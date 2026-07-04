/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR210.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR210  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 13.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Relatorio de Aprovacao de Aparencia                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR210(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³12.08.01³      ³  Inclusao dos dados na moldura         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR210(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev := ""
Private	axTex	 := {}
Private	cTextRet := ""
Private nEdicao     := Val(GetMv("MV_QPPAPED",.T.,"3"))// Indica a Edicao do PPAP default 3 Edicao

Default lBrow 		:= .F.
Default cPecaAuto 	:= ""
Default cJPEG       := ""

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint	:= TMSPrinter():New(STR0001) //"Aprovacao de Aparencia"

oPrint:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA210"
		cPecaRev := Iif(!lBrow, M->QK3_PECA + M->QK3_REV, QK3->QK3_PECA + QK3->QK3_REV)
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

DbSelectArea("QK3")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If (lPergunte .and. mv_par03 == 1) .or. !Empty(cPecaAuto)
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 13.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Aprovacao de Aparencia                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR210                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local i := 1, nCont := 0
Local lin

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho

lin := 1020

DbSelectArea("QK4")
DbSetOrder(1)
DbSeek(xFilial("QK4")+cPecaRev)

Do While !Eof() .and. QK4->QK4_PECA+QK4->QK4_REV == cPecaRev

	nCont++ 
	
	If nCont > 13		
		nCont := 1
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 1020
	Endif
	
	lin += 80
	oPrint:Say(lin,0040,Subs(QK4->QK4_SULCOR,1,9),oFontCou08)
	oPrint:Say(lin,0206,Subs(QK4->QK4_DL,1,3)	,oFontCou08)
	oPrint:Say(lin,0266,Subs(QK4->QK4_DA,1,3)	,oFontCou08)
	oPrint:Say(lin,0326,Subs(QK4->QK4_DB,1,3)	,oFontCou08)
	oPrint:Say(lin,0386,Subs(QK4->QK4_DE,1,3)	,oFontCou08)
	oPrint:Say(lin,0445,Subs(QK4->QK4_CMC,1,3)	,oFontCou08)

	oPrint:Say(lin,0511,Subs(QK4->QK4_NUMPAD,1,7)	,oFontCou08)
	oPrint:Say(lin,0650,Dt4To2(QK4->QK4_DTPAD),oFontCou08)
	oPrint:Say(lin,0805,Subs(QK4->QK4_TIPMAT,1,17),oFontCou08)
	oPrint:Say(lin,1105,Subs(QK4->QK4_FONMAT,1,17),oFontCou08)

	oPrint:Say(lin,1408,Subs(QK4->QK4_VERM,1,4) 	,oFontCou08)
	oPrint:Say(lin,1483,Subs(QK4->QK4_AMAR,1,4)  	,oFontCou08)
	oPrint:Say(lin,1558,Subs(QK4->QK4_VERD,1,4)  	,oFontCou08)
	oPrint:Say(lin,1633,Subs(QK4->QK4_AZUL,1,4)  	,oFontCou08)
	oPrint:Say(lin,1708,Subs(QK4->QK4_CLARO,1,4) 	,oFontCou08)
	oPrint:Say(lin,1783,Subs(QK4->QK4_ESCUR,1,4) 	,oFontCou08)
	oPrint:Say(lin,1858,Subs(QK4->QK4_CINZA,1,4) 	,oFontCou08)
	oPrint:Say(lin,1933,Subs(QK4->QK4_LIMPO,1,4) 	,oFontCou08)
	oPrint:Say(lin,2005,Subs(QK4->QK4_ALTO,1,4)  	,oFontCou08)
	oPrint:Say(lin,2080,Subs(QK4->QK4_BAIXO,1,4) 	,oFontCou08)
	If nEdicao == 3
		oPrint:Say(lin,2160,QK4->QK4_CORENT	,oFontCou08)
		oPrint:Say(lin,2610,QK4->QK4_DISPEC	,oFontCou08)
	Else
		oPrint:Say(lin,2155,Subs(QK4->QK4_BMBAIX,1,4)	,oFontCou08)
		oPrint:Say(lin,2225,Subs(QK4->QK4_BMALTO,1,4)	,oFontCou08)
		oPrint:Say(lin,2309,QK4->QK4_CORENT	,oFontCou08)
		oPrint:Say(lin,2654,QK4->QK4_DISPEC	,oFontCou08)
	Endif
	
	DbSkip()

Enddo

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 13.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Relatorio de Aprovacao de Aparencia                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR210                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local x 			:= 0
Local lin 			:= 0
Local cFileLogo		:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local cObs 			:= ""
Local nx 			:=1
If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58)

oPrint:Say(050,1200,STR0003,oFont16 ) //"RELATORIO DE APROVACAO DE APARENCIA "

//Box Cabecalho
oPrint:Box( 150, 30, 560, 3000 )

//Box Itens
oPrint:Box( 580, 30, 1060, 3000 )
oPrint:Box( 1060, 30, 2260, 3000 )

// Descricao do Cabecalho
// 1a Linha
oPrint:Say(160,0040,STR0004,oFont08 )   //"Numero da Peca(Cliente)"
oPrint:Say(195,0040,QK1->QK1_PCCLI,oFontCou08 )

oPrint:Say(160,0810,STR0005,oFont08 ) //"Desenho No."
oPrint:Say(195,0810,Subs(QK3->QK3_NDESEN,1,23),oFontCou08 )

oPrint:Say(160,1210,STR0006,oFont08 )       //"Cliente"
oPrint:Say(195,1210,SA1->A1_NOME,oFontCou08 )

oPrint:Say(160,2010,STR0007,oFont08 ) //"Projeto"
oPrint:Say(195,2010,QK1->QK1_PROJET,oFontCou08 )

oPrint:Say(160,2810,STR0008,oFont08 ) //"Pagina"
oPrint:Say(195,2820, Str(i,2),oFont08)

// 2a Linha
oPrint:Say(245,0040,STR0009,oFont08 ) //"Nome da Peca"
oPrint:Say(275,0040,Subs(QK1->QK1_DESC,1,40),oFontCou08 )
                                                  
oPrint:Say(245,0810,STR0010,oFont08 ) //"Comprador"
oPrint:Say(275,0810,QK3->QK3_COMPRA,oFontCou08 )

oPrint:Say(245,2010,STR0011,oFont08 ) //"Nivel de Alteracao Eng."
oPrint:Say(275,2010,QK3->QK3_NIVALT,oFontCou08 )

oPrint:Say(245,2810,STR0012,oFont08 ) //"Data"
oPrint:Say(275,2810,Dt4To2(QK3->QK3_DTALTE),oFontCou08 )


// 3a Linha
oPrint:Say(325,0040,STR0013,oFont08 ) //"Fornecedor"
oPrint:Say(355,0040,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(325,0810,STR0014,oFont08 ) //"No. Peca(Fornecedor)"
oPrint:Say(355,0810,Subs(AllTrim(QK1->QK1_PECA),1,30)+"/"+ QK1->QK1_REV,oFontCou08)

oPrint:Say(325,1410,STR0015,oFont08 ) //"Localidade de Fabricacao"
oPrint:Say(355,1410,QK3->QK3_LOCALI,oFontCou08)

oPrint:Say(325,2510,STR0016,oFont08 ) //"Codigo do Fornecedor"

// 4a Linha
If nEdicao == 3
	oPrint:Say(415,0040,STR0017,oFont08 )	//"Razao para Submissao :"
	oPrint:Say(495,0070,STR0018,oFont08 )	//"Certificado de Submissao da Peca"
	oPrint:Say(495,0770,STR0019,oFont08 )	//"Amostra Especial"
	oPrint:Say(495,1370,STR0020,oFont08 )  //"Primeira Expedicao de Producao"
	oPrint:Say(495,2070,STR0021,oFont08 )	//"Alteracao de Engenharia"
	oPrint:Say(495,2770,STR0022,oFont08 )	//"Nova Submissao"        
Else
	oPrint:Say(410,0040,STR0017,oFont08 )	//"Razao para Submissao :"
	oPrint:Say(450,0090,STR0018,oFont08 )  //"Certificado de Submissao da Peca"
	oPrint:Say(510,0090,STR0061,oFont08 )  //"Pre-Extrutura"
	oPrint:Say(450,0720,STR0019,oFont08 )	//"Amostra Especial"
	oPrint:Say(510,0720,STR0063,oFont08 )  //"Embarque Primeira Producao"
	oPrint:Say(450,1320,STR0064,oFont08 )	//"Re-Submissao"
	oPrint:Say(510,1320,STR0021,oFont08 )	//"Alteracao de Engenharia"
	oPrint:Say(450,2020,STR0062,oFont08 )	//"Outros"
Endif

If nEdicao == 3
	Do Case
		Case QK3->QK3_RAZAO == "1"
			oPrint:Say(495,0040,"X",oFont10)
		Case QK3->QK3_RAZAO == "2"
			oPrint:Say(495,0740,"X",oFont10)
		Case QK3->QK3_RAZAO == "3"
			oPrint:Say(495,1340,"X",oFont10)
		Case QK3->QK3_RAZAO == "4"
			oPrint:Say(495,2040,"X",oFont10)
		Case QK3->QK3_RAZAO == "5"
			oPrint:Say(495,2740,"X",oFont10)
	Endcase
EndIf


// Descricao dos Itens
// 1a Linha
oPrint:Say(600,1250,STR0023,oFont16 )   //"AVALICAO DE APARENCIA"
// 2a Linha
oPrint:Say(700,1250,STR0024,oFont08 ) //"Informacoes sobre Sub-Fornecedores e Textura"

If !Empty(QK3->QK3_CHAVE)  // Texto das Informacoes
	axTex := {}
	cTextRet := ""
	cTextRet := QO_Rectxt(QK3->QK3_CHAVE,"QPPA210 ",1,TamSX3("QKO_TEXTO")[1],"QKO")
	axTex := Q_MemoArray(cTextRet,axTex,TamSX3("QKO_TEXTO")[1])

	For nx :=1 To Len(axTex)
		If !Empty(axTex[nx])
			cObs += axTex[nx]
		Endif
	Next nx

	oPrint:Say(750,0040,Subs(cObs,001,165),oFontCou08)
	oPrint:Say(790,0040,Subs(cObs,166,165),oFontCou08)

Endif

DbSelectArea("QK3")

// 4a Linha
oPrint:Say(830,1250,STR0025,oFont16 )   //"AVALIACAO DE COR"
// Descricao dos Itens                           
oPrint:Say(940,60,STR0026,oFont08 )   //"Sufixo"
oPrint:Say(990,60,STR0027,oFont08 )   //"de Cor"

oPrint:Say(920,210,STR0028,oFont08 )   //"Dados Colorimetricos"
oPrint:Say(1000,207,STR0029,oFont08 )	//"DL*"
oPrint:Say(1000,267,STR0030,oFont08 )	//"Da*"
oPrint:Say(1000,327,STR0031,oFont08 )	//"Db*"
oPrint:Say(1000,387,STR0032,oFont08 )	//"DE*"
oPrint:Say(1000,445,STR0033,oFont08 )    //"CMC"

oPrint:Say(940,520,STR0034,oFont08 )   //"Numero"
oPrint:Say(990,520,STR0035,oFont08 )   //"Padrao"

oPrint:Say(940,670,STR0012,oFont08 )   //"Data"
oPrint:Say(990,670,STR0035,oFont08 ) //"Padrao"

oPrint:Say(940,900,STR0036,oFont08 )   //"Tipo do"
oPrint:Say(990,900,STR0037,oFont08 )  //"Material"

oPrint:Say(940,1200,STR0038,oFont08 )   //"Fonte do"
oPrint:Say(990,1200,STR0037,oFont08 )   //"Material"

oPrint:Say(920,1460,STR0039,oFont08 )   //"Tonalidade"
oPrint:Say(1000,1408,STR0040,oFont08 ) //"Verm"
oPrint:Say(1000,1483,STR0041,oFont08 ) //"Amar"
oPrint:Say(1000,1558,STR0042,oFont08 ) //"Verd"
oPrint:Say(1000,1633,STR0043,oFont08 ) //"Azul"

oPrint:Say(0920,1756,STR0044,oFont08 ) //"Valor"
oPrint:Say(1000,1708,STR0045,oFont08 ) //"Clar"
oPrint:Say(1000,1783,STR0046,oFont08 ) //"Escu"

oPrint:Say(0920,1896,STR0047,oFont08 ) //"Croma"
oPrint:Say(1000,1858,STR0048,oFont08 ) //"Cinz"
oPrint:Say(1000,1933,STR0049,oFont08 ) //"Limp"

oPrint:Say(0920,2040,STR0050,oFont08 ) //"Brilho"
oPrint:Say(1000,2005,STR0051,oFont08 ) //"Alto"
oPrint:Say(1000,2080,STR0052,oFont08 ) //"Baix"
                                        
If nEdicao == 3                                        
	oPrint:Say(0940,2250,STR0053,oFont10 )	//"Sufixo da Cor"
	oPrint:Say(0990,2250,STR0054,oFont10 ) //"de Entrega"
	oPrint:Say(0940,2750,STR0055,oFont10 ) //"Disposicao"
	oPrint:Say(0990,2750,STR0056,oFont10 ) //"da Peca"
Else
	oPrint:Say(0915,2180,STR0050,oFont08 ) //"Brilho"
	oPrint:Say(0945,2160,STR0065,oFont08 ) //"Metalico"
	oPrint:Say(1000,2152,STR0051,oFont08 ) //"Alto"
	oPrint:Say(1000,2225,STR0052,oFont08 ) //"Baix"
	oPrint:Say(0940,2350,STR0053,oFont10 )	//"Sufixo da Cor"
	oPrint:Say(0990,2350,STR0054,oFont10 ) //"de Entrega"
	oPrint:Say(0940,2730,STR0055,oFont10 ) //"Disposicao"
	oPrint:Say(0990,2730,STR0056,oFont10 ) //"da Peca"
Endif
oPrint:Say(2110,40,STR0057,oFont08 ) 		//"Comentarios"
oPrint:Say(2140,40,Subs(QK3->QK3_COMENT,1,165),oFontCou08 )

oPrint:Say(2190,40,STR0058,oFont08 )    //"Assinatura do Fornecedor"
oPrint:Say(2220,40,QK3->QK3_ASSFOR,oFontCou08 )

oPrint:Say(2190,1110,STR0059,oFont08 )    //"Telefone"
oPrint:Say(2220,1110,Subs(QK3->QK3_TELFOR,1,16),oFontCou08 )

oPrint:Say(2190,1410,STR0012,oFont08 ) //"Data"
oPrint:Say(2220,1410,Dt4To2(QK3->QK3_DTAFOR),oFontCou08 )

oPrint:Say(2190,1610,STR0060,oFont08 )    //"Assinatura do Representando do Cliente"
oPrint:Say(2220,1610,QK3->QK3_ASSCLI,oFontCou08 )

oPrint:Say(2190,2810,STR0012,oFont08 )    //"Data"
oPrint:Say(2220,2810,Dt4To2(QK3->QK3_DTACLI),oFontCou08 )

//Construcao do quadriculado do cabecalho
oPrint:Line( 235, 30, 235, 3000 )   	// horizontal
oPrint:Line( 315, 30, 315, 3000 )   	// horizontal
oPrint:Line( 395, 30, 395, 3000 )   	// horizontal

oPrint:Line( 150, 800, 400, 800 )   	// vertical  1a linha
oPrint:Line( 150, 1200, 235, 1200 ) 	// vertical
oPrint:Line( 150, 2000, 235, 2000 ) 	// vertical
oPrint:Line( 150, 2800, 235, 2800 ) 	// vertical

oPrint:Line( 235, 2000, 315, 2000 )	// vertical 2a linha
oPrint:Line( 235, 2800, 315, 2800 )	// vertical         

oPrint:Line( 315, 1400, 400, 1400 )   // vertical 3a linha
oPrint:Line( 315, 2500, 400, 2500 )   // vertical  


//Construcao do quadriculado dos itens
oPrint:Line( 660, 30, 660, 3000 )   	// horizontal
oPrint:Line( 740, 30, 740, 3000 )   	// horizontal
oPrint:Line( 820, 30, 820, 3000 )   	// horizontal
oPrint:Line( 900, 30, 900, 3000 )   	// horizontal

//Quadriculado da linha [Sufixo de Cor]
oPrint:Line( 900, 200, 1060, 200 )   	// vertical  
oPrint:Line( 900, 510, 1060, 510 )   	// vertical
oPrint:Line( 980, 200, 0980, 510 )   	// horizontal

//Quadriculado da linha [Dados Colorimetricos]
oPrint:Line( 0980, 260, 1060, 260 )   	// vertical  
oPrint:Line( 1060, 260, 2100, 260 )   	// vertical  

oPrint:Line( 0980, 320, 1060, 320 )   	// vertical  
oPrint:Line( 1060, 320, 2100, 320 )   	// vertical  

oPrint:Line( 0980, 380, 1060, 380 )   	// vertical  
oPrint:Line( 1060, 380, 2100, 380 )   	// vertical  

oPrint:Line( 0980, 440, 1060, 440 )   	// vertical  
oPrint:Line( 1060, 440, 2100, 440 )   	// vertical  
oPrint:Line( 1060, 510, 2100, 510 )   	// vertical

oPrint:Line( 0900, 650, 1060, 650 )   	// vertical  
oPrint:Line( 1060, 650, 2100, 650 )   	// vertical  

oPrint:Line( 0900, 800, 1060, 800 )   	// vertical  
oPrint:Line( 0900, 1100, 1060, 1100 )  // vertical  


//Quadriculado da linha [Tonalidade]
oPrint:Line( 900, 1400, 1060, 1400 )	// vertical  
oPrint:Line( 980, 1400, 0980, 1700 ) 	// horizontal
oPrint:Line( 980, 1475, 1060, 1475 )	// vertical  
oPrint:Line( 980, 1550, 1060, 1550 )	// vertical  
oPrint:Line( 980, 1625, 1060, 1625 )	// vertical  
oPrint:Line( 900, 1700, 1060, 1700 )	// vertical  

//Quadriculado da linha [Valor]
oPrint:Line( 900, 1850, 1060, 1850 )	// vertical  
oPrint:Line( 980, 1700, 0980, 1850 ) 	// horizontal
oPrint:Line( 980, 1775, 1060, 1775 )	// vertical  
                                                     
//Quadriculado da linha [Croma]
oPrint:Line( 900, 2000, 1060, 2000 )	// vertical  
oPrint:Line( 980, 1850, 0980, 2000 ) 	// horizontal
oPrint:Line( 980, 1925, 1060, 1925 )	// vertical  

//Quadriculado da linha [Brilho]
oPrint:Line( 900, 2150, 1060, 2150 )	// vertical  
oPrint:Line( 980, 2000, 0980, 2150 ) 	// horizontal
oPrint:Line( 980, 2075, 1060, 2075 )	// vertical  
                                                  
// Sufixo da cor de entrega / Disposicao da Peca
If nEdicao == 3
	oPrint:Line( 900, 2600, 1060, 2600 )	// vertical  
Else
	//Quadriculado da linha [Brilho Metalico]
	oPrint:Line( 900, 2300, 1060, 2300 )	// vertical  
	oPrint:Line( 980, 2150, 0980, 2300 ) 	// horizontal
	oPrint:Line( 980, 2220, 2100, 2220 )	// vertical  
	                                                  
	// Sufixo da cor de entrega / Disposicao da Peca
	oPrint:Line( 900, 2640, 1060, 2640 )	// vertical  
	oPrint:Line( 900, 2300, 2100, 2300 )	// vertical  
Endif


oPrint:Line( 1060, 0200, 2100, 0200 )	// vertical  
oPrint:Line( 1060, 0800, 2100, 0800 )	// vertical  
oPrint:Line( 1060, 1100, 2100, 1100 )	// vertical  
oPrint:Line( 1060, 1400, 2100, 1400 )	// vertical  
oPrint:Line( 1060, 1475, 2100, 1475 )	// vertical  
oPrint:Line( 1060, 1550, 2100, 1550 )	// vertical  
oPrint:Line( 1060, 1625, 2100, 1625 )	// vertical  
oPrint:Line( 1060, 1700, 2100, 1700 )	// vertical  
oPrint:Line( 1060, 1775, 2100, 1775 )	// vertical  
oPrint:Line( 1060, 1850, 2100, 1850 )	// vertical  
oPrint:Line( 1060, 1925, 2100, 1925 )	// vertical  
oPrint:Line( 1060, 2000, 2100, 2000 )	// vertical  
oPrint:Line( 1060, 2075, 2100, 2075 )	// vertical  
oPrint:Line( 1060, 2150, 2100, 2150 )	// vertical  
If nEdicao == 3
	oPrint:Line( 1060, 2600, 2100, 2600 )	// vertical  
Else
	oPrint:Line( 1060, 2640, 2100, 2640 )	// vertical  
Endif


lin := 1140

For x := 1 To 14
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal
	lin += 80	
Next x                                               

oPrint:Line( 2180, 1100, 2260, 1100 )	// vertical  
oPrint:Line( 2180, 1400, 2260, 1400 )	// vertical  
oPrint:Line( 2180, 1600, 2260, 1600 )	// vertical  
oPrint:Line( 2180, 2800, 2260, 2800 )	// vertical  
      
Return Nil
