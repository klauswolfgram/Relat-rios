/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR130.CH"

Static _oFinr1351

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR135   ºAutor  ³Claudio D. de Souza º Data ³  28/08/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime o relatorio de titulos a receber quando escolhido  º±±
±±º          ³ a ordem por natureza no FINR130, devido a implementacao de º±±
±±º          ³ multiplas naturezas por titulos                            º±±
±±º          ³ Parametros:                                                º±±
±±º          ³ cTipos    -> Tipos de titulos que nao serao impressos,     º±±
±±º          ³              enviado pelo FINR130 atraves do PE F130FILT   º±±
±±º          ³ lEnd      -> Acao do CodBlock, ennviado pelo RptStatus     º±±
±±º          ³ nTot0     -> Total do valor original do titulo             º±±
±±º          ³ nTot1     -> Total do saldo vencido do titulo              º±±
±±º          ³ nTot2     -> Total do saldo corrigido do titulo            º±±
±±º          ³ nTot3     -> Total do saldo a vencer dos titulos           º±±
±±º          ³ nTottit   -> Qtde. de titulos impressos                    º±±
±±º          ³ nTotJ     -> Total dos juros                               º±±
±±º          ³ oReport   -> objeto do TReport                             º±±
±±º          ³ aDados    -> array a ser utilizado no printline            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR130                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                            
User Function Finr135( cTipos, lEnd, nTot0, nTot1, nTot2, nTot3, nTotTit, nTotJ, oReport, aDados, oSection, aStru)

Local oSection1 := oReport:Section(1)
Local cIndTmp 	:= CriaTrab( Nil, .F. )
Local aAreaSe1	:= SE1->(GetArea()) 
Local aSaldo						  
Local aTotais 					  
Local cArqTmp						  
Local dDataReaj					  
Local nDecs   	:= MsDecimais(mv_par15)
Local nSaldo						   
Local nX		:= 0
Local nY		:= 0
Local nI		:= 0
Local nJuros  	:= 0				  
Local cTitAnt									
Local nIndexSe1					  
Local lDvc		:= oReport:nDevice == 4
Local aDtTit	:= {}
Local cMvDesFin	:= SuperGetMV("MV_DESCFIN",,"I")
Local nDescFin	:= 0

/*
	Tratamento para campos Personalizados -> Trocar o Alias de SE1 para cArqTemp
*/
If oSection1:UseFilter()	// Se existe algum campo (célula) Personalizado
	For nI := 1 To Len(oSection1:aCell)
		If oSection1:aCell[nI]:lUserField
			If ValType(oSection1:aCell[nI]:cAlias) == "C" .AND. oSection1:aCell[nI]:cAlias == "SE1"
				oSection1:aCell[nI]:cAlias := "cArqTmp"
			EndIf
		EndIf
	Next nI
EndIf

//-----------------------------------------------------------
//Criação da tabela temporaria com a mesma estrutura do SE1
//-----------------------------------------------------------
If _oFinr1351 <> Nil
	_oFinr1351:Delete()
	_oFinr1351 := Nil
Endif

_oFinr1351 := FWTemporaryTable():New( "cArqTmp" )  
_oFinr1351:SetFields(aStru) 	
_oFinr1351:AddIndex("1", {"E1_FILIAL","E1_NATUREZ","E1_NOMCLI","E1_PREFIXO","E1_NUM","E1_TIPO"}) 	
_oFinr1351:Create()	

DbSelectArea("SE1")

If TcSrvType() == "AS/400"
	SE1->(dbSetOrder(3))
	IndRegua( "SE1", cIndTmp, IndexKey(),,Fr130IndR())
	nIndexSE1 := RetIndex("SE1")
	dbSetOrder(nIndexSe1+1)
Endif	

cTitulo := cTitulo + OemToAnsi(STR0021)  //" - Por Natureza"
DbSelectArea("SE1")
DbGoTop()
// Gera o arquivo temporario por natureza
While SE1->(!Eof())
	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se nao atender a condicao para impressao, despreza o registro³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	If !Fr135Cond(cTipos)
		DbSkip()
		Loop
	EndIf	
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se estiver utilizando multiplas naturezas, verifica o codigo da natureza³
	//³do arquivo de multiplas naturezas (SEV)                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
  	If MV_MULNATR .And. E1_MULTNAT == "1"
   	If !PesqNatSev("SE1","E1", MV_PAR11, MV_PAR12)
			DbSkip()
			Loop
		Endif
	Else	
		/*
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Senao, verifica o codigo da natureza do SE1³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		*/
		If SE1->E1_NATUREZ < mv_par11 .OR. SE1->E1_NATUREZ > mv_par12
	  		DbSkip()
			Loop
	  	Endif
	Endif	

	dDataReaj := If(E1_VENCREA < dDataBase,;
	             If(mv_par17=1,dDataBase,E1_VENCREA),dDataBase)
					 
	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se estiver utilizando multiplas naturezas, verifica o arquivo de multiplas³
	//³naturezas (SEV) e inclui diversos registros no SE1 temporario             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	aSaldo := SdoTitNat(E1_PREFIXO     ,;
							  E1_NUM         ,;
							  E1_PARCELA     ,;
							  E1_TIPO        ,;
							  E1_CLIENTE     ,;
							  E1_LOJA,       ,;
							  "R"            ,;
							  "SE1"          ,;
							  MV_PAR15       ,;
							  MV_PAR20 == 1  ,;
							  dDataReaj	)

	//Tratamento no ultimo registro do array, pois a função SdoTitNat() totaliza a diferença de saldo na ultima natureza.
  	If MV_MULNATR .And. E1_MULTNAT == "1"
		aSaldo[Len(aSaldo),2] -= SE1->E1_SDDECRE
	Endif

	DbSelectArea("cArqTmp")
	For nX := 1 To Len( aSaldo )
		If aSaldo[nX][1] >= MV_PAR11 .And. aSaldo[nX][1]<= MV_PAR12
			DbAppend()
			For nY := 1 To (SE1->(fCount())) //Alterado para desconsiderar os ultimos campos da estrutura, campos RECNO e A1_NOME ou A1_NREDUZ
				cArqTmp->(FieldPut(nY,SE1->(FieldGet(nY))))
			Next
			cArqTmp->E1_NATUREZ := aSaldo[nX][1]
			cArqTmp->E1_SALDO   := aSaldo[nX][2]
			cArqTmp->E1_VALOR   := aSaldo[nX][4]
			// nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
			If !(E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. !(MV_PAR20 == 2 .And. E1_SALDO == 0) 
				If mv_par33 != 3
					cArqTmp->E1_SALDO -= aSaldo[nX][5]
				Endif	
			EndIf
		Endif
	Next
	DbSelectArea("SE1")
	Se1->(DbSkip())
Enddo

DbSelectArea( "cArqTmp" )
cArqTmp->(DbGoTop())
While cArqTmp->(!Eof())

	cNatAnt 	:= E1_NATUREZ
	aTotais 	:= { 0,0,0,0,0,0 } // Totais por natureza
	nJuros  	:= 0
	
	// Processa todas a naturezas
	While cArqTmp->E1_NATUREZ == cNatAnt .And. !Eof()

		// Guarda o numero do titulo para verificar se totaliza o valor do titulo
		cTitAnt := cArqTmp->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)

		nDescFin	:= 0
			
		nSaldo := cArqTmp->E1_SALDO
		nSaldo := Round(NoRound(nSaldo,3),2)
					
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So considera caso saldo seja maior que zero  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nSaldo > 0
			
			dbSelectArea("SA1")
			MSSeek(xFilial("SA1")+cArqTmp->(E1_CLIENTE+E1_LOJA))
			dbSelectArea("SA6")
			MSSeek(xFilial("SA6")+cArqTmp->E1_PORTADO)
			dbSelectArea("cArqTmp")
			
			If mv_par19 == 1
				aDados[2] := cArqTmp->E1_CLIENTE + "-" + cArqTmp->E1_LOJA + "-" + IIF(mv_par29 == 1, SubStr(SA1->A1_NREDUZ,1,IIf(TamSX3("E1_CLIENTE")[1] > 6,17,20)), SubStr(SA1->A1_NOME,1,IIf(TamSX3("E1_CLIENTE")[1] > 6,17,20)))
				aDados[3] := cArqTmp->E1_PREFIXO + "-" + cArqTmp->E1_NUM + "-" + cArqTmp->E1_PARCELA
				aDados[4] := cArqTmp->E1_TIPO
				aDados[5] := cArqTmp->E1_NATUREZ
				If lDvc
					aDados[6] := cArqTmp->E1_EMISSAO
					aDados[7] := cArqTmp->E1_VENCTO
					aDados[8] := cArqTmp->E1_VENCREA
				Else
					aDtTit := F130Dtano2("cArqTmp") 
					aDados[6] := aDtTit[1]
					aDados[7] := aDtTit[2]
					aDados[8] := aDtTit[3]
				EndIf
				aDados[9] := cArqTmp->E1_PORTADO + " " + cArqTmp->E1_SITUACA
				aDados[10]:= xMoeda(cArqTmp->E1_VALOR,cArqTmp->E1_MOEDA,mv_par15,cArqTmp->E1_EMISSAO,ndecs+1) * If(cArqTmp->E1_TIPO $ MVRECANT+"/"+MV_CRNEG, -1, 1)
			Endif
			
			If dDataBase > cArqTmp->E1_VENCREA	//vencidos
				If mv_par19 == 1
					aDados[11] := nSaldo * If(cArqTmp->E1_TIPO $ MVRECANT+"/"+MV_CRNEG, -1, 1)
				EndIf
				nJuros := fa070Juros(mv_par15,,Alias())
				If mv_par19 == 1
					aDados[12] := (nSaldo + nJuros) * If(cArqTmp->E1_TIPO $ MVRECANT+"/"+MV_CRNEG, -1, 1)
				EndIf
				If cArqTmp->E1_TIPO $ MVRECANT+"/"+MV_CRNEG
					aTotais[1] -= xMoeda(cArqTmp->E1_VALOR,cArqTmp->E1_MOEDA,mv_par15,cArqTmp->E1_EMISSAO,ndecs+1)
					aTotais[2] -= (nSaldo)
					aTotais[3] -= (nSaldo+nJuros)
				Else
					aTotais[1] += xMoeda(cArqTmp->E1_VALOR,cArqTmp->E1_MOEDA,mv_par15,cArqTmp->E1_EMISSAO,ndecs+1)
					aTotais[2] += (nSaldo)
					aTotais[3] += (nSaldo+nJuros)
				Endif
				aDados[13] := 0
			Else						//a vencer
				// Analitico
				If mv_par19 == 1					
					If cArqTmp->E1_DESCFIN > 0 .AND. ( Empty(cArqTmp->E1_BAIXA) .OR. cMvDesFin == "P"  ) 
						nDescFin := FaDescFin("cArqTmp",dDataBase,nSaldo,1,.T.)
					EndIf
					aDados[13] := (nSaldo - nDescFin) * If(cArqTmp->E1_TIPO $ MVRECANT+"/"+MV_CRNEG, -1, 1)
				EndIf
				If ! ( E1_TIPO $ MVRECANT+"/"+MV_CRNEG)
					aTotais[1] += xMoeda(cArqTmp->E1_VALOR,E1_MOEDA,mv_par15,cArqTmp->E1_EMISSAO,ndecs+1)
					aTotais[4] += nSaldo
				Else
					aTotais[1] -= xMoeda(cArqTmp->E1_VALOR,cArqTmp->E1_MOEDA,mv_par15,cArqTmp->E1_EMISSAO,ndecs+1)
					aTotais[4] -= nSaldo
				Endif
			Endif
			
			// Analitico
			If mv_par19 == 1
				aDados[14] := Alltrim(cArqTmp->E1_NUMBCO)
			EndIf
			If nJuros > 0
				If mv_par19 == 1
					aDados[15] := nJuros
				EndIf
			Endif
			
			IF dDataBase > cArqTmp->E1_VENCREA
				nAtraso := dDataBase - cArqTmp->E1_VENCTO
				IF Dow(cArqTmp->E1_VENCTO) == 1 .Or. Dow(cArqTmp->E1_VENCTO) == 7
					IF Dow(dBaixa) == 2 .and. nAtraso <= 2
						nAtraso := 0
					EndIF
				EndIF
				nAtraso := If(nAtraso<0,0,nAtraso)
				IF nAtraso>0 .And. mv_par19 == 1
					aDados[16] := nAtraso
				EndIF
			EndIF
			If mv_par19 == 1
				aDados[17] := SubStr(cArqTmp->E1_HIST,1,20)+ ;
					If(cArqTmp->E1_TIPO $ MVPROVIS,"*"," ")+ ;
					If(nSaldo == xMoeda(cArqTmp->E1_VALOR,cArqTmp->E1_MOEDA,mv_par15,dDataReaj,ndecs+1)," ","P")
					oSection1:PrintLine()
					aFill(aDados,nil)
			EndIf
			
			DbSelectArea( "cArqTmp" )
			dbSkip()
			
			aTotais[5] ++
			aTotais[6] += nJuros
			
		   nTotTit ++
		Else
			DbSelectArea( "cArqTmp" )
			dbSkip()
		EndIf
	Enddo // Mudou a natureza
	nTot0 += aTotais[1]
	nTot1 += aTotais[2]
	nTot2 += aTotais[3]
	nTot3 += aTotais[4]
	nTotJ += aTotais[6]
	IF aTotais[5] > 0 
	   If mv_par19 == 1
	      oReport:SkipLine()
	   EndIf
	   SubTot130R(aTotais[1],aTotais[2],aTotais[3],aTotais[4],,5,cNatAnt,aTotais[6],,oReport,aDados,oSection)
	   If mv_par19 == 1
	   	oReport:SkipLine()
	   EndIf
	Endif
	DbSelectArea( "cArqTmp" )
EndDo

#IFNDEF TOP
	dbSelectArea("SE1")
	dbClearFil()
	RetIndex("SE1")
	FErase(cIndTmp+OrdBagExt())	
	DbSetOrder(1)
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga arquivos tempor rios  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("cArqTmp")
cArqTmp->( dbCloseArea() )
If _oFinr1351 <> Nil
	_oFinr1351:Delete()
	_oFinr1351 := Nil
Endif

SE1->(RestArea(aAreaSe1))

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºRotina    ³Fr135Cond ºAutor  ³Claudio D. de Souza º Data ³  28/08/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Avalia condicoes para filtrar os registros que serao       º±±
±±º          ³ impressos.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR135                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Fr135Cond(cTipos)
Local lRet := .T.,;
		dDtContab 

// dDtContab para casos em que o campo E1_EMIS1 esteja vazio
dDtContab := Iif(Empty(SE1->E1_EMIS1),SE1->E1_EMISSAO,SE1->E1_EMIS1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtrar com base no Pto de entrada do Usuario...             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄJose Lucas, Localiza‡”es ArgentinaÄÙ
Do Case 
Case !Empty(cFilterUser).and.!(&cFilterUser)
	lRet := .F.
Case !Empty(SE1->E1_BAIXA) .and. Iif(mv_par20 == 2 ,SE1->E1_SALDO == 0 ,;
	  (SE1->E1_SALDO == 0 .and. SE1->E1_BAIXA <= dDataBase))
	lRet := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se trata-se de abatimento ou somente titulos³
//³ at‚ a data base. 									         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
Case SE1->E1_TIPO $ MVABATIM .Or. SE1->E1_EMISSAO>dDataBase
	lRet := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se ser  impresso titulos provis¢rios		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Case SE1->E1_TIPO $ MVPROVIS .and. mv_par16 == 2
	lRet := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se ser  impresso titulos de Adiantamento	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Case SE1->E1_TIPO $ MVRECANT+"/"+MV_CRNEG .and. mv_par26 == 2
	lRet := .F.
Case !Empty(cTipos)
	If !(SE1->E1_TIPO $ cTipos)
	   lRet := .F.
	Endif
Case SE1->E1_CLIENTE < mv_par01 .OR. SE1->E1_CLIENTE > mv_par02 .OR. ;
	  SE1->E1_PREFIXO < mv_par03 .OR. SE1->E1_PREFIXO > mv_par04 .OR. ;
  	  SE1->E1_NUM	 	< mv_par05 .OR. SE1->E1_NUM 	  > mv_par06 .OR. ;
	  SE1->E1_PORTADO < mv_par07 .OR. SE1->E1_PORTADO > mv_par08 .OR. ;
	  SE1->E1_VENCREA < mv_par09 .OR. SE1->E1_VENCREA > mv_par10 .OR. ;
	  SE1->E1_EMISSAO < mv_par13 .OR. SE1->E1_EMISSAO > mv_par14 .OR. ;
	  SE1->E1_LOJA    < mv_par24 .OR. SE1->E1_LOJA    > mv_par25 .OR. ;
	  dDtContab       < mv_par27 .OR. dDtContab       > mv_par28 .OR. ;
	  SE1->E1_EMISSAO > dDataBase .Or. !&(fr130IndR())
	  lRet := .F.
Case mv_par18 == 2 .and. FN022SITCB( SE1->E1_SITUACA )[3]   //sitcob -- Situacoes de cobranca descontada
	lRet := .F.
Case mv_par30 == 2 // nao imprime
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se deve imprimir outras moedas³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SE1->E1_MOEDA != mv_par15 //verifica moeda do campo=moeda parametro
		lRet := .F.
	Endif
EndCase
	
Return lRet