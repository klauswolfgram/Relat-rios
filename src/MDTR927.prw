/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "MDTR927.ch"
#include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR927
Ata de Eleição CIPA.

@type    function
@author  Denis Hyroshi de Souza
@since   18/10/2006
@sample  MDTR928()

@param cCodMandato, Caractere, Código do mandato
@param lImp, Lógico, Controle de impressão
@param cCliente, Caractere, Código do clinte
@param cLoja, Caractere, Código da loja
@param lUsaPt, Lógico, Variavel de controle

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
User Function MDTR927( cCodMandato , lImp , cCliente , cLoja , lUsaPt, cArquivo )

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	Local aArea := GetArea()
	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Default lImp := .F.
	Default lUsaPt := .T.

	Private lImpEmail := lImp
	Private nomeprog := "MDTR927"
	Private titulo   := STR0001 //"Ata de Eleição"
	Private cPerg    := "MDT927    "
	Private nIndTNQ  := 0
	Private lUpdExec

	dbSelectArea("SX3")
	dbSetOrder(1)
	If DbSeek("TK8")
		lUpdExec := .T.
	Else
		lUpdExec := .F.
	EndIf

	nIndTNQ := NGRETORDEM("TNQ","TNQ_FILIAL+TNQ_MANDAT+TNQ_FILMAT+TNQ_MAT+DTOS(TNQ_DTSAID)",.T.)

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	cPerg    :=If(!lSigaMdtps,"MDT927    ","MDT927PS  ")

	/*------------------------------
	/PADRÃO							|
	|  Mandato CIPA ?				|
	|  Tipo de Impressao ?			|
	|  Imprimir Brancos/Nulos ?		|
	|  								|
	//PRESTADOR						|
	|  Cliente ?					|
	|  Loja							|
	|  Mandato CIPA ?				|
	|  Tipo de Impressao ?			|
	|  Imprimir Brancos/Nulos ?		|
	 -------------------------------*/

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
		Pergunte(cPerg,.F.,titulo)
		Processa({|lEND| MDTA927IMP(cArquivo)},titulo+STR0037)  //" - Processando..."
	Else
		If Pergunte(AllTrim(cPerg),.T.,titulo)
			Processa({|lEND| MDTA927IMP()},STR0002) //"Imprimindo..."
		Endif
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTA927IMP
Funcao de impressao

@author Denis Hyroshi de Souza
@since 09/10/2006
@return nil
/*/
//---------------------------------------------------------------------
Static Function MDTA927IMP(cArquivo)

	Local nFor,nInd,nI, i, nLinhas
	Local cTexto  := Space(10)
	Local aResp   := {}, nX := 0
	Local aCandVt := {}
	Local cTxt02
	Local lCipatr  := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"
	Local cDiretorio := ""

	If !lImpEmail
		Private oPrint01    := FwMsPrinter():New( OemToAnsi(titulo))
	Endif

	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont11n  := TFont():New("VERDANA",11,11,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .T. // Controla impressao da primeira pagina ou nao
	Private nVtbranco, nVtnulo, nListar
	Private nIndice   := 0
	Private nIndPS    := NGRETORDEM("TNQ","TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANEXT+TNQ_MAT+DTOS(TNQ_DTSAID)",.T.)

	Lin := 200
	oPrint01:SetPortrait() //retrato

	nContFun := 0
	nPagina_ := 0

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		If lUpdExec
			DbSelectArea("TK8")
			DbSetOrder(3)
			If DbSeek(XFILIAL("TK8")+mv_par01+mv_par02+mv_par03)
				While !Eof() .And. xFilial("TK8") == TK8->TK8_FILIAL .And. MV_PAR03 == TK8->TK8_MANDAT
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

		oPrint01:StartPage()

		// Localização do Logo da Empresa
		oPrint01:SayBitMap(50,50,NGLocLogo(),250,50)

		oPrint01:SayAlign(lin,400,STR0003,oFont12n, 1600, 100, , 2, 0 ) //"ATA DE ELEIÇÃO DOS REPRESENTANTES DOS EMPREGADOS"

		oPrint01:Say(lin,400,STR0003,oFont12n) //"ATA DE ELEIÇÃO DOS REPRESENTANTES DOS EMPREGADOS CIPA"

		cMsgDiaEl := ""
		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += Strzero(Day(TNN->TNN_ELEICR),2)
		Endif
		cMsgDiaEl += STR0004 //" dias do mês "
		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_ELEICR))
		Endif
		cMsgDiaEl += STR0005 //" de "
		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += Strzero(Year(TNN->TNN_ELEICR),4)
		Endif

		lin += 200
		cTxt01 := STR0006+cMsgDiaEl+STR0007 //"Aos "###" no local designado no Edital de Convocação "

		If lUpdExec

			If Len(aResp) == 1
				cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0043+cTexto //" , com a presença do Senhor "
			Else
				cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0008+cTexto //" , com a presença dos Senhores "
			Endif

			cTxt01 += " " + STR0010+TNN->TNN_HORAIN //" instalou-se a mesa receptora e apuradora dos votos às "
		Else
			cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0008+cResp01+STR0009 //" , com a presença dos Senhores "###" e "
			cTxt01 += cResp02+STR0010+TNN->TNN_HORAIN //" instalou-se a mesa receptora e apuradora dos votos às "
		Endif

		cTxt01 += If(lCipatr, STR0054 ,STR0011) //" horas, o(a) Sr.(a) Presidente da mesa declarou iniciados os trabalhos. Durante a votação, "
		cTxt01 += STR0012 //"verificaram-se as seguintes ocorrências: "

		cMensagem := cTxt01+TNN->TNN_OCORRE

		If Right(trim(cMensagem),1) <> "."
			cMensagem := trim(cMensagem)+"."
		Endif

		nLinhasMemo := MLCOUNT(cMensagem,80)

		For nInd := 1 To nLinhasMemo

			If nInd == 1
				oPrint01:Say(lin,400,MemoLine(cMensagem,80,nInd),oFont12)
			Else
				oPrint01:Say(lin,300,MemoLine(cMensagem,80,nInd),oFont12)
			Endif

			Somalinha()
		Next

		cTxtMsg := STR0040+TNN->TNN_HORAFI+If(lCipatr,STR0055,STR0013) //" horas, o(a) Sr.(a) Presidente declarou encerrados os trabalhos de eleição, verificando-se" //"Às "
		oPrint01:Say(lin,300,cTxtMsg,oFont12)
		Somalinha()
		cTxtMsg := STR0014+Alltrim(Str(TNN->TNN_VOTOS,6))+; //"que compareceram "
													STR0015 //" empregados e passando-se à apuração, na presença de quantos"
		oPrint01:Say(lin,300,cTxtMsg,oFont12)
		Somalinha()
		cTxtMsg := STR0016 //"desejassem."
		oPrint01:Say(lin,300,cTxtMsg,oFont12)
		Somalinha(110)

		oPrint01:Say(lin,310,STR0017,oFont12) //"Após a apuração chegou-se ao seguinte resultado:"
		Somalinha(090)

		oPrint01:Box(lin,300,lin+140,2200)
		oPrint01:line(lin+70,300,lin+70,2200)
		oPrint01:Line(lin,1250,lin+140,1250)
		oPrint01:Line(lin+70,1000,lin+140,1000)
		oPrint01:Line(lin+70,1950,lin+140,1950)
		oPrint01:Say(lin+50,650,STR0018,oFont11n) //"Titular(es)"
		oPrint01:Say(lin+50,1600,STR0019,oFont11n) //"Suplente(s)"
		oPrint01:Say(lin+120,600,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+120,1050,STR0021,oFont11n) //"Votos"
		oPrint01:Say(lin+120,1550,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+120,2000,STR0021,oFont11n) //"Votos"

		Somalinha(140)

		aSuplentes := {}
		aTitulares := {}
		aOutrosCan := {}

		dbSelectArea("TNO")
		dbSetOrder(4)  //TNO_FILIAL+TNO_CLIENT+TNO_LOJA+TNO_MANDAT+TNO_MAT+DTOS(TNO_DTCAND)
		dbSeek(xFilial("TNO")+Mv_par01+Mv_par02+Mv_par03)

		While !eof() .And. xFilial("TNO")+Mv_par01+Mv_par02+Mv_par03 == TNO_FILIAL+TNO_CLIENT+TNO_LOJA+TNO_MANDAT
			cFil1Tmp := cFilAnt

			If !Empty(TNO->TNO_FILMAT)
				cFil1Tmp := TNO->TNO_FILMAT
			Endif

			dbSelectArea("SRA")
			dbSetOrder(1)

			If !dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT) .Or. TNO->TNO_VOTOS <= 0
				dbSelectArea("TNO")
				dbSkip()
				Loop
			Endif

			cMandato :=	NgSeek("TNQ",Mv_par01,nIndPS,"TNQ_MANDAT")

			If !Empty(cMandato)
				nIndice  := nIndPS
			EndIf

			dbSelectArea("TNQ")
			dbSetOrder(If(nIndice > 0,nIndice,8))  //TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT+TNQ_MAT+DTOS(TNQ_DTSAID)

			If dbSeek(xFilial("TNQ")+Mv_par01+Mv_par02+Mv_par03+TNO->TNO_MAT)

				If TNQ->TNQ_TIPCOM == "1"
					aADD(aTitulares,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
				Else
					aADD(aSuplentes,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
				Endif

			Else
				aADD(aOutrosCan,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
			Endif

			dbSelectArea("TNO")
			dbSkip()
		End

		//Ordenando pela quantidade de votos em ordem descrescente
		ASORT(aTitulares,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })
		ASORT(aSuplentes,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })
		ASORT(aOutrosCan,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })

		nAteFor := If( Len(aTitulares) > Len(aSuplentes) , Len(aTitulares) , Len(aSuplentes) )

		For nFor := 1 to nAteFor
			oPrint01:line(lin, 300,lin+60, 300)
			oPrint01:Line(lin,1000,lin+60,1000)
			oPrint01:Line(lin,1250,lin+60,1250)
			oPrint01:Line(lin,1950,lin+60,1950)
			oPrint01:line(lin,2200,lin+60,2200)
			oPrint01:line(lin+60,300,lin+60,2200)

			If Len(aTitulares) >= nFor
				oPrint01:Say(lin+08, 350,aTitulares[nFor,2],oFont10)
				oPrint01:Say(lin+08,1050,Str(aTitulares[nFor,3],6),oFontCNEW)
			Endif

			If Len(aSuplentes) >= nFor
				oPrint01:Say(lin+08,1300,aSuplentes[nFor,2],oFont10)
				oPrint01:Say(lin+08,2000,Str(aSuplentes[nFor,3],6),oFontCNEW)
			Endif

			Somalinha(60,.T.)
		Next nFor

		cVicePres := " "
		dbSelectArea("TNQ")
		dbSetOrder(8)  //TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT+TNQ_MAT+DTOS(TNQ_DTSAID)
		dbSeek(xFilial("TNQ")+Mv_par01+Mv_par02+Mv_par03)

		While !eof() .And. xFilial("TNQ")+Mv_par01+Mv_par02+Mv_par03 == TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT
			cFil1Tmp := cFilAnt

			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif

			If TNQ->TNQ_INDFUN == "2"
				cVicePres := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))+" "
				Exit
			Endif

			dbSelectArea("TNQ")
			dbSkip()
		End

		cTxt02 := STR0022 //"Após a classificação dos representantes dos empregados por ordem de votação, dos"
		cTxt02 += STR0023+cVicePres //"titulares e suplentes, esses representantes elegeram o "
		cTxt02 += If(lCipatr,STR0056,STR0024)+" " //"para Vice-Presidente."
		cTxt02 += STR0025 //"Demais votados em ordem decrescente de votos:"
		nLinhas := MLCOUNT(cTxt02, 80)
		oPrint01:SayAlign(lin,310,cTxt02,oFont12, 1900, 45 * nLinhas, , 3, 0 )
		Somalinha(090)

		oPrint01:Box(lin,300,lin+70,2200)
		oPrint01:Line(lin,1250,lin+70,1250)
		oPrint01:Line(lin,1000,lin+70,1000)
		oPrint01:Line(lin,1950,lin+70,1950)
		oPrint01:Say(lin+50,600,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+50,1050,STR0021,oFont11n) //"Votos"
		oPrint01:Say(lin+50,1550,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+50,2000,STR0021,oFont11n) //"Votos"

		Somalinha(70)
		nAteFor := Int(Len(aOutrosCan)/2)

		If (Len(aOutrosCan) % 2) == 1
			nAteFor++
		Endif

		For nFor := 1 to nAteFor
			nInd1 := (nFor*2)-1 //Coluna1
			nInd2 := (nFor*2)   //Coluna2
			oPrint01:line(lin, 300,lin+60, 300)
			oPrint01:Line(lin,1000,lin+60,1000)
			oPrint01:Line(lin,1250,lin+60,1250)
			oPrint01:Line(lin,1950,lin+60,1950)
			oPrint01:line(lin,2200,lin+60,2200)
			oPrint01:line(lin+60,300,lin+60,2200)

			If Len(aOutrosCan) >= nInd1
				oPrint01:Say(lin+08, 310,aOutrosCan[nInd1,2],oFont10)
				oPrint01:Say(lin+08,1010,Str(aOutrosCan[nInd1,3],6),oFontCNEW)
			Endif

			If Len(aOutrosCan) >= nInd2
				oPrint01:Say(lin+08,1260,aOutrosCan[nInd2,2],oFont10)
				oPrint01:Say(lin+08,1960,Str(aOutrosCan[nInd2,3],6),oFontCNEW)
			Endif

			Somalinha(60,.T.)
		Next nFor

		nListar := mv_par06

		If nListar == 1
			Somalinha()
			oPrint01:Say(lin,310,STR0052,oFont12) //"Candidatos sem voto:"
			Somalinha(090)

			oPrint01:Box(lin,300,lin+70,1250)
			oPrint01:Say(lin+50,600,STR0020,oFont11n) //"Nome"
			Somalinha(70)

			dbSelectArea("TNO")
			dbSetOrder(4)
			dbSeek(xFilial("TNO")+Mv_par01+Mv_par02+Mv_par03)

			While !eof() .And. xFilial("TNO")+Mv_par01+Mv_par02+Mv_par03 == TNO_FILIAL+TNO_CLIENT+TNO_LOJA+TNO_MANDAT

				If TNO->TNO_VOTOS <= 0
					dbSelectArea("SRA")
					dbSetOrder(1)

					If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
						oPrint01:line(lin, 300,lin+60, 300)
						oPrint01:line(lin,1250,lin+60,1250)
						oPrint01:line(lin+60,300,lin+60,1250)
						oPrint01:Say(lin+08, 310,SRA->RA_NOME,oFont10)
						Somalinha(60,.T.)
					Endif

				EndIf

				dbSelectArea("TNO")
				dbSkip()
			End

		EndIf

		cFilTmp := cFilAnt

		If !Empty(TNN->TNN_FILSEC)
			cFilTmp := TNN->TNN_FILSEC
		Endif

		cNomeSecr := Alltrim(Posicione("SRA",1,xFilial("SRA",cFilTmp)+TNN->TNN_SECRET,"RA_NOME"))+" "

		Somalinha(50)
		oPrint01:Say(lin,310,If(lCipatr,STR0057,STR0026),oFont12) //"E, para constar, mandou o(a) Sr.(a) Presidente da mesa que fosse lavrada a presente Ata,"
		Somalinha(70)
		oPrint01:Say(lin,310,STR0027+cNomeSecr+STR0028,oFont12) //"por mim assinada, "###", pelos Membros da mesa e"
		Somalinha(70)
		oPrint01:Say(lin,310,STR0029,oFont12) //"pelos eleitos."
		Somalinha(70)

		nAddLi1 := 0
		nAddLi2 := 0
		If lin+560 > 3050
			Somalinha(9999)
		Else
			If lin+560 <= 2950
				nAddLi1 := 50
				nAddLi2 := 100
			Endif
		Endif

		oPrint01:Line(lin+140+nAddLi1,300,lin+140+nAddLi1,800)
		oPrint01:Say(lin+150+nAddLi1,370,If(lCipatr,STR0058,STR0030),oFont10) //"Presidente da mesa"
		oPrint01:Line(lin+140+nAddLi1,1100,lin+140+nAddLi1,1600)
		oPrint01:Say(lin+150+nAddLi1,1180,STR0031,oFont10) //"Secretário da mesa"

		oPrint01:Say(lin+250+nAddLi1,300,STR0032,oFont11n) //"Representantes dos Empregados:"

		oPrint01:Line(lin+550+nAddLi2,300,lin+550+nAddLi2,800)
		oPrint01:Say(lin+560+nAddLi2,490,STR0033,oFont10) //"Titular"
		oPrint01:Line(lin+550+nAddLi2,1100,lin+550+nAddLi2,1600)
		oPrint01:Say(lin+560+nAddLi2,1265,STR0034,oFont10) //"Suplente"

		oPrint01:EndPage()

		If lImpEmail
			cDiretorio := AllTrim(GetMV("MV_RELT",," "))
			If EMPTY(cDiretorio)
				cDiretorio := "\"
			EndIf
			If Substr(cDiretorio,Len(cDiretorio),1) != "\"
				cDiretorio += "\"
			Endif

			cPrefixo := cDiretorio+"AtaEleicao"+Alltrim(Mv_par03)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)

			If !oPrint01:SaveAllAsJPEG(cPrefixo,931,1330,150)
				MsgStop(STR0041,STR0042) //"Não foi possível gravar o relatório"###"AVISO"
				cAnexo01 := .F.
			EndIf

			// Varre o diretório e procura pelas páginas gravadas.
			aFiles := Directory( cPrefixo+"*.jpg" )

			// Monta um Vetor com o path e nome do arquivo em cada linha para passar via email
			cAnexo01 := ""
			For nI:= 1 to Len(aFiles)
				cAnexo01 += cDiretorio+aFiles[nI,1] + "; "
			Next nI
		Else
			If mv_par04 == 1
				oPrint01:Preview()
			Else
				oPrint01:Print()
			EndIf
		Endif

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		If lUpdExec
			DbSelectArea("TK8")
			DbSetOrder(1)
			If DbSeek(XFILIAL("TK8")+mv_par01)
				While !Eof() .And. xFilial("TK8") == TK8->TK8_FILIAL .And. MV_PAR01 == TK8->TK8_MANDAT
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

		oPrint01:StartPage()

		// Localização do Logo da Empresa
		oPrint01:SayBitMap(50,50,NGLocLogo(),250,50)
		oPrint01:SayAlign(lin,400,STR0003,oFont12n, 1600, 100, , 2, 0 ) //"ATA DE ELEIÇÃO DOS REPRESENTANTES DOS EMPREGADOS"

		cMsgDiaEl := ""

		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += Strzero(Day(TNN->TNN_ELEICR),2)
		Endif

		cMsgDiaEl += STR0004 //" dias do mês "

		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_ELEICR))
		Endif

		cMsgDiaEl += STR0005 //" de "

		If !Empty(TNN->TNN_ELEICR)
			cMsgDiaEl += Strzero(Year(TNN->TNN_ELEICR),4)
		Endif

		lin += 200
		cTxt01 := STR0006+cMsgDiaEl+STR0007 //"Aos "###" no local designado no Edital de Convocação "

		If lUpdExec

			If Len(aResp) == 1
				cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0043+cTexto //" , com a presença do Senhor "
			Else
				cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0008+cTexto //" , com a presença dos Senhores "
			Endif

			cTxt01 += " " + STR0010+TNN->TNN_HORAIN //" instalou-se a mesa receptora e apuradora dos votos às "
		Else
			cTxt01 += Alltrim(TNN->TNN_LOCAL)+STR0008+cResp01+STR0009 //" , com a presença dos Senhores "###" e "
			cTxt01 += cResp02+STR0010+TNN->TNN_HORAIN //" instalou-se a mesa receptora e apuradora dos votos às "
		Endif

		cTxt01 += If(lCipatr, STR0054 ,STR0011) //" horas, o(a) Sr.(a) Presidente da mesa declarou iniciados os trabalhos."

		If !Empty(TNN->TNN_OCORRE)
			cTxt01 += STR0012 //" Durante a votação, verificaram-se as seguintes ocorrências: "
			cMensagem := cTxt01+TNN->TNN_OCORRE
		Else
			cMensagem := cTxt01
		EndIf

		If Right(trim(cMensagem),1) <> "."
			cMensagem := trim(cMensagem)+"."
		Endif

		cMensagem += STR0040+TNN->TNN_HORAFI+If(lCipatr,STR0055,STR0013) //" horas, o(a) Sr.(a) Presidente declarou encerrados os trabalhos de eleição, verificando-se" //"Às "
		cMensagem += STR0014+Alltrim(Str(TNN->TNN_VOTOS,6))+; //"que compareceram "
													STR0015 //" empregados e passando-se à apuração, na presença de quantos"
		cMensagem += STR0016+" " //"desejassem."
		cMensagem += STR0017 //"Após a apuração chegou-se ao seguinte resultado:"

		nLinhasMemo := MLCOUNT(cMensagem,80)
		oPrint01:SayAlign(lin,200,cMensagem,oFont12, 1900, 45 * nLinhasMemo, , 3, 0 )
		Somalinha( nLinhasMemo * 37.5)

		Somalinha(100)

		oPrint01:Box(lin,200,lin+70,2100)
		oPrint01:Box(lin+70,200,lin+140,2100)
		oPrint01:Line(lin,1150,lin+140,1150)
		oPrint01:Say(lin+50,550,STR0018,oFont11n) //"Titular(es)"
		oPrint01:Say(lin+50,1400,STR0019,oFont11n) //"Suplente(s)"
		oPrint01:Say(lin+120,500,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+120,950,STR0021,oFont11n) //"Votos"
		oPrint01:Say(lin+120,1450,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+120,1900,STR0021,oFont11n) //"Votos"

		Somalinha(140)

		aSuplentes := {}
		aTitulares := {}
		aOutrosCan := {}

		dbSelectArea("TNO")
		dbSetOrder(1)
		dbSeek(xFilial("TNO")+Mv_par01)
		While !eof() .And. xFilial("TNO")+Mv_par01 == TNO->(TNO_FILIAL+TNO_MANDAT)

			cFil1Tmp := cFilAnt
			If !Empty(TNO->TNO_FILMAT)
				cFil1Tmp := TNO->TNO_FILMAT
			Endif

			dbSelectArea("SRA")
			dbSetOrder(1)
			If !dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT) .Or. TNO->TNO_VOTOS <= 0
				dbSelectArea("TNO")
				dbSkip()
				Loop
			Endif
			cMandato :=	NgSeek("TNQ",Mv_par01,4,"TNQ_MANDAT")
			If !Empty(cMandato)
				nIndice  := 4
			EndIf
			dbSelectArea("TNQ")
			cSeekTNQ := xFilial("TNQ")+Mv_par01+TNO->TNO_MAT
			If nIndTNQ > 0
				cSeekTNQ := xFilial("TNQ")+Mv_par01+cFil1Tmp+TNO->TNO_MAT
			Endif
			dbSetOrder(If(nIndice > 0,nIndice,If(nIndTNQ>0,nIndTNQ,1)))
			If dbSeek(cSeekTNQ)
				If TNQ->TNQ_TIPCOM == "1"
					aADD(aTitulares,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
				Else
					aADD(aSuplentes,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
				Endif
			Else
				aADD(aOutrosCan,{TNO->TNO_MAT,SRA->RA_NOME,TNO->TNO_VOTOS,dDataBase-SRA->RA_ADMISSA})
			Endif

			dbSelectArea("TNO")
			dbSkip()
		End

		//Ordenando pela quantidade de votos em ordem descrescente
		ASORT(aTitulares,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })
		ASORT(aSuplentes,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })
		ASORT(aOutrosCan,,, { |x, y| Str(x[3],6)+Str(x[4],6) > Str(y[3],6)+Str(y[4],6) })

		nAteFor := If( Len(aTitulares) > Len(aSuplentes) , Len(aTitulares) , Len(aSuplentes) )

		For nFor := 1 to nAteFor
			oPrint01:Box(lin-5,200,lin+63,2100)
			oPrint01:Line(lin-5,900,lin+63,900)
			oPrint01:Line(lin-5,1150,lin+63,1150)
			oPrint01:Line(lin-5,1850,lin+63,1850)

			If Len(aTitulares) >= nFor
				oPrint01:Say(lin+35, 210,aTitulares[nFor,2],oFont10)
				oPrint01:Say(lin+35,910,Str(aTitulares[nFor,3],6),oFontCNEW)
			Endif

			If Len(aSuplentes) >= nFor
				oPrint01:Say(lin+35,1160,aSuplentes[nFor,2],oFont10)
				oPrint01:Say(lin+35,1860,Str(aSuplentes[nFor,3],6),oFontCNEW)
			Endif

			Somalinha(63,.t.)
		Next nFor

		cVicePres := " "
		dbSelectArea("TNQ")
		dbSetOrder(1)
		dbSeek(xFilial("TNQ")+Mv_par01)
		While !eof() .And. xFilial("TNQ")+Mv_par01 == TNQ_FILIAL+TNQ_MANDAT
			cFil1Tmp := cFilAnt
			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif
			If TNQ->TNQ_INDFUN == "2"
				cVicePres := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))+" "
				Exit
			Endif
			dbSelectArea("TNQ")
			dbSkip()
		End

		Somalinha(50)
		cTxt02 := STR0022 //"Após a classificação dos representantes dos empregados por ordem de votação, dos"
		cTxt02 += STR0023+cVicePres //"titulares e suplentes, esses representantes elegeram o "
		cTxt02 += If(lCipatr,STR0056,STR0024) //"para Vice-Presidente."
		cTxt02 += STR0025 //"Demais votados em ordem decrescente de votos:"
		nLinhas := MLCOUNT(cTxt02, 90) * 45 //Valor em pixels da quantidade de linhas necessária
		oPrint01:SayAlign(lin,210,cTxt02,oFont12, 1900, nLinhas, , 3, 0 )
		Somalinha(nLinhas + 25)

		oPrint01:Box(lin,200,lin+65,2100)
		oPrint01:Line(lin,1150,lin+65,1150)
		oPrint01:Line(lin,900,lin+65,900)
		oPrint01:Line(lin,1850,lin+65,1850)
		oPrint01:Say(lin+50,500,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+50,950,STR0021,oFont11n) //"Votos"
		oPrint01:Say(lin+50,1450,STR0020,oFont11n) //"Nome"
		oPrint01:Say(lin+50,1900,STR0021,oFont11n) //"Votos"

		Somalinha(70)

		nAteFor := Int(Len(aOutrosCan)/2)
		If (Len(aOutrosCan) % 2) == 1
			nAteFor++
		Endif

		For nFor := 1 to nAteFor
			nInd1 := (nFor*2)-1 //Coluna1
			nInd2 := (nFor*2)   //Coluna2
			oPrint01:line(lin, 200,lin+60, 200)
			oPrint01:Line(lin,900,lin+60,900)
			oPrint01:Line(lin,1150,lin+60,1150)
			oPrint01:Line(lin,1850,lin+60,1850)
			oPrint01:line(lin,2100,lin+60,2100)
			oPrint01:line(lin+60,200,lin+60,2100)

			If Len(aOutrosCan) >= nInd1
				oPrint01:Say(lin+40, 210,aOutrosCan[nInd1,2],oFont10)
				oPrint01:Say(lin+40,910,Str(aOutrosCan[nInd1,3],6),oFontCNEW)
			Endif

			If Len(aOutrosCan) >= nInd2
				oPrint01:Say(lin+40,1160,aOutrosCan[nInd2,2],oFont10)
				oPrint01:Say(lin+40,1860,Str(aOutrosCan[nInd2,3],6),oFontCNEW)
			Endif

			Somalinha(60,.t.)
		Next nFor

		nListar := mv_par04

		If nListar == 1
			Somalinha()
			oPrint01:Say(lin,210,STR0052,oFont12) //"Candidatos sem voto:"
			Somalinha(090)

			oPrint01:Box(lin,200,lin+70,1150)
			oPrint01:Say(lin+50,500,STR0020,oFont11n) //"Nome"
			Somalinha(70)
			dbSelectArea("TNO")
			dbSetOrder(1)
			dbSeek(xFilial("TNO")+Mv_par01)
			While !eof() .And. xFilial("TNO")+Mv_par01 == TNO_FILIAL+TNO_MANDAT
				If TNO->TNO_VOTOS <= 0
					dbSelectArea("SRA")
					dbSetOrder(1)
					If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
						aAdd(aCandVt,SRA->RA_NOME)
					Endif
				EndIf
				dbSelectArea("TNO")
				dbSkip()
			End
		EndIf

	aSort(aCandVt,,,{|x,y| x < y })

	For nX := 1 To Len(aCandVt)
		oPrint01:line(lin, 200,lin+60, 200)
		oPrint01:line(lin,1150,lin+60,1150)
		oPrint01:line(lin+60,200,lin+60,1150)
		oPrint01:Say(lin+40, 210,aCandVt[nX],oFont10)
		Somalinha(60,.t.)
	Next nX

	cFilTmp := cFilAnt

	If !Empty(TNN->TNN_FILSEC)
		cFilTmp := TNN->TNN_FILSEC
	Endif

	cNomeSecr := Alltrim(Posicione("SRA",1,xFilial("SRA",cFilTmp)+TNN->TNN_SECRET,"RA_NOME"))+" "

	dbSelectArea("TNN")
	dbSetOrder(1)
	dbSeek(xFilial("TNN")+mv_par01)

	If lSigaMdtPs
		nTeste := mv_par05
	Else
		nTeste := mv_par03
	Endif

	If nTeste == 1

		If !Empty(TNN->TNN_VTBRAN)
			nVtbranco := TNN->TNN_VTBRAN
		ElseIf Empty(nVtbranco)
			nVtbranco := 0
		Endif

		If !Empty(TNN->TNN_VTNULO)
			nVtnulo := TNN->TNN_VTNULO
		ElseIf Empty(nVtnulo)
			nVtnulo := 0
		Endif

		Somalinha(090)
		oPrint01:Box(lin,200,lin+70,900)
		oPrint01:Line(lin,550,lin+68,550)
		oPrint01:Say(lin+50,220,STR0048,oFont11n) //"Votos Brancos"
		oPrint01:Say(lin+50,600,STR0049,oFont11n) //"Votos Nulos"
		Somalinha(70)
		oPrint01:Box(lin-5,200,lin+70,900)
		oPrint01:Line(lin-5,550,lin+68,550)

		oPrint01:Say(lin+40,250,Str(nVtbranco,6),oFontCNEW)
		oPrint01:Say(lin+40,630,Str(nVtnulo,6),oFontCNEW)
		//oPrint01:Say(lin+40,210,Str(aOutrosCan[nInd1,3],6),oFontCNEW)

		Somalinha(60,.T.)

		Endif

		Somalinha(090)
		cTxt02 := If(lCipatr,STR0057,STR0026)+" " //"E, para constar, mandou o(a) Sr.(a) Coordenador da mesa que fosse lavrada a presente Ata,"
		cTxt02 += STR0027+cNomeSecr+STR0028+" " //"por mim assinada, "###", pelos Membros da mesa e"
		cTxt02 += STR0029 //"pelos eleitos."
		nLinhas := MLCOUNT(cTxt02,80) * 45
		oPrint01:SayAlign(lin,210,cTxt02,oFont12, 1900, 100, , 3, 0 )
		Somalinha(nLinhas + 25)

		nAddLi1 := 0
		nAddLi2 := 0

		If lin+560 > 3050
			Somalinha(9999)
		Else

			If lin+560 <= 2950
				nAddLi1 := 50
				nAddLi2 := 100
			Endif

		Endif

		oPrint01:Line(lin+140+nAddLi1,200,lin+140+nAddLi1,700)
		oPrint01:Say(lin+200+nAddLi1,270,If(lCipatr,STR0058,STR0030),oFont10) //"Presidente da mesa"
		oPrint01:Line(lin+140+nAddLi1,1000,lin+140+nAddLi1,1500)
		oPrint01:Say(lin+200+nAddLi1,1080,STR0031,oFont10) //"Secretário da mesa"

		oPrint01:Say(lin+400+nAddLi1,200,STR0032,oFont11n) //"Representantes dos Empregados:"

		oPrint01:Line(lin+550+nAddLi2,200,lin+550+nAddLi2,700)
		oPrint01:Say(lin+600+nAddLi2,390,STR0033,oFont10) //"Titular"
		oPrint01:Line(lin+550+nAddLi2,1000,lin+550+nAddLi2,1500)
		oPrint01:Say(lin+600+nAddLi2,1165,STR0034,oFont10) //"Suplente"

		oPrint01:EndPage()

		If lImpEmail
			oPrint01:Print()
			cDiretorio := oPrint01:cPathPDF

			If File(cDiretorio+Lower(cArquivo)+".pdf") //Verifica se arquivo temporário foi gerado
				CpyT2S( cDiretorio+Lower(cArquivo)+".pdf" , "\SPOOL\", .F. , .F.)//Copia arquivo temporário para o Spool (SERVIDOR)
				cAnexo01 := "SPOOL" +"\"+ Lower(cArquivo)+".pdf;"
			Else
				cAnexo01 := .F.
			EndIf

		Else

			If mv_par02 == 1
				oPrint01:Preview()
			Else
				oPrint01:Print()
			EndIf

		Endif

	Endif

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Funcao de somar linha

@type    function
@author Denis Hyroshi de Souza
@since 09/10/2006
@sample  sample
Somalinha( 25, .F. )

@param _li, Numérico, Linha posicionada
@param _Tabela, Lógico, Verifica quebra de linha

@return  Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function Somalinha(_li,_Tabela)

	Default _Tabela := .F.

	If _li != nil
		lin += _li
	Else
		lin += 70
	Endif

	If lin > 3100
		oPrint01:EndPage()

		oPrint01:StartPage()

		lin := 200
		oPrint01:Say(lin,500,STR0003,oFont12n) //"ATA DE ELEIÇÃO DOS REPRESENTANTES DOS EMPREGADOS"
		lin := 400

		If _Tabela
			oPrint01:line(lin,300,lin,2200)
			Somalinha(70)
		Endif

	Endif

Return Nil