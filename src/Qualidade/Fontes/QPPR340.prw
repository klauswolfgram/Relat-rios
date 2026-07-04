/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR340.CH"
#INCLUDE "PROTHEUS.CH"
                
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR340  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 04.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Amostras Iniciais PSA                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR340(void)                                              ³±±
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

User Function QPPR340(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev    := ""


Default lBrow 		:= .F.
Default cPecaAuto	:= ""  
Default cJPEG       := "" 

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint	:= TMSPrinter():New(STR0001) //"Amostras Iniciais PSA"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA340"
		cPecaRev := Iif(!lBrow,M->QL0_PECA + M->QL0_REV, QL0->QL0_PECA + QL0->QL0_REV)
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

DbSelectArea("QL0")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Relatorio, Aguarde..."
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 04.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Amostras Iniciais PSA                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR340                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local aUsuario		:= {"","",""}

Private oFont10, oFont12, oFont14, oFontCou08

oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12		:= TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
oFont14		:= TFont():New("Arial",14,14,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

QAA->(DbSetOrder(6))

If QAA->(DbSeek(Trim(Upper(QL0->QL0_APROVA)))) .and. !Empty(QL0->QL0_APROVA)
	aUsuario[1] := QAA->QAA_MAT
	aUsuario[2] := QAA->QAA_NOME
	aUsuario[3] := QAA->QAA_EMAIL
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82) // Tem que estar abaixo do RootPath

oPrint:SayBitmap(05,2000, "Logo.bmp",237,58)

oPrint:Box(80,50,230,2350)

oPrint:Say(130,400,OemToAnsi(STR0003),oFont14) //"RELATORIO DE CONTROLE AMOSTRAS INICIAIS"

oPrint:Line(80,1700,230,1700) // vertical

oPrint:Say(130,1740,OemToAnsi(STR0004),oFont10) //"No."
oPrint:Say(130,1800,QL0->QL0_RAINUM,oFontCou08)

oPrint:Box(250,50,470,2350)

oPrint:Say(270,70,OemToAnsi(STR0005),oFont12) //"IDENTIFICACAO"

oPrint:Say(270,1500,OemToAnsi(STR0006),oFont12) //"Cod. Fornecedor"
oPrint:Say(270,1900,SA1->A1_CODFOR,oFontCou08)

oPrint:Say(320,070,OemToAnsi(STR0007),oFont10) //"Razao Social"
oPrint:Say(320,300,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(370,070,OemToAnsi(STR0008),oFont10) //"Endereco"
oPrint:Say(370,300,SM0->M0_ENDCOB,oFontCou08)

oPrint:Say(420,070,OemToAnsi(STR0009),oFont10) //"Tel/Fax"
oPrint:Say(420,300,SM0->M0_TEL,oFontCou08)

oPrint:Box(490,50,3100,2350)  // 2o box, ocupa restante da pagina

oPrint:Say(510,70,OemToAnsi(STR0010),oFont12) //"IDENTIFICACAO PRODUTO"

oPrint:Say(510,1500,OemToAnsi(STR0011),oFont12) //"No. Pedido Compras"
oPrint:Say(510,2000,QL0->QL0_NUMPED,oFontCou08)

oPrint:Say(560,070,OemToAnsi(STR0012),oFont10) //"Designacao"
oPrint:Say(560,300,Subs(QK1->QK1_DESC,1,115),oFontCou08)

oPrint:Say(610,070,OemToAnsi(STR0013),oFont10) //"Ref. PSA No."
oPrint:Say(610,300,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(610,1000,OemToAnsi(STR0014),oFont10) //"Indice:"
oPrint:Say(610,1150,Subs(QK1->QK1_ALTENG,1,20),oFontCou08)

oPrint:Say(610,1500,OemToAnsi(STR0015),oFont10) //"OCM:"
oPrint:Say(610,1600,QL0->QL0_OCM,oFontCou08)

oPrint:Say(610,2000,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(610,2100,DtoC(QL0->QL0_DTOCM),oFontCou08)


oPrint:Say(660,070,OemToAnsi(STR0017),oFont10) //"Desenho PSA No."
oPrint:Say(660,400,QK1->QK1_DESCLI,oFontCou08)

oPrint:Say(710,0070,OemToAnsi(STR0018),oFont10) //"Desenho Forn. No."
oPrint:Say(710,400,QK1->QK1_NDES,oFontCou08)

oPrint:Say(710,1000,OemToAnsi(STR0014),oFont10) //"Indice:"
oPrint:Say(710,1150,QK1->QK1_REV,oFontCou08)

oPrint:Say(760,070,OemToAnsi(STR0019),oFont10) //"Nome do Arquivo da Definicao Numerica:"
oPrint:Say(760,800,QL0->QL0_NOMARQ,oFontCou08)

oPrint:Say(760,1500,OemToAnsi(STR0020),oFont10) //"Indice"
oPrint:Say(760,1700,QL0->QL0_INDARQ,oFontCou08)

oPrint:Say(760,2000,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(760,2100,DtoC(QL0->QL0_DTARQ),oFontCou08)


oPrint:Say(860,0300,OemToAnsi(STR0021),oFont10) //"Peca de Seguranca e/ou sujeita a regulamentacao"
oPrint:Say(860,1500,OemToAnsi(STR0022),oFont10) //"Sim"
oPrint:Box(860,1600,910,1650)

oPrint:Say(860,1800,OemToAnsi(STR0023),oFont10) //"Nao"
oPrint:Box(860,1900,910,1950)
If QL0->QL0_SEGREG == "1"
	oPrint:Say(860,1620,"X",oFontCou08)
Elseif QL0->QL0_SEGREG == "2"
	oPrint:Say(860,1920,"X",oFontCou08)
Endif


oPrint:Say(910,300,OemToAnsi(STR0024),oFont10) //"Materia referencia comercial"
oPrint:Say(910,800,QL0->QL0_MATREF,oFontCou08)

oPrint:Say(910,1500,OemToAnsi(STR0025),oFont10) //"Fornecedor"
oPrint:Say(910,1700,QL0->QL0_FORNEC,oFontCou08)


oPrint:Say(960,0070,OemToAnsi(STR0026),oFont10) //"Norma CDC"
oPrint:Say(960,1000,OemToAnsi(STR0027),oFont10) //"Referencia No."
oPrint:Say(960,1300,QL0->QL0_CDCNOR,oFontCou08)

oPrint:Say(960,2000,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(960,2100,DtoC(QL0->QL0_DTCDC),oFontCou08)


oPrint:Say(1010,0070,OemToAnsi(STR0028),oFont10) //"Esp. tecnica PSA"
oPrint:Say(1010,1000,OemToAnsi(STR0027),oFont10) //"Referencia No."
oPrint:Say(1010,1300,QL0->QL0_ESPPSA,oFontCou08)

oPrint:Say(1010,2000,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(1010,2100,DtoC(QL0->QL0_DTPSA),oFontCou08)


oPrint:Say(1060,0070,OemToAnsi(STR0029),oFont10) //"Padrao de aspecto - tinta + grao"
oPrint:Say(1060,1000,OemToAnsi(STR0004),oFont10) //"No."
oPrint:Say(1060,1100,QL0->QL0_PADRAO,oFontCou08)

oPrint:Say(1060,2000,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(1060,2100,DtoC(QL0->QL0_DTPADR),oFontCou08)

oPrint:Line(1110,50,1110,2350) // horizontal


// Lado esquerdo 
oPrint:Say(1160,70,OemToAnsi(STR0030),oFont12) //"IDENTIFICACAO DO ENVIO"
oPrint:Say(1210,70,OemToAnsi(STR0031),oFont12) //"MOTIVO DO ENVIO"

oPrint:Box(1310,70,1910,120)
oPrint:Line(1360,70,1360,120) // horizontal
oPrint:Line(1410,70,1410,120) // horizontal
oPrint:Line(1460,70,1460,120) // horizontal
oPrint:Line(1510,70,1510,120) // horizontal
oPrint:Line(1560,70,1560,120) // horizontal
oPrint:Line(1610,70,1610,120) // horizontal
oPrint:Line(1660,70,1660,120) // horizontal
oPrint:Line(1710,70,1710,120) // horizontal
oPrint:Line(1760,70,1760,120) // horizontal
oPrint:Line(1810,70,1810,120) // horizontal
oPrint:Line(1860,70,1860,120) // horizontal

oPrint:Say(1260+(Val(QL0->QL0_MOTENV)*50),90,"X",oFontCou08)

oPrint:Say(1310,150,OemToAnsi(STR0032),oFont10) //"Produto Novo"
oPrint:Say(1360,150,OemToAnsi(STR0033),oFont10) //"Produto Modificado"
oPrint:Say(1410,150,OemToAnsi(STR0034),oFont10) //"Produto proviniente de um novo molde"
oPrint:Say(1460,150,OemToAnsi(STR0035),oFont10) //"Produto proviniente de um molde retocado"
oPrint:Say(1510,150,OemToAnsi(STR0036),oFont10) //"Produto proviniente de um equipamento retocado"
oPrint:Say(1560,150,OemToAnsi(STR0037),oFont10) //"Produto fabricado em uma nova fabrica"
oPrint:Say(1610,150,OemToAnsi(STR0038),oFont10) //"Produto fabricado em uma nova linha"
oPrint:Say(1660,150,OemToAnsi(STR0039),oFont10) //"Reapresentacao de uma fabricacao do grupo PSA"
oPrint:Say(1710,150,OemToAnsi(STR0040),oFont10) //"Produto entregue em uma nova planta PSA"
oPrint:Say(1760,150,OemToAnsi(STR0041),oFont10) //"Processo modificado"
oPrint:Say(1810,150,OemToAnsi(STR0042),oFont10) //"Novo procedimento de fabricacao"
oPrint:Say(1860,150,OemToAnsi(STR0043),oFont10) //"Outro motivo"


// Lado direito
oPrint:Say(1160,1500,OemToAnsi(STR0044),oFont10) //"QUANTIDADE"
oPrint:Say(1160,1900,QL0->QL0_QTDE,oFontCou08)

oPrint:Say(1210,1500,OemToAnsi(STR0045),oFont10) //"No. Registro de Entrega"
oPrint:Say(1210,1900,QL0->QL0_REGENT,oFontCou08)

oPrint:Say(1260,1500,OemToAnsi(STR0046),oFont10) //"No. Etiqueta GALIA"
oPrint:Say(1260,1900,QL0->QL0_ETIQUE,oFontCou08)

oPrint:Say(1360,1500,OemToAnsi(STR0047),oFont10) //"MEIO DE FABRICACAO"

oPrint:Box(1460,1500,1660,1550)
oPrint:Line(1510,1500,1510,1550) // horizontal
oPrint:Line(1560,1500,1560,1550) // horizontal
oPrint:Line(1610,1500,1610,1550) // horizontal

oPrint:Say(1410+(Val(QL0->QL0_MEIOFA)*50),1520,"X",oFontCou08)

oPrint:Say(1460,1580,OemToAnsi(STR0048),oFont10) //"Seriado validado"
oPrint:Say(1510,1580,OemToAnsi(STR0049),oFont10) //"Seriado nao validado"
oPrint:Say(1560,1580,OemToAnsi(STR0050),oFont10) //"Nao seriado"
oPrint:Say(1610,1580,OemToAnsi(STR0051),oFont10) //"Validacao para montadora"

oPrint:Say(1710,1500,OemToAnsi(STR0052),oFont10) //"Data do equipamento definitivo"
oPrint:Say(1710,2050,DtoC(QL0->QL0_DTEQUI),oFontCou08)

oPrint:Say(1760,1500,OemToAnsi(STR0053),oFont10) //"Indice modificacao do equipamento"
oPrint:Say(1760,2080,QL0->QL0_INDMOD,oFontCou08)

oPrint:Say(1860,1500,OemToAnsi(STR0054),oFont10) //"AMOSTRAS"
oPrint:Say(1910,1500,OemToAnsi(STR0055),oFont10) //"No. da apresentacao dentro do indice"

oPrint:Box(1960,1500,2060,2200)
oPrint:Say(2010,1520,QL0->QL0_NAPRIN,oFontCou08)

oPrint:Say(2110,1500,OemToAnsi(STR0056),oFont10) //"Ref. relatorio precedente"

oPrint:Line(2160,50,2160,2350) // horizontal

oPrint:Say(2210,070,OemToAnsi(STR0057),oFont10) //"COMENTARIOS"
oPrint:Say(2260,070,Subs(QL0->QL0_EXPLIC,1,100),oFontCou08)
oPrint:Say(2310,070,Subs(QL0->QL0_EXPLIC,101,100),oFontCou08)

oPrint:Line(2360,50,2360,2350) // horizontal

oPrint:Say(2410,0070,OemToAnsi(STR0058),oFont10) //"Massa de um produto:"
oPrint:Say(2410,1000,OemToAnsi(STR0059),oFont10) //"Acondicionamento em serie:"

oPrint:Say(2410,1520,OemToAnsi(STR0022),oFont10) //"Sim"
oPrint:Box(2410,1620,2460,1670)

oPrint:Say(2410,1800,OemToAnsi(STR0023),oFont10) //"Nao"
oPrint:Box(2410,1900,2460,1950)

If QL0->QL0_ACONSE == "1"
	oPrint:Say(2410,1640,"X",oFontCou08)
Else
	oPrint:Say(2410,1920,"X",oFontCou08)
Endif

oPrint:Line(2460,50,2460,2350) // horizontal

oPrint:Say(2510,0070,OemToAnsi(STR0060),oFont10) //"COMPOSICAO DO RELATORIO"
oPrint:Say(2510,0855,OemToAnsi(STR0061),oFont10) //"ELEMENTOS ANEXOS"
oPrint:Say(2510,1620,OemToAnsi(STR0062),oFont10) //"RESPONSAVEL QUALIDADE"

oPrint:Line(2560,50,2560,2350) // horizontal

oPrint:Line(2460,0835,3100,0835) // vertical
oPrint:Line(2460,1600,3100,1600) // vertical

// 1o box
oPrint:Box(2610,70,2810,120)
oPrint:Line(2660,70,2660,120) // horizontal
oPrint:Line(2710,70,2710,120) // horizontal
oPrint:Line(2760,70,2760,120) // horizontal

If QL0->QL0_RELDIM == "1"
	oPrint:Say(2610,90,"X",oFontCou08)
Endif

If QL0->QL0_RELMAT == "1"
	oPrint:Say(2660,90,"X",oFontCou08)
Endif

If QL0->QL0_RELESP == "1"
	oPrint:Say(2710,90,"X",oFontCou08)
Endif

If QL0->QL0_RELESM == "1"
	oPrint:Say(2760,90,"X",oFontCou08)
Endif

oPrint:Say(2610,150,OemToAnsi(STR0063),oFont10) //"Relatorio dimensional"
oPrint:Say(2660,150,OemToAnsi(STR0064),oFont10) //"Relatorio materia prima"
oPrint:Say(2710,150,OemToAnsi(STR0065),oFont10) //"Relatorio especificacoes"
oPrint:Say(2760,150,OemToAnsi(STR0066),oFont10) //"Relatorio especificacoes mat."


// 2o box
oPrint:Box(2610,855,2760,905)
oPrint:Line(2660,855,2660,905) // horizontal
oPrint:Line(2710,855,2710,905) // horizontal

If QL0->QL0_COPIAP == "1"
	oPrint:Say(2610,875,"X",oFontCou08)
Endif

If QL0->QL0_PLACA == "1"
	oPrint:Say(2660,875,"X",oFontCou08)
Endif

If QL0->QL0_PVACEI == "1"
	oPrint:Say(2710,875,"X",oFontCou08)
Endif

oPrint:Say(2610,935,OemToAnsi(STR0067),oFont10) //"Copia P.V. do ensaio oficial"
oPrint:Say(2660,935,OemToAnsi(STR0068),oFont10) //"Placas amostras"
oPrint:Say(2710,935,OemToAnsi(STR0069),oFont10) //"PV de aceitacao da 1a planta utilizadaora"

//3o box
oPrint:Say(2610,1620,OemToAnsi(STR0070),oFont10) //"Nome:"
oPrint:Say(2610,1800,aUsuario[2],oFontCou08)

oPrint:Say(2660,1620,OemToAnsi(STR0071),oFont10) //"Endereco:"
oPrint:Say(2710,1620,OemToAnsi(STR0072),oFont10) //"Tel:"
oPrint:Say(2760,1620,OemToAnsi(STR0073),oFont10) //"Ass.:"

oPrint:Say(2860,1620,OemToAnsi(STR0016),oFont10) //"Data:"
oPrint:Say(2860,1800,DtoC(QL0->QL0_DTAPRO),oFontCou08)

oPrint:Say(2910,1620,OemToAnsi(STR0074),oFont10) //"Estado de utilizacao estimado"

oPrint:Box(2960,1620,3060,2200)
oPrint:Say(3010,1640,QL0->QL0_ESTADO,oFontCou08)


oPrint:EndPage() 		// Finaliza a pagina     

Return Nil