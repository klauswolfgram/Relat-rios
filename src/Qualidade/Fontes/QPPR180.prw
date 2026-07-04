/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR180.CH"
#INCLUDE "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR180  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³PPAP Resultados Dimensionais                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR180(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³01.08.01³      ³ Inclusao dos dados na moldura          ³±±
±±³ Robson Ramiro³11.10.02³      ³ Compatiblizacao das alteracoes efetuada³±±
±±³              ³        ³      ³ na 710, e impressao a partir da mBrowse³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR180(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cGrupo

Private cStartPath 	:= GetSrvProfString("Startpath","")
Private aAreaQKB 		:= {}
Private cPecaRev 		:= ""
Private cCondW			:= ""
Private lImpCd			:= .F.   
Private nEdicao 		:= Val(GetMv("MV_QPPAPED",.T.,"3"))// Indica a Edicao do PPAP default 3 Edicao

Default lBrow 			:= .F.
Default cPecaAuto		:= ""
Default cJPEG       	:= ""  

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

cCondW := "QKB->QKB_PECA+QKB->QKB_REV+QKB->QKB_SEQ == cPecaRev"

cGrupo := "ESTSEQ"

oPrint	:= TMSPrinter():New( STR0002 ) //"Resultados Dimensionais"

oPrint:SetPortrait()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//³ mv_par04				// Imprime Caracteristica?     			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lBrow
	If MsgYesNo(OemToAnsi(STR0026),OemToAnsi(STR0027)) //"Imprime Descricao/Caracteristica?" ### "Impressao"		
		lImpCd := .T.
	Else                                                                                                     
		lImpCd := .F.
	Endif
Endif

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA180"
		Pergunte(cGrupo,.F.)
	    mv_par04 := 2
		cPecaRev := Iif(!lBrow, M->QKB_PECA + M->QKB_REV + M->QKB_SEQ, QKB->QKB_PECA + QKB->QKB_REV + QKB->QKB_SEQ)
	Else
		lPergunte := Pergunte(cGrupo,.T.)	

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	+ mv_par03
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

DbSelectArea("QKB")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	aAreaQKB := GetArea()

	If Empty(cPecaAuto)
		MsgRun(STR0001,"",{|| CursorWait(), MontaRel(oPrint,lBrow) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint,lBrow)
	Endif

	If (lPergunte .and. mv_par04 == 1) .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,875,1100,140)
		Else 
			oPrint:Print()
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif

Else

	MsgAlert(OemToAnsi(STR0053),OemToAnsi(STR0052))

Endif

dbSelectArea("QKB")
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Resultados Dimensionais                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpO2 = Impressao via Browser                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MontaRel                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint,lBrow)
Local aTxtDesc 	   := {}
Local cCdCar	   := ""
Local i 		   := 1
Local lin 		   := 0
Local linaux 	   := 0 
Local nC 		   := 0
Private dDataApr   := Dtoc(QKB->QKB_DTAPR)
Private oFont06	   := TFont():New("Arial" ,06,06,,.F.,,,,.T.,.F.)
Private oFont08	   := TFont():New("Arial" ,08,08,,.F.,,,,.T.,.F.)
Private oFont10	   := TFont():New("Arial" ,10,10,,.F.,,,,.T.,.F.)  
Private oFont12	   := TFont():New("Arial" ,12,12,,.F.,,,,.T.,.F.) 
Private oFont16	   := TFont():New("Arial" ,16,16,,.F.,,,,.T.,.F.)
Private oFontCou08 := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

If nEdicao == 3
	lin := 530
Else
	lin := 590
EndIf



If nEdicao == 3
	Cabec180(oPrint,i,lBrow)  			// Funcao que monta o cabecalho
Else
	Cabec181(oPrint,i,lBrow)  			// Funcao que monta o cabecalho
EndIf

DbSelectArea("QKB")

Do While !Eof() .and. xFilial("QKB") == QKB->QKB_FILIAL .and. &cCondW
	linaux := 0
	cCdCar := ""
	If lin > 2580		
		i++
		If nEdicao == 3
			oPrint:EndPage() 			// Finaliza a pagina
			Cabec180(oPrint,i,lBrow)  	// Funcao que monta o cabecalho 
			lin := 530
		Else
			Foot181(oPrint)				// Funcao que monta o rodape
			oPrint:EndPage() 			// Finaliza a pagina
			Cabec181(oPrint,i,lBrow)  	// Funcao que monta o cabecalho 
			lin := 590
		EndIf		
	Endif
	                                    			
	lin += 40
	oPrint:Say(lin,050,QKB->QKB_ITEM,oFontCou08)
	If nEdicao == 3
		oPrint:Say(lin,140,QKB->QKB_DESC,oFontCou08)
	EndIf

	If QK2->(DbSeek(xFilial("QK2")+Subs(cPecaRev,1,42)+QKB->QKB_CARAC))
		PPAPBMP(QK2->QK2_SIMB+".BMP", cStartPath)
	    If nEdicao == 3
			oPrint:SayBitmap(lin,1110,QK2->QK2_SIMB+".BMP",40,40)
		EndIf
		
		If lBrow 
			If lImpCd
		    	cCdCar := Alltrim(QK2->QK2_CODCAR)+" - "+Alltrim(SubStr(QK2->QK2_DESC,1,TamSx3("QK2_DESC")[1]-4))
	        Endif
		Else
			If mv_par05 == 1
				cCdCar := Alltrim(QK2->QK2_CODCAR)+" - "+Alltrim(SubStr(QK2->QK2_DESC,1,TamSx3("QK2_DESC")[1]-4))
			Endif
		Endif
		
	
	Endif

	Iif(QKB->QKB_FLOK == "1",	oPrint:Say(lin,2160,"X",oFontCou08),;
								oPrint:Say(lin,2270,"X",oFontCou08))	
	

    If nEdicao == 3
		oPrint:Say(lin,1190,QKB->QKB_RESFOR,oFontCou08)
		oPrint:Say(lin,1665,QKB->QKB_RESCLI,oFontCou08)
	Else 
		oPrint:Say(lin,1290,QKB->QKB_RESFOR,oFontCou08)
		oPrint:Say(lin,1750,QKB->QKB_RESCLI,oFontCou08)
	EndIf

    If nEdicao <> 3
    	aTxtDesc := {}
		aTxtDesc := JustificaTXT(QKB->QKB_DESC+If(Empty(AllTrim(cCdCar)),"",CHR(13)+CHR(10)+cCdCar),27,.T.,.F.) // Limpa o Texto/Justifica 
		oPrint:Say(lin,1165,SubStr(QKB->QKB_QTTEST,1,5),oFontCou08)
		oPrint:Say(lin,950,Dtoc(QKB->QKB_DTENSA),oFontCou08)	
		nC := 0
		linaux := lin
		If !Empty(AllTrim(QK2->QK2_TOL))
			oPrint:Say(lin,0625,"NOM: "+QK2->QK2_TOL,oFontCou08) // "NOM: "
		EndIf
		If !Empty(AllTrim(QK2->QK2_LIE))
			lin += 40        
			nC += 1
			oPrint:Say(lin,0625,"LIE: "+Alltrim(QK2->QK2_LIE),oFontCou08) // "LIE: "
		EndIf
		If !Empty(AllTrim(QK2->QK2_LSE))
			lin += 40
			nC += 1
			oPrint:Say(lin,0625,"LSE: "+Alltrim(QK2->QK2_LSE),oFontCou08) // "LSE: "
		EndIf
	    If Len(aTxtDesc) <= 2
			If Len(aTxtDesc) > 0
			    lin := linaux
			    For nC := 1 to Len(aTxtDesc)
			    	oPrint:Say(lin,140,aTxtDesc[nC],oFontCou08)
			    	lin += 40
		    		If lin > 2580		
						i++
						Foot181(oPrint)			// Funcao que monta o rodape
						oPrint:EndPage() 		// Finaliza a pagina
						Cabec181(oPrint,i,lBrow)  			// Funcao que monta o cabecalho 
						lin := 590
					EndIf
			    Next				
			EndIf
        Else
		    lin := linaux
		    For nC := 1 to Len(aTxtDesc)
		    	oPrint:Say(lin,140,aTxtDesc[nC],oFontCou08)
		    	lin += 40
		    Next
		EndIf              
		lin+=40
	Else
		If lBrow 
			If lImpCd
		    	lin += 40
				oPrint:Say(lin,140,cCdCar,oFontCou08)    	
			    If nEdicao > 3
			    	lin -= 40
			    EndIf
	        Endif
		Else
			If mv_par05 == 1
		    	lin += 40
				oPrint:Say(lin,140,cCdCar,oFontCou08)    			
			    If nEdicao > 3
			    	lin -= 40
			    EndIf
			Endif
		Endif        	
	
		lin += 40

	EndIf 
	
	DbSelectArea("QKB")
	DbSetOrder(1)

	DbSkip()

Enddo

If nEdicao == 3
	Foot180(oPrint)			// Funcao que monta o rodape
Else
	DbSelectArea("QKB")
	DbSkip(-1)
	Foot181(oPrint)			// Funcao que monta o rodape
EndIf


Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec180(oPrint,i,lBrow)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,750,STR0003,oFont16 ) //"Aprovacao de Peca de Producao"
oPrint:Say(090,750,STR0004,oFont16 ) //"   Resultados Dimensionais   "

oPrint:Say(171,30,STR0005,oFont08 ) //"PPAP No."
oPrint:Say(171,160,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,1800,STR0021,oFont08 ) //"Pagina :"
oPrint:Say(171,1950,StrZero(i,3),oFont08)

oPrint:Say(171,1300,STR0024,oFont08)	//"Sequencia :"
oPrint:Say(171,1500,QKB->QKB_SEQ,oFont08)

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

oPrint:Line( 390, 130, 2890, 130 )   	// vertical

oPrint:Line( 390, 1080, 2890, 1080 )   // vertical

oPrint:Line( 390, 1180, 2890, 1180 )   // vertical

oPrint:Line( 530, 1655, 2890, 1655 )   // vertical

oPrint:Line( 390, 2130, 2890, 2130 )   // vertical

oPrint:Line( 390, 2240, 2890, 2240 )   // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0006,oFont08 ) //"Fornecedor"
oPrint:Say(250,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1410,STR0007,oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(250,1410,Subs(QK1->QK1_PCCLI,1,26),oFontCou08)

oPrint:Say(210,1885,STR0008,oFont08 ) //"Revisao/Data Desenho"
oPrint:Say(250,1885,AllTrim(QK1->QK1_REVDES)+Space(01)+DtoC(QK1->QK1_DTRDES),oFontCou08)
                                                     
oPrint:Say(290,0040,STR0009,oFont08 ) //"Local da Inspecao"
oPrint:Say(330,0045,Subs(QKB->QKB_LINSP,1,35),oFontCou08)

oPrint:Say(290,0695,STR0010,oFont08 ) //"Numero/Rev Peca(Fornecedor)"
oPrint:Say(330,0695,AllTrim(Subs(QK1->QK1_PECA,1,36))+"/"+ QK1->QK1_REV,oFontCou08)

oPrint:Say(290,1410,STR0011,oFont08 ) //"Nome da Peca"
oPrint:Say(330,1410,Subs(QK1->QK1_DESC,1,50),oFontCou08)

// Descricao dos itens
oPrint:Say(445,0050,STR0012,oFont08 ) //"Item"
oPrint:Say(445,0430,STR0013,oFont08 ) //"Dimensao/Especificacao"
If lBrow 
	If lImpCd
		oPrint:Say(475,0455,OemToAnsi(STR0025),oFont08 ) //"Codigo/Descricao"
	Endif
Else
	If mv_par05 == 1
		oPrint:Say(475,0455,OemToAnsi(STR0025),oFont08 ) //"Codigo/Descricao"
	Endif
Endif
oPrint:Say(440,1090,STR0014,oFont08 )	//"Carac."
oPrint:Say(470,1090,STR0015,oFont08 ) //" Esp  "
oPrint:Say(470,1300,STR0006,oFont08 ) //"Fornecedor"
oPrint:Say(445,1494,STR0016,oFont08 )	//"Resultados das Medicoes" 
oPrint:Say(470,1775,STR0022,oFont08 ) //"Cliente"
oPrint:Say(445,2150,STR0017,oFont08 ) //"Ok"
oPrint:Say(445,2257,STR0018,oFont08 )	//"Nao"
oPrint:Say(470,2260,STR0017,oFont08 ) //"Ok"

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec181 ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 09.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Cabecalho do relatorio  PPAP 4 Edicao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec181(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±   
±±³          ³ ExpO2 = Linha                                              ³±±
±±³          ³ ExpO3 = Impressao via Browse                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec181(oPrint,i,lBrow)

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
oPrint:Say(171,500,STR0005,oFont08 )		//"PPAP No."
oPrint:Say(171,630,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,1800,STR0021,oFont08 ) 		//"Pagina :"
oPrint:Say(171,1950,StrZero(i,3),oFont08)

oPrint:Say(171,1375,STR0024,oFont08)	//"Sequencia :"
oPrint:Say(171,1575,QKB->QKB_SEQ,oFont08)

//Box Cabecalho
oPrint:Box( 210, 30, 450, 2350 )                                  

//Box Itens
oPrint:Box( 470, 30, 2890, 2350 )

// Construcao da Grade cabecalho
oPrint:Line( 290, 0030, 290, 1250 )   	// horizontal
                                                         
oPrint:Line( 210, 1250, 450, 1250 )   	// vertical
                                                 
// Construcao da Grade itens
oPrint:Line( 0610, 0030, 0610, 2350 )  	// horizontal

oPrint:Line( 0470, 0130, 2810, 0130 )	// vertical

oPrint:Line( 0470, 0610, 2810, 0610 )  // vertical

oPrint:Line( 0470, 0940, 2810, 0940 )  // vertical

oPrint:Line( 0470, 1140, 2810, 1140 )  // vertical

oPrint:Line( 0470, 1260, 2810, 1260 )  // vertical

oPrint:Line( 0610, 1700, 2810, 1700 )  // vertical

oPrint:Line( 0470, 2130, 2810, 2130 )  // vertical

oPrint:Line( 0470, 2240, 2810, 2240 )  // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0006+" :",oFont08 ) //"Fornecedor"
oPrint:Say(210,0200,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1260,STR0007+" :",oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(210,1610,Alltrim(Subs(QK1->QK1_PCCLI,1,26))+IIF(EMPTY(AllTrim(QK1->QK1_REVDES)),"","/"+AllTrim(QK1->QK1_REVDES)),oFontCou08)

oPrint:Say(250,0040,STR0028+" :",oFont08 ) // "Codigo Fornecedor/Vendedor"
oPrint:Say(250,0440,QK1->QK1_CODVCL,oFontCou08)    

oPrint:Say(250,1260,STR0011+" :",oFont08 ) //"Nome da Peca"
oPrint:Say(250,1475,Subs(QK1->QK1_DESC,1,50),oFontCou08)

oPrint:Say(290,0040,STR0029+" :",oFont08 ) //"Instrucoes de Inspecao"
cDesc := QKB->QKB_OBSERV
If Len(Alltrim(cDesc)) <= 50
	oPrint:Say(290,0380,Alltrim(cDesc),oFontCou08)
Else
	oPrint:Say(290,0380,Substr(cDesc,1,50),oFontCou08)
	oPrint:Say(310,0380,Substr(cDesc,51,50),oFontCou08)	
EndIf

oPrint:Say(290,1260,STR0030+" :",oFont08 ) //"Nivel de Alteracao do Projeto"
oPrint:Say(290,1660,IIF(QK1->QK1_NALPRJ == "1",STR0041,;
                         IIF(QK1->QK1_NALPRJ == "2",STR0042,;
                             IIF(QK1->QK1_NALPRJ = "3",STR0043," "))),oFontCou08)

oPrint:Say(330,1260,STR0031+" :",oFont08 ) //"Documentos Alterados pela Engenharia"
oPrint:Say(330,1780,Alltrim(QK1->QK1_ALTDOC),oFontCou08)

oPrint:Say(410,1260,STR0032+" :",oFont08 ) //"Data Desenho"
oPrint:Say(410,1475,DtoC(QK1->QK1_DTRDES),oFontCou08)  

oPrint:Line(0410,0030,0410,1250)   			// horizontal
oPrint:Say(410,0040,STR0009+" :",oFont08 ) //"Local da Inspecao"
oPrint:Say(410,0340,Subs(QKB->QKB_LINSP,1,35),oFontCou08)


// Descricao dos itens
oPrint:Say(525,0050,STR0012,oFont08 ) //"Item"
oPrint:Say(525,0230,STR0013,oFont08 ) //"Dimensao/Especificacao"
If lBrow 
	If lImpCd
		oPrint:Say(545,0255,OemToAnsi(STR0025),oFont08 ) //"Codigo/Descricao"
	Endif
Else
	If mv_par05 == 1
		oPrint:Say(545,0255,OemToAnsi(STR0025),oFont08 ) //"Codigo/Descricao"
	Endif
Endif

oPrint:Say(520,0705,STR0033,oFont08 )	//"Especificao"
oPrint:Say(550,0705,STR0034,oFont08 )	//"  Limites  "
oPrint:Say(520,0990,STR0047,oFont08 )	//" Data"
oPrint:Say(550,0988,STR0048,oFont08 )	//"Ensaio"
oPrint:Say(520,1165,STR0037,oFont08 )	//"  QTD  "
oPrint:Say(550,1165,STR0038,oFont08 )	//"  Ens. "
oPrint:Say(525,1550,STR0016,oFont08 )	//"Resultados das Medicoes"
oPrint:Say(550,1400,STR0006,oFont08 )	//"Fornecedor"
oPrint:Say(550,1850,STR0022,oFont08 )	//"Cliente"
oPrint:Say(525,2150,STR0017,oFont08 )	//"Ok"
oPrint:Say(525,2257,STR0018,oFont08 )	//"Nao"
oPrint:Say(550,2260,STR0017,oFont08 )	//"Ok"

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot180  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot180(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot180(oPrint)

//Box 
oPrint:Box( 2890, 030, 2970, 2350 )

oPrint:Line( 2890, 1080, 2970, 1080 )		// horizontal
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical

oPrint:Say(2900,0050,STR0023,oFont08 ) 		//"Assinatura do Cliente"

RestArea(aAreaQKB)

oPrint:Say(2900,1090,STR0019,oFont08 ) 		//"Assinatura do Fornecedor"
oPrint:Say(2940,1090,QKB->QKB_ASSFOR,oFontCou08)

oPrint:Say(2900,2140,STR0020,oFont08 ) 		//"Data"
oPrint:Say(2940,2140,DtoC(QKB->QKB_DTAPR),oFontCou08)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot181  ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 09.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot181(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot181(oPrint)

Local cAss 		:= ""
Local cCodFun 	:= ""
Local cCargo	:= ""
//Box 
oPrint:Box( 2810, 030, 2970, 2350 )

oPrint:Say(2820,0300,STR0044,oFont12) //"As indicacoes gerais de conformidade sao inaceitaveis para todos os resultados de teste."

oPrint:Line( 2890, 0030, 2890, 2350)	// horizontal   
oPrint:Line( 2890, 1080, 2970, 1080 )  	// vertical
oPrint:Line( 2890, 2130, 2970, 2130 )	// vertical

oPrint:Line( 2890, 0030, 2890, 2350)	// horizontal   
oPrint:Line( 2890, 1080, 2970, 1080 )  // vertical
oPrint:Line( 2890, 2130, 2970, 2130 )  // vertical

oPrint:Say(2900,0050,STR0045,oFont08 ) //"Assinatura
oPrint:Say(2935,0060,QKB->QKB_ASSFOR,oFontCou08)

cAss 	:= QKB->QKB_ASSFOR

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

oPrint:Say(2900,1090,STR0046,oFont08 )		//"Funcao
oPrint:Say(2935,1100,cCargo,oFontCou08)
oPrint:Say(2900,2140,STR0020,oFont08 )		//"Data"      
oPrint:Say(2935,2140,dDataApr,oFontCou08)

lin := 2980
oPrint:Say(lin,90,STR0040,oFont06)    	//"Marco"
lin +=20          
oPrint:Say(lin,90,"2006",oFont06)
lin -=12  
oPrint:Say(lin,200,"CFG-1003",oFont10) //"CFG-1003"

Return Nil
