/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR923.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR923

Impressao das fichas de inscricao CIPA

@author  Denis Hyroshi de Souza
@since   16/10/2006

@sample  U_MDTR923(cCodMandato,cCliente,cLoja)

@param   cCodMandato, Caractere, Parâmetro usado no modo de prestador
@param   cCliente, Caractere, Parâmetro usado no modo de prestador
@param   cLoja, Caractere, Parâmetro usado no modo de prestador
/*/
//-------------------------------------------------------------------
User Function MDTR923(cCodMandato,cCliente,cLoja)
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()


	// Define Variaveis
	Local aArea := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR923"
	Private titulo   := STR0001 //"Ficha Inscrição"
	Private cPerg    := If(!lSigaMdtPS,"MDT923    ","MDT923PS  ")

	If ExistBlock("MDTA111R")
		//Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"5"})//Tipo do Evento

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

	/*----------------------------------
	//PADRÃO							|
	|  Mandato CIPA ?					|
	|  Qtdade de Fichas Inscricao ?		|
	|  Fichas por Pagina ?				|
	|  Tipo de Impressao ?				|
	|  									|
	//PRESTADOR							|
	|  Cliente ?						|
	|  Loja								|
	|  Mandato CIPA ?					|
	|  Qtdade de Fichas Inscricao ?		|
	|  Fichas por Pagina ?				|
	|  Tipo de Impressao ?				|
	-----------------------------------*/

	If Pergunte( cPerg, .T. )

		If !Empty( mv_par05 ) .And. !Empty( mv_par06 )
			Processa({|lEND| MDTA923IMP()},STR0002) //"Imprimindo..."
		Else
			MsgInfo( STR0025 + '.', STR0026 ) // "Não existem dados há serem exibidos no relatório"
		EndIf

	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA923IMP

Funcao de impressao

@author  Denis Hyroshi de Souza
@since   16/10/2006

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA923IMP()

	Local nCont  := 0

	Local cCand  := ""
	Local cCargo := ""
	Local cResp  := ""

	Private oPrint    := FwMsPrinter():New( OemToAnsi( titulo ) )

	Private oFont09	  := TFont():New( "VERDANA", 09, 09,, .F.,,,, .F., .F. )
	Private oFont11	  := TFont():New( "VERDANA", 11, 11,, .F.,,,, .F., .F. )
	Private oFont12n  := TFont():New( "VERDANA", 12, 12,, .T.,,,, .F., .F. )
	Private oFont12	  := TFont():New( "VERDANA", 12, 12,, .F.,,,, .F., .F. )
	Private l1st_page := .T. // Controla impressao da primeira pagina ou nao

	Lin := 4000
	oPrint:SetPortrait() // Retrato

	dbSelectArea( "TK8" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TK8" ) + mv_par01 )
		If TK8->TK8_TIPPAR == "1"
			cResp := Alltrim( Posicione( "SRA", 1, xFilial( "SRA", TK8->TK8_FILRE ) + TK8->TK8_MATRE, "RA_NOME" ) )
		ElseIf TK8->TK8_TIPPAR == "2"
			cResp := AllTrim( TK8->TK8_NOMPAR )
		EndIf
	EndIf

	dbSelectArea( "TNN" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TNN" ) + mv_par01 )

		dbSelectArea( "SRA" )
		dbSetOrder( 01 )
		If dbSeek( xFilial( "SRA" ) + mv_par05 )
			While SRA->( !Eof() ) .And. SRA->RA_FILIAL == xFilial( "SRA" )

				If SRA->RA_MAT < mv_par05 .Or. SRA->RA_MAT > mv_par06
					SRA->( DBSkip() )
					Exit
				EndIf

				nCont++

				If ( nCont % 2 ) <> 0 .Or. mv_par03 == 1
					If nCont > 1
						oPrint:EndPage()
					Endif
					oPrint:StartPage()
					lin := 200
				Else
					lin := 1500
				Endif

				oPrint:Box( lin, 500, lin + 1150, 2000 )
				// Localização do Logo da Empresa
				oPrint:SayBitMap( lin + 020, 520, NGLocLogo(), 250, 50 )
				oPrint:Say( lin + 080, 850, IIf( lMdtMin, STR0021, IIf( lCipatr, STR0018, STR0003 ) ), oFont12n ) //"FICHA DE INSCRIÇÃO PARA ELEIÇÃO DA CIPATR" //"FICHA DE INSCRIÇÃO PARA ELEIÇÃO DA CIPA"

				cTitTxt := STR0004 + StrZero( Year( TNN->TNN_DTINIC ), 4 ) //"GESTÃO - "
				If Year( TNN->TNN_DTINIC ) != Year( TNN->TNN_DTTERM )
					cTitTxt += "/"+Substr( StrZero( Year( TNN->TNN_DTTERM ), 4 ), 3, 2 )
				Else
					cTitTxt += Space( 5 )
				Endif
				cTitTxt := PadR( cTitTxt, 18 )
				oPrint:Say( lin + 140, 1125, cTitTxt, oFont12 )

				oPrint:Box( lin + 210, 520, lin + 420, 1980 )
				cCand := SRA->RA_NOME
				oPrint:Say(  lin + 250, 530, STR0005 + cCand, oFont12 ) //"Nome:"
				oPrint:Line( lin + 280, 520, lin + 280, 1980 )
				oPrint:Say(  lin + 390, 530, STR0023 + SRA->RA_CIC, oFont12 ) //"CPF:"
				oPrint:Line( lin + 350, 520, lin + 350, 1980 )
				cCargo := Alltrim( Posicione( "SQ3", 1, xFilial( "SQ3" ) + SRA->RA_CARGO ,"Q3_DESCSUM" ) )
				oPrint:Say(  lin + 320, 530, STR0006 + cCargo, oFont12 ) //"Cargo:"
					
				oPrint:Box( lin + 500, 520, lin + 580, 1980 )
				oPrint:Say( lin + 540, 530, STR0024 + cResp, oFont12 )
				oPrint:Say( lin + 540, 530, STR0024 + cResp, oFont12 )

				cTxtCIPA := STR0007 //"Venho, através desta, candidatar-me para eleição dos representantes dos empregados na "
				cTxtCIPA += IIf( lMdtMin, STR0022, IIf( lCipatr, STR0019, STR0008 ) ) //"Comissão Interna de Prevenção de Acidentes no Trabalho Rural - CIPATR da " //"Comissão Interna de Prevenção de Acidentes - CIPA da "
				cTxtCIPA += Alltrim( SM0->M0_NOMECOM ) + "."

				oPrint:SayAlign( lin + 630, 580, cTxtCIPA, oFont11, 1300, 145, , 3, 0 )

				cCidade  := Alltrim( SM0->M0_CIDCOB )
				cCidade  += ", " + Strzero( Day( dDataBase ), 2 ) + STR0009 //" de "
				cCidade  += UPPER( MesExtenso( dDataBase ) ) + STR0009 //" de "
				cCidade  += Strzero( Year( dDataBase ), 4 )

				oPrint:Say( lin + 830, 580, cCidade, oFont09 )

				oPrint:Line( lin + 1000, 520, lin + 1000, 1230  )
				oPrint:Say(  lin + 1050, 650, STR0010, oFont09  ) //"Assinatura do Candidato"
				oPrint:Say(  lin + 1080, 650, cCand, oFont09    ) //Nome Candidato
				oPrint:Line( lin + 1000, 1270, lin + 1000, 1980 )
				oPrint:Say(  lin + 1050, 1400, STR0011, oFont09 ) //"Responsável Pela Inscrição"
				oPrint:Say(  lin + 1080, 1400, cResp, oFont09   ) //Nome Responsável*/

				oPrint:EndPage()

				SRA->( DBSkip() )

			End

		EndIf

		If mv_par04 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Endif

Return NIL

//--------------------------------------------------------------------------
/*/{Protheus.doc} fCipaVal
Valida os parametros do grupo de perguntas.

@author Eloisa Anibaletto
@since 28/10/2024

@return lRet, Boolean, Retorna .F. caso conter alguma divirgencia ou .T.
caso estiver de acordo com a validação
/*/
//--------------------------------------------------------------------------
User Function fCipaVal( nOpc )

	Local lRet := .T.

	If nOpc == 1

		If Empty( mv_par05 ) .Or. !ExistCpo( "SRA" , mv_par05, 1 )
			lRet := .F.
		EndIf

	ElseIf nOpc == 2

		If Empty( mv_par06 ) .Or. !ExistCpo( "SRA" , mv_par06, 1 )
			lRet := .F.
		EndIf

	ElseIf nOpc == 3

		DbSelectArea( "TK8" )
		DbSetOrder( 1 )
		If DbSeek( xFilial( "TK8" ) + mv_par01 ) .And. TK8->TK8_MATRE != mv_par07
			Help( " ", 1, "REGNOIS" )
			lRet := .F.
		EndIf

	EndIf

Return lRet
