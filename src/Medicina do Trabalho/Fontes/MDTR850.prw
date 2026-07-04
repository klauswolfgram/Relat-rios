/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr850.ch"
#Include "Protheus.ch"
#INCLUDE "MSOLE.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR850
Relatorio GERAL do PPRA
Este programa emite relatorio do Laudo do PPRA

@author  Thiago Olis Machado
@since   04/08/2001

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR850()

	//	Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM   := NGBEGINPRM()

	Private nTipoDoc    := 1                            //Indica que o documento é o PPRA
	Private cPathEst    := Alltrim( GetMv( "MV_DIREST" ) ) // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO
	Private cFiltroF    := Alltrim( SuperGetMv( "MV_NGCATFU", .F., " " ) )
	Private cCodEmpresa := FWGrpCompany()
	Private aFilRelat   := {}
	Private dDeLaudo    := ""
	Private	dAteLaudo   := ""
	Private cCodLaudo   := ""

	If FindFunction( 'MDTChkTJ7' )

		If  MDTChkTJ7() // Verifica o tamanho do campo TJ7_CODIGO
			U_MDTREL850()
		EndIf

	Else
		MsgStop( STR0507 ) //"Seu ambiente encontra-se desatualizado ou com inconsistências no campo Código (TJ7_CODIGO) da tabela de Serviços (TJ7). Favor atualizar o ambiente."
	EndIf

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTREL850
Funcao de Impressao do PPRA/PGR

@author  Denis Hyroshi de Souza
@since   04/08/2001
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTREL850()

	Local oRadOp
	Local oDLGppra
	Local i
	Local nOpcRel := 0

	SG90PLACAO()//Adequação do Plano de Ação.

	Private cPathBmp      	:= Alltrim( GetMv( "MV_DIRACA" ) )			// Path do arquivo logo .bmp do cliente
	Private lSigaMdtPS    	:= IIf( SuperGetMv( "MV_MDTPS", .F., "N" ) == "S", .T., .F. )
	Private nModeloImp    	:= 1
	Private cCliMdtPs     	:= " "
	Private aFuncionarios 	:= {}
	Private aFuncRisco    	:= {}
	Private nFuncRisco    	:= 0
	Private lMdtCC    	  	:= lMDT190CC()
	Private lMdtUmCC      	:= lMDT190UMCC()
	Private nSizeSI3      	:= IIf( ( TAMSX3( "I3_CUSTO" )[1]) < 1, 9, ( TAMSX3( "I3_CUSTO" )[1] ) )
	Private nSizeCli      	:= IIf( ( TAMSX3( "A1_COD" )[1]) < 1, 6, ( TAMSX3( "A1_COD" )[1] ) )
	Private nSizeLoj      	:= IIf( ( TAMSX3( "A1_LOJA" )[1]) < 1, 2, ( TAMSX3( "A1_LOJA" )[1] ) )
	Private cAliasCC      	:= "SI3"
	Private cDescrCC      	:= "SI3->I3_DESC"
	Private aNfrisco      	:= {}
	Private lMdtUnix      	:= IIf( GetRemoteType() == 2 .Or. isSRVunix(), .T., .F. ) //Verifica se servidor ou estacao é Linux
	Private titulo        	:= " "
	Private nQtdFunT      	:= 0
	Private lImpTodos     	:= .T.
	Private aVETINR       	:= {} //Usado pela funcao que cria arq. temporario
	Private cFiltroF      	:= Alltrim( SuperGetMv( "MV_NGCATFU", .F., "" ) )
	Private aImagens      	:= {}
	Private lCabec850     	:= .F.
	Private aTipoInsc     	:= {}
	Private nMvDepto 		:= 0 //Valor do pergunta Considerar Por?
	Private nImpImage 		:= 1 //Valor da pergunta Impressão de Imagens

	aTipoInsc := U_fTipoINSC()
	If Empty( aTipoInsc[1] )
		aTipoInsc[1] := STR0231 //"C.G.C."
	EndIf

	cPathEst := Alltrim( GetMv( "MV_DIREST" ) ) // PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHOZ

	If nTipoDoc == 1 //Indica se é PPRA OU PGR
		titulo := STR0229 //"Programa de Prevenção de Riscos Ambientais"
	Else
		titulo := STR0308 //"Programa de Gerenciamento de Riscos"
	EndIf

	If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
		cAliasCC := "CTT"
		cDescrCC := "CTT->CTT_DESC01"
	EndIf

	lRet  := .F.

	// "Modelo do Relatório" // "Selecione o modelo em que deve ser impresso o relatório." // "Padrão" // "Gráfico"
	nOpcRel := Aviso( STR0044 + ':', STR0627, { STR0228, STR0227, 'Word' }, 2 )

	Do Case
		Case nOpcRel == 3
			nModeloImp := 1
		Case nOpcRel == 1
			nModeloImp := 3
		Otherwise
			nModeloImp := 2
	EndCase

	If nModeloImp == 1
		U_fMDT850WOR()
	Else
		U_fMDT850PDR()
	EndIf

	For i:=1 To Len( aImagens )
		If File( aImagens[i][1] + "JPG" )
			Ferase( aImagens[i][1] + "JPG" ) //Apaga imagem extraida do repositorio
		EndIf
		If File( aImagens[i][1] + "BMP" )
			Ferase( aImagens[i][1] + "BMP" ) //Apaga imagem extraida do repositorio
		EndIf
	Next i

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fMDT850PDR
Relatorio padrao do PPRA.

@author
@since
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function fMDT850PDR()

	Local wnrel   := "MDTR850"
	Local limite  := 132
	Local cDesc1
	Local cDesc2
	Local cDesc3
	Local cString := "TO0"
	Local cF3CC   := "MDTPS4"  //SI3 apenas do cliente
	Local nXY     := 1

	Private lMdtCC   := lMDT190CC()
	Private nomeprog := "MDTR850"
	Private tamanho  := "M"
	Private aReturn  := { STR0004, 1, STR0005, 1, 2, 1, "", 1 } //### //"Zebrado"###"Administracao"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := "MDT85R"
	Private cabec1
	Private cabec2
	Private cFil     := FWCodFil()
	Private cLaudo   := ""

	//-------------------------------------------------------
	//|	Variaveis utilizadas para parametros				|
	//|	MDT850		01      ¦Laudo PPRA ?					|
	//|	MDT850		02      ¦Coordenador ?					|
	//|	MDT850		03      ¦Ordenar Riscos por: ?			|
	//|	MDT850		04      ¦Ordenar Equipamentos por: ?	|
	//|	MDT850		05      ¦Ordenar Plano de Ação por: ?	|
	//|	MDT850		06      ¦Imprime Qtd. Func. e Funcoes?	|
	//|	MDT850		07      ¦Imprimir imagens?				|
	//|	MDT850		08		¦Imprimir Data de Avaliação?	|
	//|-----------------------------------------------------|
	//|	MDT850		09      ¦De Centro de Custo?			|
	//|	MDT850		10      ¦Até Centro de Custo?			|
	//|-----------------------------------------------------|
	//|	MDT850 	 	11  	¦Considerar por?				|
	//|	MDT850 	 	12  	¦De Filial ?					|
	//|	MDT850 	 	12  	¦Até Filial ?					|
	//-------------------------------------------------------

	If !AliasInDic( 'TYH' )

		// "As perguntas do relatório estão desatualizadas, favor aplicar a atualização contida no pacote da issue DNG-1847"
		MsgStop( STR0503 )

	Else

		If nTipoDoc == 1 //Indica se é PPRA OU PGR
			cDesc1  := STR0311 + STR0229 //"Programa de Prevenção de Riscos Ambientais" //"PPRA - "
		Else
			cDesc1  := STR0312 + STR0308 //"Programa de Gerenciamento de Riscos" //"PGR - "
		EndIf
		cDesc2  := STR0002 //"Atraves dos parametros selecionar os itens que devem ser considerados"
		cDesc3  := STR0003 //"no Relatorio.                                                        "

		If Alltrim( GetMV( "MV_MCONTAB" ) ) == "CTB"
			cF3CC := "MDTPS6"  //CTT apenas do cliente
		EndIf

		// Verifica as perguntas selecionadas
		pergunte( cPerg, .F. )

		// Envia controle para a funcao SETPRINT
		wnrel:=SetPrint( cString, wnrel, cPerg, titulo, cDesc1, cDesc2, cDesc3, .F., "" )

		If nLastKey == 27
			Set Filter To
			Return
		EndIf

		SetDefault( aReturn, cString )

		If nLastKey == 27
			Set Filter To
			Return
		EndIf

		aFilRelat := aClone( fBuscaFiliais( nModeloImp ) )

		If nModeloImp == 2
			RptStatus( { |lEnd| R850Imp( @lEnd, wnRel, titulo, tamanho ) }, titulo )
		Else
			RptStatus( { |lEnd| R850Grf( @lEnd, wnRel, titulo, tamanho ) }, titulo )
		EndIf
	EndIf

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R850Imp
Chamada do Relatório padrão

@author  Thiago Olis Machado
@since   04/08/2001

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caractere, Código do relatório
@param   titulo, Caracatere, Título do relatório
@param   tamanho, Caractere, Tamanho do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function R850Imp( lEnd, wnRel, titulo, tamanho )

	Local cMemo    	 := " "
	Local cTitulo  	 := " "
	Local cTexto   	 := " "
	Local lEof     	 := .T.
	Local nX
	Local nLenMemo 	 := 0
	Local nPerMemo 	 := 0
	Local cEmp
	Local cFilSM0    := ""
	Local nXY        := 0

	Private lPrint   := .T.
	Private lPrin2   := .T.
	Private lFirst   := .T.
	Private lJumpCab := .T.
	Private lIdentar := .F.
	Private aRiscos  := {}
	Private aEpis    := {}
	Private aExames  := {}
	Private li       := 80
	Private m_pag    := 1

	fPerguntas() // Restaura a ordem dos parâmetros

	nMvDepto := mv_par11
	lImpTodos := mv_par06 == 1
	nImpImage := mv_par07

	// Verifica se deve comprimir ou nao
	nTipo  := IIf( aReturn[4] == 1, 15, 18 )

	cabec1 := " "
	cabec2 := " "

	cEmp    := FWGrpCompany()
	cFilSM0 := FWCodFil()

	For nXY := 1 To Len( aFilRelat )
		lEof    := .T.
		cFil    := aFilRelat[nXY][1]

		dDeLaudo  := SToD(aFilRelat[nXY][4])
		dAteLaudo := SToD(aFilRelat[nXY][5])
		cCodLaudo := aFilRelat[nXY][3]
		If nXY == 1 .Or. IIf( nXY == 1, .T., aFilRelat[nXY][1] != aFilRelat[nXY - 1][1] )
			nQtdFunT := 0
			nQtdFunT += fQtdFunRis( aFilRelat[nXY][1] ) //Retorna quantidade de funcionarios expostos a riscos
		EndIf

		dbselectarea( "TO0" )
		dbsetorder( 1 )
		dbGoTop()
		MsSeek( xFilial( "TO0", cFil ) + cCodLaudo )

		Dbselectarea( "SM0" )
		Dbsetorder( 1 )
		MsSeek( cEmp + cFilSM0 )

		cCidade   := Alltrim( SM0->M0_CIDCOB ) + IIf( !Empty( SM0->M0_ESTCOB ), "-" + SM0->M0_ESTCOB, " " )
		cCidadeRe := Capital( Alltrim( SM0->M0_CIDCOB ) )
		cEmp_Nome := SM0->M0_NOMECOM
		cEmp_Cnpj := aTipoInsc[2] //SM0->M0_CGC
		cEmp_Endr := SM0->M0_ENDCOB
		cEmp_Bair := SM0->M0_BAIRCOB
		cEmp_Insc := SM0->M0_INSC
		cEmp_Cnae := SM0->M0_CNAE

		SomaLinha()
		SomaLinha()
		SomaLinha()
		SomaLinha()
		If nTipoDoc == 1 //Indica se é PPRA OU PGR
			@ LI, 000 PSay "                                     " + STR0045 //"PROGRAMA DE PREVENÇÃO DE RISCOS AMBIENTAIS - PPRA"
		Else
			@ LI, 000 PSay "                                        " + Upper( STR0308 ) + STR0319 //"PROGRAMA DE GERENCIAMENTO DE RISCOS" //" - PGR"
		EndIf
		Somalinha()
		Somalinha()
		Somalinha()
		@ Li, 000 Psay STR0046 + " "+cEmp_Nome //"NOME DA EMPRESA :"
		SomaLinha()
		@ Li, 000 Psay STR0047 + " " + cEmp_Endr //"ENDERECO :"
		SomaLinha()
		@ Li, 000 Psay STR0048 + " " + cCidade //"CIDADE :"
		SomaLinha()
		@ Li, 000 Psay STR0119 + cEmp_Bair  //"BAIRRO : "
		SomaLinha()
		@ Li, 000 Psay aTipoInsc[1] + " " + cEmp_Cnpj //"CNPJ :"## ou ##"CGC :"
		SomaLinha()
		@ Li, 000 Psay STR0050 + cEmp_Insc //"INSCRIÇÃO ESTADUAL : "
		SomaLinha()
		@ Li, 000 Psay STR0052 + cEmp_Cnae //"CNAE : "
		SomaLinha()
		@ Li, 000 Psay STR0051 + " " + TO0->TO0_GRISCO //"GRAU DE RISCO :"
		SomaLinha()
		@ Li, 000 Psay STR0310 + ": " + Alltrim( Str( IIf( nQtdFunT == 0, TO0->TO0_QTDFUN, nQtdFunT ), 9 ) ) //"Nº de Funcionários"
		If lMdtCC
			If Empty( mv_par09 ) .And. mv_par10 <> Replicate( "Z", Len( mv_par10 ) )
				If Empty( mv_par10 )
						cDescCapa := "Todos"
				Else
					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) )
					cDescCapa := Alltrim( &(cDescrCC) )

					cDescCapa += " até "

					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
					cDescCapa += Alltrim( &(cDescrCC) )
				EndIf
			ElseIf !Empty( mv_par09 ) .And. mv_par10 == Replicate( "Z", Len( mv_par10 ) )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par09 )
				cDescCapa := Alltrim( &(cDescrCC) )

				cDescCapa += " até "

				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
				dbSkip( -1 )
				cDescCapa := Alltrim( &(cDescrCC) )
			ElseIf !Empty( mv_par09 ) .And. mv_par10 <> Replicate( "Z", Len( mv_par10 ) )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par09 )
				cDescCapa := Alltrim( &(cDescrCC) )

				cDescCapa += " até "

				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
				cDescCapa += Alltrim( &(cDescrCC) )
			Else
				cDescCapa := "Todos"
			EndIf
				SomaLinha()
				@ Li, 000 Psay STR0065 + " " + cDescCapa //"Centro de Custo:"
		Else
			dbSelectArea( cAliasCC )
			dbSetOrder( 1 )
			If MsSeek( xFilial( cAliasCC, cFil ) + mv_par09 ) .And. !Empty( Mv_par09 ) .And. lMdtUmCC
				SomaLinha()
				@ Li, 000 Psay STR0065 + " " + &(cDescrCC) //"Centro de Custo:"
			EndIf

		EndIf
		Somalinha()
		SomaLinha()
		SomaLinha()

		cMemo := Alltrim( TO0->TO0_DESCRI )
			If !Empty( TO0->TO0_MMSYP2 )
				cMMSYP2 := MSMM( TO0->TO0_MMSYP2, 80 )
				If !Empty( cMMSYP2 )
					If !Empty( cMemo )
						cMemo += Chr( 13 ) + Chr( 10 )
					EndIf
					cMemo += cMMSYP2
				EndIf
			ELseIf TO0->( FieldPos( "TO0_DESC2" ) ) > 0 .And. !Empty( TO0->TO0_DESC2 )
				If !Empty( cMemo )
					cMemo += Chr( 13 ) + Chr( 10 )
				EndIf
				cMemo += Alltrim( TO0->TO0_DESC2 )
			EndIf

		SetRegua( 100 )
		nLenMemo := Len( cMemo )
		nPerMemo := 0

		While lEof
			If Empty( cMemo )  //Memo vazio
				lEof := .F.
				Exit
			Else
				nPos1 := At( "#", cMemo ) //Inicio de um Titulo

				If nPos1 > 1
					cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
					cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
					U_IMPDOC850( Alltrim( cTexto ) )
					fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua
					Loop
				ElseIf nPos1 == 1 //Existe #
					cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )
					nPos1   := At( "#", cMemo )
					cTitulo := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
					cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )

					nPos1   := At( "#", cMemo )
					If nPos1 > 0
						cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
						cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
					Else
						cTexto := Alltrim( cMemo )
						cMemo  := " "
						lEof   := .F.
					EndIf
				Else //Nao existe #
					//IMPRIME TEXTO
					U_IMPDOC850( Alltrim( cMemo ) )
					lEof := .F.
					Exit
				EndIf

				//IMPRIME TITULO
				If !Empty( cTitulo )
					U_IMPHEA850( cTitulo )
				EndIf

				//IMPRIME TEXTO
				If !Empty( cTexto )
					lPrint := .T.
					lPrin2 := .T.
					U_IMPDOC850( Alltrim( cTexto ) )
				EndIf

			EndIf

			fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua

		End

		cTxtMemo := " "
		DbSelectArea( "TMZ" )
		dbSetOrder( 1 )
		IF MsSeek( xFilial( "TMZ", cFil ) + TO0->TO0_TERMO )
			cTxtMemo := TMZ->TMZ_DESCRI
		EndIf

		Dbselectarea( "TMK" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TMK", cFil ) + Mv_par02 )

		If Li != 6 // Não for a primeira linha

			Li := 80
			Somalinha()

		EndIf

		@Li, 048 Psay STR0053 //"RESPONSÁVEIS TÉCNICOS"
		For nX := 1 To 3
			Somalinha()
		Next nX

		U_IMPDOC850( Alltrim( cTxtMemo ) )
		Somalinha()
		Somalinha()
		Somalinha()
		@li, 000 Psay (STR0054 + " " + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) )) //"COORDENADOR:"

		Somalinha()
		@li, 000 Psay (STR0055 + " " + Alltrim( TMK->TMK_REGMTB )) //"REG.SSST:"

		If !Empty( TMK->TMK_NUMENT )
			Somalinha()
			@li, 000 Psay (IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ) + Alltrim( TMK->TMK_NUMENT ))
		EndIf

		Somalinha()
		@li, 000 Psay (STR0057 + " " + Alltrim( TMK->TMK_TELUSU )) //"FONE:"

		Somalinha()
		@li, 000 Psay (STR0058 + " " + Alltrim( TMK->TMK_ENDUSU )) //"ENDEREÇO:"

		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TMK", cFil ) + TO0->TO0_CODUSU )

		SomaLinha()
		SomaLinha()
		@li, 000 Psay (STR0120 + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ))  //"RESPONSÁVEL: "

		If !Empty( TMK->TMK_NUMENT )
			Somalinha()
			@li, 000 Psay (IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ) + Alltrim( TMK->TMK_NUMENT ))
		EndIf

		Somalinha()
		@li, 000 Psay (STR0057 + " " + Alltrim( TMK->TMK_TELUSU )) //"FONE:"

		Somalinha()
		@li, 000 Psay (STR0058 + " " + Alltrim( TMK->TMK_ENDUSU )) //"ENDEREÇO:"

		For nX := 1 To 3
			Somalinha()
		Next nX
		@li, 000 Psay cCidadeRe + ", " + StrZero( Day( dDataBase ), 2 ) + STR0015 + MesExtenso( dDataBase ) + STR0015+; //" de "###" de "
					StrZero( Year( dDataBase ), 4 ) + "."

		Somalinha()
		@li, 000 Psay (STR0059 + " " + Alltrim( Transform( Date(), "99/99/9999" ) )) //"DATA:"
		For nX := 1 To 5
			Somalinha()
		Next nX

		Somalinha()
		@li, 000 Psay (STR0121 + "___________________________________________")  //"Ass.: "
	Next nXY

	// 	Devolve a condicao original do arquivo principal
	RetIndex( "TO0" )
	Set Filter To
	Set device To Screen
	If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool( wnrel )
	EndIf
	MS_FLUSH()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R850Grf
Chamada do Relatório Gráfico
@author  Denis Hyroshi de Souza
@since   04/03/2009

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caractere, Código do relatório
@param   titulo, Caracatere, Título do relatório
@param   tamanho, Caractere, Tamanho do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function R850Grf( lEnd, wnRel, titulo, tamanho )

	Local cMemo    := " "
	Local cTitulo  := " "
	Local cTexto   := " "
	Local lEof     := .T.
	Local nXY      := 0
	Local nLenMemo := 0
	Local nPerMemo := 0
	Local cSMCOD   := FWGrpCompany()
	Local cFilSM0  := FWCodFil()

	Private lPrint 		:= .T.
	Private lPrin2 		:= .T.
	Private lFirst 		:= .T.
	Private lJumpCab 	:= .T.
	Private lIdentar 	:= .F.
	Private aRiscos    	:= {}
	Private aEpis      	:= {}
	Private aExames    	:= {}
	Private nPaginaG   	:= 0

	Private oFont08		:= TFont():New( "Verdana", 08, 08, , .F., , , , .F., .F. )
	Private oFont08b	:= TFont():New( "Verdana", 08, 08, , .T., , , , .F., .F. )
	Private oFont10b	:= TFont():New( "Verdana", 10, 10, , .T., , , , .F., .F. )
	Private oFont10		:= TFont():New( "Verdana", 10, 10, , .F., , , , .F., .F. )
	Private oFont12b	:= TFont():New( "Verdana", 12, 12, , .T., , , , .F., .F. )
	Private oFont12 	:= TFont():New( "Verdana", 12, 12, , .F., , , , .F., .F. )
	Private oFont12bs	:= TFont():New( "Verdana", 12, 12, , .T., , , , .T., .T. )
	Private oFont12s	:= TFont():New( "Verdana", 12, 12, , .F., , , , .T., .T. )
	Private oFont28b	:= TFont():New( "Verdana", 28, 28, , .T., , , , .F., .F. )
	Private oFont50b	:= TFont():New( "Verdana", 50, 50, , .T., , , , .F., .F. )

	fPerguntas() // Restaura a ordem dos parâmetros

	nMvDepto := mv_par11
	lImpTodos := mv_par06 == 1
	nImpImage := mv_par07

	fPerguntas() // Restaura a ordem dos parâmetros

	If nTipoDoc == 1 //Indica se é PPRA OU PGR
		oPrintPPRA	:= TMSPrinter():New( OemToAnsi( STR0045 ) ) //"PROGRAMA DE PREVENÇÃO DE RISCOS AMBIENTAIS - PPRA"
	Else
		oPrintPPRA	:= TMSPrinter():New( OemToAnsi( Upper( STR0308 ) + STR0319 ) ) //"PROGRAMA DE GERENCIAMENTO DE RISCOS" //" - PGR"
	EndIf
	oPrintPPRA:Setup()
	oPrintPPRA:SetPortrait() // Seta Retrato como padrão

	// Contadores de linha e pagina
	Private lin   := 9999
	Private m_pag := 1

	//Caminho do logoppp.bmp
	Private cStartDir := AllTrim( GetSrvProfString( "StartPath", "\" ) )
	Private cStartLogo := " "

	If File( cStartDir + "LGRL" + cSMCOD + cFil + ".BMP" )
		cStartLogo := cStartDir + "LGRL" + cSMCOD + cFil + ".BMP"
	ElseIf File( cStartDir + "LGRL" + cSMCOD + ".BMP" )
		cStartLogo := cStartDir + "LGRL" + cSMCOD + ".BMP"
	EndIf

	//	Verifica se deve comprimir ou nao
	nTipo  := IIf( aReturn[4] == 1, 15, 18 )

	cabec1 := " "
	cabec2 := " "

	For nXY := 1 To Len( aFilRelat )
		lEof := .T.
		cFil := aFilRelat[nXY][1]
		dDeLaudo  := SToD(aFilRelat[nXY][4])
		dAteLaudo := SToD(aFilRelat[nXY][5])
		cCodLaudo := aFilRelat[nXY][3]
		If nXY == 1 .Or. IIf( nXY == 1, .T., aFilRelat[nXY][1] != aFilRelat[nXY - 1][1] )
			nQtdFunT := 0
			nQtdFunT += fQtdFunRis( aFilRelat[nXY][1] ) //Retorna quantidade de funcionarios expostos a riscos
		EndIf
		dbSelectArea( "TO0" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TO0", cFil ) + cCodLaudo )

		Dbselectarea( "SM0" )
		dbSetOrder( 1 )
		MsSeek( cSMCOD + cFilSM0 )

		cCidade   := Alltrim( SM0->M0_CIDCOB ) + IIf( !Empty( SM0->M0_ESTCOB ), "-" + SM0->M0_ESTCOB, " " )
		cCidadeRe := Capital( Alltrim( SM0->M0_CIDCOB ) )
		cEmp_Nome := SM0->M0_NOMECOM
		cEmp_Cnpj := aTipoInsc[2]//SM0->M0_CGC
		cEmp_Endr := SM0->M0_ENDCOB
		cEmp_Bair := SM0->M0_BAIRCOB
		cEmp_Insc := SM0->M0_INSC
		cEmp_Cnae := SM0->M0_CNAE

		cTitPPRA := " "
		If nTipoDoc == 1 //Indica se é PPRA OU PGR
			cTitPPRA := STR0229 //"Programa de Prevenção de Riscos Ambientais"
		Else
			cTitPPRA := STR0308 //"Programa de Gerenciamento de Riscos"
		EndIf

		SomaLinha( 150 )
		If nTipoDoc == 1 //Indica se é PPRA OU PGR
			oPrintPPRA:Say( 700, 1000, STR0320, oFont50b ) //"PPRA"
		Else
			oPrintPPRA:Say( 700, 1000, STR0321, oFont50b ) //"PGR"
		EndIf
		oPrintPPRA:Say( 1200, 400, MemoLine( cTitPPRA, 32, 1 ), oFont28b )
		oPrintPPRA:Say( 1400, 980, MemoLine( cTitPPRA, 32, 2 ), oFont28b )

		oPrintPPRA:Say( 2340, 150, STR0230 + ":", oFont12b ) //"EMPRESA"
		oPrintPPRA:Say( 2340, 600, cEmp_Nome, oFont12 )
		oPrintPPRA:Say( 2420, 150, aTipoInsc[1] + " ", oFont12b ) //"CGC :" ## ou ## "CNPJ :"
		oPrintPPRA:Say( 2420, 600, cEmp_Cnpj, oFont12 )
		oPrintPPRA:Say( 2500, 150, Upper( STR0232 ) + ":", oFont12b ) //"Cidade"
		oPrintPPRA:Say( 2500, 600, cCidade, oFont12 )

		lin := 9999 //Forçar quebra de pagina
		Somalinha( 150 )
		oPrintPPRA:Say( lin, 150, "1. " + STR0233, oFont12b ) //"IDENTIFICAÇÃO DA EMPRESA"
		Somalinha( 80 )
		oPrintPPRA:Say( lin, 150, STR0234 + ":", oFont10b ) //"Razão Social"
		oPrintPPRA:Say( lin, 600, cEmp_Nome, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, aTipoInsc[1] + " ", oFont10b ) //"CNPJ :"
		oPrintPPRA:Say( lin, 600, cEmp_Cnpj, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0236 + ":", oFont10b ) //"Inscrição Estadual"
		oPrintPPRA:Say( lin, 600, cEmp_Insc, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0237 + ":", oFont10b ) //"Endereço"
		oPrintPPRA:Say( lin, 600, cEmp_Endr, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0238 + ":", oFont10b )  //"Bairro"
		oPrintPPRA:Say( lin, 600, cEmp_Bair, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0232 + ":", oFont10b ) //"Cidade"
		oPrintPPRA:Say( lin, 600, cCidade, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0239 + ":", oFont10b ) //"CNAE"
		oPrintPPRA:Say( lin, 600, cEmp_Cnae, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0240 + ":", oFont10b ) //"Grau de Risco"
		oPrintPPRA:Say( lin, 600, TO0->TO0_GRISCO, oFont10 )
		SomaLinha()
		oPrintPPRA:Say( lin, 150, STR0310 + ":", oFont10b ) //"Nº de Funcionários"
		oPrintPPRA:Say( lin, 600, Alltrim( Str( IIf( nQtdFunT == 0, TO0->TO0_QTDFUN, nQtdFunT ), 9 ) ), oFont10 )

		If lMdtCC
			If Empty( mv_par09 ) .And. mv_par10 <> Replicate( "Z", Len( mv_par10 ) )
				If Empty( mv_par10 )
					cDescCapa := "Todos"
				Else
					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) )
					cDescCapa := Alltrim( &(cDescrCC) )

					cDescCapa += " até "

					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
					cDescCapa += Alltrim( &(cDescrCC) )
				EndIf
			ElseIf !Empty( mv_par09 ) .And. mv_par10 == Replicate( "Z", Len( mv_par10 ) )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par09 )
				cDescCapa := Alltrim( &(cDescrCC) )

				cDescCapa += " até "

				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
				dbSkip( -1 )
				cDescCapa := Alltrim( &(cDescrCC) )
			ElseIf !Empty( mv_par09 ) .And. mv_par10 <> Replicate( "Z", Len( mv_par10 ) )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par09 )
				cDescCapa := Alltrim( &(cDescrCC) )

				cDescCapa += " até "

				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + mv_par10 )
				cDescCapa += Alltrim( &(cDescrCC) )
			Else
				cDescCapa := "Todos"
			EndIf
			SomaLinha()
			oPrintPPRA:Say( lin, 150, STR0065 + " ", oFont10b ) //"Centro de Custo:"
			oPrintPPRA:Say( lin, 600, Alltrim( cDescCapa ), oFont10 )
		Else
			dbSelectArea( cAliasCC )
			dbSetOrder( 1 )
			If MsSeek( xFilial( cAliasCC, cFil ) + Mv_par09 ) .And. !Empty( Mv_par09 ) .And. lMdtUmCC
				SomaLinha()
				oPrintPPRA:Say( lin, 150, STR0065 + " ", oFont10b ) //"Centro de Custo:"
				oPrintPPRA:Say( lin, 600, Alltrim( &(cDescrCC) ), oFont10 )
			EndIf
		EndIf
		Somalinha( 120 )

		cMemo := Alltrim( TO0->TO0_DESCRI )
		If !Empty( TO0->TO0_MMSYP2 )
			cMMSYP2 := MSMM( TO0->TO0_MMSYP2, 80 )
			If !Empty( cMMSYP2 )
				If !Empty( cMemo )
					cMemo += Chr( 13 ) + Chr( 10 )
				EndIf
				cMemo += cMMSYP2
			EndIf
		ELseIf TO0->( FieldPos( "TO0_DESC2" ) ) > 0 .And. !Empty( TO0->TO0_DESC2 )
			If !Empty( cMemo )
				cMemo += Chr( 13 ) + Chr( 10 )
			EndIf
			cMemo += Alltrim( TO0->TO0_DESC2 )
		EndIf

		SetRegua( 100 )
		nLenMemo := Len( cMemo )
		nPerMemo := 0

		While lEof
			If Empty( cMemo )  //Memo vazio
				lEof := .F.
				Exit
			Else
				nPos1 := At( "#", cMemo ) //Inicio de um Titulo

				If nPos1 > 1
					cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
					cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
					U_IMPDOC850( Alltrim( cTexto ) )
					fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua
					Loop
				ElseIf nPos1 == 1 //Existe #
					cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )
					nPos1   := At( "#", cMemo )
					cTitulo := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
					cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )

					nPos1   := At( "#", cMemo )
					If nPos1 > 0
						cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
						cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
					Else
						cTexto := Alltrim( cMemo )
						cMemo  := " "
						lEof   := .F.
					EndIf
				Else //Nao existe #
					//IMPRIME TEXTO
					U_IMPDOC850( Alltrim( cMemo ) )
					lEof := .F.
					Exit
				EndIf

				//IMPRIME TITULO
				If !Empty( cTitulo )
					U_IMPHEA850( cTitulo )
				EndIf

				//IMPRIME TEXTO
				If !Empty( cTexto )
					lPrint := .T.
					lPrin2 := .T.
					U_IMPDOC850( Alltrim( cTexto ) )
				EndIf

			EndIf

			fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua

		EndDo

		cTxtMemo := " "
		DbSelectArea( "TMZ" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "TMZ", cFil ) + TO0->TO0_TERMO )
			cTxtMemo := TMZ->TMZ_DESCRI
		EndIf

		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TMK", cFil ) + Mv_par02 )

		If Lin != 300 .And. Lin != 360 // Não for a primeira linha

			Lin := 9999
			Somalinha()

		EndIf

		oPrintPPRA:Say( lin, 1000, STR0053, oFont12b ) //"RESPONSÁVEIS TÉCNICOS"

		Somalinha( 180 )
		U_IMPDOC850( Alltrim( cTxtMemo ) )

		Somalinha( 180 )
		oPrintPPRA:Say( lin, 100, STR0054, oFont12b ) //"COORDENADOR:"
		oPrintPPRA:Say( lin, 600, Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont12 )

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0055, oFont12b ) //"REG.SSST:"
		oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_REGMTB ), oFont12 )

		If !Empty( TMK->TMK_NUMENT )
			Somalinha()
			oPrintPPRA:Say( lin, 100, IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ), oFont12b )
			oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_NUMENT ), oFont12 )
		EndIf

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0057, oFont12b ) //"FONE:"
		oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_TELUSU ), oFont12 )

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0058, oFont12b ) //"ENDEREÇO:"
		oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_ENDUSU ), oFont12 )

		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TMK", cFil ) + TO0->TO0_CODUSU )

		SomaLinha( 120 )
		oPrintPPRA:Say( lin, 100, STR0120, oFont12b ) //"RESPONSÁVEL: "
		oPrintPPRA:Say( lin, 600, Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont12 )

		If !Empty( TMK->TMK_NUMENT )
			Somalinha()
			oPrintPPRA:Say( lin, 100, IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ), oFont12b )
			oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_NUMENT ), oFont12 )
		EndIf

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0057, oFont12b ) //"FONE: "
		oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_TELUSU ), oFont12 )

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0058, oFont12b ) //"ENDEREÇO:"
		oPrintPPRA:Say( lin, 600, Alltrim( TMK->TMK_ENDUSU ), oFont12 )

		Somalinha( 180 )
		cTxtTmp := cCidadeRe + ", " + StrZero( Day( dDataBase ), 2 ) + STR0015 + MesExtenso( dDataBase ) + STR0015 + StrZero( Year( dDataBase ), 4 ) + "." //" de "###" de "
		oPrintPPRA:Say( lin, 100, cTxtTmp, oFont12b )

		Somalinha()
		oPrintPPRA:Say( lin, 100, STR0059, oFont12b ) //"DATA:"
		oPrintPPRA:Say( lin, 300, Alltrim( Transform( Date(), "99/99/9999" ) ), oFont12 )

		Somalinha( 300 )
		oPrintPPRA:Say( lin, 100, STR0121 + "___________________________________________", oFont12 ) //"Ass.: "

	Next nXY

	If aReturn[5] == 1
		oPrintPPRA:Preview()
	Else
		oPrintPPRA:Print()
	EndIf

	//	Devolve a condicao original do arquivo principal
	RetIndex( "TO0" )
	Set Filter To

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@author Inacio Luiz Kolling
@since 01/06/1997
@sample Somalinha( 1 )
@param nLin__ - Linha posicionada

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function Somalinha( nLin__ )

	If nModeloImp == 1
		OLE_ExecuteMacro( oWord, "Somalinha" )
	ElseIf nModeloImp == 2
		Li++
		If Li > 76
			Cabec( titulo, cabec1, cabec2, nomeprog, tamanho, nTipo, , .F. )
		EndIf
	ElseIf nModeloImp == 3
		If ValType( nLin__ ) == "N"
			Lin += nLin__
		Else
			Lin += 60
		EndIf
		If Lin > 3100
			Lin := 300
			If nPaginaG > 0
				oPrintPPRA:EndPage()
			EndIf
			oPrintPPRA:StartPage()
			nPaginaG++
			If nPaginaG != 1
				oPrintPPRA:Say( 100, 2320, Alltrim( Str( nPaginaG, 10 ) ), oFont08 )
			EndIf
			If !Empty( cStartLogo ) .And. File( cStartLogo )
				oPrintPPRA:SayBitMap( 100, 150, cStartLogo, 300, 150 )
			EndIf
		EndIf
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fMDT850WOR
Relatorio do PPRA (Word)

@author  Denis Hyroshi de Souza
@since   17/09/2003

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function fMDT850WOR()

	Local cF3CC := "MDTPS4"  //SI3 apenas do cliente
	Local nXY   := 0
	Private cPerg := "MDT85R"

	//---------------------------------------------------------------
	//| Variaveis utilizadas para parametros MDT85R                 |
	//| MDT85R		01          // Laudo                            |
	//| MDT85R		02          // Coordenador                      |
	//| MDT85R		03 			// Impressao						|
	//| MDT85R		04 			// Arquivo de Saida					|
	//| MDT85R		05          // Ordenar riscos por        		|
	//| MDT85R		06          // Ordenar equipamentos por  		|
	//| MDT85R		07        	// Ordenar plano de acao por 		|
	//| MDT85R		08        	// Imprime Qtd. Func. e Funcoes?	|
	//| MDT85R		09			// Imprimir imagens?  		        |
	//| MDT85R		10			// Imprimir Data de Avaliacao?		|
	//|-------------------------------------------------------------|
	//|	MDT85R		11          // De Centro de Custo?          	|
	//|	MDT85R		12          // Até Centro de Custo?          	|
	//|-------------------------------------------------------------|
	//| MDT85R 	 	13			// Considerar por?					|
	//| MDT85R 	 	13			// De Filial?						|
	//| MDT85R 	 	13			// Até Filial?						|
	//---------------------------------------------------------------

	If !AliasInDic( 'TYH' )
		// "As perguntas do relatório estão desatualizadas, favor aplicar a atualização contida no pacote da issue DNG-1847"
		MsgStop( STR0503 )

	ElseIf Pergunte( cPerg, .T. )

		fPerguntas() // Restaura a ordem dos parâmetros

		If Alltrim( GetMV( "MV_MCONTAB" ) ) == "CTB"
			cF3CC := "MDTPS6"  //CTT apenas do cliente
		EndIf

		// A pergunta Considerar Por? pode ou não existir e pode ser a mv_ par13 ou 12
		nMvDepto := mv_par13

		lImpTodos := (mv_par08 == 1) //"Imprime Qtd. Func. e Funcoes?"
		nImpImage := mv_par09 //"Imprimir imagens?"

		aFilRelat := aClone( fBuscaFiliais( nModeloImp ) )

		RptStatus( { |lEnd| U_fWORD850() }, titulo )

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fWORD850
Impressao do relatorio (Word)

@author  Denis Hyroshi de Souza
@since   08/04/2003

@return  Lógico, Sempre Verdadiro
/*/
//-------------------------------------------------------------------
User Function fWORD850( )

	Local cMemo := ' '
	Local cTexto := ' '
	Local cSMFIL := FWCodFil()
	Local cSMCOD := FWGrpCompany()
	Local cTitulo := ' '
	Local cBarraRem := '\'
	Local cBarraSrv := '\'
	Local cArqSaida := IIf( Empty( mv_par04 ), 'Documento1', AllTrim( mv_par04 ) ) // Nome do arquivo de saida

	Local lEof := .T.

	Local nLinha
	Local nXY := 1
	Local nLenMemo := 0
	Local nPerMemo := 0

	Private aEpis := {}
	Private aRiscos := {}
	Private aExames := {}

	Private cVar := 'cVAR'
	Private cVar1 := 'cTIT'
	Private cArqDot := 'ppra.dotm' // Nome do arquivo modelo do Word (Tem que ser .dot)
	Private cArqBmp := 'LGRL' + cSMCOD + cSMFIL + '.BMP' // Nome do arquivo logo do cliente
	Private cArqBmp2 := 'LGRL' + cSMCOD + '.BMP' // Nome do arquivo logo do cliente
	Private cPathDot := Alltrim( GetMv( 'MV_DIRACA' ) ) // Path do arquivo modelo do Word
	Private cPathBmp := Alltrim( GetMv( 'MV_DIRACA' ) )	// Path do arquivo logo .bmp do cliente
	Private cPathBm2 := cPathBmp
	Private cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
	Private cFileLogo := ''

	Private lCriaIndice := .F.
	Private lPrint := .T.
	Private lPrin2 := .T.
	Private lFirst := .T.
	Private lJumpCab := .T.
	Private lIdentar := .F.
	Private lImpress := IIf( mv_par03 == 1, .T., .F. ) // Verifica se a saida será em Tela ou Impressora

	Private nVar := 1
	Private nVar1 := 1

	Private oWord

	cRootPath := IIf( RIGHT( cRootPath, 1 ) == cBarraSRV, SubStr( cRootPath, 1, Len( cRootPath ) - 1 ), cRootPath )

	If nTipoDoc == 2 //Indica se é PPRA OU PGR
		cArqDot  := 'pgr.dotm'
	EndIf

	If GetRemoteType() == 2  //estacao com sistema operacional unix
		cBarraRem := "/"
	EndIf
	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	EndIf

	cPathDot += IIf( Substr( cPathDot, Len( cPathDot ), 1 ) != cBarraSrv, cBarraSrv, "" ) + cArqDot
	cPathEst += IIf( Substr( cPathEst, Len( cPathEst ), 1 ) != cBarraRem, cBarraRem, "" )

	cPathBmp += IIf( Substr( cPathBmp, Len( cPathBmp ), 1 ) != cBarraSrv, cBarraSrv, "" ) + cArqBmp
	cPathBm2 += IIf( Substr( cPathBm2, Len( cPathBm2 ), 1 ) != cBarraSrv, cBarraSrv, "" ) + cArqBmp2

	//Cria diretorio se nao existir
	MontaDir( cPathEst )

	//Se existir .dot na estacao, apaga!
	If File( cPathEst + cArqDot )
		Ferase( cPathEst + cArqDot )
	EndIf
	If !File( cPathDot )
		If nTipoDoc == 1 //Indica se é PPRA OU PGR
			MsgStop( STR0123 + Chr( 10 ) + STR0124, STR0125 )  //"O arquivo ppra.dot não foi encontrado no servidor."  //"Verificar o parâmetro 'MV_DIRACA'."  //"ATENÇÃO"
		Else
			MsgStop( STR0309 + Chr( 10 ) + STR0124, STR0125 ) //"Verificar o parâmetro 'MV_DIRACA'."  //"ATENÇÃO" //"O arquivo pgr.dot não foi encontrado no servidor."
		EndIf
		Return
	EndIf
	CpyS2T( cPathDot, cPathEst, .T. ) 	// Copia do Server para o Remote, eh necessario
	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP
	//__copyfile(cPathDot,cPathEst+cArqDot)
	//Logo
	//Se existir .bmp na estacao, apaga!
	If File( cPathBmp )
		If File( cPathEst + cArqBmp )
			Ferase( cPathEst + cArqBmp )
		EndIf
		__copyfile( cPathBmp, cPathEst + cArqBmp )
	ElseIf File( cPathBm2 )
		If File( cPathEst + cArqBmp2 )
			Ferase( cPathEst + cArqBmp2 )
		EndIf
		__copyfile( cPathBm2, cPathEst + cArqBmp2 )
		cArqBmp := cArqBmp2
	EndIf	// para que o wordview e o proprio word possam preparar o arquivo para impressao e
	// ou visualizacao .... copia o DOT que esta no ROOTPATH Protheus para o PATH da
	// estacao , por exemplo C:\WORDTMP

	For nXY := 1 To Len( aFilRelat )
		lEof := .T.
		cFil := aFilRelat[nXY][1]
		dDeLaudo  := SToD( aFilRelat[nXY][4] )
		dAteLaudo := SToD( aFilRelat[nXY][5] )
		cCodLaudo := aFilRelat[nXY][3]

		If nXY == 1 .Or. IIf( nXY == 1, .T., aFilRelat[nXY][1] != aFilRelat[nXY - 1][1] )
			nQtdFunT := 0
			nQtdFunT += fQtdFunRis( aFilRelat[nXY][1] ) //Retorna quantidade de funcionarios expostos a riscos
		EndIf

		dbSelectArea( "TO0" )
		dbSetOrder( 1 )
		If  MsSeek( xFilial( "TO0", cFil ) + cCodLaudo )

			oWord := OLE_CreateLink( 'TMsOleWord97' )//Cria link como Word

			OLE_NewFile( oWord, cPathEst + cArqDot ) //Abrindo o arquivo modelo automaticamente

			If lImpress //Impressao via Impressora
				OLE_SetProperty( oWord, oleWdVisible, .F. )
				OLE_SetProperty( oWord, oleWdPrintBack, .T. )
			Else //Impressao na Tela(Arquivo)
				OLE_SetProperty( oWord, oleWdVisible, .F. )
				OLE_SetProperty( oWord, oleWdPrintBack, .F. )
			EndIf

			Dbselectarea( "SM0" )
			dbSetOrder( 1 )
			MsSeek( cSMCOD + cSMFIL )
			cCidade   := Alltrim( SM0->M0_CIDCOB ) + IIf( !Empty( SM0->M0_ESTCOB ), "-" + SM0->M0_ESTCOB, " " )
			cEmp_Nome := SM0->M0_NOMECOM
			cEmp_Cnpj := aTipoInsc[2]//SM0->M0_CGC
			cEmp_Endr := SM0->M0_ENDCOB
			cEmp_Bair := SM0->M0_BAIRCOB
			cEmp_Insc := SM0->M0_INSC
			cEmp_Cnae := SM0->M0_CNAE
			cEmp_Unop := " "
			cMatriz   := " "
			cEmp_GRisco := TO0->TO0_GRISCO
			cNum_Func := Alltrim( Str( IIf( nQtdFunT == 0, TO0->TO0_QTDFUN, nQtdFunT ), 9 ) )

			//Imprime Logo
			cFileLogo := cPathEst + cArqBmp

			cFileLogo := U_fChamaPE( 3, cPathEst, cArqBmp ) // PE 3 // Permitir informar em branco, caso o cliente não queira imprimir logotipo

			If !lMdtUnix //Se for windows
				If File( cFileLogo )
					OLE_SetDocumentVar( oWord, "Cria_Var", cFileLogo )
					OLE_ExecuteMacro( oWord, "Insere_logo" )
				EndIf
			EndIf

			U_fChamaPE( 2, cPathEst, cArqBmp ) //PE 2

			//Dados Empresa
			OLE_SetDocumentVar( oWord, "Empresa", cEmp_Nome )
			OLE_SetDocumentVar( oWord, "tipoInsc", aTipoInsc[1] )
			OLE_ExecuteMacro( oWord, "ativar_negrito" )
			OLE_SetDocumentVar( oWord, "CGC", cEmp_Cnpj )
			OLE_SetDocumentVar( oWord, "Ie", cEmp_Insc )
			OLE_SetDocumentVar( oWord, "Cnae", cEmp_Cnae )
			OLE_SetDocumentVar( oWord, "GRisco", cEmp_GRisco )
			OLE_SetDocumentVar( oWord, "Cidade", cCidade )
			OLE_SetDocumentVar( oWord, "Endereco", cEmp_Endr )
			OLE_SetDocumentVar( oWord, "Bairro", cEmp_Bair )
			OLE_SetDocumentVar( oWord, "cNum_Func", cNum_Func )
			If lSigaMdtPS
				OLE_SetDocumentVar( oWord, "UNOP", cEmp_Unop )
			EndIf
			If lMdtCC
				If Empty( mv_par11 ) .And. mv_par12 <> Replicate( "Z", Len( mv_par12 ) )
					If Empty( mv_par12 )
						cDescCapa := "Todos"
					Else
						dbSelectArea( cAliasCC )
						dbSetOrder( 1 )
						MsSeek( xFilial( cAliasCC, cFil ) )
						cDescCapa := Alltrim( &(cDescrCC) )

						cDescCapa += " até "

						dbSelectArea( cAliasCC )
						dbSetOrder( 1 )
						MsSeek( xFilial( cAliasCC, cFil ) + mv_par12 )
						cDescCapa += Alltrim( &(cDescrCC) )
					EndIf
				ElseIf !Empty( mv_par11 ) .And. mv_par12 == Replicate( "Z", Len( mv_par12 ) )
					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par11 )
					cDescCapa := Alltrim( &(cDescrCC) )

					cDescCapa += " até "

					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par12 )
					dbSkip( -1 )
					cDescCapa := Alltrim( &(cDescrCC) )
				ElseIf !Empty( mv_par11 ) .And. mv_par12 <> Replicate( "Z", Len( mv_par12 ) )
					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par11 )
					cDescCapa := Alltrim( &(cDescrCC) )

					cDescCapa += " até "

					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + mv_par12 )
					cDescCapa += Alltrim( &(cDescrCC) )
				Else
					cDescCapa := "Todos"
				EndIf

				OLE_SetDocumentVar( oWord, "CapaCC", cDescCapa )

			ElseIf lMdtUmCC
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				If MsSeek( xFilial( cAliasCC, cFil ) + Mv_par11 ) .And. !Empty( Mv_par11 ) .And. lMdtUmCC
					OLE_SetDocumentVar( oWord, "CapaCC", &(cDescrCC ) )
				Else
					OLE_ExecuteMacro( oWord, "Deleta_Linha" )	//Deleta linha da tabela
				EndIf
			Else
				OLE_ExecuteMacro( oWord, "Deleta_Linha" )	//Deleta linha da tabela
			EndIf

			OLE_SetDocumentVar( oWord, "RazaoSocial", cMatriz )
			If Empty( TO0->TO0_DTVALI )
				OLE_SetDocumentVar( oWord, "Validade", " " )
			Else
				OLE_SetDocumentVar( oWord, "Validade", Upper( MesExtenso( TO0->TO0_DTVALI ) ) + "/" + StrZero( Year( TO0->TO0_DTVALI ), 4 ) )
			EndIf

			OLE_ExecuteMacro( oWord, "NewPage" )

			cMemo := Alltrim( TO0->TO0_DESCRI )
			If !Empty( TO0->TO0_MMSYP2 )
				cMMSYP2 := MSMM( TO0->TO0_MMSYP2, 80 )
				If !Empty( cMMSYP2 )
					If !Empty( cMemo )
						cMemo += Chr( 13 ) + Chr( 10 )
					EndIf
					cMemo += cMMSYP2
				EndIf
			ElseIf TO0->( FieldPos( "TO0_DESC2" ) ) > 0 .And. !Empty( TO0->TO0_DESC2 )
				If !Empty( cMemo )
					cMemo += Chr( 13 ) + Chr( 10 )
				EndIf
				cMemo += Alltrim( TO0->TO0_DESC2 )
			EndIf

			SetRegua( 100 )
			nLenMemo := Len( cMemo )
			nPerMemo := 0

			While lEof
				OLE_ExecuteMacro( oWord, "Atualiza" )

				If Empty( cMemo )  //Memo vazio
					lEof := .F.
					Exit
				Else
					nPos1 := At( "#", cMemo ) //Inicio de um Titulo

					If nPos1 > 1
						cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
						cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
						U_IMPDOC850( Alltrim( cTexto ) )
						fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua
						Loop
					ElseIf nPos1 == 1 //Existe #
						cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )
						nPos1   := At( "#", cMemo )
						cTitulo := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
						cMemo   := Alltrim( Substr( cMemo, nPos1+1 ) )

						nPos1   := At( "#", cMemo )
						If nPos1 > 0
							cTexto := Alltrim( Substr( cMemo, 1, nPos1-1 ) )
							cMemo  := Alltrim( Substr( cMemo, nPos1 ) )
						Else
							cTexto := Alltrim( cMemo )
							cMemo  := " "
							lEof   := .F.
						EndIf
					Else //Nao existe #
						//IMPRIME TEXTO
						U_IMPDOC850( Alltrim( cMemo ) )
						lEof := .F.
						Exit
					EndIf

					//IMPRIME TITULO
					If !Empty( cTitulo )
						lCabec850  := .T.
						U_IMPHEA850( cTitulo, , .T. )
						If !Empty( cTexto )
							nTexto := 0
							nLinhasMemo := MLCOUNT( cTexto, 10 )
							For nLinha := 1 To nLinhasMemo
								cTextTemp := MemoLine( cTexto, 10, nLinha )
								If !Empty( cTextTemp )
									nTexto := At( "@", AllTrim( cTextTemp ) )
									Exit
								EndIf
							Next nLinha

							If nTexto == 0
								OLE_ExecuteMacro( oWord, "SomaLinha" )
								OLE_ExecuteMacro( oWord, "SomaLinha" )
							EndIf
						EndIf
					EndIf

					lPrint  := .T.
					lPrin2 := .T.
					U_IMPDOC850( Alltrim( cTexto ) )

				EndIf

				fReguaPPRA( nLenMemo, @nPerMemo, Len( cMemo ) ) //Incrementa Regua

			End

			cTxtMemo := " "
			DbSelectArea( "TMZ" )
			dbSetOrder( 1 )
			IF MsSeek( xFilial( "TMZ", cFil ) + TO0->TO0_TERMO )
				cTxtMemo := TMZ->TMZ_DESCRI
			EndIf

			aUsuSX5 := {}
			aAdd( aUsuSX5, { "1", STR0338 } ) //"Médico(a) do Trabalho"
			aAdd( aUsuSX5, { "2", STR0339 } ) //"Enfermeiro(a) do Trabalho"
			aAdd( aUsuSX5, { "3", STR0340 } ) //"Auxiliar de Enfermagem do Trabalho"
			aAdd( aUsuSX5, { "4", STR0341 } ) //"Engenheiro(a) de Segurança do Trabalho"
			aAdd( aUsuSX5, { "5", STR0342 } ) //"Técnico(a) de Segurança do Trabalho"
			aAdd( aUsuSX5, { "6", STR0343 } ) //"Médico(a)"
			aAdd( aUsuSX5, { "7", STR0344 } ) //"Enfermeiro(a)"
			aAdd( aUsuSX5, { "8", STR0345 } ) //"Auxiliar de Enfermagem"
			aAdd( aUsuSX5, { "9", STR0346 } ) //"Técnico(a) de Enfermagem do Trabalho"
			aAdd( aUsuSX5, { "A", STR0347 } ) //"Fisioterapeuta"

			nInfoDoc := 0
			cMemoUsu := ""
			dbSelectArea( "TMK" )
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMK", cFil ) + TO0->TO0_CODUSU )
				cMemoUsu += TMK->TMK_NOMUSU+"@#$"+"#*"
				nInfoDoc++
				nPosUs := aScan( aUsuSX5, {|x| x[1] == TMK->TMK_INDFUN } )
				If nPosUs > 0
					cMemoUsu += aUsuSX5[nPosUs, 2] + "#*"
				Else
					cMemoUsu += " "+"#*"
				EndIf
				nInfoDoc++
				If !Empty( TMK->TMK_NUMENT )
					cMemoUsu += IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ) + TMK->TMK_NUMENT + "#*"
					nInfoDoc++
				EndIf
				If !Empty( TMK->TMK_REGMTB )
					cMemoUsu += STR0348+TMK->TMK_REGMTB+"#*" //"Reg. DSST/MTE.: "
					nInfoDoc++
				EndIf
			EndIf

			dbSelectArea( "TMK" )
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMK", cFil ) + Mv_par02 ) .And. Mv_par02 <> TO0->TO0_CODUSU
				cMemoUsu += TMK->TMK_NOMUSU+"@#$"+"#*"
				nInfoDoc++
				nPosUs := aScan( aUsuSX5, {|x| x[1] == TMK->TMK_INDFUN } )
				If nPosUs > 0
					cMemoUsu += aUsuSX5[nPosUs, 2] + "#*"
				Else
					cMemoUsu += " "+"#*"
				EndIf
				nInfoDoc++
				If !Empty( TMK->TMK_NUMENT )
					cMemoUsu += IIf( Empty( TMK->TMK_ENTCLA ), "", Alltrim( TMK->TMK_ENTCLA ) + ": " ) + TMK->TMK_NUMENT + "#*"
					nInfoDoc++
				EndIf
				If !Empty( TMK->TMK_REGMTB )
					cMemoUsu += STR0348+TMK->TMK_REGMTB+"#*" //"Reg. DSST/MTE.: "
					nInfoDoc++
				EndIf
			EndIf

			If nInfoDoc > 0
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_SetDocumentVar( oWord, "Tabela", cMemoUsu )
				OLE_SetDocumentVar( oWord, "Linhas", nInfoDoc )
				OLE_ExecuteMacro( oWord, "Table_Responsavel" )
			EndIf

			U_fChamaPE( 4, cPathEst, cArqBmp ) //PE 4

			OLE_SetDocumentVar( oWord, "Cria_Var", Space( 1 ) ) //Limpa campo oculto do documento
			OLE_SetDocumentVar( oWord, "Tabela", Space( 1 ) )   //Limpa campo oculto do documento
			OLE_SetDocumentVar( oWord, "Tabela2", Space( 1 ) )  //Limpa campo oculto do documento
			OLE_SetDocumentVar( oWord, "Linhas", Space( 1 ) )   //Limpa campo oculto do documento
			If lCriaIndice
				OLE_ExecuteMacro( oWord, "Cria_Indice" )//"Cria o indice"
			EndIf
			OLE_ExecuteMacro( oWord, "Atualiza" ) //Executa a macro que atualiza os campos do documento
			If lCriaIndice
				OLE_ExecuteMacro( oWord, "AtualizaIndice" )//"Atualiza Indice"
			EndIf
			OLE_ExecuteMacro( oWord, "Begin_Text" ) //Posiciona o cursor no inicio do documento

			cRootPath := GetPvProfString( GetEnvServer(), "RootPath", "ERROR", GetADV97() )
			cRootPath := IIf( RIGHT( cRootPath, 1 ) == cBarraSRV, SubStr( cRootPath, 1, Len( cRootPath ) - 1 ), cRootPath )

		EndIf

	Next nXY
	IF lImpress //Impressao via Impressora
		OLE_SetProperty( oWord, '208', .F. ) ; OLE_PrintFile( oWord, "ALL", , , 1 )
	Else //Impressao na Tela(Arquivo)
		OLE_SetProperty( oWord, oleWdVisible, .T. )
		OLE_ExecuteMacro( oWord, "Maximiza_Tela" )
		If !lMdtUnix //Se for windows
			If U_fDIRR850( cRootPath + cBarraSRV + 'SPOOL' + cBarraSRV )
				OLE_SaveAsFile( oWord, cRootPath+cBarraSRV+"SPOOL"+cBarraSRV+cArqSaida, , , .F., oleWdFormatDocument )
			ElseIf U_fDIRR850( cPathEst )
				OLE_SaveAsFile( oWord, cPathEst+cArqSaida, , , .F., oleWdFormatDocument )
			Else
				OLE_SaveAsFile( oWord, cPathEst+cArqSaida, , , .F., oleWdFormatDocument )
			EndIf
		EndIf
		MsgInfo( STR0061 ) //"Alterne para o programa do Ms-Word para visualizar o documento ou clique no botao para fechar."
	EndIf
	OLE_CloseFile( oWord ) //Fecha o documento
	OLE_CloseLink( oWord ) //Fecha o documento

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} U_fChamaPE()
Chama os pontos de entrada do modelo word

@type    function
@author  Milena Leite de Oliveira
@since   20/04/2020
@sample  U_fChamaPE(1, "C:\TEMP\", "LGRLT1D MG 01 .BMP" )

@param   nPonto, Numérico, qual ponto de entrada será chamado
@param   cCaminho, Caracter, indica o caminho do arquivo
@param   cArquivo, Caracter, indica o nome da imagem

@return  cFileLogo, Retorna o conteúdo do caminho + nome do arquivo caso não encontre nenhum ponto de entrada
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function fChamaPE( nPonto, cCaminho, cArquivo)

	Local cFileLogo
	Local cPathEst := cCaminho
	Local cArqBmp  := cArquivo

	Do Case
		Case nPonto == 3 .And. ExistBlock( "MDTR8503" )
			Return  ExecBlock('MDTR8503',.F.,.F.) //Permitir informar em branco, caso o cliente não queira imprimir logotipo
		Case nPonto == 2 .And. ExistBlock( "MDTR8502" )
			ExecBlock('MDTR8502',.F.,.F.)
			Return Nil
		Case nPonto == 4 .And. ExistBlock( "MDTR8504" )
			ExecBlock('MDTR8504',.F.,.F.)
			Return Nil
		OtherWise
			cFileLogo := cPathEst + cArqBmp
			Return cFileLogo
	EndCase
Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fDIRR850
Verifica se o diretório existe.

@author  Denis Hyroshi de Souza
@since   08/04/2003
@param   cCaminho, Caractere, Caminho para o diretório a ser acessado

@return  lDir, Lógico, Verdadeiro se o diretório existir
/*/
//-------------------------------------------------------------------
User Function fDIRR850(cCaminho)

	Local lDir 		:= .F.
	Local cBARRAS   := IIf( isSRVunix(), "/", "\" )
	Local cBARRAD 	:= IIf( isSRVunix(), "//", "\\" )

	If !Empty( cCaminho ) .And. !( cBARRAD$cCaminho )
		cCaminho := AllTrim( cCaminho )
		If Right( cCaminho, 1 ) == cBarras
			cCaminho := SubStr( cCaminho, 1, Len( cCaminho ) -1 )
		EndIf
		lDir :=(Ascan( Directory( cCaminho, "D" ), { |_Vet | "D" $ _Vet[5] } ) > 0)
	EndIf

Return lDir

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPDOC850
Imprime o conteudo do texto.

@author  Denis Hyroshi de Souza
@since   08/04/2003

@param   _cTexto, Caractere, Texto a ser impresso
@param   lSaltaLin, Lógico, Se pula a linha
@param   lEsquerda, Lógico, Se alinha a esquerda
@param   lBackSpc, Lógico, Se deixa espaço antes da primiera linha
@param   nMaisCol, Numérico, Número de colunas
@param   nTermLin, Numérico, Delimita o término da linha

@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function IMPDOC850( _cTexto, lSaltaLin, lEsquerda, lBackSpc, nMaisCol, nTermLin )

	Local lTexto := .T.
	Local nPosTxt := 0
	Local cTitExe
	Local cTextoNew := _cTexto
	Local cTxtMemo  := _cTexto
	Local nArroba
	Local LinhaCor
	Local nPosTemp
	Local cCNS := " "

	Default lEsquerda := .F.  //Alinhar à esquerda
	Default lBackSpc  := .F.
	Default nMaisCol  := 0    //Adiciona colunas para impressão
	Default nTermLin  := IIf( nModeloImp == 2, 120, 90 ) // Delimita o termino da linha
	Private lFirst    := .T.

	//Imprime texto

	lJumpCab := .F. //Somalinha do Titulo de Relatorio
	While lTexto
		nArroba := At( "@", cTxtMemo )

		If nArroba > 1
			cTextoNew := Alltrim( Substr( cTxtMemo, 1, nArroba-1 ) )
			cTxtMemo  := Alltrim( Substr( cTxtMemo, nArroba ) )
			U_IMPDOC850( Alltrim( cTextoNew ) )
			Loop
		ElseIf nArroba == 1 //Existe @
			cTxtMemo := Alltrim( Substr( cTxtMemo, nArroba+1 ) )
			nArroba  := At( "@", cTxtMemo )
			cTitExe  := Alltrim( Substr( cTxtMemo, 1, nArroba-1 ) )
			U_PROC850TIT( cTitExe )
			lCabec850 := .F.
			cTxtMemo := Alltrim( Substr( cTxtMemo, nArroba+1 ) )

			nArroba   := At( "@", cTxtMemo )
			If nArroba > 0
				cTextoNew := Alltrim( Substr( cTxtMemo, 1, nArroba-1 ) )
				cTxtMemo  := Alltrim( Substr( cTxtMemo, nArroba ) )
				U_IMPDOC850( Alltrim( cTextoNew ) )
				Loop
			EndIf
		EndIf

		If ( nPosTxt := At( Chr( 13 )+Chr( 10 ), cTxtMemo ) ) == 0
			lTexto := .F.
			cTextoNew := Alltrim( cTxtMemo )
		Else
			cTextoNew := Alltrim( Substr( cTxtMemo, 1, nPosTxt - 1 ) )
			cTxtMemo  := Alltrim( Substr( cTxtMemo, nPosTxt + 2 ) )
			If Len(cTxtMemo) == 0
				lTexto := .F.
			EndIf
		EndIf

		If Empty( cTextoNew )
			cTextoNew := " "
		EndIf

		If nModeloImp == 2
			nAddLi := 0+nMaisCol
			If lIdentar
				nAddLi := 5
			EndIf
			lPrimeiro := .T.
			nLinhasMemo := MLCOUNT( cTextoNew, nTermLin )
			For LinhaCor := 1 To nLinhasMemo
				If lPrimeiro
					@ Li,005+nAddLi PSAY (MemoLine( cTextoNew, nTermLin, LinhaCor ))
					lPrimeiro := .F.
				Else
					@ Li, 000 + nAddLi PSAY (MemoLine( cTextoNew, nTermLin, LinhaCor ))
				EndIf
				Somalinha()
			Next LinhaCor
		ElseIf nModeloImp == 1 .And. cTextoNew <> " "
			cVar1 := "cTXT"+Strzero( nVar1, 6 )
			OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
			nVar1++

			If lPrint .And. !lFirst
				OLE_ExecuteMacro( oWord, "Somalinha" )
				lPrint := .F.
			EndIf
			If lPrin2 .And. !lFirst
				OLE_ExecuteMacro( oWord, "Somalinha" )
			EndIf

			If lSaltaLin
				OLE_ExecuteMacro( oWord, "Somalinha" )
			EndIf

			If lIdentar .And. !lFirst
				OLE_ExecuteMacro( oWord, "Identar" )
			EndIf

			OLE_ExecuteMacro( oWord, "Cria_Txt2" )

			If ( "{" $ cTextoNew ) .And.  ( "}" $ cTextoNew )
				nPosTemp := At( "}", cTextoNew )
				cCNS     := Substr( cTextoNew, 1, nPosTemp )
				cTextoNew := Substr( cTextoNew, nPosTemp+1 )
			EndIf

			OLE_ExecuteMacro( oWord, "desativar_negrito" )

			If ( "C" $ Upper( cCNS ) ) //C=Centralizar
				OLE_ExecuteMacro( oWord, "Centralizar" )
			Else
				OLE_ExecuteMacro( oWord, "Justificar" )
			EndIf

			If ( "S" $ Upper( cCNS ) ) //S=Sublinhar
				OLE_ExecuteMacro( oWord, "Com_Sublinhar" )
			Else
				OLE_ExecuteMacro( oWord, "Sem_Sublinhar" )
			EndIf

			If lBackSpc .And. lFirst
				OLE_ExecuteMacro( oWord, "BackSpace" )
			EndIf
			lPrin2 := .T.
			lFirst := .F.
			If lEsquerda
				OLE_ExecuteMacro( oWord, "Alinhar_Esquerda" )
			EndIf
			OLE_SetDocumentVar( oWord, cVar1, cTextoNew )
		ElseIf nModeloImp == 3
			nAddLi := 0+nMaisCol
			nDifCarac := 0
			If lIdentar
				nAddLi := 150
				nDifCarac := 7
			EndIf
			lPrimeiro := .T.
			nLinhasMemo := MLCOUNT( cTextoNew, nTermLin - nDifCarac )
			For LinhaCor := 1 To nLinhasMemo

				If lin + 120 > 3000 //Força quebra de pagina se o quadro nao sair na mesma pagina
					lin := 9999
				EndIf

				Somalinha()
				If lPrimeiro
					oPrintPPRA:Say( lin, 300+nAddLi, MemoLine( cTextoNew, nTermLin - nDifCarac, LinhaCor ), oFont10 )
					lPrimeiro := .F.
				Else
					oPrintPPRA:Say( lin, 150+nAddLi, MemoLine( cTextoNew, nTermLin - nDifCarac, LinhaCor ), oFont10 )
				EndIf
			Next LinhaCor
		EndIf

	End

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} IMPHEA850
Imprime o título do texto

@author  Denis Hyroshi de Souza
@since   08/04/2003

@param   _cTit, Caractere, Título
@param   lJump, Lógico, Se pula a linha
@param   lIndice, Lógico, Se coloca índices nos títulos

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function IMPHEA850(_cTit, lJump, lIndice)

	Local nPosTemp
	Local _cTitulo := _cTit
	Local cCNS := " "
	Local lJumper
	Local nLinhasMemo
	Local LinhaCor

	Default lJump := .F.
	Default lIndice := .F.
	lJumper := IIf( !lJump, lJumpCab, lJump )

	If nModeloImp == 2
		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At( "}", _cTitulo )
			cCNS     := Substr( _cTitulo, 1, nPosTemp )
			_cTitulo := Substr( _cTitulo, nPosTemp + 1 )
		EndIf
		Somalinha()
		@ Li, 000 Psay _cTitulo
		Somalinha()
		Return .T.

	ElseIf nModeloImp == 3

		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At( "}", _cTitulo )
			cCNS     := Substr( _cTitulo, 1, nPosTemp )
			_cTitulo := Substr( _cTitulo, nPosTemp+1 )
		EndIf

		nLinhasMemo := MLCOUNT( _cTitulo, 90 )
		For LinhaCor := 1 To nLinhasMemo
			Somalinha()
			nColImp := 150
			cTxtImp := Alltrim( MemoLine( _cTitulo, 90, LinhaCor ) )
			If ( "C" $ Upper( cCNS ) ) //C=Centralizar
				nDiff := Round(  ( 90 - Len( cTxtImp ) ) / 2 ,  0  )
				If nDiff > 0
					nColImp := 150 + ( nDiff*23.3 )
				EndIf
			EndIf
			If ( "N" $ Upper( cCNS ) ) //N=Negrito
				If ( "S" $ Upper( cCNS ) ) //S=Sublinhar
					oPrintPPRA:Say( lin, nColImp, cTxtImp, oFont12bs )
				Else
					oPrintPPRA:Say( lin, nColImp, cTxtImp, oFont12b )
				EndIf
			Else
				If ( "S" $ Upper( cCNS ) ) //S=Sublinhar
					oPrintPPRA:Say( lin, nColImp, cTxtImp, oFont12s )
				Else
					oPrintPPRA:Say( lin, nColImp, cTxtImp, oFont12 )
				EndIf
			EndIf
		Next LinhaCor
		Return .T.
	Else
		lFirst := .F.////Somalinha do texto

		cVar := "cTIT"+Strzero( nVar, 6 )
		nVar++
		OLE_SetDocumentVar( oWord, "Cria_Var", cVar )
		If !lJumper
			OLE_ExecuteMacro( oWord, "Somalinha" )
		EndIf
		lJumpCab := .F.//Somalinha do Titulo de Relatorio
		OLE_ExecuteMacro( oWord, "Somalinha" )

		If ("{" $ _cTitulo) .And.  ("}" $ _cTitulo)
			nPosTemp := At("}",_cTitulo)
			cCNS     := Substr(_cTitulo,1,nPosTemp)
			_cTitulo := Substr(_cTitulo,nPosTemp+1)
		EndIf

		If lIndice
			If ("1" $Upper(cCNS))//Titulo 1
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario")
			ElseIf("2" $Upper(cCNS))//2=Titulo 2
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario2")
			ElseIf("3" $Upper(cCNS))//2=Titulo 3
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario3")
			ElseIf("4" $Upper(cCNS))//2=Titulo 4
				lCriaIndice := .T.
				OLE_ExecuteMacro(oWord, "Cria_TituloUsuario4")
			Else
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
			EndIf
		Else
			OLE_ExecuteMacro(oWord,"Cria_Titulo")
		EndIf

		OLE_ExecuteMacro(oWord,"ativar_negrito")

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

		OLE_SetDocumentVar(oWord,cVar,_cTitulo)

		If lIndice
			Somalinha()
		EndIf
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} PROC850TIT
Imprime a Tabela relacionada ao Título

@author  Denis Hyroshi de Souza
@since   28/05/2003
@param   _cTitExe, Caractere, Título da tabela

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function PROC850TIT(_cTitExe)

	Local cTitExe := _cTitExe, nTipo := 1, cTitTemp, nPos1, aRetPE, nFor, nPosPE

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
			aRetPE := ExecBlock('MDTR8501',.F.,.F., {nModeloImp, nModeloImp, cTitExe})
			If ValType(aRetPE) == "A"
				nPosPE := aScan(aRetPE, {|x| Alltrim(x[1]) == Alltrim(cTitExe) .And. Alltrim(cTitExe) == Alltrim(x[1]) })
				If nPosPE > 0
					&(aRetPE[nPosPE,2])
					Break
				EndIf
			EndIf
		EndIf

		If nTipo == 2
			A850IMAGEM(cTitTemp)
		ElseIf nTipo == 3
			A850ARQUIVO(cTitTemp)
		ElseIf ( "LOCAIS" $ Upper( cTitExe ) .Or. "LOCAL" $ Upper( cTitExe ) )
			If "QUADRO" $ Upper( cTitExe )
				U_A850LOCAL(2)
			Else
				U_A850LOCAL(1)
			EndIf
		ElseIf "RISCO-RUIDO" $ Upper(cTitExe)
			U_A850RUIDO()
		ElseIf "RISCO-CALOR" $ Upper(cTitExe)
			U_A850CALOR()
		ElseIf "RISCO-FRIO" $ Upper(cTitExe)
			U_A850FRIO()
		ElseIf "RISCO-QUIMICO" $ Upper(cTitExe)
			U_A850QUIMICO()
		ElseIf "RISCO-UMIDADE" $ Upper(cTitExe)
			U_A850UMIDADE()
		ElseIf "RISCO-FISICO" $ Upper(cTitExe)
			U_A850FISICO()

		ElseIf "RISCO-EPC" $ Upper(cTitExe)
			U_A850RISEPC()

		ElseIf "QUADRO RISCOS" $ Upper(cTitExe)
			U_A850RISQUA()
		ElseIf "RISCO" $ Upper(cTitExe)
			fBusRis()
		ElseIf "QUADRO FUNCIONARIOS" $ Upper(cTitExe)
			If "CENTRO" $ Upper(cTitExe) .And. "CUSTO" $ Upper(cTitExe)
				U_A850QUADFUN(2)
			Else
				U_A850QUADFUN(1)
			EndIf
		ElseIf "QUADRO DE AGENTES" $ Upper(cTitExe)
			A850AGENT()
		ElseIf "PLANO EMERGENCIAL" $ Upper(cTitExe)
			A850PEMERG()
		ElseIf "DOSIMETRIA POR AMBIENTE FÍSICO" $ Upper(cTitExe)
			A850DOSIME("1")
		ElseIf "DOSIMETRIA POR FUNCIONÁRIO" $ Upper(cTitExe)
			A850DOSIME("2")
		ElseIf "DOSIMETRIA POR CENTRO DE CUSTO" $ Upper(cTitExe)
			A850DOSIME("3")
		ElseIf "DOSIMETRIA POR FUNÇÃO" $ Upper(cTitExe)
			A850DOSIME("4")
		ElseIf "DOSIMETRIA POR ATIVIDADE" $ Upper(cTitExe)
			A850DOSIME("5")
		ElseIf Upper( cTitExe ) $ "EQUIPAMENTO"
			U_A850EQUIP()
		ElseIf "QUADRO MEDIDA CONTROLE" $ Upper(cTitExe)
			U_A850CONQ()
		ElseIf "CONTROLE" $ Upper(cTitExe)
			U_A850CONTR()
		ElseIf "EXAME" $ Upper(cTitExe)
			U_A850EXAME()
		ElseIf "SESMT" $ Upper(cTitExe)
			U_A850SESMT()
		ElseIf "QUADRO EPI" $ Upper(cTitExe)
			U_A850EPIQ()
		ElseIf Upper(cTitExe) $ "EPI"
			U_A850EPIS()
		ElseIf "PLANO" $ Upper(cTitExe)
			U_A850PLANOS()
		ElseIf "QUESTIONARIO PRODUTO" $ Upper(cTitExe) .And. AliasInDic("TID")
			U_A850PRODQUIM()
		ElseIf "QUESTIONARIO" $ Upper(cTitExe)
			U_A850QUESTI()
		ElseIf "FUNCIONARIOS X FUNCAO" $ Upper(cTitExe)
			U_A850FUNFUN()
		ElseIf "FUNCOES" $ Upper(cTitExe)
			lTarefa := .F.
			If "TAREFAS" $ Upper(cTitExe)
				lTarefa := .T.
			EndIf
			U_A850FUNCOES(lTarefa)
		ElseIf "CRONOGRAMA" $ Upper(cTitExe)
			U_A850CRONOGRAMA()
		ElseIf "PAGINA"	$ Upper(cTitExe)
			If nModeloImp == 2
				li := 80
				somalinha()
			ElseIf nModeloImp == 3
				lin := 9999
				somalinha()
			Else
				OLE_ExecuteMacro(oWord,"NewPage")
				lJumpCab := .T.
			EndIf
		ElseIf "ANEXO IV" $ Upper(cTitExe) .And. AliasInDic("TJB")
			A850ANXIV()
		ElseIf Upper(cTitExe) $ "REQUISITOS" .And. AliasInDic("TJA")
			A850REQUIS()
		ElseIf Upper(cTitExe) $ "EPI X ATIVIDADES" .And. AliasInDic("TJ9")
			A850EPIATI()
		ElseIf Upper(cTitExe) $ "BEM" .And. AliasInDic("TOD")
			A850BEM()
		ElseIf Upper(cTitExe) $ "MD-EPC"//.And. AliasInDic("TOD")
			A850MDEPC()
		ElseIf Upper(cTitExe) $ "QUADRO TOQUES"
			A850QToques()
		ElseIf Upper(cTitExe) $ "QUADRO REQUISITOS X TREINAMENTO"
			A850QUATRE()
		ElseIf Upper( cTitExe ) $ "EQUIPAMENTOS RADIOATIVOS"
			A850EQPRAD()
		ElseIf Upper( cTitExe ) $ "ESTRUTURA LOCAIS"
			A850ESTLOC()
		ElseIf Upper( cTitExe ) $ "PGR - FUNCIONARIOS"
			U_A850PGRFUN()
		ElseIf Upper( cTitExe ) $ "PGR X PE"
			A850PGRXPE()
		ElseIf Upper( cTitExe ) $ 'PROGRAMA' // Programas de saúde"
			A850PROGA()
		ElseIf Upper( cTitExe ) $ "QUADRO - PROGRAMA MONITORAMENTO"
			A850PROMON()
		ElseIf Upper( cTitExe ) $ 'RADIAÇÃO DE FUGA' // Quadro de radiação de fuga vinculado ao ambiente físico relacionado ao laudo."
			A850RADFUG()
		ElseIf Upper( cTitExe ) $ 'AGENTE X MEDIDA' // Imprime agentes e medidas"
			A850AGEMED()
		ElseIf Upper( cTitExe ) $ "QUADRO AGENTE"
			A850QDAGE()
		ElseIf Upper( cTitExe ) $ "FUNCAO X TAREFA"
			A850FUNTAR()
		ElseIf Upper(cTitExe) $ "POLITICA"
			U_MDTPolicy()
		ElseIf Upper(cTitExe) $ "ACIDENTE S/VITÍMAS"
			A850ACI()
		ElseIf Upper(cTitExe) $ "ACIDENTE C/VITÍMAS"
			A850ACIVIT()
		ElseIf Upper( cTitExe ) $ 'ANÁLISE PRELIMINAR'
			fBusAnaPre()
		EndIf
	End Sequence

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850LOCAL
Imprime os Locais do Laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@param   nTipoQdr, Numérico, (1) Sem quadro ou (2) com quadro

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850LOCAL( nTipoQdr )

	Local aArea    := GetArea()
	Local cImgPath := ''
	Local cDescAmb := ''
	Local cMemo    := ''
	Local nRegs    := 0
	Local i        := 0

	lPula := .F.

	dbSelectArea( 'TO5' )
	dbSetOrder( IIf( lSigaMdtps, 4, 1 ) )
	MsSeek( xFilial( 'TO5', cFil ) + IIf( lSigaMdtps, cCliMdtPs, '' ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial('TO5') + TO0->TO0_LAUDO == TO5->TO5_FILIAL + TO5->TO5_LAUDO .And.;
		IIf( lSigaMdtps, cCliMdtPs == TO5->TO5_CLIENT + TO5->TO5_LOJA, .T. )

		dbSelectArea( 'TNE' )
		dbSetOrder( IIf( lSigaMdtps, 3, 1 ) )
		If MsSeek( xFilial( 'TNE', cFil ) + IIf( lSigaMdtps, cCliMdtPs, '' ) + TO5->TO5_CODAMB )

			lPrint := .T.
			If nModeloImp <> 1
				cDescAmb := Alltrim( TNE->TNE_MEMODS )

				If nModeloImp == 2

					lPrimeiro   := .T.
					nTamanho    := 135-Len( STR0247 + ": " ) // "Descricao do Ambiente"
					nLinhasMemo := MLCOUNT( Alltrim( TNE->TNE_NOME ), nTamanho )

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li, 000 pSay STR0246 + ": " // "Nome do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li, 000 + Len( STR0247 + ": " ) pSay MemoLine( Alltrim( TNE->TNE_NOME ), nTamanho, i)
						Somalinha()
					Next i

					lPrimeiro   := .T.
					nLinhasMemo := MLCOUNT(cDescAmb, nTamanho)

					For i := 1 To nLinhasMemo
						If lPrimeiro
							@ Li, 000 pSay STR0247 + ": " // "Descricao do Ambiente"
							lPrimeiro := .F.
						EndIf
						@ Li, 000 + Len( STR0247 + ": " ) pSay MemoLine( cDescAmb, nTamanho, i )
						Somalinha()
					Next i

					Somalinha()

				ElseIf nModeloImp == 3

					lPrimeiro := .T.
					nDifCarac := 0
					If lIdentar
						nDifCarac := 7
					EndIf
					nTamanho    := 72 - nDifCarac
					nLinhasMemo := MLCOUNT( Alltrim( TNE->TNE_NOME ), nTamanho )

					For i := 1 To nLinhasMemo
						If lPrimeiro
							oPrintPPRA:Say( lin, 150, STR0246 + ": ", oFont10 ) // "Nome do Ambiente"
							lPrimeiro := .F.
						EndIf
						oPrintPPRA:Say( lin, 600, MemoLine( Alltrim( TNE->TNE_NOME ), nTamanho, i ), oFont10 )
						Somalinha()
					Next i

					lPrimeiro   := .T.
					nLinhasMemo := MLCOUNT( cDescAmb, nTamanho )

					For i := 1 To nLinhasMemo
						If lPrimeiro
							oPrintPPRA:Say( lin, 150, STR0247 + ": ", oFont10 ) // "Descricao do Ambiente"
							lPrimeiro := .F.
						EndIf
						oPrintPPRA:Say( lin, 600, MemoLine( cDescAmb, nTamanho, i ), oFont10 )
						Somalinha()
					Next i

					Somalinha()

					If !Empty( TNE->TNE_BITMAP ) .And. nImpImage <> 2
						cImgPath := NGimgExtract( TNE->TNE_BITMAP, cPathEst )
						If !Empty( cImgPath )
							Somalinha()
							//Caso a página esteja no fim cria nova página para não truncar imagem
							If lin > 2160
								lin := 3001
								Somalinha()
							EndIf
							cImgPath := Substr( cImgPath, 1, At( ".", cImgPath ) )
							If File( cImgPath + "JPG" )
								oPrintPPRA:SayBitmap( lin+10, 200, cImgPath + "JPG", 1600, 800 )
							ElseIf File( cImgPath+ "JPEG" )
								oPrintPPRA:SayBitmap( lin + 10, 200, cImgPath + "JPEG", 1600, 800)
							ElseIf File( cImgPath + "PNG" )
								oPrintPPRA:SayBitmap( lin + 10, 200, cImgPath + "PNG", 1600, 800 )
							ElseIf File( cImgPath + "BMP" )
								oPrintPPRA:SayBitmap( lin + 10, 200, cImgPath + "BMP", 1600, 800 )
							EndIf
							//Verifica os arquivos criados para deletar depois
							If aScan( aImagens, { |x| UPPER( TRIM( x[1] ) ) == UPPER( TRIM( cImgPath ) ) } ) == 0
								aADD( aImagens, { cImgPath })
							EndIf
							lin += 820
						EndIf
					EndIf
				EndIf
			ElseIf nTipoQdr == 1 // Modelo Word - Sem Quadro
				// Nome do Ambiente
				cVar1 := "cTXT" + Strzero( nVar1, 6)
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
				nVar1++
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_ExecuteMacro( oWord, "Cria_Titulo" )
				OLE_ExecuteMacro( oWord, "ativar_negrito" )
				OLE_ExecuteMacro( oWord, "Alinhar_Esquerda" )
				OLE_SetDocumentVar( oWord, cVar1, STR0244 ) // "Nome do Ambiente:"

				cVar1 := "cTXT" + Strzero( nVar1, 6 )
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
				nVar1++
				OLE_ExecuteMacro( oWord, "Cria_Texto" )
				OLE_ExecuteMacro( oWord, "desativar_negrito" )
				OLE_ExecuteMacro( oWord, "Alinhar_Descricao" )
				OLE_SetDocumentVar( oWord, cVar1, Capital( Alltrim( TNE->TNE_NOME ) ) )
				OLE_ExecuteMacro( oWord, "Somalinha" )

				// Descrição do ambiente
				cVar1 := "cTXT"+Strzero( nVar1, 6 )
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
				nVar1++
				OLE_ExecuteMacro( oWord, "Cria_Titulo" )
				OLE_ExecuteMacro( oWord, "ativar_negrito" )
				OLE_ExecuteMacro( oWord, "Alinhar_Esquerda" )
				OLE_SetDocumentVar( oWord, cVar1, STR0245 ) // "Descrição do Ambiente:"

				cDescAmb := Alltrim( TNE->TNE_MEMODS )

				cVar1 := "cTXT"+Strzero( nVar1, 6 )
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1)
				nVar1++
				OLE_ExecuteMacro( oWord, "Cria_Texto" )
				OLE_ExecuteMacro( oWord, "desativar_negrito" )
				OLE_ExecuteMacro( oWord, "Alinhar_Descricao" )
				OLE_SetDocumentVar( oWord, cVar1, cDescAmb )
				OLE_ExecuteMacro( oWord, "Somalinha" )

				OLE_ExecuteMacro( oWord, "Retornar_Alinhamento" )

				// Extrai do repositorio a imagem relacionada ao Ambiente Fisico e atribui o path do
				// arquivo extraido 'a variavel cImgPath
				If !Empty(TNE->TNE_BITMAP) .And. nImpImage <> 2
					cImgPath := NGimgExtract( TNE->TNE_BITMAP, cPathEst )
					If !Empty( cImgPath )
						cImgPath := Substr( cImgPath, 1, At( ".", cImgPath ) )
						If File( cImgPath + "JPG" )
							cImgPath += "JPG"
						ElseIf File( cImgPath + "JPEG" )
							cImgPath += "JPEG"
						ElseIf File( cImgPath + "PNG" )
							cImgPath += "PNG"
						ElseIf File( cImgPath + "BMP" )
							cImgPath += "BMP"
						EndIf
						OLE_ExecuteMacro( oWord, "Somalinha" )
						OLE_SetDocumentVar( oWord, "Cria_Var", cImgPath )
						OLE_ExecuteMacro( oWord, "Insere_figura" ) // Insere a imagem no documento Word
						OLE_ExecuteMacro( oWord, "Somalinha" )
						If aScan( aImagens, { |x| UPPER( TRIM( x[1] ) ) ==;
							UPPER( TRIM( Substr( cImgPath, 1, At( ".", cImgPath ) ) ) ) } ) == 0
							aADD( aImagens, { Substr( cImgPath, 1, At( ".", cImgPath ) ) } )
						EndIf
						Ferase( cImgPath ) // Apaga imagem extraida do repositorio
					EndIf
				EndIf
			ElseIf nTipoQdr == 2 // Modelo Word - Com Quadro
				cDescAmb := Alltrim( TNE->TNE_MEMODS )
				cMemo += Alltrim( TNE->TNE_NOME ) + "#*"
				cMemo += cDescAmb+"#*"
				nRegs ++
			EndIf
		EndIf

		DbSelectArea( 'TO5' )
		DbSkip()
	End

	If nModeloImp == 1 .And. nTipoQdr == 2 .And. nRegs > 0 //Modelo Word - Com Quadro
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_SetDocumentVar( oWord, "Tabela", cMemo )
		OLE_SetDocumentVar( oWord, "Linhas", nRegs )
		OLE_ExecuteMacro( oWord, "Table_Local" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
	EndIf

	RestArea( aArea )

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusRis
Busca os riscos relacionados ao laudo

@author Gabriel Sokacheski
@since 11/01/2023

/*/
//-------------------------------------------------------------------
Static Function fBusRis()

	// Variáveis
	Local aRiscos := {}
	Local aFunExp := {}

	Local bValida := { ||;
		( Empty( TN0->TN0_DTELIM ) .Or. TN0->TN0_DTELIM >= TO0->TO0_DTINIC ) .And.;
		( Empty( TO0->TO0_DTFIM ) .Or. TN0->TN0_DTAVAL <= TO0->TO0_DTFIM );
	}

	Local cDep := ''
	Local cFonte := ''
	Local cAmbFis := ''
	Local cCenCus := ''
	Local cFuncao := ''
	Local cTarefa := ''
	Local cAgente := ''
	Local cTipoAge := ''
	Local cUnidade := ''
	Local cTipoExp := ''
	Local cImprime := IIf( nModeloImp == 1, mv_par19, mv_par17 )
	Local cLTolNR15 := ''
	Local cLTolACGIH := ''
	Local cLTolNHO01 := ''

	Local dAvaliacao := StoD( '  /  /    ' )

	// Controle de filial
	Local cFilTO1 := xFilial( 'TO1', cFil )

	// Parâmetros do laudo
	Local cOrdemRis := IIf( nModeloImp == 1, mv_par05, mv_par03 )
	Local cDeCenCus := IIf( nModeloImp == 1, mv_par11, mv_par09 )
	Local cAteCenCus := IIf( nModeloImp == 1, mv_par12, mv_par10 )

	Local nImpAvalia := IIf( nModeloImp == 1, mv_par10, mv_par08 )

	dbSelectArea( 'TO1' )
	dbSetOrder( 1 )

	If dbSeek( cFilTO1 + TO0->TO0_LAUDO )

		While ( 'TO1' )->( !Eof() ) .And. TO1->TO1_FILIAL + TO1->TO1_LAUDO == cFilTO1 + TO0->TO0_LAUDO

			dbSelectArea( 'TN0' )
			dbSetOrder( 1 )

			If DbSeek( xFilial( 'TN0', cFil ) + TO1->TO1_NUMRIS )

				If TN0->TN0_MAPRIS != '1' .And. Eval( bValida )

					// Filtro de centro de custo de acordo com parâmetro do laudo
					If AllTrim( TN0->TN0_CC ) == '*' .Or. ( TN0->TN0_CC >= cDeCenCus .And. TN0->TN0_CC <= cAteCenCus )

						DbSelectArea( 'TMA' )
						DbSetOrder( 1 )
						MsSeek( xFilial( 'TMA', cFil ) + TN0->TN0_AGENTE )

						cAgente := TMA->TMA_NOMAGE
						cTipoAge := TMA->TMA_GRISCO

						Do Case

							Case cTipoAge == '1'
								cTipoAge := STR0196  // "Físico"
							Case cTipoAge == '2'
								cTipoAge := STR0197  // "Químico"
							Case cTipoAge == '3'
								cTipoAge := STR0198  // "Biológico"
							Case cTipoAge == '4'
								cTipoAge := STR0199  // "Ergonômico"
							Case cTipoAge == '5'
								cTipoAge := STR0200  // "Acidente"
							Case cTipoAge == '6'
								cTipoAge := STR0201  // "Mecânico"
							Case cTipoAge == '7'
								cTipoAge := STR0505  // "Perigoso"
							Case cTipoAge == '8'
								cTipoAge := STR0626  // "Psicossocial"

						End Case

						cFonte := Posicione( 'TN7', 1, xFilial( 'TN7', cFil ) + TN0->TN0_FONTE, 'TN7_NOMFON' )

						If AllTrim( TN0->TN0_CC ) != '*'
							cCenCus := Posicione( 'CTT', 1, xFilial( 'CTT', cFil ) + TN0->TN0_CC, 'CTT_DESC01' )
						Else
							cCenCus := STR0482 // "Todos"
						EndIf

						If AllTrim( TN0->TN0_CODFUN ) != '*'
							cFuncao := Posicione( 'SRJ', 1, xFilial( 'SRJ', cFil ) + TN0->TN0_CODFUN, 'RJ_DESC' )
						Else
							cFuncao := STR0483 // "Todas"
						EndIf

						If AllTrim( TN0->TN0_CODTAR ) != '*'
							cTarefa := Posicione( 'TN5', 1, xFilial( 'TN5', cFil ) + TN0->TN0_CODTAR, 'TN5_NOMTAR' )
						Else
							cTarefa := STR0483 // "Todas"
						EndIf

						If AllTrim( TN0->TN0_DEPTO ) != '*'
							cDep := Posicione( 'SQB', 1, xFilial( 'SQB', cFil ) + TN0->TN0_DEPTO, 'QB_DESCRIC' )
						Else
							cDep := STR0482 // "Todos"
						EndIf

						cAmbFis := Posicione( 'TNE', 1, xFilial( 'TNE', cFil ) + TN0->TN0_CODAMB, 'TNE_NOME' )

						cUnidade := Posicione( 'V3F', 2, xFilial( 'V3F', cFil ) + TN0->TN0_UNIMED, 'V3F_DESCRI' )

						If nImpAvalia == 1
							dAvaliacao := TN0->TN0_DTAVAL
						EndIf

						If Empty( TN0->TN0_INDEXP )
							cTipoExp := AllTrim( Capital( ngRetSx3Box( 'TN0_INDEXP', '3' ) ) )
						Else
							cTipoExp := AllTrim( Capital( ngRetSx3Box( 'TN0_INDEXP', TN0->TN0_INDEXP ) ) )
						EndIf

						cLTolNR15 := MDTGetTLim( xFilial( "TLK", cFil ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '1', .T. )
						cLTolACGIH := MDTGetTLim( xFilial( "TLK", cFil ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '2', .T. )
						cLTolNHO01 := MDTGetTLim( xFilial( "TLK", cFil ), TN0->TN0_AGENTE, TN0->TN0_QTAGEN, '3', .T. )

						aFunExp := fBusExp( '2' $ cImprime )
						aFunNaoExp := fBusNaoExp( '3' $ cImprime )

						aAdd( aRiscos, {;
							AllTrim( TN0->TN0_NUMRIS ),; // Código do risco [1]
							Capital( AllTrim( cAgente ) ),; // Nome do agente [2]
							AllTrim( cTipoAge ),; // Tipo do agente [3]
							DtoC( dAvaliacao ),; // Data de avaliação [4]
							Capital( AllTrim( cFonte ) ),; // Nome da fonte [5]
							Capital( AllTrim( cCenCus ) ),; // Nome do centro de custo [6]
							Capital( AllTrim( cFuncao ) ),; // Nome da função [7]
							Capital( AllTrim( cTarefa ) ),; // Nome da tarefa [8]
							Capital( AllTrim( cDep ) ),; // Nome do departamento [9]
							Capital( AllTrim( cAmbFis ) ),; // Nome do ambiente fisíco [10]
							Alltrim( Str( TN0->TN0_QTAGEN ) + Space( 1 ) + cUnidade ),; // Quantidade do agente [11]
							AllTrim( cTipoExp ),; // Tipo de exposição [12]
							cLTolNR15,; // Limite de tolerancia NR-15 [13]
							cLTolACGIH,; // Limite de tolerancia ACGIH [14]
							AllTrim( Str( aFunExp[ 1 ] ) ),; // Número de funcionários expostos [15]
							AllTrim( Str( aFunNaoExp[ 1 ] ) ),; // Número de funcionários não expostos [16]
							Mdt180Cla( .T., TN0->TN0_SEVERI, TN0->TN0_PROBAB ),;  // Classificação do risco [17]
							Capital( AllTrim( TO1->TO1_RECOME ) ),; // Recomendação [18]
							TN0->TN0_SEVERI,;  // Severidade [19]
							TN0->TN0_PROBAB,;  // Probabilidade [20]
							IIf( '1' $ cImprime, fBusAti(), Nil ),; // Lista de atividades [21]
							aFunExp[ 2 ],; // Lista de funcionários expostos [22]
							aFunNaoExp[ 2 ],; // Lista de funcionários não expostos [23]
							IIf( '4' $ cImprime, fBusPla(), Nil ),; // Lista de planos de ação [24]
							cLTolNHO01; // Limite de tolerancia NHO-01 [25]
						} )

					EndIf

				EndIf

			EndIf

			( 'TO1' )->( dbSkip() )

		End

	EndIf

	If Len( aRiscos ) > 0

		// Ordena os riscos para impressão de acordo com parâmetro do laudo
		Do Case

           	Case cOrdemRis == 1 // Agente
                aSort( aRiscos, Nil, Nil, { | x, y | x[ 2 ] + x [ 1 ] < y[ 2 ] + y[ 1 ] } )
			Case cOrdemRis == 2 // Ambiente físico
                aSort( aRiscos, Nil, Nil, { | x, y | x[ 9 ] + x [ 1 ] < y[ 9 ] + y[ 1 ] } )
			Case cOrdemRis == 3 // Centro de custo
                aSort( aRiscos, Nil, Nil, { | x, y | x[ 5 ] + x[ 1 ] < y[ 5 ] + y[ 1 ] } )
			Case cOrdemRis == 4 // Fonte geradora
                aSort( aRiscos, Nil, Nil, { | x, y | x[ 4 ] + x[ 1 ] < y[ 4 ] + y[ 1 ] } )
			Case cOrdemRis == 5 // Função
                aSort( aRiscos, Nil, Nil, { | x, y | x[ 6 ] + x[ 1 ] < y[ 6 ] + y[ 1 ] } )

        End Case

		fImpRis( aRiscos )

	Else

		If nModeloImp == 1

			OLE_SetDocumentVar( oWord, 'titulo', STR0592 ) // "Risco"
			OLE_SetDocumentVar( oWord, 'texto', STR0593 + '.' ) // "Não exitem riscos válidos vinculados ao laudo"

			OLE_ExecuteMacro( oWord, 'aviso' )

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpRis
Imprime os riscos relacionados ao laudo

@author Gabriel Sokacheski
@since 11/01/2023

@param, aRiscos, riscos a serem impressos

/*/
//-------------------------------------------------------------------
Static Function fImpRis( aRiscos )

	Local cLista := ''
	Local cImprime := IIf( nModeloImp == 1, mv_par19, mv_par17 )
	Local cTitulos := ''

	Local nMemo := 0
	Local nRisco := 0
	Local nLinha := 0
	Local nOpcMat := IIf( nModeloImp == 1, mv_par20, mv_par18 )

	If nModeloImp == 1

		cTitulos += STR0063 + '#' // "Agente:"
		cTitulos += STR0136 + '#' // "Risco:"
		cTitulos += STR0070 + '#' // "Data de Avaliação:"
		cTitulos += STR0091 + ':' + '#' // "Fonte Geradora"
		cTitulos += STR0065 + '#' // "Centro de Custo:"
		cTitulos += STR0067 + '#' // "Função:"
		cTitulos += STR0068 + '#' // "Tarefa:"
		cTitulos += STR0487 + '#' // "Departamento:"
		cTitulos += STR0425 + ':' + '#' // "Ambiente"
		cTitulos += STR0071 + '#' // "Quantidade do Agente de Risco:"
		cTitulos += STR0138 + '#' // "Tipo de Exposição:"
		cTitulos += STR0623 + '#' // "Limite de tolerância NR-15:"
		cTitulos += STR0624 + '#' // "Limite de tolerância ACGIH:"
		cTitulos += STR0625 + '#' // "Limite de tolerância NHO-01:"
		cTitulos += STR0173 + '#' // "Funcionários Expostos:"
		cTitulos += STR0517 + ':' + '#' // "Funcionários não expostos"

		If nOpcMat == 1
			cTitulos += STR0367 + '#' // "Classificação:"
		EndIf

		cTitulos += STR0072 + '#' // "Recomendação:"

		OLE_SetDocumentVar( oWord, 'titulos_risco', cTitulos )
		OLE_SetDocumentVar( oWord, 'opcao_matriz', nOpcMat )

		For nRisco := 1 To Len( aRiscos )

			cLista += STR0592 + ' - ' + aRiscos[ nRisco, 1 ] + '@' // "Risco"
			cLista += aRiscos[ nRisco, 2 ] + '#' // "Agente:"
			cLista += aRiscos[ nRisco, 3 ] + '#' // "Risco:"
			cLista += aRiscos[ nRisco, 4 ] + '#' // "Data de Avaliação:"
			cLista += aRiscos[ nRisco, 5 ] + '#' // "Fonte Geradora"
			cLista += aRiscos[ nRisco, 6 ] + '#' // "Centro de Custo:"
			cLista += aRiscos[ nRisco, 7 ] + '#' // "Função:"
			cLista += aRiscos[ nRisco, 8 ] + '#' // "Tarefa:"
			cLista += aRiscos[ nRisco, 9 ] + '#' // "Departamento:"
			cLista += aRiscos[ nRisco, 10 ] + '#' // "Ambiente"
			cLista += aRiscos[ nRisco, 11 ] + '#' // "Quantidade do Agente de Risco:"
			cLista += aRiscos[ nRisco, 12 ] + '#' // "Tipo de Exposição:"
			cLista += aRiscos[ nRisco, 13 ] + '#' // "Limite de tolerância NR-15:"
			cLista += aRiscos[ nRisco, 14 ] + '#' // "Limite de tolerância ACGIH:"
			cLista += aRiscos[ nRisco, 25 ] + '#' // "Limite de tolerância NHO-01:"
			cLista += aRiscos[ nRisco, 15 ] + '#' // "Funcionários Expostos:"
			cLista += aRiscos[ nRisco, 16 ] + '#' // "Funcionários não expostos"

			If nOpcMat == 1
				cLista += aRiscos[ nRisco, 17 ] + '#' // "Classificação:"
			EndIf

			cLista += aRiscos[ nRisco, 18 ] + '#' // "Recomendação:"

			OLE_SetDocumentVar( oWord, 'risco', cLista )
			OLE_ExecuteMacro( oWord, 'risco' )

			cLista := ''

			If '1' $ cImprime
				fImpAti( aRiscos[ nRisco, 21 ] )
			EndIf

			If '2' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '3' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

			If '4' $ cImprime
				fImpPla( aRiscos[ nRisco, 24 ] )
			EndIf

			If nOpcMat == 2 .And. nTipoDoc == 2 .And. !Empty( aRiscos[ nRisco, 19 ] ) .And. !Empty( aRiscos[ nRisco, 20 ] )
				fImpMat( oWord, aRiscos[ nRisco, 19 ], aRiscos[ nRisco, 20 ] )
			EndIf

		Next nRisco

		If nOpcMat == 1 .And. nTipoDoc == 2 // No final
			fImpMat( oWord )
		EndIf

	ElseIf nModeloImp == 2

		For nRisco := 1 To Len( aRiscos )

			SomaLinha()
			@ Li, 60 PSay STR0592 + ' - ' + aRiscos[ nRisco, 1 ] // "Risco"

			SomaLinha()
			@ Li, 0 PSay STR0063 + Space( 1 ) + aRiscos[ nRisco, 2 ] // "Agente:"

			SomaLinha()
			@ Li, 0 PSay STR0136 + Space( 1 ) + aRiscos[ nRisco, 3 ] // "Risco:"

			SomaLinha()
			@ Li, 0 PSay STR0070 + Space( 1 ) + aRiscos[ nRisco, 4 ] // "Data de avaliação:"

			SomaLinha()
			@ Li, 0 PSay STR0091 + ': ' + aRiscos[ nRisco, 5 ] // "Fonte geradora:"

			SomaLinha()
			@ Li, 0 PSay STR0065 + Space( 1 ) + aRiscos[ nRisco, 6 ] // "Centro de custo:"

			SomaLinha()
			@ Li, 0 PSay STR0067 + Space( 1 ) + aRiscos[ nRisco, 7 ] // "Função:"

			SomaLinha()
			@ Li, 0 PSay STR0068 + Space( 1 ) + aRiscos[ nRisco, 8 ] // "Tarefa:"

			SomaLinha()
			@ Li, 0 PSay STR0487 + Space( 1 ) + aRiscos[ nRisco, 9 ] // "Departamento:"

			SomaLinha()
			@ Li, 0 PSay STR0425 + ': ' + aRiscos[ nRisco, 10 ] // "Ambiente:"

			SomaLinha()
			@ Li, 0 PSay STR0071 + Space( 1 ) + aRiscos[ nRisco, 11 ] // "Quantidade de agente do risco:"

			SomaLinha()
			@ Li, 0 PSay STR0138 + Space( 1 ) + aRiscos[ nRisco, 12 ] // "Tipo de exposição:"

			SomaLinha()
			@ Li, 0 PSay STR0623 + Space( 1 ) + aRiscos[ nRisco, 13 ] // "Limite de tolerância NR-15:"

			SomaLinha()
			@ Li, 0 PSay STR0624 + Space( 1 ) + aRiscos[ nRisco, 14 ] // "Limite de tolerância ACGIH:"

			SomaLinha()
			@ Li, 0 PSay STR0625 + Space( 1 ) + aRiscos[ nRisco, 25 ] // "Limite de tolerância NHO-01:"

			SomaLinha()
			@ Li, 0 PSay STR0173 + Space( 1 ) + aRiscos[ nRisco, 15 ] // "Funcionários expostos:"

			SomaLinha()
			@ Li, 0 PSay STR0517 + ': ' + aRiscos[ nRisco, 16 ] // "Funcionários não expostos:"

			If nOpcMat == 1 .Or. nOpcMat == 2
				SomaLinha()
				@ Li, 0 PSay STR0367 + Space( 1 ) + aRiscos[ nRisco, 17 ] // "Classificação:"
			EndIf

			SomaLinha()
			nMemo := MlCount( aRiscos[ nRisco, 18 ], 120 )
			@ Li, 0 PSay STR0072 // "Recomendação:"

			SomaLinha()

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				@ Li, 0 PSay MemoLine( aRiscos[ nRisco, 18 ], 120, nLinha )

			Next nMemo

			SomaLinha()

			If '1' $ cImprime
				fImpAti( aRiscos[ nRisco, 21 ] )
			EndIf

			If '2' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '3' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

			If '4' $ cImprime
				fImpPla( aRiscos[ nRisco, 24 ] )
			EndIf

		Next nRisco

	Else

		For nRisco := 1 To Len( aRiscos )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 1200, STR0592 + ' - ' + aRiscos[ nRisco, 1 ], oFont10b ) // "Risco"

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0063, oFont10b ) // "Agente:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 2 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0136, oFont10b ) // "Risco:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 3 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0070, oFont10b ) // "Data de avaliação:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 4 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0091, oFont10b ) // "Fonte geradora:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 5 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0065, oFont10b ) // "Centro de custo:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 6 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0067, oFont10b ) // "Função:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 7 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0068, oFont10b ) // "Tarefa:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 8 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0487, oFont10b ) // "Departamento:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 9 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0425 + ':', oFont10b ) // "Ambiente"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 10 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0071, oFont10b ) // "Quantidade de agente do risco:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 11 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0138, oFont10b ) // "Tipo de exposição:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 12 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0623, oFont10b ) // "Limite de tolerância NR-15:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 13 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0624, oFont10b ) // "Limite de tolerância ACGIH:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 14 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0625, oFont10b ) // "Limite de tolerância NHO-01:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 25 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0173, oFont10b ) // "Funcionários expostos:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 15 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0517, oFont10b ) // "Funcionários não expostos:"
			oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 16 ], oFont10 )

			If nOpcMat == 1
				SomaLinha()
				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0367, oFont10b ) // "Classificação:"
				oPrintPPRA:Say( lin + 15, 900, aRiscos[ nRisco, 17 ], oFont10 )
			EndIf

			SomaLinha()
			nMemo := MlCount( aRiscos[ nRisco, 18 ], 110 )
			oPrintPPRA:Box( lin, 150, lin + ( 60 * nMemo ) + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0072, oFont10b ) // "Recomendação:"

			SomaLinha()

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				oPrintPPRA:Say(lin + 15, 170, MemoLine( aRiscos[ nRisco, 18 ], 110, nLinha ), oFont10 )

			Next nMemo

			SomaLinha()

			If nOpcMat == 2 .And. nTipoDoc == 2 // Em cada risco
				fImpMat( Nil, aRiscos[ nRisco, 19 ], aRiscos[ nRisco, 20 ] )
			EndIf

			If '1' $ cImprime
				fImpAti( aRiscos[ nRisco, 21 ] )
			EndIf

			If '2' $ cImprime
				fImpExp( aRiscos[ nRisco, 22 ] )
			EndIf

			If '3' $ cImprime
				fImpNaoExp( aRiscos[ nRisco, 23 ] )
			EndIf

			If '4' $ cImprime
				fImpPla( aRiscos[ nRisco, 24 ] )
			EndIf

		Next nRisco

		If nOpcMat == 1 .And. nTipoDoc == 2 // No final
			fImpMat()
		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpMat
Imprime a matriz de risco no word

@author Gabriel Sokacheski
@since 22/07/2022

@param, oWord, objeto de impressão
@param, cSev, severidade do risco acontecer
@param, cPro, probabilidade do risco acontecer

/*/
//-------------------------------------------------------------------
Static Function fImpMat( oWord, cSev, cPro )

	Local cTitulos := ''

	Local nLetra := 0
	Local nLinha := 0

	Local oAzul
	Local oBege
	Local oVerde
	Local oAmarelo
	Local oVermelho

	Default cPro := ''
	Default cSev := ''

	If nModeloImp == 1

		cTitulos += STR0599 + '#' // "Matriz de risco"
		cTitulos += STR0600 + '#' // "Severidade"
		cTitulos += STR0150 + '#' // "Leve"
		cTitulos += STR0601 + '#' // "Menor"
		cTitulos += STR0602 + '#' // "Moderada"
		cTitulos += STR0603 + '#' // "Maior"
		cTitulos += STR0604 + '#' // "Extrema"
		cTitulos += STR0605 + '#' // "Probabilidade"
		cTitulos += STR0606 + '#' // "Muito provável"
		cTitulos += STR0607 + '#' // "Provável"
		cTitulos += STR0608 + '#' // "Possível"
		cTitulos += STR0609 + '#' // "Pouco provável"
		cTitulos += STR0610 + '#' // "Rara"
		cTitulos += STR0611 + '#' // "Legenda do risco"
		cTitulos += STR0612 + '#' // "Trivial"
		cTitulos += STR0613 + '#' // "Tolerável"
		cTitulos += STR0614 + '#' // "Moderado"
		cTitulos += STR0615 + '#' // "Substancial"
		cTitulos += STR0616 + '#' // "Intolerável"

		OLE_SetDocumentVar( oWord, 'matriz', cTitulos )
		OLE_SetDocumentVar( oWord, 'severidade', cSev )
		OLE_SetDocumentVar( oWord, 'probabilidade', cPro )

		OLE_ExecuteMacro( oWord, 'matriz_risco' )

	ElseIf nModeloImp == 3

		oAzul := TBrush():New( Nil, RGB( 156, 194, 229 ) )
		oBege := TBrush():New( Nil, RGB( 244, 176, 131 ) )
		oVerde := TBrush():New( Nil, RGB( 168, 208, 141 ) )
		oAmarelo := TBrush():New( Nil, RGB( 255, 217, 102 ) )
		oVermelho := TBrush():New( Nil, RGB( 196, 89, 17 ) )

		SomaLinha( 3100 ) // Nova página

		oPrintPPRA:FillRect( { lin + 180, 600, lin + 360, 958 }, oVerde ) // Cor E1
		oPrintPPRA:FillRect( { lin + 180, 958, lin + 360, 1316 }, oAmarelo ) // Cor E2
		oPrintPPRA:FillRect( { lin + 180, 1316, lin + 360, 1674 }, oBege ) // Cor E3
		oPrintPPRA:FillRect( { lin + 180, 1674, lin + 360, 2032 }, oVermelho ) // Cor E4
		oPrintPPRA:FillRect( { lin + 180, 2032, lin + 360, 2390 }, oVermelho ) // Cor E5
		oPrintPPRA:FillRect( { lin + 360, 600, lin + 540, 958 }, oVerde ) // Cor D1
		oPrintPPRA:FillRect( {  lin + 360, 958, lin + 540, 1316 }, oVerde ) // Cor D2
		oPrintPPRA:FillRect( { lin + 360, 1316, lin + 540, 1674 }, oAmarelo ) // Cor D3
		oPrintPPRA:FillRect( { lin + 360, 1674, lin + 540, 2032 }, oBege ) // Cor D4
		oPrintPPRA:FillRect( { lin + 360, 2032, lin + 540, 2390 }, oVermelho ) // Cor D5
		oPrintPPRA:FillRect( { lin + 540, 600, lin + 720, 958 }, oAzul ) // Cor C1
		oPrintPPRA:FillRect( { lin + 540, 958, lin + 720, 1316 }, oVerde ) // Cor C2
		oPrintPPRA:FillRect( { lin + 540, 1316, lin + 720, 1674 }, oAmarelo ) // Cor C3
		oPrintPPRA:FillRect( { lin + 540, 1674, lin + 720, 2032 }, oBege ) // Cor C4
		oPrintPPRA:FillRect( { lin + 540, 2032, lin + 720, 2390 }, oVermelho ) // Cor C5
		oPrintPPRA:FillRect( { lin + 720, 600, lin + 900, 958 }, oAzul ) // Cor B1
		oPrintPPRA:FillRect( { lin + 720, 958, lin + 900, 1316 }, oVerde ) // Cor B2
		oPrintPPRA:FillRect( { lin + 720, 1316, lin + 900, 1674 }, oAmarelo ) // Cor B3
		oPrintPPRA:FillRect( { lin + 720, 1674, lin + 900, 2032 }, oAmarelo ) // Cor B4
		oPrintPPRA:FillRect( { lin + 720, 2032, lin + 900, 2390 }, oBege ) // Cor B5
		oPrintPPRA:FillRect( { lin + 900, 600, lin + 1080, 958 }, oAzul ) // Cor A1
		oPrintPPRA:FillRect( { lin + 900, 958, lin + 1080, 1316 }, oAzul ) // Cor A2
		oPrintPPRA:FillRect( { lin + 900, 1316, lin + 1080, 1674 }, oVerde ) // Cor A3
		oPrintPPRA:FillRect( { lin + 900, 1674, lin + 1080, 2032 }, oAmarelo ) // Cor A4
		oPrintPPRA:FillRect( { lin + 900, 2032, lin + 1080, 2390 }, oAmarelo ) // Cor A5
		oPrintPPRA:Box( lin, 150, lin + 180, 2390 ) // Box da parte superior
		oPrintPPRA:Box( lin, 150, lin + 180, 600 ) // Box da matriz de risco
		oPrintPPRA:Say( lin + 80, 250, STR0599, oFont10 )
		oPrintPPRA:Box( lin, 600, lin + 60, 2390 ) // Box da severidade
		oPrintPPRA:Say( lin + 10, 1400, STR0600, oFont10 )
		oPrintPPRA:Box( lin + 60, 600, lin + 180, 958 ) // Box da severidade 1
		oPrintPPRA:Say( lin + 70, 730, STR0150, oFont10 )
		oPrintPPRA:Say( lin + 130, 760, '1', oFont10 )
		oPrintPPRA:Box( lin + 60, 958, lin + 180, 1316 ) // Box da severidade 2
		oPrintPPRA:Say( lin + 70, 1080, STR0601, oFont10 )
		oPrintPPRA:Say( lin + 130, 1110, '2', oFont10 )
		oPrintPPRA:Box( lin + 60, 1316, lin + 180, 1674 ) // Box da severidade 3
		oPrintPPRA:Say( lin + 70, 1420, STR0602, oFont10 )
		oPrintPPRA:Say( lin + 130, 1480, '3', oFont10 )
		oPrintPPRA:Box( lin + 60, 1674, lin + 180, 2032 ) // Box da severidade 4
		oPrintPPRA:Say( lin + 70, 1800, STR0603, oFont10 )
		oPrintPPRA:Say( lin + 130, 1830, '4', oFont10 )
		oPrintPPRA:Box( lin + 60, 2032, lin + 180, 2390 ) // Box da severidade 5
		oPrintPPRA:Say( lin + 70, 2150, STR0604, oFont10 )
		oPrintPPRA:Say( lin + 130, 2190, '5', oFont10 )
		oPrintPPRA:Box( lin + 180, 150, lin + 1080, 2390 ) // Box da parte inferior
		oPrintPPRA:Box( lin + 180, 150, lin + 1080, 375 ) // Box da probabilidade
		For nLetra := 1 To Len( STR0605 )
			oPrintPPRA:Say( lin + ( 310 + 40 * nLetra ), 250, SubStr( STR0605, nLetra, 1 ), oFont10 )
		Next nLetra
		oPrintPPRA:Box( lin + 180, 375, lin + 360, 600 ) // Box da probabilidade E
		oPrintPPRA:Box( lin + 360, 375, lin + 540, 600 ) // Box da probabilidade D
		oPrintPPRA:Box( lin + 540, 375, lin + 720, 600 ) // Box da probabilidade C
		oPrintPPRA:Box( lin + 720, 375, lin + 900, 600 ) // Box da probabilidade B
		oPrintPPRA:Box( lin + 900, 375, lin + 1080, 600 ) // Box da probabilidade A
		oPrintPPRA:Box( lin + 180, 600, lin + 360, 958 ) // Box E1
		nLinha := MlCount( STR0606, 8 )
		For nLetra := 1 To nLinha
			oPrintPPRA:Say( lin + ( 160 + 60 * nLetra ), 390, MemoLine( STR0606, 8, nLetra ), oFont10 )
		Next nLetra
		oPrintPPRA:Say( lin + 250, 570, 'E', oFont10 )
		oPrintPPRA:Box( lin + 180, 375, lin + 360, 1316 ) // Box E2
		oPrintPPRA:Box( lin + 180, 375, lin + 360, 1674 ) // Box E3
		oPrintPPRA:Box( lin + 180, 375, lin + 360, 2032 ) // Box E4
		oPrintPPRA:Box( lin + 180, 375, lin + 360, 2390 ) // Box E5
		oPrintPPRA:Box( lin + 360, 600, lin + 540, 958 ) // Box D1
		oPrintPPRA:Say( lin + 430, 390, STR0607, oFont10 )
		oPrintPPRA:Say( lin + 430, 570, 'D', oFont10 )
		oPrintPPRA:Box( lin + 360, 375, lin + 540, 1316 ) // Box D2
		oPrintPPRA:Box( lin + 360, 375, lin + 540, 1674 ) // Box D3
		oPrintPPRA:Box( lin + 360, 375, lin + 540, 2032 ) // Box D4
		oPrintPPRA:Box( lin + 360, 375, lin + 540, 2390 ) // Box D5
		oPrintPPRA:Box( lin + 540, 600, lin + 720, 958 ) // Box C1
		oPrintPPRA:Say( lin + 610, 390, STR0608, oFont10 )
		oPrintPPRA:Say( lin + 610, 570, 'C', oFont10 )
		oPrintPPRA:Box( lin + 540, 375, lin + 720, 1316 ) // Box C2
		oPrintPPRA:Box( lin + 540, 375, lin + 720, 1674 ) // Box C3
		oPrintPPRA:Box( lin + 540, 375, lin + 720, 2032 ) // Box C4
		oPrintPPRA:Box( lin + 540, 375, lin + 720, 2390 ) // Box C5
		oPrintPPRA:Box( lin + 720, 600, lin + 900, 958 ) // Box B1
		nLinha := MlCount( STR0609, 8 )
		For nLetra := 1 To nLinha
			oPrintPPRA:Say( lin + ( 700 + 60 * nLetra ), 390, MemoLine( STR0609, 8, nLetra ), oFont10 )
		Next nLetra
		oPrintPPRA:Say( lin + 790, 570, 'B', oFont10 )
		oPrintPPRA:Box( lin + 720, 375, lin + 900, 1316 ) // Box B2
		oPrintPPRA:Box( lin + 720, 375, lin + 900, 1674 ) // Box B3
		oPrintPPRA:Box( lin + 720, 375, lin + 900, 2032 ) // Box B4
		oPrintPPRA:Box( lin + 720, 375, lin + 900, 2390 ) // Box B5
		oPrintPPRA:Box( lin + 900, 600, lin + 1080, 958 ) // Box A1
		oPrintPPRA:Say( lin + 970, 390, STR0610, oFont10 )
		oPrintPPRA:Say( lin + 970, 570, 'A', oFont10 )
		oPrintPPRA:Box( lin + 900, 375, lin + 1080, 1316 ) // Box A2
		oPrintPPRA:Box( lin + 900, 375, lin + 1080, 1674 ) // Box A3
		oPrintPPRA:Box( lin + 900, 375, lin + 1080, 2032 ) // Box A4
		oPrintPPRA:Box( lin + 900, 375, lin + 1080, 2390 ) // Box A5

		oPrintPPRA:FillRect( { lin + 1260, 150, lin + 1320, 598 }, oAzul ) // Cor Trivial
		oPrintPPRA:FillRect( { lin + 1260, 598, lin + 1320, 1046 }, oVerde ) // Cor Tolerável
		oPrintPPRA:FillRect( { lin + 1260, 1046, lin + 1320, 1494 }, oAmarelo ) // Cor Moderado
		oPrintPPRA:FillRect( { lin + 1260, 1494, lin + 1320, 1942 }, oBege ) // Cor Substancial
		oPrintPPRA:FillRect( { lin + 1260, 1942, lin + 1320, 2390 }, oVermelho ) // Cor Intolerável
		oPrintPPRA:Box( lin + 1200, 150, lin + 1260, 2390 ) // Box da legenda
		oPrintPPRA:Say( lin + 1210, 1200, STR0611, oFont10 )
		oPrintPPRA:Box( lin + 1260, 150, lin + 1320, 598 ) // Trivial
		oPrintPPRA:Say( lin + 1270, 300, STR0612, oFont10 )
		oPrintPPRA:Box( lin + 1260, 598, lin + 1320, 1046 ) // Tolerável
		oPrintPPRA:Say( lin + 1270, 750, STR0613, oFont10 )
		oPrintPPRA:Box( lin + 1260, 1046, lin + 1320, 1494 ) // Moderado
		oPrintPPRA:Say( lin + 1270, 1200, STR0614, oFont10 )
		oPrintPPRA:Box( lin + 1260, 1494, lin + 1320, 1942 ) // Substancial
		oPrintPPRA:Say( lin + 1270, 1625, STR0615, oFont10 )
		oPrintPPRA:Box( lin + 1260, 1942, lin + 1320, 2390 ) // Intolerável
		oPrintPPRA:Say( lin + 1270, 2075, STR0616, oFont10 )

		Do Case

			Case cPro == '5' .And. cSev == '1'
				oPrintPPRA:Say( lin + 250, 760, 'X', oFont10 )
			Case cPro == '5' .And. cSev == '2'
				oPrintPPRA:Say( lin + 250, 1110, 'X', oFont10 )
			Case cPro == '5' .And. cSev == '3'
				oPrintPPRA:Say( lin + 250, 1480, 'X', oFont10 )
			Case cPro == '5' .And. cSev == '4'
				oPrintPPRA:Say( lin + 250, 1830, 'X', oFont10 )
			Case cPro == '5' .And. cSev == '5'
				oPrintPPRA:Say( lin + 250, 2190, 'X', oFont10 )
			Case cPro == '4' .And. cSev == '1'
				oPrintPPRA:Say( lin + 430, 760, 'X', oFont10 )
			Case cPro == '4' .And. cSev == '2'
				oPrintPPRA:Say( lin + 430, 1110, 'X', oFont10 )
			Case cPro == '4' .And. cSev == '3'
				oPrintPPRA:Say( lin + 430, 1480, 'X', oFont10 )
			Case cPro == '4' .And. cSev == '4'
				oPrintPPRA:Say( lin + 430, 1830, 'X', oFont10 )
			Case cPro == '4' .And. cSev == '5'
				oPrintPPRA:Say( lin + 430, 2190, 'X', oFont10 )
			Case cPro == '3' .And. cSev == '1'
				oPrintPPRA:Say( lin + 610, 760, 'X', oFont10 )
			Case cPro == '3' .And. cSev == '2'
				oPrintPPRA:Say( lin + 610, 1110, 'X', oFont10 )
			Case cPro == '3' .And. cSev == '3'
				oPrintPPRA:Say( lin + 610, 1480, 'X', oFont10 )
			Case cPro == '3' .And. cSev == '4'
				oPrintPPRA:Say( lin + 610, 1830, 'X', oFont10 )
			Case cPro == '3' .And. cSev == '5'
				oPrintPPRA:Say( lin + 610, 2190, 'X', oFont10 )
			Case cPro == '2' .And. cSev == '1'
				oPrintPPRA:Say( lin + 790, 760, 'X', oFont10 )
			Case cPro == '2' .And. cSev == '2'
				oPrintPPRA:Say( lin + 790, 1110, 'X', oFont10 )
			Case cPro == '2' .And. cSev == '3'
				oPrintPPRA:Say( lin + 790, 1480, 'X', oFont10 )
			Case cPro == '2' .And. cSev == '4'
				oPrintPPRA:Say( lin + 790, 1830, 'X', oFont10 )
			Case cPro == '2' .And. cSev == '5'
				oPrintPPRA:Say( lin + 790, 2190, 'X', oFont10 )
			Case cPro == '1' .And. cSev == '1'
				oPrintPPRA:Say( lin + 970, 760, 'X', oFont10 )
			Case cPro == '1' .And. cSev == '2'
				oPrintPPRA:Say( lin + 970, 1110, 'X', oFont10 )
			Case cPro == '1' .And. cSev == '3'
				oPrintPPRA:Say( lin + 970, 1480, 'X', oFont10 )
			Case cPro == '1' .And. cSev == '4'
				oPrintPPRA:Say( lin + 970, 1830, 'X', oFont10 )
			Case cPro == '1' .And. cSev == '5'
				oPrintPPRA:Say( lin + 970, 2190, 'X', oFont10 )

		EndCase

		SomaLinha( 3100 ) // Nova página

		oAzul:End()
		oBege:End()
		oVerde:End()
		oAmarelo:End()
		oVermelho:End()

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusAti
Busca as atividades na função do risco

@author Gabriel Sokacheski
@since 10/06/2022

@return aAti, array, lista de atividades
/*/
//-------------------------------------------------------------------
Static Function fBusAti()

	Local aAti := {}

	Local cFilSRJ := xFilial( 'SRJ', cFil )
	Local cImprime := IIf( nModeloImp == 1, mv_par19, mv_par17 )

	If '1' $ cImprime

		If AllTrim( TN0->TN0_CODFUN ) == '*'

			dbSelectArea( 'SRJ' )
			dbSetOrder( 1 )

			If dbSeek( cFilSRJ )

				While ( 'SRJ' )->( !Eof() ) .And. SRJ->RJ_FILIAL == cFilSRJ

					aAdd( aAti, {;
						Capital( AllTrim( SRJ->RJ_DESC ) ),;
						Capital( AllTrim(  NgMemo( SRJ->RJ_DESCREQ, Nil, 'RDY', cFil ) ) );
					} )

					( 'SRJ' )->( dbSkip() )

				End

			EndIf

		Else

			aAdd( aAti, {;
				Capital( AllTrim( SRJ->RJ_DESC ) ),;
				Capital( AllTrim( NgMemo( SRJ->RJ_DESCREQ, Nil, 'RDY', cFil ) ) );
			} )

		EndIf

	EndIf

Return aAti

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpAti
Imprime as atividades na função do risco

@author Gabriel Sokacheski
@since 14/06/2022

@param, aAti, array, contendo as atividades do risco
/*/
//-------------------------------------------------------------------
Static Function fImpAti( aAti )

	Local cLista := ''

	Local nAti := 0
	Local nMemo := 0
	Local nLinha := 0

	If nModeloImp == 1

		cLista += SubStr( STR0087, 1, Len( STR0087 ) - 1 ) + '@' // "Descrições das Atividades:"

		For nAti := 1 To Len( aAti )
			cLista += aAti[ nAti, 1 ] + ':' + '#'
			cLista += aAti[ nAti, 2 ] + '$'
		Next

		OLE_SetDocumentVar( oWord, 'atividades', cLista )
		OLE_ExecuteMacro( oWord, 'atividades' )

	ElseIf nModeloImp == 2

		SomaLinha()
		@ Li, 55 PSay SubStr( STR0087, 1, Len( STR0087 ) - 1 )  // "Descrições das Atividades:"

		SomaLinha()

		For nAti := 1 To Len( aAti )

			@ Li, 0 PSay aAti[ nAti, 1 ] + ':'

			SomaLinha()
			nMemo := MlCount( aAti[ nAti, 2 ], 120 )

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				@ Li, 0 PSay MemoLine( aAti[ nAti, 2 ], 120, nLinha )

			Next nMemo

			SomaLinha()

		Next

	Else

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 1100, SubStr( STR0087, 1, Len( STR0087 ) - 1 ), oFont10b ) // "Descrições das Atividades:"

		SomaLinha()

		For nAti := 1 To Len( aAti )

			nMemo := MlCount( aAti[ nAti, 2 ], 110 )
			oPrintPPRA:Box( lin, 150, lin + ( 60 * nMemo ) + 60, 2390 )
			oPrintPPRA:Say(lin + 15, 170, aAti[ nAti, 1 ] + ':', oFont10b )
			SomaLinha()

			For nLinha := 1 To nMemo

				If nLinha != 1
					SomaLinha()
				EndIf

				oPrintPPRA:Say(lin + 15, 170, MemoLine( aAti[ nAti, 2 ], 110, nLinha ), oFont10 )

			Next nMemo

			SomaLinha()

		Next

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusExp
Busca os funcionários expostos ao Risco

@author	Gabriel Sokacheski
@since 13/06/2022

@param lImprime, indica se deve montar a lista com os nomes dos
funcionários

@return aExp, quantidade e a lista dos funcionários expostos
/*/
//-------------------------------------------------------------------
Static Function fBusExp( lImprime )

	// Variáveis
	Local aExp := {}

	Local cCenCus := TN0->TN0_CC
	Local cFuncao := TN0->TN0_CODFUN
	Local cTarefa := TN0->TN0_CODTAR
	Local cDepart := TN0->TN0_DEPTO
	Local cAliasFun := GetNextAlias()

	Local dAva := TN0->TN0_DTAVAL
	Local dEli := TN0->TN0_DTELIM

	Local nFun := 0

	// Controle de filial
	Local cTN6 := xFilial( 'TN6', cFil )
	Local cSRA := xFilial( 'SRA', cFil )

	BeginSQL Alias cAliasFun

		SELECT 
			COUNT( SRA.RA_MAT ) AS QTDFUN
		FROM 
			%table:SRA% SRA
				LEFT JOIN %table:TN6% TN6 ON
					SRA.RA_MAT = TN6.TN6_MAT
					AND %exp:cTN6% = TN6.TN6_FILIAL
					AND (
						( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
						OR (
							TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
							AND NOT(
								( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
								OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
							)
						)
						OR (
							TN6.TN6_DTTERM != ''
							AND %exp:dEli% = ''
							AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
						)
						OR (
							TN6.TN6_DTTERM = ''
							AND %exp:dEli% != ''
							AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
						)
					)
					AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
					AND TN6.%NotDel%
		WHERE
			SRA.RA_FILIAL = %exp:cSRA%
			AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
			AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
			AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
			AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
			AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
			AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
			AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
			AND SRA.%NotDel%

	EndSQL

	dbSelectArea( cAliasFun )
	( cAliasFun )->( dbGoTop() )

	If ( cAliasFun )->( !Eof() )
		nFun := ( cAliasFun )->( QTDFUN )
	EndIf

	( cAliasFun )->( dbCloseArea() )

	If lImprime

		cAliasFun := GetNextAlias()

		BeginSQL Alias cAliasFun

			SELECT 
				SRA.RA_MAT, SRA.RA_NOME
			FROM 
				%table:SRA% SRA
					LEFT JOIN %table:TN6% TN6 ON
						SRA.RA_MAT = TN6.TN6_MAT
						AND %exp:cTN6% = TN6.TN6_FILIAL
						AND (
							( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
							OR (
								TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
								AND NOT(
									( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
								)
							)
							OR (
								TN6.TN6_DTTERM != ''
								AND %exp:dEli% = ''
								AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
							)
							OR (
								TN6.TN6_DTTERM = ''
								AND %exp:dEli% != ''
								AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
							)
						)
						AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
						AND TN6.%NotDel%
			WHERE
				SRA.RA_FILIAL = %exp:cSRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
				AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
				AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
				AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
				AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
				AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
				AND SRA.%NotDel%
			GROUP BY SRA.RA_MAT, SRA.RA_NOME
			ORDER BY SRA.RA_MAT

		EndSQL

		dbSelectArea( cAliasFun )
		( cAliasFun )->( dbGoTop() )

		While ( cAliasFun )->( !Eof() )

			aAdd( aExp, {;
				AllTrim( RA_MAT ),;
				Capital( AllTrim( RA_NOME ) );
			} )

			( cAliasFun )->( dbSkip() )

		End

		( cAliasFun )->( dbCloseArea() )

	EndIf

Return { nFun, aExp }

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpExp
Imprime os funcionários expostos ao Risco

@author Gabriel Sokacheski
@since 14/06/2022

@param, aExp, array, contendo os expostos ao risco
/*/
//-------------------------------------------------------------------
Static Function fImpExp( aExp )

	Local cLista := ''

	Local nFun := 0
	Local nExp := Len( aExp )

	If nExp > 0

		If nModeloImp == 1

			cLista += SubStr( STR0173, 1, Len( STR0173 ) - 1 ) + '@' // "Funcionários Expostos:"
			cLista += STR0303 + '#' // "Matrícula"
			cLista += STR0096 + '#' // "Nome"

			For nFun := 1 To nExp
				cLista += aExp[ nFun, 1 ] + '$'
				cLista += aExp[ nFun, 2 ] + '$'
			Next

			OLE_SetDocumentVar( oWord, 'funcionarios_expostos', cLista )
			OLE_SetDocumentVar( oWord, 'numero_funcionarios_expostos', nExp )
			OLE_ExecuteMacro( oWord, 'expostos' )

		ElseIf nModeloImp == 2

			SomaLinha()
			@ Li, 55 PSay SubStr( STR0173, 1, Len( STR0173 ) - 1 )  // "Funcionários Expostos:"

			SomaLinha()

			For nFun := 1 To nExp

				@ Li, 0 PSay aExp[ nFun, 1 ] + ' - ' + aExp[ nFun, 2 ]

				SomaLinha()

			Next

			SomaLinha()

		Else

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 1100, SubStr( STR0173, 1, Len( STR0173 ) - 1 ), oFont10b ) // "Funcionários Expostos:"

			SomaLinha()

			For nFun := 1 To nExp

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 500, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, aExp[ nFun, 1 ], oFont10 )
				oPrintPPRA:Say( lin + 15, 520, aExp[ nFun, 2 ], oFont10 )

				SomaLinha()

			Next

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusNaoExp
Busca os funcionários não expostos ao Risco

@author	Gabriel Sokacheski
@since 13/06/2022

@param lImprime, indica se deve montar a lista com os nomes dos
funcionários

@return aExp, quantidade e a lista dos funcionários não expostos
/*/
//-------------------------------------------------------------------
Static Function fBusNaoExp( lImprime )

	// Variáveis
	Local aNaoExp := {}

	Local cCenCus := TN0->TN0_CC
	Local cFuncao := TN0->TN0_CODFUN
	Local cTarefa := TN0->TN0_CODTAR
	Local cDepart := TN0->TN0_DEPTO
	Local cAliasFun := GetNextAlias()

	Local dAva := TN0->TN0_DTAVAL
	Local dEli := TN0->TN0_DTELIM

	Local nFun := 0

	// Controle de filial
	Local cTN6 := xFilial( 'TN6', cFil )
	Local cSRA := xFilial( 'SRA', cFil )

	BeginSQL Alias cAliasFun

			SELECT
				COUNT( SRA.RA_MAT ) AS QTDFUN
			FROM
				%table:SRA% SRA
			WHERE
				SRA.RA_FILIAL = %exp:cSRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA < %exp:dAteLaudo%
				AND SRA.%NotDel%
				AND SRA.RA_MAT NOT IN (
					SELECT 
						SRA.RA_MAT
					FROM 
						%table:SRA% SRA
							LEFT JOIN %table:TN6% TN6 ON
								SRA.RA_MAT = TN6.TN6_MAT
								AND %exp:cTN6% = TN6.TN6_FILIAL
								AND (
									( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
									OR (
										TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
										AND NOT(
											( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
											OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
										)
									)
									OR (
										TN6.TN6_DTTERM != ''
										AND %exp:dEli% = ''
										AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									)
									OR (
										TN6.TN6_DTTERM = ''
										AND %exp:dEli% != ''
										AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
									)
								)
								AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
								AND TN6.%NotDel%
					WHERE
						SRA.RA_FILIAL = %exp:cSRA%
						AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
						AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
						AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
						AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
						AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
						AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
						AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
						AND SRA.%NotDel%
					GROUP BY SRA.RA_MAT
				)

		EndSQL

		dbSelectArea( cAliasFun )
		dbGoTop()

		If ( cAliasFun )->( !Eof() )
			nFun := ( cAliasFun )->( QTDFUN )
		EndIf

	( cAliasFun )->( dbCloseArea() )

	If lImprime

		cAliasFun := GetNextAlias()

		BeginSQL Alias cAliasFun

			SELECT
				SRA.RA_MAT, SRA.RA_NOME
			FROM
				%table:SRA% SRA
			WHERE
				SRA.RA_FILIAL = %exp:cSRA%
				AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
				AND SRA.RA_ADMISSA < %exp:dAteLaudo%
				AND SRA.%NotDel%
				AND SRA.RA_MAT NOT IN (
					SELECT 
						SRA.RA_MAT
					FROM 
						%table:SRA% SRA
							LEFT JOIN %table:TN6% TN6 ON
								SRA.RA_MAT = TN6.TN6_MAT
								AND %exp:cTN6% = TN6.TN6_FILIAL
								AND (
									( TN6.TN6_DTTERM = '' AND %exp:dEli% = '' )
									OR (
										TN6.TN6_DTTERM != '' AND %exp:dEli% != ''
										AND NOT(
											( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
											OR ( TN6.TN6_DTINIC > %exp:dEli% AND TN6.TN6_DTTERM > %exp:dEli% )
										)
									)
									OR (
										TN6.TN6_DTTERM != ''
										AND %exp:dEli% = ''
										AND NOT( TN6.TN6_DTINIC < %exp:dAva% AND TN6.TN6_DTTERM < %exp:dAva% )
									)
									OR (
										TN6.TN6_DTTERM = ''
										AND %exp:dEli% != ''
										AND NOT( %exp:dAva% < TN6.TN6_DTINIC AND %exp:dEli% < TN6.TN6_DTINIC )
									)
								)
								AND TN6.TN6_DTINIC <= %exp:dAteLaudo%
								AND TN6.%NotDel%
					WHERE
						SRA.RA_FILIAL = %exp:cSRA%
						AND ( SRA.RA_SITFOLH != 'D' OR SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:dAteLaudo% )
						AND SRA.RA_ADMISSA <= %exp:dAteLaudo%
						AND ( SRA.RA_ADMISSA <= %exp:dEli% OR %exp:dEli% = '' )
						AND ( %exp:cCenCus% = '*' OR SRA.RA_CC = %exp:cCenCus% )
						AND ( %exp:cFuncao% = '*' OR SRA.RA_CODFUNC = %exp:cFuncao% )
						AND ( %exp:cDepart% = '*' OR SRA.RA_DEPTO = %exp:cDepart% )
						AND ( %exp:cTarefa% = '*' OR TN6.TN6_CODTAR = %exp:cTarefa% )
						AND SRA.%NotDel%
					GROUP BY SRA.RA_MAT
				)
			GROUP BY SRA.RA_MAT, SRA.RA_NOME
			ORDER BY SRA.RA_MAT

		EndSQL

		dbSelectArea( cAliasFun )
		dbGoTop()

		While ( cAliasFun )->( !Eof() )

			aAdd( aNaoExp, {;
				AllTrim( ( cAliasFun )->RA_MAT ),;
				Capital( AllTrim( ( cAliasFun )->RA_NOME ) );
			} )

			( cAliasFun )->( dbSkip() )

		End

		( cAliasFun )->( dbCloseArea() )

	EndIf

Return { nFun, aNaoExp }

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpNaoExp
Imprime os funcionários não expostos ao Risco

@author Gabriel Sokacheski
@since 14/06/2022

@param, aRiscos, array, contendo os riscos impressos
@param, nRisco, numérico, contendo o número do risco posicionado
/*/
//-------------------------------------------------------------------
Static Function fImpNaoExp( aNaoExp )

	Local cLista 	:= ''

	Local nFun 		:= 0 // Controlador do for
	Local nVezes	:= 1 // Quantidade de vezes que a macro foi executada novamente
	Local nNaoExp 	:= Len( aNaoExp ) // Quantidade total de funcionários a ser impressa
	Local nLimite 	:= 500 // Limite de registros impressos por vez
	Local nRegImp 	:= IIf( nNaoExp > nLimite, nLimite, nNaoExp ) // Número de registros que será impresso na vez
	Local nTotalFun := nNaoExp // Total de funcionários
	Local nVezesImp := 1 // Controlador do while

	If nNaoExp > 0

		If nModeloImp == 1

			cLista += STR0517 + '@' // "Funcionários não expostos"
			cLista += STR0303 + '#' // "Matrícula"
			cLista += STR0096 + '#' // "Nome"

			For nFun := 1 To nRegImp
				cLista += aNaoExp[ nFun, 1 ] + '$'
				cLista += aNaoExp[ nFun, 2 ] + '$'
			Next

			OLE_SetDocumentVar( oWord, 'funcionarios_nao_expostos', cLista )
			OLE_SetDocumentVar( oWord, 'numero_funcionarios_nao_expostos', nNaoExp )
			OLE_SetDocumentVar( oWord, 'limite_funcionarios_nao_expostos', nLimite )
			OLE_ExecuteMacro( oWord, 'nao_expostos' )

			nNaoExp -= nLimite

			While nNaoExp > 0

				cLista := ''

				nFun := ( nLimite * nVezes + 1 )
				nRegImp := nTotalFun - ( nLimite * nVezes )
				nVezesImp := 1

				While nVezesImp <= nRegImp .And. nVezesImp <= nNaoExp

					cLista += aNaoExp[ nFun, 1 ] + '$'
					cLista += aNaoExp[ nFun, 2 ] + '$'

					nFun++
					nVezesImp++

				End

				nVezes += 1

				OLE_SetDocumentVar( oWord, 'funcionarios_nao_expostos', cLista )
				OLE_SetDocumentVar( oWord, 'numero_funcionarios_nao_expostos', nNaoExp )
				OLE_SetDocumentVar( oWord, 'limite_funcionarios_nao_expostos', nLimite )
				OLE_ExecuteMacro( oWord, 'nao_expostos_continuacao' )

				nNaoExp -= nLimite

			End

		ElseIf nModeloImp == 2

			SomaLinha()
			@ Li, 55 PSay STR0517  // "Funcionários não expostos"

			SomaLinha()

			For nFun := 1 To nNaoExp

				@ Li, 0 PSay aNaoExp[ nFun, 1 ] + ' - ' + aNaoExp[ nFun, 2 ]

				SomaLinha()

			Next

			SomaLinha()

		Else

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 1100, STR0517, oFont10b ) // "Funcionários não expostos"

			SomaLinha()

			For nFun := 1 To nNaoExp

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 500, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, aNaoExp[ nFun, 1 ], oFont10 )
				oPrintPPRA:Say( lin + 15, 520, aNaoExp[ nFun, 2 ], oFont10 )

				SomaLinha()

			Next

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fBusPla
Busca os planos de ação do risco

@author Gabriel Sokacheski
@since 14/06/2022

@return aAti, array, lista de planos de ação
/*/
//-------------------------------------------------------------------
Static Function fBusPla()

	Local aPlanos := {}
	Local aRespon := {}

	Local cRespon := ''

	Local cFilTNJ := xFilial( 'TNJ', cFil )
	Local cFilTAA := xFilial( 'TAA', cFil )
	Local cFilTC9 := xFilial( 'TC9', cFil )
	Local cImprime := IIf( nModeloImp == 1, mv_par19, mv_par17 )

	If '4' $ cImprime

		dbSelectArea( 'TNJ' )
		dbSetOrder( 1 )

		If dbSeek( cFilTNJ + TN0->TN0_NUMRIS)

			While ( 'TNJ' )->( !Eof() ) .And. cFilTNJ + TN0->TN0_NUMRIS == TNJ->TNJ_FILIAL + TNJ->TNJ_NUMRIS

				dbSelectArea( 'TAA' )
				dbSetOrder( 1 )

				If dbSeek( cFilTAA + TNJ->TNJ_CODPLA )

					dbSelectArea( 'TC9' )
					dbSetOrder( 1 )

					If dbSeek( cFilTC9 + TAA->TAA_CODPLA )

						While ( 'TC9' )->( !Eof() ) .And. cFilTC9 + TC9->TC9_CODPLA == cFilTAA + TAA->TAA_CODPLA

							If TC9->TC9_TIPRES == '2'
								cRespon := Posicione( 'SRA', 1, xFilial( 'SRA', cFil ) + SubStr( TC9->TC9_CODRES, 1, 6 ), 'RA_NOME' )
							Else
								cRespon := Posicione( 'QAA', 1, xFilial( 'QAA', cFil ) + TC9->TC9_CODRES, 'QAA_NOME' )
							EndIf

							aAdd( aRespon, Capital( AllTrim( cRespon ) ) )

							( 'TC9' )->( dbSkip() )

						End

					EndIf

					aAdd( aPlanos, {;
						Capital( AllTrim( TAA->TAA_NOME ) ),;
						Capital( AllTrim( TAA->TAA_OQUE ) ),;
						Capital( AllTrim( TAA->TAA_ONDE ) ),;
						Capital( AllTrim( TAA->TAA_PORQUE ) ),;
						Capital( AllTrim( TAA->TAA_COMO ) ),;
						DtoC( TAA->TAA_DTIMPL ),;
						DtoC( TAA->TAA_DTINPR ),;
						DtoC( TAA->TAA_DTFIPR ),;
						DtoC( TAA->TAA_DTINRE ),;
						DtoC( TAA->TAA_DTFIRE ),;
						AllTrim( Str( TAA->TAA_CUSTOP ) ),;
						AllTrim( Str( TAA->TAA_CUSTOR ) ),;
						AllTrim( Str( TAA->TAA_QTDATU ) ),;
						AllTrim( Str( TAA->TAA_META ) ),;
						AllTrim( Str( TAA->TAA_QTDFIM ) ),;
						aRespon;
					} )

				EndIf

				( 'TNJ' )->( dbSkip() )

			End

		EndIf

	EndIf

Return aPlanos

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpPla
Imprime os planos de ação do risco

@author Gabriel Sokacheski
@since 14/06/2022

@param, aPlanos, array, contendo os planos
/*/
//-------------------------------------------------------------------
Static Function fImpPla( aPlanos )

	Local cLista := ''
	Local cTitulos := ''

	Local nPla := 0
	Local nRes := 0

	If nModeloImp == 1

		cTitulos += SubStr( STR0178, 1, Len( STR0178 ) - 1 ) + '@' // "Plano de ação:"
		cTitulos += STR0377 + '#' // "Descrição:"
		cTitulos += AllTrim( STR0182 ) + '#' // "O que?:"
		cTitulos += AllTrim( STR0183 ) + '#' // "Onde?"
		cTitulos += AllTrim( STR0184 ) + '#' // "Por que?"
		cTitulos += AllTrim( STR0185 ) + '#'  // "Como?"
		cTitulos += STR0594 + ':' + '#' // "Data da implantação"
		cTitulos += AllTrim( STR0187 ) + '#' // "Início previsto:"
		cTitulos += AllTrim( STR0188 ) + '#' // "Fim previsto:"
		cTitulos += AllTrim( STR0189 ) + '#' // "Inicio real:"
		cTitulos += AllTrim( STR0190 ) + '#' // "Fim real:"
		cTitulos += AllTrim( STR0191 ) + '#' // "Custo previsto:"
		cTitulos += AllTrim( STR0192 ) + '#' // "Custo real:"
		cTitulos += STR0595 + ':' + '#' // "Quantidade atual"
		cTitulos += STR0597 + ':' + '#' // "Quantidade meta"
		cTitulos += STR0596 + ':' + '#' // "Quantidade final"
		cTitulos += STR0407 + '#' // "Responsáveis"

		OLE_SetDocumentVar( oWord, 'titulos_plano', cTitulos )

		For nPla := 1 To Len( aPlanos )

			cLista += aPlanos[ nPla, 1 ] + '#'
			cLista += aPlanos[ nPla, 2 ] + '#'
			cLista += aPlanos[ nPla, 3 ] + '#'
			cLista += aPlanos[ nPla, 4 ] + '#'
			cLista += aPlanos[ nPla, 5 ] + '#'
			cLista += aPlanos[ nPla, 6 ] + '#'
			cLista += aPlanos[ nPla, 7 ] + '#'
			cLista += aPlanos[ nPla, 8 ] + '#'
			cLista += aPlanos[ nPla, 9 ] + '#'
			cLista += aPlanos[ nPla, 10 ] + '#'
			cLista += aPlanos[ nPla, 11 ] + '#'
			cLista += aPlanos[ nPla, 12 ] + '#'
			cLista += aPlanos[ nPla, 13 ] + '#'
			cLista += aPlanos[ nPla, 14 ] + '#'
			cLista += aPlanos[ nPla, 15 ] + '#'

			For nRes := 1 To Len( aPlanos[ nPla, 16 ] )
				cLista += aPlanos[ nPla, 16, nRes ] + '#'
			Next

			OLE_SetDocumentVar( oWord, 'numero_funcionarios_plano', Len( aPlanos[ nPla, 16 ] ) )
			OLE_SetDocumentVar( oWord, 'plano', cLista )
			OLE_ExecuteMacro( oWord, 'planos' )

		Next

		If Len( aPlanos ) == 0

			OLE_SetDocumentVar( oWord, 'titulo', SubStr( STR0178, 1, Len( STR0178 ) - 1 ) ) // Plano de Ação:
			OLE_SetDocumentVar( oWord, 'texto', STR0598 + '.' ) // "Não existem planos de ação vinculados ao risco"

			OLE_ExecuteMacro( oWord, 'aviso' )

		EndIf

	ElseIf nModeloImp == 2

		For nPla := 1 To Len( aPlanos )

			SomaLinha()
			@ Li, 60 PSay SubStr( STR0178, 1, Len( STR0178 ) - 1 ) // "Plano de ação:"

			SomaLinha()
			@ Li, 00 PSay STR0377 + Space( 1 ) + aPlanos[ nPla, 1 ] // "Descrição:"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0182 ) + Space( 1 ) + aPlanos[ nPla, 2 ] // "O que?"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0183 ) + Space( 1 ) + aPlanos[ nPla, 3 ] // "Onde?"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0184 ) + Space( 1 ) + aPlanos[ nPla, 4 ] // "Por que?"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0185 ) + Space( 1 ) + aPlanos[ nPla, 5 ] // "Como?"

			SomaLinha()
			@ Li, 00 PSay STR0594 + ': ' + aPlanos[ nPla, 6 ] // "Data da implantação"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0187 ) + Space( 1 ) + aPlanos[ nPla, 7 ] // "Início previsto:"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0188 ) + Space( 1 ) + aPlanos[ nPla, 8 ] // "Fim previsto:"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0189 ) + Space( 1 ) + aPlanos[ nPla, 9 ] // "Inicio real"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0190 ) + Space( 1 ) + aPlanos[ nPla, 10 ] // "Fim real:"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0191 ) + Space( 1 ) + aPlanos[ nPla, 11 ] // "Custo previsto"

			SomaLinha()
			@ Li, 00 PSay AllTrim( STR0192 ) + Space( 1 ) + aPlanos[ nPla, 12 ] // "Custo real:"

			SomaLinha()
			@ Li, 00 PSay STR0595 + ': ' + aPlanos[ nPla, 13 ] // "Quantidade atual"

			SomaLinha()
			@ Li, 00 PSay STR0597 + ': ' + aPlanos[ nPla, 14 ] // "Quantidade meta"

			SomaLinha()
			@ Li, 00 PSay STR0596 + ': ' + aPlanos[ nPla, 15 ] // "Quantidade final"

			SomaLinha()
			@ Li, 00 PSay STR0407 + ':' // "Responsáveis"

			SomaLinha()

			For nRes := 1 To Len( aPlanos[ nPla, 16 ] )

				@ Li, 00 PSay aPlanos[ nPla, 16, nRes ]
				SomaLinha()

			Next

		Next

	Else

		For nPla := 1 To Len( aPlanos )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 1200, SubStr( STR0178, 1, Len( STR0178 ) - 1 ), oFont10b ) // "Plano de ação:"

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0377, oFont10b ) // "Descrição:"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 1 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0182 ), oFont10b ) // "O que?"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 2 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0183 ), oFont10b ) // "Onde?"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 3 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0184 ), oFont10b ) // "Por que?"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 4 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0185 ), oFont10b ) // "Como?"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 5 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0594 + ':', oFont10b ) // "Data da implantação"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 6 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0187 ), oFont10b ) // "Início previsto:"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 7 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0188 ), oFont10b ) // "Fim previsto:"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 8 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0189 ), oFont10b ) // "Inicio real"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 9 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0190 ), oFont10b ) // "Fim real:"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 10 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0191 ), oFont10b ) // "Custo previsto"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 11 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, AllTrim( STR0192 ), oFont10b ) // "Custo real:"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 12 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0595 + ':', oFont10b ) // "Quantidade atual"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 13 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0597 + ':', oFont10b ) // "Quantidade meta"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 14 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Box( lin, 700, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 170, STR0596 + ':', oFont10b ) // "Quantidade final"
			oPrintPPRA:Say( lin + 15, 720, aPlanos[ nPla, 15 ], oFont10 )

			SomaLinha()
			oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
			oPrintPPRA:Say( lin + 15, 1200, STR0407, oFont10b ) // "Responsáveis"

			SomaLinha()

			For nRes := 1 To Len( aPlanos[ nPla, 16 ] )

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, aPlanos[ nPla, 16, nRes ], oFont10 )
				SomaLinha()

			Next

		Next

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850QUADFUN
Imprime listagem do numero de funcionários do sexo masculino,
feminino e tambem menores de idade

@author  Liber Ee Esteban
@since   20/0532005
@param   nModQuadro, Numérico, Modelo de quadro:
(1) Quadro de funcionários ou (2)Quadro de funcionários por setor

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850QUADFUN(nModQuadro)

	Local aArea  := GetArea(), nFor
	Local cSeekQF := xFilial( "SRA", cFil )
	Local cWhileQF	:= ".T."
	Local nIndexQF	:= 1
	Local nMasc  := 0
	Local nFemi  := 0
	Local nMenor := 0
	Local aDados := {}
	Local nTotDa := 0
	Local cCodigo := "SRA->RA_CC"
	Local cDescric := cDescrCC
	Local cFindValue
	Local lDepto := NGCADICBASE( "TN0_DEPTO", "A" , "TN0" , .F. ) //Caso utilize Departamento
	cMemo := " "

	Default nModQuadro := 1

	If lSigaMdtps
		cSeekQF := xFilial("SRA")+cCliMdtPs
		cWhileQF:= "cCliMdtPs == Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)"
		nIndexQF:= 2
	Else
		If lDepto .And. nMvDepto == 2
			cCodigo 	:= "SRA->RA_DEPTO"
			cDescric	:= "SQB->QB_DESCRIC"
		EndIf
	EndIf

	Dbselectarea("SRA")
	Dbsetorder(nIndexQF)
	MsSeek( cSeekQF ,.T.)
	While !Eof() .And. xFilial( "SRA", cFil ) == SRA->RA_FILIAL .And. &cWhileQF
		// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
		If !R850FUNC()
			DbSelectArea("SRA")
			DbSkip()
			Loop
		EndIf
		nIdade := Year(Date()) - Year(SRA->RA_NASC)
		If Month(Date()) < Month(SRA->RA_NASC)
			nIdade := nIdade - 1
		Elseif Month(Date()) == Month(SRA->RA_NASC)
			If Day(Date()) < Day(SRA->RA_NASC)
				nIdade := nIdade - 1
			EndIf
		EndIf

		If nModQuadro == 2
			cFindValue := &( cCodigo )
			nPos := aScan( aDados,{|x| x[5] == cFindValue })
			If nPos == 0
				If lDepto .And. nMvDepto == 2
					dbSelectArea("SQB")
					dbSetOrder( 1 )
					MsSeek( xFilial( "SQB", cFil ) + cFindValue )
				Else
					dbSelectArea( cAliasCC )
					dbSetOrder( 1 )
					MsSeek( xFilial( cAliasCC, cFil ) + cFindValue )
				EndIf
				aAdd( aDados , { 0, 0, 0, 0, cFindValue, &(cDescric) } )
				nPos := Len(aDados)
			EndIf
			nTotDa++
			If nIdade >= 18
				If SRA->RA_SEXO == "M"
					aDados[nPos,1]++
				Else
					aDados[nPos,2]++
				EndIf
			Else
				If SRA->RA_SEXO == "M"
					aDados[nPos,3]++
				Else
					aDados[nPos,4]++
				EndIf
			EndIf
		Else
			If nIdade < 18
				nMenor++
			Else
				If SRA->RA_SEXO == "M"
					nMasc++
				Else
					nFemi++
				EndIf
			EndIf
		EndIf

		Dbselectarea("SRA")
		Dbskip()
	End

	If nModQuadro == 2
		aSort(aDados,,,{|x,y| x[6] < y[6] })
		aAdd( aDados , { nTotDa, 0, 0, 0, Upper(STR0289), STR0349 } ) //"TOTAL" //"TOTAL DE FUNCIONÁRIOS"

		If nModeloImp == 2

			For nFor := 1 To Len(aDados)
				If nFor == 1
					Somalinha()
					If lDepto .And. nMvDepto == 2
						@ Li,000 Psay STR0497//"Quadro de Funcionários:  Departamento                               Número de Funcionários"
					Else
					@ Li,000 Psay STR0350 //"Quadro de Funcionários:  Centro de Custo                            Número de Funcionários"
					EndIf
					Somalinha()
					@ Li,000 Psay STR0351 //"                                                                     Maiores       Menores"
					Somalinha()
					@ Li,000 Psay STR0352 //"                                                                   Masc.  Fem.   Masc.  Fem."
				EndIf
				Somalinha()
				@ Li,025 Psay Substr(aDados[nFor,6],1,40)
				If Len(aDados) == nFor
					@ Li,077 Psay aDados[nFor,1]
				Else
					@ Li,067 Psay aDados[nFor,1]
					@ Li,074 Psay aDados[nFor,2]
					@ Li,081 Psay aDados[nFor,3]
					@ Li,088 Psay aDados[nFor,4]
				EndIf
			Next nFor

		ElseIf nModeloImp == 3

			If lin+240 > 3000
				lin := 9999
			EndIf
			For nFor := 1 To Len(aDados)
				If nFor == 1
					Somalinha()
					oPrintPPRA:Box(lin,150,lin+180,2300)
					oPrintPPRA:Line(lin,1500,lin+180,1500)
					oPrintPPRA:Line(lin+120,1700,lin+180,1700)
					oPrintPPRA:Line(lin+60,1900,lin+180,1900)
					oPrintPPRA:Line(lin+120,2100,lin+180,2100)
					oPrintPPRA:Line(lin+60,1500,lin+60,2300)
					oPrintPPRA:Line(lin+120,1500,lin+120,2300)
					If lDepto .And. nMvDepto == 2
						oPrintPPRA:Say(lin+70,825,STR0495,oFont08b,,,,2)
					Else
						oPrintPPRA:Say(lin+70,825,STR0353,oFont08b,,,,2) //"Centro de Custo"
					EndIf
					oPrintPPRA:Say(lin+10,1900,STR0354,oFont08b,,,,2) //"Número de Funcionários"
					oPrintPPRA:Say(lin+70,1700,STR0355,oFont08b,,,,2) //"Maiores"
					oPrintPPRA:Say(lin+70,2100,STR0356,oFont08b,,,,2) //"Menores"
					oPrintPPRA:Say(lin+130,1600,STR0357,oFont08b,,,,2) //"Masc."
					oPrintPPRA:Say(lin+130,1800,STR0358,oFont08b,,,,2) //"Fem."
					oPrintPPRA:Say(lin+130,2000,STR0357,oFont08b,,,,2) //"Masc."
					oPrintPPRA:Say(lin+130,2200,STR0358,oFont08b,,,,2) //"Fem."
					Somalinha(120)
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin,0150,lin+60,0150)
				oPrintPPRA:Line(lin,1500,lin+60,1500)
				If Len(aDados) != nFor
					oPrintPPRA:Line(lin,1700,lin+60,1700)
					oPrintPPRA:Line(lin,1900,lin+60,1900)
					oPrintPPRA:Line(lin,2100,lin+60,2100)
				EndIf
				oPrintPPRA:Line(lin,2300,lin+60,2300)
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				If Len(aDados) == nFor
					oPrintPPRA:Say(lin+10,170,SubStr(aDados[nFor,6],1,40),oFont08b)
					oPrintPPRA:Say(lin+10,1900,Alltrim(Str(aDados[nFor,1])),oFont08b,,,,2)
				Else
					oPrintPPRA:Say(lin+10,170,SubStr(aDados[nFor,6],1,40),oFont08)
					oPrintPPRA:Say(lin+10,1600,Alltrim(Str(aDados[nFor,1])),oFont08,,,,2)
					oPrintPPRA:Say(lin+10,1800,Alltrim(Str(aDados[nFor,2])),oFont08,,,,2)
					oPrintPPRA:Say(lin+10,2000,Alltrim(Str(aDados[nFor,3])),oFont08,,,,2)
					oPrintPPRA:Say(lin+10,2200,Alltrim(Str(aDados[nFor,4])),oFont08,,,,2)
				EndIf
			Next nFor

		Else

			For nFor := 1 To Len(aDados)
				cMemo += Alltrim(aDados[nFor,6])       +"#*"
				cMemo += Alltrim(Str(aDados[nFor,1],6))+"#*"
				If Len(aDados) == nFor
					cMemo += "#*"+"#*"+"#*"
				Else
					cMemo += Alltrim(Str(aDados[nFor,2],6))+"#*"
					cMemo += Alltrim(Str(aDados[nFor,3],6))+"#*"
					cMemo += Alltrim(Str(aDados[nFor,4],6))+"#*"
				EndIf
			Next nFor
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",Len(aDados))
			OLE_ExecuteMacro(oWord,"Quadro_FuncSetor")
			OLE_ExecuteMacro(oWord,"Somalinha")

		EndIf

	Else
		If nModeloImp == 2
			Somalinha()
			@ Li,000 Psay STR0126  //"Quadro de Funcionarios: Masculino  Feminino  Menor Aprendiz"
			Somalinha()
			Somalinha()
			@ Li,029 Psay nMasc
			@ Li,039 Psay nFemi
			@ Li,055 Psay nMenor
			Somalinha()
			Somalinha()
		ElseIf nModeloImp == 3
			If lin+180 > 3000 //Força quebra de pagina se o quadro nao sair na mesma pagina
				lin := 9999
			EndIf
			Somalinha()
			oPrintPPRA:Box(lin,150,lin+180,2300)
			oPrintPPRA:Line(lin+60,150,lin+60,2300)
			oPrintPPRA:Line(lin+120,150,lin+120,2300)
			oPrintPPRA:Line(lin+60,865,lin+180,865)
			oPrintPPRA:Line(lin+60,1580,lin+180,1580)
			oPrintPPRA:Say(lin+5,950,STR0248,oFont12b) //"QUADRO DE FUNCIONÁRIOS"
			Somalinha()
			oPrintPPRA:Say(lin+10,430,STR0249,oFont10b) //"Masculino"
			oPrintPPRA:Say(lin+10,1120,STR0250,oFont10b) //"Feminino"
			oPrintPPRA:Say(lin+10,1765,STR0251,oFont10b) //"Menor Aprendiz"
			Somalinha()
			oPrintPPRA:Say(lin+10,500,Alltrim(Str(nMasc,6)),oFont10)
			oPrintPPRA:Say(lin+10,1200,Alltrim(Str(nFemi,6)),oFont10)
			oPrintPPRA:Say(lin+10,1900,Alltrim(Str(nMenor,6)),oFont10)
		Else
			cMemo:=STR(nMasc,5) + "#*"
			cMemo+=STR(nFemi,5) + "#*"
			cMemo+=STR(nMenor,5) + "#*"
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_ExecuteMacro(oWord,"Quadro_Funcionario")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850EQUIP
Verifica os equipamentos do laudo e chama a função que os imprime.

@author  Denis Hyroshi de Souza
@since   08/04/2003

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850EQUIP()

	Local aArea := GetArea()

	Private _1st := .T.
	Private cMemo := ""
	Private nRegs := 0

	If lSigaMdtps

		If If(nModeloImp != 1, (mv_par06==1), (mv_par08==1))

			Dbselectarea("TO2")
			Dbsetorder(3) //TO2_FILIAL+TO2_CLIENT+TO2_LOJA+TO2_LAUDO+TO2_EQPTO
			MsSeek(xFilial("TO2") + cCliMdtPs + TO0->TO0_LAUDO)
			While !eof() .And. xFilial("TO2")+TO0->TO0_LAUDO == TO2->TO2_FILIAL+TO2->TO2_LAUDO .And. cCliMdtPs == TO2->TO2_CLIENT+TO2->TO2_LOJA
				Dbselectarea("TM7")
				dbSetOrder( 1 )
				If MsSeek(xFilial("TM7")+TO2->TO2_EQPTO)
					U_Equip850()
				EndIf
				Dbselectarea("TO2")
				Dbskip()
			End

		Else

			DbSelectArea("TM7")
			Dbsetorder(02)  //TM7_FILIAL+TM7_NOEQTO
			MsSeek(xFilial("TM7"))
			While !Eof() .And. xFilial("TM7") == TM7->TM7_FILIAL

				Dbselectarea("TO2")
				Dbsetorder(3)
				If !MsSeek(xFilial("TO2")+cCliMdtPs+TO0->TO0_LAUDO+TM7->TM7_EQPTO)
					DbSelectArea("TM7")
					DbSkip()
					Loop
				EndIf

				U_Equip850()

				DbSelectArea("TM7")
				DbSkip()
			EndDo

		EndIf

	Else

		If If(nModeloImp != 1, (mv_par04==1), (mv_par06==1))

			Dbselectarea("TO2")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TO2", cFil ) + TO0->TO0_LAUDO )
			While !Eof() .And. xFilial( "TO2", cFil ) + TO0->TO0_LAUDO == TO2->TO2_FILIAL + TO2->TO2_LAUDO
				Dbselectarea("TM7")
				dbSetOrder( 1 )
				If MsSeek( xFilial( "TM7", cFil ) + TO2->TO2_EQPTO )
					U_Equip850()
				EndIf
				Dbselectarea("TO2")
				Dbskip()
			End

		Else

			DbSelectArea("TM7")
			Dbsetorder(02)
			MsSeek( xFilial( "TM7", cFil ) )
			While !Eof() .And. xFilial( "TM7", cFil ) == TM7->TM7_FILIAL

				Dbselectarea("TO2")
				dbSetOrder( 1 )
				If !MsSeek( xFilial( "TO2", cFil ) + TO0->TO0_LAUDO + TM7->TM7_EQPTO )
					DbSelectArea("TM7")
					DbSkip()
					Loop
				EndIf

				U_Equip850()

				DbSelectArea("TM7")
				DbSkip()
			EndDo

		EndIf

	EndIf

	If nRegs > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Equipamentos")
	EndIf
	If nRegs > 0 .And. nModeloImp != 1
		Somalinha()
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850CONTR
Imprime as medidas de controle do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850CONTR()

	Local aArea := GetArea()

	Dbselectarea("TO3")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO3", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO3", cFil ) + TO0->TO0_LAUDO == TO3->TO3_FILIAL + TO3->TO3_LAUDO
		Dbselectarea("TO4")
		dbSetOrder( 1 )
		If MsSeek( xFilial( "TO4", cFil ) + TO3->TO3_CONTRO )
			lPrint := .T.
			If nModeloImp != 1
				U_IMPDOC850(Capital(AllTrim(TO4->TO4_NOMCTR))+": "+Alltrim(TO3->TO3_DESCRI))
			Else
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_ExecuteMacro(oWord,"Nao_Identar")
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"ativar_negrito")
				OLE_SetDocumentVar(oWord,cVar1,Capital(AllTrim(TO4->TO4_NOMCTR))+": ")

				U_IMPDOC850(Alltrim(TO3->TO3_DESCRI),.F.,.T.)
			EndIf
		EndIf
		Dbselectarea("TO3")
		Dbskip()
	End

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850SESMT
Imprime os componentes do Sesmt

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850SESMT()

	Local aArea := GetArea()
	Local aSesmt := {}, nFor
	Store 0 To nMedTrab,nEnfTrab,nAuxTrab,nEngSeg,nTecSeg,nMedico,nEnferm,nAuxEnf

	If lSigaMdtPs
		Dbselectarea("TOV")
		Dbsetorder(2)
		MsSeek(xFilial("TOV")+cCliMdtPs)
		While !eof() .And. xFilial("TOV")+cCliMdtPs == TOV->(TOV_FILIAL+TOV_CLIENT+TOV_LOJA)
			If TOV->TOV_DTFIM < TO0->TO0_DTINIC .And. !Empty(TOV->TOV_DTFIM)
				Dbselectarea("TOV")
				Dbskip()
				Loop
			EndIf
			If TOV->TOV_DTINIC > TO0->TO0_DTFIM .And. !Empty(TO0->TO0_DTFIM)
				Dbselectarea("TOV")
				Dbskip()
				Loop
			EndIf
			dbSelectArea( "TMK" )
			dbSetOrder( 1 )
			If !MsSeek(xFilial("TMK")+TOV->TOV_CODUSU) .Or. TMK->TMK_SESMT == "2"
				Dbselectarea("TOV")
				Dbskip()
				Loop
			EndIf

			If TMK->TMK_INDFUN == "1"
				nMedTrab ++
			ElseIf TMK->TMK_INDFUN == "2"
				nEnfTrab ++
			ElseIf TMK->TMK_INDFUN == "3"
				nAuxTrab ++
			ElseIf TMK->TMK_INDFUN == "4"
				nEngSeg ++
			ElseIf TMK->TMK_INDFUN == "5"
				nTecSeg ++
			EndIf

			Dbselectarea("TOV")
			Dbskip()
		End
	Else
		dbSelectArea( "TMK" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TMK", cFil ) )
		While !Eof() .And. xFilial( "TMK", cFil ) == TMK->TMK_FILIAL
			If TMK->TMK_SESMT == "2"
				dbSelectArea( "TMK" )
				Dbskip()
				Loop
			EndIf
			If TMK->TMK_INDFUN == "1"
				nMedTrab ++
			ElseIf TMK->TMK_INDFUN == "2"
				nEnfTrab ++
			ElseIf TMK->TMK_INDFUN == "3"
				nAuxTrab ++
			ElseIf TMK->TMK_INDFUN == "4"
				nEngSeg ++
			ElseIf TMK->TMK_INDFUN == "5"
				nTecSeg ++
			EndIf

			dbSelectArea( "TMK" )
			Dbskip()
		End
	EndIf
	nCSesmt := 0
	cMemo := ""
	If nMedTrab > 0
		nCSesmt++
		cMemo += STR0074+"#*" //"Médicos do Trabalho"
		cMemo += Alltrim(Str(nMedTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPDOC850(STR0075+Alltrim(Str(nMedTrab,3))) //"Médicos do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0074 , nMedTrab } )
	EndIf
	If nEnfTrab > 0
		nCSesmt++
		cMemo += STR0076+"#*" //"Enfermeiros do Trabalho"
		cMemo += Alltrim(Str(nEnfTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPDOC850(STR0077+Alltrim(Str(nEnfTrab,3))) //"Enfermeiros do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0076 , nEnfTrab } )
	EndIf
	If nAuxTrab > 0
		nCSesmt++
		cMemo += STR0078+"#*" //"Auxiliares de Enfermagem do Trabalho"
		cMemo += Alltrim(Str(nAuxTrab,3))+"#*"
		If nModeloImp == 2
			U_IMPDOC850(STR0079+Alltrim(Str(nAuxTrab,3))) //"Auxiliares de Enfermagem do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0078 , nAuxTrab } )
	EndIf
	If nEngSeg > 0
		nCSesmt++
		cMemo += STR0080+"#*" //"Engenheiros de Segurança do Trabalho"
		cMemo += Alltrim(Str(nEngSeg,3))+"#*"
		If nModeloImp == 2
			U_IMPDOC850(STR0081+Alltrim(Str(nEngSeg,3))) //"Engenheiros de Segurança do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0080 , nEngSeg } )
	EndIf
	If nTecSeg > 0
		nCSesmt++
		cMemo += STR0082+"#*" //"Técnicos de Segurança do Trabalho"
		cMemo += Alltrim(Str(nTecSeg,3))+"#*"
		If nModeloImp == 2
			U_IMPDOC850(STR0083+Alltrim(Str(nTecSeg,3))) //"Técnicos de Segurança do Trabalho: "
		EndIf
		aAdd( aSesmt , { STR0082 , nTecSeg } )
	EndIf

	If nCSesmt > 0
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nCSesmt)
			OLE_ExecuteMacro(oWord,"Table_Sesmt")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		ElseIf nModeloImp == 3 .And. Len(aSesmt) > 0
			aSort(aSesmt,,,{|x,y| x[1] < y[1] })
			If lin+420 > 3000
				lin := 9999
			EndIf
			For nFor := 1 To Len(aSesmt)
				If nFor == 1
					Somalinha()
					oPrintPPRA:Box(lin,150,lin+120,2300)
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin+60,1580,lin+120,1580)
					oPrintPPRA:Say(lin+5,800,STR0252,oFont12b) //"QUADRO DE COMPONENTES DO SESMT"
					Somalinha()
					oPrintPPRA:Say(lin+10,810,STR0093,oFont10b) //"Função"
					oPrintPPRA:Say(lin+10,1820,STR0253,oFont10b) //"Quantidade"
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin, 150,lin+60, 150)
				oPrintPPRA:Line(lin,1580,lin+60,1580)
				oPrintPPRA:Line(lin,2300,lin+60,2300)
				oPrintPPRA:Say(lin+10,170,aSesmt[nFor,1],oFont10)
				oPrintPPRA:Say(lin+10,1930,Alltrim(Str(aSesmt[nFor,2],6)),oFont10)
			Next nFor
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850EPIS
Imprime os Epis dos Riscos

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850EPIS()

	Local cMemo := "",nRisco, nFor
	Local nRegs := 0
	Local _1st := .T.
	Local aEpisMod3 := {}

	Local cAliRisk := GetNextAlias()
	Local cFilTN0 := xFilial( "TN0", cFil )
	Local cFilTO1 := xFilial( "TO1", cFil )

	Local cParCCDe := IIf(nModeloImp == 1, mv_par11, mv_par09)
	Local cParCCAte := IIf(nModeloImp == 1, mv_par12, mv_par10)

	aEpis := {}

	If lSigaMdtps

		For nRisco := 1 To Len(aRiscos)
			Dbselectarea("TNX")
			Dbsetorder(4)  //TNX_FILIAL+TNX_CLIENT+TNX_LOJA+TNX_NUMRIS+TNX_EPI
			MsSeek(xFilial("TNX")+cCliMdtps+aRiscos[nRisco][1])
			While !Eof() .And. xFilial("TNX") == TNX->TNX_FILIAL .And. TNX->TNX_NUMRIS = aRiscos[nRisco][1] .And. cCliMdtps == TNX->(TNX_CLIENT+TNX_LOJA)
				If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf
				Dbselectarea("TN3")
				Dbsetorder(4)
				If !MsSeek(xFilial("TN3")+cCliMdtPs+TNX->TNX_EPI)
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf
				aAdd(aEpis,{TNX->TNX_EPI})
				Dbselectarea("SB1")
				dbSetOrder( 1 )
				If MsSeek(xFilial("SB1")+TNX->TNX_EPI)
					nRegs++
					If nModeloImp == 2
						If _1st
							Somalinha()
							@ Li,000 Psay STR0084 //"EPIs:  Nome                                      No. Certificado Aprovação  Data Avaliação  Periodicidade"
							_1st := .F.
						EndIf
						Somalinha()
						@ Li,007 Psay Substr(SB1->B1_DESC,1,28)
						@ Li,049 Psay Alltrim(TN3->TN3_NUMCAP)
						@ Li,076 Psay TN3->TN3_DTAVAL
						@ Li,092 Psay Alltrim(Str(TN3->TN3_DURABI,5))+STR0085 //" DIAS"
					ElseIf nModeloImp == 1
						cMemo += Alltrim(SB1->B1_DESC)+"#*"
						cMemo += Alltrim(TN3->TN3_NUMCAP)+"#*"
						cMemo += If(!Empty(TN3->TN3_DTAVAL),DTOC(TN3->TN3_DTAVAL),"__/__/__")+"#*"
						cMemo += Alltrim(Str(TN3->TN3_DURABI,5))+STR0085+"#*" //" dias"
					Else
						aAdd( aEpisMod3 , { SB1->B1_DESC , TN3->TN3_NUMCAP , TN3->TN3_DTAVAL , Alltrim(Str(TN3->TN3_DURABI,5))+STR0085 } )
					EndIf
				EndIf
				Dbselectarea("TNX")
				Dbskip()
			End
		Next nRisco

	Else

		If Len(aRiscos) < 1

			BeginSQL Alias cAliRisk
				SELECT
					TN0.TN0_NUMRIS
					FROM %table:TN0% TN0
					INNER JOIN %table:TO1% TO1 ON
						TO1.TO1_FILIAL = %exp:cFilTO1% AND
						TN0.TN0_NUMRIS = TO1.TO1_NUMRIS AND
						TO1.TO1_LAUDO = %exp:cCodLaudo% AND
						TO1.%notDel%
					WHERE
						TN0.TN0_FILIAL = %exp:cFilTN0% AND
						(( TN0.TN0_CC >= %exp:cParCCDe% AND
						TN0.TN0_CC <= %exp:cParCCAte% ) OR
						LTRIM(RTRIM(TN0.TN0_CC)) = '*') AND
						TN0.%notDel%
			EndSQL

			dbSelectArea(cAliRisk)
			While !Eof()
				aAdd(aRiscos, {TN0->TN0_NUMRIS})
				dbSkip()
			end

		EndIf

		For nRisco := 1 To Len(aRiscos)
			Dbselectarea("TNX")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TNX", cFil ) + aRiscos[nRisco][1] )
			While !Eof() .And. xFilial( "TNX", cFil ) == TNX->TNX_FILIAL .And. TNX->TNX_NUMRIS = aRiscos[nRisco][1]
				If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf
				Dbselectarea("TN3")
				Dbsetorder(2)
				If !MsSeek( xFilial( "TN3", cFil ) + TNX->TNX_EPI )
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf
				aAdd(aEpis,{TNX->TNX_EPI})
				Dbselectarea("SB1")
				dbSetOrder( 1 )
				If MsSeek( xFilial( "SB1", cFil ) + TNX->TNX_EPI )
					nRegs++
					If nModeloImp == 2
						If _1st
							Somalinha()
							@ Li,000 Psay STR0084 //"EPIs:  Nome                                      No. Certificado Aprovação  Data Avaliação  Periodicidade"
							_1st := .F.
						EndIf
						Somalinha()
						@ Li,007 Psay Substr(SB1->B1_DESC,1,28)
						@ Li,049 Psay Alltrim(TN3->TN3_NUMCAP)
						@ Li,076 Psay TN3->TN3_DTAVAL
						@ Li,092 Psay Alltrim(Str(TN3->TN3_DURABI,5))+STR0085 //" DIAS"
					ElseIf nModeloImp == 1
						cMemo += Alltrim(SB1->B1_DESC)+"#*"
						cMemo += Alltrim(TN3->TN3_NUMCAP)+"#*"
						cMemo += If(!Empty(TN3->TN3_DTAVAL),DTOC(TN3->TN3_DTAVAL),"__/__/__")+"#*"
						cMemo += Alltrim(Str(TN3->TN3_DURABI,5))+STR0085+"#*" //" dias"
					Else
						aAdd( aEpisMod3 , { SB1->B1_DESC , TN3->TN3_NUMCAP , TN3->TN3_DTAVAL , Alltrim(Str(TN3->TN3_DURABI,5))+STR0085 } )
					EndIf
				EndIf
				Dbselectarea("TNX")
				Dbskip()
			End
		Next nRisco

	EndIf

	If nRegs > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nRegs)
		OLE_ExecuteMacro(oWord,"Table_Epis")
	ElseIf nRegs > 0 .And. nModeloImp == 3
		aSort(aEpisMod3,,,{|x,y| x[1] < y[1] })
		If lin+120 > 3000
			lin := 9999
		EndIf
		For nFor := 1 To Len(aEpisMod3)
			If nFor == 1
				Somalinha()
				oPrintPPRA:Box(lin,150,lin+60,2300)
				oPrintPPRA:Line(lin,1100,lin+60,1100)
				oPrintPPRA:Line(lin,1500,lin+60,1500)
				oPrintPPRA:Line(lin,1900,lin+60,1900)
				oPrintPPRA:Say(lin+10,480,STR0254,oFont08b) //"Nome do EPI"
				oPrintPPRA:Say(lin+10,1250,STR0255,oFont08b) //"C.A."
				oPrintPPRA:Say(lin+10,1550,STR0256,oFont08b) //"Data Avaliação"
				oPrintPPRA:Say(lin+10,1960,STR0257,oFont08b) //"Periodicidade"
			EndIf
			Somalinha()
			If lin == 300
				oPrintPPRA:Line(lin,150,lin,2300)
			EndIf
			oPrintPPRA:Line(lin, 150,lin+60, 150)
			oPrintPPRA:Line(lin,1100,lin+60,1100)
			oPrintPPRA:Line(lin,1500,lin+60,1500)
			oPrintPPRA:Line(lin,1900,lin+60,1900)
			oPrintPPRA:Line(lin,2300,lin+60,2300)
			oPrintPPRA:Line(lin+60,150,lin+60,2300)
			oPrintPPRA:Say(lin+10,170,SubStr(aEpisMod3[nFor,1],1,40),oFont08)
			oPrintPPRA:Say(lin+10,1110,aEpisMod3[nFor,2],oFont08)
			oPrintPPRA:Say(lin+10,1510,DtoC(aEpisMod3[nFor,3]),oFont08)
			oPrintPPRA:Say(lin+10,1910,aEpisMod3[nFor,4],oFont08)
		Next nFor
	EndIf
	If nRegs > 0 .And. nModeloImp == 2
		Somalinha()
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850EXAME
Imprime os Exames dos Riscos

@author  Denis Hyroshi de Souza
@since   08/04/2003

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850EXAME()

	Local cMemo := "",nRisco,nFor
	Local nRegs := 0
	Local _1st := .T.
	Local aExamMod3 := {}
	Local aRiscos := fRiscos()

	For nRisco := 1 To Len(aRiscos)
		Dbselectarea("TN2")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TN2", cFil ) + aRiscos[nRisco][1] )
		While !Eof() .And. xFilial( "TN2", cFil ) == TN2->TN2_FILIAL .And. TN2->TN2_NUMRIS = aRiscos[nRisco][1]
			If aScan(aExames,{|X| X[1] == TN2->TN2_EXAME}) > 0
				Dbselectarea("TN2")
				Dbskip()
				Loop
			EndIf
			aAdd(aExames,{TN2->TN2_EXAME})
			Dbselectarea("TM4")
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TM4", cFil ) + TN2->TN2_EXAME )
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0086 //"Exames:"
						@ Li,009 Psay SubStr(TM4->TM4_NOMEXA,1,40)
						_1st := .F.
					Else
						Somalinha()
						@ Li,009 Psay SubStr(TM4->TM4_NOMEXA,1,40)
					EndIf
				ElseIf nModeloImp == 1
					cMemo += TM4->TM4_NOMEXA+"#*"
				ElseIf nModeloImp == 3
					aAdd( aExamMod3 , SubStr(TM4->TM4_NOMEXA,1,40) )
				EndIf
			EndIf
			Dbselectarea("TN2")
			Dbskip()
		End
	Next nRisco

	If nRegs > 0
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Exames")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		ElseIf nModeloImp == 3
			aSort(aExamMod3,,,{|x,y| x < y })
			If lin+120 > 3000
				lin := 9999
			EndIf
			For nFor := 1 To Len(aExamMod3)
				If nFor == 1
					Somalinha()
					oPrintPPRA:Box(lin,150,lin+60,1200)
					oPrintPPRA:Say(lin+10,620,"Exame",oFont10b)
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,1200)
				EndIf
				oPrintPPRA:Line(lin, 150,lin+60, 150)
				oPrintPPRA:Line(lin,1200,lin+60,1200)
				oPrintPPRA:Line(lin+60,150,lin+60,1200)
				oPrintPPRA:Say(lin+10,170,aExamMod3[nFor],oFont10)
			Next nFor
		Else
			SomaLinha()
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850PLANOS
Verifica os planos de acao relacionados aos riscos existentes e chama
a funcao que os imprime.

@author  Denis Hyroshi de Souza
@since   08/04/2003

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850PLANOS()

	Local aArea := GetArea()
	Local svlPrint := lPrint
	Local svlPrin2 := lPrin2
	PRIVATE lAchou := .F.
	PRIVATE aPlanos := {}

	DbSelectArea( cAliasPA )

	Do Case
		Case IIf( nModeloImp != 1, ( mv_par05 == 1 ), ( mv_par07 == 1 ) )
			dbSetOrder( 1 )
		Case IIf( nModeloImp != 1, ( mv_par05 == 2 ),( mv_par07 == 2 ) )
			DbSetOrder( 3 )
		Case IIf( nModeloImp != 1, ( mv_par05 == 3 ),( mv_par07 == 3 ) )
			DbSetOrder( 4 )
	EndCase

	MsSeek( xFilial( cAliasPA, cFil ), .T. )
	While xFilial( cAliasPA, cFil ) == (cAliasPA)->&(aFieldPA[1]) .And. !Eof()

		Dbselectarea("TNJ")
		Dbsetorder(2)
		MsSeek( xFilial( "TNJ", cFil ) + (cAliasPA)->&(aFieldPA[2]) )
		While !Eof() .And. xFilial( "TNJ", cFil ) + (cAliasPA)->&(aFieldPA[2]) == TNJ->TNJ_FILIAL + TNJ->TNJ_CODPLA

			Dbselectarea("TO1")
			dbSetOrder( 1 )
			If !MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO + TNJ->TNJ_NUMRIS )
				DbSelectArea("TNJ")
				DbSkip()
				Loop
			EndIf

			Dbselectarea("TN0")
			dbSetOrder( 1 )
			If !MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS )
				Dbselectarea("TNJ")
				Dbskip()
				Loop
			Else
				If TN0->TN0_MAPRIS == "1"//Valida se o Mapa Risco é igual a CIPA ### Autor: Jackson Machado ### Data: 10/02/2011
					Dbselectarea("TNJ")
					Dbskip()
					Loop
				EndIf
			EndIf

			If aScan(aPlanos,{|x| x == TNJ->TNJ_CODPLA}) > 0
				DbSelectArea("TNJ")
				Dbskip()
				Loop
			EndIf

			Dbselectarea("TC9")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TC9", cFil ) + (cAliasPA)->&(aFieldPA[2]) )
			U_Plano850()

			Dbselectarea("TNJ")
			DbSkip()
		EndDo

		DbSelectArea( cAliasPA )
		DbSkip()
	EndDo

	lPrint := svlPrint
	lPrin2 := svlPrin2

	If lAchou
		Somalinha()
		Somalinha()
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850QUESTI
Imprime os questionários relacionados ao laudo.

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850QUESTI()

	Local cCodQuest
	Local cNomQuest
	Local cReinPer,cTipList,cNumRet
	Local nLinCorre, nLinhaMemo
	Local lCombo2 := NGCADICBASE("TMH_COMBO2","D","TMH",.F.)

	Dbselectarea("TOX")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TOX", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TOX", cFil ) + TO0->TO0_LAUDO == TOX->TOX_FILIAL + TOX->TOX_LAUDO
		cNumRet := 0
		cCodQuest := TOX->TOX_QUESTI
		cNomQuest := NgSeek( "TMG", Alltrim( TOX->TOX_QUESTI ), 1, "TMG->TMG_NOMQUE", cFil )
		If nModeloImp == 2
			SomaLinha()
			//Questionário xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxx - Realização: xx/xx/xx
			@ Li,004 Psay STR0139 + AllTrim(TOX->TOX_QUESTI) + " - " +;  //"Questionário "
				AllTrim(cNomQuest) + " - " + STR0140 + DtoC(TOX->TOX_DTREAL)  //"Realização: "
			SomaLinha()
			@ Li,008 Psay STR0141  //"Perguntas: "
			SomaLinha()

			cNumQuest := TOX->TOX_QUESTA
			cTipList := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_TPLIST", cFil )
			cQuestao := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_PERGUN", cFil )

			If cNumQuest <> cReinPer .And. cTipList == "2" //Caso as perguntas sejam multiplas escolhas.
				cNumRet := 0
			EndIf

			If	TOX->TOX_QUESTA == cNumQuest .And. cTipList == "2"
				If cNumRet == 0
					@ Li,008 Psay TOX->TOX_QUESTA + " - " + cQuestao
					cReinPer := cNumQuest//Recebe numero da questao
					SomaLinha()
				EndIf
				cNumRet := 1
			Else
				@ Li,008 Psay TOX->TOX_QUESTA + " - " + cQuestao
				SomaLinha()
				cNumRet := 0
			EndIf

			If Alltrim(TOX->TOX_RESPOS) == "#"
				@ Li,012 Psay STR0481 //"Observação: "
				nLinhaMemo := MLCOUNT(TOX->TOX_DESCRI,90)
				For nLinCorre := 1 To nLinhaMemo
					IF(nLinCorre <> 1,SomaLinha(),)
					@ Li,025 Psay MemoLine(TOX->TOX_DESCRI,90,nLinCorre)
				Next nLinCorre
			Else
				@ Li,012 Psay STR0142 + (TOX->TOX_RESPOS)//"Resposta: "
				If !lCombo2
					@ Li,030 Psay STR0144 + AllTrim(STR(TOX->TOX_QTRESP))  //"Quantidade: "
					@ Li,047 Psay STR0145 + AllTrim(TOX->TOX_COMRES)  //"Complemento: "
				EndIf
			EndIf

			SomaLinha()

		ElseIf nModeloImp == 3
			SomaLinha()
			//Questionário xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxx - Realização: xx/xx/xx
			U_IMPHEA850(Alltrim(  STR0139 + AllTrim(TOX->TOX_QUESTI) + " - " +;   //"Questionário "
							AllTrim(cNomQuest) + " - " + STR0140 + DtoC(TOX->TOX_DTREAL) ))  //"Realização: "
			SomaLinha()
			oPrintPPRA:Say(lin,300,STR0141,oFont12) //"Perguntas: "

			cNumQuest := TOX->TOX_QUESTA
			cTipList := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_TPLIST", cFil )
			cQuestao := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_PERGUN", cFil )

			If cNumQuest <> cReinPer .And. cTipList == "2"//Caso as perguntas sejam multiplas escolhas.
				cNumRet := 0
			EndIf

			If	TOX->TOX_QUESTA == cNumQuest .And. cTipList == "2"
				If cNumRet == 0
					SomaLinha()
					oPrintPPRA:Say(lin,300,TOX->TOX_QUESTA + " - " + cQuestao,oFont10)
					cReinPer := cNumQuest//Recebe numero da questao
					SomaLinha()
				EndIf
				cNumRet := 1
			Else
				SomaLinha()
				oPrintPPRA:Say(lin,300,TOX->TOX_QUESTA + " - " + cQuestao,oFont10)
				SomaLinha()
				cNumRet := 0
			EndIf

			If Alltrim(TOX->TOX_RESPOS) == "#"
				oPrintPPRA:Say(lin,450,STR0481,oFont10)//"Observação: "
				nLinhaMemo := MLCOUNT(TOX->TOX_DESCRI,90)
				For nLinCorre := 1 To nLinhaMemo
					IF(nLinCorre <> 1,SomaLinha(),)
					oPrintPPRA:Say(lin,660,MemoLine(TOX->TOX_DESCRI,90,nLinCorre),oFont10)
				Next nLinCorre
			Else
				cTextoQu := STR0142 + AllTrim(TOX->TOX_RESPOS)
				If !lCombo2
				cTextoQu+= + space(3) + STR0144 + AllTrim(STR(TOX->TOX_QTRESP)) + "   " + STR0145 + AllTrim(TOX->TOX_COMRES)
				EndIf
				oPrintPPRA:Say(lin,450,cTextoQu,oFont10)
			EndIf
			SomaLinha()

		Else

			//Questionário xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxx - Realização: xx/xx/xx
			U_IMPHEA850(Alltrim(  STR0139 + AllTrim(TOX->TOX_QUESTI) + " - " +;  //"Questionário "
							AllTrim(cNomQuest) + " - " + STR0140 + DtoC(TOX->TOX_DTREAL) ))  //"Realização: "

			//"Perguntas: "
			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Cria_Texto")
			OLE_ExecuteMacro(oWord,"desativar_negrito")
			OLE_SetDocumentVar(oWord,cVar1,STR0141)  //"Perguntas: "

			cNumQuest := TOX->TOX_QUESTA
			cTipList := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_TPLIST", cFil )
			cQuestao := NgSeek( "TMH", TOX->TOX_QUESTI + TOX->TOX_QUESTA, 1, "TMH->TMH_PERGUN", cFil )

			If cNumQuest <> cReinPer .And. cTipList == "2" //Caso as perguntas sejam multiplas escolhas.
				cNumRet := 0
			EndIf

			If	TOX->TOX_QUESTA == cNumQuest .And. cTipList == "2"
				If cNumRet == 0
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"desativar_negrito")
					OLE_SetDocumentVar(oWord,cVar1,TOX->TOX_QUESTA + " - " + cQuestao)
					cReinPer := cNumQuest //Recebe numero da questao
				EndIf
			cNumRet := 1
			Else
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Texto")
				OLE_ExecuteMacro(oWord,"desativar_negrito")
				OLE_SetDocumentVar(oWord,cVar1,TOX->TOX_QUESTA + " - " + cQuestao)
				cNumRet := 0
			EndIf

			//"Resposta:   Quantidade: 0   Complemento: 123456789012345678901234567890"
			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Cria_Texto")
			OLE_ExecuteMacro(oWord,"desativar_negrito")
			OLE_ExecuteMacro(oWord,"Identar")
			If Alltrim(TOX->TOX_RESPOS) == "#"
				OLE_SetDocumentVar(oWord,cVar1,space(3) + STR0481) //"Observação: "
				nLinhaMemo := MLCOUNT(TOX->TOX_DESCRI,90)
				For nLinCorre := 1 To nLinhaMemo
					cVar1 := "cTXT"+Strzero(nVar1,6)
					OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
					nVar1++
					OLE_ExecuteMacro(oWord,"Somalinha")
					OLE_ExecuteMacro(oWord,"Cria_Texto")
					OLE_ExecuteMacro(oWord,"desativar_negrito")
					OLE_ExecuteMacro(oWord,"Identar")
					OLE_SetDocumentVar(oWord,cVar1,+ space(3) + MemoLine(TOX->TOX_DESCRI,90,nLinCorre))
				Next nLinCorre
			Else
				If lCombo2
					OLE_SetDocumentVar(oWord,cVar1,STR0142 + AllTrim(TOX->TOX_RESPOS)) //"Resposta: "
				Else
					OLE_SetDocumentVar(oWord,cVar1,STR0142 + AllTrim(TOX->TOX_RESPOS) +;
					space(3) + STR0144   + AllTrim(STR(TOX->TOX_QTRESP)) + "   " + ;//"Quantidade: "
					STR0145 + AllTrim(TOX->TOX_COMRES) )  //"Complemento: "
				EndIf
			EndIf

		EndIf

		( 'TOX' )->( DbSkip() )

	End

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850RUIDO
Imprime os riscos de ruído do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850RUIDO()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nF
	Local aRiscRuido := {}
	Local cLimite := ""
	Local cExposicao := ""

	Dbselectarea("TO1")
	dbSetOrder( 1 )
	MsSeek(xFilial("TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial("TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO
		Dbselectarea("TN0")
		dbSetOrder( 1 )
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS ) .And. TN0->TN0_MAPRIS != "1".And. ;
			((TN0->TN0_CC >= IIf( nModeloImp == 1, mv_par11, mv_par09 ) .And. TN0->TN0_CC <= IIf( nModeloImp == 1, mv_par12, mv_par10 ) ) .Or. AllTrim( TN0->TN0_CC ) == "*")
			Dbselectarea("TMA")
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )

				If !( TMA->TMA_GRISCO $ '1/8' ) .Or. ( TN0->TN0_UNIMED != '2' .Or.;
				TN0->TN0_UNIMED != '4' .Or.  TN0->TN0_UNIMED != '3' )

					Dbselectarea("TO1")
					Dbskip()
					Loop

				EndIf

				If TN0->TN0_QTAGEN <= 85
					cLimite := STR0146  //"Sem restrição"
					cExposicao := STR0146  //"Sem restrição"
				Else
					cLimite := ""
					cExposicao := ""
				EndIf

				Dbselectarea( "TN7" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + TN0->TN0_CC )
				Dbselectarea( "SRJ" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )
				Dbselectarea( "TN5" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN5", cFil ) + TN0->TN0_CODTAR )
				Dbselectarea( "TNE" )
				dbSetOrder( 1 )
				MsSeek( xFilial("TNE", cFil ) + TN0->TN0_CODAMB )

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				aAdd(aRiscRuido,{TN0->TN0_NUMRIS,TN5->TN5_NOMTAR,TN7->TN7_NOMFON,SRJ->RJ_DESC,TN0->TN0_QTAGEN,TN0->TN0_QTEXPO,cLimite,cExposicao})
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

	ASORT(aRiscRuido,,,{|x,y| x[2]+x[3] < y[2]+y[3] })

	For nF := 1 To Len(aRiscRuido)
		nRegs++
		cMemo += Substr(aRiscRuido[nF,2],1,30)+"#*"
		cMemo += Substr(aRiscRuido[nF,3],1,30)+"#*"
		cMemo += Substr(aRiscRuido[nF,4],1,30)+"#*"
		cMemo += Str(aRiscRuido[nF,5],10,2)+"#*"
		cMemo += aRiscRuido[nF,6]+"#*"
		cMemo += aRiscRuido[nF,7]+"#*"  //Limite
		cMemo += aRiscRuido[nF,8]+"#*"  //Exposicao
	Next nF
	/*
			1         2         3         4         5         6         7         8         9       100       110       120       130
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

	Área                      Ponto de Medição          Funções Expostas          Nível Ruído  Exp. Média   Limite Tol.  Exp.Diária
																					dB(A)     por dia (h)    dB (A)     Permitida (h)

	XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXX   99.999,9        99:99            85             8
	*/
	If nModeloImp == 2
		If Len(aRiscRuido) > 0
			l_Eof := .T.
			nCol := 1
			_1st := .T.
			Somalinha()
			lisalva := li
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					_1st := .F.
					Somalinha()
					@li,000 Psay STR0147  //"Área                      Ponto de Medição          Funções Expostas          Nível Ruído  Exp. Média   Limite Tol.  Exp.Diária"
					Somalinha()
					@li,000 Psay STR0148  //"                                                                                 dB(A)     por dia (h)    dB (A)     Permitida (h)"
					Somalinha()
					Somalinha()
				EndIf

				If nCol == 1
					@li,000 Psay Substr(cText,1,25)
				ElseIf nCol == 2
					@li,026 Psay Substr(cText,1,25)
				ElseIf nCol == 3
					@li,052 Psay Substr(cText,1,25)
				ElseIf nCol == 4
					@li,079 Psay cText
				ElseIf nCol == 5
					@li,096 Psay cText
				ElseIf nCol == 6
					If cText == STR0146  //"Sem restrição"
						@li,103 Psay cText
					Else
						@li,104 Psay Val(cText) Picture '9999999999'
					EndIf
				ElseIf nCol == 7
					If cText == STR0146  //"Sem restrição"
						@li,118 Psay cText
					Else
						@li,120 Psay Val(cText) Picture '9999999999'
					EndIf
				EndIf

				nCol++
				If nCol > 7
					nCol := 1
					Somalinha()
				EndIf

				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End

			SomaLinha()
			SomaLinha()
		Else
			SomaLinha()
		EndIf

	ElseIf nModeloImp == 3
		If Len(aRiscRuido) > 0
			l_Eof := .T.
			nCol := 0
			_1st := .T.
			If lin+150 > 3000
				lin := 9999
			EndIf
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2305)
					oPrintPPRA:Line(lin+90,150,lin+90,2305)
					oPrintPPRA:Line(lin,150,lin+90,150)
					oPrintPPRA:Say(lin+30,340,STR0258,oFont08b) //"Área"
					oPrintPPRA:Line(lin,600,lin+90,600)
					oPrintPPRA:Say(lin+30,680,STR0259,oFont08b) //"Ponto de Medição"
					oPrintPPRA:Line(lin,1050,lin+90,1050)
					oPrintPPRA:Say(lin+30,1120,STR0260,oFont08b) //"Funções Expostas"
					oPrintPPRA:Line(lin,1500,lin+90,1500)
					oPrintPPRA:Say(lin+10,1501,STR0261,oFont08b) //"Nível Ruído"
					oPrintPPRA:Say(lin+50,1501,STR0262,oFont08b) //"dB(A)"
					oPrintPPRA:Line(lin,1700,lin+90,1700)
					oPrintPPRA:Say(lin+10,1701,STR0263,oFont08b) //"Exp. Média"
					oPrintPPRA:Say(lin+50,1701,STR0264,oFont08b) //"por dia (h)"
					oPrintPPRA:Line(lin,1900,lin+90,1900)
					oPrintPPRA:Say(lin+10,1901,STR0265,oFont08b) //"Limite Tol."
					oPrintPPRA:Say(lin+50,1901,STR0266,oFont08b) //"dB (A)"
					oPrintPPRA:Line(lin,2100,lin+90,2100)
					oPrintPPRA:Say(lin+10,2101,STR0267,oFont08b) //"Exp.Diária"
					oPrintPPRA:Say(lin+50,2101,STR0268,oFont08b) //"Permitida(h)"
					oPrintPPRA:Line(lin,2305,lin+90,2305)
					Somalinha(90)
				EndIf

				nCol++
				If nCol > 7
					nCol := 1
				EndIf
				If nCol == 1
					If !_1st
						Somalinha()
					EndIf
					If lin == 300
						oPrintPPRA:Line(lin,150,lin,2305)
					EndIf
					oPrintPPRA:Line(lin+60,155,lin+60,2305)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Line(lin,600,lin+60,600)
					oPrintPPRA:Line(lin,1050,lin+60,1050)
					oPrintPPRA:Line(lin,1500,lin+60,1500)
					oPrintPPRA:Line(lin,1700,lin+60,1700)
					oPrintPPRA:Line(lin,1900,lin+60,1900)
					oPrintPPRA:Line(lin,2100,lin+60,2100)
					oPrintPPRA:Line(lin,2305,lin+60,2305)
					oPrintPPRA:Say(lin+10,160,Substr(cText,1,26),oFont08)
				ElseIf nCol == 2
					oPrintPPRA:Say(lin+10,610,Substr(cText,1,26),oFont08)
				ElseIf nCol == 3
					oPrintPPRA:Say(lin+10,1060,Substr(cText,1,26),oFont08)
				ElseIf nCol == 4
					oPrintPPRA:Say(lin+10,1501,cText,oFont08)
				ElseIf nCol == 5
					oPrintPPRA:Say(lin+10,1710,cText,oFont08)
				ElseIf nCol == 6
					oPrintPPRA:Say(lin+10,1901,cText,oFont08)
				ElseIf nCol == 7
					oPrintPPRA:Say(lin+10,2101,cText,oFont08)
				EndIf

				_1st := .F.
				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	Else
		If Len(aRiscRuido) > 0
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Ruido")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850CALOR
Imprime os riscos de calor do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850CALOR()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nF
	Local aRiscCalor := {}
	Local nLinha := 0

	Dbselectarea("TO1")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO
		Dbselectarea( "TN0" )
		dbSetOrder( 1 )
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS ) .And. TN0->TN0_MAPRIS != "1".And. ;
			( ( TN0->TN0_CC >= IIf( nModeloImp == 1, mv_par11, mv_par09 ) .And. TN0->TN0_CC <= IIf( nModeloImp == 1, mv_par12, mv_par10 ) ) .Or. AllTrim( TN0->TN0_CC ) == "*" )
			Dbselectarea( "TMA" )
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )
				If !( TMA->TMA_GRISCO $ '1/8' .Or. "CALOR" $ Upper( TMA->TMA_NOMAGE ) )
					Dbselectarea( "TO1" )
					Dbskip()
					Loop
				EndIf
				Dbselectarea("TN7")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + TN0->TN0_CC )
				Dbselectarea( "SRJ" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )
				Dbselectarea( "TN5" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN5", cFil ) + TN0->TN0_CODTAR )
				Dbselectarea( "TNE" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TNE", cFil ) + TN0->TN0_CODAMB )
				cTipAtiv := " "
				If TN5->TN5_ESFORC == "1"
					cTipAtiv := STR0150  //"Leve"
				ElseIf TN5->TN5_ESFORC == "2"
					cTipAtiv := STR0151  //"Moderado"
				ElseIf TN5->TN5_ESFORC == "3"
					cTipAtiv := STR0152  //"Excessivo"
				EndIf

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				aAdd(aRiscCalor,{TN0->TN0_NUMRIS,&cDescrCC,TN5->TN5_NOMTAR,SRJ->RJ_DESC,TN0->TN0_QTAGEN,TN0->TN0_QTEXPO,cTipAtiv})
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

	ASORT(aRiscCalor,,,{|x,y| x[2]+x[3]+x[4] < y[2]+y[3]+y[4] })

	/*
			1         2         3         4         5         6         7         8         9       100       110       120       130
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

	Área                       IBUTG    Funções Expostas           Tipo Atividade  Tempo Exposição  Lim.Toler.IBUTG(ºC)
	XXXXXXXXXXXXXXXXXXXXXXXXX  9.999,9  XXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXX            99:99                  30
	*/
	If nModeloImp == 2

		If Len(aRiscCalor) > 0
			aEval( aRiscCalor, { | x |	If(Empty( x[3] ), x[3] := STR0483 , ) , ;
											If(Empty( x[5] ), x[4] := STR0482 , ), ;
											If(Empty( x[4] ), x[5] := 0 , ) } )
			Somalinha()
			@li,000 Psay STR0153  //"Área                       IBUTG    Funções Expostas           Tipo Atividade  Tempo Exposição  Lim.Toler.IBUTG(ºC)"
			Somalinha()
			Somalinha()
			For nLinha:= 1 To Len(aRiscCalor)
					@li,000 Psay SubStr( aRiscCalor[nLinha,3] , 1 , 25 )	//Área
					@li,027 Psay aRiscCalor[nLinha,5] Picture "99.99"	//IBTUG
					@li,036 Psay aRiscCalor[nLinha,4]	//Funções Expostas
					@li,063 Psay aRiscCalor[nLinha,7]	//Tipo Atividade
					@li,089 Psay aRiscCalor[nLinha,6]	//Tempo Exposição
					@li,112 Psay "30º"	//Lim.Toler.IBUTG(ºC)
				SomaLinha()
				SomaLinha()
			Next nLinha
		EndIf

	ElseIf nModeloImp == 3


		If Len(aRiscCalor) > 0
			aEval( aRiscCalor, { | x |	If(Empty( x[3] ), x[3] := STR0483 , ) , ;
											If(Empty( x[5] ), x[4] := STR0482 , ), ;
											If(Empty( x[4] ), x[5] := 0 , ) } )
			Somalinha()
			oPrintPPRA:Line(lin,150,lin,2300)
			oPrintPPRA:Line(lin+60,150,lin+60,2300)
			oPrintPPRA:Line(lin,150,lin+60,150)
			oPrintPPRA:Say(lin+10,340,STR0258,oFont08b) //"Área"
			oPrintPPRA:Line(lin,600,lin+60,600)
			oPrintPPRA:Say(lin+10,640,STR0269,oFont08b) //"IBUTG"
			oPrintPPRA:Line(lin,800,lin+60,800)
			oPrintPPRA:Say(lin+10,870,STR0260,oFont08b) //"Funções Expostas"
			oPrintPPRA:Line(lin,1250,lin+60,1250)
			oPrintPPRA:Say(lin+10,1275,STR0270,oFont08b) //"Tipo Atividade"
			oPrintPPRA:Line(lin,1550,lin+60,1550)
			oPrintPPRA:Say(lin+10,1580,STR0271,oFont08b) //"Tempo Exposição"
			oPrintPPRA:Line(lin,1900,lin+60,1900)
			oPrintPPRA:Say(lin+10,1910,STR0272,oFont08b) //"Lim.Toler.IBUTG(ºC)"
			oPrintPPRA:Line(lin,2300,lin+60,2300)
			Somalinha()
			For nLinha:= 1 To Len(aRiscCalor)
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Line(lin,600,lin+60,600)
				oPrintPPRA:Line(lin,800,lin+60,800)
				oPrintPPRA:Line(lin,1250,lin+60,1250)
				oPrintPPRA:Line(lin,1550,lin+60,1550)
				oPrintPPRA:Line(lin,1900,lin+60,1900)
				oPrintPPRA:Line(lin,2300,lin+60,2300)
				oPrintPPRA:Say(lin+10,160,SubStr( aRiscCalor[nLinha,3] , 1 , 25 ),oFont08)
				oPrintPPRA:Say(lin+10,610, Str(aRiscCalor[nLinha,5]) ,oFont08 )
				oPrintPPRA:Say(lin+10,810,aRiscCalor[nLinha,4],oFont08)
				oPrintPPRA:Say(lin+10,1260,aRiscCalor[nLinha,7],oFont08)
				oPrintPPRA:Say(lin+10,1560,aRiscCalor[nLinha,6],oFont08)
				oPrintPPRA:Say(lin+10,1910,"30º",oFont08)
				SomaLinha()
			Next nLinha
		EndIf
	Else
		For nF := 1 To Len(aRiscCalor)
			nRegs++
			cMemo += If(!Empty(aRiscCalor[nF,3]),Substr(aRiscCalor[nF,3],1,30),STR0483)+"#*"
			cMemo += Str(aRiscCalor[nF,5],10,2)+"#*"
			cMemo += If(!Empty(aRiscCalor[nF,4]),Substr(aRiscCalor[nF,4],1,30),STR0482)+"#*"
			cMemo += aRiscCalor[nF,7]+"#*"
			cMemo += Substr(aRiscCalor[nF,6],1,30)+"#*"
			cMemo += "30º"+"#*"
		Next nF

		If Len(aRiscCalor) > 0
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Calor")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850FRIO
Imprime os riscos de frio do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850FRIO()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nTempTot
	Local nRepete
	Local nF
	Local aRiscFrio := {}
	Local lFrio
	Local lObs := .F.

	Dbselectarea( "TO1" )
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO
		Dbselectarea( "TN0" )
		dbSetOrder( 1 )
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS ) .And. TN0->TN0_MAPRIS != "1".And. ;
			( ( TN0->TN0_CC >= IIf( nModeloImp == 1, mv_par11, mv_par09 ) .And. TN0->TN0_CC <= IIf( nModeloImp == 1, mv_par12, mv_par10 ) ) .Or. AllTrim( TN0->TN0_CC ) == "*" )
			Dbselectarea( "TMA" )
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )
				If !( TMA->TMA_GRISCO $ '1/8' .Or. STR0154 $ Upper( TMA->TMA_NOMAGE ) ) .Or.;
				TN0->TN0_UNIMED != '10'
					Dbselectarea( "TO1" )
					Dbskip()
					Loop
				EndIf
				Dbselectarea( "TN7" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + TN0->TN0_CC )
				Dbselectarea( "SRJ" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )
				Dbselectarea( "TN5" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN5", cFil ) + TN0->TN0_CODTAR )
				Dbselectarea( "TNE" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TNE", cFil ) + TN0->TN0_CODAMB )

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				nPos := 0
				If nModeloImp == 1 //So agrupar se for modelo WORD
					nPos := aScan(aRiscFrio,{|X| X[2] == TN7->TN7_NOMFON .And. X[3] == TN0->TN0_QTAGEN .And. ;
							X[5] == TN0->TN0_REPETE .And. X[6] == TN0->TN0_QTEXPO})
				Else
					nPos := aScan(aRiscFrio,{|X| X[2] == TN7->TN7_NOMFON .And. X[3] == TN0->TN0_QTAGEN .And. ;
							X[5] == TN0->TN0_REPETE .And. X[6] == TN0->TN0_QTEXPO .And. X[4] == Alltrim(SRJ->RJ_DESC)})
				EndIf
				If nPos == 0
					aAdd(aRiscFrio,{TN0->TN0_NUMRIS,TN7->TN7_NOMFON,TN0->TN0_QTAGEN,Alltrim(SRJ->RJ_DESC),TN0->TN0_REPETE,TN0->TN0_QTEXPO,SA1->A1_REGIAO})
				Else
					If !(Alltrim(SRJ->RJ_DESC) $ aRiscFrio[nPos,4])
						If Empty(aRiscFrio[nPos,4])
							aRiscFrio[nPos,4] += Alltrim(SRJ->RJ_DESC)
						Else
							aRiscFrio[nPos,4] += "/ "+Alltrim(SRJ->RJ_DESC)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

	ASORT(aRiscFrio,,,{|x,y| x[2]+x[4] < y[2]+y[4] })

	For nF := 1 To Len(aRiscFrio)
		nRegs++

		//Efetua tratativa afim de manter o legado, pois em algum momento o campo TN0_REPETE foi numérico.
		//Sendo assim será convertido para numérico quando necessário afim de conseguir realizar as oprações aritméticas necessarias.
		nRepete := IIf(ValType(aRiscFrio[nF,5]) <> "N", Val(aRiscFrio[nF,5]), aRiscFrio[nF,5])

		cMemo += Substr(aRiscFrio[nF,2],1,30)+"#*"   //Tipo de Camara
		cMemo += "01"+"#*"    						  //Qt.
		If (aRiscFrio[nF,3] - Int(aRiscFrio[nF,3])) == 0  //Temperatura
			cMemo += Alltrim(Str(aRiscFrio[nF,3],5,0))+"º#*"
		Else
			cMemo += Alltrim(Str(aRiscFrio[nF,3],5,1))+"º#*"
		EndIf

		cMemo += Alltrim(Substr(aRiscFrio[nF,4],1,100))+" #*"  //Funcoes Expostas
		cMemo += Str(nRepete,2)+"#*"	//Frequencia Diaria

		/* No SX5 a tabela que define as regioes eh A2:
		001 - norte
		002 - nordeste
		003 - sul
		004 - centro-oeste
		005 - sudeste
		*/

		//Verifica a Regiao
		//Verifica se NAO eh articialmente frio
		lFrio := .T.

		If aRiscFrio[nF,3] >= 12
			lFrio := .F.
		EndIf

		If lFrio  //Se o risco eh considerado artificialmente FRIO
			If HTOM(aRiscFrio[nF,6]) > 60  		//Tempo de Exposicao
				cMemo += aRiscFrio[nF,6]+" h#*"
			Else
				cMemo += Str(HTOM(aRiscFrio[nF,6]),2)+" min#*"
			EndIf

			nTempTot := nRepete * HTOM(aRiscFrio[nF,6])  //Tempo Total Exposicao
			If nTempTot > 60
				cMemo += MTOH(nTempTot)+" h#*"
			Else
				cMemo += Str(nTempTot,2)+" min#*"
			EndIf
		Else
			If HTOM(aRiscFrio[nF,6]) > 60  		//Tempo de Exposicao
				cMemo += aRiscFrio[nF,6]+" h*#*"
			Else
				cMemo += Str(HTOM(aRiscFrio[nF,6]),2)+" min*#*"
			EndIf

			nTempTot := nRepete * HTOM(aRiscFrio[nF,6])  //Tempo Total Exposicao
			If nTempTot > 60
				cMemo += MTOH(nTempTot)+" h*#*"
			Else
				cMemo += Str(nTempTot,2)+" min*#*"
			EndIf
			lObs := .T.
		EndIf

	Next nF

	/*
			1         2         3         4         5         6         7         8         9       100       110       120       130
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

	Fonte Geradora             Quant. Temp.Bulbo  Funções Expostas           Freq.Diária  Tempo Exposição    Tempo Total
									Seco ºC                                 Entrada                     Exposição Diária
	XXXXXXXXXXXXXXXXXXXXXXXXX     01      9999,9  XXXXXXXXXXXXXXXXXXXXXXXXX           99          59 min            59 min
	XXXXXXXXXXXXXXXXXXXXXXXXX     01      9999,9  XXXXXXXXXXXXXXXXXXXXXXXXX           99          99:99 h           99:99 h
	*/
	If nModeloImp == 2
		If Len(aRiscFrio) > 0
			l_Eof := .T.
			nCol := 1
			_1st := .T.
			Somalinha()
			lisalva := li
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					_1st := .F.
					Somalinha()
					@li,000 Psay STR0155  //"Fonte Geradora             Quant. Temp.Bulbo  Funções Expostas           Freq.Diária  Tempo Exposição    Tempo Total"
					Somalinha()
					@li,000 Psay STR0156  //"                                   Seco ºC                                 Entrada                     Exposição Diária"
					Somalinha()
					Somalinha()
				EndIf

				If nCol == 1
					@li,000 Psay Substr(cText,1,25)
				ElseIf nCol == 2
					@li,030 Psay cText
				ElseIf nCol == 3
					@li,038 Psay cText
				ElseIf nCol == 4
					@li,046 Psay Substr(cText,1,25)
				ElseIf nCol == 5
					@li,082 Psay cText
				ElseIf nCol == 6
					@li,094 Psay cText
				ElseIf nCol == 7
					@li,112 Psay cText
				EndIf

				nCol++
				If nCol > 7
					nCol := 1
					Somalinha()
				EndIf

				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End

			SomaLinha()
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	ElseIf nModeloImp == 3
		If Len(aRiscFrio) > 0
			l_Eof := .T.
			nCol := 0
			_1st := .T.
			If lin+150 > 3000
				lin := 9999
			EndIf
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2305)
					oPrintPPRA:Line(lin+90,150,lin+90,2305)
					oPrintPPRA:Line(lin,150,lin+90,150)
					oPrintPPRA:Say(lin+30,240,STR0091,oFont08b) //"Fonte Geradora"
					oPrintPPRA:Line(lin,600,lin+90,600)
					oPrintPPRA:Say(lin+30,640,STR0273,oFont08b) //"Quant."
					oPrintPPRA:Line(lin,800,lin+90,800)
					oPrintPPRA:Say(lin+10,825,STR0274,oFont08b) //"Temp.Bulbo"
					oPrintPPRA:Say(lin+50,850,STR0275,oFont08b) //"Seco ºC"
					oPrintPPRA:Line(lin,1050,lin+90,1050)
					oPrintPPRA:Say(lin+30,1120,STR0260,oFont08b) //"Funções Expostas"
					oPrintPPRA:Line(lin,1500,lin+90,1500)
					oPrintPPRA:Say(lin+10,1530,STR0276,oFont08b) //"Freq.Diária"
					oPrintPPRA:Say(lin+50,1565,STR0277,oFont08b) //"Entrada"
					oPrintPPRA:Line(lin,1750,lin+90,1750)
					oPrintPPRA:Say(lin+10,1825,STR0278,oFont08b) //"Tempo"
					oPrintPPRA:Say(lin+50,1795,STR0279,oFont08b) //"Exposição"
					oPrintPPRA:Line(lin,2000,lin+90,2000)
					oPrintPPRA:Say(lin+10,2040,STR0280,oFont08b) //"Tempo Total"
					oPrintPPRA:Say(lin+50,2045,STR0281,oFont08b) //"Exp. Diária"
					oPrintPPRA:Line(lin,2305,lin+90,2305)
					Somalinha(90)
				EndIf

				nCol++
				If nCol > 7
					nCol := 1
				EndIf
				If nCol == 1
					If !_1st
						Somalinha()
					EndIf
					If lin == 300
						oPrintPPRA:Line(lin,150,lin,2305)
					EndIf
					oPrintPPRA:Line(lin+60,150,lin+60,2305)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Line(lin,600,lin+60,600)
					oPrintPPRA:Line(lin,800,lin+60,800)
					oPrintPPRA:Line(lin,1050,lin+60,1050)
					oPrintPPRA:Line(lin,1500,lin+60,1500)
					oPrintPPRA:Line(lin,1750,lin+60,1750)
					oPrintPPRA:Line(lin,2000,lin+60,2000)
					oPrintPPRA:Line(lin,2305,lin+60,2305)
					oPrintPPRA:Say(lin+10,160,Substr(cText,1,25),oFont08)
				ElseIf nCol == 2
					oPrintPPRA:Say(lin+10,610,cText,oFont08)
				ElseIf nCol == 3
					oPrintPPRA:Say(lin+10,810,cText,oFont08)
				ElseIf nCol == 4
					oPrintPPRA:Say(lin+10,1060,Substr(cText,1,25),oFont08)
				ElseIf nCol == 5
					oPrintPPRA:Say(lin+10,1510,cText,oFont08)
				ElseIf nCol == 6
					oPrintPPRA:Say(lin+10,1760,cText,oFont08)
				ElseIf nCol == 7
					oPrintPPRA:Say(lin+10,2010,cText,oFont08)
				EndIf

				_1st := .F.
				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	Else
		If Len(aRiscFrio) > 0
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Frio")
			OLE_ExecuteMacro(oWord,"Somalinha")
			If lObs
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_SetDocumentVar(oWord,"Cria_Var","cObs")
				nVar1++
				OLE_ExecuteMacro(oWord,"Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"desativar_negrito")
				OLE_ExecuteMacro(oWord,"Justificar")
				OLE_ExecuteMacro(oWord,"Tamanho9")
				OLE_SetDocumentVar(oWord,"cObs",STR0157)  //"*Não há restrição, pois não é considerado câmara frigorífica."
				OLE_ExecuteMacro(oWord,"Somalinha")
			EndIf
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf
	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850FISICO
Imprime os riscos físicos do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850FISICO()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nF
	Local aRiscFisico := {}

	Dbselectarea("TO1")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO
		Dbselectarea("TN0")
		dbSetOrder( 1 )
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS) .And. TN0->TN0_MAPRIS != "1".And. ;
			((TN0->TN0_CC >= IIf( nModeloImp == 1, mv_par11, mv_par09 ) .And. TN0->TN0_CC <= IIf( nModeloImp == 1, mv_par12, mv_par10 ) ) .Or. AllTrim( TN0->TN0_CC ) == "*" )
			Dbselectarea("TMA")
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )
				If !( TMA->TMA_GRISCO $ '1/8' .Or. "DB" $ Upper( TN0->TN0_UNIMED ) .Or.;
				"DB(A)" $ Upper( TN0->TN0_UNIMED ) .Or. "DBA" $ Upper( TN0->TN0_UNIMED ) .Or.;
				STR0149 $ Upper( TMA->TMA_NOMAGE ) .Or. STR0154 $ Upper( TMA->TMA_NOMAGE ) ) .Or.;
				( TN0->TN0_UNIMED == '2' .Or. TN0->TN0_UNIMED == '4' .Or.;
				TN0->TN0_UNIMED == '3' .Or. TN0->TN0_UNIMED == '10' )

					Dbselectarea("TO1")
					Dbskip()
					Loop
					
				EndIf
				Dbselectarea("TN7")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + TN0->TN0_CC )
				Dbselectarea("SRJ")
				dbSetOrder( 1 )
				MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )
				Dbselectarea("TN5")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN5", cFil ) + TN0->TN0_CODTAR )
				Dbselectarea("TNE")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TNE", cFil ) + TN0->TN0_CODAMB )

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				aAdd(aRiscFisico,{TN0->TN0_NUMRIS,&cDescrCC,TN5->TN5_NOMTAR,TMA->TMA_NOMAGE,SRJ->RJ_DESC,TN0->TN0_QTAGEN,TN0->TN0_QTEXPO})
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

	ASORT(aRiscFisico,,,{|x,y| x[2]+x[3]+x[4] < y[2]+y[3]+y[4] })

	For nF := 1 To Len(aRiscFisico)
		nRegs++
		cMemo += Substr(aRiscFisico[nF,3],1,30)+"#*"
		cMemo += Substr(aRiscFisico[nF,4],1,30)+"#*"
		cMemo += Substr(aRiscFisico[nF,5],1,30)+"#*"
		cMemo += Str(aRiscFisico[nF,6],12,3)+"#*"
		cMemo += aRiscFisico[nF,7]+"#*"
	Next nF

	/*
			1         2         3         4         5         6         7         8         9       100       110       120       130
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

	Área                      Agente Fisico             Funções Expostas           Intensidade/    Tempo de
																				Concentracao   Exposicao

	XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXX  99999999,999       99:99
	*/
	If nModeloImp == 2
		If Len(aRiscFisico) > 0
			l_Eof := .T.
			nCol := 1
			_1st := .T.
			Somalinha()
			lisalva := li
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					_1st := .F.
					Somalinha()
					@li,000 Psay STR0158  //"Área                      Agente Fisico             Funções Expostas           Intensidade/    Tempo de"
					Somalinha()
					@li,000 Psay STR0159  //"                                                                               Concentracao   Exposicao"
					Somalinha()
					Somalinha()
				EndIf

				If nCol == 1
					@li,000 Psay Substr(cText,1,25)
				ElseIf nCol == 2
					@li,026 Psay Substr(cText,1,25)
				ElseIf nCol == 3
					@li,052 Psay Substr(cText,1,25)
				ElseIf nCol == 4
					@li,079 Psay cText
				ElseIf nCol == 5
					@li,098 Psay cText
				EndIf

				nCol++
				If nCol > 5
					nCol := 1
					Somalinha()
				EndIf

				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End

			SomaLinha()
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	ElseIf nModeloImp == 3
		If Len(aRiscFisico) > 0
			l_Eof := .T.
			nCol := 0
			_1st := .T.
			If lin+150 > 3000
				lin := 9999
			EndIf
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2300)
					oPrintPPRA:Line(lin+90,150,lin+90,2300)
					oPrintPPRA:Line(lin,150,lin+90,150)
					oPrintPPRA:Say(lin+30,380,STR0258,oFont08b) //"Área"
					oPrintPPRA:Line(lin,650,lin+90,650)
					oPrintPPRA:Say(lin+30,780,STR0282,oFont08b) //"Agente Físico"
					oPrintPPRA:Line(lin,1150,lin+90,1150)
					oPrintPPRA:Say(lin+30,1240,STR0260,oFont08b) //"Funções Expostas"
					oPrintPPRA:Line(lin,1650,lin+90,1650)
					oPrintPPRA:Say(lin+10,1700,STR0283,oFont08b) //"Intensidade/"
					oPrintPPRA:Say(lin+50,1700,STR0284,oFont08b) //"Concentração"
					oPrintPPRA:Line(lin,2000,lin+90,2000)
					oPrintPPRA:Say(lin+10,2060,STR0285,oFont08b) //"Tempo de"
					oPrintPPRA:Say(lin+50,2060,STR0279,oFont08b) //"Exposição"
					oPrintPPRA:Line(lin,2300,lin+90,2300)
					Somalinha(90)
				EndIf

				nCol++
				If nCol > 5
					nCol := 1
				EndIf
				If nCol == 1
					If !_1st
						Somalinha()
					EndIf
					If lin == 300
						oPrintPPRA:Line(lin,150,lin,2300)
					EndIf
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Line(lin,650,lin+60,650)
					oPrintPPRA:Line(lin,1150,lin+60,1150)
					oPrintPPRA:Line(lin,1650,lin+60,1650)
					oPrintPPRA:Line(lin,2000,lin+60,2000)
					oPrintPPRA:Line(lin,2300,lin+60,2300)
					oPrintPPRA:Say(lin+10,160,Substr(cText,1,40),oFont08)
				ElseIf nCol == 2
					oPrintPPRA:Say(lin+10,660,Substr(cText,1,40),oFont08)
				ElseIf nCol == 3
					oPrintPPRA:Say(lin+10,1160,Substr(cText,1,40),oFont08)
				ElseIf nCol == 4
					oPrintPPRA:Say(lin+10,1660,cText,oFont08)
				ElseIf nCol == 5
					oPrintPPRA:Say(lin+10,2010,cText,oFont08)
				EndIf

				_1st := .F.
				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	Else
		If Len(aRiscFisico) > 0
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Fisico")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850QUIMICO
Imprime os riscos químicos do laudo

@author  Denis Hyroshi de Souza
@since   08/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850QUIMICO()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nF
	Local aRiscQuimico := {}

	Local cSeekTO1 := "xFilial( 'TO1', '" + cFil + "') + TO0->TO0_LAUDO"
	Local cWhileTO1 := ".T."
	Local nIndexTO1 := 1

	Local cSeekTN0 := "xFilial( 'TN0', '" + cFil + "') + TO1->TO1_NUMRIS"
	Local nIndexTN0 := 1

	Local cSeekTN7 := "xFilial('TN7', '" + cFil + "')+TN0->TN0_FONTE"
	Local nIndexTN7 := 1

	Local cSeekTN5 := "xFilial('TN5', '" + cFil + "')+TN0->TN0_CODTAR"
	Local nIndexTN5 := 1

	Local cSeekTNE := "xFilial('TNE', '" + cFil + "')+TN0->TN0_CODAMB"
	Local nIndexTNE:= 1

	If lSigaMdtPs
		cSeekTO1 := "xFilial('TO1')+cCliMdtPs+TO0->TO0_LAUDO"
		cWhileTO1 := "cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA"
		nIndexTO1 := 3

		cSeekTN0 := "xFilial('TN0')+cCliMdtps+TO1->TO1_NUMRIS"
		nIndexTN0 := 8

		cSeekTN7 := "xFilial('TN7')+cCliMdtPs+TN0->TN0_FONTE"
		nIndexTN7 := 3

		cSeekTN5 := "xFilial('TN5')+cCliMdtps+TN0->TN0_CODTAR"
		nIndexTN5 := 3

		cSeekTNE := "xFilial('TNE')+cCliMdtPs+TN0->TN0_CODAMB"
		nIndexTNE:= 3
	EndIf

	Dbselectarea("TO1")
	Dbsetorder(nIndexTO1)// 1/3
	dbSeek( &cSeekTO1 )  //xFilial('TO1')(+cCliMdtPs)+TO0->TO0_LAUDO
	While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO .And. &cWhileTO1 //.T./cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA

		Dbselectarea("TN0")
		Dbsetorder(nIndexTN0)  //1 / 8 //TN0_FILIAL(+TN0_CODCLI+TN0_LOJACL)+TN0_NUMRIS
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek(&cSeekTN0) .And. TN0->TN0_MAPRIS != "1".And. ;
			   ((TN0->TN0_CC >= IIf(nModeloImp == 1, mv_par11, mv_par09) .And. TN0->TN0_CC <= IIf(nModeloImp == 1, mv_par12, mv_par10)) .Or. AllTrim(TN0->TN0_CC) == "*")
			Dbselectarea("TMA")
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )
				If TMA->TMA_GRISCO <> "2"
					Dbselectarea("TO1")
					Dbskip()
					Loop
				EndIf
				Dbselectarea("TN7")
				Dbsetorder(nIndexTN7) // 1/3
				MsSeek(&cSeekTN7) //xFilial('TN7')(+cCliMdtPs)+TN0->TN0_FONTE
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek(xFilial(cAliasCC, cFil)+TN0->TN0_CC)
				Dbselectarea("SRJ")
				dbSetOrder( 1 )
				MsSeek(xFilial("SRJ", cFil)+TN0->TN0_CODFUN)
				Dbselectarea("TN5")
				Dbsetorder(nIndexTN5) // 1/3
				MsSeek(&cSeekTN5) //TN5_FILIAL(+TN5_CLIENT+TN5_LOJA)+TN5_CODTAR
				Dbselectarea("TNE")
				Dbsetorder(nIndexTNE) //xFilial('TNE')(+cCliMdtPs)+TN0->TN0_CODAMB
				MsSeek(&cSeekTNE) //1 / 3

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				aAdd(aRiscQuimico,{TN0->TN0_NUMRIS,&cDescrCC,;
									TN5->TN5_NOMTAR,If(TN5->(FieldPos("TN5_DESCRI")) > 0,TN5->TN5_DESCRI,TN5->TN5_DESTAR),;
									SRJ->RJ_DESC, TMA->TMA_NOMAGE})
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End


	ASORT(aRiscQuimico,,,{|x,y| x[2]+x[3]+x[4] < y[2]+y[3]+y[4] })

	For nF := 1 To Len(aRiscQuimico)
		nRegs++
		cMemo += Substr(aRiscQuimico[nF,3],1,35)+"#*"
		cMemo += Substr(aRiscQuimico[nF,4],1,100)+"#*"
		cMemo += Substr(aRiscQuimico[nF,5],1,35)+"#*"
		cMemo += Substr(aRiscQuimico[nF,6],1,35)+"#*"
	Next nF
	/*
			1         2         3         4         5         6         7         8         9       100       110       120       130
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	Área                       Atividade                                           Função Exposta             Substância Química
	XXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXX
	*/
	If nModeloImp == 2
		If Len(aRiscQuimico) > 0
			l_Eof := .T.
			nCol := 1
			_1st := .T.
			Somalinha()
			lisalva := li
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					_1st := .F.
					Somalinha()
					@li,000 Psay STR0160  //"Área                       Atividade                                           Função Exposta             Substância Química"
					Somalinha()
					Somalinha()
				EndIf

				If nCol == 1
					@li,000 Psay Substr(cText,1,25)
				ElseIf nCol == 2
					@li,027 Psay Substr(cText,1,50)
				ElseIf nCol == 3
					@li,079 Psay Substr(cText,1,25)
				ElseIf nCol == 4
					@li,106 Psay Substr(cText,1,25)
				EndIf

				nCol++
				If nCol > 4
					nCol := 1
					Somalinha()
				EndIf

				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End
			SomaLinha()
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	ElseIf nModeloImp == 3
		If Len(aRiscQuimico) > 0
			l_Eof := .T.
			nCol := 0
			_1st := .T.
			If lin+150 > 3000
				lin := 9999
			EndIf
			While (l_Eof)
				nPos  := At("#*",cMemo)
				cText := Substr(cMemo,1,nPos-1)
				cMemo := Substr(cMemo,nPos+2)

				If _1st
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2300)
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Say(lin+10,350,STR0258,oFont08b) //"Área"
					oPrintPPRA:Line(lin,600,lin+60,600)
					oPrintPPRA:Say(lin+10,900,STR0286,oFont08b) //"Atividade"
					oPrintPPRA:Line(lin,1400,lin+60,1400)
					oPrintPPRA:Say(lin+10,1490,STR0287,oFont08b) //"Função Exposta"
					oPrintPPRA:Line(lin,1850,lin+60,1850)
					oPrintPPRA:Say(lin+10,1910,STR0288,oFont08b) //"Substância Química"
					oPrintPPRA:Line(lin,2300,lin+60,2300)
					Somalinha()
				EndIf

				nCol++
				If nCol > 4
					nCol := 1
				EndIf
				If nCol == 1
					If !_1st
						Somalinha()
					EndIf
					If lin == 300
						oPrintPPRA:Line(lin,150,lin,2300)
					EndIf
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Line(lin,600,lin+60,600)
					oPrintPPRA:Line(lin,1400,lin+60,1400)
					oPrintPPRA:Line(lin,1850,lin+60,1850)
					oPrintPPRA:Line(lin,2300,lin+60,2300)
					oPrintPPRA:Say(lin+10,160,Substr(cText,1,30),oFont08)
				ElseIf nCol == 2
					oPrintPPRA:Say(lin+10,610,Substr(cText,1,50),oFont08)
				ElseIf nCol == 3
					oPrintPPRA:Say(lin+10,1410,Substr(cText,1,30),oFont08)
				ElseIf nCol == 4
					oPrintPPRA:Say(lin+10,1860,Substr(cText,1,30),oFont08)
				EndIf

				_1st := .F.
				If Empty(cMemo)
					l_Eof := .F.
				EndIf
			End
			SomaLinha()
		Else
			SomaLinha()
		EndIf
	Else
		If Len(aRiscQuimico) > 0
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Quimico")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850FUNFUN
Imprime listagem dos funcionários por função.

@author  Denis Hyroshi de Souza
@since   11/08/2004
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850FUNFUN()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local _1st := .T.
	Local nContFun := 0
	Local nContTOT := 0
	Local aFunMod3 := {},nFor

	If lSigaMdtPs

		Dbselectarea("TOS")
		DbSetOrder(2)
		MsSeek(xFilial("TOS")+cCliMdtPs)
		While !EOF() .And. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)
			nContFun := 0
			Dbselectarea("SRA")
			Dbsetorder(2)
			MsSeek(xFilial("SRA")+cCliMdtPs,.T.)
			While !eof() .And. xFilial("SRA")+cCliMdtPs == SRA->RA_FILIAL+Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
				If !R850FUNC()
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf
				If TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. ;
					( SRA->RA_SITFOLH <> "D" .And. ( Empty( SRA->RA_DEMISSA ) .Or. !Empty( SRA->RA_DEMISSA ) ) ) .And. ;
						!( SRA->RA_CATFUNC $ cFiltroF )
					nContFun++
				EndIf
				dbSelectArea("SRA")
				Dbskip()
			End
			If nContFun > 0
				nContTOT += nContFun
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0161  //"Funcionários x Função: Função                                   Qtde. Funcionários"
						_1st := .F.
					EndIf
					Somalinha()
					If Empty(TOS->TOS_DESFUN)
						@ Li,023 Psay Substr(NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC"),1,35)
					Else
						@ Li,023 Psay Substr(TOS->TOS_DESFUN,1,35)
					EndIf
					@ Li,074 Psay nContFun Picture "99999999"
				ElseIf nModeloImp == 3
					cDescFuncao := TOS->TOS_DESFUN
					If Empty(TOS->TOS_DESFUN)
						cDescFuncao := NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")+"#*"
					EndIf
					aAdd( aFunMod3 , { cDescFuncao , Str(nContFun,7) } )
				Else
					If Empty(TOS->TOS_DESFUN)
						cMemo += NgSeek("SRJ",TOS->TOS_CODFUN,1,"SRJ->RJ_DESC")+"#*"
					Else
						cMemo += TOS->TOS_DESFUN+"#*"
					EndIf

					cMemo += Str(nContFun,7)+"#*"
				EndIf
			EndIf

			Dbselectarea("TOS")
			Dbskip()
		End

	Else

		Dbselectarea("SRJ")
		DbSetOrder(3)
		MsSeek( xFilial( "SRJ", cFil ) )
		While !Eof() .And. xFilial( "SRJ", cFil ) == SRJ->RJ_FILIAL
			nContFun := 0
			Dbselectarea("SRA")
			Dbsetorder(7)
			MsSeek( xFilial( "SRA", cFil ) + SRJ->RJ_FUNCAO )
			While !Eof() .And. xFilial( "SRA", cFil ) + SRJ->RJ_FUNCAO == SRA->RA_FILIAL + SRA->RA_CODFUNC
				// busca transferidos e afastados dentro da vigencia e fora. considerando ou nao.
				If !R850FUNC()
					DbSelectArea("SRA")
					DbSkip()
					Loop
				EndIf
				If ( SRA->RA_SITFOLH <> "D" .And. ( Empty( SRA->RA_DEMISSA ) .Or. !Empty( SRA->RA_DEMISSA ) ) ) .And. ;
						!( SRA->RA_CATFUNC $ cFiltroF )
					nContFun++
				EndIf
				DbSelectArea("SRA")
				Dbskip()
			End
			Dbselectarea("SRA")
			dbSetOrder( 1 )
			If nContFun > 0
				nContTOT += nContFun
				nRegs++
				If nModeloImp == 2
					If _1st
						Somalinha()
						@ Li,000 Psay STR0161  //"Funcionários x Função: Função                                   Qtde. Funcionários"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,023 Psay Substr(SRJ->RJ_DESC,1,35)
					@ Li,074 Psay nContFun Picture "99999999"
				ElseIf nModeloImp == 3
					aAdd( aFunMod3 , { SRJ->RJ_DESC , Str(nContFun,7) } )
				Else
					cMemo += SRJ->RJ_DESC+"#*"
					cMemo += Str(nContFun,7)+"#*"
				EndIf
			EndIf

			Dbselectarea("SRJ")
			Dbskip()
		End
	EndIf

	If nRegs > 0
		If nModeloImp == 2
			Somalinha()
			@ Li,023 Psay STR0289 //"Total"
			@ Li,074 Psay nContTOT Picture "99999999"
		ElseIf nModeloImp == 3
			For nFor := 1 To Len(aFunMod3)
				If nFor == 1
					If lin+120 > 3000
						lin := 9999
					EndIf
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,1500)
					oPrintPPRA:Line(lin+60,150,lin+60,1500)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Say(lin+10,550,STR0093,oFont08b) //"Função"
					oPrintPPRA:Line(lin,1000,lin+60,1000)
					oPrintPPRA:Say(lin+10,1025,STR0290,oFont08b) //"Número de Trabalhadores"
					oPrintPPRA:Line(lin,1500,lin+60,1500)
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,1500)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,1500)
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Say(lin+10,160,aFunMod3[nFor,1],oFont08)
				oPrintPPRA:Line(lin,1000,lin+60,1000)
				oPrintPPRA:Say(lin+10,1480,aFunMod3[nFor,2],oFont08,,,,1)
				oPrintPPRA:Line(lin,1500,lin+60,1500)
				If nFor == Len(aFunMod3)
					Somalinha()
					If lin == 300
						oPrintPPRA:Line(lin,150,lin,1500)
					EndIf
					oPrintPPRA:Line(lin+60,150,lin+60,1500)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Say(lin+10,160,STR0289,oFont08b) //"TOTAL"
					oPrintPPRA:Line(lin,1000,lin+60,1000)
					oPrintPPRA:Say(lin+10,1480,Str(nContTOT,7),oFont08,,,,1)
					oPrintPPRA:Line(lin,1500,lin+60,1500)
				EndIf
			Next nFor
		Else
			cMemo += STR0289+"#*" //"Total"
			cMemo += Str(nContTOT,7)+"#*"
			nRegs++

			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Funcionario")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			Somalinha()
		EndIf
	EndIf

	Dbselectarea("SRJ")
	dbSetOrder( 1 )

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850FUNCOES
Imprime listagem dos funcionários por função.

@author  Denis Hyroshi de Souza
@since   11/08/2004
@param   Ltarela, Lógico, Se imprime a listagem de tarefas

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850FUNCOES(lTarefa)

	Local aArea    := GetArea()
	Local nContFun := 0
	Local cFuncao, cDesFun
	Local lGrava := .F.
	Local aFuncoes := {}
	Local i

	If !lSigaMdtPs

		cAliasFUN := GetNextAlias()
		cTabSRJ := RetSqlName("SRJ")
		cTabTN0 := RetSqlName("TN0")
		cTabTO1 := RetSqlName("TO1")
		cTabSRA := RetSqlName("SRA")
		cTabTN6 := RetSqlName("TN6")

		//Query para filtrar as funções a serem impressas
		cCampos := "SRJ.RJ_FUNCAO,SRJ.RJ_FILIAL,SRJ.RJ_DESC,SRJ.RJ_CARGO,SRJ.RJ_DESCREQ"

		cQuery := "SELECT " + cCampos
		cQuery += "FROM " + cTabSRJ + " SRJ "
		cQuery += "INNER JOIN " + cTabTN0 + " TN0 ON "
		cQuery += 		"SRJ.RJ_FILIAL = '" + xFilial( "SRJ", cFil ) + "' AND "
		cQuery += 		"TN0.TN0_FILIAL = '" + xFilial( "TN0", cFil ) + "' AND "
		cQuery +=		"( SRJ.RJ_FUNCAO = TN0.TN0_CODFUN OR LTRIM(RTRIM(TN0.TN0_CODFUN)) = '*' ) AND "
		cQuery += 		"TN0.TN0_MAPRIS <> '1' AND "
		cQuery += 		"TN0.D_E_L_E_T_ <> '*'"
		cQuery += "INNER JOIN " + cTabTO1 + " TO1 ON "
		cQuery += 		"TO1.TO1_FILIAL = '" + xFilial( "TO1", cFil ) + "' AND "
		cQuery += 		"TO1.TO1_LAUDO ='" + cCodLaudo +"' AND "
		cQuery += 		"TN0.TN0_NUMRIS = TO1.TO1_NUMRIS AND "
		cQuery += 		"TO1.D_E_L_E_T_ <> '*'"
		cQuery += "INNER JOIN " + cTabSRA + " SRA ON "
		cQuery += 		"SRA.RA_FILIAL = '" + xFilial( "SRA", cFil ) + "' AND "
		cQuery +=		"( SRA.RA_SITFOLH <> 'D' OR SRA.RA_DEMISSA = '' ) AND "
		cQuery +=		"SRA.RA_ADMISSA <= '" + DTOS(dAteLaudo) + "' AND "
		cQuery += 		"SRA.D_E_L_E_T_ <> '*'"
		cQuery += "INNER JOIN " + cTabTN6 + " TN6 ON "
		cQuery += 		"TN6.TN6_FILIAL = '" + xFilial( "TN6", cFil ) + "' AND "
		cQuery +=		"( TN6.TN6_CODTAR = TN0.TN0_CODTAR OR LTRIM(RTRIM(TN0.TN0_CODTAR)) = '*' ) AND "
		cQuery +=		"SRA.RA_MAT = TN6.TN6_MAT AND "
		cQuery += 		"TN6.D_E_L_E_T_ <> '*'"
		cQuery += "WHERE "
		cQuery +=		"SRJ.D_E_L_E_T_ <> '*' "
		cQuery += "GROUP BY " + cCampos
		cQuery := ChangeQuery(cQuery)
		MPSysOpenQuery( cQuery , cAliasFUN )

		dbSelectArea( cAliasFUN )
		dbgotop()
		While !Eof()

			aAdd( aFuncoes, {;
				( cAliasFUN )->RJ_FUNCAO,;
				( cAliasFUN )->RJ_DESC,;
				IIf( !Empty( ( cAliasFUN )->RJ_DESCREQ ),;
					NgMemo( ( cAliasFUN )->RJ_DESCREQ, .F., 'RDY', cFil ),;
					( NgSeek( "SQ3", AllTrim( ( cAliasFUN )->RJ_CARGO ), 1, "MSMM( SQ3->Q3_DESCDET, 80, , , , , , 'SQ3', , 'RDY'  )", cFil ) );
				);
			} )

			dbSelectArea(cAliasFUN)
			dbSkip()
			loop

		End

		If Len(aFuncoes) > 0
			For i:=1 To Len(aFuncoes)
				U_IMPHEA850("{NS}"+aFuncoes[i][2])
				If nModeloImp == 1
					OLE_ExecuteMacro(oWord,"Somalinha")
				EndIf

				lIdentar := .F.

				U_IMPDOC850(STR0291+aFuncoes[i][3])

				If nModeloImp == 3
					Somalinha()
				EndIf
			Next i
		EndIf

	Else

		Dbselectarea("TOS")
		DbSetOrder(2)
		MsSeek(xFilial("TOS")+cCliMdtPs)
		While !EOF() .And. xFilial("TOS")+cCliMdtPs == TOS->(TOS_FILIAL+TOS_CLIENT+TOS_LOJA)

			dbSelectArea("TO1")
			dbSetOrder(3)
			MsSeek(xFilial("TO1") + cCliMdtPs + mv_par03)
			While !Eof() .And. xFilial("TO1")+mv_par03 == TO1->TO1_FILIAL+TO1->TO1_LAUDO .And. cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA

				dbSelectArea("TN0")
				dbSetOrder(8)  //TN0_FILIAL+TN0_CODCLI+TN0_LOJACL+TN0_NUMRIS
				//Valida se o Mapa Risco é diferente de CIPA
				//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
				//### Autor: Jackson Machado ### Data: 10/02/2011
				If MsSeek(xFilial("TN0")+cCliMdtps+TO1->TO1_NUMRIS) .And. TN0->TN0_MAPRIS != "1".And. ;
			   ((TN0->TN0_CC >= IIf(nModeloImp == 1, mv_par11, mv_par09) .And. TN0->TN0_CC <= IIf(nModeloImp == 1, mv_par12, mv_par10)) .Or. AllTrim(TN0->TN0_CC) == "*")

					If lImpTodos .Or. AllTrim(TN0->TN0_CODFUN) == "*" .Or. TN0->TN0_CODFUN == TOS->TOS_FUNCAO

						nContFun := 0

						dbSelectArea("SRA")
						dbSetOrder(2)
						MsSeek(xFilial("SRA")+cCliMdtPs,.T.)
						While !Eof() .And. xFilial("SRA")+cCliMdtPs == SRA->RA_FILIAL+Substr(SRA->RA_CC,1,nSizeCli+nSizeLoj)
							If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
								dbSelectArea("SRA")
								Dbskip()
								Loop
							EndIf
							If SRA->RA_ADMISSA > dAteLaudo
								dbSelectArea("SRA")
								Dbskip()
								Loop
							EndIf
							If SRA->RA_SITFOLH != "D" .And. Empty(SRA->RA_DEMISSA) .And.;
								TOS->TOS_CODFUN == SRA->RA_CODFUNC .And. !(SRA->RA_CATFUNC $ cFiltroF)
								If !lImpTodos .And. AllTrim(TN0->TN0_CODFUN) == "*"//Se for somente Exposto ao Risco verifica
									//Verifica se Func. esta no mesmo C.C. do Risco
									If (AllTrim(TN0->TN0_CC) == "*") .Or. (SRA->RA_CC == TN0->TN0_CC)
										//Verifica se Func. executa tarefa do risco
										If AllTrim(TN0->TN0_CODTAR) == "*"
											nContFun++
										Else
											dbSelectArea("TN6")
											dbSetOrder( 1 )
											MsSeek(xFilial("TN6")+TN0->TN0_CODTAR+SRA->RA_MAT)
											While !Eof() .And. xFilial("TN6")+TN0->TN0_CODTAR+SRA->RA_MAT == TN6->(TN6_FILIAL+TN6_CODTAR+TN6_MAT)
												If TN6->TN6_DTINIC <= dDatabase .And. (TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
													nContFun++
													Exit
												EndIf
												dbSelectArea("TN6")
												dbSkip()
											End
										EndIf
									EndIf
								Else
									nContFun++
								EndIf
								If nContFun > 0
									Exit
								EndIf
							EndIf
							dbSkip()
						End

						If nContFun > 0

							cFuncao := " "
							cDesFun := " "
							If Empty(TOS->TOS_DESFUN)
								cFuncao := NgSeek( "SRJ", AllTrim( TOS->TOS_CODFUN ), 1, "SRJ->RJ_DESC", cFil )
								If SRJ->( FieldPos( "RJ_MEMOATI" ) ) > 0
									cDesFun := NgSeek( "SRJ", AllTrim( TOS->TOS_CODFUN ), 1, "SRJ->RJ_MEMOATI", cFil )
								Else
									cDesFun := MSMM( NgSeek( "SRJ", AllTrim( TOS->TOS_CODFUN ), 1, "SRJ->RJ_DESCREQ", cFil ), 80 )
								EndIf
								Dbselectarea("TOS")
							Else
								cFuncao := TOS->TOS_DESFUN
								lIdentar := .F.
								If Empty(TOS->TOS_DESCDE) .And. SRJ->( FieldPos( "RJ_MEMOATI" ) ) > 0
									cDesFun := NgSeek( "SRJ", AllTrim( TOS->TOS_CODFUN ), 1, "SRJ->RJ_MEMOATI", cFil )
								Else
									cDesFun := TOS->TOS_DESCDE
								EndIf
							EndIf

							U_IMPHEA850("{NS}"+cFuncao)
							If nModeloImp == 1
								OLE_ExecuteMacro(oWord,"Somalinha")
							EndIf
							lIdentar := .F.
							U_IMPDOC850(STR0291+cDesFun) //"Objetivo do Cargo: "
							If nModeloImp == 3
								Somalinha()
							EndIf

						EndIf
					EndIf
				EndIf
				dbSelectArea("TO1")
				dbSkip()
				Loop
			End
			dbSelectArea("TOS")
			dbSkip()
			Loop
		End
	EndIf

	If lTarefa
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			Somalinha()
		EndIf
		A850TAREFA()
	EndIf

	If nModeloImp == 2
		Somalinha()
	ElseIf nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf

	Dbselectarea("SRJ")
	dbSetOrder( 1 )

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850EPIQ
Imprime os epis relacionados aos riscos existentes em uma tabela que
contém o tipo de proteção do epi e a sua área de utilização

@author  Andre E. Perez Alvarez
@since   03/07/2006
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850EPIQ()

	Local cMemo := "",nRisco
	Local nRegs := 0
	Local _1st := .T.
	Local aQuadEPI := {}
	Local nX

	aEpis      := {}

	If lSigaMdtps

		Dbselectarea("TO1")
		Dbsetorder(3)
		MsSeek(xFilial("TO1") + cCliMdtPs + TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO1")+TO0->TO0_LAUDO == TO1->TO1_FILIAL+TO1->TO1_LAUDO .And. cCliMdtPs == TO1->TO1_CLIENT+TO1->TO1_LOJA


			Dbselectarea("TNX")
			Dbsetorder(4)  //TNX_FILIAL+TNX_CLIENT+TNX_LOJA+TNX_NUMRIS+TNX_EPI
			MsSeek(xFilial("TNX")+cCliMdtps+TO1->TO1_NUMRIS)
			While !Eof() .And. xFilial("TNX")+TO1->TO1_NUMRIS == TNX->TNX_FILIAL+TNX->TNX_NUMRIS .And. cCliMdtps == TNX->(TNX_CLIENT+TNX_LOJA)

				If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf

				Dbselectarea("TN3")
				Dbsetorder(4)
				If !MsSeek(xFilial("TN3")+cCliMdtPs+TNX->TNX_EPI)
					Dbselectarea("TNX")
					Dbskip()
					Loop
				EndIf
				aAdd(aEpis,{TNX->TNX_EPI})

				Dbselectarea("SB1")
				dbSetOrder( 1 )
				If MsSeek(xFilial("SB1")+TNX->TNX_EPI)
					AADD (aQuadEPI, {TN3->TN3_TIPEPI, TN3->TN3_NUMCAP, SB1->B1_DESC, SubStr(TN3->TN3_AREEPI,1,40) } )
				EndIf
				Dbselectarea("TNX")
				Dbskip()
			End

			Dbselectarea("TO1")
			DbSkip()
		End

	Else

		// Os campos TN3_TIPEPI e TN3_AREEPI por enquanto soh existem no modo de Prestador-Padrao
			Dbselectarea("TO1")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
			While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO

				Dbselectarea("TNX")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TNX", cFil ) + TO1->TO1_NUMRIS )
				While !Eof() .And. xFilial( "TNX", cFil ) + TO1->TO1_NUMRIS == TNX->TNX_FILIAL + TNX->TNX_NUMRIS

					If aScan(aEpis,{|X| X[1] == TNX->TNX_EPI}) > 0
						Dbselectarea("TNX")
						Dbskip()
						Loop
					EndIf

					Dbselectarea("TN3")
					Dbsetorder(2)
					If !MsSeek( xFilial( "TN3", cFil ) + TNX->TNX_EPI )
						Dbselectarea("TNX")
						Dbskip()
						Loop
					EndIf
					aAdd(aEpis,{TNX->TNX_EPI})

					Dbselectarea("SB1")
					dbSetOrder( 1 )
					If MsSeek( xFilial( "SB1", cFil ) + TNX->TNX_EPI )
						AADD (aQuadEPI, {TN3->TN3_TIPEPI, TN3->TN3_NUMCAP, SB1->B1_DESC, SubStr(TN3->TN3_AREEPI,1,40) } )
					EndIf
					Dbselectarea("TNX")
					Dbskip()
				End

				Dbselectarea("TO1")
				DbSkip()
			End
	EndIf

	If Len(aQuadEPI) > 0
		ASORT(aQuadEPI,,,{|x,y| x[1] < y[1] })

		If nModeloImp == 2
			nRegs++
			If _1st
				//     1         2         3         4         5         6         7         8         9        10        11        12        13
					//456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
				//Tipo de Proteção:              C.A. Ref.:    Tipo de EPI:                              Área de Utilização:
				//1234567890123456789012345      123456789012  123456789012345678901234567890123456789   1234567890123456789012345678901234567890
				Somalinha()
				@ Li,004 Psay STR0162  //"Tipo de Proteção:              C.A. Ref.:    Tipo de EPI:                              Tarefa Executada:"
				_1st := .F.
			EndIf
			For nX := 1 To Len(aQuadEpi)
				Somalinha()
				@ Li,004 Psay aQuadEPI[nX][1]
				@ Li,035 Psay aQuadEPI[nX][2]
				@ Li,049 Psay aQuadEPI[nX][3]
				@ Li,091 Psay aQuadEPI[nX][4]
			Next nX
		ElseIf nModeloImp == 3
			For nX := 1 To Len(aQuadEpi)
				If nX == 1
					If lin+120 > 3000
						lin := 9999
					EndIf
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2300)
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Say(lin+10,280,STR0292,oFont08b) //"Tipo de Proteção"
					oPrintPPRA:Line(lin,650,lin+60,650)
					oPrintPPRA:Say(lin+10,760,STR0293,oFont08b) //"C.A. Ref."
					oPrintPPRA:Line(lin,1050,lin+60,1050)
					oPrintPPRA:Say(lin+10,1240,STR0294,oFont08b) //"Tipo de EPI"
					oPrintPPRA:Line(lin,1650,lin+60,1650)
					oPrintPPRA:Say(lin+10,1800,STR0295,oFont08b) //"Tarefa Executada"
					oPrintPPRA:Line(lin,2300,lin+60,2300)
				EndIf
				Somalinha()
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Say(lin+10,160,Substr(aQuadEPI[nX][1],1,30),oFont08)
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Say(lin+10,660,aQuadEPI[nX][2],oFont08)
				oPrintPPRA:Line(lin,1050,lin+60,1050)
				oPrintPPRA:Say(lin+10,1060,Substr(aQuadEPI[nX][3],1,35),oFont08)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Say(lin+10,1660,Substr(aQuadEPI[nX][4],1,40),oFont08)
				oPrintPPRA:Line(lin,2300,lin+60,2300)
			Next nX
		Else
			For nX := 	1 To Len(aQuadEpi)
				nRegs++
				cMemo += Alltrim(aQuadEPI[nX][1])+"#*"
				cMemo += Alltrim(aQuadEPI[nX][2])+"#*"
				cMemo += Alltrim(aQuadEPI[nX][3])+"#*"
				cMemo += Alltrim(aQuadEPI[nX][4])+"#*"
			Next nX
		EndIf

	EndIf

	If nRegs > 0
		If nModeloImp != 1
			Somalinha()
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_EpiQuad")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850CONQ
Imprime as medidas corretivas recomendadas em um quadro contendo as
recomendacoes e as metas.

@author  Andre E. Perez Alvarez
@since   04/07/2006
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850CONQ()

	Local aArea := GetArea()
	Local _1st := .T.
	Local nRegs := 0
	Local cMemo := ""
	Local aMedMod3 := {},nFor
	Local nLinhasMemo := 0
	Local cLinhasMemo := ""
	Local nLinhaCorrente := 0
	Local nLin := 10
	Local nPulaLinha := 60

	If lSigaMdtPS

		Dbselectarea("TO3")
		Dbsetorder(3)
		MsSeek(xFilial("TO3")+cCliMdtPs+TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO .And. cCliMdtPs == TO3->TO3_CLIENT+TO3->TO3_LOJA

			Dbselectarea("TO4")
			dbSetOrder( 1 )
			If MsSeek(xFilial("TO4")+TO3->TO3_CONTRO)

				nRegs++

				If nModeloImp == 2
					If _1st
						//     1         2         3         4         5         6         7         8         9        10        11        12        13
						//456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
						//Recomendações:                                                                           Metas:
						//12345678901234567890123456789012345678901234567890123456789012345678901234567890         1234567890123456789012345678901234567890
						Somalinha()
						@ Li,004 Psay STR0102  //"Recomendações:                                                                           Metas:"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,004 Psay TO4->TO4_NOMCTR
					nLinhasMemo := MLCOUNT(Alltrim(TO4->TO4_DESCRI),40)
					cLinhasMemo := Alltrim(TO4->TO4_DESCRI)
					For nLinhaCorrente := 1 To nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,40,nLinhaCorrente))
							@ Li,093 Psay MemoLine(cLinhasMemo,40,nLinhaCorrente)
							Somalinha()
						EndIf
					Next
				ElseIf nModeloImp == 3
					aAdd( aMedMod3 , { Alltrim(TO4->TO4_DESCRI) , Alltrim(TO4->TO4_NOMCTR) } )
				Else
					cMemo += Alltrim(TO4->TO4_DESCRI)+"#*"
					cMemo += Alltrim(TO4->TO4_NOMCTR)+"#*"
				EndIf

			EndIf

			Dbselectarea("TO3")
			Dbskip()
		End

	Else

		Dbselectarea("TO3")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TO3", cFil ) + TO0->TO0_LAUDO )
		While !Eof() .And. xFilial( "TO3", cFil ) + TO0->TO0_LAUDO == TO3->TO3_FILIAL + TO3->TO3_LAUDO

			Dbselectarea("TO4")
			dbSetOrder( 1 )
			If MsSeek( xFilial( "TO4", cFil ) + TO3->TO3_CONTRO )

				nRegs++

				If nModeloImp == 2
					If _1st
						//     1         2         3         4         5         6         7         8         9        10        11        12        13
						//456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
						//Recomendações:                                                                           Metas:
						//12345678901234567890123456789012345678901234567890123456789012345678901234567890         1234567890123456789012345678901234567890
						Somalinha()
						@ Li,004 Psay STR0102  //"Recomendações:                                                                           Metas:"
						_1st := .F.
					EndIf
					Somalinha()
					@ Li,004 Psay TO4->TO4_NOMCTR
					nLinhasMemo := MLCOUNT(Alltrim(TO4->TO4_DESCRI),40)
					cLinhasMemo := Alltrim(TO4->TO4_DESCRI)
					nLinha := 093
					For nLinhaCorrente := 1 To nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,40,nLinhaCorrente))
							@ Li,nLinha Psay MemoLine(cLinhasMemo,40,nLinhaCorrente)
							Somalinha()
						EndIf
					Next
				ElseIf nModeloImp == 3
					aAdd( aMedMod3 , { Alltrim(TO4->TO4_DESCRI) , Alltrim(TO4->TO4_NOMCTR) } )
				Else
					cMemo += Alltrim(TO4->TO4_DESCRI)+"#*"
					cMemo += Alltrim(TO4->TO4_NOMCTR)+"#*"
				EndIf

			EndIf

			Dbselectarea("TO3")
			Dbskip()
		End

	EndIf

	If nRegs > 0
		If nModeloImp == 2
			Somalinha()
		ElseIf nModeloImp == 3
			For nFor := 1 To Len(aMedMod3)
				If nFor == 1
					If lin+120 > 3000
						lin := 9999
					EndIf
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2300)
					oPrintPPRA:Line(lin+60,150,lin+60,2300)
					oPrintPPRA:Line(lin,150,lin+60,150)
					oPrintPPRA:Say(lin+10,900,STR0296,oFont08b) //"Metas"
					oPrintPPRA:Line(lin,1700,lin+60,1700)
					oPrintPPRA:Say(lin+10,1850,STR0297,oFont08b) //"Embasamento"
					oPrintPPRA:Line(lin,2300,lin+60,2300)
				EndIf
				Somalinha()
				oPrintPPRA:Say(If(nFor == 1,lin+10,lin+nPulaLinha),1710,Substr(aMedMod3[nFor,2],1,37),oFont08)
				//Verifica a quantidade de linhas
				nLinhasMemo := MLCOUNT(Alltrim(aMedMod3[nFor,1]),100)
				cLinhasMemo := Alltrim(aMedMod3[nFor,1])
				For nLinhaCorrente := 1 To nLinhasMemo //Faz a impressão utilizando a quebra de linhas
					If !Empty(MemoLine(cLinhasMemo,100,nLinhaCorrente))
						oPrintPPRA:Say(lin+nLin,160,MemoLine(cLinhasMemo,100,nLinhaCorrente),oFont08)
						nLin= nLin+50
						nPulaLinha:=nLin
					EndIf
				Next nLinhaCorrente
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+nPulaLinha+50,150,lin+nPulaLinha+50,2300)
				oPrintPPRA:Line(lin,150,lin+nPulaLinha+50,150)

				oPrintPPRA:Line(lin,1700,lin+nPulaLinha+50,1700)
				oPrintPPRA:Line(lin,2300,lin+nPulaLinha+50,2300)
			Next nFor
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_MedCorretiva")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850RISQUA
Imprime os riscos associados ao laudo em um quadro que contém as
seguintes colunas:
	- Tipo de Risco Previsto na NR-15
	- Está presente na área de trabalho?
	- Fonte Geradora
	- Trajetória e meio de propagação
	- Funções expostas

@author  Andre E. Perez Alvarez
@since   04/07/2006
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850RISQUA()

	Local aArea := GetArea()
	Local nRegs := 0
	Local _1st := .T.
	Local cMemo := ""
	Local cMemoFonte := ""
	Local cMemoFuncao := ""
	Local cMemoPropag := ""
	Local aTMAcombo := MDTCbox("TMA_GRISCO"," ",1)
	Local bTipoAge := { |cType| If( cType=="1", cTipo+cAgente==TRB->TIPO+TRB->AGENTE, cTipo==TRB->TIPO ) }
	Local lPula := .F.
	Local aFontes := {}
	Local aFuncoes := {}
	Local lTodasFuncoes := .F.
	Local lFunImp := .T.
	Local aDados := {}, aTemp := {}
	Local nX
	Local cPropag := ""
	Local oTempTRB

	aDBF := {}
	AADD(aDBF,{"TIPO"    ,"C",01,0})
	AADD(aDBF,{"DESCTIPO","C",15,0})
	AADD(aDBF,{"AGENTE"  ,"C",06,0})
	AADD(aDBF,{"NOMAGE"  ,"C",40,0})
	AADD(aDBF,{"FONTE"   ,"C",08,0})
	AADD(aDBF,{"NOMFONTE","C",40,0})
	AADD(aDBF,{"PROPAG"  ,"C",25,0})
	AADD(aDBF,{"FUNCAO"  ,"C",05,0})
	AADD(aDBF,{"DESCFUN" ,"C",40,0})

	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"TIPO","AGENTE","FONTE","FUNCAO"} )
	oTempTRB:Create()

	Dbselectarea("TO1")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO

		Dbselectarea("TN0")
		dbSetOrder( 1 )
		If !MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS )
			Dbselectarea("TO1")
			Dbskip()
			Loop
		Else
			If TN0->TN0_MAPRIS == "1"//Valida se o Mapa Risco é igual a CIPA ### Autor: Jackson Machado ### Data: 10/02/2011
				Dbselectarea("TO1")
				Dbskip()
				Loop
			EndIf
		EndIf

		Dbselectarea("TMA")
		dbSetOrder( 1 )
		If !MsSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )
			Dbselectarea("TO1")
			Dbskip()
			Loop
		EndIf

		Dbselectarea("TN7")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )

		Dbselectarea("SRJ")
		dbSetOrder( 1 )
		MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )

		DbSelectArea("TRB")  //TIPO+AGENTE+FONTE+FUNCAO
		If !MsSeek(TMA->TMA_GRISCO+TMA->TMA_AGENTE+TN7->TN7_FONTE+TN0->TN0_CODFUN)
			TRB->(DbAppend())
			TRB->TIPO     := TMA->TMA_GRISCO
			TRB->DESCTIPO := U_MDT850combo(aTMAcombo, TMA->TMA_GRISCO)
			TRB->AGENTE   := TMA->TMA_AGENTE
			TRB->NOMAGE   := AllTrim(TMA->TMA_NOMAGE)
			TRB->FONTE    := TN7->TN7_FONTE
			TRB->NOMFONTE := AllTrim(TN7->TN7_NOMFON)
			TRB->PROPAG   := AllTrim(TMA->TMA_PROPAG)
			TRB->FUNCAO   := TN0->TN0_CODFUN
			TRB->DESCFUN  := If ( AllTrim(TN0->TN0_CODFUN)=="*", STR0163, SRJ->RJ_DESC  )  //"Todas as funções"
			MsUnLock("TRB")
		EndIf

		Dbselectarea("TO1")
		Dbskip()
	End

	If nModeloImp == 2

		If _1st
			/*         1         2         3         4         5         6         7         8         9        10        11        12        13
			//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			//  Tipo de Risco previsto na        Está presente na         Fonte Geradora:        Trajetória e meio de         Funções Expostas
						NR-15:                    área de trabalho?                                   Propagação:                                   */

			//  123456789012345678901234567890         123             123456789012345678901   1234567890123456789012345    12345678901234567890
			Somalinha()
			@ Li,002 Psay STR0164  //"Tipo de Risco previsto na        Está presente na         Fonte Geradora:        Trajetória e meio de"
			Somalinha()
			@ Li,009 Psay STR0165  //"NR-15:                    área de trabalho?                                   Propagação:"
			Somalinha();	SomaLinha()
			_1st := .F.
		EndIf

		DbSelectArea("TRB")
		DbGoTop()
		While !Eof()

			cTipo := TRB->TIPO
			cAgente := TRB->AGENTE
			cPropag := TRB->PROPAG
			aFontes := {}
			aFuncoes := {}
			lTodasFuncoes := .F.

			If TRB->TIPO == "1"
				@ Li,002 Psay AllTrim(TRB->DESCTIPO) + " - " + SubSTR(TRB->NOMAGE,1,20)
			Else
				@ Li,002 Psay AllTrim(TRB->DESCTIPO)
			EndIf
			@ Li,041 Psay STR0166  //"SIM"
			cFuncoesImp := " "
			cFontesGImp := " "

			nTupla := TRB->(Recno())
			While !Eof() .And. EVAL(bTipoAge,cTipo)
				If AllTrim(TRB->FUNCAO) $ "*"
					lTodasFuncoes := .T.
					lFunImp := .F.
				EndIf
				DbSkip()
			End
			DbGoTo(nTupla)

			While !Eof() .And. EVAL(bTipoAge,cTipo)
				lPula := .F.
				If aScan(aFontes,{|x| x[1] == TRB->FONTE }) == 0
					If Empty(cFontesGImp)
						cFontesGImp := SubStr(Alltrim(TRB->NOMFONTE),1,23)
					Else
						cFontesGImp := SubStr(Alltrim(cFontesGImp)+"/"+Alltrim(TRB->NOMFONTE),1,23)
					EndIf
					AADD (aFontes, {TRB->FONTE})
					lPula := .T.
				EndIf

				If lTodasFuncoes
					If !lFunImp
						lFunImp := .T.
						lPula := .T.
					EndIf
				Else
					If aScan(aFuncoes,{|x| x[1] == TRB->FUNCAO }) == 0
						If Empty(cFuncoesImp)
							cFuncoesImp := SubStr(Alltrim(TRB->DESCFUN),1,23)
						Else
							cFuncoesImp := SubStr(Alltrim(cFuncoesImp)+"/"+Alltrim(TRB->DESCFUN),1,23)
						EndIf
						AADD (aFuncoes, {TRB->FUNCAO})
						lPula := .T.
					EndIf
				EndIf
				DbSkip()
			End

			@ Li,060 Psay If(Empty(cFontesGImp)," ",SubStr(cFontesGImp,1,23))
			@ Li,083 Psay Left(cPropag,25)
			SomaLinha()
			nRegs ++
		End

	Else

		aDados := {}
		DbSelectArea("TRB")
		DbGoTop()
		While !Eof()

			aTemp := {}

			cTipo := TRB->TIPO
			cAgente := TRB->AGENTE
			aFontes := {}
			aFuncoes := {}
			lTodasFuncoes := .F.

			If TRB->TIPO == "1"
				cMemo += AllTrim(TRB->DESCTIPO) + " - " + AllTrim(TRB->NOMAGE) +"#*"
				aAdd( aTemp , AllTrim(TRB->DESCTIPO) + " - " + AllTrim(TRB->NOMAGE) )
			Else
				cMemo += AllTrim(TRB->DESCTIPO) +"#*"
				aAdd( aTemp , AllTrim(TRB->DESCTIPO) )
			EndIf
			cMemo += STR0166 +"#*"  //"SIM"
			aAdd( aTemp , STR0166 )

			nTupla := TRB->(Recno())
			While !Eof() .And. EVAL(bTipoAge,cTipo)
				If AllTrim(TRB->FUNCAO) $ "*"
					lTodasFuncoes := .T.
					lFunImp := .F.
				EndIf
				DbSkip()
			End
			DbGoTo(nTupla)

			cMemoFonte := ""
			cMemoFuncao := ""
			cMemoPropag := TRB->PROPAG
			aFontes := {}
			aFuncoes := {}

			While !Eof() .And. EVAL(bTipoAge,cTipo)
				If aScan(aFontes,{|x| x[1] == TRB->FONTE }) == 0
					cMemoFonte += AllTrim(TRB->NOMFONTE) +", "
					AADD (aFontes, {TRB->FONTE})
				EndIf
				If lTodasFuncoes
					If !lFunImp
						cMemoFuncao += STR0163 +", "  //"Todas as Funções"
						lFunImp := .T.
					EndIf
				Else
					If aScan(aFuncoes,{|x| x[1] == TRB->FUNCAO }) == 0
						cMemoFuncao += AllTrim(TRB->DESCFUN) +", "
						AADD (aFuncoes, {TRB->FUNCAO})
					EndIf
				EndIf
				DbSkip()
			End

			nRegs ++
			cMemo += SubSTR(cMemoFonte,1,Len(cMemoFonte)-2)   +"#*"
			aAdd( aTemp , SubSTR(cMemoFonte,1,Len(cMemoFonte)-2) )
			cMemo += AllTrim(cMemoPropag) +"#*"
			aAdd( aTemp , AllTrim(cMemoPropag) )
			aAdd( aDados , aClone(aTemp) )
		End

	EndIf

	If nRegs > 0
		If nModeloImp == 2
			Somalinha()
		ElseIf nModeloImp == 3
			For nX := 1 To Len(aDados)
				If nX == 1
					If lin+150 > 3000
						lin := 9999
					EndIf
					Somalinha()
					oPrintPPRA:Line(lin,150,lin,2300)
					oPrintPPRA:Line(lin+90,150,lin+90,2300)
					oPrintPPRA:Line(lin,150,lin+90,150)
					oPrintPPRA:Say(lin+10,300,STR0298,oFont08b) //"Tipo de Risco previsto na"
					oPrintPPRA:Say(lin+50,450,"NR-15",oFont08b)
					oPrintPPRA:Line(lin,900,lin+90,900)
					oPrintPPRA:Say(lin+10,970,STR0299,oFont08b) //"Está presente na"
					oPrintPPRA:Say(lin+50,960,STR0300,oFont08b) //"área de trabalho?"
					oPrintPPRA:Line(lin,1300,lin+90,1300)
					oPrintPPRA:Say(lin+30,1400,STR0091,oFont08b) //"Fonte Geradora"
					oPrintPPRA:Line(lin,1800,lin+90,1800)
					oPrintPPRA:Say(lin+10,1870,STR0301,oFont08b) //"Trajetória e meio de"
					oPrintPPRA:Say(lin+50,1950,STR0302,oFont08b) //"Propagação"
					oPrintPPRA:Line(lin,2300,lin+90,2300)
					Somalinha(90)
				Else
					Somalinha()
				EndIf
				If lin == 300
					oPrintPPRA:Line(lin,150,lin,2300)
				EndIf
				oPrintPPRA:Line(lin+60,150,lin+60,2300)
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Say(lin+10,160,Substr(aDados[nX,1],1,50),oFont08)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Say(lin+10,910,aDados[nX,2],oFont08)
				oPrintPPRA:Line(lin,1300,lin+60,1300)
				oPrintPPRA:Say(lin+10,1310,Substr(aDados[nX,3],1,28),oFont08)
				oPrintPPRA:Line(lin,1800,lin+60,1800)
				oPrintPPRA:Say(lin+10,1810,Substr(aDados[nX,4],1,28),oFont08)
				oPrintPPRA:Line(lin,2300,lin+60,2300)
			Next nX
		Else
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_RiscoQuad")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	oTempTRB:Delete()

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT850combo
Retorna a descricao de um campo do tipo combo

@param   aCombo, Array, Array com os campos tipo combo
@param   cCampo, cCampo, Campo cuja descrição será retornada

@author  Andre E. Perez Alvarez
@since   04/07/2006

@return  cCombo, Caractere, Descrição do campo
/*/
//-------------------------------------------------------------------
User Function MDT850combo(aCombo, cCampo)

	Local cCombo
	Local nIND := aScan(aCombo,{|x| Upper(Substr(x,1,1)) == Substr(cCampo,1,1)})

	If nIND > 0
		cCombo := Right( AllTrim( aCombo[nIND] ), Len( AllTrim( aCombo[nIND] ) ) - 2 )
	Else
		cCombo := ""
	EndIf

Return cCombo

//-------------------------------------------------------------------
/*/{Protheus.doc} A850CRONOGRAMA
Cronograma do PPRA

@author  Denis H. Souza
@since   04/07/2006
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function A850CRONOGRAMA()

	Local aArea := GetArea()
	Local aPlanos := {}
	Local _1st := .T.
	Local nRegs := 0
	Local cMemo := ""
	Local cPadrao := ""
	Local cPadrao2 := ""
	Local cPadrao3 := ""
	Local nFor
	Local dDtIniCro := cTod("//")
	Local nAnoIni := 0
	Local nMesIni := 0
	Local nAnoFim := 0
	Local nMesFim := 0
	//"Jan/","Fev/","Mar/","Abr/","Mai/","Jun/","Jul/","Ago/","Set/","Out/","Nov/","Dez/","Jan/","Fev/","Mar/","Abr/","Mai/","Jun/","Jul/","Ago/","Set/","Out/","Nov/","Dez/"}
	Local aMes    := {STR0104,STR0105,STR0106,STR0107,STR0108,STR0109,STR0110,STR0111,STR0112,STR0113,STR0114,STR0115,STR0104,STR0105,STR0106,STR0107,STR0108,STR0109,STR0110,STR0111,STR0112,STR0113,STR0114,STR0115}
	Local dtFimReal
	Local dtFimPrev
	Local cMemo2 := ""
	Local lAcao
	Local lPrim1 := .T.
	Local cAcoes := "", cAno := ""
	Local nLinha := 0, LinhaCorrente := 0
	Local cPlaCC := ""
	Local bVldCro := { | dDtTemp , dDtIni , dDtFim | ( Year( dDtTemp ) > Year( dDtIni ) .Or. ;
													( Month( dDtTemp ) >= Month( dDtIni ) .And. ;
													Year( dDtTemp ) == Year( dDtIni ) ) ) .And. ;
													( ( Month( dDtTemp ) <= Month( dDtFim ) .And. ;
													Year( dDtTemp ) == Year( dDtFim ) ) .Or. ;
													Year( dDtTemp ) < Year( dDtFim ) ) }
	If lSigaMdtps

		Dbselectarea("TOZ")
		Dbsetorder(3)
		MsSeek(xFilial("TOZ") + cCliMdtPs + TO0->TO0_LAUDO)
		While !eof() .And. xFilial("TOZ")+TO0->TO0_LAUDO == TOZ->TOZ_FILIAL+TOZ->TOZ_LAUDO .And. cCliMdtPs == TOZ->TOZ_CLIENT+TOZ->TOZ_LOJA

			Dbselectarea( cAliasPA )
			Dbsetorder( nIndexPA )
			If MsSeek(xFilial( cAliasPA )+cCliMdtPs+TOZ->TOZ_PLANO)
				cPlaCC := (cAliasPA)->&(aFieldPA[5])
				If !Empty(cPlaCC) .And. cPlaCC >= IIf(nModeloImp == 1, mv_par11, mv_par09) .And. ;
					cPlaCC <= IIf(nModeloImp == 1, mv_par12, mv_par10)
					TOZ->(Dbskip())
					Loop //Se o centro de custo do Plano de Ação não estiver no intervalo definido nos parâmetros não imprime
				EndIf

				If !Empty((cAliasPA)->&(aFieldPA[8])) .Or. !Empty((cAliasPA)->&(aFieldPA[6]))

					If !Empty((cAliasPA)->&(aFieldPA[7]))
						dtFimPrev := (cAliasPA)->&(aFieldPA[7])
					Else
						dtFimPrev := CtoD("01/01/2040")
					EndIf

					If !Empty((cAliasPA)->&(aFieldPA[9]))
						dtFimReal := (cAliasPA)->&(aFieldPA[9])
					Else
						dtFimReal := CtoD("01/01/2040")
					EndIf

					aADD(aPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[8]),dtFimReal})
				EndIf

			EndIf
			Dbselectarea("TOZ")
			Dbskip()
		End

	Else

		Dbselectarea("TOZ")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TOZ", cFil ) + TO0->TO0_LAUDO )
		While !EoF() .And. xFilial( "TOZ", cFil ) + TO0->TO0_LAUDO == TOZ->TOZ_FILIAL + TOZ->TOZ_LAUDO

			Dbselectarea( cAliasPA )
			Dbsetorder( nIndexPA )
			If MsSeek( xFilial( cAliasPA, cFil ) + TOZ->TOZ_PLANO )
				cPlaCC := (cAliasPA)->&(aFieldPA[5])
				If !Empty(cPlaCC) .And. !(cPlaCC >= IIf(nModeloImp == 1, mv_par11, mv_par09) .And. ;
					cPlaCC <= IIf(nModeloImp == 1, mv_par12, mv_par10))
					TOZ->(Dbskip())
					Loop //Se o centro de custo do Plano de Ação não estiver no intervalo definido nos parâmetros não imprime
				EndIf

				If !Empty((cAliasPA)->&(aFieldPA[8])) .Or. !Empty((cAliasPA)->&(aFieldPA[6]))

					If !Empty((cAliasPA)->&(aFieldPA[7]))
						dtFimPrev := (cAliasPA)->&(aFieldPA[7])
					Else
						dtFimPrev := CtoD("01/01/2040")
					EndIf

					If !Empty((cAliasPA)->&(aFieldPA[9]))
						dtFimReal := (cAliasPA)->&(aFieldPA[9])
					Else
						dtFimReal := CtoD("01/01/2040")
					EndIf

					aADD(aPlanos,{(cAliasPA)->&(aFieldPA[3]),(cAliasPA)->&(aFieldPA[6]),dtFimPrev,(cAliasPA)->&(aFieldPA[8]),dtFimReal})
				EndIf

			EndIf
			TOZ->(Dbskip())
		End

	EndIf

	ASORT(aPlanos,,,{|x,y| x[2] < y[2] })
	If Len(aPlanos) > 0
		dDtIniCro := TO0->TO0_DTINIC
		nAnoIni := Year(dDtIniCro)
		nMesIni := Month(dDtIniCro)
		nAnoFim := Year(dDtIniCro)+1
		nMesFim := Month(dDtIniCro)
	EndIf

	For nFor := 1 To Len(aPlanos)
		If nFor == 1
			cMemo += STR0116+" #*"  //"AÇÕES / MÊS"
			cMemo += aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+" #*"
			cMemo += aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+" #*"

			cPadrao += STR0116+Space(22)
			cPadrao += aMes[nMesIni]+Space(2)
			cAno += SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+1]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+2]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+3]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+4]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+5]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+6]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+7]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+8]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+9]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+10]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+11]+Space(2)
			cAno += SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
			cPadrao += aMes[nMesIni+12]
			cAno += SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2)+Space(4)
		EndIf     //OK

		If nModeloImp == 2 .And. lPrim1// 2 - Padrão
			Somalinha()
			Somalinha()
			@ Li,001 Psay cPadrao
			Somalinha()
			@ Li,034 Psay cAno
			Somalinha()
			@ Li,001 Psay ("_______________________________________________________________________________________________________________")
			lPrim1 := .F.
			Somalinha()
		EndIf

		If nModeloImp == 1 .Or. nModeloImp == 2
			lAcao := .F.
			If !(Year(aPlanos[nFor,2]) > nAnoFim .And. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

				cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
				cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
				lAcao := .T.
				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+Space(5)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")+"#*"
				cPadrao2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X"," ")
			Else
				//Mes 1
				cMemo2 += " "+"#*"
				//Mes 2
				cMemo2 += " "+"#*"
				//Mes 3
				cMemo2 += " "+"#*"
				//Mes 4
				cMemo2 += " "+"#*"
				//Mes 5
				cMemo2 += " "+"#*"
				//Mes 6
				cMemo2 += " "+"#*"
				//Mes 7
				cMemo2 += " "+"#*"
				//Mes 8
				cMemo2 += " "+"#*"
				//Mes 9
				cMemo2 += " "+"#*"
				//Mes 10
				cMemo2 += " "+"#*"
				//Mes 11
				cMemo2 += " "+"#*"
				//Mes 12
				cMemo2 += " "+"#*"
				//Mes 13
				cMemo2 += " "+"#*"
			EndIf

			If !(Year(aPlanos[nFor,4]) > nAnoFim .And. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
					.And. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

				If !lAcao
					cMemo += Sente_Upper(Alltrim(aPlanos[nFor,1])) +" #*"
				EndIf
				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+Space(5)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				cMemo2 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")+"#*"
				cPadrao3 += If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X"," ")
			Else
				//Mes 1
				cMemo2 += " "+"#*"
				//Mes 2
				cMemo2 += " "+"#*"
				//Mes 3
				cMemo2 += " "+"#*"
				//Mes 4
				cMemo2 += " "+"#*"
				//Mes 5
				cMemo2 += " "+"#*"
				//Mes 6
				cMemo2 += " "+"#*"
				//Mes 7
				cMemo2 += " "+"#*"
				//Mes 8
				cMemo2 += " "+"#*"
				//Mes 9
				cMemo2 += " "+"#*"
				//Mes 10
				cMemo2 += " "+"#*"
				//Mes 11
				cMemo2 += " "+"#*"
				//Mes 12
				cMemo2 += " "+"#*"
				//Mes 13
				cMemo2 += " "+"#*"
			EndIf

			If nModeloImp == 2 // 2 - Padrão
				Somalinha()
				@ Li,000 Psay AllTrim(Str(nFor)+"-"+SubStr(cAcoes,1,30))
			@ Li,033 Psay "P"//"Planejado"
				@ Li,035 Psay cPadrao2
			Somalinha()
			@ Li,033 Psay "E"//"Executado"
				@ Li,035 Psay cPadrao3
				Somalinha()
				cPadrao2 := ""
				cPadrao3 := ""
			EndIf
		EndIf
		If nModeloImp == 3  //3 - Gráfico
				Somalinha()
			If lPrim1
				oPrintPPRA:Say(lin+10,280,STR0116,oFont08b) //"AÇÕES / MÊS"
				oPrintPPRA:Box(lin,150,lin+60,2275)
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Line(lin,1775,lin+60,1775)
				oPrintPPRA:Line(lin,1900,lin+60,1900)
				oPrintPPRA:Line(lin,2025,lin+60,2025)
				oPrintPPRA:Line(lin,2150,lin+60,2150)

				oPrintPPRA:Say(lin,651,aMes[nMesIni]+SubsTr(Str(If(nMesIni>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,776,aMes[nMesIni+1]+SubsTr(Str(If(nMesIni+1>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,901,aMes[nMesIni+2]+SubsTr(Str(If(nMesIni+2>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1026,aMes[nMesIni+3]+SubsTr(Str(If(nMesIni+3>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1151,aMes[nMesIni+4]+SubsTr(Str(If(nMesIni+4>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1276,aMes[nMesIni+5]+SubsTr(Str(If(nMesIni+5>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1401,aMes[nMesIni+6]+SubsTr(Str(If(nMesIni+6>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1526,aMes[nMesIni+7]+SubsTr(Str(If(nMesIni+7>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1651,aMes[nMesIni+8]+SubsTr(Str(If(nMesIni+8>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1776,aMes[nMesIni+9]+SubsTr(Str(If(nMesIni+9>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,1901,aMes[nMesIni+10]+SubsTr(Str(If(nMesIni+10>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,2026,aMes[nMesIni+11]+SubsTr(Str(If(nMesIni+11>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				oPrintPPRA:Say(lin,2151,aMes[nMesIni+12]+SubsTr(Str(If(nMesIni+12>12,nAnoFim,nAnoIni),4),3,2),oFont08b)
				Somalinha()
				lPrim1 := .F.
			EndIf

			lAcao := .F.
			If !(Year(aPlanos[nFor,2]) > nAnoFim .And. Month(aPlanos[nFor,2]) > nMesFim) //Se a data inicial prevista está dentro do cronograma

				cAcoes := Sente_Upper(Alltrim(aPlanos[nFor,1]))
				lAcao := .T.

				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				oPrintPPRA:Say(lin+15,713,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				oPrintPPRA:Say(lin+15,838,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				oPrintPPRA:Say(lin+15,963,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				oPrintPPRA:Say(lin+15,1088,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				oPrintPPRA:Say(lin+15,1213,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				oPrintPPRA:Say(lin+15,1338,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				oPrintPPRA:Say(lin+15,1463,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				oPrintPPRA:Say(lin+15,1588,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				oPrintPPRA:Say(lin+15,1713,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				oPrintPPRA:Say(lin+15,1838,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				oPrintPPRA:Say(lin+15,1963,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				oPrintPPRA:Say(lin+15,2088,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				oPrintPPRA:Say(lin+15,2213,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,2] , aPlanos[nFor,3] ),"X",""),oFont08b)
			EndIf

			If !(Year(aPlanos[nFor,4]) > nAnoFim .And. Month(aPlanos[nFor,4]) > nMesFim); //Se a data inicial real está dentro do cronograma
					.And. !Empty(aPlanos[nFor,4]) //Dt Real Ini *e* Final preenchidas

				//Mes 1
				cDtTemp := STOD(StrZero(nAnoIni,4)+Strzero(nMesIni,2)+"01")
				oPrintPPRA:Say(lin+75,713,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 2
				cDtTemp := STOD(StrZero(If(nMesIni+1>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+1>12,nMesIni+1-12,nMesIni+1),2)+"01")
				oPrintPPRA:Say(lin+75,838,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 3
				cDtTemp := STOD(StrZero(If(nMesIni+2>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+2>12,nMesIni+2-12,nMesIni+2),2)+"01")
				oPrintPPRA:Say(lin+75,963,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 4
				cDtTemp := STOD(StrZero(If(nMesIni+3>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+3>12,nMesIni+3-12,nMesIni+3),2)+"01")
				oPrintPPRA:Say(lin+75,1088,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 5
				cDtTemp := STOD(StrZero(If(nMesIni+4>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+4>12,nMesIni+4-12,nMesIni+4),2)+"01")
				oPrintPPRA:Say(lin+75,1213,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 6
				cDtTemp := STOD(StrZero(If(nMesIni+5>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+5>12,nMesIni+5-12,nMesIni+5),2)+"01")
				oPrintPPRA:Say(lin+75,1338,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 7
				cDtTemp := STOD(StrZero(If(nMesIni+6>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+6>12,nMesIni+6-12,nMesIni+6),2)+"01")
				oPrintPPRA:Say(lin+75,1463,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 8
				cDtTemp := STOD(StrZero(If(nMesIni+7>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+7>12,nMesIni+7-12,nMesIni+7),2)+"01")
				oPrintPPRA:Say(lin+75,1588,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 9
				cDtTemp := STOD(StrZero(If(nMesIni+8>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+8>12,nMesIni+8-12,nMesIni+8),2)+"01")
				oPrintPPRA:Say(lin+75,1713,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 10
				cDtTemp := STOD(StrZero(If(nMesIni+9>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+9>12,nMesIni+9-12,nMesIni+9),2)+"01")
				oPrintPPRA:Say(lin+75,1838,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 11
				cDtTemp := STOD(StrZero(If(nMesIni+10>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+10>12,nMesIni+10-12,nMesIni+10),2)+"01")
				oPrintPPRA:Say(lin+75,1963,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 12
				cDtTemp := STOD(StrZero(If(nMesIni+11>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+11>12,nMesIni+11-12,nMesIni+11),2)+"01")
				oPrintPPRA:Say(lin+75,2088,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
				//Mes 13
				cDtTemp := STOD(StrZero(If(nMesIni+12>12,nAnoFim,nAnoIni),4)+Strzero(If(nMesIni+12>12,nMesIni+12-12,nMesIni+12),2)+"01")
				oPrintPPRA:Say(lin+75,2213,If(Eval( bVldCro, cDtTemp , aPlanos[nFor,4] , aPlanos[nFor,5] ),"X",Space(1)),oFont08b)
			EndIf

			If nModeloImp == 3  //3 - Gráfico
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Line(lin,570,lin+60,570)
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Line(lin,1775,lin+60,1775)
				oPrintPPRA:Line(lin,1900,lin+60,1900)
				oPrintPPRA:Line(lin,2025,lin+60,2025)
				oPrintPPRA:Line(lin,2150,lin+60,2150)
				oPrintPPRA:Line(lin,2275,lin+60,2275)
				oPrintPPRA:Line(lin,150,lin,2275)
				nLinhasMemo := MLCOUNT(AllTrim(cAcoes),17)
				oPrintPPRA:Say(lin,170,AllTrim(Str(nFor)+" - "),oFont08b)
				nLinha := lin
				For LinhaCorrente := 1 To nLinhasMemo
					If	LinhaCorrente > 2
						Exit
					EndIf
					If !empty( (MemoLine(cAcoes,17,LinhaCorrente)))
					oPrintPPRA:Say(nLinha,220,MemoLine(cAcoes,17,LinhaCorrente),oFont08b)
					nLinha := lin+40
					EndIf
				Next
				oPrintPPRA:Say(lin+10,600,"P",oFont08b)//"Planejado"
				SomaLinha()
				oPrintPPRA:Line(lin,575,lin,2275) //linhas
				oPrintPPRA:Line(lin,150,lin+60,150)
				oPrintPPRA:Line(lin,570,lin+60,570)
				oPrintPPRA:Line(lin,650,lin+60,650)
				oPrintPPRA:Line(lin,775,lin+60,775)
				oPrintPPRA:Line(lin,900,lin+60,900)
				oPrintPPRA:Line(lin,1025,lin+60,1025)
				oPrintPPRA:Line(lin,1150,lin+60,1150)
				oPrintPPRA:Line(lin,1275,lin+60,1275)
				oPrintPPRA:Line(lin,1400,lin+60,1400)
				oPrintPPRA:Line(lin,1525,lin+60,1525)
				oPrintPPRA:Line(lin,1650,lin+60,1650)
				oPrintPPRA:Line(lin,1775,lin+60,1775)
				oPrintPPRA:Line(lin,1900,lin+60,1900)
				oPrintPPRA:Line(lin,2025,lin+60,2025)
				oPrintPPRA:Line(lin,2150,lin+60,2150)
				oPrintPPRA:Line(lin,2275,lin+60,2275)
				oPrintPPRA:Say(lin+10,600,"E",oFont08b)//"Executado"
			EndIf
		EndIf
	Next nFor

	nRegs := Len(aPlanos)
	If nRegs > 0
		If nModeloImp == 1//Word


			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord,"Tabela2",cMemo2)
			OLE_SetDocumentVar(oWord,"Linhas",nRegs)
			OLE_ExecuteMacro(oWord,"Table_Cronograma")
			_lJumpCab := lJumpCab
			lJumpCab := .T.
			U_IMPHEA850("{CN}P: "+STR0167,.F.)  //"Planejado"
			lJumpCab := .T.
			U_IMPHEA850("{CN}E: "+STR0168,.F.)  //"Executado"
			lJumpCab := _lJumpCab
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		ELseIf nModeloImp == 2  //2 - Padrão
		SomaLinha()
			@ Li,055 Psay "P: "+STR0167
			Somalinha()
			@ Li,055 Psay "E: "+STR0168
			Somalinha()
	ELseIf nModeloImp == 3  //3 - Gráfico
		SomaLinha()
			oPrintPPRA:Line(lin,150,lin,2275)
			oPrintPPRA:Say(lin+10,1220,"P: "+STR0167,oFont08b)
			SomaLinha()
			oPrintPPRA:Say(lin+10,1220,"E: "+STR0168,oFont08b)
		EndIf
	Else
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} A850UMIDADE
Imprime as funções expostas aos riscos químico-umidade do laudo

@author  Denis H. Souza
@since   04/07/2006
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function A850UMIDADE()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local nF
	Local aRiscQuimico := {}
	Local cDescFun := ""

	Dbselectarea("TO1")
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TO1" ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO
		Dbselectarea("TN0")
		dbSetOrder( 1 )
		//Valida se o Mapa Risco é diferente de CIPA
		//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
		//### Autor: Jackson Machado ### Data: 10/02/2011
		If MsSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS ) .And. TN0->TN0_MAPRIS != "1".And. ;
			((TN0->TN0_CC >= IIf( nModeloImp == 1, mv_par11, mv_par09 ) .And. TN0->TN0_CC <= IIf( nModeloImp == 1, mv_par12, mv_par10 ) ) .Or. AllTrim( TN0->TN0_CC ) == "*" )
			Dbselectarea("TMA")
			dbSetOrder( 1 )
			If MsSeek(xFilial("TMA", cFil ) + TN0->TN0_AGENTE )
				If TMA->TMA_GRISCO <> "2" .Or. !(STR0169 $ UPPER(TMA->TMA_NOMAGE))  //"UMIDADE"
					Dbselectarea("TO1")
					Dbskip()
					Loop
				EndIf
				Dbselectarea("TN7")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN7", cFil ) + TN0->TN0_FONTE )
				dbSelectArea( cAliasCC )
				dbSetOrder( 1 )
				MsSeek( xFilial( cAliasCC, cFil ) + TN0->TN0_CC )

				If Alltrim(TN0->TN0_CODFUN) == "*"
					cDescFun := STR0170  //"Todas"
				Else
					Dbselectarea("SRJ")
					dbSetOrder( 1 )
					MsSeek( xFilial( "SRJ", cFil ) + TN0->TN0_CODFUN )
					cDescFun := Alltrim(SRJ->RJ_DESC)
				EndIf

				Dbselectarea( "TN5" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TN5", cFil ) + TN0->TN0_CODTAR )
				Dbselectarea( "TNE" )
				dbSetOrder( 1 )
				MsSeek( xFilial( "TNE", cFil ) + TN0->TN0_CODAMB )

				lPrin2 := .F.
				lPrint := .F.
				If aScan(aRiscos,{|X| X[1] == TN0->TN0_NUMRIS}) == 0
					aAdd(aRiscos,{TN0->TN0_NUMRIS})
				EndIf
				//{Numero do risco, Centro de Custo, Nome da tarefa, Descricao da tarefa, Descricao da funcao, Nome do Agente  }
				aAdd(aRiscQuimico,{TN0->TN0_NUMRIS,&cDescrCC,;
									TN5->TN5_NOMTAR,If(TN5->(FieldPos("TN5_DESCRI")) > 0,TN5->TN5_DESCRI,TN5->TN5_DESTAR),;
									cDescFun,TMA->TMA_NOMAGE})
			EndIf
		EndIf
		Dbselectarea("TO1")
		Dbskip()
	End

	ASORT(aRiscQuimico,,,{|x,y| x[2]+x[3]+x[4] < y[2]+y[3]+y[4] })

	If Len(aRiscQuimico) > 0 .And. nModeloImp != 1
		Somalinha()
		U_IMPHEA850(STR0171)  //"FUNÇÕES EXPOSTAS AO AGENTE UMIDADE"
		If nModeloImp == 2
			SomaLinha()
		EndIf
		For nF := 1 To Len(aRiscQuimico)
			U_IMPDOC850("- " + Substr(aRiscQuimico[nF,5],1,40))
		Next nF
		SomaLinha()
	ElseIf Len(aRiscQuimico) > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Somalinha")

		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro(oWord,"Somalinha")
		OLE_ExecuteMacro(oWord,"Cria_Titulo")
		OLE_ExecuteMacro(oWord,"ativar_negrito")
		OLE_ExecuteMacro(oWord,"Identar")
		OLE_SetDocumentVar(oWord,cVar1,STR0171)  //"FUNÇÕES EXPOSTAS AO AGENTE UMIDADE"
		OLE_ExecuteMacro(oWord,"Somalinha")

		For nF := 1 To Len(aRiscQuimico)
			cVar1 := "cTXT"+Strzero(nVar1,6)
			OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
			nVar1++
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Cria_Texto")
			OLE_ExecuteMacro(oWord,"desativar_negrito")
			OLE_ExecuteMacro(oWord,"Identar")
			OLE_SetDocumentVar(oWord,cVar1,Substr(aRiscQuimico[nF,5],1,40))
			OLE_ExecuteMacro(oWord,"Somalinha")
		Next nF

		OLE_ExecuteMacro(oWord,"Somalinha")

	Else
		Somalinha()
	EndIf

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Equip850
Imprime as informações relacionadas ao equipamento

@author  Denis Hyroshi de Souza
@since   07/02/2006
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function Equip850()

	nRegs++
	If nModeloImp == 2
		If _1st
			Somalinha()
			@ Li,000 Psay STR0073 //"Equipamentos:  Nome                           Fabricante            Data Calibração  Data Aferição"
			_1st := .F.
		EndIf
		Somalinha()
		@ Li,015 Psay Substr(TM7->TM7_NOEQTO,1,28)
		@ Li,046 Psay Substr(TM7->TM7_NOMFAB,1,19)
		@ Li,068 Psay TM7->TM7_DTCALI
		@ Li,085 Psay TM7->TM7_DTAFER
	ElseIf nModeloImp == 3
		If _1st
			Somalinha()
			oPrintPPRA:Say(lin,200,STR0304,oFont08b) //"Equipamentos:"
			oPrintPPRA:Say(lin,550,STR0096,oFont08b) //"Nome"
			oPrintPPRA:Say(lin,1200,STR0305,oFont08b) //"Fabricante"
			oPrintPPRA:Say(lin,1700,STR0306,oFont08b) //"Data Calibração"
			oPrintPPRA:Say(lin,2000,STR0307,oFont08b) //"Data Aferição"
			_1st := .F.
		EndIf
		Somalinha()
		oPrintPPRA:Say(lin,550,Substr(TM7->TM7_NOEQTO,1,22),oFont08)
		oPrintPPRA:Say(lin,1200,Substr(TM7->TM7_NOMFAB,1,16),oFont08)
		oPrintPPRA:Say(lin,1700,DtoC(TM7->TM7_DTCALI),oFont08)
		oPrintPPRA:Say(lin,2000,DtoC(TM7->TM7_DTAFER),oFont08)
	Else
		cMemo += Substr(TM7->TM7_NOEQTO,1,25)+"#*"
		cMemo += Substr(TM7->TM7_NOMFAB,1,15)+"#*"
		cMemo += If(!Empty(TM7->TM7_DTCALI),DTOC(TM7->TM7_DTCALI),"__/__/__")+"#*"
		cMemo += If(!Empty(TM7->TM7_DTAFER),DTOC(TM7->TM7_DTAFER),"__/__/__")+"#*"
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Plano850
description

@author  Denis Hyroshi de Souza
@since   07/02/2006
@return  Lógico, Sempre verdadeiro
/*/
//-------------------------------------------------------------------
User Function Plano850()

	Local nSalta:= 0

	Private cFil     := FWCodFil()

	aAdd(aPlanos,TNJ->TNJ_CODPLA)

	If nModeloImp == 2
		lAchou := .T.
		Somalinha()
		Somalinha()
		@li,000 Psay STR0204+"   "+Alltrim((cAliasPA)->&(aFieldPA[3]))  //"Plano de Ação:    "
		Somalinha()
		@li,000 Psay STR0206+"   "+Alltrim((cAliasPA)->&(aFieldPA[10]))    //"O que ?           "
		Somalinha()
		@li,000 Psay STR0207+"   "+Alltrim((cAliasPA)->&(aFieldPA[12]))    //"Onde ?            "
		Somalinha()
		@li,000 Psay STR0208+"   "+Alltrim((cAliasPA)->&(aFieldPA[13]))  //"Por que ?         "
		Somalinha()
		@li,000 Psay STR0209+"   "+Alltrim((cAliasPA)->&(aFieldPA[14]))  //"Como ?            "
		Somalinha()
		@li,000 Psay STR0210+"   "+STR0211+DtoC((cAliasPA)->&(aFieldPA[6]))+"  "+STR0212+;  //"Data Início:      "//"Prevista: "//"Real: "
			DtoC((cAliasPA)->&(aFieldPA[8]))
		Somalinha()
		@li,000 Psay STR0213+"   "+STR0211+DtoC((cAliasPA)->&(aFieldPA[7]))+"  "+STR0212+;  //"Data Fim:         "  //"Real: "
			DtoC((cAliasPA)->&(aFieldPA[9]))
		If (cAliasPA)->&(aFieldPA[17]) > 0 .Or. (cAliasPA)->&(aFieldPA[18]) > 0 .Or. (cAliasPA)->&(aFieldPA[19]) > 0
			Somalinha()
			@li,000 Psay STR0214+"   "+STR0215+Ltrim(Str((cAliasPA)->&(aFieldPA[17]),8,2))+"  "+STR0216+;  //"Quantidade:       "  //"Atual: "  //"Meta: "
				Ltrim(Str((cAliasPA)->&(aFieldPA[18]),8,2))+"  "+STR0217+Ltrim(Str((cAliasPA)->&(aFieldPA[19]),9,2))  //"Final: "
		EndIf
		Somalinha()
		@li,000 Psay STR0205 //"Responsável:      "
		cWhile := "TC9->TC9_CODPLA == TNJ->TNJ_CODPLA"
		If IsInCallStack( "MDTR870" )
			cWhile := "TC9->TC9_CODPLA == TOZ->TOZ_PLANO"
		EndIf

		Dbselectarea("TC9")
		dbSetOrder( 1 )
		MsSeek(xFilial("TC9", cFil)+(cAliasPA)->&(aFieldPA[2]))

		While TC9->(!Eof()).And. &( cWhile )
			If TC9->TC9_TIPRES == "2"
				@li,021 Psay Alltrim( SubStr( NGSEEK( "SRA", Alltrim( TC9->TC9_CODRES ), 1, "RA_NOME", cFil ) , 1, 40 ) )  //"Responsável:      "
			Else
				@li,021 Psay Alltrim( SubStr( NGSEEK( "QAA", Alltrim(  TC9->TC9_CODRES), 1, "QAA_NOME", cFil ), 1, 40 ) )  //"Responsável:      "
			EndIf
			Somalinha()
			TC9->(dbSkip())
		End
	Else
		If nModeloImp == 3
			Somalinha()
		EndIf
		U_IMPHEA850("{N}"+STR0178)  //"Plano de Ação:"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(Alltrim((cAliasPA)->&(aFieldPA[3])))

		U_IMPHEA850("{N}"+STR0219,.T.)  //"O que ?"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(Alltrim((cAliasPA)->&(aFieldPA[10])))

		U_IMPHEA850("{N}"+STR0220,.T.)  //"Onde ?"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(Alltrim((cAliasPA)->&(aFieldPA[12])))

		U_IMPHEA850("{N}"+STR0221,.T.)  //"Por que ?"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(Alltrim((cAliasPA)->&(aFieldPA[13])))

		U_IMPHEA850("{N}"+STR0222,.T.)  //"Como ?"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(Alltrim((cAliasPA)->&(aFieldPA[14])))

		U_IMPHEA850("{N}"+STR0223,.T.)  //"Data Início:"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(STR0211+DtoC((cAliasPA)->&(aFieldPA[6]))+STR0225+DtoC((cAliasPA)->&(aFieldPA[8])))  //"Prevista: "  //"  Real: "

		U_IMPHEA850("{N}"+STR0226,.T.)  //"Data Fim:"
		lPrint := .F.
		lPrin2 := .F.
		U_IMPDOC850(STR0211+DtoC((cAliasPA)->&(aFieldPA[7]))+STR0225+DtoC((cAliasPA)->&(aFieldPA[9])))  //"  Real: "

		If (cAliasPA)->&(aFieldPA[17]) > 0 .Or. (cAliasPA)->&(aFieldPA[18]) > 0 .Or. (cAliasPA)->&(aFieldPA[19]) > 0
			U_IMPHEA850("{N}"+STR0224,.T.)  //"Quantidade:"
			lPrint := .F.
			lPrin2 := .F.
			U_IMPDOC850(STR0215+Ltrim(Str((cAliasPA)->&(aFieldPA[17]),8,2))+"  "+STR0216+Ltrim(Str((cAliasPA)->&(aFieldPA[18]),8,2))+;  //"Atual: "  //"Meta: "
				"  "+STR0217+Ltrim(Str((cAliasPA)->&(aFieldPA[19]),8,2)))  //"Final: "
		EndIf
		U_IMPHEA850("{N}"+STR0218,.T.)  //"Responsável:"
		lPrint := .F.
		lPrin2 := .F.
		cWhile := "TC9->TC9_CODPLA == TNJ->TNJ_CODPLA"
		If IsInCallStack( "MDTR870" )
			cWhile := "TC9->TC9_CODPLA == TOZ->TOZ_PLANO"
		EndIf
		Dbselectarea("TC9")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TC9", cFil ) + (cAliasPA)->&(aFieldPA[2]) )
		While TC9->(!Eof()).And. &( cWhile )
			nSalta++
			If TC9->TC9_TIPRES == "2"
				U_IMPDOC850( Alltrim( SubStr( NGSEEK( "SRA", Alltrim( TC9->TC9_CODRES ), 1, "RA_NOME", cFil ), 1, 40 ) ), nSalta > 1 )
			Else
				U_IMPDOC850( Alltrim( SubStr( NGSEEK( "QAA", Alltrim( TC9->TC9_CODRES ), 1, "QAA_NOME", cFil ), 1, 40 ) ), nSalta > 1 )
			EndIf
			TC9->(dbSkip())
		End

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} Sente_Upper
Transforma a primeira palavra de uma sentença em maiúscula

@author  Andre Perez Alvarez
@since   03/05/2007
@param   cTexto, Caractere, String a ser tranformada

@return  cTextoAux, Caractere, String processada
/*/
//-------------------------------------------------------------------
Static Function Sente_Upper(cTexto)

	Local cTextoNew := SubSTR(cTexto,1,1) + Lower(SubStr(cTexto,2))
	Local cTextoAux := ""

	While .T.

		nPos := at(". ",cTextoNew)
		If nPos > 0
			cTextoAux += SubSTR(cTextoNew,1,nPos+1)
			cTextoNew := Upper(SubSTR(cTextoNew,nPos+2,1)) + SubSTR(cTextoNew,nPos+3)
		Else
			cTextoAux += cTextoNew
			Exit
		EndIf

	End

Return cTextoAux

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT850CCVL
Valida o centro de custo do cliente

@author  Andre Perez Alvarez
@since   03/05/2007
@param   cCodCC, Caractere, Código do Centro de Custo

@return  Lógico, Verdadeiro se o centro de custo pertencer ao cliente
selecionado
/*/
//-------------------------------------------------------------------
User Function MDT850CCVL(cCodCC)

	If SubStr(cCodCC,1,nTa1+nTa1L) <> cCliMdtps
		msgStop(STR0118)  //"O centro de custo deve pertencer ao cliente selecionado."
		Return .F.
	EndIf

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} MDT850VMV9
Define se o valor da pergunta Até Centro de Custo é valido

@author Jorge Luis Siementkowski
@since 27/10/2017
@return lRet, Lógico, Verdadeiro se a pergunta for válida
/*/
//-------------------------------------------------------------------------------
User Function MDT850VMV9()

	Local lRet := .T.
	Local cDeCC, cAteCC

	If ValType( mv_par05 ) == 'C'

		cDeCC := mv_par05
		cAteCC :=  mv_par06

	Else

		cDeCC := IIf( nModeloImp == 1, mv_par11, mv_par09 )
		cAteCC := IIf( nModeloImp == 1, mv_par12, mv_par10 )

	EndIF

	If lMdtUmCC .And. !lMdtCC
		If cDeCC <> cAteCC
			ShowHelpDlg( STR0125 , { STR0501 } ,3,{ STR0502 } , 3 )
			lRet := .F.
		Else
			lRet := .T.
		EndIf
	Else
		lRet := AteCodigo("CTT" , cDeCC, cAteCC, len(cAteCC))
	EndIf

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fReguaPPRA
Processa regua

@author  Denis Hyroshi de Souza
@since   03/05/2007
@sample  sample

@param   nLenMemo , Numérico, Tamanho do memo
@param   nPerMemo , Numérico, Porcentagem processada
@param   nLenAtual, Numérico, Tamanho atual do memo

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
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

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT850FLVL
Valida os campos De/Ate Filial

@author  Milena Leite de Oliveira
@since   24/03/2020
@sample  U_MDT850FLVL(1)

@param   nCampo, Numérico, Campo que será validado
@return  Lógico, Retorna .T. se o conteúdo do campo está certo
/*/
//-------------------------------------------------------------------
User Function MDT850FLVL(nCampo)

	Local lRet    := .T.
	Local cArea   := Alias()
	Local aArea   := SM0->(GetArea())
	Local cDeFil, cAteFil

	If ValType( mv_par05 ) == 'C'

		cDeFil := mv_par03
		cAteFil :=  mv_par04

	Else

		cDeFil := IIf( nModeloImp != 1, mv_par12, mv_par14 )
		cAteFil := IIf( nModeloImp != 1, mv_par13, mv_par15 )

	EndIF

	If nCampo == 1
		If !Empty( cDeFil )
			dbSelectArea( "SM0" )
			If !dbSeek( cEmpAnt + cDeFil ) //Verifica se existe a filial na empresa
				Help( " ", 1, "REGNOIS" )
				lRet := .F.
			EndIf
			If cDeFil > cAteFil
				cAteFil := cDeFil
			EndIf
		EndIf
	ElseIf nCampo == 2
		If !Empty( cAteFil ) .And. cAteFil <> Replicate( "Z", Len( cAteFil ) ) .And. cAteFil <> Replicate( "9", Len( cAteFil ) )
			If cDeFil > cAteFil
				Help( " ", 1, "DEATEINVAL" )
				lRet := .F.
			Else
				dbSelectArea( "SM0" )
				If !dbSeek( cEmpAnt + cAteFil )
					Help( " ", 1, "REGNOIS" )
					lRet := .F.
				EndIf
			EndIf
		EndIf
	EndIf

	If ( ( !Empty( cDeFil ) .Or. !Empty( cAteFil ) ) .And. cDeFil != cAteFil ) .And. !Empty( Mv_par01 ) //Se vai ser escolhida uma ou mais filiais
		MsgInfo( STR0508 ) //"Para impressão de laudo de mais de uma filial, deixe o código do laudo em branco!"
	EndIf

	RestArea( aArea )
	dbSelectArea( cArea )

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fQtdFunRis
Contabiliza a quantidade de funcionarios expostos a riscos.

@author  Roger Rodrigues
@since   11/05/2010
@return  nFunc, Numérico, Número total de funcionáios expostos a
riscos
/*/
//-------------------------------------------------------------------
Static Function fQtdFunRis( cFilPar )

	Local aFunc := {} , nFunc := 0
	Local cCusto := "", cFunc := "" , cTar := "", cDepto := ""
	Local cMat := " " , cSeek := " "
	Local lRet := .T. , nInd  := 1
	Local aCateg := {},n , cCond := ""
	Local nTamCC := If((TAMSX3("TN0_CC")[1]) < 1,9,(TAMSX3("TN0_CC")[1]))
	Local nTamFun:= If((TAMSX3("TN0_CODFUN")[1]) < 1,5,(TAMSX3("TN0_CODFUN")[1]))
	Local nTamTar:= If((TAMSX3("TN0_CODTAR")[1]) < 1,6,(TAMSX3("TN0_CODTAR")[1]))
	Local nTamDep:= TAMSX3("TN0_DEPTO")[1]
	Local cSeekTN0
	Local nXY    := 1

	cFiltroF := Alltrim(SuperGetMv("MV_NGCATFU",.F.,""))
	aCateg := fSubCateg(cFiltroF)
	For n:=1 To Len(aCateg)
		cCond += " AND RA_CATFUNC <> '"+aCateg[n] + "' "
	Next

	If !lSigaMdtPs
		dbSelectArea("TN0")
		dbSetOrder(5)
		cSeekTN0 := xFilial("TN0")+PADR( "*", nTamCC )+PADR( "*", nTamFun )+PADR( "*", nTamTar )
		cSeekTN0 += PADR( "*", nTamDep)

		If MsSeek( cSeekTN0 ) .Or. lImpTodos //Se achar centro de custo/funcao/tarefa * considera todos
			#IFDEF TOP
				cTabSRA := RetSqlName("SRA")
				cFilSRA := xFilial("SRA", cFilPar )
				cAliasSRA := GetNextAlias()
				cQuery := "SELECT COUNT(*) AS TOTAL "
				cQuery += "FROM " + cTabSRA + " "
				cQuery += "WHERE (RA_SITFOLH != 'D' OR RA_DEMISSA > " + ValToSql(DtoS(dAteLaudo)) + ") "
				cQuery += "AND RA_ADMISSA < " + ValToSql(DtoS(dAteLaudo)) + " AND RA_FILIAL = " + ValToSql(cFilSRA) + " AND D_E_L_E_T_ != '*' "
				If nModeloImp == 1
					cQuery += "AND RA_CC BETWEEN " + ValToSql(Mv_par11) + " AND " + ValToSql(Mv_par12)
				Else
					cQuery += "AND RA_CC BETWEEN " + ValToSql(Mv_par09) + " AND " + ValToSql(Mv_par10)
				EndIf

				If !Empty(cCond)
					cQuery += cCond
				EndIf
				cQuery := ChangeQuery(cQuery)
				MPSysOpenQuery(cQuery, cAliasSRA)
				dbSelectArea(cAliasSRA)
				nFunc := (cAliasSRA)->TOTAL
				(cAliasSRA)->( dbCloseArea() )
				Return nFunc
			#ELSE
				dbSelectArea("SRA")
				dbSetOrder( 1 )
				MsSeek( xFilial( "SRA", cFilPar ) )
				While !Eof() .And. xFilial( "SRA", cFilPar ) == SRA->RA_FILIAL
					If SRA->RA_CATFUNC $ cFiltroF //Indica as Categorias Funcionais que nao aparecerao no PPRA
						dbSelectArea("SRA")
						dbSkip()
						Loop
					EndIf
					If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
						dbSelectArea("SRA")
						Dbskip()
						Loop
					EndIf
					If SRA->RA_ADMISSA > dAteLaudo
						dbSelectArea("SRA")
						Dbskip()
						Loop
					EndIf
					nFunc++
					dbSelectArea("SRA")
					dbSkip()
					Loop
				End
				Return nFunc
			#EndIf
		Else
			//Percorre todos os riscos
			dbSelectArea("TN0")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TN0", cFilPar ) )
			While !Eof() .And. xFilial( "TN0", cFilPar ) == TN0->TN0_FILIAL
				If TN0->TN0_MAPRIS == "1" //Valida se o Mapa Risco é igual a CIPA ### Autor: Jackson Machado ### Data: 10/02/2011
					dbSelectArea("TN0")
					dbSkip()
					Loop
				EndIf
				dbSelectArea("TO1")
				dbSetOrder( 1 )
				dbGoTop()
				If !MsSeek( xFilial( "TO1", cFilPar )+cCodLaudo+TN0->TN0_NUMRIS )
					dbSelectArea("TN0")
					dbSkip()
					Loop
				EndIf
				dbSelectArea("TN0")

				cCusto := TN0->TN0_CC
				cFunc := TN0->TN0_CODFUN
				cTar := TN0->TN0_CODTAR
				cDepto := TN0->TN0_DEPTO
				If Alltrim(cCusto) == "*"
					If Alltrim(cFunc) == "*"
						If Alltrim(cDepto) == "*"
							If Alltrim(cTar) == "*"
								Return 0
							Else
								dbSelectArea("TN6")
								dbSetOrder(01)
								MsSeek(xFilial("TN6")+cTar)//Verifica quantidade da tarefa
								While !EOF() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. TN6->TN6_CODTAR == cTar
									dbSelectArea("SRA")
									dbSetOrder(01)
									If MsSeek(xFilial("SRA")+TN6->TN6_MAT)  .And.;
										TN6->TN6_DTINIC <= dDatabase         .And.;
										(TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
										//Verifica se não esta demitido e no array
										If (SRA->RA_SITFOLH == "D") .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_ADMISSA > dAteLaudo
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If (SRA->RA_SITFOLH != "D" .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0) .And. !(SRA->RA_CATFUNC $ cFiltroF)) .Or.;
											(!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA > dAteLaudo .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0) .And. !(SRA->RA_CATFUNC $ cFiltroF))
											aADD(aFunc,{SRA->RA_MAT})
										EndIf
									EndIf
									dbSelectArea("TN6")
									dbSkip()
									Loop
								End
								lRet := .F.
								//Volta ao loop principal
								dbSelectArea("TN0")
								dbSkip()
								Loop
							EndIf
						Else
							lRet := .T.
							nInd   := 21 //Ordenar pelo Codigo do Departamento
							cSeek  := cDepto
							cField := "SRA->RA_DEPTO"
						EndIf
					Else
						lRet := .T.
						nInd   := 7 //Ordenar pelo Codigo da Funcao
						cSeek  := cFunc
						cField := "SRA->RA_CODFUNC"
					EndIf
				Else
					lRet := .T.
					nInd   := 2 //Ordenar pelo Codigo do Centro de Custo
					cSeek  := cCusto
					cField := "SRA->RA_CC"
				EndIf

				If lRet
					//Percorre SRA com chave (CC ou funcao)
					dbSelectArea("SRA")
					dbSetOrder(nInd)
					MsSeek(xFilial("SRA")+cSeek)
					While !EOF() .And. xFilial("SRA") == SRA->RA_FILIAL .And. &cField == cSeek
						//Nao le demitidos
						If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
							dbSelectArea("SRA")
							Dbskip()
							Loop
						EndIf
						If SRA->RA_ADMISSA > dAteLaudo
							dbSelectArea("SRA")
							Dbskip()
							Loop
						EndIf
						If SRA->RA_CATFUNC $ cFiltroF //Indica as Categorias Funcionais que nao aparecerao no PPRA
							dbSelectArea("SRA")
							dbSkip()
							Loop
						EndIf

						lFunc := .F.
						//Se estiver por funcao
						If nInd == 7
							If (SRA->RA_CC == cCusto .Or. Alltrim(cCusto) == "*") .And. (SRA->RA_DEPTO == cDepto .Or. Alltrim(cDepto) == "*")
									If Alltrim(cTar) == "*"//Se todas as tarefas
										If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_ADMISSA > dAteLaudo
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If (SRA->RA_SITFOLH != "D" .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0)) .Or.;
											(!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA > dAteLaudo .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0))
											aADD(aFunc,{SRA->RA_MAT})
										EndIf
										//Volta ao Loop da SRA
										dbSelectArea("SRA")
										dbSkip()
										Loop
									Else
										lFunc := .T.//Indice que deve verificar tarefa
									EndIf
								EndIf
							ElseIf nInd == 21
								If (SRA->RA_CODFUNC == cFunc .Or. Alltrim(cFunc) == "*") .And. ;
										(SRA->RA_CC == cCusto .Or. Alltrim(cCusto) == "*")
									If Alltrim(cTar) == "*"
										If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_ADMISSA > dAteLaudo
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_SITFOLH != "D" .And.	(aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0)
											aADD(aFunc,{SRA->RA_MAT})
										EndIf
										dbSelectArea("SRA")//Volta ao Loop da SRA
										dbSkip()
										Loop
									Else
										lFunc := .T.
									EndIf
								EndIf
							Else
								If (SRA->RA_CODFUNC == cFunc .Or. Alltrim(cFunc) == "*") .And. ;
										(SRA->RA_DEPTO == cDepto .Or. Alltrim(cDepto) == "*")
									If Alltrim(cTar) == "*"
										If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_ADMISSA > dAteLaudo
											dbSelectArea("SRA")
											Dbskip()
											Loop
										EndIf
										If SRA->RA_SITFOLH != "D" .And.	(aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0)
											aADD(aFunc,{SRA->RA_MAT})
										EndIf
										dbSelectArea("SRA")//Volta ao Loop da SRA
										dbSkip()
										Loop
									Else
										lFunc := .T.//Indice que deve verificar tarefa
									EndIf
								EndIf
							EndIf

						//Verifica por tarefa
						If lFunc
							dbSelectArea("TN6")
							dbSetOrder(01)
							MsSeek(xFilial("TN6")+cTar+SRA->RA_MAT)
							While !Eof() .And. xFilial("TN6") == TN6->TN6_FILIAL .And. TN6->TN6_MAT == SRA->RA_MAT .And. TN6->TN6_CODTAR == cTar
								If TN6->TN6_DTINIC <= dDatabase .And. (TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
									If (SRA->RA_SITFOLH != "D" .And.	SRA->RA_ADMISSA < dAteLaudo .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0)) .Or.;
										(!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA > dAteLaudo .And.	SRA->RA_ADMISSA < dAteLaudo .And. (aScan(aFunc,{|x| Trim(Upper(x[1])) == Trim(Upper(SRA->RA_MAT)) }) == 0))
										aADD(aFunc,{SRA->RA_MAT})
									EndIf
									Exit//Volta ao loop da SRA
								EndIf
								dbSelectArea("TN6")
								dbSkip()
								Loop
							End
						EndIf
						dbSelectArea("SRA")
						dbSkip()
						Loop
					End
				EndIf
				dbSelectArea("TN0")
				dbSkip()
				Loop
			End
			nFunc := Len(aFunc)
		EndIf
	EndIf

Return nFunc

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpExaRis
Imprime exames relacionados ao risco

@type function
@source MDTR850.prx
@author Roger Rodrigues
@since 12/05/2010

@param cRisco, Caracter , Número do risco utilizado.

@sample fImpExaRis("Risco01")

@return Lógico, Retorna sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function fImpExaRis(cRisco)

	Local lFirst := .T.
	Local nInd := 1, cCond := "TN2->TN2_FILIAL+TN2->TN2_NUMRIS"
	Local cSeek := cRisco
	Local cImpRisco := "" //Recebe os riscos que serão impressos
	Local nCntLin   := 0
	Local nSpace 	:= 0

	//Se prestador altera indices
	If lSigaMdtps
		nInd := 5
		cSeek := cCliMdtps+cRisco
		cCond := "TN2->TN2_FILIAL+TN2->TN2_CLIENT+TN2->TN2_LOJA+TN2->TN2_NUMRIS"
	EndIf
	//Percorre todos exames relacionados ao risco
	dbSelectArea("TN2")
	dbSetOrder(nInd)
	MsSeek( xFilial( "TN2", cFil ) + cSeek )
	While !Eof() .And. xFilial( "TN2", cFil )+cSeek == &(cCond)
		//Imprime cabecalho se primeira vez
		If lFirst
			If nModeloImp == 2
				Somalinha()
				@ Li,005 Psay STR0328 //"Exames Relacionados ao Risco:"
				Somalinha()
				@ Li,005 Psay STR0095 //"Código"
				@ Li,036 Psay STR0331 //"Descrição"
				Somalinha()
			Elseif nModeloImp == 3
				Somalinha()
				oPrintPPRA:Say(lin,200,STR0329,oFont10b) //"Exames Relacionados ao Risco:"
				Somalinha()
				oPrintPPRA:Say(lin,200,STR0095,oFont10b) //"Código"
				oPrintPPRA:Say(lin,850,STR0331,oFont10b) //"Descrição"
				Somalinha()
			ElseIf nModeloImp == 1
				cImpRisco := STR0329 + "#*" + "" + "#*" //"Exames Relacionados ao Risco:"
				nCntLin := 1

				cImpRisco += STR0095 + CHR(9)+ CHR(9) + CHR(9) + STR0096 + "#*" + "" + "#*" //"Código"###"Nome"
				nCntLin++
			EndIf
			lFirst := .F.
		EndIf

		dbSelectArea("TM4")
		dbSetOrder( 1 )
		MsSeek(xFilial("TM4", cFil)+TN2->TN2_EXAME)
		If nModeloImp == 2
			@ Li,005 Psay AllTrim(TN2->TN2_EXAME)
			@ Li,036 Psay SubStr(AllTrim(TM4->TM4_NOMEXA),1,40)
			Somalinha()
		ElseIf nModeloImp == 3
			oPrintPPRA:Say(lin,200,AllTrim(TN2->TN2_EXAME),oFont10)
			oPrintPPRA:Say(lin,850,SubStr(AllTrim(TM4->TM4_NOMEXA),1,40),oFont10)
			Somalinha()
		ElseIf nModeloImp == 1
			i := 18
			cChr := ""
			While i > 0
				If Len(AllTrim(TN2->TN2_EXAME)) >= (i-6) .And. Len(AllTrim(TN2->TN2_EXAME)) <= (i)
					cChr += CHR(9)
					Exit
				Else
					cChr += CHR(9)
				EndIf
				i -= 6
			End
			nSpace := 19 - Len(AllTrim(TN2->TN2_EXAME))
			cImpRisco += "" + "#*" + AllTrim(TN2->TN2_EXAME) + Capital( cChr + AllTrim(TM4->TM4_NOMEXA) ) + "#*" //"Código"###"Nome"
			nCntLin++
		EndIf

		dbSelectArea("TN2")
		dbSkip()
	End

	If nModeloImp == 1 .And. nCntLin > 0 //Caso seja impressão em Word.
		OLE_SetDocumentVar(oWord,"Tabela",cImpRisco) //Contem o valor que será impresso.
		OLE_SetDocumentVar(oWord,"Linhas",nCntLin) //Quantidade de linhas que será impressa.
		OLE_ExecuteMacro(oWord,"Imp_Word") //Chama macro de impressão.
	EndIf

	If !lFirst
		If nModeloImp <> 1
			Somalinha()
			Somalinha()
		ElseIf nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
		lPula := .T.
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpEpiRis
Imprime EPI's relacionados ao risco

@param cRisco - Número do risco utilizado.

@sample fImpEpiRis("Risco01")

@return Lógico, Retorna sempre verdadeiro

@author Roger Rodrigues
@since 12/05/2010
/*/
//---------------------------------------------------------------------
Static Function fImpEpiRis(cRisco)

	Local i:=0, nX, cChr := ""
	Local aEPI := {}
	Local cImpRisco := ""
	Local nCntLin := 0

	//Carrega vetor com todos EPI
	fBuscaEPI(cRisco,@aEPI)

	//Imprime cabecalho se haver EPI
	If Len(aEPI) > 0

		If nModeloImp == 2
			Somalinha()
			@ Li,005 Psay STR0330 //"EPI's Relacionados ao Risco:"
			Somalinha()
			@ Li,005 Psay STR0095 //"Código"
			@ Li,036 Psay STR0331 //"Descrição"
			Somalinha()
		Elseif nModeloImp == 3
			Somalinha()
			oPrintPPRA:Say(lin,200,STR0330,oFont10b)//"EPI's Relacionados ao Risco:"
			Somalinha()
			oPrintPPRA:Say(lin,200,STR0332,oFont10b) //"Código"
			oPrintPPRA:Say(lin,850,STR0331,oFont10b) //"Descrição"
			Somalinha()
		ElseIf nModeloImp == 1
			cImpRisco := STR0330 + "#*" + "" + "#*" //"EPI's Relacionados ao Risco:"
			nCntLin := 1

			cImpRisco += STR0095 + CHR(9)+CHR(9)+CHR(9)+CHR(9)+CHR(9) + STR0331 + "#*" + "" + "#*" //"Código"###"Descrição"
			nCntLin++
		EndIf

	EndIf

	For nX := 1 To Len(aEPI)
		//Verifica se ainda existe na SB1
		dbSelectArea("SB1")
		dbSetOrder( 1 )
		If MsSeek(xFilial("SB1", cFil)+aEPI[nx])
			If nModeloImp == 2
				@ Li,005 Psay AllTrim(aEPI[nx])
				@ Li,036 Psay Substr(AllTrim(SB1->B1_DESC),1,30)
				Somalinha()
			ElseIf nModeloImp == 3
				oPrintPPRA:Say(lin,200,AllTrim(aEPI[nx]),oFont10)
				oPrintPPRA:Say(lin,850,Substr(AllTrim(SB1->B1_DESC),1,30),oFont10)
				Somalinha()
			ElseIf nModeloImp == 1
				i:=30
				cChr:=""
				While i > 0
					If Len(AllTrim(aEPI[nx])) >= (i-6) .And. Len(AllTrim(aEPI[nx])) <= (i)
						cChr += CHR(9)
						Exit
					Else
						cChr += CHR(9)
					EndIf
					i -= 6
				End
				cImpRisco += "" + "#*" +aEPI[nx] + Capital(cChr+Substr(AllTrim(SB1->B1_DESC),1,30)) + "#*"
				nCntLin++
			EndIf
		EndIf

	Next nX

	If nModeloImp == 1 .And. Len(aEPI) > 0 //Caso seja modelo Word realiza a impressão.
		OLE_SetDocumentVar(oWord,"Tabela",cImpRisco) //Valor que será impresso.
		OLE_SetDocumentVar(oWord,"Linhas",nCntLin) // Quantidade de linhas que será impressa.
		OLE_ExecuteMacro(oWord,"Imp_Word") //Chama a macro de impressão.
		//Pula para a próxima linha.
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850TAREFA
Imprime listagem de tarefas

@author  Roger Rodrigues
@since   13/05/2010
@return  Lógico, Sempre Verdadeio
/*/
//-------------------------------------------------------------------
Static Function A850TAREFA()

	Local nx,i,cCampo := "", lImp := .F.
	Local lGrava   := .T.
	Local nCols    := 0
	Local nIndTO1  := 1, cCondTO1 := "TO1->TO1_FILIAL+TO1->TO1_LAUDO"
	Local cCondTN5 := "TN5->TN5_FILIAL", cSeek := "", nIndTN5 := 1
	Local nIndTN6  := 1, cSeekTN6 := "",cCondTN6 := "TN6->TN6_FILIAL+TN6->TN6_CODTAR"
	Local cSeekTO1 := cCodLaudo
	Local nIndTN0  := 1
	Local aTarefas := {}

	If nModeloImp == 2
		nCols := 19
	ElseIf nModeloImp == 3
		nCols := 340
	EndIf

	//Se prestador altera indices
	If lSigaMdtps
		cSeek    := cCliMdtps
		cSeekTO1 := mv_par03
		nIndTN5  := 3
		cCondTN5 := "TN5->TN5_FILIAL+TN5->TN5_CLIENT+TN5->TN5_LOJA"
		nIndTN6  := 3
		cCondTN6 := "TN6->TN6_FILIAL+TN6->TN6_CLIENT+TN6->TN6_LOJA+TN6->TN6_CODTAR"
		nIndTO1  := 3
		cCondTO1 := "TO1->TO1_FILIAL+TO1->TO1_CLIENT+TO1->TO1_LOJA+TO1->TO1_LAUDO"
		nIndTN0  := 8
	EndIf

	dbSelectarea("TN5")
	dbSetOrder(nIndTN5)
	MsSeek(xFilial("TN5", cFil)+cSeek)
	While !EOF() .And. xFilial("TN5", cFil)+cSeek == &(cCondTN5)

		dbSelectArea("TO1")
		dbSetOrder(nIndTO1)
		MsSeek(xFilial("TO1", cFil) + cSeek + cSeekTO1)
		While !Eof() .And. xFilial("TO1", cFil) + cSeek + cSeekTO1 == &(cCondTO1)

			dbSelectArea("TN0")
			dbSetOrder(nIndTN0)
			//Valida se o Mapa Risco é diferente de CIPA
			//E se o Risco pertence ao(s) Centro(s) de Custo especificado(s) nos parâmetros
			//### Autor: Jackson Machado ### Data: 10/02/2011
			If MsSeek(xFilial("TN0", cFil) + cSeek + TO1->TO1_NUMRIS) .And. TN0->TN0_MAPRIS != "1".And. ;
			   ((TN0->TN0_CC >= IIf(nModeloImp == 1, mv_par11, mv_par09) .And. TN0->TN0_CC <= IIf(nModeloImp == 1, mv_par12, mv_par10)) .Or. AllTrim(TN0->TN0_CC) == "*")

				If lImpTodos .Or. AllTrim(TN0->TN0_CODTAR) == "*" .Or. TN5->TN5_CODTAR == TN0->TN0_CODTAR

					dbSelectArea("TN6")
					dbSetOrder(nIndTN6)
					MsSeek(xFilial("TN6", cFil)+cSeek+TN5->TN5_CODTAR)
					While !Eof() .And. xFilial("TN6", cFil)+cSeek+TN5->TN5_CODTAR == &(cCondTN6)
						If TN6->TN6_DTINIC <= dDatabase .And. (TN6->TN6_DTTERM >= dDatabase .Or. Empty(TN6->TN6_DTTERM))
							lGrava := .T.
							If !lImpTodos .And. AllTrim(TN0->TN0_CODTAR) == "*"//Se for somente Exposto ao Risco verifica
								lGrava := .F.
								dbSelectArea("SRA")
								dbSetOrder( 1 )
								If MsSeek(xFilial("SRA", cFil)+TN6->TN6_MAT)
									//Verifica se Func. esta no mesmo C.C./Funcao/Depto do Risco
									If (AllTrim(TN0->TN0_CC) == "*" .Or. SRA->RA_CC == TN0->TN0_CC) .Or.;
										(AllTrim(TN0->TN0_CODFUN) == "*" .Or. SRA->RA_CODFUNC == TN0->TN0_CODFUN) .Or.;
										(AllTrim(TN0->TN0_DEPTO) == "*" .Or. SRA->RA_DEPTO == TN0->TN0_DEPTO)
											lGrava := .T.
									EndIf
								EndIf
							EndIf
							If lGrava
								If aScan(aTarefas,{|x| x[1] == TN5->TN5_CODTAR}) == 0
									aAdd(aTarefas,{TN5->TN5_CODTAR, SubStr(TN5->TN5_NOMTAR,1,40),;
														TN5->TN5_DESTAR,;
														TN5->TN5_DESCR1,;
														TN5->TN5_DESCR2,;
														TN5->TN5_DESCR3,;
														TN5->TN5_DESCR4,;
														TN5->TN5_DESCRI})
								EndIf
								Exit//Volta ao loop da SRA
							EndIf
						EndIf
						dbSelectArea("TN6")
						dbSkip()
					End
				EndIf
			EndIf

			dbSelectArea("TO1")
			dbSkip()
			Loop
		End

		dbSelectArea("TN5")
		dbSkip()
		Loop
	End

	For i:=1 To Len(aTarefas)
		lImp 		:= .F.
		lIdentar := .F.
		U_IMPHEA850("{NS}"+AllTrim(aTarefas[i][2]))
		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
		EndIf
		For nX := 3 To Len(aTarefas[i])
			If !Empty(aTarefas[i][nX])
				If !lImp
					U_IMPDOC850(STR0333+If(nModeloImp == 1,CHR(9),"")+AllTrim(aTarefas[i][nX])) //"Objetivo da Tarefa:"
					lImp := .T.
				Else
					U_IMPDOC850(If(nModeloImp == 1,CHR(9)+CHR(9)+CHR(9),"")+AllTrim(aTarefas[i][nX]),,,,nCols)
				EndIf
				If nModeloImp == 1
					OLE_ExecuteMacro(oWord,"Somalinha")
				EndIf
			EndIf
		Next nX

		If nModeloImp == 1
			OLE_ExecuteMacro(oWord,"Somalinha")
		Else
			Somalinha()
		EndIf
	Next i

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} A850RISEPC
Imprime EPCs relacionados aos riscos no laudo

@author  Microsiga
@since   08/02/2010
@return  Lógico, Sempre Verdadeio
/*/
//-------------------------------------------------------------------
User Function A850RISEPC() //Laudo: mv_par03 - PS, cCodLaudo - Padrao

	Local nRisc, nEPC, nDetal, nPos
	Local cUtilEPC	:= SuperGetMv("MV_NG2UEPC",.F.,"1")//Indica a consistencia dos EPC, por: 1=Bens; 2 = Medidas de Controle; 3 - Ambos;
	Local lTemLaudo	:= .F.
	Local aRisc := {}
	Local aEPC 	:= {}
	Local aDetalBem	:= {}
	Local aDetalMedC:= {}

	aEPC := {}
	nPos := 0

	dbSelectArea("TO0")
	If lSigaMdtps
		dbSetOrder(6)  //TO0_FILIAL+TO0_CLIENT+TO0_LOJA+TO0_LAUDO
		If MsSeek(xFilial("TO0")+cCliMdtPs+Mv_par03)
			lTemLaudo := .T.
		Endif
	Else
		dbSetOrder( 1 )
		If MsSeek( xFilial( "TO0", cFil ) + cCodLaudo )
			lTemLaudo := .T.
		EndIf
	EndIf

	If lTemLaudo
		dbSelectArea("TO1")
		If lSigaMdtps
			dbSetOrder(3)
			MsSeek(xFilial("TO1") + cCliMdtPs + TO0->TO0_LAUDO)
		Else
			dbSetOrder( 1 )
			MsSeek( xFilial( "TO1", cFil ) + TO0->TO0_LAUDO )
		EndIf
		While !Eof() .And. xFilial( "TO1", cFil ) + TO0->TO0_LAUDO == TO1->TO1_FILIAL + TO1->TO1_LAUDO .And. ;
			IIf( lSigaMdtps, cCliMdtPs == TO1->TO1_CLIENT + TO1->TO1_LOJA, .T. )

			AADD(aRisc,TO1->TO1_NUMRISC)
			dbSelectArea("TO1")
			dbSkip()
		End

		If Len(aRisc) > 0

			dbSelectArea("TO9")
			If lSigaMdtps
				dbSetOrder(2)
			Else
				dbSetOrder( 1 )
			EndIf

			For nRisc := 1 To Len(aRisc)
				If lSigaMdtps
					MsSeek(xFilial("TO9")+ cCliMdtPs + aRisc[nRisc])
				Else
					MsSeek( xFilial( "TO9", cFil ) + aRisc[nRisc] )
				EndIf
				While !Eof() .And. aRisc[nRisc] == TO9->TO9_NUMRIS .And. ;
					If( lSigaMdtps , cCliMdtPs == TO9->TO9_CLIENT+TO9->TO9_LOJA , .T. )

					nPos := aSCAN( aEPC, { |x| AllTrim( Upper(x) ) == AllTrim(TO9->TO9_EPC)})
					If nPos == 0
						AADD(aEPC,TO9->TO9_EPC)
					EndIf
					dbSelectArea("TO9")
					dbSkip()
				End
			Next nRisc

			For nEPC := 1 To Len(aEPC)
				If cUtilEPC <> "2" // Se for 2 - Medidas de Controle, não pega Valores
					dbSelectArea("ST9")
					dbSetOrder( 1 )
					If MsSeek( xFilial( "ST9", cFil ) + aEPC[nEPC] )
						While !EOF() .And. aEPC[nEPC] == ST9->T9_CODBEM
							AADD(aDetalBem,{ST9->T9_NOME,ST9->T9_DESCRIC})
								dbSelectArea("ST9")
								dbSkip()
							End
					EndIf
				EndIf

				If cUtilEPC <> "1"
					dbSelectArea("TO4")
					dbSetOrder( 1 )
					If MsSeek( xFilial( "TO4", cFil ) + aEPC[nEPC] )
						While !Eof() .And. Alltrim(aEPC[nEPC]) == Alltrim(TO4->TO4_CONTRO)
							AADD(aDetalMedC,{TO4->TO4_NOMCTR, TO4->TO4_DESCRI})
							dbSelectArea("TO4")
							dbSkip()
						End
					EndIf
				EndIf
			Next nEPC

			U_IMPHEA850("{N}EPCs")
			aDetalBem := ASort( aDetalBem,,, {|x,y| x[1] < y[1] } )
			For nDetal := 1 To Len(aDetalBem)
				U_IMPHEA850("{N} - "+AllTrim(aDetalBem[nDetal][1])+" : ")
				If !Empty(aDetalBem[nDetal][2])
					U_IMPDOC850(AllTrim(aDetalBem[nDetal][2]),,,,,If(nModeloImp == 3,60,))
				EndIf
			Next nDetal

			aDetalMedC := ASort( aDetalMedC,,, {|x,y| x[1] < y[1] } )
			For nDetal := 1 To Len(aDetalMedC)
				U_IMPHEA850("{N} - "+AllTrim(aDetalMedC[nDetal][1])+" : ")
				If !Empty(aDetalMedC[nDetal][2])
					U_IMPDOC850(AllTrim(aDetalMedC[nDetal][2]),,,,,If(nModeloImp == 3,60,))
				EndIf
			Next nDetal
		EndIf
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} A850ANXIV
Imprime inventário de químicos.

@author  Hugo R. Pereira
@since   07/01/2013
@version MP10
@return  Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850ANXIV()

	Local nField, nLin, nLinVal

	Local lSigaMdtPs := GetNewPar("MV_MDTPS","N") == "S"
	Local cKeyPsq    := IIf( lSigaMdtPs, cCliMdtPs, "" )
	Local nOrdPsq    := IIf( lSigaMdtPs, 2, 1 )
	Local cWhlPsq    := IIf( lSigaMdtPs, "TJB->TJB_FILIAL+TJB_CLIENT+TJB_LOJA", "TJB->TJB_FILIAL" )
	Local cTitle     := STR0389 // "Inventário de Produtos Químicos"
	Local lFirstAnx  := .T.
	Local cVarTxt    := ""
	Local xValAux    := ""
	Local aAreaTO1   := {}
	Local aAreaTJC   := {}
	Local aAreaSX3	 := {}
	Local aCodProd	 := {} //Guarda os códigos dos produtos já impressos para não have repetição.
	Local aEstPQ     := { 	{ STR0384, "NGSEEK('SB1',TJB->TJB_CODPRO,1,'B1_DESC')"							},; // "Nome do Produto"
							{ STR0385, "TJB->TJB_PRCATI"													},; // "Princípio Ativo"
							{ STR0386, "TJB->TJB_LOCAL"														},; // "Local de Uso"
							{ STR0387, "AllTrim(Transform(TJB->TJB_CONSUMO,PesqPict('TJB','TJB_CONSUMO')))"	},; // "Consumo Anual"
							{ STR0388, "TJB->TJB_ESTOCA"													} } // "Estoque"


	aAreaSX3 := SX3->( GetArea() )
	dbSelectArea("SX3")
	dbSetOrder(2)
	If MsSeek( "TJB_PRCSYP" )
		aEstPQ[2][2] := "MSMM( TJB->TJB_PRCSYP , 10 )"
		aEstPQ[3][2] := "MSMM( TJB->TJB_LOCSYP , 10 )"
		aEstPQ[5][2] := "MSMM( TJB->TJB_ESTSYP , 10 )"
	EndIf
	RestArea(aAreaSX3)

	dbSelectArea("TO1")//Posiciona Laudos x Riscos
	dbSetOrder( 1 )
	MsSeek( xFilial( "TO0", cFil ) + TO0->TO0_LAUDO )

	While TO1->(!Eof()) .And. TO1->TO1_LAUDO == TO0->TO0_LAUDO//Verificar todos os Riscos relacionados ao Laudo

		aAreaTO1 := TO1->(GetArea())
		dbSelectArea("TN0")//Posiciona no Risco
		dbSetOrder( 1 )
		MsSeek( xFilial( "TO1", cFil ) + TO1->TO1_NUMRIS )

		dbSelectArea("TJC")//Posiciona na Tabela de Agente por Produtos Quimicos.
		dbSetOrder( 1 )

		If MsSeek( xFilial( "TN0", cFil ) + TN0->TN0_AGENTE )

			While TJC->(!Eof()) .And. xFilial( "TJC", cFil ) == TJC->TJC_FILIAL .And. TN0->TN0_AGENTE == TJC->TJC_AGENTE

				aAreaTJC := TJC->(GetArea())
				dbSelectArea("TJB")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TJB", cFil ) + TJC->TJC_CODPRO)

				If aScan( aCodProd , { | x | x == TJC->TJC_CODPRO } ) == 0 //Se o produto químico ainda não foi impresso

					aAdd( aCodProd, TJC->TJC_CODPRO )

					If lFirstAnx // Titulo Anexo IV

						If nModeloImp == 2 // Modelo Padrao
							@ Li,001 Psay cTitle
							SomaLinha()

						ElseIf nModeloImp == 3 // Modelo Grafico
							oPrintPPRA:Say(lin+10,150,cTitle,oFont10)
							SomaLinha()

						ElseIf nModeloImp == 1 // Modelo Word
							OLE_ExecuteMacro(oWord,"Somalinha")

							cVar1 := "cTXT" + StrZero(nVar1,6)
							OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
							nVar1++
							OLE_ExecuteMacro(oWord,"Cria_Texto")

							OLE_SetDocumentVar(oWord,cVar1,cTitle)
							OLE_ExecuteMacro(oWord,"Somalinha")
						EndIf

						lFirstAnx := .F.
					EndIf

					cVarTxt := ""

					// Imprime/Define campos da estrutura pre-definida
					For nField := 1 To Len(aEstPQ)

						xValAux := AllTrim( &( aEstPQ[nField][2] ) )
						xValAux := If(Empty(xValAux), Space(1), xValAux)

						If nModeloImp == 1 // Word

							cVarTxt += aEstPQ[nField][1] + ":" + "#*"	// Concatena nome do campo a ser impresso com tag '#*'
							cVarTxt += xValAux + "#*" + "##" 			// Conteudo do campo, mais tag '#*', e tag '##' como fim do registro

						ElseIf Str(nModeloImp,1) $ '2/3' // Padrao

							SomaLinha()

							If ValType(xValAux) == "C"
								nLinVal := MlCount(xValAux,55)
							EndIf

							If nModeloImp == 2 // Padrao

								@ Li,005 Psay aEstPQ[nField][1] + ":" // Nome do Campo

							ElseIf nModeloImp == 3 // Grafico

								If nField == 1 // Se for o primeiro campo, define box de inicio
									oPrintPPRA:Box(lin,150,lin+60,2300)
								EndIf

								oPrintPPRA:Say(lin+10,200,aEstPQ[nField][1] + ":",oFont10b) // Nome do Campo
							EndIf

							If ValType(xValAux) == "C"

								For nLin := 1 To nLinVal

									If(nLin != 1,SomaLinha(),)

									If nModeloImp == 2
										@ Li,023 Psay MemoLine(xValAux,55,nLin)
									Else
										AnxColGrf( {150, 600, 2300}, nLin == nLinVal )
										oPrintPPRA:Say(lin+10,650,MemoLine(xValAux,55,nLin),oFont10)
									EndIf

								Next nLinVal

							Else

								If nModeloImp == 2
									@ Li,023 Psay xValAux
								Else
									AnxColGrf( {150, 600, 2300}, .T. )
									oPrintPPRA:Say(lin+10,650,xValAux,oFont10)
								EndIf

							EndIf

						EndIf

					Next nField

					If nModeloImp == 1 // Word
						OLE_ExecuteMacro(oWord,"Somalinha")
						OLE_SetDocumentVar(oWord,"Tabela", cVarTxt)     // Define estrutura de campos a ser impressa
						OLE_SetDocumentVar(oWord,"Linhas", Len(aEstPQ)) // Quantidade de linhas/campos

						OLE_ExecuteMacro(oWord,"Table_AnexoIV") // Imprime registro, em tabela, do produto quimico
						OLE_ExecuteMacro(oWord,"Somalinha")
					Else // Padrao e Grafico
						SomaLinha()
					EndIf

				EndIf

				RestArea( aAreaTJC )
				TJC->(dbSkip())

			EndDo
		EndIf

		RestArea( aAreaTO1 )
		TO1->(dbSkip())

	EndDo

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} AnxColLin
Impressao de coluna para modelo grafico.

@author Hugo R. Pereira
@since  29/01/2013

@param  aColGrf, Array, Array com as informações a serem impressas
@param  lEndLine, Lógico, Se é linha final

@version MP10
@return  Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function AnxColGrf(aColGrf, lEndLine)

	Default lEndLine := .F.

	oPrintPPRA:Line(lin,aColGrf[1],lin+60,aColGrf[1]) // Coluna Inicial
	oPrintPPRA:Line(lin,aColGrf[2],lin+60,aColGrf[2]) // Coluna Separacao
	oPrintPPRA:Line(lin,aColGrf[3],lin+60,aColGrf[3]) // Coluna Final

	If lEndLine
		oPrintPPRA:Line(lin+60,aColGrf[1],lin+60,aColGrf[3]) // Linha Final
	EndIf

Return Nil

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

//-------------------------------------------------------------------
/*/{Protheus.doc} R850FUNC
Busca Funcionarios afastados e transferidos

@author  Pedro C. Furst
@since   07/12/2011
@return  lRet, return_type, Verdadeiro se o funcionário foi
transferido ou afastado.
/*/
//-------------------------------------------------------------------
Static Function R850FUNC()

	Local lAfast := .F.
	Local lRet   := .T.

	lAfast := MDTChkSR8( "SR8" , 1 ,;//Na Ver12 alterar verificação para MDTChkSR8
														xFilial("SR8", cFil)+SRA->RA_MAT,;
														"xFilial('SR8', cFil)+SRA->RA_MAT == SR8->R8_FILIAL+SR8->R8_MAT" ,;
														TO0->TO0_DTINIC ,;
														dAteLaudo )
	If lAfast
		lRet   := .F.
	EndIf
	//Transferidos/Demitidos antes da vigência
	If SRA->RA_SITFOLH $ "T/D" .And. !Empty(SRA->RA_DEMISSA)
		If SRA->RA_DEMISSA <= TO0->TO0_DTINIC
			lRet   := .F.
		EndIf
	EndIf
	If SRA->RA_ADMISSA > dAteLaudo
		lRet   := .F.
	EndIf
	If (SRA->RA_SITFOLH == "D" .And. SRA->RA_DEMISSA <= dAteLaudo) .Or. (!Empty(SRA->RA_DEMISSA) .And. SRA->RA_DEMISSA <= dAteLaudo)
		lRet   := .F.
	EndIf
	If SRA->RA_CATFUNC $ cFiltroF //Indica as Categorias Funcionais que nao aparecerao no PPRA
		lRet   := .F.
	EndIf
	If nModeloImp == 1
		If SRA->RA_CC < Mv_par11 .Or. SRA->RA_CC > Mv_par12
			lRet := .F.
		EndIf
	Else
		If SRA->RA_CC < Mv_par09 .Or. SRA->RA_CC > Mv_par10
			lRet := .F.
		EndIf
	EndIf
Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} fTipoINSC
Busca o tipo de incrição e formata o número da inscrição de acordo.

@author  Rodrigo Soledade
@since   28/12/2011
@return  { cTipoInsc , cCNPJ }, Array, Tipo da inscrição e número
formatado
/*/
//-------------------------------------------------------------------
User Function fTipoINSC()

	Local cCNPJ := ""
	Local cTipoInsc := ""

		If !Empty(SM0->M0_CGC)
			If SM0->M0_TPINSC != 2
				cCNPJ := Transform(SM0->M0_CGC,"@R 99.999.99999/99")
				cTipoInsc := STR0360 //"C.G.C. : "
			Else
				cCNPJ := Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99")//CNPJ
				cTipoInsc := STR0359 //"CNPJ :"
			EndIf
		Else
			cTipoInsc := STR0360 //"C.G.C. : "
		EndIf

Return { cTipoInsc , cCNPJ }

//-------------------------------------------------------------------
/*/{Protheus.doc} A850IMAGEM
Funcao para inserir imagem no doc

@author  Denis Hyroshi de Souza
@since   04/08/2001
@param   cTitTemp, Caractere, título da imagem

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function A850IMAGEM(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
		Return
	EndIf

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

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} A850IMAGEM
Funcao para inserir documentos no doc

@author  Denis Hyroshi de Souza
@since   04/08/2001
@param   cTitTemp, Caractere, título do documento

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function A850ARQUIVO(cTitTemp)

	Local cFileArq := "", nPos
	Local cBarraSrv := "\"

	If nModeloImp != 1 //Se nao for em formato WORD, nao imprime
		Return
	EndIf

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

//---------------------------------------------------------------------
/*/{Protheus.doc} A850AGENT
Funcao que imprime em Relatorio o Quadro de Agentes(TMA).

Foi adicionado um novo Atalho (Quadro de Agentes) na rotina, MDTA210a.prx
para impressao no PPRA e PGR.

Quando este atalho for incluido no Laudo, serao impressos os quadros conforme
modelos abaixo:

	  nModeloImp == 1 -> MODELO WORD
	  nModeloImp == 2 -> MODELO PADRAO
	  nModeloImp == 3 -> MODELO GRAFICO

@author  Elynton Fellipe Bazzo
@since   23/01/2013
@version P10/P11

@return  Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850AGENT()

	Local aArea     := GetArea()
	Local cMemo     := ""
	Local cTitulo	:= ''
	Local nMarEsq	:= 150 // Margem esquerda mínima
	Local nMarDir	:= 2300 // Margem direita máxima
    Local nImpVal	:= 0 // Variável para posicionar o registro no meio da linha

	Local cAliasRis1 := GetNextAlias()
	Local cAliasRis2 := GetNextAlias()	
	Local cDescProd := ""

	// Impressao do Quadro de Agentes
	If nModeloImp == 1 // Modelo de impressao .doc
		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro  ( oWord , "Somalinha"   )
		OLE_ExecuteMacro  ( oWord , "Cria_Texto"  )
		OLE_SetDocumentVar( oWord , cVar1,STR0383 ) // "Quadro de Agentes:"
		OLE_ExecuteMacro  ( oWord , "Somalinha"   )
	ElseIf nModeloImp == 2 // Modelo de impressao Padrao
		Somalinha()
		@ Li,000 Psay STR0383 //"Quadro de Agentes:"
	ElseIf nModeloImp == 3 // Modelo de impressao Grafico
		Somalinha()
		Somalinha()
		oPrintPPRA:Say( lin, nMarEsq, STR0383, oFont12 ) // "Quadro de Agentes:"
		Somalinha()
		Somalinha()
	EndIf

	BeginSQL Alias cAliasRis1
		SELECT 
			TMA_AGENTE, TMA_NOMAGE, TMA_DESCRI, TMA_PROPAG, TMA_AVALIA, TMA_TIPADI,
			TMA_GRISCO,
			CASE 
				WHEN TMA_GRISCO = '1' THEN 'Físico'
				WHEN TMA_GRISCO = '4' THEN 'Ergonômico'
				WHEN TMA_GRISCO = '5' THEN 'Acidente'
				WHEN TMA_GRISCO = '6' THEN 'Mecânico'
				WHEN TMA_GRISCO = '7' THEN 'Perigosos'
				ELSE 'Psicossocial'
			END AS TMA_NOMGRP
		FROM
			%table:TMA% TMA
		WHERE TMA.TMA_FILIAL = %xFilial:TMA%
		  AND TMA.TMA_GRISCO IN ( '1', '4', '5', '6', '7', '8' )
	      AND TMA.%NotDel%
	EndSQL

	BeginSQL Alias cAliasRis2
		SELECT 
			TMA_AGENTE, TMA_NOMAGE, TMA_DESCRI, TMA_SUBATI, TMA_PROPAG, TMA_AVALIA,
			TMA_TIPADI, TMA_CLASSI, TMA_FONTES, TMA_ENTRAD, TMA_PATOGE, TMA_VIRULE,
			TMA_PERSIS,	TMA_ESTUDO, TMA_GRISCO
		FROM 
			%table:TMA% TMA
		WHERE TMA.TMA_FILIAL = %xFilial:TMA%
		  AND TMA.TMA_GRISCO IN ( '2', '3' )
		  AND TMA.%NotDel%
	EndSQL

	If nModeloImp == 1 // Impressão .doc

		dbSelectArea( cAliasRis1 )
		dbGoTop()

		// Impressão de Tabela de Agentes
		If !Empty( cAliasRis1 )

			cTitulo += "#" + STR0063 + "#"
			cTitulo += STR0174 + "#" 
			cTitulo += STR0377 + "#"
			cTitulo += STR0378 + "#"
			cTitulo += STR0379 + "#" 
			cTitulo += STR0380 + "#"

			OLE_SetDocumentVar( oWord , "Titulo_Quadro_de_Agentes", AllTrim( cTitulo ) )

			While ( cAliasRis1 )->( !Eof() )

				cMemo += AllTrim( ( cAliasRis1 )->TMA_AGENTE )                                              //Codigo Agente
				cMemo += "#*" + AllTrim( ( cAliasRis1 )->TMA_NOMAGE )                                      //Nome Agente
				cMemo += "#*" + AllTrim( Substr( Capital( ( cAliasRis1 )->TMA_DESCRI ), 1, 75 ) )          //Descricao
				cMemo += "#*" + AllTrim( ( cAliasRis1 )->TMA_PROPAG )                                      //Meio de Propagacao
				cMemo += "#*" + AllTrim( NGRETSX3BOX( "TMA_AVALIA" , ( cAliasRis1 )->TMA_AVALIA ) )        //Avalicao
				cMemo += "#*" + AllTrim( NGRETSX3BOX( "TMA_TIPADI" , ( cAliasRis1 )->TMA_TIPADI ) ) + "#*" //Adicional
				
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1	   )
				nVar1++

				If IsInCallStack( 'MDTR850' ) .And. ( cAliasRis1 )->TMA_GRISCO == '1'

					OLE_ExecuteMacro  ( oWord , "Somalinha"			  	   )
					OLE_ExecuteMacro  ( oWord , "Cria_Texto"			   )
					OLE_ExecuteMacro  ( oWord , "ativar_negrito"		   )
					OLE_SetDocumentVar( oWord , cVar1,STR0196			   ) // "Físico"
					OLE_ExecuteMacro  ( oWord , "Centralizar" 	           )
					OLE_ExecuteMacro  ( oWord , "Somalinha"			  	   ) // Pula Linha
					OLE_SetDocumentVar( oWord , "Tabela", AllTrim( cMemo ) )
					OLE_ExecuteMacro  ( oWord , "Table_AgentesFisicos"     ) // Cria tabela de agentes Físicos
					OLE_ExecuteMacro  ( oWord , "Somalinha"			       ) // Pula Linha

				ElseIf IsInCallStack( 'MDTR851' )

					OLE_ExecuteMacro  ( oWord , "Somalinha"			       )
					OLE_ExecuteMacro  ( oWord , "Cria_Texto"		       )
					OLE_ExecuteMacro  ( oWord , "ativar_negrito"	       )
					OLE_SetDocumentVar( oWord , cVar1, AllTrim( ( cAliasRis1 )->TMA_NOMGRP ) ) // "Agente cadastrado"
					OLE_ExecuteMacro  ( oWord , "Centralizar"              )
					OLE_ExecuteMacro  ( oWord , "Somalinha"			       )
					OLE_SetDocumentVar( oWord , "Tabela", AllTrim( cMemo ) )
					OLE_ExecuteMacro  ( oWord , "Table_AgentesMdt" 	       ) // Cria tabela de agentes
					OLE_ExecuteMacro  ( oWord , "Somalinha"			       )

				EndIf

				cMemo := ""
				( cAliasRis1 )->( DbSkip() )

			End

		EndIf

		dbSelectArea( cAliasRis2 )
		dbGoTop()

		// Impressão de Tabela de Agente Químico
		If !Empty( cAliasRis2 )
			While ( cAliasRis2 )->( !Eof() ) 
			
				If ( cAliasRis2 )->TMA_GRISCO == "2"

					cDescProd += fDescriProd( cAliasRis2, cDescProd ) 

					While ( cAliasRis2 )->TMA_GRISCO == "2"

						cMemo += AllTrim( ( cAliasRis2 )->TMA_AGENTE )                                      // Codigo Agente
						cMemo += "#*" + AllTrim( ( cAliasRis2 )->TMA_NOMAGE )                               // Nome Agente
						cMemo += "#*" + AllTrim( Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 75 ) )   // Descricao
						cMemo += "#*" + AllTrim( ( cAliasRis2 )->TMA_SUBATI )                               // Substancia Ativa
						cMemo += "#*" + AllTrim( ( cAliasRis2 )->TMA_PROPAG )                               // Meio de Propagacao
						cMemo += "#*" + AllTrim( NGRETSX3BOX( "TMA_AVALIA" , ( cAliasRis2 )->TMA_AVALIA ) ) // Avaliacao
						cMemo += "#*" + AllTrim( NGRETSX3BOX( "TMA_TIPADI" , ( cAliasRis2 )->TMA_TIPADI ) ) // Adicional
						cMemo += "#*" + AllTrim( cDescProd ) + "#*"                                         // Produto

						cVar1 := "cTXT"+Strzero(nVar1,6)
						OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
						nVar1++
						OLE_ExecuteMacro  ( oWord , "Somalinha"			  	   )
						OLE_ExecuteMacro  ( oWord , "Cria_Texto"			   )
						OLE_ExecuteMacro  ( oWord , "ativar_negrito"		   )
						OLE_SetDocumentVar( oWord , cVar1,STR0197			   ) // "Químico"
						OLE_ExecuteMacro  ( oWord , "Centralizar" )
						OLE_ExecuteMacro  ( oWord , "Somalinha"			  	   ) //Pula Linha
						OLE_SetDocumentVar( oWord , "Tabela", AllTrim( cMemo ) )
						OLE_ExecuteMacro  ( oWord , "Table_AgentesQuimicos"    ) // Cria tabela de agentes Quimicos
						OLE_ExecuteMacro  ( oWord , "Somalinha"			       ) //Pula Linha
						cMemo := ""
						
						( cAliasRis2 )->( DbSkip() )

					End

				ElseIf ( cAliasRis2 )->TMA_GRISCO == "3"

					While ( cAliasRis2 )->TMA_GRISCO == "3"

						cMemo += AllTrim( ( cAliasRis2 )->TMA_AGENTE )                                      //Codigo Agente
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_NOMAGE )                               //Nome Agente
						cMemo += "#*" +  AllTrim( Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 75 ) )   //Desricao
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_PROPAG )                               //Meio de propagacao
						cMemo += "#*" +  AllTrim( NGRETSX3BOX( "TMA_AVALIA" , ( cAliasRis2 )->TMA_AVALIA ) ) //Avaliacao
						cMemo += "#*" +  AllTrim( NGRETSX3BOX( "TMA_TIPADI" , ( cAliasRis2 )->TMA_TIPADI ) ) //Adicional
						cMemo += "#*" +  AllTrim( NGRETSX3BOX( "TMA_CLASSI" , ( cAliasRis2 )->TMA_CLASSI ) ) //Classificacao
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_FONTES )                               //Fontes de Exposição
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_ENTRAD )                               //Entrada
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_PATOGE )                               //patogenicidade
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_VIRULE )                               //Virulência
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_PERSIS )                               //Persistencia
						cMemo += "#*" +  AllTrim( ( cAliasRis2 )->TMA_ESTUDO ) + "#*"                        //Estudo

						cVar1 := "cTXT"+Strzero(nVar1,6)
						OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
						nVar1++
						OLE_ExecuteMacro  ( oWord , "Somalinha"				   )
						OLE_ExecuteMacro  ( oWord , "Cria_Texto"			   )
						OLE_ExecuteMacro  ( oWord , "ativar_negrito"		   )
						OLE_SetDocumentVar( oWord , cVar1,STR0198			   ) // "Biológico"
						OLE_ExecuteMacro  ( oWord , "Centralizar" )
						OLE_ExecuteMacro  ( oWord , "Somalinha"				   ) //Pula Linha
						OLE_SetDocumentVar( oWord , "Tabela", AllTrim( cMemo ) )
						OLE_ExecuteMacro  ( oWord , "Table_AgentesBiologicos"  ) // Cria tabela de agentes Biologicos
						OLE_ExecuteMacro  ( oWord , "Somalinha"				   ) //Pula Linha
						cMemo := ""

						( cAliasRis2 )->( DbSkip() )

					End

				EndIf
			End

		EndIf

	ElseIf nModeloImp == 2 // Impressão Modelo Padrao

		dbSelectArea( cAliasRis1 )
		dbGoTop()
		If !Empty( cAliasRis1 )
			While ( cAliasRis1 )->( !Eof() )
				SomaLinha()
				@ Li,019 Psay AllTrim( ( cAliasRis1 )->TMA_NOMGRP )
				Somalinha()
				@ Li,019 Psay STR0375 //"Cod. Agente:"
				@ Li,050 Psay Capital( ( cAliasRis1 )->TMA_AGENTE )
				SomaLinha()
				@ Li,019 Psay STR0376 //"Nome Agente:"
				@ Li,050 Psay Capital( ( cAliasRis1 )->TMA_NOMAGE )
				Somalinha()
				@ Li,019 Psay STR0377 //"Descrição:"
				@ Li,050 Psay Substr( Capital( ( cAliasRis1 )->TMA_DESCRI ), 1, 75 )
				SomaLinha()
				@ Li,019 Psay STR0378 //"Meio de Propagação:"
				@ Li,050 Psay Capital( ( cAliasRis1 )->TMA_PROPAG )
				SomaLinha()
				@ Li,019 Psay STR0379 //"Avaliação:"
				@ Li,050 Psay NGRETSX3BOX( "TMA_AVALIA", ( cAliasRis1 )->TMA_AVALIA )
				SomaLinha()
				@ Li,019 Psay STR0380 //"Adicional de:"
				@ Li,050 Psay NGRETSX3BOX( "TMA_TIPADI", ( cAliasRis1 )->TMA_TIPADI )
				Somalinha()
				( cAliasRis1 )->( DbSkip() )
			End
		EndIf


		dbSelectArea( cAliasRis2 )
		dbGoTop()

		// Impressão de Tabela de Agente Químico e Biológico
		If !Empty( cAliasRis2 )
			While ( cAliasRis2 )->( !Eof() )
				If ( cAliasRis2 )->TMA_GRISCO == "2"

					cDescProd += fDescriProd( cAliasRis2, cDescProd ) 

					While ( cAliasRis2 )->TMA_GRISCO == "2"
						SomaLinha()
						@ Li,019 Psay STR0371 //"Químico:"
						Somalinha()
						@ Li,019 Psay STR0375 //"Cod. Agente:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_AGENTE )
						SomaLinha()
						@ Li,019 Psay STR0376 //"Nome Agente:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_NOMAGE )
						Somalinha()
						@ Li,019 Psay STR0377 //"Descrição:"
						@ Li,050 Psay Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 75 )
						SomaLinha()
						@ Li,019 Psay STR0381 //"Substância Ativa:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_SUBATI )
						SomaLinha()
						@ Li,019 Psay STR0378 //"Meio de Propagação:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_PROPAG )
						SomaLinha()
						@ Li,019 Psay STR0379 //"Avaliação:"
						@ Li,050 Psay NGRETSX3BOX( "TMA_AVALIA",( cAliasRis2 )->TMA_AVALIA )
						SomaLinha()
						@ Li,019 Psay STR0380 //"Adicional de:"
						@ Li,050 Psay NGRETSX3BOX( "TMA_TIPADI",( cAliasRis2 )->TMA_TIPADI )
						Somalinha()
						//impressao da descrição
						@ Li,019 Psay STR0382 //"Nome Produto:"
						@ Li,050 Psay Capital( cDescProd )
						Somalinha()
						cDescProd := ""

						( cAliasRis2 )->( DbSkip() )
					End

				ElseIf ( cAliasRis2 )->TMA_GRISCO == "3"

					While ( cAliasRis2 )->TMA_GRISCO == "3"

						SomaLinha()
						@ Li,019 Psay STR0372 //"Biológicos:"
						Somalinha()
						@ Li,019 Psay STR0375 //"Cod. Agente:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_AGENTE )
						SomaLinha()
						@ Li,019 Psay STR0376 //"Nome Agente:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_NOMAGE )
						Somalinha()
						@ Li,019 Psay STR0377 //"Descrição:"
						@ Li,050 Psay Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 75 )
						SomaLinha()
						@ Li,019 Psay STR0378 //"Meio de Propagação:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_PROPAG )
						SomaLinha()
						@ Li,019 Psay STR0379 //"Avaliação:"
						@ Li,050 Psay NGRETSX3BOX( "TMA_AVALIA",( cAliasRis2 )->TMA_AVALIA )
						SomaLinha()
						@ Li,019 Psay STR0380 //"Adicional de:"
						@ Li,050 Psay NGRETSX3BOX( "TMA_TIPADI",( cAliasRis2 )->TMA_TIPADI )
						Somalinha()
						@ Li,019 Psay STR0367 //"Classificação:"
						@ Li,050 Psay NGRETSX3BOX( "TMA_CLASSI",( cAliasRis2 )->TMA_CLASSI )
						Somalinha()
						@ Li,019 Psay STR0368 //"Fontes Exposição:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_FONTES )
						Somalinha()
						@ Li,019 Psay STR0362 //"Entrada:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_ENTRAD )
						Somalinha()
						@ Li,019 Psay STR0363 //"Patogenicidade:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_PATOGE )
						Somalinha()
						@ Li,019 Psay STR0364 //"Virulência:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_VIRULE )
						Somalinha()
						@ Li,019 Psay STR0365 //"Persistência:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_PERSIS )
						Somalinha()
						@ Li,019 Psay STR0366 //"Estudos:"
						@ Li,050 Psay Capital( ( cAliasRis2 )->TMA_ESTUDO )
						Somalinha()

						( cAliasRis2 )->( DbSkip() )
					End
				EndIf
			End
		EndIf

	ElseIf nModeloImp == 3 // Impressão Modelo Gráfico

		// Impressão de Tabela de Agentes
		dbSelectArea( cAliasRis1 )
		dbGoTop()
		If !Empty( cAliasRis1 )
			While ( cAliasRis1 )->( !Eof() )
				oPrintPPRA:Say	( lin , nMarEsq , AllTrim( ( cAliasRis1 )->TMA_NOMGRP ), oFont10b ) // "Agente"
				Somalinha()
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600     , lin + 60 , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 300 	, STR0374  , oFont10b ) // "Campo"
				oPrintPPRA:Say  ( lin , 1250 	, STR0373  , oFont10b ) // "Conteudo"
				Somalinha()
				// "Cod. Agente:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 				     , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 				     , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0375 				     , oFont10b ) // "Cod. Agente:"
				oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis1 )->TMA_AGENTE ) , oFont10 ) // "Cod. Agente:"
				Somalinha()
				// "Nome Agente:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 				     , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 				     , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0376 				     , oFont10b ) // "Nome Agente:"
				oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis1 )->TMA_NOMAGE ) , oFont10 ) // "Nome Agente:"
				Somalinha()
				// "Descrição:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 				  				      , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 								      , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0377 								      , oFont10b ) // "Descrição:"
				oPrintPPRA:Say  ( lin , 620  	, Substr( Capital( ( cAliasRis1 )->TMA_DESCRI ), 1, 90 ) , oFont10 ) // "Descrição:"
				Somalinha()
				// "Meio de Propagação:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 		 		     , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 				     , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0378 				     , oFont10b ) // "Meio de Propagação:"
				oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis1 )->TMA_PROPAG ) , oFont10 ) // "Meio de Propagação:"
				Somalinha()
				// "Avaliação:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 									   , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 								       , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0379 									   , oFont10b ) // "Avaliação:"
				oPrintPPRA:Say  ( lin , 620  	, NGRETSX3BOX( "TMA_AVALIA", ( cAliasRis1 )->TMA_AVALIA ) , oFont10 ) // "Avaliação:"
				Somalinha()
				// "Adicional de:"
				oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 									   , nMarDir  ) // Monta tabela
				oPrintPPRA:line ( lin , 600  	, lin + 60 									   , 600      ) // Linha Vertical que separa os campos
				oPrintPPRA:Say  ( lin , 165  	, STR0380 									   , oFont10b ) // "Adicional de:"
				oPrintPPRA:Say  ( lin , 620  	, NGRETSX3BOX( "TMA_TIPADI", ( cAliasRis1 )->TMA_TIPADI ) , oFont10 ) // "Adicional de:"
				Somalinha()
				Somalinha()
				( cAliasRis1 )->( DbSkip() )
			End
		EndIf

		// Impressão de Tabela de Agente Químico e Biológico
		dbSelectArea( cAliasRis2 )
		dbGoTop()
		If !Empty( cAliasRis2 )
			While ( cAliasRis2 )->( !Eof() )
				If ( cAliasRis2 )->TMA_GRISCO == "2"

					cDescProd += fDescriProd( cAliasRis2, cDescProd )  

					While ( cAliasRis2 )->TMA_GRISCO == "2"

						oPrintPPRA:Say	( lin , nMarEsq , STR0371  , oFont10b ) // "Quimico:"
						Somalinha()
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 , nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60 , 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 300  	, STR0374  , oFont10b ) // "Campo"
						oPrintPPRA:Say  ( lin , 1250 	, STR0373  , oFont10b ) // "Conteudo"
						Somalinha()
						// "Cod. Agente:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0375 , oFont10b ) // "Cod. Agente:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_AGENTE ) , oFont10 ) // "Cod. Agente:"
						Somalinha()
						// "Nome Agente:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0376 , oFont10b ) // "Nome Agente:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_NOMAGE ) , oFont10 ) // "Nome Agente:"
						Somalinha()
						// "Descrição:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0377 , oFont10b ) // "Descrição:"
						oPrintPPRA:Say  ( lin , 620  	, Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 90 ) , oFont10 ) // "Descrição:"
						Somalinha()
						// "Substância Ativa:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0381 , oFont10b ) // "Substância Ativa:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_SUBATI ) , oFont10 ) // "Substância Ativa:"
						Somalinha()
						// "Meio de Propagação:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0378 , oFont10b ) // "Meio de Propagação:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_PROPAG ) , oFont10 ) // "Meio de Propagação:"
						Somalinha()
						// "Avaliação:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0379 , oFont10b ) // "Avaliação:"
						oPrintPPRA:Say  ( lin , 620  	, NGRETSX3BOX( "TMA_AVALIA", ( cAliasRis2 )->TMA_AVALIA ) , oFont10 ) // "Avaliação:"
						Somalinha()
						// "Adicional de:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0380 , oFont10b ) // "Adicional de:"
						oPrintPPRA:Say  ( lin , 620  	, NGRETSX3BOX( "TMA_TIPADI", ( cAliasRis2 )->TMA_TIPADI ) , oFont10  ) // "Adicional de:"
						Somalinha()

						//impressao da descrição
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 		 	   , nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60 			   , 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0382 			   , oFont10b ) // "Nome Produto:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( cDescProd ) , oFont10  ) // "Nome Produto:"
						Somalinha()
						SomaLinha()
						cDescProd := ""
						( cAliasRis2 )->( DbSkip() )
					End

				ElseIf ( cAliasRis2 )->TMA_GRISCO == "3"

					While ( cAliasRis2 )->TMA_GRISCO == "3"

						oPrintPPRA:Say  ( lin , nMarEsq , STR0372  , oFont10b ) // "Biologico:"
						Somalinha()
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60 , nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60 , 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 300  	, STR0374  , oFont10b ) // "Campo"
						oPrintPPRA:Say  ( lin , 1250 	, STR0373  , oFont10b ) // "Conteudo"
						Somalinha()
						// "Cod. Agente:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0375 , oFont10b ) // "Cod. Agente:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_AGENTE ) , oFont10 ) // "Cod. Agente:"
						Somalinha()
						// "Nome Agente:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165  	, STR0376, oFont10b  ) // "Nome Agente:"
						oPrintPPRA:Say  ( lin , 620  	, Capital( ( cAliasRis2 )->TMA_NOMAGE ) , oFont10 ) // "Nome Agente:"
						Somalinha()
						// "Descrição:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600  	, lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165 	, STR0377 , oFont10b ) // "Descrição:"
						oPrintPPRA:Say  ( lin , 620  	, Substr( Capital( ( cAliasRis2 )->TMA_DESCRI ), 1, 90 ) , oFont10 ) // "Descrição:"
						Somalinha()
						// "Meio de Propagação:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0378 , oFont10b ) // "Meio de Propagação:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_PROPAG ) , oFont10  ) // "Meio de Propagação:"
						Somalinha()
						// "Avaliação:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0379 , oFont10b ) // "Avaliação:"
						oPrintPPRA:Say  ( lin , 620     , NGRETSX3BOX( "TMA_AVALIA", ( cAliasRis2 )->TMA_AVALIA ) , oFont10 ) // "Avaliação:"
						Somalinha()
						// "Adicional de:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0380 , oFont10b ) // "Adicional de:"
						oPrintPPRA:Say  ( lin , 620     , NGRETSX3BOX( "TMA_TIPADI", ( cAliasRis2 )->TMA_TIPADI ) , oFont10 ) // "Adicional de:"
						Somalinha()
						// "Classificação:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0367 , oFont10b ) // "Classificação:"
						oPrintPPRA:Say  ( lin , 620     , NGRETSX3BOX( "TMA_CLASSI", ( cAliasRis2 )->TMA_CLASSI ) , oFont10 ) // "Classificação:"
						Somalinha()
						// "Fontes exposição:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0368 , oFont10b ) // "Fontes exposição:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_FONTES ) , oFont10 ) // "Fontes exposição:"
						Somalinha()
						// "Entrada:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0362 , oFont10b ) // "Entrada:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_ENTRAD ) , oFont10 ) // "Entrada:"
						Somalinha()
						// "Patogenicidade:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0363 , oFont10b ) // "Patogenicidade:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_PATOGE ) , oFont10 ) // "Patogenicidade:"
						Somalinha()
						// "Virulência:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0364 , oFont10b ) // "Virulência:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_VIRULE ) , oFont10 ) // "Virulência:"
						Somalinha()
						// "Persistência:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0365 , oFont10b ) // "Persistência:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_PERSIS ) , oFont10 ) // "Persistência:"
						Somalinha()
						// "Estudos:"
						oPrintPPRA:Box  ( lin , nMarEsq , lin + 60, nMarDir  ) // Monta tabela
						oPrintPPRA:line ( lin , 600     , lin + 60, 600      ) // Linha Vertical que separa os campos
						oPrintPPRA:Say  ( lin , 165     , STR0366 , oFont10b ) // "Estudos:"
						oPrintPPRA:Say  ( lin , 620     , Capital( ( cAliasRis2 )->TMA_ESTUDO ) , oFont10 ) // "Estudos:"
						Somalinha()
						Somalinha()
						( cAliasRis2 )->( DbSkip() )
					End
				EndIf
			End
		EndIf
	EndIf
	RestArea( aArea )
	( cAliasRis1 )->( dbCloseArea() )
	( cAliasRis2 )->( dbCloseArea() )

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} A850PEMERG
Funcao que imprime em Relatorio o Plano Emergencial

Foi adicionado um novo Atalho (PLANO EMERGENCIAL) na rotina, MDTA210a.prx
para impressao no PPRA e PGR

Quando este atalho for incluido no Laudo, serao impressos os quadros conforme
	  modelos abaixo:

	  nModeloImp == 1 -> MODELO WORD
	  nModeloImp == 2 -> MODELO PADRAO
	  nModeloImp == 3 -> MODELO GRAFICO

@author  Elynton Fellipe Bazzo
@since   15/02/2013
@version P10/P11

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------------------
Static Function A850PEMERG()

	Local aArea := GetArea()
	Local cMemo := ""
	Local nRegs := 0
	Local LinhaCorrente := 0
	Local aAreaTJG:={}

	//Impressao do título de Plano Emergencial
	If nModeloImp == 1 //Modelo de impressão .doc
		cVar1 := "cTXT"+Strzero(nVar1,6)
		OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
		nVar1++
		OLE_ExecuteMacro  (oWord , "Somalinha")
		OLE_ExecuteMacro  (oWord , "Cria_Texto")
		OLE_SetDocumentVar(oWord , cVar1,STR0409) // "PLANO EMERGENCIAL:"
		OLE_ExecuteMacro  (oWord , "Somalinha")
	ElseIf nModeloImp == 2 //Modelo de impressão padrão.
		@ Li,000 Psay STR0409 //"PLANO EMERGENCIAL:"
	SomaLinha()
	ElseIf nModeloImp == 3 //Modelo de impressão gráfico.
		SomaLinha()
		oPrintPPRA:Say(lin,165,STR0409,oFont10) //"PLANO EMERGENCIAL"
		SomaLinha()
	EndIf

	If nModeloImp == 1 //Modelo de impressão .doc
			dbSelectArea("TJG")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TJG", cFil ) + cCodLaudo )
			While TJG->(!Eof()) .And. TJG->TJG_LAUDO == cCodLaudo
				aAreaTJG := GetArea()//Salva Area
				dbSelectArea("TBB")
				dbSetOrder(01)
				dbGoTop()
				If MsSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
						nRegs := 0
						cMemo += "Plano Emergencial"+ "#*"+TBB->TBB_CODPLA+" - "+Capital(TBB->TBB_DESPLA)+"#*" //"Código" - "Descrição"
						nRegs ++

						If TBB->TBB_TIPELA == '1' // Usuário

							cMemo += "Elaborador"+"#*"  + Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) )+"#*" //"Elaborador:"
							nRegs ++

						Else // Funcionário

							cMemo += "Elaborador"+"#*"  + Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_ELABOR ), 1 ,"RA_NOME", cFil ) )+"#*" //"Elaborador:"
							nRegs ++

						EndIf

						If TBB->TBB_TIPRES == '1' // Usuário

							cMemo += "Responsável"+"#*" + Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) )+"#*" //"Responsável:"
							nRegs ++

						Else // Funcionário

							cMemo += "Responsável"+"#*" + Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_RESPON ), 1, "RA_NOME", cFil ) )+"#*" //"Responsável:"
							nRegs ++

						EndIf

						If !Empty(TBB->TBB_OBSPLA)
							cMemo += "Observações"+"#*" + Capital(TBB->TBB_OBSPLA)+"#*"//"Observações:"
							nRegs ++
						Else
							cMemo += "Observações"+"#*" + ""+"#*"//"Observações:"
							nRegs ++
						EndIf
						cMemo += "Processos"+"#*" + Capital(TAF->TAF_NOMNIV) + "#*" //"Processos:"
						nRegs ++

						dbSelectArea("TJS") // "Ações:"
						dbSetOrder( 1 ) //TJS_FILIAL+TJS_CODPLA+TJS_CODACA
						dbGoTop()
						MsSeek( xFilial( "TJS", cFil ) + TBB->TBB_CODPLA )
						// Percorre a Tabela TJS e imprime as acoes.
						While !Eof() .And. TJS->TJS_FILIAL == xFilial( "TJS", cFil ) .And. TJS->TJS_CODPLA == TBB->TBB_CODPLA
							nRegs ++
							cMemo += "Ações"+"#*"+Alltrim(TJS->TJS_CODACA)+" - "+Alltrim(TJS->TJS_DESACA)+"#*" //"Ações:"
							dbSelectArea("TJS")
							dbSkip()
						EndDo

						// Percorre a Tabela TJT e imprime os Participantes.
						dbSelectArea("TJT")
						dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
						dbGoTop()
						MsSeek( xFilial( "TJT", cFil ) + TBB->TBB_CODPLA )
						While !Eof() .And. TJT->TJT_FILIAL == xFilial( "TJT", cFil ) .And. TJT->TJT_CODPLA == TBB->TBB_CODPLA
							nRegs ++
							cMemo += "Participantes"+"#*"+Alltrim(TJT->TJT_CODPAR)+" - "+NGSEEK( "SRA", AllTrim( TJT->TJT_CODPAR ), 1, "RA_NOME", cFil )+"#*" //"Participantes:"
							dbSelectArea("TJT")
							dbSkip()
						EndDo

						// Percorre a Tabela TBU e imprime os Contatos Externos.
						dbSelectArea( 'TBU' )
						dbSetOrder( 1 )
						dbGoTop()

						If MsSeek( xFilial( 'TBU', cFil ) + TBB->TBB_CODPLA )

							While !Eof() .And. TBU->TBU_FILIAL == xFilial( 'TBU', cFil ) .And. TBU->TBU_CODPLA == TBB->TBB_CODPLA

								If !Empty( TBU->TBU_CODPLA )

									nRegs ++
									cMemo += "Contatos Externos";
										+ "#*";
										+ Alltrim( TBU->TBU_CODCON );
										+ " - ";
										+ Alltrim( TBU->TBU_DESCON );
										+ Space( 05 );
										+ STR0419;
										+ Alltrim( TBU->TBU_FONE );
										+ "#*"

								Else

									nRegs ++
									cMemo += "Contatos Externos"+"#*"+""+"#*" //"Contatos Externos:" -  "Fone:"

								EndIf

								( 'TBU' )->( dbSkip() )

							End

						EndIf

						cVar1 := "cTXT"+Strzero(nVar1,6)
						OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
						nVar1++
						OLE_ExecuteMacro   ( oWord , "Somalinha"			  )
						OLE_SetDocumentVar ( oWord , "Tabela",cMemo			  )
						OLE_SetDocumentVar ( oWord , "Linhas",nRegs			  )
						OLE_ExecuteMacro   ( oWord , "Table_PlanoEmergencial" ) // Cria tabela do Plano Emergencial.
						OLE_ExecuteMacro   ( oWord , "Somalinha"			  )
						cMemo := ""
				EndIf
				RestArea(aAreaTJG)
				TJG->(dbSkip())
			End
	ElseIf nModeloImp == 2  //Modelo de impressão padrão.
			dbSelectArea("TJG")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TJG", cFil ) + cCodLaudo )
			While TJG->(!Eof()) .And. TJG->TJG_LAUDO == cCodLaudo
				aAreaTJG := GetArea()//Salva Area
				dbSelectArea("TBB")
				dbSetOrder(01)
				dbGoTop()
				If MsSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
					SomaLinha()
					@ Li,005 Psay STR0410 //"Plano Emergencial:"
					@ Li,025 Psay Capital(TBB->TBB_CODPLA)//"Plano Emergencial:"
					@ Li,032 Psay STR0418 //" - "
					@ Li,035 Psay Capital(TBB->TBB_DESPLA)//"Plano Emergencial:"
					SomaLinha()

					@ Li,005 Psay STR0411 //"Elaborador:"

					If TBB->TBB_TIPELA == '1' // Usuário

						@ Li,025 Psay Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) )//"Elaborador:"

					Else // Funcionário

						@ Li,025 Psay Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_ELABOR ), 1, "RA_NOME", cFil ) )//"Elaborador:"

					EndIf

					SomaLinha()

					@ Li,005 Psay STR0412 //"Responsável:"

					If TBB->TBB_TIPRES == '1' // Usuário

						@ Li,025 Psay Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) )//"Responsável:"

					Else // Funcionário

						@ Li,025 Psay Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_RESPON ), 1, "RA_NOME", cFil ) )//"Responsável:"

					EndIf

					SomaLinha()

					If !Empty(TBB->TBB_OBSPLA)
						nLinhasMemo := MLCOUNT(TBB->TBB_OBSPLA,70)
						@ Li,005 Psay STR0413 //"Observações:"
						For LinhaCorrente := 1 To nLinhasMemo
							@ Li,025 Psay MemoLine(TBB->TBB_OBSPLA,70,LinhaCorrente) //"Observações:"
							SomaLinha()
						Next
					Else
						@ Li,005 Psay STR0413 //"Observações:"
						SomaLinha()
					EndIf
					@ Li,005 Psay STR0414 //"Processos:"
					@ Li,025 Psay Capital(TAF->TAF_NOMNIV)//"Processos:"
					SomaLinha()
					//ACOES
					dbSelectArea("TJS")
					dbSetOrder( 1 )//TJS_FILIAL+TJS_CODPLA+TJS_CODACA
					dbGoTop()
					If MsSeek( xFilial( "TJS", cFil ) + TBB->TBB_CODPLA )
						@ Li,005 Psay STR0415 //"Ações:"
						While !Eof() .And. TJS->TJS_FILIAL == xFilial( "TJS", cFil ) .And. TJS->TJS_CODPLA == TBB->TBB_CODPLA
							@ Li,025 Psay Capital(TJS->TJS_CODACA) // "Ações:"
							@ Li,032 Psay STR0418 //" - "
							@ Li,035 Psay Capital(TJS->TJS_DESACA) // "Ações:"
							SomaLinha()
							dbSelectArea("TJS")
							dbSkip()
							Loop
						EndDo //Finaliza While que percorre a Tabela (TJS)
					EndIf
					//PARTICIPANTES
					dbSelectArea("TJT")
					dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
					dbGoTop()
					If MsSeek( xFilial( "TJT", cFil ) + TBB->TBB_CODPLA )
						@ Li,005 Psay STR0416 //"Participantes:"
						While !Eof() .And. TJT->TJT_FILIAL == xFilial( "TJT", cFil ) .And. TJT->TJT_CODPLA == TBB->TBB_CODPLA
							@ Li,025 Psay Capital(TJT->TJT_CODPAR) //"Participantes:"
							@ Li,032 Psay STR0418 //" - "
							@ Li,035 Psay Capital( NGSEEK( "SRA", AllTrim( TJT->TJT_CODPAR ), 1, "RA_NOME", cFil ) ) //"Participantes:"
							SomaLinha()
							dbSelectArea("TJT")
							dbSkip()
							Loop
						EndDo //Finaliza While que percorre a Tabela (TJT)
					EndIf
					//CONTATOS EXTERNOS
					@ Li,005 Psay STR0417 //"Contatos Externos:"

					// Percorre a Tabela TBU e imprime os Contatos Externos.
					dbSelectArea( 'TBU' )
					dbSetOrder( 1 )
					dbGoTop()

					If MsSeek( xFilial( 'TBU', cFil ) + TBB->TBB_CODPLA )

						While !Eof() .And. TBU->TBU_FILIAL == xFilial( 'TBU', cFil ) .And. TBU->TBU_CODPLA == TBB->TBB_CODPLA

							@ Li,025 Psay Capital( TBU->TBU_CODCON ) //"Contatos Externos:"
							@ Li,032 Psay STR0418 //" - "
							@ Li,035 Psay Capital( TBU->TBU_DESCON ) //"Contatos Externos:"
							@ Li,085 Psay STR0419 //"Fone:"
							@ Li,091 Psay Capital ( TBU->TBU_FONE ) //"Fone:"
							SomaLinha()

							( 'TBU' )->( dbSkip() )

						End

					EndIf

					SomaLinha()
				EndIf
				RestArea(aAreaTJG)
				TJG->(dbSkip())
			End
	ElseIf nModeloImp == 3  //Modelo de impressão gráfico.
			dbSelectArea("TJG")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TJG", cFil ) + cCodLaudo )
			While TJG->(!Eof()) .And. TJG->TJG_LAUDO == cCodLaudo
				aAreaTJG := GetArea()//Salva Area
				dbSelectArea("TBB")
				dbSetOrder( 1 )
				If MsSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
					Somalinha()
					oPrintPPRA:Box  ( lin , 150  , lin+60		, 2300     ) // Monta tabela
					oPrintPPRA:line ( lin , 600  , lin+60		, 600      ) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin , 300  , STR0374		, oFont10b ) // "Campo"
					oPrintPPRA:Say  ( lin , 1250 , STR0373		, oFont10b ) // "Conteudo"
					Somalinha()
					oPrintPPRA:Box  ( lin , 150 , lin+60 						  		  , 2300     ) // Monta tabela
					oPrintPPRA:line ( lin , 600 , lin+60  						  		  , 600      ) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin , 165 , STR0410 	  					  		  , oFont10b ) // "Plano Emergencial:"
					oPrintPPRA:Say  ( lin , 620 , Capital(TBB->TBB_CODPLA) 			  , oFont10  ) // "Código"
					oPrintPPRA:Say  ( lin , 770 , STR0418						  		  , oFont10  )
					oPrintPPRA:Say  ( lin , 840 , Capital(Substr(TBB->TBB_DESPLA,1,50)) , oFont10  ) // "Descrição"
					Somalinha()

					// Elaborador
					oPrintPPRA:Box  ( lin , 150 , lin+60 						  					   , 2300     	) // Monta tabela
					oPrintPPRA:line ( lin , 600 , lin+60  						  					   , 600      	) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin , 165 , STR0411	   				  						   , oFont10b 	) // "Elaborador:"

					If TBB->TBB_TIPELA == '1' // Usuário

						oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) ), oFont10 ) // "Elaborador:"

					Else // Funcionário

						oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_ELABOR ), 1, "RA_NOME", cFil ) ), oFont10 ) // "Elaborador:"

					EndIf

					Somalinha()

					// Responsável
					oPrintPPRA:Box  ( lin , 150 , lin+60 						  					   , 2300     	) // Monta tabela
					oPrintPPRA:line ( lin , 600 , lin+60  						  					   , 600      	) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin , 165 , STR0412											   , oFont10b	) // "Responsável:"

					If TBB->TBB_TIPRES == '1' // Usuário

						oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) ), oFont10 ) // "Responsável:"

					Else // Funcionário

						oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "SRA", AllTrim( TBB->TBB_RESPON ), 1, "RA_NOME", cFil ) ), oFont10 ) // "Responsável:"

					EndIf

					Somalinha()

					//Observações
					If !Empty(TBB->TBB_OBSPLA)
						nLinhasMemo := MLCOUNT(TBB->TBB_OBSPLA,50)
						oPrintPPRA:Say	 ( lin , 165 , STR0413 , oFont10b ) // "Observações:"
						For LinhaCorrente := 1 To nLinhasMemo
							oPrintPPRA:Say	 ( lin , 620  , MemoLine(TBB->TBB_OBSPLA,70,LinhaCorrente),oFont10 )
							oPrintPPRA:Line ( lin , 150  , lin+60 , 150  ) // Coluna Inicial
							oPrintPPRA:Line ( lin , 2300 , lin+60 , 2300 ) // Coluna Final
							oPrintPPRA:line ( lin , 600  , lin+60 , 600  ) // Linha Vertical que separa os campos
							SomaLinha()
						Next
					Else
						oPrintPPRA:Say	( lin , 165 , STR0413 , oFont10b ) // "Observações:"
						oPrintPPRA:Box  ( lin , 150 , lin+60  , 2300     ) // Monta tabela
						oPrintPPRA:line ( lin , 600 , lin+60  , 600      ) // Linha Vertical que separa os campos
						SomaLinha()
					EndIf
					//Processos
					oPrintPPRA:Box  ( lin , 150 , lin+60 					, 2300     ) // Monta tabela
					oPrintPPRA:line ( lin , 600 , lin+60  					, 600      ) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin , 165 , STR0414 				  	, oFont10b ) // "Processos:"
					oPrintPPRA:Say  ( lin , 620 , Capital(TAF->TAF_NOMNIV) , oFont10  ) // "Processos:"
					Somalinha()
					//Acoes
					dbSelectArea("TJS")
					dbSetOrder( 1 ) //TJS_FILIAL+TJS_CODPLA+TJS_CODACA
					dbGoTop()
					If MsSeek( xFilial( "TJS", cFil ) + TBB->TBB_CODPLA )
						oPrintPPRA:Say ( lin , 165 , STR0415 , oFont10b ) // "Ações:"
						While !Eof() .And. TJS->TJS_FILIAL == xFilial( "TJS", cFil ) .And. TJS->TJS_CODPLA == TBB->TBB_CODPLA
							oPrintPPRA:Box  ( lin , 150 , lin+60 						  		  , 2300    ) // Monta tabela
							oPrintPPRA:line ( lin , 600 , lin+60  						  		  , 600     ) // Linha Vertical que separa os campos
							oPrintPPRA:Say  ( lin , 620 , Capital(TJS->TJS_CODACA) 			  , oFont10 ) // "Ações:"
							oPrintPPRA:Say  ( lin , 770 , STR0418 						  		  , oFont10 )
							oPrintPPRA:Say  ( lin , 840 , Capital(Substr(TJS->TJS_DESACA,1,50)) , oFont10 ) // "Ações:"
							Somalinha()
							dbSelectArea("TJS")
							dbSkip()
							Loop
						EndDo //Finaliza While que percorre a Tabela (TJS)
					EndIf
					//Participantes
					dbSelectArea("TJT")
					dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
					dbGoTop()
					If MsSeek( xFilial( "TJT", cFil ) + TBB->TBB_CODPLA )
						oPrintPPRA:Say ( lin , 165 , STR0416 , oFont10b ) // "Participantes:"
						While !Eof() .And. TJT->TJT_FILIAL == xFilial( "TJT", cFil ) .And. TJT->TJT_CODPLA == TBB->TBB_CODPLA
							oPrintPPRA:Box  ( lin , 150 , lin+60 						  					   , 2300     	) // Monta tabela
							oPrintPPRA:line ( lin , 600 , lin+60  						  					   , 600      	) // Linha Vertical que separa os campos
							oPrintPPRA:Say  ( lin , 620 , Capital(TJT->TJT_CODPAR) 						   , oFont10  	) // "Participantes:"
							oPrintPPRA:Say  ( lin , 770 , STR0418						  					   , oFont10  	)
							oPrintPPRA:Say  ( lin, 840, Capital( NGSEEK( "SRA", AllTrim( TJT->TJT_CODPAR ), 1, "RA_NOME", cFil ) ), oFont10 ) // "Participantes:"
							Somalinha()
							dbSelectArea("TJT")
							dbSkip()
							Loop
						EndDo //Finaliza While que percorre a Tabela (TJT)
					EndIf

					// Percorre a Tabela TBU e imprime os Contatos Externos.
					dbSelectArea( 'TBU' )
					dbSetOrder( 1 )
					dbGoTop()

					If MsSeek( xFilial( 'TBU', cFil ) + TBB->TBB_CODPLA )

						While !Eof() .And. TBU->TBU_FILIAL == xFilial( 'TBU', cFil ) .And. TBU->TBU_CODPLA == TBB->TBB_CODPLA

							If !Empty( TBU->TBU_CODPLA )

								oPrintPPRA:Box( lin, 150, lin+60, 2300 ) // Monta tabela
								oPrintPPRA:line( lin, 600, lin+60, 600 ) // Linha Vertical que separa os campos
								oPrintPPRA:Say( lin, 620, Capital( TBU->TBU_CODCON ), oFont10 ) // "Contatos Externos:"
								oPrintPPRA:Say( lin, 770, STR0418, oFont10 )
								oPrintPPRA:Say( lin, 840, Capital( Substr( TBU->TBU_DESCON, 1, 27 ) ), oFont10 ) // "Contatos Externos:"
								oPrintPPRA:Say( lin, 1745, STR0419, oFont10 ) // "Fone:"
								oPrintPPRA:Say( lin, 1842, Capital( TBU->TBU_FONE ), oFont10 ) // "Fone:"
								Somalinha()

							Else

								oPrintPPRA:Say  ( lin , 165  , STR0417 , oFont10b ) // "Contatos Externos:"
								oPrintPPRA:Box  ( lin , 150  , lin+60  , 2300     ) // Monta tabela
								oPrintPPRA:line ( lin , 600  , lin+60  , 600      ) // Linha Vertical que separa os campos
								oPrintPPRA:Say  ( lin , 1745 , STR0419 , oFont10  ) // "Fone:"
								Somalinha()

							EndIf

						( 'TBU' )->( dbSkip() )

						End

						SomaLinha()

					EndIf

				EndIf
				RestArea(aAreaTJG)
				TJG->(dbSkip())
			End
	EndIf
	RestArea( aArea )

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} A850REQUIS
Impressão de Requisitos do Laudo
Uso MDTR850

@since 01/02/2013
@version 1.0
@return  Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850REQUIS()

	Local aArea := GetArea()
	Local nRegs := 18 // Variavel pra impressao de word, numero de linhas
	Local nX	:= 0
	Local nCol	:= 0
	Local nCont := 75
	Local aMemo := {}
	Local cMemo := ""
	Local nLinhasMemo, nLinhaCorrente
	Local lTitulo := .T.

	dbSelectArea( 'TJA' )
	dbSetOrder( 1 )
	MsSeek( xFilial( 'TJA', cFil ) + cCodLaudo, .T. )

	While ( 'TJA' )->( !Eof() ) .And. xFilial( 'TJA', cFil ) + cCodLaudo == TJA->TJA_FILIAL + TJA->TJA_LAUDO

		dbSelectArea("TA0")
		dbSetOrder( 1 )
		MsSeek( xFilial( "TA0", cFil ) + TJA->TJA_CODLEG )
		If Empty(cMemo) .And. lTitulo
					lTitulo := .F.
					If nModeloImp == 1
						cVar1 := "cTXT"+Strzero(nVar1,6)
						OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
						nVar1++
						OLE_ExecuteMacro(oWord,"Somalinha")
						OLE_ExecuteMacro(oWord,"Cria_Titulo")
						OLE_ExecuteMacro(oWord,"desativar_negrito")
						OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
						OLE_SetDocumentVar(oWord,cVar1,STR0408)//"Requisitos Legais"
						OLE_ExecuteMacro(oWord,"Somalinha")
					ElseIf nModeloImp == 2
						nCol := 000
						@Li, nCol Psay STR0408 + ":" //"Requisitos Legais"
						Somalinha()
					ElseIf nModeloImp == 3
						nCol := 160
						oPrintPPRA:Say(lin+10,nCol,STR0408,oFont12b)//"Requisitos Legais"
						Somalinha()
					EndIf
		EndIf

		cMemo += STR0390 + "#*"	+ Alltrim(TA0->TA0_CODLEG)  			+ "#*"//Requisito#*
		cMemo += STR0391 + "#*"	+ Alltrim(TA0->TA0_EMENTA)				+ "#*"//Tema da Lei#*
		cMemo += STR0392 + "#*"	+ Alltrim(TA0->TA0_TIPO)				+ "#*"//Tipo#*
		cMemo += STR0393 + "#*"	+ "'MEMO1'"								+ "#*"//Descrição#*
		cMemo += STR0394 + "#*"	+ NGRETSX3BOX("TA0_ORIGEM",TA0->TA0_ORIGEM)+ "#*"//Origem#*
		cMemo += STR0395 + "#*"	+ Alltrim(TA0->TA0_CODRES)				+ "#*"//Resolução#*
		cMemo += STR0396 + "#*"	+ Alltrim(TA0->TA0_NUMRES)  			+ "#*"//Numero resolução#*
		cMemo += STR0397 + "#*"	+ Alltrim(TA0->TA0_OREMIS)				+ "#*"//Orgão Emissor#*
		cMemo += STR0398 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTEMIS))		+ "#*"//Data Emissão#*
		cMemo += STR0399 + "#*"	+ SubStr(Alltrim(TA0->TA0_SITE),1,80)	+ "#*"//Site#*
		cMemo += STR0400 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTVIGE))		+ "#*"//Inicio da Vigência#*
		cMemo += STR0401 + "#*"	+ Alltrim(DTOC(TA0->TA0_DTVENCI))		+ "#*"//Término da Vigência
		cMemo += STR0402 + "#*"	+ Alltrim(TA0->TA0_EST)					+ "#*"//Estado#*
		cMemo += STR0403 + "#*"	+ Alltrim(STR(TA0->TA0_DTVCTO))  	+ "#*"//Dias Vencimento#*
		cMemo += STR0404 + "#*"	+ "'MEMO2'"								+ "#*"//Atendimento#*
		cMemo += STR0405 + "#*"	+ "'MEMO3'"								+ "#*"//Controles#*
		cMemo += STR0406 + "#*" + "'MEMO4'"								+ "#*"//Plano de Ações do Requisito#*
		cMemo += STR0407 + "#*" + "'MEMO5'"								+ "#*"//Responsáveis#*

		If nModeloImp == 2 //Modo de impressao padrao
			cMemo := StrTran(cMemo,"#*#*","#* #*")//Caso houver arquivo vazio incrementa espaco
			aMemo := StrTokArr(cMemo,"#*")//Carrega vetor, Impar - cabecalho, Par - Registros
			For nX := 1 To Len(aMemo)
				If nX % 2 <> 0 // Se cabecalho imprimir a esquerda
					SomaLinha()
					nCol := 000
				Else
					nCol := 030// Se registro imprimir na coluna
					EndIf
				If "MEMO" $ aMemo[nX]//Se for campo Memo imprimi o memo especifico
					IF aMemo[nX] == "'MEMO1'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_DESCRI),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_DESCRI)
					ElseIF aMemo[nX] == "'MEMO2'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_OBRIGA),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_OBRIGA)
					ElseIF aMemo[nX] == "'MEMO3'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_ACOES),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_ACOES)
					ElseIf aMemo[nX] == "'MEMO4'"
						cLinhasMemo := ImpReqMemo("1")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					ElseIf aMemo[nX] == "'MEMO5'"
						cLinhasMemo := ImpReqMemo("2")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					EndIf
					For nLinhaCorrente := 1 To nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,nCont,nLinhaCorrente))
							@Li, nCol Psay MemoLine(cLinhasMemo,nCont,nLinhaCorrente)
							If nLinhaCorrente <> nLinhasMemo
								Somalinha()
							EndIf
						EndIf
					Next
				Else
					@Li, nCol Psay aMemo[nX]
				EndIf
			Next nX
			Somalinha()
		ElseIf nModeloImp == 1 //Impressao Word
			cMemo := StrTran( cMemo , "'MEMO1'" , Alltrim(TA0->TA0_DESCRI))
			cMemo := StrTran( cMemo , "'MEMO2'" , Alltrim(TA0->TA0_OBRIGA))//MEMO1 - TAO_OBRIGA
			cMemo := StrTran( cMemo , "'MEMO3'" , Alltrim(TA0->TA0_ACOES))//MEMO2 - TAO_ACOES
			cMemo := StrTran( cMemo , "'MEMO4'" , ImpReqMemo("1") )//MEMO3 - TAA_NOME
			cMemo := StrTran( cMemo , "'MEMO5'" , ImpReqMemo("2") )//MEMO2 - QAA_NOME
			OLE_ExecuteMacro(  oWord, "Somalinha")
			OLE_SetDocumentVar(oWord,"Tabela",cMemo)
			OLE_SetDocumentVar(oWord, "Linhas"	,nRegs)
			OLE_ExecuteMacro( oWord , "Table_Requisitos")
			OLE_ExecuteMacro(  oWord, "Somalinha")

		ElseIf nModeloImp == 3 // Impressao Grafico
			cMemo := StrTran(cMemo,"#*#*","#* #*")//Caso houver arquivo vazio incrementa espaco
			aMemo := StrTokArr(cMemo,"#*")//Carrega vetor, Impar - cabecalho, Par - Registros
			For nX := 1 To Len(aMemo)
				If nX == 1
					Somalinha()
				EndIf
				If nX % 2 <> 0// Se cabecalho imprimir a esquerda
					SomaLinha()
					oPrintPPRA:Line(lin,150,lin+60,150) //Linha vertical esquerda
					oPrintPPRA:Line(lin,740,lin+60,740) //Linha vertical meio
					oPrintPPRA:Line(lin,2300,lin+60,2300)//Linha horizontal em baixo
					oPrintPPRA:Line(lin,150,lin,2300) // Linha horizontal em cima
					nCol := 160
				Else // Se registro imprimir na coluna
					nCol := 750
				EndIf
				If "MEMO" $ aMemo[nX]//Se for campo Memo imprimi o memo especifico
					IF aMemo[nX] == "'MEMO1'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_DESCRI),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_DESCRI)
					ElseIF aMemo[nX] == "'MEMO2'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_OBRIGA),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_OBRIGA)
					ElseIf aMemo[nX] == "'MEMO3'"
						nLinhasMemo := MLCOUNT(Alltrim(TA0->TA0_ACOES),nCont)
						cLinhasMemo := Alltrim(TA0->TA0_ACOES)
					ElseIf aMemo[nX] == "'MEMO4'"
						cLinhasMemo := ImpReqMemo("1")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					ElseIf aMemo[nX] == "'MEMO5'"
						cLinhasMemo := ImpReqMemo("2")
						nLinhasMemo := MLCOUNT(cLinhasMemo,nCont)
					EndIf
					For nLinhaCorrente := 1 To nLinhasMemo
						If !Empty(MemoLine(cLinhasMemo,nCont,nLinhaCorrente))
							oPrintPPRA:Line(lin,150,lin+60,150)//Linha vertical esquerda
							oPrintPPRA:Line(lin,740,lin+60,740)//Linha vertical meio
							oPrintPPRA:Line(lin,2300,lin+60,2300)//Linha horizontal em baixo

							oPrintPPRA:Say(lin+10,nCol,MemoLine(cLinhasMemo,nCont,nLinhaCorrente),oFont10)
							If nLinhaCorrente <> nLinhasMemo
								Somalinha()
								oPrintPPRA:Line(lin,150,lin+60,150)//Linha vertical esquerda
								oPrintPPRA:Line(lin,740,lin+60,740)//Linha vertical meio
								oPrintPPRA:Line(lin,2300,lin+60,2300)//Linha horizontal em baixo
							EndIf
						EndIf
					Next
				Else
					oPrintPPRA:Say(lin+10,nCol,aMemo[nX],IF(nX % 2 <> 0,oFont10b,oFont10))
				EndIf
				If nX % 2 == 0
					oPrintPPRA:Line(lin+60,150,lin+60,2300)//Linha horizontal em cima
				EndIf
			Next nX
		EndIf

		dbSelectArea("TJA")
		dbSkip()

		cMemo := ""
		aMemo := {}
	End

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} ImpReqMemo
Busca Memo dos campos:
1 - Plano de Ações do Requisito;
2 - Responsáveis;
para imprecao de Requisitos A850REQUIS
Uso MDTR850

@since 01/02/2013
@param  cCampo, Caractere, Campo a ser retornado

@return cMemo, Caractere, Conteúdo do campo memo
/*/
//---------------------------------------------------------------------
Static Function ImpReqMemo(cCampo)

	Local aArea := GetArea()
	Local cMemo := ""

	Do Case
		Case cCampo == "1"//Plano de Ações do Requisito
			dbSelectArea("TCL")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TCL", cFil ) + TA0->TA0_CODLEG, .T.)
			While !Eof() .And. xFilial( "TCL", cFil ) + TA0->TA0_CODLEG == TCL->TCL_FILIAL + TCL->TCL_CODLEG
				dbSelectArea("TAA")
				dbSetOrder( 1 )
				MsSeek( xFilial( "TAA", cFil ) + TCL->TCL_CODPLA )
				cMemo += Alltrim(TAA->TAA_NOME) + CRLF
				dbSelectArea("TCL")
				dbSkip()
			End
		Case cCampo == "2" //Responsáveis
			dbSelectArea("TCM")
			dbSetOrder( 1 )
			MsSeek( xFilial( "TCM", cFil ) + TA0->TA0_CODLEG, .T. )
			While !Eof() .And. xFilial( "TCM", cFil ) + TA0->TA0_CODLEG == TCM->TCM_FILIAL + TCM->TCM_CODLEG
				dbSelectArea("QAA")
				dbSetOrder( 1 )
				MsSeek( xFilial( "QAA", cFil ) + TCM->TCM_RESPON )
				cMemo += Alltrim(QAA->QAA_NOME) + CRLF
				dbSelectArea("TCM")
				dbSkip()
			End
	End Case

	RestArea(aArea)

Return cMemo

//---------------------------------------------------------------------
/*/{Protheus.doc} A850EPIATI
Impressao de EPI por atividade

@author Guilherme Benkendorf
@since 13/02/13
@version MP10/11
@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850EPIATI()

	Local aArea		 := GetArea()
	Local lTitulo 	 := .T.
	Local cCodTarefa := ""
	Local cMemoEpi   := ""
	Local cLaudo     := cCodLaudo
	Local nReg       := 1
	Local lPrimeiro  := .T.
	Local cFilTO1    := '%%'
	Local cFilTN5    := '%%'
	Local LiCorrente := 0
	Local cDesEpi    := ""
	Local cAlsQry    := GetNextAlias()
	Local cFiliTN0   := xFilial( "TN0", cFil )
	Local cFiliTNX   := xFilial( "TNX", cFil )
	Local cFiliSB1   := xFilial( "SB1", cFil )
	Local cFiliTJ9   := xFilial( "TJ9", cFil )
	Local cFiliTJC   := xFilial( "TJC", cFil )
	Local cFiliTO1	 := xFilial( "TO1", cFil )
	Local cFiliTN5   := xFilial( "TN5", cFil )

	BeginSQL Alias cAlsQry
		SELECT * FROM (
			SELECT TN5.TN5_CODTAR CODTAR, TN5.TN5_NOMTAR NOMTAR, TNX.TNX_EPI CODEPI, SB1.B1_DESC DESEPI
				FROM %table:TN5% TN5
				JOIN %table:TN0% TN0 ON
					TN0.TN0_FILIAL = %exp:cFiliTN0% AND
					( TN0.TN0_CODTAR = TN5.TN5_CODTAR OR LTRIM(RTRIM(TN0.TN0_CODTAR)) = '*' ) AND
					TN0.%notDel%
				JOIN %table:TO1% TO1 ON
					TO1.TO1_FILIAL = %exp:cFiliTO1% AND
					TO1.TO1_NUMRIS = TN0.TN0_NUMRIS AND
					TO1.TO1_LAUDO = %exp:cLaudo% AND
					%exp:cFilTO1%
					TO1.%notDel%
				JOIN %table:TNX% TNX ON
					TNX.TNX_FILIAL = %exp:cFiliTNX% AND
					TNX.TNX_NUMRIS = TN0.TN0_NUMRIS AND
					TNX.TNX_EPI IN (
						SELECT TN3.TN3_CODEPI FROM %table:TN3% TN3
							WHERE TN3.%notDel%
							GROUP BY TN3.TN3_CODEPI
					) AND
					TNX.%notDel%
				JOIN %table:SB1% SB1 ON
					SB1.B1_FILIAL = %exp:cFiliSB1% AND
					SB1.B1_COD = TNX.TNX_EPI AND
					SB1.%notDel%
				WHERE TN5.TN5_FILIAL = %exp:cFiliTN5% AND
						%exp:cFilTN5%
						TN5.%notDel%
			UNION
			SELECT TN5.TN5_CODTAR CODTAR, TN5.TN5_NOMTAR NOMTAR, TJ9.TJ9_CODEPI CODEPI, SB1.B1_DESC DESEPI
				FROM %table:TN5% TN5
				JOIN %table:TN0% TN0 ON
					TN0.TN0_FILIAL = %exp:cFiliTN0% AND
					( TN0.TN0_CODTAR = TN5.TN5_CODTAR OR LTRIM(RTRIM(TN0.TN0_CODTAR)) = '*' ) AND
					TN0.%notDel%
				JOIN %table:TO1% TO1 ON
					TO1.TO1_FILIAL = %exp:cFiliTO1% AND
					TO1.TO1_NUMRIS = TN0.TN0_NUMRIS AND
					TO1.TO1_LAUDO = %exp:cLaudo% AND
					%exp:cFilTO1%
					TO1.%notDel%
				JOIN %table:TJC% TJC ON
					TJC.TJC_FILIAL = %exp:cFiliTJC% AND
					TJC.TJC_AGENTE = TN0.TN0_AGENTE AND
					TJC.%notDel%
				JOIN %table:TJ9% TJ9 ON
					TJ9.TJ9_FILIAL = %exp:cFiliTJ9% AND
					TJ9.TJ9_CODPRO = TJC.TJC_CODPRO AND
					TJ9.TJ9_CODEPI IN (
						SELECT TN3.TN3_CODEPI FROM %table:TN3% TN3
							WHERE TN3.%notDel%
							GROUP BY TN3.TN3_CODEPI
					) AND
					TJ9.%notDel%
				JOIN %table:SB1% SB1 ON
					SB1.B1_FILIAL = %exp:cFiliSB1% AND
					SB1.B1_COD = TJ9.TJ9_CODEPI AND
					SB1.%notDel%
				WHERE TN5.TN5_FILIAL = %exp:cFiliTN5% AND
						%exp:cFilTN5%
						TN5.%notDel%
		) TBL
		GROUP BY CODTAR, NOMTAR, CODEPI, DESEPI
		ORDER BY CODTAR
	EndSQL

	dbSelectArea( cAlsQry )//Percorre as Tarefas
	While ( cAlsQry )->(!EoF())

		If lTitulo
			lTitulo := .F.
			//Titulo dos tres modos
			If nModeloImp == 1
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord, "Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"ativar_negrito")
				OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
				OLE_SetDocumentVar(oWord,cVar1,STR0420) //EPI x ATIVIDADES
				OLE_ExecuteMacro(oWord, "Somalinha")

				cMemoEpi += STR0421 + "#*" + STR0331 + "#*" + STR0423	+ "#*" + STR0331 + "#*"//"Tarefas" + "#*" + "Descrição" + "#*" + "Cod. EPI"	+ "#*" + "Descrição" + "#*"
				OLE_SetDocumentVar	( oWord, "Tabela", cMemoEpi )
				OLE_SetDocumentVar	( oWord, "Linhas", 1 )
				OLE_ExecuteMacro	( oWord, "Table_Atividades" )
			ElseIf nModeloImp == 2
				@ Li, 001 Psay STR0420 + ": " //"EPI x ATIVIDADES"
				@ Li, 019 Psay STR0422 //"Tarefas Descrição                      EPI                 Descrição"
			ElseIf nModeloImp == 3
				oPrintPPRA:Say(lin+10,150,STR0420,oFont10)// "EPI x ATIVIDADES"
				Somalinha();Somalinha()
				oPrintPPRA:Box (lin,150,lin+60,2300)
				oPrintPPRA:Say(lin+10,180,STR0421,oFont08b) //"Tarefas"
				oPrintPPRA:Line(lin,350,lin+60,350)
				oPrintPPRA:Say(lin+10,550,STR0331,oFont08b) //"Descrição"
				oPrintPPRA:Line(lin,850,lin+60,850)
				oPrintPPRA:Say(lin+10,1200,STR0423,oFont08b) //"Cod. EPI"
				oPrintPPRA:Line(lin,1720,lin+60,1720)
				oPrintPPRA:Say(lin+10,1950,STR0331,oFont08b) //"Descrição"
			EndIf
		EndIf

		If nModeloImp <> 3
			If nModeloImp == 1
				cMemoEpi := (cAlsQry)->CODTAR + "#*" // Cod. Tarefa
				cMemoEpi += (cAlsQry)->NOMTAR + "#*" // Desc. Tarefa
				cMemoEpi += (cAlsQry)->CODEPI + "#*" // EPI
				cMemoEpi += (cAlsQry)->DESEPI + "#*" // Desc. EPI
				nReg++
				OLE_SetDocumentVar	( oWord, "Tabela", cMemoEpi )
				OLE_SetDocumentVar	( oWord, "Linhas", nReg )
				OLE_ExecuteMacro	( oWord, "Table_Atividades2" )
			ElseIf nModeloImp == 2
				Somalinha()
				//Imprime Tarefa
				If (cAlsQry)->CODTAR <> cCodTarefa
					@ Li, 019 Psay (cAlsQry)->CODTAR
					@ Li, 027 Psay Substr( ( cAlsQry ) -> NOMTAR, 1, 28 )
				EndIf
				//Imprime EPI e Descricao EPI
				@ Li, 058 Psay (cAlsQry)->CODEPI
				cDesEpi := ( cAlsQry )->DESEPI
				nLinhasMemo := MLCOUNT( cDesEpi, 44 )
				For LiCorrente := 1 To nLinhasMemo
					@ Li, 089 Psay MemoLine( cDesEpi, 44, LiCorrente )
					SomaLinha()
				Next

			EndIf
		Else

			If !Empty(cCodTarefa) .And. (cAlsQry)->CODTAR <> cCodTarefa //Se mudou de tarefa
				oPrintPPRA:Line(lin+60,150,lin+60,2300) //Linha Final da tarfea
				lPrimeiro := .T.
			EndIf
			If lin+60 > 3100 //Se vai trocar de página
				oPrintPPRA:Line(lin+60,150,lin+60,2300) //Linha Final da tarefa
			EndIf

			Somalinha()

			If lin == 300 //Se é começo de página
				oPrintPPRA:Line(lin,150,lin,2300) //Linha de cima da tarefa
				oPrintPPRA:Line(lin,850,lin,2300) //Linha de cima do EPI
			EndIf

			//Linhas verticais - ordem da esquerta para direita:
			//Primeira
			oPrintPPRA:Line(lin,150,lin+60,150)
			//Segunda
			oPrintPPRA:Line(lin,350,lin+60,350)
			//Terceira
			oPrintPPRA:Line(lin,850,lin+60,850)
			//Quarta
			oPrintPPRA:Line(lin,1720,lin+60,1720)
			//Quinta
			oPrintPPRA:Line(lin,2300,lin+60,2300)

			If lPrimeiro
				oPrintPPRA:Say(lin+10,155,(cAlsQry)->CODTAR,oFont08) //"Tarefas"
				oPrintPPRA:Say(lin+10,355, Substr( ( cAlsQry ) -> NOMTAR, 1, 28), oFont08 ) //"Descrição"
			EndIf

			oPrintPPRA:Say(lin+10, 855, (cAlsQry)->CODEPI, oFont08) //"Cod. EPI"

			//Imprime Descricao EPI
			oPrintPPRA:Say( lin+02,1725,Substr( ( cAlsQry )->DESEPI, 1, 35 ),oFont08)
			oPrintPPRA:Say( lin+28,1725,Substr( ( cAlsQry )->DESEPI, 36, 60 ),oFont08)

			//Linha final - incluso no EPI - descricao
			oPrintPPRA:Line(lin+60,850,lin+60,2300)

			lPrimeiro := .F.

		EndIf

		cCodTarefa := (cAlsQry)->CODTAR

		(cAlsQry)->( dbSkip() )

	EndDo

	If nModeloImp == 3
		oPrintPPRA:Line(lin+60,150,lin+60,2300) //Linha Final da tarefa
	EndIf

	If !lTitulo
		If nModeloImp == 1
			OLE_ExecuteMacro	( oWord, "Table_Atividades3")
			OLE_ExecuteMacro	( oWord, "Somalinha")
		EndIf
	EndIf

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} fRetLineEPI
Busca numero maximo de posicao do EPI.

- Funcao para impressão de EPI's de fImpEpiRis

@param   aEPI, Array, Contém os EPIs relacionados a outros cadastos.
@param   aPosicoes, Array, Armazena a quantidade de linhas de impressao
dos EPIs.
@param   nTam, Array, Tamanho para quebra da linha

@author  Guilherme Benkendorf
@since   13/02/13
@version MP10/11

@return  nSumPos, Numérico, Número de posições
/*/
//---------------------------------------------------------------------
Static Function fRetLineEPI(aEPI,aPosicoes,nTam)

	Local nEPI
	Local nSumPos := 0

	For nEpi := 1 To Len(aEPI)
		nSumPos += MLCOUNT( Alltrim( NGSEEK( "SB1", aEpi[nEPI], 1, "B1_DESC", cFil ) ), nTam )//MEMOLINE(DESCEPI)
		aAdd( aPosicoes , nSumPos )
	Next nEpi

Return nSumPos

//---------------------------------------------------------------------
/*/{Protheus.doc} fBuscaEPI
Busca de EPI por risco e produto quimico;

- Funcao para impressão de EPI's de fImpEpiRis

@author  Guilherme Benkendorf
@since   13/02/13
@version MP10/11

@param   cRisco, Caractere, Código do risco
@param   aEPI, Array, Array para armazenar os EPis

@return  aEPI, Array, Contem os EPIs
/*/
//---------------------------------------------------------------------
Static Function fBuscaEPI(cRisco,aEPI)

	Local nX
	//Variaveis EPIs x Produtos Quimicos
	Local nIndPro	:= 1
	Local cCondTJC	:= "TJC->TJC_FILIAL+TJC->TJC_AGENTE"
	Local cCondTJ9	:= "TJ9->TJ9_FILIAL+TJ9->TJ9_CODPRO"
	Local cSeekPro	:= ""
	//Variaveis EPIs x Risco
	Local nIndTNX	:= 1
	Local nIndFor	:= 2
	Local cCondTNX	:= "TNX->TNX_FILIAL+TNX->TNX_NUMRIS"
	Local cSeekFor	:= ""
	Local cSeekRis 	:= cRisco


	//Se prestador altera indices e busca com cliente e loja
	If lSigaMdtps
		nIndPro		:= 3
		cCondTJC	:= "TJC->TJC_FILIAL+TJC->TJC_CLIENT+TJC->TJC_LOJA+TJC->TJC_AGENTE"
		cCondTJ9	:= "TJ9->TJ9_FILIAL+TJ9->TJ9_CLIENT+TJ9->TJ9_LOJA+TJ9->TJ9_CODPRO"
		cSeekPro	:= cCliMdtPs

		nIndTNX	:= 4
		cCondTNX:= "TNX_FILIAL+TNX_CLIENT+TNX_LOJA+TNX_NUMRIS"
		nIndFor	:= 4
		cSeekFor:= cCliMdtps
		cSeekRis:= cCliMdtps+cRisco
	EndIf

	//Percorre todos EPI's relacionados ao risco
	dbSelectArea("TNX")
	dbSetOrder(nIndTNX)
	MsSeek(xFilial("TNX", cFil) + cSeekRis)

	While !Eof() .And. xFilial("TNX", cFil) + cSeekRis == &cCondTNX.
		//Verifica fornecedor
		dbSelectarea("TN3")
		dbSetorder(nIndFor)
		If !MsSeek(xFilial("TN3", cFil) + cSeekFor + TNX->TNX_EPI)
			Dbselectarea("TNX")
			Dbskip()
			Loop
		EndIf
		If aScan(aEPI,{|x| x == AllTrim(TNX->TNX_EPI)}) == 0
			aAdd(aEPI, AllTrim(TNX->TNX_EPI))
		EndIf
		dbSelectArea("TNX")
		dbSkip()
	End

	If !lSigaMdtps
		//Percorre todos EPI's relacionados ao produto quimico
		dbSelectArea("TJC")
		dbSetOrder(nIndPro)
		MsSeek(xFilial("TJC", cFil) + cSeekPro + TN0->TN0_AGENTE)

		While xFilial("TJC", cFil) + cSeekPro + TN0->TN0_AGENTE == &cCondTJC.
			dbSelectArea("TJ9")
			dbSetOrder(nIndPro)
			MsSeek(xFilial("TJ9", cFil) + cSeekPro + TJC->TJC_CODPRO)
			While xFilial("TJ9", cFil) + cSeekPro + TJC->TJC_CODPRO == &cCondTJ9.
				//Caso exista o EPI no array não inclui
				If aScan(aEPI,{|x| x == AllTrim(TJ9->TJ9_CODEPI)}) == 0
					aAdd(aEPI, AllTrim(TJ9->TJ9_CODEPI))
				EndIf

				dbSelectArea("TJ9")
				dbSkip()
			End
			dbSelectArea("TJC")
			dbSkip()
		End
	EndIf

	//Ordena por codigo do EPI
	If Len(aEPI) != 0
		aSort(aEPI,,,{ |x, y| x < y })
	EndIf

Return aEPI

//---------------------------------------------------------------------
/*/{Protheus.doc} A850QUATRE
	- Funcao que imprime em Relatorio de Quadro de Requisitos x Treinamento

	- Foi adicionado um novo Atalho (Quadro de Requisitos x Treinamento) na rotina, MDTA210a.prx
	  para impressao no PPRA e PPR
	- Quando este atalho for incluido no Laudo, serao impressos os quadros conforme
	  modelos abaixo:

	  nModeloImp == 1 -> MODELO WORD
	  nModeloImp == 2 -> MODELO PADRAO
	  nModeloImp == 3 -> MODELO GRAFICO

@author Felipe Helio dos Santos
@since 31/03/2013
@version P10/P11

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850QUATRE()

	Local aArea   := GetArea(), aAreaReq := GetArea()
	Local aEmenta := {}, aTreino := {}, aRequisito := {}
	Local nLinCorre, nLinhaMemo, nPosEme, nPosTre, nMax, i, nY, nX, nZ, nJ, nI, nReg := 1
	Local cEmenta := "", cTreino := "", cMemo := "", cEme := ""
	Local oBrush1 := TBrush():New( , RGB(229,229,229) ) // Objeto que preenche campos coloridos, Modelo Gráfico.

	DbSelectArea("TJA")
	DbSetOrder(01)
	MsSeek( xFilial( "TJA", cFil ) + cCodLaudo )

	While !Eof() .And. xFilial( "TJA", cFil ) == TJA->TJA_FILIAL .And. cCodLaudo = TJA->TJA_LAUDO

		aAreaReq := GetArea()
		DbSelectArea("TJE")
		DbSetOrder(01)
		MsSeek( xFilial( "TJE", cFil ) + TJA->TJA_CODLEG )

		While !Eof() .And. xFilial( "TJE", cFil ) == TJE->TJE_FILIAL .And. TJE->TJE_CODLEG == TJA->TJA_CODLEG
			aAdd( aTreino, Alltrim( Capital( NGSEEK( "RA2", AllTrim( TJE->TJE_CALEND ), 1, "RA2->RA2_DESC", cFil ) ) ) )
			DbSelectArea("TJE")
			DbSkip()
		EndDo
		RestArea(aAreaReq)

		DbSelectArea("TA0")
		DbSetOrder(01)
		MsSeek( xFilial( "TA0", cFil ) + TJA->TJA_CODLEG )

		aAdd(aRequisito, {TA0->TA0_CODLEG,Lower(TA0->TA0_EMENTA),TA0->TA0_DTVIGE,;
							TA0->TA0_TIPO,	NGRETSX3BOX("TA0_ORIGEM",TA0->TA0_ORIGEM),aTreino})
 		aTreino := {}

		DbSelectArea("TJA")
		DbSkip()

	EndDo

	For i := 1 To Len(aRequisito)

		nLinhaMemo := MLCOUNT(aRequisito[i][2],30)
		For nLinCorre := 1 To nLinhaMemo		//Tratamento Campo Ementa
			If !Empty((MemoLine(aRequisito[i][2],30,nLinCorre)))
				aAdd(aEmenta, (MemoLine(aRequisito[i][2],30,nLinCorre)))
			EndIf
		Next nLinCorre

		For nY := 1 To Len(aRequisito[i][6])  //Tratamento Campo Treino
			If !Empty(aRequisito[i][6][nY])
				aAdd(aTreino, AllTrim(aRequisito[i][6][nY]))
			EndIf
		Next nY

		nMax := If(Len(aEmenta) > Len(aTreino),nMax := Len(aEmenta),nMax := Len(aTreino))

		If nModeloImp == 1
			If i == 1
				cVar1 := "cTXT"+Strzero(nVar1,6)
				OLE_SetDocumentVar(oWord,"Cria_Var",cVar1)
				nVar1++
				OLE_ExecuteMacro(oWord, "Somalinha")
				OLE_ExecuteMacro(oWord,"Cria_Titulo")
				OLE_ExecuteMacro(oWord,"ativar_negrito")
				OLE_ExecuteMacro(oWord,"Alinhar_Esquerda")
				OLE_SetDocumentVar(oWord, cVar1, "Requisito x Treinamento")
				OLE_ExecuteMacro(oWord, "Somalinha")
				cMemo += STR0390 + "#*" + STR0391 + "#*" + STR0427 + "#*" + STR0392 + "#*" + STR0394+ "#*" + STR0428 + "#*"
			EndIf

			For nJ := 1 To Len(aEmenta)
				cEmenta += aEmenta[nJ] + CRLF
			Next nJ
			For nI := 1 To Len(aTreino)
				cTreino += Capital(aTreino[nI]) + CRLF
			Next nI

			cMemo += aRequisito[i][1]  + "#*"
			cMemo += cEmenta + "#*"
			cMemo += DtoC(aRequisito[i][3])  + "#*"
			cMemo += Capital(aRequisito[i][4]) + "#*"
			cMemo += Capital(aRequisito[i][5]) + "#*"
			cMemo += cTreino + "#*"
			nReg++
			aEmenta := {}
			aTreino := {}
			cEmenta := ""
			cTreino := ""
		ElseIf nModeloImp == 2
			If i == 1
				SomaLinha()
				@ Li,00  Psay STR0390
				@ Li,15  Psay STR0391
				@ Li,47  Psay STR0427
				@ Li,59  Psay STR0392
				@ Li,73  Psay STR0394
				@ Li,86  Psay STR0428
				SomaLinha()
			EndIf
			@ Li,00  Psay aRequisito[i][1]
	   		@ Li,47  Psay aRequisito[i][3]
	   		@ Li,59  Psay Capital(aRequisito[i][4])
	   		@ Li,73  Psay Capital(aRequisito[i][5])
			If nMax >= 1
				For nX := 1 To nMax
					If Len(aEmenta) >= nX
						nPosEme := If(nX == 1,16,15)
						cEme := If(nX==1,Capital(aEmenta[nX]),aEmenta[nX])
						@ Li,nPosEme  Psay AllTrim(cEme)
					EndIf
					If Len(aTreino) >= nX
						nPosTre := If(nX == 1,87,86)
						@ Li,nPosTre  Psay AllTrim(aTreino[nX])
					EndIf
					SomaLinha()
				Next nX
			EndIf
			aEmenta := {}
			aTreino := {}
			SomaLinha()
		ElseIf nModeloImp = 3
			If i == 1
				SomaLinha()
				oPrintPPRA:FillRect({lin, 150, lin+60 , 2300}, oBrush1 )
	   			oBrush1:End()
				oPrintPPRA:Box (lin, 150,  lin+60, 2300 )// Monta tabela
				oPrintPPRA:Line(lin, 436,  lin+60, 436  )//Linha vertical requisito | termo lei
				oPrintPPRA:Line(lin, 1150, lin+60, 1150 )//Linha vertical Termo lei | Vigência
				oPrintPPRA:Line(lin, 1335, lin+60, 1335 )//Linha vertical Vigência  | Tipo
				oPrintPPRA:Line(lin, 1625, lin+60, 1625 )//Linha vertical Tipo      | Origem
				oPrintPPRA:Line(lin, 1820, lin+60, 1820 )//Linha vertical Origem    | Treinamento
				oPrintPPRA:Say (lin+11, 155 , STR0390, oFont10b)
				oPrintPPRA:Say (lin+11, 440 , STR0391, oFont10b)
				oPrintPPRA:Say (lin+11, 1155, STR0427, oFont10b)
				oPrintPPRA:Say (lin+11, 1340, STR0392, oFont10b)
				oPrintPPRA:Say (lin+11, 1630, STR0394, oFont10b)
				oPrintPPRA:Say (lin+11, 1825, STR0428, oFont10b)
				SomaLinha()
			EndIf

			oPrintPPRA:Say(lin,153 ,Capital(aRequisito[i][1]),oFont10,5000)
			oPrintPPRA:Say(lin,1155,DtoC(aRequisito[i][3])   ,oFont10)
			oPrintPPRA:Say(lin,1340,Capital(aRequisito[i][4]),oFont10)
			oPrintPPRA:Say(lin,1630,Capital(aRequisito[i][5]),oFont10)

			If nMax >= 1
				For nZ := 1 To nMax
					If Len(aEmenta) >= nZ
						oPrintPPRA:Say(lin,440 ,Capital(aEmenta[nZ]),oFont10)
					EndIf
					If Len(aTreino) >= nZ
						oPrintPPRA:Say(lin,1825,Capital(aTreino[nZ]),oFont10)
					EndIf
					oPrintPPRA:Line(lin-30,150 ,lin+60,150 )//Linha vertical Esquerda
					oPrintPPRA:Line(lin-30,436 ,lin+60,436 )//Linha vertical requisito | termo lei
					oPrintPPRA:Line(lin-30,1150,lin+60,1150)//Linha vertical Termo lei | Vigência
					oPrintPPRA:Line(lin-30,1335,lin+60,1335)//Linha vertical Vigência  | Tipo
					oPrintPPRA:Line(lin-30,1625,lin+60,1625)//Linha vertical Tipo      | Origem
					oPrintPPRA:Line(lin-30,1820,lin+60,1820)//Linha vertical Origem    | Treinamento
					oPrintPPRA:Line(lin-30,2300,lin+60,2300)//Linha vertical Direita
					SomaLinha()
				Next nZ
				oPrintPPRA:Line(lin,150,lin,2300)   			//Linha horizontal inferior
			EndIf
			aEmenta := {}
			aTreino := {}
		EndIf
	Next i
	If nModeloImp == 1 .And. Len(aRequisito) > 0
		OLE_SetDocumentVar(oWord,"Tabela",cMemo)
		OLE_SetDocumentVar(oWord,"Linhas",nReg)
		OLE_ExecuteMacro(oWord,"Table_ReqTre")
		OLE_ExecuteMacro(oWord,"Somalinha")
	EndIf

	RestArea(aArea)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} A850PRODQUIM
Imprime o Questionario de Produto quimico relacionado ao Laudo

@author Taina Alberto Cardoso
@since 27/04/13
@version MP11
@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
User Function A850PRODQUIM()

	Local nLinPro  := 0
	Local cProdt   := ""
	Local cNegrit  := ""
	Local lCabec   := .T.
	Local cGrupo   := ""
	Local cCodGru  := ""
	Local nLinCorre
	Local aResp    := {}
	Local lImpNova := .F.

	//Verifica os Questionários relacionados ao Laudo
	Dbselectarea( "TIF" )
	dbSetOrder( 1 )
	MsSeek( xFilial( "TIF", cFil ) + TO0->TO0_LAUDO )
	While !Eof() .And. xFilial( "TIF", cFil ) + TO0->TO0_LAUDO == TIF->TIF_FILIAL + TIF->TIF_LAUDO
		lCabec := .F.
		//Verifica se o questionário foi respondido
		dbSelectArea( "TID" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "TID", cFil ) + TIF->TIF_QUEST )
			While !Eof() .And. xFilial( "TID", cFil ) == TID->TID_FILIAL .And. TID->TID_CODIGO == TIF->TIF_QUEST
				If nModeloImp == 3
					//Imprime o cabecalho
					If lCabec
						dbSelectArea( "TIB" )
						dbSetOrder( 1 )
						If MsSeek( xFilial( "TIB", cFil ) + TID->TID_CODIGO )
							cProduto := NgSeek( "SB1", AllTrim( TID->TID_CODPRO ), 1, "B1_DESC", cFil )
						EndIf
						cGrupo := NgSeek( "TK0", AllTrim( TID->TID_CODGRU ), 1, "TK0_DESCRI", cFil )
						cCodGru := TID->TID_CODGRU
						lCabec := .F.
						oPrintPPRA:EndPage()
						Lin := 300
						oPrintPPRA:StartPage()
						Somalinha( 50 )

						oPrintPPRA:Line( lin, 100, lin, 2300 )
						Somalinha( 25 )
						oPrintPPRA:Say( lin, 400, STR0453+ " - FISQP", oFont12b )  // "Ficha de produto químico"
						oPrintPPRA:Say( lin, 1600, STR0398 + " - "+ DToC( TID->TID_DTINI ), oFont12b )  //"Data Emissão"
						Somalinha( 50 )
						oPrintPPRA:Line( lin, 100, lin, 2300 )
						Somalinha( 25 )

						oPrintPPRA:Say( lin, 110, TID->TID_CODGRU+ " - " +cGrupo, oFont10b )
						Somalinha( 52 )

						oPrintPPRA:Line( lin, 100, lin, 2300 )
						oPrintPPRA:Line( lin, 100, lin+75, 100 )
						oPrintPPRA:Line( lin, 2300, lin+75, 2300 )
						oPrintPPRA:Line( lin, 1350, lin+75, 1350 )

						Somalinha( 23 )
						oPrintPPRA:Say( lin, 112, STR0384, oFont10b ) //"Nome do Produto"
						oPrintPPRA:Say( lin, 1380, cProduto, oFont12b )
						Somalinha( 52 )
						oPrintPPRA:Line( lin, 100, lin, 2300 )

						aResp := {}
						nLinhaMemo := MLCOUNT( MSMM( TID->TID_RESP ), 30 )
						For nLinCorre := 1 To nLinhaMemo  //Tratamento Campo Ementa
							aAdd( aResp, ( MemoLine( MSMM( TID->TID_RESP ), 30, nLinCorre ) ) )
						Next nLinCorre

						oPrintPPRA:Line( lin, 100, lin+( 55*( nLinCorre-1 ) ), 100 )
						oPrintPPRA:Line( lin, 2300, lin+( 55*( nLinCorre-1 ) ), 2300 )
						oPrintPPRA:Line( lin, 1350, lin+( 55*( nLinCorre-1 ) ), 1350 )
						oPrintPPRA:Say( lin+15, 112, TID->TID_PERG, oFont08 )
						For nLinCorre := 1 To Len( aResp )
							Somalinha( 15 )
							oPrintPPRA:Say( lin, 1380, aResp[nLinCorre], oFont08 )
							Somalinha( 40 )
						Next nLinCorre

						oPrintPPRA:Line( lin, 100, lin, 2300 )
					Else
						If cCodGru <> TID->TID_CODGRU
							cCodGru := TID->TID_CODGRU
							cGrupo := NgSeek( "TK0", AllTrim( TID->TID_CODGRU ), 1, "TK0_DESCRI", cFil )
							cCodGru := TID->TID_CODGRU
							Somalinha( 100 )
							oPrintPPRA:Say( lin, 110, TID->TID_CODGRU+ " - " +cGrupo, oFont10b )
							Somalinha( 52 )
							oPrintPPRA:Line( lin, 100, lin, 2300 )
						EndIf

						aResp := {}
						nLinhaMemo := MLCOUNT(MSMM( TID->TID_RESP ), 30 )
						For nLinCorre := 1 To nLinhaMemo
							aAdd( aResp, ( MemoLine( MSMM( TID->TID_RESP ), 30, nLinCorre ) ) )
						Next nLinCorre

						oPrintPPRA:Say( lin + 15, 112, TID->TID_PERG, oFont08 )
						For nLinCorre := 1 To Len( aResp )
							oPrintPPRA:Line( lin, 100,  lin + 55, 100 )
							oPrintPPRA:Line( lin, 2300, lin + 55, 2300 )
							oPrintPPRA:Line( lin, 1350, lin + 55, 1350 )
							Somalinha( 15 )
							oPrintPPRA:Say( lin, 1380, aResp[nLinCorre], oFont08 )
							lImpNova := .F.
							If lin + 40 > 3100
								oPrintPPRA:Line( lin + 40, 100, lin + 40, 2300 )
								lImpNova := .T.
							EndIf
							Somalinha( 40 )
							If lImpNova
								oPrintPPRA:Line( lin, 100, lin, 2300 )
							EndIf
						Next nLinCorre

						oPrintPPRA:Line( lin, 100, lin, 2300 )
					EndIf
				ElseIf nModeloImp == 1
					If lCabec
						dbSelectArea( "TIB" )
						dbSetOrder( 1 )
						If MsSeek( xFilial( "TIB", cFil ) + TID->TID_CODIGO )
							cProduto := NgSeek( "SB1", AllTrim( TID->TID_CODPRO ), 1, "B1_DESC", cFil )
						EndIf
						U_IMPHEA850( "{N}" + STR0453 + " -  FISQP " + Space( 50 ) + STR0398 + " - "+ DToC( TID->TID_DTINI ) ) //"Ficha de produto químico" ## "Data Emissão"
						cProdt := STR0384 + "#*" + cProduto + "#*"  //"Nome do Produto"
						cNegrit := "{N}"
						nLinPro++
						lCabec := .F.
					EndIf

					If cCodGru <> TID->TID_CODGRU
						If !Empty( cCodGru )
							OLE_ExecuteMacro( oWord, "Somalinha" )
							OLE_SetDocumentVar( oWord, "Tabela", cProdt )
							OLE_SetDocumentVar( oWord, "Linhas", nLinPro )
							OLE_SetDocumentVar( oWord, "Tabela2", cNegrit )
							OLE_ExecuteMacro( oWord, "Table_Quest_Prod" )
							cProdt  := ""
							cNegrit := "{}"
							nLinPro := 0
   						EndIf
						cGrupo := NgSeek( "TK0", AllTrim( TID->TID_CODGRU ), 1, "TK0_DESCRI", cFil )
						cCodGru := TID->TID_CODGRU
						U_IMPHEA850( "{N}" + AllTrim( TID->TID_CODGRU ) + " - " + cGrupo )
					EndIf
					cProdt += Alltrim( TID->TID_PERG ) + "#*"
					cProdt += MSMM( TID->TID_RESP ) + "#*"
					nLinPro++
				ElseIf nModeloImp == 2
					If lCabec

						dbSelectArea( "TIB" )
						dbSetOrder( 1 )
						If MsSeek( xFilial( "TIB", cFil ) + TID->TID_CODIGO )
							cProduto := NgSeek( "SB1", AllTrim( TID->TID_CODPRO ), 1, "B1_DESC", cFil )
						EndIf
						cGrupo := NgSeek( "TK0", AllTrim( TID->TID_CODGRU ), 1, "TK0_DESCRI", cFil )
						cCodGru := TID->TID_CODGRU
						Somalinha()
						@li, 40 Psay STR0453 + " - " + "FISPQ" //"Ficha de Produto químico"
						@li, 77 Psay STR0398 + " - " + DToC(TID->TID_DTINI) //"Data Emissão"
						@li++, 010 Psay Replicate("_",100)
						li++
						@li++, 010 Psay TID->TID_CODGRU+ " - " +cGrupo
						@li  , 012 Psay STR0384 //"Nome do Produto"
						@li++, 070 Psay cProduto
						lCabec := .F.
						aResp := {}
						nLinhaMemo := MLCOUNT (MSMM( TID->TID_RESP ), 30 )
						For nLinCorre := 1 To nLinhaMemo  //Tratamento Campo Ementa

					 		If !Empty( ( MemoLine( MSMM( TID->TID_RESP ), 30, nLinCorre ) ) )
								aAdd( aResp, ( MemoLine( MSMM( TID->TID_RESP ), 30, nLinCorre ) ) )
						    EndIf
						Next nLinCorre
						li +=1
						@li, 012 Psay TID->TID_PERG
						For nLinCorre := 1 To Len( aResp )
							@li,070 Psay aResp[nLinCorre]
							SomaLinha()
						Next nLinCorre
					Else
						If cCodGru <> TID->TID_CODGRU
							SomaLinha()
							cCodGru := TID->TID_CODGRU
							cGrupo := NgSeek( "TK0", AllTrim( TID->TID_CODGRU ), 1, "TK0_DESCRI", cFil )
							cCodGru := TID->TID_CODGRU
							SomaLinha()
							@li, 010 Psay TID->TID_CODGRU+ " - " +cGrupo
						EndIf
						aResp := {}
						nLinhaMemo := MLCOUNT( MSMM( TID->TID_RESP ), 50 )
						For nLinCorre := 1 To nLinhaMemo  //Tratamento Campo Ementa

					 		If !Empty( ( MemoLine( MSMM( TID->TID_RESP ), 50, nLinCorre ) ) )
								aAdd( aResp, ( MemoLine( MSMM( TID->TID_RESP ), 50, nLinCorre ) ) )
						   EndIf
						Next nLinCorre
						li +=1
						@li, 012 Psay TID->TID_PERG
						For nLinCorre := 1 To Len( aResp )
							@li, 070 Psay aResp[nLinCorre]
							If nLinCorre > 1
							Somalinha()
							EndIf
						Next nLinCorre
					EndIf
				EndIf
				dbSelectArea("TID")
				dbSkip()
			End
		EndIf
		If nModeloImp == 1
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_SetDocumentVar( oWord, "Tabela", cProdt )
			OLE_SetDocumentVar( oWord, "Linhas", nLinPro )
			OLE_SetDocumentVar( oWord, "Tabela2", cNegrit )
			OLE_ExecuteMacro( oWord, "Table_Quest_Prod" )
		EndIf
		lCabec := .T.
		dbSelectArea( "TIF" )
		dbSkip()
	End
Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} A850BEM
Verifica os bens do laudo e chama a função que os imprime.

@author Rodrigo Soledade
@since 06/06/2013
@version P10/P11

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function A850BEM()

	Local aArea   := GetArea()
	Private _1st  := .T.
	Private cMemo := ""
	Private nRegs := 0

	If lSigaMdtps

		If If(nModeloImp != 1, (mv_par06==1), (mv_par08==1))

			Dbselectarea("TOD")
			dbSetOrder( 1 ) //TOD_FILIAL+TOD_CLIENT+TOD_LOJA+TOD_LAUDO+TOD_CODBEM
			MsSeek(xFilial("TOD") + cCliMdtPs + TO0->TO0_LAUDO)
			While !eof() .And. xFilial("TOD")+TO0->TO0_LAUDO == TOD->TOD_FILIAL+TOD->TOD_LAUDO .And. cCliMdtPs == TOD->TOD_CLIENT+TOD->TOD_LOJA
				Dbselectarea("ST9")
				dbSetOrder( 1 )
				If MsSeek(xFilial("ST9")+TOD->TOD_CODBEM)
					Bem850()
				EndIf
				Dbselectarea("TOD")
				Dbskip()
			End

		Else

			DbSelectArea("ST9")
			Dbsetorder(02)
			MsSeek(xFilial("ST9"))
			While !Eof() .And. xFilial("ST9") == ST9->T9_FILIAL

				Dbselectarea("TOD")
				dbSetOrder( 1 )
				If !MsSeek(xFilial("TOD")+cCliMdtPs+TO0->TO0_LAUDO+ST9->T9_CODBEM)
					DbSelectArea("ST9")
					DbSkip()
					Loop
				EndIf

				Bem850()

				DbSelectArea("ST9")
				DbSkip()
			EndDo

		EndIf

	Else

		If IIf( nModeloImp != 1, (mv_par04==1), (mv_par06==1) )

			Dbselectarea( "TOD" )
			dbSetOrder( 1 )
			MsSeek( xFilial( "TOD", cFil ) + TO0->TO0_LAUDO )
			While !Eof() .And. xFilial( "TOD", cFil ) + TO0->TO0_LAUDO == TOD->TOD_FILIAL + TOD->TOD_LAUDO
				Dbselectarea( "ST9" )
				dbSetOrder( 1 )
				If MsSeek( xFilial( "ST9", cFil ) + TOD->TOD_CODBEM )
					Bem850()
				EndIf
				Dbselectarea( "TOD" )
				Dbskip()
			End

		Else

			DbSelectArea( "ST9" )
			Dbsetorder(02)
			MsSeek( xFilial( "ST9", cFil ) )
			While !Eof() .And. xFilial( "ST9", cFil ) == ST9->T9_FILIAL

				Dbselectarea( "TOD" )
				dbSetOrder( 1 )
				If !MsSeek( xFilial( "TOD", cFil ) + TO0->TO0_LAUDO + ST9->T9_CODBEM )
					DbSelectArea( "ST9" )
					DbSkip()
					Loop
				EndIf

				Bem850()
				DbSelectArea( "ST9" )
				DbSkip()
			End

		EndIf

	EndIf

	If nRegs > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_SetDocumentVar( oWord, "Tabela", cMemo )
		OLE_SetDocumentVar( oWord, "Linhas", nRegs )
		OLE_ExecuteMacro( oWord, "Table_Bens" )
	EndIf
	If nRegs > 0 .And. nModeloImp != 1
		Somalinha()
	EndIf

	RestArea( aArea )
Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} Bem850
Funcao que imprime Bens relacionados ao Laudo.

@author Rodrigo Soledade
@since 06/06/2013
@version P10/P11

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function Bem850()

	Local cNomFami := ""

	nRegs++
	If nModeloImp == 2 //Padrão
		If _1st
			Somalinha()
			@ Li, 000 Psay STR0455//"Bens:          Nome                           Familia do bem              Data Compra      Data Instalação"
			_1st := .F.
		EndIf
		Somalinha()
		DbSelectArea( "ST6" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "ST6", cFil ) + ST9->T9_CODFAMI )
			cNomFami := ST6->T6_NOME
		EndIf
		@ Li, 015 Psay Substr( ST9->T9_NOME, 1, 25 )
		@ Li, 046 Psay Substr( cNomFami, 1, 25 )
		@ Li, 074 Psay ST9->T9_DTCOMPR
		@ Li, 091 Psay ST9->T9_DTULTAC

	ElseIf nModeloImp == 3 //Grafico
		If _1st
			Somalinha()
			oPrintPPRA:Say( lin, 200, STR0454, oFont08b ) //"Bens:"
			oPrintPPRA:Say( lin, 550, STR0096, oFont08b ) //"Nome"
			oPrintPPRA:Say( lin, 1200, STR0478, oFont08b ) //"Familia do bem"
			oPrintPPRA:Say( lin, 1720, STR0459, oFont08b ) //"Data Compra"
			oPrintPPRA:Say( lin, 2020, STR0460, oFont08b ) //"Data Instalação"
			_1st := .F.
		EndIf
		Somalinha()
		DbSelectArea( "ST6" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "ST6", cFil ) + ST9->T9_CODFAMI )
			cNomFami := ST6->T6_NOME
		EndIf
		oPrintPPRA:Say( lin, 550, Substr( ST9->T9_NOME, 1, 22 ), oFont08 )
		oPrintPPRA:Say( lin, 1200, Substr( cNomFami, 1, 17 ), oFont08 )
		oPrintPPRA:Say( lin, 1720, DtoC( ST9->T9_DTCOMPR ), oFont08 )
		oPrintPPRA:Say( lin, 2020, DtoC( ST9->T9_DTULTAC ), oFont08 )
	Else
		DbSelectArea( "ST6" )
		dbSetOrder( 1 )
		If MsSeek( xFilial( "ST6", cFil ) + ST9->T9_CODFAMI )
			cNomFami := ST6->T6_NOME
		EndIf
		cMemo += Substr( ST9->T9_NOME, 1, 25 ) + "#*"
		cMemo += Substr( cNomFami, 1, 25 ) + "#*"
		cMemo += IIf( !Empty( ST9->T9_DTCOMPR ), DToC( ST9->T9_DTCOMPR ), "__/__/__" ) + "#*"
		cMemo += IIf( !Empty( ST9->T9_DTULTAC ), DToC( ST9->T9_DTULTAC ), "__/__/__" ) + "#*"
	EndIf

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} A850MDEPC
Verifica os epc do laudo e chama a função que os imprime.

@author Rodrigo Soledade
@since 06/06/2013
@version P10/P11

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function A850MDEPC()

	Local aArea   := GetArea()
	Private _1st  := .T.
	Private cMemo := ""
	Private nRegs := 0

	If lSigaMdtps

		If If(nModeloImp != 1, (mv_par06==1), (mv_par08==1))

			Dbselectarea("TO3")
			Dbsetorder(3)
			MsSeek(xFilial("TO3") + cCliMdtPs + TO0->TO0_LAUDO)
			While !eof() .And. xFilial("TO3")+TO0->TO0_LAUDO == TO3->TO3_FILIAL+TO3->TO3_LAUDO .And. cCliMdtPs == TO3->TO3_CLIENT+TO3->TO3_LOJA
				Dbselectarea("TO4")
				dbSetOrder( 1 )
				If MsSeek(xFilial("TO4")+TO3->TO3_CONTRO)
					If TO4->TO4_TIPCTR == "2"
						Epc850()
					EndIf
				EndIf
				Dbselectarea("TO3")
				Dbskip()
			End
		Else
			DbSelectArea("TO4")
			Dbsetorder(02)
			MsSeek(xFilial("TO4"))
			While !Eof() .And. xFilial("TO4") == TO4->TO4_FILIAL

				Dbselectarea("TO3")
				Dbsetorder(3)
				If !MsSeek(xFilial("TO3")+cCliMdtPs+TO0->TO0_LAUDO+TO4->TO4_CONTRO)
					DbSelectArea("TO4")
					DbSkip()
					Loop
				EndIf
				If TO4->TO4_TIPCTR == "2"
					Epc850()
				EndIf
				DbSelectArea("TO4")
				DbSkip()
			EndDo

		EndIf
	Else
		If If(nModeloImp != 1, (mv_par04==1), (mv_par06==1))
			Dbselectarea( "TO3" )
			dbSetOrder( 1 )//TO3_FILIAL+TO3_LAUDO+TO3_CONTRO
			MsSeek( xFilial( "TO3", cFil ) + TO0->TO0_LAUDO )
			While !Eof() .And. xFilial( "TO3", cFil ) + TO0->TO0_LAUDO == TO3->TO3_FILIAL + TO3->TO3_LAUDO
				Dbselectarea( "TO4" )
				dbSetOrder( 1 ) //TO4_FILIAL+TO4_CONTRO
				If MsSeek( xFilial( "TO4", cFil ) + TO3->TO3_CONTRO )
					If TO4->TO4_TIPCTR == "2"
						Epc850()
					EndIf
				EndIf
				Dbselectarea( "TO3" )
				Dbskip()
			End
		Else
			DbSelectArea( "TO4" )
			Dbsetorder( 01 )
			MsSeek( xFilial( "TO4", cFil ) )
			While !Eof() .And. xFilial( "TO4", cFil ) == TO4->TO4_FILIAL

				Dbselectarea( "TO3" )
				dbSetOrder( 1 )
				If !MsSeek( xFilial( "TO3", cFil ) + TO0->TO0_LAUDO + TO4->TO4_CONTRO )
					DbSelectArea( "TO4" )
					DbSkip()
					Loop
				EndIf
				If TO4->TO4_TIPCTR == "2"
					Epc850()
				EndIf
				DbSelectArea( "TO4" )
				DbSkip()
			EndDo
		EndIf
	EndIf

	If nRegs > 0 .And. nModeloImp == 1
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_SetDocumentVar( oWord, "Tabela", cMemo )
		OLE_SetDocumentVar( oWord, "Linhas", nRegs )
		OLE_ExecuteMacro( oWord, "Table_Epc" )
	EndIf
	If nRegs > 0 .And. nModeloImp != 1
		Somalinha()
	EndIf

	RestArea( aArea )

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} Epc850
Funcao que imprime Bens relacionados ao Laudo.

@author Rodrigo Soledade
@since 06/06/2013
@version P10/P11

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function Epc850()

	nRegs++
	If nModeloImp == 2
		If _1st
			Somalinha()
			@ Li, 000 Psay STR0456//"EPC's:         Controle                       Nome"
			_1st := .F.
		EndIf
		Somalinha()

		@ Li, 015 Psay TO4->TO4_CONTRO
		@ Li, 046 Psay TO4->TO4_NOMCTR
	ElseIf nModeloImp == 3
		If _1st
			Somalinha()
			oPrintPPRA:Say( lin, 200, STR0457, oFont08b ) //"Epc's:"
			oPrintPPRA:Say( lin, 550, STR0458, oFont08b ) //"Controle"
			oPrintPPRA:Say( lin, 1200, STR0096, oFont08b )//"Nome"
			_1st := .F.
		EndIf
		Somalinha()
		oPrintPPRA:Say( lin, 550, TO4->TO4_CONTRO, oFont08 )
		oPrintPPRA:Say( lin, 1200, SubStr( TO4->TO4_NOMCTR, 1, 22 ), oFont08 )
	Else
		cMemo += TO4->TO4_CONTRO+"#*"
		cMemo += TO4->TO4_NOMCTR+"#*"
	EndIf

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} A850QToques
Funcao que imprime Quadro de toques.

@author Rodrigo Soledade
@since 11/06/2013
@version P10/P11

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function A850QToques()

	If nModeloImp == 1
		If nModeloImp == 1 //Word
			OLE_ExecuteMacro( oWord, "Quadro_toques" )
		EndIf
	ElseIf nModeloImp == 2 //Padrão
		Somalinha()
		@ Li, 000 Psay STR0461 //"Quadro de Toques:    Numero de Toques             Tipo de Toque                       Ação"
		Somalinha()
		@ Li, 021 Psay "1"
		@ Li, 050 Psay STR0462 //"LONGO"
		@ Li, 086 Psay STR0463 //"PARAR"
		Somalinha()
		@ Li, 021 Psay "1"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0465 //"SUBIR"
		Somalinha()
		@ Li, 021 Psay "2"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0466 //"DESCER"
		Somalinha()
		@ Li, 021 Psay "3"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0467 //"ENTRADA OU SAÍDA DE PESSOAS"
		Somalinha()
		@ Li, 021 Psay "3-3-1"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0468 //"SUBIR LENTAMENTE"
		Somalinha()
		@ Li, 021 Psay "3-3-2"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0469 //"DESCER LENTAMENTE"
		Somalinha()
		@ Li, 021 Psay "4"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0470 //"INÍCIO DO TRANSPORTE DE PESSOAS"
		Somalinha()
		@ Li, 021 Psay "4-4"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0471 //"FIM DO TRANSPORTE DE PESSOAS"
		Somalinha()
		@ Li, 021 Psay "5"
		@ Li, 050 Psay STR0464 //"CURTO"
		@ Li, 086 Psay STR0472 //"O SINALIZADOR VAI ENTRAR NA GAIOLA"
		Somalinha()
		@ Li, 021 Psay "1"
		@ Li, 050 Psay STR0473 //"CONTÍNUO"
		@ Li, 086 Psay "EMERGÊNCIA"

	ElseIf nModeloImp == 3 //Grafico
		oPrintPPRA:Box( lin + 60, 150, lin + 720, 2300 )
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 320, STR0475, oFont10b ) //"Numero de Toques"
		oPrintPPRA:Say( lin + 10, 1000, STR0476, oFont10b ) //"Tipo de Toque"
		oPrintPPRA:Say( lin + 10, 1800, STR0477, oFont10b ) //"Ação"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "1", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0462, oFont10 ) //"LONGO"
		oPrintPPRA:Say( lin + 10, 1480, STR0463, oFont10 ) //"PARAR"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "1", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0465, oFont10 ) //"SUBIR"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "2", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0466, oFont10 ) //"DESCER"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "3", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0467, oFont10 ) //"ENTRADA OU SAÍDA DE PESSOAS"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "3-3-1", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0468, oFont10 ) //"SUBIR LENTAMENTE"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "3-3-2", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0469, oFont10 ) //"DESCER LENTAMENTE"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "4", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0470, oFont10 ) //"INÍCIO DO TRANSPORTE DE PESSOAS"
		Somalinha()
		oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
		oPrintPPRA:Line( lin + 120, 150, lin + 120, 2300 )
		oPrintPPRA:Line( lin + 60, 815, lin + 180, 815 )
		oPrintPPRA:Line( lin + 60, 1460, lin + 180, 1460 )
		oPrintPPRA:Say( lin + 10, 470, "4-4", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0471, oFont10 ) //"FIM DO TRANSPORTE DE PESSOAS"
		Somalinha()
		oPrintPPRA:Say( lin + 10, 470, "5", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0464, oFont10 ) //"CURTO"
		oPrintPPRA:Say( lin + 10, 1480, STR0472, oFont10 ) //"O SINALIZADOR VAI ENTRAR NA GAIOLA"
		Somalinha()
		oPrintPPRA:Say( lin + 10, 470, "1", oFont10 )
		oPrintPPRA:Say( lin + 10, 1070, STR0473, oFont10 ) //"CONTÍNUO"
		oPrintPPRA:Say( lin + 10, 1480, STR0474, oFont10 ) //"EMERGÊNCIA"
	EndIf

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} fImpPerDan
Imprime Perigos e danos relacionado ao risco.

@author Guilherme Benkendorf
@since 04/09/2013
@version P11
@param aDanos, Array, Onde serão armazenados os danos

@return Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------------------
Static Function fImpPerDan( aDanos )

	Local cCusto := cFuncao := cTarefa := "", cDepto := ""

	dbSelectArea( "TG6" )
	TG6->(dbGoTop())
	MsSeek( xFilial( "TG6", cFil ) )
	While !Eof() .And. xFilial( "TG6", cFil ) == TG6->TG6_FILIAL
		dbSelectArea( "TAF" )
		dbSetOrder( 2 )//TAF_FILIAL+TAF_CODEST+TAF_CODNIV+TAF_NOMNIV
		MsSeek( xFilial( "TAF", cFil ) + TG6->TG6_CODEST + TG6->TG6_CODNIV )
		cCusto := cFuncao := cTarefa := ""
		fVerLocRis( @cCusto, @cFuncao, @cTarefa, @cDepto )

		dbSelectArea( "TG1" )
		dbSetOrder( 1 )//TG1_FILIAL + TG1_CODPER
		MsSeek( xFilial( "TG1", cFil ) + TG6->TG6_CODPER)
		If 	Alltrim( TN0->TN0_CC ) == Alltrim( cCusto ) .And. ;
				Alltrim( TN0->TN0_CODFUN ) == Alltrim( cFuncao ) .And.;
				Alltrim( TN0->TN0_CODTAR ) == Alltrim( cTarefa ) .And.;
				Alltrim( TN0->TN0_DEPTO ) == Alltrim( cDepto )  .And.;
				TN0->TN0_AGENTE == TG1->TG1_AGENTE .And.	TN0->TN0_FONTE == TG1->TG1_FONTE

			If aScan( aDanos, { | x | x[ 1 ] == aDano[ 1 ] } ) == 0
				aAdd( aDanos, { Alltrim( TG6->TG6_CODDAN ), SubStr( NGSEEK( "TG8", AllTrim( TG6->TG6_CODDAN ), 1, "TG8_DESCRI", cFil ), 1, 40 ) } )
			EndIf

		EndIf

		TG6->(dbSkip())
	End
Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fVerLocRis
Retorna as definicoes de locais do risco

@param cCusto, Caracetre, Codigo do Centro de Custo
@param cFuncao, Caracetre, Codigo da Funcao
@param cTarefa, Caracetre, Codigo da Tarefa
@param cDepto, Caracetre, Codigo do Departamento

@author Jackson Machado
@since 16/01/2013
@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function fVerLocRis( cCusto , cFuncao , cTarefa , cDepto )

	Local cNivSup	:= ""
	Local cCargo	:= ""
	Local aArea	:= GetArea()

	cCargo	:= TAF->TAF_CODNIV
	dbSelectArea( "TAF" )
	dbSetOrder( 2 )
	MsSeek( xFilial( "TAF", cFil ) + "001" + cCargo )

	If TAF->TAF_INDCON == "2"//LOC
		If TAF->TAF_CCUSTO <> "001"
			While Empty( cCusto )
				If TAF->TAF_CODNIV <> "001"
					If !Empty( TAF->TAF_CCUSTO )
						cCusto := TAF->TAF_CCUSTO
						If Empty( cDepto )
							If !Empty( TAF->TAF_DEPTO )
								cDepto := TAF->TAF_DEPTO
							Else
								cDepto := "*"
							EndIf
						EndIf
					Else
						If Empty( cDepto )
							If !Empty( TAF->TAF_DEPTO )
								cDepto := TAF->TAF_DEPTO
							Else
								cDepto := "*"
							EndIf
						EndIf
						cNivSup := TAF->TAF_NIVSUP
						dbSelectArea( "TAF" )
						dbSetOrder( 2 )
						MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )
						Loop
					EndIf
				Else
					cCusto := "*"
					If Empty( cDepto )
						cDepto := "*"
					EndIf
				EndIf
			End
		Else
			cCusto := "*"
			If Empty( cDepto )
				cDepto := "*"
			EndIf
		EndIf
		cFuncao := "*"
		cTarefa := "*"
	ElseIf TAF->TAF_INDCON == "3"//"FUN"
		cFuncao := SubStr( TAF->TAF_CODCON, 1, Len( SRJ->RJ_FUNCAO ) )
		cTarefa := "*"
		cNivSup := TAF->TAF_NIVSUP
		dbSelectArea( "TAF" )
		dbSetOrder( 2 )
		MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )
		While Empty( cCusto )
			If TAF->TAF_CODNIV <> "001"
				If !Empty( TAF->TAF_CCUSTO )
					cCusto := TAF->TAF_CCUSTO
					If Empty( cDepto ) .And. !Empty( TAF->TAF_DEPTO )
						cDepto := TAF->TAF_DEPTO
					EndIf
				Else
					If Empty( cDepto ) .And. !Empty( TAF->TAF_DEPTO )
						cDepto := TAF->TAF_DEPTO
					EndIf
					cNivSup := TAF->TAF_NIVSUP
					dbSelectArea( "TAF" )
					dbSetOrder( 2 )
					MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )
					Loop
				EndIf
			Else
				cCusto := "*"
				If Empty( cDepto )
					cDepto := "*"
				EndIf
			EndIf
		End
	ElseIf TAF->TAF_INDCON == "4"// "TAR"
		cTarefa := SubStr( TAF->TAF_CODCON, 1, Len( TN6->TN6_CODTAR ) )
		cNivSup := TAF->TAF_NIVSUP

		dbSelectArea( "TAF" )
		dbSetOrder( 2 )
		MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )

		If TAF->TAF_INDCON == "3" // "FUN"
			cFuncao := SubStr( TAF->TAF_CODCON, 1, Len( SRJ->RJ_FUNCAO ) )
		Else
			cFuncao := "*"
		EndIf
		cNivSup := TAF->TAF_NIVSUP

		dbSelectArea( "TAF" )
		dbSetOrder( 2 )
		MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )
		While Empty( cCusto )
			If TAF->TAF_CODNIV <> "001"
				If !Empty( TAF->TAF_CCUSTO )
					cCusto := TAF->TAF_CCUSTO
					If Empty( cDepto ) .And. !Empty( TAF->TAF_DEPTO )
						cDepto := TAF->TAF_DEPTO
					EndIf
				Else
					If Empty( cDepto ) .And. !Empty( TAF->TAF_DEPTO )
						cDepto := TAF->TAF_DEPTO
					EndIf
					cNivSup := TAF->TAF_NIVSUP
					dbSelectArea( "TAF" )
					dbSetOrder( 2 )
					MsSeek( xFilial( "TAF", cFil ) + "001" + cNivSup )
					Loop
				EndIf
			Else
				cCusto := "*"
				If Empty( cDepto )
					cDepto := "*"
				EndIf
			EndIf
		End
	EndIf

	RestArea( aArea )
Return Nil

//---------------------------------------------------------------------
/*{Protheus.doc} A850DOSIME

Funcao genérica para impressão de:

 - Dosimetria por Ambiente Físico.
 - Dosimetria por Funcionario.
 - Dosimetria por Centro de Custo.
 - Dosimetria por Função.
 - Dosimetria por Atividade.

Nos modelos de impressão:
 - Word.
 - Padrão.
 - Grafico.

@author Bruno Lobo de Souza
@since 23/09/2013
@version P11
@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function A850DOSIME(cTipDos)

	Local nRegs 	  := 1
	Local cImgPath	  := ""
	Local cCodOld	  := ""
	Local cMemo 	  := ""
	Local aFiltros    := {}
	Local aRelacao    := {}
	Local aArea   	  := GetArea()
	Local oBrush1	  := TBrush():New( , RGB( 229, 229, 229 ) ) // Objeto que preenche campos coloridos, Modelo Gráfico.

	If cTipDos == "1"
		dbSelectArea( "TO5" )
		dbSetOrder( 1 )
		MsSeek( xFilial( "TO5", cFil ) + cCodLaudo )
		While TO5->( !Eof() ) .And. TO5->TO5_FILIAL == xFilial( "TO5", cFil ) .And. TO5->TO5_LAUDO == cCodLaudo
			aAdd( aFiltros , TO5->TO5_CODAMB )
			TO5->( dbSkip() )
		End
	EndIf

	dbSelectArea( "TJ7" )
	dbSetOrder( 1 )
	If MsSeek( xFilial( "TJ7", cFil ) + cTipDos )
		While !Eof() .And. xFilial( "TJ7", cFil ) == TJ7->TJ7_FILIAL .And. TJ7->TJ7_TIPREG == cTipDos

			If cTipDos == "1"
				If aScan( aFiltros, { | x | AllTrim( x ) == AllTrim( TJ7->TJ7_CODIGO ) } ) == 0
					TJ7->( dbSkip() )
					Loop
				EndIf
			EndIf

			If cCodOld <> TJ7->TJ7_CODIGO
				If !Empty( cCodOld )
					// Execução da Macro para impressão Word.
					If nModeloImp == 1 .And. !Empty( cMemo ) .And. nRegs > 1 // Modelo de ImpressÃ£o .doc (Word.)
						OLE_ExecuteMacro( oWord, "Somalinha" )
						OLE_SetDocumentVar( oWord, "Tabela", cMemo )
						OLE_SetDocumentVar( oWord, "Linhas", nRegs )
						OLE_ExecuteMacro( oWord, "Table_Dosimetria" ) // Cria tabela no Word de Dosimetria por Ambiente Físico.
						cMemo := ""
						nRegs := 1
					EndIf
				EndIf
				cCodOld := TJ7->TJ7_CODIGO

				//Inicio da impressão do cabeçalho
				If nModeloImp == 1 // Modelo de ImpressÃ£o .doc (Word.)
					If cTipDos == "1"
						U_IMPHEA850( "{N}"+STR0429+": " ) // "Dosimetria Por Ambiente Físico:"
						U_IMPDOC850( SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TNE->TNE_CODAMB ) ) + " - " +;
						 Capital( NGSEEK( "TNE", AllTrim( TJ7->TJ7_CODIGO ), 1, "TNE->TNE_NOME", cFil ) ) )
					ElseIf cTipDos == "2"
						U_IMPHEA850("{N}"+STR0430+": " ) // "Dosimetria Por Funcionário:"
						U_IMPDOC850( SubStr( Capital( TJ7->TJ7_CODIGO ) ,1, Len( SRA->RA_MAT ) ) + " - " +;
						 Capital( NGSEEK( "SRA", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRA->RA_NOME", cFil ) ) )
					ElseIf cTipDos == "3"
						U_IMPHEA850( "{N}"+STR0431+": " ) // "Dosimetria Por Centro de Custo:"
						U_IMPDOC850( SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( CTT->CTT_CUSTO ) ) + " - " +;
						 Capital( NGSEEK( "CTT", AllTrim( TJ7->TJ7_CODIGO ), 1, "CTT->CTT_DESC01", cFil ) ) )
					ElseIf cTipDos == "4"
						U_IMPHEA850( "{N}"+STR0432+": " ) // "Dosimetria Por Função:"
						U_IMPDOC850( SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( SRJ->RJ_FUNCAO ) ) + " - " +;
						 Capital( NGSEEK( "SRJ", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRJ->RJ_DESC", cFil ) ) )
					ElseIf cTipDos == "5"
						U_IMPHEA850( "{N}"+STR0433+": " ) // "Dosimetria Por Tarefa:"
						U_IMPDOC850( SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TN5->TN5_CODTAR ) ) + " - " +;
						 Capital( NGSEEK( "TN5", AllTrim( TJ7->TJ7_CODIGO ), 1, "TN5->TN5_NOMTAR", cFil ) ) )
					EndIf

					cMemo += STR0440+"#*"
					cMemo += STR0434+"#*"
					cMemo += STR0435+"#*"
					cMemo += STR0436+"#*"
					cMemo += STR0437+"#*"
					cMemo += STR0438+"#*"
					cMemo += STR0439+"#*"

				ElseIf nModeloImp == 2 // Modelo de Impressão Padrão.
					/*
					********************************************************************************************
					0         1         2         3         4         5         6         7         8         9         0         1
					012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
					********************************************************************************************
					Data        Pontos      Tipo Locais                               Fator         Taxa de Dose  Unidade  Distância
																					Ocupação (T)  Equivalente   Medida
					xx/xx/xxxx  xxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxx          xxxx          xx       xxx
					xx/xx/xxxx  xxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxx          xxxx          xx       xxx
					xx/xx/xxxx  xxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxx          xxxx          xx       xxx

					*/
					SomaLinha()
					If cTipDos == "1"
						@ Li, 019 Psay STR0429 + ": " // "Dosimetria Por Ambiente Físico:"
						@ Li, 048 Psay SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TNE->TNE_CODAMB ) ) + " - " +;
						 Capital( NGSEEK( "TNE", AllTrim( TJ7->TJ7_CODIGO ), 1, "TNE->TNE_NOME", cFil ) )
					ElseIf cTipDos == "2"
						@ Li, 019 Psay STR0430 + ": " // "Dosimetria Por Funcionário:"
						@ Li, 048 Psay SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( SRA->RA_MAT ) ) + " - " +;
						 Capital( NGSEEK( "SRA", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRA->RA_NOME", cFil ) )
					ElseIf cTipDos == "3"
						@ Li, 019 Psay STR0431 + ": " // "Dosimetria Por Centro de Custo:"
						@ Li, 048 Psay SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( CTT->CTT_CUSTO ) ) + " - " +;
						 Capital( NGSEEK( "CTT", AllTrim( TJ7->TJ7_CODIGO ), 1, "CTT->CTT_DESC01", cFil ) )
					ElseIf cTipDos == "4"
						@ Li, 019 Psay STR0432 + ": " // "Dosimetria Por Função:"
						@ Li, 048 Psay SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( SRJ->RJ_FUNCAO ) ) + " - " +;
						 Capital( NGSEEK( "SRJ", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRJ->RJ_DESC", cFil ) )
					ElseIf cTipDos == "5"
						@ Li, 019 Psay STR0433 + ": " // "Dosimetria Por Tarefa:"
						@ Li, 048 Psay SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TN5->TN5_CODTAR ) ) + " - " +;
						 Capital( NGSEEK( "TN5", AllTrim( TJ7->TJ7_CODIGO ), 1, "TN5->TN5_NOMTAR", cFil ) )
					EndIf
					SomaLinha()
					@ Li, 000 Psay STR0440 // "Data"
					@ Li, 012 Psay STR0434 // "Pontos"
					@ Li, 024 Psay STR0435 // "Tipo Local"
					@ Li, 066 Psay STR0441 // "Fator"
					@ Li, 080 Psay STR0443 // "Taxa de Dose"
					@ Li, 094 Psay STR0445 // "Unidade"
					@ Li, 103 Psay STR0439 // "Distância"
					SomaLinha()
					@ Li, 066 Psay STR0442 //"Ocupação (T)"
					@ Li, 080 Psay STR0444 //"Equivalente"
					@ Li, 094 Psay STR0446 //"Medida"

				ElseIf nModeloImp == 3 // Modelo de Impressão Grafico.
					If Lin + 300 > 3000
						SomaLinha( 300 )
					EndIf
					SomaLinha()
					If cTipDos == "1"
						oPrintPPRA:Say  ( lin, 165, STR0429 + ": ", oFont10b ) // Dosimetria Ambiente Físico:
						oPrintPPRA:Say  ( lin, 745, SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TNE->TNE_CODAMB ) ) + " - " +;
						 Capital( NGSEEK( "TNE", AllTrim( TJ7->TJ7_CODIGO ), 1, "TNE->TNE_NOME", cFil ) ), oFont10 	)
					ElseIf cTipDos == "2"
						oPrintPPRA:Say  ( lin, 165, STR0430 + ": ", oFont10b ) // "Dosimetria Por Funcionário:"
						oPrintPPRA:Say  ( lin, 665, SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( SRA->RA_MAT ) ) + " - " +;
						 Capital( NGSEEK( "SRA", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRA->RA_NOME", cFil ) ), oFont10 )
					ElseIf cTipDos == "3"
						oPrintPPRA:Say  ( lin, 165, STR0431 + ": ", oFont10b ) // "Dosimetria Por Centro de Custo:"
						oPrintPPRA:Say  ( lin, 745, SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( CTT->CTT_CUSTO ) ) + " - " +;
						 Capital( NGSEEK( "CTT", AllTrim( TJ7->TJ7_CODIGO ), 1, "CTT->CTT_DESC01", cFil ) ), oFont10 )
					ElseIf cTipDos == "4"
						oPrintPPRA:Say  ( lin, 165, STR0432 + ": ", oFont10b ) // "Dosimetria Por Função:"
						oPrintPPRA:Say  ( lin, 570, SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( SRJ->RJ_FUNCAO ) ) + " - " +;
						 Capital( NGSEEK( "SRJ", AllTrim( TJ7->TJ7_CODIGO ), 1, "SRJ->RJ_DESC", cFil ) ), oFont10 )
					ElseIf cTipDos == "5"
						oPrintPPRA:Say  ( lin, 165, STR0433 + ": ", oFont10b ) // "Dosimetria Por Tarefa:"
						oPrintPPRA:Say  ( lin, 620, SubStr( Capital( TJ7->TJ7_CODIGO ), 1, Len( TN5->TN5_CODTAR ) ) + " - " +;
						 Capital( NGSEEK( "TN5", AllTrim( TJ7->TJ7_CODIGO ), 1, "TN5->TN5_NOMTAR", cFil ) ), oFont10 )
					EndIf

					SomaLinha()
					//Destaca linha
					oPrintPPRA:FillRect({lin, 150, lin+120 , 2300}, oBrush1 )
					oBrush1:End()
					//Monta tabela do cabeçalho
					oPrintPPRA:Box( lin, 150, lin + 120, 2300 ) // Monta tabela
					oPrintPPRA:line( lin, 400, lin + 60, 400 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 670, lin + 60, 670 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1090, lin + 60, 1090 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1430, lin + 60, 1430 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1770, lin + 60, 1770 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 2040, lin + 60, 2040 ) // Linha Vertical que separa os campos
					//Comteúdo do cabeçalho
					oPrintPPRA:Say( lin, 230, STR0440, oFont10b ) // "Data"
					oPrintPPRA:Say( lin, 450, STR0434, oFont10b ) // "Ponto"
					oPrintPPRA:Say( lin, 720, STR0435, oFont10b ) // "Tipo Local"
					oPrintPPRA:Say( lin, 1190, STR0441, oFont10b ) // "Fator Ocupação (T)"
					oPrintPPRA:Say( lin, 1460, STR0443, oFont10b ) // "Taxa de Dose Equivalente"
					oPrintPPRA:Say( lin, 1825, STR0445, oFont10b ) // "Unidade Medida"
					oPrintPPRA:Say( lin, 2080, STR0439, oFont10b ) // "Distânncia"
					SomaLinha()
					//Segunda linha do cabeçalho
					oPrintPPRA:line( lin, 400, lin + 60, 400 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 670, lin + 60, 670 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1090, lin + 60, 1090 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1430, lin + 60, 1430 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 1770, lin + 60, 1770 ) // Linha Vertical que separa os campos
					oPrintPPRA:line( lin, 2040, lin + 60, 2040 ) // Linha Vertical que separa os campos
					//Conteúdo da segunda linha do cabeçalho
					oPrintPPRA:Say( lin, 1120, STR0442, oFont10b )
					oPrintPPRA:Say( lin, 1480, STR0444, oFont10b )
					oPrintPPRA:Say( lin, 1835, STR0446, oFont10b )
				EndIf
			EndIf //Fim da impressão do cabeçalho.

			//Inicio da impressão do conteudo.
			If nModeloImp == 1 // Modelo de Impressão .doc (Word.)
				cMemo += DtoC( TJ7->TJ7_DATA ) + "#*"
				cMemo += Alltrim( TJ7->TJ7_PONTO ) + "#*"
				cMemo += Alltrim( TJ7->TJ7_TIPO ) + "#*"
				cMemo += Alltrim( TJ7->TJ7_OCUPAC ) + "#*"
				cMemo += Alltrim( TJ7->TJ7_DOSE ) + "#*"
				cMemo += Alltrim( TJ7->TJ7_UNIDAD ) + "#*"
				cMemo += cValToChar( TJ7->TJ7_DISTAN ) + "#*"
				nRegs++
			ElseIf nModeloImp == 2 // Modelo de ImpressÃ£o Padrão.
				SomaLinha()
				@ Li, 000 Psay TJ7->TJ7_DATA
				@ Li, 012 Psay Capital( TJ7->TJ7_PONTO )
				@ Li, 024 Psay Capital( TJ7->TJ7_TIPO )
				@ Li, 066 Psay TJ7->TJ7_OCUPAC
				@ Li, 080 Psay TJ7->TJ7_DOSE
				@ Li, 094 Psay TJ7->TJ7_UNIDAD
				@ Li, 103 Psay TJ7->TJ7_DISTAN
			ElseIf nModeloImp == 3 // Modelo de ImpressÃ£o Gráfico.
				SomaLinha()
				//incremento das linhas da tabela
				oPrintPPRA:Box( lin, 150 , lin + 60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 400, lin + 60, 400 ) // Linha Vertical que separa os campos
				oPrintPPRA:line( lin, 670, lin + 60, 670 ) // Linha Vertical que separa os campos
				oPrintPPRA:line( lin, 1090, lin + 60, 1090 ) // Linha Vertical que separa os campos
				oPrintPPRA:line( lin, 1430, lin + 60, 1430 ) // Linha Vertical que separa os campos
				oPrintPPRA:line( lin, 1770, lin + 60, 1770 ) // Linha Vertical que separa os campos
				oPrintPPRA:line( lin, 2040, lin + 60, 2040 ) // Linha Vertical que separa os campos
				//Incremento do campos da tabela
				oPrintPPRA:Say( lin, 170, DTOC( TJ7->TJ7_DATA ), oFont10 ) // "Data"
				oPrintPPRA:Say( lin, 420, TJ7->TJ7_PONTO, oFont10 ) // "Ponto"
				oPrintPPRA:Say( lin, 680, SubStr( AllTrim ( TJ7->TJ7_TIPO  ), 1, 14 ), oFont10 ) // "Tipo Local"
				oPrintPPRA:Say( lin, 1110, cValToChar( TJ7->TJ7_OCUPAC ), oFont10	) // "Fator Ocupação(T)"
				oPrintPPRA:Say( lin, 1450, cValToChar( TJ7->TJ7_DOSE   ), oFont10	) // "Taxa de Dose Equivalente"
				oPrintPPRA:Say( lin, 1790, cValToChar( TJ7->TJ7_UNIDAD ), oFont10	) // "Unidade Medida"
				oPrintPPRA:Say( lin, 2060, cValToChar( TJ7->TJ7_DISTAN ), oFont10	) // "Distância"
			EndIf

			TJ7->( dbSkip() )
		End // Fim da impressão do conteúdo.

		// Execução da Macro para impressão Word.
		If nModeloImp == 1 .And. !Empty( cMemo ) .And. nRegs > 1 // Modelo de ImpressÃ£o .doc (Word.)
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_SetDocumentVar( oWord, "Tabela", cMemo )
			OLE_SetDocumentVar( oWord, "Linhas", nRegs )
			OLE_ExecuteMacro( oWord, "Table_Dosimetria" ) // Cria tabela no Word de Dosimetria por Ambiente Físico.
			cMemo := ""
		EndIf
	EndIf

	RestArea( aArea )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} fBuscaFiliais
Função que busca o intervalo de filiais dos parâmetros

@type    Static function
@author  Milena Leite de Oliveira
@since   09/04/2020

@sample  fBuscaFiliais( 1 )
@param   nModeloImp, Numérico, Se é modelo word, padrão ou gráfico
@return  array, array com as filiais do intervalo dos parâmetros
/*/
//-------------------------------------------------------------------
Static Function fBuscaFiliais( nModeloImp )

	Local aFilRelat  := {}

	Local cGetDB := Upper( TcGetDb() )
	Local cLaudo := GetNextAlias()
	Local cAnoAtual := Year( Date() )
	Local cDeFilial := IIf( nModeloImp == 1, Mv_par14, Mv_par12 )
	Local cAteFilial := IIf( nModeloImp == 1, Mv_par15, Mv_par13 )
	Local cTipoLaudo := IIf( nTipoDoc == 1, '1', '6' )

	If !lSigaMdtps
		aAreaSM0 := SM0->(GetArea())

		dbSelectArea( "SM0" )
		dbGoTop()

		If Empty( cDeFilial ) // De filial
			dbSeek( cEmpAnt )
		Else
			dbSeek( cEmpAnt + cDeFilial )
		EndIf
		If Empty( Mv_par01 )

			While SM0->(!Eof()) .And. AllTrim( SM0->M0_CODIGO ) == cEmpAnt .And. AllTrim( SM0->M0_CODFIL ) <= cAteFilial

				cCodFil := FWCodFil()

				If cGetDB == 'ORACLE'

					BeginSQL Alias cLaudo
						SELECT TO0_LAUDO, TO0_DTINIC, TO0_DTFIM FROM
							%table:TO0% TO0
						WHERE
							TO0_FILIAL = %exp:cCodFil% AND
							TO0_TIPREL = %exp:cTipoLaudo% AND
							( SUBSTR( TO0_DTINIC, 1, 4 ) = %exp:cAnoAtual% OR SUBSTR( TO0_DTFIM, 1, 4 ) = %exp:cAnoAtual% ) AND
							%NotDel%
					EndSQL

				Else

					BeginSQL Alias cLaudo
						SELECT TO0_LAUDO, TO0_DTINIC, TO0_DTFIM FROM
							%table:TO0% TO0
						WHERE
							TO0_FILIAL = %exp:cCodFil% AND
							TO0_TIPREL = %exp:cTipoLaudo% AND
							( Year(TO0_DTINIC) = %exp:cAnoAtual% OR Year(TO0_DTFIM) = %exp:cAnoAtual% ) AND
							%NotDel%
					EndSQL

				EndIf

				dbSelectArea( cLaudo )
				While (cLaudo)->(!Eof())
					aAdd( aFilRelat, { cCodFil, SM0->M0_NOME, (cLaudo)->TO0_LAUDO, (cLaudo)->TO0_DTINIC,;
					IIf( !Empty( (cLaudo)->TO0_DTFIM ), (cLaudo)->TO0_DTFIM, DToS( dDatabase ) ) } )

					(cLaudo)->(dbSkip())
				End
				( cLaudo )->( dbCloseArea() )

				SM0->(dbSkip())
			End
		Else
			cCodFil := xFilial('TO0')

			dbSelectArea( 'TO0' )
			dbSetOrder( 1 )
			dbSeek( xFilial('TO0') + Mv_par01 )
			aAdd( aFilRelat, { cCodFil, SM0->M0_NOME, TO0->TO0_LAUDO, DToS( TO0->TO0_DTINIC ),;
			IIf( !Empty( TO0->TO0_DTFIM ) , DToS( TO0->TO0_DTFIM ) , DToS( dDatabase ) ) } )

		EndIf

		RestArea( aAreaSM0 )

	Else

		aAdd( aFilRelat, { cFilAnt, SM0->M0_NOME, Mv_par06, Mv_par07 } )
		//Se não existir os parametros de C.C., trata
		If !lMdtUmCC .And. !lMdtCC
			If Type( "mv_par07" ) == "N"
				mv_par09 := mv_par07
			EndIf
			If Type( "mv_par06" ) == "N"
				mv_par08 := mv_par06
			EndIf
		ElseIf lMdtUmCC
			If Type( "mv_par08" ) == "N"
				mv_par09 := mv_par08
			EndIf
			If Type( "mv_par07" ) == "N"
				mv_par08 := mv_par07
			EndIf
		EndIf

		nImpImage := mv_par11
		lImpTodos := mv_par10
		cCliMdtps := Mv_par01+Mv_par02

	EndIf

Return aFilRelat

//-------------------------------------------------------------------
/*/{Protheus.doc} A850EQPRAD
Imprime os Equipamentos Radiologicos

@return	Nil, Nulo

@sample	A850EQPRAD()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
Static Function A850EQPRAD()

    Local cLaudo := IIf( lSigaMdtPs, mv_par03, cCodLaudo )
    Local aEquip := {}
	Local aCarac := {}
	Local cEquip
	Local cNomFam
	Local cDesMod
	Local cNomFab
    Local nE
	Local nC

    dbSelectArea( "TI9" )
    dbGoTop()
    If dbSeek( xFilial( "TI9", cFil ) + cLaudo )
        While !Eof() .And. xFilial( "TI9", cFil ) == TI9->TI9_FILIAL .And. TI9->TI9_LAUDO == cLaudo
            
			cEquip := TI9->TI9_CODEQP
            
			dbSelectArea( "ST9" )
            dbSetOrder( 1 )
            If dbSeek( xFilial( "ST9", cFil ) + Alltrim( cEquip ) )

                cNomFam := NGSEEK( "ST6", ST9->T9_CODFAMI, 1, 'ST6->T6_NOME' )
                cDesMod := NGSEEK( "TQR", ST9->T9_TIPMOD, 1, 'TQR->TQR_DESMOD' )
                cNomFab := NGSEEK( "ST7", ST9->T9_FABRICA, 1, 'ST7->T7_NOME' )

                dbSelectArea( "STB" )
                dbSetOrder( 1 )
                If dbSeek( xFilial( "STB", cFil ) + Alltrim( cEquip ) )

                    aCarac := {}

                    While !Eof() .And. cEquip == STB->TB_CODBEM
                        cNomCarac := NGSEEK( "TPR", STB->TB_CARACTE, 1, "TPR->TPR_NOME" )
						aAdd( aCarac, { STB->TB_CARACTE, cNomCarac, STB->TB_CONDOP, STB->TB_DETALHE, STB->TB_INFO02, STB->TB_UNIDADE } )
                        dbSelectArea( "STB" )
                        dbSkip()
                    End

                EndIf

                aAdd( aEquip, { ST9->T9_CODBEM, ST9->T9_NOME, cNomFam, cDesMod, cNomFab, ST9->T9_SERIE, TI9->TI9_DESCRI, aClone( aCarac ) } )
				
            EndIf
            dbSelectArea( "TI9" )
            dbSkip()
        End
    EndIf

    For nE := 1 To Len( aEquip )

        If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

            Somalinha()
            U_IMPHEA850( "{N}" + STR0528, .T., .F. ) //"Equipamento"
            U_IMPDOC850( aEquip[nE][1] + " " + aEquip[nE][2], .F. )
            U_IMPHEA850( "{N}" + STR0529, .T., .F. ) //"Família"
            U_IMPDOC850( aEquip[nE][3], .F. )
            U_IMPHEA850( "{N}" + STR0530, .T., .F. ) //"Modelo"
            U_IMPDOC850( aEquip[nE][4], .F. )
            U_IMPHEA850( "{N}" + STR0531, .T., .F. ) //"Marca"
            U_IMPDOC850( aEquip[nE][5], .F. )
            U_IMPHEA850( "{N}" + STR0532, .T., .F. ) //"Série"
            U_IMPDOC850( aEquip[nE][6], .F. )

            If !Empty( aEquip[nE][8] )
                For nC := 1 To Len( aEquip[nE][8] )
                    U_IMPHEA850( "{N}" + Capital( Alltrim( aEquip[nE][8][nC][2] ) ), .T., .F. )
                    If Alltrim( aEquip[nE][8][nC][3] ) == '1'
                        U_IMPDOC850( Alltrim( aEquip[nE][8][nC][4] ) + " " + Alltrim( aEquip[nE][8][nC][6] ), .F. )
                    Else
                        U_IMPDOC850( Upper( Alltrim( NGRetSX3Box( "TB_CONDOP", aEquip[nE][8][nC][3] ) ) ) + " " +;
                            AllTrim( aEquip[nE][8][nC][4] ) + " ~ " + AllTrim( aEquip[nE][8][nC][5] ) + " " +;
                            AllTrim( aEquip[nE][8][nC][6] ), .F.)
                    EndIf
                Next nC
            EndIf

        ElseIf nModeloImp == 2 //Modelo de Impressão padrão

            Somalinha()
            @ Li,000 PSay STR0528 + ": " + AllTrim( aEquip[nE][1] ) + " - " + STR0534 + " " + aEquip[nE][2] //"Descrição"+"Equipamento"
            Somalinha()
            @ Li,000 PSay STR0529 + "....: " + aEquip[nE][3] //"Familia"
            Somalinha()
            @ Li,000 PSay STR0530 + ".....: " + aEquip[nE][4] //"Modelo"
            Somalinha()
            @ Li,000 PSay STR0531 + "......: " + aEquip[nE][5] //"Marca"
            Somalinha()
            @ Li,000 PSay STR0532 + "......: " + aEquip[nE][6] //"Série"
            Somalinha()

            If !Empty( aEquip[nE][8] )
                For nC := 1 To Len( aEquip[nE][8] )
                    //Verifica se a opção é Igual ('1') ou Entre ('2')
                    If Alltrim( aEquip[nE][8][nC][3] ) == '1'
                        @ Li, 000 PSay( AllTrim( Capital( aEquip[nE][8][nC][2] ) ) ) + ": " + ;
                            AllTrim( aEquip[nE][8][nC][4] ) + " " + AllTrim( aEquip[nE][8][nC][6] )
                    Else
                        @ Li, 000 PSay( AllTrim( Capital( aEquip[nE][8][nC][2] ) ) ) + ": " + ;
                            Alltrim( NGRetSX3Box( "TB_CONDOP", aEquip[nE][8][nC][3]) ) + " " + ;
                            AllTrim( aEquip[nE][8][nC][4] ) + " ~ " + AllTrim( aEquip[nE][8][nC][5] ) + " " + ;
                            AllTrim( aEquip[nE][8][nC][6] )
                    EndIf
                    Somalinha()
                Next nC
            EndIf

            Somalinha()

        ElseIf nModeloImp == 3 //Modelo de Impressão grafico

            Somalinha()
            oPrintPPRA:Say( lin + 10, 170, STR0528 + ":", oFont08b ) //"Equipamento:"
            oPrintPPRA:Say( lin + 10, 420, AllTrim( aEquip[nE][1] ) + " " + aEquip[nE][2], oFont08 )

            Somalinha()
            oPrintPPRA:Say( lin + 10, 170, STR0529 + ".........:", oFont08b ) //"Família"
            oPrintPPRA:Say( lin + 10, 420, aEquip[nE][3], oFont08 )

            Somalinha()
            oPrintPPRA:Say( lin + 10, 170, STR0530 + ".........:", oFont08b ) //"Modelo"
            oPrintPPRA:Say( lin + 10, 420, aEquip[nE][4], oFont08 )

            Somalinha()
            oPrintPPRA:Say( lin + 10, 170, STR0531 + "...........:", oFont08b ) //"Marca"
            oPrintPPRA:Say( lin + 10, 420, aEquip[nE][5], oFont08 )

            Somalinha()
            oPrintPPRA:Say( lin + 10, 170, STR0532 + "............:", oFont08b ) //"Série"
            oPrintPPRA:Say( lin + 10, 420, aEquip[nE][6], oFont08 )

            Somalinha()

            If !Empty( aEquip[nE][8] )
                For nC := 1 To Len( aEquip[nE][8] )
                    If Alltrim( aEquip[nE][8][nC][3] ) == '1'
                        oPrintPPRA:Say( lin + 10, 170, Alltrim( Capital( aEquip[nE][8][nC][2] ) ) + ": ", oFont08b )
                        oPrintPPRA:Say( lin + 10, 170 + ( (Len( Alltrim( aEquip[nE][8][nC][2] ) ) + 1 ) * 20 ) + 20, Alltrim( aEquip[nE][8][nC][4] ) + " " + aEquip[nE][8][nC][6], oFont08 )
                    Else
                        oPrintPPRA:Say( lin + 10, 170, Alltrim( Capital( aEquip[nE][8][nC][2] ) ) + ": ", oFont08b )
                        oPrintPPRA:Say( lin + 10, 170 + ( (Len( Alltrim( aEquip[nE][8][nC][2] ) ) + 1 ) * 20 ) + 20, Alltrim( NGRetSX3Box( "TB_CONDOP", aEquip[nE][8][nC][3] ) ) + " " + ;
                            AllTrim( aEquip[nE][8][nC][4] ) + " ~ " + AllTrim( aEquip[nE][8][nC][5] ) + " " + ;
                            AllTrim( aEquip[nE][8][nC][6] ), oFont08 )
                    EndIf
                    Somalinha()
                Next nC
            EndIf

            Somalinha()
        EndIf
    Next nE

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850ESTLOC
Imprime a estrutura dos locais

@return	Nil, Nulo

@sample	A850ESTLOC()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
Static Function A850ESTLOC()

	Local cLaudo := IIf( lSigaMdtPs, mv_par03, cCodLaudo )
	Local nQtd	:= 1
	Local nEst	:= 0
	Local nCmp	:= 0
	Local nCol	:= 0
	Local nCont	:= 1
	Local cMemo := ""
	Local lPri	:= .T.
	Local aCmp	:= { "TNE_NAT", "TNE_ESP", "TNE_UNI", "TNE_LOC" }
	Local aEst	:= { { "PAR", STR0535 }, ; //"Parede"
					{ "PIS", STR0536 }, ; //"Piso"
					{ "TET", STR0537 }, ; //"Teto"
					{ "POR", STR0538 }, ; //"Porta"
					{ "RE1", STR0539 }, ; //"Revestimento 1"
					{ "RE2", STR0540 }, ; //"Revestimento 2"
					{ "VIS", STR0541 } } //"Visor"
	Local aColumms := { 20, 40, 20, 0 }
	Local aPosInf  := { 170, 500, 830, 1160 }
	Local oBrush1  := TBrush():New( , RGB( 229, 229, 229 ) ) //Objeto que preenche campos coloridos, Modelo Grafico.

	cMemo += STR0542 + "#*" //"Estrutura"
	cMemo += STR0543 + "#*" //"Natureza"
	cMemo += STR0544 + "#*" //"Espessura"
	cMemo += STR0545 + "#*" //"Localização"

	dbSelectArea( "TO5" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TO5", cFil ) + cLaudo )
	While TO5->( !Eof() ) .And. TO5->TO5_FILIAL == xFilial( "TO5", cFil ) .And. TO5->TO5_LAUDO == cLaudo

		dbSelectArea( "TNE" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TNE", cFil ) + TO5->TO5_CODAMB )
		SomaLinha()
		
		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
			U_IMPHEA850( "{N}" + STR0546 + ":" ) //"Ambiente Físico"
			U_IMPDOC850( TNE->TNE_NOME )

		ElseIf nModeloImp == 2 //Modelo de Impressão padrão
			SomaLinha()
			@ Li,019 Psay STR0546 + ":" //"Ambiente Físico"
			@ Li,037 Psay TNE->TNE_NOME
			
		ElseIf nModeloImp == 3 //Modelo de Impressão grafico
			SomaLinha()
			oPrintPPRA:Say( lin, 165, STR0546 + ":", oFont10b ) //"Ambiente Físico"
			oPrintPPRA:Say( lin, 525, TNE->TNE_NOME, oFont10 )
			SomaLinha()
		EndIf

		SomaLinha()
		For nEst := 1 To Len( aEst )
			cMemo += aEst[ nEst, 2 ] + "#*"
			For nCmp := 1 To Len( aCmp )
				If "LOC" $ aCmp[ nCmp ] .And. aEst[ nEst , 1 ] == "TET"
					cMemo += "-|-#*"
				Else
					If "NAT" $ aCmp[ nCmp ]
						cMemo += X3Combo( aCmp[ nCmp ] + aEst[ nEst, 1 ], &( aCmp[ nCmp ] + aEst[ nEst, 1 ] ) )
					Else
						cMemo += AllTrim( cValToChar( &( aCmp[ nCmp ] + aEst[ nEst, 1 ] ) ) ) + Space( 1 )
					EndIf
					If !( "ESP" $ aCmp[ nCmp ] )
						cMemo += "#*"
					EndIf
				EndIf
			Next nCmp
			nQtd++
		Next nEst

		cMemo := StrTran( cMemo, "#*#*", "#* #*" )

		If nModeloImp == 1 // Modelo de Impressão .doc (Word.)

			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_SetDocumentVar( oWord, "Tabela", cMemo )
			OLE_SetDocumentVar( oWord, "Linhas", nQtd )
			OLE_ExecuteMacro( oWord, "Table_Estrutura" ) //Cria tabela no Word de Estrutura por Ambiente Físico.

		ElseIf nModeloImp == 2 .Or. nModeloImp == 3 //Modelo de Impressão padrão ou grafico

			While !Empty( cMemo )
				nAt := At( "#*", cMemo )
				cTextImp := SubStr( cMemo, 1, nAt - 1 )
				cMemo := SubStr( cMemo, nAt + 2 )

				If nModeloImp == 2 //Modelo de Impressão padrão
					@ Li, nCol Psay cTextImp
				ElseIf nModeloImp == 3 //Modelo de Impressão grafico
					aPosInf	:= IIf( lPri, { 220, 550, 870, 1560 }, { 170, 500, 830, 1160 } )
					If nCont == 1
						If lin + 120 > 3000
							Somalinha( 120 )
						EndIf
						If lPri
							//Destaca linha
							oPrintPPRA:FillRect( { lin, 150, lin + 60, 2300 }, oBrush1 )
							oBrush1:End()
						EndIf
						//Monta tabela do cabeçalho
						oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
						oPrintPPRA:line( lin, 480, lin + 60, 480 ) // Linha Vertical que separa os campos
						oPrintPPRA:line( lin, 810, lin + 60, 810 ) // Linha Vertical que separa os campos
						oPrintPPRA:line( lin, 1140, lin + 60, 1140 ) // Linha Vertical que separa os campos
					EndIf
					//Comteúdo do cabeçalho
					oPrintPPRA:Say( lin, aPosInf[ nCont ], cTextImp, IIf( lPri, oFont10b, oFont10 ) )
				EndIf
				nCol += aColumms[ nCont ]
				nCont++
				If nCont > 4
					lPri := .F.
					SomaLinha()
					nCol := 000
					nCont := 1
				EndIf
			End
		EndIf
		nQtd  := 1
		cMemo := ""
		cMemo += STR0542 + "#*" //"Estrutura"
		cMemo += STR0543 + "#*" //"Natureza"
		cMemo += STR0544 + "#*" //"Espessura"
		cMemo += STR0545 + "#*" //"Localização"
		lPri  := .T.
		TO5->( dbSkip() )
	End

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850PGRFUN
Imprime atalho PGR - Funcionarios

@return	Nil, Nulo

@sample	U_A850PGRFUN()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
User Function A850PGRFUN()

	Local cLaudo	:= IIf( lSigaMdtPs, mv_par03, cCodLaudo )
	Local oBrush1	:= TBrush():New( , RGB( 229, 229, 229 ) ) //Objeto que preenche campos coloridos, Modelo Grafico.
	Local lDepto	:= NGCADICBASE( "TN0_DEPTO", "A" , "TN0" , .F. )
	Local nFuncPPR	:= 1
	Local cFuncPPR	:= ""
	Local aFunc		:= {}
	Local cProgSaude
	Local cNome
	Local cCPF
	Local cCodSet
	Local cCargo
	Local cCodFun
	Local cDescFun
	Local cDescSet
	Local cMat
	Local cDepto
	Local cDeparta
	Local nF

	dbSelectArea( "TIA" )
	If dbSeek( xFilial( "TIA", cFil ) + cLaudo )
		While !Eof() .And. TIA->TIA_LAUDO == cLaudo
			cProgSaude := TIA->TIA_CODPRO
			dbSelectArea( "TMN" )
			dbSetOrder( 1 )
			If dbSeek( xFilial( "TMN", cFil ) + Alltrim( cProgSaude ) )
				While !Eof() .And. TMN->TMN_CODPRO == cProgSaude
					cMat     := NGSEEK( "TM0", TMN_NUMFIC, 1, 'TM0->TM0_MAT' ) //Matrícula
					cNome    := Capital( NGSEEK( "SRA", cMat, 1, 'SRA->RA_NOME' ) ) //Nome
					cCPF     := NGSEEK( "SRA", cMat, 1, 'SRA->RA_CIC' ) //CPF
					cCodFun  := NGSEEK( "SRA", cMat, 1, 'SRA->RA_CODFUNC' ) //Código da Função
					cDescFun := NGSEEK( "SRJ", cCodFun, 1, 'SRJ->RJ_DESC' ) //Descrição da Função
					cCargo   := NGSEEK( "SRA", cMat, 1, 'SRA->RA_CARGO' ) // Código do Cargo
					cDescCar := NGSEEK( "SQ3", cCargo, 1, 'SQ3->Q3_DESCSUM' ) //Descrição do Cargo
					cCodSet  := NGSEEK( "TM0", TMN_NUMFIC, 1, 'TM0->TM0_CC' ) //Código do Centro de Custo
					cDescSet := NGSEEK( "CTT", cCodSet, 1, 'CTT_DESC01' ) //Descrição do Centro de Custo
					If lDepto
						cDeparta := NGSEEK( "SRA", cMat, 1, 'SRA->RA_DEPTO' ) //Código do Departamento
						cDepto 	 := NGSEEK( "SQB", cDeparta, 1, 'SQB->QB_DESCRIC' ) //Descrição do Departamento
					EndIf
					If !Empty( cMat ) .And. lDepto
						aAdd( aFunc, { cLaudo, cNome, cCPF, cDescFun, cDescCar, cDescSet, cDepto } )
					ElseIf !Empty( cMat )
						aAdd( aFunc, { cLaudo, cNome, cCPF, cDescFun, cDescCar, cDescSet } )
					EndIf
					TMN->( dbSkip() )
				End
			EndIf
			TIA->( dbSkip() )
		End
	EndIf

	If Len( aFunc ) < 1
		Return .F.
	EndIf

	If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
		cFuncPPR += STR0547 + "#*" //"Nome do Funcionário"
		cFuncPPR += STR0548 + "#*" //"CPF"
		cFuncPPR += STR0549 + "#*" //"Função"
		cFuncPPR += STR0550 + "#*" //"Cargo"
		If lDepto .And. Mv_par05 == 2 //Departamento
			cFuncPPR += STR0551 + "#*" //"Departamento"
		Else
			cFuncPPR += STR0092 + "#*" //"Centro de Custo"
		EndIf
	EndIf

	For nF := 1 To Len( aFunc )
		
		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

			cFuncPPR += AllTrim( aFunc[nF][2] ) + "#*"
			cFuncPPR += AllTrim( aFunc[nF][3] ) + "#*"
			cFuncPPR += AllTrim( aFunc[nF][4] ) + "#*"
			cFuncPPR += AllTrim( aFunc[nF][5] ) + "#*"
			If lDepto .And. Mv_par05 == 2
				cFuncPPR += AllTrim( aFunc[nF][7] ) + "#*"
			Else
				cFuncPPR += AllTrim( aFunc[nF][6] ) + "#*"
			EndIf
			nFuncPPR++

		ElseIf nModeloImp == 2 //Modelo de Impressão padrão
			/*
			********************************************************************************************
			0         1         2         3         4         5         6         7         8         9
			01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
			********************************************************************************************
			Nome do Funcionário        CPF          Função            Cargo          Centro de Custo
			xxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx  xxxxxxxxxxxxxxxx  xxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx
			xxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx  xxxxxxxxxxxxxxxx  xxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx
			xxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx  xxxxxxxxxxxxxxxx  xxxxxxxxxxxxx  xxxxxxxxxxxxxxxxx
			*/
			If nF == 1
				Somalinha()
				@ Li, 000 PSay STR0547 //"Nome do Funcionário"
				@ Li, 027 PSay STR0548 //"CPF"
				@ Li, 040 PSay STR0549 //"Função"
				@ Li, 058 PSay STR0550 //"Cargo"
				If lDepto .And. Mv_par03 == 2
					@ Li, 073 PSay STR0551 //"Departamento"
				Else
					@ Li, 073 PSay STR0092 //"Centro de Custo"
				EndIf
			EndIf
			Somalinha()
			@ Li, 000 PSay SubStr( aFunc[nF][2], 1, 25 )
			@ Li, 027 PSay aFunc[nF][3]
			@ Li, 040 PSay SubStr( aFunc[nF][4], 1, 17 )
			@ Li, 058 PSay SubStr( aFunc[nF][5], 1, 13 )
			If lDepto .And. Mv_par03 == 2
				@ Li,073 PSay SubStr( aFunc[nF][7], 1, 17 )
			Else
				@ Li,073 PSay SubStr( aFunc[nF][6], 1, 17 )
			EndIf

		ElseIf nModeloImp == 3 //Modelo de Impressão grafico

			If nF == 1
				If lin + 120 > 3000
					Somalinha( 120 )
				EndIf
				Somalinha()
				oPrintPPRA:FillRect( { lin, 150, lin + 60, 2370 }, oBrush1 )
				oBrush1:End()
				oPrintPPRA:Box( lin, 150, lin + 60, 2370 )
				oPrintPPRA:Line( lin, 700, lin + 60, 700 )
				oPrintPPRA:Line( lin, 940, lin + 60, 940 )
				oPrintPPRA:Line( lin, 1470, lin + 60, 1470 )
				oPrintPPRA:Line( lin, 1870, lin + 60, 1870 )
				oPrintPPRA:Say( lin + 10, 260, STR0547, oFont08b ) //"Nome do Funcionário"
				oPrintPPRA:Say( lin + 10, 790, STR0548, oFont08b ) //"CPF"
				oPrintPPRA:Say( lin + 10, 1020, STR0549, oFont08b ) //"Função"
				oPrintPPRA:Say( lin + 10, 1500, STR0550, oFont08b ) //"Cargo"
				If lDepto .And. Mv_par03 == 2
					oPrintPPRA:Say( lin + 10, 2060, STR0551, oFont08b ) //"Departamento"
				Else
					oPrintPPRA:Say( lin + 10, 2060, STR0092, oFont08b ) //"Centro de Custo"
				EndIf
			EndIf
			Somalinha()
			If lin == 300
				oPrintPPRA:Line( lin, 150, lin, 2370 )
			EndIf
			oPrintPPRA:Line( lin, 150, lin + 60, 150 )
			oPrintPPRA:Line( lin, 700, lin + 60, 700 )
			oPrintPPRA:Line( lin, 940, lin + 60, 940 )
			oPrintPPRA:Line( lin, 1470, lin + 60, 1470 )
			oPrintPPRA:Line( lin, 1870, lin + 60, 1870 )
			oPrintPPRA:Line( lin, 2370, lin + 60, 2370 )
			oPrintPPRA:Line( lin+ 60, 150, lin + 60, 2370 )

			oPrintPPRA:Say( lin + 10, 170, SubStr( aFunc[nF][2], 1, 25 ), oFont08 )
			oPrintPPRA:Say( lin + 10, 720, aFunc[nF][3], oFont08 )
			oPrintPPRA:Say( lin + 10, 960, SubStr( aFunc[nF][4], 1, 17 ), oFont08 )
			oPrintPPRA:Say( lin + 10, 1490, SubStr( aFunc[nF][5], 1, 13 ), oFont08 )
			If lDepto .And. Mv_par03 == 2
				oPrintPPRA:Say( lin + 10, 1890, SubStr( aFunc[nF][7], 1, 17 ), oFont08 )
			Else
				oPrintPPRA:Say( lin + 10, 1890, SubStr( aFunc[nF][6], 1, 17 ), oFont08 )
			EndIf
		EndIf
	Next nF

	If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_SetDocumentVar( oWord, "Tabela", cFuncPPR )
		OLE_SetDocumentVar( oWord, "Linhas", nFuncPPR )
		OLE_ExecuteMacro( oWord, "Table_Func_PGR" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
	Else
		Somalinha()
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850PGRXPE
Imprime atalho PGR x PE

@return	Nil, Nulo

@sample	A850PGRXPE()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
Static Function A850PGRXPE()

	Local aArea	  := GetArea()
	Local cLaudo  := IIf( lSigaMdtPs, mv_par03, cCodLaudo )
	Local oBrush1 := TBrush():New( , RGB( 229, 229, 229 ) ) //Objeto que preenche campos coloridos, Modelo Grafico.
	Local cMemo	  := ""
	Local nRegs	  := 0
	Local LinhaCorrente := 0

	If nModeloImp == 1 //Modelo de impressão .doc

		dbSelectArea( "TJG" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TJG", cFil ) + cLaudo )
			//Impressao do título de Plano Emergencial
			cVar1 := "cTXT" + Strzero( nVar1, 6 )
			OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
			nVar1++
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_ExecuteMacro( oWord, "Cria_Texto" )
			OLE_SetDocumentVar( oWord, cVar1, STR0552 + ":" )
			OLE_ExecuteMacro( oWord, "Somalinha" )

			While TJG->( !Eof() ) .And. TJG->TJG_FILIAL == xFilial( "TJG", cFil ) .And. TJG->TJG_LAUDO == cLaudo
				dbSelectArea( "TBB" )
				dbSetOrder( 1 ) //TJK_FILIAL+TJK_CODPLA
				dbSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
				nRegs := 0
				cMemo += STR0552 + ":" + "#*" + TBB->TBB_CODPLA + " - " + Capital( TBB->TBB_DESPLA ) + "#*" //"Plano Emergencial"
				nRegs ++

				If TBB->TBB_TIPELA == '1' // Usuário

					cMemo += STR0553 + ":" + "#*" + Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) ) + "#*" //"Elaborador:"
					nRegs ++

				Else // Funcionário

					cMemo += STR0553 + ":" + "#*" + Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_ELABOR), 1, "RA_NOME" ) ) + "#*" //"Elaborador:"
					nRegs ++

				EndIf

				If TBB->TBB_TIPRES == '1' // Usuário

					cMemo += STR0554 + ":" + "#*" + Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) ) +"#*" //"Responsável:"
					nRegs ++

				Else // Funcionário

					cMemo += STR0554 + ":" + "#*" + Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_RESPON), 1, "RA_NOME" ) ) +"#*" //"Responsável:"
					nRegs ++

				EndIf

				If !Empty( TBB->TBB_OBSPLA )
					cMemo += STR0555 + ":" + "#*" + Capital( TBB->TBB_OBSPLA ) + "#*" //"Observações:"
					nRegs ++
				Else
					cMemo += STR0555 + ":" + "#*" + "" + "#*" //"Observações:"
					nRegs ++
				EndIf
				cMemo += STR0556 + ":" + "#*" + Capital( TAF->TAF_NOMNIV ) + "#*" //"Processos:"
				nRegs ++

				dbSelectArea( "TBO" ) // "Ações:"
				dbSetOrder( 1 ) //TJS_FILIAL+TJS_CODPLA+TJS_CODACA
				dbGoTop()
				dbSeek( xFilial( "TBO", cFil ) + TBB->TBB_CODPLA )
				// Percorre a Tabela TJS e imprime as acoes.
				While !Eof() .And. TBO->TBO_FILIAL == xFilial("TBO", cFil) .And. TBO->TBO_CODPLA == TBB->TBB_CODPLA
					nRegs ++
					cMemo += "Ações" + ":" + "#*" + Alltrim( TBO->TBO_CODACA ) + " - " + Alltrim( TBO->TBO_DESACA ) + "#*" //"Ações:"
					dbSelectArea( "TBO" )
					dbSkip()
				End

				// Percorre a Tabela TJT e imprime os Participantes.
				dbSelectArea( "TBP" )
				dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
				dbGoTop()
				dbSeek( xFilial( "TBP", cFil ) + TBB->TBB_CODPLA )
				While !Eof() .And. TBP->TBP_FILIAL == xFilial( "TBP", cFil ) .And. TBP->TBP_CODPLA == TBB->TBB_CODPLA
					nRegs ++
					cMemo += "Participantes" + ":" + "#*" + Alltrim( TBP->TBP_CODPAR ) + " - " + NGSEEK( "SRA", AllTrim(TBP->TBP_CODPAR), 1, "RA_NOME" ) + "#*" //"Participantes:"
					dbSelectArea( "TBP" )
					dbSkip()
				End

				// Percorre a Tabela TJW e imprime os Contatos Externos.
				dbSelectArea( "TBU" )
				dbSetOrder( 1 ) //TJW_FILIAL+TJW_CODPLA+TJW_CODCON
				dbGoTop()
				dbSeek( xFilial( "TBU", cFil ) + TBB->TBB_CODPLA)
				If !Empty( TBU->TBU_CODPLA )
					While !Eof() .And. TBU->TBU_FILIAL == xFilial( "TBU", cFil ) .And. TBU->TBU_CODPLA == TBB->TBB_CODPLA
						nRegs ++
						cMemo += "Contatos Externos" + ":" + "#*" + Alltrim( TBU->TBU_CODCON ) + " - " + Alltrim( TBU->TBU_DESCON ) + Space( 05 ) + "Fone" + Alltrim( TBU->TBU_FONE ) + "#*" //"Contatos Externos:" -  "Fone:"
						dbSelectArea( "TBU" )
						dbSkip()
					End
				Else
					nRegs ++
					cMemo += "Contatos Externos" + ":" + "#*" + "" + "#*" //"Contatos Externos:" -  "Fone:"
				EndIf

				cVar1 := "cTXT" + Strzero( nVar1, 6 )
				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
				nVar1++
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_SetDocumentVar( oWord, "Tabela", cMemo )
				OLE_SetDocumentVar( oWord, "Linhas", nRegs )
				OLE_ExecuteMacro( oWord, "Table_PGRXPE" ) // Cria tabela do PGR x Plano Emergencial.
				OLE_ExecuteMacro( oWord, "Somalinha" )
				cMemo := ""
				dbSelectArea( "TJG" )
				TJG->( dbSkip() )
			End
		EndIf

	ElseIf nModeloImp == 2  //Modelo de impressão padrão.

		dbSelectArea( "TJG" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TJG", cFil ) + cLaudo )
			@ Li, 000 Psay STR0552 + ":" //"Plano Emergencial:"
			SomaLinha()
			While TJG->( !Eof() ) .And. TJG->TJG_FILIAL == xFilial( "TJG", cFil ) .And. TJG->TJG_LAUDO == cLaudo
				dbSelectArea( "TBB" )
				dbSetOrder( 1 ) //TJK_FILIAL+TJK_CODPLA
				dbSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
				SomaLinha()
				@ Li, 005 Psay STR0552 + ":" //"Plano Emergencial:"
				@ Li, 025 Psay Capital( TBB->TBB_CODPLA )
				@ Li, 032 Psay " - " //" - "
				@ Li, 035 Psay Capital( TBB->TBB_DESPLA )
				SomaLinha()

				@ Li, 005 Psay STR0553 + ":" //"Elaborador:"

				If TBB->TBB_TIPELA == '1' // Usuário

					@ Li, 025 Psay Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) )

				Else // Funcionário

					@ Li, 025 Psay Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_ELABOR), 1, "RA_NOME" ) )

				EndIf

				SomaLinha()

				@ Li, 005 Psay STR0554 + ":" //"Responsável:"

				If TBB->TBB_TIPRES == '1' // Usuário

					@ Li, 025 Psay Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) )

				Else // Funcionário

					@ Li, 025 Psay Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_RESPON), 1, "RA_NOME" ) )

				EndIf

				SomaLinha()
				If !Empty( TBB->TBB_OBSPLA )
					nLinhasMemo := MLCOUNT( TBB->TBB_OBSPLA, 100 )
					@ Li, 005 Psay STR0555 + ":" //"Observações:"
					For LinhaCorrente := 1 To nLinhasMemo
						@ Li, 025 Psay MemoLine( TBB->TBB_OBSPLA, 100, LinhaCorrente )
						SomaLinha()
					Next
				Else
					@ Li, 005 Psay STR0555 + ":" //"Observações:"
					SomaLinha()
				EndIf
				@ Li, 005 Psay STR0556 + ":" //"Processos:"
				@ Li, 025 Psay Capital( TAF->TAF_NOMNIV )
				SomaLinha()
				//ACOES
				@ Li, 005 Psay "Ações" + ":" //"Ações:"
				dbSelectArea( "TJS" )
				dbSetOrder( 1 ) //TJS_FILIAL+TJS_CODPLA+TJS_CODACA
				dbGoTop()
				If dbSeek( xFilial( "TJS", cFil ) + TJK->TJK_CODPLA )
					While !Eof() .And. TJS->TJS_FILIAL == xFilial( "TJS", cFil ) .And. TJS->TJS_CODPLA == TJK->TJK_CODPLA
						@ Li,025 Psay Capital( TJS->TJS_CODACA ) + " - " + Capital( TJS->TJS_DESACA )
						SomaLinha()
						dbSelectArea("TJS")
						dbSkip()
						Loop
					End //Finaliza While que percorre a Tabela (TJS)
				Else
					SomaLinha()
				Endif
				//PARTICIPANTES
				@ Li, 005 Psay "Participantes" + ":" //"Participantes:"
				dbSelectArea( "TJT" )
				dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
				dbGoTop()
				If dbSeek( xFilial( "TJT", cFil ) + TJK->TJK_CODPLA )
					While !Eof() .And. TJT->TJT_FILIAL == xFilial( "TJT", cFil ) .And. TJT->TJT_CODPLA == TJK->TJK_CODPLA
						@ Li, 025 Psay Capital( TJT->TJT_CODPAR ) + " - " + Capital( NGSEEK( "SRA", TJT->TJT_CODPAR, 1, "RA_NOME" ) ) //"Participantes:"
						SomaLinha()
						dbSelectArea( "TJT" )
						dbSkip()
						Loop
					End //Finaliza While que percorre a Tabela (TJT)
				Else
					SomaLinha()
				EndIf
				//CONTATOS EXTERNOS
				@ Li, 005 Psay "Contatos Externos" + ":" //"Contatos Externos:"
				dbSelectArea( "TJW" )
				dbSetOrder( 1 ) //TJW_FILIAL+TJW_CODPLA+TJW_CODCON
				dbGoTop()
				dbSeek( xFilial( "TJW", cFil ) + TJK->TJK_CODPLA )
				While !Eof() .And. TJW->TJW_FILIAL == xFilial( "TJW", cFil ) .And. TJW->TJW_CODPLA == TJK->TJK_CODPLA
					@ Li, 025 Psay Capital( TJW->TJW_CODCON ) + " - " + Capital( TJW->TJW_DESCON )
					@ Li, 085 Psay "Fone" + ": " + Capital( TJW->TJW_FONE ) //"Fone"
					SomaLinha()
					dbSelectArea( "TJW" )
					dbSkip()
					Loop
				End //Finaliza While que percorre a Tabela (TJW)
				SomaLinha()
				dbSelectArea( "TJG" )
				TJG->( dbSkip() )
			End //Finaliza While que percorre a Tabela (TJG)
		EndIf

	ElseIf nModeloImp == 3  //Modelo de impressão gráfico.

		dbSelectArea( "TJG" )
		dbSetOrder( 1 )
		If dbSeek( xFilial( "TJG", cFil ) + cLaudo )
			SomaLinha()
			oPrintPPRA:Say( lin, 165, STR0552 + ":", oFont10 ) //"Plano Emergencial:"
			SomaLinha()
			While TJG->( !Eof() ) .And. TJG->TJG_FILIAL == xFilial( "TJG", cFil ) .And. TJG->TJG_LAUDO == cLaudo
				dbSelectArea( "TBB" )
				dbSetOrder( 1 ) //TJK_FILIAL+TJK_CODPLA
				dbSeek( xFilial( "TBB", cFil ) + TJG->TJG_CODPLA )
				If lin + 120 > 3000
					Somalinha( 120 )
				EndIf
				Somalinha()
				oPrintPPRA:FillRect( { lin, 150, lin + 60, 2300 }, oBrush1 )
				oBrush1:End()
				oPrintPPRA:Box( lin, 150, lin+60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 600, lin+60, 600 ) // Linha Vertical que separa os campos
				oPrintPPRA:Say( lin, 300, "Campo", oFont10b ) // "Campo"
				oPrintPPRA:Say( lin, 1250, "Conteudo", oFont10b ) // "Conteudo"
				Somalinha()
				oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
				oPrintPPRA:Say( lin, 165, STR0552 + ":", oFont10b ) //"Plano Emergencial:"
				oPrintPPRA:Say( lin, 620, Capital( TBB->TBB_CODPLA ), oFont10 ) // "Código"
				oPrintPPRA:Say( lin, 770, "Código", oFont10 )
				oPrintPPRA:Say( lin, 920, Capital( Substr( TBB->TBB_DESPLA, 1, 50) ), oFont10 ) // "Descrição"
				Somalinha()
				//Elaborador
				oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
				oPrintPPRA:Say( lin, 165, STR0553 + ":", oFont10b ) // "Elaborador:"

				If TBB->TBB_TIPELA == '1' // Usuário
					
					oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_ELABOR ), 1 ,"QAA_NOME", cFil ) ), oFont10 )

				Else // Funcionário

					oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_ELABOR), 1, "RA_NOME" ) ), oFont10 )

				EndIf

				Somalinha()
				//Responsavel
				oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
				oPrintPPRA:Say( lin, 165, STR0554 + ":", oFont10b ) // "Responsável:"

				If TBB->TBB_TIPRES == '1' // Usuário

					oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "QAA", AllTrim( TBB->TBB_RESPON ), 1, "QAA_NOME", cFil ) ), oFont10 )

				Else // Funcionário

					oPrintPPRA:Say( lin, 620, Capital( NGSEEK( "SRA", AllTrim(TBB->TBB_RESPON), 1, "RA_NOME" ) ), oFont10 )

				EndIf

				Somalinha()

				//Observações
				If !Empty( TBB->TBB_OBSPLA )
					nLinhasMemo := MLCOUNT( TBB->TBB_OBSPLA, 75 )
					oPrintPPRA:Say( lin, 165, STR0555 + ":", oFont10b ) //"Observações:"
					For LinhaCorrente := 1 To nLinhasMemo
						oPrintPPRA:Say( lin, 620, MemoLine( TBB->TBB_OBSPLA, 75, LinhaCorrente ), oFont10 )
						oPrintPPRA:Line( lin, 150, lin + 60, 150 ) // Coluna Inicial
						oPrintPPRA:Line( lin, 2300, lin + 60, 2300 ) // Coluna Final
						oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
						SomaLinha()
					Next
				Else
					oPrintPPRA:Say( lin, 165, STR0555 + ":", oFont10b ) // "Observações:"
					oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
					oPrintPPRA:line ( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
					SomaLinha()
				EndIf
				//Processos
				oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
				oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
				oPrintPPRA:Say( lin, 165, STR0556 + ":", oFont10b ) // "Processos:"
				oPrintPPRA:Say( lin, 620, Capital( TAF->TAF_NOMNIV ), oFont10 )
				Somalinha()
				//Acoes
				dbSelectArea( "TJS" )
				dbSetOrder( 1 ) //TJS_FILIAL+TJS_CODPLA+TJS_CODACA
				dbGoTop()
				If dbSeek( xFilial( "TJS", cFil ) + TJK->TJK_CODPLA )
					oPrintPPRA:Say( lin, 165, STR0557 + ":", oFont10b ) // "Ações:"
					While !Eof() .And. TJS->TJS_FILIAL == xFilial( "TJS", cFil ) .And. TJS->TJS_CODPLA == TJK->TJK_CODPLA
						oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
						oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
						oPrintPPRA:Say( lin, 620, Capital( TJS->TJS_CODACA ), oFont10 )
						oPrintPPRA:Say( lin, 770, " - ", oFont10 )
						oPrintPPRA:Say( lin, 840, Capital( Substr( TJS->TJS_DESACA, 1, 50 ) ), oFont10 )
						Somalinha()
						dbSelectArea( "TJS" )
						dbSkip()
						Loop
					End //Finaliza While que percorre a Tabela (TJS)
				Endif
				//Participantes
				dbSelectArea( "TJT" )
				dbSetOrder( 1 ) //TJT_FILIAL+TJT_CODPLA+TJT_CODPAR
				dbGoTop()
				If dbSeek( xFilial( "TJT", cFil ) + TJK->TJK_CODPLA )
					oPrintPPRA:Say( lin, 165, STR0558 + ":", oFont10b ) // "Participantes:"
					While !Eof() .And. TJT->TJT_FILIAL == xFilial( "TJT", cFil ) .And. TJT->TJT_CODPLA == TJK->TJK_CODPLA
						oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
						oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
						oPrintPPRA:Say( lin, 620, Capital( TJT->TJT_CODPAR ), oFont10 )
						oPrintPPRA:Say( lin, 770, " - ", oFont10 )
						oPrintPPRA:Say( lin, 840, Capital( NGSEEK( "SRA", TJT->TJT_CODPAR, 1, "RA_NOME" ) ), oFont10 )
						Somalinha()
						dbSelectArea( "TJT" )
						dbSkip()
						Loop
					End //Finaliza While que percorre a Tabela (TJT)
				Endif
				//Contatos Externos
				dbSelectArea( "TJW" )
				dbSetOrder( 1 ) //TJW_FILIAL+TJW_CODPLA+TJW_CODCON
				dbGoTop()
				dbSeek( xFilial( "TJW", cFil ) + TJK->TJK_CODPLA )
				If !Empty( TJW->TJW_CODPLA ) // Se o existir conteudo no campo de Contatos Externos, o mesmo sera impresso.
					oPrintPPRA:Say( lin, 165, STR0559 + ":", oFont10b ) // "Contatos Externos:"
					While !Eof() .And. TJW->TJW_FILIAL == xFilial( "TJW", cFil ) .And. TJW->TJW_CODPLA == TJK->TJK_CODPLA
						oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
						oPrintPPRA:line( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
						oPrintPPRA:Say( lin, 620, Capital( TJW->TJW_CODCON ), oFont10 )
						oPrintPPRA:Say( lin, 770, " - ", oFont10 )
						oPrintPPRA:Say( lin, 840, Capital( Substr( TJW->TJW_DESCON, 1, 27 ) ), oFont10 )
						oPrintPPRA:Say( lin, 1745, STR0560 + ":", oFont10 ) // "Fone"
						oPrintPPRA:Say( lin, 1842, Capital( TJW->TJW_FONE ), oFont10 )
						Somalinha()
						dbSelectArea( "TJW" )
						dbSkip()
						Loop
					End //Finaliza While que percorre a Tabela (TJW)
				Else //Senao sera impresso apenas a Descricao do campo.
					oPrintPPRA:Say( lin, 165, STR0559 + ":", oFont10b ) // "Contatos Externos:"
					oPrintPPRA:Box( lin, 150, lin + 60, 2300 ) // Monta tabela
					oPrintPPRA:line ( lin, 600, lin + 60, 600 ) // Linha Vertical que separa os campos
					oPrintPPRA:Say  ( lin, 1745, STR0560 + ":", oFont10 )
					Somalinha()
				EndIf
				SomaLinha()
				dbSelectArea( "TJG" )
				TJG->( dbSkip() )
			End //Finaliza While que percorre a Tabela (TJG)
		EndIf
	EndIf

	RestArea( aArea )

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850PROMON
Imprime atalho Programa de Monitoramento

@return	Nil, Nulo

@sample	A850PROMON()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
Static Function A850PROMON()

	Local cLaudo	 := IIf( lSigaMdtPs, mv_par03, cCodLaudo )
	Local oBrush1	 := TBrush():New( , RGB( 229, 229, 229 ) )
	Local aQdMonitor := {}
	Local aEtapa	 := {}
	Local lImp		 := .F.
	Local cMemo		 := ""
	Local cPosMerge	 := ""
	Local nRegs		 := 0
	Local cEpc
	Local cNomEPC
	Local cCodFam
	Local cFreq
	Local cDesFreq
	Local cTPCOMTA
	Local cServico
	Local cNomServ
	Local cSeqrela
	Local nQd
	Local nE

	dbSelectArea( "TIG" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TIG", cFil ) + cLaudo )
		While !Eof() .And. xFilial( "TIG", cFil ) == TIG->TIG_FILIAL .And. TIG->TIG_LAUDO == cLaudo
			
			cCodFam := TIG->TIG_CODFAM
			dbSelectArea( "ST9" )
			dbSetOrder( 4 )
			If dbSeek( xFilial( "ST9", cFil ) + Alltrim( cCodFam ) )
				While !Eof() .And. xFilial( "ST9", cFil ) == ST9->T9_FILIAL .And. cCodFam == ST9->T9_CODFAMI
					
					cEpc := ST9->T9_CODBEM
					cNomEpc := ST9->T9_NOME
					cTPCOMTA := ST9->T9_TPCONTA
					dbSelectArea( "STF" )
					dbSetOrder( 1 )
					If dbSeek( xFilial( "STF", cFil ) + Alltrim( cEpc ) )
						lImp := .T. //Se o bem possui manutenção habilita impressão
						While !Eof() .And. xFilial( "STF", cFil ) == STF->TF_FILIAL .And. cEpc == STF->TF_CODBEM
							
							cServico := STF->TF_SERVICO
							cNomServ := Posicione( "ST4", 1, xFilial( "ST4", cFil ) + cServico, "T4_NOME" )
							cSeqrela := STF->TF_SEQRELA
							If STF->TF_TIPACOM == "T"
								cFreq := STF->TF_UNENMAN
								cDesFreq := cValToChar( STF->TF_TEENMAN ) + " " + NGRETSX3BOX( "TF_UNENMAN", cFreq )
							ElseIf STF->TF_TIPACOM $ "C/P"
								cDesFreq := cValToChar( STF->TF_INENMAN ) + " " + cTPCOMTA
							ElseIf STF->TF_TIPACOM == "A"
								cFreq := STF->TF_UNENMAN
								cDesFreq := cValToChar( STF->TF_TEENMAN ) + " " + NGRETSX3BOX( "TF_UNENMAN", cFreq ) + " ou "
								cDesFreq += cValToChar( STF->TF_INENMAN ) + " " + cTPCOMTA
							Else
								cDesFreq := ""
							EndIf
							aAdd( aQdMonitor, { cCodFam, cEpc, cNomEpc, cNomServ, cDesFreq, {} } )
							dbSelectArea( "STH" )
							dbSetOrder( 1 )
							dbSeek( xFilial( "STH", cFil ) + cEpc + cServico + cSeqrela )
							aEtapa := {}
							While !Eof() .And. xFilial( "STH", cFil ) == STH->TH_FILIAL .And. cEpc == STH->TH_CODBEM .And. cServico == STH->TH_SERVICO .And. cSeqrela == STH->TH_SEQRELA
								cCodEta := STH->TH_ETAPA
								cDesEta := Posicione( "TPA", 1, xFilial( "TPA", cFil ) + cCodEta, "TPA_DESCRI" )
								aAdd( aQdMonitor[ Len( aQdMonitor ) ][6], { cCodEta, cDesEta } )
								dbSelectArea( "STH" )
								dbSkip()
							End
							dbSelectArea( "STF" )
							dbSkip()
						End
					EndIf
					dbSelectArea( "ST9" )
					dbSkip()
				End
			EndIf
			dbSelectArea( "TIG" )
			dbSkip()
		End
	EndIf
	
	//Impressão do Cabeçalho
	Somalinha()
	If lImp //Verifica se possui cinteudo para imprimir
		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
			
			cMemo += STR0561 + "#*" //"Equipamento/Area"
			cMemo += STR0096 + "#*" //"Nome"
			cMemo += STR0562 + "#*" //"Descrição do Serviço"
			cMemo += STR0563 + "#*" //"Frequência"
			nRegs++

		ElseIf nModeloImp == 2 //Modelo de Impressão padrão
			/*
			****************************************************************************************************************************
			0         1         2         3         4         5         6         7         8         9         0         1         2
			0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123
			****************************************************************************************************************************
			Equipamento/Area  Nome                  	        Descrição do Serviço            Frequência

			xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxx
												Etapas
			xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxx
			xxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxx
			*/
			@ Li, 000 PSay STR0561 //"Equipamento/Area"
			@ Li, 018 PSay STR0096 //"Nome"
			@ Li, 050 PSay STR0562 //"Descrição do Serviço"
			@ Li, 082 PSay STR0563 //"Frequência"
			Somalinha()

		ElseIf nModeloImp == 3 //Modelo de Impressão grafico

			If lin + 120 > 3000
				Somalinha( 120 )
			EndIf
			oPrintPPRA:FillRect( { lin, 150, lin + 60, 2300 }, oBrush1 )
			oBrush1:End()
			oPrintPPRA:Box( lin, 150, lin + 60, 2300 )
			oPrintPPRA:Line( lin, 490, lin + 60, 490 )
			oPrintPPRA:Line( lin, 1060, lin + 60, 1060 )
			oPrintPPRA:Line( lin, 1680, lin + 60, 1680 )
			oPrintPPRA:Say( lin + 10, 170, STR0561, oFont08b ) //"Equipamento/Area"
			oPrintPPRA:Say( lin + 10, 510, STR0096, oFont08b ) //"Nome"
			oPrintPPRA:Say( lin + 10, 1080, STR0562, oFont08b ) //"Descrição do Serviço"
			oPrintPPRA:Say( lin + 10, 1700, STR0563, oFont08b ) //"Frequência"
			Somalinha()
		EndIf

		//Impressão do Conteúdo
		For nQd := 1 To Len( aQdMonitor )
			
			If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
				cMemo += aQdMonitor[nQd][2] + "#*"
				cMemo += aQdMonitor[nQd][3] + "#*"
				cMemo += aQdMonitor[nQd][4] + "#*"
				cMemo += aQdMonitor[nQd][5] + "#*"
				nRegs++
				If Len( aQdMonitor[nQd][6] ) > 0
					cMemo += STR0564 + "#*" + "#*" + "#*" + "#*" //Etapas
					nRegs++
					cPosMerge += "{N}" + cValToChar( nRegs ) + "#*"
					For nE := 1 To Len( aQdMonitor[nQd][6] )
						cMemo += AllTrim( aQdMonitor[nQd][6][nE][1] ) + " - " + aQdMonitor[nQd][6][nE][2] + "#*" + "#*" + "#*" + "#*"
						nRegs++
						cPosMerge += cValToChar( nRegs ) + "#*"
					Next nE
				EndIf

			ElseIf nModeloImp == 2 //Modelo de Impressão padrão

				@ Li,000 PSay aQdMonitor[nQd][2]
				@ Li,018 PSay SubStr( aQdMonitor[nQd][3], 1, 30 )
				@ Li,050 PSay SubStr( aQdMonitor[nQd][4], 1, 30 )
				@ Li,082 PSay aQdMonitor[nQd][5]
				Somalinha()
				If Len( aQdMonitor[nQd][6] ) > 0
					For nE := 1 To Len( aQdMonitor[nQd][6] )
						If nE == 1
							@ Li, 034 PSay STR0564 //Etapas
							Somalinha()
						EndIf
						@ Li, 000 PSay AllTrim( aQdMonitor[nQd][6][nE][1] ) + " - " + SubStr( aQdMonitor[nQd][6][nE][2], 1, 120 )
						Somalinha()
					Next nE
				Else
					Somalinha()
				EndIf

			ElseIf nModeloImp == 3 //Modelo de Impressão grafico

				oPrintPPRA:Box( lin, 150, lin + 60, 2300 )
				oPrintPPRA:Line( lin, 490, lin + 60, 490 )
				oPrintPPRA:Line( lin, 1060, lin + 60, 1060 )
				oPrintPPRA:Line( lin, 1680, lin + 60, 1680 )
				oPrintPPRA:Say( lin + 10, 170, aQdMonitor[nQd][2], oFont08 )
				oPrintPPRA:Say( lin + 10, 510, SubStr( aQdMonitor[nQd][3], 1, 20 ), oFont08 )
				oPrintPPRA:Say( lin + 10, 1080, SubStr( aQdMonitor[nQd][4], 1, 25 ), oFont08 )
				oPrintPPRA:Say( lin + 10, 1700, aQdMonitor[nQd][5], oFont08 )
				Somalinha()
				If Len( aQdMonitor[nQd][6] ) > 0
					For nE := 1 To Len( aQdMonitor[nQd][6] )
						If nE == 1
							oPrintPPRA:Line( lin, 150, lin + 60, 150 )
							oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
							oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
							oPrintPPRA:Say( lin + 10, 1070, STR0564, oFont08b ) //"Etapas"
							Somalinha()
						EndIf
						oPrintPPRA:Line( lin, 150, lin + 60, 150 )
						oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
						oPrintPPRA:Say( lin + 10, 170, AllTrim( aQdMonitor[nQd][6][nE][1] ) + " - " + SubStr( aQdMonitor[nQd][6][nE][2], 1, 70 ), oFont08 )
						If nE == Len( aQdMonitor[nQd][6] ) //Fecha quadro de etapas.
							oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
						EndIf
						Somalinha()
					Next nE
				EndIf
			EndIf
		Next nQd

		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
			cVar1 := "cTXT" + Strzero( nVar1, 6 )
			OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )
			nVar1++
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_SetDocumentVar( oWord, "Tabela", cMemo )
			OLE_SetDocumentVar( oWord, "Linhas", nRegs )
			OLE_SetDocumentVar( oWord, "tabela2", cPosMerge )
			OLE_ExecuteMacro( oWord, "Table_Programa_Monitoramento" ) // Cria tabela do PGR x Plano Emergencial.
			OLE_ExecuteMacro( oWord, "Somalinha" )
			cMemo := ""
		EndIf
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850RADFUG
Imprime quadro de radiação de fuga vinculado ao ambiente físico relacionado ao laudo.

@author Bruno L. Souza
@since 06/03/2014

/*/
//-------------------------------------------------------------------
Static Function A850RADFUG()

	Local aRadFug := {}

	Local cMemo := ""

	Local oBrush1 := TBrush():New( , RGB( 229, 229, 229 ) ) // Objeto que preenche campos coloridos, Modelo Grafico.

	Local nRegs	:= 0
	Local nRfCab := 0
	Local nRfCont := 0

	dbSelectArea( "TNE" )
	dbSetOrder( 1 )
	dbGoTop()

	While TNE->( !Eof() ) .And. TNE->TNE_FILIAL == xFilial( "TNE", cFil )

		dbSelectArea( "TO5" )
		dbSetOrder( 1 )

		If dbSeek( xFilial( "TO5", cFil ) + Mv_par01 + TNE->TNE_CODAMB )

			dbSelectArea( "TI7" )
			dbSetOrder( 1 )

			If dbSeek( xFilial( "TI7", cFil ) + TNE->TNE_CODAMB )

				While !Eof() .And. xFilial( "TI7", cFil ) == TI7->TI7_FILIAL .And. TI7->TI7_CODAMB == TNE->TNE_CODAMB

					If ( nCodAmb := aScan( aRadFug, { | x | x[ 1 ] == TI7->TI7_CODAMB } ) ) == 0

						aAdd( aRadFug, { TI7->TI7_CODAMB, TNE->TNE_NOME, {} } )
						nCodAmb := Len( aRadFug )

					EndIf

					aAdd( aRadFug[ nCodAmb, 3 ], { TI7->TI7_PONMED, TI7->TI7_TAXOBS, TI7->TI7_DESPAD } )

					TI7->( dbSkip() )

				End

			EndIf

		EndIf

		TNE->( dbSkip() )

	End

	// Impressão do Cabeçalho
	If Len( aRadFug ) > 0 // Verifica se possui conteudo para imprimir

		For nRfCab := 1 To Len(aRadFug)

			nRegs := 0

			If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

				U_IMPHEA850( "{N}" + STR0514 )
				U_IMPDOC850( Alltrim( aRadFug[ nRfCab, 1 ] ) + " - " + aRadFug[ nRfCab, 2 ] )

				cMemo += STR0520 + "#*" // "Pontos"
				cMemo += STR0521 + "#*" // "Taxa de Dose Absorvida(mGy/h)"
				cMemo += STR0522 + "#*" // "Desvio Padrão"

				nRegs++

			ElseIf nModeloImp == 2 //Modelo de Impressão padrão

				@ Li,000 Psay STR0514 // "Ambiente Físico:"
				@ Li,017 Psay Alltrim( aRadFug[ nRfCab, 1 ] ) + " - " + aRadFug[ nRfCab, 2 ]

				Somalinha()

				@ Li,000 PSay STR0520 // "Pontos"
				@ Li,012 PSay STR0521 // "Taxa de Dose Absorvida(mGy/h)"
				@ Li,043 PSay STR0522 // "Desvio Padrão"

				Somalinha()

			ElseIf nModeloImp == 3 //Modelo de Impressão grafico

				SomaLinha()

				If lin+120 > 3000

					Somalinha( 120 )

				EndIf

				oPrintPPRA:Say( lin, 165, STR0514, oFont10b ) // "Ambiente Físico:"
				oPrintPPRA:Say( lin, 525, aRadFug[ nRfCab, 1 ] + " - " + aRadFug[ nRfCab, 2 ], oFont10 )

				Somalinha()

				oPrintPPRA:FillRect( { lin, 150, lin + 60, 2300 }, oBrush1 )

				oBrush1:End()

				oPrintPPRA:Box(lin, 150, lin + 60, 2300 )

				oPrintPPRA:Line(lin, 860, lin + 60, 860  )
				oPrintPPRA:Line(lin, 1580, lin + 60, 1580 )

				oPrintPPRA:Say( lin + 10, 170, STR0520, oFont10b ) // "Pontos"
				oPrintPPRA:Say( lin + 10, 870, STR0521, oFont10b ) // "Taxa de Dose Absorvida(mGy/h)"
				oPrintPPRA:Say( lin + 10, 1590, STR0522, oFont10b ) // "Desvio Padrão"

				Somalinha()

			EndIf

			// Impressão do Conteúdo
			For nRfCont := 1 To Len( aRadFug[ nRfCab, 3 ] )

				If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

					cMemo += aRadFug[ nRfCab, 3, nRfCont, 1 ] + "#*"
					cMemo += cValToChar(aRadFug[ nRfCab, 3, nRfCont, 2 ] ) + "#*"
					cMemo += cValToChar(aRadFug[ nRfCab, 3, nRfCont, 3 ] ) + "#*"

					nRegs++

				ElseIf nModeloImp == 2 //Modelo de Impressão padrão

					@ Li,000 PSay aRadFug[ nRfCab, 3, nRfCont, 1 ]
					@ Li,012 PSay aRadFug[ nRfCab, 3, nRfCont, 2 ]
					@ Li,043 PSay aRadFug[ nRfCab, 3, nRfCont, 3 ]

					Somalinha()

				ElseIf nModeloImp == 3 //Modelo de Impressão grafico

					oPrintPPRA:Box( lin, 150, lin + 60, 2300 )

					oPrintPPRA:Line( lin, 860, lin + 60, 860  )
					oPrintPPRA:Line( lin, 1580, lin + 60, 1580 )

					oPrintPPRA:Say( lin + 10, 170, aRadFug[ nRfCab, 3, nRfCont, 1 ] , oFont10) 
					oPrintPPRA:Say( lin + 10, 870, cValToChar( aRadFug[ nRfCab, 3, nRfCont, 2 ] ), oFont10 )
					oPrintPPRA:Say( lin + 10, 1590, cValToChar( aRadFug[ nRfCab, 3, nRfCont, 3 ] ), oFont10 )

					Somalinha()

				EndIf

			Next nRfCont

			If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

				cVar1 := "cTXT" + Strzero( nVar1, 6 )

				OLE_SetDocumentVar( oWord, "Cria_Var", cVar1 )

				nVar1++

				OLE_ExecuteMacro( oWord, "Somalinha" )

				OLE_SetDocumentVar( oWord, "Tabela", cMemo )
				OLE_SetDocumentVar( oWord, "Linhas", nRegs )

				OLE_ExecuteMacro( oWord, "Table_Radiação_Fuga" ) // Cria tabela de Radiação de Fuga.
				OLE_ExecuteMacro( oWord, "Somalinha" )

				cMemo := ""

			EndIf

		Next nRfCab

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850PROGA
Imprime os programas de saúde existentes na empresa.

@author Gabriel Sokacheski
@since 28/07/2021

/*/
//-------------------------------------------------------------------
Static Function A850PROGA()

	dbselectarea( "TMO" )
	dbsetorder( 1 )
	dbseek( xFilial( "TMO", cFil ) )
	While TMO->( !Eof() ) .And. xFilial( "TMO", cFil ) == TMO->TMO_FILIAL
		//Verifica se existe funcionario relacionado ao programa de saude
		dbselectarea( "TMN" )
		dbsetorder( 1 )
		If !dbseek( xFilial( "TMN", cFil ) + TMO->TMO_CODPRO )
			dbselectarea( "TMO" )
			dbskip()
			Loop
		EndIf
		If !fCLIENT870( TMN->TMN_NUMFIC ) //Verifica se o Prog. Saude eh destinado aos funcionarios do Cliente
			dbselectarea( "TMO" )
			dbskip()
			Loop
		EndIf

		lPrint := .T.
		U_IMPHEA850( "{N}" + TMO->TMO_NOMPRO )
		If !Empty( TMO->TMO_DESPRO )
			U_IMPDOC850( Alltrim( TMO->TMO_DESPRO ) )
			If nModeloImp == 3
				Somalinha()
			EndIf
		Else
			Somalinha()
		EndIf
		dbselectarea( "TMO" )
		dbskip()
	End

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A850AGEMED
Imprime um quadro com os agentes e medidas por centro de custo

@author Jackson Machado
@since 29/09/2014

/*/
//---------------------------------------------------------------------
Static Function A850AGEMED()

	Local aAgeImp := {}
	Local aRiscos := fRiscos()
	Local aAgentes := {}

	Local i

	Local nAge := 0
	Local nRisc := 0
	Local nRegs	:= 0
	Local nPosCC := 0
	Local nCorte := 25

	Local cMemo := ""
	Local cCusto := ""
	Local cTexto := ""
	Local cSituacao := ""
	Local cTipAgente := ""

	Local lAllCTT := .T.
	Local lMedida := .F.

	// Ordena os riscos pelo agente
	aSort( aRiscos, , , { | x, y | x[ 1 ] + x[ 8 ]  < y[ 1 ] + x[ 8 ] } )

	For nRisc := 1 To Len( aRiscos )

		If aRiscos[ nRisc , 2 ] == "*"

			If lAllCTT

				dbSelectArea( "CTT" )
				dbSetOrder( 1 )
				If dbSeek( xFilial( "CTT", cFil ) )

					While CTT->( !Eof() ) .And. CTT->CTT_FILIAL == xFilial( "CTT", cFil )

						If ( nPosCC := aScan( aAgentes, { | x | x[ 1 ] == aRiscos[ nRisc, 2 ] } ) ) == 0

							aAdd( aAgentes, { aRiscos[ nRisc, 2 ], {} } )

							nPosCC := Len( aAgentes )

						EndIf

						aAdd( aAgentes[ nPosCC, 2 ], aRiscos[ nRisc, 1 ] )

						CTT->( dbSkip() )

					End

				EndIf

			EndIf

			lAllCTT := .F.

		Else

			If ( nPosCC := aScan( aAgentes, { | x | x[ 1 ] == aRiscos[ nRisc , 2 ] } ) ) == 0

				aAdd( aAgentes , { aRiscos[ nRisc, 2 ], {} } )

				nPosCC := Len( aAgentes )

			EndIf

			aAdd( aAgentes[ nPosCC, 2 ], aRiscos[ nRisc, 1 ] )

		EndIf

	Next nRisc

	For nAge := 1 To Len( aAgentes )

		cMemo := ""
		cCusto := aAgentes[ nAge, 1 ]

		nRegs := 0

		dbSelectArea( "CTT" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "CTT", cFil ) + cCusto )

		If nModeloImp == 2 //Modelo de Impressão padrão

			SomaLinha()

			@ Li, 001 PSay Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ) // "Centro de Custo"

		ElseIf nModeloImp == 3 //Modelo de Impressão grafico

			Somalinha()

			oPrintPPRA:Box( lin , 150 , lin + 60 , 2300 )
			oPrintPPRA:Say( lin + 10 , 175 , Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ) , oFont08b ) // "Centro de Custo"

		Else

			cMemo += Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ) + "#*" + "#*" + "#*" + "#*" + "#*" // "Centro de Custo"

			cMemo += 	Upper( STR0523 ) + "#*" + ; // "Agente"
						Upper( STR0524 ) + "#*" + ; // "Situação Encontrada"
						Upper( STR0525 ) + "#*" + ; // "Situação Desejada"
						Upper( STR0526 ) + "#*" + ;  // "Situação Ergonômica"
						Upper( STR0527 ) + "#*" // "Medida(s) Aplicada(s)"

		EndIf

		nRegs++
		aAgeImp := aAgentes[ nAge , 2 ]

		For nRisc := 1 To Len( aAgeImp )

			dbSelectArea( "TN0" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TN0", cFil ) + aAgeImp[ nRisc ] )

			dbSelectArea( "TMA" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )

			cTipAgente := TMA->TMA_GRISCO

			If nModeloImp == 2 //Modelo de Impressão padrão

				SomaLinha()

				@ Li , 015 PSay STR0523 + ": " + AllTrim( Capital( TMA->TMA_NOMAGE ) ) + " - " + TN0->TN0_NUMRIS // "Agente"

				// SomaLinha()

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf
				If Empty( cSituacao )

					cSituacao := cValToChar( TN0->TN0_QTAGEN ) + TN0->TN0_UNIMED

				EndIf

				nTamanho := 100 - Len( STR0524 + ": " ) // "Situação Encontrada"
				nLinhasMemo := MlCount( cSituacao, nTamanho )

				// Percorre o memo e realiza a impressão linear
				For i := 1 To nLinhasMemo

					If i == 1

						SomaLinha()

						@ Li , 015 PSay STR0524 + ": " // "Situação Encontrada"

					Else

						SomaLinha()

					EndIf

					@ Li , 015 + Len( STR0524 + ": " ) PSay MemoLine( cSituacao, nTamanho, i ) // "Situação Encontrada"

				Next i

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf

				nTamanho    := 100 - Len( STR0525 + ": " ) // "Situação Desejada"
				nLinhasMemo := MlCount( cSituacao , nTamanho )

				// Percorre o memo e realiza a impressão linear
				For i := 1 To nLinhasMemo

					If i == 1

						SomaLinha()

						@ Li , 015 PSay STR0525 + ": " // "Situação Desejada"

					Else

						SomaLinha()

					EndIf

					@ Li, 015 + Len( STR0525 + ": " ) PSay MemoLine( cSituacao , nTamanho , i ) // "Situação Desejada"

				Next i

				SomaLinha()

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf
				@ Li, 015 PSay STR0526 + ": " + cSituacao // "Situação Ergonômica"

			ElseIf nModeloImp == 3 //Modelo de Impressão grafico

				cMemo := ""

			Else

				cMemo += AllTrim( Capital( TMA->TMA_NOMAGE ) ) + " - " + TN0->TN0_NUMRIS + "#*"

				cTexto := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				If !( cTipAgente $ '4/8')
					cTexto := 'NA'
				EndIf

				If Empty( cTexto )

					cMemo += cValToChar( TN0->TN0_QTAGEN ) + TN0->TN0_UNIMED + "#*"

				Else

					If !( cTipAgente $ '4/8')
						cMemo += 'NA' + '#*'
					Else
						cMemo += cTexto + '#*'
					EndIf

				EndIf

				cTexto := AllTrim( MsMM( TN0->TN0_SI2SYP, 80 ) )
				If !( cTipAgente $ '4/8')
					cMemo += 'NA' + '#*'
				Else
					cMemo += cTexto + '#*'
				EndIf

				cTexto := NGRETSX3BOX( 'TN0_SITUAC', TN0->TN0_SITUAC )
				If !( cTipAgente $ '4/8')
					cMemo += 'NA' + '#*' + '#*'
				Else
					cMemo += cTexto + '#*' + '#*'
				EndIf

			EndIf

			dbSelectArea( "TJF" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TJF", cFil ) + TN0->TN0_NUMRIS )

			lMedida := .F.

			While TJF->( !Eof() ) .And. TJF->TJF_FILIAL == xFilial( "TJF", cFil ) .And. TJF->TJF_NUMRIS == TN0->TN0_NUMRIS

				dbSelectArea( "TO4" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "TO4", cFil ) + TJF->TJF_MEDCON )

				cMemo += AllTrim( Capital( TO4->TO4_NOMCTR ) )+ "; "

				TJF->( dbSkip() )

				lMedida := .T.

			End

			If lMedida

				cMemo := AllTrim( cMemo )
				cMemo := SubStr( cMemo , 1 , Len( cMemo ) - 1 )

			EndIf

			If nModeloImp == 2 //Modelo de Impressão padrão

				nTamanho    := 100 - Len( STR0527 + ": " ) // "Medida(s) Aplicada(s)"
				nLinhasMemo := MlCount( cMemo , nTamanho )

				// Percorre o memo e realiza a impressão linear
				For i := 1 To nLinhasMemo

					If i == 1

						SomaLinha()

						@ Li , 015 PSay STR0527 + ": " // "Medida(s) Aplicada(s)"

					Else

						SomaLinha()

					EndIf

					@ Li , 015 + Len( STR0527 + ": " ) PSay MemoLine( cMemo , nTamanho , i ) // "Medida(s) Aplicada(s)"

				Next i

				SomaLinha()

			ElseIf nModeloImp == 3 //Modelo de Impressão grafico

				If nRisc == 1

					Somalinha()

					oPrintPPRA:Box( lin , 0150 , lin + 60 , 2300 )

					oPrintPPRA:Line( lin , 0580 , lin + 60 , 0580 )
					oPrintPPRA:Line( lin , 1010 , lin + 60 , 1010 )
					oPrintPPRA:Line( lin , 1440 , lin + 60 , 1440 )
					oPrintPPRA:Line( lin , 1870 , lin + 60 , 1870 )

					oPrintPPRA:Say( lin + 10 , 0365 , STR0523 , oFont08b , , , , 2 ) // "Agente"
					oPrintPPRA:Say( lin + 10 , 0795 , STR0524 , oFont08b , , , , 2 ) // "Situação Encontrada"
					oPrintPPRA:Say( lin + 10 , 1225 , STR0525 , oFont08b , , , , 2 ) // "Situação Desejada"
					oPrintPPRA:Say( lin + 10 , 1655 , STR0526 , oFont08b , , , , 2 ) // "Situação Ergonômica"
					oPrintPPRA:Say( lin + 10 , 2085 , STR0527 , oFont08b , , , , 2 ) // "Medida(s) Aplicada(s)"

				EndIf

				cAgente := AllTrim( Capital( TMA->TMA_NOMAGE ) ) + " - " + TN0->TN0_NUMRIS

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf
				cEncontra := cSituacao

				If Empty( cEncontra )

					cEncontra := cValToChar( TN0->TN0_QTAGEN ) + TN0->TN0_UNIMED

				EndIf

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf
				cDeseja := cSituacao

				If cTipAgente $ '4/8'
					cSituacao := AllTrim( MsMM( TN0->TN0_SITSYP, 80 ) )
				Else
					cSituacao := 'NA'
				EndIf
				cErgonom := cSituacao

				cMedida := cMemo

				nLimFor := MlCount( cAgente , nCorte )
				nLimFor := If( nLimFor > MlCount( cEncontra , nCorte ) , nLimFor , MlCount( cEncontra , nCorte ) )
				nLimFor := If( nLimFor > MlCount( cDeseja , nCorte ) , nLimFor , MlCount( cDeseja , nCorte ) )
				nLimFor := If( nLimFor > MlCount( cErgonom , nCorte ) , nLimFor , MlCount( cErgonom , nCorte ) )
				nLimFor := If( nLimFor > MlCount( cMedida , nCorte ) , nLimFor , MlCount( cMedida , nCorte ) )

				For i := 1 To nLimFor

					Somalinha()

					oPrintPPRA:Line( lin , 0150 , lin + 60 , 0150 )
					oPrintPPRA:Line( lin , 0580 , lin + 60 , 0580 )
					oPrintPPRA:Line( lin , 1010 , lin + 60 , 1010 )
					oPrintPPRA:Line( lin , 1440 , lin + 60 , 1440 )
					oPrintPPRA:Line( lin , 1870 , lin + 60 , 1870 )
					oPrintPPRA:Line( lin , 2300 , lin + 60 , 2300 )

					If !Empty( MemoLine( cAgente , nCorte , i ) )

						oPrintPPRA:Say( lin + 10 , 170 , MemoLine( cAgente, nCorte, i ), oFont08 )

					EndIf

					If !Empty( MemoLine( cEncontra , nCorte , i ) )

						oPrintPPRA:Say( lin + 10 , 590 , MemoLine( cEncontra, nCorte, i ), oFont08 )

					EndIf

					If !Empty( MemoLine( cDeseja , nCorte , i ) )

						oPrintPPRA:Say( lin + 10 , 1030 , MemoLine( cDeseja, nCorte, i ), oFont08 )

					EndIf

					If !Empty( MemoLine( cErgonom , nCorte , i ) )

						oPrintPPRA:Say( lin + 10 , 1460 , MemoLine( cErgonom, nCorte, i ), oFont08 )

					EndIf

					If !Empty( MemoLine( cMedida, nCorte, i ) )

						oPrintPPRA:Say( lin + 10, 1890, MemoLine( cMedida, nCorte, i ), oFont08 )

					EndIf

				Next i

				oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )

			Else

				cMemo +=  + "#*"
				nRegs++

			EndIf

		Next nRisc

		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)

			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_SetDocumentVar( oWord, "Tabela", cMemo )
			OLE_SetDocumentVar( oWord, "Linhas", nRegs )
			OLE_ExecuteMacro( oWord, "Table_AgenteMedida" )
			OLE_ExecuteMacro( oWord, "Somalinha" )
			OLE_ExecuteMacro( oWord, "Somalinha" )

		Else

			SomaLinha()

		EndIf

	Next nAge

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} A850QDAGE
Imprime um quadro com os agentes e fontes por Centro de Custo

@return	Nil, Nulo

@sample	A850QDAGE()

@author	Luis Fellipy Bett
@since	27/07/2021
/*/
//-------------------------------------------------------------------
Static Function A850QDAGE()

	Local aRiscos := fRiscos()

	Local cMemo := ""
	Local cFonte := ""
	Local cTexto := ""
	Local cAgente := ""
	Local cTipAgente := ""

	Local nRisc := 0
	Local nRegs := 0
	Local nLinhasMemo
	Local i

	//Ordena os riscos pelo agente
	aSort( aRiscos, , , { | x, y | x[ 8 ] + x[ 10 ] < y[ 8 ] + y[ 10 ] } )

	For nRisc := 1 To Len( aRiscos )
		If cAgente <> aRiscos[ nRisc, 8 ] .And. cFonte <> aRiscos[ nRisc, 11 ]
			
			cAgente := aRiscos[ nRisc, 8 ]
			cFonte := aRiscos[ nRisc, 11 ]
			dbSelectArea( "TMA" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TMA", cFil ) + aRiscos[ nRisc, 8 ] )

			cTipAgente := TMA->TMA_GRISCO

			dbSelectArea( "TN7" )
			dbSetOrder( 1 )
			dbSeek( xFilial( "TN7", cFil ) + aRiscos[ nRisc, 10 ] )

			If nModeloImp == 2 //Modelo de Impressão padrão
				
				SomaLinha()
				@ Li, 001 PSay STR0523 + ": " + aRiscos[ nRisc, 9 ] //"Agente"
				SomaLinha()
				@ Li, 001 PSay STR0091 + ": " + aRiscos[ nRisc, 11 ] //"Fonte Geradora"
				
				nTamanho := 100 - Len( STR0565 + ": " ) //"Patologia"

				cTexto := AllTrim( MsMM( TMA->TMA_PATSYP, 80 ) )
				If !( cTipAgente $ '4/8' )
					cPatologia := 'NA'
				Else
					cPatologia := cTexto
				EndIf

				nLinhasMemo := MlCount( cPatologia, nTamanho )

				If cPatologia != 'NA' .And. !Empty( cPatologia )

					//Percorre o memo e realiza a impressão linear
					For i := 1 To nLinhasMemo
						If i == 1
							SomaLinha()
							@ Li, 001 PSay STR0565 + ": " //"Patologia"
						Else
							SomaLinha()
						EndIf
						@ Li, 000 + Len( STR0565 + ": " ) PSay MemoLine( cPatologia, nTamanho, i ) //"Patologia"
					Next i

				Else

					SomaLinha()
					@Li, 001 PSay STR0565 +  ': ' + cPatologia //"Patologia"

				EndIf

				nTamanho := 100 - Len( STR0566 + ": " ) //"Sintomatologia"

				cTexto := AllTrim( MsMM( TMA->TMA_SINSYP, 80 ) )
				If !( cTipAgente $ '4/8' )
					cSintomato := 'NA'
				Else
					cSintomato := cTexto
				EndIf

				nLinhasMemo := MlCount( cSintomato, nTamanho )

				If cSintomato != 'NA' .And. !Empty( cSintomato )

					//Percorre o memo e realiza a impressão linear
					For i := 1 To nLinhasMemo
						If i == 1
							SomaLinha()
							@ Li, 001 PSay STR0566 + ": " //"Sintomatologia"
						Else
							SomaLinha()
						EndIf
						@ Li, 000 + Len( STR0566 + ": " ) PSay MemoLine( cSintomato, nTamanho, i ) //"Sintomatologia"
					Next i

				Else

					SomaLinha()
					@Li, 001 PSay STR0566 + ': ' + cSintomato //"Sintomatologia"

				EndIf

				SomaLinha()

			ElseIf nModeloImp == 3 //Modelo de Impressão .doc (Word.)

				Somalinha()

				If nRisc == 1

					oPrintPPRA:Box( lin, 0150, lin + 60, 2300 )
					oPrintPPRA:Line( lin, 0600, lin + 60, 0600 )
					oPrintPPRA:Line( lin, 1000, lin + 60, 1000 )
					oPrintPPRA:Line( lin, 1650, lin + 60, 1650 )
					oPrintPPRA:Say( lin + 10, 0375, STR0523, oFont08b, , , , 2 ) //"Agente"
					oPrintPPRA:Say( lin + 10, 0800, STR0567, oFont08b, , , , 2 ) //"Fonte"
					oPrintPPRA:Say( lin + 10, 1325, STR0565, oFont08b, , , , 2 ) //"Patologia"
					oPrintPPRA:Say( lin + 10, 1975, STR0566, oFont08b, , , , 2 ) //"Sintomatologia"

					Somalinha()

				EndIf

				cAgente		:= aRiscos[ nRisc, 9 ]
				cFonte		:= aRiscos[ nRisc, 11 ]

				cTexto := AllTrim( MsMM( TMA->TMA_PATSYP, 80 ) )
				If !( cTipAgente $ '4/8' )
					cPatologia := 'NA'
				Else
					cPatologia := cTexto
				EndIf

				cTexto := AllTrim( MsMM( TMA->TMA_SINSYP, 80 ) )
				cSintomato 	:= IIf( cTipAgente == '4', cTexto, 'NA' )

				nLimFor := MlCount( cAgente , 30 )
				nLimFor := If( nLimFor > MlCount( cFonte, 30 ), nLimFor, MlCount( cFonte, 30 ) )
				nLimFor := If( nLimFor > MlCount( cPatologia, 40 ), nLimFor, MlCount( cPatologia, 40 ) )
				nLimFor := If( nLimFor > MlCount( cSintomato, 40 ), nLimFor, MlCount( cSintomato, 40 ) )

				For i := 1 To nLimFor

					oPrintPPRA:Line( lin, 0150, lin + 60, 0150 )
					oPrintPPRA:Line( lin, 0600, lin + 60, 0600 )
					oPrintPPRA:Line( lin, 1000, lin + 60, 1000 )
					oPrintPPRA:Line( lin, 1650, lin + 60, 1650 )
					oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
					If !Empty( MemoLine( cAgente , 30 , i ) )
						oPrintPPRA:Say( lin + 10, 170, MemoLine( cAgente, 30, i ), oFont08 )
					EndIf
					If !Empty( MemoLine( cFonte , 30 , i ) )
						oPrintPPRA:Say( lin + 10, 620, MemoLine( cFonte, 30, i ), oFont08 )
					EndIf
					If !Empty( MemoLine( cPatologia , 40 , i ) )
						oPrintPPRA:Say( lin + 10, 1020, MemoLine( cPatologia, 40, i ), oFont08 )
					EndIf
					If !Empty( MemoLine( cSintomato , 40 , i ) )
						oPrintPPRA:Say( lin + 10, 1670, MemoLine( cSintomato, 40, i ), oFont08 )
					EndIf
				Next i
				oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )

			Else

				cMemo += aRiscos[ nRisc, 9 ] + "#*"
				cMemo += aRiscos[ nRisc, 11 ] + "#*"
				cTexto := AllTrim( MsMM( TMA->TMA_PATSYP, 80 ) )
				If !( cTipAgente $ '4/8' )
					cMemo += 'NA' + "#*"
				Else
					cMemo += cTexto + "#*"
				EndIf
				cTexto := AllTrim( MsMM( TMA->TMA_SINSYP, 80 ) )
				If !( cTipAgente $ '4/8' )
					cMemo += 'NA' + "#*"
				Else
					cMemo += cTexto + "#*"
				EndIf
				nRegs++
			EndIf
		EndIf
	Next nRisc

	If nModeloImp == 1 .And. nRegs > 0 //Modelo de Impressão .doc (Word.)
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_SetDocumentVar( oWord, "Tabela", cMemo )
		OLE_SetDocumentVar( oWord, "Linhas", nRegs )
		OLE_ExecuteMacro( oWord, "Quadro_Agente" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
		OLE_ExecuteMacro( oWord, "Somalinha" )
	Else
		Somalinha()
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A850FUNTAR
Imprime um quadro com as funções e tarefas por centro de custo

@return Sempre Verdadeiro

@sample A850FUNTAR()

@author Jackson Machado
@since 29/09/2014
/*/
//---------------------------------------------------------------------
Static Function A850FUNTAR()

	Local aRiscos	:= fRiscos()
	Local cMemo 	:= ""
	Local cCusto	:= ""
	Local cFuncao	:= ""
	Local cTarefa	:= ""
	Local cFunImp	:= ""
	Local lAllCTT	:= .T.
	Local aRisImp	:= {}
	Local nCorte	:= 25
	Local nRisc 	:= 0
	Local nRegs		:= 0
	Local nFun
	Local nPosCC
	Local nPosFun
	Local nPosTar
	Local nImp1
	Local nImp2
	Local nImp3
	Local i

	//Ordena os riscos pelo agente
	aSort( aRiscos, , , { | x, y | x[ 2 ] + x[ 4 ] + x[ 6 ] < y[ 2 ] + y[ 4 ] + y[ 6 ] } )

	For nRisc := 1 To Len( aRiscos )
		If AllTrim( aRiscos[ nRisc, 2 ] ) <> "*"
			
			If ( nPosCC := aScan( aRisImp, { | x | x[ 1 ] == aRiscos[ nRisc, 2 ] } ) ) == 0
				aAdd( aRisImp, { aRiscos[ nRisc, 2 ], {} } )
				nPosCC := Len( aRisImp )
			EndIf

			If AllTrim( aRiscos[ nRisc, 4 ] ) == "*"
				
				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SRJ", cFil ) )
				While SRJ->( !Eof() ) .And. SRJ->RJ_FILIAL == xFilial( "SRJ", cFil )
					
					If ( ValType( aRisImp[nPosCC, 2] ) == "A" .And. Len( aRisImp[nPosCC, 2] ) == 0 ) .Or.;
						( nPosFun := aScan( aRisImp[nPosCC, 2], { | x | x[1] == SRJ->RJ_FUNCAO } ) ) == 0
						aAdd( aRisImp[ nPosCC, 2 ], { SRJ->RJ_FUNCAO, {} } )
						nPosFun := Len( aRisImp[ nPosCC, 2 ] )
					EndIf

					aTarTemp := aClone( aRisImp[ nPosCC, 2, nPosFun, 2 ] )

					If AllTrim( aRiscos[ nRisc, 6 ] ) == "*"
						
						dbSelectArea( "TN5" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "TN5", cFil ) )
						While TN5->( !Eof() ) .And. TN5->TN5_FILIAL == xFilial( "TN5", cFil )
							
							If ( nPosTar := aScan( aTarTemp, { | x | x == TN5->TN5_CODTAR } ) ) == 0
								aAdd( aRisImp[ nPosCC, 2, nPosFun, 2 ], TN5->TN5_CODTAR )
							EndIf

							TN5->( dbSkip() )
						End
					Else
						If ( nPosTar := aScan( aTarTemp, { | x | x == aRiscos[ nRisc, 6 ] } ) ) == 0
							aAdd( aRisImp[ nPosCC, 2, nPosFun, 2 ], aRiscos[ nRisc, 6 ] )
						EndIf
					EndIf

					SRJ->( dbSkip() )
				End
			Else
				aFuncTmp := aClone( aRisImp[ nPosCC , 2 ] )

				If ( nPosFun := aScan( aFuncTmp, { | x | x[ 1 ] == aRiscos[ nRisc, 4 ] } ) ) == 0
					aAdd( aRisImp[ nPosCC, 2 ], { aRiscos[ nRisc, 4 ], {} } )
					nPosFun := Len( aRisImp[ nPosCC, 2 ] )
				EndIf

				aTarTemp := aClone( aRisImp[ nPosCC, 2, nPosFun, 2 ] )

				If AllTrim( aRiscos[ nRisc, 6 ] ) == "*"
					
					dbSelectArea( "TN5" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "TN5", cFil ) )
					While TN5->( !Eof() ) .And. TN5->TN5_FILIAL == xFilial( "TN5", cFil )
						
						If ( nPosTar := aScan( aTarTemp, { | x | x == TN5->TN5_CODTAR } ) ) == 0
							aAdd( aRisImp[ nPosCC, 2, nPosFun, 2 ], TN5->TN5_CODTAR )
						EndIf

						TN5->( dbSkip() )
					End
				Else
					If ( nPosTar := aScan( aTarTemp, { | x | x == aRiscos[ nRisc, 6 ] } ) ) == 0
						aAdd( aRisImp[ nPosCC, 2, nPosFun, 2 ], aRiscos[ nRisc, 6 ] )
					EndIf
				EndIf
			EndIf
		Else
			If lAllCTT
				dbSelectArea( "CTT" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "CTT", cFil ) )
				While CTT->( !Eof() ) .And. CTT->CTT_FILIAL == xFilial( "CTT", cFil )
					If aScan( aRisImp, { | x | x[ 1 ] == aRiscos[ nRisc, 2 ] } ) == 0
						aAdd( aRisImp, { aRiscos[ nRisc, 2 ], {} } )
					EndIf
					CTT->( dbSkip() )
				End
			EndIf

			lAllCTT := .F.

			If AllTrim( aRiscos[ nRisc, 4 ] ) == "*"

				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SRJ", cFil ) )
				While SRJ->( !Eof() ) .And. SRJ->RJ_FILIAL == xFilial( "SRJ", cFil )

					For nFun := 1 To Len( aRisImp )

						aFuncTmp := aClone( aRisImp[ nFun, 2 ] )

						If ( nPosFun := aScan( aFuncTmp, { | x | x[ 1 ] == SRJ->RJ_FUNCAO } ) ) == 0
							aAdd( aRisImp[ nFun, 2 ], { SRJ->RJ_FUNCAO, {} } )
							nPosFun := Len( aRisImp[ nFun, 2 ] )
						EndIf

						aTarTemp := aClone( aRisImp[ nFun, 2, nPosFun, 2 ] )

						If AllTrim( aRiscos[ nRisc, 6 ] ) == "*"
							
							dbSelectArea( "TN5" )
							dbSetOrder( 1 )
							dbSeek( xFilial( "TN5", cFil ) )
							While TN5->( !Eof() ) .And. TN5->TN5_FILIAL == xFilial( "TN5", cFil )
								
								If ( nPosTar := aScan( aTarTemp, { | x | x == TN5->TN5_CODTAR } ) ) == 0
									aAdd( aRisImp[ nFun, 2, nPosFun, 2 ], TN5->TN5_CODTAR )
								EndIf

								TN5->( dbSkip() )
							End
						Else
							If ( nPosTar := aScan( aTarTemp, { | x | x == aRiscos[ nRisc, 6 ] } ) ) == 0
								aAdd( aRisImp[ nFun, 2, nPosFun, 2 ], aRiscos[ nRisc, 6 ] )
							EndIf
						EndIf
					Next nFun

					SRJ->( dbSkip() )
				End
			Else
				For nFun := 1 To Len( aRisImp )

					aFuncTmp := aClone( aRisImp[ nFun , 2 ] )

					If ( nPosFun := aScan( aFuncTmp, { | x | x[ 1 ] == aRiscos[ nRisc, 4 ] } ) ) == 0
						aAdd( aRisImp[ nFun, 2 ], { aRiscos[ nRisc, 4 ], {} } )
						nPosFun := Len( aRisImp[ nFun, 2 ] )
					EndIf

					aTarTemp := aClone( aRisImp[ nFun, 2, nPosFun, 2 ] )

					If AllTrim( aRiscos[ nRisc , 6 ] ) == "*"

						dbSelectArea( "TN5" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "TN5", cFil ) )
						While TN5->( !Eof() ) .And. TN5->TN5_FILIAL == xFilial( "TN5", cFil )
							If ( nPosTar := aScan( aTarTemp, { | x | x == TN5->TN5_CODTAR } ) ) == 0
								aAdd( aRisImp[ nFun, 2, nPosFun, 2 ], TN5->TN5_CODTAR )
							EndIf
							TN5->( dbSkip() )
						End
					Else
						If ( nPosTar := aScan( aTarTemp, { | x | x == aRiscos[ nRisc, 6 ] } ) ) == 0
							aAdd( aRisImp[ nFun, 2, nPosFun, 2 ], aRiscos[ nRisc, 6 ] )
						EndIf
					EndIf
				Next nFun
			EndIf
		EndIf
	Next nRisc

	If Len( aRisImp ) > 0

		If nModeloImp == 1 //Modelo de Impressão .doc (Word.)
		
			For nImp1 := 1 To Len( aRisImp )
				
				nRegs := 0
				cMemo := ""
				cCusto := aRisImp[ nImp1, 1 ]
				
				If AllTrim( cCusto ) == "*"
					cMemo += Upper( STR0099 ) + ": " + STR0482 //"Todos"
					cMemo += "#*" + "#*" + "#*" + "#*" + "#*"
				Else
					dbSelectArea( "CTT" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "CTT", cFil ) + cCusto )
					cMemo += Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ) + "#*" + "#*" + "#*" + "#*" + "#*" //"Centro de Custo"
				EndIf

				cMemo += 	Upper( STR0549 ) + "#*" + ; //"Função"
							Upper( STR0568 ) + "#*" + ; //"Tarefa"
							Upper( STR0534 ) + "#*" + ; //"Descrição"
							Upper( STR0278 ) + "#*" + ; //"Tempo"
							Upper( STR0569 ) + "#*" //"Vestimenta"
				nRegs++

				For nImp2 := 1 To Len( aRisImp[ nImp1, 2 ] )
					
					cFuncao := aRisImp[ nImp1, 2, nImp2, 1 ]
					
					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SRJ", cFil ) + cFuncao )
					
					cFunImp := AllTrim( cFuncao ) + " - " + Capital( SRJ->RJ_DESC ) + "#*"

					For nImp3 := 1 To Len( aRisImp[ nImp1, 2, nImp2, 2 ] )
						
						cTarefa := aRisImp[ nImp1, 2, nImp2, 2, nImp3 ]

						cMemo += cFunImp
						dbSelectArea( "TN5" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "TN5", cFil ) + cTarefa )

						cMemo += AllTrim( cTarefa ) + " - " + AllTrim( Capital( TN5->TN5_NOMTAR ) ) + "#*"
						If TN5->( FieldPos( "TN5_DESCRI" ) ) > 0
							cMemo += Capital( TN5->TN5_DESCRI ) + "#*"
						Else
							cMemo += AllTrim( Capital( TN5->TN5_DESTAR + TN5->TN5_DESCR1 + TN5->TN5_DESCR2 + TN5->TN5_DESCR3 + TN5->TN5_DESCR4 ) ) + "#*"
						EndIf
						cMemo += TN5->TN5_HRDIA + "#*"
						cMemo += AllTrim( MsMM( TN5->TN5_VESSYP, 80 ) ) + "#*"

						nRegs++

					Next nImp3

				Next nImp2

				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_SetDocumentVar( oWord, "funcao_tarefa", cMemo )
				OLE_SetDocumentVar( oWord, "linhas_funcao_tarefa", nRegs )
				OLE_ExecuteMacro( oWord, "Funcao_Tarefa" )
				OLE_ExecuteMacro( oWord, "Somalinha" )
				OLE_ExecuteMacro( oWord, "Somalinha" )

			Next nImp1

		ElseIf nModeloImp == 3 //Modelo de Impressão grafico

			For nImp1 := 1 To Len( aRisImp )
				
				nRegs := 0
				cMemo := ""
				cCusto := aRisImp[ nImp1, 1 ]

				dbSelectArea( "CTT" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "CTT", cFil ) + cCusto )

				Somalinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2300 )

				If AllTrim( cCusto ) == "*"
					oPrintPPRA:Say( lin + 10, 175, Upper( STR0099 ) + ": " + STR0482, oFont08b ) //"Centro de Custo"##"Todos"
				Else
					oPrintPPRA:Say( lin + 10, 175, Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ), oFont08b ) //"Centro de Custo"
				EndIf

				Somalinha()

				oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
				oPrintPPRA:Line( lin, 0150, lin + 60, 0150 )
				oPrintPPRA:Line( lin, 0580, lin + 60, 0580 )
				oPrintPPRA:Line( lin, 1010, lin + 60, 1010 )
				oPrintPPRA:Line( lin, 1440, lin + 60, 1440 )
				oPrintPPRA:Line( lin, 1870, lin + 60, 1870 )
				oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
				oPrintPPRA:Say( lin + 10, 0365, STR0549, oFont08b, , , , 2 ) //"Função"
				oPrintPPRA:Say( lin + 10, 0795, STR0568, oFont08b, , , , 2 ) //"Tarefa"
				oPrintPPRA:Say( lin + 10, 1225, STR0534, oFont08b, , , , 2 ) //"Descrição"
				oPrintPPRA:Say( lin + 10, 1655, STR0570, oFont08b, , , , 2 ) //"Hora"
				oPrintPPRA:Say( lin + 10, 2085, STR0569, oFont08b, , , , 2 ) //"Vestimenta"

				For nImp2 := 1 To Len( aRisImp[ nImp1 , 2 ] )

					cFuncao := aRisImp[ nImp1 , 2 , nImp2 , 1 ]
					
					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SRJ", cFil ) + cFuncao )

					cFunImp := AllTrim( cFuncao ) + " - " + AllTrim( Capital( SRJ->RJ_DESC ) )
					nLimFun := MlCount( cFunImp, nCorte )
					nCntFun := 0

					For nImp3 := 1 To Len( aRisImp[ nImp1, 2, nImp2, 2 ] )

						cTarefa := aRisImp[ nImp1, 2, nImp2, 2, nImp3 ]

						dbSelectArea( "TN5" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "TN5", cFil ) + cTarefa )

						cTarefa := AllTrim( cTarefa ) + " - " + AllTrim( Capital( TN5->TN5_NOMTAR ) )

						If TN5->( FieldPos( "TN5_DESCRI" ) ) > 0
							cDescri := Capital( TN5->TN5_DESCRI )
						Else
							cDescri := AllTrim( Capital( TN5->TN5_DESTAR + TN5->TN5_DESCR1 + TN5->TN5_DESCR2 + TN5->TN5_DESCR3 + TN5->TN5_DESCR4 ) )
						EndIf

						cHora := TN5->TN5_HRDIA
						cVestim := AllTrim( MsMM( TN5->TN5_VESSYP, 80 ) )

						nLimFor := MlCount( cTarefa, nCorte )
						nLimFor := If( nLimFor > MlCount( cDescri, nCorte ), nLimFor, MlCount( cDescri, nCorte ) )
						nLimFor := If( nLimFor > MlCount( cHora, nCorte ), nLimFor, MlCount( cHora, nCorte ) )
						nLimFor := If( nLimFor > MlCount( cVestim, nCorte ), nLimFor, MlCount( cVestim, nCorte ) )

						For i := 1 To nLimFor

							If Lin >= 3000
								oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )
								Somalinha( (3100 - lin) + 1) //Força quebra de página
								oPrintPPRA:Line( lin, 150, lin, 2300 )
							Else

							Somalinha()

							EndIf 

							oPrintPPRA:Line( lin, 0150, lin + 60, 0150 )
							oPrintPPRA:Line( lin, 0580, lin + 60, 0580 )
							oPrintPPRA:Line( lin, 1010, lin + 60, 1010 )
							oPrintPPRA:Line( lin, 1440, lin + 60, 1440 )
							oPrintPPRA:Line( lin, 1870, lin + 60, 1870 )
							oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
							
							If nCntFun < nLimFun .And. !Empty( MemoLine( cFunImp, nCorte, nCntFun + 1 ) )
								nCntFun++
								oPrintPPRA:Say( lin + 10 , 170 , MemoLine( cFunImp, nCorte, nCntFun ), oFont08 )
							EndIf

							If !Empty( MemoLine( cTarefa, nCorte, i ) )
								oPrintPPRA:Say( lin + 10, 590, MemoLine( cTarefa, nCorte, i ), oFont08 )
							EndIf

							If !Empty( MemoLine( cDescri, nCorte, i ) )
								oPrintPPRA:Say( lin + 10, 1030, MemoLine( cDescri, nCorte, i ), oFont08 )
							EndIf

							If !Empty( MemoLine( cHora, nCorte, i ) )
								oPrintPPRA:Say( lin + 10, 1460, MemoLine( cHora, nCorte, i ), oFont08 )
							EndIf

							If !Empty( MemoLine( cVestim, nCorte, i ) )
								oPrintPPRA:Say( lin + 10, 1890, MemoLine( cVestim, nCorte, i ), oFont08 )
							EndIf

						Next i

						If nImp3 <> Len( aRisImp[ nImp1, 2, nImp2, 2 ] ) .Or. nLimFun < nCntFun
							oPrintPPRA:Line( lin + 60, 580, lin + 60, 2300 )
						EndIf

					Next nImp3

					If nCntFun + 1 <= nLimFun

						For i := nCntFun + 1 To nLimFun
							
							If nCntFun <> nLimFun
								Somalinha()
							EndIf

							oPrintPPRA:Line( lin, 0150, lin + 60, 0150 )
							oPrintPPRA:Line( lin, 0580, lin + 60, 0580 )
							oPrintPPRA:Line( lin, 1010, lin + 60, 1010 )
							oPrintPPRA:Line( lin, 1440, lin + 60, 1440 )
							oPrintPPRA:Line( lin, 1870, lin + 60, 1870 )
							oPrintPPRA:Line( lin, 2300, lin + 60, 2300 )
							
							If !Empty( MemoLine( cFunImp, nCorte, i ) )
								oPrintPPRA:Say( lin + 10, 170, MemoLine( cFunImp, nCorte, i ), oFont08 )
								nCntFun++
							EndIf

						Next i

					EndIf
				
					oPrintPPRA:Line( lin + 60, 150, lin + 60, 2300 )

				Next nImp2

			Next nImp1

		ElseIf nModeloImp == 2 //Modelo de Impressão padrão
		
			For nImp1 := 1 To Len( aRisImp )

				cCusto := aRisImp[ nImp1, 1 ]
				
				dbSelectArea( "CTT" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "CTT", cFil ) + cCusto )

				SomaLinha()

				If AllTrim( cCusto ) == "*"
					@ Li, 001 PSay Upper( STR0099 ) + ": " + STR0482 //"Centro de Custo"##"Todos"
				Else
					@ Li, 001 PSay Upper( STR0099 ) + ": " + AllTrim( cCusto ) + " - " + Capital( CTT->CTT_DESC01 ) //"Centro de Custo"
				EndIf

				For nImp2 := 1 To Len( aRisImp[ nImp1, 2 ] )

					cFuncao := aRisImp[ nImp1, 2, nImp2, 1 ]

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial( "SRJ", cFil ) + cFuncao )
					
					SomaLinha()
					
					@ Li, 015 PSay Upper( STR0549 ) + ": " + AllTrim( cFuncao ) + " - " + Capital( SRJ->RJ_DESC ) //"Função"

					For nImp3 := 1 To Len( aRisImp[ nImp1, 2, nImp2, 2 ] )

						cTarefa := aRisImp[ nImp1, 2, nImp2, 2, nImp3 ]

						dbSelectArea( "TN5" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "TN5", cFil ) + cTarefa )

						SomaLinha()

						@ Li, 030 PSay Upper( STR0568 ) + ": " + AllTrim( cTarefa ) + " - " + SubStr( AllTrim( Capital( TN5->TN5_NOMTAR ) ) , 1 , 80 ) //"Tarefa"

						If TN5->( FieldPos( "TN5_DESCRI" ) ) > 0
							cMemo := Capital( TN5->TN5_DESCRI )
						Else
							cMemo := AllTrim( Capital( TN5->TN5_DESTAR + TN5->TN5_DESCR1 + TN5->TN5_DESCR2 + TN5->TN5_DESCR3 + TN5->TN5_DESCR4 ) )
						EndIf

						nTamanho := 100 - Len( STR0534 + ": " ) //"Descrição"
						nLinhasMemo := MlCount( cMemo, nTamanho )

						//Percorre o memo e realiza a impressão linear
						For i := 1 To nLinhasMemo
							If i == 1
								SomaLinha()
								@ Li, 030 PSay STR0534 + ": " //"Descrição"
							Else
								SomaLinha()
							EndIf
							@ Li, 030 + Len( STR0534 + ": " ) PSay MemoLine( cMemo, nTamanho, i ) //"Descrição"
						Next i
						
						SomaLinha()

						@ Li, 030 PSay STR0278 + ": " + TN5->TN5_HRDIA //"Tempo"

						cVetimen := MsMM( TN5->TN5_VESSYP, 80 )
						nTamanho := 100 - Len( STR0569 + ": " ) //"Vestimenta"
						nLinhasMemo := MlCount( cVetimen, nTamanho )

						//Percorre o memo e realiza a impressão linear
						For i := 1 To nLinhasMemo
							If i == 1
								SomaLinha()
								@ Li , 030 PSay STR0569 + ": " //"Vestimenta"
							Else
								SomaLinha()
							EndIf
							@ Li , 030 + Len( STR0569 + ": " ) PSay MemoLine( cVetimen, nTamanho, i ) //"Vestimenta"
						Next i

						If nImp3 <> Len( aRisImp[ nImp1, 2, nImp2, 2 ] )
							SomaLinha()
						EndIf

					Next nImp3

				Next nImp2

			Next nImp1

			Somalinha()

		EndIf

	EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} fRiscos
Seleciona os Riscos do Laudo.

@author Jackson Machado
@since 29/09/2014

/*/
//---------------------------------------------------------------------
Static Function fRiscos()

	Local aRiscos := {}

	Local cNomCC := ''
	Local cNomFun := ''
	Local cNomTar := ''
	Local cNomAge := ''
	Local cOrdRis := IIf( nModeloImp == 1, mv_par05, mv_par03 ) //Modelo de Impressão .doc (Word.)
	Local cDeCenCus := IIf( nModeloImp == 1, mv_par11, mv_par09 )
	Local cAteCenCus := IIf( nModeloImp == 1, mv_par12, mv_par10 )

	dbSelectArea( "TO1" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TO1", cFil ) + Mv_par01 )

		While TO1->( !EoF() ) .And. xFilial( "TO1", cFil ) + Mv_par01 == TO1->TO1_FILIAL + TO1->TO1_LAUDO

			dbSelectArea( "TN0" )
			dbSetOrder( 1 )

			If dbSeek( xFilial( "TN0", cFil ) + TO1->TO1_NUMRIS ) .And. TN0->TN0_MAPRIS != "1" // Valida se o Mapa Risco é diferente de CIPA

				// Filtro de centro de custo de acordo com parâmetro do laudo
				If AllTrim( TN0->TN0_CC ) == '*' .Or. ( TN0->TN0_CC >= cDeCenCus .And. TN0->TN0_CC <= cAteCenCus )

					dbSelectArea( "TMA" )
					dbSetOrder( 1 )

					If dbSeek( xFilial( "TMA", cFil ) + TN0->TN0_AGENTE )

						If cAliasCC == "CTT"

							cNomCC  := AllTrim( NGSEEK( "CTT" , TN0->TN0_CC , 1 , "CTT_DESC01" ) )

						Else

							cNomCC  := AllTrim( NGSEEK( "SI3" , TN0->TN0_CC , 1 , "I3_DESC" ) )

						Endif

						cNomFun := AllTrim( NGSEEK( "SRJ" , TN0->TN0_CODFUN , 1 , "RJ_DESC" ) )
						cNomTar := AllTrim( SubStr( NGSEEK( "TN5" , TN0->TN0_CODTAR , 1 , "TN5_NOMTAR" ) , 1 , 40 ) )
						cNomFon := AllTrim( NGSEEK( "TN7" , TN0->TN0_FONTE , 1 , "TN7_NOMFON" ) )
						cNomAge := AllTrim( TMA->TMA_NOMAGE )

						aAdd( aRiscos, {;
							TN0->TN0_NUMRIS,;
							TN0->TN0_CC,;
							cNomCC,;
							TN0->TN0_CODFUN,;
							cNomFun,;
							TN0->TN0_CODTAR,;
							cNomTar,;
							TN0->TN0_AGENTE,;
							cNomAge,;
							TN0->TN0_FONTE,;
							cNomFon;
						} )

					EndIf

				EndIf

			Endif

			dbSelectArea( "TO1" )
			dbsetOrder( 1 )
			dbSkip()

		End

	EndIf

	If cOrdRis == 1

		aSort( aRiscos, , , { | x, y | x[ 9 ] + x [ 1 ] < y[ 9 ] + y[ 1 ] } ) // "Cód. Agente de risco"

	ElseIf cOrdRis == 4

		aSort( aRiscos, , , { | x, y | x[ 11 ] + x[ 1 ] < y[ 11 ] + y[ 1 ] } ) // "Cód. Fonte geradora"

	ElseIf cOrdRis == 3

		If ( nModeloImp == 1 .And. mv_par09 == 2 ) .Or. ( nModeloImp != 1 .And. mv_par07 == 2 )

			aSort( aRiscos, , , { | x, y | x[ 13 ] + x[ 5 ] + x[ 1 ] < y[ 3 ] + y[ 5 ] + y[ 1 ] } ) // "Cód. Centro de custo"

		Else
	
			aSort( aRiscos, , , { | x, y | x[ 3 ] + x[ 5 ] + x[ 1 ] < y[ 3 ] + y[ 5 ] + y[ 1 ] } ) // "Cód. Centro de custo"

		EndIf

	ElseIf cOrdRis == 5

		aSort( aRiscos, , , { | x, y | x[ 5 ] + x[ 3 ] + x[ 1 ] < y[ 5 ] + y[ 3 ] + y[ 1 ] } ) // "Cód. Função"

	Else

		aSort( aRiscos, , , { | x, y | x[ 1 ] < y[ 1 ] } )

	EndIf

Return aRiscos

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTPolicy
Realiza a busca das informações para a impressão do Atalho Política.

@type  Function
@author Bruno Souza
@since 27/07/2021

@param nModeloImp, Numérico, Se é modelo word, padrão ou gráfico
@param cLaudo, Caractere, Código do laudo
@param lValidCC, Booleano, Indica se deve filtrar ou não por centro de custo
@param cCcDe, Caractere, Filtro de centro de custo
@param cCcAte, Caractere, Filtro de centro de custo
@param nOrd, Numérico, Indica a ordem dos riscos a serem impressos
@param oPrint, Objeto, Objeto para a impressão
@param oWord, Objeto, Objeto para a impressão
@param cProgram, Caractere, Indica o programa que chamou a função

@return return_var, return_type, return_description
@example
(examples)
/*/
//-------------------------------------------------------------------
User Function MDTPolicy()

	Local nX
	Local cMemoDes, cMemoMis, cMemoVis, cMemoVal
	Local nLinDes, nLinMis, nLinVis, nLinVal
	Local nTamMax   := 80

	dbSelectArea("TAU")
	dbSetOrder(1)
	dbGoTop()
	While !Eof() .And. xFilial( 'TAU', cFil ) == TAU->TAU_FILIAL
		
		If !((TAU->TAU_FLAG == '2' .Or. TAU->TAU_FLAG == '3') .And.;
			(TAU->TAU_TIPO == '3' .Or. TAU->TAU_TIPO == '4') .And.;
			TAU->TAU_DTVIGE >= TO0->TO0_DTINIC)
			
			("TAU")->(dbSkip())
			Exit
		EndIf
		
		cMemoDes := Msmm( TAU->TAU_MMSYP,,,,  3 )
		cMemoMis := Msmm( TAU->TAU_MMMISS,,,, 3 )
		cMemoVis := Msmm( TAU->TAU_MMVISA,,,, 3 )
		cMemoVal := Msmm( TAU->TAU_MMVALO,,,, 3 )

		nLinDes := MlCount( cMemoDes, nTamMax )
		nLinMis := MlCount( cMemoMis, nTamMax )
		nLinVis := MlCount( cMemoVis, nTamMax )
		nLinVal := MlCount( cMemoVal, nTamMax )

		If nModeloImp == 1

			OLE_SetDocumentVar( oWord, 'cCodPol', TAU->TAU_CODPOL )
			OLE_SetDocumentVar( oWord, 'dDtVige', DToC(TAU->TAU_DTVIGE) )

			OLE_SetDocumentVar( oWord, 'cMemoDes', cMemoDes )
			OLE_SetDocumentVar( oWord, 'cMemoMis', cMemoMis )
			OLE_SetDocumentVar( oWord, 'cMemoVis', cMemoVis )
			OLE_SetDocumentVar( oWord, 'cMemoVal', cMemoVal )

			OLE_ExecuteMacro( oWord, 'politica' )

		ElseIf nModeloImp == 2
				SomaLinha()
			@Li, 010 PSay STR0571 + ": " + TAU->TAU_CODPOL
			@Li, 068 PSay STR0572 + ": " + DToC(TAU->TAU_DTVIGE)
			SomaLinha()
			For nX := 1 To nLinDes
				SomaLinha()
				@Li, 010 PSay MEMOLINE( cMemoDes, nTamMax, nX )
			Next nX

			If nLinMis > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				@Li, 010 PSay STR0573
				SomaLinha()
				For nX := 1 To nLinMis
					SomaLinha()
					@Li, 010 PSay MEMOLINE( cMemoMis, nTamMax, nX )
				Next nX
			EndIf

			If nLinVis > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				@Li, 010 PSay STR0574
				SomaLinha()
				For nX := 1 To nLinVis
					SomaLinha()
					@Li, 010 PSay MEMOLINE( cMemoVis, nTamMax, nX )
				Next nX
			EndIf

			If nLinVal > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				@Li, 010 PSay STR0575
				SomaLinha()
				For nX := 1 To nLinVal
					SomaLinha()
					@Li, 010 PSay MEMOLINE( cMemoVal, nTamMax, nX )
				Next nX
			EndIf
			
		ElseIf nModeloImp == 3
			
			SomaLinha()
			oPrintPPRA:Say( Lin, 220, STR0571 + ": " + TAU->TAU_CODPOL, oFont12b )
			oPrintPPRA:Say( Lin, 1040, STR0572 + ": " + DToC(TAU->TAU_DTVIGE), oFont12b )
			SomaLinha()
			For nX := 1 To nLinDes
				SomaLinha()
				oPrintPPRA:Say( Lin, 220, MEMOLINE( cMemoDes, nTamMax, nX ), oFont12 )
			Next nX

			If nLinMis > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				oPrintPPRA:Say( Lin, 1040, STR0573, oFont12bs )
				SomaLinha()
				For nX := 1 To nLinMis
					SomaLinha()
					oPrintPPRA:Say( Lin, 220, MEMOLINE( cMemoMis, nTamMax, nX ), oFont12 )
				Next nX
			EndIf

			If nLinVis > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				oPrintPPRA:Say( Lin, 1045, STR0574, oFont12bs )
				SomaLinha()
				For nX := 1 To nLinVis
					SomaLinha()
					oPrintPPRA:Say( Lin, 220, MEMOLINE( cMemoVis, nTamMax, nX ), oFont12 )
				Next nX
			EndIf

			If nLinVal > 0
				SomaLinha()
				SomaLinha()
				SomaLinha()
				oPrintPPRA:Say( Lin, 1035,STR0575,oFont12bs )
				SomaLinha()
				For nX := 1 To nLinVal
					SomaLinha()
					oPrintPPRA:Say( Lin, 220, MEMOLINE( cMemoVal, nTamMax, nX ), oFont12 )
				Next nX
			EndIf

			oPrintPPRA:EndPage()
		EndIf
		("TAU")->(dbSkip())
	End

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A850ACI
Imprime o atalho de acidente sem vítimas.

@author Gabriel Sokacheski
@since 12/10/2021

/*/
//---------------------------------------------------------------------
Static Function A850ACI()

	Local aImprime := {}  // Array dos acidentes que serão impressos, agrupados por centro de custo
	Local aAcidentes := {}

	Local cTNC := xFilial( 'TNC', cFil )
	Local cTNM := xFilial( 'TNM', cFil )
	Local cTNL := xFilial( 'TNL', cFil )
	Local cAlias := GetNextAlias()
	Local cTamTNC := Space( TamSx3( 'TNC_CC' )[ 1 ] )
	Local cDeCenCus := IIf( nModeloImp == 1, mv_par11, mv_par09 )
	Local cRegistros := ''
	Local cAteCenCus := IIf( nModeloImp == 1, mv_par12, mv_par10 )

	Local dDtFim := IIf( Empty( TO0->TO0_DTFIM ), Date(), TO0->TO0_DTFIM )

	Local nI := 0
	Local nY := 0
	Local nTotalMat := 0
	Local nTotalAci := 0
	Local nMaterial := 0
	Local nAcidentes := 0

	// Busca os acidentes
	BeginSQL Alias cAlias
		SELECT 
			TNC.TNC_CC, (
				SELECT 
					SUM( TNM.TNM_VALDES )
				FROM 
					%table:TNM% TNM
					INNER JOIN %table:TNL% TNL ON
						TNL.TNL_CODDES = TNM.TNM_CODDES
						AND TNL.TNL_FILIAL = %exp:cTNL%
						AND TNL.%NotDel%
				WHERE 
					TNM.TNM_FILIAL = %exp:cTNM%
					AND TNM.TNM_ACIDEN = TNC.TNC_ACIDEN
					AND TNM.%NotDel%
			) TNC_VALOR // Valor total das despesas do acidente
		FROM 
			%table:TNC% TNC
		WHERE 
			%exp:cTNC% = TNC.TNC_FILIAL
			AND TNC.TNC_VITIMA = '2' // Sem vítima
			AND TNC_DTACID >= %exp:TO0->TO0_DTINIC% AND TNC_DTACID <= %exp:dDtFim% // Período do laudo
			AND TNC.TNC_CC != %exp:cTamTNC% // Centro de custo obrigatório
			AND TNC.%NotDel%
		ORDER BY TNC.TNC_CC, TNC.TNC_CATINS, TNC.TNC_TIPCAT
	EndSQL

	dbSelectArea( cAlias )
	dbGoTop()

	While !Eof()

		aAdd( aAcidentes, {;
			( cAlias )->( TNC_CC ),;
			( cAlias )->( TNC_VALOR );
		} )

		( cAlias )->( dbSkip() )

	End

	( cAlias )->( dbCloseArea() )

	If Len( aAcidentes ) > 0

		// Agrupa os acidentes por centro de custo para impressão do atalho
		For nI := 1 To Len( aAcidentes )

			nAcidentes += 1
			nMaterial += aAcidentes[ nI, 2 ]

			nTotalAci += 1
			nTotalMat += aAcidentes[ nI, 2 ]

			// Se este é o último registro do centro de custo, então imprime
			If AScan( aAcidentes, { | x | x[ 1 ] == aAcidentes[ nI, 1 ] }, nI + 1 ) == 0

				// Imprime somente de acordo com o filtro do laudo
				If AllTrim( aAcidentes[ nI, 1 ] ) >= AllTrim( cDeCenCus ) .And. AllTrim( aAcidentes[ nI, 1 ] ) <= AllTrim( cAteCenCus )

					aAdd( aImprime, { aAcidentes[ nI, 1 ], nAcidentes, nMaterial, '' } )

				EndIf

				nAcidentes := 0
				nMaterial := 0

			EndIf

			If nI == Len( aAcidentes )

				// Adiciona os valores da linha final da tabela, contendo as somas de todos os registros
				aAdd( aImprime, { 'Total', nTotalAci, nTotalMat, '' } )

			EndIf

		Next

		If nModeloImp == 1

			For nI := 1 To Len( aImprime )

				For nY := 1 To Len( aImprime[ nI ] )

					If ValType( aImprime[ nI, nY ] ) == 'N'

						If nY == 3 // Caso seja o valor dos materiais, coloca 2 casas decimais

							cRegistros += AllTrim( Str( aImprime[ nI, nY ], Len( Str( aImprime[ nI, nY ] ) ) + 2, 2 ) ) + '#'

						Else

							cRegistros += AllTrim( Str( aImprime[ nI, nY ] ) ) + '#'

						EndIf

					Else

						cRegistros += aImprime[ nI, nY ] + '#'

					EndIf

				Next

			Next

			OLE_SetDocumentVar( oWord, 'Registros', cRegistros )
			OLE_SetDocumentVar( oWord, 'Titulo', STR0576 )
			OLE_SetDocumentVar( oWord, 'Linhas', Len( aImprime ) + 2 )
			OLE_SetDocumentVar( oWord, 'Periodo', SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim ) )
			OLE_SetDocumentVar( oWord, 'Setor', STR0578 )
			OLE_SetDocumentVar( oWord, 'Numero', STR0579 )
			OLE_SetDocumentVar( oWord, 'Perda', STR0580 )
			OLE_SetDocumentVar( oWord, 'Observacao', STR0581 )

			OLE_ExecuteMacro( oWord, 'acidentes_sem_vitimas' )

		ElseIf nModeloImp == 2

			SomaLinha()

			@ Li, 30 PSay STR0576 + ' - ' + SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim )

			SomaLinha()
			SomaLinha()

			For nI := 1 To Len( aImprime )

				@ Li, 0 PSay STR0578 + ': ' + aImprime[ nI, 1 ]

				SomaLinha()

				@ Li, 0 PSay STR0579 + ': ' + AllTrim( Str( aImprime[ nI, 2 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0580 + ': ' + AllTrim( Str( aImprime[ nI, 3 ], Len( Str( aImprime[ nI, 3 ] ) ) + 2, 2 ) )

				SomaLinha()

				@ Li, 0 PSay STR0581 + ': ' // Campo em branco

				SomaLinha()

				SomaLinha()

			Next

		Else

			SomaLinha()

			oPrintPPRA:Say( lin, 700, STR0576 + ' - ' + SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim ), oFont10b )

			SomaLinha()

			For nI := 1 To Len( aImprime )

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 670, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0578 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 700, aImprime[ nI, 1 ], oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 670, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0579 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 700, AllTrim( Str( aImprime[ nI, 2 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 670, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0580 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 700, AllTrim( Str( aImprime[ nI, 3 ], Len( Str( aImprime[ nI, 3 ] ) ) + 2, 2 ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 670, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0581 + ': ', oFont10b )
				SomaLinha()

				If lin != 300

					SomaLinha()

				EndIf

			Next

		EndIf

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} A850ACIVIT
Imprime o atalho de acidente com vítimas.

@author Gabriel Sokacheski
@since 12/10/2021

/*/
//---------------------------------------------------------------------
Static Function A850ACIVIT()

	Local aImprime := {}
	Local aAcidentes := {}

	Local cTNC := xFilial( 'TNC', cFil )
	Local cAlias := GetNextAlias()
	Local cTamTNC := Space( TamSx3( 'TNC_CC' )[ 1 ] )
	Local cJornada := IIf( nModeloImp == 1, mv_par16, mv_par14 )
	Local cDeCenCus := IIf( nModeloImp == 1, mv_par11, mv_par09 )
	Local cRegistros := ''
	Local cAteCenCus := IIf( nModeloImp == 1, mv_par12, mv_par10 )

	Local dDtFim := IIf( Empty( TO0->TO0_DTFIM ), Date(), TO0->TO0_DTFIM )

	Local nI := 0
	Local nY := 0
	Local nTaxa := 0
	Local nUteis := IIf( nModeloImp == 1, mv_par17, mv_par15 )
	Local nQtdFun := 0
	Local nIndice := 0
	Local nQtdVit := 0
	Local nHrsFun := 0
	Local nObitos := 0
	Local nQtdTaxa := 0
	Local nGravida := 0
	Local nTotalGra := 0
	Local nTotalObi := 0
	Local nTotalVit := 0
	Local nTotalInd := 0
	Local nTotalAci := 0
	Local nMaisde15 := 0
	Local nTotalHom := 0
	Local nDiasHomem := 0
	Local nMenosde15 := 0
	Local nSemAfasta := 0
	Local nTotalMe15 := 0
	Local nTotalMa15 := 0
	Local nTotalSAfa := 0
	Local nAcidentes := 0

	// Busca os acidentes
	BeginSQL Alias cAlias
		SELECT 
			TNC.TNC_CC, TNC.TNC_AFASTA, TNC.TNC_QTAFAS, TNC.TNC_VITIMA, TNC.TNC_HRTRAB, 
			TNC.TNC_DIASDB, TNC.TNC_DTACID
		FROM 
			%table:TNC% TNC
		WHERE 
			%exp:cTNC% = TNC.TNC_FILIAL
			AND TNC.TNC_VITIMA != '2' // Com vítima
			AND TNC_DTACID >= %exp:TO0->TO0_DTINIC% AND TNC_DTACID <= %exp:dDtFim% // Período do laudo
			AND TNC.TNC_CC != %exp:cTamTNC% // Centro de custo obrigatório
			AND TNC.%NotDel%
		ORDER BY TNC.TNC_CC, TNC.TNC_CATINS, TNC.TNC_TIPCAT
	EndSQL

	dbSelectArea( cAlias )
	dbGoTop()

	While !Eof()

		aAdd( aAcidentes, {;
			AllTrim( ( cAlias )->( TNC_CC ) ),;
			AllTrim( ( cAlias )->( TNC_AFASTA ) ),;
			( cAlias )->( TNC_QTAFAS ),;
			AllTrim( ( cAlias )->( TNC_VITIMA ) ),;
			AllTrim( ( cAlias )->( TNC_HRTRAB ) ),;
			( cAlias )->( TNC_DIASDB ),;
			( cAlias )->( TNC_DTACID );
		} )

		( cAlias )->( dbSkip() )

	End

	( cAlias )->( dbCloseArea() )

	If Len( aAcidentes ) > 0

		// Agrupa os acidentes por centro de custo para impressão do atalho
		For nI := 1 To Len( aAcidentes )

			nAcidentes += 1
			nQtdVit += 1

			nTotalAci += 1
			nTotalVit += 1

			If aAcidentes[ nI, 4 ] == '3' // Vítima foi a óbito

				nObitos += 1

				nTotalObi += 1

			EndIf

			If aAcidentes[ nI, 2 ] == '1' // Acidentado foi afastado

				nDiasHomem += fDiasHomem( aAcidentes[ nI, 3 ], aAcidentes[ nI, 6 ], StoD( aAcidentes[ nI, 7 ] ), dDtFim, aAcidentes[ nI, 5 ] )
				nTotalHom += nDiasHomem

				If aAcidentes[ nI, 3 ] <= 15

					nMenosde15 += 1
					nTotalMe15 += 1

				Else

					nMaisde15 += 1
					nTotalMa15 += 1

				EndIf

			Else

				nSemAfasta += 1
				nTotalSAfa += 1

			EndIf

			// Se este é o último registro do centro de custo, então imprime
			If AScan( aAcidentes, { | x | x[ 1 ] == aAcidentes[ nI, 1 ] }, nI + 1 ) == 0 

				// Cálculos que precisam de todos os dados dos acidentes do mesmo centro de custo
				nQtdFun := fQtdFun( .T., aAcidentes[ nI, 1 ] )
				nIndice := ( ( nQtdVit * 100 ) / nQtdFun )
				nHrsFun := nQtdFun * nUteis * mdt865conv( cJornada )
				nTaxa := ( ( nQtdVit * 1000000 ) / nHrsFun )
				nGravida := ( ( fDiasHomem( aAcidentes[ nI, 3 ], aAcidentes[ nI, 6 ], StoD( aAcidentes[ nI, 7 ] ), dDtFim, aAcidentes[ nI, 5 ] ) ) / nQtdVit )

				// Imprime somente de acordo com o filtro do laudo
				If AllTrim( aAcidentes[ nI, 1 ] ) >= AllTrim( cDeCenCus ) .And. AllTrim( aAcidentes[ nI, 1 ] ) <= AllTrim( cAteCenCus )

					aAdd( aImprime, {;
						aAcidentes[ nI, 1 ],;
						nAcidentes,;
						nMenosde15,;
						nMaisde15,;
						nSemAfasta,;
						nIndice,;
						nDiasHomem,;
						nTaxa,;
						nObitos,;
						nGravida;
					} )

				EndIf

				nAcidentes := 0
				nMenosde15 := 0
				nMaisde15 := 0
				nSemAfasta := 0
				nQtdVit := 0
				nDiasHomem := 0
				nObitos := 0

			EndIf

			If nI == Len( aAcidentes )

				nQtdFun := fQtdFun( .F. )
				nTotalInd := ( ( nTotalVit * 100 ) / nQtdFun )
				nHrsFun := nQtdFun * nUteis * mdt865conv( cJornada )
				nQtdTaxa := ( ( nTotalVit * 1000000 ) / nHrsFun )
				nTotalGra := ( ( fDiasHomem( aAcidentes[ nI, 3 ], aAcidentes[ nI, 6 ], StoD( aAcidentes[ nI, 7 ] ), dDtFim, aAcidentes[ nI, 5 ] ) ) / nTotalVit )

				// Adiciona os valores da linha final da tabela, contendo as somas de todos os registros
				aAdd( aImprime, {;
					'Total',;
					nTotalAci,;
					nTotalMe15,;
					nTotalMa15,;
					nTotalSAfa,;
					nTotalInd,;
					nTotalHom,;
					nQtdTaxa,;
					nTotalObi,;
					nTotalGra;
				} )

			EndIf

		Next

		If nModeloImp == 1

			OLE_SetDocumentVar( oWord, 'Titulo', STR0582 )
			OLE_SetDocumentVar( oWord, 'Periodo', SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim ) )

			OLE_ExecuteMacro( oWord, 'acidentes_com_vitimas_cabecalho' )

			For nI := 1 To Len( aImprime )

				cRegistros := ''

				For nY := 1 To Len( aImprime[ nI ] )

					If ValType( aImprime[ nI, nY ] ) == 'N'

						If nY == 6 .Or. nY == 7 .Or. nY == 8 .Or. nY == 10 // Em valores decimais, deixa com 2 casas decimais

							cRegistros += AllTrim( Str( aImprime[ nI, nY ], Len( Str( aImprime[ nI, nY ] ) ), 4 ) ) + '#'

						Else

							cRegistros += AllTrim( Str( aImprime[ nI, nY ] ) ) + '#'

						EndIf

					Else

						cRegistros += aImprime[ nI, nY ] + '#'

					EndIf

				Next

				OLE_SetDocumentVar( oWord, 'Registros', cRegistros )
				OLE_SetDocumentVar( oWord, 'Setor', STR0578 )
				OLE_SetDocumentVar( oWord, 'Numero', STR0583 )
				OLE_SetDocumentVar( oWord, 'Menor15', STR0584 )
				OLE_SetDocumentVar( oWord, 'Maior15', STR0585 )
				OLE_SetDocumentVar( oWord, 'Afastamento', STR0586 )
				OLE_SetDocumentVar( oWord, 'Indice', STR0587 )
				OLE_SetDocumentVar( oWord, 'Dias', STR0588 )
				OLE_SetDocumentVar( oWord, 'Taxa', STR0589 )
				OLE_SetDocumentVar( oWord, 'Obitos', STR0590 )
				OLE_SetDocumentVar( oWord, 'Gravidade', STR0591 )

				OLE_ExecuteMacro( oWord, 'acidentes_com_vitimas_tabela' )

			Next

		ElseIf nModeloImp == 2

			SomaLinha()

			@ Li, 30 PSay STR0582 + ' - ' + SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim )

			SomaLinha()
			SomaLinha()

			For nI := 1 To Len( aImprime )

				@ Li, 0 PSay STR0578 + ': ' + aImprime[ nI, 1 ]

				SomaLinha()

				@ Li, 0 PSay STR0583 + ': ' + AllTrim( Str( aImprime[ nI, 2 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0584 + ': ' + AllTrim( Str( aImprime[ nI, 3 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0585 + ': ' + AllTrim( Str( aImprime[ nI, 4 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0586 + ': ' + AllTrim( Str( aImprime[ nI, 5 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0587 + ': ' + AllTrim( Str( aImprime[ nI, 6 ], Len( Str( aImprime[ nI, 6 ] ) ), 4 ) )

				SomaLinha()

				@ Li, 0 PSay STR0588 + ': ' + AllTrim( Str( aImprime[ nI, 7 ], Len( Str( aImprime[ nI, 7 ] ) ), 4 ) )

				SomaLinha()

				@ Li, 0 PSay STR0589 + ': ' + AllTrim( Str( aImprime[ nI, 8 ], Len( Str( aImprime[ nI, 8 ] ) ), 4 ) )

				SomaLinha()

				@ Li, 0 PSay STR0590 + ': ' + AllTrim( Str( aImprime[ nI, 9 ] ) )

				SomaLinha()

				@ Li, 0 PSay STR0591 + ': ' + AllTrim( Str( aImprime[ nI, 10 ], Len( Str( aImprime[ nI, 10 ] ) ), 4 ) )

				SomaLinha()
				SomaLinha()

			Next

		Else

			SomaLinha()

			oPrintPPRA:Say( lin, 700, STR0582 + ' - ' + SubStr( STR0577, 1, 11 ) + DtoC( TO0->TO0_DTINIC ) + SubStr( STR0577, 11 ) + DtoC( dDtFim ), oFont10b )

			SomaLinha()

			For nI := 1 To Len( aImprime )

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0578 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, aImprime[ nI, 1 ], oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0583 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 2 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0584 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 3 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0585 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 4 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0586 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 5 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0587 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 6 ], Len( Str( aImprime[ nI, 6 ] ) ), 4 ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0588 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 7 ], Len( Str( aImprime[ nI, 7 ] ) ), 4 ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0589 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 8 ], Len( Str( aImprime[ nI, 8 ] ) ), 4 ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0590 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 9 ] ) ), oFont10 )
				SomaLinha()

				oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
				oPrintPPRA:Box( lin, 1170, lin + 60, 2390 )
				oPrintPPRA:Say( lin + 15, 170, STR0591 + ': ', oFont10b )
				oPrintPPRA:Say( lin + 15, 1200, AllTrim( Str( aImprime[ nI, 10 ], Len( Str( aImprime[ nI, 10 ] ) ), 4 ) ), oFont10 )
				SomaLinha()

				SomaLinha()

			Next

		EndIf

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDiasHomem
Faz o cálculo de dias por homens perdidos para atalho de acidentes.

@author Gabriel Sokacheski
@since 19/10/2021

@param nQtAfas, numérico, campo da tabela TNC (qtd de dias perdidos)
@param nDiasDb, numérico, campo da tabela TNC (qtd de dias debitados)
@param dDtAcid, data, campo da tabela TNC (data do acidente)
@param dDtFim, data, data final do laudo
@param nHoras, numérico, campo da tabela TNC (horas trabalhadas)

@return nResultado, numérico, retorna o resultado da conta
/*/
//---------------------------------------------------------------------
Static Function fDiasHomem( nQtAfas, nDiasDb, dDtAcid, dDtFim, nHoras )

	Local cJornada := IIf( nModeloImp == 1, mv_par16, mv_par14 )

	Local nHrDia := 0
	Local nHrTrab := 0
	Local nMaxDias := 0
	Local nJornada := mdt865conv( cJornada )
	Local nQtDiasPer := 0
	Local nResultado := 0

	nMaxDias := Max( nQtAfas, nDiasDb )

	If DaySum( dDtAcid, nMaxDias ) > dDtFim

		nMaxDias := DateDiffDay( dDtAcid, dDtFim )

	EndIf

	nQtDiasPer += nMaxDias

	If nMaxDias == 0

		nHrTrab := mdt865conv( nHoras )

		If !Empty( nHoras ) .And. nHrTrab > 0 .And. nHrTrab < nJornada

			nHrDia += nJornada - nHrTrab

		Endif

	Endif

	nResultado := ( ( ( nQtDiasPer * nJornada ) + nHrDia ) / nJornada )

Return nResultado

//---------------------------------------------------------------------
/*/{Protheus.doc} fQtdFun
Busca a quantidade de funcionários da empresa.

@author Gabriel Sokacheski
@since 19/10/2021

@param lFilCC, lógico, indica se filtra por centro de custo
@param cCC, caractere, centro de custo para filtrar os funcionários

@return nResultado, numérico, retorna a quantidade de funcionários da filial
/*/
//---------------------------------------------------------------------
Static Function fQtdFun( lFilCC, cCC )

	Local aArea := GetArea()

	Local cSRA := xFilial( 'SRA', cFil )
	Local cAlias := GetNextAlias()

	Local nQtdFun := 0

	If lFilCC

		BeginSQL Alias cAlias
			SELECT 
				COUNT( SRA.RA_MAT ) QTDFUN
			FROM 
				%table:SRA% SRA
			WHERE 
				%exp:cSRA% = SRA.RA_FILIAL
				AND SRA.RA_CC = %exp:cCC%
				AND SRA.%NotDel%
		EndSQL

	Else

		BeginSQL Alias cAlias
			SELECT 
				COUNT( SRA.RA_MAT ) QTDFUN
			FROM 
				%table:SRA% SRA
			WHERE 
				%exp:cSRA% = SRA.RA_FILIAL
				AND SRA.%NotDel%
		EndSQL

	EndIf

	dbSelectArea( cAlias )
	dbGoTop()

	While !Eof()

		nQtdFun := ( cAlias )->( QTDFUN )

		Exit

	End

	( cAlias )->( dbCloseArea() )

	RestArea( aArea )

Return nQtdFun

//---------------------------------------------------------------------
/*/{Protheus.doc} fBusAnaPre
Busca o atalho de análise preliminar

@author Gabriel Sokacheski
@since 06/09/2022

/*/
//---------------------------------------------------------------------
Static Function fBusAnaPre()

	Local aAnalise := {}

	//--------------------
	// Análise preliminar
	//--------------------

	DbSelectArea( 'TG6' )
	DbSetOrder( 1 ) // TG6_FILIAL + TG6_ORDEM + TG6_CODPER

	While ( 'TG6' )->( !Eof() ) .And. xFilial( 'TG6', cFil ) == TG6->TG6_FILIAL

		aAdd( aAnalise, TG6->TG6_ORDEM ) // Número da ordem [1]
		aAdd( aAnalise, DtoC( TG6->TG6_DTRESU ) ) // Data [2]
		aAdd( aAnalise, TG6->TG6_NUMRIS ) // Risco [3]

		//--------
		// Perigo
		//--------

		DbSelectArea( 'TG1' )
		DbSetOrder( 1 ) // TG1_FILIAL + TG1_CODPER

		If DbSeek( xFilial( 'TG1', cFil ) + TG6->TG6_CODPER )

			aAdd( aAnalise, Capital( TG1->TG1_DESCRI ) ) // Perigo [4]
			aAdd( aAnalise, Capital( Posicione( 'TMA', 1, xFilial( 'TMA', cFil ) + TG1->TG1_AGENTE, 'TMA_NOMAGE' ) ) ) // Agente [5]
			aAdd( aAnalise, Capital( Posicione( 'TN7', 1, xFilial( 'TN7', cFil ) + TG1->TG1_FONTE, 'TN7_NOMFON' ) ) ) // Fonte [6]
			aAdd( aAnalise, AllTrim( TG1->TG1_OBSERV ) ) // Observação [7]

		EndIf

		//------
		// Dano
		//------

		DbSelectArea( 'TG8' )
		DbSetOrder( 1 ) // TG8_FILIAL + TG8_CODDAN

		If DbSeek( xFilial( 'TG8', cFil ) + TG6->TG6_CODDAN )

			aAdd( aAnalise, Capital( TG8->TG8_DESCRI ) ) // Dano [8]
			aAdd( aAnalise, AllTrim( TG8->TG8_OBSERV ) ) // Observação [9]

		EndIf

		fImpAnaPre( aAnalise )

		aAnalise := {}
		( 'TG6' )->( DbSkip() )

	End

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpAnaPre
Imprime o atalho de análise preliminar

@author Gabriel Sokacheski
@since 14/09/2022

@param, aAnalise, informações a serem impressas

/*/
//---------------------------------------------------------------------
Static Function fImpAnaPre( aAnalise )

	Local cLista := ''
	Local cTitulos := ''

	Local nMemo := 0, nLinha := 0

	If nModeloImp == 1 // Word

		cTitulos += STR0617 + ' - ' + aAnalise[ 1 ] + '@' // "Análise preliminar"
		cTitulos += STR0618 + ':' + '#' // "Data"
		cTitulos += STR0619 + ':' + '#' // "Risco gerado"
		cTitulos += STR0620 + ':' + '#' // "Perigo"
		cTitulos += STR0523 + ':' + '#' // "Agente"
		cTitulos += STR0567 + ':' + '#' // "Fonte"
		cTitulos += STR0621 + ':' + '#' // "Observação"
		cTitulos += STR0622 + ':' + '#' // "Dano"
		cTitulos += STR0621 + ':' + '#' // "Observação"

		cLista += aAnalise[ 2 ] + '#'
		cLista += aAnalise[ 3 ] + '#'
		cLista += aAnalise[ 4 ] + '#'
		cLista += aAnalise[ 5 ] + '#'
		cLista += aAnalise[ 6 ] + '#'
		cLista += aAnalise[ 7 ] + '#'
		cLista += aAnalise[ 8 ] + '#'
		cLista += aAnalise[ 9 ] + '#'

		OLE_SetDocumentVar( oWord, 'titulos_analise', cTitulos )
		OLE_SetDocumentVar( oWord, 'analise_preliminar', cLista )
		OLE_ExecuteMacro( oWord, 'analise_preliminar' )

	ElseIf nModeloImp == 2 // Padrão

		SomaLinha()
		@ Li, 50 PSay STR0617 + ' - ' + aAnalise[ 1 ] // "Análise preliminar"

		SomaLinha()
		@ Li, 0 PSay STR0618 + ':' + Space( 1 ) + aAnalise[ 2 ] // "Data"

		SomaLinha()
		@ Li, 0 PSay STR0619 + ':' + Space( 1 ) + aAnalise[ 3 ] // "Risco gerado"

		SomaLinha()
		@ Li, 0 PSay STR0620 + ':' + Space( 1 ) + aAnalise[ 4 ] // "Perigo"

		SomaLinha()
		@ Li, 0 PSay STR0523 + ':' + Space( 1 ) + aAnalise[ 5 ] // "Agente"

		SomaLinha()
		@ Li, 0 PSay STR0567 + ':' + Space( 1 ) + aAnalise[ 6 ] // "Fonte"

		SomaLinha()
		@ Li, 0 PSay STR0621 + ':' // "Observação"

		nMemo := MlCount( aAnalise[ 7 ], 110 )

		For nLinha := 1 To nMemo

			SomaLinha()
			@ Li, 0 PSay MemoLine( aAnalise[ 7 ], 110, nLinha )

		Next nMemo

		SomaLinha()
		@ Li, 0 PSay STR0622 + ':' + Space( 1 ) + aAnalise[ 8 ] // "Dano"

		SomaLinha()
		@ Li, 0 PSay STR0621 + ':' // "Observação"

		nMemo := MlCount( aAnalise[ 9 ], 110 )

		For nLinha := 1 To nMemo

			SomaLinha()
			@ Li, 0 PSay MemoLine( aAnalise[ 9 ], 110, nLinha )

		Next nMemo

		SomaLinha()

	Else // Gráfico

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 1100, STR0617 + ' - ' + aAnalise[ 1 ], oFont10b ) // "Análise preliminar"

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0618 + ':', oFont10b ) // "Data"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 2 ], oFont10 )

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0619 + ':', oFont10b ) // "Risco gerado"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 3 ], oFont10 )

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0620 + ':', oFont10b ) // "Perigo"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 4 ], oFont10 )

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0523 + ':', oFont10b ) // "Agente"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 5 ], oFont10 )

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0567 + ':', oFont10b ) // "Fonte"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 6 ], oFont10 )

		SomaLinha()
		nMemo := MlCount( aAnalise[ 7 ], 110 )
		oPrintPPRA:Box( lin, 150, lin + ( 60 * nMemo ) + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0621 + ':', oFont10b ) // "Observação"

		For nLinha := 1 To nMemo

			SomaLinha()
			oPrintPPRA:Say( lin + 15, 170, MemoLine( aAnalise[ 7 ], 110, nLinha ), oFont10 )

		Next nMemo

		SomaLinha()
		oPrintPPRA:Box( lin, 150, lin + 60, 2390 )
		oPrintPPRA:Box( lin, 870, lin + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0622 + ':', oFont10b ) // "Dano"
		oPrintPPRA:Say( lin + 15, 900, aAnalise[ 8 ], oFont10 )

		SomaLinha()
		nMemo := MlCount( aAnalise[ 9 ], 110 )
		oPrintPPRA:Box( lin, 150, lin + ( 60 * nMemo ) + 60, 2390 )
		oPrintPPRA:Say( lin + 15, 170, STR0621 + ':', oFont10b ) // "Observação"

		For nLinha := 1 To nMemo

			SomaLinha()
			oPrintPPRA:Say( lin + 15, 170, MemoLine( aAnalise[ 9 ], 110, nLinha ), oFont10 )

		Next nMemo

		SomaLinha()

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fPerguntas
Retorna a ordem original dos parâmetros.

@author Gabriel Sokacheski
@since 08/06/2022

/*/
//---------------------------------------------------------------------
Static Function fPerguntas()

	Local xPar01 := mv_par01
	Local xPar02 := mv_par02
	Local xPar03 := mv_par03
	Local xPar04 := mv_par04
	Local xPar05 := mv_par05
	Local xPar06 := mv_par06
	Local xPar07 := mv_par07
	Local xPar08 := mv_par08
	Local xPar09 := mv_par09
	Local xPar10 := mv_par10
	Local xPar11 := mv_par11
	Local xPar12 := mv_par12
	Local xPar13 := mv_par13
	Local xPar14 := mv_par14
	Local xPar15 := mv_par15
	Local xPar16 := mv_par16
	Local xPar17 := mv_par17
	Local xPar18 := mv_par18
	Local xPar19 := mv_par19

	If nModeloImp == 1

		/*Ordem original
		1 Laudo?
		2 Coordenador?
		3 Impressão?
		4 Arquivo saída?
		5 Ordenar riscos por?
		6 Ordenar equipamentos por?
		7 Ordenar plano de ação por?
		8 Imprime qtd.func. e funções?
		9 Imprimir imagens?
		10 Imprimir data de avaliação?
		11 De centro de custo?
		12 Até centro de custo?
		13 Considerar por?
		14 De filial?
		15 Até filial?
		16 Jornada de trabalho?
		17 Dias úteis do ano?
		18 Atalho não expostos?
		19 Imprimir junto ao risco?
		20 Imprimir matriz de risco?*/

		/*Nova ordem
		1 Laudo?
		2 Coordenador?
		3 De filial?
		4 Ate filial?
		5 De centro de custo?
		6 Ate centro de custo?
		7 Impressao?
		8 Arquivo saida?
		9 Ordenar riscos por?
		10 Imprimir data de avaliação?
		11 Imprimir imagens?
		12 Imprimir junto ao risco?
		13 Imprimir matriz de risco?
		14 Considerar por?
		15 Ordenar equipamentos por?
		16 Ordenar plano de ação por?
		17 Imprime qtd. func. e funções?
		18 Jornada de trabalho?
		19 Dias uteis do ano?
		*/

		If ValType( mv_par05 ) == 'C' // Verifica se possui o SX1 atualizado

			mv_par01 := xPar01
			mv_par02 := xPar02
			mv_par03 := xPar07
			mv_par04 := xPar08
			mv_par05 := xPar09
			mv_par06 := xPar15
			mv_par07 := xPar16
			mv_par08 := xPar17
			mv_par09 := xPar11
			mv_par10 := xPar10
			mv_par11 := xPar05
			mv_par12 := xPar06
			mv_par13 := xPar14
			mv_par14 := xPar03
			mv_par15 := xPar04
			mv_par16 := xPar18
			mv_par17 := xPar19
			mv_par19 := xPar12
			mv_par20 := xPar13

		EndIf

	Else

		/*Ordem original
		1 Laudo?
		2 Coordenador?
		3 Ordenar riscos por?
		4 Ordenar equipamentos por?
		5 Ordenar plano de ação por?
		6 Imprime qtd.func. e funções?
		7 Imprimir imagens?
		8 Imprimir data de avaliação?
		9 De centro de custo?
		10 Até centro de custo?
		11 Considerar por?
		12 De filial?
		13 Até filial?
		14 Jornada de trabalho?
		15 Dias úteis do ano?
		16 Atalho não expostos?
		17 Imprimir junto ao risco?
		18 Imprimir matriz de risco?
		*/

		/*Nova ordem
		1 Laudo?
		2 Coordenador?
		3 De filial?
		4 Ate filial?
		5 De centro de custo?
		6 Ate centro de custo?
		7 Impressao?
		8 Arquivo saida?
		9 Ordenar riscos por?
		10 Imprimir data de avaliação?
		11 Imprimir imagens?
		12 Imprimir junto ao risco?
		13 Imprimir matriz de risco?
		14 Considerar por?
		15 Ordenar equipamentos por?
		16 Ordenar plano de ação por?
		17 Imprime qtd. func. e funções?
		18 Jornada de trabalho?
		19 Dias uteis do ano?
		*/

		If ValType( mv_par05 ) == 'C' // Verifica se possui o SX1 atualizado

			mv_par01 := xPar01
			mv_par02 := xPar02
			mv_par03 := xPar09
			mv_par04 := xPar15
			mv_par05 := xPar16
			mv_par06 := xPar17
			mv_par07 := xPar11
			mv_par08 := xPar10
			mv_par09 := xPar05
			mv_par10 := xPar06
			mv_par11 := xPar14
			mv_par12 := xPar03
			mv_par13 := xPar04
			mv_par14 := xPar18
			mv_par15 := xPar19
			mv_par17 := xPar12
			mv_par18 := xPar13

		EndIf

	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDescriProd
Retorna a descrição do produto setado para impressão.

@author Elisson França
@since 26/02/2025

@param, cAliasRis2, Alias da query responsável pelas informações dos agentes
@param, cDescProd, Descrição do produto

@return cDescProd, Caracter, retorna a descrição do produto

/*/
//---------------------------------------------------------------------
Static Function fDescriProd( cAliasRis2, cDescProd ) 

	dbSelectArea( 'TJC' )
	dbSetOrder(01) //"TJC_FILIAL+TJC_AGENTE+TJC_CODPRO"
	MsSeek( FwxFilial( 'TJC', cFil ) + ( cAliasRis2 )->TMA_AGENTE )
	While ( 'TJC' )->( !Eof() ) .And. TJC->TJC_FILIAL == FwxFilial( 'TJC', cFil ) .And.;
	TJC->TJC_AGENTE == ( cAliasRis2 )->TMA_AGENTE
		
		If !Empty( cDescProd )
			cDescProd += NGSEEK( 'SB1', TJC->TJC_CODPRO, 1, 'SB1->B1_DESC', cFil )
		Else
			cDescProd += ',' + NGSEEK( 'SB1', TJC->TJC_CODPRO, 1, 'SB1->B1_DESC', cFil )
		EndIf

		( 'TJC' )->( dbSkip() )

	End

Return cDescProd
