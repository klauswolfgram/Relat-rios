/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWBROWSE.CH"
#INCLUDE "FINR940.CH"

Static _oFINR9401

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR940
Relação de Titulos a Receber com Retenção PIS / COFINS e CSLL

@author  Fabio V Santana
@version P12
@since   24/06/2015
/*/
//-------------------------------------------------------------------
User Function FINR940()

Pergunte( "FIN940", .F. )
ReportDef()            

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Criacao dos componentes de impressao

@author  Fabio V Santana
@version P12
@since   24/06/2015
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local oFilial
Local oReport   := Nil
Local oSection1 := Nil
Local oSection2 := Nil
Local cTitle    := STR0001  //"Relação de Titulos a Receber com Retenção PIS / COFINS e CSLL"

If Type("cAliasTrb") == "U"
	PRIVATE cAliasTrb	:=	GetNextAlias()
Else
	cAliasTrb	:=	GetNextAlias()
EndIf

oReport := TReport():New("FINR940",cTitle,"FIN940", {|oReport| ReportPrint(oReport)},STR0002) //"Relatório utilizado pelo usuário para levantar a retenções de PIS / COFINS e CSLL dos clientes afim de confirmar os valores das retenções" 
oReport:SetLandscape()

oReport:lHeaderVisible := .T.

oFilial:= TRSection():New(oReport,STR0003,{"SM0"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/,,,,.T.) // Filial
oFilial:SetReadOnly()
oFilial:SetNoFilter("SM0")

oSection1:= TRSection():New(oReport,STR0004,{cAliasTrb,"SA1"},/*aOrdem*/) // "Dados do Cliente
oSection1:SetNoFilter("SA1")

TRCell():New(oSection1,"TRB_FILIAL"  ,cAliasTrb,STR0003 ,/*Picture*/,TamSx3("A1_FILIAL")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //Filial
TRCell():New(oSection1,"TRB_CODCLI"  ,cAliasTrb,STR0005 ,/*Picture*/,TamSx3("A1_COD")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"Código"
TRCell():New(oSection1,"TRB_LOJA"	  ,cAliasTrb,STR0006	,/*Picture*/,TamSx3("A1_LOJA")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"Loja"	
TRCell():New(oSection1,"TRB_NOME"	  ,cAliasTrb,STR0007	,/*Picture*/,TamSx3("A1_NOME")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Cliente"
TRCell():New(oSection1,"TRB_CNPJ" 	  ,cAliasTrb,STR0008	,/*Picture*/,TamSx3("A1_CGC")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"CNPJ"

oSection1:SetTotalInLine(.F.)

//Secao - Resumo de títulos
oSection2:= TRSection():New(oSection1,STR0009,{cAliasTrb,"SE1","SA1"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Títulos

TRCell():New(oSection2,"TRB_ID"  		,cAliasTrb,STR0010,/*Picture*/					 	,TamSx3("A1_COD")[1]+TamSx3("A1_LOJA")[1]+TamSx3("A1_NOME")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"ID"
TRCell():New(oSection2,"TRB_PREFIX"  	,cAliasTrb,STR0011,PesqPict("SE1","E1_PREFIXO")	,/*Tamanho*/			  	 	,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Prf"
TRCell():New(oSection2,"TRB_NUM"		,cAliasTrb,STR0012,PesqPict("SE1","E1_NUM")	 	,TamSx3("E1_NUM")[1] 	 	,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Número"
TRCell():New(oSection2,"TRB_PARCEL" 	,cAliasTrb,STR0013,PesqPict("SE1","E1_PARCELA")	,TamSx3("E1_PARCELA")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Pc"
TRCell():New(oSection2,"TRB_TIPO"  	,cAliasTrb,STR0014,PesqPict("SE1","E1_TIPO")	 	,TamSx3("E1_TIPO")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Tipo"
TRCell():New(oSection2,"TRB_DTEMIS"	,cAliasTrb,STR0015,/*Picture*/ 					 	,TamSx3("E1_EMISSAO")[1]+2		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Dt. Emissão"
TRCell():New(oSection2,"TRB_DTVCTO" 	,cAliasTrb,STR0016,/*Picture*/ 					 	,TamSx3("E1_VENCREA")[1]+2		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Dt Vencto"
TRCell():New(oSection2,"TRB_VALORI"	,cAliasTrb,STR0017,PesqPict("SE1","E1_VALOR")	 	,TamSx3("E1_VALOR")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor Original"
TRCell():New(oSection2,"TRB_VALIR"		,cAliasTrb,STR0018,PesqPict("SE1","E1_IRRF")	 	,TamSx3("E1_IRRF")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor IRRF"
TRCell():New(oSection2,"TRB_VALISS" 	,cAliasTrb,STR0019,PesqPict("SE1","E1_ISS")	 	,TamSx3("E1_ISS")[1]			,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor ISS"
TRCell():New(oSection2,"TRB_VALINS"  	,cAliasTrb,STR0020,PesqPict("SE1","E1_INSS")	 	,TamSx3("E1_INSS")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor INSS"
TRCell():New(oSection2,"TRB_VALPIS" 	,cAliasTrb,STR0021,PesqPict("SE1","E1_PIS")	 	,TamSx3("E1_PIS")[1]			,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor PIS"
TRCell():New(oSection2,"TRB_VALCOF"  	,cAliasTrb,STR0022,PesqPict("SE1","E1_COFINS") 	,TamSx3("E1_COFINS")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor COFINS"
TRCell():New(oSection2,"TRB_VALCSL"  	,cAliasTrb,STR0023,PesqPict("SE1","E1_CSLL")	 	,TamSx3("E1_CSLL")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor CSLL"
TRCell():New(oSection2,"TRB_VALLIQ"  	,cAliasTrb,STR0024,PesqPict("SE1","E1_SALDO")	 	,TamSx3("E1_SALDO")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/,/*cAligne*/,/*lLineBreak*/,"RIGHT") //"Valor Liquido"

//Quebra por Cliente + Loja + Nome
oSection2:SetTotalInLine(.F.)

TRFunction():New(oSection2:Cell("TRB_DTVCTO")	,NIL,"COUNT",,STR0025,/*cPicture*/,/*uFormula*/,.T.,.T.) //"Total de títulos"
TRFunction():New(oSection2:Cell("TRB_VALORI")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALIR")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALISS")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALINS")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALPIS")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALCOF")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALCSL")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 
TRFunction():New(oSection2:Cell("TRB_VALLIQ")	,NIL,"SUM",,,/*cPicture*/,/*uFormula*/,.T.,.T.) 

If !isBlind()
	oReport:PrintDialog()
EndIf

Return(oReport)

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Relação de Titulos a Receber com Retenção PIS / COFINS e CSLL

@author  Fabio V Santana
@version P12
@since   24/06/2015
/*/
//-------------------------------------------------------------------
Static Function ReportPrint( oReport )

Local oFilial   := oReport:Section(1)
Local oSection1 := oReport:Section(2)
Local oSection2	:= oReport:Section(2):Section(1)
Local aTrbs 	:= {}
Local oTFont    := TFont():New('Arial',,09,,.T.)

Local lPendRet 	:= .F.
Local lTitRtImp	:= .F.
Local nValorLiq := 0

//Controla o Pis Cofins e Csll na RA (1 = Controla retenção de impostos no RA; ou 2 = Não controla retenção de impostos no RA(default))
Local lRaRtImp  := FRaRtImp()
//Controla o Pis Cofins e Csll na baixa (1-Retem PCC na Baixa ou 2-Retem PCC na Emissão(default))
Local lPccBxCr	:= FPccBxCr()
Local nPis		:= 0
Local nCofins	:= 0
Local nCsll		:= 0
Local nIss      := 0
Local nIrrf     := 0
Local nInss     := 0
Local nX		:= 0
Local aFilsCalc := {}
Local nForFilial:= 0
Local aAreaSM0  := SM0->(GetArea())
Local cFilBkp   := cFilAnt
Local cAliasQry := GetNextAlias()
Local lPccIdv 	:= SED->(ColumnPos("ED_PCCINDV")) > 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona Filiais?³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par09==1 
	aFilsCalc := MatFilCalc(.T.)
Else
	aFilsCalc := {{.T.,cFilAnt}}
EndIf

For nForFilial := 1 To Len(aFilsCalc)

	If aFilsCalc[ nForFilial, 1 ]		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciono na filial selecionada ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFilAnt := aFilsCalc[ nForFilial, 2 ]
    	SM0->( DbSetOrder(1) )
		SM0->( DbSeek( cEmpAnt + cFilAnt ) )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Função da query principal³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cAliasQry   := GetNextAlias()	
		cAliasQry	:=	GetQuery(cAliasQry,cFilAnt)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Criação da TRB³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		aTrbs	:= CriaTrb()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Desabilito a celula ID ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		oSection2:Cell("TRB_ID"):Disable()
						
		TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1") + (cAliasTrb)->TRB_CODCLI + (cAliasTrb)->TRB_LOJA})
		TRPosition():New(oSection2,"SE1",1,{|| xFilial("SE1") + (cAliasTrb)->TRB_PREFIX + (cAliasTrb)->TRB_NUM + (cAliasTrb)->TRB_PARCEL + (cAliasTrb)->TRB_TIPO })
		
		While !(cAliasQry)->(Eof())
			
			If (cAliasQry)->A1_RECISS == "2" .And. GetNewPar("MV_DESCISS",.F.) == .T. .And.;
					((cAliasQry)->E1_IRRF+(cAliasQry)->E1_INSS+(cAliasQry)->E1_PIS+(cAliasQry)->E1_COFINS+(cAliasQry)->E1_CSLL) == 0
				(cAliasQry)->(dbSkip())
				Loop
			EndIf
			
			RecLock(cAliasTrb, .T.)
			(cAliasTrb)->TRB_ID		:= 	(cAliasQry)->E1_CLIENTE + (cAliasQry)->E1_LOJA + (cAliasQry)->A1_NOME
			(cAliasTrb)->TRB_CODCLI	:=	(cAliasQry)->E1_CLIENTE
			(cAliasTrb)->TRB_LOJA	:=	(cAliasQry)->E1_LOJA
			(cAliasTrb)->TRB_NOME	:=	(cAliasQry)->A1_NOME
			(cAliasTrb)->TRB_CNPJ	:=	(cAliasQry)->A1_CGC
			(cAliasTrb)->TRB_FILIAL	:= 	(cAliasQry)->E1_FILIAL 
			
			lPendRet  := .F.
			lTitRtImp := .F.
			If ChkAbtImp((cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,(cAliasQry)->E1_MOEDA,"V",(cAliasQry)->E1_BAIXA) > 0
				lTitRtImp := .T.
			EndIf
			If lPccIdv
				If ((cAliasQry)->E1_SABTCOF + (cAliasQry)->E1_SABTCSL +	(cAliasQry)->E1_SABTPIS) > 0 .and. (cAliasQry)->ED_PCCINDV <> "1"
					lPendRet := .T.
				Endif
			Else
				If ((cAliasQry)->E1_SABTCOF + (cAliasQry)->E1_SABTCSL +	(cAliasQry)->E1_SABTPIS) > 0 
					lPendRet := .T.
				Endif
			Endif	
			If	lTitRtImp .and. !lPendRet
				nPis		:= (cAliasQry)->E1_PIS
				nCofins	:= (cAliasQry)->E1_COFINS
				nCsll		:= (cAliasQry)->E1_CSLL
				nValorLiq 	:= (cAliasQry)->(E1_VALOR - E1_IRRF - E1_INSS - E1_PIS- E1_COFINS - E1_CSLL)
			Else
				nPis		:= 0
				nCofins	:= 0
				nCsll		:= 0
				nValorLiq:= (cAliasQry)->(E1_VALOR - E1_IRRF - E1_INSS)
			Endif
			If lPccBxCr
				nPis		:= 0
				nCofins	:= 0
				nCsll		:= 0
				If (cAliasQry)->E1_SALDO == (cAliasQry)->E1_VALOR //Ainda não houve baixa, exibo os valores que serão retidos através de AB-
					nPis		:= (cAliasQry)->E1_PIS
					nCofins	:= (cAliasQry)->E1_COFINS
					nCsll		:= (cAliasQry)->E1_CSLL
				Else
					U_FVPccBxCr ((cAliasQry)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA),@nPis,@nCofins,@nCsll)
					If lRaRtImp .AND. ((cAliasQry)->E1_TIPO $ MVRECANT)
						nValorLiq:= (cAliasQry)->(E1_VALOR - E1_IRRF - E1_INSS )
					Else
						nValorLiq:= (cAliasQry)->(E1_VALOR - E1_IRRF - E1_INSS - nPis - nCofins - nCsll)
					EndIf
				EndIf
			Endif
			
			If (cAliasQry)->A1_RECISS == "1" .And. GetNewPar("MV_DESCISS",.F.) == .T.
				nValorLiq -= F940iriss((cAliasQry)->(E1_PREFIXO+E1_NUM+E1_PARCELA+'IS-'))
			EndIf
			
			(cAliasTrb)->TRB_PREFIX 	:= (cAliasQry)->E1_PREFIXO
			(cAliasTrb)->TRB_NUM 	:= (cAliasQry)->E1_NUM
			(cAliasTrb)->TRB_PARCEL 	:= (cAliasQry)->E1_PARCELA
			(cAliasTrb)->TRB_TIPO 	:= (cAliasQry)->E1_TIPO
			(cAliasTrb)->TRB_DTEMIS 	:= (cAliasQry)->E1_EMISSAO
			(cAliasTrb)->TRB_DTVCTO 	:= (cAliasQry)->E1_VENCREA
			(cAliasTrb)->TRB_VALORI	:=	(cAliasQry)->E1_VALOR
			
			// VERIFICAÇÃO IRRF MANUAL
			IF (cAliasQry)->E1_IRRF == 0
			   nIrrf := F940iriss((cAliasQry)->(E1_PREFIXO+E1_NUM+E1_PARCELA+'IR-'))
			   (cAliasTrb)->TRB_VALIR := nIrrf
			Else
				//nIrrf := (cAliasQry)->E1_IRRF
			   (cAliasTrb)->TRB_VALIR :=  (cAliasQry)->E1_IRRF
			Endif
			
				
			If "MATA" $ (cAliasQry)->E1_ORIGEM
				DbSelectArea("SE2")
				SE2->(DbSetOrder(1))
				
				If SE2->(DbSeek((cAliasQry)->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+PADR("TX",len((cAliasQry)->E1_TIPO))+PADR("MUNIC",Len((cAliasQry)->E1_CLIENTE))+PADR("00", LEN((cAliasQry)->E1_LOJA)))))
					(cAliasTrb)->TRB_VALISS :=	0
				Else
					(cAliasTrb)->TRB_VALISS  := IIf((cAliasQry)->A1_RECISS=="2",0,(cAliasQry)->E1_ISS)
				EndIf
			Else
				(cAliasTrb)->TRB_VALISS  := IIf((cAliasQry)->A1_RECISS=="2",0,(cAliasQry)->E1_ISS)
			EndIf
						
			//VERIFICACAO ISS MANUAL
			IF (cAliasTrb)->TRB_VALISS == 0
			   nIss := F940iriss((cAliasQry)->(E1_PREFIXO+E1_NUM+E1_PARCELA+'IS-'))
			   (cAliasTrb)->TRB_VALISS := nIss
			Endif				 	
			//
			
			nInss := (cAliasQry)->E1_INSS
			
			(cAliasTrb)->TRB_VALINS := nInss
			(cAliasTrb)->TRB_VALPIS := nPis
			(cAliasTrb)->TRB_VALCOF := nCofins
			(cAliasTrb)->TRB_VALCSL := nCsll
			
				(cAliasTrb)->TRB_VALLIQ := nValorLiq - IIF(nIrrf>0,nIrrf,0) - iif(nIss>0,nIss,0)
			
			(cAliasQry)->(DbSkip ())
			
		Enddo
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicio da Impressão ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		(cAliasTrb)->(DbGoTop ())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Faço a impressao da filial, somente se a perguinta de seleção estiver como SIM  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If mv_par09 == 1
			oFilial:Init()
			oReport:EndPage() //Reinicia Paginas
			oReport:Say(300,20,STR0026+": "+SM0->M0_NOMECOM,oTFont) // "Razão Social: "
			oReport:Say(350,20,STR0027+": "+AllTrim(SM0->M0_ENDENT)+STR0028+": "+AllTrim(SM0->M0_CIDENT)+STR0028+": "+SM0->M0_ESTENT,oTFont) //"Endereco" Cidade UF
			oReport:Say(400,20,STR0008+": "+Transform(SM0->M0_CGC,"@R 99.999.999./9999-99"),oTFont) //CNPJ
			oReport:Say(450,20,STR0030+": "+SM0->M0_INSC,oTFont) //"Inscr. Estadual: "
			oFilial:Finish()
			oReport:SkipLine(10)
			oReport:FatLine()
			oReport:SkipLine(01)
		EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Impressão principal ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		oSection2:SetParentQuery()
		oSection2:SetParentFilter({|cParam| (cAliasTrb)->(TRB_CODCLI+TRB_LOJA+TRB_NOME) == cParam},{|| (cAliasTrb)->(TRB_CODCLI+TRB_LOJA+TRB_NOME) })
		oSection1:Print()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Fecho o Alias da Query³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		(cAliasQry)->( DbCloseArea() )
		(cAliasTrb)->( DbCloseArea() )
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Removo todos os temporarios criados pela funcao CriaTrb.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To Len (aTrbs)
		Ferase (aTrbs[nX][2]+GetDBExtension ())
		Ferase (aTrbs[nX][2]+OrdBagExt ())
	Next (nX)
					
Next nForFilial
	
cFilAnt := cFilBkp
RestArea(aAreaSM0)	
	
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} GetQuery
Relação de Titulos a Receber com Retenção PIS / COFINS e CSLL

@author  Fabio V Santana
@version P12
@since   24/06/2015
/*/
//-------------------------------------------------------------------
Static Function GetQuery(cAliasQry,cFilQry)

Local cSelec 	 := ""
Local lPccIdv  := SED->(ColumnPos("ED_PCCINDV")) > 0

If lPccIdv
     cSelec   := '%, SED.ED_CODIGO, SED.ED_PCCINDV %'

Else
	cSelec   := '%, SED.ED_CODIGO %'

EndIf

//-------------------------------------------------------------------
// Monta a Query com a Regra de Negocio do Relatorio.
//-------------------------------------------------------------------
BEGINSQL ALIAS cAliasQry
	
	COLUMN E1_EMISSAO AS DATE
	COLUMN E1_VENCREA AS DATE

	SELECT 	
		
		SA1.A1_FILIAL,
		SA1.A1_COD,
		SA1.A1_LOJA,
		SA1.A1_NOME,
		SA1.A1_CGC,
		SA1.A1_RECISS,
		SE1.E1_FILIAL,
		SE1.E1_PREFIXO,
		SE1.E1_NUM,
		SE1.E1_PARCELA,
		SE1.E1_TIPO,
		SE1.E1_NATUREZ,
		SE1.E1_EMISSAO,
		SE1.E1_VENCREA,
		SE1.E1_IRRF,
		SE1.E1_ISS,
		SE1.E1_INSS,
		SE1.E1_PIS,
		SE1.E1_COFINS,
		SE1.E1_CSLL,
		SE1.E1_BAIXA, 
		SE1.E1_MOEDA,
		SE1.E1_VALOR,
		SE1.E1_SALDO, 
		SE1.E1_ORIGEM,
		SE1.E1_CLIENTE,
		SE1.E1_LOJA,
		SE1.E1_SABTPIS,
		SE1.E1_SABTCOF, 
		SE1.E1_SABTCSL
		%Exp:cSelec% 

		
	FROM 
	
		%table:SE1% SE1

		LEFT JOIN 
			%Table:SA1% SA1 
		ON 
			(SA1.A1_FILIAL = %xFilial:SA1% 
			AND SA1.A1_COD = SE1.E1_CLIENTE 
			AND SA1.A1_LOJA = SE1.E1_LOJA 
			AND SA1.%NotDel% )		
			
			LEFT JOIN 
				%Table:SED% SED
			ON 
				(SED.ED_FILIAL = %xFilial:SED% 
				AND SED.ED_CODIGO = SE1.E1_NATUREZ 
				AND SED.%NotDel% )	
	
	WHERE
		SE1.E1_FILORIG = %Exp:cFilQry%			
		AND SE1.E1_CLIENTE BETWEEN %Exp:mv_par01% AND %Exp:mv_par02%
		AND SE1.E1_LOJA BETWEEN %Exp:mv_par03% AND %Exp:mv_par04%
		AND (SE1.E1_PIS > 0 OR SE1.E1_COFINS > 0 OR SE1.E1_CSLL > 0 OR SE1.E1_IRRF > 0 OR SE1.E1_INSS > 0 OR SE1.E1_ISS > 0)	
		AND SE1.E1_VENCREA BETWEEN %Exp:Dtos(mv_par07)% AND %Exp:DtoS(mv_par08)%	
		AND SE1.E1_EMISSAO BETWEEN %Exp:Dtos(mv_par05)% AND %Exp:DtoS(mv_par06)%	
	   AND SE1.E1_EMISSAO <= %Exp:Dtos(dDataBase)%
	   AND SE1.%NotDel%
			
	ORDER BY
		
		SE1.E1_FILIAL,
		SA1.A1_COD,
		SA1.A1_LOJA,
		SE1.E1_PREFIXO,
		SE1.E1_NUM,
		SE1.E1_PARCELA,
		SE1.E1_TIPO

ENDSQL

dbSelectArea( cAliasQry )
(cAliasQry)->(DbGoTop())

Return (cAliasQry)

//-------------------------------------------------------------------
/*/{Protheus.doc} CriaTrb
Cria arquivo de trabalho

@author  Fabio V Santana
@version P12
@since   01/06/2015
/*/
//-------------------------------------------------------------------
Static Function CriaTrb()

Local	aRet		:=	{}
Local	aTrb		:=	{}
Local cAlias		:= GetNextAlias()

Local aIndTRB		:=	{}

//
aTrb	:=	{}
//
aAdd (aTrb, {"TRB_ID" 		,"C",	TamSX3("A1_COD")[1]+TamSX3("A1_LOJA")[1]+TamSX3("A1_NOME")[1],0})
//
aAdd (aTrb, {"TRB_CODCLI" 	,"C",	TamSX3("A1_COD")[1]	,0})
aAdd (aTrb, {"TRB_LOJA"		,"C",	TamSX3("A1_LOJA")[1]	,0})
aAdd (aTrb, {"TRB_NOME"		,"C",	TamSX3("A1_NOME")[1]	,0})
aAdd (aTrb, {"TRB_CNPJ"		,"C",	TamSX3("A1_CGC")[1]	,0})	
//
aAdd (aTrb, {"TRB_FILIAL"	,"C",	TamSX3("E1_FILIAL")[1]	,0})	
aAdd (aTrb, {"TRB_PREFIX"	,"C",	TamSX3("E1_PREFIXO")[1]	,0})	
aAdd (aTrb, {"TRB_NUM"	 	,"C",	TamSX3("E1_NUM")[1]	  	,0})	
aAdd (aTrb, {"TRB_PARCEL"	,"C",	TamSX3("E1_PARCELA")[1]	,0})	
aAdd (aTrb, {"TRB_TIPO"	 	,"C",	TamSX3("E1_TIPO")[1]		,0})	
//
aAdd (aTrb, {"TRB_DTEMIS"	,"D",	TamSX3("E1_EMISSAO")[1]	,0})
aAdd (aTrb, {"TRB_DTVCTO"	,"D",	TamSX3("E1_VENCREA")[1]	,0})
//
aAdd (aTrb, {"TRB_VALORI"	,"N",	TamSX3("E1_VALOR")[1]	,TamSX3("E1_VALOR")[2]})
aAdd (aTrb, {"TRB_VALIR"		,"N",	TamSX3("E1_IRRF")[1]		,TamSX3("E1_IRRF")[2]})
aAdd (aTrb, {"TRB_VALISS"	,"N",	TamSX3("E1_ISS")[1]		,TamSX3("E1_ISS")[2]})
aAdd (aTrb, {"TRB_VALINS"	,"N",	TamSX3("E1_INSS")[1]		,TamSX3("E1_INSS")[2]})
aAdd (aTrb, {"TRB_VALPIS"	,"N",	TamSX3("E1_PIS")[1]		,TamSX3("E1_PIS")[2]})
aAdd (aTrb, {"TRB_VALCOF"	,"N",	TamSX3("E1_COFINS")[1]	,TamSX3("E1_COFINS")[2]})
aAdd (aTrb, {"TRB_VALCSL"	,"N",	TamSX3("E1_CSLL")[1]		,TamSX3("E1_CSLL")[2]})
aAdd (aTrb, {"TRB_VALLIQ"	,"N",	TamSX3("E1_VALOR")[1]	,TamSX3("E1_VALOR")[2]})	
	
If _oFINR9401 <> Nil
	_oFINR9401:Delete()
	_oFINR9401	:= Nil
Endif	
	
_oFINR9401 := FWTemporaryTable():New(cAliasTrb)
_oFINR9401:SetFields( aTrb )

//Adiciona as Chaves de indices
aAdd( aIndTRB , "TRB_CODCLI" )
aAdd( aIndTRB , "TRB_LOJA" )

_oFINR9401:AddIndex("1", aIndTRB)
_oFINR9401:Create()
	
aAdd (aRet, {cAliasTrb, cAlias})

Return (aRet)	

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ChkAbtImp ³ Autor ³ Ricardo A. Canteras   ³ Data ³10/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Soma titulos de abatimento relacionado aos impostos         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ChkAbtImp()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Prefixo,Numero,Parcela,Moeda,Saldo ou Valor,Data            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³FINR940                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ChkAbtImp(cPrefixo,cNumero,cParcela,nMoeda,cCpo,dData)

Local cAlias:=Alias()
Local nRec:=RecNo()
Local nTotAbImp := 0

dData :=IIF(dData==NIL,dDataBase,dData)
nMoeda:=IIF(nMoeda==NIL,1,nMoeda)

cCampo	:= IIF( cCpo == "V", "E1_VALOR" , "E1_SALDO" )

If Select("__SE1") == 0
	ChkFile("SE1",.F.,"__SE1")
Else
	dbSelectArea("__SE1")
Endif

dbSetOrder( 1 )
dbSeek( xFilial("SE1")+cPrefixo+cNumero+cParcela )

While !Eof() .And. E1_FILIAL == xFilial("SE1") .And. E1_PREFIXO == cPrefixo .And.;
		E1_NUM == cNumero .And. E1_PARCELA == cParcela
	If E1_TIPO != 'AB-' .And. E1_TIPO $ MVCSABT+"/"+MVCFABT+"/"+MVPIABT
		nTotAbImp +=xMoeda(&cCampo,E1_MOEDA, nMoeda,dData)
	Endif
	dbSkip()
Enddo

dbSetOrder( 1 )

dbSelectArea( cAlias )
dbGoTo( nRec )

Return ( nTotAbImp )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³FPccBxCr	ºAutor  ³Mauricio Pequim Jr. º Data ³  03/09/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para obter valor total de PCC retido na baixa CR    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico - PCC Baixa CR                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FVPccBxCr(cChave,nPis,nCofins,nCsll) 

Local aArea := GetArea()

DEFAULT cChave := ""
DEFAULT nPis	:= 0
DEFAULT nCofins:= 0
DEFAULT nCsll	:= 0

If !Empty(cChave)
	dbSelectArea("SE5")
	dbSetOrder(7) //Prefixo+Numero+Parcela+Tipo+CliFor+Loja+SeqBx
	If MsSeek(xFilial("SE5")+cChave)
		While SE5->(!Eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == xFilial("SE5")+cChave	
			IF SE5->E5_SITUACA != 'C' .and. !TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
				If Empty(SE5->E5_PRETPIS) .or. SE5->E5_PRETPIS="4"  //4 = Retido em borderô
					nPis	+= SE5->E5_VRETPIS
				Endif
				If Empty(SE5->E5_PRETCOF) .or. SE5->E5_PRETCOF="4"  //4 = Retido em borderô
					nCofins	+= SE5->E5_VRETCOF
				Endif
				If Empty(SE5->E5_PRETCSL) .or. SE5->E5_PRETCSL="4"  //4 = Retido em borderô
					nCsll	+= SE5->E5_VRETCSL
				Endif
			Endif
			SE5->( dbSkip() )
		Enddo
	Else
		nPis		:= 0
		nCofins	:= 0
		nCsll		:= 0
	Endif
Endif

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao  	³F940iriss	ºAutor  ³Daniel Ferraz Lacerda. º Data ³	22/04/16º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para obter valor de IR- e ISS- incluso manualmente  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico - IR e ISS manual                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                    
Static Function F940iriss(cChave)

Local aArea := GetArea()
Local nReturn := 0 
DEFAULT cChave := ""
		

If !Empty(cChave)
	dbSelectArea("SE1")
	dbSetOrder(1) //Prefixo+Numero+Parcela+Tipo
	If MsSeek(xFilial("SE1")+cChave)
		While SE1->(!Eof()) .and. SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO) == xFilial("SE1")+cChave

			IF SE1->E1_TIPO == 'IR-' 
					nReturn := SE1->E1_VALOR					
			Endif
			If SE1->E1_TIPO == 'IS-' 
					nReturn := SE1->E1_VALOR
			Endif		
			SE1->(dbSkip())
		Enddo
	Else
		nReturn := 0
	Endif				
Endif

RestArea(aArea)


Return nReturn
