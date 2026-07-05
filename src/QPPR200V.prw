/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR200V.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR200V ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³PPAP Resultados Desempenho VDA                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR200V(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR200V(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev 	:= ""
Private cCondW		:= ""

Default lBrow 		:= .F.
Default cPecaAuto	:= ""              
Default cJPEG       := ""             

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

cCondW := "QKC->QKC_PECA+QKC->QKC_REV+QKC->QKC_SEQ == cPecaRev"

cGrupo := "ESTSEQ"

oPrint := TMSPrinter():New(STR0001) //"Resultados Desempenho"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA200"
		cPecaRev := Iif(!lBrow, M->QKC_PECA + M->QKC_REV + M->QKC_SEQ, QKC->QKC_PECA + QKC->QKC_REV + QKC->QKC_SEQ)
	Else
		lPergunte := Pergunte(cGrupo,.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	+ mv_par03
		Else
			Return Nil
		Endif
	Endif
Endif

DbSelectArea("QL1")
DbSetOrder(1)
If !DbSeek(xFilial()+Subs(cPecaRev,1,42))
	If Empty(cPecaAuto)
		Help(" ",1,"VDACAPA")  // "Antes e necessario fazer o VDA folha de capa !"
	Endif
	Return Nil
Endif

DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+Subs(cPecaRev,1,42))

DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1") + QK1->QK1_CODCLI + QK1->QK1_LOJCLI)

DbSelectArea("QKC")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Relatorio, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If (lPergunte .and. mv_par04 == 1) .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
   			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,865,1170,140)
        Else
			oPrint:Print()
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif

Else

	MsgAlert(OemToAnsi(STR0060),OemToAnsi(STR0059))

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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Resultados Desempenho VDA                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200V                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                         

Static Function MontaRel(oPrint)

Local i 	:= 1
Local lin 	:= 1150
Local nRec	:= 0

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial" ,16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial" ,08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial" ,10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:Say(200,120,STR0003,oFont10) //"Anexos:"

//lado esquerdo
oPrint:Box(250,50,1100,100)
oPrint:Line(0300,50,0300,100)	// horizontal
oPrint:Line(0350,50,0350,100)	// horizontal
oPrint:Line(0400,50,0400,100)	// horizontal
oPrint:Line(0450,50,0450,100)	// horizontal
oPrint:Line(0500,50,0500,100)	// horizontal
oPrint:Line(0550,50,0550,100)	// horizontal
oPrint:Line(0600,50,0600,100)	// horizontal
oPrint:Line(0650,50,0650,100)	// horizontal
oPrint:Line(0700,50,0700,100)	// horizontal
oPrint:Line(0750,50,0750,100)	// horizontal
oPrint:Line(0800,50,0800,100)	// horizontal
oPrint:Line(0850,50,0850,100)	// horizontal
oPrint:Line(0900,50,0900,100)	// horizontal
oPrint:Line(0950,50,0950,100)	// horizontal
oPrint:Line(1000,50,1000,100)	// horizontal
oPrint:Line(1050,50,1050,100)	// horizontal

oPrint:Say(250,120,STR0004,oFont10) //"01 Teste de funcao"
If Subs(QL1->QL1_TSTFUN,1,1) == "1"
	oPrint:Say(250,70,"X",oFontCou08)
Endif

oPrint:Say(300,120,STR0005,oFont10) //"02 Teste de medicao"
If Subs(QL1->QL1_TSTMED,1,1) == "1"
	oPrint:Say(300,70,"X",oFontCou08)
Endif

oPrint:Say(350,120,STR0006,oFont10) //"03 Teste de material"
If Subs(QL1->QL1_TSTMAT,1,1) == "1"
	oPrint:Say(350,70,"X",oFontCou08)
Endif

oPrint:Say(400,120,STR0007,oFont10) //"04 Teste de resistencia"
If Subs(QL1->QL1_TSTRES,1,1) == "1"
	oPrint:Say(400,70,"X",oFontCou08)
Endif

oPrint:Say(450,120,STR0008,oFont10) //"05 Comprov. de capaciade do processo"
If Subs(QL1->QL1_COMCAP,1,1) == "1"
	oPrint:Say(450,70,"X",oFontCou08)
Endif

oPrint:Say(500,120,STR0009,oFont10) //"06 Diagrama de decurso do processo"
If Subs(QL1->QL1_DIAGRA,1,1) == "1"
	oPrint:Say(500,70,"X",oFontCou08)
Endif

oPrint:Say(550,120,STR0010,oFont10) //"07 Comprovacao da capacidade de instr. de teste"
If Subs(QL1->QL1_COMCPT,1,1) == "1"
	oPrint:Say(550,70,"X",oFontCou08)
Endif

oPrint:Say(600,120,STR0011,oFont10) //"08 Lista de intrumentos de teste"
If Subs(QL1->QL1_LISINS,1,1) == "1"
	oPrint:Say(600,70,"X",oFontCou08)
Endif

oPrint:Say(650,120,STR0012,oFont10) //"09 Folha EG de seguranca de dados"
If Subs(QL1->QL1_FOLHEG,1,1) == "1"
	oPrint:Say(650,70,"X",oFontCou08)
Endif

oPrint:Say(700,120,STR0013,oFont10) //"10 Tato"
If Subs(QL1->QL1_TATO,1,1) == "1"
	oPrint:Say(700,70,"X",oFontCou08)
Endif

oPrint:Say(750,120,STR0014,oFont10) //"11 Acustica"
If Subs(QL1->QL1_ACUSTI,1,1) == "1"
	oPrint:Say(750,70,"X",oFontCou08)
Endif

oPrint:Say(800,120,STR0015,oFont10) //"12 Cheiro"
If Subs(QL1->QL1_CHEIRO,1,1) == "1"
	oPrint:Say(800,70,"X",oFontCou08)
Endif

oPrint:Say(850,120,STR0016,oFont10) //"13 Aspecto geral"
If Subs(QL1->QL1_GERAL,1,1) == "1"
	oPrint:Say(850,70,"X",oFontCou08)
Endif

oPrint:Say(900,120,STR0017,oFont10) //"14 Certificados"
If Subs(QL1->QL1_CERTIF,1,1) == "1"
	oPrint:Say(900,70,"X",oFontCou08)
Endif

oPrint:Say(950,120,STR0018,oFont10) //"15 Liberacao de construcao"
If Subs(QL1->QL1_LIBCON,1,1) == "1"
	oPrint:Say(950,70,"X",oFontCou08)
Endif

oPrint:Say(1000,120,STR0019,oFont10) //"16 Material de composicao em pecas compradas"
If Subs(QL1->QL1_MATCOM,1,1) == "1"
	oPrint:Say(1000,70,"X",oFontCou08)
Endif

oPrint:Say(1050,120,STR0020,oFont10) //"17 Outros"
If Subs(QL1->QL1_OUTROS,1,1) == "1"
	oPrint:Say(1050,70,"X",oFontCou08)
Endif

//lado direito
oPrint:Box(250,1450,900,1500)
oPrint:Line(0300,1450,0300,1500)	// horizontal
oPrint:Line(0350,1450,0350,1500)	// horizontal
oPrint:Line(0400,1450,0400,1500)	// horizontal
oPrint:Line(0450,1450,0450,1500)	// horizontal
oPrint:Line(0500,1450,0500,1500)	// horizontal
oPrint:Line(0550,1450,0550,1500)	// horizontal
oPrint:Line(0600,1450,0600,1500)	// horizontal
oPrint:Line(0650,1450,0650,1500)	// horizontal
oPrint:Line(0700,1450,0700,1500)	// horizontal
oPrint:Line(0750,1450,0750,1500)	// horizontal
oPrint:Line(0800,1450,0800,1500)	// horizontal
oPrint:Line(0850,1450,0850,1500)	// horizontal

oPrint:Say(250,1520,STR0021,oFont10) //"Relatorio VDA de amostra inicial"
If QL1->QL1_VDAAMO == "1"
	oPrint:Say(250,1470,"X",oFontCou08)
Endif

oPrint:Say(300,1520,STR0022,oFont10) //"Amostra inicial"
If QL1->QL1_AMOINI == "1"
	oPrint:Say(300,1470,"X",oFontCou08)
Endif

oPrint:Say(350,1520,STR0023,oFont10) //"Amostra posterior"
If QL1->QL1_AMOPOS == "1"
	oPrint:Say(350,1470,"X",oFontCou08)
Endif

oPrint:Say(400,1520,STR0024,oFont10) //"Peca nova"
If QL1->QL1_PCNOVA == "1"
	oPrint:Say(400,1470,"X",oFontCou08)
Endif

oPrint:Say(450,1520,STR0025,oFont10) //"Alteracao de produto"
If QL1->QL1_ALTPRO == "1"
	oPrint:Say(450,1470,"X",oFontCou08)
Endif

oPrint:Say(500,1520,STR0026,oFont10) //"Postergacao da producao"
If QL1->QL1_POSPRO == "1"
	oPrint:Say(500,1470,"X",oFontCou08)
Endif

oPrint:Say(550,1520,STR0027,oFont10) //"Alteracao de processos de producao"
If QL1->QL1_ALPROC == "1"
	oPrint:Say(550,1470,"X",oFontCou08)
Endif

oPrint:Say(600,1520,STR0028,oFont10) //"Interrupcao maior de producao"
If QL1->QL1_INTPRO == "1"
	oPrint:Say(600,1470,"X",oFontCou08)
Endif

oPrint:Say(650,1520,STR0029,oFont10) //"Subfornecedor novo"
If QL1->QL1_SUBNOV == "1"
	oPrint:Say(650,1470,"X",oFontCou08)
Endif

oPrint:Say(700,1520,STR0030,oFont10) //"Produto com DAE"
If QL1->QL1_PRODAE == "1"
	oPrint:Say(700,1470,"X",oFontCou08)
Endif

oPrint:Say(750,1520,STR0031,oFont10) //"Elaborado plano de producao/inspecao"
If QL1->QL1_PLPROD == "1"
	oPrint:Say(750,1470,"X",oFontCou08)
Endif

oPrint:Say(800,1520,STR0032,oFont10) //"FMEA realizado"
If QL1->QL1_FMEARE == "1"
	oPrint:Say(800,1470,"X",oFontCou08)
Endif

oPrint:Say(850,1520,STR0033,oFont10) //"Relatorio demais amostras"
If QL1->QL1_RELDEM == "1"
	oPrint:Say(850,1470,"X",oFontCou08)
Endif

lin := Cabecalho(oPrint,i,lin)  			// Funcao que monta o cabecalho

DbSelectArea("QKC")

Do While !Eof() .and. xFilial("QKC") == QKC->QKC_FILIAL .and. &cCondW

	lin += 40
	
	If lin > 3060
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		oPrint:StartPage() 		// Inicia uma nova pagina
		lin := 200
		lin := Cabecalho(oPrint,i,lin)	// Funcao que monta o cabecalho
		lin += 40
	Endif

	oPrint:Say(lin,70,QKC->QKC_CARAC,oFontCou08)

	oPrint:Say(lin,270,QKC->QKC_DESC,oFontCou08)

	oPrint:Say(lin,1170,QKC->QKC_RESFOR,oFontCou08)

	Iif(QKC->QKC_FLOK == "1",	oPrint:Say(lin,2020,"X",oFontCou08),;
								oPrint:Say(lin,2210,"X",oFontCou08))
	

	DbSelectArea("QKC")
	DbSetOrder(1)

	nRec := Recno()
	
	DbSkip()

Enddo

DbGoto(nRec)

If lin > 2660
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	oPrint:StartPage() 		// Inicia uma nova pagina
	lin := 200
	lin := Cabecalho(oPrint,i,lin)	// Funcao que monta o cabecalho
	oPrint:Line(lin+20,50,2700,2350)
Endif

Foot(oPrint)			// Funcao que monta o rodape

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200V                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i,lin)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,750,STR0034,oFont16) //"- Resultados de Exame -"

oPrint:Say(090,1800,STR0035,oFont08) //"Pagina :"
oPrint:Say(090,1950,StrZero(i,3),oFont08)

oPrint:Say(090,2050,STR0058,oFont08) //"Sequencia :"
oPrint:Say(090,2250,QKC->QKC_SEQ,oFont08)

oPrint:Box(lin,50,lin+350,2350)
oPrint:Line(lin,1150,lin+350,1150) //vertical

oPrint:Say(lin+20,070,STR0036,oFont10) //"No. de Identificacao, Fornecedor:"
oPrint:Say(lin+20,600,SA1->A1_CODFOR,oFontCou08)

oPrint:Say(lin+20,1170,STR0037,oFont10) //"No. de Identificacao, Cliente:"
oPrint:Say(lin+20,1700,QL1->QL1_IDCLI,oFontCou08)

oPrint:Line(lin+70,50,lin+70,2350) //horizontal

oPrint:Say(lin+100,070,STR0038,oFont10) //"No. de Relatorio"
oPrint:Say(lin+100,400,QL1->QL1_NURELF,oFontCou08)

oPrint:Say(lin+100,1170,STR0038,oFont10) //"No. de Relatorio"
oPrint:Say(lin+100,1500,QL1->QL1_NURELC,oFontCou08)

oPrint:Say(lin+100,700,STR0039,oFont10) //"Versao"
oPrint:Say(lin+100,850,QL1->QL1_VERELF,oFontCou08)

oPrint:Say(lin+100,1900,STR0039,oFont10) //"Versao"
oPrint:Say(lin+100,2050,QL1->QL1_VERELC,oFontCou08)

oPrint:Line(lin+150,50,lin+150,2350) //horizontal

oPrint:Say(lin+170,0070,STR0040,oFont10) //"Status/Data do no. da familia/Desenho/Alteracao:"
oPrint:Say(lin+220,0070,AllTrim(QL1->QL1_STATUF)+"/"+AllTrim(QK1->QK1_NDES)+"/"+AllTrim(QK1->QK1_REVDES),oFontCou08)

oPrint:Say(lin+170,1170,STR0040,oFont10) //"Status/Data do no. da familia/Desenho/Alteracao:"
oPrint:Say(lin+220,1170,AllTrim(QL1->QL1_STATUC)+"/"+AllTrim(QK1->QK1_DESCLI),oFontCou08)

oPrint:Say(lin+270,070,STR0041,oFont10) //"Denominacao:"
oPrint:Say(lin+270,300,Subs(QK1->QK1_DESC,1,40),oFontCou08)

oPrint:Say(lin+270,1170,STR0041,oFont10) //"Denominacao:"
oPrint:Say(lin+270,1400,QL1->QL1_DENCLI,oFontCou08)

oPrint:Box(lin+370,50,3100,2350)

oPrint:Say(lin+390,0070,STR0042,oFont10) //"No. Ref."

oPrint:Line(lin+370,250,2700,250)  // vertical
oPrint:Say(lin+390,0270,STR0043,oFont10) //"Exigencias"

oPrint:Line(lin+370,1150,2700,1150)  // vertical
oPrint:Say(lin+390,1170,STR0044,oFont10) //"Valores Atuais fornecedor"

oPrint:Line(lin+370,2000,2700,2000)  // vertical
oPrint:Line(lin+490,2170,2700,2170)  // vertical
oPrint:Say(lin+390,2100,STR0045,oFont10) //"Avaliacao"
oPrint:Say(lin+440,2020,STR0046,oFont10) //"Em. O"
oPrint:Say(lin+440,2210,STR0046,oFont10) //"Em. O"

oPrint:Line(lin+490,50,lin+490,2350)  // horizontal

Return(lin+470)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Foot     ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 21.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Rodape do relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Foot(ExpO1,ExpN1, ExpN2)                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR200V                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Foot(oPrint)

Local aUsuario	:= {"","",""}

QAA->(DbSetOrder(6))

If QAA->(DbSeek(Trim(Upper(QKC->QKC_ASSFOR)))) .and. !Empty(QKC->QKC_ASSFOR)
	aUsuario[1] := QAA->QAA_MAT
	aUsuario[2] := QAA->QAA_NOME
	aUsuario[3] := QAA->QAA_EMAIL
Endif

//Box 
oPrint:Box(2700, 50, 3100, 2350)

oPrint:Line(2700, 1150, 3100, 1150)		//vertical
oPrint:Line(2900, 0050, 2900, 2350)		//horizontal

// lado esquerdo
oPrint:Say(2710,0070,STR0047,oFont10)  //"Confirmacao do Fornecedor:"
oPrint:Say(2760,0070,STR0048,oFont10) //"Observacao:"
oPrint:Say(2810,0070,Subs(QKC->QKC_OBSERV,1,50),oFontCou08)
oPrint:Say(2860,0070,Subs(QKC->QKC_OBSERV,51,50),oFontCou08)

oPrint:Say(2910,070,STR0049,oFont08)  //"Nome:"
oPrint:Say(2910,400,aUsuario[2],oFontCou08)

oPrint:Say(2960,070,STR0050,oFont08)  //"Departamento:"
oPrint:Say(3010,070,STR0051,oFont08)  //"Telefone/Fax/E-mail:"
oPrint:Say(3010,400,aUsuario[3],oFontCou08)

oPrint:Say(3060,070,STR0052,oFont08)  //"Data:"
oPrint:Say(3060,200,DtoC(QKC->QKC_DTAPR),oFontCou08)

oPrint:Say(3060,500,STR0053,oFont08)  //"Assinatura:"

// lado direito
oPrint:Say(2710,1170,STR0054,oFont10) //"Decisao Cliente:"
oPrint:Line(2750, 1150, 2750, 2350)		//horizontal

oPrint:Say(2760,1170,STR0055,oFont10) //"Liberado"
oPrint:Line(2800, 1150, 2800, 2350)		//horizontal

oPrint:Say(2810,1170,STR0056,oFont10) //"Liberado com restricoes"
oPrint:Line(2850, 1150, 2850, 2350)		//horizontal

oPrint:Say(2860,1170,STR0057,oFont10) //"Reprovado, necessaria amostra posterior"
oPrint:Line(2750, 2000, 2900, 2000)		//vertical

If !Empty(QL1->QL1_TSTFUN)
	oPrint:Say(2710+(Val(Subs(QL1->QL1_TSTFUN,2,1))*50),2200,"X",oFontCou08)
Endif

oPrint:Say(2910,1170,STR0049,oFont08)  //"Nome:"
oPrint:Say(2910,1500,QL1->QL1_NOMEC,oFontCou08)

oPrint:Say(2960,1170,STR0050,oFont08)  //"Departamento:"
oPrint:Say(2960,1500,QL1->QL1_DEPTOC,oFontCou08)

oPrint:Say(3010,1170,STR0051,oFont08)  //"Telefone/Fax/E-mail:"
oPrint:Say(3010,1500,QL1->QL1_FONEC,oFontCou08)

oPrint:Say(3060,1170,STR0052,oFont08)  //"Data:"
oPrint:Say(3060,1300,DtoC(QL1->QL1_DTAPCL),oFontCou08)

oPrint:Say(3060,1600,STR0053,oFont08)  //"Assinatura:"

Return Nil
