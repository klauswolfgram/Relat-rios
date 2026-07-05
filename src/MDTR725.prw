/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR725.CH"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR725

Relatorio de Atendimento Diario - Enfermagem

@author  Rafael Diogo Richter
@since   10/06/03

@return  Nil, Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR725()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local oReport
	Local aArea := GetArea()
	Local lAltera := .F.

	Private cPerg := "MDT725    "
	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	Private lPersonal := .T.
	Private oTempTRB, oTempTRB2, oTempTY3
	Private cTRBTL5 := GetNextAlias()

	If !MDTRESTRI(cPrograma)
		NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
		Return .F.
	Endif

	/*---------------------------------
	//PERGUNTAS PADRÃO					|
	| 01  De Data de Atendimento ?    	|
	| 02  Até Data de Atendimento ?   	|
	| 03  De Motivo ?                 	|
	| 04  Até Motivo ?                	|
	| 05  De Atendente ?              	|
	| 06  Até Atendente ?             	|
	| 07  Totalizar por : ?           	|
	|         1-Data + Atendente      	|
	|         2-Data + Motivo Atend.  	|
	|         3-Indicação             	|
	|		   4-Atendente             	|
	|		   5-Motivo Atend.         	|
	------------------------------------*/

	If TRepInUse()
		Pergunte(cPerg,.T.)//Repassado para o começo para tratativa dos Totalizadores
		oReport := ReportDef()
		oReport:SetLandscape()
		oReport:PrintDialog()
	Else
		lPersonal := .F.
		U_MDTR725R3()
	EndIf

	RestArea(aArea)

	NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} R725Imp

Chamada do Relatorio

@author  Rafael Diogo Richter
@since   10/06/2003

@sample  U_R725Imp(@lEnd,wnRel,titulo,tamanho)

@param   lEnd, Lógico, Indica se abortou a opercao
@param   wnRel, Caractere, Arquivo de saida do relatorio
@param   titulo, Caractere, Titulo do relatorio
@param   tamanho, Caractere, Tamanho do relatorio

@return  Nil, Nulo
/*/
//-------------------------------------------------------------------
User Function R725Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local cNome
	Local nAtend:=0
	Local cDur:=""
	Local nMotiv:=0
	Local dDtAten:=CTOD("  /  /  ")

	Private li := 80 ,m_pag := 1

	nTipo  := IIF(aReturn[4]==1,15,18)

	// Monta os Cabecalhos
	if lSigaMdtps
		If (mv_par11 == 1 .Or. mv_par11 == 4)
			cabec1 := STR0007 //"Atendente      Medicamento                      Quant.     Unid."
			cabec2 := STR0048 //"    Ficha Médica    Nome                                      Atendente                                 Indicação                Hora    Observação"
		ElseIf (mv_par11 == 2 .Or. mv_par11 == 5)
			cabec1 := STR0069 //"Motivo         Medicamento                      Quant.     Unid."
			cabec2 := STR0008 //"    Ficha Médica    Nome                                      Motivo                                    Indicação                Hora    Observação"
		Else
			cabec1 := STR0070 //"Indicação      Medicamento                      Quant.     Unid."
			cabec2 := STR0048 //"    Ficha Médica    Nome                                      Atendente                                 Indicação                Hora    Observação"
		Endif
	else
		If (mv_par07 == 1 .Or. mv_par07 == 4)
			cabec1 := STR0007 //"Atendente      Medicamento                      Quant.     Unid."
			cabec2 := STR0048 //"    Ficha Médica    Nome                                      Atendente                                 Indicação                Hora    Observação"
		ElseIf (mv_par07 == 2 .Or. mv_par07 == 5)
			cabec1 := STR0069 //"Motivo         Medicamento                      Quant.     Unid."
			cabec2 := STR0008 //"    Ficha Médica    Nome                                      Motivo                                    Indicação                Hora    Observação"
		Else
			cabec1 := STR0070 //"Indicação      Medicamento                      Quant.     Unid."
			cabec2 := STR0048 //"    Ficha Médica    Nome                                      Atendente                                 Indicação                Hora    Observação"
		Endif
	endif


	//Totaliza por ATENDENTE
	/*
	--------------------------------------------------------------------------------
	*<empresa>                                                    Folha..: xxxxx   *
	*SIGA /<nome .04         <Relatorio de Questionario Medico>   DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                            Emissao: dd/mm/aa*
	--------------------------------------------------------------------------------
			10        20        30        40        50        60        70        80        90       100       110       120       130        140      150       160       170       180       190       200       210       220
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Atendente
		Ficha Médica    Nome                                      Motivo                                    Indicação                Medicamento                     Qtdade.     Unid.   Hor.    Observação
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Data: xx/xx/xx

	Paulo Jose
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  12345678901234567890123  123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  12345678901234567890123  123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos de PAULO JOSE: xxxx

	Gertrudes Jativoca
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos de GERTRUDES JATIVOCA: xxxx

	Total de Atendimento na Data xx/xx/xx: 9999
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Data: xx/xx/xx

	Paulo Jose
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos de PAULO JOSE: xxxx

	Gertrudes Jativoca
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos de GERTRUDES JATIVOCA: xxxx

	Total de Atendimento na Data xx/xx/xx: 9999
	*/

	//Totaliza por MOTIVO
	/*
	--------------------------------------------------------------------------------
	*<empresa>                                                    Folha..: xxxxx   *
	*SIGA /<nome .04         <Relatorio de Questionario Medico>   DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                            Emissao: dd/mm/aa*
	--------------------------------------------------------------------------------
			10        20        30        40        50        60        70        80        90       100       110       120       130        140      150       160       170       180       190       200       210       220
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Motivo
		Ficha Médica    Nome                                      Atendente                                 Indicação                Medicamento                     Qtdade.     Unid.   Hor.    Observação
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Data: xx/xx/xx

	1234567890123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos por motivo xxxxxxxxxxxxxx

	1234567890123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos por motivo xxxxxxxxxxxxxx

	Total de Atendimento na Data xx/xx/xx: 9999
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	Data: xx/xx/xx

	1234567890123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos por motivo xxxxxxxxxxxxxx

	1234567890123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890
		123456789       1234567890123456789012345678901234567890  1234567890123456789012345678901234567890  123456789012345678901    123456789012345678901234567890  9999999.99  123456  12345   123456789012345678901234567890

	Total de Atendimentos por motivo xxxxxxxxxxxxxx

	Total de Atendimento na Data xx/xx/xx: 9999
	*/

	If lSigaMdtps

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		SetRegua(LastRec())

		While !Eof()

			SomaLinha()
			cCliente := TRB->CLIENT+TRB->LOJA

			@ Li,000 PSay STR0056  + AllTrim(TRB->CLIENT) + "-" + AllTrim(TRB->LOJA) + " - " + SubSTR( NGSEEK("SA1",cCliente,1,"SA1->A1_NOME"), 1, 40 ) //"Cliente/Loja: "
			SomaLinha()

			While !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJA

				dDataLin := TRB->DTATEN
				nTotal := 0
				SomaLinha()
				If (MV_PAR11 == 1 .Or. MV_PAR11 == 2 .Or. MV_PAR11 == 3)
					@ Li,000 PSay (STR0027 + DtoC(TRB->DTATEN) )  //"Data: "
				Endif
				While !Eof() .And. TRB->DTATEN == dDataLin .And. cCliente = TRB->CLIENT+TRB->LOJA

					If (MV_PAR11 == 1 .Or. MV_PAR11 == 4)
						cCodigo := TRB->CODUSU
					ElseIf (MV_PAR11 == 2 .Or. MV_PAR11 == 5)
						cCodigo := TRB->MOTIVO
					Else
						cCodigo := TRB->INDICA
					EndIf
					nTotalSec2 := 0

					SomaLinha()
					SomaLinha()
					If (MV_PAR11 == 1 .OR. MV_PAR11 == 4)
						@ Li,000 PSay (TRB->NOMUSU) //Atendente
					ElseIf (MV_PAR11 == 2 .Or. MV_PAR_11 == 5)
						If !Empty(TRB->NOMOTI)
							@ Li,000 PSay (TRB->NOMOTI)    //Motivo
						Else
							@ Li,000 PSay "-"
						Endif
					Else
						@ Li,000 PSay (TRB->INDNOM)    //Indicação
					EndIf
					SomaLinha()
					If (MV_PAR11 == 1 .Or. MV_PAR11 == 4)
						cNome := AllTrim(TRB->NOMUSU) //Atendente
					ElseIf (MV_PAR11 == 2 .Or. MV_PAR11 == 5)
						cNome := AllTrim(TRB->NOMOTI) //Motivo
					Else
						cNome := AllTrim(TRB->INDNOM) //Indicação
					EndIf

					If (MV_PAR11 == 1 .Or. MV_PAR11 == 4)
						cKeyWhile := "TRB->CODUSU"
					ElseIf (MV_PAR11 == 2 .Or. MV_PAR11 == 5)
						cKeyWhile := "TRB->MOTIVO"
					Else
						cKeyWhile := "TRB->INDICA"
					EndIf
					If(mv_par11 == 1 .Or. mv_par11 == 2 .Or. mv_par11 == 3)
						While !Eof() .AND. TRB->DTATEN == dDataLin .AND. &( cKeyWhile ) == cCodigo /*.AND. cCliente = TRB->CLIENT+TRB->LOJA	  */

							IncRegua()

							@ Li,004 PSay (TRB->NUMFIC)  //Ficha
							@ Li,020 PSay (TRB->NOMFIC)  //Nome
							@ Li,062 PSay IF(MV_PAR11 == 1 .Or. MV_PAR11 == 3, (TRB->NOMUSU) , (TRB->NOMOTI) )  //Atendente
							@ Li,104 PSay (TRB->INDNOM)  //Indicacao
							@ Li,129 PSay (TRB->NOMEDI)  //Medicamento
							@ Li,155 PSay (TRB->QTDADE) Picture "@E 9,999,999.99"  //Qtde
							@ Li,173 PSay (TRB->UNIDAD)  //Unidade
							@ Li,181 PSay (TRB->HRATEN)  //Horário

							cObserv := AllTrim(TRB->OBSERV)
							nLenStr := Len ( cObserv )

							If nLenStr <= 30
								@Li,190 PSAY cObserv
							Else
								nY := 0
								nXX := 1
								While nLenStr > 30
									nY ++
									nX := 30 * nY
									@ Li,190 Psay SubStr(cObserv,nXX,30)
									SomaLinha()
									nXX := nX + 1
									nLenStr -= 30
								End
								If nLenStr > 0
									@ Li,190 Psay SubStr(cObserv,nXX,nLenStr)
								EndIf
							Endif

							SomaLinha()
							nTotal++
							nTotalSec2++
							dbSkip()
						End
					ELse
						While !Eof() .AND. &( cKeyWhile ) == cCodigo
							IncRegua()
							@ Li,004 PSay (TRB->NUMFIC)  //Ficha
							@ Li,020 PSay (TRB->NOMFIC)  //Nome
							@ Li,062 PSay IF(MV_PAR07 == 1 .Or. MV_PAR07 == 3 , (TRB->NOMUSU) , (TRB->NOMOTI) )  //Atendente
							@ Li,104 PSay (TRB->INDNOM)  //Indicacao
							@ Li,129 PSay (TRB->NOMEDI)  //Medicamento
							@ Li,155 PSay (TRB->QTDADE) Picture "@E 9,999,999.99"  //Qtde
							@ Li,173 PSay (TRB->UNIDAD)  //Unidade
							@ Li,181 PSay (TRB->HRATEN)  //Horário

							cObserv := AllTrim(TRB->OBSERV)
							nLenStr := Len ( cObserv )

							If nLenStr <= 30
								@Li,190 PSAY cObserv
							Else
								nY := 0
								nXX := 1
								While nLenStr > 30
									nY ++
									nX := 30 * nY
									@ Li,190 Psay SubStr(cObserv,nXX,30)
									SomaLinha()
									nXX := nX + 1
									nLenStr -= 30
								End
								If nLenStr > 0
									@ Li,190 Psay SubStr(cObserv,nXX,nLenStr)
								EndIf
							Endif
							SomaLinha()
							nTotal++
							nTotalSec2++
							dbSkip()
						End
					Endif
					If mv_par11 == 1
						nAtend:=0
						dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimentos
						dbSelectArea("TL5")
						dbSetOrder(4)
						dbSeek(xFilial("TL5") + cCodigo)
						While !Eof() .ANd. cCodigo == TL5->TL5_CODUSU//verifica se é do mesmo usuario
							If (TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)//verificar se esta dentro da data
								nAtend++  //adiciona ao contado um atendimento
								If (dDtAten < TL5->TL5_DTATEN)
									dDtAten:= TL5->TL5_DTATEN
								Endif
							Endif
							dbSkip()
						End
					Endif
					If mv_par11 == 2
						nMotiv:=0
						dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
						dbSelectArea("TL5")
						dbSetOrder(3)
						dbSeek(xFilial("TL5") + cCodigo )
						While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_MOTIVO)
							If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)
								nMotiv++
								If(dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
									dDtAten:= TL5->TL5_DTATEN
								Endif
							Endif
							dbSkip()
						End
					Endif
					dbSelectArea( "TRB" )
					SomaLinha()
					If MV_PAR11 == 1
										@ Li,000 PSay ( STR0028 + cNome + ": " + AllTrim(STR(nTotalSec2)) )  //"Total de Atendimentos de GERTRUDES PERERECA: "
						SomaLinha()
						If (dDataLin == dDtAten)
							@ Li,000 PSay (STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nAtend))//Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
							Somalinha()
						Endif
					ElseIf MV_PAR11 == 2
					If !Empty(cNome)
							@ Li,000 PSay ( STR0030 + cNome + ": " + AllTrim(STR(nTotalSec2)) )  //"Total de Atendimentos pelo motivo "
							Somalinha()
						Else
							@ Li,000 PSay ( STR0057 + AllTrim(STR(nTotalSec2)) )   //"Total de atendimentos sem motivo: "
							Somalinha()
						Endif
						If (dDataLin == dDtAten) .And. (mv_par07 == 2)
							@ Li,000 PSay (STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nMotiv))//Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
							Somalinha()
						Endif
					Else
						If !Empty(cNome)
							@ Li,000 PSay ( STR0060 + cNome + ": " + AllTrim(STR(nTotalSec2)) )//"Total de Atendimentos pela Indicação "
						Else
							@ Li,000 PSay ( STR0061 + ": " + AllTrim(STR(nTotalSec2)) )//"Total de Atendimentos sem Indicação "
						EndIf
					EndIf
					If Eof() .OR. TRB->DTATEN <> dDataLin .OR. cCliente <> TRB->CLIENT+TRB->LOJA
						SomaLinha()
					Endif
				End
				@ Li,000 PSay (STR0029 + DtoC(dDataLin) + ": " + AllTrim(STR(nTotal)) ) //"Total de Atendimentos na Data xx/xx/xx: 9999 "
				If !Eof() .and. cCliente = TRB->CLIENT+TRB->LOJA
					SomaLinha()
				Endif
			End   //Cliente
			SomaLinha()
			@ Li,000 PSAY __PrtThinLine()
		End

	Else

		SomaLinha()

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		SetRegua(LastRec())

		While !Eof()

			dDataLin	:= TRB->DTATEN
			nTotal := 0
			SomaLinha()
			If (mv_par07 == 1 .Or. mv_par07 == 2 .Or. mv_par07 == 3)
				@ Li,000 PSay (STR0027 + DtoC(TRB->DTATEN) )  //"Data: "
			Endif
			While !Eof() .AND. TRB->DTATEN == dDataLin

				If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					cCodigo := TRB->CODUSU
				ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
					cCodigo := TRB->MOTIVO
				Else
					cCodigo := TRB->INDICA
				EndIf
				nTotalSec2 := 0
				SomaLinha()
				SomaLinha()
				If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					@ Li,000 PSay (TRB->NOMUSU)  //Atendente
				ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
					If !Empty(TRB->NOMOTI)
						@ Li,000 PSay (TRB->NOMOTI)    //Motivo
					Else
						@ Li,000 PSay "-"
					Endif
				Else
					@ Li,000 PSay (TRB->INDNOM)    //Indicação
				EndIf

				SomaLinha()
				If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					cNome := AllTrim(TRB->NOMUSU)
				ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
					cNome := AllTrim(TRB->NOMOTI)
				Else
					cNome := AllTrim(TRB->INDNOM)
				EndIf

				If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					cKeyWhile := "TRB->CODUSU"
				ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
					cKeyWhile := "TRB->MOTIVO"
				Else
					cKeyWhile := "TRB->INDICA"
				EndIf
				If (MV_PAR07 == 1 .Or. MV_PAR07 == 2 .Or. MV_PAR07 == 3)
					While !Eof() .AND. TRB->DTATEN == dDataLin .AND. &( cKeyWhile ) == cCodigo

						IncRegua()
						@ Li,004 PSay (TRB->NUMFIC)  //Ficha
						@ Li,020 PSay (TRB->NOMFIC)  //Nome
						@ Li,062 PSay IF(MV_PAR07 == 1 .Or. MV_PAR07 == 3, (TRB->NOMUSU) , (TRB->NOMOTI) )  //Atendente
						@ Li,104 PSay (TRB->INDNOM)  //Indicacao
						@ Li,129 PSay (TRB->HRATEN)  //Horário

						cObserv := AllTrim(TRB->OBSERV)
						nLenStr := Len ( cObserv )

						If nLenStr <= 70
							@Li,137 PSAY cObserv
						Else
							nY := 0
							nXX := 1
							While nLenStr > 70
								nY ++
								nX := 70 * nY
								@ Li,137 Psay SubStr(cObserv,nXX,70)
								SomaLinha()
								nXX := nX + 1
								nLenStr -= 70
							End
							If nLenStr > 0
								@ Li,137 Psay SubStr(cObserv,nXX,nLenStr)
							EndIf
						Endif
						SomaLinha()
						//Imprime os Medicamentos.
						aAreaTRB := GetArea()//Salva área
						dbSelectArea("TRBTY3")
						dbSetOrder(1)//TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED
						If dbSeek(TRB->NUMFIC+DTOS(TRB->DTATEN))
							While TRBTY3->(!Eof())
								If TRBTY3->NUMFIC == TRB->NUMFIC .And. TRB->DTATEN == TRBTY3->DTATEN .And. TRB->HRATEN == TRBTY3->HRATEN
									@ Li,015 PSay (TRBTY3->DESMED)  //Medicamento
									@ Li,042 PSay (TRBTY3->QUANT) Picture "@E 9,999,999.99"  //Qtde
									@ Li,060 PSay (TRBTY3->UNIMED)  //Unidade*/
									SomaLinha()
								Endif
								TRBTY3->(dbSkip())
							End
						Endif
						RestArea( aAreaTRB )//Volta área posicionada

						nTotal++
						nTotalSec2++
						dbSkip()
					End
				Else
					While !Eof() .AND. &( cKeyWhile ) == cCodigo
						IncRegua()
						@ Li,004 PSay (TRB->NUMFIC)  //Ficha
						@ Li,020 PSay (TRB->NOMFIC)  //Nome
						@ Li,062 PSay IF(MV_PAR07 == 4 , (TRB->NOMUSU) , (TRB->NOMOTI) )  //Atendente
						@ Li,104 PSay (TRB->INDNOM)  //Indicacao
						@ Li,129 PSay (TRB->HRATEN)  //Horário

						cObserv := AllTrim(TRB->OBSERV)
						nLenStr := Len ( cObserv )

						If nLenStr <= 70
							@Li,137 PSAY cObserv
						Else
							nY := 0
							nXX := 1
							While nLenStr > 70
								nY ++
								nX := 70 * nY
								@ Li,137 Psay SubStr(cObserv,nXX,70)
								SomaLinha()
								nXX := nX + 1
								nLenStr -= 70
							End
							If nLenStr > 0
								@ Li,137 Psay SubStr(cObserv,nXX,nLenStr)
							EndIf
						Endif
						SomaLinha()
						//Imprime os Medicamentos.
						aAreaTRB := GetArea()//Salva área
						dbSelectArea("TRBTY3")
						dbSetOrder(1)//TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED
						If dbSeek(TRB->NUMFIC+DTOS(TRB->DTATEN))
							While TRBTY3->(!Eof())
								If TRBTY3->NUMFIC == TRB->NUMFIC .And. TRB->DTATEN == TRBTY3->DTATEN .And. TRB->HRATEN == TRBTY3->HRATEN
									@ Li,015 PSay (TRBTY3->DESMED)  //Medicamento
									@ Li,042 PSay (TRBTY3->QUANT) Picture "@E 9,999,999.99"  //Qtde
									@ Li,060 PSay (TRBTY3->UNIMED)  //Unidade*/
									SomaLinha()
								Endif
								TRBTY3->(dbSkip())
							End
						Endif
						RestArea( aAreaTRB )//Volta área posicionada

						nTotal++
						nTotalSec2++
						dbSkip()
					End
				Endif
				If mv_par07 == 1
					nAtend:=0
					dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
					dbSelectArea("TL5")
					dbSetOrder(4)
					dbSeek(xFilial("TL5") + cCodigo)
					While !Eof() .ANd. cCodigo == TL5->TL5_CODUSU//verifica se é do mesmo usuario
						If (TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)//verificar se esta dentro da data
							nAtend++  //adiciona ao contado um atendimento
							If (dDtAten < TL5->TL5_DTATEN)
								dDtAten:= TL5->TL5_DTATEN
							Endif
						Endif
						dbSkip()
					End
				Endif
				If mv_par07 == 2
					nMotiv:=0
					dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
					dbSelectArea("TL5")
					dbSetOrder(3) //TL5_FILIAL+TL5_MOTIVO
					dbSeek(xFilial("TL5") + cCodigo )
					While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_MOTIVO)
						If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)
							nMotiv++
							If(dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
								dDtAten:= TL5->TL5_DTATEN
							Endif
						Endif
						dbSkip()
					End
				Endif
				dbSelectArea( "TRB" )
				SomaLinha()
				If MV_PAR07 == 1
					@ Li,000 PSay ( STR0028 + cNome + ": " + AllTrim(STR(nTotalSec2)) )  //"Total de Atendimentos de GERTRUDES PERERECA: "
					SomaLinha()
					If (dDataLin == dDtAten)
						@ Li,000 PSay (STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nAtend))//Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
						Somalinha()
					Endif
				ElseIf mv_par07 == 2
					If !Empty(cNome)
						@ Li,000 PSay ( STR0030 + cNome + ": " + AllTrim(STR(nTotalSec2)) )  //"Total de Atendimentos pelo motivo "
						Somalinha()
					Else
						@ Li,000 PSay ( STR0057 + AllTrim(STR(nTotalSec2)) )   //"Total de atendimentos sem motivo: "
						Somalinha()
					Endif
					SomaLinha()
					If (dDataLin == dDtAten) .And. (mv_par07 == 2)
						@ Li,000 PSay (STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nMotiv))//Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
						Somalinha()
					Endif
				Else
					If !Empty(cNome)
						@ Li,000 PSay ( STR0060 + cNome + ": " + AllTrim(STR(nTotalSec2)) )//"Total de Atendimentos pela Indicação "
					Else
						@ Li,000 PSay ( STR0061 + ": " + AllTrim(STR(nTotalSec2)) )//"Total de Atendimentos sem Indicação "
					EndIf
				EndIf
				If Eof() .OR. TRB->DTATEN <> dDataLin
					SomaLinha()
				EndIf
			End

			@ Li,000 PSay (STR0029 + DtoC(dDataLin) + ": " + AllTrim(STR(nTotal)) ) //"Total de Atendimentos na Data xx/xx/xx: 9999 "

			If !Eof()
				SomaLinha()
			EndIf

			SomaLinha()
			@ Li,000 PSAY __PrtThinLine()
		End

	EndIf

	dbSelectArea("TRB")

	If RecCount() == 0
		MsgInfo(STR0058) //"Não há nada para imprimir no relatório."
		RetIndex("TL5")
		oTempTRB2:Delete()
		oTempTY3:Delete()
		Return .F.
	EndIf

	Roda(nCntImpr,cRodaTxt,Tamanho)

	// Devolve a condicao original do arquivo principal
	RetIndex("TL5")
	oTempTRB2:Delete()
	oTempTY3:Delete()
	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	MS_FLUSH()

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha

Incrementa Linha e Controla Salto de Pagina

@author  Rafael Diogo Richter
@since   10/06/2003
/*/
//-------------------------------------------------------------------
Static Function Somalinha()
    Li++

	If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		// Li := Li - 1
    EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Define as secoes impressas no relatorio

@author  Andre E. Perez Alvarez
@since   16/11/2006

@return  oReport, Objeto, O objeto TReport para criacao e visualizacao do relatorio
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Static oReport
	Static oSection0
	Static oSection1
	Static oSection2
	Static oSection3
	Static oBreak1
	Static oCell
	Static oCel2

	// LAYOUT: MV_PAR07 = 1 (Totalizar por Atendente)

	/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	_______________________________________________________________________________________________________________________________________________

														Atendimento de Enfermagem
	_______________________________________________________________________________________________________________________________________________

	F. Médica  Nome                       Motivo               Indicação Medicamento  Qtdade.     Unidade   Horário  Obs
	_______________________________________________________________________________________________________________________________________________
	Data: 99/99/9999

	Atendente: Gertrudes Picareta
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento de Gertrudes Picareta:   5

	Atendente: Virgulino Prates
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento de Virgulino Prates:   5

	Atendente: Gertrudes Picareta
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento de Gertrudes Picareta:   5

	Atendente: Virgulino Prates
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento de Virgulino Prates:   5

	_______________________________________________________________________________________________________________________________________________
	Total de Atendimentos na Data 99/99/9999: 8

	*/


	//LAYOUT: MV_PAR07 = 2 (Totalizar por Motivo Atendimento)

	/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	_______________________________________________________________________________________________________________________________________________

														Atendimento de Enfermagem
	_______________________________________________________________________________________________________________________________________________

	F. Médica  Nome                       Atendente            Indicação Medicamento Qtdade.     Unidade   Horário   Obs
	_______________________________________________________________________________________________________________________________________________
	Data: 99/99/9999

	Motivo: Admissional
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento por motivo Admissional:   5

	Motivo: Admissional
	---------------------------------------
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890
	123456789  1234567890123456789012345  12345678901234567890 123456789012345678901 9999999.99  123456    12345     123456789012345678901234567890

	Total de Atendimento por motivo Admissional:   5

	_______________________________________________________________________________________________________________________________________________
	Total de Atendimentos na Data 99/99/9999: 8

	*/

	// Criacao do componente de impressao
	//
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao

	oReport := TReport():New("MDTR725",OemToAnsi(STR0006),,{|oReport| ReportPrint()},;  // "Atendimento de Enfermagem"
			STR0001+STR0002)   // "Relatório que lista os atendimentos de enfermagem realizados, de acordo com os parâmetros escolhidos."
							   // "É possível escolher o período de atendimento, os motivos e os atendentes."

	// Criacao da secao utilizada pelo relatorio
	//
	// TRSection():New
	// ExpO1 : Objeto TReport que a secao pertence
	// ExpC2 : Descricao da seçao
	// ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela
	//         sera considerada como principal para a seção.
	// ExpA4 : Array com as Ordens do relatório
	// ExpL5 : Carrega campos do SX3 como celulas
	//         Default : False
	// ExpL6 : Carrega ordens do Sindex
	//         Default : False
	//

	// Criacao da celulas da secao do relatorio
	//
	// TRCell():New
	// ExpO1 : Objeto TSection que a secao pertence
	// ExpC2 : Nome da celula do relatório. O SX3 será consultado
	// ExpC3 : Nome da tabela de referencia da celula
	// ExpC4 : Titulo da celula
	//         Default : X3Titulo()
	// ExpC5 : Picture
	//         Default : X3_PICTURE
	// ExpC6 : Tamanho
	//         Default : X3_TAMANHO
	// ExpL7 : Informe se o tamanho esta em pixel
	//         Default : False
	// ExpB8 : Bloco de código para impressao
	//         Default : ExpC2

	If lSigaMdtps

		If (mv_par11 == 1 .Or. mv_par11 == 4)	//Totaliza por Atendente

			//********************* Secao 0 - Cliente
			oSection0 := TRSection():New (oReport, "Cliente", {"TRB","SA1"} )
			oCell := TRCell():New(oSection0, "TRB->CLIENT", "TRB" , "Cliente", "@!", nTa1  )
			oCell := TRCell():New(oSection0, "TRB->LOJA"   , "TRB" , "Loja", "@!", nTa1L  )
			oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , "Nome", "@!", 40  )
			TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT + TRB->LOJA } )

			//********************* Secao 1 - Atendente
			oSection1 := TRSection():New (oReport, STR0011, {"TRB","TMK"} ) //"Atendente"
			oCell := TRCell():New(oSection1, "TRB->CODUSU", "TRB" , STR0012, "@!", 12  )  //"Cód Atendente"
			oCell := TRCell():New(oSection1, "TMK_NOMUSU" , "TMK" , STR0011, "@!", 40  )  //"Atendente"
			TRPosition():New (oSection1, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )

			//********************* Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM0","TMS","TM1"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TMS_NOMOTI" , "TMS", STR0016, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Motivo"
			oCel2 := TRCell():New (oSection2, "TL5_INDICA" , "TL5", STR0017, "@!", 23, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Indicação"
			oSection2:Cell("TL5_INDICA"):SetCBox(RetBoxTL5())
			oCel2 := TRCell():New (oSection2, "TM1_NOMEDI" , "TM1", STR0019, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel2 := TRCell():New (oSection2, "TL5_QTDADE" , "TL5", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel2 := TRCell():New (oSection2, "TM1_UNIDAD" , "TM1", STR0021, "@!", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."

			TRPosition():New (oSection2, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )
			TRPosition():New (oSection2, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

		ElseIf (mv_par11 == 2 .Or. mv_par11 == 5)	//Totaliza por Motivo

			//********************* Secao 0 - Cliente
			oSection0 := TRSection():New (oReport, "Cliente", {"TRB","SA1"} )
			oCell := TRCell():New(oSection0, "TRB->CLIENT", "TRB" , "Cliente", "@!", nTa1  )
			oCell := TRCell():New(oSection0, "TRB->LOJA"   , "TRB" , "Loja", "@!", nTa1L  )
			oCell := TRCell():New(oSection0, "SA1->A1_NOME", "SA1" , "Nome", "@!", 40  )
			TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT + TRB->LOJA } )

			//********************* Secao 1 - Motivo
			oSection1 := TRSection():New (oReport, STR0016, {"TRB","TMS"} ) //"Motivo"
			oCell := TRCell():New(oSection1, "TRB->MOTIVO", "TRB" , STR0024, "@!", 03  )  //"Cód Motivo"
			oCell := TRCell():New(oSection1, "TMS_NOMOTI" , "TMS" , STR0016, "@!", 40  )  //"Motivo"
			TRPosition():New (oSection1, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )

			//********************* Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM0","TMK","TM1"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TRB->CODUSU", "TRB", STR0011, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Atendente"
			oCel2 := TRCell():New (oSection2, "TL5_INDICA" , "TL5", STR0017, "@!", 23, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Indicação"
			oSection2:Cell("TL5_INDICA"):SetCBox(RetBoxTL5())
			oCel2 := TRCell():New (oSection2, "TM1_NOMEDI" , "TM1", STR0019, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel2 := TRCell():New (oSection2, "TL5_QTDADE" , "TL5", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel2 := TRCell():New (oSection2, "TM1_UNIDAD" , "TM1", STR0021, "@!", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."

			TRPosition():New (oSection2, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )
			TRPosition():New (oSection2, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

		Else	//Totaliza por Indicação

			//********************* Secao 1 - Indicação
			oSection1 := TRSection():New (oReport, STR0017, {"TRB","TL5"} ) //"Indicação"
			oCell := TRCell():New(oSection1, "TRB->INDICA", "TRB" , STR0024, "@!", 01  )  //"Cód Indicação"
			oCell := TRCell():New(oSection1, "TL5_INDICA" , "TL5" , STR0017, "@!", 40  )  //"Indicação"
			TRPosition():New (oSection1, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED  } )

			//********************* Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM0","TMK","TM1"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TRB->CODUSU", "TRB", STR0011, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Atendente"
			oCel2 := TRCell():New (oSection2, "TMS_NOMOTI" , "TMS", STR0016, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Motivo"
			oCel2 := TRCell():New (oSection2, "TM1_NOMEDI" , "TM1", STR0019, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel2 := TRCell():New (oSection2, "TL5_QTDADE" , "TL5", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel2 := TRCell():New (oSection2, "TM1_UNIDAD" , "TM1", STR0021, "@!", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."

			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )
			TRPosition():New (oSection2, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )
			TRPosition():New (oSection2, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

		Endif

	Else

		If (mv_par07 == 1  .Or. mv_par07 == 4)	//Totaliza por Atendente

			// Secao 1 - Atendente
			oSection1 := TRSection():New (oReport, STR0011, {"TRB","TMK"} ) //"Atendente"
			oCell := TRCell():New(oSection1, "TRB->CODUSU", "TRB" , STR0012, "@!", 12  )  //"Cód Atendente"
			oCell := TRCell():New(oSection1, "TMK_NOMUSU" , "TMK" , STR0011, "@!", 40  )  //"Atendente"
			TRPosition():New (oSection1, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )

			// Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM0","TMS"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TMS_NOMOTI" , "TMS", STR0016, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Motivo"
			oCel2 := TRCell():New (oSection2, "TRB->INDNOM", "TRB", STR0017, "@!", 23, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Indicação"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100,/*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."
			TRPosition():New (oSection2, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )

			oSection3 := TRSection():New (oReport,STR0013, {"TRB","TM1","TY3"} ) //"Atendimentos"
			oCel3 := TRCell():New (oSection3, "TRB->DESMED", "TRB", STR0019, "@!",              20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel3 := TRCell():New (oSection3, "TRB->QUANT" , "TRB", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel3 := TRCell():New (oSection3, "TM1_UNIDAD" , "TM1", STR0021, "@!",              06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			TRPosition():New (oSection3, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection3, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

			//Aponta que a impressão da seção quebra linhas no caso das colunas não couberem em uma linha.
			oSection2:Cell("TRB->OBSERV"):lLineBreak := .T.

		ElseIf (mv_par07 == 2 .Or. mv_par07 == 5)//Totaliza por Motivo

			// Secao 1 - Motivo
			oSection1 := TRSection():New (oReport, STR0016, {"TRB","TMS"} ) //"Motivo"
			oCell := TRCell():New(oSection1, "TRB->MOTIVO", "TRB" , STR0024, "@!", 03  )  //"Cód Motivo"
			oCell := TRCell():New(oSection1, "TMS_NOMOTI" , "TMS" , STR0016, "@!", 40  )  //"Motivo"
			TRPosition():New (oSection1, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )

			// Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TM0","TMK","TM1"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TRB->CODUSU", "TRB", STR0011, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Atendente"
			oCel2 := TRCell():New (oSection2, "TRB->INDNOM", "TRB", STR0017, "@!", 23, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Indicação"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."

			//TRPosition():New (oSection2, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )

			oSection3 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM1","TY3"} ) //"Atendimentos"
			oCel3 := TRCell():New (oSection3, "TRB->DESMED", "TRB", STR0019, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel3 := TRCell():New (oSection3, "TRB->QUANT" , "TRB", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel3 := TRCell():New (oSection3, "TM1_UNIDAD" , "TM1", STR0021, "@!", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			TRPosition():New (oSection3, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection3, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

			//Aponta que a impressão da seção quebra linhas no caso das colunas não couberem em uma linha.
			oSection2:Cell("TRB->OBSERV"):lLineBreak := .T.

		Else	//Totaliza por Indicação

			// Secao 1 - Indicação
			oSection1 := TRSection():New (oReport, STR0017, {"TRB","TL5"} ) //"Indicação"
			oCell := TRCell():New(oSection1, "TRB->INDICA", "TRB" , STR0024, "@!", 01  )  //"Cód Indicação"
			oCell := TRCell():New(oSection1, "TRB->INDNOM", "TRB" , STR0017, "@!", 40  )  //"Indicação"
			TRPosition():New (oSection1, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED  } )

			// Secao 2 - Atendimentos
			oSection2 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM0","TMK","TM1"} ) //"Atendimentos"
			oCel2 := TRCell():New (oSection2, "TRB->NUMFIC", "TRB", STR0014, "@!", 15, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Ficha Médica"
			oCel2 := TRCell():New (oSection2, "TM0_NOMFIC" , "TM0", STR0015, "@!", 25, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Nome"
			oCel2 := TRCell():New (oSection2, "TRB->CODUSU", "TRB", STR0011, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Atendente"
			oCel2 := TRCell():New (oSection2, "TMS_NOMOTI" , "TMS", STR0016, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Motivo"
			oCel2 := TRCell():New (oSection2, "TRB->HRATEN", "TRB", STR0022, "@!", 07, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Horário"
			oCel2 := TRCell():New (oSection2, "TRB->OBSERV", "TRB", STR0023, "@!", 100, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Obs."

			TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TRB->NUMFIC } )
			TRPosition():New (oSection2, "TMK", 1, {|| xFilial("TMK") + TRB->CODUSU } )
			TRPosition():New (oSection2, "TMS", 1, {|| xFilial("TMS") + TRB->MOTIVO } )

			oSection3 := TRSection():New (oReport,STR0013, {"TRB","TL5","TM1","TY3"} ) //"Atendimentos"
			oCel3 := TRCell():New (oSection3, "TRB->DESMED", "TRB", STR0019, "@!", 20, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Medicamento"
			oCel3 := TRCell():New (oSection3, "TRB->QUANT" , "TRB", STR0020, "@E 9,999,999.99", 09, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Qtdade."
			oCel3 := TRCell():New (oSection3, "TM1_UNIDAD" , "TM1", STR0021, "@!", 06, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Unidade"
			TRPosition():New (oSection3, "TL5", 1, {|| xFilial("TL5") + TRB->NUMFIC + DTOS(TRB->DTATEN) + TRB->HRATEN + TRB->INDICA + TRB->CODMED } )
			TRPosition():New (oSection3, "TM1", 1, {|| xFilial("TM1") + TRB->CODMED } )

			// Aponta que a impressão da seção quebra linhas no caso das colunas não couberem em uma linha.
			oSection2:Cell("TRB->OBSERV"):lLineBreak := .T.

		Endif

	Endif

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint

Imprime o relatorio.

@author  Andre E. Perez Alvarez
@since   16/11/06

@return  .T., Logico
/*/
//-------------------------------------------------------------------
Static Function ReportPrint()

	Local lPrin := .T.
	Local dDataLin
	Local cCodigo
	Local cNome
	Local nTotal
	Local nTotalSec2
	Local nAtend:=0
	Local nMotiv:=0
	Local dDtAten:=CTOD("  /  /  ")
	Private cFilMed := ""

	cabec1 := ""
	cabec2 := ""

	Processa( {|lEND| TRBgrava()}, STR0025, STR0026 ) //"Aguarde" ## "Processando os atendimentos..."


	If lSigaMdtps

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		oReport:SetMeter( RecCount() )

		If (MV_PAR11 == 1 .Or. MV_PAR11 == 4)
			cKeyWhile := "TRB->CODUSU"
		ElseIf (MV_PAR11 == 2 .Or. MV_PAR11 == 5)
			cKeyWhile := "TRB->MOTIVO"
		Else
			cKeyWhile := "TRB->INDICA"
		EndIf
		oSection1:Cell(cKeyWhile):Disable()

		While !oReport:Cancel() .AND.;
			!Eof()

			cCliente := TRB->CLIENT+TRB->LOJA
			oSection0:Init() //-- Cliente
			oSection0:PrintLine()
			oReport:SkipLine()

			While !oReport:Cancel() 		  .AND.;
				!Eof()					  .AND.;
				cCliente == TRB->CLIENT+TRB->LOJA

				oReport:IncMeter()

				dDataLin := TRB->DTATEN
				nTotal := 0
				If (MV_PAR11 == 1 .Or. MV_PAR11 == 2 .Or. MV_PAR11 == 3 )
					oReport:PrintText(STR0027 + DtoC(TRB->DTATEN), , )  //"Data: "
				Endif
				While !oReport:Cancel() 		  .AND.;
					!Eof()					  .AND.;
					TRB->DTATEN == dDataLin     .AND.;
					cCliente == TRB->CLIENT+TRB->LOJA

					cCodigo := &(cKeyWhile)
					nTotalSec2 := 0
					oSection1:Init() //-- Atendente
					oSection1:PrintLine()
					If (mv_par11 == 1 .Or. MV_PAR11 == 4)
						cNome := Upper( AllTrim(SubStr( TMK->TMK_NOMUSU, 1 , 40 ) ) )
					ElseIf (mv_par11 == 2 .Or. MV_PAR11 == 5)
						cNome := Upper( AllTrim(TMS->TMS_NOMOTI) )
					Else
						cNome := AllTrim(TL5->TL5_INDICA)
					EndIf
					oSection2:Init() //-- Atendimentos
					If (mv_par11 == 1 .Or. mv_par11 == 2 .Or. mv_par11 == 3)
						While !oReport:Cancel()	 			.AND.;
							!Eof() 			 		    .AND.;
							TRB->DTATEN == dDataLin	    .AND.;
							&(cKeyWhile) == cCodigo        .AND.;
							cCliente == TRB->CLIENT+TRB->LOJA

							oReport:IncMeter()
							oSection2:PrintLine()
							nTotal++
							nTotalSec2++
							dbSkip()
						End
					Else
						While !oReport:Cancel()	 		.AND.;
						!Eof()			 			.AND.;
						&(cKeyWhile) == cCodigo

							oReport:IncMeter()
							oSection2:PrintLine()
							nTotal++
							nTotalSec2++
							dbSkip()
						End
					Endif
					If mv_par11 == 1
						nAtend:=0
						dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
						dbSelectArea("TL5")
						dbSetOrder(4)
						dbSeek(xFilial("TL5") + cCodigo)
						While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_CODUSU)//verifica se é do mesmo usuario
							If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)//verificar se esta dentro da data
								nAtend++  //adiciona ao contado um atendimento
								If (dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
									dDtAten:= TL5->TL5_DTATEN
								Endif
							Endif
							dbSkip()
						End
					Endif
					If mv_par11 == 2
						nMotiv:=0
						dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
						dbSelectArea("TL5")
						dbSetOrder(3)
						dbSeek(xFilial("TL5") + cCodigo )
						While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_MOTIVO)
							If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)
								nMotiv++
								If(dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
									dDtAten:= TL5->TL5_DTATEN
								Endif
							Endif
							dbSkip()
						End
					Endif
					dbSelectArea( "TRB" )
					oSection2:Finish()
					oSection1:Finish()
					oReport:SkipLine()
					If (MV_PAR11 == 1 .Or. MV_PAR11 = 4)
						oReport:PrintText( STR0028 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,) //"Total de Atendimentos de GERTRUDES PERERECA: "
						If (dDataLin == dDtAten) .And. (mv_par11 == 1)
							oReport:PrintText(STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nAtend)) //Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
						Endif //Imprime a quantidade de atendimentos/
					ElseIf (MV_PAR11 == 2 .Or. MV_PAR11 == 5)
						If !Empty(cNome)
							oReport:PrintText( STR0030 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,) //"Total de Atendimento por motivo ADMISSIONAL: "
						Else
							oReport:PrintText( STR0057 + AllTrim(STR(nTotalSec2)), ,)  //"Total de Atendimentos sem motivo: "
						Endif
						If (dDataLin == dDtAten) .And. (mv_par11 == 2)
							oReport:PrintText(STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nMotiv)) //Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
						Endif
					Else
						If !Empty(cNome)
							oReport:PrintText( STR0060 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,)//"Total de Atendimentos pela Indicação "
						Else
							oReport:PrintText( STR0061 + ": " + AllTrim(STR(nTotalSec2)), ,)//"Total de Atendimentos sem Indicação "
						EndIf
					EndIf
				End

				oReport:SkipLine()
				oReport:PrintText(STR0029 + DtoC(dDataLin) + ": " + AllTrim(STR(nTotal)), , ) //"Total de Atendimento na Data xx/xx/xx: 9999 "
				If !Eof()
					oReport:SkipLine()
				Endif
			End
			oSection0:Finish()
		End

	Else

		dbSelectArea( "TRB" )
		dbSetOrder( 1 )
		dbGoTop()

		oReport:SetMeter( RecCount() )

		If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
			cKeyWhile := "TRB->CODUSU"
		ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
			cKeyWhile := "TRB->MOTIVO"
		Else
			cKeyWhile := "TRB->INDICA"
		EndIf

		oSection1:Cell(cKeyWhile):Disable()

		While !oReport:Cancel()	.And. !Eof()

			oReport:IncMeter()

			dDataLin := TRB->DTATEN
			nTotal := 0

			If (MV_PAR07 == 1 .Or. MV_PAR07 == 2 .Or. MV_PAR07 == 3)
				oReport:PrintText(STR0027 + DtoC(TRB->DTATEN), , )  //"Data: "
			EndIf

			If lPrin
				oReport:SkipLine()
				lPrin := .F.
			EndIf

			While !oReport:Cancel() .And. !Eof() .And. TRB->DTATEN == dDataLin

				cCodigo := &(cKeyWhile)
				nTotalSec2 := 0
				oSection1:Init() // Motivo
				oSection1:PrintLine()

				If (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					cNome := Upper( AllTrim(SubStr( TMK->TMK_NOMUSU, 1 , 40 ) ) )
				ElseIf (MV_PAR07 == 2 .Or. MV_PAR07 == 5)
					cNome := Upper( AllTrim(TMS->TMS_NOMOTI) )
				Else
					cNome := AllTrim(TRB->INDNOM)
				EndIf

				oSection2:Init() // Atendimentos
				oSection3:Init() // Medicamentos
				cNumFic := TRB->NUMFIC

				If(mv_par07 == 1 .Or. mv_par07 == 2 .Or. mv_par07 == 3 )

					While !oReport:Cancel() .And. !Eof() .And. cNumFic == TRB->NUMFIC .And.;
						   TRB->DTATEN == dDataLin .And. &(cKeyWhile) == cCodigo // Imprimi os Atendimentos

						oReport:IncMeter()
						oSection2:PrintLine()
						lMedic := .T.
						//cNumFic := TRB->NUMFIC

						While !Eof() .And. cNumFic == TRB->NUMFIC .And. !Empty( TRB->CODMED )//Imprimi os Medicamentos
							oSection3:PrintLine()
							lMedic := .F.
							dbSkip()
						End

						If cFilMed <> DtoS(TRB->DTATEN)+TRB->HRATEN+TRB->NUMFIC+TRB->INDICA
							cFilMed := DtoS(TRB->DTATEN)+TRB->HRATEN+TRB->NUMFIC+TRB->INDICA
							nTotal++
							nTotalSec2++
						EndIf

						If lMedic //se caso possuir medicamento, ñ pula 2 vezes o registro
							dbSkip()
						EndIf

					EndDo

				Else

					While !oReport:Cancel() .And. !Eof() .And. TRB->DTATEN == dDataLin .And.;
					      &(cKeyWhile) == cCodigo .And. cNumFic == TRB->NUMFIC

						oReport:IncMeter()
						oSection2:PrintLine()
						lMedic := .T.
						cNumFic := TRB->NUMFIC

						While !Eof() .And. cNumFic == TRB->NUMFIC .And. !Empty( TRB->CODMED ) .And. TRB->DTATEN == dDataLin//Imprimi os Medicamentos
							oSection3:PrintLine()
							lMedic := .F.
							dbSkip()
						End

						If cFilMed <> DtoS(TRB->DTATEN)+TRB->HRATEN+TRB->NUMFIC+TRB->INDICA
							cFilMed := DtoS(TRB->DTATEN)+TRB->HRATEN+TRB->NUMFIC+TRB->INDICA
							nTotal++
							nTotalSec2++
						EndIf

						If lMedic //se caso possuir medicamento, ñ pula 2 vezes o registro
							dbSkip()
						EndIf

					End

				EndIf

				If mv_par07 == 1
					nAtend:=0
					dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
					dbSelectArea("TL5")
					dbSetOrder(4)
					dbSeek(xFilial("TL5") + cCodigo)

					While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_CODUSU)//verifica se é do mesmo usuario

						If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)//verificar se esta dentro da data
							nAtend++  //adiciona ao contado um atendimento

							If (dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
								dDtAten:= TL5->TL5_DTATEN
							EndIf

						EndIf

						dbSkip()
					End

				EndIf

				If mv_par07 == 2
					nMotiv:=0
					dDtAten:=CTOD("  /  /  ")//Zera o contador quantidade de Atendimento
					dbSelectArea("TL5")
					dbSetOrder(3)
					dbSeek(xFilial("TL5") + cCodigo )
					While !Eof() .And. Alltrim(cCodigo) == Alltrim(TL5->TL5_MOTIVO)

						If(TL5->TL5_DTATEN >= Mv_par01 .And. TL5->TL5_DTATEN <= Mv_par02)
							nMotiv++

							If(dDtAten < TL5->TL5_DTATEN) //verifica qual a ultima data
								dDtAten:= TL5->TL5_DTATEN
							EndIf

						EndIf

						dbSkip()
					End

				Endif

				dbSelectArea( "TRB" )
				oSection3:Finish()
				oSection2:Finish()
				oSection1:Finish()
				oReport:SkipLine()

				If  (MV_PAR07 == 1 .Or. MV_PAR07 == 4)
					oReport:PrintText( STR0028 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,) //"Total de Atendimentos de GERTRUDES PERERECA: "

					If (dDataLin == dDtAten) .And. (mv_par07 == 1)
						oReport:PrintText(STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nAtend)) //Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
					EndIf

				ElseIf  (MV_PAR07 == 2 .Or. MV_PAR07 == 5)

					If !Empty(cNome)
						oReport:PrintText( STR0030 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,) //"Total de Atendimento por motivo ADMISSIONAL: "
					Else
						oReport:PrintText( STR0057 + AllTrim(STR(nTotalSec2)), ,)  //"Total de Atendimentos sem motivo: "
					EndIf

					If (dDataLin == dDtAten) .And. (mv_par07 == 2)
						oReport:PrintText(STR0063+cValToChar(Mv_par01)+STR0064+cValToChar(Mv_par02)+": "+ cValToChar(nMotiv)) //Total de atendimentos no periodo de 00/00/0000 à 00/00/0000 : ##
					EndIf

				Else

					If !Empty(cNome)
						oReport:PrintText( STR0060 + cNome + ": " + AllTrim(STR(nTotalSec2)), ,)//"Total de Atendimentos pela Indicação "
					Else
						oReport:PrintText( STR0061 + ": " + AllTrim(STR(nTotalSec2)), ,)//"Total de Atendimentos sem Indicação "
					EndIf

				EndIf

			End

			oReport:SkipLine()
			oReport:PrintText(STR0029 + DtoC(dDataLin) + ": " + AllTrim(STR(nTotal)), , ) //"Total de Atendimento na Data xx/xx/xx: 9999 "

			If !Eof()
				oReport:SkipLine()
			EndIf

		End

	EndIf

	dbSelectArea("TRB")
	If RecCount() == 0
		MsgInfo(STR0058)   //"Não há nada para imprimir no relatório."
		oTempTRB:Delete()
		Return .F.
	Endif

	oTempTRB:Delete()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT725Mot

Valida a pergunta Ate Motivo.

@author  Andre E. Perez Alvarez
@since   16/11/2006
/*/
//-------------------------------------------------------------------
User Function MDT725Mot()

	If lSigaMdtps
		Return If( mv_par08=="ZZ", .T., ExistCPO('TMS',mv_par08) .AND. AteCodigo('TMS',mv_par07,mv_par08,3) )
	Else
		Return If( mv_par04=="ZZ", .T., ExistCPO('TMS',mv_par04) .AND. AteCodigo('TMS',mv_par03,mv_par04,3) )
	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT725Ate

Valida a pergunta Ate Atendente

@author  Andre E. Perez Alvarez
@since   16/11/2006
/*/
//-------------------------------------------------------------------
User Function MDT725Ate()

	If lSigaMdtps
		Return If( mv_par10==Replicate("Z",12), .T., ExistCPO('TMK',mv_par10) .AND. AteCodigo('TMK',mv_par09,mv_par10,12) )
	Else
		Return If( mv_par06==Replicate("Z",12), .T., ExistCPO('TMK',mv_par06) .AND. AteCodigo('TMK',mv_par05,mv_par06,12) )
	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava

Processa os registros de acordo com os parametros e grava no arquivo temporario.

@author  Andre E. Perez Alvarez
@since   31/07/06
/*/
//-------------------------------------------------------------------
Static Function TRBgrava()

	Local cIndex := ""
	Local cChave := ""
	Local cFiltro
	Local aDBF := {}
	Local vIND := {}

	fCreateTRB(1) // Cria a estrutura da TRB
	dbSelectArea( "TL5" )
	dbSetOrder( 1 )

	// Mapeamento dos parametros
	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR09
		xm_par6 := MV_PAR10
		xm_par7 := mv_par11
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR05
		xm_par6 := MV_PAR06
		xm_par7 := mv_par07
	EndIf

	If xm_par7 == 1  // Totaliza por Atendente
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_CODUSU, TL5.TL5_NUMFIC, TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 2	// Totaliza por Motivo
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_MOTIVO, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 3  // Totaliza por Indicação
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_INDICA, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_MOTIVO, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 4 // Totaliza por Atendente
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_CODUSU, TL5.TL5_NUMFIC, TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	Else // Totalizar por Motivo
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_MOTIVO, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	Endif

	// Condição para Prestador
	cSQLPrest := "%%"
	If lSigaMdtps
		cSQLPrest := "%SUBSTRING(RA_CC,1,"+ValToSQL(nSizeTD)+") BETWEEN " + ;
					  ValToSQL( mv_par01+mv_par02 ) + " AND " + ValToSQL( mv_par03+mv_par04 ) + "% AND"
	EndIf

	// Filtra os registros da tabela TL5 de acordo com os parametros
	BeginSQL Alias cTRBTL5
		SELECT TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_CODUSU, TL5.TL5_NUMFIC,
		TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED, TL5.TL5_HRATEN, TL5.TL5_OBSSYP
		FROM %table:TL5% TL5
		WHERE
		TL5_FILIAL = %xFilial:TL5% AND
		TL5_DTATEN BETWEEN %exp:xm_par1% AND %exp:xm_par2% AND
		TL5_MOTIVO BETWEEN %exp:xm_par3% AND %exp:xm_par4% AND
		TL5_CODUSU BETWEEN %exp:xm_par5% AND %exp:xm_par6% AND
		%exp:cSQLPrest%
		TL5.%notDel%
		ORDER BY %exp:cChave%
	EndSQL

	dbSelectArea( cTRBTL5 )
	dbGoTop()
	dbSelectArea( "TL5" )
	dbSetOrder( 1 ) //TL5_FILIAL+TL5_NUMFIC+DTOS(TL5_DTATEN)+TL5_HRATEN+TL5_INDICA+TL5_CODMED
	dbSeek( ( cTRBTL5 )->TL5_FILIAL + ( cTRBTL5 )->TL5_NUMFIC )
	ProcRegua( reccount() )

	If lSigaMdtps

		//--------------------------------------
		//Grava os dados no arquivo temporario
		//--------------------------------------

		While ( cTRBTL5 )->( !Eof() ) .AND. If(lPersonal,!oReport:Cancel(),.T.)

			IncProc()

			dbSelectArea("TM0")
			dbSetOrder(1)
			dbSeek(xFilial("TM0")+TL5->TL5_NUMFIC)
			If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
				dbSelectArea("TL5")
				dbSkip()
				Loop
			Endif

			TRB->(dbAppend())
			TRB->CLIENT := TM0->TM0_CLIENT
			TRB->LOJA   := TM0->TM0_LOJA
			TRB->DTATEN := TL5->TL5_DTATEN
			TRB->HRATEN := TL5->TL5_HRATEN
			TRB->CODUSU := TL5->TL5_CODUSU
			TRB->NUMFIC := TL5->TL5_NUMFIC
			TRB->MOTIVO := TL5->TL5_MOTIVO
			TRB->INDICA := TL5->TL5_INDICA
			TRB->CODMED := TL5->TL5_CODMED

			dbSelectArea( "TL5" )
			dbSkip()
			( cTRBTL5 )->( dbSkip() )
		End

	Else

		// Grava os dados no arquivo temporario
		While ( cTRBTL5 )->( !Eof() ) .And. If( lPersonal, !oReport:Cancel(), .T. )

			IncProc()

			// Grava os os Medicamentos da TY3
			aAreaTY3 := TY3->( GetArea() )// Salva área
			dbSelectArea("TY3")
			dbSetOrder(1)// TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED

			If dbSeek(xFilial("TY3")+TL5->TL5_NUMFIC+DTOS(TL5->TL5_DTATEN)+TL5->TL5_HRATEN+TL5->TL5_INDICA)

				While TY3->(!Eof()) .And. TY3->TY3_NUMFIC == TL5->TL5_NUMFIC .And. TL5->TL5_DTATEN == TY3->TY3_DTATEN .And. ;
					  TL5->TL5_HRATEN == TY3->TY3_HRATEN .And. TL5->TL5_INDICA == TY3->TY3_INDICA
					TRB->(dbAppend())
					TRB->DTATEN := SToD( ( cTRBTL5 )->TL5_DTATEN )
					TRB->HRATEN := ( cTRBTL5 )->TL5_HRATEN
					TRB->CODUSU := ( cTRBTL5 )->TL5_CODUSU
					TRB->NUMFIC := ( cTRBTL5 )->TL5_NUMFIC
					TRB->MOTIVO := ( cTRBTL5 )->TL5_MOTIVO
					TRB->INDICA := ( cTRBTL5 )->TL5_INDICA
					TRB->OBSERV := MsMM( ( cTRBTL5 )->TL5_OBSSYP , 80 )
					TRB->CODMED := TY3->TY3_CODMED
					TRB->DESMED := NGSeek('TM1',TRB->CODMED,1,'TM1->TM1_NOMEDI')
					TRB->QUANT  := TY3->TY3_QUANT
					TRB->INDNOM := NGRETSX3BOX("TL5_INDICA",( cTRBTL5 )->TL5_INDICA)

					TY3->(dbSkip())
				End

			Else
				TRB->(dbAppend())
				TRB->DTATEN := SToD( ( cTRBTL5 )->TL5_DTATEN )
				TRB->HRATEN := ( cTRBTL5 )->TL5_HRATEN
				TRB->CODUSU := ( cTRBTL5 )->TL5_CODUSU
				TRB->NUMFIC := ( cTRBTL5 )->TL5_NUMFIC
				TRB->MOTIVO := ( cTRBTL5 )->TL5_MOTIVO
				TRB->INDICA := ( cTRBTL5 )->TL5_INDICA
				TRB->OBSERV := MsMM( ( cTRBTL5 )->TL5_OBSSYP , 10 )
				TRB->INDNOM := NGRETSX3BOX("TL5_INDICA", ( cTRBTL5 )->TL5_INDICA)
			EndIf

			RestArea( aAreaTY3 ) // Volta área posicionada
			dbSelectArea( "TL5" )
			TL5->( DbSkip() )
			( cTRBTL5 )->( dbSkip() )
		End

	EndIf

	dbSelectArea( cTRBTL5 )
	dbCloseArea()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR725

Relatorio de Atendimento Diario - Enfermagem

@author  Rafael Diogo Richter
@since   10/06/03
/*/
//-------------------------------------------------------------------
User Function MDTR725R3()

	Local wnrel   := "MDTR725"
	Local limite  := 132
	Local cDesc1  := STR0001 // "Relatório que lista os atendimentos de enfermagem realizados, de acordo com os parâmetros escolhidos. "
	Local cDesc2  := STR0002 // "É possível escolher o período de atendimento, os motivos e os atendentes. "
	Local cDesc3  := STR0003 // "selecionado Motivo, Medico e Periodo desejado"
	Local cString := "TMJ"

	Private nomeprog := "MDTR725"
	Private tamanho  := "G"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } // "Zebrado"###"Administracao"
	Private titulo   := STR0006 // "Atendimento de Enfermagem"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cabec1, cabec2

	pergunte(cPerg,.F.)

	wnrel:="MDTR725"

	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
	Set Filter to
	Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
	Set Filter to
	Return
	Endif

	Processa( {|lEND| GRAVATRB2()}, STR0025, STR0026 ) //"Aguarde" ## "Processando os atendimentos..."

	RptStatus({|lEnd| U_R725Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} GRAVATRB2

Processa os registros de acordo com os parametros e grava no arquivo temporario.

@author  Andre E. Perez Alvarez
@since   01/10/07
/*/
//-------------------------------------------------------------------
Static Function GRAVATRB2()

	Local cIndex := ""
	Local cChave := ""
	Local cFiltro
	Local aDBF := {}
	Local vIND := {}
	Local aDBFTY3 := {}
	Local vINDTY3 := {}
	Local aAreaTL5 := {}

	fCreateTRB(2)

	dbSelectArea( "TL5" )
	dbSetOrder( 1 )

	// Mapeando os parametros
	If lSigaMdtps
		xm_par1 := MV_PAR05
		xm_par2 := MV_PAR06
		xm_par3 := MV_PAR07
		xm_par4 := MV_PAR08
		xm_par5 := MV_PAR09
		xm_par6 := MV_PAR10
		xm_par7 := mv_par11
	Else
		xm_par1 := MV_PAR01
		xm_par2 := MV_PAR02
		xm_par3 := MV_PAR03
		xm_par4 := MV_PAR04
		xm_par5 := MV_PAR05
		xm_par6 := MV_PAR06
		xm_par7 := mv_par07
	EndIf

	If xm_par7 == 1  // Totaliza por Atendente
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_CODUSU, TL5.TL5_NUMFIC, TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 2	// Totaliza por Motivo
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_MOTIVO, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 3  // Totaliza por Indicação
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_INDICA, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_MOTIVO, TL5.TL5_CODMED%"
	ElseIf xm_par7 == 4 // Totaliza por Atendente
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_CODUSU, TL5.TL5_NUMFIC, TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	Else // Totalizar por Motivo
		cChave := "%TL5.TL5_FILIAL, TL5.TL5_MOTIVO, TL5.TL5_NUMFIC, TL5.TL5_CODUSU, TL5.TL5_INDICA, TL5.TL5_CODMED%"
	Endif

	//Condição para Prestador
	cSQLPrest := "%%"
	If lSigaMdtps
		cSQLPrest := "%SUBSTRING(RA_CC,1,"+ValToSQL(nSizeTD)+") BETWEEN " + ;
						ValToSQL( mv_par01+mv_par02 ) + " AND " + ValToSQL( mv_par03+mv_par04 ) + "% AND"
	EndIf

	// Filtra os registros da tabela TL5 de acordo com os parametros
	BeginSQL Alias cTRBTL5
		SELECT TL5.TL5_FILIAL, TL5.TL5_DTATEN, TL5.TL5_CODUSU, TL5.TL5_NUMFIC,
		TL5.TL5_MOTIVO, TL5.TL5_INDICA, TL5.TL5_CODMED, TL5.TL5_HRATEN, TL5.TL5_OBSSYP
		FROM %table:TL5% TL5
		WHERE
		TL5_FILIAL = %xFilial:TL5% AND
		TL5_DTATEN BETWEEN %exp:xm_par1% AND %exp:xm_par2% AND
		TL5_MOTIVO BETWEEN %exp:xm_par3% AND %exp:xm_par4% AND
		TL5_CODUSU BETWEEN %exp:xm_par5% AND %exp:xm_par6% AND
		%exp:cSQLPrest%
		TL5.%notDel%
		ORDER BY %exp:cChave%
	EndSQL

	ProcRegua( reccount() )

	If lSigaMdtps

		//---------------------------------------
		//Grava os dados no arquivo temporario
		//---------------------------------------

		While ( cTRBTL5 )->( !Eof() )

			IncProc()

			dbSelectArea("TM0")
			dbSetOrder(1)
			dbSeek(xFilial("TM0")+TL5->TL5_NUMFIC)
			If TM0->TM0_CLIENT+TM0->TM0_LOJA < mv_par01+mv_par02 .or. TM0->TM0_CLIENT+TM0->TM0_LOJA > mv_par03+mv_par04
				dbSelectArea("TL5")
				dbSkip()
				Loop
			Endif

			TRB->(dbAppend())
			TRB->CLIENT := TM0->TM0_CLIENT
			TRB->LOJA   := TM0->TM0_LOJA
			TRB->DTATEN := TL5->TL5_DTATEN
			TRB->HRATEN := TL5->TL5_HRATEN
			TRB->CODUSU := TL5->TL5_CODUSU
			TRB->NOMUSU := NGSeek('TMK',TRB->CODUSU,1,'TMK->TMK_NOMUSU')
			TRB->NUMFIC := TL5->TL5_NUMFIC
			TRB->NOMFIC := NGSeek('TM0',TRB->NUMFIC,1,'TM0->TM0_NOMFIC')
			TRB->MOTIVO := TL5->TL5_MOTIVO
			TRB->NOMOTI := NGSeek('TMS',TRB->MOTIVO,1,'TMS->TMS_NOMOTI')
			TRB->INDICA := TL5->TL5_INDICA
			TRB->CODMED := TL5->TL5_CODMED
			TRB->NOMEDI := NGSeek('TM1',TRB->CODMED,1,'TM1->TM1_NOMEDI')
			TRB->QTDADE := TL5->TL5_QTDADE
			TRB->UNIDAD := NGSeek('TM1',TRB->CODMED,1,'TM1->TM1_UNIDAD')
			TRB->OBSERV := TL5->TL5_OBSERV
			dbSelectArea( "TL5" )
			dbSkip()
			( cTRBTL5 )->( dbSkip() )
		End

	Else


		// Grava os dados no arquivo temporario
		While !Eof()

			IncProc()
			TRB->(dbAppend())
			TRB->DTATEN := SToD( ( cTRBTL5 )->TL5_DTATEN )
			TRB->HRATEN := ( cTRBTL5 )->TL5_HRATEN
			TRB->CODUSU := ( cTRBTL5 )->TL5_CODUSU
			TRB->NOMUSU := NGSeek('TMK',TRB->CODUSU,1,'TMK->TMK_NOMUSU')
			TRB->NUMFIC := ( cTRBTL5 )->TL5_NUMFIC
			TRB->NOMFIC := NGSeek('TM0',TRB->NUMFIC,1,'TM0->TM0_NOMFIC')
			TRB->MOTIVO := ( cTRBTL5 )->TL5_MOTIVO
			TRB->NOMOTI := NGSeek('TMS',TRB->MOTIVO,1,'TMS->TMS_NOMOTI')
			TRB->INDICA := ( cTRBTL5 )->TL5_INDICA
			TRB->INDNOM := NGRETSX3BOX("TL5_INDICA",( cTRBTL5 )->TL5_INDICA)
			TRB->OBSERV := MsMM( ( cTRBTL5 )->TL5_OBSSYP, 80 )

		// Grava os os Medicamentos da TY3
			aAreaTL5 := GetArea()//Salva área
			dbSelectArea("TY3")
			dbSetOrder(1)//TY3_FILIAL+TY3_NUMFIC+DTOS(TY3_DTATEN)+TY3_HRATEN+TY3_INDICA+TY3_CODMED
			If dbSeek(xFilial("TY3")+TL5->TL5_NUMFIC+DTOS(TL5->TL5_DTATEN)+TL5->TL5_HRATEN+TL5->TL5_INDICA)
				While TY3->(!Eof()) .And. TY3->TY3_NUMFIC == TL5->TL5_NUMFIC .And. TL5->TL5_DTATEN == TY3->TY3_DTATEN .And. ;
						TL5->TL5_HRATEN == TY3->TY3_HRATEN .And. TL5->TL5_INDICA == TY3->TY3_INDICA

					TRBTY3->(dbAppend())
					TRBTY3->CODMED := TY3->TY3_CODMED
					TRBTY3->NUMFIC := TY3->TY3_NUMFIC
					TRBTY3->DTATEN := TY3->TY3_DTATEN
					TRBTY3->HRATEN := TY3->TY3_HRATEN
					TRBTY3->INDICA := TY3->TY3_INDICA
					TRBTY3->DESMED := NGSeek('TM1',TRBTY3->CODMED,1,'TM1->TM1_NOMEDI')
					TRBTY3->QUANT  := TY3->TY3_QUANT
					TRBTY3->UNIMED := NGSeek('TM1',TRBTY3->CODMED,1,'TM1->TM1_UNIDAD')

					TY3->(dbSkip())
				End
			Endif

			RestArea( aAreaTL5 )//Volta área posicionada

			dbSelectArea( "TL5" )
			TL5->(dbSkip())
			( cTRBTL5 )->( dbSkip() )
		End

	Endif

 	dbSelectArea( cTRBTL5 )
	dbCloseArea()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT725SEC

Atualiza o layout da secao do relatorio release 4, de acordo com o
ultimo parametro modificado pelo usuario

@author  Andre E. Perez Alvarez
@since   01/10/07
/*/
//-------------------------------------------------------------------
User Function MDT725SEC()
Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} fCreateTRB
Função para realizar a criação das TRBs.

@Param nImp, Numérico, Indica o tipo de impressão.

@author Jean Pytter da Costa
@since 23/01/2017
@version P12
@return
/*/
//---------------------------------------------------------------------
Static Function fCreateTRB(nImp)

	Default nImp := 1

	If nImp == 1
		aDBF := {}
		If lSigaMdtps
			AADD(aDBF,{"CLIENTE"  ,"C",nTa1,0})
			AADD(aDBF,{"LOJA"     ,"C",nTa1L,0})
		Else
			AADD(aDBF,{"QUANT"  ,"N",TAMSX3("TY3_QUANT")[1],0})
			AADD(aDBF,{"DESMED" ,"C",TAMSX3("TM1_NOMEDI")[1],0})
			AADD(aDBF,{"INDNOM" ,"C",23,0})
			AADD(aDBF,{"OBSERV" ,"M",80,0})
		EndIf
		AADD(aDBF,{"DTATEN" ,"D",08,0})
		AADD(aDBF,{"HRATEN" ,"C",05,0})
		AADD(aDBF,{"CODUSU" ,"C",12,0})
		AADD(aDBF,{"NUMFIC" ,"C",09,0})
		AADD(aDBF,{"MOTIVO" ,"C",02,0})
		AADD(aDBF,{"INDICA" ,"C",01,0})
		AADD(aDBF,{"CODMED" ,"C",15,0})

		oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
		If lSigaMdtps
			If mv_par11 == 1  //Totaliza por Atendente
				oTempTRB:AddIndex( "1", {"CLIENT","LOJA","DTATEN","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			ElseIf mv_par11 == 2	//Totaliza por Motivo
				oTempTRB:AddIndex( "1", {"CLIENT","LOJA","DTATEN","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			ElseIf mv_par11 == 3 //Totaliza por Indicação
				oTempTRB:AddIndex( "1", {"CLIENT","LOJA","DTATEN","INDICA","NUMFIC","CODUSU","MOTIVO","CODMED"} )
			ElseIf mv_par11 == 4 //Totaliza por Atendente
				oTempTRB:AddIndex( "1", {"CLIENT","LOJA","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			Else//Totalizar por Motivo Atend.
				oTempTRB:AddIndex( "1", {"CLIENT","LOJA","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			EndIf
		Else
			If mv_par07 == 1  //Totaliza por Atendente
				oTempTRB:AddIndex( "1", {"DTATEN","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			ElseIf mv_par07 == 2	//Totaliza por Motivo
				oTempTRB:AddIndex( "1", {"DTATEN","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			ElseIf mv_par07 == 3 //Totaliza por Indicação
				oTempTRB:AddIndex( "1", {"DTATEN","INDICA","NUMFIC","CODUSU","MOTIVO","CODMED"} )
			ElseIf mv_par07 == 4 //Totaliza por Atendente
				oTempTRB:AddIndex( "1", {"CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			Else//Totalizar por Motivo Atend.
				oTempTRB:AddIndex( "1", {"MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			EndIf
		EndIf
		oTempTRB:Create()
	Else
		aDBF1 := {}
		If lSigaMdtps
			AADD(aDBF1,{"CLIENTE"  ,"C",nTa1,0})
			AADD(aDBF1,{"LOJA"     ,"C",nTa1L,0})
			AADD(aDBF1,{"OBSERV"   ,"C",100,0})
		Else
			AADD(aDBF1,{"OBSERV"   ,"M",80,0})
		EndIf

		AADD(aDBF1,{"DTATEN"   ,"D",08,0})
		AADD(aDBF1,{"HRATEN"   ,"C",05,0})
		AADD(aDBF1,{"CODUSU"   ,"C",12,0})
		AADD(aDBF1,{"NOMUSU"   ,"C",40,0})
		AADD(aDBF1,{"NUMFIC"   ,"C",09,0})
		AADD(aDBF1,{"NOMFIC"   ,"C",40,0})
		AADD(aDBF1,{"MOTIVO"   ,"C",02,0})
		AADD(aDBF1,{"NOMOTI"   ,"C",40,0})
		AADD(aDBF1,{"INDICA"   ,"C",01,0})
		AADD(aDBF1,{"INDNOM"   ,"C",23,0})
		AADD(aDBF1,{"CODMED"   ,"C",15,0})
		AADD(aDBF1,{"NOMEDI"   ,"C",25,0})
		AADD(aDBF1,{"QTDADE"   ,"C",09,0})
		AADD(aDBF1,{"UNIDAD"   ,"C",06,0})

		oTempTRB2 := FWTemporaryTable():New( "TRB", aDBF1 )
		If lSigaMdtps
			If mv_par11 == 1  //Totaliza por Atendente
				oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","DTATEN","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			ElseIf mv_par11 == 2	//Totaliza por Motivo
				oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","DTATEN","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			ElseIf mv_par11 == 3	 //Totaliza por Indicação
				oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","DTATEN","INDICA","NUMFIC","CODUSU","MOTIVO","CODMED"} )
			ElseIf mv_par11 == 4	 //Totaliza por Atendente
				oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			Else					//Totalizar por Motivo
				oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			EndIf
		Else
			If mv_par07 == 1  //Totaliza por Atendente
				oTempTRB2:AddIndex( "1", {"DTATEN","CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			ElseIf mv_par07 == 2	//Totaliza por Motivo
				oTempTRB2:AddIndex( "1", {"DTATEN","MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			ElseIf mv_par07 == 3	 //Totaliza por Indicação
				oTempTRB2:AddIndex( "1", {"DTATEN","INDICA","NUMFIC","CODUSU","MOTIVO","CODMED"} )
			ElseIf mv_par07 == 4	 //Totaliza por Atendente
				oTempTRB2:AddIndex( "1", {"CODUSU","NUMFIC","MOTIVO","INDICA","CODMED"} )
			Else					//Totalizar por Motivo
				oTempTRB2:AddIndex( "1", {"MOTIVO","NUMFIC","CODUSU","INDICA","CODMED"} )
			EndIf
		EndIf
		oTempTRB2:Create()

		If !lSigaMdtps
			//--------------------------------
			// Cria arquivo temporario da TY3
			//--------------------------------
			aDBFTY3 :=	{ { "CODMED", "C", 15, 0 },;
						{   "NUMFIC ", "C", 09, 0 },;
						{   "DTATEN", "D", 08, 0 },;
						{   "HRATEN ", "C", 05, 0 },;
						{   "INDICA ", "C", 01, 0 },;
						{   "DESMED ", "C", 30, 0 },;
						{   "QUANT ", "N", 09, 2 },;
						{   "UNIMED", "C", 06, 0 } }

			oTempTY3 := FWTemporaryTable():New( "TRBTY3", aDBFTY3 )
			oTempTY3:AddIndex( "1", {"NUMFIC","DTATEN","HRATEN","INDICA","CODMED"} )
			oTempTY3:Create()
		EndIf
	EndIf

Return
