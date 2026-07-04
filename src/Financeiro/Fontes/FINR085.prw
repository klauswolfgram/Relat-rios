/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SIGAWIN.CH"
#INCLUDE "FINR085.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINR085   บAutor  ณJeniffer Larrosa    บFecha ณ  11/12/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de impressao da Ordem de Pagamento.                  บฑฑ
ฑฑบ          ณAntigo PAGR011.prx                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Financeiro                                                 บฑฑ
ฑฑฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     บฑฑ
ฑฑฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ PROGRAMADOR  ณ DATA   ณ BOPS ณ  MOTIVO DA ALTERACAO                   บฑฑ
ฑฑฬออออออออออออออุออออออออุออออออุออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Bruno        ณ31/01/00ณMelhorณCorrecao da Impressao dos Certificados. บฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Finr085()
Local nX := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de variaveis utilizadas no programa atraves da funcao    ณ
//ณ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ณ
//ณ identificando as variaveis publicas do sistema utilizadas no codigo ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("NLIN,WNREL,NTAMRM,CSTRING,CFORNECE,CLOJA")
SetPrvt("CORDPAGO,ACHQPR,ACHQTER,ANFS,APAAPL,APAGER")
SetPrvt("ARETS,DDTEMIS,NBAIXA,NBAIXAMD1,CMOEDAANT,CNOME,CDIRE")
SetPrvt("CMUN,CCUIT,CEST,CTIPOFOR,NTOTAL,I")
SetPrvt("NTOTMOED1,CTIPORET,NA,ATASAS,DDATAMOEDAS,NX")
SetPrvt("NLININI,NOPC,_SALIAS,AREGS,J")

//+--------------------------------------------------------------+
//ฆ Variaveis utilizadas para parametros                         ฆ
//ฆ mv_par01             // Do RECIBO                            ฆ
//ฆ mv_par02             // Ate RECIBO                           ฆ
//ฆ mv_par03             // Da data                              ฆ
//ฆ mv_par04             // Ate a data                           ฆ
//+--------------------------------------------------------------+
tamanho:="G"
limite:=220
titulo :=PADC(OemToAnsi(STR0001),74)  //"Impresion de la Orden de Pago."
cDesc1 :=PADC(OemToAnsi(STR0002),74)  //"Impresion de las Ordenes de Pago  "
cDesc2 :=PADC(OemToAnsi(STR0003),74)  //"Serแn solicitados los parametros de "
cDesc3 :=PADC(OemToAnsi(STR0004),74)  //"Fecha e intervalo de Ordenes."
cNatureza:=""
aReturn := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 2, 1,1,"",1 }  //"Especial","Administracion"

nomeprog:="FINR085"
cPerg:="FIR085"
nLastKey:= 0
lContinua := .T.
nLin:=0
wnrel:="FINR085"

//+-----------------------------------------------------------+
//ฆ Tamanho do Formulario.                                    ฆ
//+-----------------------------------------------------------+
nTamRm:=72     // Apenas Informativo

//+-------------------------------------------------------------------------+
//ฆ Verifica as perguntas selecionadas, busca o padrao.                     ฆ
//+-------------------------------------------------------------------------+

Pergunte(cPerg,.F.)               // Pergunta no SX1

cString:="SEK"

//+--------------------------------------------------------------+
//ฆ Envia controle para a funcao SETPRINT                        ฆ
//+--------------------------------------------------------------+
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,,,.F.)

If nLastKey == 27
	Return
Endif

//+--------------------------------------------------------------+
//ฆ Verifica Posicao do Formulario na Impressora                 ฆ
//+--------------------------------------------------------------+
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

VerImp()

RptStatus({|| RptDetail()})
Return

Static Function RptDetail()
Local nPosRet, nX, i, nA
DbSelectArea("SEK")
DbSetOrder(1)
DbSeek(xFilial("SEK")+mv_par01,.T.)
//+-----------------------------------------------------------+
//ฆ Inicializa  regua de impressao                            ฆ
//+-----------------------------------------------------------+
SetRegua(Int(RECCOUNT()/2))
While !Eof() .and. SEK->EK_ORDPAGO<= mv_par02 .and. lContinua
	IncRegua()
	If SEK->EK_DTDIGIT < mv_par03   .or.SEK->EK_DTDIGIT > mv_par04 .OR. EK_CANCEL
		DbSkip()
		Loop
	Endif
	cFornece:= EK_FORNECE
	cLoja   := EK_LOJA
	IF lAbortPrint
		@ 00,01 PSAY OemToAnsi(STR0007)  // "** CANCELADO PELO OPERADOR **"
		lContinua := .F.
		Exit
	Endif
	cOrdPago :=SEK->EK_ORDPAGO
	aChqPr  :=      {}
	aChqTer         :=      {}
	aNFs            :=      {}
	aPaApl  :=      {}
	aPaGEr  :=      {}
	aRets           :=      {}
	dDtEmis :=      SEK->EK_DTDIGIT
	nTotal	:=0.00
	nTotMoed1       :=      0
	cMoedaAnt:=     SEK->Ek_MOEDA
	Do while xFilial("SEK")==SEK->EK_FILIAL.And.cOrdPago==SEK->EK_ORDPAGO.and.!SEK->(eof())
		If (SEK->EK_TIPODOC)=="TB"
			If Alltrim(SEK->EK_TIPO) $ MVPAGANT + "/" + MV_CPNEG
				Aadd(aPaApl,{EK_NUM,EK_VALOR,EK_MOEDA,EK_VLMOED1,EK_EMISSAO})
			Else
				nBaixa		:= EK_VALOR + EK_JUROS - EK_DESCONT
				nTotal		+= nBaixa
				nBaixaMd1	:= IIf(EK_MOEDA=="1",nBaixa,xMoeda(nBaixa,Val(EK_MOEDA),1,dDtBaixa))
				nTotMoed1	+= nBaixaMd1
				Aadd(aNfs  ,{EK_PREFIXO,StrZero(Val(EK_NUM),12),EK_PARCELA,EK_TIPO,EK_VENCTO,nBaixa,EK_MOEDA,nBaixaMd1, cPaisLoc <> "BRA" .And.!Empty(SEK->EK_CANPARC) })
			Endif
		ElseIf EK_TIPODOC=="CP"
			Aadd(aChqPr, {EK_TIPO,EK_NUM,EK_VALOR,Getmv("MV_MOEDAP"+STR(VAL(EK_MOEDA),1)),EK_VLMOED1,;
			EK_BANCO,EK_AGENCIA,EK_CONTA,EK_EMISSAO,EK_VENCTO})
		Elseif EK_TIPODOC=="CT"
			Aadd(aChqTer, {EK_TIPO,EK_NUM,EK_VALOR,Getmv("MV_MOEDAP"+STR(VAL(EK_MOEDA),1)),EK_VLMOED1,;
			EK_BANCO,EK_AGENCIA,EK_CONTA,EK_EMISSAO,EK_VENCTO,EK_ENTRCLI,EK_LOJCLI})
		ElseIf       SEK->EK_TIPODOC=="PA"
			Aadd(aPaGer,{EK_NUM,EK_VALOR,Getmv("MV_MOEDAP"+STR(VAL(EK_MOEDA),1)),EK_VLMOED1})
		ENDIF
		SEK->(DbSkip())
	ENDDO
	//Acumular retenciones
   SFE->(DbSetOrder(2))
   SFE->(DBSEEK(xFILIAL("SFE")+cOrdPago))
   While !SFE->(EOF()).And.cOrdPago==SFE->FE_ORDPAGO
      If SFE->FE_RETENC > 0
         nPosRet  := Ascan(aRets,{|X| X[1]+X[3]==SFE->FE_NROCERT+SFE->FE_TIPO})
         If nPosRet ==  0
            Aadd(aRets,{SFE->FE_NROCERT,SFE->FE_RETENC,SFE->FE_TIPO})
         Else
            aRets[nPosRet][2]:=aRets[nPosRet][2]+SFE->FE_RETENC
         Endif
      Endif
      SFE->(DBSKIP())
   Enddo
	dbSelectArea("SA2")
	DbSetOrder(1)
	dbSeek( xFilial("SA2") + cFornece + cLoja )
	cNOME                :=      SA2->A2_NOME            // Nome
	cdIRE   :=      SA2->A2_END             // Endereco
	cMun                 := SA2->A2_Mun
	CcUIT           := SA2->A2_CGC
	cEst            := SA2->A2_EST
	cTipoFor := ""
	If SA2->A2_TIPO=="I"
		cTipoFor := OemToAnsi(STR0008)  // "Responsable Inscripto"
	ElseIf SA2->A2_TIPO=="N"
		cTipoFor := OemToAnsi(STR0009)  // "Responsable No Inscripto"
	ElseIf SA2->A2_TIPO=="X"
		cTipoFor := OemToAnsi(STR0010)  // "Exento"
	ElseIf SA2->A2_TIPO=="F"
		cTipoFor := OemToAnsi(STR0011)  // "Consumidor Final"
	ElseIf SA2->A2_TIPO=="D"
		cTipoFor := OemToAnsi(STR0012)  // "Exportacion"
	ElseIf SA2->A2_TIPO=="M"
		cTipoFor := OemToAnsi(STR0013)  // "Monotributista"
	EndIf

	Cabec085()

	If Len(aNfs) > 0
		@ 12,000 PSAY "|"
		@ 12,077 PSAY "|"
		@ 13,000 PSAY "| "+OemToAnsi(STR0014)  // "Orden de Pago de los siguientes Documentos."
		@ 13,077 PSAY "|"
		nLin:=14
        // "|-Serie-Numero-----------Valor Pagado---Moneda---Vencto------Valor en"
		@ nLin,000 PSAY OemToAnsi(STR0015)+alltrim(GETMV("MV_MOEDAP1"))+"|"
		//                                          0                     1                        2                3                     4                        5                        6        7                    8
		//                                        01234567890123456789012345678901234567890123456789012345678901234567890123456789
		For i:=1  to Len(aNfs)
			@nLin+i,000 PSAY "| "+ aNfs[i][1]
			@nLin+i,008 PSAY TransForm(aNfs[i][2],"@R 9999-99999999")
			@nLin+i,021 PSAY aNfs[i][6]     PICTURE TM(aNfs[i][6],16,2) //"@R 999,999,999.99"
			@nLin+i,040 PSAY aNfs[i][7]
			@nLin+i,047 PSAY aNfs[i][5]
			If aNfs[i][9]
				@nLin+i, 058 PSAY STR0044
			Else
				@nLin+i,058 PSAY aNfs[i][8]     PICTURE TM(aNfs[i][8],16,2) //"@R 999,999,999.99"
			Endif
			@nLin+i,077 PSAY "|"
		Next
		nLin:=nLin+i+1
		@nLin,000 PSAY "|"
		@nLin,077 PSAY "|"
		For i:=1  to Len(aRets)
			cTipoRet:=IIf(aRets[i][3]=="G",OemToAnsi(STR0016),Iif(aRets[i][3]=="B",OemToAnsi(STR0017),OemToAnsi(STR0018)))  //"Ganancias","Ing. Br.","I.V.A."
			@nLin+i,000 PSAY "| "+OemToAnsi(STR0019)+ cTipoRet + OemToAnsi(STR0020)   + aRets[i][1]  //"Emitido certificado de retencion de "," Nro "
			@nLin+i,058 PSAY (aRets[i][2] * - 1 )   PICTURE TM(aRets[i][2],16,2) //"@R 999,999,999.99"
			@nLin+i,077 PSAY "|"
		Next
		nLin:=nLin+i + 1
	Endif

	If len(aPaApl) > 0
		@ nLin,000 PSAY "|"
		@ nLin,077 PSAY "|"
		@ nLin+1,000 PSAY "| "+OemToAnsi(STR0021)  //"Descontados los siguientes Pagos adelantados : "
		@ nLin+1,077 PSAY "|"
		@ nLin+2,000 PSAY OemToAnsi(STR0022)+alltrim(GETMV("MV_MOEDAP1"))+"|" // "|-Numero------------------------Valor---Moneda---Emitido--------Valor Pesos--|"
		nLin    :=      nLin + 2
		For i:=1  to LEN(aPaApl)
			@nLin+i,000 PSAY "| "
			@nLin+i,003 PSAY PADR(aPaApl[i][1],12)
			@nLin+i,021 PSAY (aPaApl[i][2]* -1) PICTURE TM(aPaApl[i][2],16,2) //"@R 999,999,999.99"
			@nLin+i,040 PSAY aPaApl[i][3]
			@nLin+i,048 PSAY aPaApl[i][5]
			@nLin+i,058 PSAY (aPaApl[i][4]* -1) PICTURE TM(aPaApl[i][4],16,2) //"@R 999,999,999.99"
			@nLin+i,077 PSAY "|"
			nTotal		-= aPaApl[i][2]
			nTotmoed1	-= aPaApl[i][4]
			If nLin +i > 50
				Roda085()
				Cabec085()
				@ nLin,000 PSAY "|"
				@ nLin,077 PSAY "|"
				@ nLin+1,000 PSAY OemToAnsi(STR0023)  // "| Descontados los siguientes Pagos adelantados : "
				@ nLin+1,077 PSAY "|"
				@ nLin+2,000 PSAY OemToAnsi(STR0024)+alltrim(GETMV("MV_MOEDAP1"))+"|"
			EndIf
		Next
		nLin:=nLin+i + 1
	Endif
	If len(aChqPr) > 0
		@ nLin,000 PSAY "|"
		@ nLin,077 PSAY "|"
		@ nLin+1,000 PSAY "| "+OemToAnsi(STR0025)  // "En el siguiente detalle (Cheques-Efectivo-Transferencias)"
		@ nLin+1,077 PSAY "|"
		@ nLin+2,000 PSAY OemToAnsi(STR0026)  // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Fecha Dep-|"
		nLin    :=      nLin + 2
		For i:=1  to LEN(aChqPr)
			@nLin+i,000 PSAY "| "+aChqPr[i][1]
			@nLin+i,005 PSAY PADR(aChqPr[i][2],12)
			@nLin+i,017 PSAY aChqPr[i][3] PICTURE TM(aChqPr[i][3],16,2) //"@R 999,999,999.99"
			@nLin+i,034 PSAY aChqPr[i][4]
			@nLin+i,043 PSAY aChqPr[i][6]
			@nLin+i,048 PSAY aChqPr[i][7]
			@nLin+i,054 PSAY aChqPr[i][8]
			@nLin+i,067 PSAY aChqPr[i][9]
			@nLin+i,077 PSAY "|"
			If nLin +i > 50
				Roda085()
				Cabec085()
				@ nLin,000 PSAY "|"
				@ nLin,077 PSAY "|"
				@ nLin+1,000 PSAY "| "+OemToAnsi(STR0025)  // "En el siguiente detalle (Cheques-Efectivo-Transferencias)"
				@ nLin+1,077 PSAY "|"
				@ nLin+2,000 PSAY OemToAnsi(STR0026) // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Fecha Dep-|"
			EndIf
		Next
	Endif
	nLin:=nLin+i+1
	@ nLin,000 PSAY "|"
	@ nLin,077 PSAY "|"
	If nLin + Len(aChqTer) > 50
		Roda085()
		Cabec085()
	EndIf
	nLin    :=      nLin + 1
	If len(aChqTer) > 0
		@ nLin,000 PSAY "|"
		@ nLin,077 PSAY "|"
		@ nLin+1,000 PSAY "| "+OemToAnsi(STR0027) // "Cheques de Terceros entregados : "
		@ nLin+1,077 PSAY "|"
		@ nLin+2,000 PSAY OemToAnsi(STR0028)  // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Cliente-Sc|"
		nLin    :=      nLin + 2
		For i:=1  to LEN(aChqTer)
			@nLin+i,000 PSAY "| "+aChqTer[i][1]
			@nLin+i,005 PSAY PADR(aChqTer[i][2],12)
			@nLin+i,017 PSAY aChqTer[i][3] PICTURE TM(aChqTer[i][3],16,2) //"@R 999,999,999.99"
			@nLin+i,034 PSAY aChqTer[i][4]
			@nLin+i,043 PSAY aChqTer[i][6]
			@nLin+i,048 PSAY aChqTer[i][7]
			@nLin+i,054 PSAY aChqTer[i][8]
			@nLin+i,067 PSAY aChqTer[i][11]+"-"+aChqTer[i][12] //Cliente+Loja
			@nLin+i,077 PSAY "|"
			If nLin +i > 50
				Roda085()
				Cabec085()
				@ nLin,000 PSAY "|"
				@ nLin,077 PSAY "|"
				@ nLin+1,000 PSAY "| "+OemToAnsi(STR0027)  // "Cheques de Terceros entregados : "
				@ nLin+1,077 PSAY "|"
				@ nLin+2,000 PSAY OemToAnsi(STR0028)  // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Cliente-Sc|"
			EndIf
		Next
		nLin    :=      nLin + i + 1
	Endif
	@ nLin,000 PSAY "|"
	@ nLin,077 PSAY "|"
	nLin    :=      nLin + 1
	If Len(aPaGer) > 0
		@ nLin,000 PSAY OemToAnsi(STR0029)  // "| En concepto de Pago Anticipado de Titulos "
		@ nLin,077 PSAY "|"
		nLin    := nLin + 1
		@ nLin,000 PSAY OemToAnsi(STR0030)  // "|-Numero--------------------Valor-Moneda-------------------------------------|"
		For nA:=1  To Len(aPaGer)
			@nLin+Na,000 PSAY "| "+ aPaGer[nA][1]
			@nLin+nA,017 PSAY aPaGer[nA][2] PICTURE TM(aPaGer[nA][2],16,2) //"@R 999,999,999.99"
			@nLin+nA,034 PSAY aPaGer[nA][3]
			@nLin+nA,077 PSAY "|"
		Next
		nLin := nLin +Na+1
	Endif
	aTasas:={}
	For i:=1  To ContaMoeda()
		Aadd(aTasas,If(RecMoeda(dDtEmis,StrZero(i,1))==0,1,RecMoeda(dDtEmis,StrZero(i,1))))
	Next
	dDataMoedas := Dtoc(SM2->M2_DATA)
	For nX := nLin To 52
		@ nX, 000 PSAY "|"
		@ nX, 077 PSAY "|"
	Next nX
	@ 53,000 PSAY "|                                                ----------------------------|"
	@ 54,000 PSAY OemToAnsi(STR0031)+alltrim(GETMV("MV_MOEDAP1"))
	@ 54,060 psay Transform(nTotMoed1,"@R 999,999,999.99")
	@ 54,077 PSAY "|"
	@ 55,000 PSAY "|                                                ----------------------------|"
	@ 56,000 PSAY "|----------------------------------------------------------------------------|"
	IIf(!(cPaisloc$"POR|EUA"),xTasas(),.T.)
	EJECT
	DbSelectArea("SEK")
Enddo
Set Device To Screen

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณVERIMP    บAutor  ณMarcos Simidu       บFecha ณ  12/07/98   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica posicionamento de papel na Impressora              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR085                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function VerImp()

nLin:= 0                // Contador de Linhas
nLinIni:=0
If aReturn[5]==2

	nOpc       := 1
	While .T.

		SetPrc(0,0)
		dbCommitAll()

		@ nLin ,000 PSAY " "
		@ nLin ,004 PSAY "*"
		@ nLin ,022 PSAY "."
		IF MsgYesNo(OemToAnsi(STR0032))  //"Fomulario esta posicionado ? "
			nOpc := 1
		ElseIF MsgYesNo(OemToAnsi(STR0033))  //"Intenta Nuevamente ? "
			nOpc := 2
		Else
			nOpc := 3
		Endif
		Do Case
		Case nOpc==1
			lContinua:=.T.
			Exit
		Case nOpc==2
			Loop
		Case nOpc==3
			lContinua:=.F.
			Return
		EndCase
	End
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณCabec085  บAutor  ณJose Lucas          บFecha ณ  12/07/98   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCabecalho da Orden de Pago.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR085                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Cabec085()

SetPrc(0,0)                                             // (Zera o Formulario)
@ 01,000 PSAY "=============================================================================="
@ 02,000 PSAY "| " + SM0->M0_NOMECOM
@ 02,048 PSAY OemToAnsi(STR0038)+cOrdPago  //"ORDEN DE PAGO NRO: "
@ 02,077 PSAY "|"
@ 03,000 PSAY "| " + SM0->M0_ENDCOB
@ 03,077 PSAY "|"
@ 04,000 PSAY "| " + SM0->M0_CEPCOB + " - " + SM0->M0_CIDCOB
@ 04,048 PSAY OemToAnsi(STR0039) + DTOC(dDtEmis)  //"Fecha: "
@ 04,077 PSAY "|"
@ 05,000 PSAY "|"
@ 05,077 PSAY "|"
@ 06,000 PSAY "|"
@ 06,077 PSAY "|"
@ 07,000 PSAY OemToAnsi(STR0040)+cNome  //"| Beneficiario/a: "
@ 07,077 PSAY "|"
@ 08,000 PSAY "|"
@ 08,077 PSAY "|"
@ 09,000 PSAY OemToAnsi(STR0041) +cFornece  //"| Cuenta Nro: "
@ 09,077 PSAY "|"
@ 10,000 PSAY "|"
@ 10,077 PSAY "|"
@ 11,000 PSAY "=============================================================================="
//                         0         1         2         3         4         5         6         7        8
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789
nLin := 13
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRoda085   บAutor  ณBruno Sobieski      บFecha ณ  11/03/99   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPie de Pagina del Recibo.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR085                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Roda085()
Local nX := 0

For nX := nLin To 54
	@ nX, 000 PSAY "|"
	@ nX, 077 PSAY "|"
Next nX
@ 55,000 PSAY OemToAnsi(STR0042)  // "|                                                Continua....................|"
@ 56,000 PSAY "|----------------------------------------------------------------------------|"
IIf(!(cPaisloc$"POR|EUA"),xTasas(),.T.)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณxTasas    บAutor  ณBruno Sobieski      บFecha ณ  11/03/99   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime la tasa de las Monedas en uso en el pie de pagina.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR085                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function xTasas()
Local i := 0

@ 57,000 PSAY OemToAnsi(STR0043)+ dDataMoedas + " : "  //"|Tasas al "
For i:=2  to Len(aTasas)
	If i<4
		@ 57,((i-1)*22) PSAY GetMv("MV_MOEDAP"+STR(i,1)) +": " + Transform(aTasas[i],"@R 999.99999")
		@ 57,077 PSAY "|"
	Else
		If i==4
			@ 58,000 PSAY "|"
			@ 58,022 PSAY  Alltrim(GetMv("MV_MOEDAP"+STR(i,1)) )+": " + Transform(aTasas[i],"@R 999.99999")
		Elseif i==5
			@ 58,044 PSAY  GetMv("MV_MOEDAP"+STR(i,1)) +": " + Transform(aTasas[i],"@R 999.99999")
		Endif
		@ 58,077 PSAY "|"
	Endif
Next
REturn
