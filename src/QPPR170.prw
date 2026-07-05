/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "QPPR170.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR170  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 15.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Estudo de Capabilidade                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR170(lBrow,nChart)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Chamada da mBrowse                                 ³±±
±±³          ³ ExpN1 = Imprime ou nao o grafico                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³27.11.01³      ³ Inclusao dos dados na moldura          ³±±
±±³ Robson Ramiro³11.02.03³      ³ Implementacao de graficos              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR170(lBrow,nChart,cPecaAuto,cJPEG,aGraf64)
Local cArqPNG    := ''
Local cDir	     := GetMv("MV_QDIRGRA")
Local cGrupo     := ""
Local cStartPath := GetSrvProfString("Startpath","")
Local lPergunte  := .F.
Local nX         := 0 
Local oPrint     := Nil
Local oQLGrafico := GraficosQualidadeX():New()

Private axTex		:= {}
Private cArqCar     := ""
Private cArqHis     := ""
Private cPecaRev	:= ""
Private cPict		:= ""
Private cTextRet	:= ""
Private lExistChart := FindFunction("QIEMGRAFIC") .AND. GetBuild() >= "7.00.170117A" //controle se executa o grafico modelo novo ou por DLL
      
Default aGraf64     := {}
Default cJPEG       := ""
Default cPecaAuto	:= ""
Default lBrow 		:= .F.
Default nChart		:= 0

// Verifica se o diretorio do grafico é  um  diretorio Local
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
			cArqPNG := "QPPR170" + StrZero(nX,4) + ".PNG"
			If !File(oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG)
				Exit
			EndIf
		Next nX
	EndIf

	aGraf64[7] := cArqPNG

	QIEMGRAFIC(aGraf64[1],nChart/* aGraf64[2] */,aGraf64[3],aGraf64[4],aGraf64[5],,aGraf64[7],,.T.,.F.,,aGraf64[12])

ENDIF


If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

cGrupo := "PPRSEQ"

oPrint	:= TMSPrinter():New(STR0001) //"Capabilidade"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Caracteristica              			³
//³ mv_par04				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)

	If AllTrim(FunName()) == "QPPA170"
		cPecaRev := Iif(!lBrow, M->QK9_PECA + M->QK9_REV + M->QK9_CARAC + M->QK9_SEQ, QK9->QK9_PECA + QK9->QK9_REV + QK9->QK9_CARAC + QK9->QK9_SEQ)
	Else
		lPergunte := Pergunte(cGrupo,.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	 + mv_par03 + mv_par04
		Else
			Return Nil
		Endif
	Endif
Endif

DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+SubStr(cPecaRev,1,42))

DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1") + QK1->QK1_CODCLI + QK1->QK1_LOJCLI)

DbSelectArea("QK2")
DbSetOrder(2)
DbSeek(xFilial()+cPecaRev)

DbSelectArea("QK9")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	M->QK9_PECA	:= QK9->QK9_PECA 			// Para compatibilizacao da funcao abaixo
	M->QK9_REV		:= QK9->QK9_REV
	M->QK9_CARAC	:= QK9->QK9_CARAC	
	M->QK9_SEQ 	:= QK9->QK9_SEQ
	
	cPict := QPPA170p("QK2_TOL")

	DbSelectArea("QKK")
	DbSetOrder(2)
	DbSeek(xFilial()+SubStr(cPecaRev,1,42)+QK9->QK9_OPERAC)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint,nChart,cArqPNG) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		Montarel(oPrint,nChart)
	Endif

	If (lPergunte .and. mv_par05 == 1) .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,870,840,140)
		Else 
			oPrint:Print()
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif
Else
	MsgAlert(OemToAnsi(STR0060),OemToAnsi(STR0059)) 	//Atenção ! ### Nao ha dados a serem impressos ... Verifique os parametros !
Endif           

If File(cDir+cArqHis)       
	If File(cDir+cArqHis)       
		FErase(cDir+"HISTO.BMP") 			
	EndIf
	fRename(cDir+cArqHis,cDir+"HISTO.BMP")	
Endif

If File(cDir+cArqCar)
	If File(cDir+"CARTA.BMP")       
		FErase (cDir+"CARTA.BMP") 			
	EndIf
	fRename(cDir+cArqCar,cDir+"CARTA.BMP")	
Endif  

If File(cDir+"CARTA2.BMP")
	fErase(cDir+"CARTA2.BMP")
EndIf                          

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 15.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Capabilidade                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1,ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Flag para impressao do grafico                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


Static Function MontaRel(oPrint, nChart, cArqPNG)

Local i 	:= 1
Local lin 	:= 0
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

Private oFont16, oFont08, oFont10, oFont07, oFont06

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

//oPrint:StartPage() 		// Inicia uma nova pagina

oFont16	:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08	:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10	:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont07	:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont06	:= TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)

Cabecalho(oPrint,i)  					// Funcao que monta o cabecalho
lin := Detail(oPrint,i,nChart,cArqPNG)	// Funcao que monta os detalhes

If lin > 2050				// Espaco minimo para colocacao do rodape	
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	oPrint:StartPage() 		// Inicia uma nova pagina		
	oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
	oPrint:SayBitmap(05,2100, "Logo.bmp",237,58) 
	lin := 150
Endif

Foot(oPrint,i,@lin)			// Funcao que monta o rodape

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 15.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local cObs			:= ""
Local nx 			:=1

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58) 

oPrint:Say(075,850,STR0003,oFont16 ) //"ESTUDO DE CAPABILIDADE"

//Box Cabecalho
oPrint:Box( 150, 30, 550, 2350 )

// Descricao do Cabecalho
// 1a Linha
oPrint:Say(170,0040,STR0004,oFont08 ) //"Cliente"
oPrint:Say(190,0040,SA1->A1_NOME,oFont06 )

oPrint:Say(170,1010,STR0005,oFont08 ) //"No. Peca (Cliente)"
oPrint:Say(190,1010,Subs(QK1->QK1_PCCLI,1,26),oFont06 ) //32

oPrint:Say(170,1595,STR0006,oFont08 ) //"Revisao/Data Desenho"
oPrint:Say(190,1595,AllTrim(QK1->QK1_REVDES)+Space(2)+DtoC(QK1->QK1_DTRDES),oFont08 )

oPrint:Say(170,2160,STR0007,oFont08 ) //"Pagina"
oPrint:Say(190,2160,StrZero(i,3),oFont08 )

// 2a Linha
oPrint:Say(240,0040,STR0008,oFont08 ) //"Fornecedor"
oPrint:Say(270,0040,SM0->M0_NOMECOM,oFont08 )

oPrint:Say(240,1010,STR0009,oFont08 ) //"No. da Peca (Fornecedor)"
oPrint:Say(270,1010,Subs(QK1->QK1_PECA,1,26),oFont06 ) //32

oPrint:Say(240,1595,STR0010,oFont08 ) //"Revisao da Peca (Fornecedor)"
oPrint:Say(270,1595,QK1->QK1_REV,oFont08 )

oPrint:Line(250, 2049, 310, 2049 )   	// vertical - Sequencia
oPrint:Say(240,2060,STR0057,oFont08) //"Sequencia"
oPrint:Say(270,2060,QK9->QK9_SEQ,oFont08) //QK9->QK9_SEQ

// 3a Linha                                              
oPrint:Say(320,0040,STR0011,oFont08 ) //"Nome da Peca"
oPrint:Say(350,0040,Subs(QK1->QK1_DESC,1,44),oFont06 ) //50

oPrint:Say(320,1010,STR0012,oFont08 ) //"Numero/Descricao da Operacao"
oPrint:Say(350,1010,QKK->QKK_NOPE+Space(2)+SubStr(QKK->QKK_DESC,1,32),oFont08 )

oPrint:Line( 310, 1975, 390, 1975 )	// vertical
oPrint:Say(320,1995,STR0058,oFont07) //"Cavidade/Molde"
oPrint:Say(350,1995,QK9->QK9_CAVMOL,oFont07) //QK9->QK9_CAVMOL

// 4a Linha                                              
oPrint:Say(400,0040,STR0013,oFont08 ) //"Carac. No."
oPrint:Say(430,0040,QK2->QK2_CODCAR,oFont08 )

oPrint:Say(400,0310,STR0014,oFont08 ) //"Caracteristica"
oPrint:Say(430,0310,Subs(QK2->QK2_DESC,1,32),oFont06 ) //38

oPrint:Say(400,1010,STR0015,oFont08 ) //"Realizado por"
oPrint:Say(430,1010,SubStr(QK9->QK9_REAPOR,1,TamSx3("QK9_REAPOR")[1]-4),oFont08 )

oPrint:Say(400,2060,STR0016,oFont08 ) //"Data do Estudo"
oPrint:Say(430,2060,DtoC(QK9->QK9_DTEST),oFont08 )

// 5a Linha
oPrint:Say(480,0040,STR0017,oFont08 ) //"Observacoes"


If !Empty(QK9->QK9_CHAVE)  // Texto da observacao
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QK9->QK9_CHAVE,"QPPA170 ",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			cObs += axTex[nx]
		Endif
	Next nx

	oPrint:Say(510,0040,Subs(cObs,1,120),oFont08)

Endif


// Construcao das linhas do cabecalho
oPrint:Line( 230, 0030, 230, 2350 )   	// horizontal
oPrint:Line( 150, 1000, 470, 1000 )   	// vertical

oPrint:Line( 150, 1575, 310, 1575 )   	// vertical

oPrint:Line( 150, 2150, 230, 2150 )   	// vertical
                                                   
oPrint:Line( 390, 0300, 470, 0300 )   	// vertical
oPrint:Line( 390, 2050, 470, 2050 )   	// vertical

oPrint:Line( 310, 30, 310, 2350 )   	// horizontal
oPrint:Line( 390, 30, 390, 2350 )   	// horizontal
oPrint:Line( 470, 30, 470, 2350 )   	// horizontal

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Detail   ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 15.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Itens do relatorio                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Detail(ExpO1,ExpN1,ExpN2)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±³          ³ ExpN2 = Flag para impressao do grafico                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Detail(oPrint,i,nChart,cArqPNG)
Local cArqOrCa   := ""
Local cArqOrHi   := ""
Local cCond      := "QKA->QKA_PECA+QKA->QKA_REV+QKA->QKA_CARAC+QKA->QKA_SEQ == cPecaRev"
Local cDir		 := GetMv("MV_QDIRGRA")
Local cFileLogo	 := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local lin 	     := 580
Local nHeight    := NIL
Local nLin       := 1460
Local nWidth     := Nil
Local oQLGrafico := GraficosQualidadeX():New()

If Right(cDir,1) <> "\"
	cDir += "\"
Endif

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

If nChart == 0
	//Box Detalhes
	oPrint:Box( 570, 30, 650, 2350 )

	// Construcao da grade
	oPrint:Line( 570, 0200, 650, 0200 )   	// vertical
	oPrint:Line( 570, 0500, 650, 0500 )   	// vertical
	oPrint:Line( 570, 0800, 650, 0800 )   	// vertical
	oPrint:Line( 570, 1100, 650, 1100 )   	// vertical
	oPrint:Line( 570, 1400, 650, 1400 )   	// vertical
	oPrint:Line( 570, 1700, 650, 1700 )   	// vertical
	oPrint:Line( 570, 2000, 650, 2000 )   	// vertical

	// Descricao Detalhes
	oPrint:Say(590,0070,STR0018,oFont08 ) //"Item"
	oPrint:Say(590,0240,STR0019,oFont08 ) //"Amostra 1"
	oPrint:Say(590,0540,STR0020,oFont08 ) //"Amostra 2"
	oPrint:Say(590,0840,STR0021,oFont08 ) //"Amostra 3"
	oPrint:Say(590,1140,STR0022,oFont08 ) //"Amostra 4"
	oPrint:Say(590,1440,STR0023,oFont08 ) //"Amostra 5"
	oPrint:Say(590,1740,STR0024,oFont08 ) //"Media"
	oPrint:Say(590,2040,STR0025,oFont08 ) //"Amplitude"

	DbSelectArea("QKA")
	DbSetOrder(1)
	DbSeek(xFilial("QKA") + cPecaRev)

	Do While !Eof() .and. &cCond

		If lin > 2810		
			i++
			oPrint:EndPage() 		// Finaliza a pagina
			oPrint:StartPage() 		// Inicia uma nova pagina		
			oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
			oPrint:SayBitmap(05,2100, "Logo.bmp",237,58) 
			lin := 150
		Endif

		lin += 80	

		oPrint:Box( lin-20, 30, lin+60, 2350 )

		// Construcao da grade
		oPrint:Line( lin-20, 0200, lin+60, 0200 )   	// vertical
		oPrint:Line( lin-20, 0500, lin+60, 0500 )   	// vertical
		oPrint:Line( lin-20, 0800, lin+60, 0800 )   	// vertical
		oPrint:Line( lin-20, 1100, lin+60, 1100 )   	// vertical
		oPrint:Line( lin-20, 1400, lin+60, 1400 )   	// vertical
		oPrint:Line( lin-20, 1700, lin+60, 1700 )   	// vertical
		oPrint:Line( lin-20, 2000, lin+60, 2000 )   	// vertical

		oPrint:Say(lin,0080,QKA->QKA_ITEM,oFont08)
		oPrint:Say(lin,0240,QKA->QKA_AMOS1,oFont08)
		oPrint:Say(lin,0540,QKA->QKA_AMOS2,oFont08)
		oPrint:Say(lin,0840,QKA->QKA_AMOS3,oFont08)
		oPrint:Say(lin,1140,QKA->QKA_AMOS4,oFont08)
		oPrint:Say(lin,1440,QKA->QKA_AMOS5,oFont08)
		oPrint:Say(lin,1740,QKA->QKA_MEDIA,oFont08)
		oPrint:Say(lin,2040,QKA->QKA_AMPLI,oFont08)

		QKA->(DbSkip())

	Enddo

Elseif nChart == 3
	If lExistChart //controle se executa o grafico modelo novo ou por DLL
		cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
		oPrint:SayBitmap( 600, 30, cImgGraf, 2320,1150)
	Else
		If File(cDir+"HISTO.BMP")
			cArqOrHi := "HISTO.BMP"
			cArqHis  := CriaTrab(, .F.) + ".BMP"
			fRename(cDir+cArqOrHi,cDir+cArqHis)
			oPrint:SayBitmap(600,30,cDir+cArqHis,2320,1150)
		Endif
	Endif
	lin := 1700
Elseif nChart == 1 .Or. nChart == 2 .Or. nChart == 7
	If lExistChart //controle se executa o grafico modelo novo ou por DLL
		cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
		If nChart == 7
			nHeight := 1450
			nWidth  := 2350
			nLin    := 1900
		elseif nChart == 1 .Or. nChart == 2
			nHeight := 1250
			nWidth  := 2350
			nLin    := 1700
		Endif
		oPrint:SayBitmap( 550, 30, cImgGraf, nWidth, nHeight)//Informar params 4 e 5 para img respeitar zoom
		Lin := nLin
	Else
		If File(cDir+"CARTA.BMP")                               
			cArqOrCa := "CARTA.BMP"
			cArqCar  := CriaTrab(, .F.) + ".BMP"
			fRename(cDir+cArqOrCa,cDir+cArqCar)
			oPrint:SayBitmap(600,30,cDir+cArqCar,2320,1150)
		Endif
	Endif
	lin := nLin
Endif

Return lin


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot     ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 18.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot(ExpO1,ExpN1, ExpN2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±³          ³ ExpN2 = Contador de linhas                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR170                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot(oPrint,i,lin)

Local nTOL 		:= 0
Local nLIE 		:= 0
Local nLSE 		:= 0
Local nTotMed	:= Val(QK9->QK9_QTDSUB)*Val(QK9->QK9_TAMSUB)
Local cAval		:= ""      
Local nLICPK 	:= 1.33    // Valor de CPK definido na  norma  NAO MUDAR
Local nLSCPK 	:= 1.67    // Valor de CPK definido na  norma  NAO MUDAR

nTOL := SuperVal(QK2->QK2_TOL)
nLIE := nTOL + SuperVal(QK2->QK2_LIE)
nLSE := nTOL + SuperVal(QK2->QK2_LSE)

lin += 80

oPrint:Say(lin,1000,STR0026,oFont16 ) //"ANALISE DO ESTUDO"
lin += 80

//Box Informacoes das amostras
oPrint:Box( lin, 30, lin+320, 2350 )

oPrint:Line( lin+80, 30, lin+80, 2350 )   	// horizontal

oPrint:Say(lin+10,1100,STR0027,oFont10 ) //"Amostras"

oPrint:Say(lin+100,0040,STR0028,oFont08 ) //"LIE"
oPrint:Say(lin+100,0240,Transform(nLIE, cPict),oFont08 )

oPrint:Say(lin+150,0040,STR0029,oFont08 ) //"LSE"
oPrint:Say(lin+150,0240,Transform(nLSE, cPict),oFont08 )

oPrint:Say(lin+200,0040,STR0030,oFont08 ) //"Nominal"
oPrint:Say(lin+200,0240,Transform(nTOL, cPict),oFont08 )

oPrint:Say(lin+280,0040,STR0031,oFont08 ) //"Maior Medida"
oPrint:Say(lin+280,0240,QK9->QK9_MAIMED,oFont08 )


oPrint:Say(lin+100,0900,STR0032,oFont08 ) //"Tam. Subgrupo"
oPrint:Say(lin+100,1200,QK9->QK9_TAMSUB,oFont08 )

oPrint:Say(lin+150,0900,STR0033,oFont08 ) //"Qtd. Subgrupo"
oPrint:Say(lin+150,1200,QK9->QK9_QTDSUB,oFont08 )

oPrint:Say(lin+200,0900,STR0034,oFont08 ) //"Tot. Medidas"
oPrint:Say(lin+200,1200,Transform(nTotMed, "999"),oFont08 )

oPrint:Say(lin+280,0900,STR0035,oFont08 ) //"Menor Medida"
oPrint:Say(lin+280,1100,QK9->QK9_MENMED,oFont08 )

oPrint:Say(lin+100,1700,STR0036+Space(05)+QK9->QK9_AVANOR,oFont08 ) //"Avaliacao de Normalidade:"

oPrint:Line( lin+140,1700, lin+140, 1720 ) 	// X medio
oPrint:Line( lin+145,1700, lin+145, 1720 )
oPrint:Say(lin+150,1700,"X:",oFont08 )
oPrint:Say(lin+150,1850,Transform(Val(QK9->QK9_XBB),cPict),oFont08 )

oPrint:Line( lin+195,1700, lin+195, 1720 )   	// R medio
oPrint:Say(lin+200,1700,"R:",oFont08 )
oPrint:Say(lin+200,1850,Transform(Val(QK9->QK9_RB),cPict),oFont08 )

oPrint:Say(lin+280,1700,STR0037,oFont08 ) //"Ptos. Fora"
oPrint:Say(lin+280,1850,QK9->QK9_PONFOR,oFont08 )
                                            
oPrint:Say(lin+280,2050,STR0038,oFont08 ) //"Unilateral:"
oPrint:Say(lin+280,2200,Iif(nLIE <> 0, STR0039, STR0040),oFont08 ) //"Nao"###"Sim"

lin += 360

//Box limites de controle
oPrint:Box( lin, 30, lin+320, 2350 )

oPrint:Line( lin+80, 30, lin+80, 2350 )   	// horizontal

oPrint:Line( lin+160, 30, lin+160, 2350 )   	// horizontal

oPrint:Line( lin+240, 30, lin+240, 2350 )   	// horizontal

oPrint:Say(lin+10,1050,STR0041,oFont10 ) //"Carta das Medias"

oPrint:Say(lin+100,0040,STR0042+Space(5)+Transform(Val(QK9->QK9_MEDLCI),cPict),oFont08 ) //"Limite de Controle Inferior(LCI):"
oPrint:Say(lin+100,0900,STR0043+Space(5)+Transform(Val(QK9->QK9_MEDLCS),cPict),oFont08 ) //"Limite de Controle Superior(LCS):"
oPrint:Say(lin+100,1700,STR0044+Space(5)+QK9->QK9_MEDPFO,oFont08 ) //"Numero de Pontos Fora dos Limites :"

oPrint:Say(lin+170,1050,STR0045,oFont10 ) //"Carta das Amplitudes"

oPrint:Say(lin+260,0040,STR0042+Space(5)+Transform(Val(QK9->QK9_AMPLCI),cPict),oFont08 ) //"Limite de Controle Inferior(LCI):"
oPrint:Say(lin+260,0900,STR0043+Space(5)+Transform(Val(QK9->QK9_AMPLCS),cPict),oFont08 ) //"Limite de Controle Superior(LCS):"
oPrint:Say(lin+260,1700,STR0046+Space(5)+QK9->QK9_AMPPFO,oFont08 ) //"Numero de Pontos Fora dos Limites:"

lin += 360

//Box capabilidade / performance
oPrint:Box( lin, 30, lin+320, 2350 )

oPrint:Line( lin+80, 30, lin+80, 2350 )   	// horizontal
oPrint:Line( lin, 1160, lin+320, 1160 )   		// vertical

oPrint:Say(lin+10,0480,STR0001,oFont10 ) //"Capabilidade"
oPrint:Say(lin+10,1640,STR0047,oFont10 )  //"Desempenho"

oPrint:Say(lin+090,040,STR0048,oFont08 ) //"Desvio Padrao:"
oPrint:Say(lin+090,270,Transform(Val(QK9->QK9_CAPDES),cPict),oFont08 )

oPrint:Say(lin+090,600,"Cp:",oFont08 )
oPrint:Say(lin+090,700,Transform(Val(QK9->QK9_CP),cPict),oFont08 )

oPrint:Say(lin+170,160," CR:",oFont08 )
oPrint:Say(lin+170,270,Transform(Val(QK9->QK9_CR),cPict),oFont08 )

oPrint:Say(lin+170,600,"Cpk:",oFont08 )
oPrint:Say(lin+170,700,Transform(Val(QK9->QK9_CPK),cPict),oFont08 )

oPrint:Say(lin+090,1170,STR0048,oFont08 ) //"Desvio Padrao:"
oPrint:Say(lin+090,1400,Transform(Val(QK9->QK9_PERDES),cPict),oFont08 )

oPrint:Say(lin+090,1730,"Pp:",oFont08 )
oPrint:Say(lin+090,1830,Transform(Val(QK9->QK9_PP),cPict),oFont08 )

oPrint:Say(lin+170,1290," PR:",oFont08 )
oPrint:Say(lin+170,1400,Transform(Val(QK9->QK9_PR),cPict),oFont08 )

oPrint:Say(lin+170,1730,"Ppk:",oFont08 )
oPrint:Say(lin+170,1830,Transform(Val(QK9->QK9_PPK),cPict),oFont08 )

DbSelectArea("QK1")
DbSetOrder(1)
If DbSeek(xFilial("QK1") + QK9->QK9_PECA + QK9->QK9_REV)
	nLICPK := QK1_LICPK
	nLSCPK := QK1_LSCPK
EndIf

Do Case
	Case SuperVal(QK9->QK9_CPK) < nLICPK	
		cAval := STR0054 //"PROCESSO INCAPAZ"
	Case SuperVal(QK9->QK9_CPK) > nLICPK .and. SuperVal(QK9->QK9_CPK) <= nLSCPK
		cAval := STR0055 //"PROCESSO CAPAZ"
	Case SuperVal(QK9->QK9_CPK) > nLSCPK	
		cAval := STR0056 //"PROCESSO ALTAMENTE CAPAZ"
Endcase

oPrint:Say(lin+250,0040,cAval,oFont10)

lin += 360

//Box disposicao
oPrint:Box( lin, 30, lin+160, 2350 )

oPrint:Line( lin+80, 0030, lin+080, 2350 )   	// horizontal
oPrint:Line( lin+80, 0600, lin+160, 0600 )   	// vertical
oPrint:Line( lin+80, 2000, lin+160, 2000 )   	// vertical

oPrint:Say(lin+10,1050,STR0049,oFont10 ) //"Disposicao"

oPrint:Say(lin+090,0040,STR0049,oFont08 ) //"Disposicao"
oPrint:Say(lin+120,0040,Iif(QK9->QK9_DISP == "1", STR0050,STR0051),oFont08 ) //"Aprovado"###"Rejeitado"

oPrint:Say(lin+090,0610,STR0052,oFont08 ) //"Responsavel"
oPrint:Say(lin+120,0610,QK9->QK9_RESP,oFont08 )

oPrint:Say(lin+090,2010,STR0053,oFont08 ) //"Data"
oPrint:Say(lin+120,2010,DtoC(QK9->QK9_DATA),oFont08 )

lin += 160
Return
