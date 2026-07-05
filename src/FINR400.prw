/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR400.CH"
#Include "PROTHEUS.CH"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

//-------------------------------------------------------------------
/*/{Protheus.doc}FINR400
Relacao dos Cheque Emitidos

@author Daniel Tadashi Batori
@since  12/07/06
/*/
//-------------------------------------------------------------------
User Function FinR400()
	
	Local oReport

	oReport := ReportDef()
	oReport:PrintDialog()

Return

//-------------------------------------------------------------------
/*/{Protheus.doc}ReportDef
Definicao do layout do Relatorio

@author Daniel Tadashi Batori
@since  12/07/03
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
	
	Local oReport As Object
	Local oSection1 As Object
	Local oSection11 As Object
	Local aTam1 As Array
	Local aTam2 As Array
	Local aTam3 As Array
	Local aTam4 As Array

	oReport := TReport():New("FINR400",STR0003,"FIN400",;
	{|oReport| ReportPrint(oReport)},STR0001+STR0002)

	Pergunte("FIN400", .F.)

	//------------------------------------
	// PARÂMETOS configuração de impressão
	// mv_par01	  // Do banco ?
	// mv_par02	  // Ate o Banco ?
	// mv_par03	  // Da agencia ?
	// mv_par04	  // Ate a Agencia ?
	// mv_par05	  // Da conta ?
	// mv_par06	  // Ate conta ?
	// mv_par07	  // Do Cheque ?
	// mv_par08	  // Ate Cheque ?
	// mv_par09	  // Da Emissao ?
	// mv_par10	  // Ate Emissao ?
	// mv_par11	  // Qual Moeda ?
	// mv_par12	  // Outras Moedas ?
	// mv_par13	  // Carteira ?
	// mv_par14	  // Imprime Cheques ?
	//------------------------------------

	aTam1	:= TamSX3("A6_COD")
	aTam2	:= TamSX3("A6_NREDUZ")
	aTam3	:= TamSX3("A6_AGENCIA")
	aTam4	:= TamSX3("A6_NUMCON")
	nTam	:= LEN(STR0011) + aTam1[1] + aTam2[1] + LEN(STR0012) + aTam3[1] + aTam4[1] + 15

	oSection1 := TRSection():New(oReport,STR0032,{"SEF"},{STR0008,STR0009})
	TRCell():New(oSection1,"QUEBRA" ,,,,nTam,.F.,)  //definido por SetBlock

	oSection1:SetHeaderSection(.F.)

	oSection11 := TRSection():New(oSection1,STR0031,{"SEF"},)
	TRCell():New(oSection11,"EF_NUM" ,"SEF",STR0024,,,.F.,)  //"Numero"
	TRCell():New(oSection11,"EF_VALOR","SEF",STR0025,,,.F.,,)  //"Valor"
	TRCell():New(oSection11,"EF_DATA" ,"SEF",STR0026,,12,.F.,, "LEFT",,"LEFT",,,.F.)
	TRCell():New(oSection11,"EF_VENCTO" ,"SEF",STR0027,,12,.F.,)  //"Vencto."
	TRCell():New(oSection11,"EF_EMITENT" ,"SEF",STR0028,,40,.F.,)  //"Cliente Beneficiario/Emitente"
	TRCell():New(oSection11,"EF_HIST" ,"SEF",STR0029,,40,.F.,)  //"Historico"
	TRCell():New(oSection11,"EF_LIBER","SEF",STR0030,,,.F.,)  //"St.Ch"

	oSection11:SetAutoSize( .T. )

Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc}ReportPrint
A funcao estatica ReportDef devera ser criada para todos os
relatorios que poderao ser agendados pelo usuario.

@author Daniel Tadashi Batori
@since  12/07/03
/*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport)	
	Local oSection1  	:= oReport:Section(1)
	Local oSection11	:= oReport:Section(1):Section(1)
	Local cAliasQry1	:= GetNextAlias()
	Local cQuery 		:= ""
	Local nOrder 		:= oSection1:GetOrder()
	Local cOrder 		:= ""
	Local nDecs 		:= MsDecimais(mv_par11)
	Local cAnt
	Local nValor		:= 0
	Local nTotVal		:= 0
	Local nCheque		:= 0
	Local nMoedaBco		:= 0
	Local aCheques 		:= {}
	Local cCheque 		:= ""
	Local cChAnt 		:= ""
	Local nSomaCh 		:= 0
	Local nRectemp 		:= 0
	Local cQuebra 		:= ""
	Local nNewch 		:= 0
	Local dNewdt 		:= dDatabase
	Local dNewVenc 		:= dDatabase
	Local cNewEmit		:= ""
	Local cNewHist 		:= ""
	Local cNewLib 		:= ""
	Local cBanco		:= ""
	Local cAgen			:= ""
	Local cCtaCor		:= ""
	Local lImprBanco 	:= .T.
	Local lLegF191      := SuperGetMV("MV_LEGF191", .F., .F.)
	Local bQuebra := {||	cQuebra := If (MV_PAR13 == 2, ;
							STR0011 + SA6->A6_COD + " " + AllTrim(SA6->A6_NOME) + " " +  STR0012 + " " +  SA6->A6_AGENCIA + " " + STR0033 + " " + SA6->A6_NUMCON, ;
							STR0011 + cBanco + " " + STR0012 + " " + cAgen + " " + STR0033 + " " + cCtaCor)}
	
	oSection1:BeginQuery()

	If cPaisLoc != "BRA"
		If !(AllTrim(Upper(TCGetDB())) $ "ORACLE_INFORMIX")
			cQuery += " AND SUBSTRING(EF_NUM,1,1) <> '*' "
		Else
			cQuery += " AND SUBSTR(EF_NUM,1,1) <> '*' "
		EndIf
	EndIf

	If Mv_Par13 == 1
		cQuery += " AND EF_CART = 'R' "
	ElseIf Mv_Par13 == 2
		cQuery += " AND EF_CART <> 'R' "
	EndIf

	If Mv_Par13 <> 1
		IF Mv_Par14 == 1
			cQuery += " AND EF_LIBER = 'S' "
		ElseIf Mv_Par14 == 2
			cQuery += " AND EF_LIBER IN ('N',' ') "
		EndIf
	EndIf

	cOrder := SqlOrder(SEF->(IndexKey( nOrder )))
	cQuery += " ORDER BY "+ cOrder

	cQuery := "%" + cQuery + "%"

	BeginSql Alias cAliasQry1
		SELECT SEF.*
		FROM %table:SEF% SEF
		WHERE EF_FILIAL = %xFilial:SEF% AND
				EF_BANCO  >= %exp:mv_par01% AND
				EF_BANCO  <= %exp:mv_par02% AND
				EF_AGENCIA >= %exp:mv_par03% AND
				EF_AGENCIA <= %exp:mv_par04% AND
				EF_CONTA   >= %exp:mv_par05% AND
				EF_CONTA   <= %exp:mv_par06% AND
				EF_NUM     >= %exp:mv_par07% AND
				EF_NUM     <= %exp:mv_par08% AND
				EF_DATA    >= %exp:mv_par09% AND
				EF_DATA    <= %exp:mv_par10% AND
				EF_IMPRESS <> 'A' AND
				EF_IMPRESS <> 'C' AND
				EF_NUM <> ' ' AND
				SEF.%NotDel%
				%exp:cQuery%
	EndSql

	oSection1:EndQuery()
	oSection11:SetParentQuery()

	oSection11:SetParentFilter({|cParam| (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) == cParam},{|| (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) })

	TRPosition():New(oSection1, "SA6", 1, {|| xFilial("SA6") + cAnt}, .T. )

	oSection1:SetLineCondition( { ||  ((cAliasQry1)->EF_CART <> "P") .Or. (mv_par12 <> 2) .Or. (Empty(SA6->A6_MOEDA)) .Or. (SA6->A6_MOEDA==mv_par11) } )

	oSection1:Cell("QUEBRA"):SetBlock( { || EVAL(bQuebra),cQuebra })
	oSection11:Cell("EF_NUM"):SetBlock( { || nNewch })
	oSection11:Cell("EF_VALOR"):SetBlock( { || nValor })
	oSection11:Cell("EF_DATA"):SetBlock( { || dNewdt })
	oSection11:Cell("EF_VENCTO"):SetBlock( { || dNewVenc })
	oSection11:Cell("EF_EMITENT"):SetBlock( { || cNewEmit })
	oSection11:Cell("EF_HIST"):SetBlock( { || cNewHist })
	oSection11:Cell("EF_LIBER"):SetBlock( { || cNewLib })

	TRFunction():New(oSection11:Cell("EF_VALOR"),"T_VALOR" ,"SUM",,,,,.T.,.F.)
	oSection11:SetTotalInLine(.F.)

	(cAliasQry1)->(dbGoTop())

	oSection1:Init()

	aCheques := {}

	SA6->(DbSetOrder(1))

	While (cAliasQry1)->(!Eof())

		cAnt := (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA)
		oSection11:Init()
		lImprBanco := .T.

		While (cAliasQry1)->(!Eof()) .And. (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA) == cAnt	

			cBanco	:= (cAliasQry1)->(EF_BANCO)
			cAgen	:= (cAliasQry1)->(EF_AGENCIA)
			cCtaCor	:= (cAliasQry1)->(EF_CONTA)
				
			cChAnt := (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM)
			cCheque := cChAnt
			
			If SA6->(DbSeek(xFilial("SA6") + cBanco + cAgen + cCtaCor))
				nMoedaBco := SA6->A6_MOEDA
			Else
				nMoedaBco := 1
			Endif

			if (cAliasQry1)->EF_CART = "R"
				While (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM) == cChAnt
					If lLegF191
						nSomaCh := xMoeda((cAliasQry1)->EF_VALOR, nMoedaBco, mv_par11,(cAliasQry1)->EF_DATA,nDecs+1)
					Else
						nSomaCh += xMoeda((cAliasQry1)->EF_VALOR, nMoedaBco, mv_par11,(cAliasQry1)->EF_DATA,nDecs+1)
					EndIf
					nRectemp:= (cAliasQry1)->(RECNO())
					nNewch :=(cAliasQry1)->EF_NUM
					dNewdt :=(cAliasQry1)->EF_DATA
					dNewVenc := If(cPaisLoc <> "BRA" .Or. (cAliasQry1)->EF_CART=="R", (cAliasQry1)->EF_VENCTO, nil)
					cNewEmit := SubStr( If ((cAliasQry1)->EF_CART=="R", ;
																	If(cPaisLoc<>"BRA",(cAliasQry1)->EF_EMITENT, (cAliasQry1)->EF_CLIENTE+' '+(cAliasQry1)->EF_EMITENT), ;
																	(cAliasQry1)->EF_BENEF ),1,40)
					cNewHist := SubStr( (cAliasQry1)->EF_HIST,1,50)
					cNewLib := If((cAliasQry1)->EF_CART <> 'R' , If((cAliasQry1)->EF_LIBER $ 'N ', "B","L") , nil)

					cCheque := (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM)

					(cAliasQry1)->(dbSkip())
			
				Enddo

				nValor := nSomaCh
			Else 
				nValor	:= xMoeda((cAliasQry1)->EF_VALOR, SA6->A6_MOEDA, mv_par11,(cAliasQry1)->EF_DATA,nDecs+1) 
				nRectemp:= (cAliasQry1)->(RECNO())
				nNewch 	:=(cAliasQry1)->EF_NUM
				dNewdt 	:=(cAliasQry1)->EF_DATA
				dNewVenc:= If(cPaisLoc <> "BRA" .Or. (cAliasQry1)->EF_CART=="R", (cAliasQry1)->EF_VENCTO, nil)
				cNewEmit:= SubStr( If ((cAliasQry1)->EF_CART=="R", ;
					If(cPaisLoc<>"BRA",(cAliasQry1)->EF_EMITENT, (cAliasQry1)->EF_CLIENTE+' '+(cAliasQry1)->EF_EMITENT), ;
																	(cAliasQry1)->EF_BENEF ),1,40) 
				cNewHist:= SubStr( (cAliasQry1)->EF_HIST,1,50)
				cNewLib := If((cAliasQry1)->EF_CART <> 'R' , If((cAliasQry1)->EF_LIBER $ 'N ', "B","L") , nil)

				cCheque := (cAliasQry1)->(EF_BANCO+EF_AGENCIA+EF_CONTA+EF_NUM)

				(cAliasQry1)->(dbSkip())
			Endif

			If lImprBanco
				oSection1:PrintLine()
				lImprBanco := .F.
			End
			
			If ASCAN(ACHEQUES,{ |X|  X[1] == cCheque}) <= 0	 
				nTotVal	+= nValor
				nCheque++
				aAdd(aCheques,{cCheque})
				oSection11:PrintLine()
			Endif
			nSomaCh := 0
		Enddo
		oSection11:Finish()
		oReport:SkipLine()
		oReport:SkipLine()
	Enddo

	oSection1:Finish()

	oReport:PrintText(STR0014 + Transform(nTotVal, PesqPict('SEF','EF_VALOR') ))
	oReport:PrintText(STR0015  + Transform(nCheque, "@E 9,999,999,999,999"))

	If mv_par13 <> 1
		oReport:SkipLine()
		oReport:PrintText(STR0020) //"Total Cheques-> " //"Legenda: "
		oReport:PrintText(STR0021) //"Total Cheques-> " //"St.Ch - Status do Cheque"
		oReport:PrintText(STR0022) //"Total Cheques-> " //"B - Bloqueado "
		oReport:PrintText(STR0023) //"Total Cheques-> " //"L - Liberado "
	EndIf

Return
