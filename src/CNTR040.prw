/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CNTR040.CH"
#INCLUDE "PROTHEUS.CH"

#DEFINE ATOTAL   1
#DEFINE ADESCONT 2
#DEFINE AMULTAS  3
#DEFINE AVLBRUT  4
#DEFINE ARETENC  5
#DEFINE AIRRF    6
#DEFINE AISS     7
#DEFINE AINSS    8
#DEFINE APIS     9
#DEFINE ACOFIN   10
#DEFINE ACSLL    11
#DEFINE AVLLIQ   12
#DEFINE ABONIF   13

Static _oQueries := Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CNTR040   บAutor  ณAndre Anjos         บ Data ณ  26/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime boletim da medicao.									บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR040                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CNTR040()
	Local oReport := NIL

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Variaveis utilizadas para parametros                       |
	//| mv_par01     // Medicao de:                                |
	//| mv_par02     // Medicao ate:	                            |
	//ณ mv_par03     // Contrato de:                               ณ
	//ณ mv_par04     // Contrato ate:                              ณ
	//ณ mv_par05     // Data Inicio:                               ณ
	//ณ mv_par06     // Data Fim:                                  ณ
	//ณ mv_par07     // Situacao de:                               ณ
	//ณ mv_par08     // Situacao ate:                              ณ
	//ณ mv_par09     // Fornecedor de:                             ณ
	//ณ mv_par10     // Fornecedor ate:                            ณ
	//ณ mv_par11     // Tipo de Contrato?:                         ณ
	//ณ mv_par12     // %IRRF											ณ
	//ณ mv_par13     // %ISS												ณ
	//ณ mv_par14     // %INSS											ณ
	//ณ mv_par15     // Cliente de:  					             	ณ
	//ณ mv_par16     // Cliente ate:									ณ
	//ณ mv_par17     // Revisใo de:  					              ณ
	//ณ mv_par18     // Revisใo ate:									ณ
	//ณ mv_par19     // Data de referencia								ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Pergunte("CNR040",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()

	If ValType(_oQueries) == "J"
		FreeObj(_oQueries)		
	EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |ReportDef บAutor  ณAndre Anjos         บ Data ณ  26/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Define estrutura do relatorio de Boletim de Medi็ใo.       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR030                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
	Local oReport	:= Nil
	Local oSecMed	:= Nil
	Local oSecIMe	:= Nil
	Local oSecTot	:= Nil
	Local cSecCab	:= GetNextAlias()
	Local cSecItens	:= GetNextAlias()
	Local cPictVlTot:= PesqPict("CND","CND_VLTOT")
	Local cTamVlTot	:= GetSx3Cache( 'CND_VLTOT', 'X3_TAMANHO' )
	Local cPictQtdMd:= PesqPict("CNB","CNB_QTDMED")

	oReport	:= TReport():New("CNTR040",STR0016,"CNR040",{|oReport| ReportPrin(oReport, cSecCab, cSecItens)},STR0002+STR0003+STR0004)
	oSecMed	:= TRSection():New(oReport,STR0017,{"CND"},,,,,,,,.T.) //-- Medi็ใo
	oSecIMe	:= TRSection():New(oSecMed,STR0075,{"CNE"}) //-- Itens da Medi็ใo
	oSecTot	:= TRSection():New(oSecMed,STR0077) //-- "Totalizadores"

	oSecMed:lHeaderVisible := .T.
	TRCell():New(oSecMed,"CND_NUMMED","CND",STR0015)
	TRCell():New(oSecMed,"CND_CONTRA","CND",STR0018)
	TRCell():New(oSecMed,"CND_REVISA","CND",STR0073)
	TRCell():New(oSecMed,"CND_NUMERO","CND",STR0019)
	TRCell():New(oSecMed,"FORCLI"," ",STR0076,,TamSX3("A1_COD")[1],,{|| If(Empty((cSecCab)->CND_FORNEC),(cSecCab)->CND_CLIENT,(cSecCab)->CND_FORNEC)})
	TRCell():New(oSecMed,"LJFORCLI"," ",RetTitle("A1_LOJA"),,TamSX3("A1_LOJA")[1],,{|| If(Empty((cSecCab)->CND_LJFORN),(cSecCab)->CND_LOJACL,(cSecCab)->CND_LJFORN)})
	TRCell():New(oSecMed,"A2_NOME"," ",RetTitle("A1_NOME"),,TamSX3("A1_NOME")[1],,{|| If(Empty((cSecCab)->CND_FORNEC),;
														Posicione("SA1",1,xFilial("SA1")+(cSecCab)->(CND_CLIENT+CND_LOJACL),"A1_NOME"),;
														Posicione("SA2",1,xFilial("SA2")+(cSecCab)->(CND_FORNEC+CND_LJFORN),"A2_NOME")) })
	TRCell():New(oSecMed,"CN9_VLATU","CN9",STR0021)
	TRCell():New(oSecMed,"CN9_DTFIM","CN9",STR0022)
	TRCell():New(oSecMed,"CND_COMPET","CND",STR0023)
	TRCell():New(oSecMed,"CND_DTFIM","CND",STR0024)

	oSecIMe:lHeaderVisible := .T.
	TRCell():New(oSecIMe,"CNE_ITEM","CNE",STR0025)
	TRCell():New(oSecIMe,"CNE_PRODUT","CNE",STR0026)
	TRCell():New(oSecIMe,"B1_DESC","SB1",STR0027)
	TRCell():New(oSecIMe,"B1_UM","SB1",STR0028)
	TRCell():New(oSecIMe,"CNE_VLUNIT","CNE",STR0029,,,,{|| xMoeda((cSecItens)->CNE_VLUNIT,(cSecCab)->CND_MOEDA,1,If(Empty(mv_par19),dDataBase,mv_par19),TamSX3("CNE_VLUNIT")[2])})
	TRCell():New(oSecIMe,"CNE_QTDSOL","CNE",STR0030)
	TRCell():New(oSecIMe,"QACUMUL","CNE",STR0031,cPictQtdMd,,,{|| (cSecItens)->(CNE_QTDSOL-CNE_QTAMED)})
	TRCell():New(oSecIMe,"CNE_QUANT","CNE",STR0032)
	TRCell():New(oSecIMe,"QACUTOT"," ",STR0033,cPictQtdMd,,,{|| (cSecItens)->(CNE_QTDSOL-CNE_QTAMED+CNE_QUANT)})
	TRCell():New(oSecIMe,"VACUMUL"," ",STR0034,cPictVlTot,cTamVlTot,,;
		{|| xMoeda((cSecItens)->((CNE_QTDSOL-CNE_QTAMED)*CNE_VLUNIT),(cSecCab)->CND_MOEDA,1,If(Empty(mv_par19),dDataBase,mv_par19),TamSX3("CNB_VLTOT")[2])})
	TRCell():New(oSecIMe,"CNE_VLTOT","CNE",STR0035,,,,{|| xMoeda((cSecItens)->CNE_VLTOT,(cSecCab)->CND_MOEDA,1,If(Empty(mv_par19),dDataBase,mv_par19),TamSX3("CNE_VLTOT")[2])})
	TRCell():New(oSecIMe,"VACUTOT"," ",STR0036,cPictVlTot,cTamVlTot,,;
		{|| xMoeda((cSecItens)->((CNE_QTDSOL-CNE_QTAMED+CNE_QUANT)*CNE_VLUNIT),(cSecCab)->CND_MOEDA,1,If(Empty(mv_par19),dDataBase,mv_par19),TamSX3("CNB_QTDMED")[2])})

	TRCell():New(oSecTot,"TEXTO"," ",STR0077,,40) //-- Totalizadores
	TRCell():New(oSecTot,"VALACU"," ",STR0034,cPictVlTot,cTamVlTot)
	TRCell():New(oSecTot,"VALMED"," ",STR0035,cPictVlTot,cTamVlTot)
	TRCell():New(oSecTot,"VALACT"," ",STR0036,cPictVlTot,cTamVlTot)

	oSecMed:SetTotalInLine(.F.)
	oSecIMe:SetTotalInLine(.F.)
	oSecTot:SetReadOnly(.T.)	
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |ReportPrinบAutor  ณAndre Anjos         บ Data ณ  26/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Impressao do relatorio de medi็๕es.		                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR030                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrin(oReport, cSecCab, cSecItens)
	Local nX		:= 0
	Local nValAcu	:= 0
	Local nValMed	:= 0
	Local nValAct	:= 0
	Local nDesAcum	:= 0
	Local nDesMed	:= 0
	Local nMulAcum	:= 0
	Local nMulMed	:= 0
	Local nBonAcum	:= 0
	Local nBonMed	:= 0
	Local nLiqAcu	:= 0
	Local nLiqMed	:= 0
	Local nLiqAct	:= 0
	Local nRegs	:= 0
	Local aValImp := {0,0,0}
	Local dDataRef	:= If(Empty(mv_par19),dDataBase,mv_par19)
	Local oSecMed	:= oReport:Section(1)
	Local oSecIMe	:= oSecMed:Section(1)
	Local oSecTot	:= oSecMed:Section(2)

	Local nDecCNQVal := GetSx3Cache( 'CNQ_VALOR', 'X3_DECIMAL' )
	Local nDecCNRVal := GetSx3Cache( 'CNR_VALOR', 'X3_DECIMAL' )
	Local nDecCNDRet := GetSx3Cache( 'CND_RETCAC', 'X3_DECIMAL' )

	Default cSecCab		:= GetNextAlias()
	Default cSecItens	:= GetNextAlias()

	MakeSqlExp("CNR040")

	//Monta query da se็ใo de medi็๕es
	oSecMed:BeginQuery()
	BeginSQL Alias cSecCab

	SELECT 	CND.CND_FILIAL,
			CND.CND_FILCTR,
			CND.CND_NUMMED,
			CND.CND_CONTRA,
			CND.CND_REVISA,
			ISNULL(CXN.CXN_NUMPLA, CND.CND_NUMERO) CND_NUMERO,
			CND.CND_COMPET,
			CND.CND_DTFIM,
			CND.CND_MOEDA,
			CND.CND_VLTOT,
			CND.CND_RETCAC,
			ISNULL(CXN.CXN_VLDESC, CND.CND_DESCME) CND_DESCME,
			ISNULL(CXN.CXN_FORNEC, CND.CND_FORNEC) CND_FORNEC,
			ISNULL(CXN.CXN_LJFORN, CND.CND_LJFORN) CND_LJFORN,
			ISNULL(CXN.CXN_CLIENT, CND.CND_CLIENT) CND_CLIENT,
			ISNULL(CXN.CXN_LJCLI , CND.CND_LOJACL) CND_LOJACL,		
			CN9.CN9_VLATU,
			CN9.CN9_DTFIM,
			CN9.CN9_ESPCTR,
			CN9.CN9_ALCISS,
			CN9.CN9_TPCTO,
			CN9.CN9_INSSMO,
			CND.R_E_C_N_O_ RECNO
	FROM %Table:CND% CND
		INNER JOIN %Table:CN9% CN9 ON(
			CN9.%NotDel% 
			AND CN9.CN9_FILCTR = CND.CND_FILCTR
			AND CN9.CN9_NUMERO = CND.CND_CONTRA
			AND CN9.CN9_REVISA = CND.CND_REVISA
		)
		LEFT JOIN %Table:CXN% CXN ON(
			CXN.%NotDel% 
			AND CXN.CXN_FILIAL = CND.CND_FILIAL
			AND CXN.CXN_CONTRA = CND.CND_CONTRA
			AND CXN.CXN_REVISA = CND.CND_REVISA
			AND CXN.CXN_NUMMED = CND.CND_NUMMED
			AND CXN.CXN_CHECK  = 'T'
			AND (CXN.CXN_FORNEC = %Exp:Space(Len(CXN->CXN_FORNEC))% OR CXN.CXN_FORNEC BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%)
			AND (CXN.CXN_CLIENT = %Exp:Space(Len(CXN->CXN_CLIENT))% OR CXN.CXN_CLIENT BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%)
		)
	WHERE CND.%NotDel% 
		AND	CND.CND_FILIAL = %xFilial:CND% 
		AND CND.CND_NUMMED BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
		AND (CND.CND_FORNEC = %Exp:Space(Len(CND->CND_FORNEC))% OR CND.CND_FORNEC BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%)
		AND (CND.CND_CLIENT = %Exp:Space(Len(CND->CND_CLIENT))% OR CND.CND_CLIENT BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%)	
		AND CN9.CN9_NUMERO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND	CN9.CN9_REVISA BETWEEN %Exp:mv_par17% AND %Exp:mv_par18% 
		AND CN9.CN9_DTINIC BETWEEN %Exp:DToS(mv_par05)% AND %Exp:DToS(mv_par06)% 
		AND	CN9.CN9_SITUAC BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% 
		AND (%Exp:mv_par11% = %Exp:Space(Len(CN9->CN9_TPCTO))% OR CN9.CN9_TPCTO = %Exp:mv_par11%)
	EndSQL
	oSecMed:EndQuery()

	(cSecCab)->(dbEval({|| nRegs++}))

	oReport:SetMeter(nRegs)

	TRPosition():New(oSecMed,"CN1",1,{|| xFilial("CN1")+(cSecCab)->CN9_TPCTO})
	TRPosition():New(oSecIMe,"SB1",1,{|| xFilial("SB1")+(cSecItens)->CNE_PRODUT})

	(cSecCab)->(dbGoTop())
	While !(cSecCab)->(EOF())
		oReport:IncMeter()
		
		CND->(DbGoTo( (cSecCab)->RECNO )) //Posiciona no registro da CND pra que os campos personalizados sejam exibidos.

		oSecMed:Init()
		oSecMed:PrintLine()

		nValAcu := 0
		nValMed := 0
		nValAct := 0

		//-- Monta query da se็ใo de itens da medi็ใo
		oSecIMe:BeginQuery()
		BeginSQL Alias cSecItens

		SELECT 	CNE.CNE_QTDSOL,
				CNE.CNE_QTAMED,
				CNE.CNE_VLUNIT,
				CNE.CNE_VLTOT,
				CNE.CNE_QUANT,
				CNE.CNE_ITEM,
				CNE.CNE_PRODUT,
				CNE.CNE_VLTOT,
				CNE.R_E_C_N_O_ RECNO
		FROM %Table:CNE% CNE
		WHERE CNE.%NotDel% AND
		CNE.CNE_FILIAL = %Exp:(cSecCab)->CND_FILIAL% AND
		CNE.CNE_NUMMED = %Exp:(cSecCab)->CND_NUMMED% AND
		CNE.CNE_REVISA = %Exp:(cSecCab)->CND_REVISA% AND
		CNE.CNE_NUMERO = %Exp:(cSecCab)->CND_NUMERO%
		EndSQL
		oSecIMe:EndQuery()

		oSecIMe:Init()
		While !(cSecItens)->(EOF())
			CNE->(DbGoTo( (cSecItens)->RECNO )) //Posiciona no registro da CNE pra que os campos personalizados sejam exibidos.

			oSecIMe:PrintLine()
			nValAcu += (cSecItens)->((CNE_QTDSOL - CNE_QTAMED) * CNE_VLUNIT)
			nValMed += (cSecItens)->CNE_VLTOT
			nValAct += (cSecItens)->((CNE_QTDSOL - CNE_QTAMED + CNE_QUANT) * CNE_VLUNIT)

			(cSecItens)->(dbSkip())
		End
		oSecIMe:Finish()
		(cSecItens)->(dbCloseArea())

		//-- Impressใo dos totaliadores
		oSecTot:Init()
		For nX := 1 To 13
			Do Case
				Case nX == 1 //-- Total da medi็ใo
					oSecTot:Cell("TEXTO"):SetValue(STR0037)
					oSecTot:Cell("VALACU"):SetValue(nValAcu)
					oSecTot:Cell("VALMED"):SetValue(nValMed)
					oSecTot:Cell("VALACT"):SetValue(nValAct)
				Case nX == 2 //-- Descontos
					nDesAcum	:= (cSecCab)->(U_CNR040VlDc(CND_NUMMED,.T.,CND_CONTRA,CND_REVISA,CND_NUMERO,CND_FILCTR))
					nDesAcum	:= (cSecCab)->(xMoeda(nDesAcum	, CND_MOEDA,1,dDataRef,nDecCNQVal))					
					nDesMed		:= (cSecCab)->(xMoeda(CND_DESCME, CND_MOEDA,1,dDataRef,nDecCNQVal))

					oSecTot:Cell("TEXTO"):SetValue(STR0038)
					oSecTot:Cell("VALACU"):SetValue(nDesAcum)
					oSecTot:Cell("VALMED"):SetValue(nDesMed)
					oSecTot:Cell("VALACT"):SetValue(nDesAcum + nDesMed)
				Case nX == 3 //-- Multas
					nMulAcum	:= (cSecCab)->(U_CNR040VlMt(CND_NUMMED,.T.,CND_CONTRA,CND_REVISA,CND_NUMERO,"1",CND_FILCTR))
					nMulAcum	:= (cSecCab)->(xMoeda(nMulAcum,CND_MOEDA,1,dDataRef, nDecCNRVal))				
					nMulMed 	:= (cSecCab)->(U_CNR040VlMt(CND_NUMMED,.F.,CND_CONTRA,CND_REVISA,CND_NUMERO,"1",CND_FILCTR))
					nMulMed		:= (cSecCab)->(xMoeda(nMulMed,CND_MOEDA,1,dDataRef,nDecCNRVal))

					oSecTot:Cell("TEXTO"):SetValue(STR0039)
					oSecTot:Cell("VALACU"):SetValue(nMulAcum)
					oSecTot:Cell("VALMED"):SetValue(nMulMed)
					oSecTot:Cell("VALACT"):SetValue(nMulAcum + nMulMed)
				Case nX == 4 //-- Bonifica็๕es
					nBonAcum	:= (cSecCab)->(U_CNR040VlMt(CND_NUMMED,.T.,CND_CONTRA,CND_REVISA,CND_NUMERO,"2",CND_FILCTR))
					nBonAcum	:= (cSecCab)->(xMoeda(nBonAcum,CND_MOEDA,1,dDataRef,nDecCNRVal))
					nBonMed 	:= (cSecCab)->(U_CNR040VlMt(CND_NUMMED,.F.,CND_CONTRA,CND_REVISA,CND_NUMERO,"2",CND_FILCTR))
					nBonMed		:= (cSecCab)->(xMoeda(nBonMed,CND_MOEDA,1,dDataRef,nDecCNRVal))

					oSecTot:Cell("TEXTO"):SetValue(STR0011)
					oSecTot:Cell("VALACU"):SetValue(nBonAcum)
					oSecTot:Cell("VALMED"):SetValue(nBonMed)
					oSecTot:Cell("VALACT"):SetValue(nBonAcum + nBonMed)
				Case nX == 5 //-- Vl. Bruto
				
					If (cSecCab)->CN9_ESPCTR == '2' // Ajuste para calculo da Bonifica็ao em caso de Ctr Compra
						nLiqAcu := nValAcu-nDesAcum+nMulAcum-nBonAcum
						nLiqMed := nValMed-nDesMed+nMulMed-nBonMed
						nLiqAct := nValAct-(nDesAcum + nDesMed)+(nMulAcum + nMulMed)-(nBonAcum + nBonMed)
					Else
						nLiqAcu := nValAcu-nDesAcum+nMulAcum+nBonAcum
						nLiqMed := nValMed-nDesMed+nMulMed+nBonMed
						nLiqAct := nValAct-(nDesAcum + nDesMed)+(nMulAcum + nMulMed)+(nBonAcum + nBonMed)
					EndIF

					oSecTot:Cell("TEXTO"):SetValue(STR0040)
					oSecTot:Cell("VALACU"):SetValue(nLiqAcu)
					oSecTot:Cell("VALMED"):SetValue(nLiqMed)
					oSecTot:Cell("VALACT"):SetValue(nLiqAct)
				Case nX == 6 //-- Reten็ใo
					aValImp[1] := (cSecCab)->(U_CNR040VlRet(CND_NUMMED,CND_CONTRA,CND_REVISA,CND_NUMERO,CND_FILCTR))
					aValImp[1] := (cSecCab)->(xMoeda(aValImp[1],CND_MOEDA,1,dDataRef,nDecCNDRet))
					aValImp[2] := xMoeda((cSecCab)->CND_RETCAC,(cSecCab)->CND_MOEDA,1,dDataRef,nDecCNDRet)
					aValImp[3] := aValImp[1] + aValImp[2]

					oSecTot:Cell("TEXTO"):SetValue(STR0041)
				Case nX == 7 //-- IRRF
					aValImp[1] := (nValAcu * CN1->CN1_ALQTIR) / 100
					aValImp[2] := (nValMed * CN1->CN1_ALQTIR) / 100
					aValImp[3] := (nValAct * CN1->CN1_ALQTIR) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0042)
				Case nX == 8 //-- ISS
					aValImp[1] := (nValAcu * (cSecCab)->CN9_ALCISS) / 100
					aValImp[2] := (nValMed * (cSecCab)->CN9_ALCISS) / 100
					aValImp[3] := (nValAct * (cSecCab)->CN9_ALCISS) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0043)
				Case nX == 9 //-- INSS
					aValImp[1] := (((nValAcu * (cSecCab)->CN9_INSSMO) / 100) * CN1->CN1_ALINSS) / 100
					aValImp[2] := (((nValMed * (cSecCab)->CN9_INSSMO) / 100) * CN1->CN1_ALINSS) / 100
					aValImp[3] := (((nValAct * (cSecCab)->CN9_INSSMO) / 100) * CN1->CN1_ALINSS) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0044)
				Case nX == 10 //-- PIS
					aValImp[1] := (nValAcu * CN1->CN1_ALQPIS) / 100
					aValImp[2] := (nValMed * CN1->CN1_ALQPIS) / 100
					aValImp[3] := (nValAct * CN1->CN1_ALQPIS) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0066)
				Case nX == 11 //-- COFINS
					aValImp[1] := (nValAcu * CN1->CN1_ALCOFI) / 100
					aValImp[2] := (nValMed * CN1->CN1_ALCOFI) / 100
					aValImp[3] := (nValAct * CN1->CN1_ALCOFI) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0067)
				Case nX == 12 //-- CSLL
					aValImp[1] := (nValAcu * CN1->CN1_ALCSLL) / 100
					aValImp[2] := (nValMed * CN1->CN1_ALCSLL) / 100
					aValImp[3] := (nValAct * CN1->CN1_ALCSLL) / 100

					oSecTot:Cell("TEXTO"):SetValue(STR0068)
				Case nX == 13 //-- Vl. Lํquido
					oSecTot:Cell("TEXTO"):SetValue(STR0045)
					oSecTot:Cell("VALACU"):SetValue(nLiqAcu)
					oSecTot:Cell("VALMED"):SetValue(nLiqMed)
					oSecTot:Cell("VALACT"):SetValue(nLiqAct)
			EndCase

			If nX > 5 .And. nX < 13
				oSecTot:Cell("VALACU"):SetValue(aValImp[1])
				oSecTot:Cell("VALMED"):SetValue(aValImp[2])
				oSecTot:Cell("VALACT"):SetValue(aValImp[3])

				nLiqAcu -= aValImp[1]
				nLiqMed -= aValImp[2]
				nLiqAct -= aValImp[3]
			EndIf

			oSecTot:PrintLine()
		Next nX
		oSecTot:Finish()

		oSecMed:Finish()

		(cSecCab)->(dbSkip())
	End
	(cSecCab)->(dbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CNTR040   บAutor  ณMarcelo Custodio    บ Data ณ  23/04/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTotaliza valores da retencao                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcNumMed    - Codigo da medicao                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR040                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CNR040VlRet(cNumMed,cContra,cRevisa,cPlanil,cFilCtr)
	Local aArea  := GetArea()
	Local cQuery := ""
	Local cAlias := ""
	Local nTot   := 0
	Local cPlanVazia:= ""
	Local aTamCNDRet:= TamSx3("CND_RETCAC")
	Local cIdQuery 	:= "RETCAC"
	Local oQuery 	:= Nil

	if (oQuery := GetQuery(cIdQuery)) == NIL
		cPlanVazia:= Space(GetSx3Cache( 'CND_NUMERO', 'X3_TAMANHO' ))
		//Seleciona as medicoes para calculo dos valores retidos
		cQuery := "SELECT SUM(CND.CND_RETCAC) AS TOTRET "
		cQuery += "  FROM "+RetSQLName("CND")+" CND "
		cQuery += " WHERE CND.CND_FILCTR = ?"
		cQuery += "   AND CND.CND_NUMMED < ?"
		cQuery += "   AND CND.CND_CONTRA = ?"
		cQuery += "   AND CND.CND_REVISA = ?"
		cQuery += "   AND (CND.CND_NUMERO = ? OR CND.CND_NUMERO='"+cPlanVazia+"')"
		cQuery += "   AND CND.D_E_L_E_T_ = ' '"
		oQuery := SetQuery(cIdQuery, cQuery)
	endif
	oQuery:SetString(1, cFilCtr)
	oQuery:SetString(2, cNumMed)
	oQuery:SetString(3, cContra)	
	oQuery:SetString(4, cRevisa)	
	oQuery:SetString(5, cPlanil)	

	cAlias := GetNextAlias()
	cQuery := oQuery:getFixQuery()
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAlias,.F.,.T.)

	TCSetField(cAlias,"TOTRET", "N",aTamCNDRet[1],aTamCNDRet[2])//ณ Atualiza estrutura do total

	nTot := (cAlias)->TOTRET

	(cAlias)->(dbCloseArea())

	RestArea(aArea)
	FwFreeArray(aArea)
	FwFreeArray(aTamCNDRet)
Return nTot

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CNTR040   บAutor  ณMarcelo Custodio    บ Data ณ  23/04/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTotaliza valores das multas                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcNumMed    - Codigo da medicao                              บฑฑ
ฑฑบ          ณlAcumulado - Informa se busca as medicoes anteriores        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR040                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CNR040VlMt(cNumMed,lAcumulado,cContra,cRevisa,cNumPla,cTipo,cFilCtr)
	Local aArea		:= GetArea()
	Local cQuery	:= ""
	Local cAlias	:= ""
	Local nTot		:= 0
	Local cIdQuery 	:= ""
	Local oQuery 	:= Nil
	Local aTamCNRVal:= TamSx3("CNR_VALOR")
	Default cTipo := "1"

	cIdQuery := IIF(lAcumulado,'MULTACUM','MULTAS')

	if (oQuery := GetQuery(cIdQuery)) == NIL
		//Seleciona as medicoes para calculo das multas
		cQuery := "SELECT CNR.CNR_VALOR AS TOTMULT, CNR.CNR_TIPO, CNR.CNR_CONTRA"
		cQuery += " FROM "+RetSQLName("CNR")+" CNR"
		cQuery += " INNER JOIN "+RetSQLName("CND")+" CND ON("
		cQuery += " CND.CND_FILIAL = CNR.CNR_FILIAL"
		cQuery += " AND CND.CND_CONTRA = CNR.CNR_CONTRA"
		cQuery += " AND CND.CND_NUMMED = CNR.CNR_NUMMED"
		cQuery += " AND CND.D_E_L_E_T_ = ' ')"
		cQuery += " WHERE"
		cQuery += "	CND.CND_FILCTR = ?"
		cQuery += " AND CNR.CNR_TIPO = ?"
		cQuery += " AND CNR.CNR_CONTRA = ?"
		cQuery += " AND CND.CND_REVISA = ?"
		cQuery += " AND CNR.CNR_CODPLA = ?"

		cQuery += " AND CNR.D_E_L_E_T_ = ' '"
		If lAcumulado
			cQuery += "AND CNR.CNR_NUMMED < ? "//Busca as medicoes anteriores
		Else
			cQuery += "AND CNR.CNR_NUMMED = ? "//Busca medicao atual
		EndIf
		
		oQuery := SetQuery(cIdQuery, cQuery)
	endif

	oQuery:SetString(1, cFilCtr)
	oQuery:SetString(2, cTipo)
	oQuery:SetString(3, cContra)
	oQuery:SetString(4, cRevisa)
	oQuery:SetString(5, cNumPla)
	oQuery:SetString(6, cNumMed)

	cAlias := GetNextAlias()
	cQuery := oQuery:getFixQuery()
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAlias,.F.,.T.)	
	TCSetField(cAlias,"TOTMULT", "N",aTamCNRVal[1],aTamCNRVal[2])//Atualiza estrutura do total	

	While !(cAlias)->(Eof())
		nTot += (cAlias)->TOTMULT

		(cAlias)->(dbSkip())
	EndDo
	(cAlias)->(dbCloseArea())

	RestArea(aArea)
	FwFreeArray(aArea)
	FwFreeArray(aTamCNRVal)
Return nTot

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CNTR040   บAutor  ณMarcelo Custodio    บ Data ณ  23/04/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTotaliza valores dos descontos                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcNumMed    - Codigo da medicao                              บฑฑ
ฑฑบ          ณlAcumulado - Informa se busca as medicoes anteriores        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR040                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CNR040VlDc(cNumMed,lAcumulado,cContra,cRevisa,cPlanil,cFilCtr)
	Local aArea  := GetArea()
	Local cQuery := ""
	Local cAlias := GetNextAlias()
	Local nTot   := 0
	Local cIdQuery 	:= "DESCTACUM"
	Local oQuery 	:= Nil
	Local aTamCNQVal:= TamSx3("CNQ_VALOR")

	if (oQuery := GetQuery(cIdQuery)) == NIL
		//Seleciona as medicoes para calculo dos descontos
		cQuery := "SELECT SUM(CNQ.CNQ_VALOR) AS TOTDESC"
		cQuery += " FROM "+RetSQLName("CNQ")+" CNQ"
		cQuery += " INNER JOIN "+RetSQLName("CND")+" CND ON("
		cQuery += " CND.CND_FILIAL = CNQ.CNQ_FILIAL"
		cQuery += " AND CND.CND_NUMMED = CNQ.CNQ_NUMMED"
		cQuery += " AND CND.CND_CONTRA = CNQ.CNQ_CONTRA"
		cQuery += " AND CND.D_E_L_E_T_ = ' ')"
		cQuery += " WHERE CND.CND_FILCTR = ?"
		cQuery += " AND CNQ.CNQ_CONTRA = ?"
		cQuery += " AND CNQ.CNQ_NUMPLA = ?"
		cQuery += " AND CND.CND_REVISA = ?"
		cQuery += " AND CNQ.D_E_L_E_T_ = ' '"		
		cQuery += " AND CNQ.CNQ_NUMMED < ? "//Busca as medicoes anteriores
		oQuery := SetQuery(cIdQuery, cQuery)
	endif

	oQuery:SetString(1, cFilCtr)	
	oQuery:SetString(2, cContra)
	oQuery:SetString(3, cPlanil)
	oQuery:SetString(4, cRevisa)
	oQuery:SetString(5, cNumMed)

	cAlias := GetNextAlias()
	cQuery := oQuery:getFixQuery()
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAlias,.F.,.T.)	
	TCSetField(cAlias,"TOTDESC", "N",aTamCNQVal[1],aTamCNQVal[2])//Atualiza estrutura do total

	nTot := (cAlias)->TOTDESC

	(cAlias)->(dbCloseArea())

	RestArea(aArea)
	FwFreeArray(aArea)
	FwFreeArray(aTamCNQVal)
Return nTot

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณCNR040ClFrณ Autor ณ Aline Sebrian         ณ Data ณ 11.04.11 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณValida os parametro do Cliente e Fornecedor no relatorio.   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณU_CNR040ClFr()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณU_CNR040ClFr()                                                ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function CNR040ClFr(cTipo)
	Local aSaveArea	:= GetArea()
	Local nTamA2Cod := GetSx3Cache( 'A2_COD', 'X3_TAMANHO' )
	Local nTamA1Cod := GetSx3Cache( 'A1_COD', 'X3_TAMANHO' )

	If cTipo=="1"
		If !Empty(mv_par09) .Or. (!Empty(mv_par10) .And. UPPER(mv_par10) != REPLICATE("Z",nTamA2Cod))
			MV_PAR15	:= Space(nTamA1Cod)
			MV_PAR16	:= REPLICATE("Z",nTamA1Cod)
		EndIf
	Else
		If !Empty(mv_par15) .Or. (!Empty(mv_par16) .And. UPPER(mv_par16) != REPLICATE("Z",nTamA1Cod))
			MV_PAR09	:= Space(nTamA2Cod)
			MV_PAR10	:= REPLICATE("Z",nTamA2Cod)
		EndIf
	EndIf

	RestArea(aSaveArea)
	FwFreeArray(aSaveArea)
Return

/*/{Protheus.doc} GetQuery
	Verifica se hแ uma query preparada com identificador <cIdQuery>
@author philipe.pompeu
@since 21/06/2022
@param cIdQuery,caractere, identificador da query
@return oQuery, objeto, nulo ou instโncia de FWPreparedStatement
/*/
Static Function GetQuery(cIdQuery)
	Local oQuery := Nil
	
	If (_oQueries == Nil .Or. ValType(_oQueries) != "J")
		_oQueries := JsonObject():New()
	EndIf

	if _oQueries:HasProperty(cIdQuery)
		oQuery := _oQueries[cIdQuery]
	endif
Return oQuery

/*/{Protheus.doc} SetQuery
	Cria um objeto do tipo FWPreparedStatement que armazena <cQuerySql>
@author philipe.pompeu
@since 21/06/2022
@param cIdQuery,caractere, identificador da query
@param cQuerySql,caractere, consulta sql เ ser armazenada
@return oQuery, objeto, instโncia de FWPreparedStatement
/*/
Static Function SetQuery(cIdQuery, cQuerySql)
	Local oQuery := Nil
	oQuery := FWPreparedStatement():New(ChangeQuery(cQuerySql))
	_oQueries[cIdQuery] := oQuery
Return oQuery


