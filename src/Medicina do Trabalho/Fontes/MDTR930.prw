/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR930.ch"
#Include "Protheus.ch"
#include "ap5mail.ch"
#Include "RPTDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR930

Registro da CIPA na DRT

@author  Denis Hyroshi de Souza
@since   16/11/2006

@sample  U_MDTR930(cCodMandato,cCliente,cLoja)

@param   cCodMandato, Caractere, Parâmetro usado em modo de prestador
@param   cCliente, Caractere, Parâmetro usado em modo de prestador
@param   cLoja, Caractere, Parâmetro usado em modo de prestador
/*/
//-------------------------------------------------------------------
User Function MDTR930(cCodMandato,cCliente,cLoja)
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local aArea := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR930"
	Private titulo   := IIf( lMdtMin, STR0070, IIf( lCipatr, STR0060, STR0001 )) // "Registro da CIPATR na DRT" //"Registro da CIPA na DRT"
	Private cPerg    := If(!lSigaMdtPS,"MDT930    ","MDT930PS  ")

	/*------------------------------
	//PADRÃO						|
	|  Mandato CIPA ?				|
	|  E-mail do DRT ?				|
	|  Nome Representante do DRT ?	|
	|  Cidade / UF do DRT ?			|
	|  								|
	//PRESTADOR						|
	|  Cliente ?					|
	|  Loja							|
	|  Mandato CIPA ?				|
	|  E-mail do DRT ?				|
	|  Nome Representante do DRT ?	|
	|  Cidade / UF do DRT ?			|
	---------------------------------*/

	If ExistBlock("MDTA111R")
		//Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"E"})//Tipo do Evento

		If ValType(cCodMandato) == "C"
			aAdd(aParam, {cCodMandato})
		Else
			aAdd(aParam, {""})
		Endif

		If lSigaMdtPS

			If ValType(cCliente) == "C" .AND. ValType(cLoja) == "C"
				aAdd(aParam, {cCliente})
				aAdd(aParam, {cLoja})
			Else
				aAdd(aParam, {""})
				aAdd(aParam, {""})
			Endif

		Endif

		lRet := ExecBlock("MDTA111R",.F.,.F.,aParam)

		If Type("lRet") <> "L"
			lRet := .F.
		Endif

		If lRet
			Return .T.
		Endif

	Endif

	If Pergunte(cPerg,.t.,titulo)
		Processa({|lEND| MDTA930IMP()})
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA930IMP

Funcao de impressao

@author  Denis Hyroshi de Souza
@since   09/10/2006
/*/
//-------------------------------------------------------------------
Static Function MDTA930IMP()

	Local nOpcao := 0
	Local oMemo,oDlg1
	Local aArea       := GetArea()
	Local lOk         := .F.		// Variavel que verifica se foi conectado OK
	Local lAutOk      := .F.
	Local lSendOk     := .F.		// Variavel que verifica se foi enviado OK
	Local cMailConta  := AllTrim(GetNewPar("MV_RELACNT"," "))
	Local cMailServer := AllTrim(GetNewPar("MV_RELSERV"," "))
	Local cMailSenha  := AllTrim(GetNewPar("MV_RELPSW" ," "))
	Local lSmtpAuth   := GetMv("MV_RELAUTH",,.F.)
	Local cUserAut    := Alltrim(GetMv("MV_RELAUSR",,cMailConta)) //Usuário para Autenticação no Servidor de Email
	Local cSenhAut    := Alltrim(GetMv("MV_RELAPSW",,cMailSenha)) //Senha para Autenticação no Servidor de Email
	Local nTimeOut    := GetMv("MV_RELTIME",,120) //Tempo de Espera antes de abortar a Conexão

	Private cNomeR930
	Private cEmailTo
	Private cEmailCC
	Private cAssu930
	Private cMensR930
	Private cAttach
	Private lAciTM0
	Private oPrint01, oPrint02, oPrint03

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		cNomeR930 := PadR(Mv_par05,60)
		cEmailTo  := PadR(Mv_par04,120)
		cEmailCC  := Space(120)
		cAssu930  := PadR( IIf( lMdtMin, STR0070, IIf( lCipatr, STR0060, STR0001 )),120) //"Registro da CIPATR na DRT" //"Registro da CIPA na DRT"
		cMensR930 := U_MDTR930MSG()
		cAttach   := " "
		lAciTM0   := .F.

		//Verifica se existe o SMTP Server
		If 	Empty(cMailServer)
			Help(" ",1,STR0002,,STR0003+Chr(13)+STR0004,4,5) //"ATENCAO"###"O Servidor de SMTP nao foi configurado."###"Verifique o parametro (MV_RELSERV)."
			RestArea(aArea)
			Return
		EndIf

		If lSmtpAuth

			//Verifica se existe a CONTA
			If 	Empty(cMailConta)
				Help(" ",1,STR0002,,STR0005+Chr(13)+STR0006,4,5) //"ATENCAO"###"A Conta do email nao foi configurado."###"Verifique o parametro (MV_RELACNT)."
				RestArea(aArea)
				Return
			EndIf

			//Verifica se existe a Senha
			If 	Empty(cMailSenha)
				Help(" ",1,STR0002,,STR0007+Chr(13)+STR0008,4,5) //"ATENCAO"###"A Senha do email nao foi configurado."###"Verifique o parametro (MV_RELPSW)."
				RestArea(aArea)
				Return
			EndIf

		EndIf

		//Ata da Eleição
		oPrint01  := FwMsPrinter():New( OemToAnsi(STR0009)) //"Ata de Eleição"
		cAnexo01 := ""
		MDTR927(Mv_par03,.t.,Mv_par01,Mv_par02,.F.)

		If Valtype(cAnexo01) == "L"
			Return
		Endif

		//Ata de Instalação e Posse do novo mandato CIPA
		oPrint02  := FwMSPrinter():New( OemToAnsi(IIf( lMdtMin, STR0071, IIf( lCipatr, STR0061, STR0010 )))) //"Ata de Instalacao e Posse da CIPATR" //"Ata de Instalacao e Posse da CIPA"
		cAnexo02 := ""
		MDTR928(Mv_par03,.t.,Mv_par01,Mv_par02,.F.)

		If Valtype(cAnexo02) == "L"
			Return
		Endif

		//Calendário de reuniões ordinárias CIPA
		oPrint03  := FwMSPrinter():New( OemToAnsi(STR0011)) //"Calendário Anual das Reuniões Ordinárias da CIPA"
		cAnexo03 := ""
		MDTR929(Mv_par03,.t.,Mv_par01,Mv_par02,.F.)

		If Valtype(cAnexo03) == "L"
			Return
		Endif

		DEFINE MSDIALOG oDlg1 TITLE OemToAnsi(IIf( lMdtMin, STR0070, IIf( lCipatr, STR0060, STR0001 ))) FROM 00,00 TO 395,550 PIXEL //"Registro da CIPATR na DRT" //"Registro da CIPA na DRT"
			@ 2.0,1 SAY STR0012 OF oDlg1 //"Nome"
			@ 2.0,5 MSGET cNomeR930 SIZE 130,10 OF oDlg1 Picture "@!" When .f.
			@ 3.1,1 SAY STR0013 OF oDlg1 //"Para"
			@ 3.1,5 MSGET cEmailTo SIZE 230,10 OF oDlg1
			@ 4.2,1 SAY STR0014 OF oDlg1 //"Cópia"
			@ 4.2,5 MSGET cEmailCc SIZE 230,10 OF oDlg1
			@ 5.3,1 SAY STR0015 OF oDlg1 //"Assunto"
			@ 5.3,5 MSGET cAssu930 SIZE 230,10 OF oDlg1

			@ 6.5,1.1 GET oMemo VAR cMensR930 MEMO SIZE 260,105 OF oDlg1

			@ 8,10  BUTTON STR0016   OF oDlg1 SIZE 35,11 PIXEL ACTION (If(!U_fValCpo930(),nOpcao:=0,(nOpcao := 1,oDlg1:End()))) //"&Enviar"
			@ 8,50  BUTTON STR0017 OF oDlg1 SIZE 35,11 PIXEL ACTION (U_MDTR930IMP()) //"&Imprimir"
			@ 8,90  BUTTON STR0018 OF oDlg1 SIZE 35,11 PIXEL ACTION (nOpcao := 0,oDlg1:End()) //"&Cancelar"
			@ 2,130 TO 23,275 LABEL STR0019 of oDlg1 Pixel //"Visualizar Documentos"
			@ 8,135 BUTTON STR0020 OF oDlg1 SIZE 40,11 PIXEL ACTION (ShellExecute("open", cPAtaElei, "", cDirAtaElei, 1)) //"&Ata Eleição"
			@ 8,180 BUTTON STR0021 OF oDlg1 SIZE 40,11 PIXEL ACTION (oPrint02:Preview()) //"Ata de &Posse"
			@ 8,225 BUTTON STR0022 OF oDlg1 SIZE 45,11 PIXEL ACTION (oPrint03:Preview()) //"Agenda &Reuniões"

		ACTIVATE MSDIALOG oDlg1 CENTERED

		If nOpcao != 1
			Return
		Endif

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		cNomeR930   := PadR(Mv_par03,60)
		cEmailTo    := PadR(Mv_par02,120)
		cEmailCC    := Space(120)
		cAssu930    := PadR(IIf( lMdtMin, STR0070, IIf( lCipatr, STR0060, STR0001 )),120) //"Registro da CIPATR na DRT" //"Registro da CIPA na DRT"
		cMensR930   := U_MDTR930MSG()
		cAttach     := " "
		lAciTM0     := .f.

		//Verifica se existe o SMTP Server
		If 	Empty(cMailServer)
			Help(" ",1,STR0002,,STR0003+Chr(13)+STR0004,4,5) //"ATENCAO"###"O Servidor de SMTP nao foi configurado."###"Verifique o parametro (MV_RELSERV)."
			RestArea(aArea)
			Return
		EndIf

		If lSmtpAuth

			//Verifica se existe a CONTA
			If 	Empty(cMailConta)
				Help(" ",1,STR0002,,STR0005+Chr(13)+STR0006,4,5) //"ATENCAO"###"A Conta do email nao foi configurado."###"Verifique o parametro (MV_RELACNT)."
				RestArea(aArea)
				Return
			EndIf

			//Verifica se existe a Senha
			If 	Empty(cMailSenha)
				Help(" ",1,STR0002,,STR0007+Chr(13)+STR0008,4,5) //"ATENCAO"###"A Senha do email nao foi configurado."###"Verifique o parametro (MV_RELPSW)."
				RestArea(aArea)
				Return
			EndIf

		EndIf

		//Ata da Eleição
		cDirAtaElei := GetTempPath()
		cPAtaElei 	:= NoAcento( StrTran( STR0009, " ", ""))+Alltrim(Mv_par01)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4) //"Ata de Eleição"
		oPrint01  	:= FwMSPrinter():New( OemToAnsi(cPAtaElei+".pdf") , IMP_PDF , .T. , , .T.,,,"PDF",,,,.F.)
		cAnexo01    := ""
		MDTR927(Mv_par01,.T.,,,.F.,cPAtaElei)

		If Valtype(cAnexo01) == "L"
			Return
		Endif

		//Ata de Instalação e Posse do novo mandato CIPA
		cDirAtaInst := GetTempPath()
		cPAtaInst 	:= NoAcento( StrTran( IIf( lMdtMin, STR0071, IIf( lCipatr, STR0061, STR0010 )), " ", ""))+Alltrim(Mv_par01)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)
		oPrint02  	:= FwMSPrinter():New( OemToAnsi(cPAtaInst+".pdf"), IMP_PDF , .T. , , .T.,,,"PDF",,,,.F.) //"Ata de Instalacao e Posse da CIPATR" //"Ata de Instalacao e Posse da CIPA"
		cAnexo02 := ""
		MDTR928(Mv_par01,.T.,,,.F.,cPAtaInst)

		If Valtype(cAnexo02) == "L"
			Return
		Endif

		//Calendário de reuniões ordinárias CIPA
		cDirCalend	:= GetTempPath()
		cPCalend 	:= NoAcento( StrTran( STR0011, " ", ""))+Alltrim(Mv_par01)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)
		oPrint03  	:= FwMSPrinter():New( OemToAnsi(cPCalend+".pdf"), IMP_PDF , .T. , , .T.,,,"PDF",,,,.F.) //"Calendário Anual das Reuniões Ordinárias"
		cAnexo03 := ""
		MDTR929(Mv_par01,.T.,,,.F.,cPCalend)

		If Valtype(cAnexo03) == "L"
			Return
		Endif

		DEFINE MSDIALOG oDlg1 TITLE OemToAnsi(IIf( lMdtMin, STR0070, IIf( lCipatr, STR0060, STR0001 ))) FROM 00,00 TO 395,550 PIXEL //"Registro da CIPATR na DRT" //"Registro da CIPA na DRT"
			@ 2.0,1 SAY STR0012 OF oDlg1 //"Nome"
			@ 2.0,5 MSGET cNomeR930 SIZE 130,10 OF oDlg1 Picture "@!" When .f.
			@ 3.1,1 SAY STR0013 OF oDlg1 //"Para"
			@ 3.1,5 MSGET cEmailTo SIZE 230,10 OF oDlg1
			@ 4.2,1 SAY STR0014 OF oDlg1 //"Cópia"
			@ 4.2,5 MSGET cEmailCc SIZE 230,10 OF oDlg1
			@ 5.3,1 SAY STR0015 OF oDlg1 //"Assunto"
			@ 5.3,5 MSGET cAssu930 SIZE 230,10 OF oDlg1

			@ 6.5,1.1 GET oMemo VAR cMensR930 MEMO SIZE 260,105 OF oDlg1

			@ 8,10  BUTTON STR0016   OF oDlg1 SIZE 35,11 PIXEL ACTION (If(!U_fValCpo930(),nOpcao:=0,(nOpcao := 1,oDlg1:End()))) //"&Enviar"
			@ 8,50  BUTTON STR0017 OF oDlg1 SIZE 35,11 PIXEL ACTION (U_MDTR930IMP()) //"&Imprimir"
			@ 8,90  BUTTON STR0018 OF oDlg1 SIZE 35,11 PIXEL ACTION (nOpcao := 0,oDlg1:End()) //"&Cancelar"
			@ 2,130 TO 23,275 LABEL STR0019 of oDlg1 Pixel //"Visualizar Documentos"
			@ 8,135 BUTTON STR0020 OF oDlg1 SIZE 40,11 PIXEL ACTION (ShellExecute("open", oPrint01:cPathPDF+cPAtaElei+".pdf", "", cDirAtaElei, 1)) //"&Ata Eleição"
			@ 8,180 BUTTON STR0021 OF oDlg1 SIZE 40,11 PIXEL ACTION (ShellExecute("open", oPrint02:cPathPDF+cPAtaInst+".pdf", "", cDirAtaInst, 1)) //"Ata de &Posse"
			@ 8,225 BUTTON STR0022 OF oDlg1 SIZE 45,11 PIXEL ACTION (ShellExecute("open", oPrint03:cPathPDF+cPCalend+".pdf", "", cDirCalend, 1)) //"Agenda &Reuniões"

		ACTIVATE MSDIALOG oDlg1 CENTERED

		If nOpcao != 1
			Return
		Endif

	Endif

	CONNECT SMTP SERVER cMailServer ACCOUNT cMailConta PASSWORD cMailSenha TIMEOUT nTimeOut RESULT lOk

		If !lAutOk

			If lSmtpAuth
				lAutOk := MailAuth(cUserAut,cSenhAut)

				If !lAutOk
					Aviso(OemToAnsi(STR0002),OemToAnsi(STR0023),{"Ok"}) //"Atencao"###"Falha na Autenticação do Usuário no Provedor de E-mail"
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
						SUBJECT Trim(cAssu930);
						BODY cMensR930;
						ATTACHMENT cAnexo01+cAnexo02+cAnexo03;
						RESULT lSendOk

			If !lSendOk
				Help(" ",1,STR0002,,STR0024,4,5) //"ATENCAO"###"Erro no envio de Email"
			Else
				Aviso(OemToAnsi(STR0002),OemToAnsi(STR0025),{"Ok"}) //"Atencao"###"Email enviado com sucesso"
			EndIf

		Else
			Help(" ",1,STR0002,,STR0026,4,5) //"ATENCAO"###"Erro na conexao com o SMTP Server"
		EndIf

	DISCONNECT SMTP SERVER

	//Deleta os arquivos temporários
	If File(cDirAtaElei+Lower(cPAtaElei)+".pdf")
		FErase( cDirAtaElei+Lower(cPAtaElei)+".pdf")
	EndIf

	If File(cDirAtaInst+Lower(cPAtaInst)+".pdf")
		FErase( cDirAtaInst+Lower(cPAtaInst)+".pdf")
	EndIf

	If File(cDirCalend+Lower(cPCalend)+".pdf")
		FErase( cDirCalend+Lower(cPCalend)+".pdf")
	EndIf

	RestArea(aArea)
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fValCpo930

Validacao dos campos obrigatorios

@author  Denis Hyroshi de Souza
@since   12/08/2004
/*/
//-------------------------------------------------------------------
User Function fValCpo930()

	If 	Empty(cEmailTo)
		Aviso(OemToAnsi(STR0027),OemToAnsi(STR0028),{"Ok"}) //"Atenção"###"Não foi informado o email do destinatário."
		Return .F.
	EndIf

	If 	Empty(cAssu930)

		If !MsgYesNo(STR0029,OemToAnsi(STR0027)) //"Não foi informado o assunto. Deseja enviá-lo agora?"###"Atenção"
			Return .F.
		Endif

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR930MSG

Monta mensagem de envio ao sindicato

@author  Denis Hyroshi de Souza
@since   17/10/2006

@return  Caractere, String com a mensagem para o sindicato
/*/
//-------------------------------------------------------------------
User Function MDTR930MSG()
	Local cMensR930 := ""
	Local aAreaSA1 := SA1->(GetArea())
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	nTotalFun := QtdeFunc()

	If lSigaMdtps

		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+mv_par01+mv_par02)

		dbSelectarea("TOE")
		dbSetorder(1)
		dbSeek(xFilial("TOE")+SA1->A1_CNAE)

		cMensR930 += STR0030 //"Ao(À) Exmo.(a) Sr.(a)"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += Alltrim(Mv_par05)
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0031 //"Delegado(a) Regional do Trabalho"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += Alltrim(Mv_par06)
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += IIf( lMdtMin, STR0072, IIf( lCipatr, STR0062, STR0032 )) //"Assunto: Registro da CIPATR" //"Assunto: Registro da CIPA"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0033 //"Senhor Delegado,"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0034+Alltrim(SA1->A1_NOME)+STR0035+Alltrim(SA1->A1_END)+" - " //"A empresa "###", situada à "
		cMensR930 += Alltrim(SA1->A1_MUN)+"-"+SA1->A1_EST+", "
		cMensR930 += STR0055+Alltrim(SA1->A1_CEP)+STR0036+Alltrim(SA1->A1_TEL) //", Telefone " //"C.E.P. "

		If !Empty(TOE->TOE_DESCRI)
			cMensR930 += STR0037+Alltrim(TOE->TOE_DESCRI) //", com atividade de "
		Endif

		If !Empty(SA1->A1_CNAE)
			cMensR930 += ","+STR0056+SA1->A1_CNAE //" CNAE: "
		Endif

		cMensR930 += ","+STR0057+Transform(SA1->A1_CGC,"@R 99999999/9999-99") //" CNPJ: "
		cMensR930 += STR0038+nTotalFun+STR0039 //", com "###" colaboradores vem, "
		cMensR930 += STR0040 //"respeitosamente, requerer à Vossa Senhoria o protocolo para arquivamento "
		cMensR930 += IIf( lMdtMin, STR0073, IIf( lCipatr, STR0063, STR0041 )) //"de documentos da Comissão Interna de Prevenção de Acidentes no Trabalho Rural - CIPATR, de conformidade " //"de documentos da Comissão Interna de Prevenção de Acidentes - CIPA, de conformidade "
		cMensR930 += IIf( lMdtMin, STR0074, IIf( lCipatr, STR0064, STR0042 )) //"com o artigo 163 da CLT e a NR31 da Portaria n. 86 de 03/03/05 e Portaria n. 1896 de 09/12/2013." //"com o artigo 163 da CLT e a NR5 da Portaria n. 3.214 de 08/06/78 e Portaria n. 08 de 23/02/1999."
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0043 //"Para tanto, anexamos os seguintes documentos:"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0044 //"	- Cópia da Ata de Eleição;"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0045 //"	- Cópia da Ata de Instalação de Posse;"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += IIf( lMdtMin, STR0075, IIf( lCipatr, STR0066, STR0046 )) //"	- Calendário Anual das reuniões ordinárias da CIPA."
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0047 //"Atenciosamente,"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += If(lCipatr, STR0067, STR0048) //"Coordenador da empresa"###"Presidente da empresa"

		RestArea(aAreaSA1)

	Else

		dbSelectarea("TOE")
		dbSetorder(1)
		dbSeek(xFilial("TOE")+SM0->M0_CNAE)

		cMensR930 += STR0030 //"Ao(À) Exmo.(a) Sr.(a)"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += Alltrim(Mv_par03)
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0031 //"Delegado(a) Regional do Trabalho"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += Alltrim(Mv_par04)
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += IIf( lMdtMin, STR0072, IIf( lCipatr, STR0062, STR0032 )) //"Assunto: Registro da CIPATR" //"Assunto: Registro da CIPA"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0033 //"Senhor Delegado,"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0034+Alltrim(SM0->M0_NOMECOM)+STR0035+Alltrim(SM0->M0_ENDCOB)+" - " //"A empresa "###", situada à "
		cMensR930 += Alltrim(SM0->M0_CIDCOB)+If(!Empty(SM0->M0_ESTCOB),"-"+SM0->M0_ESTCOB," ")+", "
		cMensR930 += STR0055+Alltrim(SM0->M0_CEPCOB)+STR0036+Alltrim(SM0->M0_TEL) //", Telefone " //"C.E.P. "

		If !Empty(TOE->TOE_DESCRI)
			cMensR930 += STR0037+Alltrim(TOE->TOE_DESCRI) //", com atividade de "
		Endif

		If !Empty(SM0->M0_CNAE)
			cMensR930 += ","+STR0056+SM0->M0_CNAE //" CNAE: "
		Endif

		If SM0->M0_TPINSC == 2
			cMensR930 += ","+STR0057+Transform(SM0->M0_CGC,"@R 99999999/9999-99") //" CNPJ: "
		Else
			cMensR930 += ","+STR0057+Transform(SM0->M0_CGC,"@R 99.999.99999/99") //" CNPJ: "
		Endif

		cMensR930 += STR0038+nTotalFun+STR0039 //", com "###" colaboradores vem, "
		cMensR930 += STR0040 //"respeitosamente, requerer à Vossa Senhoria o protocolo para arquivamento "
		cMensR930 += IIf( lMdtMin, STR0073, IIf( lCipatr, STR0063, STR0041 ))// "de documentos da Comissão Interna de Prevenção de Acidentes no Trabalho Rural - CIPATR, de conformidade " //"de documentos da Comissão Interna de Prevenção de Acidentes - CIPA, de conformidade "
		cMensR930 += IIf( lMdtMin, STR0074, IIf( lCipatr, STR0064, STR0042 )) //"com o artigo 163 da CLT e a NR31 da Portaria n. 86 de 03/03/05 e Portaria n. 1896 de 09/12/2013." //"com o artigo 163 da CLT e a NR5 da Portaria n. 3.214 de 08/06/78 e Portaria n. 08 de 23/02/1999."
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0043 //"Para tanto, anexamos os seguintes documentos:"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0044 //"	- Cópia da Ata de Eleição;"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += STR0045 //"	- Cópia da Ata de Instalação de Posse;"
		cMensR930 += CHR(13)+CHR(10)
		cMensR930 += IIf( lMdtMin, STR0075, IIf( lCipatr, STR0066, STR0046 ))//"	- Calendário Anual das reuniões ordinárias da CIPA."
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += STR0047 //"Atenciosamente,"
		cMensR930 += CHR(13)+CHR(10)+CHR(13)+CHR(10)
		cMensR930 += If(lCipatr, STR0067, STR0048) //"Coordenador da empresa"###"Presidente da empresa"

	Endif

Return cMensR930

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR930IMP

Funcao de impressao dos dados do email

@author  Denis Hyroshi de Souza
@since   17/10/2006
/*/
//-------------------------------------------------------------------
User Function MDTR930IMP()

	Private oPrint  := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont11 := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)

	Lin := 300
	oPrint:SetPortrait() //retrato

	nLinhasMemo := MLCOUNT(cMensR930,90) * 45
	oPrint:StartPage()
	// Localização do Logo da Empresa
	oPrint:SayBitMap(Lin-225,200,NGLocLogo(),250,50)
	oPrint:SayAlign(lin,200,cMensR930,oFont11, 1900 , nLinhasMemo , , 3 , 0)

	If nLinhasMemo > 0
		oPrint:EndPage()
	Endif

	oPrint:Preview()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} QtdeFunc

Quantidade de funcionarios na empresa

@author  Denis Hyroshi de Souza
@since   17/10/2006

@return  Caractere, Quantidade de funcionários não demitidos na filial corrente
/*/
//-------------------------------------------------------------------
Static Function QtdeFunc()
	Local cQtde := 0
	Local nAuto := If(!lSigaMdtPs,Mv_par05,Mv_par07)

	#IFNDEF TOP

		dbSelectArea("SRA")
		dbSetorder(1)
		dbSeek(xFilial("SRA"))
		While !Eof() .and. xFilial("SRA") == SRA->RA_FILIAL
			If Empty(SRA->RA_DEMISSA) .and. SRA->RA_SITFOLH <> "D" .And. If(nAuto == 2,SRA->RA_CATFUNC <> "A",.T.)
				cQtde++
			Endif
			dbSkip()
		End

	#ELSE

		cALIASSRA := "TRBFUN"

		cQuery := " SELECT COUNT(*) QTDFUN "
		cQuery += " FROM " + RetSQLName("SRA") + " SRA "
		cQuery += " WHERE SRA.D_E_L_E_T_ = ' ' AND SRA.RA_SITFOLH <> 'D' AND"
		cQuery += " SRA.RA_DEMISSA = '        ' AND SRA.RA_FILIAL = '"+xFilial("SRA")+"' "
		If nAuto == 2
			cQuery += "AND SRA.RA_CATFUNC != 'A'"
		Endif

		cQuery := ChangeQuery(cQuery)
		MPSysOpenQuery( cQuery , cALIASSRA )

		dbSelectArea(cALIASSRA)
		dbGotop()
		cQtde := (cALIASSRA)->QTDFUN

		(cALIASSRA)->( dbCloseArea() )
	#ENDIF

Return Alltrim(Str(cQtde,9))

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT930CLI

Atualiza a variavel cCliMdtps

@author  Andre Perez Alvarez
@since   28/11/2007

@sample  sample

@param   _nDeCC, Numérico, Parâmetro utilizado em modo de prestador
@param   _nAteCC, Numérico, Parâmetro utilizado em modo de prestador

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDT930CLI(_nDeCC,_nAteCC)
	Private xVarDe  := "Mv_par"
	Private xVarAte := "Mv_par"

	cCliMdtps := mv_par01+mv_par02

	If ValType(_nDeCC) == "N"
		xVarDe := xVarDe + StrZero(_nDeCC,2)

		If ValType(&(xVarDe)) == "C"

			If Substr(&(xVarDe),1,Len(cCliMdtps)) <> cCliMdtps
				&(xVarDe) := Space(Len(&(xVarDe)))
			Endif
		Endif

	Endif

	If ValType(_nAteCC) == "N"
		xVarAte := xVarAte + StrZero(_nAteCC,2)

		If ValType(&(xVarAte)) == "C"

			If Substr(&(xVarAte),1,Len(cCliMdtps)) <> cCliMdtps
				&(xVarAte) := Replicate("Z",Len(&(xVarAte)))
			Endif

		Endif

	Endif

Return .T.