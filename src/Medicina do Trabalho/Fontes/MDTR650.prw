/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr650.ch"
#Include "Protheus.ch"
#INCLUDE "MSOLE.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR650

Relatorio Mapa de Riscos

@author  Andre E. Perez Alvarez
@since   28/08/08

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function MDTR650()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()
	Local lCipatr 	  := If( SuperGetMv("MV_NG2NR31" , .F. , "2") == "1" , .T. , .F. )

	Private nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private cAliasCC := "SI3"
	Private cDescrCC := "SI3->I3_DESC"
	Private cCodCTT  := "I3_CUSTO"
	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS", .F., "N") == "S", .T. , .F. )

	cPerg := PadR( "MDT650" , 10 )

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAliasCC := "CTT"
		cDescrCC := "CTT->CTT_DESC01"
		nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
		cCodCTT  := "CTT_CUSTO"
	Endif

	/*
	//PERGUNTAS PADRÃO
	01 De Centro de Custo ?
	02 Até Centro de Custo ?
	03 De Ambiente ?
	04 Até Ambiente ?
	05 De Data de Avaliação ?
	06 Até Data de Avaliação ?
	07 Mapa de Risco:
	    	1=CIPA/CIPATR
	    	2=SESMT
	    	3=AMBOS
	08 Considerar:
	    	1=ASO
	    	2=Nenhum
	    	3=ASO e PPP
	     	4=PPP
	09 Mapa por:
	      	1=Centro de Custo
	      	2=Ambiente
	10 Imprimir Legenda:
	      	1=Sim
	      	2=Não
	12 Tipo de Impressão:
	      	1=Tela
	      	2=Impressora
	11 Mandato ?
	12 Tipo de Impressão
	13 Agrupar por Agente ?
	      	1=Sim
	      	2=Não
	*/

	If Pergunte(cPerg,.t.)
		U_R650Imp()
	Endif

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} R650Imp

Prepara o processamento.

@author  André E. Perez Álvarez
@since   28/08/08

@return  Nulo, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function R650Imp()

	Private cTRBTN0 := GetNextAlias()

	// Processamento dos dados
	Processa( {|lEND| TRBgrava()}, STR0001, STR0002 )  // "Aguarde"###"Processando as informações..."

	// Verifica se há dados e prepara o documento Word
	dbSelectArea( cTRBTN0 )

	If ( cTRBTN0 )->( EoF() )
		MsgInfo(STR0003)  //"Não há nada para imprimir no relatório."
	Else
		U_MDT650W1()
	Endif

	dbSelectArea( cTRBTN0 )
	dbCloseArea()

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} TRBgrava

Processa os registros de acordo com os parametros e grava
no arquivo temporario.

@author  Andre E. Perez Alvarez
@since   31/07/06

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
Static Function TRBgrava()

	Local lTN0Depto := NGCADICBASE( "TN0_DEPTO" , "A" , "TN0" , .F. )
	Local cSQLCond := ""
	Local cSQLCond1 := "%%"
	Local cSQLGrp	:= "", cSQLOrd := "", cSQLCmp := ""
	Local cExpDist	:= "%COUNT(DISTINCT(SRA.RA_MAT))%"
	Local cCondDepto:= If( lTN0Depto , "%(SRA.RA_DEPTO = TN0.TN0_DEPTO OR TN0.TN0_DEPTO = '*') AND %" , "%%" )

	Private cCampos := ""
	Private aGrupo := {}

	If !( "MSSQL" $ Upper( TCGetDB() ) )
		cExpDist	:= "%COUNT(DISTINCT SRA.RA_MAT)%"
	EndIf

	dbSelectArea( "TN0" )
	dbSetOrder( 5 )  //TN0_FILIAL+TN0_CC+TN0_CODFUN+TN0_CODTAR

	If AllTrim(STR(MV_PAR08)) == "1"
		cSQLCond := '% TN0.TN0_LISASO IN(' + ValToSql( "1" ) + ' , ' + ValToSQL( "3" ) + ')%'
	ElseIf AllTrim(STR(MV_PAR08)) == "2"
		cSQLCond := '% ( TN0.TN0_LISASO = ' + ValToSql( "2" ) + ' OR ' +;
						'TN0.TN0_LISASO = '+ ValToSql( "" )  +' )%' //verifica se campo esta vazio
	ElseIf AllTrim(STR(MV_PAR08)) == "3"
		cSQLCond := '% TN0.TN0_LISASO <> ' + ValToSql( "2" ) + ' AND ' +;
						'TN0.TN0_LISASO <> ' + ValToSql( "" ) + '%' //verifica se campo esta diferente de vazio
	Else
		cSQLCond := '% TN0.TN0_LISASO IN(' + ValToSql( "3" ) + ' , ' + ValToSQL( "4" ) + ')%'
	EndIf

	If AllTrim(STR(MV_PAR07)) $ "1;2"
		cSQLCond1 := '% TN0.TN0_MAPRIS = ' + ValToSQL( AllTrim(STR(MV_PAR07)) ) + 'AND %'
	EndIf

	If mv_par09 == 1

		If mv_par13 == 2
			cSQLGrp := "% CTT.CTT_CUSTO, TN0.TN0_NUMRIS, TN0.TN0_AGENTE, TN0.TN0_GRAU %"
			CSQLOrd	:= "% TN0_CC, TN0_NUMRIS, TN0_AGENTE, TN0_GRAU %"
			cSQLCmp := "% TN0.TN0_NUMRIS, %"
		Else
			cSQLGrp := "% CTT.CTT_CUSTO, TN0.TN0_AGENTE, TN0.TN0_GRAU %"
			CSQLOrd	:= "% TN0_CC, TN0_AGENTE, TN0_GRAU %"
			cSQLCmp := "%%"
		EndIf

		BeginSQL Alias cTRBTN0
			SELECT CTT.CTT_CUSTO TN0_CC, %exp:cSQLCmp% TN0.TN0_AGENTE,TN0.TN0_GRAU,%exp:cExpDist% QTDE_FUNC
				FROM %table:CTT% CTT
					INNER JOIN %table:TN0% TN0 ON ( CTT.CTT_CUSTO = TN0.TN0_CC OR TN0.TN0_CC = '*' )
					LEFT JOIN %table:TN6% TN6 ON TN6.TN6_CODTAR = TN0.TN0_CODTAR AND TN6.%notDel% AND TN6.TN6_FILIAL = %xFilial:TN6% AND
					( ( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM = ''  ) OR
					( TN6.TN6_DTTERM <> '' AND TN0.TN0_DTELIM <> '' AND	NOT( (TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL) OR
					( TN6.TN6_DTINIC > TN0.TN0_DTELIM AND TN6.TN6_DTTERM > TN0.TN0_DTELIM) ) ) OR
					( TN6.TN6_DTTERM <> '' AND TN0.TN0_DTELIM = '' AND NOT ( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )  ) OR
					( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM <> '' AND NOT ( TN0.TN0_DTAVAL < TN6.TN6_DTINIC AND TN0.TN0_DTELIM < TN6.TN6_DTINIC ) ) )
					LEFT JOIN %table:SRA% SRA ON SRA.RA_SITFOLH <> 'D' AND (SRA.RA_CC = CTT.CTT_CUSTO ) AND
					%exp:cCondDepto%
					(SRA.RA_CODFUNC = TN0.TN0_CODFUN OR TN0.TN0_CODFUN = '*') AND
					( ( TN6.TN6_FILIAL = SRA.RA_FILIAL AND TN6.TN6_MAT = SRA.RA_MAT ) OR
					TN0.TN0_CODTAR = '*' ) AND SRA.RA_FILIAL = %xFilial:SRA% AND SRA.%notDel%
			WHERE
				TN0.TN0_FILIAL = %xFilial:TN0% AND
				( TN0.TN0_CC BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% OR LTRIM(RTRIM(TN0.TN0_CC)) = '*' ) AND
				TN0.TN0_CODAMB BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
				TN0.TN0_DTAVAL <> '' AND
				TN0.TN0_DTELIM = '' AND
				TN0.TN0_DTAVAL BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06% AND
				%exp:cSQLCond% AND
				%exp:cSQLCond1%
				TN0.%notDel% AND
				CTT.CTT_FILIAL = %xFilial:CTT% AND
				CTT.CTT_CUSTO BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
				CTT.%notDel%
			GROUP BY %exp:cSQLGrp%
			ORDER BY %exp:CSQLOrd%
		EndSQL

	Else

		If mv_par13 == 2
			cSQLGrp := "% TNE.TNE_CODAMB, TN0.TN0_NUMRIS, TN0.TN0_AGENTE, TN0.TN0_GRAU %"
			CSQLOrd	:= "% TN0_CODAMB, TN0_NUMRIS, TN0_AGENTE, TN0_GRAU %"
			cSQLCmp := "% TN0.TN0_NUMRIS, %"
		Else
			cSQLGrp := "% TNE.TNE_CODAMB, TN0.TN0_AGENTE, TN0.TN0_GRAU %"
			CSQLOrd	:= "% TN0_CODAMB, TN0_AGENTE, TN0_GRAU %"
			cSQLCmp := "%%"
		EndIf

		BeginSQL Alias cTRBTN0
			SELECT TNE.TNE_CODAMB TN0_CODAMB, %exp:cSQLCmp% TN0.TN0_AGENTE,TN0.TN0_GRAU,COUNT(DISTINCT(SRA.RA_MAT)) QTDE_FUNC
				FROM %table:TNE% TNE
					INNER JOIN %table:TN0% TN0 ON TNE.TNE_CODAMB = TN0.TN0_CODAMB
					LEFT JOIN %table:TN6% TN6 ON TN6.TN6_CODTAR = TN0.TN0_CODTAR AND TN6.%notDel% AND TN6.TN6_FILIAL = %xFilial:TN6% AND
					( ( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM = ''  ) OR
					( TN6.TN6_DTTERM <> '' AND TN0.TN0_DTELIM <> '' AND	NOT( (TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL) OR
					( TN6.TN6_DTINIC > TN0.TN0_DTELIM AND TN6.TN6_DTTERM > TN0.TN0_DTELIM) ) ) OR
					( TN6.TN6_DTTERM <> '' AND TN0.TN0_DTELIM = '' AND NOT ( TN6.TN6_DTINIC < TN0.TN0_DTAVAL AND TN6.TN6_DTTERM < TN0.TN0_DTAVAL )  ) OR
					( TN6.TN6_DTTERM = '' AND TN0.TN0_DTELIM <> '' AND NOT ( TN0.TN0_DTAVAL < TN6.TN6_DTINIC AND TN0.TN0_DTELIM < TN6.TN6_DTINIC ) ) )
					LEFT JOIN %table:SRA% SRA ON SRA.RA_SITFOLH <> 'D' AND (SRA.RA_CC = TN0.TN0_CC OR TN0.TN0_CC = '*' ) AND
					%exp:cCondDepto%
					(SRA.RA_CODFUNC = TN0.TN0_CODFUN OR TN0.TN0_CODFUN = '*') AND
					( ( TN6.TN6_FILIAL = SRA.RA_FILIAL AND TN6.TN6_MAT = SRA.RA_MAT ) OR
					TN0.TN0_CODTAR = '*' ) AND SRA.RA_FILIAL = %xFilial:SRA% AND SRA.%notDel%
			WHERE
				TN0.TN0_FILIAL = %xFilial:TN0% AND
				( TN0.TN0_CC BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% OR LTRIM(RTRIM(TN0.TN0_CC)) = '*' ) AND
				TN0.TN0_CODAMB BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
				TN0.TN0_DTAVAL <> '' AND
				TN0.TN0_DTELIM = '' AND
				TN0.TN0_DTAVAL BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06% AND
				%exp:cSQLCond% AND
				%exp:cSQLCond1%
				TN0.%notDel% AND
				TNE.TNE_FILIAL = %xFilial:TNE% AND
				TNE.TNE_CODAMB BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
				TNE.%notDel%
			GROUP BY %exp:cSQLGrp%
			ORDER BY %exp:CSQLOrd%
		EndSQL

	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT650W1

Prepara o Relatorio

@author  André E. Perez Álvarez
@since   28/08/08

@return  Nulo, Sempre nulo
/*/
//-------------------------------------------------------------------
User Function MDT650W1()

	Local nXX,nYY
	Local cBarraSrv := "\"
	Local cBarraRem := "\"
	Local cSMCOD := FWGrpCompany()
	Local cSMFIL := FWCodFil()
	Local nLinhasDesc := 0
	Local nInd := 0
	Local nSoma := 0

	Private cPathAca := Alltrim(GetMv("MV_DIRACA"))	// Path do arquivo modelo do Word
	Private cPathEst := Alltrim(GetMv("MV_DIREST"))	// PATH DO ARQUIVO A SER ARMAZENADO NA ESTACAO DE TRABALHO
	Private aArqMapa := {"NgMapa01.Bmp","NgMapa02.Bmp","NgMapa03.Bmp","NgMapa04.Bmp","NgMapa05.Bmp","NgMapa06.Bmp","NgMapa07.Bmp","NgMapa08.Bmp"}
	Private aDimMapa := { {110,120} , {190,90} , {270,60} }
	Private cArqBmp  := "LGRL"+cSMCOD+cSMFIL+".BMP"              // Nome do arquivo logo do cliente
	Private cArqBmp2 := "LGRL"+cSMCOD+".BMP"          // Nome do arquivo logo do cliente
	Private nLinMax  := 3100

	Private oFont07  := TFont():New("Verdana",07,07,,.F.,,,,.F.,.F.)
	Private oFont08  := TFont():New("Verdana",08,08,,.F.,,,,.F.,.F.)
	Private oFont09  := TFont():New("Verdana",09,09,,.F.,,,,.F.,.F.)
	Private oFont09n := TFont():New("Verdana",09,09,,.T.,,,,.F.,.F.)
	Private oFont10  := TFont():New("Verdana",10,10,,.F.,,,,.F.,.F.)
	Private oFont10n := TFont():New("Verdana",10,10,,.T.,,,,.F.,.F.)
	Private oFont11n := TFont():New("Verdana",11,11,,.T.,,,,.F.,.F.)
	Private lin := 9999

	If Mv_par10 == 1
		nLinMax := 2500
	Endif

	If Empty(cPathAca)
		MsgInfo(STR0005) //"O parâmetro MV_DIRACA não foi configurado. Este parâmetro indica o diretório onde devem estar as imagens utilizadas no Mapa de Risco."
		Return
	Endif

	If Empty(cPathEst)
		MsgInfo(STR0006) //"O parâmetro MV_DIREST não foi configurado. Este parâmetro indica o diretório na estação onde os arquivos utilizados no Mapa de Risco serão copiados."
		Return
	Endif

	If GetRemoteType() == 2  //estacao com sistema operacional unix
		cBarraRem := "/"
	Endif

	If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)
		cBarraSrv := "/"
	Endif

	//Ajusta diretorios
	cPathAca += If(Substr(cPathAca,len(cPathAca),1) != cBarraSrv,cBarraSrv,"")
	cPathEst += If(Substr(cPathEst,len(cPathEst),1) != cBarraRem,cBarraRem,"")

	//Cria diretorio se nao existir
	MontaDir(cPathEst)

	//Se existir .bmp na estacao, apaga!
	If File( cPathAca + cArqBmp )

		If File( cPathEst + cArqBmp )
			Ferase( cPathEst + cArqBmp )
		EndIf

		__copyfile( cPathAca + cArqBmp , cPathEst + cArqBmp )
	ElseIf File( cPathAca + cArqBmp2 )

		If File( cPathEst + cArqBmp2 )
			Ferase( cPathEst + cArqBmp2 )
		EndIf
		__copyfile( cPathAca + cArqBmp2 , cPathEst + cArqBmp2 )
		cArqBmp := cArqBmp2
	EndIf

	cImgErro := ""

	For nXX := 1 To Len(aArqMapa)

		If File( cPathAca + aArqMapa[nXX] )

			If File( cPathEst + aArqMapa[nXX] )
				Ferase( cPathEst + aArqMapa[nXX] )
			EndIf

			__copyfile( cPathAca + aArqMapa[nXX] , cPathEst + aArqMapa[nXX] )
		Else

			If Empty(cImgErro)
				cImgErro := aArqMapa[nXX]
			Else
				cImgErro += ", " + aArqMapa[nXX]
			Endif

		Endif

	Next nXX

	If !Empty(cImgErro)
		MsgInfo(STR0007+; //"As imagens necessárias para impressão do Mapa de Risco não foram encontradas no servidor."
		STR0008 +Chr(10)+; //"As seguintes imagens devem estar no diretório configurado no parâmetro MV_DIRACA  : "
		cImgErro+Chr(10)+Chr(10)+STR0009+Alltrim(cPathAca)	) //"Parâmetro MV_DIRACA = "
		Return
	Endif

	dbSelectArea("TNN")
	dbSetOrder(1)
	dbSeek(xFilial("TNN")+mv_par11)

	oPrintMP := FwMsPrinter():New( STR0010, 2 , .T., cPathEst, .T. ) //"Mapa de Riscos"
	oPrintMP:SetPortRait()
	oPrintMP:SetPaperSize( 9 )
	oPrintMP:Setup()

	lFirstPrt := .t.

	If Mv_par09 == 1 //Por CENTRO DE CUSTO

		aDadosRel := {}
		dbSelectArea( cTRBTN0 )
		dbGoTop()

		While !Eof()
			nInd := aScan(aDadosRel,{|x| x[1] == ( cTRBTN0 )->TN0_CC })

			If nInd == 0
				dbSelectArea(cAliasCC)
				dbSetOrder(1)
				dbSeek( xFilial(cAliasCC) + ( cTRBTN0 )->TN0_CC )
				aAdd( aDadosRel , { ( cTRBTN0 )->TN0_CC , &(cDescrCC) , {} } )
				nInd := Len(aDadosRel)
			Endif

			dbSelectArea("TMA")
			dbSetOrder(1)

			If dbSeek( xFilial("TMA") + ( cTRBTN0 )->TN0_AGENTE )

				If TMA->TMA_GRISCO $ "1/2/3/4/5/6" .and. ( cTRBTN0 )->TN0_GRAU $ "1/2/3"
					aAdd( aDadosRel[nInd,3] , { Val( ( cTRBTN0 )->TN0_GRAU ) , Val( If(TMA->TMA_GRISCO=="6","5",TMA->TMA_GRISCO) ) , ;
											Capital(TMA->TMA_NOMAGE) , ( cTRBTN0 )->QTDE_FUNC , ( cTRBTN0 )->TN0_AGENTE } )

				Endif

			Endif

			dbSelectArea( cTRBTN0 )
			dbSkip()
		End

		//Ordenando pela descricao do centro de custo
		aSort( aDadosRel ,,,{|x,y| x[2] < y[2] })

		For nXX := 1 To Len( aDadosRel )

			nLenCC := Len( aDadosRel[nXX,3] )

			If nLenCC == 0
				Loop
			Endif

			//Ordenando pelo nome do agente
			aSort( aDadosRel[nXX,3] ,,,{|x,y| x[2] < y[2] })

			nPagTotal := 0 //Quantidade de Paginas para o Centro de Custo
			nLinTotal := 0 //Quantidade de Linhas para o Centro de Custo
			nPagCC    := 0 //Pagina Atual do Centro de Custo
			nLinMaxim := 3 //Linhas Maxima para a Pagina

			//Linhas
			nLinTotal := Int(nLenCC/3)

			If (nLenCC % 3) <> 0
				nLinTotal++
			Endif

			//Paginas

			If Mv_par10 == 1
				nPagTotal := Int(nLinTotal/nLinMaxim)

				If (nLinTotal % nLinMaxim) <> 0
					nPagTotal++
				Endif

			Else
				nPagTotal := Int(nLinTotal/nLinMaxim)

				If (nLinTotal % nLinMaxim) <> 0
					nPagTotal++
				Endif

			Endif

			nPagCC  := 1
			nColunX := 1
			nLinhaX := 1
			nLinhaMais := 0

			For nYY := 1 To Len( aDadosRel[nXX,3] )
				nPosImage := aDadosRel[nXX,3][nYY,2]
				nTamImage := aDadosRel[nXX,3][nYY,1]

				If nColunX == 1

					If nLinhaX > nLinMaxim
						nLinhaX := 1
						nPagCC++
						SomaLinha(300,nPagCC,nPagTotal,aDadosRel[nXX,2],.t.)
					Else

						If nYY == 1
							SomaLinha(480,nPagCC,nPagTotal,aDadosRel[nXX,2],.t.)
						Else
							SomaLinha(480,nPagCC,nPagTotal,aDadosRel[nXX,2])
						Endif

					Endif

					oPrintMP:Line(lin,30,lin+640,30)
					oPrintMP:Line(lin,2450,lin+640,2450)

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],160+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),160, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma,160, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				ElseIf nColunX == 2

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],930+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),930, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma, 930, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				Else

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],1690+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),1730, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma, 1730, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				Endif

				nColunX++

				If nColunX > 3
					nColunX := 1
					nLinhaX++
				Endif

			Next nYY

		Next nXX

	Else

		// Por AMBIENTE
		aDadosRel := {}
		dbSelectArea( cTRBTN0 )
		dbGoTop()

		While !Eof()
			nInd := aScan(aDadosRel,{|x| x[1] == ( cTRBTN0 )->TN0_CODAMB })

			If nInd == 0
				dbSelectArea("TNE")
				dbSetOrder(1)
				dbSeek( xFilial("TNE") + ( cTRBTN0 )->TN0_CODAMB )
				aAdd( aDadosRel , { ( cTRBTN0 )->TN0_CODAMB , TNE->TNE_NOME , {} } )
				nInd := Len(aDadosRel)
			Endif

			dbSelectArea("TMA")
			dbSetOrder(1)

			If dbSeek( xFilial("TMA") + ( cTRBTN0 )->TN0_AGENTE )

				If TMA->TMA_GRISCO $ "1/2/3/4/5/6" .and. ( cTRBTN0 )->TN0_GRAU $ "1/2/3"
					aAdd( aDadosRel[nInd,3] , { Val( ( cTRBTN0 )->TN0_GRAU ) , Val( If(TMA->TMA_GRISCO=="6","5",TMA->TMA_GRISCO) ) , ;
												Capital(SubStr(TMA->TMA_NOMAGE,1,25)) , ( cTRBTN0 )->QTDE_FUNC , ( cTRBTN0 )->TN0_AGENTE } )
				Endif

			Endif

			dbSelectArea( cTRBTN0 )
			dbSkip()
		End

		// Ordenando pela descricao do Ambiente
		aSort( aDadosRel ,,,{|x,y| x[2] < y[2] })

		For nXX := 1 To Len( aDadosRel )
			nLenCC := Len( aDadosRel[nXX,3] )

			If nLenCC == 0
				Loop
			Endif

			// Ordenando pelo nome do agente
			aSort( aDadosRel[nXX,3] ,,,{|x,y| x[2] < y[2] })
			nPagTotal := 0 //Quantidade de Paginas para o Ambiente
			nLinTotal := 0 //Quantidade de Linhas para o Ambiente
			nPagCC    := 0 //Pagina Atual do Ambiente
			nLinMaxim := 3 //Linhas Maxima para a Pagina

			// Linhas
			nLinTotal := Int(nLenCC/3)

			If (nLenCC % 3) <> 0
				nLinTotal++
			Endif

			// Paginas
			If Mv_par10 == 1
				nPagTotal := Int(nLinTotal/nLinMaxim)

				If (nLinTotal % nLinMaxim) <> 0
					nPagTotal++
				Endif

			Else
				nPagTotal := Int(nLinTotal/nLinMaxim)

				If (nLinTotal % nLinMaxim) <> 0
					nPagTotal++
				Endif

			Endif

			nPagCC  := 1
			nColunX := 1
			nLinhaX := 1
			nLinhaMais := 0

			For nYY := 1 To Len( aDadosRel[nXX,3] )
				nPosImage := aDadosRel[nXX,3][nYY,2]
				nTamImage := aDadosRel[nXX,3][nYY,1]

				If nColunX == 1

					If nLinhaX > nLinMaxim
						nLinhaX := 1
						nPagCC++
						SomaLinha(300,nPagCC,nPagTotal,aDadosRel[nXX,2],.t.)
					Else

						If nYY == 1
							SomaLinha(480,nPagCC,nPagTotal,aDadosRel[nXX,2],.t.)
						Else
							SomaLinha(480,nPagCC,nPagTotal,aDadosRel[nXX,2])
						Endif

					Endif

					oPrintMP:Line(lin,30,lin+640,30)
					oPrintMP:Line(lin,2450,lin+640,2450)

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],160+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),160, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma,160, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				ElseIf nColunX == 2

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],930+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),930, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma, 930, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				Else

					If File( cPathEst + aArqMapa[nPosImage] )
						oPrintMP:SayBitMap(lin+aDimMapa[nTamImage,2],1690+aDimMapa[nTamImage,2],cPathEst + aArqMapa[nPosImage], aDimMapa[nTamImage,1] , aDimMapa[nTamImage,1] )
					Endif

					oPrintMP:Say((lin+340),1730, STR0011+cValToChar(aDadosRel[nXX,3][nYY,4]) ,oFont09n) //"Nº Func.: "

					nLinhasDesc := MLCOUNT(Alltrim( aDadosRel[nXX,3][nYY,3] ), 20,,.t.) //Quebra linha
					For nInd := 1 to nLinhasDesc
						oPrintMP:Say((lin+400) + nSoma, 1730, MemoLine( aDadosRel[nXX,3][nYY,3], 20, nInd,,.t.) ,(oFont09))
						nSoma += 40
					Next nInd
					nSoma := 0

				Endif

				nColunX++

				If nColunX > 3
					nColunX := 1
					nLinhaX++
				Endif

			Next nYY

		Next nXX

	Endif

	If !lFirstPrt
		oPrintMP:Line(lin+640,30,lin+640,2450)
		Somalinha(640)

		If Mv_par10 == 1
			fImpLegenda()
		Endif

		oPrintMP:EndPage()
	Endif

	If mv_par12 == 1
		oPrintMP:Preview()
	Else
		oPrintMP:Print()
	Endif

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha

Executa a quebra de linha e de página

@author  Denis Hyroshi de Souza
@since   28/08/08

@sample  SomaLinha(350, nPagCC, nPagTotal, aDadosRel[nXX,2], .T.)

@param   nlinhaa, Numérico, Tamanho da quebra de linha
@param   nPagCC, Numérico, Compatibilidade
@param   nPagTotal, Numérico, Compatibilidade
@param   cDescSetor, Caractere, Descrição do CC ou Ambiente que será impressa no cabeçalho
@param   lBreakPag, Lógico, Define se  será realizada a quebra de página independente da posição atual
/*/
//-------------------------------------------------------------------
Static Function SomaLinha(nlinhaa, nPagCC, nPagTotal, cDescSetor, lBreakPag)

	Local lCipatr := SuperGetMv("MV_NG2NR31" , .F. , "2") == "1"

	If ValType(nlinhaa) == "N"
		lin += nlinhaa
	Else
		lin += 60
	Endif

	If lin > nLinMax .or. ValType(lBreakPag) == "L"

		If ValType(nlinhaa) == "N"
			lin := lin - nlinhaa
		Else
			lin := lin - 60
		Endif

		If lFirstPrt
			oPrintMP:StartPage()
			lFirstPrt := .f.
		Else
			oPrintMP:Line(lin+640,30,lin+640,2450)
			lin += 640

			If Mv_par10 == 1
				fImpLegenda()
			Endif

			oPrintMP:EndPage()
			oPrintMP:StartPage()
		Endif

		If File( cPathEst + cArqBmp )
			oPrintMP:SayBitMap(150,150,cPathEst + cArqBmp,335,185) //Logo
		ElseIf File( cArqBmp )
			oPrintMP:SayBitMap(150,150,cArqBmp,335,185) //Logo
		Endif

		oPrintMP:Say(200,550,STR0012,oFont10n) //"Empresa:"
		oPrintMP:Say(200,760,SM0->M0_NOMECOM,oFont10) //Empresa
		oPrintMP:Say(200,1650,If(lCipatr, STR0081, STR0080), oFont10n) //"CIPATR:" //"CIPA:"

		If Year(TNN->TNN_DTINIC) == Year(TNN->TNN_DTTERM) .or. Empty(TNN->TNN_DTTERM)
			oPrintMP:Say(200,1820,Alltrim( Str(Year(TNN->TNN_DTINIC)) ),oFont10)
		Else
			oPrintMP:Say(200,1820,Alltrim( Str(Year(TNN->TNN_DTINIC)) + "/" + SubStr( StrZero(Year(TNN->TNN_DTTERM),4) ,3,2) ),oFont10)
		Endif

		oPrintMP:Say(370,150,STR0013,oFont10n) //"Mapeamento de Riscos:"
		oPrintMP:Say(420,150,STR0014,oFont09) //Descricao //"Informamos aos trabalhadores sobre os riscos de acidentes e doenças do trabalho a que estão submetidos durante a jornada"
		oPrintMP:Say(470,150,STR0015,oFont09) //Descricao //"de trabalho."

		If mv_par09 == 1
			oPrintMP:Say(550,150,STR0016,oFont10n) //"Centro de Custo:"
		Else
			oPrintMP:Say(550,150,STR0017,oFont10n) //"Ambiente:"
		Endif

		oPrintMP:Say(550,500,cDescSetor,oFont11n) //Centro de Custo ou Ambiente
		oPrintMP:Say(150,2080,STR0018+dToc(dDataBase),oFont07) //"Data: "
		oPrintMP:Say(185,2080,STR0019+Substr(Time(),1,5),oFont07) //"Hora: "

		oPrintMP:Line(840,30,840,2450)
		lin := 840

	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} fImpLegenda

Legenda

@author  Denis Hyroshi de Souza
@since   28/08/08
/*/
//-------------------------------------------------------------------
Static Function fImpLegenda()

	lin += 60

	oPrintMP:Say( lin, 170, STR0020, oFont10n ) // "Legenda:"

	If File( cPathEst + aArqMapa[ 6 ] )
		oPrintMP:SayBitMap( lin + 50, 100, cPathEst + aArqMapa[ 6 ], 270, 270 ) // Figura Risco Grande
	Endif

	If File( cPathEst + aArqMapa[ 7 ] )
		oPrintMP:SayBitMap( lin + 350, 140, cPathEst + aArqMapa[ 7 ], 200, 200 ) // Figura Risco Medio
	Endif

	If File( cPathEst + aArqMapa[ 8 ] )
		oPrintMP:SayBitMap( lin + 570, 190, cPathEst + aArqMapa[ 8 ], 100, 100 ) // Figura Risco Pequeno
	Endif

	oPrintMP:Say( lin + 100, 545, STR0021, oFont10n ) // "Nº Func.:"
	oPrintMP:Say( lin + 100, 965, STR0022, oFont08 ) // "Número de funcionários expostos ao risco."

	If File( cPathEst + aArqMapa[ 1 ] )
		oPrintMP:SayBitMap( lin + 160, 465, cPathEst + aArqMapa[ 1 ], 70, 70 ) //Figura Verde
	Endif

	oPrintMP:Say( lin + 195, 545, STR0023, oFont10n ) // "Físico -"
	oPrintMP:Say( lin + 190, 965, STR0024, oFont08 ) // "Ruídos, vibrações, radiações ionizantes/não ionizantes, frio, calor, pressões anormais e umidade."

	If File( cPathEst + aArqMapa[ 2 ] )
		oPrintMP:SayBitMap( lin + 240, 465, cPathEst + aArqMapa[ 2 ], 70, 70 ) //Figura Vermelha
	Endif

	oPrintMP:Say( lin + 275, 545, STR0025, oFont10n ) // "Químico -"
	oPrintMP:Say( lin + 270, 965, STR0026, oFont08 ) // "Poeira, fumos, névoas, neblinas, gases, vapores, substâncias, compostos ou produtos químicos em geral."

	If File( cPathEst + aArqMapa[ 3 ] )
		oPrintMP:SayBitMap( lin + 320, 465, cPathEst + aArqMapa[ 3 ], 70, 70 ) //Figura Marron
	Endif

	oPrintMP:Say( lin + 360, 545, STR0027, oFont10n ) // "Biológico -"
	oPrintMP:Say( lin + 355, 965, STR0028, oFont08 ) // "Vírus, bactérias, protozoários, fungos, parasitas e bacilos."

	If File( cPathEst + aArqMapa[ 4 ] )
		oPrintMP:SayBitMap( lin + 400, 465, cPathEst + aArqMapa[ 4 ], 70, 70 ) //Figura Amarelo
	Endif

	oPrintMP:Say( lin + 440, 545, STR0029, oFont10n ) // "Ergonômico -"
	oPrintMP:Say( lin + 435, 965, STR0030, oFont08 ) // "Esforço físico interno, levantamento, transporte manual de peso, exigência de postura inadequada,"
	oPrintMP:Say( lin + 455, 965, STR0031, oFont08 ) // "controle rígido de produtividade, imposição de ritmos excessivos, trabalho em turno e noturno,"
	oPrintMP:Say( lin + 480, 965, STR0032, oFont08 ) // "jornada de trabalho prolongada, monotonia e repetitividade, outras situações."

	If File( cPathEst + aArqMapa[ 5 ] )
		oPrintMP:SayBitMap( lin + 490, 465, cPathEst + aArqMapa[ 5 ], 70, 70 ) //Figura Azul
	Endif

	oPrintMP:Say( lin + 530, 545, STR0033, oFont10n ) // "Mecânico/Acidente -"
	oPrintMP:Say( lin + 525, 965, STR0034, oFont08 ) // "Arranjo físico inadequado, maquinas e equipamentos sem proteção, ferramentas inadequadas"
	oPrintMP:Say( lin + 545, 965, STR0035, oFont08 ) // "ou defeituosas, iluminação inadequada, eletricidade, riscos de ou explosão, armazenamento"
	oPrintMP:Say( lin + 570, 965, STR0036, oFont08 ) // "inadequado, animais peçonhentos, outras situações."

Return
