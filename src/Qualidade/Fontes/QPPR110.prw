/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR110.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR110  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 24.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR110(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³24.04.02³META  ³ Troca do Alias da familia SR para QA   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR110(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F. 
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev	:= ""
Private axTex 		:= {}
Private cTextRet	:= ""

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""    

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Cronograma - APQP"

oPrint:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA110"
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

PPAPBMP("ENABLE_OCEAN.BMP",cStartPath)
PPAPBMP("BR_AMARELO_OCEAN.BMP",cStartPath)
PPAPBMP("DISABLE_OCEAN.BMP",cStartPath)
PPAPBMP("BR_CINZA_OCEAN.BMP",cStartPath)

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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 24.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i := 1, nCont := 0
Local lin
Local nx := 1
Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
lin := 500

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
		lin := 500
	Endif

	lin += 40
	oPrint:SayBitmap(lin-70,40, AllTrim(QKP->QKP_LEGEND)+"_OCEAN.BMP",50,50)

	oPrint:Say(lin,0040,Subs(QKP->QKP_ATIV,1,30),oFontCou08)

	QAA->(DbSetOrder(1))
	If QAA->(DbSeek(QKP->QKP_FILMAT + QKP->QKP_MAT))
		oPrint:Say(lin,0630,Subs(QAA->QAA_NOME,1,25),oFontCou08)
	Endif

	oPrint:Say(lin,1110,U_Dt4To2(QKP->QKP_DTINI),oFontCou08)
	oPrint:Say(lin,1260,U_Dt4To2(QKP->QKP_DTFIM),oFontCou08)
	oPrint:Say(lin,1410,U_Dt4To2(QKP->QKP_DTPRA),oFontCou08)

	Do Case
		Case QKP->QKP_PCOMP == "0"; oPrint:Say(lin,1560,"  0.00 %",oFontCou08)
		Case QKP->QKP_PCOMP == "1"; oPrint:Say(lin,1560," 25.00 %",oFontCou08)
		Case QKP->QKP_PCOMP == "2"; oPrint:Say(lin,1560," 50.00 %",oFontCou08)
		Case QKP->QKP_PCOMP == "3"; oPrint:Say(lin,1560," 75.00 %",oFontCou08)
		Case QKP->QKP_PCOMP == "4"; oPrint:Say(lin,1560,"100.00 %",oFontCou08)
	EndCase
	
	If !Empty(QKP->QKP_CHAVE)
		DbSelectArea("QKO")
		DbSetOrder(1)

		axTex := {}
		cTextRet := ""
		cTextRet := QO_Rectxt(QKP->QKP_CHAVE,"QPPA110 ",1,TamSX3("QKO_TEXTO")[1],"QKO")
		axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

		For nx :=1 To Len(axTex)
			If !Empty(axTex[nx])
				If lin > 2200
					nCont := 1
					i++
					oPrint:EndPage() 		// Finaliza a pagina
					Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
					lin := 500
				Endif
				oPrint:Say(lin,1710,axTex[nx],oFontCou08)
				lin += 40
			Endif
		Next nx
	Endif
    
	lin += 40
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
	lin += 40
	
	DbSelectArea("QKP")                                            
	DbSkip()

Enddo


If !Empty(QKG->QKG_CHAVE)

	lin += 40
	oPrint:Say(lin,0040,Repl("*",30),oFontCou08)
	oPrint:Say(lin,0630,Repl("*",25),oFontCou08)
	oPrint:Say(lin,1110,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1260,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1410,Repl("*",08),oFontCou08)
	oPrint:Say(lin,1560,Repl("*",08),oFontCou08)
	oPrint:Say(lin,2030,STR0003,oFont08)	 //"OBSERVACOES GERAIS DO CRONOGRAMA"
	lin += 80

	DbSelectArea("QKO")
	DbSetOrder(1)

	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKG->QKG_CHAVE,"QPPA110A",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			If lin > 2200
				nCont := 1
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
				lin := 500
			Endif
			oPrint:Say(lin,1710,axTex[nx],oFontCou08)
			lin += 40
		Endif
	Next nx
Endif

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 24.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cronograma                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial 

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58)

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
oPrint:Say(200,0520,AllTrim(QK1->QK1_REVDES)+" "+U_Dt4To2(QK1->QK1_DTRDES),oFontCou08)

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
oPrint:Say(280,2810,U_Dt4To2(QKG->QKG_DATA),oFontCou08)
                                    
oPrint:SayBitmap(330,40, "ENABLE_OCEAN.BMP",40,40)
oPrint:Say(330,100,STR0020,oFont08) //"Atividade em dia"

oPrint:SayBitmap(330,1000, "BR_AMARELO_OCEAN.BMP",40,40)
oPrint:Say(330,1060,STR0021,oFont08) //"Atividade Expirando nos proximos dias"

oPrint:SayBitmap(330,1740, "DISABLE_OCEAN.BMP",40,40)
oPrint:Say(330,1800,STR0022,oFont08) //"Atividade Atrasada"

oPrint:SayBitmap(330,2480, "BR_CINZA_OCEAN.BMP",40,40)
oPrint:Say(330,2540,STR0023,oFont08) //"Atividade Encerrada"

// Box itens
oPrint:Box( 380, 30, 2260, 3000 )

oPrint:Say(400,0040,STR0013,oFont08) //"Atividade"
oPrint:Say(400,0630,STR0014,oFont08) //"Responsavel"
oPrint:Say(400,1110,STR0015,oFont08) //"Inicio"
oPrint:Say(400,1260,STR0016,oFont08) //"Fim"
oPrint:Say(400,1410,STR0017,oFont08) //"Prazo"
oPrint:Say(400,1560,STR0018,oFont08) //"Comp.(%)"
oPrint:Say(400,1710,STR0019,oFont08) //"Observacoes"

oPrint:Line( 460, 30, 460, 3000 )   	// horizontal

oPrint:Line(380, 0620, 2260, 0620)   	// vertical
oPrint:Line(380, 1100, 2260, 1100)   	// vertical
oPrint:Line(380, 1250, 2260, 1250)   	// vertical
oPrint:Line(380, 1400, 2260, 1400)   	// vertical
oPrint:Line(380, 1550, 2260, 1550)   	// vertical
oPrint:Line(380, 1700, 2260, 1700)   	// vertical

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Dt4To2   ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 08.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Transforma data em caracter com ano de 2 digitos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Dt4To2(ExpD1)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpD1 = Data                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaPPAP                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Dt4To2(dData)

Local cData := DtoC(dData)

If Len(cData) > 8
	cData := Substr(cData,1,6) + Substr(cData,9,2)
Endif

Return cData
