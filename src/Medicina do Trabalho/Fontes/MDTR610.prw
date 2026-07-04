/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr610.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR610
Resumo de Insalubridade (NR 4 - Quadro V)

@return	Nil, Nulo

@sample U_MDTR610()

@author	Liber De Esteban
@since	14/04/2005
/*/
//-------------------------------------------------------------------
User Function MDTR610()

	Local aNGBEGINPRM := NGBEGINPRM() //Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local oTempTable

	//Define Variaveis
	Private nomeprog := "MDTR610"
	Private tamanho  := "M"
	Private aReturn  := { STR0001, 1, STR0002, 1, 1, 1, "", 1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0003 //"RELATORIO DE INSALUBRIDADE"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1
	Private cabec2
	Private cPROGRAMA := "MDTR610"

	Private cCodFun  := "RA_CODFUNC"
	Private cCodFun2 := "TN0_CODFUN"
	Private nSizeSRJ := IIf( ( TAMSX3( "RJ_FUNCAO" )[1] ) < 1, 5, ( TAMSX3( "RJ_FUNCAO" )[1] ) )

	If SRA->( FieldPos( "RA_POSTO" ) ) > 0 .And. TN0->( FieldPos( "TN0_CODPOS" ) ) > 0
		cCodFun  := "RA_POSTO"
		cCodFun2 := "TN0_CODPOS"
		nSizeSRJ := IIf( ( TAMSX3( "ZZI_COD" )[1] ) < 1, 5, ( TAMSX3( "ZZI_COD" )[1] ) )
	EndIf

	Private cAlias		:= "SI3"
	Private cDescr		:= "SI3->I3_DESC"
	Private cCodcc		:= "I3_CUSTO"
	Private cF3CC		:= "SI3"
	Private nSizeCC		:= IIf( ( TAMSX3( "I3_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "I3_CUSTO" )[1] ) )
	Private nSizeSQB	:= IIf( ( TAMSX3( "QB_DEPTO" )[1] ) < 1, 9, ( TAMSX3( "QB_DEPTO" )[1] ) )
	Private lMdtps		:= SuperGetMv( "MV_NGMDTPS", .F., "N" ) == "S"
	Private lSigaMdtPS	:= SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lTN0Depto	:= NGCADICBASE( "TN0_DEPTO", "A", "TN0", .F. ) .And. !lSigaMdtPs

	If Alltrim( SuperGetMv( "MV_MCONTAB", .F., "" ) ) == "CTB"
		cAlias	  := "CTT"
		cDescr    := "CTT->CTT_DESC01"
		cCodcc    := "CTT_CUSTO"
		nSizeCC   := IIf( ( TAMSX3( "CTT_CUSTO" )[1] ) < 1, 9, ( TAMSX3( "CTT_CUSTO" )[1] ) )
		cFilialCC := "CTT->CTT_FILIAL"
		cF3CC     := "CTT"
	EndIf

	nTa1 := IIf( ( TAMSX3( "A1_COD" )[1] ) < 1, 6, ( TAMSX3( "A1_COD" )[1] ) )

	dbSelectArea( "SX3" )
	dbSetOrder( 2 )
	Private lTemLimTol := dbSeek( "TLK_AGENTE" )
	Private lTemTipAdi := dbSeek( "TMA_TIPADI" )

	//Verifica as perguntas selecionadas
	Private cPerg := "MDT610    "

	/*---------------------------
	//PERGUNTAS PADRÃO			|
	| 01 Tipo de Impressao ?	|
	| 02 De Centro de Custo ?	|
	| 03 Ate Centro de Custo ?	|
	| 04 Responsavel ?			|
	| 05 Imprimir zero (0) ?	|
	| 06 De Data ?				|
	| 07 Até Data ?				|
	-----------------------------*/

	//Cria tabelas temporarias para utilizar no programa
	//Tabela dos setores expostos a riscos
	aDBFIMP := {}

	aAdd( aDBFIMP, { "CODCC", "C", nSizeCC, 0 } )
	If lTN0Depto
		aAdd( aDBFIMP, { "DEPTO", "C", nSizeSQB, 0 } )
	EndIf
	aAdd( aDBFIMP, { "CODAGE", "C", TAMSX3( "TN0_AGENTE" )[1], 0 } )
	aAdd( aDBFIMP, { "GRAU", "C", 1, 0 } )
	aAdd( aDBFIMP, { "QUANTI", "N", 6, 0 } )

	oTempTable := FWTemporaryTable():New( "TRBIMP", aDBFIMP )

	If lTN0Depto
		oTempTable:AddIndex( "1", { "CODCC", "DEPTO", "CODAGE", "GRAU" } )
	Else
		oTempTable:AddIndex( "1", { "CODCC", "CODAGE", "GRAU" } )
	EndIf

	oTempTable:Create()

	If pergunte( cPerg, .T. )
		Processa( { |lEnd| U_R610Dados() } ) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
		U_R610Imp()
	EndIf

	dbSelectArea( "TRBIMP" )
	Use

	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} R610Dados
Processa os funcionários

@return	.T., Boolean, Sempre verdadeiro

@sample U_R610Dados()

@author	Liber de Esteban - Refeito por: Luis Fellipy Bett
@since	14/04/2005 - 10/09/2020
/*/
//-------------------------------------------------------------------
User Function R610Dados()

	Local cDtIniRis
	Local cDtFimRis
	Local cAliasFun	:= GetNextAlias()

	BeginSql Alias cAliasFun
		SELECT RA_MAT, RA_ADMISSA, RA_DEMISSA, RA_CC, RA_DEPTO, RA_CODFUNC
		FROM %Table:SRA% SRA
		WHERE SRA.RA_FILIAL = %xFilial:SRA%
			AND SRA.%NotDel%
			AND SRA.RA_CC >= %exp:mv_par02%
			AND SRA.RA_CC <= %exp:mv_par03%
			AND SRA.RA_ADMISSA <= %exp:mv_par07%
			AND ( SRA.RA_DEMISSA = '' OR SRA.RA_DEMISSA > %exp:mv_par06% )
			AND SRA.RA_CATFUNC NOT IN ( 'A', 'E', 'G', 'P' ) //NR 4 - item 4.1 - //Funcionários que não são regidos pela CLT não devem ser considerados (Autônomo, Estagiário Mensalista, Estagiário Horista)
		ORDER BY SRA.RA_MAT
	EndSql

	dbSelectArea( cAliasFun ) //Posiciona na tabela

	ProcRegua( Contar( cAliasFun, "!Eof()" ) ) //Define a régua de processamento

	( cAliasFun )->( dbGoTop() )
	While ( cAliasFun )->( !Eof() )

		IncProc() //Incrementa a régua

		cDtIniRis := DToS( mv_par06 )
		cDtFimRis := DToS( mv_par07 )

		//Periodo de exposicao ao Risco desde a Admissao
		If ( cAliasFun )->RA_ADMISSA > DToS( mv_par06 )
			cDtIniRis := ( cAliasFun )->RA_ADMISSA
		EndIf
		If !Empty( ( cAliasFun )->RA_DEMISSA ) .And. ( cAliasFun )->RA_DEMISSA < DToS( mv_par07 )
			cDtFimRis := ( cAliasFun )->RA_DEMISSA
		EndIf

		//Verifica os riscos nos quais o funcionario esteve exposto
		MDT610FU( cDtIniRis, cDtFimRis, ( cAliasFun )->RA_MAT, ( cAliasFun )->RA_CC, ( cAliasFun )->RA_DEPTO, ( cAliasFun )->RA_CODFUNC )

		( cAliasFun )->( dbSkip() ) //Pula registro
	End

	( cAliasFun )->( dbCloseArea() ) //Exclui tabela temporária

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT610FU
Verifica os riscos nos quais o funcionario esteve exposto

@return	.T., Boolean, Sempre verdadeiro

@sample MDT610FU()

@author	André E. Perez Álvarez
@since	28/11/2008
/*/
//-------------------------------------------------------------------
Static Function MDT610FU( cDtIniRis, cDtFimRis, cMat, cCenCus, cDepto, cFuncao )

	Local cFiltro  //Utilizado no filtro da tabela SRE, SR7
	Local dIniTar
	Local dFimTar
	Local dIniFuncao
	Local dFimFuncao
	Local lFuncao
	Local lTarefa
	Local lPula
	Local dIniRisAux
	Local dFimRisAux
	Local cEmp		:= FWGrpCompany()
	Local cFil		:= FWCodFil()
	Local cAliasIns	:= GetNextAlias()
	Local cAliasSR7
	Local cAliasSRE

	Private cMatAux := cMat //Define variável private para ser utilizada dentro da função MDTChkSR8

	//Verificar se não vai trazer mais de um resultado pro mesmo funcionário
	BeginSql Alias cAliasIns
		SELECT	TN0_AGENTE, TN0_DTRECO, TN0_DTELIM, TN0_CODFUN, TN0_CODTAR, TN0_CC, TN0_DEPTO, TN0_GRAU, TLK_GRAU
			FROM %Table:TN0% TN0
			INNER JOIN %Table:TMA% TMA ON TN0.TN0_AGENTE = TMA.TMA_AGENTE AND TMA.%NotDel%
			INNER JOIN %Table:TLK% TLK ON TN0.TN0_AGENTE = TLK.TLK_AGENTE AND TLK.%NotDel%
			WHERE TN0.TN0_FILIAL = %xFilial:TN0%
				AND TN0.%NotDel%
				AND ( TN0.TN0_CC = '*' OR TN0.TN0_CC = %exp:cCenCus% )
				AND ( TN0.TN0_DEPTO = '*' OR TN0.TN0_DEPTO = %exp:cDepto% )
				AND TN0.TN0_DTRECO <= %exp:cDtFimRis%
				AND ( TN0.TN0_DTELIM = '' OR TN0.TN0_DTELIM >= %exp:cDtIniRis% )
				AND TMA.TMA_TIPADI = '1'
				AND ( TN0.TN0_GRAU <> '' OR TN0.TN0_GRAU = '' AND TMA.TMA_AVALIA = '1'
				AND ( ( TN0.TN0_QTAGEN = TLK.TLK_DEQTDE AND TN0.TN0_QTEXPO > TLK.TLK_HRLIMI AND TLK.TLK_GRAU <> '' )
					OR ( TN0.TN0_QTAGEN > TLK.TLK_DEQTDE AND TN0.TN0_QTEXPO >= TLK.TLK_HRLIMI AND TLK.TLK_GRAU <> '' ) ) )
	EndSql

	dbSelectArea( cAliasIns )
	( cAliasIns )->( dbGoTop() )
	While ( cAliasIns )->( !Eof() )

		cGrauRisco := IIf( !Empty( ( cAliasIns )->TLK_GRAU ), ( cAliasIns )->TLK_GRAU, ( cAliasIns )->TN0_GRAU )

		//Inicio-Fim do Risco do funcionário
		dIniRisAux := SToD( cDtIniRis )
		dFimRisAux := SToD( cDtFimRis )

		If SToD( ( cAliasIns )->TN0_DTRECO ) > dIniRisAux
			dIniRisAux := SToD( ( cAliasIns )->TN0_DTRECO )
		EndIf

		If !Empty( SToD( ( cAliasIns )->TN0_DTELIM ) ) .And. SToD( ( cAliasIns )->TN0_DTELIM ) <= dFimRisAux
			dFimRisAux := SToD( ( cAliasIns )->TN0_DTELIM )
		EndIf

		//Verifica o setor atual - Verifica se o funcionario tem transferencia de funcao.
		//Se tiver verifica qual foi a ultima, para verificar desde quando ele esta na funcao atual (mesma funcao do risco)
		lFuncao := .T.
		If AllTrim( ( cAliasIns )->TN0_CODFUN ) <> "*"

			cAliasSR7 := GetNextAlias()
			lFuncao := .F.

			//Transferencias de funcao do funcionario
			BeginSql Alias cAliasSR7
				SELECT R7_DATA, R7_FUNCAO
					FROM %Table:SR7% SR7
					WHERE SR7.R7_FILIAL = %xFilial:SR7%
						AND SR7.%NotDel%
						AND SR7.R7_MAT = %exp:cMat%
					ORDER BY R7_DATA DESC
			EndSql

			dbSelectArea( cAliasSR7 ) //Posiciona na tabela temporária

			If cFuncao == ( cAliasIns )->TN0_CODFUN  //Desde quando ele esta na funcao do risco ?
				dIniFuncao := dIniRisAux

				If ( cAliasSR7 )->( Eof() )
					lFuncao := .T.  //Nao existe historico de mudanca entao ele esta nessa funcao desde o inicio
				Else
					If ( cAliasIns )->TN0_CODFUN <> ( cAliasSR7 )->R7_FUNCAO  //A ultima funcao no historico nao condiz com a funcao atual
						lFuncao := .T.  //Dai considera a funcao atual
					Else
						While ( cAliasSR7 )->( !Eof() ) .And. ( cAliasIns )->TN0_CODFUN == ( cAliasSR7 )->R7_FUNCAO
							dIniFuncao := SToD( ( cAliasSR7 )->R7_DATA )
							( cAliasSR7 )->( dbSkip() )
						End
						If dIniFuncao < dFimRisAux  //No momento em que o funcionario foi transferido para a funcao atual ele ficou exposto ao risco
							lFuncao := .T.
							If dIniFuncao > dIniRisAux
								dIniRisAux := dIniFuncao
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf

			//A funcao atual do funcionario nao é a mesma do risco ou é a mesma do risco porém ele comeceu a exercê-la num período fora do
			//período do risco, nesse caso verifica se anteriormente ele esteve nessa funcao
			If !lFuncao
				( cAliasSR7 )->( dbGoTop() )
				While ( cAliasSR7 )->( !Eof() ) .And. !lFuncao

					If ( cAliasSR7 )->R7_FUNCAO == ( cAliasIns )->TN0_CODFUN  //mesma funcao do risco

						dFimFuncao := DaySub( SToD( ( cAliasSR7 )->R7_DATA ), 1 )

						If dFimFuncao >= dIniRisAux .And. SToD( ( cAliasSR7 )->R7_DATA ) <= dFimRisAux  //Nesse periodo esteve exposto ao risco
							lFuncao := .T.
							If SToD( ( cAliasSR7 )->R7_DATA ) > dIniRisAux
								dIniRisAux := SToD( ( cAliasSR7 )->R7_DATA )
							EndIf
							If dFimFuncao < dFimRisAux
								dFimRisAux := dFimFuncao
							EndIf
						EndIf
					EndIf
					( cAliasSR7 )->( dbSkip() ) //Pula para o próximo registro
				End
			EndIf

			( cAliasSR7 )->( dbCloseArea() ) //Exclui a tabela temporária

			If !lFuncao  //Se o funcionario nunca exerceu a funcao do risco no periodo do risco
				( cAliasIns )->( dbSkip() )
				Loop
			EndIf
		EndIf

		//Periodo de exposicao ao Risco desde a execucao da Tarefa
		lTarefa := .T.
		If AllTrim( ( cAliasIns )->TN0_CODTAR ) <> "*"

			lTarefa := .F.
			dIniTar := dIniRisAux
			dFimTar := dFimRisAux

			dbSelectArea( "TN6" )
			dbSetOrder( 01 ) //TN6_FILIAL+TN6_CODTAR+TN6_MAT+DTOS(TN6_DTINIC)+TN6_HORINI
			dbSeek( xFilial( "TN6" ) + ( cAliasIns )->TN0_CODTAR + cMat )

			While TN6->( !Eof() ) .And. xFilial( "TN6" ) + ( cAliasIns )->TN0_CODTAR + cMat == TN6->( TN6_FILIAL + TN6_CODTAR + TN6_MAT )

				If TN6->TN6_DTINIC >= dFimRisAux .Or. ( !Empty( TN6->TN6_DTTERM ) .And. TN6->TN6_DTTERM <= dIniRisAux )
					TN6->( dbSkip() )
					Loop
				EndIf

				If !lTarefa
					If TN6->TN6_DTINIC > dIniRisAux
						dIniTar := TN6->TN6_DTINIC
					EndIf
					If !Empty( TN6->TN6_DTTERM ) .And. TN6->TN6_DTTERM < dFimRisAux
						dFimTar := TN6->TN6_DTTERM
					EndIf
				Else
					If !Empty( TN6->TN6_DTTERM ) .And. TN6->TN6_DTTERM < dFimRisAux
						If TN6->TN6_DTTERM > dFimTar
							dFimTar := TN6->TN6_DTTERM
						EndIf
					EndIf
				EndIf
				lTarefa := .T.
				TN6->( dbSkip() )
			End

			If !lTarefa //Se o periodo no qual o funcionario executou a tarefa nao cai dentro do periodo do Risco
				( cAliasIns )->( dbSkip() )
				Loop
			EndIf

			If dIniTar > dIniRisAux
				dIniRisAux := dIniTar
			EndIf
			If dFimTar < dFimRisAux
				dFimRisAux := dFimTar
			EndIf

		EndIf

		If AllTrim( ( cAliasIns )->TN0_CC ) <> "*" .Or. IIf( lTN0Depto, ( AllTrim( ( cAliasIns )->TN0_DEPTO ) <> "*" ), .F. )

			//Verifica se o funcionario tem transferencia de setor.
			//Se tiver verifica qual foi a ultima, para verificar desde quando ele esta no setor atual.
			cAliasSRE := GetNextAlias()
			lPula := .F.

			//Transferencias de funcao do funcionario
			BeginSql Alias cAliasSRE
				SELECT RE_DATA
					FROM %Table:SRE% SRE
					WHERE SRE.%NotDel%
						AND SRE.RE_MATD = %exp:cMat%
						AND SRE.RE_MATP = %exp:cMat%
						AND SRE.RE_EMPP = %exp:cEmp%
						AND SRE.RE_FILIALP = %exp:cFil%
					ORDER BY RE_DATA DESC
			EndSql

			dbSelectArea( cAliasSRE )
			If ( cAliasSRE )->( !Eof() )
				If SToD( ( cAliasSRE )->RE_DATA ) < dFimRisAux .And. SToD( ( cAliasSRE )->RE_DATA ) > dIniRisAux
					dIniRisAux := SToD( ( cAliasSRE )->RE_DATA )
				ElseIf SToD( ( cAliasSRE )->RE_DATA ) >= dFimRisAux  //No momento em que o funcionario foi transferido para o setor atual ele nao ficou exposto ao risco
					lPula := .T.
				EndIf
			EndIf
			( cAliasSRE )->( dbCloseArea() ) //Exclui a tabela

			If lPula
				( cAliasIns )->( dbSkip() )
				Loop
			EndIf
		EndIf

		//Verifica se esteve afastado no periodo de exposicao ao risco
		If MDTChkSR8( "SR8", 1, xFilial( "SR8" ) + cMat, "xFilial('SR8') == SR8->R8_FILIAL .And. cMatAux == SR8->R8_MAT", dIniRisAux, dFimRisAux )
			( cAliasIns )->( dbSkip() )
			Loop
		EndIf

		//Se não esteve afastado no periodo de exposicao ao risco e se no setor/funcao/tarefa atual o funcionario
		//esteve ou está exposto ao risco, então grava para imprimir
		dbSelectArea( "TRBIMP" )
		dbSetOrder( 1 )

		If lTN0Depto
			lAchou := dbSeek( cCenCus + cDepto + ( cAliasIns )->TN0_AGENTE + cGrauRisco )
		Else
			lAchou := dbSeek( cCenCus + ( cAliasIns )->TN0_AGENTE + cGrauRisco )
		EndIf

		If !lAchou
			RecLock( "TRBIMP", .T. )
			TRBIMP->CODCC := cCenCus
			If lTN0Depto
				TRBIMP->DEPTO := cDepto
			EndIf
			TRBIMP->CODAGE := ( cAliasIns )->TN0_AGENTE
			TRBIMP->GRAU   := cGrauRisco
			TRBIMP->QUANTI := 1
			MsUnLock( "TRBIMP" )
		Else
			RecLock( "TRBIMP", .F. )
			TRBIMP->QUANTI++
			MsUnLock( "TRBIMP" )
		EndIf

		Set Filter To //Limpa filtro

		( cAliasIns )->( dbSkip() )
	End

	( cAliasIns )->( dbCloseArea() ) //Exclui a tabela temporária

Return  .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} R610Imp
Imprime relatorio

@return	Nil, Nulo

@sample U_R610Imp()

@author	Liber De Esteban
@since	14/04/2005
/*/
//-------------------------------------------------------------------
User Function R610Imp()

	Local nX
	Local cDescCC
	Local cAgente
	Local lSetor := .F.
	Local lAgent := .F.
	Local nAgent

	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()

	Private oFont12
	Private oFont11
	Private oFont10
	Private oFont10b
	Private oFont09
	Private oFont09b
	Private oFont08
	Private oFont07

	Private oPrint
	Private lin
	Private linaux

	oPrint := TMSPrinter():New( OemToAnsi( titulo ) )
	oPrint:SetPortrait() //retrato
	oPrint:Setup()

	oFont07	 := TFont():New( "ARIAL", 07, 07, , .F., , , , .F., .F. )
	oFont08	 := TFont():New( "ARIAL", 08, 08, , .F., , , , .F., .F. )
	oFont09	 := TFont():New( "ARIAL", 09, 09, , .F., , , , .F., .F. )
	oFont09b := TFont():New( "ARIAL", 09, 09, , .T., , , , .F., .F. )
	oFont10	 := TFont():New( "ARIAL", 10, 10, , .F., , , , .F., .F. )
	oFont10b := TFont():New( "ARIAL", 10, 10, , .T., , , , .F., .F. )
	oFont12	 := TFont():New( "ARIAL", 12, 12, , .F., , , , .F., .F. )
	oFont14	 := TFont():New( "ARIAL", 14, 14, , .T., , , , .F., .F. )

	If lTN0Depto
		nPos6101 := 760
		nPos6102 := 1170
		nPos6103 := 740
		nPos6104 := 1800
		nPos6105 := 2060
		nPos6106 := 2400
	Else
		nPos6101 := 120
		nPos6102 := 620
		nPos6103 := 600
		nPos6104 := 1350
		nPos6105 := 1730
		nPos6106 := 2200
	EndIf

	cCusto := " "
	cDepto := " "
	lPrint := .T.
	lPrintRel := .F.

	nSizeCli := IIf( ( TAMSX3( "A1_COD" )[1] ) < 1, 6, ( TAMSX3( "A1_COD" )[1] ) )
	nSizeLoj := IIf( ( TAMSX3( "A1_LOJA" )[1] ) < 1, 2, ( TAMSX3( "A1_LOJA" )[1] ) )

	dbSelectArea( "TRBIMP" )
	dbSetOrder( 1 )
	dbGoTop()

	nTamSub := nSizeCli + nSizeLoj

	If !lSigaMdtPS
		nTamSub := nSizeCli
	EndIf

	Private cCodcli := SubStr( TRBIMP->CODCC, 1, nTamSub )

	While !Eof()
		lPrintRel := .T.

		If lMdtps .Or. lSigaMdtPS
			nTamSub := nSizeCli + nSizeLoj
			If !lSigaMdtPS
				nTamSub := nSizeCli
			EndIf
			If cCodcli != SubStr( TRBIMP->CODCC, 1, nTamSub )
				If ( lSetor .And. !lAgent .And. nAgent == 1 ) .Or. lAgent
					SomaLin( 65, .F. )
				EndIf
				lin += 70
				oPrint:Line( lin, 100, lin, nPos6106 )
				oPrint:Line( 200, 100, lin, 100 )
				oPrint:Line( linaux, nPos6103, lin, nPos6103 )
				If lTN0Depto
					oPrint:Line( linaux, 1150, lin, 1150 )
				EndIf
				oPrint:Line( linaux, nPos6104, lin, nPos6104 )
				oPrint:Line( linaux, nPos6105, lin, nPos6105 )
				oPrint:Line( 200, nPos6106, lin, nPos6106 )
				MDT610QUAD()
				cCodcli := SubStr( TRBIMP->CODCC, 1, nTamSub )
				lPrint := .T.
			EndIf
		EndIf

		If lPrint
			oPrint:StartPage()
			lin := 200
			oPrint:Line( lin, 100, lin, nPos6106 )

			cFileLogo := "lgrl" + cSMCOD + cSMFIL + ".bmp"
			If File( cFileLogo )
				oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
			Else
				cFileLogo := "lgrl" + cSMCOD + ".bmp"
				If File( cFileLogo )
					oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
				EndIf
			EndIf

			lin += 250
			oPrint:Say( lin, 1000, STR0004, oFont14 ) //"QUADRO V"

			lin += 140
			oPrint:Say( lin, 120, STR0005, oFont12 ) //"INSALUBRIDADE"
			lin += 100
			dbSelectArea( "TMK" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMK" ) + mv_par04 )
			oPrint:Say( lin, 120, STR0006 + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont09 ) //"Responsável:  "
			oPrint:Say( lin, 1550, STR0044, oFont09 ) //"Ass.:   _________________________"

			cTipResp := Tabela( "P1", TMK->TMK_INDFUN, .F. )

			lin += 50
			oPrint:Say( lin, 120, STR0015 + cTipResp, oFont09 ) //"Cargo:  "
			oPrint:Say( lin, 1550, STR0016 + DToC( dDataBase ), oFont09 ) //"Data do Mapa:  "

			lin += 80
			oPrint:Line( lin, 100, lin, nPos6106 )
			linaux := lin
			If lTN0Depto
				oPrint:Say( lin + 50, 420, STR0017, oFont09, , , , 2 ) //"SETOR"
				oPrint:Say( lin + 50, 945, STR0045, oFont09, , , , 2 ) //"DEPARTAMENTO"
				oPrint:Say( lin + 50, 1410, STR0018, oFont09, , , , 2 ) //"AGENTES IDENTIFICADOS"
				oPrint:Say( lin + 30, 1810, STR0019, oFont09, , , , 2 ) //"INTENSIDADE OU "
				oPrint:Say( lin + 70, 1810, STR0020, oFont09, , , , 2 ) //" CONCENTRAÇÃO"
				oPrint:Say( lin + 30, 2185, STR0021, oFont09, , , , 2 ) //"Nº DE TRABALHADORES"
				oPrint:Say( lin + 70, 2185, STR0022, oFont09, , , , 2 ) //"    EXPOSTOS"
			Else
				oPrint:Say( lin + 50, 270, STR0017, oFont10 ) //"SETOR"
				oPrint:Say( lin + 50, 735, STR0018, oFont10 ) //"AGENTES IDENTIFICADOS"
				oPrint:Say( lin + 30, 1390, STR0019, oFont10 ) //"INTENSIDADE OU "
				oPrint:Say( lin + 70, 1380, STR0020, oFont10 ) //" CONCENTRAÇÃO"
				oPrint:Say( lin + 30, 1760, STR0021, oFont10 ) //"Nº DE TRABALHADORES"
				oPrint:Say( lin + 70, 1830, STR0022, oFont10 ) //"    EXPOSTOS"
			EndIf
			lin += 80
		EndIf
		lPrint := .F.

		If cCusto != TRBIMP->CODCC .Or. IIf( lTN0Depto, ( cDepto <> TRBIMP->DEPTO ), .F. )
			If ( lSetor .And. !lAgent .And. nAgent == 1 ) .Or. (lSetor .and. nAgent == 2)
				SomaLin( 65, .F. )
			EndIf
			Somalin( 65, .F. )
			oPrint:Line( lin, 100, lin, nPos6106 )
			cCusto := TRBIMP->CODCC
			If lTN0Depto
				cDepto := TRBIMP->DEPTO
			EndIf
			lCusto := .T.
			nAgent := 0
		Else
			Somalin( 65, .T. )
			lCusto := .F.
		EndIf

		If lCusto
			dbSelectArea( cAlias )
			dbSetOrder( 1 )
			dbSeek( xFilial( cAlias ) + TRBIMP->CODCC )
			cDescCC := Alltrim( &cDescr )

			IIf( Len( cDescCC ) >23, lSetor := .T., lSetor := .F. )
			oPrint:Say( lin + 20, 120, IIf( lSetor, SubStr( cDescCC, 1, 23 ), cDescCC ), oFont09 )
			If lSetor
				SomaLin( 65, .F. )
				oPrint:Say( lin + 20, 120, SubStr( cDescCC, 24, 40 ), oFont09 )
				lin -= 65
			EndIf
			If lTN0Depto
				dbSelectArea( "SQB" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SQB" ) + TRBIMP->DEPTO )
				cDescQB := NgSeek( "SQB", TRBIMP->DEPTO, 1, "SQB->QB_DESCRIC" )

				IIf( Len( cDescQB ) > 15, lSetor := .T., lSetor := .F. )

				oPrint:Say( lin + 20, nPos6101, SubStr( cDescQB, 1, 15 ), oFont09 )
				If lSetor
					SomaLin( 65, .F. )
					oPrint:Say( lin + 20, nPos6101, SubStr( cDescQB, 16, 30 ), oFont09 )
					lin -= 65
				EndIf
			EndIf
		EndIf

		dbSelectArea( "TMA" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "TMA" ) + TRBIMP->CODAGE )

		If lTN0Depto
			nAgent := nAgent + 2
			nPosAge := 40
		Else
			nAgent ++
			nPosAge := 20
		EndIf

		cAgente := Alltrim( TMA->TMA_NOMAGE )
		IIf( lAgent .And. !lCusto, SomaLin( 65, .F. ), NIL)

		IIf( Len( cAgente ) > nPosAge, lAgent := .T., lAgent := .F. )
		oPrint:Say( lin + 20, nPos6102, IIf( lAgent, SubStr( cAgente, 1, nPosAge ), cAgente ), oFont09 )

		If lAgent
			SomaLin( 65, .F. )
			oPrint:Say( lin + 20, nPos6102, SubStr( cAgente, nPosAge + 1, 40 ), oFont09 )
			lin -= 65
		EndIf

		If lTN0Depto
			cDescGrau := IIf( TRBIMP->GRAU == "1", STR0023, IIf( TRBIMP->GRAU == "2", STR0024, STR0025 ) ) //"GRAU MÍNIMO 10%"###//"GRAU MÉDIO 20%"###//"GRAU MÁXIMO 40%"
			oPrint:Say( lin + 20, 1810, cDescGrau, oFont09, , , , 2 )
			oPrint:Say( lin + 20, 2150, Str( TRBIMP->QUANTI, 6 ), oFont09, , , , 2 )
		Else
			If TRBIMP->GRAU == "1"
				oPrint:Say( lin + 20, 1384, STR0023, oFont10 ) //"GRAU MÍNIMO 10%"
			ElseIf TRBIMP->GRAU == "2"
				oPrint:Say( lin + 20, 1387, STR0024, oFont10 ) //"GRAU MÉDIO 20%"
			Else
				oPrint:Say( lin + 20, 1377, STR0025, oFont10 ) //"GRAU MÁXIMO 40%"
			EndIf
			oPrint:Say( lin + 20, 1900, Str( TRBIMP->QUANTI, 6 ), oFont10 )
		EndIf

		dbSelectArea( "TRBIMP" )
		DbSkip()

	End

	If lPrintRel

		If ( lSetor .And. !lAgent .And. nAgent == 1 ) .Or. lAgent
			SomaLin( 65, .F. )
		EndIf
		lin+=70

		If lSetor //Caso tiver mais de uma linha
			SomaLin( 65, .F. )
		EndIf

		oPrint:Line( lin, 100, lin, nPos6106 )
		oPrint:Line( 200, 100, lin, 100 )
		oPrint:Line( linaux, 700, lin, 700 )
		If lTN0Depto
			oPrint:Line( linaux, 1150, lin, 1150 )
		EndIf
		oPrint:Line( linaux, 1640, lin, 1640 )
		oPrint:Line( linaux, 1960, lin, 1960 )
		oPrint:Line( 200, nPos6106, lin, nPos6106 )

		MDT610QUAD()

		If lMdtps .Or. lSigaMdtPS

			nTamSub := nSizeCli + nSizeLoj
			If !lSigaMdtPS
				nTamSub := nSizeCli
			EndIf

			dbSelectArea( cAlias )
			dbSetOrder( 1 )
			dbSeek( xFilial( cAlias ) + mv_par02, .T. )
			While !Eof() .And. xFilial( cAlias ) == &( cFilialCC ) .And. &( cCodcc ) <= mv_par03

				If cCodCli <> SubStr( &( cCodCC ), 1, nTamSub )
					cCodCli := SubStr( &( cCodCC ), 1, nTamSub )

					dbSelectArea( "TRBIMP" )
					If !dbSeek( cCodCli )

						oPrint:StartPage()
						lin := 200
						oPrint:Line( lin, 100, lin, nPos6106 )

						cFileLogo := "lgrl" + cSMCOD + cSMFIL + ".bmp"
						If File( cFileLogo )
							oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
						Else
							cFileLogo := "lgrl" + cSMCOD + ".bmp"
							If File( cFileLogo )
								oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
							EndIf
						EndIf

						lin += 250
						oPrint:Say( lin, 1000, STR0004, oFont14 )  //"QUADRO V"

						lin += 140
						oPrint:Say( lin, 120, STR0005, oFont12 )  //"INSALUBRIDADE"
						lin += 100
						dbSelectArea( "TMK" )
						dbSetOrder( 01 )
						dbSeek( xFilial( "TMK" ) + mv_par04 )
						oPrint:Say( lin, 120, STR0006 + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont09 ) //"Responsável:  "
						oPrint:Say( lin, 1550, STR0044, oFont09 ) //"Ass.:   _________________________"

						cTipResp := Tabela( "P1", TMK->TMK_INDFUN, .F. )

						lin += 50
						oPrint:Say( lin, 120, STR0015 + cTipResp, oFont09 ) //"Cargo:  "
						oPrint:Say( lin, 1550, STR0016 + DToC( dDataBase ), oFont09 ) //"Data do Mapa:  "

						lin += 80
						oPrint:Line( lin, 100, lin, nPos6106 )
						linaux := lin
						oPrint:Say( lin + 50, 270, STR0017, oFont09 ) //"SETOR"
						oPrint:Say( lin + 50, 735, STR0018, oFont09 ) //"AGENTES IDENTIFICADOS"
						oPrint:Say( lin + 30, 1390, STR0019, oFont09 ) //"INTENSIDADE OU "
						oPrint:Say( lin + 70, 1380, STR0020, oFont09 ) //" CONCENTRAÇÃO"
						oPrint:Say( lin + 30, 1760, STR0021, oFont09 ) //"Nº DE TRABALHADORES"
						oPrint:Say( lin + 70, 1830, STR0022, oFont09 ) //"    EXPOSTOS"

						lin += 80

						Somalin( 65, .F. )
						oPrint:Line( lin, 100, lin, nPos6106 )
						For nX := 1 To 10
							Somalin( 65, .F. )
						Next nX

						If lSetor //Caso tiver mais de uma linha
							SomaLin( 65, .F. )
						EndIf

						oPrint:Line( lin, 100, lin, nPos6106 )

						oPrint:Line( lin, 100, lin, nPos6106 )
						oPrint:Line( 200, 100, lin, 100 )
						oPrint:Line( linaux, nPos6103, lin, nPos6103 )
						If lTN0Depto
							oPrint:Line( linaux, 1150, lin, 1150 )
						EndIf
						oPrint:Line( linaux, nPos6104, lin, nPos6104 )
						oPrint:Line( linaux, nPos6105, lin, nPos6105 )
						oPrint:Line( 200, nPos6106, lin, nPos6106 )

						MDT610QUAD()

					EndIf
				EndIf

				dbSelectArea( cAlias )
				dbSkip()
			End

		EndIf

	Else  //Se nao tem dados, tem q imprimir o quadro vazio por força da Lei

		If lMdtps .Or. lSigaMdtPS

			nTamSub := nSizeCli + nSizeLoj
			If !lSigaMdtPS
				nTamSub := nSizeCli
			EndIf

			dbSelectArea( cAlias )
			dbSetOrder( 1 )
			dbSeek( xFilial( cAlias ) + mv_par02, .T. )
			While !Eof() .And. xFilial( cAlias ) == &( cFilialCC ) .And. &( cCodcc ) <= mv_par03

				If cCodCli <> SubStr( &( cCodCC ), 1, nTamSub )
					cCodCli := SubStr( &( cCodCC ), 1, nTamSub )

					oPrint:StartPage()
					lin := 200
					oPrint:Line( lin, 100, lin, nPos6106 )

					cFileLogo := "lgrl" + cSMCOD + cSMFIL + ".bmp"
					If File( cFileLogo )
						oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
					Else
						cFileLogo := "lgrl" + cSMCOD + ".bmp"
						If File( cFileLogo )
							oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
						EndIf
					EndIf

					lin += 250
					oPrint:Say( lin, 1000, STR0004, oFont14 ) //"QUADRO V"

					lin += 140
					oPrint:Say( lin, 120, STR0005, oFont12 ) //"INSALUBRIDADE"
					lin += 100
					dbSelectArea( "TMK" )
					dbSetOrder( 01 )
					dbSeek( xFilial( "TMK" ) + mv_par04 )
					oPrint:Say( lin, 120, STR0006 + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont09 ) //"Responsável:  "
					oPrint:Say( lin, 1550, STR0044, oFont09 ) //"Ass.:   _________________________"

					cTipResp := Tabela( "P1", TMK->TMK_INDFUN, .F. )

					lin += 50
					oPrint:Say( lin, 120, STR0015 + cTipResp, oFont09 ) //"Cargo:  "
					oPrint:Say( lin, 1550, STR0016 + DToC( dDataBase ), oFont09 ) //"Data do Mapa:  "

					lin += 80
					oPrint:Line( lin, 100, lin, nPos6106 )
					linaux := lin
					oPrint:Say( lin + 50, 270, STR0017, oFont09 ) //"SETOR"
					oPrint:Say( lin + 50, 735, STR0018, oFont09 ) //"AGENTES IDENTIFICADOS"
					oPrint:Say( lin + 30, 1390, STR0019, oFont09 ) //"INTENSIDADE OU "
					oPrint:Say( lin + 70, 1380, STR0020, oFont09 ) //" CONCENTRAÇÃO"
					oPrint:Say( lin + 30, 1760, STR0021, oFont09 ) //"Nº DE TRABALHADORES"
					oPrint:Say( lin + 70, 1830, STR0022, oFont09 ) //"    EXPOSTOS"

					lin += 80

					Somalin( 65, .F. )
					oPrint:Line( lin, 100, lin, nPos6106 )

					If mv_par05 == 1
						oPrint:Say( lin + 50, 270, STR0035, oFont09 )  //"0 (zero)"
						oPrint:Say( lin + 50, 860, STR0035, oFont09 )  //"0 (zero)"
						oPrint:Say( lin + 50, 1485, STR0035, oFont09 ) //"0 (zero)"
						oPrint:Say( lin + 50, 1900, STR0035, oFont09 )  //"0 (zero)"
					EndIf

					For nX := 1 To 10
						Somalin( 65, .F. )
					Next nX
					oPrint:Line( lin, 100, lin, nPos6106 )

					oPrint:Line( lin, 100, lin, nPos6106 )
					oPrint:Line( 200, 100, lin, 100 )
					oPrint:Line( linaux, nPos6103, lin, nPos6103 )
					If lTN0Depto
						oPrint:Line( linaux, 1150, lin, 1150 )
					EndIf
					oPrint:Line( linaux, nPos6104, lin, nPos6104 )
					oPrint:Line( linaux, nPos6105, lin, nPos6105 )
					oPrint:Line( 200, nPos6106, lin, nPos6106 )

					MDT610QUAD()
				EndIf

				dbSelectArea( cAlias )
				dbSkip()
			End
		Else
			oPrint:StartPage()
			lin := 200
			oPrint:Line( lin, 100, lin, nPos6106 )

			cFileLogo := "lgrl" + cSMCOD + cSMFIL + ".bmp"
			If File( cFileLogo )
				oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
			Else
				cFileLogo := "lgrl" + cSMCOD + ".bmp"
				If File( cFileLogo )
					oPrint:sayBitMap( lin + 50, 150, cFileLogo, 500, 150 )
				EndIf
			EndIf

			lin += 250
			oPrint:Say( lin, 1000, STR0004, oFont14 ) //"QUADRO V"

			lin += 140
			oPrint:Say( lin, 120, STR0005, oFont12 ) //"INSALUBRIDADE"
			lin += 100
			dbSelectArea( "TMK" )
			dbSetOrder( 01 )
			dbSeek( xFilial( "TMK" ) + mv_par04 )
			oPrint:Say( lin, 120, STR0006 + Alltrim( SubStr( TMK->TMK_NOMUSU, 1, 40 ) ), oFont09 ) //"Responsável:  "
			oPrint:Say( lin, 1550, STR0044, oFont09 ) //"Ass.:   _________________________"

			cTipResp := Tabela( "P1", TMK->TMK_INDFUN, .F. )

			lin += 50
			oPrint:Say( lin, 120, STR0015 + cTipResp, oFont09 ) //"Cargo:  "
			oPrint:Say( lin, 1550, STR0016 + DToC( dDataBase ), oFont09 ) //"Data do Mapa:  "

			lin += 80
			oPrint:Line( lin, 100, lin, nPos6106 )
			linaux := lin
			If lTN0Depto
				oPrint:Say( lin + 50, 420, STR0017, oFont09, , , , 2 ) //"SETOR"
				oPrint:Say( lin + 50, 945, STR0045, oFont09, , , , 2 ) //"DEPARTAMENTO"
				oPrint:Say( lin + 50, 1475, STR0018, oFont09, , , , 2 ) //"AGENTES IDENTIFICADOS"
				oPrint:Say( lin + 30, 1930, STR0019, oFont09, , , , 2 ) //"INTENSIDADE OU "
				oPrint:Say( lin + 70, 1930, STR0020, oFont09, , , , 2 ) //" CONCENTRAÇÃO"
				oPrint:Say( lin + 30, 2230, STR0021, oFont09, , , , 2 ) //"Nº DE TRABALHADORES"
				oPrint:Say( lin + 70, 2230, STR0022, oFont09, , , , 2 ) //"    EXPOSTOS"
			Else
				oPrint:Say( lin + 50, 270, STR0017, oFont10 ) //"SETOR"
				oPrint:Say( lin + 50, 735, STR0018, oFont10 ) //"AGENTES IDENTIFICADOS"
				oPrint:Say( lin + 30, 1390, STR0019, oFont10 ) //"INTENSIDADE OU "
				oPrint:Say( lin + 70, 1380, STR0020, oFont10 ) //" CONCENTRAÇÃO"
				oPrint:Say( lin + 30, 1760, STR0021, oFont10 ) //"Nº DE TRABALHADORES"
				oPrint:Say( lin + 70, 1830, STR0022, oFont10 ) //"    EXPOSTOS"
			EndIf

			lin += 80

			Somalin( 65, .F. )
			oPrint:Line( lin, 100, lin, nPos6106 )

			If mv_par05 == 1
				oPrint:Say( lin + 50, 270, STR0035, oFont09 )  //"0 (zero)"
				oPrint:Say( lin + 50, 860, STR0035, oFont09 )  //"0 (zero)"
				oPrint:Say( lin + 50, 1490, STR0035, oFont09 ) //"0 (zero)"
				oPrint:Say( lin + 50, 1910, STR0035, oFont09 )  //"0 (zero)"
			EndIf

			For nX := 1 To 10
				Somalin( 65, .F. )
			Next nX
			oPrint:Line( lin, 100, lin, nPos6106 )

			oPrint:Line( lin, 100, lin, nPos6106 )
			oPrint:Line( 200, 100, lin, 100 )
			oPrint:Line( linaux, nPos6103, lin, nPos6103 )
			If lTN0Depto
				oPrint:Line( linaux, 1150, lin, 1150 )
			EndIf
			oPrint:Line( linaux, nPos6104, lin, nPos6104 )
			oPrint:Line( linaux, nPos6105, lin, nPos6105 )
			oPrint:Line( 200, nPos6106, lin, nPos6106 )

			MDT610QUAD()
		EndIf
	EndIf

	If Mv_par01 = 1
		oPrint:Preview()
	Else
		oPrint:Print()
	EndIf

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalin
Soma linha

@return	.T., Boolean, Sempre true

@sample Somalin()

@author	Liber De Esteban
@since	20/04/2005
/*/
//-------------------------------------------------------------------
Static Function Somalin( nLin, lLinha )

	lin += nLin

	If lin > 2800
		If lLinha
			oPrint:Line( lin, 100, lin, nPos6106 )
		EndIf

		oPrint:Line( 200, 100, lin, 100 )
		oPrint:Line( linaux, nPos6103, lin, nPos6103 )

		If lTN0Depto
			oPrint:Line( linaux, 1150, lin, 1150 )
		EndIf

		oPrint:Line( linaux, nPos6104, lin, nPos6104 )
		oPrint:Line( linaux, nPos6105, lin, nPos6105 )
		oPrint:Line( 200, nPos6106, lin, nPos6106 )
		oPrint:EndPage()
		oPrint:StartPage()

		lin := 200
		linaux := lin

		If !lLinha
			oPrint:Line( lin, 100, lin, nPos6106 )
		EndIf
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT610QUAD
Imprime o quadro com dados da empresa

@return	.T., Boolean, Sempre true

@sample MDT610QUAD()

@author	Liber De Esteban
@since	12/07/2002
/*/
//-------------------------------------------------------------------
Static Function MDT610QUAD()

	If lMdtps .Or. lSigaMdtPS //Se a empresa for prestadora de serviços

		dbSelectArea( "SA1" )
		dbSetOrder( 01 )
		dbSeek( xFilial( "SA1" ) + cCodcli )

		cNome	  := SA1->A1_NOME
		cEndereco := SA1->A1_END
		cCidade	  := SA1->A1_MUN

		If Empty( SA1->A1_DDD )
			cTelefone := SA1->A1_TEL
		Else
			cTelefone := "(" + Alltrim( SA1->A1_DDD ) + ")" + Alltrim( SA1->A1_TEL )
		EndIf
	Else
		cNome	  := SM0->M0_NOMECOM
		cEndereco := SM0->M0_ENDCOB
		cCidade	  := SM0->M0_CIDCOB
		cTelefone := SM0->M0_TEL
	EndIf

	oPrint:Box( lin, 100, lin + 220, nPos6106 )
	oPrint:Say( lin + 20, 120, STR0026, oFont12 ) //"DADOS DA EMPRESA"

	lin += 75
	oPrint:Say( lin + 20, 120, STR0027 + "...: " + cNome, oFont10 ) //"EMPRESA"
	oPrint:Say( lin + 20, 1250, STR0028 + ".....: " + cCidade, oFont10 ) //"CIDADE"

	lin += 65
	oPrint:Say( lin + 20, 120, STR0029 + ": " + cEndereco, oFont10 ) //"ENDERECO"
	oPrint:Say( lin + 20, 1250, STR0030 + ": " + cTelefone, oFont10 ) //"TELEFONE"

	oPrint:EndPage()

Return .T.
