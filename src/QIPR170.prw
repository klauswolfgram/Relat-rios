/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "QIPR170.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QIPR170  ³ Autor ³ Eduardo de Souza      ³ Data ³ 25/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Medicoes ( Grafico )                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QIPR170(nChart)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Imprime ou nao o grafico                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Inspecao de Processos / Inspecao de Entradas               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QIPR170(nChart,aArray,aGraf64)
Local aMedicao   := {}  
Local aOrdProd   := {}
Local cArqPNG    := ''
Local nOrdQP1    := QP1->(IndexOrd())
Local nOrdQP6    := QP6->(IndexOrd())
Local nOrdQP7    := QP7->(IndexOrd())
Local nOrdSAH    := SAH->(IndexOrd())
Local nPosQP1    := QP1->(RecNo())
Local nPosQP6    := QP6->(RecNo())
Local nPosQP7    := QP7->(RecNo())
Local nPosSAH    := SAH->(RecNo())
Local nX         := 0 
Local oPrint     := NIL
Local oQLGrafico := GraficosQualidadeX():New()

Private cArqCar     := ""  
Private cArqEst     := "" 
Private cArqHis     := ""
Private cDir	    := GetMv("MV_QDIRGRA")
Private cEnsaio     := "" 
Private cLabor      := ""
Private cProd       := ""
Private cRevi       := ""
Private lExistChart := FindFunction("QIEMGRAFIC") .AND. GetBuild() >= "7.00.170117A" //controle se executa o grafico modelo novo ou por DLL
Private nPagina     := 0// Já declarada Private na chamada de todos os quadros

Default aArray  := {}
Default aGraf64 := {}
Default nChart  := 0

If Len(aArray)>1
	cProd  := aArray[5]
	cRevi  := aArray[6]
	cLabor := aArray[4]
	cEnsaio:= SubStr(aArray[1],1,8)
	aOrdProd := aArray[7]
	aMedicao := aArray[8]
Else
	cProd  := Space(TamSX3("QPK_PRODUT")[1])
	cRevi  := Space(TamSX3("QPK_REVI")[1])
	cLabor := Space(TamSX3("QPL_LABOR")[1])
	cEnsaio:= Space(01)
	aOrdProd := {}
	aMedicao := {}
Endif

  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o diretorio do grafico e um  diretorio Local ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !QA_VerQDir(cDir) 
	Return
EndIf  

oPrint := FWMSPrinter():New(OemToAnsi(STR0001),IMP_PDF,.T.,nil,.T.,nil,@oPrint,nil,.F.,.F.,.F.,.T.)
oPrint:setDevice(IMP_PDF)
oPrint:setResolution(72)
oPrint:SetPortrait()
oPrint:SetPaperSize(DMPAPER_A4)
oPrint:setMargin(10,10,10,10)

IF !EMPTY(aGraf64)

	IF lExistChart //controle se executa o grafico modelo novo ou por DLL
		For nX := 1 to 99999
			cArqPNG := "QIPR170" + StrZero(nX,4) + ".PNG"
			If !File(oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG)
				Exit
			EndIf
		Next nX
	EndIf

	aGraf64[7] := cArqPNG

	QIEMGRAFIC(aGraf64[1],aGraf64[2],aGraf64[3],aGraf64[4],aGraf64[5],aGraf64[6],aGraf64[7],aGraf64[8],.T.,aGraf64[10],aGraf64[11],aGraf64[12])

ENDIF

MsgRun(OemToAnsi(STR0002),"",{|| CursorWait(), MontaRel(oPrint,nChart,aOrdProd,aMedicao,cArqPNG) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."

oPrint:Preview() // Visualiza antes de imprimir   

If File(cDir+cArqHis)
	FErase(cDir+cArqHis) 			
Endif

If File(cDir+cArqCar)
	FErase(cDir+cArqCar) 			
Endif

If File(cDir+cArqEst)
	FErase(cDir+cArqEst) 			
Endif

//Retorna a Ordem/Posicao Atual dos arquivos
QP7->(DbGoto(nPosQP7))
QP7->(DbSetOrder(nOrdQP7))

QP6->(DbGoto(nPosQP6))
QP6->(DbSetOrder(nOrdQP6))

QP1->(DbGoto(nPosQP1))
QP1->(DbSetOrder(nOrdQP1))

SAH->(DbGoto(nPosSAH))
SAH->(DbSetOrder(nOrdSAH))

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Eduardo de Souza      ³ Data ³ 25/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Grafico das Medicoes                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1,ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Tipo de Grafico                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MontaRel(oPrint,nChart,aOrdProd,aMedicao,cArqPNG)

Local nI         := 1
Local Lin 	     := 0
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial

Private oFont16, oFont08, oFont10

If !File(cFileLogo)
	cFileLogo := "LGRL"+SM0->M0_CODIGO+".BMP" // Empresa
Endif

//oPrint:StartPage() 		// Inicia uma nova pagina

oFont16	:= TFont():New("Arial",18,18,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont10	:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)

QIP170Cab(oPrint,nI) // Funcao que monta o cabecalho

Lin := QIP170Det(oPrint,nChart,cArqPNG)	// Funcao que monta os detalhes

If Lin > 2050				// Espaco minimo para colocacao do rodape	
	nI++
	oPrint:EndPage() 		// Finaliza a pagina
	oPrint:StartPage() 		// Inicia uma nova pagina		
	oPrint:SayBitmap(010,010, cFileLogo,338,092) // Tem que estar abaixo do RootPath
	Lin := 150
Endif

QIP170Foot(oPrint,nI,@Lin,aOrdProd,aMedicao,cFileLogo)	// Funcao que monta o rodape

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QIP170Cab ³ Autor ³ Eduardo de Souza      ³ Data ³ 25/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QIP170Cab(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QIP170Cab(oPrint,nI)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

QP1->(DbSetOrder(1))
QP1->(DbSeek(xFilial("QP1")+cEnsaio))

QP6->(DbSetOrder(2))
QP6->(DbSeek(xFilial("QP6")+cProd+cRevi))

QP7->(DbSetOrder(3))
QP7->(DbSeek(xFilial("QP7")+cEnsaio+cProd+cRevi))

SAH->(DbSetOrder(1))
SAH->(DbSeek(xFilial("SAH")+QP7->QP7_UNIMED))

oPrint:StartPage() // Inicia uma nova pagina

oPrint:SayBitmap(010,010,cFileLogo,338,092) // Tem que estar abaixo do RootPath

oPrint:Say(075,850,OemToAnsi(STR0001),oFont16) //"Grafico das Medicoes"

//Box Cabecalho
oPrint:Box( 150, 30, 310, 2350 )

// 1a Linha
oPrint:Say(170,0040,AllTrim(TitSX3("QP7_PRODUT")[1]),oFont08 ) // "Produto"
oPrint:Say(190,0040,cProd+"/"+cRevi + " - " + QP6->QP6_DESCPO,oFont08 )

oPrint:Say(170,1210,OemToAnsi(STR0003),oFont08 ) //"Laboratorio"
oPrint:Say(190,1210,cLabor+" - "+Posicione("SX5",1,xFilial("SX5")+"Q2"+cLabor,"X5_DESCRI"),oFont08 )

// 2a Linha
oPrint:Say(250,0040,AllTrim(TitSX3("QP7_ENSAIO")[1]),oFont08 ) //"Ensaio"
oPrint:Say(270,0040,cEnsaio+" - "+QP1->QP1_DESCPO,oFont08 )

oPrint:Say(250,0850,AllTrim(TitSX3("QP7_UNIMED")[1]),oFont08 ) //"Unidade de Medida"
oPrint:Say(270,0850,SAH->AH_UMRES,oFont08 )

oPrint:Say(250,1210,AllTrim(TitSX3("QP7_NOMINAL")[1]),oFont08 ) //"Nominal"
oPrint:Say(270,1210,QP7->QP7_NOMINA,oFont08 )

oPrint:Say(250,1610,AllTrim(TitSX3("QP7_LIE")[1]),oFont08 ) //"LIE"
oPrint:Say(270,1610,QP7->QP7_LIE,oFont08 )

oPrint:Say(250,2010,AllTrim(TitSX3("QP7_LSE")[1]),oFont08 ) //"LSE"
oPrint:Say(270,2010,QP7->QP7_LSE,oFont08 )

// Construcao das linhas do cabecalho
oPrint:Line( 230, 0030, 230, 2350 )   	// horizontal
oPrint:Line( 150, 1200, 230, 1200 )   	// vertical

oPrint:Line( 230,  840, 310,  840 )   	// vertical
oPrint:Line( 230, 1200, 310, 1200 )   	// vertical                                           
oPrint:Line( 230, 1600, 310, 1600 )   	// vertical
oPrint:Line( 230, 2000, 310, 2000 )   	// vertical

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QIP170Det³ Autor ³ Eduardo de Souza      ³ Data ³ 26/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Itens do relatorio                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QIP170Det(ExpO1,ExpN1,ExpN2)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±³          ³ ExpN2 = Flag para impressao do grafico                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QIP170Det(oPrint,nChart,cArqPNG)
Local cArqOrCa   := ""
Local cArqOrEs   := ""
Local cArqOrHi   := ""
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+SM0->M0_CODFIL+".BMP" // Empresa+Filial
Local cStartPath := GetSrvProfString("Startpath","")
Local lImpEst    := GetMv("MV_QIMPEST",.T.,.F.)
Local Lin 		 := 340
Local oQLGrafico := GraficosQualidadeX():New()

If Right(cDir,1) <> "\"
	cDir += "\"
Endif

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

If nChart == 1
	If lExistChart //controle se executa o grafico modelo novo ou por DLL
		cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
		oPrint:SayBitmap( 360, 30, cImgGraf, 2320,1150)
	Else
		If File(cDir+"HISTO.BMP")
			cArqOrHi := "HISTO.BMP"
			cArqHis  := CriaTrab(, .F.) + ".BMP"
			Copy File (cDir+cArqOrHi) To (cDir+cArqHis)
			oPrint:SayBitmap(360,30,cDir+cArqHis,2320,1150)
		EndIf
	Endif
	Lin := 1460
Elseif nChart == 2
	If lExistChart //controle se executa o grafico modelo novo ou por DLL
		cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
		oPrint:SayBitmap( 360, 30, cImgGraf, 2320,1150)
		Lin := 1460
	Else
		If File(cDir+"CARTA.BMP")
			cArqOrCa := "CARTA.BMP"
			cArqCar  := CriaTrab(, .F.) + ".BMP"
			Copy File (cDir+cArqOrCa) To (cDir+cArqCar)
			oPrint:SayBitmap(360,30,cDir+cArqCar,2320,1150)
		EndIf
		Lin := 1460
	Endif
Endif 

If File(cDir+"ESTAT.BMP") .and. lImpEst
	cArqOrEs := "ESTAT.BMP"
	cArqEst  := CriaTrab(, .F.) + ".BMP"
	Copy File (cDir+cArqOrEs) To (cDir+cArqEst)
	If nChart == 2
		oPrint:SayBitmap(1680,30,cDir+cArqEst,1000,1000)
	Else
		oPrint:SayBitmap(1680,30,cDir+cArqEst,1000,1000)
	EndIf
	Lin := 2790
Endif

Return Lin

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³QIP170Foot³ Autor ³ Eduardo de Souza      ³ Data ³ 26/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Rodape do relatorio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QIP170Foot(ExpO1,ExpN1, ExpN2)                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±³          ³ ExpN2 = Contador de linhas                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QIP170Foot(oPrint,nI,Lin,aOrdProd,aMedicao,cFileLogo)

Local nQtde     := 0
Local nCnt      := 0
Local nMedia    := 0
Local nMaiorVal := 0
Local nMenorVal := 0
Local cPict     := ""
Local lImprCab  := .T.

Private nColItem  := 0
Private nColAmos01:= 0
Private nColAmos02:= 0
Private nColAmos03:= 0
Private nColAmos04:= 0
Private nColAmos05:= 0
Private nColAmos06:= 0
Private nColAmos07:= 0
Private nColAmos08:= 0
Private nColAmos09:= 0
Private nColAmos10:= 0
Private nColMedia := 0
Private nColAmpl  := 0

If QP1->QP1_CARTA == "IND"
	nQtde:= 1
Else
	IIf(QP1->QP1_QTDE>10,nQtde:=10,nQtde:= QP1->QP1_QTDE)
EndIf

If nQtde == 1
	nSomaCol:= 2350/2
Else
	nSomaCol:= 2350/(nQtde+3)
EndIf

nColItem  := 0070
nColAmos01:= nSomaCol
nColAmos02:= nSomaCol*2
nColAmos03:= nSomaCol*3
nColAmos04:= nSomaCol*4
nColAmos05:= nSomaCol*5
nColAmos06:= nSomaCol*6
nColAmos07:= nSomaCol*7
nColAmos08:= nSomaCol*8
nColAmos09:= nSomaCol*9
nColAmos10:= nSomaCol*10
nColMedia := nSomaCol*(nQtde+1)
nColAmpl  := nSomaCol*(nQtde+2)

lin += 80
oPrint:Say(Lin,1000,OemToAnsi(STR0011),oFont16 ) //"Amostras"
lin += 80

//Imprime o Cabecalho das Amostras
QIP170CabM(oPrint,Lin,nQtde)

For nCnt:= 1 To Len(aMedicao)

	If Lin > 2960		// Espaco minimo para colocacao do rodape	
		nI++
		oPrint:EndPage() 		// Finaliza a pagina
		oPrint:StartPage() 		// Inicia uma nova pagina		
		oPrint:SayBitmap(010,010, cFileLogo,338,092) // Tem que estar abaixo do RootPath
		Lin := 150
		//Imprime o cabecalho das Amostras
		QIP170CabM(oPrint,Lin,nQtde)
	EndIf
    
	If Len(aMedicao[nCnt]) > 0
		cPict  := PesqPict("QP7","QP7_NOMINA")
		Lin+= 80
		oPrint:Box(Lin,030,Lin+80, 2350 )
	
		oPrint:Line( Lin, nColAmos01-20, Lin+80, nColAmos01-20 ) // vertical
		
		oPrint:Say(Lin+020,nColItem,AllTrim(StrZero(nCnt,4)),oFont08 ) //"Item"
		oPrint:Say(Lin+020,nColAmos01,TransForm(aMedicao[nCnt,1],cPict),oFont08 ) //"Amostra 1"
	
		If nQtde > 1
			oPrint:Line( Lin, nColAmos02-20, Lin+80, nColAmos02-20 )   	// vertical
			oPrint:Line( Lin, nColMedia-20 , Lin+80, nColMedia-20  )   	// vertical
			oPrint:Line( Lin, nColAmpl-20  , Lin+80, nColAmpl-20   )   	// vertical
	
			oPrint:Say(Lin+020,nColAmos02,TransForm(aMedicao[nCnt,2],cPict),oFont08 ) //"Amostra 2"
	
			nMedia   := SuperVal(aMedicao[nCnt,1])+SuperVal(aMedicao[nCnt,2])
	
			nMaiorVal:= SuperVal(aMedicao[nCnt,1])
			nMenorVal:= SuperVal(aMedicao[nCnt,1])
		
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,2]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,2])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,2]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,2])
			EndIf
	
		EndIf
		
		If nQtde > 2
			oPrint:Line( Lin, nColAmos03-20, Lin+80, nColAmos03-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos03,TransForm(aMedicao[nCnt,3],cPict),oFont08 ) //"Amostra 3"
	
			nMedia+= SuperVal(aMedicao[nCnt,3])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,3]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,3])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,3]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,3])
			EndIf
	
		EndIf
		
		If nQtde > 3
			oPrint:Line( Lin, nColAmos04-20, Lin+80, nColAmos04-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos04,TransForm(aMedicao[nCnt,4],cPict),oFont08 ) //"Amostra 4"
	
			nMedia+= SuperVal(aMedicao[nCnt,4])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,4]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,4])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,4]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,4])
			EndIf
	
		EndIf
	
		If nQtde > 4
			oPrint:Line( Lin, nColAmos05-20, Lin+80, nColAmos05-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos05,TransForm(aMedicao[nCnt,5],cPict),oFont08 ) //"Amostra 5"
	
			nMedia+= SuperVal(aMedicao[nCnt,5])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,5]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,5])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,5]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,5])
			EndIf
	
		EndIf
		
		If nQtde > 5
			oPrint:Line( Lin, nColAmos06-20, Lin+80, nColAmos06-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos06,TransForm(aMedicao[nCnt,6],cPict),oFont08 ) //"Amostra 6"
	
			nMedia+= SuperVal(aMedicao[nCnt,6])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,6]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,6])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,6]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,6])
			EndIf
	
		EndIf
		
		If nQtde > 6
			oPrint:Line( Lin, nColAmos07-20, Lin+80, nColAmos07-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos07,TransForm(aMedicao[nCnt,7],cPict),oFont08 ) //"Amostra 7"
	
			nMedia+= SuperVal(aMedicao[nCnt,7])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,7]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,7])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,7]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,7])
			EndIf
	
		EndIf
		
		If nQtde > 7
			oPrint:Line( Lin, nColAmos08-20, Lin+80, nColAmos08-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos08,TransForm(aMedicao[nCnt,8],cPict),oFont08 ) //"Amostra 8"
	
			nMedia+= SuperVal(aMedicao[nCnt,8])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,8]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,8])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,8]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,8])
			EndIf
	
		EndIf
		
		If nQtde > 8
			oPrint:Line( Lin, nColAmos09-20, Lin+80, nColAmos09-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos09,TransForm(aMedicao[nCnt,9],cPict),oFont08 ) //"Amostra 9"
	
			nMedia+= SuperVal(aMedicao[nCnt,9])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,9]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,9])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,9]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,9])
			EndIf
	
		EndIf
		
		If nQtde > 9
			oPrint:Line( Lin, nColAmos10-20, Lin+80, nColAmos10-20 )   	// vertical
			oPrint:Say(Lin+020,nColAmos10,TransForm(aMedicao[nCnt,10],cPict),oFont08 ) //"Amostra 10"
	
			nMedia+= SuperVal(aMedicao[nCnt,10])
	
			// Maior Valor das Amostras
			If SuperVal(aMedicao[nCnt,10]) > nMaiorVal
				nMaiorVal:= SuperVal(aMedicao[nCnt,10])
			EndIf
	
			// Menor Valor das Amostras
			If SuperVal(aMedicao[nCnt,10]) < nMenorVal
				nMenorVal:= SuperVal(aMedicao[nCnt,10])
			EndIf
	
		EndIf	
	
		cPict:= QIP170PicS(aMedicao[nCnt,1])
	
		If nQtde > 1
			oPrint:Say(Lin+020,nColMedia ,Transform(nMedia/nQtde,cPict),oFont08 ) //"Media"
			oPrint:Say(Lin+020,nColAmpl  ,Transform(nMaiorVal-nMenorVal,cPict),oFont08) //"Amplitude"
		EndIf
	EndIf
Next nCnt

Lin+=160
oPrint:Say(Lin,1000,OemToAnsi(STR0006),oFont16 ) //"Ordens de Producao"
lin += 80
	
For nCnt:= 1 To Len(aOrdProd)
	
	If Lin > 2960		// Espaco minimo para colocacao do rodape	
		nI++
		oPrint:EndPage() 		// Finaliza a pagina
		oPrint:StartPage() 		// Inicia uma nova pagina		
		oPrint:SayBitmap(010,010, cFileLogo,338,092) // Tem que estar abaixo do RootPath
		Lin     := 150
		lImprCab:= .T.
	EndIf

	If lImprCab
		oPrint:Box(Lin,030,Lin+80, 2350 )
		oPrint:Say(Lin+020,0040,OemToAnsi(STR0007),oFont08 ) //"Ordem de Producao"
		oPrint:Say(Lin+020,0640,OemToAnsi(STR0008),oFont08 ) //"Data"
		oPrint:Say(Lin+020,1240,OemToAnsi(STR0009),oFont08 ) //"Lote"
		oPrint:Say(Lin+020,1840,OemToAnsi(STR0010),oFont08 ) //"Quantidade"
	
		oPrint:Line( Lin,  630, Lin+080,  630 )   	// vertical
		oPrint:Line( Lin, 1230, Lin+080, 1230 )   	// vertical                                           
		oPrint:Line( Lin, 1830, Lin+080, 1830 )   	// vertical
		lin += 080
		lImprCab:= .F.
	EndIf

	oPrint:Box(Lin,030,Lin+80, 2350 )
	
	oPrint:Say(Lin+020,0040,aOrdProd[nCnt,1],oFont08 )	
	oPrint:Say(Lin+020,0640,DtoC(aOrdProd[nCnt,2]),oFont08 )		
	oPrint:Say(Lin+020,1240,aOrdProd[nCnt,3],oFont08 )
	oPrint:Say(Lin+020,1840,AllTrim(Str(aOrdProd[nCnt,4])),oFont08 )
	
	oPrint:Line( Lin,  630, Lin+080,  630 )   	// vertical
	oPrint:Line( Lin, 1230, Lin+080, 1230 )   	// vertical                                           
	oPrint:Line( Lin, 1830, Lin+080, 1830 )   	// vertical
	
	lin += 080

Next nCnt

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³QIP170CabM³ Autor ³ Eduardo de Souza      ³ Data ³ 27/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Monta o Cabecalho das Amostras                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ QIP170CabM(ExpC1)                 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Valor do Campo referencia (cpo. que define a pict) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QIPR170													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QIP170CabM(oPrint,Lin,nQtde)

oPrint:Box(Lin,030,Lin+80, 2350 )

// Descricao Detalhes
oPrint:Line( Lin, nColAmos01-20, Lin+80, nColAmos01-20 ) // vertical

oPrint:Say(Lin+020,nColItem  ,STR0012,oFont08 ) //"Item"
oPrint:Say(Lin+020,nColAmos01,STR0013,oFont08 ) //"Amostra 1"

If nQtde > 1
	oPrint:Line( Lin, nColAmos02-20, Lin+80, nColAmos02-20 )   	// vertical
	oPrint:Line( Lin, nColMedia-20 , Lin+80, nColMedia-20  )   	// vertical
	oPrint:Line( Lin, nColAmpl-20  , Lin+80, nColAmpl-20   )   	// vertical

	oPrint:Say(Lin+020,nColAmos02,STR0014,oFont08 ) //"Amostra 2"
	oPrint:Say(Lin+020,nColMedia ,STR0023,oFont08 ) //"Media"
	oPrint:Say(Lin+020,nColAmpl  ,STR0024,oFont08 ) //"Amplitude"
EndIf

If nQtde > 2
	oPrint:Line( Lin, nColAmos03-20, Lin+80, nColAmos03-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos03,STR0015,oFont08 ) //"Amostra 3"
EndIf

If nQtde > 3
	oPrint:Line( Lin, nColAmos04-20, Lin+80, nColAmos04-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos04,STR0016,oFont08 ) //"Amostra 4"
EndIf

If nQtde > 4
	oPrint:Line( Lin, nColAmos05-20, Lin+80, nColAmos05-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos05,STR0017,oFont08 ) //"Amostra 5"
EndIf

If nQtde > 5
	oPrint:Line( Lin, nColAmos06-20, Lin+80, nColAmos06-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos06,STR0018,oFont08 ) //"Amostra 6"
EndIf

If nQtde > 6
	oPrint:Line( Lin, nColAmos07-20, Lin+80, nColAmos07-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos07,STR0019,oFont08 ) //"Amostra 7"
EndIf

If nQtde > 7
	oPrint:Line( Lin, nColAmos08-20, Lin+80, nColAmos08-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos08,STR0020,oFont08 ) //"Amostra 8"
EndIf

If nQtde > 8
	oPrint:Line( Lin, nColAmos09-20, Lin+80, nColAmos09-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos09,STR0021,oFont08 ) //"Amostra 9"
EndIf

If nQtde > 9
	oPrint:Line( Lin, nColAmos10-20, Lin+80, nColAmos10-20 )   	// vertical
	oPrint:Say(Lin+020,nColAmos10,STR0022,oFont08 ) //"Amostra 10"
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³QIP170PicS³ Autor ³ Eduardo de Souza      ³ Data ³ 27/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Retorna a picture apartir do valor                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ QIP170PicS(ExpC1)                 						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Valor do Campo referencia (cpo. que define a pict) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QIPR170													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QIP170PicS(cValor)

Local cPict  := ""
Local cType  := ""
Local nDec   := 0
Local nPict  := 0
Local nValor := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o numero de casas decimais do Valor de Referencia 			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nDec := QA_NumDec(cValor)	 // Valor de Referencia

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Aumenta mais duas casas decimais alem das anteriores 		³
//³ se variavel lDec estiver ativa. 							³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nDec <= 6
	nDec := nDec + 2
EndIf

cType   := ValType(cValor)
If (cType == "C")
	nValor	:= Val(cValor)
ElseIf (cType == "N")
	nValor	:= cValor
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a picture a partir no. casas decimais do cCampo		³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nDec == 0
	cPict := "@E "+Replicate('9',10)
Else    
	cPict := "@E "+Replicate('9',10-(nDec+1)) + '.' + Replicate('9',nDec)
EndIf

nPict	:= Val(Substr(cPict,4,13))

If Int(nValor) > Int(nPict) //Reconstruir a Picture
	nDec := QA_NumDec(cValor)	 // Valor de Referencia
	cPict := "@E "+Replicate('9',10-(nDec+1)) + '.' + Replicate('9',nDec)
Endif

Return(cPict)
