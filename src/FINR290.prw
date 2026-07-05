/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR290.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} FinR290
Relatório de Relação dos Juros devidos e não Pagos.

@author 	Daniel Batori
@since 		03/07/2006
@version 	1.0
@return		Nil
/*/
User Function FinR290()

	Local oReport	As Object

	oReport := ReportDef()
	oReport:PrintDialog()

Return Nil

/*/{Protheus.doc} ReportDef
Impressão do Arquivo de Envio de Titulos ao Banco - SE1.

@author 	Daniel Batori
@since 		03/07/2006
@version 	1.0
@return		Nil
/*/
Static Function ReportDef()

	Local aTam1			As Array
	Local aTam2			As Array
	Local aTam3			As Array
	Local cAliasQry1	As Character
	Local oReport		As Object
	Local oSection1		As Object

	cAliasQry1	:= GetNextAlias()

	oReport 	:= TReport():New("FINR290", STR0004, "FIN290", {|oReport| ReportPrint(oReport, @cAliasQry1)}, STR0001 + STR0002 + STR0003)

	oReport:SetPortrait(.T.)


	Pergunte("FIN290", .F.)


	oSection1 := TRSection():New(oReport,STR0031,{"SE1","SA1","SED"}) //'Titulos'

	aTam1 	:= TamSX3("E1_CLIENTE")
	aTam2 	:= TamSX3("E1_LOJA")
	nTamCli := aTam1[1] + aTam2[1] + 1
	aTam1 	:= TamSX3("E1_PREFIXO")
	aTam2 	:= TamSX3("E1_NUM")
	aTam3 	:= TamSX3("E1_PARCELA")
	nTamTit := aTam1[1] + aTam2[1] + aTam3[1] + 5

	TRCell():New(oSection1,"E1_PORTADO","SE1",STR0017,,3      ,.F.,)
	TRCell():New(oSection1,"CLIENTE"   ,"SE1",STR0018,,nTamCli,.F.,)
	TRCell():New(oSection1,"A1_NREDUZ" ,"SA1",STR0019,,       ,.F.,)
	TRCell():New(oSection1,"TITULO"    ,"SE1",STR0020,,nTamTit,.F.,)
	TRCell():New(oSection1,"E1_VENCTO" ,"SE1",STR0021,,       ,.F.,)
	TRCell():New(oSection1,"ATRASO"    ,	 ,STR0022,,4      ,.F.,)
	TRCell():New(oSection1,"E1_BAIXA"  ,"SE1",STR0023,,       ,.F.,)   //SOMENTE PARA BAIXADO
	TRCell():New(oSection1,"E1_VALOR"  ,"SE1",STR0024+CRLF+STR0025,"@E 99,999,999.99",13,.F.,)
	TRCell():New(oSection1,"E1_SALDO"  ,"SE1",STR0026+CRLF+STR0025,"@E 99,999,999.99",13,.F.,)
	TRCell():New(oSection1,"E1_DEV"    ,"SE1",STR0027+CRLF+STR0028,"@E 99,999,999.99",13,.F.,)
	TRCell():New(oSection1,"E1_PAG"    ,"SE1",STR0027+CRLF+STR0029,"@E 99,999,999.99",13,.F.,)
	TRCell():New(oSection1,"E1_DIF"    ,"SE1",STR0030,"@E 99,999,999.99",13,.F.,)

Return oReport

/*/{Protheus.doc} ReportPrint
A funcao estática ReportDef devera ser criada para todos os relatorios que poderão ser agendados pelo usuário.

@author 	Daniel Batori
@since 		03/07/2006
@version 	1.0
@param		oReport, object, objeto TReport
@param		cAliasQry1, character, alias utilizado na query
@return		Nil
/*/
Static Function ReportPrint(oReport As Object, cAliasQry1 As Character)

	Local aJuroCalc		As Array
	Local cQuery		As Character
	Local lBaixados		As Logical
	Local nDecs			As Numeric
	Local nDias			As Numeric
	Local nSaldoTit 	As Numeric
	Local nJuroDif		As Numeric
	Local nJDevido 		As Numeric
	Local nJPago		As Numeric
	Local nValorTit		As Numeric
	Local oBreak		As Object
	Local oSection1 	As Object

	Private dBaixa 		As Date

	oSection1 	:= oReport:Section(1)
	cQuery		:= ""
	nDias		:= 0
	nValorTit	:= 0
	nSaldoTit 	:= 0
	nJDevido	:= 0
	nJPago		:= 0
	nJuroDif	:= 0
	nDecs		:= MsDecimais(MV_PAR09)
	aJuroCalc	:= {0, 0} // array de juros (1 - juros devido, 2 - juros pago)
	lBaixados	:= IIf(MV_PAR08 == 2, .T., .F.)

	dBaixa 		:= dDataBase

	DbSelectArea("SE1")
	SE1->(DbSetorder(4))

	oSection1:BeginQuery()

	//Baixados?
	If lBaixados
		cQuery += " AND E1_SALDO = 0 "
	Else
		cQuery += " AND E1_SALDO <> 0 "
	EndIf

	//nao imprime de outra moeda
	If MV_PAR10 == 2
		cQuery += " AND E1_MOEDA = " + STR(MV_PAR09, 2)
	EndIf

	// Nao considera abatimentos
	cQuery += " AND E1_TIPO NOT IN " + FormatIn(MVABATIM, "|")

	cQuery += " ORDER BY " + SqlOrder(IndexKey())

	cQuery := "%" + cQuery + "%"

	BeginSql Alias cAliasQry1

		SELECT SE1.*, SA1.A1_NREDUZ
		FROM %table:SA1% SA1 ,
			%table:SE1% SE1
			LEFT OUTER JOIN %table:SED% SED
				ON	(	ED_FILIAL	=	%xFilial:SED% AND
						ED_CODIGO	=	E1_NATUREZ AND
						SED.%NotDel%)

		WHERE E1_FILIAL = %xFilial:SE1% AND
				E1_PORTADO BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
				E1_TIPO <> 'JP' AND
				E1_CLIENTE between %exp:MV_PAR05% AND %exp:MV_PAR06% AND
				E1_VENCTO between %exp:MV_PAR03% AND %exp:MV_PAR04% AND
				SE1.%NotDel% AND
				A1_FILIAL	= %xFilial:SA1% AND
				A1_COD		= E1_CLIENTE	AND
				A1_LOJA		= E1_LOJA		AND
				SA1.%NotDel%
				%Exp:cQuery%
	EndSql

	oSection1:EndQuery()

	oBreak := TRBreak():New (oSection1 ,  oSection1:Cell("Bco")  , "Sub Total" , .F.)

	oSection1:Cell("ATRASO")	:SetBlock({|| nDias    })
	oSection1:Cell("E1_VALOR")	:SetBlock({|| nValorTit})
	oSection1:Cell("E1_SALDO")	:SetBlock({|| nSaldoTit})
	oSection1:Cell("E1_DEV")	:SetBlock({|| nJDevido })
	oSection1:Cell("E1_PAG")	:SetBlock({|| nJPago   })
	oSection1:Cell("E1_DIF")	:SetBlock({|| nJuroDif })
	oSection1:Cell("E1_PORTADO"):SetBlock({|| (cAliasQry1)->E1_PORTADO })
	oSection1:Cell("CLIENTE")	:SetBlock({|| (cAliasQry1)->E1_CLIENTE + " " + (cAliasQry1)->E1_LOJA })
	oSection1:Cell("A1_NREDUZ")	:SetBlock({|| (cAliasQry1)->A1_NREDUZ  })
	oSection1:Cell("TITULO")	:SetBlock({|| (cAliasQry1)->E1_PREFIXO + "-" + (cAliasQry1)->E1_NUM + "-" + (cAliasQry1)->E1_PARCELA })
	oSection1:Cell("E1_VENCTO")	:SetBlock({|| (cAliasQry1)->E1_VENCTO  })
	oSection1:Cell("E1_BAIXA")	:SetBlock({|| (cAliasQry1)->E1_BAIXA   })   //SOMENTE PARA BAIXADO

	If lBaixados .And. (cAliasQry1)->(!Eof())
		oSection1:Cell("E1_SALDO"):Disable()
		oReport:SetTitle(STR0004 + " " + GetMv("MV_MOEDA"+Str(MV_PAR09,1)) + STR0009)

		TRFunction():New(oSection1:Cell("E1_VALOR")	,"T_VALOR"	,"SUM"	,oBreak,,,,.T.,.F.)
		TRFunction():New(oSection1:Cell("E1_DEV")	,"T_J_DEV"	,"SUM"	,oBreak,,,,.T.,.F.)
		TRFunction():New(oSection1:Cell("E1_PAG")	,"T_J_PAG"	,"SUM"	,oBreak,,,,.T.,.F.)
		TRFunction():New(oSection1:Cell("E1_DIF")	,"T_DIF"	,"SUM"	,oBreak,,,,.T.,.F.)
	ElseIf (cAliasQry1)->(!Eof())
		oSection1:Cell("E1_BAIXA"):Disable()
		oSection1:Cell("E1_DEV"):Disable()
		oSection1:Cell("E1_PAG"):Disable()
		oReport:SetTitle(STR0004 + GetMv("MV_MOEDA"+Str(MV_PAR09,1)) + STR0007)

		TRFunction():New(oSection1:Cell("E1_SALDO")	,"T_SALDO"	,"SUM",oBreak,,,,.T.,.F.)
		TRFunction():New(oSection1:Cell("E1_DIF")	,"T_DIF"	,"SUM",oBreak,,,,.T.,.F.)
		oSection1:Cell("E1_DIF"):SetTitle(STR0027+CRLF+STR0028)
	EndIf

	oSection1:SetTotalInLine(.F.)
	oReport:SetMeter((cAliasQry1)->(LastRec()))

	(cAliasQry1)->(DbGoTop())

	oSection1:Init()

	While (cAliasQry1)->(!Eof())

		lImprime := .F.

		nSaldoTit := xMoeda((cAliasQry1)->(E1_SALDO + E1_SDACRES - E1_SDDECRE), (cAliasQry1)->E1_MOEDA, MV_PAR09, (cAliasQry1)->E1_EMISSAO, nDecs + 1)

		// Titulo Baixado
		If lBaixados
			If (cAliasQry1)->E1_BAIXA > DataValida((cAliasQry1)->E1_VENCTO, .T.)
				nDias := (cAliasQry1)->E1_BAIXA - (cAliasQry1)->E1_VENCTO
			Else
				nDias := (cAliasQry1)->E1_BAIXA - DataValida((cAliasQry1)->E1_VENCTO, .T.)
			EndIf
		ElseIf dDataBase > DataValida((cAliasQry1)->E1_VENCTO, .T.)
			nDias  := (dDataBase - (cAliasQry1)->E1_VENCTO)	// sem data valida, para considerar final de semana em atraso
		Else
			nDias  := 0
		EndIf

		If nDias <= 0
			(cAliasQry1)->(DbSkip())
			Loop
		EndIf

		nValorTit := xMoeda((cAliasQry1)->E1_VALOR, (cAliasQry1)->E1_MOEDA, MV_PAR09, (cAliasQry1)->E1_EMISSAO, nDecs + 1)

		If lBaixados
			dBaixa := (cAliasQry1)->E1_BAIXA
		Else
			dBaixa := dDataBase // data p/calculo de juros não pagos (fa070juros)
		EndIf

		aJuroCalc	:= U_FR290Juros(MV_PAR09, lBaixados, (cAliasQry1)->E1_VENCTO, cAliasQry1)     // moeda selecionada
		nJDevido	:= aJuroCalc[1]
		nJPago		:= aJuroCalc[2]

		If lBaixados
			nJuroDif := (Round(NoRound(nJDevido, 3), 2) - Round(NoRound(nJPago, 3), 2))
		Else
			nJuroDif := nJDevido
		EndIf

		If nJuroDif >= MV_PAR07 // Valor minimo de juros a ser listado
			oSection1:PrintLine()
		EndIf

		(cAliasQry1)->(DbSkip())
		oReport:IncMeter()
	EndDo

	oSection1:Finish()

Return

/*/{Protheus.doc} FR290Juros
Calcula o valor dos juros de acordo com o numero de dias em atraso passando por todos os titulos atrasados ou pagos com atraso.                                                    

@author 	Daniel Batori
@since 		03/07/2006
@version 	1.0
@param		nMoeda, numeric, moeda da impressão
@param		lBaixados, logical, se considera baixados ou não
@param		dUltBaixa, date, data da última baixa
@param		cAlias, character, alias da query
@return		array, array de duas posições, sendo {1=Juros Devido;2=Juros Pago}
/*/
User Function FR290Juros(nMoeda As Numeric, lBaixados As Logical, dUltBaixa As Date,cAlias As Character) As Array

	Local cAliasOld		:= Alias()
	Local aJurCalc		:= {0, 0} 	//total de juros devido do titulo e total de juros pago do titulo
	Local lPrimeiro		:= .T.		// Controla o primeiro registro de movimentacao bancaria para efeito do calculo dos juros devidos e nao pagos em baixas parciais
	Local nSaldo		:= 0
	Local nDecs			:= MsDecimais(MV_PAR09)

	Default cAlias		:= "SE1"

	DbSelectArea(cAlias)

	If lBaixados
		nSaldo := (cAlias)->E1_VALOR
	Else
		SE1->(MsGoTo((cAlias)->R_E_C_N_O_)) // SaldoTit precisa do SE1 posicionado

		nSaldo := SaldoTit((cAlias)->E1_PREFIXO, (cAlias)->E1_NUM, (cAlias)->E1_PARCELA, (cAlias)->E1_TIPO, (cAlias)->E1_NATUREZ, "R", (cAlias)->E1_CLIENTE,;
			MV_PAR09,,, (cAlias)->E1_LOJA)
	EndIf

	nSaldo := Round(NoRound(nSaldo, 3), 2)

	//Só executa caso não seja títulos baixados (saldo = 0)
	If !lBaixados
		aJurCalc[1] := Fa070Juros(nMoeda, nSaldo, cAlias, dUltBaixa,, .T.)
	EndIf

	// Calculo de juros dos titulos já baixados, lancado no SE5.
	// Pesquisa todos os movimentos bancario recebidos com atraso referente ao titulo baixado no SE1, para calculo de juros devido e juros pago.

	DbSelectArea("SE5")
	SE5->(DbSetOrder(4))

	// Se houve baixa, calcula os juros devidos pelo SE5
	If SE5->(DbSeek(xFilial("SE5") + (cAlias)->E1_NATUREZ + (cAlias)->E1_PREFIXO + (cAlias)->E1_NUM + (cAlias)->E1_PARCELA + (cAlias)->E1_TIPO, .T.))
		While ( !Eof() .And. xFilial("SE5")  == SE5->E5_FILIAL  .And. (cAlias)->E1_NATUREZ == SE5->E5_NATUREZ .And. (cAlias)->E1_PREFIXO == SE5->E5_PREFIXO .And.;
			(cAlias)->E1_NUM == SE5->E5_NUMERO  .And. (cAlias)->E1_PARCELA == SE5->E5_PARCELA .And. (cAlias)->E1_TIPO == SE5->E5_TIPO )

			If SE5->E5_CLIFOR == (cAlias)->E1_CLIENTE .And. SE5->E5_LOJA   == (cAlias)->E1_LOJA
				If !(TemBxCanc(SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA + SE5->E5_TIPO + SE5->E5_CLIFOR + SE5->E5_LOJA + SE5->E5_SEQ))
					If SE5->E5_TIPODOC $ "JR#J2"
						If cPaisLoc == "BRA"
							aJurCalc[2] += SE5->E5_VALOR // Juros pagos
						Else
							SA6->(DbSeek(xFilial("SA6") + SE5->E5_BANCO + SE5->E5_AGENCIA + SE5->E5_CONTA))
							aJurCalc[2] += xMoeda(SE5->E5_VALOR, SA6->A6_MOEDA, nMoeda, SE5->E5_DATA, nDecs + 1)
						EndIf
					ElseIf SE5->E5_TIPODOC $ "BA/VL" .And. SE5->E5_DATA != (cAlias)->E1_VENCREA // Calcula os juros de titulos pagos (juros devidos e nao pagos)
						If MV_PAR11 == 1 // Calcula Normalmente
							If lPrimeiro
								nSaldo		:= (cAlias)->E1_VALOR
								aJurCalc[1]	:= 0
								lPrimeiro	:= .F.
								dUltBaixa	:= (cAlias)->E1_VENCTO
							EndIf
							dBaixa 		:= SE5->E5_DATA
							aJurCalc[1]	+= Fa070Juros(nMoeda, nSaldo, cAlias, dUltBaixa,, .T.)
							nSaldo		-= (SE5->(E5_VALOR - E5_VLJUROS - E5_VLCORRE + E5_VLMULTA - E5_VLDESCO))
							dUltBaixa	:= SE5->E5_DATA
						Else	// Calcula por baixa
							If lPrimeiro
								aJurCalc[1]	:= 0
								lPrimeiro	:= .F.
								dUltBaixa	:= (cAlias)->E1_VENCTO
							EndIf
							dBaixa		:= SE5->E5_DATA
							nSaldo		:= (SE5->(E5_VALOR - E5_VLJUROS - E5_VLCORRE + E5_VLMULTA - E5_VLDESCO))
							aJurCalc[1]	+= Fa070Juros(nMoeda, nSaldo, cAlias, dUltBaixa,, .T.)
							dUltBaixa	:= SE5->E5_DATA
						EndIf
					EndIf
				EndIf
			EndIf
			DbSelectArea("SE5")
			SE5->(DbSkip())
		EndDo
	EndIf

	If cPaisLoc == "BRA"
		aJurCalc[2] := xMoeda(aJurCalc[2], 1, nMoeda)
	EndIf

	DbSelectArea(cAliasOld)

Return aJurCalc
