/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR890.CH"
#Include "PROTHEUS.CH"
#Define OP       1
#Define RECURSO  2
#Define DATA     3
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR890   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Acompanhamento das Operacoes.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR890()
Local   oReport
Private cAliasSH8
Private cTpHr     := GetMV("MV_TPHR")
Private bConv     := {|x,y| A680ConvHora(x,y,cTpHr) }

//-- Verifica se o SH8 esta locado para atualizacao por outro processo
If !IsLockSH8()
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:= ReportDef()
		If !oReport:PrintDialog()
	   		dbSelectArea("SH8")
			Set Filter to
			dbCloseArea()
			dbSelectArea("SC2")
			Return Nil
		EndIf
	Else
		U_MATR890R3()
	EndIf
EndIf
Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³26/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR890                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection
Local aOrdem  := {STR0005,STR0006,STR0007}	//"Por Op"###"Por Recurso"###"Por Data Inicio"
Local cPict   := TimePict()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MATR890",OemToAnsi(STR0001),"MTR890", {|oReport| ReportPrint(oReport)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+OemToAnsi(STR0004)) //##"Este programa ira imprimir a Rela‡„o de Acompanhamento das Opera‡”es. Os valores referentes aos tempos de duracao est„o convertidos conforme o parametro MV_TPHR. Se utilizada Prod. Mod. 2 podem haver divergencias."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sugere orientacao modo PAISAGEM                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetLandscape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas (MTR890)                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // De                                    ³
//³ mv_par02            // Ate                                   ³
//³ mv_par03            // Impr. OP's Firmes, Previstas ou Ambas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 1 (oSection)                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection := TRSection():New(oReport,STR0030,{"SH8","SH6","SC2","SB1"},aOrdem) //"Operações alocadas Carga Máquina"
oSection:SetHeaderPage()

TRCell():New(oSection,'H8_OP'   	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_OPER' 	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_RECURSO' 	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_FERRAM'  	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'C2_PRODUTO' 	,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_DESC' 	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_DTINI' 	,'SH8', STR0024  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_HRINI'   	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| Eval(bConv,(cAliasSH8)->H8_HRINI,"N") })
TRCell():New(oSection,'H6_DATAINI'	,'SH6', STR0025  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H6_HORAINI' 	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'VarInicio'  	,'SH8', STR0026  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_DTFIM' 	,'SH8', STR0027  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_HRFIM' 	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| Eval(bConv,(cAliasSH8)->H8_HRFIM,"N") })
TRCell():New(oSection,'H6_DATAFIN' 	,'SH6', STR0028  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H6_HORAFIN' 	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'VarFim'   	,'SH8', STR0026  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_BITUSO' 	,'SH8', STR0029  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H6_TEMPO'   	,'SH6',/*Titulo*/, cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'Diferenca'	,'SH8', STR0026  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection:SetNoFilter({"SH6","SB1"})

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³25/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR890                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local aColSH6   := {}
Local oSection  := oReport:Section(1)
Local nOrdem    := oSection:GetOrder()
Local cOrderBy  := ""
Local cH6DtIni  := Ctod("  /  /  ")
Local cH6DtFim  := Ctod("  /  /  ")
Local cH6HrIni  := ""
Local cH6HrFim  := ""
Local cH8HrIni  := ""
Local cH8HrFim  := ""
Local cWhere01  := ""
Local lAchouH6  := .F.
Local lApsInUse := SuperGetMv("MV_APS",.F.,"") == "TOTVS"
Local nIndex    := 1
Local nTotCol   := Len(oSection:aCellsName)
Local xDurAloc  := ""
Local xDurReal  := ""
Local oBreak

//Defininco a Quebra e o Titulo conforme a Ordem selecionada
If nOrdem == 1
	oBreak := TRBreak():New(oSection,oSection:Cell('H8_OP'),NIL,.F.) //"Por Op"
	oReport:SetTitle(STR0001+"  "+"("+STR0005+")") //"Relacao de Acompanhamento das Operacoes "####"Por OP"
ElseIf nOrdem == 2
	oBreak := TRBreak():New(oSection,oSection:Cell('H8_RECURSO'),NIL,.F.) //"Por Recurso"
	oReport:SetTitle(STR0001+"  "+"("+STR0006+")") //"Relacao de Acompanhamento das Operacoes "####"Por Recurso"
ElseIf nOrdem == 3
	oBreak := TRBreak():New(oSection,oSection:Cell('H8_DTINI'),NIL,.F.) //"Por Data Inicio"
	oReport:SetTitle(STR0001+"  "+"("+STR0007+")") //"Relacao de Acompanhamento das Operacoes "####"Por Data Inicio"
Endif

//Filtragem do relatorio
//Transforma parametros Range em expressao SQL
MakeSqlExpr(oReport:uParam)

//Relacionamento SC2 - SH8
cWhere01 := "%"
If	Upper(TcGetDb()) $ 'ORACLE,DB2,POSTGRES,INFORMIX'
	cWhere01 += "SC2.C2_NUM = SUBSTR(SH8.H8_OP,1,6) AND "
	cWhere01 += "SC2.C2_ITEM = SUBSTR(SH8.H8_OP,7,2) AND "
	cWhere01 += "SC2.C2_SEQUEN = SUBSTR(SH8.H8_OP,9,3) AND "
	cWhere01 += "SC2.C2_ITEMGRD = SUBSTR(SH8.H8_OP,12," + cValToChar(GetSx3Cache("C2_ITEMGRD","X3_TAMANHO")) + ")"
Else
	cWhere01 += "SC2.C2_NUM = SUBSTRING(SH8.H8_OP,1,6) AND "
	cWhere01 += "SC2.C2_ITEM = SUBSTRING(SH8.H8_OP,7,2) AND "
	cWhere01 += "SC2.C2_SEQUEN = SUBSTRING(SH8.H8_OP,9,3) AND "
	cWhere01 += "SC2.C2_ITEMGRD = SUBSTRING(SH8.H8_OP,12," + cValToChar(GetSx3Cache("C2_ITEMGRD","X3_TAMANHO")) + ")"
EndIf
cWhere01 += "%"

//Order by de acordo com a ordem selecionada.
cOrderBy := "%"
If nOrdem == 1
	cOrderBy += " H8_FILIAL, H8_OP, H8_OPER, H8_DESDOBR " // Por OP
ElseIf nOrdem == 2
	cOrderBy += " H8_FILIAL, H8_RECURSO, H8_BITINI " // Por Recurso
ElseIf nOrdem == 3
	cOrderBy += " H8_FILIAL, H8_DTINI " // Por Data Inicio
EndIf
cOrderBy += "%"

//Query do relatorio da secao 1
oSection:BeginQuery()

cAliasSH8 := GetNextAlias()

BeginSql Alias cAliasSH8
  SELECT SH8.H8_FILIAL, SH8.H8_OP    , SH8.H8_OPER , SH8.H8_DESDOBR, SH8.H8_RECURSO, SH8.H8_FERRAM,
  	     SH8.H8_DTINI , SH8.H8_HRINI , SH8.H8_DTFIM, SH8.H8_HRFIM  , SH8.H8_BITUSO , SH8.H8_BITINI,
  	     SC2.C2_FILIAL, SC2.C2_NUM   , SC2.C2_ITEM , SC2.C2_SEQUEN , SC2.C2_ITEMGRD, C2_PRODUTO,
  	     C2_ROTEIRO   , SB1.B1_FILIAL, SB1.B1_COD  , SB1.B1_DESC   , SB1.B1_OPERPAD
    FROM %table:SH8% SH8
    LEFT JOIN %table:SC2% SC2
      ON SC2.C2_FILIAL = %xFilial:SC2%
     AND %Exp:cWhere01%
     AND SC2.%NotDel%
    LEFT JOIN %table:SB1% SB1
      ON SB1.B1_FILIAL = %xFilial:SB1%
     AND SB1.B1_COD    = SC2.C2_PRODUTO
     AND SB1.%NotDel%
   WHERE SH8.H8_FILIAL = %xFilial:SH8%
     AND SH8.H8_OP    >= %Exp:mv_par01%
     AND SH8.H8_OP    <= %Exp:mv_par02%
     AND SH8.%NotDel%
   ORDER BY %Exp:cOrderBy%
EndSql

oSection:EndQuery()

oSection:Cell('H8_HRINI'  ):HideHeader()
oSection:Cell('H6_HORAINI'):HideHeader()
oSection:Cell('H8_HRFIM'  ):HideHeader()
oSection:Cell('H6_HORAFIN'):HideHeader()

//Inicio da impressao do fluxo do relatorio
oReport:SetMeter(SH8->(LastRec()))
oSection:Init()

//Verifica as colunas da SH6 (inexistente na query) a serem impressas
For nIndex := 1 To nTotCol
	If Left(oSection:aCellsName[nIndex], 3) == "H6_"
		aAdd(aColSH6, nIndex)
	EndIf
Next nIndex
nTotCol := Len(aColSH6)

dbSelectArea(cAliasSH8)

While !oReport:Cancel() .And. !(cAliasSH8)->(Eof())
	dbSelectarea("SC2")
	dbSetOrder(1)
 	dbSeek(xFilial("SC2")+(cAliasSH8)->H8_OP)

	//Valida se a OP deve ser Impressa ou n„o
	If !MtrAValOP(mv_par03, 'SC2')
		dbSelectArea(cAliasSH8)
		dbSkip()
		Loop
	EndIf

	//Posicionar no registro de movimentacao de Producoes SH6.
	dbSelectArea("SH6")
	dbSetOrder(1)

	If dbSeek(xFilial("SH6")+(cAliasSH8)->H8_OP+SC2->C2_PRODUTO+(cAliasSH8)->H8_OPER)
		While !Eof() .And. ;
		      SH6->H6_FILIAL+SH6->H6_OP+SH6->H6_PRODUTO+SH6->H6_OPERAC == xFilial("SH6")+(cAliasSH8)->H8_OP+SC2->C2_PRODUTO+(cAliasSH8)->H8_OPER

			If SH6->H6_DESDOBR != (cAliasSH8)->H8_DESDOBR
				dbSkip()
				Loop
			Endif

			If Empty(cH6HrIni) .Or. (Dtos(SH6->H6_DATAINI) + TimeH6( ,"H6_HORAINI")) < (Dtos(cH6DtIni) + cH6HrIni)
				cH6HrIni := TimeH6(,"H6_HORAINI")
				cH6DtIni := SH6->H6_DATAINI
			Endif

			If Empty(cH6HrFim) .Or. (Dtos(SH6->H6_DATAFIN) + TimeH6( ,"H6_HORAFIN")) > (Dtos(cH6DtFim) + cH6HrFim)
				cH6HrFim := TimeH6(,"H6_HORAFIN")
				cH6DtFim := SH6->H6_DATAFIN
			Endif

			dbSkip()
		Enddo
	EndIf

	lAchouH6 := dbSeek(xFilial("SH6")+(cAliasSH8)->H8_OP+SC2->C2_PRODUTO+(cAliasSH8)->H8_OPER)

	//Carrega os dados da SH6 (inexistente na query)
	If lAchouH6
		For nIndex := 1 To nTotCol
			oSection:Cell(oSection:aCellsName[aColSH6[nIndex]]):SetValue(SH6->&(oSection:aCellsName[aColSH6[nIndex]]))
		Next nIndex
	EndIf

	oSection:Cell('H6_DATAINI'):SetValue(If(lAchouH6, cH6DtIni, ''))
	oSection:Cell('H6_HORAINI'):SetValue(cH6HrIni)

	cH8HrIni := Eval(bConv,(cAliasSH8)->H8_HRINI,"N")
	cH8HrFim := Eval(bConv,(cAliasSH8)->H8_HRFIM,"N")

	If ( (cAliasSH8)->H8_DTINI > cH6DtIni ) .Or. ( (cAliasSH8)->H8_DTINI = cH6DtIni .And. cH8HrIni > cH6HrIni )
		If lApsInUse
			oSection:Cell('VarInicio'):SetValue( A680TimeCale(cH6DtIni,cH6HrIni,(cAliasSH8)->H8_DTINI,cH8HrIni,(cAliasSH8)->H8_RECURSO) )
		Else
			oSection:Cell('VarInicio'):SetValue( U_R815Dur((cAliasSH8)->H8_RECURSO,(cAliasSH8)->H8_DTINI,cH8HrIni,cH6DtIni,cH6HrIni) )
		EndIf
	Else
		If lApsInUse
			oSection:Cell('VarInicio'):SetValue( A680TimeCale((cAliasSH8)->H8_DTINI,cH8HrIni,cH6DtIni,cH6HrIni,(cAliasSH8)->H8_RECURSO) )
		Else
			oSection:Cell('VarInicio'):SetValue( U_R815Dur((cAliasSH8)->H8_RECURSO,cH6DtIni,cH6HrIni,(cAliasSH8)->H8_DTINI,cH8HrIni) )
		EndIf
	EndIf
	oSection:Cell('H6_DATAFIN'):SetValue(If(lAchouH6, cH6DtFim, ''))
	oSection:Cell('H6_HORAFIN'):SetValue(cH6HrFim)

	If ( (cAliasSH8)->H8_DTFIM > cH6DtFim ) .Or. ( (cAliasSH8)->H8_DTFIM = cH6DtFim .And. cH8HrFim > cH6HrFim )
		If lApsInUse
			oSection:Cell('VarFim'):SetValue( A680TimeCale(cH6DtFim,cH6HrFim,(cAliasSH8)->H8_DTFIM,cH8HrFim,(cAliasSH8)->H8_RECURSO) )
		Else
			oSection:Cell('VarFim'):SetValue( U_R815Dur((cAliasSH8)->H8_RECURSO,(cAliasSH8)->H8_DTFIM,cH8HrFim,cH6DtFim,cH6HrFim) )
		EndIf
	Else
		If lApsInUse
			oSection:Cell('VarFim'):SetValue( A680TimeCale((cAliasSH8)->H8_DTFIM,cH8HrFim,cH6DtFim,cH6HrFim,(cAliasSH8)->H8_RECURSO) )
		Else
			oSection:Cell('VarFim'):SetValue( U_R815Dur((cAliasSH8)->H8_RECURSO,cH6DtFim,cH6HrFim,(cAliasSH8)->H8_DTFIM,cH8HrFim) )
		EndIf
	EndIf

	xDurAloc:=ConvTime((cAliasSH8)->H8_BITUSO)
    oSection:Cell('H8_BITUSO'):SetValue(xDurAloc) // Duracao Alocao

    If SH6->H6_TIPOTEM == 1 // Tipo Normal
	    xDurReal:=ConvTime( NIL, NIL, SH6->H6_TEMPO)
	ElseIf SH6->H6_TIPOTEM == 2 // Tipo Centesimal
	    xDurReal:= ConvTime( NIL, NIL, Substr(SH6->H6_TEMPO,1,4) + StrZero(Val(Substr(SH6->H6_TEMPO,5))*0.6,2) )
	EndIf
	oSection:Cell('H6_TEMPO'):SetValue(If(lAchouH6, xDurReal, '')) // Duracao Real

	oSection:Cell('Diferenca'):SetValue( If(lAchouH6,CalcDif(xDurAloc,xDurReal),'') )

	oReport:IncMeter()
	oSection:PrintLine()
	dbSelectArea(cAliasSH8)
	dbSkip()
	cH6HrIni := ''
	cH6HrFim := ''
EndDo

oSection:Finish()
(cAliasSH8)->(DbCloseArea())
dbSelectArea("SH8")
Set Filter to
dbCloseArea()
dbSelectArea("SC2")

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR890  ³ Autor ³ Jose Lucas            ³ Data ³ 09.09.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Acompanhamento das Operacoes                    ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MATR890(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo Sart.³02/06/98³XXXXXX³Acerto nas impressoes qdo lista por ordem³±±
±±³             ³        ³      ³de recurso ou ordem de data de inicio.   ³±±
±±³Rodrigo Sart.³19/10/98³18403A³Acerto nas descricoes do relatorio       ³±±
±±³Fernando J.  ³07/02/99³META  ³Imprimir OP's Firmes, Previstas ou Ambas.³±±
±±³Cesar Valadao³09/08/99³20030A³Listar Todos Apontamentos das Producoes  ³±±
±±³             ³        ³      ³Parciais.                                ³±±
±±³Patricia Sal.³18/04/00³003265³Imprimir Codigo da Ferramenta.           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR890R3()
LOCAL titulo 		:=STR0001	//"Relacao de Acompanhamento das Operacoes "
LOCAL cString		:="SH8"
LOCAL wnrel			:="MATR890"
LOCAL cDesc1 		:=STR0002	//"Este programa ira imprimir a Rela‡„o de Acompanhamento das Opera‡”es."
LOCAL cDesc2 		:=STR0003	//"Os valores referentes aos tempos de duracao est„o convertidos conforme"
LOCAL cDesc3 		:=STR0004	//"o parametro MV_TPHR. Se utilizada Prod. Mod. 2 podem haver divergencias."
LOCAL aOrd 			:= {STR0005,STR0006,STR0007}	//"Por Op"###"Por Recurso"###"Por Data Inicio"
LOCAL tamanho		:="G"
PRIVATE aReturn	:= {STR0008,1,STR0009, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
PRIVATE cPerg    	:="MTR890"
PRIVATE nLastKey 	:= 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR890",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // De                                    ³
//³ mv_par02            // Ate                                   ³
//³ mv_par03            // Impr. OP's Firmes, Previstas ou Ambas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//-- Verifica se o SH8 esta locado para atualizacao por outro processo
If !IsLockSH8()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho)

	If nLastKey = 27
		dbSelectArea("SH8")
		Set Filter to
		dbCloseArea()
		dbSelectArea("SC2")
		Return
	Endif

	titulo += "("+AllTRim(aOrd[aReturn[8]])+")"

	SetDefault(aReturn,cString)

	If nLastKey = 27
		dbSelectArea("SH8")
		Set Filter To
		dbCloseArea()
		dbSelectArea("SC2")
		Return
	Endif

	RptStatus({|lEnd| R890Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
EndIf
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R890Imp  ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR890			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R890Imp(lEnd,wnRel,titulo,tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt
LOCAL CbCont,cabec1,cabec2
LOCAL nCntImpr := 0
LOCAL cCond, lImpProd, cProdAnt,cIndex
LOCAL nomeprog:="MATR890"
LOCAL cRoteiro:=""
LOCAL DurAloc:="",DurReal:="" // Variaveis podem ser Caracter ou Numerica
LOCAL lAchou
LOCAL cH6HrIni := "", cH6HrFim := ""
LOCAL cH6DtIni := Ctod("  /  /  "), cH6DtFim := Ctod("  /  /  ")
LOCAL cH6Tempo	:= "", cH6Hora := 0, cH6Min := 0
Local lApsInUse := SuperGetMv("MV_APS",.F.,"") == "TOTVS"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := STR0019	//"ORDEM DE    O. RECURSO FERRAMENTA  P R O D U T O                                              I  N  I  C  I  O                              *               T  E  R  M  I  N  O               *     D U R A C A O"
cabec2 := STR0020	//"PRODUCAO                                                                            A L O C A D O            R  E  A  L           VARIACAO  *   A L O C A D O      R  E  A  L       VARIACAO  *   ALOC.  REAL     VAR"
*****                12345678901 12 123456   123456      123456789012345 123456789012345678901234567890 1234567890 12345       1234567890 12345                  1  1234567890 12345   1234567890 12345            1  1234567 1234567 1234567
*****                0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21
*****                012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega o nome do arquivo de indice de trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq := CriaTrab("",.F.)
dbSelectarea("SH8")
cCond := "H8_OP>='"+mv_par01+"'.And.H8_OP<='"+mv_par02+"'.And.H8_FILIAL=='"+xFilial()+"'"
If aReturn[8] == OP .Or. aReturn[8] == RECURSO
	dbSetOrder(aReturn[8])
	cIndex:= IndexKey()
Else
   cIndex:="H8_FILIAL+H8_DTINI"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o indice de trabalho                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IndRegua("SH8",cNomArq,cIndex,,cCond,STR0021)	//"Selecionando Registros..."

SetRegua(LastRec())

cProdAnt := Space(46)
dbGoTop()

While !Eof() .AND. H8_FILIAL == cFilial

	IncRegua()

	cOPAnt := SH8->H8_OP

   If lEnd
		@ Prow()+1,001 PSay STR0022	//"CANCELADO PELO OPERADOR"
		Exit
	EndIf

   dbSelectarea("SC2")
   dbSetOrder(1)
   dbSeek(cFilial+SH8->H8_OP)

	//-- Valida se a OP deve ser Impressa ou n„o        '
	If !MtrAValOP(mv_par03, 'SC2')
		dbSelectArea('SH8')
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Buscar Descricao do produto no arquivo SB1.             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SB1")
	dbSeek(cFilial+SC2->C2_PRODUTO)
	If Found()
		cProduto := Substr(SC2->C2_PRODUTO+" "+SB1->B1_DESC,1,45)
	Else
		cProduto := STR0023	//"Produto Inexistente no arquivo"
	EndIf
	lImpProd := IIf( cProduto == cProdAnt,.F.,.T.)
	cProdAnt := cProduto

	If Empty(SC2->C2_ROTEIRO)
		dbSeek(xFilial()+SC2->C2_PRODUTO)
		If !Empty(SB1->B1_OPERPAD)
			cRoteiro:=SB1->B1_OPERPAD
		Else
			cRoteiro:="01"
		EndIf
	Else
		cRoteiro:=SC2->C2_ROTEIRO
	EndIf

   dbSelectArea("SH1")
   dbSeek(cFilial+SH8->H8_RECURSO)
   dbSelectArea("SG2")
   dbSeek(cFilial+SC2->C2_PRODUTO+cRoteiro+SH8->H8_OPER)

   If li > 58
     	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
   EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posicionar no registro de movimentacao de Producoes SH6.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("SH6")
	dbSetOrder(1)
	lAchou := dbSeek(cFilial+SH8->H8_OP+SC2->C2_PRODUTO+SH8->H8_OPER)

	While If(lAchou,!Eof(),.F.) .And. If(lAchou,SH6->H6_FILIAL+SH6->H6_OP+SH6->H6_PRODUTO+SH6->H6_OPERAC == cFilial+SH8->H8_OP+SC2->C2_PRODUTO+SH8->H8_OPER,.F.)
		If lAchou .And. SH6->H6_DESDOBR != SH8->H8_DESDOBR
			DBSkip()
			Loop
		Endif

 		If Empty(cH6HrIni) .Or. (Dtos(SH6->H6_DATAINI) + TimeH6(,"H6_HORAINI")) < (Dtos(cH6DtIni) + cH6HrIni)
			cH6HrIni := TimeH6(,"H6_HORAINI")
			cH6DtIni := SH6->H6_DATAINI
		Endif

		If Empty(cH6HrFim) .Or. (Dtos(SH6->H6_DATAFIN) + TimeH6(,"H6_HORAFIN")) > (Dtos(cH6DtFim) + cH6HrFim)
			cH6HrFim := TimeH6(,"H6_HORAFIN")
			cH6DtFim := SH6->H6_DATAFIN
		Endif

		cH6Hora	+= Val(SubStr(SH6->H6_TEMPO,1,3))
		cH6Min	+= Val(SubStr(SH6->H6_TEMPO,5,2))
		If cH6Min > 60
			cH6Min -= 60
			cH6Hora++
		Endif
		cH6Tempo := TimeH6()
		dbSkip()
	Enddo

	lAchou := dbSeek(cFilial+SH8->H8_OP+SC2->C2_PRODUTO+SH8->H8_OPER)

	@ Li,000 PSay SH8->H8_OP
	@ Li,012 PSay SH8->H8_OPER
	@ Li,015 PSay SH8->H8_RECURSO
	@ LI,024 PSay SH8->H8_FERRAM
	@ Li,035 PSay IIf( lImpProd ,cProduto ,Space(45) )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Inicio Alocado.                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,082 PSay SH8->H8_DTINI
	@ Li,093 PSay SH8->H8_HRINI


	If lAchou
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Inicio Real.                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li,105 PSay cH6DtIni
		@ Li,116 PSay cH6HrIni

		If ( SH8->H8_DTINI > cH6DtIni ) .Or. ( SH8->H8_DTINI = cH6DtIni .And. SH8->H8_HRINI > cH6HrIni )
			If lApsInUse
				@ Li,130 PSay A680TimeCale(cH6DtIni,cH6HrIni,SH8->H8_DTINI,SH8->H8_HRINI,SH8->H8_RECURSO) Picture TimePict()
			Else
				@ Li,130 PSay U_R815Dur(SH8->H8_RECURSO,SH8->H8_DTINI,SH8->H8_HRINI,cH6DtIni,cH6HrIni) Picture TimePict()
			EndIf
		Else
			If lApsInUse
				@ Li,130 PSay A680TimeCale(SH8->H8_DTINI,SH8->H8_HRINI,cH6DtIni,cH6HrIni,SH8->H8_RECURSO)
			Else
				@ Li,130 PSay U_R815Dur(SH8->H8_RECURSO,cH6DtIni,cH6HrIni,SH8->H8_DTINI,SH8->H8_HRINI) Picture TimePict()
			EndIf
		EndIf

	EndIf
	@ Li,140 PSay "*"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Fim Alocado.                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,142 PSay SH8->H8_DTFIM
	@ Li,153 PSay SH8->H8_HRFIM

	If lAchou
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o Fim Real.                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		@ Li,161 PSay cH6DtFim
		@ Li,172 PSay cH6HrFim

		If ( SH8->H8_DTFIM > cH6DtFim ) .Or. ( SH8->H8_DTFIM = cH6DtFim .And. SH8->H8_HRFIM > cH6HrFim )
			If lApsInUse
				@ Li,180 PSay A680TimeCale(cH6DtFim,cH6HrFim,SH8->H8_DTFIM,SH8->H8_HRFIM,SH8->H8_RECURSO) Picture TimePict()
			Else
				@ Li,180 PSay U_R815Dur(SH8->H8_RECURSO,SH8->H8_DTFIM,SH8->H8_HRFIM,cH6DtFim,cH6HrFim) Picture TimePict()
			EndIf
		Else
			If lApsInUse
				@ Li,180 PSay A680TimeCale(SH8->H8_DTFIM,SH8->H8_HRFIM,cH6DtFim,cH6HrFim,SH8->H8_RECURSO) Picture TimePict()
			Else
				@ Li,180 PSay U_R815Dur(SH8->H8_RECURSO,cH6DtFim,cH6HrFim,SH8->H8_DTFIM,SH8->H8_HRFIM) Picture TimePict()
			EndIf
		EndIf

	EndIf
	@ Li,190 PSay "*"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a Duracao Alocada.                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DurAloc:=ConvTime(SH8->H8_BITUSO)
	@ Li,192 PSay DurAloc Picture TimePict()

	If lAchou
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a Duracao Real.                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    If SH6->H6_TIPOTEM == 1 // Tipo Normal
		    DurReal:=ConvTime( NIL, NIL, SH6->H6_TEMPO)
		ElseIf SH6->H6_TIPOTEM == 2 // Tipo Centesimal
		    DurReal:= ConvTime( NIL, NIL, Substr(SH6->H6_TEMPO,1,4) + StrZero(Val(Substr(SH6->H6_TEMPO,5))*0.6,2) )
		EndIf
		@ Li,201 PSay DurReal Picture TimePict()

		@ Li,209 PSay CalcDif(DurAloc,DurReal) Picture TimePict()

	EndIf
	nCntImpr ++

	Li ++

	dbSelectArea("SH8")
	dbSkip()
	cH6HrIni := ''
	cH6HrFim := ''
	If cOPAnt != SH8->H8_OP
		Li ++
	EndIf
EndDO

IF LI != 80
    roda(cbcont,cbtxt,"G")
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais do arquivo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SH8")
RetIndex("SH8")
Set Filter To
dbSetOrder(1)
dbCloseArea()
dbSelectArea("SC2")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq += OrdBagExt()
FErase( cNomArq )

If aReturn[5] = 1
   Set Printer TO
   dbCommitall()
   ourspool(wnrel)
Endif

MS_FLUSH()
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R815Dur  ³ Autor ³ Ary Medeiros          ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a duracao de uma operacao em Bits                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAPCP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R815Dur(cRecurso,dtFim,HrFim,dtIni,HrIni,cForcaTipo)
Local cAlias := Alias(), sCalend, nCount, nIniLoop, nEndLoop
Local cDur   := ""
Local cCargaFile, cCalFile, cBuffer, aCarga := Array(8)
Local cCalStr, nCalHdl, nHdl,i
Local cDirPCP		:= Alltrim(GetMV("MV_DIRPCP"))
Local cNameCarga	:= ""
Local cEmp690     	:= Alltrim(STR(a690FilNum(FwCodFil())))

cNameCarga := "CARGA"+cEmp690

Default cForcaTipo:=""
If !Empty(cDirPCP)
	cDirPCP += IIf( Right(cDirPCP,1) # "\" , "\" , "" )
EndIf
If Empty(dtFim) .or. Empty(HrFim) .or. Empty(dtIni) .or. Empty(HrIni)
	dbSelectArea(cAlias)
    Return "       "
endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le arquivo CARGA.MAQ para montar array de controle           ³
//³ aCarga[1] := Handler do arquivo                              ³
//³ aCarga[2] := Dia da geracao da carga de maquinas             ³
//³ aCarga[3] := Periodo                                         ³
//³ aCarga[4] := Precisao                                        ³
//³ aCarga[5] := Numero de maquinas                              ³
//³ aCarga[6] := Indice                                          ³
//³ aCarga[7] := Tamanho do registro                             ³
//³ aCarga[8] := Handler do arquivo de calendario                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//
DbSelectArea("SH8")
dbSetOrder(1)
dbSeek("SH8")
cCargaFile := cDirPCP+cNameCarga+".MAQ"
nHdl := FOpen(cCargaFile,0+64)
If nHdl == -1
	Help(" ",1,"SemCarga",,Str(Ferror(),2,0),05,38)
	dbSelectArea(cAlias)
	Return cDur
Endif
cCalFile := cDirPCP+cNameCarga+".CAL"
nCalHdl  := FOpen(cCalFile,0+64)
If nCalHdl == -1
	Help(" ",1,"SemCarga",,Str(Ferror(),2,0),05,38)
	fClose(nHdl)
	dbSelectArea(cAlias)
	Return cDur
Endif
cBuffer := Space(8)
aCarga[1] := nHdl
Fseek(nHdl,-8,2)
FRead(nHdl,@cBuffer,8)
aCarga[2] := StoD(cBuffer) // Dia da carga
cBuffer := Space(2)
Fseek(nHdl,-10,2)
Fread(nHdl,@cBuffer,2)
aCarga[3] := Bin2I(cBuffer) // Periodo
Fseek(nHdl,-12,2)
Fread(nHdl,@cBuffer,2)
aCarga[4] := Bin2I(cBuffer) // Precisao
FSeek(nHdl,-14,2)
FRead(nHdl,@cBuffer,2)
aCarga[5] := Bin2I(cBuffer) // Numero de maquinas
cBuffer := Space(7*aCarga[5])
FSeek(nHdl,-14-(7*aCarga[5]),2)
FRead(nHdl,@cBuffer,7*aCarga[5])
aCarga[6] := cBuffer // Indice da carga de maquinas
aCarga[7] := (24 * aCarga[3] * aCarga[4]) / 8 // Tamanho do registro
aCarga[8] := nCalHdl
cCalStr := Space( aCarga[7] )
FSeek(aCarga[8],PosiMaq(cRecurso,aCarga[6])*aCarga[7])
FRead(aCarga[8],@cCalStr,aCarga[7])
sCalend := Bin2Str(cCalStr)

nCount := 0
nIniLoop := dtHrInBits(dtIni,HrIni,aCarga[2])
nEndLoop := dthrInbits(dtFim,HrFim,aCarga[2])

For i := nIniLoop to (nEndLoop - 1)
	if Empty(Substr(sCalend,i,1))
		nCount++
	endif
Next
cDur:=ConvTime(nCount,NIL,NIL,cForcaTipo)
FCLOSE(nCalHdl)
fClose(nHdl)
dbSelectArea(cAlias)

Return cDur

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³DtHrInBits³ Autor ³ Ary Medeiros          ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Transforma uma data e hora centesimal em um bit            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAPCP                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DtHrInBits(dDia,cHora,dDiaIni)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define qual a precisao utilizada pelo SIGAPCP                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nPrecisao := GETMV("MV_PRECISA")
Local nHora := Val(Substr(cHora,1,2)+"."+Substr(cHora,4,2))
Local nRet
nRet := (24*nPrecisao*(dDia-dDiaIni)) + (nPrecisao * Int(nHora)) + (Val(Substr(Str(nHora,6,2),AT(".",Str(nHora,6,2))+1))/(60/nPrecisao))+1
Return nRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CalcDif  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 12/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a diferenca entre o tempo real e o alocado         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ RELATORIOS SIGAPCP                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CalcDif(DurAloc,DurReal)
Local cTempo:="",nTempo:=0,nPos:=0
Local	nHoraReal:=0,nMinutoReal:=0
Local nHoraAloc:=0,nMinutoAloc:=0
Local	nHorasDif:=0,nMinutosDif:=0
Static cTipoTemp:=""
If Empty(cTipoTemp)
	cTipoTemp:=GetMV("MV_TPHR")
EndIf
If cTipoTemp == "C"
	if Valtype(DurReal) == "C"
		DurReal	:= 0
	EndIf
	if Valtype(DurAloc) == "C"
		DurAloc := 0
	Endif
	nTempo:=DurReal-DurAloc
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Converte tudo p/ minutos para calcular corretamente          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nPos			:= AT(":",DurReal)
	nHoraReal	:= Val(Substr(DurReal,1,nPos-1)+"."+Substr(DurReal,nPos+1))
	nMinutoReal := (Int(nHoraReal)*60)+((nHoraReal-Int(nHoraReal))*100)
	nPos		:= AT(":",DurAloc)
	nHoraAloc   := Val(Substr(DurAloc,1,nPos-1)+"."+Substr(DurAloc,nPos+1))
	nMinutoAloc := (Int(nHoraAloc)*60)+((nHoraAloc-Int(nHoraAloc))*100)
	nHorasDif	:= Int((nMinutoReal-nMinutoAloc)/60)
	nMinutosDif := (nMinutoReal-nMinutoAloc)-(nHorasDif*60)
	cTempo      := StrZero(nHorasDif,nPos-1)+":"+StrZero(ABS(nMinutosDif),Len(DurAloc)-nPos)
	If (nMinutosDif < 0 .Or. nHorasDif < 0) .And. cTipoTemp == "C"
		cTempo:="-"+cTempo
	Else
		cTempo:=" "+cTempo
	EndIf
EndIf
Return IF(cTipoTemp=="C",nTempo,cTempo)
