/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE  "QPPR190.CH"
#INCLUDE  "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR190  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Resultados dos Ensaios de Materiais                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR190(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³03.08.01³      ³  Inclusao dos dados na moldura         ³±±
±±³ Robson Ramiro³11.10.02³      ³ Compatiblizacao das alteracoes efetuada³±±
±±³              ³        ³      ³ na 710, e impressao a partir da mBrowse³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR190(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cGrupo

Private cStartPath 	:= GetSrvProfString("Startpath","")
Private aAreaQKD	:= {}
Private cPecaRev 	:= ""
Private cCondW		:= ""
Private	lImpCar		:= .F.		
Private	lImpCar2	:= .F.		
Private lPergunte   := .F.
Private nEdicao := Val(GetMv("MV_QPPAPED",.T.,"3"))// Indica a Edicao do PPAP default 3 Edicao

Default lBrow := .F.
Default cPecaAuto	:= ""
Default cJPEG       := "" 

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

cCondW := "QKD->QKD_PECA+QKD->QKD_REV+QKD->QKD_SEQ == cPecaRev"

cGrupo := "PPR190"

oPrint	:= TMSPrinter():New( STR0001 ) //"Resultados Materiais"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//³ mv_par04				// Impr. Caracteristica?      			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA190"
			cPecaRev := Iif(!lBrow, M->QKD_PECA + M->QKD_REV + M->QKD_SEQ, QKD->QKD_PECA + QKD->QKD_REV + QKD->QKD_SEQ)
		If MsgYesNo(OemToAnsi(STR0028),OemToAnsi(STR0029)) //"Deseja Imprimir Codigo/Descricao Caracteristica ?" ### "Caracteristica"
			lImpCar := .T.		
			lImpCar2:= .T.
		Endif
	Else
		lPergunte := Pergunte(cGrupo,.T.)    

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	+ mv_par05
		Else
			Return Nil
		Endif
	Endif
Endif

If !lBrow .and. !Empty(cPecaAuto)
	Pergunte(cGrupo,.F.)
    mv_par04 := 2
EndIf
	
DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+Subs(cPecaRev,1,42))

DbSelectArea("QK2")
DbSetOrder(2)
DbSeek(xFilial()+Subs(cPecaRev,1,42))

DbSelectArea("QKD")
cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	aAreaQKD := GetArea()
	
	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If (lPergunte) .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,875,1100,140)
		Else 
			If mv_par03 == 2
				If !Empty(cJPEG)
					oPrint:SaveAllAsJPEG(cStartPath+cJPEG,875,1100,140)
				Endif	
				oPrint:Preview()  		// Visualiza antes de imprimir
			Else
				oPrint:Print()
			Endif	
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif

Else

	MsgAlert(OemToAnsi(STR0055),OemToAnsi(STR0054))

Endif

dbSelectArea("QKD")
If !Empty(cFiltro)
	Set Filter To &cFiltro
Endif

If !lPergunte
	RestArea(aArea)
Endif

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Ensaios Materiais                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i 	:= 1
Local lin 	:= 0
Local cCdCar:= ""
Local aTxtDesc 	:= {}
Local linaux 	:= 0 
Local nC 		:= 0 
Local cVar      := ""
Local nCount    := ""

Private oFont16, oFont06, oFont08, oFont10, oFont12, oFontCou05, oFontCou08
Private dDataApr := Dtoc(QKD->QKD_DTAPR)
Private cAssFor

oFont06		:= TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12		:= TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFontCou05	:= TFont():New("Courier New",05,05,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)


If nEdicao == 3
	Cabec190(oPrint,i)  			// Funcao que monta o cabecalho
	lin := 540
Else 
	Cabec191(oPrint,i)  			// Funcao que monta o cabecalho	
	lin := 615
EndIf

DbSelectArea("QKD")

Do While !Eof() .and. xFilial("QKD") == QKD->QKD_FILIAL .and. &cCondW
	linaux := 0
	If lin > 2580
		i++
		// Finaliza a pagina
		If nEdicao == 3
			oPrint:EndPage() 
			Cabec190(oPrint,i)  			// Funcao que monta o cabecalho
			lin := 540
		Else
			Foot191(oPrint)
			oPrint:EndPage() 
			Cabec191(oPrint,i)  			// Funcao que monta o cabecalho	
			lin := 615
		EndIf
	Endif
	
	lin += 40
    If nEdicao > 3
		oPrint:Say(lin,1440,QKD->QKD_RESFOR,oFontCou08)
		oPrint:Say(lin,1825,QKD->QKD_RESCLI,oFontCou08)
		oPrint:Say(lin,1320,QKD->QKD_QTTEST,oFontCou08)
		oPrint:Say(lin,1110,Dtoc(QKD->QKD_DTENSA),oFontCou08)	
		cCdCar := ""
		If !lPergunte
			If lImpCar
				oPrint:Say(0525,0050,OemToAnsi(STR0030),oFont08 ) //"Codigo/Descricao Caracteristica" 
			Else
				cCdCar := ""
			EndIf
		Else                            
			If mv_par04 == 1
				oPrint:Say(0525,0050,OemToAnsi(STR0030),oFont08 ) //"Codigo/Descricao Caracteristica" 
				lImpCar2 := .T.
			Else
				cCdCar := ""
			EndIf
		EndIf

		Iif(QKD->QKD_FLOK == "1",	oPrint:Say(lin,2215,"X",oFontCou08),;
									oPrint:Say(lin,2295,"X",oFontCou08)) 

		DbSelectArea("QK1")
		DbSetOrder(1)
		DbSeek(xFilial()+QKD->QKD_PECA+QKD->QKD_REV)									
    	aTxtDesc := {}
		aTxtDesc := JustificaTXT(QKD->QKD_ITEM+" "+QK1->QK1_REV+" "+Dtoc(QK1->QK1_DTREVI)+If(Empty(AllTrim(cCdCar)),"",CHR(13)+CHR(10)+cCdCar),23,.T.,.F.) // Limpa o Texto/Justifica 
		nC := 0
		linaux := lin
		DbSelectArea("QK2")
		DbSetOrder(2)
		DbSeek(xFilial()+Subs(cPecaRev,1,42)+QKD->QKD_CARAC)
		If !Empty(AllTrim(QK2->QK2_TOL))
			oPrint:Say(lin,0785,"NOM: "+QK2->QK2_TOL,oFontCou08) // "NOM: "
		EndIf
		If !Empty(AllTrim(QK2->QK2_LIE))
			lin += 40        
			nC += 1
			oPrint:Say(lin,0785,"LIE: "+Alltrim(QK2->QK2_LIE),oFontCou08) // "LIE: "
		EndIf
		If !Empty(AllTrim(QK2->QK2_LSE))
			lin += 40
			nC += 1
			oPrint:Say(lin,0785,"LSE: "+Alltrim(QK2->QK2_LSE),oFontCou08) // "LSE: "
		EndIf
	    If Len(aTxtDesc) <= 2
			If Len(aTxtDesc) > 0
			    lin := linaux
			    For nC := 1 to Len(aTxtDesc)
			    	oPrint:Say(lin,050,aTxtDesc[nC],oFontCou08)
			    	If lImpCar .or. lImpCar2
			    		cVar := RTRIM(QKD->QKD_CARAC+" "+QKD->QKD_DESC)
			    		FOR nCount := 1 to mlcount(cVar,40)
					    	oPrint:Say(lin+40,050,memoline(cVar,40,nCount))
					    	lin += 40
					    next
				    Endif
			    	lin += 40
					If lin > 2580
						i++
						// Finaliza a pagina
						Foot191(oPrint)
						oPrint:EndPage() 
						Cabec191(oPrint,i)  			// Funcao que monta o cabecalho	
						lin := 615
					Endif
			    Next				
			EndIf
        Else
		    lin := linaux
		    For nC := 1 to Len(aTxtDesc)
		    	oPrint:Say(lin,050,aTxtDesc[nC],oFontCou08)
		    	If lImpCar .Or. lImpCar2
			    	oPrint:Say(lin+40,050,QKD->QKD_CARAC+" "+QKD->QKD_DESC)
		    	Endif
		    	lin += 40
		    Next
		EndIf
	Else 
		oPrint:Say(lin,060,QKD->QKD_CARAC,oFontCou08)
		oPrint:Say(lin,240,QKD->QKD_TPTEST,oFontCou08)
		oPrint:Say(lin,440,Subs(QKD->QKD_DESC,1,42),oFontCou08)
		cCdCar := ""
		If QK2->(DbSeek(xFilial()+Subs(cPecaRev,1,42)+QKD->QKD_CARAC))
			PPAPBMP(QK2->QK2_SIMB+".BMP", cStartPath)
			oPrint:SayBitmap(lin,1205,QK2->QK2_SIMB+".BMP",40,40)
			cCdCar := Alltrim(QKD->QKD_CARAC)+"-"+Alltrim(SubStr(QKD->QKD_DESC,1,40))
		Endif
		oPrint:Say(lin,1290,QKD->QKD_RESFOR,oFontCou08)
		oPrint:Say(lin,1715,QKD->QKD_RESCLI,oFontCou08)
		
		Iif(QKD->QKD_FLOK == "1",	oPrint:Say(lin,2160,"X",oFontCou08),;
							oPrint:Say(lin,2270,"X",oFontCou08)) 
							
		If !lPergunte
			If lImpCar
				lin +=40	
				If lin > 2280
					i++
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec190(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 540
				Endif
			
				oPrint:Say(480,0630,OemToAnsi(STR0030),oFont08 ) //"Codigo/Descricao Caracteristica"
				oPrint:Say(lin,440,cCdCar,oFontCou08)	
			Endif
		Else
			If mv_par04 == 1
				lin +=40	
				If lin > 2280
					i++
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec190(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 540
				Endif
			
				oPrint:Say(480,0630,OemToAnsi(STR0030),oFont08 ) //"Codigo/Descricao Caracteristica"
				oPrint:Say(lin+40,050,QKD->QKD_CARAC+" "+QKD->QKD_DESC)
			Endif	
		Endif		    
	Endif
	lin += 40

	DbSelectArea("QKD")
	DbSetOrder(1)
	DbSkip()
Enddo

If nEdicao == 3
	Foot190(oPrint)			// Funcao que monta o rodape
Else
	DbSelectArea("QKD")
	DbSkip(-1)
	Foot191(oPrint)			// Funcao que monta o rodape
EndIf

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec190 ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec190(ExpO1,ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec190(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,750,STR0003,oFont16 ) //"Aprovacao de Peca de Producao"
oPrint:Say(090,750,STR0004,oFont16 ) //"Resultados dos Ensaios de Materiais"

oPrint:Say(171,30,STR0005,oFont08 ) //"PPAP No."
oPrint:Say(171,160,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,2100,STR0006,oFont08 ) //"Pagina :"
oPrint:Say(171,2250,StrZero(i,3),oFont08)

oPrint:Say(090,2050,STR0027,oFont08) //"Sequencia :"
oPrint:Say(090,2250,QKD->QKD_SEQ,oFont08) 

//Box Cabecalho
oPrint:Box( 210, 30, 370, 2350 )

//Box Itens
oPrint:Box( 390, 30, 2890, 2350 )

// Construcao da Grade cabecalho
oPrint:Line( 290, 0030, 290, 2350 )   	// horizontal

oPrint:Line( 210, 1400, 370, 1400 )   	// vertical
                                                 
oPrint:Line( 210, 1875, 290, 1875 )   	// vertical

oPrint:Line( 290, 685, 370, 685 )   	// vertical  

// Construcao da Grade itens
oPrint:Line( 530, 0030, 530, 2350 )   	// horizontal

oPrint:Line( 390, 230, 2890, 230 )   	// vertical

oPrint:Line( 390, 430, 2890, 430 )   	// vertical

oPrint:Line( 390, 1180, 2890, 1180 )   // vertical

oPrint:Line( 390, 1280, 2890, 1280 )   // vertical

oPrint:Line( 530, 1705, 2890, 1705 )   // vertical

oPrint:Line( 390, 2130, 2890, 2130 )   // vertical

oPrint:Line( 390, 2240, 2890, 2240 )   // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0007,oFont08 ) //"Fornecedor"
oPrint:Say(250,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1410,STR0008,oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(250,1410,Subs(QK1->QK1_PCCLI,1,26),oFontCou08)

oPrint:Say(210,1885,STR0009,oFont08 ) //"Revisao/Data Desenho"
oPrint:Say(250,1885,AllTrim(QK1->QK1_REVDES)+Space(01)+DtoC(QK1->QK1_DTRDES),oFontCou08)
                                                     
oPrint:Say(290,0040,STR0010,oFont08 )     //"Laboratorio"
oPrint:Say(330,0045,Subs(QKD->QKD_LABOR,1,35),oFontCou08)

oPrint:Say(290,0695,STR0011,oFont08 ) //"Numero/Rev Peca(Fornecedor)"
oPrint:Say(330,0695,AllTrim(Subs(QK1->QK1_PECA,1,36))+"/"+ QK1->QK1_REV,oFontCou08)

oPrint:Say(290,1410,STR0012,oFont08 ) //"Nome da Peca"
oPrint:Say(330,1410,Subs(QK1->QK1_DESC,1,50),oFontCou08)


// Descricao dos itens
oPrint:Say(445,0060,STR0013,oFont08 ) //"No. Caract"
oPrint:Say(420,0280,STR0014,oFont08 ) //"Tipo de"
oPrint:Say(450,0280,STR0015,oFont08 ) //" Teste "
oPrint:Say(420,0630,STR0016,oFont08 ) //"Numero da Especificacao do"
oPrint:Say(450,0630,STR0017,oFont08 ) //"Material/Data/Especificacao"
oPrint:Say(420,1190,STR0018,oFont08 ) //"Carac."
oPrint:Say(450,1190,STR0019,oFont08 ) //" Esp  "
oPrint:Say(450,1400,STR0007,oFont08 ) //"Fornecedor"
oPrint:Say(420,1550,STR0020,oFont08 ) //"Resultados dos Ensaios"
oPrint:Say(450,1825,STR0025,oFont08 ) //"Cliente"
oPrint:Say(440,2150,STR0021,oFont08 ) //"Ok"
oPrint:Say(420,2260,STR0022,oFont08 ) //"Nao"
oPrint:Say(450,2260,STR0021,oFont08 ) //"Ok"

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec191 ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 11.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cabecalho do relatorio PPAP 4 Edicao                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec191(ExpO1,ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec191(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local cDesc		 := " "

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,750,STR0003,oFont16 ) //"Aprovacao de Peca de Producao"
oPrint:Say(090,750,STR0004,oFont16 ) //"   Resultados Dimensionais   "

//
Do Case
	Case QK1->QK1_TPLOGO == "1" 
		cLogoPad	:= "BIG3.BMP"
		nWeight		:= 370
		nWidth		:= 70
	Case QK1->QK1_TPLOGO == "2" 
		cLogoPad 	:= "CHRYSLER.BMP"
		nWeight		:= 370
		nWidth		:= 70
	Case QK1->QK1_TPLOGO == "3" 
		cLogoPad 	:= "FORD.BMP"
		nWeight		:= 160
		nWidth		:= 80
	Case QK1->QK1_TPLOGO == "4" 
		cLogoPad := "GM.BMP"
		nWeight		:= 80
		nWidth		:= 80
	Case QK1->QK1_TPLOGO == "5" 
		cLogoPad 	:= ""
		nWeight		:= 0
		nWidth		:= 0
	OtherWise
		cLogoPad	:= "BIG3.BMP"
		nWeight		:= 370 
		nWidth		:= 70
Endcase

PPAPBMP(cLogoPad, cStartPath)
oPrint:SayBitmap(141,0080, cLogoPad,nWeight,nWidth)
oPrint:Say(171,500,STR0005,oFont08 ) 		//"PPAP No."
oPrint:Say(171,630,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,1800,STR0006,oFont08 ) //"Pagina :"
oPrint:Say(171,1950,StrZero(i,3),oFont08)

oPrint:Say(171,1375,STR0027,oFont08)	//"Sequencia :"
oPrint:Say(171,1575,QKD->QKD_SEQ,oFont08)

//Box Cabecalho
oPrint:Box( 210, 30, 450, 2350 )                                  

//Box Itens
oPrint:Box( 470, 30, 2890, 2350 )

// Construcao da Grade cabecalho
oPrint:Line( 290, 0030, 290, 1250 )   	// horizontal
                                                         
oPrint:Line( 210, 1250, 450, 1250 )   	// vertical
                                                 
// Construcao da Grade itens
  
oPrint:Line( 0610, 0030, 0610, 2350 )   	// horizontal

oPrint:Line( 0470, 0775, 2810, 0775 )  	// vertical

oPrint:Line( 0470, 1095, 2810, 1095 )   // vertical

oPrint:Line( 0470, 1285, 2810, 1285 )   // vertical

oPrint:Line( 0470, 1430, 2810, 1430 )   // vertical


oPrint:Line( 0610, 1800, 2810, 1800 )   // vertical

oPrint:Line( 0470, 2190, 2810, 2190 )   // vertical

oPrint:Line( 0470, 2270, 2810, 2270 )   // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0007+" :",oFont08 ) //"Fornecedor"
oPrint:Say(210,0200,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1260,STR0008+" :",oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(210,1610,Alltrim(Subs(QK1->QK1_PCCLI,1,26))+IIF(EMPTY(AllTrim(QK1->QK1_REVDES)),"","/"+AllTrim(QK1->QK1_REVDES)),oFontCou08)

oPrint:Say(250,0040,STR0031+" :",oFont08 ) // "Codigo Fornecedor/Vendedor"
oPrint:Say(250,0440,QK1->QK1_CODVCL,oFontCou08)    

oPrint:Say(250,1260,STR0012+" :",oFont08 ) //"Nome da Peca"
oPrint:Say(250,1475,Subs(QK1->QK1_DESC,1,50),oFontCou08)

oPrint:Say(290,0040,STR0032+" :",oFont08 ) //"Material Fornecedor"
cDesc := QKD->QKD_OBSERV
If Len(Alltrim(cDesc)) <= 50
	oPrint:Say(290,0380,Alltrim(cDesc),oFontCou08)
Else
	oPrint:Say(290,0380,Substr(cDesc,1,50),oFontCou08)
	oPrint:Say(310,0380,Substr(cDesc,51,50),oFontCou08)	
EndIf

oPrint:Say(290,1260,STR0033+" :",oFont08 ) //"Nivel de Alteracao do Projeto"
oPrint:Say(290,1660,IIF(QK1->QK1_NALPRJ == "1","Alto",;
                         IIF(QK1->QK1_NALPRJ == "2","Medio",;
                             IIF(QK1->QK1_NALPRJ = "3","Baixo"," "))),oFontCou08)

oPrint:Say(330,1260,STR0034+" :",oFont08 ) //"Documentos Alterados pela Engenharia"
oPrint:Say(330,1780,Alltrim(QK1->QK1_ALTDOC),oFontCou08)

oPrint:Say(370,1260,STR0010+" :",oFont08 )     //"Laboratorio"
oPrint:Say(370,1475,Subs(QKD->QKD_LABOR,1,35),oFontCou08)

oPrint:Say(410,1260,STR0035+" :",oFont08 ) //"Data Desenho"
oPrint:Say(410,1475,DtoC(QK1->QK1_DTRDES),oFontCou08)  

// Descricao dos itens
oPrint:Say(495,0050,STR0053,oFont08 ) //"Numero da Especificacao do"
oPrint:Say(495,0860,STR0038,oFont08 ) //"Especificao"
oPrint:Say(525,0860,STR0039,oFont08 ) //"  Limites  "
oPrint:Say(495,1140,STR0048,oFont08 ) //" Data  "
oPrint:Say(525,1140,STR0049,oFont08 ) //" Ensaio"
oPrint:Say(495,1320,STR0042,oFont08 ) //"  QTD  "
oPrint:Say(525,1320,STR0043,oFont08 ) //"  Ens. "
oPrint:Say(500,1685,STR0020,oFont08 ) //"Resultados dos Ensaios"
oPrint:Say(550,1520,STR0007,oFont08 ) //"Fornecedor"
oPrint:Say(550,1950,STR0025,oFont08 ) //"Cliente"
oPrint:Say(515,2215,STR0021,oFont08 ) //"Ok"
oPrint:Say(495,2285,STR0022,oFont08 ) //"Nao"
oPrint:Say(525,2295,STR0021,oFont08 ) //"Ok"

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot     ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot(ExpO1,ExpN1, ExpN2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR190                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot190(oPrint)

//Box 
oPrint:Box( 2890, 030, 2970, 2350 )

oPrint:Line( 2890, 1080, 2970, 1080 )		// horizontal
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical

oPrint:Say(2900,0050,STR0026,oFont08 ) //"Assinatura do Cliente"

RestArea(aAreaQKD)
oPrint:Say(2900,1090,STR0023,oFont08 ) //"Assinatura do Fornecedor"
oPrint:Say(2940,1090,QKD->QKD_ASSFOR,oFontCou08) 

oPrint:Say(2900,2140,STR0024,oFont08 ) //"Data"
oPrint:Say(2940,2140,dDataApr,oFontCou08)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot191  ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 09.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot191(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot191(oPrint)

Local cAss 		:= ""
Local cCodFun 	:= ""
Local cCargo	:= ""
//Box 
oPrint:Box( 2810, 030, 2970, 2350 )

oPrint:Say(2820,0300,STR0044,oFont12) //"Declarações de conformidade não são aceitas para qualquer resultado" -> Acertar STR0044

oPrint:Line( 2890, 0030, 2890, 2350)		// horizontal   
oPrint:Line( 2890, 1080, 2970, 1080 )   	// vertical
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical

oPrint:Line( 2890, 0030, 2890, 2350)		// horizontal   
oPrint:Line( 2890, 1080, 2970, 1080 )   	// vertical
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical
oPrint:Say(2900,0050,STR0046,oFont08 ) 		//"Assinatura
oPrint:Say(2940,0200,QKD->QKD_ASSFOR,oFontCou08) 
cAss 	:= QKD->QKD_ASSFOR           

If !Empty(cAss) 
	DbSelectArea("QAA")
	DbSetOrder(6)
	If DbSeek(Upper(Alltrim(cAss)))
		cCodFun := QAA->QAA_CODFUN  
		DbSelectArea("QAC")
		DbSetOrder(1)
		If DbSeek(xFilial()+cCodFun)
			cCargo	:= QAC->QAC_DESC
		Endif	
	Endif	
Endif          

oPrint:Say(2900,1090,STR0047,oFont08 ) 		//"Funcao
oPrint:Say(2935,1100,cCargo,oFontCou08)
oPrint:Say(2900,2140,STR0024,oFont08 ) 		//"Data"      
oPrint:Say(2935,2140,dDataApr,oFontCou08)

lin := 2980
oPrint:Say(lin,90,STR0045,oFont06)    //"Marco"
lin +=20          
oPrint:Say(lin,90,"2006",oFont06)
lin -=12  
oPrint:Say(lin,200,"CFG-1004",oFont10)   //"CFG-1004"

Return Nil
