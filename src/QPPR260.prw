/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR260.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR260  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 25.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR260(void)                                              ³±±
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

User Function QPPR260(lBrow,cPecaAuto,cJPEG)

Local oPrint
Local lPergunte    := .F.
Local cFiltro	   := ""
Local aArea		   := GetArea() 
Local cStartPath   := GetSrvProfString("Startpath","")
Local lPriED260R   := GetMV("MV_QAPQPED",.T.,"1") == '1' //Verifica Edição APQP
Local nNrespR      := 0
Private cPecaRev   := ""
Private cEspecie   := "PPA260"
Private nTamLin    := 38 // Tamanho da linha do texto

Default lBrow 		:= .F.
Default cPecaAuto	:= ""
Default cJPEG       := ""  


nNrespR := QPPA260CE()  //Verifica pelo numero de NResp em qual modelo foi feio o APQP
DbSelectArea("QKR")
		DbSetOrder(1)
		cFiltro := 'QKR_NPERG == "01"'
		Set Filter To &cFiltro


If Right(cStartPath,1) <> "\"
	cStartPath += "\"
Endif

If !Empty(cPecaAuto)
	cPecaRev := cPecaAuto
Endif

oPrint := TMSPrinter():New(STR0001) //"Checklist APQP A2"

oPrint:SetLandscape()

If Empty(cPecaAuto)
	If AllTrim(FunName()) == "QPPA260"
		cPecaRev := Iif(!lBrow,M->QKR_PECA + M->QKR_REV, QKR->QKR_PECA + QKR->QKR_REV)
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

DbSelectArea("QKR")

cFiltro := DbFilter()

If !Empty(cFiltro)
	Set Filter To
Endif

DbSetOrder(1)
If DbSeek(xFilial()+cPecaRev)
 
			
			nNrespR := QPPA260CE()  //Verifica pelo numro de NResp em qual modelo foi feio o APQP


	If Empty(cPecaAuto) 
		MsgRun(STR0002,"",{|| CursorWait(), Iif(nNrespR == 40 ,MontRel(oPrint),MontRED(oPrint) ) ,CursorArrow()}) //"Gerando Visualizacao, Aguarde..."
	Else
		Iif(nNrespR == 40 ,MontRel(oPrint),MontRED(oPrint))
	Endif

	If lPergunte .and. mv_par03 == 1 .or. !Empty(cPecaAuto)
		If !Empty(cJPEG)
			oPrint:SaveAllAsJPEG(cStartPath+cJPEG,1120,855,140)
		Else 
			oPrint:Print()      //Direto na Impressora.
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
±±³Funcao    ³ MontRel ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 25.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRel(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRel(oPrint)                   //--> Primeira Edição APQP

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


aAdd( aPerg,{	"01", STR0003,;	//"  A. GERAL"
				STR0004,; 		//"O Projeto exige :"
				STR0005 }) 		//" Novos Materiais ?"

aAdd( aPerg,{	"02", STR0006,; //" Ferramentas especiais ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"03", STR0007,; //" Foi Considerada a analise de variacao de montagem ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"04", STR0008,; //" Foi considerado Delineamento de Experimentos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"05", STR0009,; //" Existe algum plano para prototipos em andamento ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"06", STR0010,; //" O DFMEA foi completado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"07", STR0011,; //" O DFMA foi completado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"08", STR0012,; 	//" Foram consideradas questoes relativas a assistencia"
				STR0013,; 			//" tecnica e manutencao ?"
				Space(50) })

aAdd( aPerg,{	"09", STR0014,; //" O Plano de Verificacao de Projeto foi completado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"10", STR0015,; 	//" Em caso positivo, foi completado por uma equipe"
				STR0016,; 			//"multifuncional ?"
				Space(50) })

aAdd( aPerg,{	"11", STR0017,; 	//" Foram claramente definidos e comprometidos todos os"
				STR0018,; 			//" testes, metodos, equipamentos e criterios de aceitacao ?"
				Space(50) })

aAdd( aPerg,{	"12", STR0019,; //" Foram Selecionadas as Caracteristicas Especiais ?"
				Space(50), Space(50) })

aAdd( aPerg,{ "13", STR0020,; //" A lista de materiais/pecas esta completa ?"
				Space(50), Space(50) })

aAdd( aPerg,{ 	"14", STR0021,; 	//" As Caracteristicas Especiais estao apropriadamente"
				STR0022,; 			//" documentadas ?"
				Space(50) })

aAdd( aPerg,{ 	"15", STR0023,; 	//"  B. DESENHOS DE ENGENHARIA"
				STR0024,; 			//" Foram identificadas as dimensoes que afetam ajuste,"
				STR0025 }) 			//" funcoes e durabilidade ?"

aAdd( aPerg,{	"16", STR0026,; 	//" Foram identificadas as dimensoes de referencia para"
				STR0027,; 			//" minimizar o tempo de layout de inspecao ?"
				Space(50) })
				
aAdd( aPerg,{	"17", STR0028,; 	//" Existem pontos de controle e superficies de referencia"
				STR0029,; 			//" suficientemente indentificados para projetar dispositivos"
				STR0030 }) 			//" funcionais ?"

aAdd( aPerg,{ 	"18", STR0031,; 	//" As Tolerancias sao compativeis com normas de"
				STR0032,; 			//" manufatura aceitaveis ?"
				Space(50) })

aAdd( aPerg,{	"19", STR0033,; 	//" Existem quaisquer requisitos especificados que nao"
				STR0034,; 			//" possam ser avaliados atraves de tecnicas de inspecao"
				STR0035 }) 			//" conhecidas ?"

aAdd( aPerg,{	"20", STR0036,; 	//"  C. ESPECIFICACOES DE DESEMPENHO DE ENGENHARIA"
				STR0037,; 			//" Todas as Caracteristicas especiais foram"
				STR0038 }) 			//" identificadas ?"

aAdd( aPerg,{	"21", STR0039,; 	//" A Quantidade de Ensaios e suficiente para oferecer"
				STR0040,; 			//" todas as condicoes, ou seja, validacao de producao"
				STR0041 }) 			//" e uso final ?"

aAdd( aPerg,{	"22", STR0042,; 	//" Pecas fabricadas nas especificacoes minimas e"
				STR0043,; 			//" maximas foram testadas ?"
				Space(50) })

aAdd( aPerg,{ 	"23", STR0044,; 	//" Amostras adicionais podem ser testadas quando algum"
				STR0045,; 			//" plano de reacao assim exigir e ainda conduzir os"
				STR0046 }) 			//" testes regulares em processo ?"

aAdd( aPerg,{	"24", STR0047,; //" Todos os Ensaios de produto serao feitos internamente ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"25", STR0048,; 	//" Em caso contrario, eles serao o efetuados por um "
				STR0049,; 			//" subfornecedor aprovado ?"
				Space(50) })

aAdd( aPerg,{	"26", STR0050,; 	//" E viavel a frequencia e tamanho de amostragem para"
				STR0051,; 			//" ensaios ?"
				Space(50) })

aAdd( aPerg,{	"27", STR0052,; 	//" Se necessario, foi obtido aprovacao do cliente para"
				STR0053,; 			//" o equipamento de ensaio ?"
				Space(50) })

aAdd( aPerg,{	"28", STR0054,; 	//"  D. ESPECIFICACAO DE MATERIAIS"
				STR0055,; 			//" As caracteristicas especiais de material estao"
				STR0038 })			//" identificadas ?"

aAdd( aPerg,{	"29", STR0056,; 	//" Os materiais, tratamento termico e tratamento de"
				STR0057,; 			//" superficie especificados sao compativeis com a"
				STR0058 }) 			//" durabilidade no ambiente identificado ?"

aAdd( aPerg,{	"30", STR0059,; 	//" Os fornecedores do material previsto estao na lista"
				STR0060,; 			//" de clientes aprovados ?"
				Space(50) })

aAdd( aPerg,{	"31", STR0061,; 	//" Sera solicitado aos fornecedores de material"
				STR0062,; 			//" certificado a cada lote de entrega ?"
				Space(50) })

aAdd( aPerg,{	"32", STR0063,; 	//" Forma identificadas caracteristicas de material"
				STR0064,; 			//" que necessitam de inspecao ?"
				STR0065 }) 			//" Em caso positivo, "

aAdd( aPerg,{	"33", STR0066,; 	//"* As caracteristicas serao verificadas internamente ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"34", STR0067,; 	//"* O equipamento de teste esta disponivel ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"35", STR0068,; 	//"* Havera a necessidade de treinamento para assegurar"
				STR0069,; 			//" resultados precisos ?"
				Space(50) })

aAdd( aPerg,{	"36", STR0070,; 	//" Serao utilizados laboratorios externos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"37", STR0071,; 	//" Todos os laboratorios utilizados sao credenciados"
				STR0072,; 			//" (se necessario) ?"
				STR0073 }) 			//" Foram considerados os seguintes requisitos materiais ?"

aAdd( aPerg,{	"38", STR0074,; 	//"* Manuseio ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"39", STR0075,; 	//"* Estocagem ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"40", STR0076,; 	//"* Ambiental ?"
				Space(50), Space(50) })

Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
lin := 280

DbSelectArea("QKR")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

Do While !Eof() .and. QKR->QKR_PECA+QKR->QKR_REV == cPecaRev

	cTexto 	:= ""
	nPos	:= 0
	
	If lin > 2200 .or. (QKR->QKR_NPERG $ "10_19_28_37" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	nPos := aScan(aPerg, {|x| x[1] == QKR->QKR_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKR->QKR_CHAVE,cEspecie+QKR->QKR_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))
	
	oPrint:Say(lin,0050,Str(Val(QKR->QKR_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
	If QKR->QKR_RPOSTA == "1"
		oPrint:Say(lin,1220,"X",oFont08)
	Else
		oPrint:Say(lin,1320,"X",oFont08)
	Endif
	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKR->QKR_FILRES+QKR->QKR_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKR->QKR_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec1ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKR->QKR_PREPOR

	DbSelectArea("QKR")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0077,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec1ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 25.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec1ED(ExpO1,ExpN1)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec1ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 5

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0078,oFont16) //" A-2 LISTA DE VERIFICACAO DE INFORMACAO DO PROJETO"

oPrint:Say(160,040,STR0079,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0080,oFont08) //"Pergunta"
oPrint:Say(220,1210,STR0081,oFont08) //"Sim"
oPrint:Say(220,1310,STR0082,oFont08) //"Nao"
oPrint:Say(220,1550,STR0083,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0084,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0085,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1190, 2220, 1190 )	// vertical
oPrint:Line( 200, 1290, 2220, 1290 )	// vertical
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0086,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKR->QKR_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0087+Str(i,2)+STR0088+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil





/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MontRED ³ Autor ³ klaus daniel lopes c   ³ Data ³ 25.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MontRED(ExpO1)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MontRED(oPrint) //-->Segunda Edição do APQP.

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


aAdd( aPerg,{	"01-A", STR0003,;	//"  A. GERAL"
				STR0004,; 		//"O Projeto exige :"
				STR0005 }) 		//" Novos Materiais ?"

aAdd( aPerg,{	"01-B", STR0006,; //" Ferramentas especiais ?"
				Space(50), Space(50) }) 
				
aAdd( aPerg,{	"01-C", STR0090,; //"Novas Tecnologias ou Processos ? "
				Space(50), Space(50) })

aAdd( aPerg,{	"02", STR0007,; //" Foi Considerada a analise de variacao de montagem ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"03", STR0008,; //" Foi considerado Delineamento de Experimentos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"04", STR0009,; //" Existe algum plano para prototipos em andamento ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"05", STR0124,; //" A DFMEA foi concluída ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"06", STR0125,; //"A DFMA (Projeto para Manufaturabilidade e Montagem)"
				 STR0126,;      //"foi concluida ?"
				 Space(50) })

aAdd( aPerg,{	"07", STR0012,; 	//" Foram consideradas questoes relativas a assistencia"
				STR0013,; 			//" tecnica e manutencao ?"
				Space(50) })

aAdd( aPerg,{	"08", STR0014,; //" O Plano de Verificacao de Projeto foi completado ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"09", STR0015,; 	//" Em caso positivo, foi completado por uma equipe"
				STR0016,; 			//"multifuncional ?"
				Space(50) })

aAdd( aPerg,{	"10", STR0017,; 	//" Foram claramente definidos e compreendidos todos os"
				STR0018,; 			//" testes, metodos, equipamentos e criterios de aceitacao ?"
				Space(50) })

aAdd( aPerg,{	"11", STR0019,; //" Foram Selecionadas as Caracteristicas Especiais ?"
				Space(50), Space(50) })

aAdd( aPerg,{ "12", STR0020,; //" A lista de materiais/pecas esta completa ?"
				Space(50), Space(50) })

aAdd( aPerg,{ 	"13", STR0021,; 	//" As Caracteristicas Especiais estao apropriadamente"
				STR0022,; 			//" documentadas ?"
				Space(50) })

aAdd( aPerg,{ 	"14", STR0023,; 	//"  B. DESENHOS DE ENGENHARIA"
				STR0026,; 			//" Foram identificadas as dimensoes de referencia para"
				STR0027 }) 			//" minimizar o tempo de layout de inspecao ?"

aAdd( aPerg,{	"15", STR0127,; 		//"Existem pontos de controle e superficies de "
				STR0128,; 			    //"referência suficientes identificados para projetar"
				STR0129 })              //"dispositivos de medição funcionais ?"
				
				
aAdd( aPerg,{	"16", STR0031,; 	 //" As Tolerancias sao compativeis com normas de"
				STR0032,; 			     //" manufatura aceitaveis ?"
				Space(50) })        	    

aAdd( aPerg,{ 	"17", STR0091,; 	 //"As Técnicas de inspeção conhecidas podem"
				STR0092,; 			     //"medir todos os requisitos do projeto?"
				Space(50) })

aAdd( aPerg,{	"18", STR0093,; 	//"O processo de gerenciamento de alterações de" 
				STR0094,; 		     	//"engenharia designado pelo cliente é usado para"
				STR0095 }) 		    	//"gerenciar as alterações de engenharia?"
				

aAdd( aPerg,{	"19", STR0036,; 	//"  C. ESPECIFICACOES DE DESEMPENHO DE ENGENHARIA"
				STR0130,; 			//"As caracteristicas especiais foram identificadas ?"
				Space(50) }) 		

aAdd( aPerg,{	"20", STR0096,; 	 //"os Parametros de Teste sao suficientes para oferecer"
				STR0097,; 			     //"todas as condições de uso, ou seja, validacão de"
				STR0098 }) 			     //"producão e uso final ?"

aAdd( aPerg,{	"21", STR0042,; 	     //" Pecas fabricadas nas especificacoes minimas e"
				STR0131,; 		             //" maximas foram testadas, conforme necessário?"
				Space(50) })
				
aAdd( aPerg,{	"22", STR0132,;        //" Todos os Ensaios de produto serao feitos internamente ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"23", STR0048,;      	//" Em caso contrario, eles serao o efetuados por um "
				STR0133,; 		        	//" subfornecedor aprovado ?"
				Space(50) })


aAdd( aPerg,{ 	"24", STR0099,; 	    //"A frequência e/ou tamanho de amostragem para "
				STR0100,; 			        //"os testes especificados de desempenho sao"
				STR0101 }) 		            //"consistentes com os volumes de manufatura?"

aAdd( aPerg,{	"25", STR0122,; 	//"Foi obtida a aprovação do Cliente, por exemplo, para"
				STR0089,; 			//""os testes e documentação, conforme necessário?"
				Space(50) })

aAdd( aPerg,{	"26", STR0054,; 	        //"  D. ESPECIFICACAO DE MATERIAIS"
				STR0055,; 			//" As caracteristicas especiais de material estao"
				STR0038 })			       //" identificadas ?"

aAdd( aPerg,{	"27", STR0134,; 	     //"Quando a Organização for responsavel pelo projeto, os materiais"
				STR0135,; 			     //"tratamento térmico e tratamento de superfície especificados são"
				STR0136 }) 			     //"compatíveis com os requisitos de durabilidade no ambiente identificado?"


aAdd( aPerg,{	"28", STR0137,; 	   //"Onde necessário, os fornecedores de material estão "
				STR0138,; 			   //"na lista aprovada do cliente?"
				Space(50) })


aAdd( aPerg,{	"29", STR0102,; 	        //"A organização desenvolveu e implementou um"
				STR0103,; 			            //"processo para controlar a qualidade dos materiais"
				STR0104 })                      //"recebidos ?"



aAdd( aPerg,{	"30", STR0063,; 	//" Forma identificadas caracteristicas de material"
				STR0064,; 			//" que necessitam de inspecao ?"
				STR0065 }) 			//" Em caso positivo, "

aAdd( aPerg,{	"30-A", STR0066,; 	//"* As caracteristicas serao verificadas internamente ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"30-B", STR0139,; 	//"Se forem verificadas internamente, o equipamento de"
				STR0111,;           //"teste está disponivel ?"
				Space(50) })
				
aAdd( aPerg,{	"30-C", STR0105,; 	      //" Se forem verificadas internamente , existem"
				STR0106,; 			          //"pessoas capacitadas para assegurar testes"
				STR0107 }) 			          //"precisos ?"


aAdd( aPerg,{	"31", STR0070,; 	//" Serao utilizados laboratorios externos ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"31-A", STR0108,; 	//"A organização possui um processo implantado"
				STR0109,; 			    //"para assegurar a competência do laboratório, tal"
				STR0110})               //"como creditação? (Deve ser certificada)"
			
                                          

aAdd( aPerg,{	"32-A", STR0073,; 	//"Foram considerados os seguintes requisitos materiais ?" 
				 STR0112,;              //"Manuseio, incluindo aspectos ambientais ?"
				 Space(50) })

aAdd( aPerg,{	"32-B", STR0113,; 	//"Estocagem, incluindo aspectos ambientais ?"
				Space(50), Space(50) })

aAdd( aPerg,{	"32-C", STR0114,; 	//"A Composição dos materiasi / Substancias foram"
				STR0115,;               //"reportadas de acordo com os requisitos do cliente,"
				STR0116 })              //"por exemplo, IMDS? "   
				
aAdd( aPerg,{	"32-D", STR0117,; 	//"As peças Polimetricas foram identificadas / Marcadas"
				 STR0118,;              //"de acordo com os requisitos do cliente ?"
				 Space(50) })

Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho da Segunda Edição.
lin := 280

DbSelectArea("QKR")
DbSetOrder(1)
DbSeek(xFilial()+cPecaRev)

nPos	:= 0
Do While !Eof() .and. QKR->QKR_PECA+QKR->QKR_REV == cPecaRev

	cTexto 	:= ""
	
	nPos := Val(QKR->QKR_NPERG)
	
	If lin > 2200 .or. (QKR->QKR_NPERG $ "10_19_28_37" .and. lin <> 280)
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif
	
	lin += 40

	//nPos := aScan(aPerg, {|x| x[1] == QKR->QKR_NPERG })

	cTexto := AllTrim(Subs(QO_Rectxt(QKR->QKR_CHAVE,cEspecie+QKR->QKR_NPERG,1, nTamLin,"QKO"),1,152))

	cTexto := StrTran(cTexto,Chr(13)+Chr(10))
	
//	oPrint:Say(lin,0050,Str(Val(QKR->QKR_NPERG),2),oFontCou08)

	oPrint:Say(lin		,0050,aPerg[nPos,1],oFontCou08)
	oPrint:Say(lin		,0150,aPerg[nPos,2],oFontCou08)
	oPrint:Say(lin+40	,0150,aPerg[nPos,3],oFontCou08)
	oPrint:Say(lin+80	,0150,aPerg[nPos,4],oFontCou08)
    
//Consistência para verificar onde Marca o "X" no relatorio//
	If QKR->QKR_RPOSTA == "1"
		oPrint:Say(lin,1120,"X",oFont08)             //Se o valor de QKQ_RPOSTA for igua a 1, Cria na coluna 1120
		Elseif QKR->QKR_RPOSTA == "2" 
			oPrint:Say(lin,1220,"X",oFont08)        //Se o valor de QKQ_RPOSTA for igua a 2, Cria na coluna 1120
		Else
			oPrint:Say(lin,1338,"X",oFont08)        //Se o valor de QKQ_RPOSTA for igua a 3, Cria na coluna 1120
	Endif 

	
	oPrint:Say(lin		,1400,Subs(cTexto,001,38),oFontCou08)
	oPrint:Say(lin+40	,1400,Subs(cTexto,039,38),oFontCou08)
	oPrint:Say(lin+80	,1400,Subs(cTexto,077,38),oFontCou08)
	oPrint:Say(lin+120	,1400,Subs(cTexto,115,38),oFontCou08)
	
	oPrint:Say(lin,2100,Posicione("QAA",1,QKR->QKR_FILRES+QKR->QKR_RESP,"QAA_NOME"),oFontCou08)
	oPrint:Say(lin,2800,DtoC(QKR->QKR_DTPREV),oFontCou08)

	lin += 160
	oPrint:Line( lin, 30, lin, 3000 )   	// horizontal

	If lin > 2220
		i++
		oPrint:EndPage() 		// Finaliza a pagina
		Cabec2ED(oPrint,i)  	// Funcao que monta o cabecalho
		lin := 280
	Endif

	cPrepor := QKR->QKR_PREPOR

	DbSelectArea("QKR")
	DbSkip()

Enddo

oPrint:Say(2360,2100,STR0077,oFont08) //"Preparado Por"
oPrint:Say(2360,2500,cPrepor,oFont08)

Return Nil


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ Cabec2ED³ Autor ³ Robson Ramiro A. Olive³ Data ³ 25.09.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Checklist APQP A2                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Cabec2ED(ExpO1,ExpN1)--> Segunda Edição do APQP            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±³          ³ ExpN1 = Contador de paginas                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QPPR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function Cabec2ED(oPrint,i)

Local cFileLogo  	:= "LGRL"+SM0->M0_CODIGO+FWCodFil()+".BMP" // Empresa+Filial
Local nTotPag		:= 5

If !File(cFileLogo)
	cFileLogo := "LGRL" + SM0->M0_CODIGO+".BMP" // Empresa
Endif

oPrint:StartPage() 		// Inicia uma nova pagina

oPrint:SayBitmap(05,0005, cFileLogo,328,82)             // Tem que estar abaixo do RootPath
oPrint:SayBitmap(05,2800, "Logo.bmp",237,58) 

oPrint:Say(050,1000,STR0078,oFont16) //" A-2 LISTA DE VERIFICACAO DE INFORMACAO DO PROJETO"

oPrint:Say(160,040,STR0079,oFont08) //"Numero da Peca Interno ou do Cliente"
oPrint:Say(160,600,QK1->QK1_PECA,oFontCou08)

// Box 
oPrint:Box( 200, 30, 2220, 3000 )
               
oPrint:Say(220,0550,STR0080,oFont08) //"Pergunta"
oPrint:Say(220,1100,STR0081,oFont08) //"Sim"
oPrint:Say(220,1200,STR0082,oFont08) //"Nao"
oPrint:Say(220,1320,STR0121,oFont08) //"N/a"
oPrint:Say(220,1550,STR0083,oFont08) //"Cometarios / Acao Requerida"
oPrint:Say(220,2300,STR0084,oFont08) //"Pessoa Responsavel"
oPrint:Say(220,2800,STR0085,oFont08) //"Data Prevista"

oPrint:Line( 280, 30, 280, 3000 )   	// horizontal

oPrint:Line( 200, 0140, 2220, 0140 )	// vertical
oPrint:Line( 200, 1080, 2220, 1080 )	// vertical
oPrint:Line( 200, 1180, 2220, 1180 )	// vertical
oPrint:Line( 200, 1285, 2220, 1285 )	// vertical   //(nova linha para a divisao do n/a )//
oPrint:Line( 200, 1390, 2220, 1390 )	// vertical
oPrint:Line( 200, 2090, 2220, 2090 )	// vertical
oPrint:Line( 200, 2790, 2220, 2790 )	// vertical

oPrint:Say(2240,2100,STR0086,oFont08) //"Data de Revisao"
oPrint:Say(2240,2500,DtoC(QKR->QKR_DTREVI),oFont08)
oPrint:Say(2280,2500,STR0087+Str(i,2)+STR0088+Str(nTotPag,2),oFont08) //"Pagina "###" de "

Return Nil