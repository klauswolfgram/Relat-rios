/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR080.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ LojR080	³ Autor ³ Raul Capeleti 		³ Data ³ 29.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emitir Etiquetas para Mala Direta de Cliente e Forneced.   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_LojR080(  ) 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nao tem													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LojR080()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString:="SA1"
Local wnRel  := "LOJR080" //Nome Default do relatorio em Disco
Local oDlgEtiq
Local aArqs:={}
Local nList:= 1
Local oList

Private Cbtxt,cColor
// Zebrado / Administracao
Private aReturn := { STR0001, 1, STR0002, 1, 2, 1, "",1 }
Private nomeprog:="LOJR080"
Private nLastKey := 0
Private cPerg	 :="LJR080"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cbtxt 	:= ""
cbcont	:= 0
li 		:= 0
m_pag 	:= 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("LJR080",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros  ³
//³ mv_par01	  // Do Codigo 			 ?³
//³ mv_par02	  // Ate' o Codigo       ?³
//³ mv_par03	  // Quantas Copias		 ?³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Etiquetas para Mala Direta
DEFINE MSDIALOG oDlgEtiq FROM 39,85 TO 165,300 TITLE ;
	OemToAnsi(STR0003) PIXEL OF oMainWnd
Aadd(aArqs,STR0004)  // Fornecedor
Aadd(aArqs,STR0005)  // Cliente
Aadd(aArqs,STR0006)  // Produto
@  3, 10 TO 45, 95 LABEL STR0007 OF oDlgEtiq PIXEL  // Arquivos
@ 13, 15 LISTBOX oList VAR nList ITEMS aArqs SIZE 75,30 OF oDlgEtiq PIXEL
	
DEFINE SBUTTON FROM 48,34 TYPE 1 ENABLE OF oDlgEtiq;
	ACTION (nArq := nList , U_LjR080Imp(wnRel,cString,nArq))
DEFINE SBUTTON FROM 48,67 TYPE 2 ENABLE OF oDlgEtiq;
	ACTION ( oDlgEtiq:End() )
ACTIVATE MSDIALOG oDlgEtiq CENTERED
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ LjR080IMP³ Autor ³ Aline C. Vale 		³ Data ³ 08.10.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Etiquetas (Fornec./Cliente/Produto)			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Sigaloja 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LjR080Imp(wnRel,cString,nArq)
Local titulo :=""
Local cDesc1 :=""
Local cDesc2 :=""
Local cDesc3 :=""
Local tamanho:="G"

If nArq == 1
	cString := "SA2"
	titulo  := STR0008   // Etiquetas de Fornecedores
	cDesc1  := STR0009   // Imprime Etiquetas de Fornecedores para Mala Direta.
	cPerg   := "LJR082"
	Pergunte("LJR082",.F.)
ElseIf nArq == 2
	cString := "SA1"
	titulo  := STR0010   // Etiquetas de Clientes
	cDesc1  := STR0011   // Imprime Etiquetas de Clientes para Mala Direta.
	cPerg   := "LJR081"
	Pergunte("LJR081",.F.)
Elseif nArq == 3
	cString := "SB1"
	titulo  := STR0012   // Etiquetas de Produtos
	cDesc1  := STR0013   // Imprime Etiquetas de Produtos para Mala Direta.
	cPerg   := "LJR080"
	Pergunte("LJR080",.F.)
Else
	Return Nil
Endif
           
nLastKey := 0 // foi preciso forçar zero no nLastKey porque estava ficando com 27 de execuções anteriores
              // uma vez que a declaração da variável zerada está fora do loop

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Por Codigo / Por Nome
aOrd	:= {STR0014,STR0015}
wnRel := SetPrint(cString,wnRel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastkey = 27
	Return Nil
EndIf

If aReturn[5] != 1
	// Testa o Inicio do Formulario para a Impress„o?
	If !MsgYesNo(STR0016,STR0017)
		SetDefault(aReturn,cString)
		If nLastkey = 27
			Return
		Endif
		TesteImp()
	EndIf
EndIf
SetDefault(aReturn,cString)
If nLastkey = 27
	Return
EndIf

RptStatus({|lEnd| U_LJR080Imp2(@lEnd,wnRel,cString)},Titulo)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³LjR080IMP2³ Autor ³ Aline C. Vale 	    ³ Data ³ 09.10.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao de Etiquetas (Fornec./Cliente/Produto)			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Sigaloja 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Cleber M.     ³18/10/05³87366 ³ Tratamento para filtros de usuario     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LjR080Imp2(lEnd,wnRel,cString)
Local lContinua := .T.		// Indica se continua a impressao do relatorio
Local nQtdEtiq  			// Controle de impressao de etiquetas de produtos
Local nEtiqueta := mv_par03	// Qtde de copias
Local cChave	// chave de pesquisa no arquivo
Local cCond		// Condicao de pesquisa
Local nCnt		// Contador de registros
Local nAnt		// Total anterior
Local nMult		// Multiplicador 
Local nTregs	// Total de registros no arq.
Local nAtu		// Total atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa a linha para impressao                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Arquivo de Fornec/Clientes/Prod conforme o  parametro	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea(cString)
nOrdem := aReturn[8]
If nOrdem == 1
	dbSetOrder( 1 )
	dbSeek( cFilial + mv_par01 , .T. )
Else
	dbSeek( cFilial )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona o indice conforme a ordem selecionada  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cString == "SA1" .OR. cString == "SA2"
	dbSetOrder(nOrdem)
	If cString == "SA1"
		cCond := "xFilial()== A1_FILIAL"
	Else
		cCond := "xFilial() == A2_FILIAL"
	EndIf
Else
	If nOrdem == 1
		dbSetOrder(nOrdem)
	Else
		dbSetOrder(3)
	Endif
	cCond := "xFilial() == B1_FILIAL"
EndIf

nTregs:=Reccount()
nMult :=1
IF nTregs>0
	nMult:=70/nTregs
EndIF
nAnt:=4
nAtu:=4
nCnt:=0
SetRegua(Reccount())
While !Eof( ) .and. lContinua .and. &cCond
	nKey := Inkey( )
	IncRegua()
	nCnt++
	nAtu:=3+INT(nCnt*nMult)
	If nAtu != nAnt
		nAnt:=nAtu
	EndIF
	cCod := SubStr(Alias(),2,2) + "_COD"
	If nOrdem == 2
		If &cCod < Trim ( mv_par01 )
			dbSkip( )
			Loop
		End
	End

	If &cCod > mv_par02
		dbSkip( )
		Loop
	End		 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (!Empty(aReturn[7])) .AND. (!&(aReturn[7]))
		dbSkip()
		Loop
	Endif
	
	If cString == "SA1"
		For nQtdEtiq := 1 to nEtiqueta  //imprime a qtde de etiqueta especificada
			@ li,00 PSay A1_COD
			li++
			@ li,00 PSay A1_NOME
			li++
			@ li,00 PSay A1_END
			li++
			@ li,00 PSay A1_BAIRRO+" "+A1_MUN+" "+A1_EST
			li++
			@ li,00 PSay STR0019 + Subst(A1_CEP,1,5)+"-"+Substr(A1_CEP,6,3)  // CEP -
			li+=4
		Next
	ElseIf cString == "SA2"
 		For nQtdEtiq := 1 to nEtiqueta  //imprime a qtde de etiqueta especificada
			@ li,00 PSay A2_COD
			li++
			@ li,00 PSay A2_NOME
			li++
			@ li,00 PSay A2_END
			li++
			@ li,00 PSay A2_BAIRRO+" "+A2_MUN+" "+A2_EST
			li++
			@ li,00 PSay STR0019 + Subst(A2_CEP,1,5)+"-"+Substr(A2_CEP,6,3)  // CEP -
			li+=4
		Next
	ElseIf cString == "SB1"
		cChave := cFilial + B1_COD
		dbSelectArea( "SB2" )            //caso qtde. branco imprime qtde. atual
		If mv_par03 = 0
			If dbSeek( cChave )
				nEtiqueta := B2_QATU
			EndIf
		EndIf
		If nEtiqueta <= 0 			// se estiver com estoque negativo
			nEtiqueta := 1 			// imprime somente uma etiqueta do produto
		EndIf
		dbSelectarea(cString)
		For nQtdEtiq := 1 to nEtiqueta  //imprime a qtde de etiqueta especificada
			@ li,00 PSay STR0020 + B1_COD   // Codigo....
			li++
			@ li,00 PSay STR0021 + B1_DESC  // Descricao.
			li++
			@ li,00 PSay STR0022 + B1_TIPO  // Tipo......
			li++
			@ li,00 PSay STR0023 + B1_GRUPO // Grupo.....
			li++
			@ li,00 PSay STR0024 + B1_UM    // Unidade...
			li++
			// Peso......
			@ li,00 PSay STR0025 + Alltrim(Transform(B1_PESO,"@E 999,999.9999"))
			li+=4
		Next
	End
	dbSkip()
EndDo

Set Device to Screen
dbSetOrder(1)
Set Filter To

If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnRel)
Endif

@ 0,0 PSay " "  //liberando o buffer de impressao
MS_FLUSH()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³TesteImp	³ Autor ³ Raul C. Capeleti 	  ³ Data ³ 30.12.94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime uma Etiqueta de exemplo para se medir a altura do   ³±±
±±³			 ³formulario																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³TesteImp()																  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nao Tem																	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ LojR080																	  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TesteImp( )

@ li,00 PSay Replicate("X",40)
li++
@ li,00 PSay Replicate("X",40)
li++
@ li,00 PSay Replicate("X",40)
li++
@ li,00 PSay Replicate("X",40)
li++
@ li,00 PSay Replicate("X",40)
li++
@ li,00 PSay Replicate("X",40)    
li+=4
Set Devi To Screen
Return
