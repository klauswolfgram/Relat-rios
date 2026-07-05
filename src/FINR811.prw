/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'Protheus.ch'
#INCLUDE 'FINR811.CH'

Static __cTabFWT	:= ""
Static __cTabSE1A	:= ""
Static __lFIN811R	:= .T.

/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} FINR811
Relatório carta de cobrança sintético
@author Rodrigo Pirolo
@since 17/08/15
/*/ 
/*--------------------------------------------------------------------------------------------------------------------*/

User Function FINR811(lProcesso As Logical,cComboVenc As Character) As Logical

	Local oReport	As Object
	Local aArea		As Array
	Local cPerg		As Character // Nome do grupo de perguntas

	Private dBaixa		As Date
	Private lFina811	As Logical
	Private lRelSint	As Logical
	Private cLayout		As Character

	Default lProcesso  := .F.
	Default cComboVenc := ''
	
	If !TableInDic("FWP") .OR. !TableInDic("FWQ") .OR. !TableInDic("FWS") .OR. !TableInDic("FWT") 
        MsgNextRel() //-- É necessário a atualização do sistema para a expedição mais recente
        Return()	
	EndIf

	If !lProcesso .And. GetHlpLGPD({"A1_NOME", "E1_NOMCLI"})
		Return .F.
	Endif

	aArea	:= GetArea()
	cPerg	:= "FINR810"
	
	/***************************************\
	|* MV_PAR01 = Layout de:               *|
	|* MV_PAR02 = Layout Até:              *|
	|* MV_PAR03 = Dt Envio de:             *|
	|* MV_PAR04 = Dt Envio até:            *|
	|* MV_PAR05 = Cliente de:              *|
	|* MV_PAR06 = Loja de:                 *|
	|* MV_PAR07 = Cliente até:             *|
	|* MV_PAR08 = Loja até:                *|
	|* MV_PAR09 = Imprime: 1=Analitico     *|
	|*					   2=Sintetico	   *|
	\***************************************/
	If Pergunte( cPerg, .T. )

		lFina811    := lProcesso
		cComboVenc  := cComboVenc
		lRelSint	:= MV_PAR09 == 2
	

		If lRelSint
			oReport := ReportDef()
			oReport:PrintDialog()
		Else
			FINR811A()
		EndIf

	EndIf

	RestArea(aArea)

Return .T.

/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} ReportDef
Definicao do objeto do relatorio personalizavel e das secoes que serao utilizadas.
@return oReport 
@author Rodrigo Pirolo
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/

Static Function ReportDef() As Object

	Local oReport	As Object
	Local oSection	As Object
	Local oSection1	As Object
	Local cReport 	As Character // Nome do relatorio
	Local cTitulo 	As Character //"Carta de Cobrança"
	Local cDescri 	As Character //"Carta de Cobrança"
	Local cPerg		As Character // Nome do grupo de perguntas
	Local n1		As Logical
	Local aCels		As Array

	aCels	:= {}

	cReport	:= "FINR811"
	cTitulo	:= STR0001
	cDescri	:= STR0001
	cPerg	:= "FINR810"

	__cTabFWT := GetNextAlias()
	__cTabSE1A:= GetNextAlias()

	/***************************************\
	|* MV_PAR01 = Layout de:               *|
	|* MV_PAR02 = Layout Até:              *|
	|* MV_PAR03 = Dt Envio de:             *|
	|* MV_PAR04 = Dt Envio até:            *|
	|* MV_PAR05 = Cliente de:              *|
	|* MV_PAR06 = Loja de:                 *|
	|* MV_PAR07 = Cliente até:             *|
	|* MV_PAR08 = Loja até:                *|
	|* MV_PAR09 = Imprime: 1=Analitico     *|
	|*					   2=Sintetico	   *|
	\***************************************/
	Pergunte(cPerg,.F.)

	oReport := TReport():New(cReport, cTitulo, cPerg, {|oReport| ReportPrint(oReport)}, cDescri)

	oReport:SetLandscape()	//Imprime o relatorio no formato paisagem


	If lFina811
		oReport:lParamPage 		:= .F.
		oReport:lParamReadOnly	:= .T.
	EndIf

	aCels := MontaCel()

	// Secao principal
	oSection := TRSection():New(oReport, STR0002 , {"FWT","SE1"})	//"CABECALHO"

	oSection:SetHeaderSection(.T.)	//Não imprime o cabecalho da secao
	oSection:SetPageBreak(.T.)		//Salta a pagina na quebra da secao

	// Secao 01
	oSection1 := TRSection():New(oSection, STR0003 , {"FWT","SE1"})	//"Titulos Vencidos"
	For n1 := 1 To Len (aCels)
		TRCell():New(oSection1, aCels[N1][1], aCels[N1][2], aCels[N1][3], aCels[N1][4], aCels[N1][5],/*lPixel*/,/*CodeBlock*/)
	Next n1

	TRBreak():New(oSection, {|| (__cTabFWT)->E1_CLIENTE },/**/,/*lTotalInLine*/.F.,/*cNameBrk*/,.T.,.F.,.T.)

	oSection1:Cell("TOTAL"):SetHeaderAlign("RIGHT")

Return oReport

/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} ReportPrint
Imprime o objeto oReport definido na funcao ReportDef
@author Rodrigo Pirolo
@param oReport - Objeto para impressão definido pela função ReportDef
@return oReport 
@since 17/08/15
/*/
/*--------------------------------------------------------------------------------------------------------------------*/

Static Function ReportPrint(oReport As Object)

	Local oSection	As Object //Cabeçalho
	Local oSection1 As Object //"Titulos Vencidos"

	Local cQuery	As Character
	Local cNome		As Character
	Local cCliLj	As Character
	Local cConcat	As Character
	Local cStatus	As Character
	Local cModelo	As Character
	Local cDias		As Character
	Local cFilFWT	As Character

	Local nJuros	As Numeric
	Local nMulta	As Numeric
	Local nX		As Numeric
	Local nAbat		As Numeric
	Local nPosProc	As Numeric

	Local cMvPar01	As Character
	Local cMvPar02	As Character
	Local dMvPar03	As Character
	Local dMvPar04	As Character
	Local cMvPar05	As Character
	Local cMvPar06	As Character
	Local cMvPar07	As Character
	Local cMvPar08	As Character

	Local aStatus	As Array

	oSection	:= oReport:Section(STR0002)
	oSection1	:= oReport:Section(STR0002):Section(STR0003)

	cNome	:= ""
	cCliLj	:= ""
	cConcat	:= If( Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX", "||", "+")
	cStatus	:= ""
	cModelo	:= ""
	cDias	:= ""
	cFilFWT	:= ""
	cQuery	:=""

	nJuros	:= 0
	nMulta	:= 0
	nX		:= 0
	nAbat	:= 0
	nPosProc:= 0

	cMvPar01:= MV_PAR01
	cMvPar02:= MV_PAR02
	dMvPar03:= MV_PAR03
	dMvPar04:= MV_PAR04
	cMvPar05:= MV_PAR05
	cMvPar06:= MV_PAR06
	cMvPar07:= MV_PAR07
	cMvPar08:= MV_PAR08

	aStatus	:= StrTokArr( U_FR811Descr(), ";" )


	DbSelectArea("SA1")
	DbSelectArea("FWP")
	
	__lFIN811R := F811RetRep( .F. )

	If lFina811 .And. !__lFIN811R 
		cMvPar01 := aReport[1][4]
		cMvPar02 := aReport[Len(aReport)][4]
		dMvPar03 := dDataBase
		dMvPar04 := dDataBase
		cMvPar05 := aReport[1][1]
		cMvPar06 := aReport[1][2]
		cMvPar07 := aReport[Len(aReport)][1]
		cMvPar08 := aReport[Len(aReport)][2]
	EndIf

	SE1->(DbGoTop())
	FK7->(DbGoTop())

	cQuery += " AND SE1.E1_FILIAL + '|' + SE1.E1_PREFIXO + '|' + SE1.E1_NUM + '|' + SE1.E1_PARCELA +"
	cQuery += " '|' +  SE1.E1_TIPO + '|' +  SE1.E1_CLIENTE + '|' +  SE1.E1_LOJA = FK7.FK7_CHAVE "
	cQuery := "%" + StrTran(cQuery,"+",cConcat) + "%"

	//Inicia query de processos
	oSection:BeginQuery()
	BeginSql Alias __cTabFWT
		SELECT DISTINCT
		FWT.FWT_FILIAL,	FWT.FWT_LAYOUT,	FWT.FWT_PROCES, FWT.FWT_DTREFE, FWT.FWT_STATUS, FWT.FWT_DTENVI, FWT.FWT_FILLYT, 
		SE1.E1_CLIENTE, SE1.E1_FILORIG
		FROM
		%table:SE1% SE1, %table:FWT% FWT, %table:FK7% FK7
		WHERE
		FWT.FWT_LAYOUT	BETWEEN %Exp:cMvPar01% and %Exp:cMvPar02% AND
		FWT.FWT_DTENVI	BETWEEN %Exp:dMvPar03% and %Exp:dMvPar04% AND
		SE1.E1_CLIENTE	BETWEEN %Exp:cMvPar05% and %Exp:cMvPar07% AND
		SE1.E1_LOJA   	BETWEEN %Exp:cMvPar06% and %Exp:cMvPar08% AND
		FWT.FWT_CHAVE = FK7.FK7_IDDOC AND
		SE1.%notDel% AND FWT.%notDel% AND FK7.%notDel%
		%Exp:cQuery%
		ORDER BY E1_CLIENTE, FWT.FWT_PROCES
	EndSql
	oSection:EndQuery()

	oSection1:BeginQuery()
	BeginSql Alias __cTabSE1A
		SELECT
		FWT.FWT_FILIAL,	FWT.FWT_LAYOUT,	FWT.FWT_PROCES, FWT.FWT_DTREFE, FWT.FWT_STATUS, FWT.FWT_DTENVI, FWT.FWT_FILLYT, 
		SE1.E1_VENCREA,	SE1.E1_CLIENTE, SE1.R_E_C_N_O_ AS RecNoSE1
		FROM
		%table:SE1% SE1, %table:FWT% FWT, %table:FK7% FK7
		WHERE
		FWT.FWT_LAYOUT	BETWEEN %Exp:cMvPar01% and %Exp:cMvPar02% AND
		FWT.FWT_DTENVI	BETWEEN %Exp:dMvPar03% and %Exp:dMvPar04% AND
		SE1.E1_CLIENTE	BETWEEN %Exp:cMvPar05% and %Exp:cMvPar07% AND
		SE1.E1_LOJA   	BETWEEN %Exp:cMvPar06% and %Exp:cMvPar08% AND
		FWT.FWT_CHAVE = FK7.FK7_IDDOC AND
		SE1.%notDel% AND FWT.%notDel% AND FK7.%notDel%
		%Exp:cQuery%
		ORDER BY SE1.E1_CLIENTE, FWT.FWT_PROCES, FWT.FWT_DTENVI, SE1.E1_VENCREA, FWT.FWT_DTREFE
	EndSql
	oSection1:EndQuery()

	If lFina811
		oSection1:Cell("FWT_STATUS"):Disable()
		oSection1:Cell("E1_CLIENTE"):Disable()
		oSection1:Cell("NOME"):Disable()
		oSection1:Cell("FWT_DTENVI"):Disable()
		oSection1:Cell("LAYOUT"):Disable()
	EndIf

	oReport:SkipLine()
	oSection:Init()
	lFirst := .T.

	While (__cTabFWT)->(!EoF())

		If lFina811
			//Busca os que serão impressos os processos
			nPosProc := aScan(aReport, { |x| x[3] == (__cTabFWT)->FWT_PROCES } )

			If nPosProc = 0
				(__cTabFWT)->(dbskip())
				Loop
			EndIf
		EndIf

		cFilFWT	:= (__cTabFWT)->FWT_FILIAL
		cLayout	:= (__cTabFWT)->FWT_LAYOUT
		cProcess:= (__cTabFWT)->FWT_PROCES
		dBaixa	:= (__cTabFWT)->FWT_DTREFE

		While (__cTabSE1A)->(!EoF())
			If (__cTabSE1A)->FWT_PROCES == cProcess .and.;
					(__cTabSE1A)->FWT_FILIAL == cFilFWT .and.;
					(__cTabSE1A)->FWT_LAYOUT == cLayout
				If lFirst
					oSection1:Init()
					lFirst:= .F.
				EndIf

				SE1->(DBGOTO((__cTabSE1A)->RecNoSE1))

				nAbat := F811AbatRec()

				nJuros	:= fa070Juros(SE1->E1_MOEDA,SE1->E1_SALDO - nAbat,,)
				nMulta	:= F811RMul(SE1->E1_VALOR,SE1->E1_SALDO - nAbat,SE1->E1_VENCREA,dBaixa,SE1->(Recno()))

				cNome	:= AllTrim( Posicione('SA1', 1, xFilial( 'SA1' ) + SE1->E1_CLIENTE + SE1->E1_LOJA , 'A1_NOME') )

				cModelo	:= AllTrim( Posicione('FWP', 1, xFilial( 'FWP', (__cTabSE1A)->FWT_FILLYT ) + (__cTabSE1A)->FWT_LAYOUT , 'FWP_DESCRI') )

				oSection1:Cell("NOME"):SetBlock( { || cNome } )
				oSection1:Cell("E1_SALDO"):SetBlock( { || SE1->E1_SALDO - nAbat })
				oSection1:Cell("E1_MULTA"):SetBlock( { || nMulta } )
				oSection1:Cell("E1_JUROS"):SetBlock( { || nJuros } )
				oSection1:Cell("TOTAL"):SetBlock( { || (nMulta+nJuros+SE1->(E1_SALDO+E1_MULTA+E1_SDACRES-E1_SDDECRE)) - nAbat} )
				oSection1:Cell("MODELO"):SetBlock( { || cModelo } )

				If (__cTabFWT)->FWT_STATUS == "1"
					cStatus:= aStatus[1]
				ElseIf (__cTabFWT)->FWT_STATUS == "2"
					cStatus:= aStatus[2]
				ElseIf (__cTabFWT)->FWT_STATUS == "3"
					cStatus:= aStatus[3]
				ElseIf (__cTabFWT)->FWT_STATUS == "4"
					cStatus:= aStatus[4]
				ElseIf (__cTabFWT)->FWT_STATUS == "5"
					cStatus:= aStatus[5]
				Else
					cStatus:= STR0022 // STR0022 "Carta Impressa"
				EndIf

				oSection1:Cell("FWT_STATUS"):SetBlock( { || cStatus } )

				If SE1->E1_VENCREA > (__cTabFWT)->FWT_DTREFE
					cDias	:= "-" + CValToChar(FRClcDias(SE1->E1_VENCREA,FWT->FWT_DTREFE))
					oSection1:Cell("DIAS"	 ):SetBlock( { || STR0019 } )//STR0019 "A Vencer"
					oSection1:Cell("DIAS2"	 ):SetBlock( { || cDias } )
				Else
					cDias	:= CValToChar(FRClcDias(SE1->E1_VENCREA,FWT->FWT_DTREFE))
					oSection1:Cell("DIAS"	 ):SetBlock( { || STR0020 } )//STR0020 "Vencido"
					oSection1:Cell("DIAS2"	 ):SetBlock( { || cDias } )
				EndIf

				oSection1:PrintLine(.T.)
			Else
				Exit
			EndIf
			(__cTabSE1A)->( DbSkip() )
		EndDo
	
		(__cTabFWT)->( DbSkip() )
	EndDo

	If !lFirst
		oSection1:Finish()
		lFirst := .T.
	EndIf

	oSection:Finish()

Return

/*------------------------------------------------*/
/*/{Protheus.doc} MontaCel
Monta um Array de Acordo com o tipo de Relatório
@author Jacomo Lisa
@since 17/08/15
/*/
/*------------------------------------------------*/
Static Function MontaCel() As Array
	Local aCels	As Array

	aCels	:= {}

	aADD(aCels, {"E1_CLIENTE","SE1" ,SX3->(RetTitle("E1_CLIENTE")),PesqPict("SE1","E1_CLIENTE"),TamSX3("E1_CLIENTE")[1] + 8	})
	aADD(aCels, {"NOME"		 ,"SE1" ,SX3->(RetTitle("A1_NOME")),PesqPict("SA1","A1_NOME"),TamSX3("A1_NOME")[1]		})
	aADD(aCels, {"E1_PREFIXO","SE1" ,SX3->(RetTitle("E1_PREFIXO")),PesqPict("SE1","E1_PREFIXO"),TamSX3("E1_PREFIXO")[1]		})
	aADD(aCels, {"E1_NUM"    ,"SE1" ,SX3->(RetTitle("E1_NUM"    )),PesqPict("SE1","E1_NUM"    ),TamSX3("E1_NUM"    )[1] + 4	})
	aADD(aCels, {"E1_PARCELA","SE1" ,SX3->(RetTitle("E1_PARCELA")),PesqPict("SE1","E1_PARCELA"),TamSX3("E1_PARCELA")[1]		})
	aADD(aCels, {"E1_EMISSAO","SE1" ,SX3->(RetTitle("E1_EMISSAO")),PesqPict("SE1","E1_EMISSAO"),TamSX3("E1_EMISSAO")[1]	+ 2	})
	aADD(aCels, {"E1_VENCREA","SE1" ,SX3->(RetTitle("E1_VENCREA")),PesqPict("SE1","E1_VENCREA"),TamSX3("E1_VENCREA")[1]	+ 2	})
	aADD(aCels, {"DIAS"      ,"SE1" ,STR0018					  ,PesqPict("SE1","E1_NUM"    ),TamSX3("E1_NUM"    )[1]		})//STR0018 "Sit. do Título"
	aADD(aCels, {"DIAS2"     ,"SE1" ,STR0005					  ,PesqPict("SE1","E1_NUM"    ),TamSX3("E1_NUM"    )[1]		})//STR0018 "Sit. do Título"
	aADD(aCels, {"E1_VALOR"  ,"SE1" ,SX3->(RetTitle("E1_VALOR"  )),PesqPict("SE1","E1_VALOR"  ),TamSX3("E1_VALOR"  )[1]		})
	aADD(aCels, {"E1_SALDO"  ,"SE1" ,SX3->(RetTitle("E1_SALDO"  )),PesqPict("SE1","E1_SALDO"  ),TamSX3("E1_SALDO"  )[1]		})
	aADD(aCels, {"E1_MULTA"  ,"SE1" ,SX3->(RetTitle("E1_MULTA"  )),PesqPict("SE1","E1_MULTA"  ),TamSX3("E1_MULTA"  )[1]		})
	aADD(aCels, {"E1_JUROS"  ,"SE1" ,SX3->(RetTitle("E1_JUROS"  )),PesqPict("SE1","E1_JUROS"  ),TamSX3("E1_JUROS"  )[1]		})
	aADD(aCels, {"E1_SDACRES","SE1" ,SX3->(RetTitle("E1_SDACRES")),PesqPict("SE1","E1_SDACRES"),TamSX3("E1_SDACRES")[1]		})
	aADD(aCels, {"E1_SDDECRE","SE1" ,SX3->(RetTitle("E1_SDDECRE")),PesqPict("SE1","E1_SDDECRE"),TamSX3("E1_SDDECRE")[1]		})
	aADD(aCels, {"TOTAL"	 ,"SE1" ,STR0008					  ,PesqPict("SE1","E1_SALDO"  ),TamSX3("E1_SALDO"  )[1]		})
	aADD(aCels, {"FWT_STATUS","FWT" ,SX3->(RetTitle("FWT_STATUS")),PesqPict("FWT","FWT_STATUS"),TamSX3("E1_NUM"  )[1]+26	})
	aADD(aCels, {"MODELO"	,		,STR0021					  ,PesqPict("FWP","FWP_DESCRI"),TamSX3("FWP_DESCRI")[1]+30	})

Return aCels

/*--------------------------------------------------------------------------------------------------------------------*/
/*/{Protheus.doc} FR811Descr
Função que retorna as opções de "combo" para o campo FWT_STATUS, permitindo que o status do envio da carta por e-mail
seja exibido no relatório, correspondente ao valor armazenado no campo. As opções do "combo" ficam armazenadas no
FINR811.CH. Havendo a inclusão de mais status de envio, esses novos status devem ser cadastrados no .ch.

@author Pedro Pereira Lima
@since 02/08/2016
/*/
/*--------------------------------------------------------------------------------------------------------------------*/
User Function FR811Descr() As Character

	Local cRet As Character

	cRet := STR0013 + ";" + STR0014 + ";" + STR0015 + ";" + STR0016 + ";" + STR0017 + ";"

Return cRet
