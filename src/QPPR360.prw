/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR360.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR360  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ VDA Amostras Iniciais                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR360(void)                                              ³±±
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

User Function QPPR360(lBrow,cPecaAuto,cJPEG)

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

oPrint := TMSPrinter():New(STR0001) //"VDA Amostras Iniciais"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA360"
		cPecaRev := Iif(!lBrow, M->QL2_PECA + M->QL2_REV, QL2->QL2_PECA + QL2->QL2_REV)
	Else
		lPergunte := Pergunte("PPR180",.T.)

		If lPergunte
			cPecaRev := mv_par01 + mv_par02	
		Else
			Return Nil
		Endif
	Endif
Endif

PPAPBMP("A5.BMP", cStartPath)

DbSelectArea("QL1")
DbSetOrder(1)
If !DbSeek(xFilial()+cPecaRev)
	If Empty(cPecaAuto)
		Help(" ",1,"VDACAPA")  // "Antes e necessario fazer o VDA folha de capa !"
	Endif
	Return Nil
Endif

DbSelectArea("QK1")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

DbSelectArea("SA1")
DbSetOrder(1)
DbSeek(xFilial("SA1") + QK1->QK1_CODCLI + QK1->QK1_LOJCLI)

DbSelectArea("QL3")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

DbSelectArea("QL2")
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³VDA Amostras Iniciais                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontaRel(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR360                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                                                         

Static Function MontaRel(oPrint)

Local i 	:= 2
Local lin 	:= 860
Local cFileLogo := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial" ,16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial" ,08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial" ,10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

oPrint:StartPage() 		// Inicia uma nova pagina

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,600,STR0003,oFont16) //"Relatorio VDA de Inspecao de Amostras Iniciais"
oPrint:Say(090,500,STR0004,oFont16) //"Material de Pecas Compradas(Folha de Dados de Material)"

oPrint:Say(200,50,STR0005,oFont10) //"1. Denominacao da Empresa e do Produto"

oPrint:Box(250,50,950,2350)
oPrint:Line(250,1150,850,1150)	// vertical
oPrint:Line(850,0050,850,2350)	// horizontal


// Lado esquerdo
oPrint:Say(300,70,STR0006,oFont10) //"1.1 Dados do fabricante/fornecedor"

oPrint:Say(400,070,STR0007,oFont10) //"Nome"
oPrint:Say(400,350,SM0->M0_NOMECOM,oFontCou08)

oPrint:Say(450,070,STR0008,oFont10) //"Rua/Caixa Postal"
oPrint:Say(450,400,SM0->M0_ENDCOB,oFontCou08)

oPrint:Say(500,070,STR0009,oFont10) //"CEP/Cidade"
oPrint:Say(500,350,SM0->M0_CEPCOB+"/"+SM0->M0_CIDCOB,oFontCou08)

oPrint:Say(550,070,STR0010,oFont10) //"Responsavel"
oPrint:Say(550,350,QL2->QL2_APROVA,oFontCou08)

oPrint:Say(600,070,STR0011,oFont10) //"Telefone/Fax"
oPrint:Say(600,350,SM0->M0_TEL,oFontCou08)

oPrint:Say(900,70,STR0012,oFont10) //"Assinatura de Responsaveis:"

// Lado esquerdo
oPrint:Say(300,1170,STR0013,oFont10) //"1.2 Dados do produto"

oPrint:Say(400,1170,STR0014,oFont10) //"Peca:"
oPrint:Say(400,1300,Subs(QK1->QK1_DESC,1,60),oFontCou08)

oPrint:Say(450,1170,STR0015,oFont10) //"No. do Relatorio de Amostra:"
oPrint:Say(450,1700,QL1->QL1_NURELC,oFontCou08)

oPrint:Say(500,1170,STR0016,oFont10) //"No. de ZSB:"
oPrint:Say(500,1500,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(550,1170,STR0017,oFont10) //"No. de Pedido:"
oPrint:Say(550,1500,QL1->QL1_NPEDDT,oFontCou08)

oPrint:Say(600,1170,STR0018,oFont10) //"No. de Artigo:"
oPrint:Say(600,1500,QL2->QL2_NUMART,oFontCou08)

oPrint:Say(700,1170,STR0019,oFont10) //"No. de Nota Fiscal:"
oPrint:Say(700,1500,QL1->QL1_NDTNFI,oFontCou08)

oPrint:Say(750,1170,STR0020,oFont10) //"Alteracao:"
oPrint:Say(750,1500,QK1->QK1_REV,oFontCou08)

oPrint:Say(800,1170,STR0021,oFont10) //"Data:"
oPrint:Say(800,1500,QL1->QL1_STATUC,oFontCou08)

oPrint:Say(1000,50,STR0022,oFont10) //"2. Seguranca e Meio-Ambiente"
oPrint:Say(1100,50,STR0023,oFont10) //"Materiais que, de acordo com a lei, estao submetidos a uma proibicao de utilizacao nao podem"
oPrint:Say(1150,50,STR0024,oFont10) //"ser utilizados!"
oPrint:Say(1200,50,STR0025,oFont10) //"Veja: Lista VDA sobre materiais com obrigatoriedade de declaracao."
oPrint:Say(1250,50,STR0026,oFont10) //"Assinalar a resposta certa"

oPrint:SayBitmap(1360,100,"A5.BMP",20,20)
oPrint:Say(1350,150,STR0027,oFont10) //"As pecas contem material com caracteristica de periculosidade de acordo com"
oPrint:Say(1400,150,STR0028,oFont10) //"ChemG/GefStoffV (controle de substancias perigosas, toxicos ou quimicos) ?"
oPrint:Say(1450,250,STR0029,oFont10) //"Nao"
oPrint:Say(1500,250,STR0030,oFont10) //'Sim   (Caracteristicas de acordo com GefStoffV e concentracoes devem ser declaradas em "componentes")'

oPrint:Box(1450,150,1550,200)
oPrint:Line(1500,150,1500,200)  // horizontal
oPrint:Say(Iif(QL2->QL2_CHEMG == "1",1500,1450),170,"X",oFontCou08)

oPrint:SayBitmap(1610,100,"A5.BMP",20,20)
oPrint:Say(1600,150,STR0031,oFont10) //"Com manuseio adequado da peca podem ocorrer ou serem liberadas substancias perigosas ?"
oPrint:Say(1650,150,STR0032,oFont10) //"(veja lista VDA para substancias com obrigatoriedade de declaracao)"
oPrint:Say(1700,250,STR0029,oFont10) //"Nao"
oPrint:Say(1750,250,STR0033,oFont10) //"Sim   (Preencher item 10 da folha de seguranca de dados EG)"

oPrint:Box(1700,150,1800,200)
oPrint:Line(1750,150,1750,200)  // horizontal
oPrint:Say(Iif(QL2->QL2_MANUAD == "1",1750,1700),170,"X",oFontCou08)


oPrint:SayBitmap(1860,100,"A5.BMP",20,20)
oPrint:Say(1850,150,STR0034,oFont10) //"A peca e um bem perigoso de acordo com a legislacao de transito ?"
oPrint:Say(1900,150,STR0035,oFont10) //"(Legislacao de transporte)"
oPrint:Say(1950,250,STR0029,oFont10) //"Nao"
oPrint:Say(2000,250,STR0036,oFont10) //"Sim"

oPrint:Box(1950,150,2050,200)
oPrint:Line(2000,150,2000,200)  // horizontal
oPrint:Say(Iif(QL2->QL2_BEMPER == "1",2000,1950),170,"X",oFontCou08)

oPrint:SayBitmap(2110,100,"A5.BMP",20,20)
oPrint:Say(2100,150,STR0037,oFont10) //"A peca contem substancias perigosas para a agua, de acordo com a legislacao da agua ?"
oPrint:Say(2150,250,STR0029,oFont10) //"Nao"
oPrint:Say(2200,250,STR0038,oFont10) //"Sim   (Indicar quantidade e classe de perigo de contaminacao das aguas)"

oPrint:Box(2150,150,2250,200)
oPrint:Line(2200,150,2200,200)  // horizontal
If QL2->QL2_SUBPER == "1"
	oPrint:Say(2200,170,"X",oFontCou08)
	oPrint:Say(2200,1500,QL2->QL2_QTDCOM,oFontCou08)
Else
	oPrint:Say(2150,170,"X",oFontCou08)
Endif	

oPrint:SayBitmap(2310,100,"A5.BMP",20,20)
oPrint:Say(2300,150,STR0039,oFont10) //"A peca foi tratada com biocidas ?"
oPrint:Say(2350,250,STR0029,oFont10) //"Nao"
oPrint:Say(2400,250,STR0040,oFont10) //"Sim   (Teores > 0,1% devem ser indicados)"

oPrint:Box(2350,150,2450,200)
oPrint:Line(2400,150,2400,200)  // horizontal
If QL2->QL2_TRABIO == "1"
	oPrint:Say(2400,170,"X",oFontCou08)
	oPrint:Say(2400,1500,QL2->QL2_TEORES,oFontCou08)
Else
	oPrint:Say(2350,170,"X",oFontCou08)
Endif	

oPrint:SayBitmap(2510,100,"A5.BMP",20,20)
oPrint:Say(2500,150,STR0041,oFont10) //"Apos a utilizacao da peca podem surgir residuos aos quais sao relacionados codigo EAK-code ?"
oPrint:Say(2550,250,STR0029,oFont10) //"Nao"
oPrint:Say(2600,250,STR0036,oFont10) //"Sim"

oPrint:Box(2550,150,2650,200)
oPrint:Line(2600,150,2600,200)  // horizontal
If QL2->QL2_EAKCOD == "1"
	oPrint:Say(2600,170,"X",oFontCou08)
	oPrint:Say(2600,1500,QL2->QL2_EAKNUM,oFontCou08)
Else
	oPrint:Say(2550,170,"X",oFontCou08)
Endif	

oPrint:Say(2700,250,STR0042,oFont10) //"A tabela seguinte deve ser totalmente preenchida"
oPrint:EndPage()

Cabecalho(oPrint,i)  			// Funcao que monta o cabecalho

DbSelectArea("QL3")
                                                           
Do While !Eof() .and. QL3->QL3_PECA+QL3->QL3_REV == cPecaRev

	lin += 40
	
	If lin > 3060
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		oPrint:StartPage() 		// Inicia uma nova pagina
		Cabecalho(oPrint,i)		// Funcao que monta o cabecalho
		lin := 900
	Endif

	oPrint:Say(lin,0020,QL3->QL3_NPEMAT,oFontCou08)

	oPrint:Say(lin,0370,QL3->QL3_NOMEPC,oFontCou08)

	oPrint:Say(lin,0720,QL3->QL3_COMZSB,oFontCou08)

	oPrint:Say(lin,1070,QL3->QL3_MASSA,oFontCou08)

	oPrint:Say(lin,1330,QL3->QL3_MATESP,oFontCou08)

	oPrint:Say(lin,1680,QL3->QL3_SUBCAS,oFontCou08)

	oPrint:Say(lin,1940,QL3->QL3_DENMAT,oFontCou08)

	oPrint:Say(lin,2200,QL3->QL3_TEOR,oFontCou08)
		
	DbSkip()

Enddo

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.11.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Cabecalho do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR360                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(040,650,STR0043,oFont16) //"Relatorio VDA de Amostra Inicial"
oPrint:Say(090,800,STR0044,oFont16) //"Material das Pecas"

oPrint:Say(090,1800,STR0045,oFont08) //"Pagina :"
oPrint:Say(090,1950,StrZero(i,3),oFont08)

oPrint:Say(300,400,STR0046,oFont10) //"Materiais ou substancias que estao submetidas a uma proibicaoo de utilizacao nao podem estar contidas"
oPrint:Say(350,500,STR0047,oFont10) //"Devem ser tambem declaradas substancias que ocorrem ou sao liberadas na utilizacao"
oPrint:Say(400,600,STR0048,oFont10)  //"Veja: Lista VDA para substancias com obrigatoriedade de declaracao!"

oPrint:Say(500,070,STR0049, oFont10)  //"3. Caracteristicas das pecas:"
oPrint:Say(500,600,STR0050, oFont10)  //"No. ZSB:"
oPrint:Say(500,800,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(500,1500,STR0051, oFont10)  //"Relatorio de Amostras No:"
oPrint:Say(500,1950,QL1->QL1_NURELC,oFontCou08)

oPrint:Say(550,600,STR0052, oFont10) //"Denominacao:"
oPrint:Say(550,850,Subs(QK1->QK1_DESC,1,80),oFontCou08)

oPrint:Box(650,10,3100,2390)

oPrint:Say(700,40,STR0053, oFont10) //"No. de Peca/"
oPrint:Say(750,40,STR0054, oFont10) //"No. de Material"

oPrint:Say(700,390,STR0055, oFont10) //"Nome da"
oPrint:Say(750,390,STR0056, oFont10) //"Peca"

oPrint:Say(700,740,STR0057, oFont10) //"Materiais"
oPrint:Say(750,740,STR0058, oFont10) //"de ZSB"

oPrint:Say(700,1090,STR0059, oFont10) //"Massa"

oPrint:Say(700,1330,STR0060, oFont10) //"Material/Especific."
oPrint:Say(750,1350,STR0061, oFont10) //"do produto pelo"
oPrint:Say(800,1350,STR0062, oFont10) //"fabricante"

oPrint:Say(700,1700,STR0063, oFont10) //"Substancias"
oPrint:Say(750,1700,STR0064, oFont10) //"contidas"
oPrint:Say(800,1700,STR0065, oFont10) //"No. CAS"

oPrint:Say(700,1950,STR0063, oFont10) //"Substancias"
oPrint:Say(750,1950,STR0066, oFont10) //"Denominacao"
oPrint:Say(800,1950,STR0067, oFont10) //"do material"

oPrint:Say(750,2210,STR0068, oFont10) //"Teor[%]"

oPrint:Line(850,10,850,2390)	// horizontal

oPrint:Line(650,0360,3100,0360)	// vertical
oPrint:Line(650,0710,3100,0710)	// vertical
oPrint:Line(650,1060,3100,1060)	// vertical
oPrint:Line(650,1320,3100,1320)	// vertical
oPrint:Line(650,1670,3100,1670)	// vertical
oPrint:Line(650,1930,3100,1930)	// vertical
oPrint:Line(850,2190,3100,2190)	// vertical

Return Nil