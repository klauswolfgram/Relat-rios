/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "rwmake.ch"
#INCLUDE "SIGAWIN.CH"
#INCLUDE "FINR890.CH"
#define DOCUMENTOS    "1"
#define VALORES       "2"
#define ADIANTAMENTOS "3"
#define INVALIDO      "0"


#define DescrTipo(cTipo)   (If(cTipo == "CH", STR0028, If(cTipo == "TC", STR0029, If(cTipo == "EF", STR0030, ""))))

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FINR890  ³ Autor ³ Rubens Joao Pante     ³ Data ³ 15/08/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descripcio³ Informe para generacion del Comprobante de Ingreso         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ General localizacion Colombia                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³  DATA    ³ BOPS ³                  ALTERACAO                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³04.10.00  ³xxxxxx³Acerto das perguntas para a versao 5.08              ³±±
±±³          ³Rubens³                                                     ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR890()
   Local cInd
   Local aOrd         := {}
   Local cDesc1       := OemToAnsi(STR0001) //"Este programa tiene como objetivo imprimir informe "
   Local cDesc2       := OemToAnsi(STR0002) //"de acuerdo con los parametros informados por el usuario."
   Local cDesc3       := OemToAnsi(STR0003) //"Comprobante de Ingreso"
   Local cPict        := ""
   Local titulo       := OemToAnsi(STR0004) //"Comprobante de Ingreso"
   Private lEnd       := .F.
   Private lAbortPrint:= .f.
   Private limite     := 79
   Private tamanho    := "P"
   Private nomeprog   := "FINR890" // Coloque aqui el nombre del programa para impresion en el encabezamiento
   Private nTipo      := 18
   Private aReturn    := {OemToAnsi(STR0005) /* "A Rayas" */, 1, ;
                          OemToAnsi(STR0006) /* "Administracion" */, 1, 2, 1, "", 1}
   Private nLastKey   := 0
   Private wnrel      := "SEL" // Coloque aqui el nombre del archivo usado para impresion en disco
   Private cString    := "SEL"
   Private cPerg      := "FIN890"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica existencia de EF_COMPROB³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SX3->(dbSetOrder(2))
    If ! SX3->(dbSeek("EF_COMPROB"))
      MsgStop("EF_COMPROB nao encontrado. Crie segundo campo EF_COMPROV")
      Return
    EndIf

   /*
   +----------------------------------------------------------+
   |Definicion de Variables ambientes                         |
   +----------------------------------------------------------+
   | Variables utilizadas para parametros                     |
   |   mv_par01		Numero de Comprobante de Ingreso          |
   |   mv_par02		Concepto							      |
   +----------------------------------------------------------+
   */
  
   Pergunte(cPerg,.f.)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Monta la interfase estandar con el usuario...                       ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
   If ! nLastKey == 27
      SetDefault(aReturn,cString)
      If ! nLastKey == 27
         nTipo := If(aReturn[4]==1,15,18)
         RptStatus({|lEnd| RunReport(@lEnd, wnrel, cString)},Titulo)
      Endif
   Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFunction  ³RunReport ºAutor  ³Rubens Joao Pante   º Data ³  11/08/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprima el informe de Comprobante de Ingreso                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ General localizacion Colombia                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RunReport //(lEnd, wnrel, cString)
   Local  cDocumento, cTipoDoc, cConcepto,  cNomeBanco, nDocumento, nCont, cDocAnter
   Local nValor,    nValIVA,    nValFTE,    nValCom
   Local lPriDoc    := lPriVal := lPriAnt := .t.
   Local aDocumento := {}
   Private nTotal   := nTotIVA := nTotFTE :=  nTotCom := 0
   Private nLin     := 99

   cFil := xFilial("SEL")
   SEL->(dbsetorder(8))
   If SEL->(dbseek(xFilial("SEL")+mv_par03+mv_par01))
      SA1->(dbsetorder(1))
      SA1->(dbseek(xFilial("SA1")+SEL->EL_Cliente+SEL->EL_Loja))
      SA6->(dbsetorder(1))
      SA6->(dbseek(xfilial("SA6")+SEL->El_BANCO+SEL->EL_AGENCIA))
      cNomeBanco := SA6->A6_NOME
      SE1->(dbsetorder(2))
   Endif

   DO While SEL->EL_FILIAL+SEL->EL_RECIBO+SEL->EL_SERIE == xFilial("SEL")+mv_par01+mv_par03
      cOrdem := If(SEL->El_TipoDoc $ "TB", DOCUMENTOS, ;
                If(SEL->El_TipoDoc $ "CH,EF,TC", VALORES, ;
                If(SEL->El_TipoDoc $ "RA", ADIANTAMENTOS, INVALIDO)))
      IF cOrdem != INVALIDO
         AADD(aDocumento, cOrdem + STR(SEL->(RECNO()),9))
         If cOrdem == DOCUMENTOS
           nTotal += SEL->EL_Valor
         EndIF
      EndIf
      SEL->(dbskip())
   EndDo

   aDocumento := ASORT(aDocumento)
   nDocumento := Len(aDocumento)
   SetRegua(nDocumento)
   For nCont := 1 TO nDocumento
      SEL->(DbGoto(VAL(Substr(aDocumento[nCont],2)))) // posicion SEL no reg. adequado
      cDocumento := SEL->EL_Numero
      nValor     := SEL->EL_Valor
      cTipoDoc   := SEL->EL_TipoDoc
      nValIVA    := 0
      nValFTE    := 0
      nValCom    := 0
      If SF2->(dbseek(xFilial("SF1")+SEL->EL_Cliente+SEL->EL_Loja+SEL->EL_Numero))
         cDocumento := SF2->F2_Doc
         nValIVA  := SF2->F2_ValImp1
         nValFTE  := SF2->F2_ValImp5
      EndIf
      If SE1->(dbseek(xFilial("SE1")+SEL->EL_Cliente+SEL->EL_Loja+SEL->EL_Prefixo+;
                SEL->EL_Numero+SEL->EL_Parcela))
         nValCom := SE1->E1_ValCom1
      EndIf

      If nLin >= 60  // Imprime cabecalho de pagina
         cConcepto := If(mv_par02 == 1, Upper(OemToAnsi(STR0010)) /*PAGO FACTURAS*/,;
                       If(mv_par02 == 2, Upper(OemToAnsi(STR0011)) /*ABONO*/, ;
                       If(mv_par02 == 3, Upper(OemToAnsi(STR0012)) /*CANCELACION FACTURA*/,;
                       If(mv_par02 == 4, Upper(OemToAnsi(STR0013)) /*Fuctura Expancion*/,;
                       If(mv_par02 == 5, Upper(OemToAnsi(STR0014)) /*Fuctura Expansion*/,;
                          "")))))
         @ 03,01 PSAY OemToAnsi(SM0->M0_NomeCom)
         @ 03,53 PSAY OemToAnsi(STR0016) //"Emision   :"
	     @ 03,72 PSAY dtoc(dDataBase)
         @ 04,01 PSAY OemToAnsi(STR0004) //"Comprobante de Ingreso"
         @ 04,53 PSAY OemToAnsi(STR0017) // "No.       :"+
         @ 04,74 PSAY Alltrim(mv_par03)+Iif(Empty(mv_par03),"   "," - ")+mv_par01
         @ 05,01 PSAY OemToAnsi(STR0018) + cConcepto //"Concepto: "
         @ 05,53 PSAY OemToAnsi(STR0019) //"Valor     :"
         @ 05,65 PSAY nTotal Picture PesqPict("SEL","EL_VALOR",15,1)
         @ 08,01 PSAY OemToAnsi(STR0020) + SA1->A1_Nome //"Cliente : "
         cDocAnter := Substr(aDocumento[nCont],1,1)
         nTotal    := 0
         nLin      := 10
      EndIf

      If aDocumento[nCont] = DOCUMENTOS
         If lPriDoc
            // "DOCUMENTO                 VALOR     VLR.IVA  VLR.RET.FTE     COMISION"
            @ nLin,  06 PSAY OemToAnsi(STR0021)
            @ nLin+1,01 PSAY Replicate("-",limite)
            nLin    += 2
            lPriDoc := .f.
         EndIf
         @ nLin,06 PSAY cDocumento
         @ nLin,23 PSAY nValor     Picture PesqPict("SEL","EL_VALOR",14,1)
         @ nLin,38 PSAY nValIVA    Picture PesqPict("SF2","F2_VALIMP1",11,1)
         @ nLin,51 PSAY nValFTE    Picture PesqPict("SF2","F2_VALIMP5",11,1)
         @ nLin,64 PSAY nValCom    Picture PesqPict("SE1","E1_VALCOM1",11,1)
         nTotal  += nValor
         nTotIVA += nValIVA
         nTotFTE += nValFTE
         nTotCom += nValCom
      EndIf

      If aDocumento[nCont] = VALORES
         If lPriVal
            ImpTotal(! lPriDoc, ! lPriVal, ! lPriAnt)
            @ nLin,  06 PSAY OemToAnsi(STR0022) //"PAGOS                     VALOR"
            @ nLin+1,01 PSAY Replicate("-",40)
            nLin    += 2
            lPriVal := .f.
            nTotal  := 0
         EndIf
         @ nLin,06 PSAY DescrTipo(SEL->EL_TipoDoc) // Esta no .CH
         @ nLin,23 PSAY nValor     Picture PesqPict("SEL","EL_VALOR",14,1)
         nTotal += nValor
      EndIf

      If aDocumento[nCont] = ADIANTAMENTOS
         If lPriAnt
            ImpTotal(! lPriDoc, ! lPriVal, ! lPriAnt)
            // "PAGOS ANTECIPADO       VALOR"
            @ nLin++,06 PSAY OemToAnsi(STR0023) //"PAGOS ANTECIPADO          VALOR"
            @ nLin++,01 PSAY Replicate("-",40)
            lPriAnt := .f.
            nTotal  := 0
         EndIf
         @ nLin,06 PSAY OemToAnsi(STR0024) //"Pago Antecipado"
         @ nLin,23 PSAY nValor     Picture PesqPict("SEL","EL_VALOR",14,1)
         nTotal += nValor
      EndIf

      nLin++
      IncRegua()
   Next

   If nLin != 99
      ImpTotal(! lPriDoc, ! lPriVal, ! lPriAnt)
      @ nLin,   01 PSAY Replicate("-",limite)
      @ nlin+2 ,01 PSAY OemToAnsi(STR0026) + cNomeBanco // "BANCO : "
      @ nlin+30,50 PSAY Replicate("-",30)
      @ nlin+31,50 PSAY OemToAnsi(STR0027) // "FIRMA RECIBO / IDENTIFICACION"
   EndIf

   SET DEVICE TO SCREEN
   If aReturn[5]==1
      dbCommitAll()
      SET PRINTER TO
      OurSpool(wnrel)
   Endif
   MS_FLUSH()
Return

// Controla a impressao dos rodapes com os totais
Static Function ImpTotal(lImprimiuDoc, lImprimiuVal, lImprimiuAnt)
   Do Case
      Case lImprimiuAnt
         @ nLin,06 PSAY OemToAnsi(STR0025) //"TOTAL........"
         @ nLin,23 PSAY nTotal     Picture PesqPict("SEL","EL_VALOR",14,1)
      Case lImprimiuVal
         @ nLin,06 PSAY OemToAnsi(STR0025) //"TOTAL........"
         @ nLin,23 PSAY nTotal     Picture PesqPict("SEL","EL_VALOR",14,1)
      Case lImprimiuDoc
         @ nLin,06 PSAY OemToAnsi(STR0025) //"TOTAL........"
         @ nLin,23 PSAY nTotal     Picture PesqPict("SEL","EL_VALOR",14,1)
         @ nLin,38 PSAY nTotIVA    Picture PesqPict("SF2","F2_VALIMP1",11,1)
         @ nLin,51 PSAY nTotFTE    Picture PesqPict("SF2","F2_VALIMP5",11,1)
         @ nLin,64 PSAY nTotCom    Picture PesqPict("SE1","E1_VALCOM1",11,1)
   EndCase
   nLin += 2
Return
