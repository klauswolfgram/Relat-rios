/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR420.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR420
Relatorio das doencas diagnosticadas por funcao.

@return Nil, sempre nulo

@sample U_MDTR420()

@author	Marcio Costa
@since	12/01/2000
/*/
//-------------------------------------------------------------------
User Function MDTR420()

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local oReport
	Local aArea := GetArea()

	lSigaMdtPS := IIf( SuperGetMv( "MV_MDTPS", .F., "N" ) == "S", .T. , .F. )

	Private nMasc		:= 0
	Private nFemin		:= 0
	Private cCodfun		:= Space( 5 )
	Private cCid		:= Space( 8 )
	Private nSizeSRJ	:= IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 4, ( TAMSX3( "RJ_FUNCAO" )[1] ) )
	Private cPerg		:= IIf( !lSigaMdtPS, "MDT420    ", "MDT420PS  " )
	Private lPrestSX6	:= .F.

	If SuperGetMv( "MV_NGMDTPS", .F., "N" ) == "S"
		lPrestSX6 := .T.
	EndIf

	/*-----------------------------------
	//PERGUTAS PADRÃO					|
	|  01  De  Funcao ?					|
	|  02  Ate Funcao ?					|
	|  03  De  CID ?					|
	|  04  Ate CID ?					|
	|  05  De  Data Diagnost. ?			|
	|  06  Ate Data Diagnost. ?			|
	|-----------------------------------|
	//PERGUNTAS PRESTADOR DE SERVIÇO	|
	|  01  De  Cliente ?         		|
	|  02  Loja                  		|
	|  03  Até Cliente ?         		|
	|  04  Loja                  		|
	|  05  De  Funcao ?          		|
	|  06  Ate Funcao ?          		|
	|  07  De  CID ?             		|
	|  08  Ate CID ?             		|
	|  09  De  Data Diagnost. ?  		|
	|  10  Ate Data Diagnost. ?  		|
	------------------------------------*/

	If !MDTRESTRI( cPrograma )
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM( aNGBEGINPRM )
		Return .F.
	EndIf

	If TRepInUse()
		//Interface de impressao
		oReport := ReportDef()
		oReport:SetPortrait()
		oReport:PrintDialog()
	Else
		U_MDTR420R3()
	EndIf

	RestArea( aArea )

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as secoes impressas no relatorio

@return oReport, Objeto do relatório

@sample ReportDef()

@author	Andre E. Perez Alvarez
@since	16/11/2006
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Static oReport
	Static oSection0
	Static oSection1
	Static oSection2
	Static oSection3
	Static oBreak3
	Static oCell
	Static oCel2
	Static oCel3

	/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	_______________________________________________________________________________________________________________________________________________

														CID x Funcionario
	_______________________________________________________________________________________________________________________________________________

	CID			Descricao
	-----------------------------------------
	123456789  123456789012345678901234567890

	Matricula  Nome Funcionario           Sexo      Admissao  Idade  Dt. Diag.  C. Custo   Funcao Descricao
	---------------------------------------------------------------------------------------------------------------------
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890

	CID			Descricao
	-----------------------------------------
	123456789  123456789012345678901234567890

	Matricula  Nome Funcionario           Sexo      Admissao  Idade  Dt. Diag.  C. Custo   Funcao Descricao
	---------------------------------------------------------------------------------------------------------------------
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890
	123456789  1234567890123456789012345  Masculino xx/xx/xx     80  xx/xx/xx   123456789  123456789012345678901234567890

	_______________________________________________________________________________________________________________________________________________
	Resumo do Relatorio
	Total de Diagnosticos Pesquisados:  xxx

	C.I.D.    Descricao                                 Masculinos Femininos Total
	------------------------------------------------------------------------------
	12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
	12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
	12345678  1234567890123456789012345678901234567890         xxx       xxx   xxx
	*/

	//Criacao do componente de impressao
	//TReport():New
	//ExpC1 : Nome do relatorio
	//ExpC2 : Titulo
	//ExpC3 : Pergunte
	//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	//ExpC5 : Descricao
	oReport := TReport():New( "MDTR420", OemToAnsi( STR0006 ), cPerg, { |oReport| ReportPrint() }, STR0001 + STR0002 + STR0003 ) //"CID x Funcao"

	//Verifica as perguntas selecionadas / Variaveis utilizadas para parametros
	//-mv_par01 // De Funcao
	//-mv_par02 // Ate Funcao
	//-mv_par03 // De CID
	//-mv_par04 // Ate CID
	//-mv_par05 // De Dt.diagnostico
	//-mv_par06 // Ate Dt. Diagnostico
	//Somente se for prestador de servico:
	//-mv_par07 // De Cliente
	//-mv_par08 // Ate Cliente
	Pergunte( oReport:uParam, .F. )

	//Criacao da secao utilizada pelo relatorio
	//TRSection():New
	//-ExpO1 : Objeto TReport que a secao pertence
	//-ExpC2 : Descricao da seçao
	//-ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela sera considerada como principal para a seção.
	//-ExpA4 : Array com as Ordens do relatório
	//-ExpL5 : Carrega campos do SX3 como celulas / Default : False
	//-ExpL6 : Carrega ordens do Sindex / Default : False

	//Criacao da celulas da secao do relatorio
	//TRCell():New
	//-ExpO1 : Objeto TSection que a secao pertence
	//-ExpC2 : Nome da celula do relatório. O SX3 será consultado
	//-ExpC3 : Nome da tabela de referencia da celula
	//-ExpC4 : Titulo da celula / Default : X3Titulo()
	//-ExpC5 : Picture / Default : X3_PICTURE
	//-ExpC6 : Tamanho / Default : X3_TAMANHO
	//-ExpL7 : Informe se o tamanho esta em pixel / Default : False
	//-ExpB8 : Bloco de código para impressao / Default : ExpC2

	If lSigaMdtps
		oSection0 := TRSection():New( oReport, STR0024, { "TRB", "SA1" } ) //"Cliente"
		oCell	  := TRCell():New( oSection0, "TRB->CLIENTE", "TRB", STR0024, "@!", nTa1 )  //"Cliente"
		oCell	  := TRCell():New( oSection0, "TRB->LOJA", "TRB", STR0027, "@!", nTa1L )  //"Loja"
		oCell	  := TRCell():New( oSection0, "SA1->A1_NOME", "SA1", STR0025, "@!", 40 )  //"Nome"
		TRPosition():New( oSection0, "SA1", 1, { || xFilial( "SA1" ) + TRB->CLIENTE + TRB->LOJA } )
	Else
		If lPrestSX6
			oSection0 := TRSection():New( oReport, STR0024, { "TRB", "SA1" } ) //"Cliente"
			oCell	  := TRCell():New( oSection0, "TRB->CLIENTE", "TRB", STR0024, "@!", 06 )  //"Cliente"
			oCell	  := TRCell():New( oSection0, "SA1->A1_NOME", "SA1", STR0025, "@!", 40 )  //"Nome"
			TRPosition():New( oSection0, "SA1", 1, { || xFilial( "SA1" ) + TRB->CLIENTE } )
		EndIf
	EndIf

	oSection1 := TRSection():New( oReport, STR0014, { "TRB", "SRJ" } ) //Funcao
	oCel1	  := TRCell():New( oSection1, "TRB->CODFUN", "TRB", STR0014, "@!", 10, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Funcao"
	oCel1	  := TRCell():New( oSection1, "RJ_DESC", "SRJ", STR0015, "@!", 40, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Descricao"
	TRPosition():New( oSection1, "SRJ", 1, { || xFilial( "SRJ" ) + TRB->CODFUN } )

	oSection2 := TRSection():New( oReport, STR0010, { "TRB", "TMR" } ) //"C.I.D."
	oCel2	  := TRCell():New( oSection2, "TRB->CID", "TRB", STR0016, "@!", 08 ) //"C.I.D."
	oCel2	  := TRCell():New( oSection2, "TMR_DOENCA", "TMR", STR0015, "@!", 66 ) //"Descricao"
	oCel2	  := TRCell():New( oSection2, "TRB->GRPCID", "TRB", STR0042, "@!", 15 ) //"Grupo C.I.D."
	oCel2	  := TRCell():New( oSection2, "TRB->MASC", "TRB", STR0017, "999999", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Masculino"
	oCell	  := TRCell():New( oSection2, "DELIMIT1", " ", " ", "@!", 02, /*lPixel*/, /*{|| code-block de impressao }*/ )
	oCel2	  := TRCell():New( oSection2, "TRB->FEMI", "TRB", STR0018, "999999", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Feminino"
	TRPosition():New( oSection2, "TMR", 1, { || xFilial( "TMR" ) + TRB->CID } )

	oSection3 := TRSection():New( oReport, STR0010, { "TRB2" } ) //"C.I.D."
	oCel3	  := TRCell():New( oSection3, "TRB2->CID", "TRB2", STR0016, "@!", 08 ) //"C.I.D."
	oCel3	  := TRCell():New( oSection3, "TRB2->QUANTI", "TRB2", STR0043, "999999", 15 ) //"Total Atendimentos"

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio

@return oReport, Objeto do relatório

@sample ReportDef()

@author	Andre E. Perez Alvarez
@since	16/11/2006
/*/
//-------------------------------------------------------------------
Static Function ReportPrint()

	Local aResumo	:= {}
	Local nTotGeral	:= 0
	Local nX
	Local nLinha
	Local cFuncao
	Local nPOS
	Local nTotFun
	Local cCliente

	Private oTempTRB1
	Private oTempTRB2

	Processa( { |lEND| TRBgrava() }, STR0019, STR0020 ) //"Aguarde" ## "Processando os diagnósticos..."

	dbSelectArea( "TRB" )
	dbSetOrder( 1 )
	dbGoTop()

	oReport:SetMeter( RecCount() )
	nX := 1

	If lSigaMdtps

		While !oReport:Cancel() .And. !Eof()
			cCliente	:= TRB->CLIENTE + TRB->LOJA
			aResumo		:= {}
			nTotGeral	:= 0
			oSection0:Init() //Cliente
			oSection0:PrintLine()

			While !oReport:Cancel() .And. !Eof() .And. cCliente == TRB->CLIENTE + TRB->LOJA
				cFuncao := TRB->CODFUN
				nTotFun := 0

				oSection1:Init() //Funcao
				oSection1:PrintLine()
				oSection2:Init() //CID

				While !oReport:Cancel() .And. !Eof() .And. TRB->CODFUN == cFuncao .And. cCliente == TRB->CLIENTE + TRB->LOJA

					oReport:IncMeter()
					oSection2:PrintLine()
					nTotFun += TRB->QUANTI
					If ( nPOS := aSCAN( aResumo, { |x| x[1] + x[2] == TRB->CODFUN + TRB->CID } ) ) == 0
						aAdd( aResumo, { TRB->CODFUN, TRB->CID, 1 } )
					Else
						aResumo[nPOS][3]++
					EndIf

					dbSelectArea( "TRB" )
					dbSkip()
				End

				oReport:SkipLine()
				oReport:PrintText( STR0011 + AllTrim( STR( nTotFun ) ), , ) //"Total de Atendimentos:"
				oReport:SkipLine()

				oSection2:Finish()
				oSection1:Finish()
			End

			dbSelectArea( "TRB2" )
			dbSetOrder( 1 )
			dbGoTop()
			oSection3:Init() //inicia section3
			While !Eof()
				oSection3:PrintLine() //imprime as linhas do Section3
				nTotGeral += TRB2->QUANTI //contador total de atendimento
				dbSkip()
			End

			oReport:SkipLine()
			oReport:PrintText( STR0021 + AllTrim( STR( nTotGeral ) ), , 000 ) //Total Geral: xxxxx

			oSection0:Finish()
		End
	Else
		If !lPrestSX6
			While !oReport:Cancel() .And. !Eof()
				cFuncao := TRB->CODFUN
				nTotFun := 0

				oSection1:Init() //Funcao
				oSection1:PrintLine()
				oSection2:Init() //CID

				While !oReport:Cancel() .And. !Eof() .And. TRB->CODFUN == cFuncao
					oReport:IncMeter()
					oSection2:PrintLine()
					nTotFun += TRB->QUANTI
					If ( nPOS := aSCAN( aResumo, { |x| x[1] + x[2] == TRB->CODFUN + TRB->CID } ) ) == 0
						aAdd( aResumo, { TRB->CODFUN, TRB->CID, 1 } )
					Else
						aResumo[nPOS][3]++
					EndIf

					dbSelectArea( "TRB" )
					dbSkip()
				End

				oReport:SkipLine()
				oReport:PrintText( STR0011 + AllTrim( STR( nTotFun ) ), , ) //"Total de Atendimentos: "
				oReport:SkipLine()

				oSection2:Finish()
				oSection1:Finish()
			End

			dbSelectArea( "TRB2" )
			dbSetOrder( 1 )
			dbGoTop()
			oSection3:Init() //inicia section3
			While !Eof()
				oSection3:PrintLine() //imprime as linhas do Section3
				nTotGeral += TRB2->QUANTI	//contador total de atendimento
				dbSkip()
			End
			oSection3:Finish()//encerra section
			oReport:SkipLine()
			oReport:PrintText( STR0021 + AllTrim( STR( nTotGeral ) ), , 000 ) //Total Geral: xxxxx
		Else
			While !oReport:Cancel() .And. !Eof()
				cCliente  := TRB->CLIENTE
				aResumo	  := {}
				nTotGeral := 0
				oSection0:Init() //Cliente
				oSection0:PrintLine()

				While !oReport:Cancel() .And. !Eof() .And. cCliente == TRB->CLIENTE
					cFuncao := TRB->CODFUN
					nTotFun := 0

					oSection1:Init() //Funcao
					oSection1:PrintLine()
					oSection2:Init() //CID

					While !oReport:Cancel() .And. !Eof() .And. TRB->CODFUN == cFuncao .And. cCliente == TRB->CLIENTE
						oReport:IncMeter()
						oSection2:PrintLine()
						nTotFun += TRB->QUANTI
						If ( nPOS := aSCAN( aResumo, { |x| x[1] + x[2] == TRB->CODFUN + TRB->CID } ) ) == 0
							aAdd( aResumo, { TRB->CODFUN, TRB->CID, 1 } )
						Else
							aResumo[nPOS][3]++
						EndIf

						dbSelectArea( "TRB" )
						dbSkip()
					End

					oReport:SkipLine()
					oReport:PrintText( STR0011 + AllTrim( STR( nTotFun ) ), , ) //"Total de Atendimentos: "
					oReport:SkipLine()

					oSection2:Finish()
					oSection1:Finish()
				End

				//Imprime Total do Cliente
				oReport:SkipLine()
				oReport:FatLine()
				oReport:SkipLine()

				dbSelectArea( "TRB2" )
				dbSetOrder( 1 )
				dbSeek( cCliente )
				While !Eof() .AND. cCliente == TRB2->CLIENTE
					nLinha := oReport:nRow //Usar a mesma linha corrente
					oReport:PrintText( STR0023 + TRB2->CID, nLinha, 10 ) //C.I.D.: XXXXX
					oReport:PrintText( STR0011 + AllTrim( STR( TRB2->QUANTI ) ), nLinha, 500 ) //Total de Atendimentos: xxxxx
					nTotGeral += TRB2->QUANTI
					oReport:SkipLine()
					dbSelectArea( "TRB2" )
					dbSkip()
				End

				oReport:SkipLine()
				oReport:PrintText( STR0021 + AllTrim( Str( nTotGeral ) ), , 500 ) //Total Geral: xxxxx

				oSection0:Finish()
			End
		EndIf
	EndIf

	If TRB->( RecCount() ) == 0
		MsgInfo( STR0033 ) //"Não há nada para imprimir no relatório."
		oTempTRB1:Delete()
		oTempTRB2:Delete()
		Return .F.
	EndIf

	oTempTRB1:Delete()
	oTempTRB2:Delete()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava
Processa os registros de acordo com os parametros e grava no arquivo temporario.

@return oReport, Objeto do relatório

@sample ReportDef()

@author	Andre E. Perez Alvarez
@since	13/12/2006
/*/
//-------------------------------------------------------------------
Static Function TRBgrava()

	Local aDBF		:= {}
	Local aDBF2		:= {}
	Local cSelect

	Private cAliasTMT := GetNextAlias()

	// Filtra os registros da tabela TL5
	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR09
		xm_par6 := MV_PAR10

		cSelect := "%TMT.TMT_CODFUN, TMT.TMT_CID, TMT_GRPCID, TMT_NUMFIC, TMT.TMT_CC, TM0.TM0_SEXO,TMT_CID2, TMT_GRPCI2, TMT_DTCONS, TMT_HRCONS,"
		cSelect	+= "TMT_CLIENT, TMT_LOJA%"
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR05
		xm_par6 := MV_PAR06

		cSelect := "%TMT.TMT_CODFUN, TMT.TMT_CID, TMT_GRPCID, TMT_NUMFIC, TMT.TMT_CC, TM0.TM0_SEXO,TMT_CID2, TMT_GRPCI2, TMT_DTCONS, TMT_HRCONS%"
	EndIf

	cTamCOD := Space( TAMSX3( "TMT_CODFUN" )[1] ) //Tamanho do campo de função
	cTamCID := Space( TAMSX3( "TMT_CID" )[1] ) //Tamanho do campo de CID

	BeginSQL Alias cAliasTMT
		SELECT %Exp:cSelect%
			FROM %Table:TMT% TMT
			INNER JOIN %Table:TM0% TM0 ON TMT.TMT_FILIAL = TM0.TM0_FILIAL AND TMT.TMT_NUMFIC = TM0.TM0_NUMFIC AND TM0.%NotDel%
			WHERE TMT_FILIAL = %xFilial:TMT% AND
				TMT_CODFUN <> %Exp:cTamCOD% AND //Verifica se campo esta preenchido
				TMT_CODFUN BETWEEN %Exp:xm_par1% AND %Exp:xm_par2% AND
				TMT_CID <> %Exp:cTamCID% AND //Verifica se campo esta preenchido
				TMT_CID BETWEEN %Exp:xm_par3% AND %Exp:xm_par4% AND
				TMT_DTATEN BETWEEN %Exp:xm_par5% AND %Exp:xm_par6% AND
				TMT.%notDel%
			ORDER BY TMT.TMT_FILIAL, TMT.TMT_CODFUN, TMT.TMT_CID
	EndSQL

	//Cria arquivo temporario
	aDBF :=	{ { "CODFUN", "C", 05, 0 },;
			{ "CID", "C", 08, 0 },;
			{ "MASC", "N", 06, 0 },;
			{ "FEMI", "N", 06, 0 },;
			{ "QUANTI", "N", 14, 0 },;
			{ "GRPCID", "C", 03, 0 } }

	If lSigaMdtPs
		aAdd( aDBF, {"CLIENTE", "C", nTa1} )
		aAdd( aDBF, {"LOJA", "C", nTa1L} )
	Else
		If lPrestSX6
			aAdd( aDBF, { "CLIENTE", "C", 06 } )
		EndIf
	EndIf

	oTempTRB1 := FWTemporaryTable():New( "TRB", aDBF )

	If lSigaMdtPs
		oTempTRB1:AddIndex( "1", { "CLIENTE", "LOJA", "CODFUN", "CID" } )
	Else
		If !lPrestSX6
			oTempTRB1:AddIndex( "1", { "CODFUN", "CID" } )
		Else
			oTempTRB1:AddIndex( "1", { "CLIENTE", "CODFUN", "CID" } )
		EndIf
	EndIf

	oTempTRB1:Create()

	//Cria arquivo temporario
	aDBF2 := { { "CID", "C", 08, 0 },;
			{ "QUANTI", "N", 14, 0 },;
			{ "GRPCID", "C", 03, 0 } }

	If lSigaMdtPs
		aAdd( aDBF2, { "CLIENTE", "C", nTa1 } )
		aAdd( aDBF2, { "LOJA", "C", nTa1L } )
	Else
		If lPrestSX6
			aAdd( aDBF2, { "CLIENTE", "C", 06 } )
		EndIf
	EndIf

	oTempTRB2 := FWTemporaryTable():New( "TRB2", aDBF2 )

	If lSigaMdtPs
		oTempTRB2:AddIndex( "1", { "CLIENTE", "LOJA", "CID" } )
	Else
		If !lPrestSX6
			oTempTRB2:AddIndex( "1", { "CID" } )
		Else
			oTempTRB2:AddIndex( "1", { "CLIENTE", "CID" } )
		EndIf
	EndIf

	oTempTRB2:Create()

	ProcRegua( Contar( cAliasTMT, "!Eof()" ) ) //Define a régua de processamento

	//Grava os dados no arquivo temporario
	dbSelectArea( cAliasTMT )
	dbGoTop()

	If lSigaMdtps

		While ( cAliasTMT )->( !Eof() )

			IncProc() //Incrementa a régua

			cCliente := ( cAliasTMT )->TMT_CLIENT + ( cAliasTMT )->TMT_LOJA

			dbSelectArea( "TRB" )
			If !dbSeek( cCliente + ( cAliasTMT )->TMT_CODFUN + ( cAliasTMT )->TMT_CID )
				TRB->( dbAppend() )
				TRB->CODFUN := ( cAliasTMT )->TMT_CODFUN
				TRB->CID    := ( cAliasTMT )->TMT_CID
				TRB->GRPCID := ( cAliasTMT )->TMT_GRPCID
				If TM0->TM0_SEXO == '1'
					TRB->MASC := 1
					TRB->FEMI := 0
				Else
					TRB->MASC := 0
					TRB->FEMI := 1
				EndIf

				TRB->CLIENTE := ( cAliasTMT )->TMT_CLIENT
				TRB->LOJA    := ( cAliasTMT )->TMT_LOJA
				TRB->QUANTI++
			Else
				RecLock( "TRB", .F. )
				If TM0->TM0_SEXO == '1'
					TRB->MASC++
				Else
					TRB->FEMI++
				EndIf
				TRB->QUANTI++
				MsUnlock( "TRB" )
			EndIf

			dbSelectArea( "TRB2" )
			If !dbSeek( cCliente + ( cAliasTMT )->TMT_CID )
				TRB2->( dbAppend() )
				TRB2->CLIENTE	:= ( cAliasTMT )->TMT_CLIENT
				TRB2->LOJA		:= ( cAliasTMT )->TMT_LOJA
				TRB2->CID		:= ( cAliasTMT )->TMT_CID
				TRB2->GRPCID	:= ( cAliasTMT )->TMT_GRPCID
				TRB2->QUANTI	:= 1
			Else
				RecLock( "TRB2", .F. )
				TRB2->QUANTI++
				MsUnlock( "TRB2" )
			EndIf

	    	//------------------------------------------------------------------
	    	// Implementação, define que o relatório deve considerar, não os
	    	// Cid's do campo TMT_CID, mas também o campo TMT_CID2 e os Cids,
	    	// complementares que foram relacionados na tabela TKJ, dessa forma
	    	// fica a cargo da função abaixo realizar a inclusão destes Cids na
	    	// TRB, tendo como pré requisito, estar posicionado no diagnóstico da
	    	// TMT
	    	//------------------------------------------------------------------
			MDT420PRC2()

			dbSelectArea( cAliasTMT )
			( cAliasTMT )->( dbSkip() )
		End
	Else
		If !lPrestSX6
			While ( cAliasTMT )->( !Eof() )

				IncProc() //Incrementa a régua

				dbSelectArea( "TRB" )
				If !dbSeek( ( cAliasTMT )->TMT_CODFUN + ( cAliasTMT )->TMT_CID )
					TRB->( dbAppend() )
					TRB->CODFUN := ( cAliasTMT )->TMT_CODFUN
					TRB->CID    := ( cAliasTMT )->TMT_CID
					TRB->GRPCID := ( cAliasTMT )->TMT_GRPCID
					If ( cAliasTMT )->TM0_SEXO = '1'
						TRB->MASC := 1
						TRB->FEMI := 0
					Else
						TRB->MASC := 0
						TRB->FEMI := 1
					EndIf
					TRB->QUANTI := 1
				Else
					RecLock( "TRB", .F. )
					If ( cAliasTMT )->TM0_SEXO == '1'
						TRB->MASC++
					Else
						TRB->FEMI++
					EndIf
					TRB->QUANTI++
					MsUnlock( "TRB" )
				EndIf

				dbSelectArea( "TRB2" )
				If !dbSeek( ( cAliasTMT )->TMT_CID )
					TRB2->( dbAppend() )
					TRB2->CID    := ( cAliasTMT )->TMT_CID
					TRB2->QUANTI := 1
					TRB2->GRPCID := ( cAliasTMT )->TMT_GRPCID
				Else
					RecLock( "TRB2", .F. )
					TRB2->QUANTI++
					MsUnlock( "TRB2" )
				EndIf

			    //Preenche TRB com Cids Complementares
				MDT420PRC2()

				dbSelectArea( cAliasTMT )
				( cAliasTMT )->( dbSkip() )
			End
		Else
			While ( cAliasTMT )->( !Eof() )

				IncProc() //Incrementa a régua

				dbSelectArea( "TRB" )
				If !dbSeek( ( cCliente := SubStr( ( cAliasTMT )->TMT_CC, 1, 6 ) ) + ( cAliasTMT )->TMT_CODFUN + ( cAliasTMT )->TMT_CID )
					TRB->( dbAppend() )
					TRB->CODFUN := ( cAliasTMT )->TMT_CODFUN
					TRB->CID    := ( cAliasTMT )->TMT_CID
					If ( cAliasTMT )->TM0_SEXO == '1'
						TRB->MASC := 1
						TRB->FEMI := 0
					Else
						TRB->MASC := 0
						TRB->FEMI := 1
					EndIf

					TRB->CLIENTE := cCliente
					TRB->QUANTI ++
				Else
					RecLock( "TRB", .F. )
					If ( cAliasTMT )->TM0_SEXO == '1'
						TRB->MASC++
					Else
						TRB->FEMI++
					EndIf
					TRB->QUANTI++
					MsUnlock( "TRB" )
				EndIf

				dbSelectArea( "TRB2" )
				If !dbSeek( ( cCliente := SubStr( ( cAliasTMT )->TMT_CC, 1, 6 ) ) + ( cAliasTMT )->TMT_CID )
					TRB2->( dbAppend() )
					TRB2->CLIENTE := cCliente
					TRB2->CID     := ( cAliasTMT )->TMT_CID
					TRB2->QUANTI  := 1
				Else
					RecLock( "TRB2", .F. )
					TRB2->QUANTI++
					MsUnlock( "TRB2" )
				EndIf

				dbSelectArea( cAliasTMT )
				( cAliasTMT )->( dbSkip() )
			End
		EndIf
	EndIf

	( cAliasTMT )->( dbCloseArea() )

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT420Fun
Valida a pergunta Ate Funcao

@return lRet, Boolean, Verdadeiro se o valor digitado é válido

@sample U_MDT420Fun()

@author	Andre E. Perez Alvarez
@since	29/11/2006
/*/
//-------------------------------------------------------------------
User Function MDT420Fun()

	Local lRet	  := .F.
	Local cDeFun  := IIf( lSigaMdtPs, mv_par05, mv_par01 )
	Local cAteFun := IIf( lSigaMdtPs, mv_par06, mv_par02 )

	If cAteFun == Replicate( "Z", 5 )
		lRet := .T.
	Else
		lRet := ExistCPO( 'SRJ', cAteFun ) .And. AteCodigo( "SRJ", cDeFun, cAteFun, 5 )
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT420Cid
Valida a pergunta Ate CID

@return lRet, Boolean, Verdadeiro se o valor digitado é válido

@sample U_MDT420Cid()

@author	Andre E. Perez Alvarez
@since	29/11/2006
/*/
//-------------------------------------------------------------------
User Function MDT420Cid()

	Local lRet := .F.
	Local cDeCID  := IIf( lSigaMdtPs, mv_par07, mv_par03 )
	Local cAteCID := IIf( lSigaMdtPs, mv_par08, mv_par04 )

	If cAteCID == Replicate( "Z", 8 )
		lRet := .T.
	Else
		lRet := ExistCPO( 'TMR', cAteCID ) .And. AteCodigo( "TMR", cDeCID, cAteCID, 8 )
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT420Cli
Valida a pergunta Ate Cliente

@return lRet, Boolean, Verdadeiro se o valor digitado é válido

@sample U_MDT420Cid()

@author	Andre E. Perez Alvarez
@since	29/11/2006
/*/
//-------------------------------------------------------------------
User Function MDT420Cli()

	Local lRet := IIf( mv_par08 == Replicate( "Z", 6 ), .T., ExistCPO( 'SA1', mv_par08 ) .And. AteCodigo( 'SA1', mv_par07, mv_par08, 6 ) )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR420R3
Relatorio das doencas diagnosticadas por funcao.

@return Nil, Nulo

@sample U_MDTR420R3()

@author	Marcio Costa
@since	12/01/2000
/*/
//-------------------------------------------------------------------
User Function MDTR420R3()

	Local wnrel   := "MDTR420"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio de apresentacao das doencas por funcao. Baseado nos"
	Local cDesc2  := STR0002 //"diagnostigos emitidos  pelos medicos, para os funcionarios."
	Local cDesc3  := STR0003 //"Atraves dos parametros podera ser selecionada funcao e/ou o CID."
	Local cString := "TMT"

	Private nomeprog := "MDTR420"
	Private tamanho  := "P"
	Private aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "", 1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0006 //"CID x Funcao"
	Private ntipo    := 0
	Private nLastKey := 0
	Private nMasc    := 0
	Private nFemin   := 0
	Private cCodfun  := Space( 5 )
	Private cCid     := Space( 8 )
	Private nSizeSRJ := IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 4, ( TAMSX3( "RJ_FUNCAO" )[1] ) )
	Private cabec1
	Private cabec2

	//Verifica as perguntas selecionadas
	pergunte( cPerg, .F. )

	//Variaveis utilizadas para parametros
	//-mv_par01 / De Funcao
	//-mv_par02 / Ate Funcao
	//-mv_par03 / De CID
	//-mv_par04 / Ate CID
	//-mv_par05 / De Dt.diagnostico
	//-mv_par06 / Ate Dt. Diagnostico
	//Somente se for prestador de servico:
	//-mv_par07 / De Cliente
	//-mv_par08 / Ate Cliente

	wnrel := "MDTR420"

	WnRel := SetPrint( cString, WnRel, cPerg, titulo, cDesc1, cDesc2, cDesc3, .F., "", .F., 'P' )

	If nLastKey == 27
		Set Filter to
		Return
	EndIf

	SetDefault( aReturn, cString )

	If nLastKey == 27
		Set Filter to
		Return
	EndIf

	RptStatus( { |lEnd| R420Imp( @lEnd, wnRel, titulo, tamanho ) }, titulo )

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} R420Imp
Chamada do relatório

@return Nil, Nulo

@sample R420Imp()

@author	Marcio Costa
@since	12/01/2000
/*/
//-------------------------------------------------------------------
Static Function R420Imp( lEnd, wnRel, titulo, tamanho )

	Local cRodaTxt := ""
	Local nCntImpr := 0

	//Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs := 0
	Local nMult := 1
	Local nPosAnt := 4
	Local nPosAtu := 4
	Local nPosCnt := 0

	//Variaveis locais exclusivas deste programa
	Local cChave	:= Space(16)
	Local lContinua	:= .T.

	//Contadores de linha e pagina
	Private li := 80
	Private m_pag := 1

	//Verifica se deve comprimir ou nao
	nTipo := IIf( aReturn[4] ==1, 15, 18 )

	//Monta os Cabecalhos
	cabec1 := STR0007 //"Funcao  Descricao                             "
	cabec2 := STR0010 //"        C.I.D.     Descricao                                 Masc.       Fem."

	/*
	1         2         3         4         5         6         7         8         9         0         1         2         3
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	-------------------------------------------------------------------------------------------------------------------------------------
	Funcao  Descricao
	C.I.D.     Descricao                                 Masc.      Fem.
	-------------------------------------------------------------------------------------------------------------------------------------

	xxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	xxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx.xxx     xx.xxx
	*/

	Processa( { |lEND| TRBgrava() }, STR0019, STR0020 ) //"Aguarde" ## "Processando os diagnósticos..."

	If lSigaMdtps

		lPrint  := .F.

		dbSelectArea("TRB")
		dbGoTop()

		While !EoF()
			cCliente := TRB->CLIENTE + TRB->LOJA
			lPrint := .T.

			While !Eof() .And. TRB->CLIENTE + TRB->LOJA == cCliente
				cFUNCAO := TRB->CODFUN
				dbSelectArea( "SRJ" )
				dbSetOrder( 01 )
				dbSeek( xFilial( "SRJ" ) + cFUNCAO )
				If lPrint
					li := 80
					dbSelectArea( "SA1" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SA1" ) + cCliente )
					Somalinha()
					@Li, 000 PSAY STR0034 + AllTrim( SA1->A1_COD ) + "-" + AllTrim( SA1->A1_LOJA ) + " - " + Alltrim( SA1->A1_NOME ) //"Cliente/Loja: "
					Somalinha()
					lPrint := .F.
				EndIf

				SomaLinha()
				@ Li, 000 PSay cFUNCAO PICTURE "@!"
				@ Li, 008 PSay SRJ->RJ_DESC

				dbSelectArea( "TRB" )
				nQtafun := 0
				nQtatot := 0

				While !Eof() .And. TRB->CLIENTE + TRB->LOJA == cCliente .And. cFUNCAO == TRB->CODFUN
					cCID := TRB->CID
					dbSelectArea( "TMR" )
					dbSetOrder( 01 )
					dbSeek( xFilial( "TMR" ) + cCID )
					SomaLinha()
					@ Li, 008 PSay cCID PICTURE "@!"
					@ Li, 019 PSay SubStr( TMR->TMR_DOENCA, 1, 27 )
					@ Li, 047 PSay SubStr( TRB->GRPCID, 1, 3 )

					dbSelectArea( "TRB" )
					nQtaten := 0
					While !Eof() .And. TRB->CLIENTE + TRB->LOJA == cCliente .And. cFUNCAO == TRB->CODFUN .And. cCID == TRB->CID
						@ Li, 064 PSay TRB->MASC  PICTURE '999'
						@ Li, 075 PSay TRB->FEMI  PICTURE '999'
						nQtaten := nQtaten + TRB->MASC + TRB->FEMI
						nQtafun += nQtaten
						dbSelectArea( "TRB" )
						dbSkip()
					End
				End

				If nQtafun != 0
					Somalinha()
					Somalinha()
					@ Li, 000 PSay STR0011 + Alltrim( Str( nQtafun ) ) //"Total de Atendimentos.: "
					Somalinha()
				EndIf
			End

			Somalinha()
			dbSelectArea( "TRB2" )
			dbSeek( cCliente )

			@Li, 000 PSAY STR0016 //"C.I.D."
			@Li, 043 PSAY STR0043 //"Total Atendimento"

			Somalinha()
			While !Eof() .And. TRB2->CLIENTE + TRB2->LOJA == cCliente
				@Li, 000 PSAY Alltrim( TRB2->CID )
				@Li, 047 PSAY TRB2->QUANTI Picture "@E 99999999999999"
				nQtatot := nQtatot + TRB2->QUANTI
				Somalinha()
				dbSkip()
			End

			Somalinha()
			@Li,027 PSAY STR0013 //"TOTAL GERAL.: "
			@Li,043 PSAY Alltrim( Str( nQtatot ) )

			dbSelectArea("TRB")
		End
	Else
		cCondicao  := "!Eof()"
		cCondicao2 := "!Eof() .And. cFUNCAO == TRB->CODFUN"
		cCondicao3 := "!Eof() .And. cFUNCAO == TRB->CODFUN .And. cCID == TRB->CID"

		If lPrestSX6
			cCondicao  := "!Eof() .And. TRB->CLIENTE == cCliente"
			cCondicao2 := "!Eof() .And. TRB->CLIENTE == cCliente .And. cFUNCAO == TRB->CODFUN"
			cCondicao3 := "!Eof() .And. TRB->CLIENTE == cCliente .And. cFUNCAO == TRB->CODFUN .And. cCID == TRB->CID"
		EndIf

		lPrint := .F.

		dbSelectArea( "TRB" )
		dbGoTop()
		While !Eof()

			If lPrestSX6
				cCliente := TRB->CLIENTE
			EndIf

			lPrint := .T.

			While &cCondicao
				cFUNCAO := TRB->CODFUN
				dbSelectArea( "SRJ" )
				dbSetOrder( 01 )
				dbSeek( xFilial( "SRJ" ) + cFUNCAO )
				If lPrestSX6 .And. lPrint
					li := 80
					dbSelectArea( "SA1" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SA1" ) + TRB->CLIENTE )
					Somalinha()
					@Li, 000 PSAY STR0009 //"Cliente..:"
					@Li, 011 PSay Alltrim( TRB->CLIENTE ) + " - " + Alltrim( SA1->A1_NOME )
					Somalinha()
					lPrint := .F.
				EndIf

				SomaLinha()
				@ Li,000 PSay cFUNCAO PICTURE "@!"
				@ Li,008 PSay AllTrim(SRJ->RJ_DESC)

				dbSelectArea("TRB")
				nQtafun := 0
				nQtatot := 0

				While &cCondicao2
					cCID := TRB->CID
					dbSelectArea( "TMR" )
					dbSetOrder( 01 )
					dbSeek( xFilial( "TMR" ) + cCID )
					SomaLinha()
					@ Li, 008 PSay cCID PICTURE "@!"
					@ Li, 019 PSay SubStr( TMR->TMR_DOENCA, 1, 27 )
					@ Li, 047 PSay SubStr( TRB->GRPCID, 1, 3 )
					dbSelectArea( "TRB" )
					nQtaten := 0
					While &cCondicao3
						@ Li, 064 PSay TRB->MASC  PICTURE '999'
						@ Li, 075 PSay TRB->FEMI  PICTURE '999'
						nQtaten := nQtaten + TRB->MASC + TRB->FEMI
						nQtafun += nQtaten
						dbSelectArea( "TRB" )
						dbSkip()
					End
				End

				If nQtafun != 0
					Somalinha()
					Somalinha()
					@ Li,000 PSay STR0011 + Alltrim( Str( nQtafun ) ) //"Total de Atendimentos.: "
					Somalinha()
				EndIf
			End
			Somalinha()
			If lPrestSX6
				dbSelectArea( "TRB2" )
				dbGoTop()
				@Li, 000 PSAY STR0016//"C.I.D."
				@Li, 043 PSAY STR0043//"Total Atendimento"
				Somalinha()

				While !Eof() .And. TRB2->CLIENTE == cCliente
					@Li, 000 PSAY Alltrim( TRB2->CID )
					@Li, 047 PSAY TRB2->QUANTI Picture "@E 99999999999999"
					nQtatot := nQtatot + TRB2->QUANTI
					Somalinha()
					dbSkip()
				End
			Else
				dbSelectArea( "TRB2" )
				dbGoTop()
				@Li, 000 PSAY STR0016//"C.I.D."
				@Li, 043 PSAY STR0043//"Total Atendimento"

				Somalinha()
				While !Eof()
					@Li, 000 PSAY Alltrim( TRB2->CID )
					@Li, 047 PSAY TRB2->QUANTI Picture "@E 99999999999999"
					nQtatot := nQtatot + TRB2->QUANTI
					Somalinha()
					dbSkip()
				End
			EndIf
			Somalinha()
			@Li, 027 PSAY STR0013 //"TOTAL GERAL.: "
			@Li, 043 PSAY Alltrim( Str( nQtatot ) )
		End
	EndIf

	//Devolve a condicao original do arquivo principal
	RetIndex( "TMT" )
	Set Filter To

	Set device To Screen

	If TRB->( RecCount() ) == 0
		MsgInfo( STR0033 ) //"Não há nada para imprimir no relatório."
		dbSelectArea( "TRB" )
		Use
		dbSelectArea( "TRB2" )
		Use
		Return .F.
	EndIf

	If aReturn[5] == 1
		Set Printer To
		dbCommitAll()
		OurSpool( wnrel )
	EndIf

	dbSelectArea( "TRB" )
	Use
	dbSelectArea( "TRB2" )
	Use
	dbSelectArea( "TMT" )
	dbSetOrder( 01 )

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha e Controla Salto de Pagina

@return Nil, Nulo

@sample SomaLinha()

@author	Inacio Luiz Kolling
@since	01/06/97
/*/
//-------------------------------------------------------------------
Static Function Somalinha()

	Li++

	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT420PRC2
Insere na TRB os Cid's complementares do diagnóstico posicionado.

@return Nil

@author André Felipe Joriatti
@since 28/11/2012
/*/
//---------------------------------------------------------------------
Static Function MDT420PRC2()

	Local aArea		:= GetArea()
	Local cSTRBTMT  := IIf( lSigaMdtPs, "cCliente + TMT->TMT_CODFUN + TMT->TMT_CID2","TMT->TMT_CODFUN + TMT->TMT_CID2" )
	Local cSTRBTKJ  := IIf( lSigaMdtPs, "cCliente + TMT->TMT_CODFUN + TKJ->TKJ_CID", "TMT->TMT_CODFUN + TKJ->TKJ_CID" )
	Local cSTRB2TMT := IIf( lSigaMdtPs, "cCliente + TMT->TMT_CID2", "TMT->TMT_CID2" )
	Local cSTRB2TKJ := IIf( lSigaMdtPs, "cCliente + TKJ->TKJ_CID", "TKJ->TKJ_CID" )

	If !Empty( ( cAliasTMT )->TMT_CID2 )

		dbSelectArea( "TRB" )
		If !dbSeek( &( cSTRBTMT ) )
			TRB->( dbAppend() )
			TRB->CODFUN := ( cAliasTMT )->TMT_CODFUN
			TRB->CID    := ( cAliasTMT )->TMT_CID2
			TRB->GRPCID := ( cAliasTMT )->TMT_GRPCI2

			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TM0" ) + ( cAliasTMT )->TMT_NUMFIC )
			If TM0->TM0_SEXO == '1'
				TRB->MASC := 1
				TRB->FEMI := 0
			Else
				TRB->MASC := 0
				TRB->FEMI := 1
			EndIf

			If lSigaMdtPs
				TRB->CLIENTE := ( cAliasTMT )->TMT_CLIENT
				TRB->LOJA    := ( cAliasTMT )->TMT_LOJA
			EndIf

			TRB->QUANTI++
	    Else
			dbSelectArea( "TM0" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TM0" ) + ( cAliasTMT )->TMT_NUMFIC )
			RecLock( "TRB", .F. )
			If TM0->TM0_SEXO == '1'
				TRB->MASC++
			Else
				TRB->FEMI++
			EndIf
			TRB->QUANTI++
			MsUnlock( "TRB" )
	    EndIf

	    dbSelectArea( "TRB2" )
		If !dbSeek( &( cSTRB2TMT ) )
			TRB2->( dbAppend() )
			If lSigaMdtPs
				TRB2->CLIENTE := ( cAliasTMT )->TMT_CLIENT
				TRB2->LOJA := ( cAliasTMT )->TMT_LOJA
			EndIf
			TRB2->CID     := ( cAliasTMT )->TMT_CID2
			TRB2->GRPCID  := ( cAliasTMT )->TMT_GRPCID
			TRB2->QUANTI  := 1
		Else
			RecLock("TRB2",.F.)
			TRB2->QUANTI++
			MsUnlock( "TRB2" )
		EndIf

	EndIf

	dbSelectArea( "TKJ" )
	dbSetOrder( 1 ) // TKJ_FILIAL+TKJ_NUMFIC+DTOS(TKJ_DTCONS)+TKJ_HRCONS+TKJ_GRPCID+TKJ_CID
	dbSeek( xFilial( "TKJ" ) + ( cAliasTMT )->TMT_NUMFIC + ( cAliasTMT )->TMT_DTCONS + ( cAliasTMT )->TMT_HRCONS )
	While !EoF() .And. TKJ->TKJ_FILIAL + TKJ->TKJ_NUMFIC + DTOS( TKJ->TKJ_DTCONS ) + TKJ->TKJ_HRCONS == ;
						xFilial( "TKJ" ) + ( cAliasTMT )->TMT_NUMFIC + ( cAliasTMT )->TMT_DTCONS + ( cAliasTMT )->TMT_HRCONS

		dbSelectArea( "TRB" )
		If !dbSeek( &( cSTRBTKJ ) )
			TRB->( dbAppend() )
			TRB->CODFUN := ( cAliasTMT )->TMT_CODFUN
			TRB->CID    := TKJ->TKJ_CID
			TRB->GRPCID := TKJ->TKJ_GRPCID
			If TM0->TM0_SEXO == '1'
				TRB->MASC := 1
				TRB->FEMI := 0
			Else
				TRB->MASC := 0
				TRB->FEMI := 1
			EndIf

			If lSigaMdtPs
				TRB->CLIENTE := ( cAliasTMT )->TMT_CLIENT
				TRB->LOJA    := ( cAliasTMT )->TMT_LOJA
			EndIf

			TRB->QUANTI++
		Else
			If TM0->TM0_SEXO == '1'
				TRB->MASC++
			Else
				TRB->FEMI++
			EndIf
			TRB->QUANTI++
			MsUnlock( "TRB" )
		EndIf

		dbSelectArea( "TRB2" )
		If !dbSeek( &( cSTRB2TKJ ) )
			TRB2->( dbAppend() )
			If lSigaMdtPs
				TRB2->CLIENTE := ( cAliasTMT )->TMT_CLIENT
				TRB2->LOJA    := ( cAliasTMT )->TMT_LOJA
			EndIf
			TRB2->CID     := TKJ->TKJ_CID
			TRB2->GRPCID  := TKJ->TKJ_GRPCID
			TRB2->QUANTI  := 1
		Else
			RecLock( "TRB2", .F. )
			TRB2->QUANTI++
			MsUnlock( "TRB2" )
		EndIf

		dbSelectArea( "TKJ" )
		dbSkip()
	End

	RestArea( aArea )

Return
