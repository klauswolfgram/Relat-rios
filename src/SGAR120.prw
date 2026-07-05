/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "SGAR120.ch"
#Include "Protheus.ch"
#Include "ap5mail.ch"
#Include "FWPrintSetup.ch"
#Include "RPTDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} SGAR120
Inventario Nacional de Residuos Solidos Industriais.

@author  Thiago Olis Machado
@since   10/02/2005

@return  Logico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function SGAR120()
	
	Local oTempTRB

	Private oPrintRes
	Private nPaginaRes := 1
	Private cPerg := "SGR120"

	// Variaveis para Email
	Private aUsuario  := ""
	Private cTitulo
	Private oDlgMail
	Private cDiretorio := ""
	Private x := 1
	Private cBody := ""

	Private cServer   := AllTrim( GetMV( "MV_RELSERV", , " " ) )
	Private cAccount  := AllTrim( GetMV( "MV_RELACNT", , " " ) )
	Private cPassword := AllTrim( GetMV( "MV_RELPSW" , , " " ) )
	Private cUserAut  := AllTrim( GetMV( "MV_RELAUSR", , cAccount ) )  // Usuário para Autenticação no Servidor de Email
	Private cPassAut  := AllTrim( GetMV( "MV_RELAPSW", , cPassword ) ) // Senha para Autenticação no Servidor de Email
	Private lSmtpAuth := GetMv( "MV_RELAUTH", , .F. )

	Private cFrom     := cAccount
	Private cAnexos   := ""
	Private cTo       := Space(200)
	Private cCC       := Space(200)
	Private cSubject  := Space(250)
	Private lOk       := .T.
	Private lAutOk    := .F.

	SetKey( VK_F9, { | | NGVersao( "SGAR120" , 2 ) } )

	// Verica se o UPDSGA13 foi aplicado
	If !SG390CHKDIC()
		Return .T.
	Endif

	cTRB := GetNextAlias()

	aDBFB := {}
	
	Aadd( aDBFB, { "MONIT"   , "C", TamSX3("TCH_MONIT")[1], 0 } )
	Aadd( aDBFB, { "DIA"     , "C", 02, 0 } )
	Aadd( aDBFB, { "MES"     , "C", 02, 0 } )
	Aadd( aDBFB, { "ANO"     , "C", 04, 0 } )
	Aadd( aDBFB, { "HORA"    , "C", TamSX3("TCH_HRCOLE")[1], 0 } )
	Aadd( aDBFB, { "LINHA"   , "C", 02, 0 } )
	Aadd( aDBFB, { "LINHACRI", "C", 04, 0 } )
	Aadd( aDBFB, { "CRITERIO", "C", TamSX3("TCH_CODCRI")[1], 0 } )
	Aadd( aDBFB, { "MEDICAO" , "N", TamSX3("TCH_QUANTI")[1], 4 } )
	Aadd( aDBFB, { "UNIMED"  , "C", TamSX3("TCH_UNIMED")[1], 0 } )
	Aadd( aDBFB, { "CODPLA"  , "C", 06, 0 } )

	oTempTRB := FWTemporaryTable():New( cTRB, aDBFB )
	oTempTRB:AddIndex( "1", {"DIA","MES","ANO","LINHA","CRITERIO"} )
	oTempTRB:AddIndex( "2", {"DIA","MES","ANO","LINHA","LINHACRI","CRITERIO"} )
	oTempTRB:AddIndex( "3", {"MES","ANO"} )
	oTempTRB:AddIndex( "4", {"CRITERIO","ANO","MES","DIA"} )
	oTempTRB:Create()

	nProcessa := 1

	If pergunte(cPerg, .T.)

		If mv_par08 == 3
			nProcessa := ResConfMail()
		EndIf

		If nProcessa == 1
			Processa( { |lEnd| SgR120Imp() } ) // Monta a tela para acompanhamento do processo
		EndIf

	EndIf

	// Deleta arquivo temporário e restaura area
	oTempTRB:Delete()

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SGR120IMP
Realiza o processo de impressão do relatório

@author  Thiago Olis Machado
@since   10/02/2005
/*/
//-------------------------------------------------------------------
Static Function SgR120Imp()
	Local cMesIni, cMesFim, cAnoIni, cAnoFim, cMes
	Local nCntFor,nCntFor2
	Local nPosic
	Local aFornec := {}
	Local aTotMes := {}
	Local aTotCri := {}
	Local nImprimiu := 0
	Local cAliasQry := GetNextAlias()
	Local lFirst	:= .T.

	Private cPrefixo  := "SGR120_" + DtoS(dDatabase) + "_" + StrZero( HtoM( Time() ), 4) + ".PDF"
	Private lin := 0
	Private aCriterio := {}, aLinhaUsad := {}
	Private nDias, cDataIni, cDataFim
	Private cBARRAS  := If(isSRVunix(),"/","\")
	Private cTemp    := GetTempPath() // "C:"+cBARRAS+"Temp"+cBARRAS
	Private cImagens := cTemp+STR0057+cBARRAS // "Objetivos"
	Private lTotCriMes, lTotCriGer, lQtdCriMes, lQtdCriGer

	Private oFont08n := TFont():New("Courier New", ,13,,.T.,,,,.F.,.F.)
	Private oFont09n := TFont():New("Courier New", ,14,,.T.,,,,.F.,.F.)
	Private oFont15  := TFont():New("Courier New", ,20,,.T.,,,,.F.,.F.)

	If mv_par08 == 3 // Envio por email
		// Força a geração de PDF para envio no e-mail
		oPrintRes := FwMsPrinter():New(OemToAnsi( cPrefixo ), IMP_PDF, .T., , .T., , , "PDF", , , ,.F.)
	Else // Impressao
		oPrintRes := FwMsPrinter():New(OemToAnsi(STR0008)) // "Relatório de Medição Mensal"
	EndIf

	oPrintRes:SetPortrait()

	// Verifica Data Inicial
	cMesIni  := AllTrim( StrZero( Val( SubStr( MV_PAR01, 1, 2 ) ), 2 ) )
	cAnoIni  := AllTrim( Str( Val( SubStr( MV_PAR01, 4, 4 ) ) ) )
	cDataIni := cAnoIni + cMesIni + "01"

	// Verifica Data Final
	nMesFim  := Val(SubStr( MV_PAR02, 1, 2 ) )
	nAnoFim  := Val(SubStr( MV_PAR02, 4, 4 ) )
	nDias    := NGDIASMES( nMesFim, nAnoFim )
	cMesFim  := AllTrim(StrZero(Val(SubStr( MV_PAR02, 1, 2 ) ), 2 ) )
	cAnoFim  := AllTrim( Str( Val( SubStr( MV_PAR02, 4, 4 ) ) ) )
	cDataFim := cAnoFim + cMesFim + AllTrim( STR( nDias ) )

	// Fornecedores para impressão, copia da query de busca de resultados - Devido a ação rapida que teve de ser tomada construída lógica desta forma para não comprometer o que já estava desenvolvido - P.O.G.
	cQuery := " SELECT TCH.TCH_FORNEC "
	cQuery += " FROM " + RetSqlName("TCH") + " TCH "//Resultados
	cQuery += " JOIN " + RetSqlName("TCD") + " TCD ON (TCD.TCD_FILIAL = TCH.TCH_FILIAL AND TCD.TCD_CODIGO = TCH.TCH_MONIT AND TCD.TCD_STATUS <> '4' AND TCD.D_E_L_E_T_ <> '*') "//Monitoramento
	cQuery += " JOIN " + RetSqlName("TCC") + " TCC ON (TCC.TCC_FILIAL = TCH.TCH_FILIAL AND TCC.TCC_CODIGO = TCH.TCH_CODCRI AND TCC.D_E_L_E_T_ <> '*') "//Critetrios
	cQuery += " WHERE  TCH.TCH_FILIAL = '" + xFilial("TCH") + "'"
	cQuery += " AND   TCH.TCH_DTCOLE >= '" + cDataIni + "'"
	cQuery += " AND   TCH.TCH_DTCOLE <= '" + cDataFim + "'"
	cQuery += " AND   TCH.TCH_MONIT   = '" + MV_PAR03 + "'"
	cQuery += " AND   TCH.TCH_FORNEC >= '" + MV_PAR04 + "'"
	cQuery += " AND   TCH.TCH_FORNEC <= '" + MV_PAR05 + "'"
	cQuery += " AND   TCH.TCH_CODCRI >= '" + MV_PAR06 + "'"
	cQuery += " AND   TCH.TCH_CODCRI <= '" + MV_PAR07 + "'"
	cQuery += " AND   TCH.TCH_STATUS <> '3' "// Nao pega analises canceladas
	cQuery += " AND   TCH.D_E_L_E_T_ <> '*'"
	cQuery += " GROUP BY TCH.TCH_FORNEC "
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery , cAliasQry )

	dbSelectArea( cAliasQry )

	While ( cAliasQry )->( !Eof() )

		If aScan( aFornec , { | x | x == ( cAliasQry )->TCH_FORNEC } ) == 0
			aAdd( aFornec , ( cAliasQry )->TCH_FORNEC )
		EndIf

		( cAliasQry )->( dbSkip() )
	End

	dbSelectArea( cAliasQry )
	( cAliasQry )->( dbCloseArea() )

	For nCntFor := 1 To Len( aFornec )

		// Carrega TRB
		If U_SGAR120QUE( aFornec[nCntFor] )
			lin := 100
			oPrintRes:StartPage()

			If File("\SIGAADV\LOGO.BMP") //Imprime logotipo da previdencia social
				oPrintRes:SayBitMap(lin,1000,"\SIGAADV\LOGO.BMP",400,130)
			Endif

			oPrintRes:Box(lin+170,50,lin+250,2080)
			oPrintRes:SayAlign(lin+170,50,STR0008,oFont15, 2030, lin+250, , 2, 0) // "Relatório de Medição Mensal"
			// Cabecalho
			oPrintRes:Box(lin+270,50,lin+820,2080)
			oPrintRes:Say(lin+310,60,STR0009+SM0->M0_CODIGO,oFont09n) // "Empresa: "
			oPrintRes:Say(lin+310,650,STR0010+SM0->M0_NOME,oFont09n)  // "Razão Social: "
			SomaLinha(080)
			dbSelectArea("TCD")
			dbSetOrder(1)
			dbSeek(xFilial("TCD")+mv_par03)
			oPrintRes:Say(lin+310,60,STR0045+MV_PAR03+' - '+TCD->TCD_DESCRI,oFont09n) //"Monitotamento: "
			SomaLinha(080)
			oPrintRes:Say(lin+310,60,STR0011+TCD->TCD_FONTE+' - '+NGSEEK("TCB",TCD->TCD_FONTE,1,'TCB_DESCRI'),oFont09n) //"Fonte: "
			SomaLinha(080)
			oPrintRes:Say(lin+310,60,STR0046+TCD->TCD_GRUPO+' - '+NGSEEK("TCA",TCD->TCD_GRUPO,1,'TCA_DESCRI'),oFont09n) //"Grupo: "
			SomaLinha(080)
			oPrintRes:Say(lin+310,60,STR0012+SM0->M0_ENDENT,oFont09n) //"Logradouro: "
			SomaLinha(080)
			oPrintRes:Say(lin+310,60,STR0013+SM0->M0_BAIRENT,oFont09n) //"Bairro: "
			oPrintRes:Say(lin+310,1040,STR0014+SM0->M0_CIDENT,oFont09n) //"Município: "
			oPrintRes:Say(lin+310,1650,STR0015+SubStr(SM0->M0_CEPCOB,1,5)+"-"+SubStr(SM0->M0_CEPCOB,6,3),oFont09n) //"CEP: "
			SomaLinha(080)
			oPrintRes:Say(lin+310,60,STR0016+SM0->M0_TEL,oFont09n) //"Telefone: "

			If !Empty(aFornec[nCntFor])
				oPrintRes:Box(lin+340,50,lin+600,2080)
				SomaLinha(080)
				oPrintRes:Say(lin+310,60,STR0017+aFornec[nCntFor],oFont09n) //"Laboratório: "
				oPrintRes:Say(lin+310,650,STR0018+Substr(NGSEEK("SA2",aFornec[nCntFor],1,'A2_NOME'),1,40),oFont09n) //"Nome: "
				oPrintRes:Say(lin+310,1400,STR0019+MV_PAR01+STR0047+MV_PAR02,oFont09n) //"Data Análise: " //" a "
				SomaLinha(080)
				oPrintRes:Say(lin+310,60,STR0012+NGSEEK("SA2",aFornec[nCntFor],1,'A2_END'),oFont09n) //"Logradouro: "
				SomaLinha(080)
				oPrintRes:Say(lin+310,60,STR0013+NGSEEK("SA2",aFornec[nCntFor],1,'A2_BAIRRO'),oFont09n) //"Bairro: "
				oPrintRes:Say(lin+310,1040,STR0014+NGSEEK("SA2",aFornec[nCntFor],1,'A2_MUN'),oFont09n) //"Município: "
				SomaLinha(110)
			Else
				oPrintRes:Box(lin+340,50,lin+420,2080)
				SomaLinha(80)
				oPrintRes:Say(lin+310,60,STR0058,oFont09n) //"*Resultados coletados pela própria empresa."
				Somalinha(110)
			EndIf

			cMes    := ''
			cCriter := ''
			cUnidad := ''

			SGR120IMG()

			lTotCriMes := 0
			lQtdCriMes := 0
			lTotCriGer := 0
			lQtdCriGer := 0
			lFirst	   := .T.

			ProcRegua( ( Val( cAnoFim ) + Val( cMesFim ) ) - ( Val( cAnoIni ) + Val( cMesIni ) ) )
			// Percorre Meses do periodo informado
			dbSelectArea(cTRB)
			dbSetOrder(4)
			dbGoTop()

			While !Eof()
				IncProc()//Incrementa barra de processamento

				If lFirst
					nImprimiu++
					lFirst := .F.
				EndIF

				If (cCriter <> (cTRB)->CRITERIO) .OR. (cMes <> (cTRB)->MES) .OR. (lin+150 > 2790)
					Somalinha(040)
					SGAR120TOT(cCriter,(cTRB)->CRITERIO,cMes,(cTRB)->MES,lTotCriMes,lTotCriGer,lQtdCriMes,lQtdCriGer,cUnidad,(cTRB)->UNIMED)

					If cCriter <> (cTRB)->CRITERIO
						Somalinha(150)
						oPrintRes:Say(lin+195,65, (cTRB)->CRITERIO+' - '+AllTrim(NGSEEK("TCC",(cTRB)->CRITERIO,1,'TCC_DESCRI')) )
					EndIf

					Somalinha(150)
					//oPrintRes:Say(lin+195,1600,"PLANO DE AÇÃO",oFont09n) //"VALORES DE REFERÊNCIA"
					oPrintRes:Say(lin+195,1100,STR0059,oFont09n) //"VALORES DE REFERÊNCIA"
					oPrintRes:Say(lin+195,65,MesExtenso(Val((cTRB)->MES))+" de "+(cTRB)->ANO,oFont09n)
				EndIf

				cCriter := (cTRB)->CRITERIO
				cMes := (cTRB)->MES
				cUnidad := (cTRB)->UNIMED

				lTotCriMes += (cTRB)->MEDICAO
				lQtdCriMes += 1
				lTotCriGer += (cTRB)->MEDICAO
				lQtdCriGer += 1

				If ( nPosic := aScan( aTotMes , { | x | x[ 1 ] == cCriter } ) ) == 0
					//aAdd( aTotMes , { cCriter , { cMes , (cTRB)->MEDICAO , 1 } } ) )
					aAdd( aTotMes , { cCriter , { { cMes , (cTRB)->MEDICAO , 1 , (cTRB)->UNIMED } } } )
				Else

					If ( nPosic2 := aScan( aTotMes[ nPosic , 2 ] , { | x | x[ 1 ] == cMes } ) ) == 0
						aAdd( aTotMes[ nPosic , 2 ] , { cMes , (cTRB)->MEDICAO , 1 , (cTRB)->UNIMED } )
					Else
						aTotMes[ nPosic , 2 , nPosic2 , 2 ] += (cTRB)->MEDICAO
						aTotMes[ nPosic , 2 , nPosic2 , 3 ] += 1
					EndIf

				EndIf

				If ( nPosic := aScan( aTotCri , { | x | x[ 1 ] == cCriter } ) ) == 0
					aAdd( aTotCri , { cCriter , (cTRB)->MEDICAO , 1 , (cTRB)->UNIMED } )
				Else
					aTotCri[ nPosic , 2 ] += (cTRB)->MEDICAO
					aTotCri[ nPosic , 3 ] += 1
				EndIf

				Somalinha(040)

				lLimMin := ''
				lLimMax := ''
				oPrintRes:Say(lin+240,100,STR0060+(cTRB)->DIA+'/'+(cTRB)->MES+'/'+(cTRB)->ANO+' '+STR0061+; //"Data: "###"Hora: "
								(cTRB)->HORA+'  '+STR0062+AllTrim(Str((cTRB)->MEDICAO)+' '+(cTRB)->UNIMED),oFont09n) //"Resultado: "
				dbSelectArea("TCE")
				dbSetOrder(01)

				If dbSeek(xFilial("TCE")+(cTRB)->MONIT+(cTRB)->CRITERIO)
					lLimMin := AllTrim(Str(TCE->TCE_LIMMIN))
					lLimMax := AllTrim(Str(TCE->TCE_LIMMAX))
					oPrintRes:Say(lin+240,1100,'|| '+lLimMin+' A '+lLimMax+' '+(cTRB)->UNIMED,oFont09n)

					If File(cImagens+"NG_METAS_BAIXO_LEG.PNG") .And. ((cTRB)->MEDICAO < TCE->TCE_LIMMIN .Or. (cTRB)->MEDICAO > TCE->TCE_LIMMAX)
						oPrintRes:SayBitmap(lin+245,65,cImagens+"NG_METAS_BAIXO_LEG.PNG",25,25)
					Endif

					If !Empty((cTRB)->CODPLA)
						SomaLinha(040)
						oPrintRes:Say(lin+240,150,"Plano de Ação" + ": "+(cTRB)->CODPLA + ' - ' + NGSEEK( "TAA" , (cTRB)->CODPLA , 1, "TAA_NOME" ),oFont09n)
					EndIf

				EndIf

				dbSelectArea(cTRB)
				dbSkip()
			End

			SomaLinha(040)
			SGAR120TOT(cCriter,(cTRB)->CRITERIO,cMes,(cTRB)->MES,lTotCriMes,lTotCriGer,lQtdCriMes,lQtdCriGer,cUnidad,(cTRB)->UNIMED)

			Somalinha(040)

			oPrintRes:Say(3100,1170,Str(nPaginaRes,3),oFont09n)

			oPrintRes:EndPage()
		EndIf

	Next nCntFor

	If nImprimiu > 1
		lin := 100
		oPrintRes:StartPage()

		If File("\SIGAADV\LOGO.BMP") //Imprime logotipo da previdencia social
			oPrintRes:SayBitMap(lin,1000,"\SIGAADV\LOGO.BMP",400,130)
		EndIf

		oPrintRes:Box(lin+170,50,lin+250,2080)
		oPrintRes:SayAlign(lin+170,50,STR0008,oFont15, 2030, lin+250, , 2, 0) // "Relatório de Medição Mensal"
		//Cabecalho
		oPrintRes:Box(lin+270,50,lin+820,2080)
		oPrintRes:Say(lin+310,60,STR0009+SM0->M0_CODIGO,oFont09n) //"Empresa: "
		oPrintRes:Say(lin+310,650,STR0010+SM0->M0_NOME,oFont09n) //"Razão Social: "
		SomaLinha(080)
		dbSelectArea("TCD")
		dbSetOrder(1)
		dbSeek(xFilial("TCD")+mv_par03)
		oPrintRes:Say(lin+310,60,STR0045+MV_PAR03+' - '+TCD->TCD_DESCRI,oFont09n) //"Monitotamento: "
		SomaLinha(080)
		oPrintRes:Say(lin+310,60,STR0011+TCD->TCD_FONTE+' - '+NGSEEK("TCB",TCD->TCD_FONTE,1,'TCB_DESCRI'),oFont09n) //"Fonte: "
		SomaLinha(080)
		oPrintRes:Say(lin+310,60,STR0046+TCD->TCD_GRUPO+' - '+NGSEEK("TCA",TCD->TCD_GRUPO,1,'TCA_DESCRI'),oFont09n) //"Grupo: "
		SomaLinha(080)
		oPrintRes:Say(lin+310,60,STR0012+SM0->M0_ENDENT,oFont09n) //"Logradouro: "
		SomaLinha(080)
		oPrintRes:Say(lin+310,60,STR0013+SM0->M0_BAIRENT,oFont09n) //"Bairro: "
		oPrintRes:Say(lin+310,1040,STR0014+SM0->M0_CIDENT,oFont09n) //"Município: "
		oPrintRes:Say(lin+310,1650,STR0015+SubStr(SM0->M0_CEPCOB,1,5)+"-"+SubStr(SM0->M0_CEPCOB,6,3),oFont09n) //"CEP: "
		SomaLinha(080)
		oPrintRes:Say(lin+310,60,STR0016+SM0->M0_TEL,oFont09n) //"Telefone: "
		oPrintRes:Box(lin+340,50,lin+420,2080)
		SomaLinha(80)
		oPrintRes:Say(lin+310,60,"Totais Gerais",oFont09n) //"Totais Gerais"
		Somalinha(110)
		SGR120IMG()
		Somalinha(110)
		oPrintRes:Say(lin+310,60,"Totais por Critério",oFont09n) //"Totais por Critério"

		For nCntFor := 1 To Len( aTotCri )
			Somalinha(150)
			oPrintRes:Say(lin+240,100,PadR( AllTrim( NGSEEK("TCC",aTotCri[ nCntFor , 1 ],1,'TCC_DESCRI') ) + ":" , 41 ) + ;
								STR0065 + "Geral: " + AllTrim(Str(aTotCri[ nCntFor , 2 ]))+ " " + aTotCri[ nCntFor , 4 ]+'  '+; //"Total "
								STR0066 + ": " + AllTrim(Str(aTotCri[ nCntFor , 2 ]/aTotCri[ nCntFor , 3 ])) + " " + aTotCri[ nCntFor , 4 ] ,oFont09n) //"Média "
			Somalinha(100)
			nPosic := aScan( aTotMes , { | x | x[ 1 ] == aTotCri[ nCntFor , 1 ] } )

			If nPosic > 0
				oPrintRes:Say(lin+310,60,"Totais Mensais",oFont09n) //"Totais Mensais"
				Somalinha(100)
				aMeses := aClone( aTotMes[ nPosic , 2 ] )

				For nCntFor2 := 1 To Len( aMeses )
					oPrintRes:Say(lin+240,100,STR0069+ " " + PadR( AllTrim( aMeses[ nCntFor2 , 1 ] ) + ":" , 10 ) + ;
							STR0065 + AllTrim(Str(aMeses[ nCntFor2 , 2 ]))+ " " + aTotCri[ nCntFor , 4 ]+'  '+STR0066+AllTrim(Str(aMeses[ nCntFor2 , 2 ]/aMeses[ nCntFor2 , 3 ])) + " " + aMeses[ nCntFor2 , 4 ] ,oFont09n) //"Total Mês: "###"Média Mês: "
					Somalinha(040)
				Next nCntFor2

			EndIf

		Next nCntFor

		Somalinha(110)

		If mv_par08 == 1
			oPrintRes:Preview()
		ElseIf mv_par08 == 2
			oPrintRes:Print()
		Else
			ResSendMail()
		EndIf

	Else

		If nImprimiu <> 1
			MsgStop(STR0035,STR0021) //"Não existem dados para montar o relatório"###"Atenção"
		Else

			If mv_par08 == 1
				oPrintRes:Preview()
			ElseIf mv_par08 == 2
				oPrintRes:Print()
			Else
				ResSendMail()
			Endif

		EndIf

	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Quebra de linha

@author  Thiago Olis Machado
@since   10/02/05

@sample  Somalinha(080)
@param   _li, Numérico, Espaçamento usado na quebra de linha
@param   [_linha], Lógico, Define se será realizada a quebra de página independente da posição atual
@param   [_pula], Lógico, Define se será impressa uma linha no final da página
/*/
//-------------------------------------------------------------------
Static Function Somalinha(_li, _linha, _pula )

	If _li != nil
		lin += _li
	Else
		lin += 60
	EndIf

	If lin > 2790 .Or. _pula

		If _linha
			oPrintRes:Line(lin+50,50,lin+50,2330)
		Endif

		oPrintRes:Line(lin+245,50,lin+245,2330) // Horizontal

		oPrintRes:Say(3100,1170,Str(nPaginaRes,3),oFont09n)
		oPrintRes:EndPage()
		nPaginaRes++
		oPrintRes:StartPage()
		lin := 60
	EndIf

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ResConfMail
Verifica os parametros do SX6 usados para enviar email.
Exibe janela para o usuario entrar os dados.

@author  Thiago Olis Machado
@since   24/05/2005

@return  Numérico, Define qual opção foi escolhida pelo usuário na tela de envio do e-mail
/*/
//-------------------------------------------------------------------
Static Function ResConfMail()

	Local nOpca := 0

	// Verifica se existe o SMTP Server
	If	Empty(cServer)
		MsgStop(STR0020 ,STR0021) //"O Servidor de SMTP não foi configurado !!!"###"Atenção"
		Return 0
	EndIf

	If lSmtpAuth

		// Verifica se existe a CONTA
		If Empty(cAccount)
			Msgstop(STR0022 ,STR0021) //"A Conta do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

		// Verifica se existe a Senha
		If Empty(cPassword)
			Msgstop(STR0023 ,STR0021) //"A Senha do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

	EndIf

	PswOrder(1)
	PswSeek(__CUSERID,.T.)
	aUsuario := PswRet(1)
	cTitulo := STR0024 //"Dados do E-mail"

	DEFINE MSDIALOG oDlgMail OF oMainWnd FROM 0,0 TO 200,544 PIXEL TITLE cTitulo

		@ 05,04 To 079,268 OF oDlgMail PIXEL
		@ 18,08 Say STR0025    Size 012,08          OF oDlgMail PIXEL // "De: "
		@ 33,08 Say STR0026    Size 016,08          OF oDlgMail PIXEL // "Para:"
		@ 48,08 Say "CC:"      Size 016,08          OF oDlgMail PIXEL
		@ 63,08 Say STR0027    Size 021,08          OF oDlgMail PIXEL // "Assunto:"

		@ 18,33 MSGet cFrom    Size 233,10 When .F. OF oDlgMail PIXEL
		@ 33,33 MSGet cTo      Size 233,10          OF oDlgMail PIXEL
		@ 48,33 MSGet cCC      Size 233,10          OF oDlgMail PIXEL
		@ 63,33 MSGet cSubject Size 233,10          OF oDlgMail PIXEL

		DEFINE SBUTTON FROM 85,100 TYPE 1 ACTION (If(!Empty(cTo),If(oDlgMail:End(),nOpca:=1,nOpca:=1),Help("",1,"AVG0001054"))) ENABLE OF oDlgMail PIXEL
		DEFINE SBUTTON FROM 85,140 TYPE 2 ACTION (oDlgMail:End()) ENABLE OF oDlgMail PIXEL

	ACTIVATE MSDIALOG oDlgMail CENTERED

Return nOpca

//-------------------------------------------------------------------
/*/{Protheus.doc} ResSendMail
Envia email do relatorio

@author  Thiago Olis Machado
@since   24/05/2005

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
Static Function ResSendMail()

	If nProcessa == 1

		cDiretorio := AllTrim(GetNewPar("MV_RELT"," "))
		cAnexos    := ""

		If Empty(cDiretorio)
			cDiretorio := IIf( isSRVunix(), "/", "\" )
		EndIf

		oPrintRes:Print()

		If CpyT2S( oPrintRes:cPathPDF + cPrefixo, cDiretorio )
			cAnexos := cDiretorio + cPrefixo
		Else
			MsgStop( STR0070 + CRLF + STR0071, STR0029) // "Não foi possível gravar o arquivo de anexo do e-mail." ### "Favor configurar o parâmetro MV_RELT." ### "AVISO"
			Return .F.
		EndIf

		cBody  := STR0030 + OemToAnsi( STR0072 ) // "Segue em anexo relatório de " ## "Medição Mensal"

		CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lOk

			If !lAutOk

				If ( lSmtpAuth )
					lAutOk := MailAuth(cUserAut, cPassAut)
				Else
					lAutOk := .T.
				EndIf

			EndIf

			If lOk .And. lAutOk

				If !Empty(cCC)
					SEND MAIL FROM cFrom TO cTo CC cCC SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
				Else
					SEND MAIL FROM cFrom TO cTo SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
				EndIf

				If lOk
					MsgInfo(STR0031) // "Email enviado com sucesso"
				Else
					GET MAIL ERROR cErro
					MsgStop( STR0032 + Chr(13) + Chr(10) + cErro, STR0029 ) // "Não foi possível enviar o Email."###"AVISO"
					Return .F.
				EndIf

			Else
				GET MAIL ERROR cErro
				MsgStop( STR0033 + Chr(13) + Chr(10) + cErro, STR0029 ) // "Erro na conexão com o SMTP Server."###"AVISO"
				Return .F.
			EndIf

		DISCONNECT SMTP SERVER

	EndIf

	If MsgYesNo( STR0034 ) // "Deseja visualizar o relatório?"
		shellExecute("Open", oPrintRes:cPathPDF + cPrefixo, "", "" , 1 )
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SGAR120QUE
Busca os dados das medicoes para imprimir no relatorio

@author  Marcos Wagner Junior
@since   31/03/2008

@sample  U_SGAR120QUE( "01" )
@param   cFornec, Caractere, Código do fornecedor

@return  Lógico, .T. para quando foram recuperados dados pela função
/*/
//-------------------------------------------------------------------
User Function SGAR120QUE( cFornec )
	Local nI := 0
	Local nCont := 0
	Local lRet	:= .T.
	Local lCodPla := NGCADICBASE( "TCH_CODPLA" , "A" , "TCH" , .F. )

	cAliasQry := GetNextAlias()
	cQuery := " SELECT TCH.TCH_DTCOLE, TCH.TCH_HRCOLE, TCH.TCH_QUANTI, TCC.TCC_CODIGO, TCC.TCC_DESCRI, TCH.TCH_MONIT, TCC.TCC_UNIMED "
	If lCodPla
		cQuery += ", TCH.TCH_CODPLA "
	EndIf
	cQuery += " FROM " + RetSqlName("TCH") + " TCH "//Resultados
	cQuery += " JOIN " + RetSqlName("TCD") + " TCD ON (TCD.TCD_FILIAL = TCH.TCH_FILIAL AND TCD.TCD_CODIGO = TCH.TCH_MONIT AND TCD.TCD_STATUS <> '4' AND TCD.D_E_L_E_T_ <> '*') "//Monitoramento
	cQuery += " JOIN " + RetSqlName("TCC") + " TCC ON (TCC.TCC_FILIAL = TCH.TCH_FILIAL AND TCC.TCC_CODIGO = TCH.TCH_CODCRI AND TCC.D_E_L_E_T_ <> '*') "//Critetrios
	cQuery += " WHERE  TCH.TCH_FILIAL = '" + xFilial("TCH") + "'"
	cQuery += " AND   TCH.TCH_DTCOLE >= '"+cDataIni+"'"
	cQuery += " AND   TCH.TCH_DTCOLE <= '"+cDataFim+"'"
	cQuery += " AND   TCH.TCH_MONIT   = '"+MV_PAR03+"'"
	If !Empty(cFornec)
		cQuery += " AND   TCH.TCH_FORNEC  = '"+cFornec+"'"
	Else
		cQuery += " AND   TCH.TCH_FORNEC  = ' ' "
	EndIf
	cQuery += " AND   TCH.TCH_CODCRI >= '"+MV_PAR06+"'"
	cQuery += " AND   TCH.TCH_CODCRI <= '"+MV_PAR07+"'"
	cQuery += " AND   TCH.TCH_STATUS <> '3' "//Nao pega analises canceladas
	cQuery += " AND   TCH.D_E_L_E_T_ <> '*'"
	cQuery += " ORDER BY TCH.TCH_DTCOLE, TCH.TCH_HRCOLE, TCC.TCC_CODIGO "
	cQuery := ChangeQuery(cQuery)
	MPSysOpenQuery( cQuery , cAliasQry )

	dbSelectArea( cTRB )
	ZAP

	dbSelectArea(cAliasQry)
	dbGoTop()

	If !Eof()
		nI := 0

		While !Eof()
			nPOS := ASCAN(aCriterio,{|x| x[1] == (cAliasQry)->TCC_CODIGO})

			If nPOS == 0

				If nI == 11
					nI := 0
				EndIf

				AADD(aCriterio,{(cAliasQry)->TCC_CODIGO,(nI*200)+140,(cAliasQry)->TCC_DESCRI})
				nI++
			EndIf

			cDia   := StrZero(Day(STOD((cAliasQry)->TCH_DTCOLE)),2)
			cMes   := StrZero(Month(STOD((cAliasQry)->TCH_DTCOLE)),2)
			cAno   := AllTrim(Str(Year(STOD((cAliasQry)->TCH_DTCOLE))))
			cLinha := StrZero(Int(IIF(nPOS==0,Len(aCriterio),nPOS)/11)+(IIF(Len(aCriterio)==11,0,1)),2)

			nCont := 1
			dbSelectArea(cTRB)
			dbSetOrder(01)
			dbSeek(cDia+cMes+cAno+cLinha+(cAliasQry)->TCC_CODIGO)

			While !Eof() .And. cDia+cMes+cAno == (cTRB)->DIA+(cTRB)->MES+(cTRB)->ANO .And. (cAliasQry)->TCC_CODIGO = (cTRB)->CRITERIO
				nCont++
				dbSkip()
			End

			RecLock(cTRB,.T.)
			(cTRB)->MONIT    := (cAliasQry)->TCH_MONIT // TamSX3("TCH_MONIT")[1]
			(cTRB)->DIA      := cDia
			(cTRB)->MES      := cMes
			(cTRB)->ANO      := cAno
			(cTRB)->HORA     := (cAliasQry)->TCH_HRCOLE // TamSX3("TCH_HRCOLE")[1]
			(cTRB)->LINHA    := cLinha
			(cTRB)->LINHACRI := AllTrim(StrZero(nCont,4))
			(cTRB)->CRITERIO := (cAliasQry)->TCC_CODIGO // TamSX3("TCH_CODCRI")[1]
			(cTRB)->MEDICAO  := (cAliasQry)->TCH_QUANTI // TamSX3("TCH_QUANTI")[1]
			(cTRB)->UNIMED   := (cAliasQry)->TCC_UNIMED // TamSX3("TCH_UNIMED")[1]

			If lCodPla
				(cTRB)->CODPLA   := (cAliasQry)->TCH_CODPLA
			EndIf

			MsUnlock(cTRB)

			dbSelectArea(cAliasQry)
			dbSkip()
		End

	Else
		lRet := .F.
	Endif

	dbSelectArea(cAliasQry)
	dbCloseArea()

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} SGAR120MES
Valid das perguntas SX1 De/Até Mês/Ano

@author  Marcos Wagner Junior
@since   31/03/2008

@sample  U_SGAR120MES(1)
@param   nOpc, Numérico, Define se está validando De ou Até

@return  Lógico, Define se o valor da pergunta é válido
/*/
//-------------------------------------------------------------------
User Function SGAR120MES(nOpc)
	Local cVar := &(ReadVar())
	Default nOpc := 1

	If NaoVazio()

		If (AT("/",cVar)) > 1 .and. (AT("/",cVar)) < 4
			cMes := SubStr(cVar,1,AT("/",cVar))
			cAno := SubStr(cVar,AT("/",cVar)+1)

			// Valida Mes
			If Val(cMes) < 1 .OR. Val(cMes) > 12
				MsgStop(STR0040,STR0021) //"Mês informado deverá ser maior/igual a '01' e menor/igual a '12'."###"Atenção"
				Return .F.
			EndIf

			// Valida Ano
			If Len(AllTrim(cAno)) != 4
				MsgStop(STR0041,STR0021) //"Ano informado deverá possuir 4 posições."###"Atenção"
				Return .f.
			EndIf

			// Valida De/Ate
			If nOpc == 2
				cMes1 := SubStr(MV_PAR01,1,AT("/",MV_PAR01))
				cAno1 := SubStr(MV_PAR01,AT("/",MV_PAR01)+1)

				If (Val(cMes1) > Val(cMes) .And. Val(cAno1) >= Val(cAno)) .Or. (Val(cAno1) > Val(cAno))
					Help(" ",1,"DEATEINVAL")
					Return .F.
				EndIf

			EndIf

		Else
			Return .F.
		EndIf

	Else
		Return .F.
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SGR120MON
Valid da pergunta SX1 Monitoramento

@author  Roger Rodrigues
@since   18/02/10

@return  Lógico, Define se o valor da pergunta é válido
/*/
//-------------------------------------------------------------------
User Function SGR120MON()

	// Verifica se existe na base
	If ExistCpo('TCD', mv_par03)
		// Verifica se não é cancelado
		dbSelectArea("TCD")
		dbSetOrder(1)
		dbSeek(xFilial("TCD") + mv_par03)

		If TCD->TCD_STATUS == "4"
			ShowHelpDlg( STR0021, {STR0048}, 1, {STR0049} ) //"Atenção"###"O Monitoramento informado está Cancelado."###"Favor informar um Monitoramento Válido."
			Return .F.
		EndIf

	Else
		Return .F.
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SGR120IMG
Extrai imagens

@author  Marcos Wagner Junior
@since   16/01/13

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
Static Function SGR120IMG()
	Local nX
	Local aImagens := {"NG_METAS_BAIXO_LEG.PNG"}

	// Cria Pasta Temp
	If !ExistDir(cTemp)
		MakeDir(cTemp)
	EndIf

	// Cria pasta no Temp
	If !ExistDir(cImagens)
		MakeDir(cImagens)
	EndIf

	For nX := 1 to Len(aImagens)
		// Exclui imagem se ela ja existir no diretorio
		FErase(cImagens+aImagens[nX])

		// Exporta imagens do RPO para a pasta especificada
		Resource2File(aImagens[nX],cImagens+aImagens[nX])
	Next nX

Return .T.


//-------------------------------------------------------------------
/*/{Protheus.doc} SGAR120TOT
Totalizador do relatorio

@author  Marcos Wagner Junior
@since   16/01/13

@sample  SGAR120TOT(cCriter,(cTRB)->CRITERIO,cMes,(cTRB)->MES,lTotCriMes,lTotCriGer,lQtdCriMes,lQtdCriGer,cUnidad,(cTRB)->UNIMED)

@param   lOldCri, Lógico, Código do Criterio
@param   lNewCri, Lógico, Novo critério
@param   lOldMes, Lógico, Mês antigo
@param   lNewMes, Lógico, Mês novo
@param   _lTotCriMes, Lógico, Total de meses
@param   _lTotCriGe, Lógico, Toral de critérios
@param   _lQtdCriMe, Lógico, Média de meses
@param   _lQtdCriGe, Lógico, Média de critérios
@param   cUnidOld, Caractere, Unidade de medida do Critério
@param   cUnidade, Caractere, Unidade de medida do Critério

@return  return_type, return_descr
/*/
//-------------------------------------------------------------------
Static Function SGAR120TOT(lOldCri, lNewCri, lOldMes, lNewMes, _lTotCriMes, _lTotCriGe, _lQtdCriMe, _lQtdCriGe, cUnidOld, cUnidade)

	If ((lOldCri <> lNewCri) .Or. (lOldMes <> lNewMes)) .And. (_lQtdCriMe > 0)
		Somalinha(040)
		oPrintRes:Say(lin+240,100,STR0063+AllTrim(Str(_lTotCriMes))+' '+cUnidOld+'  '+STR0064+AllTrim(Str(_lTotCriMes/_lQtdCriMe))+' '+cUnidOld,oFont09n) //"Total Mês: "###"Média Mês: "
		lTotCriMes := 0
		lQtdCriMes := 0

		If (lOldCri <> lNewCri)
			Somalinha(080)
			oPrintRes:Say(lin+240,100,STR0065+AllTrim(NGSEEK("TCC",lOldCri,1,'TCC_DESCRI'))+': '+AllTrim(Str(_lTotCriGe))+' '+cUnidOld+' '+; //"Total "
								STR0066+AllTrim(NGSEEK("TCC",lOldCri,1,'TCC_DESCRI'))+': '+AllTrim(Str(_lTotCriGe/_lQtdCriGe))+' '+cUnidOld,oFont09n) //"Média "
			lTotCriGer := 0
			lQtdCriGer := 0
		EndIf

	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} SGR120VLD
Validação de SX1

@return Lógico - Retorna verdadeiro caso validação esteja correta

@param nVal - Indica o SX1 a ser validado.
				5 - Até Laboratório

@sample
U_SGR120VLD( 5 )

@author Jackson Machado
@since 22/11/2013
/*/
//---------------------------------------------------------------------
User Function SGR120VLD( nVal )
	Local lRet := .T.

	If nVal == 5
		lRet := If(empty(mv_par05) .Or. atecodigo('SA2',mv_par04,mv_par05,06),.t.,.f.)
	EndIf

Return lRet
