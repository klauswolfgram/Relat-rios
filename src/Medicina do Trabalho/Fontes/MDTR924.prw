/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR924.ch"
#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR924
Edital de convocacao para eleicoes CIPA

@type    function

@author  Denis Hyroshi de Souza
@since   16/10/2006

@param   cCodMandato, Caracter, Código do Mandato a ser considerado
@param   cCliente, Caracter, Código do Cliente (Prestador de Serviço)
@param   cLoja, Caracter, Loja do Cliente (Prestador de Serviço)
@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDTR924(cCodMandato,cCliente,cLoja)
	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local aArea := GetArea()
	Local lCipatr   := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private lMdtMin  := If( SuperGetMv("MV_MDTMIN",.F.,"N") == "S", .t. , .f. )
	Private nomeprog := "MDTR924"
	Private titulo   := STR0001 //"Edital de Convocação para Eleições"
	Private cPerg    := "MDT924    "
	Private cAliasCC := "CTT"
	Private cFilCC   := "CTT->CTT_FILIAL"
	Private cCodCC   := "CTT->CTT_CUSTO"
	Private cDesCC   := "CTT->CTT_DESC01"

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cPerg    :=  If(!lSigaMdtPS,"MDT924    ","MDT924PS  ")

	If ExistBlock("MDTA111R")
		// Verifica se a rotina de eventos foi chamada
		aParam := {}
		aAdd(aParam, {"7-1"}) // Tipo do Evento
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

	If Alltrim(GETMV("MV_MCONTAB")) != "CTB"
		cAliasCC := "SI3"
		cFilCC   := "SI3->I3_FILIAL"
		cCodCC   := "SI3->I3_CUSTO"
		cDesCC   := "SI3->I3_DESC"
	Endif

	/*--------------------------
	//PADRÃO					|
	|  Mandato CIPA ?			|
	|  Local de Votacao ?		|
	|  Horario de votacao ?		|
	|  Tipo de Impressao ?		|
	|  							|
	//PRESTADOR					|
	|  Cliente ?				|
	|  Loja						|
	|  Mandato CIPA ?			|
	|  Local de Votacao ?		|
	|  Horario de votacao ?		|
	|  Tipo de Impressao ?		|
	----------------------------*/

	If Pergunte(cPerg,.t.)
		Processa({|lEND| MDTA924IMP()},STR0002) //"Imprimindo..."
	Endif

	RestArea(aArea)

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTA924IMP
Funcao de impressao

@type    function

@author  Denis Hyroshi de Souza
@since   09/10/2006

@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function MDTA924IMP()

	Local nInd1, nInd2

	Local nSizeSA1  := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nSizeLoj  := If((TAMSX3("A1_LOJA")[1]) < 1,6,(TAMSX3("A1_LOJA")[1]))
	Local lCipatr   := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	Private oPrint    := FwMsPrinter():New( OemToAnsi(titulo))
	Private oFont12n  := TFont():New("VERDANA",12,12,,.T.,,,,.F.,.F.)
	Private oFont12   := TFont():New("VERDANA",12,12,,.F.,,,,.F.,.F.)
	Private oFont10   := TFont():New("VERDANA",10,10,,.F.,,,,.F.,.F.)
	Private oFontCNEW := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
	Private l1st_page := .t. // Controla impressao da primeira pagina ou nao

	oPrint:SetLandscape() //paisagem

	aAreaCipa := {}

	If lMdtMin

		If lSigaMdtps

			dbSelectArea("TLJ")
			dbSetOrder(1)
			Set Filter To xFilial("TLJ") == TLJ->TLJ_FILIAL .AND.;
						mv_par03 == TLJ->TLJ_MANDAT .AND. mv_par01+mv_par02 == SubStr(TLJ->TLJ_CC,1,nSizeSA1+nSizeLoj) .AND.;
						!Empty(TLJ->TLJ_AREA) .AND.;
						TLJ->TLJ_AREA >= mv_par08 .AND. TLJ->TLJ_AREA <= mv_par09
			dbGoTop()

			While !eof()
				cDescCC  := NGSeek(cAliasCC, TLJ->TLJ_CC ,1,cDesCC)
				nPosCIPA := aScan( aAreaCipa, { |x| x[1] == TLJ->TLJ_AREA })

				If nPosCIPA == 0
					aAdd( aAreaCipa , {TLJ->TLJ_AREA ,{{TLJ->TLJ_CC,cDescCC}} , {} } )
				Else
					aAdd( aAreaCipa[nPosCIPA, 2] , {TLJ->TLJ_CC,cDescCC} )
				Endif

				dbSkip()
			End

			dbSelectArea("TNO")
			dbSetOrder(4)  //TNO_FILIAL+TNO_CLIENT+TNO_LOJA+TNO_MANDAT+TNO_MAT+DTOS(TNO_DTCAND)
			dbSeek(xFilial("TNO")+Mv_par01+mv_par02+mv_par03)
			While !Eof() .and. xFilial("TNO")+mv_par01+mv_par02+mv_par03 == TNO->TNO_FILIAL+TNO->TNO_CLIENT+TNO->TNO_LOJA+TNO->TNO_MANDAT

				cFil1Tmp := cFilAnt
				If !Empty(TNO->TNO_FILMAT)
					cFil1Tmp := TNO->TNO_FILMAT
				Endif

				dbSelectArea("SRA")
				dbSetOrder(1)
				If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
					cSetor   := SRA->RA_CC
					cAreaC   := NGSeek('TLJ', mv_par03 + cSetor ,1,'TLJ->TLJ_AREA')
					cFuncao_ := Substr(Posicione("SRJ",1,xFilial("SRJ")+SRA->RA_CODFUNC,"RJ_DESC"),1,34)
					nPosCIPA := aScan( aAreaCipa, { |x| x[1] == cAreaC })
					cDesCC1  := NGSeek(cAliasCC, SRA->RA_CC ,1,cDesCC)
					If nPosCIPA > 0
						aAdd( aAreaCipa[nPosCIPA, 3] , {TNO->TNO_MAT, SRA->RA_NOME, cFuncao_ ,cDesCC1 } )
					Endif
				Endif
				dbSelectArea("TNO")
				dbSkip()
			End

			dbSelectArea("TLJ")
			dbSetOrder(1)
			Set Filter To

		Else

			dbSelectArea("TLJ")
			dbSetOrder(1)
			dbSeek( xFilial("TLJ")+ mv_par01)
			While !eof() .and. xFilial("TLJ") == TLJ->TLJ_FILIAL .and. mv_par01 == TLJ->TLJ_MANDAT
				If Empty(TLJ->TLJ_AREA) .or. Empty(TLJ->TLJ_CC) .or.;
					TLJ->TLJ_AREA < mv_par06 .or. TLJ->TLJ_AREA > mv_par07

					dbSkip()
					Loop
				Endif

				cDescCC  := NGSeek(cAliasCC, TLJ->TLJ_CC ,1,cDesCC)
				nPosCIPA := aScan( aAreaCipa, { |x| x[1] == TLJ->TLJ_AREA })
				If nPosCIPA == 0
					aAdd( aAreaCipa , {TLJ->TLJ_AREA ,{{TLJ->TLJ_CC,cDescCC}} , {} } )
				Else
					aAdd( aAreaCipa[nPosCIPA, 2] , {TLJ->TLJ_CC,cDescCC} )
				Endif

				dbSkip()
			End

			dbSelectArea("TNO")
			dbSetOrder(1)
			dbSeek(xFilial("TNO")+mv_par01)
			While !Eof() .and. xFilial("TNO")+mv_par01 == TNO->TNO_FILIAL+TNO->TNO_MANDAT

				cFil1Tmp := cFilAnt
				If !Empty(TNO->TNO_FILMAT)
					cFil1Tmp := TNO->TNO_FILMAT
				Endif

				dbSelectArea("SRA")
				dbSetOrder(1)
				If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
					cSetor   := SRA->RA_CC
					cAreaC   := NGSeek('TLJ', mv_par01 + cSetor ,1,'TLJ->TLJ_AREA')
				cFuncao_ := Substr(Posicione("SRJ",1,xFilial("SRJ")+SRA->RA_CODFUNC,"RJ_DESC"),1,34)
					nPosCIPA := aScan( aAreaCipa, { |x| x[1] == cAreaC })
					cDesCC1  := NGSeek(cAliasCC, SRA->RA_CC ,1,cDesCC)
					If nPosCIPA > 0
						aAdd( aAreaCipa[nPosCIPA, 3] , {TNO->TNO_MAT, SRA->RA_NOME,cFuncao_ ,cDesCC1 } )
					Endif
				Endif
				dbSelectArea("TNO")
				dbSkip()
			End

		Endif

	Else

		If lSigaMdtps

			dbSelectArea("TNO")
			dbSetOrder(4)  //TNO_FILIAL+TNO_CLIENT+TNO_LOJA+TNO_MANDAT+TNO_MAT+DTOS(TNO_DTCAND)
			dbSeek(xFilial("TNO")+Mv_par01+mv_par02+mv_par03)
			While !Eof() .and. xFilial("TNO")+mv_par01+mv_par02+mv_par03 == TNO->TNO_FILIAL+TNO->TNO_CLIENT+TNO->TNO_LOJA+TNO->TNO_MANDAT

				cFil1Tmp := cFilAnt
				If !Empty(TNO->TNO_FILMAT)
					cFil1Tmp := TNO->TNO_FILMAT
				Endif

				dbSelectArea("SRA")
				dbSetOrder(1)
				If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
					cFuncao_ := Substr(Posicione("SRJ",1,xFilial("SRJ")+SRA->RA_CODFUNC,"RJ_DESC"),1,34)
					cDesCC1  := NGSeek(cAliasCC, SRA->RA_CC ,1,cDesCC)
					If Len(aAreaCipa) > 0
						aAdd( aAreaCipa[1, 3] , {TNO->TNO_MAT, SRA->RA_NOME, SubStr(cFuncao_,1,23), SubStr(cDesCC1,1,23) } )
					Else
						aAdd( aAreaCipa , { Space(9) , {} , {{TNO->TNO_MAT, SRA->RA_NOME,SubStr(cFuncao_,1,23) ,SubStr(cDesCC1,1,23) }} } )
					Endif
				Endif

				dbSelectArea("TNO")
				dbSkip()
			End

		Else

			dbSelectArea("TNO")
			dbSetOrder(1)
			dbSeek(xFilial("TNO")+Mv_par01)
			While !Eof() .and. xFilial("TNO")+mv_par01 == TNO->TNO_FILIAL+TNO->TNO_MANDAT

				cFil1Tmp := cFilAnt
				If !Empty(TNO->TNO_FILMAT)
					cFil1Tmp := TNO->TNO_FILMAT
				Endif

				dbSelectArea("SRA")
				dbSetOrder(1)
				If dbSeek(xFilial("SRA",cFil1Tmp)+TNO->TNO_MAT)
					cFuncao_ := Substr(Posicione("SRJ",1,xFilial("SRJ")+SRA->RA_CODFUNC,"RJ_DESC"),1,34)
					cDesCC1  := NGSeek(cAliasCC, SRA->RA_CC ,1,cDesCC)
					If Len(aAreaCipa) > 0
						aAdd( aAreaCipa[1, 3] , {TNO->TNO_MAT, SRA->RA_NOME,SubStr(cFuncao_,1,23) , SubStr(cDesCC1,1,23) } )
					Else
						aAdd( aAreaCipa , { Space(9) , {} , {{TNO->TNO_MAT, SRA->RA_NOME, SubStr(cFuncao_,1,23), SubStr(cDesCC1,1,23) }} } )
					Endif
				Endif

				dbSelectArea("TNO")
				dbSkip()
			End

		Endif

	Endif

	If lSigaMdtps

		dbSelectArea("TNN")
		dbSetOrder(3)
		dbSeek(xFilial("TNN")+mv_par01+mv_par02+mv_par03)

		For nInd1 := 1 to Len(aAreaCipa)
			Lin := 200
			oPrint:StartPage()

			// Localização do Logo da Empresa
			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)
			oPrint:Say(lin,1250,STR0003,oFont12n) //"EDITAL DE CONVOCAÇÃO DE ELEIÇÃO"

			If lMdtMin
				Lin += 100
				oPrint:Say(lin,300,STR0021+NGSeek(cAliasCC, aAreaCipa[nInd1,1] ,1,cDesCC),oFont12) //"Área: "
				aSort(aAreaCipa[nInd1,2],,,{|x,y| x[2] < y[2]  })

				For nInd2 := 1 to Len(aAreaCipa[nInd1,2])
					If nInd2 == 1
						Lin += 80
						oPrint:Say(lin,300,STR0022,oFont10) //"Centros de Custos:"
					Else
						Lin += 50
					Endif
					oPrint:Say(lin,650,"- "+aAreaCipa[nInd1,2,nInd2,2],oFont10)
				Next nInd2
				Lin -= 50
			Endif

			cTxt01 := If(lCipatr,STR0034,STR0004) //"Ficam convocados os empregados desta empresa para eleição dos membros da Comissão Interna de Prevenção de Acidentes - CIPA,"

			If mv_par07 == 1
				cTxt02 := If(lCipatr,STR0035,STR0005) //"de acordo com a Norma Regulamentadora - NR 5, aprovada pela Portaria nº 08, de 03 de fevereiro de 2002 baixada pelo "
			Else
				cTxt02 := If(lCipatr,STR0035,STR0032) //"de acordo com a Norma Regulamentadora - NR 5, aprovada pela Portaria nº 08, de 23 de fevereiro de 1999 baixada pelo "
			EndIf

			cTxt03 := STR0006 //"Ministério do Trabalho, a ser realizada, em escrutínio secreto, no dia"
			cTxt04 := DTOC(TNN->TNN_ELEICA) + STR0023 + Mv_par05 + STR0008+Alltrim(Mv_par04)+"." //" horas, no local " //" às "

			If lMdtMin
				cTxt01 := StrTran(cTxt01,'CIPA','CIPAMIN')
				cTxt02 := STR0033 //"de acordo com a Norma Regulamentadora - NR 22, aprovada pela Portaria nº 2.037, de 15 de dezembro de 1999 baixada pelo "
			Endif

			oPrint:SayAlign(lin+200,300,cTxt01 + cTxt02 + cTxt03 + cTxt04,oFont12, 1000, 230, , 3, 0 )

			lin += 500 //800

			oPrint:Say(lin,200,STR0009,oFont12) //"Apresentaram-se e serão votados os seguintes candidatos:"

			Somalinha(20)
			aSort(aAreaCipa[nInd1,3],,,{|x,y| x[2] < y[2]  })
			lFirst := .t.

			For nInd2 := 1 To Len(aAreaCipa[nInd1,3])

				If lFirst
					Somalinha(80)
					oPrint:Box(lin,200,lin+80,2050)
					oPrint:Box(lin,200,lin+80,2900)
					oPrint:Line(lin,1150,lin+80,1150)
					oPrint:Say(lin+15,660,STR0010,oFont12N) //"Nome"
					oPrint:Say(lin+15,1550,STR0011,oFont12N) //"Função"
					oPrint:Say(lin+15,2340,STR0007,oFont12N )//"Centro de Custo"
					lFirst := .f.
					Somalinha(10)
				Endif

				Somalinha(70)
				oPrint:Line(lin,200,lin+70,200)
				oPrint:Line(lin,2900,lin+70,2900)
				oPrint:Line(lin,2050,lin+70,2050)
				oPrint:Line(lin+70,200,lin+70,2900)
				oPrint:Line(lin,1150,lin+70,1150)
				oPrint:Line(lin,200,lin,2900)
				oPrint:Say(lin+15,210,Substr(aAreaCipa[nInd1,3,nInd2,2],1,34),oFont12)
				oPrint:Say(lin+15,1160,aAreaCipa[nInd1,3,nInd2,3],oFont12)
				oPrint:Say(lin+15,2060,Substr(aAreaCipa[nInd1,3,nInd2,4],1,27),oFont12)
			Next nInd2

			Somalinha(200)

			dbSelectArea("SA1")
			dbSetOrder(1)
			dbSeek(xFilial("SA1")+mv_par01+mv_par02)

			cCidade  := Alltrim(SA1->A1_MUN)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0024 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0024 //" de "
			cCidade  += Strzero(Year(dDataBase),4)
			If Len(cCidade) > 40
				oPrint:Say(lin+130,1250,cCidade,oFont10)
			Else
				oPrint:Say(lin+130,1250,cCidade,oFont12)
			Endif

			Somalinha(250)

			oPrint:Line(lin+160,1300,lin+160,1975)
			oPrint:Say(lin+170,1380,STR0012,oFont12) //"(Assinatura do Empregador)"

			oPrint:EndPage()
		Next nInd1

		If mv_par06 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Else

		dbSelectArea("TNN")
		dbSetOrder(1)
		dbSeek(xFilial("TNN")+mv_par01)

		For nInd1 := 1 to Len(aAreaCipa)
			Lin := 200
			oPrint:StartPage()

			// Localização do Logo da Empresa
			oPrint:SayBitMap(50,50,NGLocLogo(),250,50)


			Dbselectarea("SM0")
			oPrint:Say(lin,400,STR0026 + Substr(SM0->M0_NOMECOM,1,60),oFont12)//"Empresa/Filial: "
			oPrint:Say(lin+50,400,STR0027 + SM0->M0_CGC,oFont12)//"CNPJ: "
			lin += 200

			oPrint:SayAlign(lin,250,STR0003,oFont12n, 2400, 230, , 2, 0 ) //"EDITAL DE CONVOCAÇÃO DE ELEIÇÃO"

			If lMdtMin
				Lin += 100
				oPrint:Say(lin,200,STR0021+NGSeek(cAliasCC, aAreaCipa[nInd1,1] ,1,cDesCC),oFont12) //"Área: "
				aSort(aAreaCipa[nInd1,2],,,{|x,y| x[2] < y[2]  })

				For nInd2 := 1 to Len(aAreaCipa[nInd1,2])
					If nInd2 == 1
						Lin += 80
						oPrint:Say(lin,200,STR0022,oFont10) //"Centros de Custos:"
					Else
						Lin += 50
					Endif
					oPrint:Say(lin,650,"- "+aAreaCipa[nInd1,2,nInd2,2],oFont10)
				Next nInd2
				Lin -= 50
			Endif

			cTxt01 := If(lCipatr,STR0034,STR0004) //"Ficam convocados os empregados desta empresa para eleição dos membros da Comissão Interna de Prevenção de Acidentes - CIPA,"

			If mv_par05 == 1
				cTxt02 := If(lCipatr,STR0035,STR0005) //"de acordo com a Norma Regulamentadora - NR 5, aprovada pela Portaria nº 08, de 03 de fevereiro de 2002 baixada pelo "
			Else
				cTxt02 := If(lCipatr,STR0035,STR0032) //"de acordo com a Norma Regulamentadora - NR 5, aprovada pela Portaria nº 08, de 23 de fevereiro de 1999 baixada pelo "
			EndIf

			cTxt03 := STR0006 //"Ministério do Trabalho, a ser realizada, em escrutínio secreto, no dia"
			cTxt04 := DTOC(TNN->TNN_ELEICA) +STR0023+Mv_par03+STR0008+Alltrim(Mv_par02)+"." //" às "##" horas, no local "

			If lMdtMin
				cTxt01 := StrTran(cTxt01,'CIPA','CIPAMIN')
				cTxt02 := STR0033 //"de acordo com a Norma Regulamentadora - NR 22, aprovada pela Portaria nº 2.037, de 15 de dezembro de 1999 baixada pelo "
			Endif

			oPrint:SayAlign(lin+200,300,cTxt01 + cTxt02 + cTxt03 + cTxt04,oFont12, 2400, 230, , 3, 0 )

			lin += 500 //800

			oPrint:SayAlign(lin-40,300,STR0009,oFont12, 2400, 230, , 0, 0 ) //"Apresentaram-se e serão votados os seguintes candidatos:"

			Somalinha(20)
			aSort(aAreaCipa[nInd1,3],,,{|x,y| x[2] < y[2]  })
			lFirst := .t.

			For nInd2 := 1 To Len(aAreaCipa[nInd1,3])

				If !lFirst .AND. (nInd2 % 10) == 1
					oPrint:EndPage()
					oPrint:StartPage()
					lin := 500
					lFirst := .T.
				EndIf

				If lFirst
					Somalinha(80)
					oPrint:Box(lin,300,lin+80,1100)
					oPrint:Box(lin,1100,lin+80,1900)
					oPrint:Box(lin,1900,lin+80,2700)
					oPrint:SayAlign(lin+15,300,STR0010,oFont12N, 800, 50, , 2, 0 ) //"Nome"
					oPrint:SayAlign(lin+15,800,STR0011,oFont12N, 1400, 50, , 2, 0 ) //"Função"
					oPrint:SayAlign(lin+15,1300,STR0007,oFont12N , 2000, 50, , 2, 0 )//"Centro de Custo"
					lFirst := .f.
					Somalinha(10)
				Endif

				Somalinha(70)
				oPrint:Box(lin,300,lin+80,1100)
				oPrint:Box(lin,1100,lin+80,1900)
				oPrint:Box(lin,1900,lin+80,2700)
				oPrint:Say(lin+45,310,Substr(aAreaCipa[nInd1,3,nInd2,2],1,34),oFont12)
				oPrint:Say(lin+45,1110,aAreaCipa[nInd1,3,nInd2,3],oFont12)
				oPrint:Say(lin+45,1910,Substr(aAreaCipa[nInd1,3,nInd2,4],1,27),oFont12)
			Next nInd2

			Somalinha(50)

			cCidade  := Alltrim(SM0->M0_CIDCOB)
			cCidade  += ", "+Strzero(Day(dDataBase),2)+STR0024 //" de "
			cCidade  += UPPER(MesExtenso(dDataBase))+STR0024 //" de "
			cCidade  += Strzero(Year(dDataBase),4)

			If Len(cCidade) > 40
				oPrint:SayAlign(lin+50,300,cCidade,oFont10, 2400, 230, , 2, 0 )
			Else
				oPrint:SayAlign(lin+50,300,cCidade,oFont12, 2400, 230, , 2, 0 )
			Endif

			Somalinha(150)

			oPrint:Line(lin+160,1150,lin+160,1850)
			oPrint:SayAlign(lin+100,300,STR0012,oFont12, 2400, 230, , 2, 0 ) // "(Assinatura do Empregador)"

			oPrint:EndPage()
		Next nInd1

		If mv_par04 == 1
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf

	Endif

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Funcao de somar linha

@type    function

@author  Denis Hyroshi de Souza
@since   09/10/2006

@param   _li, Numérico, Posição da Linha a ser impresso
@return  Null, Sempre nulo
/*/
//-------------------------------------------------------------------
Static Function Somalinha(_li)

	If _li != nil
		lin += _li
	Else
		lin += 70
	Endif

	If lin > 2500
		oPrint:EndPage()

		oPrint:StartPage()
		// Localização do Logo da Empresa
		oPrint:SayBitMap(50,50,NGLocLogo(),250,50)

		lin := 200
		lin := 400
		Somalinha(80)

	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT924MAND
Funcao que valida mandato.

@type    function

@author  Rodrigo Soledade
@since   08/08/2013

@return  Lógico, Indica se o mandato é valido ou não
/*/
//-------------------------------------------------------------------
User Function MDT924MAND()

If lSigaMdtps
	If Empty(mv_par03)
		MsgStop(STR0025) //"O código do Mandato deve ser informado."
		Return .T.
	ElseIf !ExistCpo('TNN',mv_par01+mv_par02+mv_par03,3)
		Return .F.
	EndIf
EndIf

Return .T.