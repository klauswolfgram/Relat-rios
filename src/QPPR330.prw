/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR330.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR330  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 04.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist Material a Granel                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR330(void)                                              ³±±
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

User Function QPPR330(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cStartPath 	:= GetSrvProfString("Startpath","")

Private cPecaRev 	:= ""
Private cEspecie	:= "PPA330"
Private nTamLin 	:= 38 // Tamanho da linha do texto

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""        

If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Checklist Material a Granel"

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA330"
		cPecaRev := Iif(!lBrow,M->QKY_PECA + M->QKY_REV, QKY->QKY_PECA + QKY->QKY_REV)
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

DbSelectArea("QKY")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), MontaRel(oPrint) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		MontaRel(oPrint)
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,1140,840,140)
		Else 
			oPrint:Print()
		EndIF
	Else
		oPrint:Preview()  		// Visualiza antes de imprimir
	Endif
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
±±³Funcao    ³ MontaRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 04.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist Material a Granel                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MotaRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontaRel(oPrint)

Local lin, nPos, i
Local cResp1, cResp2, cResp3
Local cCiaCd1, cCiaCd2, cCiaCd3
Local cFilRes
Local aPerg	:= {}

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)

aAdd( aPerg,{ "01", STR0003 }) //"VERIFICACAO DE PROJETO E DESENVOLVIMENTO DE PRODUTO"
aAdd( aPerg,{ "02", STR0004 }) //"Matriz de Projeto"
aAdd( aPerg,{ "03", STR0005 }) //"FMEA de Projeto"
aAdd( aPerg,{ "04", STR0006 }) //"Caracteristicas Especiais do Produto"
aAdd( aPerg,{ "05", STR0007 }) //"Registros de Projeto"
aAdd( aPerg,{ "06", STR0008 }) //"Plano de Controle de Prototipo"
aAdd( aPerg,{ "07", STR0009 }) //"Relatorio de Aprovacao de Aparencia"
aAdd( aPerg,{ "08", STR0010 }) //"Amostras Padrao"
aAdd( aPerg,{ "09", STR0011 }) //"Resultados dos Ensaios"
aAdd( aPerg,{ "10", STR0012 }) //"Resultados Dimensionais"
aAdd( aPerg,{ "11", STR0013 }) //"Auxiliares de Verificacao"
aAdd( aPerg,{ "12", STR0014 }) //"Aprovacao de Engenharia"
aAdd( aPerg,{ "13", STR0015 }) //"VERIFICACAO DE PROJETO E DESENVOLVIMENTO DE PROCESSO"
aAdd( aPerg,{ "14", STR0016 }) //"Diagramas de Fluxo de Processo"
aAdd( aPerg,{ "15", STR0017 }) //"FMEA de Processo"
aAdd( aPerg,{ "16", STR0018 }) //"Caracteristicas Especiais de Processo"
aAdd( aPerg,{ "17", STR0019 }) //"Plano de Controle de Pre-Lancamento "
aAdd( aPerg,{ "18", STR0020 }) //"Plano de Controle de Producao"
aAdd( aPerg,{ "19", STR0021 }) //"Estudos de Sistemas de Medicao"
aAdd( aPerg,{ "20", STR0022 }) //"Aprovacao Interina"
aAdd( aPerg,{ "21", STR0023 }) //"VALIDACAO DE PROCESSO E PRODUTO"
aAdd( aPerg,{ "22", STR0024 }) //"Estudos Iniciais de Processo"
aAdd( aPerg,{ "23", STR0025 }) //"Submissao do Certificado de Aprovacao da Peca (CFG-1001)"
aAdd( aPerg,{ "24", STR0026 }) //"ELEMENTOS A SEREM COMPLETADOS QUANDO NECESSARIO"
aAdd( aPerg,{ "25", STR0027 }) //"Contato no Local de Producao do Cliente"
aAdd( aPerg,{ "26", STR0028 }) //"Alteracao de Documentacao"
aAdd( aPerg,{ "27", STR0029 }) //"Consideracoes do Subcontratado"

Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKY")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKY->QKY_PECA+QKY->QKY_REV == cPecaRev

	nPos	:= 0
	
	If lin > 2360
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 30

	nPos := aScan(aPerg, {|x| x[1] == QKY->QKY_NQST })

	oPrint:Say(lin,0020,aPerg[nPos,2],oFontCou08)

	oPrint:Say(lin,1066,SubsTr(QKY->QKY_REQDT,1,10),oFontCou08)
	oPrint:Say(lin,1250,Subs(QKY->QKY_RESCLI,1,25),oFontCou08)
	oPrint:Say(lin,1720,Subs(QKY->QKY_RESFOR,1,25),oFontCou08)
	oPrint:Say(lin,2190,Subs(QKY->QKY_COMENT,1,25),oFontCou08)
	oPrint:Say(lin,2650,Subs(QKY->QKY_APRPDT,1,25),oFontCou08)

	lin += 40
	oPrint:Line( lin, 10, lin, 3090 )   	// horizontal

	If lin > 2360
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabecalho(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	cFilRes := QKY->QKY_FILRES
	
	cResp1 := QKY->QKY_RESP1
	cResp2 := QKY->QKY_RESP2
	cResp3 := QKY->QKY_RESP3

	cCiaCd1 := QKY->QKY_CIACD1
	cCiaCd2 := QKY->QKY_CIACD2
	cCiaCd3 := QKY->QKY_CIACD3

	DbSelectArea("QKY")
	DbSkip()

Enddo

oPrint:Say(2210,100,STR0030,oFont08) //"Plano aceito por"
oPrint:Say(2210,400,Posicione("QAA",1,cFilRes+cResp1,"QAA_NOME"),oFontCou08)
oPrint:Say(2250,400,Posicione("QAA",1,cFilRes+cResp2,"QAA_NOME"),oFontCou08)
oPrint:Say(2290,400,Posicione("QAA",1,cFilRes+cResp3,"QAA_NOME"),oFontCou08)

oPrint:Say(2210,1500,STR0031,oFont08) //"Companhia/Cargo/Data"
oPrint:Say(2210,1850,cCiaCd1,oFontCou08)
oPrint:Say(2250,1850,cCiaCd2,oFontCou08)
oPrint:Say(2290,1850,cCiaCd3,oFontCou08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabecalho³ Autor ³ Robson Ramiro A. Olive³ Data ³ 04.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist Material a Granel                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabecalho(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR330                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabecalho(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0032,oFont16) //"Relacao de Requisitos para Material a Granel"

oPrint:Say(160,040,STR0033,oFont08) //"Numero da Peca no Cliente:"
oPrint:Say(160,500,QK1->QK1_PCCLI,oFontCou08)

oPrint:Say(160,1740,STR0034,oFont08) //"Peca/Rev (Fornecedor):"
oPrint:Say(160,2100,AllTrim(QK1->QK1_PECA)+ " / " + QK1->QK1_REV,oFontCou08)

// Box 
oPrint:Box( 200, 10, 2170, 3090 )
               
oPrint:Say(210,1080,STR0035,oFont08) //"Requerido/"
oPrint:Say(240,1080,STR0036,oFont08) //"Data Alvo"
oPrint:Say(210,1520,STR0037,oFont08) //"Responsabilidade Primaria"
oPrint:Say(240,1350,STR0038,oFont08) //"Cliente"
oPrint:Say(240,1820,STR0039,oFont08) //"Fornecedor"
oPrint:Say(220,2190,STR0040,oFont08) //"Comentarios/Condicoes"
oPrint:Say(220,2650,STR0041,oFont08) //"Aprovado Por/Data"

oPrint:Line( 280, 10, 280, 3090 )   	// horizontal

oPrint:Line( 200, 1049, 2170, 1049 )	// vertical
oPrint:Line( 200, 1240, 2170, 1240 )	// vertical
oPrint:Line( 280, 1710, 2170, 1710 )	// vertical
oPrint:Line( 200, 2180, 2170, 2180 )	// vertical
oPrint:Line( 200, 2640, 2170, 2640 )	// vertical

Return Nil
