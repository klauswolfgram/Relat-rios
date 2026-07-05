/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR921.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR921

Carta de Designação da Comissão Eleitoral CIPA

@author  Denis Hyroshi de Souza
@since   17/10/2006

@sample  U_MDTR921(cCodMandato,cCliente,cLoja)

@param   cCodMandato, Caractere, Parâmetro utilizado no modo de prestador
@param   cCliente, Caractere, Parâmetro utilizado no modo de prestador
@param   cLoja, Caractere, Parâmetro utilizado no modo de prestador
/*/
//-------------------------------------------------------------------
User Function MDTR921(cCodMandato,cCliente,cLoja)

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local aArea   := GetArea()

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR921"
	Private titulo   := IIf( lMdtMin, STR0030, IIf( lCipatr, STR0019, STR0001 )) //"Designação da Comissão Eleitoral CIPA"
	Private cPerg    := If(!lSigaMdtPS,"MDT921    ","MDT921PS  ")
	Private cMandato := Space(6)
	Private lUpdExec

	dbSelectArea("SX3")
	dbSetOrder(1)

	If DbSeek("TK8")
		lUpdExec := .T.
	Else
		lUpdExec := .F.
	EndIf

	If ExistBlock("MDTA111R")
		// Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"3"}) // Tipo do Evento

		If ValType(cCodMandato) == "C"
			aAdd(aParam, {cCodMandato})
		Else
			aAdd(aParam, {""})
		Endif

		If lSigaMdtPS

			If ValType(cCliente) == "C" .AND. ValType(cLoja) == "C"
				aAdd(aParam, {cCliente})
				aAdd(aParam, {cLoja})
			Else
				aAdd(aParam, {""})
				aAdd(aParam, {""})
			Endif

		Endif

		lRet := ExecBlock("MDTA111R",.F.,.F.,aParam)

		If Type("lRet") <> "L"
			lRet := .F.
		Endif

		If lRet
			Return .T.
		Endif

	Endif

	/*----------------------------------
	/PADRÃO								|
	|  Mandato CIPA Anterior ?			|
	|  Quantas copias ?					|
	|  Tipo de Impressao ?				|
	|  									|
	//PRESTADOR							|
	|  Cliente ?						|
	|  Loja								|
	|  Mandato CIPA Anterior ?			|
	|  Quantas copias ?					|
	|  Tipo de Impressao ?				|
	-------------------------------------*/

	If Pergunte(cPerg,.t.)
		Processa({|lEND| MDTA921IMP()},STR0002) // "Imprimindo..."
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA921IMP

Função de impressão

@author  Denis Hyroshi de Souza
@since   09/10/2006

@return  Nulo , Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA921IMP()

	Local nInd//,LinhaCor
	Local LinhaCorrente, i
	Local cTexto := Space(10)
	Local aResp  := {}

	Private oPrint    := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao

	Lin := 300
	oPrint:SetPortrait() //retrato
	oPrint:Setup()

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		If lUpdExec
			DbSelectArea("TK8")
			DbSetOrder(3)
			If DbSeek(XFILIAL("TK8")+mv_par01+mv_par02+mv_par03)
				While !Eof() .AND. MV_PAR03 == TK8->TK8_MANDAT
					If TK8->TK8_TIPPAR == '1'
						cResp := Alltrim(Posicione("SRA",1,xFilial("SRA",TK8->TK8_FILRE)+TK8->TK8_MATRE,"RA_NOME"))
					ElseIf TK8->TK8_TIPPAR == '2'
						cResp :=	AllTrim(TK8->TK8_NOMPAR)
					EndIf
					If !Empty(cResp)
						AADD(aResp,cResp)
					Endif
					DbSkip()
				End
			Endif

			If !Empty(aResp)
				For i := 1 to Len(aResp)
					If Len(aResp) == 1
						cTexto := aResp[i]
					Else
						If i == 1
							cTexto := aResp[i]
						ElseIf i == Len(aResp)
							cTexto += " e " + aResp[i]
						Else
							cTexto += ", " + aResp[i]
						Endif
					Endif
				Next i
			Endif

		Else

			cFil1Tmp := cFilAnt
			cFil2Tmp := cFilAnt
			If !Empty(TNN->TNN_FILRE1)
				cFil1Tmp := TNN->TNN_FILRE1
			Endif
			If !Empty(TNN->TNN_FILRE2)
				cFil2Tmp := TNN->TNN_FILRE2
			Endif
			cResp01 := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNN->TNN_MATRE1,"RA_NOME"))+" "
			cResp02 := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil2Tmp)+TNN->TNN_MATRE2,"RA_NOME"))+" "

		Endif

		For nInd := 1 To Mv_par04

			oPrint:StartPage()

			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)
			oPrint:Say(150,300,NGSeek('SA1',TNN->(TNN_CLIENT+TNN_LOJAC),1,'SA1->A1_NOME'),oFont12n) //Nome do cliente
			oPrint:SayAlign(300,400,STR0003,oFont12n, 1500, 500, , 2, 0 ) //"DESIGNAÇÃO DA COMISSÃO ELEITORAL"

			cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

			If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
				cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
			Endif

			If lUpdExec

				If Len(aResp) == 1
					cTxt01 := STR0017+cTexto //"Fica designado o senhor "
					cTxt01 += " " + IIf( lMdtMin, STR0028, IIf( lCipatr, STR0024, STR0018 )) //"para compor a Comissão Eleitoral da CIPA, em conformidade com a Norma"
				Else
					cTxt01 := STR0004+cTexto //"Ficam designados os senhores "
					cTxt01 += " " + IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
				Endif

				cTxt01 += " " + IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 )) //"Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
				cTxt01 += " " + IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 )) //"alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."

				Lin := 870

				LinhasMemo := MLCOUNT(cTxt01,75)
				oPrint:SayAlign(Lin,300,cTxt01,oFont12, 1700, LinhasMemo * 45 , , 3, 0 )

			Else

				If Len(cResp01+cResp02) <= 47
					cTxt01 := STR0004+cResp01+STR0015+cResp02 //"Ficam designados os senhores " //"e "
					cTxt02 := IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
					cTxt03 := IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 )) //"Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
					cTxt04 := IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 )) //"alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."
					oPrint:Say(870,400,cTxt01,oFont12)
					oPrint:Say(940,300,cTxt02,oFont12)
					oPrint:Say(1010,300,cTxt03,oFont12)
					oPrint:Say(1080,300,cTxt04,oFont12)
				Else
					cTxt01 := STR0008 //"Ficam designados os senhores"
					cTxt02 := IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
					cTxt03 := IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 ))//"Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
					cTxt04 := IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 ))//"alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."

					If Len(cResp01+cResp02) <= 55
						oPrint:Say(870,400,cTxt01,oFont12)
						oPrint:Say(870,1100,cResp01+STR0015+cResp02,oFont10) //"e "
					Else
						oPrint:Say(870,300,cTxt01,oFont12)
						oPrint:Say(870,1000,cResp01+STR0015+cResp02,oFont10) //"e "
					Endif

					oPrint:Say(940,300,cTxt02,oFont12)
					oPrint:Say(1010,300,cTxt03,oFont12)
					oPrint:Say(1080,300,cTxt04,oFont12)
				Endif

			Endif

			cCidade  := Alltrim(SM0->M0_CIDCOB)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0016 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0016 //" de "
			cCidade  += Strzero(Year(dDataBase),4)

			If Len(cCidade) > 40
				oPrint:SayAlign(1700,1000,cCidade,oFont10, 900, 500, , 1, 0 )
			Else
				oPrint:SayAlign(1700,1000,cCidade,oFont12, 900, 500, , 1, 0 )
			Endif

			oPrint:Say(2400,850,IIf( lMdtMin, STR0031, IIf( lCipatr, STR0023, STR0009 )),oFont12) //"Coordenador ou Vice Coordenador da CIPA"
			oPrint:EndPage()

		Next nInd

		If mv_par05 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		If lUpdExec
			DbSelectArea("TK8")
			DbSetOrder(1)

			If DbSeek(XFILIAL("TK8")+mv_par01)

				While !Eof() .AND. MV_PAR01 == TK8->TK8_MANDAT

					If TK8->TK8_TIPPAR == '1'
						cResp := Alltrim(Posicione("SRA",1,xFilial("SRA",TK8->TK8_FILRE)+TK8->TK8_MATRE,"RA_NOME"))
					ElseIf TK8->TK8_TIPPAR == '2'
						cResp :=	AllTrim(TK8->TK8_NOMPAR)
					EndIf

					If !Empty(cResp)
						AADD(aResp,cResp)
					Endif

					DbSkip()
				End

			Endif

			If !Empty(aResp)

				For i := 1 to Len(aResp)

					If Len(aResp) == 1
						cTexto := aResp[i]
					Else

						If i == 1
							cTexto := aResp[i]
						ElseIf i == Len(aResp)
							cTexto += " e " + aResp[i]
						Else
							cTexto += ", " + aResp[i]
						Endif

					Endif

				Next i

			Endif

		Else

			cFil1Tmp := cFilAnt
			cFil2Tmp := cFilAnt

			If !Empty(TNN->TNN_FILRE1)
				cFil1Tmp := TNN->TNN_FILRE1
			Endif

			If !Empty(TNN->TNN_FILRE2)
				cFil2Tmp := TNN->TNN_FILRE2
			Endif

			cResp01 := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNN->TNN_MATRE1,"RA_NOME"))+" "
			cResp02 := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil2Tmp)+TNN->TNN_MATRE2,"RA_NOME"))+" "

		Endif

		For nInd := 1 To Mv_par02

			oPrint:StartPage()
			// Localização do Logo da Empresa
			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)
			oPrint:SayAlign(300,400,STR0003,oFont12n, 1500, 500, , 2, 0 ) //"DESIGNAÇÃO DA COMISSÃO ELEITORAL"

			cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

			If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
				cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
			Endif

			If lUpdExec

				If Len(aResp) == 1
					cTxt01 := STR0017+cTexto //"Fica designado o senhor "
					cTxt01 += " " + IIf( lMdtMin, STR0028, IIf( lCipatr, STR0024, STR0018 )) //"para compor a Comissão Eleitoral da CIPA, em conformidade com a Norma"
				Else
					cTxt01 := STR0004+cTexto //"Ficam designados os senhores "
					cTxt01 += " " + IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
				Endif

				cTxt01 += " " + IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 )) // "Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
				cTxt01 += " " + IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 )) // "alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."

				Lin := 870

				LinhasMemo := MLCOUNT(cTxt01,75)
				oPrint:SayAlign(Lin,300,cTxt01,oFont12, 1700, LinhasMemo * 45 , , 3, 0 )

			Else

				If Len(cResp01+cResp02) <= 47
					cTxt01 := STR0004+cResp01+STR0015+cResp02 //"Ficam designados os senhores " //"e "
					cTxt02 := IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
					cTxt03 := IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 )) //"Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
					cTxt04 := IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 )) //"alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."
					oPrint:Say(870,400,cTxt01,oFont12)
					oPrint:Say(940,300,cTxt02,oFont12)
					oPrint:Say(1010,300,cTxt03,oFont12)
					oPrint:Say(1080,300,cTxt04,oFont12)
				Else
					cTxt01 := STR0008 //"Ficam designados os senhores"
					cTxt02 := IIf( lMdtMin, STR0029, IIf( lCipatr, STR0020, STR0005 )) //"para comporem a Comissão Eleitoral da CIPA, em conformidade com a Norma"
					cTxt03 := IIf( lMdtMin, STR0026, IIf( lCipatr, STR0021, STR0006 )) //"Regulamentadora NR 5, da Portaria 3.214/78 do Ministério do Trabalho e Emprego,"
					cTxt04 := IIf( lMdtMin, STR0027, IIf( lCipatr, STR0022, STR0007 ))//"alterada pela Portaria nº 86, de 03 de março de 2005."###"alterada pela Portaria nº 08, de 23 de fevereiro de 1999."

					If Len(cResp01+cResp02) <= 55
						oPrint:Say(870,400,cTxt01,oFont12)
						oPrint:Say(870,1100,cResp01+STR0015+cResp02,oFont10) //"e "
					Else
						oPrint:Say(870,300,cTxt01,oFont12)
						oPrint:Say(870,1000,cResp01+STR0015+cResp02,oFont10) //"e "
					Endif

					oPrint:Say(940,300,cTxt02,oFont12)
					oPrint:Say(1010,300,cTxt03,oFont12)
					oPrint:Say(1080,300,cTxt04,oFont12)
				Endif

			Endif

			cCidade  := Alltrim(SM0->M0_CIDCOB)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0016 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0016 //" de "
			cCidade  += Strzero(Year(dDataBase),4)

			If Len(cCidade) > 40
				oPrint:SayAlign(1700,1000,cCidade,oFont10, 900, 500, , 1, 0 )
			Else
				oPrint:SayAlign(1700,1000,cCidade,oFont12, 900, 500, , 1, 0 )
			Endif

			oPrint:Say(2400,850,IIf( lMdtMin, STR0031, IIf( lCipatr, STR0023, STR0009 )),oFont12) //"Coordenador ou Vice Coordenador da CIPA"
			oPrint:EndPage()

		Next nInd

		If mv_par03 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Endif

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT921MAND

Altera o filtro da tabela de componentes

@author  Denis Hyroshi de Souza
@since   09/10/2006

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDT921MAND()
	Local lUpdMdt70 := AliasInDic("TK8")

	If lUpdMdt70

		If lSigaMdtps

			If !ExistCpo('TNN',mv_par01+mv_par02+mv_par03,3)
				Return .f.
			Else
				cMandato := Mv_par03
			Endif

		Else

			If !ExistCpo('TNN',Mv_par01)
				Return .f.
			Else
				cMandato := Mv_par01
			Endif

		Endif

	Else

		If lSigaMdtps
			cMandato := Mv_par03
		Else
			cMandato := Mv_par01
		Endif

	Endif

Return .T.