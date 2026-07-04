/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR475.ch"
#Include "Protheus.ch"
#Include "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR475  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do PCMSO Anual.                                   ³±±
±±³          ³Demonstra estatisticamente por setor e pela natureza do     ³±±
±±³          ³exame, a quantidade de exames realizados, bem como a quanti-³±±
±±³          ³dade que apresentou  resultados anormais. Atraves dos       ³±±
±±³          ³parametros o usuario devera informa o numero do pcmso que   ³±±
±±³          ³deseja listar no mapa anual, tambem o indice de acrescimo de³±±
±±³          ³exames previstos  para o ano seguinte.                      ³±±
±±³          ³Para emissao o programa deve ler as seguintes tabelas:      ³±±
±±³          ³ TMW - Parametros do PCMSO                                  ³±±
±±³          ³ TM5 - Exames do PCMSO                                      ³±±
±±³          ³       Classificado por c.custo e natureza do exame.        ³±±
±±³          ³ SI3 - Nome do centro de custo                              ³±±
±±³          ³ Da tabela TM5 considerar apenas os registros com o campo   ³±±
±±³          ³ TM5_PCMSO = AO PCMSO informado nos parametros e se o campo ³±±
±±³          ³ data do resultado estive prenchido.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR475void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR475()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR475"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio Anual do Programa de Saude Ocupacional - PCMSO             "
LOCAL cDesc2  := STR0002 //"Demonstrativo por setor e natureza da quantidade de exames realizados"
LOCAL cDesc3  := STR0003 //"com resultados normais e anormais.                                   "
LOCAL cString := "TM5"
	Local cOrdSX1 := "00"

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE nomeprog := "MDTR475"
PRIVATE tamanho  := "M"
PRIVATE ntamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006   //"Relatorio Anual do PCMSO"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := PadR( If(!lSigaMdtPS,"MDT475","MDT475PS"), 10 )
PRIVATE cabec1   := " "
PRIVATE cabec2   := " "
Private aVetinr  := {}, nIndTRB

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private lTMW_Filial := If( Empty(xFilial("TMW")) .and. !Empty(xFilial("SRA")) , .t. , .f. ) //Indica se o PCMSO é para varias filiais
PRIVATE lMV_NGMDTPS := .f.
PRIVATE nSizeSI3
Private nSizeSQB
Private nSizeSRJ
Private nTamExa
Private Lin := 300

nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
nSizeSQB := If((TAMSX3("QB_DEPTO")[1]) < 1,5,(TAMSX3("QB_DEPTO")[1]))
nTamExa	:= If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

cAliasCC := "CTT"
cDescCC2 := "CTT->CTT_DESC01"
nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))

If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lMV_NGMDTPS := .t.
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*--------------------------------
//PERGUNTAS PADRÃO               |
| 01 De PCMSO ?                  |
| 02 Ate PCMSO ?                 |
| 03 De Centro de Custo ?        |
| 04 Ate Centro de Custo ?       |
| 05 Exames Proximo Ano ?        |
| 06 Classificar por ?           |
| 07 Imprimir Exames NR7 ?       |
| 08 Listar Exames Proximo Ano?  |
----------------------------------*/

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR475"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If aReturn[4] == 2
	tamanho  := "G"
	ntamanho := "G"
Endif

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| U_R475Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL

User Function R475Imp(lEnd,wnRel,titulo,tamanho)

	Local oFonTit 		:= TFont():New( 'Verdana', 28, 28, Nil,.T., Nil, Nil, Nil, .F., .F. )
	Local oFonCabNeg 	:= TFont():New( 'Verdana', 11, 11, Nil, .T., Nil, Nil, Nil, .F., .F. )
	Local oFonCabNor  	:= TFont():New( 'Verdana', 11, 11, Nil, .F., Nil, Nil, Nil, .F., .F. )

	Private oFonNeg 	:= TFont():New( 'Verdana', 09, 09, Nil,.T., Nil, Nil, Nil,.F., .F. )
	Private oFonNor		:= TFont():New( 'Verdana', 09, 09, Nil,.F., Nil, Nil, Nil,.F., .F. )

	Private oImprime	:= FWMSPrinter():New( STR0018, IMP_PDF, Nil, Nil, .T. ) // "PCMSO"

	oImprime:SetParm( '-RFS' )
	oImprime:SetResolution( 72 )
	oImprime:SetPortrait()
	oImprime:SetPaperSize( DMPAPER_A4 )
	oImprime:SetMargin( 10, 10, 10, 10 )

	oImprime:StartPage()

	SomaLinha()

	oImprime:Say( 1200, 300, MemoLine( STR0001, 33, 1 ), oFonTit, Nil, Nil, Nil, 2 ) // "Relatório Anual do Programa de Saúde Ocupacional"
	oImprime:Say( 1400, 650, MemoLine( STR0001, 33, 2 ), oFonTit, Nil, Nil, Nil, 2 ) // "Relatório Anual do Programa de Saúde Ocupacional"

	oImprime:Say( 2540, 100, STR0085 + ': ', oFonCabNeg ) // "Grupo de empresa"
	oImprime:Say( 2540, 480, SM0->M0_NOMECOM, oFonCabNor )
	oImprime:Say( 2620, 100, STR0086 + ': ', oFonCabNeg ) // "Filial"
	oImprime:Say( 2620, 300, SM0->M0_FILIAL, oFonCabNor)
	oImprime:Say( 2700, 100, STR0087 + ': ', oFonCabNeg ) // "Data de emissão"
	oImprime:Say( 2700, 470, DtoC( Date() ), oFonCabNor )

	oImprime:EndPage()
	oImprime:StartPage()

	fBusExa()

	oImprime:Print()

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fBusExa
Atalho de exames

@author	Gabriel Sokacheski
@since 14/11/2023

/*/
//---------------------------------------------------------------------
Static Function fBusExa()

	Local aTotal		:= {}
	Local aExaAnt		:= {}
	Local aExaAtu		:= {}
	Local aTotNat		:= {}
	Local aRetBusExa	:= {} // Retorno da busca de exames

	Local cAntIni		:= Mv_par16 // Código inicial do PCMSO anterior
	Local cAntFim 		:= Mv_par17 // Código final do PCMSO anterior
	Local cAtuIni		:= Mv_par01 // Código inicial do PCMSO atual
	Local cAtuFim 		:= Mv_par02 // Código final do PCMSO atual

	Local dIniPrg		:= CtoD( '' )
	Local dFimPrg 		:= CtoD( '' )
	Local dIniAnt		:= CtoD( '' )
	Local dFimAnt 		:= CtoD( '' )

	fDefDatAnt( cAtuIni, cAtuFim, @dIniPrg, @dFimPrg ) // Define as datas do PCMSO atual
	fDefDatAnt( cAntIni, cAntFim, @dIniAnt, @dFimAnt ) // Define as datas do PCMSO anterior

	aExaAnt := fRetExa( cAntIni, cAntFim, dIniAnt, dFimAnt )[ 1 ] // Exames do PCMSO anterior

	aRetBusExa := fRetExa( cAtuIni, cAtuFim, dIniPrg, dFimPrg )

	aExaAtu	:= aRetBusExa[ 1 ] // Exames do PCMSO atual
	aTotNat := aRetBusExa[ 2 ] // Totais por natureza
	aTotal 	:= aRetBusExa[ 3 ] // Totais da empresa

	fImpExa( { DtoC( dIniAnt ), DtoC( dFimAnt ), DtoC( dIniPrg ), DtoC( dFimPrg ) }, aExaAnt, aExaAtu )

	fImpNatExa( aTotNat )

	fImpTotExa( aTotal )

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDefDatAnt
Busca as informações do PCMSO

@author Gabriel Sokacheski
@since 24/10/2023

@param cIni, pcmso inicial
@param cFim, pcmso final
@param dIni, variável a ser gravada a data de início
@param dFim, variável a ser gravada a data de fim

/*/
//---------------------------------------------------------------------
Static Function fDefDatAnt( cIni, cFim, dIni, dFim )

	Local aArea := ( 'TMW' )->( GetArea() )

	DbSelectArea( 'TMW' )
	( 'TMW' )->( DbSetOrder( 1 ) )
	( 'TMW' )->( DbGoTop() )

	If ( 'TMW' )->( DbSeek( xFilial( 'TMW' ) + cIni ) )

		dIni := TMW->TMW_DTINIC
		dFim := TMW->TMW_DTFIM

		While ( 'TMW' )->( !Eof() ) .And. TMW->TMW_FILIAL == xFilial( 'TMW' ) .And. TMW->TMW_PCMSO >= cIni .And. TMW->TMW_PCMSO <= cFim

			If TMW->TMW_DTINIC < dIni
				dIni := TMW->TMW_DTINIC
			EndIf

			If TMW->TMW_DTFIM > dFim
				dFim := TMW->TMW_DTFIM
			EndIf

			( 'TMW' )->( DbSkip() )

		End

	EndIf

	RestArea( aArea )

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fRetExa
Retorna os exames que serão impressos no atalho de exames

@author Gabriel Sokacheski
@since 14/11/2023

@param cIni, código inicial do PCMSO a ser buscado
@param cFim, código final do PCMSO a ser buscado
@param dIni, data de início do PCMSO
@param dFim, data de fim do PCMSO

@return aArray, array contendo listas com as informações necessárias
/*/
//---------------------------------------------------------------------
Static Function fRetExa( cIni, cFim, dIni, dFim )

	Local aExame 		:= {} // Lista com todos os exames do PCMSO
	Local aNatureza		:= {} // Lista os exames por natureza
	Local aTotal		:= { 0, 0, 0 } // Totais da empresa dos exames do PCMSO

	Local cSetor 		:= ''
	Local cExame 		:= ''
	Local cNatureza 	:= ''

	Local nExame		:= 0 // Quantidade realizada do exame
	Local nSetor 		:= mv_par12 // Considerar por? 1=Centro de custo;2=Departamento;
	Local nResAno		:= 0 // Número de resultados anormais do exame

	DbSelectArea( 'TMW' )
	( 'TMW' )->( DbSetOrder( 01 ) )

	If ( 'TMW' )->( DbSeek( xFilial( 'TMW' ) + cIni ) )

		While ( 'TMW' )->( !Eof() ) .And. TMW->TMW_FILIAL == xFilial( 'TMW' ) .And. TMW->TMW_PCMSO <= cFim

			DbSelectArea( 'TM5' )
			( 'TM5' )->( DbSetOrder( 03 ) )

			If ( 'TM5' )->( DbSeek( xFilial( 'TM5' ) + TMW->TMW_PCMSO ) )

				While ( 'TM5' )->( !Eof() ) .And. TM5->TM5_FILIAL == xFilial( 'TM5' ) .And. TM5->TM5_PCMSO == TMW->TMW_PCMSO
				
					If TM5->TM5_DTPROG >= dIni .And. TM5->TM5_DTPROG <= dFim .And. !Empty( TM5->TM5_DTRESU );
					.And. ( nSetor == 2 .Or. ( !Empty( TM5->TM5_CC ) .And. TM5->TM5_CC >= mv_par03 .And. TM5->TM5_CC <= mv_par04 ) );
					.And. ( mv_par07 == 1 .Or. AllTrim( TM5->TM5_EXAME ) != 'NR7' )

						//----------------------
						// Informações do exame
						//----------------------

						If nSetor == 2

							cSetor := Posicione( 'TM0', 1, xFilial( 'TM0' ) + TM5->TM5_NUMFIC, 'TM0_DEPTO' )

							If cSetor < mv_par13 .Or. cSetor > mv_par14
								( 'TM5' )->( Dbskip() )
								Loop
							EndIf

							cSetor := AllTrim( Capital( Posicione( 'SQB', 1, xFilial( 'SQB' ) + cSetor, 'QB_DESCRIC' ) ) )

						Else
							cSetor := AllTrim( Capital( Posicione( 'CTT', 1, xFilial( 'CTT' ) + TM5->TM5_CC, 'CTT_DESC01' ) ) )
						EndIf

						If TM5->TM5_INDRES == '2' // Resultado alterado (não normal/anormal)
							nResAno := 1
						EndIf

						cExame := AllTrim( Capital( Posicione( 'TM4', 1, xFilial( 'TM4' ) + TM5->TM5_EXAME, 'TM4_NOMEXA' ) ) )

						Do Case
							Case TM5->TM5_NATEXA == '1'
								cNatureza := 'Admissional'
							Case TM5->TM5_NATEXA == '2'
								cNatureza := 'Periódico'
							Case TM5->TM5_NATEXA == '3'
								cNatureza := 'Mudança de riscos ocupacionais'
							Case TM5->TM5_NATEXA == '4'
								cNatureza := 'Retorno ao trabalho'
							Case TM5->TM5_NATEXA == '5'
								cNatureza := 'Demissional'
							Case TM5->TM5_NATEXA == '6'
								cNatureza := 'Monitoramento pontual'
						EndCase

						// Caso não exista este exame no array, adiciona
						If ( nExame := aScan( aExame, { | exame | exame[ 1 ] == cSetor .And. exame[ 2 ] == cExame } ) ) == 0

							aAdd( aExame, {;
								cSetor,;				// [1] Setor
								cExame,;				// [2] Exame
								1,;						// [3] Exames realizados
								nResAno,;				// [4] Resultados anormais
								( nResAno / 1 ) * 100;	// [5] Percentual anormal
							} )

						// Caso exista, altera os totalizadores do exame no array
						Else

							aExame[ nExame, 3 ] += 1 													// [3] Exames realizados
							aExame[ nExame, 4 ] += nResAno 												// [4] Resultados anormais
							aExame[ nExame, 5 ] := ( aExame[ nExame, 4 ] / aExame[ nExame, 3 ] ) * 100	// [5] Percentual anormal

						EndIf

						If mv_par11 != 4

							// Caso não exista este exame no array, adiciona
							If ( nExame := aScan( aNatureza, { | exame | exame[ 1 ] == cNatureza .And. exame[ 2 ] == cExame } ) ) == 0

								aAdd( aNatureza, {;
									cNatureza,;				// [1] Setor
									cExame,;				// [2] Exame
									1,;						// [3] Exames realizados
									nResAno,;				// [4] Resultados anormais
									( nResAno / 1 ) * 100;	// [5] Percentual anormal
								} )

							// Caso exista, altera os totalizadores do exame no array
							Else

								aNatureza[ nExame, 3 ] += 1 														// [3] Exames realizados
								aNatureza[ nExame, 4 ] += nResAno 													// [4] Resultados anormais
								aNatureza[ nExame, 5 ] := ( aNatureza[ nExame, 4 ] / aNatureza[ nExame, 3 ] ) * 100	// [5] Percentual anormal

							EndIf

						EndIf

						//-------------------
						// Totais da empresa
						//-------------------
						aTotal[ 1 ] += 1
						aTotal[ 2 ] += nResAno
						aTotal[ 3 ] := ( aTotal[ 2 ] / aTotal[ 1 ] ) * 100

						nResAno := 0

					EndIf

					( 'TM5' )->( Dbskip() )

				End

			EndIf

			( 'TMW' )->( Dbskip() )

		End

	EndIf

	If !Empty( aExame ) // Ordena o array de forma cresente pelo setor dos exames
		aSort( aExame, Nil, Nil, { | x, y | x[ 1 ] + x[ 2 ] < y[ 1 ] + y[ 2 ] } )
	EndIf

	If !Empty( aNatureza ) // Ordena o array de forma cresente pela natureza dos exames
		aSort( aNatureza, Nil, Nil, { | x, y | x[ 1 ] + x[ 2 ] < y[ 1 ] + y[ 2 ] } )
	EndIf

	If !Empty( aTotal ) // Converte os totais para caractere
		aTotal[ 1 ] := AllTrim( Str( aTotal[ 1 ] ) )
		aTotal[ 2 ] := AllTrim( Str( aTotal[ 2 ] ) )
		aTotal[ 3 ] := AllTrim( Str( aTotal[ 3 ] ) ) + '%'
	EndIf

Return { aExame, aNatureza, aTotal }

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpExa
Imprime o atalho de exames

@author Gabriel Sokacheski
@since 16/11/2023

@param aDatas, datas de início e fim do PCMSO anterior e atual
@param aExaAnt, exames do PCMSO anterior
@param aExaAtu, exames do PCMSO atual

/*/
//---------------------------------------------------------------------
Static Function fImpExa( aDatas, aExaAnt, aExaAtu )


	Local nExaAtu 		:= 0 // Posição no array do exame no período atual
	Local nExaAnt 		:= 0 // Posicão no array do exame equivalente no período anterior
	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	SomaLinha()
	oImprime:Say( lin + nImpVal, 1200, STR0078, oFonNeg ) // "Exames"

	For nExaAtu := 1 To Len( aExaAtu )

		SomaLinha()

		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 820, lin + 60, 820 )

		oImprime:Say( lin + nImpVal, 170, STR0079, oFonNeg ) // "Setor"
		oImprime:Say( lin + nImpVal, 840, aExaAtu[ nExaAtu, 1 ], oFonNor )

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 820, lin + 60, 820 )
		oImprime:Say( lin + nImpVal, 170, STR0080, oFonNeg ) // "Exame"
		oImprime:Say( lin + nImpVal, 840, aExaAtu[ nExaAtu, 2 ], oFonNor )

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 1200, lin + 60, 1200 )
		oImprime:Say( lin + nImpVal, 450, aDatas[ 1 ] + ' - ' + aDatas[ 2 ], oFonNeg )
		oImprime:Say( lin + nImpVal, 1600, aDatas[ 3 ] + ' - ' + aDatas[ 4 ], oFonNeg )

		SomaLinha()

		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 440, lin + 60, 440 )
		oImprime:Line( lin, 770, lin + 60, 770 )
		oImprime:Line( lin, 1200, lin + 60, 1200 )
		oImprime:Line( lin, 1530, lin + 60, 1530 )
		oImprime:Line( lin, 1920, lin + 60, 1920 )
		oImprime:Say( lin + nImpVal, 170, STR0081, oFonNeg ) // "Exames realizados"
		oImprime:Say( lin + nImpVal, 460, STR0082, oFonNeg ) // "Resultados anormais"
		oImprime:Say( lin + nImpVal, 830, STR0083, oFonNeg ) // "Percentual anormais"
		oImprime:Say( lin + nImpVal, 1240, STR0081, oFonNeg ) // "Exames realizados"
		oImprime:Say( lin + nImpVal, 1580, STR0082, oFonNeg ) // "Resultados anormais"
		oImprime:Say( lin + nImpVal, 1940, STR0083, oFonNeg ) // "Percentual anormais"

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 440, lin + 60, 440 )
		oImprime:Line( lin, 770, lin + 60, 770 )
		oImprime:Line( lin, 1200, lin + 60, 1200 )
		oImprime:Line( lin, 1530, lin + 60, 1530 )
		oImprime:Line( lin, 1920, lin + 60, 1920 )

		// Procura no array de exames do PCMSO anterior o exame equivalente ao atual
		If ( nExaAnt := aScan( aExaAnt, { | exame | exame[ 1 ] == aExaAtu[ nExaAtu, 1 ] .And. exame[ 2 ] == aExaAtu[ nExaAtu, 2 ] } ) ) > 0

			oImprime:Say( lin + nImpVal, 170, AllTrim( Str( aExaAnt[ nExaAnt, 3 ] ) ), oFonNor )
			oImprime:Say( lin + nImpVal, 460, AllTrim( Str( aExaAnt[ nExaAnt, 4 ] ) ), oFonNor )
			oImprime:Say( lin + nImpVal, 830, AllTrim( Str( aExaAnt[ nExaAnt, 5 ] ) + '%' ), oFonNor )

		Else // Define os totalizadores como zero caso não exista um exame equivalente

			oImprime:Say( lin + nImpVal, 170, '0', oFonNor )
			oImprime:Say( lin + nImpVal, 460, '0', oFonNor )
			oImprime:Say( lin + nImpVal, 830, '0%', oFonNor )

		EndIf

		oImprime:Say( lin + nImpVal, 1240, AllTrim( Str( aExaAtu[ nExaAtu, 3 ] ) ), oFonNor )
		oImprime:Say( lin + nImpVal, 1580, AllTrim( Str( aExaAtu[ nExaAtu, 4 ] ) ), oFonNor )
		oImprime:Say( lin + nImpVal, 1940, AllTrim( Str( aExaAtu[ nExaAtu, 5 ] ) + '%' ), oFonNor )
		SomaLinha()

	Next nExaAtu

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpNatExa
Imprime os exames por natureza

@author Gabriel Sokacheski
@since 03/09/2024

@param aTotal, totais por natureza

/*/
//---------------------------------------------------------------------
Static Function fImpNatExa( aTotal )

	Local nExame		:= 0
	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	For nExame := 1 To Len( aTotal )

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 820, lin + 60, 820 )
		oImprime:Say( lin + nImpVal, 170, STR0088, oFonNeg ) // "Natureza"
		oImprime:Say( lin + nImpVal, 840, aTotal[ nExame, 1 ], oFonNor )

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 820, lin + 60, 820 )
		oImprime:Say( lin + nImpVal, 170, STR0080, oFonNeg ) // "Exame"
		oImprime:Say( lin + nImpVal, 840, aTotal[ nExame, 2 ], oFonNor )

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 1020, lin + 60, 1020 )
		oImprime:Line( lin, 1570, lin + 60, 1570 )
		oImprime:Say( lin + nImpVal, 170, STR0081, oFonNeg ) // "Exames realizados
		oImprime:Say( lin + nImpVal, 1040, STR0082, oFonNeg ) // "Resultados anormais"
		oImprime:Say( lin + nImpVal, 1610, STR0083, oFonNeg ) // "Percentual anormais"

		SomaLinha()
		oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
		oImprime:Line( lin, 1020, lin + 60, 1020 )
		oImprime:Line( lin, 1570, lin + 60, 1570 )
		oImprime:Say( lin + nImpVal, 170, AllTrim( Str( aTotal[ nExame, 3 ] ) ), oFonNor )
		oImprime:Say( lin + nImpVal, 1040, AllTrim( Str( aTotal[ nExame, 4 ] ) ), oFonNor )
		oImprime:Say( lin + nImpVal, 1610, AllTrim( Str( aTotal[ nExame, 5 ] ) ) + '%', oFonNor )

		SomaLinha()

	Next nExame

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fImpTotExa
Imprime os totais dos exames da empresa do PCMSO

@author Gabriel Sokacheski
@since 29/11/2023

@param aTotal, estátisticas dos exames do PCMSO da empresa

/*/
//---------------------------------------------------------------------
Static Function fImpTotExa( aTotal )

	Local nMarEsq		:= 150 // Margem esquerda mínima
	Local nMarDir		:= 2250 // Margem direita máxima
	Local nImpVal 		:= 40 // Meio da linha

	SomaLinha()
	oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
	oImprime:Say( lin + nImpVal, 1150, STR0084, oFonNeg ) // "Totais da empresa"

	SomaLinha()
	oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
	oImprime:Line( lin, 1020, lin + 60, 1020 )
	oImprime:Line( lin, 1570, lin + 60, 1570 )
	oImprime:Say( lin + nImpVal, 170, STR0081, oFonNeg ) // "Exames realizados
	oImprime:Say( lin + nImpVal, 1040, STR0082, oFonNeg ) // "Resultados anormais"
	oImprime:Say( lin + nImpVal, 1610, STR0083, oFonNeg ) // "Percentual anormais"

	SomaLinha()
	oImprime:Box( lin, nMarEsq, lin + 60, nMarDir )
	oImprime:Line( lin, 1020, lin + 60, 1020 )
	oImprime:Line( lin, 1570, lin + 60, 1570 )
	oImprime:Say( lin + nImpVal, 170, aTotal[ 1 ], oFonNor )
	oImprime:Say( lin + nImpVal, 1040, aTotal[ 2 ], oFonNor )
	oImprime:Say( lin + nImpVal, 1610, aTotal[ 3 ], oFonNor )

	SomaLinha()

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Pula linha

@author Gabriel Sokacheski
@since 30/08/2024

/*/
//---------------------------------------------------------------------
Static Function SomaLinha()

	Lin += 60

	If Lin > 3000
		Lin := 300
		oImprime:EndPage()
		oImprime:StartPage()
	EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT475FLVL³ Autor ³ Denis Hyroshi        ³ Data ³ 04/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os campos De/Ate Filial                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT475FLVL(nTipo)
Local lRet := .T.
Local cArea := Alias()
Local aArea := SM0->(GetArea())

If nTipo == 1
	If !Empty(Mv_par09)
		dbSelectArea("SM0")
		If !dbSeek(cEmpAnt+Mv_par09)
			Help(" ",1,"REGNOIS")
			lRet := .F.
		Endif
		If Mv_par09 > Mv_par10
			Mv_par10 := Mv_par09
		Endif
	Endif
Else
	If Mv_par10 <> Replicate("Z",Len(Mv_par10)) .and. Mv_par10 <> Replicate("9",Len(Mv_par10))
		If Mv_par09 > Mv_par10
			Help(" ",1,"DEATEINVAL")
			lRet := .F.
		Else
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par10)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
		Endif
	Endif
Endif

RestArea(aArea)
dbSelectArea(cArea)

Return lRet

/*
          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³<XXXXXXXXXXXXXXX>      Relatorio anual do PCMSO   Periodo: dd/mm/aa a dd/dd/aa 														   ³
³SIGA/MDTR475                                      Emissao: dd/mm/aa   hh:mm    														   ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³
³Responsavel.....: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          CRM.: xxxxxxxxxxx    														   ³
³                                                                               														   ³
³Assinatura......: _____________________________           Data: xx/xx/xx       														   ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
|Setor/Funcao/Exame                                   |    Natureza     |   Exames   | Resultados | Anormais x 100 | Exames p/Ano  |
³                                                     ³                 ³ Realizados ³  Anormais  ³  /Realizados   ³   Seguinte    ³
|_____________________________________________________|_________________|____________|____________|________________|_______________|
³XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX             ³                 ³            ³            ³                ³               ³
³      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX       ³                 ³            ³            ³                ³               ³
³             XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX³ Demiss          ³   99.999   ³   99.999   ³    999.99      ³    99.999     ³
³                                                     ³ Retorno         ³   99.999   ³   99.999   ³    999.99      ³    99.999     ³
³                                                     ³ Mudanca         ³   99.999   ³   99.999   ³    999.99      ³    99.999     ³
³                                                     ³ Periodico       ³   99.999   ³   99.999   ³    999.99      ³    99.999     ³
|_____________________________________________________|_________________|____________|____________|________________|_______________|
*/
User Function MDT475PREX1()
Local lRet

lRet := If(Empty(mv_par03),.t.,ExistCpo(cAliasCC,mv_par03))
If !lRet
	Return .f.
Endif

If lMV_NGMDTPS
	If Empty(mv_par03)
		MsgStop(STR0031+; //"Essa empresa esta cadastrada como Prestadora de Servico, portanto as 6 primeiras "
    			STR0032+; //"posicoes dos parametros: 'De Centro de Custo' e 'Ate Centro de Custo' referem-se "
    			STR0033)  //"ao codigo do cliente e devem ser preenchidas com o mesmo valor."
		Return .f.
	Endif
Endif
Return .t.
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
User Function PREX2MDT475()
Local cVar3 := Substr(mv_par03,1,6)
Local cVar4 := Substr(mv_par04,1,6)
Local lRet

lRet := If(atecodigo(cAliasCC,mv_par03,mv_par04,nSizeSI3),.t.,.f.)
If !lRet
	Return .f.
Endif

If lMV_NGMDTPS
	If Empty(mv_par04) .or. (!Empty(cVar3) .and. (cVar3 != cVar4))
		MsgStop(STR0031+; //"Essa empresa esta cadastrada como Prestadora de Servico, portanto as 6 primeiras "
    			STR0032+; //"posicoes dos parametros: 'De Centro de Custo' e 'Ate Centro de Custo' referem-se "
    			STR0033)  //"ao codigo do cliente e devem ser preenchidas com o mesmo valor."
		Return .f.
	Endif
Endif
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³MDTCBOX   ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 27.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Combo Box para exibir na tela                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_MDTCbox(cCampo)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com combo box                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Campo que tera o Combo Box anexado                 ³±±
±±³          ³ ExpC2 = String contendo item a nao ser apresentado "56"    ³±±
±±³          ³ ExpN1 = Tamanho a ser verificado a cada item da string     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTCbox(cCampo,cForaCombo,nLenGrava)

Local aArray1	:= {}
Local aArray2	:= {}
Local aSaveArea	:= GetArea()

Local cVar, nCont

DEFAULT cForaCombo := ""
DEFAULT nLenGrava  := 1

dbSelectArea("SX3")
dbSetOrder(2)
MsSeek(cCampo)

cVar 	:= X3CBox()

If Empty(cVar)
	Return aArray2
Endif

aArray1	:= RetSx3Box(cVar,,,1)

For nCont := 1 To Len(aArray1)
	If cForaCombo <> "" .And. Left(aArray1[nCont][1], nLenGrava) $ cForaCombo
		Loop
	Endif
	AADD(aArray2,aArray1[nCont][1])
Next nCont

RestArea(aSaveArea)

Return aArray2
