/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR350.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR350  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 03.12.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³PPAP VDA Folha de Capa                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR350(void)                                              ³±±
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

User Function QPPR350(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev 	:= ""

Default lBrow 		:= .F.
Default cPecaAuto	:= ""  
Default cJPEG       := ""  

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"VDA Folha de Capa"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA350"
		cPecaRev := Iif(!lBrow, M->QL1_PECA + M->QL1_REV, QL1->QL1_PECA + QL1->QL1_REV)
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

DbSelectArea("QL1")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Relatorio, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
		   oPrint:SaveAllAsJPEG(cStartPath+cJPEG,875,1170,140)
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 03.12.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ VDA Folha de Capa                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR350                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                         

Static Function MontaRel(oPrint)

Local lin 	:= 1150
Local x		:= 0
Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local aUsuario	:= {"","",""}
Local oFont16, oFont08, oFont10, oFontCou08
Local nLib		:= 0
Local nLibRes	:= 0
Local nRep		:= 0
Local cTot		:= ""

oFont16		:= TFont():New("Arial" ,16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial" ,08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial" ,10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

QAA->(DbSetOrder(6))

If QAA->(DbSeek(Trim(Upper(QL1->QL1_APROVA)))) .and. !Empty(QL1->QL1_DTAPRO)
	aUsuario[1] := QAA->QAA_MAT
	aUsuario[2] := QAA->QAA_NOME
	aUsuario[3] := QAA->QAA_EMAIL
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(40,1100,STR0003,oFont16) //"- Capa -"

//lado esquerdo
oPrint:Say(250,050,STR0004,oFont10) //"Remetente:"
oPrint:Say(300,050,SM0->M0_NOMECOM,oFontCou08)
oPrint:Say(350,050,SM0->M0_ENDCOB,oFontCou08)

oPrint:Say(400,050,SM0->M0_CIDCOB,oFontCou08)
oPrint:Say(400,500,SM0->M0_ESTCOB,oFontCou08)
oPrint:Say(400,750,SM0->M0_CEPCOB,oFontCou08)

oPrint:Say(450,050,cPaisLoc,oFontCou08)
oPrint:Say(500,050,STR0005,oFont10) //"Codigo:"
oPrint:Say(500,250,SA1->A1_CODFOR,oFontCou08)

oPrint:Line(550,50,550,1150)  // horizontal

oPrint:Say(600,50,STR0006,oFont10) //"Destinatario:"
oPrint:Say(650,050,SA1->A1_NOME,oFontCou08)
oPrint:Say(700,050,SA1->A1_END,oFontCou08)

oPrint:Say(750,050,SA1->A1_MUN,oFontCou08)
oPrint:Say(750,500,SA1->A1_EST,oFontCou08)
oPrint:Say(750,750,SA1->A1_CEP,oFontCou08)

oPrint:Say(800,050,SA1->A1_PAIS,oFontCou08)


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

oPrint:Say(250,1520,STR0007,oFont10) //"Relatorio VDA de amostra inicial"
If QL1->QL1_VDAAMO == "1"
	oPrint:Say(250,1470,"X",oFontCou08)
Endif

oPrint:Say(300,1520,STR0008,oFont10) //"Amostra inicial"
If QL1->QL1_AMOINI == "1"
	oPrint:Say(300,1470,"X",oFontCou08)
Endif

oPrint:Say(350,1520,STR0009,oFont10) //"Amostra posterior"
If QL1->QL1_AMOPOS == "1"
	oPrint:Say(350,1470,"X",oFontCou08)
Endif

oPrint:Say(400,1520,STR0010,oFont10) //"Peca nova"
If QL1->QL1_PCNOVA == "1"
	oPrint:Say(400,1470,"X",oFontCou08)
Endif

oPrint:Say(450,1520,STR0011,oFont10) //"Alteracao de produto"
If QL1->QL1_ALTPRO == "1"
	oPrint:Say(450,1470,"X",oFontCou08)
Endif

oPrint:Say(500,1520,STR0012,oFont10) //"Postergacao da producao"
If QL1->QL1_POSPRO == "1"
	oPrint:Say(500,1470,"X",oFontCou08)
Endif

oPrint:Say(550,1520,STR0013,oFont10) //"Alteracao de processos de producao"
If QL1->QL1_ALPROC == "1"
	oPrint:Say(550,1470,"X",oFontCou08)
Endif

oPrint:Say(600,1520,STR0014,oFont10) //"Interrupcao maior de producao"
If QL1->QL1_INTPRO == "1"
	oPrint:Say(600,1470,"X",oFontCou08)
Endif

oPrint:Say(650,1520,STR0015,oFont10) //"Subfornecedor novo"
If QL1->QL1_SUBNOV == "1"
	oPrint:Say(650,1470,"X",oFontCou08)
Endif

oPrint:Say(700,1520,STR0016,oFont10) //"Produto com DAE"
If QL1->QL1_PRODAE == "1"
	oPrint:Say(700,1470,"X",oFontCou08)
Endif

oPrint:Say(750,1520,STR0017,oFont10) //"Elaborado plano de producao/inspecao"
If QL1->QL1_PLPROD == "1"
	oPrint:Say(750,1470,"X",oFontCou08)
Endif

oPrint:Say(800,1520,STR0018,oFont10) //"FMEA realizado"
If QL1->QL1_FMEARE == "1"
	oPrint:Say(800,1470,"X",oFontCou08)
Endif

oPrint:Say(850,1520,STR0019,oFont10) //"Relatorio demais amostras"
If QL1->QL1_RELDEM == "1"
	oPrint:Say(850,1470,"X",oFontCou08)
Endif

oPrint:Box(950,30,1370,2370)

oPrint:Say(960,1100,STR0020,oFont10) //"Anexos"
oPrint:Line(1000,30,1000,2370)  // horizontal

oPrint:Box(1050,50,1350,100)
oPrint:Line(1100,50,1100,100)	// horizontal
oPrint:Line(1150,50,1150,100)	// horizontal
oPrint:Line(1200,50,1200,100)	// horizontal
oPrint:Line(1250,50,1250,100)	// horizontal
oPrint:Line(1300,50,1300,100)	// horizontal

oPrint:Say(1050,120,STR0021,oFont10) //"01 Teste de funcao"
If Subs(QL1->QL1_TSTFUN,1,1) == "1"
	oPrint:Say(1050,70,"X",oFontCou08)
Endif

oPrint:Say(1100,120,STR0022,oFont10) //"02 Teste de medicao"
If Subs(QL1->QL1_TSTMED,1,1) == "1"
	oPrint:Say(1100,70,"X",oFontCou08)
Endif

oPrint:Say(1150,120,STR0023,oFont10) //"03 Teste de material"
If Subs(QL1->QL1_TSTMAT,1,1) == "1"
	oPrint:Say(1150,70,"X",oFontCou08)
Endif

oPrint:Say(1200,120,STR0024,oFont10) //"04 Teste de resistencia"
If Subs(QL1->QL1_TSTRES,1,1) == "1"
	oPrint:Say(1200,70,"X",oFontCou08)
Endif

oPrint:Say(1250,120,STR0025,oFont10) //"05 Comprov. de capaciade do processo"
If Subs(QL1->QL1_COMCAP,1,1) == "1"
	oPrint:Say(1250,70,"X",oFontCou08)
Endif

oPrint:Say(1300,120,STR0026,oFont10) //"06 Diagrama de decurso do processo"
If Subs(QL1->QL1_DIAGRA,1,1) == "1"
	oPrint:Say(1300,70,"X",oFontCou08)
Endif

oPrint:Box(1050,800,1350,850)
oPrint:Line(1100,800,1100,850)	// horizontal
oPrint:Line(1150,800,1150,850)	// horizontal
oPrint:Line(1200,800,1200,850)	// horizontal
oPrint:Line(1250,800,1250,850)	// horizontal
oPrint:Line(1300,800,1300,850)	// horizontal

oPrint:Say(1050,870,STR0027,oFont10) //"07 Comprovacao da capac. instr. de teste"
If Subs(QL1->QL1_COMCPT,1,1) == "1"
	oPrint:Say(1050,820,"X",oFontCou08)
Endif

oPrint:Say(1100,870,STR0028,oFont10) //"08 Lista de intrumentos de teste"
If Subs(QL1->QL1_LISINS,1,1) == "1"
	oPrint:Say(1100,820,"X",oFontCou08)
Endif

oPrint:Say(1150,870,STR0029,oFont10) //"09 Folha EG de seguranca de dados"
If Subs(QL1->QL1_FOLHEG,1,1) == "1"
	oPrint:Say(1150,820,"X",oFontCou08)
Endif

oPrint:Say(1200,870,STR0030,oFont10) //"10 Tato"
If Subs(QL1->QL1_TATO,1,1) == "1"
	oPrint:Say(1200,820,"X",oFontCou08)
Endif

oPrint:Say(1250,870,STR0031,oFont10) //"11 Acustica"
If Subs(QL1->QL1_ACUSTI,1,1) == "1"
	oPrint:Say(1250,820,"X",oFontCou08)
Endif

oPrint:Say(1300,870,STR0032,oFont10) //"12 Cheiro"
If Subs(QL1->QL1_CHEIRO,1,1) == "1"
	oPrint:Say(1300,820,"X",oFontCou08)
Endif

oPrint:Box(1050,1600,1300,1650)
oPrint:Line(1100,1600,1100,1650)	// horizontal
oPrint:Line(1150,1600,1150,1650)	// horizontal
oPrint:Line(1200,1600,1200,1650)	// horizontal
oPrint:Line(1250,1600,1250,1650)	// horizontal

oPrint:Say(1050,1670,STR0033,oFont10) //"13 Aspecto geral"
If Subs(QL1->QL1_GERAL,1,1) == "1"
	oPrint:Say(1050,1620,"X",oFontCou08)
Endif

oPrint:Say(1100,1670,STR0034,oFont10) //"14 Certificados"
If Subs(QL1->QL1_CERTIF,1,1) == "1"
	oPrint:Say(1100,1620,"X",oFontCou08)
Endif

oPrint:Say(1150,1670,STR0035,oFont10) //"15 Liberacao de construcao"
If Subs(QL1->QL1_LIBCON,1,1) == "1"
	oPrint:Say(1150,1620,"X",oFontCou08)
Endif

oPrint:Say(1200,1670,STR0036,oFont10) //"16 Material de comp. em pecas compradas"
If Subs(QL1->QL1_MATCOM,1,1) == "1"
	oPrint:Say(1200,1620,"X",oFontCou08)
Endif

oPrint:Say(1250,1670,STR0037,oFont10) //"17 Outros"
If Subs(QL1->QL1_OUTROS,1,1) == "1"
	oPrint:Say(1250,1620,"X",oFontCou08)
Endif

lin := 1400
oPrint:Box(lin,30,lin+620,2370)
oPrint:Line(lin,1150,lin+620,1150) //vertical

oPrint:Say(lin+20,070,STR0038,oFont10) //"No. do Fornecedor:"
oPrint:Say(lin+20,600,SA1->A1_CODFOR,oFontCou08)

oPrint:Say(lin+20,1170,STR0039,oFont10) //"No. do Cliente:"
oPrint:Say(lin+20,1700,QL1->QL1_IDCLI,oFontCou08)

oPrint:Line(lin+70,30,lin+70,2370) //horizontal

oPrint:Say(lin+100,070,STR0040,oFont10) //"No. de Relatorio"
oPrint:Say(lin+100,400,QL1->QL1_NURELF,oFontCou08)

oPrint:Say(lin+100,1170,STR0040,oFont10) //"No. de Relatorio"
oPrint:Say(lin+100,1500,QL1->QL1_NURELC,oFontCou08)

oPrint:Say(lin+100,700,STR0041,oFont10) //"Versao"
oPrint:Say(lin+100,850,QL1->QL1_VERELF,oFontCou08)

oPrint:Say(lin+100,1900,STR0041,oFont10) //"Versao"
oPrint:Say(lin+100,2050,QL1->QL1_VERELC,oFontCou08)

oPrint:Line(lin+150,30,lin+150,2370) //horizontal

// lado esquerdo
oPrint:Say(lin+170,070,STR0042,oFont10) //"No. de familia:"
oPrint:Say(lin+170,400,QK1->QK1_PECA,oFontCou08)

oPrint:Say(lin+220,070,STR0043,oFont10) //"No. de Desenho:"
oPrint:Say(lin+220,400,QK1->QK1_NDES,oFontCou08)

oPrint:Say(lin+270,070,STR0044,oFont10) //"Status/Data:"
oPrint:Say(lin+270,400,QL1->QL1_STATUF,oFontCou08)

oPrint:Say(lin+320,070,STR0045,oFont10) //"No. de alteracao:"
oPrint:Say(lin+320,400,QK1->QK1_REV,oFontCou08)

oPrint:Say(lin+370,0070,STR0046,oFont10) //"Denominacao:"
oPrint:Say(lin+370,400,Subs(QK1->QK1_DESC,1,40),oFontCou08)

// lado direito
oPrint:Say(lin+170,1170,STR0042,oFont10) //"No. de familia:"
oPrint:Say(lin+170,1500,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(lin+220,1170,STR0043,oFont10) //"No. de Desenho:"
oPrint:Say(lin+220,1500,QK1->QK1_DESCLI,oFontCou08)
                      
oPrint:Say(lin+270,1170,STR0044,oFont10) //"Status/Data:"
oPrint:Say(lin+270,1500,QL1->QL1_STATUC,oFontCou08)

oPrint:Say(lin+320,1170,STR0045,oFont10) //"No. de alteracao:"
oPrint:Say(lin+320,1500,Subs(QK1->QK1_ALTENG,1,50),oFontCou08)

oPrint:Say(lin+370,1170,STR0046,oFont10) //"Denominacao:"
oPrint:Say(lin+370,1500,QL1->QL1_DENCLI,oFontCou08)

oPrint:Line(lin+420,30,lin+420,2370) //horizontal


oPrint:Say(lin+430,070,STR0047,oFont10) //"No./Data de Nota Fiscal:"
oPrint:Say(lin+430,500,QL1->QL1_NDTNFI,oFontCou08)

oPrint:Say(lin+430,1170,STR0048,oFont10) //"No./Data de Entrega do Produto:"
oPrint:Say(lin+430,1700,QL1->QL1_NDTENT,oFontCou08)

oPrint:Line(lin+480,30,lin+480,2370) //horizontal

oPrint:Say(lin+490,0070,STR0049,oFont10) //"Quantidade fornecida:"
oPrint:Say(lin+490,500,QL1->QL1_QTDFOR,oFontCou08)

oPrint:Say(lin+490,1170,STR0050,oFont10) //"Local para descarregar:"
oPrint:Say(lin+490,1600,QL1->QL1_LOCALD,oFontCou08)

oPrint:Say(lin+530,070,STR0051,oFont10) //"No. de Carga:"
oPrint:Say(lin+530,500,QL1->QL1_NUMCAR,oFontCou08)

oPrint:Say(lin+570,070,STR0052,oFont10) //"Peso Padrao:"
oPrint:Say(lin+570,500,QL1->QL1_PESO,oFontCou08)

lin += 640
oPrint:Box(lin,30,lin+300,2370)
oPrint:Say(lin+10,70,STR0053,oFont10) //"Confirmacao do fornecedor:"
oPrint:Say(lin+50,70,STR0054,oFont10) //"Confirmamos que a amostra foi realizada de acordo com a VDA volume 2 item 4."

oPrint:Line(lin+90,30,lin+90,2370)		//horizontal
oPrint:Line(lin+90,1150,lin+300,1150) 	//vertical

// lado esquerdo
oPrint:Say(lin+100,070,STR0055,oFont10) //"Nome:"
oPrint:Say(lin+100,400,aUsuario[2],oFontCou08)

oPrint:Say(lin+150,070,STR0056,oFont10)  //"Departamento:"
oPrint:Say(lin+200,070,STR0057,oFont10) //"Telefone/Fax/E-mail:"
oPrint:Say(lin+200,400,aUsuario[3],oFontCou08)

oPrint:Say(lin+250,070,STR0058,oFont10)  //"Data:"
oPrint:Say(lin+250,200,DtoC(QL1->QL1_DTAPRO),oFontCou08)

oPrint:Say(lin+250,500,STR0059,oFont08) //"Assinatura:"

// lado direito
oPrint:Say(lin+100,1170,STR0060,oFont10) //"Observacao:"
oPrint:Say(lin+100,1400,Subs(QL1->QL1_OBSFOR,001,50),oFontCou08)
oPrint:Say(lin+150,1400,Subs(QL1->QL1_OBSFOR,051,50),oFontCou08)
oPrint:Say(lin+200,1400,Subs(QL1->QL1_OBSFOR,101,50),oFontCou08)
oPrint:Say(lin+250,1400,Subs(QL1->QL1_OBSFOR,151,50),oFontCou08)

lin += 320
oPrint:Box(lin,30,3100,2370)

oPrint:Say(lin+10,0070,STR0061,oFont10) //"Decisao do Cliente"
oPrint:Line(lin,900,lin+240,900)  //vertical
oPrint:Line(lin,1170,lin+240,1170)  //vertical
oPrint:Say(lin+10,1000,STR0062,oFont10) //"Total"
oPrint:Say(lin+10,1600,STR0063,oFont08) //"De acordo com Anexo:"

oPrint:Say(lin+100,70,STR0064,oFont10) //"Liberacao"
oPrint:Say(lin+150,70,STR0065,oFont10) //"Liberacao com restricoes"
oPrint:Say(lin+200,70,STR0066,oFont10) //"Reprovado, necessaria amostra posterior"

oPrint:Line(lin+040,1170,lin+040,2370)  //horizontal
oPrint:Line(lin+090,0030,lin+090,2370)  //horizontal
oPrint:Line(lin+140,0030,lin+140,2370)  //horizontal
oPrint:Line(lin+190,0030,lin+190,2370)  //horizontal
oPrint:Line(lin+240,0030,lin+240,2370)  //horizontal

For x := 1 To 17
	oPrint:Say(lin+50,1110+(x*70),StrZero(x,2),oFont10)
	oPrint:Line(lin+40,1100+(x*70),lin+240,1100+(x*70))  //vertical
	Do Case
		Case x == 1;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_TSTFUN,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_TSTFUN,2,1))>=1,"X",""),oFontCou08)
		Case x == 2;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_TSTMED,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_TSTMED,2,1))>=1,"X",""),oFontCou08)
		Case x == 3;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_TSTMAT,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_TSTMAT,2,1))>=1,"X",""),oFontCou08)
		Case x == 4;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_TSTRES,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_TSTRES,2,1))>=1,"X",""),oFontCou08)
		Case x == 5;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_COMCAP,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_COMCAP,2,1))>=1,"X",""),oFontCou08)
		Case x == 6;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_DIAGRA,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_DIAGRA,2,1))>=1,"X",""),oFontCou08)
		Case x == 7;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_COMCPT,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_COMCPT,2,1))>=1,"X",""),oFontCou08)
		Case x == 8;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_LISINS,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_LISINS,2,1))>=1,"X",""),oFontCou08)
		Case x == 9;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_FOLHEG,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_FOLHEG,2,1))>=1,"X",""),oFontCou08)
		Case x == 10;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_TATO,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_TATO,2,1))>=1,"X",""),oFontCou08)
		Case x == 11;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_ACUSTI,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_ACUSTI,2,1))>=1,"X",""),oFontCou08)
		Case x == 12;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_CHEIRO,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_CHEIRO,2,1))>=1,"X",""),oFontCou08)
		Case x == 13;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_GERAL,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_GERAL,2,1))>=1,"X",""),oFontCou08)
		Case x == 14;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_CERTIF,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_CERTIF,2,1))>=1,"X",""),oFontCou08)
		Case x == 15;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_LIBCON,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_LIBCON,2,1))>=1,"X",""),oFontCou08)
		Case x == 16;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_MATCOM,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_MATCOM,2,1))>=1,"X",""),oFontCou08)
		Case x == 17;	oPrint:Say(lin+50+(Val(Subs(QL1->QL1_OUTROS,2,1))*50),1120+(x*70),Iif(Val(Subs(QL1->QL1_OUTROS,2,1))>=1,"X",""),oFontCou08)
	Endcase
Next x

cTot += Subs(QL1->QL1_TSTFUN,2,1) + Subs(QL1->QL1_TSTMED,2,1) + Subs(QL1->QL1_TSTMAT,2,1)
cTot += Subs(QL1->QL1_TSTRES,2,1) + Subs(QL1->QL1_COMCAP,2,1) + Subs(QL1->QL1_DIAGRA,2,1)
cTot += Subs(QL1->QL1_COMCPT,2,1) + Subs(QL1->QL1_LISINS,2,1) + Subs(QL1->QL1_FOLHEG,2,1)
cTot += Subs(QL1->QL1_TATO,2,1) + Subs(QL1->QL1_ACUSTI,2,1) + Subs(QL1->QL1_CHEIRO,2,1)
cTot += Subs(QL1->QL1_GERAL,2,1) + Subs(QL1->QL1_CERTIF,2,1) + Subs(QL1->QL1_LIBCON,2,1)
cTot += Subs(QL1->QL1_MATCOM,2,1) + Subs(QL1->QL1_OUTROS,2,1)

For x := 1 To Len(cTot)
	If Subs(cTot,x,1) == "1"
		nLib++
	Elseif Subs(cTot,x,1) == "2"
		nLibres++
	Elseif Subs(cTot,x,1) == "3"
		nRep++
	Endif
Next x

oPrint:Say(lin+100,1030,Str(nLib,2),oFontCou08)
oPrint:Say(lin+150,1030,Str(nLibres,2),oFontCou08)
oPrint:Say(lin+200,1030,Str(nRep,2),oFontCou08)

lin += 250

oPrint:Say(lin,070,STR0067,oFont10) //"No. Licenca para desvio:"
oPrint:Say(lin,500,QL1->QL1_NLIDES,oFontCou08)
oPrint:Line(lin+50,30,lin+50,2370)  //horizontal

oPrint:Say(lin+70,070,STR0068,oFont10) //"Em caso de envio de retorno, no./data nota fiscal:"
oPrint:Say(lin+70,900,QL1->QL1_RETNFI,oFontCou08)
oPrint:Line(lin+120,30,lin+120,2370)  //horizontal

// lado esquerdo
oPrint:Line(lin+120,1150,lin+400,1150) //vertical
oPrint:Say(lin+150,070,STR0055,oFont10) //"Nome:"
oPrint:Say(lin+150,400,QL1->QL1_NOMEC,oFontCou08)

oPrint:Say(lin+200,070,STR0056,oFont10)  //"Departamento:"
oPrint:Say(lin+200,400,QL1->QL1_DEPTOC,oFontCou08)

oPrint:Say(lin+250,070,STR0057,oFont10) //"Telefone/Fax/E-mail:"
oPrint:Say(lin+250,400,QL1->QL1_FONEC,oFontCou08)

oPrint:Line(lin+300,30,lin+300,1150)  //horizontal
oPrint:Say(lin+350,070,STR0058,oFont10)  //"Data:"
oPrint:Say(lin+350,200,DtoC(QL1->QL1_DTAPCL),oFontCou08)

oPrint:Say(lin+350,500,STR0059,oFont08) //"Assinatura:"

// lado direito
oPrint:Say(lin+150,1170,STR0060,oFont10) //"Observacao:"
oPrint:Say(lin+150,1400,Subs(QL1->QL1_OBSCLI,001,50),oFontCou08)
oPrint:Say(lin+200,1400,Subs(QL1->QL1_OBSCLI,051,50),oFontCou08)
oPrint:Say(lin+250,1400,Subs(QL1->QL1_OBSCLI,101,50),oFontCou08)
oPrint:Say(lin+300,1400,Subs(QL1->QL1_OBSCLI,151,50),oFontCou08)
oPrint:Line(lin+400,30,lin+400,2370)  //horizontal

oPrint:Say(lin+430,70,STR0069,oFont10) //"Ditribuicao:"

For x := 1 To 14
	oPrint:Say(lin+430,910+(x*100),StrZero(x,2),oFont10)
	oPrint:Line(lin+400,870+(x*100),3100,870+(x*100))  //vertical
Next x

Return Nil
