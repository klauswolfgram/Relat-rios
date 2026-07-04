/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR922.ch"
#Include "Protheus.ch"
#include "ap5mail.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR922

Aviso ao Sindicato sobre Eleições CIPA

@author  Denis Hyroshi de Souza
@since   16/10/2006

@sample  U_MDTR922(cCodMandato, cCliente, cLoja)

@param   cCodMandato, Caractere, Parâmetro usado no modo de prestador
@param   cCliente, Caractere, Parâmetro usado no modo de prestador
@param   cLoja, Caractere, Parâmetro usado no modo de prestador
/*/
//-------------------------------------------------------------------
User Function MDTR922(cCodMandato, cCliente, cLoja)
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local aArea   := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR922"
	Private titulo   := IIf( lMdtMin, STR0054, IIf( lCipatr, STR0044, STR0001 )) //"Aviso ao Sindicato sobre Eleições CIPA"
	Private cPerg    := If(!lSigaMdtPS,"MDT922    ","MDT922PS  ")

	/*------------------------------
	//PADRÃO						|
	|  Mandato  ?					|
	|  E-mail do Sindicato ?		|
	|  Nome Presidente Sindicato ?	|
	|  Nome do Sindicato ?			|
	|  Cidade Sede do Sindicato ?	|
	|  								|
	//PRESTADOR						|
	|  Cliente ?					|
	|  Loja							|
	|  Mandato CIPA ?				|
	|  E-mail do Sindicato ?		|
	|  Nome Presidente Sindicato ?	|
	|  Nome do Sindicato ?			|
	|  Cidade Sede do Sindicato ?	|
	---------------------------------*/

	If Pergunte(cPerg,.t.)
		Processa({|lEND| MDTA922IMP()})
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA922IMP

Funcao de impressao

@author  Denis Hyroshi de Souza
@since   09/10/2006
/*/
//-------------------------------------------------------------------
Static Function MDTA922IMP()

	Local nOpcao := 0
	Local oMemo,oDlg1
	Local aArea       := GetArea()
	Local lOk         := .F.		// Variavel que verifica se foi conectado OK
	Local lAutOk      := .F.
	Local lSendOk     := .F.		// Variavel que verifica se foi enviado OK
	Local cMailConta  := AllTrim(GetMV("MV_RELACNT",," "))
	Local cMailServer := AllTrim(GetMV("MV_RELSERV",," "))
	Local cMailSenha  := AllTrim(GetMV("MV_RELPSW" ,," "))
	Local lSmtpAuth   := GetMv("MV_RELAUTH",,.F.)
	Local cUserAut    := Alltrim(GetMv("MV_RELAUSR",,cMailConta)) // Usuário para Autenticação no Servidor de Email
	Local cSenhAut    := Alltrim(GetMv("MV_RELAPSW",,cMailSenha)) // Senha para Autenticação no Servidor de Email
	Local nTimeOut    := GetMv("MV_RELTIME",,120) // Tempo de Espera antes de abortar a Conexão

	Private cNome
	Private cEmailTo
	Private cEmailCC
	Private cAssunto
	Private cMensagem
	Private cAttach
	Private lAciTM0
	Private cCabecario
	Private oMemoCabec
	Private oMemoTxt

	//Verifica se existe o SMTP Server
	If 	Empty(cMailServer)
		Help(" ",1,STR0003,,STR0004+Chr(13)+STR0005,4,5) //"ATENCAO"###"O Servidor de SMTP nao foi configurado."###"Verifique o parametro (MV_RELSERV)."
		RestArea(aArea)
		Return
	EndIf

	If lSmtpAuth

		//Verifica se existe a CONTA
		If 	Empty(cMailConta)
			Help(" ",1,STR0003,,STR0006+Chr(13)+STR0007,4,5) //"ATENCAO"###"A Conta do email nao foi configurado."###"Verifique o parametro (MV_RELACNT)."
			RestArea(aArea)
			Return
		EndIf

		//Verifica se existe a Senha
		If 	Empty(cMailSenha)
			Help(" ",1,STR0003,,STR0008+Chr(13)+STR0009,4,5) //"ATENCAO"###"A Senha do email nao foi configurado."###"Verifique o parametro (MV_RELPSW)."
			RestArea(aArea)
			Return
		EndIf

	EndIf

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(1)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		cNome       := PadR(Mv_par05,60)
		cEmailTo    := PadR(Mv_par04,120)
		cEmailCC    := Space(120)
		cAssunto    := PadR(STR0002,120) //"Comunicação de processo eleitoral"
		U_MDTR922MSG ( , @cMensagem)
		U_MDTR922MSG (.T. , @cCabecario)
		cAttach     := " "
		lAciTM0 := .f.
		lReadOnly := .T.

		DEFINE MSDIALOG oDlg1 TITLE OemToAnsi(STR0010) FROM 00,00 TO 380,510 PIXEL //"Aviso ao Sindicato sobre o início do processo eleitoral CIPA"
			@ 0.2,1 SAY STR0011 OF oDlg1 //"Presidente"
			@ 0.2,5 MSGET cNome SIZE 130,10 OF oDlg1 Picture "@!" When .f.
			@ 1.3,1 SAY STR0012 OF oDlg1 //"Para"
			@ 1.3,5 MSGET cEmailTo SIZE 210,10 OF oDlg1
			@ 2.4,1 SAY STR0013 OF oDlg1 //"Cópia"
			@ 2.4,5 MSGET cEmailCc SIZE 210,10 OF oDlg1
			@ 3.5,1 SAY STR0014 OF oDlg1 //"Assunto"
			@ 3.5,5 MSGET cAssunto SIZE 210,10 OF oDlg1

			@ 3.5,1 SAY STR0042 OF oDlg1 //"Cabeçalho"
			@ 5.1,1 GET oMemoCabec VAR cCabecario MEMO SIZE 210,40 OF oDlg1
			oMemoCabec:lReadOnly := .T.
			@ 3.5,1 SAY STR0043 OF oDlg1 //"Texto"
			@ 5.1,1 GET oMemoTxt VAR cCabecario MEMO SIZE 210,64 OF oDlg1

			@ 80,8  BUTTON STR0038 OF oDlg1 SIZE 30,14 PIXEL ACTION (If(!U_fValCpo922(),nOpcao:=0,(nOpcao := 1,oDlg1:End()))) //"&Enviar"
			@ 80,48 BUTTON STR0039 OF oDlg1 SIZE 30,14 PIXEL ACTION (U_MDTR922IMP()) //"&Imprimir"
			@ 80,88 BUTTON STR0040 OF oDlg1 SIZE 30,14 PIXEL ACTION (nOpcao := 0,oDlg1:End()) //"&Cancelar"

		ACTIVATE MSDIALOG oDlg1 CENTERED

		If nOpcao != 1
			Return
		Endif

		// Envia e-mail com os dados necessarios
		If !Empty(cMailServer) .And. !Empty(cMailConta) .And. !Empty(cMailSenha)
			CONNECT SMTP SERVER cMailServer ACCOUNT cMailConta PASSWORD cMailSenha TIMEOUT nTimeOut RESULT lOk

			If !lAutOk

				If lSmtpAuth
					lAutOk := MailAuth(cUserAut,cSenhAut)

					If !lAutOk
						Aviso(OemToAnsi(STR0003),OemToAnsi(STR0015),{"Ok"}) //"Atencao"###"Falha na Autenticação do Usuário no Provedor de E-mail"
						RestArea(aArea)
						DISCONNECT SMTP SERVER
						Return
					Endif

				Else
					lAutOk := .T.
				EndIf

			EndIf

			If lOk .and. lAutOk
					SEND MAIL FROM cMailConta;
							TO cEmailTo;
							CC cEmailcc;
							SUBJECT Trim(cAssunto);
							BODY cCabecario + cMensagem;
							RESULT lSendOk
				If !lSendOk
					Help(" ",1,STR0003,,STR0016,4,5) //"ATENCAO"###"Erro no envio de Email"
				Else
					Aviso(OemToAnsi(STR0003),OemToAnsi(STR0017),{"Ok"}) //"Atencao"###"Email enviado com sucesso"
				EndIf

			Else
				Help(" ",1,STR0003,,STR0018,4,5) //"ATENCAO"###"Erro na conexao com o SMTP Server"
			EndIf

			DISCONNECT SMTP SERVER
		EndIf

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		cNome       := PadR(Mv_par03,60)
		cEmailTo    := PadR(Mv_par02,120)
		cEmailCC    := Space(120)
		cAssunto    := PadR(STR0002,120) //"Comunicação de processo eleitoral"
		U_MDTR922MSG( , @cMensagem )
		U_MDTR922MSG( .T. , @cCabecario )
		cAttach     := " "
		lAciTM0 := .f.
		lReadOnly:= .T.

		DEFINE MSDIALOG oDlg1 TITLE OemToAnsi(STR0010) FROM 00,00 TO 380,515 PIXEL //"Aviso ao Sindicato sobre o início do processo eleitoral CIPA"
			@ 0.2,1 SAY If(lCipaTr,STR0052,STR0011) OF oDlg1 //"Coordenador"###"Presidente"
			@ 0.2,6 MSGET cNome SIZE 130,10 OF oDlg1 Picture "@!" When .f.
			@ 1.3,1 SAY STR0012 OF oDlg1 //"Para"
			@ 1.3,6 MSGET cEmailTo SIZE 210,10 OF oDlg1
			@ 2.4,1 SAY STR0013 OF oDlg1 //"Cópia"
			@ 2.4,6 MSGET cEmailCc SIZE 210,10 OF oDlg1
			@ 3.5,1 SAY STR0014 OF oDlg1 //"Assunto"
			@ 3.5,6 MSGET cAssunto SIZE 210,10 OF oDlg1 Valid U_MDTR922MSG( .T. , @cCabecario )
			//
			@ 4.8,1 SAY STR0042 OF oDlg1 //"Cabeçario"
			@ 4.8,6 GET oMemoCabec VAR cCabecario MEMO SIZE 210,40 OF oDlg1
			oMemoCabec:lReadOnly := .T.
			@ 8.2,1 SAY STR0043 OF oDlg1 //"Texto"
			@ 8.2,6 GET oMemoTxt VAR cMensagem MEMO SIZE 210,62 OF oDlg1

			@ 173,138  BUTTON STR0038   OF oDlg1 SIZE 30,14 PIXEL ACTION (If(!U_fValCpo922(),nOpcao:=0,(nOpcao := 1,oDlg1:End()))) //"&Enviar"
			@ 173,178 BUTTON STR0039 OF oDlg1 SIZE 30,14 PIXEL ACTION (U_MDTR922IMP()) //"&Imprimir"
			@ 173,218 BUTTON STR0040 OF oDlg1 SIZE 30,14 PIXEL ACTION (nOpcao := 0,oDlg1:End()) //"&Cancelar"

		ACTIVATE MSDIALOG oDlg1 CENTERED

		If nOpcao != 1
			Return
		Endif

		CONNECT SMTP SERVER cMailServer ACCOUNT cMailConta PASSWORD cMailSenha TIMEOUT nTimeOut RESULT lOk

			If !lAutOk

				If lSmtpAuth
					lAutOk := MailAuth(cUserAut,cSenhAut)

					If !lAutOk
						Aviso(OemToAnsi(STR0003),OemToAnsi(STR0015),{"Ok"}) //"Atencao"###"Falha na Autenticação do Usuário no Provedor de E-mail"
						RestArea(aArea)
						DISCONNECT SMTP SERVER
						Return
					Endif

				Else
					lAutOk := .T.
				EndIf

			EndIf

			If lOk .And. lAutOk
					SEND MAIL FROM cMailConta;
							TO cEmailTo;
							CC cEmailcc;
							SUBJECT Trim(cAssunto);
							BODY cCabecario + cMensagem;
							RESULT lSendOk

				If !lSendOk
					Help(" ",1,STR0003,,STR0016,4,5) //"ATENCAO"###"Erro no envio de Email"
				Else
					Aviso(OemToAnsi(STR0003),OemToAnsi(STR0017),{"Ok"}) //"Atencao"###"Email enviado com sucesso"
				EndIf

			Else
				Help(" ",1,STR0003,,STR0018,4,5) //"ATENCAO"###"Erro na conexao com o SMTP Server"
			EndIf

		DISCONNECT SMTP SERVER

	Endif

	RestArea(aArea)
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fValCpo922

Validacao todos os campos obrigatorios

@author  Denis Hyroshi de Souza
@since   12/08/2004

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function fValCpo922()

	If 	Empty(cEmailTo)
		Aviso(OemToAnsi(STR0019),OemToAnsi(STR0020),{"Ok"}) //"Atenção"###"Não foi informado o email do destinatário."
		Return .f.
	EndIf

	If 	Empty(cAssunto)

		If !MsgYesNo(STR0021,OemToAnsi(STR0019)) //"Não foi informado o assunto. Deseja enviá-lo agora?"###"Atenção"
			Return .f.
		Endif

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR922MSG

Monta mensagem de envio ao sindicato
@author  Denis Hyroshi de Souza
@since   17/10/2006

@sample  sample

@param   lCabec, Lógico, Define se será impressa informações adicionais na mensagem
@param   cMsgRet, Caractere, Compatibilidade

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDTR922MSG( lCabec , cMsgRet )
	Local cMsgDiaEl, cMensagem

	Default lCabec := .F.

	cMsgDiaEl := " "

	If lSigaMdtps

		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+cCliMdtps)

		If lCabec
			cMensagem := Alltrim(SA1->A1_MUN)
			cMensagem += ", "+Strzero(Day(dDataBase),2)+STR0041 //" de "
			cMensagem += UPPER(MesExtenso(dDataBase))+STR0041 //" de "
			cMensagem += Strzero(Year(dDataBase),4)
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)

			cMensagem += STR0022 + CHR(13)+CHR(10) + Mv_par05 + CHR(13)+CHR(10) //"Ao(À) Exmo.(a) Sr.(a)"
			cMensagem += Mv_par06 + CHR(13)+CHR(10)
			cMensagem += Mv_par07 + CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0023+cAssunto //"Assunto: "
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)+CHR(13)+CHR(10)
		Else

			If !Empty(TNN->TNN_ELEICA)
				cMsgDiaEl := Strzero(Day(TNN->TNN_ELEICA),2)+STR0041 //" de "
				cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_ELEICA))+STR0041 //" de "
				cMsgDiaEl += Strzero(Year(TNN->TNN_ELEICA),4)
			Endif

			cMensagem := If(lCipatr,STR0053,STR0024)+CHR(13)+CHR(10)+CHR(13)+CHR(10) //"Senhor(a) Coordenador,"###"Senhor(a) Presidente,"
			cMensagem += STR0025+cMsgDiaEl //"Comunicamos a este Sindicato, que será realizada no dia "
			cMensagem += STR0026 //", a eleição dos representantes dos empregados na Comissão Interna de "
			cMensagem += IIf( lMdtMin, STR0055, IIf( lCipatr, STR0045, STR0027 ))+Alltrim(SA1->A1_NOME) //"Prevenção de Acidentes no Trabalho Rural - CIPATR, da empresa " //"Prevenção de Acidentes - CIPA, da empresa "
			cMensagem += STR0028+Alltrim(SA1->A1_END)+" - " //" no endereço "
			cMensagem += Alltrim(SA1->A1_MUN)+"-"+SA1->A1_EST+"."
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0029 //"Atenciosamente,"
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0030 //"Responsável pela Empresa"
		EndIf
	Else
		If lCabec
			cMensagem := Alltrim(SM0->M0_CIDCOB)
			cMensagem += ", "+Strzero(Day(dDataBase),2)+STR0041 //" de "
			cMensagem += UPPER(MesExtenso(dDataBase))+STR0041 //" de "
			cMensagem += Strzero(Year(dDataBase),4)
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)

			cMensagem += STR0022 + CHR(13)+CHR(10) + Mv_par03 + CHR(13)+CHR(10) //"Ao(À) Exmo.(a) Sr.(a)"
			cMensagem += Mv_par04 + CHR(13)+CHR(10)
			cMensagem += Mv_par05 + CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0023+cAssunto //"Assunto: "
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)+CHR(13)+CHR(10)
		Else

			If !Empty(TNN->TNN_ELEICA)
				cMsgDiaEl := Strzero(Day(TNN->TNN_ELEICA),2)+STR0041 //" de "
				cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_ELEICA))+STR0041 //" de "
				cMsgDiaEl += Strzero(Year(TNN->TNN_ELEICA),4)
			Endif

			cMensagem := If(lCipatr,STR0053,STR0024)+CHR(13)+CHR(10)+CHR(13)+CHR(10) //"Senhor(a) Coordenador,"###"Senhor(a) Presidente,"
			cMensagem += STR0025+cMsgDiaEl //"Comunicamos a este Sindicato, que será realizada no dia "
			cMensagem += STR0026 //", a eleição dos representantes dos empregados na Comissão Interna de "
			cMensagem := If(lCipatr,STR0053,STR0024)+CHR(13)+CHR(10)+CHR(13)+CHR(10) //"Senhor(a) Coordenador,"###"Senhor(a) Presidente,"
			cMensagem += STR0028+Alltrim(SM0->M0_ENDCOB)+" - " //" no endereço "
			cMensagem += Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")+"."
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0029 //"Atenciosamente,"
			cMensagem += CHR(13)+CHR(10)+CHR(13)+CHR(10)+CHR(13)+CHR(10)
			cMensagem += STR0030 //"Responsável pela Empresa"
		EndIf

	Endif

	cMsgRet := cMensagem

	If Type( "oMemoCabec" ) == "O"
		oMemoCabec:Refresh()
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR922IMP

Função de impressão dos dados do email

@author  Denis Hyroshi de Souza
@since   17/10/2006
/*/
//-------------------------------------------------------------------
User Function MDTR922IMP()
	Local Lin := 300

	Private oPrint  := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont11 := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)

	If ExistBlock("MDTA111R")
		//Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"4"})//Tipo do Evento

		If lSigaMdtPS
			aAdd(aParam, {mv_par01})
			aAdd(aParam, {mv_par02})
			aAdd(aParam, {mv_par03})
		Else
			aAdd(aParam, {mv_par01})
		Endif

		lRet := ExecBlock("MDTA111R",.F.,.F.,aParam)

		If Type("lRet") <> "L"
			lRet := .F.
		Endif

		If lRet
			Return .T.
		Endif

	Endif

	Lin := 300
	oPrint:SetPortrait() //retrato
	oPrint:Setup()
	nLinhasMemo := MLCOUNT(cCabecario + cMensagem,90) * 50
	oPrint:StartPage()
	// Localização do Logo da Empresa
	oPrint:SayBitMap(Lin-225,200,NGLocLogo(),250,50)
	oPrint:SayAlign(lin , 200 , cCabecario+cMensagem , oFont11 , 1900 , nLinhasMemo , , 3 , 0)

	If nLinhasMemo > 0
		oPrint:EndPage()
	Endif

	oPrint:Preview()

Return