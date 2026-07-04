/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR150.CH"
#Include "PROTHEUS.Ch"

Static _oFinr155
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR155   ºAutor  ³Claudio D. de Souza º Data ³  28/08/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime o relatorio de titulos a pagar   quando escolhido  º±±
±±º          ³ a ordem por natureza no FINR150, devido a implementacao de º±±
±±º          ³ multiplas naturezas por titulos                            º±±
±±º          ³ Parametros:                                                º±±
±±º          ³ cTipos    -> Tipos de titulos que nao serao impressos,     º±±
±±º          ³              enviado pelo FINR150 atraves do PE F150FILT   º±±
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
±±ºUso       ³ FINR150                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Finr155( cTipos, lEnd, nTot0, nTot1, nTot2, nTot3, nTotTit, nTotJ, oReport, aDados, cNomNat, nTotVenc, nTotGeral)
Local oSection1	  := oReport:Section(1)
Local lCellPers	  := oSection1:UseFilter()//retorna se existe campo personalizado
Local aAreaSe2	  := SE2->(GetArea())
Local aStru		  := SE2->(DbStruct())
Local aColuna	  := {}
Local nAux		  := 0
Local aSaldo
Local aTotais
Local cArqTmp	  := GetNextAlias()
Local cOrigem 	  := Alltrim(FunName())
Local dDataReaj
Local nDecs		  := MsDecimais(mv_par15)
Local nSaldo
Local nJuros	  := 0
Local nX		  := 0
Local nY		  := 0
Local aTamFor	  := TAMSX3("E2_FORNECE")
Local cTitAnt
Local aPosTab	  := {}	// nPos1 - Posição no objeto do TReport;
						// nPos2 - Tabela do Campo adicionado pelo Usuario (Personalização de Layout)
Local lReposic    := .F.

Private cFilterUser := oSection1:GetUserExp("SE2", .F.) 

For nAux := 1 to Len(aStru)

	If(aStru[nAux][1] != "R_E_C_N_O_" .AND. aStru[nAux][1] != "R_E_C_D_E_L_")

		aAdd(aColuna,aStru[nAux])

	EndIf
Next

//Verificando se precisa deletar
If(_oFinr155 <> NIL)

	_oFinr155:Delete()
	_oFinr155:= NIL

EndIf
//Criando o objeto
_oFinr155 := FwTemporaryTable():New(cArqTmp)
//Amarrando as colunas neste Objeto
_oFinr155:SetFields(aColuna)
_oFinr155:AddIndex("1",{"E2_FILIAL","E2_NATUREZ","E2_NOMFOR","E2_PREFIXO","E2_NUM","E2_PARCELA","E2_TIPO","E2_FORNECE"})

_oFinr155:Create()

DbSelectArea("SE2")
cTitulo := cTitulo + STR0017  //" - Por Natureza"
DbSelectArea("SE2")
DbGoTop()

// Gera o arquivo temporario por natureza
While SE2->(!Eof())

	/*
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se nao atender a condicao para impressao, despreza o registro³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	*/
	If !Fr155Cond(cTipos, cOrigem)
		DbSkip()
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se estiver utilizando multiplas naturezas, verifica o codigo da natureza³
	//³do arquivo de multiplas naturezas (SEV)                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  	If MV_MULNATP .And. E2_MULTNAT == "1"
	   	If !PesqNatSev("SE2","E2", MV_PAR05, MV_PAR06)
			DbSkip()
			Loop
		Endif
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Senao, verifica o codigo da natureza do SE2³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SE2->E2_NATUREZ < mv_par05 .OR. SE2->E2_NATUREZ > mv_par06
	  		DbSkip()
			Loop
	  	Endif
	Endif
	
	dDataReaj := dDataBase
	
	If SE2->E2_VENCREA < dDataBase .And. MV_PAR17 == 2 .And. MV_PAR15 != SE2->E2_MOEDA .And. RecMoeda(SE2->E2_VENCREA, cValToChar(MV_PAR15)) > 0
		dDataReaj := SE2->E2_VENCREA 
	EndIf
	
	// Se estiver utilizando multiplas naturezas, verifica o arquivo de multiplas
	// naturezas (SEV), inclui diversos registro no SE2 temporario
	aSaldo := SdoTitNat(E2_PREFIXO     ,;
						E2_NUM         ,;
						E2_PARCELA     ,;
						E2_TIPO        ,;
						E2_FORNECE     ,;
						E2_LOJA,       ,;
						"P"            ,;
						"SE2"          ,;
						MV_PAR15       ,;
						MV_PAR21 == 1  ,;
						dDataReaj	)
	
	//Tratamento no ultimo registro do array, pois a função SdoTitNat() totaliza a diferença de saldo na ultima natureza.
	If MV_MULNATP .And. E2_MULTNAT == "1"
		aSaldo[Len(aSaldo),2] -= SE2->E2_SDDECRE
	Endif

	DbSelectArea(cArqTmp)
	For nX := 1 To Len( aSaldo )
		If aSaldo[nX][1] >= MV_PAR05 .And. aSaldo[nX][1]<= MV_PAR06
			DbAppend()
			For nY := 1 To SE2->(fCount())
			    If SE2->(AllTrim(FieldName(nY))) != "R_E_C_N_O_" .And. SE2->(AllTrim(FieldName(nY))) != "R_E_C_D_E_L_"
					(cArqTmp)->(FieldPut(nY,SE2->(FieldGet(nY))))
				EndIf
			Next
			(cArqTmp)->E2_NATUREZ := aSaldo[nX][1]
			(cArqTmp)->E2_SALDO   := aSaldo[nX][2]
			(cArqTmp)->E2_VALOR   := aSaldo[nX][4]
			// nao deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
			If !(E2_TIPO $ MVPAGANT+"/"+MV_CPNEG) .And. !(MV_PAR21 == 2 .And. E2_SALDO == 0)
				(cArqTmp)->E2_SALDO -= aSaldo[nX][5]
			EndIf
		Endif
	Next
	DbSelectArea("SE2")
	Se2->(DbSkip())
Enddo

DbSelectArea( cArqTmp )
DbGoTop()
While !Eof()

	cNatAnt := E2_NATUREZ
	aTotais := { 0,0,0,0,0,0 } // Totais por natureza
	nJuros  := 0

	// Processa todas a naturezas
	While (cArqTmp)->E2_NATUREZ == cNatAnt .And. !Eof()

		// Guarda o numero do titulo para verificar se totaliza o valor do titulo
		cTitAnt := (cArqTmp)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO )

		nSaldo := (cArqTmp)->E2_SALDO
		nSaldo := Round(NoRound(nSaldo,3),2)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ So considera caso saldo seja maior que zero  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nSaldo > 0
			If lCellPers
				SetAliasCell( oSection1, @aPosTab )
				lCellPers := .F.
			EndIf

			If mv_par21 == 1
				//Verifica se existem compensações em outras filiais para descontar do saldo, pois a SaldoTit() somente
				//verifica as movimentações da filial corrente. Nao deve processar quando existe somente uma filial.
				If !Empty(xFilial("SE2")) .And. !Empty(xFilial("SE5"))
					nSaldo -= FRVlCompFil("P", (cArqTmp)->E2_PREFIXO, (cArqTmp)->E2_NUM, (cArqTmp)->E2_PARCELA, (cArqTmp)->E2_TIPO, (cArqTmp)->E2_FORNECE, (cArqTmp)->E2_LOJA, IIF(mv_par34 == 2,3,1),,,,mv_par15,(cArqTmp)->E2_MOEDA, If(mv_par35==1,(cArqTmp)->E2_TXMOEDA, Nil), dDataReaj, .T.)
				EndIf
			Else
				nSaldo := xMoeda((cArqTmp)->E2_SALDO, (cArqTmp)->E2_MOEDA, mv_par15, dDataReaj,ndecs + 1, If(mv_par35==1, (cArqTmp)->E2_TXMOEDA, Nil))
			EndIf

			dbSelectArea("SA2")
			MSSeek(xFilial("SA2")+(cArqTmp)->(E2_FORNECE+E2_LOJA))
			DbSelectArea(cArqTmp)

			If mv_par20 == 1
				aDados[2] := (cArqTmp)->E2_FORNECE + "-" + (cArqTmp)->E2_LOJA + "-" + IIF(mv_par28 == 1, SubStr(SA2->A2_NREDUZ,1,20), SubStr(SA2->A2_NOME,1,20))
				cFilBrk := xFilial("SE2",(cArqTmp)->E2_FILORIG)
				cNatBrk := (cArqTmp)->E2_NATUREZ
				If (aTamFor[1] > 6)
					oSection1:PrintLine()
					oReport:SkipLine()
					aFill(aDados,nil)
				EndIf
				aDados[3] := (cArqTmp)->E2_PREFIXO+"-"+(cArqTmp)->E2_NUM+"-"+(cArqTmp)->E2_PARCELA
				aDados[4] := (cArqTmp)->E2_TIPO
				aDados[5] := (cArqTmp)->E2_NATUREZ
				aDados[6] := (cArqTmp)->E2_EMISSAO
				aDados[7] := (cArqTmp)->E2_VENCTO
				aDados[8] := (cArqTmp)->E2_VENCREA
				aDados[9] := xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,(cArqTmp)->E2_EMISSAO,ndecs+1) * If((cArqTmp)->E2_TIPO $ MV_CPNEG+"/"+MVPAGANT,-1,1)
				aDados[18] := xFilial("SE2",(cArqTmp)->E2_FILORIG)
			Else
				aDados[5]  := (cArqTmp)->E2_NATUREZ
				aDados[18] := xFilial("SE2",(cArqTmp)->E2_FILORIG)
			Endif

			If dDataBase > (cArqTmp)->E2_VENCREA	//vencidos
				If mv_par20 == 1
					aDados[10] := nSaldo * If((cArqTmp)->E2_TIPO $ MV_CPNEG+"/"+MVPAGANT,-1,1)
				EndIf

				nJuros := fa080Juros(mv_par15,,Alias())

				If mv_par20 == 1
					aDados[11] := (nSaldo+nJuros) * If((cArqTmp)->E2_TIPO $ MV_CPNEG+"/"+MVPAGANT,-1,1)
				EndIf

				If (cArqTmp)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG
					aTotais[1] -= xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,(cArqTmp)->E2_EMISSAO,ndecs+1)
					aTotais[2] -= (nSaldo)
					aTotais[3] -= (nSaldo+nJuros)
				Else
					aTotais[1] += xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,(cArqTmp)->E2_EMISSAO,ndecs+1)
					aTotais[2] += (nSaldo)
					aTotais[3] += (nSaldo+nJuros)
				Endif
			Else						//a vencer
				// Analitico
				If mv_par20 == 1
					aDados[12] := nSaldo  * If((cArqTmp)->E2_TIPO $ MV_CPNEG+"/"+MVPAGANT,-1,1)
				EndIf
				If ! ( (cArqTmp)->E2_TIPO $ MVPAGANT+"/"+MV_CPNEG)
					aTotais[1] += xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,(cArqTmp)->E2_EMISSAO,ndecs+1)
					aTotais[4] += nSaldo
				Else
					aTotais[1] -= xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,(cArqTmp)->E2_EMISSAO,ndecs+1)
					aTotais[4] -= nSaldo
				Endif
			Endif

			// Analitico
			If mv_par20 == 1
				aDados[13] := (cArqTmp)->E2_PORTADO
			EndIf
			If nJuros > 0
				If mv_par20 == 1
					aDados[14] := nJuros
				EndIf
			Endif

			IF dDataBase > (cArqTmp)->E2_VENCREA
				nAtraso := dDataBase - (cArqTmp)->E2_VENCTO
				IF Dow((cArqTmp)->E2_VENCTO) == 1 .Or. Dow((cArqTmp)->E2_VENCTO) == 7
					IF Dow(dBaixa) == 2 .and. nAtraso <= 2
						nAtraso := 0
					EndIF
				EndIF
				nAtraso:=IIF(nAtraso<0,0,nAtraso)
				IF nAtraso>0 .And. mv_par20 == 1
					aDados[15] := nAtraso
				EndIF
			EndIF
			If mv_par20 == 1
				aDados[16] := SubStr((cArqTmp)->E2_HIST,1,24)+ ;
					If((cArqTmp)->E2_TIPO $ MVPROVIS,"*"," ")+ ;
					If(nSaldo == xMoeda((cArqTmp)->E2_VALOR,(cArqTmp)->E2_MOEDA,mv_par15,dDataReaj,ndecs+1)," ","P")
				aDados[18]	:= xFilial("SE2",(cArqTmp)->E2_FILORIG)
				SE2->(DbGoTop()) //NECESSÁRIO POSICIONAR PARA O PRINT LINE FUNCIONAR.
				oSection1:PrintLine()
				SE2->(DbGoBottom())
				aFill(aDados,nil)
				//Os dados de Natureza e filial origem são realimentados para que não se dê erro no final do relatório.
				cNatBrk    := (cArqTmp)->E2_NATUREZ
				cFilBrk    := xFilial("SE2",(cArqTmp)->E2_FILORIG)
				aDados[18] := xFilial("SE2",(cArqTmp)->E2_FILORIG)
			Else
				aDados[5]  := (cArqTmp)->E2_NATUREZ
				aDados[18] := xFilial("SE2",(cArqTmp)->E2_FILORIG)
			EndIf

			SED->(dbSetOrder(1))
			If SED->(dbSeek(xFilial("SED")+(cArqTmp)->(E2_NATUREZ)))			
				cNomNat	 := MascNat(SED->ED_CODIGO)+" "+SED->ED_DESCRIC
			EndIf 
			DbSelectArea( cArqTmp )
			dbSkip()

			aTotais[5] ++
			aTotais[6] += nJuros

		   nTotTit ++
		Else
			DbSelectArea( cArqTmp )
			dbSkip()
		EndIf
	Enddo // Mudou a natureza
	nTot0 += aTotais[1]
	nTot1 += aTotais[2]
	nTot2 += aTotais[3]
	nTot3 += aTotais[4]

	nTotJ += aTotais[6]

	nTotVenc  := aTotais[3]+aTotais[4]
	nTotGeral := nTot2+nTot3

	If aTotais[5] > 0 .And. mv_par20 == 2	//2- Sintetico
		If Len(aPosTab) > 0
			For nY := 1 To Len(aPosTab)
				If oSection1:acell[aPosTab[nY,1]]:lUserField
					oSection1:acell[aPosTab[nY,1]]:CALIAS := aPosTab[nY,2]
				EndIf
			Next nY
		EndIf

		lReposic := .F.
		If (SE2->(EOF()) .AND. mv_par20 == 2 .AND. !Empty(cFilterUser))
			SE2->(DbGoTop())
			lReposic := .T.
		EndIf

		SubT150R(aTotais[1],aTotais[2],aTotais[3],aTotais[4],,2,cNatAnt,aTotais[6],oReport,oSection1)

		If (lReposic)
			SE2->(DbGoBottom())
		EndIf
	EndIf
	DbSelectArea( cArqTmp )
EndDo

// Apaga arquivos temporarios
If(_oFinr155 <> NIL)

	_oFinr155:Delete()
	_oFinr155 := NIL

EndIf

SE2->(RestArea(aAreaSe2))

Return Nil

 /*/{Protheus.doc} Fr155Cond
Avalia condicoes para filtrar os registros que serao impressos.      

@author 	Claudio D. de Souza
@since 		28/08/01
@param		cTipo, character, filtro a ser aplicado.
@param		cOrigem, character, Origem da chamada da função
@return		logical, verdadeiro se o título está dentro do filtro a ser considerado
/*/
Static Function Fr155Cond(cTipos As Character, cOrigem As Character) 

Local lRet As Logical

Default cTipos := ""
Default cOrigem := ""

lRet := .T.

// Filtrar com base no Pto de entrada do Usuario...             
Do Case
	Case !Empty(cFilterUser).and.!(&cFilterUser)
		lRet := .F.
	// Verifica se titulo, apesar do E2_SALDO = 0, deve aparecer ou 
	// não no relatorio quando se considera database (mv_par21 = 1) 
	// ou caso nao se considere a database, se o titulo foi totalmen
	// te baixado.													 	
	Case !Empty(SE2->E2_BAIXA) .and. Iif(mv_par21 == 2 ,SE2->E2_SALDO == 0 ,;
		Iif(mv_par34 == 1,(SE2->E2_SALDO == 0 .and. SE2->E2_BAIXA <= dDataBase),.F.))
		lRet := .F.
	// Tratamento da correcao monetaria para a Argentina 	
	Case cPaisLoc=="ARG" .And. mv_par15 <> 1  .And.  SE2->E2_CONVERT == 'N'
		lRet := .F.
	Case !Empty(cTipos)
		If cOrigem $ "FINR150" //O P.E FR150FLT retorna uma expressão
			lRet := !(&cTipos)
		EndIf	
EndCase

Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} SetAliasCell()
Funcao para responsável por setar o alias correto nas cels personalizadas
@param oSection1 - seção na qual será verificada a inclusão de células de user.
@author Totvs Sa
@since	14/09/2017
@version 12
/*/
//-------------------------------------------------------------------

Static Function SetAliasCell( oSection1, aPosTab )

Local nI		:= 0
Local nTotCell	:= len(oSection1:acell)

For nI := 1 To nTotCell
	If oSection1:acell[nI]:lUserField
		AAdd(aPosTab, { nI, oSection1:acell[nI]:CALIAS } )
		oSection1:acell[nI]:CALIAS := Alias()
	EndIf
Next nI

Return Nil
