/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR220.CH"
#INCLUDE "TOTVS.CH"
         
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR220  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Certificado de Submissao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR220(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PPAP                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Robson Ramiro³19.08.01³      ³  Inclusao dos dados na moldura         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR220(lBrow,cPecaAuto,cJPEG)
Local lPergunte := .F.

Private oPrint
Private cStartPath 	:= GetSrvProfString("Startpath","")
Private cPecaRev := ""

Private nEdicao := Val(GetMv("MV_QPPAPED",.T.,"3"))// Indica a Edicao do PPAP default 3 Edicao

Default lBrow 		:= .F.
Default cPecaAuto 	:= ""
Default cJPEG       := ""      

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint	:= TMSPrinter():New(STR0001) //"Certificado de Submissao"

oPrint:SetPortrait()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca       							³
//³ mv_par02				// Revisao        						³
//³ mv_par03				// Impressora / Tela          			³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA220"
		cPecaRev := Iif(!lBrow,M->QKI_PECA + M->QKI_REV, QKI->QKI_PECA + QKI->QKI_REV)
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

DbSelectArea("QKI")
DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If nEdicao == 3
		If Empty(cPecaAuto)
			MsgRun(STR0002,"",{|| CursorWait(), Monta220(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
		Else
			Monta220(oPrint)
		Endif 
	Else 
		If Empty(cPecaAuto)
			MsgRun(STR0002,"",{|| CursorWait(), Monta221(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
		Else
			Monta221(oPrint)
		Endif		
	EndIf
	
	If (lPergunte .and. mv_par03 == 1) .or. !Empty(cPecaAuto)
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Certificado de Submissao                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Monta220(oPrint)
Local aTxtExplic  := {}
Local lRel        := .T.
Local x           := Nil
Private cFileLogo := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Private cLogoPad  := Nil
Private lin       := Nil
Private oFont16, oFont06, oFont08, oFont10, oFont12, oFontCou08
Private nWeight, nWidth

oFont06		:= TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFont12		:= TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath

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

PPAPBMP(cLogoPad, cStartPath)
oPrint:SayBitmap(80,0080, cLogoPad,nWeight,nWidth)
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(40,700,STR0003,oFont16 ) //"Certificado de Submissao de Peca de Producao"

oPrint:Box(160,80,2940,2300)

oPrint:Say(200,0090,STR0004,oFont10) //"Nome da Peca"
oPrint:Say(200,0390,Subs(QK1->QK1_DESC,1,55),oFontCou08 )

oPrint:Say(200,1450,STR0005,oFont10) //"Numero da Peca"
oPrint:Say(200,1740,Subs(QK1->QK1_PCCLI,1,40),oFontCou08 )

oPrint:Say(280,0090,STR0006,oFont10) //"Item de Seguranca e/ou"
oPrint:Say(330,0090,STR0007,oFont10) //"Regulamentacao Governamental"

oPrint:Say(330,0090,STR0007,oFont10) //"Regulamentacao Governamental"

oPrint:Box(330,650,380,700)
oPrint:Say(330,0670,Iif(QKI->QKI_ITSEG == "1","X"," "),oFontCou08)
oPrint:Say(330,0710,STR0008,oFontCou08) //"SIM"

oPrint:Box(330,850,380,900)
oPrint:Say(330,0870,Iif(QKI->QKI_ITSEG == "2","X"," "),oFontCou08)
oPrint:Say(330,0910,STR0009,oFontCou08) //"NAO"

oPrint:Say(330,1100,STR0010,oFont10) //"Alteracao de Engenharia"
oPrint:Say(330,1500,Subs(QK1->QK1_ALTENG,1,29),oFontCou08 )

oPrint:Say(330,2000,STR0011,oFont10) //"Data"
oPrint:Say(330,2090,DtoC(QK1->QK1_DTENG),oFontCou08 )

oPrint:Say(410,0090,STR0012,oFont10) //"Alteracoes Adicionais de Engenharia"
oPrint:Say(410,0680,Subs(QKI->QKI_ADENG,1,72),oFontCou08 )

oPrint:Say(410,2000,STR0011,oFont10) //"Data"
oPrint:Say(410,2090,DtoC(QKI->QKI_DTADEN),oFontCou08 )

oPrint:Say(490,0090,STR0013,oFont10) //"Exposto no Desenho No."
oPrint:Say(490,0480,QK1->QK1_NDES,oFontCou08 )

oPrint:Say(490,1000,STR0014,oFont10) //"No. Pedido de Compra"
oPrint:Say(490,1400,SubStr(QKI->QKI_PEDCOM,1,28),oFontCou08 )

oPrint:Say(490,1900,STR0015,oFont10) //"Peso"
oPrint:Say(490,1990,Alltrim(QKI->QKI_PESO)+"  Kg",oFontCou08 )

oPrint:Say(570,0090,STR0016,oFont10) //"Auxilio para Verificacao No."
oPrint:Say(570,0520,QKI->QKI_AUXVER,oFontCou08 )

oPrint:Say(570,0900,STR0010,oFont10) //"Alteracao de Engenharia"
oPrint:Say(570,1300,Subs(QKI->QKI_ALDMEN,1,40),oFontCou08 )

oPrint:Say(570,2000,STR0011,oFont10) //"Data"
oPrint:Say(570,2090,DtoC(QKI->QKI_DTDIME),oFontCou08 )

// Lado esquerdo
oPrint:Say(650,0090,STR0017,oFont12) //"INFORMACOES DO FORNECEDOR"

oPrint:Say(740,090,SM0->M0_NOMECOM,oFontCou08 )
oPrint:Line(770,90,770,1050) // horizontal
oPrint:Say(780,0090,STR0018,oFont10) //"Nome do Fornecedor"

oPrint:Say(740,0700,Alltrim(QK1->QK1_CODVCL),oFontCou08)
oPrint:Say(780,0700,STR0019,oFont10) //"Codigo do Fornecedor"

oPrint:Say(900,090,SM0->M0_ENDCOB,oFontCou08 )
oPrint:Line(930,90,930,1050) // horizontal
oPrint:Say(940,90,STR0020,oFont10) //"Endereco"

oPrint:Say(1060,090,alltrim(SM0->M0_CIDCOB)+"/"+alltrim(SM0->M0_ESTCOB)+"/"+alltrim(SM0->M0_CEPCOB),oFontCou08 )
oPrint:Line(1090,90,1090,1050) // horizontal
oPrint:Say(1100,90,STR0021,oFont10) //"Cidade/Estado/CEP"

// Lado direito
oPrint:Say(650,1110,STR0022,oFont12) //"INFORMACOES DA SUBMISSAO"

oPrint:Box(750,1410,800,1460)
oPrint:Say(750,1430,Iif(QKI->QKI_SUBDIM == "1","X"," "),oFontCou08)
oPrint:Say(750,1200,STR0023,oFont10) //"Dimensional"

oPrint:Box(750,1920,800,1970)
oPrint:Say(750,1940,Iif(QKI->QKI_SUBMAT == "1","X"," "),oFontCou08)
oPrint:Say(750,1600,STR0024,oFont10) //"Materiais/Funcional"

oPrint:Box(750,2170,800,2220)
oPrint:Say(750,2190,Iif(QKI->QKI_SUBAPA == "1","X"," "),oFontCou08)
oPrint:Say(750,2000,STR0025,oFont10) //"Aparencia"
                                                        
oPrint:Say(880,1110,STR0026,oFont10) //"Nome do Cliente /Divisao"
oPrint:Say(880,1520,SA1->A1_NOME,oFontCou08 )

oPrint:Say(960,1110,STR0027,oFont10) //"Comprador/Codigo do Comprador"
oPrint:Say(960,1660,Subs(QKI->QKI_COMPRA,1,36),oFontCou08 )

oPrint:Say(1040,1110,STR0028,oFont10) //"Aplicacao"
oPrint:Say(1040,1300,QKI->QKI_APLIC,oFontCou08 )

oPrint:Say(1150,090,STR0029,oFont10) //"Nota :"
oPrint:Say(1150,200,STR0030,oFont10) //"Esta peca contem alguma substancia de uso restrito ou reportavel"
oPrint:Say(1200,200,STR0031,oFont10) //"As pecas plasticas sao identificadas com os codigos adequados de marcacao ISO"

oPrint:Box(1100,1700,1150,1750)
oPrint:Say(1100,1720,Iif(QKI->QKI_FLNT1 == "1","X"," "),oFontCou08)
oPrint:Say(1100,1760,STR0008,oFontCou08) //"SIM"

oPrint:Box(1100,1900,1150,1950)
oPrint:Say(1100,1920,Iif(QKI->QKI_FLNT1 == "2","X"," "),oFontCou08)
oPrint:Say(1100,1960,STR0009,oFontCou08) //"NAO"

oPrint:Box(1100,2100,1150,2150)
oPrint:Say(1100,2120,Iif(QKI->QKI_FLNT1 == "3","X"," "),oFontCou08)
oPrint:Say(1100,2160,STR0098,oFontCou08) //"N/A"

oPrint:Box(1200,1700,1250,1750)
oPrint:Say(1200,1720,Iif(QKI->QKI_FLNT2 == "1","X"," "),oFontCou08)
oPrint:Say(1200,1760,STR0008,oFontCou08) //"SIM"

oPrint:Box(1200,1900,1250,1950)
oPrint:Say(1200,1920,Iif(QKI->QKI_FLNT2 == "2","X"," "),oFontCou08)
oPrint:Say(1200,1960,STR0009,oFontCou08) //"NAO"

oPrint:Box(1200,2100,1250,2150)
oPrint:Say(1200,2120,Iif(QKI->QKI_FLNT2 == "3","X"," "),oFontCou08)
oPrint:Say(1200,2160,STR0098,oFontCou08) //"N/A"

oPrint:Say(1300,90,STR0032,oFont12) //"RAZAO PARA SUBMISSAO"

oPrint:Say(1360,0200,STR0033,oFont10) //"Submissao Inicial"
oPrint:Say(1360,1300,STR0034,oFont10) //"Alteracao de Material ou Construcao Opcional"

oPrint:Say(1410,0200,STR0035,oFont10) //"Alteracoes da Engenharia"
oPrint:Say(1410,1300,STR0036,oFont10) //"Alteracao do Subfornecedor ou Fonte do Material"

oPrint:Say(1460,0200,STR0037,oFont10) //"Ferramental: Transferencia, Reposicao, Reparo ou Adicional"
oPrint:Say(1460,1300,STR0038,oFont10) //"Alteracao do Processo de Fabricacao da Peca"

oPrint:Say(1510,0200,STR0039,oFont10) //"Correcao de Discrepancia"
oPrint:Say(1510,1300,STR0040,oFont10) //"Pecas Produzidas em outra Localidade"
                                                                     
oPrint:Say(1560,0200,STR0041,oFont10) //"Ferramental Inativo por mais de 1 ano"
oPrint:Say(1560,1300,STR0042,oFont10) //"Outros - Especifique:"

oPrint:Box(1360,130,1610,180)	// Box das questoes lado esquerdo
oPrint:Line(1410,130,1410,180)	// horizontal
oPrint:Line(1460,130,1460,180)	// horizontal
oPrint:Line(1510,130,1510,180)	// horizontal
oPrint:Line(1560,130,1560,180)	// horizontal

oPrint:Box(1360,1230,1610,1280)	// Box das questoes lado direito
oPrint:Line(1410,1230,1410,1280)	// horizontal
oPrint:Line(1460,1230,1460,1280)	// horizontal
oPrint:Line(1510,1230,1510,1280)	// horizontal
oPrint:Line(1560,1230,1560,1280)	// horizontal


If !Empty(QKI->QKI_FLRZSU)
	if "A" $ QKI->QKI_FLRZSU
		oPrint:Say(1360,150,"X",oFontCou08)
	EndIf			
	if "B" $ QKI->QKI_FLRZSU
		oPrint:Say(1410,150,"X",oFontCou08)
	EndIf
	If "C" $ QKI->QKI_FLRZSU
		oPrint:Say(1460,150,"X",oFontCou08)
    EndIf
	If "D" $ QKI->QKI_FLRZSU
		oPrint:Say(1510,150,"X",oFontCou08)
	EndIf
	If "E" $ QKI->QKI_FLRZSU
		oPrint:Say(1560,150,"X",oFontCou08)
	EndIF
	If "F" $ QKI->QKI_FLRZSU
		oPrint:Say(1360,1250,"X",oFontCou08)
	EndiF
	If "G" $ QKI->QKI_FLRZSU
		oPrint:Say(1410,1250,"X",oFontCou08)
	EndIF
	If "H" $ QKI->QKI_FLRZSU
		oPrint:Say(1460,1250,"X",oFontCou08)
	EndIF
	If "I" $ QKI->QKI_FLRZSU
		oPrint:Say(1510,1250,"X",oFontCou08)
	EndIf
	If "J" $ QKI->QKI_FLRZSU 
		oPrint:Say(1560,1250,"X",oFontCou08)
		oPrint:Say(1560,1680,Subs(QKI->QKI_OUTRO1,1,32),oFontCou08)
 	EndIf
Endif

oPrint:Say(1660,90,STR0043,oFont12) //"NIVEL DE SUBMISSAO (Marque um)"

oPrint:Say(1710,200,STR0044,oFont08) //"Nivel 1 - Certificado apenas(e para itens de aparencia designados, um Relatorio de Aprovacao de Aparencia) submetidos ao cliente"
oPrint:Say(1760,200,STR0045,oFont08) //"Nivel 2 - Certificado com amostras do produto e dados limitados de suporte submetidos ao cliente"
oPrint:Say(1810,200,STR0046,oFont08) //"Nivel 3 - Certificado com amostras do produto e todos os dados de suporte submetidos ao cliente"
oPrint:Say(1860,200,STR0047,oFont08) //"Nivel 4 - Certificado e outros requisitos conforme definido pelo cliente"
oPrint:Say(1910,200,STR0048,oFont08) //"Nivel 5 - Certificado com amostras do produto e todos os dados de suporte verificados na localidade de manufatura do fornecedor"

oPrint:Box(1710,130,1960,180)	// Box do Nivel 
oPrint:Line(1760,130,1760,180)	// horizontal
oPrint:Line(1810,130,1810,180)	// horizontal
oPrint:Line(1860,130,1860,180)	// horizontal
oPrint:Line(1910,130,1910,180)	// horizontal


If !Empty(QKI->QKI_FLNISU)
	Do Case
		Case QKI->QKI_FLNISU == "1"
			oPrint:Say(1710,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "2"
			oPrint:Say(1760,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "3"
			oPrint:Say(1810,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "4"
			oPrint:Say(1860,150,"X",oFontCou08)                         
		Case QKI->QKI_FLNISU == "5"
			oPrint:Say(1910,150,"X",oFontCou08)
	Endcase
Endif

oPrint:Say(2010,90,STR0049,oFont12) //"RESULTADOS DA SUBMISSAO"

oPrint:Say(2070,100,STR0050,oFont08)	//"Os resultados de "

oPrint:Box(2060,320,2110,370)			// Box dos Check 1
oPrint:Say(2070,380,STR0051,oFont08)	// "medicoes dimensionais "

oPrint:Box(2060,690,2110,740)			// Box dos Check 2
oPrint:Say(2070,750,STR0052,oFont08)	//" ensaios de materiais e funcionias "

oPrint:Box(2060,1190,2110,1240)		// Box dos Check 3
oPrint:Say(2070,1250,STR0053,oFont08)	//" criterios de aparencia  "

oPrint:Box(2060,1540,2110,1590)		// Box dos Check 4
oPrint:Say(2070,1600,STR0054,oFont08)	//" dados estatisticos "

oPrint:Say(2070,0340,Iif(QKI->QKI_RESDIM == "1","X"," "),oFontCou08)
oPrint:Say(2070,0710,Iif(QKI->QKI_RESMAT == "1","X"," "),oFontCou08)
oPrint:Say(2070,1210,Iif(QKI->QKI_RESAPA == "1","X"," "),oFontCou08)
oPrint:Say(2070,1560,Iif(QKI->QKI_RESEST == "1","X"," "),oFontCou08)

oPrint:Say(2120,0100,STR0055,oFont08) 	//"Estes resultados atendem a todos os requisitos do desenho e de especificacoes:   "

oPrint:Box(2120,1150,2170,1200)		// Box sim
oPrint:Say(2120,1200,STR0056,oFont08) 	//" SIM "
oPrint:Say(2120,1175,Iif(QKI->QKI_REQUIS == "1","X"," "),oFontCou08)

oPrint:Box(2120,1350,2170,1400)		// Box nao
oPrint:Say(2120,1400,STR0057,oFont08) 	//" NAO "
oPrint:Say(2120,1370,Iif(QKI->QKI_REQUIS == "2","X"," "),oFontCou08)

oPrint:Say(2120,1500,STR0084,oFont08) 	//'  (Se "NAO" - Explicar abaixo)'

oPrint:Say(2170,100,STR0058,oFont08) //"Moldes / Cavidades / Processo de Producao :"
oPrint:Say(2170,700,QKI->QKI_MOLDE,oFontCou08 )

oPrint:Say(2250,90,STR0059,oFont12) //"DECLARACAO"

oPrint:Say(2300,100,STR0060,oFont08) //"Por meio deste afirmo que as amostras representadas por este certificado sao representativas das nossas pecas e foram fabricadas conforme os"
oPrint:Say(2350,100,STR0061,oFont08) //"requisitos aplicaveis do Manual do Processo de Aprovacao de Producao 3a. edicao. Alem disso certifico que estas amostras foram"
oPrint:Say(2400,100,STR0062+AllTrim(QKI->QKI_TXPROD)+" / 8"+STR0063,oFont08) //"produzidas a uma taxa de producao de  "###" horas. Eu anotei qualquer desvio desta declaracao abaixo:"

oPrint:Say(2460,100,STR0064,oFont08) //"Explicacoes/Comentarios"

aTxtExplic := JustificaTXT(QKI->QKI_COMENT,100,.T.)
If !Empty(MsMM(QKI->QKI_DESCHV,TamSx3("QKI_COMEN1")[1]))
	aTxtExplic := JustificaTXT(MsMM(QKI->QKI_DESCHV,TamSx3("QKI_COMEN1")[1]),100,.T.)
Endif

lin := 2460
For x := 1 to Len(aTxtExplic)     
    oPrint:Say(lin,500, aTxtExplic[x],oFontCou08)            
    lin += 40 
    If lin > 2750
      lRel := .F.
      U_IniciaPagina(@lin)    
    Endif 
Next

If lRel 
  U_IniciaPagina(@lin) 
Endif  

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Monta221 ³ Autor ³ Cicero Odilio Cruz    ³ Data ³ 06.11.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Certificado de Submissao Layout 4 Edicao                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Monta221(ExpO1)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Monta221(oPrint)
Local aPaises    := GetCountryList()
Local aTxtExplic := {}
Local lRel       := .T.
Local x          := 0
Local nPos 	     := Ascan( aPaises, {|p| p[1] == cPaisLoc} )
Local cDescPais  := Alltrim( aPaises[nPos][2] )

Private cFileLogo  := "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Private cLogoPad   := ""
Private lin        := 0
Private nWeight    := 0
Private nWidth     := 0
Private oFont06	   := TFont():New("Arial",06,06,,.F.,,,,.T.,.F.)
Private oFont08	   := TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
Private oFont10	   := TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
Private oFont12	   := TFont():New("Arial",12,12,,.F.,,,,.T.,.F.)
Private oFont16	   := TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
Private oFontCou08 := TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath

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

PPAPBMP(cLogoPad, cStartPath)
oPrint:SayBitmap(80,0080, cLogoPad,nWeight,nWidth)
oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)

oPrint:Say(40,700,STR0003,oFont16 ) //"Certificado de Submissao de Peca de Producao"

oPrint:Box(160,80,2940,2300)

oPrint:Say(200,0090,STR0004,oFont10) //"Nome da Peca"
oPrint:Say(200,0390,Subs(QK1->QK1_DESC,1,55),oFontCou08 )

oPrint:Say(200,1450,STR0085,oFont10) //"Numero Peca Cli."
oPrint:Say(200,1740,Subs(QK1->QK1_PCCLI,1,32),oFontCou08 )

oPrint:Say(260,0090,STR0013,oFont10) //"Exposto no Desenho No."
oPrint:Say(260,0480,QK1->QK1_NDES,oFontCou08 )

oPrint:Say(260,1450,STR0086,oFont10) //"Numero Peca Org."
oPrint:Say(260,1740,Subs(QK1->QK1_PECA,1,32),oFontCou08 )

oPrint:Say(320,0090,STR0010,oFont10) //"Alteracao de Engenharia"
oPrint:Say(320,0480,Subs(QK1->QK1_ALTENG,1,29),oFontCou08 )

oPrint:Say(320,2000,STR0011,oFont10) //"Data"
oPrint:Say(320,2090,DtoC(QK1->QK1_DTENG),oFontCou08 )

oPrint:Say(380,0090,STR0012,oFont10) //"Alteracoes Adicionais de Engenharia"
oPrint:Say(380,0680,Subs(QKI->QKI_ADENG,1,72),oFontCou08 )

oPrint:Say(380,2000,STR0011,oFont10) //"Data"
oPrint:Say(380,2090,DtoC(QKI->QKI_DTADEN),oFontCou08 )

oPrint:Say(440,0090,STR0006,oFont10) //"Item de Seguranca e/ou"
oPrint:Say(490,0090,STR0007,oFont10) //"Regulamentacao Governamental"

oPrint:Say(490,0090,STR0007,oFont10) //"Regulamentacao Governamental"

oPrint:Box(490,650,520,700)
oPrint:Say(490,0670,Iif(QKI->QKI_ITSEG == "1","X"," "),oFontCou08)
oPrint:Say(490,0710,STR0008,oFontCou08) //"SIM"

oPrint:Box(490,850,520,900)
oPrint:Say(490,0870,Iif(QKI->QKI_ITSEG == "2","X"," "),oFontCou08)
oPrint:Say(490,0910,STR0009,oFontCou08) //"NAO"

oPrint:Say(490,1000,STR0014,oFont10) //"No. Pedido de Compra"
oPrint:Say(490,1400,SubStr(QKI->QKI_PEDCOM,1,28),oFontCou08 )

oPrint:Say(490,1900,STR0015,oFont10) //"Peso"
oPrint:Say(490,1990,Alltrim(QKI->QKI_PESO)+"  Kg",oFontCou08 )

oPrint:Say(550,0090,STR0016,oFont10) //"Auxilio para Verificacao No."
oPrint:Say(550,0520,QKI->QKI_AUXVER,oFontCou08 )

oPrint:Say(550,0900,STR0010,oFont10) //"Alteracao de Engenharia"
oPrint:Say(550,1300,Subs(QKI->QKI_ALDMEN,1,40),oFontCou08 )

oPrint:Say(550,2000,STR0011,oFont10) //"Data"
oPrint:Say(550,2090,DtoC(QKI->QKI_DTDIME),oFontCou08 )

// Lado esquerdo
oPrint:Say(640,0090,STR0017,oFont12) //"INFORMACOES DO FORNECEDOR"

oPrint:Say(705,090,SM0->M0_NOMECOM,oFontCou08 )
oPrint:Line(730,90,730,1050) // horizontal
oPrint:Say(735,0090,STR0018,oFont08) //"Nome do Fornecedor"

oPrint:Say(735,0700,STR0019,oFont08) //"Codigo do Fornecedor"

oPrint:Say(805,090,SM0->M0_ENDCOB,oFontCou08 )
oPrint:Line(830,90,830,1050) // horizontal
oPrint:Say(835,90,STR0020,oFont08) //"Endereco"

oPrint:Say(905,090,alltrim(SM0->M0_CIDCOB)+"/"+alltrim(SM0->M0_ESTCOB)+"/"+alltrim(SM0->M0_CEPCOB)+"/"+cDescPais,oFontCou08 )
oPrint:Line(930,90,930,1050) // horizontal
oPrint:Say(935,90,STR0087,oFont08) //"Cidade/Estado/CEP/Pais"

// Lado direito
oPrint:Say(640,1110,STR0022,oFont12) //"INFORMACOES DA SUBMISSAO"

oPrint:Say(705,1110,SA1->A1_NOME,oFontCou08 )
oPrint:Line(730,1110,730,2270) // horizontal
oPrint:Say(735,1110,STR0026,oFont08) //"Nome do Cliente /Divisao"

oPrint:Say(805,1110,Subs(QKI->QKI_COMPRA,1,36),oFontCou08 )
oPrint:Line(830,1110,830,2270) // horizontal
oPrint:Say(835,1110,STR0027,oFont08) //"Comprador/Codigo do Comprador"

oPrint:Say(905,1110,QKI->QKI_APLIC,oFontCou08 )
oPrint:Line(930,1110,930,2270) // horizontal
oPrint:Say(935,1110,STR0028,oFont08) //"Aplicacao"

oPrint:Say(0980,0090,STR0088,oFont12) //"RELATORIO MATERIAIS"
                                                       
oPrint:Say(1055,090,STR0030,oFont08) //"Esta peca contem alguma substancia de uso restrito ou reportavel"
oPrint:Say(1115,200,STR0089,oFont08) //"Submetido por IMDS ou por formato do cliente "
IF  Empty(QKI->QKI_IMDSID) .AND. Empty(QKI->QKI_IMDSVE) .AND. Empty(QKI->QKI_IMDSDT)
	oPrint:Line(1150,0810,1150,2270) // horizontal
	oPrint:Line(1210,0810,1210,2270) // horizontal
Else
	oPrint:Say(1115,0810,QKI->QKI_IMDSID+" - "+QKI->QKI_IMDSVE+" - "+DTOC(QKI->QKI_IMDSDT),oFontCou08 )
	//oPrint:Line(1210,0810,1210,2270) // horizontal
EndIf
oPrint:Say(1240,090,STR0031,oFont08) //"As pecas plasticas sao identificadas com os codigos adequados de marcacao ISO"

oPrint:Box(1055,1700,1085,1750)
oPrint:Say(1055,1720,Iif(QKI->QKI_FLNT1 == "1","X"," "),oFontCou08)
oPrint:Say(1055,1760,STR0008,oFontCou08) //"SIM"

oPrint:Box(1055,1900,1085,1950)
oPrint:Say(1055,1920,Iif(QKI->QKI_FLNT1 == "2","X"," "),oFontCou08)
oPrint:Say(1055,1960,STR0009,oFontCou08) //"NAO"

oPrint:Box(1055,2100,1085,2150)
oPrint:Say(1055,2120,Iif(QKI->QKI_FLNT1 == "3","X"," "),oFontCou08)
oPrint:Say(1055,2160,STR0098,oFontCou08) //"N/A"

oPrint:Box(1240,1700,1270,1750)
oPrint:Say(1240,1720,Iif(QKI->QKI_FLNT2 == "1","X"," "),oFontCou08)
oPrint:Say(1240,1760,STR0008,oFontCou08) //"SIM"

oPrint:Box(1240,1900,1270,1950)
oPrint:Say(1240,1920,Iif(QKI->QKI_FLNT2 == "2","X"," "),oFontCou08)
oPrint:Say(1240,1960,STR0009,oFontCou08) //"NAO"

oPrint:Box(1240,2100,1270,2150)
oPrint:Say(1240,2120,Iif(QKI->QKI_FLNT2 == "3","X"," "),oFontCou08)
oPrint:Say(1240,2160,STR0098,oFontCou08) //"N/A"

oPrint:Say(1300,90,STR0032,oFont12) //"RAZAO PARA SUBMISSAO"

oPrint:Say(1360,0200,STR0033,oFont08) //"Submissao Inicial"
oPrint:Say(1360,1300,STR0034,oFont08) //"Alteracao de Material ou Construcao Opcional"

oPrint:Say(1395,0200,STR0035,oFont08) //"Alteracoes da Engenharia"
oPrint:Say(1395,1300,STR0036,oFont08) //"Alteracao do Subfornecedor ou Fonte do Material"

oPrint:Say(1430,0200,STR0037,oFont08) //"Ferramental: Transferencia, Reposicao, Reparo ou Adicional"
oPrint:Say(1430,1300,STR0038,oFont08) //"Alteracao do Processo de Fabricacao da Peca"

oPrint:Say(1465,0200,STR0039,oFont08) //"Correcao de Discrepancia"
oPrint:Say(1465,1300,STR0040,oFont08) //"Pecas Produzidas em outra Localidade"
                                                                     
oPrint:Say(1500,0200,STR0041,oFont08) //"Ferramental Inativo por mais de 1 ano"
oPrint:Say(1500,1300,STR0042,oFont08) //"Outros - Especifique:"

oPrint:Box(1360,145,1390,175)	// Box das questoes lado esquerdo
oPrint:Box(1395,145,1425,175)
oPrint:Box(1430,145,1460,175)
oPrint:Box(1465,145,1495,175)
oPrint:Box(1500,145,1530,175)

oPrint:Box(1360,1245,1390,1275) 	// Box das questoes lado direito
oPrint:Box(1395,1245,1425,1275)	
oPrint:Box(1430,1245,1460,1275)	
oPrint:Box(1465,1245,1495,1275)	
oPrint:Box(1500,1245,1530,1275)

If !Empty(QKI->QKI_FLRZSU)
	if "A" $ QKI->QKI_FLRZSU
		oPrint:Say(1360,150,"X",oFontCou08)
	EndIf
	If "B" $ QKI->QKI_FLRZSU 
		oPrint:Say(1395,150,"X",oFontCou08)
	EndIf
	If "C" $ QKI->QKI_FLRZSU
		oPrint:Say(1430,150,"X",oFontCou08)
	EndIf
	If "D" $ QKI->QKI_FLRZSU
		oPrint:Say(1465,150,"X",oFontCou08)
	EndIf
	If "E" $ QKI->QKI_FLRZSU
		oPrint:Say(1500,150,"X",oFontCou08)
	EndIf
	If "F" $ QKI->QKI_FLRZSU
		oPrint:Say(1360,1250,"X",oFontCou08)
	EndIf
	If "G" $ QKI->QKI_FLRZSU
		oPrint:Say(1395,1250,"X",oFontCou08)
	EndIf
	If "H" $ QKI->QKI_FLRZSU
		oPrint:Say(1430,1250,"X",oFontCou08)
	EndIf
	If "I" $ QKI->QKI_FLRZSU
		oPrint:Say(1465,1250,"X",oFontCou08)
	EndIF
	If "J" $ QKI->QKI_FLRZSU
		oPrint:Say(1500,1250,"X",oFontCou08)
		oPrint:Say(1500,1680,Subs(QKI->QKI_OUTRO1,1,32),oFontCou08)
	EndIf 
Endif

oPrint:Say(1560,90,STR0043,oFont12) //"NIVEL DE SUBMISSAO (Marque um)"

oPrint:Say(1620,200,STR0044,oFont08) //"Nivel 1 - Certificado apenas(e para itens de aparencia designados, um Relatorio de Aprovacao de Aparencia) submetidos ao cliente"
oPrint:Say(1655,200,STR0045,oFont08) //"Nivel 2 - Certificado com amostras do produto e dados limitados de suporte submetidos ao cliente"
oPrint:Say(1690,200,STR0046,oFont08) //"Nivel 3 - Certificado com amostras do produto e todos os dados de suporte submetidos ao cliente"
oPrint:Say(1725,200,STR0047,oFont08) //"Nivel 4 - Certificado e outros requisitos conforme definido pelo cliente"
oPrint:Say(1760,200,STR0048,oFont08) //"Nivel 5 - Certificado com amostras do produto e todos os dados de suporte verificados na localidade de manufatura do fornecedor"

oPrint:Box(1620,145,1650,175)	// Box do Nivel 
oPrint:Box(1655,145,1685,175)	
oPrint:Box(1690,145,1720,175)	
oPrint:Box(1725,145,1755,175)	
oPrint:Box(1760,145,1790,175)	


If !Empty(QKI->QKI_FLNISU)
	Do Case
		Case QKI->QKI_FLNISU == "1"
			oPrint:Say(1620,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "2"
			oPrint:Say(1655,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "3"
			oPrint:Say(1690,150,"X",oFontCou08)
		Case QKI->QKI_FLNISU == "4"
			oPrint:Say(1725,150,"X",oFontCou08)                         
		Case QKI->QKI_FLNISU == "5"
			oPrint:Say(1760,150,"X",oFontCou08)
	Endcase
Endif

oPrint:Say(1840,90,STR0049,oFont12) //"RESULTADOS DA SUBMISSAO"

oPrint:Say(1900,100,STR0050,oFont08)	//"Os resultados de "

oPrint:Box(1900,335,1930,365)			// Box dos Check 1
oPrint:Say(1900,380,STR0051,oFont08)	// "medicoes dimensionais "

oPrint:Box(1900,705,1930,735)			// Box dos Check 2
oPrint:Say(1900,750,STR0052,oFont08)	//" ensaios de materiais e funcionais "

oPrint:Box(1900,1205,1930,1235)		// Box dos Check 3
oPrint:Say(1900,1250,STR0053,oFont08)	//" criterios de aparencia  "

oPrint:Box(1900,1555,1930,1585)		// Box dos Check 4
oPrint:Say(1900,1600,STR0054,oFont08)	//" dados estatisticos "

oPrint:Say(1900,0340,Iif(QKI->QKI_RESDIM == "1","X"," "),oFontCou08)
oPrint:Say(1900,0710,Iif(QKI->QKI_RESMAT == "1","X"," "),oFontCou08)
oPrint:Say(1900,1210,Iif(QKI->QKI_RESAPA == "1","X"," "),oFontCou08)
oPrint:Say(1900,1560,Iif(QKI->QKI_RESEST == "1","X"," "),oFontCou08)

oPrint:Say(1940,0100,STR0055,oFont08) 	//"Estes resultados atendem a todos os requisitos do desenho e de especificacoes:   "

oPrint:Box(1940,1165,1970,1195)		// Box sim
oPrint:Say(1940,1200,STR0056,oFont08) 	//" SIM "
oPrint:Say(1940,1175,Iif(QKI->QKI_REQUIS == "1","X"," "),oFontCou08)

oPrint:Box(1940,1365,1970,1395)		// Box nao
oPrint:Say(1940,1400,STR0057,oFont08) 	//" NAO "
oPrint:Say(1940,1370,Iif(QKI->QKI_REQUIS == "2","X"," "),oFontCou08)

oPrint:Say(1940,1500,STR0084,oFont08) 	//'  (Se "NAO" - Explicar abaixo)'

oPrint:Say(1980,100,STR0058,oFont08) //"Moldes / Cavidades / Processo de Producao :"
oPrint:Say(1980,700,QKI->QKI_MOLDE,oFontCou08 )

oPrint:Say(2040,90,STR0059,oFont12) //"DECLARACAO"

oPrint:Say(2100,100,STR0060,oFont08) //"Por meio deste afirmo que as amostras representadas por este certificado sao representativas das nossas pecas e foram fabricadas conforme os"
oPrint:Say(2140,100,STR0090,oFont08) //"requisitos aplicaveis do Manual do Processo de Aprovacao de Producao 4a. edicao. Alem disso certifico que estas amostras foram"
oPrint:Say(2180,100,STR0062+AllTrim(QKI->QKI_TXPROD)+" / "+QKI->QKI_TMPROD+STR0063,oFont08) //"produzidas a uma taxa de producao de  "###" horas. Eu anotei qualquer desvio desta declaracao abaixo:"

oPrint:Say(2220,100,STR0064,oFont08) //"Explicacoes/Comentarios"

aTxtExplic := JustificaTXT(QKI->QKI_COMENT,100,.T.)
If !Empty(MsMM(QKI->QKI_DESCHV,TamSx3("QKI_COMEN1")[1]))
	aTxtExplic := JustificaTXT(MsMM(QKI->QKI_DESCHV,TamSx3("QKI_COMEN1")[1]),100,.T.)
Endif

lin := 2220
For x := 1 to Len(aTxtExplic)     
    oPrint:Say(lin,500, aTxtExplic[x],oFontCou08)            
    lin += 40 
    If lin > 2750
      lRel := .F.
      U_IniciaPagina(@lin)    
    Endif 
Next

If lRel 
  U_IniciaPagina(@lin) 
Endif  

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³PulaPagina ³ Autor ³ Leandro de S. Sabino ³ Data ³ 27.02.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Inicia uma nova pagina.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_IniciaPagina(lin)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lin = linha atual de impressao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function IniciaPagina(lin)

If nEdicao == 3
	
	oPrint:Say(lin,100,STR0065,oFont08) //"Nome"
	oPrint:Say(lin,200,QKI->QKI_NOMAPR,oFontCou08 )
	
	oPrint:Say(lin,1000,STR0066,oFont08) //"Cargo"
	oPrint:Say(lin,1100,SubStr(QKI->QKI_CARAPR,1,34),oFontCou08 )
	
	oPrint:Say(lin,1700,STR0067,oFont08) //"Telefone"
	oPrint:Say(lin,1850,QKI->QKI_TELAPR,oFontCou08 )
	
	lin +=60          
	U_ControlaLinha(@lin)
	oPrint:Say(lin,0100,STR0068,oFont08) //"Assinatura Autorizada do Fornecedor"
	oPrint:Say(lin,2000,STR0011,oFont08) //"Data"
	oPrint:Say(lin,2090,DtoC(QKI->QKI_DTAPR),oFontCou08 )
	
	lin += 50         
	U_ControlaLinha(@lin)
	oPrint:Line(lin,80,lin,2300) // horizontal
	
	lin += 20         
	U_ControlaLinha(@lin)
	oPrint:Say(lin,700,STR0069,oFont12) //"PARA USO DO CLIENTE APENAS (SE APLICAVEL)"
	
	lin += 50         
	U_ControlaLinha(@lin)
	oPrint:Say(lin,0090,STR0070,oFont10)  //"Disposicao do Certificado da Peca:"
	oPrint:Say(lin,0700,STR0071,oFont10)  //"Aprovado"
	oPrint:Say(lin,1000,STR0072,oFont10)  //"Rejeitado"
	oPrint:Box(lin,640,(lin+110),690)     //Box Disposicao
	oPrint:Box(lin,930,(lin+050),980)    //Box Rejeitado
	oPrint:Say(lin,1350,STR0074,oFont10)  //"Aprovacao Funcional da Peca:"
	oPrint:Say(lin,1900,STR0071,oFont10)  //"Aprovado"
	
	oPrint:Box(lin,1840,(lin+110),1890)  //Box Disposicao
	oPrint:Line(lin,1300,(lin+50),1300)  //vertical
	
	lin += 50         
	U_ControlaLinha(@lin)
	oPrint:Line(lin,640,lin,690)		  // horizontal
	oPrint:Line(lin,1840,lin,1890)	      // horizontal
	
	lin += 10
	linaux := (lin + 40)     
	U_ControlaLinha(@lin)
	oPrint:Say(lin,0700,STR0073,oFont10) //"Outros"
	oPrint:Say(lin,1900,STR0075,oFont10) //"Dispensado"
	
	If !Empty(QKI->QKI_DISCLI)
		If	QKI->QKI_DISCLI == "1"
			 lin := lin - 60
			oPrint:Say(lin,0663,"X",oFontCou08)
		Elseif	QKI->QKI_DISCLI == "2"
			lin := lin - 60
			oPrint:Say(lin,0950,"X",oFontCou08)
		Elseif	QKI->QKI_DISCLI == "3"
			oPrint:Say(lin,0650,"X",oFontCou08)
			oPrint:Say(lin,0850,QKI->QKI_OUTRO2,oFontCou08)
		Endif
	Endif
	
	If !Empty(QKI->QKI_APRFUN)
		If	QKI->QKI_APRFUN == "1"
			oPrint:Say(lin,1860,"X",oFontCou08)
		Elseif	QKI->QKI_APRFUN == "2"
			lin := lin + 60
			oPrint:Say(lin,1860,"X",oFontCou08)
		Endif
	Endif
	lin := linaux 
	lin += 100
	U_ControlaLinha(@lin)
	oPrint:Say(lin,090,STR0076,oFont10)    //"Repres. Cliente"
	oPrint:Say(lin,400,QKI->QKI_REPCLI,oFontCou08 )
	oPrint:Say(lin,1100,STR0077,oFont10)   //"Assinatura do Cliente"
	oPrint:Line((lin+50),80,(lin+50),2300) // horizontal
	oPrint:Say(lin,2000,STR0011,oFont10)   //"Data"
	oPrint:Say(lin,2090,DtoC(QKI->QKI_DTRCLI),oFontCou08 )
	
	lin +=90          
	U_ControlaLinha(@lin)
	oPrint:Say(lin,90,STR0078,oFont08)    //"Julho"
	oPrint:Say(lin,700,STR0080, oFont08)  //"A copia original desse documento deve permanecer nas instalacoes"
	oPrint:Say(lin,1800,STR0082, oFont08) //"Opcional: Numero de Rastreamento"
	
	lin +=30          
	U_ControlaLinha(@lin)
	oPrint:Say(lin,200,STR0079,oFont10)   //"CFG-1001"
	oPrint:Say(lin,700,STR0081, oFont08)  //"do fornecedor enquanto a peca estiver ativa (veja Glossario)"
	oPrint:Say(lin,1800,STR0083, oFont08) //"do Cliente:#"
	
	lin +=10          
	U_ControlaLinha(@lin)
	oPrint:Say(lin,90,"1999",oFont08)
	
	lin += 50
	oPrint:Box(160,80,lin,2300) // BOX GERAL 
	
	oPrint:EndPage() 		// Finaliza a pagina     

Else

	lin += 40
	U_ControlaLinha(@lin)
	oPrint:Say(lin,0090,STR0091,oFont08)  //"Cada instrumento do cliente foi corretamente etiquetado e numerado"
	oPrint:Say(lin,1050,STR0056,oFont08)  //"SIM"
	oPrint:Say(lin,1300,STR0057,oFont08)  //"NAO"
	oPrint:Say(lin,1550,STR0098,oFont08)  //"N/A"
	oPrint:Box(lin,990,(lin+30),1020)     //Box Sim  
	oPrint:Box(lin,1240,(lin+30),1270)    //Box Nao
	oPrint:Box(lin,1490,(lin+30),1520)    //Box N/A

	If !Empty(QKI->QKI_FERCLI)
		If	QKI->QKI_FERCLI == "1"
			oPrint:Say(lin,1000,"X",oFontCou08)
		Elseif	QKI->QKI_FERCLI == "2"
			oPrint:Say(lin,1250,"X",oFontCou08)
		Elseif	QKI->QKI_FERCLI == "3"
			oPrint:Say(lin,1500,"X",oFontCou08)
		EndIf
	EndIf
	
	lin += 80
	U_ControlaLinha(@lin)	
	oPrint:Say(lin,0100,STR0068,oFont08) //"Assinatura Autorizada do Fornecedor"
	oPrint:Say(lin,2000,STR0011,oFont08) //"Data"
	oPrint:Say(lin,2090,DtoC(QKI->QKI_DTAPR),oFontCou08 )
	
	lin +=80
	U_ControlaLinha(@lin)
	oPrint:Say(lin,100,STR0065,oFont08) //"Nome"
	oPrint:Say(lin,200,QKI->QKI_NOMAPR,oFontCou08 )

	oPrint:Say(lin,1000,STR0067,oFont08) //"Telefone"
	oPrint:Say(lin,1150,QKI->QKI_TELAPR,oFontCou08 )

	oPrint:Say(lin,1700,STR0092,oFont08) //"Fax"
	oPrint:Say(lin,1850,SubStr(QKI->QKI_FAXAPR,1,34),oFontCou08 )

	lin +=40
	U_ControlaLinha(@lin)
	
	oPrint:Say(lin,100,STR0066,oFont08) //"Cargo"
	oPrint:Say(lin,200,SubStr(QKI->QKI_CARAPR,1,34),oFontCou08 )
	
	oPrint:Say(lin,1325,STR0093,oFont08) //"E-Mail"
	oPrint:Say(lin,1425,QKI->QKI_EMAAPR,oFontCou08 )  

	lin += 50         
	U_ControlaLinha(@lin)
	oPrint:Line(lin,80,lin,2300) // horizontal
	
	lin += 20         
	U_ControlaLinha(@lin)
	oPrint:Say(lin,700,STR0069,oFont12) //"PARA USO DO CLIENTE APENAS (SE APLICAVEL)"
	
	lin += 50         
	U_ControlaLinha(@lin)
	oPrint:Say(lin,0090,STR0070,oFont08)  //"Disposicao do Certificado da Peca:"
	oPrint:Say(lin,0700,STR0071,oFont08)  //"Aprovado"
	oPrint:Say(lin,1000,STR0072,oFont08)  //"Rejeitado"
	oPrint:Say(lin,1300,STR0073,oFont08)  //"Outros"
	oPrint:Box(lin,655,(lin+30),685)     //Box Disposicao
	oPrint:Box(lin,945,(lin+30),975)     //Box Rejeitado  
	oPrint:Box(lin,1255,(lin+30),1285)     //Box Rejeitado

	If !Empty(QKI->QKI_DISCLI)
		If	QKI->QKI_DISCLI == "1"
			oPrint:Say(lin,0650,"X",oFontCou08)
		Elseif	QKI->QKI_DISCLI == "2"
			oPrint:Say(lin,0950,"X",oFontCou08)
		Elseif	QKI->QKI_DISCLI == "3"
			oPrint:Say(lin,1260,"X",oFontCou08)
			oPrint:Say(lin,1400,QKI->QKI_OUTRO2,oFontCou08)
		Endif
	Endif
	
	lin += 80
	oPrint:Say(lin,090,STR0077,oFont08)   //"Assinatura do Cliente"
	oPrint:Say(lin,2000,STR0011,oFont08)   //"Data"
	oPrint:Say(lin,2090,DtoC(QKI->QKI_DTRCLI),oFontCou08 )

	lin += 80
	U_ControlaLinha(@lin)
	oPrint:Say(lin,090,STR0076,oFont08)    //"Repres. Cliente"
	oPrint:Say(lin,400,QKI->QKI_REPCLI,oFontCou08 )
	oPrint:Say(lin,1370,STR0082+" "+STR0083, oFont08) //"Opcional: Numero de Rastreamento" ### "do Cliente:#"
	
	If lin > 2900
		U_ControlaLinha(@lin)  
		oPrint:Box(160,80,lin,2300)
	Else	
		lin := 2950
		oPrint:Say(lin,90,STR0094,oFont06)    //"Marco"
		lin +=20          
		oPrint:Say(lin,90,"2006",oFont06)
		lin -=12  
		oPrint:Say(lin,200,STR0079,oFont10)   //"CFG-1001"
	EndIf
	
	oPrint:EndPage()     
		
EndIf
	
Return nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ControlaLinha ³ Autor ³ Leandro S. Sabino ³ Data ³ 27.02.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Verifica a necessidade de iniciar uma nova pagina.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_ControlaLinha(lin)                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lin = linha atual de impressao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ControlaLinha(lin)
If lin > 2900
	If nEdicao == 4
		lin = 2950 
		lin +=20
		oPrint:Line(lin,80,lin,2300) // horizontal
		oPrint:Say(lin,90,STR0094,oFont06)    //"Marco"
		lin +=20          
		oPrint:Say(lin,90,"2006",oFont06)
		lin -=12  
		oPrint:Say(lin,200,STR0079,oFont10)   //"CFG-1001"
	EndIf

	oPrint:EndPage() 		                     // Finaliza a pagina     
    oPrint:SayBitmap(05,0005, cFileLogo,328,82) // Tem que estar abaixo do RootPath
	oPrint:SayBitmap(80,0080, cLogoPad,nWeight,nWidth)
	oPrint:SayBitmap(05,2100, "Logo.bmp",237,58)
	oPrint:Say(40,700,STR0003,oFont16 )         //"Certificado de Submissao de Peca de Producao"

   	lin := 200
   	oPrint:StartPage() 		                    // Inicia uma nova pagina
	oPrint:Say(lin,0090,STR0004,oFont10)       //"Nome da Peca"
	oPrint:Say(lin,0390,Subs(QK1->QK1_DESC,1,55),oFontCou08 )
	
	oPrint:Say(lin,1450,STR0005,oFont10)       //"Numero da Peca"
	oPrint:Say(lin,1740,Subs(QK1->QK1_PCCLI,1,32),oFontCou08 )
   
	lin+=80
Endif   
Return
