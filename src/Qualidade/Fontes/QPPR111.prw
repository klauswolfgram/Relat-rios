/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR111.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "COLORS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                       
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR111  ³ Autor ³ Cleber Souza          ³ Data ³ 11/08/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma  (                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR111(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 			 ³		  ³      ³ 										  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QPPR111(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte   := .F.
Local cStartPath  := GetSrvProfString("Startpath","")      

Private axTex     := {}
Private cTextRet  := ""
Private cPecaRev  := ""

Default lBrow 		:= .F.
Default cPecaAuto	:= "" 
Default cJPEG       := ""

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif  

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif 

PPAPBMP("VD.BMP",cStartPath)
PPAPBMP("VM.BMP",cStartPath)
PPAPBMP("AM.BMP",cStartPath)

oPrint := TMSPrinter():New(STR0001) //"Cronograma - APQP"
oPrint:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA111"
		cPecaRev := Iif(!lBrow,M->QKG_PECA + M->QKG_REV,QKG->QKG_PECA + QKG->QKG_REV)
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

DbSelectArea("QKG")
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

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontaRel ³ Autor ³ Cleber Souza          ³ Data ³ 11/08/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR111                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i 	  := 1, nCont := 0
Local lin 	  := 0, linAnt
Local nx
Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont07		:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",07,07,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",06,06,,.F.,,,,.T.,.F.)

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
lin    := 460
linAnt := lin
DbSelectArea("QKP")
DbSetOrder(2)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKP->QKP_PECA+QKP->QKP_REV == cPecaRev

	nCont++ 
	
	If lin > 2200
		nCont := 1
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 460
	Endif

	lin += 15
	oPrint:Say(lin,0036,QKP->QKP_SEQ,oFontCou08)
	oPrint:Say(lin,0090,Subs(QKP->QKP_ATIV,1,30),oFontCou08)

	QAA->(DbSetOrder(1))
	If QAA->(DbSeek(QKP->QKP_FILMAT + QKP->QKP_MAT))
		oPrint:Say(lin,0680,Subs(QAA->QAA_NOME,1,25),oFontCou08)
	Endif
             
	oPrint:Say(lin,1080,Dt4To2(QKP->QKP_DTINI) ,oFontCou08)
	oPrint:Say(lin,1230,Dt4To2(QKP->QKP_DTFIM) ,oFontCou08)
	oPrint:Say(lin,1380,Dt4To2(QKP->QKP_DTPRAI),oFontCou08)
	oPrint:Say(lin,1530,Dt4To2(QKP->QKP_DTPRA) ,oFontCou08)

	oPrint:Say(lin,1680,IIF(QKP->QKP_RISCO=="S","SIM","NAO") ,oFontCou08)
	                          
	If !Empty(QKP->QKP_CHAVE)
		lImpObs:=.F.
		axTex := {}
		cTextRet := ""
		cTextRet := QO_Rectxt(QKP->QKP_CHAVE,"QPPA110 ",1,TamSX3("QKO_TEXTO")[1],"QKO")
		axTex := Q_MemoArray(cTextRet,axTex,85)

		For nx :=1 To Len(axTex)
			If !Empty(axTex[nx])
				If lin > 2200
					nCont := 1
					i++
					oPrint:EndPage() 		// Finaliza a pagina
					Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 460
				Endif
				oPrint:Say(lin,1910,axTex[nx],oFontCou08)
				lin += 25 
				lImpObs:=.T.
			Endif
		Next nx
		If !lImpObs
			lin += 25
		EndIf	
	Else	
		lin += 25
	Endif
    
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
	
	//Imprime a legenda do Previsto
    If QKP->QKP_RISPRE == "VD"
		oPrint:SayBitmap(linAnt+2,1783, "VD.BMP",56,40)
    ElseIf QKP->QKP_RISPRE == "VM"
   		oPrint:SayBitmap(linAnt+2,1783, "VM.BMP",56,40)
    Else
  		oPrint:SayBitmap(linAnt+2,1783, "AM.BMP",56,40)
	EndIf                           
	
	//Imprime a legenda do Realizado
    If QKP->QKP_RISREA == "VD"
		oPrint:SayBitmap(linAnt+2,1843, "VD.BMP",56,40)
    ElseIf QKP->QKP_RISREA == "VM"
   		oPrint:SayBitmap(linAnt+2,1843, "VM.BMP",56,40)
    Else
  		oPrint:SayBitmap(linAnt+2,1843, "AM.BMP",56,40)
	EndIf                           
	
	linAnt := lin

	DbSelectArea("QKP")                                            
	DbSkip()

Enddo

If !Empty(QKG->QKG_CHAVE)      

	lin += 20
	oPrint:Say(lin,0035,Repl("*",03),oFontCou08)
	oPrint:Say(lin,0090,Repl("*",40),oFontCou08)
	oPrint:Say(lin,0680,Repl("*",29),oFontCou08)
	oPrint:Say(lin,1080,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1230,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1380,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1530,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1680,Repl("*",04),oFontCou08)   
	oPrint:Say(lin,1786,Repl("*",03),oFontCou08)  
	oPrint:Say(lin,1846,Repl("*",03),oFontCou08)  
	
	oPrint:Say(lin,1910,STR0003,oFont08)	 //"OBSERVACOES GERAIS DO CRONOGRAMA"
	lin += 60

	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKG->QKG_CHAVE,"QPPA110A",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,85)

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2200
				nCont := 1
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
				lin := 460
			Endif
			oPrint:Say(lin,1910,axTex[nx],oFontCou08)
			lin += 25
		Endif
	Next nx

Endif

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Cleber Souza          ³ Data ³ 11/08/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR111                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local cStartPath := GetSrvProfString("Startpath","")

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, cStartPath+"\Logo.bmp",237,58)

oPrint:Say(050,1350,STR0001,oFont16 ) //"CRONOGRAMA - APQP"

// Box Cabecalho
oPrint:Box( 160, 30, 320, 3000 )

// Construcao da Grade
oPrint:Line( 240, 30, 240, 3000 )   	// horizontal

oPrint:Line( 160, 0510, 240, 0510 )   	// vertical
oPrint:Line( 160, 1020, 320, 1020 )   	// vertical

oPrint:Line( 160, 2010, 320, 2010 )   	// vertical
oPrint:Line( 160, 2800, 320, 2800 )   	// vertical
                                                   
// Descricao cabecalho
oPrint:Say(170,0040,STR0004,oFont08)  //"Numero da Peca(Cliente)"
oPrint:Say(200,0040,Subs(QK1->QK1_PCCLI,1,28),oFontCou08)

oPrint:Say(170,0520,STR0005,oFont08) //"Rev/Data do Desenho"
oPrint:Say(200,0520,AllTrim(QK1->QK1_REVDES)+" "+Dt4To2(QK1->QK1_DTRDES),oFontCou08)

oPrint:Say(170,1030,STR0006,oFont08) //"Nome da Peca"
oPrint:Say(200,1030,AllTrim(Subs(QK1->QK1_DESC,1,55)),oFontCou08)

oPrint:Say(170,2020,STR0007,oFont08) //"Cliente"
oPrint:Say(200,2020,SA1->A1_NOME,oFontCou08)

oPrint:Say(170,2810,STR0008,oFont08) //"Pagina"
oPrint:Say(200,2810,StrZero(i,3),oFontCou08)

oPrint:Say(250,0040,STR0009,oFont08) //"Fornecedor"
oPrint:Say(280,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(250,1030,STR0010,oFont08) //"Aprovado Por"

QAA->(DbSetOrder(1))
If QAA->(DbSeek(QKG->QKG_FILRES + QKG->QKG_RESP))
	oPrint:Say(280,1030,Subs(QAA->QAA_NOME,1,40),oFontCou08)
Endif

oPrint:Say(250,2020,STR0011,oFont08) //"Numero/Rev Peca(Fornecedor)"
oPrint:Say(280,2020,AllTrim(QKG->QKG_PECA)+" "+QKG->QKG_REV,oFontCou08)

oPrint:Say(250,2810,STR0012,oFont08) //"Data"
oPrint:Say(280,2810,Dt4To2(QKG->QKG_DATA),oFontCou08)
                                    
// Box Previsto x Realizado
oPrint:Box( 360, 1070, 410, 1670 )
oPrint:Line(360, 1370, 410, 1370 )       // vertical

oPrint:Say(370,1175,STR0021,oFont08)    //"Previsto"
oPrint:Say(370,1470,STR0022,oFont08)    //"Realizado"

// Box itens
oPrint:Box( 410,0030, 2260, 3000 )

oPrint:Say(420,0035,"Seq",oFont08) //"Seq"
oPrint:Say(420,0090,STR0013,oFont08) //"Atividade"
oPrint:Say(420,0680,STR0014,oFont08) //"Responsavel"
oPrint:Say(420,1080,STR0015,oFont08) //"Inicio"  ->Previsto
oPrint:Say(420,1230,STR0016,oFont08) //"Fim"
oPrint:Say(420,1380,STR0015,oFont08) //"Inicio"  ->Realizado
oPrint:Say(420,1530,STR0016,oFont08) //"Fim"
oPrint:Say(420,1680,STR0017,oFont08) //"Risco"
oPrint:Say(420,1786,STR0018,oFont08) //"Prev"
oPrint:Say(420,1846,STR0020,oFont08) //"Real"
oPrint:Say(420,1910,STR0019,oFont08) //"Observacoes"

oPrint:Line( 460, 30, 460, 3000 )   	// horizontal

oPrint:Line(410, 0080, 2260, 0080)   	// vertical
oPrint:Line(410, 0670, 2260, 0670)   	// vertical
oPrint:Line(410, 1070, 2260, 1070)   	// vertical
oPrint:Line(410, 1220, 2260, 1220)   	// vertical
oPrint:Line(410, 1370, 2260, 1370)   	// vertical
oPrint:Line(410, 1520, 2260, 1520)   	// vertical
oPrint:Line(410, 1670, 2260, 1670)   	// vertical
oPrint:Line(410, 1780, 2260, 1780)   	// vertical
oPrint:Line(410, 1840, 2260, 1840)   	// vertical
oPrint:Line(410, 1900, 2260, 1900)   	// vertical

Return Nil
