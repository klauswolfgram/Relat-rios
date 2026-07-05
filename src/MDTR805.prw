/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MDTR805.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR805
Recibo de entrega do epi.
Todo funcionario que recebe epi da empresa deve assinar o
recibo comprovando o seu recebimento. o programa inicia
lendo a tabela de epi's entregues (TNF). Conforme parametros
seleciona os funcionarios que receberam epi em um determina-
do periodo. O programa podera listar apenas os epi's ainda
lendo a tabela de epi's entregues (TNF). Conforme parametros
com data de emissao do recibo em branco ou todos se o usu  -
rio desejar.

@param aDados - Array com os dados da entrega.
@param aRegs
@param aRegsTNF
@param lDevEpi - Indica se é necessário a devolução.

@author Thiago Machado
@since 20/09/2000
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR805( aDados, aRegs, aRegsTNF, lDevEpi, aDev, lChkBio, aTipRel965 )

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local wnrel   := "MDTR805"
	Local limite  := 132
	Local cDesc1  := STR0001 //"Relatorio de Comprovante de Entrega de EPI.                                     "
	Local cDesc2  := STR0002 //"Conforme parametros o usuario pode selecionar os funcionarios, periodo desejado "
	Local cDesc3  := STR0003 //"e indicar se deseja imprimir apenas epi's nao impressos ou para todos.          "
	Local cString := "TNF"
	Local nFor

	Default lDevEpi := .F.
	Default aDev 	:= {}
	Default lChkBio := .F.

	Private aOldACols := {}
	If Valtype( aRegs ) == "A"
		aOldACols := aClone( aRegs )
	EndIf

	Private aDad695
	Private aRegs695
	If Valtype( aDados ) == "A"
		aDad695 := aClone( aDados )
	EndIf
	If Valtype( aRegsTNF ) == "A"
		aRegs695 := aClone( aRegsTNF )
	EndIf

	Private nomeprog := "MDTR805"
	Private tamanho  := "G"
	Private aReturn  := { STR0004, 1, STR0005, 2, 2, 1, "", 1 } //"Zebrado"###"Administracao"
	Private titulo
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := ""
	Private cPerg2	 := PadR( "MDT805A", 10 ) //Grupo exclusivo para utilização das rotinas MDTA695 e MDTA630
	Private cabec1	 := " "
	Private cabec2   := " "
	Private cFuncMat := " "
	Private dDataEnt := " "
	Private nDist    := 0
	Private cAliasCC := "SI3"
	Private cDescCC  := "SI3->I3_DESC"
	Private cF3CC    := "SI3"
	Private cCodcc   := "I3_CUSTO"
	Private nSizeCC
	Private oTempTRB
	Private nSizeSI3
	Private nSizeSRJ
	Private cUsaInt1  := AllTrim( GetMv( "MV_NGMDTES" ) )
	Private lMdtGerSA := IIf( SuperGetMv( "MV_NG2SA", .F., "N" ) == "S", .T., .F. ) //Indica se gera SA ao inves de requisitar do estoque
	Private lGera_SA  := .T.
	Private lDevol	  := lDevEpi
	Private aDevParc  := aClone( aDev )
	Private lRecBio   := lChkBio

	If !lDevol
		titulo := STR0006 //"Comprovante de Entrega de EPI"
	Else
		titulo := STR0087 //"Comprovante de Devolução de EPI"
	EndIf

	If cUsaInt1 != "S" .Or. !lMdtGerSA
		lGera_SA := .F.
	EndIf

	nSizeCod := IIf( ( TAMSX3( "B1_COD" )[1] ) < 1, 2, ( TAMSX3( "B1_COD" )[1] ) )
	If nSizeCod > 15
		nDist := ( nSizeCod / 2 ) + 2
	EndIf

	nSizeSI3 := IIf( ( TAMSX3( "I3_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "I3_CUSTO" )[1] ) )
	nSizeSRJ := IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 4, ( TAMSX3( "RJ_FUNCAO" )[1] ) )
	nSizeCC  := IIf( ( TAMSX3( "CTT_CUSTO" )[1] ) < 1, 20, ( TAMSX3( "CTT_CUSTO" )[1] ) )
	Private nSizeFil:= FwSizeFilial()

	If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
		cAliasCC := "CTT"
		cDescCC  := "CTT->CTT_DESC01"
		cF3CC    := "CTT"
		cCodcc    := "CTT_CUSTO"
		nSizeSI3 := IIf( ( TAMSX3( "CTT_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "CTT_CUSTO" )[1] ) )
	EndIf

	Private lBioMDT    := SuperGetMv( "MV_NG2BIOM", .F., "2" ) == "1" //Entrega Biométrica
	Private lBioReturn := SuperGetMv( "MV_DEVBIOM", .F., "2" ) == "1" //Devolução Biométrica

	cPerg	  := "MDT805"

	/*--------------------------------------------------------------------
	//PERGUNTAS PADRÃO                                                   |
	| mv_par01              De Funcionario                               |
	| mv_par02              Ate Funcionario                              |
	| mv_par03              De Data Entrega                              |
	| mv_par04              Ate Data Entrega                             |
	| mv_par05              Todos / So nao Impresos / Ultima retirada    |
	| mv_par06              Termo de Responsabilidade                    |
	| mv_par07              Duas vias                                    |
	| mv_par08              Ordenar por                                  |
	| mv_par09              De Centro de Custo                           |
	| mv_par10              Ate Centro de Custo                          |
	| mv_par11              Considerar funcionarios demitidos            |
	|                           1 - Sim                                  |
	|                           2 - Nao                                  |
	| mv_par12              Ordenar EPIs por:                            |
	|                            1 - Cod                                 |
	|                            2 - Nome                                |
	| mv_par13              De Data Admissao                             |
	| mv_par14              Ate Data Admissao                            |
	| mv_par15              De Filial                                    |
	| mv_par16              Ate Filial                                   |
	| mv_par17    		   Tipo de Relatório                             |
	|                             1 - Antalítico                         |
	|                             2 - Sintérico                          |
	| mv_par18    			 Considerar Ass. Lateral ?                   |
	|             				1 - Sim                                  |
	|      						2 - Não                                  |
	| mv_par19    			 Considera Data Recibo ?                     |
	|             				1 - Não                                  |
	|      						2 - Sim                                  |
	|                                                                    |
	---------------------------------------------------------------------*/

	// Verifica as perguntas selecionadas
	If IsInCallStack( "MDTA695" ) .Or. IsInCallStack( "MDTA630" ) .Or. IsInCallStack( "MDTA410" ) .Or. IsInCallStack( "MDTA333" )
		pergunte( cPerg2, .F. )
	Else
		pergunte( cPerg, .F. )
	EndIf

	// Envia controle para a funcao SETPRINT
	wnrel := "MDTR805"

	If Valtype( aDad695 ) == "A"
		wnrel := SetPrint( cString, wnrel, cPerg2, titulo, cDesc1, cDesc2, cDesc3, .F., "" )
		//Adiciona os valores do novo grupo de perguntas no aDad695
		aAdd( aDad695, { "Mv_Par06", Mv_Par01 } )
		aAdd( aDad695, { "Mv_Par07", Mv_Par02 } )
		aAdd( aDad695, { "Mv_Par12", Mv_Par03 } )
		aAdd( aDad695, { "Mv_Par18", Mv_Par04 } )
		aAdd( aDad695, { "Mv_Par19", Mv_Par05 } )
		pergunte( cPerg, .F. )
		If !Empty( aTipRel965 )

			Mv_Par17 := aTipRel965[1][2]

		EndIf

		For nFor := 1 To Len( aDad695 )
			&( aDad695[ nFor, 1 ] ) := aDad695[ nFor, 2 ]
		Next nFor
		
	ElseIf Valtype( aRegs695 ) == "A"
		wnrel := SetPrint( cString, wnrel, cPerg2, titulo, cDesc1, cDesc2, cDesc3, .F., "" )
		pergunte( cPerg, .F. )
	Else
		wnrel := SetPrint( cString, wnrel, cPerg, titulo, cDesc1, cDesc2, cDesc3, .F., "" )
	EndIf

	If nLastKey == 27
		Set Filter to
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM( aNGBEGINPRM )
		Return
	EndIf

	SetDefault( aReturn, cString )

	If nLastKey == 27
		Set Filter to
		//Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM( aNGBEGINPRM )
		Return
	EndIf

	RptStatus( { | lEnd | R805Imp( @lEnd, wnRel, titulo, tamanho ) }, titulo )

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} R805Imp
Chama relatório

@param lEnd - Cancela a impressão.
@param wnRel - Nome do programa.
@param titulo - Titulo do relatório.
@param tamanho - Indica o tamanho do relatório.

@author Thiago Machado
@since 20/09/2000
@return Nil
/*/
//---------------------------------------------------------------------
Static Function R805Imp( lEnd, wnRel, titulo, tamanho )

	// Define Variaveis
	Local cRodaTxt	:= ""
	Local nCntImpr	:= 0
	Local cCC		:= ""
	Local lImp		:= .F.
	Local i

	// Variaveis para controle do cursor de progressao do relatorio
	Local nTotRegs	:= 0
	Local nMult		:= 1
	Local nPosAnt	:= 4
	Local nPosAtu	:= 4
	Local nPosCnt	:= 0

	// Variaveis locais exclusivas deste programa
	Local lContinua	:= .T.
	Local nRegAtual	:= 0
	Local nCont
	Local nPOSCOD
	Local nPOSNUM
	Local nPOSDAT
	Local nPOSHOR
	Local lExistOld
	Local aFiliais	 := {}
	Local cFiltro	 := ''
	Local cQryTNF	 := GetNextAlias()
	Local cOrdem	 := ''
	Local cDemit	 := '%%'
	Local cQryFilter := ''
	Local cFilterInd := "AND TNF.TNF_INDDEV != '3'"
	Local lMDTR8051	 := ExistBlock( "MDTR8051" )

	// Contadores de linha e pagina
	Private li		   := 80
	Private m_pag	   := 1
	Private lCPODtVenc := .T.
	Private cTRB	   := GetNextAlias()

	aDBF := {}
	aAdd( aDBF, { "FUNCI", "C", 06, 0 } )
	aAdd( aDBF, { "NOME", "C", 70, 0 } )
	aAdd( aDBF, { "RG", "C", 15, 0 } )
	aAdd( aDBF, { "NASC", "D", 10, 0 } )
	aAdd( aDBF, { "ADMIS", "D", 10, 0 } )
	aAdd( aDBF, { "IDADE", "C", 03, 0 } )
	aAdd( aDBF, { "CC", "C", nSizeSI3, 0 } )
	aAdd( aDBF, { "DESCC", "C", 60, 0 } )
	aAdd( aDBF, { "FUNCAO", "C", nSizeSRJ, 0 } )
	aAdd( aDBF, { "DESCFUN", "C", 20, 0 } )
	aAdd( aDBF, { "CODEPI", "C", nSizeCod, 0 } )
	aAdd( aDBF, { "DESEPI", "C", 80, 0 } )
	aAdd( aDBF, { "DTENT", "D", 10, 0 } )
	aAdd( aDBF, { "HRENT", "C", 08, 0 } )
	aAdd( aDBF, { "QTDE", "N", 06, 2 } )
	aAdd( aDBF, { "DEV", "C", 01, 0 } )
	aAdd( aDBF, { "NUMCAP", "C", 12, 0 } )
	aAdd( aDBF, { "NUMCRI", "C", 12, 0 } )
	aAdd( aDBF, { "NUMCRF", "C", 12, 0 } )
	aAdd( aDBF, { "DTDEVO", "D", 10, 0 } )
	aAdd( aDBF, { "CATFUNC", "C", 01, 0 } )
	aAdd( aDBF, { "NUMSA", "C", 06, 0 } )
	aAdd( aDBF, { "ITEMSA", "C", 02, 0 } )
	aAdd( aDBF, { "BIOMET", "N", 01, 0 } )
	aAdd( aDBF, { "DTRECI", "D", 10, 0 } )
	aAdd( aDBF, { "NOMECOM", "C", 60, 0 } )
	aAdd( aDBF, { "CGC", "C", 14, 0 } )
	aAdd( aDBF, { "FILIAL", "C", nSizeFil, 0 } )
	aAdd( aDBF, { "NOMFIL", "C", 40, 0 } )
	aAdd( aDBF, { "ENDENT", "C", 60, 0 } )
	aAdd( aDBF, { "CIDENT", "C", 60, 0 } )
	aAdd( aDBF, { "ESTENT", "C", 60, 0 } )
	aAdd( aDBF, { "BIOMETRIA", "C", 1, 0 } )


	If Len( aOldACols ) > 0
		nPOSCOD := aSCAN( aHEADER, { | x | Trim( Upper( x[2] ) ) == "TNF_CODEPI" } ) // Codigo do Epi
		nPOSNUM := aSCAN( aHEADER, { | x | Trim( Upper( x[2] ) ) == "TNF_NUMCAP" } ) // Num C. A.
		nPOSDAT := aSCAN( aHEADER, { | x | Trim( Upper( x[2] ) ) == "TNF_DTENTR" } ) // Data da Entrega
		nPOSHOR := aSCAN( aHEADER, { | x | Trim( Upper( x[2] ) ) == "TNF_HRENTR" } ) // Hora da Entrega
	EndIf

	oTempTRB := FWTemporaryTable():New( cTRB, aDBF )
	If mv_par12 == 1  //Cod EPI
		oTempTRB:AddIndex( "1", { "FILIAL", "FUNCI", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "2", { "FILIAL", "NOME", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "3", { "FILIAL", "CC", "FUNCI", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "4", { "FILIAL", "DESCC", "FUNCI", "CODEPI", "NUMCAP", "DTENT" } )
	ElseIf mv_par12 == 2  //Nome EPI
		oTempTRB:AddIndex( "1", { "FUNCI", "DESEPI", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "2", { "FILIAL", "NOME", "DESEPI", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "3", { "FILIAL", "CC", "FUNCI", "CODEPI", "NUMCAP", "DTENT" } )
		oTempTRB:AddIndex( "4", { "FILIAL", "DESCC", "FUNCI", "DESEPI", "CODEPI", "NUMCAP", "DTENT" } )
	Else // Data EPI
		oTempTRB:AddIndex( "1", { "FUNCI", "DTENT", "HRENT", "CODEPI", "NUMCAP"} )
		oTempTRB:AddIndex( "2", { "FILIAL", "NOME", "DTENT", "HRENT", "CODEPI", "NUMCAP" } )
		oTempTRB:AddIndex( "3", { "FILIAL", "CC", "FUNCI", "DTENT", "CODEPI", "NUMCAP", "HRENT" } )
		oTempTRB:AddIndex( "4", { "FILIAL", "DESCC", "FUNCI", "DTENT", "HRENT", "CODEPI", "NUMCAP" } )
	EndIf
	oTempTRB:Create()

	lImpAuto := .F.
	If Valtype( aRegs695 ) == "A"
		lImpAuto := .T.
		SetRegua( Len( aRegs695 ) )
		For i := 1 To Len( aRegs695 )
			IncRegua()
			dbSelectArea( "TNF" )
			dbGoTo( aRegs695[i] )
			If !Eof() .And. !Bof()
				cFuncMat := TNF->TNF_MAT
				U_AddRec805( cFilAnt, Upper( Substr( SM0->M0_NOME, 1, 40 ) ) )
			EndIf
		Next i
	EndIf

	// Define Filiais a percorrer
	If Valtype( aDad695 ) == "A"
		aFiliais := { { cFilAnt, Upper( Substr( SM0->M0_NOME, 1, 40 ) ) } }
	Else
		aFiliais := MDTRETFIL( "SRA", MV_PAR15, MV_PAR16 )
	EndIf

	// Verifica se deve comprimir ou nao
	nTipo := IIf( aReturn[4] == 1, 15, 18 )

	If MV_PAR05 == 2 //Só não Impresos
		cFiltro := "AND TNF_DTRECI = ''"
	ElseIf MV_PAR05 == 3 // Última retirada
		cFiltro := "AND TNF.TNF_DTENTR = ( SELECT MAX(TNF_DTENTR) FROM " + RetSQLName( "TNF" ) + " TNF1 " + ;
					"WHERE TNF1.TNF_FILIAL = TNF.TNF_FILIAL AND TNF.TNF_MAT = TNF1.TNF_MAT)"
	EndIf

	If MV_PAR11 == 2 //Não Considerar funcionarios demitidos
		cDemit := "%AND SRA.RA_SITFOLH <> 'D' AND SRA.RA_DEMISSA = ''%"
	EndIf

	For i := 1 To Len( aFiliais )

		If lImpAuto
			Loop
		EndIf

		dbSelectArea( "TNF" )
		SetRegua( LastRec() )

		cFilTNF := xFilial( 'TNF', aFiliais[ i, 1 ] )
		cFilSRA := xFilial( 'SRA', aFiliais[ i, 1 ] )

		cQryFilter := "%"
		If lMDTR8051
			cQryFilter += ExecBlock( "MDTR8051", .F., .F., { cFilterInd } )
		Else
			cQryFilter += cFilterInd
		EndIf
		cQryFilter += cFiltro
		cQryFilter += "%"

		BeginSql Alias cQryTNF

			SELECT
				TNF.TNF_FILIAL, TNF.TNF_FORNEC, TNF.TNF_LOJA, TNF.TNF_MAT, TNF.TNF_CODEPI, TNF.TNF_NUMCAP,
				TNF.TNF_DTENTR, TNF.TNF_HRENTR
			FROM
				%Table:TNF% TNF
				INNER JOIN
					%Table:SRA% SRA ON
						SRA.RA_FILIAL = %exp:cFilSRA%
						AND SRA.RA_MAT = TNF.TNF_MAT
						AND SRA.RA_ADMISSA >= %exp:MV_PAR13%
						AND SRA.RA_ADMISSA <= %exp:MV_PAR14%
						AND SRA.RA_CC >= %exp:MV_PAR09%
						AND SRA.RA_CC <= %exp:MV_PAR10%
						AND SRA.%NotDel%
						%exp:cDemit%
			WHERE
				TNF.TNF_FILIAL = %exp:cFilTNF%
				AND TNF.TNF_MAT >= %exp:MV_PAR01%
				AND TNF.TNF_MAT <= %exp:MV_PAR02%
				AND TNF.TNF_DTENTR >= %exp:MV_PAR03%
				AND TNF.TNF_DTENTR <= %exp:MV_PAR04%
				AND TNF.%NotDel%
				%exp:cQryFilter%
		EndSql

		// Correr TNF para ler os  EPI's Entregues aos Funcionarios
		While ( cQryTNF )->( !Eof() )

			dbSelectArea( "TNF" )
			dbSetOrder( 1 )// TNF_FILIAL+TNF_FORNEC+TNF_LOJA+TNF_CODEPI+TNF_NUMCAP+TNF_MAT+DTOS(TNF_DTENTR)+TNF_HRENTR
			If !dbSeek( xFilial( "TNF", ( cQryTNF )->TNF_FILIAL ) + ;
				( cQryTNF )->( TNF_FORNEC + TNF_LOJA + TNF_CODEPI + TNF_NUMCAP + TNF_MAT + TNF_DTENTR + TNF_HRENTR ) )
				
				(cQryTNF)->( dbSkip() )
				Loop

			EndIf

			IncRegua()

			dbSelectArea( "SRA" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "SRA", aFiliais[ i, 1 ] ) + TNF->TNF_MAT )
			dbSelectArea( "TM0" )
			dbSetOrder( 03 )
			dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )

			lExistOld := .F.
			If Len( aOldACols ) > 0
				For nCont := 1 To Len( aOldACols )
					If aOldACols[nCont][nPOSCOD] == TNF->TNF_CODEPI .And. aOldACols[nCont][nPOSNUM] == TNF->TNF_NUMCAP .And. ;
						aOldACols[nCont][nPOSDAT] == TNF->TNF_DTENTR .And. aOldACols[nCont][nPOSHOR] == TNF->TNF_HRENTR
						lExistOld := .T.
						Exit
					EndIf
				Next nCont

				If lExistOld
					( cQryTNF )->( dbSkip() )
					Loop
				EndIf
			EndIf

			lExistOld := .T.
			If Len( aDevParc ) > 0
				For nCont := 1 To Len( aDevParc )
					If aDevParc[ nCont, 2 ] == TNF->TNF_CODEPI .And. aDevParc[ nCont, 5 ] == TNF->TNF_NUMCAP .And. ;
						aDevParc[ nCont, 7 ] == TNF->TNF_DTENTR .And. aDevParc[ nCont, 8 ] == TNF->TNF_HRENTR
						lExistOld := .F.
						Exit
					EndIf
				Next nCont

				If lExistOld
					( cQryTNF )->( dbSkip() )
					Loop
				EndIf
			EndIf

			cFuncMat := TNF->TNF_MAT

			If Empty( TNF->TNF_DTRECI ) .And. TM0->TM0_INDBIO != "1"
				dbSelectArea( "TNF" )
				Reclock( "TNF", .F. )
					TNF->TNF_DTRECI := Date()
				MsUnlock( "TNF" )
			EndIf
			
			U_AddRec805( aFiliais[ i, 1 ], aFiliais[ i, 2 ] )

			( cQryTNF )->( dbSkip() )

		End
		( cQryTNF )->( dbCloseArea() )
	Next i

	//Teste de parametros para saber o tipo de relatório a ser imprimido.
	If mv_par17 == 1 .Or. IsInCallStack( "MDTA333" ) 
		U_NGIMP805TRB()
	Else
		U_NGIMP805SIN()
	EndIf

	If ( cTRB )->( RecCount() ) > 0
		lImp := .T.
	EndIf

	oTempTRB:Delete()

	// Devolve a condicao original do arquivo principal
	RetIndex( "TNF" )
	Set Filter To

	If lImp
		Set device to Screen

		If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool( wnrel )
		EndIf
		MS_FLUSH()
	Else
		MsgStop( STR0079, STR0080 ) //"Não existem dados para montar o relatório."###"Atenção"
	EndIf

	dbSelectArea( "TNF" )
	dbSetOrder( 1 )

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Thiago Machado
@since 20/09/2000
@return Nil
/*/
//---------------------------------------------------------------------
Static Function Somalinha()

	Li++

	If Li > 58
       Cabec( titulo, cabec1, cabec2, nomeprog, tamanho, nTipo )
    EndIf

Return

/*
          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³XXXXXXXXXXXXX                                      COMPROVANTE DE ENTREGA DE EPI'S                                                 ³
³SIGA/MDTR805                                    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                Emissao: 99/99/99   hh:mm    ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Funcionario.....: xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                         RG.: xxx.xxx.xxx			        				³
³Centro de Custo.: xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx						 		                                    			³
³Funcao..........: xxxx  -  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   					                                     					³
³Nascimento......: xx/xx/xx                                                               Admissao.: xx/xx/xx     Idade.: xx  		³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEPI'sÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³EPI              Nome do EPI                        Dt. Entr    Hora     Qtde  Dev. Dt. Devo  Num. CA 	                            	³
³  Num. CRF      Num. CRI      Num. SA  Item SA                   													                           ³
³xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xx:xx  xxx,xx  xxx  xx/xx/xx  xxxxxxxxxxxx  Ass.: _________________  ³
³  xxxxxxxxxxxx  xxxxxxxxxxxx  xxxxxx   xx                                                                                          ³
³xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xx:xx  xxx,xx  xxx  xx/xx/xx  xxxxxxxxxxxx  Ass.: _________________  ³
³xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx/xx/xxxx  xx:xx  xxx,xx  xxx  xx/xx/xx  xxxxxxxxxxxx  Ass.: _________________  ³
³                                                                               																		³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³       Data : ___/___/___                                                           							              	    			³
³                                                                               																		³
|       Assinatura: _______________________                                   Resp Empr: _______________________                    ³
³                                                                               																		³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
//---------------------------------------------------------------------
/*/{Protheus.doc} NGIMP805TRB
Impressão do Relatório.

@author Thiago Machado
@since 20/09/2000
@return Nil
/*/
//---------------------------------------------------------------------
User Function NGIMP805TRB()

	Local LinhaCorrente
	Local cFil          := ""
	Local lPrimvez      := .T.
	Local nRecnoAtu     := 1

	dbSelectArea( cTRB )
	If mv_par08 == 1  //Matricula
		dbSetOrder( 1 )
	ElseIf mv_par08 == 2  //Nome Funcionario
		dbSetOrder( 2 )
	ElseIf mv_par08 == 3  //Cod. C. Custo
		dbSetOrder( 3 )
	ElseIf mv_par08 == 4  //Nome C. Custo
		dbSetOrder( 4 )
	EndIf

	dbGoTop()

	While !Eof()

		nRecnoAtu := Recno()

		cFil  := ( cTRB )->FILIAL
		CFUNC := ( cTRB )->FUNCI
		nVolta := 0
		SomaLinha()
		@ Li, 000 PSay " " + Replicate( "_", 219 )
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 Psay STR0027 + ( cTRB )->NOMECOM //"Empresa...:"
		@ Li, 127 Psay STR0075 + ( cTRB )->CGC //"CNPJ..:"
		@ Li, 220 PSay "|"
		If NGSX2MODO( "TNF" ) != "C"
			Somalinha()
			@ Li, 000 PSay "|"
			@ Li, 001 Psay STR0081 + ( cTRB )->FILIAL + " - " + ( cTRB )->NOMFIL //"Filial....:"
			@ Li, 220 PSay "|"
		EndIf
		SomaLinha()

		@ Li, 000 PSay "|"
		@ Li, 001 Psay STR0028 + ( cTRB )->ENDENT //"Endereco..:"
		@ Li, 127 Psay STR0029 + ( cTRB )->CIDENT //"Cidade..:"
		@ Li, 162 Psay STR0030 + ":" + ( cTRB )->ESTENT //"Estado.."
		@ Li, 221 PSay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"

		SomaLinha()
		@ Li, 000 PSay STR0010 //"|Funcionario.....:"
		@ Li, 019 PSay MDTHideCpo( AllTrim( CFUNC ), "TNF_MAT" ) + " - " + MDTHideCpo( ( cTRB )->NOME, "RA_NOME" )
		@ Li, 127 PSay STR0011 //"RG.:"
		@ Li, 132 PSay MDTHideCpo( ( cTRB )->RG, "RA_RG" ) PICTURE "@!"
		@ Li, 220 PSay "|"

		SomaLinha()
		@ Li, 000 PSay STR0012 //"|Centro de Custo.:"

		@ Li, 019 PSay Alltrim( ( cTRB )->CC ) + " - " + Alltrim( ( cTRB )->DESCC )
		@ Li, 127 PSay STR0066 //"Categoria Func.:"
		@ Li, 144 PSay Substr( Posicione( "SX5", 01, xFilial( "SX5" ) + "28" + ( cTRB )->CATFUNC, "X5Descri()" ), 1, 30 ) PICTURE "@!"
		@ Li, 220 PSay "|"

		SomaLinha()
		@ Li, 000 PSay STR0013 //"|Funcao..........:"
		@ Li, 019 PSay Alltrim( ( cTRB )->FUNCAO ) + " - " + Alltrim( ( cTRB )->DESCFUN ) PICTURE "@!"
		@ Li, 220 PSay "|"

		SomaLinha()
		@ Li, 000 PSay STR0014 //"|Nascimento......:"
		@ Li, 019 PSay MDTHideCpo( ( cTRB )->NASC, 'RA_NASC' )
		@ Li, 127 PSay STR0015 //"Admissao.:"
		@ Li, 138 PSay ( cTRB )->ADMIS PICTURE "99/99/9999"
		@ Li, 157 PSay STR0016 //"Idade.:"
		If !Versenha( 192 ) //Verifica se usuário não tem permissão para ver dados pessoais
			@ Li, 165 PSay FwProtectedDataUtil():ValueAsteriskToAnonymize( ( cTRB )->IDADE ) + " " + STR0039 //"anos"
		Else
			@ Li, 165 PSay ( cTRB )->IDADE + " " + STR0039 //"anos"
		EndIf
		@ Li, 220 PSay "|"

		lLinha := .F.
		lFirst := .T.

		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 Psay "|"
		@ Li, 001 PSay STR0017 //"EPI"
		@ Li, 017 + nDist PSay STR0018 //"Nome do EPI"

		If MV_PAR19 == 1 //Não imprime Assinatura Lateral

			@ Li, 097 + nDist PSay STR0019 //"Dt. Entr"
			@ Li, 109 + nDist PSay STR0040 //"Hora"
			@ Li, 119 + nDist PSay STR0025 //"Qtde"
			@ Li, 127 + nDist PSay STR0020 //"Dev."
			@ Li, 132 + nDist PSay STR0042 //"Dt. Devo"
			@ Li, 144 + nDist PSay STR0026 //"Num C.A."
			@ Li, 220 Psay "|"
			Somalinha()
			@ Li, 000 Psay "|"

		Else

			@ Li, 097 + nDist PSay STR0019 //"Dt. Entr"
			@ Li, 119 + nDist PSay STR0025 //"Qtde"
			@ Li, 127 + nDist PSay STR0020 //"Dev."
			@ Li, 132 + nDist PSay STR0042 //"Dt. Devo"
			@ Li, 144 + nDist PSay STR0026 //"Num C.A."
			@ Li, 220 Psay "|"
			Somalinha()
			@ Li, 000 Psay "|"

		EndIf

		dbSelectArea( "TN3" )
		@ Li, 002 PSay STR0033  //"Num. CRF"
		lLinha := .T.
		@ Li, 016 PSay STR0034  //"Num. CRI"
		lLinha := .T.
		If lGera_SA
			@ Li, 031 PSay STR0082  //"Num. SA"
			@ Li, 040 PSay STR0083  //"Item SA"
			lLinha := .T.
		EndIf
		dbSelectArea( cTRB )
		While !Eof() .And. ( cTRB )->FUNCI == CFUNC .And. ( cTRB )->FILIAL == cFil
			If lLinha .And. lFirst
				@ Li, 220 Psay "|"
				Somalinha()
				@ Li, 000 PSay "|"
			EndIf
			If !lFirst
				Somalinha()
				@ Li, 000 PSay "|"
			EndIf
			lFirst := .F.
			
			//Garante que o parâmetro receberá um valor válido
			If Valtype( MV_PAR19 ) != "N"
				MV_PAR19 := 1
			EndIf
			
			If MV_PAR19 == 1 //Imprime data Entrega


				@ Li, 001 PSAY ( cTRB )->CODEPI
				@ Li, 017 + nDist PSay SubStr( AllTrim( ( cTRB )->DESEPI ), 1, 75 ) PICTURE "@!"
				@ Li, 097 + nDist PSay IIf( MV_PAR19 == 1, ( cTRB )->DTENT, ( cTRB )->DTRECI ) PICTURE "99/99/9999"
				@ Li, 109 + nDist PSay IIf( MV_PAR19 == 1, ( cTRB )->HRENT, CTOD('')) PICTURE "99:99:99"
				@ Li, 116 + nDist PSay ( cTRB )->QTDE PICTURE "@E 999.99"

				If ( cTRB )->DEV = "1"
					@ Li, 127 + nDist PSAY STR0021 //"SIM"
				Else
					@ Li, 127 + nDist PSAY STR0022  //"NAO"
				ENDIf
				@ Li, 132 + nDist PSay ( cTRB )->DTDEVO PICTURE "99/99/9999"
				If !Empty( ( cTRB )->NUMCAP )
					@ Li, 144 + nDist PSay AllTrim( SubStr( ( cTRB )->NUMCAP, 1, 12 ) )
				EndIf

				If mv_par18 == 1 .And. !Empty( ( cTRB )->DTRECI ) //Imprime assinatura lateral

						If ( cTRB )->BIOMET == 2 .Or. Empty( ( cTRB )->BIOMET )
							@ Li, 160 + nDist PSay STR0076 //"Ass.: _________________"
						Else
							@ Li, 160 + nDist PSay STR0086 //"Registro Biométrico"
						EndIf				

				EndIf

			Else

				@ Li, 001 PSAY ( cTRB )->CODEPI
				@ Li, 017 + nDist PSay SubStr( AllTrim( ( cTRB )->DESEPI ), 1, 75 ) PICTURE "@!"
				@ Li, 097 + nDist PSay IIf( MV_PAR19 == 1, ( cTRB )->DTENT, ( cTRB )->DTRECI ) PICTURE "99/99/9999"
				@ Li, 116 + nDist PSay ( cTRB )->QTDE PICTURE "@E 999.99"

				If ( cTRB )->DEV = "1"
					@ Li, 127 + nDist PSAY STR0021 //"SIM"
				Else
					@ Li, 127 + nDist PSAY STR0022  //"NAO"
				ENDIf
				@ Li, 132 + nDist PSay ( cTRB )->DTDEVO PICTURE "99/99/9999"
				If !Empty( ( cTRB )->NUMCAP )
					@ Li, 144 + nDist PSay AllTrim( SubStr( ( cTRB )->NUMCAP, 1, 12 ) )
				EndIf

				
				If mv_par18 == 1 .And. !Empty( ( cTRB )->DTRECI )//Imprime assinatura lateral

						If ( cTRB )->BIOMET == 2 .Or. Empty( ( cTRB )->BIOMET )
							@ Li, 160 + nDist PSay STR0076 //"Ass.: _________________"
						Else
							@ Li, 160 + nDist PSay STR0086 //"Registro Biométrico"
						EndIf				

				EndIf

			EndIf

			If lLinha
				@ Li, 219 Psay "|"
				Somalinha()
				@ Li, 000 Psay "|"
			EndIf

			dbSelectArea( "TN3" )
			@ Li, 002 PSay ( cTRB )->NUMCRF
			@ Li, 016 PSay ( cTRB )->NUMCRI
			If lGera_SA
				@ Li, 031 PSay ( cTRB )->NUMSA
				@ Li, 040 PSay ( cTRB )->ITEMSA
			EndIf

			@ Li, 220 PSay "|"
			nVolta++
			dbSelectArea( cTRB )
			dbSkip()
		End

		//termo
		dbSelectArea( "TMZ" )
		dbSetOrder( 01 )
		If dbSeek( xFilial( "TMZ" ) + MV_PAR06 )
			SomaLinha()
			@ Li, 000 PSay "|"
			@ Li, 001 PSay Replicate( "_", 219 )
			@ Li, 220 PSay "|"
			SomaLinha()
			@ Li, 000 PSay "|"
			@ Li, 098 PSay STR0041 //"TERMO DE RESPONSABILIDADE"
			@ Li, 220 PSay "|"
			Somalinha()
			@ Li, 000 PSay "|"
			lPrimeiro := .T.

			nLinhasMemo := MLCOUNT( TMZ->TMZ_DESCRI, 219 )
			For LinhaCorrente := 1 To nLinhasMemo
				If lPrimeiro
					If !Empty( ( MemoLine( TMZ->TMZ_DESCRI, 56, LinhaCorrente ) ) )
						@ Li, 001 PSAY ( MemoLine( TMZ->TMZ_DESCRI, 219, LinhaCorrente ) )
						@ Li, 220 PSay "|"
						lPrimeiro := .F.
					Else
						Exit
					EndIf
				Else
					@ Li, 000 PSay "|"
					@ Li, 001 PSAY ( MemoLine( TMZ->TMZ_DESCRI, 219, LinhaCorrente ) )
					@ Li, 220 PSay "|"
				EndIf
				Somalinha()
			Next
			If !lPrimeiro
				@ Li, 000 PSay "|"
			EndIf
			@ Li, 220 PSay "|"
		EndIf
		//Fim do Termo

		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay STR0036 //"|       Data : ____/____/____"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay STR0037 //"|       Assinatura: _______________________"
		@ Li, 127 PSay STR0088 //"Resp Empr: _______________________"
		@ Li, 220 Psay "|"
		SomaLinha()
		@ Li, 000 Psay "|"
		@ Li, 220 Psay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		Li := 80
		If mv_par07 == 2 .And. lPrimvez
			dbSelectArea( cTRB )
			dbGoTo( nRecnoAtu )
			dbSkip( -( nVolta - 1 ) )
			lPrimvez := .F.
		Else
			dbSelectArea( cTRB )
			lPrimvez := .T.
		EndIf
	End

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} NG805DATE
Faz tratamento das datas

@param dDtPPP - Data

@author Thiago Machado
@since 20/09/2000
@return cRet
/*/
//---------------------------------------------------------------------
User Function NG805DATE( dDtPPP )

	Local cRet, cDia, cMes, cAno

	If Empty( dDtPPP )
		Return "  /  /  "
	EndIf

	cDia := Strzero( Day( dDtPPP ), 2 )
	cMes := Strzero( Month( dDtPPP ),2)
	cAno := Substr( Str( Year( dDtPPP ), 4 ), 3, 2 )

	cRet := cDia + "/" + cMes + "/" + cAno

Return cRet

//---------------------------------------------------------------------
/*/{Protheus.doc} AddRec805
Armazena informacoes de um recibo para impressao.

@param cCodFil - Codigo da Filial
@param cNomFil - Nome da Filial

@author Andre E. Perez Alvarez
@since 17/01/2006
@return Nil
/*/
//---------------------------------------------------------------------
User Function AddRec805( cCodFil, cNomFil )

	Local lParcial	:= .F. //Determina se foi entrega Parcial.
	Local dDataDev	:= STOD("") //Data de Devolução Parcial.
	Local nW		:= 0
	Local aInfEmp	:= fInfEmp( cCodFil )
	Local lBioLeg := SuperGetMV('MV_BIOMDT', .F., '1') == '1'

	Default cCodFil := ""
	Default cNomFil := ""

	dbSelectArea( "TN3" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TN3", cCodFil ) + TNF->TNF_FORNEC + TNF->TNF_LOJA + TNF->TNF_CODEPI + TNF->TNF_NUMCAP )

	dbSelectArea( "SRA" )
	dbSetOrder( 01 )
	dbSeek( xFilial( "SRA", cCodFil ) + cFuncMat )

	dbSelectArea( cAliasCC )
	dbSetOrder( 01 )
	dbSeek( xFilial( cAliasCC, cCodFil ) + SRA->RA_CC )

	dbSelectArea( "SRJ" )
	dbSetOrder( 01 )
	dbSeek( xFilial( "SRJ", cCodFil ) + SRA->RA_CODFUNC )

	dbSelectArea( "SB1" )
	dbSetOrder( 01 )
	dbSeek( xFilial( "SB1", cCodFil ) + TNF->TNF_CODEPI )

	If Len(aDevParc) > 0 .And. ; //Caso seja devolução parcial.
	aScan( aDevParc, { | x | x[ 1 ] == TNF->TNF_FILIAL .And. ;
							x[ 2 ] == TNF->TNF_CODEPI .And. ;
							x[ 3 ] == TNF->TNF_FORNEC .And. ;
							x[ 4 ] == TNF->TNF_LOJA .And. ;
							x[ 5 ] == TNF->TNF_NUMCAP .And. ;
							x[ 6 ] == TNF->TNF_MAT .And. ;
							x[ 7 ] == TNF->TNF_DTENTR .And. ;
							x[ 8 ] == TNF->TNF_HRENTR } ) //Caso Epi estaja em uso, verIfica a devolução Parcial.

		For nW := 1 To Len( aDevParc )
			If aDevParc[ nW, 1 ] == TNF->TNF_FILIAL .And. aDevParc[ nW, 2 ] == TNF->TNF_CODEPI .And. ;
				aDevParc[ nW, 3 ] == TNF->TNF_FORNEC .And. aDevParc[ nW, 4 ] == TNF->TNF_LOJA .And. ;
				aDevParc[ nW, 5 ] == TNF->TNF_NUMCAP .And. aDevParc[ nW, 6 ] == TNF->TNF_MAT .And. ;
				aDevParc[ nW, 7 ] == TNF->TNF_DTENTR .And. aDevParc[ nW, 8 ] == TNF->TNF_HRENTR

				dbSelectArea( cTRB )
				( cTRB )->( dbAppend() )
				( cTRB )->FUNCI		:= cFuncMat
				( cTRB )->NOME		:= IIf( !Empty( SRA->RA_NOMECMP ), SRA->RA_NOMECMP, SRA->RA_NOME )
				( cTRB )->RG		:= SRA->RA_RG
				( cTRB )->CATFUNC	:= SRA->RA_CATFUNC
				( cTRB )->NASC		:= SRA->RA_NASC
				( cTRB )->ADMIS		:= SRA->RA_ADMISSA
				( cTRB )->IDADE		:= R555ID( ( cTRB )->NASC )
				( cTRB )->CC		:= SRA->RA_CC
				( cTRB )->DESCC		:= AllTrim( &( cDescCC ) )
				( cTRB )->FUNCAO	:= SRA->RA_CODFUNC
				( cTRB )->DESCFUN	:= Alltrim( SRJ->RJ_DESC )
				( cTRB )->CODEPI	:= TNF->TNF_CODEPI
				( cTRB )->DESEPI	:= AllTrim( SB1->B1_DESC )
				( cTRB )->DTENT		:= TNF->TNF_DTENTR
				( cTRB )->HRENT		:= TNF->TNF_HRENTR
				( cTRB )->QTDE		:= aDevParc[ nW, 11 ] //TNF->TNF_QTDENT
				( cTRB )->DEV		:= "1"
				( cTRB )->DTDEVO	:= aDevParc[ nW, 9 ]
				( cTRB )->NUMCAP	:= TNF->TNF_NUMCAP
				( cTRB )->DTRECI    := TNF->TNF_DTRECI
				( cTRB )->BIOMETRIA := TM0->TM0_INDBIO
				If lDevol //Se for recibo de Devolução
					If TNF->TNF_DEVBIO == "1"
						( cTRB )->BIOMET := 1
					Else
						( cTRB )->BIOMET := 2
					EndIf
				EndIf
				( cTRB )->NUMCRI := TN3->TN3_NUMCRI
				( cTRB )->NUMCRF := TN3->TN3_NUMCRF
				If lGera_SA
					( cTRB )->NUMSA  := TNF->TNF_NUMSA
					( cTRB )->ITEMSA := TNF->TNF_ITEMSA
				EndIf
				( cTRB )->NOMECOM	:= AllTrim( SubStr( aInfEmp[ 1, 1 ], 1, 60 ) )
				( cTRB )->CGC		:= AllTrim( aInfEmp[ 1, 2 ] )
				( cTRB )->FILIAL	:= AllTrim( xFilial( "SRA", cCodFil ) )
				( cTRB )->NOMFIL	:= AllTrim( cNomFil )
				( cTRB )->ENDENT	:= AllTrim( aInfEmp[ 1, 3 ] )
				( cTRB )->CIDENT	:= AllTrim( aInfEmp[ 1, 4 ] )
				( cTRB )->ESTENT	:= AllTrim( aInfEmp[ 1, 5 ] )
			EndIf
		Next nW

	Else //Caso seja devolução total.

		dbSelectArea( cTRB )
		( cTRB )->( dbAppend() )
		( cTRB )->FUNCI    := cFuncMat
		( cTRB )->NOME     := IIf( !Empty( SRA->RA_NOMECMP ), SRA->RA_NOMECMP, SRA->RA_NOME )
		( cTRB )->RG       := SRA->RA_RG
		( cTRB )->CATFUNC  := SRA->RA_CATFUNC
		( cTRB )->NASC     := SRA->RA_NASC
		( cTRB )->ADMIS    := SRA->RA_ADMISSA
		( cTRB )->IDADE    := R555ID( ( cTRB )->NASC )
		( cTRB )->CC       := SRA->RA_CC
		( cTRB )->DESCC    := AllTrim( &( cDescCC ) )
		( cTRB )->FUNCAO   := SRA->RA_CODFUNC
		( cTRB )->DESCFUN  := Alltrim( SRJ->RJ_DESC )
		( cTRB )->CODEPI   := TNF->TNF_CODEPI
		( cTRB )->DESEPI   := AllTrim( SB1->B1_DESC )
		( cTRB )->DTENT    := TNF->TNF_DTENTR
		( cTRB )->HRENT    := TNF->TNF_HRENTR
		( cTRB )->QTDE     := TNF->TNF_QTDENT
		( cTRB )->DEV      := TNF->TNF_INDDEV
		( cTRB )->DTDEVO   := TNF->TNF_DTDEVO
		( cTRB )->NUMCAP   := TNF->TNF_NUMCAP
		( cTRB )->DTRECI   := TNF->TNF_DTRECI
		( cTRB )->BIOMETRIA:= TM0->TM0_INDBIO
		If lDevol	//Se for recibo de Devolução
			If TNF->TNF_DEVBIO == "1" .Or. lRecBio
				( cTRB )->BIOMET := 1
			Else
				( cTRB )->BIOMET := 2
			EndIf
		Else
			( cTRB )->BIOMET := IIf( ( lBioLeg .And. !Empty( TNF->TNF_DIGIT1 ) ) .Or.;
									 ( !lBioLeg .And. TNF->TNF_ENTBIO == '1' ), 1, 2 )
		EndIf
		( cTRB )->NUMCRI := TN3->TN3_NUMCRI
		( cTRB )->NUMCRF := TN3->TN3_NUMCRF
		If lGera_SA
			( cTRB )->NUMSA  := TNF->TNF_NUMSA
			( cTRB )->ITEMSA := TNF->TNF_ITEMSA
		EndIf
		( cTRB )->NOMECOM	:= AllTrim( SubStr( aInfEmp[ 1, 1 ], 1, 60 ) )
		( cTRB )->CGC		:= AllTrim( aInfEmp[ 1, 2 ] )
		( cTRB )->FILIAL	:= AllTrim( xFilial( "SRA", cCodFil ) )
		( cTRB )->NOMFIL	:= AllTrim( cNomFil )
		( cTRB )->ENDENT	:= AllTrim( aInfEmp[ 1, 3 ] )
		( cTRB )->CIDENT	:= AllTrim( aInfEmp[ 1, 4 ] )
		( cTRB )->ESTENT	:= AllTrim( aInfEmp[ 1, 5 ] )
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} NGIMP805SIN
Impressao do relatorio sintérico

@param cCodFil - Codigo da Filial
@param cNomFil - Nome da Filial

@author Jackson Machado
@since 16/02/2011
@return Nil
/*/
//---------------------------------------------------------------------
User Function NGIMP805SIN()

	Local cFil      := ""
	Local lPrimvez  := .T.
	Local nRecnoAtu := 1

	dbSelectArea( cTRB )
	If mv_par08 == 1  //Matricula
		dbSetOrder( 1 )
	ElseIf mv_par08 == 2  //Nome Funcionario
		dbSetOrder( 2 )
	ElseIf mv_par08 == 3  //Cod. C. Custo
		dbSetOrder( 3 )
	ElseIf mv_par08 == 4  //Nome C. Custo
		dbSetOrder( 4 )
	EndIf

	dbGoTop()

	While !Eof()

		nRecnoAtu := Recno()

		cFil  := ( cTRB )->FILIAL
		CFUNC := ( cTRB )->FUNCI
		nVolta := 0
		SomaLinha()
		@ Li, 000 PSay " " + Replicate( "_", 219 )
		SomaLinha()
		@ Li, 000 PSay STR0010 //"|Funcionario.....:"
		@ Li, 019 PSay MDTHideCpo( AllTrim( CFUNC ), "TNF_MAT" ) + " - " + MDTHideCpo( ( cTRB )->NOME, "RA_NOME" )
		@ Li, 127 PSay STR0011 //"RG.:"
		@ Li, 132 PSay MDTHideCpo( ( cTRB )->RG, "RA_RG" ) PICTURE "@!"
		@ Li, 220 PSay "|"

		lLinha := .F.
		lFirst := .T.

		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 Psay "|"
		@ Li, 001 PSay STR0017     //"EPI"
		@ Li, 017 + nDist PSay STR0018     //"Nome do EPI"
		
		If MV_PAR19 == 1 //Não imprime Assinatura Lateral
		
			@ Li, 80 + nDist PSay STR0019     //"Dt. Entr"
			@ Li, 100 + nDist PSay STR0040     //"Hora"
			@ Li, 120 + nDist PSay STR0025     //"Qtde"
			@ Li, 140 + nDist PSay STR0026	   //"Num C.A."
			@ Li, 220 Psay "|"
			SomaLinha()
			@ Li, 000 Psay "|"

		Else

			@ Li, 100 + nDist PSay STR0019     //"Dt. Entr"
			@ Li, 120 + nDist PSay STR0025     //"Qtde"
			@ Li, 140 + nDist PSay STR0026	   //"Num C.A."
			@ Li, 220 Psay "|"
			SomaLinha()
			@ Li, 000 Psay "|"

		EndIf
		
		dbSelectArea( cTRB )
		While !Eof() .And. ( cTRB )->FUNCI == CFUNC .And. ( cTRB )->FILIAL == cFil
			cCodNumEpi := ( cTRB )->CODEPI
			cDescEpi := SubStr( AllTrim( ( cTRB )->DESEPI ), 1, 60 )
			cCodNumCap := ( cTRB )->NUMCAP

			If lLinha .And. lFirst
				@ Li, 220 Psay "|"
				Somalinha()
				@ Li, 000 PSay "|"
			EndIf
			If !lFirst
				Somalinha()
				@ Li, 000 PSay "|"
			EndIf
			lFirst := .F.
			@ Li, 001 PSAY cCodNumEpi
			@ Li, 017 + nDist PSay cDescEpi PICTURE "@!"

			If MV_PAR19 == 1 //Imprime data Entrega

				@ Li, 80 + nDist PSay ( cTRB )->DTENT PICTURE "99/99/9999"
				@ Li, 100 + nDist PSay ( cTRB )->HRENT PICTURE "99:99:99"
				@ Li, 120 + nDist PSay ( cTRB )->QTDE  PICTURE "@E 999.99"

				If !Empty( cCodNumCap )
					@ Li, 140 + nDist PSay cCodNumCap
				EndIf

				If mv_par18 == 1 .And. !Empty( ( cTRB )->DTRECI )//Imprime assinatura lateral

						If ( cTRB )->BIOMET == 2 .Or. Empty( ( cTRB )->BIOMET )
							@ Li, 160 + nDist PSay STR0076 //"Ass.: _________________"
						Else
							@ Li, 160 + nDist PSay STR0086 //"Registro Biométrico"
						EndIf				

				EndIf

			Else

				@ Li, 100 + nDist PSay ( cTRB )->DTRECI PICTURE "99/99/9999"
				@ Li, 120 + nDist PSay ( cTRB )->QTDE  PICTURE "@E 999.99"

				If !Empty( cCodNumCap )
					@ Li, 140 + nDist PSay cCodNumCap
				EndIf

				If mv_par18 == 1 .And. !Empty( ( cTRB )->DTRECI )//Imprime assinatura lateral

					If ( cTRB )->BIOMET == 2 .Or. Empty( ( cTRB )->BIOMET )
						@ Li, 160 + nDist PSay STR0076 //"Ass.: _________________"
					Else
						@ Li, 160 + nDist PSay STR0086 //"Registro Biométrico"
					EndIf				

				EndIf

			EndIf

			If lLinha
				@ Li, 220 Psay "|"
				Somalinha()
				@ Li, 000 Psay "|"
			EndIf

			nVolta++

			dbSelectArea( cTRB )
			Dbskip()
			@ Li, 220 Psay "|"
		ENDDO

		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay STR0036 //"|       Data : ____/____/____"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 220 PSay "|"
		SomaLinha()
		@ Li, 000 PSay STR0037 //"|       Assinatura: _______________________"
		@ Li, 127 PSay STR0088 //"Resp Empr: _______________________"
		@ Li, 220 Psay "|"
		SomaLinha()
		@ Li, 000 Psay "|"
		@ Li, 220 Psay "|"
		SomaLinha()
		@ Li, 000 PSay "|"
		@ Li, 001 PSay Replicate( "_", 219 )
		@ Li, 220 PSay "|"
		Li := 80
		If mv_par07 == 2 .And. lPrimvez
			dbSelectArea( cTRB )
			dbGoTo( nRecnoAtu )
			dbSkip( -( nVolta - 1 ) )
			lPrimvez := .F.
		Else
			dbSelectArea( cTRB )
			lPrimvez := .T.
		EndIf
	End

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fInfEmp
Busca as informações da empresa do funcionário a serem impressas no relatório

@return aDados, Array, Array contendo as informações da empresa do funcionário

@sample fInfEmp( "D MG 01 " )

@param cCodFil, Caracter, Código da filial do funcionário

@author	Luis Fellipy Bett
@since	22/09/2020
/*/
//-------------------------------------------------------------------
Static Function fInfEmp( cCodFil )

	Local aDados	:= {} //Dados da empresa do funcionário
	Local aAreaSM0	:= SM0->( GetArea() ) //Pega a empresa posicionada

	dbSelectArea( "SM0" )
	dbSeek( cEmpAnt + cCodFil )
	aAdd( aDados, { SM0->M0_NOMECOM, SM0->M0_CGC, SM0->M0_ENDENT, SM0->M0_CIDENT, SM0->M0_ESTENT } )

	RestArea( aAreaSM0 ) //Retorna a empresa posicionada

Return aDados
