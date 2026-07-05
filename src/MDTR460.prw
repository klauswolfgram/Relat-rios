/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR460.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR460  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio Ficha de encaminhamento para realizar Exames.     ³±±
±±³          ³Este programa emite relatorio no formato de ficha individual³±±
±±³          ³para encaminhamento do funcionario ao fornecedor de exames. ³±±
±±³          ³Com base nas informacoes da tabela de Exames do Funconario  ³±±
±±³          ³(TM5) e na tabela de fornecedores de Exames (TMD). O usuario³±±
±±³          ³seleciona o fornecedor desejado podera  tambem selecionar   ³±±
±±³          ³um exame especifico ou deixar que o programa liste todos os ³±±
±±³          ³exames relacionados ao fornecedor previamente selecionado.  ³±±
±±³          ³Devera definir um periodo de abrangencia. Ex 01/01/00 a     ³±±
±±³          ³31/03/00 quer dizer que ele deseja listar ordens de encami- ³±±
±±³          ³nhamento para todos os funcionarios com exames proramados   ³±±
±±³          ³neste periodo, cujo fornecedor seja igual ao selecionado.   ³±±
±±³          ³Na ficha de encaminhamento encontram-se treis agrupamentos  ³±±
±±³          ³de informacao 1.) dados da empresa e do Funcionario, obter  ³±±
±±³          ³estas informacoes nas tabelas (TM5 e TM0). 2.) Dados do For-³±±
±±³          ³necedor obter na tabela (SA2). 3.) Dados dos Exames progra- ³±±
±±³          ³mados, obter nas Tabelas (TM5 e TM4).                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ MDTR460void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR460()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK)                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR460"
LOCAL limite  := 120
LOCAL cDesc1  := STR0001 //"Relatorio de Encaminhamento de Funcionarios para a realizacao de  exames no     "
LOCAL cDesc2  := STR0002 //"Fornecedor definido. Nesta ficha de encaminhamento constam dados do  funcionario"
LOCAL cDesc3  := STR0003 //"dados do fornecedor e dos exames que devem ser realizados. Atraves selecionar"
LOCAL cString := "TM5"
LOCAL lAltera := .F.
Local nX	  := 0
LOcal lDelSX1 := .F.
Local nLenFil := Len(TM5->TM5_FILIAL)
Local nLenExa	:= Len(TM5->TM5_EXAME)
Local nLenFor := Len(TM5->TM5_FORNEC)
Local nLenLoj := Len(TM5->TM5_LOJA)
Local aPerg := {}

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S"  , .T. , .F. )
lPrepExame := .T.

PRIVATE nomeprog  := "MDTR460"
PRIVATE tamanho   := "M"
PRIVATE aReturn   := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo    := STR0006   //"Encaminhamento para Realizacao dos Exames"
PRIVATE ntipo     := 0
PRIVATE nLastKey  := 0
PRIVATE cPerg     :="MDT460    "
PRIVATE cabec1, cabec2
PRIVATE aNFichas  := {}
Private nNatureza := 0
Private cNatureza := ""
Private aFilRelat := {}
Private aSm0	  := {}
Private oBmp
Private nAltura   := 0
Private nLargura  := 0

//Verifica o tamanho da imagem
oBmp := TBitmap():New(0,0,0,0,,,.F.,GetWndDefault(),,,,.F.,,,,,.T.)
oBmp:Hide()
If oBmp:Load(,NGLocLogo())
	oBmp:nClrPane := CLR_WHITE
	oBmp:lAutoSize    := .T.
	oBmp:lTransparent := .T.
	oBmp:Refresh()
	nLargura := 500
	nAltura  := 100
EndIf
oBmp:Free()

cAliasCC := "SI3"
cDescCC  := "SI3->I3_DESC"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
cDescCC  := "I3_DESC"
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cDescCC  := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cDescCC  := "CTT_DESC01"
	cDescCC2 := "CTT->CTT_DESC01"
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/* Perguntas
+----------------------------+
| 01 Imprimir Modelo ?       |
| 02 Fornecedor ?            |
| 03 Loja ?                  |
| 04 De  Ficha  Medica ?     |
| 05 Ate Ficha  Medica ?     |
| 06 De  Data Programac. ?   |
| 07 Ate Data Programac. ?   |
| 08 Medico Responsavel ?    |
| 09 De Exame ?              |
| 10 Ate Exame ?             |
| 11 Filtrar por Natureza ?  |
| 12 Modelo ImpressÒo ?      |
| 13 Filtrar por Fornecedor ?|
| 14 De Filial ?             |
| 15 Ate Filial ?            |
| 16 Imprimir Preparacao ?   |
+----------------------------+
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Imprimir Individual/Coletivo         ³
//³ mv_par02             // Fornecedor                           ³
//³ mv_par02             // Loja                                 ³
//³ mv_par04             // De Ficha Medica                      ³
//³ mv_par05             // Ate Ficha Medica                     ³
//³ mv_par06             // De Data Programacao                  ³
//³ mv_par07             // Ate Data Programacao                 ³
//³ mv_par08             // Medico Responsavel                   ³
//³ mv_par09             // De Exame                             ³
//³ mv_par10             // Ate Exame                            ³
//³ mv_par11             // Tipo de Exame:                       ³
//³                           1 - Admissional                    ³
//³                           2 - Demissional                    ³
//³                           3 - Retorno ao trabalho            ³
//³                           4 - Mudancao de Funcao             ³
//³                           4 - Periodico                      ³
//³ mv_par12             // Modelo de impressao:                 ³
//³                           1 - Modelo 1                       ³
//³                           2 - Modelo 2                       ³
//³ mv_par13             // Filtrar por fornecedor               ³
//³ mv_par14             // De Filial                            ³
//³ mv_par15             // Ate Filial                           ³
//³ mv_par16             // Imprimir Preparação                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR460"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

	If mv_par16 == 2
		lPrepExame := .F.
	EndIf

If mv_par01 == 2
	If (mv_par09 != mv_par10) .or. Empty(mv_par09)
		MsgStop(STR0098)  //"Para visualizar o relatório coletivo, deve se escolher apenas um Exame"
		U_MDTR460()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		NGRETURNPRM(aNGBEGINPRM)
		Return .f.
	EndIf
EndIf

If mv_par11 == 1 .AND. nNatureza = 0
	If !U_MDTR460Nat()
		U_MDTR460()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		NGRETURNPRM(aNGBEGINPRM)
		Return .F.
	EndIf
EndIf

Do Case //Considerar exames..
	Case nNatureza == 1
		cNatureza := STR0103 //" Admissionais"
	Case nNatureza == 2
		cNatureza := STR0104 //" Demissionais"
	Case nNatureza == 3
		cNatureza := STR0105 //" de Retorno ao Trabalho"
	Case nNatureza == 4
		cNatureza := STR0106 //" de Mudança de Função"
	Case nNatureza == 5
		cNatureza := STR0107 //" PeriÓdicos"
EndCase
SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

If !Empty(xFilial("TM5"))

	aSm0 := FWLoadSM0()

	For nX:=1 to len(aSm0)
		If aSm0[nX][1] == cEmpAnt .And. aSm0[nX][2] <= mv_par15
			aAdd(aFilRelat,aSm0[nX][2])
		Endif
	Next

Else
	aAdd( aFilRelat , cFilAnt )
Endif

If mv_par12 == 1  //Modelo 1
	If mv_par01 == 1
		RptStatus({|lEnd| R460Ind(@lEnd,wnRel,titulo,tamanho)},titulo)
	Else
		RptStatus({|lEnd| R460Col(@lEnd,wnRel,titulo,tamanho)},titulo)
	EndIf
Else  //Modelo 2
	If mv_par01 == 1
		Processa({|lEND| RGRAFInd()},STR0081)  //"Processando Arquivo..."
	Else
		Processa({|lEND| RGRAFCol()},STR0081)  //"Processando Arquivo..."
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R460Ind  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR460                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R460Ind(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL lContinua := .T.
LOCAL cFicSalvo := ""
LOCAL lPulouTM5 := .F.
LOCAL aExames   := {},nXYZ
LOCAL lPrint    := .f.
Local cNatExa   := ""
Local LinhaCor
Local nLinhasMemo
Local nLinhaCorrente

cabec1 := " "
cabec2 := " "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

For nXYZ := 1 To Len(aFilRelat)
	dbSelectArea("TM5")
	dbSetOrder(01)
	dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par04,.t.)

	SetRegua(LastRec())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  CONVOCADOS                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While !Eof()                                   .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ]) .AND.;
	      TM5->TM5_NUMFIC >= mv_par04              .AND.;
	      TM5->TM5_NUMFIC <= mv_par05

		IncRegua()

		Do Case
			Case nNatureza == 1  //Considerar exames Admissionais
				If TM5->TM5_NATEXA <> "1"
					dbSkip()
					loop
				Endif
			Case nNatureza == 2  //Considerar exames Demissionais
				If TM5->TM5_NATEXA <> "5"
					dbSkip()
					loop
				Endif
			Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
				If TM5->TM5_NATEXA <> "4"
					dbSkip()
					loop
				Endif
			Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
				If TM5->TM5_NATEXA <> "3"
					dbSkip()
					loop
				Endif
			Case nNatureza == 5  //Considerar exames Periodicos
				If TM5->TM5_NATEXA <> "2"
					dbSkip()
					loop
				Endif
			Case nNatureza == 6  //Considerar exames de Monitoração Pontual
				If TM5->TM5_NATEXA <> "6"
					dbSkip()
					loop
				Endif
		EndCase

		lPulouTM5 := .F.

		IF mv_par13 == 2
			If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
				dbSelectArea("TM5")
				dbSkip()
				Loop
			Endif
		Endif
		If !EMPTY(TM5->TM5_DTRESU)
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		If TM5->TM5_EXAME < mv_par09 .OR. TM5->TM5_EXAME > mv_par10
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		cFilTM5 := aFilRelat[nXYZ]
		If !Empty(TM5->TM5_FILFUN)
			cFilTM5 := TM5->TM5_FILFUN
			If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
				dbSelectArea("TM5")
				dbskip()
				Loop
			Endif
		Endif

		Dbselectarea("TM0")
		Dbsetorder(1)
		If !Dbseek(xFilial("TM0",cFilTM5)+TM5->TM5_NUMFIC)
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		lCandidato := .f.
		dbSelectArea("SRA")
		dbSetOrder(01)
		If !dbSeek(xFilial("SRA",cFilTM5)+TM0->TM0_MAT)
			lCandidato := .t.
		Endif

		Li := 80

		SomaLinha()

		@ Li,000 PSay Replicate("-",120)
		SomaLinha()

		@ Li,000 PSay "|"
		@ Li,024 PSay STR0008 + Upper(cNatureza) + " - " + If(cNatureza == "",Substr(SA1->A1_NOME,1,29), Substr(SA1->A1_NOME,1,19))
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,001 PSay Replicate("-",118)
		@ Li,119 PSay "|"

		SomaLinha()
		If lCandidato
			@ Li,000 PSay STR0115 //"|Filial...............:"
			@ Li,024 PSay TM0->TM0_FILIAL
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0025 //"|Candidato............:"

			nLinhasMemo := MLCOUNT( AllTrim( TM0->TM0_NOMFIC ), 40 )
			For nLinhaCorrente := 1 to nLinhasMemo
				If nLinhaCorrente == 1
					@ Li,024 PSay Alltrim( TM0->TM0_CANDID ) + " - " + Memoline( AllTrim( TM0->TM0_NOMFIC ), 40, nLinhaCorrente, NIL, .T. )
					@ Li,119 PSay "|"
				Else
					SomaLinha()
					@ Li,000 PSay "|"
					@ Li,024 PSay Memoline( AllTrim( TM0->TM0_NOMFIC ), 40, nLinhaCorrente, NIL, .T. )
					@ Li,119 PSay "|"
				EndIf
			Next nLinhaCorrente

			@ Li,086 PSay STR0011 //"Ficha.:"
			@ Li,094 PSay TM5->TM5_NUMFIC PICTURE "@!"

			SomaLinha()
			@ Li,000 PSay STR0012 //"|Centro de Custo......:"
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			If dbSeek(xFilial(cAliasCC,cFilTM5)+TM0->TM0_CC)
				@ Li,024 PSay Substr(Alltrim(TM0->TM0_CC)+" - "+&(cDescCC2),1,55)
			Endif
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0013 //"|Funcao...............:"
			dbSelectArea("SRJ")
			dbSetOrder(01)
			If dbSeek(xFilial("SRJ",cFilTM5)+TM0->TM0_CODFUN)
				@ Li,024 PSAY AllTrim(TM0->TM0_CODFUN)+" - "+Substr(AllTrim(SRJ->RJ_DESC),1,25) Picture "@!"
			Endif
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0014 //"|Nascimento...........:"
			@ Li,024 PSay TM0->TM0_DTNASC PICTURE '99/99/99'
			@ Li,086 PSay STR0016 //"Idade.:"
			@ Li,094 PSay R555ID(TM0->TM0_DTNASC) PICTURE '999'
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0028 //"|Registro Geral.......:"
			@ Li,024 PSay TM0->TM0_RG
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0029 //"|CPF..................:"
			@ Li,024 PSay TM0->TM0_CPF
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0030 //"|Carteira Profissional:"
			@ Li,024 PSay TM0->TM0_NUMCP
			@ Li,119 PSay "|"

		Else

			@ Li,000 PSay STR0115 //"|Filial...............:"
			@ Li,024 PSay TM0->TM0_FILFUN
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0010 //"|Funcionario..........:"
			@ Li,024 PSAY AllTrim(TM5->TM5_MAT)+" - "+Substr(SRA->RA_NOME,1,35) Picture "@!"
			@ Li,086 PSay STR0011 //"Ficha.:"
			@ Li,094 PSay TM5->TM5_NUMFIC PICTURE "@!"
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0012 //"|Centro de Custo......:"
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			If dbSeek(xFilial(cAliasCC,cFilTM5)+TM5->TM5_CC)
				@ Li,024 PSay Substr(Alltrim(TM5->TM5_CC)+" - "+&(cDescCC2),1,55)
			EndIf
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0013 //"|Funcao...............:"
			dbSelectArea("SRJ")
			dbSetOrder(01)
			If dbSeek(xFilial("SRJ",cFilTM5)+TM5->TM5_CODFUN)
				@ Li,024 PSAY AllTrim(TM5->TM5_CODFUN)+" - "+Substr(SRJ->RJ_DESC,1,20) Picture "@!"
			EndIf
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0014 //"|Nascimento...........:"
			@ Li,024 PSay SRA->RA_NASC PICTURE '99/99/99'
			@ Li,086 PSay STR0016 //"Idade.:"
			@ Li,094 PSay R555ID(SRA->RA_NASC)  PICTURE '999'
			@ Li,119 PSay "|"

			Somalinha()
			@ Li,000 PSay STR0015 //"|Admissao.............:"
			@ Li,024 PSay SRA->RA_ADMISSA PICTURE '99/99/99'
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0028 //"|Registro Geral.......:"
			@ Li,024 PSay SRA->RA_RG
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0029 //"|CPF..................:"
			@ Li,024 PSay SRA->RA_CIC
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0030 //"|Carteira Profissional:"
			@ Li,024 PSay SRA->RA_NUMCP
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0026 //"|Endereço.............:"
			@ Li,024 PSay SRA->RA_ENDEREC
			@ Li,119 PSay "|"

			SomaLinha()
			@ Li,000 PSay STR0027 //"|Bairro...............:"
			@ Li,024 PSay SRA->RA_BAIRRO
			@ Li,119 PSay "|"
		Endif

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,001 PSay Replicate("-",118)
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0017 //"|Fornecedor.:"
		dbSelectArea("SA2")
		dbSetOrder(01)
		If dbSeek(xFilial("SA2")+mv_par02+mv_par03)
			@ Li,014 PSay Substr(Alltrim(mv_par02)+" - "+SA2->A2_NOME,1,63)
		EndIf
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSAY STR0018 //"|Endereco...:"
		@ Li,014 PSAY Substr(SA2->A2_END,1,60)
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0019 //"|Bairro.....:"
		@ Li,014 PSAY Substr(SA2->A2_BAIRRO,1,26)
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSAY STR0020 //"|Cidade.....:"
		@ Li,014 PSAY Substr(SA2->A2_MUN,1,25)
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0021 //"|Telefone...:"
		@ Li,014 PSAY SA2->A2_TEL
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0116 //"|------------------------------------------------------Responsavel-----------------------------------------------------|"

		SomaLinha()
		@ Li,000 PSay STR0022 //"|Medico.....:"
		DbSelectArea("TMK")
		DbSetOrder(1)
		If DbSeek(xFilial("TMK")+mv_par08)
			@ Li,014 PSAY Substr(TMK->TMK_NOMUSU,1,60)
		EndIf
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0023 //"|CRM........:"
		DbSelectArea("TMK")
		DbSetOrder(1)
		If DbSeek(xFilial("TMK")+mv_par08)
			@ Li,014 PSay TMK->TMK_NUMENT PICTURE '@!'
		EndIf
		@ Li,119 PSay "|"

		SomaLinha()
		If nNatureza == 0
			@ Li,000 PSay STR0117 //"|  -----------------------Exames------------------------------------------------------Natureza-----------------------  |"
		Else
			@ Li,000 PSay STR0118 //"|  ------------------------------------------------------Exames------------------------------------------------------  |"
		EndIf

		SomaLinha()
		dbSelectArea("TM5")
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"
		@ Li,002 PSay STR0140//"Data do Exame....:"
		@ Li,022 PSay TM5->TM5_DTPROG
		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"
		@ Li,002 PSay STR0141//"Horário do Exame.:"
		@ Li,022 PSay TM5->TM5_HRPROG

		cFicsalvo := TM5->TM5_NUMFIC
		aExames   := {}
		lFirst    := .T.
		lLinha    := .T.

		dbSelectArea("TM5")
		While !Eof()                               .AND.;
			  TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ])    .AND.;
			  TM5->TM5_NUMFIC == cFicsalvo

			Do Case
			Case nNatureza == 1  //Considerar exames Admissionais
				If TM5->TM5_NATEXA <> "1"
					dbSkip()
					loop
				Endif
			Case nNatureza == 2  //Considerar exames Demissionais
				If TM5->TM5_NATEXA <> "5"
					dbSkip()
					loop
				Endif
			Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
				If TM5->TM5_NATEXA <> "4"
					dbSkip()
					loop
				Endif
			Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
				If TM5->TM5_NATEXA <> "3"
					dbSkip()
					loop
				Endif
			Case nNatureza == 5  //Considerar exames Periodicos
				If TM5->TM5_NATEXA <> "2"
					dbSkip()
					loop
				Endif
			Case nNatureza == 6  //Considerar exames de Monitoração Pontual
				If TM5->TM5_NATEXA <> "6"
					dbSkip()
					loop
				Endif
			EndCase
			IF mv_par13 == 2
				If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
					dbSelectArea("TM5")
					dbSkip()
					Loop
				Endif
			Endif
			If !EMPTY(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_EXAME < mv_par09 .OR. TM5->TM5_EXAME > mv_par10
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			lPrint := .t.

			If nNatureza == 0
				If TM5->TM5_NATEXA == "1"
					cNatExa := STR0108 //"Admissional"
				ElseIf TM5->TM5_NATEXA == "2"
					cNatExa := STR0109 //"Periódico"
				ElseIf TM5->TM5_NATEXA == "3"
					cNatExa := STR0110 //"Mudança Função"
				ElseIf TM5->TM5_NATEXA == "4"
					cNatExa := STR0111 //"Retorno Trabalho"
				ElseIf TM5->TM5_NATEXA == "5"
					cNatExa := STR0112  //"Demissional"
				Else
					cNatExa := "  "
				EndIf

				If ( aSCAN (aExames, {|x| x[1] == TM5->TM5_EXAME+cNatExa}) ) < 1
					aADD (aExames, {TM5->TM5_EXAME+cNatExa} )
					SomaLinha()
					If lFirst
						lFirst := .F.
					Else
						@ Li,000 PSay "|"
						@ Li,119 PSay "|"
						SomaLinha()
					EndIf
					dbSelectArea("TM4")
					dbSetOrder(01)
					If dbSeek(xFilial("TM4",cFilTM5)+TM5->TM5_EXAME)
						@ Li,000 PSay "|"
						@ Li,004 PSay SubStr(TM5->TM5_EXAME+" - "+AllTrim(TM4->TM4_NOMEXA),1,80) Picture "@!"
						@ Li,086 PSay cNatExa
						@ Li,119 PSay "|"
						If lPrepExame
							lLinha       := .T.
							cTextoNew    := MSMM(TM4->TM4_PREPAR)
							nLinhasMemo  := MLCOUNT(cTextoNew,100)
							For LinhaCor := 1 to nLinhasMemo
								SomaLinha(.T.)
								If lLinha
									@ Li,000 PSay "|"
									@ Li,004 PSay STR0135 //"PREPARAÇÃO:"
									@ Li,016 PSay MemoLine(cTextoNew,100,LinhaCor)
									@ Li,119 PSay "|"
									lLinha := .F.
								Else
									@ Li,000 PSay "|"
									@ Li,016 PSay MemoLine(cTextoNew,100,LinhaCor)
									@ Li,119 PSay "|"
								EndIf
							Next LinhaCor
						EndIf
					EndIf
				EndIf
			Else
				If ( aSCAN (aExames, {|x| x[1] == TM5->TM5_EXAME}) ) < 1
					aADD (aExames, {TM5->TM5_EXAME} )
					SomaLinha()
					If lFirst
						lFirst := .F.
					Else
						@ Li,000 PSay "|"
						@ Li,119 PSay "|"
						SomaLinha()
					EndIf
					dbSelectArea("TM4")
					dbSetOrder(01)
					If dbSeek(xFilial("TM4",cFilTM5)+TM5->TM5_EXAME)
						@ Li,000 PSay "|"
						@ Li,004 PSay SubStr(TM5->TM5_EXAME+" - "+AllTrim(TM4->TM4_NOMEXA),1,112) Picture "@!"
						@ Li,119 PSay "|"
						If lPrepExame
							lLinha       := .T.
							cTextoNew    := MSMM(TM4->TM4_PREPAR)
							nLinhasMemo  := MLCOUNT(cTextoNew,100)
							For LinhaCor := 1 to nLinhasMemo
								SomaLinha(.T.)
								If lLinha
									@ Li,000 PSay "|"
									@ Li,004 PSay STR0135 //"PREPARAÇÃO:"
									@ Li,016 PSay MemoLine(cTextoNew,100,LinhaCor)
									@ Li,119 PSay "|"
									lLinha := .F.
								Else
									@ Li,000 PSay "|"
									@ Li,016 PSay MemoLine(cTextoNew,100,LinhaCor)
									@ Li,119 PSay "|"
								EndIf
							Next LinhaCor
						EndIf
					EndIf
				EndIf
			EndIf

			dbSelectArea("TM5")
			dbskip()
			lPulouTM5 := .T.
		Enddo

		If (Li + 6) > 58
			Li++
			@ Li,000 PSay "|"
			@ Li,001 PSay Replicate("-",118)
			@ Li,119 PSay "|"
			Li := 58
		EndIf

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,001 PSay Replicate("-",118)
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0024 //"|   Realizacao : ____/____/____                                         Responsavel:  ______________________________   |"

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay STR0119 //"|                                                                       Assinatura:   ______________________________   |"

		SomaLinha()
		@ Li,000 PSay "|"
		@ Li,119 PSay "|"

		SomaLinha()
		@ Li,000 PSay Replicate("-",120)

		dbSelectArea("TM5")
		If !Eof() .AND. !lPulouTM5
			dbskip()
		EndIf
	Enddo
Next nXYZ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lPrint
	MsgInfo(STR0099)  //"Não há nada para imprimir no relatório."
	RetIndex("TM5")
	Set Filter To
	Return .F.
Endif

RetIndex("TM5")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return NIL


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R460Col  ³ Autor ³ Liber De Esteban      ³ Data ³   /12/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR460                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R460Col(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lImprime := .F.
Local nLinhaCorrente
Local nLinhasMemo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL lContinua := .T.,nXYZ
LOCAL lPrint := .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo := IIF(aReturn[4]==1,15,18)

cabec1 := " "
cabec2 := " "

For nXYZ := 1 To Len(aFilRelat)
	If lImprime
		Exit
	Endif
	dbSelectArea("TM5")
	dbSetOrder(02)
	If dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par09)
		While !Eof() .AND. TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ]) .AND. TM5->TM5_EXAME == mv_par09
			If !Empty(TM5->TM5_FILFUN)
				If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif
			IF mv_par13 == 2
				If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
					dbSelectArea("TM5")
					dbSkip()
					Loop
				Else
					lImprime := .T.
					Exit
				Endif
			Endif
			Do Case
				Case nNatureza == 1  //Considerar exames Admissionais
					If TM5->TM5_NATEXA == "1"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 2  //Considerar exames Demissionais
					If TM5->TM5_NATEXA == "5"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
					If TM5->TM5_NATEXA == "4"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
					If TM5->TM5_NATEXA == "3"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 5  //Considerar exames Periodicos
					If TM5->TM5_NATEXA == "2"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 6  //Considerar exames de Monitoração Pontual
					If TM5->TM5_NATEXA == "6"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 0
					lImprime := .T.
					Exit
			EndCase
			dbSkip()
		End
	Endif
Next nXYZ

If lImprime

	Li     := 80
	lPrint := .t.

	SomaLinha()

	@ Li,000 PSay Replicate("-",82)
	SomaLinha()

	@ Li,000 PSay "|"
	@ Li,001 PSay STR0008 + Upper(cNatureza) + " - " + If(cNatureza == "",Substr(SA1->A1_NOME,1,29), Substr(SA1->A1_NOME,1,19))
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay "|--------------------------------------------------------------------------------|"

	dbSelectArea("TM4")
	dbSetOrder(01)
	dbSeek(xFilial("TM4")+mv_par09)
	SomaLinha()
	@ Li,000 PSay STR0083 //"|Exame......:"
	@ Li,014 PSay Alltrim(mv_par09) + " - " + Substr(TM4->TM4_NOMEXA,1,53) PICTURE "@!"
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay STR0017 //"|Fornecedor.:"
	dbSelectArea("SA2")
	dbSetOrder(01)
	dbSeek(xFilial("SA2")+mv_par02+mv_par03)
	@ Li,014 PSay Substr(Alltrim(mv_par02)+" - "+SA2->A2_NOME,1,63)
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSAY STR0018 //"|Endereco...:"
	@ Li,014 PSAY SubSTR(SA2->A2_END,1,30)
	@ Li,047 PSay STR0120 //"Telefone.:"
	@ Li,058 PSAY Substr(SA2->A2_TEL,1,17)
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay STR0019 //"|Bairro.....:"
	@ Li,014 PSAY SubSTR(SA2->A2_BAIRRO,1,30)
	@ Li,047 PSAY STR0121 //"Cidade...:"
	@ Li,058 PSAY SubSTR(SA2->A2_MUN,1,20)
	@ Li,081 PSay "|"

	/*
	          1         2         3         4         5         6         7         8
	012345678901234567890123456789012345678901234567890123456789012345678901234567890
	|----------------------------------Funcionários----------------------------------|
	|Filial       Mat.    Nome                       Função                    Idade |
	|XXXXXX       123456  xxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxx  99
	|
	*/

	Somalinha()
	@ Li,000 PSay STR0122 //"|----------------------------------Funcionários----------------------------------|"
	Somalinha()
	@ Li,000 PSay STR0123 //"|Filial       Mat.    Nome                       Função                    Idade |"
	Somalinha()
	@ Li,000 PSay "|--------------------------------------------------------------------------------|"

	SetRegua(LastRec())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  CONVOCADOS                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	nCol := 01

	For nXYZ := 1 To Len(aFilRelat)
		dbSelectArea("TM5")
		dbSetOrder(02)
		dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par09)
		While !Eof()                                 .AND.;
			TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ])        .AND.;
			TM5->TM5_EXAME == mv_par09

			IncRegua()

			cFilTM5 := aFilRelat[nXYZ]
			If !Empty(TM5->TM5_FILFUN)
				cFilTM5 := TM5->TM5_FILFUN
				If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif

			IF mv_par13 == 2
				If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
					dbSelectArea("TM5")
					dbSkip()
					Loop
				Endif
			Endif
			If !EMPTY(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_NUMFIC < mv_par04 .OR. TM5->TM5_NUMFIC > mv_par05
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			Do Case
				Case nNatureza == 1  //Considerar exames Admissionais
					If TM5->TM5_NATEXA <> "1"
						dbSkip()
						loop
					Endif
				Case nNatureza == 2  //Considerar exames Demissionais
					If TM5->TM5_NATEXA <> "5"
						dbSkip()
						loop
					Endif
				Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
					If TM5->TM5_NATEXA <> "4"
						dbSkip()
						loop
					Endif
				Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
					If TM5->TM5_NATEXA <> "3"
						dbSkip()
						loop
					Endif
				Case nNatureza == 5  //Considerar exames Periodicos
					If TM5->TM5_NATEXA <> "2"
						dbSkip()
						loop
					Endif
				Case nNatureza == 6  //Considerar exames de Monitoração Pontual
					If TM5->TM5_NATEXA <> "6"
						dbSkip()
						loop
					Endif
			EndCase

			Dbselectarea("TM0")
			Dbsetorder(1)
			If !Dbseek(xFilial("TM0",cFilTM5)+TM5->TM5_NUMFIC)
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If (nPos := aScan(aNFichas,{|x| TM0->TM0_NUMFIC == x[1]})) > 0
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			lCandidato := .f.
			dbSelectArea("SRA")
			dbSetOrder(01)
			If !dbSeek(xFilial("SRA",cFilTM5)+TM0->TM0_MAT)
				lCandidato := .t.
			Endif

			If lCandidato

				Somalinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay TM0->TM0_FILIAL

				nLinhasMemo := MLCOUNT( AllTrim( TM0->TM0_NOMFIC ), 27 )
				For nLinhaCorrente := 1 to nLinhasMemo
					If nLinhaCorrente == 1
						@ Li,014 PSay Replicate( "-", Len( TM5->TM5_MAT ) )
						@ Li,021 PSay Memoline( AllTrim( TM0->TM0_NOMFIC ), 27, nLinhaCorrente, NIL, .T. )
						@ Li,081 PSay "|"
					Else
						SomaLinha()
						@ Li,000 PSay "|"
						@ Li,021 PSay Memoline( AllTrim( TM0->TM0_NOMFIC ), 27, nLinhaCorrente, NIL, .T. )
						@ Li,081 PSay "|"
					EndIf
				Next nLinhaCorrente

				dbSelectArea("SRJ")
				dbSetOrder(01)
				If dbSeek(xFilial("SRJ",cFilTM5)+TM0->TM0_CODFUN)
					@ Li,049 PSay Substr(SRJ->RJ_DESC,1,25)
				Endif
				@ Li,075 PSay R555ID(TM0->TM0_DTNASC)  PICTURE '9999'

				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0124 //"Centro de Custo.:"
				dbSelectArea(cAliasCC)
				dbSetOrder(01)
				If dbSeek(xFilial(cAliasCC,cFilTM5)+TM0->TM0_CC)
					@ Li,040 PSay Substr(&(cDescCC2),1,30)
				Endif
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0033 //"Registro Geral..:"
				@ Li,040 PSay TM0->TM0_RG
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0034 //"CPF.............:"
				@ Li,040 PSay TM0->TM0_CPF
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0035 //"Carteira Prof...:"
				@ Li,045 PSay TM0->TM0_NUMCP
				@ Li,081 PSay "|"

			Else
				Somalinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay TM0->TM0_FILFUN
				@ Li,014 PSay TM5->TM5_MAT
				@ Li,022 PSAY Substr(SRA->RA_NOME,1,25)
				dbSelectArea("SRJ")
				dbSetOrder(01)
				dbSeek(xFilial("SRJ",cFilTM5)+TM5->TM5_CODFUN)
				@ Li,049 PSay Substr(SRJ->RJ_DESC,1,25)
				@ Li,075 PSay R555ID(SRA->RA_NASC)  PICTURE '999'
				@ Li,081 PSay "|"

				dbSelectArea(cAliasCC)
				dbSetOrder(01)
				dbSeek(xFilial(cAliasCC,cFilTM5)+TM5->TM5_CC)
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0124 //"Centro de Custo.:"
				@ Li,040 PSay Substr(&(cDescCC2),1,30)
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0033 //"Registro Geral..:"
				@ Li,040 PSay SRA->RA_RG
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0034 //"CPF.............:"
				@ Li,040 PSay SRA->RA_CIC
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0035 //"Carteira Prof...:"
				@ Li,045 PSay SRA->RA_NUMCP
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0031 //"Endereço........:"
				@ Li,040 PSay SRA->RA_ENDEREC
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0032 //"Bairro..........:"
				@ Li,040 PSay SRA->RA_BAIRRO
				@ Li,081 PSay "|"
			Endif
				SomaLinha()
				dbSelectArea("TM5")
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0140//"Data do Exame....:"
				@ Li,041 PSay TM5->TM5_DTPROG
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,020 PSay STR0141//"Horário do Exame.:"
				@ Li,041 PSay TM5->TM5_HRPROG
				@ Li,081 PSay "|"
				SomaLinha()
				@ Li,000 PSay "|"
				@ Li,001 PSay Replicate("-",80)
				@ Li,081 PSay "|"

			AADD(aNFichas,{TM0->TM0_NUMFIC})
			dbSelectArea("TM5")
			dbskip()

		Enddo

	Next nXYZ

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,081 PSay "|"
	Somalinha()

	@ Li,000 PSay STR0125 //"|-------------------------------Medico Responsavel-------------------------------|"

	Somalinha()
	@ Li,000 PSay "|"
	@ Li,081 PSay "|"
	Somalinha()

	@ Li,000 PSay STR0085 //"|Assinatura.:"
	@ Li,014 PSay "_________________________"
	@ Li,050 PSay STR0086 //"Realizacao : ____/____/____"
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay STR0087 //"|Medico.....:"
	DbSelectArea("TMK")
	DbSetOrder(1)
	DbSeek(xFilial("TMK")+mv_par08)
	@ Li,014 PSAY Substr(TMK->TMK_NOMUSU,1,60)
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay STR0126 //"|CRM .......:"
	@ Li,014 PSay TMK->TMK_NUMENT PICTURE '@!'
	@ Li,081 PSay "|"

	SomaLinha()
	@ Li,000 PSay Replicate("-",81)

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lPrint
	MsgInfo(STR0099)  //"Não há nada para imprimir no relatório."
	RetIndex("TM5")
	Set Filter To
	Return .F.
Endif

RetIndex("TM5")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha(lImpHor)
Default lImpHor := .F.
Li++
If Li > 58
	If lImpHor
		@ Li,000 PSay Replicate("-",120)
	EndIf
	Cabec(STR0082,cabec1,cabec2,nomeprog,tamanho,nTipo,,,NGLocLogo())
	If lImpHor
		@ Li,000 PSay Replicate("-",120)
		Li++
	EndIf
EndIf

Return
/*
         1         2         3         4         5         6         7         8
012345678901234567890123456789012345678901234567890123456789012345678901234567890

ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³XXXXXXXXXXXXX          ORDEM DE ENCAMINHAMENTO PARA EXAMES PERIODIOCOS        ³
³SIGA/MDTR460   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  Emissao: 99/99/99 hh:mm³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Funcionario.....: xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Ficha.: xxxxxxxx ³
³Centro de Custo.: xxxxxxxxx - xxxxxxxxxxxxxxxxxxxx                            ³
³Funcao..........: xxxx  -  xxxxxxxxxxxxxxxxxxxx                               ³
³Nascimento......: xx/xx/xx                Admissao.: xx/xx/xx     Idade.: xx  ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄFornecedorÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Fornecedor.: xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxx                           ³
³Endereco...: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                           ³
³Bairro.....: xxxxxxxxxxxxxxxxxxxx         Cidade.: xxxxxxxxxxxxxxxxxxxx       ³
³Telefone...: xxxxxxxxxxxx                                                     ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄResponsavelÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Medico...:  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                          ³
³CRM......:  xxxxxxxxxxxx                                                      ³
³   ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄExamesÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ   ³
³   xxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                           ³
³   xxxxx  - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                           ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³  Realizacao : ____/____/____           Responsavel:  ____________________    ³
³                                                                              ³
³                                        Assinatura: _______________________   ³
³                                                                              ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR460   ºAutor: ³Andre Perez Alvarez º Data ³  11/07/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Imprime modelo grafico (individual)                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR460                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RGRAFInd()

LOCAL cFicSalvo := "", cNatExa := ""
LOCAL lPulouTM5 := .F.
LOCAL aExames   := {}
LOCAL nAdd,nLCorrente,xx,yy,nXYZ
LOCAL lFirst,lLinha,lExCabe
LOCAL nAux
Local nLinhasMemo
Local nLinhaCorrente
Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()
Local LinhaCor

PRIVATE oPrint := TMSPrinter():New( OemToAnsi(STR0006) ) // "Encaminhamento para Realizacao dos Exames"
oPrint:Setup()
oPrint:SetPortrait() //retrato

Private oFont16,oFont14,oFont13,oFont12,oFont11,oFont10, oFont09n, oFont09, oFont08, lin
oFont08  := TFont():New("ARIAL",08,08,,.F.,,,,.F.,.F.)
oFont09  := TFont():New("ARIAL",09,09,,.F.,,,,.F.,.F.)
oFont09n := TFont():New("ARIAL",09,09,,.T.,,,,.F.,.F.)
oFont09  := TFont():New("ARIAL",09,09,,.F.,,,,.F.,.F.)
oFont10  := TFont():New("ARIAL",10,10,,.F.,,,,.F.,.F.)
oFont11  := TFont():New("ARIAL",11,11,,.F.,,,,.F.,.F.)
oFont12n := TFont():New("ARIAL",12,12,,.T.,,,,.F.,.F.)
oFont14n := TFont():New("ARIAL",14,14,,.T.,,,,.F.,.F.)

ProcRegua(RecCount())

For nXYZ := 1 To Len(aFilRelat)
	dbSelectArea("TM5")
	dbSetOrder(01)
	dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par04,.t.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  CONVOCADOS                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While !Eof()                                   .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ])        .AND.;
	      TM5->TM5_NUMFIC >= mv_par04              .AND.;
	      TM5->TM5_NUMFIC <= mv_par05

		IncProc()

		Do Case
		Case nNatureza == 1  //Considerar exames Admissionais
			If TM5->TM5_NATEXA <> "1"
				dbSkip()
				loop
			Endif
		Case nNatureza == 2  //Considerar exames Demissionais
			If TM5->TM5_NATEXA <> "5"
				dbSkip()
				loop
			Endif
		Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
			If TM5->TM5_NATEXA <> "4"
				dbSkip()
				loop
			Endif
		Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
			If TM5->TM5_NATEXA <> "3"
				dbSkip()
				loop
			Endif
		Case nNatureza == 5  //Considerar exames Periodicos
			If TM5->TM5_NATEXA <> "2"
				dbSkip()
				loop
			Endif
		Case nNatureza == 6  //Considerar exames de Monitoração Pontual
			If TM5->TM5_NATEXA <> "6"
				dbSkip()
				loop
			Endif
		EndCase

		lPulouTM5 := .F.
		IF mv_par13 == 2
			If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
				dbSelectArea("TM5")
				dbSkip()
				Loop
			Endif
		Endif
		If !EMPTY(TM5->TM5_DTRESU)
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		If TM5->TM5_EXAME < mv_par09 .OR. TM5->TM5_EXAME > mv_par10
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		cFilTM5 := aFilRelat[nXYZ]
		If !Empty(TM5->TM5_FILFUN)
			cFilTM5 := TM5->TM5_FILFUN
			If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
				dbSelectArea("TM5")
				dbskip()
				Loop
			Endif
		Endif

		Dbselectarea("TM0")
		Dbsetorder(1)
		If !Dbseek(xFilial("TM0",cFilTM5)+TM5->TM5_NUMFIC)
			dbSelectArea("TM5")
			dbSkip()
			loop
		Endif

		lCandidato := .f.
		lExCabe    := .T.
		dbSelectArea("SRA")
		dbSetOrder(01)
		If !dbSeek(xFilial("SRA",cFilTM5)+TM0->TM0_MAT)
			lCandidato := .t.
		Endif

		oPrint:StartPage()

		lin := 250

		oPrint:SayBitMap(lin-20,45,NGLocLogo(),nLargura,nAltura)

		//linhas
		For nAdd := 0 to 3
			oPrint:Line(lin-nAdd,805+nAdd,lin-nAdd,1505-nAdd)
		Next nAdd
		For nAdd := 0 to 8
			oPrint:Line(lin+145+nAdd,805+nAdd,lin+145+nAdd,1505)
		Next nAdd
		//colunas
		For nAdd := 0 to 3
			oPrint:Line(lin+5+nAdd,800-nAdd,lin+140-nAdd,800-nAdd)
		Next nAdd
		For nAdd := 0 to 8
			oPrint:Line(lin+5+nAdd,1505+nAdd,lin+140,1505+nAdd)
		Next nAdd

		oPrint:Line(lin+5,800,lin,800)
		oPrint:Line(lin+140,800,lin+145,800)
		oPrint:Line(lin,1500,lin+5,1505)
		For nAdd := 0 to 8
			oPrint:Line(lin+145+nAdd,1500,lin+140,1505+nAdd)
		Next nAdd

		SumLine(20)
		oPrint:Say(lin,820,STR0046,oFont12n) //"Ordem de Encaminhamento para"
		If nNatureza == 0
			oPrint:Say(lin+70,+1045,STR0047,oFont12n) // "Exames"
		ElseIf nNatureza == 3 .OR. nNatureza == 4
			oPrint:Say(lin+70,820,STR0047 + cNatureza,oFont12n) // "Exames"
		Else
			oPrint:Say(lin+70,+920,STR0047 + cNatureza,oFont12n) // "Exames"
		EndIf

		SumLine(180)
		oPrint:Say(lin,100,"SIGA/MDTR460",oFont09)
		oPrint:Say(lin,350,Substr(SM0->M0_NOMECOM,1,60),oFont09)
		oPrint:Say(lin,1800,STR0009+" "+DtoC(dDataBase),oFont09) //"Emissão:"
		oPrint:Say(lin,2120,time(),oFont09)

		//------------ Dados do Funcionario -------------//
		SumLine(60)

		//Linhas
		oPrint:Line(lin    ,55,lin    ,2295)
		oPrint:Line(lin+100,50,lin+100,2300)
		//Colunas
		oPrint:Line(lin+5,50  ,lin+100,50  )
		oPrint:Line(lin+5,2300,lin+100,2300)

		oPrint:Line(lin+5,50  ,lin  ,55  )
		oPrint:Line(lin  ,2295,lin+5,2300)

		oPrint:Say(lin+30,950,STR0048,oFont12n)  //"Dados do Funcionário"
		//------------ Dados do Funcionario -------------//

		oPrint:Line(lin+100,50,2090,50)
		oPrint:Line(lin+100,2300,2090,2300)

		SumLine(120)

		If !lCandidato
			oPrint:Say(lin,100,STR0127,oFont11) //"Filial:"
			oPrint:Say(lin,500,TM0->TM0_FILFUN,oFont11)

			SumLine(70)
			oPrint:Say(lin,100,STR0049,oFont11)	 //"Funcionário:"
			oPrint:Say(lin,500,TM5->TM5_MAT + " - " + Substr(SRA->RA_NOME,1,35),oFont11)
			oPrint:Say(lin,1600,STR0050 + TM5->TM5_NUMFIC,oFont11)  //"Ficha: "

			SumLine(70)
			oPrint:Say(lin,100,STR0051,oFont11)	 //"Centro de Custo:"
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC,cFilTM5)+TM5->TM5_CC)
			oPrint:Say(lin,500,Substr(Alltrim(TM5->TM5_CC)+" - "+&(cDescCC2),1,55),oFont11)

			SumLine(70)
			oPrint:Say(lin,100,STR0052,oFont11)	 //"Função:"
			dbSelectArea("SRJ")
			dbSetOrder(01)
			dbSeek(xFilial("SRJ",cFilTM5)+TM5->TM5_CODFUN)
			oPrint:Say(lin,500,AllTrim(TM5->TM5_CODFUN) + " - "+Substr(SRJ->RJ_DESC,1,40),oFont11)

			SumLine(70)
			oPrint:Say(lin,100,STR0053,oFont11) //"Nascimento:"
			oPrint:Say(lin,500,DtoC(SRA->RA_NASC),oFont11)
			oPrint:Say(lin,1600,STR0054 + DtoC(SRA->RA_ADMISSA) + STR0055 + R555ID(SRA->RA_NASC),oFont11)  //"Admissão: " //"      Idade: "
			SumLine(70)
			oPrint:Say(lin,100,STR0056,oFont11)  //"Registro Geral:"
			oPrint:Say(lin,500,SRA->RA_RG,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0057,oFont11)  //"C.P.F.:"
			oPrint:Say(lin,500,SRA->RA_CIC,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0058,oFont11)	 //"Carteira Profissional:"
			oPrint:Say(lin,500,SRA->RA_NUMCP,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0059,oFont11)	 //"Endereço:"
			oPrint:Say(lin,500,SRA->RA_ENDEREC,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0060,oFont11)	//"Bairro:"
			oPrint:Say(lin,500,SRA->RA_BAIRRO,oFont11)

		Else
			oPrint:Say(lin,100,STR0127,oFont11) //"Filial:"
			oPrint:Say(lin,500,TM0->TM0_FILIAL,oFont11)

			SumLine(70)
			oPrint:Say(lin,100,STR0061,oFont11) //"Candidato:"
		    nLinhasMemo := MLCOUNT( AllTrim( TM0->TM0_NOMFIC ), 40 )
			For nLinhaCorrente := 1 to nLinhasMemo
				If nLinhaCorrente == 1
					oPrint:Say( lin, 300, Alltrim( TM0->TM0_CANDID ) + " - " + Memoline( AllTrim( TM0->TM0_NOMFIC ), 40, nLinhaCorrente, NIL, .T. ), oFont11 )
				Else
					SumLine(40)
					oPrint:Say( lin, 300, Memoline( AllTrim( TM0->TM0_NOMFIC ), 40, nLinhaCorrente, NIL, .T. ), oFont11 )
				EndIf
			Next nLinhaCorrente

			If nLinhasMemo == 2
				lin := lin - 40 //Para não desposicionar o restante do relatório
			EndIf

			oPrint:Say(lin,1600,STR0050 + TM5->TM5_NUMFIC,oFont11)  //"Ficha: "
			SumLine(80)
			oPrint:Say(lin,100,STR0051,oFont11) //"Centro de Custo:"
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			If dbSeek(xFilial(cAliasCC,cFilTM5)+TM0->TM0_CC)
				oPrint:Say(lin,500,Substr(Alltrim(TM0->TM0_CC)+" - "+&(cDescCC2),1,55),oFont11)
			Endif

			SumLine(70)
			oPrint:Say(lin,100,STR0052,oFont11) //"Função:"
			dbSelectArea("SRJ")
			dbSetOrder(01)
			If dbSeek(xFilial("SRJ",cFilTM5)+TM0->TM0_CODFUN)
				oPrint:Say(lin,500,AllTrim(TM0->TM0_CODFUN)+" -  "+Substr(SRJ->RJ_DESC,1,40),oFont11)
			Endif

			SumLine(70)
			oPrint:Say(lin,100,STR0053,oFont11) 	//"Nascimento:"
			oPrint:Say(lin,500,DtoC(TM0->TM0_DTNASC),oFont11)
			oPrint:Say(lin,1600,STR0055 + R555ID(TM0->TM0_DTNASC) ,oFont11)  //"Idade: "
			SumLine(70)
			oPrint:Say(lin,100,STR0056,oFont11) 	//"Registro Geral:"
			oPrint:Say(lin,500,TM0->TM0_RG,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0057,oFont11)  //"CPF:"
			oPrint:Say(lin,500,TM0->TM0_CPF,oFont11)
			SumLine(70)
			oPrint:Say(lin,100,STR0058,oFont11)  //"Carteira Profissional:"
			oPrint:Say(lin,500,TM0->TM0_NUMCP,oFont11)
		Endif

		SumLine(70)
		//------------ Dados do Fornecedor de Exames -------------//

		oPrint:Line(lin,55,lin,2295)
		oPrint:Line(lin+100,50,lin+100,2300)
		oPrint:Line(lin+5,50,lin+100,50)
		oPrint:Line(lin+5,2300,lin+100,2300)

		oPrint:Line(lin+5,50,lin,55)
		oPrint:Line(lin,2295,lin+5,2300)

		oPrint:Say(lin+30,850,STR0045,oFont12n)  //"Dados do Fornecedor de Exames"
		//------------ Dados do Fornecedor de Exames -------------//

		SumLine(120)
		oPrint:Say(lin,100,STR0062,oFont11)	//"Fornecedor:"
		dbSelectArea("SA2")
		dbSetOrder(01)
		dbSeek(xFilial("SA2")+mv_par02+mv_par03)
		oPrint:Say(lin,450,Substr(Alltrim(mv_par02)+" - "+SA2->A2_NOME,1,63),oFont11)

		SumLine(70)
		oPrint:Say(lin,100,STR0059,oFont11)	 //"Endereço:"
		oPrint:Say(lin,450,ALLTRIM(SA2->A2_END),oFont11)

		SumLine(70)
		oPrint:Say(lin,100,STR0060,oFont11)	//"Bairro:"
		oPrint:Say(lin,450,ALLTRIM(SA2->A2_BAIRRO),oFont11)
		oPrint:Say(lin,1600,STR0063 + Substr(SA2->A2_MUN,1,40),oFont11)	 //"Cidade: "

		SumLine(70)
		oPrint:Say(lin,100,STR0064,oFont11)		//"Telefone:"
		oPrint:Say(lin,450,SA2->A2_TEL,oFont11)

		//------------ Responsável -------------//
		SumLine(70)

		oPrint:Line(lin,55,lin,2295)
		oPrint:Line(lin+100,50,lin+100,2300)
		oPrint:Line(lin+5,50,lin+100,50)
		oPrint:Line(lin+5,2300,lin+100,2300)

		oPrint:Line(lin+5,50,lin,55)
		oPrint:Line(lin,2295,lin+5,2300)

		oPrint:Say(lin+30,1020,STR0065,oFont12n)  //Responsável
		//------------ Responsável -------------//

		SumLine(120)
		oPrint:Say(lin,100,STR0066,oFont11)	 //"Médico:"

		DbSelectArea("TMK")
		DbSetOrder(1)
		DbSeek(xFilial("TMK")+mv_par08)
		oPrint:Say(lin,450,Substr(TMK->TMK_NOMUSU,1,60),oFont11)

		SumLine(70)
		oPrint:Say(lin,100,STR0067,oFont11)	 //"CRM:"
		oPrint:Say(lin,450,TMK->TMK_NUMENT,oFont11)

		//------------ Exames -------------//
		SumLine(70)

		oPrint:Line(lin    ,55  ,lin    ,2295)
		oPrint:Line(lin+100,50  ,lin+100,2300)
		oPrint:Line(lin+5  ,50  ,lin+250,50  )
		oPrint:Line(lin+5  ,2300,lin+250,2300)

		oPrint:Line(lin+5,50  ,lin  ,55  )
		oPrint:Line(lin  ,2295,lin+5,2300)

		oPrint:Say(lin+30,1060,STR0068,oFont12n)
		SumLine(70)
		SumLine(70)
		oPrint:Say(lin,100,STR0140,oFont09) //"Data do Exame....:"
		oPrint:Say(lin,400,DtoC(TM5->TM5_DTPROG),oFont09)
		SumLine(50)
		oPrint:Say(lin,100,STR0141,oFont09) //"Horário do Exame.:"
		oPrint:Say(lin,400,TM5->TM5_HRPROG,oFont09)

		//------------ Exames -------------//

		If nNatureza == 0

			oPrint:Line(lin,50,lin+250,50)
			oPrint:Line(lin,2300,lin+250,2300)

			//------------ Exame Natureza -------------//
			SumLine(140)

			oPrint:Say(lin,100,STR0088,oFont09n) //"Exame"
			oPrint:Say(lin,890,STR0089,oFont09n) //"Natureza"

			SumLine(70)
			oPrint:Line(lin,50,lin,2300)
			//------------ Exame Natureza -------------//

			SumLine(35)
		Else
			SumLine(60)
		EndIf

		cFicsalvo := TM5->TM5_NUMFIC
		lFirst    := .T.
		lLinha    := .T.
		nCont     := 1
		aExames   := {}

		dbSelectArea("TM5")
		While !Eof()                               .AND.;
			  TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ])    .AND.;
			  TM5->TM5_NUMFIC == cFicsalvo

				Do Case
				Case nNatureza == 1  //Considerar exames Admissionais
					If TM5->TM5_NATEXA <> "1"
						dbSkip()
						loop
					Endif
				Case nNatureza == 2  //Considerar exames Demissionais
					If TM5->TM5_NATEXA <> "5"
						dbSkip()
						loop
					Endif
				Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
					If TM5->TM5_NATEXA <> "4"
						dbSkip()
						loop
					Endif
				Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
					If TM5->TM5_NATEXA <> "3"
						dbSkip()
						loop
					Endif
				Case nNatureza == 5  //Considerar exames Periodicos
					If TM5->TM5_NATEXA <> "2"
						dbSkip()
						loop
					Endif
				Case nNatureza == 6  //Considerar exames de Monitoração Pontual
					If TM5->TM5_NATEXA <> "6"
						dbSkip()
						loop
					Endif
				EndCase
				IF mv_par13 == 2
					If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
						dbSelectArea("TM5")
						dbSkip()
						Loop
					Endif
				Endif
				If !EMPTY(TM5->TM5_DTRESU)
					dbSelectArea("TM5")
					dbSkip()
					loop
				Endif

				If TM5->TM5_EXAME < mv_par09 .OR. TM5->TM5_EXAME > mv_par10
					dbSelectArea("TM5")
					dbSkip()
					loop
				Endif

				If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
					dbSelectArea("TM5")
					dbSkip()
					loop
				Endif

				If TM5->TM5_NATEXA == "1"
					cNatExa := STR0108 //"Admissional"
				ElseIf TM5->TM5_NATEXA == "2"
					cNatExa := STR0109 //"Periódico"
				ElseIf TM5->TM5_NATEXA == "3"
					cNatExa := STR0110 //"Mudança Função"
				ElseIf TM5->TM5_NATEXA == "4"
					cNatExa := STR0111 //"Retorno Trabalho"
				ElseIf TM5->TM5_NATEXA == "5"
					cNatExa := STR0112  //"Demissional"
				ElseIf TM5->TM5_NATEXA == "6"
					cNatExa := STR0176  //"Monitoração Pontual"
				Else
					cNatExa := "  "
				EndIf

				If nNatureza == 0
					If ( aSCAN (aExames, {|x| x[1] == TM5->TM5_EXAME+cNatExa}) ) < 1
						aADD (aExames, {TM5->TM5_EXAME+cNatExa} )
						If lFirst
							lFirst := .F.
							oPrint:Line(2090,50  ,2100,50  )
							oPrint:Line(2090,2300,2100,2300)
						Else
							SumLine(70)
						EndIf
						dbSelectArea("TM4")
						dbSetOrder(01)
						dbSeek(xFilial("TM4",cFilTM5)+TM5->TM5_EXAME)

						If lPrepExame
							oPrint:Line(lin,50  ,lin+75,50  )
							oPrint:Line(lin,2300,lin+75,2300)
							oPrint:Say(lin,100,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,33),oFont08)
							oPrint:Say(lin,890,cNatExa,oFont08)
							SumLine(50)
							oPrint:Line(lin,50  ,lin+70,50  )
							oPrint:Line(lin,2300,lin+70,2300)
							oPrint:Say(lin,100,STR0135,oFont08)
							lLinha       := .T.
							cTextoNew    := MSMM(TM4->TM4_PREPAR)
							nLinhasMemo  := MLCOUNT(cTextoNew,112)
							For LinhaCor := 1 To nLinhasMemo
								If lLinha
									lLinha := .F.
								Else
									If (lin + 50) > 3200
										SumLine(70)
									Else
										SumLine(50)
									EndIf
								EndIf
								oPrint:Line(lin,50  ,lin+70,50  )
								oPrint:Line(lin,2300,lin+70,2300)
								oPrint:Say(lin,350,MemoLine(cTextoNew,112,LinhaCor),oFont08)
							Next LinhaCor
						Else
							If nCont > 20
								nCont := 1
								oPrint:Line(lin-10,50,lin-10,2300)
								SumLine(5000)

								//------------ Exames -------------//
								oPrint:Line(lin,55,lin,2295)
								oPrint:Line(lin+100,50,lin+100,2300)
								oPrint:Line(lin+5,50,lin+100,50)
								oPrint:Line(lin+5,2300,lin+100,2300)

								oPrint:Line(lin+5,50,lin,55)
								oPrint:Line(lin,2295,lin+5,2300)

								oPrint:Say(lin+30,1060,STR0068,oFont12n)  //"Exames"
								//------------ Exames -------------//
								oPrint:Line(350,50,370,50)
								oPrint:Line(350,2300,370,2300)

								If nNatureza == 0
									//------------ Exame                           Natureza -------------//
									SumLine(140)

									oPrint:Say(lin,100,STR0088,oFont09n) //"Exame"
									oPrint:Say(lin,890,STR0089,oFont09n) //"Natureza"

									SumLine(70)
									oPrint:Line(lin,50,lin,2300)
									//------------ Exame                           Natureza -------------//

									SumLine(35)
								Else
									SumLine(120)
								EndIf
							Endif

							If nCont <= 10
								oPrint:Line(lin,50  ,lin+75,50  )
								oPrint:Line(lin,2300,lin+75,2300)
								oPrint:Say(lin,100,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,33),oFont08)
								oPrint:Say(lin,890,cNatExa,oFont08)
								nAux := lin
							Elseif nCont <= 20
								If lExCabe
									oPrint:Say(lin-105,1215,STR0088,oFont09n) //"Exame"
									oPrint:Say(lin-105,1990,STR0089,oFont09n) //"Natureza"
									lExCabe := .F.
								EndIf
								oPrint:Say(lin,1215,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,30),oFont08)
								oPrint:Say(lin,1990,AllTrim(cNatExa),oFont08)
							Endif
							nCont ++
							If nCont == 11
								lin := lin - (70*10)
							Endif
						EndIf
					EndIf
				Else
					If ( aSCAN (aExames, {|x| x[1] == TM5->TM5_EXAME}) ) < 1
						aADD (aExames, {TM5->TM5_EXAME} )
						If lFirst
							lFirst := .F.
							oPrint:Line(2090,50  ,2100,50  )
							oPrint:Line(2090,2300,2100,2300)
						Else
							SumLine(70)
						Endif
						dbSelectArea("TM4")
						dbSetOrder(01)
						dbSeek(xFilial("TM4",cFilTM5)+TM5->TM5_EXAME)

						If lPrepExame
							oPrint:Line(lin,50  ,lin+75,50  )
							oPrint:Line(lin,2300,lin+75,2300)
							oPrint:Say(lin,100,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,33),oFont08)
							SumLine(50)
							oPrint:Line(lin,50  ,lin+70,50  )
							oPrint:Line(lin,2300,lin+70,2300)
							oPrint:Say(lin,100,STR0135,oFont08)
							lLinha       := .T.
							cTextoNew    := MSMM(TM4->TM4_PREPAR)
							nLinhasMemo  := MLCOUNT(cTextoNew,112)
							For LinhaCor := 1 To nLinhasMemo
								If lLinha
									lLinha := .F.
								Else
									If (lin + 50) > 3200
										SumLine(70)
									Else
										SumLine(50)
									EndIf
								EndIf
								oPrint:Line(lin,50  ,lin+70,50  )
								oPrint:Line(lin,2300,lin+70,2300)
								oPrint:Say(lin,350,MemoLine(cTextoNew,112,LinhaCor),oFont08)
							Next LinhaCor
						Else
							If nCont > 20
								nCont := 1
								oPrint:Line(lin-10,50,lin-10,2300)
								SumLine(5000)

								//------------ Exames -------------//
								oPrint:Line(lin,55,lin,2295)
								oPrint:Line(lin+100,50,lin+100,2300)
								oPrint:Line(lin+5,50,lin+100,50)
								oPrint:Line(lin+5,2300,lin+100,2300)

								oPrint:Line(lin+5,50,lin,55)
								oPrint:Line(lin,2295,lin+5,2300)

								oPrint:Say(lin+30,1060,STR0068,oFont12n)  //"Exames"
								//------------ Exames -------------//
								oPrint:Line(350,50,370,50)
								oPrint:Line(350,2300,370,2300)

								SumLine(120)
							Endif

							If nCont <= 10
								oPrint:Line(lin,50  ,lin+75,50  )
								oPrint:Line(lin,2300,lin+75,2300)
								oPrint:Say(lin,100,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,40),oFont10)
								nAux := lin
							Elseif nCont <= 20
								oPrint:Say(lin,1400,AllTrim(TM5->TM5_EXAME) + " - "+Substr(TM4->TM4_NOMEXA,1,40),oFont10)
							Endif
							nCont ++
							If nCont == 11
								lin := lin - (70*10)
							Endif
						EndIf
					EndIf
				EndIf
				dbSelectArea("TM5")
				dbskip()
				lPulouTM5 := .T.
		Enddo

		If !lPrepExame
			lin := nAux
		EndIf

		If (lin + 225) <= 3200
			oPrint:Line(lin+70,50,lin+70,2300)
		EndIf

		SumLine(70)

		//-------- Realização e Responsavel----------//
		oPrint:Line(lin,50  ,lin+150,50  )
		oPrint:Line(lin,2300,lin+150,2300)
		oPrint:Say(lin+70,100,STR0069,oFont10) //"Realizacao: _____/_____/_____  Responsavel: ___________________________________   Assinatura: _______________________ "

		// Linhas Finais
		oPrint:Line(lin+155,55  ,lin+155,2295)
		oPrint:Line(lin+150,50  ,lin+155,55  )
		oPrint:Line(lin+155,2295,lin+150,2300)

		dbSelectArea("TM5")
		If !Eof() .AND. !lPulouTM5
			dbskip()
		EndIf

		oPrint:EndPage()

	Enddo

Next nXYZ

If aReturn[5] == 1
	oPrint:Preview()
Else
	oPrint:Print()
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR460   ºAutor: ³Andre Perez Alvarez º Data ³  11/07/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Imprime modelo grafico (coletivo)                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR460                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RGRAFCol()

Local lImprime := .F.

LOCAL nAdd,nXYZ
Local nLinhasMemo
Local nLinhaCorrente
LOCAL lFirst
Local cSMCOD := FWGrpCompany()
Local cSMFIL := FWCodFil()

PRIVATE nLinFu
PRIVATE nLinFun2 := 0

PRIVATE oPrint := TMSPrinter():New( OemToAnsi(STR0006) )  //"Encaminhamento para Realizacao dos Exames"
oPrint:Setup()
oPrint:SetPortrait() //retrato

Private oFont16,oFont14,oFont13,oFont12,oFont11,oFont10,lin
oFont09n := TFont():New("ARIAL",09,09,,.T.,,,,.F.,.F.)
oFont09  := TFont():New("ARIAL",09,09,,.F.,,,,.F.,.F.)
oFont10  := TFont():New("ARIAL",10,10,,.F.,,,,.F.,.F.)
oFont11  := TFont():New("ARIAL",11,11,,.F.,,,,.F.,.F.)
oFont12n := TFont():New("ARIAL",12,12,,.T.,,,,.F.,.F.)
oFont14n := TFont():New("ARIAL",14,14,,.T.,,,,.F.,.F.)

oPrint:StartPage()

For nXYZ := 1 To Len(aFilRelat)
	If lImprime
		Exit
	Endif
	dbSelectArea("TM5")
	dbSetOrder(02)
	If dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par09)
		While !Eof() .AND. TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ]) .AND. TM5->TM5_EXAME == mv_par09
			If !Empty(TM5->TM5_FILFUN)
				If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif
			IF mv_par13 == 2
				If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
					dbSelectArea("TM5")
					dbSkip()
					Loop
				Else
					lImprime := .T.
					Exit
				Endif
			Endif
			Do Case
				Case nNatureza == 1  //Considerar exames Admissionais
					If TM5->TM5_NATEXA == "1"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 2  //Considerar exames Demissionais
					If TM5->TM5_NATEXA == "5"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
					If TM5->TM5_NATEXA == "4"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
					If TM5->TM5_NATEXA == "3"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 5  //Considerar exames Periodicos
					If TM5->TM5_NATEXA == "2"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 6  //Considerar exames de Monitoração Pontual
					If TM5->TM5_NATEXA == "6"
						lImprime := .T.
						Exit
					Endif
				Case nNatureza == 0
					lImprime := .T.
					Exit
			EndCase
			dbSkip()
		End
	Endif
Next nXYZ

If lImprime

	lin := 250

	oPrint:SayBitMap(lin-20,45,NGLocLogo(),nLargura,nAltura)

	//linhas
	For nAdd := 0 to 3
		oPrint:Line(lin-nAdd,805+nAdd,lin-nAdd,1505-nAdd)
	Next nAdd
	For nAdd := 0 to 8
		oPrint:Line(lin+145+nAdd,805+nAdd,lin+145+nAdd,1505)
	Next nAdd
	//colunas
	For nAdd := 0 to 3
		oPrint:Line(lin+5+nAdd,800-nAdd,lin+140-nAdd,800-nAdd)
	Next nAdd
	For nAdd := 0 to 8
		oPrint:Line(lin+5+nAdd,1505+nAdd,lin+140,1505+nAdd)
	Next nAdd

	oPrint:Line(lin+5,800,lin,800)
	oPrint:Line(lin+140,800,lin+145,800)
	oPrint:Line(lin,1500,lin+5,1505)
	For nAdd := 0 to 8
		oPrint:Line(lin+145+nAdd,1500,lin+140,1505+nAdd)
	Next nAdd

	lin+=20
	oPrint:Say(lin,820,STR0046,oFont12n) //"Ordem de Encaminhamento para"
	If nNatureza == 0
		oPrint:Say(lin+70,+1045,STR0047,oFont12n) // "Exames"
	ElseIf nNatureza == 3 .OR. nNatureza == 4
		oPrint:Say(lin+70,820,STR0047 + cNatureza,oFont12n) // "Exames"
	Else
		oPrint:Say(lin+70,+920,STR0047 + cNatureza,oFont12n) // "Exames"
	EndIf

	lin += 180
	oPrint:Say(lin,100,"SIGA/MDTR460",oFont09)
	oPrint:Say(lin,350,Substr(SM0->M0_NOMECOM,1,60),oFont09)
	oPrint:Say(lin,1800,STR0009+" "+DtoC(dDataBase),oFont09)	//"Emissão:"
	oPrint:Say(lin,2120,time(),oFont09)

	//------------ Dados do Exame -------------//
	lin += 60

	oPrint:Line(lin,55,lin,2295)
	oPrint:Line(lin+100,50,lin+100,2300)

	oPrint:Line(lin+5,50,lin+100,50)
	oPrint:Line(lin+5,2300,lin+100,2300)

	oPrint:Line(lin+5,50,lin,55)
	oPrint:Line(lin,2295,lin+5,2300)

	oPrint:Say(lin+30,990,STR0070,oFont12n)  //"Dados do Exame"
	//------------ Dados do Exame -------------//

	oPrint:Line(lin+100,50,1800,50)
	oPrint:Line(lin+100,2300,1800,2300)

	lin += 120

	dbSelectArea("TM4")
	dbSetOrder(01)
	dbSeek(xFilial("TM4")+TM5->TM5_EXAME)
	oPrint:Say(lin,100,STR0071,oFont11)	 //"Exame:"
	oPrint:Say(lin,400,Alltrim(mv_par09) + " - " + Substr(TM4->TM4_NOMEXA,1,53),oFont11)

	lin += 70
	oPrint:Say(lin,100,STR0072,oFont11)
	dbSelectArea("SA2")
	dbSetOrder(01)
	dbSeek(xFilial("SA2")+mv_par02+mv_par03)
	oPrint:Say(lin,400,Alltrim(mv_par02)+" - "+Substr(SA2->A2_NOME,1,40),oFont11)

	lin += 70
	oPrint:Say(lin,100,STR0059,oFont11)  //"Endereço:"
	oPrint:Say(lin,400,Alltrim(SA2->A2_END),oFont11)
	oPrint:Say(lin,1600,STR0064 + Substr(SA2->A2_TEL,1,17),oFont11)  //"Telefone: "

	lin += 70
	oPrint:Say(lin,100,STR0060,oFont11)  //"Bairro:"
	oPrint:Say(lin,400,SA2->A2_BAIRRO,oFont11)
	oPrint:Say(lin,1600,STR0063 + Alltrim(SA2->A2_MUN),oFont11)  //"Cidade: "

	//------------ Funcionários -------------//
	lin += 70

	oPrint:Line(lin,50,lin,2300)
	oPrint:Line(lin+100,50,lin+100,2300)
	oPrint:Say(lin+30,1035,STR0073,oFont12n)  //"Funcionários"
	//------------ Funcionários -------------//

	//------------ Filial Mat.     Nome      Centro de Custo      Função       Idade -------------//
	lin   += 140
	nColZ := 080
	nCol1 := 265
	nCol2 := 445
	nCol3 := 1085
	nCol4 := 1685
	nCol5 := 2200
	oPrint:Say(lin,nColZ,STR0128,oFont09n) //"Filial"
	oPrint:Say(lin,nCol1,STR0074,oFont09n)  //"Mat."
	oPrint:Say(lin,nCol2,STR0075,oFont09n)  //"Nome"
	oPrint:Say(lin,nCol3,STR0076,oFont09n)  //"Centro de Custo"
	oPrint:Say(lin,nCol4,STR0077,oFont09n)  //"Função"
	oPrint:Say(lin,nCol5,STR0078,oFont09n)  //"Idade"
	lin += 70
	oPrint:Line(lin,50,lin,2300)
	//------------ Filial  Mat.     Nome      Centro de Custo      Função       Idade -------------//
	lin += 35

	ProcRegua(RecCount())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  CONVOCADOS                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	nCol   := 01
	nLinFu := 1115
	nColX  := 400
	nColY  := 800
	lFirst := .T.
	nDes   := 65
	xx     := 80

	For nXYZ := 1 To Len(aFilRelat)
		dbSelectArea("TM5")
		dbSetOrder(02)
		dbSeek(xFilial("TM5",aFilRelat[nXYZ])+mv_par09)
		While !Eof()                                   .AND.;
			  TM5->TM5_FILIAL == xFIlial('TM5',aFilRelat[nXYZ])        .AND.;
			  TM5->TM5_EXAME == mv_par09

			IncProc()

			cFilTM5 := aFilRelat[nXYZ]
			If !Empty(TM5->TM5_FILFUN)
				cFilTM5 := TM5->TM5_FILFUN
				If TM5->TM5_FILFUN < mv_par14 .or. TM5->TM5_FILFUN > mv_par15
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif

			IF mv_par13 == 2
				If TM5->TM5_FORNEC+TM5->TM5_LOJA != MV_PAR02+MV_PAR03
					dbSelectArea("TM5")
					dbSkip()
					Loop
				Endif
			Endif
			If !EMPTY(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_NUMFIC < mv_par04 .OR. TM5->TM5_NUMFIC > mv_par05
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If TM5->TM5_DTPROG < mv_par06 .OR. TM5->TM5_DTPROG > mv_par07
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			Do Case
				Case nNatureza == 1  //Considerar exames Admissionais
					If TM5->TM5_NATEXA <> "1"
						dbSkip()
						loop
					Endif
				Case nNatureza == 2  //Considerar exames Demissionais
					If TM5->TM5_NATEXA <> "5"
						dbSkip()
						loop
					Endif
				Case nNatureza == 3  //Considerar exames de Retorno ao Trabalho
					If TM5->TM5_NATEXA <> "4"
						dbSkip()
						loop
					Endif
				Case nNatureza == 4  //Considerar exames de Mudanca de Funcao
					If TM5->TM5_NATEXA <> "3"
						dbSkip()
						loop
					Endif
				Case nNatureza == 5  //Considerar exames Periodicos
					If TM5->TM5_NATEXA <> "2"
						dbSkip()
						loop
					Endif
				Case nNatureza == 6  //Considerar exames de Monitoração Pontual
					If TM5->TM5_NATEXA <> "6"
						dbSkip()
						loop
					Endif
			EndCase

			Dbselectarea("TM0")
			Dbsetorder(1)
			If !Dbseek(xFilial("TM0",cFilTM5)+TM5->TM5_NUMFIC)
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			If (nPos := aScan(aNFichas,{|x| TM0->TM0_NUMFIC == x[1]})) > 0
				dbSelectArea("TM5")
				dbSkip()
				loop
			Endif

			lCandidato := .f.
			dbSelectArea("SRA")
			dbSetOrder(01)
			If !dbSeek(xFilial("SRA",cFilTM5)+TM0->TM0_MAT)
				lCandidato := .t.
			Endif

			If lFirst
				oPrint:Line(nLinFu,50,nLinFu+xx,50)
				oPrint:Line(nLinFu,2300,nLinFu+xx,2300)
				nLinFu += xx
			Else
				SumLine2(60)
				nLinFun2 += 5
				oPrint:Line(nLinFu,50,nLinFu+xx+nLinFun2,50)
				oPrint:Line(nLinFu,2300,nLinFu+xx+nLinFun2,2300)
				nLinFu += (xx + nLinFun2)
			Endif
			lFirst := .F.

			If !lCandidato

				oPrint:Say(lin,nColZ,TM0->TM0_FILFUN,oFont09)
				oPrint:Say(lin,nCol1,TM5->TM5_MAT,oFont09)
				oPrint:Say(lin,nCol2,Substr(SRA->RA_NOME,1,30),oFont09)
				dbSelectArea(cAliasCC)
				dbSetOrder(01)
				dbSeek(xFilial(cAliasCC,cFilTM5)+TM5->TM5_CC)
				oPrint:Say(lin,nCol3,Substr(&(cDescCC2),1,30),oFont09)
				dbSelectArea("SRJ")
				dbSetOrder(01)
				dbSeek(xFilial("SRJ",cFilTM5)+TM5->TM5_CODFUN)
				oPrint:Say(lin,nCol4,Substr(SRJ->RJ_DESC,1,25),oFont09)
				oPrint:Say(lin,nCol5,R555ID(SRA->RA_NASC),oFont09)

				//Dados do funcionario
				SumLine2(50,.F.)
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0056,oFont09)  //"Registro Geral:"
				oPrint:Say(lin,nColY,SRA->RA_RG,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0057,oFont09)  //"C.P.F.:"
				oPrint:Say(lin,nColY,SRA->RA_CIC,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0058,oFont09)  //"Carteira Profissional:"
				oPrint:Say(lin,nColY,SRA->RA_NUMCP,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0059,oFont09)  //"Endereço:"
				oPrint:Say(lin,nColY,SRA->RA_ENDEREC,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0060,oFont09)  //"Bairro:"
				oPrint:Say(lin,nColY,SRA->RA_BAIRRO,oFont09)
				oPrint:Line(nLinFu,50,nLinFu+50,50)
				oPrint:Line(nLinFu,2300,nLinFu+50,2300)
				//--Fim
			Else

				nLinhasMemo := MLCOUNT( AllTrim( TM0->TM0_NOMFIC ), 40 )
				For nLinhaCorrente := 1 to nLinhasMemo
					oPrint:Say( lin, nCol2, Memoline( AllTrim( TM0->TM0_NOMFIC ), 40, nLinhaCorrente, NIL, .T. ), oFont11 )
					SumLine2(40)
				Next nLinhaCorrente

				lin := lin - 40 //Para não desposicionar o restante do relatório

				dbSelectArea(cAliasCC)
				dbSetOrder(01)
				If dbSeek(xFilial(cAliasCC,cFilTM5)+TM0->TM0_CC)
					oPrint:Say(lin,nCol3,Substr(&(cDescCC2),1,40),oFont09)
				Endif

				dbSelectArea("SRJ")
				dbSetOrder(01)
				If dbSeek(xFilial("SRJ",cFilTM5)+TM0->TM0_CODFUN)
					oPrint:Say(lin,nCol4,Substr(SRJ->RJ_DESC,1,30),oFont09)
				Endif

				oPrint:Say(lin,nCol5,R555ID(TM0->TM0_DTNASC),oFont09)

				//Dados do Funcionario
				SumLine2(50,.F.)
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0056,oFont09)  //"Registro Geral:"
				oPrint:Say(lin,nColY,TM0->TM0_RG,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0057,oFont09)  //"CPF:"
				oPrint:Say(lin,nColY,TM0->TM0_CPF,oFont09)

				SumLine2(60)
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
				oPrint:Say(lin,nColX,STR0058,oFont09)  //"Carteira Profissional:"
				oPrint:Say(lin,nColY,TM0->TM0_NUMCP,oFont09)

				//--Fim
			Endif

			lin += 70
			nLinFu += nDes
			oPrint:Line(nLinFu,50,nLinFu+nDes,50)
			oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
			oPrint:Say(lin,nColX,STR0140,oFont09)  //"Realizar Exame até:"
			oPrint:Say(lin,nColY,DtoC(TM5->TM5_DTPROG),oFont09)

			If nLinhasMemo == 2
				nLinFu += nDes
				oPrint:Line(nLinFu,50,nLinFu+nDes,50)
				oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
			EndIf

			lin += 70
			nLinFu += nDes
			oPrint:Line(nLinFu,50,nLinFu+nDes,50)
			oPrint:Line(nLinFu,2300,nLinFu+nDes,2300)
			oPrint:Say(lin,nColX,STR0141,oFont09)  //"Horário do Exame.:"
			oPrint:Say(lin,nColY,TM5->TM5_HRPROG,oFont09)

			AADD(aNFichas,{TM0->TM0_NUMFIC})
			dbSelectArea("TM5")
			dbskip()
		Enddo
	Next nXYZ

	//------------ Médico Responsável -------------//
	If (lin + 550) > 3200
		oPrint:Line(nLinFu+nDes,50,nLinFu+nDes,2300)
		oPrint:EndPage()
		oPrint:StartPage()	//Inicio de uma nova Pag.
		lin := 250
		oPrint:Line(lin,50,lin+335,50)
		oPrint:Line(lin,2300,lin+335,2300)
	Else
		lin += 70
		oPrint:Line(lin-40,50,lin+335,50)
		oPrint:Line(lin-40,2300,lin+335,2300)
	Endif

	oPrint:Line(lin,50,lin,2300)
	oPrint:Line(lin+100,50,lin+100,2300)
	oPrint:Say(lin+30,1000,STR0079,oFont12n)  //"Médico Responsável"
	//------------ Médico Responsável -------------//

	lin += 130
	oPrint:Say(lin,100,STR0080,oFont11)  //"Assinatura: _________________________                    Realização: ______/______/______"
	lin += 70

	DbSelectArea("TMK")
	DbSetOrder(1)
	DbSeek(xFilial("TMK")+mv_par08)
	oPrint:Say(lin,100,STR0066 + Substr(TMK->TMK_NOMUSU,1,60),oFont11)	//"Médico: "

	lin += 70
	oPrint:Say(lin,100,STR0067,oFont11)	//"CRM:"
	oPrint:Say(lin,450,TMK->TMK_NUMENT,oFont11)

	lin += 70
	oPrint:Line(lin,55,lin,2295)

	oPrint:Line(lin-5,50,lin,55)
	oPrint:Line(lin,2295,lin-5,2300)

Endif  //Fim - lImprime

oPrint:EndPage()

If !lImprime
	MsgInfo(STR0099)  //"Não há nada para imprimir no relatório."
	RetIndex("TM5")
	Set Filter To
	Return .F.
Endif

If aReturn[5] == 1
	oPrint:Preview()
Else
	oPrint:Print()
EndIf

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR460   ºAutor: ³Andre Perez Alvarez º Data ³  11/07/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  SumLine                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR460                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SumLine(nLinhas)
Local nOldLin   := lin
nOldLin += nLinhas

// Se o numero de linhas ultrapassar 3200 pixels, cria uma nova pag.
If nOldLin > 3200
	lin += nLinhas
	oPrint:Line(lin,50,lin,2300)
	oPrint:EndPage()
	oPrint:StartPage()	//Inicio de uma nova Pag.
	lin := 255
	oPrint:Line(lin,50  ,lin+10,50  )
	oPrint:Line(lin,2300,lin+10,2300)
	oPrint:Line(lin,50  ,lin   ,2300)
	lin += 5
Else
	lin := nOldLin
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR460   ºAutor: ³Andre Perez Alvarez º Data ³  11/07/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  SumLine2                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MDTR460                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function SumLine2(nLinhas,lDes)

Local nAdd
Default lDes := .T.

lin += nLinhas
// Se o numero de linhas ultrapassar 3200 pixels, cria uma nova pag.
If lin > 3200

	If lDes
		oPrint:Line(nLinFu+nDes,50,nLinFu+nDes,2300)
	Else
		oPrint:Line(nLinFu,50,nLinFu,2300)
	Endif

	oPrint:EndPage()
	oPrint:StartPage()	//Inicio de uma nova Pag.

	//Imprime os Dados dos Exames novamente
	***************************************
	lin := 250
	//linhas
	For nAdd := 0 to 3
		oPrint:Line(lin-nAdd,805+nAdd,lin-nAdd,1505-nAdd)
	Next nAdd
	For nAdd := 0 to 8
		oPrint:Line(lin+145+nAdd,805+nAdd,lin+145+nAdd,1505)
	Next nAdd
	//colunas
	For nAdd := 0 to 3
		oPrint:Line(lin+5+nAdd,800-nAdd,lin+140-nAdd,800-nAdd)
	Next nAdd
	For nAdd := 0 to 8
		oPrint:Line(lin+5+nAdd,1505+nAdd,lin+140,1505+nAdd)
	Next nAdd

	oPrint:Line(lin+5,800,lin,800)
	oPrint:Line(lin+140,800,lin+145,800)
	oPrint:Line(lin,1500,lin+5,1505)
	For nAdd := 0 to 8
		oPrint:Line(lin+145+nAdd,1500,lin+140,1505+nAdd)
	Next nAdd

	lin+=20
	oPrint:Say(lin,820,STR0046,oFont12n) //"Ordem de Encaminhamento para"
	If nNatureza == 0
		oPrint:Say(lin+70,+1045,STR0047,oFont12n) // "Exames"
	ElseIf nNatureza == 3 .OR. nNatureza == 4
		oPrint:Say(lin+70,820,STR0047 + cNatureza,oFont14n) // "Exames"
	Else
		oPrint:Say(lin+70,+920,STR0047 + cNatureza,oFont14n) // "Exames"
	EndIf

	lin += 180
	oPrint:Say(lin,100,"SIGA/MDTR460",oFont09)
	oPrint:Say(lin,350,Substr(SM0->M0_NOMECOM,1,60),oFont09)
	oPrint:Say(lin,1800,STR0009+" "+DtoC(dDataBase),oFont09)	//"Emissão:"
	oPrint:Say(lin,2120,time(),oFont09)

	//------------ Dados do Exame -------------//
	lin += 60

	oPrint:Line(lin,55,lin,2295)
	oPrint:Line(lin+100,50,lin+100,2300)

	oPrint:Line(lin+5,50,lin+100,50)
	oPrint:Line(lin+5,2300,lin+100,2300)

	oPrint:Line(lin+5,50,lin,55)
	oPrint:Line(lin,2295,lin+5,2300)

	oPrint:Say(lin+30,990,STR0070,oFont12n)  //"Dados do Exame"
	//------------ Dados do Exame -------------//

	oPrint:Line(lin+100,50,1120,50)
	oPrint:Line(lin+100,2300,1120,2300)

	lin += 120

	dbSelectArea("TM4")
	dbSetOrder(01)
	dbSeek(xFilial("TM4")+TM5->TM5_EXAME)
	oPrint:Say(lin,100,STR0071,oFont11)	 //"Exame:"
	oPrint:Say(lin,400,Alltrim(TM5->TM5_EXAME) + " - " + Substr(TM4->TM4_NOMEXA,1,53),oFont11)

	lin += 70
	oPrint:Say(lin,100,STR0072,oFont11)  //"Fornecedor:"
	dbSelectArea("SA2")
	dbSetOrder(01)
	dbSeek(xFilial("SA2")+mv_par02+mv_par03)
	oPrint:Say(lin,400,Alltrim(mv_par02)+" - "+Substr(SA2->A2_NOME,1,40),oFont11)

	lin += 70
	oPrint:Say(lin,100,STR0059,oFont11) //"Endereço:"
	oPrint:Say(lin,400,Alltrim(SA2->A2_END),oFont11)
	oPrint:Say(lin,1600,STR0064 + Substr(SA2->A2_TEL,1,17),oFont11) //"Telefone: "

	lin += 70
	oPrint:Say(lin,100,STR0060,oFont11)  //"Bairro:"
	oPrint:Say(lin,400,SA2->A2_BAIRRO,oFont11)
	oPrint:Say(lin,1600,STR0063+Alltrim(SA2->A2_MUN),oFont11)  //"Cidade: "

	//------------ Funcionários -------------//
	lin += 70

	oPrint:Line(lin,50,lin,2300)
	oPrint:Line(lin+100,50,lin+100,2300)
	oPrint:Say(lin+30,1035,STR0073,oFont12n)  //"Funcionários"
	//------------ Funcionários -------------//

	//------------ Mat.     Nome      Centro de Custo      Função       Idade -------------//
	lin   += 140
	nColZ := 080
	nCol1 := 265
	nCol2 := 445
	nCol3 := 1085
	nCol4 := 1685
	nCol5 := 2200
	oPrint:Say(lin,nColZ,STR0128,oFont09n) //"Filial"
	oPrint:Say(lin,nCol1,STR0074,oFont09n) //"Mat."
	oPrint:Say(lin,nCol2,STR0075,oFont09n) //"Nome"
	oPrint:Say(lin,nCol3,STR0076,oFont09n) //"Centro de Custo"
	oPrint:Say(lin,nCol4,STR0077,oFont09n) //"Função"
	oPrint:Say(lin,nCol5,STR0078,oFont09n) //"Idade"
	lin += 70
	oPrint:Line(lin,50,lin,2300)
	//------------ Mat.     Nome      Centro de Custo      Função       Idade -------------//

	lin      += 45
	nLinFu   := 1115
	nLinFun2 := 0
	xx       := 80

	oPrint:Line(nLinFu,50,nLinFu+xx,50)
	oPrint:Line(nLinFu,2300,nLinFu+xx,2300)
	nLinFu += xx
	nLinFu -= nDes
Endif

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDTR460Nat³ Autor ³ Vitor Emanuel Batista ³ Data ³26/06/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chama Tela para filtrar de acordo com a Natureza           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR460                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR460Nat()

Private lRET    := .T.
Private lFiltro := .F.
nNatureza       := 0

If mv_par11 = 1
	lFiltro := .T.
EndIf

If lFiltro
	Private oDlg, oRadio

	nNatureza := 1
	DEFINE MSDIALOG oDlg FROM  0,0 TO 195,320 TITLE STR0129 PIXEL  //"Filtro"

	@ 10,10 TO 79,150 LABEL STR0113 of oDlg Pixel //"Natureza do Exame"
	@ 20,14 RADIO oRadio VAR nNatureza ITEMS STR0108, STR0112, STR0111, STR0110, STR0109, STR0176 SIZE 80,15 PIXEL OF oDlg //"Admissional", "Demissional", "Retorno ao Trabalho", "Mudança de Função", "Periódico", "Monitoração Pontual"

	DEFINE SBUTTON FROM 83,90  TYPE 1 ENABLE OF oDlg ACTION EVAL({|| lRET := .T.,oDlg:END()})
	DEFINE SBUTTON FROM 83,120 TYPE 2 ENABLE OF oDlg ACTION EVAL({|| lRET := .F.,oDlg:END()})

	ACTIVATE MSDIALOG oDlg CENTERED

EndIf

Return lRET

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDT460FLVL³ Autor ³ Denis Hyroshi        ³ Data ³ 04/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os campos De/Ate Filial                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT460FLVL(nTipo)
Local lRet  := .T.
Local cArea := Alias()
Local aArea := SM0->(GetArea())

If nTipo == 1
	If !Empty(mv_par14)
		dbSelectArea("SM0")
		If !dbSeek(cEmpAnt+mv_par14)
			Help(" ",1,"REGNOIS")
			lRet := .F.
		Endif
		If mv_par14 > mv_par15
			mv_par15 := mv_par14
		Endif
	Endif
Else
	If mv_par15 <> Replicate("Z",Len(mv_par15)) .and. mv_par15 <> Replicate("9",Len(mv_par15))
		If mv_par14 > mv_par15
			Help(" ",1,"DEATEINVAL")
			lRet := .F.
		Else
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+mv_par15)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
		Endif
	Endif
Endif

RestArea(aArea)
dbSelectArea(cArea)

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} MDT460Loj
Função responsável por realizar a validação do SX1 Loja ?

@author Guilherme Freudenburg
@since 11/03/2016
/*/
//---------------------------------------------------------------------
User Function MDT460Loj()

Local aArea := GetArea()
Local lRet	:= .T.

If !Empty(Mv_par03)
	dbSelectArea("SA2")
	dbSetOrder(1)
	If !dbSeek(xFilial("SA2")+Mv_par02+Mv_par03)
		lRet := .F.
		ShowHelpDlg(STR0157,{STR0158},1,{STR0159},2)//"Atenção!"##"A Loja informada não condiz com o Fornecedor."##"Favor informar uma Loja existente para o Fornecedor."
	Endif
ELse
	If !Empty(Mv_par02)
		lRet := NaoVazio(Mv_par03)
	EndIf
Endif

RestArea(aArea)

Return lRet
