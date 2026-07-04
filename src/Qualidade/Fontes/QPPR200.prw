/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR200.CH"
#INCLUDE "TOTVS.CH"
                
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR200  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 22.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Resultados dos Ensaios de Desempenho                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR200(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³03.08.01³      ³  Inclusao dos dados na moldura         ³±±
±±³ Robson Ramiro³14.10.02³      ³ Compatiblizacao das alteracoes efetuada³±±
±±³              ³        ³      ³ na 710, e impressao a partir da mBrowse³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR200(lBrow,cPecaAuto,cJPEG)
Local aArea		:= GetArea()
Local cFiltro	:= ""
Local cGrupo    := "PPR200" 
Local oPrint    := TMSPrinter():New(STR0001) //"Resultados dos Ensaios de Desempenho"

Private	lImpCar		:= .F.	 
Private aAreaQKC	:= {}
Private cCondW		:= "QKC->QKC_PECA+QKC->QKC_REV+QKC->QKC_SEQ == cPecaRev"
Private cPecaRev 	:= ""
Private cStartPath 	:= GetSrvProfString("Startpath","")
Private lPergunte   := .F.
Private nEdicao     := Val(GetMv("MV_QPPAPED",.T.,"3"))// Indica a Edicao do PPAP default 3 Edicao	

Default cJPEG       := "" 
Default cPecaAuto	:= ""
Default lBrow 		:= .F.

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//³ mv_par04				// Impr. Caracteristica?      			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA200"
		cPecaRev := Iif(!lBrow, M->QKC_PECA + M->QKC_REV + M->QKC_SEQ, QKC->QKC_PECA + QKC->QKC_REV + QKC->QKC_SEQ)
		If MsgYesNo(OemToAnsi(STR0028),OemToAnsi(STR0029)) //"Deseja Imprimir Descricao da Caracteristica ?"
			lImpCar := .T.		
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

DbSelectArea("QKC")
cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	aAreaQKC := GetArea()

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If (lPergunte .and. mv_par04 == 1) .or. !Empty(cPecaAuto)
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
	MsgAlert(OemToAnsi(STR0047),OemToAnsi(STR0046))	//Atenção ! ### Não há dados a serem impressos. Verifique os parâmetros !
Endif

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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 22.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Resultado dos Ensaios de Desempenho                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


Static Function MontaRel(oPrint)
Local axTextos := {} 
Local cCarac   := " "  
Local cConTst  := ""
Local cTxtAux  := ""
Local i 	   := 1
Local lin 	   := 0                  
Local linaux   := 0                  
Local nC       := 0

Private dDataApr   := Dtoc(QKC->QKC_DTAPR)
Private oFont06    := TFont():New("Arial",      06,06,,.F.,,,,.T.,.F.)
Private oFont08    := TFont():New("Arial",      08,08,,.F.,,,,.T.,.F.)
Private oFont10    := TFont():New("Arial",      10,10,,.F.,,,,.T.,.F.)
Private oFont12    := TFont():New("Arial",      12,12,,.F.,,,,.T.,.F.)
Private oFont16    := TFont():New("Arial",      16,16,,.F.,,,,.T.,.F.)   
Private oFontCou06 := TFont():New("Courier New",06,06,,.F.,,,,.T.,.F.)
Private oFontCou08 := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

If nEdicao == 3
	Cabec200(oPrint,i)  	// Funcao que monta o cabecalho
	lin := 540
Else
	Cabec201(oPrint,i)  	// Funcao que monta o cabecalho
	lin := 590
EndIf

DbSelectArea("QKC")

Do While !Eof() .and. xFilial("QKC") == QKC->QKC_FILIAL .and. &cCondW
        
	If lin > 2580
		i++
		If nEdicao == 3
			oPrint:EndPage() 		// Finaliza a pagina
			Cabec200(oPrint,i)  	// Funcao que monta o cabecalho
			lin := 540
		Else
			Foot201(oPrint)			// Funcao que monta o rodape
			oPrint:EndPage() 		// Finaliza a pagina				
			Cabec201(oPrint,i)  	// Funcao que monta o cabecalho
			lin := 590
		EndIf
	Endif
	
	lin += 40
	If nEdicao == 3
		oPrint:Say(lin,0040,QKC->QKC_CARAC,oFontCou08)
		oPrint:Say(lin,0340,Subs(QKC->QKC_DESC,1,42),oFontCou08)
		oPrint:Say(lin,0180,Subs(QKC->QKC_NREF,1,8),oFontCou08)
		oPrint:Say(lin,1090,Subs(QKC->QKC_FTEST,1,8),oFontCou08)	
		oPrint:Say(lin,1240,Subs(QKC->QKC_QTENS,1,8),oFontCou08)
	Else                                                            
		oPrint:Say(lin,0050,Subs(QKC->QKC_DESC,1,42),oFontCou08)
		oPrint:Say(lin,1545,Subs(QKC->QKC_QTENS,1,8),oFontCou08)
	EndIf
		
	Iif(QKC->QKC_FLOK == "1",	oPrint:Say(lin,2200,"X",oFontCou08),;
								oPrint:Say(lin,2300,"X",oFontCou08))

	If nEdicao == 3
		oPrint:Say(lin,1390,QKC->QKC_RESFOR,oFontCou08)
		oPrint:Say(lin,1785,QKC->QKC_RESCLI,oFontCou08)
	EndIf
	
	If nEdicao == 3	
		If (Len(AllTrim(QKC->QKC_DESC))>=43)
			lin += 40
			oPrint:Say(lin,0340,Subs(QKC->QKC_DESC,43,42),oFontCou08)
		EndIf          
	Else
		If (Len(AllTrim(QKC->QKC_DESC))>=43)
			lin += 40
			oPrint:Say(lin,0050,Subs(QKC->QKC_DESC,43,42),oFontCou08)
		EndIf          	
	Endif
	
	cCarac := U_PPR200CARAC(QKC->QKC_PECA,QKC->QKC_REV,QKC->QKC_CARAC)
	
	If !lPergunte
		If lImpCar
			lin +=40	
			If lin > 2780
				i++

				If nEdicao == 3
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec200(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 540
				Else
		   			Foot201(oPrint)			// Funcao que monta o rodape		
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec201(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 590
				EndIf

			Endif

			If nEdicao == 3
				oPrint:Say(480,0480,OemToAnsi(STR0030),oFont08 ) //"Descricao Caracteristica"
				fImpQuebra(cCarac, 43, oPrint, oFontCou08, lin, 0340)
			Else
				oPrint:Say(525,0050,OemToAnsi(STR0030),oFont08 ) //"Descricao Caracteristica"			
				fImpQuebra(cCarac, 43, oPrint, oFontCou08, lin, 0050)	
				lin -= 40
			EndIf

		Endif
	Else
		If mv_par04 == 1
			lin +=40	
			If lin > 2780
				i++
				If nEdicao == 3
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec200(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 540
				Else
					Foot201(oPrint)			// Funcao que monta o rodape
					oPrint:EndPage() 		// Finaliza a pagina
					Cabec201(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 590
				EndIf
			Endif
		
			If nEdicao == 3
				oPrint:Say(0480,0480,OemToAnsi(STR0030),oFont08 ) //"Descricao Caracteristica"
				fImpQuebra(cCarac, 43, oPrint, oFontCou08, lin, 0340) 
			Else
				oPrint:Say(0525,0050,OemToAnsi(STR0030),oFont08 ) //"Descricao Caracteristica"			
				fImpQuebra(cCarac, 43, oPrint, oFontCou08, lin, 0050)	
			    lin -= 40
			EndIf
		Endif	
	Endif

   	axTextos := {}
	cTxtAux :=  QO_Rectxt(QK2->QK2_CHAVE,"QPPA010 ",1,27,"QKO",axTextos)
	cConTst :=  Iif(!Empty(AllTrim(QKC->QKC_RESFOR)),;
				    STR0007+": "+CHR(13)+CHR(10)+QKC->QKC_RESFOR+;
				    Iif(!Empty(AllTrim(cTxtAux)),CHR(13)+CHR(10)+CHR(13)+CHR(10)," ")," ")+; 
					Iif(!Empty(AllTrim(cTxtAux)),cTxtAux," ")+;
					Iif(!Empty(AllTrim(QKC->QKC_RESCLI)),;
	                IIf(Empty(AllTrim(cTxtAux)),STR0025+": "+CHR(13)+CHR(10)+QKC->QKC_RESCLI,;
	                                             CHR(13)+CHR(10)+CHR(13)+CHR(10)+STR0025+": "+CHR(13)+CHR(10)+QKC->QKC_RESCLI)," ") 
   	axTextos := {}
	axTextos := JustificaTXT(cConTst,27,.T.,.F.) // Limpa o Texto/Justifica 
	U_PPR200VARR(@axTextos) // Valida o Texto
		
    nC := 0
    If nEdicao > 3
		If !Empty(AllTrim(QK2->QK2_TOL))
			oPrint:Say(lin,1095,"NOM: "+QK2->QK2_TOL,oFontCou08) // "NOM: "
		EndIf
		If !Empty(AllTrim(QK2->QK2_LIE))
			lin += 40
			oPrint:Say(lin,1095,"LIE: "+Alltrim(QK2->QK2_LIE),oFontCou08) // "LIE: "
			nC ++
		EndIf
		If !Empty(AllTrim(QK2->QK2_LSE))
			lin += 40
			oPrint:Say(lin,1095,"LSE: "+Alltrim(QK2->QK2_LSE),oFontCou08) // "LSE: "
			nC ++
		EndIf

		If Len(axTextos) >= 1		
	    	If Len(axTextos) >= 3
		    	lin := lin - ((nC+1)*40) // Volto 1 ou 2 linhas
		    Else 
		    	linaux := lin
		    EndIf
			For nC := 1 To Len(axTextos)
				lin += 40   
				If lin > 2780
					Foot201(oPrint)	
					i++
					oPrint:EndPage() 
					Cabec201(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 590
                EndIf
				oPrint:Say(lin,1700,axTextos[nC],oFontCou08)		
		    Next
		    
		  	If linaux > lin
				lin := linaux
			  	linaux := 0
		  	EndIf
		    
		EndIf
			
		If Empty(AllTrim(QK2->QK2_TOL))	 .AND. Empty(AllTrim(QK2->QK2_LIE)) .AND.;
		   Empty(AllTrim(QK2->QK2_LSE))
			lin += 40 // Volto a linha que  estava quando foi impressa a caracteristica			
		EndIf 	

	EndIf

	lin += 40 

	DbSelectArea("QKC")
	DbSetOrder(1)

	DbSkip()

Enddo

If nEdicao == 3
	Foot200(oPrint)			// Funcao que monta o rodape
Else          
	DbSelectArea("QKC")
	DbSkip(-1)
	Foot201(oPrint)			// Funcao que monta o rodape
EndIf

oPrint:EndPage() 

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec200 ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 22.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec200(ExpO1,ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec200(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,650,STR0003,oFont16 ) //"      Aprovacao de Peca de Producao"
oPrint:Say(090,650,STR0001,oFont16 ) //"Resultados dos Ensaios de Desempenho"

oPrint:Say(171,30,STR0005,oFont08 ) //"PPAP No."
oPrint:Say(171,160,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,1800,STR0006,oFont08 )  //"Pagina :"
oPrint:Say(171,1950,StrZero(i,3),oFont08)

oPrint:Say(171,1300,STR0027,oFont08)  // "Sequencia :"
oPrint:Say(171,1500,QKC->QKC_SEQ,oFont08)

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

oPrint:Line( 390, 170, 2890, 170 )   	// vertical

oPrint:Line( 390, 330, 2890, 330 )   	// vertical

oPrint:Line( 390, 1080, 2890, 1080 )   // vertical

oPrint:Line( 390, 1230, 2890, 1230 )   // vertical

oPrint:Line( 390, 1380, 2890, 1380 )   // vertical

oPrint:Line( 530, 1775, 2890, 1775 )   // vertical

oPrint:Line( 390, 2170, 2890, 2170 )   // vertical

oPrint:Line( 390, 2260, 2890, 2260 )   // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0007,oFont08 ) //"Fornecedor"
oPrint:Say(250,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1410,STR0008,oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(250,1410,Subs(QK1->QK1_PCCLI,1,26),oFontCou08)

oPrint:Say(210,1885,STR0009,oFont08 ) //"Revisao/Data Desenho"
oPrint:Say(250,1885,AllTrim(QK1->QK1_REVDES)+Space(01)+DtoC(QK1->QK1_DTRDES),oFontCou08)
                                                     
oPrint:Say(290,0040,STR0010,oFont08 ) //"Laboratorio"
oPrint:Say(330,0045,Subs(QKC->QKC_LABOR,1,35),oFontCou08)

oPrint:Say(290,0695,STR0011,oFont08 ) //"Numero/Rev Peca(Fornecedor)"
oPrint:Say(330,0695,AllTrim(Subs(QK1->QK1_PECA,1,36))+"/"+ QK1->QK1_REV,oFontCou08)

oPrint:Say(290,1410,STR0012,oFont08 ) //"Nome da Peca"
oPrint:Say(330,1410,Subs(QK1->QK1_DESC,1,50),oFontCou08)

// Descricao dos itens
oPrint:Say(445,0060,STR0013,oFont08 ) //"No. Car."
oPrint:Say(445,0200,STR0014,oFont08 ) //"No. Ref."
oPrint:Say(445,0480,STR0015,oFont08 ) //"Requisitos"    
oPrint:Say(420,1120,STR0016,oFont08 ) //"Freq"
oPrint:Say(455,1120,STR0017,oFont08 ) //"Teste"
oPrint:Say(420,1270,STR0018,oFont08 ) //"Qtde"
oPrint:Say(455,1270,STR0019,oFont08 ) //"Ens"
oPrint:Say(455,1500,STR0007,oFont08 ) //"Fornecedor"
oPrint:Say(420,1650,STR0020,oFont08 ) //"Resultados dos Ensaios"
oPrint:Say(455,1925,STR0025,oFont08 ) //"Cliente"
oPrint:Say(445,2200,STR0021,oFont08 ) //"Ok"
oPrint:Say(420,2290,STR0022,oFont08 ) //"Nao"
oPrint:Say(470,2290,STR0021,oFont08 ) //"Ok"

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec201 ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 13.11.06 ³±±
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
Static Function Cabec201(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,650,STR0003,oFont16 ) //"      Aprovacao de Peca de Producao"
oPrint:Say(090,650,STR0001,oFont16 ) //"Resultados dos Ensaios de Desempenho"

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

oPrint:Say(171,500,STR0005,oFont08 ) //"PPAP No."
oPrint:Say(171,630,QK1->QK1_PPAP,oFont08)

oPrint:Say(171,1800,STR0006,oFont08 ) //"Pagina :"
oPrint:Say(171,1950,StrZero(i,3),oFont08)

oPrint:Say(171,1375,STR0027,oFont08)	//"Sequencia :"
oPrint:Say(171,1575,QKC->QKC_SEQ,oFont08)

//Box Cabecalho
oPrint:Box( 210, 30, 450, 2350 ) 

//Box Itens
oPrint:Box( 470, 30, 2890, 2350 )

// Construcao da Grade cabecalho
oPrint:Line( 290, 0030, 290, 1250 )   	// horizontal
                                                         
oPrint:Line( 210, 1250, 450, 1250 )   	// vertical

// Construcao da Grade itens
oPrint:Line( 580, 0030, 580, 2350 )   	// horizontal

oPrint:Line( 0470, 1080, 2810, 1080 )   // vertical

oPrint:Line( 0470, 1340, 2810, 1340 )   // vertical

oPrint:Line( 0470, 1535, 2810, 1535 )   // vertical

oPrint:Line( 0470, 1690, 2810, 1690 )   // vertical

oPrint:Line( 0470, 2170, 2810, 2170 )   // vertical

oPrint:Line( 0470, 2260, 2810, 2260 )   // vertical

// Descricao do Cabecalho
oPrint:Say(210,0040,STR0007+" :",oFont08 ) //"Fornecedor"
oPrint:Say(210,0200,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(210,1260,STR0008+" :",oFont08 ) //"Numero da Peca(Cliente)"
oPrint:Say(210,1610,Alltrim(Subs(QK1->QK1_PCCLI,1,26))+IIF(EMPTY(AllTrim(QK1->QK1_REVDES)),"","/"+AllTrim(QK1->QK1_REVDES)),oFontCou08)

oPrint:Say(250,0040,STR0031+" :",oFont08 ) // "Codigo Fornecedor/Vendedor"
oPrint:Say(250,0440,QK1->QK1_CODVCL,oFontCou08)    

oPrint:Say(250,1260,STR0012+" :",oFont08 ) //"Nome da Peca"
oPrint:Say(250,1475,Subs(QK1->QK1_DESC,1,50),oFontCou08)

oPrint:Say(0290,0040,STR0010+" :",oFont08 )     //"Laboratorio"
oPrint:Say(0290,0200,Subs(QKC->QKC_LABOR,1,35),oFontCou08)

oPrint:Say(290,1260,STR0032+" :",oFont08 ) //"Nivel de Alteracao do Projeto"
oPrint:Say(290,1660,IIF(QK1->QK1_NALPRJ == "1",STR0033,;   //"Alto"
                         IIF(QK1->QK1_NALPRJ == "2",STR0034,;   //"Medio"
                             IIF(QK1->QK1_NALPRJ = "3",STR0035," "))),oFontCou08) //"Baixo"

oPrint:Say(330,1260,STR0036+" :",oFont08 ) //"Documentos Alterados pela Engenharia"
oPrint:Say(330,1780,Alltrim(QK1->QK1_ALTDOC),oFontCou08)

oPrint:Say(410,1260,STR0037+" :",oFont08 ) //"Data Desenho"
oPrint:Say(410,1475,DtoC(QK1->QK1_DTRDES),oFontCou08)

// Descricao dos itens
oPrint:Say(495,0050,STR0015,oFont08 ) //"Requisitos"
oPrint:Say(495,1135,STR0038,oFont08 ) //"Especificao"
oPrint:Say(525,1135,STR0039,oFont08 ) //"  Limites  "
oPrint:Say(495,1400,STR0024,oFont08 ) //"Data"
oPrint:Say(525,1400,STR0045,oFont08 ) //"Ensaio"
oPrint:Say(495,1580,STR0018,oFont08 ) //"Qtde"
oPrint:Say(525,1580,STR0019,oFont08 ) //"Ens"
oPrint:Say(495,1775,STR0020,oFont08 ) //"Resultados dos Ensaios"  
oPrint:Say(525,1775,STR0040,oFont08 ) //"Condicoes de Teste"
oPrint:Say(515,2200,STR0021,oFont08 ) //"Ok"
oPrint:Say(495,2290,STR0022,oFont08 ) //"Nao"
oPrint:Say(525,2290,STR0021,oFont08 ) //"Ok"

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot200  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 22.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot(ExpO1,ExpN1, ExpN2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot200(oPrint)

//Box 
oPrint:Box( 2890, 030, 2970, 2350 )

oPrint:Line( 2890, 1080, 2970, 1080 )		// horizontal
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical

oPrint:Say(2900,0050,STR0026,oFont08 ) //"Assinatura do Cliente"

RestArea(aAreaQKC)

oPrint:Say(2900,1090,STR0023,oFont08 ) //"Assinatura do Fornecedor"
oPrint:Say(2940,1090,QKC->QKC_ASSFOR,oFontCou08)

oPrint:Say(2900,2140,STR0024,oFont08 ) //"Data"
oPrint:Say(2940,2140,dDataApr,oFontCou08)

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot201  ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 14.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot201(ExpO1,Exp02)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint / Exp02 = Data da Aprovacao          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR180                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot201(oPrint)    

Local cAss 		:= ""
Local cCodFun 	:= ""
Local cCargo	:= ""
//Box 
oPrint:Box( 2810, 030, 2970, 2350 )

oPrint:Say(2820,0300,STR0041,oFont12) //"As indicacoes gerais de conformidade sao inaceitaveis para todos os resultados de teste."

oPrint:Line( 2890, 0030, 2890, 2350)		// horizontal   
oPrint:Line( 2890, 1080, 2970, 1080 )   	// vertical
oPrint:Line( 2890, 2130, 2970, 2130 )   	// vertical
oPrint:Say(2900,0050,STR0043,oFont08 ) 		//"Assinatura
oPrint:Say(2940,0200,QKC->QKC_ASSFOR,oFontCou08) 
cAss 	:= QKC->QKC_ASSFOR           

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

oPrint:Say(2900,1090,STR0044,oFont08 ) //"Funcao 
oPrint:Say(2935,1100,cCargo,oFontCou08)
oPrint:Say(2900,2140,STR0024,oFont08 ) //"Data"      
oPrint:Say(2940,2140,dDataApr,oFontCou08)   

lin := 2980
oPrint:Say(lin,90,STR0042,oFont06)    //"Marco"
lin +=20          
oPrint:Say(lin,90,"2006",oFont06)
lin -=12  
oPrint:Say(lin,200,"CFG-1005",oFont10)   //"CFG-1004"

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³          ºAutor  ³ Cicero Odilio Cruz º Data ³  23/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a caracteristica a ser impressa                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PPAP                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PPR200CARAC(cPeca,cRev,cCarac)
Local aArea := GetArea()
Local cRes  := " "

DbSelectArea("QK2")
DbSetOrder(2)
If DbSeek(xFilial("QK2")+cPeca+cRev+cCarac)
	cRes  := ALLTRIM(QK2->QK2_DESC) +" / "+ ALLTRIM(QK2->QK2_ESPE) +" / "+ ALLTRIM(QK2->QK2_UM)
EndIf

RestArea(aArea)
Return cRes                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PPR200VARRºAutor  ³ Cicero Odilio Cruz º Data ³  14/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a caracteristica a ser impressa                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PPAP                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PPR200VARR(axTextos)
Local aTexto 	:= aClone(axTextos)
Local xQuebra   := CHR(13)+CHR(10)
Local nC 		:= 0
Local cLinha 	:= ""
Local cTexto 	:= ""

axTextos := {}
For nC := 1 to Len(aTexto)
	cTexto := aTexto[nC]
	nQuebra := At(xQuebra,cTexto)
	While nQuebra > 0
		cLinha := SubStr(cTexto,1,nQuebra-1)
		Aadd(axTextos,cLinha)
		cTexto := Stuff(cTexto,1,nQuebra+1,"")
		nQuebra := At(xQuebra,cTexto)
	EndDo 
	If nQuebra == 0 .AND. Len(cTexto) > 0
		Aadd(axTextos,cTexto)	
	EndIf
Next

Return 


/*/{Protheus.doc} fImpQuebra
	screve textos de acordo com o tamanho definido para quebra de linhas.
	@type  Static Function
	@author rafael.kleestadt
	@since 14/11/2022
	@version 1.0
	@param cCaracter, caracter, texto a ser impresso
	@param nQuebra, numeric, tamanho maxímo do texto para quebra de linha
	@param oObjPrint, object, objeto da classe TMSPrinter
	@param oFont, object, objeto da classe TFont
	@param nLin, numeric, linha onde será iniciada a escrita do cCaracter
	@param nCol, numeric, coluna onde será iniciada a escrita do cCaracter
	@return nLin, numeric, linha onde deve iniciar a impressão do próximo texto 
	@example
	(examples)
	@see (links_or_references)
/*/
Static Function fImpQuebra(cCaracter, nQuebra, oObjPrint, oFont, nLin, nCol)
	Local cTextoImp := AllTrim(cCaracter)
	Local nX        := 0

	For nX := 1 To Len(cTextoImp)
		If Len(cTextoImp) == nQuebra
			oObjPrint:Say(nLin, nCol, cTextoImp, oFont)
			Return
		Endif

		oObjPrint:Say(nLin, nCol, Subs(cTextoImp, nX, nQuebra), oFont)
		nX   += nQuebra - 1
		nLin += 40
	Next nX
	
Return nLin
