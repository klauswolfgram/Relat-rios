/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR200.CH"
#Include "PROTHEUS.CH"

Static _oFINR2001
Static lFWCodFil := FindFunction("FWCodFil")

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR200  ³ Autor ³ Vin¡cius Barreira     ³ Data ³ 19.10.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Di rio Sint‚tico em Aberto por Natureza                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR200(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR200()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Vari veis  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel
LOCAL cDesc1 := STR0001  //"Emiss„o do Relat¢rio Di rio Sint‚tico por Natureza. Ser  usado a"
LOCAL cDesc2 := STR0002  //"a data-base do sistema como ponto de partida."
LOCAL cDesc3 :=""
LOCAL cString:="SE7"
Local nMoeda, cTexto


PRIVATE Titulo  := ""
PRIVATE cabec1  := ""
PRIVATE cebec2  := ""
PRIVATE tamanho := "G"
PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:= "FINR200"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   := "FIN200"
PRIVATE nColun  := 0  // Controle de colunas (substitui pCol())
PRIVATE aAreaSM0 := SM0->(GetArea())


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 80
m_pag    := 1

Pergunte( "FIN200" , .F. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parƒmetros                        ³
//³ mv_par01               Da Natureza                          ³
//³ mv_par02               At‚ a Natureza                       ³
//³ mv_par03               N£mero de dias                       ³
//³ mv_par04               Moeda                                ³
//³ mv_par05               Cons.Ped.Compra 1=Sim,2=nao FMQ201   ³
//³ mv_par06               Cons.Ped.Vda. 1=Sim,2=Nao   FMQ201   ³
//³ mv_par07               N¡veis de quebra                     ³
//³ mv_par08               Considera Data Base                  ³
//³ mv_par09               Considera Abatimentos                ³
//³ mv_par10               Considera Filiais                    ³
//³ mv_par11               Filial De                            ³
//³ mv_par12               Filial Ate                           ³
//³ mv_par13               Situacoes a imprimir                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi(STR0005)  //"Diario Sintetico por Natureza"
cabec1 := OemToAnsi(STR0006)  //"Diario Sintetico Por Natureza"
cabec2 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a fun‡„o SETPRINT   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR200"            //Nome Default do relat¢rio em Disco
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho,,.F.)

SM0->(RestArea(aAreaSM0))

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nMoeda	:= mv_par04
cTexto	:= " - " + GetMv("MV_MOEDA"+Str(nMoeda,1))
Titulo	+= cTexto

RptStatus({|lEnd| U_Fa200Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FA200IMP ³ Autor ³ Vin¡cius Barreira     ³ Data ³ 19.10.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Di rio Sint‚tico em Aberto por Natureza                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA200Imp(lEnd,wnRel,cString)
LOCAL cbCont:=0,CbTxt:=Space(10)
LOCAL aNiveis  := {}
LOCAL aQuebras := {}
LOCAL nLaco := 0
LOCAL nByte := 0
LOCAL cMapa := ""
LOCAL nLimBreak := 0
LOCAL nBancos := 0
LOCAL nCaixas := 0
LOCAL nAplicacao := 0
Local nEmprestimo:= 0
LOCAL lPrimeiraPagina := .T.
LOCAL aVenc,nValor,dDataIni
LOCAL lHaMovto := .F.
LOCAL lMovNat	:= .F.
LOCAL nOutroLaco := 0
LOCAL aSemana := {OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010),;     //"Domingo"###"Segunda"###"Terca  "###"Quarta "
						OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013) }              //"Quinta "###"Sexta  "###"Sabado "
LOCAL aCalc   := {}
Local aDtCabec := {}		// array das datas do cabecalho de dias
Local nBlocOld := 0		// controla bloco anterior p/imprimir cabecalho de dias
Local dDataCabec := dDataBase
Local dDtMovim := dDataBase
Local cBancoCx
LOCAL lSaldoDia:= .F.
LOCAL lResulDia:= .F.

Local cSavFil  := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
Local dUltData := dDataBase
Local dDataTrab:= dDataBase
Local nX       := 0
Local nY       := 0
Local nZ			:= 0
Local nDays
LOCAL cFilDe ,;
	  	cFilAte,;
	  	cNatAnt,;
	  	bNatureza := { || IF( mv_par10 == 1, .T., SED->ED_FILIAL == xFilial("SED") .AND.;
	  							                       	SED->ED_CODIGO <= mv_par02 ) }
Local nDias
Local nBlocos
Local lFirst := .T.
Local nValAux	:= 0

cBancoCx := GetMV("MV_CARTEIR")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Lˆ a formata‡„o do c¢digo das naturezas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMascNat := GetMV("MV_MASCNAT")
cMapa    := "123456789"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida limite de quebra.      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 >= Len( cMascNat )
	mv_par07 := Len( cMascNat ) - 1
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula a ultima data do relatorio, baseado no parametro que informa a  ³
//³qtde. de dias (MV_PAR03), pois o relatorio precisa processar datas em   ³
//³multiplos de oito dias.                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 0 To MV_PAR03 STEP 8
	nZ := IIF(mv_par03-nX >= 8,8,MOD(mv_par03,8))	
	For nY := 1 TO nZ
		If nX == 0 .AND. nY == 7
			Exit
		EndIf
		dUltData++
		While Dow(dUltData) == 1 .or. Dow(dUltData) == 7
			dUltData++
		Enddo
	Next nY
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par10 == 2
	cFilDe  := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	cFilAte := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
ELSE
	cFilDe := mv_par11	// Todas as filiais
	cFilAte:= mv_par12
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gera arquivo de Trabalho      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos:={	{"NATUR", "C" , Len(SED->ED_CODIGO),0},;
	         {"DATAX", "D" , 08,0},;
	         {"ENTR" , "N" , 17,2},;
	         {"SAID" , "N" , 17,2}}

//------------------
//Criação da tabela temporaria 
//------------------
If _oFINR2001 <> Nil
	_oFINR2001:Delete()
	_oFINR2001 := Nil
Endif

_oFINR2001 := FWTemporaryTable():New( "cArqTmp" )  
_oFINR2001:SetFields(aCampos) 	
_oFINR2001:AddIndex("1", {"DATAX","NATUR"}) 	
_oFINR2001:Create()	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica a Disponibilidade Financeira                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cEmpAnt+cFilDe,.T.)
While SM0->(!Eof()) .And. SM0->M0_CODIGO == cEmpAnt .And. IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) <= cFilAte
	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se existe Operacao Financeira a ser resgatada no dia ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SEH")

	If !Empty(FwFilial("SEH")) .Or. (Empty(FwFilial("SEH")) .And. lFirst)
		dbSetOrder(2)
		dbSeek(xFilial("SEH")+"A",.T.)
		While ( !Eof() .And. SEH->EH_FILIAL == xFilial("SEH") .And. SEH->EH_STATUS == "A" )
			aCalc := Fa171Calc(dDataBase+MV_PAR03)
			If ( SEH->EH_APLEMP == "EMP" )
				If cPaisLoc == "BRA"
					nEmprestimo += xMoeda(aCalc[2,1],1,MV_PAR04)
				Else
					nEmprestimo += xMoeda(aCalc[2,1],SEH->EH_MOEDA,MV_PAR04)
				Endif
			Else
				If cPaisLoc == "BRA"
					nAplicacao += xMoeda(aCalc[1],1,MV_PAR04)
				Else
					nAplicacao += xMoeda(aCalc[1],SEH->EH_MOEDA,MV_PAR04)
				Endif
			EndIf
			dbSelectArea("SEH")
			dbSkip()
		EndDo
		dbSelectArea("SEH")
		dbSetOrder(1)
	Endif	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica disponibilidade banc ria                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If !Empty(FwFilial("SA6")) .Or. (Empty(FwFilial("SA6")) .And. lFirst)
		dbSelectArea("SA6")
		dbSeek(xFilial("SA6"))
		While ! Eof() .and. SA6->A6_FILIAL == xFilial("SA6")
			If SA6->A6_FLUXCAI <> "N"
				If SubStr(SA6->A6_COD,1,2) = "CX" .or. SA6->A6_COD $ cBancoCx
					nValAux := RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
					If cPaisLoc == "BRA"
						nCaixas += nValAux
					Else
						nCaixas += xMoeda(nValAux,SA6->A6_MOEDA,MV_PAR04)
					Endif
				Else
					nValAux := RecSalBco(SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON,dDataBase)
					If cPaisLoc == "BRA"
						nBancos += nValAux
					Else
						nBancos += xMoeda(nValAux,SA6->A6_MOEDA,MV_PAR04)
					Endif
				EndIf
			EndIf
			dbSelectArea("SA6")
			dbSkip()
		Enddo
	Endif	
	
	lFirst  := .F.
	If cPaisLoc == "BRA"
		nBancos := xMoeda(nBancos,1,MV_PAR04)
		nCaixas := xMoeda(nCaixas,1,MV_PAR04)
	Endif

	If mv_par05 == 1
	
      dbSelectArea("SC7")
      dbSeek(xFilial("SC7"))
      While !Eof() .and. xFilial("SC7") == C7_FILIAL

         If !Empty(C7_RESIDUO)
            dbSkip()
            Loop
         Endif

         If ( SC7->C7_FLUXO != "N" )
			If cPaisLoc == "BRA"
	            nValor := C7_PRECO * (C7_QUANT-C7_QUJE) * (1+C7_IPI/100)
			Else
	            nValor := C7_PRECO * (C7_QUANT-C7_QUJE)
			Endif
            dbSelectArea("SA2")
            dbSeek(xFilial("SA2")+SC7->C7_FORNECE)
				IF SA2->A2_NATUREZ >= mv_par01 .and. SA2->A2_NATUREZ <= mv_par02
               dbSelectArea("SED")
               dbSetOrder(1)
               If (dbSeek(xFilial("SED")+SA2->A2_NATUREZ))
                  If nValor > 0 
                     dDataIni := IIF(SC7->C7_DATPRF < dDataBase,dDataBase,SC7->C7_DATPRF)
                     aVenc := Condicao ( nValor,SC7->C7_COND,0,dDataIni)
                     nValor := nValor / len(aVenc)
                     For nX := 1 to Len(aVenc)
                        IF DataValida(aVenc[nX][1],.T.) <= dUltData
                           dbSelectArea("cArqTmp")
                           IF dbSeek(dTos(DataValida(aVenc[nX][1],.T.))+SED->ED_CODIGO)
                              RecLock("cArqTmp")
                           Else
                              RecLock("cArqTmp",.T.)
										cArqTmp->NATUR := SA2->A2_NATUREZ
                              cArqTmp->DATAX := DataValida(aVenc[nX][1],.T.)
                           Endif
							If cPaisLoc == "BRA"
	                           cArqTmp->SAID  += xMoeda(nValor,1,mv_par04)
							Else
	                           cArqTmp->SAID  += xMoeda(nValor,SC7->C7_MOEDA,mv_par04)
	      					Endif
                           msUnlock()
                        Endif
                     Next
					   EndIf		
               Endif
            Endif
         EndIf
         dbSelectArea("SC7")
         dbSkip()
      Enddo
   Endif
   If mv_par06 == 1
      dbSelectArea("SC6")
      dbSeek(xFilial("SC6"))
      While !Eof() .and. xFilial("SC6") == C6_FILIAL
         // Se for residuo ou se o TES nao gera duplicata, despreza o registro		
         If Alltrim(C6_BLQ) == "R" .OR.;
			   (SF4->(DBSEEK(xFilial()+SC6->C6_TES)) .AND.;
				 SF4->F4_DUPLIC == "N")
            dbSkip()
            Loop
         Endif
			nValor := C6_PRCVEN * (C6_QTDVEN-C6_QTDENT)
         dbSelectArea("SA1")
         dbSeek(xFilial("SA1")+SC6->C6_CLI)
			IF  SA1->A1_NATUREZ >= mv_par01 .and.  SA1->A1_NATUREZ <= mv_par02
            dbSelectArea("SED")
            dbSetOrder(1)
            If (dbSeek(xFilial("SED")+SA1->A1_NATUREZ))
               SC5->(dbSeek(xFilial("SC5")+SC6->C6_NUM))
               IF nValor > 0  .and. SC5->C5_TIPO == "N"
                  dbSelectArea("SB1")
                  dbSeek(cFilial + SC6->C6_PRODUTO)
                  If cPaisLoc == "BRA"
	                  nValor *= (1+SB1->B1_IPI/100)
	              Endif
                  dDataIni := IIF(SC6->C6_ENTREG < dDataBase,dDataBase,SC6->C6_ENTREG)
                  aVenc := Condicao ( nValor,SC5->C5_CONDPAG,0,dDataIni)
                  nValor := nValor / len(aVenc)
                  For nX := 1 to Len(aVenc)
                     If DataValida(aVenc[nX][1],.T.) <= dUltData
                        dbSelectArea("cArqTmp")
                        IF dbSeek(DtoS(DataValida(aVenc[nX][1],.T.))+SED->ED_CODIGO)
                           RecLock("cArqTmp")
                        Else
                           RecLock("cArqTmp",.T.)
									cArqTmp->NATUR := SA1->A1_NATUREZ
                           cArqTmp->DATAX := DataValida(aVenc[nX][1],.T.)
                        Endif
                        If cPaisLoc == "BRA"
	                        cArqTmp->ENTR  += xMoeda(nValor,1,mv_par04)
						Else
	                        cArqTmp->ENTR  += xMoeda(nValor,SC5->C5_MOEDA,mv_par04)
						Endif
                        msUnlock()
                     Endif
                  Next
				   EndIf
            Endif
         Endif
         dbSelectArea("SC6")
         dbSkip()
      Enddo
   Endif

	dbSelectArea("SM0")
	dbSkip()
EndDo
cFilAnt := cSavFil
SM0->(RestArea(aAreaSM0))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa os titulos a receber                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GeraTmp("SE1",3,dUltData,cFilDe,cFilAte)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa os titulos a pagar                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR10 == 1
	cFilDe := MV_PAR11	// Todas as filiais
	cFilAte:= MV_PAR12
Else
	cFilDe  := xFilial("SE2")
	cFilAte := xFilial("SE2")	
EndIf
GeraTmp("SE2",2,dUltData,cFilDe,cFilAte)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz informa em que posi‡”es ser„o feitas as quebras.   ³
//³ 1-Byte inicial da quebra, 2-Quantidade de caracteres.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aNiveis  := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Esta matriz ANIVEIS estrutura os ponteiros usados na      ³
//³ verifica‡Æo de quebras de naturezas.                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nLaco := 1 to len( cMascNat )
	nByte := Val( Substr( cMascNat,nLaco,1 ) )
	If nByte > 0
		AAdd( aNiveis  , { Val(Left(cMapa,1)) , nByte} )
		cMapa := Subst(cMapa,nByte+1,Len(cMapa)-nByte)
	Endif
Next
nLimBreak := IIf(Len(aNiveis) > 1, Len(aNiveis)-1, 1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ nLimite armazena o n¡vel de quebra m ximo. Caso o Usu rio   ³
//³ parametrize um limite menor, ‚ respeitado o parƒmetro do    ³
//³ usu rio.                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 > 0 .and. mv_par07 < nLimBreak
	nLimBreak := mv_par07
Endif

If mv_par07 == 0
	nLimBreak := 1
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Cria a principal matriz para verificar      ³
//³  quebras e imprimir valores.                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nMultpl8 :=  IIf(mv_par03 > 8, Int ( mv_par03 / 8 ) + 1, 1)
nMultpl8 *= 8
nMultpl8 += 2
aQuebras := Array( Len(aNiveis), nMultpl8 )
For nLaco := 1 to Len( aQuebras )
	aQuebras[nLaco,1] := ""
	For nDias := 2 to nMultpl8
		aQuebras[nLaco,nDias] := 0
	Next
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o relat¢rio a partir do arquivo tempor rio  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nBlocos   := 0
nHeader   := 0
nDias     := 0
nDays		 := 2  // dias para controle da coluna de atraso e database
dDataTrab := dDataBase
nValor    := 0
aTotDia   := { 0,0,0,0,0,0,0 }
cLinha    := "|" + Replicate("-",47) + "|" + Replicate("-----------------|",9)
nTotLinha := 0
nSaldoDoDia := 0

IF mv_Par10 == 1
   cIndex := CriaTrab(nil,.f.)
   dbSelectArea("SED")
   IndRegua("SED",cIndex,"ED_CODIGO",,,OemToAnsi(STR0014))  //"Selecionando Registros..."
   nIndex := RetIndex("SED")
   dbSelectArea("SED")
   #IFNDEF TOP
      SED->(dbSetIndex(cIndex+OrdBagExt()))
   #ENDIF
   SED->(dbSetOrder(nIndex+1))
   SED->(dbGoTop())
ENDIF   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o relat¢rio a partir do arquivo tempor rio  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lPrimeiraPagina := .T.
dbSelectArea("cArqTmp")
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Avan‡a blocos de 8 em 8 dias. Caso o n£mero de dias for menor      ³
//³ que sete ou nÆo for m£ltiplo de 8, nÆo h  problema, pois o         ³
//³ arquivo tempor rio nÆo armazenar  datas fora do n£mero de dias     ³
//³ selecionados.                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nBlocos := 1 to mv_par03 Step 8

	If li > 58
		cabec(Titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")) )
		If lPrimeiraPagina
			lPrimeiraPagina := .F.
			Li++
			@LI++,00 PSAY OemToAnsi(STR0015)  //"SALDO EM CAIXA      : "
			@Prow(),23 PSAY nCaixas    Picture tm(nCaixas,16) //"@E 999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0016)  //"SALDO EM BANCOS     : "
			@Prow(),23 PSAY nBancos    Picture tm(nBancos,16) //"@E 999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0017)  //"SALDO EM APLICACOES : "
			@Prow(),23 PSAY nAplicacao Picture tm( nAplicacao,16) //"@E 999,999,999.99"
			@LI++,00 PSAY OemToAnsi(STR0018)  //"SALDO EM EMPRESTIMOS: "
			@Prow(),23 PSAY nEmprestimo Picture tm(nEmprestimo,16) //"@E 999,999,999.99"

			nSaldoDoDia += nBancos
			nSaldoDoDia += nCaixas
			nSaldoDoDia += nAplicacao
			nSaldoDoDia -= nEmprestimo

			@LI++,00 PSAY OemToAnsi(STR0019)  //"TOTAL DO DISPONIVEL : "
			@Prow(),23 PSAY nSaldoDoDia Picture tm(nSaldoDoDia,16) //"@E 999,999,999.99"
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Desenha sempre os cabe‡alhos de data pois o la‡o s¢ passar       ³
	//³  por aqui quando quebrar a data.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nBlocos > 1
		++li
	Endif
	U_Fin200Cabec(nBlocos,nHeader,aSemana,@aDtCabec,@nBlocOld,@dDataCabec)

	aTotDia := { 0,0,0,0,0,0,0,0 }
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura as naturezas nos dias abrangidos     ³
	//³ Por nBlocos (Acima) e nDias (Abaixo)         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DBSELECTAREA("SED")
	if mv_par10 == 1
      SED->(dbSetOrder(nIndex+1))
	   If !Empty(mv_par01)
	      SED->(dbSeek( mv_par01 ))
	   Else
	      SED->(dbGoTop())
	   Endif
	else
	   SED->(dbSetOrder(1))
	   If !Empty(mv_par01)
	      SED->(dbSeek( xFilial("SED")+mv_par01 ))
	   Else
	      SED->(dbseek( xFilial("SED") ))
	   Endif
	endif   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta o aspecto VERTICAL do relat¢rio, sempre em blocos de 8 dias   ³
	//³ definidos pelo la‡o nBlocos acima definido.                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While SED->(!Eof()) .AND. EVAL( bNatureza )
        cNatAnt := SED->ED_CODIGO
		If li > 58
			If !lSaldoDia .or. !lResulDia
				@++li,00 PSAY cLinha
			Endif
			Cabec(Titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,GetMv("MV_COMP"),GetMv("MV_NORM")) )
			U_Fin200Cabec(nBlocos,nHeader,aSemana,@aDtCabec,@nBlocOld,@dDataCabec)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se houve movimenta‡Æo d'aquela natureza para imprimir ou   ³
		//³ nÆo a linha contendo aquela natureza.                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("cArqTmp")
		lHaMovto := .F.
		dDtMovim := dDataBase - 1
		For nOutroLaco := 0 to mv_par03
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data que se busca movimentacao nao ‚ a data  ³
			//³ referente aos atrasos ou DataBase. Caso seja, nao verifica ³
			//³ se a mesma ‚ Sabado ou Domingo pois ser  impresso na coluna³
			//³ de atrasos ou database.												³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If dDtMovim > dDataBase
				While Dow(dDtMovim) == 1 .or. Dow(dDtMovim) == 7
					dDtMovim++
				Enddo
			Endif
			If dbSeek(dTos(dDtMovim)+SED->ED_CODIGO )
				If cArqTmp->ENTR !=0 .or. cArqTmp->SAID !=0
					lHaMovto := .T.
					lMovNat	:= .T.
					Exit
				Endif
			Endif
			dDtMovim++
		Next
		If !lHaMovto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  Inicia a matriz acumuladora de quebras  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			For nLaco := 1 to Len( aQuebras )
				aQuebras[nLaco,1] := Subst( SED->ED_CODIGO,aNiveis[nLaco,1],aNiveis[nLaco,2] )
			Next
			dbSelectArea("SED")
            DO WHILE SED->ED_CODIGO == cNatAnt
		       dbSkip()
            ENDDO
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  Verifica se houve quebra em algum n¡vel ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			U_f200totnat(nLimBreak,aQuebras,aNiveis,@lMovNat,nBlocos)
			Loop
		Endif

		// Se for n¡vel 0 o relat¢rio ser  sint‚tico.
		If mv_par07 > 0
			lSaldoDia := .F.
			lResulDia := .F.
			@++li,00 PSAY  "|" + Trim(Mascnat(SED->ED_CODIGO) + ' ' + Left(SED->ED_DESCRIC,30) )
			@li,48   PSAY  "|"
		Endif
		dbSelectArea("cArqTmp")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta o aspecto HORIZONTAL do Relat¢rio.               ³
		//³ Caso nÆo encontre a data, imprime espa‡os em branco    ³
		//³ para manter o alinhamento.                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTotLinha := 0
		nDays := 2
		For nDias := 1 to 8
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Caso seja primeiro bloco, procura pelos atrasos e valo-³
			//³ res referentes a data base.                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nBlocos == 1 .and. nDias < 3
				If dbSeek( dTos(dDaTaBase+1-nDays) + SED->ED_CODIGO )
					nValor := cArqTmp->Entr - cArqTmp->Said
					aTotDia[ nDias ] += cArqTmp->Entr - cArqTmp->Said
					nTotLinha += nValor
					For nLaco := 1 to Len(aQuebras)
						aQuebras[nLaco,( nBlocos+nDias ) ] += nValor
					Next

					// Se for n¡vel 0 o relat¢rio ser  sint‚tico.
					If mv_par07 > 0 .and. nValor != 0
						@Prow(),33+(nDias*18) PSAY nValor Picture tm(nValor,13)//"@E 99,999,999.99"
					Endif
				Endif
				nDays --
			Else
				If dbSeek( dTos(aDtCabec[nDias]) + SED->ED_CODIGO )
					nValor := cArqTmp->Entr - cArqTmp->Said
					aTotDia[ nDias ] += cArqTmp->Entr - cArqTmp->Said
					nTotLinha += nValor
					For nLaco := 1 to Len(aQuebras)
						aQuebras[nLaco,( nBlocos+nDias ) ] += nValor
					Next
					// Se for n¡vel 0 o relat¢rio ser  sint‚tico.
					If mv_par07 > 0 .and. nValor != 0
						@Prow(),33+(nDias*18) PSAY nValor Picture tm(nValor,13) // "@E 99,999,999.99"
					Endif
				Endif
			Endif
			// Se for n¡vel 0 o relat¢rio ser  sint‚tico.
			If mv_par07 > 0
				@Prow(),48 + ((nDias*18))   PSAY "|"
			Endif
		Next
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Imprime o total daquela linha daquela p gina     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par07 > 0
			@Prow(),194  PSAY nTotLinha Picture tm(nTotLinha,15) //"@E 9999,999,999.99"
			@Prow(),210	 PSAY "|"
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Inicia a matriz acumuladora de quebras  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nLaco := 1 to Len( aQuebras )
			aQuebras[nLaco,1] := Subst( SED->ED_CODIGO,aNiveis[nLaco,1],aNiveis[nLaco,2] )
		Next
		dbSelectArea("SED")
        DO WHILE SED->ED_CODIGO == cNatAnt
		   dbSkip()
        ENDDO
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Verifica se houve quebra em algum n¡vel ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_f200totnat(nLimBreak,aQuebras,aNiveis,@lMovNat,nBlocos)
	enddo	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  ImpressÆo dos TOTAIS quando houver quebras por dia ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@++li,00 PSAY OemToAnsi(STR0021)   //"| RESULTADO DO DIA"
	@li,48   PSAY "|"
	lResulDia := .T.
	nTotLinha := 0
	For nDias := 1 to 8
		dDataTrab := dDataBase + nBlocos + nDias - 3
		nTotLinha += aTotDia[ nDias ]
		@Prow(),31 + ((nDias*18)) PSAY aTotDia[ nDias ] Picture tm(aTotDia[ nDias ],16) // "@E 99,999,999.99"
		@Prow(),48 + ((nDias*18)) PSAY "|"
	Next
	@Prow(),193      PSAY nTotLinha Picture tm(nTotLinha,16) //"@E 9999,999,999.99"
	@Prow(),210      PSAY "|"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  ImpressÆo dos SALDOS quando houver quebras por dia ³
	//³  Observe que o array aTotDia somente ‚ limpo neste  ³
	//³  ponto do programa                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@++li,00 PSAY cLinha
	@++li,00 PSAY OemToAnsi(STR0022)  //"| SALDO DO DIA"
	@li,48   PSAY "|"
	lSaldoDia := .T.
	nTotLinha := 0
	For nDias := 1 to 8
		nSaldoDoDia += aTotDia[nDias]
		@Prow(),31 + ((nDias*18)) PSAY nSaldoDoDia Picture tm(nSaldoDoDia,16) //"@E 99,999,999.99"
		@Prow(),48 + ((nDias*18)) PSAY "|"
		nTotLinha := nSaldoDoDia
		aTotDia[ nDias ] := 0
	Next
	@Prow(),193      PSAY nTotLinha Picture tm(nTotLinha,16) //"@E 9999,999,999.99"
	@Prow(),210      PSAY "|"
	@++li,00         PSAY  cLinha
Next                                                         

roda(cbcont,cbtxt,"G")

Set Device To Screen
Set Filter To

If mv_Par10 == 1
   dbSelectArea("SED")
   dbClearFil()
   RetIndex("SED")
   FErase(cIndex+OrdBagExt())
   DbSetOrder(1)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga arquivos tempor rios  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("cArqTmp")
cArqTmp->( dbCloseArea() )

If _oFINR2001 <> Nil
	_oFINR2001:Delete()
	_oFINR2001 := Nil
Endif

dbSelectArea("SE1")
If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()
Return Nil

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fin200Cabec³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 10/09/98³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Printa o cabe‡alho dos dias da semana                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fin200Cabec(nBlocos,nHeader,aSemana,aDtCabec,nBlocOld,		³±±
±±³          ³             dDataCabec)												   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nBlocos  - N£mero de dias em m£ltiplos de 8 (uma semana).   ³±±
±±³          ³ nHeader  - Dia do mes/da semana do bloco em questao.        ³±±
±±³          ³ aSemana  - Array com os dias da semana por extenso.         ³±±
±±³          ³ aDtCabec - Array com as datas do bloco.                     ³±±
±±³          ³ nBlocOld - Guarda o bloco anterior p/recalcular datas ou nao³±±
±±³          ³ dDataCabec - Ultima data calculada no cabecalho.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Financeiro - FINR200.PRX                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fin200Cabec(nBlocos,nHeader,aSemana,aDtCabec,nBlocOld,dDataCabec)

LOCAL aMeses := { OemToAnsi(STR0023),OemToAnsi(STR0024),OemToAnsi(STR0025),;   //"Janeiro"###"Fevereiro"###"Marco"
	OemToAnsi(STR0026),OemToAnsi(STR0027),OemToAnsi(STR0028),;   //"Abril"###"Maio"###"Junho"
	OemToAnsi(STR0029),OemToAnsi(STR0030),OemToAnsi(STR0031),;   //"Julho"###"Agosto"###"Setembro"
	OemToAnsi(STR0032),OemToAnsi(STR0033),OemToAnsi(STR0034) }   //"Outubro"###"Novembro"###"Dezembro"

Local nCount := 8

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica, pelo numero de linhas se podera imprimir o cabecalho	³
//³ nesta pagina, evitando que imprima cabecalho sem linha de dados  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li < 55
	@++li,00 PSAY cLinha
	@++li,00 PSAY OemToAnsi(STR0035)  //"| HISTORICO/DIAS"
	@li,48   PSAY "|"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica mudanca de bloco para atualizar o array de datas. Caso³
	//³o Array esteja vazio, alimenta o Array.                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF nBlocOld <> nBlocos
		aDtCabec := {}
		nBlocOld := nBlocos
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se for 1§ bloco, imprime coluna de Atrasos e da DataBase      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nBlocos == 1
			AADD (aDtCabec,dDataBase-1)
			dDataCabec:= dDataBase
			AADD (aDtCabec,dDataCabec)
			nCount := 6
		Endif
		For nHeader := 1 to nCount
			dDataCabec++
			While Dow(dDataCabec) == 1 .or. Dow(dDataCabec) == 7
				dDataCabec++
			Enddo
			AADD (aDtCabec,dDataCabec)
		Next
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime datas.                                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nColun := 48
	For nHeader :=1 to 8
		If nHeader ==1 .and. nBlocos == 1
			nColun += 18
			@Prow(),54       PSAY OemToAnsi(STR0036)  //"Atrasos "
			@Prow(),nColun   PSAY "|"
		Else
			nColun+=4
			@Prow(),nColun       PSAY aDtCabec[nHeader]
			nColun+=14
			@Prow(),nColun PSAY "|"
		Endif
	Next
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime Coluna de Subtotal no cabecalho.                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@Prow(),195 PSAY OemToAnsi(STR0037)  //"SUBTOTAL DA"
	@Prow(),210 PSAY "|"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime dias da semana ref as datas do bloco.                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@++li,00 PSAY "| " + aMeses[Month( dDataCabec )]
	@li,48   PSAY "|"
	nColun := 48
	For nHeader := 1 to 8
		If nHeader ==1 .and. nBlocos == 1
			nColun += 18
			@Prow(),nColun PSAY "|"
		Else
			nColun+=5
			@Prow(),nColun PSAY aSemana[ Dow(aDtCabec[nHeader]) ]
			nColun += 13
			@Prow(),nColun PSAY "|"
		Endif

	Next
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime coluna de complemento do Subtotal no cabecalho.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nColun += 6
	@Prow(),nColun PSAY OemToAnsi(STR0038)  //"NATUREZA"
	@Prow(),210 PSAY "|"
	@++li,00 PSAY  cLinha
Else
	li := 80
Endif
Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ F200TotNatc³ Autor ³ Mauricio Pequim Jr    ³ Data ³ 09/12/98³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total da natureza, na quebra de natureza	         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_f200totnat(nLimBreak,aQuebras,aNiveis,lMovNat)  	         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Financeiro - FINR200.PRX                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function f200totnat(nLimBreak,aQuebras,aNiveis,lMovNat,nBlocos)
Local nSavRec
Local nSavRec2
Local cSeekSED
Local cCodSED
Local nCtrl
Local nToCtrl
LOCAL nSetOrder := SED->(INDEXORD())
LOCAL nLaco, nQuebras, nDias, nTotLinha
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Verifica se houve quebra em algum n¡vel ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SED->( DBSETORDER(1) )
For nLaco := 1 to nLimBreak
	If aQuebras[nLaco,1] # Subst( SED->ED_CODIGO, aNiveis[nLaco,1], aNiveis[nLaco,2] )
		For nQuebras := nLimBreak to nLaco Step -1
			nSavRec := SED->( Recno() )
			dbSeek( xFilial("SED") + aQuebras[nQuebras,1] )
			nTotLinha := 0
			For nDias := 1 to 8
				If aQuebras[nQuebras, nBlocos+nDias ] # 0
					nTotLinha += aQuebras[nQuebras, nBlocos+nDias ]
				Endif
			Next
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime totais de natureza que tenham Movimento  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nTotLinha != 0 .or. lMovNat
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica a Descricao da Natureza Totalizada ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nSavRec2 := SED->( Recno() )
				cCodSED  := aQuebras[nQuebras,1]
				cSeekSED := ""
				If lMovNat
					nToCtrl  := IIF(mv_par07 > 0, mv_par07, 1)
					For nCtrl := 1 to nToCtrl
						cSeekSED += aQuebras[nCtrl,1]
					Next
					dbSeek( xFilial("SED") + cSeekSED )
					cCodSED := MascNat(SED->ED_CODIGO)
				EndIf
				li++
				@li,00 PSAY "|"
				@li,07 PSAY OemToAnsi(STR0020) + cCodSED + " " + Left( SED->ED_DESCRIC , 20 )  //"TOTAL - "
				@li,48 PSAY "|"

				SED->( dbGoTo( nSavRec2 ) )

				lMovNat := .F.

				For nDias := 1 to 8
					If aQuebras[nQuebras, nBlocos+nDias ] # 0
						@Prow(),32 + ((nDias*18)) PSAY aQuebras[nQuebras, nBlocos+nDias ] Picture Tm(aQuebras[nQuebras, nBlocos+nDias ], 14 ) //"@E 99,999,999.99"
					Endif
					aQuebras[nQuebras, nBlocos+nDias ] := 0
					@Prow(),48 + ((nDias*18))   PSAY "|"
				Next
				@Prow(),194 PSAY nTotLinha Picture Tm( nTotLinha, 15 ) // "@E 9999,999,999.99"
				@Prow(),210 PSAY "|"
				@++li,00 PSAY cLinha
			Endif
			SED->( dbGoTo( nSavRec ) )
		Next
	Endif
Next
SED->(DBSETORDER(nSetOrder))
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GeraTmp   ºAutor  ³Claudio D. de Souza º Data ³  29/08/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera dados no arquivo temporario, a partir do arquivo de    º±± 
±±º          ³titulos a receber ou do arquivo de titulos a pagar          º±±
±±º          ³Parametros:                                                 º±±
±±º          ³cAlias   -> Alias do arquivo de titulos (SE1 ou SE2)        º±±
±±º          ³nOrdem   -> Ordem por natureza do arquivo cAlias            º±±
±±º          ³dUltData -> Ultima data do periodo do relatorio             º±±
±±º          ³cFilDe   -> Filial inicial                                  º±±
±±º          ³cFilAte  -> Filial final                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR200                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION GeraTmp(cAlias,nOrdem,dUltData,cFilDe,cFilAte)
LOCAL cAliasTmp ,;
		dDataTrab ,;
		nX			 ,;
		aSaldo    ,;
		cTipo    := If(Upper(cAlias)=="SE1", MVRECANT+"/"+MV_CRNEG, MVPAGANT+"/"+MV_CPNEG),;
		cCampo   := Right(cAlias,2),;
		cCampTmp := If(Upper(cAlias)=="SE1", "Entr", "Said"),;
		lMvMultNat := &("MV_MULNAT"+If(cAlias=="SE1","R","P"))
		
#IFDEF TOP
	Local	aStru
	Local cQuery	 
#ELSE
	Local nIndex
	Local cIndTmp
	
#ENDIF		
		
#IFDEF TOP
	aStru  := (cAlias)->(dbStruct())
	cAliasTmp := "FINR200"
	cQuery := ""
	aEval(aStru,{|x| cQuery += ","+AllTrim(x[1])})
	cQuery := "SELECT "+SubStr(cQuery,2)
	cQuery +=         ",R_E_C_N_O_ RECNO "
	cQuery += "FROM "+RetSqlName(cAlias)+ " "+ cAlias + " "
	cQuery += "WHERE "
	If mv_par10 == 1
		cQuery += cAlias + "." + cCampo + "_FILIAL BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' AND "
	Else
		cQuery += cAlias + "." + cCampo + "_FILIAL = '"+ xFilial(cAlias)+"' AND "
	Endif		
	cQuery += "("+cAlias + "." + cCampo + "_MULTNAT = '1' OR ("
	cQuery += cAlias + "." + cCampo + "_NATUREZ BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "
	cQuery += cAlias + "." + cCampo + "_NATUREZ <> '"+Space(Len((cAlias)->&(cCampo+"_NATUREZ")))+"')) AND "
	cQuery += cAlias + "." + cCampo + "_EMISSAO <= '"+Dtos(dDataBase)+"' AND "
	cQuery += cAlias + "." + cCampo + "_VENCREA <= '"+Dtos(dUltData)+"' AND "
	If cAlias=="SE1"
		cQuery += cAlias + "." + cCampo + "_SITUACA IN "+FormatIn(mv_par13,,1)+" AND "
	Endif
	If ( MV_PAR08 == 2 )
		cQuery += cAlias + "." + cCampo + "_SALDO > 0 AND "
	EndIf
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Nao considerar titulos gerados a partir de uma FATURA para ³
	//³nao duplicar a demonstração.                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	cQuery += "NOT (" + cAlias + "." + cCampo + "_FATURA <> ' ' AND " + cAlias + "." + cCampo + "_FATURA <> 'NOTFAT' AND " + cAlias + "." + cCampo  + "_DTFATUR <= '" + DTOS(dDataBase) + "') AND "
	cQuery += cAlias + "." + cCampo + "_FLUXO<>'N' AND "
	cQuery += cAlias + ".D_E_L_E_T_=' ' "

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTmp,.T.,.T.)	
	For nX :=  1 To Len(aStru)
		If aStru[nX][2] <> "C"
			TcSetField(cAliasTmp,aStru[nX][1],aStru[nX][2],aStru[nX][3],aStru[nX][4])
		EndIf
	Next nX
#ELSE
	dbSelectArea(cAlias)
	dbSetOrder(nOrdem)
	cIndTmp := CriaTrab(,.F.)
	
	IndRegua(cAlias,cIndTmp,IndexKey(),,U_Fr200Fil(cCampo,cFilDe,cFilAte,dUltData))
	nIndex := RetIndex(cAlias)
	dbSetIndex(cIndTmp+OrdBagExt())
	dbSetOrder(nIndex+1)
	dbGotop()
	cAliasTmp := cAlias
#ENDIF


dbSelectArea(cAliasTmp)
While ( !Eof() ) //IndRegua
	// Se estiver utilizando multiplas naturezas, verifica o arquivo de multiplas
   // naturezas (SEV)
   If lMvMultnat .And. (cAliasTmp)->&(cCampo+"_MULTNAT") == "1"
	   If !U_PesqNatSev(cAliasTmp,cCampo, mv_par01, mv_par02)
			DbSkip()
			Loop
		Endif	
	Else
		If &(cCampo+"_NATUREZ") > mv_par02 .OR. &(cCampo+"_NATUREZ") < mv_par01
			DbSkip()
			Loop
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se considera ou nÆo adiantamentos		  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR09 == 2 .and. (cAliasTmp)->&(cCampo +"_TIPO") $ cTipo
		dbSkip()
		Loop
	EndIf
	If (cAliasTmp)->&(cCampo +"_VENCREA") < dDataBase
		dDataTrab := dDataBase - 1
	Else
		dDataTrab := DataValida((cAliasTmp)->&(cCampo+"_VENCREA"),.T.)
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se a data de vencto. ultrapassar a ultima data do relatorio ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If dDataTrab > dUltData
		dbSkip()
		Loop
	EndIf
	#IFDEF TOP
		// Posiciona SE2 ou SE1 para pegar o saldo do titulo correto
		(cAlias)->(DbGoto((cAliasTmp)->RECNO))
	#ENDIF
	aSaldo := SdoTitNat((cAliasTmp)->&(cCampo+"_PREFIXO"),;
							  (cAliasTmp)->&(cCampo+"_NUM")    ,;
							  (cAliasTmp)->&(cCampo+"_PARCELA"),;
							  (cAliasTmp)->&(cCampo+"_TIPO")   ,;
							  (cAliasTmp)->&(cCampo+If(Upper(cAlias)=="SE1","_CLIENTE","_FORNECE")),;
							  (cAliasTmp)->&(cCampo+"_LOJA"),;
							  (cAliasTmp)->&(cCampo+"_NATUREZ"),;
					 		  If(cAlias=="SE1","R","P")        ,;
							  cAliasTmp                        ,;
							  MV_PAR04                         ,;
							  MV_PAR08 == 1)
	For nX := 1 To Len(aSaldo)
		If Abs(aSaldo[nX][2]) > 0.0001 	.And.;
			aSaldo[nX][1] >= MV_PAR01   	.And.;
			aSaldo[nX][1] <= MV_PAR02 	  	.And.;
			(If(MV_PAR08 == 1, (cAliasTmp)->&(cCampo+"_SALDO") <> 0 .Or. ((cAliasTmp)->&(cCampo+"_SALDO") == 0 .And. dDatabase < (cAliasTmp)->&(cCampo+"_BAIXA")), (cAliasTmp)->&(cCampo+"_SALDO") <> 0 ))		
			dbSelectArea( "cArqTmp" )
			If !(dbSeek(dTos(dDataTrab)+aSaldo[nX][1]))
				RecLock("cArqTmp",.T.)
				cArqTmp->NATUR := aSaldo[nX][1]
				cArqTmp->DATAX := dDataTrab
			Else
				RecLock("cArqTmp")
			EndIf
			If (cAliasTmp)->&(cCampo+"_TIPO") $ MVABATIM + "/" + cTipo
				cArqTmp->&(cCampTmp) -= aSaldo[nX][2]
			Else
				cArqTmp->&(cCampTmp) += aSaldo[nX][2]
			EndIf
		EndIf
	Next
	dbSelectArea(cAliasTmp)
	dbSkip()
Enddo
#IFDEF TOP
	dbSelectArea(cAliasTmp)
	dbCloseArea()
	dbSelectArea(cAlias)
#ELSE
	dbSelectArea(cAlias)
	DbClearFil()
	RetIndex(cAlias)
	FErase(cIndTmp+OrdBagExt())
#ENDIF

RETURN NIL
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Fr200Fil    ³ Autor ³ Claudio Donizete Souza³ Data ³ 31/05/01³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Expressao de filtro para base CDX, tratando mult.Naturezas   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Fr200Fil(cCampo, cFilDe,cFilAte,dUltData)                   ³±±
±±³          ³ cCampo     - Campo do arquivo de titulo "E1" ou "E2"        ³±±
±±³          ³ cFilDe     - Filial inicial                                 ³±±
±±³          ³ cFilAte    - Filial final                                   ³±±
±±³          ³ dUltData   - Ultima data para o filtro a ser considerada    ³±±
±±³          ³              no VENCREA                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Financeiro - FINR200.PRX                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fr200Fil( cCampo, cFilDe, cFilAte, dUltData)
Local cFiltro             ,;
		cAlias  := Alias()  
Local	cArq		:= "S"+cCampo		

If mv_par10 = 1
	cFiltro := cCampo + "_FILIAL>='"+cFilDe+"'.And."
	cFiltro += cCampo + "_FILIAL<='"+cFilAte+"'.And."
Else
	cFiltro := cCampo + "_FILIAL=='"+xFilial(cArq)+"'.And."
Endif
cFiltro += "("+cCampo + "_MULTNAT='1'.Or."
cFiltro += "("+cCampo + "_NATUREZ>='"+MV_PAR01+"'.And."	
cFiltro += cCampo + "_NATUREZ<='"+MV_PAR02+"'.And."
cFiltro += cCampo + "_NATUREZ<>'"+Space(Len((cAlias)->&(cCampo + "_NATUREZ")))+"')).And."
cFiltro += "Dtos(" + cCampo + "_VENCREA)<='"+Dtos(dUltData)+"'.And."
cFiltro += "Dtos(" + cCampo + "_EMISSAO)<='"+Dtos(dDataBase)+"'.And."
If cAlias=="SE1"
	cFiltro += cCampo + "_SITUACA$'"+mv_par13+"'.And."	
Endif
If MV_PAR08==2
   cFiltro += cCampo + "_SALDO>0.And."
EndIf
/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Nao considerar titulos gerados a partir de uma FATURA para ³
//³nao duplicar a demonstração.                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
cFiltro += "!(!Empty(" + cCampo + "_FATURA).And.SUBSTR(" + cCampo + "_FATURA,1,6)!='NOTFAT'.And.DTOS(" + cCampo  + "_DTFATUR)<='" + DTOS(dDataBase) + "').And."
cFiltro += cCampo + "_FLUXO<>'N'"

Return cFiltro

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PesqNatSev  ³ Autor ³ Claudio Donizete Souza³ Data ³ 01/06/01³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Pesquisa a natureza no SEV, de acordo com o titulo           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PesqNatSev(cAlias,cCampo,cNatIni,cNatFim)                   ³±±
±±³          ³ cAlias     - Alias do arquivo de titulos                    ³±±
±±³          ³ cCampo     - Campo do arquivo de titulo "E1" ou "E2"        ³±±
±±³          ³ cNatIni    - Natureza Inicial        					   ³±±
±±³          ³ cNatFim    - Natureza Final 								   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Financeiro - FINR200.PRX                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PesqNatSev( cAlias, cCampo, cNatIni, cNatFim )
LOCAL aArea := GetArea(),;
		cChaveSev		   ,;
		aAreaSev := SEV->(GetArea()),;
		lAchouSev := .F.

DbSelectArea("SEV")
cChaveSev := RetChaveSev(cAlias,cCampo)
If MsSeek(cChaveSev)
	// Pesquisa as naturezas para o titulo
	While xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+;
										EV_LOJA) == cChaveSev .And. !Eof()
		// Verifica se a natureza esta dentro dos parametros estabelecidos
		If SEV->EV_NATUREZ>= cNatIni .And.;
			SEV->EV_NATUREZ<= cNatFim .And.;
			!Empty(SEV->EV_NATUREZ)
			lAchouSev := .T.
			Exit
		Endif	
		DbSkip()
	EndDo
Endif

RestArea( aAreaSev )
RestArea( aArea )
		
Return lAchouSev
               
