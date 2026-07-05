/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR380.CH"    
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR380  ³ Autor ³ Denis Martins			³ Data ³ 12.05.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Processo                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR380(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³										  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QPPR380(oprint,lBrow,cPecaAuto,cJPEG)
Local lPergunte  := .F.
Local aLayout	 := {"A","B","C","D","E","F","G","H"}
Local aPergs     := {}
Local aRetPergs  := {}
Local cLayout    := ""

Private cPecaRev 	:= ""
Private cStartPath 	:= GetSrvProfString("Startpath","")
Private	lQLGREL		:= GetMv("MV_QLGREL")

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := "" 

If lBrow
	aAdd(aPergs, {2,"Layout",1,aLayout,40,"",.T.})
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

If oPrint == Nil //Caso venha do menu Relatorios..
	oPrint := TMSPrinter():New(STR0001) //FMEA
Endif

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA130" .or. AllTrim(FunName()) == "QPPA131"
		cPecaRev := Iif(!lBrow, M->QK7_PECA + M->QK7_REV, QK7->QK7_PECA + QK7->QK7_REV)
	Else
		If lPergunte := Pergunte("PPR131",.T.)
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

DbSelectArea("QK7") 
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)
	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint,IIF(empty(cLayout),"A",cLayout)) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint,IIF(empty(cLayout),"A",cLayout))
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
±±³Funcao    ³ MontaRel ³ Autor ³ Denis Martins			³ Data ³ 12.05.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Processo                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint,cForm)
Local i 	:= 1, nCont := 0
Local x 	:= 0, lin, nPos
Local nx		 := 0
Local cTexto	 := ""
Local cOpe		 := ""
Local cItem		 := ""
Local cItemAnt	 := ""
Local nNPRMAX	 := GetMv("MV_NPRMAX")
Local aTxt		 := {}
Local axTextos   := {}
Local nxCont     := 0, nLinha := 0
Local cLayout    := If(Empty(cForm),UPPER(MV_PAR04),cForm)   //Variavel de controle para impressão dos Layout's do Formulario.
Local nLinNPR    := 0
Local lLayoutOK  := cLayout $ 'ABCDEFGH' //Verifica se o layout esta preenchido errado

Private oFont16, oFont08, oFont10, oFontCou08, oFontNPR, oFont16N, oFontCou07

If !lLayoutOK
	cLayout := 'A'
Endif

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.) 
oFont16N	:= TFont():New("Arial",16,16,,.T.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",06,06,,.F.,,,,.T.,.F.)
oFontNPR	:= TFont():New("Arial",08,08,,.T.,,,,.T.,.F.)

Cabecalho(oPrint,i,cLayout)  	// Funcao que monta o cabecalho
lin := 790

DbSelectArea("QK8")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)
Do While !Eof() .and. QK8->(QK8_PECA+QK8_REV) == cPecaRev
	nCont++
	aTxt := {}	// Array que armazena os campos memos
	lin += 40

	If lin > 2240
		nCont := 1
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i,cLayout)  	// Funcao que monta o cabecalho
		lin := 790
		lin += 40
	Endif

	oPrint:Say(lin,1049,QK8->QK8_SEVER,oFontCou08)

	If !Empty(QK8->QK8_CLASS)
		PPAPBMP(QK8->QK8_CLASS+".BMP", cStartPath)
		oPrint:SayBitmap(lin,1085, QK8->QK8_CLASS+".BMP",40,40)
	Endif
	If cLayout $ 'AFBG'  
		oPrint:Say(lin,1349,QK8->QK8_OCORR,oFontCou08) //ocorrencia
	Endif
	If cLayout $ ' CEDH'
		oPrint:Say(lin,1515,QK8->QK8_OCORR,oFontCou08) //ocorrencia
	Endif
	
	If cLayout <>'E'
		oPrint:Say(lin,1710,QK8->QK8_DETEC,oFontCou08)
	Else
		oPrint:Say(lin,1866,QK8->QK8_DETEC,oFontCou08)
	Endif 
	
	//Imprime o X quando o Layout é igual a G ou H para o Campo de ID     
	If cLayout $ 'GH'
		dbselectArea("QK2")
		dbgoTop()                      
		dbsetOrder(2)   //QK2_FILIAL+QK2_PECA+QK2_REV+QK2_CODCAR
		If Dbseek(xFilial()+cPecaRev+QK8->QK8_ID)
			Do While !Eof() .and. QK2->QK2_PECA+QK2->QK2_REV+QK2->QK2_CODCAR == cPecaRev+QK8->QK8_ID
				IF QK2->QK2_PRODPR == '1'
					oPrint:Say(lin,415,"X",oFontCou08)
				ElseIf QK2->QK2_PRODPR == '2'
					oPrint:Say(lin,505,"X",oFontCou08)
				Endif		
				DbSkip()
			EndDo           
		Endif
	Endif	

	If cLayout =='E'
    	nLinNPR := 1900
    Else
    	nLinNPR := 1753
    EndiF
	
	If Val(QK8->QK8_NPR) >= nNPRMAX
		oPrint:Say(lin,nLinNPR,QK8->QK8_NPR,oFontNPR)
	Else
		oPrint:Say(lin,nLinNPR,QK8->QK8_NPR,oFontCou08)
	Endif

	If cLayout $ ' ABCDGH'	
		oPrint:Say(lin,2125,Substr(QK8->QK8_RESP,1,21),oFontCou08)
		oPrint:Say(lin+30,2125,DtoC(QK8->QK8_PRAZO),oFontCou08)
	Endif
	
	If cLayout $ 'GH'
		oPrint:Say(lin,315,QK8->QK8_ID,oFontCou08)
	EndiF
	
	If cLayout =='F'
		oPrint:Say(lin,2125,Substr(QK8->QK8_RESP,13),oFontCou08) //Responsavel 
		oPrint:Say(lin,2355,DtoC(QK8->QK8_PRAZO),oFontCou08)//Prazo
		oPrint:Say(lin,2690,DtoC(QK8->QK8_DATEEF),oFontCou07)//Data Efetiva
	Endif
		
    If cLayout <>'E'
		oPrint:Say(lin,2815,QK8->QK8_RSEVER,oFontCou08)
		oPrint:Say(lin,2855,QK8->QK8_ROCORR,oFontCou08)
		oPrint:Say(lin,2895,QK8->QK8_RDETEC,oFontCou08)
	Else
		oPrint:Say(lin,2965,QK8->QK8_RSEVER,oFontCou08)
		oPrint:Say(lin,3005,QK8->QK8_ROCORR,oFontCou08)
		oPrint:Say(lin,3045,QK8->QK8_RDETEC,oFontCou08)
		oPrint:Say(lin,2285,Substr(QK8->QK8_RESP,22),oFontCou08)
		oPrint:Say(lin+30,2305,DtoC(QK8->QK8_PRAZO),oFontCou08)
	Endif
	   
    If cLayout =='E'
    	nLinNPR := 3081
    Else
    	nLinNPR := 2931
    EndiF
		
	If Val(QK8->QK8_RNPR) >= nNPRMAX
		oPrint:Say(lin,nLinNPR,QK8->QK8_RNPR,oFontNPR)
	Else
		oPrint:Say(lin,nLinNPR,QK8->QK8_RNPR,oFontCou08)
	Endif
	
	//Sequencia de chaves que o programa salva na QKO

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³QPPA130A   DESCRICAO DA OPERACAO                                    ³
	//³QPPA130B   MODO DE FALHA POTENCIAL                                  ³
	//³QPPA130C   EFEITO POTENCIAL DE FALHA                                ³
	//³QPPA130D   CAUSA / MECANISMO POTENCIAL DA FALHA                     ³
	//³QPPA130E   CONTROLES ATUAIS DO PROJETO  PREVENCAO                   ³
	//³QPPA130F   ACOES RECOMENDADAS                                       ³
	//³QPPA130G   ACOES TOMADAS                                            ³
	//³QPPA130H   CONTROLES ATUAIS DO PROJETO DETECCAO                     ³
	//³QPPA130I   REQUISITOS                                               ³
	//³QPPA130J   CONTROLES DE PROCESSO ATUAIS  -> CAUSAS                  ³
	//³QPPA130K   CONTROLES DE PROCESSO ATUAIS  -> MODOS DE FALHA POTENCIAL³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(QK8->QK8_CHAVE1)
		DbSelectArea("QKO")
		DbSetOrder(1)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130A   DESCRICAO DA OPERACAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  		axTextos := {}     
			//Recupera texto da chave
	
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130A",1,17,"QKO", axTextos,.F.)
			cxTextos := QADIVFRA( QExclEnter(cxTextos), 17)
			axTextos := QuebraTXT(cxTextos,15)  
	
	        nLinha := 1
			For nxCont := 1 To Len(axTextos)
				If Len(aTxt) <> 0
					nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
				Else
					nPos := 0
				Endif
	
	   			If nPos == 0
					aAdd( aTxt,{	STRZERO(nLinha,3), axTextos[nxCont], Space(13),Space(13), Space(13), Space(13),;
									Space(8),Space(8), Space(17), Space(17), Space(17),Space(17) })
	   			Else
					aTxt[nPos,2] := axTextos[nxCont]
	   			Endif
	            nLinha++ 
	        Next 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130I   REQUISITOS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If !(cLayout $ 'GH') //Nesses layout's nao imprime os Requisitos
			axTextos := {}
			//Recupera texto da chave
			   	cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130I",1,17,"QKO",axTextos,.F.)
				cxTextos := QExclEnter(cxTextos)
//				cxTextos := QADIVFRA (cxTextos,17)
				axTextos := QuebraTXT(cxTextos,18)  

		   
	        nLinha := 1
			For nxCont := 1 To Len(axTextos) //Requisitos	
				If Len(aTxt) <> 0
					nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
				Else
					nPos := 0
				Endif
	
	   			If nPos == 0
					aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), axTextos[nxCont], Space(15), Space(14),;
									Space(9), Space(10), Space(8), Space(17), Space(17), Space(17), Space(17) })
	   			Else
					aTxt[nPos,3] := axTextos[nxCont]
	   			Endif
	            nLinha++ 
	        Next
        Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130B   MODO DE FALHA POTENCIAL ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130B",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA (cxTextos, 17)
			axTextos := QuebraTXT(cxTextos,18)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos)
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), axTextos[nxCont], Space(14),;
								Space(9), Space(10), Space(8), Space(17), Space(17), Space(17), Space(17) })
   			Else
				aTxt[nPos,4] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130C   EFEITO POTENCIAL DE FALHA³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130C",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA (cxTextos,17)
			axTextos := QuebraTXT(cxTextos,18)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Efeito de Falha Potencial
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15), axTextos[nxCont],;
								Space(9), Space(10), Space(8), Space(17), Space(17), Space(17), Space(17) })
   			Else
				aTxt[nPos,5] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130D   CAUSA / MECANISMO POTENCIAL DA FALHA³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130D",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA (cxTextos,17)
			axTextos := QuebraTXT(cxTextos,18)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Causa/Mecanismo Potencial da Falha
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15), Space(17),;
								axTextos[nxCont], Space(10), Space(8), Space(17), Space(17), Space(17), Space(17) })
   			Else
				aTxt[nPos,6] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130E   CONTROLES ATUAIS DO PROJETO  PREVENCAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130E",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA (cxTextos,17)
			axTextos := QuebraTXT(cxTextos,9)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Controles atuais do processo
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15),Space(14),;
								Space(9), axTextos[nxCont], Space(8), Space(17), Space(17) , Space(17), Space(17)})
   			Else
				aTxt[nPos,7] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130H   CONTROLES ATUAIS DO PROJETO DETECCAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130H",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA (cxTextos,17)
			axTextos := QuebraTXT(cxTextos,9)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Controles atuais do projeto Deteccao
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15),Space(14),;
								Space(9), Space(10), axTextos[nxCont], Space(17), Space(17), Space(17), Space(17) })
   			Else
				aTxt[nPos,8] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130J   CONTROLES DE PROCESSO ATUAIS  -> CAUSAS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130J",1,17,"QKO",axTextos)
			cxTextos := QExclEnter(cxTextos)
			cxTextos := QADIVFRA    (cxTextos,11)
			axTextos := JustificaTXT(cxTextos,8,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Causa
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15),Space(14),;
								Space(9), Space(10), Space(8), Space(17), Space(17),axTextos[nxCont], Space(17) })
   			Else
				aTxt[nPos,11] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130K   CONTROLES DE PROCESSO ATUAIS  -> MODOS DE FALHA POTENCIAL³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130K",1,17,"QKO",axTextos)
			cxTextos := QExclEnter(cxTextos)
			cxTextos := QADIVFRA(cxTextos, 11)
			axTextos := JustificaTXT(cxTextos,8,.F.,.T.)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Modos de falha
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15),Space(14),;
								Space(9), Space(10), Space(8), Space(17), Space(17), Space(17),axTextos[nxCont], })
   			Else
				aTxt[nPos,12] := axTextos[nxCont]
   			Endif

            nLinha++ 
        Next

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³QPPA130F   ACOES RECOMENDADAS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		axTextos := {}
		//Recupera texto da chave
			cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130F",1,17,"QKO",axTextos,.F.)
			cxTextos := QExclEnter(cxTextos)
//			cxTextos := QADIVFRA( cxTextos, 17)
			axTextos := QuebraTXT(cxTextos,18)  
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Acoes Recomendadas
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15), Space(14),;
								Space(9), Space(10), Space(8), axTextos[nxCont], Space(17), Space(17), Space(17) })
   			Else
				aTxt[nPos,9] := axTextos[nxCont]
   			Endif
            nLinha++ 
        Next       

        axTextos := {}
        If cLayout =='F'
				cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130G",1,13,"QKO",axTextos,.F.)
				cxTextos := QExclEnter(cxTextos)
//				cxTextos := QADIVFRA( QExclEnter(cxTextos), 13)
				axTextos := QuebraTXT(cxTextos,11)  
		Else
				cxTextos := QO_Rectxt(QK8->QK8_CHAVE1,"QPPA130G",1,21,"QKO",axTextos,.F.)
				cxTextos := QExclEnter(cxTextos)
//				cxTextos := QADIVFRA( QExclEnter(cxTextos), 21)
				axTextos := QuebraTXT(cxTextos,18)  
		Endif
        nLinha := 1
		For nxCont := 1 To Len(axTextos) // Acoes Tomadas
			If Len(aTxt) <> 0
				nPos := aScan( aTxt, { |x| x[1] == STRZERO(nLinha,3) })
			Else
				nPos := 0
				  
			Endif

   			If nPos == 0
				aAdd( aTxt,{	STRZERO(nLinha,3), Space(17), Space(17), Space(15), Space(14),;
								Space(9), Space(8), Space(8), Space(17), axTextos[nxCont] , Space(17), Space(17)})
   			Else
				aTxt[nPos,10] := axTextos[nxCont]
   			Endif

            nLinha++ 
        Next 	  		
    Endif

	If Len(aTxt) > 0
		cItem := aTxt[1,2]
	Endif

	If nCont > 1
		If Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, iif(cLayout =='E',3150,3000) )   	// horizontal
			lin += 20
		Elseif !Empty(cItemAnt) .and. !Empty(cItem)
			oPrint:Line( lin, 30, lin, iif(cLayout =='E',3150,3000) )   	// horizontal
			lin += 20
		Endif
	Endif
		lin += 50
	If Len(aTxt) > 0
		For nx := 1 To Len(aTxt)
			oPrint:Say(lin,0050,aTxt[nx,2],oFontCou08) //etapa
			oPrint:Say(lin-40,0310,aTxt[nx,3],oFontCou08) //requisito
			oPrint:Say(lin-40,0572,aTxt[nx,4],oFontCou08) //modo de falha potencial
			oPrint:Say(lin-40,0818,aTxt[nx,5],oFontCou08) //efeito potencial de falha
			oPrint:Say(lin-40,1141,aTxt[nx,6],oFontCou08) //causa potencial
			If cLayout $ ' CEDH'
				oPrint:Say(lin-40,1355,aTxt[nx,7],oFontCou08) //controle de prevencao
			Endif                                                             
			If cLayout $ 'AFBG'
				oPrint:Say(lin-40,1385,aTxt[nx,7],oFontCou08) //controle de prevencao
			Endif
			If cLayout <>'E'
				oPrint:Say(lin-40,1556,aTxt[nx,8],oFontCou08) //controle de deteccao
				oPrint:Say(lin-40,1840,aTxt[nx,9],oFontCou08) //acoes recomendadas
				oPrint:Say(lin-40,2499,aTxt[nx,10],oFontCou08) //acoes tomadas
			Else
				oPrint:Say(lin-40,1990,aTxt[nx,9],oFontCou08) //acoes recomendadas
				oPrint:Say(lin-40,2649,aTxt[nx,10],oFontCou08) //acoes tomadas
				oPrint:Say(lin-40,1580,aTxt[nx,11],oFontCou08) //Causas
				oPrint:Say(lin-40,1720,aTxt[nx,12],oFontCou08) //Modo de falha
			Endif		

			lin += 40

			If lin > 2240
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint,i,cLayout) 	// Funcao que monta o cabecalho
				lin := 790
				lin += 80
			Endif
		Next nx
	Endif

	If Len(aTxt) > 0
		cItemAnt := cItem
	Endif

	DbSelectArea("QK8")
	DbSkip()
Enddo

lin += 20
oPrint:Line( lin, 30, lin, iif(cLayout =='E',3150,3000) )   	// horizontal que vai ate o fim da pagina no looping que forma os campos. 

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Denis Martins			³ Data ³ 12.05.09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³FMEA de Processo                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i,cLayout)
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
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

oPrint:Say(050,1090,STR0001,oFont16N ) //"FMEA DE PROCESSO"
oPrint:Say(100,1360,STR0002,oFont16N ) //"FMEA DE PROCESSO"

// Box Cabecalho
If cLayout <>'E'
	oPrint:Box( 160, 30, 560, 3000 )
Else
	oPrint:Box( 160, 30, 560, 3150 ) //cLayout =='E'
Endif

// Construcao da Grade     
If cLayout <>'E'
	oPrint:Line( 240, 30, 240, 3000 )   	// horizontal
	oPrint:Line( 320, 30, 320, 3000 )   	// horizontal
	oPrint:Line( 400, 30, 400, 3000 )   	// horizontal
Else
	oPrint:Line( 240, 30, 240, 3150 )   	// horizontal
	oPrint:Line( 320, 30, 320, 3150 )   	// horizontal
	oPrint:Line( 400, 30, 400, 3150 )   	// horizontal
Endif

oPrint:Line( 240, 1020, 400, 1020 )   	// vertical
oPrint:Line( 160, 2010, 560, 2010 )   	// vertical

// Descricao cabecalho
oPrint:Say(170,0040,STR0017,oFont08) //"Item"
oPrint:Say(200,0040,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(170,2020,STR0008,oFont08) //"Numero da FMEA"
oPrint:Say(200,2020,QK7->QK7_FMEA,oFontCou08)

oPrint:Say(250,0040,STR0012,oFont08) //"Ano(s)/Modelo(s)/Programa(s)"
oPrint:Say(280,0040,QK7->QK7_ANOMOD,oFontCou08)

oPrint:Say(250,1030,STR0010,oFont08) //"Responsavel pelo Processo"
oPrint:Say(280,1030,QK7->QK7_RESPON,oFontCou08)

oPrint:Say(250,2020,STR0009,oFont08)       //"Pagina"
oPrint:Say(280,2020,StrZero(i,3),oFontCou08)

oPrint:Say(330,0040,STR0015,oFont08) //"Equipe Central"
oPrint:Say(360,0040,QK7->QK7_EQUIPE,oFontCou08)

oPrint:Say(330,1030,STR0013,oFont08) //"Data Chave"
oPrint:Say(360,1030,DtoC(QK7->QK7_DTCHAV),oFontCou08)

oPrint:Say(330,2020,STR0011,oFont08) //"Preparado Por"
oPrint:Say(360,2020,QK7->QK7_PREPOR,oFontCou08)       

oPrint:Say(430,2020,STR0060,oFont08) //"Data Fmea (Original)"
oPrint:Say(460,2020,Dtoc(QK7->QK7_DATA),oFontCou08)       

oPrint:Say(410,0040,STR0016,oFont08) //"Observacoes"

If Len(AllTrim(QK7->QK7_OBS)) <= 116
	oPrint:Say(440,0040,QK7->QK7_OBS,oFontCou08)
Else
	oPrint:Say(440,0040,Subs(QK7->QK7_OBS,1,116),oFontCou08)
	oPrint:Say(470,0040,Subs(QK7->QK7_OBS,117),oFontCou08)
Endif

// Box itens (O Box Maior)
If cLayout <>'E'
	oPrint:Box( 610, 30, 2260, 3000 )
	oPrint:Line( 820, 30, 820, 3000 )   	// horizontal
	oPrint:Say(2280,2750,STR0061+' '+Upper(cLayout),oFontCou08)
Else
	oPrint:Box( 610, 30, 2260, 3150 ) //cLayout =='E'
	oPrint:Line( 820, 30, 820, 3150 ) 
	oPrint:Say(2280,2900,STR0061+' '+Upper(cLayout),oFontCou08)
Endif

// Construcao da grade itens
If cLayout $ ' BFGDEH'
	oPrint:Line( 610, 0305, 2260, 0305 )   	// vertical - item funcao
Endif

oPrint:Line( 610, 0566, 2260, 0566 )   	// vertical - requisito
oPrint:Line( 610, 0813, 2260, 0813 )   	// vertical - modo de falha potencial
oPrint:Line( 610, 1045, 2260, 1045 )   	// vertical - severidade
oPrint:Line( 610, 1080, 2260, 1080 )   	// vertical - classificacao
oPrint:Line( 610, 1132, 2260, 1132 )   	// vertical - causa potencial de falha - 95
                                                  
oPrint:Line( 610, 1344, 2260, 1344 )   	// vertical - Controle de prevenção

If cLayout $ ' CEDH'
	oPrint:Line( 610, 1510, 2260, 1510 )   	// vertical - OCORRENCIA
Endif
If cLayout $ 'AFBG'
	oPrint:Line( 610, 1382, 2260, 1382 )   	// vertical - OCORRENCIA
Endif
oPrint:Line( 610, 1548, 2260, 1548 )   	// vertical

If cLayout <>'E'
	oPrint:Line( 610, 1701, 2260, 1701 )   	// vertical deteccao
	oPrint:Line( 610, 1752, 2260, 1752 )   	// vertical
	oPrint:Line( 610, 1823, 2260, 1823 )   	// vertical - D E T E C - final
	oPrint:Line( 610, 2115, 2260, 2115 )   	// vertical - 
	oPrint:Line( 610, 2490, 2260, 2490 )   	// vertical
Else
	oPrint:Line( 610, 1851, 2260, 1851 )   	// vertical deteccao
	oPrint:Line( 610, 1902, 2260, 1902 )   	// vertical
	oPrint:Line( 610, 1973, 2260, 1973 )   	// vertical - D E T E C - final
	oPrint:Line( 610, 2265, 2260, 2265 )   	// vertical - 
	oPrint:Line( 610, 2640, 2260, 2640 )   	// vertical
	oPrint:Line(700,1548 , 700 ,1851 )      //horizontal
	oPrint:Line( 700, 1698, 2260, 1698 )   	// vertical
Endif

If cLayout =='F'
	oPrint:Line( 610, 2350, 2260, 2350 )   	// vertical
Endif
                                                   
If cLayout <>'E'
	oPrint:Line( 675, 2490, 675, 3000 )   	// horizontal 
	oPrint:Say(630,2620,STR0062,oFont08) //"Resultado das Ações "
	oPrint:Line( 675, 2810, 2260, 2810 )   	// vertical 
	
	oPrint:Line( 675, 2850, 2260, 2850 )   	// vertical
	oPrint:Line( 675, 2890, 2260, 2890 )   	// vertical
	oPrint:Line( 675, 2930, 2260, 2930 )   	// vertical
Else
	oPrint:Line( 675, 2640, 675, 3150 )   	// horizontal 
	oPrint:Say(630,2800,STR0062,oFont08) //"Resultado das Ações "
	oPrint:Line( 675, 2960, 2260, 2960 )   	// vertical 
	
	oPrint:Line( 675, 3000, 2260, 3000 )   	// vertical
	oPrint:Line( 675, 3040, 2260, 3040 )   	// vertical
	oPrint:Line( 675, 3080, 2260, 3080 )   	// vertical
Endif

// Descricao itens
If cLayout $ ' BDFE'
	oPrint:Say(630,45,STR0004,oFont08) //"Etapa do Processo"
	oPrint:Line( 820, 30, 610, 305 )   	// diagonal ?
	oPrint:Say(740,163,STR0018,oFont08) //"Funcao"   
	oPrint:Say(680,380,STR0019,oFont08) //"Requisito"
Endif

If cLayout $ 'GH'
	oPrint:Say(630,45,STR0004,oFont08) //"Etapa do Processo"
	oPrint:Line( 820, 30, 610, 305 )   	// diagonal ?
	oPrint:Say(740,163,STR0018,oFont08) //"Funcao"   
	oPrint:Say(635,390,STR0019,oFont08) //"Requisito"
	oPrint:Line( 680, 0305, 680, 0566 )   	// horizontal
	//vertical
	oPrint:Line( 680, 380, 2260, 380 )   	// vertical
	oPrint:Line( 680, 460, 2260, 460 )   	// vertical
	oPrint:Say(740,320,STR0063,oFont08) //"ID   
	oPrint:Say(740,385,STR0064,oFont08) //"Prod.
	oPrint:Say(740,465,STR0065,oFont08) //"`Proc   
Endif

If cLayout $ 'CA'
	oPrint:Say(630,45,STR0004,oFont08) //"Etapa do Processo" 
	oPrint:Say(660,45,STR0018,oFont08) //"Funcao"
	oPrint:Line( 820, 30, 610, 566 )   	// diagonal ?
	oPrint:Say(740,420,STR0019,oFont08) //"Requisito"
Endif

oPrint:Say(640,626,STR0020,oFont08) //" Modo de "
oPrint:Say(680,647,STR0021,oFont08) //"Falha"
oPrint:Say(720,637,STR0022,oFont08) //"Potencial "

oPrint:Say(640,886,STR0023,oFont08) //" Efeito  "
oPrint:Say(680,875,STR0024,oFont08) //"Potencial"
oPrint:Say(720,876,STR0025,oFont08) //"da Falha "

oPrint:Say(640,1053,STR0026,oFont08) // "S"
oPrint:Say(665,1053,STR0027,oFont08) // "E"
oPrint:Say(690,1053,STR0028,oFont08) // "V"
oPrint:Say(715,1053,STR0029,oFont08) // "E"
oPrint:Say(740,1053,STR0030,oFont08) // "R"*/

oPrint:Say(640,1096,STR0031,oFont08) // "C"
oPrint:Say(665,1096,STR0032,oFont08) // "L"
oPrint:Say(690,1096,STR0033,oFont08) // "A" 
oPrint:Say(715,1096,STR0034,oFont08) // "S"
oPrint:Say(740,1096,STR0035,oFont08) // "S"

oPrint:Say(640,1179,STR0036,oFont08) //"Causa(s)"
oPrint:Say(680,1165,STR0037,oFont08) //"Potencial(ais)"
oPrint:Say(720,1180,STR0038,oFont08) //"de Falha"

If cLayout $ ' CEDH'
	oPrint:Say(660,1377,STR0039,oFont08) //"Controles"
	oPrint:Say(700,1377,STR0040,oFont08) //"Prevencao"
Endif

If cLayout $ 'AFBG'
	oPrint:Say(660,1395,STR0039,oFont08) //"Controles"
	oPrint:Say(700,1395,STR0040,oFont08) //"Prevencao"
Endif

If cLayout $ 'AFBG'
	oPrint:Say(640,1355,STR0041,oFont08) // "O"
	oPrint:Say(665,1355,STR0042,oFont08) // "C"
	oPrint:Say(690,1355,STR0043,oFont08) // "O"
	oPrint:Say(715,1355,STR0044,oFont08) // "R"
	oPrint:Say(740,1355,STR0044,oFont08) // "R"
Endif

If cLayout $ ' CEDH'
	oPrint:Say(640,1517,STR0041,oFont08) // "O"
	oPrint:Say(665,1517,STR0042,oFont08) // "C"
	oPrint:Say(690,1517,STR0043,oFont08) // "O"
	oPrint:Say(715,1517,STR0044,oFont08) // "R"
	oPrint:Say(740,1517,STR0044,oFont08) // "R"
Endif

If cLayout $ 'ABCDFGH'
	oPrint:Say(660,1570,STR0039,oFont08) //"Controles"
	oPrint:Say(700,1569,STR0045,oFont08) //"Deteccao" 
Endif

If cLayout =='E'
	oPrint:Say(625,1625,STR0066,oFont08) //"Controles de"
	oPrint:Say(665,1605,STR0067,oFont08) //"Processo Atuais"
	oPrint:Say(760,1580,STR0068,oFont08) //"Causa
	oPrint:Say(740,1720,STR0069,oFont08) //"Modos de 
	oPrint:Say(770,1730,STR0070,oFont08) //"Falha
Endif

If cLayout =='E'
	oPrint:Say(640,1862,STR0046,oFont08) // "D"
	oPrint:Say(665,1862,STR0047,oFont08) // "E"
	oPrint:Say(690,1862,STR0048,oFont08) // "T"
	oPrint:Say(715,1862,STR0049,oFont08) // "E"
	oPrint:Say(740,1862,STR0050,oFont08) // "C"
	
	oPrint:Say(660,1923,STR0051,oFont08) // "N"
	oPrint:Say(685,1923,STR0052,oFont08) // "P"
	oPrint:Say(710,1923,STR0053,oFont08) // "R"
	
	oPrint:Say(660,2073,STR0054,oFont08) //"     Acoes  "
	oPrint:Say(700,2028,STR0055,oFont08) //"Recomendadas"
Else
	oPrint:Say(640,1717,STR0046,oFont08) // "D"
	oPrint:Say(665,1717,STR0047,oFont08) // "E"
	oPrint:Say(690,1717,STR0048,oFont08) // "T"
	oPrint:Say(715,1717,STR0049,oFont08) // "E"
	oPrint:Say(740,1717,STR0050,oFont08) // "C"
	
	oPrint:Say(660,1773,STR0051,oFont08) // "N"
	oPrint:Say(685,1773,STR0052,oFont08) // "P"
	oPrint:Say(710,1773,STR0053,oFont08) // "R"
	
	oPrint:Say(660,1923,STR0054,oFont08) //"     Acoes  "
	oPrint:Say(700,1888,STR0055,oFont08) //"Recomendadas"
Endif

If cLayout $ ' ABCDGH'
	oPrint:Say(660,2195,STR0056,oFont08) //"Responsabilidade"
	oPrint:Say(700,2195,STR0057,oFont08) //"Data de Conclusao"
Endif

If cLayout =='E'
	oPrint:Say(660,2345,STR0056,oFont08) //"Responsabilidade"
	oPrint:Say(700,2345,STR0057,oFont08) //"Data de Conclusao"
Endif

If cLayout =='F'
	oPrint:Say(680,2150,STR0071,oFont08) //"Responsavel"
	
	oPrint:Say(660,2360,STR0072,oFont08) // "Data de"
	oPrint:Say(685,2360,STR0073,oFont08) // "Conclusão
	oPrint:Say(710,2360,STR0074,oFont08) // "pretendida"
Endif

If cLayout $ ' ABCDGH'
	oPrint:Say(730,2518,STR0058,oFont08) //"Acoes Implementadas"
Endif

If cLayout =='F'
	oPrint:Say(730,2550,STR0075,oFont08) //"Acoes"
	oPrint:Say(750,2500,STR0076,oFont08) //"Implementadas"
	oPrint:Line( 675, 2685, 2260, 2680 )   	// vertical           
	oPrint:Say(730,2710,STR0077,oFont08) //" Data
	oPrint:Say(752,2705,STR0078,oFont08) //" Efetiva
Endif

If cLayout =='E'
	oPrint:Say(730,2668,STR0058,oFont08) //"Acoes Implementadas"
Endif

If cLayout <>'E'
	oPrint:Say(680,2825,STR0026,oFont08) // "S"
	oPrint:Say(705,2825,STR0027,oFont08) // "E"
	oPrint:Say(730,2825,STR0028,oFont08) // "V"
	oPrint:Say(755,2825,STR0029,oFont08) // "E"
	oPrint:Say(780,2825,STR0030,oFont08) // "R"
	                                 
	oPrint:Say(680,2865,STR0041,oFont08) // "O"
	oPrint:Say(705,2865,STR0042,oFont08) // "C"
	oPrint:Say(730,2865,STR0043,oFont08) // "O"
	oPrint:Say(755,2865,STR0044,oFont08) // "R"
	oPrint:Say(780,2865,STR0044,oFont08) // "R"
	
	oPrint:Say(680,2897,STR0046,oFont08) // "D"
	oPrint:Say(705,2897,STR0047,oFont08) // "E"
	oPrint:Say(730,2897,STR0048,oFont08) // "T"
	oPrint:Say(755,2897,STR0049,oFont08) // "E"
	oPrint:Say(780,2897,STR0050,oFont08) // "C"
	
	oPrint:Say(700,2950,STR0051,oFont08) // "N"
	oPrint:Say(725,2950,STR0052,oFont08) // "P"
	oPrint:Say(750,2950,STR0053,oFont08) // "R"
Else
	oPrint:Say(680,2979,STR0026,oFont08) // "S"
	oPrint:Say(705,2979,STR0027,oFont08) // "E"
	oPrint:Say(730,2979,STR0028,oFont08) // "V"
	oPrint:Say(755,2979,STR0029,oFont08) // "E"
	oPrint:Say(780,2979,STR0030,oFont08) // "R"
	                                 
	oPrint:Say(680,3018,STR0041,oFont08) // "O"
	oPrint:Say(705,3018,STR0042,oFont08) // "C"
	oPrint:Say(730,3018,STR0043,oFont08) // "O"
	oPrint:Say(755,3018,STR0044,oFont08) // "R"
	oPrint:Say(780,3018,STR0044,oFont08) // "R"
	
	oPrint:Say(680,3047,STR0046,oFont08) // "D"
	oPrint:Say(705,3047,STR0047,oFont08) // "E"
	oPrint:Say(730,3047,STR0048,oFont08) // "T"
	oPrint:Say(755,3047,STR0049,oFont08) // "E"
	oPrint:Say(780,3047,STR0050,oFont08) // "C"
	
	oPrint:Say(730,3100,STR0051,oFont08) // "N"
	oPrint:Say(755,3100,STR0052,oFont08) // "P"
	oPrint:Say(780,3100,STR0053,oFont08) // "R"
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
