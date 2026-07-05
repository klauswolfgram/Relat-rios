/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "mdtr510.ch"
#include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR510
Impressao de Atestado Medico

@type    function
@author  Thiago Olis Machado
@since   14/04/2003
@sample  U_MDTR510()

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR510()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local oPrint
	Local i 	:= 1

	Private lObserva
	Private nTamCTT   := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	Private nTamFun   := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
	Private nXATEST   := 0 //Variavel de controle utilizada na impressão tReport

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .T. , .F. )

	cPerg := If(!lSigaMdtPS,"MDT510    ","MDT510PS  ")

	/*----------------------------------
	//PERGUNTAS PADRÃO					|
	| 01  De Ficha Medica ?				|
	| 02  Ate Ficha Medica ?			|
	| 03  De Data ?						|
	| 04  Ate Data ?					|
	| 05  De CID ?						|
	| 06  Ate CID ?						|
	| 07  De Centro de Custo ?			|
	| 08  Ate Centro de Custo ?			|
	| 09  De Funcao ?					|
	| 10  Ate Funcao ?					|
	| 11  Considerar Atest. ou Afast.	|
	-----------------------------------*/

	If !MDTRESTRI(cPrograma)
		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf

	DbSelectArea("TNY")
	lObserva := .T.

	Private oFont12	 := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
	Private oFont14B  := TFont():New("Arial",10,10,,.F.,,,,.F.,.F.)
	Private oFont16B  := TFont():New("Arial",12,12,,.F.,,,,.F.,.F.)
	Private oFont12T  := TFont():New("Times New Roman",10,10,,.F.,,,,.T.,.F.)
	Private oFont12I  := TFont():New("Times New Roman",10,10,,.T.,,.T.,,.T.,.F.)

	If FindFunction("TRepInUse") .And. TRepInUse()

		// Interface de impressao
		oReport := ReportDef()
		oReport:lDisableOrientation := .T.// Trava o modo de impressão como paisagem
		oReport:SetLandscape() // Modo paisagem
		oReport:HideParamPage() // Retira pagina de Parâmetros da impressão.
		oReport:nLeftMargin := 3 // Margem do lado esquerdo
		oReport:PrintDialog()

	Else

		oPrint := TMSPrinter():New( OemToAnsi( STR0001 ) ) //"Atestado Medico"
		oPrint:SetLandScape() //Paisagem
		oPrint:Setup()

		If !Pergunte(cPerg,.T.)
			Return Nil
		EndIf

		aAtestado := U_MDTR510DADOS()

		If Len( aAtestado ) = 0
			oPrint:Preview()
			Return
		EndIf

		U_MDTR510REL( oPrint,@i,1 )
		oPrint:Preview()

	EndIf
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR510REL
Montagem do Relatorio

@type    function
@author  Thiago Olis Machado
@since   15/04/2003
@sample  U_MDTR510REL( oPrint )

@param   oPrint, Objeto, Características do relatório

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR510REL( oPrint,i,g )

	Local x
	Local z
	Local t           := 1
	Local cCliente    := ""
	Local cSMCOD      := FWGrpCompany()
	Local cSMFIL      := FWCodFil()
	Local nInd        := 0
	Local nLinhasMemo := 0
	Local LinA        := 0
	Local LinN        := 0

	Private lin       := 0

	If lSigaMdtps

		ASORT(aAtestado,,,{|x,y| x[1]+x[2]+x[5] < y[1]+y[2]+y[5] })

		While t <= Len(aAtestado)

			oPrint:StartPage()

			oPrint:Cmtr2Pix(130,080)//linha,coluna
			oPrint:Cmtr2Pix(500,150)//largura,altura
			oPrint:SayBitmap(130,080,"LGRL"+cSMCOD+cSMFIL+".BMP" ,500,130 )//objeto,constante,linha,coluna,caminho,

			oPrint:Say(  130	, 860 	, STR0008 		 , oFont12I ) //"PROGRAMA DE CONTROLE MEDICO DE SAUDE OCUPACIONAL"
			oPrint:Line( 200	, 840 	, 200 			 , 3220     )
			oPrint:Say(  220	, 860 	, STR0032 		 , oFont12I ) //"COMUNICACAO  INTERNA  DE  ATESTADOS  POR  FALTA  AO  TRABALHO"
			oPrint:Line( 110	, 2560  , 280 			 , 2560     )
			oPrint:Say(  140	, 2580  , STR0010 		 , oFont14B ) //"Unidade:"
			oPrint:Say(  140	, 2790  , SM0->M0_NOME 	 , oFont14B )
			oPrint:Say(  220	, 2580  , STR0011 		 , oFont14B ) //"Data:"
			oPrint:Say(  220	, 2726  , DtoC( Date() ) , oFont14B )

			oPrint:Line( 280 , 080 , 280 , 3220 )
			oPrint:Line( 281 , 080 , 281 , 3220 )
			oPrint:Line( 282 , 080 , 282 , 3220 )

			oPrint:Say( 295 , 150  , STR0012 , oFont12T )	//"R. G."
			oPrint:Say( 295 , 350  , STR0018 , oFont12T )	//"MATRICULA"
			oPrint:Say( 295 , 760  , STR0013 , oFont12T )	//"NOME"
			oPrint:Say( 295 , 1110 , STR0045 , oFont12T )	//"CENTRO DE CUSTO"
			oPrint:Say( 295 , 1600 , STR0046 , oFont12T )	//"PERIODO DE AFAST."
			oPrint:Say( 295 , 2000 , STR0048 , oFont12T )	//"DIAS PERD."
			oPrint:Say( 295 , 2230 , STR0047 , oFont12T )	//"HORAS PERD."
			oPrint:Say( 295 , 2490 , STR0015 , oFont12T )	//"OBSERVACOES"

			oPrint:Line( 350 , 080 , 350 , 3220 ) //horizontal

			oPrint:Line( 285 , 310  , 2239 , 310  ) //vertical
			oPrint:Line( 285 , 565  , 2239 , 565  ) //vertical
			oPrint:Line( 285 , 1055 , 2239 , 1055 ) //vertical
			oPrint:Line( 285 , 1520 , 2239 , 1520 ) //vertical
			oPrint:Line( 285 , 1990 , 2239 , 1990 ) //vertical
			oPrint:Line( 285 , 2210 , 2239 , 2250 ) //vertical
			oPrint:Line( 285 , 2470 , 2239 , 2470 ) //vertical

			// rodape
			oPrint:Line( 2239 , 080 , 2239 , 3220 ) //horizontal
			oPrint:Line( 2240 , 080 , 2240 , 3220 ) //horizontal

			oPrint:Say( 2288 , 800 , "____/____/____   " + Replicate("_",26) , oFont16B )
			oPrint:Say( 2288 , 1950 , "____/____/____   " + Replicate("_",35) , oFont16B )

			oPrint:Say( 2340 , 1340 , STR0016 ,oFont12 ) //"MEDICO"
			oPrint:Say( 2340 , 2480 , STR0017 ,oFont12 ) //"RESPONSÁVEL DE SAÚDE"

			oPrint:Line( 2388 , 080 , 2388 , 3220 ) //horizontal
			oPrint:Line( 2389 , 080 , 2389 , 3220 ) //horizontal
			oPrint:Line( 2390 , 080 , 2390 , 3220 ) //horizontal

			lin := 420
			cCliente := aAtestado[t,1]+aAtestado[t,2]

			For x := g To Len( aAtestado )

				LinA:= 0 //Zera varial de linha

				If cCliente <> aAtestado[x,1]+aAtestado[x,2]
					exit
				Endif

				oPrint:Say( lin-60 , 090  ,Transform( aAtestado[ x , 3 ] , "@R 9.999.999/9" ) , oFont12 ) //RG
				oPrint:Say( Lin-60 , 380  ,Transform( aAtestado[ x , 4 ] , "@R 999999" ) , oFont12 ) //Matrícula

				//Quebra nome do Funcionário
				nLinhasMemo := MLCOUNT(Alltrim( aAtestado[ x , 3 ]),20)//Utilização do quebra linha
				For nInd := 1 to nLinhasMemo
					oPrint:Say( Lin-60 , 590 ,MemoLine( aAtestado[ x , 3 ] , 20, nInd ) , oFont12 ) //Nome Funcionário
					If nInd <> nLinhasMemo
						Lin += 40
						LinN += 40
					EndIf
				Next nInd

				If nLinhasMemo > 1 //Caso a quebra de linhas seja maior que 1
					Lin -= LinN //Retira valor adicionado pela quebra
				Endif

				nLinhasMemo := MLCOUNT(Alltrim( aAtestado[ x , 9 ]),20)//Quebra linha
				For nInd := 1 to nLinhasMemo
					oPrint:Say( Lin-60 , 1070 ,MemoLine( aAtestado[ x , 9 ] , 20, nInd ) , oFont12 ) //Centro de Custo
					If nInd <> nLinhasMemo
						lin += 40
						LinA += 40
					EndIf
				Next nInd

				If nLinhasMemo > 1 //Caso a quebra de linhas seja maior que 1
					Lin -= LinA //Retira valor adicionado pela quebra
				Endif

				oPrint:Say( Lin-60 , 1560 ,DtoC( aAtestado[ x , 6 ] ) + " a " + DtoC( aAtestado[ x , 7 ] ) , oFont12 ) //Data de afastamento
				oPrint:Say( Lin-60 , 2060 ,Transform( aAtestado[ x , 10 ] , "@R 99999" ) , oFont12 ) //Dias Perdidos
				oPrint:Say( Lin-60 , 2280 ,Transform( aAtestado[ x , 11 ] , "99:99" )  , oFont12 ) //Horas Perdidas

				If lObserva//Verifica se será impressão observação
					nLinhasMemo := MLCOUNT(Alltrim(aAtestado[ x , 8 ]),28)//Quebra linha
					For nInd := 1 to nLinhasMemo
						oPrint:Say( Lin-60 , 2490 , (MemoLine( aAtestado[ x , 8 ] , 30 , nInd )) , oFont12 )//Observação
						If nInd <> nLinhasMemo
							lin += 40
						EndIf
					Next nInd
				EndIf

				If Lin < (Lin + If( LinA > LinN , LinA , LinN ) ) //Caso a linha posicionada seja menor que a utilizada no centro de custo.
					Lin += If( LinA > LinN , LinA , LinN )
				Endif

				If Lin < 2109
					oPrint:Line( lin , 080 , lin , 3220 ) //horizontal
				EndIf

				If Lin > 2109
					I++
					oPrint:EndPage()
					If U_MDTR510REL(oPrint,@i,x)
						Return .T.
					EndIf
					Lin := 100
				EndIf
				Lin += 70
			Next x

			t := x

			If Len( aAtestado ) > 25
				yLinhas := Round((( 2119-Lin )/70),0)+2
			Else
				yLinhas := Lin
			EndIf

			For z := 1 to yLinhas
				If lin > 2200
					Exit
				EndIf
				oPrint:Line(lin,080,lin,3220) //horizontal
				Lin += 70
			Next z

			oPrint:EndPage()
			lin := 100

		End

	Else

		oPrint:StartPage()

		oPrint:Cmtr2Pix(  130 , 080 ) //linha,coluna
		oPrint:Cmtr2Pix(  500 , 150 ) //largura,altura
		oPrint:SayBitmap( 130 , 080 , "LGRL" + cSMCOD + cSMFIL + ".BMP" , 500 , 130 )//objeto,constante,linha,coluna,caminho,

		oPrint:Say(  130	, 860 	, STR0008 		, oFont12I ) //"PROGRAMA DE CONTROLE MEDICO DE SAUDE OCUPACIONAL"
		oPrint:Line( 200	, 840 	, 200 			, 3220     )
		oPrint:Say(  220	, 860 	, STR0032 		, oFont12I ) //"COMUNICACAO  INTERNA  DE  ATESTADOS  POR  FALTA  AO  TRABALHO"
		oPrint:Line( 110	, 2560 , 280 			, 2560     )
		oPrint:Say(  140	, 2580 , STR0010 		, oFont14B ) //"Unidade:"
		oPrint:Say(  140	, 2790 , SM0->M0_NOME 	, oFont14B )
		oPrint:Say(  220	, 2580 , STR0011 		, oFont14B ) //"Data:"
		oPrint:Say(  220	, 2726 , DtoC( Date() )	, oFont14B )

		oPrint:Line( 280 , 080 , 280 , 3220 )
		oPrint:Line( 281 , 080 , 281 , 3220 )
		oPrint:Line( 282 , 080 , 282 , 3220 )

		oPrint:Say( 295 , 150  , STR0012 , oFont12T )	//"R. G."
		oPrint:Say( 295 , 330  , STR0018 , oFont12T )	//"MATRICULA"
		oPrint:Say( 295 , 760  , STR0013 , oFont12T )	//"NOME"
		oPrint:Say( 295 , 1110 , STR0045 , oFont12T )	//"CENTRO DE CUSTO"
		oPrint:Say( 295 , 1600 , STR0046 , oFont12T )	//"PERIODO DE AFAST."
		oPrint:Say( 295 , 2000 , STR0048 , oFont12T )	//"DIAS PERD."
		oPrint:Say( 295 , 2230 , STR0047 , oFont12T )	//"HORAS PERD."
		oPrint:Say( 295 , 2490 , STR0015 , oFont12T )	//"OBSERVACOES"

		oPrint:Line( 350 , 080 , 350 , 3220 ) //horizontal

		oPrint:Line( 285 , 310  , 2239 , 310  ) //vertical
		oPrint:Line( 285 , 565  , 2239 , 565  ) //vertical
		oPrint:Line( 285 , 1055 , 2239 , 1055 ) //vertical
		oPrint:Line( 285 , 1520 , 2239 , 1520 ) //vertical
		oPrint:Line( 285 , 1990 , 2239 , 1990 ) //vertical
		oPrint:Line( 285 , 2210 , 2239 , 2210 ) //vertical
		oPrint:Line( 285 , 2470 , 2239 , 2470 ) //vertical

		// rodape
		oPrint:Line( 2239 , 080 , 2239 , 3220 ) //horizontal
		oPrint:Line( 2240 , 080 , 2240 , 3220 ) //horizontal

		oPrint:Say( 2288 , 800 , "____/____/____   " + Replicate("_",26) , oFont16B )
		oPrint:Say( 2288 , 1950 , "____/____/____   " + Replicate("_",35) , oFont16B )

		oPrint:Say( 2340 , 1340 , STR0016 ,oFont12) //"MEDICO"
		oPrint:Say( 2340 , 2480 , STR0017 ,oFont12 ) //"RESPONSÁVEL DE SAÚDE"

		oPrint:Line( 2388 , 080 , 2388 , 3220 ) //horizontal
		oPrint:Line( 2389 , 080 , 2389 , 3220 ) //horizontal
		oPrint:Line( 2390 , 080 , 2390 , 3220 ) //horizontal

		lin := 420
		For x := g To Len( aAtestado )

			LinA:= 0 //Zera varial de linha
			LinN:= 0 //Zera varial de linha

			oPrint:Say( lin-60 , 090  ,Transform( aAtestado[ x , 1 ] , "@R 9.999.999/9" ) , oFont12 ) //RG
			oPrint:Say( Lin-60 , 380  ,Transform( aAtestado[ x , 2 ] , "@R 999999" ) , oFont12 ) //Matrícula

			//Quebra nome do Funcionário
			nLinhasMemo := MLCOUNT(Alltrim( aAtestado[ x , 3 ]),20)//Utilização do quebra linha
			For nInd := 1 to nLinhasMemo
				oPrint:Say( Lin-60 , 590 ,MemoLine( aAtestado[ x , 3 ] , 20, nInd ) , oFont12 ) //Nome Funcionário
				If nInd <> nLinhasMemo
					Lin += 40
					LinN += 40
				EndIf
			Next nInd

			If nLinhasMemo > 1 //Caso a quebra de linhas seja maior que 1
				Lin -= LinN //Retira valor adicionado pela quebra
			Endif

			//Quebra Centro de Custo
			nLinhasMemo := MLCOUNT(Alltrim( aAtestado[ x , 7 ]),20)//Utilização do quebra linha
			For nInd := 1 to nLinhasMemo
				oPrint:Say( Lin-60 , 1070 ,MemoLine( aAtestado[ x , 7 ] , 20, nInd ) , oFont12 ) //Centro de Custo
				If nInd <> nLinhasMemo
					Lin += 40
					LinA += 40
				EndIf
			Next nInd

			If nLinhasMemo > 1 //Caso a quebra de linhas seja maior que 1
				Lin -= LinA //Retira valor adicionado pela quebra
			Endif

			oPrint:Say( Lin-60 , 1560 ,DtoC( aAtestado[ x , 4 ] ) + " a " + DtoC( aAtestado[ x , 5 ] ) , oFont12 ) //Data de afastamento
			oPrint:Say( Lin-60 , 2060 ,Transform( aAtestado[ x , 8 ] , "@R 99999" ) , oFont12 ) //Dias Perdidos
			oPrint:Say( Lin-60 , 2280 ,Transform( aAtestado[ x , 9 ] , "99:99" )  , oFont12 ) //Horas Perdidas

			If lObserva//Verifica se existe observação.
				nLinhasMemo := MLCOUNT(Alltrim(aAtestado[ x , 6 ]),28)//Quebra linha
				For nInd := 1 to nLinhasMemo
					oPrint:Say( Lin-60 , 2490 , (MemoLine( aAtestado[ x , 6 ] , 30 , nInd )) , oFont12 )//Observação
					If nInd <> nLinhasMemo
						lin += 40
					EndIf
				Next nInd
			EndIf

			If Lin < (Lin + If( LinA > LinN , LinA , LinN ) ) //Caso a linha posicionada seja menor que a utilizada no centro de custo.
				Lin += If( LinA > LinN , LinA , LinN )
			Endif

			If Lin < 2109
				oPrint:Line( lin , 080 , lin , 3220 ) //horizontal
			EndIf

			If Lin > 2109
				I++
				oPrint:EndPage()
				If U_MDTR510REL(oPrint,@i,x)
					Return .T.
				EndIf
				Lin := 100
			EndIf
			Lin += 70
		Next x

		If Len( aAtestado ) > 25
			yLinhas := Round((( 2119-Lin )/70),0)+2
		Else
			yLinhas := Lin
		EndIf

		For z := 1 to yLinhas
			if lin > 2200
				Exit
			EndIf
			oPrint:Line(lin,080,lin,3220) //horizontal

			Lin += 70
		Next z

		oPrint:EndPage()
		lin := 100

	Endif

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR510DADOS
Busca de Dados para Impressao.

@type    function
@author  Thiago Olis Machado
@since   15/04/2003
@sample  U_MDTR510DADOS()

@return  aAtestado, Array, Contem registros de afastamentos a serem
impressos
/*/
//-------------------------------------------------------------------
User Function MDTR510DADOS()

	Local aAtestado   := {}
	Local cAtest2     := "!Empty(TNY->TNY_DTSAI2) .Or. !Empty(TNY->TNY_DTALT2)" //Verifica se tem um segundo afastamento
	Local cAtest3     := "!Empty(TNY->TNY_DTSAI3) .Or. !Empty(TNY->TNY_DTALT3)" //Verifica se tem um terceiro afastamento
	Local lAfast1     := .F. //Veriavel que determina a impressão do afastamento 1
	Local lAfast2     := .F. //Veriavel que determina a impressão do afastamento 2
	Local lAfast3     := .F. //Veriavel que determina a impressão do afastamento 3
	Local cHoraIni    := "00:01"
	Local cHoraFim    := "23:59"
	Local aHoras      := {}
	Local aTemporario := {}
	Local aTYZImp     := {}
	Local nQtdDias    := 0
	Local n           := 0
	Local cHrsPerd    := '00:00'

	If lSigaMdtps

		DbSelectArea("TNY")
		DbSetOrder(1)
		DbSeek(xFilial("TNY")+mv_par05,.T.)

		Do While !Eof() .And. xFilial("TNY") == TNY->TNY_FILIAL .And.;
									TNY->TNY_NUMFIC <= mv_par06

			If TNY->TNY_CID < mv_par09 .Or. TNY->TNY_CID > mv_par10
				DbSelectArea("TNY")
				DbSkip()
				Loop
			EndIf

			If Mv_par15 == 1 //Data do Atestado
				If TNY->TNY_DTINIC < mv_par07 .Or. TNY->TNY_DTINIC > mv_par08
					DbSelectArea("TNY")
					DbSkip()
					Loop
				EndIf
			Else
				If (TNY->TNY_DTSAID >= Mv_par07 .And. TNY->TNY_DTSAID <= Mv_par08) .Or. (TNY->TNY_DTALTA >= Mv_par07 .And. TNY->TNY_DTALTA <= mv_par08)//Verifica se  data do 1º afastamento esta dentro dos parametros
					lAfast1:=.T.
				Endif
				If (TNY->TNY_DTSAI2 >= Mv_par07 .And. TNY->TNY_DTSAI2 <= Mv_par08) .Or. (TNY->TNY_DTALT2 >= Mv_par07 .And. TNY->TNY_DTALT2 <= mv_par08)//Verifica se  data do 2º afastamento esta dentro dos parametros
					lAfast2:=.T.
				Endif
				If (TNY->TNY_DTSAI3 >= Mv_par07 .And. TNY->TNY_DTSAI3 <= Mv_par08) .Or. (TNY->TNY_DTALT3 >= Mv_par07 .And. TNY->TNY_DTALT3 <= mv_par08)//Verifica se  data do 3º afastamento esta dentro dos parametros
					lAfast3:=.T.
				Endif
				If !lAfast1 .And. !lAfast2 .And. !lAfast3//Caso as 3 datas estiverem fora dos parametros pula registro
					DbSelectArea("TNY")
					DbSkip()
					Loop
				Endif
			Endif

			DbSelectArea("TM0")
			DbSetOrder(1)
			If DbSeek(xFilial("TM0")+TNY->TNY_NUMFIC)

				If TM0->TM0_CLIENT+TM0->TM0_LOJA < mv_par01+mv_par02 .Or. TM0->TM0_CLIENT+TM0->TM0_LOJA > mv_par03+mv_par04
					DbSelectArea("TNY")
					DbSkip()
					Loop
				Endif
				DbSelectArea("SRA")
				DbSetOrder(1)
				If DbSeek(xFilial("SRA")+TM0->TM0_MAT)
					If ( SRA->RA_CC >= MV_PAR11 .And. SRA->RA_CC <= MV_PAR12 ) .And. ( SRA->RA_CODFUNC >= MV_PAR13 .And. SRA->RA_CODFUNC <= MV_PAR14 )

						If Mv_par15 == 1
							cHoraIni:=  TNY->TNY_HRINIC
							cHoraFim:= If( Empty( TNY->TNY_HRFIM ) , "00:00" , TNY->TNY_HRFIM )
							aTemporario := MdtTurnoSPJ( TNY->TNY_DTINIC , TNY->TNY_DTFIM , cHoraIni , cHoraFim )
							aHoras:= If(aTemporario[1] , aClone(aTemporario) , { "" , "00:00" , If(Empty(TNY->TNY_DTFIM), (dDataBase - TNY->TNY_DTINIC) , (TNY->TNY_DTFIM - TNY->TNY_DTINIC))+1 } )
							Aadd( aAtestado,{TM0->TM0_CLIENT,TM0->TM0_LOJA,SRA->RA_RG,SRA->RA_MAT,SRA->RA_NOME,TNY->TNY_DTINIC,TNY->TNY_DTFIM,If(lObserva, TNY->TNY_OBSERV,),,NGSEEK("CTT",SRA->RA_CC,1,"CTT_DESC01"),aHoras[3],If( aHoras[ 2 ] == "  :  " , "00:00" , aHoras[ 2 ] ), TNY->TNY_GRPCID, TNY->TNY_CID })//Data do Atestado
						Else
							If lAfast1
								aTemporario := MdtTurnoSPJ( TNY->TNY_DTSAID , TNY->TNY_DTALTA ,  cHoraIni , cHoraFim )
								aHoras:= If(aTemporario[1] , aClone(aTemporario) , { "" , "00:00" , If(Empty(TNY->TNY_DTALTA), (dDataBase - TNY->TNY_DTSAID) , (TNY->TNY_DTALTA - TNY->TNY_DTSAID))+1 } )
								Aadd( aAtestado,{TM0->TM0_CLIENT,TM0->TM0_LOJA,SRA->RA_RG,SRA->RA_MAT,SRA->RA_NOME,TNY->TNY_DTSAID,TNY->TNY_DTALTA,If(lObserva, TNY->TNY_OBSERV,),NGSEEK("CTT",SRA->RA_CC,1,"CTT_DESC01"),aHoras[3], If( aHoras[ 2 ] == "  :  " , "00:00" , aHoras[ 2 ] ), TNY->TNY_GRPCID, TNY->TNY_CID })//Primeiro Afastamento
							Endif
							If &(cAtest2) .And. lAfast2 //Verifica se existe o segundo afastamento
								aTemporario := MdtTurnoSPJ( TNY->TNY_DTSAI2 , TNY->TNY_DTALT2 ,  cHoraIni , cHoraFim )
								aHoras:= If(aTemporario[1] , aClone(aTemporario) , { "" , "00:00" , If(Empty(TNY->TNY_DTALT2), (dDataBase - TNY->TNY_DTSAI2) , (TNY->TNY_DTALT2 - TNY->TNY_DTSAI2))+1 } )
								Aadd( aAtestado,{TM0->TM0_CLIENT,TM0->TM0_LOJA,SRA->RA_RG,SRA->RA_MAT,SRA->RA_NOME,TNY->TNY_DTSAI2,TNY->TNY_DTALT2,If(lObserva, TNY->TNY_OBSERV,),NGSEEK("CTT",SRA->RA_CC,1,"CTT_DESC01"),aHoras[3], If( aHoras[ 2 ] == "  :  " , "00:00" , aHoras[ 2 ] ), TNY->TNY_GRPCID, TNY->TNY_CID })//Segundo Afastamento
							Endif
							If &(cAtest3) .And. lAfast3 //Verifica se existe um teceiro afastamento
								aTemporario := MdtTurnoSPJ( TNY->TNY_DTSAI3 , TNY->TNY_DTALT3 ,  cHoraIni , cHoraFim )
								aHoras:= If(aTemporario[1] , aClone(aTemporario) , { "" , "00:00" , If(Empty(TNY->TNY_DTALT3), (dDataBase - TNY->TNY_DTSAI3) , (TNY->TNY_DTALT3 - TNY->TNY_DTSAI3))+1 } )
								Aadd( aAtestado,{TM0->TM0_CLIENT,TM0->TM0_LOJA,SRA->RA_RG,SRA->RA_MAT,SRA->RA_NOME,TNY->TNY_DTSAI3,TNY->TNY_DTALT3,If(lObserva, TNY->TNY_OBSERV,),NGSEEK("CTT",SRA->RA_CC,1,"CTT_DESC01"),aHoras[3], If( aHoras[ 2 ] == "  :  " , "00:00" , aHoras[ 2 ] ), TNY->TNY_GRPCID, TNY->TNY_CID })//Terceiro Afastamento
							Endif
						Endif

					EndIf
				EndIf
			EndIf

			//Devolve valor inicial as variáveis.
			lAfast1 := .F.
			lAfast2 := .F.
			lAfast3 := .F.

			DbSelectArea("TNY")
			DbSkip()
		EndDo

	Else

		dbSelectArea("TNY")
		dbSetOrder(1)
		dbSeek(xFilial("TNY") + mv_par01,.T.)

		Do While !Eof() .And. xFilial("TNY") == TNY->TNY_FILIAL .And. TNY->TNY_NUMFIC <= mv_par02

			If TNY->TNY_CID < mv_par05 .Or. TNY->TNY_CID > mv_par06
				dbSelectArea("TNY")
				dbSkip()
				Loop
			EndIf

			dbSelectArea("TM0")
			dbSetOrder(1)

			If dbSeek(xFilial("TM0") + TNY->TNY_NUMFIC)

				dbSelectArea("SRA")
				dbSetOrder(1)

				If dbSeek(xFilial("SRA" ) + TM0->TM0_MAT)

					If ( SRA->RA_CC >= MV_PAR07 .And. SRA->RA_CC <= MV_PAR08 ) .And. ( SRA->RA_CODFUNC >= MV_PAR09 .And. SRA->RA_CODFUNC <= MV_PAR10 )

						// Verifica se considerará a data do Atestado ou do Afastamento
						If Mv_par11 == 2

							If AliasInDic("TYZ")

								dbSelectArea( "TYZ" )
								dbSetOrder( 2 ) // TYZ_FILIAL + TYZ_NATEST + DTOS(TYZ_DTSAID) + DTOS(TYZ_DTALTA)
								dbSeek( xFilial("TYZ") + TNY->TNY_NATEST )

								While !Eof() .And. xFilial("TYZ") == TYZ->TYZ_FILIAL .And. TNY->TNY_NATEST == TYZ->TYZ_NATEST
									aAdd( aTYZImp, { TYZ->TYZ_DTSAID, TYZ->TYZ_DTALTA } )
									TYZ->( dbSkip() )
								End

								If Len(aTYZImp) > 0

									For n := 1 to Len(aTYZImp)
										nQtdDias += MDTA685CLC( aTYZImp[n, 1], aTYZImp[n, 2], Alltrim(TNY->TNY_HRINIC), Alltrim(TNY->TNY_HRFIM), TNY->TNY_NUMFIC, n, Len(aTYZImp), @cHrsPerd )
									Next

									Aadd( aAtestado, { SRA->RA_RG, SRA->RA_MAT, SRA->RA_NOME, aTYZImp[1, 1], aTYZImp[ Len(aTYZImp), 2], If( lObserva, TNY->TNY_OBSERV, ), ;
										NGSEEK( "CTT", SRA->RA_CC, 1, "CTT_DESC01" ), nQtdDias, cHrsPerd, TNY->TNY_GRPCID, TNY->TNY_CID } ) // Data do Afastamento

								EndIf

							EndIf

						EndIf

						If Mv_par11 == 1 .Or. ( Mv_par11 == 2 .And. Len(aTYZImp) == 0 ) // Se for considerar afastamento porém não existir fará como se fosse atestado

							If TNY->TNY_DTINIC < Mv_par03 .Or. TNY->TNY_DTINIC > Mv_par04
								dbSelectArea("TNY")
								dbSkip()
								Loop
							EndIf

							nQtdDias := MDTA685CLC( TNY->TNY_DTINIC, TNY->TNY_DTFIM, Alltrim(TNY->TNY_HRINIC), Alltrim(TNY->TNY_HRFIM), TNY->TNY_NUMFIC, , , @cHrsPerd)
							aAdd( aAtestado, { SRA->RA_RG, SRA->RA_MAT, SRA->RA_NOME, TNY->TNY_DTINIC, TNY->TNY_DTFIM, If( lObserva, TNY->TNY_OBSERV, ), ;
							      NGSEEK( "CTT", SRA->RA_CC, 1, "CTT_DESC01" ), nQtdDias, cHrsPerd, TNY->TNY_GRPCID, TNY->TNY_CID } )//Data do Atestado
						Endif

					EndIf
				EndIf
			EndIf

			//Devolve valor inicial as variáveis.
			nQtdDias := 0
			aTYZImp  := {}
			lAfast1  := .F.
			lAfast2  := .F.
			lAfast3  := .F.

			dbSelectArea("TNY")
			dbSkip()
		EndDo

	Endif

Return aAtestado

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Função que trás as perguntas (SX1) no modo Personalizado e monta as
Section

@sample ReportDef()
@author Guilherme Freudenburg
@since  13/08/2014

@return oReport, Objeto
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3

	Local aAtestado := {}

	//- Criacao do componente de impressao
	// TReport():New
	// ExpC1 : Nome do relatorio
	// ExpC2 : Titulo
	// ExpC3 : Pergunte
	// ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao
	// ExpC5 : Descricao

	oReport := TReport():New("MDTR510",,cPerg,{|oReport| ReportPrint(oReport,oSection1,oSection2,oSection3,aAtestado)})  //"Funcionários Afastados"

		//Seção para impressão do título
		oSection1 := TRSection():New(oReport,STR0008 ,{" "} )//"Ocorrencias na Geracao da Programacao de Exames"
		oSection1:nLeftMargin := 3

		//Seção para impresão do relatório.
		oSection2 := TRSection():New( oReport , STR0008 ,{" "} )//"Ocorrencias na Geracao da Programacao de Exames"
		TRCell():New( oSection2, "ATESTADO_RG"		, " " , STR0012, "@R 9.999.999/9" , 25, .T., {|| Transform( aAtestado[ nXATEST , 1 ] , "@R 9.999.999/9" )					   }) //"R.G."
		TRCell():New( oSection2, "ATESTADO_MAT"	    , " " , STR0018, "@R 999999"	  , 18, .T., {|| Transform( aAtestado[ nXATEST , 2 ] , "@R 999999" ) 						   }) //"MATRÍCULA"
		TRCell():New( oSection2, "ATESTADO_NOME"	, " " , STR0013, "@!"			  , 45, .T., {|| SubStr( aAtestado[ nXATEST , 3 ] , 1 , 30 )								   }) //"NOME"
		TRCell():New( oSection2, "ATESTADO_CC"		, " " , STR0045, "@!"			  , 60, .T., {|| SubStr( aAtestado[ nXATEST , 7 ] , 1 , 40 ) 								   }) //"C. CUSTO"
		TRCell():New( oSection2, "ATESTADO_DTAFAS"  , " " , STR0046, "@!"			  , 40, .T., {|| DtoC( aAtestado[ nXATEST , 4 ] ) + STR0051 + DtoC( aAtestado[ nXATEST , 5 ] ) }) //"PERIODO DE AFAST."
		TRCell():New( oSection2, "ATESTADO_GPCID"	, " " , STR0052, "@!"			  , 10, .T., {|| aAtestado[ nXATEST , 10 ] 	 								                   }) //"GRUPO CID"
		TRCell():New( oSection2, "ATESTADO_CID"	    , " " , STR0053, "@!"			  , 10, .T., {|| aAtestado[ nXATEST , 11 ] 	 								                   }) //"CID"
		TRCell():New( oSection2, "ATESTADO_DTPER"	, " " , STR0048, "@R 9999"		  , 16, .T., {|| Transform( aAtestado[ nXATEST , 8 ] , "@R 9999" )	 						   }) //"DIAS PERD."
		TRCell():New( oSection2, "ATESTADO_HRPER"	, " " , STR0047, "99:99"		  , 22, .T., {|| Transform( aAtestado[ nXATEST , 9 ] , "99:99") 				 			   }) //"HORAS PERD."
		If lObserva //Verifica se existe campo observação
			oSection3 := TRSection():New( oReport , STR0008 ,{" "} )//"Ocorrencias na Geracao da Programacao de Exames"
			TRCell():New( oSection3 ,"ATESTADO_OBSERV", " " , STR0015	,"@!"				,138	,.T.	,{|| SubStr( aAtestado[ nXATEST , 6 ] , 1 , 80 ) 									}) //"OBSERVAÇÕES"
			oSection3:nLeftMargin := 3 //Determina uma margem na lateral esquerda.
		EndIf
		oSection2:nLeftMargin := 1 //Determina uma margem na lateral esquerda.

		Pergunte( oReport:uParam , .F. )//Faz a chamada das perguntas.

Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Função responsavel por dar inicio a impressão

@param oReport, Objeto, Objeto de impressão.
@param oSection1, Objeto, Primeira seção.
@param oSection2, Objeto, Segunda seção.
@param oSection3, Objeto, Terceira seção.
@param aAtestado, Array, Contém as informações a serem impressas.

@sample ReportPrint( oReport , oSection1 , oSection2 , oSection3 , {} )
@author Guilhrme Freudenburg
@since  13/08/2014

@return Nil, Sempre Nulo
/*/
//---------------------------------------------------------------------
Static Function ReportPrint( oReport , oSection1 , oSection2 , oSection3 , aAtestado )

	Local nX := 0
	Local nY := 0

	DbSelectArea( "TNY" )
	//Preenche array com valores.
	aAtestado := U_MDTR510DADOS()

	If Len(aAtestado) >= 1//Verifica se existe algum atestado.

		oSection1:Init()  //Inicia section
		oReport:SkipLine(8)
		oReport:PrtCenter(STR0008)//"PROGRAMA DE CONTROLE MEDICO DE SAUDE OCUPACIONAL"
		oReport:SkipLine()
		oReport:PrtCenter(STR0032)//"COMUNICACAO  INTERNA  DE  ATESTADOS  POR  FALTA  AO  TRABALHO"
		oReport:SkipLine(3)
		oSection1:Finish() //Fecha Section

		For nX := 1 To Len(aAtestado)//Percorre todos os registro para realizar a impressão
			oSection2:Init()  //Inicia Section
				nXATEST := nX
				oSection2:PrintLine()  //Imprime a linha
				If !Empty( aAtestado[ nX , 6 ] )//Verifica se existe observação
					oSection3:Init()  //Inicia Section
					oSection3:PrintLine()  //Imprime a linha
					oSection3:Finish() //Fecha Section
				Endif
				//Verifica a quantidade de linhas impresas,após a impressão de todos os registros.
				If nX =  Len(aAtestado) .And. oReport:Row() < 2100 //Verifica a quantidade de linhas impressa
					For nY := 1 To 50
						oReport:SkipLine()//Pula linha
						If oReport:Row() >= 2100 //Caso atinja ao valor máximo de linhas
							Exit
						Endif
					Next nY

				Endif
				//Imprime rodapé de assinaturas.
				If oReport:Row() >= 2100 .Or. nX == Len(aAtestado)
					oReport:SkipLine(3)
					oReport:PrtCenter( "               ___ / ___ / ___  _____________________________                                               ___ / ___ / ___  ______________________________   " )
					oReport:SkipLine()
					oReport:PrtCenter( STR0050 )//"                                         MEDICO                                                                                   RESPONSÁVEL DE SAÚDE         "
					oReport:EndPage(.T.)
					If oReport:Page() > 1 .And. nX <> Len(aAtestado) //Caso seja nova pagina.
						oSection1:Init()
						oReport:SkipLine(8)
						oReport:PrtCenter(STR0008)//"PROGRAMA DE CONTROLE MEDICO DE SAUDE OCUPACIONAL"
						oReport:SkipLine()
						oReport:PrtCenter(STR0032) //"COMUNICACAO  INTERNA  DE  ATESTADOS  POR  FALTA  AO  TRABALHO"
						oReport:SkipLine(3)
						oSection1:Finish()
					Endif
				EndIf
			oSection2:Finish()
		Next nX


	Else
		MsgStop( STR0049 )//"Não existe atestado para realizar a impressão."
		Return .F.
	Endif

Return Nil