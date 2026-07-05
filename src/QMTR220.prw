/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ IMPORTANTE: A vari vel aFim que est  sendo utilizada como    ³
//³ private, dever  ser passada por parƒmetro em implementa‡”es  ³
//³ futuras nas fun‡”es a150calrr e a150currr                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#INCLUDE "QMTR220.Ch"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR220  ³ Autor ³ Wanderley Goncalves   ³ Data ³ 09.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resultado Individual de R&R                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QMTR220(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR220()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1   :=OemToAnsi( STR0001 ) // "Este programa ira emitir o"
Local cDesc2   :=OemToAnsi( STR0002 ) // "Resultado Individual de Repe/Repro."
Local cDesc3   :=""
Local wnrel
Local lImpLin2 := .T.
Local cString  :="QM2"

Private titulo
Private cabec1    := ""
Private cabec2    := ""
Private aReturn   := { OemToAnsi( STR0003 ), 1,OemToAnsi( STR0004 ), 1, 2, 1, "",1 } // "Zebrado"###"Administra‡„o"
Private nomeprog  :="QMTR220"
Private nLastKey  := 0
Private cPerg     :="QMR220"
Private cTamanho := "M"
Private nPosEns  // Posicao do Ensaiador na aCols
Private nPosCic  // Posicao do Ciclo na aCols
Private nPosPec  // Posicao da Peca na aCols
Private nPosAtr  // Posicao do Atributo na aCols
Private nPosali  // Posicao do Alias do Arquivo
Private nPosrec  // Posicao do Recno do registro
Private bCampo := { |nField| Field(nField) }
Private aResult := {}
Private aTabela := {}
Private aFIM := {} // Guarda resultados na array para impressao
Private cQM5Tmp
Private amger := {}
Private aNMedp := {}
Private aCols := {}
Private aHeader := {}
Private cPicts	:= ""
Private cQM5ATP
Private Inclui := .F.
Private nTraco := 0
Private nRefere := 0
Private nCodig	:= 0
Private nVlrRef	:= 0
Private aUseRef := {}
Private nVlRef := 0
Private	cPicture := " "

If AllTrim(FunName()) <> AllTrim("QMTA150")
	ALTERA := .F.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR220",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ vARIAVEIS UTILIZADAS PARA PARAMETROS                            ³
//³ mv_par01            // Instrumento Inicial                      ³
//³ mv_par02            // Instrumento Final                        ³
//³ mv_par03            // Periodo Inicial                          ³
//³ mv_par04            // Periodo Final                            ³
//³ mv_par05            // Departamento Inicial                     ³
//³ mv_par06            // Departamento Final                       ³
//³ mv_par07            // Familia                                  ³
//³ mv_par08            // Usuario                                  ³
//³ mv_par09            // Fabricante                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ vARIAVEIS UTILIZADAS PARA PARAMETROS                            ³
//³ mv_par01            // Instrumento Inicial                      ³
//³ mv_par02            // Instrumento Final                        ³
//³ mv_par03            // Periodo Inicial                          ³
//³ mv_par04            // Periodo Final                            ³
//³ mv_par05            // Departamento Inicial                     ³
//³ mv_par06            // Departamento Final                       ³
//³ mv_par07            // Familia de                               ³
//³ mv_par08            // Familia ate                              ³
//³ mv_par09            // Usuario de                               ³
//³ mv_par10            // Usuario ate                              ³
//³ mv_par11            // Fabricante de                            ³
//³ mv_par12            // Fabricante ate                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

titulo := OemToAnsi( STR0041 ) //"REPETITIVIDADE / REPRODUTIBILIDADE"
cabec1 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR220"            //Nome Default do relatorio em Disco

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,cTamanho)

If nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
   Return
Endif

RptStatus({|lEnd| MTR220Imp(@lEnd,wnRel,cString,lImpLin2)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR220IMP³ Autor ³ Wanderley Goncalves   ³ Data ³ 08.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Seleciona Registro e imprime resultado                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR220IMP(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function MTR220Imp(lEnd,wnRel,cString,lImpLin2)

Local nOrder      := IndexOrd()
Local cAlias      := Alias()
Local cChave
Private	TRB_INSTR
Private	TRB_REVINS
Private	TRB_TIPO
Private	TRB_RESP
Private	TRB_DEPTO
Private	TRB_FABR
Private	TRB_VALREP
Private	TRB_TIPQM4
Private	TRB_NENSR
Private	TRB_NCICLO
Private	TRB_NPECAS
Private	TRB_LIE
Private	TRB_LSE
Private	TRB_PECA
Private	TRB_CARACT
Private	TRB_NUMERO
Private	TRB_UM
Private TRB_STATUS
Private TRB_TPMSA
Private TRB_TPATR
Private TRB_TOLESP
Private li
Private nCol
Private cTitIns		:= TitSx3("QM2_INSTR")[1]
Private cTitEsc		:= TitSx3("QM2_TIPO")[1]
Private cTitPeca	:= TitSx3("QM4_PECA")[1]
Private cTitCarac	:= TitSx3("QM4_CARACT")[1]
Private cTitNum		:= TitSx3("QM4_NUMERO")[1]
Private nTamRa		:= TamSx3("QAA_MAT")[1]
Private lExist		:= .T.
Private nCtUser		:= 0
Private lNoImprs	:= .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbTxt    := SPACE(10)
cbCont   := 0
li       := 80
m_pag    := 1

SetRegua(RecCount())

cChave := "QM4_FILIAL+QM4_INSTR+QM4_REVINS+QM4_DATA"
cQuery := "SELECT QM4_FILIAL,QM4_INSTR,QM4_REVINS,QM4_DATA,QM4_NENSR,QM4_NCICLO,QM4_NPECAS,"
cQuery += "QM4_LIE,QM4_PECA,QM4_CARACT,QM4_NUMERO,QM4_UM,QM4_LSE,QM4_TIPO,QM4_HORA,"
cQuery += "QM4_TPMSA,QM4_TPATR,QM4_TOLESP,"
cQuery += "QM2_FILIAL,QM2_INSTR,QM2_REVINS,QM2_REVINV,QM2_DEPTO,QM2_TIPO,QM2_STATUS,QM2_REVINV,"
cQuery += "QM2_DEPTO,QM2_TIPO,QM2_VALREP,QM2_FABR,QM2_RESP "
cQuery += "FROM "+RetSqlName("QM4")+ " QM4, "
cQuery += RetSqlName("QM2") + " QM2 "
cQuery += "WHERE "
cQuery += "QM4.QM4_FILIAL = '"			+xFilial("QM4")+	"' AND "
cQuery += "QM2.QM2_FILIAL = QM4.QM4_FILIAL AND "
cQuery += "QM2.QM2_INSTR  = QM4.QM4_INSTR AND "
cQuery += "QM2.QM2_REVINS = QM4.QM4_REVINS AND "
cQuery += "QM2.QM2_INSTR  BetWeen '"	+ mv_par01 +		"' AND '" + mv_par02 +			"' AND "
cQuery += "QM4.QM4_DATA   BetWeen '"	+ Dtos(mv_par03)+	"' AND '" + DtoS(mv_par04) +	"' AND "
cQuery += "QM2.QM2_DEPTO  BetWeen '"	+ mv_par05 +		"' AND '" + mv_par06 + 			"' AND "
cQuery += "QM2.QM2_TIPO   BetWeen '"	+ mv_par07 +		"' AND '" + mv_par08 + 			"' AND "
cQuery += "QM2.QM2_FABR   BetWeen '"	+ mv_par11 +		"' AND '" + mv_par12 + 			"' AND "
cQuery += "QM2.QM2_RESP   BetWeen '"	+ mv_par09 +		"' AND '" + mv_par10 + 			"' AND "
cQuery += "QM4.D_E_L_E_T_= ' ' "+ " AND " +"QM2.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY " + SqlOrder(cChave)

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QM4_DATA","D",8,0)
TcSetField("TRB","QM2_VALREP","D",8,0)

dbSelectArea( "TRB" )

Do While !Eof()

    IF lEnd
      li++
      @li  ,001 PSAY OemToAnsi(STR0005)  //"CANCELADO PELO OPERADOR"
      EXIT
   ENDIF

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Selecao de registros (Posiciona no QM2)                      ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	TRB_INSTR	:= TRB->QM2_INSTR
    TRB_REVINS	:= TRB->QM2_REVINS
	TRB_FABR	:= TRB->QM2_FABR
	TRB_STATUS	:= TRB->QM2_STATUS
	TRB_VALREP	:= TRB->QM2_VALREP
	TRB_TIPQM4	:= TRB->QM4_TIPO
	TRB_NENSR	:= TRB->QM4_NENSR
	TRB_NCICLO	:= TRB->QM4_NCICLO
	TRB_NPECAS	:= TRB->QM4_NPECAS
	TRB_LIE		:= TRB->QM4_LIE
	TRB_LSE		:= TRB->QM4_LSE
	TRB_PECA	:= TRB->QM4_PECA
	TRB_CARACT	:= TRB->QM4_CARACT
	TRB_NUMERO	:= TRB->QM4_NUMERO
	TRB_UM		:= TRB->QM4_UM
	TRB_TIPO	:= TRB->QM2_TIPO
	TRB_DATA	:= TRB->QM4_DATA
	TRB_DEPTO	:= TRB->QM2_DEPTO
	TRB_RESP	:= TRB->QM2_RESP
	TRB_TPMSA	:= TRB->QM4_TPMSA
	TRB_TPATR	:= TRB->QM4_TPATR
	TRB_TOLESP  := TRB->QM4_TOLESP

	cPicture := QA_PICT("QM4_LIE",ALLTRIM(TRB->QM4_LIE)+"1")

	M->QM4_INSTR	:= TRB->QM2_INSTR
	M->QM4_REVINS	:= TRB->QM2_REVINS
	M->QM4_DATA		:= TRB->QM4_DATA
	M->QM4_HORA		:= TRB->QM4_HORA
	M->QM4_NENSR	:= TRB->QM4_NENSR
	M->QM4_NCICLO	:= TRB->QM4_NCICLO
	M->QM4_TIPO		:= TRB->QM4_TIPO
	M->QM4_NPECAS	:= TRB->QM4_NPECAS
	M->QM4_LIE		:= TRB->QM4_LIE
	M->QM4_LSE		:= TRB->QM4_LSE
	M->QM4_TPMSA	:= TRB->QM4_TPMSA
	M->QM4_TPATR	:= TRB->QM4_TPATR
	M->QM4_TOLESP	:= TRB->QM4_TOLESP

	If TRB_TIPQM4 == "A"
		If TRB_TPMSA $ "1|3"
			dbSkip()
			Loop
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se status do instrumento esta ativo                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If !QMTXSTAT(TRB_STATUS)
      dbskip()
      loop
   EndIf


   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impressao dos resgistros selecionados                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   IncRegua()

	If TRB_NPECAS == 2
		nTraco := 18
		cTamanho := "M"
	ElseIf TRB_NPECAS == 3
		nTraco := 19
		cTamanho := "M"
	ElseIf TRB_NPECAS == 4
		nTraco := 20
		cTamanho := "M"
	ElseIf TRB_NPECAS == 5
		nTraco := 21
		cTamanho := "M"
	ElseIf TRB_NPECAS == 6
		nTraco := 22
		cTamanho := "M"
	ElseIf TRB_NPECAS == 7
		nTraco := 23
		cTamanho := "M"
	ElseIf TRB_NPECAS == 8
		nTraco := 24
		cTamanho := "M"
	ElseIf TRB_NPECAS == 9
		nTraco := 25
		cTamanho := "M"
	ElseIf TRB_NPECAS == 10
		nTraco := 26
		cTamanho := "G"
	ElseIf TRB_NPECAS == 11
		nTraco := 27
		cTamanho := "G"
	ElseIf TRB_NPECAS == 12
		nTraco := 28
		cTamanho := "G"
	ElseIf TRB_NPECAS == 13
		nTraco := 29
		cTamanho := "G"
	ElseIf TRB_NPECAS == 14
		nTraco := 30
		cTamanho := "G"
	ElseIf TRB_NPECAS == 15
		nTraco := 31
		cTamanho := "G"
	Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Calcula R&R                                                  ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   aFim := {}
   
   dbSelectArea( "QM4" )
   dbSetOrder(1)
   If(dbSeek( xFilial("QM4")+TRB->QM2_INSTR+TRB->QM2_REVINS+DtoS(TRB->QM4_DATA)+TRB->QM4_HORA))
	   U_R220CalRR()
	   If lNoImprs
		   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³ Imprime R&R                                                  ³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		   U_R220ImpRR()
	
		   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³ Apaga arquivo temporario                                     ³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		   A150DelTmp()
		   A150DelATP()
		   aCols := {}
	   Endif
	
		DbSelectArea("TRB")
		DbSkip()
	
		li := 60
	EndIF

EndDo

DbCloseArea("TRB")

Roda( cbCont, cbTxt, cTamanho )

Set Device To Screen
Set Filter To
dbSelectArea(cAlias)
dbSetOrder(nOrder)

If aReturn[5] = 1
   Set Printer TO
   dbCommitall()
   ourspool(wnrel)
End
MS_FLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R220CALRR³ Autor ³ Wanderley Goncalves   ³ Data ³ 08.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula R&R para este tipo de relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220CALRR()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220CalRR()
Local nCntFor:= 1
Local lMonts := .F.
aResult	:= {}
amger		:= {}
aNMedp	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa as Variaveis                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lMonts := .T.

If lMonts
	dbSelectArea("QM4")
	For nCntFor:= 1 To FCount()
		M->&(EVAL(bCampo,nCntFor)) := FieldGet(nCntFor)
	Next nCntFor
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tabela de ensaiadores                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nCtUser := 0
A150TabEns()
If Len(aTabela) > 0 .and. nCtUser == TRB_NENSR

   If nModulo <> 47 .and. li > 54
      cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
      @ li  ,000 PSAY Repl("*",132)
      li+=2
      U_R220Cabec(.t.,.t.)
   Endif


	lNoImprs := .T.
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta aCols e aHeader                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aCols := {}
	A150Monta()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Guarda posicao dos elementos nos acols                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	a150PosCol()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Recupera medicoes cadastradas                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	a150Recup()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ As funcoes a150CalRR e a150CurRR atualizam os valores do     ³
	//³ array Private aFim                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If TRB_TIPQM4 $ "EP"
	   a150CalRR(.f.)
	ElseIf TRB_TIPQM4 == "C"
		a150CurRR(.f.)
	ElseIf TRB_TIPQM4 == "A"
		a150CalAtri(.f.)
	EndIf
Else
	lNoImprs := .F.
Endif

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R220IMPRR³ Autor ³ Wanderley Goncalves   ³ Data ³ 10.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime R&R Individual                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220CALRR()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220ImpRR()

If TRB_TIPQM4 $ "EP"
   U_R220MLong()
ElseIf TRB_TIPQM4 == "C"
	U_R220MCurt()
ElseIf TRB_TIPQM4 == "A"
	U_R220MAtrib()
EndIf

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R220MLong³ Autor ³ Wanderley Goncalves   ³ Data ³ 13.07.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime R&R Individual para metodo longo                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220MLong()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220MLong()

Local nTipoRR  := If(TRB_TIPQM4=='E',1,;
                  If(TRB_TIPQM4=="P",2,3 ) )
Local nCntFor3 := 1
Local nCntFor2 := 1
Local nCntFor4 := 1
Local nCntFor := 1
Local nX := 1
Local nMsa := Val(TRB_TPMSA)

QM5TMP->(DbGoTop())
nLETRA := 0
For nCntFor := 1 to TRB_NENSR
   li++

   QAA->(DbSetOrder(1))
   If QAA->(DbSeek(QM5TMP->QM5_FILRES+QM5TMP->QM5_ENSR))
      @ li  , 01 PSAY QM5TMP->QM5_ENSR + " - " + QAA->QAA_NOME
   Else
      @ li  , 01 PSAY QM5TMP->QM5_ENSR
   EndIf
   For nCntFor2 := 1 to TRB_NCICLO
      If li > 54
         cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
         @ li  ,000 PSAY Repl("*",132)
         li+=2
         U_R220Cabec(.t.,.t.)
      Endif
      li++
      @ li  ,07 PSAY StrZero(nCntFor2,2) + ' ' + '|'
      For nCntFor3 := 1 to TRB_NPECAS
          cNOME := "QM5TMP->PECA"+StrZero(nCntFor3,2)
           @ li  , pcol() PSAY &cNOME  PICTURE QA_PICT("QM4_LIE",TRB_LIE)
           @ li  , pcol() PSAY '|'
      Next nCntFor3
	  nColMedia := pCol()
      @ li  ,pcol() PSAY QM5TMP->MEDIA PICTURE QA_PICT("QM4_LIE",TRB_LIE)
      QM5TMP->(DbSkip())
   Next nCntFor2
   li++
   @ li  , 01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
   // Linha de medias
   li++
   @ li  ,01 PSAY subs(OemToAnsi(STR0006),1,9)  // 'Medias'
   @ li  ,10 PSAY '|'
   For nCntFor4 := 1 to TRB_NPECAS
       @ li  ,pcol() PSAY aResult[nCntFor4+TRB_NPECAS*(nCntFor-1),5];
                           PICTURE QA_PICT("QM4_LIE",TRB_LIE)
       @ li  ,pcol() PSAY '|'
   Next
   // Media das medias
   @ li  , nColMedia PSAY 'XB'+ chr(97+nLETRA)+' = '
   @ li  , pcol() PSAY amger[nCntFor,2] PICTURE QA_PICT("QM4_LIE",TRB_LIE)
   // Imprime linha de amplitude
   li++
   @ li  ,01 PSAY subs(OemToAnsi(STR0007),1,9)        // "Amplitude"
   @ li  ,10 PSAY '|'
   For nCntFor4 := 1 to TRB_NPECAS
       @ li  ,pcol() PSAY aResult[nCntFor4+TRB_NPECAS*(nCntFor-1),6];
                           PICTURE QA_PICT("QM4_LIE",TRB_LIE)
       @ li  ,pcol() PSAY '|'
   Next

   // Media de amplitudes
   @ li  , nColMedia PSAY 'RB'+ chr(97+nLETRA)+' = '
   @ li  , pcol() PSAY amger[nCntFor,1] PICTURE QA_PICT("QM4_LIE",TRB_LIE)
   li++
   @ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
   nLETRA++
Next

// Media da peca
li++
@ li  ,01 PSAY  subs(OemtoAnsi(STR0008),1,9)   //'Medias'
@ li  ,10 PSAY '|'
For nX := 1 to TRB_NPECAS
    @ li  , pcol() PSAY space(10)+'|'
Next

nXBB := 0
For nX := 1 to TRB_NENSR
    nXBB += amger[nX,2]
Next
nXBB := nXBB/TRB_NENSR
cPicts := q150MoPict(aFim[1,1],"TRB_LIE")
@ li  , nColMedia PSAY 'XBB = '
@ li  , pcol() PSAY nXBB PICTURE q150MoPict(nXBB,"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE)

li++
@ li  ,01 PSAY subs(OemtoAnsi(STR0009),1,9)  //'da Peca'
@ li  ,10 PSAY '|'
For nX := 1 to TRB_NPECAS
    @ li  ,pcol() PSAY aNMedp[nX] PICTURE QA_PICT("QM4_LIE",TRB_LIE)
    @ li  ,pcol() PSAY '|'
Next
@ li  ,nColMedia PSAY 'Rp  = '
@ li  ,pcol() PSAY aFim[1,6] PICTURE QA_PICT("QM4_LIE",TRB_LIE) // nrp
li++
@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
li++
li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0049))
li++
If nColMedia < 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif
li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0010)) // 'Media de todas as amplitudes (RBa+RBb+...)/# de avaliadores'
If nColMedia < 60
	nColMedia := 60
Endif
@ li  ,nColMedia PSAY '|' + 'RBB = '
@ li  ,pcol() PSAY aFim[1,7] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //namp
li++
If nColMedia == 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.t.)
endif

li++
@ li  ,01 PSAY 'Max XB = '
@ li  ,10 PSAY aFim[1,8] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //nmax
@ li  ,pcol() PSAY '   - Min XB = '
@ li  ,pcol() PSAY aFim[1,9] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //nmin
@ li  ,pcol() PSAY '   = XBdif'
@ li  ,nColMedia  PSAY +'|'+'      '
@ li  ,pcol() PSAY aFim[1,10] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //xdif

li++
If nColMedia == 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.t.)
endif

If nColMedia == 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif
li++
@ li  ,01 PSAY 'RBB = '
@ li  ,pcol()+3 PSAY aFim[1,7] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //namp
@ li  ,pcol() PSAY	'   - xD4 = '
@ li  ,pcol()+3 PSAY aFim[1,11] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //d4
@ li  ,pcol() PSAY	'   = LSCr'
@ li  ,nColMedia  PSAY +'|'+'      '
@ li  ,pcol() PSAY aFim[1,12] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //nlsc
li++
If nColMedia == 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.t.)
endif

li++
@ li  ,01 PSAY 'RBB = '
@ li  ,pcol()+3 PSAY aFim[1,7] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //namp
@ li  ,pcol() PSAY	'     xD3 = '
@ li  ,pcol()+3 PSAY aFim[1,13] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //d3
@ li  ,pcol() PSAY '   = LICr'
@ li  ,nColMedia PSAY +'|'+'      '
@ li  ,pcol() PSAY aFim[1,14] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //nlic
li++

If nColMedia == 60
	@ li  ,01 PSAY repl('-',77)
Else
	@ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Endif

nColMedia := pCol()

cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
@ li  ,000 PSAY Repl("*",132)
li+=2
U_R220Cabec(.f.,.f.)

li++
@ li  ,01 PSAY repl('=',80)
li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0011)) //'ANALISE DA GRANDEZA DE MEDICAO'
@ li  ,47 PSAY '|'
@ li  ,53 PSAY alltrim(OemtoAnsi(STR0012)) //'% VARIACAO DO PROCESSO'
li++
@ li  ,01 PSAY repl('=',80)

li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0013)) //'Repetitividade - Variacao do equipamento (VE)'
@ li  ,47 PSAY '|'
li++
@ li  ,47 PSAY '|'
li++
@ li  ,01 PSAY 'VE =  RBB   x   K1'

if nTipoRR == 1
   @ li ,47 PSAY '| %VE  = 100 [VE/TE]' // Tolerancia
else
   @ li ,47 PSAY '| %VE  = 100 [VE/VT]'
endif

li++
@ li  ,01 PSAY '   = '
@ li  ,pcol() PSAY aFim[1,7] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //namp
@ li  ,pcol() PSAY ' x '
@ li  ,pcol() PSAY aFim[1,15] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //k1

@ li  ,47 PSAY '|      = 100 [ '
@ li  ,pcol() PSAY aFim[1,16] PICTURE QA_PICT("QM4_LIE",TRB_LIE) //nvre
@ li  ,pcol() PSAY ' / '

If nTipoRR == 1
   @ li  ,pcol() PSAY aFim[1,17] PICTURE q150MoPict(aFim[1,17],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nTole
   @ li  ,pcol() PSAY ' ] '
Else
   @ li  ,pcol() PSAY aFim[1,18] PICTURE q150MoPict(aFim[1,18],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nVt
   @ li  ,pcol() PSAY + ' ] '
EndIf

li++
@ li  ,01 PSAY '   = '
@ li  ,pcol() PSAY aFim[1,16] PICTURE cPicture //q150MoPict(aFim[1,16],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvre

@ li  ,47 PSAY '|      = '

@ li  ,pcol() PSAY aFim[1,1] PICTURE cPicture//qmt140PicS(,StrTran(AllTrim(Str(aFim[1,1],15,Qa_NumDec(aFim[1,1]))),".",","),.f.) //npve - TRB_LIE
@ li  ,pcol() PSAY ' %'

li++
@ li  ,01 PSAY repl('-',80)


if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif

li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0014)) //'Reprodutibilidade-Variacao do Avaliador(VA)'
@ li  ,47 PSAY '|'
@ li  ,49 PSAY alltrim(OemtoAnsi(STR0015)) //'n = numero de pecas'
li++
@ li  ,47 PSAY '| '
@ li  ,49 PSAY alltrim(OemtoAnsi(STR0016)) //'r = numero de ciclos'
li++
@ li  ,01 PSAY 'VA = RaizQ((XBdif x K2)^2 - (VE^2/nr))'
@ li  ,47 PSAY '|'
li++
@ li  ,01 PSAY '   = RaizQ(('
@ li  ,pcol() PSAY  aFim[1,10] PICTURE q150MoPict(aFim[1,10],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //xdif
@ li  ,pcol() PSAY  ' x '
@ li  ,pcol() PSAY aFim[1,19] PICTURE q150MoPict(aFim[1,19],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //k2
@ li  ,pcol() PSAY ')^2 - '
if nTipoRR == 1
   @ li  ,47 PSAY '| %VA  = 100 [VA/TE]' // Tolerancia
else
   @ li  ,47 PSAY '| %VA  = 100 [VA/VT]'
endif

li++
@ li  ,01 PSAY space(11)+'('
@ li  ,PCOL() PSAY aFim[1,16] PICTURE q150MoPict(aFim[1,16],"TRB_LIE")  //QA_PICT("QM4_LIE",TRB_LIE) //nvre
@ li  ,PCOL() PSAY '^2 / '+Str(TRB_NPECAS,2) + ' x ' +Str(TRB_NCICLO,2) + '))'

@ li  ,47 PSAY '|      = 100 [ '
@ li  ,PCOL() PSAY aFim[1,20] PICTURE q150MoPict(aFim[1,20],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nva
@ li  ,PCOL() PSAY ' / '

If nTipoRR == 1
   @ li  ,PCOL() PSAY aFim[1,17] PICTURE q150MoPict(aFim[1,17],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //ntole
Else
   @ li  ,PCOL() PSAY aFim[1,18] PICTURE q150MoPict(aFim[1,18],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE)  //nvt
EndIf

@ li  ,PCOL() PSAY ' ] '
li++
@ li  ,01 PSAY '   = '
@ li  ,PCOL() PSAY aFim[1,20] PICTURE cPicture //QA_PICT("QM4_LIE",TRB_LIE) //nva
@ li  ,47 PSAY '|      = '
@ li  ,PCOL() PSAY aFim[1,2] PICTURE cPicture  //qmt140PicS(,StrTran(AllTrim(Str(aFim[1,2],15,Qa_NumDec(aFim[1,2]))),".",","),.f.) //PICTURE "9999.99" //QA_PICT("QM4_LIE",TRB_LIE) //npva
@ li  ,PCOL() PSAY ' %'
li++
@ li  ,01 PSAY repl('-',80)

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif

li++
@ li  ,01 PSAY alltrim(OemtoAnsi(STR0017))  // 'Repetitividade e Reprodutibilidade (R&R)'
@ li  ,47 PSAY If(nMsa > 2,'| Com base na Variação do Processo','')
@ li  ,90 PSAY If(nMsa > 2,'| Com base na Tolerancia','')
li++
@ li  ,47 PSAY '|'

@ li  ,90 PSAY If(nMsa > 2,'|','')
li++
@ li  ,01 PSAY 'R&R= RaizQ(VE^2 + VA^2)'
@ li  ,47 PSAY if(nTipoRR==1,'| R&R  = RaizQ( (%V.E.^2) + (%V.A.^2) )',;
                                '| R&R  = 100 [R&R/VT]')
@ li  ,90 PSAY If(nMsa > 2,'| R&R  = 100 [R&R/(1/6 * Tol)]','')
li++
@ li  ,01 PSAY '   = RaizQ('
@ li  ,PCOL() PSAY aFim[1,16] PICTURE q150MoPict(aFim[1,16],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvre
@ li  ,PCOL() PSAY '^2 + '
@ li  ,PCOL() PSAY aFim[1,20] PICTURE q150MoPict(aFim[1,20],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nva
@ li  ,PCOL() PSAY '^2)'
if nTipoRR == 1
   @ li  ,47 PSAY '|      = RaizQ( ('
   @ li  ,PCOL() PSAY aFim[1,1] PICTURE q150MoPict(aFim[1,1],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //npve
   @ li  ,PCOL() PSAY '^2'
   @ li  ,PCOL() PSAY aFim[1,2] PICTURE q150MoPict(aFim[1,2],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //npva
   @ li  ,PCOL() PSAY '^2 ] '
else
   @ li  ,47 PSAY '|      = 100 [ '
   @ li  ,PCOL() PSAY aFim[1,21] PICTURE q150MoPict(aFim[1,21],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nrr
   @ li  ,PCOL() PSAY ' / '
   @ li  ,PCOL() PSAY aFim[1,18] PICTURE q150MoPict(aFim[1,18],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvt
   @ li  ,PCOL() PSAY ' ] '

   If(nMsa > 2)
	   @ li  ,90 PSAY '|      = 100 [ '
	   @ li  ,PCOL() PSAY aFim[1,21] PICTURE q150MoPict(aFim[1,21],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nrr
	   @ li  ,PCOL() PSAY ' /(1/6 * '
	   @ li  ,PCOL() PSAY SuperVal(TRB_TOLESP) PICTURE q150MoPict(aFim[1,21],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvt
	   @ li  ,PCOL() PSAY ' )] '
	EndIf

endif

li++

@ li  ,01 PSAY '   = '
@ li  ,PCOL() PSAY aFim[1,21] PICTURE cPicture //QA_PICT("QM4_LIE",TRB_LIE) //nrr
@ li  ,47 PSAY '|      = '
@ li  ,56 PSAY Round(aFim[1,3],QA_NumDec(aFim[1,3])) PICTURE cPicture
@ li  ,PCOL() PSAY ' %'

If(nMsa > 2)
	@ li  ,01 PSAY '   = '
	@ li  ,PCOL() PSAY aFim[1,21] PICTURE cPicture //QA_PICT("QM4_LIE",TRB_LIE) //nrr
	@ li  ,90 PSAY ' |      = '
	@ li  ,100 PSAY Round(aFim[1,25],QA_NumDec(aFim[1,25])) PICTURE cPicture
	@ li  ,PCOL() PSAY ' %'
EndIf
li++
@ li  ,01 PSAY repl('-',80)

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif

li++
@ li  ,01 PSAY OemtoAnsi(STR0018)  //'Variacao Peca a Peca (VP)'
@ li  ,47 PSAY '|'
li++
@ li  ,47 PSAY '|'
li++
@ li  ,01 PSAY 'VP =  Rp    x   K3'
@ li  ,47 PSAY If(nTipoRR==1,'| %VP  = 100 [VP/TE]',;
                              '| %VP  = 100 [VP/VT]')
li++
@ li  ,01 PSAY '   = '
@ li  ,PCOL() PSAY aFim[1,6] PICTURE q150MoPict(aFim[1,6],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nrp
@ li  ,PCOL() PSAY ' x '
@ li  ,PCOL() PSAY aFim[1,22] PICTURE q150MoPict(aFim[1,22],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //k3
If nTipoRR == 1
   @ li  ,47 PSAY '|      = 100 [ '
   @ li  ,PCOL() PSAY aFim[1,23] PICTURE q150MoPict(aFim[1,23],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvp
   @ li  ,PCOL() PSAY ' / '
   @ li  ,PCOL() PSAY aFim[1,17] PICTURE q150MoPict(aFim[1,17],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //ntole
   @ li  ,PCOL() PSAY ' ] '
else
   @ li  ,47 PSAY '|      = 100 [ '
   @ li  ,PCOL() PSAY aFim[1,23] PICTURE q150MoPict(aFim[1,23],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvp
   @ li  ,PCOL() PSAY ' / '
   @ li  ,PCOL() PSAY aFim[1,18] PICTURE q150MoPict(aFim[1,18],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvt
   @ li  ,PCOL() PSAY ' ] '
EndIf
li++
@ li  ,01 PSAY '   = '
@ li  ,pCOL() PSAY aFim[1,23] PICTURE cPicture //QA_PICT("QM4_LIE",TRB_LIE) //nvp
@ li  ,47 PSAY '|      = '
@ li  ,PCOL() PSAY Round(aFim[1,4],QA_NumDec(aFim[1,4])) PICTURE cPicture //qmt140PicS(,StrTran(AllTrim(Str(aFim[1,4],15,Qa_NumDec(aFim[1,4]))),".",","),.f.) //PICTURE "9999.99"  //QA_PICT("QM4_LIE",TRB_LIE) //npvp
@ li  ,PCOL() PSAY ' %'
li++
@ li  ,01 PSAY repl('-',80)

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif


If nTipoRR == 2

   li++
   @ li  ,01 PSAY OemtoAnsi(STR0019)  //'Variacao Total (VT)'
   If TRB_TPMSA $ "1|3"
	   @ li  ,47 PSAY '| ndc'
   Else
	   @ li  ,47 PSAY '|'
   Endif
   li++
   @ li  ,47 PSAY '|'
   li++
   @ li  ,01 PSAY 'VT = RaizQ(R&R^2 + VP^2)'
   If TRB_TPMSA $ "1|3"
	   @ li  ,47 PSAY '| ndc  = 1.41(VP/R&R)'
   Else
	   @ li  ,47 PSAY '|'
   Endif
   li++
   @ li  ,01 PSAY '   = RaizQ('
   @ li  ,PCOL() PSAY aFim[1,21] PICTURE q150MoPict(aFim[1,21],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nrr
   @ li  ,PCOL() PSAY '^2 + '
   @ li  ,PCOL() PSAY aFim[1,23] PICTURE q150MoPict(aFim[1,23],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE) //nvp
   @ li  ,PCOL() PSAY '^2)'
   If TRB_TPMSA $ "1|3"
	   @ li  ,47 PSAY '|      = 1.41('
	   @ li  ,PCOL() PSAY aFim[1,23] PICTURE q150MoPict(aFim[1,23],"TRB_LIE")
	   @ li  ,PCOL() PSAY '/'
	   @ li  ,PCOL() PSAY aFim[1,21] PICTURE q150MoPict(aFim[1,21],"TRB_LIE")
	   @ li  ,PCOL() PSAY ')'
   Else
	   @ li  ,47 PSAY '|'
   Endif
   li++
   @ li  ,01 PSAY '   = '
   @ li  ,PCOL() PSAY aFim[1,18] PICTURE cPicture //QA_PICT("QM4_LIE",TRB_LIE) //nvt
//   @ li  ,47 PSAY '|      = '
   If TRB_TPMSA $ "1|3"
	   @ li  ,47 PSAY '|      = '
	   @ li  ,PCOL() PSAY aFim[1,24] PICTURE cPicture
   Else
      @ li  ,47 PSAY '|'
   Endif
   li++
   @ li  ,01 PSAY repl('-',80)
elseif nTipoRR == 1
   li++
   If TRB_TPMSA $ "1|3"
	   @ li  ,01 PSAY 'ndc'
	   @ li  ,47 PSAY '|'
	   li++
	   @ li  ,47 PSAY '|'
	   li++
	   @ li  ,01 PSAY 'ndc= 1.41('
	   @ li  ,PCOL() PSAY aFim[1,23] PICTURE q150MoPict(aFim[1,23],"TRB_LIE")
	   @ li  ,PCOL() PSAY '/'
	   @ li  ,PCOL() PSAY aFim[1,21] PICTURE q150MoPict(aFim[1,21],"TRB_LIE")
	   @ li  ,PCOL() PSAY ')'
	   @ li  ,47 PSAY '|'
	   li++
	   @ li  ,01 PSAY '   = '
	   @ li  ,PCOL() PSAY aFim[1,24] PICTURE q150MoPict(aFim[1,24],"TRB_LIE")
	   @ li  ,47 PSAY '|'
   Endif
   li++
endif


if aFim[1,3]  <= GetMv("MV_QRRIAPR")  // nprr
   cresu = alltrim(GetMv("MV_QRRTAPR"))    // "BOM"
elseif aFim[1,3] <= GetMv("MV_QRRICON")  //nprr
   cresu = alltrim(GetMv("MV_QRRTCON"))    // "ACEITAVEL"
else
   cresu = alltrim(GetMv("MV_QRRTREP"))    // "INACEITAVEL"
endif

li+=2

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif
@ li  ,01 PSAY alltrim(STR0020)+'..:  '+cresu //'Resultado'

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R220MCurt³ Autor ³ Wanderley Goncalves   ³ Data ³ 13.07.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime R&R Individual para metodo curto                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220MCurt()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220MCurt()

Local nPosEns := ASCAN(aHeader,{|x| alltrim(x[2]) = "QM5_ENSR" })
Local nPosPec := ASCAN(aHeader,{|x| alltrim(x[2]) = "QM5_PECA" })
Local cEnsr
Local nTAmp := 0
Local nTole
Local cResu
Local nCntFor3 := 1
Local nCntFor2 := 1
Local nCntFor := 1
Local nCntFor4 := 1

cPicts := q150MoPict(aFim[1,4],"TRB_LIE")
For nCntFor := 1 to TRB_NENSR
   li++
   cEnsr := Subs(aCols[nCntFor,nPosEns],1,nTamRa)

   QAA->(DbSetOrder(1))
   If QAA->(DbSeek(cFilAnt + cEnsr ))
      @ li  , 01 PSAY cEnsr + " - " + QAA->QAA_NOME
   Else
      @ li  , 01 PSAY cEnsr
   EndIf
   For nCntFor2 := 1 to TRB_NCICLO // So tem um ciclo
      if li > 54
         cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
         @ li  ,000 PSAY Repl("*",132)
         li+=2
         U_R220Cabec(.t.,.t.)
      endif
      li++
      @ li  ,07 PSAY StrZero(nCntFor2,2) + ' ' + '|'
      For nCntFor3 := nPosPec to nPosPec+TRB_NPECAS-1
           @ li  , pcol() PSAY aCols[nCntFor,nCntFor3] PICTURE QA_PICT("QM4_LIE",TRB_LIE)
           @ li  , pcol() PSAY '|'
      Next nCntFor3
   Next nCntFor2
   li++
   @ li  , 01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Next

// Linha de Amplitudes
li++
@ li  ,01 PSAY subs(OemToAnsi(STR0021),1,9)  // "Amplitude"
@ li  ,10 PSAY '|'
For nCntFor4 := 1 to TRB_NPECAS
    @ li  ,pcol() PSAY aFim[1][1][nCntFor4];
						PICTURE QA_PICT("QM4_LIE",TRB_LIE)
    @ li  ,pcol() PSAY '|'
Next

@ li, pcol() PSAY aFim[1,2] PICTURE q150MoPict(aFim[1,2],"TRB_LIE")//qmt140pics("aFim[1,2]",TRB_LIE,.t.)

li+= 4

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Amplitude media                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ li, 004 PSAY OemToAnsi(STR0022)  // "Amplitude M‚dia"
@ li, 025 PSAY OemToAnsi(STR0023)  // "Soma das amplitudes / # de avaliadores"

nTAmp := 0

For nCntFor := 1 to Len(aFim[1][1])
	nTAmp += aFim[1][1][nCntFor]
Next nCntFor

@ li, 080 PSAY AllTrim(STR(nTamp)) + " / " + AllTrim(STR(TRB_NPECAS))
@ li, 115 PSAY ' = '
@ li, 120 PSAY aFim[1,2] PICTURE q150MoPict(aFim[1,2],"TRB_LIE") //qmt140pics("aFim[1,2]",TRB_LIE,.t.)

li+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime G R&R                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ li, 004 PSAY OemToAnsi(STR0024)  // "G R&R"
@ li, 025 PSAY "5,15 (R) / d2 "
@ li, 080 PSAY "5,15 * "
@ li, 087 PSAY aFim[1,2] PICTURE q150MoPict(aFim[1,2],"TRB_LIE") //QA_PICT("QM4_LIE",TRB_LIE)
@ li, 095 PSAY " / " + AllTrim(Str(aFim[1,5]))
@ li, 115 PSAY ' = '
@ li, 120 PSAY aFim[1,3] PICTURE q150MoPict(aFim[1,3],"TRB_LIE") //qmt140pics("nAmp",TRB_LIE,.t.)

li+=2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime % R&R                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTole := abs(SuperVal(TRB_LSE) - SuperVal(TRB_LIE))
@ li, 004 PSAY OemToAnsi(STR0025)  // "% R&R"
@ li, 025 PSAY "100 (% R&R / " + OemToAnsi(STR0026) // "Varia‡„o do Processo/Tolerƒncia"
@ li, 080 PSAY "100 ("
@ li, 086 PSAY aFim[1,3] PICTURE q150MoPict(aFim[1,3],"TRB_LIE") //qmt140pics("aFim[1,4]",TRB_LIE,.t.)
@ li, 095 PSAY " / "
@ li, 098 PSAY nTole PICTURE q150MoPict(nTole,"TRB_LIE")//QA_PICT("QM4_LIE",TRB_LIE)
@ li, 107 PSAY ')'
@ li, 115 PSAY ' = '
@ li, 120 PSAY aFim[1,4] PICTURE q150MoPict(aFim[1,4],"TRB_LIE") //qmt140pics("aFim[1,4]",TRB_LIE,.t.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Resultado                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li+=3

if aFim[1,4]  <= GetMv("MV_QRRIAPR")  // nprr
   cResu := alltrim(GetMv("MV_QRRTAPR"))    // "BOM"
elseif aFim[1,4] <= GetMv("MV_QRRICON")  //nprr
   cResu := alltrim(GetMv("MV_QRRTCON"))    // "ACEITAVEL"
else
   cResu := alltrim(GetMv("MV_QRRTREP"))    // "INACEITAVEL"
endif

if li > 54
   cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
   @ li  ,000 PSAY Repl("*",132)
   li+=2
   U_R220Cabec(.f.,.f.)
endif
@ li  ,04 PSAY alltrim(STR0027)+'..:  '+cresu //'Resultado'

Return(Nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R220Cabec³ Autor ³ Wanderley Goncalves   ³ Data ³ 10.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Cabecalho R&R Individual                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220CABEC()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³ lCab -> Imprime cabecalho da tabela de lancamentos         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220Cabec(lCab)
Local nCntFor  := 0
Local nColInt  := 0
Local nPosi	   := 0
@ li  ,05 PSAY alltrim(cTitIns)+' '+;  // 'Instrumento'
          repl('.',16-len(alltrim(cTitIns)))+;
               ': ' + padr(TRB_INSTR,60) +space(20)+;
               OemtoAnsi(STR0040) + DtoC(TRB_VALREP) // 'Data da validade: '
li++

QM1->(DbSetOrder(1))
If QM1->(DbSeek(xFilial("QM1")+TRB_TIPO))
   @ li  ,05 PSAY alltrim(cTitEsc)+' '+;  // 'Tipo'
            repl('.',16-len(alltrim(cTitEsc)))+;
               ': ' + alltrim(TRB_TIPO)+;
               ' - ' + QM1->QM1_DESCR
EndIf

li+= 2

@ li  ,05 PSAY alltrim(cTitPeca)+' '+;  // 'Peca'
            repl('.',16-len(alltrim(cTitPeca)))+;
            ': ' + alltrim(TRB_PECA)

li++
@ li  ,05 PSAY alltrim(cTitCarac)+' '+;  // 'Caracteristica'
            repl('.',16-len(alltrim(cTitCarac)))+;
            ': ' + alltrim(TRB_CARACT)

li++

@ li  ,05 PSAY alltrim(cTitNum)+' '+;  // 'Numero'
            repl('.',16-len(alltrim(cTitNum)))+;
            ': ' + alltrim(TRB_NUMERO)
li++

If TRB_TIPQM4 <> "A"
	SAH->(DbSetOrder(1))
SAH->(DbSeek(xFilial("SAH")+TRB_UM))

	@ li  ,05 PSAY alltrim(OemToAnsi(STR0028))+' '+; // "Limites"
            repl('.',16-len(alltrim(OemToAnsi(STR0029))))+; // "Limites"
            ': '  + alltrim(TRB_LIE) +;
            ' - ' + alltrim(TRB_LSE) +;
            '   ' + alltrim(SAH->AH_UMRES)

	li++

nToler := SuperVal(TRB_LSE) - SuperVal(TRB_LIE)

	li++

	@ li  ,65 PSAY OemToAnsi(STR0030)+ '  :'    // 'Tolerancia'
@ li  ,90 PSAY nToler PICTURE QA_PICT("QM4_LIE",TRB_LIE)

	li+=2
Endif

@ li  ,05 PSAY OemToAnsi(STR0031) // 'Resultados'

li+=2

@ li  ,05 PSAY OemToAnsi(STR0042)+; // 'Data do ensaio: '
			   DtoC(TRB_DATA)

@ li  ,65 PSAY OemToAnsi(STR0032)+' : '+;  // 'Metodo'
         if(TRB_TIPQM4 == "E",; // Metodo GM
            OemToAnsi(STR0033),; // 'Tolerancia de Especificacao'
         if(TRB_TIPQM4 == "P",;
            OemToAnsi(STR0034),; // 'Tolerancia de Processo'
         	if(TRB_TIPQM4 == "A",OemToAnsi(STR0046),OemToAnsi(STR0039)))) // 'Metodo Curto'
li+=2

If lCab
   // Impressao da tabela de dados com medias e amplitudes
   @ li  ,01 PSAY repl('-',9)+'-'+repl('-',(TRB_NPECAS*10))+'-'+repl('-',nTraco)
   li++

   If TRB_NPECAS <= 9
	   @ li  ,01 PSAY subs(OemToAnsi(STR0035),1,9)+'|'+space(((TRB_NPECAS*10)/2)-3)+;	//	'Ensaiador'
				alltrim(OemToAnsi(STR0036))+space((TRB_NPECAS*10)/2)+;     	// 	'Pecas'
				If(TRB_TIPQM4 <> "A",Space(5)+alltrim(OemToAnsi(STR0037)),"")	//	'Medias'
   Else
	   @ li  ,01 PSAY subs(OemToAnsi(STR0035),1,9)+'|'+space(((TRB_NPECAS*10)/2)-3)+;	//	'Ensaiador'
				alltrim(OemToAnsi(STR0036))+space((TRB_NPECAS*10)/2)+;     	// 	'Pecas'
				If(TRB_TIPQM4 <> "A",Space(13)+alltrim(OemToAnsi(STR0037)),"")	//	'Medias'
   Endif
   li++

   For nCntFor := 1 to TRB_NPECAS
       nPosi := nPosi + 11
   Next nCntFor

   @ li  ,01 PSAY space(9)+'|'+repl('-',nPosi-1)+'|'+space(13)
   li++
   @ li  ,01 PSAY alltrim(OemToAnsi(STR0038))+'  |'

   nColInt := Int(10/2)-1

   For nCntFor := 1 to TRB_NPECAS
       @ li,pcol()+nColInt PSAY StrZero(nCntFor,2)+Space(nColInt)+'|'
   Next nCntFor
   li++
   @ li  ,01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ A150Pc   ³ Autor ³ Wanderley Goncalves   ³ Data ³ 27/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chama a funcao que monta a picture de um campo.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ A150Pc(cCampo)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Nome do Campo que tera' a picture a ser definida   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTA150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A220Pc(cCampo)

Local cPict
//Campo ,Valor de Referencia
cPict := QA_PICT(cCampo,&cCampo)
return cPict
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R220MAtrib³ Autor ³ Denis Martins         ³ Data ³ 25.04.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime R&R por Atributo - Metodo Curto                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_R220MAtrib()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR220                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R220MAtrib()

Local nPosAtr := ASCAN(aHeader,{|x| alltrim(x[2]) = "QM5_ATRIB" })
Local cEnsr
Local nTot := 1
Local nCntFor2 := 1
Local nCntFor3 := 1
Local nCntFor := 1

QM5ATP->(DBGOTOP())
For nCntFor := 1 to TRB_NENSR
   li++
   cEnsr := QM5ATP->QM5_ENSR

   QAA->(DbSetOrder(1))
   If QAA->(DbSeek(QM5ATP->QM5_FILRES + cEnsr ))
      @ li  , 01 PSAY cEnsr + " - " + QAA->QAA_NOME
   Else
      @ li  , 01 PSAY cEnsr
   EndIf
   For nCntFor2 := 1 to TRB_NCICLO
      if li > 60
         cabec(titulo,cabec1,cabec2,nomeprog,cTamanho,IIF(aReturn[4]==1,15,18))
         @ li  ,000 PSAY Repl("*",132)
         li+=2
         U_R220Cabec(.t.,.t.)
      endif
      li++
      @ li  ,07 PSAY StrZero(nCntFor2,2) + ' ' + '|'
      For nCntFor3 := nPosAtr to nPosAtr+TRB_NPECAS-1
          If nTot <= Len(aCols)
	          If Alltrim(aCols[nTot,nCntFor3]) == "1"
				 @ li  , pcol() PSAY OemToAnsi(STR0047) //	Passa
       		  Else
           		 @ li  , pcol() PSAY OemToAnsi(STR0048) //	N.Passa
	          Endif
   		       @ li  , pcol()+3 PSAY '|'
		  Endif
      Next nCntFor3
      nTot++
      QM5ATP->(dbSkip())
   Next nCntFor2
   li++
   @ li  , 01 PSAY repl('-',9)+'-'+repl('-',TRB_NPECAS*10)+'-'+repl('-',nTraco)
Next

li+=2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime Resultado.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ li  ,04 PSAY alltrim(STR0027)+'..:  '+aFim[1,2] //'Resultado'
li++
@ li  ,04 PSAY alltrim(STR0043)+'..:  '+Alltrim(Str(aFim[1,3]+aFim[1,4])) //Total de Leitura
li++
@ li  ,04 PSAY alltrim(STR0044)+'..:  '+Alltrim(Str(aFim[1,3])) //Leitura(s) Capaz(es)
li++
@ li  ,04 PSAY alltrim(STR0045)+'..:  '+Alltrim(Str(aFim[1,4])) //Leitura(s) Nao Capaz(es)

Return(Nil)

