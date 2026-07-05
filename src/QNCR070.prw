/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QNCR070.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TOTVS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QNCR070  ³ Autor ³ Aldo Marini Junior    ³ Data ³ 06.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Diagrama de Causa e efeito                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QNCR070(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function QNCR070(nRegImp)
Private nLastKey  := 0
Private cPerg     := "QNR070"
Private Titulo	  := STR0001		//"DIAGRAMA DE CAUSA E EFEITO"
Private nLig      := 0
Private nPag      := 1
Private lPagPrint := .T.
Private lTMKPMS   := If(GetMv("MV_QTMKPMS",.F.,1) == 1,.F.,.T.)//Integracao do QNC com TMK e PMS: 1-Sem integracao,2-TMKxQNC,3-QNCxPMS,4-TMKxQNCxPMS ³

Default nRegImp   := 0

INCLUI := .F.	// Utilizado devido algumas funcoes de retorno de descricao/nome
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Filial  De                               ³
//³ mv_par02        //  Filial  Ate                              ³
//³ mv_par03        //  Ano De                                   ³
//³ mv_par04        //  Ano Ate                                  ³
//³ mv_par05        //  Plano de Acao                            ³
//³ mv_par06        //  Plano de Acao                            ³
//³ mv_par07        //  Revisao De                               ³
//³ mv_par08        //  Revisao Ate                              ³
//³ mv_par09        //  Acoes 1-Corretiva/2-Preventiva/3-Melhoria/4-Ambas
//³ mv_par10        //  Status Acoes 1-Registrada/2-Em Analise/3-Procede/4-Nao Procede/5-Cancelada/6-Ambas
//³ mv_par11        //  Visualiza antes  1-Sim/2-Nao             |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If nRegImp == 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lOkPrint := pergunte("QNR070",.T.)

	If !lOkPrint
		Return
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFilDe   := mv_par01
	cFilAte  := mv_par02
	cAnoDe   := mv_par03
	cAnoAte  := mv_par04
	cAcaoDe  := mv_par05
	cAcaoAte := mv_par06
	cRevDe   := mv_par07
	cRevAte  := mv_par08
	nAcao    := mv_par09
	cStatus  := mv_par10
	nView    := mv_par11

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	pergunte("QNR070",.F.)
	cFilDe   := QI3->QI3_FILIAL
	cFilAte  := QI3->QI3_FILIAL
	cAnoDe   := QI3->QI3_ANO
	cAnoAte  := QI3->QI3_ANO
	cAcaoDe  := QI3->QI3_CODIGO
	cAcaoAte := QI3->QI3_CODIGO
	cRevDe   := QI3->QI3_REV
	cRevAte  := QI3->QI3_REV
	nAcao    := 4
	cStatus  := QI3->QI3_STATUS
	nView    := 1
   
Endif

RptStatus({|lEnd| QNCR070Imp(@lEnd)},Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Volta o registro correspondente ao Plano de Acao quando a    ³
//³ impressao for selecionada via cadastro.                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nRegImp > 0
	dbSelectArea("QI3")
	dbSetOrder( 1 )
	dbGoTo(nRegImp)
Endif

dbSelectArea( "QI2" )
dbSetOrder( 1 )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QNCR070Imp³ Autor ³ Aldo Marini Junior    ³ Data ³ 08.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Diagrama de Causa e Efeito                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³QNCR070Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR070                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QNCR070Imp(lEnd)

Local nQI6Atu  := 0
Local aCausas  := {}
Local lRaiz	   := .F.

Private oFont08, oFont10, oFont15, oFont10n, oFont21, oFont12
Private oQPrint
Private lFirst     := .T.
Private lInicial   := .F.
Private cFileLogo  := ""
Private cFilOld    := cFilAnt
Private cNomFilial := ""

oFont07	:= TFont():New("Courier New",07,07,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Courier New",08,08,,.T.,,,,.T.,.F.)
oFont10	:= TFont():New("Courier New",10,10,,.F.,,,,.T.,.F.)
oFont10n:= TFont():New("Courier New",10,10,,.T.,,,,.T.,.F.)
oFont12	:= TFont():New("Courier New",12,12,,.T.,,,,.T.,.F.)
oFont15	:= TFont():New("Courier New",15,15,,.T.,,,,.T.,.F.)
oFont21 := TFont():New("Courier New",21,21,,.T.,,,,.T.,.T.)

// 5o. Bold
// 9o. Italico
//10o. Underline

dbSelectArea( "QI2" )
dbSetOrder( 5 )

dbSelectArea( "QI3" )
dbGoTop()

dbSetOrder( 1 )
dbSeek(IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilDe) + cAnoDe + cAcaoDe + cRevDe,.T.)
cInicio  := "QI3->QI3_FILIAL + QI3->QI3_ANO + QI3->QI3_CODIGO + QI3->QI3_REV"
cFim     := IF((FWModeAccess("QI3") == "C"),xFilial("QI3"),cFilAte) + cAnoAte + cAcaoAte + cRevAte

cFileLogo  := "LGRL"+SM0->M0_CODIGO
cFilOld    := QI3->QI3_FILIAL

If (FWModeAccess("QI3") == "C")
	cFileLogo += FWCodFil()+".BMP"
Else
	cFileLogo += QI3->QI3_FILIAL+".BMP"
Endif

If !File( cFileLogo )
	cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua de Processamento                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(QI3->(RecCount()))

While !EOF() .And. &cInicio <= cFim
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua de Processamento                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If	(QI3->QI3_ANO < cAnoDe ) .Or. ( QI3->QI3_ANO > cAnoAte ) .Or. ;
	 	(Left(QI3->QI3_CODIGO,15) < Left(cAcaoDe,15) ) .Or. ( Left(QI3->QI3_CODIGO,15) > Left(cAcaoAte,15) ) .Or. ;
		(QI3->QI3_REV < cRevDe ) .Or. ( QI3->QI3_REV > cRevAte ) 
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste o tipo de Plano de Acao                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nAcao <> 4 .And. Val(QI3->QI3_TIPO) <> nAcao
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Consiste o Status dos Planos de Acoes                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(QI3->QI3_STATUS $ cStatus)
		dbSkip()
		Loop
	Endif

	cNomFilial := AllTrim(QA_CHKFIL(QI3->QI3_FILIAL,,.T.))
	If !Empty(cFilOld) .And. cFilOld <> QI3->QI3_FILIAL
        cFilOld    := QI3->QI3_FILIAL
		cFileLogo := "LGRL"+SM0->M0_CODIGO+QI3->QI3_FILIAL+".BMP"
		If !File( cFileLogo )
			cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
		Endif
	Endif

	If QI6->(dbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV))
		nQI6Atu := QI6->(Recno())
      	dbSelectArea("QI2")
      	
		If dbSeek(QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV)
			While !Eof() .And. QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV == QI2->QI2_FILIAL+QI2->QI2_CODACA+QI2->QI2_REVACA
				aCausas := {{},{},{},{},{},{}}
				QI6->(dbGoTo(nQI6Atu))
				While !(QI6->(Eof())) .And. QI3->QI3_FILIAL+QI3->QI3_CODIGO+QI3->QI3_REV == QI6->QI6_FILIAL+QI6->QI6_CODIGO+QI6->QI6_REV
					If QI6->QI6_TIPO $ "123456"
						aAdd(aCausas[Val(QI6->QI6_TIPO)],alltrim(PADR(FQNCNTAB("1",QI6->QI6_CAUSA),50))+iif(QI6->QI6_RAIZ=="1","(*)","")) //
						IF QI6->QI6_RAIZ=="1"
//							aCausas[Val(QI6->QI6_TIPO)][1]:=Alltrim(aCausas[Val(QI6->QI6_TIPO)][1])+"(*)"
							lRaiz:=.T.
						Endif
					Endif
					QI6->(dbSkip())
				Enddo

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime o Diagrama de Causa e Efeito                         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				U_QNCR070DIA(aCausas,lRaiz)
            
				dbSkip()
			Enddo
		Endif
	Endif

	dbSelectArea("QI3")
	dbSkip()
Enddo

If oQPrint <> NIL
	oQPrint:EndPage() // Finaliza a pagina
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("QI3")
Set Filter to
dbSetOrder(1)
If oQPrint <> NIL
	If nView == 1
		oQPrint:Preview()  // Visualiza antes de imprimir
	Else
	   oQPrint:Print() // Imprime direto na impressora default Protheus
	Endif
Endif

If Len(aCausas) == 0
	MsgStop(STR0011,STR0012) // "Nao existem dados gerados para este Relatorio. Verifique os parametros do relatorio" ### "Sem Dados"
EndIf

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³QNCR070DIA³ Autor ³ Aldo Marini Junior    ³ Data ³ 08.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o grafico                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_QNCR070DIA(aCausas)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1-Array contendo as linhas a serem impressas           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR070                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QNCR070DIA(aCausas,lRaiz)
Local aPosicao := {}
Local nA       := 1
Local nColEmp  := 1500-((Len(cNomFilial)/2)*30) // Tamanho de fonte 15
Local nColI1   := 310
Local nColI2   := 1140
Local nColI3   := 1970
Local nColS1   := 200
Local nColS2   := 1030
Local nColS3   := 1860
Local nLinInf  := 1320
Local nLinSup  := 540
Local nTa      := 1

aAdd(aPosicao,{ 1,10, 1 })
aAdd(aPosicao,{ 2, 7, 6 })
aAdd(aPosicao,{ 3, 6, 4 })
aAdd(aPosicao,{ 4, 4, 4 })
aAdd(aPosicao,{ 5, 4, 3 })
aAdd(aPosicao,{ 6, 3, 3 })
aAdd(aPosicao,{ 7, 4, 2 })
aAdd(aPosicao,{ 8, 3, 2 })
aAdd(aPosicao,{ 9, 2, 2 })
aAdd(aPosicao,{10, 1, 2 })
aAdd(aPosicao,{11, 5, 1 })
aAdd(aPosicao,{12, 5, 1 })
aAdd(aPosicao,{13, 4, 1 })
aAdd(aPosicao,{14, 4, 1 })
aAdd(aPosicao,{15, 3, 1 })
aAdd(aPosicao,{16, 2, 1 })
aAdd(aPosicao,{17, 2, 1 })
aAdd(aPosicao,{18, 1, 1 })
aAdd(aPosicao,{19, 1, 1 })

If Len(aCausas[1]) == 0 .And. ; // Medicao
	Len(aCausas[2]) == 0 .And. ; // Materiais
	Len(aCausas[3]) == 0 .And. ; // Mao-de-Obra
	Len(aCausas[4]) == 0 .And. ; // Meio Ambiente
	Len(aCausas[5]) == 0 .And. ; // Metodo
	Len(aCausas[6]) == 0		// Maquina
	Return Nil
Endif

If !lInicial
	lInicial := .T.
	oQPrint := FWMSPrinter():New(Titulo,IMP_PDF, .T.,, .F.,,,,   ,,, .T. )
	oQPrint:SetLandscape()
Endif

oQPrint:StartPage() // Inicia uma nova pagina
oQPrint:SayBitmap(30,30, cFileLogo,474,117)

oQPrint:Say(030,nColEmp,cNomFilial,oFont15 )

oQPrint:Say(140,900, STR0001,oFont21 )	// "DIAGRAMA DE CAUSA E EFEITO"

oQPrint:Say(300,  50, STR0002 +":"+QI2->QI2_CODEFE+"-"+FQNCNTAB("2",QI2->QI2_CODEFE),oFont10n )	// "EFEITO"
oQPrint:Say(350,  50, STR0003 +" "+TransForm(QI2->QI2_FNC,PesqPict("QI2","QI2_FNC"))+"-"+QI2->QI2_REV ,oFont10 )	// "Ficha Ocorrencia/Nao-Conformidade:"
oQPrint:Say(350,1760, STR0004 +" "+TransForm(QI3->QI3_CODIGO,PesqPict("QI3","QI3_CODIGO"))+"-"+QI3->QI3_REV ,oFont10 )	// "Plano de Acao:" 

IF !lRaiz                            
	oQPrint:Box(450,50 , 2150, 3000 )
Else
	oQPrint:Box(450,50 , 2200, 3000 )
	oQPrint:Say(2150,90, STR0013,oFont12 )	  //"(*) Causa Raiz"
ENDif

oQPrint:Box(1240, 2750, 1360, 2980 )
oQPrint:Say(1275,2770, STR0002,oFont15 )	// "EFEITO"
oQPrint:Line(1300, 200, 1300, 2750 )

oQPrint:Line(540,  70, 1300, 270 )
oQPrint:Line(540, 900, 1300,1100 )
oQPrint:Line(540,1730, 1300,1930 )

oQPrint:Line(2050,  90, 1300, 290 )
oQPrint:Line(2050, 920, 1300,1120 )
oQPrint:Line(2050,1750, 1300,1950 )

oQPrint:Say( 480,  80, STR0005 ,oFont12 )	//"MEDICAO"
oQPrint:Say( 480, 900, STR0006 ,oFont12 )	//"MATERIAIS"
oQPrint:Say( 480,1730, STR0007 ,oFont12 )	//"MAO-DE-OBRA"
oQPrint:Say(2080,  90, STR0008 ,oFont12 )	//"MEIO AMBIENTE"
oQPrint:Say(2080, 910, STR0009 ,oFont12 )	//"METODO"
oQPrint:Say(2080,1740, STR0010 ,oFont12 )	//"MAQUINA"

For nA := 1 to Len(aCausas)

	If Len(aCausas[nA]) > 0

		nPosicao := Ascan(aPosicao,{ |X| X[1] == Len(aCausas[nA]) })
	
		If nA == 1 .Or. nA == 2 .Or. nA == 3
			nLinha := nLinSup
		Else
			nLinha := nLinInf
		Endif

		nLinha := nLinha + ( (aPosicao[nPosicao,2]-1) * 40 )
		nFatLin := aPosicao[nPosicao,3]*40
      
		If  nA == 1
			nColuna := nColS1
			nFatCol := (aPosicao[nPosicao,3]) * 10
		ElseIf nA == 2
			nColuna := nColS2
			nFatCol := (aPosicao[nPosicao,3]) * 10
		ElseIf nA == 3
			nColuna := nColS3
			nFatCol := (aPosicao[nPosicao,3]) * 10
		ElseIf nA == 4
			nColuna := nColI1
			nFatCol := -((aPosicao[nPosicao,3]) * 10)
		ElseIf nA == 5
			nColuna := nColI2      
			nFatCol := -((aPosicao[nPosicao,3]) * 10)
		ElseIf nA == 6
			nColuna := nColI3
			nFatCol := -((aPosicao[nPosicao,3]) * 10)
		Endif                                             

		nColuna := nColuna + (((aPosicao[nPosicao,2]-1)*10)*If(nA>3,(-1),1))

		For nTa := 1 To Len(aCausas[nA])
			oQPrint:Say( nLinha,nColuna-18,CHR(171),oFont07)
			oQPrint:Say( nLinha,nColuna,aCausas[nA,nTa],oFont07 )
			nLinha += nFatLin
			nColuna += nFatCol
		Next
	Endif
Next

oQPrint:EndPage()	// Finaliza Pagina

oQPrint:SetViewPDF(.T.) // Trás selecionada a visualização em PDF
		
Return Nil
