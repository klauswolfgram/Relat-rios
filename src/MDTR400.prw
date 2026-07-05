/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr400.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR400
Relatório da Ficha Médica e todo seu prontuario.
O usuario selecionar o numero da ficha, e para cada ficha
escolher as informações que deseja listar, bem como o periodo
desejado. Obtendo um histórico completo da saúde do paciente.
Podera selecionar: Programas de saúde, exames, medicamentos,
diagnósticos, restrições e os questionários.

Uso Genérico

@param cFicha, caracter, apresenta a ficha médica
@sample U_MDTR400( "000000002" )

@author Jean Pytter da Costa
@since 26/08/2014
/*/
//---------------------------------------------------------------------
User Function MDTR400( cFicha )


//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
Local aNGBEGINPRM := NGBEGINPRM()

Local wnrel	  := "MDTR400"
Local limite  := 132
Local cDesc1  := STR0001 //"Ficha medica com prontuario medico."
Local cDesc2  := STR0002 //"Atraves dos parametros o usuario podera selecionar: Periodo Desejado"
Local cDesc3  := STR0003 //"programas de saude, exames, medicamentos, diagnosticos restricoes e questionario"
Local cString := "TM0"

lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
//lSigaMdtPS := IIf( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

Private nomeprog := "MDTR400"
Private tamanho	 := "M"
Private aReturn	 := { STR0004, 1, STR0005, 2, 2, 1, "", 1 } //"Zebrado"###"Administracao"
Private titulo	 := STR0006 //"Ficha Medica e Prontuario "
Private ntipo	 := 0
Private nLastKey := 0
Private cPerg	 := IIf( !lSigaMDTPS, "MDT400    ", "MDT400PS  " )
Private cabec1	 := " "
Private cabec2	 := " "

If !MDTRESTRI(cPrograma)
	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )
	Return .F.
Endif
/*
//--------------------------------------------
	// PERGUNTAS PADRÃO
	+-----------------------------+
	| 01  De  Ficha ?             |
	| 02  Ate Ficha ?             |
	| 03  De  Periodo ?           |
	| 04  Ate Periodo ?           |
	| 05  Programas de Saude ?    |
	| 06  Exames Realizados ?     |
	| 07  Restricoes ?            |
	| 08  Doencas ?               |
	| 09  Diagnosticos ?          |
	| 10  Tipo Atendimento ?      |
	| 11  Resultado de Exame ?    |
	| 12  Detalhes Diagnosticos ? |
	| 13  Modelo Impressao ?      |
	| 14  No. de Vias ?           |
	| 15  Imprimir Vacinas ?      |
	| 16  Atend. Enfermagem ?     |
	| 17  Imp. Med. do Diagnos. ? |
	+-----------------------------+
	//PERGUNTAS PRESTADOR
	+-----------------------------+
	| 01  De Cliente ?            |
	| 02  Loja                    |
	| 03  Até Cliente ?           |
	| 04  Loja                    |
	| 05  De  Ficha ?             |
	| 06  Ate Ficha ?             |
	| 07  De  Periodo ?           |
	| 08  Ate Periodo ?           |
	| 09  Programas de Saude ?    |
	| 10  Exames Realizados ?     |
	| 11  Restricoes ?            |
	| 12  Doencas ?               |
	| 13  Diagnosticos ?          |
	| 14  Tipo Atendimento ?      |
	| 15  Resultado de Exame ?    |
	| 16  Detalhes Diagnosticos ? |
	| 17  Modelo Impressao ?      |
	| 18  No. de Vias ?           |
	| 19  Imprimir Vacinas ?      |
	+-----------------------------+
//-----------------------------------------------------
*/

//Verifica as perguntas selecionadas
pergunte( cPerg, .F. )

If ValType( cFicha ) == "C" .And. !lSigaMdtps
	dbSelectArea( "TM0" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TM0" ) + cFicha )

		mv_par01 := cFicha
		mv_par02 := cFicha
		mv_par03 := Stod( "" )
		mv_par04 := dDataBase
		mv_par05 := 1
		mv_par06 := 1
		mv_par07 := 1
		mv_par08 := 1
		mv_par09 := 1
		mv_par10 := 1
		mv_par11 := 1
		mv_par12 := 1
		mv_par13 := 2
		mv_par14 := 1
		mv_par15 := 1
		mv_par16 := 1
		mv_par17 := 1

		cPerg := Nil
		cDesc2 := ""
		cDesc3 := ""
	EndIf
EndIf

//Envia controle para a funcao SETPRINT
wnrel := "MDTR400"
wnrel := SetPrint( cString, wnrel, cPerg, titulo, cDesc1, cDesc2, cDesc3, .F., "" )

If nLastKey == 27
	Set Filter to
	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )
	Return
Endif

SetDefault( aReturn, cString )

If nLastKey == 27
	Set Filter to
	//Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM( aNGBEGINPRM )
	Return
Endif

Private nVias := IIf( lSigaMdtps, mv_par18, mv_par17 )
//Private nVias := If(lSigaMdtps,mv_par18,mv_par14)

If lSigaMdtps
	If mv_par17 == 1
		RptStatus( {|lEnd| R400Imp( @lEnd, wnRel, titulo, tamanho )}, titulo )
	Else
		Processa( {|lEnd| GRAF400imp()} ) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
	Endif
Else
	If mv_par13 == 1
		RptStatus( {|lEnd| R400Imp( @lEnd, wnRel, titulo, tamanho )}, titulo )
	Else
		Processa( {|lEnd| GRAF400imp()} ) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
	Endif
Endif

//Devolve variaveis armazenadas (NGRIGHTCLICK)
NGRETURNPRM( aNGBEGINPRM )

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} R400Imp
Chamada do Relatório

@type Static Function

@author  Inacio Luiz Kolling
@since   06/1997

@sample  R400Imp( @lEnd, 'MDTR400', 'Relatório', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Programa utilizado
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório

@return  Nil, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function R400Imp( lEnd, wnRel, titulo, tamanho )

	Local aArea := TM0->(GetArea())
	Local LinhaCorrente
	Local nCont
	Local nSizeFil := 0

	//Variaveis para controle do cursor de progressao do relatorio
	Local lContinua := .T.
	Local lPrint    := .F.
	Local cCliente  := ""
	Local cLinhasMemo
	Local cLinMemo0
	Local cLinMemo1
	Local cLinMemo2
	Local cLinMemo
	Local nLinhaCorrente
	Local nLinhasMemo
	Local nLinMemo
	Local nLinMemo0 := 0
	Local nLinMemo1 := 0
	Local nLinMemo2 := 0
	Local nConty    := 17
	Local nContLin //Variavel para tamanho da linha

	//Variaveis Memo
	Local cDiagno
	Local cDesAte
	Local cQueixa
	Local cLinhasMot := ""
	Local nLinMot    := 0
	Local cLinhasMed := ""
	Local nLinMed    := 0
	Local nContImp   := 0
	Local lAtend     := .F.
	Local lAtend2    := .F.
	Local nLinBck    := 1
	Local lImpSYP	 := .T.

	//Contadores de linha e pagina
	Private li := 80, flag := .F., m_pag := 1

	//Verifica se deve comprimir ou não
	nTipo := IIF( aReturn[4] == 1, 15, 18 )

	If cReleaseRPO >= '12.1.2410'
		lImpSYP := .F.
	EndIf
	//Monta os Cabecalhos

	/*/

	//           " Ficha    Matricula  Nome do Funcionario           Progamacao   Emissao     Cancel.   Parecer   Natureza  "
	//           "  "
			//           1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

			Ficha Medica.: xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Implant...: xx/xx/xx
	F         Matricula....: xx - xxxxxx                                Nascimento: xx/xx/xx
	D         Matricula....: xx - xxxxxx Dep.: xx xxxxxxxxxxxxxxxxxxxxx Nascimento: xx/xx/xx
	C         Candidato....: xxxxxx                                     Nascimento: xx/xx/xx
			Sexo.........: xxxxxxxx                                   Sangue....: xx x
			Doador.......: xxx                                        Ul.Doacao.: xx/xx/xx
			Peso.........: xxx.x                                      Altura....: x.xx
			Fumante......: xxx                                        Cig/Dia...: xxx
			Qt Tempo Fuma: xxx Anos                                   Ficha.Ant.: xxxxxxxxxxxx
			Antecedentes.: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
							xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
							xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
							xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
							xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


			//           1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			Programas de Saude    xxx                                  Inicio       Termino
			Diagnosticos                                              Realiz.    Termino
			xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xx/xx/xx      xx/xx/xx
			xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xx/xx/xx      xx/xx/xx
			xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xx/xx/xx      xx/xx/xx

			Exames Realizados                      Realiz.   Termino   Cod. Resultado  Descrição             Ind. Res.        Natureza

			xxxxxxxxx - XXXXXXXXXXXXXXXXXXXXXXXXX  xx/xx/xx  xx/xx/xx  XXXXXXXXXX      XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXX

			// 0         1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			Diagnosticos                     Realiz.     Termino     Ind. Atend.         Diagnóstico        Atend. Médico      Queixa Principal
			XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXX    XXXXXXXX    XXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXX


			// 0         1         2         3         4         5         6         7         8         9         0         1         2         3
			// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
			"Vacinas Aplicadas                       Data           Dose"
			XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX          XX/XX/XXXX     XX
			XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX          XX/XX/XXXX     XX
	/*/

	dbSelectArea( "TM0" )
	dbSetOrder( 01 )      // NUMERO DA FICHA MEDICA
	dbSeek( xFilial( "TM0" ) + mv_par01, .T. )

	SetRegua( LastRec() )

	//-------------------------------------------------------------------
	/*/
	Correr TM0 para ler as  Fichas Medicas
	Para cada ficha obter
		TMN - Programas de Saude
		TM5 - Exames do Funcionario
		TMF - Restricoes
		TNA - Doencas
		TNT - Diagnosticos Medicos
	/*/
	//-------------------------------------------------------------------
	While lContinua .And. !Eof() .And.;
	      TM0->TM0_FILIAL == xFIlial('TM0') .And.;
	      TM0->TM0_NUMFIC <= mv_par02

	    IncRegua()

		For nCont := 1 to nVias
			//Imprime dados da ficha medica
		    If li <> 6
		       Somalinha()
		    Endif

		    //Imprime dados da ficha medica
		    lPrint := .t.
		    @ Li,000 PSay STR0008 //"Ficha Medica.: "
		    @ Li,016 PSay TM0->TM0_NUMFIC Picture "999999999"
		    @ Li,025 PSay "-"
		    @ Li,027 PSay TM0->TM0_NOMFIC
		    @ Li,075 PSay STR0009 //"Implant...: "
		    @ Li,087 PSay TM0->TM0_DTIMPL Picture "99/99/99"
		    SomaLinha()
		    If !Empty(TM0->TM0_MAT)
		    	nSizeFil := FwSizeFilial()-2
		        @ Li,000 PSay STR0010 //"Matricula....: "
		        @ Li,016 PSay TM0->TM0_FILFUN
		        @ Li,018+nSizeFil PSay "-"
		        @ Li,020+nSizeFil PSay TM0->TM0_MAT

		        If !Empty(TM0->TM0_NUMDEP)
		            @ Li,027+nSizeFil PSay STR0011 //"Dep.: "
		            @ Li,033+nSizeFil PSay TM0->TM0_NUMDEP
		            dbSelectArea("SRA")
		            dbSetOrder(01)
		            dbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT,.F.)
		            @ Li,036+nSizeFil PSay SRA->RA_NOME
		        EndIf

		    Else
		        @ Li,000 PSay STR0012 //"Candidato....: "
		        @ Li,016 PSay TM0->TM0_CANDID
		    EndIf
			@ Li,075 PSay STR0013 //"Nascimento: "
			@ Li,087 PSay TM0->TM0_DTNASC Picture "99/99/99"
			SomaLinha()
			@ Li,000 PSay STR0014 //"Sexo.........: "
			@ Li,016 PSay AllTrim(NGRETSX3BOX( "TM0_SEXO", TM0->TM0_SEXO ))
			@ Li,075 PSay STR0017 //"Sangue....: "
			@ Li,087 PSay  AllTrim(NGRETSX3BOX( "TM0_SANGUE", TM0->TM0_SANGUE ))
			@ Li,091 PSay AllTrim(NGRETSX3BOX( "TM0_FATORH", TM0->TM0_FATORH ))
			SomaLinha()
			@ Li,000 PSay STR0018 //"Doador.......: "
			@ Li,016 PSay AllTrim(NGRETSX3BOX( "TM0_DOADOR", TM0->TM0_DOADOR ))
			@ Li,075 PSay STR0021 //"Ul.Doacao.: "
			@ Li,087 PSay TM0->TM0_DTDOAC Picture "99/99/99"
			SomaLinha()
			@ Li,000 PSay STR0022 //"Peso.........: "
			@ Li,016 PSay TM0->TM0_PESO Picture "999.9"
			@ Li,075 PSay STR0023 //"Altura....: "
			@ Li,087 PSay TM0->TM0_ALTURA Picture "9.99"
			SomaLinha()
			@ Li,000 PSay STR0024 //"Fumante......: "
			@ Li,016 PSay AllTrim(NGRETSX3BOX( "TM0_FUMA", TM0->TM0_FUMA ))
			@ Li,075 PSay STR0025 //"Cig/Dia...: "
			@ Li,087 PSay TM0->TM0_QTCIG Picture "999"
			SomaLinha()
			@ Li,000 PSay STR0026 //"Qt Tempo Fuma: "
			@ Li,016 PSay TM0->TM0_QTTEMP Picture "999"
			@ Li,019 PSay STR0027 //"Anos"
			@ Li,075 PSay STR0028 //"Ficha.Ant.: "
			@ Li,087 PSay TM0->TM0_FICANT
			SomaLinha()
			@ Li,000 PSay STR0085 //"Endereço:"
			@ Li,016 PSay NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_ENDEREC')
			@ Li,075 PSay STR0086 //"Bairro:"
			@ Li,087 PSay NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_BAIRRO')
			SomaLinha()
			@ Li,000 PSay STR0087 + " " + NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_COMPLEM') //"Complemento do Endereço:"
			SomaLinha()
			lPrimeiro := .T.
			nLinhasMemo := MLCOUNT(TM0->TM0_DESCRI,66)
			For LinhaCorrente := 1 to nLinhasMemo
				if !empty( (MemoLine(TM0->TM0_DESCRI,66,LinhaCorrente)))
		            If lPrimeiro
		                @ Li,000 PSay STR0029 //"Antecedentes.: "
		                lPrimeiro := .F.
		            EndIf
		            @ Li,016 PSay (MemoLine(TM0->TM0_DESCRI,66,LinhaCorrente))
		            SomaLinha()
		        endif
		        Loop
		    Next

		    If mv_par05 == 1       // Relacionar programas de saude
		        dbSelectArea( "TMN" )
		        dbSetOrder( 02 )      // NUMERO DA FICHA MEDICA + CODIGO DO PROGRAMA
		        dbSeek( xFilial( "TMN" ) + TM0->TM0_NUMFIC, .F. )

				lPrimeiro := .T.

		        While !Eof() .And. TMN->TMN_NUMFIC == TM0->TM0_NUMFIC

				    If TMN->TMN_DTINIC < mv_par03 .Or. TMN->TMN_DTINIC > mv_par04
		                dbskip()
		                loop
		            EndIf

				    If lPrimeiro

					    If li <> 6
		                   SomaLinha()
		                Endif

					    @ Li,000 PSay STR0030 //"Programas de Saude                                         Inicio       Termino "
		                SomaLinha()

						If li <> 6
		                   SomaLinha()
		                Endif

					    lPrimeiro := .F.

				    EndIf

		            @ Li,000 PSay TMN->TMN_CODPRO
		            @ Li,010 PSay "-"

		            DbSelectArea( "TMO" )
		            DbSetOrder( 01 )
		            DbSeek( xfilial( "TMO" ) + TMN->TMN_CODPRO )

		            @ Li,012 PSay TMO->TMO_NOMPRO
		            @ Li,058 PSay TMN->TMN_DTINIC Picture "99/99/99"
		            @ Li,069 PSay TMN->TMN_DTTERM Picture "99/99/99"
		            SomaLinha()
		            DbSelectArea( "TMN" )
		            dbskip()
		            loop

		        Enddo
		    EndIf

			If mv_par06 == 1 // Relacionar exames realizados

				dbSelectArea( "TM5" )
				dbSetOrder( 01 )
				dbSeek( xFilial( "TM5" ) + TM0->TM0_NUMFIC, .F. )

				lPrimeiro := .T.

				While !Eof() .And. TM0->TM0_NUMFIC == TM5->TM5_NUMFIC

					//Se o parâmetro for igual a assistencial e o exame for diferente de assistencial ele passa para o próximo registro
					If mv_par10 == 2 .And. TM5->TM5_ORIGEX <> '1'
						DbSkip()
						Loop
					EndIf

					//Se o parametro for igual a ocupacional e o exame for diferente de ocupacional ele passa para o proximo registro
					If mv_par10 == 3 .And. TM5->TM5_ORIGEX <> '2'
						DbSkip()
						Loop
					EndIf

					If TM5->TM5_DTPROG < mv_par03 .Or. TM5->TM5_DTPROG > mv_par04
						dbskip()
						loop
					EndIf

					If Empty( TM5->TM5_DTRESU )
						dbskip()
						loop
					EndIf

					If lPrimeiro

						If li <> 6
							SomaLinha()
						EndIf

						IF mv_par11 == 1
							@ Li,000 PSay STR0035 //"Exames Realizados                      Realiz.    Termino    Cod. Resultado  Descrição             Ind. Res.        Natureza"
							SomaLinha()
						Else
							@ Li,000 PSay STR0036 //"Exames Realizados                                         Realiz.    Termino"
							SomaLinha()
						EndIf

						If li <> 6
							SomaLinha()
						Endif

						lPrimeiro := .F.

					EndIf

					@ Li,000 PSay TM5->TM5_EXAME
					@ Li,010 PSay "-"
					DbSelectArea( "TM4" )
					DbSetOrder( 01 )
					DbSeek( xfilial( "TM4" ) + TM5->TM5_EXAME )

					nLinMemo0 := MLCOUNT( Alltrim( TM4->TM4_NOMEXA ), nConty )//Conta a quantidade de linhas que serão necessarias
    				cLinMemo0 := Alltrim( TM4->TM4_NOMEXA )//Recebe o valor do campo

    				If mv_par11 == 1

    					DbSelectArea( "TMU" )
		            	DbSetOrder( 1 )

		            	If DbSeek( xFilial( "TMU" ) + TM5->TM5_CODRES )
    						nLinMemo1 := MLCOUNT( Alltrim( TMU->TMU_RESULT ), nConty )//Conta a quantidade de linhas que serão necessarias
    						cLinMemo1 := Alltrim( TMU->TMU_RESULT )//Recebe o valor do campo
    					Else  //Se não encontrar, vai receber 0 e vazio, para não ficar repetindo valores da encontrada anteriormente.
    						nLinMemo1 := 0
    						cLinMemo1 := " "
    					EndIf

    				EndIf

	    			aMaxLin := { nLinMemo0, nLinMemo1 }
		    		aSort( aMaxLin, , , { | x , y |  x > y } )
		    		nLinhasMemo := aMaxLin[1]

					For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas

						If !Empty( MemoLine( cLinMemo0, nConty, nLinhaCorrente ) )
							@Li, 013 Psay MemoLine( cLinMemo0, nConty, nLinhaCorrente ) //Quebra a linha quando chegar no valor de nConty em caracteres

							If mv_par11 == 1
								@Li, 077 Psay MemoLine( cLinMemo1, nConty, nLinhaCorrente ) //Quebra a linha quando chegar no valor de nConty em caracteres
							EndIf

						ElseiF !Empty( MemoLine( cLinMemo1, nConty, nLinhaCorrente ) )

							If mv_par11 == 1
								@Li, 077 Psay MemoLine( cLinMemo1, nConty, nLinhaCorrente ) //Quebra a linha quando chegar no valor de nConty em caracteres
							EndIf

				  	 	EndIf

				  	 	If nLinhaCorrente == 1 .And. mv_par11 == 1
				  	 		@ Li,040 PSay TM5->TM5_DTPROG Picture "99/99/99"
							@ Li,051 PSay TM5->TM5_DTRESU Picture "99/99/99"
				  	 		@ Li,062 PSay TMU->TMU_CODRES
							@ Li,100 PSay AllTrim(NGRETSX3BOX( "TM5_INDRES", TM5->TM5_INDRES ))
							@ Li,117 PSay AllTrim(NGRETSX3BOX( "TM5_NATEXA", TM5->TM5_NATEXA ))

						ElseIf nLinhaCorrente == 1 .And. mv_par11 == 2
							@ Li,058 PSay TM5->TM5_DTPROG Picture "99/99/99"
							@ Li,069 PSay TM5->TM5_DTRESU Picture "99/99/99"

						EndIf

				  	 	If nLinhaCorrente <> nLinhasMemo
					   		Somalinha()
						EndIf

		  			Next

					SomaLinha()
					DbSelectArea( "TM5" )
					dbskip()
					loop

		        Enddo

		    EndIf

		    If mv_par07 == 1 // Relacionar restricoes
		        dbSelectArea( "TMF" )
		        dbSetOrder( 01 )
		        dbSeek( xFilial( "TMF" ) + TM0->TM0_NUMFIC, .F. )

		        lPrimeiro := .T.

		        While !Eof() .And. TM0->TM0_NUMFIC == TMF->TMF_NUMFIC

				 	If TMF->TMF_DTINIC < mv_par03   .Or.;
		               TMF->TMF_DTINIC > mv_par04
		                dbskip()
		                loop
		            EndIf

				    If lPrimeiro
		                If li <> 6
		                   SomaLinha()
		                Endif

		                @ Li,000 PSay STR0032 //"Restricoes                                            Realiz. Termino"
		                SomaLinha()

		                If li <> 6
		                   SomaLinha()
		                Endif

		                lPrimeiro := .F.

		            EndIf

		            @ Li,000 PSay TMF->TMF_RESTRI
		            @ Li,010 PSay "-"
		            DbSelectArea( "TME" )
		            DbSetOrder( 01 )
		            DbSeek( xfilial( "TME" ) + TMF->TMF_RESTRI )

		            @ Li,012 PSay TME->TME_NOMRES
		            @ Li,058 PSay TMF->TMF_DTINIC Picture "99/99/99"
		            @ Li,069 PSay TMF->TMF_DTFIM  Picture "99/99/99"

		            SomaLinha()
		            DbSelectArea("TMF")
		            dbskip()
		            loop

		        EndDo

		    EndIf

		    If mv_par08 == 1 // Relacionar doencas
		        dbSelectArea( "TNA" )
		        dbSetOrder( 01 )
		        dbSeek( xFilial( "TNA" ) + TM0->TM0_NUMFIC, .F. )

				lPrimeiro := .T.
		        nContLin  := 40

				While !Eof() .And. TM0->TM0_NUMFIC == TNA->TNA_NUMFIC

					If TNA->TNA_DTINIC  < mv_par03  .Or.;
		               TNA->TNA_DTINIC  > mv_par04
		                dbskip()
		                loop
		            EndIf

					If lPrimeiro

						If li <> 6
		                   SomaLinha()
		                Endif

					    @ Li,000 PSay STR0033 //"Doencas                                               Realiz. Termino"
		                SomaLinha()

					    If li <> 6
		                   SomaLinha()
		                Endif

					    lPrimeiro := .F.

					EndIf

					@ Li,000 PSay TNA->TNA_CID
		            @ Li,010 PSay "-"
		            DbSelectArea( "TMR" )
		            DbSetOrder( 01 )
		            DbSeek( xfilial( "TMR" ) + TNA->TNA_CID )

					nLinhasMemo := MLCOUNT( Alltrim( TMR->TMR_DOENCA ), nContLin )//Conta a quantidade de linhas que serão necessarias
					cLinhasMemo := Alltrim( TMR->TMR_DOENCA )//Recebe o valor do campo

					For nLinhaCorrente := 1 To nLinhasMemo 	 // Imprime ate o total maximo de linhas

						If !Empty(MemoLine( cLinhasMemo, nContLin, nLinhaCorrente ) )
							@Li, 012 Psay MemoLine(cLinhasMemo,nContLin,nLinhaCorrente) //Quabra a linha quando chegar no valor de nConty em caracteres
						EndIf

						If nLinhaCorrente == 1
							@ Li,058 PSay TNA->TNA_DTINIC Picture "99/99/99"
		            		@ Li,069 PSay TNA->TNA_DTFIM  Picture "99/99/99"
		            	EndIf

						If nLinhaCorrente <> nLinhasMemo
							Somalinha()
						EndIf
					Next

					SomaLinha()
					DbSelectArea("TNA")
					dbskip()
					loop

		        Enddo

		    EndIf

		    If mv_par09 == 1 // Relacionar Diagnosticos
		        dbSelectArea( "TMT" )
		        dbSetOrder( 01 )
		        dbSeek( xFilial( "TMT" ) + TM0->TM0_NUMFIC, .F. )

		        lPrimeiro := .T.

				While !Eof() .And. TM0->TM0_NUMFIC == TMT->TMT_NUMFIC .And. xFilial( "TMT" ) == TMT->TMT_FILIAL
		   			//Se o parametro for igual a assistencial e o exame for diferente de assistencial ele passa para o proximo registro
		            If mv_par10 = 2 .And. ( TMT->TMT_OCORRE <> '1' .And. TMT->TMT_OCORRE <> '5' )
		                DbSkip()
		                Loop
		            Endif

					//Se o parametro for igual a ocupacional e o exame for diferente de ocupacional ele passa para o proximo registro
		            If mv_par10 = 3 .And. ( TMT->TMT_OCORRE == '1' .Or. TMT->TMT_OCORRE == '5' )
		                DbSkip()
		                Loop
		            Endif

		            If TMT->TMT_DTCONS < mv_par03 .Or. TMT->TMT_DTCONS > mv_par04
		                dbskip()
		                loop
		            EndIf

		            If TMT->TMT_DTATEN < mv_par03 .Or. TMT->TMT_DTATEN > mv_par04
		                dbskip()
		                loop
		            EndIf

					If mv_par12 == 1
						DbSelectArea( "TMR" )
						DbSetOrder( 01 )
						If DbSeek( xfilial( "TMR" ) + TMT->TMT_CID )

						 If lPrimeiro

								If li <> 6
									SomaLinha()
								Endif

								@ Li,000 PSay STR0044 //"Diagnosticos                     Realiz.     Termino     Ind. Atend.         Diagnóstico        Atend. Médico      Queixa Principal"

								If mv_par17 == 1
									SomaLinha(20)
									@ Li,40 PSay STR0126 //"Medicamentos                                              Unidade        Quantidade"
								EndIf

								SomaLinha()

								If li <> 6
									SomaLinha()
								Endif

								lPrimeiro := .F.

							EndIf

							nLinMemo := MLCOUNT(Alltrim(TMR->TMR_DOENCA),nConty )//Conta a quantidade de linhas que serão necessarias
			    			cLinMemo := Alltrim(TMR->TMR_DOENCA)//Recebe o valor do campo

							If lImpSYP
								cDiagno := MsMM( TMT->TMT_DIASYP, 10 )
				    			cDesAte := MsMM( TMT->TMT_DATSYP, 10 )
				    			cQueixa := MsMM( TMT->TMT_QUESYP, 10 )
							Else
				    			cDiagno := TMT->TMT_MDIAGN
				    			cDesAte := TMT->TMT_MDESAT
				    			cQueixa := TMT->TMT_MQUEIX
			    			EndIf

			    			nLinMemo0 := MLCOUNT(Alltrim(cDiagno),nConty )
			    			cLinMemo0 := Alltrim(cDiagno)

			    			nLinMemo1 := MLCOUNT(Alltrim(cDesAte),nConty )
			    			cLinMemo1 := Alltrim(cDesAte)

			    			nLinMemo2 := MLCOUNT(Alltrim(cQueixa),nConty )
			    			cLinMemo2 := Alltrim(cQueixa)

			    			//Faz comparações para verificar qual possui mais linhas
			    			aMaxLin := { nLinMemo, nLinMemo0, nLinMemo1, nLinMemo2 }
			    			aSort( aMaxLin, , , { | x , y |  x > y } )
			    			nLinhasMemo := aMaxLin[1]

			    			For nLinhaCorrente := 1 To nLinhasMemo 	 // Imprime ate o total maximo de linhas

								If !Empty(MemoLine(cLinMemo,nConty,nLinhaCorrente))    //Verifica se tem informações, caso possuir vai imprimindo linha a linha
									@Li, 012 Psay MemoLine(cLinMemo,nConty,nLinhaCorrente)
								EndIf

								If !Empty(MemoLine(cLinMemo0,nConty,nLinhaCorrente))
									@Li, 077 Psay MemoLine(cLinMemo0,nConty,nLinhaCorrente)
								EndIf

								If !Empty(MemoLine(cLinMemo1,nConty,nLinhaCorrente))
									@Li, 096 Psay MemoLine(cLinMemo1,nConty,nLinhaCorrente)
								EndIf

								If !Empty(MemoLine(cLinMemo2,nConty,nLinhaCorrente))
									@Li, 115 Psay MemoLine(cLinMemo2,nConty,nLinhaCorrente)
								EndIf

								If nLinhaCorrente == 1 //Só deve se impresso na primeira linha, caso possua varias linhas
									@ Li,000 PSay TMT->TMT_CID
									@ Li,010 PSay "-"
									@ Li,033 PSay TMT->TMT_DTCONS  Picture "99/99/99"
									@ Li,045 PSay TMT->TMT_DTATEN  Picture "99/99/99"
									@ Li,057 PSay AllTrim(NGRETSX3BOX( "TMT_OCORRE", TMT->TMT_OCORRE ))
								EndIf

								If nLinhaCorrente <> nLinhasMemo
						   			Somalinha()
						  	 	EndIf

				  			Next

							// MEDICAMENTOS
							If mv_par17 == 1
								DbSelectArea( "TM2" )
								dbSetOrder( 1 )//TM2_FILIAL+TM2_NUMFIC+DTOS(TM2_DTCONS)+TM2_HRCONS+TM2_CODMED
								If dbSeek( xFilial( "TM2" ) + TM0->TM0_NUMFIC + DTOS( TMT->TMT_DTCONS ) + TMT->TMT_HRCONS )
					            	SomaLinha()

									While !Eof() .And. xFilial("TM2") == TM2->TM2_FILIAL .And. TM2->TM2_NUMFIC == TM0->TM0_NUMFIC .And.;
										DTOS(TM2->TM2_DTCONS) == DTOS(TMT->TMT_DTCONS) .ANd. TM2->TM2_HRCONS == TMT->TMT_HRCONS

									 	@ Li,041 PSay Alltrim( TM2->TM2_CODMED ) + " - " + Alltrim( NgSeek( "TM1", TM2->TM2_CODMED, 1, "TM1->TM1_NOMEDI" ) )
									 	@ Li,100 PSay Alltrim( NgSeek( "TM1", TM2->TM2_CODMED, 1, "TM1->TM1_UNIDAD" ) )
								 		@ Li,113 PSay cValtochar( TM2->TM2_QTUTIL )
										SomaLinha()
										TM2->( dbSkip() )

									 End

								Endif

							EndIf

			            	SomaLinha()
			            	SomaLinha()

		            	EndIf

		            	DbSelectArea( "TMT" )
		            	dbskip()
		            	loop
					Else
						@ Li,000 PSay TMT->TMT_CID
						@ Li,010 PSay "-"

						DbSelectArea( "TMR" )
						DbSetOrder( 01 )
						If DbSeek( xfilial( "TMR" ) + TMT->TMT_CID )

							 If lPrimeiro

								If li <> 6
									SomaLinha()
								Endif

								@ Li,000 PSay STR0034 //"Diagnosticos                                              Realiz.    Termino"

								If mv_par17 == 1
									SomaLinha(20)
									@ Li,40 PSay STR0126 //"Medicamentos                                              Unidade        Quantidade"
								EndIf

								SomaLinha()

								If li <> 6
									SomaLinha()
								Endif

								lPrimeiro := .F.

							EndIf

							nLinhasMemo := MLCOUNT(Alltrim(TMR->TMR_DOENCA),nContLin )//Conta a quantidade de linhas que serão necessarias
							cLinhasMemo := Alltrim(TMR->TMR_DOENCA)//Recebe o valor do campo

							For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas
								If !Empty(MemoLine(cLinhasMemo,nContLin,nLinhaCorrente))
									@Li, 012 Psay MemoLine(cLinhasMemo,nContLin,nLinhaCorrente) //Quabra a linha quando chegar no valor de nConty em caracteres
								EndIf
								If nLinhaCorrente == 1
									@ Li,058 PSay TMT->TMT_DTCONS  Picture "99/99/99"
									@ Li,069 PSay TMT->TMT_DTATEN  Picture "99/99/99"
				            	EndIf
								If nLinhaCorrente <> nLinhasMemo
									Somalinha()
								EndIf
							Next

							// MEDICAMENTOS
							If mv_par17 == 1
								DbSelectArea( "TM2" )
								dbSetOrder(1)//TM2_FILIAL+TM2_NUMFIC+DTOS(TM2_DTCONS)+TM2_HRCONS+TM2_CODMED
								If dbSeek(xFilial( "TM2" ) + TM0->TM0_NUMFIC + DTOS( TMT->TMT_DTCONS ) + TMT->TMT_HRCONS )
									SomaLinha()

									While !Eof() .And. xFilial( "TM2" ) == TM2->TM2_FILIAL .And. TM2->TM2_NUMFIC == TM0->TM0_NUMFIC .And.;
										DTOS( TM2->TM2_DTCONS ) == DTOS( TMT->TMT_DTCONS ) .And. TM2->TM2_HRCONS == TMT->TMT_HRCONS

									 	@ Li,041 PSay Alltrim( TM2->TM2_CODMED ) + " - " + Alltrim( NgSeek( "TM1", TM2->TM2_CODMED, 1, "TM1->TM1_NOMEDI" ) )
									 	@ Li,100 PSay Alltrim( NgSeek( "TM1", TM2->TM2_CODMED, 1, "TM1->TM1_UNIDAD" ) )
								 		@ Li,113 PSay cValtochar( TM2->TM2_QTUTIL )

										SomaLinha()
										TM2->( dbSkip() )
									 End

								Endif

							EndIf

							SomaLinha()
						EndIf

						DbSelectArea( "TMT" )
						dbskip()
						loop
					EndIf

		        Enddo

		    EndIf

		    //Imprimir Vacinas
		    If mv_par15 == 1

				DbSelectArea( "TL9" )
				DbSetOrder( 01 )
				DbSeek( xfilial( "TL9" ) + TM0->TM0_NUMFIC, .T. )
				lPrimeiro := .T.

				While !Eof() .And. TM0->TM0_NUMFIC == TL9->TL9_NUMFIC

					If !Empty(TL9->TL9_DTREAL)
						If TL9->TL9_DTREAL < mv_par03 .Or. TL9->TL9_DTREAL > mv_par04
							dbSelectArea( "TL9" )
							dbSkip()
							Loop
						EndIf

					Else
						If TL9->TL9_DTPREV < mv_par03 .Or. TL9->TL9_DTPREV > mv_par04
							dbSelectArea( "TL9" )
							dbSkip()
							Loop
						EndIf

					EndIf

					If lPrimeiro .Or. Li >= 58
						SomaLinha()
						@ Li,000 PSay STR0118 //"Vacinas Aplicadas                                     Data                   Dose"
						SomaLinha()
						lPrimeiro := .F.
					EndIf

					SomaLinha()

					@ Li,000 PSay NGSEEK( "TL6", TL9->TL9_VACINA, 1, "TL6->TL6_NOMVAC" )
					@ Li,040 PSay TL9->TL9_DTREAL  Picture "99/99/99"
					@ Li,055 PSay TL9->TL9_DOSE

					DbSelectArea( "TL9" )
					dbskip()
					loop

				Enddo

			EndIf

			//Caso seja impresso o(s) Atendimento(s) de Enfermagem.
			If mv_par16 == 1
				DbSelectArea( "TL5" )
				DbSetOrder( 01 )//TL5_FILIAL+TL5_NUMFIC+DTOS(TL5_DTATEN)+TL5_HRATEN+TL5_INDICA+TL5_CODMED
				If DbSeek( xFilial( "TL5" ) + TM0->TM0_NUMFIC )

					SomaLinha()
					@ Li,000 PSay STR0127 //"Atend. Enfermagem     Motivo                              Medicamentos                    Unid. Med.     Quantidade"
					SomaLinha()

					While !Eof() .And. xFilial( "TL5" ) == TL5->TL5_FILIAL .And. TL5->TL5_NUMFIC == TM0->TM0_NUMFIC

						//Motivos
						cLinhasMot := Alltrim( TL5->TL5_MOTIVO ) + " - " + Alltrim( NgSeek( "TMS", TL5->TL5_MOTIVO, 1, "TMS->TMS_NOMOTI" ) )
						nLinMot    :=  MLCOUNT( cLinhasMot, 35 )
						lAtend     := .T. //Variavel para controle de impressão do motivo
						lAtend2    := .T. //Controla a impressão da segunda linha do motivo

						// Imprime o Medicamento
						DbselectArea( "TY3" )
						dbSetOrder( 1 )//TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED
						If dbSeek( xFilial( "TY3" ) + TM0->TM0_NUMFIC + DTOS( TL5->TL5_DTATEN ) + TL5->TL5_HRATEN )

							While !Eof() .And. xFilial("TY3") == TY3->TY3_FILIAL .And. TY3->TY3_NUMFIC == TM0->TM0_NUMFIC .And.;
								DTOS(TY3->TY3_DTATEN) == DTOS(TL5->TL5_DTATEN) .And. TY3->TY3_HRATEN == TL5->TL5_HRATEN
								cLinhasMed := Alltrim( TY3->TY3_CODMED ) + " - " + Alltrim( NgSeek( "TM1", TY3->TY3_CODMED, 1, "TM1->TM1_NOMEDI" ) )
								nLinMed    :=  MLCOUNT( cLinhasMed, 30 )

								nContImp := IIf( nLinMot >= nLinMed, nLinMot, nLinMed )//Verifica a quantidade de linhas que será impressa.

								For nLinhaCorrente := 1 To nContImp

									If nLinhaCorrente == 1 //Caso seja a primeira linha

										If nLinBck == 2 .Or. nLinMot == 1
											Somalinha()
										Endif

										If lAtend
											@ Li,000 PSay DTOC(TL5->TL5_DTATEN) + " - " + TL5->TL5_HRATEN //Data do Atendimento de Enfermagem
											@ Li,022 PSay Memoline(cLinhasMot,35,nLinhaCorrente)
											lAtend := .F.
										EndIf

										@ Li,058 PSay Memoline(cLinhasMed,30,nLinhaCorrente)
										@ Li,093 PSay Alltrim(NgSeek("TM1",TY3->TY3_CODMED,1,"TM1->TM1_UNIDAD")) //Unidade
										@ Li,105 PSay cValtochar(TY3->TY3_QUANT) //Quantidade

									ElseIf nLinhaCorrente == 2
										nLinBck := nLinMed
										Somalinha()

										If nLinMot > 1 .And. lAtend2
											@ Li,022 PSay Memoline(cLinhasMot,35,nLinhaCorrente)
											lAtend2 := .F.
										EndIf

										If nLinMed > 1
											@ Li,058 PSay Memoline(cLinhasMed,30,nLinhaCorrente)
										EndIf

									EndIf

								Next nLinhaCorrente
								TY3->(dbSkip())
							End
						Else //Caso não tenham medicamento.

							For nLinhaCorrente := 1 To nLinMot

								If nLinhaCorrente == 1  //Caso seja a primeira linha
									@ Li,000 PSay DTOC(TL5->TL5_DTATEN) + " - " + TL5->TL5_HRATEN //Data do Atendimento de Enfermagem
								EndIf

								@ Li,022 PSay Memoline(cLinhasMot,35,nLinhaCorrente)
								Somalinha()

							Next nLinhaCorrente

						Endif
						TL5->(dbSkip())
					End

				EndIf
				Somalinha()

			EndIf

			If Li <> 6
				Li := 60
			Endif

		Next
		dbselectarea("TM0")
		dbskip()

	EndDo

	RestArea(aArea)

	//Devolve a condicao original do arquivo principal
	If !lPrint
		MsgInfo(STR0098)  //"Não há nada para imprimir no relatório."
		Return .F.
	Endif

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
	//SET CENTURY ON
	MS_FLUSH()

Return NIL
//-------------------------------------------------------------------
/*/{Protheus.doc} GRAF400Imp
Chamada do relatório Modelo Gráfico

@type Static Function
@author  Liber De Esteban

@since   08/2004

@sample  GRAF400Imp( @lEnd, 'MDTR400', 'Relatório', 'M' )

@param   lEnd, Lógico, Indica o fim da impressão
@param   wnRel, Caracter, Programa utilizado
@param   titulo, Caracter, Título do relatório
@param   tamanho, Caracter, Tamanho do relatório
@return  return_type, return_descr
/*/
//-------------------------------------------------------------------
Static Function GRAF400Imp( lEnd, wnRel, titulo, tamanho )

	Local LinhaCorrente
	Local aArea   := TM0->(GetArea())
	Local cSMCOD  := If(FindFunction("FWGrpCompany"),FWGrpCompany(),SM0->M0_CODIGO)
	Local cSMFIL  := If(FindFunction("FWCodFil"),FWCodFil(),SM0->M0_CODFIL)
	Local cLinhasMemo
	Local cLinhasMot := ""
	Local cLinhasMed := ""
	Local lFirst     := .T.
	Local lAtend     := .F.
	Local lAtend2    := .F.
	Local nCont
	Local nLinhaCorrente
	Local nLinhasMemo
	Local nConty    := 18
	Local nContLin
	Local nLinMot   := 0
	Local nLinMed   := 0
	Local nContImp  := 0
	Local nLinBck   := 1
	Local nLinSalva := 0

	//Variaveis Memo
	Local cDiagno
	Local cDesAte
	Local cQueixa
	Local lImpSYP := .T.

	Private oFont16,oFont14,oFont12,oFont11,oFont10,oFont09
	Private oPrint := TMSPrinter():New( OemToAnsi(STR0001) ) //"FICHA MEDICA"
	Private lin := 200
	oPrint:Setup()

	oFont09	 := TFont():New("ARIAL",08,08,,.F.,,,,.F.,.F.)
	oFont10  := TFont():New("ARIAL",09,09,,.F.,,,,.F.,.F.)
	oFont11  := TFont():New("ARIAL",10,10,,.F.,,,,.T.,.F.)
	oFont12  := TFont():New("ARIAL",10,10,,.T.,,,,.F.,.F.)
	oFont12n := TFont():New("ARIAL",12,12,,.T.,,,,.T.,.F.)
	oFont14	 := TFont():New("ARIAL",14,14,,.F.,,,,.F.,.F.)
	oFont16  := TFont():New("ARIAL",16,16,,.T.,,,,.T.,.F.)

	If cReleaseRPO >= '12.1.2410'
		lImpSYP := .F.
	EndIf

	dbSelectArea( "TM0" )
	dbSetOrder( 01 )      // NUMERO DA FICHA MEDICA
	dbSeek( xFilial( "TM0" ) + mv_par01, .T. )
	ProcRegua( RecCount() ) // MONTA A REGUA DE ACOMPANHAMENTO

	While !Eof() .And. TM0->TM0_FILIAL == xFilial( 'TM0' ) .And. TM0->TM0_NUMFIC <= mv_par02

		If lEnd
			Exit
	    EndIf

		IncProc()  // INCREMENTO DA REGUA DE ACOMPAHAMENTO.

		For nCont := 1 to nVias
			lin := 180
			oPrint:StartPage()
			oPrint:Line(150,50,150,2350)
			oPrint:Line(323,50,323,2350)

			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+cSMFIL+".BMP",400,165)

			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+".BMP",400,165)

			ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",400,165)

			ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+".BMP",400,165)

			Endif
			oPrint:Say(lin+30,800,STR0053,oFont16) //"FICHA MÉDICA E PRONTUÁRIO"
			Somalinha(180)

			oPrint:Say(lin,060,STR0054,oFont12) //"Ficha Médica:"
			oPrint:Say(lin,360, TM0->TM0_NUMFIC + " - " + TM0->TM0_NOMFIC, oFont11 )
		    oPrint:Say(lin,1400,STR0055,oFont12) //"Implantação:"
		    oPrint:Say(lin,1696,DTOC(TM0->TM0_DTIMPL),oFont11)
		    Somalinha()

		    If !Empty( TM0->TM0_MAT )
				oPrint:Say(lin,060,STR0056,oFont12) //"Matrícula:"
				oPrint:Say(lin,360, TM0->TM0_FILFUN + " - " + TM0->TM0_MAT, oFont11 )

			    If !Empty( TM0->TM0_NUMDEP )
		            dbSelectArea( "SRA" )
		            dbSetOrder( 01 )
		            dbSeek( TM0->TM0_FILFUN + TM0->TM0_MAT )
			        oPrint:Say(lin,640,STR0011,oFont12)//"Dep.: "
					oPrint:Say(lin,730,TM0->TM0_NUMDEP+" - "+SRA->RA_NOME,oFont11 )
		        EndIf

		    Else
				oPrint:Say(lin,060,STR0057,oFont12) //"Candidato:"
				oPrint:Say(lin,360,TM0->TM0_CANDID,oFont11)
		    EndIf
			oPrint:Say(lin,1400,STR0013,oFont12)//"Nascimento: "
			oPrint:Say(lin,1696,DTOC(TM0->TM0_DTNASC),oFont11)
		    SomaLinha()

			oPrint:Say(lin,060,STR0058,oFont12) //"Sexo: "
			oPrint:Say(lin,360,AllTrim(NGRETSX3BOX( "TM0_SEXO", TM0->TM0_SEXO )),oFont11)
			oPrint:Say(lin,1400,STR0059,oFont12) //"Sangue:"
			cFatorRH := " "
			cFatorRH := AllTrim(NGRETSX3BOX( "TM0_FATORH", TM0->TM0_FATORH ))
			oPrint:Say(lin,1696,AllTrim(NGRETSX3BOX( "TM0_SANGUE", TM0->TM0_SANGUE ))+" "+cFatorRH,oFont11)
		    SomaLinha()
			oPrint:Say(lin,060,STR0060,oFont12) //"Doador: "
			oPrint:Say(lin,360,AllTrim(NGRETSX3BOX( "TM0_DOADOR", TM0->TM0_DOADOR )),oFont11) //"Sim"
			oPrint:Say(lin,1400,STR0061,oFont12) //"Ul.Doação:"
		    oPrint:Say(lin,1696,DTOC(TM0->TM0_DTDOAC),oFont11)
		    SomaLinha()
			oPrint:Say(lin,060,STR0062,oFont12) //"Peso: "
		    oPrint:Say(lin,360,Transform(TM0->TM0_PESO,"999.9")+" KG",oFont11)
		    oPrint:Say(lin,1400,STR0063,oFont12) //"Altura:"
		    oPrint:Say(lin,1696,Transform(TM0->TM0_ALTURA,"9.99")+" M",oFont11)
		    SomaLinha()
			oPrint:Say(lin,060,STR0064,oFont12) //"Fumante:"
		    oPrint:Say(lin,360,AllTrim(NGRETSX3BOX( "TM0_FUMA", TM0->TM0_FUMA )),oFont11)
		    oPrint:Say(lin,1400,STR0065,oFont12) //"Cigarro/Dia:"
		    oPrint:Say(lin,1696,Transform(TM0->TM0_QTCIG,"999"),oFont11)
		    SomaLinha()
			oPrint:Say(lin,060,STR0066,oFont12) //"Qt. Tempo Fuma:"
		    oPrint:Say(lin,360,Transform(TM0->TM0_QTTEMP,"999")+" "+Upper(STR0027),oFont11)//"Anos"
		    oPrint:Say(lin,1400,STR0067,oFont12) //"Ficha Anterior:"
		    oPrint:Say(lin,1696,TM0->TM0_FICANT,oFont11)
		    SomaLinha()
			oPrint:Say(lin,060,STR0088,oFont12) //"Endereço:"
		    oPrint:Say(lin,360,NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_ENDEREC'),oFont11)
		    oPrint:Say(lin,1400,STR0089,oFont12) //"Bairro:"
		    oPrint:Say(lin,1696,NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_BAIRRO'),oFont11)
		    SomaLinha()
		    oPrint:Say(lin,060,STR0087,oFont12) //"Complemento do Endereço:"
		    oPrint:Say(lin,600,NGSeek('SRA',TM0->TM0_MAT,1,'SRA->RA_COMPLEM'),oFont11)
		    SomaLinha()

		    lPrimeiro   := .T.
		    nLinhasMemo := MLCOUNT(TM0->TM0_DESCRI,90)
		    For LinhaCorrente := 1 To nLinhasMemo

				if !empty( (MemoLine(TM0->TM0_DESCRI,90,LinhaCorrente)))
		            If lPrimeiro
		            	oPrint:Say(lin,060,STR0029,oFont12) //"Antecedentes.: "
		                lPrimeiro := .F.
		            EndIf
					oPrint:Say(lin,396,MemoLine(TM0->TM0_DESCRI,90,LinhaCorrente),oFont11)
		            SomaLinha()
		        EndIf
		        Loop
		    Next

		    If mv_par05 = 1       // Relacionar programas de saude
		        dbSelectArea("TMN")
		        dbSetOrder(02)      // NUMERO DA FICHA MEDICA + CODIGO DO PROGRAMA
		        dbSeek(xFilial("TMN")+TM0->TM0_NUMFIC,.F.)
		        lPrimeiro := .T.
		        While !Eof() .And. TMN->TMN_NUMFIC = TM0->TM0_NUMFIC .and. xFilial("TMN") == TMN->TMN_FILIAL
		            If TMN->TMN_DTINIC < mv_par03 .OR.;
		               TMN->TMN_DTINIC > mv_par04
		                dbskip()
		                loop
		            EndIf
		            If lPrimeiro .or. lin == 360
		                If lin+70 > 2600
		                	Somalinha(70,.t.)
		                Endif
			            If lin != 360
			                SomaLinha(10)
			                oPrint:Line(lin-10,50,lin-10,2350)
		    	            oPrint:Line(lin-10,1390,lin+50,1390)
			                oPrint:Line(lin-10,1790,lin+50,1790)
			            Else
		    	            oPrint:Line(323,1390,lin+50,1390)
			                oPrint:Line(323,1790,lin+50,1790)
						Endif
		                oPrint:Say(lin,060,STR0068,oFont12) //"Programas de Saúde"
		                oPrint:Say(lin,1400,STR0069,oFont12) //"Início"
		                oPrint:Say(lin,1800,STR0070,oFont12) //"Término"
		                oPrint:Line(lin+50,50,lin+50,2350)
		                SomaLinha()
		                SomaLinha(10)
		                lPrimeiro = .F.
		            EndIf
		            DbSelectArea("TMO")
		            DbSetOrder(01)
		            DbSeek(xfilial("TMO")+TMN->TMN_CODPRO)
		            oPrint:Line(lin-10,1390,lin+50,1390)
		            oPrint:Line(lin-10,1790,lin+50,1790)
		            oPrint:Say(lin,060,TMN->TMN_CODPRO+" - "+TMO->TMO_NOMPRO,oFont11)
		            oPrint:Say(lin,1400,DtoC(TMN->TMN_DTINIC),oFont11)
		            oPrint:Say(lin,1800,DtoC(TMN->TMN_DTTERM),oFont11)
		            DbSelectArea("TMN")
		            dbskip()
		            SomaLinha()
		            loop
		        Enddo
		    EndIf
		    If mv_par06 == 1 // Relacionar exames realizados
		        dbSelectArea("TM5")
		        dbSetOrder(01)
		        dbSeek(xFilial("TM5")+TM0->TM0_NUMFIC,.F.)
		        lPrimeiro := .T.
		        While !Eof() .And. TM0->TM0_NUMFIC == TM5->TM5_NUMFIC .And. xFilial("TM5") == TM5->TM5_FILIAL
					//Se o parametro for igual a assistencial e o exame for diferente de assistencial ele passa para o proximo registro
		            If mv_par10 == 2 .And.;
				      TM5->TM5_ORIGEX <> '1'
				        DbSkip()
				        Loop
				    EndIf
					//Se o parametro for igual a ocupacional e o exame for diferente de ocupacional ele passa para o proximo registro
				    If mv_par10 == 3 .And.;
				    TM5->TM5_ORIGEX <> '2'
				        DbSkip()
				        Loop
				    EndIf
		            If TM5->TM5_DTPROG < mv_par03 .Or.;
		               TM5->TM5_DTPROG > mv_par04
		                dbskip()
		                loop
		            EndIf
		            If Empty(TM5->TM5_DTRESU)
		                dbskip()
		                loop
		            EndIf
		            If lPrimeiro .Or. lin == 360
		                If lin+70 > 2600
		                	Somalinha(70,.T.)
		                Endif
			            If lin != 360
			                SomaLinha(10)
			                oPrint:Line(lin-10,50,lin-10,2350)
						Endif
		                IF mv_par11 == 1
			                If lin != 360
				                oPrint:Line(lin-10,890,lin+50,890)
				                oPrint:Line(lin-10,1090,lin+50,1090)
				                oPrint:Line(lin-10,1690,lin+50,1690)
				                oPrint:Line(lin-10,1940,lin+50,1940)
				            Else
				                oPrint:Line(323,890,lin+50,890)
				                oPrint:Line(323,1090,lin+50,1090)
				                oPrint:Line(323,1690,lin+50,1690)
				                oPrint:Line(323,1940,lin+50,1940)
				            Endif
			                oPrint:Say(lin,060,STR0071,oFont12) //"Exames Realizados"
			                oPrint:Say(lin,900,STR0072,oFont12) //"Data"
			                oPrint:Say(lin,1100,STR0073,oFont12) //"Descrição do Resultado"
			                oPrint:Say(lin,1700,STR0074,oFont12) //"Ind. Res."
			                oPrint:Say(lin,1950,STR0075,oFont12) //"Natureza"
		                Else
			                If lin != 360
				                oPrint:Line(lin-10,1390,lin+50,1390)
				                oPrint:Line(lin-10,1790,lin+50,1790)
				            Else
					            oPrint:Line(323,1390,lin+50,1390)
					            oPrint:Line(323,1790,lin+50,1790)
				            Endif
			                oPrint:Say(lin,060,STR0071,oFont12) //"Exames Realizados"
			                oPrint:Say(lin,1400,STR0076,oFont12) //"Data Exame"
							oPrint:Say(lin,1800,STR0075,oFont12) //"Natureza"
		    			ENDIF
		    			oPrint:Line(lin+50,50,lin+50,2350)
		    			SomaLinha()
		                SomaLinha(10)
		                lPrimeiro := .F.
		            EndIf
		            DbSelectArea("TM4")
		            DbSetOrder(01)
		            DbSeek(xfilial("TM4")+TM5->TM5_EXAME)
					If mv_par11 == 1
						oPrint:Line(lin-10,890,lin+50,890)
						oPrint:Line(lin-10,1090,lin+50,1090)
						oPrint:Line(lin-10,1690,lin+50,1690)
						oPrint:Line(lin-10,1940,lin+50,1940)
						nContLin := 25
						nLinMemo := MLCOUNT(Alltrim(TM4->TM4_NOMEXA),nContLin )//Conta a quantidade de linhas que serão necessarias
						cLinMemo := Alltrim(TM4->TM4_NOMEXA)//Recebe o valor do campo
						DbSelectArea("TMU")
		            	DbSetOrder(1)
		            	If DbSeek(xFilial("TMU")+TM5->TM5_CODRES)
		            		nLinMemo0 := MLCOUNT(Alltrim(TMU->TMU_RESULT),nContLin )
							cLinMemo0 := Alltrim(TMU->TMU_RESULT)
						Else
							nLinMemo0 := 0
							cLinMemo0 := " "
						EndIf
						aMaxLin := { nLinMemo, nLinMemo0 }
		    			aSort( aMaxLin, , , { | x , y |  x > y } )
		    			nLinhasMemo := aMaxLin[1]

						For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas
							If !Empty(MemoLine(cLinMemo,nContLin,nLinhaCorrente))
								oPrint:Say(lin,250,MemoLine(cLinMemo,nContLin,nLinhaCorrente),oFont11)//Quabra a linha quando chegar no valor de nContLin em caracteres
							EndIf
							If !Empty(MemoLine(cLinMemo0,nContLin,nLinhaCorrente))
								oPrint:Say(lin,1100,MemoLine(cLinMemo0,nContLin,nLinhaCorrente),oFont11)
							EndIf
							If nLinhaCorrente == 1
								oPrint:Say(lin,060,TM5->TM5_EXAME + " - ",oFont11)
								oPrint:Say(lin,900,DtoC(TM5->TM5_DTRESU),oFont11)
								oPrint:Say(lin,1700,AllTrim(NGRETSX3BOX( "TM5_INDRES", TM5->TM5_INDRES )),oFont11)
				            	oPrint:Say(lin,1950,AllTrim(NGRETSX3BOX( "TM5_NATEXA", TM5->TM5_NATEXA )),oFont11)
			            	EndIf
							If nLinhaCorrente <> nLinhasMemo
								Somalinha()
							EndIf
							oPrint:Line(lin-10,890,lin+50,890)
							oPrint:Line(lin-10,1090,lin+50,1090)
							oPrint:Line(lin-10,1690,lin+50,1690)
							oPrint:Line(lin-10,1940,lin+50,1940)
						Next
					Else
						oPrint:Line(lin-10,1390,lin+50,1390)
						oPrint:Line(lin-10,1790,lin+50,1790)
						oPrint:Say(lin,060,TM5->TM5_EXAME+" - "+TM4->TM4_NOMEXA,oFont11)
						oPrint:Say(lin,1400,DtoC(TM5->TM5_DTRESU),oFont11)
						oPrint:Say(lin,1800,AllTrim(NGRETSX3BOX( "TM5_NATEXA", TM5->TM5_NATEXA )),oFont11)
					EndIf
					SomaLinha()
					DbSelectArea("TM5")
					dbskip()
					loop
				Enddo
			EndIf

			If mv_par07 == 1 // Relacionar restricoes
			dbSelectArea("TMF")
			dbSetOrder(01)
			dbSeek(xFilial("TMF")+TM0->TM0_NUMFIC,.F.)
			lPrimeiro := .T.
				While !Eof() .And. TM0->TM0_NUMFIC == TMF->TMF_NUMFIC .And. xFilial("TMF") == TMF->TMF_FILIAL
					If TMF->TMF_DTINIC < mv_par03   .Or.;
						TMF->TMF_DTINIC > mv_par04
						dbskip()
						loop
					EndIf
					If lPrimeiro .Or. lin == 360
						If lin+70 > 2600
							Somalinha(70,.T.)
						Endif
						If lin != 360
							SomaLinha(10)
							oPrint:Line(lin-10,50,lin-10,2350)
							oPrint:Line(lin-10,1390,lin+50,1390)
							oPrint:Line(lin-10,1790,lin+50,1790)
						Else
							oPrint:Line(323,1390,lin+50,1390)
							oPrint:Line(323,1790,lin+50,1790)
						Endif
						oPrint:Say(lin,60,STR0077,oFont12) //"Restrições"
						oPrint:Say(lin,1400,STR0069,oFont12) //"Início"
						oPrint:Say(lin,1800,STR0070,oFont12) //"Término"
						oPrint:Line(lin+50,50,lin+50,2350)
						SomaLinha()
						SomaLinha(10)
						lPrimeiro := .F.
					EndIf
					DbSelectArea("TME")
					DbSetOrder(01)
					DbSeek(xfilial("TME")+TMF->TMF_RESTRI)
					oPrint:Line(lin-10,1390,lin+50,1390)
					oPrint:Line(lin-10,1790,lin+50,1790)
					oPrint:Say(lin,60,TMF->TMF_RESTRI+" - "+TME->TME_NOMRES,oFont11)
					oPrint:Say(lin,1400,DTOC(TMF->TMF_DTINIC),oFont11)
					oPrint:Say(lin,1800,DTOC(TMF->TMF_DTFIM),oFont11)
					SomaLinha()
					DbSelectArea("TMF")
					dbskip()
					loop
				Enddo
		    EndIf

		    If mv_par08 == 1 // Relacionar doencas
				dbSelectArea("TNA")
				dbSetOrder(01)
				dbSeek(xFilial("TNA")+TM0->TM0_NUMFIC,.F.)
				lPrimeiro := .T.
				While !Eof() .And. TM0->TM0_NUMFIC == TNA->TNA_NUMFIC .and. xFilial("TNA") == TNA->TNA_FILIAL
					If TNA->TNA_DTINIC  < mv_par03  .OR.;
							TNA->TNA_DTINIC  > mv_par04
						dbskip()
						loop
					EndIf
					If lPrimeiro .or. lin == 360
						If lin+70 > 2600
							Somalinha(70,.t.)
						Endif
						If lin != 360
							SomaLinha(10)
							oPrint:Line(lin-10,50,lin-10,2350)
							oPrint:Line(lin-10,1390,lin+50,1390)
							oPrint:Line(lin-10,1790,lin+50,1790)
						Else
							oPrint:Line(323,1390,lin+50,1390)
							oPrint:Line(323,1790,lin+50,1790)
						Endif
						oPrint:Say(lin,60,STR0078,oFont12) //"Doenças"
						oPrint:Say(lin,1400,STR0069,oFont12) //"Início"
						oPrint:Say(lin,1800,STR0070,oFont12) //"Término"
						oPrint:Line(lin+50,50,lin+50,2350)
						SomaLinha()
						SomaLinha(10)
						lPrimeiro := .F.
					EndIf

					oPrint:Line(lin-10,1390,lin+50,1390)
					oPrint:Line(lin-10,1790,lin+50,1790)

					DbSelectArea("TMR")
					DbSetOrder(01)
					DbSeek(xfilial("TMR")+TNA->TNA_CID)
					nContLin := 50
					nLinMemo := MLCOUNT(Alltrim(TMR->TMR_DOENCA),nContLin )//Conta a quantidade de linhas que serão necessarias
					cLinMemo := Alltrim(TMR->TMR_DOENCA)//Recebe o valor do campo

					aMaxLin := { nLinMemo }
	    			aSort( aMaxLin, , , { | x , y |  x > y } )
	    			nLinhasMemo := aMaxLin[1]

					For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas
						If !Empty(MemoLine(cLinMemo,nContLin,nLinhaCorrente))
							oPrint:Say(lin,250,MemoLine(cLinMemo,nContLin,nLinhaCorrente),oFont11)//Quabra a linha quando chegar no valor de nContLin em caracteres
						EndIf
						If nLinhaCorrente == 1
							oPrint:Say(lin,060,TNA->TNA_CID+" - ",oFont11)
							oPrint:Say(lin,1400,DTOC(TNA->TNA_DTINIC),oFont11)
							oPrint:Say(lin,1800,DTOC(TNA->TNA_DTFIM),oFont11)
		            	EndIf
						If nLinhaCorrente <> nLinhasMemo
							Somalinha()
						EndIf
						oPrint:Line(lin-10,1390,lin+50,1390)
						oPrint:Line(lin-10,1790,lin+50,1790)
					Next
					SomaLinha()
					DbSelectArea("TNA")
					dbskip()
					loop
				Enddo
		    EndIf

		    If mv_par09 == 1 // Relacionar Diagnosticos
		        dbSelectArea("TMT")
		        dbSetOrder(01)
		        dbSeek(xFilial("TMT")+TM0->TM0_NUMFIC,.F.)
		        lPrimeiro := .T.
		        While !Eof() .And. TM0->TM0_NUMFIC == TMT->TMT_NUMFIC .and. xFilial("TMT") == TMT->TMT_FILIAL
					//Se o parametro for igual a assistencial e o Diagnóstico for diferente de Atendimento Clínico ou Outros Atendimentos ele passa para o proximo registro
					If MV_PAR10 = 2 .AND. (TMT->TMT_OCORRE <> '1' .Or. TMT->TMT_OCORRE <> '5')
						DbSkip()
						Loop
					Endif
					//Se o parametro for igual a ocupacional e o Diagnóstico for igual a Atendimento Clínico ou Outros Atendimentos ele passa para o proximo registro
					If MV_PAR10 = 3 .AND.;
		            (TMT->TMT_OCORRE = '1' .OR. TMT->TMT_OCORRE = '5')
		                DbSkip()
		                Loop
					Endif
					If TMT->TMT_DTCONS < mv_par03 .OR.;
		               TMT->TMT_DTCONS > mv_par04
		                dbskip()
		                loop
					EndIf
					If TMT->TMT_DTATEN < mv_par03 .OR.;
		               TMT->TMT_DTATEN > mv_par04
		                dbskip()
		                loop
					EndIf
					IF mv_par12 == 1
						DbSelectArea("TMR")
		            	DbSetOrder(01)
		            	If DbSeek(xfilial("TMR")+TMT->TMT_CID)
			            	If lPrimeiro .or. lin == 360
								If lin+70 > 2600
									Somalinha(70,.t.)
								Endif
								If lin != 360
									SomaLinha(10)
									oPrint:Line(lin-10,50,lin-10,2350)
								Endif
								If lin != 360
									oPrint:Line(lin-10,590,lin+50,590)
									oPrint:Line(lin-10,810,lin+50,810)
									oPrint:Line(lin-10,1190,lin+50,1190)
									oPrint:Line(lin-10,1590,lin+50,1590)
									oPrint:Line(lin-10,1990,lin+50,1990)
								Else
									oPrint:Line(323,590,lin+50,590)
									oPrint:Line(323,810,lin+50,810)
									oPrint:Line(323,1190,lin+50,1190)
									oPrint:Line(323,1590,lin+50,1590)
									oPrint:Line(323,1990,lin+50,1990)
								Endif
								oPrint:Say(lin,60,STR0079,oFont12) //"Diagnósticos"
								oPrint:Say(lin,600,STR0072,oFont12) //"Data"
								oPrint:Say(lin,820,STR0080,oFont12) //"Ind. Atend."
								oPrint:Say(lin,1200,STR0081,oFont12) //"Diagnóstico Médico"
								oPrint:Say(lin,1600,STR0082,oFont12) //"Atend. Médico"
								oPrint:Say(lin,2000,STR0083,oFont12) //"Queixa Principal"
								oPrint:Line(lin+50,50,lin+50,2350)
								SomaLinha()
								SomaLinha(10)
								lPrimeiro := .F.
							EndIf

			            	If mv_par17 == 1
			           	 	oPrint:Line(Lin-10,50 ,lin-10,2350 )
			            	EndIf
							oPrint:Line(lin-10,590,lin+50,590)
							oPrint:Line(lin-10,810,lin+50,810)
							oPrint:Line(lin-10,1190,lin+50,1190)
							oPrint:Line(lin-10,1590,lin+50,1590)
							oPrint:Line(lin-10,1990,lin+50,1990)

							nLinMemo := MLCOUNT(Alltrim(TMR->TMR_DOENCA),nConty )//Conta a quantidade de linhas que serão necessarias
							cLinMemo := Alltrim(TMR->TMR_DOENCA)//Recebe o valor do campo

							If lImpSYP
								cDiagno := MsMM( TMT->TMT_DIASYP , 10 )
				    			cDesAte := MsMM( TMT->TMT_DATSYP , 10 )
				    			cQueixa := MsMM( TMT->TMT_QUESYP , 10 )
							Else
				    			cDiagno := TMT->TMT_MDIAGN
				    			cDesAte := TMT->TMT_MDESAT
				    			cQueixa := TMT->TMT_MQUEIX
			    			EndIf

							nLinMemo0 := MLCOUNT(Alltrim(cDiagno),nConty )
			    			cLinMemo0 := Alltrim(cDiagno)
			    			nLinMemo1 := MLCOUNT(Alltrim(cDesAte),nConty )
			    			cLinMemo1 := Alltrim(cDesAte)
							nLinMemo2 := MLCOUNT(Alltrim(cQueixa),nConty )
			    			cLinMemo2 := Alltrim(cQueixa)

			    			//Faz comparações para verificar qual possui mais linhas
							aMaxLin := { nLinMemo, nLinMemo0, nLinMemo1, nLinMemo2 }
			    			aSort( aMaxLin, , , { | x , y |  x > y } )
			    			nLinhasMemo := aMaxLin[1]

							For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas
								If !Empty(MemoLine(cLinMemo,nConty,nLinhaCorrente)) //Verifica se tem informações, caso possuir vai imprimindo linha a linha
									oPrint:Say(lin,250,MemoLine(cLinMemo,nConty,nLinhaCorrente),oFont11)//Quabra a linha quando chegar no valor de nConty em caracteres
								EndIf
								If !Empty(MemoLine(cLinMemo0,nConty,nLinhaCorrente))
									oPrint:Say(lin,1200,MemoLine(cLinMemo0,nConty,nLinhaCorrente),oFont11)
								EndIf
								If !Empty(MemoLine(cLinMemo1,nConty,nLinhaCorrente))
									oPrint:Say(lin,1600,MemoLine(cLinMemo1,nConty,nLinhaCorrente),oFont11)
								EndIf
								If !Empty(MemoLine(cLinMemo2,nConty,nLinhaCorrente))
									oPrint:Say(lin,2000,MemoLine(cLinMemo2,nConty,nLinhaCorrente),oFont11)
								EndIf
								If nLinhaCorrente == 1 //Só deve se impresso na primeira linha, caso possua varias linhas
									oPrint:Say(lin,060,TMT->TMT_CID+" - ",oFont11)
									oPrint:Say(lin,600,DTOC(TMT->TMT_DTCONS),oFont11)
					            	oPrint:Say(lin,820,AllTrim(NGRETSX3BOX( "TMT_OCORRE", TMT->TMT_OCORRE )),oFont11)
				            	EndIf
								If nLinhaCorrente <> nLinhasMemo
									Somalinha()
								EndIf
								oPrint:Line(lin-10,590,lin+100,590)
								oPrint:Line(lin-10,810,lin+100,810)
								oPrint:Line(lin-10,1190,lin+100,1190)
								oPrint:Line(lin-10,1590,lin+100,1590)
								oPrint:Line(lin-10,1990,lin+100,1990)
								If lin+50 > 2600
									oPrint:Line(lin-10,590,lin+50,590)
									oPrint:Line(lin-10,810,lin+50,810)
									oPrint:Line(lin-10,1190,lin+50,1190)
									oPrint:Line(lin-10,1590,lin+50,1590)
									oPrint:Line(lin-10,1990,lin+50,1990)
									Somalinha(50,.t.)
									oPrint:Line(lin-30,590,lin+50,590)
									oPrint:Line(lin-30,810,lin+50,810)
									oPrint:Line(lin-30,1190,lin+50,1190)
									oPrint:Line(lin-30,1590,lin+50,1590)
									oPrint:Line(lin-30,1990,lin+50,1990)
								Endif
							Next

							// MEDICAMENTOS
							If mv_par17 == 1
								DbSelectArea("TM2")
								dbSetOrder(1)//TM2_FILIAL+TM2_NUMFIC+DTOS(TM2_DTCONS)+TM2_HRCONS+TM2_CODMED
								If dbSeek(xFilial("TM2")+TM0->TM0_NUMFIC+DTOS(TMT->TMT_DTCONS)+TMT->TMT_HRCONS)
									If Lin + 220 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
										SomaLinha( 220 , .T. )
										Lin -= 80
									Endif
			            			SomaLinha()
									SomaLinha()
									oPrint:Line(lin,50,lin,590)
									oPrint:Box(lin,590 ,lin+50,2350 )  // Monta tabela
									oPrint:Say(lin,610,STR0128,oFont12) //"Medicamentos"
									oPrint:Line(lin,1860,lin+50,1860)//Linha Vertical
									oPrint:Say(lin,1880,STR0129,oFont12) //"Unid. Medida"
									oPrint:Line(lin,2080,lin+50,2080)//Linha Vertical
									oPrint:Say(lin,2100,STR0130,oFont12) //"Quantidade"
									SomaLinha()

									nLinSalva := lin
									While !Eof() .And. xFilial("TM2") == TM2->TM2_FILIAL .And. TM2->TM2_NUMFIC == TM0->TM0_NUMFIC .And.;
									 DTOS(TM2->TM2_DTCONS) == DTOS(TMT->TMT_DTCONS) .And. TM2->TM2_HRCONS == TMT->TMT_HRCONS
										//Caso nova página, imprime cabeçalho.
										If Lin + 160 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
											oPrint:Box(nLinSalva,590 ,lin,2350 )  // Monta tabela
											oPrint:Line(nLinSalva,1860,lin,1860)//Linha Vertical
											oPrint:Line(nLinSalva,2080,lin,2080)//Linha Vertical
											SomaLinha( 160 , .T. )
											Lin -= 30
											nLinSalva := Lin
										Endif
									 	oPrint:Say(Lin,1900,Alltrim(NgSeek("TM1",TM2->TM2_CODMED,1,"TM1->TM1_UNIDAD")),oFont11) //Unid. Medida
										oPrint:Say(Lin,2100,cValtochar(TM2->TM2_QTUTIL),oFont11) //Quantidade

									 	//-------------------------------------
										// Imprime o Medicamento
										//-------------------------------------
										oPrint:Say(Lin,620,Alltrim(TM2->TM2_CODMED) + " - " + Alltrim(NgSeek("TM1",TM2->TM2_CODMED,1,"TM1->TM1_NOMEDI")),oFont11)
										SomaLinha()
										TM2->(dbSkip())
									 End
									oPrint:Box(nLinSalva,590 ,lin+20,2350 )  // Monta tabela
									oPrint:Line(nLinSalva,1860,lin+20,1860)//Linha Vertical
									oPrint:Line(nLinSalva,2080,lin+20,2080)//Linha Vertical
								Else
									SomaLinha()
									SomaLinha()
									oPrint:Line(lin,50,lin,2350)
								Endif
							EndIf

			           	SomaLinha()
			            	SomaLinha()
		            	EndIf
		            	DbSelectArea("TMT")
		            	dbskip()
		            	loop
					Else
						DbSelectArea("TMR")
		            	DbSetOrder(01)
		            	If DbSeek(xfilial("TMR")+TMT->TMT_CID)
		            		If lPrimeiro .or. lin == 360
								If lin+70 > 2600
									Somalinha(70,.t.)
								Endif
								If lin != 360
									SomaLinha(10)
									oPrint:Line(lin-10,50,lin-10,2350)
								Endif
								If lin != 360
									oPrint:Line(lin-10,1390,lin+50,1390)
									oPrint:Line(lin-10,1790,lin+50,1790)
								Else
									oPrint:Line(323,1390,lin+50,1390)
									oPrint:Line(323,1790,lin+50,1790)
								Endif
								oPrint:Say(lin,60,STR0079,oFont12) //"Diagnósticos"
								oPrint:Say(lin,1400,STR0084,oFont12) //"Data Consulta"
								oPrint:Say(lin,1800,STR0080,oFont12) //"Ind. Atend."
								oPrint:Line(lin+50,50,lin+50,2350)
								SomaLinha()
								SomaLinha(10)
								lPrimeiro := .F.
							EndIf
			            	If mv_par17 == 1
				            	oPrint:Line(lin-10,50,lin-10,2350)
								oPrint:Line(lin-10,1390,lin+100,1390)
								oPrint:Line(lin-10,1790,lin+100,1790)
							Else
							oPrint:Line(lin-10,1390,lin+50,1390)
							oPrint:Line(lin-10,1790,lin+50,1790)
							EndIf

							nContLin := 50
							nLinMemo := MLCOUNT(Alltrim(TMR->TMR_DOENCA),nContLin )//Conta a quantidade de linhas que serão necessarias
							cLinMemo := Alltrim(TMR->TMR_DOENCA)//Recebe o valor do campo

							aMaxLin := { nLinMemo }
			    			aSort( aMaxLin, , , { | x , y |  x > y } )
			    			nLinhasMemo := aMaxLin[1]

							For nLinhaCorrente := 1 to nLinhasMemo 	 // Imprime ate o total maximo de linhas
								If !Empty(MemoLine(cLinMemo,nContLin,nLinhaCorrente))
									oPrint:Say(lin,250,MemoLine(cLinMemo,nContLin,nLinhaCorrente),oFont11)//Quabra a linha quando chegar no valor de nConty em caracteres
								EndIf
								If nLinhaCorrente == 1
									oPrint:Say(lin,060,TMT->TMT_CID+" - ",oFont11)
									oPrint:Say(lin,1400,DTOC(TMT->TMT_DTCONS),oFont11)
									oPrint:Say(lin,1800,AllTrim(NGRETSX3BOX( "TMT_OCORRE", TMT->TMT_OCORRE )),oFont11)
				            	EndIf
								If nLinhaCorrente <> nLinhasMemo
									Somalinha()
								EndIf
								oPrint:Line(lin-10,1390,lin+50,1390)
								oPrint:Line(lin-10,1790,lin+50,1790)
							Next

							// MEDICAMENTOS
							If mv_par17 == 1
								DbSelectArea("TM2")
								dbSetOrder(1)//TM2_FILIAL+TM2_NUMFIC+DTOS(TM2_DTCONS)+TM2_HRCONS+TM2_CODMED
								If dbSeek(xFilial("TM2")+TM0->TM0_NUMFIC+DTOS(TMT->TMT_DTCONS)+TMT->TMT_HRCONS)
									If Lin + 220 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
										SomaLinha( 220 , .T. )
										Lin -= 80
									Endif

									SomaLinha()
									SomaLinha()
									oPrint:Line(lin,50,lin,590)
									oPrint:Box(lin,590 ,lin+50,2350 )  // Monta tabela
									oPrint:Say(lin,610,STR0128,oFont12) //"Medicamentos"
									oPrint:Line(lin,1860,lin+50,1860)//Linha Vertical
									oPrint:Say(lin,1880,STR0129,oFont12) //"Unid. Medida"
									oPrint:Line(lin,2080,lin+50,2080)//Linha Vertical
									oPrint:Say(lin,2100,STR0130,oFont12) //"Quantidade"
									SomaLinha()

									nLinSalva := lin
									While !Eof() .And. xFilial("TM2") == TM2->TM2_FILIAL .And. TM2->TM2_NUMFIC == TM0->TM0_NUMFIC .And.;
									 DTOS(TM2->TM2_DTCONS) == DTOS(TMT->TMT_DTCONS) .ANd. TM2->TM2_HRCONS == TMT->TMT_HRCONS
										//Caso nova página, imprime cabeçalho.
										If Lin + 160 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
											oPrint:Box(nLinSalva,590 ,lin,2350 )  // Monta tabela
											oPrint:Line(nLinSalva,1860,lin,1860)//Linha Vertical
											oPrint:Line(nLinSalva,2080,lin,2080)//Linha Vertical
											SomaLinha( 160 , .T. )
											Lin -= 30
											nLinSalva := Lin
										Endif
									 	oPrint:Say(Lin,1900,Alltrim(NgSeek("TM1",TM2->TM2_CODMED,1,"TM1->TM1_UNIDAD")),oFont11) //Unid. Medida
										oPrint:Say(Lin,2100,cValtochar(TM2->TM2_QTUTIL),oFont11) //Quantidade

									 	// Imprime o Medicamento
										oPrint:Say(Lin,620,Alltrim(TM2->TM2_CODMED) + " - " + Alltrim(NgSeek("TM1",TM2->TM2_CODMED,1,"TM1->TM1_NOMEDI")),oFont11)
										SomaLinha()
										TM2->(dbSkip())
									 End
									oPrint:Box(nLinSalva,590 ,lin+20,2350 )  // Monta tabela
									oPrint:Line(nLinSalva,1860,lin+20,1860)//Linha Vertical
									oPrint:Line(nLinSalva,2080,lin+20,2080)//Linha Vertical
								Else
									SomaLinha()
									SomaLinha()
									oPrint:Line(lin,50,lin,2350)
								Endif
								SomaLinha()
							EndIf

			            	SomaLinha()
		            	EndIf
		            	DbSelectArea("TMT")
		            	dbskip()
		            	loop
		            EndIf
		        Enddo
		    EndIf

		    //Imprimir Vacinas
			If mv_par15 == 1
				DbSelectArea("TL9")
				DbSetOrder(01)
				DbSeek(xfilial("TL9")+TM0->TM0_NUMFIC,.T.)
				lPrimeiro := .T.

				While !Eof() .And. TM0->TM0_NUMFIC == TL9->TL9_NUMFIC

					If !Empty(TL9->TL9_DTREAL)
						If TL9->TL9_DTREAL < mv_par03 .Or. TL9->TL9_DTREAL > mv_par04
							dbSelectArea("TL9")
							dbSkip()
							Loop
						EndIf
					Else
						If TL9->TL9_DTPREV < mv_par03 .Or. TL9->TL9_DTPREV > mv_par04
							dbSelectArea("TL9")
							dbSkip()
							Loop
						EndIf
					EndIf

					If lPrimeiro .Or. lin == 360

						oPrint:Box(lin,50 ,lin+50,2350 )  // Monta tabela
						oPrint:Line(lin,890,lin+50,890)   //Linha Vertical
						oPrint:Line(lin,1090,lin+50,1090) //Linha Vertical

						oPrint:Say(lin,060,STR0119,oFont12) //"Vacinas Aplicadas"
						oPrint:Say(lin,900,STR0120,oFont12) //"Data"
						oPrint:Say(lin,1100,STR0121,oFont12)//"Dose"

						SomaLinha()

						If lin == 360
							If lin+70 > 2600
								Somalinha(70,.t.)
							Endif
							SomaLinha(10)
						EndIf
						lPrimeiro := .F.
					EndIf


					oPrint:Line(lin-10,890,lin+50,890)
					oPrint:Line(lin-10,1090,lin+50,1090)

					oPrint:Say(lin,060,NGSEEK("TL6", TL9->TL9_VACINA, 1, "TL6->TL6_NOMVAC"),oFont11)
					oPrint:Say(lin,900,DTOC(TL9->TL9_DTREAL),oFont11)
					oPrint:Say(lin,1100,TL9->TL9_DOSE,oFont11)

					SomaLinha()

					DbSelectArea("TL9")
					dbskip()
					loop
				Enddo
			EndIf
		    If mv_par16 == 1
		    	DbSelectArea("TL5")
				DbSetOrder(01)//TL5_FILIAL+TL5_NUMFIC+DTOS(TL5_DTATEN)+TL5_HRATEN+TL5_INDICA+TL5_CODMED
				If DbSeek(xFilial("TL5")+TM0->TM0_NUMFIC)
					If Lin + 220 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
						SomaLinha( 220 , .T. )
						Lin -= 30
					Endif
					oPrint:Box(lin,50 ,lin+50,2350 )  // Monta tabela
					oPrint:Say(lin,060,STR0132,oFont12) //"Atend. Enfermagem"
					oPrint:Line(lin,420,lin+50,420)//Linha Vertical
					oPrint:Say(lin,440,STR0131,oFont12) //"Motivo"
					oPrint:Line(lin,1180,lin+50,1180)//Linha Vertical
					oPrint:Say(lin,1200,STR0128,oFont12) //"Medicamentos"
					oPrint:Line(lin,1860,lin+50,1860)//Linha Vertical
					oPrint:Say(lin,1880,STR0129,oFont12) //"Unid. Medida"
					oPrint:Line(lin,2080,lin+50,2080)//Linha Vertical
					oPrint:Say(lin,2100,STR0130,oFont12) //"Quantidade"
					//Caso nova página, imprime cabeçalho.
					nLinSalva := lin

					While !Eof() .And. xFilial("TL5") == TL5->TL5_FILIAL .And. TL5->TL5_NUMFIC == TM0->TM0_NUMFIC

						cLinhasMot := Alltrim(TL5->TL5_MOTIVO) + " - " + Alltrim(NgSeek("TMS",TL5->TL5_MOTIVO,1,"TMS->TMS_NOMOTI"))
						nLinMot :=  MLCOUNT(cLinhasMot,35)
						lAtend := .T. //Variavel para controle de impressão do motivo
						lAtend2 := .T. //Controla a impressão da segunda linha do motivo

						// Imprime o Medicamento
						DbselectArea("TY3")
						dbSetOrder(1)//TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED
						If dbSeek(xFilial("TY3")+TM0->TM0_NUMFIC+DTOS(TL5->TL5_DTATEN)+TL5->TL5_HRATEN)
							While !Eof() .And. xFilial("TY3") == TY3->TY3_FILIAL .And. TY3->TY3_NUMFIC == TM0->TM0_NUMFIC .And.;
														DTOS(TY3->TY3_DTATEN) == DTOS(TL5->TL5_DTATEN) .And. TY3->TY3_HRATEN == TL5->TL5_HRATEN
								cLinhasMed := Alltrim(TY3->TY3_CODMED) + " - " + Alltrim(NgSeek("TM1",TY3->TY3_CODMED,1,"TM1->TM1_NOMEDI"))
								nLinMed :=  MLCOUNT(cLinhasMed,30)

								nContImp := If( nLinMot >= nLinMed , nLinMot , nLinMed )//Verifica a quantidade de linhas que será impressa.

								//Caso nova página, imprime cabeçalho.
								If Lin + 220 > 2600 //Caso o espaço que for utilizado para impressão ultrapasse o tamanho da pg, efetua a quebra de pg.
									oPrint:Line( nLinSalva , 420  , lin+100 , 420  ) //Linha Vertical
									oPrint:Line( nLinSalva , 1180 , lin+100 , 1180 ) //Linha Vertical
									oPrint:Line( nLinSalva , 1860 , lin+100 , 1860 ) //Linha Vertical
									oPrint:Line( nLinSalva , 2080 , lin+100 , 2080 ) //Linha Vertical
									SomaLinha( 220 , .T. )
									Lin -= 30
									nLinSalva := lin //Salva linha atual
								Endif


								For nLinhaCorrente := 1 To nContImp

									If nLinhaCorrente == 1 //Caso seja a primeira linha
										If nLinBck == 2 .Or. nLinMot == 1
											Somalinha()
										Endif
										If lAtend
											oPrint:Say(lin,060,DTOC(TL5->TL5_DTATEN) + " - " + TL5->TL5_HRATEN,oFont11)//Data do Atendimento de Enfermagem
											oPrint:Say(lin,450,Memoline(cLinhasMot,35,nLinhaCorrente),oFont11)
											lAtend := .F.
										EndIf
										oPrint:Say(Lin,1200,Memoline(cLinhasMed,30,nLinhaCorrente),oFont11)
										oPrint:Say(Lin,1900,Alltrim(NgSeek("TM1",TY3->TY3_CODMED,1,"TM1->TM1_UNIDAD")),oFont11) //Unid. Medida
										oPrint:Say(Lin,2100,cValtochar(TY3->TY3_QUANT ),oFont11) //Quantidade
									ElseIf nLinhaCorrente == 2
										nLinBck := nLinMed
										Somalinha()
										If nLinMot > 1 .And. lAtend2
											oPrint:Say(lin,450,Memoline(cLinhasMot,35,nLinhaCorrente),oFont11)
											lAtend2 := .F.
										EndIf
										If nLinMed > 1
											oPrint:Say(Lin,1200,Memoline(cLinhasMed,30,nLinhaCorrente),oFont11)
										EndIf
									EndIf

								Next nLinhaCorrente
								TY3->(dbSkip())
							End
						Else //Caso não tenham medicamento.
							For nLinhaCorrente := 1 To nLinMot
								If nLinhaCorrente == 1  //Caso seja a primeira linha
									oPrint:Say(lin,060,DTOC(TL5->TL5_DTATEN) + " - " + TL5->TL5_HRATEN,oFont11)//Data do Atendimento de Enfermagem
								EndIf
								oPrint:Say(lin,450,Memoline(cLinhasMot,35,nLinhaCorrente),oFont11)
								Somalinha()
							Next nLinhaCorrente
						Endif
						oPrint:Line( nLinSalva , 420  , lin+50 , 420  ) //Linha Vertical
						oPrint:Line( nLinSalva , 1180 , lin+50 , 1180 ) //Linha Vertical
						oPrint:Line( nLinSalva , 1860 , lin+50 , 1860 ) //Linha Vertical
						oPrint:Line( nLinSalva , 2080 , lin+50 , 2080 ) //Linha Vertical

						SomaLinha()

						TL5->(dbSkip())
					End
				EndIf

		    Endif

			If lin+330 > 2600 //Caso seja maior que a página.
				oPrint:Line(lin,50,lin,2350)
				Somalinha(330,.t.)
			Endif

			//Imprime espaco para assinatura do medico e do paciente
			oPrint:Line(lin,50,lin,2350)
			oPrint:Line(lin+60,50,lin+60,2350)
			oPrint:Say(lin+10,60,STR0113,oFont12)//"Assinatura Do Médico"

			SomaLinha(220)

			oPrint:Line(lin,400,lin,940)

			oPrint:Line(lin,1400,lin,1940)
			nNome   := len(Alltrim(SRA->RA_NOME)) * 22
			nEspaco := (550 - (nNome))/2
			If nNome > 0
				oPrint:Say(lin+10,1400+nEspaco,Alltrim(SRA->RA_NOME),oFont11)
			Else
				oPrint:Say(lin+10,1400,Alltrim(SRA->RA_NOME),oFont11)
			EndIf

			SomaLinha(110)
			oPrint:Line(150,50,lin,50)
			oPrint:Line(150,2350,lin,2350)
			oPrint:Line(lin,50,lin,2350)
		    oPrint:EndPage()
	    Next
		dbselectarea("TM0")
	    dbskip()
	EndDo

	RetIndex("TM1")
	Set Filter To
	Set device to Screen

	If aReturn[5] == 1
		oPrint:Preview()
	Else
		oPrint:Print()
	Endif

	MS_FLUSH()

	RestArea(aArea)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@type Static Function
@author  Inacio Luiz Kolling
@since   06/1997

@sample  Somalinha(1, .T.)

@param   Linhas, linha posicionada
@param   LSimulacao

@return Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha(linhas,lSimulacao)

Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

Default linhas := 50

If lSigaMdtps

	If mv_par17 == 2
		lin += linhas
		If lin > 2600
			If lSimulacao
				lin -= linhas
			Endif
			oPrint:Line(150,50,lin,50)
			oPrint:Line(150,2350,lin,2350)
			oPrint:Line(lin,50,lin,2350)
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 180
			oPrint:Line(150,50,150,2350)
			oPrint:Line(323,50,323,2350)
			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+cSMFIL+".BMP",400,165)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+".BMP",400,165)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",400,165)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+".BMP",400,165)
			Endif
			oPrint:Say(lin+30,800,STR0053,oFont16) //"FICHA MÉDICA E PRONTUÁRIO"
			lin+=180
		EndIf
	Else
	    Li += 1
	    If Li > 58
	        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	    EndIf
	Endif

Else

	If mv_par13 == 2
		lin += linhas
		If lin > 2600
			If lSimulacao
				lin -= linhas
			Endif
			oPrint:Line(150,50,lin+100,50)
			oPrint:Line(150,2350,lin+100,2350)
			oPrint:Line(lin+100,50,lin+100,2350)
			oPrint:EndPage()
			oPrint:StartPage()
			lin := 180
			oPrint:Line(150,50,150,2350)
			oPrint:Line(323,50,323,2350)
			If File("LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+cSMFIL+".BMP",400,165)
			ElseIf File("LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"LGRL"+cSMCOD+".BMP",400,165)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+cSMFIL+".BMP",400,165)
			ElseIf File("\SIGAADV\LGRL"+cSMCOD+".BMP")
				oPrint:SayBitMap(155,55,"\SIGAADV\LGRL"+cSMCOD+".BMP",400,165)
			Endif
			oPrint:Say(lin+30,800,STR0053,oFont16) //"FICHA MÉDICA E PRONTUÁRIO"
			lin+=180
		EndIf
	Else
	    Li += 1
	    If Li > 58
	        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	    EndIf
	Endif

Endif

Return
