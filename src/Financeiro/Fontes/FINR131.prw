/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR131.CH"
#IFDEF WINDOWS
   #Include "FIVEWIN.Ch"
#ELSE
   #Include "InKey.Ch"
   #Include "SetCurs.Ch"
   #Include "Siga.Ch"
#ENDIF

Static __oFinr131

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR131 ³ Autor ³Jose Lucas/Diego Rivero³ Data ³ 09.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente/Fornecedores                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR131(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Lucas/Bruno  ³14.04.00³xxxxxx³Reestruturação do relatorio.           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR131()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1  := STR0001  //"Este relatorio ir  imprimir o razonete de Clientes ou"
LOCAL cDesc2  := STR0002  //"Fornecedores. Poder  ser emitida toda a movimenta‡„o "
LOCAL cDesc3  := STR0003  //"dos mesmos, ou somente os valores originais."
LOCAL wnrel
LOCAL limite  := 132
LOCAL cString := "SE1"
LOCAL Tamanho := "P"

PRIVATE titulo := STR0004  //"Razonete de Contas Correntes"
PRIVATE cabec1
PRIVATE cabec2
PRIVATE aReturn := { STR0005, 1, STR0006 , 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:= "FINR131"
PRIVATE aLinha := { },nLastKey := 0
PRIVATE cPerg := "FIN131"
PRIVATE cTipos := ""

cTipos := ""

cPerg := "FIN131"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//³ mv_par11=parametro da moeda                                  ³
//³ mv_par12 =Imprime outras moedas                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN131",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR131"            //Nome Default do relatorio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,Tamanho,,.T.)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

#IFDEF WINDOWS
   RptStatus({|lEnd| Fa131Imp(@lEnd,wnRel,cString)},titulo)
#ELSE
   fa131Imp(.f.,Wnrel,cString)
#ENDIF
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA131Imp ³ Autor ³Jose Lucas/Diego Rivero³ Data ³ 09.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente/Fornecedores                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA131Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FA131Imp(lEnd,wnRel,cString)

LOCAL CbCont,CbTxt
LOCAL tamanho:="M"
LOCAL nQuebra:=0,lImprAnt := .F.
LOCAL cNome,nTotDeb:=0,nTotCrd:=0,nSaldoAtu:=0,nTotDebG:=0,nTotCrdG:=0,nSalAtuG:=0,nSalAntG:=0
LOCAL aSaldos:={},j,dEmissao:=CTOD(""),dVencto:=CTOD("")
LOCAL nRec,nPrim,cPrefixo,cNumero,cParcela,cTipo,cNaturez,nValliq
LOCAL nAnterior:=0,cAnterior,cFornece,dDtDigit,cRecPag,nRec1,cSeq
LOCAL nTotAbat
LOCAL nRegistro
LOCAL lNoSkip := .T.
LOCAL lFlag := .F.
LOCAL nSaldoFinal:=0
LOCAL aCampos:={},aTam:={}
LOCAL aInd:={}
LOCAL cCondE1:=cCondE2:=cCondE5:=" "
LOCAL cIndE1 :=cIndE2 :=cIndE5 :=cIndA1 :=cIndA2 :=" "
LOCAL nRegAtu,lImprime
LOCAL cArqTrab1,nIndex1
LOCAL nRegSe1Atu := SE1->(RecNo())
LOCAL nOrdSe1Atu := SE1->(IndexOrd())
LOCAL lBaixa     := .F.
LOCAL nRegSe2Atu := SE2->(RecNo())
LOCAL nOrdSe2Atu := SE2->(IndexOrd())
LOCAL cChaveSe1
LOCAL cChaveSe2
LOCAL nI := 0

PRIVATE cClieIni  := mv_par01
PRIVATE cClieFim  := mv_par02
PRIVATE cLojaIni  := mv_par03
PRIVATE cLojaFim  := mv_par04
PRIVATE dFechaIni := mv_par05
PRIVATE dFechaFim := mv_par06
PRIVATE nInforme  := mv_par07
PRIVATE nSituacao := mv_par08
PRIVATE nImpSaldo := mv_par09
PRIVATE nMoeda    := mv_par11
PRIVATE nOutrasMoedas := mv_par12


If nSituacao   == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aRegs := {}
	pergunte("FI131A",.T.)
	PRIVATE dFechaBase := Min(mv_par01,dDataBase)
Else
	PRIVATE dFechaBase := dDataBase
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag  := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0007+STR0008  //"RAZONETE DE CONTAS CORRENTES DE "###"CLIENTES"###"FORNECEDORES"
If nInforme == 2
   cabec1 := STR0053
Else
   cabec1 := STR0010
EndIf
cabec2 :=""

AADD(aCampos,{"CODIGO"  ,"C",06,0})
AADD(aCampos,{"LOJA"    ,"C",02,0})
AADD(aCampos,{"CLIENTE" ,"C",25,0})
AADD(aCampos,{"TELEFONE","C",15,0})
AADD(aCampos,{"VENDEDOR","C",03,0})
AADD(aCampos,{"NOMEVEND","C",25,0})
AADD(aCampos,{"TELEVEND","C",15,0})
AADD(aCampos,{"NATUREZA","C",10,0})
AADD(aCampos,{"EMISSAO" ,"D",08,0})
AADD(aCampos,{"PREFIXO" ,"C",03,0})
AADD(aCampos,{"NUMERO"  ,"C",15,0})
AADD(aCampos,{"TIPO"    ,"C",03,0})
AADD(aCampos,{"PARCELA" ,"C",01,0})
AADD(aCampos,{"BANCO"   ,"C",03,0})
AADD(aCampos,{"BAIXA"   ,"D",08,0})
AADD(aCampos,{"VENCTO"  ,"D",08,0})
AADD(aCampos,{"VENCREA" ,"D",08,0})
AADD(aCampos,{"HISTOR"  ,"C",20,0})
AADD(aCampos,{"VALOR"   ,"N",18,2})
AADD(aCampos,{"DEBITO"  ,"N",18,2})
AADD(aCampos,{"CREDITO" ,"N",18,2})
AADD(aCampos,{"SALDO"   ,"N",18,2})
AADD(aCampos,{"SALTIT"   ,"N",18,2})
AADD(aCampos,{"DC"      ,"C", 1,0})
AADD(aCampos,{"SIGLA" 	 ,"C",03,0})
AADD(aCampos,{"VALORANT" ,"N",18,2})
AADD(aCampos,{"VALOR180A","N",18,2})
AADD(aCampos,{"VALOR150A","N",18,2})
AADD(aCampos,{"VALOR120A","N",18,2})
AADD(aCampos,{"VALOR090A","N",18,2})
AADD(aCampos,{"VALOR060A","N",18,2})
AADD(aCampos,{"VALOR030A","N",18,2})
AADD(aCampos,{"VALORHOY" ,"N",18,2})
AADD(aCampos,{"VALOR030P","N",18,2})
AADD(aCampos,{"VALOR060P","N",18,2})
AADD(aCampos,{"VALOR090P","N",18,2})
AADD(aCampos,{"VALOR120P","N",18,2})
AADD(aCampos,{"VALOR150P","N",18,2})
AADD(aCampos,{"VALOR180P","N",18,2})
AADD(aCampos,{"VALORAPOS","N",18,2})
AADD(aCampos,{"SALDOFIM" ,"N",18,2})


If(__oFinr131 <> NIL)
	
	__oFinr131:Delete()
	__oFinr131 := NIL

EndIf

//Criando a tabela temporaria
__oFinr131 := FwTemporaryTable():New("TRB")
//Setando as colunas
__oFinr131:SetFields(aCampos)
//Criando o indicie 
__oFinr131:AddIndex("1",{"CODIGO","LOJA","CLIENTE","EMISSAO"})
//Criando a Tabela Temporaria
__oFinr131:Create()

Processa({|lEnd| U_SldClieArg(aReturn[7],.F.,nMoeda,nOutrasMoedas)},,OemToAnsi("Preparando Transit¢rio..."))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")
dbGoTop()

nTotClie := 0
nTotVend := 0

SetRegua(RecCount())

nDebGeral := 0.00
nCrdGeral := 0.00
nSldGeral := 0.00

While ! Eof()

   If li > 50
  	  cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
      li := 08
   Endif

   nSldClie := 0.00
   nDebClie := 0.00
   nCrdClie := 0.00

   cCodClie := TRB->CODIGO
   cLojaCli := TRB->LOJA
   cRazSocial := TRB->CLIENTE
   cTelefone := TRB->TELEFONE

   lImpClie := .T.

   cCondWClie := "!Eof().and.TRB->CODIGO==cCodClie.and.TRB->LOJA==cLojaCli"

   While &( cCondWClie )

      IncRegua()
      #IFNDEF WINDOWS
          Inkey()
          If LastKey() = K_ALT_A
             lEnd := .t.
          Endif
      #ENDIF
      If lEnd
       	 Exit
      EndIf

      If li>50
         cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
         li:=8
      Endif

	  If nInforme == 2 //Detallado
	  	 If lImpClie
		    @li,  0 PSAY cCodClie+"-"+cLojaCli
		    @li, 11 PSAY cRazSocial
     		@li, 42 PSAY "Tel.: " + cTelefone
			lImpClie := .F.
			li++
			li++
		 EndIf
	     @li,  0 PSAY EMISSAO
   	     @li, 11 PSAY HISTOR        Picture "@!"
		 If Len(AllTrim(NUMERO)) < 12
	        @li,033 PSAY NUMERO
		 Else
	        @li,033 PSAY NUMERO		Picture "@R 9999-99999999"
		 EndIf
      	 @li,050 PSAY PARCELA
         @li,053 PSAY EMISSAO
         @li,064 PSAY VENCTO
         @li,077 PSAY DEBITO         Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li,095 PSAY CREDITO        Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li,113 PSAY ABS(SALDO) 	 Picture PesqPict("SE1","E1_SALDO",17,nmoeda)
         @li,131 PSAY If(SALDO>=0,"D","C")
		 li++
	  EndIf
   	  nDebClie += TRB->DEBITO
      nCrdClie += TRB->CREDITO
      nSldClie += TRB->SALDO

      dbSelectArea("TRB")
      dbSkip()
   End
   If nInforme == 2 //Detallado
  	  nTotClie ++
	  li++
	  @li, 0 PSAY Repl("-",132)
	  li++
      nSldClie := nDebClie - nCrdClie
	  @li,  0 PSAY "Total Del Cliente  --->  "+cCodClie+"-"+cLojaCli
      @li, 77 PSAY nDebClie      Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
      @li, 95 PSAY nCrdClie      Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
      @li,113 PSAY ABS(nSldClie) Picture PesqPict("SE1","E1_SALDO",17,nmoeda)
      @li,131 PSAY If(nSldClie>=0,"D","C")
	  li++
	  @li, 0 PSAY Repl("-",132)
	  li++
	  li := li+ 2
   ElseIf nInforme == 1 //Sint‚tico
 	  nTotClie ++
      nSldClie := nDebClie - nCrdClie
      If ( nImpSaldo == 2 .and. nSldClie != 0 )
	     @li,  0 PSAY cCodClie+"-"+cLojaCli
  	     @li, 11 PSAY cRazSocial
     	 @li, 42 PSAY cTelefone
         @li, 70 PSAY nDebClie      Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li, 95 PSAY nCrdClie      Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li,113 PSAY ABS(nSldClie) Picture PesqPict("SE1","E1_SALDO",17,nmoeda)
         @li,131 PSAY If(nSldClie>=0,"D","C")
	  Else
	     @li,  0 PSAY cCodClie+"-"+cLojaCli
  	     @li, 11 PSAY cRazSocial
         @li, 42 PSAY cTelefone
       	 @li, 69 PSAY nDebClie      Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li, 94 PSAY nCrdClie     Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
         @li,113 PSAY ABS(nSldClie) Picture PesqPict("SE1","E1_SALDO",17,nmoeda)
         @li,131 PSAY If(nSldClie>=0,"D","C")
	  EndIf
	  li++
	  li++
   EndIf
   nDebGeral += nDebClie
   nCrdGeral += nCrdClie

   cLojaCli    := TRB->LOJA
   cCodClie    := TRB->CODIGO
End

If nTotClie > 1 .or. nTotVend > 0
   nSldGeral := nDebGeral - nCrdGeral
   If li>50
      cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
      li:=8
   EndIf
   li++
   @li, 0 PSAY Repl("-",132)
   li++
   @li,  0 PSAY STR0020+STR0021  //"T o t a l   G e r a l  d o s  "###"C l i e n t e s"###"F o r n e c e d o r e s"
   If nInforme == 2
      @li,077 PSAY nDebGeral  	Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
      @li,095 PSAY nCrdGeral  	Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
   Else
      @li,065 PSAY nDebGeral  	Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
   	  @li,090 PSAY nCrdGeral    Picture PesqPict("SE1","E1_VALOR",17,nmoeda)
   EndIf
   @li,113 PSAY ABS(nSldGeral)	Picture PesqPict("SE1","E1_SALDO",17,nmoeda)
   @li,131 PSAY If(nSldGeral>=0,"D","C")
   li++
   @li, 0 PSAY Repl("-",132)
EndIf

Roda( cbCont, cbTxt, Tamanho )

dbSelectArea("TRB")
dbCloseArea()

dbSelectArea("SA1")
RetIndex("SA1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SA2")
RetIndex("SA2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE1")
RetIndex("SE1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE2")
RetIndex("SE2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE5")
RetIndex("SE5")
dbSetOrder(1)
DbClearFilter()

For nI:=1 to Len(aInd)
   if File(aInd[nI]+OrdBagExt())
      //Ferase(aInd[nI]+OrdBagExt())
   Endif
Next

Set Device To Screen
If aReturn[5] = 1
   Set Printer To
   Commit
   Ourspool(wnrel)
Endif
MS_FLUSH()
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±                                                                         ±±
±±            Funcoes retiradas do arquivo FINXFUN.PRX                     ±±
±±                                                                         ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SldClieArg³ Autor ³ Lucas                ³ Data ³ 05/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grabar uno archivo transit¢rio (TRB) con los salods de los ³±±
±±³          ³ Clientes. Baseado en las leyes y denificiones de LOCALiza- ³±±
±±³          ³ ciones de los paises del ConeSul y Andinos.					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GrvSldClie(ExpC1,ExpC2,ExpN1,ExpL1,ExpC3)						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := C¢digo Inicial del Cliente     						  ³±±
±±³          ³ ExpC2 := C¢digo Final del Cliente								  ³±±
±±³          ³ ExpN1 := Selecci¢n del Tipo de T¡tulos							  ³±±
±±³          ³ ExpL1 := Identifica lo Cierre por Vendedor o Cliente		  ³±±
±±³          ³ ExpL2 := Imprimir con Historico o No (Saldo > 0)    		  ³±±
±±³          ³ ExpC3 := Nombre do Relat¢rio. Ejemplo: "FINR132"			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ LOCALizacoes ConeSul y Andinos									  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function SldClieArg(cFilterUser,lRecibo)
LOCAL nDebito := 0.00
LOCAL nCredito := 0.00

lRecibo := IIf(lRecibo == NIL,.T.,lRecibo)
cFilterUser := IIF(cFilterUser == NIL,"",cFilterUser)

nCount := 1000

ProcRegua( nCount )

dbSelectArea("SE1")
dbSetOrder(2)
dbSeek(xFilial("SE1")+cClieIni+cLojaIni,.T. )

IncProc()

While !Eof() .and. SE1->E1_CLIENTE <= cClieFim ;
		.and. SE1->E1_LOJA <= cLojaFim

	SA1->(dbSetOrder(1))
	If SA1->(dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA) )
		//
	EndIf
	IncProc("Procesando Cliente " + SA1->A1_NOME)
	//Controla o Filtro da SetPrint.
	//Bruno.

	If !Empty(cFilterUser).And.!(&cFilterUser.)
		DbSkip()
		Loop
	EndIf

	cCondIf := '! Subs( SE1->E1_TIPO, 1, 2 ) $ "TF~CH~RA"'
	If nSituacao == 2
		cCondIf := '! Subs( SE1->E1_TIPO, 1, 2 ) $ "TF~CH"'
	EndIf

	If &( cCondIf )

		If Subs( SE1->E1_TIPO, 1, 2 ) $ "RA" .and. SE1->E1_VALLIQ == 0
			dbSkip()
			Loop
		Endif

		//If SE1->E1_EMISSAO <= dFechaBase
		nCredito := 0
		nDebito  := 0
		If DToS( SE1->E1_EMISSAO ) < DToS( dFechaIni )
			If ALLTRIM(SE1->E1_TIPO)$"NCC".OR.SUBSTR(SE1->E1_TIPO,3,1)=="-".OR.;
					ALLTRIM(SE1->E1_TIPO)$"RA"
				nCredito := If(nSituacao==1,SE1->E1_VLCRUZ,SE1->E1_SALDO)
			Else
				nDebito := If(nSituacao==1,SE1->E1_VLCRUZ,SE1->E1_SALDO)
			EndIf
		ElseIf DToS( SE1->E1_EMISSAO ) >= DToS( dFechaIni ) .and. DToS( SE1->E1_EMISSAO ) <= DToS( dFechaFim )
			If ALLTRIM(SE1->E1_TIPO)$"NCC".OR.SUBSTR(SE1->E1_TIPO,3,1)=="-".OR.;
					ALLTRIM(SE1->E1_TIPO)$"RA"
				nCredito := If(nSituacao==1,SE1->E1_VLCRUZ,SE1->E1_SALDO)
			Else
				nDebito := If(nSituacao==1,SE1->E1_VLCRUZ,SE1->E1_SALDO)
			EndIf
			If (nDebito + nCredito) != 0
				RecLock( "TRB", .T. )
				TRB->CODIGO  :=  SE1->E1_CLIENTE
				TRB->LOJA    :=  SE1->E1_LOJA
				TRB->CLIENTE :=  SA1->A1_NOME
				TRB->TELEFONE :=  SA1->A1_TEL
				TRB->NUMERO  :=  SE1->E1_NUM
				TRB->TIPO    :=  SE1->E1_TIPO
				TRB->SIGLA   :=  SE1->E1_TIPO
				TRB->PARCELA :=  SE1->E1_PARCELA
				TRB->PREFIXO :=  SE1->E1_PREFIXO
				TRB->DEBITO  :=  nDebito
				TRB->CREDITO :=  nCredito
				TRB->SALTIT  :=  xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,1,DDATABASE)
				If SE1->E1_SALDO > 0.00
					If SE1->E1_VENCTO == dDataBase
						TRB->VENCTO := dDataBase
					ElseIf SE1->E1_VENCTO < dDataBase.And.!Empty(SE1->E1_VENCTO )
						TRB->VENCTO := SE1->E1_VENCTO
						TRB->VENCREA := SE1->E1_VENCREA
					Else
						TRB->VENCTO := SE1->E1_VENCTO
						TRB->VENCREA := SE1->E1_VENCREA
					EndIf
				Else
					TRB->VENCTO := SE1->E1_BAIXA
					TRB->VENCREA := SE1->E1_BAIXA
					TRB->BAIXA := SE1->E1_BAIXA
				EndIf
				TRB->EMISSAO  :=  SE1->E1_EMISSAO
				TRB->SALDO    := TRB->DEBITO - TRB->CREDITO
				MsUnLock()
				cHistor := TABELA("05",ALLTRIM(SE1->E1_TIPO),.F.)
				IF Empty(cHistor)
					If SE1->E1_TIPO == "NCC"
						cHistor := "NOTA DE CREDITO No. "
					ElseIf SE1->E1_TIPO == "NDC"
						cHistor := OemToAnsi("NOTA DE DEBITO No. ")
					ElseIf SE1->E1_TIPO == "NF "
						cHistor := OemToAnsi("FACTURA No. ")
					ElseIf SE1->E1_TIPO == "FT "
						cHistor := OemToAnsi("FACTURA No. ")
					ElseIf SE1->E1_TIPO == "RA "
						cHistor := OemToAnsi("ANTICIPO")
					ElseIf SE1->E1_TIPO == "NCI"
						cHistor := OemToAnsi("NOTA DE CRED. INTERNA")
					ElseIf SE1->E1_TIPO == "NDI"
						cHistor := OemToAnsi("NOTA DE DEB. INTERNA")
					Else
						cHistor := OemToAnsi("NO CLASIFICADO...")
					EndIf
				Endif
				RecLock("TRB",.F.)
				TRB->HISTOR := cHistor
				MsUnLock()
			EndIf
		EndIf
		//EndIf
	EndIf

	dbSelectArea("SE1")
	dbSkip()
End
If lRecibo
	If nSituacao == 1

		dbSelectArea("SEL")
		dbSetOrder(3)
		dbGoTop()
		dbSeek( xFilial( "SEL" ) + cClieIni+cLojaIni,.T. )
		IncProc("Procesando Recibos")
		While !Eof() .and. EL_CLIENTE <= cClieFim ;
				.and. EL_LOJA <= cLojaFim

			SA1->(dbSetOrder(1))
			If SA1->(dbSeek(xFilial("SA1")+SEL->EL_CLIENTE+SEL->EL_LOJA) )
				//
			EndIf

			If nSituacao == 1 //Historico

				If SEL->EL_TIPODOC $ "TB.RA"

					If SEL->EL_DTDIGIT <= dFechaBase .and.  ! SEL->EL_CANCEL

						If DToS( SEL->EL_DTDIGIT ) < DToS( dFechaIni )
							nCredito := SEL->EL_VLMOED1
							dbSkip()
							Loop
						ElseIf DToS( SEL->EL_DTDIGIT ) >= DToS( dFechaInI ) .and. DToS( SEL->EL_DTDIGIT ) <= DToS( dFechaFim )
							RecLock("TRB",.T.)
							TRB->CODIGO  :=  SEL->EL_CLIENTE
							TRB->LOJA    :=  SEL->EL_LOJA
							TRB->CLIENTE :=  SA1->A1_NOME
							TRB->TELEFONE :=  SA1->A1_TEL
							TRB->NUMERO  :=  AllTrim( SEL->EL_RECIBO )
							TRB->PARCELA :=  SEL->EL_PARCELA
							TRB->TIPO    :=  "RC"
							TRB->SIGLA   :=  "RC"
							TRB->EMISSAO :=  SEL->EL_DTDIGIT
							TRB->VENCTO  :=  SEL->EL_DTDIGIT
							TRB->CREDITO := TRB->CREDITO + SEL->EL_VLMOED1
							TRB->SALDO   := TRB->CREDITO*-1
							TRB->SALTIT  := xMoeda(TRB->SALDO,SE1->E1_MOEDA,1,SEL->EL_DTDIGIT)
							cHistor := ""
							If SEL->EL_TIPODOC $ "TB.EF.CH"
								cHistor := "RECIBO No. "
							ElseIf SEL->EL_TIPODOC == "RI"
								cHistor := OemToAnsi("RETENCION IVA")
							ElseIf SEL->EL_TIPODOC == "RG"
								cHistor := OemToAnsi("RET. GANANCIAS")
							ElseIf SEL->EL_TIPODOC == "RA"
								cHistor := OemToAnsi("ANTICIPO")
							ElseIf SEL->EL_TIPODOC == "RB"
								cHistor := OemToAnsi("RET. ING. BRUTOS")
							EndIf
							TRB->HISTOR := cHistor
							MsUnLock()
						EndIf
					EndIf
				EndIf

			Else  //Piendente

				If SEL->EL_TIPODOC $ "TB.RA"

					If ! SEL->EL_CANCEL

						If DToS( SEL->EL_DTDIGIT ) < DToS( dFechaIni )
							nCredito := SEL->EL_VLMOED1
							dbSkip()
							Loop
						ElseIf DToS( SEL->EL_DTDIGIT ) >= DToS( dFechaIni ) .and. DToS( SEL->EL_DTDIGIT ) <= DToS( dFechaFim )
							RecLock("TRB",.T.)

							TRB->CODIGO  :=  SEL->EL_CLIENTE
							TRB->LOJA    :=  SEL->EL_LOJA
							TRB->CLIENTE :=  SA1->A1_NOME
							TRB->TELEFONE :=  SA1->A1_TEL
							TRB->NUMERO  :=  AllTrim( SEL->EL_RECIBO )
							TRB->PARCELA :=  SEL->EL_PARCELA
							TRB->TIPO    :=  "RC"
							TRB->SIGLA   :=  "RC"
							TRB->EMISSAO :=  SEL->EL_DTDIGIT
							TRB->VENCTO  :=  SEL->EL_DTDIGIT
							TRB->CREDITO := TRB->CREDITO + SEL->EL_VLMOED1
							TRB->SALDO   := TRB->CREDITO*-1
							TRB->SALTIT  := xMoeda(TRB->SALDO,SE1->E1_MOEDA,1,SEL->EL_DTDIGIT)
							cHistor := ""
							If SEL->EL_TIPODOC $ "TB.EF.CH"
								cHistor := "RECIBO No. "
							ElseIf SEL->EL_TIPODOC == "RI"
								cHistor := OemToAnsi("RETENCION IVA")
							ElseIf SEL->EL_TIPODOC == "RG"
								cHistor := OemToAnsi("RET. GANANCIAS")
							ElseIf SEL->EL_TIPODOC == "RA"
								cHistor := OemToAnsi("ANTICIPO")
							ElseIf SEL->EL_TIPODOC == "RB"
								cHistor := OemToAnsi("RET. ING. BRUTOS")
							EndIf
							TRB->HISTOR := cHistor
							MsUnLock()
						EndIf
					EndIf
				EndIf
			EndIf
			dbSelectArea("SEL")
			dbSkip()
		End
	EndIf
Endif
Return