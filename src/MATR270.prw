/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR270.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR270  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.09.91 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Etiquetas para Inventario                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo Pim.³04/12/01³PYME  ³ Adequacao do fonte para utilizacao do    ³±±
±±³            ³        ³PYME  ³ Siga PyMe.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcos Hirak³28/04/05³XXXXXX³Imprimir B1_CODITE quando for gestao de   ³±±
±±³            ³        ³      ³Concessionarias ( MV_VEICULO = "S").      ³±±
±±³            ³        ³      ³foi retirado a variavel "cProdant"        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr270
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL titulo   := STR0001	//"Etiquetas para Inventario"
LOCAL cDesc1   := STR0002	//"Este programa ira emitir etiquetas para contagem do estoque."
LOCAL cDesc2   := STR0003	//"Sera emitido em 3 colunas para cada produto."
LOCAL cDesc3   := ""
LOCAL cString  := "SB1"
LOCAL wnrel    := "MATR270"
LOCAL aOrd     := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Local para SIGAVEI, SIGAPEC e SIGAOFI         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea1	:= Getarea()
 
/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ\¿
//³NA Gestão de concessionárias não será utilizado a ordem Por Localizacao Fisica   ³
//³por isso que não serão exibidos as perguntas mv_par15 - Localizacao Fisica De e  ³
//³mv_par16 - Localizacao Fisica Ate, através das variáveis lPymeSx1a e lT          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ\Ù
ENDDOC*/
Local lPymeSx1a:= __lPymeSx1 // Conteúdo do __lPymeSx1 antes de entrar nesse relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private para SIGAVEI, SIGAPEC e SIGAOFI       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private lVEIC		:= UPPER(GETMV("MV_VEICULO"))=="S"
Private aSB1Cod	:= {}
Private aSB1Ite	:= {}
Private cCABPROD  := ""
Private lT			:= .T.
                  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento da Ordem para utilizacao do Siga Pyme e           ³
//³ da Gestão de Concessionárias Tratamento, pois não tem o      ³
//³ conceito de Localizacao Fisica. Marcos Hirakawa              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If __lPyme
	lT := .F.
Else
	If lVEIC
		lT := .F.
  	Endif
Endif  	
If lT
	aOrd := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0026)}   //" Por Codigo         "###" Por Tipo           "###" Por Descricao    "###" Por Grupo        "###" Por Localizacao Fisica "
Else
	aOrd := {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006),OemToAnsi(STR0007)}   //" Por Codigo         "###" Por Tipo           "###" Por Descricao    "###" Por Grupo        "
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn:= { OemToAnsi(STR0008), 1,OemToAnsi(STR0009), 2, 2, 1, "",1 }    //"Zebrado"###"Administracao"
PRIVATE nLastKey := 0 ,cPerg := "MTR270"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Almox. de                                    ³
//³ mv_par02     // Almox. ate                                   ³
//³ mv_par03     // Produto de                                   ³
//³ mv_par04     // Produto ate                                  ³
//³ mv_par05     // tipo de                                      ³
//³ mv_par06     // tipo ate                                     ³
//³ mv_par07     // grupo de                                     ³
//³ mv_par08     // grupo ate                                    ³
//³ mv_par09     // descricao de                                 ³
//³ mv_par10     // descricao ate                                ³
//³ mv_par11     // Numero da primeira ficha                     ³
//³ mv_par12     // Data de Selecao de                           ³
//³ mv_par13     // Data de Selecao ate                          ³
//³ mv_par14     // Qual Ordem de Coluna                         ³
//³ mv_par15     // Localizacao Fisica De                        ³
//³ mv_par16     // Localizacao Fisica Ate                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd)

dbSelectArea("SB1")
If nLastKey = 27
	dbClearFilter()
	__lPymeSx1	:= lPymeSx1a // volta com a situação do __lPymeSx1 anterior.
	Return
Endif

SetDefault(aReturn,cString)

dbSelectArea("SB1")
If nLastKey = 27
	dbClearFilter()
	__lPymeSx1	:= lPymeSx1a // volta com a situação do __lPymeSx1 anterior.
	Return
Endif

//  lT -> .T. = Por Localizacao Fisica
lT := iif(aReturn[8] == 5, .T., .F.) 

titulo	:= ALLTRIM(titulo) + ' - ' + alltrim(aOrd[aReturn[8]])

If aReturn[8] == 5
	RptStatus({|lEnd| U_A270ImpEnd(aOrd,@lEnd,wnrel,cString,titulo)},titulo)
Else
	RptStatus({|lEnd| C270Imp(aOrd,@lEnd,wnrel,cString,titulo)},titulo)
Endif

__lPymeSx1	:= lPymeSx1a // volta com a situação do __lPymeSx1 anterior.
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C270IMP  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 11.12.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR270			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function C270Imp(aOrd,lEnd,wnrel,cString,titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cLinha,cLinha1,cColuna,nNum
LOCAL nTipo := 0
LOCAL cOrd  := ""
LOCAL cLocal,cLocaliz
LOCAL nC	:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Local para SIGAVEI, SIGAPEC e SIGAOFI         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
local cArq1 := "" 
local nInd1 := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contador de linha                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li		:= 80
PRIVATE limite	:= 132

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis privadas exclusivas deste programa                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCondicao,lContinua,cCondSB

dbSelectArea("SB1")
SetRegua(LastRec())

Set Softseek On
dbSetOrder(aReturn[8])
//     " Por Codigo 1
// "###" Por Tipo   2
// "###" Por Descricao 3
// "###" Por Grupo     4
// "###" Por Localizacao Fisica "
If aReturn[8] == 4
   if lVeic
		dbSetOrder(7) // B1_FILIAL+B1_GRUPO+B1_CODITE
   endif
	Seek cFilial+mv_par07
	cCondicao := "lContinua .And. !Eof() .And. B1_GRUPO <= mv_par08"
ElseIf aReturn[8] == 3
	Seek cFilial+mv_par09
	cCondicao := "lContinua .And. !Eof() .And. B1_DESC <= mv_par10"
ElseIf aReturn[8] == 2
   if lVeic
		cArq1	:= CRIATRAB(NIL,.F.)
	   INDREGUA("SB1",cArq1,"B1_FILIAL+B1_TIPO+B1_CODITE+B1_GRUPO")			//"Selecionando Registros..."
		nInd1:=RetIndex("SB1")
		dbSetOrder(nInd1 + 1)
		dbGoTop()
   ENDIF
	cCondicao := "lContinua .And. !Eof() .And. B1_TIPO <= mv_par06"
	Seek cFilial+mv_par05
Else
   if ! lVeic
		dbSetOrder(1)
		cCondicao := "lContinua .And. !Eof() .And. B1_COD <= mv_par04"
	else
		cCondicao := "lContinua .And. !Eof() .And. B1_CODITE <= mv_par04"
		cArq1	:= CRIATRAB(NIL,.F.)
	   INDREGUA("SB1",cArq1,"B1_FILIAL+B1_CODITE+B1_GRUPO")			//"Selecionando Registros..."
		nInd1:=RetIndex("SB1")
		dbSetOrder(nInd1 + 1)
		dbGoTop()
	endif
	Seek cFilial+mv_par03
Endif
Set SoftSeek Off

cLinha  := "|"+Replicate("-",128)+"|"
cLinha1 := Replicate("=",130)
cColuna := "|"+Space(42)+"|"+Space(42)+"|"+Space(42)+"|"
lContinua := .T.
nNum := mv_par11

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 PSay AvalImp(Limite)

While &cCondicao .and. B1_FILIAL == cFilial

	If lEnd
		@ PROW()+1,001 PSay OemToAnsi(STR0010)   //"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	IncRegua()

   If ! lVeic  
		If B1_COD < mv_par03 .Or. B1_COD > mv_par04
			dbSkip()
			Loop
		EndIf
   Else
		If B1_CODITE < mv_par03 .Or. B1_CODITE > mv_par04
			dbSkip()
			Loop
		EndIf
	EndIf
	If B1_TIPO < mv_par05 .Or. B1_TIPO > mv_par06
		dbSkip()
		Loop
	EndIf
	
	If B1_GRUPO < mv_par07 .Or. B1_GRUPO > mv_par08
	   dbSkip()
	   Loop
	EndIf

	If B1_DESC < mv_par09 .Or. B1_DESC > mv_par10
	   dbSkip()
	   Loop
	EndIf

	If !__lPyme .And. aReturn[8] == 5
		If B1_LOCALIZ # "S" 
			dbSkip()
			Loop
		EndIf
	EndIf

	If aReturn[8] == 5
 	 	dbSelectArea("SBF")
 	 	dbSetOrder(2)
		dbSeek(cFilial+SB1->B1_COD)
		cCondSB := "BF_FILIAL+BF_PRODUTO"
	Else         
 	 	dbSelectArea("SB2")
		dbSeek(cFilial+SB1->B1_COD)
		cCondSB := "B2_FILIAL+B2_COD"
 	EndIf	

	If EOF()    
  		dbSelectArea("SB1")
		dbSkip()
		Loop
	EndIf

	While !EOF() .And. &cCondSB == xFilial()+SB1->B1_COD
	
		If lEnd
			@ PROW()+1,001 PSay OemToAnsi(STR0010)	//"CANCELADO PELO OPERADOR"
			lContinua := .F.
			Exit
		EndIf

		If Li > 50
			Li := 3
		EndIf

		If aReturn[8] == 5 .And. ! __lPyme 
			If BF_LOCALIZ < mv_par15 .Or. BF_LOCALIZ > mv_par16
				dbSkip()
				Loop
			EndIf	
 	 		dbSelectArea("SB2")
			dbSeek(cFilial+SB1->B1_COD+SBF->BF_LOCAL)
		EndIf	

		If !Empty(SB2->B2_DINVENT)
			If (SB2->B2_DINVENT + SB1->B1_PERINV) < mv_par12 .Or. (SB2->B2_DINVENT + SB1->B1_PERINV) > mv_par13
				If(aReturn[8] == 5,dbSelectArea("SBF"),"")
				dbSkip()
				Loop
			Endif
		EndIf

		If B2_LOCAL < mv_par01 .Or. B2_LOCAL > mv_par02
			If(aReturn[8] == 5,dbSelectArea("SBF"),"")
			dbSkip()
			Loop
		EndIf
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Verifica se tem saldo (mv_par17 = 1-com saldo/2-sem saldo/3-AmBos) ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      If (mv_par17 == 1 .And. B2_QATU <= 0) .Or. (mv_par17 == 2 .And. B2_QATU > 0)
         dbSkip()
         Loop
      EndIf
			
		@ Li,000 PSay cLinha
		Li++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemtoAnsi(STR0023)   //   "|          A-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemtoAnsi(STR0024)   //   "|          B-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemtoAnsi(STR0025)   //   "|          C-INVENTARIO No. "
			Endif
			If nC == 1
				@ Li,000 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 2	
				@ Li,043 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 3
				@ Li,086 PSay cOrd+StrZero(nNum,6)
			Endif	
		Next nC
		@ Li,129 PSay "|"
		dbSelectArea("SB1")
		Li++

		IF !lVEIC
			@ Li,000 PSay cColuna
		ELSE
			cCABPROD	:= SUBSTR("[ " + B1_CODITE + " ]" + SPACE(42),1,42)
			// cColuna := "|"+Space(42)+"|"+Space(42)+"|"+Space(42)+"|"
			@ Li,000 PSay "|" + cCABPROD + "|" + cCABPROD + "|" + cCABPROD + "|"
		ENDIF	

		Li++
		@ Li,000 PSay "|"+Replicate(' '+OemToAnsi(STR0011)+' '+PADR(B1_COD,30)+Space(3)+"|",3)
		Li++
		@ Li,000 PSay OemToAnsi(STR0015)+SubStr(B1_DESC,1,30)   //"|Descri.: "
		@ Li,043 PSay OemToAnsi(STR0015)+SubStr(B1_DESC,1,30)   //"|Descri.: "
		@ Li,086 PSay OemToAnsi(STR0015)+SubStr(B1_DESC,1,30)   //"|Descri.: "
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay "|"+replicate(OemToAnsi(STR0012)+B1_TIPO+OemToAnsi(STR0013)+B1_GRUPO+OemToAnsi(STR0014)+B1_UM+Space(22)+"|",3) //" Tp:"###" Gr:"###" Um:"
        Li++
		If aReturn[8] == 5
			dbSelectArea("SBF")
			cLocal   := BF_LOCAL
			cLocaliz := BF_LOCALIZ
		Else
			dbSelectArea("SB2")
			cLocal   := B2_LOCAL
			cLocaliz := Posicione("NNR",1,xFilial("NNR")+B2_LOCAL,"NNR_DESCRI")
		EndIf	
		@ Li,000 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao :"
		@ Li,043 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao :"    
		@ Li,086 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao :"
			  
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemToAnsi(STR0018)	//"| Data da 1a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemToAnsi(STR0019)	//"| Data da 2a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemToAnsi(STR0020)	//"| Data da 3a. contagem : ____/____/____"
			Endif
			If nC == 1
				@ Li,000 PSay cOrd
			ElseIf nC == 2	
				@ Li,043 PSay cOrd
			ElseIf nC == 3
				@ Li,086 PSay cOrd
			Endif	
		Next nC
		@ Li,129 PSay "|"
		Li++
//		@ Li,000 PSay cLinha
//		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,043 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,086 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay "|"+Replicate(" -------------------- ------------------- |",3)
		Li++
		@ Li,000 PSay "|"+Replicate(OemToAnsi(STR0022),3)    //"  Visto funcionario     Visto Conferente  |"
		Li++
		@ Li,000 PSay cLinha
		Li += 2
		@ Li,000 PSay cLinha1
		Li += 2
		nNum++
		If aReturn[8] == 5
 			dbSelectArea("SBF")
 		Else	
			dbSelectArea("SB2")
		EndIf	
		dbSkip()
	EndDo
	dbSelectArea("SB1")
	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
RetIndex("SB1")
Set Filter To 
dbSetOrder(1)

If File(cArq1+OrdBagExt())
	Ferase(cArq1+OrdBagExt())
EndIf

If aReturn[5] = 1
	Set Printer TO 
	Commit
	OurSpool(wnrel)
Endif

MS_FLUSH()
RETURN

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MR270Ord  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 29/10/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se os nrs estao entre 1 e 3.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR270                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MR270Ord()
LOCAL nC,cVar:=&(ReadVar())
For nC:= 1 To 3
	If Val(Subs(cVar,nC,1)) > 3
		Help(" ",1,".MTR27014.")
		Return .F.
	Endif
Next
Return .T.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A270ImpEnd³ Autor ³ Marcos Daniel         ³ Data ³ 09/12/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime as etiquetas por endereco                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR270                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function A270ImpEnd(aOrd,lEnd,wnRel,cString,Titulo)

LOCAL cLinha	:= "|"+Replicate("-",128)+"|"
LOCAL cLinha1	:= Replicate("=",130)
LOCAL cColuna	:= "|"+Space(42)+"|"+Space(42)+"|"+Space(42)+"|"
LOCAL nNum		:= MV_PAR11
LOCAL cOrd		:= ""
LOCAL nC		:= 0
LOCAL lQuery    := .F.
LOCAL cAliasSBF := ""
LOCAL cQuery    := ""

PRIVATE li		:= 80
PRIVATE limite	:= 132

dbSelectArea("SB1")
dbSetOrder(1)

dbSelectArea("SBF")
dbSetOrder(1)

SetRegua(LastRec())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se tem saldo (mv_par17 = 1-com saldo/2-sem saldo/3-AmBos) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par17 <> 2 //Com saldo ou Ambos

	cAliasSBF := GetNextAlias()
	cQuery    := ""
	lQuery    := .T.
	
	cQuery += "SELECT BF_LOCAL, BF_LOCALIZ, BF_PRODUTO, B1_TIPO, B1_GRUPO, B1_UM, B1_DESC, B1_PERINV  "
	cQuery += "FROM " + RetSqlName( "SBF" ) + " SBF "
	cQuery += ", " + RetSqlName( "SBE" ) + " SBE "
	cQuery += ", " + RetSqlName( "SB1" ) + " SB1 "
	cQuery += "WHERE "
	cQuery += "BF_FILIAL ='" + xFilial( "SBF" ) + "' AND "
	cQuery += "BF_LOCAL   >= '" + mv_par01 + "' AND "
	cQuery += "BF_LOCAL   <= '" + mv_par02 + "' AND "
	cQuery += "BF_PRODUTO >= '" + mv_par03 + "' AND "
	cQuery += "BF_PRODUTO <= '" + mv_par04 + "' AND "
	If ! __lPyme 
		cQuery += "BF_LOCALIZ >= '" + mv_par15 + "' AND "
		cQuery += "BF_LOCALIZ <= '" + mv_par16 + "' AND "
	Endif	
	cQuery += "SBF.D_E_L_E_T_=' ' AND "
	cQuery += "BE_FILIAL='" + xFilial( "SBE" ) + "' AND "
	cQuery += "BE_LOCAL = BF_LOCAL AND "
	cQuery += "BE_LOCALIZ = BF_LOCALIZ AND "
	cQuery += "SBE.D_E_L_E_T_=' ' AND "
	cQuery += "B1_FILIAL='" + xFilial( "SB1" ) + "' AND "
	cQuery += "B1_COD = BF_PRODUTO AND "
	cQuery += "B1_TIPO >= '" + mv_par05 + "' AND "
	cQuery += "B1_TIPO <= '" + mv_par06 + "' AND "				
	cQuery += "B1_GRUPO >= '" + mv_par07 + "' AND "
	cQuery += "B1_GRUPO <= '" + mv_par08 + "' AND "								
	cQuery += "B1_DESC >= '" + mv_par09 + "' AND "
	cQuery += "B1_DESC <= '" + mv_par10 + "' AND "								
	If !__lPyme
		cQuery += "B1_LOCALIZ = 'S' AND "
	Endif
	cQuery += "SB1.D_E_L_E_T_=' ' "
	cQuery += "ORDER BY BF_LOCALIZ " //ordena por enderecos
	
	cQuery := ChangeQuery( cQuery )
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSBF,.F.,.T. )

	While (cAliasSBF)->(!Eof()) 
		
		If lEnd
			@ PROW()+1,001 PSay OemToAnsi(STR0010)   //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	
		IncRegua()
		
		If Li > 50
			Li := 3
		EndIf
	
		dbSelectArea("SB2")
		dbSeek(cFilial+(cAliasSBF)->BF_PRODUTO+(cAliasSBF)->BF_LOCAL)
		
		If !Empty(SB2->B2_DINVENT)
			If (SB2->B2_DINVENT + IIF(lQuery,(cAliasSBF)->B1_PERINV,SB1->B1_PERINV)) < mv_par12 .Or. (SB2->B2_DINVENT + IIF(lQuery,(cAliasSBF)->B1_PERINV,SB1->B1_PERINV)) > mv_par13
				dbSelectArea(cAliasSBF)
				(cAliasSBF)->(dbSkip())
				Loop
			Endif
		EndIf		
		
		If SB2->B2_LOCAL < mv_par01 .Or. SB2->B2_LOCAL > mv_par02
			dbSelectArea(cAliasSBF)
			(cAliasSBF)->(dbSkip())
			Loop
		EndIf
		
		@ Li,000 PSay cLinha
		Li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemtoAnsi(STR0023)   //   "|          A-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemtoAnsi(STR0024)   //   "|          B-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemtoAnsi(STR0025)   //   "|          C-INVENTARIO No. "
			Endif
			If nC == 1
				@ Li,000 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 2
				@ Li,043 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 3
				@ Li,086 PSay cOrd+StrZero(nNum,6)
			Endif
		Next nC
		@ Li,129 PSay "|"
		
		Li++
		@ Li,000 PSay cColuna
		Li++   
		
		
		@ Li,000 PSay "|"+Replicate(' '+OemToAnsi(STR0011)+' '+PADR((cAliasSBF)->BF_PRODUTO,30)+Space(3)+"|",3)//"Codigo:"###"
		
		Li++
		@ Li,000 PSay OemToAnsi(STR0015)+SubStr((cAliasSBF)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,043 PSay OemToAnsi(STR0015)+SubStr((cAliasSBF)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,086 PSay OemToAnsi(STR0015)+SubStr((cAliasSBF)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,129 PSay "|"		
		Li++
		@ Li,000 PSay "|"+Replicate(OemToAnsi(STR0012)+(cAliasSBF)->B1_TIPO+OemToAnsi(STR0013)+(cAliasSBF)->B1_GRUPO+OemToAnsi(STR0014)+(cAliasSBF)->B1_UM+Space(22)+"|",3) //" Tp:"###" Gr:"###" Um:"						
		Li++
		
		cLocal   := (cAliasSBF)->BF_LOCAL
		cLocaliz := (cAliasSBF)->BF_LOCALIZ
		
		@ Li,000 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao : "
		@ Li,043 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao : "
		@ Li,086 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+SubStr(cLocaliz,1,15)    //"|Almox..: "###" Localizacao : "
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemToAnsi(STR0018)	//"| Data da 1a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemToAnsi(STR0019)	//"| Data da 2a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemToAnsi(STR0020)	//"| Data da 3a. contagem : ____/____/____"
			Endif
			If nC == 1
				@ Li,000 PSay cOrd
			ElseIf nC == 2
				@ Li,043 PSay cOrd
			ElseIf nC == 3
				@ Li,086 PSay cOrd
			Endif
		Next nC
		@ Li,129 PSay "|"
		Li++
//		@ Li,000 PSay cLinha
//		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,043 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,086 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay "|"+Replicate(" -------------------- ------------------- |",3)
		Li++
		@ Li,000 PSay "|"+Replicate(OemToAnsi(STR0022),3)    //"  Visto funcionario     Visto Conferente  |"
		Li++
		@ Li,000 PSay cLinha
		Li += 2
		@ Li,000 PSay cLinha1
		Li += 2
		nNum++
			
		dbSelectArea(cAliasSBF)
		dbSkip()
	EndDo
	
	If lQuery
		dbSelectArea(cAliasSBF)
		dbCloseArea()
	Else
		RetIndex("SBF")
		dbClearFilter()
		Ferase(cArqInd+OrdBagExt())
	Endif	
	dbSelectArea("SBF")
	dbSetOrder(1)
Endif	

If mv_par17 <> 1 //Sem Saldo que houve movimentacao no periodo selecionado

	dbSelectArea("SDB")
	dbSetOrder(1)
	SetRegua(LastRec())
	
	aDados := {}

	cAliasSDB := GetNextAlias()
	cQuery    := ""
	lQuery    := .T.

	cQuery += "SELECT DISTINCT(DB_PRODUTO), DB_LOCAL, B1_TIPO, B1_GRUPO, B1_UM, B1_DESC, B1_PERINV  "		
	cQuery += "FROM " + RetSqlName( "SDB" ) + " SDB "
	cQuery += ", " + RetSqlName( "SBE" ) + " SBE "
	cQuery += ", " + RetSqlName( "SB1" ) + " SB1 "
	cQuery += "WHERE "
	cQuery += "DB_FILIAL ='" + xFilial( "SDB" ) + "' AND "
	cQuery += "DB_LOCAL   >= '" + mv_par01 + "' AND "
	cQuery += "DB_LOCAL   <= '" + mv_par02 + "' AND "
	cQuery += "DB_PRODUTO >= '" + mv_par03 + "' AND "
	cQuery += "DB_PRODUTO <= '" + mv_par04 + "' AND "
	cQuery += "DB_DATA >= '" + DTOS(mv_par12) + "' AND "
	cQuery += "DB_DATA <= '" + DTOS(mv_par13) + "' AND "					
	If ! __lPyme 
		cQuery += "DB_LOCALIZ >= '" + mv_par15 + "' AND "
		cQuery += "DB_LOCALIZ <= '" + mv_par16 + "' AND "
	Endif	
	cQuery += "SDB.D_E_L_E_T_=' ' AND "
	cQuery += "BE_FILIAL='" + xFilial( "SBE" ) + "' AND "
	cQuery += "BE_LOCAL = DB_LOCAL AND "
	cQuery += "BE_LOCALIZ = DB_LOCALIZ AND "
	cQuery += "SBE.D_E_L_E_T_=' ' AND "
	cQuery += "B1_FILIAL='" + xFilial( "SB1" ) + "' AND "
	cQuery += "B1_COD = DB_PRODUTO AND "
	cQuery += "B1_TIPO >= '" + mv_par05 + "' AND "
	cQuery += "B1_TIPO <= '" + mv_par06 + "' AND "				
	cQuery += "B1_GRUPO >= '" + mv_par07 + "' AND "
	cQuery += "B1_GRUPO <= '" + mv_par08 + "' AND "								
	cQuery += "B1_DESC >= '" + mv_par09 + "' AND "
	cQuery += "B1_DESC <= '" + mv_par10 + "' AND "								
	If !__lPyme
		cQuery += "B1_LOCALIZ = 'S' AND "
	Endif
	cQuery += "SB1.D_E_L_E_T_=' ' AND "
	
	cQuery += "NOT EXISTS ( SELECT 1 "
	cQuery += "FROM " + RetSqlName( "SBF" ) + " SBF "
	cQuery += "WHERE "
	cQuery += "BF_FILIAL='" + xFilial( "SBF" ) + "' AND "
	cQuery +=" BF_PRODUTO = DB_PRODUTO AND "
	cQuery += "BF_LOCAL = DB_LOCAL AND "
	cQuery += "BF_LOCALIZ = DB_LOCALIZ AND "
	cQuery += "SBF.D_E_L_E_T_=' ' ) "
	
	cQuery := ChangeQuery( cQuery )
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSDB,.F.,.T. )

	
	While (cAliasSDB)->(!Eof())
		If lEnd
			@ PROW()+1,001 PSay OemToAnsi(STR0010)   //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	
		IncRegua()

		If Li > 50
			Li := 3
		EndIf
	
		dbSelectArea("SB2")
		dbSeek(cFilial+(cAliasSDB)->DB_PRODUTO+(cAliasSDB)->DB_LOCAL)
		
		If !Empty(SB2->B2_DINVENT)
			If (SB2->B2_DINVENT + IIF(lQuery,(cAliasSDB)->B1_PERINV,SB1->B1_PERINV)) < mv_par12 .Or. (SB2->B2_DINVENT + IIF(lQuery,(cAliasSDB)->B1_PERINV,SB1->B1_PERINV)) > mv_par13
				dbSelectArea(cAliasSDB)
				(cAliasSDB)->(dbSkip())
				Loop
			Endif
		EndIf		
		
		If SB2->B2_LOCAL < mv_par01 .Or. SB2->B2_LOCAL > mv_par02
			dbSelectArea(cAliasSDB)
			(cAliasSDB)->(dbSkip())
			Loop
		EndIf
		
		@ Li,000 PSay cLinha
		Li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemtoAnsi(STR0023)   //   "|          A-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemtoAnsi(STR0024)   //   "|          B-INVENTARIO No. "
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemtoAnsi(STR0025)   //   "|          C-INVENTARIO No. "
			Endif
			If nC == 1
				@ Li,000 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 2
				@ Li,043 PSay cOrd+StrZero(nNum,6)
			ElseIf nC == 3
				@ Li,086 PSay cOrd+StrZero(nNum,6)
			Endif
		Next nC
		@ Li,129 PSay "|"
		
		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay "|"+Replicate(' '+OemToAnsi(STR0011)+' '+PADR((cAliasSDB)->DB_PRODUTO,30)+Space(3)+"|",3)//"Codigo:"###"
		Li++
		@ Li,000 PSay OemToAnsi(STR0015)+SubStr((cAliasSDB)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,043 PSay OemToAnsi(STR0015)+SubStr((cAliasSDB)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,086 PSay OemToAnsi(STR0015)+SubStr((cAliasSDB)->B1_DESC,1,33)   //"|Descri.: "
		@ Li,129 PSay "|"		
		Li++
		@ Li,000 PSay "|"+Replicate(OemToAnsi(STR0012)+(cAliasSDB)->B1_TIPO+OemToAnsi(STR0013)+(cAliasSDB)->B1_GRUPO+OemToAnsi(STR0014)+(cAliasSDB)->B1_UM+"|",3)  //" Tp:"###" Gr:"###" Um:"						
		Li++
		
		cLocal   := (cAliasSDB)->DB_LOCAL
		
		@ Li,000 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+Space(15)   //"|Almox..: "###" Localizacao : "
		@ Li,043 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+Space(15)   //"|Almox..: "###" Localizacao : "
		@ Li,086 PSay OemToAnsi(STR0016)+cLocal+OemToAnsi(STR0017)+Space(15)   //"|Almox..: "###" Localizacao : "
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz a mudanca da ordem selecionada pelo mv_par14.       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nC:= 1 To 3
			If Val(Subs(mv_par14,nC,1)) == 1
				cOrd:= OemToAnsi(STR0018)	//"| Data da 1a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 2
				cOrd:= OemToAnsi(STR0019)	//"| Data da 2a. contagem : ____/____/____"
			ElseIf Val(Subs(mv_par14,nC,1)) == 3
				cOrd:= OemToAnsi(STR0020)	//"| Data da 3a. contagem : ____/____/____"
			Endif
			If nC == 1
				@ Li,000 PSay cOrd
			ElseIf nC == 2
				@ Li,043 PSay cOrd
			ElseIf nC == 3
				@ Li,086 PSay cOrd
			Endif
		Next nC
		@ Li,129 PSay "|"
		Li++
//		@ Li,000 PSay cLinha
//		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,043 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,086 PSay OemToAnsi(STR0021)	//"| Quantidade apurada:"
		@ Li,129 PSay "|"
		Li++
		@ Li,000 PSay cLinha
		Li++
		@ Li,000 PSay cColuna
		Li++
		@ Li,000 PSay "|"+Replicate(" -------------------- ------------------- |",3)
		Li++
		@ Li,000 PSay "|"+Replicate(OemToAnsi(STR0022),3)    //"  Visto funcionario     Visto Conferente  |"
		Li++
		@ Li,000 PSay cLinha
		Li += 2
		@ Li,000 PSay cLinha1
		Li += 2
		nNum++	

		dbSelectArea(cAliasSDB)
		dbSkip()
	EndDo   	   	
	If lQuery
		dbSelectArea(cAliasSDB)
		dbCloseArea()
	Else
		RetIndex("SDB")
		dbClearFilter()
		Ferase(cArqInd+OrdBagExt())
	Endif	
	dbSelectArea("SDB")
	dbSetOrder(1)	
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cString)
dbClearFilter() 
dbSetOrder(1)

If aReturn[5] = 1
	Set Printer TO 
	Commit
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return