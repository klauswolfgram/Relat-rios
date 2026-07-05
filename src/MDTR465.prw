/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "mdtr465.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR465
Descrição Relatorio do Atestado de Saude Ocupacional (ASO). Para cada
exame medico obrigatorio previsto na NR7, o medico do trabalho devera
emitir o Atestado de Saude Ocuacional - (ASO), em duas vias (ha opcao
para se imprimir em ate 3 vias). Para emitir o ASO o programa devera
obter os parametros de selecao: Numero do ASO De: Ate:. O programa
buscara as informacoes para imprimir no aso nas tabelas:
	TMY - Dados do Atestado ( data, medico, parecer etc..)
	TMX - Riscos impressos no Aso - TMA - Nome dos Agentes
	TM5 - Exames impressos no Aso - TM4 - Nome dos Exames
		  Dados do Funcionario (matricula, c.custo, funcao)
	SRA - Dados do Funcionario (cpf,ctps,rg,admissao, nascim.)
	TMW - Parametros do PCMSO - medico coordenador

Apos realizada a emissao do ASO, o programa atualiza o campo data de
emissao na tabela TMY. O usuario podera escolher entre tres modelos
de ASO, sendo que no modelo 1 tera a opcao de imprimir 2 ASOs por
pagina. O ASO pode ser cancelado pelo usuario, os ASOs cancelados nao
serao impressos por este programa.

@type    function
@author  Marcio Costa
@since   12/01/2000
@sample  U_MDTR465()

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR465()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local wnrel     := "MDTR465"
	Local cDesc1    := STR0001  //"Atestado de Saude Ocupacional ( ASO ). Relaciona as informacoes referentes aos"
	Local cDesc2    := STR0002  //"exames realizados e os riscos a que o funcionario esta exposto. Atraves dos parametros"
	Local cDesc3    := STR0003  //"pode optar em imprimir um por pagina ou dois ASO's iguais na mesma pagina"
	Local cString   := "TMY"

	//Variáveis a serem utilizadas na integração com o eSocial
	Local leSocial := IIf( FindFunction( "MDTVldEsoc" ), MDTVldEsoc(), .F. )
	Local lImprime := .T.
	Local aInfASO  := {}

	//Variáveis private utilizadas para controlar quando a mensagem da integração com o eSocial deve ser disparada
	Private nASOTot  := 0
	Private nASOCont := 0

	Private nomeprog := "MDTR465"
	Private tamanho  := "P"
	Private aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "", 1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0052 //"ATESTADO DE SAUDE OCUPACIONAL"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := "MDT465    "
	Private cabec1   := ""
	Private cabec2   := ""
	Private nMdRel
	Private lDepto   := NGCADICBASE( "TMY_NOVDEP", "A", "TMY", .F. )
	Private cCodCoo := '' // Variável utilizada no relatório e no e-social
	Private cCodUsu	 := '' // Médico PCMSO escolhido

	If !MDTRESTRI( cPrograma )
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM( aNGBEGINPRM )
		Return .F.
	EndIf

	/*----------------------------------
	//PERGUNTAS PADRÃO					|
	| 01  De  Ficha ?                   |
	| 02  Ate Ficha ?                   |
	| 03  De  Dt. Programacao ?         |
	| 04  Ate Dt. Programacao ?         |
	| 05  ASOs por Pagina ?             |
	| 06  Cliente ?                     |
	| 07  Termo de Respons. ?           |
	| 08  Imprimir logomarca ?          |
	| 09  Listar Exames NR7 ?           |
	| 10  Modelo Impressao ?            |
	| 11  No. de Vias ?                 |
	| 12  Via entregue ao funcionario ? |
	| 13  Imprimir Apto c/ Restrições:  |
	|       1-como Inapto               |
	|       2-sem alteração             |
	| 14  Imprimir Riscos?              |
	| 15  Imprimir Parecer do Médico?   |
	| 16  Nome Atividade Func?          |
	| 17  Imprimir Restricoes?          |
	| 18  Agrupar exames por data ?     |
	| 19  Imp. Portador Deficiência?	|
	| 20  Endereço de cobrança ?		|
	|	      							|
	//PERGUNTAS PRESTADOR DE SERVIÇO	|
	| 01  De Cliente ?                  |
	| 02  Loja                          |
	| 03  Até Cliente ?                 |
	| 04  Loja							|
	| 05  De  Ficha ?                   |
	| 06  Ate Ficha ?                   |
	| 07  De  Dt. Programacao ?         |
	| 08  Ate Dt. Programacao ?         |
	| 09  ASOs por Pagina ?             |
	| 10  Termo de Respons. ?           |
	| 11  Imprimir logomarca ?          |
	| 12  Listar Exames NR7 ?           |
	| 13  Modelo Impressao ?            |
	| 14  No. de Vias ?                 |
	| 15  Via entregue ao funcionario ? |
	| 16  Imprimir Apto c/ Restrições:  |
	|       1-como Inapto               |
	|       2-sem alteração             |
	| 17  Imprimir Riscos?              |
	| 18  Imprimir Parecer do Médico?   |
	| 19  Nome Atividade Func?          |
	| 20  Imprimir Restricoes?          |
	| 21  Agrupar exames por data?      |
	| 22  Imp. Portador Deficiência?	|
	| 23  Endereço de cobrança ?		|
	------------------------------------*/

	// Verifica as perguntas selecionadas
	Pergunte( cPerg, .F. )

	//Envia controle para a funcao SETPRINT
	wnrel := SetPrint( cString, wnrel, cPerg, titulo, cDesc1, cDesc2, cDesc3, .F., "" )

	//Caso o valor da variável nLastKey for igual a 27 indica que o usuário cancelou a impressão do relatório
	lImprime := nLastKey <> 27

	//-------------------------------------------------------------------------------
	// Valida as informações a serem enviadas ao eSocial dos ASO's a serem impressos
	//-------------------------------------------------------------------------------
	If lImprime .And. leSocial //Caso houver integração com o eSocial
		
		dbSelectArea( "TMY" )
		dbSetOrder( 2 )
		dbSeek( xFilial( "TMY" ) + mv_par01, .T. )
		While TMY->( !Eof() ) .And. TMY->TMY_FILIAL == xFilial( "TMY" ) .And. TMY->TMY_NUMFIC <= mv_par02

			If Empty( TMY->TMY_DTEMIS ) .And. Empty( TMY->TMY_DTCANC ) .And. TMY->TMY_DTPROG >= MV_PAR03 .And. TMY->TMY_DTPROG <= MV_PAR04
				
				//Conta o número de ASO's processados
				nASOTot++

				aAdd( aInfASO, { TMY->TMY_NUMFIC, TMY->TMY_FILIAL + TMY->TMY_NUMASO } )
			EndIf
			TMY->( dbSkip() )
		End

		If Len( aInfASO ) > 0 //Caso existam ASO's a serem comunicados
			lImprime := MDTIntEsoc( "S-2220", 3, aInfASO, , .F. )
		EndIf

	EndIf

	//Caso houve integração com o eSocial apenas imprime caso não haja inconsistências
	If lImprime

		// Validação das Perguntas relacionadas as vias
		If ( MV_PAR11 < MV_PAR12 ) .Or. ( MV_PAR12 > MV_PAR11 )
			MsgInfo( STR0169, STR0168 ) // "O Número Total de Vias não pode ser menor que o número da via enviada ao funcionário"#"ATENÇÃO"
			U_MDTR465()
			Return .F.
		EndIf

		SetDefault( aReturn, cString )

		RptStatus( {|lEnd| R465Imp( @lEnd, wnRel, titulo, tamanho )}, titulo )

	EndIf

	//Zera o filtro
	Set Filter To

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R465Imp
Chamada do Relatório

@type    function
@author  Inacio Luiz Kolling
@since   18/04/2000
@sample  R450Imp( @lEnd, 'MDTR465', 'Relatório ASO', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Nome do relatório
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function R465Imp( lEnd, wnRel, titulo, tamanho )	

	//Variaveis para controle do cursor de progressao do relatorio
	Private lContinua := .T.
	// Contadores de linha e pagina
	Private li    := 80
	Private m_pag := 1
	// Verifica se deve comprimir ou nao
	Private oPrint := TMSPrinter():New( OemToAnsi( STR0052 ) ) //"ATESTADO DE SAUDE OCUPACIONAL"

	If mv_par10 == 2 .Or. mv_par10 == 3
		oPrint:SetPortrait() //Retrato
		oPrint:Setup()
	EndIf

	nTipo  := IIF( aReturn[4] == 1, 15, 18 )
	lPrint := .F.

	//Caso a validação dos registros a serem enviados ao eSocial estiverem ok, prossegue com a impressão
	dbSelectArea( "TMY" )
	dbSetOrder( 2 )
	dbSeek( xFilial( "TMY" )+mv_par01, .T. )

	SetRegua( LastRec() )
	While lContinua .And. !Eof() .And. TMY->TMY_FILIAL == xFIlial( 'TMY' ) .And. TMY->TMY_NUMFIC <= mv_par02

		If lEnd
			@ PROW()+1, 001 PSay STR0015 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf

		IncRegua()

		If !EMPTY( TMY->TMY_DTCANC )
			dbSelectArea( "TMY" )
			dbSkip()
			Loop
		EndIf

		If TMY->TMY_DTPROG < MV_PAR03 .Or. TMY->TMY_DTPROG > MV_PAR04
			dbSelectArea( "TMY" )
			dbSkip()
			Loop
		EndIf

		U_NGIMPRASO(;
			MV_PAR05,; // [1]
			MV_PAR07,; // [2]
			MV_PAR08,; // [3]
			MV_PAR09,; // [4]
			MV_PAR10,; // [5]
			MV_PAR11,; // [6]
			MV_PAR12,; // [7]
			MV_PAR13,; // [8]
			MV_PAR14,; // [9]
			MV_PAR15,; // [10]
			MV_PAR16,; // [11]
			MV_PAR17,; // [12]
			MV_PAR18,; // [13]
			MV_PAR20,; // [14]
			IIf( lDepto, MV_PAR21, 1 ),; // [15]
			mv_par22; // [16]
		)

		dbSelectArea( "TMY" )
		dbSetOrder( 2 )
		dbskip()

	End

	//Devolve a condicao original do arquivo principal
	If lPrint
		If mv_Par10 == 2 .Or. mv_Par10 == 3
			If aReturn[5] == 1
				oPrint:Preview()
			Else
				oPrint:Print()
			EndIf
		EndIf
	Else
		MsgInfo( STR0127 )  //"Não há nada para imprimir no relatório."
		RetIndex( "TMY" )
		Set Filter To
		Return .F.
	EndIf


	RetIndex( "TMY" )

	Set Filter To

	Set device To Screen

	If aReturn[5] = 1 .And. mv_par10 == 1
		Set Printer To
		dbCommitAll()
		OurSpool( wnrel )
	EndIf

	MS_FLUSH()

	dbSelectArea( "TMY" )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} NGIMPRASO
Impressao do ASO

@author Inacio Luiz Kolling
@since 18/05/2000

@param nPORPAG, ASOs por Pagina ? [1]
@param mvpar07, Termo de Respons. (Obs) ? [2]
@param mvpar08, Listar Exames NR7 ? [3]
@param nImpNR7, Imprimir logomarca ? [4]
@param cPar10, Modelo Impressao ? [5]
@param nVias, Numero de Vias ? [6]
@param nPar12, Via entregue ao funcionario ? [7]
@param nPar13, Imprimir Apto c/ Restricoes ? [8]
@param nPar14, Imprimir Riscos ? [9]
@param nPar15, Imprimir Parecer do Medico ? [10]
@param nPar16, Nome Atividade Func.? [11]
@param nPar17, Imprimir Restricoes ? [12]
@param nPar18, Agrupar exames por data ? [13]
@param nPar19, Endereco de cobranca ? [14]
@param nCCouDep, Imprimir por ? [15]
@param nFor, Formato da logo ? [16]

@return lRet, Lógico, Retorna verdadeiro caso ocorra a impressão
/*/
//-------------------------------------------------------------------
User Function NGIMPRASO( nPORPAG, mvpar07, mvpar08, nImpNR7, cPar10, nVias, nPar12, nPar13, nPar14, nPar15, nPar16, nPar17, nPar18, nPar19, nCCouDep, nFor )

	Local aAreaTM0
	Local cBarraSrv	:= "\"
	Local lRet      := .T.
	Local lDepto	:= NGCADICBASE( "TMY_NOVDEP", "A", "TMY", .F. )
	Local lIntGPE	:= SuperGetMv( "MV_MDTGPE", .F., "N" ) == "S"
	Local leSocial	:= IIf( FindFunction( "MDTVldEsoc" ), MDTVldEsoc(), .F. )

	Private nTipAtv 	:= nPar16
	Private nTipEnd 	:= nPar19
	Private nFormato	:= nFor

	Default nFor 		:= 1
	Default nPar16   	:= 1
	Default nPar17   	:= 2
	Default nPar18   	:= 2
	Default nPar19   	:= 1
	Default nCCouDep 	:= 1

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	nTa1    := IIf( ( TAMSX3( "A1_COD" )[1]) < 1, 6, ( TAMSX3( "A1_COD" )[1] ) )
	nTa1L   := IIf( ( TAMSX3( "A1_LOJA" )[1]) < 1, 2, ( TAMSX3( "A1_LOJA" )[1] ) )
	nSizeTD := nTa1+nTa1L

	Private lDefisTM0 := NGCADICBASE( "TM0_TIPDEF", "A", "TM0", .F. ) //Indica se o campo existe
	Private lNomSocTM0:= NGCADICBASE( "TM0_NOMSOC", "A", "TM0", .F. ) //Indica se o campo existe

	Private cMvPar10    := cPar10
	Private lTM0        := .F.
	Private lSA1        := .F.
	Private cTELMED     := ""
	Private cENDMED     := ""
	Private cTELRES     := ""
	Private cENDRES     := ""
	Private cTERMO      := IIf( Valtype( mvpar07 )=="C", mvpar07, Space( 6 ) )
	Private cDesCusto   := " "
	Private cDesFuncao  := " "
	Private cLOGOM      := IIf( Valtype( mvpar08 )=="N", mvpar08, 1 )
	Private cAlias      := "SI3"
	Private cDescr      := "SI3->I3_DESC"
	Private aTMYCombo   := MDTCbox( "TMY_NATEXA", " ", 1 )
	Private aTMACombo   := MDTCbox( "TMA_GRISCO", " ", 1 )
	Private aDescAgents := { STR0191, STR0192, STR0193, STR0194, STR0195, STR0196, STR0246, STR0258 } //Passou a subst. a aTMACombo, pois agora os agentes devem estar no plural
	Private lTipRel	    := ( cPar10 == 1 )
	Private nTotVias    := nVias
	Private cRelExam    := SuperGetMv( "MV_NGEXREL", .F., "1" ) //Indica o padrao para o filtro de exames relacionados.
	Private cGrpExam    := IIf( nPar18 == 1, "2", "1" ) //Indica se agrupa os exames por data no ASO.
	Private lAliasTYD	:= AliasInDic( "TYD" )
	Private lMsgS2220	:= .F.

	If cPar10 == 2 .Or. cPar10 == 3
		Private cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "", GetADV97() )
		Private cPathSiga := GetPvProfString( GetEnvServer(), "StartPath", "ERROR", GetADV97() )
		cPathSiga += IIf( RIGHT( cPathSiga, 1 ) != cBarraSrv, cBarraSrv, "" )
		cPathSiga := IIf( Substr( cPathSiga, 1, 1 ) != cBarraSrv, cBarraSrv+cPathSiga, cPathSiga )
		cRootPath := IIf( RIGHT( cRootPath, 1 ) == cBarraSrv, SubStr( cRootPath, 1, Len( cRootPath )-1 ), cRootPath )
	EndIf

	If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	EndIf

	If lDepto
		//Posiciona na Tabela para Correta abertura no Multi-Empresa
		dbSelectArea( "SQB" )
		dbSetOrder( 1 )
		dbGoTop()
	EndIf

	//Retorna para empresa correta
	aTblOpen := { { "SRJ", 01 }, { "CTT", 01 }, { "SQB", 01}, { "TN5", 01 }, { "SRA", 01 }  }
	If IsInCallStack( "MDTA410" )
		cOldEmp := cEmpAsoOld
		cOldFil := cFilAsoOld
	ElseIf IsInCallStack( "MDTA200" ) .And. TMY->TMY_FILIAL == cFilAnt
		cOldFil := cFilAnt
	EndIf
	If IsInCallStack( "MDTA200" ) .Or. IsInCallStack( "MDTA410" )
		If cOldEmp <> cEmpAnt .And. !Empty( cOldEmp )
			NGPrepTBL( aTblOpen, cEmpAnt, cFilAnt )
		ElseIf cOldFil != cFilAnt .And. !Empty( cOldFil )
			cFilAnt := cOldFil
		EndIf
	EndIf
	If SuperGetMv( "MV_NGMDTPS", .F., "N" ) = "S" //Se o Cliente for prestadora de Servico testa o parametro de Cliente
		dbSelectArea( "TM0" )
			dbSelectArea( "TM0" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TM0" )+TMY->TMY_NUMFIC )

			If cPerg == "MDT465"
				If TM0->TM0_CLIENT <> MV_PAR06
					dbSelectArea( "TMY" )
					Return
				EndIf
			EndIf
			dbSelectArea( "SA1" )
			dbSetOrder( 1 )
			If dbSeek( xFilial( "SA1" )+TM0->TM0_CLIENT+TM0->TM0_LOJA )
				lSA1 := .T.
			EndIf
	EndIf

	aArea := GetArea()
	aAreaSM0 := SM0->( GetArea() )
	dbSelectArea( "SM0" )
	dbSeek( cEmpAnt + AllTrim( TMY->TMY_FILIAL ) )
	If Type( "nTipEnd" ) == "N" .And. nTipEnd == 1          //Se Cobrança usa os endereços de cobrança )
		_NOMECOM := SM0->M0_NOMECOM
		_ENDCOB  := SM0->M0_ENDCOB
	Else 			//Se Fiscal usa os endereços de Fiscal
		_NOMECOM := SM0->M0_NOMECOM
		_ENDCOB  := SM0->M0_ENDENT
	EndIf
	_CGC := SM0->M0_CGC
	RestArea( aAreaSM0 )
	RestArea( aArea )

	dbSelectArea( "TM0" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )

	dbSelectArea( "SRA" )
	dbSetOrder( 1 )
	If dbSeek( TM0->TM0_FILFUN + TM0->TM0_MAT )

		If nCCouDep == 1 //Caso seja por Centro de Custo.
			dbSelectArea( cAlias )
			dbSetOrder( 1 )
			dbSeek( xFilial( cAlias ) + SRA->RA_CC )
			cDesCusto  := Substr( Alltrim( SRA->RA_CC ) + " - " + &cDescr, 1, 44 )
		Else //Caso seja por Departamento.
			dbSelectArea( "SQB" )
			dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
			If dbSeek( xFilial( "SQB" ) + SRA->RA_DEPTO )
				cDesCusto  := Substr( Alltrim( SRA->RA_DEPTO ) + " - " + SQB->QB_DESCRIC, 1, 44 )
			EndIf
		EndIf

		cFunSav := SRA->RA_CODFUNC

		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "SRJ" ) + cFunSav )
		cDesFuncao := Substr( Alltrim( cFunSav ) + " - " + SRJ->RJ_DESC, 1, 36 )

		If TMY->TMY_NATEXA == "3" .And. lIntGPE

			cFilMat := cFilAnt
			If TMY->( ColumnPos( "TMY_FILFUN" ) ) > 0
				If !Empty( TMY->TMY_FILFUN )
					cFilMat := TMY->TMY_FILFUN
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_CC" ) ) > 0 .And. nCCouDep == 1 //Caso tenha um novo centro de custo.
				dbSelectArea( cAlias )
				dbSetOrder( 1 )
				If dbSeek( xFilial( cAlias, cFilMat ) + TMY->TMY_CC )
					cDesCusto  := Substr( Alltrim( TMY->TMY_CC ) + " - " + &cDescr, 1, 44 )
				EndIf
			ElseIf TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0 .And. nCCouDep == 2 //Caso tenha um novo departamento. TMY_NOVDEP
				dbSelectArea( "SQB" )
				dbSetOrder( 1 )//QB_FILIAL+QB_DEPTO
				If dbSeek( xFilial( "SQB" ) + TMY->TMY_NOVDEP )
					cDesCusto  := Substr( Alltrim( TMY->TMY_NOVDEP ) + " - " + SQB->QB_DESCRIC, 1, 44 )
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_CODFUN" ) ) > 0
				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )
				If dbSeek( xFilial( "SRJ", cFilMat ) + TMY->TMY_CODFUN )
					cDesFuncao := Substr( Alltrim( TMY->TMY_CODFUN ) + " - " + SRJ->RJ_DESC, 1, 36 )
				EndIf
			EndIf
		EndIf
	Else
		lTM0 := .T.
	EndIf

	dbSelectArea( "TMK" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TMK" ) + TMY->TMY_CODUSU )
	cNOMEMED := TMK->TMK_NOMUSU
	cCRMMDE  := TMK->TMK_NUMENT
	cTELMED  := TMK->TMK_TELUSU
	cENDMED  := TMK->TMK_ENDUSU

	cNOMERES := cNOMEMED
	cCRMRES  := cCRMMDE
	cTELRES  := cTELMED
	cENDRES  := cENDMED

	If Empty( cCodUsu )
		cCodUsu := U_MDTASOCoord( TMY->TMY_DTGERA ) //Busca o Médico Coordenador do PCMSO
	EndIf

	If !Empty( cCodUsu )
		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TMK" ) + cCodUsu )
		cNOMERES := TMK->TMK_NOMUSU
		cCRMRES  := TMK->TMK_NUMENT
		cTELRES  := TMK->TMK_TELUSU
		cENDRES  := TMK->TMK_ENDUSU
	EndIf

	cINDPAR := STR0118 // "Apto"
	If TMY->TMY_INDPAR == '2'
		cINDPAR := STR0119 // "Inapto"
	ElseIf TMY->TMY_INDPAR == '3'
		If nPar13 == 1  //1-Imprimir Apto c/ Restrições como Inapto
			cINDPAR := STR0119 // "Inapto"
		Else
			cINDPAR := STR0160 // "Apto Com Restricoes"
		EndIf
	EndIf

	aAreaTM0 := TM0->( GetArea() )

	dbSelectArea( "TMY" )
	If Empty( TMY->TMY_DTEMIS )
		
		If leSocial .And. IsInCallStack( "MDTR465" ) //Caso houver integração com o eSocial e for impressão via MDTR465

			nASOCont++ //Incrementa o número de ASOs processados

			If nASOCont == nASOTot //Caso estiver processando o último ASO do laço
				lMsgS2220 := .T. //Seta a variável para que emita a mensagem da integração
			EndIf
		EndIf

		Begin Transaction

			//------------------------------------------------------------------
			// Realiza a integração das informações do evento S-2220 ao Governo
			//------------------------------------------------------------------
			If ( lRet := FindFunction( "MDTIntEsoc" ) .And. MDTIntEsoc( "S-2220", 3, TMY->TMY_NUMFIC, , , , , , DToS( dDataBase ) ) )
				RecLock( 'TMY', .F. )
					TMY->TMY_DTEMIS := dDataBase
				TMY->( MsUnLock() )
			EndIf

		End Transaction
	EndIf

	RestArea(aAreaTM0)

	If lRet
		If cPar10 == 1 //modelo de impressao padrao
			U_IMPASOM1(;
				nPORPAG,; // [1]
				mvpar07,; // [2]
				mvpar08,; // [3]
				nImpNR7,; // [4]
				cPar10,; // [5]
				nVias,; // [6]
				nPar12,; // [7]
				nPar14,; // [8]
				nPar15,; // [9]
				nPar17,; // [10]
				nCCouDep; // [11]
			)
		ElseIF cPar10 == 2 //modelo de impressao grafico 1
			U_IMPASOM2(;
				nPORPAG,; // [1]
				mvpar07,; // [2]
				mvpar08,; // [3]
				nImpNR7,; // [4]
				cPar10,; // [5]
				nVias,; // [6]
				nPar12,; // [7]
				nPar14,; // [8]
				nPar15,; // [9]
				nPar17,; // [10]
				nCCouDep; // [11]
			)
		Else //modelo de impressao grafico 1
			U_IMPASOM3(;
				nPORPAG,; // [1]
				mvpar07,; // [2]
				mvpar08,; // [3]
				nImpNR7,; // [4]
				cPar10,; // [5]
				nVias,; // [6]
				nPar12,; // [7]
				nPar13,; // [8]
				nPar14,; // [9]
				nPar15,; // [10]
				nPar17,; // [11]
				nCCouDep; // [12]
			)
		EndIf

		lPrint := .T.
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPASOM1
Impressao do ASO modelo 1

@author  Inacio Luiz Kolling
@since   18/05/2000

@param nPORPAG, ASOs por Pagina ? [1]
@param mvpar07, Termo de Respons. (Obs) ? [2]
@param mvpar08, Listar Exames NR7 ? [3]
@param nImpNR7, Imprimir logomarca ? [4]
@param cPar10, Modelo Impressao ? [5]
@param nVias, Numero de Vias ? [6]
@param nPar12, Via entregue ao funcionario ? [7]
@param nPar14, Imprimir Riscos ? [8]
@param nPar15, Imprimir Parecer do Medico ? [9]
@param nPar17, Imprimir Restricoes ? [10]
@param nCCouDep, Imprimir por ? [11]

/*/
//-------------------------------------------------------------------
User Function IMPASOM1( nPORPAG, mvpar07, mvpar08, nImpNR7, cPar10, nVias, nPar12, nPar14, nPar15, nPar17, nCCouDep )

	Local xx, yy, cc, LinhaCorrente, i, nLCorrente
	Local nCont			:= 0
	Local lExist4653	:= ExistBlock( "MDTR4653" )
	Local lMDTA076		:= IsInCallStack( "MDTA076" )
	Local cNovFun		:= ""
	Local cNovCC		:= ""
	Local cDepto		:= ""
	Local aTarefASO		:= {} //Array que receberá as Tarefas da TYD relacionada ao ASO
	Local aCampos2		:= {}
	Local nCampos		:= 0
	Local cPermTrab		:= ""
	Local nLinhasMemo	:= 0
	Local cPermis		:=""

	Private lTmpDFis	:= IIf( Type( "lDefisTM0" )!="L", .F., IIf( lDefisTM0, (TM0->TM0_TIPDEF != "0" .And. !Empty( TM0->TM0_TIPDEF ) ), .F. ) ) //Indica se o funcionario/candidato é deficiente
	Private lTitulo		:= .F.
	Private lQbVia		:= .F.
	Private lPagIn		:= .T.
	Private lFlag		:= .T.
	Private nViaAtual	:= 0
	Private liFim
	Private aRiscos		:= {}
	Private aEXAMES		:= {}
	Private nPagAt		:= 1
	Private nPagTot		:= 1
	Private lImpObs		:= .F.
	Private lImpRest	:= .F.
	Private cObs		:= ""
	Private cObsAd		:= ""
	Private cObsRestri	:= ""
	Private cNomeFunc	:= ""
	Private cNomeSocial	:= ""
	Private cNomeCand	:= ""
	Private LinhasMemoObs
	Private LinhasAso
	Private LinhasRes

	Default nPar14	 := 2
	Default nPar15	 := 1
	Default nCCouDep := 1

	If ExistBlock( "MDTR4652" )
		cObsAd := ExecBlock( "MDTR4652" )
		If ValType( cObsAd ) != "C"
			cObsAd := ""
		EndIf
	EndIf

	//Verifica restricoes
	If nPar17 == 1 .And. TMY->TMY_INDPAR == "3"
		cObsRestri := f465RESTRI( TMY->TMY_NUMFIC, TMY->TMY_DTPROG, nPar17 )
	EndIf

	nMdRel := 1

	If cLOGOM == 1//nao imprime logo
		liFim := 72
		li := 0
	EndIf

	For xx := 1 To nVias

		nPagAt := 1
		nPagTot := 1

		If cLOGOM == 2 //imprime logo
			liFim := 65
			U_MDTR465LOG()
		EndIf

		If ( nViaAtual == 0 ) .Or. ( nViaAtual == 1 ) .Or. ( nViaAtual == 2 )
			nViaAtual := nViaAtual + 1
		EndIf

		U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )

		lPRIN   := .F.
		lFlag   := .T.

		/*Obtem total de paginas do relatorio.
		Chamada das funcoes para referente ao conteudo variavel do relatorio.
		aRiscos, aEXAMES, Memos TMY_DESCRI e TMZ->TMZ_DESCRI*/
		nPagTot := U_NGNRPAGASO( nImpNR7 )

		Somalin( , nCCouDep )
		@Li, 000 PSay STR0031 //"|---------------------------------  Riscos  -----------------------------------|"

		If Len( aRiscos ) > 0
			lPRIN := .T.
			For i:=1 To Len( aRiscos )
				If lFlag
					lFlag := .F.
					Somalin( , nCCouDep )
					@Li, 000 PSay "|"
					@Li, 002 PSay SubStr( Alltrim( aRiscos[i][2] ), 1, 37 )
				Else
					lFlag := .T.
					@Li, 041 PSay SubStr( Alltrim( aRiscos[i][2] ), 1, 37 )
					@Li, 079 PSay "|"
				EndIf
			Next i
		ElseIf !lPRIN
			cTextoRis := STR0111 //"Não há risco ocupacional específico para a atividade."
			SomaLin( , nCCouDep )
			@Li, 000 PSay "|"
			@Li, 002 PSay MemoLine( cTextoRis, 75, 1 )
			@Li, 079 PSay "|"
		EndIf

		If lFlag == .F.
			@Li, 079 PSay "|"
		EndIf

		If lExist4653
			ExecBlock( "MDTR4653", .F., .F. )
		Else
			lPRIN2 := .F.
			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				For yy := 1 To Len( aTmpExa )
					If !lPRIN2
						SomaLin( , nCCouDep )
						@Li, 000 PSay STR0033 //"|---------------------------------  Exames  -----------------------------------|"
						lPRIN2 := .T.
					EndIf
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 60 )
					For nLCorrente := 1 To nLMemo
						SomaLin( , nCCouDep )
						@Li, 000 PSay "|"
						@Li, 002 PSay MemoLine( aTmpExa[yy, 3], 60, nLCorrente )
						If nLCorrente == 1
							@Li, 065 PSay aTmpExa[yy,1] PICTURE '99/99/99'
						EndIf
						@Li, 079 PSay "|"
					Next LCorrente
				Next yy
			Else
				For yy := 1 To Len( aEXAMES )

					cExame := ""
					dDateResultado := ""

					If !Empty( aEXAMES[yy][2] )
						dbSelectArea( "TM5" )
						dbSetOrder( 08 )
						dbSeek( xFilial( 'TM5' ) + aEXAMES[yy][1] + DToS( aEXAMES[yy][2] ) + aEXAMES[yy][5] + aEXAMES[yy][3] )
						cExame := TM5->TM5_EXAME
						dDateResultado := TM5->TM5_DTRESU
					EndIf

					If cRelExam == "2"
						If Empty( cExame )
							dbSelectArea( "TKB" )
							dbSetOrder( 01 )
							dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO + aEXAMES[yy][3] )
							cExame := TKB->TKB_EXAME
							dDateResultado := ""
						EndIf
					EndIf

					If !lPRIN2
						SomaLin( , nCCouDep )
						@Li, 000 PSay STR0033 //"|---------------------------------  Exames  -----------------------------------|"
						lPRIN2 := .T.
					EndIf

					If MOD( yy, 2 ) != 0
						SomaLin( , nCCouDep )
						@Li, 000 PSay "|"
						nCOL := 2
					Else
						SomaLin( , nCCouDep )
						@Li, 000 PSay "|"
					EndIf

					dbSelectArea( "TM4" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "TM4" ) + cExame )

					@Li, nCOL PSay SubStr( TM4->TM4_NOMEXA, 1, 38 )
					@Li, nCOL+55 PSay dDateResultado PICTURE '99/99/99'

					If nCOL > 30 .Or. yy == Len( aEXAMES )
						@Li, 079 PSay "|"
					Else
						@Li, 079 PSay "|"
					EndIf

				Next yy
			EndIf

			If !lPRIN2 .And. !lPRIN
				cTextoExa := STR0034 //"Não existe necessidade de exame médico complementar, somente consulta clínica ocupacional."
				SomaLin( , nCCouDep )
				@Li, 000 PSay STR0033 //"|---------------------------------  Exames  -----------------------------------|"
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 002 PSay MemoLine( cTextoExa, 75, 1 )
				@Li, 079 PSay "|"
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 002 PSay MemoLine( cTextoExa, 75, 2 )
				@Li, 079 PSay "|"
			EndIf
		EndIf

		lTitulo := .T.
		SomaLin( , nCCouDep )
		lTitulo := .F.
		@Li, 000 PSay STR0035 //"|------------------------------- Coordenador PCMSO ----------------------------|"
		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0036 //"|Medico...:"
		@Li, 012 PSAY Substr( cNOMERES, 1, 30 )
		@Li, 048 PSAY STR0037 //"Tel. Contato.:"
		If !Empty( cTELRES )
			@Li, 063 PSay cTELRES
		EndIf
		@Li, 079 PSay "|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0038         //"|Endereco..:"
		If !Empty( cENDRES )
			@Li, 012 PSay Substr( cENDRES, 1, 30 )
		EndIf

		@Li, 057 PSay STR0045 //"CRM.:"
		@Li, 063 PSAY cCRMRES PICTURE '@!'
		@Li, 079 PSay "|"

		lTitulo := .T.

		If (Li + 10) > liFim - 3
			@Li, 000 PSAY Replicate( "-", 80 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := Round( ( Len( cPagina )/2 ), 1 ) - 1
			@055, ( 040 - nPosPag ) PSAY cPagina
			nPagAt++
			lPagIn  := .F.
			Li := 0
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lQbVia  := .T.
		EndIf

		

		If TMY->(ColumnPos( "TMY_OUTROS" )) > 0 .And. Empty( aCampos2 )

			If TMY->( ColumnPos( "TMY_PLAT" ) ) > 0 .And. TMY->TMY_PLAT == "1"
				aAdd( aCampos2, { "1", STR0209 } )//"Plataforma"
			EndIf

			If TMY->( ColumnPos( "TMY_MANCIV" ) ) > 0 .And. TMY->TMY_MANCIV == "1"
				aAdd( aCampos2,{ "2", STR0210} ) //"Manutenção Civil"
			EndIf

			If TMY->( ColumnPos( "TMY_EXPLO" ) ) > 0 .And. TMY->TMY_EXPLO == "1"
				aAdd( aCampos2,{ "3", STR0211 } )//"Explosivos"
			EndIf

			If TMY->( ColumnPos( "TMY_ESCAV" ) ) > 0 .And. TMY->TMY_ESCAV == "1"
				aAdd( aCampos2,{ "5", STR0212 } )
			EndIf

			If TMY->( ColumnPos( "TMY_SOLDA" ) ) > 0 .And. TMY->TMY_SOLDA == "1"
				aAdd( aCampos2,{ "7", STR0214 } )
			EndIf

			If TMY->( ColumnPos( "TMY_FRIO" ) ) > 0 .And. TMY->TMY_FRIO == "1"
				aAdd( aCampos2,{ "9", STR0215 } )
			EndIf

			If TMY->( ColumnPos( "TMY_RADIA" ) ) > 0 .And. TMY->TMY_RADIA == "1"
				aAdd( aCampos2,{ "A", STR0216 } )
			EndIf

			If TMY->( ColumnPos( "TMY_PRESS" ) ) > 0 .And. TMY->TMY_PRESS == "1"
				aAdd( aCampos2,{ "B", STR0217 } )
			EndIf

			If TMY->( ColumnPos( "TMY_OUTROS" ) ) > 0 .And. TMY->TMY_OUTROS == "1"
				aAdd( aCampos2,{ "X", STR0218 } )
			EndIf

			If TMY->( ColumnPos( "TMY_ALTURA" ) ) > 0 .And. TMY->TMY_ALTURA == "1"
				aAdd( aCampos2, { "4", STR0221 } )
			EndIf
			
			If TMY->( ColumnPos( "TMY_ELETRI" ) ) > 0 .And. TMY->TMY_ELETRI == "1"
				aAdd( aCampos2, { "6", STR0213 } )
			EndIf
			
			If TMY->( ColumnPos( "TMY_CONFIN" ) ) > 0 .And. TMY->TMY_CONFIN == "1"
				aAdd( aCampos2, { "8", STR0207 } )
			EndIf

			If TMY->( ColumnPos( "TMY_TMC" ) ) > 0 .And. TMY->TMY_TMC == "1"
				aAdd( aCampos2, { "Z", STR0208 } )
			EndIf

			If TMY->( ColumnPos( "TMY_INFLA" ) ) > 0 .And. TMY->TMY_INFLA == "1"
				aAdd( aCampos2, { "C", STR0257 } ) //"Trabalho com Inflamável"
			EndIf

		EndIf

		If !TMY->(ColumnPos( "TMY_OUTROS" )) > 0 .And. Empty( aCampos2 )

			dbSelectArea( "TY7" )
			dbSetOrder( 1 )
			If dbSeek( xFilial( "TY7" ) + TMY->TMY_NUMASO )

				While !Eof() .And. TY7->TY7_FILIAL == xFilial( "TY7" ) .And. TY7->TY7_NUMASO == TMY->TMY_NUMASO

				If !TMY->(ColumnPos( "TMY_PLAT" )) > 0 .And. TY7->TY7_TIPERM == "1" .And. aScan( aCampos2, { |x| x[ 1 ] == "1" } ) == 0
					aAdd( aCampos2, { "1", STR0209 } )//"Plataforma"
				ElseIf !TMY->(ColumnPos( "TMY_MANCIV" )) > 0 .And. TY7->TY7_TIPERM == "2" .And. aScan( aCampos2, { |x| x[ 1 ] == "2" } ) == 0
					aAdd( aCampos2,{ "2", STR0210} )//"Manutenção Civil"
				ElseIf !TMY->(ColumnPos( "TMY_EXPLO" )) > 0 .And. TY7->TY7_TIPERM == "3" .And. aScan( aCampos2, { |x| x[ 1 ] == "3" } ) == 0
					aAdd( aCampos2,{ "3", STR0211 } )//"Explosivos"
				ElseIf TY7->TY7_TIPERM == "4" .And. aScan( aCampos2, { |x| x[ 1 ] == "4" } ) == 0
					aAdd( aCampos2, { "4", STR0221 } )//"Trabalho em Altura"
				ElseIf !TMY->(ColumnPos( "TMY_ESCAV" )) > 0 .And. TY7->TY7_TIPERM == "5" .And. aScan( aCampos2, { |x| x[ 1 ] == "5" } ) == 0
					aAdd( aCampos2,{ "5", STR0212 } )//"Escavações/Demolições"
				ElseIf TY7->TY7_TIPERM == "6" .And. aScan( aCampos2, { |x| x[ 1 ] == "6" } ) == 0
					aAdd( aCampos2, { "6", STR0213 } )//"Trabalho com Eletricidade"
				ElseIf !TMY->(ColumnPos( "TMY_SOLDA" )) > 0 .And. TY7->TY7_TIPERM == "7" .And. aScan( aCampos2, { |x| x[ 1 ] == "7" } ) == 0
					aAdd( aCampos2,{ "7", STR0214 } )//"Solda (A Quente)"
				ElseIf TY7->TY7_TIPERM == "8" .And. aScan( aCampos2, { |x| x[ 1 ] == "8" } ) == 0
					aAdd( aCampos2, { "8", STR0207 } )//"Trabalho em Espaço Confinado"
				ElseIf !TMY->(ColumnPos( "TMY_FRIO" )) > 0 .And. TY7->TY7_TIPERM == "9" .And. aScan( aCampos2, { |x| x[ 1 ] == "9" } ) == 0
					aAdd( aCampos2,{ "9", STR0215 } )//"A Frio"
				ElseIf !TMY->(ColumnPos( "TMY_RADIA" )) > 0 .And. TY7->TY7_TIPERM == "A" .And. aScan( aCampos2, { |x| x[ 1 ] == "A" } ) == 0
					aAdd( aCampos2,{ "A", STR0216 } )//"Radiação"
				ElseIf !TMY->(ColumnPos( "TMY_PRESS" )) > 0 .And. TY7->TY7_TIPERM == "B" .And. aScan( aCampos2, { |x| x[ 1 ] == "B" } ) == 0
					aAdd( aCampos2,{ "B", STR0217 } )//"Pressão"
				ElseIf !TMY->(ColumnPos( "TMY_OUTROS" )) > 0 .And. TY7->TY7_TIPERM == "X" .And. aScan( aCampos2, { |x| x[ 1 ] == "X" } ) == 0
					aAdd( aCampos2,{ "X", STR0218 } )//"Pressão"
				EndIf

				TY7->( dbSkip() )

				End
				
			EndIf

			If TMY->( ColumnPos( "TMY_TMC" ) ) > 0 .And. TMY->TMY_TMC == "1" .And. aScan( aCampos2, { |x| x[ 1 ] == "Z" } ) == 0
				aAdd( aCampos2, { "Z", STR0208 } )//"Transporte e Movimentação de Carga
			EndIf

		EndIf

		If !Empty( aCampos2 )

			lTitulo := .T.
			SomaLin( , nCCouDep )
			lTitulo := .F.
			@Li, 000 PSay "|"
			@Li, 000 PSay Replicate( "-", 27 ) + STR0249 + Replicate( "-", 27 ) //"Permissões para trabalho"
			@Li, 078 PSay "|"

			lFlag := .T.

			For nCampos := 1 To Len( aCampos2 )
				cPermTrab += AllTrim( aCampos2[ nCampos, 2 ] ) + CRLF
			Next nCampos

			nLinhasMemo := MLCOUNT( cPermTrab , 40 )

			For LinhaCorrente := 1 To nLinhasMemo
				cPermis :=MemoLine( AllTrim(cPermTrab), 40, LinhaCorrente )

				If lFlag
					lFlag := .F.
					SomaLin( , nCCouDep )
					@Li, 000 PSay "|"
					@Li, 002 PSay Substr( AllTrim(cPermis), 1, 40 ) //Imprime nome da permissão
				Else
					lFlag := .T.
					@Li, 042 PSay Substr( AllTrim(cPermis), 1, 40 ) //Imprime nome da permissão
					@Li, 079 PSay "|"
				EndIf

			Next LinhaCorrente
		EndIf

		If !lFlag .And. !Empty( aCampos2 )

			@Li, 079 PSay "|"

		EndIf

		cPermTrab := ""

		If lImpRest
			lPRIN := .T.
			For LinhaCorrente := 1 To LinhasRes
				If lPRIN
					lTitulo := .T.
					SomaLin( , nCCouDep )
					lTitulo := .F.
					@Li, 000 PSay STR0185//"|--------------------------------- Restrições ---------------------------------|"
					lPRIN := .F.
				EndIf
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 005 PSAY ( MemoLine( cObsRestri, 70, LinhaCorrente ) )
				@Li, 079 PSay "|"
			Next LinhaCorrente
		EndIf

		If lImpObs
			lPRIN := .T.
			For LinhaCorrente := 1 To LinhasMemoObs
				If lPRIN
					lTitulo := .T.
					SomaLin( , nCCouDep )
					lTitulo := .F.
					@Li, 000 PSay STR0051 //"|--------------------------------- Observação ---------------------------------|"
					lPRIN := .F.
				EndIf
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 005 PSAY ( MemoLine( cObs, 70, LinhaCorrente ) )
				@Li, 079 PSay "|"
			Next LinhaCorrente
		EndIf

		If ( Li + 1 ) <= ( liFim - 3 )
			SomaLin( , nCCouDep )
		EndIf

		@Li, 000 PSay "|"
		@Li, 000 PSay Replicate( "-", 78 )
		@Li, 078 PSay "|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0048  //"|Parecer.:"

		If nPar15 == 1
			@Li, 015 PSay AllTrim(cINDPAR) PICTURE "@!"
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			@Li, 000 PSay "|"
			@Li, 000 PSay STR0205 //"Natureza.....:"
			If ( nIND := aScan( aTMYcombo, { |x| Upper( Substr( x, 1, 1 ) ) == Substr( TMY->TMY_NATEXA, 1, 1 ) } ) ) > 0
				@Li, 015 PSAY Substr( aTMYcombo[nIND], 3, 20 ) PICTURE "@!"
			EndIf
			@Li, 078 PSay "|"
		Else
			@Li, 011 PSay "( )" + STR0118 + " ( )" + STR0119 + " ( )" + STR0160 //"Apto"#"Inapto"#"Apto Com Restricoes"
			@Li, 079 PSay "|"
		EndIf

		If TMY->TMY_NATEXA == "3" .And. TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0

			If TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0

				aTblOpen := { { "SRJ", 01 }, { "CTT", 01 }, { "SQB", 01}, { "TN5", 01 } }
				cEmpBkp	:= ""
				cFilBkp	:= ""
				cEmpFut := TMY->TMY_EMPFUT
				cFilFut := TMY->TMY_FILFUT

				If cEmpFut <> cEmpAnt .And. !Empty( cEmpFut )
					//Bkp da empresa e filial
					cEmpBkp := cEmpAnt
					cFilBkp := cFilAnt

					NGPrepTBL( aTblOpen, cEmpFut, cFilFut )

					cFilAnt := cFilFut
				ElseIf cFilFut != cFilAnt .And. !Empty( cFilFut )
					cFilBkp := cFilAnt
					cFilAnt := cFilFut
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0 .And. !Empty( TMY->TMY_NOVCC )
				cNovCC := SubStr( NGSEEK( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" ), 1, 40 )
			EndIf

			If TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. !Empty( TMY->TMY_NOVFUN )
				cNovFun := SubStr( NGSEEK( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" ), 1, 40 )
			EndIf

			If TMY->( FieldPos( "TMY_NOVTAR" ) ) > 0
				If lAliasTYD
					dbSelectArea( "TYD" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "TYD", cFilBkp ) + TMY->TMY_NUMASO )
						While TYD->( !Eof() ) .And. TYD->TYD_FILIAL == xFilial( "TYD", cFilBkp ) .And. TMY->TMY_NUMASO == TYD->TYD_NUMASO
							aAdd( aTarefASO, SubStr( Posicione( "TN5", 1, xFilial( "TN5" ) + TYD->TYD_CODTAR, "TN5_NOMTAR" ), 1, 40 ) )
							TYD->( dbSkip() )
						End
					EndIf
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If !Empty( TMY->TMY_NOVDEP )
					cDepto := SubStr( NGSEEK( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" ), 1, 40 )
				EndIf
			EndIf

			If TMY->( FieldPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( FieldPos( "TMY_FILFUT" ) ) > 0

				//Retorna para empresa e filial correta
				If !Empty( cEmpFut ) .And. cEmpFut <> cEmpAnt
					NGPrepTBL( aTblOpen, cEmpAnt, cFilBkp )
					cFilAnt := cFilBkp
				ElseIf !Empty( cFilBkp ) .And. cFilBkp <> cFilAnt
					cFilAnt := cFilBkp
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0 .And. Empty( cNovCC )
				cNovCC := SubStr( NGSeek( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" ), 1, 40 )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. Empty( cNovFun )
				cNovFun := SubStr( NGSeek( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" ), 1, 40 )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If Empty( cDepto )
					cDepto := SubStr( NGSeek( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" ), 1, 40 )
				EndIf
			EndIf
			SomaLin( , nCCouDep )

			If !Empty( cNovCC )
				@Li, 000 PSay "|"
				@Li, 001 PSay STR0242 + "......:" //"Novo CC"
				@Li, 018 PSAY cNovCC PICTURE "@!"
				@Li, 079 PSay "|"
				SomaLin( , nCCouDep )
			EndIf

			If !Empty( cNovFun )
				@Li, 000 PSay "|"
				@Li, 001 PSay STR0204 + "..:"//"Nova Função"
				@Li, 018 PSAY cNovFun PICTURE "@!"
				@Li, 079 PSay "|"
				SomaLin( , nCCouDep )
			EndIf

			For nCont := 1 To Len( aTarefASO )
				@Li,000 PSay "|"
				If nCont == 1 //Só imprimirá o titulo 1 vez
					@Li,001 PSay IIf( lAliasTYD, STR0245, STR0243 ) + ":" //"Nova Tarefa"
				EndIf
				@Li,018 PSAY aTarefASO[ nCont ] PICTURE "@!"
				@li,079 PSay "|"
				SomaLin( , nCCouDep )
			Next nCont

			//Zera array de tarefas para que não duplique as tarefas da próxima via
			aTarefASO := {}

			If !Empty( cDepto )
				@Li, 000 PSay "|"
				@Li, 001 PSay STR0244 + "....:" //"Novo Dep."
				@Li, 018 PSAY cDepto PICTURE "@!"
				@Li, 079 PSay "|"
			EndIf
		EndIf

		lPRIN := .T.
		For LinhaCorrente := 1 To LinhasAso
			If !Empty( ( MemoLine( TMY->TMY_DESCRI, 68, LinhaCorrente ) ) )
				If lPRIN
					SomaLin( , nCCouDep )
					@Li, 000 PSay STR0050+":" //"|Procedimento"
					@Li, 014 PSay ( MemoLine( AllTrim(TMY->TMY_DESCRI), 63, LinhaCorrente ) )
					@Li, 079 PSay "|"
					lPRIN := .F.
				ElseIf !Empty( MemoLine( AllTrim(TMY->TMY_DESCRI), 75, LinhaCorrente ) )
					SomaLin( , nCCouDep )
					@Li, 000 PSay "|"
					@Li, 000 PSay ( MemoLine( AllTrim(TMY->TMY_DESCRI), 75, LinhaCorrente ) )
					@Li, 078 PSay "|"
				EndIf
			Else
				Exit
			EndIf
		Next LinhaCorrente

		If ( (Li + 10) > liFim .And. mvpar08 == 2 )
			SomaLin( , nCCouDep )
			@Li, 000 PSAY Replicate( "-", 80 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := Round( ( Len( cPagina )/2 ), 1 ) - 1
			@Li+1, ( 040 - nPosPag ) PSAY cPagina
			nPagAt++
			lPagIn  := .F.
			Li := 0
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lQbVia  := .T.
		EndIf

		lTitulo := .F.

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0040 //"|------------------------------- Realizacao -----------------------------------|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay "|"
		@Li, 001 pSay STR0161+Str( nPar12, 1 )+STR0162 //"Declaro que recebi a "###"ª via do ASO"
		@Li, 079 PSay "|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0041//"|Assinatura.: ____________________________  Ass.: ____________________________ |"

		dbSelectArea( "SRA" )
		dbSetOrder( 1 )
		If dbSeek( IIf( lMDTA076, TM0->TM0_FILFUN, xFilial( "SRA" ) ) + TM0->TM0_MAT ) .And. !Empty( SRA->RA_MAT )

			If !Empty( SRA->RA_NSOCIAL )
				cNomeSocial := SRA->RA_NSOCIAL
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := TM0->TM0_NOMSOC
			EndIf

			If !Empty( SRA->RA_NOMECMP )
				cNomeFunc := SRA->RA_NOMECMP
			ElseIf !Empty( SRA->RA_NOME )
				cNomeFunc := SRA->RA_NOME
			EndIf

		EndIf

		nLinhasMemo := MLCOUNT( AllTrim( cNomeFunc ), 28 ) 	// quanto o nome atingir 40 caracter ele quebra e joga pra baixo

		For LinhaCorrente := 1 To nLinhasMemo
			SomaLin( , nCCouDep )
			cTexte :=MemoLine( cNomeFunc, 28, LinhaCorrente )
			If LinhaCorrente == 1
				@Li, 000 PSay STR0042 //"|Funcionario:"
				@Li, 014 PSay Substr( cTexte, 1, 28 )// Nome
				@Li, 044 PSay STR0043 //"Resp:"
				@Li, 050 PSay Substr( cNOMEMED, 1, 28 )
				@Li, 079 PSay "|"
			ElseIf LinhaCorrente == 2
				@Li, 000 PSay "|"
				@Li, 014 PSay Substr( cTexte, 1, 28 )// Nome
				@Li, 044 PSay STR0045 //"CRM.:"
				@Li, 050 PSay cCRMMDE
				@Li, 079 PSay "|"
			ElseIf LinhaCorrente == 3
				@Li, 000 PSay "|"
				@Li, 014 PSay Substr( cTexte, 1, 28 )// Nome
				@Li, 044 PSay STR0046 //"End.:"
				@Li, 050 PSay Substr( cENDMED, 1, 26 )
				@Li, 079 PSay "|"
			EndIf

		Next LinhaCorrente

		If lTM0
			DbSelectArea( "TM0" )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )
			SomaLin( , nCCouDep )
			@Li, 000 PSay STR0255 //"|Candidato:"
			@Li, 014 PSay Substr( TM0->TM0_NOMFIC, 1, 28 )
			@Li, 044 PSay STR0043 //"Resp:"
			@Li, 050 PSay Substr( cNOMEMED, 1, 28 )
			@Li, 079 PSay "|"
		EndIf

		If !Empty( cNomeSocial )
			SomaLin( , nCCouDep )
			@Li, 000 PSay STR0253 //"|Nome Social:"
			@Li, 014 PSay Substr( cNomeSocial, 1, 28 )
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
		EndIf

		If LinhaCorrente <= 2
			If Empty( cNomeSocial )
				SomaLin( , nCCouDep )
			EndIf
			@Li, 000 PSay "|"
			@Li, 044 PSay STR0045 //"CRM.:"
			@Li, 050 PSay cCRMMDE
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			lPrintLin := .T.
		EndIf

		If Empty( cNomeSocial ) .And. !lTM0
			SomaLin( , nCCouDep )
		EndIf

		@Li, 000 PSay STR0044 //"|Data.......:"
		@Li, 014 PSay dDataBase PICTURE "99/99/99"
		lPrintLin := .F.

		If LinhaCorrente <= 3
			If lPrintLin
				@Li, 000 PSay "|"
			EndIf
			@Li, 044 PSay STR0046 //"End.:"
			@Li, 050 PSay  Substr( cENDMED, 1, 26 )
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			lPrintLin := .T.
		EndIf

		If LinhaCorrente <= 4
			If lPrintLin
				@Li, 000 PSay "|"
			EndIf
			@Li, 044 PSay STR0047 //"Tel.:"
			@Li, 050 PSay cTELMED
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			lPrintLin := .T.
		EndIf
	
		@Li, 000 PSay Replicate( "-", 80 )

		cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
		nPosPag := ( Len( cPagina ) / 2 ) - 1

		If cLOGOM != 1 .Or. nPORPAG != 2 .Or. xx != 1 .Or. Li > 34 .Or. lQbVia
			SomaLin( , nCCouDep )
			@li+1, ( 040 - nPosPag ) PSay cPagina
		EndIf

		If cLOGOM == 1 //sem logo
			If nPORPAG == 2  // Duas por p gina
				If xx == 1
					If Li < 35
						If !lQbVia
							SomaLin( , nCCouDep )
							@Li, (040 - nPosPag) PSAY cPagina
							For cc := Li To 34
								SomaLin( , nCCouDep )
							Next cc
						Else
							Li := 0
						EndIf
					Else
						Li := 0
					EndIf
				Else
					Li := 0
				EndIf
			Else
				Li := 0
			EndIf
		EndIf

		lQbVia := .F.

	Next xx

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPASOM2
Impressão do ASO modelo 2

@type    function
@author  Liber de Esteban
@since   18/10/2004
@sample  sample

@param nPORPAG, ASOs por Pagina ? [1]
@param mvpar07, Termo de Respons. (Obs) ? [2]
@param mvpar08, Listar Exames NR7 ? [3]
@param nImpNR7, Imprimir logomarca ? [4]
@param cPar10, Modelo Impressao ? [5]
@param nVias, Numero de Vias ? [6]
@param nPar12, Via entregue ao funcionario ? [7]
@param nPar14, Imprimir Riscos ? [8]
@param nPar15, Imprimir Parecer do Medico ? [9]
@param nPar17, Imprimir Restricoes ? [10]
@param nCCouDep, Imprimir por ? [11]

/*/
//-------------------------------------------------------------------
User Function IMPASOM2( nPORPAG, mvpar07, mvpar08, nImpNR7, cPar10, nVias, nPar12, nPar14, nPar15, nPar17, nCCouDep )

	Local yy
	Local xx
	Local cc
	Local LinhaCorrente
	Local i
	Local nLCorrente
	Local nLinhasMemo	:= 0
	Local cNomeFunc		:= ""
	Local cTexte		:= ""
	Local aCampos		:= fPerAso()
	Local nCampos		:= 0
	Local nCont			:= 0
	//Controle da posição impressão das permissões
	Local nPosDesc		:= 0
	Local nPosCamp		:= 0
	Local nImp			:= 0
	Local lExist4653	:= ExistBlock( "MDTR4653" )
	Local lMDTA076		:= IsInCallStack( "MDTA076" )
	Local cNovFun		:= ""
	Local cNovCC		:= ""
	Local cDepto		:= ""
	Local aTarefASO		:= {} //Array que receberá as Tarefas da TYD relacionada ao ASO

	Private lTmpDFis	:= ( TM0->TM0_TIPDEF <> "0" .And. !Empty( TM0->TM0_TIPDEF ) )  //Indica se o funcionario/candidato é deficiente fisico
	Private nViaAtual	:= 0
	Private lTitulo		:= .T.
	Private lImpObs		:= .F.
	Private lImpRest	:= .F.
	Private aRiscos		:= {}
	Private aEXAMES		:= {}
	Private cObsAd		:= ""
	Private cObs		:= ""
	Private cObsRestri	:= ""
	Private nPagAt		:= 1
	Private nPagTot		:= 1
	Private LinhasMemoObs
	Private LinhasAso
	Private LinhasRes

	Private lin := 150
	Private oFont08	:= TFont():New( "ARIAL", 08, 08, , .F., , , , .F., .F. )
	Private oFont09	:= TFont():New( "ARIAL", 09, 09, , .F., , , , .F., .F. )
	Private oFont10	:= TFont():New( "ARIAL", 10, 10, , .F., , , , .F., .F. )
	Private oFont11	:= TFont():New( "ARIAL", 12, 12, , .T., , , , .T., .F. )
	Private oFont12	:= TFont():New( "ARIAL", 12, 12, , .F., , , , .F., .F. )
	Private oFont14	:= TFont():New( "ARIAL", 14, 14, , .F., , , , .F., .F. )
	Private oFont16	:= TFont():New( "ARIAL", 16, 16, , .T., , , , .T., .F. )

	Default nPar14 := 2
	Default nPar15 := 1
	Default nCCouDep := 1

	If ExistBlock( "MDTR4652" )
		cObsAd := ExecBlock( "MDTR4652" )
		If ValType( cObsAd ) != "C"
			cObsAd := ""
		EndIf
	EndIf


	//Verifica restricoes
	If nPar17 == 1 .And. TMY->TMY_INDPAR == "3"
		cObsRestri := f465RESTRI( TMY->TMY_NUMFIC, TMY->TMY_DTPROG, nPar17 )
	EndIf

	nMdRel := 2

	For xx := 1 To nVias
		oPrint:StartPage()

		nPagAt  := 1
		nPagTot := 1
		lin     := 150

		oPrint:line( lin, 030, lin, 2350 )

		If cLOGOM == 2
			Somalin( 60, nCCouDep )
			U_MDTR465LOG()
			lin += 20
		EndIf

		If ( nViaAtual == 0 ) .Or. ( nViaAtual == 1 ) .Or. ( nViaAtual == 2 )
			nViaAtual := nViaAtual + 1
		EndIf

		lTitulo  := .T.
		U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
		lTitulo  := .F.

		lPRIN   := .F.
		lFlag   := .T.

		/*Obtem total de paginas do relatorio.
		Chamada das funcoes para referente ao conteudo variavel do relatorio.
		aRiscos, aEXAMES, Memos TMY_DESCRI e TMZ->TMZ_DESCRI*/
		nPagTot := U_NGNRPAGASO( nImpNR7 )

		oPrint:Line( lin + 30, 30, lin + 30, 1060 )
		oPrint:Say( lin, 1080, STR0069, oFont16 ) //"Riscos"
		oPrint:Line( lin + 30, 1290, lin + 30, 2350 )

		If Len( aRiscos ) > 0
			lPRIN := .T.
			For i:=1 To Len( aRiscos )
				If lFlag
					lFlag := .F.
					lin += 60
					oPrint:Say( lin, 50, SubStr( Alltrim( aRiscos[i][2] ), 1, 37 ) + IIf( Len( aRiscos ) > 0 .And. i < Len( aRiscos ), ", ", "" ), oFont12 )
				Else
					lFlag := .T.
					oPrint:Say( lin, 1150, SubStr( Alltrim( aRiscos[i][2] ), 1, 37 ), oFont12 )
				EndIf
			Next i
		ElseIf !lPRIN
			cTextoRis := STR0111 //"Não há risco ocupacional específico para a atividade."
			lin += 60
			oPrint:Say( lin, 60, cTextoRis, oFont12 )
		EndIf

		If lExist4653
			ExecBlock( "MDTR4653", .F., .F., oPrint )
		Else
			lPRIN2 := .F.

			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				For yy := 1 To Len( aTmpExa )
					If !lPRIN2
						lin += 60
						oPrint:Line( lin + 30, 30, lin + 30, 1050 )
						oPrint:Say( lin, 1075, STR0070, oFont16 ) //"Exames"
						oPrint:Line( lin + 30, 1310, lin + 30, 2350 )
						lPRIN2 := .T.
					EndIf
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 70 )
					For nLCorrente := 1 To nLMemo
						lin += 60
						oPrint:Say( lin, 50, MemoLine( aTmpExa[yy, 3], 70, nLCorrente ), oFont12 )
						If nLCorrente == 1
							If Empty( aTmpExa[yy, 1] )
								oPrint:Say( lin, 2150, "___/___/____", oFont12, , , , 2 )
							Else
								oPrint:Say( lin, 2150, DToC( aTmpExa[yy, 1] ), oFont12, , , , 2 )
							EndIf
						EndIf
					Next LCorrente
				Next yy
			Else
				For yy := 1 To Len( aEXAMES )

					cExame := ""
					dDateResultado := ""

					If !Empty( aEXAMES[yy][2] )
						dbSelectArea( "TM5" )
						dbSetOrder( 08 )
						dbSeek( xFilial( 'TM5' ) + aEXAMES[yy][1] + DToS( aEXAMES[yy][2] ) + aEXAMES[yy][5] + aEXAMES[yy][3] )
						cExame := TM5->TM5_EXAME
						dDateResultado := DToC( TM5->TM5_DTRESU )
					EndIf

					If cRelExam == "2"
						If Empty( cExame )
							dbSelectArea( "TKB" )
							dbSetOrder( 01 )
							dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO + aEXAMES[yy][3] )
							cExame := TKB->TKB_EXAME
							dDateResultado := ""
						EndIf
					EndIf

					If !lPRIN2
						lin +=60
						oPrint:Line( lin + 30, 30, lin + 30, 1050 )
						oPrint:Say( lin, 1075, STR0070, oFont16 ) //"Exames"
						oPrint:Line( lin + 30, 1310, lin + 30, 2350 )
						lPRIN2 := .T.
					EndIf

					dbSelectArea( "TM4" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "TM4" ) + cExame )
					lin+=60

					oPrint:Say( lin, 50, SubStr( TM4->TM4_NOMEXA, 1, 40 ), oFont12 )
					oPrint:Say( lin, 1650, dDateResultado, oFont12 )

				Next yy
			EndIf

			If !lPRIN2 .And. !lPRIN
				cTextoExa := STR0034 //"Não existe necessidade de exame médico complementar, somente consulta clínica ocupacional."
				lin += 60
				oPrint:Line( lin + 30, 30, lin+30, 1050 )
				oPrint:Say( lin, 1075, STR0070, oFont16 ) //"Exames"
				oPrint:Line( lin+30, 1310, lin+30, 2350 )
				lin += 60
				oPrint:Say( lin, 60, cTextoExa, oFont12 )
			EndIf
		EndIf
		lTitulo := .T.
		Somalin( 60, nCCouDep )
		lTitulo  := .F.

		oPrint:Line( lin + 30, 30, lin + 30, 875 )
		oPrint:Say( lin, 900, STR0071, oFont16 ) //"Coordenador PCMSO"
		oPrint:Line( lin + 30, 1515, lin + 30, 2350 )
		Somalin( 70, nCCouDep )

		oPrint:Say( lin, 50, STR0072, oFont12 ) //"Medico . . . :"
		oPrint:Say( lin, 310, Substr( cNOMERES, 1, 30 ), oFont12 )
		oPrint:Say( lin, 1550, STR0073, oFont12 ) //"Tel. Contato . :"
		If !Empty( cTELRES )
			oPrint:Say( lin, 1860, cTELRES, oFont12 )
		EndIf

		Somalin( 60, nCCouDep )
		oPrint:Say( lin, 50, STR0057, oFont12 ) //"Endereço . :"
		If !Empty( cENDRES )
			oPrint:Say( lin, 310, cENDRES, oFont12 )
		EndIf
		oPrint:Say( lin, 1650, STR0074, oFont12 ) //"CRM . :"
		oPrint:Say( lin, 1860, cCRMRES, oFont12 )
		Somalin( 60, nCCouDep )

		If !Empty( aCampos )

			oPrint:Line( lin + 30, 30, lin + 30, 875 )
			oPrint:Say( lin, 900, STR0249, oFont16 ) //"Permissões para trabalho"
			oPrint:Line( lin + 30, 1700, lin + 30, 2350 )
			Somalin( 40, nCCouDep )

			//Imprime os campos de Trabalhos específicos em formato de array
			For nCampos := 1 To Len( aCampos )
				nImp++
				If nImp % 2 != 0 //Campo impar, recomeça a linha
					nPosDesc := 40
					nPosCamp := 835
					Somalin( 50, nCCouDep )
				Else //Campo par, impressão na linha atual
					nPosDesc := 1250
					nPosCamp := 2040
				EndIf

				oPrint:Say( lin, nPosDesc, aCampos[ nCampos, 2 ], oFont12 ) //Título

			Next nCampos

			nImp := 0

		EndIf

		If lImpRest
			lPRIN := .T.
			For LinhaCorrente := 1 To LinhasRes
				If lPRIN
					lTitulo := .T.
					Somalin( 80, nCCouDep )
					lTitulo := .F.
					oPrint:Line( lin + 30, 30, lin + 30, 1015 )
					oPrint:Say( lin, 1040, STR0186, oFont16 )//"Restrições"
					oPrint:Line( lin + 30, 1450, lin + 30, 2350 )
					Somalin( 10, nCCouDep )
					lPRIN := .F.
				EndIf
				Somalin( 60, nCCouDep )
				oPrint:Say( lin, 80, MemoLine( cObsRestri, 105, LinhaCorrente ), oFont12 )
			Next LinhaCorrente
		EndIf

		If lImpObs
			lPRIN := .T.
			For LinhaCorrente := 1 To LinhasMemoObs
				If lPRIN
					lTitulo := .T.
					Somalin( 50, nCCouDep )
					lTitulo := .F.
					oPrint:Line( lin + 30, 30, lin + 30, 1015 )
					oPrint:Say( lin, 1040, STR0087, oFont16 ) //"Observação"
					oPrint:Line( lin + 30, 1450, lin + 30, 2350 )
					Somalin( 10, nCCouDep )
					lPRIN := .F.
				EndIf
				Somalin( 50, nCCouDep )
				oPrint:Say( lin, 80, MemoLine( cObs, 90, LinhaCorrente ), oFont12 )
			Next LinhaCorrente
		EndIf

		lin += 10
		oPrint:Line( 150, 030, lin, 030 )
		oPrint:Line( 150, 2350, lin, 2350 )

		//--------- Realizacao -----------
		If ( lin + 730 ) > 3100
			Somalin( 50, nCCouDep )
			oPrint:Line( lin, 030, lin , 2350 )
			oPrint:Line( 150, 030, lin , 030 )
			oPrint:Line( 150, 2350, lin , 2350 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina )/2 ) - 1
			oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 150
			oPrint:Line( lin, 030, lin, 2350 )
			If cLOGOM == 2 //imprime logo
				Somalin( 50, nCCouDep )
				U_MDTR465LOG()
				lin+=20
			EndIf
			lTitulo := .T.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lTitulo  := .F.
		EndIf

		Somalin( 50, nCCouDep )
		oPrint:Line( lin, 030, lin, 2350 )
		oPrint:Say( lin, 50, STR0084, oFont12 )  //"Parecer . . . . . . :"
		If nPar15 == 1
			oPrint:Say( lin, 400, cINDPAR, oFont11 )
		Else
			oPrint:Say( lin, 400, "( )" + STR0118 + "   ( )" + STR0119 + "   ( )" + STR0160, oFont12 ) //"Apto"#"Inapto"#"Apto Com Restricoes"
		EndIf
		oPrint:Say( lin, 1200, STR0220 + ". . . . . . :", oFont12 ) //"Natureza . . :"
		If (nIND := aScan( aTMYcombo, { |x| Upper( Substr( x, 1, 1 ) ) == Substr( TMY->TMY_NATEXA, 1, 1 ) } ) ) > 0
			oPrint:Say( lin, 1550, Alltrim( Substr( aTMYcombo[nIND], 3, 40 ) ), oFont11, , , ,  0 )
		EndIf

		If TMY->TMY_NATEXA == "3" .And. TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0

			If TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0

				aTblOpen := { { "SRJ", 01 }, { "CTT", 01 }, { "SQB", 01}, { "TN5", 01 } }
				cEmpBkp	:= ""
				cFilBkp	:= ""
				cEmpFut := TMY->TMY_EMPFUT
				cFilFut := TMY->TMY_FILFUT

				If cEmpFut <> cEmpAnt .And. !Empty( cEmpFut )
					//Bkp da empresa e filial
					cEmpBkp := cEmpAnt
					cFilBkp := cFilAnt

					NGPrepTBL( aTblOpen, cEmpFut, cFilFut )

					cFilAnt := cFilFut
				ElseIf cFilFut <> cFilAnt .And. !Empty( cFilFut )
					cFilBkp := cFilAnt
					cFilAnt := cFilFut
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0 .And. !Empty( TMY->TMY_NOVCC )
				cNovCC := NGSeek( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. !Empty( TMY->TMY_NOVFUN )
				cNovFun := NGSeek( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" )
			EndIf

			If TMY->( FieldPos( "TMY_NOVTAR" ) ) > 0
				If lAliasTYD
					dbSelectArea( "TYD" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "TYD", cFilBkp ) + TMY->TMY_NUMASO )
						While TYD->( !Eof() ) .And. TYD->TYD_FILIAL == xFilial( "TYD", cFilBkp ) .And. TMY->TMY_NUMASO == TYD->TYD_NUMASO
							aAdd( aTarefASO, SubStr( Posicione( "TN5", 1, xFilial( "TN5" ) + TYD->TYD_CODTAR, "TN5_NOMTAR" ), 1, 40 ) )
							TYD->( dbSkip() )
						End
					EndIf
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If !Empty( TMY->TMY_NOVDEP )
					cDepto := NGSeek( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" )
				EndIf
			EndIf

			If TMY->( FieldPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( FieldPos( "TMY_FILFUT" ) ) > 0

				//Retorna para empresa e filial correta
				If !Empty( cEmpFut ) .And. cEmpFut <> cEmpAnt
					NGPrepTBL( aTblOpen, cEmpAnt, cFilBkp )

					cFilAnt := cFilBkp
				ElseIf !Empty( cFilBkp ) .And. cFilBkp <> cFilAnt
					cFilAnt := cFilBkp
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0  .And. Empty( cNovCC )
				cNovCC := NGSeek( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. Empty( cNovFun )
				cNovFun := NGSEEK( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If Empty( cDepto )
					cDepto := NGSeek( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" )
				EndIf
			EndIf

			Somalin( 50, nCCouDep )

			If !Empty( cNovCC )
				oPrint:Say( lin, 1200, STR0242 + ". . . . . . . . :", oFont12 ) //"Novo CC"
				oPrint:Say( lin, 1575, cNovCC, oFont11, , , ,  0 )
			EndIf
			If !Empty( cNovFun )
				oPrint:Say( lin, 0050, STR0204 + ". . . . :", oFont12 ) //"Nova Função"
				oPrint:Say( lin, 0500, cNovFun, oFont11, , , ,  0 )
			EndIf

			For nCont := 1 To Len( aTarefASO )
				Somalin( 50, nCCouDep )
				If nCont == 1 //Só imprimirá o titulo 1 vez
					oPrint:Say( lin, 0050, IIf( lAliasTYD, STR0245, STR0243 ) + ". . . :", oFont12 ) //"Nova Tarefa"
				EndIf
				oPrint:Say( lin, 0400, aTarefASO[ nCont ], oFont11, , , , 0 )
			Next nCont

			//Zera array de tarefas para que não duplique as tarefas da próxima via
			aTarefASO := {}

			Somalin( 50, nCCouDep )

			If !Empty( cDepto )
				oPrint:Say( lin, 1200, STR0244 + ". . . . . . :", oFont12 ) //"Novo Dep."
				oPrint:Say( lin, 1560, cDepto, oFont11, , , ,  0 )
			EndIf

		ElseIf !Empty(TMY->TMY_DESCRI) 	

			Somalin( 50, nCCouDep )
			
		EndIf

		lPrin := .T.
		For LinhaCorrente := 1 To LinhasAso
			If !Empty( ( MemoLine( TMY->TMY_DESCRI, 30, LinhaCorrente ) ) )
				If lPRIN
					oPrint:Say( lin, 50, STR0086, oFont12 ) //"Procedimento . :"
					lPRIN := .F.
				EndIf

				oPrint:Say( lin, 380, MemoLine( TMY->TMY_DESCRI, 30, LinhaCorrente ), oFont12 )
				Somalin( 40, nCCouDep )
			Else
				Exit
			EndIf
		Next LinhaCorrente

		If ( lin + 730 ) > 3100
			Somalin( 100, nCCouDep )
			oPrint:Line( lin, 030, lin , 2350 )
			oPrint:Line( 150, 030, lin , 030 )
			oPrint:Line( 150, 2350, lin , 2350 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina )/2 ) - 1
			oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 150
			oPrint:Line( lin, 030, lin, 2350 )
			If cLOGOM == 2 //imprime logo
				Somalin( 50, nCCouDep )
				U_MDTR465LOG()
				lin+=20
			EndIf
			lTitulo := .T.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lTitulo  := .F.
		EndIf

		Somalin( 50, nCCouDep )
		oPrint:Line( lin + 30, 30, lin + 30, 1015 )
		oPrint:Say( lin, 1040, STR0075, oFont16 ) //"Realização"
		oPrint:Line( lin + 30, 1360, lin + 30, 2350 )

		oPrint:Say( lin + 70, 50, STR0161 + Str( nPar12, 1 ) + STR0162, oFont12 ) // "Declaro que recebi a "###"ª via do ASO"

		Somalin( 120, nCCouDep )

		oPrint:Say( lin + 50, 50, STR0076, oFont12 ) //"Assinatura. . :"
		oPrint:Line( lin + 90, 350, lin + 90, 1150 )
		oPrint:Say( lin + 50, 1255, STR0077, oFont12 ) //"Ass . . :"
		oPrint:Line( lin + 90, 1440, lin + 90, 2300 )
		Somalin( 60, nCCouDep )

		If lTM0
			DbSelectArea( "TM0" )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )
			cNomeFunc := TM0->TM0_NOMFIC
			oPrint:Say( lin + 50, 50, STR0059, oFont12 ) //"Candidato....:"

			If lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := Memoline(TM0->TM0_NOMSOC, 30)
			EndIf
		EndIf

		dbSelectArea( "SRA" )
		dbSetOrder( 1 )
		If dbSeek(  IIf( lMDTA076, TM0->TM0_FILFUN, xFilial( "SRA" ) ) + TM0->TM0_MAT ) .And. !Empty( SRA->RA_MAT )

			If !Empty( SRA->RA_NSOCIAL )
				cNomeSocial := Memoline(SRA->RA_NSOCIAL, 30)
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := Memoline(TM0->TM0_NOMSOC, 30)
			EndIf

			If !Empty( SRA->RA_NOMECMP )
				cNomeFunc := SRA->RA_NOMECMP
				oPrint:Say( lin + 50, 50, STR0078, oFont12 ) //"Funcionário. :"

			ElseIf !Empty( SRA->RA_NOME )
				cNomeFunc := SRA->RA_NOME
				oPrint:Say( lin + 50, 50, STR0078, oFont12 ) //"Funcionário. :"

			EndIf

		EndIf

		If !Empty( cNomeFunc )
			nLinhasMemo := MLCOUNT( AllTrim( cNomeFunc ), 30 ) 	// quanto o nome atingir 40 caracter ele quebra e joga pra baixo

			For LinhaCorrente := 1 To nLinhasMemo

				cTexte := MemoLine( cNomeFunc, 30, LinhaCorrente )

				If LinhaCorrente > 1
				EndIf

				If nLinhasMemo == 1
					If LinhaCorrente == 1
						oPrint:Say( lin + 50, 350, cTexte, oFont12 )// Imprime Atestado.
						Somalin( 60, nCCouDep )
						If lNomSocTM0 .And. !Empty( SRA->RA_NSOCIAL ) .Or. !Empty( TM0->TM0_NOMSOC )
							oPrint:Say( lin + 50, 50, STR0250, oFont12 ) //"Nome Social:"
							oPrint:Say( lin + 50, 350, cNomeSocial, oFont12 ) // Nome Social
						EndIf
						oPrint:Say( lin, 1250, STR0079, oFont12 ) //"Resp . :"
						oPrint:Say( lin, 1440, SubStr( cNOMEMED, 1, 24 ), oFont12 )
						Somalin( 60, nCCouDep )
						oPrint:Say( lin + 100, 50, STR0080, oFont12 ) //"Data. . . . . . . :"
						oPrint:Say( lin + 100, 350, DToC( dDataBase ), oFont12 )
						oPrint:Say( lin, 1250, STR0081, oFont12 ) //"CRM . :"
						oPrint:Say( lin, 1440, cCRMMDE, oFont12 )
						Somalin( 60, nCCouDep )
						oPrint:Say( lin, 1248, STR0082, oFont12 ) //"End . . :"
						oPrint:Say( lin, 1440, cENDMED, oFont12 )
						oPrint:Say( lin + 70, 1248, STR0083, oFont12 ) //"Tel . . . :"
						oPrint:Say( lin + 70, 1440, cTELMED, oFont12 )
						Somalin( 60, nCCouDep )
					EndIf
				ElseIf nLinhasMemo == 2
					If LinhaCorrente == 1
						oPrint:Say( lin + 50, 350, cTexte, oFont12 )// Imprime Atestado.
						Somalin( 60, nCCouDep )
						oPrint:Say( lin, 1250, STR0079, oFont12 ) //"Resp . :"
						oPrint:Say( lin, 1440, SubStr( cNOMEMED, 1, 24 ), oFont12 )
						Somalin( 60, nCCouDep )
					EndIf
					If LinhaCorrente == 2
						oPrint:Say( lin-10, 350, cTexte, oFont12 )// Imprime Atestado.
						If lNomSocTM0 .And. !Empty( SRA->RA_NSOCIAL ) .Or. !Empty( TM0->TM0_NOMSOC )
							oPrint:Say( lin + 50, 50, STR0250, oFont12 ) //"Nome Social:"
							oPrint:Say( lin + 50, 350, cNomeSocial, oFont12 ) // Nome Social
						EndIf
						oPrint:Say( lin, 1250, STR0081, oFont12 ) //"CRM . :"
						oPrint:Say( lin, 1440, cCRMMDE, oFont12 )
						Somalin( 60, nCCouDep )
						oPrint:Say( lin, 1248, STR0082, oFont12 ) //"End . . :"
						oPrint:Say( lin, 1440, cENDMED, oFont12 )
						oPrint:Say( lin + 100, 47, STR0080, oFont12 ) //"Data. . . . . . . :"
						oPrint:Say( lin + 100, 350, DToC( dDataBase ), oFont12 )
						oPrint:Say( lin + 50, 1245, STR0083, oFont12 ) //"Tel . . . :"
						oPrint:Say( lin + 50, 1440, cTELMED, oFont12 )
					EndIf
				ElseIf nLinhasMemo == 3
					If LinhaCorrente == 1
						oPrint:Say( lin + 50, 350, cTexte, oFont12 )// Imprime Atestado.
						Somalin( 60, nCCouDep )
						oPrint:Say( lin, 1250, STR0079, oFont12 ) //"Resp . :"
						oPrint:Say( lin, 1440, SubStr( cNOMEMED, 1, 24 ), oFont12 )
						Somalin( 60, nCCouDep )
					EndIf
					If LinhaCorrente == 2
						oPrint:Say( lin - 10, 350, cTexte, oFont12 )// Imprime Atestado.
						oPrint:Say( lin, 1250, STR0081, oFont12 ) //"CRM . :"
						oPrint:Say( lin, 1440, cCRMMDE, oFont12 )
						Somalin( 60, nCCouDep )
					EndIf
					If LinhaCorrente == 3
						oPrint:Say( lin - 10, 350, cTexte, oFont12 )// Imprime Atestado.
						If lNomSocTM0 .And. !Empty( SRA->RA_NSOCIAL ) .Or. !Empty( TM0->TM0_NOMSOC )
							oPrint:Say( lin + 50, 50, STR0250, oFont12 ) //"Nome Social:"
							oPrint:Say( lin + 50, 350, cNomeSocial, oFont12 ) // Nome Social
						EndIf
						oPrint:Say( lin, 1248, STR0082, oFont12 ) //"End . . :"
						oPrint:Say( lin, 1440, cENDMED, oFont12 )
						oPrint:Say( lin + 100, 47, STR0080, oFont12 ) //"Data. . . . . . . :"
						oPrint:Say( lin + 100, 350, DToC( dDataBase ), oFont12 )
						oPrint:Say( lin + 50, 1245, STR0083, oFont12 ) //"Tel . . . :"
						oPrint:Say( lin + 50, 1440, cTELMED, oFont12 )
					EndIf
				EndIf
			Next LinhaCorrente
		Else
			oPrint:Say( lin + 50, 350, SubStr( SRA->RA_NOME, 1, 33 ), oFont12 )
			Somalin( 60, nCCouDep )
			oPrint:Say( lin, 1250, STR0079, oFont12 ) //"Resp . :"
			oPrint:Say( lin, 1440, SubStr( cNOMEMED, 1, 30 ), oFont12 )
			Somalin( 60, nCCouDep )
			oPrint:Say( lin, 1250, STR0081, oFont12 ) //"CRM . :"
			oPrint:Say( lin, 1440, cCRMMDE, oFont12 )
			Somalin( 60, nCCouDep )
			oPrint:Say( lin, 1248, STR0082, oFont12 ) //"End . . :"
			oPrint:Say( lin, 1440, cENDMED, oFont12 )
			oPrint:Say( lin + 70, 1245, STR0083, oFont12 ) //"Tel . . . :"
			oPrint:Say( lin + 70, 1440, cTELMED, oFont12 )
		EndIf
		
		lin += 150
		oPrint:Line( lin, 030, lin, 2350 )
		oPrint:Line( 150, 030, lin, 030 )
		oPrint:Line( 150, 2350, lin, 2350 )

		cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
		nPosPag := ( Len( cPagina ) / 2 ) - 1
		oPrint:Say( lin + 170, ( 1145 - nPosPag ), cPagina, oFont12 )

		oPrint:EndPage()
	Next xx

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPASOM3
Impressao do ASO modelo 3

@author Liber De Esteban
@since 18/11/2004

@param nPORPAG, ASOs por Pagina ? [1]
@param mvpar07, Termo de Respons. (Obs) ? [2]
@param mvpar08, Listar Exames NR7 ? [3]
@param nImpNR7, Imprimir logomarca ? [4]
@param cPar10, Modelo Impressao ? [5]
@param nVias, Numero de Vias ? [6]
@param nPar12, Via entregue ao funcionario ? [7]
@param nPar13, ??? [8]
@param nPar14, Imprimir Riscos ? [9]
@param nPar15, Imprimir Parecer do Medico ? [10]
@param nPar17, Imprimir Restricoes ? [11]
@param nCCouDep, Imprimir por ? [12]

/*/
//-------------------------------------------------------------------
User Function IMPASOM3( nPORPAG, mvpar07, mvpar08, nImpNR7, cPar10, nVias, nPar12, nPar13, nPar14, nPar15, nPar17, nCCouDep )

	Local nAdd
	Local nLCorrente
	Local xx
	Local yy
	Local i
	Local nCont := 0
	Local nCont2 := 0
	Local nImp := 0
	Local nPosDesc := 0
	Local nPosCamp := 0
	Local aCampos := fPerAso()
	Local nLinhasMemo := 0
	Local nLinhaCorrente := 0
	Local nLinha := 0
	Local lExist4653 := ExistBlock( "MDTR4653" )
	Local lMDTA076 := IsInCallStack( "MDTA076" )
    Local lMDTA200 := IsInCallStack( "MDTA200" )
	Local lMDTA465 := IsInCallStack( "MDTR465" )
	Local cNovFun := ""
	Local cAntFun := ''
	Local cNovCC := ""
	Local cAntCC := ''
	Local cDepto := ""
	Local nLinBckp := 0
	Local cAntDepto := ''
	Local aTarefASO := {} // Array que receberá as Tarefas da TYD relacionada ao ASO

	Private lTmpDFis := IIf( Type( "lDefisTM0" ) != "L", .F., IIf( lDefisTM0, (TM0->TM0_TIPDEF != "0" .And. !Empty( TM0->TM0_TIPDEF ) ), .F. ) ) //Indica se o funcionario/candidato é deficiente fisico
	Private nViaAtual := 0
	Private lTitulo := .F.
	Private lPagIn := .T.
	Private aRiscos := {}
	Private aEXAMES := {}
	Private nPagAt := 1
	Private nPagTot := 1
	Private lImpObs := .F.
	Private lImpRest := .F.
	Private cObs := ""
	Private cObsAd := ""
	Private cObsRestri := ""
	Private lPRIN := .F.
	Private lPRIN2 := .F.
	Private nLinha1 := 80 // Linha inicial do relatório
	Private nMargEsq := 80 // Valor da margem esquerda
	Private nMargDir := 2420 // Valor da margem direita
	Private LinhasMemoObs
	Private LinhasRes
	Private cDescri
	Private _CIDADE
	Private cNomeFunc
	Private cCCFUNC
	Private oFont16
	Private oFont14
	Private oFont13
	Private oFont12
	Private oFont11
	Private oFont10
	Private lin

	Default nPar14   := 2
	Default nPar15   := 1
	Default nCCouDep := 1

	If ExistBlock( "MDTR4652" )
		cObsAd := ExecBlock( "MDTR4652" )
		If ValType( cObsAd ) != "C"
			cObsAd := ""
		EndIf
	EndIf

	//Verifica restricoes
	If nPar17 == 1 .And. TMY->TMY_INDPAR == "3"
		cObsRestri := f465RESTRI( TMY->TMY_NUMFIC, TMY->TMY_DTPROG, nPar17 )
	EndIf

	nMdRel := 3

	oFont08	 := TFont():New( "ARIAL", 08, 08, , .F., , , , .F., .F. )
	oFont09	 := TFont():New( "ARIAL", 10, 10, , .F., , , , .F., .F. )
	oFont10	 := TFont():New( "ARIAL", 10, 10, , .T., , , , .T., .F. )
	oFont10x := TFont():New( "ARIAL", 10, 10, , .F., , , , .F., .F. )
	oFont11	 := TFont():New( "ARIAL", 11, 11, , .T., , , , .T., .F. )
	oFont12	 := TFont():New( "ARIAL", 12, 12, , .F., , , , .F., .F. )
	oFont13  := TFont():New( "ARIAL", 12, 12, , .T., , , , .T., .F. )
	oFont14  := TFont():New( "ARIAL", 14, 14, , .F., , , , .F., .F. )
	oFont16	 := TFont():New( "ARIAL", 16, 16, , .T., , , , .T., .F. )

	For xx := 1 To nVias
		oPrint:StartPage()
		lPagIn  := .T.
		nPagAt 	:= 1

		lin := nLinha1

		oPrint:Line( lin, nMargEsq, lin, nMargDir ) // Primeira linha antes do cabeçalho
		oPrint:Line( lin, nMargEsq, lin + 405, nMargEsq ) // Borda esquerda
		oPrint:Line( lin, nMargDir, lin + 405, nMargDir ) // Borda direita

		lin := 150

		If cLOGOM == 2
			U_MDTR465LOG()
		EndIf

		If ( nViaAtual == 0 ) .Or. ( nViaAtual == 1 ) .Or. ( nViaAtual == 2 )
			nViaAtual := nViaAtual + 1
		EndIf

		U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )

		lin += 120
		nLinaux := lin + 80

		oPrint:Line( lin, nMargEsq, lin, nMargDir ) // 1° linha dos riscos
		oPrint:Line( lin, nMargEsq, lin + 100, nMargEsq ) // Borda esqueda
		oPrint:Line( lin, nMargDir, lin + 100, nMargDir ) // Borda direita
		oPrint:Line( lin + 100, nMargEsq, lin + 100, nMargDir ) // 2° linha

		//Imprime os Riscos
		oPrint:Say( lin + 30, 1020, STR0108, oFont13 ) //"RISCOS OCUPACIONAIS"

		lPRIN := .F.
		lin += 120

		nLinBckp := lin - 20

		/*Obtem total de paginas do relatorio.
		Chamada das funcoes para referente ao conteudo variavel do relatorio.
		aRiscos, aEXAMES, Memos TMY_DESCRI e TMZ->TMZ_DESCRI*/
		nPagTot := U_NGNRPAGASO( nImpNR7 )

		If Len( aRiscos ) > 0
			lPRIN := .T.
			For i := 1 To Len( aRiscos )
				If Len( aRiscos[i] ) > 2
					oPrint:Say( lin, 140, aRiscos[i][2], oFont13 )
					nLMemo := MLCOUNT( aRiscos[i][3], 70 )
					For nLCorrente := 1 To nLMemo
						If !Empty( ( MemoLine( aRiscos[i][3], 70, nLCorrente ) ) )
							oPrint:Say( lin, 670, MemoLine( aRiscos[i][3], 70, nLCorrente ), oFont12 )
							lin += 55
						EndIf
					Next nLCorrente
				EndIf
				If i != Len( aRiscos ) .And. Len( aRiscos[i + 1] ) > 2
					lin += 15
				EndIf
			Next i
		ElseIf !lPRIN
			cTextoRis := STR0111 //"Não há risco ocupacional específico para a atividade."
			oPrint:Say( lin, 140, cTextoRis, oFont12 )
			lin += 50
		EndIf		

		lin += 30
		If lin >= 3160
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 100
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			lPagIn := .F.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lin := 900
		EndIf
		// IMPRIME OS EXAMES
		If lExist4653
			ExecBlock( "MDTR4653", .F., .F., oPrint )
		Else
			lPRIN  := .F.
			lPRIN2 := .F.

			nLinaux := lin + 5

			oPrint:Line( lin, nMargEsq, lin, nMargDir ) // 3° linha
			oPrint:Line( nLinBckp, nMargEsq, lin, nMargEsq ) // Borda esquerda
			oPrint:Line( nLinBckp, nMargDir, lin, nMargDir ) // Borda direita

			oPrint:Say( lin + 30, 750, STR0112, oFont13 ) //"REALIZOU OS SEGUINTES EXAMES OCUPACIONAIS"

			oPrint:Line( lin + 100, nMargEsq, lin + 100, nMargDir ) // 4° linha

			nLinBckp := lin

			If lPrin
				oPrint:Say( lin + 130, 950, STR0113, oFont13 )  //"TIPO"
				oPrint:Say( lin + 130, 2045, STR0114, oFont13 ) //"DATA"
				lin += 100
			EndIf
			lin += 100
			lin += 20
			lAdd := .T.

			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				For yy := 1 To Len( aTmpExa )
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 70 )
					For nLCorrente := 1 To nLMemo
						lPRIN2 := .T.
						oPrint:Say( lin, 140, MemoLine( aTmpExa[yy, 3], 70, nLCorrente ), oFont12 )
						If nLCorrente == 1
							If Empty( aTmpExa[yy, 1] )
								oPrint:Say( lin, 2200, "___/___/____", oFont12, , , , 2 )
							Else
								oPrint:Say( lin, 2200, DToC( aTmpExa[yy, 1] ), oFont12, , , , 2 )
							EndIf
						EndIf
						lin+=55
						If lin >= 3100
							cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
							nPosPag := ( Len( cPagina ) / 2 ) - 1
							oPrint:Say( 3100, 1225, cPagina, oFont12, , , , 2 )
							nPagAt++
							oPrint:EndPage()
							oPrint:StartPage()
							lin := 100
							If cLOGOM == 2 //imprime logo
								U_MDTR465LOG()
							EndIf
							lPagIn := .F.
							U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
							lin := 900
							nLinaux := lin + 5
							lAdd := .F.
						EndIf
						lin += 15
					Next LCorrente
				Next yy
			Else
				For yy := 1 To Len( aEXAMES )

					cExame := ""
					dDateResultado := ""

					If !Empty( aEXAMES[yy][2] )
						dbSelectArea( "TM5" )
						dbSetOrder( 08 )
						dbSeek( xFilial( 'TM5' ) + aEXAMES[yy][1] + DToS( aEXAMES[yy][2] ) + aEXAMES[yy][5] + aEXAMES[yy][3] )
						cExame := TM5->TM5_EXAME
						dDateResultado := DToC( TM5->TM5_DTRESU )
					EndIf

					If cRelExam == "2"
						If Empty( cExame )
							dbSelectArea( "TKB")
							dbSetOrder( 01)
							dbSeek( xFilial( 'TKB') + TMY->TMY_NUMASO + aEXAMES[yy][3] )
							cExame := TKB->TKB_EXAME
							dDateResultado := ""
						EndIf
					EndIf

					lPRIN2 := .T.
					dbSelectArea( "TM4" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "TM4" ) + cExame )
					oPrint:Say( lin, 140, SubStr( TM4->TM4_NOMEXA, 1, 40 ), oFont12 )
					oPrint:Say( lin, 2020, dDateResultado, oFont12 )
					lin+=55
					If lin >= 3100
						oPrint:line( lin,  nMargDir,  nLinaux,  nMargDir )
						cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
						nPosPag := ( Len( cPagina ) / 2 ) - 1
						oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina, oFont12 )
						nPagAt++
						oPrint:EndPage()
						oPrint:StartPage()
						lin := 100
						If cLOGOM == 2 //imprime logo
							U_MDTR465LOG()
						EndIf
						lPagIn := .F.
						U_MDTR465CBL( nVias,  nViaAtual,  lTmpDFis, nCCouDep )
						lin := 1000

						nLinaux := lin + 10

						lAdd := .F.
					EndIf
					lin += 15

				Next yy
			EndIf

			oPrint:Line( nLinBckp, nMargEsq, lin, nMargEsq ) // Borda esquerda
			oPrint:Line( nLinBckp, nMargDir, lin, nMargDir ) // Borda direita

			nLinBckp := lin

			If !lPRIN2 .And. !lPRIN
				cTextoExa := STR0115 //"Não existe necessidade de exame médico complementar, somente consulta clínica ocupacional."
				oPrint:Say( lin, 140, cTextoExa, oFont12 )
				If !Empty( cDescri )
					oPrint:Say( lin + 90, 140, STR0116, oFont13 ) //"OBSERVAÇÕES:"
					lin += 80
					nLMemo := MLCOUNT( cDescri, 63 )
					For nLCorrente := 1 To nLMemo
						If !Empty( ( MemoLine( cDescri, 63, nLCorrente ) ) )
							oPrint:Say( lin + 10, 520, MemoLine( cDescri, 63, nLCorrente ), oFont12 )
							lin += 50
						EndIf
					Next LCorrente
					lin -= 40
				EndIf
			Else
			
			oPrint:Line( lin, nMargEsq, lin, nMargDir )

			nAdd := 0

			If lAdd
				nAdd := 95
			EndIf
				If cGrpExam == "2" //Agrupa os exames por Data
					oPrint:line( lin, 2050, nLinaux + nAdd, 2050 )
				Else
					oPrint:line( lin, 1870, nLinaux + nAdd, 1870 )
				EndIf
				oPrint:Say( lin + 10, 140, STR0116, oFont13 ) //"OBSERVAÇÕES:"
				If !Empty( cDescri )
					nLMemo := MLCOUNT( cDescri, 90 )
					For nLCorrente := 1 To nLMemo
						If !Empty( ( MemoLine( cDescri, 90, nLCorrente ) ) )
							oPrint:Say( lin + 10, 520, MemoLine( cDescri, 90, nLCorrente ), oFont12 )
							lin += 50
						EndIf
					Next LCorrente
					lin -= 40
				EndIf
			EndIf
		EndIf
		lin += 50

		lin += 30
		If lin >= 3160
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 100
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			lPagIn := .F.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lin := 900
		EndIf

		If !Empty( aCampos )
			
			oPrint:Line( lin, nMargEsq, lin, nMargDir )
			Somalin( 30, nCCouDep )
			oPrint:Say( lin, 900, Upper(STR0249) + Space( 3 ), oFont13 ) //"Permissões para trabalho"
			Somalin( 50, nCCouDep )
			oPrint:Line( lin, nMargEsq, lin, nMargDir )

			For nCont := 1 To Len( aCampos )
				nImp++ // Caso entre, incrementa o contador dos campos impressos
				If nImp % 2 != 0 // Se for campo impar, recomeça a linha para impressão
					nPosCamp := 150
					nPosDesc := 920
					Somalin( 50, nCCouDep )
				Else
					// Se for campo ímpar, realiza a impressão na linha atual
					nPosCamp := 1160
					nPosDesc := 1930
				EndIf

				// Imprime as informações do campos conforme disposto na posição do array
				oPrint:Say( lin, nPosCamp, aCampos[ nCont, 2 ], oFont12 )

			Next nCont

			nImp := 0

			oPrint:Line( lin + 100, nMargEsq, lin + 100, nMargDir )

			lin += 120

		EndIf

		oPrint:Line( nLinBckp, nMargEsq, lin + 100, nMargEsq ) // Borda esquerda
		oPrint:Line( nLinBckp, nMargDir, lin + 100, nMargDir ) // Borda direita
		
		If lImpRest
			lPRIN := .T.
			lFlag := .F.
			For nLCorrente := 1 To LinhasRes
			Somalin( 60, nCCouDep )
				If lPRIN
					oPrint:Line( lin, nMargEsq + 5, lin, nMargDir - 5 )   // Linha Horizontal superior do bloco
					oPrint:Line( lin + 5, nMargEsq, lin, nMargEsq + 5 )   // Borda Superior Esquerda do bloco
					oPrint:Line( lin, nMargDir - 5, lin + 5, nMargDir )   // Borda Superior Direita do bloco
					oPrint:Line( lin + 5, nMargEsq, lin + 100, nMargEsq ) // Linha Vertical Esquerda do bloco
					oPrint:Line( lin + 5, nMargDir, lin + 100, nMargDir ) // Linha Vertical Direita do bloco

					oPrint:Say( lin + 20, 1020, Upper( STR0186 ), oFont13 )//"Restrições"
					oPrint:Line( lin + 80, nMargEsq, lin + 80, nMargDir ) // Linha Horizontal inferior do bloco
					Somalin( 60, nCCouDep )
					oPrint:Line( lin, nMargEsq, lin + 75, nMargEsq ) // Linha Vertical esquerda do bloco
					oPrint:Line( lin, nMargDir, lin + 75, nMargDir ) // Linha Vertical direita do bloco
					Somalin( 60, nCCouDep )
					
					lFlag := .T.
					lPRIN := .F.
				EndIf

					oPrint:Say( lin, 130, MemoLine( cObsRestri, 75, nLCorrente ), oFont12 )
					oPrint:Line( lin, nMargEsq, lin + 75, nMargEsq ) // Linha Vertical esquerda do bloco
					oPrint:Line( lin, nMargDir, lin + 75, nMargDir ) // Linha Vertical direita do bloco

			Next nLCorrente

			If lFlag // Se imprimiu a Observacao
				oPrint:Line( lin + 80, nMargEsq + 5,lin + 80, nMargDir - 5 )// Linha Horizontal inferior do bloco
				oPrint:Line( lin + 75, nMargEsq, lin + 80, nMargEsq + 5 )  // Borda Inferior Esquerda do bloco
				oPrint:Line( lin + 75, nMargDir, lin + 80, nMargDir - 5 )  // Borda Inferior Direita do bloco
				lin += 150
			EndIf
		EndIf

		// OBSERVACAO
		If lImpRest == .T.
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			oPrint:Say( 3190, ( 1220 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 150
			//Primeira linha antes do cabeçalho
			oPrint:Line( lin - 70, nMargEsq + 5, lin - 70, nMargDir - 5 )
			//Bordas arredondadas
			oPrint:Line( lin - 65, nMargEsq, lin - 70, nMargEsq + 5 )
			oPrint:Line( lin - 65, nMargDir, lin -70, nMargDir - 5 )
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			lPagIn := .F.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lin := 1200
		EndIf

		If lImpObs
			lPRIN := .T.
			lFlag := .F.
			For nLCorrente := 1 To LinhasMemoObs
				If lPRIN
					oPrint:Line( lin, nMargEsq + 5, lin, nMargDir - 5 )   // Linha Horizontal superior do bloco
					oPrint:Line( lin + 5, nMargEsq, lin, nMargEsq + 5 )   // Borda Superior Esquerda do bloco
					oPrint:Line( lin, nMargDir - 5, lin + 5, nMargDir )   // Borda Superior Direita do bloco
					oPrint:Line( lin + 5, nMargEsq, lin + 100, nMargEsq ) // Linha Vertical Esquerda do bloco
					oPrint:Line( lin + 5, nMargDir, lin + 100, nMargDir ) // Linha Vertical Direita do bloco

					oPrint:Say( lin + 20, 1020, UPPER( STR0087 ), oFont13 ) //"Observacao"
					oPrint:Line( lin + 80, nMargEsq, lin + 80, nMargDir )
					Somalin( 10, nCCouDep )

					lPRIN := .F.
					lFlag := .T.
				EndIf

				Somalin( 60, nCCouDep )
				oPrint:Say( lin + 20, 130, MemoLine( cObs, 90, nLCorrente ), oFont12 )
				oPrint:Line( lin + 5, nMargEsq, lin + 75, nMargEsq ) // Linha Vertical esquerda do bloco
				oPrint:Line( lin + 5, nMargDir, lin + 75, nMargDir ) // Linha Vertical direita do bloco
			Next nLCorrente

			If lFlag // Se imprimiu a Observacao
				oPrint:Line( lin + 80, nMargEsq + 5, lin + 80, nMargDir - 5 ) // Linha Horizontal inferior do bloco
				oPrint:Line( lin + 75, nMargEsq, lin + 80, nMargEsq + 5 )   // Borda Inferior Esquerda do bloco
				oPrint:Line( lin + 75, nMargDir, lin + 80, nMargDir - 5 )   // Borda Inferior Direita do bloco
				lin += 120
			EndIf
		EndIf

		If lin >= 2660
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			oPrint:Say( 3190, ( 1220 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 150
			//Primeira linha antes do cabeçalho
			oPrint:Line( lin - 70, nMargEsq + 5, lin - 70, nMargDir - 5 )
			//Bordas arredondadas
			oPrint:Line( lin - 65, nMargEsq, lin - 70, nMargEsq + 5 )
			oPrint:Line( lin - 65, nMargDir, lin -70, nMargDir - 5 )
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			lPagIn := .F.
			U_MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )
			lin := 1200
		EndIf

		Somalin( 20, nCCouDep )
		oPrint:Line( lin - 15, nMargEsq, lin - 15, nMargDir ) // 1° linha Natureza/Nova Função
		oPrint:Line( lin - 15, nMargEsq, lin + 340, nMargEsq ) // Borda esqueda
		oPrint:Line( lin - 15, nMargDir, lin + 340, nMargDir ) // Borda direita
		oPrint:Line( lin + 340, nMargEsq, lin + 340, nMargDir ) // 2° linha

		oPrint:Say( lin + 20, 130, STR0117, oFont12 )  //"Sendo Considerado:"
		oPrint:Box( lin, 650, lin + 80, 740 )
		oPrint:Say( lin + 20, 770, STR0118, oFont13 )  //"Apto"
		oPrint:Box( lin, 1050, lin + 80, 1140 )
		oPrint:Say( lin + 20, 1170, STR0119, oFont13 ) //"Inapto"
		If nPar13 == 2  //2-Imprimir Apto c/ Restrições
			oPrint:Box( lin, 1450, lin + 80, 1540 )
			oPrint:Say( lin + 20, 1570, STR0160, oFont13 ) //"Apto Com Restrições"
		EndIf

		If nPar15 == 1
			If TMY->TMY_INDPAR == '2'
				oPrint:Line( lin, 1050, lin + 80, 1140 )
				oPrint:Line( lin + 80, 1050, lin, 1140 )
			ElseIf TMY->TMY_INDPAR == '3'
				If nPar13 == 1  //1-Nao Imprimir Apto c/ Restrições
					oPrint:Line( lin, 1050, lin + 80, 1140 )
					oPrint:Line( lin + 80, 1050, lin, 1140 )
				Else
					oPrint:Line( lin, 1450, lin + 80, 1540 )
					oPrint:Line( lin + 80, 1450, lin, 1540 )
				EndIf
			Else
				oPrint:Line( lin, 650, lin + 80, 740 )
				oPrint:Line( lin + 80, 650, lin, 740 )
			EndIf
		EndIf
		lin += 200
		oPrint:Say( lin - 110, 130, STR0049 + Space( 3 ) + NGRETSX3BOX( "TMY_NATEXA", TMY->TMY_NATEXA ), oFont11 )

		If TMY->TMY_NATEXA == "3" .And. TMY->( ColumnPos(  "TMY_NOVFUN" ) ) > 0

			cAntCC := CTT->CTT_CUSTO
			cAntFun := SRJ->RJ_FUNCAO
			cAntDepto := SQB->QB_DEPTO

			If TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0

				aTblOpen := { { "SRJ", 01 }, { "CTT", 01 }, { "SQB", 01 }, { "TN5", 01 } }
				cEmpBkp	:= ""
				cFilBkp	:= ""
				cEmpFut := TMY->TMY_EMPFUT
				cFilFut := TMY->TMY_FILFUT

				If cEmpFut <> cEmpAnt .And. !Empty( cEmpFut )
					//Bkp da empresa e filial
					cEmpBkp := cEmpAnt
					cFilBkp := cFilAnt

					NGPrepTBL( aTblOpen, cEmpFut, cFilFut )

					cFilAnt := cFilFut
				ElseIf cFilFut <> cFilAnt .And. !Empty( cFilFut )
					cFilBkp := cFilAnt
					cFilAnt := cFilFut
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0 .And. !Empty( TMY->TMY_NOVCC )
				cNovCC := NGSeek( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. !Empty( TMY->TMY_NOVFUN )
				cNovFun := NGSeek( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" )
			EndIf

			If TMY->( FieldPos( "TMY_NOVTAR" ) ) > 0
				If lAliasTYD
					dbSelectArea( "TYD" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "TYD", cFilBkp ) + TMY->TMY_NUMASO )
						While TYD->( !Eof() ) .And. TYD->TYD_FILIAL == xFilial( "TYD", cFilBkp ) .And. TMY->TMY_NUMASO == TYD->TYD_NUMASO
							aAdd( aTarefASO, SubStr( Posicione( "TN5", 1, xFilial( "TN5" ) + TYD->TYD_CODTAR, "TN5_NOMTAR" ), 1, 40 ) )
							TYD->( dbSkip() )
						End
					EndIf
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If !Empty( TMY->TMY_NOVDEP )
					cDepto := NGSeek( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" )
				EndIf
			EndIf

			If TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0

				//Retorna para empresa e filial correta
				If !Empty( cEmpFut ) .And. cEmpFut <> cEmpAnt
					NGPrepTBL( aTblOpen, cEmpAnt, cFilBkp )

					cFilAnt := cFilBkp
				ElseIf !Empty( cFilBkp ) .And. cFilBkp <> cFilAnt
					cFilAnt := cFilBkp
				EndIf

			EndIf

			If TMY->( ColumnPos( "TMY_NOVCC" ) ) > 0  .And. Empty( cNovCC )
				cNovCC := NGSeek( "CTT", TMY->TMY_NOVCC, 1, "CTT->CTT_DESC01" )
			EndIf
			If TMY->(  ColumnPos( "TMY_NOVFUN" ) ) > 0 .And. Empty( cNovFun )
				cNovFun := NGSeek( "SRJ", TMY->TMY_NOVFUN, 1, "SRJ->RJ_DESC" )
			EndIf
			If TMY->( ColumnPos( "TMY_NOVDEP" ) ) > 0
				If Empty( cDepto )
					cDepto := NGSeek( "SQB", TMY->TMY_NOVDEP, 1, "SQB->QB_DESCRIC" )
				EndIf
			EndIf

			If !Empty( cNovCC )
				oPrint:Say( lin -70, 130, STR0242 + "...........:" + Space( 3 ) + cNovCC, oFont11 ) //"Novo CC"
			EndIf

			If !Empty( cNovFun )
				oPrint:Say( lin -30, 130, STR0204 + "....:" + Space( 3 ) + cNovFun, oFont11 ) //"Nova Função"
			EndIf

			For nCont2 := 1 To Len( aTarefASO )
				Somalin( 50, nCCouDep )
				If nCont2 == 1 //Só imprimirá o titulo 1 vez
					oPrint:Say( lin, 150, IIf( lAliasTYD, STR0245, STR0243 ) + "...:" + Space( 3 ) + aTarefASO[ nCont2 ], oFont11 ) //"Novas Tarefas"
				Else
					oPrint:Say( lin, 400, aTarefASO[ nCont2 ], oFont11 )
				EndIf
			Next nCont2

			//Zera array de tarefas para que não duplique as tarefas da próxima via
			aTarefASO := {}

			If !Empty( cDepto )
				oPrint:Say( lin +10, 130, STR0244 + "........:" + Space( 3 ) + cDepto, oFont11 ) //"Novo Dep."
			EndIf

			// Retorna as tabelas ao registro de origem do funcionário para caso possua mais de uma página
			cAntCC := NGSeek( 'CTT', cAntCC, 1, 'CTT->CTT_CUSTO' )
			cAntFun := NGSeek( 'SRJ', cAntFun, 1, 'SRJ->RJ_FUNCAO' )
			cAntDepto := NGSeek( 'SQB', cAntDepto, 1, 'SQB->QB_DEPTO' )

		EndIf

		//ASSINATURAS/CARIMBOS
		Somalin( 170, nCCouDep )
		oPrint:Line( lin, nMargEsq + 5, lin, 1095 )
		oPrint:Line( lin + 535, nMargEsq + 5, lin + 535, 1095 )
		oPrint:Line( lin + 5, nMargEsq, lin + 530, nMargEsq )
		oPrint:Line( lin + 5, 1100, lin + 530, 1100 )

		oPrint:Line( lin + 5, nMargEsq, lin, nMargEsq + 5 )
		oPrint:Line( lin, 1095, lin + 5, 1100 )
		oPrint:Line( lin + 530, nMargEsq, lin + 535, nMargEsq + 5 )
		oPrint:Line( lin + 535, 1095, lin + 530, 1100 )

		nLinha := 50
		nLinhasMemo := MLCOUNT( _CIDADE + " , " + DToC( dDataBase ), 35 )
		For nLinhaCorrente := 1 To nLinhasMemo
			If !Empty( MemoLine( _CIDADE + " , " + DToC( dDataBase ), 35, nLinhaCorrente ) )
				oPrint:Say( lin + nLinha, 180, MemoLine( _CIDADE + " , " + DToC( dDataBase ), 35, nLinhaCorrente ), oFont12 ) //Cidade - Data
				nLinha += 50
			EndIf
		Next nLinhaCorrente

		oPrint:Say( lin + nLinha, 180, STR0161 + Str( nPar12, 1 ) + STR0162, oFont13 ) //"Declaro que recebi a "###"ª via do ASO"

		oPrint:Line( lin + 390, 180, lin + 390, 1020 )
		nNome   := Len( Alltrim( cNomeFunc ) ) * 28
		nEspaco := ( 830 - ( nNome ) ) / 2
		dbSelectArea( "SRA" )
		dbSetOrder( 1 )
		If dbSeek( IIf( lMDTA076 .Or. lMDTA200 .Or. ( lMDTA465 .And. !Empty( TM0->TM0_FILFUN ) ), TM0->TM0_FILFUN, xFilial( "SRA" ) ) + TM0->TM0_MAT ) .And. !Empty( SRA->RA_MAT )
			If !Empty( SRA->RA_NSOCIAL )
				cNomeSocial := Memoline(SRA->RA_NSOCIAL, 40)
				oPrint:Say( lin + 448, 230, STR0250, oFont08, , , , 2 ) //Nome Social:
				oPrint:Say( lin + 448, 700, Alltrim( cNomeSocial ), oFont08, , , , 2 )
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := Memoline(TM0->TM0_NOMSOC, 40)
				oPrint:Say( lin + 448, 230, STR0250, oFont08, , , , 2 ) //Nome Social:
				oPrint:Say( lin + 448, 700, Alltrim( cNomeSocial ), oFont08, , , , 2 )
			EndIf

			If !Empty( SRA->RA_NOMECMP )
				cNomeFunc := Memoline(SRA->RA_NOMECMP, 40)
				oPrint:Say( lin + 408, 230, STR0254, oFont08, , , , 2 ) //Empregado(a):
				oPrint:Say( lin + 408, 650, Alltrim( cNomeFunc ), oFont08, , , , 2 )

			ElseIf !Empty( SRA->RA_NOME )
				cNomeFunc := Memoline(SRA->RA_NOME, 40)
				oPrint:Say( lin + 408, 230, STR0254, oFont08, , , , 2 ) //Empregado(a):
		     	oPrint:Say( lin + 408, 650, Alltrim( cNomeFunc ), oFont08, , , , 2 )

			EndIf

		EndIf

		If lTM0
			DbSelectArea( "TM0" )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )
			cNomeFunc := TM0->TM0_NOMFIC
			oPrint:Say( lin + 448, 220, STR0256, oFont08, , , , 2 ) //Candidato:
			oPrint:Say( lin + 448, 690, Substr( cNomeFunc, 1, 28 ), oFont08, , , , 2 )

			If lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := TM0->TM0_NOMSOC
				oPrint:Say( lin + 448, 250, STR0250, oFont08, , , , 2 ) //Nome Social:
				oPrint:Say( lin + 448, 700, Alltrim( cNomeSocial ), oFont08, , , , 2 )
			EndIf

		EndIf

		oPrint:Line( lin, 1155, lin, nMargDir - 5 )
		oPrint:Line( lin + 535, 1155, lin + 535, nMargDir - 5 )
		oPrint:Line( lin + 5, 1150, lin + 530, 1150 )
		oPrint:Line( lin + 5, nMargDir, lin + 530, nMargDir )

		oPrint:Line( lin + 5, 1150, lin, 1155 )
		oPrint:Line( lin, nMargDir - 5, lin + 5, nMargDir )
		oPrint:Line( lin + 530, 1150, lin + 535, 1155 )
		oPrint:Line( lin + 535, nMargDir - 5, lin + 530, nMargDir )

		oPrint:Line( lin + 155, 1220, lin + 155, 2280 )
		oPrint:Say( lin + 165, 1240, STR0121, oFont08 ) //"Medico Coordenador: "
		oPrint:Say( lin + 165, 1600, Substr( cNOMERES, 1, 30 ), oFont08 )
		oPrint:Say( lin + 205, 1240, STR0122 + Alltrim( cENDRES ), oFont08 ) //"End: "
		oPrint:Say( lin + 205, 1900, STR0123 + Alltrim( cTELRES ), oFont08 ) //"Tel: "
		oPrint:Say( lin + 245, 1240, STR0124 + Alltrim( cCRMRES ), oFont08 ) //"CRM: "

		oPrint:Line( lin + 405, 1220, lin + 405, 2280 )
		oPrint:Say( lin + 415, 1240, STR0125, oFont08 ) //"Medico Examinador: "
		oPrint:Say( lin + 415, 1580, Substr( cNOMEMED, 1, 30 ), oFont08 )
		oPrint:Say( lin + 455, 1240, STR0122 + Alltrim( cENDMED ), oFont08 ) //"End: "
		oPrint:Say( lin + 455, 1900, STR0123 + Alltrim( cTELMED ), oFont08 ) //"Tel: "
		oPrint:Say( lin + 495, 1240, STR0124 + Alltrim( cCRMMDE ), oFont08 ) //"CRM: "

		lin += 100
		cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
		nPosPag := ( Len( cPagina ) / 2 ) - 1
		oPrint:Say( lin + 450, ( 1145 - nPosPag ), cPagina, oFont12 )
		nPagAt++

		oPrint:EndPage()
	Next xx

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalin
Incrementa Linha inicial

@type    function
@author  Inacio Luiz Kolling
@since   01/06/1997
@sample  sample
@param   nLinha, Numérico, Número da linha atual
@param   nCCouDep, Numérico, (1) - Usa Centro de custo,
(2) - Usa Deparatemento

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function Somalin( nLinha, nCCouDep )

	Default nCCouDep := 1 //Caso não tenha usa o Centro de Custo

	If lTipRel
		Li ++
		If Li > liFim
			@Li, 000 PSay Replicate( "-", 80 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			@( Li + 2 ), ( 040 - nPosPag ) PSAY cPagina
			nPagAt++
			Li := 0
			If cLOGOM == 2 //imprime logo
				U_MDTR465LOG()
			EndIf
			lPagIn := .F.
			U_MDTR465CBL( nTotVias, nViaAtual, lTmpDFis, nCCouDep )
			lQbVia := .T.
		EndIf
	ElseIf nMdRel == 2
		lin += nLinha
		If lin > ( 3100 - 180 )
			oPrint:Line( lin, 030, lin, 2350 )
			oPrint:Line( 150, 030, lin, 030 )
			oPrint:Line( 150, 2350, lin, 2350 )
			cPagina := STR0183 + cValToChar( nPagAt ) + STR0184 + cValToChar( nPagTot )
			nPosPag := ( Len( cPagina ) / 2 ) - 1
			oPrint:Say( 3100, ( 1175 - nPosPag ), cPagina, oFont12 )
			nPagAt++
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 150
			oPrint:line( lin, 030, lin, 2350 )
			If cLOGOM == 2 //imprime logo
				Somalin( 60, nCCouDep )
				U_MDTR465LOG()
				lin += 20
			EndIf
			U_MDTR465CBL( nTotVias, nViaAtual, lTmpDFis, nCCouDep)
		EndIf
	ElseIf nMdRel == 3
		lin += nLinha
	EndIf

Return

/*
         1         2         3         4         5         6         7         8
012345678901234567890123456789012345678901234567890123456789012345678901234567890

|------------------------------------------------------------------------------|
|<XXXXXXXXXXXXXXX>      ATESTADO DE SAUDE OCUPACIONAL          Num.: xxxxxxxxx |
|SIGA/MDTR465                                         Emissao: dd/mm/aaaa hh:mm|
|------------------------------------------------------------------------------|
|Funcionario.....: xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxx CPF.: xxx.xxx.xxx-xx |
|Centro de Custo.: xxxxxxxxx - xxxxxxxxxxxxxxxxxxxx      CTPS.: xxxxxxxxxxxxx  |
|Funcao..........: xxxx  -  xxxxxxxxxxxxxxxxxxxx          RG..: xxxxxxxxxxxxxxx|
|Nascimento......: xx/xx/xx     Admissao.: xx/xx/xx     Idade.: xx             |
|---------------------------------  Riscos  -----------------------------------|
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx |
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx |
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx |
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx |
|---------------------------------  Exames  -----------------------------------|
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx|
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx|
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx|
| xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx xxxxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx|
|------------------------------- Coordenador PCMSO ----------------------------|
|Medico...:  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                          |
|CRM......:  xxxxxxxxxxxx         Assinatura.:  ______________________________ |
|------------------------------- Realizacao -----------------------------------|
|Assinatura.: ______________________________  Ass.: __________________________ |
|Funcionario: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  Resp: xxxxxxxxxxxxxxxxxxxxxxxxxx |
|Data.......: xx/xx/xx                        CRM.: xxxxxxxxxxxx               |
|Parecer....: xxxxxx                      Natureza: xxxxxxxxxxxxxxxxx          |
|Procedimento xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  |
|------------------------------------------------------------------------------|
|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx|
|------------------------------------------------------------------------------|
*/

//-------------------------------------------------------------------
/*/{Protheus.doc} RiscoASO
Carrega riscos da função, da tarefa e do centro de custo

@type    function
@author  Andrey Martim Pegorini
@since   10/09/2010
@sample  U_RiscoASO()

@return  aRiscos, Array, Contém os Riscos
/*/
//-------------------------------------------------------------------
User Function RiscoASO()

	Local aArea1   := GetArea()
	Local aTempRis := {}
	Local cBkpEmp  := cEmpAnt
	Local cBkpFil  := cFilAnt
	Local dData
	Local aArea
	Local i
	Local j

	Private aRiscos    := {}
	Private aRiscosAux := {}
	Private lRisco

	lRisco := SuperGetMV( "MV_NGMDTRI", .F., "1" ) == "1"

	dbSelectArea( "TMY" )
	dData := IIf( !Empty( TMY->TMY_DTGERA ), TMY->TMY_DTGERA, TMY->TMY_DTPROG )
	dbSelectArea( "TM0" )
	dbSetOrder( 1 )
	aAreaTM0 := GetArea()
	If dbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )

		If lRisco
			aTempRis := MDTRETRIS( dData, TMY->TMY_NUMFIC, TMY->TMY_NATEXA, , '.And. TN0->TN0_LISASO $ "13"' )[1]
		Else
			aTempRis := U_MDT465RIS()
		EndIf

		For i := 1 To Len( aTempRis )
			If ( nPos := aScan( aRiscos, { |x| x[1] == aTempRis[i][2] } ) ) == 0
				aAdd( aRiscos, { aTempRis[i][2] } )
			EndIf
		Next i

		If cMvPar10 != 3
			If Len( aRiscos ) > 0
				//Abre a tabela de agentes da outra filial/empresa
				If TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0
					aTblOpen := { { "TMA", 01 } }
					//Retorna para empresa e filial correta
					If !Empty( TMY->TMY_EMPFUT ) .And. TMY->TMY_EMPFUT <> cEmpAnt
						NGPrepTBL( aTblOpen, TMY->TMY_EMPFUT, TMY->TMY_FILFUT )

						cFilAnt := TMY->TMY_FILFUT
					ElseIf !Empty( TMY->TMY_FILFUT ) .And. TMY->TMY_FILFUT <> cFilAnt
						cFilAnt := TMY->TMY_FILFUT
					EndIf
				EndIf
				dbSelectArea( "TMA" )
				dbSetOrder( 1 )
				For i := 1 To Len( aRiscos )
					If dbSeek( xFilial( "TMA" ) + aRiscos[i][1] )
						aAdd( aRiscos[i], TMA->TMA_NOMAGE )
					EndIf
				Next i
			EndIf
		Else
			If Len( aRiscos ) > 0
				aRiscosAux := aClone( aRiscos )
				aRiscos := {}

				For i:=1 To Len( aTMACombo )
					aAdd( aRiscos, { SubStr( aTMACombo[i], 1, 1 ), STR0109 + Alltrim( SubStr( aDescAgents[i], 0, 14 ) ) + ": " } )//"Agentes "
				Next i

				If TMY->( ColumnPos( "TMY_FILFUT" ) ) > 0 .And. TMY->( ColumnPos( "TMY_EMPFUT" ) ) > 0
					aTblOpen := { { "TMA", 01 } }
					//Retorna para empresa e filial correta
					If !Empty( TMY->TMY_EMPFUT ) .And. TMY->TMY_EMPFUT <> cEmpAnt
						NGPrepTBL( aTblOpen, TMY->TMY_EMPFUT, TMY->TMY_FILFUT )

						cFilAnt := TMY->TMY_FILFUT
					ElseIf !Empty( TMY->TMY_FILFUT ) .And. TMY->TMY_FILFUT <> cFilAnt
						cFilAnt := TMY->TMY_FILFUT
					EndIf
				EndIf
				dbSelectArea( "TMA" )
				dbSetOrder( 1 )
				For i := 1 To Len( aRiscos )
					For j := 1 To Len( aRiscosAux )
						If dbSeek( xFilial( "TMA" ) + aRiscosAux[j][1] )
							If AllTrim( SubStr( TMA->TMA_GRISCO, 1, 1 ) ) == aRiscos[i][1]
								If Len( aRiscos[i] ) < 3
									aAdd( aRiscos[i], AllTrim( TMA->TMA_NOMAGE ) )
								ElseIf !( Alltrim( TMA->TMA_NOMAGE ) $ aRiscos[ i ][ 3 ] ) .Or. Alltrim( TMA->TMA_NOMAGE ) != aRiscos[ i ][ 3 ]
									aRiscos[i][3] += ", " + Alltrim( TMA->TMA_NOMAGE )
								EndIf
							EndIf
						EndIf
					Next j
				Next i
			EndIf
		EndIf
	EndIf

	//Retorna a empresa/filial
	If cEmpAnt <> TMY->TMY_EMPFUT
		NGPrepTBL( aTblOpen, cEmpAnt, cBkpFil )
		cFilAnt := cBkpFil
	ElseIf cFilAnt <> cBkpFil
		cFilAnt := cBkpFil
	EndIf

	RestArea( aArea1 )
	RestArea( aAreaTM0 )

Return aRiscos

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR465CBL
Imprime cabeçalho para cada modelo

@type   function
@author Microsiga
@since  09/10/2010

@param  nVias, Numérico, Número de vias
@param  nViaAtual, Numérico, Via atual
@param  lTmpDFis, Lógico, Portador de deficiências
@param  nCCouDep, Numérico, Imprime por Departamento

@sample U_MDTR465CBL( 3, 1, .F., 1 )

@return Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR465CBL( nVias, nViaAtual, lTmpDFis, nCCouDep )

	Local cCpf := ''
	Local cTPdef
	Local nAtivid := IIf( Type( "nTipAtv" ) == "N", nTipAtv, 1 )
	Local nPorDef := fMDT465VPD()// Verifica se eh chamado de MDTR465 ou MDTA200
	Local nLinhasMemo := 0
	Local nLinhaCorrente := 0
	Local nLinha := -25
	Local cNomeFunc := ""
	Local c1DesCusto := ""
	Local lMDTA076 := IsInCallStack( "MDTA076" )
	Local cFilTNY //Verifica a filial em que foi incluso o atestado(aso).
	Local nLinEmp := IIf( cLOGOM == 1, 90, 400 )

	Default nCCouDep := 1

	If nMdRel == 1

		@Li, 000 PSAY Replicate( "-", 80 )
		SomaLin( , nCCouDep )
		@Li, 000 PSay "|"
		@Li, 001 PSay STR0053 //"Num .     :"
		@Li, 011 PSay TMY->TMY_NUMASO PICTURE "@!"
		@Li, 023 pSay STR0052 //"ATESTADO DE SAÚDE OCUPACIONAL"
		@Li, 068 pSay STR0170 + Str( nViaAtual, 1 ) + " / " + Str( nVias, 1 )
		@Li, 079 PSay "|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0017 //"|SIGA/MDTR465                                         Emissao:"
		@Li, 061 PSay dDataBase PICTURE "99/99/99"
		@Li, 072 PSay TIME()    PICTURE "99:99"
		@Li, 079 PSay "|"

		If !lSA1
			aArea := GetArea()
			aAreaSM0 := SM0->( GetArea() )

			cFilTNY := IIf( FWModeAccess( "TMY" ) == "C", cFilAnt, AllTrim( TMY->TMY_FILIAL ) )

			dbSelectArea( "SM0" )
			dbSeek( cEmpAnt + cFilTNY )
			If Type( "nTipEnd" ) == "N" .And. nTipEnd == 1 //Se Cobrança usa os endereços de cobrança )
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SM0->M0_ENDCOB
			Else //Se Fiscal usa os endereços de Fiscal
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SM0->M0_ENDENT
			EndIf
			_CGC := SM0->M0_CGC
			RestArea( aAreaSM0 )
			RestArea( aArea )
		Else
			_NOMECOM := SA1->A1_NOME
			_CGC     := SA1->A1_CGC
			_ENDCOB  := SA1->A1_END
		EndIf

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0018 //"|Empresa.: "
		@Li, 011 PSay SubStr( _NOMECOM, 1, 40 ) PICTURE "@!"
		@Li, 052 Psay STR0019 //"Geracao:"
		@Li, 061 Psay TMY->TMY_DTGERA PICTURE "99/99/99"
		@Li, 079 PSay '|'

		SomaLin( , nCCouDep )
		@Li, 000 PSay STR0020 //"|Endereco: "
		@Li, 011 PSay Substr( _ENDCOB, 1, 40 ) PICTURE "@!"
		@Li, 055 PSay STR0021 //"CNPJ.: "
		@Li, 061 PSay Substr( _CGC, 1, 18 )
		@Li, 079 PSay "|"

		SomaLin( , nCCouDep )
		@Li, 000 PSay "|"
		@Li, 001 PSAY Replicate( "-", 78 )
		@Li, 079 PSay "|"

		SomaLin( , nCCouDep )
		If lTM0
			DbSelectArea( 'TM0' )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )
			@Li, 000 PSay STR0022 //"|Candidato.......:"
			@Li, 018 PSay TM0->TM0_NUMFIC PICTURE "@!"
			@Li, 028 PSay "-" + Space(1) + Substr( AllTrim(TM0->TM0_NOMFIC), 1, 28 )
			@Li, 058 PSay STR0030 //"CPF.:"
			@Li, 063 PSay TM0->TM0_CPF PICTURE "@R XXX.XXX.XXX-XX"
			@Li, 079 PSay "|"

			If lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := TM0->TM0_NOMSOC
				SomaLin( , nCCouDep )
				@Li, 000 PSay STR0252 //"|Nome Social...........:"
				@Li, 025 PSay TM0->TM0_NUMFIC PICTURE "@!
				@Li, 035 PSay "-" + Substr( AllTrim(cNomeSocial), 1, 28)// Nome
				@Li, 079 PSay "|"
			EndIf

			SomaLin( , nCCouDep )
			If nCCouDep == 1 //Caso seja centro de custo.
				@Li, 000 PSay STR0023 //"|Centro de Custo.:"
				dbSelectArea( cAlias )
				dbSetOrder( 1 )
				dbSeek( xFilial( cAlias ) + TM0->TM0_CC )
				If !Empty( TM0->TM0_CC )
					@Li, 024 PSay Substr( Alltrim( TM0->TM0_CC ) + " - " + &cDescr, 1, 32 )
				EndIf
			ElseIf nCCouDep == 2 .And. TM0->( ColumnPos( "TM0_DEPTO" ) ) > 0 //Caso seja Departamento
				@Li, 000 PSay STR0237 //"|Departamento....:"
				dbSelectArea( "SQB" )
				dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
				dbSeek( xFilial( "SQB" ) + TM0->TM0_DEPTO )
				If !Empty( TM0->TM0_DEPTO )
					cDesCusto  := Substr( Alltrim( TM0->TM0_DEPTO ) + " - " + SQB->QB_DESCRIC, 1, 32 )
				EndIf
			EndIf

			@Li, 057 PSay STR0024 //"CTPS.:"
			@Li, 063 PSay TM0->TM0_NUMCP PICTURE "@!"
			@Li, 079 PSay "|"

			SomaLin( , nCCouDep )
			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SRJ" ) + TM0->TM0_CODFUN )
			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				@Li, 000 PSAY STR0176 //"|Cargo...........:"
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				@Li, 018 PSAY AllTrim( SRJ->RJ_CARGO ) + " - " + Substr( SQ3->Q3_DESCSUM, 1, 28 )
			Else
				@Li, 000 PSAY STR0025 //"|Atual Funcao..........:"
				If !Empty( TM0->TM0_CODFUN )
					@Li, 024 PSAY AllTrim( TM0->TM0_CODFUN ) + " - " + Substr( SRJ->RJ_DESC, 1, 28 )
				EndIf
			EndIf
			@Li, 059 PSAY 'RG.:'
			@Li, 063 PSAY Substr( TM0->TM0_RG, 1, 15 ) PICTURE "@!"
			@Li, 079 PSay "|"

			SomaLin( , nCCouDep )
			@Li, 000 PSAY STR0026 //"|Nascimento......:"
			@Li, 024 PSAY TM0->TM0_DTNASC PICTURE '99/99/99'
			If Empty( TM0->TM0_MAT ) .And. TMY->TMY_NATEXA = "1"
				@Li, 035 PSAY STR0027 //"Admissao.:"
				@Li, 044 PSAY "___/___/____"//Date() PICTURE '99/99/99'
				@Li, 057 PSAY STR0028 //"Idade.:"
				@Li, 063 PSay fCalcIdade( TM0->TM0_DTNASC ) PICTURE '99'
				@Li, 077 PSay "|"
			Else
				@Li, 056 PSAY STR0028 //"Idade.:"
				@Li, 063 PSay fCalcIdade( TM0->TM0_DTNASC ) PICTURE '99'
				@Li, 079 PSay "|"
			EndIf

			If nPorDef == 1
				SomaLin( , nCCouDep )
				If !lDefisTM0 .And. SRA->RA_TPDEFFI <> "0"
					SomaLin( , nCCouDep )
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0010 //Sim
					@Li, 079 PSay "|"
				ElseIf lTmpDFis
					SomaLin( , nCCouDep )
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0010 //Sim
					@Li, 079 PSay "|"
				Else
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0009 //Nao
					@Li, 079 PSay "|"
				EndIf
			EndIf
		Else
			@Li, 000 PSay STR0029 //"|Funcionario.....:"
			@Li, 024 PSay SRA->RA_MAT PICTURE "@!"
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			If dbSeek( IIf( lMDTA076, TM0->TM0_FILFUN, xFilial( "SRA" ) ) + TM0->TM0_MAT ) .And. !Empty( SRA->RA_MAT )

				If !Empty( SRA->RA_NOMECMP )
					cNomeFunc := SRA->RA_NOMECMP

				ElseIf !Empty( SRA->RA_NOME )
					cNomeFunc := SRA->RA_NOME

				EndIf

			EndIf
			nLinhasMemo := MLCOUNT( AllTrim( cNomeFunc ), 40 ) 	// quanto o nome atingir 40 caracter ele quebra e joga pra baixo
			For nLinhaCorrente := 1 To nLinhasMemo
				cTexte := MemoLine( cNomeFunc, 45, nLinhaCorrente )
				If nLinhaCorrente == 1
					@Li, 031 PSay "-" + Substr( cTexte, 1, 40 )// Nome
					@Li, 079 PSay "|"
				Else
					SomaLin( , nCCouDep )
					@Li, 000 PSay "|"
					@Li, 032 PSay Substr( cTexte, 1, 40 )// Nome
					@Li, 079 PSay "|"
				EndIf
			Next nLinhaCorrente

			If !Empty( SRA->RA_NSOCIAL )
					cNomeSocial := SRA->RA_NSOCIAL
					SomaLin( , nCCouDep )
					@Li, 000 PSay STR0252 //"|Nome Social...........:"
					@Li, 024 PSay SRA->RA_MAT PICTURE "@!"
					@Li, 031 PSay "-" + Substr( cNomeSocial, 1, 40 )// Nome
					@Li, 079 PSay "|"
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := TM0->TM0_NOMSOC
				SomaLin( , nCCouDep )
				@Li, 000 PSay STR0252 //"|Nome Social...........:"
				@Li, 024 PSay SRA->RA_MAT PICTURE "@!"
				@Li, 031 PSay "-" + Substr( cNomeSocial, 1, 40 )// Nome
				@Li, 079 PSay "|"
			EndIf

			SomaLin( , nCCouDep )
			If nCCouDep == 1//Caso seja Centro de Custo
				@Li, 000 PSay STR0023 //"|Centro de Custo.:"
			Else //Caso seja Departamento
				@Li, 000 PSay STR0237 //"|Departamento....:"
			EndIf
			If !Empty( cDesCusto )
				@Li, 024 PSay Substr( cDesCusto, 1, 32 )
			EndIf
			@Li, 058 PSay STR0030 //"CPF.:"
			@Li, 063 PSay SRA->RA_CIC PICTURE "@R XXX.XXX.XXX-XX"
			@Li, 079 PSay "|"

			SomaLin( , nCCouDep )

			dbSelectarea( "SRJ" )
			dbSetorder( 1 )
			dbSeek( xFilial( "SRJ" ) + SRA->RA_CODFUNC )
			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				@Li, 000 PSAY STR0176 //"|Cargo...........:"
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				@Li, 018 PSAY AllTrim( SRJ->RJ_CARGO ) + " - " + Substr( SQ3->Q3_DESCSUM, 1, 28 )
			Else
				@Li, 000 PSAY STR0025 //"|Atual Funcao..........:"
				@Li, 024 PSAY Substr( cDesFuncao, 1, 30 )
			EndIf
			@Li, 057 PSay STR0024 //"CTPS.:"
			@Li, 063 PSay SRA->RA_NUMCP PICTURE "@!"
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			@Li, 000 PSAY STR0026 //"|Nascimento......:"
			@Li, 024 PSAY SRA->RA_NASC PICTURE '99/99/99'
			@Li, 037 PSAY STR0027 //"Admissao.:"
			@Li, 048 PSAY SRA->RA_ADMISSA PICTURE '99/99/99'
			@Li, 059 PSAY 'RG.:'
			@Li, 063 PSAY Substr( SRA->RA_RG, 1, 15 ) PICTURE "@!"
			@Li, 079 PSay "|"
			SomaLin( , nCCouDep )
			@Li, 000 PSay "|"
			@Li, 001 PSAY STR0206 //"Idade.:"
			@Li, 024 PSay fCalcIdade( SRA->RA_NASC ) PICTURE '99'
			@Li, 079 PSay "|"

			If nPorDef == 1
				If !lDefisTM0 .And. SRA->RA_TPDEFFI <> "0"
					SomaLin( , nCCouDep )
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0010 //Sim
					@Li, 079 PSay "|"
				ElseIf lTmpDFis
					SomaLin( , nCCouDep )
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0010 //Sim
					@Li, 079 PSay "|"
				Else
					SomaLin( , nCCouDep )
					@Li, 000 PSAY "|" + STR0126 //"|Portador de Deficiência:"
					@Li, 025 PSAY STR0009 //Nao
					@Li, 079 PSay "|"
				EndIf
			EndIf
		EndIf

		If !lPagIn
			If !lTitulo .And. cLOGOM ==1
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 001 PSAY Replicate( "-", 78 )
				@Li, 079 PSay "|"
				SomaLin( , nCCouDep )
			Else
				SomaLin( , nCCouDep )
				@Li, 000 PSay "|"
				@Li, 079 PSay "|"
			EndIf
			lPagIn := .T.
		EndIf

	ElseIf nMdRel == 2

		oPrint:Say( lin, 2047, STR0170 + ":", oFont14 ) //"Via "
		oPrint:Say( lin, 2180, Str( nViaAtual, 1 ), oFont14 )
		oPrint:Say( lin, 2210, " / ", oFont14 )
		oPrint:Say( lin, 2250, Str( nVias, 1 ), oFont14 )

		lin+=90
		oPrint:Say( lin, 670, STR0052, oFont16 ) //"ATESTADO DE SAUDE OCUPACIONAL"
		oPrint:Say( lin, 2000, STR0164, oFont14 ) //"Num . :"
		oPrint:Say( lin, 2180, TMY->TMY_NUMASO, oFont14 )
		lin += 160
		oPrint:Say( lin,  50, STR0088, oFont12 ) //"SIGA\MDTR465"
		oPrint:Say( lin, 1647, STR0054, oFont12 ) //"Emissão . :"
		oPrint:Say( lin, 1900, DToC( dDataBase ), oFont12 )
		oPrint:Say( lin, 2170, TIME(), oFont12 )

		lin += 60

		If !lSA1
			aArea := GetArea()
			aAreaSM0 := SM0->( GetArea() )

			cFilTNY := IIf( FWModeAccess( "TMY" ) == "C", cFilAnt, AllTrim( TMY->TMY_FILIAL ) )

			dbSelectArea( "SM0" )
			dbSeek( cEmpAnt + cFilTNY )
			If Type( "nTipEnd" ) == "N" .And. nTipEnd == 1          //Se Cobrança usa os endereços de cobrança )
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SM0->M0_ENDCOB
			Else 			//Se Fiscal usa os endereços de Fiscal
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SM0->M0_ENDENT
			EndIf
			_CGC := SM0->M0_CGC
			RestArea( aAreaSM0 )
			RestArea( aArea )
		Else
			_NOMECOM := SA1->A1_NOME
			_CGC     := SA1->A1_CGC
			_ENDCOB  := SA1->A1_END
		EndIf

		oPrint:Say( lin, 50, STR0055, oFont12 ) //"Empresa. . :"
		oPrint:Say( lin, 320, SubStr( _NOMECOM, 1, 40 ), oFont12 )
		oPrint:Say( lin, 1647, STR0056, oFont12 ) //"Geração . :"
		oPrint:Say( lin, 1900, DToC( TMY->TMY_DTGERA ), oFont12 )

		lin += 60

		oPrint:Say( lin, 50, STR0057, oFont12 ) //"Endereço . :"
		oPrint:Say( lin, 320, SubStr( _ENDCOB, 1, 52 ), oFont12 )
		oPrint:Say( lin, 1647, STR0058, oFont12 ) //"CNPJ . . . . :"
		oPrint:Say( lin, 1900, _CGC, oFont12 )

		lin += 60
		oPrint:line( lin, 30, lin, 2350 )
		lin += 30

		If lTM0	
			DbSelectArea( "TM0" )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )
			oPrint:Say( lin, 50, STR0059, oFont12 ) //"Candidato. . . . . . :"
			oPrint:Say( lin, 445, TM0->TM0_NUMFIC + " - " + TM0->TM0_NOMFIC, oFont12 )
			If lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := TM0->TM0_NUMFIC + " - " + TM0->TM0_NOMSOC
				lin += 60
				oPrint:Say( lin, 50, STR0251, oFont12 ) //"Nome Social:"
				oPrint:Say( lin, 520, Substr( cNomeSocial, 1, 45 ), oFont12 )
			EndIf
			oPrint:Say( lin, 1647, STR0068, oFont12 ) //"CPF . . . . . :"
			oPrint:Say( lin, 1900, TM0->TM0_CPF, oFont12 )
			lin += 60
			If nCCouDep == 1 //Caso seja centro de custo.
				oPrint:Say( lin, 50, STR0060, oFont12 ) //"Centro de Custo. :"
				dbSelectArea( cAlias )
				dbSetOrder( 01 )
				dbSeek( xFilial( cAlias ) + TM0->TM0_CC )
				If !Empty( TM0->TM0_CC )
					oPrint:Say( lin, 445, TM0->TM0_CC + " - " + &cDescr, oFont12 )
				EndIf
			ElseIf nCCouDep == 2 .And. TM0->( ColumnPos( "TM0_DEPTO" ) ) > 0//Caso seja Departamento
				oPrint:Say( lin, 50, STR0238, oFont12 ) //"Departamento. . . . . . . :"
				dbSelectArea( "SQB" )
				dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
				dbSeek( xFilial( "SQB" ) + TM0->TM0_DEPTO )
				If !Empty( TM0->TM0_DEPTO )
					oPrint:Say( lin, 445, TM0->TM0_DEPTO + " - " + SQB->QB_DESCRIC, oFont12 )
				EndIf
			EndIf

			oPrint:Say( lin, 1645, STR0061, oFont12 ) //"CTPS . . . . :"
			oPrint:Say( lin, 1900, TM0->TM0_NUMCP, oFont12 )

			lin += 60

			dbSelectarea( "SRJ" )
			dbSetorder( 1 )
			dbSeek( xFilial( "SRJ" ) + TM0->TM0_CODFUN )
			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				oPrint:Say( lin, 50, STR0177, oFont12 ) //"Cargo . . . . . . . . :"
				oPrint:Say( lin, 520, AllTrim( SRJ->RJ_CARGO ) + " - " + Substr( SQ3->Q3_DESCSUM, 1, 28 ), oFont12 )
			Else
				oPrint:Say( lin, 50, STR0062, oFont12 ) //"Função. . . . . . . . :"
				If !Empty( TM0->TM0_CODFUN )
					oPrint:Say( lin, 520, TM0->TM0_CODFUN + " - " + SRJ->RJ_DESC, oFont12 )
				EndIf
			EndIf
			oPrint:Say( lin, 1647, STR0063, oFont12 ) //"RG . . . . . . :"
			oPrint:Say( lin, 1900, TM0->TM0_RG, oFont12 )

			lin += 60

			oPrint:Say( lin, 50, STR0064, oFont12 ) //"Nascimento . . . . :"
			oPrint:Say( lin, 520, DToC( TM0->TM0_DTNASC ), oFont12 )
			IF Empty( TM0->TM0_MAT ) .And. TMY->TMY_NATEXA = "1"
				oPrint:Say( lin, 940, STR0065, oFont12 ) //"Admissao . :"
				oPrint:Say( lin, 1200, "___/___/____", oFont12 )
			EndIf
			oPrint:Say( lin, 1647, STR0066, oFont12 ) //"Idade . . . . :"
			oPrint:Say( lin, 1900, Alltrim( STR( fCalcIdade( TM0->TM0_DTNASC ) ) ), oFont12 )

			lin += 50

			If nPorDef == 1
				If !lDefisTM0 .And. SRA->RA_TPDEFFI <> "0"
					oPrint:Say( lin, 50, STR0126 + " " + STR0010, oFont12 ) //"Portador de Deficiência: Sim"
				ElseIf lTmpDFis
					oPrint:Say( lin, 50, STR0126 + " " + STR0010, oFont12 ) //"Portador de Deficiência: Sim"
				Else
					oPrint:Say( lin, 50, STR0126 + " " + STR0009, oFont12 ) //"Portador de Deficiência: Nao"
				EndIf
			EndIf
		Else
			oPrint:Say( lin, 50, STR0067, oFont12 ) //"Funcionário . . . . :"
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			If dbSeek( IIf( lMDTA076, TM0->TM0_FILFUN, xFilial( "SRA" ) ) + TM0->TM0_MAT ) .And. !Empty( SRA->RA_MAT )

				If !Empty( SRA->RA_NOMECMP )
					cNomeFunc := SRA->RA_MAT + " - " + SRA->RA_NOMECMP
				ElseIf !Empty( SRA->RA_NOME )
					cNomeFunc := SRA->RA_MAT + " - " + SRA->RA_NOME
				EndIf

			EndIf

			nLinhasMemo := MLCOUNT( AllTrim( cNomeFunc ), 45 ) //quanto o nome atingir 40 caracter ele quebra e joga pra baixo

			For nLinhaCorrente := 1 To nLinhasMemo
				cTexte := MemoLine( cNomeFunc, 45, nLinhaCorrente )
				If nLinhaCorrente == 1
					oPrint:Say( lin, 520, Substr( cTexte, 1, 45 ), oFont12 ) // Imprime Atestado.
				Else
					lin+=60 //Pula linha
					oPrint:Say( lin, 680, Substr( cTexte, 1, 45 ), oFont12 ) // Imprime Atestado.
				EndIf
			Next nLinhaCorrente

			If !Empty( SRA->RA_NSOCIAL )
				cNomeSocial := SRA->RA_MAT + " - " + SRA->RA_NSOCIAL
				lin += 60
				oPrint:Say( lin, 50, STR0251, oFont12 ) //"Nome Social:"
				oPrint:Say( lin, 520, Substr( cNomeSocial, 1, 45 ), oFont12 )
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := SRA->RA_MAT + " - " + TM0->TM0_NOMSOC
				lin += 60
				oPrint:Say( lin, 50, STR0251, oFont12 ) //"Nome Social:"
				oPrint:Say( lin, 520, Substr( cNomeSocial, 1, 45 ), oFont12 )
			EndIf

			lin += 60 //Pula linha
			If nCCouDep == 1 //Caso seja Centro de Custo
				oPrint:Say( lin, 50, STR0060, oFont12 ) //"Centro de Custo. :"
			Else //Caso seja Departamento
				oPrint:Say( lin, 50, STR0238, oFont12 ) //"Departamento. . . . . . . :"
			EndIf
			oPrint:Say( lin, 520, cDescusto, oFont12 )
			oPrint:Say( lin, 1647, STR0068, oFont12 ) //"CPF . . . . . :"
			oPrint:Say( lin, 1900, SRA->RA_CIC, oFont12 )
			lin += 60
			dbSelectarea( "SRJ" )
			dbSetorder( 1 )
			dbSeek( xFilial( "SRJ" ) + SRA->RA_CODFUNC )
			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				oPrint:Say( lin, 50, STR0177, oFont12 ) //"Cargo . . . . . . . . :"
				oPrint:Say( lin, 520, AllTrim( SRJ->RJ_CARGO ) + " - " + Substr( SQ3->Q3_DESCSUM, 1, 28 ), oFont12 )
			Else
				oPrint:Say( lin, 50, STR0062, oFont12 ) //"Função. . . . . . . . :"
				oPrint:Say( lin, 520, cDesFuncao, oFont12 )
			EndIf
			oPrint:Say( lin, 1647, STR0061, oFont12 ) //"CTPS . . . . :"
			oPrint:Say( lin, 1900, SRA->RA_NUMCP, oFont12 )

			lin += 60

			oPrint:Say( lin, 50, STR0064, oFont12 ) //"Nascimento . . . . :"
			oPrint:Say( lin, 520, DToC( SRA->RA_NASC ), oFont12 )
			oPrint:Say( lin, 940, STR0065, oFont12 ) //"Admissao . :"
			oPrint:Say( lin, 1200, DToC( SRA->RA_ADMISSA ), oFont12 )
			oPrint:Say( lin, 1647, STR0063, oFont12 ) //"RG . . . . . . :"
			oPrint:Say( lin, 1900, SubStr( SRA->RA_RG, 1, 15 ), oFont12 )
			lin += 60
			oPrint:Say( lin, 50, STR0066, oFont12 ) //"Idade . . . . :"
			oPrint:Say( lin, 520, Alltrim( STR( fCalcIdade( SRA->RA_NASC ) ) ), oFont12 )
			lin += 50

			If nPorDef == 1
				If !lDefisTM0 .And. SRA->RA_TPDEFFI <> "0"
					oPrint:Say( lin, 50, STR0126 + " " + STR0010, oFont12 ) //"Portador de Deficiência: Sim"
				ElseIf lTmpDFis
					oPrint:Say( lin, 50, STR0126 + " " + STR0010, oFont12 ) //"Portador de Deficiência: Sim"
				Else
					oPrint:Say( lin, 50, STR0126 + " " + STR0009, oFont12 ) //"Portador de Deficiência: Nao"
				EndIf
			EndIf
		EndIf

		If !lTitulo
			lin += 60
			oPrint:Line( lin, 030, lin, 2350 )
			lin += 20
		Else
			lin += 40
		EndIf

	ElseIf nMdRel == 3

		lin += 20
		oPrint:Say( lin + 100, 1100, STR0098 + Space( 1 ) + STR0099 + Space( 1 ) + STR0100, oFont16 ) // "ASO - ATESTADO"//"DE SAÚDE"//"OCUPACIONAL"

		If !lSA1
			aArea := GetArea()
			aAreaSM0 := SM0->( GetArea() )

			cFilTNY := IIf( FWModeAccess( "TMY" ) == "C", cFilAnt, AllTrim( TMY->TMY_FILIAL ) )

			dbSelectArea( "SM0" )
			dbSeek( cEmpAnt + cFilTNY )
			If Type( "nTipEnd" ) == "N" .And. nTipEnd == 1 //Se Cobrança usa os endereços de cobrança )
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SubStr( SM0->M0_ENDCOB, 1, 40 )
				_CIDADE  := Alltrim( SM0->M0_CIDCOB )
				_ESTADO  := SM0->M0_ESTCOB
				_TEL     := SM0->M0_TEL
			Else //Se Fiscal usa os endereços de Fiscal
				_NOMECOM := SM0->M0_NOMECOM
				_ENDCOB  := SM0->M0_ENDENT
				_CIDADE  := Alltrim( SM0->M0_CIDENT )
				_ESTADO  := SM0->M0_ESTENT
				_TEL     := SM0->M0_TEL
			EndIf
			_CGC := SM0->M0_CGC
			RestArea( aAreaSM0 )
			RestArea( aArea )
		Else
			_NOMECOM := SA1->A1_NOME
			_CGC     := SA1->A1_CGC
			_ENDCOB  := SA1->A1_END
			_CIDADE  := Alltrim( SA1->A1_MUN )
			_ESTADO  := SA1->A1_EST
			_TEL     := "(" + Alltrim( SA1->A1_DDD ) + ")" + SA1->A1_TEL
		EndIf

		If fVerFor( nFormato ) != 1
			lin += 110
			nLinEmp := 90
		EndIf

		nLinhasMemo := MLCOUNT( _NOMECOM, 34 )
		For nLinhaCorrente := 1 To nLinhasMemo
			If !Empty( MemoLine( _NOMECOM, 34, nLinhaCorrente ) )
				oPrint:Say( ( lin ) + nLinha, nLinEmp, MemoLine( _NOMECOM, 34, nLinhaCorrente ), oFont10 ) //Nome Empresa
				nLinha += 50
			EndIf
		Next nLinhaCorrente

		nLinhasMemo := MLCOUNT( _ENDCOB, 34 )
		For nLinhaCorrente := 1 To nLinhasMemo
			If !Empty( MemoLine( _ENDCOB, 34, nLinhaCorrente ) )
				oPrint:Say( ( lin ) + nLinha, nLinEmp, MemoLine( _ENDCOB, 34, nLinhaCorrente ), oFont10 ) //Endereço de Cobrança
				nLinha += 50
			EndIf
		Next nLinhaCorrente

		nLinhasMemo := MLCOUNT( _CIDADE + " - " + _ESTADO, 34 )
		For nLinhaCorrente := 1 To nLinhasMemo
			If !Empty( MemoLine( _CIDADE + " - " + _ESTADO, 34, nLinhaCorrente ) )
				oPrint:Say( ( lin ) + nLinha, nLinEmp, MemoLine( _CIDADE + " - " + _ESTADO, 34, nLinhaCorrente ), oFont10 ) //Cidade e Estado  - Telefone
				nLinha += 50
			EndIf
		Next nLinhaCorrente

		oPrint:Say( ( lin ) + nLinha, nLinEmp, STR0163 + _TEL, oFont10 ) //"Tel. "

		nLinha += 50
		oPrint:Say( ( lin ) + nLinha, nLinEmp, STR0165 + Transform( _CGC, "@!R NN.NNN.NNN/NNNN-99" ), oFont10 ) //"CNPJ."

		lin += 315

		// Contagem depois do cabelho
		oPrint:Line( lin, nMargEsq, lin, nMargDir ) // Primeira linha
		oPrint:Line( lin - 400, nMargEsq, lin + 180, nMargEsq ) // Borda esquerda
		oPrint:Line( lin - 400, nMargDir, lin + 180, nMargDir ) // Borda direita
		oPrint:Line( lin + 180, nMargEsq, lin + 180, nMargDir ) // Segunda linha

		If ( nIND := aScan( aTMYcombo, { |x| Upper( Substr( x, 1, 1 ) ) == Substr( TMY->TMY_NATEXA, 1, 1 ) } ) ) > 0
			If nInd != 3
				oPrint:Say( lin + 60, 800, STR0178 + SubStr( aTMYcombo[nIND], 3 ), oFont16 ) //"Tipo de Exame: "
			Else
				oPrint:Say( lin + 60, 600, STR0178 + SubStr( aTMYcombo[nIND], 3 ), oFont16 ) //"Tipo de Exame: "
			EndIf
		EndIf
		
		oPrint:Say( lin + 040, 2050, STR0170 + ":" + Space( 2 ) + Str( nViaAtual, 1 ) + " / " + Str( nVias, 1 ), oFont12 ) //"Via "

		oPrint:Say( lin + 120, 2015, STR0164 + Alltrim( TMY->TMY_NUMASO ), oFont12 ) // "Num. : "
		oPrint:Say( lin + 040, 130,  STR0054 + Space( 2 ) + DToC( dDataBase ), oFont12 ) //"Emissão . :"
		oPrint:Say( lin + 120, 130,  STR0056 + Space( 2 ) + DToC( TMY->TMY_DTGERA ), oFont12 ) // "Geração. : "
		
		
		If lTM0

			cCCFUNC := " "
			If nCCouDep == 1 //Caso seja centro de custo.
				dbSelectArea( cAlias )
				dbSetOrder( 01 )
				dbSeek( xFilial( cAlias ) + TM0->TM0_CC )
				cCCFUNC := Alltrim( &cDescr )
			ElseIf nCCouDep == 2 .And. TM0->( ColumnPos( "TM0_DEPTO" ) ) > 0 //Caso seja Departamento
				dbSelectArea( "SQB" )
				dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
				If dbSeek( xFilial( "SQB" ) + TM0->TM0_DEPTO )
					cCCFUNC := Alltrim( SQB->QB_DESCRIC )
				EndIf
			EndIf

			If !Empty( cCCFUNC )
				cCCFUNC += " / "
			EndIf

			dbSelectArea( "SRJ" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "SRJ" ) + TM0->TM0_CODFUN )
			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				cCCFUNC += Alltrim( Substr( SQ3->Q3_DESCSUM, 1, 28 ) )
			Else
				cCCFUNC += Alltrim( SRJ->RJ_DESC )
			EndIf

			DbSelectArea( 'TM0' )
			DbSetOrder( 1 )
			DbSeek( xFilial( "TM0" ) + TMY->TMY_NUMFIC )

			cRG    	  := TM0->TM0_RG
			cCpf      := IIf( !Empty( TM0->TM0_CPF ), Transform( TM0->TM0_CPF, '@R XXX.XXX.XXX-XX' ), '' )
			cRE    	  := IIf( !Empty( TM0->TM0_MAT ), AllTrim( TM0->TM0_MAT ) + ' - ', '' )
			cTPdef    := TM0->TM0_TIPDEF
			nIdade    := Alltrim( STR( fCalcIdade( TM0->TM0_DTNASC ) ) )

			If !Empty( TM0->TM0_NOMFIC )
				cNomeFunc := ""
				nLinhasMemo := MLCOUNT( cRE + AllTrim( TM0->TM0_NOMFIC ), 45 )

				For nLinhaCorrente := 1 To nLinhasMemo

					cTexte := MemoLine( cRE + AllTrim( TM0->TM0_NOMFIC ), 45, nLinhaCorrente )
					oPrint:Say( lin + 300, 140, AllTrim( cTexte ), oFont12 )
					Somalin( 40, nCCouDep )

				Next nLinhaCorrente

				If nLinhasMemo == 1
					Somalin( 40, nCCouDep )
				EndIf

			EndIf

			If lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := ""
				nLinhasMemo := MLCOUNT( cRE + AllTrim( TM0->TM0_NOMSOC ), 45 )

				For nLinhaCorrente := 1 To nLinhasMemo

					cNome := MemoLine( cRE + AllTrim( TM0->TM0_NOMSOC ), 45, nLinhaCorrente )
					oPrint:Say( lin + 260, 120, STR0250, oFont10 ) //"Nome Social:"
					oPrint:Say( lin + 290, 140, AllTrim( cNome ), oFont12 )
					Somalin( 40, nCCouDep )

				Next nLinhaCorrente

				If nLinhasMemo == 1
					Somalin( 40, nCCouDep )
				EndIf

			EndIf

		Else
			dbSelectArea( "SRA" )
			dbSetOrder( 1 )
			dbSeek( TM0->TM0_FILFUN + TM0->TM0_MAT )

			dbSelectArea( cAlias )
			dbSetOrder( 01 )
			dbSeek( xFilial( cAlias ) + SRA->RA_CC )

			cFunSav := SRA->RA_CODFUNC
			If nCCouDep == 1 //Caso seja centro de custo.
				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SRJ" ) + cFunSav )
				c1DesCusto := Alltrim( &cDescr )
			ElseIf nCCouDep == 2 //Caso seja Departamento
				dbSelectArea( "SQB" )
				dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
				If dbSeek( xFilial( "SQB" ) + SRA->RA_DEPTO )
					c1DesCusto := Alltrim( SQB->QB_DESCRIC )
				EndIf
			EndIf

			If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
				dbSelectArea( "SQ3" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
				c1DesFuncao := Alltrim( Substr( SQ3->Q3_DESCSUM, 1, 28 ) )
			Else
				c1DesFuncao := Alltrim( SRJ->RJ_DESC )
			EndIf

			If TMY->TMY_NATEXA == "3"
				cFilMat := cFilAnt
				If TMY->( ColumnPos( "TMY_FILFUN" ) ) > 0
					If !Empty( TMY->TMY_FILFUN )
						cFilMat := TMY->TMY_FILFUN
					EndIf
				EndIf

				If nCCouDep == 1 //Caso seja centro de custo.
					If TMY->( ColumnPos( "TMY_CC" ) ) > 0
						dbSelectArea( cAlias )
						dbSetOrder( 1 )
						If dbSeek( xFilial( cAlias, cFilMat ) + TMY->TMY_CC )
							c1DesCusto  := Alltrim( &cDescr )
						EndIf
					EndIf
				ElseIf nCCouDep == 2 .And. TMY->(ColumnPos( "TMY_NOVDEP" )) > 0//Caso seja Departamento
					dbSelectArea( "SQB" )
					dbSetOrder( 1 ) //QB_FILIAL+QB_DEPTO
					If dbSeek( xFilial( "SQB", cFilMat ) + TMY->TMY_NOVDEP )
						c1DesCusto := Alltrim( SQB->QB_DESCRIC )
					EndIf
				EndIf

				If TMY->( ColumnPos( "TMY_CODFUN" ) ) > 0
					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "SRJ", cFilMat ) + TMY->TMY_CODFUN )
						If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
							dbSelectArea( "SQ3" )
							dbSetOrder( 1 )
							dbSeek( xFilial( "SQ3" ) + SRJ->RJ_CARGO )
							c1DesFuncao := Alltrim( Substr( SQ3->Q3_DESCSUM, 1, 28 ) )
						Else
							c1DesFuncao := Alltrim( SRJ->RJ_DESC )
						EndIf
					EndIf
				EndIf
			EndIf
			cCCFUNC :=  c1DesCusto + " / " + c1DesFuncao

			cRG := SRA->RA_RG
			cRE := IIf( !Empty( SRA->RA_MAT ), AllTrim( SRA->RA_MAT ) + ' - ', '' )
			cCpf := IIf( !Empty( SRA->RA_CIC ), Transform( SRA->RA_CIC, '@R XXX.XXX.XXX-XX' ), '' )
			cTPdef := SRA->RA_TPDEFFI
			nIdade := Alltrim( STR( fCalcIdade( SRA->RA_NASC ) ) )

			If !Empty( SRA->RA_NSOCIAL )
				cNomeSocial := ""
				nLinhasMemo := MLCOUNT( cRE + AllTrim( SRA->RA_NSOCIAL ), 80 )
				oPrint:Say( lin + 390, 120, STR0250, oFont10 ) //"Nome Social:"

				For nLinhaCorrente := 1 To nLinhasMemo

					cNome := MemoLine( cRE + AllTrim( SRA->RA_NSOCIAL ), 80, nLinhaCorrente )
					oPrint:Say( lin + 390, 350, AllTrim( cNome ), oFont12 )
					Somalin( 40, nCCouDep )

				Next nLinhaCorrente

				If nLinhasMemo == 1
					Somalin( 40, nCCouDep )
				EndIf
			ElseIf lNomSocTM0 .And. !Empty( TM0->TM0_NOMSOC )
				cNomeSocial := ""
				nLinhasMemo := MLCOUNT( cRE + AllTrim( TM0->TM0_NOMSOC ), 50 )
				oPrint:Say( lin + 390, 120, STR0250, oFont10 ) //"Nome Social:"

				For nLinhaCorrente := 1 To nLinhasMemo

					cNome := MemoLine( cRE + AllTrim( TM0->TM0_NOMSOC ), 50, nLinhaCorrente )
					oPrint:Say( lin + 390, 350, AllTrim( cNome ), oFont12 )
					Somalin( 40, nCCouDep )

				Next nLinhaCorrente

				If nLinhasMemo == 1
					Somalin( 40, nCCouDep )
				EndIf
			EndIf	

			If  !Empty( SRA->RA_NOMECMP )
				cNomeFunc := ""
				nLinhasMemo := MLCOUNT( cRE + AllTrim( SRA->RA_NOMECMP ), 45 )

				For nLinhaCorrente := 1 To nLinhasMemo

					cTexte := MemoLine( cRE + AllTrim( SRA->RA_NOMECMP ), 45, nLinhaCorrente )
					oPrint:Say( lin + 225, 140, AllTrim( cTexte ), oFont12 )
					Somalin( 40, nCCouDep )

				Next nLinhaCorrente

				If nLinhasMemo == 1
					Somalin( 40, nCCouDep )
				EndIf

			Else
				cNomeFunc := SRA->RA_NOME
				Somalin( 40, nCCouDep )
				Somalin( 40, nCCouDep )
			EndIf

		EndIf

		lin += 100
		oPrint:Line( lin, nMargEsq, lin, nMargDir )
		oPrint:Line( lin, nMargEsq, lin + 390, nMargEsq ) // Borda esqueda
		oPrint:Line( lin, nMargDir, lin + 390, nMargDir ) // Borda direita

		oPrint:Say( lin + 10, 120, STR0101, oFont10 ) //"ATESTO QUE O EMPREGADO SR.( A ):"

		If !Empty( cNomeFunc )
			oPrint:Say( lin + 50, 140, cRE + cNomeFunc, oFont12 )
		EndIf

		If nPorDef == 1
			Somalin( 20, nCCouDep )
			oPrint:Say( lin + 150, 120, STR0126, oFont10 ) //"Portador de Deficiência:"

			If !lDefisTM0 .And. SRA->RA_TPDEFFI <> "0"
				oPrint:Say( lin + 150, 550, STR0010, oFont10x )
			ElseIf lTmpDFis
				oPrint:Say( lin + 150, 550, STR0010, oFont10x )
			Else
				oPrint:Say( lin + 150, 550, STR0009, oFont10x )  //Nao
			EndIf
		EndIf

		oPrint:Say( lin + 10, 1370, STR0102, oFont10 ) //"RG"
		oPrint:Say( lin + 10, 1440, cRG, oFont12 )
		oPrint:Say( lin + 10, 1870, STR0103, oFont10 ) //"IDADE"
		oPrint:Say( lin + 10, 2010, nIdade, oFont12 )

		oPrint:Say( lin + 80, 1370, STR0248 + ':', oFont10 ) // "CPF"
		oPrint:Say( lin + 80, 1450, cCpf, oFont12 ) // "CPF"
		oPrint:Say( lin + 80, 1870, "NIT:", oFont10 ) //"NIT"
		If !Empty( SRA->RA_PIS )
			oPrint:Say( lin + 80, 1940, Transform( SRA->RA_PIS, "@R 999.99999.99-9" ), oFont12 )
		EndIf

		lin += 200
		oPrint:Line( lin, nMargEsq, lin, nMargDir ) // 3° linha

		If nAtivid == 2 .And. !Empty( SRJ->RJ_CARGO )
			If nCCouDep == 1 //Caso seja centro de custo.
				oPrint:Say( lin + 10, 120, STR0179, oFont10 ) //"CENTRO DE CUSTO / CARGO"
			Else //Caso seja Departamento
				oPrint:Say( lin + 10, 120, STR0239, oFont10 ) //"DEPARTAMENTO / CARGO"
			EndIf
		Else
			If nCCouDep == 1 //Caso seja centro de custo.
				oPrint:Say( lin + 10, 120, STR0104, oFont10 ) //"CENTRO DE CUSTO / FUNÇÃO"
			Else //Caso seja Departamento
				oPrint:Say( lin + 10, 120, STR0240, oFont10 ) //"DEPARTAMENTO / FUNÇÃO"
			EndIf
		EndIf
		oPrint:Say( lin + 50, 140, cCCFUNC, oFont12 )

		oPrint:Say( lin + 120, 120, STR0106 + DToC( TMY->TMY_DTGERA ) + STR0107, oFont11 ) //"FOI CLINICAMENTE EXAMINADO( A),  DIA "##",   ESTANDO EXPOSTOS AOS:"

		lin += 100
		oPrint:Line( lin, nMargEsq, lin, nMargDir )
		oPrint:Line( lin + 70, nMargEsq, lin + 70, nMargDir ) // 5° linha

	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR465LOG
Imprime cabeçalho com logomarca

@author ???
@since 09/20/2010

/*/
//-------------------------------------------------------------------
User Function MDTR465LOG()

	Local oBmp

	Default nFormato := 1

	//Verifica o tamanho da imagem
	oBmp := TBitmap():New( 0, 0, 0, 0, , , .F., GetWndDefault(), , , , .F., , , , , .T. )
	oBmp:Hide()

	If oBmp:Load( , NGLocLogo() )
		oBmp:nClrPane := CLR_WHITE
		oBmp:lAutoSize    := .T.
		oBmp:lTransparent := .T.
		oBmp:Refresh()
	EndIf

	oBmp:Free()

	If nMdRel == 1
		Cabec( titulo, cabec1, cabec2, nomeprog, tamanho, nTipo )
	ElseIf nMdRel == 2
		If fVerFor( nFormato ) != 1
			oPrint:sayBitMap( lin, 090, NGLocLogo(), 500, 100 )
		Else
			oPrint:sayBitMap( lin, 090, NGLocLogo(), 280, 280 )
		EndIf
	ElseIf nMdRel == 3
		If fVerFor( nFormato ) != 1
			oPrint:sayBitMap( 150, 090, NGLocLogo(), 500, 100 )
		Else
			oPrint:sayBitMap( 150, 090, NGLocLogo(), 300, 300 )
		EndIf
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fVerFor
Verifica e valida se a pergunta do formato existe no dicionário e
retorna a opção escolhida

@author Gabriel Sokacheski
@since 27/02/2023

@param, nFormato, pergunta do dicionário

@return, nOpcao, opção escolhida
/*/
//-------------------------------------------------------------------
Static Function fVerFor( nFormato )

	Local nOpcao := 1

	If ValType( nFormato ) == 'N' .And. nFormato != 1
		nOpcao := 2
	EndIf

Return nOpcao

//-------------------------------------------------------------------
/*/{Protheus.doc} f465RESTRI
Retorna texto com todas restrições do funcionário

@type    function
@author  Roger Rodrigues
@since   05/11/2010
@sample  f465RESTRI( '000001', '0101/2010', 2 )

@param   cNumFic, Caractere, Número da ficha médica do funcionário
@param   dDataProg, Data, Data da programação do exame
@param   nPar17, Numérico, Conteúdo da pergunta 'Imprimir Restricoes ?'

@return  cRestri, Caractere, Contém as retrições do funcionário
/*/
//-------------------------------------------------------------------
Static Function f465RESTRI( cNumFic, dDataProg, nPar17 )

	Local aArea := GetArea()
	Local cRestri := ""

	dbSelectArea( "TMF" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TMF" ) + cNumFic )
	While !Eof() .And. xFilial( "TMF" ) + cNumFic == TMF->( TMF_FILIAL + TMF_NUMFIC )
		//Verifica se esta nas datas
		If TMF->TMF_DTINIC > dDataProg .Or. ( !Empty( TMF->TMF_DTFIM ) .And. TMF->TMF_DTFIM < dDataProg )
			dbSelectArea( "TMF" )
			dbSkip()
			Loop
		EndIf
		dbSelectArea( "TME" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TME" ) + TMF->TMF_RESTRI )
			If nPar17 == 2
				cRestri += Capital( AllTrim( TME->TME_NOMRES ) ) + "; "
			Else
				cRestri += Capital( AllTrim( TME->TME_NOMRES ) ) + Chr( 13 ) + Chr( 10 )
			EndIf
		EndIf
		dbSelectArea( "TMF" )
		dbSkip()
	End

	RestArea( aArea )

Return AllTrim( cRestri )

//-------------------------------------------------------------------
/*/{Protheus.doc} NGNRPAGASO
Controle de Pagina

@type    function
@author  Microsiga
@since   09/20/2010
@sample  U_NGNRPAGASO( 1 )

@param   nImpNR7, Numérico, Se imprime logomarca
@return  nPag, Numérico, Número total de páginas do relatório
/*/
//-------------------------------------------------------------------
User Function NGNRPAGASO( nImpNR7 )

	Local nPagTot   := 1
	Local nPag      := 1
	Local nLinAt    := 27
	Local cNomeFunc :=""
	Local nControl
	Local nLine
	Local nLCorrente
	Local i
	Local nCont
	Local yy
	Local aRet
	Local aArea

	aArea := GetArea()

	If nMdRel == 1

		nControl := 18

		aRiscos := U_RiscoASO()

		If !Empty( Len( aRiscos ) )
			nLinRis := IIf( Len( aRiscos ) % 2 == 0, ( Len( aRiscos ) / 2 ), ( Int( Len( aRiscos ) / 2 ) ) + 1 )
			For nCont := 1 To nLinRis
				If nControl > ( liFim - 3 )
					nPag++
					nControl := 18
				EndIf
				nControl++
			Next nCont
		Else
			nControl += MLCOUNT( STR0111, 75 )
		EndIf

		nLine := nControl

		aEXAMES := {}
		If ExistBlock( "MDTR4654" )
			aRet := ExecBlock( "MDTR4654", .F., .F., { nLine, nPag, nControl } )
			If Type( "aRet" ) == "A" .And. Len( aRet ) >= 3
				nLine    := aRet[ 1 ]
				nPag     := aRet[ 2 ]
				nControl := aRet[ 3 ]
			EndIf
		Else
			dbSelectArea( "TM5" )
			dbSetOrder( 04 )
			dbSeek( xFilial( 'TM5' ) + TMY->TMY_NUMASO )

			While !Eof() .And. TM5->TM5_FILIAL == xFilial( "TM5" ) .And. TMY->TMY_NUMASO == TM5->TM5_NUMASO
				cChavtm5 := TM5->TM5_NUMFIC + DToS( TM5->TM5_DTRESU ) + TM5->TM5_EXAME

				If !Empty( TM5->TM5_DTRESU ) .And. IIf( nImpNR7 == 1, .T., Alltrim( TM5->TM5_EXAME ) != "NR7" ) .And.;
						aScan( aExames, { |x| x[1] + DToS( x[4] ) + x[3] == cChavtm5 } ) == 0
					aAdd( aEXAMES, { TM5->TM5_NUMFIC, TM5->TM5_DTPROG, TM5->TM5_EXAME, TM5->TM5_DTRESU, TM5->TM5_HRPROG } )
				EndIf

				dbSelectArea( "TM5" )
				dbskip()
			End

			If cRelExam == "2"

				dbSelectArea( "TKB" )
				dbSetOrder( 01 )
				dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO )

				While !Eof() .And. TKB->TKB_FILIAL == xFIlial( "TKB" ) .And. TMY->TMY_NUMASO == TKB->TKB_NUMASO
					cChavtm5 := TKB->TKB_EXAME

					If IIf( nImpNR7 == 1, .T., Alltrim( TKB->TKB_EXAME ) != "NR7" ) .And. aScan( aExames, { |x| x[3] == cChavtm5 } ) == 0
						aAdd( aEXAMES, { , , TKB->TKB_EXAME, , } )
					EndIf

					dbSelectArea( "TKB" )
					dbskip()
				End

			EndIf

			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				If Len( aTmpExa ) > 0
					nControl := nLine + 1
				EndIf
				For yy := 1 To Len( aTmpExa )
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 60 )
					For nLCorrente := 1 To nLMemo
						If nControl > ( liFim - 3 )
							nPag++
							nControl := 18
						EndIf
						nControl++
					Next LCorrente
				Next yy
			Else
				If Len( aEXAMES ) > 0
					nControl := nLine + 1
					For nCont := 1 To Len( aEXAMES )
						If nControl > ( liFim - 3 )
							nPag++
							nControl := 18
						EndIf
						nControl++
					Next nCont
				EndIf
			EndIf
		EndIf

		// Verifica tamanho de Coordenador PCMSO
		nLine := nControl
		nControl := 3

		If ( nLine + nControl ) > ( liFim - 3 )
			nPag++
			nLine := 18 + ( nControl - ( 52 - nLine ) )
		Else
			nLine += nControl
		EndIf

		// Verifica tamanho de Realizacao
		nControl := 11

		If ( nLine + nControl ) > ( liFim - 3 )
			nPag++
			nLine := 18 + ( nControl - 1 )
		Else
			nLine += nControl
		EndIf

		// PROCEDIMENTO
		LinhasAso := MLCOUNT( TMY->TMY_DESCRI, 63 )
		For nCont := 1 To LinhasAso
			If !Empty( ( MemoLine( TMY->TMY_DESCRI, 63, nCont ) ) )
				If nLine > ( liFim - 3 )
					nPag++
					nLine := 18
				EndIf
				nLine++
			Else
				Exit
			EndIf
		Next nCont

		// RESTRICOES
		If !Empty( cObsRestri )

			lImpRest := .T.

			LinhasRes := MLCOUNT( cObsRestri, 70 )

			For nCont := 1 To LinhasRes
				If nLine > ( liFim - 3 )
					nPag++
					nLine := 18
				EndIf
				nLine++
			Next nCont

		EndIf

		// OBSERVACAO
		If !Empty( cTERMO ) .Or. !Empty( cObsAd )

			lImpObs := .T.

			dbSelectArea( "TMZ" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMZ" ) + cTERMO )

			cObs := AllTrim( TMZ->TMZ_DESCRI )

			If !Empty( cObs ) .And. !Empty( cObsAd )
				cObs += Chr( 13 ) + Chr( 10 ) + Chr( 13 ) + Chr( 10 ) + cObsAd
			ElseIf !Empty( cObsAd )
				cObs := cObsAd
			EndIf

			LinhasMemoObs := MLCOUNT( cObs, 110 )

			For nCont := 1 To LinhasMemoObs
				If nLine + 1 > liFim
					nPag++
					nLine := 18
				EndIf
				nLine++
			Next nCont

		EndIf

	ElseIf nMdRel == 2

		nControl := 1000

		aRiscos := U_RiscoASO()

		If !Empty( Len( aRiscos ) )
			nLinRis := ( IIf( Len( aRiscos ) % 2 == 0, ( Len( aRiscos ) / 2 ), ( Int( Len( aRiscos ) / 2 ) + 1 ) ) )
			For nCont := 1 To nLinRis
				If nControl > 2820
					nPag++
					nControl := 1000
				EndIf
				nControl += 65
			Next nCont
		Else
			nControl += 120
		EndIf

		nLine := nControl


		/*EXAMES*/
		If ExistBlock( "MDTR4654" )
			aRet := ExecBlock( "MDTR4654", .F., .F., { nLine, nPag, nControl } )
			If Type( "aRet" ) == "A" .And. Len( aRet ) >= 3
				nLine := aRet[ 1 ]
				nPag := aRet[ 2 ]
				nControl := aRet[ 3 ]
			EndIf
		Else
			dbSelectArea( "TM5" )
			dbSetOrder( 04 )
			dbSeek( xFilial( 'TM5' ) + TMY->TMY_NUMASO )

			While lContinua .And. !Eof() .And. TM5->TM5_FILIAL == xFilial( 'TM5' ) .And. TMY->TMY_NUMASO == TM5->TM5_NUMASO
				cChavtm5 := TM5->TM5_NUMFIC + DToS( TM5->TM5_DTRESU ) + TM5->TM5_EXAME

				If !Empty( TM5->TM5_DTRESU ) .And. IIf( nImpNR7 == 1, .T., Alltrim( TM5->TM5_EXAME ) != "NR7" ) .And.;
						aScan( aExames, { |x| x[1] + DToS( x[4] ) + x[3] == cChavtm5 } ) == 0
					aAdd( aEXAMES, { TM5->TM5_NUMFIC, TM5->TM5_DTPROG, TM5->TM5_EXAME, TM5->TM5_DTRESU, TM5->TM5_HRPROG } )
				EndIf

				dbSelectArea( "TM5" )
				dbskip()
			End

			If cRelExam == "2"

				dbSelectArea( "TKB" )
				dbSetOrder( 01 )
				dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO )

				While lContinua .And. !Eof() .And. TKB->TKB_FILIAL == xFIlial( 'TKB' ) .And. TMY->TMY_NUMASO == TKB->TKB_NUMASO
					cChavtm5 := TKB->TKB_EXAME

					If IIf( nImpNR7 == 1, .T., Alltrim( TKB->TKB_EXAME ) != "NR7" ) .And.;
							aScan( aExames, { |x| x[3] == cChavtm5 } ) == 0
						aAdd( aEXAMES, { , , TKB->TKB_EXAME, , } )
					EndIf

					dbSelectArea( "TKB" )
					dbskip()
				End

			EndIf

			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				For yy := 1 To Len( aTmpExa )
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 70 )
					For nLCorrente := 1 To nLMemo
						If nControl > 2820
							nPag++
							nControl := 1000
						EndIf
						nControl += 60
					Next LCorrente
				Next yy
			Else
				If Len( aEXAMES ) > 0
					For nCont := 1 To Len( aEXAMES )
						If nControl > 2820
							nPag++
							nControl := 1000
						EndIf
						nControl += 60
					Next nCont
				EndIf
			EndIf
		EndIf

		// Verifica tamanho de Coordenador PCMSO
		nLine := nControl
		nControl := 180

		If ( nLine + nControl ) > 2820
			nPag++
			nLine := 1000 + ( nControl - ( 2820 - nLine ) )
		Else
			nLine += nControl
		EndIf

		// Verifica tamanho de Realizacao
		If ( nLine + nControl ) > 2820
			nPag++
			nLine := 1000 + ( nControl - ( 2820 - nLine ) )
		Else
			nLine += nControl
		EndIf

		// PROCEDIMENTO
		LinhasAso := MLCOUNT( TMY->TMY_DESCRI, 63 )
		For nCont := 1 To LinhasAso
			If !Empty( ( MemoLine( TMY->TMY_DESCRI, 63, nCont ) ) )
				If nLine > 2820
					nPag++
					nLine := 1000
				EndIf
				nLine += 60
			Else
				Exit
			EndIf
		Next nCont

		// RESTRICOES
		If !Empty( cObsRestri )

			lImpRest := .T.

			LinhasRes := MLCOUNT( cObsRestri, 90 )
			nLine += 60
			If nLine > 2820
				nPag++
				nLine := 1000
			EndIf
			For nCont := 1 To LinhasRes
				If nLine > 2820
					nPag++
					nLine := 1000
				EndIf
				nLine += 60
			Next nCont

		EndIf

		// OBSERVACAO
		If !Empty( cTERMO ) .Or. !Empty( cObsAd )

			lImpObs := .T. //Imprime Observacao

			dbSelectArea( "TMZ" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMZ" ) + cTERMO )

			cObs := AllTrim( TMZ->TMZ_DESCRI )

			If !Empty( cObs ) .And. !Empty( cObsAd )
				cObs += Chr( 13 ) + Chr( 10 ) + Chr( 13 ) + Chr( 10 ) + cObsAd
			ElseIf !Empty( cObsAd )
				cObs := cObsAd
			EndIf

			LinhasMemoObs := MLCOUNT( cObs, 110 )
			nLine += 60
			If nLine > 3100
				nPag++
				nLine := 1000
			EndIf
			For nCont := 1 To LinhasMemoObs
				If nLine > 2150
					nPag++
					nLine := 1000
				EndIf
				nLine += 60
			Next nCont

		EndIf

	ElseIf nMdRel == 3

		nControl := 1300

		aRiscos := U_RiscoASO()

		If Len( aRiscos ) > 0
			lPRIN := .T.
			For i:=1 To Len( aRiscos )
				If Len( aRiscos[i] ) > 2
					nLMemo := MLCOUNT( aRiscos[i][3], 70 )
					For nLCorrente := 1 To nLMemo
						If !Empty( ( MemoLine( aRiscos[i][3], 70, nLCorrente ) ) )
							nControl += 70
						EndIf
					Next nLCorrente
					If i != Len( aRiscos ) .And. Len( aRiscos[i + 1] ) > 2
						nControl += 15
					EndIf
				EndIf
			Next i
		ElseIf !lPRIN
			nControl += 50
		EndIf

		nControl += 140
		nLine := nControl

		If ExistBlock( "MDTR4654" )
			aRet := ExecBlock( "MDTR4654", .F., .F., { nLine, nPag, nControl } )
			If Type( "aRet" ) == "A" .And. Len( aRet ) >= 3
				nLine    := aRet[ 1 ]
				nPag     := aRet[ 2 ]
				nControl := aRet[ 3 ]
			EndIf
		Else

			dbSelectArea( "TM5" )
			dbSetOrder( 04 )
			dbSeek( xFilial( 'TM5' ) + TMY->TMY_NUMASO )

			While lContinua .And. !Eof() .And. TM5->TM5_FILIAL == xFilial( 'TM5' ) .And. TMY->TMY_NUMASO == TM5->TM5_NUMASO
				cChavtm5 := TM5->TM5_NUMFIC + DToS( TM5->TM5_DTRESU ) + TM5->TM5_EXAME

				If !Empty( TM5->TM5_DTRESU ) .And. IIf( nImpNR7 == 1, .T., Alltrim( TM5->TM5_EXAME ) != "NR7"  ) .And.;
						aScan( aExames, { |x| x[1] + DToS( x[4] ) + x[3] == cChavtm5 } ) == 0
					aAdd( aEXAMES, { TM5->TM5_NUMFIC, TM5->TM5_DTPROG, TM5->TM5_EXAME, TM5->TM5_DTRESU, TM5->TM5_HRPROG } )
					lPRIN := .T.
				EndIf

				dbSelectArea( "TM5" )
				dbskip()
			End

			If cRelExam == "2"

				dbSelectArea( "TKB" )
				dbSetOrder( 01 )
				dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO )

				While lContinua .And. !Eof() .And. TKB->TKB_FILIAL == xFilial( 'TKB' ) .And. TMY->TMY_NUMASO == TKB->TKB_NUMASO
					cChavtm5 := TKB->TKB_EXAME

					If IIf( nImpNR7 == 1, .T., Alltrim( TKB->TKB_EXAME ) != "NR7" ) .And. aScan( aExames, { |x| x[3] == cChavtm5 } ) == 0
						aAdd( aEXAMES, { , , TKB->TKB_EXAME, , } )
						lPRIN := .T.
					EndIf

					dbSelectArea( "TKB" )
					dbskip()
				End
			EndIf

			lPRIN  := .F.
			lPRIN2 := .F.

			If cGrpExam == "2" //Agrupa os exames por Data
				aTmpExa := fExaAgrupado()
				If Len( aTmpExa ) > 0
					nControl := nLine
					lPRIN2 := .T.
				Else
					nControl += 70
				EndIf
				For yy := 1 To Len( aTmpExa )
					nLMemo := MLCOUNT( aTmpExa[yy, 3], 70 )
					For nLCorrente := 1 To nLMemo
						If nControl + 70 > 3160
							nPag++
							nControl := 1050
						EndIf
						nControl += 70
					Next LCorrente
				Next yy
			Else
				If Len( aEXAMES ) > 0
					lPRIN2 := .T.
					nControl := nLine + 1
					For nCont := 1 To Len( aEXAMES )
						If nControl + 70 > 3160
							nPag++
							nControl := 1050
						EndIf
						nControl += 70
					Next nCont
				EndIf
			EndIf
		EndIf
		If !lPRIN2 .And. !lPRIN
			cDescri := Alltrim( TMY->TMY_DESCRI )
			If !Empty( cDescri )
				nControl += 80
				nLMemo := MLCOUNT( cDescri, 90 )
				For nLCorrente := 1 To nLMemo
					If !Empty( ( MemoLine( cDescri, 90, nLCorrente ) ) )
						nControl += 50
					EndIf
				Next LCorrente
				nControl -= 40
			EndIf
		Else
			cDescri := Alltrim( TMY->TMY_DESCRI )
			If !Empty( cDescri )
				nLMemo := MLCOUNT( cDescri, 90 )
				For nLCorrente := 1 To nLMemo
					If !Empty( ( MemoLine( cDescri, 90, nLCorrente ) ) )
						nControl += 50
					EndIf
				Next LCorrente
				nControl -= 40
			EndIf
		EndIf

		nLine := nControl
		If nControl + 270 > 3160
			nPag++
			nControl := 1050
		EndIf
		nControl += 270

		// OBSERVACAO
		If !Empty( cTERMO ) .Or. !Empty( cObsAd )

			lImpObs := .T.

			dbSelectArea( "TMZ" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMZ" ) + cTERMO )

			cObs := AllTrim( TMZ->TMZ_DESCRI )

			If !Empty( cObs ) .And. !Empty( cObsAd )
				cObs += Chr( 13 ) + Chr( 10 ) + Chr( 13 ) + Chr( 10 ) + cObsAd
			ElseIf !Empty( cObsAd )
				cObs := cObsAd
			EndIf

			LinhasMemoObs := MLCOUNT( cObs, 105 )

			For nCont := 1 To LinhasMemoObs
				If nControl > 3160
					nPag++
					nControl := 1050
				EndIf
				nControl += 60
			Next nCont
		EndIf

		nControl += 150
		If (nControl + 530) > 3000
			nPag++
		EndIf

	EndIf

	RestArea( aArea )

Return nPag

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT465RIS
Retorna um array com os riscos ligados ao atestado

@type    function
@author  Jackson Machado
@since   26/04/2011
@sample  U_MDT465RIS()

@return  aRet, Array, Riscos do atestado
/*/
//-------------------------------------------------------------------
User Function MDT465RIS()

	Private aRet := {}

	dbSelectArea( "TMX" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TMX" ) + TMY->TMY_NUMASO )

	While !Eof() .And. xFilial( "TMX" ) == TMX->TMX_FILIAL .And. TMX->TMX_NUMASO == TMY->TMY_NUMASO
		dbSelectArea( "TN0" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TN0" ) + TMX->TMX_NUMRIS )

			If ( !Empty( TN0->TN0_DTELIM ) .And. TN0->TN0_DTELIM <  dDataBase )
				dbSelectArea( "TMX" )
				dbSkip()
				Loop
			EndIf

			aAdd( aRet, { TN0->TN0_NUMRIS, TN0->TN0_AGENTE } )
		EndIf
		dbSelectArea( "TMX" )
		dbSkip()
	EndDo

Return aRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fExaAgrupado
Agrupa os exames por data

@type    function
@author  Denis
@since   05/11/2010
@sample  fExaAgrupado()

@return  aTM5, Array, Contém os exames do array aEXAMES, ordenados
por data
/*/
//-------------------------------------------------------------------
Static Function fExaAgrupado()

	Local aTM5    := {}
	Local cExame
	Local dDateResultado
	Local yy
	Local nPos
	Local xx

	For yy := 1 To Len( aEXAMES )
		cExame := ""
		dDateResultado := StoD( "" )
		If !Empty( aEXAMES[yy][2] )
			dbSelectArea( "TM5" )
			dbSetOrder( 08 )
			dbSeek( xFilial( 'TM5' ) + aEXAMES[yy][1] + DToS( aEXAMES[yy][2] ) + aEXAMES[yy][5] + aEXAMES[yy][3] )
			cExame := TM5->TM5_EXAME
			dDateResultado := TM5->TM5_DTRESU
		EndIf
		If cRelExam == "2"
			If Empty( cExame )
				dbSelectArea( "TKB")
				dbSetOrder( 01 )
				dbSeek( xFilial( 'TKB' ) + TMY->TMY_NUMASO + aEXAMES[yy][3] )
				cExame := TKB->TKB_EXAME
				dDateResultado := StoD( "" )
			EndIf
		EndIf
		dbSelectArea( "TM4" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TM4" ) + cExame )
		If !Empty( TM4->TM4_NOMEXA )
			nPos := aScan( aTM5, { |x| x[1] == dDateResultado } )
			If nPos == 0
				aAdd( aTM5, { dDateResultado, {}, "" } )
				nPos := Len( aTM5 )
			EndIf
			aAdd( aTM5[nPos, 2], Alltrim( TM4->TM4_NOMEXA ) )
		EndIf
	Next yy

	aSort( aTM5, , , { |x, y| x[1] < y[1] } )
	For yy := 1 To Len( aTM5 )
		aSort( aTM5[yy, 2], , , { |x, y| x < y } )
		For xx := 1 To Len( aTM5[yy, 2] )
			If xx > 1
				If Len( aTM5[yy, 2] ) == xx
					aTM5[yy, 3] += " e "
				Else
					aTM5[yy, 3] += ", "
				EndIf
			EndIf
			aTM5[yy, 3] += aTM5[yy, 2, xx]
		Next xx
	Next yy

Return aTM5

//-------------------------------------------------------------------
/*/{Protheus.doc} fCalcIdade
Calcula a idade

@type    function
@author  Jackson Machado
@since   23/08/2011
@sample  fCalcIdade( 29/12/1994 )
@param   dNasc, Data, Data de Nascimento

@return  nIdade, Numérico, Idade calculada
/*/
//-------------------------------------------------------------------
Static Function fCalcIdade( dNasc )

	Local nIdade := 0
	nIdade := YEAR( DATE() ) - YEAR( dNasc )

	If MONTH( dNasc ) > MONTH( DATE() )
		nIdade--
	ElseIf MONTH( dNasc ) == MONTH( DATE() )
		If DAY( dNasc ) > DAY( DATE() )
			nIdade--
		EndIf
	EndIf

Return nIdade

//-------------------------------------------------------------------
/*/{Protheus.doc} fMDT465VPD
Valida parametro para Portador de deficiencia MDTR465

@type    function
@author  Guilherme Benkendorf
@since   04/12/2012
@sample  fMDT465VPD()

@return  xResult, Indefinido,
/*/
//-------------------------------------------------------------------
Static Function fMDT465VPD()

	Local xResult

	If IsInCallStack( "MDTR465" )
		xResult := MV_PAR19
	Else
		xResult := MV_PAR14
	EndIf

	If ValType( xResult ) <> "N"
		xResult := 2
	EndIf

Return xResult

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTASOCoord
Busca o código do Médico Coordenador do PCMSO

@author  Luis Fellipy Bett
@since   16/07/2018

@return Caracter, Código do Médico Coordenador do PCMSO
/*/
//-------------------------------------------------------------------
User Function MDTASOCoord( dDtgera )

	Local aArea := GetArea()
	Local aUsuarios := {}

	Local cAlias := GetNextAlias()

	Local lPerg := .T.

	Local nI := 0

	Default cCodCoo := ''

	If Empty( cCodCoo )

		BeginSQL Alias cAlias

			SELECT 
				TMK.TMK_CODUSU
			FROM 
				%Table:TMW% TMW
				INNER JOIN %table:TMK% TMK ON
					TMK.TMK_CODUSU = TMW.TMW_CODUSU
					AND TMK.TMK_FILIAL = %xFilial:TMK%
					AND TMK.%NotDel%
			WHERE 
				TMW.TMW_FILIAL = %xFilial:TMW%
				AND %Exp:dDtgera% >= TMW.TMW_DTINIC
				AND %Exp:dDtgera% <= TMW.TMW_DTFIM
				AND TMW.%NotDel%

		EndSQL

		dbSelectArea( cAlias )
		dbGoTop()

		While !Eof()

			aAdd( aUsuarios, TMK_CODUSU )

			( cAlias )->( dbSkip() )

		End

		( cAlias )->( dbCloseArea() )

		For nI := Len( aUsuarios ) To 1 Step -1

			cCodCoo := aUsuarios[ nI ]

			If nI != 1

				lPerg := MsgYesNo(;
					SubStr( STR0247, 1, 16 ) + ;
					AllTrim( Posicione( 'TMK', 1, xFilial( 'TMK' ) + aUsuarios[ nI ], 'TMK_NOMUSU' ) ) + ;
					SubStr( STR0247, 16 ), ;
					STR0168;
					)

				If lPerg

					Exit

				EndIf

			EndIf

		Next

	EndIf

	RestArea( aArea )

Return cCodCoo

//-------------------------------------------------------------------
/*/{Protheus.doc} fPerAso
Verifica a permissão na Tabela da Pt/Pet

@author  Elisson França
@since   16/08/2022

@return aCampos, Array, Nomes das permissões de trabalho
/*/
//-------------------------------------------------------------------
Static Function fPerAso()

	Local aCampos := {}

	If !TMY->(ColumnPos( "TMY_OUTROS" )) > 0

		dbSelectArea( "TY7" )
		dbSetOrder( 1 )

		//	Verifica as permissões
		If dbSeek( xFilial( "TY7" ) + TMY->TMY_NUMASO )

			While !Eof() .And. TY7->TY7_FILIAL == xFilial( "TY7" ) .And. TY7->TY7_NUMASO == TMY->TMY_NUMASO

				If !TMY->(ColumnPos( "TMY_PLAT" )) > 0 .And. TY7->TY7_TIPERM == "1" .And. aScan( aCampos, { |x| x[ 1 ] == "1" } ) == 0
					aAdd( aCampos, { "1", STR0209 } )//"Plataforma"
				ElseIf !TMY->(ColumnPos( "TMY_MANCIV" )) > 0 .And. TY7->TY7_TIPERM == "2" .And. aScan( aCampos, { |x| x[ 1 ] == "2" } ) == 0
					aAdd( aCampos,{ "2", STR0210} )//"Manutenção Civil"
				ElseIf !TMY->(ColumnPos( "TMY_EXPLO" )) > 0 .And. TY7->TY7_TIPERM == "3" .And. aScan( aCampos, { |x| x[ 1 ] == "3" } ) == 0
					aAdd( aCampos,{ "3", STR0211 } )//"Explosivos"
				ElseIf TY7->TY7_TIPERM == "4" .And. aScan( aCampos, { |x| x[ 1 ] == "4" } ) == 0
					aAdd( aCampos, { "4", STR0221 } )//"Trabalho em Altura"
				ElseIf !TMY->(ColumnPos( "TMY_ESCAV" )) > 0 .And. TY7->TY7_TIPERM == "5" .And. aScan( aCampos, { |x| x[ 1 ] == "5" } ) == 0
					aAdd( aCampos,{ "5", STR0212 } )//"Escavações/Demolições"
				ElseIf TY7->TY7_TIPERM == "6" .And. aScan( aCampos, { |x| x[ 1 ] == "6" } ) == 0
					aAdd( aCampos, { "6", STR0213 } )//"Trabalho com Eletricidade"
				ElseIf !TMY->(ColumnPos( "TMY_SOLDA" )) > 0 .And. TY7->TY7_TIPERM == "7" .And. aScan( aCampos, { |x| x[ 1 ] == "7" } ) == 0
					aAdd( aCampos,{ "7", STR0214 } )//"Solda (A Quente)"
				ElseIf TY7->TY7_TIPERM == "8" .And. aScan( aCampos, { |x| x[ 1 ] == "8" } ) == 0
					aAdd( aCampos, { "8", STR0207 } )//"Trabalho em Espaço Confinado"
				ElseIf !TMY->(ColumnPos( "TMY_FRIO" )) > 0 .And. TY7->TY7_TIPERM == "9" .And. aScan( aCampos, { |x| x[ 1 ] == "9" } ) == 0
					aAdd( aCampos,{ "9", STR0215 } )//"A Frio"
				ElseIf !TMY->(ColumnPos( "TMY_RADIA" )) > 0 .And. TY7->TY7_TIPERM == "A" .And. aScan( aCampos, { |x| x[ 1 ] == "A" } ) == 0
					aAdd( aCampos,{ "A", STR0216 } )//"Radiação"
				ElseIf !TMY->(ColumnPos( "TMY_PRESS" )) > 0 .And. TY7->TY7_TIPERM == "B" .And. aScan( aCampos, { |x| x[ 1 ] == "B" } ) == 0
					aAdd( aCampos,{ "B", STR0217 } )//"Pressão"
				ElseIf !TMY->(ColumnPos( "TMY_OUTROS" )) > 0 .And. TY7->TY7_TIPERM == "X" .And. aScan( aCampos, { |x| x[ 1 ] == "X" } ) == 0
					aAdd( aCampos,{ "X", STR0218 } )//"Pressão"
				EndIf

				TY7->( dbSkip() )
			End

		EndIf

		If TMY->( ColumnPos( "TMY_TMC" ) ) > 0 .And. TMY->TMY_TMC == "1" .And. aScan( aCampos, { |x| x[ 1 ] == "Z" } ) == 0
			aAdd( aCampos, { "Z", STR0208 } )//"Transporte e Movimentação de Carga
		EndIf

	EndIf

	If TMY->(ColumnPos( "TMY_OUTROS" )) > 0

		// Condições para verificação dos novos campos de permissão da TMY
		If TMY->( ColumnPos( "TMY_PLAT" ) ) > 0 .And. TMY->TMY_PLAT == "1"
			aAdd( aCampos, { "1", STR0209 } ) //"Trabalho em Plataforma"
		EndIf

		If TMY->( ColumnPos( "TMY_MANCIV" ) ) > 0 .And. TMY->TMY_MANCIV == "1"
			aAdd( aCampos, { "1", STR0210 } ) //"Trabalho com Manutenção Civil"
		EndIf

		If TMY->( ColumnPos( "TMY_EXPLO" ) ) > 0 .And. TMY->TMY_EXPLO == "1"
			aAdd( aCampos, { "1", STR0211 } ) //"Trabalho com Explosivos"
		EndIf
		If TMY->( ColumnPos( "TMY_ALTURA" ) ) > 0 .And. TMY->TMY_ALTURA == "1"
			aAdd( aCampos, {"1", STR0221 } )
		EndIf

		If TMY->( ColumnPos( "TMY_ESCAV" ) ) > 0 .And. TMY->TMY_ESCAV == "1"
			aAdd( aCampos, {"1", STR0212 } )
		EndIf

		If TMY->( ColumnPos( "TMY_ELETRI" ) ) > 0 .And. TMY->TMY_ELETRI == "1"
			aAdd( aCampos, {"1", STR0213 } )
		EndIf

		If TMY->( ColumnPos( "TMY_SOLDA" ) ) > 0 .And. TMY->TMY_SOLDA == "1"
			aAdd( aCampos, {"1", STR0214 } )
		EndIf

		If TMY->( ColumnPos( "TMY_FRIO" ) ) > 0 .And. TMY->TMY_FRIO == "1"
			aAdd( aCampos, {"1", STR0215  } )
		EndIf

		If TMY->( ColumnPos( "TMY_RADIA" ) ) > 0 .And. TMY->TMY_RADIA == "1"
			aAdd( aCampos, {"1", STR0216 } )
		EndIf

		If TMY->( ColumnPos( "TMY_PRESS" ) ) > 0 .And. TMY->TMY_PRESS == "1"
			aAdd( aCampos, {"1", STR0217 } )
		EndIf

		If TMY->( ColumnPos( "TMY_CONFIN" ) ) > 0 .And. TMY->TMY_CONFIN == "1"
			aAdd( aCampos, {"1", STR0222 } )
		EndIf

		If TMY->( ColumnPos( "TMY_OUTROS" ) ) > 0 .And. TMY->TMY_OUTROS == "1"
			aAdd( aCampos, {"1", STR0218 } )
		EndIf

		If TMY->( ColumnPos( "TMY_TMC" ) ) > 0 .And. TMY->TMY_TMC == "1"
			aAdd( aCampos, {"1", STR0208 } )
		EndIf

		If TMY->( ColumnPos( "TMY_INFLA" ) ) > 0 .And. TMY->TMY_INFLA == "1"
			aAdd( aCampos, {"1", STR0257 } ) //"Trabalho com Inflamável"
		EndIf

	EndIf

Return aCampos
