/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR410.ch"
#Include "Protheus.ch"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RPTDEF.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR410  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³         Respostas ao Questionario Medico.                  ³±±
±±³          ³  Permite tabular as respostas dos questionamentos medicos. ³±±
±±³          ³Inicialmente o usuario seleciona o questionario desejado.   ³±±
±±³          ³Em seguida pode selecionar os funcionarios ou candidatos,   ³±±
±±³          ³por intermedio das fichas medicas.                          ³±±
±±³          ³  Finalmente seleciona do questionario escolhido, qual a    ³±±
±±³          ³pergunta  desejada, ou pode listar todas as perguntas.      ³±±
±±³          ³  O questionario medico e uma ferramenta que ajuda a tracar ³±±
±±³          ³o perfil dos funcionarios quanto aos assuntos relacionados a³±±
±±³          ³saude.                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR410(void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR410( aDados )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				 	  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR410"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de apresentacao do questionario e suas respostas e resumo "
LOCAL cDesc2  := STR0002 //"contento estatistica das respostas do universo selecionado          "
LOCAL cDesc3  := STR0003 //"Opcao disponivel atraves do botao de  parametros.   "
LOCAL cString := "TMI",nFor
LOCAL cPergAlt := ""

PRIVATE aDad145
If Valtype(aDados) == "A"
	aDad145 := aClone(aDados)
Endif

Private nSizeTMH := (TAMSX3("TMH_PERGUN")[1])
nSizeTMH := If( nSizeTMH > 0 , nSizeTMH , 60 )

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE nomeprog := "MDTR410"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006   // + ( NOME DO QUESTIONARIO ) //"Questionario Medico"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    :=If(!lSigaMdtPS,"MDT410    ","MDT410PS  ")
Private aPerg	 := {}
PRIVATE cabec1, cabec2
Private lPrinGraf := .t.
Private lPrintTel := .t.
PRIVATE nSizeTM0 := If((TAMSX3("TM0_NUMFIC")[1]) < 1,9,(TAMSX3("TM0_NUMFIC")[1]))
Private cDESQUEST
PRIVATE aQuesSelc := {}
Private cFilPg := ""
Private nLinhaTot := 3200 //Define o limite de linhas do questionário
Private oTempTRB, oTempTRB2, oTempTRB1

If nSizeTMH > 60
	tamanho := "G"
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*
//----------------------------------------------------------
//PERGUNTAS PADRÕES												|
|  01  De Questionario ?                       				|
|  02  Até Questionario ?                      				|
|  03  De Ficha Médica ?                       				|
|  04  Até Ficha Médica ?                      				|
|  05  Filtrar Questoes ?                      				|
|  06  De  Data Realizacao ?                   				|
|  07  Ate Data Realizacao ?                   				|
|  08  Modelo Relatorio    ?                   				|
|  09  Perguntas por Linha ?                   				|
|  10  Deseja imprimir observações em branco ? 				|
| 																	|
//PERGUNTAS PRESTADOR											|
|  01  Cliente ?                               				|
|  02  Loja                                    				|
|  03  De Questionario ?                       				|
|  04  Até Questionario ?                      				|
|  05  De Ficha Médica ?                       				|
|  06  Até Ficha Médica ?                      				|
|  07  Filtrar Questoes ?                      				|
|  08  De  Data Realizacao ?                   				|
|  09  Ate Data Realizacao ?                   				|
|  10  Modelo Relatorio    ?                   				|
|  11  Perguntas por Linha ?                   				|
|  12  Deseja imprimir observações em branco ? 				|
//-----------------------------------------------------------
*/

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR410"

If Valtype(aDad145) == "A"
	For nFor := 1 To Len(aDad145)
		&(aDad145[nFor,1]) := aDad145[nFor,2]
	Next nFor
Else
	If !pergunte(cPerg,.T.)
		Return
	Endif
	If lSigaMdtps
		If mv_par10 == 2
			lPrintTel := .f.
		Endif
	Else
		If mv_par08 == 2
			lPrintTel := .f.
		Endif
	Endif
Endif

If lSigaMdtps

	dbSelectArea("TMG")
	dbSetOrder(02)  //TMG_FILIAL+TMG_CLIENT+TMG_LOJA+TMG_QUESTI
	dbSeek(xFilial("TMG")+MV_PAR01+MV_PAR02+MV_PAR03)

Else

	dbSelectArea("TMG")
	dbSetOrder(01)
	dbSeek(xFilial("TMG")+MV_PAR01)

Endif

cDESQUEST := STR0083

If lSigaMdtps
	titulo := titulo + "  " + cDESQUEST + " ("+DTOC(MV_PAR08)+" a "+DTOC(MV_PAR09)+")"
Else
	titulo := titulo + "  " + cDESQUEST + " ("+DTOC(MV_PAR06)+" a "+DTOC(MV_PAR07)+")"
EndIf

If !lPrinGraf
	RptStatus({|lEnd| R410Imp2(@lEnd,wnRel,titulo,tamanho)},titulo)
Else
	Processa({|lEnd| U_fImpMod2()})
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha(lImpGrf,nSaltoGrf)
Local nLinhaTot := 3200 //Define o limite de linhas do questionário

If Valtype(lImpGrf) == "L"
	If lImpGrf
		If Valtype(nSaltoGrf) == "N"
			lin += nSaltoGrf
		Else
			lin += 60
		Endif
		If lin > nLinhaTot
			oPrint:Line(lin,100,lin,2300)
			lin := 150
			oPrint:EndPage() //Fechar Pagina
			fInicPagina() //Iniciar Pagina
			//oPrint:Line(lin,200,lin,2300)
		Endif
		Return
	Endif
Endif

Li++
If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
EndIf

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ MDT410TMH³ Autor ³ André E. Perez Álvarez³ Data ³ 07/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida a pergunta De Pergunta (prestador)                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDT410TMH()

Return If(empty(mv_par07),.t.,ExistCpo("TMH",mv_par01+mv_par02+mv_par03+mv_par07,2))
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ MDT410TMH³ Autor ³ André E. Perez Álvarez³ Data ³ 07/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida a pergunta Ate Pergunta (prestador)                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDTTMH410()

Return ValAte3(mv_par07,mv_par08,'TMH','TMH_QUESTA',mv_par01+mv_par02+mv_par03,2)
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ MDT410FIC³ Autor ³ André E. Perez Álvarez³ Data ³ 08/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida a pergunta De Ficha Medica (prestador)              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDT410FIC()

Return IF(empty(mv_par05),.t.,existcpo('TM0',mv_par01+mv_par02+mv_par05,8))
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ MDTFIC410³ Autor ³ André E. Perez Álvarez³ Data ³ 08/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida a pergunta Ate Ficha Medica (prestador)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDTFIC410()

Return ValAte3(mv_par05,mv_par06,'TM0','TM0_NUMFIC',mv_par01+mv_par02,8)

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³LoadArTmp ³ Autor ³ Denis                 ³ Data ³ 20/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Carrega arquivo temporario                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function LoadArTmp(lCombTK0,lRelGraf)

Local nLenCompl := (TAMSX3("TMI_COMRES")[1])
Local nX

If nLenCompl < 30
	nLenCompl := 30
Endif

aDBF := {}
AADD(aDBF,{ "QUESTI" , "C" ,06, 0 })
AADD(aDBF,{ "MATRICULA" , "C" ,06, 0 })
AADD(aDBF,{ "NUMFICHA"  , "C" ,09, 0 })
AADD(aDBF,{ "PERGUNTA"  , "C" ,03, 0 })
AADD(aDBF,{ "NOMPERGU"  , "C" ,nSizeTMH, 0 })
AADD(aDBF,{ "RESPOS"    , "C" ,01, 0 })
AADD(aDBF,{ "DTREAL"    , "D" ,08, 0 })
AADD(aDBF,{ "QUANTID"   , "N" ,09, 2 })
AADD(aDBF,{ "COMPLEM"   , "C" ,nLenCompl, 0 })
AADD(aDBF,{ "CODGRUPO"  , "C" ,03, 0 })
AADD(aDBF,{ "XCOMBO"   , "C" ,250, 0 })

//Cria TRB
oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
oTempTRB:AddIndex( "1", {"NUMFICHA","DTREAL","CODGRUPO","PERGUNTA"} )
oTempTRB:Create()

aDBF2 := {}
AADD(aDBF2,{ "PERGUNTA" , "C" ,03, 0 })
AADD(aDBF2,{ "NOMPERGU" , "C" ,nSizeTMH, 0 })
AADD(aDBF2,{ "RESPSIM"  , "N" ,06, 0 })
AADD(aDBF2,{ "RESPNAO"  , "N" ,06, 0 })

//Cria TRB
oTempTRB2 := FWTemporaryTable():New( "TRB2", aDBF2 )
oTempTRB2:AddIndex( "1", {"PERGUNTA"} )
oTempTRB2:Create()

If lSigaMdtps

	dbSelectArea("TMI")
	dbSetOrder(04)  //TMI_FILIAL+TMI_CLIENT+TMI_LOJA+TMI_QUESTI
	dbSeek(xFilial("TMI")+MV_PAR01+MV_PAR02+MV_PAR03)

	If lRelGraf
		ProcRegua(LastRec())
	Else
		SetRegua(LastRec())
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TMI para ler as  Questoes                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While !Eof()                                   .AND.;
	      TMI->TMI_FILIAL == xFilial('TMI')        .AND.;
	      TMI->(TMI_CLIENT+TMI_LOJA) == MV_PAR01+MV_PAR02


		If lRelGraf
			IncProc()
		Else
			IncRegua()
		Endif

		If TMI->TMI_NUMFIC < mv_par05 .or. TMI->TMI_NUMFIC > mv_par06
			dbSelectArea("TMI")
			dbSkip()
			Loop
		Endif

		If TMI->TMI_QUESTI < MV_PAR03 .OR. TMI->TMI_QUESTI > MV_PAR04
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(1)
		If !dbSeek(xFilial("TM0")+TMI->TMI_NUMFIC)
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		If TMI->TMI_DTREAL < MV_PAR08 .OR. TMI->TMI_DTREAL > MV_PAR09
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		TRB->(DbAppend())

		TRB->QUESTI   	:= TMI->TMI_QUESTI
		TRB->MATRICULA  := TM0->TM0_MAT
		TRB->NUMFICHA   := TMI->TMI_NUMFIC
		TRB->PERGUNTA   := TMI->TMI_QUESTA
		TRB->NOMPERGU   := TMH->TMH_PERGUN
		TRB->RESPOS     := TMI->TMI_RESPOS
		TRB->DTREAL     := TMI->TMI_DTREAL
		TRB->QUANTID    := TMI->TMI_QTRESP
		TRB->COMPLEM    := TMI->TMI_COMRES
		TRB->XCOMBO   := TMH->TMH_COMBO
		TRB->CODGRUPO := TMH->TMH_CODGRU

		If mv_par07 == 1
			If Len(aQuesSelc) > 0
				For nX:=1 to Len(aQuesSelc)
					If	aQuesSelc[nX][1] == TMI->TMI_QUESTI .And. aQuesSelc[nX][5] == .T.
						dbSelectArea("TRB2")
						If !dbSeek(TMI->TMI_QUESTA)
							TRB2->(DbAppend())
							TRB2->PERGUNTA := TMI->TMI_QUESTA
							TRB2->NOMPERGU := TMH->TMH_PERGUN
						Endif

						If TMI->TMI_RESPOS = '1'
							TRB2->RESPSIM := TRB2->RESPSIM + 1
						Else
							TRB2->RESPNAO := TRB2->RESPNAO + 1
						Endif
					EndIf
				Next
			EndIf
		Else
			dbSelectArea("TRB2")
			If !dbSeek(TMI->TMI_QUESTA)
				TRB2->(DbAppend())
				TRB2->PERGUNTA := TMI->TMI_QUESTA
				TRB2->NOMPERGU := TMH->TMH_PERGUN
			Endif

			If TMI->TMI_RESPOS = '1'
				TRB2->RESPSIM := TRB2->RESPSIM + 1
			Else
				TRB2->RESPNAO := TRB2->RESPNAO + 1
			Endif
		EndIf

		dbSelectArea("TMI")
		dbSKIP()

	End

Else

	dbSelectArea("TMI")
	dbSetOrder(02)
	dbSeek(xFilial("TMI")+MV_PAR01,.T.)

	If lRelGraf
		ProcRegua(LastRec())
	Else
		SetRegua(LastRec())
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TMI para ler as  Questoes                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While !Eof() .AND. TMI->TMI_FILIAL == xFIlial('TMI')

		If lRelGraf
			IncProc()
		Else
			IncRegua()
		Endif

		If TMI->TMI_NUMFIC < mv_par03 .or. TMI->TMI_NUMFIC > mv_par04
			dbSelectArea("TMI")
			dbSkip()
			Loop
		Endif

       	If TMI->TMI_QUESTI < MV_PAR01 .OR. TMI->TMI_QUESTI > MV_PAR02
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		If TMI->TMI_DTREAL < MV_PAR06 .OR. TMI->TMI_DTREAL > MV_PAR07
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		If dbSeek(xFilial("TM0")+TMI->TMI_NUMFIC)
			If TM0->TM0_NUMFIC < MV_PAR03 .OR. TM0->TM0_NUMFIC > MV_PAR04
				dbSelectArea("TMI")
				dbSkip()
				loop
			Endif
		Else
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		TRB->(DbAppend())

		TRB->QUESTI   	:= TMI->TMI_QUESTI
		TRB->MATRICULA  := TM0->TM0_MAT
		TRB->NUMFICHA   := TMI->TMI_NUMFIC
		TRB->PERGUNTA   := TMI->TMI_QUESTA
		TRB->NOMPERGU   := TMH->TMH_PERGUN
		TRB->RESPOS     := TMI->TMI_RESPOS
		TRB->DTREAL     := TMI->TMI_DTREAL
		TRB->QUANTID    := TMI->TMI_QTRESP
		TRB->XCOMBO   := TMH->TMH_COMBO
		TRB->CODGRUPO := TMH->TMH_CODGRU

		If Mv_Par05 == 1
			If Len(aQuesSelc) > 0
				For nX:=1 to Len(aQuesSelc)
					If	aQuesSelc[nX][1] == TMI->TMI_QUESTI .And. aQuesSelc[nX][5] == .T.
						dbSelectArea("TRB2")
						If !dbSeek(TMI->TMI_QUESTA)
							TRB2->(DbAppend())
							TRB2->PERGUNTA := TMI->TMI_QUESTA
							TRB2->NOMPERGU := TMH->TMH_PERGUN
						Endif

						If TMI->TMI_RESPOS = '1'
							TRB2->RESPSIM := TRB2->RESPSIM + 1
						Else
							TRB2->RESPNAO := TRB2->RESPNAO + 1
						Endif
					EndIf
				Next
			EndIf
		Else
			dbSelectArea("TRB2")
			If !dbSeek(TMI->TMI_QUESTA)
				TRB2->(DbAppend())
				TRB2->PERGUNTA := TMI->TMI_QUESTA
				TRB2->NOMPERGU := TMH->TMH_PERGUN
			Endif
			If TMI->TMI_RESPOS = '1'
				TRB2->RESPSIM := TRB2->RESPSIM + 1
			Else
				TRB2->RESPNAO := TRB2->RESPNAO + 1
			Endif
		EndIf

		dbSelectArea("TMI")
		dbSKIP()

	End

Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fRetCbox ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 01/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao para mostar lista de opções ao entrar no campo      ³±±
±±³          ³ TMH_COMBO                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fRetCbox( cCboxTMH )
Local nPos,nPos1,cDesc,nXX,aCodBox
Local aBoxPerg := {}
Local cSemRes := "1="+STR0012+";"+"2="+STR0013+";"+"3="+STR0056 //"Sim"###"Nao"###"Sem Resposta"

nPos1 := aScan(aCboxSV,{|x| x[1] == Alltrim(cCboxTMH) })
If nPos1 > 0
	aBoxPerg := aClone( aCboxSV[nPos1,2] )
Else
	aCodBox := {"1","2","3","4","5","6","7","8","9",;
				"A","B","C","D","E","F","G","H","I",;
				"J","K","L","M","N","O","P","Q","R",;
				"S","T","U","V","W","X","Y","Z" }
	If cSemRes != Alltrim(cCboxTMH)
		For nXX := 1 To Len(aCodBox)
			nPos := At( aCodBox[nXX]+"=" , cCboxTMH )
			If nPos > 0
				nPos1 := At( ";" , Substr( cCboxTMH , nPos+2 ) )
				cDesc := Alltrim(Substr( cCboxTMH , nPos+2 ))
				If nPos1 > 0
					cDesc := Alltrim(Substr( cCboxTMH , nPos+2 , nPos1-1 ))
				Endif
				aAdd( aBoxPerg , { Alltrim(Substr(cDesc,1,30)) , aCodBox[nXX] } )
			Endif
		Next nXX
	Endif
	If Len(aBoxPerg) == 0
		aAdd( aBoxPerg , { STR0012 , "1" } ) //"Sim"
		aAdd( aBoxPerg , { STR0013 , "2" } ) //"Nao"
	Endif
	aAdd(aCboxSV , { Alltrim(cCboxTMH) , aBoxPerg } )
Endif

Return aBoxPerg

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fInicPagina³Autor ³Denis Hyroshi de Souza ³ Data ³ 01/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao para imprimir cabeçalho do relatorio                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fInicPagina()

oPrint:StartPage() //Iniciar Pagina
oPrint:Box(150,100,330,2300,"-8")

If File( cStartPath + "LGRL" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".png" )

	// Empresa + Filial
	cLogo := cStartPath + "LGRL" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".png"

ElseIf File( cStartPath + "LGRL" + SM0->M0_CODIGO + ".png" )

	 // Empresa
	cLogo := cStartPath + "LGRL" + SM0->M0_CODIGO + ".png"

ElseIf File( cStartPath + "LGRL" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".bmp" )

	// Empresa + Filial
	cLogo := cStartPath + "LGRL" + SM0->M0_CODIGO + SM0->M0_CODFIL + ".bmp"

ElseIf File( cStartPath + "LGRL" + SM0->M0_CODIGO + ".bmp" )

	// Empresa
	cLogo := cStartPath + "LGRL" + SM0->M0_CODIGO + ".bmp"

EndIf

oPrint:SayBitMap( 160, 110, cLogo, 310, 150 )

nColInic := 530
nTamTit  := Int(Len(cDESQUEST)/2)
nTamTit  := If(nTamTit>20,20,nTamTit)
nTamTit  := If(nTamTit==0,1,nTamTit)
nColInic := 530 + ( ( 20 - nTamTit ) * 38 )
If Len(cDESQUEST) > 36
	oPrint:Say(250,510,Substr(cDESQUEST,1,40),oFont18b) //Nome Questionario
Else
	oPrint:Say(250,nColInic,Substr(cDESQUEST,1,40),oFont19b) //Nome Questionario
Endif

nPag410++
oPrint:Say(170,2070,STR0053 + cValToChar(nPag410),oFont08) //"Pág.: "
oPrint:Say(210,2070,STR0054 + cValToChar(dDataBase),oFont08) //"Data: "
oPrint:Say(250,2070,STR0055 + Time(),oFont08) //"Hora: "
lin := 370

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ fRetPres ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 01/04/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Localiza ultimo diagnostico                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fRetPres( nFichaMed , dRealData , nPesoTM0 , nAltTM0 )
Local aRet := { " " , 0 , 0 , " " , " " , 0 , 0, 0}


dbSelectArea("TMT")
dbSetOrder(3)
dbSeek(xFilial("TMT")+nFichaMed+DTOS(dRealData),.t.)
If Eof() .Or. Bof() .Or. TMT->TMT_FILIAL != xFilial("TMT") .Or. TMT->TMT_NUMFIC != nFichaMed .Or. TMT_DTCONS != dRealData
	dbSkip(-1)
Endif
While !Eof() .and. !Bof() .and. TMT->TMT_FILIAL == xFilial("TMT") .and. TMT->TMT_NUMFIC == nFichaMed
	If !Empty( TMT->TMT_PREART )
		aRet[1] := TMT->TMT_PREART
	ElseIf !Empty( TMT->TMT_PRESIS ) .And. !Empty( TMT->TMT_PREDIS )
		aRet[1] := cValToChar( TMT->TMT_PRESIS ) + " x " + cValToChar( TMT->TMT_PREDIS )
	Endif
	If !Empty(TMT->TMT_PESO) .and. Empty(aRet[2])
		aRet[2] := TMT->TMT_PESO
	Endif
	If !Empty(TMT->TMT_ALTURA) .and. Empty(aRet[3])
		aRet[3] := TMT->TMT_ALTURA
	Endif
	If !Empty(TMT->TMT_PULSO) .and. Empty(aRet[4])
		aRet[4] := TMT->TMT_PULSO
	Endif
	If !Empty(TMT->TMT_RESPI) .and. Empty(aRet[5])
		aRet[5] := TMT->TMT_RESPI
	Endif
	If !Empty(TMT->TMT_DINAMO)
		aRet[8] := TMT->TMT_DINAMO
	Endif
	If !Empty(TMT->TMT_AVODSE)
		aRet[6] := TMT->TMT_AVODSE
	Endif
	If !Empty(TMT->TMT_AVOESE)
		aRet[7] := TMT->TMT_AVOESE
	Endif
	dbSkip(-1)
	If !Empty(aRet[1]) .Or. !Empty(aRet[2]) .Or. !Empty(aRet[3])
		Exit
	Endif
End

If Empty(aRet[2])
	aRet[2] := nPesoTM0
Endif
If Empty(aRet[3])
	aRet[3] := nAltTM0
Endif

Return aRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R410Imp2 ³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R410Imp2(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cFICHA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// PRIVATE

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                 <Relatorio de Questionario Medico>                               DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

             1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Matricula  Nome Funcionario                           Sexo       Admissao   Idade
Perg. Descricao Pergunta                                         Resp. Dt.Resp.  Quantidade Complemento
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxx  99/99/99      99

xxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxx   99/99/99 999.999.999 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxx   99/99/99 999.999.999 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Resumo do Questionario  ( NOME DO QUESTIONARO )
Total de Funcionarios pesquisados.: 999.999
Per.  Descricao Pergunta                                                  Sim        Nao  Sem Respos.
xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    999.999    999.999     999.999
xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx    999.999    999.999     999.999


TAMANHO G
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
          1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
Matricula  Nome Funcionario                           Sexo       Admissao   Idade
Perg. Descricao Pergunta                                                                                                                                      Resp. Dt.Resp.  Quantidade Complemento
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxx   123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890  Sim   99/99/99 999.999.999 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


Per.  Descricao Pergunta                                                                                                                                                                Sim        Nao  Sem Respos.
xxx   12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890    999.999    999.999     999.999
*/

LoadArTmp2(.F.,.F.)

cabec1 := STR0007 //"Matricula  Nome Funcionario                           Sexo       Admissao   Idade"
cabec2 := STR0008 //"Perg. Descricao Pergunta                                         Resp. Dt.Resp.  Quantidade Complemento"
If nSizeTMH > 60
	cabec2 := STR0025 //"Perg. Descricao Pergunta                                                                                                                                      Resp. Dt.Resp.  Quantidade Complemento"
Endif

dbSelectArea("TRB")
dbGOTOP()

If Eof()
	MsgInfo(STR0023)  //"Não há nada para imprimir no relatório."
	oTempTRB2:Delete()
	Return .F.
Else
	If lSigaMdtps
		Somalinha2()
		@Li,000 PSAY STR0024 + MV_PAR01 +"-"+ MV_PAR02 +" - "+ NGSEEK("SA1",mv_par01+mv_par02,1,"SA1->A1_NOME")  //"Cliente/Loja: "
		Somalinha2()
	Endif
Endif

nTOTFUNC := 0
While ! eof()

	cFICHA := TRB->NUMFICHA

	nTOTFUNC := nTOTFUNC + 1

	Somalinha2()
	@Li,000 PSAY TRB->MATRICULA PICTURE "@!"

	dbSelectArea("SRA")
	dbSetOrder(01)
	dbSeek(xFilial("SRA")+TRB->MATRICULA)

	dbSelectArea("TM0")
	dbSetOrder(01)
	dbSeek(xFilial("TM0")+cFICHA)

	@Li,011 PSAY substr(TM0->TM0_NOMFIC,1,40)

	If TM0->TM0_SEXO = '1'
		@Li,054 PSAY STR0010 //'Masculino'
	Else
		@Li,054 PSAY STR0011 //'Feminino'
	Endif

	@Li,065 PSAY SRA->RA_ADMISSA      PICTURE '99/99/99'
	@Li,079 PSAY YEAR(DATE()) - YEAR(TM0->TM0_DTNASC)  PICTURE '99'
	Somalinha2()

	dbSelectArea("TRB")

	While ! eof() .and. TRB->NUMFICHA == cFICHA

		SomaLinha2()
		@ Li,000 PSAY TRB->PERGUNTA  PICTURE "@!"
		If nSizeTMH <= 60
			@ Li,004 PSAY Substr(TRB->NOMPERGU,1,60)
			If TRB->RESPOS = '1'
				@ Li,065 PSAY STR0012 //'Sim'
			Else
				@ Li,065 PSAY STR0013 //'Nao'
			Endif
			@ Li,071 PSAY TRB->DTREAL    PICTURE '99/99/99'
			@ Li,082 PSAY TRB->QUANTID   PICTURE '@E 999,999.99'
			@ LI,094 PSAY Substr(TRB->COMPLEM,1,30)
		Else
			@ Li,006 PSAY Substr(TRB->NOMPERGU,1,150)
			If TRB->RESPOS = '1'
				@ Li,158 PSAY STR0012 //'Sim'
			Else
				@ Li,158 PSAY STR0013 //'Nao'
			Endif
			@ Li,164 PSAY TRB->DTREAL    PICTURE '99/99/99'
			@ Li,173 PSAY TRB->QUANTID   PICTURE '@E 999,999.99'
			@ LI,185 PSAY Substr(TRB->COMPLEM,1,30)
		Endif

		dbSelectArea("TRB")
		dbskip()
	Enddo

	SomaLinha2()

Enddo

If nTOTFUNC > 0
	SomaLinha2()
	@ LI,000 PSAY Replicate("-",132)
	SomaLinha2()
	If lSigaMdtps
		@ LI,000 PSAY STR0014 + cDESQUEST + " ("+DTOC(MV_PAR08)+" a "+DTOC(MV_PAR09)+")" //"Resumo do Questionario - "
	Else
		@ LI,000 PSAY STR0014 + cDESQUEST + " ("+DTOC(MV_PAR06)+" a "+DTOC(MV_PAR07)+")" //"Resumo do Questionario - "
	Endif
	SomaLinha2()
	@ LI,000 PSAY STR0015 //"Total de Funcionarios ou Candidatos Pesquisados.:"
	@ LI,050 PSAY nTOTFUNC PICTURE '@E 999,999'
	SomaLinha2()
	If nSizeTMH <= 60
		@ LI,000 PSAY STR0016 //"Per.  Descricao Pergunta                                                  Sim        Nao  Sem Respos."
	Else
		@ LI,000 PSAY STR0026 //"Per.  Descricao Pergunta                                                                                                                                                                Sim        Nao  Sem Respos."
	Endif

	SomaLinha2()
	dbSelectArea("TRB2")
	dbGOTOP()

	While ! eof()
		SomaLinha2()
		@ Li,000 PSAY TRB2->PERGUNTA                           PICTURE "@!"
		If nSizeTMH <= 60
			@ Li,006 PSAY Substr(TRB2->NOMPERGU,1,57)
			@ Li,070 PSAY TRB2->RESPSIM                            PICTURE '@E 999,999'
			@ Li,081 PSAY TRB2->RESPNAO                            PICTURE '@E 999,999'
			nTot := nTOTFUNC-(TRB2->RESPSIM + TRB2->RESPNAO)
			If nTot < 0
				nTot := 0
			EndIf
			@ Li,093 PSAY nTOT PICTURE '@E 999,999'
		Else
			@ Li,006 PSAY Substr(TRB2->NOMPERGU,1,170)
			@ Li,180 PSAY TRB2->RESPSIM                            PICTURE '@E 999,999'
			@ Li,191 PSAY TRB2->RESPNAO                            PICTURE '@E 999,999'
			nTot := nTOTFUNC-(TRB2->RESPSIM + TRB2->RESPNAO)
			If nTot < 0
				nTot := 0
			EndIf
			@ Li,203 PSAY nTOT PICTURE '@E 999,999'
		Endif

		dbSelectArea("TRB2")
		dbskip()
	Enddo

Endif

// EJECT

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TM1")
Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

oTempTRB:Delete()
oTempTRB2:Delete()
dbSelectArea("TMI")
dbSetOrder(01)

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha2(nSaltoGrf)
Local nLinhaTot := 3200 //Define o limite de linhas do questionário

If Valtype(nSaltoGrf) == "N"
	lin += nSaltoGrf

	If lin > nLinhaTot
		oPrint:Line(lin,100,lin,2301,,"-8")
		lin := 150
		oPrint:EndPage() //Fechar Pagina
		fInicPagina() //Iniciar Pagina
		//oPrint:Line(lin,200,lin,2300)
	Endif
Else
	Li++
	If Li > 58
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIf
EndIf
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ fImpMod2 ³ Autor ³ André E. Perez Álvarez³ Data ³ 08/05/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³  												          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function fImpMod2(a410Tipo)
Local nXYZ, nXX, LinhaCorrente, nYY
Local cAliasCC := "SI3"
Local cCodCC2  := "I3_CUSTO"
Local cDescCC2 := "SI3->I3_DESC"
Local cTemp    := Alltrim(GetTempPath())
Local aImagens := {"ngradiono.png","ngradiook.png","ngcheckno.png","ngcheckok.png"}
Local cBarras  := If(isSrvUnix(),"/","\")
Local nIndTMH, cSeekTMH, cCondTMH, nX, lQs
Local cQuesti := If(lSigaMdtps, mv_par03, mv_par01)
Local cRespos := "TMH->TMH_RESPOS"
Local aArea := GetArea()
Local nDescBox:=0
Local nXZ:=0
Local nAdicLinha := 0 //Utilizado para adicionar valor a linha
Local lLinha50 := .F. //Verifica se ja foi adicionado o valor.
Local nLinhaTot := 3200 //Define o limite de linhas do questionário
Local nContGrp  := 1
Local lTemCRLF  := .F.
Local lTemLF    := .F.
Local lDoisTerm := .F.
Local LinhaUm   := 0
Local cTitulo   := STR0105

Private cStartPath := AllTrim(GetSrvProfString("Startpath",""))
Private cBarraSrv := "\"
Private cBarSrv2 := "\\"
Private cLogo
Private aCadTipo := {}

If Valtype(a410Tipo) == "A"
	aCadTipo := aClone(a410Tipo)
Endif

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC2  := "CTT_CUSTO"
	cDescCC2 := "CTT->CTT_DESC01"
Endif

If isSRVunix()  //servidor eh da familia Unix (linux, solaris, free-bsd, hp-ux, etc.)

	cBarraSrv := "/"
	cBarSrv2  := "//"

	// Tratamento para remover espaços do título devido a erros ao salvar arquivo
	cTitulo   := StrTran( cTitulo, " ", "" )

Endif

If Substr(cStartPath,Len(cStartPath),1) <> cBarraSrv
	cStartPath := cStartPath+cBarraSrv
Endif

Private nTipLine := If(lSigaMdtPs,mv_par11,mv_par09)
Private nOrdTMI := NGRETORDEM("TMI","TMI_FILIAL+TMI_NUMFIC+TMI_QUESTI+DTOS(TMI_DTREAL)+TMI_QUESTA+TMI_RESPOS",.F.)
Private lin := 9999
Private nPag410 := 0
Private oPrint
Private oFont08  := TFont():New("Arial",08,08,,.F.,,,,.F.,.F.)
Private oFont09  := TFont():New("Arial",09,09,,.F.,,,,.F.,.F.)
Private oFont10b := TFont():New("Arial Black",10,10,,.T.,,,,.F.,.F.)
Private oFont10  := TFont():New("Arial",10,10,,.F.,,,,.F.,.F.)
Private oFont11n := TFont():New("Arial Black",11,11,,.T.,,,,.F.,.F.)
Private oFont14  := TFont():New("Arial Black",14,14,,.T.,,,,.F.,.F.)
Private oFont18b := TFont():New("Arial Black",18,18,,.T.,,,,.F.,.F.)
Private oFont19b := TFont():New("Arial Black",19,19,,.T.,,,,.F.,.F.)
Private oPreto
Private aCboxSV  := {}
Private cFilPg := ""

//pergunta Filtrar Questoes?
If lSigaMdtps
	cFilPg := "mv_par07"
	nMostMemo := "mv_par12"
Else
	cFilPg := "mv_par05"
	nMostMemo := "mv_par10"
EndIf
If !Empty(&(cFilPg))
	If &(cFilPg) == 1 .And. Len(aQuesSelc) == 0
		MsgInfo(STR0023)  //"Não há nada para imprimir no relatório."
		RestArea( aArea )
		Return .F.
	EndIf
EndIf

cTemp := cTemp + If(Right(cTemp,1)==cBarras,"",cBarras)
//Cria Pasta Temp
If !ExistDir(cTemp)
	MakeDir(cTemp)
EndIf
For nYY := 1 to Len(aImagens)
	//Exclui imagem se ela ja existir no diretorio
	FErase(cTemp+aImagens[nYY])

	//Exporta imagens do RPO para a pasta especificada
	Resource2File(aImagens[nYY],cTemp+aImagens[nYY])

	//---------------------------------------------------------
	// Exporta imagem para BMP para funcionar com o TMSPrinter
	//---------------------------------------------------------
	oBmp := TBitmap():New(0,0,0,0,,,.T.,,,,,.F.,,,,,.T.)
		oBmp:Hide()
		oBmp:Load(,StrTran(aImagens[nYY],'.png',''))

		oBmp:lStretch:= .T.
		oBmp:lTransparent := .T.
		nAltura  := oBmp:nClientHeight
		nLArgura := oBmp:nClientWidth
		oBmp:nHeight := nAltura
		oBmp:nWidth  := nLargura
		oBmp:SaveAsBmp(cTemp+StrTran(lower(aImagens[nYY]),".png",".bmp"))
		oBmp:Free()
Next nX

oPrint := FWMSPrinter():New( cTitulo, IMP_PDF, Nil, Nil, .T. ) //"Questionario Medico"
oPrint:SetParm( '-RFS' )
oPrint:SetResolution( 72 )
oPrint:SetPortrait()
oPrint:SetPaperSize( DMPAPER_A4 )
oPrint:SetMargin( 10, 10, 10, 10 )

oPreto := TBrush():New( Nil, RGB( 000, 000, 000 ) )

	LoadArTmp2(.T.,.T.,Len(aCadTipo))

	dbSelectArea("TRB")
	dbGoTop()
	lTemDados := .t.
	If Eof()
		lTemDados := .f.
	Endif
	While !Eof()

		cFICHA := TRB->NUMFICHA
		dDTSAV := TRB->DTREAL
		nPag410 := 0

		//Verifica se há algum questionário com perguntas selecionadas nessa ficha médica.
		If !Empty(&(cFilPg))
			If &(cFilPg) == 1 //Filtrar perguntas? Sim
				lQs := .F.
				dbSelectArea("TMI")
				dbSetOrder(03)
				dbSeek(xFilial("TMI")+cFICHA)
				While !Eof() .And. lQs = .F.
					For nx:=1 to Len(aQuesSelc)
						If aQuesSelc[nX][5] == .T. .And. ;
							aQuesSelc[nX][1] == TMI->TMI_QUESTI
							lQs := .T.
							Exit
						EndIf
					Next
				End
				If !lQs
					dbSelectArea("TRB")
					dbSkip()
					Loop
				EndIf
			EndIf
		EndIf
		fInicPagina()

		dbSelectArea("TM0")
		dbSetOrder(01)
		dbSeek(xFilial("TM0")+cFICHA)
		cCodFuncao := TM0->TM0_CODFUN
		cCodCcusto := TM0->TM0_CC
		dbSelectArea("SRA")
		dbSetOrder(01)
		If dbSeek( xFilial("SRA",TM0->TM0_FILFUN) + TM0->TM0_MAT )
			cCodFuncao := SRA->RA_CODFUNC
			cCodCcusto := SRA->RA_CC
		Endif
		dbSelectArea("SRJ")
		dbSetOrder(01)
		dbSeek( xFilial("SRJ") + cCodFuncao )
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek( xFilial(cAliasCC) + cCodCcusto )

		oPrint:Line(330,100,550,100,,"-8")
		oPrint:Line(330,2301,550,2301,,"-8")
		oPrint:Line(550,100,550,2301,,"-8")
		oPrint:Line(390,100,390,2301,,"-8")

		oPrint:Say(360,110,"1. "+STR0027,oFont10b) //"IDENTIFICAÇÃO"
		oPrint:Say(420,110,STR0028+":",oFont10b) //"Nome"
		oPrint:Say(420,510,TM0->TM0_NOMFIC,oFont10)
		oPrint:Say(470,110,STR0029+":",oFont10b) //"Função"
		oPrint:Say(470,510,SRJ->RJ_DESC,oFont10)
		oPrint:Say(520,110,STR0030+":",oFont10b) //"Centro de Custo"
		oPrint:Say(520,510,&(cDescCC2),oFont10)

		cIdade := Alltrim( Str( Int((dDataBase - TM0->TM0_DTNASC) / 365) , 10 ) )
		oPrint:Say(420,1500,STR0031+":",oFont10b) //"Idade"
		oPrint:Say(420,1640,cIdade,oFont10)
		oPrint:Say(420,1810,STR0032+":",oFont10b) //"Sexo"
		oPrint:Say(420,1950,If(TM0->TM0_SEXO=="1",STR0010,STR0011),oFont10) //Masculino Feminino
		oPrint:Say(470,1500,STR0033+":",oFont10b) //"Data do Questionário"
		oPrint:Say(470,1950,DtoC(TRB->DTREAL),oFont10)
		oPrint:Say(520,1500,STR0034+":",oFont10b) //"Data Admissão"
		oPrint:Say(520,1950,DtoC(SRA->RA_ADMISSA),oFont10)

		oPrint:Line(550,100,870,100,,"-8")
		oPrint:Line(550,2301,870,2301,,"-8")
		oPrint:Line(870,100,870,2301,,"-8")
		oPrint:Line(610,100,610,2301,,"-8")

		aVetDiag := fRetPres( TM0->TM0_NUMFIC , TRB->DTREAL , TM0->TM0_PESO , TM0->TM0_ALTURA )
		oPrint:Say(580,110,"2. "+STR0035,oFont10b) //"EXAME FÍSICO"
		oPrint:Say(635,110,STR0036+":",oFont10b) //"Sinais Vitais"
		oPrint:Say(690,150,STR0037+":",oFont10b) //"PA"
		oPrint:Say(690,310, aVetDiag[1] ,oFont10)
		oPrint:Say(740,150,STR0038+":",oFont10b) //"Medidas Antopométricas"
		oPrint:Say(790,150,STR0039+":",oFont10b) //"Peso"
		If aVetDiag[2] <> 0
			oPrint:Say(790,310,Alltrim(Transform(aVetDiag[2],"@E 999.9")) + " " + STR0040,oFont10) //"KG"
		Endif
		oPrint:Say(840,150,STR0041+":",oFont10b) //"Altura"
		If aVetDiag[3] <> 0
			oPrint:Say(840,310,Transform(aVetDiag[3],"@E 9.99") + " "+"M",oFont10)
		Endif
		oPrint:Say(640,800,STR0042+":",oFont10b) //"Possui alguma deficiência"
		oPrint:Say(695,840,STR0043,oFont10) //"Física"
		oPrint:Say(745,840,STR0044,oFont10) //"Visual"
		oPrint:Say(795,840,STR0045,oFont10) //"Auditiva"
		oPrint:Say(845,840,STR0046,oFont10) //"Nenhuma"
		oPrint:Box(675,800,705,830,"-8")
		oPrint:Box(725,800,755,830,"-8")
		oPrint:Box(775,800,805,830,"-8")
		oPrint:Box(825,800,855,830,"-8")
		oPrint:Say(640,1500,STR0067+":",oFont10b)//"Pulso(BPM)"
		oPrint:Say(640,1950, Alltrim(aVetDiag[4]) ,oFont10)
		oPrint:Say(690,1500,STR0068+":",oFont10b) //"Respiração(MPM)"
		oPrint:Say(690,1950, Alltrim(aVetDiag[5]) ,oFont10)
		oPrint:Say(740,1500,STR0069+":",oFont10b)//"Acuidade Visual O.D."
		oPrint:Say(740,1950, Alltrim(Str(aVetDiag[6])) ,oFont10)
		oPrint:Say(790,1500,STR0070+":",oFont10b)//"Acuidade Visual O.E."
		oPrint:Say(790,1950, Alltrim(Str(aVetDiag[7])) ,oFont10)
		oPrint:Say(840,1500,STR0071+":",oFont10b)//"Dinamometria"
		oPrint:Say(840,1950, Alltrim(Str(aVetDiag[8])) ,oFont10)
		If TM0->TM0_TIPDEF == "1"
			oPrint:FillRect( { 675, 800, 705, 830 }, oPreto )
		ElseIf TM0->TM0_TIPDEF == "2"
			oPrint:FillRect( { 775, 800, 805, 830 }, oPreto )
		ElseIf TM0->TM0_TIPDEF == "3"
			oPrint:FillRect( { 725, 800, 755, 830 }, oPreto )
		ElseIf TM0->TM0_TIPDEF $ "0/6" .or. Empty(TM0->TM0_TIPDEF)
			oPrint:FillRect( { 825, 800, 855, 830 }, oPreto )
		Endif

		lin := 800
		lPrimQuest := .t.

		If lSigaMdtps
			nIndTMH := 2
			cSeekTMH:= mv_par01+mv_par02+cQuesti
			cCondTMH:= "TMH->(TMH_FILIAL+TMH_CLIENT+TMH_LOJA+TMH_QUESTI)"
		Else
			nIndTMH := 1
			cSeekTMH:= cQuesti
			cCondTMH:= "TMH->(TMH_FILIAL+TMH_QUESTI)"
		Endif

		If Len(aCadTipo) == 0
			dbSelectArea("TMH")
			dbSetOrder(nIndTMH)
			dbGoTop()
			While !Eof()

				dbSelectArea("TMI")
				dbSetOrder(03)
				If !dbSeek(xFilial("TMI")+cFICHA+TRB->QUESTI)//TMH->TMH_QUESTI)
					dbSelectArea("TMH")
					dbSkip()
					Loop
				Endif
				If TMH->TMH_QUESTI <> TRB->QUESTI
					dbSelectArea("TMH")
					dbSkip()
					loop
				EndIf
				//Verifica se a pergunta foi selecionada
			If !Empty(&(cFilPg))
					If &(cFilPg) == 1 //Filtrar perguntas? Sim
						lQs := .F.
						For nx:=1 to Len(aQuesSelc)
							If aQuesSelc[nX][5] == .T. .And. ;
								aQuesSelc[nX][1] == TMH->TMH_QUESTI  .And. ;
								aQuesSelc[nX][2] == TMH->TMH_QUESTA
								lQs := .T.
								Exit
							EndIf
						Next
						If !lQs
							dbSelectArea("TMH")
							dbSkip()
							Loop
						EndIf
					EndIf
				EndIf

				//Verifica se o usuario precisa responder a pergunta
				If TMH->TMH_INDSEX <> "3"
					If (TMH->TMH_INDSEX == "1" .and. TM0->TM0_SEXO == "2") .OR.;
						(TMH->TMH_INDSEX == "2" .and. TM0->TM0_SEXO == "1")

						dbSelectArea( 'TMH' )
						dbSkip()
						loop
					Endif
				Endif
				aTipoTMH := {}
				If !Empty( &cRespos )
					aTipoTMH := fRetCombo(Alltrim( &cRespos ))
				Endif
				aTemp    := Array(Len(aTipoTMH),3)
				For nXX := 1 To Len(aTemp)
					If (TMH->TMH_TPLIST=="1")
						aTemp[nXX,1] := 0
					Else
						aTemp[nXX,1] := .F.
					Endif
					dbSelectArea("TMI")
					dbSetOrder(nOrdTMI)
					If dbSeek( xFilial("TMI") + TRB->NUMFICHA+TRB->QUESTI+DTOS(TRB->DTREAL)+TMH->TMH_QUESTA+SubStr(aTipoTMH[nXX],1,1) )
						If (TMH->TMH_TPLIST=="1")
							aTemp[nXX,1] := 1
						Else
							aTemp[nXX,1] := .T.
						Endif
					Endif
				Next nXX
				//Se não for inclusão
				cMemoM6 := ""

				dbSelectArea("TMI")
				dbSetOrder(nOrdTMI)
				If dbSeek( xFilial("TMI") + TRB->NUMFICHA+TRB->QUESTI+DTOS(TRB->DTREAL)+TMH->TMH_QUESTA+"#" )
					cMemoM6 := Alltrim(TMI->TMI_DESCRI)
				Else
					dbSelectArea("TMI")
					dbSetOrder(nOrdTMI)
				If dbSeek( xFilial("TMI") + TRB->NUMFICHA+TRB->QUESTI+DTOS(TRB->DTREAL)+TMH->TMH_QUESTA) .AND. Empty(cMemoM6)
						cMemoM6 := Alltrim(TMI->TMI_COMRES)
					Endif
				Endif

				//1 - Codigo Questão
				//2 - Descrição Questão
				//3 - Grupo
				//4 - Array de Opções
				//5 - Cbox
				//6 - Indica se é RADIO (.T.) ou CHECK (.F.)
				//7 - Indica se tem campo Memo
				//8 - Array (respostas,objeto)
				//9 - Ordem
				//10- Campo Memo
				//11- Qtd. Objetos x Pergunta
				//12- Página onde ficará a pergunta
				//13- Questionario

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ ATENCAO: A CONFIGURACAO DA VARIAVEL aCadTipo DEVE SER A MESMA DEFINIDA NO PROGRAMA MDTA145.PRX ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				aADD( aCadTipo , { TMH->TMH_QUESTA , Capital(TMH->TMH_PERGUN) , TMH->TMH_CODGRU , aTipoTMH ,;
								&cRespos , (TMH->TMH_TPLIST=="1") ,;
								(TMH->TMH_ONMEMO=="1") , aTemp , TMH->TMH_ORDEM ,cMemoM6, TRB->QUESTI, TMH->TMH_QUESTI, 0  , 0  } )
				dbSelectArea("TMH")
				dbSkip()
			End
		Endif
		If Len( aCadTipo ) > 0
			If Len(aCadTipo[1]) > 10
				aSort( aCadTipo ,,, { |x,y| x[11]+x[3]+x[9] < y[11]+y[3]+y[9] } )
			Else
				aSort( aCadTipo ,,, { |x,y| x[3]+x[9] < y[3]+y[9] } )
			Endif
		EndIf
		cOldGrupo := "#"
		cOldQuest := "#"
		If nTipLine <> 1
			lMemoAnt := .T.
			nTotAcu := 0
			nQtPer  := 0
			nLinAcu := 0
		Endif
		For nYY := 1 to Len(aCadTipo)

			If Len(aCadTipo[nYY]) > 10 //Caso impressao seja de apenas um questionario, não valida posição 11 da mudança de questionário
				If cOldQuest <> aCadTipo[nYY,11]
					cOldQuest := aCadTipo[nYY,11]
					dbSelectArea("TMG")
					dbSetOrder(01)
					dbSeek(xFilial("TMG")+cOldQuest)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Titulo do Questionario                         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					Somalinha2(70)
					oPrint:Box(lin,100,lin+100,2300,"-8")
					oPrint:Say(lin+40,110,"3. " + Upper(Alltrim(TMG->TMG_NOMQUE)),oFont10b)//NOME DO QUESTIONÁRIO
					Somalinha2(30)
					cOldGrupo := "#"
				Endif
			Endif

			If cOldGrupo <> aCadTipo[nYY,3]
				cOldGrupo := aCadTipo[nYY,3]
				cDesGrupo := " "
				dbSelectArea("TK0")
				dbSetOrder(01)
				If dbSeek( xFilial("TK0") + cOldGrupo )
					If !Empty(TK0->TK0_DESCRI)
						cDesGrupo := Capital( Alltrim(TK0->TK0_DESCRI) )
					Endif
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Titulo do Grupo                                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oPrint:Box(lin+40,100,lin+100,2300,"-8")
				oPrint:Say(lin+80,120,"3."+ CValToChar(nContGrp) +" - "+cDesGrupo,oFont10b)
				nContGrp++
				Somalinha2(70)
				If nTipLine <> 1
					nTotAcu := 0
					nLinAcu := If(lin > nLinhaTot .and. nTipLine == 2,280,lin)
					nQtPer  := 0
				Endif
			Endif
		nLimCol := 120
			nAcumLi := 0

		If nTipLine <> 1
				If lMemoAnt
					nLinAcu := If(lin > nLinhaTot .and. nTipLine == 2,280,lin)
					nAcumLi := 0
					nTotAcu := 0
					nQtPer  := 1
				Else
					If aCadTipo[nYY,7] .And. If( Mv_par10 == 2 , !Empty(aCadTipo[nYY,10]) , .T. )
						nLinAcu := If(lin > nLinhaTot .and. nTipLine == 2,280,lin)
						nAcumLi := 0
						nTotAcu := 0
						nQtPer  := 0
					Endif
					nAcumLi := nTotAcu
					nTot := Len(aCadTipo[nYY,2])
					nBox := 0
					For nXX := 1 To Len(aCadTipo[nYY,4])
						nBox += Len(SubStr(aCadTipo[nYY,4,nXX],3))
					Next nXX
					If nBox > nTot
						nTot := nBox
					Endif

					If nAcumLi+nTot > nLimCol
						nLinAcu := If(lin > nLinhaTot .and. nTipLine == 2,280,lin)
						nTotAcu := 0
						nQtPer  := 1
					Endif

					If nTipLine == 2
					If nQtPer == 0
						nAcumLi := 0
					Elseif nQtPer == 1 .and. nTotAcu <> 0
						nAcumLi := 60
						Endif
						If nQtPer < 2
							lin := nLinAcu
							nQtPer++
						Else
							nLinAcu := If(lin > nLinhaTot .and. nTipLine == 2,280,lin)
							nAcumLi := 0
							nTotAcu := 0
							nQtPer  := 1
						Endif
					Else
						lin := nLinAcu
					Endif
				Endif
				If aCadTipo[nYY,7] .And. If( Mv_par10 == 2 , !Empty(aCadTipo[nYY,10]) , .T. )
					lMemoAnt := .T.
					nAcumLi := 0
				Else
					lMemoAnt := .F.
				Endif
			ENdif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Titulo Questão                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Somalinha2(50)

			If mv_par09 == 1 //Caso seja uma pergunta por linha
				oPrint:Say(lin+40,If(nTipLine == 1,125,125+(nAcumLi*18)),aCadTipo[nYY,2],oFont11n)
			ELse //Caso seja 2 pergunta por linha
				nLinhasMemo := MLCOUNT(aCadTipo[nYY,2],50)//Quebra a linha
				For LinhaCorrente := 1 to nLinhasMemo
					If !Empty( (MemoLine(aCadTipo[nYY,2],50,LinhaCorrente)))
					If nLinhasMemo > 1 .And. LinhaCorrente == 2
							Somalinha2(50)
						EndIf
						oPrint:Say(lin+40,If(nTipLine == 1,125,125+(nAcumLi*18)),MemoLine(aCadTipo[nYY,2],50,LinhaCorrente),oFont11n)
				Endif
				Next LinhaCorrente
			EndIf

			oPrint:Line(lin-40,100,lin+60,100,,"-8")
			oPrint:Line(lin-40,2301,lin+60,2301,,"-8")
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Montando lista de opcoes (radio ou check)      ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nXX := 1 To Len(aCadTipo[nYY,4])
				cStrXX := Alltrim( Str(nXX) )
				If nXX = 1
					For nXZ:=1 to Len(aCadTipo[nYY,4]) //Percorre  o Array
						cDescBox := SubStr(aCadTipo[nYY,4,nXZ],3)//Verificar o todos os registros
						nDescBox:=If(Len(cDescBox) > nDescBox, Len(cDescBox),nDescBox)//Adiciona o registro de maior
					Next nXZ
				Endif
				cDescBox := SubStr(aCadTipo[nYY,4,nXX],3)
				If (nAcumLi + nDescBox + 5) > nLimCol .or. nXX == 1
					If nXX == 1
						Somalinha2(50)
					Else
						lMemoAnt := .T.
						Somalinha2(40)
					Endif
					nAcumLi := If(nTipLine == 1,0,nTotAcu)
					oPrint:Line(lin-30,100,lin+40,100,,"-8")
					oPrint:Line(lin-30,2301,lin+40,2301,,"-8")
				Endif

				If aCadTipo[nYY,6]
					If aCadTipo[nYY,8,nXX,1] == 0
						If File(cTemp+"ngradiono.png")
							oPrint:SayBitmap(Lin+35,120+(nAcumLi*18),cTemp+"ngradiono.png",30,32)
						Endif
					Else
						If File(cTemp+"ngradiook.png")
							oPrint:SayBitmap(Lin+35,120+(nAcumLi*18),cTemp+"ngradiook.png",30,32)
						Endif
					Endif
				Else
					If !aCadTipo[nYY,8,nXX,1]
						If File(cTemp+"ngcheckno.png")
							oPrint:SayBitmap(Lin+35,120+(nAcumLi*18),cTemp+"ngcheckno.png",30,32)
						Endif
					Else
						If File(cTemp+"ngcheckok.png")
							oPrint:SayBitmap(Lin+35,120+(nAcumLi*18),cTemp+"ngcheckok.png",30,32)
						Endif
					Endif
				Endif
				oPrint:Say(lin+60,120+(nAcumLi*18)+50,cDescBox,oFont10)
				nAcumLi += nDescBox + 9	//Variavel de controle da distancia entre os elementos
			Next nXX
			If nTipLine <> 1
				nTotAcu := If(Len(aCadTipo[nYY,2])+nTotAcu > nAcumLi,nTotAcu+Len(aCadTipo[nYY,2])+4,nAcumLi+4)
				nTotAcu := If(nTipLine == 2,If(nQtPer == 0,0,60),nTotAcu)
			Endif

			If mv_par09 == 2//Verifica se será impresso 2 perguntas por linha

				If nLinhasMemo > 1 .and. nQtPer == 1 //Verifica se é primeira pergunta da linha, e se houve quebra de linha.
					nAdicLinha:= 50 //Adiciona o valor a mais na linha
				EndIf

				lLinha50 := nLinhasMemo > 1 .and. nQtPer <> 1 //Verifica se é a segunda pergunta da mesma linha

				If nQtPer > 1 .And. nAdicLinha > 0 .And. !lLinha50 //Verifica esta na 2ª pergunta e se necessita adicionar o valor na linha.
					lin+= nAdicLinha //Adiciona o valor a linha.
					nAdicLinha:= 0 //Zera variavel.
				ELseIf nQtPer > 1 .And. nAdicLinha > 0 //Caso não seja preciso adicionar valor, zera variavel
					nAdicLinha:= 0 //Zera variavel
				Endif

			Endif

			Somalinha2(50)
			oPrint:Line(lin-30,100,lin+40,100,,"-8")
			oPrint:Line(lin-30,2301,lin+40,2301,,"-8")

			If aCadTipo[nYY,7] .And. If( Mv_par10 == 2 , !Empty(aCadTipo[nYY,10]) , .T. )
				If (&nMostMemo == 2 .And. !Empty(aCadTipo[nYY,10])) .Or. &nMostMemo == 1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Campo Memo                                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					lTemCRLF  := ( At( Chr( 13 ) + Chr( 10 ), aCadTipo[ nYY, 10 ] ) > 0 )
					lTemLF    := ( At( Chr( 10 ), StrTran( aCadTipo[ nYY, 10 ], Chr( 13 ) + Chr( 10 ), "" ) ) > 0 )
					lDoisTerm := ( lTemCRLF .and. lTemLF )
					If lDoisTerm .Or. ( !lTemLF .And. lTemCRLF )
						nLinhasMemo := MLCOUNT( aCadTipo[ nYY, 10 ], 160 )
					Else
						nLinhasMemo := MLCOUNT( aCadTipo[ nYY, 10 ], 160 )
					EndIf
					
					nLinhasMemo := If(nLinhasMemo<2,2,nLinhasMemo)
					LinhaUm := 1
					For LinhaCorrente := 1 To nLinhasMemo
						If LinhaUm == 1
							If Lin+85 > nLinhaTot
								Lin := 7777
							Endif
							Somalinha2(50)
							oPrint:Line(lin-40,100,lin+50,100,,"-8")
							oPrint:Line(lin-40,2301,lin+50,2301,,"-8")
							oPrint:Line(lin,120,lin+50,120,,"-8")
							oPrint:Line(lin,2280,lin+50,2280,,"-8")
							oPrint:Line(lin-5,120,lin-5,2280,,"-8")
						Else
							Somalinha2(45)
							oPrint:Line(lin-50,100,lin+40,100,,"-8")
							oPrint:Line(lin-50,2301,lin+40,2301,,"-8")
							oPrint:Line(lin-50,2280,lin+40,2280,,"-8")
							oPrint:Line(lin-50,120,lin+40,120,,"-8")
						Endif
						oPrint:Say(lin+33,150,MemoLine(aCadTipo[nYY,10],160,LinhaCorrente),oFont10)
						If LinhaCorrente == nLinhasMemo
							oPrint:Line(lin+40,120,lin+40,2280,,"-8")
							oPrint:Line(lin-25,100,lin+25,100,,"-8")
							oPrint:Line(lin-25,2301,lin+25,2301,,"-8")
						Endif
						LinhaUm ++
						If lin+540 > nLinhaTot
							oPrint:Line(lin+40,100,lin+40,2301,,"-8")
							LinhaUm := 1
							lin := 9999
						EndIf
					Next LinhaCorrente
				EndIf
			Endif

			If nYY != Len(aCadTipo)
				Somalinha2(10)
			Endif
			oPrint:Line(lin-30,100,lin+100,100,,"-8")
			oPrint:Line(lin-30,2301,lin+100,2301,,"-8")

			If lin+540 > nLinhaTot
				oPrint:Line(lin+100,100,lin+100,2301,,"-8")
				lin := 9999
			Endif

		Next nYY
		aCadTipo := {}

		If lin+540 > 3200
			lin := 9999
		Endif
		Somalinha2(90)
		oPrint:Line(lin,100,lin+540,100,,"-8")
		oPrint:Line(lin+60,1150,lin+540,1150,,"-8")
		oPrint:Line(lin,2301,lin+540,2301,,"-8")

		oPrint:Line(lin+60,100,lin+60,2301,,"-8")
		oPrint:Line(lin+120,100,lin+120,2301,,"-8")
		oPrint:Line(lin+220,100,lin+220,2301,,"-8")
		oPrint:Line(lin+280,100,lin+280,2301,,"-8")
		oPrint:Line(lin+380,100,lin+380,2301,,"-8")
		oPrint:Line(lin+440,100,lin+440,2301,,"-8")
		oPrint:Line(lin+540,100,lin+540,2301,,"-8")

		oPrint:Say(lin+50,110,"4. "+ STR0048,oFont10b) //"REGISTRO DE LEGITIMIDADE E VERACIDADE DAS INFORMAÇÕES"

		oPrint:Say(lin+100,450,STR0049,oFont10) //"DATA DO PREENCHIMENTO"
		oPrint:Line(lin+207,410,lin+207,850,,"-8")
		oPrint:Line(lin+205,557,lin+145,567,,"-8")
		oPrint:Line(lin+205,702,lin+145,709,,"-8")
		oPrint:Say(lin+100,1470,STR0050,oFont10) //"ASSINATURA DO COLABORADOR"
		oPrint:Line(lin+207,1200,lin+207,2250,,"-8")

		oPrint:Say(lin+260,450,STR0049,oFont10) //"DATA DO PREENCHIMENTO"
		oPrint:Line(lin+370,410,lin+370,850,,"-8")
		oPrint:Line(lin+370,557,lin+310,567,,"-8")
		oPrint:Line(lin+370,702,lin+310,709,,"-8")
		oPrint:Say(lin+260,1285,STR0057,oFont10) //"ASSINATURA DO AUXILIAR NO PREENCHIMENTO/TESTEMUNHA"
		oPrint:Line(lin+370,1200,lin+370,2250,,"-8")

		oPrint:Say(lin+420,450,STR0051,oFont10) //"DATA DA ANÁLISE E EXAME"
		oPrint:Line(lin+530,410,lin+530,850,,"-8")
		oPrint:Line(lin+530,557,lin+475,567,,"-8")
		oPrint:Line(lin+530,702,lin+475,709,,"-8")
		oPrint:Say(lin+420,1490,STR0052,oFont10) //"ASSINATURA DO MÉDICO EXAMINADOR"
		oPrint:Line(lin+530,1200,lin+530,2250,,"-8")

		oPrint:EndPage() //Fechar Pagina
		dbSelectArea("TRB")
		dbSkip()
	End

	If !lTemDados
		MsgInfo(STR0023)  //"Não há nada para imprimir no relatório."
	Else
		If lPrintTel
			oPrint:Preview()
		Else
			oPrint:Print()
		EndIf
	Endif

	If Type("oTempTRB") == "O"
		oTempTRB:Delete()
	EndIf
	If Type("oTempTRB2") == "O"
		oTempTRB2:Delete()
	EndIf

	RestArea( aArea )
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³LoadArTmp2³ Autor ³ Denis                 ³ Data ³ 20/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Carrega arquivo temporario                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function LoadArTmp2(lCombTK0,lRelGraf,nImp145)

Local nLenCompl := (TAMSX3("TMI_COMRES")[1])
Local nX
Local aArea := GetArea()

Default nImp145 := 0
If nLenCompl < 30
	nLenCompl := 30
Endif

aDBF := {}
AADD(aDBF,{ "QUESTI" , "C" ,06, 0 })
AADD(aDBF,{ "MATRICULA" , "C" ,06, 0 })
AADD(aDBF,{ "NUMFICHA"  , "C" ,09, 0 })
AADD(aDBF,{ "PERGUNTA"  , "C" ,03, 0 })
AADD(aDBF,{ "NOMPERGU"  , "C" ,nSizeTMH, 0 })
AADD(aDBF,{ "RESPOS"    , "C" ,01, 0 })
AADD(aDBF,{ "DTREAL"    , "D" ,10, 0 })
AADD(aDBF,{ "QUANTID"   , "N" ,09, 2 })
AADD(aDBF,{ "COMPLEM"   , "C" ,nLenCompl, 0 })
AADD(aDBF,{ "CODGRUPO"  , "C" ,03, 0 })
AADD(aDBF,{ "XCOMBO"    , "M" ,10, 0 })

//Cria TRB
oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
oTempTRB:AddIndex( "1", {"NUMFICHA","DTREAL","QUESTI","CODGRUPO","PERGUNTA"} )
oTempTRB:AddIndex( "2", {"NUMFICHA","DTREAL","PERGUNTA"} )
oTempTRB:Create()

aDBF2 := {}
AADD(aDBF2,{ "PERGUNTA" , "C" ,03, 0 })
AADD(aDBF2,{ "NOMPERGU" , "C" ,nSizeTMH, 0 })
AADD(aDBF2,{ "RESPSIM"  , "N" ,06, 0 })
AADD(aDBF2,{ "RESPNAO"  , "N" ,06, 0 })

//Cria TRB
oTempTRB2 := FWTemporaryTable():New( "TRB2", aDBF2 )
oTempTRB2:AddIndex( "1", {"PERGUNTA"} )
oTempTRB2:Create()

If nImp145 > 0
	dbSelectArea("TRB")
	If lSigaMdtps
		If !dbSeek(MV_PAR05+DTOS(MV_PAR08))
			TRB->(DbAppend())
			TRB->NUMFICHA   := MV_PAR05
			TRB->DTREAL     := MV_PAR08
		EndIf
	Else
		If !dbSeek(MV_PAR03+DTOS(MV_PAR06))
			TRB->(DbAppend())
			TRB->NUMFICHA   := MV_PAR03
			TRB->DTREAL     := MV_PAR06
		EndIf
	Endif
ElseIf lSigaMdtps

	dbSelectArea("TMI")
	dbSetOrder(04)  //TMI_FILIAL+TMI_CLIENT+TMI_LOJA+TMI_QUESTI
	dbSeek(xFilial("TMI")+MV_PAR01+MV_PAR02)

	If lRelGraf
		ProcRegua(LastRec())
	Else
		SetRegua(LastRec())
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TMI para ler as  Questoes                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While !Eof()                                   .AND.;
	      TMI->TMI_FILIAL == xFilial('TMI')        .AND.;
	      TMI->(TMI_CLIENT+TMI_LOJA) == MV_PAR01+MV_PAR02

		If lRelGraf
			IncProc()
		Else
			IncRegua()
		Endif

		If TMI->TMI_QUESTI < MV_PAR03 .OR. TMI->TMI_QUESTI > MV_PAR04
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		If TMI->TMI_NUMFIC < mv_par05 .or. TMI->TMI_NUMFIC > mv_par06
			dbSelectArea("TMI")
			dbSkip()
			Loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(1)
		If !dbSeek(xFilial("TM0")+TMI->TMI_NUMFIC)
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		If TMI->TMI_DTREAL < MV_PAR08 .OR. TMI->TMI_DTREAL > MV_PAR09
			dbSelectArea("TMI")
			dbSkip()
			loop
		Endif

		dbSelectArea("TRB")
		dbSetOrder( 1 )
		If !dbSeek(TMI->TMI_NUMFIC+DTOS(TMI->TMI_DTREAL)+TMI->TMI_QUESTI)
			TRB->(DbAppend())

		   	TRB->QUESTI   	:= TMI->TMI_QUESTI
			TRB->MATRICULA  := TM0->TM0_MAT
			TRB->NUMFICHA   := TMI->TMI_NUMFIC
			TRB->PERGUNTA   := TMI->TMI_QUESTA
			TRB->NOMPERGU   := TMH->TMH_PERGUN
			TRB->RESPOS     := TMI->TMI_RESPOS
			TRB->DTREAL     := TMI->TMI_DTREAL
			TRB->QUANTID    := TMI->TMI_QTRESP
			TRB->COMPLEM    := TMI->TMI_COMRES
			TRB->XCOMBO   := TMH->TMH_RESPOS
			TRB->CODGRUPO := TMH->TMH_CODGRU
		EndIf

		If Mv_Par07 == 1
			If Len(aQuesSelc) > 0
				For nX:=1 to Len(aQuesSelc)
					If	aQuesSelc[nX][1] == TMI->TMI_QUESTI .And. aQuesSelc[nX][5] == .T.
						dbSelectArea("TRB2")
						If !dbSeek(TMI->TMI_QUESTA)
							TRB2->(DbAppend())
							TRB2->PERGUNTA := TMI->TMI_QUESTA
							TRB2->NOMPERGU := TMH->TMH_PERGUN
						Endif

						If TMI->TMI_RESPOS = '1'
							TRB2->RESPSIM := TRB2->RESPSIM + 1
						Else
							TRB2->RESPNAO := TRB2->RESPNAO + 1
						Endif
					EndIf
				Next
			EndIf
		Else
			dbSelectArea("TRB2")
			If !dbSeek(TMI->TMI_QUESTA)
				TRB2->(DbAppend())
				TRB2->PERGUNTA := TMI->TMI_QUESTA
				TRB2->NOMPERGU := TMH->TMH_PERGUN
			Endif
			If TMI->TMI_RESPOS = '1'
				TRB2->RESPSIM := TRB2->RESPSIM + 1
			Else
				TRB2->RESPNAO := TRB2->RESPNAO + 1
			Endif
		EndIf

		dbSelectArea("TMI")
		dbSKIP()
	End
Else

	cAliasTMI := GetNextAlias()
	cTabTMI := RetSqlName("TMI")

	cQryQue := "SELECT TMI.TMI_NUMFIC AS NUMFIC, TMI.TMI_QUESTI AS QUESTI, TMI.TMI_DTREAL AS DTREAL, TMI.TMI_QUESTA AS QUESTA, "
	cQryQue += " TMI.TMI_RESPOS AS RESPOS, TMI.TMI_QTRESP AS QTRESP, TMI.TMI_COMRES AS COMRES"
	cQryQue += "FROM " + cTabTMI + " TMI "
	cQryQue += "WHERE D_E_L_E_T_ != '*' AND "
	cQryQue += "TMI.TMI_FILIAL = " + ValToSql(xFilial( "TMI" ))

	//Ao entrar pelo MDTA145, ja vem posicionado na ficha
	If IsInCallStack( "MDTA145" )

		cQryQue += " AND TMI.TMI_NUMFIC = " + ValToSql( TM0->TM0_NUMFIC )

	Else
		//verifica se o parametro de ficha médica está preenchida para filtrar
		If !Empty( mv_par03 ) .And. ( !Empty( mv_par04 ) .And. mv_par04 <> Replicate("Z",9) )
			If mv_par03 == mv_par04
				cQryQue += " AND TMI.TMI_NUMFIC = " + ValToSql( mv_par03 )
			Else
				cQryQue += " AND TMI.TMI_NUMFIC >= " + ValToSql( mv_par03 )
				cQryQue += " AND TMI.TMI_NUMFIC <= " + ValToSql( mv_par04 )
			EndIf
		EndIf
		//Verifica se o parametro de questionario está preenchido para filtrar
		If !Empty( mv_par01 ) .And. ( !Empty( mv_par02 ) .And. mv_par02 <> Replicate("Z",6) )
			If mv_par01 == mv_par02
				cQryQue += " AND TMI.TMI_QUESTI = " + ValToSql( mv_par01 )
			Else
				cQryQue += " AND TMI.TMI_QUESTI >= " + ValToSql( mv_par01 )
				cQryQue += " AND TMI.TMI_QUESTI <= " + ValToSql( mv_par02 )
			EndIf
		EndIf

	EndIf

	cQryQue := ChangeQuery( cQryQue )
	MPSysOpenQuery( cQryQue , cAliasTMI )

	If lRelGraf
		ProcRegua(LastRec())
	Else
		SetRegua(LastRec())
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TMI para ler as  Questoes                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	DbSelectArea( cAliasTMI )
	DbGoTop()
	While ( cAliasTMI )->( !Eof() )

		If lRelGraf
			IncProc()
		Else
			IncRegua()
		Endif

		If ( cAliasTMI )->NUMFIC < mv_par03 .or. ( cAliasTMI )->NUMFIC > mv_par04
			DbSelectArea( cAliasTMI )
			dbSkip()
			Loop
		Endif

		If ( cAliasTMI )->QUESTI < MV_PAR01 .OR. ( cAliasTMI )->QUESTI > MV_PAR02
			DbSelectArea( cAliasTMI )
			dbSkip()
			loop
		Endif

		If StoD(( cAliasTMI )->DTREAL) < MV_PAR06 .OR. StoD(( cAliasTMI )->DTREAL) > MV_PAR07
			DbSelectArea( cAliasTMI )
			dbSkip()
			loop
		Endif

		dbSelectArea("TM0")
		dbSetOrder(01)
		If dbSeek(xFilial("TM0") + ( cAliasTMI )->NUMFIC )
			If TM0->TM0_NUMFIC < MV_PAR03 .OR. TM0->TM0_NUMFIC > MV_PAR04
				DbSelectArea( cAliasTMI )
				dbSkip()
				loop
			Endif
		Else
			DbSelectArea( cAliasTMI )
			dbSkip()
			loop
		Endif

		dbSelectArea("TRB")
		dbSetOrder( 1 )
		If !dbSeek( ( cAliasTMI )->NUMFIC+( cAliasTMI )->DTREAL+( cAliasTMI )->QUESTI )
			TRB->(DbAppend())

			TRB->QUESTI   	:= ( cAliasTMI )->QUESTI
			TRB->MATRICULA  := TM0->TM0_MAT
			TRB->NUMFICHA   := ( cAliasTMI )->NUMFIC
			TRB->PERGUNTA   := ( cAliasTMI )->QUESTA
			TRB->NOMPERGU   := TMH->TMH_PERGUN
			TRB->RESPOS     := ( cAliasTMI )->RESPOS
			TRB->DTREAL     := StoD(( cAliasTMI )->DTREAL)
			TRB->QUANTID    := ( cAliasTMI )->QTRESP
			TRB->COMPLEM    := ( cAliasTMI )->COMRES
			TRB->XCOMBO   := TMH->TMH_RESPOS
			TRB->CODGRUPO := TMH->TMH_CODGRU
		EndIf
		If Mv_Par05 == 1
			If Len(aQuesSelc) > 0
				For nX:=1 to Len(aQuesSelc)
					If	aQuesSelc[nX][1] == ( cAliasTMI )->QUESTI .And. aQuesSelc[nX][5] == .T.
						dbSelectArea("TRB2")
						If !dbSeek(( cAliasTMI )->QUESTA)
							TRB2->(DbAppend())
							TRB2->PERGUNTA := ( cAliasTMI )->QUESTA
							TRB2->NOMPERGU := TMH->TMH_PERGUN
						Endif

						If ( cAliasTMI )->RESPOS = '1'
							TRB2->RESPSIM := TRB2->RESPSIM + 1
						Else
							TRB2->RESPNAO := TRB2->RESPNAO + 1
						Endif
					EndIf
				Next
			EndIf
		Else
			dbSelectArea("TRB2")
			If !dbSeek(( cAliasTMI )->QUESTA)
				TRB2->(DbAppend())
				TRB2->PERGUNTA := ( cAliasTMI )->QUESTA
				TRB2->NOMPERGU := TMH->TMH_PERGUN
			Endif
			If ( cAliasTMI )->RESPOS = '1'
				TRB2->RESPSIM := TRB2->RESPSIM + 1
			Else
				TRB2->RESPNAO := TRB2->RESPNAO + 1
			Endif
		EndIf

		dbSelectArea( cAliasTMI )
		dbSKIP()
	End

	( cAliasTMI )->( dbCloseArea() )

Endif
RestArea( aArea )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  fRetCombo³ Autor ³ Denis Hyroshi de Souza³ Data ³07/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a formula esta correta e faz a gravacao         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fRetCombo(cVar)
Local aArray1 := RetSx3Box(cVar,,,1)
Local nCont,aArray2 := {}

For nCont := 1 To Len(aArray1)
	If !Empty(aArray1[nCont][1])
		AADD(aArray2,Alltrim(aArray1[nCont][1]))
	Endif
Next nCont

Return aClone(aArray2)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDT410OpcQ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 07/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Escolhe as perguntas                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT410OpcQ()
	If &(cFilPg) == 1
		Return fQuestoes()
	Else
		aQuesSelc := {}
	Endif
Return .t.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDT410OpcQ³ Autor ³ Denis Hyroshi de Souza³ Data ³ 07/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Escolhe as perguntas                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fQuestoes()
Local nContador := 0, nCnt := 0, nUsed, nColumn, nOld, x, y, xx
Local lGrava := .f.
Local aArea := GetArea()
Local nPos1, lQs, cQP
Local oDlgF, oFont, oGroup , oPanel , oScroll
Local oMARK1, nX
Local oMainWnd , oBROWSE
Private cMARCA  := GetMark()
Private aSize := MsAdvSize(,.f.,430)

lInverte:= .f.

lQuery := .t.

dbSelectArea("TMH")

aDBF := {}
AADD (aDBF, { "TO2_OK"   , "C" , 02, 0 } )
AADD (aDBF, { "QUESTI" 	 , "C" , 06, 0 } )
AADD (aDBF, { "CODIGOPE" , "C" , 03, 0 } )
AADD (aDBF, { "PERGUNTA" , "C" , 50, 0 } )
AADD (aDBF, { "GRUPO"    , "C" , 01, 0 } )

aTRB1 := {}
AADD ( aTRB1, { "TO2_OK"    , NIL, " "    , } )
AADD ( aTRB1, { "QUESTI"    , NIL, STR0091, } )//"Questionario"
AADD ( aTRB1, { "CODIGOPE"  , NIL, STR0092, } )//"Codigo"
AADD ( aTRB1, { "PERGUNTA"  , NIL, STR0093, } )//"Pergunta"

oTempTRB1 := FWTemporaryTable():New( "TRB1", aDBF )
oTempTRB1:AddIndex( "1", {"QUESTI"} )
oTempTRB1:Create()

dbSelectArea("TMH")
dbSetOrder(1)
dbGoTop()
dbSeek(xFilial("TMH"))
While !EOF() .And. TMH->TMH_FILIAL == xFilial("TMH")

   If lSigaMdtps
		If (TMH->(TMH_CLIENT+TMH_LOJA) <> Mv_par01+Mv_par02) .Or. ;
		   (TMH->TMH_QUESTI < MV_PAR03 .OR. TMH->TMH_QUESTI > MV_PAR04 )
			dbSelectArea("TMH")
			dbSkip()
			loop
		Endif
	Else
		If TMH->TMH_QUESTI < MV_PAR01 .OR. TMH->TMH_QUESTI > MV_PAR02
			dbSelectArea("TMH")
			dbSkip()
			loop
		Endif
	Endif

	cIndGrupo := "N"
	If Upper(Substr(TMH->TMH_QUESTA,1,1)) >= 'A' .and. Upper(Substr(TMH->TMH_QUESTA,1,1)) <= 'Z' .and. ;
		Empty(Substr(TMH->TMH_QUESTA,2,2))

		cIndGrupo := "S"
	Endif

	TRB1->(DbAppend())
	If cIndGrupo != "S"
		TRB1->TO2_OK   := cMarca
	Endif
	TRB1->QUESTI   := TMH->TMH_QUESTI
	TRB1->CODIGOPE := TMH->TMH_QUESTA
	TRB1->PERGUNTA := TMH->TMH_PERGUN
	TRB1->GRUPO    := cIndGrupo

	dbSelectArea("TMH")
	dbSkip()
End

Dbselectarea("TRB1")
Dbsetorder(1)
Dbgotop()
If TRB1->(Reccount()) <= 0
	oTempTRB1:Delete()
	RestArea(aArea)
	lRefresh := .t.
	ApMsgstop(STR0086,STR0090) //"Não há perguntas cadastradas para este questionário.","ATENÇÃO"
	Return .f.
Endif

nOpca1 := 2
DEFINE FONT oFont NAME "Arial" SIZE 0,-12
DEFINE MSDIALOG oDlgF TITLE OemToAnsi(STR0085) From aSize[7],0 To aSize[6],aSize[5] OF oMainWnd PIXEL  //"Perguntas do Questionário"

	@ 0,0 SCROLLBOX oScroll VERTICAL OF oDlgF BORDER
	oScroll:Align := CONTROL_ALIGN_ALLCLIENT

	oPanel := TPanel():New(15, 5, Nil, oScroll, Nil, .T., .F., Nil, Nil,,, .T., .F. )
	oPanel:Align := CONTROL_ALIGN_ALLCLIENT

		oMARK1 := MsSelect():NEW("TRB1","TO2_OK",,aTRB1,@lINVERTE,@cMARCA,,,,oPanel)
		oMARK1:bMARK := {|| U_MDT410MKFU(cMarca,lInverte)}
		oMARK1:oBROWSE:lHASMARK := .T.
		oMARK1:oBROWSE:lCANALLMARK := .T.
		oMARK1:oBROWSE:bALLMARK := {|| U_MDTA410INV(cMarca) }

ACTIVATE MSDIALOG oDlgF ON INIT EnchoiceBar(oDlgF,{|| nOpca1 := 1,oDlgf:End()},{|| nOpca1 := 2,oDlgf:End()})

If nOpca1 == 2
	dbSelectArea("TRB1")
	Use
	RestArea(aArea)
	lRefresh := .t.
	Return .f.
Endif

lQs := .F.
aQuesSelc := {}
dbSelectArea("TRB1")
dbGoTop()
While !eof()
	If !Empty(TRB1->TO2_OK)
		aADD(aQuesSelc, {TRB1->QUESTI, TRB1->CODIGOPE,TRB1->PERGUNTA, TRB1->GRUPO , If( Empty(TRB1->TO2_OK) , .f. , .t. ) } )
		lQs := .T.
	EndIf
	dbSelectArea("TRB1")
	dbSkip()
End
If !lQs
	MsgInfo(STR0087)//"O filtro será desconsiderado, pois nenhuma questão foi selecionada."
	dbSelectArea("TRB1")
	Use
	RestArea(aArea)
	lRefresh := .T.
	&(cFilPg) := 2
	Return .F.
Else
	If lSigaMdtps
		cQP := "TMH->TMH_QUESTI >= MV_PAR03 .AND. TMH->TMH_QUESTI <= MV_PAR04"
	Else
		cQP := "TMH->TMH_QUESTI >= MV_PAR01 .AND. TMH->TMH_QUESTI <= MV_PAR02"
	EndIf

	dbSelectArea("TMH")
	dbSetOrder(1)
	dbGoTop()
	While !Eof() .And. TMH->TMH_FILIAL == xFilial("TMH")
		If &(cQP)
			lQs := .F.
			For nx:=1 to Len(aQuesSelc)
				If aQuesSelc[nX][5] == .T. .And. ;
					aQuesSelc[nX][1] == TMH->TMH_QUESTI
					lQs := .T.
					Exit
				EndIf
			Next
			If !lQs
				MsgInfo(STR0088+TMH->TMH_QUESTI+STR0089)//"Nenhuma pergunta do Questionario # foi selecionada."
				dbSelectArea("TRB1")
				Use
				RestArea(aArea)
				lRefresh := .t.
				&(cFilPg) := 2
				Return .F.
			EndIf
		Endif
		dbSelectArea("TMH")
		dbSkip()
	End
EndIf

oTempTRB1:Delete()

RestArea(aArea)
Return .t.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³MDT410MKFU³ Autor ³ Denis                 ³ Data ³ 12/11/07 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDT410MKFU(cMarca,lInverte)
If TRB1->GRUPO == "S"
	TRB1->TO2_OK := "  "
Endif
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³MDTA410INV³ Autor ³ Denis                 ³ Data ³ 12/11/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Inverte a marcacao do browse                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function MDTA410INV(cMarca)
Local aArea := GetArea()

dbSelectArea("TRB1")
dbGoTop()
While !eof()
	If TRB1->GRUPO == "N"
		TRB1->TO2_OK := IF(TO2_OK == "  ",cMARCA,"  ")
	Endif
	dbSkip()
End

RestArea(aArea)
Return .t.
