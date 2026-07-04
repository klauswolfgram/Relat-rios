/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR410.CH"
#Include "PROTHEUS.CH"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR410  ³ Autor ³ Adilson Hideki yamaguchi ³ Data ³ 14/06/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Cheque Recebidos por Baixas a Receber             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR410(void)                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FinR410()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1    := STR0001  //"Este relatorio ira imprimir a rela‡„o de cheques Recebidos,"
Local cDesc2    := STR0002  //"por Baixas a Receber"
Local cDesc3    := ""
Local wnrel
Local cString   := "SEF"
Local Tamanho   := "M"
Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa	:= {}
Local aPergs := {}

Private titulo  := STR0003  //"Rela‡„o de Cheques Recebidos."
Private cabec1
Private cabec2
Private aReturn := { OemToAnsi(STR0004), 1,OemToAnsi(STR0005), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private nomeprog:= "FINR410"
Private aLinha  := { },nLastKey := 0
Private cPerg   := "FIR410"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos Cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0006)  //"Relacao de Cheques Recebidos"

If cPaisLoc == "BRA"
	cabec1 := OemToAnsi(STR0007)  //"Numero                   Valor Emissao  Beneficiario                              Historico"
Else
	cabec1 := OemToAnsi(STR0016)  //"Numero                   Valor Emissao  Vencto.  Beneficiario                              Historico"
EndIf

cabec2 := " "

pergunte("FIR410",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                      ³
//³ mv_par01            // Do Banco                           ³
//³ mv_par02            // Ate o Banco                        ³
//³ mv_par03            // Da Agencia                         ³
//³ mv_par04            // Ate a Agencia                      ³
//³ mv_par05            // Da Conta                           ³
//³ mv_par06            // Ate a Conta                        ³
//³ mv_par07            // Do Cheque                          ³
//³ mv_par08            // Ate o Cheque                       ³
//³ mv_par09            // Da Emissao                         ³
//³ mv_par10            // Ate a Emissao                      ³
//³ mv_par11            // Qual moeda                         ³
//³ mv_par12            // Outras moedas                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:= "FINR410"            //Nome Default do relatorio em Disco
aOrd := {OemToAnsi(STR0008),OemToAnsi(STR0009) }  //"Por Cheque"###"Por Emissao"
wnrel:= SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey = 27
	Return
EndIf

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
EndIf

RptStatus({|lEnd| Fa410Imp(@lEnd,wnRel,cString)},titulo)
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA410Imp ³ Autor ³ Paulo Boschetti       ³ Data ³ 15.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Cheque Emitidos                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA410Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡ao do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem			                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function FA410Imp(lEnd,wnRel,cString)

Local CbCont,CbTxt
Local tamanho   := "M"
Local limite    := 132
Local nOrdem
Local nTotch:=0,nTotVal:=0,nTotchg:=0,nTotValg:=0,nFirst:=0
Local lContinua := .T.,nTipo
Local cCond1,cCond2,cCarAnt, nValorEF
Local cFilialA6 := xFilial("SA6")
Local cCarteira := "R"
#IFDEF TOP
	Local aStru     := SEF->(dbStruct()), ni
#ENDIF
Local cFilterUser:=aReturn[7]

Private nDecs   := MsDecimais(mv_par11)

nTipo:=Iif(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1
nOrdem   := aReturn[8]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o Cabecalho em funcao da Carteira      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := OemToAnsi(STR0017) //"Numero                   Valor  Emissao     Emitente                                  Historico"

SA6->(DbSetorder(1)) // Para pegar moeda do banco
dbSelectArea("SEF")

SetRegua(RecCount())
#IFDEF TOP
	If TcSrvType() != "AS/400"

		cOrder := SqlOrder(SEF->(IndexKey(nOrdem)))
		cQuery := "SELECT * "
		cQuery += "  FROM "+	RetSqlName("SEF")
		cQuery += " WHERE EF_FILIAL = '" + xFilial("SEF") + "' AND "
	  	cQuery += "EF_BANCO   >= '" + mv_par01 + "' AND EF_BANCO   <= '"  + mv_par02 + "' AND "
		cQuery += "EF_AGENCIA >= '" + mv_par03 + "' AND EF_AGENCIA <= '"  + mv_par04 + "' AND "
		cQuery += "EF_CONTA   >= '" + mv_par05 + "' AND EF_CONTA   <= '"  + mv_par06 + "' AND "
		cQuery += "EF_NUM     >= '" + mv_par07 + "' AND EF_NUM     <= '"  + mv_par08 + "' AND "
		cQuery += "EF_DATA    >= '" + Dtos(mv_par09) + "' AND EF_DATA    <= '"  + Dtos(mv_par10) + "' AND "
        cQuery += "EF_IMPRESS <> 'A' AND "
        cQuery += "EF_IMPRESS <> 'C' AND "
		cQuery += "EF_NUM <> '" + Space(Len(EF_NUM))+ "' AND "

		If cPaisLoc != "BRA"
		    If !(AllTrim(Upper(TCGetDB())) $ "ORACLE_INFORMIX")
			   cQuery += " SUBSTRING(EF_NUM,1,1) <> '*' AND "
		    Else
			   cQuery += " SUBSTR(EF_NUM,1,1) <> '*' AND "
		    EndIf
		EndIf

		cQuery += "EF_CART = 'R' AND "

		cQuery += "EF_ORIGEM = 'FINA070' AND "

		cQuery += "D_E_L_E_T_ = ' ' "

		cQuery += " ORDER BY "+ cOrder
		cQuery := ChangeQuery(cQuery)

		dbSelectArea("SEF")
		dbCloseArea()
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SEF', .F., .T.)

		For ni := 1 to Len(aStru)
			If aStru[ni,2] != 'C'
				TCSetField('SEF', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
			EndIf
		Next

		If (SEF->(EOF()))
			dbSelectArea("SEF")
			dbCloseArea()
			ChkFile("SEF")
			dbSelectArea("SEF")
			dbSetOrder(1)
			Return
	   EndIf
	Else

#ENDIF

		If nOrdem = 1
			dbSetOrder(1)
			dbSeek(cFilial+mv_par01+mv_par03+mv_par05+mv_par07,.T.)
		Else
			dbSetOrder(2)
			dbSeek(cFilial+mv_par01+mv_par03+mv_par05+Dtos(mv_par09),.T.)
		EndIf

#IFDEF TOP
	EndIf
#ENDIF

If nOrdem = 1
	cCond1 := "EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM <= mv_par02+mv_par04+mv_par06+mv_par08"
	cCond2 := "EF_BANCO+EF_AGENCIA+EF_CONTA"
Else
	cCond1 := "EF_BANCO+EF_AGENCIA+EF_CONTA+DTOS(EF_DATA) <= mv_par02+mv_par04+mv_par06+DTOS(mv_par10)"
	cCond2 := "EF_BANCO+EF_AGENCIA+EF_CONTA"
EndIf

While &cCond1 .And. !Eof() .And. lContinua .and. EF_FILIAL == cFilial

	If lEnd
		@Prow()+1,001 Psay OemToAnsi(STR0010)  //"Cancelado pelo Operador"
		Exit
	EndIf

	IncRegua()

	If EF_IMPRESS $ "AC"		//Integrante de outro Cheque ou cancelado
		dbSkip()
		Loop
	Endif

	If Empty( EF_NUM ) .Or. ( cPaisLoc<>"BRA" .And. Subs( EF_NUM,1,1)="*")
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Validacao da carteira.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SEF->EF_CART # 'R'
		DbSkip()
		Loop
	EndIf

	nTotVal := nTotCh := nFirst := 0
	cCarAnt := &cCond2

	While &cCond2 == cCarAnt .And. !Eof() .and. cFilial == EF_FILIAL

		If lEnd
			@Prow()+1,001 Psay OemToAnsi(STR0010)  //"Cancelado pelo operador"
			lContinua := .F.
			Exit
		Endif

		IncRegua()
     	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSkip()
			Loop
		Endif


		If Empty( EF_NUM ) .Or. ( cPaisLoc<>"BRA" .And. Subs( EF_NUM,1,1)="*")
			dbSkip( )
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Validacao da carteira.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SEF->EF_CART # 'R'
			DbSkip()
			Loop
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se esta dentro dos parametros                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If  EF_BANCO   < mv_par01 .OR. EF_BANCO   > mv_par02 .or. ;
				EF_AGENCIA < mv_par03 .OR. EF_AGENCIA > mv_par04 .or. ;
				EF_CONTA   < mv_par05 .OR. EF_CONTA   > mv_par06 .or. ;
				EF_NUM     < mv_par07 .OR. EF_NUM     > mv_par08 .or. ;
				EF_DATA    < mv_par09 .OR. EF_DATA    > mv_par10
			dbSkip( )
			Loop
		Endif

		If EF_IMPRESS $ "AC"	//Integrante de outro Cheque ou cancelado
			dbSkip( )
			Loop
		Endif

		// Desconsidera cheques com moeda diferente se escolhido nao imprimir
		SA6->(dbSeek(cFilialA6+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA))
		If mv_par12 == 2 .AND. !Empty(SA6->A6_MOEDA) .And. SA6->A6_MOEDA != mv_par11
		   dbSkip()
		   Loop
		EndIf

		If li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			nFirst:=0
		Endif

		If nFirst = 0
			dbSelectArea( "SA6" )
			dbSeek(cFilialA6+SEF->EF_BANCO+SEF->EF_AGENCIA+SEF->EF_CONTA)
			@li, 0 Psay OemToAnsi(STR0011) +A6_COD+" - "+AllTrim(A6_NREDUZ)+OemToAnsi(STR0012)+A6_AGENCIA+" Conta : "+SA6->A6_NUMCON  //"Banco : "###" -  Agencia : "
			li += 2
			nFirst++
		Endif

		dbSelectArea( "SEF" )
		@li ,   0 Psay SEF->EF_NUM

		If cPaisLoc <> "BRA"
			nValorEF := xMoeda(SEF->EF_VALOR, SA6->A6_MOEDA, mv_par11,SEF->EF_DATA,nDecs+1)
			@li ,  16 Psay nValorEF           Picture TM(SEF->EF_VALOR,14,nDecs)
			@li ,  32 Psay SEF->EF_DATA
			@li ,  42 Psay SEF->EF_VENCTO

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 			//³ Imprime o Beneficiario em funcao da Carteira   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@ li,  51 Psay Substr(SEF->EF_EMITENT,1,40)   // "Emitente"

			@li ,  95 Psay Substr(SEF->EF_HIST,1,31)
			nTotVal += nValorEF
		Else
			@li ,  16 Psay SEF->EF_VALOR     Picture TM(SEF->EF_VALOR,14)
			@li ,  32 Psay SEF->EF_DATA

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 			//³ Imprime o Beneficiario em funcao da Carteira   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			@ li,  44 Psay SEF->EF_EMITENT   // "Emitente"

			@li ,  86 Psay Substr(SEF->EF_HIST,1,40)
			nTotVal += SEF->EF_VALOR
		EndIf

		nTotCh++
		dbSkip()
		li++
	Enddo

	If nTotVal > 0
		SubTot410(nTotVal,limite)
	EndIf

	nTotChg  += nTotCh
	nTotValg += nTotVal
EndDo

If nTotValg > 0
	TotGer410(nTotChg,nTotValg)
EndIf

If li != 80
	roda(cbcont,cbtxt,"M")
EndIf

Set Device To Screen
dbSelectArea("SEF")

#IFDEF TOP
	If TcSrvType() != "AS/400"
		dbCloseArea()
		ChkFile("SEF")
		dbSelectArea("SEF")
	EndIf
#ENDIF

dbSetOrder(1)
Set Filter To

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
EndIf
MS_FLUSH()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³SubTot410 ³ Autor ³ Paulo Boschetti       ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do SubTotal do Banco                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ SubTot410(ExpN1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1  - Valor Total                                       ³±±
±±³          ³ ExpN2  - Tamanho da linha                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function SubTot410(nTotVal,limite)
li++
@li, 0 Psay OemToAnsi(STR0013)  //"Sub-Total ----> "
@li,16 Psay nTotVal            Picture TM(nTotVaL,14,nDecs)
li++
@ li,00 Psay __PrtThinLine()
li++
Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TotGer410³ Autor ³ Paulo Boschetti       ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Total Do Relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ TotGer410(ExpN1,ExpN2)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Total de cheques,Valor Total                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function TotGer410(nTotChg,nTotValg)
li++
@li  ,  0 Psay OemToAnsi(STR0014)  //"Total Geral--> "
@li  , 16 Psay nTotValg              Picture tm(nTotValg,14,nDecs)
li++
@li  ,  0 Psay OemToAnsi(STR0015)+Alltrim(str(nTotChg))  //"Total Cheques-> "
li++
Return .T.

