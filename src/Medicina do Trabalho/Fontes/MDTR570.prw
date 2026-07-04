/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr570.ch"
#INCLUDE "MSOLE.CH"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR570  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Laudo Tecnico Pericial                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR570()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  	  	  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aNGBEGINPRM := NGBEGINPRM( ),cQRYA,nTOTTJ0,nWPROC,cTN0SIM, nI

	PRIVATE cPerg := "MDT570    "
	PRIVATE aTN0Combo := MDTCbox("TN0_INDEXP"," ",1)
	Private lMdtUmCC  := lMDT190UMCC()
	Private nSizeSI3  := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private cAliasCC := "SI3"

	Private lMdtUnix := If( GetRemoteType() == 2 .Or. isSRVunix() , .T. , .F. ) //Verifica se servidor ou estacao é Linux

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCC := "CTT"
	EndIf

	If !MDT210UPD()//Verifica Aplicacao de Update
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )
	cCliMdtps := ""

	nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	nSizeTD := nTa1+nTa1L

	If lSigaMdtps
		/* Perguntas
		MDT555    ¦01      ¦Cliente ?
		MDT555    ¦02      ¦Loja

		MDT570    ¦03      ¦Laudo ?
		MDT570    ¦04      ¦Funcionario ?
		MDT570    ¦05      ¦Impressao ?
		MDT570    ¦06      ¦Arquivo Saida ?
		MDT570    ¦07      ¦Centro de Custo?   * Opcional
		*/

		cPerg    :=  "MDT570PS  "

		If Pergunte(cPerg,.T.) .And. ExCpoMDT('SRA',Mv_par04) .And. ExistCpo('TO0',mv_par01+mv_par02+Mv_par03,6)
			RptStatus({|lEnd| U_FIMP570()})
		EndIf

	Else
		/* Perguntas
		MDT570    ¦01      ¦Laudo ?
		MDT570    ¦02      ¦Funcionario ?
		MDT570    ¦03      ¦Impressao ?
		MDT570    ¦04      ¦Arquivo Saida ?
		MDT570    ¦05      ¦Centro de Custo?   * Opcional
		*/

		///If Pergunte(cPerg,.T.) .And. ExCpoMDT('SRA',Mv_par02) .And.
		If Pergunte(cPerg,.T.) .And. ExistCpo('TO0',Mv_par01) .And. U_MDT570ALL("FUNCIONARIO")
			If Empty(MV_PAR02)

				aMatriculas := {}

				DbSelectArea("TJ0")
				TJ0->(DBSETORDER(1))
				IF TJ0->(DBSEEK(XFILIAL("TJ0")+PADR(MV_PAR01,TAMSX3("TJ0_LAUDO")[1])))
					While TJ0->(!Eof()) .And. TJ0->TJ0_FILIAL == xFilial("TJ0") .And. TJ0->TJ0_LAUDO == MV_PAR01

						IF TJ0->TJ0_CONFEX == "1"
							AADD(aMatriculas,TJ0->TJ0_MAT)
						EndIf
						TJ0->(DbSkip())

					Enddo
				EndIf

				nTOTTJ0 := Len(aMatriculas)

				If nTOTTJ0 > 0

					MSGINFO(STR0063+ALLTRIM(STR(nTOTTJ0))+STR0064,STR0051) //"Sera(o) impresso(s) " ## " Laudo(s). A cada documento gerado, salve o mesmo antes de continuar !" ## "Atencao"

					cTN0SIM := ""
					nWPROC  := 0

					For nI := 1 to nTOTTJ0
						MV_PAR02 := aMatriculas[nI]
						nWPROC++
						RptStatus({|lEnd| U_FIMP570()},STR0065+ALLTRIM(STR(nWPROC)+STR0066+ALLTRIM(STR(nTOTTJ0))))  //"Processando: " ## " de "

					Next nI
				Else
					MsgInfo( STR0068 )			 //"Não existem funcionário com a confirmação de exposição ao risco."
				EndIf
			Else

				RptStatus({|lEnd| U_FIMP570()},STR0065)  //"Processando: "

			EndIf

		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FIMP570  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do relatorio                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FIMP570()

	Local cMemo := " ",cTitulo := " ",cTexto := " "
	Local lEof := .T.
	Local strDia,strMes,strAno

	Local cArqDot  := "ltpericial.dot"							// Nome do arquivo modelo do Word (Tem que ser .dot)
	Local cPathDot := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo modelo do Word
	Local cBarraRem := "\"
	Local cBarraSrv := "\"

	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()
	Local lImp := .F.
	Local aTabT3Reg := {}

	If GetRemoteType() == 2  //estacao com sistema operacional unix
		cBarraRem := "/"
	EndIf
	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	Private cPathEst := Alltrim(GetMv("MV_DIREST")) 			// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ
	Private cArqBmp  := "LGRL"+cSMCOD+cSMFIL+".BMP"  // Nome do arquivo logo do cliente
	Private cArqBmp2 := "LGRL"+cSMCOD+".BMP"         // Nome do arquivo logo do cliente
	Private cPathBmp := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo logo .bmp do cliente
	Private cPathBm2 := cPathBmp

	If lSigaMdtPS
		cArqBmp  := "LGRL"+Mv_par01+mv_par02+".bmp"              // Nome do arquivo logo do cliente
		cArqBmp2 := "LGRL"+Mv_par01+".bmp" // Nome do arquivo logo do cliente
	EndIf

	cPathDot += If(Substr(cPathDot,len(cPathDot),1) != cBarraSrv,cBarraSrv,"") + cArqDot
	cPathEst += If(Substr(cPathEst,len(cPathEst),1) != cBarraRem,cBarraRem,"")

	cPathBmp += If(Substr(cPathBmp,len(cPathBmp),1) != cBarraSrv,cBarraSrv,"") + cArqBmp
	cPathBm2 += If(Substr(cPathBm2,len(cPathBm2),1) != cBarraSrv,cBarraSrv,"") + cArqBmp2

	//Cria diretorio se nao existir
	MontaDir(cPathEst)

	//Se existir .dot na estacao, apaga!
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	If !File(cPathDot)
		MsgStop(STR0052+chr(10)+STR0053,STR0051) // "O arquivo ltpericial.dot não foi encontrado no servidor."###"Verificar parâmetro 'MV_DIRACA'."###"ATENÇÃO"
		Return
	EndIf
	CpyS2T(cPathDot,cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario
	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP

	//Se existir .bmp na estacao, apaga!
	If File(cPathBmp)
		If File( cPathEst + cArqBmp )
			Ferase( cPathEst + cArqBmp )
		EndIf
		__copyfile(cPathBmp,cPathEst+cArqBmp)
	ElseIf File(cPathBm2)
		If File( cPathEst + cArqBmp2 )
			Ferase( cPathEst + cArqBmp2 )
		EndIf
		__copyfile(cPathBm2,cPathEst+cArqBmp2)
		cArqBmp := cArqBmp2
	EndIf

	Private cVar := "cVAR",nVar := 1
	Private cVar1 := "cTIT",nVar1 := 1
	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lPrint := .T.
	Private lPrin2 := .T.
	Private lIdentar := .F.
	Private aFuncoes := {}
	aStrMes := {STR0001,STR0002,STR0003,STR0004,STR0005,STR0006,STR0007,STR0008,STR0009,STR0010,STR0011,STR0012} //"Janeiro"###"Fevereiro"###"Março"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	Dbselectarea("SRA")
	Dbsetorder(1)
	Dbseek(xFilial("SRA")+Mv_par02)

	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)

	Dbselectarea(cAlias) 	//SI3 ou CTT
	Dbsetorder(1)
	Dbseek(xFilial(cAlias)+SRA->RA_CC)

	Dbselectarea("TO0")
	Dbsetorder(1)
	If Dbseek(xFilial("TO0")+Mv_par01)
		lImp := .T.
		lImpress	:= If(mv_par03 == 1,.T.,.F.)	//Verifica se a saida sera em Tela ou Impressora
		cArqSaida	:= If(Empty(mv_par04),"Documento1",AllTrim(mv_par04))	// Nome do arquivo de saida

		oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

		If lImpress //Impressao via Impressora
			OLE_SetProperty(oWord,oleWdVisible,  .F.)
			OLE_SetProperty(oWord,oleWdPrintBack,.T.)
		Else //Impressao na Tela(Arquivo)
			OLE_SetProperty(oWord,oleWdVisible,  .F.)
			OLE_SetProperty(oWord,oleWdPrintBack,.F.)
		EndIf
		cType := "ltpericial| *.dot"
		OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

		//Imprime Logo
		cFileLogo := cPathEst + cArqBmp

		If !lMdtUnix //Se for windows
			If File(cFileLogo)
				OLE_SetDocumentVar(oWord,"Cria_Var",cFileLogo)
				OLE_ExecuteMacro(oWord,"Insere_logo")
			EndIf
		EndIf

		cCid := Alltrim(SM0->M0_CIDCOB)
		cCidade   := Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
		cEmp_Nome := SM0->M0_NOMECOM
		cEmp_Cnpj := SM0->M0_CGC
		cEmp_Endr := Substr(SM0->M0_ENDCOB,1,40)
		cEmp_Insc := SM0->M0_INSC
		cEmp_ramo := " "
		cEmp_grau := TO0->TO0_GRISCO
		cEmp_cnae := SM0->M0_CNAE

		dbSelectArea("SA1")
		dbSetOrder(1)
		If dbSeek(xFilial("SA1")+TO0->TO0_CLIENT)

			aTabT3Reg := FWGetSX5( "T3", SA1->A1_SATIV1 )

			If Len(aTabT3Reg) > 0
				cCidade   := Alltrim(SA1->A1_MUN)+If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
				cEmp_Nome := SA1->A1_NOME
				cEmp_Cnpj := SA1->A1_CGC
				cEmp_Endr := Substr(SA1->A1_END,1,40)
				cEmp_Insc := SA1->A1_INSCR
				cEmp_ramo := Substr(Upper(aTabT3Reg[ 1, 4 ]),1,40)
				cEmp_cnae := SA1->A1_ATIVIDA
			EndIf

		EndIf

		DbSelectArea("SRJ")
		DBSetOrder(1)
		DbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
		cCBO  := SRJ->RJ_CBO
		If !Empty(SRJ->RJ_CODCBO)
			cCBO := SRJ->RJ_CODCBO
		EndIf

		//Dados Empresa
		OLE_SetDocumentVar(oWord,"Emp_Nome",cEmp_Nome)
		OLE_SetDocumentVar(oWord,"Emp_Local",cEmp_Endr)
		OLE_SetDocumentVar(oWord,"Emp_cnpj",Transform(cEmp_Cnpj,"@!R NN.NNN.NNN/NNNN-99"))
		OLE_SetDocumentVar(oWord,"Emp_ie",cEmp_Insc)
		OLE_SetDocumentVar(oWord,"Emp_cidade",cCidade)
		OLE_SetDocumentVar(oWord,"Emp_ramo",cEmp_ramo)
		OLE_SetDocumentVar(oWord,"Emp_cnae",cEmp_cnae)
		OLE_SetDocumentVar(oWord,"Emp_grau",cEmp_grau)
		If lMdtUmCC
			Dbselectarea(cAlias)
			Dbsetorder(1)
			If Dbseek(xFilial(cAlias)+Mv_par05) .And. !Empty(Mv_par05)
				OLE_SetDocumentVar(oWord,"CapaCC",&(cDescr))
			EndIf
		EndIf

		//Dados Funcionario
		OLE_SetDocumentVar(oWord,"Fun_Nome",SRA->RA_NOME)
		OLE_SetDocumentVar(oWord,"Fun_mat",SRA->RA_MAT)
		OLE_SetDocumentVar(oWord,"Fun_pis",SRA->RA_PIS)
		OLE_SetDocumentVar(oWord,"Fun_ctps",SRA->RA_NUMCP+" / "+SRA->RA_SERCP)
		OLE_SetDocumentVar(oWord,"Fun_cbo",Alltrim(SRJ->RJ_DESC)+" ")
		OLE_SetDocumentVar(oWord,"Fun_codcbo",cCBO)

		OLE_SetDocumentVar(oWord,"Fun_Custo",Alltrim(&cDescr)+" ")	//SI3 ou CTT
		OLE_SetDocumentVar(oWord,"Fun_Admissao",SRA->RA_ADMISSA)
		OLE_SetDocumentVar(oWord,"Fun_Demissao",If(Empty(SRA->RA_DEMISSA),STR0015,SRA->RA_DEMISSA)) //"EM ATIVIDADE"

		//Objetivo do Laudo
		OLE_SetDocumentVar(oWord,"Lau_Obje",Alltrim(TO0->TO0_OBJETI)+" ")

		OLE_ExecuteMacro(oWord,"Somalinha")

		cMemo := Alltrim(TO0->TO0_DESCRI)
			If !Empty(TO0->TO0_MMSYP2)

				cMMSYP2 := NgMemo( TO0->TO0_MMSYP2, .T. )

				If !Empty(cMMSYP2)
					If !Empty(cMemo)
						cMemo += Chr(13)+Chr(10)
					EndIf
					cMemo += cMMSYP2
				EndIf
			EndIf
		SetRegua(100)
		nLenMemo := Len(cMemo)
		nPerMemo := 0
		While lEof
			OLE_ExecuteMacro(oWord,"Atualiza")

			If Empty(cMemo)  //Memo vazio
				lEof := .F.
				Exit
			Else
				nPos1 := At("#",cMemo) //Inicio de um Titulo
				fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
				If nPos1 > 1
					cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
					cMemo  := Alltrim(Substr(cMemo,nPos1))
					U_IMPTXT570(Alltrim(cTexto))
					Loop
				ElseIf nPos1 == 1 //Existe #
					cMemo   := Alltrim(Substr(cMemo,nPos1+1))
					nPos1   := At("#",cMemo)
					cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
					cMemo   := Alltrim(Substr(cMemo,nPos1+1))

					nPos1   := At("#",cMemo)
					If nPos1 > 0
						cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo  := Alltrim(Substr(cMemo,nPos1))
					Else
						cTexto := Alltrim(cMemo)
						cMemo  := " "
						lEof   := .F.
					EndIf
				Else //Nao existe #
					//IMPRIME TEXTO
					U_IMPTXT570(Alltrim(cMemo))
					lEof := .F.
					Exit
				EndIf


				//IMPRIME TITULO
				If !Empty(cTitulo)
					U_IMPCAB570(cTitulo)
				EndIf

				//IMPRIME TEXTO
				If !Empty(cTexto)
					lPrint := .T.
					lPrin2 := .T.
					U_IMPTXT570(Alltrim(cTexto))
				EndIf

			EndIf
			fReguaPPRA( nLenMemo, @nPerMemo, Len(cMemo) ) //Incrementa Regua
		End

		Dbselectarea("TMK")
		Dbsetorder(1)
		Dbseek(xFilial("TMK")+TO0->TO0_CODUSU)

		strDia := Alltrim(Str(Day(Date())))
		strMes := aStrMes[Month(Date())]
		strAno := Alltrim(Str(Year(Date())))
		cCid += ", "+strDia+STR0054+strMes+STR0054+strAno
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		U_IMPCAB570("{CN}"+STR0016,.T.) //"SIGNATÁRIO DO LAUDO"
		OLE_ExecuteMacro(oWord,"Somalinha")
		U_IMPCAB570(cCid,.T.)
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")

		U_IMPCAB570("{N}"+"___________________________________",.T.)
		OLE_ExecuteMacro(oWord,"Table_Vinculo")

		U_IMPCAB570("{}"+Alltrim(TMK->TMK_NOMUSU),.T.)

		cTipResp := Tabela("P1",TMK->TMK_INDFUN,.F.)

		U_IMPCAB570("{}"+cTipResp,.T.)
		U_IMPCAB570("{}"+Alltrim(TMK->TMK_ENTCLA)+": "+Alltrim(TMK->TMK_NUMENT),.T.)

		OLE_SetDocumentVar(oWord,"Tabela",Space(1))   //Limpa campo oculto do documento
		OLE_SetDocumentVar(oWord,"Linhas",Space(1))   //Limpa campo oculto do documento
		OLE_SetDocumentVar(oWord,"Cria_Var",Space(1)) //Limpa campo oculto do documento
		OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
		OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

		IF lImpress //Impressao via Impressora
			OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
		Else //Impressao na Tela(Arquivo)
			OLE_SetProperty(oWord,oleWdVisible,.T.)
			OLE_ExecuteMacro(oWord,"Maximiza_Tela")
			If !lMdtUnix
				If U_DIRR570(cPathEst)
					OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.F.,oleWdFormatDocument)
				EndIf
			EndIf
			MsgInfo(STR0013) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
		EndIf
		OLE_CloseFile(oWord) //Fecha o documento
		OLE_CloseLink(oWord) //Fecha o documento
	EndIf

	If !lImp
		MsgStop(STR0055, STR0056)//"Não existem dados para imprimr."##"Atenção"
	EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DIRR570  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se o diretorio existe.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DIRR570(cCaminho)

	Local lDir := .F.
	Local cBARRAS   := If(isSRVunix(),"/","\")
	Local cBARRAD := If(isSRVunix(),"//","\\")

	If !empty(cCaminho) .And. !(cBARRAD$cCaminho)
		cCaminho := alltrim(cCaminho)
		If Right(cCaminho,1) == cBARRAS
			cCaminho := SubStr(cCaminho,1,len(cCaminho)-1)
		EndIf
		lDir :=(Ascan( Directory(cCaminho,"D"),{|_Vet | "D" $ _Vet[5] } ) > 0)
	EndIf

Return lDir

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³IMPTXT570 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME O CONTEUDO DO TEXTO                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IMPTXT570(_cTexto)

	Local lTexto := .T.
	Local nPosTxt := 0
	Local cTitExe
	Local cTextoNew := _cTexto
	Local cTxtMemo := _cTexto
	Local nArroba
	//Imprime texto

	While lTexto
		nArroba := At("@",cTxtMemo)

		If nArroba > 1
			cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
			U_IMPTXT570(Alltrim(cTextoNew))
			Loop
		ElseIf nArroba == 1 //Existe @
			cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
			nArroba  := At("@",cTxtMemo)
			cTitExe  := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			U_EXEC570TIT(cTitExe)
			cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))

			nArroba   := At("@",cTxtMemo)
			If nArroba > 0
				cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
				cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))
				U_IMPTXT570(Alltrim(cTextoNew))
				Loop
			EndIf
		EndIf

		If (nPosTxt := At(Chr(13)+Chr(10),cTxtMemo)) == 0
			lTexto := .F.
			cTextoNew :=  Alltrim(cTxtMemo)
		Else
			cTextoNew :=  Alltrim(Substr(cTxtMemo,1,nPosTxt-1))
			cTxtMemo  :=  Alltrim(Substr(cTxtMemo,nPosTxt+2))
		EndIf

		If !Empty(cTextoNew)
			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++

			If lPrint
				OLE_ExecuteMacro(oWord,"Somalinha")
				lPrint := .F.
			EndIf
			If lPrin2
				OLE_ExecuteMacro(oWord,"Somalinha")
			EndIf
			lPrin2 := .T.

			OLE_ExecuteMacro(oWord,"Cria_Texto")
			If lIdentar
				OLE_ExecuteMacro(oWord,"Identar")
			EndIf
			OLE_ExecuteMacro(oWord,"Sem_Negrito")
			OLE_SetDocumentVar(oWord,cVar1,cTextoNew)

		EndIf
	End

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPCAB570³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME O TITULO DO TEXTO                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IMPCAB570(_cTit,lJump)

	Local nPosTemp
	Local _cTitulo := _cTit
	Local cCNS := " "

	cVar := "cTIT"+Strzero(nVar,3)
	nVar++
	OLE_SetDocumentVar(oWord,"Cria_Var",cVar)
	If !lJump
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Cria_Titulo")

	If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
		nPosTemp := At("}",_cTitulo)
		cCNS     := Substr(_cTitulo,1,nPosTemp)
		_cTitulo := Substr(_cTitulo,nPosTemp+1)
	EndIf

	If ("N" $ Upper(cCNS)) //N=Negrito
		OLE_ExecuteMacro(oWord,"Com_Negrito")
	Else
		OLE_ExecuteMacro(oWord,"Sem_Negrito")
	EndIf

	If ("C" $ Upper(cCNS)) //C=Centralizar
		OLE_ExecuteMacro(oWord,"Centralizar")
	Else
		OLE_ExecuteMacro(oWord,"Justificar")
	EndIf

	If ("S" $ Upper(cCNS)) //S=Sublinhar
		OLE_ExecuteMacro(oWord,"Com_Sublinhar")
	Else
		OLE_ExecuteMacro(oWord,"Sem_Sublinhar")
	EndIf

	OLE_SetDocumentVar(oWord,cVar,_cTitulo+" ")

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³EXEC570TIT³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME A TABELA RELACIONADA AO TITULO                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function EXEC570TIT(_cTitExe)

	Local cTitExe := _cTitExe, nTipo := 1, cTitTemp, nPos1

	cTitTemp := _cTitExe
	nPos1    := At("!",cTitTemp)
	If nPos1 > 0
		cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
		nPos1    := At("!",cTitTemp)
		If nPos1 > 0
			cTitTemp := Substr(cTitTemp,1,nPos1-1)
			nTipo := 2
		EndIf
	EndIf

	If nTipo == 1
		cTitTemp := _cTitExe
		nPos1    := At("%",cTitTemp)
		If nPos1 > 0
			cTitTemp := Alltrim(Substr(cTitTemp,nPos1+1))
			nPos1    := At("%",cTitTemp)
			If nPos1 > 0
				cTitTemp := Substr(cTitTemp,1,nPos1-1)
				nTipo := 3
			EndIf
		EndIf
	EndIf

	Begin Sequence
		If ExistBlock("MDTR8501") //Ponto de Entrada para executar atalhos customizados
			aRetPE := ExecBlock('MDTR8501',.F.,.F., {'3', 1, cTitExe})
			If ValType(aRetPE) == "A"
				nPosPE := aScan(aRetPE, {|x| Alltrim(x[1]) == Alltrim(cTitExe) .And. Alltrim(cTitExe) == Alltrim(x[1]) })
				If nPosPE > 0
					&(aRetPE[nPosPE,2])
					Break
				EndIf
			EndIf
		EndIf

		If nTipo == 2
			A570IMAGEM(cTitTemp)
		ElseIf nTipo == 3
			A570ARQUIVO(cTitTemp)
		ElseIf "LOCAIS" $ Upper(cTitExe) .Or. "LOCAL" $ Upper(cTitExe)
			U_A570LOCAL()
		ElseIf "RISCO" $ Upper(cTitExe)
			U_A570RISCO()
		ElseIf "EQUIPAMENTO" $ Upper(cTitExe)
			U_A570EQUIP()
		ElseIf "CONTROLE" $ Upper(cTitExe)
			U_A570CONTR()
		ElseIf "TAREFA" $ Upper(cTitExe)
			U_A570TAREF()
		ElseIf "FUNCOES" $ Upper(cTitExe) .Or. "FUNÇÕES" $ Upper(cTitExe)
			U_A570FUNC1()
		ElseIf "QUADRO FUNCIONARIOS" $ Upper(cTitExe)
			U_A570QUADFUN()
		ElseIf "HISTORICO" $ Upper(cTitExe) .Or. "HISTÓRICO" $ Upper(cTitExe)
			U_A570FUNC2()
		ElseIf "EPI" $ Upper(cTitExe)
			U_A570EPIS()
		ElseIf "PAGINA"	$ Upper(cTitExe)
			OLE_ExecuteMacro(oWord,"NewPage")
		EndIf
	End Sequence

Return .T.

/*/
Fun‡…o    A570LOCAL ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME OS LOCAIS DO LAUDO
/*/
User Function A570LOCAL()

	Dbselectarea("TO5")
	Dbsetorder(01)
	Dbseek(xFilial("TO5")+TO0->TO0_LAUDO)
	While !eof() .And. xFilial("TO5")+TO0->TO0_LAUDO == TO5->TO5_FILIAL+TO5->TO5_LAUDO
		Dbselectarea("TNE")
		Dbsetorder(1)
		If Dbseek(xFilial("TNE")+TO5->TO5_CODAMB)
			lPrint := .T.
			U_IMPCAB570(Alltrim(TNE->TNE_NOME))
			U_IMPTXT570(Alltrim(TO5->TO5_DESCRI))
			U_IMPTXT570(Alltrim(TNE->TNE_DESAMB)+" ")
			If !Empty(TNE->TNE_DESAM1)
				U_IMPTXT570(Alltrim(TNE->TNE_DESAM1))
			EndIf
			If !Empty(TNE->TNE_DESAM2)
				U_IMPTXT570(Alltrim(TNE->TNE_DESAM2))
			EndIf
			If !Empty(TNE->TNE_DESAM3)
				U_IMPTXT570(Alltrim(TNE->TNE_DESAM3))
			EndIf
			If !Empty(TNE->TNE_DESAM4)
				U_IMPTXT570(Alltrim(TNE->TNE_DESAM4))
			EndIf
		EndIf
		Dbselectarea("TO5")
		Dbskip()
	End

Return .T.

/*/
Fun‡…o    A570RISCO ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME OS RISCOS DO LAUDO
/*/
User Function A570RISCO()

	Local cIndExp := " "
	Local CComExp := " "
	Local lNR32		 := If(SuperGetMv("MV_NG2NR32",.F.,"2") == "2", .F., .T.)
	Local lTN0Depto  := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
	Local lImpNaoExp := !Empty( Mv_par06 ) .And. Mv_par06 != 3

	Dbselectarea("TO1")
	Dbsetorder(01)
	Dbseek(xFilial("TO1")+TO0->TO0_LAUDO)
	While !eof() .And. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO
		Dbselectarea("TN0")
		Dbsetorder(1)
		If Dbseek(xFilial("TN0")+TO1->TO1_NUMRIS)
			Dbselectarea("TMA")
			Dbsetorder(1)
			If Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
				Dbselectarea("TN7")
				Dbsetorder(1)
				Dbseek(xFilial("TN7")+TN0->TN0_FONTE)
				Dbselectarea(cAlias)
				Dbsetorder(1)
				Dbseek(xFilial(cAlias)+TN0->TN0_CC)
				Dbselectarea("SRJ")
				Dbsetorder(1)
				Dbseek(xFilial("SRJ")+TN0->TN0_CODFUN)
				Dbselectarea("TN5")
				Dbsetorder(1)
				Dbseek(xFilial("TN5")+TN0->TN0_CODTAR)
				Dbselectarea("TNE")
				Dbsetorder(1)
				Dbseek(xFilial("TNE")+TN0->TN0_CODAMB)
				Dbselectarea("TJF")
				Dbsetorder(1)
				Dbseek(xFilial("TJF")+TN0->TN0_NUMRIS)
				If lTN0Depto
					dbSelectArea("SQB")
					dbSetOrder(1)
					dbSeek( xFilial( "SQB" ) + TN0->TN0_DEPTO )
				EndIf
				lPrin2 := .F.
				lPrint := .F.

				//Soma valor para impressão

				nQtdCol := 9

				cInfImp := "{N}" + STR0025 + "#* " + TMA->TMA_NOMAGE + "#*"
				cInfImp += "{N}" + STR0026 + "#* " + TN7->TN7_NOMFON + "#*"
				cInfImp += "{N}" + STR0027 + "#* " + If(Alltrim(TN0->TN0_CC)=="*",STR0028,Alltrim(&cDescr)) + "#*"
				If Alltrim(TN0->TN0_CODFUN) != "*"
					nQtdCol++
					cInfImp += "{N}" + STR0029 + "#* " + Alltrim(SRJ->RJ_DESC) + "#*"
				EndIf
				If Alltrim(TN0->TN0_CODTAR) != "*"
					nQtdCol++
					cInfImp += "{N}" + STR0030 + "#* " + Alltrim(TN5->TN5_NOMTAR) + "#*"
				EndIf
				If lTN0Depto .And. Alltrim(TN0->TN0_DEPTO) != "*"
					nQtdCol++
					cInfImp += "{N}" + "Departamento:" + "#* " + Alltrim(SQB->QB_DESCRIC) + "#*"
				EndIf
				cInfImp += "{N}" + If(lNR32,STR0060+":",STR0031+":") + "#* " + Alltrim(TNE->TNE_NOME) + "#*"
				cInfImp += "{N}" + STR0032 + "#* " + DtoC(TN0->TN0_DTAVAL) + "#*"
				cInfImp += "{N}" + STR0033 + "#* " + Alltrim(Str(TN0->TN0_QTAGEN)+" "+TN0->TN0_UNIMED) + "#*"
				If TMA->(FieldPos("TMA_LIMTOL")) > 0
					nQtdCol++
					cInfImp += "{N}" + STR0034 + "#* " + Alltrim(Str(TMA->TMA_LIMTOL)+" "+TMA->TMA_UNIMED) + "#*"
				EndIf
				cInfImp += "{N}" + STR0035 + "#* " + TN0->TN0_QTEXPO + "#*"
				If TN0->(FieldPos("TN0_INDEXP")) > 0
					nQtdCol++
					If (nIND := aScan(aTN0Combo,{|x| Upper(Substr(x,1,1)) == Substr(TN0->TN0_INDEXP,1,1)})) > 0
						cIndExp := UPPER(Substr(aTN0Combo[nIND],3))
					EndIf
					cInfImp += "{N}" + STR0039 + "#* " + AllTrim(cIndExp) + "#*"
				EndIf
				If NGCADICBASE("TN0_COMEXP","A","TN0",.F.)
					nQtdCol++
					cInfImp += "{N}" + STR0061+ ":" + "#* " +  Alltrim(TN0->TN0_COMEXP) + "#*"
				EndIf
				//Medida de Controle
				If lNR32 .And. AliasInDic("TJF")
					fImpMedCon(TN0->TN0_NUMRIS,@cInfImp,@nQtdCol)
				EndIf
				cInfImp += "{N}" + STR0040 + "#* " + TN0->TN0_TECUTI + "#*"
				cInfImp += "{N}" + STR0041 + "#* " + "{J}" + Alltrim(TO1->TO1_RECOME) + "#*"

				//Executa macro da impressão
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_SetDocumentVar(oWord,"Tabela",cInfImp)
				OLE_SetDocumentVar(oWord,"Linhas",nQtdCol)
				OLE_ExecuteMacro(oWord,"ImpRiscoLaudo")
				OLE_ExecuteMacro(oWord,"Somalinha")

				If lImpNaoExp
					A570NAOEXP()
				EndIf

			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

Return .T.

/*/
Fun‡…o    A570EQUIP ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME OS EQUIPAMENTOS DO LAUDO
/*/
User Function A570EQUIP()

	Local cMemo := ""
	Local nRegs := 0

	Dbselectarea("TO2")
	Dbsetorder(01)
	Dbseek(xFilial("TO2")+TO0->TO0_LAUDO)
	While !eof() .And. xFilial("TO2")+TO0->TO0_LAUDO == TO2->TO2_FILIAL+TO2->TO2_LAUDO
		Dbselectarea("TM7")
		Dbsetorder(1)
		If Dbseek(xFilial("TM7")+TO2->TO2_EQPTO)
			nRegs++
			cMemo += Substr(Alltrim(TM7->TM7_NOEQTO),1,30)+"#*"
			cMemo += Substr(Alltrim(TM7->TM7_NOMFAB),1,25)+"#*"
			cMemo += If(!Empty(TM7->TM7_DTCALI),DTOC(TM7->TM7_DTCALI),"__/__/__")+"#*"
			cMemo += DTOC(TM7->TM7_DTAFER)+"#*"
		EndIf
		Dbselectarea("TO2")
		Dbskip()
	End
	If nRegs > 0
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Equipamentos")
	EndIf

Return .T.

/*/
Fun‡…o    A570CONTR ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME AS MEDIDAS DE CONTROLE DO LAUDO
/*/
User Function A570CONTR()

	Dbselectarea("TO3")
	Dbsetorder(01)
	Dbseek(xFilial("TO3")+TO0->TO0_LAUDO)
	While !eof() .And. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO
		Dbselectarea("TO4")
		Dbsetorder(1)
		If Dbseek(xFilial("TO4")+TO3->TO3_CONTRO)
			lPrint := .T.
			U_IMPCAB570(Alltrim(TO4->TO4_NOMCTR))
			U_IMPTXT570(Alltrim(TO3->TO3_DESCRI))
		EndIf
		Dbselectarea("TO3")
		Dbskip()
	End

Return .T.

/*/
Fun‡…o    A570QUADFUN³ Autor ³Liber Ee Esteban ³ Data ³ 17.05.05
Descri‡…o IMPRIME LISTAGEM DO NUMERO DE FUNCIONARIOS MASCULINO, FEMININO E MENORE
/*/
User Function A570QUADFUN()

	Local aArea  := GetArea()
	Local cMemo  := ""
	Local nMasc  := 0
	Local nFemi  := 0
	Local nMenor := 0

	Dbselectarea("SRA")
	Dbsetorder(01)
	Dbseek(xFilial("SRA"))
	While !eof() .And. xFilial("SRA") == SRA->RA_FILIAL

		If SRA->RA_SITFOLH == "D" .Or. !Empty(SRA->RA_DEMISSA)
			Dbskip()
			Loop
		End

		nIdade := Year(Date()) - Year(SRA->RA_NASC)
		If Month(Date()) < Month(SRA->RA_NASC)
			nIdade := nIdade - 1
		Elseif Month(Date()) == Month(SRA->RA_NASC)
			If Day(Date()) < Day(SRA->RA_NASC)
				nIdade := nIdade - 1
			EndIf
		EndIf

		If nIdade < 18
			nMenor++
		Else
			If SRA->RA_SEXO == "M"
				nMasc++
			Else
				nFemi++
			EndIf
		EndIf

		Dbselectarea("SRA")
		Dbskip()
	End

	cMemo:=STR(nMasc,5) + "#*"
	cMemo+=STR(nFemi,5) + "#*"
	cMemo+=STR(nMenor,5) + "#*"
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Tabela",cMemo)
	OLE_ExecuteMacro(oWord,"Quadro_Funcionario")
	OLE_ExecuteMacro(oWord,"Somalinha")

	RestArea(aArea)

Return .T.

/*/
Fun‡…o    A570FUNC1 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME AS FUNCOES DO FUNCIONARIO
/*/
User Function A570FUNC1()

	Local nCont, cMemo,lDois := .T.
	Local aCargos := {}

	If lSigaMdtps

		Dbselectarea("SR7")
		Dbsetorder(1)
		Dbseek(SRA->RA_FILIAL+Mv_par04+DTOS(SRA->RA_ADMISSA))
		While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par04

			If aScan(aFuncoes,{|x| x[1] == SR7->R7_FUNCAO}) == 0
				aAdd(aFuncoes,{SR7->R7_FUNCAO})
			EndIf

			Dbselectarea("SR7")
			Dbskip()
		End

	Else

		Dbselectarea("SR7")
		Dbsetorder(1)
		Dbseek(SRA->RA_FILIAL+Mv_par02+DTOS(SRA->RA_ADMISSA))
		While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par02

			If aScan(aFuncoes,{|x| x[1] == SR7->R7_FUNCAO}) == 0
				aAdd(aFuncoes,{SR7->R7_FUNCAO})
			EndIf

			Dbselectarea("SR7")
			Dbskip()
		End

	EndIf

	If Len(aFuncoes) == 0
		aAdd(aFuncoes,{SRA->RA_CODFUNC})
	EndIf

	For nCont := 1 to Len(aFuncoes)
		Dbselectarea("SRJ")
		Dbsetorder(1)
		If Dbseek(xFilial("SRJ")+aFuncoes[nCont][1])
			Dbselectarea("SQ3")
			Dbsetorder(1)
			If Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)
				If aScan(aCargos,{|x| x[1] == SRJ->RJ_CARGO}) == 0
					aAdd(aCargos,{SRJ->RJ_CARGO})
					cMemo := MSMM(SQ3->Q3_DESCDET)
					If !Empty(cMemo)
						lPrint := .T.
						U_IMPCAB570(Alltrim(SQ3->Q3_DESCSUM))
						U_IMPTXT570(Alltrim(cMemo))
					EndIf
				EndIf
			EndIf

		EndIf
	Next nCont

Return .T.

/*/
Fun‡…o    A570CARGO ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME O CARGO ATUAL DO FUNCIONARIO
/*/
User Function A570CARGO()

	Local cMemo

	Dbselectarea("SRJ")
	Dbsetorder(1)
	Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)
	Dbselectarea("SQ3")
	Dbsetorder(1)
	If Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)
		cMemo := MSMM(SQ3->Q3_DESCDET)
		If !Empty(cMemo)
			lPrint := .T.
			U_IMPCAB570(Alltrim(SQ3->Q3_DESCSUM))
			U_IMPTXT570(Alltrim(cMemo))
		EndIf
	EndIf

Return .T.

/*/
Fun‡…o    A570TAREF ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME AS TAREFAS EXECUTADAS DO FUNCIONARIO
/*/
User Function A570TAREF()

	Local cMemo := ""
	Local nRegs := 0

	If lSigaMdtps

		Dbselectarea("TN6")
		Dbsetorder(2)
		Dbseek(xFilial("TN6")+Mv_par04)

		While !eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. Mv_par04 == TN6->TN6_MAT
			Dbselectarea("TN5")
			Dbsetorder(1)
			If Dbseek(xFilial("TN5")+TN6->TN6_CODTAR)
				nRegs++
				cMemo += Substr(Alltrim(TN5->TN5_NOMTAR),1,40)+"#*"
				cMemo += DTOC(TN6->TN6_DTINIC)+"#*"
				cMemo += If(!Empty(TN6->TN6_DTTERM),DTOC(TN6->TN6_DTTERM),"__/__/__")+"#*"
			EndIf
			Dbselectarea("TN6")
			Dbskip()
		End

	Else

		Dbselectarea("TN6")
		Dbsetorder(2)
		Dbseek(xFilial("TN6")+Mv_par02)

		While !eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. Mv_par02 == TN6->TN6_MAT
			Dbselectarea("TN5")
			Dbsetorder(1)
			If Dbseek(xFilial("TN5")+TN6->TN6_CODTAR)
				nRegs++
				cMemo += Substr(Alltrim(TN5->TN5_NOMTAR),1,40)+"#*"
				cMemo += DTOC(TN6->TN6_DTINIC)+"#*"
				cMemo += If(!Empty(TN6->TN6_DTTERM),DTOC(TN6->TN6_DTTERM),"__/__/__")+"#*"
			EndIf
			Dbselectarea("TN6")
			Dbskip()
		End

	EndIf

	If nRegs > 0
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Tarefas")
	EndIf

Return .T.

/*/
Fun‡…o    A570FUNC2 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME O HISTORICO DE FUNCOES DO FUNCIONARIO
/*/
User Function A570FUNC2()

	Local cMemo := ""
	Local nRegs := 0
	Local cFuncOld := " "
	Local nRec,dFim

	If lSigaMdtps

		Dbselectarea("SR7")
		Dbsetorder(1)
		Dbseek(SRA->RA_FILIAL+Mv_par02+DTOS(SRA->RA_ADMISSA))

		While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par04
			Dbselectarea("SR7")
			nRec := Recno()

			If cFuncOld == SR7->R7_FUNCAO
				Dbskip()
				Loop
			EndIf
			cFuncOld := SR7->R7_FUNCAO

			Dbskip()
			If !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par04
				dFim := DTOC(SR7->R7_DATA-1)
			Else
				dFim := "__/__/__"
			EndIf
			Dbgoto(nRec)

			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+SR7->R7_FUNCAO)
			Dbselectarea("SQ3")
			Dbsetorder(1)
			Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)

			nRegs++
			cMemo += DTOC(SR7->R7_DATA)+" à "+dFim+"#*"
			cMemo += Substr(Alltrim(SRJ->RJ_DESC),1,23)+"#*"
			cMemo += Substr(Alltrim(SQ3->Q3_DESCSUM),1,23)+"#*"
			cMemo += SRJ->RJ_CBO+"#*"

			Dbselectarea("SR7")
			Dbskip()
		End

	Else

		Dbselectarea("SR7")
		Dbsetorder(1)
		Dbseek(SRA->RA_FILIAL+Mv_par02+DTOS(SRA->RA_ADMISSA))

		While !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par02
			Dbselectarea("SR7")
			nRec := Recno()

			If cFuncOld == SR7->R7_FUNCAO
				Dbskip()
				Loop
			EndIf
			cFuncOld := SR7->R7_FUNCAO

			Dbskip()
			If !eof() .And. SR7->R7_FILIAL == SRA->RA_FILIAL .And. SR7->R7_MAT == Mv_par02
				dFim := DTOC(SR7->R7_DATA-1)
			Else
				dFim := "__/__/__"
			EndIf
			Dbgoto(nRec)

			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+SR7->R7_FUNCAO)
			Dbselectarea("SQ3")
			Dbsetorder(1)
			Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)

			nRegs++
			cMemo += DTOC(SR7->R7_DATA)+" à "+dFim+"#*"
			cMemo += Substr(Alltrim(SRJ->RJ_DESC),1,23)+"#*"
			cMemo += Substr(Alltrim(SQ3->Q3_DESCSUM),1,23)+"#*"
			cMemo += SRJ->RJ_CBO+"#*"

			Dbselectarea("SR7")
			Dbskip()
		End

	EndIf

	If nRegs == 0
		Dbselectarea("SRJ")
		Dbsetorder(1)
		Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)
		Dbselectarea("SQ3")
		Dbsetorder(1)
		Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)

		nRegs++
		cMemo += DTOC(SRA->RA_ADMISSA)+" à __/__/__"+"#*"
		cMemo += Substr(Alltrim(SRJ->RJ_DESC),1,23)+"#*"
		cMemo += Substr(Alltrim(SQ3->Q3_DESCSUM),1,23)+"#*"
		cMemo += SRJ->RJ_CBO+"#*"
	EndIf

	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_ExecuteMacro(oWord,"Somalinha")
	OLE_SetDocumentVar(oWord,"Tabela",cMemo)
	OLE_SetDocumentVar(oWord,"Linhas",nRegs)
	OLE_ExecuteMacro(oWord,"Table_FuncaoCargo")

Return .T.

/*/
Fun‡…o    A570EPIS  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 08.04.03
Descri‡…o IMPRIME OS EPIS RELACIONADOS A FUNCAO EXECERCIDA PELO FUNC.
/*/
User Function A570EPIS()

	Local cMemo := ""
	Local nRegs := 0

	Dbselectarea("SRA")
	Dbsetorder(1)
	Dbseek(xFilial("SRA")+mv_par02)

	Dbselectarea("TNB")
	Dbsetorder(1)
	Dbseek(xFilial("TNB")+SRA->RA_CODFUNC)

	While !eof() .And. xFilial("TNB")+SRA->RA_CODFUNC == TNB->TNB_FILIAL+TNB->TNB_CODFUN
		Dbselectarea("TN3")
		Dbsetorder(2)
		If !Dbseek(xFilial("TN3")+TNB->TNB_CODEPI)
			Dbselectarea("TNB")
			Dbskip()
			Loop
		EndIf

		Dbselectarea("SB1")
		Dbsetorder(1)
		If Dbseek(xFilial("SB1")+TNB->TNB_CODEPI)
			nRegs++
			cMemo += Alltrim(Substr(SB1->B1_DESC,1,40))+"#*"
			cMemo += Alltrim(TN3->TN3_NUMCAP)+"#*"
			cMemo += If(!Empty(TN3->TN3_DTVENC),DTOC(TN3->TN3_DTVENC),"__/__/__")+"#*"
			cMemo += +"#*"
			cMemo += Alltrim(Str(TN3->TN3_DURABI,5))+STR0042+"#*" //" dias"
		EndIf
		Dbselectarea("TNB")
		Dbskip()
	End
	If nRegs > 0
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Epis")
	EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT555CLI³ Autor ³Andre Perez Alvarez    ³ Data ³31/01/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Atualiza a variavel cCliMdtps                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT570CLI(nPar)

	Local nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	Default nPar := 1

	If ValCli(nPar,mv_par01,'mv_par02',mv_par01,'mv_par02',nTa1,nTa1L)
		cCliMdtps := mv_par01+mv_par02
	Else
		Return .F.
	EndIf

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fReguaPPRAºAutor  ³Denis               º Data ³  27/10/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Processa regua                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR572                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fReguaPPRA( nLenMemo, nPerMemo, nLenAtual )

	Local nLenOld := (100 - nPerMemo) * ( nLenMemo / 100 ) //Calcula Len anterior
	Local nDiff := nLenOld - nLenAtual
	Local nFor,nPercent

	If nDiff > 0
		//Porcentagem que processou neste Loop
		nPercent := Round( (100 / nLenMemo) * nDiff , 0 )
		//Porcentagem processada
		nPerMemo += nPercent
		If nPercent >= 1 .And. nPercent <= 100
			For nFor := 1 To nPercent
				IncRegua()
			Next nFor
		EndIf
	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A570IMAGEM³ Autor ³ Denis                 ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para inserir imagem no doc                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR850 e MDTR851                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A570IMAGEM(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	nPos := Rat(cBarraSrv,cTitTemp)
	If nPos > 0
		cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
	EndIf

	CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

	If File( cPathEst+cFileArq )
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
		OLE_ExecuteMacro(oWord,"Insere_img")
	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³A570ARQUIVO³ Autor ³ Denis                 ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao para inserir documentos no doc                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR850 e MDTR851                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A570ARQUIVO(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	nPos := Rat(cBarraSrv,cTitTemp)
	If nPos > 0
		cFileArq := AllTrim(Substr(cTitTemp,nPos+1))
	EndIf

	CpyS2T(Alltrim(cTitTemp),cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario

	If File( cPathEst+cFileArq )
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Cria_Var",cPathEst+cFileArq)
		OLE_ExecuteMacro(oWord,"Insere_doc")
	EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} fImpMedCon
	- Funcao que imprime Medidas de controle para os riscos.

@author Guilherme Benkendorf
@since 08/03/2013
@version P10/P11
/*/
//-------------------------------------------------------------------------------
Static Function fImpMedCon(cRisco,cTxtImp,nQtdCol)

	Local lTitulo := .T.
	Local nReg	  := 1
	Local cMemoMed:= ""
	Local lMed		:= .F.

	Local cSeek		:= IF(lSigaMdtPs,cCliMdtPs, "")
	Local cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_NUMRIS"
	Local cWhileTO4 := "TO4->TO4_FILIAL + TO4->TO4_CONTRO"
	Local nIndTJF 	:= 1
	Local nIndTO4 	:= 1

	If lSigaMdtPs
		cWhileTJF := "TJF->TJF_FILIAL + TJF->TJF_CLIENT + TJF->TJF_LOJA + TJF->TJF_NUMRIS"
		nIndTJF   := 2
	End

	//Procura Medidas de controle relacionado aos Riscos
	DbSelectArea("TJF")
	DbSetOrder(nIndTJF)
	DbSeek(xFilial("TJF") + cSeek + cRisco)
	While xFilial("TJF") + cSeek + cRisco == &cWhileTJF.
		DbSelectArea("TO4")
		DbSetOrder(nIndTO4)
		DbSeek(xFilial("TO4") + TJF->TJF_MEDCON)
		While xFilial("TO4") + TJF->TJF_MEDCON == &cWhileTO4.
			If lTitulo
				lTitulo := .F.

				cTxtImp += STR0057 + ":" + "#* " //"Medidas de Controle"
			Else
				cTxtImp += "; #*"
			EndIf
			cTxtImp += Alltrim(TO4->TO4_NOMCTR)

			nQtdCol++
			lMed := .T.

			DbSelectArea("TO4")
			DbSkip()
		End
		DbSelectArea("TJF")
		DbSkip()
	End
	If lMed
		cTxtImp += "#*"
	EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} MDT570ALL
Validações das Perguntas

@param cValid Caracter Indica a validação a ser executada

@sample U_MDT570ALL( "LAUDO" )

@author
@since
/*/
//-------------------------------------------------------------------------------
User Function MDT570ALL( cValid )

	Local aArea		:= GetArea()
	Local lRet			:= .T.
	Local lAdiFol		:= NGCADICBASE( "TN0_ADIFOL" , "A" , "TN0" , .F. )

	Default cValid	:= ""

	If cValid == "FUNCIONARIO"
		dbSelectArea( "TO0" )
		TO0->( dbSetOrder( 1 ) ) // TO0_FILIAL+TO0_LAUDO
		dbSeek( xFilial( "TO0" ) + Mv_par01 )
		If !Empty( MV_PAR02 )
			IF lAdiFol .And. TO0->TO0_TIPREL == "3" .And. IsInCallStack( "MDTA215" )
				MsgInfo( STR0067 , STR0051 )  //"Para laudo do tipo LT.Pericial, nao é permitido informar o funcionario. Deixe o campo em branco !" ## "Atencao"
				lRet := .F.
			ELSE
				lRet := ExCpoMDT( "SRA" , Mv_par02 )
			EndIf
		EndIf
	EndIf

	RestArea( aArea )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} A570NAOEXP
Busca e imprime as informações do atalho dos funcionarios não
expostos aos riscos do laudo

@type Function
@author Gabriel Sokacheski
@since 23/03/2021

/*/
//-------------------------------------------------------------------
Static Function A570NAOEXP()

	Local aFun := {}
	Local aRiscos := {}
	Local aFunRis := {}

	Local cFun := ''
	Local cTar := ''
	Local cDep := ''
	Local cCenCus := ''
	Local cLaudo := TO0->TO0_LAUDO
	Local cAliasRis := GetNextAlias()
	Local cAliasFun := GetNextAlias()
	Local cListaFun := ''
	Local cCenCusFil := IIf( Empty( mv_par05 ), 'NULL', mv_par05 )
	Local nTipoRel := Mv_par06

	Local dAteLaudo := IIf( !Empty( TO0->TO0_DTFIM ), TO0->TO0_DTFIM, dDatabase )

	Local nI := 0
	Local nX := 0

	BeginSQL Alias cAliasRis
		SELECT 
			TN0.TN0_NUMRIS, TMA.TMA_NOMAGE, TMA.TMA_GRISCO, TN7.TN7_NOMFON, CTT.CTT_DESC01, SRJ.RJ_DESC,
			TN5.TN5_NOMTAR, SQB.QB_DESCRIC, TNE.TNE_NOME, TN0.TN0_DTAVAL, TN0.TN0_QTAGEN, V3F.V3F_DESCRI,
			TN0.TN0_INDEXP, TN0.TN0_CC, TN0.TN0_CODFUN, TN0.TN0_CODTAR, TN0.TN0_DEPTO, TO1.TO1_RECOME
		FROM
			%table:TO0% TO0
				INNER JOIN %table:TO1% TO1 ON
					TO0.TO0_LAUDO = TO1.TO1_LAUDO
					AND %xFilial:TO1% = TO1.TO1_FILIAL
					AND TO1.%NotDel%
				INNER JOIN %table:TN0% TN0 ON
					TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
					AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
					AND %xFilial:TN0% = TN0.TN0_FILIAL
					AND TN0.TN0_MAPRIS != '1'
					AND TN0.%NotDel%
				INNER JOIN %table:TMA% TMA ON
					TN0.TN0_AGENTE = TMA.TMA_AGENTE
					AND %xFilial:TMA% = TMA.TMA_FILIAL
					AND TMA.%NotDel%
				INNER JOIN %table:TN7% TN7 ON
					TN0.TN0_FONTE = TN7.TN7_FONTE
					AND %xFilial:TN7% = TN7.TN7_FILIAL
					AND TN7.%NotDel%
				LEFT JOIN %table:CTT% CTT ON
					TN0.TN0_CC = CTT.CTT_CUSTO
					AND %xFilial:CTT% = CTT.CTT_FILIAL
					AND CTT.%NotDel%
				LEFT JOIN %table:SRJ% SRJ ON
					TN0.TN0_CODFUN = SRJ.RJ_FUNCAO
					AND %xFilial:SRJ% = SRJ.RJ_FILIAL
					AND SRJ.%NotDel%
				LEFT JOIN %table:TN5% TN5 ON
					TN0.TN0_CODTAR = TN5.TN5_CODTAR
					AND %xFilial:TN5% = TN5.TN5_FILIAL
					AND TN5.%NotDel%
				LEFT JOIN %table:SQB% SQB ON
					TN0.TN0_DEPTO = SQB.QB_DEPTO
					AND %xFilial:SQB% = SQB.QB_FILIAL
					AND SQB.%NotDel%
				LEFT JOIN %table:TNE% TNE ON
					TN0.TN0_CODAMB = TNE.TNE_CODAMB
					AND %xFilial:TNE% = TNE.TNE_FILIAL
					AND TNE.%NotDel%
				LEFT JOIN %table:V3F% V3F ON
					TN0.TN0_UNIMED = V3F.V3F_CODIGO
					AND %xFilial:V3F% = V3F.V3F_FILIAL
					AND V3F.%NotDel%
		WHERE
			TO0.TO0_FILIAL = %xFilial:TO0%
			AND TO0.TO0_LAUDO = %exp:cLaudo%
			AND TO0.TO0_TIPREL = '3'
			AND ( TN0.TN0_CC = CTT.CTT_CUSTO OR TN0.TN0_CC = '*' )
			AND ( TN0.TN0_CODFUN = SRJ.RJ_FUNCAO OR TN0.TN0_CODFUN = '*' )
			AND ( TN0.TN0_CODTAR = TN5.TN5_CODTAR OR TN0.TN0_CODTAR = '*' )
			AND ( TN0.TN0_DEPTO = SQB.QB_DEPTO OR TN0.TN0_DEPTO = '*' )
			AND TO0.%NotDel%
		ORDER BY TN0.TN0_NUMRIS
	EndSQL

	dbSelectArea( cAliasRis )
	dbGoTop()

	While !Eof()

		If aScan( aRiscos, { | x | x[ 1 ] == TN0_NUMRIS } ) == 0

			cFun := IIf( AllTrim( TN0_CODFUN ) == '*', STR0085, RJ_DESC ) // "Todas"
			cTar := IIf( AllTrim( TN0_CODTAR ) == '*', STR0085, TN5_NOMTAR ) // "Todas"
			cDep := IIf( AllTrim( TN0_DEPTO ) == '*', STR0084, QB_DESCRIC ) // "Todos"
			cCenCus := IIf( AllTrim( TN0_CC ) == '*', STR0084, CTT_DESC01 ) // "Todos"

			aAdd( aRiscos, {;
				TN0_NUMRIS,;
				TMA_NOMAGE,;
				TMA_GRISCO,;
				TN7_NOMFON,;
				cCenCus,;
				cFun,;
				cTar,;
				cDep,;
				TNE_NOME,;
				TN0_DTAVAL,;
				TN0_QTAGEN,;
				TN0_INDEXP,;
				TO1_RECOME,;
				V3F_DESCRI;
			} )

		EndIf

		( cAliasRis )->( dbSkip() )

	End

	( cAliasRis )->( dbCloseArea() )

	BeginSQL Alias cAliasFun
		SELECT
			TN0.TN0_NUMRIS, TM0.TM0_NUMFIC, SRA.RA_MAT, SRA.RA_NOME
		FROM
			%table:SRA% SRA
				INNER JOIN %table:TO0% TO0 ON
					%exp:cLaudo% = TO0.TO0_LAUDO
					AND %xFilial:TO0% = TO0.TO0_FILIAL
					AND TO0.TO0_TIPREL = '3'
					AND TO0.%NotDel%
				INNER JOIN %table:TO1% TO1 ON
					TO0.TO0_LAUDO = TO1.TO1_LAUDO
					AND %xFilial:TO1% = TO1.TO1_FILIAL
					AND TO1.%NotDel%
				INNER JOIN %table:TN0% TN0 ON
					TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
					AND %xFilial:TN0% = TN0.TN0_FILIAL
					AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
					AND TN0.TN0_MAPRIS != '1'
					AND TN0.%NotDel%
				LEFT JOIN %table:TM0% TM0 ON
					SRA.RA_MAT = TM0.TM0_MAT
					AND %xFilial:TM0% = TM0.TM0_FILIAL
					AND TM0.%NotDel%
		WHERE
			SRA.RA_FILIAL = %xFilial:SRA%
			AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
			AND SRA.RA_ADMISSA < %exp:dAteLaudo%
			AND ( SRA.RA_CC = TN0.TN0_CC OR TN0.TN0_CC = '*' )
			AND SRA.%NotDel%
			AND CONCAT( SRA.RA_MAT, TN0.TN0_NUMRIS ) NOT IN (
				SELECT
					CONCAT( SRA.RA_MAT, TN0.TN0_NUMRIS )
				FROM
					%table:SRA% SRA
						INNER JOIN %table:TO0% TO0 ON
							%exp:cLaudo% = TO0.TO0_LAUDO
							AND TO0.TO0_TIPREL = '3'
							AND %xFilial:TO0% = TO0.TO0_FILIAL
							AND TO0.%NotDel%
						INNER JOIN %table:TO1% TO1 ON
							TO0.TO0_LAUDO = TO1.TO1_LAUDO
							AND %xFilial:TO1% = TO1.TO1_FILIAL
							AND TO1.%NotDel%
						INNER JOIN %table:TN0% TN0 ON
							TO1.TO1_NUMRIS = TN0.TN0_NUMRIS
							AND ( TN0.TN0_CC = %exp:cCenCusFil% OR TN0.TN0_CC = '*' )
							AND %xFilial:TN0% = TN0.TN0_FILIAL
							AND TN0.TN0_MAPRIS != '1'
							AND TN0.%NotDel%
						LEFT JOIN %table:TN6% TN6 ON
							SRA.RA_MAT = TN6.TN6_MAT
							AND %xFilial:TN6% = TN6.TN6_FILIAL
							AND TN6.TN6_CODTAR = TN0.TN0_CODTAR
							AND (
								( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM = '' )
								OR (
									TN6.TN6_DTTERM != '' AND TN0.TN0_DTELIM != ''
									AND NOT(
										( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )
										OR ( TN6.TN6_DTINIC > TN0.TN0_DTELIM AND TN6.TN6_DTTERM > TN0.TN0_DTELIM )
									)
								)
								OR (
									TN6.TN6_DTTERM != ''
									AND TN0.TN0_DTELIM = ''
									AND NOT( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )
								)
								OR (
									TN6.TN6_DTTERM = ''
									AND TN0.TN0_DTELIM != ''
									AND NOT( TN0.TN0_DTAVAL < TN6.TN6_DTINIC AND TN0.TN0_DTELIM < TN6.TN6_DTINIC )
								)
							)
							AND TN6.%NotDel%
				WHERE
					SRA.RA_FILIAL = %xFilial:SRA%
					AND SRA.RA_SITFOLH != 'D'
					AND SRA.RA_DEMISSA = ''
					AND ( SRA.RA_ADMISSA <= TN0.TN0_DTELIM OR TN0.TN0_DTELIM = '' )
					AND ( SRA.RA_CC = TN0.TN0_CC OR TN0.TN0_CC = '*' )
					AND ( SRA.RA_CODFUNC = TN0.TN0_CODFUN OR TN0.TN0_CODFUN = '*' )
					AND ( SRA.RA_DEPTO = TN0.TN0_DEPTO OR TN0.TN0_DEPTO = '*' )
					AND ( TN6.TN6_CODTAR = TN0.TN0_CODTAR OR TN0.TN0_CODTAR = '*' )
					AND SRA.%NotDel%
			)
		GROUP BY TN0.TN0_NUMRIS, TM0.TM0_NUMFIC, SRA.RA_MAT, SRA.RA_NOME
		ORDER BY TN0.TN0_NUMRIS
	EndSQL

	dbSelectArea( cAliasFun )
	dbGoTop()

	While !Eof()

		aAdd( aFun, {;
			TN0_NUMRIS,;
			TM0_NUMFIC,;
			RA_MAT,;
			RA_NOME;
		} )

		( cAliasFun )->( dbSkip() )

	End

	( cAliasFun )->( dbCloseArea() )

	For nI := 1 To Len( aRiscos )

		aFunRis := {}

		For nX := 1 To Len( aFun )

			If aFun[ nX, 1 ] == aRiscos[ nI, 1 ]
				aAdd( aFunRis, aFun[ nX ] )
			EndIf

		Next

		aAdd( aRiscos[ nI ], AllTrim( Str( Len( aFunRis ) ) ) ) // Quantidade de funcionários
		aAdd( aRiscos[ nI ], aFunRis ) // Informações dos funcionários

	Next

	For nI := 1 To Len( aRiscos )

		// Só imprime os riscos que contém funcionários não expostos
		If Val( aRiscos[ nI, 15 ] ) > 0

			cListaFun := ''

			OLE_SetDocumentVar( oWord, 'cAgente', AllTrim( aRiscos[ nI, 2 ] ) )

			If aRiscos[ nI, 3 ] == '1'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0071 )
			ElseIf aRiscos[ nI, 3 ] == '2'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0072 )
			ElseIf aRiscos[ nI, 3 ]== '3'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0073 )
			ElseIf aRiscos[ nI, 3 ]== '4'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0074 )
			ElseIf aRiscos[ nI, 3 ] == '5'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0075 )
			ElseIf aRiscos[ nI, 3 ] == '6'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0076 )
			ElseIf aRiscos[ nI, 3 ] == '7'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0077 )
			ElseIf aRiscos[ nI, 3 ] == '8'
				OLE_SetDocumentVar( oWord, 'cTipo', STR0086 )
			EndIf

			OLE_SetDocumentVar( oWord, 'cFonte', AllTrim( aRiscos[ nI, 4 ] ) )
			OLE_SetDocumentVar( oWord, 'cCenCus', AllTrim( aRiscos[ nI, 5 ] ) )
			OLE_SetDocumentVar( oWord, 'cFuncao', AllTrim( aRiscos[ nI, 6 ] ) )
			OLE_SetDocumentVar( oWord, 'cTarefa', AllTrim( aRiscos[ nI, 7 ] ) )
			OLE_SetDocumentVar( oWord, 'cDep', AllTrim( aRiscos[ nI, 8 ] ) )

			If Empty( aRiscos[ nI, 9 ] )
				OLE_SetDocumentVar( oWord, 'cAmb', 'NA' )
			Else
				OLE_SetDocumentVar( oWord, 'cAmb', AllTrim( aRiscos[ nI, 9 ] ) )
			EndIf

			OLE_SetDocumentVar( oWord, 'dDtAval', Dtoc( Stod( aRiscos[ nI, 10 ] ) ) )

			If aRiscos[ nI, 11 ] > 0
				If Empty( aRiscos[ nI, 14 ] )
					OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) )
				Else
					OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) + ' (' + AllTrim( aRiscos[ nI, 14 ] ) + ')' )
				EndIf
			Else
				OLE_SetDocumentVar( oWord, 'cQtdAgen', AllTrim( cValToChar( aRiscos[ nI, 11 ] ) ) )
			EndIf

			If aRiscos[ nI, 12 ] == '1'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0079 )
			ElseIf aRiscos[ nI, 12 ] == '2'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0080 )
			ElseIf aRiscos[ nI, 12 ] == '3'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0081 )
			ElseIf aRiscos[ nI, 12 ] == '4'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0082 )
			ElseIf aRiscos[ nI, 12 ] == '5'
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0083 )
			Else
				OLE_SetDocumentVar( oWord, 'cTipoExp', STR0078 )
			EndIf

			If Empty( aRiscos[ nI, 13 ] )
				OLE_SetDocumentVar( oWord, 'cRec', STR0078 )
			Else
				OLE_SetDocumentVar( oWord, 'cRec', AllTrim( aRiscos[ nI, 13 ] ) )
			EndIf

			If nTipoRel == 1 // Sintético

				OLE_SetDocumentVar( oWord, 'nQtdLin', 12 ) // Quantidade de linhas necessárias para a tabela
				OLE_SetDocumentVar( oWord, 'cFun', aRiscos[ nI, 15 ] )

				OLE_ExecuteMacro( oWord, 'nao_expostos_sintetico' )
			Else
				// Funcionários
				For nX := 1 To Len( aRiscos[ nI, 16 ] )

					If Empty( aRiscos[ nI, 16, nX, 2 ] )
						cListaFun += STR0078 + '*' + AllTrim( aRiscos[ nI, 16, nX, 3 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 4 ] ) + '#'
					Else
						cListaFun += AllTrim( aRiscos[ nI, 16, nX, 2 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 3 ] ) + '*' + AllTrim( aRiscos[ nI, 16, nX, 4 ] ) + '#'
					EndIf

				Next

				OLE_SetDocumentVar( oWord, 'nQtdLin', 13 + Val( aRiscos[ nI, 15 ] ) ) // Quantidade de linhas necessárias para a tabela
				OLE_SetDocumentVar( oWord, 'cFun', cListaFun )

				OLE_ExecuteMacro( oWord, 'nao_expostos_analitico' )

			EndIf

		EndIf

	Next

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fSubCateg
Carrega no array os tipos de categoria do funcionario

@author  Rodrigo Soledade
@since   15/09/2011
@param   cCateg, Caractere, Categorias separadas por barra

@return  aCateg, Array, Contém as categorias do funcionário
/*/
//-------------------------------------------------------------------
Static Function fSubCateg(cCateg)

	Local aCateg := {}
	Local nPos

	If !Empty(cCateg)
		If Substr(cCateg,1,1) == "/"
			cCateg := Substr(cCateg,2)
		EndIf
		If Substr(cCateg,Len(cCateg),1) != "/"
			cCateg += "/"
		EndIf
		cCateg := AllTrim(cCateg)

		While .T.
			nPos := At("/",cCateg)
			If nPos > 0
				If !Empty(Substr(cCateg,1,nPos-1)) .And. Substr(cCateg,1,nPos-1) != "/"
					aADD(aCateg,Substr(cCateg,1,nPos-1))
				EndIf
				cCateg := Substr(cCateg,nPos+1)
			Else
				Exit
			EndIf
		EndDo
	EndIf

Return aCateg
