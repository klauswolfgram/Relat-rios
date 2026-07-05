/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr860.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR860  ³ Autor ³ Thiago Olis Machado   ³ Data ³ 04.08.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio GERAL do Laudo Ambienta.                          ³±±
±±³          ³Este programa emite relatorio do Laudo Ambiental.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR860
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)
  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR860"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio do Laudo Ambiental                                         "
LOCAL cDesc2  := STR0002 //"Atraves dos parametros selecionar os itens que devem ser considerados"
LOCAL cDesc3  := STR0003 //"no Relatorio.                                                        "
LOCAL cString := "TO0"

PRIVATE nomeprog := "MDTR860"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 1, 2, 1, "",1 } //### //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Laudo Ambiental"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    :=""
PRIVATE cabec1, cabec2             
PRIVATE _cFuncao                   

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cPerg    := If(!lSigaMdtps,"MDT860    ","MDT860PS  ")

cabec1 := " " 
cabec2 := " "

/*-----------------------
//PADRÃO					|
| De Laudo ?				|
| Ate Laudo ?				|
| De Data ?				|
| Ate Data ?				|
| Listar Descricao ?		|
| 							|
//PRESTADOR				|
| De Cliente ?			|
| Loja						|
| Até Cliente ?			|
| Loja						|
| De Laudo ?				|
| Ate Laudo ?				|
| De Data ?				|
| Ate Data ?				|
| Listar Descricao ?		|
-------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
    Set Filter to
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Set Filter to
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
   Return
Endif

RptStatus({|lEnd| R860Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R860Imp  ³ Autor ³ Thiago Olis Machado   ³ Data ³ 04/08/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR860                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R860Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1 ,cMes := ' '        

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

DEFINE FONT oFont NAME "Arial" SIZE 0, -12 BOLD

If lSigaMdtps

	dbSelectArea("TO0")
	dbSetOrder(06)  //TO0_FILIAL+TO0_CLIENT+TO0_LOJA+TO0_LAUDO
	dbSeek(xFilial("TO0")+mv_par01+mv_par02,.t.) 
	
	SetRegua(LastRec())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TO0 para ler o  Laudo Selecionado                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	IncRegua()
	
	While !EOF() .and. TO0->(TO0_CLIENT+TO0_LOJA) <= mv_par03+mv_par04
		
		if TO0->TO0_LAUDO < mv_par05 .OR. TO0->TO0_LAUDO > mv_par06
			dbSelectArea("TO0")
			dbSkip()
			Loop
		EndIf	
		
		Somalinha()
		Li := 08
		
		@ Li,000 PSay STR0051 + Alltrim(TO0->TO0_LAUDO) + " - " + TO0->TO0_NOME //"LAUDO: "
		
		Li += 3                     
		nDia := Day(TO0->TO0_DTINIC)
		cMes := U_NGRETDATA(TO0->TO0_DTINIC)
		nAno := Year(TO0->TO0_DTINIC)
		@ Li,000 PSay STR0052 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Dt. Inicio: "###" de "###" de "
		
		nDia := Day(TO0->TO0_DTFIM)
		cMes := U_NGRETDATA(TO0->TO0_DTFIM)
		nAno := Year(TO0->TO0_DTFIM)
		@ Li,065 PSay STR0053 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Dt. Fim: "###" de "###" de "
		
		LI++
		dbSelectArea("SA1")
		dbSetOrder(01)
		dbSeek(xFilial("SA1")+TO0->TO0_CLIENT)
		@ Li,000 PSay STR0054 + Alltrim(TO0->TO0_CLIENT) + " - " + Alltrim(SA1->A1_NOME) //"Cliente: "
		@ Li,065 PSay STR0055 + Alltrim(str(TO0->TO0_QTDFUN,5)) //"Qtd. Funcionários: "
		
		LI++
		dbSelectArea("TMK")
		dbSetOrder(01)
		dbSeek(xFilial("TMK")+TO0->TO0_CODUSU)
		cFuncao := TMK->TMK_INDFUN
		U_DESCFUN860(cFuncao)
		@ Li,000 PSay Substr(STR0056 + Alltrim(TMK->TMK_NOMUSU) + " - " + _cFuncao,1,63) //"Responsavel: "
		dbSelectArea("TMZ")
		dbSetOrder(01)
		dbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
		@ Li,065 PSay STR0057 + TMZ->TMZ_NOMTER //"Termo de Responsabilidade: "
		
		LI++                                                                      
		@ Li,000 PSay STR0058 + Alltrim(TO0->TO0_GRISCO) //"Grau de Risco: "
		nDia := Day(TO0->TO0_DTVALI)
		cMes := U_NGRETDATA(TO0->TO0_DTVALI)
		nAno := Year(TO0->TO0_DTVALI)
		@ Li,065 PSay STR0059 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Data de Avaliacao: "###" de "###" de "
		
		Li++
		@ Li,000 PSay STR0060 + Alltrim(TO0->TO0_OBJETI) //"Objetivo: "
		
		Somalinha()  
		SomaLinha()
		
		If mv_par09 == 1
			cMemo := Alltrim(TO0->TO0_DESCRI)
			If !Empty(TO0->TO0_MMSYP2)
				cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
				If !Empty(cMMSYP2)
					If !Empty(cMemo)
						cMemo += Chr(13)+Chr(10)
					Endif
					cMemo += cMMSYP2
				Endif
			Endif
			Somalinha()	               
			@ Li,000 PSay STR0061 //"DESCRIÇÃO: "
			Somalinha()
			lEof := .t.	
			While lEof
				If Empty(cMemo)  //Memo vazio
					lEof := .f.
					Exit
				Else
					nPos1 := At("#",cMemo) //Inicio de um Titulo
				
					If nPos1 > 1   
						cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo  := Alltrim(Substr(cMemo,nPos1))	 
						U_IMPDOC860(Alltrim(cTexto))
						Loop
					ElseIf nPos1 == 1 //Existe #
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						nPos1   := At("#",cMemo)
						cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						
						nPos1   := At("#",cMemo)
						If nPos1 > 0
							cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
							cMemo  := Alltrim(Substr(cMemo,nPos1))
						Else
							cTexto := Alltrim(cMemo)
							cMemo  := " "
							lEof   := .f.
						Endif
					
					Else //Nao existe #
						//IMPRIME TEXTO
						U_IMPDOC860(Alltrim(cMemo))
						lEof := .f. 
						Exit			
					Endif
				
					//IMPRIME TITULO
					If !Empty(cTitulo)  
						If ("{" $ cTitulo) .and.  ("}" $ cTitulo)
							nPosTemp := At("}",cTitulo)
							cCNS     := Substr(cTitulo,1,nPosTemp)
							cTitulo := Substr(cTitulo,nPosTemp+1)
						Endif
						Somalinha()
						@ Li,000 Psay Substr(Alltrim(cTitulo),1,78)
						Somalinha()
					Endif	
			
					//IMPRIME TEXTO
					If !Empty(cTexto)    
						lPrint := .t.
						lPrin2 := .t.
						U_IMPDOC860(Alltrim(cTexto)) 
					Endif	
				EndIf
			End
		EndIf
	dbSelectArea("TO0")
	dbSkip()
	End	

Else

	dbSelectArea("TO0")
	dbSetOrder(01)
	dbGoTop() 
	
	SetRegua(LastRec())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TO0 para ler o  Laudo Selecionado                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	IncRegua()
	
	While !EOF()
		
		if TO0->TO0_LAUDO < mv_par01 .OR. TO0->TO0_LAUDO > mv_par02
			dbSelectArea("TO0")
			dbSkip()
			Loop
		EndIf	
		
		Somalinha()
		Li := 08
		
		@ Li,000 PSay STR0051 + Alltrim(TO0->TO0_LAUDO) + " - " + TO0->TO0_NOME //"LAUDO: "
		
		Li += 3                     
		nDia := Day(TO0->TO0_DTINIC)
		cMes := U_NGRETDATA(TO0->TO0_DTINIC)
		nAno := Year(TO0->TO0_DTINIC)
		@ Li,000 PSay STR0052 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Dt. Inicio: "###" de "###" de "
		
		nDia := Day(TO0->TO0_DTFIM)
		cMes := U_NGRETDATA(TO0->TO0_DTFIM)
		nAno := Year(TO0->TO0_DTFIM)
		@ Li,065 PSay STR0053 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Dt. Fim: "###" de "###" de "
		
		LI++
		dbSelectArea("SA1")
		dbSetOrder(01)
		dbSeek(xFilial("SA1")+TO0->TO0_CLIENT)
		@ Li,000 PSay STR0054 + Alltrim(TO0->TO0_CLIENT) + " - " + Alltrim(SA1->A1_NOME) //"Cliente: "
		@ Li,065 PSay STR0055 + Alltrim(str(TO0->TO0_QTDFUN,5)) //"Qtd. Funcionários: "
		
		LI++
		dbSelectArea("TMK")
		dbSetOrder(01)
		dbSeek(xFilial("TMK")+TO0->TO0_CODUSU)
		cFuncao := TMK->TMK_INDFUN
		U_DESCFUN860(cFuncao)
		@ Li,000 PSay Substr(STR0056 + Alltrim(TMK->TMK_NOMUSU) + " - " + _cFuncao,1,63) //"Responsavel: "
		dbSelectArea("TMZ")
		dbSetOrder(01)
		dbSeek(xFilial("TMZ")+TO0->TO0_TERMO)
		@ Li,065 PSay STR0057 + TMZ->TMZ_NOMTER //"Termo de Responsabilidade: "
		
		LI++                                                                      
		@ Li,000 PSay STR0058 + Alltrim(TO0->TO0_GRISCO) //"Grau de Risco: "
		nDia := Day(TO0->TO0_DTVALI)
		cMes := U_NGRETDATA(TO0->TO0_DTVALI)
		nAno := Year(TO0->TO0_DTVALI)
		@ Li,065 PSay STR0059 + alltrim(str(nDia)) + STR0015 + AllTrim(cMes) + STR0015 + AllTrim(Str(nAno)) //"Data de Avaliacao: "###" de "###" de "
		
		Li++
		@ Li,000 PSay STR0060 + Alltrim(TO0->TO0_OBJETI) //"Objetivo: "
		
		Somalinha()  
		SomaLinha()
		
		If mv_par05 == 1
			cMemo := Alltrim(TO0->TO0_DESCRI)
			If !Empty(TO0->TO0_MMSYP2)
				cMMSYP2 := MSMM(TO0->TO0_MMSYP2,80)
				If !Empty(cMMSYP2)
					If !Empty(cMemo)
						cMemo += Chr(13)+Chr(10)
					Endif
					cMemo += cMMSYP2
				Endif
			Endif
			Somalinha()	               
			@ Li,000 PSay STR0061 //"DESCRIÇÃO: "
			Somalinha()
			lEof := .t.	
			While lEof
				If Empty(cMemo)  //Memo vazio
					lEof := .f.
					Exit
				Else
					nPos1 := At("#",cMemo) //Inicio de um Titulo
				
					If nPos1 > 1   
						cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo  := Alltrim(Substr(cMemo,nPos1))	 
						U_IMPDOC860(Alltrim(cTexto))
						Loop
					ElseIf nPos1 == 1 //Existe #
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						nPos1   := At("#",cMemo)
						cTitulo := Alltrim(Substr(cMemo,1,nPos1-1))
						cMemo   := Alltrim(Substr(cMemo,nPos1+1))
						
						nPos1   := At("#",cMemo)
						If nPos1 > 0
							cTexto := Alltrim(Substr(cMemo,1,nPos1-1))
							cMemo  := Alltrim(Substr(cMemo,nPos1))
						Else
							cTexto := Alltrim(cMemo)
							cMemo  := " "
							lEof   := .f.
						Endif
					
					Else //Nao existe #
						//IMPRIME TEXTO
						U_IMPDOC860(Alltrim(cMemo))
						lEof := .f. 
						Exit			
					Endif
				
					//IMPRIME TITULO
					If !Empty(cTitulo)  
						If ("{" $ cTitulo) .and.  ("}" $ cTitulo)
							nPosTemp := At("}",cTitulo)
							cCNS     := Substr(cTitulo,1,nPosTemp)
							cTitulo := Substr(cTitulo,nPosTemp+1)
						Endif
						Somalinha()
						@ Li,000 Psay Substr(Alltrim(cTitulo),1,78)
						Somalinha()
					Endif	
			
					//IMPRIME TEXTO
					If !Empty(cTexto)    
						lPrint := .t.
						lPrin2 := .t.
						U_IMPDOC860(Alltrim(cTexto)) 
					Endif	
				EndIf
			End
		EndIf
	dbSelectArea("TO0")
	dbSkip()
	End	

Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TO0")
Set Filter To
Set device to Screen
If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
MS_FLUSH()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³DESCFUN860³ Autor ³ Liber de Esteban      ³ Data ³ 03/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Identifica e retorna a descricao da funcao.                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function DESCFUN860(cFuncao)	
_cFuncao := " "
IF cFuncao = "1"
    _cFuncao := STR0022 //"Medico do Trabalho"
ElseIF cFuncao = "2"                                                                 
	_cFuncao := STR0023 //"Enfermeiro do Trabalho"
ElseIF cFuncao = "3"                                                                  
	_cFuncao := STR0024 //"Auxiliar de Enfermagem"
ElseIF cFuncao = "4"                                                                  
	_cFuncao := STR0025 //"Engenheiro de Segurancao do Trabalho"
ElseIF cFuncao = "5"                                                                  
	_cFuncao := STR0026 //"Tecnico de Segurancao do Trabalho"
ElseIF cFuncao = "6"                                            
	_cFuncao := STR0027 //"Medico"
ElseIF cFuncao = "7"         
	_cFuncao := STR0028                                    //"Enfermeiro"
ElseIF cFuncao = "8"         
	_cFuncao := STR0024 //"Auxiliar de Enfermagem"
ElseIF cFuncao = "9"                                            
	_cFuncao := STR0029 //"Outros"
EndIf                  

Return _cFuncao

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³IMPDOC860 ³ Autor ³ Liber de Esteban      ³ Data ³ 03/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³IMPRIME O CONTEUDO DO TEXTO                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IMPDOC860(cText)

Local lTexto := .t. 
Local nPosTxt := 0
Local cTitExe
Local cTextoNew := cText
Local cTxtMemo := cText
Local nArroba, LinhaCor
//Imprime texto         
 
lJumpCab := .f. //Somalinha do Titulo de Relatorio

While lTexto                                      
	nArroba := At("@",cTxtMemo)

	If nArroba > 1
		cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))	 
		U_IMPDOC860(Alltrim(cTextoNew))
		Loop	
	ElseIf nArroba == 1 //Existe @
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
		nArroba  := At("@",cTxtMemo)
		cTitExe  := Alltrim(Substr(cTxtMemo,1,nArroba-1))
		cTxtMemo := Alltrim(Substr(cTxtMemo,nArroba+1))
			
		nArroba   := At("@",cTxtMemo)
		If nArroba > 0
			cTextoNew := Alltrim(Substr(cTxtMemo,1,nArroba-1))
			cTxtMemo  := Alltrim(Substr(cTxtMemo,nArroba))    
			U_IMPDOC860(Alltrim(cTextoNew)) 
			Loop
		Endif
	Endif	
	
	If (nPosTxt := At(Chr(13)+Chr(10),cTxtMemo)) == 0
		lTexto := .f.
		cTextoNew :=  Alltrim(cTxtMemo)
	Else
		cTextoNew :=  Alltrim(Substr(cTxtMemo,1,nPosTxt-1))
		cTxtMemo  :=  Alltrim(Substr(cTxtMemo,nPosTxt+2))				    
	Endif
	
	If !Empty(cTextoNew)                          
		lPrimeiro := .t.
		nLinhasMemo := MLCOUNT(cTextoNew,120)
		@ Li,000 PSAY cTitexe
		Somalinha()
		For LinhaCor := 1 to nLinhasMemo
		    If lPrimeiro
				@ Li,000 PSAY (MemoLine(cTextoNew,120,LinhaCor))
				lPrimeiro := .f.
			Else
				@ Li,000 PSAY (MemoLine(cTextoNew,120,LinhaCor))
			EndIf   
			Somalinha()
		Next LinhaCor		
	EndIf
End    
Return .t.

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
Static Function Somalinha()
	Li++
    If Li > 58
    	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo,,.f.)
    EndIf
Return        

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³NGRETDATA ³ Autor ³ Liber de Esteban      ³ Data ³ 03/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Identifica e retorna o nome do mes.                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NGRETDATA(dData) 

nMEs := Month(dData)
cMes := ' '                             
If nMes = 01
   cMes := STR0031 //"Janeiro"
ElseIf nMes = 02
   cMes := STR0032	 //"Fevereiro"
ElseIf nMes = 03
   cMes := STR0033 //"Marco"
ElseIf nMes = 04
   cMes := STR0034 //"Abril"
ElseIf nMes = 05
   cMes := STR0035 //"Maio"
ElseIf nMes = 06
   cMes := STR0036 //"Junho"
ElseIf nMes = 07
   cMes := STR0037 //"Julho"
ElseIf nMes = 08
   cMes := STR0038 //"Agosto"
ElseIf nMes = 09
   cMes := STR0039 //"Setembro"
ElseIf nMes = 10
   cMes := STR0040 //"Outubro"
ElseIf nMes = 11
   cMes := STR0041 //"Novembro"
ElseIf nMes = 12
   cMes := STR0042 //"Dezembro"
EndIf      

Return cMes