/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr929.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTR929   ³ Autor ³ Ricardo Dal Ponte     ³ Data ³26/10/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Calendario de Reunioes ordinarias CIPA                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR929( cCodMandato, lImp, cCliente, cLoja, lUsaPt, cArquivo )

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local aArea := GetArea()
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Default lImp := .f.
	Default lUsaPt := .T.
	Private lImpEmail := lImp

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

	Private nomeprog := "MDTR929"
	Private titulo   := If(lCipatr,STR0033,STR0001) //"Calendário Anual das Reuniões Ordinárias CIPATR"###"Calendário Anual das Reuniões Ordinárias da CIPA"
	Private cPerg    := If(!lSigaMdtPS,"MDT929    ","MDT929PS  ")

	/*---------------------------
	//PADRÃO					|
	|  Mandato CIPA ?			|
	|  Tipo de Impressao ?		|
	|							|
	//PRESTADOR					|
	|  Cliente ?				|
	|  Loja						|
	|  Mandato CIPA ?			|
	|  Tipo de Impressao ?		|
	-----------------------------*/

	If ExistBlock("MDTA111R") .And. lUsaPt
		//Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"D"})//Tipo do Evento

		If ValType(cCodMandato) == "C"
			aAdd(aParam, {cCodMandato})
		Else
			aAdd(aParam, {""})
		Endif

		If lSigaMdtPS

			If ValType(cCliente) == "C" .And. ValType(cLoja) == "C"
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

	If lImpEmail
		Pergunte(cPerg,.f.,titulo)
		Processa({|lEND| MDTA929IMP(cArquivo)},titulo+STR0025)  //" - Processando..."
	Else

		If Pergunte(cPerg,.t.,titulo)
			Processa({|lEND| MDTA929IMP()},STR0006) //"Imprimindo..."
		Endif

	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTA929IMP³ Autor ³ Ricardo Dal Ponte     ³ Data ³26/10/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Funcao de impressao                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MDTA929IMP( cArquivo )

	Local nXOrdem
	Local nDiaDaSemana,nI
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Private cTxtData

	If !lImpEmail
		Private oPrint03 := FwMsPrinter():New( OemToAnsi(titulo))
	Endif

	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .T. // Controla impressao da primeira pagina ou nao

	Lin := 200
	oPrint03:SetPortrait() // Retrato

	nXOrdem:=0
	nContFun := 0
	nPagina_ := 0
	lFirst := .t.

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

		If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
			cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
		Endif

		oPrint03:StartPage()

		// Localização do Logo da Empresa
		oPrint03:SayBitMap(50,50,NGLocLogo(),250,50)
		oPrint03:Say(lin,590,STR0001,oFont12n) //"CALENDÁRIO ANUAL DAS REUNIÕES ORDINÁRIAS DA CIPA"
		Somalinha(50)
		oPrint03:Say(lin,990,STR0007+cTxtData,oFont12n) //"GESTÃO "

		lin += 100

		Somalinha(80)

		oPrint03:Box(lin,200,lin+80,2200)
		oPrint03:Line(lin,600,lin+80,600)
		oPrint03:Line(lin,1000,lin+80,1000)
		oPrint03:Line(lin,1400,lin+80,1400)
		oPrint03:Line(lin,1800,lin+80,1800)
		oPrint03:Say(lin+15,290,STR0008,oFont12N) //"Nº ORDEM"
		oPrint03:Say(lin+15,670,STR0009,oFont12N) //"DIA DO MÊS"
		oPrint03:Say(lin+15,1150,STR0010,oFont12N) //"MÊS"
		oPrint03:Say(lin+15,1465,STR0011,oFont12N) //"DIA SEMANA"
		oPrint03:Say(lin+15,1890,STR0012,oFont12N) //"HORÁRIO"
		lFirst := .f.
		Somalinha(10)

		dbSelectArea("TNR")
		dbSetOrder(2)  //TNR_FILIAL+TNR_CLIENT+TNR_LOJA+TNR_MANDAT+DTOS(TNR_DTREUN)+TNR_HRREUN
		dbSeek(xFilial("TNR")+Mv_par01+Mv_par02+Mv_par03)
		While !eof() .and. xFilial("TNR")+Mv_par01+Mv_par02+Mv_par03 == TNR_FILIAL+TNR_CLIENT+TNR_LOJA+TNR_MANDAT
			If TNR_TIPREU <> "1"
				dbSkip()
				Loop
		End If

			Somalinha(70)

			oPrint03:Box(lin,200,lin+80,2200)
			oPrint03:Line(lin,600,lin+80,600)
			oPrint03:Line(lin,1000,lin+80,1000)
			oPrint03:Line(lin,1400,lin+80,1400)
			oPrint03:Line(lin,1800,lin+80,1800)

		nXOrdem ++

		oPrint03:Say(lin+15,370,Strzero(nXOrdem, 2),oFont10)
		oPrint03:Say(lin+15,770,Strzero(Day(TNR->TNR_DTREUN), 2),oFont10)
		oPrint03:Say(lin+15,1050,UPPER(MesExtenso(TNR->TNR_DTREUN))+ "/" + Strzero(Year(TNR->TNR_DTREUN), 4),oFont10)

		nDiaDaSemana := DOW(TNR->TNR_DTREUN)

		if nDiaDaSemana = 1
			oPrint03:Say(lin+15,1465,STR0013,oFont10) //"Domingo"
		ElseIf nDiaDaSemana = 2
			oPrint03:Say(lin+15,1465,STR0014,oFont10) //"Segunda-feira"
		ElseIf nDiaDaSemana = 3
			oPrint03:Say(lin+15,1465,STR0015,oFont10) //"Terça-feira"
		ElseIf nDiaDaSemana = 4
			oPrint03:Say(lin+15,1465,STR0016,oFont10) //"Quarta-feira"
		ElseIf nDiaDaSemana = 5
			oPrint03:Say(lin+15,1465,STR0017,oFont10) //"Quinta-feira"
		ElseIf nDiaDaSemana = 6
			oPrint03:Say(lin+15,1465,STR0018,oFont10) //"Sexta-feira"
		ElseIf nDiaDaSemana = 7
			oPrint03:Say(lin+15,1465,STR0019,oFont10) //"Sábado"
		EndIf

		oPrint03:Say(lin+15,1950,TNR->TNR_HRREUN,oFont10)

			dbSelectArea("TNR")
			dbSkip()
		End

		Somalinha(250)

		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+mv_par01+mv_par02)

		cCidade  := Alltrim(SA1->A1_MUN)
		cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0020 //" de "
		cCidade  += UPPER(MesExtenso(dDataBase))+STR0020 //" de "
		cCidade  += Strzero(Year(dDataBase),4)
		If Len(cCidade) > 40
			oPrint03:Say(lin,200,cCidade,oFont10)
		Else
			oPrint03:Say(lin,200,cCidade,oFont12)
		Endif

		Somalinha(350)

		oPrint03:Line(lin,200,lin,1100)
		oPrint03:Say(lin+20,200,If(lCipatr,STR0030,STR0021)+cTxtData,oFont12) //"Presidente CIPA gestão "

		oPrint03:Line(lin,1300,lin,2200)
		oPrint03:Say(lin+20,1300,If(lCipatr,STR0031,STR0022)+cTxtData,oFont12) //"Vice-Presidente CIPA gestão "

		oPrint03:EndPage()

		If lImpEmail
			cDiretorio := AllTrim(GetMV("MV_RELT",," "))

			If EMPTY(cDiretorio)
				cDiretorio := "\"
			EndIf

			If Substr(cDiretorio,Len(cDiretorio),1) != "\"
				cDiretorio += "\"
			Endif

			cPrefixo := cDiretorio+"Reunioes"+Alltrim(Mv_par03)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)

			If !oPrint03:SaveAllAsJPEG(cPrefixo,931,1330,150)
				MsgStop(STR0026,STR0027)  //"Não foi possível gravar o relatório"  //"AVISO"
				cAnexo03 := .F.
			EndIf

			// Varre o diretório e procura pelas páginas gravadas.
			aFiles := Directory( cPrefixo+"*.jpg" )

			// Monta um Vetor com o path e nome do arquivo em cada linha para passar via email
			cAnexo03 := ""

			For nI:= 1 to Len(aFiles)
				cAnexo03 += cDiretorio+aFiles[nI,1] + "; "
			Next nI
		Else

			If mv_par04 == 1
				oPrint03:Preview()
			Else
				oPrint03:Print()
			EndIf

		Endif

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		cTxtData := StrZero(Year(TNN->TNN_DTINIC),4)

		If Year(TNN->TNN_DTINIC) <> Year(TNN->TNN_DTTERM)
			cTxtData += " / "+StrZero(Year(TNN->TNN_DTTERM),4)
		Endif

		oPrint03:StartPage()

		// Localização do Logo da Empresa
		oPrint03:SayBitMap(50,50,NGLocLogo(),250,50)
		oPrint03:SayAlign(lin,300,If(lCipatr,STR0033,STR0001),oFont12n, 1700 , 150 , , 2 , 0) //"CALENDÁRIO ANUAL DAS REUNIÕES ORDINÁRIAS"
		Somalinha(50)
		oPrint03:SayAlign(lin,300,STR0007+cTxtData,oFont12n, 1700 , 150 , , 2 , 0) //"GESTÃO "

		lin += 100

		Somalinha(80)

		oPrint03:Box(lin,200,lin+80,2100)
		oPrint03:Line(lin,500,lin+80,500)
		oPrint03:Line(lin,900,lin+80,900)
		oPrint03:Line(lin,1300,lin+80,1300)
		oPrint03:Line(lin,1700,lin+80,1700)
		oPrint03:Say(lin+50,250,STR0008,oFont12N) //"Nº ORDEM"
		oPrint03:Say(lin+50,570,STR0009,oFont12N) //"DIA DO MÊS"
		oPrint03:Say(lin+50,1050,STR0010,oFont12N) //"MÊS"
		oPrint03:Say(lin+50,1365,STR0011,oFont12N) //"DIA SEMANA"
		oPrint03:Say(lin+50,1790,STR0012,oFont12N) //"HORÁRIO"
		lFirst := .f.
		Somalinha(10)

		dbSelectArea("TNR")
		dbSetOrder(1)
		dbSeek(xFilial("TNR")+Mv_par01)
		While !eof() .and. xFilial("TNR")+Mv_par01 == TNR_FILIAL+TNR_MANDAT
			If TNR_TIPREU <> "1"
				dbSkip()
				Loop
			End If

				Somalinha(70)

				oPrint03:Box(lin,200,lin+80,2100)
				oPrint03:Line(lin,500,lin+80,500)
				oPrint03:Line(lin,900,lin+80,900)
				oPrint03:Line(lin,1300,lin+80,1300)
				oPrint03:Line(lin,1700,lin+80,1700)

			nXOrdem ++

			oPrint03:Say(lin+50,270,Strzero(nXOrdem, 2),oFont10)
			oPrint03:Say(lin+50,670,Strzero(Day(TNR->TNR_DTREUN), 2),oFont10)
			oPrint03:Say(lin+50,950,UPPER(MesExtenso(TNR->TNR_DTREUN))+ "/" + Strzero(Year(TNR->TNR_DTREUN), 4),oFont10)

			nDiaDaSemana := DOW(TNR->TNR_DTREUN)

			If nDiaDaSemana = 1
				oPrint03:Say(lin+50,1365,STR0013,oFont10) //"Domingo"
			ElseIf nDiaDaSemana = 2
				oPrint03:Say(lin+50,1365,STR0014,oFont10) //"Segunda-feira"
			ElseIf nDiaDaSemana = 3
				oPrint03:Say(lin+50,1365,STR0015,oFont10) //"Terça-feira"
			ElseIf nDiaDaSemana = 4
				oPrint03:Say(lin+50,1365,STR0016,oFont10) //"Quarta-feira"
			ElseIf nDiaDaSemana = 5
				oPrint03:Say(lin+50,1365,STR0017,oFont10) //"Quinta-feira"
			ElseIf nDiaDaSemana = 6
				oPrint03:Say(lin+50,1365,STR0018,oFont10) //"Sexta-feira"
			ElseIf nDiaDaSemana = 7
				oPrint03:Say(lin+50,1365,STR0019,oFont10) //"Sábado"
			EndIf

		oPrint03:Say(lin+50,1850,TNR->TNR_HRREUN,oFont10)
			dbSelectArea("TNR")
			dbSkip()
		End

		Somalinha(250)

		cCidade  := Alltrim(SM0->M0_CIDCOB)
		cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0020 //" de "
		cCidade  += UPPER(MesExtenso(dDataBase))+STR0020 //" de "
		cCidade  += Strzero(Year(dDataBase),4)
		If Len(cCidade) > 40
			oPrint03:Say(lin,200,cCidade,oFont10)
		Else
			oPrint03:Say(lin,200,cCidade,oFont12)
		Endif

		Somalinha(350)

		oPrint03:Line(lin,200,lin,1000)
		oPrint03:Say(lin+60,200,If(lCipatr,STR0030,STR0021)+cTxtData,oFont12) //"Presidente CIPA gestão "

		oPrint03:Line(lin,1300,lin,2100)
		oPrint03:Say(lin+60,1300,If(lCipatr,STR0031,STR0022)+cTxtData,oFont12) //"Vice-Presidente CIPA gestão "

		oPrint03:EndPage()

		If lImpEmail
			oPrint03:Print()
			cDiretorio := oPrint03:cPathPDF

			If File(cDiretorio+cArquivo+".pdf")
				CpyT2S( cDiretorio+Lower(cArquivo)+".pdf" , "\SPOOL\", .F. , .F.)//Copia arquivo temporário para o Spool (SERVIDOR)
				cAnexo03 := "SPOOL" +"\"+ Lower(cArquivo)+".pdf;"
			Else
				cAnexo03 := .f.
			EndIf

		Else

			If mv_par02 == 1
				oPrint03:Preview()
			Else
				oPrint03:Print()
			EndIf

		Endif

	Endif

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³Somalinha ³ Autor ³ Ricardo Dal Ponte     ³ Data ³26/10/2006 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Funcao de somar linha                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Somalinha(_li)

	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	If _li != nil
		lin += _li
	Else
		lin += 70
	Endif

	If lin > 2900
		Lin := 200
		oPrint03:EndPage()

		oPrint03:SayAlign(lin,300,STR0001,oFont12n, 1700 , 150 , , 2 , 0) //"CALENDÁRIO ANUAL DAS REUNIÕES ORDINÁRIAS"
		Somalinha(50)
		oPrint03:SayAlign(lin,300,STR0007+cTxtData,oFont12n, 1700 , 150 , , 2 , 0) //"GESTÃO "

		lin += 100

		Somalinha(80)

		oPrint03:Box(lin,200,lin+80,2100)
		oPrint03:Line(lin,500,lin+80,500)
		oPrint03:Line(lin,900,lin+80,900)
		oPrint03:Line(lin,1300,lin+80,1300)
		oPrint03:Line(lin,1700,lin+80,1700)
		oPrint03:Say(lin+50,250,STR0008,oFont12N) //"Nº ORDEM"
		oPrint03:Say(lin+50,570,STR0009,oFont12N) //"DIA DO MÊS"
		oPrint03:Say(lin+50,1050,STR0010,oFont12N) //"MÊS"
		oPrint03:Say(lin+50,1365,STR0011,oFont12N) //"DIA SEMANA"
		oPrint03:Say(lin+50,1790,STR0012,oFont12N) //"HORÁRIO"
		lFirst := .f.
		Somalinha(10)
		Somalinha(70)
	Endif

Return