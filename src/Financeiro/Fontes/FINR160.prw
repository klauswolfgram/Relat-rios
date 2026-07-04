/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR160.CH"
#Include "FiveWin.Ch"

Static lFWCodFil := .T.

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR160  ³ Autor ³ Wagner Xavier         ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Comparativo entre Valores Orcados x Reais                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR160(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sergio Rocha³16.08.93³17201 ³Criar novos parametros de impressao:      ³±±
±±³            ³        ³      ³1-Analitico/Sintetico                     ³±±
±±³            ³        ³      ³2-Regime de Caixa/Competencia             ³±±
±±³            ³        ³      ³3-Realizados/Todos os Titulos             ³±±
±±³            ³        ³      ³4-Quebra por Natureza (configuravel)      ³±±
±±³            ³        ³      ³-Opcao de Escolher as Naturezas           ³±±
±±³            ³        ³      ³-Imprimir Titulos a Receber/Pagar/Saldo   ³±±
±±³            ³        ³      ³-Criar relacao de inconsistencia p/cotacao³±±
±±³Julio Wittw.³02.08.99³META  ³Interpretar MV_CRNEG e MV_CPNEG           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR160()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL titulo

LOCAL cDesc1 :=OemToAnsi(STR0001)  //"Emiss„o do relat¢rio de comparativo entre Or‡ados x Reais."
LOCAL cDesc2 :=OemToAnsi(STR0002)  //"Poder  ser emitido considerando ou n„o as emiss”es de titu-"
LOCAL cDesc3 :=OemToAnsi(STR0003)  //"los a pagar/receber dentro do periodo base."
LOCAL lEnd   := .F.
LOCAL cString:="SE7"

PRIVATE m_pag   := 1
PRIVATE tamanho :="G"
PRIVATE Li      := 80
PRIVATE wnRel
Private nTotQb11:=Array(12),nTotQb21:=Array(12),nTotQb31:=Array(12),nTotQb41:=Array(12),nTotQb51:=Array(12)
Private nTotQb12:=Array(12),nTotQb22:=Array(12),nTotQb32:=Array(12),nTotQb42:=Array(12),nTotQb52:=Array(12)
Private nTotQb13:=Array(12),nTotQb23:=Array(12),nTotQb33:=Array(12),nTotQb43:=Array(12),nTotQb53:=Array(12)
Private cQuebra1:=Array(12),cQuebra2:=Array(12),cQuebra3:=Array(12),cQuebra4:=Array(12),cQuebra5:=Array(12)
PRIVATE aReturn := { OemToAnsi(STR0004), 1,OemToAnsi(STR0005), 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:="FINR160"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="FIN160"
Afill(nTotQb11,0)
Afill(nTotQb12,0)
Afill(nTotQb13,0)
Afill(nTotQb21,0)
Afill(nTotQb22,0)
Afill(nTotQb23,0)
Afill(nTotQb31,0)
Afill(nTotQb32,0)
Afill(nTotQb33,0)
Afill(nTotQb41,0)
Afill(nTotQb42,0)
Afill(nTotQb43,0)
Afill(nTotQb51,0)
Afill(nTotQb52,0)
Afill(nTotQb53,0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN160",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        ³
//³ Entradas                                                    ³
//³ mv_par01            // da Natureza                          ³
//³ mv_par02            // ate a Natureza                       ³
//³ Saidas                                                      ³
//³ mv_par03            // da Natureza                          ³
//³ mv_par04            // ate a Natureza                       ³
//³ Quebra (configuracao)                                       ³
//³ mv_par05            // Quebras das Naturezas                ³
//³ mv_par06            // Listagem Analitico/Sintetico         ³
//³ mv_par07            // Regime de Caixa/Competencia          ³
//³ mv_par08            // Somente Realizados/Todos os Titulos  ³
//³ mv_par09            // Moeda                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR160"            //Nome Default do relatorio em Disco

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi(STR0006)  //"MAPA COMPARATIVO - VALORES ORCADOS x REAIS"
Titulo += OemToAnsi(STR0007) +GetMV("MV_MOEDA"+Str(mv_par09,1))  //" em "

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

dbGoTop()

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| U_Fa160Imp(@lEnd,wnRel,cString)},titulo)
Return

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Fa160Imp ³ Autor ³ Wagner Xavier         ³ Data ³ 01.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Orcamento Orcado X Reais                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Fa160Imp ( lArg1,xArg1,cArg1 )                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ U_Finr160()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Fa160Imp( lArg1, cArg1, cArg2 )

Local Kx, cMascNivel, cCtlQueb, nMaxCtl, cDataIni, cDataFim, cFilSE5, i,;
      nC


LOCAL lEnd     := lArg1
LOCAL Titulo   := cArg2
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cbcont   := 0
LOCAL cbTxt    := Space( 10 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cabec1   := OemToAnsi(STR0008)+;  //"Cod Natureza    Descricao                           " 
                  OemToAnsi(STR0009)+;  //"Janeiro     Fevereiro         Marco         Abril   " 
                  OemToAnsi(STR0010)+;  //"       Maio         Junho         Julho        " 
                  OemToAnsi(STR0011)+;  //"Agosto      Setembro       Outubro      Novembro  " 
                  OemToAnsi(STR0012)    //"    Dezembro"
LOCAL cabec2   := ""
//

LOCAL cNatAnt  :=""
LOCAL lFirst   :=.T.
LOCAL cVariavel:=""
LOCAL cTeste   := ""
LOCAL nVal     := 0
LOCAL Limite   := 220
LOCAL bTot     :={|X,Y,Z| "nTotQb"+Str(X,1)+Str(Y,1)+"["+STR(Z,2)+"]" }
LOCAL nValor   := 0
LOCAL aCotacao :=Cotacao(Year(dDataBase))
LOCAL nVarAux  := 0
LOCAL bQb      := {|X| "cQuebra"+Str(X,1) }
LOCAL cMascNat := GetMV("MV_MASCNAT")
LOCAL aRealP   :=Array(12)    // realizado - Pagar
LOCAL aRealR   :=Array(12)    // realizado - Receber
LOCAL aArealP  :=Array(12)    // a realizar- Pagar
LOCAL aArealR  :=Array(12)    // a realizar- Receber
LOCAL aOrc     :=Array(12)
LOCAL aRealTR  :=Array(12)    // Total a Receber - Realizado
LOCAL aRealTP  :=Array(12)    // Total a Pagar   - Realizado
LOCAL aArealTR :=Array(12)    // Total a Receber - a Realizar
LOCAL aArealTP :=Array(12)    // Total a Pagar   - a Realizar
LOCAL aOrcTR   :=Array(12)    // Total orcado - Receber
LOCAL aOrcTP   :=Array(12)    // Total orcado - Pagar
LOCAL aErrMoeda:={}           // Cotacoes nao encontradas
LOCAL aMeses   :={OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),OemToAnsi(STR0016),;  //"Jan"###"Fev"###"Mar"###"Abr"
						OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),OemToAnsi(STR0020),;  //"Mai"###"Jun"###"Jul"###"Ago"
						OemToAnsi(STR0021),OemToAnsi(STR0022),OemToAnsi(STR0023),OemToAnsi(STR0024)}   //"Set"###"Out"###"Nov"###"Dez"

PRIVATE cMoeda :=Str(mv_par09,1)



AFILL(aOrcTR,0)
AFILL(aOrcTP,0)
AFILL(aRealTR,0)
AFILL(aRealTP,0)
AFILL(aARealTR,0)
AFILL(aARealTP,0)


dbSelectArea("SED")
dbSeek(cFilial+mv_par01,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo das entradas                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

For Kx:=1 To Len(alltrim(cMascNat))
	nVarAux+=Val(Subs(cMascNat,kx,1))
	&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
Next

cMaxNivel:=Str(Len(alltrim(cMascNat)),1)
cCtlQueb :=GeraNivel(mv_par05)
nMaxCtl  :=nVarAux
mv_par05 :=AllTrim(mv_par05)

SetRegua( RecCount() )

While !SED->(Eof()) .and. SED->ED_CODIGO <= mv_par02 .and. cFilial==SED->ED_FILIAL


    cNatAnt:=SED->ED_CODIGO

    #IFDEF TOP
	// nao foram colocadas todas as condicoes pois estourava o tamanho do filtro
	// colocar depois as condicoes do SE5
		cDataIni := Dtos(Ctod("01/01"+strzero(year(dDataBase),4),"ddmmyy"))
		cDataFim := Dtos(Ctod("31/12"+strzero(year(dDataBase),4),"ddmmyy"))
		cFilSE5 := 'E5_SITUACA <> "C" .and. '
		cFilSE5 += 'E5_RECPAG == "R" .and. ' 
		cFilSE5 += IIF(mv_par07 == 1,'DTOS(E5_DTDIGIT)','DTOS(E5_DATA)')+' >= "'+cDataIni+'" .and. ' 
		cFilSE5 += IIF(mv_par07 == 1,'DTOS(E5_DTDIGIT)','DTOS(E5_DATA)')+' <= "'+cDataFim+'" .and. ' 
		cFilSE5 += 'E5_TIPODOC <> "DC" .and. E5_TIPODOC <> "JR" .and. E5_TIPODOC <> "MT" .and. E5_TIPODOC <> "CM"'
		dbSelectARea("SE5")
		Set Filter to &cFilSE5
	#ENDIF


	dbSelectArea("SE7")
	dbSeek(cFilial+SED->ED_CODIGO)
	dbSelectArea("SE5")
	dbSetOrder(4)
	dbSeek(cFilial+SED->ED_CODIGO)
	dbSelectArea("SE1")
	dbSetOrder(3)
	dbSeek(cFilial+SED->ED_CODIGO)
		
	If SE7->(Found()) .or. SE5->(Found()) .or. SE1->(Found())

       IF lEnd
          @PROW()+1,001 PSAY OemToAnsi(STR0025)  //"CANCELADO PELO OPERADOR"
          Exit
       End

        IF li > 58
           cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
		EndIF

		If cMaxNivel == mv_par05
            @li, 0 pSay MascNat(SED->ED_CODIGO)
            @li,16 pSay Substr(SED->ED_DESCRIC,1,20)
            @li,37 pSay "  ORCADO"
		Endif
		nC :=31
		DbSelectArea("SE7")
		AFILL(aOrc,0)
		For i:=1 To 12
			cMes:=aMeses[i]+"1"
			nC+=14
			If cMaxNivel == mv_par05
				nValor := ValorMed (SE7->E7_VAL&cMes,SE7->E7_MOEDA,mv_par09,aCotacao[i])
                @li,nC pSay nValor Picture tm(nValor,14)
			Endif
			aOrc[I] := nValor
		Next i
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lˆ Arquivo de Movimentacoes                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AFILL(aRealR,0)      //Zera Array com valores da natureza lida Realizado - Receber
		AFILL(aArealR,0)     //Zera Array com valores da natureza lida a Realizar - Receber

		DbSelectArea("SE5")

		While !Eof() .And. E5_FILIAL==cFilial .And. E5_NATUREZ==SED->ED_CODIGO

            IF E5_SITUACA = "C"
				dbSkip()
				Loop
			EndIF

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lˆ arquivo de movimentacoes e verifica tipo do lan‡amento ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF E5_TIPODOC $ "DCüJRüMTüCM/D2/J2/M2/C2"
				dbSkip()
				Loop
			EndIF

			IF mv_par07 == 1  .And. YEAR(E5_DTDIGIT)  != YEAR(dDataBase) // Regime de Caixa
				dbSkip()
				Loop
			EndIF

			IF mv_par07 != 1  .And. YEAR(E5_DATA)  != YEAR(dDataBase) // Regime de Competencia
				dbSkip()
				Loop
			Endif

			If E5_TIPO $ MVRECANT+"/"+MVPAGANT
				dbSkip( )
				Loop
			End

			dbSelectArea("SE1")
			dbSetOrder(1) 
			Seek cFilial+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO
			If EOF()
				dConsid := SE5->E5_DATA
			Else
				dConsid := SE1->E1_EMISSAO
			Endif

			dbSelectArea("SM2")
			dbSeek(IIF(mv_par07==1,SE5->E5_DTDIGIT, dConsid ))
			IF !found()
				IF ASCAN(aErrMoeda,IIF(mv_par07== 1, DTOC(SE5->E5_DTDIGIT), DTOC(dConsid) ))=0
					AADD(aErrMoeda,IIF(mv_par07== 1, DTOC(SE5->E5_DTDIGIT), DTOC(dConsid)))
				EndIF
			EndIF

			dbSelectArea("SE5")
			IF E5_RECPAG=="R"
				IF mv_par07 == 1  // Regime de Caixa
					aRealR[Month(E5_DTDIGIT)]+=IIF(mv_par09==1,E5_VALOR,E5_VALOR/SM2->M2_MOEDA&cMoeda)
				Else              // Regime de Competencia
					aRealR[Month(dConsid)]+=IIF(mv_par09==1,E5_VALOR,E5_VALOR/SM2->M2_MOEDA&cMoeda)
				Endif
			EndIF

			dbSkip()

        EndDO

		IF mv_par08 == 2   // Impressao de todos os titulos (baixados/em aberto)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lˆ Carteria de titulos - a Receber                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SE1")

			#IFDEF TOP
				cFilSE1 := 'E1_SALDO > 0 .and. '
				cFilSE1 += IIF(mv_par07 == 1,'DTOS(E1_VENCTO)','DTOS(E1_EMISSAO)')+' >= "'+cDataINI+'" .and. ' 
				cFilSE1 += IIF(mv_par07 == 1,'DTOS(E1_VENCTO)','DTOS(E1_EMISSAO)')+' <= "'+cDataFim+'"' 
				dbSelectArea("SE1")
				Set Filter to &cFilSE1
			#ENDIF

			dbSetOrder(3)
			dbSeek(cFilial+SED->ED_CODIGO)
			While !EOF() .and. E1_FILIAL==cFilial .and. E1_NATUREZ==SED->ED_CODIGO
               IF E1_SALDO == 0
					dbSkip()
					Loop
               EndIF
			   IF mv_par07 == 1  .And. YEAR(E1_VENCTO)  != YEAR(dDataBase) // Regime de Caixa
					dbSkip()
					Loop
				EndIF
				IF mv_par07 != 1  .And. YEAR(E1_EMISSAO)  != YEAR(dDataBase) // Regime de Competencia
					dbSkip()
      			Loop
				Endif

				IF !E1_TIPO $ MVPROVIS
					IF TesMoeda(E1_SALDO,mv_par09,IIF(mv_par07==1,E1_VENCTO,E1_EMISSAO),E1_MOEDA) = 0
						If !ExistMoeda(IIF(mv_par07==1,E1_VENCTO,E1_EMISSAO),cMoeda)
							IF ASCAN(aErrMoeda,IIF(mv_par07==1,DTOC(E1_VENCTO),DTOC(E1_EMISSAO)))=0
								AADD(aErrMoeda,IIF(mv_par07==1,DTOC(E1_VENCTO),DTOC(E1_EMISSAO)))
							EndIF
						End
					EndIF
					IF mv_par07 == 1  // Regime de Caixa
						If E1_TIPO $ MVABATIM+"/"+MVRECANT+"/"+MV_CRNEG
							aArealR[Month(E1_VENCTO)]-=TesMoeda(E1_SALDO,mv_par09,E1_VENCTO,E1_MOEDA)
						Else
							aArealR[Month(E1_VENCTO)]+=TesMoeda(E1_SALDO,mv_par09,E1_VENCTO,E1_MOEDA)
						End
					Elseif E1_TIPO $ MVABATIM+"/"+MVRECANT+"/"+MV_CRNEG
						aArealR[Month(E1_VENCTO)]-=TesMoeda(E1_SALDO,mv_par09,E1_VENCTO,E1_MOEDA)
					Else				
						aArealR[Month(E1_EMISSAO)]+=TesMoeda(E1_SALDO,mv_par09,E1_EMISSAO,E1_MOEDA)
					End
				End
				dbSkip()
			EndDO
		EndIF

		dbSelectArea("SE1")
		Set Filter to

		IF mv_par06 = 1 .and. mv_par08 = 2
			If cMaxNivel == mv_par05
				li++
                @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
				ImpLin(aRealR,31)
				li++
                @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
				ImpLin(aArealR,31)
			EndIF
		Endif

		If cMaxNivel == mv_par05
			li++
			IF mv_par08=1
                @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
			Else
                @li,37 pSay OemToAnsi(STR0028)  //"    REAL"
			EndIF
			nC :=31

			For i:=1 To 12
				nC+=14
                @li,nC pSay Abs(aRealR[i]+aArealR[i]) Picture tm(Abs(aRealR[i]+aArealR[i]),14)
			Next i

			Li++
            @li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"

			nC:=38

			For i:=1 To 12
				nC+=14
				nReal:= Abs(aRealR[i]+aArealR[i])
				nVal := NOROUND((abs(nReal)-Abs(aOrc[i]))/abs(aOrc[i])*100)
				cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
				cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
                @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
			Next i
			li+=2
		Endif

		For i:=1 To 12
			aArealTR[I]+=aArealR[I]
			aRealTR[I]+=aRealR[I]
			aOrcTR[I]+=aOrc[I]
		Next i

		For Kx:=1 To Val(cMaxNivel)
			For i:=1 To 12
				&(Eval(bTot,Kx,1,i))+=aRealR[I]
				&(Eval(bTot,Kx,2,i))+=aArealR[I]
				&(Eval(bTot,Kx,3,i))+=aOrc[I]
			Next
		Next
		cNatAnt:=SED->ED_CODIGO
		dbSelectArea("SED")
		dbSkip()
		nRecNo:=RecNo()
		nVaraux:=nMaxCtl

		For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
			nVarAux-=Val(Subs(cMascNat,kx+1,1))
			If &(Eval(bQb,Kx)) != Subs(SED->ED_CODIGO,1,nVarAux)
				If Str(kx,1) $ cCtlQueb
					dbSelectArea("SED")
					dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
					IF li > 55
						Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
					EndIF
					Li:=ImpSubTot(Kx,bQb,bTot,Li)
					lFirst:=.F.
					For i=1 To 12
						&(Eval(bTot,Kx,1,i)):= 0
						&(Eval(bTot,Kx,2,i)):= 0
						&(Eval(bTot,Kx,3,i)):= 0
					Next
					dbSelectArea("SED")
					&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
					Li++
				EndIF
			EndIF
		Next
		DbGoTo(nRecNo)
		&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
	Else
		cNatAnt:=SED->ED_CODIGO
		dbSelectArea("SED")
		dbSkip()
		nRecNo:=RecNo()
		nVaraux:=nMaxCtl

		For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
			nVarAux-=Val(Subs(cMascNat,kx+1,1))
			If &(Eval(bQb,Kx)) != Subs(SED->ED_CODIGO,1,nVarAux)
				If Str(kx,1) $ cCtlQueb
					dbSelectArea("SED")
					dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
					IF li > 55
						Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
					EndIF
					Li:=ImpSubTot(Kx,bQb,bTot,Li)
					lFirst:=.F.
					For i=1 To 12
						&(Eval(bTot,Kx,1,i)):= 0
						&(Eval(bTot,Kx,2,i)):= 0
						&(Eval(bTot,Kx,3,i)):= 0
					Next
					dbSelectArea("SED")
					&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
					Li++
				EndIF
			EndIF
		Next
		DbGoTo(nRecNo)
		&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
	Endif
    IncRegua()
EndDO

If lFirst
	nVaraux:=nMaxCtl
	For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
		nVarAux-=Val(Subs(cMascNat,kx+1,1))
		If Str(kx,1) $ cCtlQueb
			dbSelectArea("SED")
			dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
			IF li > 55
				Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIF
			Li:=ImpSubTot(Kx,bQb,bTot,Li)
			lFirst:=.F.
			For i=1 To 12
				&(Eval(bTot,Kx,1,i)):= 0
				&(Eval(bTot,Kx,2,i)):= 0
				&(Eval(bTot,Kx,3,i)):= 0
			Next
			&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
			Li++
		Endif
	Next
Endif
lFirst:=.t.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo das Saidas                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Afill(nTotQb11,0)
Afill(nTotQb12,0)
Afill(nTotQb13,0)
Afill(nTotQb21,0)
Afill(nTotQb22,0)
Afill(nTotQb23,0)
Afill(nTotQb31,0)
Afill(nTotQb32,0)
Afill(nTotQb33,0)
Afill(nTotQb41,0)
Afill(nTotQb42,0)
Afill(nTotQb43,0)
Afill(nTotQb51,0)
Afill(nTotQb52,0)
Afill(nTotQb53,0)
lFirst:=.T.
dbSelectArea("SED")
DbSeek(cFilial+mv_par03,.T.)
cMascNat:= GetMV("MV_MASCNAT")
nVaraux:=0
For Kx:=1 To Len(alltrim(cMascNat))
	nVarAux+=Val(Subs(cMascNat,kx,1))
	&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
Next
cMaxNivel:=Str(Len(alltrim(cMascNat)),1)
cCtlQueb :=GeraNivel(mv_par05)
nMaxCtl  :=nVarAux
nAnt:=4
nAtu:=4
nCnt:=0

While !SED->(Eof()) .and. SED->ED_CODIGO <= mv_par04 .and. cFilial==SED->ED_FILIAL
   cNatAnt:=SED->ED_CODIGO

    IF li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	EndIF

	#IFDEF TOP
	// nao foram colocadas todas as condicoes pois estourava o tamanho do filtro
	// colocar depois as condicoes do SE5

      cDataIni := Dtos(Ctod("01/01"+strzero(year(dDataBase),4),"ddmmyy"))
		cDataFim := Dtos(Ctod("31/12"+strzero(year(dDataBase),4),"ddmmyy"))
		cFilSE5 := 'E5_SITUACA <> "C" .and. '
		cFilSE5 += 'E5_RECPAG == "P" .and. ' 
		cFilSE5 += IIF(mv_par07 == 1,'E5_DTDIGIT','E5_DATA')+' >= "'+cDataIni+'" .and. ' 
		cFilSE5 += IIF(mv_par07 == 1,'E5_DTDIGIT','E5_DATA')+' <= "'+cDataFim+'" .and. ' 
		cFilSE5 += 'E5_TIPODOC <> "DC" .and. E5_TIPODOC <> "JR" .and. E5_TIPODOC <> "MT" .and. E5_TIPODOC <> "CM"'
		dbSelectARea("SE5")
		Set Filter to &cFilSE5
	#ENDIF

	dbSelectArea("SE7")
	dbSeek(cFilial+SED->ED_CODIGO)
	dbSelectArea("SE5")
	dbSetOrder(4)
	dbSeek(cFilial+SED->ED_CODIGO)
	dbSelectArea("SE2")
	dbSetOrder(2)
	dbSeek(cFilial+SED->ED_CODIGO)
		
	If SE7->(Found()) .or. SE5->(Found()) .or. SE2->(Found())

		If cMaxNivel == mv_par05
            @li, 0 pSay MascNat(SED->ED_CODIGO)
            @li,16 pSay Substr(SED->ED_DESCRIC,1,20)
            @li,37 pSay "  ORCADO"
		Endif
		nC :=31
		DbSelectArea("SE7")
		AFILL(aOrc,0)
		For i:=1 To 12
			cMes:=aMeses[i]+"1"
			nC+=14
			If cMaxNivel == mv_par05
				nValor := ValorMed (SE7->E7_VAL&cMes,SE7->E7_MOEDA,mv_par09,aCotacao[i])
                @li,nC pSay nValor Picture tm(nValor,14)
			Endif
   	  	aOrc[I] := nValor
		Next i

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Lˆ Arquivo de Movimentacoes                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SE5")
		
		AFILL(aRealP,0)      //Zera Array com valores da natureza lida Realizado - Pagar
		AFILL(aArealP,0)     //Zera Array com valores da natureza lida a Realizar - Pagar

		While !Eof() .And. E5_FILIAL==cFilial .And. E5_NATUREZ==SED->ED_CODIGO

			IF E5_SITUACA = "C"
				dbSkip()
				Loop
			EndIF

			IF mv_par07 == 1  .And. YEAR(E5_DTDIGIT)  != YEAR(dDataBase) // Regime de Caixa
				dbSkip()
	   		Loop
			EndIF

			IF mv_par07 != 1  .And. YEAR(E5_DATA)  != YEAR(dDataBase) // Regime de Competencia
      		dbSkip()
				Loop
			Endif

			If E5_TIPO $ MVPAGANT+"/"+MVRECANT
				dbSkip( )
				Loop
			End

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lˆ arquivo de movimentacoes e verifica tipo do lan‡amento ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF E5_TIPODOC $ "DCüJRüMTüCM/D2/J2/M2/C2"
				dbSkip()
				Loop
			EndIF
			dbSelectArea("SE2")
			dbSetOrder(1) 
			Seek cFilial+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_CLIFOR
			If EOF() 
				dConsid := SE5->E5_DATA
			Else
				dConsid := SE2->E2_EMISSAO
			Endif

			dbSelectArea("SM2")
			dbSeek(IIF(mv_par07== 1, SE5->E5_DTDIGIT, dConsid ))
			IF !found()
				IF ASCAN(aErrMoeda,IIF(mv_par07== 1, DTOC(SE5->E5_DTDIGIT),DTOC(dConsid)))=0
					AADD(aErrMoeda,IIF(mv_par07== 1, DTOC(SE5->E5_DTDIGIT),DTOC(dConsid)))
				EndIF
			EndIF

			dbSelectArea("SE5")
			IF E5_RECPAG=="P"
				IF mv_par07 == 1  // Regime de Caixa
					aRealP[Month(E5_DTDIGIT)]+=IIF(mv_par09==1,E5_VALOR,E5_VALOR/SM2->M2_MOEDA&cMoeda)
				Else              // Regime de Competencia
					aRealP[Month(dConsid)]+=IIF(mv_par09==1,E5_VALOR,E5_VALOR/SM2->M2_MOEDA&cMoeda)
				EndIF
			EndIF
			dbSkip()
            IncRegua()
		EndDO

		IF mv_par08 == 2   // Impressao de todos os titulos (baixados/em aberto)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Lˆ Carteira de titulos - a Pagar     	                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SE2")

			#IFDEF TOP
				cFilSE2 := 'E2_SALDO > 0 .and. '
				cFilSE2 += IIF(mv_par07 == 1,'DTOS(E2_VENCTO)','DTOS(E2_EMISSAO)')+' >= "'+cDataIni+'" .and. ' 
				cFilSE2 += IIF(mv_par07 == 1,'DTOS(E2_VENCTO)','DTOS(E2_EMISSAO)')+' <= "'+cDataFim+'"' 
				dbSelectArea("SE2")
				Set Filter to &cFilSE2
			#ENDIF

			dbSetOrder(2)
			dbSeek(cFilial+SED->ED_CODIGO)
			While !EOF() .and. E2_FILIAL==cFilial .and. E2_NATUREZ==SED->ED_CODIGO
	
				IF E2_SALDO == 0
					dbSkip()
					Loop
				EndIF

				IF mv_par07 == 1  .And. YEAR(E2_VENCTO)  != YEAR(dDataBase) // Regime de Caixa
					dbSkip()
					Loop
				EndIF

				IF mv_par07 != 1  .And. YEAR(E2_EMISSAO)  != YEAR(dDataBase) // Regime de Competencia
					dbSkip()
					Loop
				Endif

				IF TesMoeda(E2_SALDO,mv_par09,IIF(mv_par07 == 1,E2_VENCTO,E2_EMISSAO),E2_MOEDA) = 0
					If !ExistMoeda(IIF(mv_par07==1,E2_VENCTO,E2_EMISSAO),cMoeda)
						IF ASCAN(aErrMoeda,IIF(mv_par07 == 1,DTOC(E2_VENCTO),DTOC(E2_EMISSAO)))=0
							AADD(aErrMoeda,IIF(mv_par07 == 1,DTOC(E2_VENCTO),DTOC(E2_EMISSAO)))
						End
					End
				EndIF
    
				If !E2_TIPO $ MVPROVIS
					IF mv_par07 == 1  // Regime de Caixa
						If E2_TIPO $ MVABATIM+"/"+MVPAGANT+"/"+MV_CPNEG
							aArealP[Month(E2_VENCTO)] -=TesMoeda(E2_SALDO,mv_par09,E2_VENCTO,E2_MOEDA)
						Else
							aArealP[Month(E2_VENCTO)] +=TesMoeda(E2_SALDO,mv_par09,E2_VENCTO,E2_MOEDA)
						End
					Elseif E2_TIPO $ MVABATIM+"/"+MVPAGANT+"/"+MV_CPNEG
						aArealP[Month(E2_EMISSAO)]-=TesMoeda(E2_SALDO,mv_par09,E2_EMISSAO,E2_MOEDA)
					Else
						aArealP[Month(E2_EMISSAO)]+=TesMoeda(E2_SALDO,mv_par09,E2_EMISSAO,E2_MOEDA)
					Endif
				End
				dbSkip( )
				Loop
			End
		Endif

		dbSelectArea("SE2")
		Set Filter to
		dbSelectArea("SE5")
		Set Filter to

		li++
		IF mv_par06 = 1
			If cMaxNivel == mv_par05
                @li,36 pSay   OemToAnsi(STR0026)  //"REALIZADO"
				ImpLin(aRealP,31)
				li++
                @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
				ImpLin(aArealP,31)
				li++
			EndIf
		EndIF

		IF cMaxNivel == mv_par05
			IF mv_par08=1
                @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
			Else
                @li,37 pSay OemToAnsi(STR0028)  //"    REAL"
			EndIF
			nC :=31

			For i:=1 To 12
				nC+=14
                @li,nC pSay Abs(aRealP[i]+aArealP[i]) Picture tm(Abs(aRealP[i]+aArealP[i]),14)
			Next i
			Li++
            @li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"
			nC:=38

			For i:=1 To 12
				nC+=14
				nReal:= Abs(aRealP[i]+aArealP[i])
				nVal := NOROUND((abs(nReal)-Abs(aOrc[i]))/abs(aOrc[i])*100)
				cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
				cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
                @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
			Next i
			li+=2
		Endif

		For i:=1 To 12
			aArealTP[I]+=aArealP[I]
			aRealTP[I]+=aRealP[I]
			aOrcTP[I]+=aOrc[I]
		Next i

		For Kx:=1 To Val(cMaxNivel)
			For i:=1 To 12
				&(Eval(bTot,Kx,1,i))+=aRealP[I]
				&(Eval(bTot,Kx,2,i))+=aArealP[I]
				&(Eval(bTot,Kx,3,i))+=aOrc[I]
			Next
		Next
		cNatAnt:=SED->ED_CODIGO
		dbSelectArea("SED")
		dbSkip()
		nRecNo:=RecNo()
		nVaraux:=nMaxCtl
		For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
			nVarAux-=Val(Subs(cMascNat,kx+1,1))
			If &(Eval(bQb,Kx)) != Subs(SED->ED_CODIGO,1,nVarAux)
				If Str(kx,1) $ cCtlQueb
					dbSelectArea("SED")
					dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
					IF li > 55
						Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
					EndIF
					Li:=ImpSubTot(Kx,bQb,bTot,Li)
					lFirst:=.F.
					For i=1 To 12
						&(Eval(bTot,Kx,1,i)):= 0
						&(Eval(bTot,Kx,2,i)):= 0
						&(Eval(bTot,Kx,3,i)):= 0
					Next
					dbSelectArea("SED")
					&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
					Li++
				EndIF
			EndIF
		Next
		DbGoTo(nRecNo)
		&(Eval(bQb,Kx+1)) := Subs(SED->ED_CODIGO,1,nVarAux)
	Else
		cNatAnt:=SED->ED_CODIGO
		dbSelectArea("SED")
		dbSkip()
		nRecNo:=RecNo()
		nVaraux:=nMaxCtl
		For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
			nVarAux-=Val(Subs(cMascNat,kx+1,1))
			If &(Eval(bQb,Kx)) != Subs(SED->ED_CODIGO,1,nVarAux)
				If Str(kx,1) $ cCtlQueb
					dbSelectArea("SED")
					dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
					IF li > 55
						Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
					EndIF
					Li:=ImpSubTot(Kx,bQb,bTot,Li)
					lFirst:=.F.
					For i=1 To 12
						&(Eval(bTot,Kx,1,i)):= 0
						&(Eval(bTot,Kx,2,i)):= 0
						&(Eval(bTot,Kx,3,i)):= 0
					Next
					dbSelectArea("SED")
					&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
					Li++
				EndIF
			EndIF
		Next
		DbGoTo(nRecNo)
		&(Eval(bQb,Kx+1)) := Subs(SED->ED_CODIGO,1,nVarAux)
	Endif
EndDO

If lFirst
	nVaraux:=nMaxCtl
	For Kx:=(Len(alltrim(cMascNat))-1) To 1 Step -1
		nVarAux-=Val(Subs(cMascNat,kx+1,1))
		If Str(kx,1) $ cCtlQueb
			dbSelectArea("SED")
			dbSeek(cFilial+Subs(cNatAnt,1,nVarAux))
			IF li > 55
				Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			EndIF
			Li:=ImpSubTot(Kx,bQb,bTot,Li)
			lFirst:=.F.
			For i=1 To 12
				&(Eval(bTot,Kx,1,i)):= 0
				&(Eval(bTot,Kx,2,i)):= 0
				&(Eval(bTot,Kx,3,i)):= 0
			Next
			&(Eval(bQb,Kx)) := Subs(SED->ED_CODIGO,1,nVarAux)
			Li++
		Endif
	Next
	Li++
Endif
lFirst:=.t.
nC :=31
@Li,0 pSay Replicate("-",Limite)
Li++
@Li,0 pSay OemToAnsi(STR0030)  //"Resumo"
li++
IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizador das Entradas                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,0 pSay Replicate("-",Limite)
Li++

@li,15 pSay OemToAnsi(STR0031)  //"Entradas-"
@li,37 pSay OemToAnsi(STR0032)  //"  ORCADO"

For i:=1 To 12
	nC+=14
    @li,nC pSay abs(aOrcTR[i])  Picture tm(Abs(aOrcTR[i]),14)
Next i

nC :=31
Li++

IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
IF mv_par06=1 .and. mv_par08 = 2
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
	For i:=1 To 12
		nC+=14
        @li,nC pSay abs(aRealTR[i])  Picture tm(Abs(aRealTR[i]),14)
	Next i
	Li++
    @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
	ImpLin(aARealTR,31)
	Li++
Endif
IF mv_par08=1
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
Else
    @li,37 pSay OemToAnsi(STR0028)  //"    REAL"
EndIF
nC :=31
For i:=1 To 12
	nC+=14
    @li,nC pSay abs(aRealTR[i]+aARealTR[i])  Picture tm(Abs(aRealTR[i]+aArealTR[i]),14)
Next i

nC :=38
Li++
IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
@li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"

For i:=1 To 12
	nC+=14
	nVal:=NOROUND((abs(aRealTR[i]+aArealTR[i])-Abs(aOrcTR[i]))/abs(aOrcTR[i])*100)
	cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
	cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
    @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
Next i
Li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizador das Saidas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,0 pSay Replicate("-",Limite)
Li++
@li,15 pSay OemToAnsi(STR0033)  //"Saidas -"
@li,37 pSay OemToAnsi(STR0032)  //"  ORCADO"
ImpLin(aOrcTP,31)
nC :=31
Li++

IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
IF mv_par06=1 .and. mv_par08 = 2
    @li,36 pSay OemToAnsi(STR0026) //"REALIZADO"
	ImpLin(aRealTP,31)
	Li++
    @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
	ImpLin(aARealTP,31)
	nC :=31
	Li++
Endif
IF mv_par08=1
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
Else
    @li,37 pSay OemToAnsi(STR0028)  //"    REAL"
EndIF

For i:=1 To 12
	nC+=14
    @li,nC pSay abs(aRealTP[i]+aARealTP[i])  Picture tm(Abs(aRealTP[i]+aArealTP[i]),14)
Next i

nC :=38
Li++
IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
@li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"

For i:=1 To 12
	nC+=14
	nVal:=NOROUND((abs(aRealTP[i]+aArealTP[i])-Abs(aOrcTP[i]))/abs(aOrcTP[i])*100)
	cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
	cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
    @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
Next i
Li++
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizador dos Saldos                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@Li,0 pSay Replicate("-",Limite)
Li++
nC :=31
@li,15 pSay OemToAnsi(STR0034)  //"Saldo  -"
@li,37 pSay OemToAnsi(STR0032)  //"  ORCADO"

For i:=1 To 12
	nC+=14
    @li,nC pSay aOrcTR[i]-aOrcTP[i]  Picture tm(aOrcTR[i]-aOrcTP[i],14)
Next i

nC :=31
Li++

IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
IF mv_par06=1 .and. mv_par08 = 2
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
	For i:=1 To 12
		nC+=14
        @li,nC pSay aRealTR[i]-aRealTP[i]  Picture tm(aRealTR[i]-aRealTP[i],14)
	Next i
	nC :=31
	Li++
    @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
	For i:=1 To 12
		nC+=14
        @li,nC pSay aArealTR[i]-aARealTP[i]  Picture tm(aArealTR[i]-aARealTP[i],14)
	Next i
	nC :=31
	Li++
Endif
IF mv_par08=1
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
Else
    @li,37 pSay OemToAnsi(STR0028)  //"    REAL"
EndIF

For i:=1 To 12
	nC+=14
    @li,nC pSay aRealTR[i]+aArealTR[i]-aRealTP[i]-aARealTP[i]  Picture tm(aRealTR[i]+aArealTR[i]-aRealTP[i]-aArealTP[i],14)
Next i

nC :=38
Li++
IF li > 58
	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
EndIF
@li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"

For i:=1 To 12
	nC+=14
	If aOrcTR[i]-aOrcTP[i] = 0
		nVal:=0
	Else
		nVal1:=((aRealTR[i]+aArealTR[i]-aRealTP[i]-aArealTP[i])-(aOrcTR[i]-aOrcTP[i]))/(aOrcTR[i]-aOrcTP[i])
		nVal:=NOROUND(nVal1*100)
	EndIF
	cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
	cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
    @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
Next i
Li++
@Li,0 pSay Replicate("-",Limite)
IF Len(aErrMoeda) # 0
	Li+=2
	nC:=10
    @ Li,nC pSay OemToAnsi(STR0035)  //"Relacao de Moedas nao Cadastradas"
	Li++
	For i:=1 To Len(aErrMoeda)
		IF li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			nc:=10
		EndIF
        @ Li,nC pSay CTOD(aErrMoeda[i],"ddmmyy")  // Picture "99/99/99"
		nC+=12
		IF nC>132
			nC:=10
			Li++
		EndIF
	Next
EndIF

IF li != 80
	roda(cbcont,cbtxt,"G")
EndIF

dbSelectArea("SE5")
dbSetOrder(1)
Set Filter To

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	ourspool(wnrel)
Endif
FT_PFLUSH()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpLin   ³ Autor ³ Sergio Rocha          ³ Data ³ 18.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da linha detalhe                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpLin(Array,ExpN1,ExpC1)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Array de valores a ser impresso,Numero da Coluna inicial e ³±±
±±³          ³ Picture.                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function ImpLin(aVar,nCol)
Local i := 0
For i:=1 To 12
	nCol+=14
    @li,nCol pSay aVar[i] Picture tm(Abs(aVar[i]),14)
Next
Return Nil
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpSubTot³ Autor ³ Sergio Rocha          ³ Data ³ 18.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do Sub-Total                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ImpSubTot(ExpN1,ExpC1,ExpC2)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Ponteiro de quebra                                 ³±±
±±³          ³ ExpC1 = Bloco de Codigo de Quebra                          ³±±
±±³          ³ ExpC2 = Bloco de Codigo de Total                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpSubTot(Kx,bQb,bTot,Li)

Local cMacro	:= Eval(bQb,Kx),cTot,cTot2
Local i		:= 0

@Li,00 pSay OemToAnsi(STR0036)+ &cMacro +" - "+Substr(SED->ED_DESCRIC,1,20)  //"Total - "
nC := 31
@li,37 pSay OemToAnsi(STR0032)  //"  ORCADO"
For i := 1 To 12
	nC+=14
    @Li,nC pSay &(Eval(bTot,Kx,3,i)) Picture tm( &(Eval(bTot,Kx,3,i)),14)
Next
Li++
IF mv_par06 == 1 .and. mv_par08 == 2
    @li,36 pSay OemToAnsi(STR0026)  //"REALIZADO"
	nC := 31
	For i := 1 To 12
		nC += 14
        @Li,nC pSay &(Eval(bTot,Kx,1,i)) Picture  tm( &(Eval(bTot,Kx,1,i)),14)
	Next
	Li++
    @li,35 pSay OemToAnsi(STR0027)  //"A REALIZAR"
	nC := 31
	For i := 1 To 12
		nC += 14
        @Li,nC pSay &(Eval(bTot,Kx,2,i)) Picture tm( &(Eval(bTot,Kx,2,i)),14)
	Next
	Li++
EndIF
@li,37 pSay OemToAnsi(STR0028)  //"    REAL"
nC := 31
For i := 1 To 12
	nC += 14
	cTot := Eval(bTot,Kx,1,i)
	cTot2 := Eval(bTot,Kx,2,i)
    @Li,nC pSay &cTot + &cTot2 Picture tm(&(Eval(bTot,Kx,1,i))+ &(Eval(bTot,Kx,2,i)),14)
Next
Li++
@li,35 pSay OemToAnsi(STR0029)  //"% VARIACAO"
nC := 38
For i := 1 To 12
	nC += 14
	nReal := &(Eval(bTot,Kx,1,i)) + &(Eval(bTot,Kx,2,i))
	nVal := NOROUND((abs(nReal)-Abs(&(Eval(bTot,Kx,3,i))))/abs(&(Eval(bTot,Kx,3,i)))*100)
	cTeste := iif(abs(nVal)#0,Transform(abs(nVal),iif(nVal<0,"@E -999.99","@E +999.99")),'0,00')
	cVariavel := Subs(cTeste,1,1)+alltrim(Subs(cTeste,2,6))
    @li,nC pSay iif(len(cVariavel)=7,cVariavel,Space(7-Len(cVariavel))+cVariavel)
Next i
Li += 2
Return(Li)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Geranivel³ Autor ³ Paulo Boschetti       ³ Data ³ 13.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera string contendo os niveis de quebra                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Geranivel()                                                ³±± 
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function GeraNivel(cControl)

Local Wx:=0,cNiveis:=""

If Val(cControl) > 1
	For Wx:=Val(cControl) to 1 Step -1
		cNiveis += Str(Wx,1)
	Next
Else
	cNiveis:="1"
Endif

Return cNiveis

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TesMoeda ³ Autor ³ Sergio Rocha          ³ Data ³ 20.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica a existencia da cotacao conforme o tipo da moeda  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TesMoeda(ExpN1,ExpC1,ExpD1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Valor a ser convertido                             ³±±
±±³          ³ ExpC1 = Tipo da Moeda                                      ³±±
±±³          ³ ExpD1 = Data a ser pesquisada                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TesMoeda(nValor,nMoeda,dData,nMoeOr)
If nMoeOr == Nil .or. nMoeor = 0
	nMoeOr := 1
End 
nMoeOr := Iif(nMoeOr < 2,1,nMoeOr)
xValor := xMoeda(nValor,nMoeOr,nMoeda,dData)
Return xValor

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Cotacao  ³ Autor ³ Valter G. Nogueira Jr.³ Data ³ 03/02/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Devolve a cotacao media das moedas de um determinado ano   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ExpA1:=Cotacao(ExpN1)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 = Array bidimensional com as cotacoes medias         ³±±
±±³          ³ ExpN2 = Ano                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function Cotacao(nAno)
LOCAL aCotacao:={},aCotMes:={},dDataIni,dDataFim,i

if nAno = NIL
  nAno := Year(dDataBase)
endif

For i = 1 to 12
	dDataIni := Ctod("01/" + StrZero(i,2) + "/" +Str(nAno,4),"ddmmyy")
	dDataFim := LastDay(dDataIni)
	aCotMes := CalcMedia (dDataIni,dDataFim)
	AAdd (aCotacao,aCotMes)
Next i

return aCotacao

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ValorMed ³ Autor ³ Valter G. Nogueira Jr.³ Data ³ 03/02/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Devolve o valor convertido pelo valor medio da moeda       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ExpN1:=ValorMed(ExpN2,ExpN2,ExpC1,ExpD1)                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = Valor convertido                                   ³±±
±±³          ³ ExpN2 = Valor a converter                                  ³±±
±±³          ³ ExpC1 = Moeda original                                     ³±±
±±³          ³ ExpC2 = Moeda desejada                                     ³±±
±±³          ³ ExpA1 = Array com o valor das moedas                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function ValorMed(nValor,nMoedaOri,nMoeda,aCotacao)
LOCAL nValRet:=0,cMoedaAtu,cMoeda
cMoedaOri := StrZero(nMoedaOri,1)
cMoeda    := StrZero(nMoeda,1) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se moeda pesquisa e' igual a digitada, devolve o proprio valor ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cMoedaOri==cMoeda
	Return nValor
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica em que moeda esta' o titulo                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nMoedaOri:=Iif(nMoedaOri==0,1,nMoedaOri)
nValRet := (nValor * IIF(aCotacao[nMoedaOri]=0,1,aCotacao[nMoedaOri]) ;
               / IIF(aCotacao[nMoeda]=0,1,aCotacao[nMoeda]))
nValRet := int(100 * nValRet) / 100
Return nValRet

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ExistMoeda ³ Autor ³ Cesar C S Prado       ³ Data ³ 20/05/94 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Devolve .T. se existir a moeda solicitada                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ExpN1:=ValorMed(ExpD1,ExpC1)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpD1 = Data a verificar                                     ³±±
±±³          ³ ExpC1 = Numero da moeda a verificar                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function ExistMoeda(dData,cMoeda)
Local lRet:=.T.
Local cAlias:=Alias()
dbSelectArea( "SM2" )
lRet:=dbSeek(dData)
lRet:=IIf(SM2->(EOF()) .or. &("M2_MOEDA"+cMoeda) = 0,.F.,.T.)
dbSelectArea(cAlias)
Return lRet
