/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR120.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR120  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Projeto                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR120(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³10.09.01³      ³  Inclusao dos dados na moldura         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR120(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.

Private cPecaRev 	:= ""
Private cStartPath 	:= GetSrvProfString("Startpath","")
Private	lQLGREL		:= GetMv("MV_QLGREL")

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"FMEA de Projeto"

oPrint:SetLandscape()

If GetMV("MV_QVEFMEA",.T.,"3") == "4" //FMEA 4a. EDICAO...
	QPPR370(@oPrint,lBrow,cPecaAuto,cJPEG,lPergunte)
Else
	If Empty(cPecaAuto)
		If AllTrim(FunName()) == "QPPA120"  .or. AllTrim(FunName()) == "QPPA121"
			cPecaRev := Iif(!lBrow, M->QK5_PECA + M->QK5_REV, QK5->QK5_PECA + QK5->QK5_REV)
		Else
			lPergunte := Pergunte("PPR180",.T.)
	
			If lPergunte
				cPecaRev := mv_par01 + mv_par02	
			Else
				Return Nil
			Endif
		Endif
	Endif
	
	DbSelectArea("QK1")
	DbSetOrder(1)
	DbSeek(xFilial()+cPecaRev)
	
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1") + QK1->QK1_CODCLI + QK1->QK1_LOJCLI)
	
	DbSelectArea("QK5") 
	DbSetOrder(1)
	If DbSeek(xFilial()+cPecaRev)
	
		If Empty(cPecaAuto)
			MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
		Else
			MontaRel(oPrint)
		Endif
	
		If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
			If !Empty(cJPEG)
				oPrint:SaveAllAsJPEG(cStartPath+cJPEG,1120,840,140)
			Else 
				oPrint:Print()
			EndIF
		Else
			oPrint:Preview()  		// Visualiza antes de imprimir
		Endif
	Endif
Endif
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Projeto                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i 	    := 1, nCont := 0
Local x 	    := 0, lin, nPos, nxCont := 0,nLinha := 0
Local aTxt, nx
Local cItem		:= ""
Local cItemAnt	:= ""
Local nNPRMAX	:= GetMv("MV_NPRMAX")
Local axTextos  := {} 
Local lPrazo    
Local xQuebra   := chr(13)+chr(10)
Local cxTextos  := ""

Private oFont16, oFont08, oFont10, oFontCou07,oFontCou08, oFontNPR

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
oFontCou07	:= TFont():New("Courier New",07,07,,.F.,,,,.T.,.F.)
oFontNPR	:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
lin := 790

DbSelectArea("QK6")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QK6->QK6_PECA+QK6->QK6_REV == cPecaRev

	nCont++ 

	aTxt := {}	// Array que armazena os campos memos

	lin += 40

	lPrazo:= .T.
	If lin > 2240
		nCont := 1
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 790
		lin += 40
	Endif

	oPrint:Say(lin,0995,QK6->QK6_SEVER,oFontCou07)

	PPAPBMP(QK6->QK6_CLASS+".BMP", cStartPath)
	oPrint:SayBitmap(lin,1029, QK6->QK6_CLASS+".BMP",40,40)

	oPrint:Say(lin,1395,QK6->QK6_OCORR,oFontCou07)
	oPrint:Say(lin,1755,QK6->QK6_DETEC,oFontCou07)

	If Val(QK6->QK6_NPR) >= nNPRMAX
		oPrint:Say(lin,1795,QK6->QK6_NPR,oFontNPR)
	Else
		oPrint:Say(lin,1795,QK6->QK6_NPR,oFontCou07)
	Endif
	oPrint:Say(lin,2815,QK6->QK6_RSEVER,oFontCou07)
	oPrint:Say(lin,2855,QK6->QK6_ROCORR,oFontCou07)
	oPrint:Say(lin,2895,QK6->QK6_RDETEC,oFontCou07)

	If Val(QK6->QK6_RNPR) >= nNPRMAX
		oPrint:Say(lin,2931,QK6->QK6_RNPR,oFontNPR)
	Else
		oPrint:Say(lin,2931,QK6->QK6_RNPR,oFontCou07)
	Endif

	If !Empty(QK6->QK6_CHAVE1)
        
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120A",1,17,"QKO",axTextos)
		cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
		axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
		
       nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If !Empty(QKO->QKO_TEXTO)

				If Len(aTxt) <> 0
					nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
				Else
					nPos := 0
				Endif

				If nPos == 0
					aAdd( aTxt,{	STRZERO(nLinha,3), axTextos[nxCont], Space(17), Space(17),;
										Space(17), Space(8), Space(8), Space(17), Space(17), Space(17) })
      			Else
					aTxt[nPos,2] := axTextos[nxCont]
      			Endif
			Endif
            nLinha++ 
        Next
        
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120B",1,17,"QKO",axTextos)
		cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
		axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
       nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), axTextos[nxCont], Space(17),;
		                   Space(17), Space(8), Space(8), Space(17), Space(17), Space(17) })
      		Else
		   		aTxt[nPos,3] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next


		DbSelectArea("QKO")
		DbSetOrder(1)

		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120C",1,17,"QKO",axTextos)
		cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
		axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
       nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), axTextos[nxCont],;
								Space(17), Space(8), Space(8), Space(17), Space(17), Space(17) })
      		Else
		   		aTxt[nPos,4] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120D",1,17,"QKO",axTextos)
		cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
		axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								axTextos[nxCont], Space(8), Space(8), Space(17), Space(17), Space(17) })
      		Else
		   		aTxt[nPos,5] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		axTextos := {}     
		//Recupera texto da chave  

			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120E",1,8,"QKO",axTextos)
			cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 8)
			axTextos := JustificaTXT(cxTextos,8,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(17), axTextos[nxCont], Space(8), Space(17), Space(17), Space(17) })
      		Else
		   		aTxt[nPos,6] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next            
        
		axTextos := {}     
		//Recupera texto da chave  
			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120H",1,8,"QKO",axTextos)
			cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 8)
			axTextos := JustificaTXT(cxTextos,8,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17), Space(17),;
								Space(8),axTextos[nxCont], Space(17), Space(17), Space(17) })
      		Else
		   		aTxt[nPos,7] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next 

		axTextos := {}     
		//Recupera texto da chave  
			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120F",1,17,"QKO",axTextos)
			cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
			axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(17), Space(8), Space(8), axTextos[nxCont], Space(17), Space(17) })
      		Else
		   		aTxt[nPos,8] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next 
        

		axTextos := {}     
		//Recupera texto da chave  
			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120G",1,17,"QKO",axTextos)
			cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
			axTextos := JustificaTXT(cxTextos,17,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(17), Space(8), Space(8), Space(17), axTextos[nxCont], Space(17)})
      		Else
		   		aTxt[nPos,9] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

        axTextos := {}     

		//Recupera texto da chave
		cxTextos := QK6->QK6_RESP						
		cxTextos := QADIVFRA( U_QExclEnter(cxTextos), 17)
		axTextos := JustificaTXT(cxTextos,17,.F.,.T.)
		aAdd(axTextos,DtoC(QK6->QK6_PRAZO))	 // Acrescenta a data PRAZO na ultima linha desta coluna  
	    nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If !Empty(QK6->QK6_RESP)
	
				If Len(aTxt) <> 0
					nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
				Else
					nPos := 0
				Endif
	
	      		If nPos == 0  
					aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(12), Space(10), Space(8), Space(17), Space(17), axTextos[nxCont] })
	   			Else
		   			aTxt[nPos,10] := axTextos[nxCont]
	   			Endif
			Endif
	        nLinha++ 
		Next   
	Endif

	If Len(aTxt) > 0
		cItem := aTxt[1,2]
	Endif

	If nCont > 1
		If Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
		Elseif !Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
		Endif
	Endif

	If Len(aTxt) > 0
		For nx := 1 To Len(aTxt)
			oPrint:Say(lin,0050,aTxt[nx,2],oFontCou07)
			oPrint:Say(lin,0360,aTxt[nx,3],oFontCou07)
			oPrint:Say(lin,0680,aTxt[nx,4],oFontCou07)
			oPrint:Say(lin,1080,aTxt[nx,5],oFontCou07)
			oPrint:Say(lin,1440,aTxt[nx,6],oFontCou07)
			oPrint:Say(lin,1600,aTxt[nx,7],oFontCou07)
			oPrint:Say(lin,1880,aTxt[nx,8],oFontCou07)
			oPrint:Say(lin,2510,aTxt[nx,9],oFontCou07)
			oPrint:Say(lin,2195,aTxt[nx,10],oFontCou07)
			
			lin += 40

			If lin > 2240
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
				lin := 790
				lin += 40
			Endif

		Next nx
	Else
		oPrint:Say(lin,2195,DtoC(QK6->QK6_PRAZO),oFontCou07)	
	Endif

	If Len(aTxt) > 0
		cItemAnt := cItem
	Endif

	DbSelectArea("QK6")
	DbSkip()

	If Len(aTxt) == 0
		lin += 40
	EndIf
Enddo

lin += 40        
oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Projeto                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local cLogoPad
Local nWeight, nWidth

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

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

If lQLGREL
	PPAPBMP(cLogoPad, cStartPath)
	oPrint:SayBitmap(80,0080, cLogoPad,nWeight,nWidth)
Endif

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1400,STR0001,oFont16 ) //"FMEA DE PROJETO"

// Box Cabecalho
oPrint:Box( 160, 30, 560, 3000 )

// Construcao da Grade
oPrint:Line( 240, 30, 240, 3000 )   	// horizontal
oPrint:Line( 320, 30, 320, 3000 )   	// horizontal
oPrint:Line( 400, 30, 400, 3000 )   	// horizontal
oPrint:Line( 480, 30, 480, 3000 )   	// horizontal

oPrint:Line( 160, 1020, 400, 1020 )   	// vertical
oPrint:Line( 160, 0610, 240, 0610 )   	// vertical

oPrint:Line( 160, 2010, 560, 2010 )   	// vertical
oPrint:Line( 160, 2800, 240, 2800 )   	// vertical
                                                   
oPrint:Line( 400, 2800, 560, 2800 )   	// vertical

oPrint:Line( 480, 2405, 560, 2405 )   	// vertical

// Descricao cabecalho
oPrint:Say(170,0040,STR0003,oFont08) //"Numero da Peca(Cliente)"
oPrint:Say(200,0040,Subs(QK1->QK1_PCCLI,1,40),oFontCou08)

oPrint:Say(170,0620,STR0004,oFont08) //"Rev/Data do Desenho"
oPrint:Say(200,0620,AllTrim(QK1->QK1_REVDES)+" "+DtoC(QK1->QK1_DTRDES),oFontCou08)

oPrint:Say(170,1030,STR0005,oFont08) //"Nome da Peca"
oPrint:Say(200,1030,Subs(QK1->QK1_DESC,1,50),oFontCou08)

oPrint:Say(170,2020,STR0006,oFont08) //"Numero da FMEA"
oPrint:Say(200,2020,QK5->QK5_FMEA,oFontCou08)

oPrint:Say(170,2810,STR0007,oFont08) //"Pagina"
oPrint:Say(200,2810,StrZero(i,3),oFontCou08)

oPrint:Say(250,0040,STR0008,oFont08) //"Preparado Por"
oPrint:Say(280,0040,QK5->QK5_PREPOR,oFontCou08)

oPrint:Say(250,1030,STR0009,oFont08) //"Responsavel pelo Projeto"
oPrint:Say(280,1030,QK5->QK5_RESPON,oFontCou08)

oPrint:Say(250,2020,STR0010,oFont08)       //"Cliente"
oPrint:Say(280,2020,SA1->A1_NOME,oFontCou08)

oPrint:Say(330,0040,STR0011,oFont08) //"Fornecedor"
oPrint:Say(360,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(330,1030,STR0012,oFont08) //"Identificacao do Produto"
oPrint:Say(360,1030,QK5->QK5_IDPROD,oFontCou08)

oPrint:Say(330,2020,STR0013,oFont08) //"Numero/Rev Peca(Fornecedor)"
oPrint:Say(360,2020,AllTrim(QK5->QK5_PECA)+" "+QK5->QK5_REV,oFontCou08)

oPrint:Say(410,0040,STR0014,oFont08) //"Equipe"
oPrint:Say(440,0040,QK5->QK5_EQUIPE,oFontCou08)

oPrint:Say(410,2020,STR0015,oFont08) //"Aprovado Por"
oPrint:Say(440,2020,QK5->QK5_APRPOR,oFontCou08)

oPrint:Say(410,2810,STR0016,oFont08) //"Data"
oPrint:Say(440,2810,DtoC(QK5->QK5_DATA),oFontCou08)
                                    
oPrint:Say(490,0040,STR0017,oFont08) //"Observacoes"
If Len(AllTrim(QK5->QK5_OBS)) <=100
	oPrint:Say(520,0040,QK5->QK5_OBS,oFontCou08)
Else
	oPrint:Say(490,0230,SubStr(QK5->QK5_OBS,1,100),oFontCou08)
	oPrint:Say(520,0040,SubStr(QK5->QK5_OBS,101),oFontCou08)
Endif

oPrint:Say(490,2020,STR0018,oFont08) //"Data Inicio"
oPrint:Say(520,2020,DtoC(QK5->QK5_DTINI),oFontCou08)

oPrint:Say(490,2415,STR0019,oFont08) //"Data Rev"
oPrint:Say(520,2415,DtoC(QK5->QK5_DTREV),oFontCou08)

oPrint:Say(490,2810,STR0020,oFont08) //"Data Chave"
oPrint:Say(520,2810,DtoC(QK5->QK5_DTCHAV),oFontCou08)

// Box itens
oPrint:Box( 580, 30, 2260, 3000 )
oPrint:Line( 820, 30, 820, 3000 )   	// horizontal

// Construcao da grade itens
oPrint:Line( 580, 0350, 2260, 0350 )   	// vertical
oPrint:Line( 580, 0670, 2260, 0670 )   	// vertical

oPrint:Line( 580, 0990, 2260, 0990 )   	// vertical
oPrint:Line( 580, 1025, 2260, 1025 )   	// vertical
oPrint:Line( 580, 1070, 2260, 1070 )   	// vertical
                                                   
oPrint:Line( 580, 1390, 2260, 1390 )   	// vertical
oPrint:Line( 580, 1430, 2260, 1430 )   	// vertical
oPrint:Line( 580, 1590, 2260, 1590 )   	// vertical

oPrint:Line( 580, 1750, 2260, 1750 )   	// vertical
oPrint:Line( 580, 1790, 2260, 1790 )   	// vertical
oPrint:Line( 580, 1870, 2260, 1870 )   	// vertical
                                                   
oPrint:Line( 580, 2190, 2260, 2190 )   	// vertical
oPrint:Line( 580, 2490, 2260, 2490 )   	// vertical
                                                   
oPrint:Line( 630, 2490, 0630, 3000 )   	// horizontal
oPrint:Line( 630, 2810, 2260, 2810 )   	// vertical
oPrint:Line( 630, 2850, 2260, 2850 )   	// vertical
oPrint:Line( 630, 2890, 2260, 2890 )   	// vertical
oPrint:Line( 630, 2930, 2260, 2930 )   	// vertical

// Descricao itens
oPrint:Say(660,100,STR0021,oFont08) //" Item "
oPrint:Say(700,100,STR0022,oFont08) //"Funcao"

oPrint:Say(640,400,STR0023,oFont08) //"Modo de  "
oPrint:Say(680,400,STR0024,oFont08) //" Falha   "
oPrint:Say(720,400,STR0025,oFont08) //"Potencial"

oPrint:Say(640,720,STR0026,oFont08) //" Efeito  "
oPrint:Say(680,720,STR0025,oFont08) //"Potencial"
oPrint:Say(720,720,STR0027,oFont08) //"da Falha "

oPrint:Say(620,997,STR0040,oFont08) // "S"
oPrint:Say(645,997,STR0041,oFont08) // "E"
oPrint:Say(670,997,STR0042,oFont08) // "V"
oPrint:Say(695,997,STR0043,oFont08) // "E"
oPrint:Say(720,997,STR0044,oFont08) // "R"

oPrint:Say(620,1034,STR0058,oFont08) // "C"
oPrint:Say(645,1034,STR0059,oFont08) // "L"
oPrint:Say(670,1034,STR0060,oFont08) // "A" 
oPrint:Say(695,1034,STR0061,oFont08) // "S"
oPrint:Say(720,1034,STR0062,oFont08) // "S"

oPrint:Say(640,1100,STR0028,oFont08) //"Causa / Mecanismo"
oPrint:Say(680,1100,STR0029,oFont08) //"    Potencial    "
oPrint:Say(720,1100,STR0030,oFont08) //"     da Falha    "

oPrint:Say(620,1395,STR0045,oFont08) // "O"
oPrint:Say(645,1395,STR0046,oFont08) // "C"
oPrint:Say(670,1395,STR0047,oFont08) // "O"
oPrint:Say(695,1395,STR0048,oFont08) // "R"
oPrint:Say(720,1395,STR0049,oFont08) // "R"

oPrint:Say(640,1450,STR0031,oFont08) //"Controles"
oPrint:Say(680,1450,STR0032,oFont08) //"Atuais do"
oPrint:Say(720,1450,STR0033,oFont08) //" Projeto "
oPrint:Say(760,1450,STR0063,oFont08) //"Prevencao"

oPrint:Say(640,1610,STR0031,oFont08) //"Controles"
oPrint:Say(680,1610,STR0032,oFont08) //"Atuais do"
oPrint:Say(720,1610,STR0033,oFont08) //" Projeto "
oPrint:Say(760,1610,STR0064,oFont08) //"Deteccao"

oPrint:Say(620,1760,STR0050,oFont08) // "D"
oPrint:Say(645,1760,STR0051,oFont08) // "E"
oPrint:Say(670,1760,STR0052,oFont08) // "T"
oPrint:Say(695,1760,STR0053,oFont08) // "E"
oPrint:Say(720,1760,STR0054,oFont08) // "C"

oPrint:Say(645,1810,STR0055,oFont08) // "N"
oPrint:Say(670,1810,STR0056,oFont08) // "P"
oPrint:Say(695,1810,STR0057,oFont08) // "R"

oPrint:Say(660,1900,STR0034,oFont08) //"     Acoes  "
oPrint:Say(700,1900,STR0035,oFont08) //"Recomendadas"

oPrint:Say(660,2250,STR0036,oFont08) //"Responsavel"
oPrint:Say(700,2250,STR0037,oFont08) //"     Prazo "

oPrint:Say(700,2550,STR0038,oFont08) //"Acoes Tomadas"

oPrint:Say(590,2610,STR0039,oFont08) //"Resultado das Acoes"

oPrint:Say(640,2825,STR0040,oFont08) // "S"
oPrint:Say(665,2825,STR0041,oFont08) // "E"
oPrint:Say(690,2825,STR0042,oFont08) // "V"
oPrint:Say(715,2825,STR0043,oFont08) // "E"
oPrint:Say(740,2825,STR0044,oFont08) // "R"
                                 
oPrint:Say(640,2865,STR0045,oFont08) // "O"
oPrint:Say(665,2865,STR0046,oFont08) // "C"
oPrint:Say(690,2865,STR0047,oFont08) // "O"
oPrint:Say(715,2865,STR0048,oFont08) // "R"
oPrint:Say(740,2865,STR0049,oFont08) // "R"

oPrint:Say(640,2897,STR0050,oFont08) // "D"
oPrint:Say(665,2897,STR0051,oFont08) // "E"
oPrint:Say(690,2897,STR0052,oFont08) // "T"
oPrint:Say(715,2897,STR0053,oFont08) // "E"
oPrint:Say(740,2897,STR0054,oFont08) // "C"

oPrint:Say(665,2950,STR0055,oFont08) // "N"
oPrint:Say(690,2950,STR0056,oFont08) // "P"
oPrint:Say(715,2950,STR0057,oFont08) // "R"
               
Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Tratament³ Autor ³ Adilson Soeiro Oliveir³ Data ³ 27.11.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Projeto                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Elimianar os <ENTER> inseridos pela rotina                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cLinTEXTO = caracter                                       ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Retorno do tratamento da linha de texto                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QExclEnter(cLinTEXTO )
// Excluir os <ENTER> inseridos pela  rotina
// Apenas os <ENTER> digitados pelo o usuario serao mantidos. Vide condicao: ( nQuebra == 1 ).

Local clinha	 := Alltrim(cLinTEXTO)
Local cxTextos	 := ""
Local xQuebra	 := chr(13)+chr(10)
Local nPosBRANCO := 1
Local nLimBRANCO := 1
Local lWordCrash := .F.

While Len(cLinha) > 0
	cLinha := Alltrim(cLinha)
	nQuebra := At(xQuebra,cLinha)
	Do Case
		Case ( nQuebra > 1 )                             
			// Verifica se a "PALAVRA" foi quebrada pela rotina com <ENTER>. Se a "PALAVRA EXISTIR" no cadastro, sera desconsiderada a quebra
            If subs(cLinha,nQuebra-1,1) <> " "
				lWordCrash:= .F.
                cLinhaTrat := Stuff(cLinha,nQuebra,2,"") + " " // sempre encontrara uma posicao em branco
                nPosBRANCO := 0                                // posicao do branco antes da "PALAVRA"
                nLimBRANCO := at(" ",clinhaTrat)              // posicao do branco apos a "PALAVRA"

                // busca o ultimo branco antes da quebra
                While nLimBRANCO > 0 .AND. nLimBRANCO < nQuebra
					nPosBRANCO := nLimBRANCO                          // Condicao aceita, considera na variavel nPosBRANCO
					cLinhaTrat := Stuff(cLinhaTrat,nPosBRANCO,1,"#") // a cada branco encontrado troca por "#"	 
					nLimBRANCO := at(" ",clinhaTrat)                 // busca a ultima posicao do BRANCO antes da quebra do <ENTER>
				Enddo			

              	// ATENCAO! Palavra quebrada nao podera inserir BRANCO entre as palabras
               	lWordCrash := QAL->(DbSeek(xFilial("QAL")+UPPER(QAXACENTO(subs(cLinhaTrat,nPosBRANCO+1,nLimBRANCO-1)))) )

                If lWordCrash // Existe "PALAVRA"
	                cLinha   := Stuff(cLinha,nQuebra,2,"")   // Adilson Soeiro - desconsidera a quebra chr(13)+chr(10) 
					cxTextos += " " +alltrim(SubStr(cLinha,1,nLimBRANCO-1))
					cLinha := Stuff(cLinha,1,nLimBRANCO,"")
				Else
					cxTextos += " " +alltrim(SubStr(cLinha,1,nQuebra-1))
					cLinha := Stuff(cLinha,1,nQuebra+1,"")
                Endif

			Else	
				cxTextos += " " +alltrim(SubStr(cLinha,1,nQuebra-1))
			    cLinha := Stuff(cLinha,1,nQuebra+1,"")
			EndIf

		Case ( nQuebra == 1 )
			If len(cLinha) > 3                               // Adilson Soeiro - 3 caracteres chr(13)+chr(10)+chr(32)
				cxTextos := cxTextos + " " +chr(13)+chr(10) // Adilson Soeiro - detalhe de uma linha em branco	 
			Endif
		    cLinha   := Stuff(cLinha,1,2,"")			
		OtherWise
			cxTextos += " " + alltrim(SubStr(cLinha,1,Len(cLinha))) 
			cLinha := Stuff(cLinha,1,Len(cLinha),"")	 
	EndCase
EndDo
cxTextos := AllTrim(cxTextos)
Return cxTextos

