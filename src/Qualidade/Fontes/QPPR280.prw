/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR280.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR280  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 30.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A4                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR280(void)                                              ³±±
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

User Function QPPR280(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte := .F.
Local cFiltro	:= ""
Local aArea		:= GetArea()  
Local cStartPath 	:= GetSrvProfString("Startpath","")
Local lPriED280R   := GetMV("MV_QAPQPED",.T.,"1") == '1' // Define se o APQP deve ser feito na primeira ou segunda edição 1 - Primeira Edição 2 - Segunda Edição
Local nNrespR      := 0
Private cPecaRev 	:= ""

Private cEspecie	:= "PPA280"
Private nTamLin 	:= 38 // Tamanho da linha do texto

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""

nNrespR := QPPA280CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP
DbSelectArea("QKT")
		DbSetOrder(1)
		cFiltro := 'QKT_NPERG == "01"'
		Set Filter To &cFiltro



If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Checklist APQP A4"

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA280"
		cPecaRev := Iif(!lBrow,M->QKT_PECA + M->QKT_REV, QKT->QKT_PECA + QKT->QKT_REV)
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

DbSelectArea("QKT")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)


nNrespR := QPPA280CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP


	If Empty(cPecaAuto)
		MsgRun(STR0002,"",{|| CursorWait(), Iif(nNrespR == 53 ,MontRel(oPrint),MontRED(oPrint) ) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		Iif(nNrespR == 53 ,MontRel(oPrint),MontRED(oPrint) )
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
±±³Funcao    ³ MontRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 30.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A4                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR280                                                    ³±±
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


aAdd( aPerg,{ 	"01", STR0003,; //" E necessaria a assistencia da qualidade assegurado do"
				STR0004,; //" cliente ou atividade da engenharia do produto para"
				STR0005 }) //" desenvolver ou aprovar o plano de controle ?"

aAdd( aPerg,{ 	"02", STR0006,; //" O fornecedor identificou quem sera o contato da"
				STR0007,; //" qualidade com o cliente ?"
				Space(50) })

aAdd( aPerg,{	"03", STR0008,; //" O fornecedor indentificou quem sera o contato da"
				STR0009,; //" qualidade com seus fornecedores ?"
				Space(50) })

aAdd( aPerg,{	"04", STR0010,; //" O sistema da qualidade foi analisado criticamente"
				STR0011,; //" atraves da utilizacao do manual de Avaliacao do Sistema"
				STR0012 }) //" da Qualidade da Chrysler, Ford e General Motors ?"

aAdd( aPerg,{	"05", STR0013,; //" Existe pessoal suficiente identificado para cobrir :"
				STR0014,; //"* Requisitos do plano de controle ?"
				Space(50) })

aAdd( aPerg,{	"06", STR0015,; //"* Inspecao dimensional ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"07", STR0016,; //"* Testes de desempenho de engenharia ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"08", STR0017,; //"* Analise de solucao de problemas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"09", STR0018,; //" Existe um programa de treinamento documentado que :"
				STR0019,; //"* Inclua todos os funcionarios ?"
				Space(50) })

aAdd( aPerg,{	"10", STR0020,; //"* Descreva aqueles que foram treinados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"11", STR0021,; //"* Forneca uma programacao de treinamento ?"
				Space(50), Space(50) })

aAdd( aPerg,{ 	"12", STR0022,; //" Foi completado treinamento para :"
				STR0023,; //"* Controle Estatistico de Processo"
				Space(50) })

aAdd( aPerg,{	"13", STR0024,; //"* Estudos de Capabilidade ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"14", STR0025,; //"* Solucao de Problemas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"15", STR0026,; //"* Prova de erros ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"16", STR0027,; //"* Outros topicos, conforme identificados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"17", STR0028,; //"* Cada operacao e dotada de instrucoes de processo"
				STR0029,; //" ligadas com o plano de controle ?"
				Space(50) })

aAdd( aPerg,{	"18", STR0030,; //"* Instrucoes padrao para o operador estao disponiveis"
				STR0031,; //" para cada operacao ?"
				Space(50) })

aAdd( aPerg,{	"19", STR0032,; //"* Lideres de operacao/equipe estiveram envolvidos no"
				STR0033,; //" desenvolvimento de instrucoes padrao de operacao ?"
				Space(50) })

aAdd( aPerg,{	"20", STR0034,; //" As instrucoes de inspecao incluem :"
				STR0035,; //"* Especificacoes de desempenho de engenharia"
				STR0036 }) //" facilmente compreendidas ?"

aAdd( aPerg,{	"21", STR0037,; //"* Frequencia de testes ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"22", STR0038,; //"* Tamanho das amostras ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"23", STR0039,; //"* Planos de reacao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"24", STR0040,; //"* Documentacao ?"
				Space(50),;
				Space(50) })

aAdd( aPerg,{	"25", STR0041,;	 	//" As instrucoes visuais sao :"
				STR0042,; 			//"* Facilmente compreendidas ?"
				Space(50) })

aAdd( aPerg,{	"26", STR0043,; //"* Disponiveis ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"27", STR0044,; //"* Acessiveis ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"28", STR0045,; //"* Aprovados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"29", STR0046,; //"* Datadas e atualizadas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"30", STR0047,; //" Existe procedimento para implementar, manter e"
				STR0048,; //" estabelecer planos de reacao para cartas de controle"
				STR0049 }) //" estatistico ?"

aAdd( aPerg,{	"31", STR0050,; //" Existe um sistema de analise de causa de raiz efetivo ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"32", STR0051,; //" Foram feitas provisoes para deixar os desenhos e "
				STR0052,; //" especificacoes em seu ultimo nivel de revisao no ponto"
				STR0053 }) //" de inspecao ?"

aAdd( aPerg,{	"33", STR0054,; //" Formularios/registros estao disponiveis para que o"
				STR0055,; //" pessoal adequado registre os resultados de inspecao ?"
				Space(50) })

aAdd( aPerg,{	"34", STR0056,; //" Foram feitas provisoes para se colocar o seguinte material"
				STR0057,; //" na operacao monitorada :"
				STR0058 }) //"* Instrumento de inspecao ?"

aAdd( aPerg,{	"35", STR0059,; //"* Instrucoes sobre instrumentos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"36", STR0060,; //"* Amostras de referencia ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"37", STR0061,; //"* Registros de inspecao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"38", STR0062,; //" Foram feitas provisoes para certificar e calibrar"
				STR0063,; //" rotineiramente os dispositivos de medicao e"
				STR0064 }) //"equipamentos de teste ?"
				
aAdd( aPerg,{	"39", STR0065,; //" Os estudos de capabilidade do sistema de medicao"
				STR0066,; //" necessarios foram :"
				STR0067 }) //"* Completados"

aAdd( aPerg,{	"40", STR0068,; //"* Aceitos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"41", STR0069,; //" As intalacoes e equipamentos de inspecao sao"
				STR0070,; //" adequados para proporcionar uma inspecao dimensional"
				STR0071 }) //" inicial e continua em todos os detalhes e componentes ?"

aAdd( aPerg,{	"42", STR0072,; //" Existe algum procedimento para o controle de recebimento"
				STR0073,; //" de produtos que identifica :"
				STR0074 }) //"* Caracteristicas a serem inspecionadas ?"
				
aAdd( aPerg,{	"43", STR0075,; //"* Frequencia da inspecao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"44", STR0076,; //"* Tamanho da amostra ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"45", STR0077,; //"* Local designado para o produto aprovado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"46", STR0078,; //"* Disposicao de produtos nao-conforme ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"47", STR0079,; //" Existe algum procedimento para identificar, segregar"
				STR0080,; //" e controlar produtos nao-conforme para evitar a"
				STR0081 }) //" sua entrega ?"

aAdd( aPerg,{ 	"48", STR0082,; //" Estao disponiveis procedimentos de retrabalho/reparo ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"49", STR0083,; //" Existe algum procedimento para requalificar material"
				STR0084,; //" reparado/retrabalhado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"50", STR0085,; //" Existe um sistema adequado de rastreabilidade de"
				STR0086,; //" lotes ?"
				Space(50) })
				
aAdd( aPerg,{	"51", STR0087,; //" Foram planejadas e implementadas, auditorias"
				STR0088,; //" periodicas de produto acabado ?"
				Space(50) })

aAdd( aPerg,{ 	"52", STR0089,; //" Foram planejadas e implementadas pesquisas"
				STR0090,; //" periodicas do sistema da qualidade"
				Space(50) })

aAdd( aPerg,{	"53", STR0091,; //" O cliente aprovou a especificacao de embalagem ?"
				Space(50), Space(50) })


Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKT")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKT->QKT_PECA+QKT->QKT_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200 .or. (QKT->QKT_NPERG $ "10_19_28_37_46" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKT->QKT_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKT->QKT_CHAVE,cEspecie+QKT->QKT_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))

	oPrint:Say(lin,0050,Str(Val(QKT->QKT_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
	If QKT->QKT_RPOSTA == "1"
		oPrint:Say(lin,1220,"X",oFont08)
	Else
		oPrint:Say(lin,1320,"X",oFont08)
	Endif
	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKT->QKT_FILRES+QKT->QKT_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKT->QKT_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKT->QKT_PREPOR

	DbSelectArea("QKT")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0092,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec1ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 30.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A4                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec1ED(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec1ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 6

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,700,STR0093,oFont16) //" A-4 LISTA DE VERIFICACAO DA QUALIDADE DO PRODUTO/PROCESSO"

oPrint:Say(160,040,STR0094,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0095,oFont08) //"Pergunta"
oPrint:Say(220,1210,STR0096,oFont08) //"Sim"
oPrint:Say(220,1310,STR0097,oFont08) //"Nao"
oPrint:Say(220,1550,STR0098,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0099,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0100,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1190, 2220, 1190 )	// vertical
oPrint:Line( 200, 1290, 2220, 1290 )	// vertical
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0101,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKT->QKT_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0102+Str(i,2)+STR0103+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontRED ³ Autor ³ Klaus DAniel L Cabral³ Data ³ 30.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A4                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRED(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRED(oPrint)   // Monta o relatório na Segunda Edição do APQP

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


aAdd( aPerg,{ 	"01", STR0120,;   //"É necessária a assistência ou aprovação do cliente"
				STR0121,;         //"para desenvolver o plano de controle ?"
				Space(50) }) 

aAdd( aPerg,{ 	"02", STR0123,;    //"A Organização identificou quem será o contato da "
				STR0007,;          //" qualidade com o cliente ?"
				Space(50) })

aAdd( aPerg,{	"03", STR0123,;     //"A Organização identificou quem será o contato da "
				STR0009,;           //" qualidade com seus fornecedores ?"
				Space(50) })

aAdd( aPerg,{	"04", STR0010,; //" O sistema da qualidade foi analisado criticamente"
					STR0107,; //"e aprovado de acordo com os requisitos do cliente?"
				Space(50) })

aAdd( aPerg,{	"05", STR0013,; //" Existe pessoal suficiente identificado para cobrir :"
				STR0014,; //"* Requisitos do plano de controle ?"
				Space(50) })

aAdd( aPerg,{	"06", STR0015,; //"* Inspecao dimensional ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"07", STR0016,; //"* Testes de desempenho de engenharia ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"08", STR0108,; //"Reaçao a problemas e analise de solução de problemas?"
				Space(50), Space(50) })

aAdd( aPerg,{	"09", STR0018,; //" Existe um programa de treinamento documentado que :"
				STR0019,; //"* Inclua todos os funcionarios ?"
				Space(50) })

aAdd( aPerg,{	"10", STR0020,; //"* Descreva aqueles que foram treinados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"11", STR0021,; //"* Forneca uma programacao de treinamento ?"
				Space(50), Space(50) })

aAdd( aPerg,{ 	"12", STR0022,; //" Foi completado treinamento para :"
				STR0023,; //"* Controle Estatistico de Processo"
				Space(50) })

aAdd( aPerg,{	"13", STR0024,; //"* Estudos de Capabilidade ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"14", STR0124,; //"Resolução de Problemas ?
				Space(50), Space(50) })

aAdd( aPerg,{	"15", STR0026,; //"* Prova de erros ?"
				Space(50), Space(50) })
				
aAdd( aPerg,{	"16", STR0109,; // "Planos de Reação?"
				Space(50), Space(50) })

aAdd( aPerg,{	"17", STR0027,; //"* Outros topicos, conforme identificados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"18", STR0028,; //"* Cada operacao e dotada de instrucoes de processo"
				STR0029,; //" ligadas com o plano de controle ?"
				Space(50) })

aAdd( aPerg,{	"19", STR0125,;    //"As instruções-padrão para o operador estão"
				STR0126,;          //"acessíveis em cada estação de trabalho ?"
				Space(50) }) 
				
aAdd( aPerg,{	"20", STR0110,;  //"As instruções para o operador incluem fotos e diagramas"
				Space(50), Space(50) })

aAdd( aPerg,{	"21", STR0032,; //"* Lideres de operacao/equipe estiveram envolvidos no"
				STR0033,; //" desenvolvimento de instrucoes padrao de operacao ?"
				Space(50) })

aAdd( aPerg,{	"22", STR0034,; //" As instrucoes de inspecao incluem :"
				STR0035,; //"* Especificacoes de desempenho de engenharia"
				STR0036 }) //" facilmente compreendidas ?"

aAdd( aPerg,{	"23", STR0037,; //"* Frequencia de testes ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"24", STR0038,; //"* Tamanho das amostras ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"25", STR0039,; //"* Planos de reacao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"26", STR0127,; //"Requisitos de documentação"
				Space(50),;
				Space(50) })

aAdd( aPerg,{	"27", STR0041,;	 	//" As instrucoes visuais sao :"
				STR0128,; 			//"Apropriadas, facilmente compreendidas e legíveis?"
				Space(50) })

aAdd( aPerg,{	"28", STR0043,; //"* Disponiveis ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"29", STR0044,; //"* Acessiveis ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"30", STR0045,; //"* Aprovados ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"31", STR0046,; //"* Datadas e atualizadas ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"32", STR0129,;    //"Existe um procedimento para implementar, manter e estabelecer"
				STR0130,;          //"planos de reação para questões como condições fora de controle"
				STR0131 })         //"baseadas no controle estatístico de processo? "

aAdd( aPerg,{	"33", STR0132,;   //"Existe um processo identificado para a resolução de "
				STR0133,;         //"problemas que inclui a análise de causa raiz?"
				 Space(50) })

aAdd( aPerg,{	"34", STR0134,;    //"Os desenhos e especificações mais atualizados estão"
				STR0135,;          //"disponíveis para o operador, em particular nos "
				STR0136 })         //"pontos de inspeção?"  
				
aAdd( aPerg,{	"35", STR0111,;    //"Os testes de engenharia (dimensionais, de material, aparencia"
			     STR0112,; 		   //"e desempenho) foram concluidos e documentados, conforme "
				STR0112 }) 		   //"necessario, de acordo com os requisitos do cliente?"


aAdd( aPerg,{	"36", STR0054,;   //" Formularios/registros estao disponiveis para que o"
				STR0055,;         //" pessoal adequado registre os resultados de inspecao ?"
				Space(50) })

aAdd( aPerg,{	"37", STR0137,;    //"Os itens abaixo estão disponíveis e foram colocados nos "
				STR0138,;          //"pontos apropriados da operação?"
				STR0114 })         //"Dispositivos de monitoramento e medição?"

aAdd( aPerg,{	"38", STR0059,; //"* Instrucoes sobre instrumentos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"39", STR0060,; //"* Amostras de referencia ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"40", STR0061,; //"* Registros de inspecao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"41", STR0062,; //" Foram feitas provisoes para certificar e calibrar"
				STR0063,; //" rotineiramente os dispositivos de medicao e"
				STR0064 }) //"equipamentos de teste ?"
				
aAdd( aPerg,{	"42", STR0065,; //" Os estudos de capabilidade do sistema de medicao"
				STR0066,; //" necessarios foram :"
				STR0139 }) //"* Completados"

aAdd( aPerg,{	"43", STR0068,; //"* Aceitos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"44", STR0116,;  //"Os Estudos de capabilidade inicial do processo foram"
				STR0117,;   //"conduzidos de acordo com os requisitos do cliente?"
				 Space(50) })
				
aAdd( aPerg,{	"45", STR0140,;     //"As instalações e equipamentos de inspeção de layout são adequadas"
				STR0141,;          //"para proporcionar um layout inicial e continuo de todos os"
				STR0142 })         //"detalhes e componentes, de acordo com os requisitos do cliente ?"

aAdd( aPerg,{	"46", STR0072,; //" Existe algum procedimento para o controle de recebimento"
				STR0073,; //" de produtos que identifica :"
				STR0074 }) //"* Caracteristicas a serem inspecionadas ?"
				
aAdd( aPerg,{	"47", STR0075,; //"* Frequencia da inspecao ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"48", STR0076,; //"* Tamanho da amostra ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"49", STR0077,; //"* Local designado para o produto aprovado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"50", STR0078,; //"* Disposicao de produtos nao-conforme ?"
				Space(50), Space(50) })
				
				
aAdd( aPerg,{	"51", STR0118,;  //"Peças de amostra da producao foram fornecidas de acordo "
				STR0119,;        //"com os requisitos do cliente?"
				 Space(50) })				

aAdd( aPerg,{	"52", STR0079,;   //" Existe algum procedimento para identificar, segregar"
				STR0080,;         //" e controlar produtos nao-conforme para evitar a"
				STR0081 })        //" sua entrega ?"

aAdd( aPerg,{ 	"53", STR0143,;    //"Estão disponiveis procedimentos de retrabalho / reparo"
				STR0144,;          //"para assegurar produtos conformes ?"
				 Space(50) })

aAdd( aPerg,{	"54", STR0083,; //" Existe algum procedimento para requalificar material"
				STR0084,; //" reparado/retrabalhado ?"
				Space(50), Space(50) })
				
aAdd( aPerg,{	"55", STR0105,; //"Uma amostra mestre foi retida, se necessario, como"
     			STR0104,; //"parte do processo de aprovacao de peça?"
				Space(50), Space(50) })

aAdd( aPerg,{	"56", STR0085,; //" Existe um sistema adequado de rastreabilidade de"
				STR0086,; //" lotes ?"
				Space(50) })
				
aAdd( aPerg,{	"57", STR0087,; //" Foram planejadas e implementadas, auditorias"
				STR0088,; //" periodicas de produto acabado ?"
				Space(50) })

aAdd( aPerg,{ 	"58", STR0089,; //" Foram planejadas e implementadas pesquisas"
				STR0090,; //" periodicas do sistema da qualidade"
				Space(50) })

aAdd( aPerg,{	"59", STR0145,; //"O cliente aprovou a embalagem e a especificação da "
				STR0122,;       //"embalagem? "
				 Space(50) })


Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKT")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKT->QKT_PECA+QKT->QKT_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200 .or. (QKT->QKT_NPERG $ "10_19_28_37_46_55" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKT->QKT_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKT->QKT_CHAVE,cEspecie+QKT->QKT_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))

	oPrint:Say(lin,0050,Str(Val(QKT->QKT_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
	
//Consistência para verificar onde Marca o "X" no relatorio//
	If QKT->QKT_RPOSTA == "1"
		oPrint:Say(lin,1120,"X",oFont08)             //Se o valor  for igua a 1, Cria na coluna 1120
		Elseif QKT->QKT_RPOSTA == "2" 
			oPrint:Say(lin,1220,"X",oFont08)        //Se o valor  for igua a 2, Cria na coluna 1120
		Else
			oPrint:Say(lin,1338,"X",oFont08)        //Se o valor  for igua a 3, Cria na coluna 1120
	Endif 
	
    

	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKT->QKT_FILRES+QKT->QKT_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKT->QKT_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKT->QKT_PREPOR

	DbSelectArea("QKT")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0092,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec2ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 30.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A4                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec2ED(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR280                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec2ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 6

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,700,STR0093,oFont16) //" A-4 LISTA DE VERIFICACAO DA QUALIDADE DO PRODUTO/PROCESSO"

oPrint:Say(160,040,STR0094,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0095,oFont08) //"Pergunta"
oPrint:Say(220,1100,STR0096,oFont08) //"Sim"
oPrint:Say(220,1200,STR0097,oFont08) //"Nao" 
oPrint:Say(220,1320,STR0106,oFont08) //"N/a"
oPrint:Say(220,1550,STR0098,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0099,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0100,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1080, 2220, 1080 )	// vertical
oPrint:Line( 200, 1180, 2220, 1180 )	// vertical
oPrint:Line( 200, 1285, 2220, 1285 )	// vertical   //(nova linha para a divisao do n/a )//
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0101,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKT->QKT_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0102+Str(i,2)+STR0103+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil
