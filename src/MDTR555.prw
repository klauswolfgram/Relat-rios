/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr555.ch"
#INCLUDE "MSOLE.CH"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR555  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 23.04.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do DIRBEN 8030.                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR555()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

PRIVATE cPerg    := ""
Private aTarefas := {}
Private aFuncoes := {}
Private nDocVar  := 0000
Private aRiscos  := {}
Private cLocal   := space(10)
Private cAgente  := space(10)
Private cLaudo   := space(10)
Private cIndExp  := space(1)
Private lLaudo   := .f.
Private lUseLI   := .f.
Private PageNumb := 1
Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,4,(TAMSX3("RJ_FUNCAO")[1]))

Private lMdtUnix := GetRemoteType() == 2 .or. isSRVunix() //Verifica se servidor ou estacao é Linux

lSigaMdtPS := SuperGetMv("MV_MDTPS",.F.,"N") == "S"
cCliMdtps := ""
cPerg    :=  PADR( If(lSigaMdtPS,"MDT555PS","MDT555") , 10 )

nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
nSizeTD := nTa1+nTa1L

/*--------------------------------------------
//PERGUNTAS PADRÃO								|
| MDT555    ¦01      ¦Tipo Impressao ?			|
| MDT555    ¦02      ¦Funcionario ?			|
| MDT555    ¦03      ¦Usuario Respons. ?		|
| MDT555    ¦04      ¦Cliente ?					|
| MDT555    ¦05      ¦Laudo ?					|
| MDT555    ¦06      ¦Arquivo Saida ?			|
													|
//PERGUNTAS PRESTADOR DE SERVIÇO				|
| MDT555    ¦01      ¦Tipo Impressao ?			|
| MDT555    ¦02      ¦Cliente ?					|
| MDT555    ¦03      ¦Loja						|
| MDT555    ¦04      ¦Funcionario ?			|
| MDT555    ¦05      ¦Usuario Respons. ?		|
| MDT555    ¦06      ¦Laudo ?					|
| MDT555    ¦07      ¦Arquivo Saida ?			|
----------------------------------------------*/

If pergunte(cPerg,.t.)
	U_INDMDT555()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ INDMDT555³ Autor ³Denis Hyroshi de Souza ³ Data ³02/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime Relatorio do Dirben                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function INDMDT555()

	Local cCGC,cCidade,cEmpresa,cEndereco,cRamo, nf, xx
	Local cCDAIQ,strDia,strMes,strAno,aStrMes,aIndices
	Local cMemo := " "

	Local cArqDot  := "dss8030.dot"							// Nome do arquivo modelo do Word (Tem que ser .dot)
	Local cPathDot := Alltrim(GetMv("MV_DIRACA"))			// Path do arquivo modelo do Word
	Local cPathEst := Alltrim(GetMv("MV_DIREST")) 			// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ
	Local cRootPath
	Local cBarraRem := "\"
	Local cBarraSrv := "\"
	Local aTabT3Reg := {}

	If GetRemoteType() == 2  //estacao com sistema operacional unix
		cBarraRem := "/"
	Endif
	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	Endif

	cPathDot += If(Substr(cPathDot,len(cPathDot),1) != cBarraSrv,cBarraSrv,"") + cArqDot
	cPathEst += If(Substr(cPathEst,len(cPathEst),1) != cBarraRem,cBarraRem,"")

	//Cria diretorio se nao existir
	MontaDir(cPathEst)

	//Se existir .dot na estacao, apaga!
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	If !File(cPathDot)
		MsgStop(STR0049+chr(10)+STR0050,STR0051) //"O arquivo dss8030.dot não foi encontrado no servidor."###"Verificar parâmetro 'MV_DIRACA'."###"ATENÇÃO"
		Return
	EndIf
	CpyS2T(cPathDot,cPathEst,.T.) 	// Copia do Server para o Remote, eh necessario
	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP

	Private cAlias := "SI3"
	Private cDescr := "SI3->I3_DESC"
	Private lImpress,cArqSaida, oWord

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	Endif

	lin := 250
	aIndices := {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w",;
	"x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W",;
	"X","Y","Z"}
	aStrMes := {STR0001,STR0002,STR0003,STR0004,STR0005,STR0006,STR0007,STR0008,STR0009,STR0010,STR0011,STR0012} //"Janeiro"###"Fevereiro"###"Março"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"

	Dbselectarea("SRA")
	Dbsetorder(01)
	If Dbseek(xFilial("SRA")+Mv_par02)

		lImpress	:= If(mv_par01 == 1,.f.,.t.)	//Verifica se a saida sera em Tela ou Impressora
		cArqSaida	:= If(Empty(mv_par06),"Documento1",AllTrim(mv_par06))	// Nome do arquivo de saida

		oWord := OLE_CreateLink('TMsOleWord97')//Cria link como Word

		If lImpress //Impressao via Impressora
			OLE_SetProperty(oWord,oleWdVisible,  .F.)
			OLE_SetProperty(oWord,oleWdPrintBack,.T.)
		Else //Impressao na Tela(Arquivo)
			OLE_SetProperty(oWord,oleWdVisible,  .F.)
			OLE_SetProperty(oWord,oleWdPrintBack,.F.)
		EndIf
		cType := "dss8030| *.dot"
		OLE_NewFile(oWord,cPathEst + cArqDot) //Abrindo o arquivo modelo automaticamente

		Dbselectarea("TM0")
		Dbsetorder(3)
		Dbseek(xFilial("TM0")+Mv_par02)
		Dbselectarea("TMK")
		Dbsetorder(1)
		Dbseek(xFilial("TMK")+Mv_par03)
		Dbselectarea(cAlias)
		Dbsetorder(1)
		Dbseek(xFilial(cAlias)+SRA->RA_CC)
		Dbselectarea("SRJ")
		Dbsetorder(1)
		Dbseek(xFilial("SRJ")+SRA->RA_CODFUNC)

		Dbselectarea("TO0")
		Dbsetorder(1)
		If Dbseek(xFilial("TO0")+Mv_par05)
			lLaudo := .t.
			cMemo := Alltrim(TO0->TO0_DESCRI)
				If !Empty(TO0->TO0_MMSYP2)
					cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
					If !Empty(cMMSYP2)
						If !Empty(cMemo)
							cMemo += CRLF
						Endif
						cMemo += cMMSYP2
					Endif
				ELseIf !Empty(TO0->TO0_DESC2)
					If !Empty(cMemo)
						cMemo += CRLF
					Endif
					cMemo += Alltrim(TO0->TO0_DESC2)
				Endif
		Endif

		cCGC      := alltrim(Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))
		cCidade   := "BAIRRO: "+Alltrim(SM0->M0_BAIRCOB)+"  -  "+Alltrim(SM0->M0_CIDCOB)
		cCidade   += If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")
		cEmpresa  := Alltrim(SM0->M0_NOMECOM)
		cEndereco := Alltrim(SM0->M0_ENDCOB)
		cRamo     := space(1)
		cCDAIQ    := Alltrim(SM0->M0_CIDCOB)

		dbSelectArea("SA1")
		dbSetOrder(1)
		If dbSeek(xFilial("SA1")+Mv_par04)

			aTabT3Reg := FWGetSX5( "T3", SA1->A1_SATIV1 )

			If Len(aTabT3Reg) > 0
				cRamo     := Alltrim(Upper(aTabT3Reg[ 1, 4 ]))
				cCidade   := STR0052+Alltrim(SM0->M0_BAIRCOB)+"  -  "+Alltrim(SA1->A1_MUN) //"BAIRRO: "
				cCidade   += If(!Empty(SA1->A1_EST),"-"+SA1->A1_EST," ")
				cEmpresa  := Alltrim(SA1->A1_NOME)
				cEndereco := Alltrim(SA1->A1_END)
				cCGC      := Alltrim(Transform(SA1->A1_CGC,"@!R NN.NNN.NNN/NNNN-99"))
				cCDAIQ    := Alltrim(SA1->A1_MUN)
			EndIf

		EndIf

		U_NG555EVO(SRA->RA_FILIAL,SRA->RA_MAT,SRA->RA_ADMISSA)
		MDTRETRIS( , , , { | | fDefRisco() } , , , , .F. )

		If Empty(cLocal)
			cLocal := &cDescr
		Endif

		OLE_SetDocumentVar(oWord,"cEmpresa",cEmpresa+" ")
		OLE_SetDocumentVar(oWord,"cRamo",cRamo+" ")
		OLE_SetDocumentVar(oWord,"cEndereco",cEndereco+"  -  "+cCidade)
		OLE_SetDocumentVar(oWord,"cNome",SRA->RA_NOME)
		OLE_SetDocumentVar(oWord,"cCtps",Alltrim(SRA->RA_NUMCP+"/"+SRA->RA_SERCP))
		OLE_SetDocumentVar(oWord,"cRg",SRA->RA_RG)
		OLE_SetDocumentVar(oWord,"cSetor",Substr(&cDescr,1,35))
		OLE_SetDocumentVar(oWord,"cHorario",Str(SRA->RA_HRSEMAN,5,2)+STR0024)
		OLE_SetDocumentVar(oWord,"cLocal",Substr(cLocal,1,100))

		//"ATIVIDADES QUE EXECUTA"
		If Len(aFuncoes) <= 0
			aAdd(aFuncoes,{SRA->RA_CODFUNC,SRA->RA_ADMISSA})
		Endif
		aAdd(aFuncoes,{SRA->RA_CODFUNC,If(Empty(SRA->RA_DEMISSA),CtoD("  /  /  "),SRA->RA_DEMISSA)})
		For nF := 1 to 	(Len(aFuncoes)-1)
			nDocVar++
			cDocVar  := "cHist"+Strzero(nDocVar,4)
			OLE_SetDocumentVar(oWord,"Parametro1",cDocVar)
			If nF != 1
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"Com_Negrito")
			Endif

			Dbselectarea("SRJ")
			Dbsetorder(1)
			Dbseek(xFilial("SRJ")+aFuncoes[nF][1])
			Dbselectarea("SQ3")
			Dbsetorder(1)
			Dbseek(xFilial("SQ3")+SRJ->RJ_CARGO)

			If nF == (Len(aFuncoes)-1)
				cOle := STR0053+DtoC(aFuncoes[nF][2])+STR0054+DtoC(aFuncoes[nF+1][2])+" - "+Alltrim(SRJ->RJ_DESC) //"* De: "###" à "
				OLE_SetDocumentVar(oWord,cDocVar,cOle)
			Else
				cOle := STR0053+DtoC(aFuncoes[nF][2])+STR0054+DtoC(aFuncoes[nF+1][2]-1)+" - "+Alltrim(SRJ->RJ_DESC) //"* De: "###" à "
				OLE_SetDocumentVar(oWord,cDocVar,cOle)
			Endif

			cMemo111 := " "
			cMemo111 := Alltrim(MSMM(SQ3->Q3_DESCDET))
			cMemo111 := StrTran(cMemo111,Chr(13)+Chr(10)," ")

			nDocVar++
			cDocVar  := "cHist"+Strzero(nDocVar,4)
			OLE_SetDocumentVar(oWord,"Parametro1",cDocVar)
			If nF == 1
				OLE_ExecuteMacro(oWord,"SetCampos")
			Endif
			OLE_ExecuteMacro(oWord,"Cria_Texto")
			OLE_ExecuteMacro(oWord,"Sem_Negrito")
			OLE_SetDocumentVar(oWord,cDocVar,cMemo111+" ")

		Next nF

		cAgenteRis := " "
		For xx := 1 to Len(aRiscos)
			If xx == Len(aRiscos)
				cAgenteRis += aRiscos[xx][2]+"."
			Else
				If xx == (Len(aRiscos)-1)
					cAgenteRis += aRiscos[xx][2]+STR0055 //" e "
				Else
					cAgenteRis += aRiscos[xx][2]+", "
				Endif
			Endif
		Next xx
		OLE_SetDocumentVar(oWord,"cAgente",cAgenteRis)

		If lLaudo
			OLE_SetDocumentVar(oWord,"cLaudo",STR0030) //"SIM"
		Else
			OLE_SetDocumentVar(oWord,"cLaudo",STR0031) //"NÃO"
		Endif

		If cIndexp == "1"
			OLE_SetDocumentVar(oWord,"cExposicao",STR0034)
		Elseif	cIndexp == "2"
			OLE_SetDocumentVar(oWord,"cExposicao",STR0035)
		Elseif	cIndexp == "4"
			OLE_SetDocumentVar(oWord,"cExposicao",Trim(Upper(NGRETSX3BOX("TN0_INDEXP",cIndExp))) )
		Else
			OLE_SetDocumentVar(oWord,"cExposicao"," ")
		Endif

		OLE_SetDocumentVar(oWord,"cConclusao"," ")
		If lLaudo .and. !Empty(cMemo)
			U_F555MEMO(cMemo)
		Endif

		strDia := Alltrim(Str(Day(Date())))
		strMes := Upper(aStrMes[Month(Date())])
		strAno := Alltrim(Str(Year(Date())))
		cCDAIQ += ", "+strDia+STR0056+strMes+STR0056+strAno  //" DE "###" DE "
		OLE_SetDocumentVar(oWord,"cDataHora",cCDAIQ)

		OLE_SetDocumentVar(oWord,"Medico",Substr(TMK->TMK_NOMUSU,1,25))
		OLE_SetDocumentVar(oWord,"nCrea",Alltrim(TMK->TMK_ENTCLA)+" "+TMK->TMK_NUMENT)
		OLE_SetDocumentVar(oWord,"nSSMT","SSMT "+TMK->TMK_REGMTB)

		OLE_ExecuteMacro(oWord,"Atualiza") //Executa a macro que atualiza os campos do documento
		OLE_ExecuteMacro(oWord,"Begin_Text") //Posiciona o cursor no inicio do documento

		cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
		cRootPath := IF( RIGHT(cRootPath,1) == cBarraSrv,SubStr(cRootPath,1,Len(cRootPath)-1), cRootPath)

		IF lImpress //Impressao via Impressora
			OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL",,, 1 )
		Else //Impressao na Tela(Arquivo)
			OLE_SetProperty(oWord,oleWdVisible,.t.)
			OLE_ExecuteMacro(oWord,"Maximiza_Tela")
			If !lMdtUnix //Se for windows
				If DIRR570(cRootPath+cBarraSrv+"SPOOL"+cBarraSrv)
					OLE_SaveAsFile(oWord,cRootPath+cBarraSrv+"SPOOL"+cBarraSrv+cArqSaida,,,.f.,oleWdFormatDocument)
				Else
					OLE_SaveAsFile(oWord,cPathEst+cArqSaida,,,.f.,oleWdFormatDocument)
				Endif
			Endif
			MsgInfo(STR0057) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
		EndIF
		OLE_CloseLink(oWord) //Fecha o documento
	Endif

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R555ID   ³ Autor ³Denis Hyroshi de Souza ³ Data ³02/04/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Calcula a idade do funcionario                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R555ID(dNasc,dFim)

Local nIdade := 0

If dFim == nil
	dFim := Date()
Endif

nIdade := Year(dFim) - Year(dNasc)
If Month(dFim) < Month(dNasc)
	nIdade := nIdade - 1
Elseif Month(dFim) == Month(dNasc)
	If Day(dFim) < Day(dNasc)
		nIdade := nIdade - 1
	Endif
Endif

Return Alltrim(Str(nIdade,3))
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fDefRisco³ Autor ³Jackson                ³ Data ³25/08/2015³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Alimenta as variáveis de Risco                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fDefRisco()

						If cIndExp != "1"
							cIndExp := TN0->TN0_INDEXP
						Endif
						If lSigaMdtps
							Dbselectarea("TNE")
							Dbsetorder(3)  //TNE_FILIAL+TNE_CODCLI+TNE_LOJACL+TNE_CODAMB
							If Dbseek(xFilial("TNE")+TN0->(TN0_CODCLI+TN0_LOJACL)+TN0->TN0_CODAMB)
								If Empty(cLocal)
				cLocal := If(NGCADICBASE( "TNE_MEMODS" , "A" , "TNE" , .F. ), Alltrim(TNE->TNE_MEMODS) , Alltrim(TNE->TNE_DESAMB))
								Endif
							Endif
						Else
							Dbselectarea("TNE")
							Dbsetorder(1)
							If Dbseek(xFilial("TNE")+TN0->TN0_CODAMB)
								If Empty(cLocal)
				cLocal := If(NGCADICBASE( "TNE_MEMODS" , "A" , "TNE" , .F. ), Alltrim(TNE->TNE_MEMODS) , Alltrim(TNE->TNE_DESAMB))
								Endif
							Endif
						Endif

						Dbselectarea("TMA")
						Dbsetorder(1)
						If Dbseek(xFilial("TMA")+TN0->TN0_AGENTE)
					    	If Len(aRiscos) < 40 .and. aSCAN(aRiscos,{|x| Alltrim(X[1]) == Alltrim(TN0->TN0_AGENTE)}) < 1
								AADD(aRiscos,{TN0->TN0_AGENTE,Substr(Alltrim(TMA->TMA_NOMAGE),1,35)})
							Endif
						Endif
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |U_F555MEMO ()³ Autor³Denis Hyroshi de Souza ³ Data  ³ 28/04/03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³Verifica se existe texto no campo memo a ser impresso       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function F555MEMO(cRet)
Local lEof := .t.,cTitulo := " ",cTexto := " ",nPos1

While lEof
	If Empty(cRet)  //Memo vazio
		lEof := .f.
		Exit
	Else
		nPos1   := At("#",cRet)
		cRet    := Alltrim(Substr(cRet,nPos1+1))
		nPos1   := At("#",cRet)
		cTitulo := Alltrim(Substr(cRet,1,nPos1-1))
		cRet    := Alltrim(Substr(cRet,nPos1+1))
		nPos1   := At("#",cRet)
		If nPos1 > 0
			cTexto := Alltrim(Substr(cRet,1,nPos1-1))
		Else
			cTexto := Alltrim(cRet)
			lEof   := .f.
		Endif
	Endif

	If STR0058 $ cTitulo .OR. STR0059 $ cTitulo .OR. STR0060 $ cTitulo .OR. ; //"CONCLUSÃO"###"CONCLUSAO"###"Conclusão"
   	   STR0061 $ cTitulo .OR. STR0062 $ cTitulo .OR. STR0063 $ cTitulo //"Conclusao"###"conclusão"###"conclusao"

		U_IMPTXT555(Alltrim(cTexto))
		lEof   := .f.
	Endif
End
Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |U_IMPTXT555()³ Autor³Denis Hyroshi de Souza ³ Data  ³ 28/04/03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o campo memo do Laudo Tecnico                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function IMPTXT555(_cTexto)
Local cTextoNew := _cTexto

cTextoNew := StrTran(cTextoNew,Chr(13)+Chr(10)," ")

OLE_SetDocumentVar(oWord,"cConclusao",cTextoNew)

Return .t.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   |U_NG555EVO ()³ Autor³Denis Hyroshi de Souza ³ Data  ³ 25/08/03³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Verifica a evolucao das funcoes exercidas pelo funcionario ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function NG555EVO(sraFilial,sraMat,sraAdmissa)
Local cFunOld := "#####"

Dbselectarea("SR7")
Dbsetorder(1)
Dbseek(sraFilial+sraMat+Dtos(sraAdmissa),.t.)
While !eof() .and. sraFilial+sraMat == SR7->R7_FILIAL+SR7->R7_MAT
	If SR7->R7_FUNCAO <> cFunOld
		aAdd(aFuncoes,{SR7->R7_FUNCAO,SR7->R7_DATA})
	Endif
	cFunOld := SR7->R7_FUNCAO
	Dbselectarea("SR7")
	Dbskip()
End
Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDT735VL01³ Autor ³Andre E. P. Alvarez    ³ Data ³31/01/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Valida o cliente (no mod prestador)                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT555VL01(nTipo)
Local lRet := .t.
If nTipo == 1
	If Empty(Mv_par03)
		Mv_par03 := "0000"
	Endif
	lRet := ExistCpo('SA1',Mv_par02 + Mv_par03)
	PutFileInEof('SA1')
	Return lRet
Else
	If Empty(SA1->A1_COD)
		dbselectarea('SA1')
		dbsetorder(1)
		dbseek(xFilial('SA1')+Mv_par02)
	Endif

	If !ExistCpo('SA1',SA1->A1_COD+Mv_par03)
		Return .f.
	Endif
	Mv_par02 := SA1->A1_COD
	PutFileInEof('SA1')
Endif

Return .t.
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
User Function MDT555CLI()

cCliMdtps := mv_par02+mv_par03

Return .T.
