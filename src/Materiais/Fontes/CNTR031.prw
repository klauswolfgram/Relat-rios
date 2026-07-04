/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CNTR030.CH"
#INCLUDE "PROTHEUS.CH"
#include "report.ch"

Static _cFilMed := ""
Static _cRevMed := ""

//-------------------------------------------------------------------
/*/{Protheus.doc} CNTR031
Imprime listagem com o detalhamento das medições

Observaçoes: Adaptado o relatório CNTR030 e criado o CNTR031. Essa nova 
versão será usada para imprimir medições que foram feitas através da rotina 
CNTA121 e durante a impressão será feita a quebra por planilha. 
   
@param cNumMed, Caracter, Número da medição 
@return Nenhum
@author Eduardo Gomes Júnio (Autor da rotina original:Andre Anjos)
@since 26/08/2013
/*/
//-------------------------------------------------------------------
User Function CNTR031(cNumMed)
Local oReport 	:= NIL
Default cNumMed := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//| mv_par01     // Medicao de:                                  ³
//| mv_par02	   // Medicao ate:	                             ³
//³ mv_par03     // Contrato de:                                 ³
//³ mv_par04     // Contrato ate:                                ³
//³ mv_par05     // Data Inicio:                                 ³
//³ mv_par06     // Data Fim:                                    ³
//³ mv_par07     // Situacao de:                                 ³
//³ mv_par08     // Situacao ate:                                ³
//³ mv_par09     // Fornecedor de:                               ³
//³ mv_par10     // Fornecedor ate:                              ³
//³ mv_par11     // Tipo de Contrato?:                           ³
//³ mv_par12     // Exibir Desconto: Sim/Nao                     ³
//³ mv_par13     // Exibir Multas/Bonificacoes: Sim/Nao          ³
//³ mv_par14     // Exibir Caucoes Retidas: Sim/Nao              ³
//³ mv_par15     // Cliente de:                                  ³
//³ mv_par16     // Cliente ate:                                 ³
//| mv_par17     // Imprimir valores - Moeda do ctr/medic./outra ³
//| mv_par18     // Moeda: 										 ³
//| mv_par19     // Data de Referencia:							 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

	If ExistNvPerg()
		MV_PAR20 := "'" + CND->CND_REVISA + "'"
		MV_PAR21 := "'" + CND->CND_FILCTR + "'"
	Else
		_cRevMed := CND->CND_REVISA
		_cFilMed := CND->CND_FILCTR
	EndIf
	
EndIf

oReport := ReportDef()
oReport:PrintDialog()

_cFilMed := ' '
_cRevMed := ' '


Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Define estrutura do relatório de medições   
@param Nenhum 
@return oReport, Objeto , estrutura do relatório
@author Andre Anjos
@since 26/08/2013
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local oReport	:= TReport():New("CNTR031",STR0001,"CNR030",{|oReport| ReportPrin(oReport)},STR0002+STR0003+STR0004)
	Local oSecMed	:= TRSection():New(oReport,STR0017,{"CND"},,,,,,,,.T.) 													//-- Medição
	Local oSecPla	:= TRSection():New(oSecMed,STR0026,{"CXN"}) 															//-- Planilha Med. de Contratos	
	Local oSecIMe	:= TRSection():New(oSecPla,STR0018,{"CNE"}) 															//-- Itens da Medição
	Local oSecMB	:= TRSection():New(oSecPla,STR0019,{"CNR"}) 															//-- Multas e Bonificações
	Local oSecDes	:= TRSection():New(oSecPla,STR0020,{"CNP","CNQ"}) 														//-- Descontos
	Local oSecCau	:= TRSection():New(oSecPla,STR0021,{"CNT"}) 															//-- Cauções Retidas

	oSecMed:lHeaderVisible := .T.
	TRCell():New(oSecMed,"CND_NUMMED","CND")
	TRCell():New(oSecMed,"CND_CONTRA","CND")
	TRCell():New(oSecMed,"CND_COMPET","CND")
	TRCell():New(oSecMed,"CND_DTVENC","CND")
	TRCell():New(oSecMed,"CND_VLMEAC","CND",,,,,{|| SECMED->(C031xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLMEAC"))})
	TRCell():New(oSecMed,"CND_VLSALD","CND",,,,,{|| SECMED->(C031xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLSALD"))})
	TRCell():New(oSecMed,"CND_VLTOT","CND",,,,,{|| SECMED->(C031xMoeda(CND_CONTRA,CND_REVISA,CND_NUMMED,"CND_VLTOT"))})

	oSecPla:lHeaderVisible := .T.
	TRCell():New(oSecPla,"CXN_NUMPLA"	,"CXN")
	TRCell():New(oSecPla,"CXN_TIPPLA"	,"CXN")
	TRCell():New(oSecPla,"FORCLI"		," ",STR0022,,TamSX3("A1_COD")[1],,{||If(Empty(SECPLA->CXN_FORNEC),SECPLA->CXN_CLIENT,SECPLA->CXN_FORNEC)} )
	TRCell():New(oSecPla,"LJFORCLI"		," ",RetTitle("A1_LOJA"),,TamSX3("A1_LOJA")[1],,{|| If(Empty(SECPLA->CXN_LJFORN),SECPLA->CXN_LJCLI,SECPLA->CXN_LJFORN)} )
	TRCell():New(oSecPla,"CXN_VLSALD"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLSALD"))})
	TRCell():New(oSecPla,"CXN_VLPREV"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLPREV"))})
	TRCell():New(oSecPla,"CXN_VLMULT"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLMULT"))})
	TRCell():New(oSecPla,"CXN_VLLIQD"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLLIQD"))})
	TRCell():New(oSecPla,"CXN_VLBONI"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLBONI"))})
	TRCell():New(oSecPla,"CXN_VLDESC"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLDESC"))})
	TRCell():New(oSecPla,"CXN_VLTOT"	,"CXN",,,,,{|| SECPLA->(C031xMoeda(CXN_CONTRA,CXN_REVISA,CXN_NUMMED,"CXN_VLTOT"))})

	oSecIMe:lHeaderVisible := .T.
	TRCell():New(oSecIMe,"CNE_ITEM","CNE")
	TRCell():New(oSecIMe,"CNE_PRODUT","CNE")
	TRCell():New(oSecIMe,"B1_DESC","SB1")
	TRCell():New(oSecIMe,"CNE_QTDSOL","CNE")
	TRCell():New(oSecIMe,"CNE_QTAMED","CNE")
	TRCell():New(oSecIMe,"CNE_QUANT","CNE")
	TRCell():New(oSecIMe,"CNE_PERC","CNE")
	TRCell():New(oSecIMe,"CNE_VLUNIT","CNE",,,,,{|| SECIME->(C031xMoeda(CNE_CONTRA,CNE_REVISA,CNE_NUMMED,"CNE_VLUNIT"))})
	TRCell():New(oSecIMe,"CNE_VLTOT","CNE",,,,,{|| SECIME->(C031xMoeda(CNE_CONTRA,CNE_REVISA,CNE_NUMMED,"CNE_VLTOT"))})

	If	mv_par13 != 2
		oSecMB:lHeaderVisible := .T.
		TRCell():New(oSecMB,"CNR_TIPO","CNR")
		TRCell():New(oSecMB,"CNR_DESCRI","CNR")
		TRCell():New(oSecMB,"CNR_VALOR","CNR",,,,,{|| SECMB->(C031xMoeda(CNR_CONTRA,SECMED->CND_REVISA,CNR_NUMMED,"CNR_VALOR"))})
	Endif

	If	mv_par12 != 2
		oSecDes:lHeaderVisible := .T.
		TRCell():New(oSecDes,"CNQ_TPDESC","CNQ")
		TRCell():New(oSecDes,"CNP_DESCRI","CNP")
		TRCell():New(oSecDes,"CNQ_VALOR","CNQ",,,,,{|| SECDES->(C031xMoeda(CNQ_CONTRA,SECMED->CND_REVISA,CNQ_NUMMED,"CNQ_VALOR"))})
	Endif

	If	mv_par14 != 2
		oSecCau:lHeaderVisible := .T.
		TRCell():New(oSecCau,"CNT_FORNEC","CNT")
		TRCell():New(oSecCau,"CNT_LJFORN","CNT")
		TRCell():New(oSecCau,"A2_NOME"," ",STR0022,,TamSX3("A1_NOME")[1],,{|| If(Empty(SECMED->CND_FORNEC),;
															Posicione("SA1",1,xFilial("SA1")+SECMED->(CND_CLIENT+CND_LOJACL),"A1_NOME"),;
															Posicione("SA2",1,xFilial("SA2")+SECMED->(CND_FORNEC+CND_LJFORN),"A2_NOME")) })
		TRCell():New(oSecCau,"CNT_VLRET","CNT",,,,,{|| SECCAU->(C031xMoeda(CNT_CONTRA,SECMED->CND_REVISA,CNT_NUMMED,"CNT_VLRET"))})
		TRCell():New(oSecCau,"CNT_VLBX","CNT",,,,,{|| SECCAU->(C031xMoeda(CNT_CONTRA,SECMED->CND_REVISA,CNT_NUMMED,"CNT_VLBX"))})
		TRCell():New(oSecCau,"CNT_DTBX","CNT")
	Endif

	oSecMB:SetTotalText("")
	oSecDes:SetTotalText("")
	oSecCau:SetTotalText("")

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrin
Impressao do relatorio de medições  
@param oReport, Objeto, estrutura do relatório
@return Nenhum
@author Andre Anjos
@since 26/08/2013
/*/
//-------------------------------------------------------------------
Static Function ReportPrin(oReport)

	Local oSecMed		:= oReport:Section(1)
	Local oSecPla		:= oSecMed:Section(1) 
	Local oSecIMe		:= oSecPla:Section(1) 
	Local oSecMB		:= oSecPla:Section(2) 
	Local oSecDes		:= oSecPla:Section(3)
	Local oSecCau		:= oSecPla:Section(4)


	Local cCNRValPic	:= GetSx3Cache( 'CNR_VALOR', "X3_PICTURE" )
	Local cCNQValPic	:= GetSx3Cache( 'CNQ_VALOR', "X3_PICTURE" )
	Local cCNTValPic	:= GetSx3Cache( 'CNT_VLRET', "X3_PICTURE" )
	Local cCNTVBxPic	:= GetSx3Cache( 'CNT_VLBX'	, "X3_PICTURE" )
	Local aParams		:= {}


	MakeSqlExp("CNR030")

	If ExistNvPerg()
		aAdd(aParams,MV_PAR20)
		aAdd(aParams,MV_PAR21)
	ElseIf !Empty(_cFilMed)
		aAdd(aParams,"(CND.CND_FILCTR = '" +_cFilMed+ "')")
		aAdd(aParams,"(CND.CND_REVISA = '" +_cRevMed+ "')")
	EndIF

	//-- Monta query da seção de medições
	oSecMed:BeginQuery()
	BeginSQL Alias "SECMED"

	SELECT CND.* 
	FROM %Table:CND% CND
	JOIN %Table:CN9% CN9 ON
		CN9.%NotDel% AND
		CN9.CN9_FILIAL = %xFilial:CN9% AND
		CN9.CN9_NUMERO = CND.CND_CONTRA AND
		CN9.CN9_REVISA = CND.CND_REVISA AND
		CN9.CN9_FILCTR = CND.CND_FILCTR
	WHERE CND.%NotDel% AND
		CND.CND_NUMMED BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		CN9.CN9_NUMERO BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
		CN9.CN9_DTINIC >= %Exp:DToS(mv_par05)% AND
		CN9.CN9_DTFIM <= %Exp:DToS(mv_par06)% AND
		CN9.CN9_SITUAC BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% AND
		(%Exp:mv_par11% = %Exp:CriaVar("CN9_TPCTO",.F.)% OR CN9.CN9_TPCTO = %Exp:mv_par11%) AND
		(CND.CND_FORNEC = %Exp:CriaVar("CND_FORNEC",.F.)% OR CND.CND_FORNEC BETWEEN %Exp:mv_par09% AND %Exp:mv_par10%) AND
		(CND.CND_CLIENT = %Exp:CriaVar("CND_CLIENT",.F.)% OR CND.CND_CLIENT BETWEEN %Exp:mv_par15% AND %Exp:mv_par16%) AND 
		CND.CND_NUMERO = ''

	EndSQL
	oSecMed:EndQuery(aParams)

	//-- Monta query da seção de Planilha Med. de Contratos
	BEGIN REPORT QUERY oSecPla

	BeginSQL Alias "SECPLA"

	SELECT CXN.*
	FROM %Table:CXN% CXN
	WHERE CXN.CXN_FILIAL = %report_param:SECMED->CND_FILIAL% AND
		CXN.CXN_NUMMED = %report_param:SECMED->CND_NUMMED% AND
		CXN.CXN_REVISA = %report_param:SECMED->CND_REVISA% AND
		CXN.%NotDel%

	EndSQL

	END REPORT QUERY oSecPla

	//-- Monta query da seção de itens da medição
	BEGIN REPORT QUERY oSecIMe
	BeginSQL Alias "SECIME"

	SELECT CNE.*
	FROM %Table:CNE% CNE
	WHERE CNE.CNE_FILIAL = %report_param:SECMED->CND_FILIAL% AND
		CNE.CNE_NUMMED = %report_param:SECMED->CND_NUMMED% AND
		CNE.CNE_REVISA = %report_param:SECMED->CND_REVISA% AND
		CNE.CNE_NUMERO = %report_param:SECPLA->CXN_NUMPLA% AND 
		CNE.%NotDel%

	EndSQL
	END REPORT QUERY oSecIMe

	//-- Monta query da seção de multas e bonificações da medição
	If mv_par13 == 2
		oSecMB:Hide()
	Else
	
		//Total por planilha
		BEGIN REPORT QUERY oSecMB
		BeginSQL Alias "SECMB"

		SELECT CNR.*
		FROM %Table:CNR% CNR
		WHERE CNR.CNR_FILIAL = %xFilial:CNR% AND
			CNR.CNR_NUMMED = %report_param:SECPLA->CXN_NUMMED% AND
			CNR.CNR_CODPLA = %report_param:SECPLA->CXN_NUMPLA% AND
			CNR.CNR_ITEM   = '' AND 
			CNR.%NotDel%

		EndSQL
		END REPORT QUERY oSecMB

		TRFunction():New(oSecMB:Cell("CNR_VALOR"),,"SUM",,STR0012,cCNRValPic,,.T.,.F.,,,{|| SECMB->CNR_TIPO == '1'}) //-- Total de Multas
		TRFunction():New(oSecMB:Cell("CNR_VALOR"),,"SUM",,STR0013,cCNRValPic,,.T.,.F.,,,{|| SECMB->CNR_TIPO == '2'}) //-- Total de Bonificações
		
	EndIf

	//-- Monta query da seção de descontos
	If	mv_par12 == 2
		oSecDes:Hide()
	Else

		//Total por planilha
		BEGIN REPORT QUERY oSecDes
		BeginSQL Alias "SECDES"

		SELECT CNQ.*
		FROM %Table:CNQ% CNQ
		WHERE CNQ.CNQ_FILIAL = %xFilial:CNQ% AND
			CNQ.CNQ_NUMMED = %report_param:SECPLA->CXN_NUMMED% AND
			CNQ.CNQ_NUMPLA = %report_param:SECPLA->CXN_NUMPLA% AND
			CNQ.%NotDel%

		EndSQL
		END REPORT QUERY oSecDes

		TRFunction():New(oSecDes:Cell("CNQ_VALOR"),,"SUM",,STR0025,cCNQValPic,,.T.,.F.) //-- Total de Descontos
		
	EndIf

	//-- Monta query da seção de cauções
	If	mv_par14 == 2
		oSecCau:Hide()
	Else
		BEGIN REPORT QUERY oSecCau
		BeginSQL Alias "SECCAU"

		SELECT CNT.*
		FROM %Table:CNT% CNT
		WHERE CNT.CNT_FILIAL = %xFilial:CNT% AND
			CNT.CNT_NUMMED = %report_param:SECPLA->CXN_NUMMED% AND
			CNT.CNT_NUMPLA = %report_param:SECPLA->CXN_NUMPLA% AND
			CNT.%NotDel%

		EndSQL
		END REPORT QUERY oSecCau

		TRFunction():New(oSecCau:Cell("CNT_VLRET"),,"SUM",,STR0023,cCNTValPic,,.T.,.F.) //-- Total Retido
		TRFunction():New(oSecCau:Cell("CNT_VLBX"),,"SUM",,STR0024,cCNTVBxPic,,.T.,.F.) //-- Total Retido
	EndIf

	TRPosition():New(oSecIMe,"SB1",1,{|| xFilial("SB1")+SECIME->CNE_PRODUT})

	If	mv_par12 != 2
		TRPosition():New(oSecDes,"CNP",1,{|| xFilial("CNP")+SECDES->CNQ_TPDESC})
	Endif

	oSecMed:Print()

	FwFreeArray(aParams)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} C031xMoeda
Realiza a conversao entre moedas de um determinado valor  
@param cContra, Caracter, Número do contrato
@param cRev, Caracter, Número da revisão
@param cNumMed, Caracter, Número da medição
@param cCampo, Caracter, Nome do campo
@return nRet, Númerico, Valor convertivo
@author Microsiga
@since 11/06/2011
/*/
//-------------------------------------------------------------------
Static Function C031xMoeda(cContra,cRev,cNumMed,cCampo)
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

/*/{Protheus.doc} ExistNvPerg
    Verifica se na base de dados existem os novos perguntes cadastrados no CNR030
@author jose.souza2
@since 20/03/2023
@return lResult, lógico, verdadeiro caso existam os novos perguntes cadastradados
*/

Static Function ExistNvPerg()
	Local oPergunte	:= Nil
	Local aPergunte	:= {}
	Local lRet		:= .F.

	oPergunte:= FwSX1Util():New()
	oPergunte:AddGroup("CNR030")
	oPergunte:SearchGroup()
	aPergunte:= oPergunte:GetGroup("CNR030")

	lRet:=  Len(aPergunte[2]) > 19 
		
	FwFreeArray(aPergunte)
	FwFreeObj(oPergunte)
	

Return lRet
