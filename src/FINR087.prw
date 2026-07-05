/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SIGAWIN.CH"
#INCLUDE "FINR087.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR087   ºAutor  ³Jeniffer Larrosa    ºFecha ³  07/12/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de impressao do Recibo de Cobranca                   º±±
±±º          ³Antigo RCBR010.prx                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Financeiro                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSergio F.     ³07/01/02³012384³Ajuste no Lay-out do relatorio          º±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Finr087()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tratamento para chamada do modulo SIGACTB(Relacionamentos-CTL)³
//³ atraves da rotina de Rastreamento de Lancamento(CTBC010).     ³
//³ Pelo cadastro de Relacionamento pode ser configurada a chamada³
//³ desta rotina, atraves do campo CTL_EXECUT, com a finalidade de³
//³ rastreamento dos lancamentos contabeis                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL lRastroCTB  := AllTrim(ProcName(1)) == "CTBRECIBO"
Local aArea:=GetArea()
Local aAreaSEL:=SEL->(GetArea())
Private nTamValor := TamSX3("EL_VALOR")[2]

// ------------------------------------------------------------------------------
// Dados Protegidos- Acesso Restrito: Este usuário não possui permissão de acesso 
// aos dados dessa rotina. Saiba mais em {link documentação centralizadora}"
If RetGlbLGPD('A1_NOME')
	Help(" ",1,"DADO_PROTEGIDO")
	RETURN 
ENDIF
// ------------------------------------------------------------------------------

SetPrvt("CBTXT,CBCONT,CUENTABANCO,CBANCO,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,AORD,TITULO")
SetPrvt("CDESC1,CDESC2,CDESC3,CNATUREZA,ARETURN,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,NTAMRM")
SetPrvt("CSTRING,CRCBO,NCNTRCBO,CCLIENTE,CLOJA,CRECIBO,CSERREC,CVERSAO")
SetPrvt("ACHQS,ANFS,ARAS,DDTEMIS,LDIFMOEDS,CMOEDANT")
SetPrvt("CRETORNO,CNOME,CDIRE,CNUMCLI,CMUN,CCUIT")
SetPrvt("CEST,CTIPO_CLI,NTOTAL,CMOEDA,I,AEXT")
SetPrvt("NTOTMOED1,NP,NA,NZ,NX,NLININI")
SetPrvt("NOPC,_SALIAS,AREGS,J,ATASAS,DDATAMOEDAS")
SetPrvt("NK,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros					     ³
//³ mv_par01				 // De Recibo                        ³
//³ mv_par02				 // Ate Recibo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CbTxt    := ""
CbCont   := ""
cDescMo  := GetMv("MV_MOEDA1")
nOrdem   := 0
Alfa     := 0
Z        := 0
M        := 0
tamanho	 := "M"
limite	 := 132
aOrd     := {}
titulo   := PADC(OemToAnsi(STR0001),74)  //"Impresion del Recibo de Cobro."
cDesc1   := PADC(OemToAnsi(STR0002),74)  //"Impresion de los Recibos de Cobro."
cDesc2   := ""
cDesc3   := ""
cNatureza:= ""
//"Especial","Administracion"
aReturn	 := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 1,1,"",1 }

nomeprog := "FINR087"
cPerg    := ""
nLastKey := 0
lContinua:= .T.
nLin     := 0
wnrel    := "FINR087"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do formulario 								         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTamRm   := 72     // Apenas Informativo

/*
 * Implementação de versionamento de recibos de cobrança (Argentina)
 */
If cPaisLoc $ "ARG"
		cPerg := "FIR087A"	
	Else
		cPerg := "FIR087"	
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas 							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.) 

cString  := "SEL"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,,,.F.)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica posicao do formulario na impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

VerImp()

RptStatus({|| RptDetail(lRastroCTB)})

SEL->(RestArea(aAreaSEL))
RestArea(aArea)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³Jeniffer Larrosa       ³ Data ³ 07.12.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao e selecao dos dados do Recibo                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaLoja                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail(lRastroCTB)

LOCAL lCancelado  := .F.
LOCAL cChave       := ""
Local nX 			:= 0
Local nA 			:= 0
Local nI 			:= 0
Local nValMulta 	:= 0
Local nValJuros 	:= 0
Local nDesconto 	:= 0
Local cMoeda		:= 0
Local nTaxa		:= 0
Local nloop 		:= 0 
Local cSerie		:= ""
Local lVersao		:= .F.
Local cVerDe		:= ""
Local cVerAte		:= ""
Local cChaveSEL	:= ""
Local cIndexSEL	:= ""
Local nIndexSEL 	:= 0
Local cCondicao	:= ""
Local nTamFil		:= TamSx3("EL_FILIAL")[1]
Local nTamRec    	:= TamSX3("EL_RECIBO")[1]
Local cPosReg := ""

If cPaisLoc == "ARG"	

	lVersao := .T.
	cSerie 	:= MV_PAR05
	cVerDe	:= MV_PAR03
	cVerAte	:= MV_PAR04

	//Posiciona SEL de acordo com o CV3->CV3_KEY para que imprima o registro posicionado na consulta (Rastreio)

	cPosReg := Alltrim(CV3->CV3_KEY)
	DbSelectArea("SEL")
	dbSetOrder(1)
	DbSeek(cPosReg)
	
Else
	cSerie:= MV_PAR03
EndIf

If lRastroCTB .And. !Empty(CTL->CTL_KEY)
	cChave    := &(CTL->CTL_KEY)
	mv_par01  := Substr(cChave,nTamFil+1,nTamRec)
	mv_par02  := Substr(cChave,nTamFil+1,nTamRec)
EndIf

If cPaisLoc $ "ARG" .AND. lVersao
 		cCondicao := ' EL_RECIBO >= "' +  mv_par01 + '" .AND. EL_RECIBO <= "' + mv_par02 + '" .AND. EL_FILIAL == "' + xFilial("SEL") + '"'
		cCondicao += ' .AND. EL_SERIE	==	"' + cSerie 	+'" 
	    cCondicao += ' .AND. EL_VERSAO 	>= 	"' + cVerDe 	+'" .AND. EL_VERSAO 	<=	"'	+ cVerAte 	+'" '
	cChaveSEL := "EL_FILIAL+EL_SERIE+EL_RECIBO+EL_VERSAO"
	IndRegua("SEL",cIndexSEL,cChaveSEL,,cCondicao,OemToAnsi(STR0007))  //"Selecionando Registros..."
	nIndexSEL := RetIndex("SEL")
	dbSetOrder(nIndexSEL+1)
	DbGoTop()
Else
	DbSelectArea("SEL")
	DbSetOrder(8)
	DbSeek(xFilial("SEL")+cSerie+mv_par01,.T.)
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa regua de impressao    							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cRcbo   := Mv_par01

xPict1  := PesqPict("SEL","EL_VALOR")

nCntRcbo	:=	0
SetRegua(Int(RecCount()/2))
While !Eof() .And. ( xFilial("SEL")==SEL->EL_FILIAL ) .And. SEL->EL_RECIBO <= mv_par02 .And. SEL->EL_SERIE == cSerie;
			 .And. lContinua .AND. Iif(lVersao,(SEL->EL_VERSAO >= cVerDe .AND. SEL->EL_VERSAO <= cVerAte),.T.)
	IncRegua()
	cCliente  := EL_CLIORIG
	cLoja     := EL_LOJORIG
	IF lAbortPrint
		@ 00,01 PSAY OemToAnsi(STR0005)  // "** CANCELADO PELO OPERADOR **"
		lContinua := .F.
		Exit
	Endif
	
	If SEL->EL_CANCEL
		If lRastroCTB
			lCancelado  := .T.
		Else
			SEL->(DbSkip())
			Loop
		EndIf
	EndIf
	cRecibo 	:= SEL->EL_RECIBO
	cSerREc	:= SEL->EL_SERIE
	cVersao	:= SEL->EL_VERSAO
	aCHQs    	:=	{}
	aNFs 	   	:=	{}
	aRas	   	:=	{}
	dDtEmis    := SEL->EL_DTDIGIT
	lDifMoeds  := .F.
	cMoedAnt   := SEL->EL_MOEDA
	Do while xFilial("SEL")==SEL->EL_FILIAL.And.cRECIBO==SEL->EL_RECIBO.And.cSerRec==SEL->EL_SERIE.and.!SEL->(eof());
		.AND. Iif(lVersao,(SEL->EL_VERSAO == cVersao),.T.)
		IncRegua()
		IF lAbortPrint
			@ 00,01 PSAY OemToAnsi(STR0005)  // "** CANCELADO PELO OPERADOR **"
			lContinua := .F.
			Exit
		Endif
		
		If SEL->EL_CANCEL
			If lRastroCTB
				lCancelado  := .T.
			Else
				SEL->(DbSkip())
				Loop
			EndIf
		EndIf
		
		If !(Alltrim(SEL->EL_TIPODOC)$"TB|RA")
			cRetorno :=""
			If Substr(EL_TIPODOC,1,2) == "CH"
				If SUBS(EL_BANCO,1,2)=="CX"
					cRetorno:=OemToAnsi(STR0006)  // "Cheque"
				Else
					cRetorno:=OemToAnsi(STR0007)  // "Efectivo"
				Endif
			Elseif Substr(EL_TIPODOC,1,2) == "TF"
				cRetorno:=OemToAnsi(STR0008)  // "Transfer"
			Elseif Substr(EL_TIPODOC,1,2) == "LT"
				cRetorno:=OemToAnsi(STR0009)  // "Letra"
			Elseif Substr(EL_TIPODOC,1,2) == "TJ"
				cRetorno:=OemToAnsi(STR0049)  // "Cartao de credito"
			Endif

			Aadd(aCHQs, {EL_TIPODOC,EL_NUMERO,EL_VALOR,Left(GetMV("MV_SIMB"+STR(VAL(EL_MOEDA),1)),4),EL_VLMOED1,;
			EL_BCOCHQ,EL_AGECHQ,EL_CTACHQ,EL_DTVCTO,EL_MOEDA})
			
			If EL_MOEDA#cMoedAnt .And. !lDifMoeds
				lDifMoeds:=	.T.
			Endif
		ElseIf 	Substr(SEL->EL_TIPODOC,1,2) == "TB"
			nValMulta := 0 
			nValJuros := 0
			nDesconto := 0
			SE5->(DbSetOrder(8))
			SE5->(DbSeek(xFilial("SE5")+ cRecibo) )
			While !EOF() .and. cRecibo ==  SE5->E5_ORDREC
				If	SE5->E5_PREFIXO == EL_PREFIXO .And. ;
					SE5->E5_NUMERO  == EL_NUMERO  .And. ;
					SE5->E5_PARCELA == EL_PARCELA .And. ;
					SE5->E5_TIPO    == EL_TIPO    .And. ;
					SE5->E5_CLIFOR  == EL_CLIORIG .And. ;
					SE5->E5_LOJA    == EL_LOJORIG
					If SE5->E5_TIPODOC == "MT"
						nValMulta := SE5->E5_VALOR
					ElseIf SE5->E5_TIPODOC == "JR"			
						nValJuros := SE5->E5_VALOR
					ElseIf SE5->E5_TIPODOC == "DC"			
						nDesconto := SE5->E5_VALOR
					EndIf
					cMoeda	:= SE5->E5_MOEDA
					nTaxa	:= SE5->E5_TXMOEDA   
				EndIf	
				SE5->(Dbskip())
			EndDo
			Aadd(aNFs,{EL_PREFIXO,StrZero(Val(EL_NUMERO),TamSX3("EL_NUMERO")[1]),EL_VALOR,Left(GetMV("MV_SIMB"+Str(Val(EL_MOEDA),1)),4),EL_DTVCTO,EL_VLMOED1,EL_MOEDA,EL_TIPO,nValMulta,nValJuros,nDesconto,cMoeda,nTaxa})
		ElseIf	Substr(SEL->EL_TIPODOC,1,2) == "RA"
			Aadd(aRas,{EL_NUMERO,EL_VALOR,Left(GetMV("MV_SIMB"+STR(VAL(EL_MOEDA),1)),4),EL_MOEDA})
		EndIf
		
		SEL->(DbSkip())
	EndDo
	dbSelectArea("SA1")
	dbSeek( xFilial("SA1") + cCliente + cLoja )
	cNome		:=	SA1->A1_NOME            // Nome
	cDire 	    :=	SA1->A1_END             // Endereco
	cNumCli 	:= SA1->A1_COD
	cMun 		:= SA1->A1_MUN
	cCUIT		:= SA1->A1_CGC
	If cPaisLoc == "COL"
		If Empty(cCuit)
			cCuit := SA1->A1_PFISICA
		Endif
	Endif
	cEst		:= SA1->A1_EST
	If cPaisLoc == "ARG"
		cTipo_Cli   := ""
		If SA1->A1_TIPO=="I"
			cTipo_Cli := OemToAnsi(STR0010)  //"Responsable Inscripto"
		ElseIf SA1->A1_TIPO=="N"
			cTipo_Cli := OemToAnsi(STR0011)  //"Responsable No Inscripto"
		ElseIf SA1->A1_TIPO=="X"
			cTipo_Cli := OemToAnsi(STR0012)  //"Exento"
		ElseIf SA1->A1_TIPO=="F"
			cTipo_Cli := OemToAnsi(STR0013)  //"Consumidor Final"
		ElseIf SA1->A1_TIPO=="D"
			cTipo_Cli := OemToAnsi(STR0014)  //"Exportacion"
		ElseIf SA1->A1_TIPO=="M"
			cTipo_Cli := OemToAnsi(STR0015)  //"Monotributista"
		ElseIf SA1->A1_TIPO=="A"
			cTipo_Cli := OemToAnsi(STR0016)  //"Afecto IVA"
		EndIf
	EndIf
	SetRegua(Int(RecCount()/2))
	nTotal  := 0.00
	
	If Len(aChqs) > 0
		For nI:= 1 to Len(aChqs)
			If lDifMoeds
				nTotal	:=	nTotal + aChqs[nI][5]
			Else
				nTotal	:= nTotal + aChqs[nI][3]
			EndIf
		Next 
		If lDifMoeds
			cExtenso := Extenso(nTotal,.F.,1)+" "
		Else
			cExtenso := Extenso(nTotal,.F.,Val(aChqs[1][10]))+" "
		EndIf
	ElseIf Len(aNFs) > 0
		//Caso nao tenham sido gerados documentos(cheques, transferencias etc.) atraves
		//do Recibo faz a soma pelos titulos a receber baixados
		For nI:= 1 to Len(aNFs)
			If !(aNFs[nI][8] $ MV_CRNEG+"|"+MVRECANT)
				nTotal	:=	nTotal + aNFs[nI][3]
			EndIf
		Next nI
		cExtenso := Extenso(nTotal,.F.,Val(aNFs[1][7]))+" "
	Endif
	aExt := {}
	nPosAnt  := 1
	nPosTot  := 0
	nCnt     := 0
	
	While .T.
		nloop++
		nTamLin := 72
		cExt  := SubStr(cExtenso,nPosAnt,nTamLin)
		If SubStr(cExtenso,(nPosAnt+nTamLin)-1,1)==" " .OR. SubStr(cExtenso,(nPosAnt+nTamLin),1)==" "
			nPosTot += Len(cExt)
			nPosAnt +=Len(cExt)
		Else
			nTamAnt := Len(cExt)
			nPosTot += Len(cExt)+1
			cExt    := SubStr(cExt,1,RAT(" ",cExt)-1)
			nPosAnt += Len(cExt)+1
			nDif    := nTamAnt-Len(cExt)
			For nI:= 1 to Len(cExt)
				If nCnt >= nDif
					Exit
				Endif
				If SubStr(cExt,nI,1) == " "
					cExt  := SubStr(cExt,1,nI)+" "+SubStr(cExt,nI+1,Len(cExt))
					nI++
					nCnt++
				EndIf
			Next 
		EndIf
		AADD(aExt,cExt)
		If nPosTot >= Len(cExtenso)
			Exit
		Endif
	EndDo
	While Len(aExt) < 3
		AADD(aExt,Space(72))
	EndDo
	If nloop > 1
		EJECT
	EndIf	
	Cabec087(lVersao)
	nTotMoed1	:=	0
	@ 17,000 PSAY "|"
	If lCancelado
		@ 17,030 PSAY OemToAnsi(STR0051)  //"*** DOCUMENTO CANCELADO ***"
	EndIf
	@ 17,084 PSAY "|"
	@ 18,000 PSAY "| "+OemToAnsi(STR0019)  //"No seguinte detalhe "
	If cPaisLoc <> "BRA"
		@ 18,041 PSAY OemToAnsi(STR0055) //  "--Banco del cheque----------" 
	Endif
	@ 18,084 PSAY "|"
	@ 19,000 PSAY OemToAnsi(STR0020)  // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Fecha Dep-|"
	nLin	:=19
	nP		:= 1
	If Len(aChqs) > 0
		For nA := 1  to Len(aChqs)
			IncRegua()
		    
	        @nLin+nP,000 PSAY "| "+aChqs[nA][1]  //Tipo Doc.
		   	@nLin+nP,005 PSAY PADR(aCHQS[nA][2],TamSX3("EL_NUMERO")[1])  //Numero do Doc.  

		    If cPaisloc $ "PTG|ANG|MEX"  
			    @nLin+nP,026 PSAY aCHQS[nA][3] PICTURE TM(aCHQS[nA][3],16,MsDecimais(Val(aCHQS[nA][10]))) //"@R 999,999,999.99"  //Valor do Doc.
				@nLin+nP,043 PSAY aCHQS[nA][4]  //Simbolo da moeda
				@nLin+nP,046 PSAY aCHQS[nA][6]  //Banco do cheque
				@nLin+nP,052 PSAY aCHQS[nA][7]  //Agencia do cheque
				@nLin+nP,058 PSAY aCHQS[nA][8]  //Conta do cheque
				@nLin+nP,074 PSAY aCHQS[nA][9]  //Data de vencto.
				@nLin+nP,084 PSAY "|"
			else
				@nLin+nP,018 PSAY aCHQS[nA][3] PICTURE TM(aCHQS[nA][3],16,MsDecimais(nTamValor)) //"@R 999,999,999.99"  //Valor do Doc.
				@nLin+nP,036 PSAY aCHQS[nA][4]  //Simbolo da moeda
				@nLin+nP,043 PSAY aCHQS[nA][6]  //Banco do cheque
				@nLin+nP,048 PSAY aCHQS[nA][7]  //Agencia do cheque
				@nLin+nP,055 PSAY aCHQS[nA][8]  //Conta do cheque
				@nLin+nP,070 PSAY aCHQS[nA][9]  //Data de vencto.
				@nLin+nP,084 PSAY "|"
			endif

			nTotMoed1  := nTotMoed1+aCHQS[nA][5]
			If nLin +nP > 50
				nLin	:=	nLin	+ nP
				Roda087()
				Cabec087(lVersao)
				@ 17,000 PSAY "|"
				@ 17,084 PSAY "|"
				@ 18,000 PSAY "| "+OemToAnsi(STR0019)  //"No seguinte detalhe "
				If cPaisLoc <> "BRA"
					@ 18,041 PSAY OemToAnsi(STR0055)  // "--Banco del cheque----------"
				Endif
				@ 18,084 PSAY "|"
				@ 19,000 PSAY OemToAnsi(STR0020)  // "|-VL-Numero-----------------Valor-Moneda---Bco--Suc.--Cuenta-------Fecha Dep-|"
				nP	:=	0
			EndIf
			nP	:=	nP+1
		Next nA
	Else
		@nLin+nP,000 PSAY "| "
		@nLin+nP,005 PSAY OemToAnsi(STR0050)  //"Nao houve recebimento de titulos"
		@nLin+nP,084 PSAY "|"
		nP++
	EndIf
	nLin  := nLin + nP
	@ nLin,000 PSAY "|"
	@ nLin,084 PSAY "|"
	If nLin  > 46
		Roda087()
		Cabec087(lVersao)
	EndIf
	nLin	:=	nLin + 1
	nZ 	    := 1
	If Len(aRas) > 0
		@ nLin,000 PSAY "| "+OemToAnsi(STR0021)  // "En concepto de Recibo Anticipado de Titulos "
		@ nLin,084 PSAY "|"
		nLin	:= nLin + 1
		@ nLin,000 PSAY OemToAnsi(STR0022)  // "|-Numero--------------------Valor-Moneda-------------------------------------|"
		For nA:=1  To Len(aRas)                 
			IncRegua()
			@nLin+nZ,000 PSAY "| "+ aRas[nA][1]
			If cPaisLoc $ "PTG|ANG|MEX"  
				@nLin+nZ,023 PSAY aRas[nA][2] PICTURE TM(aRas[nA][2],16,MsDecimais(Val(aRas[nA][4]))) //"@R 999,999,999.99"
				@nLin+nZ,044 PSAY aRas[nA][3]
			Else
				@nLin+nZ,018 PSAY aRas[nA][2] PICTURE TM(aRas[nA][2],16,MsDecimais(Val(aRas[nA][4]))) //"@R 999,999,999.99"
				@nLin+nZ,036 PSAY aRas[nA][3]
			EndIf	
			@nLin+nZ,084 PSAY "|"
			If nLin + nZ > 50
				nLin	:=	nLin	+  nZ + 1
				Roda087()
				Cabec087(lVersao)
				@ nLin,000 PSAY "| "+OemToAnsi(STR0021) // "En concepto de Pago Anticipado de Titulos "
				@ nLin,084 PSAY "|"
				nLin	:= nLin + 1
				@ nLin,000 PSAY OemToAnsi(STR0022)  // "|-Numero--------------------Valor-Moneda-------------------------------------|"
				nZ	:= 0
			Endif
			nZ	:=	nZ	+ 1
		Next nA
		nLin := nLin + nZ
	Endif
	If Len(aNfs) > 0
		@ nLin,000 PSAY "|"
		@ nLin,084 PSAY "|"
		nLin := nLin + 1
		If nLin > 47
			Roda087()
			Cabec087(lVersao)
		EndIf
		@ nLin,000 PSAY "| "+OemToAnsi(STR0023) //"En concepto de Pago de los siguientes Titulos : "
		@ nLin,084 PSAY "|"
		nLin	:=	nLin	+	1
		//					  0			1			 2	   	  3			4			 5			  6   	   7			8
		//01234567890123456789012345678901234567890123456789012345678901234567890123456789
		@ nLin,000 PSAY OemToAnsi(STR0024)+ " " + Left(GetMv('MV_SIMB1'),4)  // "|-Serie-Numero-----------Valor Cobrado--Moneda---Vencto------Valor en "
		@ nLin,084 PSAY "|"
		nP	:=	1
		For nA:=1  to Len(aNfs)                                         //6        7         8
			@nLin+nP,000 PSAY "| "+ aNfs[nA][1]  //Serie
			@nLin+nP,008 PSAY TransForm(aNfs[nA][2],PesqPict("SEL","EL_NUMERO"))  //Numero do Doc.
			If cPaisLoc $ "PTG|ANG|MEX"
			  	@nLin+nP,028 PSAY IIf(AllTrim(aNfs[nA][8])$ mv_crneg+"|"+mvrecant,aNfs[nA][3]*-1,aNfs[nA][3]) PICTURE TM(aNfs[nA][3],16,MsDecimais(nTamValor)) //"@R 99,999,999,999"  //Valor do Doc.
				@nLin+nP,046 PSAY aNfs[nA][4]  //Simbolo da moeda
				@nLin+nP,052 PSAY aNfs[nA][5]  //Data vencto.
			  	@nLin+nP,062 PSAY IIf(AllTrim(aNfs[nA][8])$ mv_crneg+"|"+mvrecant,aNfs[nA][6]*-1,aNfs[nA][6]) PICTURE TM(aNfs[nA][6],21,MsDecimais(nTamValor)) //"@R 999,999,999.99"  //Valor na moeda 1
			Else
			  	@nLin+nP,021 PSAY IIf(AllTrim(aNfs[nA][8])$ mv_crneg+"|"+mvrecant,aNfs[nA][3]*-1,aNfs[nA][3]) PICTURE TM(aNfs[nA][3],21,MsDecimais(nTamValor)) //"@R 99,999,999,999"  //Valor do Doc.
				@nLin+nP,044 PSAY aNfs[nA][4]  //Simbolo da moeda
				@nLin+nP,052 PSAY aNfs[nA][5]  //Data vencto.
			  	@nLin+nP,062 PSAY IIf(AllTrim(aNfs[nA][8])$ mv_crneg+"|"+mvrecant,aNfs[nA][6]*-1,aNfs[nA][6]) PICTURE TM(aNfs[nA][6],21,MsDecimais(nTamValor)) //"@R 999,999,999.99"  //Valor na moeda 1
			EndIf	
			@nLin+nP,084 PSAY "|" 
		    If (aNfs[nA][9] >0 .or. aNfs[nA][10]>0 .or. aNfs[nA][11]>0 ) .and. nLin + 4 > 50
				nLin	:=	nLin	+ nP + 1
				Roda087()
				Cabec087(lVersao)
				@ nLin,000 PSAY "| "+OemToAnsi(STR0023)  // "En concepto de Pago de los siguientes Titulos : "
				@ nLin,084 PSAY "|"
				nLin	:=	nLin	+	1
				@ nLin,000 PSAY OemToAnsi(STR0024)+ Left(GetMv('MV_SIMB1'),4)  // "|-Serie-Numero-----------Valor Cobrado--Moneda---Vencto------Valor en "
				@ nLin,084 PSAY "|"
				nP	:=	0
			Endif
					 	
		 	If aNfs[nA][9] > 0
				nLin:=nLin+1
				
		 		@nLin+nP,000 PSAY "|"
		 		@nLin+nP,002 PSAY OemToAnsi(STR0052)//("-----  Multa...:(+)")
		 		
				If cPaisLoc $ "PTG|ANG|MEX"  
			 		@nLin+nP,023 PSAY aNfs[nA][9] PICTURE TM(aNfs[nA][9],21,MsDecimais(Val(aNfs[nA][7]))) //"@R 999,999,999.99"  //Valor na moeda 1
					@nLin+nP,046 PSAY Left(GetMV("MV_SIMB"+Alltrim(STR(Val(aNfs[nA][12])))),4) //Simbolo da moeda
					@nLin+nP,062 PSAY xMoeda(aNfs[nA][9],Val(aNfs[nA][12]),1,,,aNfs[nA][13]) PICTURE TM(aNfs[nA][11],21,MsDecimais(Val(aNfs[nA][7])))
				Else
			 		@nLin+nP,021 PSAY aNfs[nA][9] PICTURE TM(aNfs[nA][9],21,MsDecimais(Val(aNfs[nA][7]))) //"@R 999,999,999.99"  //Valor na moeda 1
					@nLin+nP,044 PSAY Left(GetMV("MV_SIMB"+Alltrim(STR(Val(aNfs[nA][12])))),4) //Simbolo da moeda
					@nLin+nP,060 PSAY xMoeda(aNfs[nA][9],Val(aNfs[nA][12]),1,,,aNfs[nA][13]) PICTURE TM(aNfs[nA][11],21,MsDecimais(Val(aNfs[nA][7])))
				EndIf	
		 		
		 		@nLin+nP,084 PSAY "|"
			EndIf
		 
		 	If aNfs[nA][10] > 0
	 			nLin:=nLin+1
	 			@nLin+nP,000 PSAY "|"
		 		@nLin+nP,002 PSAY OemToAnsi(STR0053)//("-----  Juros...:(+)") 
		 		@nLin+nP,021 PSAY aNfs[nA][10] PICTURE TM(aNfs[nA][10],21,MsDecimais(Val(aNfs[nA][7]))) //"@R 999,999,999.99"  //Valor na moeda 1
				@nLin+nP,044 PSAY Left(GetMV("MV_SIMB"+Alltrim(STR(Val(aNfs[nA][12])))),4) //Simbolo da moeda
				@nLin+nP,060 PSAY xMoeda(aNfs[nA][10],Val(aNfs[nA][12]),1,,,aNfs[nA][13]) PICTURE TM(aNfs[nA][11],21,MsDecimais(Val(aNfs[nA][7])))
		 		@nLin+nP,084 PSAY "|"
		 	EndIf
		 
		 	If aNfs[nA][11] > 0
 				nLin:=nLin+1
 				@nLin+nP,000 PSAY "|"
		 		@nLin+nP,002 PSAY OemToAnsi(STR0054) //("-----  Desconto:(-)")
		 		@nLin+nP,021 PSAY aNfs[nA][11] PICTURE TM(aNfs[nA][11],21,MsDecimais(Val(aNfs[nA][7]))) //"@R 999,999,999.99"  //Valor na moeda 1
				@nLin+nP,044 PSAY Left(GetMV("MV_SIMB"+Alltrim(STR(Val(aNfs[nA][12])))),4) //Simbolo da moeda
				@nLin+nP,060 PSAY xMoeda(aNfs[nA][11],Val(aNfs[nA][12]),1,,,aNfs[nA][13]) PICTURE TM(aNfs[nA][11],21,MsDecimais(Val(aNfs[nA][7])))
		 		@nLin+nP,084 PSAY "|"
		 	EndIf  
			
			If (aNfs[nA][9] >0 .or. aNfs[nA][10]>0 .or. aNfs[nA][11]>0 )
				nLin := nLin + 1
				@nLin+nP,000 PSAY "|"
				@nLin+nP,084 PSAY "|"
			EndIf

			If nLin + nP > 50
				nLin	:=	nLin	+ nP + 1
				Roda087()
				nLin := 0
				@ nLin,000 PSAY Chr(27)+ Chr(03)+ Chr(02)	
				Cabec087(lVersao)
				@ nLin,000 PSAY "| "+OemToAnsi(STR0023)  // "En concepto de Pago de los siguientes Titulos : "
				@ nLin,084 PSAY "|"
				nLin	:=	nLin	+	1
				@ nLin,000 PSAY OemToAnsi(STR0024)+ Left(GetMv('MV_SIMB1'),4)  // "|-Serie-Numero-----------Valor Cobrado--Moneda---Vencto------Valor en "
				@ nLin,084 PSAY "|"
				nP	:=	0
			Endif
			nP	:=	nP	+ 1
		Next nA
		nLin  := nLin+nP
	Endif
	For nX := nLin To 51
		IncRegua()
		@ nX, 000 PSAY "|"
		@ nX, 084 PSAY "|"
	Next nX
	@ 52,000 PSAY "|                                                     ------------------------------|"
	If lDifMoeds
		@ 53,000 PSAY OemToAnsi(STR0025)+ Left(GetMv('MV_SIMB1'),4)
		@ 53,054 PSAY "|"+Transform(nTotMoed1,xPict1)		// "Total en "
	ElseIf Len(aChqs) > 0
		@ 53,000 PSAY OemToAnsi(STR0025)+ aChqs[1][4]
		@ 53,054 PSAY "|"+Transform(nTotal,TM(nTotal,21,MsDecimais(nTamValor)))		// "Total en "
	ElseIf Len(aNFs) > 0
		@ 53,000 PSAY OemToAnsi(STR0025)+ aNFs[1][4]   // "Total em "
		@ 53,054 PSAY "|"+Transform(nTotal,TM(nTotal,21,MsDecimais(Val(aNFs[1][7]))))
	Endif
	@ 53,084 PSAY "|"
	@ 54,000 PSAY "|                                                     ------------------------------|"
	@ 55,000 PSAY "|-----------------------------------------------------------------------------------|"
	If cPaisLoc == "COL"
		If GetNewPar("MV_IMPTX","N") == "S"
			xTasas()
		Else
			Eject // Nao retirar Eject - Estouro de Retorio
		Endif
	Else
		xTasas()
	Endif
	nCntRcbo	:=	0
	DbSelectArea("SEL")    
	If lVersao
		dbSetOrder(nIndexSEL+1)
	Else	
		DbSetorder(8)
	Endif	
EndDo
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³VERIMP    ºAutor  ³Marcos Simidu       ºFecha ³  12/07/98   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica posicionamento de papel na Impressora              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR087                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
		IF MsgYesNo(OemToAnsi(STR0026))  //"Fomulario esta posicionado ? "
			nOpc := 1
		ElseIF MsgYesNo(OemToAnsi(STR0027))  //"Intenta Nuevamente ? "
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Cabec087  ºAutor  ³Bruno Sobieski      ºFecha ³  11/03/99   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Encabezado del Recibo.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR087                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Cabec087(lVersao)

Local cRetCGC  := RTrim(RetTitle("M0_CGC"))  //Retorna o titulo do campo
Local cRetCli  := RTrim(RetTitle("A1_CGC"))  //Retorna o titulo do campo

nCntRcbo	:=	nCntRcbo	+ 1
SetPrc(0,0)     		                        // (Zera o Formulario)
@ 01,000 PSAY "====================================================================================="
@ 02,000 PSAY "| "+AllTrim(SM0->M0_NOMECOM)
@ 02,048 PSAY OemToAnsi(STR0030)+IIf(Empty(cSerRec),'    ',cSerRec+"-")+cRecibo + "/" + Str(nCntRcbo,2) + " Rev. " + cVersao //"Recibo Nro: "
@ 02,084 PSAY "|"
@ 03,000 PSAY "| "+AllTrim(SM0->M0_ENDENT)
@ 03,062 PSAY cRetCGC + " " + TransForm(SM0->M0_CGC,PesqPict("SM0","M0_CGC"))  //"CGC,RUT,RUC,CUIT..."
@ 03,084 PSAY "|"
@ 04,000 PSAY "| "+AllTrim(SM0->M0_CEPENT)+" - "+AllTrim(SM0->M0_CIDENT)+" - "+AllTrim(SM0->M0_ESTENT)
@ 04,048 PSAY OemToAnsi(STR0035) + DTOC(dDtEmis) //"Fecha: "
@ 04,084 PSAY "|"
@ 05,000 PSAY OemToAnsi(STR0036) + AllTrim(SM0->M0_TEL) + OemToAnsi(STR0037)+ AllTrim(SM0->M0_FAX)  //"| Telefono : ","     FAX : "
@ 05,084 PSAY "|"
@ 06,000 PSAY "|"
@ 06,084 PSAY "|"

@ 07,000 PSAY "|-----------------------------------------------------------------------------------|"
@ 08,000 PSAY "|"
@ 08,084 PSAY "|"
@ 09,000 PSAY OemToAnsi(STR0038)+Subs(cNome,1,28)  //"| Recibimos de los Senores: "
@ 09,058 PSAY OemToAnsi(STR0039) + cCliente+"-"+cLoja  //"Cliente : "
@ 09,084 PSAY "|"
@ 10,000 PSAY OemToAnsi(STR0040)+ cDire  //"| Direccion: "
@ 10,084 PSAY "|"
@ 11,000 PSAY OemToAnsi(STR0041)+ cMun  //"| Localidad: "
@ 11,084 PSAY "|"
If cPaisLoc == "ARG"
	@ 12,000 PSAY OemToAnsi(STR0042)+ cTipo_Cli  //"| I.V.A. : "
Else
	@ 12,000 PSAY "|"
Endif
@ 12,045 PSAY cRetCli + " " + Transform(cCUIT,PesqPict("SA1","A1_CGC"))  //"CGC,RUT,CUIT,RUC..."

@ 12,084 PSAY "|"
@ 13,000 PSAY "| " + aExt[1]
@ 13,084 PSAY "|"
@ 14,000 PSAY "| " + aExt[2]
@ 14,084 PSAY "|"
@ 15,000 PSAY "| " + aExt[3]
@ 15,084 PSAY "|"
@ 16,000 PSAY "|-----------------------------------------------------------------------------------|"
nLin := 17
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Roda087   ºAutor  ³Bruno Sobieski      ºFecha ³  11/03/99   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Pie de Pagina del Recibo                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR087                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Roda087()

LOCAL nX := 0

For nX := nLin To 53
	@ nX, 000 PSAY "|"
	@ nX, 084 PSAY "|"
Next nX
@ 54,000 PSAY OemToAnsi(STR0043)  // "|                                                Continua....................|"
@ 55,000 PSAY "|-----------------------------------------------------------------------------------|"
If cPaisLoc == "COL"
	If GetNewPar("MV_IMPTX","N") == "S"
		xTasas()
	Else
		Eject // Nao retirar Eject - Estouro de Relatorio
	Endif
Else
	xTasas()
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³xTasas    ºAutor  ³Bruno Sobieski      ºFecha ³  11/03/99   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime la tasa de las Monedas en uso en el pie de pagina   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR087                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function xTasas()

Local cSimb
Local aTasas	:=	{}
Local nK := 0

For nK:=1  To ContaMoeda()
	Aadd(aTasas,If(RecMoeda(dDtEmis,StrZero(nK,1))==0,1,RecMoeda(dDtEmis,StrZero(nK,1))))
Next
dDataMoedas := Dtoc(SM2->M2_DATA)

@ 56,000 PSAY OemToAnsi(STR0044)+ dDataMoedas + " : "  // "|Tasas al "
For nK:=2  to Len(aTasas)
	cSimb := PADL(GetMv("MV_SIMB"+STR(nK,1)),4)
	If nK<4
		If nK==2
			@ 56,022 PSAY cSimb +": " + Transform(aTasas[nK],TM(aTasas[nK],11,MsDecimais(nK)))
		ElseIf nK==3
			@ 56,050 PSAY cSimb +": " + Transform(aTasas[nK],TM(aTasas[nK],11,MsDecimais(nK)))
		Endif
	Else
		If nK==4
			@ 56,084 PSAY "|"
			@ 57,000 PSAY "|"
			@ 57,022 PSAY  cSimb +": " + Transform(aTasas[nK],TM(aTasas[nK],11,MsDecimais(nK)))
		Elseif nK==5
			@ 57,050 PSAY  cSimb +": " + Transform(aTasas[nK],TM(aTasas[nK],11,MsDecimais(nK)))
		Endif
	Endif
Next
@ PRow()  ,083 PSAY "|"
@ PRow()+1,000 PSAY Replicate("=",84)

Return
