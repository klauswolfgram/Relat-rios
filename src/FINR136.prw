/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR136.CH"

#DEFINE CLIENTE			1
#DEFINE NOM_CLIENTE		2
#DEFINE COMPROVANT		3
#DEFINE EMISSAO			4
#DEFINE VENCIMENTO		5
#DEFINE ORIGINAL		6
#DEFINE DEBITO			7
#DEFINE CREDITO			8
#DEFINE SALDO			9

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ Finr136  º Autor ³ Daniel Tadashi Batoriº Data ³  16/08/2006 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Demostrativo de compensacoes                 	            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Argentina                                       	            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr136()

	Local oReport	:= Nil
	Local lCliente	:= .F.
	
	Pergunte("FIR136",.T.)
	lCliente := (mv_par01 == 1)

	oReport := ReportDef(lCliente)
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 16.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef(lCliente)
Local oReport	:= Nil  
Local oSection1	:= Nil
Local cPerg		:= ""
Local nTam		:= 0
Local nTamVal	:= 0
Local cPictVal	:= ""
Local nTamComp	:= 0

If lCliente
	cPerg := "FRC136"
Else
	cPerg := "FRP136"
Endif

nTam	:= Max( (TamSX3("E1_TIPO")[1]+TamSX3("E1_NUM")[1]+7) , (TamSX3("E5_ORDREC")[1]+3) )
nTamVal	:= TamSX3("E5_VALOR")[1]
cPictVal:= PesqPict("SE5","E5_VALOR")
nTamComp:= 20
oReport	:= TReport():New("FINR136",STR0007,cPerg,{|oReport| ReportPrint(oReport,lCliente,nTamVal)},STR0002+STR0003) //"Estado de Compensaciones" - "Este programa tiene como objetivo imprimir el informe" - "de acuerdo con los parametr. indicados por el usuar."

oReport:SetPortrait(.T.)

pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01  	      	// de Cliente/Fornecedor                 ³
//³ mv_par02            // Ate Cliente/Forncedor                 ³
//³ mv_par03            // Considerar fecha                      ³
//³ mv_par04            // Data de                               ³
//³ mv_par05            // Data Ate                              ³
//³ mv_par06            // Avaliar                               ³
//³ mv_par07            // Saldos                                ³
//³ mv_par08            // De  Modalidade                        ³
//³ mv_par09            // Ate Modalidade                        ³
//³ mv_par10            // Moeda                                 ³
//³ mv_par11            // Outras Moedas  Converter/Nao Imprimir ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New(oReport,STR0027,,) //"Titulos por cobr."
TRCell():New(oSection1,"E1_CLIENTE","SE1",,,,.F.,) //"Cliente"
TRCell():New(oSection1,"A1_NREDUZ","SA1",,,,.F.,)  //"Razao Social"
TRCell():New(oSection1,"COMPROVANTE",,STR0020,,nTam,.F.,)  //"Comprovante"
TRCell():New(oSection1,"E1_EMISSAO","SE1",,,,.F.,)  //"Emissao"
TRCell():New(oSection1,"E1_VENCTO","SE1",,,,.F.,)  //"Vcto"
TRCell():New(oSection1,"ORIGINAL",,STR0023,cPictVal,nTamVal,.F.,)  //"Val Original"
TRCell():New(oSection1,"DEBITO",,STR0024,cPictVal,nTamVal,.F.,)  //"Debito"
TRCell():New(oSection1,"CREDITO",,STR0025,cPictVal,nTamVal,.F.,)  //"Credito"
TRCell():New(oSection1,"SALDO",,STR0026,cPictVal,nTamVal,.F.,)  //"Saldo"

oSection2 := TRSection():New(oReport,STR0028,,) //"Tit. por pagar"
TRCell():New(oSection2,"E2_FORNECE","SE2",,,,.F.,) //"Cliente"
TRCell():New(oSection2,"A2_NREDUZ","SA2",,,,.F.,)  //"Razao Social"
TRCell():New(oSection2,"COMPROVANTE",,STR0020,,nTamComp,.F.,)  //"Comprovante"
TRCell():New(oSection2,"E2_EMISSAO","SE2",,,,.F.,)  //"Emissao"
TRCell():New(oSection2,"E2_VENCTO","SE2",,,,.F.,)  //"Vcto"
TRCell():New(oSection2,"ORIGINAL",,STR0023,cPictVal,nTamVal,.F.,)  //"Val Original"
TRCell():New(oSection2,"DEBITO",,STR0024,cPictVal,nTamVal,.F.,)  //"Debito"
TRCell():New(oSection2,"CREDITO",,STR0025,cPictVal,nTamVal,.F.,)  //"Credito"
TRCell():New(oSection2,"SALDO",,STR0026,cPictVal,nTamVal,.F.,)  //"Saldo"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³16.08.06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport,lCliente,nTamVal)
Local oSection1  := If(lCliente,oReport:Section(1),oReport:Section(2))
Local aDados[9]
Local nPos
Local nRow, nPosDebi, nPosCred, nPosSald
Local cLinha
Local cFiltroSA	:=	oSection1:GetAdvPlExp(If(lCliente,'SA1','SA2'))
Local cFiltroSE	:=	oSection1:GetSqlExp(If(lCliente,'SE1','SE2'))
Local cString     := If(lCliente,"SE1","SE2")
Local cChave
Local nDebCliTot:=nCredCliTot:=nSaldoCli:=0
Local lQuery:=.F.
Local lRABaixado:=.F.
Local lEstorno := .F.
Local cChaveSeq := ""
Local nLoop := 0
Local nTaxa  := 0
Local nValor := 0
Local nRegSE5 := 0 
Local nConsidera,dDataDe,dDataAte,nEvaluar,nSaldos,cDeModalid,cAteModalid,nMoeda  
Local nTamDoc := Iif(cPaisLoc=="MEX",TamSx3("E2_NUM")[1]+7,19)

Private cTipos  // Usada por la funcion FinrTipos().

cDeCliFor   := mv_par01
cAteCliFor  := mv_par02
nConsidera  := mv_par03
dDataDe		:= mv_par04
dDataAte	   := mv_par05
nEvaluar 	:= mv_par06
nSaldos		:= mv_par07
cDeModalid	:= mv_par08
cAteModalid	:= mv_par09
nMoeda     	:= mv_par10
nConvNoImp 	:= mv_par11
If lCliente
	oSection1:Cell("E1_CLIENTE"):SetBlock( { || aDados[CLIENTE] })
	oSection1:Cell("A1_NREDUZ"):SetBlock( { || aDados[NOM_CLIENTE] })
	oSection1:Cell("E1_EMISSAO"):SetBlock( { || aDados[EMISSAO] })
	oSection1:Cell("E1_VENCTO"):SetBlock( { || aDados[VENCIMENTO] })
	nPos		:= oSection1:Cell("E1_VENCTO"):ColPos()
Else
	oSection1:Cell("E2_FORNECE"):SetBlock( { || aDados[CLIENTE] })
	oSection1:Cell("A2_NREDUZ"):SetBlock( { || aDados[NOM_CLIENTE] })
	oSection1:Cell("E2_EMISSAO"):SetBlock( { || aDados[EMISSAO] })
	oSection1:Cell("E2_VENCTO"):SetBlock( { || aDados[VENCIMENTO] })
	nPos		:= oSection1:Cell("E2_VENCTO"):ColPos()
Endif	
oSection1:Cell("COMPROVANTE"):SetBlock( { || aDados[COMPROVANT] })
oSection1:Cell("ORIGINAL"):SetBlock( { || aDados[ORIGINAL] })
oSection1:Cell("DEBITO"):SetBlock( { || aDados[DEBITO] })
oSection1:Cell("CREDITO"):SetBlock( { || aDados[CREDITO] })
oSection1:Cell("SALDO"):SetBlock( { || aDados[SALDO] })

If cPaisLoc=="MEX"
	nPosDebi	:= oSection1:Cell("DEBITO"):Col()
	nPosCred	:= oSection1:Cell("CREDITO"):Col()
	nPosSald	:= oSection1:Cell("SALDO"):Col()
Else
	nPosDebi	:= oSection1:Cell("DEBITO"):ColPos()
	nPosCred	:= oSection1:Cell("CREDITO"):ColPos()
	nPosSald	:= oSection1:Cell("SALDO"):ColPos()
EndIf

If nEvaluar == 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta janela para selecionar os tipos de titulos a serem tratados,³
	//³retorno na variavel cTipos que deve ser declarada como Private.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	FinrTipos()
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de Entrada que permite ao usuario a manipulacao da      ³
//³variavel cTipos retornada pela funcao FinrTipos().            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistBlock("FR136TIP")
	ExecBlock("FR136TIP",.F.,.F.)
EndIf

DbSelectArea(cString)
DbSetOrder(2) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO - E2_FILIAL+E2_NATUREZ+E2_NOMFOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE 
DbGoTop()

	lQuery:=.T.
	aStru := (cString)->(dbStruct())
	dbCloseArea()
	dbSelectArea(cString)
	
	If lCliente
		cQuery := "SELECT SE1.*, R_E_C_N_O_ AS NUMREC FROM " + RetSQLname(cString) + " SE1 "
		cQuery += " WHERE D_E_L_E_T_ = ' '"
		cQuery += " AND E1_FILIAL  = '"  + xFilial(cString) + "'"
		cQuery += " AND E1_CLIENTE BETWEEN '" + cDeCliFor + "' AND '" + cAteCliFor + "'"
		cQuery += " AND E1_NATUREZ BETWEEN '" + cDeModalid + "' AND '" + cAteModalid + "'"
		If nConsidera == 1
			If !Empty(dDataDe)
				cQuery += " AND E1_EMISSAO BETWEEN '" + DTOS(dDataDe) + "' AND '" + DTOS(dDataAte) + "'"
			EndIf
		Else
			If !Empty(dDataDe)
				cQuery += " AND E1_VENCTO BETWEEN '" + DTOS(dDataDe) + "' AND '" + DTOS(dDataAte) + "'"
			EndIf
		EndIf
		IF cTipos <> Nil
			cQuery += " AND E1_TIPO IN "+FormatIn(cTipos,"/")
		EndIf
		cQuery += " AND E1_BAIXA <> '' "
	Else
		cQuery := "SELECT SE2.*, R_E_C_N_O_ AS NUMREC FROM " + RetSQLname(cString) + " SE2 "
		cQuery += " WHERE D_E_L_E_T_ = ' '"
		cQuery += " AND E2_FILIAL  = '"  + xFilial(cString) + "'"
		cQuery += " AND E2_FORNECE BETWEEN '" + cDeCliFor + "' AND '" + cAteCliFor + "'"
		cQuery += " AND E2_NATUREZ BETWEEN '" + cDeModalid + "' AND '" + cAteModalid + "'"
		If nConsidera == 1
			If !Empty(dDataDe)
				cQuery += " AND E2_EMISSAO BETWEEN '" + DTOS(dDataDe) + "' AND '" + DTOS(dDataAte) + "'"
			EndIf
		Else
			If !Empty(dDataDe)
				cQuery += " AND E2_VENCTO BETWEEN '" + DTOS(dDataDe) + "' AND '" + DTOS(dDataAte) + "'"
			EndIf
		EndIf
		IF cTipos <> Nil
			cQuery += " AND E2_TIPO IN " + FormatIn(cTipos,"/")
		EndIf
		cQuery += " AND E2_BAIXA <> '' "
	EndIf
	If !Empty(cFiltroSE)
		cQuery	+=	" AND ("+cQuery+") "
	Endif
	cQuery	+=	" Order By " + SqlOrder(IndexKey())
	cQuery := ChangeQuery(cQuery)
	
	cString:="TMP"
	
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cString, .F., .T.)
	
	For nLoop := 1 to Len(aStru)
		If aStru[nLoop,2] <> "C"
			TCSetField(cString, aStru[nLoop,1], aStru[nLoop,2],;
			aStru[nLoop,3], aStru[nLoop,4])
		Endif
	Next
	
	dbSelectArea(cString)
	TMP->(dbGoTop())
      
cAlias := Alias()

oSection1:Init()
aFill(aDados,nil)

oReport:SetMeter((cAlias)->(RecCount()))

cCliFor := If(lCliente,(cAlias)->E1_CLIENTE,(cAlias)->E2_FORNECE)
Do While !Eof() .And. IIf(lCliente,(cAlias)->E1_CLIENTE <= cAteCliFor,(cAlias)->E2_FORNECE <= cAteCliFor)
	
	If ! lQuery
		If lCliente
			If (cAlias)->E1_NATUREZ < cDeModalid .And. (cAlias)->E1_NATUREZ > cAteModalid
				DbSkip()
				Loop
			EndIf
		
			If nConsidera == 1
				If (cAlias)->E1_EMISSAO < dDataDe .And. (cAlias)->E1_EMISSAO > dDataAte
					DbSkip()
					Loop
				EndIf
			Else
				If (cAlias)->E1_VENCTO < dDataDe .And. (cAlias)->E1_VENCTO > dDataAte
					DbSkip()
					Loop
				EndIf
			EndIf
			
			IF cTipos <> Nil .And. ! (cAlias)->E1_TIPO $ cTipos
				DbSkip()
				Loop
			EndIf
			SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA 
			SA1->(MsSeek(xFilial("SA1")+(cAlias)->E1_CLIENTE))
		Else
			If (cAlias)->E2_NATUREZ < cDeModalid .And. (cAlias)->E2_NATUREZ > cAteModalid
				DbSkip()
				Loop
			EndIf
			
			If nConsidera == 1
				If (cAlias)->E2_EMISSAO < dDataDe .And. (cAlias)->E2_EMISSAO > dDataAte
					DbSkip()
					Loop
				EndIf
			Else
				If (cAlias)->E2_VENCTO < dDataDe .And. (cAlias)->E2_VENCTO > dDataAte
					DbSkip()
					Loop
				EndIf
			EndIf
			
			//Titulos sem compensacoes nao devem ser considerados.
			If Empty((cAlias)->E2_BAIXA )
				DbSkip()
				Loop
			Endif
			
			IF cTipos <> Nil .And. ! (cAlias)->E2_TIPO $ cTipos
				DbSkip()
				Loop
			EndIf
			SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
			SA2->(MsSeek(xFilial("SA2")+(cAlias)->E2_FORNECE))
		EndIf
	EndIf

	//Filtra tabela SE1 ou SE2
	If !Empty(cFiltroSE) .And. !(&cFiltroSE)
		DbSkip()
		Loop
	EndIf

	//Filtra tabela SE1 ou SE2
	If !Empty(cFiltroSA) 
		If lCliente
			If !(SA1->&(cFiltroSA))
				DbSkip()
				Loop
			Endif
		Else		
			If !(SA2->&(cFiltroSA))
				DbSkip()
				Loop
			Endif
		Endif
	EndIf

	If lCliente
		nSaldoTit:=SaldoTit((cAlias)->E1_PREFIXO, (cAlias)->E1_NUM, (cAlias)->E1_PARCELA,;
		(cAlias)->E1_TIPO, (cAlias)->E1_NATUREZ, "R", (cAlias)->E1_CLIENTE, nMoeda,,,(cAlias)->E1_LOJA)
	Else
		nSaldoTit:=SaldoTit((cAlias)->E2_PREFIXO, (cAlias)->E2_NUM, (cAlias)->E2_PARCELA,;
		(cAlias)->E2_TIPO, (cAlias)->E2_NATUREZ, "P", (cAlias)->E2_FORNECE, nMoeda,,,(cAlias)->E2_LOJA)
	EndIf
	DbSelectArea(cAlias)	
	If nSaldos == 1
		If nSaldoTit <= 0
			DbSkip()
			Loop
		EndIf
	ElseIf nSaldos == 2
		If nSaldoTit >= 0
			DbSkip()
			Loop
		EndIf
	ElseIf nSaldos == 3
		If nSaldoTit <> 0
			DbSkip()
			Loop
		EndIf
	EndIf
	If nConvNoImp == 2 .And. nMoeda <> If(lCliente,(cAlias)->E1_MOEDA,(cAlias)->E2_MOEDA)
		DbSkip()
		Loop
	EndIf
	     
	// Tratamento da correcao monetaria                        
	If !lCliente .and. (cAlias)->(FieldPos("E2_CONVERT")) > 0
		If cPaisLoc <> "BRA" .And. If(lCliente,(cAlias)->E1_CONVERT=='N',(cAlias)->E2_CONVERT=='N')
			DbSkip()
			Loop
		EndIf
	EndIf	
	
	nDebTot := 0
	nCredTot := 0
	nSaldo := 0

	If cCliFor <> If(lCliente,(cAlias)->E1_CLIENTE,(cAlias)->E2_FORNECE)
		If lCliente
			oReport:PrintText(PadL(STR0013,58)) //"Totais do Cliente :"
		Else
			oReport:PrintText(PadL(STR0014,58)) //"Totais Fornecedor :"
		EndIf
		aDados[DEBITO]  := nDebCliTot
		aDados[CREDITO] := nCredCliTot
		aDados[SALDO]   := nSaldoCli
		IIf(lCliente,SE1->(MsGoTo((cAlias)->NUMREC)),SE2->(MsGoTo((cAlias)->NUMREC)))
		oSection1:PrintLine()
		aFill(aDados,nil)
		oReport:SkipLine()

		cCliFor:=If(lCliente,(cAlias)->E1_CLIENTE,(cAlias)->E2_FORNECE)
		nDebCliTot:=nCredCliTot:=nSaldoCli:=0
	EndIf
	
	If lCliente
		SA1->(DbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA
		SA1->(MsSeek(xFilial("SA1")+(cAlias)->E1_CLIENTE))
		nTaxa:=Iif(MV_PAR12==2,Iif(!Empty((cAlias)->E1_TXMOEDA),(cAlias)->E1_TXMOEDA,RecMoeda((cAlias)->E1_EMISSAO,(cAlias)->E1_MOEDA)),0)
		aDados[CLIENTE]     := (cAlias)->E1_CLIENTE
		aDados[NOM_CLIENTE] := SA1->A1_NREDUZ
		aDados[COMPROVANT]  := (cAlias)->E1_TIPO+" "+(cAlias)->E1_NUM
		aDados[EMISSAO]     := (cAlias)->E1_EMISSAO
		aDados[VENCIMENTO]  := (cAlias)->E1_VENCTO
		aDados[ORIGINAL]    := xMoeda((cAlias)->E1_VALOR,(cAlias)->E1_MOEDA,nMoeda,(cAlias)->E1_EMISSAO,,nTaxa)
		
		nValor := xMoeda((cAlias)->E1_VALOR,(cAlias)->E1_MOEDA,nMoeda,(cAlias)->E1_EMISSAO,,nTaxa)
		If !(cAlias)->E1_TIPO $ MV_CRNEG + "/" + MVRECANT
			aDados[DEBITO] := nValor
			nSaldo		+= nValor
			nDebTot		+= nValor
			nSaldoCli	+= nValor
			nDebCliTot	+= nValor
		Else
			aDados[CREDITO] := nValor
			nSaldo      -= nValor
			nCredTot    += nValor
			nSaldoCli   -= nValor
			nCredCliTot += nValor
		EndIf
		aDados[SALDO] := nSaldo
		
		cChave:=(cAlias)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)
	Else
		SA2->(DbSetOrder(1)) //A2_FILIAL+A2_COD+A2_LOJA
		SA2->(MsSeek(xFilial("SA2")+(cAlias)->E2_FORNECE))
		nTaxa:=Iif(MV_PAR12==2,Iif(!Empty((cAlias)->E2_TXMOEDA),(cAlias)->E2_TXMOEDA,RecMoeda((cAlias)->E2_EMISSAO,(cAlias)->E2_MOEDA)),0)
		aDados[CLIENTE]     := (cAlias)->E2_FORNECE
		aDados[NOM_CLIENTE] := SA2->A2_NREDUZ
		aDados[COMPROVANT]  := (cAlias)->E2_TIPO+" "+(cAlias)->E2_NUM
		aDados[EMISSAO]     := (cAlias)->E2_EMISSAO
		aDados[VENCIMENTO]  := (cAlias)->E2_VENCTO
		aDados[ORIGINAL]    := xMoeda((cAlias)->E2_VALOR,(cAlias)->E2_MOEDA,nMoeda,(cAlias)->E2_EMISSAO,,nTaxa)
		
		nValor := xMoeda((cAlias)->E2_VALOR,(cAlias)->E2_MOEDA,nMoeda,(cAlias)->E2_EMISSAO,,nTaxa)
		If !(cAlias)->E2_TIPO $ MV_CPNEG + "/" + MVPAGANT
			aDados[DEBITO] := nValor
			nSaldo      += nValor
			nDebTot     += nValor
			nSaldoCli   += nValor
			nDebCliTot  += nValor
		Else
			aDados[CREDITO] := nValor
			nSaldo      -= nValor
			nCredTot    += nValor
			nSaldoCli   -= nValor
			nCredCliTot += nValor
		EndIf
		aDados[SALDO] := nSaldo
		cChave:=(cAlias)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)
	EndIf
	
	oSection1:PrintLine()
	aFill(aDados,nil)
	
	SE5->(DbSetOrder(7)) //E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ
	SE5->(DbSeek(xFilial("SE5")+cChave))

	While SE5->(!Eof()) .and. SE5->E5_FILIAL == xFilial("SE5") .and.;
	      SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cChave

		If (SE5->E5_TIPODOC == IIF(lCliente,"RA","PA") .And. EMPTY(SE5->E5_DOCUMEN)  .And. EMPTY(SE5->E5_ORDREC)) .OR. (SE5->E5_SITUACA $("C|X") .And. EMPTY(SE5->E5_ORDREC))
			SE5->(DbSkip())
			Loop
		EndIf	 
		 
		If (SE5->E5_SITUACA $ "C" .And. !EMPTY(SE5->E5_ORDREC))  //caso o recibo tenha sido cancelado
			SE5->(DbSkip())
			Loop
		EndIf	      
              
		If SE5->E5_TIPO $ MVPAGANT .And. SE5->E5_TIPODOC=="BA".AND. SE5->E5_MOTBX=='NOR'.AND. SE5->E5_RECPAG=="P" .And. EMPTY(SE5->E5_DOCUMEN) //PA GERADO SEM GERAR CHEQUE
			SE5->(DbSkip())
			Loop
		EndIf	
		
		//Não imprime os estornos -- títulos a pagar
		If SE5->E5_TIPODOC=="ES" 
			SE5->(DbSkip())
			Loop
		EndIf
		
		//Se encontrar um estorno para a sequencia de baixa, não imprime no relatório -- titulos a pagar

	    nRegSE5 := SE5->(Recno())
	                                   
	    cChaveSeq := SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) 
	    
	    If SE5->(dbSeek(cChaveSeq))
	    	While !SE5->(Eof()) .And.SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) == cChaveSeq
	    		If SE5->E5_TIPODOC == "ES"
	    			lEstorno := .T.
	    			Exit	
	    		EndIf
	    		SE5->(DbSkip())
	    	EndDo 
	    	
	    	SE5->(dbGoTo(nRegSE5))
	    	
	    	If lEstorno
	    		SE5->(DbSkip())
				lEstorno := .F.
				Loop	
	    	Endif
		EndIf	
  
		If !Empty(SE5->E5_ORDREC).or. SE5->E5_MOTBX == "DIF"           
			If lCliente .and. (SE5->E5_RECPAG =="R" .or. SE5->E5_RECPAG=="P" .And. SE5->E5_TIPODOC=="ES" ).or.!lCliente .and. SE5->E5_RECPAG =="P"
				nTaxa:=Iif(MV_PAR12==2,Iif(!Empty(SE5->E5_TXMOEDA),SE5->E5_TXMOEDA,RecMoeda(SE5->E5_DATA,Val(SE5->E5_MOEDA))),0)
				nValor := xMoeda(SE5->E5_VALOR,Val(SE5->E5_MOEDA),nMoeda,SE5->E5_DATA,,nTaxa)
				If  lCliente .And. SE5->E5_RECPAG=="P" .And. SE5->E5_TIPODOC=="ES"
					aDados[COMPROVANT] := Space(3) + STR0017 + SE5->E5_ORDREC //"Est RC"
					aDados[EMISSAO]    := SE5->E5_DATA
					aDados[DEBITO]     := nValor
					nSaldo      += nValor
					nDebTot     += nValor
					nSaldoCli   += nValor
					nDebCliTot  += nValor
				Else
					aDados[COMPROVANT] := Space(3) + If(lCliente ,"RC","OP") + SE5->E5_ORDREC
					aDados[EMISSAO] := SE5->E5_DATA
					IF (!lCliente .And. !(SE5->E5_TIPO $ MVPAGANT+"/"+MV_CPNEG)).Or.;
						(lCliente .And. !(SE5->E5_TIPO $ MVRECANT+"/"+MV_CRNEG))
						aDados[CREDITO] := nValor
						nSaldo      -= nValor
						nCredTot    += nValor
						nSaldoCli   -= nValor	
						nCredCliTot += nValor
	   		  		Else
						aDados[DEBITO] := nValor
						nSaldo		+= nValor
						nDebTot		+= nValor
						nSaldoCli	+= nValor
						nDebCliTot	+= nValor
					Endif
				EndIf
			Endif
		Else
			aPosArea:=GetArea()
			If lCliente
				SE1->(DbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				
				If  Empty(SE5->E5_DOCUMEN) 
					SE1->(DbSeek(xFilial("SE1")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO))	
				Else 
					SE1->(DbSeek(xFilial("SE1")+Left(SE5->E5_DOCUMEN,nTamDoc)))
				End
				
				If SE5->E5_MOTBX <> "CEC"
 	            aDados[COMPROVANT] := Space(3) + SE1->E1_TIPO + " " + SE1->E1_NUM
				Else 
					aDados[COMPROVANT] := Space(3) + PadR(STR0016,12," ") //"Comp. Cart."
				EndIf

				aDados[EMISSAO] := SE1->E1_EMISSAO
				aDados[VENCIMENTO] := SE1->E1_VENCTO
				aDados[ORIGINAL] := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,nMoeda,SE1->E1_EMISSAO,,Iif(MV_PAR12==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))
				
				lRABaixado := .F.
				lRABaixado := SE1->E1_TIPO=="RA " .And. Empty(SE5->E5_DOCUMEN) .And. Empty(SE5->E5_ORDREC)
				nTaxa      := IIf(MV_PAR12==2,Iif(!Empty(SE5->E5_TXMOEDA),SE5->E5_TXMOEDA,RecMoeda(SE5->E5_DATA,Val(SE5->E5_MOEDA))),0)
				nValor     := xMoeda(SE5->E5_VALOR,Val(SE5->E5_MOEDA),nMoeda,SE5->E5_DATA,,nTaxa)
				If  SE1->E1_TIPO $ MV_CRNEG + "/" + MVRECANT .And. !lRABaixado
					aDados[CREDITO] := nValor
					nSaldo      -= nValor
					nCredTot    += nValor
					nSaldoCli   -= nValor
					nCredCliTot += nValor
				ElseIf SE5->E5_MOTBX <> "CEC"
					aDados[DEBITO] := nValor
					nSaldo     += nValor
					nDebTot    += nValor
					nSaldoCli  += nValor
					nDebCliTot += nValor
				Else
					aDados[CREDITO] := nValor
					nSaldo      -= nValor
					nCredTot    += nValor
					nSaldoCli   -= nValor
					nCredCliTot += nValor
				EndIf
			Else
				SE2->(DbSetOrder(1)) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
				
	   			If !Empty(SE5->E5_DOCUMEN)
					SE2->(DbSeek(xFilial("SE2")+Left(SE5->E5_DOCUMEN,nTamDoc)))
			 		Do While !SE2->(Eof()) .And. SE2->E2_FORNECE + SE2->E2_LOJA + SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO != SE5->E5_FORNADT + SE5->E5_LOJAADT + Left(SE5->E5_DOCUMEN,nTamDoc)
			  	 		SE2->(DbSkip())
				  	EndDo
				Else
					SE2->(DbSeek(xFilial("SE2")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO))
				EndIf
				
				If SE5->E5_MOTBX <> "CEC"
					aDados[COMPROVANT] := Space(3) + SE2->E2_TIPO + " " + SE2->E2_NUM
				Else
					aDados[COMPROVANT] := Space(3) + PadR(STR0016,12," ") //"Comp. Cart."
				EndIf
				
				aDados[EMISSAO]		:= SE2->E2_EMISSAO
				aDados[VENCIMENTO]	:= SE2->E2_VENCTO
				aDados[ORIGINAL]    := xMoeda(SE2->E2_VALOR,SE2->E2_MOEDA,nMoeda,SE2->E2_EMISSAO,,Iif(MV_PAR12==2,Iif(!Empty(SE2->E2_TXMOEDA),SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0))
				
				nTaxa  := Iif(MV_PAR12==2,Iif(!Empty(SE5->E5_TXMOEDA),SE5->E5_TXMOEDA,RecMoeda(SE5->E5_DATA,Val(SE5->E5_MOEDA))),0)
				If  nMoeda == 1 .And. Val(SE5->E5_MOEDA) != 1 .And. Empty(SE5->E5_ORDREC)
					nValor :=xMoeda(SE5->E5_VLMOED2,Val(SE5->E5_MOEDA),nMoeda,SE5->E5_DATA,TAMSX3("M2_MOEDA"+ALLTRIM(STR(nMoeda)))[2],nTaxa)
				Else 
    				If nMoeda != 1 .And. Val(SE5->E5_MOEDA) != 1 .And. Empty(SE5->E5_ORDREC)
						nValor :=xMoeda(SE5->E5_VALOR,1,Val(SE5->E5_MOEDA),SE5->E5_DATA,TAMSX3("M2_MOEDA1")[2],nTaxa)
					Else
						nValor :=xMoeda(SE5->E5_VALOR,Val(SE5->E5_MOEDA),nMoeda,SE5->E5_DATA,TAMSX3("M2_MOEDA"+ALLTRIM(STR(nMoeda)))[2],nTaxa)
					EndIf
				EndIf
				
				If  (SE2->E2_TIPO $ MV_CPNEG+"/"+MVPAGANT  .Or. SE2->E2_TIPO=="CH ") .And. !(SE2->E2_TIPO == "PA " .And. Empty(SE5->E5_DOCUMEN) .And. Empty(SE5->E5_ORDREC))
					aDados[CREDITO] := nValor
					nSaldo      -= nValor
					nCredTot    += nValor
					nSaldoCli   -= nValor
					nCredCliTot += nValor
				ElseIf SE5->E5_MOTBX <> "CEC"
					aDados[DEBITO] := nValor
					nSaldo     += nValor
					nDebTot    += nValor
					nSaldoCli  += nValor
					nDebCliTot += nValor
				Else
					aDados[CREDITO] := nValor
					nSaldo      -= nValor
					nCredTot    += nValor
					nSaldoCli   -= nValor
					nCredCliTot += nValor
				EndIf
			EndIf
			RestArea(aPosArea)
		EndIf
		aDados[SALDO] := nSaldo
		
		oSection1:PrintLine()
		aFill(aDados,nil)
		
		SE5->(DbSkip())
	EndDo
	
	nRow := oReport:Row()
	cLinha := Replicate("-",nTamVal)
	oReport:PrintText(cLinha, nRow, nPosDebi)
	oReport:PrintText(cLinha, nRow, nPosCred)
	oReport:PrintText(cLinha, nRow, nPosSald)
	oReport:SkipLine()
	
	aDados[COMPROVANT] := STR0015  // Totais :
	aDados[DEBITO]     := nDebTot
	aDados[CREDITO]    := nCredTot
	aDados[SALDO]      := nSaldo
	
	oSection1:PrintLine()
	aFill(aDados,nil)
	
	DbSkip()         // Avanza el puntero del registro en el archivo
	oReport:SkipLine()
	oReport:IncMeter()
EndDo

DbSkip(-1)
If (nDebCliTot + nCredCliTot) <> 0
	If lCliente
		nTaxa:=Iif(MV_PAR12==2,Iif(!Empty((cAlias)->E1_TXMOEDA),(cAlias)->E1_TXMOEDA,RecMoeda((cAlias)->E1_EMISSAO,(cAlias)->E1_MOEDA)),0)
		oReport:PrintText(STR0013,,nPos) //"Totais do Cliente :"
	Else
		nTaxa:=Iif(MV_PAR12==2,Iif(!Empty((cAlias)->E2_TXMOEDA),(cAlias)->E2_TXMOEDA,RecMoeda((cAlias)->E2_EMISSAO,(cAlias)->E2_MOEDA)),0)
		oReport:PrintText(STR0014,,nPos) //"Totais Fornecedor :"
	EndIf
	aDados[DEBITO]  := nDebCliTot
	aDados[CREDITO] := nCredCliTot
	aDados[SALDO]   := nSaldoCli
	oSection1:PrintLine()
	aFill(aDados,nil)
	oReport:SkipLine()
EndIf

oSection1:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice ou consulta(Query)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
dbCloseArea()

DbSelectArea(If(lCliente,"SE1","SE2"))

Return Nil
