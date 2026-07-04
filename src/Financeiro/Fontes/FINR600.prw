/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR600.CH"
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ finr600  ³ Autor ³ Wagner Xavier         ³ Data ³ 05.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impress„o de Boleto                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_finr600(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR600()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Vari veis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL Wnrel
LOCAL cString:="SE1"
LOCAL cDesc1 :=STR0001  //"Este  programa  tem como objetivo imprimir os"
LOCAL cDesc2 :=STR0002  //"Boletos do banco selecionado, conforme layout"
LOCAL cDesc3 :=STR0003  //"previamente configurado."
Local nMoeda, cTexto

PRIVATE cTitulo         := STR0004  //"Impress„o do Boleto em "
PRIVATE aReturn         := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog        :="FINR600"
PRIVATE cPerg           :="FIN600"
PRIVATE aLinha          := { }
PRIVATE nLastKey 		:= 0
PRIVATE cMensagem1      := Space(80)
PRIVATE cMensagem2      := Space(80)
PRIVATE cMensagem3      := Space(80)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li      := 00
I       := J := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("FIN600",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                      ³
//³ mv_par01        	// Qual Banco                            ³
//³ mv_par02        	// Do Bordero                            ³
//³ mv_par03        	// Ate o Bordero                         ³
//³ mv_par04        	// Imprime o local de Pagamento          ³
//³ mv_par05        	// Qual Local De Pagamento               ³
//³                  // Se Vazio Considera Municipio Cliente  ³
//³ mv_par06        	// Qual Moeda                            ³
//³ mv_par07        	// Altera Mensagem                       ³
//³ mv_par08        	// Aceita?                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a fun‡„o SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel   := "FINR600"
wnrel   :=SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,"",,"M")

If nLastKey == 27
	Return
End

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
End

If (nMoeda := mv_par06) == 0
	nMoeda	:= 1
EndIf
cTexto	:= GetMv("MV_MOEDA"+Str(nMoeda,1))
cTitulo	+= cTexto

RptStatus({|lEnd| FA600Imp(@lEnd,wnRel,cString)},cTitulo)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FA600Imp ³ Autor ³ Marcos Patricio       ³ Data ³ 05.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao de Boleto.                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA600Imp(lEnd,wnRelm,Cstring)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Parametro 1 - lEnd    - A‡Æo do CodeBlock                  ³±±
±±³          ³ Parametro 2 - wnRel   - T¡tulo do relat¢rio                ³±±
±±³          ³ Parametro 3 - cString - Mensagem                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static FUNCTION FA600Imp(lEnd,wnRel,cString)

LOCAL lContinua := .T.
LOCAL aBol      :={}
LOCAL aRet      :=array(2)
LOCAL i
LOCAL j
LOCAL cMuni
LOCAL cCgc
LOCAL nNumVias := 1
LOCAL nNumpas  := 60
LOCAL lFirst   := .T.
LOCAL lFirst1  := .T.
LOCAL lEqual   := .F.
LOCAL cSimb    := ""
LOCAL cInd     := ""
LOCAL cEnd1    := ""
LOCAL cEnd2    := ""
LOCAL cEst     := ""
LOCAL cBoleto  := CriaVar("SA6->A6_BOLETO")
LOCAL cCarteira
LOCAL cDataProc
LOCAL nTamCGC := 0
LOCAL nDecs   :=MsDecimais(MV_PAR06)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para Impress„o do Cabe‡alho e Rodap‚    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li      := 00
I       := 0
J 		:= 0

dbSelectArea("SA6")
dbSeek(cFilial+mv_par01)
cMensagem1:= SubStr( A6_MENSAGE,001,80 )
cMensagem2:= SubStr( A6_MENSAGE,081,80 )
cMensagem3:= SubStr( A6_MENSAGE,161,80 )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se banco foi configurado                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF	Empty ( A6_BOLETO )
	Help( " ", 1, "BOLETOCONF" )
	Return
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Permite altera‡„o de mensagem.                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF  mv_par07 == 1
	U_FR600MENS(@cMensagem1,@cMensagem2,@cMensagem3 )
End

SetPrc(000,000)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Efetua teste do formul rio.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_FA600TEST()

Set Device To Printer
dbSelectArea( "SE1" )
dbSetOrder( 5 )
dbSeek( cFilial+mv_par02,.T. )

SetRegua(RecCount())

While   !Eof( ) .And. lContinua .and. E1_NUMBOR <= mv_par03 .And. ;
		E1_FILIAL == cFilial


	IF	lEnd
		@PROW()+1,001 PSAY OemToAnsi(STR0007)  //"CANCELADO PELO OPERADOR"
		Exit
	End

	IncRegua()

	IF	E1_TIPO $ MVABATIM+"/"+MVPROVIS
		dbSkip()
		Loop
	End

	If  E1_PORTADO != mv_par01
		dbSkip()
		Loop
	End

	If  lFirst
		dbSelectArea("SA6")
		cBoleto:= A6_BOLETO
		cMensagem1:= SubStr( A6_MENSAGE,001,80 )
		cMensagem2:= SubStr( A6_MENSAGE,081,80 )
		cMensagem3:= SubStr( A6_MENSAGE,161,80 )
		cDataProc := Substr( A6_BOLETO ,088,06 )
		cCarteira := Substr( A6_BOLETO ,094,06 )
		nNumVias  := Val ( SubStr ( A6_BOLETO,76,1 ) )
		nNumpas   := Val ( SubStr ( A6_BOLETO,77,3 ) )
		cSex      := SubStr (A6_BOLETO,87,1 )
		lEqual    := IIF( SubStr( A6_BOLETO,80,1 ) $ " N" , .F. , .T. )
		cInd      := Str( mv_par06,1,0 )
		cSimb     := Getmv( "MV_SIMB"+cInd )
		dbSelectArea( "SE1" )
		lFirst := .F.
	End

	dbSelectArea( "SA1" )
	dbSeek( cFilial+SE1->E1_CLIENTE+SE1->E1_LOJA )
	nTamCGC	:= Len(AllTrim(A1_CGC))
	cCgc  := IIF(nTamCGC == 11,"CPF - ","CGC - ")+ ;
		IIF(nTamCgc == 11 ,;
		Transform(A1_CGC,"@R 999.999.999-99"),;
		Transform(A1_CGC,"@R 99.999.999/9999-99"))
	cMuni := Trim ( A1_MUN )

	If	EMPTY( A1_ENDCOB )
		cEnd1 := A1_END+" "+A1_BAIRRO
		cEnd2 := A1_MUN+" "+A1_EST+" "+TRANS(A1_CEP,"@R 99999-999")
		cEst  := A1_EST
	Else
		If	"MESMO" $ Upper(Alltrim(A1_ENDCOB))
			cEnd1 := A1_END+" "+A1_BAIRRO
			cEnd2 := A1_MUN+" "+A1_EST+" "+TRANS(A1_CEP,"@R 99999-999")
			cEst  := A1_EST
		Else
			aRet  := U_MontaEnd(A1_ENDCOB)
			cEnd1 := aRet[1]
			cEnd2 := aRet[2]
			cEst  := ""
		End
	End

	dbSelectArea("SE1")

   nAbatimento := SomaAbat(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA,;
                                                 "R", 1,, SE1->E1_CLIENTE)
                                                 
	AADD ( aBol, {	cMuni+" "+cEst,E1_VENCTO, E1_EMISSAO,E1_PREFIXO+E1_NUM+E1_PARCELA,;
              		E1_TIPO,mv_par08,;
                  xMoeda((SE1->E1_VALOR-nAbatimento)+(SE1->E1_SDACRES-SE1->E1_SDDECRE),E1_MOEDA,mv_par06,E1_EMISSAO,nDecs+1),;
						SA1->A1_COD + "  " + SA1->A1_NOME,;
						cEnd1,cEnd2+" - "+cCgc,;
		     			iif(!Empty(cMensagem1),&cMensagem1,""),;
		      			iif(!Empty(cMensagem2),&cMensagem2,""),;
						iif(!Empty(cMensagem3),&cMensagem3,""),;
						iif(!Empty(cDataProc),dDataBase,""),;
						iif(!Empty(cCarteira),RetSitua(E1_SITUACA),"") } )
	J++

   If	lEqual    /* impress„o duas colunas (iguais) */
      Aadd(aBol, aBol[Len(aBol) - If(Len(aBol) = 1, 0, 1)])
		J++
	EndIf

	If J = nNumVias
		U_PrintBol(aBol,nNumVias,@li,nNumpas,cBoleto,cMensagem1,cMensagem2,cMensagem3,cSimb,lFirst1,cCarteira,cDataProc)
		lFirst 	:= .F.
		lFirst1	:= .F.
		aBol	 	:= {}
		J  		:= 0
	End

	dbSkip( )

End

If	!Empty( aBol )
	U_PrintBol(aBol,nNumVias,@li,nNumpas,cBoleto,cMensagem1,cMensagem2,cMensagem3,cSimb,lFirst1,cCarteira,cDataProc)
	lFirst1:= .F.
	aBol := {}
End

Set Device To Screen
If aReturn[5] = 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
End

MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PrintBol ³ Autor ³ Wagner Xavier         ³ Data ³ 12.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime os Boletos de titulos previamente negociados       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PrintBol(aBol,nNumVias,li,nNumpas,cBoleto,cMensagem1,cMensagem2,cMensagem3,cSimb,lFirst1,cCarteira,cDataProc)

Local nL1  := Val(IIf(SubStr(cBoleto,01,3) # "   ",SubStr(cBoleto,01,3),"-9"))
Local nC1  := Val(IIf(SubStr(cBoleto,04,3) # "   ",SubStr(cBoleto,04,3),"-9"))
Local nL2  := Val(IIf(SubStr(cBoleto,07,3) # "   ",SubStr(cBoleto,07,3),"-9"))
Local nC2  := Val(IIf(SubStr(cBoleto,10,3) # "   ",SubStr(cBoleto,10,3),"-9"))
Local nL3  := Val(IIf(SubStr(cBoleto,13,3) # "   ",SubStr(cBoleto,13,3),"-9"))
Local nC3  := Val(IIf(SubStr(cBoleto,16,3) # "   ",SubStr(cBoleto,16,3),"-9"))
Local nL4  := Val(IIf(SubStr(cBoleto,19,3) # "   ",SubStr(cBoleto,19,3),"-9"))
Local nC4  := Val(IIf(SubStr(cBoleto,22,3) # "   ",SubStr(cBoleto,22,3),"-9"))
Local nL5  := Val(IIf(SubStr(cBoleto,25,3) # "   ",SubStr(cBoleto,25,3),"-9"))
Local nC5  := Val(IIf(SubStr(cBoleto,28,3) # "   ",SubStr(cBoleto,28,3),"-9"))
Local nL6  := Val(IIf(SubStr(cBoleto,31,3) # "   ",SubStr(cBoleto,31,3),"-9"))
Local nC6  := Val(IIf(SubStr(cBoleto,34,3) # "   ",SubStr(cBoleto,34,3),"-9"))
Local nL7  := Val(IIf(SubStr(cBoleto,37,3) # "   ",SubStr(cBoleto,37,3),"-9"))
Local nC7  := Val(IIf(SubStr(cBoleto,40,3) # "   ",SubStr(cBoleto,40,3),"-9"))
Local nL8  := Val(IIf(SubStr(cBoleto,43,3) # "   ",SubStr(cBoleto,43,3),"-9"))
Local nC8  := Val(IIf(SubStr(cBoleto,46,3) # "   ",SubStr(cBoleto,46,3),"-9"))
Local nL9  := Val(IIf(SubStr(cBoleto,49,3) # "   ",SubStr(cBoleto,49,3),"-9"))
Local nC9  := Val(IIf(SubStr(cBoleto,52,3) # "   ",SubStr(cBoleto,52,3),"-9"))
Local nL10 := Val(IIf(SubStr(cBoleto,55,3) # "   ",SubStr(cBoleto,55,3),"-9"))
Local nC10 := Val(IIf(SubStr(cBoleto,58,3) # "   ",SubStr(cBoleto,58,3),"-9"))
Local nL11 := Val(IIf(SubStr(cBoleto,61,3) # "   ",SubStr(cBoleto,61,3),"-9"))
Local nC11 := Val(IIf(SubStr(cBoleto,64,3) # "   ",SubStr(cBoleto,64,3),"-9"))
Local nL12 := Val(IIf(SubStr(cBoleto,67,3) # "   ",SubStr(cBoleto,67,3),"-9"))
Local nC12 := Val(IIf(SubStr(cBoleto,70,3) # "   ",SubStr(cBoleto,70,3),"-9"))
Local nL13 := Val(IIf(SubStr(cBoleto,81,3) # "   ",SubStr(cBoleto,81,3),"-9"))
Local nC13 := Val(IIf(SubStr(cBoleto,84,3) # "   ",SubStr(cBoleto,84,3),"-9"))
Local nSal := Val(IIf(SubStr(cBoleto,73,3) # "   ",SubStr(cBoleto,73,3),"-9"))
Local cSex := Subs(cBoleto,87,1)
Local nL14 := Val(IIf(SubStr(cBoleto,88,3) # "   ",SubStr(cBoleto,88,3),"-9"))
Local nC14 := Val(IIf(SubStr(cBoleto,91,3) # "   ",SubStr(cBoleto,91,3),"-9"))
Local nL15 := Val(IIf(SubStr(cBoleto,94,3) # "   ",SubStr(cBoleto,94,3),"-9"))
Local nC15 := Val(IIf(SubStr(cBoleto,97,3) # "   ",SubStr(cBoleto,97,3),"-9"))

__LogPages()

If  lFirst1    // .and. Prow() == 0
	@ PROW(), PCOL() PSAY Chr(27)+Chr(64)
	IF	cSex == "8"
		@ PROW(), PCOL() PSAY Chr(27)+Chr(48)
	End
Else
	If	nSal > 0 ;  li := Prow() + nSal ; Endif
End

If	nNumVias = 1				/* Se so 1 Coluna de boleto */
	If	mv_par04 == 2
      U_PrintField(li,nL1,nC1,"")
	Else
      If Empty(mv_par05)
         U_PrintField(li,nL1,nC1,aBol[1,1])  // Local de Pagamento
      Else
         U_PrintField(li,nL1,nC1,mv_par05)
		End
	End

   U_PrintField( li,nL2 , nC2,  aBol[1,2] )      // Data Vencimento
   U_PrintField( li,nL3 , nC3,  aBol[1,3] )      // Data Emiss„o (Documento)
   U_PrintField( li,nL4 , nC4,  aBol[1,4] )      // No. do Documento
   U_PrintField( li,nL5 , nC5,  aBol[1,5] )      // Esp‚cie Documento (Tipo)
   U_PrintField( li,nL6 , nC6,  aBol[1,6] )      // Aceite

	If	!Empty(cDataProc)
      U_PrintField( li,nL14, nC14, aBol[1,14] )     // Data Processamento
	EndIf

	If !Empty(cCarteira)
      U_PrintField( li,nL15, nC15, aBol[1,15] )     // Carteira
	EndIf	

   U_PrintField( li,nL13, nC13, cSimb )          // Esp‚cie Numer rio

   If  mv_par06 == 1
      U_PrintField( li,nL7 , nC7, aBol[1,7] , Tm(aBol[1,7],16) ) // Valor Moeda Nacional
	Else
      U_PrintField( li,nL8 , nC8, aBol[1,7] , Tm(aBol[1,7],16) ) // Valor Outra Moeda
	End
	If	!Empty ( cMensagem1 )
      U_PrintField( li,nL12 , nC12, subs(aBol[01,11],1,48) )
	End

	If	!Empty ( cMensagem2 )
      U_PrintField( li,nL12+1, nC12, SubStr(aBol[01,12],1,48) )
	End

   If !Empty ( cMensagem3 )
      U_PrintField( li,nL12+2, nC12, SubStr(aBol[01,13],1,48) )
	End
   U_PrintField( li,nL9 , nC9,  aBol[1,8] )          // Codigo e Nome do Sacado
   U_PrintField( li,nL10, nC10, aBol[1,9] )          // Endereco 1a. linha
   U_PrintField( li,nL11, nC11, lTrim(aBol[1,10]) )  // Endereco 2a. linha

	If nL11 > 0 .and. nSal > 0 ;   li+=(nL11+nSal) ; Endif

Else							/* duas colunas de boletos */
	If	mv_par04 == 2
      U_PrintField( li,nL1 , nC1 , "" )
      U_PrintField( li,nL1 + nNumPas, nC1 , "" )
	Else
		If	Empty(mv_par05)
         U_PrintField( li,nL1 , nC1, aBol[1,1] )
         U_PrintField( li,nL1 , nC1+nNumpas , aBol[2,1] )
		Else
         U_PrintField( li,nL1 , nC1, mv_par05 )
         U_PrintField( li,nL1 , nC1+nNumpas, mv_par05 )
		End
   End
   U_PrintField( li,nL2 , nC2 , aBol[1,2] )
   U_PrintField( li,nL2 , nC2+nNumpas, aBol[2,2] )

   U_PrintField( li,nL3 , nC3 , aBol[1,3] )
   U_PrintField( li,nL3 , nC3+nNumpas, aBol[2,3] )

   U_PrintField( li,nL4 , nC4 , aBol[1,4] )
   U_PrintField( li,nL4 , nC4+nNumpas, aBol[2,4] )

   U_PrintField( li,nL5 , nC5 , aBol[1,5] )
   U_PrintField( li,nL5 , nC5+nNumpas, aBol[2,5] )

   U_PrintField( li,nL6 , nC6 , aBol[1,6] )
   U_PrintField( li,nL6 , nC6+nNumpas, aBol[2,6] )

   If ! Empty(cDataProc)
      U_PrintField( li,nL14, nC14, aBol[1,14] )
      U_PrintField( li,nL14, nC14+nNumpas, aBol[2,14] )
	EndIf	

   If ! Empty(cCarteira)
      U_PrintField( li,nL15, nC15, aBol[1,15] )
      U_PrintField( li,nL15, nC15+nNumpas , aBol[2,15] )
	EndIf

   U_PrintField( li,nL13, nC13, cSimb )
   U_PrintField( li,nL13, nC13+nNumpas , cSimb )

	If	mv_par06 == 1
      U_PrintField( li,nL7 , nC7 , aBol[1,7] , Tm(aBol[1,7],16) )
      U_PrintField( li,nL7 , nC7+nNumpas , aBol[2,7] , Tm(aBol[2,7],16) )
	Else
      U_PrintField( li,nL8 , nC8 , aBol[1,7] , Tm(aBol[1,7],16) )
      U_PrintField( li+nL8 , nC8+nNumpas , aBol[2,7] , Tm(aBol[2,7],16) )
	End
	If ! Empty ( cMensagem1 )
      U_PrintField( li,nL12 , nC12 , subs(aBol[01,11],1,48) )
      U_PrintField( li,nL12 , nC12+nNumpas , subs(aBol[02,11],1,48) )
	End

   If ! Empty ( cMensagem2 )
      U_PrintField( li,nL12+1, nC12  , subs(aBol[01,12],1,48) )
      U_PrintField( li,nL12+1, nC12+nNumpas , subs(aBol[02,12],1,48) )
	End

   If ! Empty ( cMensagem3 )
      U_PrintField( li,nL12+2, nC12  , subs(aBol[01,13],1,48) )
      U_PrintField( li,nL12+2, nC12+nNumpas , subs(aBol[02,13],1,48) )
	End

   U_PrintField( li,nL9 , nC9 , aBol[1,8] )
   U_PrintField( li,nL9 , nC9+nNumpas , aBol[2,8] )

   U_PrintField( li,nL10, nC10 , aBol[1,9] )
   U_PrintField( li,nL10, nC10+nNumpas , aBol[2,9] )

   U_PrintField( li,nL11, nC11 , ltrim(aBol[1,10]) )
   U_PrintField( li,nL11, nC11+nNumpas , ltrim(aBol[2,10]) )

   If nL11 > 0 .and. nSal > 0 ;   li+=(nL11+nSal)   ; Endif
End

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FIN600val³ Autor ³ Wagner Xavier         ³ Data ³ 12.01.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Fin600val()
LOCAL lRet
lRet	:=IIF(mv_sn$"sSnN",.T.,.F.)
Return lRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FA600Test³ Autor ³ Wagner Xavier         ³ Data ³ 05/04/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Teste da emiss„o do Boleto                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA600test                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA600TEST()

Local nOpca:=0
Local aSays:={}, aButtons:={},cCadastro := ""

AADD(aSays,OemToAnsi( STR0008 ) ) //"Antes de iniciar a impress„o, verifique se o formul rio continuo est  ajustado."
AADD(aSays,OemToAnsi( STR0009 ) ) //"O teste ser  impresso na coluna de local de pagamento."
AADD(aSays,OemToAnsi( STR0010 ) ) //"Clique no botÆo impressora para teste de posicionamento."
AADD(aSays,OemToAnsi( STR0011 ) ) //"Formul rio posicionado corretamente ?"
AADD(aButtons, { 1,.T.,{|o| nOpca:= 1,o:oWnd:End()}} )
AADD(aButtons, { 6,.T.,{|o| nOpca:= 0,CHECKIMP() }} )
FormBatch( cCadastro, aSays, aButtons )


/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CHECKIMP ³ Autor ³ Marcos Patrico        ³ Data ³ 20/12/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime um caracter no Boleto                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ CHECKIMP                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC Function CHECKIMP()

Set Device to Printer
@ PROW(),PCOL() PSAY "*"
Set Device To Screen

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MontaEnd ³ Autor ³ Wagner Xavier         ³ Data ³ 23.06.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Monta as duas Strings Contendo o endereco do Cliente       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MontaEnd(cCampo)
LOCAL aRet	:= Array ( 2 )
LOCAL nPos	:= 0
nPos 			:= AT("#",cCampo)
If nPos == 0
	aRet[1] := Alltrim(cCampo)
	aRet[2] := ""
Else
	aRet[1] := SubStr( cCampo,1,nPos-1 )
	aRet[2] := SubStr( cCampo,nPos+1,Len( cCampo )-nPos )
End
Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fr600Mens ³ Autor ³ Wagner Xavier         ³ Data ³ 22.12.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Permite alterar mensagem do Boleto                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR600                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FR600Mens(cMensagem1,cMensagem2,cMensagem3)
LOCAL nOpca		:=0

LOCAL oDlg
DEFINE MSDIALOG oDlg FROM 173,9 TO 344,453 TITLE OemToAnsi(STR0018) PIXEL  //"Faturas a Receber"

@ 008, 007 SAY	 A6_COD + "  " + SubStr( A6_NOME, 1,20 )  SIZE 120, 11 OF oDlg PIXEL
@ 020, 007 TO 075, 175 LABEL OemToAnsi(STR0019) OF oDlg PIXEL  //"Mensagens"
@ 032, 014 SAY   OemToAnsi(STR0020) OF oDlg PIXEL  //"Linha 1"
@ 047, 014 SAY   OemToAnsi(STR0021) OF oDlg PIXEL  //"Linha 2"
@ 062, 014 SAY   OemToAnsi(STR0022) OF oDlg PIXEL  //"Linha 3"
@ 030, 040 MSGET cMensagem1 	Valid FR600ERRO() SIZE 120, 11 OF oDlg PIXEL
@ 045, 040 MSGET cMensagem2 	Valid FR600ERRO() SIZE 120, 11 OF oDlg PIXEL
@ 060, 040 MSGET cMensagem3 	Valid FR600ERRO() SIZE 120, 11 OF oDlg PIXEL

DEFINE SBUTTON FROM 07, 187 TYPE 1 ACTION (nOpca:=1,IF(U_FA600Ok(),oDlg:End(),nOpca:=0)) ENABLE OF oDlg
DEFINE SBUTTON FROM 19, 187 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg

IF nOpca = 1
	Reclock( "SA6" )
	SA6->A6_MENSAGE := cMensagem1+cMensagem2+cMensagem3
	MsUnlock( )
ENDIF

Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³FA600OK   ³ Autor ³ Marcos Patricio       ³ Data ³ 20/12/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Confirma mensagens.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR600                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA600Ok()
Local lRet := .F.
If SA6->A6_MENSAGE != cMensagem1+cMensagem2+cMensagem3
	lRet := MsgYesNo(STR0026,STR0025) // "Existem outras mensagens configuradas para o boleto, confirma substituição ?"###"Bordero Gen‚rico ?"
Else
	lRet := MsgYesNo(OemToAnsi(STR0024),OemToAnsi(STR0025))  //"Quanto a grava‡„o ?"###"Bordero Gen‚rico ?"
Endif
Return lRet
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fr600Erro ³ Autor ³ Wagner Xavier         ³ Data ³ 22/12/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Verifica se mensagem est  Ok.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR600                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FR600Erro(  )
LOCAL xResult
LOCAL cForm	:=&(ReadVar())
LOCAL bBlock:=ErrorBlock()
LOCAL bErro := ErrorBlock( { |e| Chk600Erro( e ) } )
PRIVATE lRet:=.T.

IF Empty( cForm );Return .T.;End

BEGIN	SEQUENCE
	xResult := &cForm
END SEQUENCE

ErrorBlock(bBlock)

Return lRet

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Chk600Erro³ Autor ³ Wagner Xavier         ³ Data ³ 22/12/93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Analisa mensagem                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR600                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CHK600Erro( e )
IF	e:gencode > 0
	HELP(" ",1,"ERR_MSG",,e:Description,1,1)
	lRet:=.F.
End
Break

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RetSitua  ³ Autor ³ Pilar Sanchez         ³ Data ³ 02/08/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Retorna a Situa‡„o do Titulo                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR600                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RetSitua( cSitua )
Local cRetorna := Substr(FN022SITCB(cSitua)[9],1,15)
Local lRetSitua:=ExistBlock("RETSITU")

If lRetSitua
	cRetorna := ExecBlock("RETSITU",.f.,.f.)
Endif	
Return cRetorna

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PrintField³ Autor ³ Vin¡cius Barreira    ³ Data ³ 11.08.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime os campos dos boletos sob crit‚rios.               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PrintField( nLi,nlinha,nColuna,uTexto,cPicture )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso a linha ou a coluna n„o tenha sido definido, n„o se imprime   ³
//³ o campo em quest„o.                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nLinha < 0 .Or. nColuna < 0
	Return Nil
Endif

If	ValType(cPicture) == "C"
	@ nLi+nLinha,nColuna PSAY uTexto Picture cPicture
Else
	@ nLi+nLinha,nColuna PSAY uTexto
Endif		

Return Nil

