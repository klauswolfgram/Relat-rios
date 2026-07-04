/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAGRR100   บ Autor ณ Saulo Carvalho Gomesบ Data ณ  31/10/05  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rela็ใo de compromissos futuros.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function AGRR100()

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Compromissos Futuros"
	Local titulo         := "Compromissos Futuros"
	Local nLin           := 80
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 220
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR100'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR100"
	Private wnrel       := "AGRR100"

	dbSelectArea("NO1")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint("NO1",NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,Tamanho,,.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NO1')

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  01/10/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local cQuery    := ''
	Local cMoeda    := SuperGetMv('MV_SIMB1',.F. ,"R$")
	Private cAliasNO1 := 'NO1'

	/*
	1         1         1         1         1         1         1         1         1         1         2         2
	1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	Cliente                                            Endere็o                                 Municipio
	XXXXXX-XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX
	N. CP. Numero Complementar  Safra                  Emissao  Vencto   Moeda         Produto                                 UM     Quantidade Observa็๕es
	XXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXX-XXXXXXXXXXXXXXX XX/XX/XX XX/XX/XX XX-XXXXXXXXXX XXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXXX XX XXX,XXX,XXX.XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	*/
	Cabec1 := " Cliente                                            Endere็o"
	Cabec2 := " N. CP. Numero Complementar  Safra                  Emissao  Vencto   Moeda         Produto                                 UM     Quantidade Observa็๕es"

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Filtra tabela para listagem de contratos.                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	#IFDEF TOP
	cAliasNO1 := GetNextAlias()

	cQuery := "SELECT *"
	cQuery += " FROM "+RetSqlName('NO1')
	cQuery += " WHERE NO1_FILIAL='"+xFilial('NO1')+"'"
	cQuery += " AND NO1_NUMERO>='"+MV_PAR01+ "' AND NO1_NUMERO<='"+MV_PAR02+"'"
	cQuery += " AND NO1_SAFRA>='" +MV_PAR03+ "' AND NO1_SAFRA<='" +MV_PAR04+"'"
	cQuery += " AND NO1_CODCLI+NO1_LOJCLI>='"+MV_PAR05+ "' AND NO1_CODCLI+NO1_LOJCLI<='"+MV_PAR06+"'"
	cQuery += " AND NO1_DATEMI>='"+DToS(MV_PAR07)+ "' AND NO1_DATEMI<='" +DToS(MV_PAR08)+"'"
	cQuery += " AND NO1_DATVEN>='"+DToS(MV_PAR09)+ "' AND NO1_DATVEN<='" +DToS(MV_PAR10)+"'"
	If MV_PAR13==1
		cQuery += " AND (NO1_FECHAD=' ' OR NO1_FECHAD='N')"
	Else
		If MV_PAR13==2
			cQuery += " AND NO1_FECHAD='S'"
		EndIf
	EndIf
	cQuery += " AND D_E_L_E_T_<>'*'"
	cQuery += " ORDER BY NO1_CODCLI+NO1_LOJCLI, NO1_NUMERO"

	cQuery := ChangeQuery(cQuery) 
	dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),cAliasNO1,.F.,.T. )
	#ELSE
	cAliasNO1 := 'NO1'

	cQuery := "NO1_FILIAL=='"+xFilial('NO1')+"'"
	cQuery += " .And. NO1_NUMERO>='"+MV_PAR01            +"' .And. NO1_NUMERO<='"+MV_PAR02+"'"
	cQuery += " .And. NO1_SAFRA >='"+MV_PAR03            +"' .And. NO1_SAFRA <='"+MV_PAR04+"'"
	cQuery += " .And. NO1_CODCLI>='"+Substr(MV_PAR05,1,6)+"' .And. NO1_CODCLI<='"+Substr(MV_PAR06,1,6)+"'"
	cQuery += " .And. NO1_LOJCLI>='"+Substr(MV_PAR05,7,2)+"' .And. NO1_LOJCLI<='"+Substr(MV_PAR06,7,2)+"'"
	cQuery += " .And. DToS(NO1_DATEMI)>='"+DToS(MV_PAR07)+"' .And. DToS(NO1_DATEMI)<='"+DToS(MV_PAR08)+"'"
	cQuery += " .And. DToS(NO1_DATVEN)>='"+DToS(MV_PAR09)+"' .And. DToS(NO1_DATVEN)<='"+DToS(MV_PAR10)+"'"
	If MV_PAR13==1
		cQuery += " .And. (NO1_FECHAD=' ' .Or. NO1_FECHAD='N')"
	Else
		If MV_PAR13==2
			cQuery += " .And. NO1_FECHAD='S'"
		EndIf
	EndIf

	IndRegua(cAliasNO1,CriaTrab(NIL,.F.),'NO1_FILIAL+NO1_CODCLI+NO1_LOJCLI+NO1_NUMERO',,cQuery,"Selecionando Registros ...")
	#ENDIF

	dbSelectArea(cAliasNO1)
	SetRegua(LastRec())
	dbGotop()
	While .Not. Eof()

		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		EndIf

		If nLin > 55
			If nLin < 80
				If '***' $ MV_PAR11
					Roda()
				EndIf
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf

		//Imprime informa็๕es do cliente
		dbSelectArea('NN1')
		dbSetOrder(1)
		dbSeek(XFilial('NN1')+(cAliasNO1)->NO1_SAFRA)

		//Imprime informa็๕es do cliente
		dbSelectArea('SA1')
		dbSetOrder(1)
		dbSeek(XFilial('SA1')+(cAliasNO1)->NO1_CODCLI + (cAliasNO1)->NO1_LOJCLI)

		@ nLin, 001 PSay PadR((cAliasNO1)->NO1_CODCLI+'-'+(cAliasNO1)->NO1_LOJCLI,9)
		@ nLin, 011 PSay PadR(SA1->A1_NOME,40)
		@ nLin, 052 PSay PadR(SA1->A1_END, 40)
		@ nLin, 093 PSay PadR(SA1->A1_MUN, 20)
		nLin ++
		/*
		1         1         1         1         1         1         1         1         1         1         2         2
		1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1
		0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		Cliente                                            Endere็o
		XXXXXX-XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		N. CP. Numero Complementar  Safra                  Emissao  Vencto   Moeda         Produto                                 UM     Quantidade Observa็๕es
		XXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXX-XXXXXXXXXXXXXXX XX/XX/XX XX/XX/XX XX-XXXXXXXXXX XXXXXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXXX XX XXX,XXX,XXX.XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
		*/
		@ nLin , 001 PSay PadR((cAliasNO1)->NO1_NUMERO,06)
		@ nLin , 008 PSay PadR((cAliasNO1)->NO1_NUMCMP,20)
		@ nLin , 029 PSay PadR((cAliasNO1)->NO1_SAFRA+'-'+NN1->NN1_DESCRI,22)
		@ nLin , 052 PSay PadR(DToC(SToD((cAliasNO1)->NO1_DATEMI)),08)
		@ nLin , 061 PSay PadR(DToC(SToD((cAliasNO1)->NO1_DATVEN)),08)
		@ nLin , 070 PSay PadR(Transform((cAliasNO1)->NO1_MOEDA,'@E 99')+'-'+ cMoeda + AllTrim(Str((cAliasNO1)->NO1_MOEDA)),13)
		@ nLin , 084 PSay PadR(AllTrim((cAliasNO1)->NO1_CODPRO)+'-'+(cAliasNO1)->NO1_DESPRO,39)
		@ nLin , 124 PSay PadR((cAliasNO1)->NO1_UM1PRO,02)
		@ nLin , 127 PSay Transform((cAliasNO1)->NO1_QTDPRO, "@E 999,999,999.99")
		@ nLin , 142 PSay PadR((cAliasNO1)->NO1_HISTOR,78)
		nLin := nLin + 2

		// Imprime as Fixa็๕es caso existam
		If '1' $ MV_PAR11
			nLin := fImpFixa((cAliasNO1)->NO1_NUMERO, nLin, Cabec1 ,Cabec2, Titulo)
			nLin++
		EndIf

		// Imprime os Tํtulos a Receber caso existam
		If '2' $ MV_PAR11
			nLin := fImpFina((cAliasNO1)->NO1_NUMERO, nLin, Cabec1 ,Cabec2, Titulo)
			nLin++
		EndIf

		// Imprime os Faturamentos caso existam
		If '3' $ MV_PAR11
			nLin := fImpFata((cAliasNO1)->NO1_NUMERO, nLin, Cabec1 ,Cabec2, Titulo)
			nLin++
		EndIf

		If '***' <> MV_PAR11
			nLin := 80
			Roda()
		EndIf

		dbSelectArea(cAliasNO1)
		dbSkip()
		IncRegua()
	EndDo

	If '***' $ MV_PAR11
		Roda()
	EndIf

	dbSelectArea(cAliasNO1)

	#IFNDEF TOP
	FErase(cArqInd+OrdBagExt())
	#ENDIF

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fimpFixa บAutor  ณ Ricardo Tomasi     บ Data ณ  14/12/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime fixa็๕es de mode analitico e sintetico.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpFixa(cNumCP, nLin, Cabec1 ,Cabec2, Titulo)
	Local nValAFix := 0
	Local nValFixa := 0

	/*
	1         1         1         1         1         1         1         1         1         1         2         2
	1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	Item     Quantidade  Entrega UM Moed   Taxa   Prc.     Data   Pre.     Data   Des.     Data   Arr.     Data          Total       Total M2 Observa็๕es
	XXX  XXX,XXX,XXX.XX XX/XX/XX XX   XX XX,XXX XX.XXX XX/XX/XX XX.XXX XX/XX/XX XX.XXX XX/XX/XX XX.XXX XX/XX/XX XXX,XXX,XXX.XX XXX,XXX,XXX.XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	*/

	@ nLin, 001 PSay PadC("Fixa็๕es",218,'-')
	nLin ++
	If MV_PAR12==2
		@ nLin, 001 PSay 'Item     Quantidade  Entrega UM Moed   Taxa   Prc.     Data   Pre.     Data   Des.     Data   Arr.     Data          Total '+PadL('Total '+GetMV('MV_SIMB'+AllTrim(Str((cAliasNO1)->NO1_MOEDA))),14)+' Observa็๕es'
		nLin++
		@ nLin, 001 PSay Replicate('-',218)
		nLin ++
	EndIf

	dbSelectArea('NO2')
	dbSetOrder(1)
	dbSeek(xFilial('NO2')+cNumCP)
	While .Not. Eof() .And. xFilial('NO2')==cFilial .And. NO2->NO2_NUMCP==cNumCP
		If nLin > 55
			If nLin < 80
				If '***' $ MV_PAR11
					Roda()
				EndIf
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf
		If Empty(NO2->NO2_DATPRC).Or.Empty(NO2->NO2_DATPRM).Or.Empty(NO2->NO2_DATDES).Or.Empty(NO2->NO2_DATARO)
			nValAFix += NO2->NO2_QUANT
		Else
			nValFixa += NO2->NO2_QUANT
		EndIf
		If MV_PAR12==2
			@ nLin , 001 PSay Transform(NO2->NO2_SEQ  ,'XXX')
			@ nLin , 006 PSay Transform(NO2->NO2_QUANT,"@E 999,999,999.99")
			@ nLin , 021 PSay DToC(NO2->NO2_DATENT)
			@ nLin , 030 PSay NO2->NO2_UM
			@ nLin , 034 PSay Transform(NO2->NO2_MOEDA,'@E 999')
			@ nLin , 038 PSay Transform(NO2_TXMOED    ,'@E 99.999')
			@ nLin , 045 PSay Transform(NO2_VLRPRC    ,'@E 999.99')
			@ nLin , 052 PSay DToC(NO2->NO2_DATPRC)
			@ nLin , 061 PSay Transform(NO2_PREMIO    ,'@E 999.99') 
			@ nLin , 068 PSay DToC(NO2->NO2_DATPRM)
			@ nLin , 077 PSay Transform(NO2_DESPSA    ,'@E 999.99')  
			@ nLin , 084 PSay DToC(NO2->NO2_DATDES)
			@ nLin , 093 PSay Transform(NO2_AROLAG    ,'@E 999.99')
			@ nLin , 100 PSay DToC(NO2->NO2_DATARO)
			@ nLin , 109 PSay Transform(NO2_TOTAL     ,"@E 999,999,999.99")
			@ nLin , 124 PSay Transform(NO2_TOTALX    ,"@E 999,999,999.99")
			@ nLin , 139 PSay PadR(NO2_HISTOR,75)
			nLin++
		EndIf

		dbSkip()
	EndDo

	If MV_PAR12==2
		@ nLin, 001 PSay Replicate('-',218)
		nLin++
	EndIf
	@ nLin, 001 PSay "Quantidade Total a Fixar: " 
	@ nLin, 027 PSay Transform(nValAFix,'@E 999,999,999.99')
	@ nLin, 061 PSay "Quantidade Total Fixado: " 
	@ nLin, 087 PSay Transform(nValFixa,'@E 999,999,999.99')
	nLin++
	@ nLin, 001 PSay Replicate('-',218)
	nLin ++

Return(nLin)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fimpFina บAutor  ณ Ricardo Tomasi     บ Data ณ  14/12/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime titulos financeiros do compromisso.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpFina(cNumCP, nLin, Cabec1 ,Cabec2, Titulo)
	Local nValARec := 0
	Local nValRece := 0

	@ nLin, 001 PSay PadC("Financeiro",218,'-')
	nLin ++
	If MV_PAR12==2
		@ nLin, 001 PSay 'Prefixo Numero Parcela Tipo Banco Agencia Conta      Natureza   Data Emissao Data Vencimento  Moeda   Taxa           Valor Observa็ใo'
		nLin++
		@ nLin, 001 PSay Replicate('-',218)
		nLin ++
	EndIf

	dbSelectArea('NO3')
	dbSetOrder(2)
	dbSeek(xFilial('NO3')+cNumCP)
	While .Not. Eof() .And. xFilial('NO3')==cFilial .And. NO3->NO3_NUMCP==cNumCP
		If nLin > 55
			If nLin < 80
				If '***' $ MV_PAR11
					Roda()
				EndIf
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf
		If NO3->NO3_TIPO $ 'RA '
			nValRece += NO3->NO3_VALOR
		EndIf
		If NO3->NO3_TIPO $ 'PR '
			nValARec += NO3->NO3_VALOR
		Else
			nValARec -= NO3->NO3_VALOR
		EndIf

		If MV_PAR12==2
			@ nLin , 003 PSay NO3->NO3_PREFIX
			@ nLin , 009 PSay NO3->NO3_NUM
			@ nLin , 019 PSay NO3->NO3_PARCEL
			@ nLin , 024 PSay NO3->NO3_TIPO
			@ nLin , 029 PSay NO3->NO3_CODBCO
			@ nLin , 035 PSay NO3->NO3_CODAGE
			@ nLin , 043 PSay NO3->NO3_CODCTA
			@ nLin , 054 PSay NO3->NO3_NATURE
			@ nLin , 067 PSay DToC(NO3->NO3_DATEMI)
			@ nLin , 082 PSay DToC(NO3->NO3_DATVEN)
			@ nLin , 097 PSay Transform(NO3->NO3_MOEDA  ,'@E 999')
			@ nLin , 101 PSay Transform(NO3->NO3_TXMOED ,'@E 99.999')
			@ nLin , 109 PSay Transform(NO3->NO3_VALOR  ,"@E 999,999,999.99")
			@ nLin , 124 PSay PadR(NO3->NO3_HISTOR,80)
			nLin++
		EndIf

		dbSkip()
	EndDo

	If MV_PAR12==2
		@ nLin, 001 PSay Replicate('-',218)
		nLin++
	EndIf
	@ nLin, 001 PSay "Total a Receber: ("+GetMV('MV_SIMB'+AllTrim(Str((cAliasNO1)->NO1_MOEDA)))+")"
	@ nLin, 027 PSay Transform(nValARec,'@E 999,999,999.99')
	@ nLin, 061 PSay "Total Recebido: ("+GetMV('MV_SIMB'+AllTrim(Str((cAliasNO1)->NO1_MOEDA)))+")"
	@ nLin, 087 PSay Transform(nValRece,'@E 999,999,999.99')
	nLin++
	@ nLin, 001 PSay Replicate('-',218)
	nLin ++

Return(nLin)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fimpFata บAutor  ณ Ricardo Tomasi     บ Data ณ  14/12/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime notas fiscais de saida para esse compromisso.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpFata(cNumCP,nLin, Cabec1 ,Cabec2, Titulo)
	Local cArqSD2  := ''
	Local nIndSD2  := 0
	Local nTotEntr := 0
	Local nTotAEnt := 0
	Local nColAux  := 0
	Local nContNF  := 0

	If FWModeAccess('NO1',3) == 'C'
		dbSelectArea('SD2')
		cArqSD2 := CriaTrab(Nil,.f.)	
		IndRegua('SD2', cArqSD2, 'D2_FILIAL+D2_SERIE+D2_DOC+D2_ITEM',, 'D2_NUMCP=="'+cNumCP+'"', "")
		nIndSD2 := RetIndex('SD2')+1
	Else
		dbSelectArea('SD2')
		cArqSD2 := CriaTrab(Nil,.f.)
		IndRegua('SD2', cArqSD2, 'D2_FILIAL+D2_SERIE+D2_DOC+D2_ITEM',, 'D2_FILIAL=="'+cFilial+'" .And. D2_NUMCP=="'+cNumCP+'"', "")
		nIndSD2 := RetIndex('SD2')+1
	EndIf

	#IFNDEF TOP
	dbSetIndex(cIndSD2+OrdBagExT())
	#ENDIF
	dbSetOrder(nIndSD2)
	dbGotop()

	nTotAEnt := (cAliasNO1)->NO1_QTDPRO
	/*
	1         1         1         1         1         1         1         1         1         1         2         2
	1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1
	0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
	Numero  Serie   Emissao   UM      Quantidade      Preco Uni.           Total Armazem TES   CFOP Romaneio  |  Numero  Serie   Emissao   UM      Quantidade      Preco Uni.           Total Armazem TES   CFOP Romaneio
	XXXXXX   XXX    XX/XX/XX  XX  XXX,XXX,XXX.XX  XXX,XXX,XXX.XX  XXX,XXX,XXX.XX    XX   XXX XXXXXX   XXXXXX  |  XXXXXX   XXX    XX/XX/XX  XX  XXX,XXX,XXX.XX  XXX,XXX,XXX.XX  XXX,XXX,XXX.XX    XX   XXX XXXXXX   XXXXXX
	*/

	@ nLin, 001 PSay PadC("Faturamento",218,'-')
	nLin ++
	If MV_PAR12==2
		@ nLin, 001 PSay 'Numero  Serie   Emissao   UM      Quantidade      Preco Uni.           Total Armazem TES   CFOP Romaneio  |  Numero  Serie   Emissao   UM      Quantidade      Preco Uni.           Total Armazem TES   CFOP Romaneio'
		nLin++
		@ nLin, 001 PSay Replicate('-',218)
		nLin ++
	EndIf

	While .Not. Eof()

		If nLin > 55
			If nLin < 80
				If '***' $ MV_PAR11
					Roda()
				EndIf
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		EndIf

		nTotEntr += AGRX001(SD2->D2_UM,(cAliasNO1)->NO1_UM1PRO,SD2->D2_QUANT)
		nTotAEnt -= AGRX001(SD2->D2_UM,(cAliasNO1)->NO1_UM1PRO,SD2->D2_QUANT)
		nContNF++

		If MV_PAR12 == 2
			@ nLin, nColAux+001 PSay PadR(SD2->D2_DOC    ,06)
			@ nLin, nColAux+010 PSay PadR(SD2->D2_SERIE  ,03)
			@ nLin, nColAux+017 PSay PadR(SD2->D2_EMISSAO,08)
			@ nLin, nColAux+027 PSay PadR(SD2->D2_UM     ,02)
			@ nLin, nColAux+031 PSay Transform(D2_QUANT  ,'@E 999,999,999.99')
			@ nLin, nColAux+047 PSay Transform(D2_PRCVEN ,'@E 999,999,999.99') 
			@ nLin, nColAux+063 PSay Transform(D2_TOTAL  ,'@E 999,999,999.99')
			@ nLin, nColAux+081 PSay PadR(SD2->D2_LOCAL  ,02)
			@ nLin, nColAux+086 PSay PadR(SD2->D2_TES    ,03)
			@ nLin, nColAux+090 PSay PadR(D2_CF          ,06)
			@ nLin, nColAux+099 PSay PadR(SD2->D2_CODROM ,06)
			If nColAux == 0
				@ nLin, nColAux+107 PSay '|'
				nColAux := 109
			Else
				nColAux := 0
				nLin++
			EndIf
		EndIf

		dbSkip()
	EndDo

	If MV_PAR12==2
		If nColAux > 0
			nLin++
		EndIf
		@ nLin, 001 PSay Replicate('-',218)
		nLin++
	EndIf
	@ nLin, 001 PSay "Total a Entregar: ("+PadR((cAliasNO1)->NO1_UM1PRO,02)+")"
	@ nLin, 027 PSay Transform(nTotAEnt,'@E 999,999,999.99')
	@ nLin, 061 PSay "Total Entrege: ("+PadR((cAliasNO1)->NO1_UM1PRO,02)+")"
	@ nLin, 087 PSay Transform(nTotEntr,'@E 999,999,999.99')
	@ nLin, 121 PSay "Total de Itens Vinculados: "
	@ nLin, 149 PSay Transform(nContNF, "@E 9,999")
	nLin++
	@ nLin, 001 PSay Replicate('-',218)
	nLin ++

Return(nLin)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AGRR255A บAutor  ณ Danyel Bernuci     บ Data ณ  12/09/2005 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Lista Descontos de Classifica็ใo.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AGRR100A()
	Local cTitulo   := 'Itens do Compromisso'
	Local cReadAtu  := &(Alltrim(ReadVar()))
	Local cReadRet  := Alltrim(ReadVar())
	Local cItens    := '123'
	Local aItens    := {'1-Fixa็๕es','2-Financeiro','3-Faturamento'}

	If f_Opcoes(@cReadAtu,cTitulo,aItens,cItens,,,.f.,1,3)
		&cReadRet := cReadAtu
	Endif

	&cReadRet	:= cReadAtu

Return()
