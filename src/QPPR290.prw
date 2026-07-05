/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR290.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR290  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 01.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A5                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR290(void)                                              ³±±
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

User Function QPPR290(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()
Local cStartPath 	:= GetSrvProfString("Startpath","")
Local lPriED290R   := GetMV("MV_QAPQPED",.T.,"1") == '1' // Define se o APQP deve ser feito na primeira ou segunda edição 1 - Primeira Edição 2 - Segunda Edição
Local nNrespR      := 0

Private cPecaRev 	:= ""
Private cEspecie	:= "PPA290"
Private nTamLin 	:= 38 // Tamanho da linha do texto

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""  


nNrespR := QPPA290CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP
DbSelectArea("QKU")
		DbSetOrder(1)
		cFiltro := 'QKU_NPERG == "01"'
		Set Filter To &cFiltro


If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New("Checklist APQP A5")

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA290"
		cPecaRev := Iif(!lBrow,M->QKU_PECA + M->QKU_REV, QKU->QKU_PECA + QKU->QKU_REV)
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

DbSelectArea("QKU")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)

	nNrespR := QPPA290CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP

	If Empty(cPecaAuto)
		MsgRun(STR0001,"",{|| CursorWait(), Iif(nNrespR == 13 ,MontRel(oPrint),MontRED(oPrint) ) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		Iif(nNrespR == 13 ,MontRel(oPrint),MontRED(oPrint) )
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
±±³Funcao    ³ MontRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 01.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A5                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR290                                                    ³±±
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


aAdd( aPerg,{	"01", STR0002,;	//" As instalacoes e equipamentos de inspecao sao"
				STR0003,; 		//" adequados  para proporcionar uma inspecao dimensional"
				STR0004 }) 		//" inicial e continua em todos os detalhes e componentes ?"

aAdd( aPerg,{	"02", STR0005,;	//" Foram claramente marcadas as areas para todos os"
				STR0006,; 		//" materiais, ferramentas e equipamentos para cada"
				STR0007 }) 		//" operacao considerada ?"

aAdd( aPerg,{	"03", STR0008,;	//" Foi reservado espaco suficiente para todos os"
				STR0009,; 		//" equipamentos ?"
				Space(50) })

aAdd( aPerg,{	"04", STR0010,;	//" AS AREAS DE PROCESSO E INSPECAO SAO :"
				STR0011,; 		//"* De tamanho adequado ?"
				Space(50) })

aAdd( aPerg,{	"05", STR0012,; //"* Corretamente iluminadas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"06", STR0013,;	//" As areas de inspecao contem equipamentos e arquivos"
				STR0014,; 		//" necessarios ?"
				Space(50) })

aAdd( aPerg,{	"07", STR0015,;	//" SAO ADEQUADAS :"
				STR0016,; 		//"* Areas de Elevacao ?"
				Space(50) })

aAdd( aPerg,{	"08", STR0017,; //"* Areas de retencao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"09", STR0018,;	//" Os pontos de inspecao estao logicamente localizados"
				STR0019,; 		//" para evitar a entrega de produtos nao conformes ?"
				Space(50) })

aAdd( aPerg,{	"10", STR0020,;	//" Foram estabelecidos controles para eliminar o potencial"
				STR0021,; 		//" para uma operacao, inclusive processamento externo,"
				STR0022 }) 		//" contaminar ou misturar produtos similares ?"

aAdd( aPerg,{	"11", STR0023,;	//" O material esta protegido da contaminacao de sistemas"
				STR0024,; 		//" de manipulacao volante ou ar comprimido ?"
				Space(50) })

aAdd( aPerg,{	"12", STR0025,;	//" Foram providenciadas instalacoes para a auditoria final ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"13", STR0026,;	//" Os controles sao adequados para evitar o movimento"
				STR0027,; 		//" de material de entrada fora de conformidade para"
				STR0028 }) 		//" estocagem ou ponto de utilizacao ?"


Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKU")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKU->QKU_PECA+QKU->QKU_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200 .or. (QKU->QKU_NPERG $ "10_19_28_37_46" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKU->QKU_NPERG })
	
	cTexto := AllTrim(Subs(QO_Rectxt(QKU->QKU_CHAVE,cEspecie+QKU->QKU_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))

	oPrint:Say(lin,0050,Str(Val(QKU->QKU_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
	If QKU->QKU_RPOSTA == "1"
		oPrint:Say(lin,1220,"X",oFont08)
	Else
		oPrint:Say(lin,1320,"X",oFont08)
	Endif
	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKU->QKU_FILRES+QKU->QKU_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKU->QKU_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKU->QKU_PREPOR

	DbSelectArea("QKU")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0029,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec1ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 01.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A5                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec1ED(ExpO1,ExpN1)              //Primeira Edição        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec1ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 2

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0030,oFont16) //" A-5 LISTA DE VERIFICACAO DAS INSTALACOES"

oPrint:Say(160,040,STR0031,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0032,oFont08) //"Pergunta"
oPrint:Say(220,1210,STR0033,oFont08) //"Sim"
oPrint:Say(220,1310,STR0034,oFont08) //"Nao"
oPrint:Say(220,1550,STR0035,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0036,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0037,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1190, 2220, 1190 )	// vertical
oPrint:Line( 200, 1290, 2220, 1290 )	// vertical
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0038,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKU->QKU_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0039+Str(i,2)+STR0040+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontRED ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 01.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A5                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRED(ExpO1) //Segunda Edição APQP                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRED(oPrint)

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


aAdd( aPerg,{	"01", STR0045,;	 ///"Foram aplicados conceitos 'Lean' ao considerar o"
				STR0046,; 		 //"Fluxo de Material?"
				Space(50) }) 		


aAdd( aPerg,{	"02", STR0047,;	//"As instalações Identificam todos os processos requeridos"
				STR0048,; 		//"e pontos de Inspeção?"
				Space(50) }) 		

aAdd( aPerg,{	"03", STR0051,;	//"Foram consideradas áreas claramente marcadas para"
				STR0052,; 		//"todos os materiais, ferramentas e equipamentos para "
				STR0053 }) 		//"cada operação ?"

aAdd( aPerg,{	"04", STR0008,;	//" Foi reservado espaco suficiente para todos os"
				STR0009,; 		//" equipamentos ?"
				Space(50) })

aAdd( aPerg,{	"05", STR0010,;	//" AS AREAS DE PROCESSO E INSPECAO SAO :"
				STR0011,; 		//"* De tamanho adequado ?"
				Space(50) })

aAdd( aPerg,{	"06", STR0012,; //"* Corretamente iluminadas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"07", STR0013,;	//" As areas de inspecao contem equipamentos e arquivos"
				STR0014,; 		//" necessarios ?"
				Space(50) })

aAdd( aPerg,{	"08", STR0015,;	//" SAO ADEQUADAS :"
				STR0016,; 		//"* Areas de Elevacao ?"
				Space(50) })

aAdd( aPerg,{	"09", STR0017,; //"* Areas de retencao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"10", STR0018,;	//" Os pontos de inspecao estao logicamente localizados"
				STR0019,; 		//" para evitar a entrega de produtos nao conformes ?"
				Space(50) })

aAdd( aPerg,{	"11", STR0049,;	//"Foram Estabelecidos controles para cada processo "
				STR0050,; 		//"para eliminar a contaminação ou mistura inadequada"
				STR0043 }) 		//"de produtos?"

aAdd( aPerg,{	"12", STR0023,;	//" O material esta protegido da contaminacao de sistemas"
				STR0024,; 		//" de manipulacao volante ou ar comprimido ?"
				Space(50) })

aAdd( aPerg,{	"13", STR0054,;	  //"Foram providenciadas instalações para auditoria do "
				  STR0055,;       //"produto final ?"
				  Space(50) })

aAdd( aPerg,{	"14", STR0042,;  //"As Instalações são adequadas para controlar o"
				STR0041,; 	     //"movimento de material de entrada nao conforme?"	
				Space(50) }) 
				
					

Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKU")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKU->QKU_PECA+QKU->QKU_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200 .or. (QKU->QKU_NPERG $ "10_19_28_37_46" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKU->QKU_NPERG })
	
	cTexto := AllTrim(Subs(QO_Rectxt(QKU->QKU_CHAVE,cEspecie+QKU->QKU_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))

	oPrint:Say(lin,0050,Str(Val(QKU->QKU_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
//Consistência para verificar onde Marca o "X" no relatorio//
	If QKU->QKU_RPOSTA == "1"
		oPrint:Say(lin,1120,"X",oFont08)             //Se o valor de QKQ_RPOSTA for igua a 1, Cria na coluna 1120
		Elseif QKU->QKU_RPOSTA == "2" 
			oPrint:Say(lin,1220,"X",oFont08)        //Se o valor de QKQ_RPOSTA for igua a 2, Cria na coluna 1120
		Else
			oPrint:Say(lin,1338,"X",oFont08)        //Se o valor de QKQ_RPOSTA for igua a 3, Cria na coluna 1120
	Endif 

	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKU->QKU_FILRES+QKU->QKU_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKU->QKU_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKU->QKU_PREPOR

	DbSelectArea("QKU")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0029,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec2ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 01.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A5                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec2ED(ExpO1,ExpN1)              //Segunda Edição        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec2ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 2

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0030,oFont16) //" A-5 LISTA DE VERIFICACAO DAS INSTALACOES"

oPrint:Say(160,040,STR0031,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0032,oFont08) //"Pergunta"
oPrint:Say(220,1100,STR0033,oFont08) //"Sim"
oPrint:Say(220,1200,STR0034,oFont08) //"Nao" 
oPrint:Say(220,1320,STR0044,oFont08) //"N/a"
oPrint:Say(220,1550,STR0035,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0036,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0037,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1080, 2220, 1080 )	// vertical
oPrint:Line( 200, 1180, 2220, 1180 )	// vertical
oPrint:Line( 200, 1285, 2220, 1285 )	// vertical   //(nova linha para a divisao do n/a )//
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0038,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKU->QKU_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0039+Str(i,2)+STR0040+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil