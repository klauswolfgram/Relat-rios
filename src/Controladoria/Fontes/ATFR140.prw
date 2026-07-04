/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FiveWin.ch"

// 17/08/2009 - Ajuste para filiais com mais de 2 caracteres.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR140  ³ Autor ³ Wagner Xavier         ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Raz„o Analitico do Ativo por item                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ATFR140                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR140()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cString := "SN3"
LOCAL cDesc1  := OemToAnsi( "Este relatorio ir  imprimir o Raz„o Auxiliar do Ativos" )
LOCAL cDesc2  := OemToAnsi( "Imobilizados (RAZORT) por Conta e Item  da  Conta na " )
LOCAL cDesc3  := OemToAnsi( "moeda corrente.")
LOCAL wnrel
LOCAL cCol1
LOCAL cCol2
LOCAL aDados := {}

PRIVATE aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
PRIVATE aLinha   := { }
PRIVATE cPerg    :="AFR140"
PRIVATE nomeprog :="ATFR140"
PRIVATE nLastKey := 0
PRIVATE titulo   := "Razao Auxiliar"
PRIVATE cabec1   := ""
PRIVATE cabec2   := ""
PRIVATE tamanho  := "M"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                  ³
//³ mv_par01         // da Conta                                        ³
//³ mv_par02         // ate a Conta                                     ³
//³   mv_par03       // do Item                                         ³ inc
//³   mv_par04       // ate o Item                                      ³ inc
//³ mv_par05         // do Mes                                          ³
//³ mv_par06         // Ate o Mes                                       ³
//³ mv_par07         // da Moeda                                        ³
//³ mv_par08         // Salta pagina na quebra de conta ? (Sim/Nao)     ³
//³ mv_par09         // Quebra Mes a Mes ? (Sim/Nao)                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aDados, {"Da Conta ?","¿De Cuenta ?","From Account ?","mv_ch1","C",LEN(SN3->N3_CCONTAB),0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","CT1","S","003","",""})
Aadd(aDados, {"Ate a Conta ?","¿A Cuenta ?","To Account ?","mv_ch2","C",LEN(SN3->N3_CCONTAB),0,0,"G","","mv_par02","","","",Replicate("Z",LEN(SN3->N3_CCONTAB)),"","","","","","","","","","","","","","","","","","","","","CT1","S","003","",""})
Aadd(aDados, {"Do Item Contabil ?","¿De Item Contable ?","From Accounting It. ?","mv_ch3","G",LEN(SN3->N3_SUBCTA),0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","CTD","S","005","",""})
Aadd(aDados, {"Até Item ?","¿A Item ?","To Item ?","MV_CH4","G",LEN(SN3->N3_SUBCTA),0,0,"G","","mv_par04","","","",Replicate("Z",LEN(SN3->N3_SUBCTA)),"","","","","","","","","","","","","","","","","","","","","CTD","S","005","",""})
Aadd(aDados, {"Do Mes ?","¿De Mes ?","From Month ?","mv_ch5","N",2,0,0,"G","","mv_par05","","",""," 1","","","","","","","","","","","","","","","","","","","","","","S","","",""})
Aadd(aDados, {"Ate o mes ?","¿A Mes ?","To Month ?","mv_ch6","N",2,0,0,"G","","mv_par06","","","","12","","","","","","","","","","","","","","","","","","","","","","S","","",""})
Aadd(aDados, {"Qual a moeda ?","¿Que Moneda ?","What is the Currency ?","mv_ch7","N",1,0,2,"C","","mv_par07","Moeda 2","Moneda 2","Currency 2","","","Moeda 3","Moneda 3","Currency 3","","","Moeda 4","Moneda 4","Currency 4","","","Moeda 5","Moneda 5","Currency 5","","","","","","","","S","","",""})
Aadd(aDados, {"Salta pagina quebra ?","¿Pasa salto de pag. ?","Skip Page Break ?","mv_ch8","N",1,0,2,"C","","mv_par08","Sim","Si","Yes","","","Nao","No","No","","","","","","","","","","","","","","","","","","S","","",""})
Aadd(aDados, {"Quebra Mes a Mes ?","¿Divide por mes ?","Break per Month ?","mv_ch9","N",1,0,2,"C","","mv_par09","Sim","Si","Yes","","","Nao","No","No","","","","","","","","","","","","","","","","","","S","","",""})
AjustaSx1("AFR140",aDados)
pergunte( "AFR140",.F. )

SET DECIMALS TO 4

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Direciona para definicao dos parametros da impressao do relatorio         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel :="ATFR140"
wnrel :=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If  nLastKey == 27
    Return
End

SetDefault( aReturn,cString )

If nLastKey == 27
    Return
End

cAtfMoeda := GETMV("MV_ATFMOEDA")
cSimbolo  := AllTrim( GETMV("MV_SIMB" + Str(mv_par07+1,1,0) ) )

cCol1   := "Valor em "+AllTrim(GETMV("MV_SIMB1"))
cCol1   := Space(21-Len(cCol1))+cCol1
cCol2   := "Valor " + cSimbolo 
cCol2   := Space(13-Len(cCol2))+cCol2

titulo  += " em " + cSimbolo
cabec1  := "  Data   Historico       "+cCol1+" Refer.  "+cCol2+"            Acrescimo           Decrescimo          Saldo  Atual"

RptStatus({|lEnd| FR140Imp(@lEnd,wnRel,cString)},Titulo)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR140  ³ Autor ³ Wagner Xavier         ³ Data ³ 03.08.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Raz„o Analitico do Ativo                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_ATFR140(lEnd,WnRel,Titulo)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FR140Imp(lEnd,WnRel,cString)

Local cConta,aSaldos[5],nMoeda
Local nMesDe,nMesAte,nFirst:=0
Local lValor
Local nTotAcresc := 0
Local nTotDimin  := 0
Local cRefere    := " "
Local nValorX    := 0
Local nMoedaX    := 0
Local aMeses     := {"Jan","Fev","Mar","Abr","Mai","Jun",;
                    "Jul","Ago","Set","Out","Nov","Dez"}

Local aTotMeses  := {}
Local dMesAtual  := cTod("")
Local nTacMes    := 0
Local nTdimMes   := 0
Local CbTxt
Local cbCont
Local limite:=132
Local lCtb       := CtbInUse()
Local cGrupoPass := GetMv("MV_GRPASS")
Local lInverte   := .F.

cbtxt   := SPACE( 10 )
cbcont  := 0
li      := 80
m_pag   := 1

titulo  :="Razao Auxiliar Por Conta e Item em "+ cSimbolo

dbSelectArea( "SN5" )
SN5->( dbseek( cFilial+mv_par01, .T. ) )

cMoeda  := Str(mv_par07+1,1)
nMoeda  := mv_par07+1
nMesDe  := mv_par05
nMesAte := mv_par06

SetRegua(SN5->(RecCount()))

While ! SN5->(Eof()) .And. SN5->N5_FILIAL==cFilial .And. SN5->N5_CONTA<=mv_par02
    
   IF  lEnd
       @PROW()+1,001 PSAY "CANCELADO PELO OPERADOR"
       Exit
   End
	    
   cConta  := SN5->N5_CONTA
	nFirst := 0
	
  	If lCtb
		dbSelectArea("CT1")
		dbSetOrder(1)
		If dbSeek(xFilial("CT1")+cConta)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ lInverte ‚ .T. se conta pertence ao grupo de contas Credoras (cGru-³
			//³ poPass),I1_NORMAL = "C", mas o saldo e devedor                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (CT1->CT1_NORMAL=="1" .And. SUBS(cConta,1,1)$cGrupoPass)
				lInverte := .T.
			Endif
		Endif
 	Else
		dbSelectArea("SI1")
		dbSetOrder(1)
		If dbSeek(xFilial("SI1")+cConta)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ lInverte ‚ .T. se conta pertence ao grupo de contas Credoras (cGru-³
			//³ poPass),I1_NORMAL = "C", mas o saldo e devedor                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (SI1->I1_NORMAL=="D" .And. SUBS(cConta,1,1)$cGrupoPass)
				lInverte := .T.
			Endif
		Endif
	EndIf

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula Saldo Inicial.O saldo inicial nao muda de sinal, pois  ³
	//³na virada anual j  vem c/ o sinal correto de acordo com a condi-³
	//³‡„o da conta (I1_NORMAL).                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SN5")
	IF SN5->N5_TIPO == "0"
		aSaldos[1] := SN5->N5_VALOR1
		aSaldos[2] := SN5->N5_VALOR2
		aSaldos[3] := SN5->N5_VALOR3
		aSaldos[4] := SN5->N5_VALOR4
		aSaldos[5] := SN5->N5_VALOR5
		SN5->( dbSkip())
    Else
		Afill( aSaldos, 0 )
    End
    
    aTotMeses := aClone( aSaldos )  
    
    While ! SN5->( Eof() ) .and. cFilial==SN5->N5_FILIAL .and. SN5->N5_CONTA == cConta
        
        If  li > 58
            cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
        End
        
        IF lEnd
            @PROW()+1,001 PSAY "CANCELADO PELO OPERADOR"
            Exit
        End
        
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Movimentacao da regua                                               ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        IncRegua()
        
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se nao ultrapassou o intervalo solicitado                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF (Month(SN5->N5_DATA) > nMesAte .and. Year(SN5->N5_DATA) >= Year(dDataBase)).or. Year(SN5->N5_DATA) > Year(dDataBase)
				SN5->(dbSkip())
				Loop
			Endif
        
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Acumula o saldo anterior                                            ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        IF  Month( SN5->N5_DATA ) < nMesDe .or. Year( SN5->N5_DATA ) < Year( dDataBase )
            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
            //³ tipo == 0 +- Saldo Inicial ( D/C)        ³
            //³            1  + Imobilizacao                ³
            //³            2  + Ampliacao                   ³
            //³            3  + Reavaliacao                 ³
            //³            4  + Depreciacao                 ³
            //³            5  - Baixa                       ³
            //³            6  + Corr.Monet.                 ³
            //³            7  + Corr.Monet.Depr.            ³
            //³            8  - Transf.de                   ³
            //³            9  + Transf.para                 ³
            //³            A  - Imob Capital                ³
            //³            B  + Imob Capital                ³
            //³            C  + Baixa Capital               ³
            //³            D  - Baixa Capital c/Prejuizo    ³
            //³            E  - Amplia‡„o Capital           ³
            //³            F  + Amplia‡„o Capital Prejuizo  ³
            //³            G  + Transf DE Patrimonio        ³
            //³            H  - Transf DE Patrimonio Prej.  ³
            //³            I  - Transf P/ Patrimonio        ³
            //³            J  + Transf P/ Patrimonio Prej.  ³
            //³            K  + Deprec Acelerada Positiva   ³
            //³            L  - Deprec Acelerada Negativa   ³
            //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
            If lInverte
					If SN5->N5_TIPO $ "1234679BCFGJKPQSV"
						aSaldos [ 1 ]        -= SN5->N5_VALOR1
						aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)
						aTotMeses [ 1 ]      -= SN5->N5_VALOR1
						aTotMeses [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
					Else
						aSaldos [ 1 ]        += SN5->N5_VALOR1
						aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)
						aTotMeses [ 1 ]      += SN5->N5_VALOR1
						aTotMeses [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
					Endif
				Else
					If SN5->N5_TIPO $ "1234679BCFGJKPQTU"
						aSaldos [ 1 ]        += SN5->N5_VALOR1
						aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)
						aTotMeses [ 1 ]      += SN5->N5_VALOR1
						aTotMeses [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
					Else
						aSaldos [ 1 ]        -= SN5->N5_VALOR1
						aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)
						aTotMeses [ 1 ]      -= SN5->N5_VALOR1
						aTotMeses [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
					Endif
				Endif
            SN5->( dbSkip( ) )
            Loop
			End
        
			IF nFirst == 0
				nFirst++   
				If lCtb
					dbSelectArea("CT1")
					dbSetOrder( 1 )
					dbSeek(cFilial+cConta)
					@ li    ,  0    PSAY "CONTA: "+Mascara(cConta)+" "+CT1->CT1_DESC01  //"CONTA: "
				Else
					dbSelectArea("SI1")
					SI1->( dbSetOrder( 1 ) )
					SI1->( dbSeek( cFilial+cConta ) )
					@ li    ,  0    PSAY "CONTA: "+Mascara(cConta)+" "+SI1->I1_DESC  //"CONTA: "
				EndIf				
				@++li   ,  9    PSAY "SALDO ANTERIOR"
				@ li    , 25    PSAY aSaldos[1]         PICTURE PesqPict("SN5","N5_VALOR1"      ,21,1     )
				@ li    ,112    PSAY aSaldos[nMoeda]    PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				li++
				dbSelectArea ( "SN5" )
			EndIf
        
			lValor:=.F.
        
        	If lInverte  
				If SN5->N5_TIPO $"1234679BCFGJKPQSV"
					lValor := .T.
					aSaldos [ 1 ]        -= SN5->N5_VALOR1
					aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)
					aTotMeses [ 1 ]      -= SN5->N5_VALOR1
					aTotMeses [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
				Else
					aSaldos [ 1 ]        += SN5->N5_VALOR1
					aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)
					aTotMeses [ 1 ]      += SN5->N5_VALOR1
					aTotMeses [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
				Endif
			Else
				If SN5->N5_TIPO $"1234679BCFGJKPQTU"
					lValor := .T.
					aSaldos [ 1 ]        += SN5->N5_VALOR1
					aSaldos [ nMoeda ]   += &('SN5->N5_VALOR'+cMoeda)
					aTotMeses [ 1 ]      += SN5->N5_VALOR1
					aTotMeses [ nMoeda ] += &('SN5->N5_VALOR'+cMoeda)
				Else
					aSaldos [ 1 ]        -= SN5->N5_VALOR1
					aSaldos [ nMoeda ]   -= &('SN5->N5_VALOR'+cMoeda)
					aTotMeses [ 1 ]      -= SN5->N5_VALOR1
					aTotMeses [ nMoeda ] -= &('SN5->N5_VALOR'+cMoeda)
				Endif
			Endif
        
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Impressao da movimentacao identificada                              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cRefere := aMeses[Month(SN5->N5_DATA)]+"/"+Subs(StrZero(Year(SN5->N5_DATA),4),3,2)
			nValorX := SN5->&("N5_VALOR"+cMoeda)
      	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³  Imprime o valor registrado da ufir se o valor da ufir for registrada e            ³
			//³  se a moeda do relat¢rio for ufir.                                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SN5->N5_TAXA # 0 .and. (mv_par05 + 1) = Val(cAtfMoeda)
				nMoedaX := SN5->N5_TAXA
			Else    
				If nValorX == 0
					nMoedaX := IIF(aSaldos[nMoeda] <> 0, aSaldos[1] / aSaldos[nMoeda], 0)
				Else
					nMoedaX := SN5->N5_VALOR1 / nValorX     //),X3Decimal("N5_VALOR"+cMoeda))
				Endif
			Endif
	
			@ li,  0 PSAY SN5->N5_DATA
			@ li, 11 PSAY AFDescSal( SN5->N5_TIPO )
			If lInverte
				If SN5->N5_TIPO=="B"
					@ li, 25 PSAY SN5->N5_VALOR1*(-1) 	PICTURE  PesqPict("SN5","N5_VALOR1",21,1)
				Else
					@ li, 25 PSAY SN5->N5_VALOR1 		PICTURE  PesqPict("SN5","N5_VALOR1",21,1)
				Endif
			Else
				If SN5->N5_TIPO == "A"
					@ li, 25 PSAY SN5->N5_VALOR1*(-1) 	PICTURE  PesqPict("SN5","N5_VALOR1",21,1)
				Else
					@ li, 25 PSAY SN5->N5_VALOR1 		PICTURE  PesqPict("SN5","N5_VALOR1",21,1)
				Endif
			Endif
			@ li, 47 PSAY cRefere
			@ li, 55 PSAY nMoedaX  PICTURE PesqPict("SM2","M2_MOEDA"+cMoeda,11,nMoeda)
	
			If lValor
				@ li, 69    PSAY nValorX    PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				nTotAcresc += nValorX
				nTacMes += nValorx
			Else
				@ li, 90    PSAY nValorX    PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				nTotDimin  += nValorX
				nTdimMes += nValorx
			EndIf
			If lInverte
				If SN5->N5_TIPO=="B"
					@ li,112   PSAY aSaldos[nMoeda]*(-1) 	PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				Else
					@ li,112   PSAY aSaldos[nMoeda] 		PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				Endif
			Else
				If SN5->N5_TIPO=="A"
					@ li,112   PSAY aSaldos[nMoeda]*(-1) 	PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				Else
					@ li,112   PSAY aSaldos[nMoeda] 		PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
				Endif		
			Endif
			li++
			dMesAtual   := SN5->N5_DATA
			cContaAtual := SN5->N5_CONTA
        
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Trata a quebra por mes                                        ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If  mv_par09 == 1 .and. nFirst # 0
            If  Month(SN5->N5_DATA)     # Month(dMesAtual)  .or. ;
                Year(SN5->N5_DATA)   # Year(dMesAtual)    .or. ;
                cContaAtual # SN5->N5_CONTA
                
                li ++
                @ li,  0    PSAY    "TOTAL DO MES: "+Iif(!Empty(dMesAtual), aMesExt[Month(dMesAtual)], "")  
                @ li, 25    PSAY    aTotMeses[1]        PICTURE PesqPict("SN5","N5_VALOR1"      ,21)
                @ li, 69    PSAY    nTacMes             PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20)
                @ li, 90    PSAY    nTdimMes            PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20)
                @ li,112    PSAY    aTotMeses[nMoeda]   PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20)
                li++
                @ li, 25    PSAY    "---------------------"
                @ li, 69    PSAY    "--------------------"
                @ li, 90    PSAY    "--------------------"
                @ li,112    PSAY    "--------------------"
                li ++
            Endif
        Endif
        SN5->( dbSkip() )             
    End

    afill(aTotMeses ,0)
    nTacMes := 0
    nTdimMes := 0
    
    IF nFirst == 0
		IF li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		Endif
		nFirst++
		If lCtb
			dbSelectArea( "CT1" )
			dbSetOrder( 1 )
			dbSeek( cFilial+cConta )
			@ li    , 0     PSAY "CONTA: "+Mascara(cConta)+" "+CT1->CT1_DESC01  //"CONTA: "
		Else
			dbSelectArea( "SI1" )
			SI1->(dbSetOrder( 1 ))
			SI1->(dbSeek( cFilial+cConta ))	
			@ li    , 0     PSAY "CONTA: " + Mascara(cConta)+" "+SI1->I1_DESC  //"CONTA: "
		EndIf
		@ ++li  , 9     PSAY "SALDO ANTERIOR"
		@ li    , 25    PSAY aSaldos[1]			PICTURE PesqPict("SN5","N5_VALOR1"      ,21,1     )
		@ li    ,112    PSAY aSaldos[nMoeda]	PICTURE PesqPict("SN5","N5_VALOR"+cMoeda,20,nMoeda)
		li++
		dbSelectArea ( "SN5" )
	End
    
    IF nFirst != 0
        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Somente mostra o total da conta se nao houver quebra por mes. ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If  mv_par09 # 1
            @ li, 25    PSAY "---------------------"
            @ li, 69    PSAY "--------------------"
            @ li, 90    PSAY "--------------------"
            @ li,112    PSAY "--------------------"
            li++
            @ li, 00    PSAY "TOTAL DA CONTA "
            @ li, 25    PSAY aSaldos[1]         PICTURE     PesqPict("SN5","N5_VALOR1"      ,21)
            @ li, 69    PSAY nTotAcresc         PICTURE     PesqPict("SN5","N5_VALOR"+cMoeda,20)
            @ li, 90    PSAY nTotDimin          PICTURE     PesqPict("SN5","N5_VALOR"+cMoeda,20)
            @ li,112    PSAY aSaldos[nMoeda]    PICTURE     PesqPict("SN5","N5_VALOR"+cMoeda,20)
        Endif
        li++
        @ li, 0 PSAY    Replicate("-",Limite)
        li++
        nTotAcresc := 0
        nTotDimin  := 0
    Endif
	 // CHAMAR FUNCAO PARA IMPRIMIR SUBCONTA SE EXISTIR    
	 U_AFR140Item(cConta, lInverte, lCtb)
    IF MV_PAR08 == 1
        li:=60
    Endif
    dbSelectArea ( "SN5" )
End

IF li != 80
    Roda(cbcont,cbtxt,Tamanho)
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura posi‡”es originais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SN5" )
dbSetOrder( 1 )

If aReturn[5] = 1
    Set Printer To
    dbCommitAll()
    Ourspool(wnrel)
Endif
dbSelectArea("SN5")

MS_FLUSH()

Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o	 ³U_AFR140ITEM()³ Autor ³ Alice Yamamoto      ³ Data ³02.03.98  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime Item se existir                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ AFR140                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Afr140Item(cConta,lInverte, lCtb)
Local aArea := { Alias(), IndexOrd(), Recno() }
Local aSaldos[5],nMoeda
Local nMesDe,nMesAte,nFirst:=0
Local lValor
Local nTotAcresc := 0
Local nTotDimin  := 0
Local cRefere    := " "
Local nValorX    := 0
Local nMoedaX    := 0
Local aMeses     := {"Jan","Fev","Mar","Abr","Mai","Jun",;
                    "Jul","Ago","Set","Out","Nov","Dez"}

Local aTotMeses  := {}
Local dMesAtual  := cTod("")
Local nTacMes    := 0
Local nTdimMes   := 0
//Local CbTxt
//Local cbCont
Local limite:=132

dbSelectArea("SN6")
dbSetOrder(1)
If dbSeek(xFilial("SN6")+cConta)

	cMoeda  := Str(mv_par07+1,1)
	nMoeda  := mv_par07+1
	nMesDe  := mv_par05
	nMesAte := mv_par06

	SetRegua(SN6->(RecCount()))
	cSubCta := SN6->N6_SUBCTA
	While ! SN6->(Eof()) .And. SN6->N6_FILIAL==cFilial .And. SN6->N6_CONTA == cConta
		If SN6->N6_SUBCTA < mv_par03 .Or. SN6->N6_SUBCTA > mv_par04
			dbSkip()
			Loop
		Endif
    
		cSubCta := SN6->N6_SUBCTA
		nFirst := 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula Saldo Inicial.O saldo inicial nao muda de sinal, pois  ³
		//³na virada anual j  vem c/ o sinal correto de acordo com a condi-³
		//³‡„o da conta (I1_NORMAL).                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF  SN6->N6_TIPO == "0"
			 aSaldos [ 1 ] := SN6->N6_VALOR1
			 aSaldos [ 2 ] := SN6->N6_VALOR2
			 aSaldos [ 3 ] := SN6->N6_VALOR3
			 aSaldos [ 4 ] := SN6->N6_VALOR4
			 aSaldos [ 5 ] := SN6->N6_VALOR5
			 SN6->( dbSkip())
		Else
			 Afill( aSaldos, 0 )
		End
    
		aTotMeses := aClone( aSaldos )  
    
		While ! SN6->( Eof() ) .and. SN6->N6_CONTA == cConta .And. SN6->N6_SUBCTA == cSubCta
        
			If li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			End
        
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Movimentacao da regua                                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncRegua()
        
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se nao ultrapassou o intervalo solicitado                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF (Month(SN6->N6_DATA) > nMesAte .and. Year(SN6->N6_DATA) >= Year(dDataBase)).or. Year(SN6->N6_DATA) > Year(dDataBase)
				 SN6->(dbSkip())
				 Loop
			Endif
        
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula o saldo anterior                                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IF  Month( SN6->N6_DATA ) < nMesDe .or. Year( SN6->N6_DATA ) < Year( dDataBase )
				 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				 //³ tipo ==    0 +- Saldo Inicial ( D/C)        ³
				 //³            1  + Imobilizacao                ³
				 //³            2  + Ampliacao                   ³
				 //³            3  + Reavaliacao                 ³
				 //³            4  + Depreciacao                 ³
				 //³            5  - Baixa                       ³
				 //³            6  + Corr.Monet.                 ³
				 //³            7  + Corr.Monet.Depr.            ³
				 //³            8  - Transf.de                   ³
				 //³            9  + Transf.para                 ³
				 //³            A  - Imob Capital                ³
				 //³            B  + Imob Capital                ³
				 //³            C  + Baixa Capital               ³
				 //³            D  - Baixa Capital c/Prejuizo    ³
				 //³            E  - Amplia‡„o Capital           ³
				 //³            F  + Amplia‡„o Capital Prejuizo  ³
				 //³            G  + Transf DE Patrimonio        ³
				 //³            H  - Transf DE Patrimonio Prej.  ³
				 //³            I  - Transf P/ Patrimonio        ³
				 //³            J  + Transf P/ Patrimonio Prej.  ³
				 //³            K  + Deprec Acelerada Positiva   ³
				 //³            L  - Deprec Acelerada Negativa   ³
				 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				 If lInverte
					If SN6->N6_TIPO $ "1234679BCFGJKPQSV"
						aSaldos [ 1 ]        -= SN6->N6_VALOR1
						aSaldos [ nMoeda ]   -= &('SN6->N6_VALOR'+cMoeda)
						aTotMeses [ 1 ]      -= SN6->N6_VALOR1
						aTotMeses [ nMoeda ] -= &('SN6->N6_VALOR'+cMoeda)
					Else
						aSaldos [ 1 ]        += SN6->N6_VALOR1
						aSaldos [ nMoeda ]   += &('SN6->N6_VALOR'+cMoeda)
						aTotMeses [ 1 ]      += SN6->N6_VALOR1
						aTotMeses [ nMoeda ] += &('SN6->N6_VALOR'+cMoeda)
					Endif
				Else
					If SN6->N6_TIPO $ "1234679BCFGJKPQTU"
						aSaldos [ 1 ]        += SN6->N6_VALOR1
						aSaldos [ nMoeda ]   += &('SN6->N6_VALOR'+cMoeda)
						aTotMeses [ 1 ]      += SN6->N6_VALOR1
						aTotMeses [ nMoeda ] += &('SN6->N6_VALOR'+cMoeda)
					Else
						aSaldos [ 1 ]        -= SN6->N6_VALOR1
						aSaldos [ nMoeda ]   -= &('SN6->N6_VALOR'+cMoeda)
						aTotMeses [ 1 ]      -= SN6->N6_VALOR1
						aTotMeses [ nMoeda ] -= &('SN6->N6_VALOR'+cMoeda)
					Endif
				Endif
				SN6->( dbSkip( ) )
				Loop
			End
        
			IF nFirst == 0
				nFirst++
				If lCtb
					CTD->(DbSetOrder(1))
					CTD->(MsSeek(xFilial("CTD")+cSubCta))
					dbSelectArea("CT1")
					dbSetOrder( 1 )
					dbSeek(cFilial+cConta)
					@ li    ,  0    PSAY "CONTA: "+Mascara(cConta)+" "+CT1->CT1_DESC01  + " ITEM: " + cSubCta + " " + CTD->CTD_DESC01 //"CONTA: "
				Else
					dbSelectArea("SI1")
					SI1->( dbSetOrder( 1 ) )
					SI1->( dbSeek( cFilial+cConta ) )
					@ li    ,  0    PSAY "CONTA/ITEM: "+Mascara(cConta)+" "+SI1->I1_DESC  + cSubCta //"CONTA: "
				EndIf
				@++li   ,  9    PSAY "SALDO ANTERIOR"
				@ li    , 25    PSAY aSaldos[1]         PICTURE PesqPict("SN6","N6_VALOR1"      ,21)
				@ li    ,112    PSAY aSaldos[nMoeda]    PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20)
				li++
				dbSelectArea ( "SN6" )
			EndIf
        
			lValor:=.F.
        
			If lInverte  
				If SN6->N6_TIPO $"1234679BCFGJKPQSV"
					lValor := .T.
					aSaldos [ 1 ]        -= SN6->N6_VALOR1
					aSaldos [ nMoeda ]   -= &('SN6->N6_VALOR'+cMoeda)
					aTotMeses [ 1 ]      -= SN6->N6_VALOR1
					aTotMeses [ nMoeda ] -= &('SN6->N6_VALOR'+cMoeda)
				Else
					aSaldos [ 1 ]        += SN6->N6_VALOR1
					aSaldos [ nMoeda ]   += &('SN6->N6_VALOR'+cMoeda)
					aTotMeses [ 1 ]      += SN6->N6_VALOR1
					aTotMeses [ nMoeda ] += &('SN6->N6_VALOR'+cMoeda)
				Endif
			Else
				If SN6->N6_TIPO $"1234679BCFGJKPQTU"
					lValor := .T.
					aSaldos [ 1 ]        += SN6->N6_VALOR1
					aSaldos [ nMoeda ]   += &('SN6->N6_VALOR'+cMoeda)
					aTotMeses [ 1 ]      += SN6->N6_VALOR1
					aTotMeses [ nMoeda ] += &('SN6->N6_VALOR'+cMoeda)
				Else
					aSaldos [ 1 ]        -= SN6->N6_VALOR1
					aSaldos [ nMoeda ]   -= &('SN6->N6_VALOR'+cMoeda)
					aTotMeses [ 1 ]      -= SN6->N6_VALOR1
					aTotMeses [ nMoeda ] -= &('SN6->N6_VALOR'+cMoeda)
				Endif
			Endif
        
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³ Impressao da movimentacao identificada                              ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 cRefere := aMeses[Month(SN6->N6_DATA)]+"/"+Subs(StrZero(Year(SN6->N6_DATA),4),3,2)
			 nValorX := SN6->&("N6_VALOR"+cMoeda)
			 //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			 //³  Imprime o valor registrado da ufir se o valor da ufir for registrada e            ³
			 //³  se a moeda do relat¢rio for ufir.                                                 ³
			 //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			 If SN6->N6_TAXA # 0 .and. (mv_par07 + 1) = Val(cAtfMoeda)
				  nMoedaX := SN6->N6_TAXA
			 Else    
				  If  nValorX == 0
						nMoedaX := IIF(aSaldos[nMoeda] <> 0, aSaldos[1] / aSaldos[nMoeda], 0)
				  Else
						nMoedaX := SN6->N6_VALOR1 / nValorX     //),X3Decimal("VALOR"+cMoeda))
				  Endif
			 Endif
			 @ li,  0    PSAY SN6->N6_DATA
			 @ li,  9    PSAY AFDescSal( SN6->N6_TIPO )
			If lInverte
			 	If SN6->N6_TIPO=="B"
					@ li, 25    PSAY SN6->N6_VALOR1*(-1)     PICTURE  PesqPict("SN6","N6_VALOR1",21)
				Else
					@ li, 25    PSAY SN6->N6_VALOR1     PICTURE  PesqPict("SN6","N6_VALOR1",21)
				Endif
			Else
				If SN6->N6_TIPO=="A"
					@ li, 25    PSAY SN6->N6_VALOR1*(-1)     PICTURE  PesqPict("SN6","N6_VALOR1",21)
				Else
					@ li, 25    PSAY SN6->N6_VALOR1     PICTURE  PesqPict("SN6","N6_VALOR1",21)
				Endif
			Endif
			@ li, 47    PSAY cRefere
			@ li, 55    PSAY nMoedaX  PICTURE PesqPict("SM2","M2_MOEDA"+cMoeda,11,nMoeda)
        
			If lValor
				@ li, 69    PSAY nValorX    PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20)
				nTotAcresc += nValorX
				nTacMes += nValorx
			Else
				@ li, 90    PSAY nValorX    PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20)
				nTotDimin  += nValorX
				nTdimMes += nValorx
			EndIf
			If lInverte
				If SN6->N6_TIPO=="B"
					@ li,112   PSAY aSaldos[nMoeda]*(-1) 	PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20,nMoeda)
				Else
					@ li,112   PSAY aSaldos[nMoeda] 		PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20,nMoeda)
				Endif
			Else
				If SN6->N6_TIPO=="A"
					@ li,112   PSAY aSaldos[nMoeda]*(-1) 	PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20,nMoeda)
				Else
					@ li,112   PSAY aSaldos[nMoeda] 		PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20,nMoeda)
				Endif		
			Endif
			li++
			dMesAtual   := SN6->N6_DATA
			SN6->( dbSkip() )
		EndDo
    
		afill(aTotMeses ,0)
		nTacMes := 0
		nTdimMes := 0
    
		IF nFirst == 0
			IF  li > 58
				 cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			End
			nFirst++
			If lCtb
				CTD->(DbSetOrder(1))
				CTD->(MsSeek(xFilial("CTD")+cSubCta))
				dbSelectArea("CT1")
				dbSetOrder( 1 )
				dbSeek(cFilial+cConta)
				@ li    ,  0    PSAY "CONTA: "+Mascara(cConta)+" "+CT1->CT1_DESC01  + " ITEM: " + cSubCta + " " + CTD->CTD_DESC01 //"CONTA: "
			Else
				dbSelectArea("SI1")
				SI1->( dbSetOrder( 1 ) )
				SI1->( dbSeek( cFilial+cConta ) )
				@ li    ,  0    PSAY "CONTA/ITEM: "+Mascara(cConta)+" "+SI1->I1_DESC  + cSubCta //"CONTA: "
			EndIf
			@ ++li  , 9     PSAY "SALDO ANTERIOR"
			@ li    , 25    PSAY aSaldos[1]         PICTURE PesqPict("SN6","N6_VALOR1"      ,21)
			@ li    ,112    PSAY aSaldos[nMoeda]    PICTURE PesqPict("SN6","N6_VALOR"+cMoeda,20)
			li++
			dbSelectArea ( "SN6" )
		End
    
		IF nFirst != 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Somente mostra o total da conta se nao houver quebra por mes. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If  mv_par09 # 1
				 @ li, 25    PSAY "---------------------"
				 @ li, 69    PSAY "--------------------"
				 @ li, 90    PSAY "--------------------"
				 @ li,112    PSAY "--------------------"
				 li++
				 @ li, 00    PSAY "Total da conta/Item "
				 @ li, 25    PSAY aSaldos[1]         PICTURE     PesqPict("SN6","N6_VALOR1"      ,21)
				 @ li, 69    PSAY nTotAcresc         PICTURE     PesqPict("SN6","N6_VALOR"+cMoeda,20)
				 @ li, 90    PSAY nTotDimin          PICTURE     PesqPict("SN6","N6_VALOR"+cMoeda,20)
				 @ li,112    PSAY aSaldos[nMoeda]    PICTURE     PesqPict("SN6","N6_VALOR"+cMoeda,20)
			Endif
			li++
			@ li++, 0 PSAY    Replicate("-",Limite)
			li++
			nTotAcresc := 0
			nTotDimin  := 0
		Endif
		IF MV_PAR08 == 1
			 li:=60
		Endif
		dbSelectArea ( "SN6" )
	EndDo

Endif

dbSelectArea( aArea[1] )
dbSetOrder( aArea[2] )
dbGoto( aArea[3] )
Return