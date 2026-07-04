/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "MDTR928.ch"
#include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR928
Ata de Instalacao e Posse da CIPA

@type    function
@author  Denis Hyroshi de Souza
@since   01/11/2006
@sample  U_MDTR928()

@param cCodMandato, Caractere, Código do mandato
@param lImp, Lógico, Controle de impressão
@param cCliente, Caractere, Código do clinte
@param cLoja, Caractere, Código da loja
@param lUsaPt, Lógico, Variavel de controle

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR928( cCodMandato, lImp, cCliente, cLoja, lUsaPt, cArquivo )

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local aArea := GetArea()

	Default lImp := .F.
	Default lUsaPt := .T.

	Private lImpEmail := lImp

	Private lCipatr    := SuperGetMv( "MV_NG2NR31", .F., "2" ) == "1"
	Private lSigaMdtPS := SuperGetMv( "MV_MDTPS", .F., "N" ) == "S"
	Private lMdtMin    := SuperGetMv( "MV_MDTMIN", .F., "N" ) == "S"

	Private nomeprog := "MDTR928"
	Private titulo   := IIf( lMdtMin, STR0060, IIf( lCipatr, STR0045, STR0001 )) //"Ata de Instalacao e Posse da CIPATR" //"Ata de Instalacao e Posse da CIPA"
	Private cPerg    := If(!lSigaMdtPS,"MDT928    ","MDT928PS  ")

	/*--------------------------
	//PADRÃO					|
	|  Mandato CIPA ?			|
	|  Tipo de Impressao ?		|
	|  							|
	//PRESTADOR					|
	|  Cliente ?				|
	|  Loja						|
	|  Mandato CIPA ?			|
	|  Tipo de Impressao ?		|
	 ---------------------------*/

	If ExistBlock("MDTA111R") .And. lUsaPt
		//Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"C"})//Tipo do Evento

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
		Processa({|lEND| MDTA928IMP(cArquivo)},titulo+STR0040)  //" - Processando..."
	Else

		If Pergunte(cPerg,.T.,titulo)
			Processa({|lEND| MDTA928IMP()},STR0002) //"Imprimindo..."
		Endif

	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA928IMP
Funcao de impressao

@type    function
@author  Denis Hyroshi de Souza
@since   09/10/2006
@sample  MDTA928IMP()
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA928IMP(cArquivo)

	Local nFor,nInd,nI
	Local nCon := 0
	Local aCipTit := {}
	Local aCipSup := {}
	Local aCipVer := {}
	Local cViceCIPA := "" //Vice-Presidente CIPA
	Local cPresCIPA := "" //Presidente CIPA
	Local cSecrCIPA := "" //Secretario CIPA
	Local cSubsCIPA := "" //Substituto Secretario CIPA
	Local cDiretorio := ""

	If !lImpEmail
		Private oPrint02  := FwMsPrinter():New( OemToAnsi(titulo))
	Endif

	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont11n  := TFont():New("VERDANA",11,11,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .T. // Controla impressao da primeira pagina ou nao

	Lin := 200
	oPrint02:SetPortrait() //retrato

	nContFun := 0
	nPagina_ := 0

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)  //TNN_FILIAL+TNN_CLIENT+TNN_LOJAC+TNN_MANDAT
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		//cResp01 := Alltrim(Posicione("SRA",1,xFilial("SRA")+TNN->TNN_MATRE1,"RA_NOME"))+" "
		//cResp02 := Alltrim(Posicione("SRA",1,xFilial("SRA")+TNN->TNN_MATRE2,"RA_NOME"))+" "

		oPrint02:StartPage()

		// Localização do Logo da Empresa
		oPrint02:SayBitMap(50,50,NGLocLogo(),250,50)

		oPrint02:SayAlign(lin, 300, IIf( lMdtMin, STR0061, IIf( lCipatr, STR0048, STR0003 )),oFont12n, 1700, 100, , 2 , 0) //"ATA DE INSTALAÇÃO E POSSE DA CIPATR" //"ATA DE INSTALAÇÃO E POSSE DA CIPA"

		cMsgDiaEl := ""

		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += Strzero(Day(TNN->TNN_POSSE),2)
		Endif

		cMsgDiaEl += STR0004 //" dias do mês "

		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_POSSE))
		Endif

		cMsgDiaEl += STR0005 //" de "

		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += Strzero(Year(TNN->TNN_POSSE),4)
		Endif

		// Presidente Sessao de Posse CIPA
		cFil1Tmp := cFilAnt
		cFil2Tmp := cFilAnt
		If !Empty(TNN->TNN_FILPSE)
			cFil1Tmp := TNN->TNN_FILPSE
		Endif
		If !Empty(TNN->TNN_FILSSE)
			cFil2Tmp := TNN->TNN_FILSSE
		Endif
		cPreSessao := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNN->TNN_PRESES,"RA_NOME"))
		//Secretario Sessao de Posse CIPA
		cSecSessao := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil2Tmp)+TNN->TNN_SECSES,"RA_NOME"))

		lin += 200
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+mv_par01+mv_par02)

		cTxt01 := STR0006+cMsgDiaEl+STR0007+Alltrim(SA1->A1_NOME)+STR0008 //"Aos "###" na Empresa "###" nesta cidade, "
		cTxt01 += STR0009 //"presente(s) o/a(s) Senhor/Senhora(es/s) Diretor/Diretora(es/s) da Empresa, bem como os demais presentes, conforme Livro "
		cTxt01 += IIf( lMdtMin, STR0062, IIf( lCipatr, STR0047, STR0010 )) //"de Presença, reuniram-se para Instalação e Posse da Cipa desta Empresa, conforme o estabelecido "
		cTxt01 += If(lCipatr,STR0048,STR0011)+cPreSessao+If(lCipatr, STR0057, STR0012) //"pela portaria n° 3214/78. O(A) Senhor(a) "###" representante da Empresa e Presidente da Sessão, "
		cTxt01 += STR0013+cSecSessao+STR0014 //"tendo convidado a mim, "###" para Secretário da mesma, declarou "
		cTxt01 += STR0015 //"abertos os trabalhos, lembrando a todos os objetivos da Reunião, quais sejam: Instalação e "
		cTxt01 += STR0016 //"Posse dos componentes da CIPA. Continuando, declarou instalada a Comissão e empossados os "
		cTxt01 += STR0017 //"Representantes do Empregador:"

		cMensagem   := cTxt01
		nLinhasMemo := MLCOUNT(cMensagem,80) * 45
		oPrint02:SayAlign(lin,300,cMensagem,oFont12, 1700 , nLinhasMemo, , 3, 0)
		Somalinha(nLinhasMemo + 25)

		Somalinha(40)

		oPrint02:Box(lin,300,lin+70,2200)
		oPrint02:Line(lin,1250,lin+70,1250)
		oPrint02:Say(lin+50,650,STR0018,oFont11n) //"Titulares"
		oPrint02:Say(lin+50,1600,STR0019,oFont11n) //"Suplentes"

		Somalinha(70)

		aTitEmpresa := {}
		aTitFuncion := {}
		aSupEmpresa := {}
		aSupFuncion := {}

		dbSelectArea("TNQ")
		dbSetOrder(4)  //TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT+TNQ_MAT+DTOS(TNQ_DTSAID)
		dbSeek(xFilial("TNQ")+Mv_par01+MV_PAR02+MV_PAR03)
		While !eof() .And. xFilial("TNQ")+Mv_par01+MV_PAR02+MV_PAR03 == TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT

			cFil1Tmp := cFilAnt
			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif

			dbSelectArea("SRA")
			dbSetOrder(1)
			If dbSeek(xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT)

				If TNQ->TNQ_TIPCOM == "1"
					If TNQ->TNQ_INDICA == "1"
						aADD(aTitEmpresa,SRA->RA_NOME)
					Else
						aADD(aTitFuncion,SRA->RA_NOME)
					Endif
				Else
					If TNQ->TNQ_INDICA == "1"
						aADD(aSupEmpresa,SRA->RA_NOME)
					Else
						aADD(aSupFuncion,SRA->RA_NOME)
					Endif
				Endif

			Endif

			dbSelectArea("TNQ")
			dbSkip()
		End

		//Ordenando pelo nome
		ASORT(aTitEmpresa,,, { |x, y| x > y })
		ASORT(aSupEmpresa,,, { |x, y| x > y })

		nAteFor := If( Len(aTitEmpresa) > Len(aSupEmpresa) , Len(aTitEmpresa) , Len(aSupEmpresa) )

		For nFor := 1 to nAteFor
			oPrint02:line(lin, 300,lin+60, 300)
			oPrint02:Line(lin,1250,lin+60,1250)
			oPrint02:line(lin,2200,lin+60,2200)
			oPrint02:line(lin+60,300,lin+60,2200)
			If Len(aTitEmpresa) >= nFor
				oPrint02:Say(lin+08, 310,aTitEmpresa[nFor],oFont10)
			Endif
			If Len(aSupEmpresa) >= nFor
				oPrint02:Say(lin+08,1260,aSupEmpresa[nFor],oFont10)
			Endif
			Somalinha(60,.T.)
		Next nFor

		Somalinha(50)
		oPrint02:Say(lin,310,STR0020,oFont12) //"Da mesma forma declarou empossados os Representantes eleitos pelos Empregados:"
		Somalinha(090)

		oPrint02:Box(lin,300,lin+70,2200)
		oPrint02:Line(lin,1250,lin+70,1250)
		oPrint02:Say(lin+50,650,STR0018,oFont11n) //"Titulares"
		oPrint02:Say(lin+50,1600,STR0019,oFont11n) //"Suplentes"

		Somalinha(70)
		//Ordenando pelo nome
		ASORT(aTitFuncion,,, { |x, y| x > y })
		ASORT(aSupFuncion,,, { |x, y| x > y })

		nAteFor := If( Len(aTitFuncion) > Len(aSupFuncion) , Len(aTitFuncion) , Len(aSupFuncion) )

		For nFor := 1 to nAteFor
			oPrint02:line(lin, 300,lin+60, 300)
			oPrint02:Line(lin,1250,lin+60,1250)
			oPrint02:line(lin,2200,lin+60,2200)
			oPrint02:line(lin+60,300,lin+60,2200)

			If Len(aTitFuncion) >= nFor
				oPrint02:Say(lin+40, 310,aTitFuncion[nFor],oFont10)
			Endif

			If Len(aSupFuncion) >= nFor
				oPrint02:Say(lin+40,1260,aSupFuncion[nFor],oFont10)
			Endif

			Somalinha(60,.T.)
		Next nFor

		Somalinha(50)

		dbSelectArea("TNQ")
		dbSetOrder(4)  //TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT+TNQ_MAT+DTOS(TNQ_DTSAID)
		dbSeek(xFilial("TNQ")+Mv_par01+MV_PAR02+MV_PAR03)

		While !eof() .And. xFilial("TNQ")+Mv_par01+MV_PAR02+MV_PAR03 == TNQ_FILIAL+TNQ_CLIENT+TNQ_LOJA+TNQ_MANDAT

			cFil1Tmp := cFilAnt

			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif

			If TNQ->TNQ_INDFUN == "1" .And. Empty(cPresCIPA)
				cPresCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif

			If TNQ->TNQ_INDFUN == "2" .And. Empty(cViceCIPA)
				cViceCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif

			If TNQ->TNQ_INDFUN == "3" .And. Empty(cSecrCIPA)
				cSecrCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif

			If TNQ->TNQ_INDFUN == "4" .And. Empty(cSubsCIPA)
				cSubsCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif

			dbSelectArea("TNQ")
			dbSkip()
		End

		cTxt01 := IIf( lMdtMin, STR0063, IIf( lCipatr, STR0049, STR0021 ))+cPresCIPA+STR0022 //"A seguir, foi designado para Coordenador da CIPATR o Senhor " //"A seguir, foi designado para Presidente da CIPA o(a) Senhor(a) "###", tendo sido escolhido "
		cTxt01 += STR0023+cViceCIPA+ If(lCipatr,STR0051,STR0024) //" para Vice-Coordenador. " //"entre os Representantes eleitos dos Empregados o(a) Senhor(a) "###" para Vice-Presidente. "
		cTxt01 += STR0025 //"Os Representantes do Empregador e dos Empregados, em comum acordo, escolheram "
		cTxt01 += STR0026+cSecrCIPA+ IIf( lMdtMin, STR0064, IIf( lCipatr, STR0052, STR0027 )) //" para Secretário da CIPATR, sendo seu substituto o Senhor " //"também o(a) Senhor(a) "###" para Secretário da CIPA, sendo seu substituto o(a) Senhor(a) "
		cTxt01 += cSubsCIPA+If(lCipatr,STR0058,STR0028) //". Nada mais havendo para tratar, o Presidente da Sessão deu por encerrada a reunião, "
		cTxt01 += IIf( lMdtMin, STR0065, IIf( lCipatr, STR0054, STR0029 )) //"lembrando a todos que o período da gestão da CIPATR ora instalada será de 02 (dois) anos, " //"lembrando a todos que o período da gestão da CIPA ora instalada será de 01 (um) ano, "
		cTxt01 += STR0030 //"a contar da presente data. E, para constar, lavrou-se a presente Ata que, lida e "
		cTxt01 += If(lCipatr,STR0059,STR0031) //"aprovada, vai assinada por mim, Secretário, pelo Presidente da Sessão e por todos os "
		cTxt01 += STR0032 //"Representantes eleitos e/ou designados, inclusive os Suplentes."

		cMensagem   := cTxt01
		nLinhasMemo := MLCOUNT(cMensagem,80) * 45
		oPrint02:SayAlign(lin,300,cMensagem,oFont12, 1700 , nLinhasMemo, , 3, 0)

		Somalinha(200)

		oPrint02:Line(lin,300,lin,1000)
		oPrint02:Say(lin+50,450,If(lCipatr,STR0056,STR0033),oFont10) //"Presidente da Sessão"
		oPrint02:Line(lin,1500,lin,2200)
		oPrint02:Say(lin+50,1650,STR0034,oFont10) //"Secretário da Sessão"

		Somalinha(100)

		nAteFor := If( Len(aTitFuncion)+Len(aTitEmpresa) > Len(aSupFuncion)+Len(aSupEmpresa) , ;
					Len(aTitFuncion)+Len(aTitEmpresa) , Len(aSupFuncion)+Len(aSupEmpresa) )

		oPrint02:Say(lin,550,STR0018,oFont12) //"Titulares"
		oPrint02:Say(lin,1750,STR0019,oFont12) //"Suplentes"
		Somalinha(60)

		For nInd := 1 to nAteFor
			Somalinha(80)
			oPrint02:Line(lin,300,lin,1000)
			oPrint02:Line(lin,1500,lin,2200)
		Next nInd

		Somalinha(150)
		oPrint02:Line(lin,300,lin,1000)
		oPrint02:Line(lin,1500,lin,2200)
		oPrint02:Say(lin+50,550,STR0035,oFont10) //"Secretário"
		oPrint02:Say(lin+50,1650,STR0036,oFont10) //"Secretário Substituto"

		oPrint02:EndPage()

		If lImpEmail
			cDiretorio := AllTrim(GetNewPar("MV_RELT"," "))
			If EMPTY(cDiretorio)
				cDiretorio := "\"
			EndIf
			If Substr(cDiretorio,Len(cDiretorio),1) != "\"
				cDiretorio += "\"
			Endif

			cPrefixo := cDiretorio+"AtaPosse"+Alltrim(Mv_par03)+"_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)

			If !oPrint02:SaveAllAsJPEG(cPrefixo,931,1330,150)
				MsgStop(STR0043,STR0044) //"Não foi possível gravar o relatório"###"AVISO"
				cAnexo02 := .T.
			EndIf

			// Varre o diretório e procura pelas páginas gravadas.
			aFiles := Directory( cPrefixo+"*.jpg" )

			// Monta um Vetor com o path e nome do arquivo em cada linha para passar via email
			cAnexo02 := ""
			For nI:= 1 to Len(aFiles)
				cAnexo02 += cDiretorio+aFiles[nI,1] + "; "
			Next nI
		Else
			If mv_par04 == 1
				oPrint02:Preview()
			Else
				oPrint02:Print()
			EndIf
		Endif

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)
		//cResp01 := Alltrim(Posicione("SRA",1,xFilial("SRA")+TNN->TNN_MATRE1,"RA_NOME"))+" "
		//cResp02 := Alltrim(Posicione("SRA",1,xFilial("SRA")+TNN->TNN_MATRE2,"RA_NOME"))+" "

		oPrint02:StartPage()

		// Localização do Logo da Empresa
		oPrint02:SayBitMap(50,50,NGLocLogo(),250,50)

		oPrint02:SayAlign(lin, 300, IIf( lMdtMin, STR0061, IIf( lCipatr, STR0048, STR0003 )), oFont12n, 1700, 150, , 2 , 0) //"ATA DE INSTALAÇÃO E POSSE DA CIPATR"//"ATA DE INSTALAÇÃO E POSSE DA CIPA"

		cMsgDiaEl := ""
		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += Strzero(Day(TNN->TNN_POSSE),2)
		Endif
		cMsgDiaEl += STR0004 //" dias do mês "
		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += UPPER(MesExtenso(TNN->TNN_POSSE))
		Endif
		cMsgDiaEl += STR0005 //" de "
		If !Empty(TNN->TNN_POSSE)
			cMsgDiaEl += Strzero(Year(TNN->TNN_POSSE),4)
		Endif

		//Presidente Sessao de Posse CIPA
		cFil1Tmp := cFilAnt
		cFil2Tmp := cFilAnt
		If !Empty(TNN->TNN_FILPSE)
			cFil1Tmp := TNN->TNN_FILPSE
		Endif
		If !Empty(TNN->TNN_FILSSE)
			cFil2Tmp := TNN->TNN_FILSSE
		Endif
		cPreSessao := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNN->TNN_PRESES,"RA_NOME"))
		//Secretario Sessao de Posse CIPA
		cSecSessao := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil2Tmp)+TNN->TNN_SECSES,"RA_NOME"))

		lin += 200
		cTxt01 := STR0006+cMsgDiaEl+STR0007+Alltrim(SM0->M0_NOMECOM)+STR0008 //"Aos "###" na Empresa "###" nesta cidade, "
		cTxt01 += STR0009 //"presente(s) o/a(s) Senhor/Senhora(es/s) Diretor/Diretora(es/s) da Empresa, bem como os demais presentes, conforme Livro "
		cTxt01 += IIf( lMdtMin, STR0062, IIf( lCipatr, STR0049, STR0010 )) //"de Presença, reuniram-se para Instalação e Posse da Cipatr desta Empresa, conforme o estabelecido " //"de Presença, reuniram-se para Instalação e Posse da Cipa desta Empresa, conforme o estabelecido "
		cTxt01 += If(lCipatr,STR0050,STR0011)+cPreSessao+If(lCipatr, STR0057, STR0012) //"pela portaria n° 86/05. O Senhor " //"pela portaria n° 3214/78. O(A) Senhor(a) "###" representante da Empresa e Presidente da Sessão, "
		cTxt01 += STR0013+cSecSessao+STR0014 //"tendo convidado a mim, "###" para Secretário da mesma, declarou "
		cTxt01 += STR0015 //"abertos os trabalhos, lembrando a todos os objetivos da Reunião, quais sejam: Instalação e "
		cTxt01 += STR0016 //"Posse dos componentes da CIPA. Continuando, declarou instalada a Comissão e empossados os "
		cTxt01 += STR0017 //"Representantes do Empregador:"

		cMensagem   := cTxt01
		nLinhasMemo := MLCOUNT(cMensagem,80) * 45
		oPrint02:SayAlign(lin,300,cMensagem,oFont12, 1800 , nLinhasMemo, , 3, 0)
		Somalinha(nLinhasMemo + 25)

		oPrint02:Box(lin,300,lin+70,2100)
		oPrint02:Line(lin,1150,lin+70,1150)
		oPrint02:Say(lin+50,550,STR0018,oFont11n) //"Titulares"
		oPrint02:Say(lin+50,1500,STR0019,oFont11n) //"Suplentes"

		Somalinha(70)

		aTitEmpresa := {}
		aTitFuncion := {}
		aSupEmpresa := {}
		aSupFuncion := {}

		dbSelectArea("TNQ")
		dbSetOrder(1)
		dbSeek(xFilial("TNQ")+Mv_par01)

		While !eof() .And. xFilial("TNQ")+Mv_par01 == TNQ_FILIAL+TNQ_MANDAT

			cFil1Tmp := cFilAnt
			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif

			dbSelectArea("SRA")
			dbSetOrder(1)
			If dbSeek(xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT)

				If TNQ->TNQ_TIPCOM == "1"
					If TNQ->TNQ_INDICA == "1"
						aADD(aTitEmpresa,SRA->RA_NOME)
					Else
						aADD(aTitFuncion,SRA->RA_NOME)
					Endif
					aADD(aCipTit,SRA->RA_NOME) //Componentes Titulares da CIPA
				Else
					If TNQ->TNQ_INDICA == "1"
						aADD(aSupEmpresa,SRA->RA_NOME)
					Else
						aADD(aSupFuncion,SRA->RA_NOME)
					Endif
					aADD(aCipSup,SRA->RA_NOME) //Componentes Substitutos da CIPA
				Endif

			Endif

			dbSelectArea("TNQ")
			dbSkip()
		End

		//Ordenando pelo nome
		ASORT(aTitEmpresa,,, { |x, y| x > y })
		ASORT(aSupEmpresa,,, { |x, y| x > y })

		nAteFor := If( Len(aTitEmpresa) > Len(aSupEmpresa) , Len(aTitEmpresa) , Len(aSupEmpresa) )

		For nFor := 1 to nAteFor
			oPrint02:Box(lin,300,lin+70,2100)
			oPrint02:Line(lin,1150,lin+70,1150)

			If Len(aTitEmpresa) >= nFor
				oPrint02:Say(lin+40, 350,aTitEmpresa[nFor],oFont10)
			Endif

			If Len(aSupEmpresa) >= nFor
				oPrint02:Say(lin+40, 1200,aSupEmpresa[nFor],oFont10)
			Endif

			Somalinha(60,.T.)
		Next nFor

		Somalinha(50)
		oPrint02:Say(lin,300,STR0020,oFont12) //"Da mesma forma declarou empossados os Representantes eleitos pelos Empregados:"
		Somalinha(090)

		oPrint02:Box(lin,300,lin+70,2100)
		oPrint02:Line(lin,1150,lin+70,1150)
		oPrint02:Say(lin+50,550,STR0018,oFont11n) //"Titulares"
		oPrint02:Say(lin+50,1500,STR0019,oFont11n) //"Suplentes"

		Somalinha(60)
		//Ordenando pelo nome
		ASORT(aTitFuncion,,, { |x, y| x > y })
		ASORT(aSupFuncion,,, { |x, y| x > y })

		nAteFor := If( Len(aTitFuncion) > Len(aSupFuncion) , Len(aTitFuncion) , Len(aSupFuncion) )

		For nFor := 1 to nAteFor
			oPrint02:Box(lin,300,lin+70,2100)
			oPrint02:Line(lin,1150,lin+70,1150)

			If Len(aTitFuncion) >= nFor
				oPrint02:Say(lin+40, 350,aTitFuncion[nFor],oFont10)
			Endif

			If Len(aSupFuncion) >= nFor
				oPrint02:Say(lin+40, 1200,aSupFuncion[nFor],oFont10)
			Endif

			Somalinha(60,.T.)
		Next nFor

		Somalinha(50)

		dbSelectArea("TNQ")
		dbSetOrder(1)
		dbSeek(xFilial("TNQ")+Mv_par01)
		While !eof() .And. xFilial("TNQ")+Mv_par01 == TNQ_FILIAL+TNQ_MANDAT
			cFil1Tmp := cFilAnt
			If !Empty(TNQ->TNQ_FILMAT)
				cFil1Tmp := TNQ->TNQ_FILMAT
			Endif
			If TNQ->TNQ_INDFUN == "1" .And. Empty(cPresCIPA)
				cPresCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif
			If TNQ->TNQ_INDFUN == "2" .And. Empty(cViceCIPA)
				cViceCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif
			If TNQ->TNQ_INDFUN == "3" .And. Empty(cSecrCIPA)
				cSecrCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif
			If TNQ->TNQ_INDFUN == "4" .And. Empty(cSubsCIPA)
				cSubsCIPA := Alltrim(Posicione("SRA",1,xFilial("SRA",cFil1Tmp)+TNQ->TNQ_MAT,"RA_NOME"))
			Endif

			dbSelectArea("TNQ")
			dbSkip()
		End

		U_MDTR928SEC( @cSecrCIPA, @cSubsCIPA, Mv_par01 )

		cTxt01 := IIf( lMdtMin, STR0063, IIf( lCipatr, STR0051, STR0021 ))+cPresCIPA+STR0022 //"A seguir, foi designado para Coordenador da CIPATR o Senhor " //"A seguir, foi designado para Presidente da CIPA o Senhor "###", tendo sido escolhido "
		cTxt01 += STR0023+cViceCIPA+ If(lCipatr,STR0053,STR0024) //" para Vice-Coordenador. " //"entre os Representantes eleitos dos Empregados o Senhor "###" para Vice-Presidente. "
		cTxt01 += STR0025 //"Os Representantes do Empregador e dos Empregados, em comum acordo, escolheram "
		cTxt01 += STR0026+cSecrCIPA+ IIf( lMdtMin, STR0064, IIf( lCipatr, STR0052, STR0027 )) //" para Secretário da CIPATR, sendo seu substituto o Senhor " //"também o Senhor "###" para Secretário da CIPA, sendo seu substituto o Senhor "
		cTxt01 += cSubsCIPA+If(lCipatr,STR0058,STR0028) //". Nada mais havendo para tratar, o Presidente da Sessão deu por encerrada a reunião, "
		cTxt01 += IIf( lMdtMin, STR0065, IIf( lCipatr, STR0054, STR0029 )) //"lembrando a todos que o período da gestão da CIPATR ora instalada será de 02 (dois) anos, " //"lembrando a todos que o período da gestão da CIPA ora instalada será de 01 (um) ano, "
		cTxt01 += STR0030 //"a contar da presente data. E, para constar, lavrou-se a presente Ata que, lida e "
		cTxt01 += If(lCipatr,STR0059,STR0031) //"aprovada, vai assinada por mim, Secretário, pelo Presidente da Sessão e por todos os "
		cTxt01 += STR0032 //"Representantes eleitos e/ou designados, inclusive os Suplentes."

		cMensagem   := cTxt01
		nLinhasMemo := MLCOUNT(cMensagem,80) * 45
		oPrint02:SayAlign(lin,300,cMensagem,oFont12, 1800 , nLinhasMemo, , 3, 0)

		Somalinha(nLinhasMemo + 200)

		oPrint02:Line(lin,300,lin,1000)
		oPrint02:Say(lin+50,300,If(lCipatr,STR0056,STR0033),oFont10) //"Presidente da Sessão"
		oPrint02:Line(lin,1400,lin,2100)
		oPrint02:Say(lin+50,1500,STR0034,oFont10) //"Secretário da Sessão"
		Somalinha(50)
		oPrint02:Say(lin+50,300,cPreSessao,oFont10) //Nome Presidente da Sessão
		oPrint02:Say(lin+50,1500,cSecSessao,oFont10) //Nome Secretário da Sessão

		Somalinha(10)

		nAteFor := If( Len(aTitFuncion)+Len(aTitEmpresa) > Len(aSupFuncion)+Len(aSupEmpresa) , ;
					Len(aTitFuncion)+Len(aTitEmpresa) , Len(aSupFuncion)+Len(aSupEmpresa) )

		//Ordenando pelo nome
		ASORT(aCipTit,,, { |x, y| x > y })
		ASORT(aCipSup,,, { |x, y| x > y })

		If !Empty(cSecrCIPA)
			aADD(aCipVer,{aCipTit,cSecrCIPA})
			aADD(aCipVer,{aCipSup,cSecrCIPA})
		EndIf
		If !Empty(cSubsCIPA)
			aADD(aCipVer,{aCipTit,cSubsCIPA})
			aADD(aCipVer,{aCipSup,cSubsCIPA})
		EndIf

		For nCon := 1 To Len(aCipVer)
			nCip := aSCAN(aCipVer[nCon,1],{|x| Alltrim(x) == Alltrim(aCipVer[nCon,2]) })
			If nCip > 0
				aDel( aCipVer[nCon,1],nCip)
				aSize( aCipVer[nCon,1], Len( aCipVer[nCon,1] )-1)
			EndIf
		Next nCon

		For nInd := 1 to nAteFor

			If ( lin + 250 )  > 3100 //Caso seja quebra de página
				Somalinha(250)
			Else
				Somalinha(200)
			EndIf

			oPrint02:Line(lin,300,lin,1000)
			oPrint02:Line(lin,1400,lin,2100)
			Somalinha(10)

			oPrint02:Say(lin+10,300,STR0045,oFont10)//"Titular"

			If Len(aCipTit) >= nInd
				oPrint02:Say(lin+50,300,aCipTit[ nInd ],oFont10)
			EndIf

			oPrint02:Say(lin+10,1500,STR0046,oFont10)//"Suplente"

			If Len(aCipSup) >= nInd
				oPrint02:Say(lin+50,1500,aCipSup[ nInd ],oFont10)
			EndIf

			If Len(aCipTit) <= nInd .And. Len(aCipSup) <= nInd
				Exit
			EndIf

		Next nInd

		If ( lin + 210 )  > 3100 //Caso seja quebra de página
			Somalinha(210)
		Else
			Somalinha(200)
		EndIf
		oPrint02:Line(lin,300,lin,1000)
		oPrint02:Line(lin,1400,lin,2100)
		oPrint02:Say(lin+50,300,STR0035,oFont10) //"Secretário"
		oPrint02:Say(lin+50,1500,STR0036,oFont10) //"Secretário Substituto"
		Somalinha(50)
		oPrint02:Say(lin+50,300,cSecrCIPA,oFont10) //"Nome Secretário"
		oPrint02:Say(lin+50,1500,cSubsCIPA,oFont10) //"Nome Secretário Substituto"

		oPrint02:EndPage()

		If lImpEmail
			oPrint02:Print()
			cDiretorio := oPrint02:cPathPDF

			If File(cDiretorio+cArquivo+".pdf")
				CpyT2S( cDiretorio+Lower(cArquivo)+".pdf" , "\SPOOL\", .F. , .F.)//Copia arquivo temporário para o Spool (SERVIDOR)
				cAnexo02 := "SPOOL" +"\"+ Lower(cArquivo)+".pdf;"
			Else
				cAnexo02 := .f.
			EndIf

		Else
			If mv_par02 == 1
				oPrint02:Preview()
			Else
				oPrint02:Print()
			EndIf
		Endif

	Endif

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
description
@type    function
@author  Denis Hyroshi de Souza
@since   09/10/2006
@sample  Somalinha(35,.T.)

@param _li, Numérico, Linha posicionada
@param _Tabela, Lógico, Verifica quebra de linha

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha(_li,_Tabela)

	If _li != nil
		lin += _li
	Else
		lin += 70
	Endif

	If lin > 2900
		oPrint02:EndPage()

		oPrint02:StartPage()

		lin := 200
		oPrint02:SayAlign(lin,300,STR0037,oFont12n, 1700, 100, , 2 , 0) //"ATA DE ELEIÇÃO DOS REPRESENTANTES DOS EMPREGADOS CIPA"
		lin := 400

		If _Tabela
			oPrint02:line(lin,300,lin,2200)
			Somalinha(70)
		Endif

	Endif

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR928SEC
Função que busca o secretário e secretário substituto do cadastro
do mandato CIPA. Se o cadastro for deferentes dos componentes cadastrados
como secretários nos componentes, ou estes etiverem vazios, ele utiliza
os do mandato.

@type    function
@author  Julia Kondlatsch
@since   19/10/2018
@sample  U_MDTR928SEC( @cSecrCIPA, @cSubsCIPA, '001' )

@param   cSecrCIPA, Caractere, Nome do secretário CIPA
@param   cSubsCIPA, Caractere, Nome do secretário substituto CIPA
@param   cCodMand, Caractere, Código do madato

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR928SEC( cSecrCIPA, cSubsCIPA, cCodMand )

	Local cSecrTNN := ''
	Local cSubsTNN := ''

	//Pega os secretários do mandato CIPA
	dbSelectArea( 'TNN' )
	dbSetOrder( 1 )
	If dbSeek( xFilial('TNN') + cCodMand )
		cSecrTNN := Alltrim( Posicione( "SRA", 1, xFilial( "SRA", TNN->TNN_FILRE1 ) + TNN->TNN_MATRE1, "RA_NOME" ) )
		cSubsTNN := Alltrim( Posicione( "SRA", 1, xFilial( "SRA", TNN->TNN_FILRE2 ) + TNN->TNN_MATRE2, "RA_NOME" ) )
	EndIf

	// Se não houver secretário cadastrado como componente da CIPA(TNQ) ou ele for diferente do cadastrado no mandato CIPA(TNN)
	If cSecrTNN <> cSecrCIPA .Or. Empty(cSecrCIPA)
		//Usa o secretário do mandato CIPA
		cSecrCIPA := cSecrTNN
	EndIf

	If cSubsTNN <> cSubsCIPA .Or. Empty(cSubsCIPA)
		//Usa o secretário substituto do mandato CIPA
		cSubsCIPA := cSubsTNN
	EndIf

Return Nil