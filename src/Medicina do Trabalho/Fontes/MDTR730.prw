/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr730.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR730
Relatório da Ficha Clinica

@type Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@sample  U_MDTR730()

@return Nil, Sempre nulo
/*/
//---------------------------------------------------------------------
User Function MDTR730()

Local aNGBEGINPRM := NGBEGINPRM()

Local cPerg := ""

Private lSigaMdtPS := IIf( SuperGetMv( "MV_MDTPS", .F., "N" ) == "S", .T., .F. )

cPerg := IIf( !lSigaMdtPS, "MDT730    ", "MDT730PS  " )

If !MDTRESTRI( cPrograma )
	NGRETURNPRM( aNGBEGINPRM )
	Return .F.
EndIf


/* Perguntas
//---------------------------------------------------------------------
 01  Tipo Impressao ?
 02  De Ficha Medica ?
 03  Ate Ficha Medica ?
 04  De Data Atendimento ?
 05  Ate Data Atendimento ?
 06  Indicacao de Atendimento ?
/*/
//---------------------------------------------------------------------


If pergunte(cPerg,.t.)
	MDT730IMP()
EndIf

NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT730IMP
Chamada do Relatório.

@type Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@return .T.
/*/
//---------------------------------------------------------------------
Static Function MDT730IMP()
Local oPrint

Local xm_par01 := IIf( lSigaMdtPs, mv_par05, mv_par01 )

Private cAlias := "SI3"
Private cDescr := "SI3->I3_DESC"

Private lin := 0

Private oFont06 := TFont():New( "Courier New", 08, 08, , .F., , , , .F., .F. )
Private oFont07 := TFont():New( "Courier New", 07, 07, , .F., , , , .F., .F. )
Private oFont08 := TFont():New( "Courier New", 08, 08, , .T., , , , .F., .F. )
Private oFont09 := TFont():New( "Courier New", 09, 09, , .T., , , , .F., .F. )
Private oFont10 := TFont():New( "Courier New", 10, 10, , .F., , , , .F., .F. )
Private oFont11 := TFont():New( "Courier New", 11, 11, , .F., , , , .F., .F. )
Private oFont12 := TFont():New( "Courier New", 12, 12, , .T., , , , .F., .F. )
Private oFont13 := TFont():New( "Courier New", 13, 13, , .F., , , , .F., .F. )
Private oFont14 := TFont():New( "Courier New", 14, 14, , .T., , , , .F., .F. )
Private oFont15 := TFont():New( "Courier New", 15, 15, , .T., , , , .F., .F. )


If Alltrim( GETMV( "MV_MCONTAB" ) ) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
EndIf

oPrint := TMSPrinter():New( OemToAnsi( STR0001 ) ) //"Ficha Clínica"
oPrint:Setup()
oPrint:SetPortrait() //retrato

RELMDT730( oPrint )

If xm_par01 = 2
	oPrint:Print()
Else
	oPrint:Preview()
EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} RELMDT730
Modelo Coletivo

@type Static Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@param oPrint - Objeto de impressão.

@return .T., boolean, sempre retorna verdadeiro
/*/
//---------------------------------------------------------------------
Static Function RELMDT730(oPrint)

Local xxx
Local nTam := 90 //Tamanho do Memo

//Variavies para prestador de servico
Local nIntTMT     := 3
Local cSeekTMT    := "xFilial('TMT')+xm_par02"
Local cWhileTMT   := "xFilial('TMT') == TMT->TMT_FILIAL .and. TMT->TMT_NUMFIC <= xm_par03"
Local cWhile2TMT  := "xFilial('TMT') == TMT->TMT_FILIAL .and. TMT->TMT_NUMFIC == cFichaMed"
Local nIndTM5     := 4
Local cSeekTM5    := "xFilial('TM5')+TMY->TMY_NUMASO"
Local cWhileTM5   := "xFilial('TM5') == TM5->TM5_FILIAL .and. TM5->TM5_NUMASO == TMY->TMY_NUMASO"
Local cRG     := ""
Local cFuncao := ""
Local cCusto  := ""
Local cEstado := ""
Local cIdade  := ""
Local cNome   := ""

Private nPagina   := 1
Private lImpLine  := .F.
Private nLinha01  := 0
Private nLinha02  := 0
Private cCliPar01 := ""
Private cCliPar02 := ""
Private xm_par01  := mv_par01
Private xm_par02  := mv_par02
Private xm_par03  := mv_par03
Private xm_par04  := mv_par04
Private xm_par05  := mv_par05
Private xm_par06  := mv_par06

lin := 250

If lSigaMdtps
	nIntTMT    := 10
	cSeekTMT   := "xFilial('TMT')+cCliPar01"
	cWhileTMT  := "xFilial('TMT') == TMT->TMT_FILIAL .and. TMT->(TMT_CLIENT+TMT_LOJA) <= cCliPar02"
	cWhile2TMT := "xFilial('TMT') == TMT->TMT_FILIAL .and. TMT->TMT_NUMFIC == cFichaMed .and. cCliente == TMT->TMT_CLIENT+TMT->TMT_LOJA"
	cCliPar01  := mv_par01+mv_par02
	cCliPar02  := mv_par03+mv_par04
	xm_par01   := mv_par05
	xm_par02   := mv_par06
	xm_par03   := mv_par07
	xm_par04   := mv_par08
	xm_par05   := mv_par09
	xm_par06   := mv_par10
	nIndTM5    := 18
	cSeekTM5   := "xFilial('TM5')+TMY->TMY_NUMASO+cCliente"
	cWhileTM5  := "xFilial('TM5') == TM5->TM5_FILIAL .and. TM5->TM5_NUMASO == TMY->TMY_NUMASO .and. cCliente == SubStr(TM5->TM5_CC,1,nSizeTD)"
EndIf

dbSelectArea( "TMT" )
dbSetOrder( nIntTMT )
dbSeek( &( cSeekTMT ), .T. )
While !Eof() .And. &( cWhileTMT )

	dbSelectArea( "TMT" )
	If lSigaMdtPs
		If TMT->TMT_NUMFIC < xm_par02 .Or. TMT->TMT_NUMFIC > xm_par03
			Dbskip()
			Loop
		EndIf
	EndIf
	If TMT->TMT_DTATEN < xm_par04 .Or. TMT->TMT_DTATEN > xm_par05
		Dbskip()
		Loop
	EndIf

	If xm_par06 == 1 .And. TMT->TMT_OCORRE <> "1"
		Dbskip()
		Loop
	EndIf
	If xm_par06 == 2 .And. TMT->TMT_OCORRE <> "2"
		Dbskip()
		Loop
	EndIf
	If xm_par06 == 3 .And. !( TMT->TMT_OCORRE $ "3/4" )
		Dbskip()
		Loop
	EndIf
	If xm_par06 == 4 .And. TMT->TMT_OCORRE <> "6"
		Dbskip()
		Loop
	EndIf

	dbSelectArea( "TM0" )
	dbSetOrder( 1 )
	dbSeek( xFilial( "TM0" ) + TMT->TMT_NUMFIC )
	dbSelectArea( "SRA" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "SRA" ) + TM0->TM0_MAT )
		cRG 	:= SRA->RA_RG
		cEstado := SRA->RA_ESTCIVI
		cIdade  := SRA->RA_NASC
		cNome	:= IIf( Empty( SRA->RA_NOMECMP ), SRA->RA_NOME, SRA->RA_NOMECMP )

		dbSelectArea( cAlias )
		dbSetOrder( 1 )
		dbSeek( xFilial( cAlias ) + SRA->RA_CC )
		cCusto := &cDescr

		dbSelectArea( "SRJ" )
		dbSetOrder( 1 )
		dbSeek( xFilial( "SRJ" ) + SRA->RA_CODFUNC )
		cFuncao := SRJ->RJ_DESC

	Else // Caso seja candidato
		cRG		:= TM0->TM0_RG
		cFuncao := TM0->TM0_CODFUN
		cCusto  := TM0->TM0_CC
		cEstado := TM0->TM0_ESTCIV
		cIdade  := TM0->TM0_DTNASC
		cNome	:= TM0->TM0_NOMFIC
	EndIf

	nPagina := 1

	If lSigaMdtPs
   		cCliente := TMT->TMT_CLIENT+TMT->TMT_LOJA
 	EndIf
	cFichaMed := TMT->TMT_NUMFIC

	oPrint:StartPage() //Inicia nova página
	lin := 250

	lImpLine := .F.

	F730HEA( oPrint ) // Imprime o cabecalho

	lin := 580
	oPrint:Say( lin + 5, 60, STR0021, oFont07 )//"NOME"
	oPrint:Say( lin + 35, 60, cNome, oFont08 )
	oPrint:Line( lin, 1700, lin + 80, 1700 )
	oPrint:Say( lin + 5, 1710, STR0022, oFont07 ) //"R.G. FUNCIONAL"
	oPrint:Say( lin + 35, 1710, cRG, oFont08 )
	oPrint:Line( lin + 80, 50, lin + 80, 2300 )

	lin := 660
	oPrint:Say( lin + 5, 60, STR0023, oFont07 )//"FUNÇÃO"
	oPrint:Say( lin + 35, 60, cFuncao, oFont08 )
	oPrint:Line( lin, 1150, lin + 80, 1150 )
	oPrint:Say( lin + 5, 1160, STR0024, oFont07 )//"CENTRO DE CUSTO"
	oPrint:Say( lin + 35, 1160, cCusto, oFont08 )
	oPrint:Line( lin + 80, 50, lin + 80, 2300 )

	cEstCiv := STR0025//"SOLTEIRO(A)"
	If cEstado = "C"
		cEstCiv := STR0026//"CASADO(A)"
	ElseIf cEstado = "D"
		cEstCiv := STR0027//"DIVORCIADO(A)"
	ElseIf cEstado = "M"
		cEstCiv := STR0028//"MARITAL"
	ElseIf cEstado = "Q"
		cEstCiv := STR0029//"DESQUITADO(A)"
	ElseIf cEstado = "S"
		cEstCiv := STR0030//"SOLTEIRO(A)"
	ElseIf cEstado = "V"
		cEstCiv := STR0031//"VIUVO(A)"
	EndIf

	lin := 740
	oPrint:Say( lin + 5, 60, STR0032, oFont07 )//"IDADE"
	oPrint:Say( lin + 35, 60, R730ID( cIdade ) + " " + STR0033, oFont08 )//" ano(s)"
	oPrint:Line( lin, 425, lin + 80, 425 )
	oPrint:Say( lin + 5, 435, STR0034, oFont07 )//"ESTADO CIVIL"
	oPrint:Say( lin + 35, 435, cEstCiv, oFont08 )
	oPrint:Line( lin, 800, lin + 80, 800 )
	oPrint:Say( lin + 5, 810, STR0035, oFont07 )//"NACIONALIDADE"
	oPrint:Say( lin + 35, 810, NGSEEK( "SX5", "34" + SRA->RA_NACIONA, 1, "SubStr(X5_DESCRI,1,20)" ), oFont08 )

	oPrint:Line( lin, 1175, lin + 80, 1175 )
	oPrint:Say( lin + 5, 1185, STR0036, oFont07 )//"COR"
	oPrint:Say( lin + 35, 1185, NGRETSX3BOX( "TM0_CORPEL", TM0->TM0_CORPEL ), oFont08 )
	oPrint:Line( lin, 1550, lin + 80, 1550 )
	oPrint:Say( lin + 5, 1560, STR0037, oFont07 )//"DATA DE ADMISSÃO"
	oPrint:Say( lin + 35, 1560, Dtoc( SRA->RA_ADMISSA ), oFont08 )
	oPrint:Line( lin, 1925, lin + 80, 1925 )
	oPrint:Say( lin + 5, 1935, STR0038, oFont07 )//"DATA DO 1º EXAME"
	oPrint:Say( lin +35, 1935, DTOC( fDtPrExa( cFichaMed ) ), oFont08 )
	oPrint:Line( lin + 80, 50, lin + 80, 2300 )
	oPrint:Line( lin + 81, 50, lin + 81, 2300 )

	lin := 820

	nIndicar := Round( ( 3000 - lin ) / 70, 0 )

	For xxx := 1 to nIndicar
		oPrint:Line( lin + ( 70 * xxx ), 50, lin + ( 70 * xxx ), 2300 )
	Next xxx

	oPrint:Line( lin, 650, lin + ( 70 * nIndicar ), 650 )
	oPrint:Line( lin + ( 70 * nIndicar ) - 1, 50, lin + ( 70 * nIndicar ) - 1, 2300 )
	oPrint:Line( lin + ( 70 * nIndicar ), 50, lin + ( 70 * nIndicar ), 2300 )
	oPrint:Line( lin + ( 70 * nIndicar ) + 1, 50, lin + ( 70 * nIndicar ) + 1, 2300 )

	dbSelectArea( "TMT" )
	While !Eof() .And. &( cWhile2TMT )

		nLMemo := MLCOUNT( TMT->TMT_OUTROS, nTam )
		nMemo  := 0
		oPrint:Line( lin + 1, 50, lin + 1, 2300 )
		oPrint:Line( lin + 2, 50, lin + 2, 2300 )
		oPrint:Line( lin + 3, 50, lin + 3, 2300 )
		oPrint:Say( lin + 5, 60, STR0039, oFont08 )//"DATA"
		oPrint:Say( lin + 15, 260, DTOC( TMT->TMT_DTATEN ), oFont08 )
		oPrint:Say( lin + 5, 660, STR0040, oFont08 )	//"OBSERVAÇÕES"

		HEADER730( oPrint )

		oPrint:Say( lin + 5, 60, STR0041, oFont07 )//"PESO"
		oPrint:Say( lin + 15, 260, Alltrim( Str( TMT->TMT_PESO ) ), oFont08 )

		nMemo++

		oPrint:Say( lin + 30, 700, Memoline( TMT->TMT_OUTROS, nTam, nMemo ), oFont06 )

		HEADER730( oPrint )

		oPrint:Say( lin + 5, 60, "PA =", oFont07 )
		If TMT->( ColumnPos( "TMT_PRESIS" ) ) > 0 .And. TMT->( ColumnPos( "TMT_PREDIS" ) ) > 0
			oPrint:Say( lin + 15, 260, cValToChar( TMT->TMT_PRESIS ) + " X " + cValToChar( TMT->TMT_PREDIS ), oFont08 )
		EndIf

		nMemo++

		oPrint:Say( lin + 30, 660, Memoline( TMT->TMT_OUTROS, nTam, nMemo ), oFont06 )

		HEADER730( oPrint )

		oPrint:Say( lin + 5, 60, "P = FC =", oFont07 )
		If NGCADICBASE( "TMT_DIASYP", "A", "TMT", .F. )
			oPrint:Say( lin + 15, 260, SubStr( MsMM( TMT->TMT_AUCSYP, 10 ), 1, 20 ), oFont08 )
		Else
			oPrint:Say( lin + 15, 260, SubStr( TMT->TMT_AUSCAR, 1, 20 ), oFont08 )
		EndIf

		nMemo++
		//Acrescentado o If devido a falta de espaço e truncamento se não houver conteúdo no campo de Outros.
		If !Empty( TMT->TMT_OUTROS ) .And.;
		( MLCOUNT( TMT->TMT_OUTROS, nTam ) >= 4 .Or.;
		!Empty( Memoline( TMT->TMT_OUTROS, nTam, nMemo ) ) )
			oPrint:Say( lin + 30, 660, Memoline( TMT->TMT_OUTROS, nTam, nMemo ), oFont06 )
		Else
			HEADER730( oPrint )
		EndIf

		dbSelectArea( "TMY" )
		dbSetOrder( 3 )
		If dbSeek( xFilial( "TMY" ) + TMT->TMT_NUMFIC + DTOS( TMT->TMT_DTCONS ) )
			lExame := .T.
			dbSelectArea( "TM5" )
			dbSetOrder( nIndTM5 )
			dbSeek( &( cSeekTM5 ) )
			While !Eof() .And. &( cWhileTM5 )

				If lExame

					HEADER730( oPrint )
					oPrint:Say( lin + 5, 260, STR0042, oFont09 )//"EXAMES"
					nMemo++

					oPrint:Say( lin + 30, 660, Memoline( TMT->TMT_OUTROS, nTam, nMemo ), oFont06 )

				EndIf

				HEADER730( oPrint )

				dbSelectArea( "TM4" )
				dbSetOrder( 01 )
				dbSeek( xFilial( "TM4" ) + TM5->TM5_EXAME )

				oPrint:Say( lin + 5, 60, Substr( TM4->TM4_NOMEXA, 1, 23 ), oFont07 )
				oPrint:Say( lin + 25, 260, DtoC( TM5->TM5_DTRESU ), oFont08 )

				nMemo++

				lExame := .F.
				//Serão impressos todos os exames sem pular linha
				oPrint:Say( lin + 30, 660, Memoline( TMT->TMT_OUTROS, nTam, nMemo ), oFont06 )

				dbSelectArea( "TM5" )
				dbSkip()
			End
			// Caso seja o último exame e não tenha mais texto, o sistema pula linha,se houver texto,
			// ele vai pular linha dentro da função IMPMEMO730
			If Empty(Memoline( TMT->TMT_OUTROS, nTam, nMemo ))
				HEADER730( oPrint )
			EndIf
		EndIf


		If nMemo < nLMemo
			IMPMEMO730( oPrint, nMemo + 1 )
		EndIf
		dbSelectArea( "TMT" )
		Dbskip()
	End
	oPrint:EndPage()
End

Return .t.

//---------------------------------------------------------------------
/*/{Protheus.doc} R730ID
Calcula a idade do funcionario.

@type Static Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@param dNasc, Data, Data de nascimento.
@param dFim, Data, Data fim.


@return nIdade, Mumérico, retorna a idade.
/*/
//---------------------------------------------------------------------
Static Function R730ID( dNasc, dFim )

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

Return Alltrim( Str( nIdade, 3 ) )

//---------------------------------------------------------------------
/*/{Protheus.doc} HEADER730
Inicia nova página.

@type Static Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@param oPrint, objeto de impressão.
@return .T., Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function HEADER730( oPrint )

lin += 70

If lin >= 2970
	lin := 250
	oPrint:EndPage()
	oPrint:StartPage()
	F730HEA( oPrint )
EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} F730HEA
Imprime o cabacalho das paginas

@type Static Function
@author Denis Hyroshi de Souza
@since 02/04/2003

@param oPrint, Objeto de impressão.

@return .T., Sempre verdadeiro
/*/
//---------------------------------------------------------------------
Static Function F730HEA( oPrint )

Local nBold
Local xxx
Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

If File( "LGRL" + cSMCOD + cSMFIL + ".BMP" )
	oPrint:SayBitMap( 60, 1650, "LGRL" + cSMCOD + cSMFIL + ".BMP", 550, 180 )
ElseIf File( "LGRL" + cSMCOD + ".BMP" )
	oPrint:SayBitMap( 60, 1650, "LGRL" + cSMCOD + ".BMP", 550, 180 )
ElseIf File( "\SIGAADV\LGRL" + cSMCOD + cSMFIL + ".BMP" )
	oPrint:SayBitMap( 60, 1650, "\SIGAADV\LGRL" + cSMCOD + cSMFIL + ".BMP", 550, 180 )
ElseIf File( "\SIGAADV\LGRL" + cSMCOD + ".BMP" )
	oPrint:SayBitMap( 60, 1650, "\SIGAADV\LGRL" + cSMCOD + ".BMP", 550, 180 )
EndIf

For nBold := 1 to 4
	oPrint:Line( lin + nBold, 050, lin + nBold, 2300 )
Next nBold

oPrint:Say( lin + 40, 400, STR0043, oFont15 )//"PROGRAMA DE CONTROLE MÉDICO DE SAÚDE OCUPACIONAL"
oPrint:Line( lin + 110, 050, lin + 110, 2300 )
oPrint:Line( lin + 111, 050, lin + 111, 2300 )
oPrint:Say( lin + 140, 600, UPPER( STR0001 ), oFont15 )//"FICHA CLÍNICA"

If lSigaMdtps

	oPrint:Say( lin + 140, 1300, STR0044, oFont12 )
	oPrint:Say( lin + 140, 1550, Substr( NGSEEK( "SA1", TMT->( TMT_CLIENT + TMT_LOJA ), 1, "SA1->A1_NOME" ), 1, 40 ), oFont10 )
	oPrint:Line( lin + 220, 050, lin + 220, 2300 )
	oPrint:Say( lin + 250, 600, STR0045, oFont12 )//"Exames Periódicos"
	oPrint:Say( lin + 250, 1300, STR0046, oFont12 )//"Folha nº:"
	oPrint:Say( lin + 250, 1550, StrZero( nPagina, 2 ), oFont10 )

	nPagina++

	oPrint:Line( lin + 330, 050, lin + 330, 2300 )
	oPrint:Line( lin + 331, 050, lin + 331, 2300 )
	oPrint:Line( lin + 332, 050, lin + 332, 2300 )
	oPrint:Line( lin + 110, 1280, lin + 331, 1280 )

Else

	oPrint:Say( lin + 140, 1600, STR0044, oFont12 )//"Unidade:"
	oPrint:Say( lin + 140, 1850, Substr( SM0->M0_NOMECOM, 1, 20 ), oFont10 )
	oPrint:Line( lin + 220, 050, lin + 220, 2300 )
	oPrint:Say( lin + 250, 600, STR0045, oFont12 )//"Exames Periódicos"
	oPrint:Say( lin + 250, 1600, STR0046, oFont12 )//"Folha nº:"
	oPrint:Say( lin + 250, 1850, StrZero( nPagina, 2 ), oFont10 )

	nPagina++

	oPrint:Line( lin + 330, 050, lin + 330, 2300 )
	oPrint:Line( lin + 331, 050, lin + 331, 2300 )
	oPrint:Line( lin + 332, 050, lin + 332, 2300 )
	oPrint:Line( lin + 110, 1580, lin + 331, 1580 )

EndIf

lin := 580
If lImpLine

	nIndicar := Round( ( 3000 - lin ) / 70, 0 )

	For xxx := 1 to nIndicar
		oPrint:Line( lin + ( 70 * xxx ), 50, lin + ( 70 * xxx ), 2300 )
	Next xxx

	oPrint:Line( lin, 650, lin + ( 70 * nIndicar ), 650 )
	oPrint:Line( lin + ( 70 * nIndicar ) - 1, 50, lin + ( 70 * nIndicar ) - 1, 2300 )
	oPrint:Line( lin + ( 70 * nIndicar ), 50, lin + ( 70 * nIndicar ), 2300 )
	oPrint:Line( lin + ( 70 * nIndicar ) +1, 50, lin + ( 70 * nIndicar ) + 1, 2300 )

EndIf

lImpLine := .T.

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} IMPMEMO730
Término de impressão do campo Memo


@type Static Function
@author Desconhecido
@since Desconhecido

@param oPrint, Objeto de impressão.
@param ninic, Linha de impressão.
@return
/*/
//---------------------------------------------------------------------
Static Function IMPMEMO730( oPrint, ninic )

Local nTam := 90 //Tamanho do Memo
Local LinhaCorrente

nLMemo := MLCOUNT( TMT->TMT_OUTROS, nTam )

For LinhaCorrente := ninic to nLMemo

	HEADER730( oPrint )
	oPrint:Say( lin + 30, 660, ( MemoLine( TMT->TMT_OUTROS, nTam, LinhaCorrente ) ), oFont06 )

Next LinhaCorrente

HEADER730( oPrint )

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDtPrExa
Retorna data do primeiro exame

@type Static Function
@author Jackson Machado
@since 10/04/2012

@param cFicha, Caracter, Ficha médica.
@return dDtExa
/*/
//---------------------------------------------------------------------
Static Function fDtPrExa( cFicha )

Local dDtExa := STOD( Space( 8 ) )

#IFDEF TOP
	Local cAliasQry := GetNextAlias()

	cQuery := "SELECT MIN(TM5_DTRESU) AS PRIEXA FROM "+RetSqlName("TM5")+" WHERE TM5_NUMFIC = "+ValToSql(cFicha)
	cQuery += " AND D_E_L_E_T_ <> '*' AND TM5_FILIAL = "+ValToSql(xFilial("TM5"))+"AND TM5_DTRESU <> ''"
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery , cAliasQry )

	dbSelectArea( cAliasQry )
	dbGoTo(1)
	If ( cAliasQry )->( !Eof() )
		dDtExa := STOD( ( cAliasQry )->PRIEXA )
	EndIf
#Else
	dbSelectArea( "TM5" )
	dbSetOrder( 1 )
	If dbSeek( xFilial( "TM5" ) + TM0->TM0_NUMFIC )
		While TM5->( !Eof() ) .And. TM5->TM5_NUMFIC == TM0->TM0_NUMFIC
			If !Empty( TM5->TM5_DTRESU ) .And. ( TM5->TM5_DTRESU < dDtExa .Or. Empty( dDtExa ) )
			 	dDtExa := TM5->TM5_DTRESU
			EndIf
			TM5->( dbSkip() )
		End
	EndIf
#ENDIF

Return dDtExa
