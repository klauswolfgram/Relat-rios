/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.Ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ ATFR240	³ Autor ³ Alessandro B. Freire  ³ Data ³ 14.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                   								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_ATFR240(void)															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parƒmetros³ 																			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR240()
LOCAL cDesc1	:= "Imprime o Relat¢rio com a Rela‡„o de Simula‡„o"
LOCAL cDesc2	:= "de Vendas conforme os parƒmetros selecionados "
LOCAL cDesc3	:= "pelo usu rio."
LOCAL cString	:= "SN7"
LOCAL wnrel

PRIVATE aReturn	:= { "Zebrado", 1,"Administra‡„o", 2, 2, 1, "",1 }
PRIVATE nomeprog	:="ATFR240"
PRIVATE nLastKey	:= 0
PRIVATE cPerg		:="ATR240"
PRIVATE tamanho	:="G"
PRIVATE titulo		:= ""
PRIVATE cabec1
PRIVATE cabec2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabe‡alhos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := "Relatorio de Conferencia de Simulacao de Vendas"
//                                                                                                             1         1         1         1         1         1         1         1         1         1         2         2        2
//                   1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1        1
//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
cabec1 := "COD. BASE                       ITEM/BEM  CENTRO DE   CONTA             TX. DEPREC.  DT.VENDA    VLR. AQUIS. R$         DEPR. ACUM. R$        CORR. DO BEM           VLR. CORRIGIDO         VLR. VENDA"          
cabec2 := "DESCR. BEM                                 CUSTO      ITEM DA CONTA                  DT.AQUIS.   VLR. AQUIS. UFIR       DEPR. ACUM. UFIR      CORR. MONET. DEPR.     VLR. RESIDUAL          LUCRO/PREJUIZO"  
//         9999999999                      XXXX      XXXXXXXXX   XXXXXXXXXXXXXXX   999,9999     99/99/99    9.999.999.999.999,99   9.999.999.999.999,99  9.999.999.999.999,99   9.999.999.999.999,99   9.999.999.999.999,99  
//         XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                        XXXXXXXXX                      99/99/99    99.999.999.999,9999    99.999.999.999,9999   9.999.999.999.999,99   9.999.999.999.999,99   9.999.999.999.999,99

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("ATR240",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros ³
//³ mv_par01	  // do data   			  ³
//³ mv_par02	  // at‚ a data   		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "ATFR240"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| Fr240Imp(@lEnd,wnRel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³ Fr240Imp ³ Autor ³ Alessandro B. Freire  ³ Data ³ 14.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impress„o                         								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ Fr240Imp(lEnd,wnRel,cString)										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd	  - A‡Æo do Codeblock										  ³±±
±±³			 ³ wnRel   - T¡tulo do relat¢rio 									  ³±±
±±³			 ³ cString - Mensagem													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Gen‚rico 																  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR240Imp(lEnd,wnRel,cString)
LOCAL limite   := 220
Local CbCont
Local CbTxt
Local cDescr   := Space(30)
Local nVlCorrig:= 0
Local nOrig3   := 0
Local nVlDepAc3:= 0
Local nVlResid := 0
Local nLucro   := 0
Local nTotBens := 0

PRIVATE cMoedaAtf := GetMv("MV_ATFMOED")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impress„o do Cabe‡alho e Rodap‚ ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt  := ""
cbcont := 0
li 	 := 80
m_pag  := 1

dbSelectArea("SN7")
dbSetOrder(1)
dbSeek(xFilial("SN7"),.T.)
SetRegua(LastRec())
While ! Eof()
	
	IF lEnd
		@PROW()+1,001 PSAY  "CANCELADO PELO OPERADOR"
		Exit
	End

	If !Empty(SN7->N7_DTBAIXA)
		dbSelectArea("SN7")
		dbSkip()
		loop
	Endif 

	If SN7->N7_DTSIMUL < mv_par01 .or. SN7->N7_DTSIMUL > mv_par02
		dbSelectArea("SN7")
		dbSkip()
		loop	
	EndIf
	dbSelectArea("SN1")
	dbSetOrder(1)
	If !dbSeek(xFilial("SN1")+ SN7->N7_CBASE+SN7->N7_ITEM)
		Help(" ",1,"020ATIVO")
		Exit
	EndIf	
	cDescr := SubStr(SN1->N1_DESCRIC,1,30)

	dbSelectArea("SN3")
	dbSetOrder(1)
	If !dbSeek(xFilial("SN3")+ SN7->N7_CBASE+SN7->N7_ITEM)
		Help(" ",1,"020ATIVO")
		Exit
	EndIf
	nVlCorrig := SN3->N3_VORIG1+SN3->N3_VRCACM1
	nVorig3   := &('SN3->N3_VORIG'+cMoedaAtf)
	nVlDepAc3 := &('SN3->N3_VRDACM'+cMoedaAtf)
	If SN3->N3_TIPO = "05"	
		nVlresid  := (SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1) + (SN3->N3_VRDACM1+SN3->N3_VRCDA1)
	Else
		nVlresid  := (SN3->N3_VORIG1+SN3->N3_VRCACM1+SN3->N3_AMPLIA1) - (SN3->N3_VRDACM1+SN3->N3_VRCDA1)
	Endif
	nLucro    := (SN7->N7_VLSIMU1-SN7->N7_VLREAL)
	nTotBens++
	IncRegua()
	 
	If li > 55
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	EndIf	
	
	dbSelectArea("SN7")
	dbSetOrder(1)
	@li,000 PSAY SN7->N7_CBASE                   // CODIGO BASE
	@li,032 PSAY SN7->N7_ITEM                    // ITEM/BEM
	@li,042 PSAY SN3->N3_CCUSTO                                        // CENTRO DE CUSTO
	@li,054 PSAY SN3->N3_CCONTAB                                       // CONTA
	@li,072 PSAY SN3->N3_TXDEPR1 Picture PesqPict("SN3","N3_TXDEPR1",8)  // TX. DE DEPRECIACAO
	@li,085 PSAY SN7->N7_DTSIMUL                                       // DATA DA VENDA
	@li,097 PSAY SN3->N3_VORIG1  Picture PesqPict("SN3","N3_VORIG1",16)   // VALOR DA AQUISICAO EM R$
	@li,120 PSAY SN3->N3_VRDACM1 Picture PesqPict("SN3","N3_VRDACM1",16)  // DEPRECIACAO ACUMULADA EM R$
	@li,142 PSAY SN3->N3_VRCACM1 Picture PesqPict("SN3","N3_VRCACM1",16)  // CORRECAO DO BEM
	@li,165 PSAY nVlCorrig       Picture PesqPict("SN3","N3_VORIG1",16)   // VALOR CORRIGIDO
	@li,187 PSAY SN7->N7_VLREAL  Picture PesqPict("SN3","N3_VORIG1",16)  //valor da venda..........:"
	li++
	
	@li,000 PSAY cDescr                                                       // DESCRICAO DO BEM	"
	@li,054 PSAY SN3->N3_SUBCCON                                              // ITEM DA CONTA"
	@li,085 PSAY SN3->N3_AQUISIC                                              // DATA DA AQUISICAO"
	@li,097 PSAY nVorig3        Picture PesqPict("SN3","N3_VORIG"+cMoedaAtf,16)  // valor da aquisicao em ufir"
	@li,120 PSAY nVlDepAc3      Picture PesqPict("SN3","N3_VORIG"+cMoedaAtf,16)  // DEPRECIACAO ACUMULADA EM UFIR"
	@li,142 PSAY SN3->N3_VRCDA1 Picture PesqPict("SN3","N3_VORIG1",16)           // CORRECAO MONETARIA DA DEPRECIACAO"
	@li,165 PSAY nVlResid       Picture PesqPict("SN3","N3_VORIG1",16)
	@li,187 PSAY nLucro         Picture PesqPict("SN3","N3_VORIG1",16)           //LUCRO / PREJUIZO........:"
	li++

	@li,00 PSAY Repl("-",limite)
	li++
	cDescr:=Space(30); nVlCorrig:=0; nOrig3:=0; nVlDepAc3:=0;	nVlResid:=0; nLucro:= 0
	dbSelectArea("SN7")
	dbSkip()
	Loop
EndDo
@li++,00 PSAY Repl("*",220)
@li,000 PSAY "Total de Bens ....."
@li,021 PSAY nTotBens

Roda( cbCont, cbTxt ,Tamanho)

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return(.t.)
