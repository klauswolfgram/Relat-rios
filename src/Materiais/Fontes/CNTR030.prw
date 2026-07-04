/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CNTR030.CH"
#INCLUDE "PROTHEUS.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |CNTR030   บAutor  ณAndre Anjos         บ Data ณ  26/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime listagem com o detalhamento das medi็๕es.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR030                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CNTR030(cNumMed)
Local oReport 	:= NIL
Default cNumMed := ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         |
//| mv_par01     // Medicao de:                                  |
//| mv_par02	   // Medicao ate:	                              |
//ณ mv_par03     // Contrato de:                                 ณ
//ณ mv_par04     // Contrato ate:                                ณ
//ณ mv_par05     // Data Inicio:                                 ณ
//ณ mv_par06     // Data Fim:                                    ณ
//ณ mv_par07     // Situacao de:                                 ณ
//ณ mv_par08     // Situacao ate:                                ณ
//ณ mv_par09     // Fornecedor de:                               ณ
//ณ mv_par10     // Fornecedor ate:                              ณ
//ณ mv_par11     // Tipo de Contrato?:                           ณ
//ณ mv_par12     // Exibir Desconto: Sim/Nao                     ณ
//ณ mv_par13     // Exibir Multas/Bonificacoes: Sim/Nao          ณ
//ณ mv_par14     // Exibir Caucoes Retidas: Sim/Nao              ณ
//ณ mv_par15     // Cliente de:                                  ณ
//ณ mv_par16     // Cliente ate:                                 ณ
//| mv_par17     // Imprimir valores - Moeda do ctr/medic./outra ณ
//| mv_par18     // Moeda: 										 	  ณ
//| mv_par19     // Data de Referencia:							  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Pergunte("CNR030",.F.)

If !Empty(cNumMed)
	MV_PAR01 := cNumMed
	MV_PAR02 := cNumMed
	MV_PAR03 := CND->CND_CONTRA
	MV_PAR04 := CND->CND_CONTRA
	MV_PAR05 := CTOD("01/01/06")
	MV_PAR06 := CTOD("31/12/49")
	MV_PAR07 := Space(TamSx3("CN9_SITUAC")[1])
	MV_PAR08 := Replicate("Z",TamSx3("CN9_SITUAC")[1])
	MV_PAR09 := CND->CND_FORNEC
	MV_PAR10 := CND->CND_FORNEC
	MV_PAR12 := 1
	MV_PAR13 := 1
	MV_PAR14 := 1
	MV_PAR15 := CND->CND_CLIENT
	MV_PAR16 := CND->CND_CLIENT
	MV_PAR17 := 1
	MV_PAR18 := 1
	MV_PAR19 := ctod("  /  /  ")
EndIf

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  |ReportDef บAutor  ณAndre Anjos         บ Data ณ  26/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Define estrutura do relatorio de Medicoes.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR030                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport	:= TReport():New("CNTR030",STR0001,"CNR030",{|oReport| ReportPrin(oReport)},STR0002+STR0003+STR0004)
Local oSecMed	:= TRSection():New(oReport,STR0017,{"CND"},,,,,,,,.T.) //-- Medi็ใo
Local oSecIMe	:= TRSection():New(oSecMed,STR0018,{"CNE"}) //-- Itens da Medi็ใo
Local oSecMB	:= TRSection():New(oSecMed,STR0019,{"CNR"}) //-- Multas e Bonifica็๕es
Local oSecDes	:= TRSection():New(oSecMed,STR0020,{"CNP","CNQ"}) //-- Descontos
Local oSecCau	:= TRSection():New(oSecMed,STR0021,{"CNT"}) //-- Cau็๕es Retidas

oSecMed:lHeaderVisible := .T.
TRCell():New(oSecMed,"CND_NUMMED","CND")
TRCell():New(oSecMed,"CND_NUMERO","CND")
TRCell():New(oSecMed,"CND_CONTRA","CND")
TRCell():New(oSecMed,"FORCLI"," ",STR0022,,TamSX3("A1_COD")[1],,{|| If(Empty(SECMED->CND_FORNEC),SECMED->CND_CLIENT,SECMED->CND_FORNEC)})
TRCell():New(oSecMed,"LJFORCLI"," ",RetTitle("A1_LOJA"),,TamSX3("A1_LOJA")[1],,{|| If(Empty(SECMED->CND_LJFORN),SECMED->CND_LOJACL,SECMED->CND_LJFORN)})
TRCell():New(oSecMed,"CND_COMPET","CND")
TRCell():New(oSecMed,"CND_DTVENC","CND")
TRCell():New(oSecMed,"CND_VLMEAC","CND",,,,,{|| SECMED->(C030xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLMEAC"))})
TRCell():New(oSecMed,"CND_VLSALD","CND",,,,,{|| SECMED->(C030xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLSALD"))})
TRCell():New(oSecMed,"CND_VLTOT","CND",,,,,{|| SECMED->(C030xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLTOT"))})

oSecIMe:lHeaderVisible := .T.
TRCell():New(oSecIMe,"CNE_ITEM","CNE")
TRCell():New(oSecIMe,"CNE_PRODUT","CNE")
TRCell():New(oSecIMe,"B1_DESC","SB1")
TRCell():New(oSecIMe,"CNE_QTDSOL","CNE")
TRCell():New(oSecIMe,"CNE_QTAMED","CNE")
TRCell():New(oSecIMe,"CNE_QUANT","CNE")
TRCell():New(oSecIMe,"CNE_PERC","CNE")
TRCell():New(oSecIMe,"CNE_VLUNIT","CNE",,,,,{|| SECIME->(C030xMoeda(CNE_CONTRA,CNE_REVISA,CNE_NUMMED,"CNE_VLUNIT"))})
TRCell():New(oSecIMe,"CNE_VLTOT","CNE",,,,,{|| SECIME->(C030xMoeda(CNE_CONTRA,CNE_REVISA,CNE_NUMMED,"CNE_VLTOT"))})

If mv_par13 != 2
	oSecMB:lHeaderVisible := .T.
	TRCell():New(oSecMB,"CNR_TIPO","CNR")
	TRCell():New(oSecMB,"CNR_DESCRI","CNR")
	TRCell():New(oSecMB,"CNR_VALOR","CNR",,,,,{|| SECMB->(C030xMoeda(CNR_CONTRA,SECMED->CND_REVISA,CNR_NUMMED,"CNR_VALOR"))})
Endif

If mv_par12 != 2
	oSecDes:lHeaderVisible := .T.
	TRCell():New(oSecDes,"CNQ_TPDESC","CNQ")
	TRCell():New(oSecDes,"CNP_DESCRI","CNP")
	TRCell():New(oSecDes,"CNQ_VALOR","CNQ",,,,,{|| SECDES->(C030xMoeda(CNQ_CONTRA,SECMED->CND_REVISA,CNQ_NUMMED,"CNQ_VALOR"))})
Endif

If mv_par14 != 2
	oSecCau:lHeaderVisible := .T.
	TRCell():New(oSecCau,"CNT_FORNEC","CNT")
	TRCell():New(oSecCau,"CNT_LJFORN","CNT")
	TRCell():New(oSecCau,"A2_NOME"," ",STR0022,,TamSX3("A1_NOME")[1],,{|| If(Empty(SECMED->CND_FORNEC),;
														Posicione("SA1",1,xFilial("SA1")+SECMED->(CND_CLIENT+CND_LOJACL),"A1_NOME"),;
														Posicione("SA2",1,xFilial("SA2")+SECMED->(CND_FORNEC+CND_LJFORN),"A2_NOME")) })
	TRCell():New(oSecCau,"CNT_VLRET","CNT",,,,,{|| SECCAU->(C030xMoeda(CNT_CONTRA,SECMED->CND_REVISA,CNT_NUMMED,"CNT_VLRET"))})
	TRCell():New(oSecCau,"CNT_VLBX","CNT",,,,,{|| SECCAU->(C030xMoeda(CNT_CONTRA,SECMED->CND_REVISA,CNT_NUMMED,"CNT_VLBX"))})
	TRCell():New(oSecCau,"CNT_DTBX","CNT")
Endif

oSecMB:SetTotalText("")
oSecDes:SetTotalText("")
oSecCau:SetTotalText("")

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
Static Function ReportPrin(oReport)
Local oSecMed	:= oReport:Section(1)
Local oSecIMe	:= oSecMed:Section(1)
Local oSecMB	:= oSecMed:Section(2)
Local oSecDes	:= oSecMed:Section(3)
Local oSecCau	:= oSecMed:Section(4)
Local cExpFil := "%"

MakeSqlExp("CNR030")

cExpFil += "CND.CND_FILCTR = CN9.CN9_FILCTR AND%"

//-- Monta query da se็ใo de medi็๕es
oSecMed:BeginQuery()
BeginSQL Alias "SECMED"

SELECT CND.*
FROM %Table:CND% CND
JOIN %Table:CN9% CN9 ON
	CN9.%NotDel% AND
	CN9.CN9_FILIAL = %xFilial:CN9% AND
	CN9.CN9_NUMERO = CND.CND_CONTRA AND
	CN9.CN9_REVISA = CND.CND_REVISA AND
	CN9.CN9_NUMERO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
	CN9.CN9_DTINIC >= %Exp:DToS(mv_par05)% AND
	CN9.CN9_DTFIM <= %Exp:DToS(mv_par06)% AND
	CN9.CN9_SITUAC BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% AND
	(%Exp:mv_par11% = %Exp:CriaVar("CN9_TPCTO",.F.)% OR CN9.CN9_TPCTO = %Exp:mv_par11%)
WHERE CND.%NotDel% AND
	%Exp:cExpFil%
	CND.CND_NUMMED BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	(CND.CND_FORNEC = %Exp:CriaVar("CND_FORNEC",.F.)% OR CND.CND_FORNEC BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%) AND
	(CND.CND_CLIENT = %Exp:CriaVar("CND_CLIENT",.F.)% OR CND.CND_CLIENT BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%)
ORDER BY CND_NUMMED

EndSQL
oSecMed:EndQuery()

//-- Monta query da se็ใo de itens da medi็ใo
BEGIN REPORT QUERY oSecIMe
BeginSQL Alias "SECIME"

SELECT CNE.*
FROM %Table:CNE% CNE
WHERE CNE.CNE_FILIAL = %report_param:SECMED->CND_FILIAL% AND
	CNE.CNE_NUMMED = %report_param:SECMED->CND_NUMMED% AND
	CNE.CNE_REVISA = %report_param:SECMED->CND_REVISA% AND
	CNE.CNE_CONTRA = %report_param:SECMED->CND_CONTRA% AND
	CNE.%NotDel%

EndSQL
END REPORT QUERY oSecIMe

//-- Monta query da se็ใo de multas e bonifica็๕es da medi็ใo
If mv_par13 == 2
	oSecMB:Hide()
Else
	BEGIN REPORT QUERY oSecMB
	BeginSQL Alias "SECMB"

	SELECT CNR.*
	FROM %Table:CNR% CNR
	WHERE CNR.CNR_FILIAL = %xFilial:CNR% AND
		CNR.CNR_NUMMED = %report_param:SECMED->CND_NUMMED% AND
		CNR.%NotDel%

	EndSQL
	END REPORT QUERY oSecMB

	TRFunction():New(oSecMB:Cell("CNR_VALOR"),,"SUM",,STR0012,"@E 99,999,999,999,999.99",,.T.,.F.,,,{|| SECMB->CNR_TIPO == '1'}) //-- Total de Multas
	TRFunction():New(oSecMB:Cell("CNR_VALOR"),,"SUM",,STR0013,"@E 99,999,999,999,999.99",,.T.,.F.,,,{|| SECMB->CNR_TIPO == '2'}) //-- Total de Bonifica็๕es
EndIf

//-- Monta query da se็ใo de descontos
If mv_par12 == 2
	oSecDes:Hide()
Else
	BEGIN REPORT QUERY oSecDes
	BeginSQL Alias "SECDES"

	SELECT CNQ.*
	FROM %Table:CNQ% CNQ
	WHERE CNQ.CNQ_FILIAL = %xFilial:CNQ% AND
		CNQ.CNQ_NUMMED = %report_param:SECMED->CND_NUMMED% AND
		CNQ.%NotDel%

	EndSQL
	END REPORT QUERY oSecDes

	TRFunction():New(oSecDes:Cell("CNQ_VALOR"),,"SUM",,STR0025,"@E 99,999,999,999,999.99",,.T.,.F.) //-- Total de Descontos
EndIf

//-- Monta query da se็ใo de cau็๕es
If mv_par14 == 2	
	oSecCau:Hide()
Else
	BEGIN REPORT QUERY oSecCau
	BeginSQL Alias "SECCAU"

	SELECT CNT.*
	FROM %Table:CNT% CNT
	WHERE CNT.CNT_FILIAL = %xFilial:CNT% AND
		CNT.CNT_NUMMED = %report_param:SECMED->CND_NUMMED% AND
		CNT.%NotDel%

	EndSQL
	END REPORT QUERY oSecCau

	TRFunction():New(oSecCau:Cell("CNT_VLRET"),,"SUM",,STR0023,"@E 99,999,999,999,999.99",,.T.,.F.) //-- Total Retido
	TRFunction():New(oSecCau:Cell("CNT_VLBX"),,"SUM",,STR0024,"@E 99,999,999,999,999.99",,.T.,.F.) //-- Total Retido
EndIf

TRPosition():New(oSecIMe,"SB1",1,{|| xFilial("SB1")+SECIME->CNE_PRODUT})

If mv_par12 != 2
	TRPosition():New(oSecDes,"CNP",1,{|| xFilial("CNP")+SECDES->CNQ_TPDESC})
Endif

oSecMed:Print()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณC030xMoedaบAutor  ณMicrosiga           บ Data ณ  11/06/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Realiza a conversao entre moedas de um determinado valor.  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ cContra: numero do contrato que esta sendo impresso.		  บฑฑ
ฑฑบ			 ณ cRev: revisao do contrato que esta sendo impresso.		  บฑฑ
ฑฑบ			 ณ cNumMed: medicao do contrato que esta sendo impressa.	  บฑฑ
ฑฑบ			 ณ cCampo: nome do campo a ser convertido.					  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno	 ณ nRet: valor apos conversao								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CNTR030													  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function C030xMoeda(cContra,cRev,cNumMed,cCampo)
Local nMoedaOri	:= Posicione("CND",4,xFilial("CND")+cNumMed,"CND_MOEDA")
Local nMoedaDes := nMoedaOri
Local nRet 		:= &(cCampo)

If mv_par17 == 2
	nMoedaDes := Posicione("CN9",1,xFilial("CN9")+cContra+cRev,"CN9_MOEDA")
ElseIf mv_par17 == 3
	nMoedaDes := mv_par18
EndIf

nRet := Round(xMoeda(nRet,nMoedaOri,nMoedaDes,If(Empty(mv_par19),dDataBase,mv_par19),6),TamSX3(cCampo)[2])

Return nRet
