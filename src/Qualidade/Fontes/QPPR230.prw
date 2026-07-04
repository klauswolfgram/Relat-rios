/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR230.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR230  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Sumario e APQP                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR230(void)                                              ³±±
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

User Function QPPR230(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cStartPath := GetSrvProfString("Startpath","")

Private cPecaRev := ""
Private	axTex := {}
Private	cTextRet := ""

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""   

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Sumario e APQP"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA230"
		cPecaRev := Iif(!lBrow, M->QKJ_PECA + M->QKJ_REV, QKJ->QKJ_PECA + QKJ->QKJ_REV)
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

DbSelectArea("QKJ")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,865,1110,140)
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Sumario e APQP                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR230                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i := 1, nCont := 0
Local lin
Local nx :=1

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
lin := 350

DbSelectArea("QKJ")

nCont++ 

	
If lin > 2900
	nCont := 1
	i++
	oPrint:EndPage() 		// Finaliza a pagina
	Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
	lin := 350
Endif
	
lin += 40
oPrint:Say(lin,0030,STR0003,oFont08) //"1. ESTUDO PRELIMINAR DA CAPABILIDADE DO PROCESSO"
oPrint:Say(lin,1800,STR0004,oFont08) //"QUANTIDADE"

lin += 40
oPrint:Box( lin, 1450, lin+120, 2300 )		// Box do Estudo Preliminar
oPrint:Line( lin, 1783, lin+120, 1783 )	// vertical
oPrint:Line( lin, 2066, lin+120, 2066 ) 	// vertical
oPrint:Line( lin+60, 1450, lin+60, 2300 )	// horizontal

lin += 20
oPrint:Say(lin,1500,STR0005,oFont08) //"REQUERIDA"
oPrint:Say(lin,1800,STR0006,oFont08) //"ACEITAVEL"
oPrint:Say(lin,2100,STR0007,oFont08) //"PENDENTE*"

lin += 60
oPrint:Say(lin,0030,STR0008,oFont08) //"Ppk - CARACTERISTICAS ESPECIAIS"
oPrint:Say(lin,1510,QKJ->QKJ_QTREQ,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTACE,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTPEN,oFontCou08)

lin += 120
oPrint:Say(lin,0030,STR0009,oFont08) //"2. APROVACAO DO PLANO DE CONTROLE (SE REQUERIDO)"
oPrint:Say(lin,1450,STR0010,oFont08) //"APROVADO"
oPrint:Say(lin,1650,Iif(!Empty(QKJ->QKJ_APRPLN),Iif(QKJ->QKJ_APRPLN == "1",STR0011,STR0012)," "),oFontCou08) //"SIM "###"NAO*"
oPrint:Say(lin,1750,STR0013,oFont08) //"DATA DA APROVACAO"
oPrint:Say(lin,2100,DtoC(QKJ->QKJ_DTAPPL),oFontCou08)

lin += 80
oPrint:Say(lin,0030,STR0014,oFont08) //"3. CATEGORIA DAS CARACTERISTICAS DA AMOSTRA INICIAL DA PRODUCAO"
oPrint:Say(lin,1600,STR0004,oFont08) //"QUANTIDADE"

lin += 40
oPrint:Box( lin, 1117, lin+300, 2300 )			// Box da categoria
oPrint:Line( lin, 1450, lin+300, 1450 )		// vertical
oPrint:Line( lin, 1783, lin+300, 1783 )		// vertical
oPrint:Line( lin, 2066, lin+300, 2066 ) 		// vertical
oPrint:Line( lin+060, 1117, lin+060, 2300 )	// horizontal
oPrint:Line( lin+120, 1117, lin+120, 2300 )	// horizontal
oPrint:Line( lin+180, 1117, lin+180, 2300 )	// horizontal
oPrint:Line( lin+240, 1117, lin+240, 2300 )	// horizontal

lin += 20
oPrint:Say(lin,1200,STR0015,oFont08) //"AMOSTRAS"
oPrint:Say(lin,1500,STR0016,oFont08) //"CARAC/AMOST"
oPrint:Say(lin,1800,STR0006,oFont08) //"ACEITAVEL"
oPrint:Say(lin,2100,STR0007,oFont08) //"PENDENTE*"

lin += 60
oPrint:Say(lin,0030,STR0017,oFont08) //"DIMENSIONAL"
oPrint:Say(lin,1210,QKJ->QKJ_QTDIAM,oFontCou08)
oPrint:Say(lin,1510,QKJ->QKJ_QTDICA,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTDIAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTDIPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0018,oFont08) //"VISUAL"
oPrint:Say(lin,1210,QKJ->QKJ_QTVIAM,oFontCou08)
oPrint:Say(lin,1510,QKJ->QKJ_QTVICA,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTVIAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTVIPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0019,oFont08) //"LABORATORIO"
oPrint:Say(lin,1210,QKJ->QKJ_QTLAAM,oFontCou08)
oPrint:Say(lin,1510,QKJ->QKJ_QTLACA,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTLAAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTLAPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0020,oFont08) //"DESEMPENHO"
oPrint:Say(lin,1210,QKJ->QKJ_QTDEAM,oFontCou08)
oPrint:Say(lin,1510,QKJ->QKJ_QTDECA,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTDEAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTDEPE,oFontCou08)

lin += 140
oPrint:Say(lin,0030,STR0021,oFont08) //"4. ANALISE DO SISTEMA DE MEDICAO DE DISPOSITIVOS E INSTRUMENTOS"
oPrint:Say(lin,1800,STR0004,oFont08) //"QUANTIDADE"

lin += 40
oPrint:Box( lin, 1450, lin+120, 2300 )		// Box da analise do sistema de medicao
oPrint:Line( lin, 1783, lin+120, 1783 )	// vertical
oPrint:Line( lin, 2066, lin+120, 2066 ) 	// vertical
oPrint:Line( lin+60, 1450, lin+60, 2300 )	// horizontal

lin += 20
oPrint:Say(lin,1500,STR0005,oFont08) //"REQUERIDA"
oPrint:Say(lin,1800,STR0006,oFont08) //"ACEITAVEL"
oPrint:Say(lin,2100,STR0007,oFont08) //"PENDENTE*"

lin += 60
oPrint:Say(lin,0030,STR0022,oFont08) //"CARACTERISTICA ESPECIAL"
oPrint:Say(lin,1510,QKJ->QKJ_QTMERE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTMEAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTMEPE,oFontCou08)

lin += 120

oPrint:Say(lin,0030,STR0023,oFont08) //"5. MONITORAMENTO DO PROCESSO"
oPrint:Say(lin,1800,STR0004,oFont08) //"QUANTIDADE"

lin += 40
oPrint:Box( lin, 1450, lin+240, 2300 )			// Box do monitoramento do processo
oPrint:Line( lin, 1783, lin+240, 1783 )		// vertical
oPrint:Line( lin, 2066, lin+240, 2066 ) 		// vertical
oPrint:Line( lin+060, 1450, lin+60, 2300 )	// horizontal
oPrint:Line( lin+120, 1450, lin+120, 2300 )	// horizontal
oPrint:Line( lin+180, 1450, lin+180, 2300 )	// horizontal

lin += 20
oPrint:Say(lin,1500,STR0005,oFont08) //"REQUERIDA"
oPrint:Say(lin,1800,STR0006,oFont08) //"ACEITAVEL"
oPrint:Say(lin,2100,STR0007,oFont08) //"PENDENTE*"

lin += 60
oPrint:Say(lin,0030,STR0024,oFont08) //"INSTRUCOES DE MONITORAMENTO"
oPrint:Say(lin,1510,QKJ->QKJ_QTMORE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTMOAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTMOPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0025,oFont08) //"FOLHAS DE PROCESSO"
oPrint:Say(lin,1510,QKJ->QKJ_QTFORE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTFOAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTFOPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0026,oFont08) //"INSTRUCOES VISUAIS"
oPrint:Say(lin,1510,QKJ->QKJ_QTIVRE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTIVAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTIVPE,oFontCou08)

lin += 120

oPrint:Say(lin,0030,STR0027,oFont08) //"6. EMBALAGEM/EXPEDICAO"
oPrint:Say(lin,1800,STR0004,oFont08) //"QUANTIDADE"

lin += 40
oPrint:Box( lin, 1450, lin+180, 2300 )			// Box embalagem/expedicao
oPrint:Line( lin, 1783, lin+180, 1783 )		// vertical
oPrint:Line( lin, 2066, lin+180, 2066 ) 		// vertical
oPrint:Line( lin+060, 1450, lin+60, 2300 )	// horizontal
oPrint:Line( lin+120, 1450, lin+120, 2300 )	// horizontal

lin += 20
oPrint:Say(lin,1500,STR0005,oFont08) //"REQUERIDA"
oPrint:Say(lin,1800,STR0006,oFont08) //"ACEITAVEL"
oPrint:Say(lin,2100,STR0007,oFont08) //"PENDENTE*"

lin += 60
oPrint:Say(lin,0030,STR0028,oFont08) //"APROVACAO DA EMBALAGEM"
oPrint:Say(lin,1510,QKJ->QKJ_QTEMRE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTEMAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTEMPE,oFontCou08)

lin += 60
oPrint:Say(lin,0030,STR0029,oFont08) //"TESTE DE ENTREGA"
oPrint:Say(lin,1510,QKJ->QKJ_QTTERE,oFontCou08)
oPrint:Say(lin,1810,QKJ->QKJ_QTTEAC,oFontCou08)
oPrint:Say(lin,2110,QKJ->QKJ_QTTEPE,oFontCou08)

lin += 120
oPrint:Say(lin,0030,STR0030,oFont08) //"7. APROVACAO"

//1o bloco de assinaturas
lin += 80
oPrint:Say(lin,0030,AllTrim(QKJ->QKJ_MEMB1)+Space(05)+DtoC(QKJ->QKJ_DTME1),oFontCou08)
oPrint:Say(lin,1200,AllTrim(QKJ->QKJ_MEMB2)+Space(05)+DtoC(QKJ->QKJ_DTME2),oFontCou08)

lin += 30
oPrint:Line(lin, 0030, lin, 0430)	// horizontal
oPrint:Line(lin, 1200, lin, 1630)	// horizontal

lin += 10
oPrint:Say(lin,0030,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"
oPrint:Say(lin,1200,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"

// 2o bloco de assinaturas
lin += 40
oPrint:Say(lin,0030,AllTrim(QKJ->QKJ_MEMB3)+Space(05)+DtoC(QKJ->QKJ_DTME3),oFontCou08)
oPrint:Say(lin,1200,AllTrim(QKJ->QKJ_MEMB4)+Space(05)+DtoC(QKJ->QKJ_DTME4),oFontCou08)

lin += 30
oPrint:Line(lin, 0030, lin, 0430)	// horizontal
oPrint:Line(lin, 1200, lin, 1630)	// horizontal

lin += 10
oPrint:Say(lin,0030,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"
oPrint:Say(lin,1200,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"

// 3o bloco de assinaturas
lin += 40
oPrint:Say(lin,0030,AllTrim(QKJ->QKJ_MEMB5)+Space(05)+DtoC(QKJ->QKJ_DTME5),oFontCou08)
oPrint:Say(lin,1200,AllTrim(QKJ->QKJ_MEMB6)+Space(05)+DtoC(QKJ->QKJ_DTME6),oFontCou08)

lin += 30
oPrint:Line(lin, 0030, lin, 0430)	// horizontal
oPrint:Line(lin, 1200, lin, 1630)	// horizontal

lin += 10
oPrint:Say(lin,0030,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"
oPrint:Say(lin,1200,STR0031,oFont08) //"Membro da Equipe/Cargo/Data"

lin += 60
oPrint:Say(lin,0030,STR0032,oFont08) //"*Requer um plano de acao para acompanhar o progresso"

lin += 80
oPrint:Say(lin,0030,STR0033,oFont08) //"PLANO DE ACAO"
lin += 40

If !Empty(QKJ->QKJ_CHAVE)
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QKJ->QKJ_CHAVE,"QPPA230 ",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			lin += 40
			If lin > 2900
				i++
				oPrint:EndPage() 		// Finaliza a pagina
				Cabecalho(oPrint)  		// Funcao que monta o cabecalho
				lin := 350
				lin += 80
				oPrint:Say(lin,0030,STR0033,oFont08) //"PLANO DE ACAO"
				lin += 40
			Endif
			oPrint:Say(lin,0030,axTex[nx],oFontCou08)
		Endif
	Next nx

Endif

DbSelectArea("QKJ")

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 19.09.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Sumario e APQP                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR230                                                    ³±±
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
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(050,700,STR0034,oFont16 ) //"SUMARIO E APROVACAO DO PLANEJAMENTO"
oPrint:Say(100,850,STR0035,oFont16 ) //"DA QUALIDADE DO PRODUTO"

oPrint:Say(200,0030,STR0036,oFont08) //"Data :"
oPrint:Say(200,0130,DtoC(QKJ->QKJ_DATA),oFontCou08)

oPrint:Say(250,0030,STR0038,oFont08) //"Nome da Peca :"
oPrint:Say(250,0270,Subs(QK1->QK1_DESC,1,45),oFontCou08)

oPrint:Say(300,0030,STR0037,oFont08) //"Cliente :"
oPrint:Say(300,0230,SA1->A1_NOME,oFontCou08)

oPrint:Say(250,1400,STR0042,oFont08) //"No. da Peca/Rev :"
oPrint:Say(250,1630,Alltrim(QKJ->QKJ_PECA)+" / "+Alltrim(QKJ->QKJ_REV),oFontCou08)

oPrint:Say(300,1400,STR0041,oFont08) //"Planta de Manufatura :"
oPrint:Say(300,1680,QKJ->QKJ_PMANUF,oFontCou08)
 
Return Nil
