/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR190.ch" 
#Include "Protheus.ch"

Static lFWCodFil := .T.
Static lUnidNeg := Iif( lFWCodFil, FWSizeFilial() > 2, .F. ) //Indica se usa Gestao Corporativa
Static _oFINR199

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR199   ºAutor  ³Adrianne Furtado    º Data ³  11/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime o relatorio de baixas quando escolhida a ordem por º±±
±±º          ³ por natureza no FINR190, devido a implementacao de         º±±
±±º          ³ multiplas naturezas por baixa de titulos                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR190                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Finr199(nGerOrig	,nGerValor	,nGerDesc	,nGerJurMul	,nGerCM		,nGerAbLiq,;
			     nGerAbImp	,nGerBaixado,nGerMovFin	,nGerComp	,nFilOrig	,nFilValor,;
			     nFilDesc	,nFilJurMul	,nFilCM		,nFilAbLiq	,nFilAbImp	,nFilBaixado,;
			     nFilMovFin	,nFilComp	,lEnd		,cCondicao	,cCond2		,aColu,;
			     lContinua	,cFilSE5	,lAsTop		,tamanho	,aRet		,aTotais, nOrdem, nGerFat, nFilFat,lNovaGestao)

Local aAreaSm0	:= SM0->(GetArea())
Local aAreaSe5	:= SE5->(GetArea())
Local aStru		:= SE5->(DbStruct())
Local aSaldo	:= {}
Local nValNat
Local nVBxNat
Local nJurNat
Local nAbtNat
Local nAbImpNat
Local nMulNat
Local nCmoNat
Local nDesNat
Local nValor	  	:= 0
Local nDesc		  	:= 0
Local nJuros	  	:= 0
Local nAbat 	  	:= 0
Local nCM		  	:= 0
Local nMulta	  	:= 0
Local nVlr 		  	:= 0
Local nVlMovFin  	:= 0
Local cArqTmp		:= GetNextAlias()
Local nTotOrig   	:= 0
Local nTotValor  	:= 0
Local nTotDesc   	:= 0
Local nTotJurMul 	:= 0
Local nTotCm 	  	:= 0
Local nTotMulta  	:= 0
Local nTotAbat   	:= 0
Local nTotImp 	  	:= 0
Local nTotBaixado 	:= 0
Local nTotMovFin  	:= 0
Local nTotComp    	:= 0
Local nTotFat    	:= 0
Local nTotAbImp   	:= 0
Local cAnterior
Local cCliFor190  	:= ""
Local cCliFor
Local nDecs	  	   	:= GetMv("MV_CENT"+(IIF(mv_par12 > 1 , STR(mv_par12,1),"")))
Local nMoedaBco   	:= 1
Local cCarteira
Local lManual 	   	:=.F.
Local cBanco
Local cNatureza
Local nCT		   	:= 0
Local dDigit
Local cLoja
Local lBxTit	   	:=.F.
Local cHistorico
Local nRecSe5 	   	:= 0
Local dDtMovFin
Local cRecPag
Local cMotBaixa   	:= CRIAVAR("E5_MOTBX")
Local cFilTrb
Local cChave
Local cFilOrig
Local nX 		:= 0
Local nY 		:= 0
Local lTemTit	:=.T.
Local nTamEH    := TamSx3("EH_NUMERO")[1]
Local nTamEI    := TamSx3("EI_NUMERO")[1]+TamSx3("EI_REVISAO")[1]+TamSx3("EI_SEQ")[1]
Local lFilSit	:= !Empty(MV_PAR15)
Local aImpresso := {}
Local nAscan
Local nRecno
Local nSavOrd
Local lAchou
Local nTamRet	:= 0
Local lPCCBaixa := SuperGetMv("MV_BX10925",.T.,"2") == "1"

Local lUltBaixa := .F.
Local cChaveSE1 := ""
Local cChaveSE5 := ""
Local cSeqSE5	:= ""

//Controla o Pis Cofins e Csll na baixa (1-Retem PCC na Baixa ou 2-Retem PCC na Emissão(default))
Local lPccBxCr	:= FPccBxCr()
Local nPccBxCr	:= 0
Local nPccBxNat := 0
Local cNatur199	:= ""
Local cCodUlt	:= SM0->M0_CODIGO
Local cFilUlt	:= IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
Local cEmpresa	:= IIF(lUnidNeg,FWCodEmp(),"")
Local nAbatLiq  := 0
/* GESTAO - inicio */
Default lNovaGestao := .F.
/* GESTAO - fim */
//Campos adicionais para o arquivo temporario
//E5_VALTIT = Valor do titulo
//E5_VLABLIQ = Valor dos abatimentos
//E5_VLABIMP = Valos dos abatimentos de impostos
AADD(aStru,{"E5_VALTIT","N",17,2})
AADD(aStru,{"E5_VLMOVFI","N",17,2})
AADD(aStru,{"E5_VLABLIQ","N",17,2})
AADD(aStru,{"E5_VLABIMP","N",17,2})

If(_oFINR199 <> NIL)

	_oFINR199:Delete()
	_oFINR199 := NIL

EndIf

_oFINR199 := FwTemporaryTable():New(cArqTmp)
_oFINR199:SetFields(aStru)

If FunName() == "FINR190"
	//Retirando o DTOS  da chave 
	cChaveInterFun := StrTran(StrTran(Upper(cChaveInterFun),"DTOS(",""),")","") 
	_oFINR199:AddIndex("1", Strtokarr2(cChaveInterFun, "+"))
Else	
	_oFINR199:AddIndex("1",{"E5_FILIAL","E5_NATUREZ","E5_PREFIXO","E5_NUMERO","E5_PARCELA","E5_TIPO","E5_CLIFOR","E5_LOJA"})
Endif

_oFINR199:Create()

DbSelectArea("SEH")
DbSelectArea("SEI")
DbSelectArea("NEWSE5")
cE5Filial := NEWSE5->E5_FILIAL

While NEWSE5->(!Eof()) .And. NEWSE5->E5_FILIAL==xFilial("SE5") .And. &cCondicao .and. lContinua

	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )

	If NEWSE5->E5_FILIAL<>xFilial("SE5")
		NEWSE5->(dbSkip())		      // filtro de registros desnecessarios
		Loop
	Endif

	DbSelectArea("NEWSE5")
	// Testa condicoes de filtro
	If !Fr190TstCond(cFilSe5)
		NEWSE5->(dbSkip())		      // filtro de registros desnecessarios
		Loop
	Endif

	If lUnidNeg .and. (cEmpresa	<> FWCodEmp())
		SM0->(DbSkip())
		Loop
	Endif

	If (NEWSE5->E5_RECPAG == "R" .and. ! (NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG )) .or. ;	//Titulo normal
		(NEWSE5->E5_RECPAG == "P" .and.   (NEWSE5->E5_TIPO $ "RA /"+MV_CRNEG )) 	//Adiantamento
		cCarteira := "R"
	Else
		cCarteira := "P"
	Endif

	dbSelectArea("NEWSE5")
	cAnterior 	:= &cCond2
	nTotValor	:= 0
	nTotDesc	:= 0
	nTotJurMul	:= 0
	nTotMulta	:= 0
	nTotCM		:= 0
	nCT			:= 0
	nTotOrig	:= 0
	nTotBaixado	:= 0
	nTotAbat  	:= 0
	nTotImp  	:= 0
	nTotMovFin	:= 0
	nTotComp	:= 0
	nTotFat		:= 0

	While NEWSE5->(!EOF()) .and. &cCond2=cAnterior .and. NEWSE5->E5_FILIAL=xFilial("SE5") .and. lContinua

		lManual := .f.
		lTemTit:=.T.
		dbSelectArea("NEWSE5")

		If (Empty(NEWSE5->E5_TIPODOC) .And. mv_par16 == 1) .Or.;
			(Empty(NEWSE5->E5_NUMERO)  .And. mv_par16 == 1)
			lManual := .t.
		EndIf

		// Testa condicoes de filtro
		If !Fr190TstCond(cFilSe5)
			dbSelectArea("NEWSE5")
			NEWSE5->(dbSkip())		      // filtro de registros desnecessarios
			Loop
		Endif


		// testa mv_par37 (Imp. mov. cheque aglutinado?Cheque/Baixa/Ambos)
		If ((mv_par37 == 1) .And. ;
		   ((NEWSE5->E5_TIPODOC == "VL") .Or. (NEWSE5->E5_TIPODOC == "BA"))) //somente cheques

			nRecno  := SE5->(Recno())
			nSavOrd := SE5->(INDEXORD())

			SE5->(dbSetOrder(11))
			SE5->(MsSeek(xFilial("SE5")+NEWSE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)))
			cChave := SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)
			lAchou := .F.

			// Procura o cheque aglutinado, se encontrar despreza o movimento bancario
			WHILE SE5->(!EOF()) .And. SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)	== cChave
				If SE5->E5_TIPODOC == "CH"
					lAchou := .T.
					Exit
				Endif
				SE5->(dbSkip())
			Enddo

			SE5->(DbSetOrder(nSavOrd))
			SE5->(dbGoTo(nRecno))
			// Achou cheque aglutinado para a baixa, despreza o registro
			If lAchou
				NEWSE5->(dbSkip())
				Loop
			Endif

		ElseIf ((mv_par37 == 2) .And. (NEWSE5->E5_TIPODOC == "CH")) //somente baixas

			nRecno  := SE5->(Recno())
			nSavOrd := SE5->(INDEXORD())

			SE5->(dbSetOrder(11))
			SE5->(MsSeek(xFilial("SE5")+NEWSE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)))
			cChave := SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)
			lAchou := .F.

			// Procura a baixa aglutinada, se encontrar despreza o movimento bancario
			WHILE SE5->(!EOF()) .And. SE5->(E5_BANCO+E5_AGENCIA+E5_CONTA+E5_NUMCHEQ)	== cChave
				If SE5->E5_TIPODOC $ "BA#VL"
					lAchou := .T.
					Exit
				Endif
				SE5->(dbSkip())
			Enddo

			SE5->(DbSetOrder(nSavOrd))
			SE5->(dbGoTo(nRecno))
			// Achou cheque aglutinado para a baixa, despreza o registro

			If lAchou
				NEWSE5->(dbSkip())
				Loop
			Endif
		Endif

		cNumero    	:= NEWSE5->E5_NUMERO
		cPrefixo   	:= NEWSE5->E5_PREFIXO
		cParcela   	:= NEWSE5->E5_PARCELA
		dBaixa     	:= NEWSE5->E5_DATA
		cBanco     	:= NEWSE5->E5_BANCO
		cNatureza  	:= NEWSE5->E5_NATUREZ
		cCliFor    	:= NEWSE5->E5_BENEF
		cLoja      	:= NEWSE5->E5_LOJA
		cSeq       	:= NEWSE5->E5_SEQ
		cNumCheq   	:= NEWSE5->E5_NUMCHEQ
		cRecPag	 	:= NEWSE5->E5_RECPAG
		cMotBaixa	:= NEWSE5->E5_MOTBX
		cCheque    	:= NEWSE5->E5_NUMCHEQ
		cTipo      	:= NEWSE5->E5_TIPO
		cFornece   	:= NEWSE5->E5_CLIFOR
		cLoja      	:= NEWSE5->E5_LOJA
		dDigit     	:= NEWSE5->E5_DTDIGIT
		lBxTit	  	:= .F.
		cFilorig    := NEWSE5->E5_FILORIG

		If (NEWSE5->E5_RECPAG == "R" .and. ! (NEWSE5->E5_TIPO $ "PA /"+MV_CPNEG )) .or. ;	//Titulo normal
			(NEWSE5->E5_RECPAG == "P" .and.   (NEWSE5->E5_TIPO $ "RA /"+MV_CRNEG )) 	//Adiantamento
			dbSelectArea("SE1")
			dbSetOrder(1)
			lBxTit := MsSeek(cFilial+cPrefixo+cNumero+cParcela+cTipo)
			If !lBxTit
				lBxTit := dbSeek(NEWSE5->E5_FILORIG+cPrefixo+cNumero+cParcela+cTipo)
			Endif
			cCarteira := "R"
			dDtMovFin := IIF (lManual,CTOD("//"), DataValida(SE1->E1_VENCTO,.T.))
			While SE1->(!Eof()) .and. SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO==cPrefixo+cNumero+cParcela+cTipo
				If SE1->E1_CLIENTE == cFornece .And. SE1->E1_LOJA == cLoja	// Cliente igual, Ok
					Exit
				Endif
				SE1->( dbSkip() )
			EndDo
			If !SE1->(EOF()) .And. mv_par11 == 1 .and. !lManual .and.  ;
				(NEWSE5->E5_RECPAG == "R" .and. !(NEWSE5->E5_TIPO $ MVPAGANT+"/"+MV_CPNEG))
				
				If lFilSit .And. !Empty(NEWSE5->E5_SITCOB)	// Verifica se filtra situação. Em branco exibi todas
					If !(NEWSE5->E5_SITCOB $ MV_PAR15)
						dbSelectArea("NEWSE5")
						NEWSE5->(dbSkip())		      // filtro de registros desnecessarios
						Loop
					Endif
				EndIf
			
			Endif

			cCond3:="E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+DtoS(E5_DATA)+E5_SEQ+E5_NUMCHEQ==cPrefixo+cNumero+cParcela+cTipo+DtoS(dBaixa)+cSeq+cNumCheq"
			nDesc := nJuros := nValor := nMulta := nCM := nVlMovFin := 0
		Else
			dbSelectArea("SE2")
			DbSetOrder(1)
			cCarteira := "P"
			lBxTit := MsSeek(cFilial+cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja)
			If !lBxTit
				lBxTit := dbSeek(NEWSE5->E5_FILORIG+cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja)
			Endif
			dDtMovFin := IIF(lManual,CTOD("//"),DataValida(SE2->E2_VENCTO,.T.))
			cCond3:="E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+DtoS(E5_DATA)+E5_SEQ+E5_NUMCHEQ==cPrefixo+cNumero+cParcela+cTipo+cFornece+DtoS(dBaixa)+cSeq+cNumCheq"
			nDesc := nJuros := nValor := nMulta := nCM := nVlMovFin := 0
			cCheque    := Iif(Empty(NEWSE5->E5_NUMCHEQ),SE2->E2_NUMBCO,NEWSE5->E5_NUMCHEQ)
		Endif
		
		dbSelectArea("NEWSE5")
		cHistorico := Space(40)
				
		While NEWSE5->( !Eof()) .and. &cCond3 .and. lContinua .And. NEWSE5->E5_FILIAL==xFilial("SE5")
			
			dbSelectArea("NEWSE5")
			
			//Testa condicoes de filtro
			If !Fr190TstCond(cFilSe5) 
				dbSelectArea("NEWSE5")
				NEWSE5->(dbSkip())		      // filtro de registros desnecessarios
				Loop
			Endif

			If NEWSE5->E5_SITUACA $ "C/E/X"
				dbSelectArea("NEWSE5")
				NEWSE5->( dbSkip() )
				Loop
			EndIF

			If NEWSE5->E5_LOJA != cLoja
				Exit
			Endif

			If NEWSE5->E5_FILORIG < mv_par33 .or. NEWSE5->E5_FILORIG > mv_par34
				dbSelectArea("NEWSE5")
				NEWSE5->( dbSkip() )
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Nao imprime os registros de emprestimos excluidos ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If NEWSE5->E5_TIPODOC == "EP"
				SEH->(DbSetOrder(1))
				
				If !SEH->(MsSeek(xFilial("SEH")+Substr(NEWSE5->E5_DOCUMEN,1,nTamEH)))
					NEWSE5->(dbSkip())
					Loop
				EndIf
			EndIf
			
			//Nao imprime os registros de pagamento de emprestimos estornados
			If NEWSE5->E5_TIPODOC == "PE"
				SEI->(DbSetOrder(1))
				
				If SEI->(MsSeek(xFilial("SEI")+"EMP"+Substr(NEWSE5->E5_DOCUMEN,1,nTamEI))) .And. SEI->EI_STATUS == "C"
					NEWSE5->(dbSkip())
					Loop
				EndIf
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica o vencto do Titulo ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cFilTrb := If(mv_par11==1,"SE1","SE2")
			If (cFilTrb)->(!Eof()) .And.;
				((cFilTrb)->&(Right(cFilTrb,2)+"_VENCREA") < mv_par31 .Or. (!Empty(mv_par32) .And. (cFilTrb)->&(Right(cFilTrb,2)+"_VENCREA") > mv_par32))
				dbSelectArea("NEWSE5")
				NEWSE5->(dbSkip())
				Loop
			Endif

			dBaixa     	:= NEWSE5->E5_DATA
			cBanco     	:= NEWSE5->E5_BANCO
			cNatureza  	:= NEWSE5->E5_NATUREZ
			cCliFor    	:= NEWSE5->E5_BENEF
			cSeq       	:= NEWSE5->E5_SEQ
			cNumCheq   	:= NEWSE5->E5_NUMCHEQ
			cRecPag		:= NEWSE5->E5_RECPAG
			cMotBaixa	:= NEWSE5->E5_MOTBX
			cTipo190		:= NEWSE5->E5_TIPO

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Obter moeda da conta no Banco.                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cPaisLoc	# "BRA".And.!Empty(NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA)
				SA6->(DbSetOrder(1))
				SA6->(MsSeek(xFilial()+NEWSE5->E5_BANCO+NEWSE5->E5_AGENCIA+NEWSE5->E5_CONTA))
				nMoedaBco	:=	Max(SA6->A6_MOEDA,1)
			Else
				nMoedaBco	:=	1
			Endif

			If !Empty(NEWSE5->E5_NUMERO)
				If (NEWSE5->E5_RECPAG == "R" .and. !(NEWSE5->E5_TIPO $ MVPAGANT+"/"+MV_CPNEG)) .or. ;
					(NEWSE5->E5_RECPAG == "P" .and. NEWSE5->E5_TIPO $ MVRECANT+"/"+MV_CRNEG)
					dbSelectArea( "SA1")
					dbSetOrder(1)
					If MsSeek(xFilial("SA1")+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA)
						cCliFor := Iif(mv_par30==1,SA1->A1_NREDUZ,SA1->A1_NOME)
					EndIF
				Else
					dbSelectArea( "SA2")
					dbSetOrder(1)
					If MSSeek(xFilial("SA2")+NEWSE5->E5_CLIFOR+NEWSE5->E5_LOJA)
						cCliFor := Iif(mv_par30==1,SA2->A2_NREDUZ,SA2->A2_NOME)
					EndIF
				EndIf
			EndIf

			dbSelectArea("SM2")
			dbSetOrder(1)
			dbSeek(NEWSE5->E5_DATA)
			dbSelectArea("NEWSE5")
			nRecSe5:=If(lAsTop,NEWSE5->SE5RECNO,Recno())

			nDesc+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VLDESCO,Round(xMoeda(NEWSE5->E5_VLDESCO,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))
			nJuros+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VLJUROS,Round(xMoeda(NEWSE5->E5_VLJUROS,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))
			nMulta+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VLMULTA,Round(xMoeda(NEWSE5->E5_VLMULTA,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))
			nCM+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VLCORRE,Round(xMoeda(NEWSE5->E5_VLCORRE,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))

			If lPccBaixa .and. Empty(NEWSE5->E5_PRETPIS) .And. Empty(NEWSE5->E5_PRETCOF) .And. Empty(NEWSE5->E5_PRETCSL)
				nTotAbImp+=(NEWSE5->E5_VRETPIS)+(NEWSE5->E5_VRETCOF)+(NEWSE5->E5_VRETCSL)
			Endif

			If NEWSE5->E5_TIPODOC $ "VL/V2/BA/RA/PA/CP"
				cHistorico := NEWSE5->E5_HISTOR
				nValor+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,Round(xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))

				//Pcc Baixa CR
				If cCarteira == "R" .and. lPccBxCr .and. cPaisLoc == "BRA"
					If Empty(NEWSE5->E5_PRETPIS)
						nPccBxCr += Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VRETPIS,Round(xMoeda(NEWSE5->E5_VRETPIS,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,NEWSE5->E5_TXMOEDA),nDecs+1))
					Endif
					If Empty(NEWSE5->E5_PRETCOF)
						nPccBxCr += Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VRETCOF,Round(xMoeda(NEWSE5->E5_VRETCOF,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,NEWSE5->E5_TXMOEDA),nDecs+1))
					Endif
					If Empty(NEWSE5->E5_PRETCSL)
						nPccBxCr += Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VRETCSL,Round(xMoeda(NEWSE5->E5_VRETCSL,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,NEWSE5->E5_TXMOEDA),nDecs+1))
					Endif
				Endif

			Else
				nVlMovFin+=Iif(mv_par12==1.And.nMoedaBco==1,NEWSE5->E5_VALOR,Round(xMoeda(NEWSE5->E5_VALOR,nMoedaBco,mv_par12,NEWSE5->E5_DATA,nDecs+1,,If(cPaisLoc=="BRA",NEWSE5->E5_TXMOEDA,0)),nDecs+1))
				cHistorico := Iif(Empty(NEWSE5->E5_HISTOR),"MOV FIN MANUAL",NEWSE5->E5_HISTOR)
				cNatureza  	:= NEWSE5->E5_NATUREZ
			Endif
			dbSkip()
			If lManual		// forca a saida do looping se for mov manual
				Exit
			Endif
		EndDO

		If (nDesc+nValor+nJuros+nCM+nMulta+nVlMovFin) > 0
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ C lculo do Abatimento        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cCarteira == "R" .and. !lManual
				dbSelectArea("SE1")
				nRecno 		:= Recno()
				nTotAbImp 	:= 0
				nAbatLiq 	:= 0
				lUltBaixa 	:= .F.

				aAreaSE1 := SE1->(GetArea())
				dbSelectArea("SE5")
				dbSetOrder(7)
				cChaveSE1 := SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)
				SE5->(MsSeek(xFilial("SE5")+cChaveSE1))

				cSeqSE5 := SE5->E5_SEQ

				While SE5->(!EOF()) .And. cChaveSE1 == SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)
					If SE5->E5_SEQ > cSeqSE5
						cSeqSE5 := SE5->E5_SEQ
					Endif
					SE5->(dbSkip())
				Enddo

				SE5->(MsSeek(xFilial("SE5")+cChaveSE1+cSeqSE5))
				cChaveSE5 := cPrefixo+cNumero+cParcela+cTipo+cFornece+cLoja+cSeq

				If cChaveSE5 == SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) .And.;
					Empty(SE1->E1_SALDO)
					lUltBaixa := .T.
				EndIf

				If lUltBaixa
					nAbat := SumAbatRec(cPrefixo,cNumero,cParcela,SE1->E1_MOEDA,"V",dBaixa,@nTotAbImp)
					nAbatLiq := nAbat - nTotAbImp
				EndIf

				lUltBaixa := .F.
				RestArea(aAreaSE1)
				dbSelectArea("SE1")
				dbGoTo(nRecno)
				cCliFor190 := SE1->E1_CLIENTE+SE1->E1_LOJA
				nVlr:= SE1->E1_VLCRUZ
				If mv_par12 > 1
					nVlr := Round(xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par12,SE1->E1_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",SE1->E1_TXMOEDA,0)),nDesc+1)
				EndIF
				If mv_par13 == 1  // Utilizar o Hist¢rico da Baixa ou Emiss„o
					cHistorico := Iif(Empty(cHistorico), SE1->E1_HIST, cHistorico )
				Else
					cHistorico := Iif(Empty(SE1->E1_HIST), cHistorico, SE1->E1_HIST )
				Endif
				dbSelectArea("SE5")
				dbgoto(nRecSe5)
			Elseif !lManual
				dbSelectArea("SE2")
				nRecno := Recno()
				nAbat :=	SomaAbat(cPrefixo,cNumero,cParcela,"P",mv_par12,,cFornece,cLoja)
				nAbatLiq := nAbat
				dbSelectArea("SE2")
				dbGoTo(nRecno)
				cCliFor190 := SE2->E2_FORNECE+SE2->E2_LOJA
				nVlr:= SE2->E2_VLCRUZ
				If mv_par12 > 1
					nVlr := Round(xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,mv_par12,SE2->E2_EMISSAO,nDecs+1,If(cPaisLoc=="BRA",SE2->E2_TXMOEDA,0)),nDecs+1)
				Endif
				If mv_par13 == 1  // Utilizar o Hist¢rico da Baixa ou Emiss„o
					cHistorico := Iif(Empty(cHistorico), SE2->E2_HIST, cHistorico )
				Else
					cHistorico := Iif(Empty(SE2->E2_HIST), cHistorico, SE2->E2_HIST )
				Endif
				dbSelectArea("SE5")
				dbgoto(nRecSe5)
			Else
				nAbatLiq := 0
				lTemTit:=.F.
				dbSelectArea("SE5")
				dbgoto(nRecSe5)
				nVlr := Iif(mv_par12==1.And.nMoedaBco==1,SE5->E5_VALOR,Round(xMoeda(SE5->E5_VALOR,nMoedaBco,mv_par12,SE5->E5_DATA,nDecs+1,If(cPaisLoc=="BRA",SE5->E5_TXMOEDA,0)),nDecs+1))
			EndIF

			//Calcula a multnat para cada baixa, se houver
			lMultNat := .F.
			If !lManual
				dbSelectArea("SEV")
				dbSetOrder(2)
				cChave:= xFilial("SEV")+cPrefixo+cNumero+cParcela+cTipo+cCliFor190+"2"+cSeq
				bWhile := { || .F. }
				If dbSeek(cChave)
					lMultNat := .T.
					bWhile := { || cChave == xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_IDENT+SEV->EV_SEQ) }
				Else
					// Pesquisa pela distribuicao mult. natureza na emissao, sem a sequencia da baixa
					cChave:= xFilial("SEV")+cPrefixo+cNumero+cParcela+cTipo+cCliFor190+"1"
					If dbSeek(cChave)
						lMultNat := .T.
						bWhile := { || cChave == xFilial("SEV")+SEV->(EV_PREFIXO+EV_NUM+EV_PARCELA+EV_TIPO+EV_CLIFOR+EV_LOJA+EV_IDENT) }
					Endif
				Endif
				If lMultNat
					aSaldo := {}
					While Eval(bWhile)
						If SEV->EV_RECPAG == cCarteira .AND. !(SEV->EV_SITUACA $ "X/E")
							nValNat 	 := nVlr //* SEV->EV_PERC
							nVBxNat 	 := nValor * SEV->EV_PERC
							nJurNat 	 := nJuros * SEV->EV_PERC
							nAbtNat 	 := nAbatLiq * SEV->EV_PERC
							nAbImpNat := nTotAbImp * SEV->EV_PERC
							nMulNat   := nMulta * SEV->EV_PERC
							nCmoNat   := nCm * SEV->EV_PERC
							nDesNat   := nDesc * SEV->EV_PERC
							nPccBxNat := nPccBxCr * If(Select("TMPSEV") > 0,TMPSEV->EV_PERC,SEV->EV_PERC)	//Pcc Baixa CR
							AADD(aSaldo,{SEV->EV_NATUREZ,nValNat,nVBxNat,nJurNat,nMulNat,nDesNat,nCmoNat,nAbtNat,nAbImpNat,nVlMovFin,SE5->E5_NATUREZ,nPccBxNat})
						Endif
						SEV->(DbSkip())
						Loop
					Enddo
				Endif
			Endif
			//PCC Baixa CR
			//Somo aos abatimentos de impostos, os impostos PCC na baixa.
			//Caso o calculo do PCC CR seja pela emissao, esta variavel estara zerada
			nTotAbImp := nTotAbImp + nPccBxCR

			If !lMultNat .and. !lManual
				AADD(aSaldo,{cNatureza,nVlr,nValor,nJuros,nMulta,nDesc,nCm,nAbatLiq,nTotAbImp,nVlMovFin,cNatureza,nPccBxCr})
			ElseIf lManual
				AADD(aSaldo,{cNatureza,nVlr,nVlMovFin,nJuros,nMulta,nDesc,nCm,nAbatLiq,nTotAbImp,nVlMovFin,cNatureza,nPccBxCr})
			Endif
			DbSelectArea(cArqTmp)
			For nX := 1 To Len( aSaldo )
				//Verifico a Natureza e gravo no ArqTmp

				If (aSaldo[nX][1] >= MV_PAR05 .And. aSaldo[nX][1]<= MV_PAR06) .or.;
				   (aSaldo[nX][11] >= MV_PAR05 .And. aSaldo[nX][11]<= MV_PAR06)

					RecLock(cArqTmp,.T.) //DbAppend()
					For nY := 1 To SE5->(fCount())
						(cArqTmp)->(FieldPut(nY,SE5->(FieldGet(nY))))
					Next
					(carqtmp)->E5_BENEF 	:= cCliFor 
					(cArqTmp)->E5_NATUREZ	:= aSaldo[nX][1]
					(cArqTmp)->E5_VALTIT	:= aSaldo[nX][2]
					(cArqTmp)->E5_VALOR		:= aSaldo[nX][3]
					(cArqTmp)->E5_VLJUROS	:= aSaldo[nX][4]
					(cArqTmp)->E5_VLMULTA	:= aSaldo[nX][5]
					(cArqTmp)->E5_VLDESCO	:= aSaldo[nX][6]
					(cArqTmp)->E5_VLCORRE	:= aSaldo[nX][7]
					(cArqTmp)->E5_VLABLIQ	:= aSaldo[nX][8]
					(cArqTmp)->E5_VLABIMP	:= aSaldo[nX][9] //+ aSaldo[nX][12]
					(cArqTmp)->E5_VLMOVFI	:= aSaldo[nX][10]
					(cArqTmp)->E5_VENCTO	:= dDtMovFin
					(cArqTmp)->E5_HISTOR	:= cHistorico
					(cArqTmp)->(MsUnlock())
				Endif
			Next
			aSaldo := {}
			nDesc := nJuros := nValor := nMulta := nCM := nAbatLiq := nTotAbImp := nVlMovFin := 0
			nPccBxCr := 0		//Pcc Baixa CR
			dbSelectArea("SE5")
			//cE5Filial := NEWSE5->E5_FILIAL
			dbSkip()
		Endif
		dbSelectArea("NEWSE5")
	Enddo
Enddo
dbSelectArea(cArqTmp)
dbGoTop()
If !EOF() .and. !BOF()
	While !Eof()
		If FunName() == "FINR190"
			If ((MV_MULNATR .and. mv_par11 = 1 .and. mv_par38 = 2 .and. !mv_par39 == 2) .or. (MV_MULNATP .and. mv_par11 = 2 .and. mv_par38 = 2 .and. !mv_par39 == 2) )
				/*cAnterior := cArqTmp->(E5_NATUREZ)
				cCondLaco := "E5_NATUREZ"*/
				cAnterior := (cArqTmp)->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO)
				cCondLaco := "E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO"
			Else
				cAnterior    := (cArqTmp)->(&cCond2)
				cCondLaco    := cCond2
			EndIf
		Else
			cAnterior := (cArqTmp)->(E5_NATUREZ)
			cCondLaco := "E5_NATUREZ"
		Endif
		
		While !Eof() .and. cAnterior == (cArqTmp)->(&cCondLaco)
			If cCondLaco == "E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO" .And. FunName() == "FINR190"
				If (cArqTmp)->(E5_NATUREZ) < mv_par05 .Or. (cArqTmp)->(E5_NATUREZ) > mv_par06
					(cArqTmp)->(dbSkip())
					Loop
				EndIf
			EndIf
			cNatur199 := ""
			AAdd(aRet, Array(33))
			nTamRet := Len(aRet)
			aRet[nTamRet][22] := (cArqTmp)->(E5_FILIAL) + " - " + FwFilName(cEmpAnt,(cArqTmp)->(E5_FILIAL))
			aRet[nTamRet][23] := (cArqTmp)->(E5_BENEF)
			aRet[nTamRet][24] := (cArqTmp)->(E5_LOTE)
			aRet[nTamRet][25] := (cArqTmp)->(E5_DTDISPO)

			cMotBaixa := (cArqTmp)->(E5_MOTBX)
			lManual := .F.
			If Empty((cArqTmp)->E5_TIPODOC) .Or. Empty((cArqTmp)->E5_NUMERO)
				lManual := .t.
			EndIf

			IF !lManual
				aRet[nTamRet][05] := (cArqTmp)->(E5_CLIFOR)
				aRet[nTamRet][06] := SUBSTR((cArqTmp)->(E5_BENEF),1,18)
			Endif

			aRet[nTamRet][01] := (cArqTmp)->(E5_PREFIXO)
			aRet[nTamRet][02] := (cArqTmp)->(E5_NUMERO)
			aRet[nTamRet][03] := (cArqTmp)->(E5_PARCELA)
			aRet[nTamRet][04] := (cArqTmp)->(E5_TIPO)

			aRet[nTamRet][07] := (cArqTmp)->(E5_NATUREZ)
			aRet[nTamRet][08] := (cArqTmp)->(E5_VENCTO)

			If !Empty((cArqTmp)->(E5_NUMCHEQ))
				aRet[nTamRet][09] := SubStr(ALLTRIM((cArqTmp)->(E5_NUMCHEQ))+"/"+Trim((cArqTmp)->(E5_HISTOR)),1,18)
			Else
				aRet[nTamRet][09] := SubStr((cArqTmp)->(E5_HISTOR),1,40)
			Endif

			aRet[nTamRet][10] := (cArqTmp)->(E5_DATA)

			IF (cArqTmp)->(E5_VALTIT) > 0
				aRet[nTamRet][11] := (cArqTmp)->(E5_VALTIT) //Picture tm(cArqTmp->(E5_VALTIT),14,nDecs)
			Endif

			nJurMul := (cArqTmp)->(E5_VLJUROS) + (cArqTmp)->(E5_VLMULTA)

			nCT++
			aRet[nTamRet][12] := nJurMul 				//PicTure tm(cArqTmp->(E5_VLJUROS),12,nDecs)
			aRet[nTamRet][13] := (cArqTmp)->(E5_VLCORRE) 	//PicTure tm((cArqTmp)->(E5_VLCORRE),12,nDecs)
			aRet[nTamRet][14] := (cArqTmp)->(E5_VLDESCO) 	//PicTure tm((cArqTmp)->(E5_VLDESCO),12,nDecs)
			aRet[nTamRet][15] := (cArqTmp)->(E5_VLABLIQ) 	//Picture tm((cArqTmp)->(E5_VLABLIQ) ,12,nDecs)
			aRet[nTamRet][16] := (cArqTmp)->(E5_VLABIMP) 	//Picture tm((cArqTmp)->(E5_VLABIMP) ,12,nDecs)
			aRet[nTamRet][17] := (cArqTmp)->(E5_VALOR)	//PicTure tm((cArqTmp)->(E5_VALOR)  ,14,nDecs)
			aRet[nTamRet][18] := (cArqTmp)->(E5_BANCO)
			aRet[nTamRet][19] := (cArqTmp)->(E5_DTDIGIT)
			aRet[nTamRet][20] := IF(Empty((cArqTmp)->(E5_MOTBX)),"NOR",(cArqTmp)->(E5_MOTBX))
			aRet[nTamRet][21] := (cArqTmp)->(E5_FILORIG)

			nAscan := aScan(aImpresso, (cArqTmp)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+If(nOrdem == 3,(cArqTmp)->E5_NATUREZ,'')) )
			aRet[nTamRet][26] := If(nAscan = 0,.T.,.F.)
			aRet[nTamRet][27] := If( (cArqTmp)->(E5_VLMOVFI) <> 0, (cArqTmp)->(E5_VLMOVFI) , If(MovBcoBx(cMotBaixa),(cArqTmp)->(E5_VALOR),0))
			aRet[nTamRet][29] := If(aScan(aImpresso, (cArqTmp)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) ) = 0,.T.,.F.)
			aRet[nTamRet][30] := (cArqTmp)->(E5_AGENCIA)
			aRet[nTamRet][31] := (cArqTmp)->(E5_CONTA)
			aRet[nTamRet][33] := (cArqTmp)->(E5_TIPODOC)

			//Busca no se5 o recno original do registro para abastecer no array
			nRecnoSe5 := SE5->(Recno())
			If Empty((cArqTmp)->E5_IDMOVI)
				SE5->(dbSetorder(7))
				SE5->(dbseek((cArqTmp)->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ)))
			Else	
				SE5->(dbSetorder(19))
				SE5->(dbseek((cArqTmp)->(E5_FILIAL+E5_IDMOVI)))
			EndIf	
			aRet[nTamRet][28] := SE5->(Recno())
			SE5->(dbGoto(nRecnoSe5))
			SE5->(dbSetorder(1))

			nTotOrig   	+= If(nAscan = 0,(cArqTmp)->(E5_VALTIT),0)
			nGerOrig    += If(aScan(aImpresso, (cArqTmp)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA))=0,(cArqTmp)->(E5_VALTIT),0)
			nFilOrig   	+= If(aScan(aImpresso, (cArqTmp)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA))=0,(cArqTmp)->(E5_VALTIT),0)
			nTotBaixado += Iif(lManual .or. ((cArqTmp)->(E5_TIPODOC) $ "CP/BA" .AND. (cArqTmp)->(E5_MOTBX) $ "CMP/FAT"),0,(cArqTmp)->(E5_VALOR))		//nao soma, ja somou no principal
			nTotDesc   	+= (cArqTmp)->(E5_VLDESCO)
			nTotJurMul 	+= nJurMul
			nTotCM     	+= (cArqTmp)->(E5_VLCORRE)
			nTotAbat   	+= (cArqTmp)->(E5_VLABLIQ)
			nTotImp    	+= (cArqTmp)->(E5_VLABIMP)
			nTotValor  	+= If( (cArqTmp)->(E5_VLMOVFI) <> 0, (cArqTmp)->(E5_VLMOVFI) , If(MovBcoBx(cMotBaixa),(cArqTmp)->(E5_VALOR),0))
			nTotMovFin 	+= If(lManual,(cArqTmp)->(E5_VLMOVFI),0)
			nTotComp	+= If((cArqTmp)->(E5_TIPODOC) == "CP",(cArqTmp)->(E5_VALOR),0)
			nTotFat	    += Iif((cArqTmp)->(E5_MOTBX) == "FAT",(cArqTmp)->(E5_VALOR),0)

			If !lManual
				Aadd(aImpresso, (cArqTmp)->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_NATUREZ+If(nOrdem == 3,(cArqTmp)->E5_NATUREZ,'')) )
			Endif
			cNatur199 := (cArqTmp)->(E5_NATUREZ)
			(cArqTmp)->(dbSkip())

		EndDo

		If (nTotValor+nDesc+nJuros+nCM+nTotMulta+nTotOrig+nTotMovFin+nTotComp+nTotFat) > 0

			cQuebra := (cArqTmp)->(E5_NATUREZ)

		  	If nTotBaixado > 0
				AAdd(aTotais,{cQuebra,STR0028,nTotBaixado,(cArqTmp)->(E5_DATA)}) //"Baixados"
			Endif
			If nTotMovFin > 0
				AAdd(aTotais,{cQuebra,STR0031,nTotMovFin,(cArqTmp)->(E5_DATA)}) //"Baixados"
			Endif
			If nTotComp > 0
				AAdd(aTotais,{cQuebra,STR0037,nTotComp,(cArqTmp)->(E5_DATA)}) //"Compensados"
			Endif
			If nTotFat > 0
				AAdd(aTotais,{cQuebra,STR0076 ,nTotFat,(cArqTmp)->(E5_DATA)}) //"Bx.Fatura"
			Endif
		Endif
		
		//========================
		//Incrementa Totais Gerais
		//========================
		//nGerOrig  += nTotOrig
		nGerValor   += nTotValor
		nGerDesc    += nTotDesc
		nGerJurMul  += nTotJurMul
		nGerCM      += nTotCM
		nGerAbLiq   += nTotAbat
		nGerAbImp   += nTotImp
		nGerBaixado += nTotBaixado
		nGerMovFin  += nTotMovFin
		nGerComp    += nTotComp
		nGerFat     += nTotFat
		
		//========================
		//Incrementa Totais Filial
		//========================
		//nFilOrig  += nTotOrig
		nFilValor   += nTotValor
		nFilDesc    += nTotDesc
		nFilJurMul  += nTotJurMul
		nFilCM      += nTotCM
		nFilAbLiq   += nTotAbat
		nFilAbImp   += nTotImp
		nFilBaixado += nTotBaixado
		nFilMovFin  += nTotMovFin
		nFilComp    += nTotComp
		nFilFat     += nTotFat

		nTotValor   := 0
		nTotDesc    := 0
		nTotJurMul  := 0
		nTotMulta   := 0
		nTotCM	     := 0
		nCT         := 0
		nTotOrig    := 0
		nTotBaixado := 0
		nTotAbat    := 0
		nTotImp     := 0
		nTotMovFin  := 0
		nTotComp    := 0
		nTotFat     := 0
		
		dbSelectArea(cArqTmp)
	
	EndDo
	
Endif

DbSelectArea("SM0")
DbSeek(cEmpAnt+cFilAnt,.T.)

While !Eof() .and. M0_CODIGO == cEmpAnt .and. IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) <= cFilAte
	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	cFilNome:= SM0->M0_FILIAL

	If lUnidNeg .AND. (cEmpresa	<> FWCodEmp())
		SM0->(DbSkip())
		Loop
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprimir TOTAL por filial somente quan-³
	//³ do houver mais do que 1 filial.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if mv_par17 == 1 .and. SM0->(Reccount()) > 1
		If nFilBaixado > 0
			AAdd(aTotais,{IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ),STR0028,nFilBaixado})  //"Baixados"
		Endif
		If nFilMovFin > 0
			AAdd(aTotais,{IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ),STR0031,nFilMovFin})  //"Mov Fin."
		Endif
		If nFilComp > 0
			AAdd(aTotais,{IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ),STR0037,nFilComp})  //"Compens."
		Endif
		If nFilFat > 0
			AAdd(aTotais,{IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ),STR0076,nFilFat})  //"Bx. Fatura"
		Endif

		If Empty(FwFilial("SE5"))
			Exit
		Endif

		nFilOrig:=nFilJurMul:=nFilCM:=nFilDesc:=nFilAbLiq:=nFilAbImp:=nFilValor:=0
		nFilBaixado:=nFilMovFin:=nFilComp:=nFilFat:=0
	Endif
	dbSelectArea("SM0")
	cCodUlt := SM0->M0_CODIGO
	cFilUlt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	dbSkip()

Enddo

If (lNovaGestao .Or. (mv_par17 == 1 .and. SM0->(Reccount()) > 1)) .And. !Empty(cE5Filial)
	DbSelectArea("SM0")
	DbSeek(cCodUlt+cE5Filial,.T.)
	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
EndIf

If(_oFINR199 <> NIL)
	_oFINR199:Delete()
	_oFINR199 := NIL
EndIf

RestArea(aAreaSm0)
SE5->(RestArea(aAreaSe5))

Return aRet
