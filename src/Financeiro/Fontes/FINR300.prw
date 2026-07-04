/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "FINR300.CH"
#Include "PROTHEUS.CH"

#DEFINE NOMEDOCLIENTE    1
#DEFINE VALOREMATRASO    2
#DEFINE VALORDEVIDO      3
#DEFINE VALORTOTAL       4
#DEFINE NRODETITULOS     5
#DEFINE DIASATRASADOS    6
#DEFINE CODIGODOCLIENTE  7
#DEFINE LOJADOCLIENTE    8
#DEFINE PREFIXO          9
#DEFINE NUMEROTITULO     10
#DEFINE PARCELA          11
#DEFINE TIPO             12

Static _oFINR3001

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ FINR300	³ Autor ³ Daniel Tadashi Batori ³ Data ³ 06.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos maiores atrasos/devedores					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR300(void)											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FinR300()

Local oReport


oReport := ReportDef()
oReport:PrintDialog()


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 06.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio				     		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport
Local oSection1
Local nTamVal, cPict

oReport := TReport():New("FINR300",STR0005,"FIN300",{|oReport| ReportPrint(oReport)},STR0001 + STR0002)

Pergunte("FIN300", .F.)

nTamVal := TamSX3("E1_VALOR")[1]
cPict := PesqPict("SE1","E1_VALOR")

oSection1 := TRSection():New(oReport,STR0023,{"SE1","SA1"},) //"Itens do atraso"
TRCell():New(oSection1,"COD_CLI"   ,"SE1",STR0017,,,.F.,)  //definido por SetBlock
TRCell():New(oSection1,"A1_NOME"   ,"SA1",,,,.F.,)
TRCell():New(oSection1,"VAL_ATRASO",,STR0018,cPict,nTamVal,.F.,) //"Valor em Atraso"
TRCell():New(oSection1,"VAL_DEVIDO",,STR0019,cPict,nTamVal,.F.,) //"Valor Total Devido"
TRCell():New(oSection1,"QTDE_TIT"  ,"SE1",STR0020,,7,.F.,) //"N.Tit"
TRCell():New(oSection1,"PERC_TOT"  ,"SE1",STR0021,"@E 999.9",5,.F.,) //"%Tot"
TRCell():New(oSection1,"D_ATRASO"  ,,STR0022,"@E 9999",4,.F.,) //"Dias em Atraso"

TRFunction():New(oSection1:Cell("VAL_ATRASO"),"VAL_ATRA","SUM",,,,,.T.,.F.) //"Valor em Atraso"
TRFunction():New(oSection1:Cell("VAL_DEVIDO"),"VAL_DEV" ,"SUM",,,,,.T.,.F.)
TRFunction():New(oSection1:Cell("QTDE_TIT")  ,"QTDE_TIT","SUM",,,,,.T.,.F.)
TRFunction():New(oSection1:Cell("D_ATRASO")  ,"D_ATRASO","AVERAGE",,,,,.T.,.F.)

oSection1:SetTotalInLine(.F.)

oSection1:SetPageBreak(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³26/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local oSection1  	:= oReport:Section(1)
Local cWhere 		:= ""
Local cAlias 		:= "SE1"
Local cAliasQry	:= GetNextAlias()
Local nFirst 		:= 0
Local cCliAnt
Local aDados[12]
Local aTemp 		:= {}
Local lSoma
Local nSaldo
Local nDecs 		:= MsDecimais(mv_par03)
Local nDiasAtraso 	:= 0
Local nLinha		:= 0
Local oTRPosition
Local cFilUser		:= ""
Local nJuros		:= 0
Local nVA			:= 0
Local nMulta		:= 0
Local cMvJurTipo	:= SuperGetMv("MV_JURTIPO",,"")  // calculo de Multa do Loja , se JURTIPO == L
Local nRecno		:= 0
Local lJurVar		:= ValType('lReclcJur') == 'L'
Local lExistVlAc	:= ExistFunc('FValAcess')

dbSelectarea("SE1")
dbSetOrder(2)

oReport:NoUserFilter()

If  mv_par04 == 2 		//4-Outras moedas/nao imprimir
	cWhere := " AND E1_MOEDA = " + AllTrim(Str(mv_par03))
EndIf

cFilUser := oSection1:GetSqlExp()
If !Empty(cFilUser)
	cWhere += " AND " + cFilUser
EndIf

cWhere += " AND SE1.E1_SALDO+(SE1.E1_SDACRES-SE1.E1_SDDECRE) > 0 "

cWhere += " ORDER BY " + SqlOrder(IndexKey())
dbCloseArea()

cWhere := "% " + cWhere + " %"

BeginSql Alias cAliasQry
	column E1_VENCREA as Date
	SELECT SA1.A1_NOME, SE1.*
	FROM %table:SE1% SE1 JOIN %table:SA1% SA1 ON A1_FILIAL = %xFilial:SA1% AND E1_CLIENTE = A1_COD AND E1_LOJA = A1_LOJA
	WHERE E1_FILIAL = %xFilial:SE1%
			AND SE1.%NotDel% AND SA1.%NotDel%
			%Exp:cWhere%
EndSQL

(cAliasQry)->(dbGoTop())
aDados[VALORTOTAL] := 0	// Valor Total Dos Saldos dos titulos

While (cAliasQry)->(!Eof()) .And. (cAliasQry)->E1_FILIAL == xFilial("SE1")

	aDados[NOMEDOCLIENTE]   := Space(30) //SA1->A1_NOME   NOME DO CLIENTE
	aDados[VALOREMATRASO]   := 0         // Valor Em Atraso
	aDados[VALORDEVIDO]     := 0         // Valor Devido
	aDados[NRODETITULOS]    := 0         //No de titulos
	aDados[DIASATRASADOS]   := 0         //QTDE. DIAS ATRASADOS
	aDados[CODIGODOCLIENTE] := ""        //E1_CLIENTE    CODIGO DO CLIENTE
	aDados[LOJADOCLIENTE]   := ""        //E1_LOJA       CODIGO LOJA
	aDados[PREFIXO]         := ""        //E1_PREFIXO    PREFIXO DO TITULO
	aDados[NUMEROTITULO]    := ""        //E1_NUM        NUMERO DO TITULO
	aDados[PARCELA]         := ""        //E1_PARCELA    PARCELA DO TITULO
	aDados[TIPO]            := ""        //E1_TIPO       TIPO DO TITULO

	nFirst  := 1
	cCliAnt := (cAliasQry)->E1_CLIENTE+E1_LOJA

	While (cAliasQry)->E1_FILIAL == xFilial("SE1") .And.	;
			(cAliasQry)->E1_CLIENTE+E1_LOJA == cCliAnt .And.;
			(cAliasQry)->(!Eof())

		If nFirst = 1
			aDados[NOMEDOCLIENTE]   := (cAliasQry)->A1_NOME		//SubStr(A1_NOME,1,30)
			aDados[CODIGODOCLIENTE] := (cAliasQry)->E1_CLIENTE
			aDados[LOJADOCLIENTE]   := (cAliasQry)->E1_LOJA
			aDados[PREFIXO]         := (cAliasQry)->E1_PREFIXO
			aDados[NUMEROTITULO]    := (cAliasQry)->E1_NUM
			aDados[PARCELA]         := (cAliasQry)->E1_PARCELA
			aDados[TIPO]            := (cAliasQry)->E1_TIPO
			nFirst++
		Endif

		lSoma := .T.

		If (cAliasQry)->E1_TIPO $ MVABATIM+"/"+MVRECANT+"/"+MV_CRNEG
			lSoma := .F.
		EndIf

		nTxMoeda := (cAliasQry)->E1_MOEDA
		
		nRecno := (cAliasQry)->R_E_C_N_O_ 
		
		cAlias := "SE1"
		(cAlias)->(DbGoto(nRecno))
		
		//Calculo do valor devido referente a juros
		If lJurVar
			nJuros := fa070Juros(E1_MOEDA,E1_SALDO,,Stod(E1_BAIXA),Iif( lReclcJur , nTxMoeda , Nil ) )
		Else
			nJuros := fa070Juros(E1_MOEDA,E1_SALDO,,Stod(E1_BAIXA))
		EndIf
		
		//Calculo do valor devido referente aos valores acessórios
		nVA := IIf(lExistVlAc,FValAcess(E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_CLIENTE,E1_LOJA,E1_NATUREZ, Iif(Empty(E1_BAIXA),.F.,.T.),"","R",dDataBase),0)
		
		nMulta := LojxRMul( , , ,SE1->E1_SALDO, SE1->E1_ACRESC, SE1->E1_VENCREA, dDataBase, , SE1->E1_MULTA, ,;
		  					 SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_TIPO, SE1->E1_CLIENTE, SE1->E1_LOJA, "SE1",.T. ) 
		  					 
		nSaldo := xMoeda(((cAliasQry)->E1_SALDO+E1_SDACRES-E1_SDDECRE)+nJuros+nVA+nMulta,(cAliasQry)->E1_MOEDA,mv_par03,,nDecs+1)

		If (cAliasQry)->E1_VENCREA < dDataBase .and. nSaldo != 0
			If lSoma
				aDados[VALOREMATRASO] += nSaldo  // Valor Em Atraso
			Else
				aDados[VALOREMATRASO] -= nSaldo  // Valor Em Atraso
			Endif

			If !(AllTrim((cAliasQry)->E1_TIPO) $ AllTrim(MVABATIM+"|RA|NCC"))
				aDados[NRODETITULOS]++    // No. de titulos

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Calcula a Quantidade de Dias em Atraso.                      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nDiasAtraso := dDataBase - (cAliasQry)->E1_VENCREA

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Armazena a Quantidade de Dias em Atraso de acordo com a esco-³
				//³ lha do Usuario : mv_par02 == 1 (Media) / 2 (Maior Atraso)    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If mv_par02 == 1
					aDados[DIASATRASADOS] += nDiasAtraso
				Else
					aDados[DIASATRASADOS] := If(aDados[DIASATRASADOS] < nDiasAtraso, nDiasAtraso, aDados[DIASATRASADOS])
				EndIf
			EndIf

		Endif

		If lSoma
			aDados[VALORDEVIDO] += nSaldo  // Valor Devido
			aDados[VALORTOTAL] += nSaldo  // Valor Total Dos Saldos dos titulos
		Else
			aDados[VALORDEVIDO] -= nSaldo  // Valor Devido
			aDados[VALORTOTAL] -= nSaldo  // Valor Total Dos Saldos dos titulos
		Endif

		(cAliasQry)->(dbSkip())
	Enddo

	aADD(aTemp,{ aDados[CODIGODOCLIENTE],;		//E1_CLIENTE
					 aDados[LOJADOCLIENTE],;	//E1_LOJA
					 aDados[NOMEDOCLIENTE],;	//A1_NOME
					 aDados[VALOREMATRASO],;	//Valor Em Atraso
					 aDados[VALORDEVIDO],;		//Valor Devido
					 aDados[NRODETITULOS],;		//No de titulos
					 If(mv_par02 == 1, ROUND(aDados[DIASATRASADOS] / aDados[NRODETITULOS],0), aDados[DIASATRASADOS]),; //QTDE. DIAS ATRASADOS
					 aDados[PREFIXO],; // Prefixo
					 aDados[NUMEROTITULO],; // numero 
					 aDados[PARCELA],; // parcela
					 aDados[TIPO]})   // tipo

EndDo

oReport:SetMeter(Len(aTemp))

oSection1:Cell("COD_CLI" ):SetBlock( { || aTemp[nLinha,1] + " " + aTemp[nLinha,2] } )
oSection1:Cell("A1_NOME" ):SetBlock( { || aTemp[nLinha,3] } )
oSection1:Cell("VAL_ATRASO"):SetBlock(	 { || ROUND(aTemp[nLinha,4],2) } )
oSection1:Cell("VAL_DEVIDO"):SetBlock(	 { || ROUND(aTemp[nLinha,5],2) } )
oSection1:Cell("QTDE_TIT"):SetBlock( { || aTemp[nLinha,6] } )
oSection1:Cell("PERC_TOT"):SetBlock( { || ROUND(aTemp[nLinha,5] / aDados[VALORTOTAL],1) * 100 } )
oSection1:Cell("D_ATRASO"):SetBlock( { || aTemp[nLinha,7] } )

Asort(aTemp,,,{|x,y| x[5] > y[5] })

If mv_par01 = 1
	oReport:SetTitle( STR0006 )  //'Relacao Do Maior Devedor'
Else
	oReport:SetTitle( STR0007+alltrim(str(mv_par01))+STR0015 )  //'Relacao dos '###' Maiores Devedores'
Endif

oSection1:Init()

//este TRPosition serve para quando o usuario incluir celulas do SA1 no relatorio.
	TRPosition():New(oSection1, "SA1", 1, {|| xFilial("SA1")+aTemp[nLinha,1] + aTemp[nLinha,2] }, .T. )
	//este TRPosition serve para quando o usuario incluir celulas do SE1 no relatorio.
	TRPosition():New(oSection1, "SE1", 2, {|| xFilial("SE1")+aTemp[nLinha,1] + aTemp[nLinha,2]+aTemp[nLinha,8]+aTemp[nLinha,9]+aTemp[nLinha,10]+aTemp[nLinha,11] }, .T. )
	
For nLinha := 1 to Min( Len(aTemp) , mv_par01 )	

	oReport:IncMeter()

	IF aTemp[nLinha,4] + aTemp[nLinha,5] > 0
		oSection1:PrintLine()
	Endif
 
Next
oSection1:Finish()


If oReport:nDevice != 4
	Asort(aTemp,,,{|x,y| x[4] > y[4] })

	If mv_par01 = 1
		oReport:SetTitle( STR0011 )  //'Relacao do Maior Atraso'
	Else
		oReport:SetTitle( STR0007+alltrim(str(mv_par01))+STR0013 )  //'Relacao dos '###' maiores atrasos'
	Endif

	oSection1:Init()
	For nLinha := 1 to Min( Len(aTemp) , mv_par01 )
		oReport:IncMeter()	

		IF aTemp[nLinha,4] + aTemp[nLinha,5] > 0
			oSection1:PrintLine()
		Endif
	Next
	oSection1:Finish()
EndIf


Return
