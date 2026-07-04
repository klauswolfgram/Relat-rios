/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "MDTR869.ch"

Static _nFilCC := 1
Static _nCodCC := 2
Static _nHrExp := 3
Static _nSAfas := 4
Static _nCAfas := 5
Static _nDPerd := 6

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR869  ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 30.05.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³       Relatorio da Taxa Mensal de Acidentes.               ³±±
±±³          ³ - Esse relatorio imprime uma tabela que segue os padroes do³±±
±±³          ³ Quadro I da NR-30. O usuario escolhe o ano e um centro de  ³±±
±±³          ³ custo.                                                     ³±±
±±³          ³ - Sao verficados todos os funcionarios pertencentes ao     ³±±
±±³          ³ centro de custo informado durante o ano informado. Sao     ³±±
±±³          ³verificados todos os acidentes desses funcionarios durante  ³±±
±±³          ³o ano informado.                                            ³±±
±±³          ³- Com base no resumo destas informacoes, e' preenchido o    ³±±
±±³          ³quadro estatisco.                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR869(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR869()

//----------------------------------------------------------------
//  Define Variaveis
//----------------------------------------------------------------
Local cTitulo := STR0001 //"Taxa Mensal de Acidentes"

Local aNGBEGINPRM := NGBEGINPRM( )

Private cAlias  := "SI3"
Private cCodFil := "SI3->I3_FILIAL"
Private cCodCC  := "SI3->I3_CUSTO"
Private cDescCC := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias  := "CTT"
	cCodFil := "CTT->CTT_FILIAL"
	cCodCC  := "CTT->CTT_CUSTO"
	cDescCC := "CTT->CTT_DESC01"
Endif

Private cPerg := PADR( "MDT869" , 10 )

//----------------------------------------------------------------
//	Verifica as perguntas selecionadas
//----------------------------------------------------------------
pergunte(cPerg,.F.)

//----------------------------------------------------------------
// Variaveis utilizadas para parametros
// mv_par01			// Ano ?
// mv_par02			// Imprimir Conforme NR-30?
// mv_par03			// Tipo de Impressao ?
// mv_par04			// De Centro Custo ?
// mv_par05			// Ate Centro Custo ?
// mv_par06			// De Filial ?
// mv_par07			// Ate Filial ?
// mv_par08			// Listar acidentes ?
// mv_par09			// Filtro Avançado de Centro de Custo ?
// mv_par10			//Imprime Centro Custo s/ Acid. ?
// mv_par11			// Imprimir Total por Filial ?
//-----------------------------------------------------------------

If pergunte(cPerg,.t.)
	Processa({|lEnd| U_MDT869IMP()})
Endif

//------------------------------------------------------
//  Devolve variaveis armazenadas (NGRIGHTCLICK)       -
//------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT869IMP
Busca os dados e realiza a impressão do relatório

@return Nil

@sample U_MDT869IMP()

@author Andre E. Perez Alvarez - Refeito por: Jackson Machado
@since 31/05/2006 - Refeito em: 18/02/2016
/*/
//---------------------------------------------------------------------
User Function MDT869IMP()

	Local nX, nY, nZ, nYY, nXX, nQf
	Local nFil, nPosArr
	Local cFilFun
	Local dtInic, dtFim
	Local Mv_HrMes := SuperGetMv("MV_NG2HMES",.F.,0)
	Local cEmp := cEmpAnt
	Local cEmpresa:= ""
	Local aFilFun := {}
	//----------------------------------------------------------------
	// Array que contem os valores agrupados por C.C.
	//----------------------------------------------------------------
	/*   Elementos:
		[x][1] - Filial do C.C.
		[x][2] - Código do C.C.
		[x][3..1] - Horas Homem Exposição Janeiro
		[x][3..y] - Horas Homem Exposição Mês Y
		[x][4..1] - Acidentes Sem Afastamento Janeiro
		[x][4..y] - Acidentes Sem Afastamento Mês Y
		[x][5..1] - Acidentes Com Afastamento Janeiro
		[x][5..y] - Acidentes Com Afastamento Mês Y
		[x][6..1] - Horas Perdidas Janeiro
		[x][6..y] - Horas Perdidas Mês Y		*/
	Local aCustos := {}
	Local aFuncio := {}//Array com os funcionários já considerados
	Local aValZero := { 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 }//Array de valores zerados

	//Arrays para consistir as informações
	Private aCCusto := {}
	Private aQuadro := {}
	Private aDtMes  := {}

	//Objetos de Impressão
	Private oPrint		:= TMSPrinter():New( OemToAnsi( STR0001 ) ) //"Taxa Mensal de Acidentes"
	Private oFont08		:= TFont():New( "Arial",08,08,,.F.,,,,.F.,.F.)
	Private oFont09n	:= TFont():New( "Arial",09,09,,.T.,,,,.F.,.F.)
	Private oFont10		:= TFont():New( "Arial",10,10,,.F.,,,,.F.,.F.)
	Private oFont12		:= TFont():New( "Arial",12,12,,.F.,,,,.F.,.F.)
	Private oFont12n	:= TFont():New( "Arial",12,12,,.T.,,,,.F.,.F.)
	Private oFont14n	:= TFont():New( "Arial",13,13,,.T.,,,,.F.,.F.)

	Private cVerbas    := ""
	Private lIntMDTGPE := .f.
	Private aQuadroFil := {} // Array utilizado para imprimir quantidade total (Por Filial)


	If Alltrim(GETMV("MV_MDTGPE")) == "S"
		lIntMDTGPE := .t.
		cVerbas := Alltrim(GETMV("MV_MDTVERBA"))
	Endif
	If mv_par09 == 1
		U_MDT869FILT() //"Filtro Avançado de C. de Custo"
	Endif

	//----------------------------------------------------------------
	// Array com as informacoes do Quadro I - NR-30
	//----------------------------------------------------------------
	/*   Elementos:
		[x][1] - Mes e Total
		[x][2] - Horas homem de exposicao ao risco
		[x][3] - Numero de acidentes ocorridos sem afastamento
		[x][4] - Numero de acidentes ocorridos com afastamento
		[x][5] - Taxa de acidentados sem afastamento
		[x][6] - Taxa de acidentados com afastamento
		[x][7] - Taxa de Gravidade
		[x][8] - Dias Perdidos*/
	aAdd( aQuadro, { STR0007, 0, 0, 0, 0, 0, 0, 0 } ) //"JANEIRO"
	aAdd( aQuadro, { STR0008, 0, 0, 0, 0, 0, 0, 0 } ) //"FEVEREIRO"
	aAdd( aQuadro, { STR0009, 0, 0, 0, 0, 0, 0, 0 } ) //"MARÇO"
	aAdd( aQuadro, { STR0010, 0, 0, 0, 0, 0, 0, 0 } ) //"ABRIL"
	aAdd( aQuadro, { STR0011, 0, 0, 0, 0, 0, 0, 0 } ) //"MAIO"
	aAdd( aQuadro, { STR0012, 0, 0, 0, 0, 0, 0, 0 } ) //"JUNHO"
	aAdd( aQuadro, { STR0013, 0, 0, 0, 0, 0, 0, 0 } ) //"JULHO"
	aAdd( aQuadro, { STR0014, 0, 0, 0, 0, 0, 0, 0 } ) //"AGOSTO"
	aAdd( aQuadro, { STR0015, 0, 0, 0, 0, 0, 0, 0 } ) //"SETEMBRO"
	aAdd( aQuadro, { STR0016, 0, 0, 0, 0, 0, 0, 0 } ) //"OUTUBRO"
	aAdd( aQuadro, { STR0017, 0, 0, 0, 0, 0, 0, 0 } ) //"NOVEMBRO"
	aAdd( aQuadro, { STR0018, 0, 0, 0, 0, 0, 0, 0 } ) //"DEZEMBRO"
	aAdd( aQuadro, { STR0019, 0, 0, 0, 0, 0, 0, 0 } ) //"TOTAL"

	aQuadroFil := aClone( aQuadro ) // Array utilizado para imprimir quantidade total (Por Filial)

	//Define as datas de início e fim de cada mês
	cAnoTmp := SubSTR( Alltrim( STR( mv_par01 ) ), 3, 2 )
	aAdd( aDtMes, { CtoD( "01/01/" + cAnoTmp ) , CtoD( "31/01/" + cAnoTmp ) } )
	If Mod( mv_par01, 4 ) == 0 .AND. Mod( mv_par01, 100 ) <> 0//Caso seja ano bissexto
		aAdd( aDtMes, { CtoD( "01/02/" + cAnoTmp ) , CtoD( "29/02/"+  cAnoTmp ) } )
	Else
		aAdd( aDtMes, { CtoD( "01/02/" + cAnoTmp ) , CtoD( "28/02/" + cAnoTmp ) } )
	Endif
	aAdd( aDtMes, { CtoD( "01/03/" + cAnoTmp ) , CtoD( "31/03/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/04/" + cAnoTmp ) , CtoD( "30/04/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/05/" + cAnoTmp ) , CtoD( "31/05/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/06/" + cAnoTmp ) , CtoD( "30/06/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/07/" + cAnoTmp ) , CtoD( "31/07/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/08/" + cAnoTmp ) , CtoD( "31/08/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/09/" + cAnoTmp ) , CtoD( "30/09/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/10/" + cAnoTmp ) , CtoD( "31/10/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/11/" + cAnoTmp ) , CtoD( "30/11/" + cAnoTmp ) } )
	aAdd( aDtMes, { CtoD( "01/12/" + cAnoTmp ) , CtoD( "31/12/" + cAnoTmp ) } )

 	//------------------------------
 	// Inicia a impressão
 	//------------------------------
	oPrint:SetPortrait()
	oPrint:Setup()
	//-------------------------------------------------
	// Busca os acidentes por Filial
	// Avalia todos os acidentes ocorridos no período,
	// buscando todos os Centros de Custo afetados
	// Caso acidente seja exclusivo e não tenha ocorrido
	// na filial do filtro, não considera, mesmo que o
	// funcionário seja da filial
	//-------------------------------------------------
	dbSelectArea( "TNC" )
	dbSetOrder( 1 )
	If !Empty( mv_par06 )
		dbSeek( xFilial( "TNC" , mv_par06 ) )
	Else
		dbGoTop()
	EndIf
	While TNC->( !Eof() ) .And. TNC->TNC_FILIAL <= mv_par07

		//Caso acidente não tenha ocorrido no período ou seja diferente do tipo, não considera
		If Year( TNC->TNC_DTACID ) == mv_par01 .And. ;
			( TNC->TNC_INDACI == STR( mv_par08 , 1 ) .OR. mv_par08 == 5 ) .And. ;
			TNC->TNC_VITIMA $ "1/3"
			If Empty( TNC->TNC_NUMFIC )//Caso esteja com Vítima como Sim e sem Ficha Médica, considera o C.C. e Filial do Acidente
				// Verifica os filtros do C.C. para verificar se considera
				// Caso Len( aCCusto ) seja 0, significa que não utilizou Filtro Avançado, caso haja algum C.C. signfica Filtro Avançado
				If !Empty( TNC->TNC_CC ) .And. ( ( Len( aCCusto ) == 0 .And. TNC->TNC_CC >= mv_par04 .And. TNC->TNC_CC <= mv_par05 ) .Or. ;
						( aScan( aCCusto , { | x | x[ 1 ] == xFilial( "SRA" , TNC->TNC_FILIAL ) .And. x[ 2 ] == TNC->TNC_CC } ) > 0 ) )
					//Busca se já adicionou o C.C., caso já tenha, utiliza a posição, caso não adiciona nova
					If ( nPosArr := aScan( aCustos , { | x | x[ _nFilCC ] == xFilial( "SRA" , TNC->TNC_FILIAL ) .And. x[ _nCodCC ] == TNC->TNC_CC } ) ) == 0
						aAdd( aCustos , { xFilial( "SRA" , TNC->TNC_FILIAL ) , TNC->TNC_CC , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) } )
						nPosArr := Len( aCustos )
					EndIf

					//Verifica afastamento do acidente
					lTemAfast := .F.
					nDiasAfas := 0
					If TNC->TNC_QTAFAS > 0//Caso não tenha SR8, verifica se foi lançado dias de afastamento no acidente
						nDiasAfas := TNC->TNC_QTAFAS
						lTemAfast := .T.
					EndIf
					If lTemAfast//Caso tenha alguma quantidade de dias de afastamento
						If TNC->TNC_DIASDB > nDiasAfas//Considera a maior quantidade entre dias afastados e dias debitados
							nDiasAfas := TNC->TNC_DIASDB
						Endif
						//Acidente com afastamento
						aCustos[ nPosArr , _nCAfas , Month( TNC->TNC_DTACID ) ] += 1
						aCustos[ nPosArr , _nDPerd , Month( TNC->TNC_DTACID ) ] += nDiasAfas
					Else
						//Acidente sem afastamento
						aCustos[ nPosArr , _nSAfas , Month( TNC->TNC_DTACID ) ] += 1
					EndIf
				EndIf
			Else
				//Busca as informações do funcionário
				dbSelectArea( "TM0" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "TM0" , TNC->TNC_FILIAL ) + TNC->TNC_NUMFIC )//Verifica a ficha médica da Filial do acidente

				dbSelectArea( "SRA" )
				dbSetOrder( 1 )
				dbSeek( xFilial( "SRA" , TM0->TM0_FILFUN ) + TM0->TM0_MAT )

				//Filtra pelas informações do Funcionário
				If SRA->RA_CATFUNC $ "A,E,P,G"
					TNC->( dbSkip() )
					Loop
				EndIf
				//Caso demitido antes do Ano, acidente não deve ser considerado pois ocorreu após a saída do funcionário
				If SRA->RA_SITFOLH == "D" .And. !Empty( SRA->RA_DEMISSA ) .And. Year( SRA->RA_DEMISSA ) < mv_par01
					TNC->( dbSkip() )
					Loop
				EndIf
				//Caso admitido após o Ano, acidente não deve ser considerado pois ocorreu antes da entrada do funcionário
				If Year( SRA->RA_ADMISSA ) > mv_par01
					TNC->( dbSkip() )
					Loop
				EndIf

				//Busca o histórico do funcionário naquele ano
				aFilFun := fBuscaHist( cValToChar( Year( TNC->TNC_DTACID ) ) )

				//Verifica se a data do acidente ocorreu em algum período de transferência do funcionário na empresa
				nPosCC := aScan( aFilFun , { | x | x[ 1 ] == cEmp .And. x[ 4 ] <= TNC->TNC_DTACID .And. x[ 5 ] >= TNC->TNC_DTACID } )

				// Caso localize o centro de custo correto, verifica os filtros do C.C. para verificar se considera
				// Caso Len( aCCusto ) seja 0, significa que não utilizou Filtro Avançado, caso haja algum C.C. signfica Filtro Avançado
				If nPosCC > 0 .And. ( ( Len( aCCusto ) == 0 .And. aFilFun[ nPosCC , 7 ] >= mv_par04 .And. aFilFun[ nPosCC , 7 ] <= mv_par05 ) .Or. ;
						( aScan( aCCusto , { | x | x[ 1 ] == xFilial( "SRA" , aFilFun[ nPosCC , 2 ] ) .And. x[ 2 ] == aFilFun[ nPosCC , 7 ] } ) > 0 ) )

					//Busca se já adicionou o C.C., caso já tenha, utiliza a posição, caso não adiciona nova
					If ( nPosArr := aScan( aCustos , { | x | x[ _nFilCC ] == xFilial( "SRA" , aFilFun[ nPosCC , 2 ] ) .And. x[ _nCodCC ] == aFilFun[ nPosCC , 7 ] } ) ) == 0
						aAdd( aCustos , { xFilial( "SRA" , aFilFun[ nPosCC , 2 ] ) , aFilFun[ nPosCC , 7 ] , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) } )
						nPosArr := Len( aCustos )
					EndIf

					//Verifica afastamento do acidente
					lTemAfast := .f.
					nDiasAfas := fTemSR8( xFilial( "SRA" , aFilFun[ nPosCC , 2 ] ) , aFilFun[ nPosCC , 6 ] , TNC->TNC_DTACID )
					If nDiasAfas > 0//Verifica se tem SR8 para considerar os dias reais
						lTemAfast := .t.
					ElseIf TNC->TNC_QTAFAS > 0//Caso não tenha SR8, verifica se foi lançado dias de afastamento no acidente
						nDiasAfas := TNC->TNC_QTAFAS
						lTemAfast := .t.
					EndIf
					If lTemAfast//Caso tenha alguma quantidade de dias de afastamento
						If TNC->TNC_DIASDB > nDiasAfas//Considera a maior quantidade entre dias afastados e dias debitados
							nDiasAfas := TNC->TNC_DIASDB
						Endif
						//Acidente com afastamento
						aCustos[ nPosArr , _nCAfas , Month( TNC->TNC_DTACID ) ] += 1
						aCustos[ nPosArr , _nDPerd , Month( TNC->TNC_DTACID ) ] += nDiasAfas
					Else
						//Acidente sem afastamento
						aCustos[ nPosArr , _nSAfas , Month( TNC->TNC_DTACID ) ] += 1
					EndIf
				EndIf
			EndIf
		EndIf

		TNC->( dbSkip() )
	End

	// Busca todos os Centros de Custo para Impressão
	// Irá buscar somente se deve considerar C.C. em Branco
	If mv_par10 == 1
		dbSelectArea( cAlias )
		dbSetOrder( 1 )
		If !Empty( mv_par06 )
			dbSeek( xFilial( cAlias , mv_par06 ) )
		Else
			dbGoTop()
		EndIf
		While ( cAlias )->( !Eof() ) .And. &( cCodFil ) <= mv_par07
			If ( Len( aCCusto ) == 0 .And. &( cCodCC ) >= mv_par04 .And. &( cCodCC ) <= mv_par05 ) .Or. ;
					( aScan( aCCusto , { | x | x[ 1 ] == &( cCodFil ) .And. x[ 2 ] == &( cCodCC ) } ) > 0 )
				If ( nPosArr := aScan( aCustos , { | x | x[ _nFilCC ] == &( cCodFil ) .And. x[ _nCodCC ] == &( cCodCC ) } ) ) == 0
					aAdd( aCustos , { &( cCodFil ) , &( cCodCC ) , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) , aClone( aValZero ) } )
				EndIf
			EndIf
			( cAlias )->( dbSkip() )
		End
	EndIf

	//Caso tenha achado algum C.C. busca os funcionários
	If Len( aCustos ) > 0
		//Calcula Horas Homem de Exposição
		dbSelectArea( "SRA" )
		dbSetOrder( 1 )
		If !Empty( mv_par06 )
			dbSeek( xFilial( "SRA" , mv_par06 ) )
		Else
			dbGoTop()
		EndIf
		While SRA->( !EoF() ) .And. SRA->RA_FILIAL <= mv_par07

			//Filtra pelas informações do Funcionário
			If SRA->RA_CATFUNC $ "A,E,P,G"
				SRA->( dbSkip() )
				Loop
			EndIf

			//Demissão anterior ao relatório, desconsidera
			If SRA->RA_SITFOLH == "D" .And. !Empty( SRA->RA_DEMISSA ) .And. Year( SRA->RA_DEMISSA ) < mv_par01
				SRA->( dbSkip() )
				Loop
			EndIf

			//Admissão posterior ao relatório desconsidera
			If Year( SRA->RA_ADMISSA ) > mv_par01
				SRA->( dbSkip() )
				Loop
			EndIf

			//Traz o histórico desse funcionário no ano
			aFilFun := fBuscaHist( cValToChar( mv_par01 ) )

			//Caso tenha um histórico, considera pelo histórico, caso não, considera pela SRA
			If Len( aFilFun ) > 0
				For nFil := 1 To Len( aFilFun )//Percorre histórico
					//Considera apenas registros da empresa atual
					If aFilFun[ nFil , 1 ] == cEmp
						//Trata as datas de início e fim
						If Year( aFilFun[ nFil , 4 ] ) < mv_par01
							nMesInic := 1
							dDtInic  := SToD( cValToChar( mv_par01 ) + "0101" )
						Else
							nMesInic := Month( aFilFun[ nFil , 4 ] )
							dDtInic := aFilFun[ nFil , 4 ]
						EndIf
						If Empty( aFilFun[ nFil , 5 ] ) .Or. Year( aFilFun[ nFil , 5 ] ) > mv_par01
							nMesFim := 12
							dDtFim  := SToD( cValToChar( mv_par01 ) + "1231" )
						Else
							nMesFim := Month( aFilFun[ nFil , 5 ] )
							dDtFim  := aFilFun[ nFil , 5 ]
						EndIf
						//Quantidade de horas trabalhadas no mês
						nHrsMes  := If( SRA->RA_HRSMES == 0 , Mv_HrMes ,SRA->RA_HRSMES )

						// Somente irá considerar os valores do C.C. se já foi usado, pois somente haverão os C.C.
						// de acordo com o Filtro Avançado ou que possuam acidentes
						// Verifica também o Array aFuncio para garantir que já não considerou este funcionário
						If ( nPosArr := aScan( aCustos , { | x | x[ _nFilCC ] == xFilial( "SRA" , aFilFun[ nFil , 2 ] ) .And. x[ _nCodCC ] == aFilFun[ nFil , 7 ] } ) ) > 0 .And. ;
								aScan( aFuncio , { | x |  x[ 1 ] == xFilial( "SRA" , aFilFun[ nFil , 2 ] ) .And. x[ 2 ] == aFilFun[ nFil , 6 ] .And. x[ 3 ] == aFilFun[ nFil , 7 ] .And. x[ 4 ] == dDtInic .And. x[ 5 ] == dDtFim } ) == 0

							For nY := nMesInic to nMesFim
								dTmpIni := If( dDtInic < aDtMes[nY,1] , aDtMes[nY,1] , dDtInic )
								dTmpFim := If( dDtFim > aDtMes[nY,2] , aDtMes[nY,2] , dDtFim )
								//Total de horas trabalhadas pelo funcionario
								aCustos[ nPosArr , _nHrExp , nY ] += ((dTmpFim - dTmpIni) + 1) * (nHrsMes / 30)
								If lIntMDTGPE
									//Acrescenta as horas extras e subtrai as faltas (1. Filial+Mat, 2.Verbas, 3.De Data, 4.Ate Data, 5.Horas Mes)
									aCustos[ nPosArr , _nHrExp , nY ] += MDT865HrsF( xFilial( "SRA" , aFilFun[ nFil , 2 ] )+aFilFun[ nFil , 6 ], cVerbas, dTmpIni, dTmpFim, SRA->RA_HRSMES )
								Endif

							Next nY

							//Adiciona no Array para não considerar mais esse funcionário
							aAdd( aFuncio , { xFilial( "SRA" , aFilFun[ nFil , 2 ] ) , aFilFun[ nFil , 6 ] , aFilFun[ nFil , 7 ] , dDtInic , dDtFim } )
						EndIf
					EndIf
				Next nFil
			Else
				//Trata as datas de início e fim
				If Year( SRA->RA_ADMISSA ) < mv_par01
					nMesInic := 1
					dDtInic  := SToD( cValToChar( mv_par01 ) + "0101" )
				Else
					nMesInic := Month( SRA->RA_ADMISSA )
					dDtInic := SRA->RA_ADMISSA
				EndIf
				If Empty( SRA->RA_DEMISSA ) .Or. Year( SRA->RA_DEMISSA ) > mv_par01
					nMesFim := 12
					dDtFim  := SToD( cValToChar( mv_par01 ) + "1231" )
				Else
					nMesFim := Month( SRA->RA_DEMISSA )
					dDtFim  := SRA->RA_DEMISSA
				EndIf
				//Quantidade de horas trabalhadas no mês
				nHrsMes  := If( SRA->RA_HRSMES == 0 , Mv_HrMes ,SRA->RA_HRSMES )

				// Somente irá considerar os valores do C.C. se já foi usado, pois somente haverão os C.C.
				// de acordo com o Filtro Avançado ou que possuam acidentes
				// Verifica também o Array aFuncio para garantir que já não considerou este funcionário
				If ( nPosArr := aScan( aCustos , { | x | x[ _nFilCC ] == SRA->RA_FILIAL .And. x[ _nCodCC ] == SRA->RA_CC } ) ) > 0 .And. ;
						aScan( aFuncio , { | x |  x[ 1 ] == SRA->RA_FILIAL .And. x[ 2 ] == SRA->RA_MAT .And. x[ 3 ] == SRA->RA_CC .And. x[ 4 ] == dDtInic .And. x[ 5 ] == dDtFim } ) == 0

					For nY := nMesInic to nMesFim
						dTmpIni := If( dDtInic < aDtMes[nY,1] , aDtMes[nY,1] , dDtInic )
						dTmpFim := If( dDtFim > aDtMes[nY,2] , aDtMes[nY,2] , dDtFim )
						//Total de horas trabalhadas pelo funcionario
						aCustos[ nPosArr , _nHrExp , nY ] += ((dTmpFim - dTmpIni) + 1) * (nHrsMes / 30)
						If lIntMDTGPE
							//Acrescenta as horas extras e subtrai as faltas (1. Filial+Mat, 2.Verbas, 3.De Data, 4.Ate Data, 5.Horas Mes)
							aCustos[ nPosArr , _nHrExp , nY ] += MDT865HrsF( SRA->RA_FILIAL+SRA->RA_MAT, cVerbas, dTmpIni, dTmpFim, SRA->RA_HRSMES )
						Endif

					Next nY

					//Adiciona no Array para não considerar mais esse funcionário
					aAdd( aFuncio , { SRA->RA_FILIAL , SRA->RA_MAT , SRA->RA_CC , dDtInic , dDtFim } )
				EndIf
			EndIf
			SRA->( dbSkip() )
		End


		//Ordena os Centros de Custo por Filial + Código
		aSort( aCustos , , , { | x , y | x[ _nFilCC ]+x[ _nCodCC ] < y[ _nFilCC ]+y[ _nCodCC ] })

		For nXX := 1 To Len(aCustos)
			//----------------------------------------------
			//  Preenche o array que representa o Quadro I
			//----------------------------------------------
			For nX := 1 To 12
				//2 - Horas homem de exposicao ao risco
				aQuadro[nX][2] := Round( aCustos[ nXX , _nHrExp , nX ] , 2 )
				aQuadro[13][2] += aQuadro[nX][2]//Total
				//3 - Nº Sem Afastamentos
				aQuadro[nX][3] := aCustos[ nXX , _nSAfas , nX ]
				aQuadro[13][3] += aQuadro[nX][3]//Total
				//4 - Nº Com Afastamentos
				aQuadro[nX][4] := aCustos[ nXX , _nCAfas , nX ]
				aQuadro[13][4] += aQuadro[nX][4]//Total
				//5 - Taxa de acidentados sem afastamento
				aQuadro[nX][5] := Round( ((aQuadro[nX][3] * 1000000) / aQuadro[nX][2]), 2)
				//6 - Taxa de acidentados com afastamento
				aQuadro[nX][6] := Round( ((aQuadro[nX][4] * 1000000) / aQuadro[nX][2]), 2)
				//8 - Dias Perdidos
				aQuadro[nX][8] := aCustos[ nXX , _nDPerd , nX ]
				aQuadro[13][8] += aCustos[ nXX , _nDPerd , nX ]
				//7 - Taxa de Gravidade
				aQuadro[nX][7] := Round( ((aQuadro[nX][8] * 1000000) / aQuadro[nX][2]), 2)
			Next nX
			aQuadro[13][5] := Round( ((aQuadro[13][3] * 1000000) / aQuadro[13][2]), 2)
			aQuadro[13][6] := Round( ((aQuadro[13][4] * 1000000) / aQuadro[13][2]), 2)
			aQuadro[13][7] := Round( ((aQuadro[13][8] * 1000000) / aQuadro[13][2]), 2)
			//-----------------------------------
			//- Fim do preenchimento            -
			//-----------------------------------

			//-----------------------------
			//- Imprime o quadro          -
			//-----------------------------
			dbSelectArea(cAlias)
			DbSetOrder(1)
			DbSeek(xFilial(cAlias, aCustos[nXX,_nFilCC])+aCustos[nXX,_nCodCC])
			U_MODMDT869(cDescCC,,aCustos[nXX,_nFilCC])

			If mv_par11 == 1 // Verifica se será impresso o Totalizador por Filial

				//-------------------------------------------------------------------
				//- Salva os valores no array aQuadroFil, para que seja impresso    -
				//-  um relatório com a quantidade Total da Filial.                 -
				//-------------------------------------------------------------------
				AEVAL( aQuadro, { | x,y | aQuadroFil[y][2] +=  Round( x[2] , 2 ),; //2 - Horas homem de exposicao ao risco
										  aQuadroFil[y][3] +=  x[3],;			   //3 - Nº Sem Afastamentos
										  aQuadroFil[y][4] +=  x[4],;			   //4 - Nº Com Afastamentos
										  aQuadroFil[y][8] +=  x[8];			   //8 - Dias Perdidos
				})
				
				For nQf := 1 To Len(aQuadroFil)
					aQuadroFil[nQf][5] := Round( ( ( aQuadroFil[nQf][3] * 1000000) / aQuadroFil[nQf][2]), 2) //5 - Taxa de acidentados sem afastamento
					aQuadroFil[nQf][6] := Round( ( ( aQuadroFil[nQf][4] * 1000000) / aQuadroFil[nQf][2]), 2) //6 - Taxa de acidentados com afastamento
					aQuadroFil[nQf][7] := Round( ( ( aQuadroFil[nQf][8] * 1000000) / aQuadroFil[nQf][2]), 2) //7 - Taxa de Gravidade
				Next nQf

				If (nXX+1 > Len( aCustos ) .Or. aCustos[ nXX+1 , _nFilCC ] <> aCustos[ nXX , _nFilCC ] ) //Verifica se imprime o totalizador por Filial
					cEmpresa:= SM0->M0_CODIGO
					// Imprime quadro final, com o Total por Filial.
					dbSelectArea("SM0")
					dbSetOrder(1)
					dbSeek(cEmpresa + aCustos[nXX,_nFilCC])
					cDescFilial:= "SM0->M0_CODFIL +' '+ SM0->M0_FILIAL"//Descrição da Filial
					aQuadro := aClone(aQuadroFil) // Joga o coteúdo para o array
		  			//- Chama função que faz a impressão    -
					U_MODMDT869(cDescFilial,.T.,aCustos[nXX,_nFilCC])
					AEVAL( aQuadroFil , { | x | AFILL( x , 0, 2, ) } )
				Endif
			Endif
			// Zera Array para nova impressão
			AEVAL( aQuadro , { | x | AFILL( x , 0, 2, ) } )
		Next nXX

		If mv_par03 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		Endif
	Else
		MsgInfo( STR0070 )//"Não há dados para a impressão do relatório."
	EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MODMDT869³ Autor ³Andre E. Perez Alvarez ³ Data ³31/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao do Relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MODMDT869(cDescCC,lImpFilial,cFilCC)

Local nX
Local lin
Local cEmpNome
Local cEmp := cEmpAnt
Local cFil := cFilAnt
Local nColuna :=0

Default lImpFilial:=.F.
Default cFilCC := cFil

DbSelectArea("SM0")
dbseek(cEmp+cFilCC)
cEmpNome := SM0->M0_NOMECOM

oPrint:StartPage() // Iniciar Pagina

//tabela
nColIni := 100  //coluna inicio
nColFim := 2000 //coluna fim
nLinFim := 1560 //linha final da tabela
lin     := 100
nCol    := 1850  //coluna que delimita quadrado do ANO
nColTit := 900
If mv_par02 == 2
	nColFim := 2300
	nCol    := 2150
Endif

oPrint:Say(lin,nColTit,Upper(STR0001),oFont14n) //"TAXA MENSAL DE ACIDENTES"
oPrint:Box(lin:=200,nColIni,nLinFim,nColFim)

//EMPRESA //NAVIO //ANO
oPrint:Say(lin+20,nColIni+20,STR0020,oFont12n) //"EMPRESA:"
oPrint:Say(lin+20,nCol+20,STR0021,oFont12n) //"ANO:"
oPrint:Say(lin+20,nColIni+260,cEmpNome,oFont12)
oPrint:Line(lin:=280,nColIni,lin,nCol)

If mv_par02 == 1
	oPrint:Say(lin+20,nColIni+20,If(!lImpFilial,STR0022,STR0066),oFont12n) //"NAVIO: ou FILIAL:"
	oPrint:Say(lin+20,nColIni+200,AllTrim(&cDescCC),oFont12)
Else
	nColuna:=If(lImpFilial,200,450)
	oPrint:Say(lin+20,nColIni+20,If(!lImpFilial,STR0045,STR0066),oFont12n) //"CENTRO DE CUSTO:  ou FILIAL:"
	oPrint:Say(lin+20,nColIni+nColuna,AllTrim(&cDescCC),oFont12)
Endif
oPrint:Say(lin+20,nCol+30,AllTrim(STR(mv_par01)),oFont12)	 //ano
oPrint:Line(lin:=360,nColIni,lin,nColFim)  //delimita quadrado do ANO
oPrint:Line(200,nCol,360,nCol)	//delimita quadrado do ANO

//(1)HORAS HOMEM DE EXPOSICAO AO RISCO //NUMERO DE ACIDENTES OCORRIDOS //TAXA DE ACIDENTADOS
oPrint:Say(lin+20,nColIni+55,STR0023,oFont09n) //"HORAS HOMEM DE EXPOSIÇÃO AO RISCO"
oPrint:Line(lin,850,nLinFim,850)
oPrint:Say(lin+20,905,STR0024,oFont09n) //"NÚMERO DE ACIDENTES OCORRIDOS"
oPrint:Line(lin,1550,nLinFim,1550)
oPrint:Say(lin+20,1585,STR0025,oFont09n) //"TAXA DE ACIDENTADOS"
If mv_par02 == 2
	oPrint:Line(lin,2000,nLinFim,2000)
	oPrint:Say(lin+20,2050,STR0046,oFont09n) //"GRAVIDADE"
Endif
oPrint:Line(lin:=440,nColIni,lin,nColFim)

//MES  //QUANTIDADE  //(2) SEM AFASTAMENTO  //(3) COM AFASTAMENTO  //(4) TFSA   //(5) TFCA
oPrint:Say(lin+20,nColIni+140,STR0026,oFont09n) //"MÊS"
oPrint:Line(lin,450,nLinFim,450)
oPrint:Say(lin+20,540,STR0027,oFont09n) //"QUANTIDADE"

oPrint:Say(lin+20,855,STR0028,oFont09n) //"SEM AFASTAMENTO"
oPrint:Line(lin,1201,nLinFim,1201)
oPrint:Say(lin+20,1210,STR0029,oFont09n) //"COM AFASTAMENTO"

oPrint:Say(lin+20,1620,STR0030,oFont09n) //"TFSA"
oPrint:Line(lin,1775,nLinFim,1775)
oPrint:Say(lin+20,1840,STR0031,oFont09n) //"TFCA"
If mv_par02 == 2
	oPrint:Line(lin,2000,nLinFim,2000)
	oPrint:Say(lin+20,2120,"TG",oFont09n)
Endif

//Meses
For nX := 1 to Len(aQuadro)
	oPrint:Line(lin+=80,nColIni,lin,nColFim)
	oPrint:Say(lin+20,nColIni+50,aQuadro[nX][1],oFont10)  //Mes e "Total"
	oPrint:Say(lin+20,0820,TransForm(aQuadro[nX][2], "@E 999,999,999.99"	),oFont10,,,,1)  //Quantidade (Horas homem de exposicao ao risco)
	oPrint:Say(lin+20,1170,TransForm(aQuadro[nX][3], "@E 999,999,999"		),oFont10,,,,1) //Numero de acidentes ocorridos sem afastamento
	oPrint:Say(lin+20,1520,TransForm(aQuadro[nX][4], "@E 999,999,999"		),oFont10,,,,1) //Numero de acidentes ocorridos com afastamento
	oPrint:Say(lin+20,1745,TransForm(aQuadro[nX][5], "@E 9,999,999.99"	),oFont10,,,,1) //Taxa de acidentados sem afastamento
	oPrint:Say(lin+20,1970,TransForm(aQuadro[nX][6], "@E 9,999,999.99"	),oFont10,,,,1) //Taxa de acidentados com afastamento
	If mv_par02 == 2
		oPrint:Say(lin+20,2270,TransForm(aQuadro[nX][7],"@E 9,999,999.99"	),oFont10,,,,1) //Taxa de gravidade
	Endif
Next nX

lin += 150

If mv_par02 == 1
	oPrint:Say(lin,nColIni,STR0032,oFont08) //"HORAS HOMEM DE EXPOSIÇÃO AO RISCO - Total de horas à disposição do empregador."
Else
	oPrint:Say(lin,nColIni,STR0044,oFont08) //"HORAS HOMEM DE EXPOSIÇÃO AO RISCO - Total de horas à disposição do empregador."
Endif

oPrint:Say(lin+=40,nColIni,STR0033,oFont08) //"NÚMERO DE ACIDENTES OCORRIDOS SEM AFASTAMENTO - Aquele em que o empregado retorna as suas atividades normais no mesmo"
oPrint:Say(lin+=40,100,STR0034,oFont08) //"dia do acidente ou no dia seguinte no início da próxima jornada de trabalho."

oPrint:Say(lin+=40,nColIni,STR0035,oFont08) //"NÚMERO DE ACIDENTES OCORRIDOS COM AFASTAMENTO - Aquele em que o empregado não retorna as suas atividades normais no"
oPrint:Say(lin+=40,100,STR0036,oFont08) //"mesmo dia do acidente ou no dia seguinte no início da próxima jornada de trabalho."

oPrint:Say(lin+=40,nColIni,STR0037,oFont08) //"TFSA - Número de acidentes sem afastamento x 1.000.000 / número de horas homem de exposição."

oPrint:Say(lin+=40,nColIni,STR0038,oFont08) //"TFCA - Número de acidentes com afastamento x 1.000.000 / número de horas homem de exposição."
If mv_par02 == 2
	oPrint:Say(lin+=40,nColIni,STR0047,oFont08) //"TG - Tempo Computado x 1.000.000 / número de horas homem de exposição."
Endif

oPrint:EndPage()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ NGano869 ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 28.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida o ano informado como parametro na tela de perguntas.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR869(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function NGano869()

If len(AllTrim(str(mv_par01))) != 4
	MsgStop(STR0039) //"O ano informado deve conter 4 dígitos."
	Return .F.
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  fTemSR8 ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 17/09/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se o funcionario tem afastamento por acidente     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fTemSR8( _cFilMat , _cMatFun , _dAcidente )
Local nRet := 0
Local dTemp
Local cTipoAfas := "If(Empty( R8_TIPOAFA ), R8_TIPO, NGSeek( 'RCM' , R8_TIPOAFA , 1 , 'RCM_CODSEF' ) )"

dbSelectArea("SR8")
dbSetOrder(1)
dbSeek(_cFilMat+_cMatFun+DtoS(_dAcidente),.t.)
While !eof() .and. SR8->R8_FILIAL+SR8->R8_MAT == _cFilMat+_cMatFun .and. SR8->R8_DATAINI >= _dAcidente .and. SR8->R8_DATAINI <= _dAcidente+3
	If Substr(SR8->( &cTipoAfas ) , 1 , 1 ) == "O" //Se for Acidente
		dTemp := If( Empty( SR8->R8_DATAFIM ) , dDataBase , SR8->R8_DATAFIM )
		nRet := ( dTemp - SR8->R8_DATAINI ) + 1
		Exit
	Endif
	dbSkip()
End

Return nRet
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDT869FILT³ Autor ³ Rodrigo Soledade		  ³ Data ³21/06/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Filtro Avançado de Centro de Custo 							     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR869                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT869FILT()

Local oDlg, nOpca1:= 2
Local nTamCTT := If(TAMSX3("CTT_CUSTO")[1] <= 0 ,9,TAMSX3("CTT_CUSTO")[1])
Local nTamFIL := If(TAMSX3("CTT_FILIAL")[1] <= 0 ,8,TAMSX3("CTT_FILIAL")[1])
Local oTempTRB
Private cAliasCTT := GetNextAlias()
Private lINVERTE := .F.,cMARCA:= getMark()

dbSelectArea("CTT")
aDBF := {}
AADD(aDBF,{ "CTT_OK"     , "C" ,02, 0 })
AADD(aDBF,{"CTT_MARK", "C", 02, 0})
AADD(aDBF,{ "CTT_FILIAL" , "C" ,nTamFIL, 0 })
AADD(aDBF,{ "CTT_CUSTO" , "C" ,nTamCTT, 0 })
AADD(aDBF,{ "CTT_DESC01" , "C" ,40, 0 })

aTRB1 := {}
AADD(aTRB1,{ "CTT_OK"    ,NIL," ",})
AADD(aTRB1,{ "CTT_FILIAL",NIL,"Filial",})
AADD(aTRB1,{ "CTT_CUSTO",NIL,"C. Custo",})
AADD(aTRB1,{ "CTT_DESC01",NIL,"Decrição",})

oTempTRB := FWTemporaryTable():New( cAliasCTT, aDBF )
oTempTRB:AddIndex( "1", {"CTT_FILIAL","CTT_CUSTO"} )
oTempTRB:AddIndex( "2", {"CTT_MARK","CTT_CUSTO"} )
oTempTRB:Create()

dbSelectArea("CTT")
dbSetOrder(1)
dbGoTop()
While !Eof()
	If &( cCodFil ) >= Mv_par06 .And. &( cCodFil ) <= Mv_par07
		dbSelectArea(cAliasCTT)
		(cAliasCTT)->(DbAppend())
		(cAliasCTT)->CTT_OK := Space(2)
		(cAliasCTT)->CTT_MARK := "ZZ"
		(cAliasCTT)->CTT_FILIAL := &( cCodFil )
		(cAliasCTT)->CTT_CUSTO := &( cCodCC )
		(cAliasCTT)->CTT_DESC01 := &( cDescCC )
	Endif
	dbSelectArea("CTT")
	dbSkip()
End
dbSelectArea(cAliasCTT)
dbGoTop()
DEFINE MSDIALOG oDlg TITLE OemToAnsi(STR0060) From 120,0 To 484,702 OF oMainWnd PIXEL

oMARK1 := MsSelect():NEW(cAliasCTT,"CTT_OK",,aTRB1,@lINVERTE,@cMARCA)
oMARK1:oBROWSE:ALIGN := CONTROL_ALIGN_ALLCLIENT
oMARK1:bMARK := {|| U_MDTA869INV(,.F.,oMARK1)}
oMARK1:oBROWSE:bALLMARK := {|| U_MDTA869INV(cMarca, .T.,oMARK1)}
ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpca1 := 1,oDlg:End()},{|| nOpca1 := 2,oDlg:End()}) CENTERED
If nOpca1 == 1
	dbSelectArea(cAliasCTT)
	dbSetOrder(2)
	dbGoTop()
	While !Eof() .AND. !Empty((cAliasCTT)->CTT_OK)
		AADD(aCCusto,{(cAliasCTT)->CTT_FILIAL,(cAliasCTT)->CTT_CUSTO})
		dbSkip()
	End
EndIf

oTempTRB:Delete()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTA869INV³ Autor ³ Rodrigo Soledade		  ³ Data ³22/06/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao que cria no campo CTT_MARK o espelho do campo CTT_OK³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR869                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTA869INV(cMARK, ALL, oMARK1)
	Local aArea := GetArea()
	(cAliasCTT)->CTT_MARK := IF(!Empty((cAliasCTT)->CTT_OK),Space(2),"ZZ")

	If ALL
		Dbselectarea((cAliasCTT))
		Dbgotop()
		While !eof()
			If Empty((cAliasCTT)->CTT_OK)
				(cAliasCTT)->CTT_OK := cMARCA
				(cAliasCTT)->CTT_MARK := Space(2)
			Else
				(cAliasCTT)->CTT_OK := Space(2)
				(cAliasCTT)->CTT_MARK := "ZZ"
			EndIf
			Dbskip()
		End
		oMARK1:oBROWSE:REFRESH(.T.)
	EndIf
	RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT869FLVL  ³ Autor ³ Rodrigo Soledade³ Data ³ 28/06/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os campos De/Ate Filial                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT869FLVL(nTipo)
Local lRet := .T.
Local cArea := Alias()
Local aArea := SM0->(GetArea())

If nTipo == 1
	If !Empty(Mv_par06)
		dbSelectArea("SM0")
		If !dbSeek(cEmpAnt+Mv_par06)
			Help(" ",1,"REGNOIS")
			lRet := .F.
		Endif
		If Mv_par06 > Mv_par07
			Mv_par07 := Mv_par06
		Endif
	Endif
Else
	If Mv_par07 <> Replicate("Z",Len(Mv_par07)) .and. Mv_par07 <> Replicate("9",Len(Mv_par07))
		If Mv_par06 > Mv_par07
			Help(" ",1,"DEATEINVAL")
			lRet := .F.
		Else
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par07)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
		Endif
	Endif
Endif

RestArea(aArea)
dbSelectArea(cArea)

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} fBuscaHist
Função que realiza a busca das filiais no historico do funcionario

@return Array - Contem as filiais no formato { 'EMPRESA' , 'FILIAL' , 'NOME' , dDataInicio , dDataFim }

@sample
fBuscaHist()

@author Jackson Machado
@since 13/02/2013
/*/
//---------------------------------------------------------------------
Static Function fBuscaHist( cAno )

	Local nTamFil	:= TAMSX3( "RA_FILIAL" )[ 1 ]
	Local cCondCus	:= Space( Len( SRA->RA_CC ) ) //Condicao de validacao da troca de centro de custo
	Local cCondALL	:= Space( 10 ) //Condicao principal da pesquisa
	Local cKeyEmp	:= cEmpAnt //Chave Empresa
	Local cKeyFil	:= SRA->RA_FILIAL //Chave Filial
	Local cKeyMat	:= SRA->RA_MAT //Chave Matricula
	Local cKeyCus	:= SRA->RA_CC //Chave Centro Custo
	Local dDtFimF	:= If( Empty( SRA->RA_DEMISSA ) , StoD( cAno + "1231" ) , SRA->RA_DEMISSA ) //Data de controle das saídas
	Local dDtEntr	:= SToD( Space( 8 ) ) //Data de Controle das entradas
	Local dINITMP	:= SRA->RA_ADMISSA //Data Admissao
	Local lPrimeiro	:= .T. //Indica se eh primeiro registro computado
	Local lEncerra	:= .F. // Verifica se acabou o historico de setores
	Local aFiliais 	:= {} //Filiais do Funcionario - Nesta funcao o RECNO eh incluida no Array para possivel reordenacao
	Local aArea		:= GetArea()//Salva a area de trabalho atual

	If Year( dINITMP ) < Val( cAno )
		dINITMP := StoD( cAno + "0101" )
	EndIf

	While !lEncerra
		//Reseta variaveis para iniciar a verificacao a cada passagem e reducao de datas
		lPrimeiro 	:= .T.
		dDtEntr		:= SToD( Space( 8 ) )
		cCondCus  	:= cKeyCus
		cCondALL  	:= cKeyEmp + PadR( cKeyFil , Len( SRE->RE_FILIALD ) ) + cKeyMat
		Dbselectarea( "SRE" )
		Dbsetorder( 2 )//RE_EMPP + RE_FILIALP + RE_MATP
		Dbseek( cCondALL )//EMPRESA + FILIAL + MATRICULA
		While !eof() .and. cCondALL == SRE->RE_EMPP + SRE->RE_FILIALP + SRE->RE_MATP

				//Caso for transferido para mesma empresa, filial, matricula e C.C. desconsidera o registro
				If SRE->RE_EMPP == SRE->RE_EMPD .And. SRE->RE_FILIALP == SRE->RE_FILIALD .And. ;
					SRE->RE_MATP == SRE->RE_MATD .And. SRE->RE_CCP == SRE->RE_CCD
					Dbselectarea( "SRE" )
					Dbskip()
					Loop
				Endif

	            // Verifica se data eh superior a data fim ou inferior a data inicial, caso seja desconsidera
				If SRE->RE_DATA >= dDtFimF .Or. SRE->RE_DATA < dINITMP
					Dbselectarea( "SRE" )
					Dbskip()
					Loop
				Endif

				//Caso seja centro de custo diferente da chave, desconsidera
				If SRE->RE_CCP != cCondCus
					Dbselectarea( "SRE" )
					Dbskip()
					Loop
				Endif

				//Caso for primeira registro da chave, adiciona no array e salva novos valores para a chave
				If lPrimeiro
					cKeyEmp := SRE->RE_EMPD
					cKeyFil := SubStr( SRE->RE_FILIALD , 1 , nTamFil )
					cKeyMat := SRE->RE_MATD
					cKeyCus := SRE->RE_CCD
					dDtEntr := SRE->RE_DATA
					aADD( aFiliais , { 	SRE->RE_EMPP , ;//Empresa
										SubStr( SRE->RE_FILIALP , 1 , nTamFil ) , ; //Filial
										FWFilialName( SRE->RE_EMPP , SRE->RE_FILIALP , 2 ) , ; //Nome completo
										dDtEntr + 1 , ; //Data de entrada
										dDtFimF , ; //Data de Saída
										SRE->RE_MATP ,;//Matricula
										SRE->RE_CCP } ) //Centro de Custo
				Else
					// Caso seja segundo registro da chave, verifica se a data salva eh superior a atual
					// caso seja, adiciona a data de entrada a data atual
					If SRE->RE_DATA < aFiliais[ Len( aFiliais ) ][ 4 ]
						cKeyEmp := SRE->RE_EMPD
						cKeyFil := SubStr( SRE->RE_FILIALD , 1 , nTamFil )
						cKeyMat := SRE->RE_MATD
						cKeyCus := SRE->RE_CCD
						dDtEntr := SRE->RE_DATA
						aFiliais[ Len( aFiliais ) ][ _nDTENTR_ ] := SRE->RE_DATA + 1
					Endif
				Endif

				lPrimeiro := .F.//Identifica que jah fez a primeira verificacao

				Dbselectarea("SRE")
				Dbskip()
		End
		If lPrimeiro
			// Caso seja primeira verifica encerra o processo, indica que acho um registro e computa o ultimo registro da SRE
			// desde que a data de inicio seja menor que a ultima data fim
			lEncerra   := .T.
			If dINITMP <= dDtFimF
				aADD(aFiliais,{ 	cKeyEmp , ; //Empresa
									cKeyFil , ; //Filial
									FWFilialName( cKeyEmp , PadR( cKeyFil , Len( SRE->RE_FILIALD ) ) , 2 ) , ; //Nome completo
									dINITMP , ; //Data de entrada
									dDtFimF , ; //Data de Saída
									cKeyMat , ; //Matricula
									cKeyCus } ) //Centro de Custo
			Endif
		Else
			//Caso jah tenha computado o registro, salva a data fim como sendo a ultima data de entrada e continua verificando
			dDtFimF := dDtEntr
	    Endif
	End

	//Retornar a area salva
	RestArea( aArea )

Return aFiliais
