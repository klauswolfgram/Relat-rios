/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR300.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR300  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 02.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A6                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR300(void)                                              ³±±
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

User Function QPPR300(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cStartPath 	:= GetSrvProfString("Startpath","")
Local lPriED300R   := GetMV("MV_QAPQPED",.T.,"1") == '1' // Define se o APQP deve ser feito na primeira ou segunda edição 1 - Primeira Edição 2 - Segunda Edição
Local nNrespR      := 0

Private cPecaRev 	:= ""
Private cEspecie	:= "PPA300"
Private nTamLin 	:= 38 // Tamanho da linha do texto

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""        


nNrespR := QPPA300CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP
DbSelectArea("QKV")
		DbSetOrder(1)
		cFiltro := 'QKV_NPERG == "01"'
		Set Filter To &cFiltro



If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Checklist APQP A6"

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA300"
		cPecaRev := Iif(!lBrow,M->QKV_PECA + M->QKV_REV, QKV->QKV_PECA + QKV->QKV_REV)
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

DbSelectArea("QKV")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

nNrespR := QPPA300CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP

	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), Iif(nNrespR == 7 ,MontRel(oPrint),MontRED(oPrint) ) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		Iif(nNrespR == 7 ,MontRel(oPrint),MontRED(oPrint) )
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,1120,855,140)
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
±±³Funcao    ³ MontRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 02.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A6                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRel(oPrint)

Local lin, nPos
Local i 		:= 1
Local cTexto	:= ""
Local aPerg		:= {}
Local cPrepor	:= ""

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)


aAdd( aPerg,{	"01", STR0003,;	//" O Fluxograma ilustra a sequencia de producao e"
				STR0004,; 		//" pontos de inspecao ?"
				Space(50) })

aAdd( aPerg,{	"02", STR0005,;	//" Todos os FMEA apropriados (SFMEA, DFMEA) estavam"
				STR0006,; 		//" disponiveis e foram usados como auxilio para"
				STR0007 }) 		//" desenvolver o fluxograma de processo ?"

aAdd( aPerg,{	"03", STR0008,;	//" O Fluxograma esta direcionado as verificacoes de"
				STR0009,; 		//" produto e processo no plano de controle ?"
				Space(50) })

aAdd( aPerg,{	"04", STR0010,;	//" O fluxograma descreve como o produto sera"
				STR0011,; 		//" movimentado isto e, correia transportadora,"
				STR0012 }) 		//" container deslizantes, etc. ?"

aAdd( aPerg,{	"05", STR0013,;	//" A otimizacao/Sistema de tracao foi considerada para"
				STR0014,; 		//" este processo ?"
				Space(50) })

aAdd( aPerg,{	"06", STR0015,;	//" Foram tomadas medidas para identificar e inspecionar"
				STR0016,; 		//" os produtos retrabalhados antes de serem usados ?"
				Space(50) })

aAdd( aPerg,{	"07", STR0017,;	//" Problemas de qualidade em potenciais devido ao"
				STR0018,; 		//" manuseio e processamento externo, foram identificados"
				STR0019 }) 		//" e corrigidos ?"

Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKV")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKV->QKV_PECA+QKV->QKV_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKV->QKV_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKV->QKV_CHAVE,cEspecie+QKV->QKV_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))

	oPrint:Say(lin,0050,Str(Val(QKV->QKV_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
	If QKV->QKV_RPOSTA == "1"
		oPrint:Say(lin,1220,"X",oFont08)
	Else
		oPrint:Say(lin,1320,"X",oFont08)
	Endif
	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKV->QKV_FILRES+QKV->QKV_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKV->QKV_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKV->QKV_PREPOR

	DbSelectArea("QKV")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0020,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec1ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 02.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A6                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec1ED(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec1ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 1

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0021,oFont16) //" A-6 LISTA DE VERIFICACAO DO FLUXOGRAMA DO PROCESSO"

oPrint:Say(160,040,STR0022,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0023,oFont08) //"Pergunta"
oPrint:Say(220,1210,STR0024,oFont08) //"Sim"
oPrint:Say(220,1310,STR0025,oFont08) //"Nao"
oPrint:Say(220,1550,STR0026,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0027,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0028,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1190, 2220, 1190 )	// vertical
oPrint:Line( 200, 1290, 2220, 1290 )	// vertical
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0029,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKV->QKV_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0030+Str(i,2)+STR0031+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontRED ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 02.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A6                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRED(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRED(oPrint) //--> Tela segunda Edição

Local lin, nPos
Local i 		:= 1
Local cTexto	:= ""
Local aPerg		:= {}
Local cPrepor	:= ""

Private oFont16, oFont08, oFont10, oFontCou08

oFont16		:= TFont():New("Arial",16,16,,.F.,,,,.T.,.F.)
oFont08		:= TFont():New("Arial",08,08,,.F.,,,,.T.,.F.)
oFont10		:= TFont():New("Arial",10,10,,.F.,,,,.T.,.F.)
oFontCou08	:= TFont():New("Courier New",08,08,,.F.,,,,.T.,.F.)


aAdd( aPerg,{	"01", STR0035,;	//"O fluxograma Ilustra todo processo desde o"
				STR0036,; 		//"recebimento até a expedição, incluindo processos e"
				STR0037 })      //"Serviços externos?"


aAdd( aPerg,{	"02", STR0038,;	//"No desenvolvimento do fluxograma de processo, a"
				STR0039,; 		//"DFMEA foi utilizada, se disponivel, para identificar"
				STR0040 }) 		//"caracteristicas especificas que podem ser criticas?"

aAdd( aPerg,{	"03", STR0041,;	//"O fluxograma esta adaptado às verificações do produto"
				STR0042,; 		//"e processo no Plano de controle e na PFMEA?"
				Space(50) })

aAdd( aPerg,{	"04", STR0010,;	//" O fluxograma descreve como o produto sera"
				STR0011,; 		//" movimentado isto e, correia transportadora,"
				STR0012 }) 		//" container deslizantes, etc. ?"

aAdd( aPerg,{	"05", STR0013,;	//" A otimizacao/Sistema de tracao foi considerada para"
				STR0014,; 		//" este processo ?"
				Space(50) })

aAdd( aPerg,{	"06", STR0015,;	//" Foram tomadas medidas para identificar e inspecionar"
				STR0016,; 		//" os produtos retrabalhados antes de serem usados ?"
				Space(50) })

aAdd( aPerg,{	"07", STR0043,;	//"Os Controles de Material para movimentação e"
				STR0032,; 		//"elevação dos produtos, incluindo identificação"
				STR0033 })      //"apropriada, foram identificados e implementados adequadamente ?"
				
				
//Posição do array 'aPerg' adicionada Para controle de versão do APQP.				
aAdd( aPerg,{	"08"," ",;	
				" ",; 		
				" " }) 

Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho da segunda Edição
lin := 280

DbSelectArea("QKV")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKV->QKV_PECA+QKV->QKV_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKV->QKV_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKV->QKV_CHAVE,cEspecie+QKV->QKV_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))
    
    // Validação para Não Imprimir o campo de Controle 08
    
    If QKV->QKV_NPERG <> '08'

	oPrint:Say(lin,0050,Str(Val(QKV->QKV_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
//Consistência para verificar onde Marca o "X" no relatorio//
	If QKV->QKV_RPOSTA == "1"
		oPrint:Say(lin,1120,"X",oFont08)             //Se o valor   for igua a 1, Cria na coluna 1120
		Elseif QKV->QKV_RPOSTA == "2" 
			oPrint:Say(lin,1220,"X",oFont08)        //Se o valor  for igua a 2, Cria na coluna 1120
		Else
			oPrint:Say(lin,1338,"X",oFont08)        //Se o valor  for igua a 3, Cria na coluna 1120
	Endif 
	
	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKV->QKV_FILRES+QKV->QKV_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKV->QKV_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

    EndIf //Fim validação Campo de Controle 
    
	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKV->QKV_PREPOR

	DbSelectArea("QKV")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0020,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec2ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 02.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A6                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec2ED(ExpO1,ExpN1)   //Segunda Edição                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR300                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec2ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 1

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0021,oFont16) //" A-6 LISTA DE VERIFICACAO DO FLUXOGRAMA DO PROCESSO"

oPrint:Say(160,040,STR0022,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0023,oFont08) //"Pergunta"
oPrint:Say(220,1100,STR0024,oFont08) //"Sim"
oPrint:Say(220,1200,STR0025,oFont08) //"Nao"
oPrint:Say(220,1320,STR0034,oFont08) //"N/a"
oPrint:Say(220,1550,STR0026,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0027,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0028,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1080, 2220, 1080 )	// vertical
oPrint:Line( 200, 1180, 2220, 1180 )	// vertical
oPrint:Line( 200, 1285, 2220, 1285 )	// vertical   //(nova linha para a divisao do n/a )//
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical


oPrint:Say(2240,2100,STR0029,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKV->QKV_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0030+Str(i,2)+STR0031+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil
