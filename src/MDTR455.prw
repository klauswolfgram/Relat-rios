/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr455.ch"
#Include "Protheus.ch"

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR455
Relatorio dos funcionarios convocados para realizar Exames.
O usuario pode selecionar o numero da convocacao que identi-
fica os parametros que originaram  a tabela de convocados.
Com base nas informacoes da tabela de parametros (TMV), o
programa selecionara os registros da tabela de convocacao
para lista-los no relatorio.
O usuario selecionara o periodo desejado, com estas infor-
macoes pode-se conferir o calculo que gerou a convocacao.
Podera selecionar tambem os funcionarios que nao realizaram
os exames, somente aqueles que ja realizaram ou todos.

@author Marcio Costa
@since 12/01/2000
/*/
//---------------------------------------------------------------------
User Function MDTR455()

	// Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	// Define Variaveis
	Local wnrel   := "MDTR455"
	Local limite  := 132
	Local cDesc1  := STR0001 // "Relatorio de Funcionarios convocados para a realizacao dos exames periodicos."
	Local cDesc2  := STR0002 // "Atraves dos parametros o usuario seleciona: O numero da Convocacao e o  periodo"
	Local cDesc3  := STR0003 // "desejado. Define tambem se deseja listar: todos, nao realizados ou ja realizados"
	Local cString := "TMJ"
	Local aPerg := {} // Grupo de perguntas
	Local lRet := .T. // Controle da aplicação do pacote para alteração das perguntas

	Private cAlias      := "SI3"
	Private cDescr      := "I3_DESC"
	Private nSizeSI3    := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	Private lTMW_Filial := If( Empty(xFilial("TMW")) .and. Empty(xFilial("TMV")) .and. !Empty(xFilial("SRA")) , .t. , .f. ) //Indica se o PCMSO/Convocacao é para varias filiais

	Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S"  , .T. , .F. )
	Private nomeprog := "MDTR455"
	Private tamanho  := "M"
	Private aReturn  := {STR0004, 1,STR0005, 2, 2, 1, "",1} // "Zebrado"###"Administracao"
	Private titulo   := STR0006   // "Convocacao para Realizacao dos Exames Periodicos"
	Private ntipo    := 0
	Private nLastKey := 0
	Private cPerg    := IIf(!lSigaMdtPS,"MDT455    ","MDT455PS  ")
	Private cabec1, cabec2
	Private mv_pcmso

	If Alltrim(GetMv("MV_MCONTAB")) == "CTB"
		cAlias   := "CTT"
		cDescr   := "CTT_DESC01"
		nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	Endif

	lPrepExame := .T.

	If !MDTRESTRI(cPrograma)
		NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
		Return .F.
	Endif

	/*------------------------------------------------
	//PERGUNTA PADRÃO									|
	| MDT455    ¦01      ¦PCMSO ?                   	|

	| MDT455    ¦02      ¦De Convocacao ?              	|
	| MDT455    ¦03      ¦Ate Convocacao ?              |

	| MDT455    ¦04      ¦Imprime ?                 	|
	| MDT455    ¦05      ¦De  Data Consulta ?       	|
	| MDT455    ¦06      ¦Ate Data Consulta ?       	|
	| MDT455    ¦07      ¦De  Centro Custo ?        	|
	| MDT455    ¦08      ¦Ate Centro Custo ?        	|
	| MDT455    ¦09      ¦Saltar Página por ?       	|
	|                    - Nenhum                  		|
	|                	 - Centro de Custo 		  		|
	|                    - Funcionário              	|
	| MDT455    ¦10      ¦De  Filial ?              	|
	| MDT455    ¦11      ¦Ate Filial ?              	|
	| MDT455    ¦12      ¦Imprimir Preparação ?     	|
	|													|

	//PERGUNTAS PRESTADO DE SERVIÇO						|
	|            01      ¦Cliente ?                 	|
	|            02      ¦Loja                      	|
	| MDT455    ¦03      ¦PCMSO ?                   	|
	| MDT455    ¦04      ¦Convocacao ?              	|
	| MDT455    ¦05      ¦Imprime ?                 	|
	| MDT455    ¦06      ¦De  Data Consulta ?       	|
	| MDT455    ¦07      ¦Ate Data Consulta ?       	|
	| MDT455    ¦08      ¦De Centro Custo ?         	|
	| MDT455    ¦09      ¦Ate Centro Custo ?        	|
	| MDT455    ¦10      ¦Saltar Página por ?       	|
	|                    - Nenhum                   	|
	|                	 - Centro de Custo				|
	|                    - Funcionário             		|
	| MDT455    ¦11      ¦De  Filial ?              	|
	| MDT455    ¦12      ¦Ate Filial ?              	|
	| MDT455    ¦13      ¦Imprimir Preparação ?     	|
	--------------------------------------------------*/

	// Verificacao da aplicação do Pacote que altera as perguntas3

	If Posicione( 'SX1', 1, cPerg+"03", 'X1Pergunt()') != STR0042 //"Até Convocação ?"
		ShowHelpDlg( STR0060   , ;           // Atenção
                   { STR0058 + "." } , 1 , ; // Para o uso correto deste relatório (MDTR455) é necessária a aplicação do pacote presente na Issue MNG-866
				   { STR0059 + "." } , 2 )   // Aplicar o pacote da Issue MNG-866
		lRet := .F.
	EndIf

	If lRet

		pergunte(cPerg,.F.) // Verifica as perguntas selecionadas

		If lSigaMdtPS
			mv_pcmso := mv_par03
		Else
			mv_pcmso := mv_par01
		EndIf

		// Envia controle para a funcao SETPRINT
		wnrel:="MDTR455"

		wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

		If mv_par12 == 2
			lPrepExame := .F.
		EndIf

		If nLastKey == 27
			Set Filter to
			// Devolve variaveis armazenadas (NGRIGHTCLICK)
			NGRETURNPRM(aNGBEGINPRM)
			Return
		Endif

		SetDefault(aReturn,cString)

		If nLastKey == 27
			Set Filter to
			NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
			Return
		Endif

		If lSigaMdtps
			lTMW_Filial := .F.
			RptStatus({|lEnd| _R455Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		Else
			RptStatus({|lEnd| R455Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
		Endif

	EndIf

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} R455Imp
Chamada do Relatorio

@param lEnd, Lógico - Indica o fim da impressão
@param wnRel, Caracter - Programa utilizado
@param titulo, Caracter - Título do relatório
@param tamanho, Caracter - Tamanho do relatório

@return NIl, Nulo

@author Inacio Luiz Kolling
@since 01/06/1997
/*/
//---------------------------------------------------------------------
Static Function R455Imp(lEnd,wnRel,titulo,tamanho)

	//	Define Variaveis
	Local cRodaTxt  := ""
	Local nCntImpr  := 0
	Local nXXX, nXYZ
	Local lImprimiu := .F.

	// Variaveis para controle do cursor de progressao do relatorio

	// Variaveis locais exclusivas deste programa
	Local lContinua := .T.
	Local cConSalvo := ""

	// Variaveis tipo Private padrao de todos os relatorios

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1
	Private lPrimvez := .T.

	// Variaveis private exclusivas deste programa
	Private aDados := {} //Vetor com os valores a serem impressos

	nTipo  := IIF(aReturn[4]==1,15,18) // Verifica se deve comprimir ou nao

	dbSelectArea("TMV")
	dbSetOrder(01)

	If Empty(mv_par02)
		dbGoTop()
	Else
		dbSeek(xFilial("TMV")+MV_PAR01 + MV_PAR02)
	EndIf

	dbSelectArea("TM4")
	dbSetOrder(01)
	dbSeek(xFilial("TM4")+TMV->TMV_EXAME)

	aFilRelat := {}
	If lTMW_Filial .And. !Empty(xFilial("TMJ"))
		aAreaSM0 := SM0->(GetArea())
		dbSelectArea("SM0")
		dbGoTop()

		If Empty(Mv_par10)
			dbSeek(cEmpAnt)
		Else
			dbSeek(cEmpAnt+Mv_par10)
		EndIf

		While !Eof() .And. SM0->M0_CODIGO == cEmpAnt .And. SM0->M0_CODFIL <= Mv_par11
			aAdd( aFilRelat , SM0->M0_CODFIL )
			dbSkip()
		End

		RestArea(aAreaSM0)
	Else
		aAdd( aFilRelat , cFilAnt )
	Endif

	For nXYZ := 1 To Len(aFilRelat)

		dbSelectArea("TMJ")
		dbSetOrder(03)
		dbSeek(xFilial("TMJ",aFilRelat[nXYZ])+MV_PAR01+MV_PAR02,.T.)
		SetRegua(LastRec())

		While 	!Eof() .And. TMJ->TMJ_FILIAL == xFIlial('TMJ',aFilRelat[nXYZ]) .And.;
		 		TMJ->TMJ_PCMSO  == MV_PAR01 .And. ;
				(TMJ->TMJ_CONVOC >= MV_PAR02 .And. TMJ->TMJ_CONVOC <= MV_PAR03)

			DbSelectArea("TM0")
			DbSetOrder(1)
			DbSeek(xFilial("TM0",aFilRelat[nXYZ])+TMJ->TMJ_NUMFIC)

			If !Empty(TM0->TM0_FILFUN)

				If lTMW_Filial

					If TM0->TM0_FILFUN < Mv_par10 .Or. TM0->TM0_FILFUN > Mv_par11
						dbSelectArea("TMJ")
						dbskip()
						Loop
					EndIf

				ElseIf TM0->TM0_FILFUN <> aFilRelat[nXYZ]
					dbSelectArea("TMJ")
					dbskip()
					Loop
				EndIf

			Endif

			If MV_PAR04 == 2 .And. !EMPTY(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If MV_PAR04 == 3 .And. EMPTY(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If TMJ->TMJ_DTCONS < MV_PAR05 .Or. TMJ->TMJ_DTCONS > MV_PAR06
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA",TM0->TM0_FILFUN)+TMJ->TMJ_MAT)

			If SRA->RA_CC < MV_PAR07 .Or. SRA->RA_CC > MV_PAR08
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			dbSelectArea(cAlias)
			dbSetOrder(1)
			dbSeek(xFilial(cAlias,TM0->TM0_FILFUN)+SRA->RA_CC)

			aADD( aDados , {TMJ->TMJ_DTCONS      											,;
							TMJ->TMJ_HRCONS          										,;
							TMJ->TMJ_MAT             										,;
							Substr(SRA->RA_NOME,1,30)										,;
							SRA->RA_CC               										,;
							Substr(&(cDescr),1,25)  										,;
							TMJ->TMJ_DTATEN			 										,;
							TM0->TM0_FILFUN													,;
							TMJ->TMJ_CONVOC 												,;
							TMJ->TMJ_CODUSU													,;
							AllTrim(NGSEEK("TMK",TMJ->TMJ_CODUSU,1,"TMK->TMK_NOMUSU")) 		,;
							TMJ->TMJ_EXAME													,;
							AllTrim(NGSEEK("TM4",TMJ->TMJ_EXAME,1,"TM4->TM4_NOMEXA"))		,;
							NGSEEK("TMV",TMJ->TMJ_PCMSO + TMJ->TMJ_CONVOC,1,"TMV->TMV_LOCAL")})

			dbSelectArea("TMJ")
			dbskip()
		End

	Next nXYZ

	// Monta os Cabecalhos
	If mv_par09 == 1 // Nao

		cabec1 := STR0007 //"Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames "
		cabec2 := STR0008 //"Data       Hora    Matric.   Nome do Funcionario              Centro Custo   Nome                               Realizado"

		// Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames
		// Data       Hora    Matric.   Nome do Funcionario              Centro Custo   Nome                               Realizado
		//           1         2         3         4         5         6         7         8         9         0         1         2         3
		// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

		// xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		//	Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		// Convocação: 9999

		// xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		// xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		// xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx

		aSort( aDados ,,, { |x,y| x[8]+DtoS(x[1])+x[2] < y[8]+DtoS(y[1])+y[2] } ) //Filial + Data + Hora
		cSvFilial := "--"
		cConSalvo := "########"

		SetRegua(Len(aDados))

		For nXXX := 1 To Len(aDados)
			IncRegua()
			lImprimiu := .T.

			If aDados[nXXX,9] != cConSalvo .Or. aDados[nXXX,8] <> cSvFilial
				li := 80

				If lTMW_Filial
					SomaLinha(nXXX)
					@ Li,000 Psay STR0017 + ": " + aDados[nXXX,8] //"Filial"
					SomaLinha(nXXX)
				EndIf

				Somalinha(nXXX)
				@ Li,000 PSay "Convocação: " + Alltrim(aDados[nXXX,9])
				Somalinha(nXXX)
				cSvFilial := aDados[nXXX,8]
				cConSalvo := aDados[nXXX,9]
			EndIf

			SomaLinha(nXXX)
			@ Li,000 PSay aDados[nXXX,1] PICTURE "99/99/99"
			@ Li,011 PSay aDados[nXXX,2] PICTURE "99:99"
			@ Li,019 PSay aDados[nXXX,3] PICTURE "@!"
			@ Li,029 PSay aDados[nXXX,4] PICTURE "@!"
			@ Li,062 PSay aDados[nXXX,5] PICTURE "@!"
			@ Li,077 PSay Substr(aDados[nXXX,6],1,25) PICTURE "@!"
			@ Li,115 PSay aDados[nXXX,7] PICTURE "99/99/99"
		Next nXXX

	ElseIf mv_par09 == 2 // Por Centro de Custo

		cabec1 := STR0007 //"Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames "
		cabec2 := "Convocacao     Data       Hora    Matric.     Nome do Funcionario                 Realizado"

		/*        1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames
		Convocacao     Data       Hora    Matric.     Nome do Funcionario                 Realizado
		-------------------------------------------------------------------------------------------------------------------------------------
		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

			Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		Centro de Custo.: 999999999 - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx           xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx           xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx           xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx
		*/

		aSort( aDados ,,, { |x,y| x[8]+x[5]+x[4]+x[9] < y[8]+y[5]+y[4]+y[9] } ) //Filial + Centro de Custo + Nome + Convocacao
		cCcsalvo  := "########"
		cSvFilial := "--"

		SetRegua(Len(aDados))

		For nXXX := 1 To Len(aDados)
			IncRegua()
			lImprimiu := .T.

			If cCcsalvo != aDados[nXXX,5] .or. aDados[nXXX,8] <> cSvFilial
				li := 80

				If lTMW_Filial
					SomaLinha()
					@ Li,000 Psay STR0017 + ": " + aDados[nXXX,8] //"Filial"
					SomaLinha()
				EndIf

				Somalinha()
				@ Li,000 PSay STR0013 + Alltrim(aDados[nXXX,5]) + " - " + Alltrim(aDados[nXXX,6])  //"Centro de Custo.: "
				Somalinha()
				cSvFilial := aDados[nXXX,8]
				cCcsalvo  := aDados[nXXX,5]
			EndIf

			SomaLinha()
			@ Li,000 PSay aDados[nXXX,10] PICTURE "@!" //Atendente
			@ Li,015 PSay aDados[nXXX,11] PICTURE "@!" //Nome Atendente
			@ Li,055 PSay aDados[nXXX,12] PICTURE "@!" //Exame
			@ Li,067 PSay aDados[nXXX,13] PICTURE "@!" //Nome Exame
			@ Li,100 PSay aDados[nXXX,14] PICTURE "@!" //Local Exames
			SomaLinha()
			@ Li,000 PSay aDados[nXXX,9] PICTURE "9999"		 //Convocacao
			@ Li,015 PSay aDados[nXXX][1] PICTURE "99/99/99" //Data Consulta
			@ Li,026 PSay aDados[nXXX][2] PICTURE "99:99"    //Hora Consulta
			@ LI,034 PSay aDados[nXXX][3] PICTURE "@!"       //Matricula Funcionario
			@ Li,046 PSay aDados[nXXX][4] PICTURE "@!"       //Nome Funcionario
			@ Li,082 PSay aDados[nXXX][7] PICTURE "99/99/99" //Data Realização
			SomaLinha()
		Next nXXX

	ElseIf mv_par09 == 3 // Por Funcionário

		cabec1 := STR0007 //"Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames "
		cabec2 := "Convocacao     Data       Hora    Matric.     Nome do Funcionario                 Realizado"

		/*        1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Atendente      Nome Atendente                          Exame       Nome Exame                       Local Exames
		Convocacao     Data       Hora    Matric.     Nome do Funcionario                 Realizado
		-------------------------------------------------------------------------------------------------------------------------------------
		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

			Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
											xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		Centro de Custo.: 999999999 - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx  		   xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx  		   xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx

		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		xxxx  		   xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx
		*/

		aSort( aDados ,,, { |x,y| x[8]+x[3]+x[4]+x[9] < y[8]+y[3]+y[4]+y[9] } ) //Filial + Matricula + Nome + Convocacao
		cMatFunc  := "########"
		cSvFilial := "--"

		SetRegua(Len(aDados))

		For nXXX := 1 To Len(aDados)
			IncRegua()
			lImprimiu := .T.

			If cMatFunc != aDados[nXXX][3] .or. aDados[nXXX][8] <> cSvFilial
				li := 80
				Somalinha()

				If lTMW_Filial
					@ Li,000 Psay STR0017 + ": " + aDados[nXXX][8] //"Filial"
					SomaLinha()
				EndIf

				cSvFilial := aDados[nXXX][8]
				cMatFunc  := aDados[nXXX][3]
			EndIf

			SomaLinha()
			@ Li,000 PSay aDados[nXXX,10] PICTURE "@!" //Atendente
			@ Li,015 PSay aDados[nXXX,11] PICTURE "@!" //Nome Atendente
			@ Li,055 PSay aDados[nXXX,12] PICTURE "@!" //Exame
			@ Li,067 PSay aDados[nXXX,13] PICTURE "@!" //Nome Exame
			@ Li,100 PSay aDados[nXXX,14] PICTURE "@!" //Local Exames
			SomaLinha()
			@ Li,000 PSay aDados[nXXX,9] PICTURE "9999"		 //Convocacao
			@ Li,015 PSay aDados[nXXX][1] PICTURE "99/99/99" //Data Consulta
			@ Li,026 PSay aDados[nXXX][2] PICTURE "99:99"    //Hora Consulta
			@ LI,034 PSay aDados[nXXX][3] PICTURE "@!"       //Matricula Funcionario
			@ Li,046 PSay aDados[nXXX][4] PICTURE "@!"       //Nome Funcionario
			@ Li,082 PSay aDados[nXXX][7] PICTURE "99/99/99" //Data Realização
			SomaLinha()
		Next nXXX

	EndIf

	If !lImprimiu
		MsgInfo(STR0011)  //"Não há nada para imprimir no relatório."
		Use
		RetIndex("TM1")
		Set Filter To
		Return .F.
	Endif

	Roda(nCntImpr,cRodaTxt,Tamanho)
	RetIndex("TM1") // Devolve a condicao original do arquivo principal

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	//SET CENTURY ON
	MS_FLUSH()

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} _R455Imp
Chamada do Relatorio p/ prestador

@param lEnd, Lógico - Indica o fim da impressão
@param wnRel, Caracter - Programa utilizado
@param titulo, Caracter - Título do relatório
@param tamanho, Caracter - Tamanho do relatório

@return NIl, Nulo

@author Andre Perez Alvarez
@since 26/02/2008
/*/
//---------------------------------------------------------------------
Static Function _R455Imp(lEnd,wnRel,titulo,tamanho)

	// Define Variaveis
	Local cRodaTxt := ""
	Local nCntImpr := 0
	Local nXXX
	Local lImprimiu := .f.

	// Variaveis locais exclusivas deste programa
	Local lContinua := .T.

	// Variaveis tipo Private padrao de todos os relatorios

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1
	Private lPrimvez := .T.

	nTipo  := IIF(aReturn[4]==1,15,18) // Verifica se deve comprimir ou nao

	// Monta os Cabecalhos
	If mv_par10 == 1 //Nenhum
		cabec1 := STR0007
		cabec2 := STR0014

		//" Atendente      Nome Atendente                         Exame     Nome Exame                         Local Exames "
		//" Data      Hora    Matric.   Nome do Funcionario              Centro Custo           Nome                        Realizado"
		//            1         2         3         4         5         6         7         8         9         0         1         2         3
		//  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012

		//  xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx         xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		//	Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
		//									 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


		//  xx/xx/xx  xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   12345678901234567890   xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		//  xx/xx/xx  xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   12345678901234567890   xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		//  xx/xx/xx  xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   12345678901234567890   xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx


		dbSelectArea("TMJ")
		dbSetOrder(03)
		dbSeek(xFilial("TMJ")+MV_PAR03+MV_PAR04,.T.)

		SetRegua(LastRec())

		// Correr TMJ para ler os  CONVOCADOS
		While lContinua .And. !Eof()            .And.;
			  TMJ->TMJ_FILIAL == xFIlial('TMJ') .And.;
			  TMJ->TMJ_PCMSO  == MV_PAR03       .And.;
			  TMJ->TMJ_CONVOC == MV_PAR04

			IncRegua()

			If  lPrimvez
				dbSelectArea("TMV")
				dbSetOrder(01)
				dbSeek(xFilial("TMV")+MV_PAR03 + MV_PAR04)

				dbSelectArea("TMK")
				dbSetOrder(01)
				dbSeek(xFilial("TMK")+TMJ->TMJ_CODUSU)

				dbSelectArea("TM4")
				dbSetOrder(01)
				dbSeek(xFilial("TM4")+TMV->TMV_EXAME)
				lPrimvez := .F.
			EndIf

			If MV_PAR05 == 2 .And. !Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If MV_PAR05 == 3 .And. Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If TMJ->TMJ_DTCONS < MV_PAR06
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If TMJ->TMJ_DTCONS > MV_PAR07
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TMJ->TMJ_MAT)

			If SRA->RA_CC < MV_PAR08
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If SRA->RA_CC > MV_PAR09
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			SunLine(TMJ->TMJ_MAT)
			@ Li,000 PSay TMJ->TMJ_DTCONS  PICTURE "99/99/99"
			@ Li,011 PSay TMJ->TMJ_HRCONS  PICTURE "99:99"
			@ LI,019 PSay TMJ->TMJ_MAT     PICTURE "@!"
			@ Li,029 PSay Substr(SRA->RA_NOME,1,30) PICTURE "@!"
			@ Li,062 PSay SRA->RA_CC       PICTURE "@!"
			dbselectarea(cAlias)
			dbSetorder(1)
			dbseek(xFilial(cAlias)+SRA->RA_CC)
			@ Li,086 PSay Substr(&(cDescr),1,25)
			@ Li,114 PSay TMJ->TMJ_DTATEN  PICTURE "99/99/99"

			dbSelectArea("TMJ")
			dbSetOrder(03)

			lImprimiu := .t.

			dbskip()

		EndDo

	ElseIf mv_par10 == 2 //por Centro de Custo

		cabec1 := STR0007 //"Atendente      Nome Atendente                          Exame     Nome Exame                         Local Exames"
		cabec2 := STR0010 //"Data       Hora    Matricula   Nome do Funcionario                 Realizado"

		/*        1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		Atendente      Nome Atendente                          Exame     Nome Exame                         Local Exames"
		Data       Hora    Matricula   Nome do Funcionario                 Realizado"
		-------------------------------------------------------------------------------------------------------------------------------------
		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		Centro de Custo.: 999999999 - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx
		xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx
		xx/xx/xx   xx:xx   xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      xx/xx/xx
		*/

		aDados := {}

		dbSelectArea("TMJ")
		dbSetOrder(03)
		dbSeek(xFilial("TMJ")+MV_PAR03+MV_PAR04,.T.)
		SetRegua(LastRec())
		While !Eof()                              .And.;
				TMJ->TMJ_FILIAL == xFIlial('TMJ') .And.;
				TMJ->TMJ_PCMSO  == MV_PAR03       .And.;
				TMJ->TMJ_CONVOC == MV_PAR04

			IncRegua()

			If MV_PAR05 == 2 .AND. !Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			If MV_PAR05 == 3 .AND. Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			If TMJ->TMJ_DTCONS < MV_PAR06 .or. TMJ->TMJ_DTCONS > MV_PAR07
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TMJ->TMJ_MAT)

			If SRA->RA_CC < MV_PAR08 .or. SRA->RA_CC > MV_PAR09
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			dbSelectArea(cAlias)
			dbSetOrder(1)
			dbSeek(xFilial(cAlias)+SRA->RA_CC)

			aAdd( aDados , {TMJ->TMJ_DTCONS           ,;
							TMJ->TMJ_HRCONS           ,;
							TMJ->TMJ_MAT              ,;
							Substr(SRA->RA_NOME,1,30) ,;
							SRA->RA_CC                ,;
							Substr(&(cDescr),1,25)    ,;
							TMJ->TMJ_DTATEN	} )

			dbSelectArea("TMJ")
			dbskip()
		End

		aSort( aDados ,,, { |x,y| x[5]+x[4] < y[5]+y[4] } ) //Centro de Custo + Nome

		dbSelectArea("TMV")
		dbSetOrder(01)
		dbSeek(xFilial("TMV")+MV_PAR03 + MV_PAR04)
		dbSelectArea("TMK")
		dbSetOrder(01)
		dbSeek(xFilial("TMK")+TMV->TMV_CODUSU)
		dbSelectArea("TM4")
		dbSetOrder(01)
		dbSeek(xFilial("TM4")+TMV->TMV_EXAME)

		cCcsalvo := "########"

		SetRegua(Len(aDados))

		For nXXX := 1 To Len(aDados)
			IncRegua()

			If cCcsalvo != aDados[nXXX,5]
				cCcsalvo := aDados[nXXX,5]
				Li := 59
				SunLine(aDados[nXXX,3])
				@ Li,000 PSay STR0013 + Alltrim(aDados[nXXX,5]) + " - " + Alltrim(aDados[nXXX,6])  //"Centro de Custo.: "
				SunLine(aDados[nXXX,3])
				lImprimiu := .t.
			EndIf

			SunLine(aDados[nXXX,3])
			@ Li,000 PSay aDados[nXXX,1] PICTURE "99/99/99"
			@ Li,011 PSay aDados[nXXX,2] PICTURE "99:99"
			@ LI,019 PSay aDados[nXXX,3] PICTURE "@!"
			@ Li,031 PSay aDados[nXXX,4] PICTURE "@!"
			@ Li,067 PSay aDados[nXXX,7] PICTURE "99/99/99"
		Next nXXX

	ElseIf mv_par10 == 3 // Por Funcionário

		cabec1 := STR0007
		cabec2 := STR0014

	/*
		"Atendente      Nome Atendente                          Exame     Nome Exame                         Local Exames "
		"Data       Hora    Matric.   Nome do Funcionario              Centro Custo   Nome                        Realizado"
				  1         2         3         4         5         6         7         8         9         0         1         2         3
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
		xxxxxxxxxxxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

		Preparação para o Exame: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
										xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


		xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
		xx/xx/xx   xx:xx   xxxxxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx   xxxxxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxx   xx/xx/xx
	*/

		aDados := {}

		dbSelectArea("TMJ")
		dbSetOrder(03)
		dbSeek(xFilial("TMJ")+MV_PAR03+MV_PAR04,.T.)
		SetRegua(LastRec())

		While !Eof()                              .And.;
				TMJ->TMJ_FILIAL == xFIlial('TMJ') .And.;
				TMJ->TMJ_PCMSO  == MV_PAR03       .And.;
				TMJ->TMJ_CONVOC == MV_PAR04

			IncRegua()

			If MV_PAR05 == 2 .AND. !Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If MV_PAR05 == 3 .AND. Empty(TMJ->TMJ_DTATEN)
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			If TMJ->TMJ_DTCONS < MV_PAR06 .or. TMJ->TMJ_DTCONS > MV_PAR07
				dbSelectArea("TMJ")
				dbSkip()
				loop
			EndIf

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TMJ->TMJ_MAT)

			If SRA->RA_CC < MV_PAR08 .or. SRA->RA_CC > MV_PAR09
				dbSelectArea("TMJ")
				dbSkip()
				loop
			Endif

			dbSelectArea(cAlias)
			dbSetOrder(1)
			dbSeek(xFilial(cAlias)+SRA->RA_CC)

			aAdd( aDados , {TMJ->TMJ_DTCONS           ,;
							TMJ->TMJ_HRCONS           ,;
							TMJ->TMJ_MAT              ,;
							Substr(SRA->RA_NOME,1,30) ,;
							SRA->RA_CC                ,;
							Substr(&(cDescr),1,25)    ,;
							TMJ->TMJ_DTATEN           ,;
							TM0->TM0_FILFUN } )

			dbSelectArea("TMJ")
			dbskip()
		End

		aSort( aDados ,,, { |x,y| x[8]+x[3]+x[4]+DtoS(x[1])+x[2] < y[8]+y[3]+y[4]+DtoS(y[1])+y[2] } ) //Filial + Matricula + Nome + Data + Hora
		cMatFunc  := "########"
		cSvFilial := "--"

		dbSelectArea("TMV")
		dbSetOrder(01)
		dbSeek(xFilial("TMV")+MV_PAR03 + MV_PAR04)
		dbSelectArea("TMK")
		dbSetOrder(01)
		dbSeek(xFilial("TMK")+TMV->TMV_CODUSU)
		dbSelectArea("TM4")
		dbSetOrder(01)
		dbSeek(xFilial("TM4")+TMV->TMV_EXAME)

		SetRegua(Len(aDados))

		For nXXX := 1 To Len(aDados)
			IncRegua()
			lImprimiu := .T.

			If cMatFunc != aDados[nXXX][3] .or. aDados[nXXX][8] <> cSvFilial
				li := 80
				Somalinha()

				If lTMW_Filial
					@ Li,000 Psay STR0017 + ": " + aDados[nXXX][8] //"Filial"
					SomaLinha()
				EndIf

				cSvFilial := aDados[nXXX][8]
				cMatFunc  := aDados[nXXX][3]
			EndIf

			@ Li,000 PSay aDados[nXXX][1] PICTURE "99/99/99" //Data Consulta
			@ Li,011 PSay aDados[nXXX][2] PICTURE "99:99"    //Hora Consulta
			@ LI,019 PSay aDados[nXXX][3] PICTURE "@!"       //Matricula Funcionario
			@ Li,031 PSay aDados[nXXX][4] PICTURE "@!"       //Nome Funcionario
			@ Li,067 PSay aDados[nXXX][7] PICTURE "99/99/99" //Data Realização
		Next nXXX

	EndIf

	If !lImprimiu
		MsgInfo(STR0011)  //"Não há nada para imprimir no relatório."
		Use
		RetIndex("TM1")
		Set Filter To
		Return .F.
	Endif

	Roda(nCntImpr,cRodaTxt,Tamanho)
	RetIndex("TM1") // Devolve a condicao original do arquivo principal

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	EndIf

	//SET CENTURY ON
	MS_FLUSH()

Return NIL

//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina

@param nX, Numerico - Posição no vetor aDados das informações do cabecalho
a serem impressas

@author Inacio Luiz Kolling
@since 01/06/1997
/*/
//---------------------------------------------------------------------
Static Function Somalinha(nX)
	Local LinhaCor
	Default nX := 0

	Li++
	If Len(aDados) > 0 .AND. (Li > 58)
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		If GetMv("MV_NGMDTPS") = 'S'

			dbSelectArea("SRA")
			dbSetOrder(01)
			dbSeek(xFilial("SRA")+TMJ->TMJ_MAT)
			cCliente := SubStr(SRA->RA_CC,1,6)

			dbSelectArea("SA1")
			dbSetOrder(01)
			dbSeek(xFilial("SA1")+cCliente)
			cNome := SA1->A1_NOME

			@ Li,000 Psay STR0016+cCliente //"Cliente :"
			@ Li,017 Psay cNome Picture "@!"
			Li++
			Li++
		EndIf

		If mv_par09 == 1 // Nao

			@ Li,000 PSay aDados[nX,10] PICTURE "@!" //Atendente
			@ Li,015 PSay aDados[nX,11] PICTURE "@!" //Nome Atendente
			@ Li,055 PSay aDados[nX,12] PICTURE "@!" //Exame
			@ Li,067 PSay aDados[nX,13] PICTURE "@!" //Nome Exame
			@ Li,100 PSay aDados[nX,14] PICTURE "@!" //Local Exame

			If lPrepExame .and. !Empty(TM4->TM4_PREPAR)
				Li++
				lPrimeiro    := .T.
				cTextoNew    := MSMM(TM4->TM4_PREPAR)
				nLinhasMemo  := MLCOUNT(cTextoNew,105)
				nTotalLinhas := If(nLinhasMemo > 50,50,nLinhasMemo)
				For LinhaCor := 1 To nTotalLinhas
					Li++
					If lPrimeiro
						@ Li,000 PSay STR0037 //"Preparação para o Exame:"
						lPrimeiro := .F.
					EndIf
					@ Li,025 PSay MemoLine(cTextoNew,105,LinhaCor)
					If Li > 50
						Exit
					EndIf
				Next LinhaCor
			EndIf
			Somalinha()
			Somalinha()

		EndIf
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} SunLine
Incrementa Linha e Controla Salto de Pagina (p/ prestador)

@param cMat, Caracter - Matricula do cliente

@author Andre Perez Alvarez
@since 26/02/2008
/*/
//---------------------------------------------------------------------
Static Function SunLine(cMat)
	Local LinhaCor
	Local lCanPrint := ( mv_par10 == 1 .And. !Eof() ) .Or. ( mv_par10 != 1 .And. Type("aDados") == "A" .And. Len(aDados) > 0 )

	Li++
	If lCanPrint .AND. (Li > 58)

		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)

		dbSelectArea("SRA")
		dbSetOrder(01)
		dbSeek(xFilial("SRA")+cMat)
		cCliente := SubStr(SRA->RA_CC,1,nSizeTD)

		DbSelectArea("SA1")
		DbSetOrder(01)
		DbSeek(xFilial("SA1")+cCliente)

		@ Li,000 Psay STR0012 + AllTrim(SA1->A1_COD) + "-" + AllTrim(SA1->A1_LOJA) + " - " + SA1->A1_NOME  //"Cliente/Loja: "

		Li++
		Li++
		@ Li,000 PSay TMV->TMV_CODUSU
		@ Li,015 PSay SubStr(NGSEEK("TMK",TMV->TMV_CODUSU,1,"TMK->TMK_NOMUSU"),1,30)
		@ Li,055 PSay TMV->TMV_EXAME
		@ Li,067 PSay SubStr(TM4->TM4_NOMEXA,1,28)
		@ Li,100 PSay TMV->TMV_LOCAL
		If lPrepExame .and. !Empty(TM4->TM4_PREPAR)
			Li++
			lPrimeiro    := .T.
			cTextoNew    := MSMM(TM4->TM4_PREPAR)
			nLinhasMemo  := MLCOUNT(cTextoNew,105)
			nTotalLinhas := If(nLinhasMemo > 50,50,nLinhasMemo)
			For LinhaCor := 1 To nTotalLinhas
				Li++
				If lPrimeiro
					@ Li,000 PSay STR0037 //"Preparação para o Exame:"
					lPrimeiro := .F.
				EndIf
				@ Li,025 PSay MemoLine(cTextoNew,105,LinhaCor)
				If Li > 50
					Exit
				EndIf
			Next LinhaCor
		EndIf
		SunLine(cMat)
		SunLine(cMat)
	EndIf

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT435TMW
Verifica se o PCMSO e do cliente

@param cPCMSO, Caracter - Informação para a procura dos parâmetros do PCMSO

@return .T.

@author Andre Perez Alvarez
@since 27/02/2008
/*/
//---------------------------------------------------------------------
User Function MDT435TMW(cPCMSO)

	Local aArea := GetArea()
	Local aAreaTMW := TMW->(GetArea())

	dbSelectArea("TMW")
	dbSetOrder(1)
	dbSeek(xFilial("TMW")+cPCMSO)

	If SubSTR(TMW->TMW_CCDE,1,nSizeTD) <> mv_par01+mv_par02
		msgStop(STR0015)  //"O PCMSO não pertence ao cliente selecionado."
		RestArea(aArea)
		RestArea(aAreaTMW)
		Return .F.
	Endif

	RestArea(aArea)
	RestArea(aAreaTMW)
Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT455FLVL
Valida os campos De/Ate Filial

@param nTipo, Numerico - Define se é De Filial ou Ate Filial

@return lRet, Logico - Se o parametro é valido ou não

@author Denis Hyroshi
@since 04/08/2008
/*/
//---------------------------------------------------------------------
User Function MDT455FLVL(nTipo)
	Local lRet := .T.
	Local cArea := Alias()
	Local aArea := SM0->(GetArea())

	If nTipo == 1
		If !Empty(Mv_par10)
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par10)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
			If Mv_par10 > Mv_par11
				Mv_par11 := Mv_par10
			Endif
		Endif
	Else
		If Mv_par11 <> Replicate("Z",Len(Mv_par11))
			If Mv_par10 > Mv_par11
				Help(" ",1,"DEATEINVAL")
				lRet := .F.
			Else
				dbSelectArea("SM0")
				If !dbSeek(cEmpAnt+Mv_par11)
					Help(" ",1,"REGNOIS")
					lRet := .F.
				Endif
			Endif
		Endif
	Endif

	RestArea(aArea)
	dbSelectArea(cArea)

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT455PCMS
Valida o campo PCMSO

@param mv_par,

@return .T.

@author Andrey Martim Pegorini
@since 05/11/2010
/*/
//---------------------------------------------------------------------
User Function MDT455PCMS(mv_par)

	mv_pcmso := mv_par

Return .T.

//---------------------------------------------------------------------
/*/{Protheus.doc} VALIDMV03
Valida o parametro MV_PAR03

@param cTmw, Caracter -
@param mvpar03, Numerico - Parametro "Ate Convocacao"

@return .F.

@author André Felipe Joriatti
@since 11/06/2012
/*/
//---------------------------------------------------------------------
User Function VALIDMV03( cTmw,mvpar03 )
	If ExistCpo(cTmw,mvpar03) .and. U_MDT435TMW(mvpar03) .and. U_MDT455PCMS(mvpar03)
		Return .T.
	EndIf
Return .F.

//---------------------------------------------------------------------
/*/{Protheus.doc} MDTR455VLC
Valida os campos De/Ate Convocacao

@param nTipo, Numerico - Define se é De Convovavao ou Ate Convocacao

@return lRet, Logico - Se o parametro é valido ou não

@author Jorge Luis Siementkowski
@since 29/08/2017
/*/
//---------------------------------------------------------------------
User Function MDTR455VLC(nTipo)

	Local lRet := .T.

	If nTipo == 1 //De Convocacao

		If !Empty(mv_par02)
			If mv_par02 > mv_par03 .And. !Empty(mv_par03)
				Help(" ",1,"DEATEINVAL")
				lRet := .F.
			ElseIf !ExistCpo("TMV", mv_par01 + mv_par02)
				lRet := .F.
			EndIf
		EndIf

	Else //Ate Convocacao

		If mv_par03 <> Replicate( "Z",Len(mv_par03) )
			If mv_par03 < mv_par02
				Help(" ",1,"DEATEINVAL")
				lRet := .F.
			ElseIf !ExistCpo("TMV", mv_par01 + mv_par03)
				lRet := .F.
			EndIf
		EndIf

	EndIf

Return lRet
