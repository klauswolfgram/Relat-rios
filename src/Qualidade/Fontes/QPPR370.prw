/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR370.CH"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QPPR370   ºAutor  ³Denis Martins       º Data ³  24/04/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tratamento de FMEA de Projeto para 4a Edicao				  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QPRR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QPPR370(oPrint,lBrow,cPecaAuto,cJPEG,lPergunte)
Local aLayout	 := {"A","B","C","D","E","F"}
Local aPergs     := {}
Local aRetPergs  := {}
Local cLayout    := ""

Private	lQLGREL		:= GetMv("MV_QLGREL")
Private cPecaRev 	:= ""
Private cStartPath 	:= GetSrvProfString("Startpath","")

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := "" 
Default lPergunte   := .F. 

If lBrow
	aAdd(aPergs, {2,"Layout",4,aLayout,40,"",.T.})
	If ParamBox(aPergs,"Parâmetros",aRetPergs)
		cLayout := If(ValType(aRetPergs[1]) == "C",aRetPergs[1],aLayout[aRetPergs[1]])
	Else
		Return Nil
	EndIf
EndIf

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA120" .or. AllTrim(FunName()) == "QPPA121"
		cPecaRev := Iif(!lBrow, M->QK5_PECA + M->QK5_REV, QK5->QK5_PECA + QK5->QK5_REV)
	Else
		lPergunte := Pergunte("PPR181",.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	
		Else
			Return Nil
		Endif
	Endif
Endif

If oPrint == Nil //Caso seja chamado diretamente pelo menu...
	oPrint := TMSPrinter():New(STR0001) //FMEA
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
		MsgRun(STR0003,"",{|| CursorWait(), MontaRel(oPrint,cPecaRev,IIF(empty(cLayout),"D",cLayout)) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint,cPecaRev,IIF(empty(cLayout),"D",cLayout))
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

Static Function MontaRel(oPrint,cPecaRev,cForm)
Local i 	     := 1, nCont := 0
Local x 	     := 0, lin, nPos, nxCont := 0,nLinha := 0
Local aTxt, nx
Local cItem		 := ""
Local cItemAnt	 := ""
Local nNPRMAX	 := GetMv("MV_NPRMAX")
Local axTextos   := {} 
Local lPrazo                 
Local cLayout    := If(Empty(cForm),Upper(MV_PAR05),cForm)   // Tipo de formulario de FMEA de projeto   
Local nLinhE     := 0
Local lLayoutok  := cLayout $ 'ABCDEF'     //verifica se existe algum layout preenchido na rotina

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se nao Existem os Campos (Caso o UPDATE nao tenha sido rodado)  ³
//³E se o Layout nao foi preenchido (Quando o cliente entra diretamente pelo³
//³imprimir da QPPA120 e QPPA121 e nao pela rotina de relatorios            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !lLayoutok
	cLayout := 'D'
Endif

Private oFont16, oFont08, oFont10, oFontCou08, oFontNPR, oFont07, oFontCou07

oFont16		:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.) 
oFont07		:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",07,07,,.F.,,,,.T.,.F.)
oFontCou07	:= TFont():New("Courier New",07,07,,.F.,,,,.T.,.F.)
oFontNPR	:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)

Cabecalho(oPrint,i,cLayout)  	// Funcao que monta o cabecalho
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
		Cabecalho(oPrint,i,cLayout)  	// Funcao que monta o cabecalho
		lin := 790
		lin += 40
	Endif

	oPrint:Say(lin,1046,QK6->QK6_SEVER,oFontCou08)

	If !Empty(QK6->QK6_CLASS)
		PPAPBMP(QK6->QK6_CLASS+".BMP", cStartPath)
		oPrint:SayBitmap(lin,1084, QK6->QK6_CLASS+".BMP",40,40)
    Endif
    If cLayout $ 'BF'
		oPrint:Say(lin,1355,QK6->QK6_OCORR,oFontCou08)
	Else
		oPrint:Say(lin,1511,QK6->QK6_OCORR,oFontCou08)
	Endif
	
    If cLayout =='E'
		oPrint:Say(lin,1868,QK6->QK6_DETEC,oFontCou08)
	Else
		oPrint:Say(lin,1710,QK6->QK6_DETEC,oFontCou08)
	EndIf
	
    If cLayout =='E'
	    nLinhE :=150
    Endif
	If Val(QK6->QK6_NPR) >= nNPRMAX
		oPrint:Say(lin,1755+nLinhE,QK6->QK6_NPR,oFontNPR)
	Else
		oPrint:Say(lin,1755+nLinhE,QK6->QK6_NPR,oFontCou08)
	Endif 

    If cLayout =='F' 
		If Len(AllTrim(QK6->QK6_RESP)) <= 12
			oPrint:Say(lin,2115,QK6->QK6_RESP,oFontCou08)
		Else
			oPrint:Say(lin,2115,Subs(QK6->QK6_RESP,1,12),oFontCou08)
			If Len(AllTrim(Subs(QK6->QK6_RESP,13))) <= 12
				oPrint:Say((lin+20),2115,Subs(QK6->QK6_RESP,13),oFontCou08)
			Else
				oPrint:Say((lin+20),2115,Subs(QK6->QK6_RESP,13,12),oFontCou08)
				oPrint:Say((lin+40),2115,Subs(QK6->QK6_RESP,26),oFontCou08)
			EndIf
		Endif
	Elseif cLayout <> 'E' 
		oPrint:Say(lin,2120,Subs(QK6->QK6_RESP,1,22),oFontCou08)
	Else
		oPrint:Say(lin,2280,Subs(QK6->QK6_RESP,1,22),oFontCou08)
	Endif
		
	If cLayout =='E'
		oPrint:Say(lin,2965,QK6->QK6_RSEVER,oFontCou08)  //severidade
		oPrint:Say(lin,3005,QK6->QK6_ROCORR,oFontCou08)  //ocorrencia
		oPrint:Say(lin,3045,QK6->QK6_RDETEC,oFontCou08)  //deteccao
	Else
		oPrint:Say(lin,2815,QK6->QK6_RSEVER,oFontCou08)  //severidade
		oPrint:Say(lin,2855,QK6->QK6_ROCORR,oFontCou08)  //ocorrencia
		oPrint:Say(lin,2895,QK6->QK6_RDETEC,oFontCou08)  //deteccao
	Endif
	
	If cLayout =='F'
		oPrint:Say(lin,2695,Dtoc(QK6->QK6_DATEEF),oFontCou07)  //data Efetiva
	Endif
    
    If cLayout =='E'
	    nLinhE := 150
    Endif
    
    
	If Val(QK6->QK6_RNPR) >= nNPRMAX
		oPrint:Say(lin,2931+nLinhE,QK6->QK6_RNPR,oFontNPR)
	Else
		oPrint:Say(lin,2931+nLinhE,QK6->QK6_RNPR,oFontCou08)
	Endif
        
	// Lista das posições que ele salva na QKO.		
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³QPPA120A   ITEM FUNCAO                                  ³
	//³QPPA120B   MODO DE FALHA POTENCIAL                      ³
	//³QPPA120C   EFEITO POTENCIAL DE FALHA                    ³
	//³QPPA120D   CAUSA / MECANISMO POTENCIAL DE FALHA         ³
	//³QPPA120E   CONTROLES ATUAIS DE PROJETO -> PREVENCAO     ³
	//³QPPA120F   ACOES RECOMENDADAS                           ³
	//³QPPA120G   ACOES TOMADAS                                ³
	//³QQPA120H   CONTROLES ATUAIS DE PROJETO -> DETECCAO      ³
	//³QPPA120I   REQUISITOS                                   ³
	//³QPPA120J   CONTROLES DE PROJETO ATUAIS --> CAUSAS       ³
	//³QPPA120K   CONTROLES DE PROJETO ATUAIS --> MODO DE FALHA³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
	If !Empty(QK6->QK6_CHAVE1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120A   ITEM FUNCAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120A",1,16,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 16)
		axTextos := U_QbArTxt(cxTextos)  

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
									Space(12), Space(10), Space(8), Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      			Else
					aTxt[nPos,2] := axTextos[nxCont]
      			Endif
			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120I   REQUISITOS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120I",1,15,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 15)
		axTextos := U_QbArTxt(cxTextos)  
	
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If !Empty(QKO->QKO_TEXTO)
				If Len(aTxt) <> 0
					nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
				Else
					nPos := 0
				Endif

   				If nPos == 0
					aAdd( aTxt,{	STRZERO(nLinha,3),Space(17), Space(17), Space(17),;
									Space(12), Space(10), Space(8), Space(17), Space(17), axTextos[nxCont],Space(17),Space(17),Space(17)})
	      		Else
					aTxt[nPos,10] := axTextos[nxCont]
	    		Endif
			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120B   MODO DE FALHA POTENCIAL³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120B",1,14,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 14)
		axTextos := U_QbArTxt(cxTextos)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0                                            
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), axTextos[nxCont], Space(17),;
							Space(12), Space(10), Space(8), Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,3] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		DbSelectArea("QKO")
		DbSetOrder(1)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120C   EFEITO POTENCIAL DE FALHA³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120C",1,14,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 14)
		axTextos := U_QbArTxt(cxTextos)
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), axTextos[nxCont],;
								Space(12), Space(10), Space(8), Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,4] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120D   CAUSA / MECANISMO POTENCIAL DE FALHA³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120D",1,12,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 12)
		axTextos := U_QbArTxt(cxTextos)
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								axTextos[nxCont], Space(10), Space(8), Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,5] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120E   CONTROLES ATUAIS DE PROJETO -> PREVENCAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120E",1,10,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 10)
		axTextos := U_QbArTxt(cxTextos)
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(12), axTextos[nxCont], Space(8), Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,6] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next            

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120H   CONTROLES ATUAIS DE PROJETO -> DETECCAO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120H",1,8,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 8)
		axTextos := U_QbArTxt(cxTextos)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17), Space(12),;
								Space(10),axTextos[nxCont], Space(17), Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,7] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120F   ACOES RECOMENDADAS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120F",1,17,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 17)
		axTextos := U_QbArTxt(cxTextos)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(12), Space(10), Space(8), axTextos[nxCont], Space(17), Space(17),Space(17),Space(17),Space(17) })
      		Else
		   		aTxt[nPos,8] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120G   ACOES TOMADAS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}     
		//Recupera texto da chave  
		If cLayout =='F'
			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120G",1,13,"QKO",axTextos,.F.)
			cxTextos := QADIVFRA( QExclEnter(cxTextos), 13)
			axTextos := U_QbArTxt(cxTextos)
		Else
			cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120G",1,17,"QKO",axTextos,.F.)
			cxTextos := QADIVFRA( QExclEnter(cxTextos), 17)
			axTextos := U_QbArTxt(cxTextos)
		Endif
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17),;
								Space(12), Space(10), Space(8), Space(17), axTextos[nxCont], Space(17),Space(17),Space(17),Space(17)})
      		Else
		   		aTxt[nPos,9] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120J   CONTROLES DE PROJETO ATUAIS --> CAUSAS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        axTextos := {}     
		//Recupera texto da chave       //CAUSA
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120J",1,8,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 8)
		axTextos := U_QbArTxt(cxTextos)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17), Space(12),;
								Space(10),Space(10),Space(16), Space(17), Space(17), Space(17),axTextos[nxCont],Space(17),Space(17) })
      		Else
		   		aTxt[nPos,11] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA120K   CONTROLES DE PROJETO ATUAIS --> MODO DE FALHA³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
         axTextos := {}     
		//Recupera texto da chave  //MODOS DE FALHA
		cxTextos := QO_Rectxt(QK6->QK6_CHAVE1,"QPPA120K",1,8,"QKO",axTextos,.F.)
		cxTextos := QADIVFRA( QExclEnter(cxTextos), 8)
		axTextos := U_QbArTxt(cxTextos)
        nLinha := 1
		For nxCont := 1 To Len(axTextos)		
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

      		If nPos == 0  
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(17), Space(12),;
								Space(10),Space(10), Space(17), Space(17),Space(17) ,Space(17),axTextos[nxCont],Space(17) })
      		Else
		   		aTxt[nPos,12] := axTextos[nxCont]
      		Endif
            nLinha++ 
        Next      
	Endif

	If Len(aTxt) > 0
		cItem := aTxt[1,2]
	Endif

	If nCont > 1
		If Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, 3000+nLinhE )   	// horizontal
		Elseif !Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, 3000+nLinhE )   	// horizontal
		Endif
	Endif

	If Len(aTxt) > 0
		For nx := 1 To Len(aTxt)
			oPrint:Say(lin,0045,aTxt[nx,2],oFontCou08) //Item Funcao
			oPrint:Say(lin,0319,aTxt[nx,10],oFontCou08) //REQUISITO
			oPrint:Say(lin,0573,aTxt[nx,3],oFontCou08) //Modo de Falha
			oPrint:Say(lin,0818,aTxt[nx,4],oFontCou08) //Efeito Potencial
			oPrint:Say(lin,1137,aTxt[nx,5],oFontCou08) //Causa / Potencial
    
            If cLayout =='B' .or. cLayout =='F'
				oPrint:Say(lin,1394,aTxt[nx,6],oFontCou08) //Prevencao
			Else
				oPrint:Say(lin,1357,aTxt[nx,6],oFontCou08) //Prevencao
			Endif	
			
			If cLayout <>'E'
				oPrint:Say(lin,1557,aTxt[nx,7],oFontCou08) //Detecao
			Endif
						
			If cLayout =='E'
				oPrint:Say(lin,1988,aTxt[nx,8],oFontCou08) //Acoes Recomendadas
				oPrint:Say(lin,1555,aTxt[nx,11],oFontCou08) //CAUSAS
				oPrint:Say(lin,1720,aTxt[nx,12],oFontCou08) //MODO DE FALHA
			Else
				oPrint:Say(lin,1838,aTxt[nx,8],oFontCou08) //Acoes Recomendadas
			Endif
			
			If cLayout =='F'
				oPrint:Say(lin,2495,aTxt[nx,9],oFontCou08) //Acoes implementadas
			Elseif cLayout == 'E'
				oPrint:Say(lin,2660,aTxt[nx,9],oFontCou08) //Acoes implementadas
			Else
				oPrint:Say(lin,2510,aTxt[nx,9],oFontCou08) //Acoes implementadas
			Endif
     
			lin += 40

			If lin > 2240
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint,i,cLayout)  	// Funcao que monta o cabecalho
				lin := 790
				lin += 40
			Endif
			If lPrazo
			    If cLayout =='F'
				    oPrint:Say(lin-40,2325,DtoC(QK6->QK6_PRAZO),oFontCou08)	
			    Elseif cLayout =='E'
		    		oPrint:Say(lin,2345,DtoC(QK6->QK6_PRAZO),oFontCou08)	
		    	Else 
			    	oPrint:Say(lin,2115,DtoC(QK6->QK6_PRAZO),oFontCou08)
	    		Endif
    			lPrazo:= .F.
			Endif
		Next nx
	Else
		oPrint:Say(lin,2115,DtoC(QK6->QK6_PRAZO),oFontCou08)	
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

If cLayout =='E'
	oPrint:Line( lin, 30, lin, 3150 )   	// horizontal
Else
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
Endif

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
Static Function Cabecalho(oPrint,i,cLayout)
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

oPrint:Say(050,1060,STR0001,oFont16 ) //"ANáLISE DE MODO E EFEITOS DE FALHA POTENCIAL"
oPrint:Say(100,1328,STR0002,oFont16 ) //"FMEA DE PROJETO"

// Box Cabecalho  (O pequeno de Cima!)
If cLayout =='E'
	oPrint:Box( 160, 30, 580, 3150 )
Else
	oPrint:Box( 160, 30, 580, 3000 )
Endif

// Construcao da Grade
If cLayout =='E'
	oPrint:Line( 240, 1020, 240, 3150 )   	// horizontal
	oPrint:Line( 320, 1020, 320, 3150 )   	// horizontal
	oPrint:Line( 400, 1020, 400, 3150 )   	// horizontal 
	oPrint:Line( 480, 1020, 480, 3150 )   	// horizontal
Else
	oPrint:Line( 240, 1020, 240, 3000 )   	// horizontal
	oPrint:Line( 320, 1020, 320, 3000 )   	// horizontal
	oPrint:Line( 400, 1020, 400, 3000 )   	// horizontal 
	oPrint:Line( 480, 1020, 480, 3000 )   	// horizontal
Endif
oPrint:Line( 400, 030, 400, 1020 )   	// horizontal
oPrint:Line( 480, 030, 480, 1020 )   	// horizontal
 
oPrint:Line( 236, 1020, 580, 1020 )   	// vertical
oPrint:Line( 160, 2390, 480, 2390 )   	// vertical      

// Descricao cabecalho
oPrint:Say(170,0040,STR0004,oFont08)   		//"__Sistema"
oPrint:Say(250,0040,STR0005,oFont08)		//"__SubSistema"
oPrint:Say(330,0040,STR0006,oFont08)		//"__Componente"

If Alltrim(QK5->QK5_TPFMEA) == "1"
	oPrint:Say(169,0045,"X",oFontCou08)
ElseIf Alltrim(QK5->QK5_TPFMEA) == "2" 
	oPrint:Say(249,0045,"X",oFontCou08)
ElseIf Alltrim(QK5->QK5_TPFMEA) == "3"
	oPrint:Say(329,0045,"X",oFontCou08)	
Endif


oPrint:Say(170,2405,STR0008,oFont08) //"Numero da FMEA"
oPrint:Say(200,2405,QK5->QK5_FMEA,oFontCou08)

oPrint:Say(250,2405,STR0009,oFont08) //"Pagina"
oPrint:Say(280,2405,StrZero(i,3),oFontCou08)

oPrint:Say(330,2405,STR0007,oFont08) //"Elaborado Por "
oPrint:Say(360,2405,PadR(QK5->QK5_PREPOR,34),oFontCou08)

oPrint:Say(250,1030,STR0010,oFont08) //"Responsavel pelo Projeto"
oPrint:Say(280,1030,QK5->QK5_RESPON,oFontCou08)

oPrint:Say(330,1030,STR0011,oFont08) //"Identificacao do Produto"
oPrint:Say(360,1030,QK5->QK5_IDPROD,oFontCou08)

oPrint:Say(410,0040,STR0012,oFont08) //"Ano(s)/Programa"
oPrint:Say(440,0040,QK5->QK5_ANOMOD,oFontCou08)

oPrint:Say(410,1030,STR0013,oFont08) //"Data Chave"
oPrint:Say(440,1030,DtoC(QK5->QK5_DTCHAV),oFontCou08)

oPrint:Say(410,2405,STR0014,oFont08) //"Data FMEA(Original)"
oPrint:Say(440,2405,DtoC(QK5->QK5_DATA),oFontCou08)

oPrint:Say(490,0040,STR0015,oFont08) //"Equipe"
oPrint:Say(520,0040,QK5->QK5_EQUIPE,oFontCou08)

oPrint:Say(490,1030,STR0016,oFont08) //"Observacoes"
If Len(AllTrim(QK5->QK5_OBS)) <= 116
	oPrint:Say(520,1030,QK5->QK5_OBS,oFontCou08)
Else
	oPrint:Say(520,1030,SubStr(QK5->QK5_OBS,1,116),oFontCou08)
	oPrint:Say(550,1030,SubStr(QK5->QK5_OBS,117),oFontCou08)
Endif

// Box itens  (O box Maior.!!)  
If cLayout =='E'
	oPrint:Box( 630, 30, 2260, 3150 )
	oPrint:Line( 820, 30, 820, 3150 )   	// horizontal
	oPrint:Say(2280,2900,STR0060+' '+Upper(cLayout),oFontCou08)
Else
	oPrint:Box( 630, 30, 2260, 3000 )
	oPrint:Line( 820, 30, 820, 3000 )   	// horizontal
	oPrint:Say(2280,2750,STR0060+' '+Upper(cLayout),oFontCou08)
Endif

// Construcao da grade itens     
If cLayout $ ' BDEF'
	oPrint:Line( 630, 0305, 2260, 0305 )   	// vemmrtical - item funcao
	oPrint:Line( 630, 0305, 820, 30 )   	// VERTICAL  - item funcao DIAGONAL
	oPrint:Line( 630, 0566, 2260, 0566 )   	// vertical - requisito
Endif 

If cLayout $ 'AC'
	oPrint:Line( 820, 0305, 2260, 0305 )   	// vemmrtical - item funcao
	oPrint:Line( 630, 0566, 820, 30 )   	// VERTICAL  - item funcao requisito DIAGONAL
	oPrint:Line( 630, 0566, 2260, 0566 )   	// vertical - requisito
Endif

oPrint:Line( 630, 0813, 2260, 0813 )   	// vertical - modo de falha potencial
oPrint:Line( 630, 1045, 2260, 1045 )   	// vertical - severidade
oPrint:Line( 630, 1080, 2260, 1080 )   	// vertical - classificacao
oPrint:Line( 630, 1132, 2260, 1132 )   	// vertical - causa potencial de falha - 95
                                                   
oPrint:Line( 630, 1344, 2260, 1344 )   	// vertical

If cLayout $ 'BF'                        // ocorrencia perto de COntroles de Prevencao.
	oPrint:Line( 630, 1390, 2260, 1390 )   	// vertical
Else
	oPrint:Line( 630, 1510, 2260, 1510 )   	// vertical
Endif
oPrint:Line( 630, 1548, 2260, 1548 )   	// vertical

If cLayout =='E'
	oPrint:Say(640,1610,STR0061,oFont08) //"Controles de
	oPrint:Say(670,1610,STR0062,oFont08) //"Projetos atuais
	oPrint:Say(750,1570,STR0063,oFont08) //"Causas
	oPrint:Say(735,1710,STR0064,oFont08) //"Modos de 
	oPrint:Say(765,1730,STR0065,oFont08) //"Falha
	oPrint:Line( 700, 1548, 700, 1851 )   	// vertical 
	oPrint:Line( 700, 1700, 2260, 1700 )   	// vertical 
	oPrint:Line( 630, 1851, 2260, 1851 )   	// vertical 
	oPrint:Line( 630, 1902, 2260, 1902 )   	// vertical
	oPrint:Line( 630, 1976, 2260, 1976 )   	// vertical - D E T E C - final
	oPrint:Line( 630, 2265, 2260, 2265 )   	// vertical - alterar esta
Else
	oPrint:Line( 630, 1701, 2260, 1701 )   	// vertical 
	oPrint:Line( 630, 1752, 2260, 1752 )   	// vertical
	oPrint:Line( 630, 1823, 2260, 1823 )   	// vertical - D E T E C - final
	oPrint:Line( 630, 2115, 2260, 2115 )   	// vertical - alterar esta
Endif

If cLayout =='F'
	oPrint:Line( 630, 2320, 2260, 2320 )   	// vertical
	oPrint:Line( 690, 2690, 2260, 2690 )   	// vertical
Endif

If cLayout =='E'
	oPrint:Line( 630, 2640, 2260, 2640 )   	// vertical --> Linha entre Responsabilidade e Data conclusao Pretendida e Acoes adotadas
	oPrint:Line( 630, 2640, 0630, 3150 )   	// horizontal
	oPrint:Line( 690, 2640, 690, 3150 )   	// horizontal
	oPrint:Say(650,2770,STR0066,oFont08) //"Resultado das Ações
	oPrint:Line( 690, 2960, 2260, 2960 )   	// vertical SEVERIDADE
	oPrint:Line( 690, 3000, 2260, 3000 )   	// vertical OCORRENCIA
	oPrint:Line( 690, 3040, 2260, 3040 )   	// vertical DETECCAO
	oPrint:Line( 690, 3080, 2260, 3080 )   	// vertical NPR
Else
	oPrint:Line( 630, 2490, 2260, 2490 )   	// vertical --> Linha entre Responsabilidade e Data conclusao Pretendida e Acoes adotadas
	oPrint:Line( 630, 2490, 0630, 3000 )   	// horizontal
	oPrint:Line( 690, 2490, 690, 3000 )   	// horizontal
	oPrint:Say(650,2600,STR0066,oFont08) //"Resultado das Ações
	oPrint:Line( 690, 2810, 2260, 2810 )   	// vertical SEVERIDADE
	oPrint:Line( 690, 2850, 2260, 2850 )   	// vertical OCORRENCIA
	oPrint:Line( 690, 2890, 2260, 2890 )   	// vertical DETECCAO
	oPrint:Line( 690, 2930, 2260, 2930 )   	// vertical NPR
Endif

// Descricao itens
If cLayout $ ' BDEF'
	oPrint:Say(650,110,STR0017,oFont08) //" Item "
	oPrint:Say(760,153,STR0018,oFont08) //"Funcao"
	oPrint:Say(700,370,STR0019,oFont08) //"Requisito"
Endif 

If cLayout $ 'AC'
	oPrint:Say(650,110,STR0017,oFont08) //" Item "
	oPrint:Say(680,95,STR0018,oFont08) //"Funcao"
	oPrint:Say(730,390,STR0019,oFont08) //"Requisito"
Endif

oPrint:Say(660,630,STR0020,oFont08) //" Modo de "
oPrint:Say(700,650,STR0021,oFont08) //"Falha"
oPrint:Say(740,630,STR0022,oFont08) //"Potencial "

oPrint:Say(660,880,STR0023,oFont08) //" Efeito  "
oPrint:Say(700,870,STR0024,oFont08) //"Potencial"
oPrint:Say(740,870,STR0025,oFont08) //"da Falha "

oPrint:Say(650,1053,STR0026,oFont08) // "S"
oPrint:Say(675,1053,STR0027,oFont08) // "E"
oPrint:Say(700,1053,STR0028,oFont08) // "V"
oPrint:Say(725,1053,STR0029,oFont08) // "E"
oPrint:Say(750,1053,STR0030,oFont08) // "R"

oPrint:Say(650,1096,STR0031,oFont08) // "C"
oPrint:Say(675,1096,STR0032,oFont08) // "L"
oPrint:Say(700,1096,STR0033,oFont08) // "A" 
oPrint:Say(725,1096,STR0034,oFont08) // "S"
oPrint:Say(750,1096,STR0035,oFont08) // "S"

oPrint:Say(660,1185,STR0036,oFont08) //"Causa(s)"
oPrint:Say(700,1150,STR0037,oFont08) //"Potencial(ais)"
oPrint:Say(740,1185,STR0038,oFont08) //"de Falha"

If cLayout $ 'BF'
	oPrint:Say(675,1404,STR0039,oFont08) //"Controles"
	oPrint:Say(715,1404,STR0040,oFont08) //"Prevencao"
	
	oPrint:Say(630,1360,STR0041,oFont08) // "O"
	oPrint:Say(655,1360,STR0042,oFont08) // "C"
	oPrint:Say(680,1360,STR0043,oFont08) // "O"
	oPrint:Say(705,1360,STR0044,oFont08) // "R"
	oPrint:Say(730,1360,STR0044,oFont08) // "R"
Else
	oPrint:Say(675,1362,STR0039,oFont08) //"Controles"
	oPrint:Say(715,1362,STR0040,oFont08) //"Prevencao"
	
	oPrint:Say(650,1517,STR0041,oFont08) // "O"
	oPrint:Say(675,1517,STR0042,oFont08) // "C"
	oPrint:Say(700,1517,STR0043,oFont08) // "O"
	oPrint:Say(725,1517,STR0044,oFont08) // "R"
	oPrint:Say(750,1517,STR0044,oFont08) // "R"
Endif

If cLayout =='E'
	oPrint:Say(650,1865,STR0046,oFont08) // "D"
	oPrint:Say(675,1865,STR0047,oFont08) // "E"
	oPrint:Say(700,1865,STR0048,oFont08) // "T"
	oPrint:Say(725,1865,STR0049,oFont08) // "E"
	oPrint:Say(750,1865,STR0050,oFont08) // "C"
	
	oPrint:Say(665,1925,STR0051,oFont08) // "N"
	oPrint:Say(695,1925,STR0052,oFont08) // "P"
	oPrint:Say(715,1925,STR0053,oFont08) // "R"
	
	oPrint:Say(675,2075,STR0054,oFont08) //"     Acoes  "
	oPrint:Say(715,2016,STR0055,oFont08) //"Recomendadas"
Else
	oPrint:Say(675,1558,STR0039,oFont08) //"Controles"
	oPrint:Say(715,1558,STR0045,oFont08) //"Deteccao"
	
	oPrint:Say(650,1715,STR0046,oFont08) // "D"
	oPrint:Say(675,1715,STR0047,oFont08) // "E"
	oPrint:Say(700,1715,STR0048,oFont08) // "T"
	oPrint:Say(725,1715,STR0049,oFont08) // "E"
	oPrint:Say(750,1715,STR0050,oFont08) // "C"
	
	oPrint:Say(665,1775,STR0051,oFont08) // "N"
	oPrint:Say(695,1775,STR0052,oFont08) // "P"
	oPrint:Say(715,1775,STR0053,oFont08) // "R"
	
	oPrint:Say(675,1925,STR0054,oFont08) //"     Acoes  "
	oPrint:Say(715,1866,STR0055,oFont08) //"Recomendadas"
Endif

If cLayout =='F'
	oPrint:Say(690,2120,STR0067,oFont08) //"Responsabilidade
	oPrint:Say(670,2350,STR0068,oFont08) //"Data de
	oPrint:Say(700,2330,STR0069,oFont08) //"conclusao
	oPrint:Say(730,2330,STR0070,oFont08) //"pretendida
	oPrint:Say(715,2520,STR0071,oFont08) //"Acoes 
	oPrint:Say(745,2508,STR0072,oFont08) //"adotadas
	oPrint:Say(715,2720,STR0073,oFont08) //"Data
	oPrint:Say(745,2710,STR0074,oFont08) //"efetiva
ElseIf cLayout <> 'E'
	oPrint:Say(675,2185,STR0056,oFont08) //"Responsabilidade"
	oPrint:Say(715,2185,STR0057,oFont08) //"Data de Conclusao"
	oPrint:Say(735,2508,STR0058,oFont08) //"Acoes Implementadas"
Else
	oPrint:Say(675,2335,STR0056,oFont08) //"Responsabilidade"
	oPrint:Say(715,2335,STR0057,oFont08) //"Data de Conclusao"
	oPrint:Say(735,2658,STR0058,oFont08) //"Acoes Implementadas"
Endif

If cLayout =='E'
	oPrint:Say(690,2972,STR0026,oFont08) // "S"
	oPrint:Say(715,2972,STR0027,oFont08) // "E"
	oPrint:Say(740,2972,STR0028,oFont08) // "V"
	oPrint:Say(765,2972,STR0029,oFont08) // "E"
	oPrint:Say(790,2972,STR0030,oFont08) // "R" 
	                                 
	oPrint:Say(690,3010,STR0041,oFont08) // "O"
	oPrint:Say(715,3010,STR0042,oFont08) // "C"
	oPrint:Say(740,3010,STR0043,oFont08) // "O"
	oPrint:Say(765,3010,STR0044,oFont08) // "R"
	oPrint:Say(790,3010,STR0044,oFont08) // "R" 
	
	oPrint:Say(690,3050,STR0046,oFont08) // "D"
	oPrint:Say(715,3050,STR0047,oFont08) // "E"
	oPrint:Say(740,3050,STR0048,oFont08) // "T"
	oPrint:Say(765,3050,STR0049,oFont08) // "E"
	oPrint:Say(790,3050,STR0050,oFont08) // "C"  
	
	oPrint:Say(715,3100,STR0051,oFont08) // "N"
	oPrint:Say(740,3100,STR0052,oFont08) // "P"
	oPrint:Say(765,3100,STR0053,oFont08) // "R"
Else
	oPrint:Say(690,2822,STR0026,oFont08) // "S"
	oPrint:Say(715,2822,STR0027,oFont08) // "E"
	oPrint:Say(740,2822,STR0028,oFont08) // "V"
	oPrint:Say(765,2822,STR0029,oFont08) // "E"
	oPrint:Say(790,2822,STR0030,oFont08) // "R" 
	                                 
	oPrint:Say(690,2860,STR0041,oFont08) // "O"
	oPrint:Say(715,2860,STR0042,oFont08) // "C"
	oPrint:Say(740,2860,STR0043,oFont08) // "O"
	oPrint:Say(765,2860,STR0044,oFont08) // "R"
	oPrint:Say(790,2860,STR0044,oFont08) // "R" 
	
	oPrint:Say(690,2900,STR0046,oFont08) // "D"
	oPrint:Say(715,2900,STR0047,oFont08) // "E"
	oPrint:Say(740,2900,STR0048,oFont08) // "T"
	oPrint:Say(765,2900,STR0049,oFont08) // "E"
	oPrint:Say(790,2900,STR0050,oFont08) // "C"  
	
	oPrint:Say(715,2950,STR0051,oFont08) // "N"
	oPrint:Say(740,2950,STR0052,oFont08) // "P"
	oPrint:Say(765,2950,STR0053,oFont08) // "R"
Endif
               
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ QuebraTxtºAutor  ³Andre Anjos		 º Data ³  17/03/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Quebra texto em linhas conforme tamanho informado.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QPPR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QuebraTxt(cTexto,nTamanho,nMaxLin)
Local aRet      := {}
Local nLinCount := 1

While !Empty(cTexto) .And. If(Empty(nMaxLin),.T.,nLinCount <= nMaxLin)
	aAdd(aRet,Substr(cTexto,1,nTamanho))
	cTexto := Substr(cTexto,nTamanho+1)
End

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ QbArTxt  ºAutor  ³Robson Sales		 º Data ³  05/08/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Gera array com as quebras de linha geradas pelo QADIVFRA() º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QPPR370                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QbArTxt(cTexto)

Local nCr
Local aTexto := {}

Default cTexto := " "

While Len(cTexto) > 1
	nCr := At(chr(13)+chr(10),cTexto)
	Aadd(aTexto,SubStr(cTexto,1,nCr-2))
	cTexto := Stuff(cTexto,1,nCr+1,"")
EndDo

Return aTexto