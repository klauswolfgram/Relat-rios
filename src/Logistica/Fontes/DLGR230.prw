/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'FIVEWIN.CH'
#Include 'DLGR230.CH'
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ DLGR230 ³ Autor ³ Flavio Luiz Vicco      ³Data  ³18/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reabastecimento                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAWMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function DLGR230()
Local oReport

If SuperGetMv("MV_WMSNEW",.F.,.F.)
	Return WMSR230()
EndIf

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()
Else
	U_DLGR230R3()
EndIf
Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Flavio Luiz Vicco      ³Data  ³18/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reabastecimento                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: nReg = Registro posicionado do SC3 apartir Browse  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cAliasNew := "SDB"
Local cTitle    := OemToAnsi(STR0010) //'Servicos/Tarefas/Atividades'
Local oReport 
Local oSection1
Local oSection2
Local oSection3
dbSelectArea(cAliasNew)
dbSetOrder(1)
#IFDEF TOP
	cAliasNew := GetNextAlias()
#ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("DLGR230",cTitle,"DLR230",{|oReport| ReportPrint(oReport,cAliasNew)},STR0010) //'Servicos/Tarefas/Atividades'
oReport:SetLandscape()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 - Servico   de       ?                                        ³
//³ mv_par02 - Servico   ate      ?                                        ³
//³ mv_par03 - Tarefa    de       ?                                        ³
//³ mv_par04 - Tarefa    Ate      ?                                        ³
//³ mv_par05 - Atividade De       ?                                        ³
//³ mv_par06 - Atividade Ate      ?                                        ³
//³ mv_par07 - Documento De       ?                                        ³
//³ mv_par08 - Documento Ate      ?                                        ³
//³ mv_par09 - Serie De           ?                                        ³
//³ mv_par10 - Serie Ate          ?                                        ³
//³ mv_par11 - Data De            ?                                        ³
//³ mv_par12 - Data Ate           ?                                        ³
//³ mv_par13 - Quantidade         ? 1a.UM / 2a.UM / U.M.I. / Nao Imprime   ³
//³ mv_par14 - Tipo de Documento  ? Doc/Ser WMS / Doc/Ser Ori. CQ / Carga/Unitiz.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:= TRSection():New(oReport,STR0022+' - '+STR0006,{"SDB"},/*aOrdem*/) //"Movimentos por endereco - Estrutura"
oSection1:SetLineStyle()
oSection1:SetCharSeparator("")
TRCell():New(oSection1,"DB_ESTFIS",	"SDB",STR0006+' : ') //"Estrutura"
TRCell():New(oSection1,"CDESEST",	"","Descrição",,30,,{||If(lQuery,(cAliasNew)->DC8_DESEST,Posicione('DC8',1,xFilial('DC8')+(cAliasNew)->DB_ESTFIS,'DC8_DESEST'))})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:= TRSection():New(oSection1,STR0022+' - '+STR0032,{"SDB"},/*aOrdem*/) //"Movimentos por endereco - Endereco"
TRCell():New(oSection2,"DB_LOCALIZ",	"SDB",STR0023) //"End.Origem"
TRCell():New(oSection2,"DB_ESTDES",		"SDB",STR0024) //"Estru."
TRCell():New(oSection2,"DB_ENDDES",		"SDB")
TRCell():New(oSection2,"DB_DOC",		"SDB")
TRCell():New(oSection2,"DB_SERIE",		"SDB")
TRCell():New(oSection2,"DB_CARGA",		"SDB")
TRCell():New(oSection2,"DB_UNITIZ",		"SDB")
TRCell():New(oSection2,"DB_LOTECTL",	"SDB")
TRCell():New(oSection2,"DB_NUMLOTE",	"SDB")
TRCell():New(oSection2,"DB_PRODUTO",	"SDB",STR0025) //"Cod.Produto"
TRCell():New(oSection2,"B1_UM",			"SB1",STR0020) //"UM:"
TRCell():New(oSection2,"B1_SEGUM",		"SB1",STR0020) //"UM:"
TRCell():New(oSection2,"B1_DESC",		"SB1",STR0026,,30) //"Produto"
TRCell():New(oSection2,"DB_QUANT",		"SDB",STR0027) //"1a. U.M."
TRCell():New(oSection2,"DB_QTSEGUM",	"SDB",STR0028,,,,{||ConvUm((cAliasNew)->DB_PRODUTO,(cAliasNew)->DB_QUANT,0,2)}) //"2a. U.M."
TRCell():New(oSection2,"NUMI", 			"",   STR0029,PesqPict("SDB","DB_QUANT")) //"Unitizador"
TRCell():New(oSection2,"N1UM",			"",   STR0030,PesqPict("SDB","DB_QUANT")) //"2a. U.M."
TRCell():New(oSection2,"N2UM",			"",   STR0031,PesqPict("SDB","DB_QUANT")) //"1a. U.M."
TRCell():New(oSection2,"LACUNA1",		"",   STR0029,,12,,{||"[__________]"}) //"Unitizador"
TRCell():New(oSection2,"LACUNA2",		"",   STR0030,,12,,{||"[__________]"}) //"2a. U.M."
TRCell():New(oSection2,"LACUNA3",		"",   STR0031,,12,,{||"[__________]"}) //"1a. U.M."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection3:= TRSection():New(oSection2,STR0022+' - '+STR0033,{"SDB"},/*aOrdem*/) //"Movimentos por endereco - Recurso Humano"
TRCell():New(oSection3,"SEPARADOR", "",STR0008,,45,,{||"  _______________________   ___:___   ___:___"}) //"Separador :"
TRCell():New(oSection3,"CONFERENTE","",STR0009,,44,,{||" _______________________   ___:___   ___:___"}) //"Conferente :"
oSection3:SetLineStyle()
oSection3:SetCharSeparator("")
Return(oReport)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Flavio Luiz Vicco     ³Data  ³18/10/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reabastecimento                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasNew)
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(1):Section(1)
Local oSection3  := oReport:Section(1):Section(1):Section(1)
Local oBreak1
Local cCondicao  := ""
Local cChave     := ""
Local cCondWhile := "DB_ESTFIS"
Local cValoWhile := ""
Local cVazio     := Space(Len(SDB->DB_CARGA))
Local nUMI       := 0
Local n1UM       := 0
Local n2UM       := 0
Local aQtdUni    := {}
Local cCodCFG    := ""
Local cCodCFG1   := ""
Local cPicCFG    := ""
Local cDocSDB    := ""
Local cSerieSDB  := ""
#IFDEF TOP
	cCondicao := "%"
	If mv_par14 == 1
		cCondicao += " AND DB_DOC    >= '" + MV_PAR07 + "' AND DB_DOC    <= '" + MV_PAR08 + "'"
		cCondicao += " AND DB_SERIE  >= '" + MV_PAR09 + "' AND DB_SERIE  <= '" + MV_PAR10 + "'"
	ElseIf mv_par14 == 3
		cCondicao += " AND DB_CARGA  <> '" + cVazio   + "'"
		cCondicao += " AND DB_CARGA  >= '" + MV_PAR07 + "' AND DB_CARGA  <= '" + MV_PAR08 + "'"
		cCondicao += " AND DB_UNITIZ >= '" + MV_PAR09 + "' AND DB_UNITIZ <= '" + MV_PAR10 + "'"
	EndIf
	cCondicao += "%"
	If mv_par14 <= 2
		cChave	 := '%DB_FILIAL,DB_ESTFIS,DB_DOC,DB_SERIE,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL%'
	ElseIf mv_par14 == 3
		cChave	 := '%DB_FILIAL,DB_ESTFIS,DB_CARGA,DB_UNITIZ,DB_LOCALIZ,DB_PRODUTO,DB_LOCAL%'
	EndIf
	oSection1:BeginQuery()	
	BeginSql Alias cAliasNew
	//-->
	SELECT	SDB.DB_FILIAL,  SDB.DB_LOCAL,   SDB.DB_LOCALIZ, SDB.DB_DOC,    SDB.DB_SERIE,   SDB.DB_CARGA,
			SDB.DB_SERVIC,  SDB.DB_TAREFA,  SDB.DB_ATIVID,  SDB.DB_TM,     SDB.DB_ESTORNO, SDB.DB_ATUEST, SDB.DB_QUANT,
			SDB.DB_PRODUTO, SDB.DB_LOTECTL, SDB.DB_NUMLOTE, SDB.DB_ENDDES, SDB.DB_ESTFIS,  SDB.DB_ESTDES, SDB.DB_UNITIZ
	FROM %table:SDB% SDB
	WHERE SDB.DB_FILIAL      = %xFilial:SDB%
	AND   SDB.DB_SERVIC     >= %Exp:MV_PAR01%
	AND   SDB.DB_SERVIC     <= %Exp:MV_PAR02%
	AND   SDB.DB_TAREFA     >= %Exp:MV_PAR03%
	AND   SDB.DB_TAREFA     <= %Exp:MV_PAR04%
	AND   SDB.DB_ATIVID     >= %Exp:MV_PAR05%
	AND   SDB.DB_ATIVID     <= %Exp:MV_PAR06%
	AND   SDB.DB_DATA       >= %Exp:DtoS(MV_PAR11)%
	AND   SDB.DB_DATA       <= %Exp:DtoS(MV_PAR12)%
	AND   SDB.DB_ESTORNO     = ' '
	AND   SDB.DB_ATUEST      = 'N'
	AND   SDB.%NotDel%
    %Exp:cCondicao%
	ORDER BY %Exp:cChave%
	//-->
	EndSql
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
#ELSE
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao Advpl                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr(oReport:uParam)
	cCondicao := ' DB_SERVIC >= "'           + MV_PAR01       + '" .And. DB_SERVIC <= "' + MV_PAR02 + '"'
	cCondicao += ' .And. DB_TAREFA >= "'     + MV_PAR03       + '" .And. DB_TAREFA <= "' + MV_PAR04 + '"'
	cCondicao += ' .And. DB_ATIVID >= "'     + MV_PAR05       + '" .And. DB_ATIVID <= "' + MV_PAR06 + '"'
	If mv_par14 == 1
		cCondicao += ' .And. DB_DOC    >= "'     + MV_PAR07       + '" .And. DB_DOC    <= "' + MV_PAR08 + '"'
		cCondicao += ' .And. DB_SERIE  >= "'     + MV_PAR09       + '" .And. DB_SERIE  <= "' + MV_PAR10 + '"'
	ElseIf mv_par14 == 3
		cCondicao += ' .And. !Empty(DB_CARGA)'
		cCondicao += ' .And. DB_CARGA  >= "'     + MV_PAR07       + '" .And. DB_CARGA  <= "' + MV_PAR08 + '"'
		cCondicao += ' .And. DB_UNITIZ >= "'     + MV_PAR09       + '" .And. DB_UNITIZ <= "' + MV_PAR10 + '"'
	EndIf
	cCondicao += ' .And. DtoS(DB_DATA) >= "' + DtoS(MV_PAR11) + '"'
	cCondicao += ' .And. DtoS(DB_DATA) <= "' + DtoS(MV_PAR12) + '"'
	cCondicao += ' .And. Empty(DB_ESTORNO) .And. DB_ATUEST == "N"'
	If mv_par14 <= 2
		cChave	 := 'DB_FILIAL+DB_ESTFIS+DB_DOC+DB_SERIE+DB_LOCALIZ+DB_PRODUTO+DB_LOCAL'
	ElseIf mv_par14 == 3
		cChave	 := 'DB_FILIAL+DB_ESTFIS+DB_CARGA+DB_UNITIZ+DB_LOCALIZ+DB_PRODUTO+DB_LOCAL'
	EndIf
	oSection1:SetFilter(cCondicao,cChave)
#ENDIF
oBreak1 := TRBreak():New(oSection2,{||(cAliasNew)->(&cCondWhile) },,.F.,,.T.)
If mv_par13 == 1
	oSection2:Cell("DB_QTSEGUM"):Disable()
	oSection2:Cell("B1_SEGUM"):Disable()
	oSection2:Cell("NUMI"):Disable()
	oSection2:Cell("N1UM"):Disable()
	oSection2:Cell("N2UM"):Disable()
	oSection2:Cell("LACUNA1"):Disable()
	oSection2:Cell("LACUNA2"):Disable()
	oSection2:Cell("LACUNA3"):Disable()
ElseIf mv_par13 == 2
	oSection2:Cell("DB_QUANT"):Disable()
	oSection2:Cell("B1_UM"):Disable()
	oSection2:Cell("NUMI"):Disable()
	oSection2:Cell("N1UM"):Disable()
	oSection2:Cell("N2UM"):Disable()
	oSection2:Cell("LACUNA1"):Disable()
	oSection2:Cell("LACUNA2"):Disable()
	oSection2:Cell("LACUNA3"):Disable()
ElseIf mv_par13 == 3
	oSection2:Cell("DB_QUANT"):Disable()
	oSection2:Cell("B1_UM"):Disable()
	oSection2:Cell("DB_QTSEGUM"):Disable()
	oSection2:Cell("B1_SEGUM"):Disable()
	oSection2:Cell("LACUNA1"):Disable()
	oSection2:Cell("LACUNA2"):Disable()
	oSection2:Cell("LACUNA3"):Disable()
Else
	oSection2:Cell("DB_QUANT"):Disable()
	oSection2:Cell("B1_UM"):Disable()
	oSection2:Cell("DB_QTSEGUM"):Disable()
	oSection2:Cell("B1_SEGUM"):Disable()
	oSection2:Cell("NUMI"):Disable()
	oSection2:Cell("N1UM"):Disable()
	oSection2:Cell("N2UM"):Disable()
EndIf
oSection1:Cell("CDESEST"):HideHeader()
oSection2:SetParentQuery()
oSection3:SetParentQuery()
oSection1:Init()
oSection2:Init()
oSection3:Init()
While !oReport:Cancel() .And. !(cAliasNew)->(Eof())
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	//-->
	If mv_par13 == 3
		n1UM := n2UM := nUMI := 0
		nUMI := QtdUni((cAliasNew)->DB_PRODUTO, (cAliasNew)->DB_LOCAL, ConvUm((cAliasNew)->DB_PRODUTO,(cAliasNew)->DB_QUANT,0,2),1)
		If !(QtdComp(nUMI) == QtdComp(int(nUMI)))  //-- Se a Quantidade de Unitizadores for diferente de um numero inteiro
			n2UM := nUMI - Int(nUMI)
			n2UM := QtdUni((cAliasNew)->DB_PRODUTO, (cAliasNew)->DB_LOCAL, n2UM,2)
			If !(QtdComp(n2UM) == int(QtdComp(n2UM)))
				n1UM := n2UM - Int(n2UM)
				n1UM := ConvUm((cAliasNew)->DB_PRODUTO,0,n1UM,1)
			Endif
		EndIf
		oSection2:Cell("NUMI"):SetValue(nUMI)
		oSection2:Cell("N1UM"):SetValue(n1UM)
		oSection2:Cell("N2UM"):SetValue(n2UM)
	EndIf
	If mv_par14 == 2
		cDocSDB   := (cAliasNew)->DB_DOC
		cSerieSDB := (cAliasNew)->DB_SERIE
		DLR230OrCQ(@cDocSDB, @cSerieSDB)
		oSection2:Cell("DB_DOC"):SetValue(cDocSDB)
		oSection2:Cell("DB_SERIE"):SetValue(cSerieSDB)
	EndIf
	//--> Le picture do endereco Origem
	If SBE->(MsSeek(xFilial('SBE')+(cAliasNew)->DB_LOCAL+(cAliasNew)->DB_LOCALIZ, .F.))
		If !(cCodCFG==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
			cCodCFG := SBE->BE_CODCFG
			cPicCFG := DLXPicEnd(SBE->BE_CODCFG)
			oSection2:Cell("DB_LOCALIZ"):SetPicture(cPicCFG)
		EndIf
	EndIf
	//--> Le picture do endereco Destino
	If SBE->(MsSeek(xFilial('SBE')+(cAliasNew)->DB_LOCAL+(cAliasNew)->DB_ENDDES, .F.))
		If !(cCodCFG1==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
			cCodCFG1 := SBE->BE_CODCFG
			cPicCFG  := DLXPicEnd(SBE->BE_CODCFG)
			oSection2:Cell("DB_ENDDES"):SetPicture(cPicCFG)
		EndIf
	EndIf
	//-->
	If	cValoWhile != (cAliasNew)->(&cCondWhile)
		cValoWhile := (cAliasNew)->(&cCondWhile)
		oSection1:PrintLine()
	EndIf
	oSection2:PrintLine()
	oReport:SkipLine()	
	oSection3:PrintLine()
	oReport:ThinLine()
	(cAliasNew)->(dbSkip())
	If	cValoWhile != (cAliasNew)->(&cCondWhile)
		oSection2:Finish()
		oSection2:Init()
		oReport:EndPage()
	EndIf
EndDo
oSection1:Finish()
oSection2:Finish()
oSection3:Finish()
Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³          ³ Autor ³Renato                 ³ Data ³16/02/01  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Operacoes executadas por um funcionario          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DLGR230R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo     := STR0010 //'Servicos/Tarefas/Atividades'
Local cDesc1     := STR0011 //'Emite Relatorio de'
Local cDesc2     := STR0010 //'Servicos/Tarefas/Atividades'
Local cDesc3     := ''
Local cString    := 'SDB'
Local lDic       := .F.
Local lComp      := .T.
Local lFiltro    := .T.
Local WnRel      := 'DLGR230'
Local nomeprog   := 'DLGR230'
Private Tamanho    := 'G'
Private Limite     := 180
Private cPerg      := 'DLR230'
Private aReturn    := {STR0001, 1,STR0002, 1, 2, 1, "",1 } //'Zebrado'###'Administracao'
Private lEnd       := .F.
Private m_pag      := 1
Private nLastKey   := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as Perguntas Seleciondas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia para a SetPrinter                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
WnRel := SetPrint(cString, WnRel, cPerg, @Titulo, cDesc1, cDesc2, cDesc3, lDic,, lComp, Tamanho, lFiltro)

If aReturn[4] == 1
   Tamanho := "P"
   Limite  := 80
Endif

If (nLastKey==27)
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return Nil
Endif
SetDefault(aReturn,cString)
If (nLastKey==27)
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return Nil
Endif
RptStatus({|lEnd| ImpDet(@lEnd, WnRel, cString, nomeprog, Titulo)}, Titulo)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³Renato                 ³ Data ³16/02/01  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ImpDet(lEnd, WnRel, cString, nomeprog, Titulo)
Local nx         := 0
Local li     	 := 80
Local lImp    	 := .F.
Local cbCont  	 := 0
Local cbText  	 := ''
Local CHRCOMP 	 := 15
Local nSomaVol   := 0
Local cCodCFG    := ''
Local cPicCFG    := ''
Local cCodCFG1   := ''
Local cPicCFG1	 := ''
Local lTipo      := If(aReturn[4]==1,.T.,.F.)
Local nTam       := TamSx3("DB_DOC")[1]
Local nIncCol    := If(nTam>=10,nTam-10,0) //Tamanho do campo - tamanho minimo
Local cCabec1 	 := ''
Local cCabec2 	 := STR0003+If(mv_par14==3,"",Space(nIncCol))+If(!ltipo,STR0021,"") //-- 'Endereco Origem                Estru. Endereco Destino      Documento  Serie   Lote        Sub-Lote   Cod.Produto      UN Produto                        '
Local cArq       := ''
Local cChave     := ''
Local cCondicao  := ''
Local cValoWhile := ''
Local cProduto   := ''
Local cNumSeq    := ''
Local nRegistro  := 0
Local nQtdpLinha := 24
Local nIndSDB    := 0
Local cLocaliz   := ''
Local lIni	     := .T.
Local nUMI       := 0
Local n1UM       := 0
Local n2UM       := 0
Local aImpDet    := {}

Private nOrdTot  := 0
Private nOrdAtu  := 0

SB1->(dbSetOrder(1))
SB5->(dbSetOrder(1))
SBE->(dbSetOrder(1))
DC8->(dbSetOrder(1))

If mv_par14 > 2
	cCabec2 := STR0015+If(!lTipo,STR0021,"") //-- 'Endereco Origem                Estru. Endereco Destino      Carga      Unitiz. Lote        Sub-Lote   Cod.Produto      UN Produto                        '
EndIf

dbSelectArea(cString)
cArq := CriaTrab('', .F.)
cCondicao := ' DB_SERVIC >= "'           + MV_PAR01       + '" .And. DB_SERVIC <= "' + MV_PAR02 + '"'
cCondicao += ' .And. DB_TAREFA >= "'     + MV_PAR03       + '" .And. DB_TAREFA <= "' + MV_PAR04 + '"'
cCondicao += ' .And. DB_ATIVID >= "'     + MV_PAR05       + '" .And. DB_ATIVID <= "' + MV_PAR06 + '"'
If mv_par14 == 1
	cCondicao += ' .And. DB_DOC    >= "'     + MV_PAR07       + '" .And. DB_DOC    <= "' + MV_PAR08 + '"'
	cCondicao += ' .And. DB_SERIE  >= "'     + MV_PAR09       + '" .And. DB_SERIE  <= "' + MV_PAR10 + '"'
ElseIf mv_par14 == 3
	cCondicao += ' .And. !Empty(DB_CARGA)'
	cCondicao += ' .And. DB_CARGA  >= "'     + MV_PAR07       + '" .And. DB_CARGA  <= "' + MV_PAR08 + '"'
	cCondicao += ' .And. DB_UNITIZ >= "'     + MV_PAR09       + '" .And. DB_UNITIZ <= "' + MV_PAR10 + '"'
EndIf
cCondicao += ' .And. DtoS(DB_DATA) >= "' + DtoS(MV_PAR11) + '"'
cCondicao += ' .And. DtoS(DB_DATA) <= "' + DtoS(MV_PAR12) + '"'
cCondicao += ' .And. Empty(DB_ESTORNO) .And. DB_ATUEST == "N"'
cCondicao += IIF(!Empty(aReturn[7]),' .And. '+aReturn[7],'')

If mv_par14 <= 2
	cChave	 := 'DB_FILIAL+DB_ESTFIS+DB_DOC+DB_SERIE+DB_LOCALIZ+DB_PRODUTO+DB_LOCAL'
ElseIf mv_par14 == 3
	cChave	 := 'DB_FILIAL+DB_ESTFIS+DB_CARGA+DB_UNITIZ+DB_LOCALIZ+DB_PRODUTO+DB_LOCAL'
EndIf

IndRegua(cString, cArq, cChave,, cCondicao, STR0004) //'Selecionando Registros...'
nIndSDB := RetIndex('SDB')
#IFNDEF TOP
	dbSetIndex(cArq+OrdBagExt())
#ENDIF
dbSetOrder(nIndSDB+1)

dbSelectArea('SDB')
SetRegua(LastRec())
dbGoTop()
Do While !Eof()
	nRegistro  := Recno()
	nOrdAtu    := 0
	lVerfOrd   := If(cValoWhile#SDB->DB_ESTFIS,.T.,.F.)
	nOrdTot    := If(cValoWhile#SDB->DB_ESTFIS,0,nOrdTot)
	cValoWhile := SDB->DB_ESTFIS
	Do While !Eof() .And. (cValoWhile==SDB->DB_ESTFIS) .And. lVerfOrd
		nOrdAtu++
		dbSkip()
	Enddo
	nOrdTot := nOrdAtu/nQtdpLinha
	nOrdTot := Int(nOrdTot)+If(nOrdTot==Int(nOrdTot),0,1)
	nOrdAtu := 0
	dbGoto(nRegistro)

	lVerfOrd := .F.
	If lEnd
		If !(mv_par14 == 2)
			@ Prow()+1,001 PSAY STR0005 //'CANCELADO PELO OPERADOR'
		EndIf
		Exit
	EndIf

	//-- Posiciona Arquivos
	cProduto := DB_PRODUTO
	cNumSeq  := DB_NUMSEQ
	SB1->(MsSeek(xFilial('SB1')+cProduto))
	SB5->(MsSeek(xFilial('SB5')+cProduto))
	DC8->(MsSeek(xFilial('DC8')+SDB->DB_ESTFIS))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Le picture do endereco Origem                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SBE->(MsSeek(xFilial('SBE')+SDB->DB_LOCAL+SDB->DB_LOCALIZ, .F.))
		If !(cCodCFG==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
			cCodCFG := SBE->BE_CODCFG
			cPicCFG := DLXPicEnd(SBE->BE_CODCFG)
		EndIf
	EndIf

	If Li > 55 .Or. !(cLocaliz==SDB->DB_ESTFIS)
		If !(cLocaliz==SDB->DB_ESTFIS) .And. !lIni
			Li++
			If !(mv_par14 == 2)
				@ Li,000 PSAY __PrtFatLine()
			EndIf
		Endif
		nOrdAtu++
		cCabec1 := STR0006+SDB->DB_ESTFIS+'-'+DC8->DC8_DESEST //'Estrutura : '
		If lTipo
		   cCabec1 += ("   " + STR0007+StrZero(nOrdAtu,3)+'/'+StrZero(nOrdTot,3)) //'Ordem : '
		Else
		   cCabec1 += PadL(STR0007+StrZero(nOrdAtu,3)+'/'+StrZero(nOrdTot,3),132-Len(cCabec1)) //'Ordem : '
		Endif
		If mv_par14 == 2
			Li := 0
		Else
			Li := Cabec(Titulo, cCabec1, cCabec2+IF(!lTipo,IIF(mv_par13 ==1,STR0012,IIF(mv_par13 == 2, STR0013,STR0014)),""), nomeprog, Tamanho, CHRCOMP)
		EndIf
		lIni := .F.
	Endif
	cLocaliz := SDB->DB_ESTFIS
	Li++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Le picture do endereco Destino                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If SBE->(MsSeek(xFilial('SBE')+SDB->DB_LOCAL+SDB->DB_ENDDES, .F.))
		If !(cCodCFG1==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
			cCodCFG1 := SBE->BE_CODCFG
			cPicCFG1 := DLXPicEnd(SBE->BE_CODCFG)
		EndIf
	EndIf

	If mv_par14 == 2
		aAdd(aImpDet, Array(19))
		aImpDet[Len(aImpDet), 01] := DB_LOCALIZ
		aImpDet[Len(aImpDet), 02] := DB_ESTDES
		aImpDet[Len(aImpDet), 03] := DB_ENDDES
		cDocSDB   := DB_DOC
		cSerieSDB := DB_SERIE
		DLR230OrCQ(@cDocSDB, @cSerieSDB)
		aImpDet[Len(aImpDet), 04] := cDocSDB
		aImpDet[Len(aImpDet), 05] := DB_CARGA
		aImpDet[Len(aImpDet), 06] := cSerieSDB
		aImpDet[Len(aImpDet), 07] := DB_LOTECTL
		aImpDet[Len(aImpDet), 08] := DB_NUMLOTE
		aImpDet[Len(aImpDet), 09] := cProduto
		aImpDet[Len(aImpDet), 10] := If(mv_par13 == 1,SB1->B1_UM,SB1->B1_SEGUM)
		aImpDet[Len(aImpDet), 11] := Substr(SB1->B1_DESC,1,30)
		aImpDet[Len(aImpDet), 12] := Array(3)
		If mv_par13 == 1
			aImpDet[Len(aImpDet), 12, 1] := Transform(DB_QUANT, '@E 999,999.99')
		ElseIf mv_par13 == 2
			aImpDet[Len(aImpDet), 12, 1] := Transform(ConvUm(cProduto,DB_QUANT,0,2), '@E 999,999.99')
		ElseIf mv_par13 == 3
			n1UM := n2UM := nUMI := 0
			nUMI := QtdUni(cProduto, DB_LOCAL, ConvUm(cProduto,DB_QUANT,0,2),1)
			IF !(QtdComp(nUMI) == QtdComp(int(nUMI)))  //-- Se a Quantidade de Unitizadores for diferente de um numero inteiro
				n2UM := nUMI - int(nUMI)
				n2UM := QtdUni(cProduto, DB_LOCAL, n2UM,2)
				IF !(QtdComp(n2UM) == int(QtdComp(n2UM)))
					n1UM := n2UM - int(n2UM)
					n1UM := ConvUm(cProduto,0,n1UM,1)
				Endif
			Endif
			aImpDet[Len(aImpDet), 12, 1] := Transform(Int(nUMI), '@E 999,999.99')
			aImpDet[Len(aImpDet), 12, 2] := Transform(int(QtdComp(n2UM)), '@E 999,999.99')
			aImpDet[Len(aImpDet), 12, 3] := Transform(n1UM, '@E 999,999.99')
		ElseIf mv_par13 == 4
			aImpDet[Len(aImpDet), 12, 1] := '[__________]' // Unitizadores
			aImpDet[Len(aImpDet), 12, 2] := '[__________]' // 2a. Unidade de Medida
			aImpDet[Len(aImpDet), 12, 3] := '[__________]' // 1a. Unidade de Medida
		Endif
		Li += 2
		aImpDet[Len(aImpDet), 13] := STR0008 + '  _______________________   ___:___   ___:___' //'Separador :'
		aImpDet[Len(aImpDet), 14] := STR0009 + ' _______________________   ___:___   ___:___' //'Conferente :'
		Li++
		aImpDet[Len(aImpDet), 15] := __PrtThinLine()
		aImpDet[Len(aImpDet), 16] := DB_ESTFIS
		aImpDet[Len(aImpDet), 17] := DB_UNITIZ
		aImpDet[Len(aImpDet), 18] := DB_LOCAL
		aImpDet[Len(aImpDet), 19] := DB_NUMSEQ
	Else
		@ Li, 000 PSay DB_LOCALIZ Picture cPicCFG
		@ Li, 031 PSay DB_ESTDES
		@ Li, 038 PSay DB_ENDDES Picture cPicCFG1
		If mv_par14 == 1
			@ Li, 060         PSay DB_DOC
			@ Li, 071+nIncCol PSay DB_SERIE
		ElseIf mv_par14 == 3
			@ Li, 060 PSay DB_CARGA
			@ Li, 071 PSay DB_UNITIZ
		EndIf
		If lTipo
		   Li++
		   @ Li, 000 Psay STR0017 // Lote 
		   @ Li, 006 Psay DB_LOTECTL
		   @ Li, 018 Psay STR0018 // Sub-Lote
		   @ Li, 028 Psay DB_NUMLOTE
           @ Li, 036 Psay STR0019 // Produto
		   @ Li, 045 PSay allTrim(cProduto)+ "-" + alltrim(Substr(SB1->B1_DESC,1,30))
		Else
		   @ Li, 079+nIncCol Psay DB_LOTECTL
		   @ Li, 091+nIncCol Psay DB_NUMLOTE
		   @ Li, 102+nIncCol PSay cProduto
		   @ Li, 119+nIncCol PSay SB1->B1_UM
		   @ Li, 122+nIncCol PSay Substr(SB1->B1_DESC,1,30)
		Endif   
		If mv_par13 == 1
		    If lTipo
		       Li++
		       @ Li,000 Psay STR0020 //UM
		       @ Li,004 PSay SB1->B1_UM
			   @ Li,008 Psay STR0016
			   @ Li,020 PSay DB_QUANT	Picture '@E 9,999,999.99'
		    Else
			   @ Li,153+nIncCol PSay DB_QUANT	Picture '@E 9,999,999.99'
			Endif
		ElseIf mv_par13 == 2
			If lTipo
			   Li++
		       @ Li,000 Psay STR0020 //UM
		       @ Li,004 PSay SB1->B1_SEGUM
			   @ Li,008 Psay STR0016 
			   @ Li,020 Psay ConvUm(cProduto,DB_QUANT,0,2) Picture '@E 9,999,999.99'
			Else
			   @ Li,153+nIncCol Psay ConvUm(cProduto,DB_QUANT,0,2) Picture '@E 9,999,999.99'
			Endif
		ElseIf mv_par13 == 3
			n1UM := n2UM := nUMI := 0
			nUMI := QtdUni(cProduto, DB_LOCAL, ConvUm(cProduto,DB_QUANT,0,2),1)
			If !(QtdComp(nUMI) == QtdComp(int(nUMI)))  //-- Se a Quantidade de Unitizadores for diferente de um numero inteiro
				n2UM := nUMI - int(nUMI)
				n2UM := QtdUni(cProduto, DB_LOCAL, n2UM,2)
				IF !(QtdComp(n2UM) == int(QtdComp(n2UM)))
					n1UM := n2UM - int(n2UM)
					n1UM := ConvUm(cProduto,0,n1UM,1)
				Endif
			Endif
			If lTipo
			   Li+=2
			   @ Li,000 Psay allTrim(STR0014)
			   Li++
			   @ Li,000 Psay Int(nUMI) Picture '@E 999,999.99'  // Unitizadores
			   @ Li,017 Psay int(QtdComp(n2UM)) Picture '@E 999,999.99'  // 2a. Unidade de Medida
			   @ Li,036 Psay n1UM      Picture '@E 999,999.99'  // 1a. Unidade de Medida
			Else
			   @ Li,153+nIncCol Psay Int(nUMI) Picture '@E 999,999.99'  // Unitizadores
			   @ Li,170+nIncCol Psay int(QtdComp(n2UM)) Picture '@E 999,999.99'  // 2a. Unidade de Medida
			   @ Li,190+nIncCol Psay n1UM      Picture '@E 999,999.99'  // 1a. Unidade de Medida
			Endif    
		ElseIf mv_par13 == 4
		    If lTipo
			   Li+=2
			   @ Li,000 Psay allTrim(STR0014)
			   Li++
			   @ Li,000 Psay '[__________]' // Unitizadores
			   @ Li,017 Psay '[__________]' // 2a. Unidade de Medida
			   @ Li,036 Psay '[__________]' // 1a. Unidade de Medida
		    Else
			   @ Li,153+nIncCol Psay '[__________]' // Unitizadores
			   @ Li,170+nIncCol Psay '[__________]' // 2a. Unidade de Medida
			   @ Li,190+nIncCol Psay '[__________]' // 1a. Unidade de Medida
			Endif
		Endif
		Li+=2
		@ Li,000 PSay STR0008 + '  _______________________   ___:___   ___:___' //'Separador :'
		If lTipo
		   Li+=2
		   @ Li,000 PSay STR0009 + ' _______________________   ___:___   ___:___' //'Conferente :'
		Else
		   @ Li,075 PSay STR0009 + ' _______________________   ___:___   ___:___' //'Conferente :'
		Endif
		Li++
		@ Li,000 PSAY __PrtThinLine()
		lImp := .T.
	EndIf

	SDB->(dbSkip())
	IncRegua()
EndDo

If mv_par14 == 2
	lIni     := .T.
	cLocaliz := ''
	//-- Array aImpDet
	//-- aImpDet[nn, 01]     := DB_LOCALIZ
	//-- aImpDet[nn, 02]     := DB_ESTDES
	//-- aImpDet[nn, 03]     := DB_ENDDES
	//-- aImpDet[nn, 04]     := Doc
	//-- aImpDet[nn, 05]     := DB_CARGA
	//-- aImpDet[nn, 06]     := Serie
	//-- aImpDet[nn, 07]     := DB_LOTECTL
	//-- aImpDet[nn, 08]     := DB_NUMLOTE
	//-- aImpDet[nn, 09]     := cProduto
	//-- aImpDet[nn, 10]     := SB1->B1_UM
	//-- aImpDet[nn, 11]     := Substr(SB1->B1_DESC,1,30)
	//-- aImpDet[nn, 12, 01] := UMI
	//-- aImpDet[nn, 12, 02] := 2aUM
	//-- aImpDet[nn, 12, 03] := 1aUM
	//-- aImpDet[nn, 13]     := STR0008 + ' _______________________   ___:___   ___:___'
	//-- aImpDet[nn, 14]     := STR0009 + ' _______________________   ___:___   ___:___'
	//-- aImpDet[nn, 15]     := __PrtThinLine()
	//-- aImpDet[nn, 16]     := DB_ESTFIS
	//-- aImpDet[nn, 17]     := DB_UNITIZ
	//-- aImpDet[nn, 18]     := DB_LOCAL
	//-- aImpDet[nn, 19]     := DB_NUMSEQ

	//-- Ordenar por DB_ESTFIS+DB_DOC+DB_SERIE+DB_LOCALIZ+DB_PRODUTO+DB_LOCAL
	aSort(aImpDet,,, {|x, y| x[16]+x[04]+x[06]+x[01]+x[09]+x[18] < y[16]+y[04]+y[06]+y[01]+y[09]+y[18]})

	For nX := 1 to Len(aImpDet)

		If aImpDet[nX, 04] < mv_par07 .Or. aImpDet[nX, 04] > mv_par08 .Or.;
			aImpDet[nX, 06] < mv_par09 .Or. aImpDet[nX, 06] > mv_par10
			Loop
		EndIf

		nRegistro  := nX
		nOrdAtu    := 0
		lVerfOrd   := If(cValoWhile#aImpDet[nX, 16],.T.,.F.)
		nOrdTot    := If(cValoWhile#aImpDet[nX, 16],0,nOrdTot)
		cValoWhile := aImpDet[nX, 16]
		Do While (nX<=Len(aImpDet)) .And. (cValoWhile==aImpDet[nX, 16]) .And. lVerfOrd
			nOrdAtu++
			nX ++
		Enddo
		nOrdTot := nOrdAtu/nQtdpLinha
		nOrdTot := Int(nOrdTot)+If(nOrdTot==Int(nOrdTot),0,1)
		nOrdAtu := 0
		nX := nRegistro

		lVerfOrd := .F.
		If lEnd
			@ Prow()+1,001 PSAY STR0005 //'CANCELADO PELO OPERADOR'
			Exit
		EndIf

		//-- Posiciona Arquivos
		cProduto := aImpDet[nX, 09] //-- Produto
		cNumSeq  := aImpDet[nX, 09] //-- NumSeq
		SB1->(MsSeek(xFilial('SB1')+cProduto))
		SB5->(MsSeek(xFilial('SB5')+cProduto))
		DC8->(MsSeek(xFilial('DC8')+aImpDet[nX, 16])) //-- Estrutura Fisica

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Le picture do endereco Origem                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SBE->(MsSeek(xFilial('SBE')+aImpDet[nX, 18]+aImpDet[nX, 01], .F.))
			If !(cCodCFG==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
				cCodCFG := SBE->BE_CODCFG
				cPicCFG := DLXPicEnd(SBE->BE_CODCFG)
			EndIf
		EndIf

		If Li > 55 .Or. !(cLocaliz==aImpDet[nX, 16])
			If !(cLocaliz==aImpDet[nX, 16]) .And. !lIni
				Li++
				@ Li,000 PSAY __PrtFatLine()
			Endif
			nOrdAtu++
			cCabec1 := STR0006+aImpDet[nX, 16]+'-'+DC8->DC8_DESEST //'Estrutura : '
            If lTipo
		       cCabec1 += ("   " + STR0007+StrZero(nOrdAtu,3)+'/'+StrZero(nOrdTot,3)) //'Ordem : '
            Else
			   cCabec1 += PadL(STR0007+StrZero(nOrdAtu,3)+'/'+StrZero(nOrdTot,3),132-Len(cCabec1)) //'Ordem : '
			Endif   
			Li   := Cabec(Titulo, cCabec1, cCabec2+IF(!lTipo,IIF(mv_par13 ==1,STR0012,IIF(mv_par13 == 2, STR0013,STR0014)),""), nomeprog, Tamanho, CHRCOMP)
			lIni := .F.
		Endif
		cLocaliz := aImpDet[nX, 16]
		Li++

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Le picture do endereco Destino                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SBE->(MsSeek(xFilial('SBE')+aImpDet[nX, 18]+aImpDet[nX, 02], .F.))
			If !(cCodCFG1==SBE->BE_CODCFG) //-- Verifica se o codigo mudou
				cCodCFG1 := SBE->BE_CODCFG
				cPicCFG1 := DLXPicEnd(SBE->BE_CODCFG)
			EndIf
		EndIf

        @ Li, 000         PSay aImpDet[nX, 01] Picture cPicCFG
	    @ Li, 031         PSay aImpDet[nX, 02]
		@ Li, 038         PSay aImpDet[nX, 03] Picture cPicCFG1
		@ Li, 060         PSay aImpDet[nX, 04]
		@ Li, 071+nIncCol PSay aImpDet[nX, 06]
		If lTipo
		   Li++
		   @ Li, 000 Psay STR0017 // Lote 
		   @ Li, 006 Psay aImpDet[nX, 07]
		   @ Li, 018 Psay STR0018 // Sub-Lote
		   @ Li, 028 Psay aImpDet[nX, 08]
           @ Li, 036 Psay STR0019 // Produto
		   @ Li, 045 PSay allTrim(aImpDet[nX, 09])+ "-" + alltrim(Substr(aImpDet[nX, 11],1,30))
		Else
		   @ Li, 079+nIncCol Psay aImpDet[nX, 07]
		   @ Li, 091+nIncCol Psay aImpDet[nX, 08]
		   @ Li, 102+nIncCol PSay aImpDet[nX, 09]
		   @ Li, 119+nIncCol PSay aImpDet[nX, 10]
		   @ Li, 122+nIncCol PSay aImpDet[nX, 11]
		Endif
		If mv_par13 <=2
		   If lTipo
	          Li++
	          @ Li,000 Psay STR0020 //UM
	          @ Li,004 PSay aImpDet[Len(aImpDet), 10]
		      @ Li,008 Psay STR0016
		      @ Li,020 PSay aImpDet[nX, 12, 1]
		   Else
		   	  @ Li,153+nIncCol PSay aImpDet[nX, 12, 1]
		   Endif
		Else
		   If lTipo
			  Li+=2
			  @ Li,000 Psay allTrim(STR0014)
			  Li++
			  @ Li,000 Psay aImpDet[nX, 12, 1] // Unitizadores
			  @ Li,017 Psay aImpDet[nX, 12, 2] // 2a. Unidade de Medida
			  @ Li,036 Psay aImpDet[nX, 12, 3] // 1a. Unidade de Medida
		   Else
		      @ Li,153+nIncCol Psay aImpDet[nX, 12, 1] // Unitizadores
			  @ Li,170+nIncCol Psay aImpDet[nX, 12, 2] // 2a. Unidade de Medida
			  @ Li,190+nIncCol Psay aImpDet[nX, 12, 3] // 1a. Unidade de Medida
		   Endif   
		Endif
		Li+=2
		@ Li,000 PSay aImpDet[nX, 13] //'Separador :'
		If lTipo
		   Li+=2
		   @ Li,000 PSay aImpDet[nX, 14] //'Conferente :'
		Else
		   @ Li,075 PSay aImpDet[nX, 14] //'Conferente :'
		Endif
		Li++
		@ Li,000 PSAY __PrtThinLine()
		lImp := .T.

		IncRegua()

	Next nX

EndIf

RetIndex(cString)
fErase(cArq+OrdBagExt())

If (lImp)
	Li++
	@ Li,000 PSAY __PrtFatLine()
	Roda(cbCont,cbText,Tamanho)
EndIf

Set Device To Screen
Set Printer To
If (aReturn[5]==1)
	dbCommitAll()
	OurSpool(WnRel)
Endif
MS_FLUSH()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ QtdUNI   ³ Autor ³Fernando Joly          ³ Data ³09/06/04  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QTDUNI(cProduto, cLocal, nQuant,cTipo)

Local nRet := nQuant
Local aAreaAnt   := GetArea()
Local aAreaSB5   := SB5->(GetArea())
Local aAreaDC2   := DC2->(GetArea())
Local aAreaDC3   := DC3->(GetArea())

dbSelectArea('SB5')
SB5->(dbSetOrder(1))
DC3->(dbSetOrder(1))
If MSSeek(xFilial('SB5')+cProduto, .F.) .And. DC3->(MsSeek(xFilial('DC3')+cProduto+cLocal, .F.))
	dbSelectArea('DC2')
	DC2->(dbSetOrder(1))
	If MSSeek(xFilial('DC2')+DC3->DC3_CODNOR, .F.)
		if cTipo == 1
			nRet := (nRet) / (DC2_LASTRO*DC2_CAMADA)
		ElseIf cTipo == 2
			nRet := (nRet) * (DC2_LASTRO*DC2_CAMADA)
		Endif
	EndIf
EndIf

RestArea(aAreaDC3)
RestArea(aAreaDC2)
RestArea(aAreaSB5)
RestArea(aAreaAnt)

Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DLR230OrCQºAutor  ³Microsiga           º Data ³  06/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function DLR230OrCQ(cDoc, cSerie)

Local aAreaAnt   := GetArea()

dbSelectArea('SD7')
dbSetorder(1)
If MsSeek(xFilial('SD7')+cDoc, .F.)
	cDoc   := SD7->D7_DOC
	cSerie := SD7->D7_SERIE
EndIf

RestArea(aAreaAnt)

Return Nil
