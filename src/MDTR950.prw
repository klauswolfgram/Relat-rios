/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR950.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR950

Relatorio de Programacao de Eventos da SIPAT

@author  Denis Hyroshi de Souza
@since   12/07/07
/*/
//-------------------------------------------------------------------
User Function MDTR950()
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Private nomeprog := "MDTR950"
	Private titulo   := STR0001 //"Relatório da Programação de Eventos da SIPAT"
	Private cPerg    := "MDTR950   "

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cPerg    := If(!lSigaMdtPS,"MDTR950   ","MDTR950PS ")

	/*--------------------------------
	//PADRÃO							|
	|  De  SIPAT ?						|
	|  Ate SIPAT ?						|
	|  De  Mandato CIPA ?				|
	|  Ate Mandato CIPA ?				|
	|  De  Data Evento ?				|
	|  Ate Data Evento ?				|
	|  Exibir Detalhes do Evento ?		|
	|  Tipo de Impressão ?				|
	|  									|
	//PRESTADOR							|
	|  De Cliente ?						|
	|  Loja								|
	|  Até Cliente ?					|
	|  Loja								|
	|  De  SIPAT ?						|
	|  Ate SIPAT ?						|
	|  De  Mandato CIPA ?				|
	|  Ate Mandato CIPA ?				|
	|  De  Data Evento ?				|
	|  Ate Data Evento ?				|
	|  Exibir Detalhes do Evento ?		|
	|  Tipo de Impressão ?				|
	-----------------------------------*/

	If Pergunte(cPerg,.t.,titulo)
		If lSigaMdtps
			Processa({|lEND| MDT950IMPS()},STR0002) //"Imprimindo..."
		Else
			Processa({|lEND| MDTA950IMP()},STR0002) //"Imprimindo..."
		Endif
	Endif

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA950IMP

Funcao de impressao

@author  Denis Hyroshi de Souza
@since   09/10/2006

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA950IMP()

	Local nFor,nInd,nI,LinhaCorrente,nY,nX
	Local aTitles     := {STR0003,STR0004,STR0005,STR0006,STR0007,STR0008,STR0009} //"Domingo"###"Segunda-feira"###"Terça-feira"###"Quarta-feira"###"Quinta-feira"###"Sexta-feira"###"Sábado"
	Local cSet := Set(_SET_DATEFORMAT)
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()

	Private oPrint02  := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont09   := TFont():New("VERDANA",09,09,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFont11   := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)
	Private oFont11n  := TFont():New("VERDANA",11,11,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao
	Private aDados950 := {}

	//Seta data para ano com 4 digitos
	Set(_SET_DATEFORMAT,"dd/mm/yyyy")

	Lin := 200
	oPrint02:SetPortrait() //retrato

	nContFun := 0
	nPagina_ := 0

	dbSelectArea("TLH")
	dbSetOrder(1)
	dbSeek(xFilial("TLH")+mv_par01,.t.)
	While !Eof() .and. xFilial("TLH") == TLH->TLH_FILIAL .and. TLH->TLH_SIPAT <= mv_par02

		dbSelectArea("TLH")
		If TLH->TLH_MANDAT < Mv_par03 .or. TLH->TLH_MANDAT > Mv_par04
			dbSkip()
			Loop
		Endif
		If TLH->TLH_DTINI > Mv_par06 .or. TLH->TLH_DTFIM < Mv_par05
			dbSkip()
			Loop
		Endif

		aEventos := {}

		dbSelectArea("TLI")
		dbSetOrder(1)
		dbSeek(xFilial("TLI")+TLH->TLH_SIPAT)
		While !Eof() .and. xFilial("TLI") + TLH->TLH_SIPAT == TLI->TLI_FILIAL + TLI->TLI_SIPAT
			If TLI->TLI_DTPROG > Mv_par06 .or. TLI->TLI_DTPROG < Mv_par05
				dbSelectArea("TLI")
				dbSkip()
				Loop
			Endif

			cNomeResp := " "
			If TLI->TLI_INDRES == "1"
				dbSelectArea("TMK")
				dbSetOrder(1)
				dbSeek(xFilial("TMK")+TLI->TLI_CODRES)
				cNomeResp := SubStr(TMK->TMK_NOMUSU,1,40)
			ElseIf TLI->TLI_INDRES == "2"
				dbSelectArea("SRA")
				dbSetOrder(1)
				dbSeek(xFilial("SRA")+TLI->TLI_CODRES)
				cNomeResp := SRA->RA_NOME
			ElseIf TLI->TLI_INDRES == "3"
				cNomeResp := TLI->TLI_NOMRES
			Endif

			aAdd( aEventos , {  TLI->TLI_DTPROG	,;
								TLI->TLI_HRPROG	,;
								TLI->TLI_HRFIM	,;
								TLI->TLI_LOCAL	,;
								TLI->TLI_DESCRI	,;
								cNomeResp		,;
								TLI->TLI_OBSERV	})

			dbSelectArea("TLI")
			dbSkip()
		End

		aSort( aEventos ,,, { |x,y| DtoS(x[1])+x[2] < DtoS(y[1])+y[2] } ) //Ordena pela data + hora

		aAdd(aDados950, { 	TLH->TLH_SIPAT	,;
							TLH->TLH_NOME	,;
							TLH->TLH_DTINI	,;
							TLH->TLH_DTFIM	,;
							TLH->TLH_DESCRI	,;
							aEventos		})

		dbSelectArea("TLH")
		dbSkip()
	End

	cStartPath := AllTrim(GetSrvProfString("Startpath",""))
	If Substr(cStartPath,Len(cStartPath),1) <> "\"
		cStartPath := cStartPath+"\"
	Endif

	For nX := 1 to Len(aDados950)

		oPrint02:StartPage()
		lin := 300

		cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial
		If File(cLogo)
			oPrint02:SayBitMap(150,200,cLogo,250,50)
		Else
			cLogo := cStartPath+"LGRL"+cSMCOD+".BMP" // Empresa
			If File(cLogo)
				oPrint02:SayBitMap(150,200,cLogo,250,50)
			Else
				cLogo := "LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial
				If File(cLogo)
					oPrint02:SayBitMap(150,200,cLogo,250,50)
				Else
					cLogo := "LGRL"+cSMCOD+".BMP" // Empresa
					If File(cLogo)
						oPrint02:SayBitMap(150,200,cLogo,250,50)
					Endif
				Endif
			Endif
		Endif

		oPrint02:Say(lin-40,620,STR0010,oFont12n) //"SIPAT - Semana Interna de Prevenção de Acidentes do Trabalho"
		lin += 100 // 400
		oPrint02:Say(lin-40 ,950,STR0011 + DtoC(aDados950[nX,3]) + STR0012 + DtoC(aDados950[nX,4]) ,oFont12n) //"De  à  "
		lin += 200 // 600
		If !Empty(aDados950[nX,5])
			oPrint02:Say(lin,200,STR0013,oFont11n) //"Objetivo"
				Somalinha(50,nX)
			nLinhasMemo := MLCOUNT(aDados950[nX,5],100) * 50 //Linhas em pixels
				oPrint02:SayAlign( lin , 200 , aDados950[nX,5] , oFont11 , 1800 , nLinhasMemo , , 3 , 0 )
			Somalinha(nLinhasMemo + 100,nX)
		Endif
		oPrint02:Say(lin,200,STR0014,oFont11n) //"Programação"
		Somalinha(50,nX)

		dDataAnt := CtoD("//")
		For nY := 1 to Len(aDados950[nX,6])
			//Verifica tamanho de impressão da programação
			nLinhasMemo := MLCOUNT(aDados950[nX,6,nY,7],100) * 50
			If lin + nLinhasMemo + 410 > 2900 //lin = linha atual //nLinhasMemo = tamanho da descrição //410 = tamanho do cabeçalho das programações
				//Força nova página
				lin := 2900
				Somalinha( , nX)
			EndIf
			If dDataAnt <> aDados950[nX,6,nY,1]
				Somalinha(50,nX)
				dDataAnt := aDados950[nX,6,nY,1]
				oPrint02:Say(lin,200, Transform(aDados950[nX,6,nY,1],"99/99/9999"),oFont11n)
				nDIA := DOW(aDados950[nX,6,nY,1])
				If nDIA > 0
					oPrint02:Say(lin,500, aTitles[nDIA] ,oFont11n)
				Endif
				Somalinha(60,nX)
			Endif
			oPrint02:Say(lin,200, aDados950[nX,6,nY,2] ,oFont11n)//horario inicio
			oPrint02:Say(lin,310, STR0033,oFont11n)   // as
			oPrint02:Say(lin,360, aDados950[nX,6,nY,3] ,oFont11n)// horario fim
			oPrint02:Say(lin,500, aDados950[nX,6,nY,5] ,oFont11)
			Somalinha(50,nX)
			If !Empty( aDados950[nX,6,nY,6] + aDados950[nX,6,nY,4] )
				cTextoLinha := ""
				If !Empty(aDados950[nX,6,nY,6])
					cTextoLinha += STR0016+Alltrim(aDados950[nX,6,nY,6])  //"Responsável: "
				Endif
				If !Empty(aDados950[nX,6,nY,4])
					If !Empty(cTextoLinha)
						cTextoLinha += "   /   "
					Endif
					cTextoLinha += STR0017+Alltrim(aDados950[nX,6,nY,4])  //"Local: "
				Endif
				oPrint02:Say(lin,500, cTextoLinha ,oFont11)
				Somalinha(50,nX)
				If Mv_par07 == 1
					oPrint02:SayAlign( lin , 410 , aDados950[nX,6,nY,7] , oFont11 , 1600 , nLinhasMemo , , 3 , 0 )
				Endif
			Endif
			Somalinha(nLinhasMemo + 50,nX)
		Next nY

		oPrint02:EndPage()
	Next nX

	If len(aDados950) == 0
		MsgStop( STR0034 ) //"Não há dados a serem impressos"
	Else
		If mv_par08 == 1
			oPrint02:Preview()
		Else
			oPrint02:Print()
		EndIf
	EndIf

	//Seta o formato da data anterior
	Set(_SET_DATEFORMAT,cSet)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT950IMPS
Funcao de impressao para prestadores
@author  Andre Perez Alvarez
@since   18/02/2008
@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDT950IMPS()

	Local nFor,nInd,nI,LinhaCorrente,nY,nX
	Local aTitles     := {STR0003,STR0004,STR0005,STR0006,STR0007,STR0008,STR0009} //"Domingo"###"Segunda-feira"###"Terça-feira"###"Quarta-feira"###"Quinta-feira"###"Sexta-feira"###"Sábado"
	Local cSet := Set(_SET_DATEFORMAT)
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()

	Private oPrint02  := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont09   := TFont():New("VERDANA",09,09,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFont11   := TFont():New("VERDANA",11,11,,.F.,,,,.F.,.F.)
	Private oFont11n  := TFont():New("VERDANA",11,11,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao
	Private aDados950 := {}

	//Seta data para ano com 4 digitos
	Set(_SET_DATEFORMAT,"dd/mm/yyyy")

	Lin := 200
	oPrint02:SetPortrait() //retrato
	oPrint02:Setup()

	nContFun := 0
	nPagina_ := 0

	dbSelectArea("TLH")
	dbSetOrder(5)  //TLH_FILIAL+TLH_CLIENT+TLH_LOJA+TLH_SIPAT
	dbSeek(xFilial("TLH")+mv_par01+mv_par02,.t.)
	While !Eof() .and. xFilial("TLH") == TLH->TLH_FILIAL .and. TLH->(TLH_CLIENT+TLH_LOJA) <= mv_par03+mv_par04
		dbSelectArea("TLH")

		If TLH->TLH_SIPAT < mv_par05 .or. TLH->TLH_SIPAT > mv_par06
			dbSkip()
			Loop
		Endif

		If TLH->TLH_MANDAT < Mv_par07 .or. TLH->TLH_MANDAT > Mv_par08
			dbSkip()
			Loop
		Endif

		If TLH->TLH_DTINI > Mv_par10 .or. TLH->TLH_DTFIM < Mv_par09
			dbSkip()
			Loop
		Endif

		aEventos := {}

		dbSelectArea("TLI")
		dbSetOrder(6)  //TLI_FILIAL+TLI_CLIENT+TLI_LOJA+TLI_SIPAT+DTOS(TLI_DTPROG)+TLI_HRPROG
		dbSeek(xFilial("TLI")+TLH->(TLH_CLIENT+TLH_LOJA)+TLH->TLH_SIPAT)
		While !Eof() .and. xFilial("TLI") + TLH->TLH_SIPAT == TLI->TLI_FILIAL + TLI->TLI_SIPAT .and. TLH->(TLH_CLIENT+TLH_LOJA) = TLI->(TLI_CLIENT+TLI_LOJA)

			If TLI->TLI_DTPROG > Mv_par10 .or. TLI->TLI_DTPROG < Mv_par09
				dbSelectArea("TLI")
				dbSkip()
				Loop
			Endif

			cNomeResp := " "

			If TLI->TLI_INDRES == "1"
				dbSelectArea("TMK")
				dbSetOrder(1)
				dbSeek(xFilial("TMK")+TLI->TLI_CODRES)
				cNomeResp := SubStr(TMK->TMK_NOMUSU,1,40)
			ElseIf TLI->TLI_INDRES == "2"
				dbSelectArea("SRA")
				dbSetOrder(1)
				dbSeek(xFilial("SRA")+TLI->TLI_CODRES)
				cNomeResp := SRA->RA_NOME
			ElseIf TLI->TLI_INDRES == "3"
				cNomeResp := TLI->TLI_NOMRES
			Endif

			aAdd( aEventos , {  TLI->TLI_DTPROG	,;
								TLI->TLI_HRPROG	,;
								TLI->TLI_HRFIM	,;
								TLI->TLI_LOCAL	,;
								TLI->TLI_DESCRI	,;
								cNomeResp		,;
								TLI->TLI_OBSERV	 } )

			dbSelectArea("TLI")
			dbSkip()
		End

		aSort( aEventos ,,, { |x,y| DtoS(x[1])+x[2] < DtoS(y[1])+y[2] } ) //Ordena pela data + hora

		aAdd(aDados950, { 	TLH->TLH_SIPAT	,;
							TLH->TLH_NOME	,;
							TLH->TLH_DTINI	,;
							TLH->TLH_DTFIM	,;
							TLH->TLH_DESCRI	,;
							aEventos		,;
							TLH->TLH_CLIENT ,;
							TLH->TLH_LOJA   ,;
							SubStr(NGSEEK("SA1",TLH->TLH_CLIENT+TLH->TLH_LOJA,1,"SA1->A1_NOME"),1,40) } )

		dbSelectArea("TLH")
		dbSkip()
	End

	cStartPath := AllTrim(GetSrvProfString("Startpath",""))

	If Substr(cStartPath,Len(cStartPath),1) <> "\"
		cStartPath := cStartPath+"\"
	Endif

	For nX := 1 to Len(aDados950)

		oPrint02:StartPage()
		lin := 300
		cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial

		If File(cLogo)
			oPrint02:SayBitMap(150,200,cLogo,250,50)
		Else
			cLogo := cStartPath+"LGRL"+cSMCOD+".BMP" // Empresa

			If File(cLogo)
				oPrint02:SayBitMap(150,200,cLogo,250,50)
			Else
				cLogo := "LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial

				If File(cLogo)
					oPrint02:SayBitMap(150,200,cLogo,250,50)
				Else
					cLogo := "LGRL"+cSMCOD+".BMP" // Empresa

					If File(cLogo)
						oPrint02:SayBitMap(150,200,cLogo,250,50)
					Endif

				Endif

			Endif

		Endif

		oPrint02:Say(lin-40,620,STR0010,oFont12n) //"SIPAT - Semana Interna de Prevenção de Acidentes do Trabalho"
		lin += 100 // 400
		oPrint02:Say(lin-40 ,620,STR0015 + aDados950[nX,7]+"-"+aDados950[nX,8]+" - "+aDados950[nX,9],oFont12n)  //"Cliente/Loja: "
		lin += 100 // 500
		oPrint02:Say(lin-40 ,950,STR0011 + DtoC(aDados950[nX,3]) + STR0012 + DtoC(aDados950[nX,4]) ,oFont12n) //"De  à  "
		lin += 200 // 700
		If !Empty(aDados950[nX,5])
			oPrint02:Say(lin,200,STR0013,oFont11n) //"Objetivo"
			Somalinha(100,nX)
			nLinhasMemo := MLCOUNT(aDados950[nX,5],100)
			For LinhaCorrente := 1 To nLinhasMemo
				oPrint02:Say(lin,200,MemoLine(aDados950[nX,5],100,LinhaCorrente),oFont11)
				Somalinha(50,nX)
			Next
			Somalinha(100,nX)
		Endif
		oPrint02:Say(lin,200,STR0014,oFont11n) //"Programação"
		Somalinha(50,nX)

		dDataAnt := CtoD("//")
		For nY := 1 to Len(aDados950[nX,6])
			If dDataAnt <> aDados950[nX,6,nY,1]
				Somalinha(50,nX)
				dDataAnt := aDados950[nX,6,nY,1]
				oPrint02:Say(lin,200, Transform(aDados950[nX,6,nY,1],"99/99/9999"),oFont11n)
				nDIA := DOW(aDados950[nX,6,nY,1])
				If nDIA > 0
					oPrint02:Say(lin,500, aTitles[nDIA] ,oFont11n)
				Endif
				Somalinha(60,nX)
			Endif
			oPrint02:Say(lin,200, aDados950[nX,6,nY,2] ,oFont11n)//horario inicio
			oPrint02:Say(lin,310, STR0033,oFont11n)   // as
			oPrint02:Say(lin,360, aDados950[nX,6,nY,3] ,oFont11n)// horario fim
			oPrint02:Say(lin,500, aDados950[nX,6,nY,5] ,oFont11)
			Somalinha(50,nX)
			If !Empty( aDados950[nX,6,nY,6] + aDados950[nX,6,nY,4] )
				cTextoLinha := ""
				If !Empty(aDados950[nX,6,nY,6])
					cTextoLinha += STR0016+Alltrim(aDados950[nX,6,nY,6])  //"Responsável: "
				Endif
				If !Empty(aDados950[nX,6,nY,4])
					If !Empty(cTextoLinha)
						cTextoLinha += "   /   "
					Endif
					cTextoLinha += STR0017+Alltrim(aDados950[nX,6,nY,4])  //"Local: "
				Endif
				oPrint02:Say(lin,500, cTextoLinha ,oFont11)
				Somalinha(50,nX)
				If Mv_par11 == 1
					nLinhasMemo := MLCOUNT(aDados950[nX,6,nY,7],100)
					For LinhaCorrente := 1 To nLinhasMemo
						oPrint02:Say(lin,410,MemoLine(aDados950[nX,6,nY,7],100,LinhaCorrente),oFont11)
						Somalinha(30,nX)
					Next LinhaCorrente
				Endif
			Endif
			Somalinha(10,nX)
		Next nY

		oPrint02:EndPage()
	Next nX

	If mv_par12 == 1
		oPrint02:Preview()
	Else
		oPrint02:Print()
	EndIf

	//Seta o formato da data anterior
	Set(_SET_DATEFORMAT,cSet)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha

Controla a quebra de linha e de página

@author  Denis Hyroshi de Souza
@since   09/10/2006

@sample  Somalinha(50, nX)

@param   _li, Numérico, Tamanho da quebra de linha
@param   nPos, Numérico, Número correspondente a uma posção de um array
                         de informações a serem impressas no cabeçalho da página
/*/
//-------------------------------------------------------------------
Static Function Somalinha(_li,nPos)

	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()

	Default nPos := 1

	If _li != nil
		lin += _li
	Else
		lin += 70
	Endif

	If lin > 2900
		oPrint02:EndPage()
		oPrint02:StartPage()

		lin := 300

		cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial
		If File(cLogo)
			oPrint02:SayBitMap(150,200,cLogo,250,50)
		Else
			cLogo := cStartPath+"LGRL"+cSMCOD+".BMP" // Empresa
			If File(cLogo)
				oPrint02:SayBitMap(150,200,cLogo,250,50)
			Else
				cLogo := "LGRL"+cSMCOD+cSMFIL+".BMP" // Empresa+Filial
				If File(cLogo)
					oPrint02:SayBitMap(150,200,cLogo,250,50)
				Else
					cLogo := "LGRL"+cSMCOD+".BMP" // Empresa
					If File(cLogo)
						oPrint02:SayBitMap(150,200,cLogo,250,50)
					Endif
				Endif
			Endif
		Endif

		oPrint02:Say(lin-40,620,STR0010,oFont12n) //"SIPAT - Semana Interna de Prevenção de Acidentes do Trabalho"
		lin += 100 // 400
		If lSigaMdtps
			lin += 100 // 400
			oPrint02:Say(lin-40 ,620,STR0015 + aDados950[nPos,7]+"-"+aDados950[nPos,8]+" - "+aDados950[nPos,9],oFont12n)  //"Cliente/Loja: "
			lin += 100 // 400
		Endif
		oPrint02:Say(lin-40 ,950,STR0011 + DtoC(aDados950[nPos,3]) + STR0012 + DtoC(aDados950[nPos,4]) ,oFont12n) //"De  à  "
		lin += 200 // 600
	Endif

Return