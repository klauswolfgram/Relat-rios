/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "FINR120.CH"
#Include "PROTHEUS.CH"

# Define ANALITICO   ( nNivel == 1 )
# Define SINTETICO   ( nNivel == 2 )
# Define PAGAMENTO   ( nOperacao == 1 .or. nOperacao == 3 )
# Define RECEBIMENTO ( nOperacao == 2 .or. nOperacao == 3 )

Static _oFINR120

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR120
Movimento Diario do Caixa	      

@author Daniel Batori
@since  07/06/2006
@version 12.1.17
/*/
//-------------------------------------------------------------------
User Function FINR120()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Definicao do layout do Relatorio	      

@author Daniel Batori
@since  07/06/2006
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function ReportDef()
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local cPerg      := "FIN120"  // Nome do grupo de perguntas
Local cAliasQry1 := GetNextAlias()
Local cAliasQry2 := GetNextAlias()
Local cAliasQry3 := GetNextAlias()
Local aNumerario := {}

oReport := TReport():New("FINR120",STR0010,"FIN120",;
{|oReport| ReportPrint(oReport,@cAliasQry1,@cAliasQry2,@cAliasQry3,@aNumerario)},STR0007+STR0008+STR0009)

oReport:SetLandScape()

Pergunte ( cPerg, .F. )

If cPaisLoc	#	"BRA"
	/* GESTAO - inicio */
	oSection1 := TRSection():New(oReport,STR0027,{"SE5","SE8","SA6"},{STR0003,STR0004,STR0005,STR0006}) //"Saldo"
	/* GESTAO - fim */
	TRCell():New(oSection1,"E8_DTSALAT" ,"SE8",STR0023,,,.F.,{|| DtoC(Mv_Par03) })               //"Data"
	TRCell():New(oSection1,"E5_BANCO"   ,"SE5",STR0024,,,.F.,{|| (cAliasQry1)->E5_BANCO })       //"Banco"
	TRCell():New(oSection1,"E5_AGENCIA" ,"SE5",STR0025,,,.F.,{|| (cAliasQry1)->E5_AGENCIA })     //"Agencia"
	TRCell():New(oSection1,"E5_CONTA"   ,"SE5",STR0026,,,.F.,{|| (cAliasQry1)->E5_CONTA })       //"Conta"
	TRCell():New(oSection1,"E8_SALATUA" ,"SE8",STR0027,,,.F.,)                                    //"Saldo"
EndIf

/* GESTAO - inicio */
oSection2 := TRSection():New(oReport,STR0012,"SE5",{STR0003,STR0004,STR0005,STR0006}) 				//"Analitico"
/* GESTAO - fim */
TRCell():New(oSection2,"E5_DATA"    ,"SE5",STR0023,,,.F.,{|| (cAliasQry2)->E5_DATA })  			   //"Data"
TRCell():New(oSection2,"E5_MOEDA"   ,"SE5",STR0030,,,.F.,{|| (cAliasQry2)->E5_MOEDA })             //"Numerario"
TRCell():New(oSection2,"E5_NATUREZ" ,"SE5",STR0031,,,.F.,{|| (cAliasQry2)->E5_NATUREZ })           //"Natureza"
TRCell():New(oSection2,"E5_BANCO"   ,"SE5",STR0024,,,.F.,{|| (cAliasQry2)->E5_BANCO })             //"Banco"
TRCell():New(oSection2,"E5_AGENCIA" ,"SE5",STR0025,,,.F.,{|| (cAliasQry2)->E5_AGENCIA })           //"Agencia"
TRCell():New(oSection2,"E5_CONTA"   ,"SE5",STR0026,,,.F.,{|| (cAliasQry2)->E5_CONTA })             //"Conta"
TRCell():New(oSection2,"E5_NUMCHEQ" ,"SE5",STR0032,,TamSx3("E5_NUMCHEQ")[1],.F.,{|| (cAliasQry2)->E5_NUMCHEQ })           //"Cheque"
TRCell():New(oSection2,"E5_DOCUMEN" ,"SE5",STR0033,,32,.F.,{|| (cAliasQry2)->E5_DOCUMEN })           //"Documento"
TRCell():New(oSection2,"E5_ORDREC"  ,"SE5",If(cPaisLoc <> "CHI",STR0034,STR0035),,TamSx3("E5_ORDREC")[1],.F.,{|| (cAliasQry2)->E5_ORDREC })	//"OP/Rec" ## "OP/Plan"
TRCell():New(oSection2,"E5_VENCTO"  ,"SE5",STR0036,,,.F.,{|| (cAliasQry2)->E5_VENCTO })            //"Vencimento"
TRCell():New(oSection2,"E5_BENEF"   ,"SE5",STR0037,,19,.F.,{|| (cAliasQry2)->E5_BENEF })           //"Beneficiario"
TRCell():New(oSection2,"E5_HISTOR"  ,"SE5",STR0038,,22,.F.,{|| (cAliasQry2)->E5_HISTOR })          //"Historico"
TRCell():New(oSection2,"PAGAM"      ,     ,STR0039,Tm(0,16),16,.F.,,,,"RIGHT")                     //definido com SetBlock					//"Pagamentos(A)"
TRCell():New(oSection2,"RECEB"      ,     ,STR0040,Tm(0,16),16,.F.,,,,"RIGHT")                     //definido com SetBlock					//"Recebimentos(B)"
TRCell():New(oSection2,"DIF_PAGREC" ,     ,STR0041,Tm(0,16),16,.F.,,,,"RIGHT")                     //definido com SetBlock					//"B - A"
oSection2:Cell("DIF_PAGREC"):Hide()
oSection2:SetHeaderPage(.T.) //Define o cabecalho da secao como padrao

oSection3 := TRSection():New(oReport,STR0013,{cAliasQry3,"SE5"})		//"Sintetico"
TRCell():New(oSection3,"ORDEM"		,		,STR0028,,50,.F.,{ || (cAliasQry3)->ORDEM} ) 	//"Ordem"
TRCell():New(oSection3,"PAGAM3"    ,     ,STR0039,"@E 9,999,999,999.99",20,.F.,)			//"Pagamentos(A)"
TRCell():New(oSection3,"RECEB3"    ,     ,STR0040,"@E 9,999,999,999.99",20,.F.,)			//"Recebimentos(B)"
TRCell():New(oSection3,"DIF_PAGREC",     ,STR0041,"@E 9,999,999,999.99",20,.F.,)			//"B - A"

Return oReport


//-------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint
Impressão do Relatorio	      

@author Daniel Batori
@since  07/06/2006
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport,cAliasQry1,cAliasQry2,cAliasQry3,aNumerario)
Local oSection1
Local oSection2
Local oSection3
Local nOrdem := oReport:Section(1):GetOrder()
Local cFilUser   := ""
Local oBreak
Local cAnt       := ""
Local cWhere     := ""
Local nMoedaBco  := 1
Local nCasas	  := GetMv("MV_CENT"+(IIF(mv_par09 > 1 , STR(mv_par09,1),"")))
Local nTxMoedBc  := 0
Local nTotPag    := 0
Local nTotRec    := 0
Local nValor	  := 0
Local nNivel     := Mv_Par10
Local cTitulo
Local cFiltro
Local aCampos     := {}
Local aTam        := {}
Local cTrabalho1  := ""
Local cTrabalho2  := ""
Local cTrabalho3  := ""
Local cOperacao   := ""
Local nAscan
Local nConvert	  := mv_par09

If cPaisLoc	# "BRA"
	oSection1  := oReport:Section(1)
	oSection2  := oReport:Section(2)
	oSection3  := oReport:Section(3)
Else
	oSection2  := oReport:Section(1)
	oSection3  := oReport:Section(2)
EndIf

If mv_par11 == 1 // Pagamentos ( 1 ), recebimentos ( 2 ) ou ambos ( 3 )
	cOperacao := "P"
ElseIf mv_par11 == 2
	cOperacao := "R"
Else
	cOperacao := ""
EndIf

//------------------------------------------------------------------------
//Query para saldo inicial
If cPaisLoc	# "BRA"
	oSection1:BeginQuery()

	cWhere := ""

	If nOrdem == 2 //Por Numerario, nao considera em brancos
		cWhere := " AND E5_MOEDA <> ' ' "
	EndIf

	cWhere := "%" + cWhere + "%"

	BeginSql Alias cAliasQry1
		SELECT E5_BANCO, E5_AGENCIA, E5_CONTA, A6_MOEDA
		FROM %table:SE5% SE5, %table:SA6% SA6
		WHERE E5_FILIAL 	= %xFilial:SE5%
			  	AND E5_DATA    >= %exp:Mv_Par03%
			 	AND E5_DATA    <= %exp:Mv_Par04%
				AND E5_BANCO   >= %exp:Mv_Par05%
				AND E5_BANCO   <= %exp:Mv_Par06%
				AND E5_MOEDA   >= %exp:Mv_Par01%
				AND E5_MOEDA   <= %exp:Mv_Par02%
				AND E5_NATUREZ >= %exp:Mv_Par07%
				AND E5_NATUREZ <= %exp:Mv_Par08%
				AND E5_TIPODOC NOT IN  ('BA','MT','CM','DC','JR','CP','M2','C2','D2','J2','V2')
				AND E5_MOTBX   <> 'CMP'
				AND E5_SITUACA <> 'C'
				AND SE5.%NotDel%
				AND A6_FILIAL	= %xFilial:SA6%
				AND A6_COD 		=	E5_BANCO
				AND A6_AGENCIA = 	E5_AGENCIA
				AND A6_NUMCON	=	E5_CONTA
				AND SA6.%NotDel%
				%Exp:cWhere%
		GROUP BY E5_BANCO, E5_AGENCIA, E5_CONTA, A6_MOEDA
		ORDER BY E5_BANCO, E5_AGENCIA, E5_CONTA
	EndSQL

	oSection1:EndQuery()
EndIf

//-------------------------------------------------------------------------
//Query para as movimentacoes - analitico
oSection2:BeginQuery()

cWhere := ""

If nOrdem == 2 //Por Numerario, nao considera em brancos
	cWhere += " AND E5_MOEDA <> ' ' "
EndIf

If MV_PAR11 != 3 // Pagamentos ( 1 ), recebimentos ( 2 ) ou ambos ( 3 )
	cWhere += " AND ((E5_RECPAG <> '" + cOperacao + "' AND E5_TIPODOC='ES') OR (E5_RECPAG = '" + cOperacao + "' AND E5_TIPODOC<>'ES')) "
EndIf

//Considerar a moeda do banco e não a SE5 já que os movimentos bancários sempre serão na moeda do banco
//independente do conteúdo do E5_MOEDA
If MV_PAR12 == 2
	cWhere += " AND A6_MOEDA = '" + Alltrim( StrZero(nConvert,2)) + "'"
EndIf
oReport:NoUserFilter()

cFilUser := If ( ANALITICO , oSection2:GetSqlExp() , oSection3:GetSqlExp() )

If !Empty(cFilUser)
	cWhere += " AND " + cFilUser
EndIf

Do Case
	Case nOrdem == 1  //Por Data
		cWhere += " ORDER BY E5_FILIAL, E5_DATA, E5_BANCO, E5_AGENCIA, E5_CONTA, E5_NUMCHEQ "
	Case nOrdem == 2 //Por Numerario
		cWhere += " ORDER BY E5_FILIAL, E5_MOEDA, E5_DATA, E5_BANCO, E5_AGENCIA, E5_CONTA, E5_NUMCHEQ "
	Case nOrdem == 3 //Por Banco
		cWhere += " ORDER BY E5_FILIAL, E5_BANCO, E5_AGENCIA, E5_CONTA, E5_DATA "
	Case nOrdem == 4 //Por Natureza
		cWhere += " ORDER BY E5_FILIAL, E5_NATUREZ, E5_DATA, E5_BANCO, E5_AGENCIA, E5_CONTA, E5_NUMCHEQ "
EndCase

// Ponto de entrada permite a customizacao dos movimentos que serao informados no relatorio 
If ExistBlock("FR120QRY")
	cWhere := ExecBlock("FR120QRY",.F.,.F.,{cWhere})
Endif

cWhere := "%" + cWhere + "%"

BeginSql Alias cAliasQry2
	SELECT	E5_DATA, E5_MOEDA, E5_NATUREZ, E5_BANCO, E5_AGENCIA, E5_CONTA,
				E5_NUMCHEQ, E5_DOCUMEN, E5_ORDREC, E5_VENCTO, E5_BENEF, E5_HISTOR,
				E5_RECPAG, E5_VALOR, E5_TXMOEDA, A6_MOEDA, A6_NOME
	FROM %table:SE5% SE5 LEFT JOIN %table:SA6% SA6 ON 	A6_FILIAL 	= %xFilial:SA6% AND
																		A6_COD 		=	E5_BANCO     AND
																		A6_AGENCIA 	=	E5_AGENCIA	AND
																		A6_NUMCON	=	E5_CONTA
	WHERE E5_FILIAL   = %xFilial:SE5%
		  	AND E5_DATA    >= %exp:Mv_Par03%
		 	AND E5_DATA    <= %exp:Mv_Par04%
			AND E5_BANCO   >= %exp:Mv_Par05%
			AND E5_BANCO   <= %exp:Mv_Par06%
			AND E5_MOEDA   >= %exp:Mv_Par01%
			AND E5_MOEDA   <= %exp:Mv_Par02%
			AND E5_NATUREZ >= %exp:Mv_Par07%
			AND E5_NATUREZ <= %exp:Mv_Par08%
			AND E5_TIPODOC NOT IN  ('BA','MT','CM','DC','JR','CP','M2','C2','D2','J2','V2')
			AND E5_MOTBX   <> 'CMP'
			AND E5_SITUACA <> 'C'
			AND SE5.%NotDel%
			AND SA6.%NotDel%
			%Exp:cWhere%

EndSql

oSection2:EndQuery(/*ExpA1*/)

If cPaisLoc	!= "BRA"//E8_FILIAL, E8_BANCO, E8_AGENCIA, E8_CONTA, E8_DTSALAT
	oSection1:Cell("E8_SALATUA"):SetBlock( { || CalcSldIni( MV_PAR03, (cAliasQry1)->E5_BANCO, (cAliasQry1)->E5_AGENCIA, (cAliasQry1)->E5_CONTA ) } )
EndIf

//define o Break ; define o titulo do relatorio ; define o SetBlock para a segunda secao do relatorio ; define o titulo para a secao 3
Do Case
  	Case nOrdem == 1  //Por Data

	 	oBreak := TRBreak():New( oSection2,{|| (cAliasQry2)->E5_DATA } , )
  		oBreak:SetTitle({|| STR0042 + " - " + cAnt }) //"Total"
		oBreak:OnPrintTotal({|| cAnt := DtoC((cAliasQry2)->E5_DATA) })

		cTitulo := STR0010 + "         ( " + iIf ( ANALITICO, STR0012, STR0013 )  + " ) " + STR0043 + ;  //"Analitico"###"Sintetico"###"em "
			  			GetMv("MV_MOEDA"+LTrim(Str(Mv_Par09))) + ' - ' + STR0003
  		oReport:SetTitle(cTitulo)

		oSection3:Cell("ORDEM"):SetTitle(STR0023)		//"Data"

  	Case nOrdem == 2 //Por Numerario

		oBreak := TRBreak():New( oSection2,{|| (cAliasQry2)->E5_MOEDA } ,  )
		oBreak:SetTitle({|| STR0042 + " - " + cAnt }) //"Total"
		oBreak:OnPrintTotal({|| nAscan := Ascan(aNumerario, { |e| e[1] == Right("000"+AllTrim((cAliasQry2)->E5_MOEDA),2) } ),;
										If( nAscan > 0, cAnt := STR0044 + " " + aNumerario[nAscan][2], cAnt := "" ) } )		//"Moeda"

		// Obtém a tabela de numerários
		SX5 -> ( dbSeek( xFilial("SX5") + "06" ) )
		SX5 -> ( dbEval(	{ || aAdd( aNumerario, { Alltrim(SX5->X5_CHAVE), X5Descri() } ) },NIL,;
								{ || xFilial("SX5") == SX5 -> X5_FILIAL .and. SX5 -> X5_TABELA == "06" } )  )

		cTitulo := STR0010 + "         ( " + iIf ( ANALITICO, STR0012, STR0013 )  + " ) " + STR0043 + ;  //"Analitico"###"Sintetico"###"em "
			  			GetMv("MV_MOEDA"+LTrim(Str(Mv_Par09))) + ' - ' + STR0004
		oReport:SetTitle(cTitulo)

		oSection3:Cell("ORDEM"):SetTitle(STR0044)		//"Moeda"

  	Case nOrdem == 3 //Por Banco

	 	oBreak := TRBreak():New( oSection2,{|| (cAliasQry2)->(E5_BANCO+E5_AGENCIA+E5_CONTA)} , )
  		oBreak:SetTitle({|| STR0042 + " - " + cAnt }) //"Total"
		oBreak:OnPrintTotal({|| cAnt := (cAliasQry2)->A6_NOME })

		cTitulo := STR0010 + "         ( " + iIf ( ANALITICO, STR0012, STR0013 )  + " ) " + STR0043 + ;  //"Analitico"###"Sintetico"###"em "
			  			GetMv("MV_MOEDA"+LTrim(Str(Mv_Par09))) + ' - ' + STR0005
		oReport:SetTitle(cTitulo)

		oSection3:Cell("ORDEM"):SetTitle(STR0024)			//"Banco"

  	Case nOrdem == 4 //Por Natureza

	 	oBreak := TRBreak():New( oSection2,{|| (cAliasQry2)->E5_NATUREZ } , )
  		oBreak:SetTitle({|| STR0042 + " - " + cAnt }) //"Total"
		oBreak:OnPrintTotal({|| cAnt := FR120Natur((cAliasQry2)->E5_NATUREZ) })

		cTitulo := STR0010 + "         ( " + iIf ( ANALITICO, STR0012, STR0013 )  + " ) " + STR0043 + ;  //"Analitico"###"Sintetico"###"em "
			  			GetMv("MV_MOEDA"+LTrim(Str(Mv_Par09))) + ' - ' + STR0006
		oReport:SetTitle(cTitulo)

		oSection3:Cell("ORDEM"):SetTitle(STR0031)		//"Natureza"

EndCase

oReport:SetTotalText(STR0017)	//"Total geral"

If cPaisLoc == "BRA"
	oSection2:Cell("E5_ORDREC"):Disable()
Else
	oSection2:Cell("E5_ORDREC"):Enable()
EndIf

//se pagamento entao preenche apenas celula de pagamento senao apenas celula de recebimento
oSection2:Cell("PAGAM"):SetBlock( {|| nTotPag := If((cAliasQry2)->E5_RECPAG == "P" ,;
														(nTxMoedBc := (cAliasQry2)->E5_TXMOEDA ,;
												  		xMoeda((cAliasQry2)->E5_VALOR,(If(cPaisLoc#"BRA",(Max((cAliasQry2)->A6_MOEDA,1)),nMoedaBco)),mv_par09,(cAliasQry2)->E5_DATA,nCasas+1,nTxMoedBc,If(cPaisLoc=="BRA",(cAliasQry2)->E5_TXMOEDA,0))),;
												  		0)	} )
oSection2:Cell("RECEB"):SetBlock( {|| nTotRec := If ((cAliasQry2)->E5_RECPAG == "R" ,;
														(nTxMoedBc := (cAliasQry2)->E5_TXMOEDA,;
												  		xMoeda((cAliasQry2)->E5_VALOR,(If(cPaisLoc#"BRA",(Max((cAliasQry2)->A6_MOEDA,1)),nMoedaBco)),mv_par09,(cAliasQry2)->E5_DATA,nCasas+1,nTxMoedBc,If(cPaisLoc=="BRA",(cAliasQry2)->E5_TXMOEDA,0))),;
												  		0)	} )

oSection2:Cell("DIF_PAGREC"):SetBlock( {||nTotRec-nTotPag })

oSection2:SetTotalInLine(.F.)
oReport:SetTotalInLine(.F.)

If SINTETICO
	//------------------------------------------------------------------------
	// tabela temporaria para as movimentacoes - sintetico
	// -----------------------------------------------------------------------
	// Cria o arquivo de trabalho 
	//------------------------------------------------------------------------
	aCampos := {}
	AADD(aCampos,{"ORDEM"      ,"C",50,0})
	aTam:=TamSX3("E5_VALOR")
	AADD(aCampos,{"PAGAM3"     ,"N",aTam[1],aTam[2]})
	AADD(aCampos,{"RECEB3"     ,"N",aTam[1],aTam[2]})
	AADD(aCampos,{"DIF_PAGREC" ,"N",aTam[1],aTam[2]})

	If(_oFINR120 <> NIL)
		_oFINR120:Delete()
		_oFINR120 := NIL
	EndIf

	_oFINR120 := FWTemporaryTable():New( cAliasQry3 )
	_oFINR120:SetFields(aCampos)
	_oFINR120:AddIndex("1",{"ORDEM","PAGAM3","RECEB3","DIF_PAGREC"})

	_oFINR120:Create()

	(cAliasQry2)->(DbGotop())
	While (cAliasQry2)->(!Eof())
		Do Case
			Case nOrdem == 1  //Por Data
				bQuebra := { || (cAliasQry2)->E5_DATA == uQuebra }
				uQuebra := (cAliasQry2)->E5_DATA
			Case nOrdem == 2 //Por Numerario
				bQuebra := { || (cAliasQry2)->E5_MOEDA == uQuebra }
				uQuebra := (cAliasQry2)->E5_MOEDA
			Case nOrdem == 3 //Por Banco
				bQuebra := { || (cAliasQry2)->(E5_BANCO+E5_AGENCIA+E5_CONTA) == uQuebra }
				uQuebra := (cAliasQry2)->(E5_BANCO+E5_AGENCIA+E5_CONTA)
			Case nOrdem == 4 //Por Natureza
				bQuebra := { || (cAliasQry2)->E5_NATUREZ == uQuebra }
				uQuebra := (cAliasQry2)->E5_NATUREZ
		EndCase

		nTotPag  := 0
		nTotRec  := 0

		While (cAliasQry2)->(!Eof()) .And. Eval(bQuebra)
			nValor := xMoeda( (cAliasQry2)->E5_VALOR , ;
									 If(cPaisLoc#"BRA",Max((cAliasQry2)->A6_MOEDA,1),nMoedaBco) , ;
									 mv_par09 , ;
									 (cAliasQry2)->E5_DATA , ;
									 nCasas+1 , ;
									 (cAliasQry2)->E5_TXMOEDA , ;
									 If(cPaisLoc=="BRA",(cAliasQry2)->E5_TXMOEDA,0) )

			If (cAliasQry2)->E5_RECPAG == "P"
				nTotPag  += nValor
			Else
				nTotRec  += nValor
			EndIf
			(cAliasQry2)->(DbSkip())
		EndDo // Mudou a quebra

		Do Case
			Case nOrdem == 2 //Por Numerario
				nAscan  := Ascan(aNumerario, { |e| e[1] == Right("000"+AllTrim( uQuebra ),2) } )
				uQuebra := If( nAscan > 0, aNumerario[nAscan][2], "" )
			Case nOrdem == 3 //Por Banco
				uQuebra :=  Fr120Banco ( uQuebra )
			Case nOrdem == 4 //Por Natureza
				uQuebra :=  FR120Natur( uQuebra )
		EndCase

		RecLock( cAliasQry3, .T. )
		(cAliasQry3)->ORDEM       := Transform(uQuebra,"")
		(cAliasQry3)->PAGAM3      := nTotPag
		(cAliasQry3)->RECEB3      := nTotRec
		(cAliasQry3)->DIF_PAGREC := (nTotRec-nTotPag)
		MsUnlock( )

	EndDo

	oReport:SetTotalText(STR0017)		//"Total geral :"
	oSection2:SetHeaderSection(.F.)

	oSection3:Cell("PAGAM3"):SetBlock     ( {|| (cAliasQry3)->PAGAM3		})
	oSection3:Cell("RECEB3"):SetBlock     ( {|| (cAliasQry3)->RECEB3		})
	oSection3:Cell("DIF_PAGREC"):SetBlock ( {|| (cAliasQry3)->DIF_PAGREC})

EndIf

(cAliasQry2)->(dbGoTop())

If cPaisLoc	!= "BRA"
	oSection1:SetOrder(1)
	oSection1:Print()
EndIf

If ANALITICO

	Do Case
		Case nOrdem == 1 //Por Data
			cAnt := DtoC((cAliasQry2)->E5_DATA)
		Case nOrdem == 2 //Por Numerario
			nAscan := Ascan(aNumerario, { |e| e[1] == Right("000"+AllTrim((cAliasQry2)->E5_MOEDA),2) } )
			If( nAscan > 0, cAnt := STR0044 + " " + aNumerario[nAscan][2], cAnt := "" ) 	//"Moeda"
		Case nOrdem == 3 //Por Banco
			cAnt := (cAliasQry2)->A6_NOME
	   Case nOrdem == 4 //Por Natureza
		    cAnt := FR120Natur((cAliasQry2)->E5_NATUREZ)
	EndCase

	TRFunction():New(oSection2:Cell("PAGAM")      ,"TOT_PAGAM" ,"SUM",oBreak,,,,.F.,.T.)
	TRFunction():New(oSection2:Cell("RECEB")      ,"TOT_RECEB" ,"SUM",oBreak,,,,.F.,.T.)
	TRFunction():New(oSection2:Cell("DIF_PAGREC") ,"TOT_PAGREC","SUM",oBreak,,,,.F.,.T.)

	oSection2:SetOrder(1)
	oSection2:Print()

Else    //sintetico

	TRFunction():New(oSection3:Cell("PAGAM3")     ,"TOT_PAGAM" ,"SUM",,,,,.F.,.T.)
	TRFunction():New(oSection3:Cell("RECEB3")     ,"TOT_RECEB" ,"SUM",,,,,.F.,.T.)
	TRFunction():New(oSection3:Cell("DIF_PAGREC") ,"TOT_PAGREC","SUM",,,,,.F.,.T.)

	oSection3:Print()

	(cAliasQry3)->(dbCloseArea())
	fErase ( cTrabalho3 + GetDBExtension() )
	fErase ( cTrabalho3 + OrdBagExt() )

EndIf

If(_oFINR120 <> NIL)
	_oFINR120:Delete()
	_oFINR120 := NIL
EndIf

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} Fr120Banco
Obtém a descrição do banco (SA6)	      

@author Daniel Batori
@since  07/06/2006
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function Fr120Banco ( cBcoAgenCt )

Local cDescricao := ""
Local cArquivo   := Alias ()
Local nOrdem     := 0

dbSelectArea ( "SA6" )
nOrdem := IndexOrd ()
SA6 -> ( dbSetOrder ( 1 ) )
If ( SA6 -> ( dbSeek ( cFilial + cBcoAgenCt ) ) )
	cDescricao := SA6 -> A6_NOME
Else
	cDescricao := OemToAnsi(STR0018) + cBcoAgenCt + " )"  //"BANCO NAO DEFINIDO ( "
End
SA6 -> ( dbSetOrder ( nOrdem ) )
dbSelectArea ( cArquivo )

Return ( cDescricao )

//-------------------------------------------------------------------
/*/{Protheus.doc} Fr120Banco
Obtém a descrição da Natureza (SED)	      

@author Daniel Batori
@since  07/06/2006
@version 12.1.17
/*/
//-------------------------------------------------------------------
Static Function FR120Natur( cNatureza )

Local cDescricao := ""
Local cArquivo   := Alias ()
Local nOrdem     := 0

dbSelectArea ( "SED" )
nOrdem := IndexOrd( )
SED -> ( dbSetOrder ( 1 ) )
If ( SED -> ( dbSeek ( cFilial + cNatureza ) ) )
	cDescricao := SED -> ED_DESCRIC
Else
	cDescricao := OemToAnsi(STR0019) + cNatureza + " )"  //"NATUREZA NAO DEFINIDA ( "
End

SED -> ( dbSetOrder ( nOrdem ) )
dbSelectArea ( cArquivo )

Return ( cDescricao )

//----------------------------------------------------------------
/*/{Protheus.doc}CalcSldIni
Função para cálculo do saldo inicial

@author Rodrigo.Pirolo
@since  13/03/2020
@version 12
@param dDtIni Dia inicial para emissão do relatorio
@param cBanco	- Codigo do Banco
@param cAgencia	- Numero da Agencia
@param cContaC	- Numero da Conta

@return nSaldoIni
/*/
//-----------------------------------------------------------------

Static Function CalcSldIni( dDtIni As Date, cBanco As Character, cAgencia As Character, cContaC As Character ) As Numeric

	Local cSaldo As Character
	Local cQry As Character
	Local nSaldoIni As Numeric
	Local aArea As Array

	Default dDtIni		:= CToD("  /  /    ")
	Default cBanco		:= ""
	Default cAgencia	:= ""
	Default cContaC		:= ""
	
	cSaldo		:= GetNextAlias()
	cQry		:= ""
	nSaldoIni	:= 0
	aArea		:= GetArea()

	If !Empty(cBanco)

		cQry := " SELECT SE8.E8_FILIAL,SE8.E8_BANCO,SE8.E8_AGENCIA,SE8.E8_CONTA,SE8.E8_DTSALAT,SE8.E8_SALATUA "
		cQry += " FROM " + RetSQLName("SE8") + " SE8 "
		cQry += " WHERE SE8.E8_FILIAL = '" + xFilial("SE8") + "' "
		cQry += 		" AND SE8.E8_BANCO = '" + cBanco + "' "
		cQry += 		" AND SE8.E8_AGENCIA = '" + cAgencia + "' "
		cQry += 		" AND SE8.E8_CONTA = '" + cContaC + "' "
		cQry += 		" AND SE8.E8_DTSALAT < '" + DToS( dDtIni ) + "' "
		cQry += 		" AND SE8.D_E_L_E_T_ = ' ' AND "
		cQry += 		" SE8.E8_DTSALAT IN ( "
		cQry += 							" SELECT MAX(SE8B.E8_DTSALAT) "
		cQry += 							" FROM " + RetSQLName("SE8") + " SE8B "
		cQry += 							" WHERE SE8B.E8_FILIAL = SE8.E8_FILIAL "
		cQry += 							" AND SE8B.E8_BANCO = SE8.E8_BANCO "
		cQry += 							" AND SE8B.E8_AGENCIA = SE8.E8_AGENCIA "
		cQry += 							" AND SE8B.E8_CONTA = SE8.E8_CONTA "
		cQry += 							" AND SE8B.E8_DTSALAT < '" + DToS( dDtIni ) + "' "
		cQry += 							" AND SE8B.D_E_L_E_T_ = ' ') "
		
		cQry := ChangeQuery(cQry)

		cSaldo   := MpSysOpenQuery( cQry, cSaldo )

		(cSaldo)->( DbGoTop() )
		
		While (cSaldo)->(!Eof())
			nSaldoIni	:= (cSaldo)->E8_SALATUA
			(cSaldo)->(DbSkip())
		EndDo

		(cSaldo)->( DbCloseArea() )
	EndIf

	RestArea(aArea)

Return nSaldoIni