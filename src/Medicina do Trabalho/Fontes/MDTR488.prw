/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR488.ch"
#INCLUDE "MSOLE.CH"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR488
 Resultado dos Exames de Audiometria
 Lista as frequencias e quantidade de decibeis referente a
 audicao do funcionario em cada frequencia, demostra este
 resultado em forma de grafico individualmente por orelha.
 Atraves dos parametros o usuario podera selecionar a matri-
 cula do funcionario, o codigo do exame e a data da realiza-
 cao desejada. Com base nos parametro o programa ira obter
 as informacoes da tabela de resultado dos exames dos funcio-
 narios (TM5), e para cada exame que atender os parametros e
 cujo a data do resultado estiver entre o intervalo solicita-
 do, o programa devera ler a tabela de resultados dos exames
 de audiometria, obter as informacoes e imprimir conforme
 modelo neste programa, observando o simbolo conforme o a via
 em que foi realizado o exame.

@author  Marcio Costa
@since   12/01/2000
@sample  U_MDTR488()
@return  Lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function MDTR488()

	//Guarda conteudo e declara variaveis padroes
	Local aNGBEGINPRM := NGBEGINPRM()

	lSigaMdtPS := IIf( SuperGetMv( "MV_MDTPS", .F., "N" ) == "S", .T., .F. )

	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux
	Private aVetinr := {}

	// Define o cabecalho da tela de baixas
	Private aRotina := MenuDef()

	If !MDTRESTRI( cPrograma )
		//----------------------------------------------
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		//----------------------------------------------
		NGRETURNPRM( aNGBEGINPRM )
		Return .F.
	EndIf

	If lSigaMdtps
		cCadastro := OemtoAnsi( STR0090 )  //"Clientes"

		DbSelectArea( "SA1" )
		DbSetOrder( 1 )

		mBrowse( 6, 1, 22, 75, "SA1" )
	Else
		cCadastro := OemToAnsi( STR0004 ) //"Ficha Medica"

		// Endereca a funcao de BROWSE
		mBrowse( 6, 1, 22, 75, "TM0" )

		// Recupera a Ordem Original do arquivo principal
		dbSelectArea( "TM0" )
		dbSetOrder( 1 )
	EndIf

	// Retorna conteudo de variaveis padroes
	NGRETURNPRM( aNGBEGINPRM )
Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTREXA
Monta um browse dos Exames

@author  Inacio Luiz Kolling
@since   27/04/2000
@sample  U_MDTREXA()
@return  Nil, nulo
/*/
//-------------------------------------------------------------------
User Function MDTREXA()

	Local OldRot
	Local OldCad := cCadastro
	Local oTempTRB
	Local bBloco1 := FIELDBLOCK( "(cAliasTRB)->TM9_ODRESU" )
	Local bBloco2 := FIELDBLOCK( "(cAliasTRB)->TM9_DESVIA" )
	Local bBloco3 := FIELDBLOCK( "(cAliasTRB)->TM9_ODREFE" )
	Local bBloco4 := FIELDBLOCK( "(cAliasTRB)->TM9_OERESU" )
	Local bBloco5 := FIELDBLOCK( "(cAliasTRB)->TM9_OEREFE" )
	Local nTamExa := IIf( TAMSX3( "TM4_EXAME" )[1] < 1, 6, TAMSX3( "TM4_EXAME" )[1] )
	Private aVetinr := {}
	Private cAliasTRB := GetNextAlias()

	OldRot := aCLONE( aROTINA )

	Private cFilTM9 := xFilial( "TM9" )
	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux

	If ExistBlock( "VR488IMP" )
		aRotina := { { STR0006, "U_VR488IMP", 0, 1} } //"Imprimir"
	Else
		aRotina := { { STR0006, "MDTR488IMP", 0, 1} } //"Imprimir"
	EndIf

	cCadastro := OemToAnsi( STR0088 )  //"Resultados dos Exames de Audiometria"
	lInverte:= .F.
	cMARCA  := GetMark()
	lQuery := .T.

	dbSelectArea( "TM9" )

	aDBF := {}
	AADD( aDBF, { "TM9_OK", "C", 02, 0 } )
	AADD( aDBF, { "TM9_NUMFIC", "C", 09, 0 } )
	AADD( aDBF, { "TM9_EXAME", "C", nTamExa, 0 } )
	AADD( aDBF, { "TM9_DTPROG", "D", 08, 0 } )
	AADD( aDBF, { "TM9_HRPROG", "C", 05, 0 } )
	AADD( aDBF, { "TM9_EQPTO", "C", 06, 0 } )
	AADD( aDBF, { "TM9_INDVIA", "C", 01, 0 } )
	AADD( aDBF, { "TM9_DESVIA", "C", 11, 0 } )
	AADD( aDBF, { "TM9_ODREFE", "C", 03, 0 } )
	AADD( aDBF, { "TM9_ODRESU", "C", 28, 0 } )
	AADD( aDBF, { "TM9_OEREFE", "C", 03, 0 } )
	AADD( aDBF, { "TM9_OERESU", "C", 28, 0 } )

	aTRB9 := {}
	AADD( aTRB9, { "TM9_OK", NIL, " ", } )
	AADD( aTRB9, { "TM9_NUMFIC", NIL, STR0004, } ) //"Ficha Médica"
	AADD( aTRB9, { "TM9_EXAME", NIL, STR0003, } ) //"Exame"
	AADD( aTRB9, { "TM9_DTPROG", NIL, STR0047, } ) //"Data Exame"
	AADD( aTRB9, { "TM9_HRPROG", NIL, STR0052, } )	//"Horário Exame"
	AADD( aTRB9, { "TM9_EQPTO", NIL, STR0048, } ) //"Equipamento"
	AADD( aTRB9, { "TM9_DESVIA", NIL, STR0049, } ) //"Via Condução"
	AADD( aTRB9, { "TM9_ODREFE", NIL, STR0050, } ) //"Refer. O.D."
	AADD( aTRB9, { "TM9_ODRESU", NIL, STR0051, } ) //"Result. O.D."
	AADD( aTRB9, { "TM9_OEREFE", NIL, "Refer. O.E.", } ) //"Refer. O.D."
	AADD( aTRB9, { "TM9_OERESU", NIL, "Result. O.E.", } ) //"Result. O.D."

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( cAliasTRB, aDBF )
	oTempTRB:AddIndex( "1", {"TM9_NUMFIC", "TM9_DTPROG", "TM9_HRPROG", "TM9_EXAME"} )
	oTempTRB:Create()

	dbSelectArea( cAliasTRB )
	APPEND FROM "TM9" FIELDS "TM9_NUMFIC", "TM9_EXAME", "TM9_DTPROG", "TM9_HRPROG", "TM9_EQPTO", "TM9_INDVIA",;
							 "TM9_ODREFE", "TM9_ODRESU", "TM9_OEREFE", "TM9_OERESU" FOR ( TM9->TM9_FILIAL+TM9->TM9_NUMFIC == cFilTM9+TM0->TM0_NUMFIC )

	Dbselectarea( cAliasTRB )
	Dbgotop()
	While !Eof()
		EVAL( bBloco1, ResulDes( (cAliasTRB)->TM9_ODRESU ) )
		EVAL( bBloco2, ViaDesc( (cAliasTRB)->TM9_INDVIA ) )
		EVAL( bBloco3, RefDesc( (cAliasTRB)->TM9_ODREFE ) )
		EVAL( bBloco4, ResulDes( (cAliasTRB)->TM9_OERESU ) )
		EVAL( bBloco5, RefDesc( (cAliasTRB)->TM9_OEREFE ) )
		dbSkip()
	End

	dbGoTop()
	MARKBROW( cAliasTRB, "TM9_OK", , aTRB9, lInverte, cMarca, "U_A488Invert()" )

	dbSelectArea( cAliasTRB )
	//Use
	oTempTRB:Delete()
	aRotina := aCLONE( OldRot )
	cCadastro := OldCad

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ResulDes
Coloca a descricao do Resultado da Portaria 19 no campo do TRB

@author  Andre Perez Alvarez
@since   16/08/2007
@sample  ResulDes("1")

@param   cCodResu, caractere, código do resultado do exame
@return  caractere, descrição do código
/*/
//-------------------------------------------------------------------
Static Function ResulDes(cCodResu)

	Local cDesc := ""
	cCodResu := AllTrim( cCodResu )

	If cCodResu = '1'
		cDesc := STR0053  //"Requer Interpretação"
	ElseIf cCodResu = '2'
		cDesc := STR0054  //"Limiares Aceitáveis"
	ElseIf cCodResu = '3'
		cDesc := STR0055  //"Sugestivo de PAIR"
	ElseIf cCodResu = '4'
		cDesc := STR0056  //"Nao Sugestivo de PAIR"
	ElseIf cCodResu = '5'
		cDesc := STR0057  //"Sugestivo de Desencadeamento"
	ElseIf cCodResu = '6'
		cDesc := STR0058  //"Sugestivo de Agravamento"
	ElseIf cCodResu = '7'
		cDesc := STR0059  //"Perda auditiva"
	EndIf

Return cDesc

//-------------------------------------------------------------------
/*/{Protheus.doc} ViaDesc
Coloca a descricao da Via de Conducao no campo do TRB

@author  Andre Perez Alvarez
@since   16/08/2007
@sample  ViaDesc("1")

@param   cCodVia, caractere, código da via
@return  caractere, descrição do código
/*/
//-------------------------------------------------------------------
Static Function ViaDesc(cCodVia)

	Local cDesc := ""
	cCodVia := AllTrim( cCodVia )

	If cCodVia == "1"
		cDesc := STR0060  //"Aérea"
	ElseIf cCodVia == "2"
		cDesc := STR0061  //"Óssea"
	EndIf

Return cDesc

//-------------------------------------------------------------------
/*/{Protheus.doc} RefDesc
Coloca a descricao do campo Referencial do TRB.

@author  Andre Perez Alvarez
@since   16/08/2007
@sample  RefDesc("1")

@param   cCod, caractere, código do campo referencial
@return  caractere, descrição do código
/*/
//-------------------------------------------------------------------
Static Function RefDesc(cCod)

	Local cDesc := ""
	cCod := AllTrim( cCod )

	If cCod == "1"
		cDesc := STR0086 //"Sim"
	ElseIf cCod == "2"
		cDesc := STR0087 //"Não"
	EndIf

Return cDesc

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR488IMP
Verifica se eh possivel imprimir os resultados selecionados, e em caso positivo, os imprime.

@author  Inacio Luiz Kolling
@since   27/04/2000
@sample  U_MDTR488IMP("TM9")

@param   cAliasTRB1, caractere, alias da tabela
@return  Nil, nulo
/*/
//-------------------------------------------------------------------
User Function MDTR488IMP(cAliasTRB1)

	//Verifica se os campos novos da versão 10 release 1.2 existem. Caso afirmativo o programa irá se comportar conforme especIficação dessa release
	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux
	Default cAliasTRB1 := ""

		U__PRINT488( cAliasTRB1 )

		//------------------------------//
		// Funcoes utlizadas neste caso //
		//------------------------------//

		/*	_PRINT488
			_R488IMP
			TAB488
			Exame1
			Grafico1
			Exame2
			Grafico2
			MatrizLim
			MatrizMas
			STRMED120
			MascReal
			ResultDes
			ViaDesc
			RefDesc
			DIRR488
			R488Idade  */

		//-----------------------------------------------//
		// Arquivo .dot utilizado: audiometria-v10r2.dot //
		//-----------------------------------------------//

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} DIRR488
Busca o caminho do arquivo.

@author  Denis Hyroshi de Souza
@since   22/03/2007
@sample  DIRR488("C:")

@param   cCaminho, caractere, caminho do arquivo
@return  lógico, Se salvou no diretorio
/*/
//-------------------------------------------------------------------
Static Function DIRR488( cCaminho )

	Local lDir := .F.
	Local cBARRAS   := IIf( isSRVunix(), "/", "\" )
	Local cBARRAD := IIf( isSRVunix(), "//", "\\" )
	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux
	If !Empty( cCaminho ) .And. !( cBARRAD$cCaminho )
		cCaminho := Alltrim( cCaminho )
		If Right( cCaminho, 1 ) == cBARRAS
			cCaminho := SubStr( cCaminho, 1, Len( cCaminho )-1 )
		EndIf
		lDir :=( aScan( Directory( cCaminho, "D" ), {|_Vet | "D" $ _Vet[5] } ) > 0 )
	EndIf

Return lDir

//-------------------------------------------------------------------
/*/{Protheus.doc} R488IDADE
Calcula a idade.

@author  Denis Hyroshi de Souza
@since   22/03/2007
@sample  R488IDADE(12/01/1997, 17/02/2020)

@param   dNasc,  data, data de nascimento
@param   dFim,   data, data final para calculo da idade
@return  numérico, idade calculada
/*/
//-------------------------------------------------------------------
Static Function R488IDADE( dNasc, dFim )

	Local nIdade := 0

	If dFim == nil
		dFim := Date()
	EndIf

	nIdade := Year( dFim ) - Year( dNasc )
	If Month( dFim ) < Month( dNasc )
		nIdade := nIdade - 1
	ElseIf Month( dFim ) == Month( dNasc )
		If Day( dFim ) < Day( dNasc )
			nIdade := nIdade - 1
		EndIf
	EndIf

Return nIdade

//-------------------------------------------------------------------
/*/{Protheus.doc} MenuDef
Utilizacao de Menu Funcional.

@type    static function

@author  Andre E. Perez Alvarez
@since   13/12/2006

@return aRotina, array, Array com opcoes da rotina.
@obs Parametros do array a Rotina:
		1. Nome a aparecer no cabecalho
		2. Nome da Rotina associada
		3. Reservado
		4. Tipo de Transação a ser efetuada:
		    1 - Pesquisa e Posiciona em um Banco de Dados
		    2 - Simplesmente Mostra os Campos
		    3 - Inclui registros no Bancos de Dados
		    4 - Altera o registro corrente
		    5 - Remove o registro corrente do Banco de Dados
		5. Nivel de acesso
		6. Habilita Menu Funcional

/*/
//-------------------------------------------------------------------
Static Function MenuDef()

	Local lSigaMdtPS := IIf( SuperGetMv( "MV_MDTPS", .F., "N" ) == "S", .T., .F. )
	Local aRotina

	If lSigaMdtps
		aRotina := { { STR0001, "AxPesqui", 0, 1},; //"Pesquisar"
		             { STR0002, "NGCAD01", 0, 2},; //"Visualizar"
		             { STR0091, "MDT488TM0", 0, 4} } //"Fichas Médicas"
	Else
		aRotina := { { STR0001, "AxPesqui", 0, 1},; //"Pesquisar"
					 { STR0002, "NGCAD01", 0, 2},; //"Visualizar"
	     			 { STR0092, "MDTREXA", 0, 3}}  //"Exames"
	EndIf

Return aRotina

//-------------------------------------------------------------------
/*/{Protheus.doc} _PRINT488
Verifica se é possivel imprimir os resultados selecionados, e em caso positivo,
os imprime.

@author  Andre E. Perez Alvarez
@since   04/03/2008
@sample  U__PRINT488("TM9")

@param   cAliasTRB1, caractere, alias da tabela
@return  Nil, nulo
/*/
//-------------------------------------------------------------------
User Function _PRINT488(cAliasTRB1)

	Local cPerg	:= PADR( "MDT488", 10 )

	Private nAerea := 0
	Private nOssea := 0

	Private RecAerea
	Private RecOssea
	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux

	DbSelectArea( cAliasTRB1 )
	DBGOTOP()
	While !Eof()
		If !Empty( (cAliasTRB1)->TM9_OK )
			If (cAliasTRB1)->TM9_INDVIA == "1"
				nAerea++
				RecAerea := Recno()
			ElseIf (cAliasTRB1)->TM9_INDVIA == "2"
	      		nOssea++
	      		RecOssea := Recno()
	      	EndIf
		EndIf
		Dbskip()
	End

	cTexto := STR0040  //"Não foi possível imprimir o relatório."
	If (nAerea + nOssea) > 2
	   Msgstop( cTexto+" "+STR0042, STR0041 )  //"Selecione no máximo 2(dois) exames."//"ATENÇÃO"
	   DbGotop()
	   Return .F.
	EndIf
	If (nAerea + nOssea) = 0
	   Msgstop( cTexto+" "+STR0043, STR0041 )  //"Selecione pelo menos 1(um) exame."//"ATENÇÃO"
	   DbGotop()
	   Return .F.
	EndIf

	If (nAerea + nOssea == 2)
		If (nAerea != nOssea)
		   Msgstop( cTexto+" "+STR0044, STR0041 ) //"Selecione 1(um) exame via aérea e 1(um) exame via óssea."//"ATENÇÃO"
		   DbGotop()
		   Return .F.
		EndIf
	EndIf

	If Pergunte( cPerg, .T. )
		Processa( {|lEnd| _R488Imp( cAliasTRB1 )} )  //Imprime
	EndIf

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} _R488Imp
Imprime o Relatorio

@author  Andre E. Perez Alvarez
@since   04/03/2008
@sample  _R488Imp("TM9")

@param   cAliasTRB1, caractere, alias da tabela
@return  Nil, nulo
/*/
//-------------------------------------------------------------------
Static Function _R488Imp(cAliasTRB1)

	Local lImpress, cArqSaida
	Local cPathDot := Alltrim( GetMv( "MV_DIRACA" ) )	// Path do arquivo modelo do Word
	Local cPathEst := Alltrim( GetMv( "MV_DIREST" ) )	// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ
	Local cRootPath
	Local lMascVa := .F.  //Denota se o mascaramento foi realizado para a Via Área
	Local lMascVo := .F.  //Denota se o mascaramento foi realizado para a Via Óssea
	Local lPrimeiro := .T.
	Local nX
	Local cDESRES := ""
	Local nLinhasMemo
	Local LinhaCorrente
	Local i
	Local cBarraRem := IIf( GetRemoteType() == 2, "/", "\" )
	Local cBarraSrv := IIf( isSRVunix(), "/", "\" )
	Local cArqDot := 'audiometria.dotm'
	Local lCTT := Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
	Local aCnpj := fTipoINSC()

	Private lMdtUnix := IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux

	//-----------------------//
	//Preparacao do documento//
	//-----------------------//

	cPathDot += IIf( Substr( cPathDot, Len( cPathDot ), 1 ) != cBarraSrv, cBarraSrv, "" ) + cArqDot
	cPathEst += IIf( Substr( cPathEst, Len( cPathEst ), 1 ) != cBarraRem, cBarraRem, "" )

	//Cria diretorio se nao existir
	MontaDir( cPathEst )

	//Se existir .dot na estacao, apaga!
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	If !File( cPathDot )
		MsgStop( STR0093 + Chr( 10 )+ STR0063, STR0041 ) // "O arquivo audiometria.dotm não foi encontrado no servidor."
		Return
	EndIf
	CpyS2T( cPathDot, cPathEst, .T. ) 	// Copia do Server para o Remote, é necessario
	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP

	// Seleciona Arquivo Modelo
	lImpress	:= IIf( mv_par01 == 1, .T., .F. )	// Verifica se a saida sera em Tela ou Impressora
	cArqSaida	:= Upper( IIf( Empty( mv_par02 ), "Documento1", AllTrim( mv_par02 ) ) )	// Nome do arquivo de saida

	If !(".DOCX" $ cArqSaida)
		cArqSaida := StrTran( cArqSaida, ".DOC", ".DOCX" )
	EndIf

	oWord := OLE_CreateLink()// Cria link como Word

	OLE_NewFile( oWord, cPathEst + cArqDot ) //Abrindo o arquivo modelo automaticamente

	cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
	cRootPath := IIf( RIGHT( cRootPath, 1 ) == cBarraSrv, SubStr( cRootPath, 1, Len( cRootPath )-1 ), cRootPath )

	Private aPosDB := {;
		200,; // +7
		207,; // +7
		214,; // +7
		221,; // +7
		228,; // +7
		235,; // +7
		242,; // +7
		249,; // +7
		256,; // +7
		263,; // +7
		270,; // +7
		277,; // +7
		284,; // +7
		291,; // +7
		298,; // +7
		305,; // +7
		312,; // +7
		319,; // +7
		326,; // +7
		333,; // +7
		340,; // +7
		347,; // +7
		354,; // +7
		361,; // +7
		368,; // +7
		375,; // +7
		382,; // +7
		389,; // +7
		396; // +7
	}

	Private aPosHz := {;
		107,; // +29
		136,; // +29
		165,; // +29
		194,; // +15
		209,; // +15
		224,; // +15
		239,; // +15
		254,; // +116
		370,; // +29
		399,; // +29
		428,; // +29
		457,; // +15
		472,; // +15
		487,; // +15
		502,; // +15
		517;
	}

	Private aDICBS := {;
		-10,; // +5 
		-5,; // +5 
		0,; // +5 
		5,; // +5 
		10,; // +5 
		15,; // +5 
		20,; // +5 
		25,; // +5 
		30,; // +5 
		35,; // +5 
		40,; // +5 
		45,; // +5 
		50,; // +5 
		55,; // +5 
		60,; // +5 
		65,; // +5 
		70,; // +5 
		75,; // +5 
		80,; // +5 
		85,; // +5 
		90,; // +5 
		95,; // +5 
		100,; // +5 
		105,; // +5 
		110,; // +5 
		115,; // +5 
		120,; // +5 
		125,; // +5 
		130; // +5 
	}

	Private nDBInicio := 0
	Private nHZInicio := 0
	Private nposDBfi := 0
	Private nposHZfi := 0

	Private fCCusto := "SRA->RA_CC"
	Private fNome   := "SRA->RA_NOME"
	Private fFuncao := "SRA->RA_CODFUNC"
	Private fCPF    := 'Transform( SRA->RA_CIC, "@R 999.999.999-99" )'
	Private fNasc   := "SRA->RA_NASC"
	Private lTm0 := .F.

	Private cFilSRJ := IIf( Empty( TM0->TM0_FILFUN ), xFilial( "SRJ" ), xFilial( "SRJ", TM0->TM0_FILFUN ) )
	Private cFilCC  := ''

	If lCTT
		cFilCC := IIf( Empty( TM0->TM0_FILFUN ), xFilial( "CTT" ), xFilial( "CTT", TM0->TM0_FILFUN ) )
	Else
		cFIlCC := IIf( Empty( TM0->TM0_FILFUN ), xFilial( "SI3" ), xFilial( "SI3", TM0->TM0_FILFUN ) )
	EndIf

	cCondicao := 'cFilTM9+(cAliasTRB1)->TM9_NUMFIC+DTOS((cAliasTRB1)->TM9_DTPROG)+(cAliasTRB1)->TM9_HRPROG+(cAliasTRB1)->TM9_EXAME+(cAliasTRB1)->TM9_INDVIA'
	Dbselectarea( cAliasTRB1 )

	If nAerea > 0
		Dbgoto( RecAerea )
	ElseIf nOssea > 0
		Dbgoto( RecOssea )
	EndIf

	ProcRegua( nAerea+nOssea )

	//-----------------------------------------
	//Percorre as vias de conducao selecionadas
	//-----------------------------------------
	For nX := 1 To (nAerea+nOssea)

		dbSelectArea( "TM9" )
		dbSetOrder( 03 )  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA
		dbSeek( cFilTM9+(cAliasTRB1)->TM9_NUMFIC+DTOS( (cAliasTRB1)->TM9_DTPROG )+(cAliasTRB1)->TM9_HRPROG+(cAliasTRB1)->TM9_EXAME+(cAliasTRB1)->TM9_INDVIA )

		If lPrimeiro
		    lPrimeiro := .F.
		    //----------------------------------------------
		    //Cabeçalho - Outras Informacoes  - Conclusao
		    //----------------------------------------------
		    ****************************************************************************
		    dbSelectArea( "TM5" )
		    dbSetOrder( 08 ) //TM5_FILIAL+TM5_NUMFIC+DTOS(TM5_DTPROG)+TM5_HRPROG+TM5_EXAME
		    dbSeek( xFilial( "TM5" )+TM9->TM9_NUMFIC+DTOS( TM9->TM9_DTPROG )+TM9->TM9_HRPROG+TM9->TM9_EXAME )

		    // Verifica se o exame é assistencial, caso seja, não adiciona descricao
		    // conforme natureza, mas sim, descricao assistencial
		    If TM5->TM5_ORIGEX == "1"
		    	cNatexa := STR0113//"Audiograma Assistencial"
		    Else
			    //-------------------
			    // Natureza do exame
			    //-------------------
			   	cNatexa := STR0064 //"Audiograma Admissional"
			    If TM5->TM5_NATEXA == '2'
			    	cNatexa := STR0065  //"Audiograma Periódico"
			    ElseIf TM5->TM5_NATEXA == '3'
			    	cNatexa := STR0066  //"Audiograma para Mudança de Função"
			    ElseIf TM5->TM5_NATEXA == '4'
			    	cNatexa := STR0067  //"Audiograma para Retorno Trabalho"
			    ElseIf TM5->TM5_NATEXA == '5'
			    	cNatexa := STR0068  //"Audiograma Demissional"
				ElseIf TM5->TM5_NATEXA == '6'
		    		cNatexa := STR0120 //"Audiograma Monitoração Pontual"
			    EndIf
		    EndIf

			OLE_SetDocumentVar( oWord, "cNatexa", cNatexa )
			//------------------//

		    dbSelectArea( "TM0" )
		    dbSetOrder( 01 )
		    dbSeek( xFilial( "TM0" )+TM9->TM9_NUMFIC )

		    dbSelectArea( "SRA" )
		    dbSetOrder( 01 )
		    If dbSeek( xFilial( "SRA", TM0->TM0_FILFUN )+TM0->TM0_MAT )
				fCCusto := "SRA->RA_CC"
				fNome   := "SRA->RA_NOME"
				fFuncao := "SRA->RA_CODFUNC"
				fCPF    := 'Transform( SRA->RA_CIC, "@R 999.999.999-99" )'
				fNasc   := 	"SRA->RA_NASC"
		    Else
			    lTm0 := .T.
			    Dbselectarea( "TM0" )
		       	fNome := "TM0->TM0_NOMFIC"
				fCPF  := 'Transform( TM0->TM0_CPF, "@R 999.999.999-99" )'
		       	fNasc := "TM0->TM0_DTNASC"
		    	fCCusto := "TM0->TM0_CC"
		    	fFuncao := "TM0->TM0_CODFUN"
			EndIf

			OLE_SetDocumentVar( oWord, "cEmpresa", Capital( Substr( SM0->M0_NOMECOM, 1, 35 ) ) )
			OLE_SetDocumentVar( oWord, "cCnpj", Capital( aCnpj[ 2 ] ) )  // Cnpj

			OLE_SetDocumentVar( oWord, "dDtprog", TM9->TM9_DTPROG ) //Data do Exame
			OLE_SetDocumentVar( oWord, "dtresu", TM5->TM5_DTRESU ) //Data do Resultado
			OLE_SetDocumentVar( oWord, "cMat", IIf( lTM0, TM0->TM0_CANDID, TM0->TM0_MAT ) )//Matricula do Funcionario
			OLE_SetDocumentVar( oWord, "cNome", Substr( Capital( &fNome ), 1, 40 ) )//Nome do Funcionario
			OLE_SetDocumentVar( oWord, "cCPF", &fCPF )  //CPF

		    dbSelectArea( "SRJ" )
		    dbSetOrder( 01 )
		    dbSeek( cFilSRJ+&fFuncao )
		    OLE_SetDocumentVar( oWord, "cFuncao", Capital( Substr( SRJ->RJ_DESC, 1, 40 ) ) )//Funcao
			OLE_SetDocumentVar( oWord, "nIdade", R488IDADE( &fNasc ) )//Data de Nasc.

			If lCTT
		    	dbSelectArea( "CTT" )
		    	dbSetOrder( 01 )
		    	dbSeek( cFilCC+&fCCusto )
				OLE_SetDocumentVar( oWord, "cCusto", Capital( Substr( CTT->CTT_DESC01, 1, 40 ) ) )//Centro de Custo
			Else
 				dbSelectArea( "SI3" )
		    	dbSetOrder( 01 )
		    	dbSeek( cFilCC+&fCCusto )
		    	OLE_SetDocumentVar( oWord, "cCusto", Substr( SI3->I3_DESC, 1, 40 ) )//Centro de Custo
			EndIf

			OLE_SetDocumentVar( oWord, "nHoras", TM9->TM9_REPOUS )//Repouso Auditivo

		    DbSelectArea( "TM7" )
		    DbSetOrder( 1 )
		    DbSeek( xFilial( "TM7" )+TM9->TM9_EQPTO )
		    OLE_SetDocumentVar( oWord, "cNomeEqpto", Capital( Substr( TM7->TM7_NOEQTO, 1, 35 ) ) )
			DbSelectArea( "TM9" )
	    	OLE_SetDocumentVar( oWord, "dAfer", TM9->TM9_DTAFER )//Data Afericao Eq.
		    OLE_SetDocumentVar( oWord, "dCali", TM9->TM9_DTCALI )//Data Calibracao Eq.
			OLE_SetDocumentVar( oWord, "cFabr", Capital( Substr( TM7->TM7_NOMFAB, 1, 35 ) ) ) //Fabricante

			****************************************************************************
			//------------------------
			// Outras Informações
			//------------------------
			****************************************************************************
			//LOGOAUDIOMETRIA
			If Mv_par09 == 1
			If TM9->TM9_ODRECF != 0
				OLE_SetDocumentVar( oWord, "odLoInten", Alltrim( Str( TM9->TM9_ODRECF ) ) + " dB" ) //Intensidade Orelha Direita
			Else
				OLE_SetDocumentVar( oWord, "odLoInten", STR0096 ) //"Não Realizado"
			EndIf
			If TM9->TM9_OERECF != 0
				OLE_SetDocumentVar( oWord, "oeLoInten", Alltrim( Str( TM9->TM9_OERECF ) ) + " dB" ) //Intensidade Orelha Esquerda
			Else
				OLE_SetDocumentVar( oWord, "oeLoInten", STR0096 ) //"Não Realizado"
			EndIf
			If TM9->TM9_ODREMO != 0
				OLE_SetDocumentVar( oWord, "odLoMono", Alltrim( Str( TM9->TM9_ODREMO ) ) + " %" ) //Monossilaba Orelha Direita
			Else
				OLE_SetDocumentVar( oWord, "odLoMono", STR0096 ) //"Não Realizado"
			EndIf
			If TM9->TM9_OEREMO != 0
				OLE_SetDocumentVar( oWord, "oeLoMono", Alltrim( Str( TM9->TM9_OEREMO ) ) + " %" ) //Monossilaba Orelha Esquerda
			Else
				OLE_SetDocumentVar( oWord, "oeLoMono", STR0096 ) //"Não Realizado"
			EndIf
			If TM9->TM9_ODREDI != 0
				OLE_SetDocumentVar( oWord, "odLoDissi", Alltrim( Str( TM9->TM9_ODREDI ) ) + " %" ) //Dissilaba Orelha Direita
			Else
				OLE_SetDocumentVar( oWord, "odLoDissi", STR0096 ) //"Não Realizado"
			EndIf
			If TM9->TM9_OEREDI != 0
				OLE_SetDocumentVar( oWord, "oeLoDissi", Alltrim( Str( TM9->TM9_OEREDI ) ) + " %" ) //Dissilaba Orelha Esquerda
			Else
				OLE_SetDocumentVar( oWord, "oeLoDissi", STR0096 ) //"Não Realizado"
			EndIf

			If TM9->TM9_ODSDT != 0
				OLE_SetDocumentVar( oWord, "cTM9_ODSDT", Alltrim( Str( TM9->TM9_ODSDT ) ) + " dB" ) //SDT O.D.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_ODSDT", " " )
			EndIf
			If TM9->TM9_OESDT != 0
				OLE_SetDocumentVar( oWord, "cTM9_OESDT", Alltrim( Str( TM9->TM9_OESDT ) ) + " dB" ) //SDT O.E.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_OESDT", " " )
			EndIf
			If TM9->TM9_ODMSRT != 0
				OLE_SetDocumentVar( oWord, "cTM9_ODMSRT", Alltrim( Str( TM9->TM9_ODMSRT ) ) + " dB" ) //Masc. SRT O.D.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_ODMSRT", " " )
			EndIf
			If TM9->TM9_OEMSRT != 0
				OLE_SetDocumentVar( oWord, "cTM9_OEMSRT", Alltrim( Str( TM9->TM9_OEMSRT ) ) + " dB" ) //Masc. SRT O.E.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_OEMSRT", " " )
			EndIf
			If TM9->TM9_ODMIRF != 0
				OLE_SetDocumentVar( oWord, "cTM9_ODMIRF", Alltrim( Str( TM9->TM9_ODMIRF ) ) + " dB" ) //Masc. IRF O.D.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_ODMIRF", " " )
			EndIf
			If TM9->TM9_OEMIRF != 0
				OLE_SetDocumentVar( oWord, "cTM9_OEMIRF", Alltrim( Str( TM9->TM9_OEMIRF ) ) + " dB" ) //Masc. IRF O.E.
			Else
				OLE_SetDocumentVar( oWord, "cTM9_OEMIRF", " " )
			EndIf

			OLE_SetDocumentVar( oWord, "VA_ODLMIN", " " )
			OLE_SetDocumentVar( oWord, "VA_OELMIN", " " )
			OLE_SetDocumentVar( oWord, "VO_ODLMIN", " " )
			OLE_SetDocumentVar( oWord, "VO_OELMIN", " " )

			//MEATOSCOPIA
			OLE_SetDocumentVar( oWord, "cODMeat", TM9->TM9_ODMEAT )//Orelha Direita
			OLE_SetDocumentVar( oWord, "cOEMeat", TM9->TM9_OEMEAT )//Orelha Esquerda
			EndIf
			****************************************************************************
			//------------
			// Conclusoes
			//------------
			****************************************************************************
		    nLinhasMemo := MLCOUNT( TM5->TM5_DESRES, 80 )
		    For LinhaCorrente := 1 to nLinhasMemo
		        If !Empty( ( MemoLine( TM5->TM5_DESRES, 80, LinhaCorrente ) ) )
					cDESRES += MemoLine( TM5->TM5_DESRES, 80, LinhaCorrente )
		        EndIf
		    Next LinhaCorrente

			OLE_SetDocumentVar( oWord, "cLaudo", IIf( Empty( cDESRES ), TM5->TM5_OBSERV, TM5->TM5_DESRES ) ) //Laudo Conclusivo

			//RESPONSAVEL / EXECUTANTE
			DbSelectArea( "TMK" )
		    DbSetOrder( 1 )
		    DbSeek( xFilial( "TMK" )+TM9->TM9_USURES )
		    _Crm := IIf( Empty( TMK->TMK_ENTCLA ), "CRM - ", Alltrim( TMK->TMK_ENTCLA )+" - " )
			OLE_SetDocumentVar( oWord, "cCrm", _Crm+Alltrim( TMK->TMK_NUMENT )+Space( 2 ) )      //CRM do Medico
			OLE_SetDocumentVar( oWord, "cMedico", TMK->TMK_NOMUSU )//Nome do Medico Responsavel
			****************************************************************************
		EndIf

		//---------
		//Via Aerea
		//---------
		If TM9->TM9_INDVIA == "1"
			If !Empty( TM9->TM9_ODLMIN ) .Or. !Empty( TM9->TM9_ODLMAX )
				cTxt := Alltrim( TM9->TM9_ODLMIN ) + " / " + Alltrim( TM9->TM9_ODLMAX )
				OLE_SetDocumentVar( oWord, "VA_ODLMIN", cTxt + " dB" ) //Masc. limites O.D.
			Else
				OLE_SetDocumentVar( oWord, "VA_ODLMIN", " " )
			EndIf
			If !Empty( TM9->TM9_OELMIN ) .Or. !Empty( TM9->TM9_OELMAX )
				cTxt := Alltrim( TM9->TM9_OELMIN ) + " / " + Alltrim( TM9->TM9_OELMAX )
				OLE_SetDocumentVar( oWord, "VA_OELMIN", cTxt + " dB" ) //Masc. limites O.E.
			Else
				OLE_SetDocumentVar( oWord, "VA_OELMIN", " " )
			EndIf

		    //-----------------------------
		    //Tabelas de Limiar - Via Aerea
		    //-----------------------------
		    //OD
		   	TAB488( "ODA025", TM9->TM9_OD025K )
		   	TAB488( "ODA050", TM9->TM9_OD05KH )
		   	TAB488( "ODA1", TM9->TM9_OD1KHZ )
		   	TAB488( "ODA2", TM9->TM9_OD2KHZ )
		   	TAB488( "ODA3", TM9->TM9_OD3KHZ )
		   	TAB488( "ODA4", TM9->TM9_OD4KHZ )
		   	TAB488( "ODA6", TM9->TM9_OD6KHZ )
			TAB488( "ODA8", TM9->TM9_OD8KHZ )
			//OE
		   	TAB488( "OEA025", TM9->TM9_OE025K )
		   	TAB488( "OEA050", TM9->TM9_OE05KH )
		   	TAB488( "OEA1", TM9->TM9_OE1KHZ )
		   	TAB488( "OEA2", TM9->TM9_OE2KHZ )
		   	TAB488( "OEA3", TM9->TM9_OE3KHZ )
		   	TAB488( "OEA4", TM9->TM9_OE4KHZ )
		   	TAB488( "OEA6", TM9->TM9_OE6KHZ )
			TAB488( "OEA8", TM9->TM9_OE8KHZ )

			//-----------------------------------
			//Resultados e Medias da Via Aérea
			//-----------------------------------
			Exame1()

			lMascVa := MascReal()  //Se realizou o Mascaramento

			If lMascVa

			    //-----------------------
			    //Tabelas do Mascaramento
			    //-----------------------
			    //OD
			   	TAB488( "ODA025ma", TM9->TM9_ODMA25, TM9->TM9_OD025K )
			   	TAB488( "ODA050ma", TM9->TM9_ODMA50, TM9->TM9_OD05KH )
			   	TAB488( "ODA1ma", TM9->TM9_ODMA10, TM9->TM9_OD1KHZ )
			   	TAB488( "ODA2ma", TM9->TM9_ODMA20, TM9->TM9_OD2KHZ )
			   	TAB488( "ODA3ma", TM9->TM9_ODMA30, TM9->TM9_OD3KHZ )
			   	TAB488( "ODA4ma", TM9->TM9_ODMA40, TM9->TM9_OD4KHZ )
			   	TAB488( "ODA6ma", TM9->TM9_ODMA60, TM9->TM9_OD6KHZ )
				TAB488( "ODA8ma", TM9->TM9_ODMA80, TM9->TM9_OD8KHZ )
				//OE
			   	TAB488( "OEA025ma", TM9->TM9_OEMA25, TM9->TM9_OE025K )
			   	TAB488( "OEA050ma", TM9->TM9_OEMA50, TM9->TM9_OE05KH )
			   	TAB488( "OEA1ma", TM9->TM9_OEMA10, TM9->TM9_OE1KHZ )
			   	TAB488( "OEA2ma", TM9->TM9_OEMA20, TM9->TM9_OE2KHZ )
			   	TAB488( "OEA3ma", TM9->TM9_OEMA30, TM9->TM9_OE3KHZ )
			   	TAB488( "OEA4ma", TM9->TM9_OEMA40, TM9->TM9_OE4KHZ )
			   	TAB488( "OEA6ma", TM9->TM9_OEMA60, TM9->TM9_OE6KHZ )
				TAB488( "OEA8ma", TM9->TM9_OEMA80, TM9->TM9_OE8KHZ )
				
				If mv_par04 == 2   //Imprime resultado Normal apenas se requisitado
				//-----------------
				//Grafico do Limiar
				//-----------------
					Grafico1()
				Else
				//-----------------------
				//Grafico do Mascaramento
				//-----------------------
					Grafico2()
				EndIf

		    Else

				If nOssea > 0
					dbSelectArea( cAliasTRB1 )
					Dbgoto( RecOssea )

					dbSelectArea( "TM9" )
					dbSeek( cFilTM9+(cAliasTRB1)->TM9_NUMFIC+DTOS( (cAliasTRB1)->TM9_DTPROG )+(cAliasTRB1)->TM9_HRPROG+(cAliasTRB1)->TM9_EXAME+(cAliasTRB1)->TM9_INDVIA )
					lMascVo := MascReal()  //Se realizou o Mascaramento

					dbSelectArea( cAliasTRB1 )
					Dbgoto( RecAerea )

					dbSelectArea( "TM9" )
					dbSeek( cFilTM9+(cAliasTRB1)->TM9_NUMFIC+DTOS( (cAliasTRB1)->TM9_DTPROG )+(cAliasTRB1)->TM9_HRPROG+(cAliasTRB1)->TM9_EXAME+(cAliasTRB1)->TM9_INDVIA )
				EndIf

				If lMascVo

					If mv_par04 == 2   //Imprime resultado Normal apenas se requisitado
						//-----------------
						//Grafico do Limiar
						//-----------------
						Grafico1()
					EndIf
				Else
					//-----------------
					//Grafico do Limiar
					//-----------------
					Grafico1()
				EndIf

			    //-----------------------
			    //Tabelas do Mascaramento
			    //-----------------------
			    //OD
			   	TAB488( "ODA025ma", -1 )
			   	TAB488( "ODA050ma", -1 )
			   	TAB488( "ODA1ma", -1 )
			   	TAB488( "ODA2ma", -1 )
			   	TAB488( "ODA3ma", -1 )
			   	TAB488( "ODA4ma", -1 )
			   	TAB488( "ODA6ma", -1 )
				TAB488( "ODA8ma", -1 )
				//OE
			   	TAB488( "OEA025ma", -1 )
			   	TAB488( "OEA050ma", -1 )
			   	TAB488( "OEA1ma", -1 )
			   	TAB488( "OEA2ma", -1 )
			   	TAB488( "OEA3ma", -1 )
			   	TAB488( "OEA4ma", -1 )
			   	TAB488( "OEA6ma", -1 )
				TAB488( "OEA8ma", -1 )
			EndIf
		//---------
		//Via Ossea
		//---------
		Else

			If !Empty( TM9->TM9_ODLMIN ) .Or. !Empty( TM9->TM9_ODLMAX )
				cTxt := Alltrim( TM9->TM9_ODLMIN ) + " / " + Alltrim( TM9->TM9_ODLMAX )
				OLE_SetDocumentVar( oWord, "VO_ODLMIN", cTxt + " dB" ) //Masc. limites O.D.
			Else
				OLE_SetDocumentVar( oWord, "VO_ODLMIN", " " )
			EndIf
			If !Empty( TM9->TM9_OELMIN ) .Or. !Empty( TM9->TM9_OELMAX )
				cTxt := Alltrim( TM9->TM9_OELMIN ) + " / " + Alltrim( TM9->TM9_OELMAX )
				OLE_SetDocumentVar( oWord, "VO_OELMIN", cTxt + " dB" ) //Masc. limites O.E.
			Else
				OLE_SetDocumentVar( oWord, "VO_OELMIN", " " )
			EndIf

		    //-----------------------------
		    //Tabelas de Limiar - Via Ossea
		    //-----------------------------
		    //OD
		   	TAB488( "ODO050", TM9->TM9_OD05KH )
		   	TAB488( "ODO1", TM9->TM9_OD1KHZ )
		   	TAB488( "ODO2", TM9->TM9_OD2KHZ )
		   	TAB488( "ODO3", TM9->TM9_OD3KHZ )
		   	TAB488( "ODO4", TM9->TM9_OD4KHZ )
			//OE
		   	TAB488( "OEO050", TM9->TM9_OE05KH )
		   	TAB488( "OEO1", TM9->TM9_OE1KHZ )
		   	TAB488( "OEO2", TM9->TM9_OE2KHZ )
		   	TAB488( "OEO3", TM9->TM9_OE3KHZ )
		   	TAB488( "OEO4", TM9->TM9_OE4KHZ )

			lMascVo := MascReal()  //Se realizou o Mascaramento
			If lMascVo

			    //-----------------------
			    //Tabelas do Mascaramento
			    //-----------------------
			    //OD
			   	TAB488( "ODO050ma", TM9->TM9_ODMA50, TM9->TM9_OD05KH )
			   	TAB488( "ODO1ma", TM9->TM9_ODMA10, TM9->TM9_OD1KHZ )
			   	TAB488( "ODO2ma", TM9->TM9_ODMA20, TM9->TM9_OD2KHZ )
			   	TAB488( "ODO3ma", TM9->TM9_ODMA30, TM9->TM9_OD3KHZ )
			   	TAB488( "ODO4ma", TM9->TM9_ODMA40, TM9->TM9_OD4KHZ )
				//OE
			   	TAB488( "OEO050ma", TM9->TM9_OEMA50, TM9->TM9_OE05KH )
			   	TAB488( "OEO1ma", TM9->TM9_OEMA10, TM9->TM9_OE1KHZ )
			   	TAB488( "OEO2ma", TM9->TM9_OEMA20, TM9->TM9_OE2KHZ )
			   	TAB488( "OEO3ma", TM9->TM9_OEMA30, TM9->TM9_OE3KHZ )
			   	TAB488( "OEO4ma", TM9->TM9_OEMA40, TM9->TM9_OE4KHZ )
				
				If mv_par04 == 2   //Imprime resultado Normal/Masc. apenas se requisitado
				//-----------------
				//Grafico do Limiar/Masc.
				//-----------------
					Grafico1()

				Else

				//-----------------------
				//Grafico do Mascaramento
				//-----------------------
					Grafico2()
				EndIf
			
			Else

				If lMascVa
		   			If mv_par04 == 2   //Imprime resultado Normal apenas se requisitado
						//-----------------
						//Grafico do Limiar/Masc.
						//-----------------
						Grafico1()
		   			EndIf
				Else
					//-----------------
					//Grafico do Limiar/Masc.
					//-----------------
					Grafico1()
				EndIf

			    //-----------------------
			    //Tabelas do Mascaramento
			    //-----------------------
			    //OD
			   	TAB488( "ODO050ma", -1 )
			   	TAB488( "ODO1ma", -1 )
			   	TAB488( "ODO2ma", -1 )
			   	TAB488( "ODO3ma", -1 )
			   	TAB488( "ODO4ma", -1 )
				//OE
			   	TAB488( "OEO050ma", -1 )
			   	TAB488( "OEO1ma", -1 )
			   	TAB488( "OEO2ma", -1 )
			   	TAB488( "OEO3ma", -1 )
			   	TAB488( "OEO4ma", -1 )
			EndIf
		EndIf

		IncProc()
		If nOssea > 0
			dbSelectArea( cAliasTRB1 )
			Dbgoto( RecOssea )
		EndIf
	Next nX

	If nAerea == 0
	    //-----------------------------
	    //Tabelas de Limiar - Via Aerea
	    //-----------------------------
	    //OD
	   	TAB488( "ODA025", -1 )
	   	TAB488( "ODA050", -1 )
	   	TAB488( "ODA1", -1 )
	   	TAB488( "ODA2", -1 )
	   	TAB488( "ODA3", -1 )
	   	TAB488( "ODA4", -1 )
	   	TAB488( "ODA6", -1 )
		TAB488( "ODA8", -1 )
		//OE
	   	TAB488( "OEA025", -1 )
	   	TAB488( "OEA050", -1 )
	   	TAB488( "OEA1", -1 )
	   	TAB488( "OEA2", -1 )
	   	TAB488( "OEA3", -1 )
	   	TAB488( "OEA4", -1 )
	   	TAB488( "OEA6", -1 )
		TAB488( "OEA8", -1 )

		//--------------------------------------------
		//Resultados e Medias da Via Aérea (em branco)
		//--------------------------------------------
		Exame2()

	    //-----------------------
	    //Tabelas do Mascaramento
	    //-----------------------
	    //OD
	   	TAB488( "ODA025ma", -1 )
	   	TAB488( "ODA050ma", -1 )
	   	TAB488( "ODA1ma", -1 )
	   	TAB488( "ODA2ma", -1 )
	   	TAB488( "ODA3ma", -1 )
	   	TAB488( "ODA4ma", -1 )
	   	TAB488( "ODA6ma", -1 )
		TAB488( "ODA8ma", -1 )
		//OE
	   	TAB488( "OEA025ma", -1 )
	   	TAB488( "OEA050ma", -1 )
	   	TAB488( "OEA1ma", -1 )
	   	TAB488( "OEA2ma", -1 )
	   	TAB488( "OEA3ma", -1 )
	   	TAB488( "OEA4ma", -1 )
	   	TAB488( "OEA6ma", -1 )
		TAB488( "OEA8ma", -1 )
	EndIf

	If nOssea == 0
	    //-----------------------------
	    //Tabelas de Limiar - Via Ossea
	    //-----------------------------
	    //OD
	   	TAB488( "ODO050", -1 )
	   	TAB488( "ODO1", -1 )
	   	TAB488( "ODO2", -1 )
	   	TAB488( "ODO3", -1 )
	   	TAB488( "ODO4", -1 )
		//OE
	   	TAB488( "OEO050", -1 )
	   	TAB488( "OEO1", -1 )
	   	TAB488( "OEO2", -1 )
	   	TAB488( "OEO3", -1 )
	   	TAB488( "OEO4", -1 )

	    //-----------------------
	    //Tabelas do Mascaramento
	    //-----------------------
	    //OD
	   	TAB488( "ODO050ma", -1 )
	   	TAB488( "ODO1ma", -1 )
	   	TAB488( "ODO2ma", -1 )
	   	TAB488( "ODO3ma", -1 )
	   	TAB488( "ODO4ma", -1 )
		//OE
	   	TAB488( "OEO050ma", -1 )
	   	TAB488( "OEO1ma", -1 )
	   	TAB488( "OEO2ma", -1 )
	   	TAB488( "OEO3ma", -1 )
	   	TAB488( "OEO4ma", -1 )
	EndIf

	//------------------
	//Atualiza documento
	//------------------
	OLE_ExecuteMacro( oWord, "Atualiza" )

	If mv_par09 == 2 // Se não imprime logo
		OLE_ExecuteMacro( oWord, 'deleta_logo' )
	EndIf
	If Mv_par05 == 2 //Se nao imprime medias
		OLE_ExecuteMacro( oWord, "Deleta_tab9" )
	EndIf
	If Mv_par06 == 2 //Se nao imprime parecer
		OLE_ExecuteMacro( oWord, "Deleta_tab8" )
	EndIf
	If Mv_par08 == 2 //Se nao imprime legendas
		OLE_ExecuteMacro( oWord, "Deleta_tabs" )
	EndIf

	If lImpress
		For i := 1 to MV_PAR03  //No. Copias
			OLE_SetProperty( oWord, '208', .F. )
			OLE_PrintFile( oWord, "ALL", , , 1 )
		Next i
	Else
		OLE_SetProperty( oWord, oleWdVisible, .T. )
		OLE_ExecuteMacro( oWord, "Maximiza_Tela" )
		If !lMdtUnix //Se for windows
			If DIRR488( cRootPath+cBarraSrv+"RELATO"+cBarraSrv )
				OLE_SaveAsFile( oWord, cRootPath+cBarraSrv+"RELATO"+cBarraSrv+cArqSaida, , , .F., oleWdFormatDocument )
			Else
				OLE_SaveAsFile( oWord, cPathEst+cArqSaida, , , .F., oleWdFormatDocument )
			EndIf
		EndIf
		OLE_ExecuteMacro( oWord, "Atualiza" )
		OLE_ExecuteMacro( oWord, "Posiciona_Cursor" )
		MsgInfo( STR0046 ) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
	EndIf
	OLE_CloseLink( oWord )

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} MATRIZLIM
Monta a matriz com as referencia do exame (LIMIAR)

@type function

@source MDTR488.prx

@author Denis Hyroshi de Souza
@since 07/03/2003

@param nVALOR, Numerico, Valor preenchido
@param nCOL, Numerico, Coluna preenchida


@sample MATRIZLIM( 100 , 3 )

@return Lógico, Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function MATRIZLIM( nVALOR, nCOL )

	Local nposHZ, nposDB, nPos, cLegenda, nLIN
	Local lAusente := .F.
	Local aFldAus := { "TM9_ODAS25", "TM9_ODAS50", "TM9_ODAS10", "TM9_ODAS20", "TM9_ODAS30", "TM9_ODAS40",;
					   "TM9_ODAS60", "TM9_ODAS80", "TM9_OEAS25", "TM9_OEAS50", "TM9_OEAS10", "TM9_OEAS20",;
					   "TM9_OEAS30", "TM9_OEAS40", "TM9_OEAS60", "TM9_OEAS80" }

	If TM9->TM9_INDVIA == "2"  //Via Ossea
		If nVALOR == -2 .Or. nVALOR == -4//Ausente
			If !Empty( &( "TM9->" + aFldAus[ nCol ] ) )
				nVALOR := Val( cValToChar( &( "TM9->" + aFldAus[ nCol ] ) ) )
			Else
				nVALOR := 75
			EndIf
			lAusente := .T.
		EndIf
	Else
		If nVALOR == -2 .Or. nVALOR == -4//Ausente
			If !Empty( &( "TM9->" + aFldAus[ nCol ] ) )
				nVALOR := Val( cValToChar( &( "TM9->" +  aFldAus[ nCol ] ) ) )
			Else
				nVALOR := 130
			EndIf
			lAusente := .T.
		EndIf
	EndIf

	nLIN := aScan( aDICBS, {|X| X == nVALOR} )
	If nLIN <= 0
		Return .T.
	EndIf

	nPos   := nLIN
	nposDB := aposDB[nPos]
	nposHZ := aposHZ[nCOL]

	cLegenda := "1"

	If lAusente
		cLegenda := "3"
		If nCol <= 8   //OD
			If TM9->TM9_INDVIA = "1"
				cLegenda := "3"
			Else
				cLegenda := "7"
		    EndIf
		Else          //OE
			If TM9->TM9_INDVIA = "1"
				cLegenda := "4"
			Else
				cLegenda := "8"
		    EndIf
		EndIf
	Else
		If nCol <= 8  //OD
			If TM9->TM9_INDVIA = "1"
				cLegenda := "1"
			Else
				cLegenda := "5"
		    EndIf
		Else         //OE
			If TM9->TM9_INDVIA = "1"
				cLegenda := "2"
			Else
				cLegenda := "6"
		    EndIf
		End
	EndIf

	If lPrimeira
		lPrimeira := .F.
	EndIf

	If nDBInicio = 0 .And. nHZInicio = 0

		If lAusente

			lAusAnt := .T.

		EndIf

		nDBInicio := nposDB
		nHZInicio := nposHZ

		OLE_SetDocumentVar( oWord, "HZini", nHZInicio )
		OLE_SetDocumentVar( oWord, "DBini", nDBInicio )
		OLE_SetDocumentVar( oWord, "HZfim", nposHZ )
		OLE_SetDocumentVar( oWord, "DBfim", nposDB )
		OLE_SetDocumentVar( oWord, "legenda", cLegenda )

		OLE_ExecuteMacro( oWord, "Imprime_shape1" )

	Else

		OLE_SetDocumentVar( oWord, "HZini", nHZInicio )
		OLE_SetDocumentVar( oWord, "DBini", nDBInicio )
		OLE_SetDocumentVar( oWord, "HZfim", nposHZ )
		OLE_SetDocumentVar( oWord, "DBfim", nposDB )
		OLE_SetDocumentVar( oWord, "legenda", cLegenda )

		If TM9->TM9_INDVIA = "1" .And. !lAusente .And. !lAusAnt

			If nCOL <= 8
				OLE_ExecuteMacro( oWord, "OrelhaDireita" )
			Else
				OLE_ExecuteMacro( oWord, "OrelhaEsquerda" )
			EndIf

		EndIf

		OLE_ExecuteMacro( oWord, "Imprime_shape1" )

	EndIf

	If lAusente

		lAusAnt := .T.

	Else

		lAusAnt	:= .F.

	EndIf

	nDBInicio := nposDB
	nHZInicio := nposHZ

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MATRIZMAS
Manta a matriz com as referencia do exame (MASCARAMENTO)

@type function

@source MDTR488.prx

@author Andre Perez Alvarez
@since 23/08/2007

@param nTmpVALOR, Numerico, Valor preenchido
@param nCOL, Numerico, Coluna preenchida
@param nValLimiar, Valor liminar

@sample MATRIZMAS( 1 , 3 , 4 )

@return Lógico, Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function MATRIZMAS( nTmpVALOR, nCOL, nValLimiar )

	Local nposHZ, nposDB, nPos, cLegenda, nLIN
	Local lAusente    := .F.
	Local aFldAus     := { "TM9_OD025K", "TM9_OD05KH", "TM9_OD1KHZ", "TM9_OD2KHZ", "TM9_OD3KHZ", "TM9_OD4KHZ", "TM9_OD6KHZ",;
					       "TM9_OD8KHZ", "TM9_OE025K", "TM9_OE05KH", "TM9_OE1KHZ", "TM9_OE2KHZ", "TM9_OE3KHZ", "TM9_OE4KHZ",;
					       "TM9_OE6KHZ", "TM9_OE8KHZ"}				   
	Local aFldMascAus := { "TM9_ODAS25", "TM9_ODAS50", "TM9_ODAS10", "TM9_ODAS20", "TM9_ODAS30", "TM9_ODAS40",;
						   "TM9_ODAS60", "TM9_ODAS80", "TM9_OEAS25", "TM9_OEAS50", "TM9_OEAS10", "TM9_OEAS20",;
					       "TM9_OEAS30", "TM9_OEAS40", "TM9_OEAS60", "TM9_OEAS80" }
	Local nVALOR := nTmpVALOR

	If TM9->TM9_INDVIA == "2"  //Via Ossea
		If nVALOR == -2 //Ausente
			nVALOR := -1
		ElseIf nVALOR == -3 .Or. ( nVALOR == -3 .And. nValLimiar == -2 ) .Or.;
				( nValLimiar == -4 .And. nVALOR >= 0 .Or. nVALOR == -10 .Or.;
				nVALOR == -5 ) //Mascaramento - Mascaramento e Ausência
			If !FWIsInCallStack( "MDTR488" )
				If !Empty( cValToChar( &( aFldAus[ nCol ] ) ) )
					nVALOR := Val( cValToChar( &( aFldAus[ nCol ] ) ) )
				EndIf				
			ElseIf !Empty( &( "TM9->" + aFldAus[ nCol ] ) )
				nVALOR := Val( cValToChar( &( "TM9->" + aFldAus[ nCol ] ) ) )
			EndIf
		Else
			nVALOR := nValLimiar
		EndIf
	Else
		If nVALOR == -2 //Ausente
			nVALOR := -1
		ElseIf nVALOR == -3 .Or. ( nVALOR == -3 .And. nValLimiar == -2 ) .Or.;
				( nValLimiar == -4 .And. nVALOR >= 0 .Or. nVALOR == -10 .Or.;
				nVALOR == -5 ) //Mascaramento - Mascaramento e Ausência
			If !FWIsInCallStack( "MDTR488" )
				If Val( cValToChar( &( aFldAus[ nCol ] ) ) ) != 0
					nVALOR := Val( cValToChar( &( aFldAus[ nCol ] ) ) )
				Else
					nVALOR := Val( cValToChar( &( "TM9->" + aFldMascAus[ nCol ] ) ) )
				EndIf				
			ElseIf !Empty( &( "TM9->" + aFldAus[ nCol ] ) )
				nVALOR := Val( cValToChar( &( "TM9->" + aFldAus[ nCol ] ) ) )
			EndIf
		Else
			nVALOR := nValLimiar
		EndIf
	EndIf

	If ( nValLimiar == -2 .And. nVALOR == -2 ) .Or. ( nValLimiar == -4 .And. nvalor == -4 ) .Or.;
	   ( nValLimiar == -4 .And. nvalor == 0 ) .Or. nVALOR == -1
		
		nVALOR := Val( cValToChar( &( "TM9->" + aFldMascAus[ nCol ] ) ) )

		If nVALOR == 0 .And. TM9->TM9_INDVIA == "1"
			nVALOR := 130
		ElseIf nVALOR == 0 .And. TM9->TM9_INDVIA == "2"
			nVALOR := 75
		EndIf

	EndIf

	If nValLimiar == -2 .Or. nValLimiar == -4 .Or. nvalor == -3
		lAusente := .T.
	EndIf

	nLIN := aScan( aDICBS, {|X| X == nVALOR} )
	If nLIN <= 0
		Return .T.
	EndIf

	nPos   := nLIN

	nposDB := aPosDB[ nPos ]
	nposHZ := aPosHZ[ nCOL ]

	cLegenda := "1"

	If lAusente
		cLegenda := "3"
		If nCol <= 8   //OD
			If TM9->TM9_INDVIA = "1"
				cLegenda := "3"
			Else
				cLegenda := "7"
		    EndIf
		Else          //OE
			If TM9->TM9_INDVIA = "1"
				cLegenda := "4"
			Else
				cLegenda := "8"
		    EndIf
		EndIf
	Else
		If nCol <= 8  //OD
			If TM9->TM9_INDVIA = "1"
				cLegenda := "1"
			Else
				cLegenda := "5"
		    EndIf
		Else         //OE
			If TM9->TM9_INDVIA = "1"
				cLegenda := "2"
			Else
				cLegenda := "6"
		    EndIf
		End
	EndIf

	If lPrimeira
		nDBInicio := nposDB
		nHZInicio := nposHZ
		lPrimeira := .F.
	EndIf

	If nDBInicio = 0 .And. nHZInicio = 0

		If lAusente

			lAusAnt	:= .T.

		EndIf

		nDBInicio := nposDB
		nHZInicio := nposHZ

		OLE_SetDocumentVar( oWord, "HZini", nHZInicio )
		OLE_SetDocumentVar( oWord, "DBini", nDBInicio )
		OLE_SetDocumentVar( oWord, "HZfim", nposHZ )
		OLE_SetDocumentVar( oWord, "DBfim", nposDB )
		OLE_SetDocumentVar( oWord, "legenda", cLegenda )

		OLE_ExecuteMacro( oWord, "Imprime_shape2" )

	Else

		OLE_SetDocumentVar( oWord, "HZini", nHZInicio )
		OLE_SetDocumentVar( oWord, "DBini", nDBInicio )
		OLE_SetDocumentVar( oWord, "HZfim", nposHZ )
		OLE_SetDocumentVar( oWord, "DBfim", nposDB )
		OLE_SetDocumentVar( oWord, "legenda", cLegenda )

		OLE_ExecuteMacro( oWord, "Imprime_shape2" )

		If TM9->TM9_INDVIA == "1" .And. !lAusente .And. !lAusAnt // Via Aérea
			If nCOL <= 8
				OLE_ExecuteMacro( oWord, "OrelhaDireita" )
			Else
				OLE_ExecuteMacro( oWord, "OrelhaEsquerda" )
			EndIf
		EndIf

	EndIf

	If lAusente

		lAusAnt := .T.

	Else

		lAusAnt	:= .F.

	EndIf

	nDBInicio := nposDB
	nHZInicio := nposHZ

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} TAB488
Coloca o valor correto dentro da tabela de decibeis.

@author  Andre Perez Alvarez
@since   22/03/2007
@sample   TAB488("ODA025ma", 1, 2)

@param   cVarWord, caractere, Variavel a ser atualizada dentro da planiha do limiar
@param   nValor,   numérico, Valor do limiar
@param   nValLin,  numérico, Valor da linha
@return  Lógico,   sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function TAB488( cVarWord, nValor, nValLin )

	Default nValLin := 0

	If nValor == -1 .Or. nValor == -3
		OLE_SetDocumentVar( oWord, cVarWord, "" )
	ElseIf nValor == -2 .Or. nValLin == -4 .Or. nValor == -4
		OLE_SetDocumentVar( oWord, cVarWord, "A" )
	Else
		OLE_SetDocumentVar( oWord, cVarWord, nValor )
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Exame1
Mostra os Resultados e as Médias da Via Aérea

@author  Andre Perez Alvarez
@since   22/03/2007
@sample  Exame1()

@return  Lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function Exame1()

	//Resultados
	//Portaria 19 - OD
	If TM9->TM9_ODRESU = '1'
	   	OLE_SetDocumentVar( oWord, "PortOD1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_ODRESU = '2'
	   	OLE_SetDocumentVar( oWord, "PortOD1", STR0054 )  //"Limiares Aceitáveis"
	ElseIf TM9->TM9_ODRESU = '3'
	   	OLE_SetDocumentVar( oWord, "PortOD1", STR0055 )  //'Sugestivo de PAIR'
	ElseIf TM9->TM9_ODRESU = '4'
		OLE_SetDocumentVar( oWord, "PortOD1", STR0056 )  //'Não Sugestivo de PAIR'
	ElseIf TM9->TM9_ODRESU = '5'
		OLE_SetDocumentVar( oWord, "PortOD1", STR0057 )  //'Sugestivo de Desencadeamento'
	ElseIf TM9->TM9_ODRESU = '6'
		OLE_SetDocumentVar( oWord, "PortOD1", STR0058 )  //'Sugestivo de Agravamento'
	ElseIf TM9->TM9_ODRESU = '7'
		OLE_SetDocumentVar( oWord, "PortOD1", STR0059 )  //'Perda Auditiva'
	Else
		OLE_SetDocumentVar( oWord, "PortOD1", STR0053 )  //"Requer Interpretação"
	EndIf
	//Portaria 19 - OE
	If TM9->TM9_OERESU = '1'
	   	OLE_SetDocumentVar( oWord, "PortOE1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_OERESU = '2'
	   	OLE_SetDocumentVar( oWord, "PortOE1", STR0054 )  //"Limiares Aceitáveis"
	ElseIf TM9->TM9_OERESU = '3'
	   	OLE_SetDocumentVar( oWord, "PortOE1", STR0055 )  //'Sugestivo de PAIR'
	ElseIf TM9->TM9_OERESU = '4'
		OLE_SetDocumentVar( oWord, "PortOE1", STR0056 )  //'Não Sugestivo de PAIR'
	ElseIf TM9->TM9_OERESU = '5'
		OLE_SetDocumentVar( oWord, "PortOE1", STR0057 )  //'Sugestivo de Desencadeamento'
	ElseIf TM9->TM9_OERESU = '6'
		OLE_SetDocumentVar( oWord, "PortOE1", STR0058 )  //'Sugestivo de Agravamento'
	ElseIf TM9->TM9_OERESU = '7'
		OLE_SetDocumentVar( oWord, "PortOE1", STR0059 )  //'Perda Auditiva'
	Else
		OLE_SetDocumentVar( oWord, "PortOE1", STR0053 )  //"Requer Interpretação"
	EndIf

	//Clinico - OD
	If TM9->TM9_ODCLIN = '1'
	   	OLE_SetDocumentVar( oWord, "CliOD1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_ODCLIN = '2'
		OLE_SetDocumentVar( oWord, "CliOD1", STR0069 )  //"Normal"
	ElseIf TM9->TM9_ODCLIN = '3'
		OLE_SetDocumentVar( oWord, "CliOD1", STR0070 )  //"Surdez Leve"
	ElseIf TM9->TM9_ODCLIN = '4'
		OLE_SetDocumentVar( oWord, "CliOD1", STR0071 )  //"Surdez Moderada"
	ElseIf TM9->TM9_ODCLIN = '5'
		OLE_SetDocumentVar( oWord, "CliOD1", STR0072 )  //"Surdez Severa"
	ElseIf TM9->TM9_ODCLIN = '6'
		OLE_SetDocumentVar( oWord, "CliOD1", STR0073 )  //"Surdez Profunda"
	ElseIf TM9->TM9_ODCLIN = '7'
	 	OLE_SetDocumentVar( oWord, "CliOD1", STR0074 )  //"Surdez Total"
	Else
		OLE_SetDocumentVar( oWord, "CliOD1", STR0053 )  //"Requer Interpretação"
	EndIf
	//Clinico - OE
	If TM9->TM9_OECLIN = '1'
	 	OLE_SetDocumentVar( oWord, "CliOE1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_OECLIN = '2'
		OLE_SetDocumentVar( oWord, "CliOE1", STR0069 )  //"Normal"
	ElseIf TM9->TM9_OECLIN = '3'
		OLE_SetDocumentVar( oWord, "CliOE1", STR0070 )  //"Surdez Leve"
	ElseIf TM9->TM9_OECLIN = '4'
		OLE_SetDocumentVar( oWord, "CliOE1", STR0071 )  //"Surdez Moderada"
	ElseIf TM9->TM9_OECLIN = '5'
		OLE_SetDocumentVar( oWord, "CliOE1", STR0072 )  //"Surdez Severa"
	ElseIf TM9->TM9_OECLIN = '6'
		OLE_SetDocumentVar( oWord, "CliOE1", STR0073 )  //"Surdez Profunda"
	ElseIf TM9->TM9_OECLIN = '7'
	 	OLE_SetDocumentVar( oWord, "CliOE1", STR0074 )  //"Surdez Total"
	Else
		OLE_SetDocumentVar( oWord, "CliOE1", STR0053 )  //"Requer Interpretação"
	EndIf


	//INSS - OD
	If TM9->TM9_ODINSS = '1'
	   	OLE_SetDocumentVar( oWord, "InssOD1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_ODINSS = '2'
		OLE_SetDocumentVar( oWord, "InssOD1", STR0069 )  //"Normal"
	ElseIf TM9->TM9_ODINSS = '3'
		OLE_SetDocumentVar( oWord, "InssOD1", STR0082 )  //"Redução em Grau Mínimo"
	ElseIf TM9->TM9_ODINSS = '4'
		OLE_SetDocumentVar( oWord, "InssOD1", STR0083 )  //"Redução em Grau Médio"
	ElseIf TM9->TM9_ODINSS = '5'
		OLE_SetDocumentVar( oWord, "InssOD1", STR0084 )  //"Redução em Grau Máximo"
	ElseIf TM9->TM9_ODINSS = '6'
		OLE_SetDocumentVar( oWord, "InssOD1", STR0085 )  //"Perda de Audição"
	Else
		OLE_SetDocumentVar( oWord, "InssOD1", STR0053 )  //"Requer Interpretação"
	EndIf
	//INSS - OE
	If TM9->TM9_OEINSS = '1'
	   	OLE_SetDocumentVar( oWord, "InssOE1", STR0053 )  //"Requer Interpretação"
	ElseIf TM9->TM9_OEINSS = '2'
		OLE_SetDocumentVar( oWord, "InssOE1", STR0069 )  //"Normal"
	ElseIf TM9->TM9_OEINSS = '3'
		OLE_SetDocumentVar( oWord, "InssOE1", STR0082 )  //"Redução em Grau Mínimo"
	ElseIf TM9->TM9_OEINSS = '4'
		OLE_SetDocumentVar( oWord, "InssOE1", STR0083 )  //"Redução em Grau Médio"
	ElseIf TM9->TM9_OEINSS = '5'
		OLE_SetDocumentVar( oWord, "InssOE1", STR0084 )  //"Redução em Grau Máximo"
	ElseIf TM9->TM9_OEINSS = '6'
		OLE_SetDocumentVar( oWord, "InssOE1", STR0085 )  //"Perda de Audição"
	Else
		OLE_SetDocumentVar( oWord, "InssOE1", STR0053 )	 //"Requer Interpretação"
	EndIf

	********************************************************
	//Medias
	********************************************************
	If TM9->TM9_ODMED5 != 999.99
		nODMED5 := STRMED120( TM9->TM9_ODMED5 )
	Else
		nODMED5 := ""
	EndIf
	If TM9->TM9_OEMED5 != 999.99
		nOEMED5 := STRMED120( TM9->TM9_OEMED5 )
	Else
		nOEMED5 := ""
	EndIf
	If TM9->TM9_ODMED3 != 999.99
		nODMED3 := STRMED120( TM9->TM9_ODMED3 )
	Else
		nODMED3 := ""
	EndIf
	If TM9->TM9_OEMED3 != 999.99
		nOEMED3 := STRMED120( TM9->TM9_OEMED3 )
	Else
		nOEMED3 := ""
	EndIf

	OLE_SetDocumentVar( oWord, "nMed512OD", nODMED5 )
	OLE_SetDocumentVar( oWord, "nMed512OE", nOEMED5 )
	OLE_SetDocumentVar( oWord, "nMed346OD", nODMED3 )
	OLE_SetDocumentVar( oWord, "nMed346OE", nOEMED3 )
	********************************************************

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Exame2
Mostra os Resultados e as Médias da Via Aérea (em branco)

@author  Andre Perez Alvarez
@since   27/08/2007
@sample  Exame2()

@return  Lógico, sempre verdadeiro
/*/
//-------------------------------------------------------------------
Static Function Exame2()

	//Resultados
	//Portaria 19 - OD
	OLE_SetDocumentVar( oWord, "PortOD1", "" )
	//Portaria 19 - OE
	OLE_SetDocumentVar( oWord, "PortOE1", "" )
	//Clinico - OD
	OLE_SetDocumentVar( oWord, "CliOD1", "" )
	//Clinico - OE
	OLE_SetDocumentVar( oWord, "CliOE1", "" )
	//INSS - OD
	OLE_SetDocumentVar( oWord, "InssOD1", "" )
	//INSS - OE
	OLE_SetDocumentVar( oWord, "InssOE1", "" )

	//Medias
	OLE_SetDocumentVar( oWord, "nMed512OD", "" )
	OLE_SetDocumentVar( oWord, "nMed512OE", "" )
	OLE_SetDocumentVar( oWord, "nMed346OD", "" )
	OLE_SetDocumentVar( oWord, "nMed346OE", "" )

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} Grafico1
Monta o grafico - LIMIAR (Via Aerea ou Ossea)

@type function

@source MDTR488.prx

@author Andre Perez Alvarez
@since 22/03/2007

@sample Grafico1()

@return Sempre Verdadeiro.
/*/
//---------------------------------------------------------------------
Static Function Grafico1()


	Private lPrimeira := .T.
	Private lAusAnt	  := .F.

	//---------------
	// ORELHA DIREITA
	//---------------
	nDBInicio := 0
	nHZInicio := 0

	//nVALOR,nCOL
	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_ODMA25 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA25 != -1 .Or.;
		TM9->TM9_ODMA25 > 0 .And. TM9->TM9_OD025K > 0 .Or. TM9->TM9_OD025K == -4 //Via Aerea
		MATRIZMAS( TM9->TM9_ODMA25, 1, TM9->TM9_OD025K )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OD025K, 1 )
	EndIf

	If cValToChar( TM9->TM9_ODMA50 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA50 != -1 .Or.;
	 TM9->TM9_ODMA50 > 0 .And. TM9->TM9_OD05KH > 0 .Or. TM9->TM9_OD05KH == -4
		MATRIZMAS( TM9->TM9_ODMA50, 2, TM9->TM9_OD05KH )
	Else
		MATRIZLIM( TM9->TM9_OD05KH , 2 )
	EndIf
	
	If cValToChar( TM9->TM9_ODMA10 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA10 != -1 .Or.;
	 TM9->TM9_ODMA10 > 0 .And. TM9->TM9_OD1KHZ > 0 .Or. TM9->TM9_OD1KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA10, 3, TM9->TM9_OD1KHZ )
	Else
		MATRIZLIM( TM9->TM9_OD1KHZ , 3 )
	EndIf
	
	If cValToChar( TM9->TM9_ODMA20 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA20 != -1 .Or.;
	 TM9->TM9_ODMA20 > 0 .And. TM9->TM9_OD2KHZ > 0 .Or. TM9->TM9_OD2KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA20, 4, TM9->TM9_OD2KHZ )
	Else
		MATRIZLIM( TM9->TM9_OD2KHZ , 4 )
	EndIf
	
	If cValToChar( TM9->TM9_ODMA30 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA30 != -1 .Or.;
	 TM9->TM9_ODMA30 > 0 .And. TM9->TM9_OD3KHZ > 0 .Or. TM9->TM9_OD3KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA30, 5, TM9->TM9_OD3KHZ )
	Else
		MATRIZLIM( TM9->TM9_OD3KHZ , 5 )
	EndIf

	If cValToChar( TM9->TM9_ODMA40 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA40 != -1 .Or.;
		TM9->TM9_ODMA40 > 0 .And. TM9->TM9_OD4KHZ > 0 .Or. TM9->TM9_OD4KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA40, 6, TM9->TM9_OD4KHZ )
	Else
		MATRIZLIM( TM9->TM9_OD4KHZ , 6 )
	EndIf

	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_ODMA60 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA60 != -1 .Or.;
	   TM9->TM9_ODMA60 > 0 .And. TM9->TM9_OD6KHZ > 0 .Or. TM9->TM9_OD6KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA60, 7, TM9->TM9_OD6KHZ )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OD6KHZ, 7 )
	EndIf

	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_ODMA80 ) $( " -5 / -3 " ) .Or. TM9->TM9_ODMA80 != -1 .Or.;
		TM9->TM9_ODMA80 > 0 .And. TM9->TM9_OD8KHZ > 0 .Or. TM9->TM9_OD8KHZ == -4
		MATRIZMAS( TM9->TM9_ODMA80, 8, TM9->TM9_OD8KHZ )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OD8KHZ, 8 )
	EndIf

	//----------------
	// ORELHA ESQUERDA
	//----------------

	nDBInicio := 0
	nHZInicio := 0

	//nVALOR,nCOL
	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_OEMA25 ) $( " -5 / -3 " ) .Or.;
	 TM9->TM9_OEMA25 != -1 .Or. TM9->TM9_OEMA25 > 0 .And. TM9->TM9_OE025K > 0 .Or. TM9->TM9_OE025K == -4//Via Aerea
		MATRIZMAS( TM9->TM9_OEMA25, 9, TM9->TM9_OE025K )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OE025K, 9 )
	EndIf

	If cValToChar( TM9->TM9_OEMA50 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA50 != -1 .Or.;
	 TM9->TM9_OEMA50 > 0 .And. TM9->TM9_OE05KH > 0 .Or. TM9->TM9_OE05KH == -4
		MATRIZMAS( TM9->TM9_OEMA50, 10, TM9->TM9_OE05KH )
	Else
		MATRIZLIM( TM9->TM9_OE05KH , 10 )
	EndIf
	
	If cValToChar( TM9->TM9_OEMA10 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA10 != -1 .Or.;
	 TM9->TM9_OEMA10 > 0 .And. TM9->TM9_OE1KHZ > 0 .Or. TM9->TM9_OE1KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA10, 11, TM9->TM9_OE1KHZ )
	Else
		MATRIZLIM( TM9->TM9_OE1KHZ , 11 )
	EndIf
	
	If cValToChar( TM9->TM9_OEMA20 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA20 != -1 .Or.;
	 TM9->TM9_OEMA20 > 0 .And. TM9->TM9_OE2KHZ > 0 .Or. TM9->TM9_OE2KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA20, 12, TM9->TM9_OE2KHZ )
	Else
		MATRIZLIM( TM9->TM9_OE2KHZ , 12 )
	EndIf
	
	If cValToChar( TM9->TM9_OEMA30 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA30 != -1 .Or.;
	 TM9->TM9_OEMA30 > 0 .And. TM9->TM9_OE3KHZ > 0 .Or. TM9->TM9_OE3KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA30, 13, TM9->TM9_OE3KHZ )
	Else
		MATRIZLIM( TM9->TM9_OE3KHZ , 13 )
	EndIf

	If cValToChar( TM9->TM9_OEMA40 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA40 != -1 .Or.;
	 TM9->TM9_OEMA40 > 0 .And. TM9->TM9_OE4KHZ > 0 .Or. TM9->TM9_OE4KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA40, 14, TM9->TM9_OE4KHZ )
	Else
		MATRIZLIM( TM9->TM9_OE4KHZ , 14 )
	EndIf

	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_OEMA60 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA60 != -1 .Or.;
		TM9->TM9_OEMA60 > 0 .And. TM9->TM9_OE6KHZ > 0 .Or. TM9->TM9_OE6KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA60, 15, TM9->TM9_OE6KHZ )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OE6KHZ, 15 )
	EndIf

	If TM9->TM9_INDVIA == "1" .And. cValToChar( TM9->TM9_OEMA80 ) $( " -5 / -3 " ) .Or. TM9->TM9_OEMA80 != -1 .Or.;
		TM9->TM9_OEMA80 > 0 .And. TM9->TM9_OE8KHZ > 0 .Or. TM9->TM9_OE8KHZ == -4
		MATRIZMAS( TM9->TM9_OEMA80, 16, TM9->TM9_OE8KHZ )
	ElseIf TM9->TM9_INDVIA == "1"
		MATRIZLIM( TM9->TM9_OE8KHZ, 16 )
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} Grafico2
Monta o grafico - MASCARAMENTO (Via Aerea ou Ossea)

@type function

@source MDTR488.prx

@author Andre Perez Alvarez
@since 23/08/2007

@sample Grafico2()

@return Lógico, Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function Grafico2()

	//----------------
	// ORELHA DIREITA
	//----------------
	//nVALOR,nCOL

	Private lPrimeira := .T.
	Private lAusAnt	  := .F.

	nDBInicio := 0
	nHZInicio := 0

	If TM9->TM9_INDVIA == "1"  //Via Aerea
	
		MATRIZMAS( TM9->TM9_ODMA25, 1, TM9->TM9_OD025K )

	EndIf
	MATRIZMAS( TM9->TM9_ODMA50, 2, TM9->TM9_OD05KH )
	MATRIZMAS( TM9->TM9_ODMA10, 3, TM9->TM9_OD1KHZ )
	MATRIZMAS( TM9->TM9_ODMA20, 4, TM9->TM9_OD2KHZ )
	MATRIZMAS( TM9->TM9_ODMA30, 5, TM9->TM9_OD3KHZ )
	MATRIZMAS( TM9->TM9_ODMA40, 6, TM9->TM9_OD4KHZ )
	If TM9->TM9_INDVIA == "1"  //Via Aerea
		MATRIZMAS( TM9->TM9_ODMA60, 7, TM9->TM9_OD6KHZ )
		MATRIZMAS( TM9->TM9_ODMA80, 8, TM9->TM9_OD8KHZ )
	EndIf

	//------------------
	// ORELHA ESQUERDA
	//------------------
	nDBInicio := 0
	nHZInicio := 0


	If TM9->TM9_INDVIA == "1"  //Via Aerea
		MATRIZMAS( TM9->TM9_OEMA25, 9, TM9->TM9_OE025K )
	EndIf
	MATRIZMAS( TM9->TM9_OEMA50, 10, TM9->TM9_OE05KH )
	MATRIZMAS( TM9->TM9_OEMA10, 11, TM9->TM9_OE1KHZ )
	MATRIZMAS( TM9->TM9_OEMA20, 12, TM9->TM9_OE2KHZ )
	MATRIZMAS( TM9->TM9_OEMA30, 13, TM9->TM9_OE3KHZ )
	MATRIZMAS( TM9->TM9_OEMA40, 14, TM9->TM9_OE4KHZ )
	If TM9->TM9_INDVIA == "1"  //Via Aerea
		MATRIZMAS( TM9->TM9_OEMA60, 15, TM9->TM9_OE6KHZ )
		MATRIZMAS( TM9->TM9_OEMA80, 16, TM9->TM9_OE8KHZ )
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} STRMED120
Faz tratamento da média.

@author  Andre Perez Alvarez
@since   10/08/2007
@sample  sample
@param   cCampo, caractere, campo para ser tratado
@return  caractere, texto tratado
/*/
//-------------------------------------------------------------------
Static Function STRMED120(cCampo)

Local cTexto
Local nLen

If ValType( cCampo ) == "N"
	cTexto := AllTrim( Str( cCampo ) )
Else
	cTexto := cCampo
EndIf

nLen := Len( cTexto )

If nLen == 6
	cTexto := Transform( cCampo, Trim( "@E 999.99" ) )
ElseIf nLen == 5
	cTexto := Transform( cCampo, Trim( "@E 99.99" ) )
ElseIf nLen == 4
	cTexto := Transform( cCampo, Trim( "@E 9.99" ) )
ElseIf !Empty( cTexto )
	cTexto := Transform( cCampo, Trim( "@E 999.99" ) )
EndIf

Return cTexto

//-------------------------------------------------------------------
/*/{Protheus.doc} MascReal
Indica se o mascaramento foi realizado.

@author  Andre Perez Alvarez
@since   16/08/2007
@sample  MascReal()

@return  lRet, lógico
/*/
//-------------------------------------------------------------------
Static Function MascReal()

	Local lRet := .F.

	If	TM9->TM9_ODMA25 != -1 .Or.;
		TM9->TM9_ODMA50 != -1 .Or.;
		TM9->TM9_ODMA10 != -1 .Or.;
		TM9->TM9_ODMA20 != -1 .Or.;
		TM9->TM9_ODMA30 != -1 .Or.;
		TM9->TM9_ODMA40 != -1 .Or.;
		TM9->TM9_ODMA60 != -1 .Or.;
		TM9->TM9_ODMA80 != -1 .Or.;
		TM9->TM9_OEMA25 != -1 .Or.;
		TM9->TM9_OEMA50 != -1 .Or.;
		TM9->TM9_OEMA10 != -1 .Or.;
		TM9->TM9_OEMA20 != -1 .Or.;
		TM9->TM9_OEMA30 != -1 .Or.;
		TM9->TM9_OEMA40 != -1 .Or.;
		TM9->TM9_OEMA60 != -1 .Or.;
		TM9->TM9_OEMA80 != -1
			lRet := .T.
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT488TM0
Browse das fichas médicas do cliente.

@author  Andre Perez Alvarez
@since   06/03/2008
@sample  U_MDT488TM0()

@return  Sempre nulo.
/*/
//-------------------------------------------------------------------
User Function MDT488TM0()

	Local aArea	:= GetArea()
	Local oldROTINA := aCLONE( aROTINA )
	Local oldCad := cCadastro
	cCliMdtPs := SA1->A1_COD+SA1->A1_LOJA

	aRotina := { { STR0001, "AxPesqui", 0, 1},;  //"Pesquisar"
				 { STR0002, "NGCAD01", 0, 2},;  //"Visualizar"
				 { STR0092, "MDTREXA", 0, 3} }  //"Exames"

	// Define o cabecalho da tela de atualizacoes
	cCadastro := OemtoAnsi( STR0091 )  //"Fichas Médicas"


	// Endereca a funcao de BROWSE
	DbSelectArea( "TM0" )
	Set Filter To TM0->(TM0_CLIENT+TM0_LOJA) == cCliMdtps
	DbSetOrder( 1 )
	mBrowse( 6, 1, 22, 75, "TM0" )

	DbSelectArea( "TM0" )
	Set Filter To

	aROTINA := aCLONE( oldROTINA )
	RestArea( aArea )
	cCadastro := oldCad

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} U_A488Invert()
Inverte marcacoes - Windows

@source MDTR488.prx

@author Paulo Pego
@since 09/11/99

@sample U_A488Invert()

@return Sempre Nulo.
/*/
//---------------------------------------------------------------------
User Function A488Invert()

	Local nREG := (cAliasTRB)->(RECNO())

	dbSelectArea( cAliasTRB )
	dbGoTop()
	Do While !EOF()
		(cAliasTRB)->TM9_OK := IIf( Empty( (cAliasTRB)->TM9_OK ), cMARCA, "  " )
		dbSkip()
	EndDo

	(cAliasTRB)->(dbGoTo( nREG ))
	lRefresh := .T.

Return Nil
