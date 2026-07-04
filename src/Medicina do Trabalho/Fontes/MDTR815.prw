/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR815.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha

Relatorio da projeção para troca dos EPI's dos Funcionarios.
O usuario seleciona o periodo desejado, podera selecionar   
resultado a relacao de Funcionarios programado para receber 
determinado EPI. O programa inicia lendo a tabela de EPI,s  
entregues (TNF), para cada EPI, verifica a data da ultima   
retirada deste epi e calcula com base na durabilidade a data
provavel para a substituicao.   

@return nulo

@sample U_MDTR815()

@author Marcio Costa
@since 12/01/2000
/*/
//---------------------------------------------------------------------
User Function MDTR815()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local wnrel   := "MDTR815"
	Local cDesc1  := STR0001 //"Relatorio de  projecao para substituicao dos EPI's. Atraves dos parametros o    "
	Local cDesc2  := STR0002 //"usuario deve informar o per¡odo desejado e se desejar o EPI, o programa mostrara"
	Local cDesc3  := STR0003 //"uma relacao com os EPI's por Funcionario e a data da Proxima Substituicao.      "
	Local cString := "TNF"

	Private nomeprog := "MDTR815"
	Private tamanho  := "G"
	Private aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   := STR0006 //"Projecao para substituicao dos EPI's"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := ""
	Private cabec1, cabec2
	Private nSizeSA2 := If( (TAMSX3("A2_COD")[1]) < 1, 6, (TAMSX3("A2_COD")[1]) )
	Private nSizeSRJ := If( (TAMSX3("RJ_FUNCAO")[1]) < 1, 4, (TAMSX3("RJ_FUNCAO")[1]) )
	Private nSizeSI3 := If( (TAMSX3("I3_CUSTO")[1]) < 1, 20, (TAMSX3("I3_CUSTO")[1]) )
	Private nSizeCod := If( (TAMSX3("B1_COD")[1]) < 1,20,(TAMSX3("B1_COD")[1]))
	Private nSizeFil := FwSizeFilial()
	Private cTRB := GetNextAlias()
	//Private cARQTtnf
	Private lNumCap := NGCADICBASE("TNF_NUMCAP","A","TNF",.F.)
	Private oTempTRB

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
	cPerg    := If(!lSigaMdtps,"MDT815    ","MDT815PS  ")
	
	/*PERGUNTAS PADRÃO
	MDT815    ¦01      ¦De  EPI ?			
	MDT815    ¦02      ¦Ate EPI ?			
	MDT815    ¦03      ¦De  Data ?			
	MDT815    ¦04      ¦Ate Data ?			
	MDT815    ¦05      ¦De  Funcao ?		
	MDT815    ¦06      ¦Ate Funcao ?		
	MDT815    ¦07      ¦Classificacao ?	
	MDT815    ¦08      ¦Ordenar Func.?		
	MDT815    ¦09      ¦Situação do EPI ?	
													
	//PREGUNTAS PRESTADOR DE SERVIÇO			
	MDT815    ¦01      ¦De Cliente ?		
	MDT815    ¦02      ¦Loja					
	MDT815    ¦03      ¦Até Cliente ?		
	MDT815    ¦04      ¦Loja					
	MDT815    ¦05      ¦De  EPI ?			
	MDT815    ¦06      ¦Ate EPI ?			
	MDT815    ¦07      ¦De  Data ?			
	MDT815    ¦08      ¦Ate Data ?			
	MDT815    ¦09      ¦De  Funcao ?		
	MDT815    ¦10      ¦Ate Funcao ?		
	MDT815    ¦11      ¦Classificacao ?	
	MDT815    ¦12      ¦Ordenar Func.?		
	MDT815    ¦13      ¦Situação do EPI ?	
	*/

	// Verifica as perguntas selecionadas
	If FindFunction("TRepInUse") .And. TRepInUse()
		
		// Verifica as perguntas selecionadas
		Pergunte(cPerg,.F.)

		// Personalizado - Interface de impressao	
		oReport := ReportDef( AllTrim( titulo) )
		oReport:SetLandscape()
		oReport:PrintDialog()
	Else

		// Verifica as perguntas selecionadas
		Pergunte(cPerg,.F.)

		// Envia controle para a funcao SETPRINT
		wnrel:="MDTR815"
		wnrel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

		If nLastKey == 27
			Set Filter to	
			// Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
			Return
		Endif

		SetDefault(aReturn,cString)

		RptStatus({|lEnd| R815IMP(@lEnd,wnRel,titulo,tamanho)},titulo)

	EndIf
	
	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Chamada do relatório

@param lEnd,wnRel,titulo,tamanho
@return nulo

@sample R815IMP(lEnd,wnRel,titulo,tamanho)

@author Inacio Luiz Kolling
@since 01/06/1997
/*/
//---------------------------------------------------------------------
Static Function R815IMP(lEnd,wnRel,titulo,tamanho)
	
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local cCliente := ""
	Local cCodFil := ""

	// Variaveis locais exclusivas deste programa
	Local lImp := .T.
	Local nTamMat := TAMSX3("RA_MAT")[1]

	// Variaveis tipo Private padrao de todos os relatorios	
	// Contadores de linha e pagina

	Private li := 80, m_pag := 1
	Private dDTFIM := cTOD("  /  /  ")
	Private cHorFim := ""
	Private aVETINR := {}  //Usado na criacao do arquivo temporario
	Private aEpi := {}
	Private aEpiDes := {}

	// Variaveis locais exclusivas deste programa
	Private cFicAnt := SPACE( 9 )

	// Verifica se deve comprimir ou nao
	nTipo := IIF( aReturn[4] == 1, 15, 18)

	/*/
	************************************************************************************************************************************
	*<empresa>                                                                                                        Folha..: xxxxx   *
	*SIGA /<nome .04                                 <Proje‡ao para substitui‡ao dos EPI's>                           DT.Ref.: dd/mm/aa*
	*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
	************************************************************************************************************************************
			1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6       7           8         9         0         1         2
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	Matricula  Nome Funcionario                           Sexo    Admissao  Idade  C.Custo               Funcao Entrega                    Funcao Atual
		EPI                             Nome do EPI                          Dt.Entrega  Hr.Entr. Qtde Ent. Un. Dt.Substit. Hr.Subst. Fornecedor                                   Epi deve ser:

	xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx      99/99/99   999   xxxxxxxx              xxxx - xxxxxxxxxxxxxxxxxxxx       xxxx - xxxxxxxxxxxxxxxxxxxx
		xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999  99:99      xxxx,xx xx  99/99/9999  99:99     xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx
		xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999  99:99      xxxx,xx xx  99/99/9999  99:99     xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx
		xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999  99:99      xxxx,xx xx  99/99/9999  99:99     xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx
		xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  99/99/9999  99:99      xxxx,xx xx  99/99/9999  99:99     xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxx
	=====================================================================================================================================
			1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	EPI             Nome do EPI                                   Fornecedor                                                "
		Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo               Funcao Entrega      Funcao Atual         Epi deve ser:

	xxxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99   999  xxxxxxxxxxxxxxxxxxxx  xxxxx - xxxxxxxxxx  xxxxx - xxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99   999  xxxxxxxxxxxxxxxxxxxx  xxxxx - xxxxxxxxxx  xxxxx - xxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99   999  xxxxxxxxxxxxxxxxxxxx  xxxxx - xxxxxxxxxx  xxxxx - xxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99   999  xxxxxxxxxxxxxxxxxxxx  xxxxx - xxxxxxxxxx  xxxxx - xxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
	====================================================================================================================================
			1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6       7           8         9         0         1         2
	012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	EPI             Nome do EPI                                   Fornecedor
		Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo    Funcao Atual    					Epi deve ser:

	Funcao - xxxx - xxxxxxxxxxxxxxxxxxxx                                                          admi

	xxxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99   999  xxxxxxxxx  xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99    99  xxxxxxxxx	xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99    99  xxxxxxxxx	xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx
		xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx    99/99/9999  99:99      xxxx,xx xx   99/99/99  99:99     99/99/99    99  xxxxxxxxx	xxxx - xxxxxxxxxxxxxxxxxxxxxxxxxx	xxxxxxxxxxxxxxxxxxxx

	============================================================================================
	/*/

	If lSigaMdtps
		
		// Montagem da tabela temporária
		MDT815TRB(1)

		dbSelectArea(cTRB)
		dbSetOrder(mv_par12)
		dbGoTop()

		If Empty((cTRB)->EPI)
			MsgStop(STR0038) //"Não existem dados para montar o relatório."
			lImp := .F.
		Endif

		If mv_par11 == 1

			While !Eof()
				cCliente := (cTRB)->CLIENT+(cTRB)->LOJACL
				Somalinha()
				@Li,000 PSAY STR0017 + (cTRB)->CLIENT + "-" + (cTRB)->LOJACL + " - " + (cTRB)->NOMECLI PICTURE "@!" //"Cliente/Loja: "
				Somalinha()

				dbSelectArea( cTRB )
				While !eof() .and. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL
					cMAT := (cTRB)->MATRICULA
					Somalinha()
					@Li,000 PSAY (cTRB)->MATRICULA PICTURE "999999"

					dbSelectArea( "SRA" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SRA") + (cTRB)->MATRICULA )
					@Li,011 PSAY SRA->RA_NOME    PICTURE "@!"
					@Li,054 PSAY SRA->RA_SEXO    PICTURE "@!"
					@Li,062 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
					@Li,073 PSAY (cTRB)->IDADE
					@Li,079 PSAY SRA->RA_CC

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SRJ") + (cTRB)->FUNCAO )
					@Li,110 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SRJ->RJ_DESC PICTURE "@!"

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SRJ") + SRA->RA_CODFUNC )
					@Li,145 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SRJ->RJ_DESC PICTURE "@!"

					dbSelectArea( cTRB )
					While ! eof() .and. (cTRB)->MATRICULA == cMAT .and. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL

						Somalinha()
						@Li,005 PSAY (cTRB)->EPI PICTURE "@!"

						dbSelectArea( "SB1" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SB1") + (cTRB)->EPI )
						@Li,037 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"
						@Li,074 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
						@Li,086 PSAY (cTRB)->HORAENTR PICTURE "99:99"
						@Li,097 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
						@Li,105 PSAY SB1->B1_UM

						@Li,109 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
						@Li,121 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

						dbSelectArea( "SA2" )
						dbSetOrder( 1 )
						dbSeek( xFilial( "SA2" ) + (cTRB)->FORNEC )
						@Li,131 PSAY SubSTR( Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME, 1,35) PICTURE "@!"

						If mv_par13 == 3
							nScan := aSCAN(aEpi, {|x| x[2]+x[3]+x[4] == cCliente + (cTRB)->MATRICULA + (cTRB)->EPI })
							If nScan > 0
								If aEpi[nScan,5] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .AND. aScan(aEpiDes,{|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + (cTRB)->CLIENT + (cTRB)->LOJACL + (cTRB)->MATRICULA + (cTRB)->EPI .and. x[5] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
									If (cTRB)->DTSUBIST > dDatabase
										@Li,175 PSAY STR0053//"A SUBSTITUIR"
									Else
										@Li,175 PSAY STR0051//"SUBSTITUIR"
									EndIf
								Else
									If (cTRB)->DTSUBIST > dDatabase
										@Li,175 PSAY STR0054//"A DEVOLVER"
									Else
										@Li,175 PSAY STR0052//"DEVOLVER"
									EndIf
								Endif
							Else
								@Li,175 PSAY STR0047 //Epi não encontrado
							Endif
						Endif

						dbSelectArea( cTRB )
						dbSkip()
					End
					SomaLinha()
				End
				Somalinha()
				@Li,000 pSay __PrtThinLine()
			End

		ElseIf mv_par11 == 2

			While !EOF()
				cCliente := (cTRB)->CLIENT+(cTRB)->LOJACL
				Somalinha()
				@Li,000 PSAY STR0017 + (cTRB)->CLIENT + "-" + (cTRB)->LOJACL + " - " + (cTRB)->NOMECLI PICTURE "@!" //"Cliente/Loja: "
				Somalinha()

				dbSelectArea( cTRB )
				While !eof() .and. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL

					cEPI := (cTRB)->EPI
					SomaLinha()
					@Li,000 PSAY (cTRB)->EPI PICTURE "@!"

					dbSelectArea( "SB1" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SB1") + (cTRB)->EPI )
					@Li,032 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"

					dbSelectArea( "SA2" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SA2") + (cTRB)->FORNEC )
					@Li,070 PSAY Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME PICTURE "@!"
					dbSelectArea(cTRB)
					While !eof() .and. cEPI == (cTRB)->EPI .and. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL
						SomaLinha()
						@Li,005 PSAY (cTRB)->MATRICULA PICTURE Replicate("9",nTamMat)

						dbSelectArea( "SRA" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SRA") + (cTRB)->MATRICULA )
						@Li,016 PSAY SRA->RA_NOME PICTURE "@!"
						@Li,059 PSAY SRA->RA_SEXO PICTURE "@!"
						@Li,065 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
						@Li,077 PSAY (cTRB)->HORAENTR PICTURE "99:99"
						@Li,088 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
						@Li,096 PSAY SB1->B1_UM

						@Li,100 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
						@Li,111 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

						dbSelectArea( "SRA" )
						dbSetOrder( 1 )
						dbSEEK( xFilial("SRA") + (cTRB)->MATRICULA )
						@Li,121 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
						@Li,132 PSAY If(!Empty((cTRB)->IDADE), (cTRB)->IDADE, "-") PICTURE "999" //YEAR( DATE() ) - YEAR( SRA->RA_NASC ) PICTURE "999"
						@Li,137 PSAY SRA->RA_CC

						dbSelectArea( "SRJ" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SRJ") + (cTRB)->FUNCAO )
						@Li,159 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SubStr(SRJ->RJ_DESC,1,10) PICTURE "@!"

						dbSelectArea( "SRJ" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SRJ") + SRA->RA_CODFUNC )
						@Li,179 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SubStr(SRJ->RJ_DESC,1,10) PICTURE "@!"

						If mv_par13 == 3
							nScan := aSCAN(aEpi, {|x| x[2]+x[3]+x[4] == cCliente + (cTRB)->MATRICULA + (cTRB)->EPI })
							If nScan > 0
								If aEpi[nScan,5] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .AND. aScan(aEpiDes,{|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + (cTRB)->CLIENT + (cTRB)->LOJACL + (cTRB)->MATRICULA + (cTRB)->EPI .and. x[5] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
									If (cTRB)->DTSUBIST > dDatabase
										@Li,200 PSAY STR0053//"A SUBSTITUIR"
									Else
										@Li,200 PSAY STR0051//"SUBSTITUIR"
									EndIf
								Else
									If (cTRB)->DTSUBIST > dDatabase
										@Li,200 PSAY STR0054//"A DEVOLVER"
									Else
										@Li,200 PSAY STR0052//"DEVOLVER"
									EndIf
								Endif
							Else
								@Li,200 PSAY STR0047 //Epi não encontrado
							Endif
						Endif

						dbSelectArea( cTRB )
						dbSkip()
					End
					Somalinha()
				End
				Somalinha()
				@Li,000 pSay __PrtThinLine()
			End

		ElseIf mv_par11 == 3

			While !EOF()
				cCliente := (cTRB)->CLIENT+(cTRB)->LOJACL
				Somalinha()
				@Li,000 PSAY STR0017 + (cTRB)->CLIENT + "-" + (cTRB)->LOJACL + " - " + (cTRB)->NOMECLI PICTURE "@!" //"Cliente/Loja: "
				Somalinha()

				dbSelectArea( cTRB )
				While !eof() .and. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL

					cFUNCAO := (cTRB)->FUNCAO
					SomaLinha()
					@Li,000 PSAY STR0013 PICTURE "@!" //"Funcao - "

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( xFilial("SRJ") + (cTRB)->FUNCAO )
					@Li,017 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SRJ->RJ_DESC PICTURE "@!"

					Dbselectarea( cTRB )
					While ! EoF() .AND. (cTRB)->FUNCAO == cFUNCAO .AND. cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL

						SomaLinha()
						SomaLinha()
						@Li,000 PSAY (cTRB)->EPI PICTURE "@!"

						dbSelectArea( "SB1" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SB1") + (cTRB)->EPI )
						@Li,032 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"

						dbSelectArea( "SA2" )
						dbSetOrder( 1 )
						dbSeek( xFilial("SA2") + (cTRB)->FORNEC )
						@Li,070 PSAY Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME PICTURE "@!"
						cEPI := (cTRB)->EPI

						dbSelectArea( cTRB )
						While !EoF() .AND. ( (cTRB)->EPI == cEPI ) .AND. ( (cTRB)->FUNCAO == cFUNCAO ) .AND. ( cCliente == (cTRB)->CLIENT+(cTRB)->LOJACL )
							Somalinha()
							@Li,005 PSAY (cTRB)->MATRICULA PICTURE Replicate("9",nTamMat)

							dbSelectArea( "SRA" )
							dbSetOrder( 1 )
							dbSeek( xFilial("SRA") + (cTRB)->MATRICULA )
							@Li,016 PSAY SRA->RA_NOME PICTURE "@!"
							@Li,059 PSAY SRA->RA_SEXO PICTURE "@!"
							@Li,065 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
							@Li,077 PSAY (cTRB)->HORAENTR PICTURE "99:99"
							@Li,088 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
							@Li,096 PSAY SB1->B1_UM

							@Li,100 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
							@Li,111 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

							dbSelectArea( "SRA" )
							dbSetOrder( 1 )
							dbSeek( xFilial("SRA") + (cTRB)->MATRICULA )
							@Li,121 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
							@Li,132 PSAY If(!Empty((cTRB)->IDADE), (cTRB)->IDADE, "-") PICTURE "999"//YEAR( DATE() ) - YEAR( SRA->RA_NASC ) PICTURE "999"
							@Li,137 PSAY SRA->RA_CC

							dbSelectArea("SRJ")
							dbSetOrder(1)
							dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC )
							@Li,162 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SRJ->RJ_DESC PICTURE "@!"

							If mv_par13 == 3
								nScan := aSCAN(aEpi, {|x| x[2]+x[3]+x[4] == cCliente + (cTRB)->MATRICULA + (cTRB)->EPI })
								If nScan > 0
									If aEpi[nScan,5] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .AND. aScan(aEpiDes,{|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + (cTRB)->CLIENT + (cTRB)->LOJACL + (cTRB)->MATRICULA + (cTRB)->EPI .and. x[5] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
										If (cTRB)->DTSUBIST > dDatabase
											@Li,194 PSAY STR0053//"A SUBSTITUIR"
										Else
											@Li,194 PSAY STR0051//"SUBSTITUIR"
									EndIf
									Else
										If (cTRB)->DTSUBIST > dDatabase
											@Li,194 PSAY STR0054//"A DEVOLVER"
										Else
											@Li,194 PSAY STR0052//"DEVOLVER"
										EndIf
									Endif
								Else
									@Li,194 PSAY STR0047// Epi não encontrado
								Endif
							Endif

							dbSelectArea( cTRB )
							dbSkip()
						End
						Somalinha()
					End
					Somalinha()
				End
				Somalinha()
				@Li,000 pSay __PrtThinLine()
			End

		EndIf

	Else

		// Montagem da tabela temporária
		MDT815TRB(1)

		dbSelectArea( cTRB )
		dbSetOrder(mv_par10)
		dbGoTop()

		If Empty((cTRB)->EPI)
			MsgStop(STR0038) //"Não existem dados para montar o relatório."
			lImp := .F.
		Endif

		If mv_par07 == 1 .and. lImp

			While !Eof()
				cCodFil := (cTRB)->FILIAL
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay STR0039+": "+AllTrim((cTRB)->FILIAL)+" - "+AllTrim((cTRB)->NOMFIL) //"Filial"
					Somalinha()
					Somalinha()
				Endif

				dbSelectArea( cTRB )
				While !eof() .and. cCodFil == (cTRB)->FILIAL
					cMAT := (cTRB)->MATRICULA
					Somalinha()
					@Li,000 PSAY (cTRB)->MATRICULA PICTURE Replicate("9",nTamMat)

					dbSelectArea("SRA")
					dbSetOrder(1)
					dbSeek(U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )
					@Li,011 PSAY (cTRB)->NOMEFUN    PICTURE "@!"
					@Li,054 PSAY SRA->RA_SEXO    PICTURE "@!"
					@Li,062 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
					@Li,073 PSAY If(!Empty((cTRB)->IDADE), (cTRB)->IDADE, "-") PICTURE "999"//YEAR( DATE() ) - YEAR( SRA->RA_NASC ) PICTURE "999"
					@Li,079 PSAY SRA->RA_CC

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + (cTRB)->FUNCAO )
					@Li,100 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SRJ->RJ_DESC PICTURE "@!"

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + SRA->RA_CODFUNC )
					@Li,135 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SRJ->RJ_DESC PICTURE "@!"

					dbSelectArea( cTRB )
					While ! eof() .and. (cTRB)->MATRICULA == cMAT .and. cCodFil == (cTRB)->FILIAL

						Somalinha()
						@Li,005 PSAY (cTRB)->EPI PICTURE "@!"

						dbSelectArea("SB1")
						dbSetOrder(1)
						dbSeek(U_MDTR815FIL("SB1",(cTRB)->FILIAL)+(cTRB)->EPI )
						@Li,037 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"
						@Li,074 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
						@Li,086 PSAY (cTRB)->HORAENTR PICTURE "99:99"
						@Li,097 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
						@Li,105 PSAY SB1->B1_UM

						@Li,112 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
						@Li,124 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

						dbSelectArea("SA2")
						dbSetOrder(1)
						dbSeek(U_MDTR815FIL( "SA2",(cTRB)->FILIAL) + (cTRB)->FORNEC )
						@Li,136 PSAY SubSTR( Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME, 1,35) PICTURE "@!"
					If mv_par11 == 3
							nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
							If nScan > 0
								If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
									If (cTRB)->DTSUBIST > dDatabase
										@Li,173 PSAY STR0053//"A SUBSTITUIR"
									Else
										@Li,173 PSAY STR0051//"SUBSTITUIR"
									EndIf
								Else
									If (cTRB)->DTSUBIST > dDatabase
										@Li,173 PSAY STR0054//"A DEVOLVER"
									Else
										@Li,173 PSAY STR0052//"DEVOLVER"
									EndIf
								Endif
							Else
								@Li,175 PSAY STR0047 //Epi não encontrado
							Endif
						Endif

						dbSelectArea( cTRB )
						dbSkip()
					End

					SomaLinha()
				End
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay __PrtThinLine()
				Endif
			End
		ElseIf mv_par07 == 2 .and. lImp

			While !EOF()
				cCodFil := (cTRB)->FILIAL
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay STR0039+": "+AllTrim((cTRB)->FILIAL)+" - "+AllTrim((cTRB)->NOMFIL) //"Filial"
					Somalinha()
					Somalinha()
				Endif

				dbSelectArea( cTRB )
				While !eof() .and. cCodFil == (cTRB)->FILIAL

					cEPI := (cTRB)->EPI
					SomaLinha()
					@Li,000 PSAY (cTRB)->EPI PICTURE "@!"

					dbSelectArea( "SB1" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SB1",(cTRB)->FILIAL) + (cTRB)->EPI )
					@Li,032 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"

					dbSelectArea( "SA2" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SA2",(cTRB)->FILIAL) + (cTRB)->FORNEC )
					@Li,070 PSAY Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME PICTURE "@!"

					dbSelectArea( cTRB )
					While !eof() .and. cCodFil == (cTRB)->FILIAL .and. (cTRB)->EPI == cEPI
						SomaLinha()
						@Li,005 PSAY (cTRB)->MATRICULA PICTURE Replicate("9",nTamMat)

						dbSelectArea( "SRA" )
						dbSetOrder( 1 )
						dbSeek( U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )
						@Li,016 PSAY (cTRB)->NOMEFUN PICTURE "@!"
						@Li,059 PSAY SRA->RA_SEXO PICTURE "@!"
						@Li,065 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
						@Li,077 PSAY (cTRB)->HORAENTR PICTURE "99:99"
						@Li,088 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
						@Li,096 PSAY SB1->B1_UM

						@Li,105 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
						@Li,117 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

						dbSelectArea( "SRA" )
						dbSetOrder( 1 )
						dbSEEK( U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )
						@Li,129 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
						@Li,141 PSAY If(!Empty((cTRB)->IDADE), (cTRB)->IDADE, "-") PICTURE "999"//YEAR( DATE() ) - YEAR( SRA->RA_NASC ) PICTURE "999"
						@Li,146 PSAY SRA->RA_CC

						dbSelectArea( "SRJ" )
						dbSetOrder( 1 )
						dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + (cTRB)->FUNCAO )
						@Li,159 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SubStr(SRJ->RJ_DESC,1,10) PICTURE "@!"

						dbSelectArea( "SRJ" )
						dbSetOrder( 1 )
						dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + SRA->RA_CODFUNC )
						@Li,175 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SubStr(SRJ->RJ_DESC,1,10) PICTURE "@!"

						If mv_par11 == 3
							nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
							If nScan > 0
								If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
									If (cTRB)->DTSUBIST > dDatabase
										@Li,196 PSAY STR0053//"A SUBSTITUIR"
									Else
										@Li,196 PSAY STR0051//"SUBSTITUIR"
									EndIf
								Else
									If (cTRB)->DTSUBIST > dDatabase
										@Li,196 PSAY STR0054//"A DEVOLVER"
									Else
										@Li,196 PSAY STR0052//"DEVOLVER"
									EndIf
								Endif
							Else
								@Li,200 PSAY STR0047 //Epi não encontrado
							Endif
						Endif

						dbSelectArea( cTRB )
						dbSkip()
					End
					Somalinha()
				End
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay __PrtThinLine()
				Endif
			End

		ElseIf mv_par07 == 3 .and. lImp

			While !Eof()
				cCodFil := (cTRB)->FILIAL
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay STR0039+": "+AllTrim((cTRB)->FILIAL)+" - "+AllTrim((cTRB)->NOMFIL) //"Filial"
					Somalinha()
					Somalinha()
				Endif

				dbSelectArea( cTRB )
				While !eof() .and. cCodFil == (cTRB)->FILIAL
					cFUNCAO := (cTRB)->FUNCAO
					SomaLinha()
					@Li,000 PSAY STR0013 PICTURE "@!" //"Funcao - "

					dbSelectArea("SRJ")
					dbSetOrder(1)
					dbSeek(U_MDTR815FIL("SRJ",(cTRB)->FILIAL)+(cTRB)->FUNCAO )
					@Li,017 PSAY Alltrim((cTRB)->FUNCAO) + " - " + SRJ->RJ_DESC PICTURE "@!"

					Dbselectarea( cTRB )
					While ! EoF() .AND. (cTRB)->FUNCAO == cFUNCAO .and. cCodFil == (cTRB)->FILIAL

						SomaLinha()
						SomaLinha()
						@Li,000 PSAY (cTRB)->EPI PICTURE "@!"

						dbSelectArea("SB1")
						dbSetOrder(1)
						dbSeek(U_MDTR815FIL("SB1",(cTRB)->FILIAL) + (cTRB)->EPI )
						@Li,032 PSAY SubStr( SB1->B1_DESC, 1, 30 ) PICTURE "@!"

						dbSelectArea("SA2")
						dbSetOrder(1)
						dbSeek(U_MDTR815FIL("SA2",(cTRB)->FILIAL) + (cTRB)->FORNEC )
						@Li,070 PSAY Alltrim((cTRB)->FORNEC) + " - " + SA2->A2_NOME PICTURE "@!"
						cEPI := (cTRB)->EPI

						dbSelectArea( cTRB )
						While !EoF() .AND. ( (cTRB)->EPI == cEPI ) .AND. ( (cTRB)->FUNCAO == cFUNCAO ) .and. cCodFil == (cTRB)->FILIAL

							SomaLinha()
							@Li,005 PSAY (cTRB)->MATRICULA PICTURE Replicate("9",nTamMat)

							dbSelectArea("SRA")
							dbSetOrder(1)
							dbSeek(U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )
							@Li,016 PSAY (cTRB)->NOMEFUN PICTURE "@!"
							@Li,059 PSAY SRA->RA_SEXO PICTURE "@!"
							@Li,065 PSAY (cTRB)->DATAENTR PICTURE "99/99/99"
							@Li,077 PSAY (cTRB)->HORAENTR PICTURE "99:99"
							@Li,088 PSAY (cTRB)->QUANT PICTURE "@E 999.99"
							@Li,096 PSAY SB1->B1_UM

							@Li,105 PSAY (cTRB)->DTSUBIST PICTURE "99/99/99"
							@Li,117 PSAY (cTRB)->HRSUBIST PICTURE "99:99"

							@Li,129 PSAY SRA->RA_ADMISSA PICTURE "99/99/99"
							@Li,140 PSAY If(!Empty((cTRB)->IDADE), (cTRB)->IDADE, "-") PICTURE "999"// YEAR( DATE() ) - YEAR( SRA->RA_NASC ) PICTURE "999"
							@Li,144 PSAY SRA->RA_CC

							dbSelectArea("SRJ")
							dbSetOrder(1)
							dbSeek(U_MDTR815FIL("SRJ",(cTRB)->FILIAL)+SRA->RA_CODFUNC )
							@Li,171 PSAY Alltrim(SRA->RA_CODFUNC) + " - " + SRJ->RJ_DESC PICTURE "@!"

							If mv_par11 == 3
								nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
								If nScan > 0
									If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
										If (cTRB)->DTSUBIST > dDatabase
											@Li,203 PSAY STR0053//"A SUBSTITUIR"
										Else
											@Li,203 PSAY STR0051 //"SUBSTITUIR"
										EndIf
									Else
										If (cTRB)->DTSUBIST > dDatabase
											@Li,203 PSAY STR0054 //"A DEVOLVER"
										Else
											@Li,203 PSAY STR0052 //"DEVOLVER"
										EndIf
									Endif
								Else
									@Li,203 PSAY STR0047 //Epi não encontrado
								Endif
						Endif

							dbSelectArea( cTRB )
							dbSkip()
						End
						Somalinha()
					End
					Somalinha()
				End
				If NGSX2MODO("TNF") != "C"
					Somalinha()
					@Li,000 pSay __PrtThinLine()
				Endif
			End

		EndIf

	Endif

	Roda(nCntImpr,cRodaTxt,Tamanho)

	
	// Devolve a condicao original do arquivo principal
	RetIndex("TNF")

	Set Filter To

	If lImp
		Set device to Screen

		If aReturn[5] = 1
			Set Printer To
			dbCommitAll()
			OurSpool(wnrel)
		Endif
	Endif

	MS_FLUSH()

	oTempTRB:Delete()

	dbSelectArea( "TNF" )
	dbSetOrder( 01 )

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Deleta do TRB se ha um registro posterior de entrega

@return nulo

@sample SomaLinha()

@author Inacio Luiz Kolling
@since 01/06/1997
/*/
//---------------------------------------------------------------------
Static Function Somalinha()

	Li++
	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} fDelTrb
Deleta do TRB se ha um registro posterior de entrega

@return nulo

@sample fDelTrb()

@author Jackson Machado
@since 05/09/2011
/*/
//---------------------------------------------------------------------
Static Function fDelTrb()
	
	Local nPar := mv_par11
	Local nRec := (cTrb)->(RECNO())
	
	If lSigaMdtPs
		nPar := mv_par13
		aSort(aEpiDes,,,{|x,y| x[1]+x[2]+x[3]+x[4]+x[5] < y[1]+y[2]+y[3]+y[4]+y[5]})
		dbSelectArea(cTrb)
		dbGoTop()
		While !eof()
			If nPar == 1
				If aScan(aEpiDes,{|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + (cTRB)->CLIENT + (cTRB)->LOJACL + (cTRB)->MATRICULA + (cTRB)->EPI .and. x[5] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) > 0
					RecLock(cTrb,.F.)
					dbDelete()
					MsUnLock(cTrb)
				Endif
			Elseif nPar == 3
				If (cTRB)->INDDEV != "1"
					If aScan(aEpiDes,{|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + (cTRB)->CLIENT + (cTRB)->LOJACL + (cTRB)->MATRICULA + (cTRB)->EPI .and. x[5] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) > 0
						RecLock(cTrb,.F.)
						dbDelete()
						MsUnLock(cTrb)
					Endif
				Endif
			Endif
			dbSelectArea(cTrb)
			dbSkip()
		End
	Else
		aSort(aEpiDes,,,{|x,y| x[1]+x[2]+x[3]+x[4] < y[1]+y[2]+y[3]+y[4]})
		dbSelectArea(cTrb)
		dbGoTop()
		While !eof()
			If nPar == 1
				If aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) > 0
					RecLock(cTrb,.F.)
					dbDelete()
					MsUnLock(cTrb)
				Endif
			Elseif nPar == 3
				If (cTRB)->INDDEV != "1"
					If aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) > 0
						RecLock(cTrb,.F.)
						dbDelete()
						MsUnLock(cTrb)
					Endif
				Endif
			Endif
			dbSelectArea(cTrb)
			dbSkip()
		End
	Endif
	dbSelectArea(cTrb)
	dbGoTo(nRec)

Return
//---------------------------------------------------------------------
/*/ {Protheus.doc} MDTR815FIL
Trata do retorno do xFilial para que seja equivalente ao tamanho do
campo da filial.

@author Lucas Guszak
@since 16/08/13
@version MP11
@return Nil
/*/
//---------------------------------------------------------------------
User Function MDTR815FIL(cAliasxF, cFilialxF)

	cFilPar := "" // Recebe a filial do retorno

	If Len(xFilial(cAliasxF,cFilialxF)) == Len(cFilialxF) //Se o tamanho do retorno da função xFilial for igual ao campo da filial
		cFilPar := xFilial(cAliasxF,cFilialxF) //Retorna o valor integral da função
	Else //Se o tamanho do retorno da função xFilial for diferente ao campo da filial
		cFilPar := SubStr(xFilial(cAliasxF,cFilialxF),1,Len(cFilialxF))	//Retorna o valor relativo ao tamanho da filial
	EndIf

Return cFilPar

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT815TRB
Realiza a montagem da TRB de impressão.

@sample MDT815TRB()
@param nTipo - Recebe o tipo de relatório 1 - Padrão, 2 - Personalizado

@author Guilherme Freudenburg
@since 12/07/2016
@return .T.
/*/
//---------------------------------------------------------------------
Static Function MDT815TRB(nTipo)

	Local cEPITN3 := ""
	Local cNUMCAP := ""
	Local aDBFtnf := {}
	Local nTa1 	  := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
	Local nTa1L   := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
	Local nTamMat := TAMSX3("RA_MAT")[1]
	Local nRet 	  := 0
	Local i 	  := 0
	Local nAfast  := 0
	Local nDurac  := 0

	Default nTipo := 1

	If lSigaMdtps
	//Definicao dos campos do arquivo temporario
		aDBFtnf :=	{ 	{ "CLIENT"    , "C", nTa1		, 0 },;
						{ "LOJACL"    , "C", nTa1L		, 0 },;
						{ "NOMECLI"   , "C", 40			, 0 },;
						{ "MATRICULA" , "C", nTamMat	, 0 },;
						{ "EPI"       , "C", nSizeCod	, 0 },;
						{ "DATAENTR"  , "D", 08			, 0 },;
						{ "HORAENTR"  , "C", 05			, 0 },;
						{ "DTSUBIST"  , "D", 08			, 0 },;
						{ "HRSUBIST"  , "C", 05			, 0 },;
						{ "FORNEC"    , "C", nSizeSA2	, 0 },;
						{ "FUNCAO"    , "C", nSizeSRJ	, 0 },;
						{ "QUANT"     , "N", 06			, 2 },;
						{ "NOMEFUN"   , "C", 40			, 0 },;
						{ "SITUAC"  	, "C", 10			, 0 },;
						{ "SEXO"  		, "C", 01			, 0 },;
						{ "IDADE"  	, "N", 03			, 0 },;
						{ "INDDEV"		, "C", 01			, 0 } }

		oTempTRB := FWTemporaryTable():New( cTRB, aDBFtnf )
		
		If mv_par11 == 1  //Classificacao: Matricula x EPI
			oTempTRB:AddIndex( "1", {"CLIENT","LOJACL","MATRICULA","EPI","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"CLIENT","LOJACL","NOMEFUN","MATRICULA","EPI","DATAENTR","HORAENTR"} )

			dbSelectArea( "TNF" )
			dbSetOrder( 07 )  //TNF_FILIAL+TNF_CLIENT+TNF_LOJACL+TNF_CODEPI
			dbSeek( xFilial( "TNF" ) + MV_PAR01 + MV_PAR02 + MV_PAR05, .T.)
			cCONDIT := "TNF->TNF_FILIAL == xFIlial('TNF') .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODEPI >= MV_PAR01+MV_PAR02+MV_PAR05 .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODEPI <= MV_PAR03+MV_PAR04+MV_PAR06"
			cabec1 := STR0018 //"Matricula  Nome Funcionário                           Sexo    Admissão Idade  C.Custo                         Função Entrega                     Função Atual"
			If mv_par13 == 3
				cabec2 := STR0048 //"     EPI                             Nome do EPI                          Dt.Entrega  Hr.Entr. Qtde Ent. Un. Dt.Substit. Hr.Subst. Fornecedor                                   Situação"
			Else
				cabec2 := STR0008 //"     EPI                             Nome do EPI                          Dt.Entrega  Hr.Entr. Qtde Ent. Un. Dt.Substit. Hr.Subst. Fornecedor"
			Endif
			cContrb  := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_MAT + TNF->TNF_CODEPI + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
			cContrb2 := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_MAT + TNF->TNF_CODEPI"
		
		ElseIf mv_par11 == 2  //Classificacao: EPI x Matricula
			oTempTRB:AddIndex( "1", {"CLIENT","LOJACL","EPI","MATRICULA","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"CLIENT","LOJACL","EPI","NOMEFUN","MATRICULA","DATAENTR","HORAENTR"} )

			dbSelectArea( "TNF" )
			dbSetOrder( 07 )  //TNF_FILIAL+TNF_CLIENT+TNF_LOJACL+TNF_CODEPI
			dbSeek( xFilial( "TNF" ) + MV_PAR01 + MV_PAR02 + MV_PAR05, .T.)
			cCONDIT := "TNF->TNF_FILIAL == xFIlial('TNF') .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODEPI >= MV_PAR01+MV_PAR02+MV_PAR05 .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODEPI <= MV_PAR03+MV_PAR04+MV_PAR06"
			cabec1 := STR0009 //"EPI                               Nome do EPI                                   Fornecedor                                                "
			If mv_par13 = 3
				cabec2 := STR0049 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo               Funcao Entrega      Funcao Atual         Situação"
			Else
				cabec2 := STR0031 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo               Funcao Entrega      Funcao Atual"
			Endif
			cContrb  := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_CODEPI + TNF->TNF_MAT + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
			cContrb2 := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_CODEPI + TNF->TNF_MAT"
		
		ElseIf MV_PAR11 == 3  //Classificacao: Funcao x EPI
			oTempTRB:AddIndex( "1", {"CLIENT","LOJACL","FUNCAO","EPI","MATRICULA","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"CLIENT","LOJACL","FUNCAO","EPI","NOMEFUN","MATRICULA","DATAENTR","HORAENTR"} )

			dbSelectArea( "TNF" )
			dbSetOrder( 09 )  //TNF_FILIAL+TNF_CLIENT+TNF_LOJACL+TNF_CODFUN
			dbSeek( xFilial("TNF") + MV_PAR01 + MV_PAR02 + MV_PAR09,.T. )
			cCONDIT := "TNF->TNF_FILIAL == xFIlial('TNF') .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODFUN >= MV_PAR01 + MV_PAR02 + MV_PAR09 .AND. TNF->TNF_CLIENT+TNF->TNF_LOJACL+TNF->TNF_CODFUN <= MV_PAR03 + MV_PAR04 + MV_PAR10"
			cabec1 := STR0009 //"EPI                               Nome do EPI                                   Fornecedor                                                "
			If mv_par13 = 3
				cabec2 := STR0050 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo                  Funcao Atual                    Situação"
			Else
				cabec2 := STR0011 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo                  Funcao Atual"
			Endif
			cContrb  := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_CODFUN + TNF->TNF_CODEPI + TNF->TNF_MAT + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
			cContrb2 := "TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_CODFUN + TNF->TNF_CODEPI + TNF->TNF_MAT"
		
		EndIf

		oTempTRB:Create()

		If nTipo == 1
			SetRegua( LastRec() )
		EndIf

		While !Eof() .AND. &cCONDIT

			If nTipo == 1
				IncRegua()
			EndIf

			dbSelectArea( "SRA" )   //Funcionarios demitidos nao precisam mais receber EPI
			dbSetOrder(1)
			dbSeek( xfilial( "SRA" ) + TNF->TNF_MAT )
			If ( SRA->RA_SITFOLH == "D" ) .OR. ( !Empty(SRA->RA_DEMISSA) )
				dbSelectArea( "TNF" )
				dbSkip()
				Loop
			Endif

			cEPI := TNF->TNF_CODEPI
			cMAT := TNF->TNF_MAT

			If ( TNF->TNF_CODEPI < MV_PAR05 ) .OR. ( TNF->TNF_CODEPI > MV_PAR06 )
				dbSelectArea( "TNF" )
				dbSkip()
				Loop
			Endif

			dbSelectArea( "TN3" )
			If lNumCap//TNF->( FieldPos("TNF_NUMCAP") ) > 0
				dbSetOrder(5)  //TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_FORNEC+TN3_LOJA+TN3_CODEPI+TN3_NUMCAP
				dbSeek( xFilial("TN3") + TNF->( TNF_CLIENT + TNF_LOJACL + TNF_FORNEC + TNF_LOJA + TNF_CODEPI +TNF_NUMCAP ) )
			Else
				dbSetOrder( 4 )  //TN3_FILIAL+TN3_CLIENT+TN3_LOJACL+TN3_CODEPI+TN3_NUMCAP
				dbSeek( xFilial("TN3") + TNF->( TNF_CLIENT + TNF_LOJACL ) + cEPI )
			EndIf

			If mv_par13 == 2 .AND. TN3->TN3_INDEVO != "1"
				dbSelectArea( "TNF" )
				dbSkip()
				Loop
			Endif

			If TN3->TN3_DURABI == 0
				dbSelectArea("TNF")
				dbSkip()
				Loop
			Else
				If TN3->TN3_TPDURA == "U"
					
					nAfast := 0
				
					dbSelectArea( "SR8" )
					dbSetOrder( 1 )//R8_FILIAL+R8_MAT+DTOS(R8_DATAINI)
					If dbSeek( xFilial( "SR8" ) + cMAT )
				
						While !Eof() .And. xFilial( "SR8" ) == SR8->R8_FILIAL .And.;
							cMat == SR8->R8_MAT .And. SR8->R8_DATAINI <= dDataBase

							If ( Empty( SR8->R8_DATAFIM ) .Or. SR8->R8_DATAFIM > TNF->TNF_DTENTR )

								If SR8->R8_DATAINI >= TNF->TNF_DTENTR .And. !Empty(SR8->R8_DATAFIM)
									nAfast += ( SR8->R8_DATAFIM - SR8->R8_DATAINI ) 
								ElseIf SR8->R8_DATAFIM >= TNF->TNF_DTENTR .And. SR8->R8_DATAINI <= TNF->TNF_DTENTR
									nAfast += ( SR8->R8_DATAFIM - TNF->TNF_DTENTR )
								ElseIf Empty( SR8->R8_DATAFIM )
									nAfast := 0
									nDurac := SR8->R8_DURACAO
								EndIf

							EndIf
							("SR8")->(dbSkip())
						End
					EndIf
				EndIf

				If nAfast == 0 .And. nDurac == 999
					dDTFIM := cTOD("  /  /  ")
					cHorFim := ""	
				Else
					dDTFIM := TNF->TNF_DTENTR + nAfast + TN3->TN3_DURABI
					cHorFim := TNF->TNF_HRENTR
				
					If ( dDTFIM  > MV_PAR08 ) .OR. ( dDTFIM < MV_PAR07 )
						aAdd(aEpiDes, { xFilial("TNF"),;
										TNF->TNF_CLIENT + TNF->TNF_LOJACL,;
										TNF->TNF_MAT,;
										TNF->TNF_CODEPI,;
										DTOS(dDTFIM)+cHorFim;
									} )
						
						dbSelectArea( "TNF" )
						dbSkip()
						Loop
					Endif
				EndIf
			EndIf

			If ( TNF->TNF_CODFUN < MV_PAR09 ) .OR. ( TNF->TNF_CODFUN > MV_PAR10 )
				dbSelectArea( "TNF" )
				dbSkip()
				Loop
			Endif

			If mv_par13 == 2 .AND. TNF->TNF_INDDEV == "1"
				dbSelectArea( "TNF" )
				dbSkip()
				loop
			EndIf

			dbSelectArea( cTRB )
			dbSetOrder( 01 )

			If mv_par13 == 1
				cContrb3 := cContrb2
			Else
				If TN3->TN3_INDEVO != "1"
					cContrb3 := cContrb2
				Else
					cContrb3 := cContrb
				Endif
			Endif

			If !dbSeek( &cContrb3 )
				(cTRB)->( DbAppend() )
				(cTRB)->CLIENT	  := TNF->TNF_CLIENT
				(cTRB)->LOJACL	  := TNF->TNF_LOJACL
				(cTRB)->NOMECLI	  := NGSEEK("SA1",TNF->TNF_CLIENT+TNF->TNF_LOJACL,1,"SA1->A1_NOME")
				(cTRB)->MATRICULA := TNF->TNF_MAT
				(cTRB)->EPI		  := TNF->TNF_CODEPI
				(cTRB)->DATAENTR  := TNF->TNF_DTENTR
				(cTRB)->HORAENTR  := TNF->TNF_HRENTR
				(cTRB)->DTSUBIST  := dDTFIM
				(cTRB)->HRSUBIST  := cHorFim
				(cTRB)->FORNEC	  := TNF->TNF_FORNEC
				(cTRB)->FUNCAO	  := TNF->TNF_CODFUN
				(cTRB)->IDADE	  := YEAR( DATE() ) - YEAR( SRA->RA_NASC ) //Calcula Idade
				(cTRB)->QUANT	  := TNF->TNF_QTDENT
				(cTRB)->NOMEFUN	  := SRA->RA_NOME
				(cTRB)->SEXO	  := SRA->RA_SEXO
				(cTRB)->INDDEV	  := TN3->TN3_INDEVO
			Else
				If (cTRB)->DTSUBIST  < dDTFIM
					Reclock( cTRB, .F. )
					(cTRB)->DATAENTR := TNF->TNF_DTENTR
					(cTRB)->HORAENTR := TNF->TNF_HRENTR
					(cTRB)->DTSUBIST := dDTFIM
					(cTRB)->HRSUBIST := cHorFim
					(cTRB)->FORNEC	 := TNF->TNF_FORNEC
					(cTRB)->FUNCAO	 := TNF->TNF_CODFUN
					(cTRB)->QUANT	 := TNF->TNF_QTDENT
					(cTRB)->INDDEV	 := TN3->TN3_INDEVO
					MsUnlock(cTRB)
				EndIf
			EndIf

			nRet := 0
			If mv_par13 == 3
				If aSCAN(aEpi, {|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_MAT + TNF->TNF_CODEPI }) == 0
					aAdd(aEpi, {xFilial("TNF"),TNF->TNF_CLIENT + TNF->TNF_LOJACL, TNF->TNF_MAT, TNF->TNF_CODEPI, DTOS(dDTFIM)+cHorFim})
					nRet := 0
				Else
				nRet := aSCAN(aEpi, {|x| x[1]+x[2]+x[3]+x[4] == xFilial("TNF") + TNF->TNF_CLIENT + TNF->TNF_LOJACL + TNF->TNF_MAT + TNF->TNF_CODEPI })
				Endif
			Endif

			If nRet > 0 .And. aEpi[nRet,5] < DTOS(dDTFIM)+cHorFim
				aEpi[nRet,5] := DTOS(dDTFIM)+cHorFim
			Endif

			dbSelectArea( "TNF" )
			DbSkip()
		End

		If mv_par13 == 1 .or. mv_par13 == 3
			fDelTrb()
		Endif

	Else

		aFiliais := MDTRETFIL("TNF", MV_PAR08, MV_PAR09)

		//Definicao dos campos do arquivo temporario
		aDBFtnf :=	{ 	{ "MATRICULA" , "C", nTamMat	, 0 },;
						{ "EPI"       , "C", nSizeCod	, 0 },;
						{ "DATAENTR"  , "D", 08			, 0 },;
						{ "HORAENTR"  , "C", 05			, 0 },;
						{ "DTSUBIST"  , "D", 08			, 0 },;
						{ "HRSUBIST"  , "C", 05			, 0 },;
						{ "FORNEC"    , "C", nSizeSA2	, 0 },;
						{ "FORDES"    , "C", 40			, 0 },;
						{ "FUNCAO"    , "C", nSizeSRJ	, 0 },;
						{ "FUNDES"    , "C", 20			, 0 },;
						{ "QUANT"     , "N", 06			, 2 },;
						{ "FILIAL"    , "C", nSizeFil	, 0 },;
						{ "NOMFIL"    , "C", 40			, 0 },;
						{ "NOMEFUN"   , "C", 40			, 0 },;
						{ "SITUAC"  	, "C", 10			, 0 },;
						{ "SEXO"  		, "C", 02			, 0 },;
						{ "IDADE"  	, "N", 03			, 0 },;
						{ "INDDEV"    , "C", 01			, 0 }}

		oTempTRB := FWTemporaryTable():New( cTRB, aDBFtnf )
		If mv_par07 == 1//Classificacao: Matricula x EPI
			oTempTRB:AddIndex( "1", {"FILIAL","MATRICULA","EPI","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"FILIAL","NOMEFUN","MATRICULA","EPI","DATAENTR","HORAENTR"} )
		ElseIf mv_par07 == 2  //Classificacao: EPI x Matricula
			oTempTRB:AddIndex( "1", {"FILIAL","EPI","MATRICULA","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"FILIAL","EPI","NOMEFUN","MATRICULA","DATAENTR","HORAENTR"} )
		ElseIf MV_PAR07 == 3  //Classificacao: Funcao x EPI
			oTempTRB:AddIndex( "1", {"FILIAL","FUNCAO","EPI","MATRICULA","DATAENTR","HORAENTR"} )
			oTempTRB:AddIndex( "2", {"FILIAL","FUNCAO","EPI","NOMEFUN","MATRICULA","DATAENTR","HORAENTR"} )
		EndIf
		oTempTRB:Create()

		If nTipo == 1
			SetRegua(Len(aFiliais))
		EndIf

		For i:=1 to Len(aFiliais)
			If mv_par07 == 1//Classificacao: Matricula x EPI

				dbSelectArea("TNF")
				dbSetOrder(02)
				dbSeek(U_MDTR815FIL("TNF",aFiliais[i,1])+MV_PAR01, .T.)
				cCONDIT := "TNF->TNF_CODEPI <= MV_PAR02"
				cabec1 := STR0007 //"Matricula  Nome Funcionario                           Sexo    Admissao  Idade  C.Custo               Funcao Entrega                    Funcao Atual"
				If mv_par11 == 3
					cabec2 := STR0048 //"     EPI                             Nome do EPI                          Dt.Entrega  Hr.Entr. Qtde Ent. Un. Dt.Substit. Hr.Subst. Fornecedor                                   Situação"
				Else
					cabec2 := STR0008 //"     EPI                             Nome do EPI                          Dt.Entrega  Hr.Entr. Qtde Ent. Un. Dt.Substit. Hr.Subst. Fornecedor"
				Endif
				cContrb := "TNF->TNF_FILIAL + TNF->TNF_MAT + TNF->TNF_CODEPI + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
				cContrb2:= "TNF->TNF_FILIAL + TNF->TNF_MAT + TNF->TNF_CODEPI"
			ElseIf mv_par07 == 2  //Classificacao: EPI x Matricula

				dbSelectArea("TNF")
				dbSetOrder(02)
				dbSeek(U_MDTR815FIL("TNF",aFiliais[i,1])+MV_PAR01, .T. )
				cCONDIT := "TNF->TNF_CODEPI <= MV_PAR02"
				cabec1 := STR0009 //"EPI             Nome do EPI                                   Fornecedor                                                "
				If mv_par11 = 3
					cabec2 := STR0049 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo               Funcao Entrega      Funcao Atual         Situação"
				Else
					cabec2 := STR0031 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo               Funcao Entrega      Funcao Atual"
				Endif
				cContrb := "TNF->TNF_FILIAL + TNF->TNF_CODEPI + TNF->TNF_MAT + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
				cContrb2:= "TNF->TNF_FILIAL + TNF->TNF_CODEPI + TNF->TNF_MAT"
			ElseIf MV_PAR07 == 3  //Classificacao: Funcao x EPI

				dbSelectArea("TNF")
				dbSetOrder(04)
				dbSeek(U_MDTR815FIL("TNF",aFiliais[i,1])+MV_PAR05,.T. )
				cCONDIT := "TNF->TNF_CODFUN <= MV_PAR06"
				cabec1 := STR0009 //"EPI             Nome do EPI                                   Fornecedor                                                "
				If mv_par11 = 3
					cabec2 := STR0050 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo    Funcao Atual    					Situação"
				Else
					cabec2 := STR0011 //"     Matricula  Nome Funcionario                           Sexo  Dt.Entrega  Hr.Entr. Qtde Ent. Un   Dt.Subs.  Hr.Subst. Admissao Idade  C.Custo    Funcao Atual"
				Endif
				cContrb := "TNF->TNF_FILIAL + TNF->TNF_CODFUN + TNF->TNF_CODEPI + TNF->TNF_MAT + DTOS(TNF->TNF_DTENTR) + TNF->TNF_HRENTR"
				cContrb2:= "TNF->TNF_FILIAL + TNF->TNF_CODFUN + TNF->TNF_CODEPI + TNF->TNF_MAT"
			EndIf

			If nTipo == 1
				IncRegua()
			EndIf

			While !Eof() .AND. TNF->TNF_FILIAL == U_MDTR815FIL("TNF",aFiliais[i,1]) .and. &cCONDIT
				dbSelectArea("SRA")   //Funcionarios demitidos nao precisam mais receber EPI
				dbSetOrder(1)
				dbSeek(U_MDTR815FIL("SRA",aFiliais[i,1]) + TNF->TNF_MAT )
				If ( SRA->RA_SITFOLH == "D" ) .OR. ( !Empty(SRA->RA_DEMISSA) )
					dbSelectArea( "TNF" )
					dbSkip()
					Loop
				Endif

				cEPI := TNF->TNF_CODEPI
				cMAT := TNF->TNF_MAT

				If ( TNF->TNF_CODEPI < MV_PAR01 ) .OR. ( TNF->TNF_CODEPI > MV_PAR02 )
					dbSelectArea( "TNF" )
					dbSkip()
					Loop
				Endif

				cEPITN3 := "" //Código do EPI utilizado para busca na TN3
				cNUMCAP := "" //Numero de CA do EPI utilizado para busca na TN3

				//Verifica se o EPI é um epi filho
				dbSelectArea("TL0")
				dbSetOrder(2) //TL0_FILIAL + TL0_EPIFIL
				//Se for, busca na TN3 com código do EPI Pai
				If MsSeek( U_MDTR815FIL("TL0",aFiliais[i,1]) + cEPI ) .AND. TL0->TL0_NUMCAP == TNF->TNF_NUMCAP
					cEPITN3 := TL0->TL0_EPIGEN
					cNUMCAP := ""
				Else //Se não, utiliza as informações da TNF
					cEPITN3 := TNF->TNF_CODEPI
					cNUMCAP := TNF->TNF_NUMCAP
				EndIf

				dbSelectArea( "TN3" )
				If lNumCap//TNF->( FieldPos("TNF_NUMCAP") ) > 0
					dbSetOrder(1)
					dbSeek( U_MDTR815FIL("TN3",aFiliais[i,1]) + TNF->( TNF_FORNEC + TNF_LOJA ) + cEPITN3 + cNUMCAP )
				Else
					dbSetOrder( 2 )
					dbSeek( U_MDTR815FIL("TN3",aFiliais[i,1]) + cEPI )
				EndIf


				If mv_par11 == 2 .AND. TN3->TN3_INDEVO != "1"
					dbSelectArea( "TNF" )
					dbSkip()
					Loop
				Endif


				If TN3->TN3_DURABI == 0
					dbSelectArea( "TNF" )
					dbSkip()
					Loop
				Else

					If TN3->TN3_TPDURA == "U"
					
						nAfast := 0
					
						dbSelectArea( "SR8" )
						dbSetOrder( 1 )//R8_FILIAL+R8_MAT+DTOS(R8_DATAINI)
						If dbSeek( xFilial( "SR8" ) + cMAT )
					
							While !Eof() .And. xFilial( "SR8" ) == SR8->R8_FILIAL .And.;
								cMat == SR8->R8_MAT .And. SR8->R8_DATAINI <= dDataBase

								If ( Empty( SR8->R8_DATAFIM ) .Or. SR8->R8_DATAFIM > TNF->TNF_DTENTR )

									If SR8->R8_DATAINI >= TNF->TNF_DTENTR .And. !Empty(SR8->R8_DATAFIM)
										nAfast += ( SR8->R8_DATAFIM - SR8->R8_DATAINI ) 
									ElseIf SR8->R8_DATAFIM >= TNF->TNF_DTENTR .And. SR8->R8_DATAINI <= TNF->TNF_DTENTR
										nAfast += ( SR8->R8_DATAFIM - TNF->TNF_DTENTR )
									ElseIf Empty( SR8->R8_DATAFIM )
										nAfast := 0
										nDurac := SR8->R8_DURACAO
									EndIf
								EndIf
								("SR8")->(dbSkip())
							End
						EndIf
					EndIf

					If nAfast == 0 .And. nDurac == 999
						dDTFIM := cTOD("  /  /  ")
						cHorFim := ""	
					Else
						dDTFIM := TNF->TNF_DTENTR + nAfast + TN3->TN3_DURABI
						cHorFim := TNF->TNF_HRENTR
					
						If ( dDTFIM  > MV_PAR04 ) .OR. ( dDTFIM < MV_PAR03 )
							aAdd(aEpiDes, { xFilial("TNF"),;
											TNF->TNF_MAT,;
											TNF->TNF_CODEPI,;
											DTOS(dDTFIM)+cHorFim;
										} )
							dbSelectArea( "TNF" )
							dbSkip()
							Loop	
						EndIf
					EndIf
				EndIf

				If ( TNF->TNF_CODFUN < MV_PAR05 ) .OR. ( TNF->TNF_CODFUN > MV_PAR06 )
					dbSelectArea( "TNF" )
					dbSkip()
					Loop
				Endif

				If TNF->TNF_INDDEV == "1"
					dbSelectArea( "TNF" )
					dbSkip()
					loop
				EndIf

				dbSelectArea( cTRB )
				dbSetOrder( 01 )

				If mv_par11 == 1
					cContrb3 := cContrb2
				Else
					If mv_par11 == 3 .AND. TN3->TN3_INDEVO != "1"
						cContrb3 := cContrb2
					Else
						cContrb3 := cContrb
					Endif
				Endif

				If !dbSeek( &cContrb3 )
					Reclock( cTRB, .T. )
					(cTRB)->MATRICULA	:= TNF->TNF_MAT
					(cTRB)->EPI			:= TNF->TNF_CODEPI
					(cTRB)->DATAENTR	:= TNF->TNF_DTENTR
					(cTRB)->HORAENTR	:= TNF->TNF_HRENTR
					(cTRB)->DTSUBIST	:= dDTFIM
					(cTRB)->HRSUBIST	:= cHorFim
					(cTRB)->FORNEC		:= TNF->TNF_FORNEC
					(cTRB)->FORDES		:= Alltrim(Posicione("SA2",1,xFilial("SA2")+TNF->TNF_FORNEC,"A2_NOME"))
					(cTRB)->FUNCAO		:= TNF->TNF_CODFUN
					(cTRB)->FUNDES		:= Alltrim(Posicione("SRJ",1,xFilial("SRJ")+TNF->TNF_CODFUN,"RJ_DESC"))
					(cTRB)->QUANT		:= TNF->TNF_QTDENT
					(cTRB)->FILIAL		:= TNF->TNF_FILIAL
					(cTRB)->NOMFIL		:= aFiliais[i,2]
					(cTRB)->IDADE		:= If(Empty(SRA->RA_NASC), 0, YEAR( DATE() ) - YEAR( SRA->RA_NASC )) //Calcula Idade
					(cTRB)->NOMEFUN		:= SRA->RA_NOME
					(cTRB)->SEXO		:= SRA->RA_SEXO
					(cTRB)->INDDEV		:= TN3->TN3_INDEVO
					MsUnlock(cTRB)
				Else
					If (cTRB)->DTSUBIST  < dDTFIM
						Reclock( cTRB, .F. )
						(cTRB)->DATAENTR	:= TNF->TNF_DTENTR
						(cTRB)->HORAENTR	:= TNF->TNF_HRENTR
						(cTRB)->DTSUBIST	:= dDTFIM
						(cTRB)->HRSUBIST	:= cHorFim
						(cTRB)->FORNEC	:= TNF->TNF_FORNEC
						(cTRB)->FORDES	:= Alltrim(Posicione("SA2",1,xFilial("SA2")+TNF->TNF_FORNEC,"A2_NOME"))
						(cTRB)->FUNCAO	:= TNF->TNF_CODFUN
						(cTRB)->FUNDES	:= Alltrim(Posicione("SRJ",1,xFilial("SRJ")+TNF->TNF_CODFUN,"RJ_DESC"))
						(cTRB)->QUANT		:= TNF->TNF_QTDENT
						(cTRB)->INDDEV	:= TN3->TN3_INDEVO
						MsUnlock(cTRB)
					EndIf
				EndIf
				nRet := 0
				If mv_par11 == 3
					If aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == U_MDTR815FIL("TNF",(cTRB)->FILIAL) + TNF->TNF_MAT + TNF->TNF_CODEPI }) == 0
						aAdd(aEpi, {U_MDTR815FIL("TNF",(cTRB)->FILIAL), TNF->TNF_MAT, TNF->TNF_CODEPI, DTOS(dDTFIM)+cHorFim})
					Else
					nRet := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == U_MDTR815FIL("TNF",(cTRB)->FILIAL) + TNF->TNF_MAT + TNF->TNF_CODEPI })
					Endif
				Endif

				If nRet > 0 .And. aEpi[nRet,4] < DTOS(dDTFIM)+cHorFim
					aEpi[nRet,4] := DTOS(dDTFIM)+cHorFim
					nRet := 0
				Endif

				dbSelectArea( "TNF" )
				DbSkip()
			End
		Next i

		If mv_par11 == 1 .or. mv_par11 == 3
			fDelTrb()
		Endif
	EndIf

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define as seções impressas no relatorio

@return oReport Objeto Objeto do TReport

@param cDescric Caracter Descrição do relatório

@sample ReportDef( 'Descrição' )

@author Guilherme Freudenburg
@since 01/07/2016
/*/
//---------------------------------------------------------------------
Static Function ReportDef( cDescric )

	Local nSizeSRA := TAMSX3("RA_MAT")[1]

	Private cTRB := GetNextAlias()
	//Private cARQTtnf

	Static oReport
	Static oSection0, oSection1, oSection2, oSection3, oSection4, oSection5
	Static oCell0, oCell1, oCell2, oCell3, oCell4, oCell5

	oReport := TReport():New( "MDTR815" , OemToAnsi( titulo ) , AllTrim( cPerg ) , { | oReport | ReportPrint( oReport ) } , ;
								cDescric )

	//-------------------- Secao 0 - Filial
	oSection0 := TRSection():New( oReport, STR0076, { cTRB } )//Filial
	oCell0 := TRCell():New( oSection0, "FILIAL" , cTRB , STR0039 , "@!", nSizeFil, /*lPixel*/, { | | (cTRB)->FILIAL } ) //"Filial"
	oCell0 := TRCell():New( oSection0, "NOMFIL" , cTRB , STR0034 , "@!", 32 ,	 /*lPixel*/, { | | (cTRB)->NOMFIL  } )	 //"Nome"

	//-------------------- Secao 1 - Funcionário
	oSection1 := TRSection():New( oReport, STR0077, { cTRB, "SRA" } )//Funcionários
		oCell1 := TRCell():New( oSection1, "MATRICULA"	, cTRB	, STR0033, "@!"			,nSizeSRA+5	,/*lPixel*/, { | | ( cTRB )->MATRICULA }	) //"Matrícula"
		oCell1 := TRCell():New( oSection1, "NOMEFUN" 		, cTRB , STR0058, "@!"			,34 			,/*lPixel*/, { | | ( cTRB )->NOMEFUN } 	) //"Nome Funcionário"
		oCell1 := TRCell():New( oSection1, "SEXO" 		, cTRB , STR0059, "@!"			,06 			,/*lPixel*/, { | | (cTRB)->SEXO } 	) //"Sexo"
		oCell1 := TRCell():New( oSection1, "RA_ADMISSA" 	, "SRA", STR0060, "99/99/9999"	,16 			) //"Admissão"
		oCell1 := TRCell():New( oSection1, "IDADE" 		, cTRB , STR0061, "@E 999"		,06 			,/*lPixel*/, { | | cValtoChar(( cTRB )->IDADE) } ) //"Idade"
		oCell1 := TRCell():New( oSection1, "RA_CC" 		, "SRA", STR0062, "@!"			,nSizeSI3+6	) //"Centro Custo"
		oCell1 := TRCell():New( oSection1, "FUNCAO" 		, cTRB , STR0063, "@!"			,15 			,/*lPixel*/, { | | ( cTRB )->FUNCAO } ) //"Função Entrega"
		oCell1 := TRCell():New( oSection1, "FUNDES" 		, cTRB , STR0080, "@!"			,25 			,/*lPixel*/, { | | ( cTRB )->FUNDES } ) //"Descrição"
		oCell1 := TRCell():New( oSection1, "RA_CODFUNC" 	, "SRA", STR0064, "@!"			,15 			) //"Função Atual"
		oCell1 := TRCell():New( oSection1, "RJ_DESC" 		, "SRJ", STR0080, "@!"			,25 			) //"Descrição"
		TRPosition():New (oSection1, "SRA", 1, {|| U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA     } )

	//-------------------- Secao 2 - EPIs
	oSection2 := TRSection():New( oReport, STR0078, { cTRB, "SB1" } ) //Epi's
		oCell2 := TRCell():New( oSection2, "EPI" 		, cTRB		, STR0065	, "@!"			,nSizeCod+4	,/*lPixel*/, { | | ( cTRB )->EPI } )//"EPI"
		oCell2 := TRCell():New( oSection2, "B1_DESC" 	, "SB1"	, STR0066	, "@!"			,35 			) //"Nome do EPI"
		oCell2 := TRCell():New( oSection2, "DATAENTR"	, cTRB 	, STR0067	, "99/99/9999",15 			,/*lPixel*/, { | | ( cTRB )->DATAENTR } ) //"Data Entr."
		oCell2 := TRCell():New( oSection2, "HORAENTR"	, cTRB 	, STR0068	, "@E 99:99"	,12	 			,/*lPixel*/, { | | ( cTRB )->HORAENTR } ) //"Hr. Entr."
		oCell2 := TRCell():New( oSection2, "QUANT" 	, cTRB 	, STR0069	, "@E 999.99"	,10 			,/*lPixel*/, { | | ( cTRB )->QUANT } ) //"Quant. Ent."
		oCell2 := TRCell():New( oSection2, "B1_UM" 	, "SB1"	, STR0070	, "@!"			,06 			) //"Un."
		oCell2 := TRCell():New( oSection2, "DTSUBIST"	, cTRB 	, STR0071	, "99/99/9999",14 			,/*lPixel*/, { | | ( cTRB )->DTSUBIST } ) //"Data Subst."
		oCell2 := TRCell():New( oSection2, "HRSUBIST"	, cTRB 	, STR0072	, "@E 99:99"	,12 			,/*lPixel*/, { | | ( cTRB )->HRSUBIST } ) //"Hora Subst."
		oCell2 := TRCell():New( oSection2, "FORNEC" 	, cTRB 	, STR0074	, "@!"			,nSizeSA2+4	,/*lPixel*/, { | | ( cTRB )->FORNEC } ) //Fornecedor
		oCell2 := TRCell():New( oSection2, "FORDES" 	, cTRB 	, STR0080	, "@!"			,45				,/*lPixel*/, { | | ( cTRB )->FORDES } ) //Descrição
		oCell2 := TRCell():New( oSection2, "SITUAC" 	, cTRB 	, STR0073	, "@!"			,15 			,/*lPixel*/, { | | ( cTRB )->SITUAC } ) //"Situação"
		TRPosition():New (oSection2, "SB1", 1, {|| U_MDTR815FIL("SB1",(cTRB)->FILIAL) + (cTRB)->EPI     	} )

	//-------------------- Secao 3 - Funcionário
	oSection3 := TRSection():New( oReport, STR0077, { cTRB, "SRA", "SB1" } )//"Funcionários"
		oCell3 := TRCell():New( oSection3, "MATRICULA"	, cTRB	, STR0033, "@!"			,nSizeSRA+5	,/*lPixel*/, { | | ( cTRB )->MATRICULA } ) //"Matrícula"
		oCell3 := TRCell():New( oSection3, "NOMEFUN" 		, cTRB , STR0058, "@!"			,34 			,/*lPixel*/, { | | ( cTRB )->NOMEFUN } ) //"Nome Funcionário"
		oCell3 := TRCell():New( oSection3, "SEXO" 		, cTRB , STR0059, "@!"			,06 			,/*lPixel*/, { | | (cTRB)->SEXO } 	) //"Sexo"
		oCell3 := TRCell():New( oSection3, "DATAENTR"		, cTRB , STR0067, "99/99/9999"	,15 			,/*lPixel*/, { | | ( cTRB )->DATAENTR } ) //"Data Entr."
		oCell3 := TRCell():New( oSection3, "HORAENTR" 	, cTRB , STR0068, "@E 99:99"	,12 			,/*lPixel*/, { | | ( cTRB )->HORAENTR } ) //"Hr. Entr."
		oCell3 := TRCell():New( oSection3, "QUANT" 		, cTRB , STR0069, "@E 999.99"	,10 			,/*lPixel*/, { | | ( cTRB )->QUANT } ) //"Quant. Ent."
		oCell3 := TRCell():New( oSection3, "B1_UM" 		, "SB1", STR0070, "@!"			,06 			) //"Un."
		oCell3 := TRCell():New( oSection3, "DTSUBIST" 	, cTRB , STR0071, "99/99/9999"	,15 			,/*lPixel*/, { | | ( cTRB )->DTSUBIST } ) //"Data Subst."
		oCell3 := TRCell():New( oSection3, "HRSUBIST" 	, cTRB , STR0072, "@E 99:99"	,12 			,/*lPixel*/, { | | ( cTRB )->HRSUBIST } ) //"Hora Subst."
		oCell3 := TRCell():New( oSection3, "RA_ADMISSA" 	, "SRA", STR0060, "99/99/9999"	,16 			) //"Admissão"
		oCell3 := TRCell():New( oSection3, "IDADE" 		, cTRB , STR0061, "@E 999"		,06 			,/*lPixel*/, { | | cVAlToChar(( cTRB )->IDADE) } ) //"Idade"
		oCell3 := TRCell():New( oSection3, "RA_CC" 		, "SRA", STR0062, "@!"			,nSizeSI3+10	) //"Centro Custo"
		oCell3 := TRCell():New( oSection3, "FUNCAO" 		, cTRB , STR0063, "@!"			,20 			,/*lPixel*/, { | | ( cTRB )->FUNCAO } ) //"Função Entrega"
		oCell3 := TRCell():New( oSection3, "FUNDES" 		, cTRB , STR0080, "@!"			,25 			,/*lPixel*/, { | | ( cTRB )->FUNDES } ) //"Descrição"
		oCell3 := TRCell():New( oSection3, "RA_CODFUNC" 	, "SRA", STR0064, "@!"			,20 			) //"Função Atual"
		oCell3 := TRCell():New( oSection3, "RJ_DESC" 		, "SRJ", STR0080, "@!"			,25 			) //"Descrição"
		oCell3 := TRCell():New( oSection3, "SITUAC" 		, cTRB	, STR0073, "@!"			,15 			,/*lPixel*/, { | | ( cTRB )->SITUAC } ) //"Situação"
		TRPosition():New (oSection3, "SRA", 1, {|| U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA  } )
		TRPosition():New (oSection3, "SB1", 1, {|| U_MDTR815FIL("SB1",(cTRB)->FILIAL) + (cTRB)->EPI      } )

	//-------------------- Secao 4 - EPIs
	oSection4 := TRSection():New( oReport, STR0078, { cTRB } )//Epis
		oCell4 := TRCell():New( oSection4, "EPI" 		, cTRB	, STR0065, "@!"	,nSizeCod+4	,/*lPixel*/, { | | ( cTRB )->EPI } )//"EPI"
		oCell4 := TRCell():New( oSection4, "B1_DESC" 	, "SB1", STR0066, "@!"	,35 			) //"Nome do EPI"
		oCell4 := TRCell():New( oSection4, "FORNEC" 	, cTRB	, STR0074, "@!"	,nSizeSA2+4 	,/*lPixel*/, { | | ( cTRB )->FORNEC } ) //Fornecedor
		oCell4 := TRCell():New( oSection4, "FORDES" 	, cTRB , STR0080, "@!"	,40				,/*lPixel*/, { | | ( cTRB )->FORDES } ) //Descrição
		TRPosition():New (oSection4, "SB1", 1, {|| U_MDTR815FIL("SB1",(cTRB)->FILIAL) + (cTRB)->EPI } )

	//-------------------- Secao 5 - Função de Entrega
	oSection5 := TRSection():New( oReport, STR0079, { cTRB } )//Função
		oCell5 := TRCell():New( oSection5, "FUNCAO" 	, cTRB , STR0063, "@!",20 ,/*lPixel*/, { | | ( cTRB )->FUNCAO } ) //"Função Entrega"
		oCell5 := TRCell():New( oSection5, "FUNDES" 	, cTRB , STR0080, "@!",25 ,/*lPixel*/, { | | ( cTRB )->FUNDES } ) //Descrição

Return oReport

//---------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Imprime o relatorio

@return .T.

@param oReport Objeto Objeto do TReport

@sample ReportDef( oReport )

@author Guilherme Freudenburg
@since 14/07/2016
/*/
//---------------------------------------------------------------------
Static Function ReportPrint(oReport)
	
	Local cCodFil := ""
	Local lImp := .T.

	Private aEpi := {}
	Private aEpiDes := {}

	
	// Monta tabela temporária
	MDT815TRB(2)

	dbSelectArea( cTRB )
	dbSetOrder(mv_par10)
	dbGoTop()

	
	// Verifica existencia de registros
	If Empty((cTRB)->EPI)
		MsgStop(STR0038) //"Não existem dados para montar o relatório."
		lImp := .F.
	Endif

	If mv_par07 == 1 .and. lImp //Matricula x Epi

		While !Eof()
			cCodFil := (cTRB)->FILIAL
			If NGSX2MODO("TNF") != "C"
				oSection0:Init() //-- Filial ou Clientes
				oSection0:PrintLine()
			Endif
			dbSelectArea( cTRB )
			While !eof() .and. cCodFil == (cTRB)->FILIAL
				oSection1:Init()
				cMAT := (cTRB)->MATRICULA

				dbSelectArea( "SRA" )
				dbSetOrder( 1 )
				dbSeek( U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )

				dbSelectArea( "SRJ" )
				dbSetOrder( 1 )
				dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + SRA->RA_CODFUNC )

				oSection1:PrintLine()
				dbSelectArea( cTRB )
				While ! eof() .and. (cTRB)->MATRICULA == cMAT .and. cCodFil == (cTRB)->FILIAL

					If mv_par11 <> 3
						oSection2:Cell("SITUAC"):Disable()
					EndIf
					oSection2:Init()

				If mv_par11 == 3
						nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
						If nScan > 0
							If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
								If (cTRB)->DTSUBIST > dDatabase
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0053//"A SUBSTITUIR"
									MsUnLock(cTRB)
								Else
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0051//"SUBSTITUIR"
									MsUnLock(cTRB)
								EndIf
							Else
								If (cTRB)->DTSUBIST > dDatabase
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0054//"A DEVOLVER"
									MsUnLock(cTRB)
								Else
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0052//"DEVOLVER"
									MsUnLock(cTRB)
								EndIf
							Endif
						Else
							Reclock( cTRB, .F. )
							(cTRB)->SITUAC := STR0047 //Epi não encontrado
							MsUnLock(cTRB)
						Endif
					Endif
					oSection2:PrintLine()

					dbSelectArea( cTRB )
					dbSkip()

				End
				oSection2:Finish()
				oSection1:Finish()
			End
			If NGSX2MODO("TNF") != "C"
				oSection0:Finish()
			Endif
			//Imprime linha para determinar fim da impressão.
			oReport:SkipLine()
			oReport:FatLine()
			oReport:SkipLine()
		End
	ElseIf mv_par07 == 2 .and. lImp // Epi x Matricula

		While !EOF()
			cCodFil := (cTRB)->FILIAL
			If NGSX2MODO("TNF") != "C"
				oSection0:Init() //-- Filial ou Clientes
				oSection0:PrintLine()
			Endif

			dbSelectArea( cTRB )
			While !eof() .and. cCodFil == (cTRB)->FILIAL

				cEPI := (cTRB)->EPI
				oSection4:Init()
				dbSelectArea( "SA2" )
				dbSetOrder( 1 )
				dbSeek( U_MDTR815FIL("SA2",(cTRB)->FILIAL) + (cTRB)->FORNEC )

				oSection4:PrintLine()

				dbSelectArea( cTRB )
				If mv_par11 <> 3
					oSection3:Cell("SITUAC"):Disable()
				EndIf
				oSection3:Init()
				While !eof() .and. cCodFil == (cTRB)->FILIAL .and. (cTRB)->EPI == cEPI

					dbSelectArea( "SRA" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SRA",(cTRB)->FILIAL) + (cTRB)->MATRICULA )

					dbSelectArea( "SRJ" )
					dbSetOrder( 1 )
					dbSeek( U_MDTR815FIL("SRJ",(cTRB)->FILIAL) + SRA->RA_CODFUNC )

					If mv_par11 == 3
						nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
						If nScan > 0
							If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
								If (cTRB)->DTSUBIST > dDatabase
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0053//"A SUBSTITUIR"
									MsUnLock(cTRB)
								Else
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0051//"SUBSTITUIR"
									MsUnLock(cTRB)
								EndIf
							Else
								If (cTRB)->DTSUBIST > dDatabase
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0054//"A DEVOLVER"
									MsUnLock(cTRB)
								Else
									Reclock( cTRB, .F. )
									(cTRB)->SITUAC := STR0052//"DEVOLVER"
									MsUnLock(cTRB)
								EndIf
							Endif
						Else
							Reclock( cTRB, .F. )
							(cTRB)->SITUAC := STR0047 //Epi não encontrado
							MsUnLock(cTRB)
						Endif
					Endif

					oSection3:PrintLine()

					dbSelectArea( cTRB )
					dbSkip()
				End
				oSection3:Finish()
				oSection4:Finish()
			End
			If NGSX2MODO("TNF") != "C"
				oSection0:Finish()
			Endif
			//Imprime linha para determinar fim da impressão.
			oReport:SkipLine()
			oReport:FatLine()
			oReport:SkipLine()
		End

	ElseIf mv_par07 == 3 .and. lImp // Função x Epi

		While !Eof()
			cCodFil := (cTRB)->FILIAL
			If NGSX2MODO("TNF") != "C"
				oSection0:Init() //-- Filial ou Clientes
				oSection0:PrintLine()
			Endif

			dbSelectArea( cTRB )
			While !eof() .and. cCodFil == (cTRB)->FILIAL
				cFUNCAO := (cTRB)->FUNCAO

				oSection5:Init()

				dbSelectArea("SRJ")
				dbSetOrder(1)
				dbSeek(U_MDTR815FIL("SRJ",(cTRB)->FILIAL)+(cTRB)->FUNCAO )

				oSection5:PrintLine()

				Dbselectarea( cTRB )
				While ! EoF() .AND. (cTRB)->FUNCAO == cFUNCAO .and. cCodFil == (cTRB)->FILIAL

					oSection4:Init()

					dbSelectArea("SA2")
					dbSetOrder(1)
					dbSeek(U_MDTR815FIL("SA2",(cTRB)->FILIAL) + (cTRB)->FORNEC )

					cEPI := (cTRB)->EPI

					oSection4:PrintLine()

					If mv_par11 <> 3
						oSection3:Cell("SITUAC"):Disable()
					EndIf
					oSection3:Cell("FUNCAO"):Disable()
					oSection3:Cell("FUNDES"):Disable()
					oSection3:Init()

					dbSelectArea( cTRB )
					While !EoF() .AND. ( (cTRB)->EPI == cEPI ) .AND. ( (cTRB)->FUNCAO == cFUNCAO ) .and. cCodFil == (cTRB)->FILIAL

						dbSelectArea("SRJ")
						dbSetOrder(1)
						dbSeek(U_MDTR815FIL("SRJ",(cTRB)->FILIAL)+SRA->RA_CODFUNC )

						If mv_par11 == 3
							nScan := aSCAN(aEpi, {|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI })
							If nScan > 0
								If aEpi[nScan,4] == DTOS((cTRB)->DTSUBIST)+(cTRB)->HRSUBIST .and. aScan(aEpiDes,{|x| x[1]+x[2]+x[3] == (cTRB)->FILIAL + (cTRB)->MATRICULA + (cTRB)->EPI .AND. x[4] > DTOS((cTRB)->DTSUBIST) + (cTRB)->HRSUBIST}) == 0
									If (cTRB)->DTSUBIST > dDatabase
										Reclock( cTRB, .F. )
										(cTRB)->SITUAC := STR0053//"A SUBSTITUIR"
										MsUnLock(cTRB)
									Else
										Reclock( cTRB, .F. )
										(cTRB)->SITUAC := STR0051 //"SUBSTITUIR"
										MsUnLock(cTRB)
									EndIf
								Else
									If (cTRB)->DTSUBIST > dDatabase
										Reclock( cTRB, .F. )
										(cTRB)->SITUAC := STR0054 //"A DEVOLVER"
										MsUnLock(cTRB)
									Else
										Reclock( cTRB, .F. )
										(cTRB)->SITUAC := STR0052 //"DEVOLVER"
										MsUnLock(cTRB)
									EndIf
								Endif
							Else
								Reclock( cTRB, .F. )
								(cTRB)->SITUAC := STR0047 //Epi não encontrado
								MsUnLock(cTRB)
							Endif
					Endif

					oSection3:PrintLine()

						dbSelectArea( cTRB )
						dbSkip()
					End
					oSection3:Finish()
					oSection4:Finish()
				End
			oSection5:Finish()
			End
			If NGSX2MODO("TNF") != "C"
				oSection0:Finish()
			Endif
			//Imprime linha para determinar fim da impressão.
			oReport:SkipLine()
			oReport:FatLine()
			oReport:SkipLine()
		End
	EndIf

	oTempTRB:Delete()

Return .T.
