/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/


#Include "MATR895.CH"
#INCLUDE "FIVEWIN.CH"

Static cTipoTemp
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR895   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 03/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio Comparativo Real X Previsto.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           
*/
User Function MATR895()
Local cExpData    := ""
Local lRetMsg     := .T.
Local oReport

Private aOrdem  := {STR0005,STR0006,STR0007,STR0008}	//"Por OP"###"Por Recurso"#####"Por Data"######"Por Operador" 
Private l680:=.F.,l681:=.F., lUlt := .F.  

If GetRpoRelease() >= "12.1.2410"
	cExpData := "20260331"
	lRetMsg  := PCPExpSV(cExpData,"MATR895", "PCPR895")
EndIf

If lRetMsg
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:= ReportDef()
		oReport:PrintDialog()
	Else
		U_MATR895R3()
	EndIf
EndIf

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³03/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³MATR895			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection1    // Secao 1
Local oSection2    // Secao 2
Local cTitle    := OemToAnsi(STR0001) //"Relatorio Comparativo Real X Previsto"
Local cPict     := TimePict()
Local cAliasSH6 := GetNextAlias()

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
oReport:= TReport():New("MATR895",cTitle,"MTR895", {|oReport| ReportPrint(oReport,cAliasSH6, cTitle)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+OemToAnsi(STR0004)) //##"Comparativo entre o apontamento real da producao e o planejado,"##"baseando-se no Roteiro de Opera‡”es.Os valores referentes aos "##"tempos est„o convertidos conforme o parametro MV_TPHR."
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas (MTR895)                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // De  OP									     ³
//³ mv_par02     // Ate OP									     ³
//³ mv_par03     // De  Recurso                                  ³
//³ mv_par04     // Ate Recurso                                  ³
//³ mv_par05     // De  Data                                     ³
//³ mv_par06     // Ate Data                                     ³
//³ mv_par07     // De  Operador                                 ³
//³ mv_par08     // Ate Operador                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:GetParam(),.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao das secoes utilizadas pelo relatorio                            ³
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
//³ Secao 1 (oSection1)                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0022,{"SH6","SC2","SB1","SH1","SH4","SG2"},aOrdem)
oSection1:SetHeaderPage()

TRCell():New(oSection1,'H6_OP'	    ,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_PRODUTO'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_OPERAC'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'G2_DESCRI'	,'SG2',/*Titulo*/,/*Picture*/, 15        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_RECURSO'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H1_DESCRI'	,'SH1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_FERRAM' 	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H4_DESCRI' 	,'SH4',/*Titulo*/,/*Picture*/, 18        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_OPERADO'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'C2_QUANT'	,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_QTDPROD'	,'SH6',"(*)"+RetTitle("H6_QTDPROD"),/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_QTDPERD'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'HoraPrev'	,'SH6', STR0020  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'HoraReal'	,'SH6', STR0021  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'H6_DTAPONT'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 2 (oSection2) - Totalizadora                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0019,{"SH6","SC2","SH1","SH4","SG2"},/*aOrdem*/) //"Relatorio Comparativo Real X Previsto"
oSection2:SetHeaderPage(.F.)                 
oSection2:SetHeaderSection(.F.)              

TRCell():New(oSection2,'DescrTot'	,'SH6',STR0019+" "+STR0006,/*Picture*/,40,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'C2_QUANT'	,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'H6_QTDPROD'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'H6_QTDPERD'	,'SH6',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'HoraPrev'	,'SH6', STR0020  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,'HoraReal'	,'SH6', STR0021  , cPict     ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³03/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³ExpO2: Alias da tabela SH6                                  ³±±
±±³          ³ExpO3: Define se ira utilizar Query (Top)                   ³±±
±±³          ³ExpO4: Titulo do Relatorio                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR895	   		                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport, cAliasSH6,  cTitle)
Local oSection1   := oReport:Section(1)
Local oSection2   := oReport:Section(1):Section(1)
Local nOrdem      := oSection1:GetOrder()
Local cOrderBy
Local cCondicao
Local cCampo
Local cQuebra
Local cRoteiro
Local cHrPrev, cHrReal
Local nTotQtdOp, nTotQtdPrd, nTotQtdPer, nTotHrPrev, nTotHrReal
Local cWhere01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo a chave de indice para Quebra e o titulo do Relatorio, conforme a Ordem selecionada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1 //"Por OP"
	cOrderBy := "% H6_FILIAL, H6_OP, H6_DTAPONT %"   
	cCampo   := "H6_FILIAL+H6_OP"
	oReport:SetTitle(cTitle+"   "+"("+STR0005+")") //"Relatorio Comparativo Real X Previsto"##"Por OP"
Elseif nOrdem == 2 //"Por Recurso"
	cOrderBy := "% H6_FILIAL, H6_RECURSO, H6_DTAPONT %"
	cCampo   := "H6_FILIAL+H6_RECURSO"
	oReport:SetTitle(cTitle+"   "+"("+STR0006+")") //"Relatorio Comparativo Real X Previsto"##"Por Recurso"
Elseif nOrdem == 3 //"Por Data" 
	cOrderBy := "% H6_FILIAL, H6_DTAPONT, H6_RECURSO %"
	cCampo   := "H6_FILIAL+DTOS(H6_DTAPONT)"
	oReport:SetTitle(cTitle+"   "+"("+STR0007+")") //"Relatorio Comparativo Real X Previsto"##"Por Data"
Elseif nOrdem == 4 //"Por Operador"
	cOrderBy := "% H6_FILIAL, H6_OPERADO, H6_DTAPONT %"
	cCampo   := "H6_FILIAL+H6_OPERADO"
	oReport:SetTitle(cTitle+"   "+"("+STR0008+")") //"Relatorio Comparativo Real X Previsto"##"Por Operador"	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:GetParam())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao Where para filtrar OP's                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhere01 := "%"
If	Upper(TcGetDb()) $ 'ORACLE,DB2,POSTGRES,INFORMIX'
	cWhere01  += "SC2.C2_NUM = SUBSTR(SH6.H6_OP,1,6) AND " 
	cWhere01  += "SC2.C2_ITEM = SUBSTR(SH6.H6_OP,7,2) AND "
	cWhere01  += "SC2.C2_SEQUEN = SUBSTR(SH6.H6_OP,9,3) AND "
	cWhere01  += "SC2.C2_ITEMGRD = SUBSTR(SH6.H6_OP,12,3)"
Else
    cWhere01  += "SC2.C2_NUM = SUBSTRING(SH6.H6_OP,1,6) AND "
	cWhere01  += "SC2.C2_ITEM = SUBSTRING(SH6.H6_OP,7,2) AND "
	cWhere01  += "SC2.C2_SEQUEN = SUBSTRING(SH6.H6_OP,9,3) AND "
	cWhere01  += "SC2.C2_ITEMGRD = SUBSTRING(SH6.H6_OP,12,3)"
EndIf
cWhere01 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

 	BEGIN REPORT QUERY oSection1
 	BeginSql Alias cAliasSH6

SELECT SH6.H6_FILIAL, SH6.H6_OP, SH6.H6_PRODUTO, SH6.H6_OPERAC, SH6.H6_RECURSO, SH6.H6_FERRAM, SH6.H6_OPERADO,
       SH6.H6_QTDPROD, SH6.H6_QTDPERD, SH6.H6_DTAPONT, SH6.H6_TIPO, SH6.H6_TEMPO, SH6.H6_TIPOTEM,
       SH6.H6_SEQ,SH6.H6_DATAINI, SH6.H6_HORAINI, SH6.H6_DATAFIN, SH6.H6_HORAFIN,SH6.R_E_C_N_O_, 
       SC2.C2_FILIAL, SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_ITEMGRD, SC2.C2_QUANT, SC2.C2_ROTEIRO, SC2.C2_QUJE,
       SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_OPERPAD,
       SH1.H1_FILIAL, SH1.H1_CODIGO, SH1.H1_DESCRI, SH1.H1_MAOOBRA,
       SH4.H4_FILIAL, SH4.H4_CODIGO, SH4.H4_DESCRI

	FROM %table:SH6% SH6
	
	LEFT JOIN %table:SC2% SC2 ON
  		SC2.C2_FILIAL = %xFilial:SC2% AND %Exp:cWhere01% AND	SC2.%NotDel%
	
	LEFT JOIN %table:SB1% SB1 ON
  		SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = SH6.H6_PRODUTO AND SB1.%NotDel%
	
	LEFT JOIN %table:SH1% SH1 ON
  		SH1.H1_FILIAL = %xFilial:SH1% AND SH1.H1_CODIGO = SH6.H6_RECURSO AND SH1.%NotDel%
	
	LEFT JOIN %table:SH4% SH4 ON
  		SH4.H4_FILIAL = %xFilial:SH4% AND SH4.H4_CODIGO = SH6.H6_FERRAM AND SH4.%NotDel%
	
	WHERE SH6.H6_FILIAL  = %xFilial:SH6% AND
  		SH6.H6_OP >= %Exp:mv_par01% AND
 		SH6.H6_OP <= %Exp:mv_par02% AND
	SH6.H6_RECURSO >= %Exp:mv_par03% AND
	SH6.H6_RECURSO <= %Exp:mv_par04% AND
	SH6.H6_DTAPONT >= %Exp:mv_par05% AND
	SH6.H6_DTAPONT <= %Exp:mv_par06% AND
	SH6.H6_OPERADO >= %Exp:mv_par07% AND
	SH6.H6_OPERADO <= %Exp:mv_par08% AND
	SH6.H6_TIPO In ('P',' ' ) AND
	SH6.%NotDel%

	ORDER BY %Exp:cOrderBy%

EndSql 
END REPORT QUERY oSection1 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter( SH6->(LastRec()) )
oSection1:Init()
oSection2:Init()
dbSelectArea(cAliasSH6)
While !oReport:Cancel() .And. !(cAliasSH6)->(Eof())
	nTotQtdOp	:= 0
	nTotQtdPrd	:= 0
	nTotQtdPer	:= 0
	nTotHrPrev	:= 0	
	nTotHrReal	:= 0
	cQuebra:= (cAliasSH6)->&(cCampo)
	Do While !(cAliasSH6)->(Eof()) .And. (cAliasSH6)->&(cCampo) == cQuebra
		If !Empty((cAliasSH6)->C2_ROTEIRO)
			cRoteiro:=(cAliasSH6)->C2_ROTEIRO
		Else
			cRoteiro:=(cAliasSH6)->B1_OPERPAD
		EndIf		
		
		If Empty(cRoteiro)
			cRoteiro := StrZero(1, Len(SG2->G2_CODIGO))
		Endif	
		
		//Valida se é ultima operação
		lUlt		:= .F. //Ultima operação
		aAreaSH6	:=  SH6->(GetArea())
		
		DBSELECTAREA("SH6")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SH6")+(cAliasSH6)->H6_OP+(cAliasSH6)->H6_PRODUTO+(cAliasSH6)->H6_OPERAC+(cAliasSH6)->H6_SEQ+dtos((cAliasSH6)->H6_DATAINI)+(cAliasSH6)->H6_HORAINI+dtos((cAliasSH6)->H6_DATAFIN)+(cAliasSH6)->H6_HORAFIN )

		IF A680UltOper(.F.) //função que valida se o registro pertence a ultima operação. 
			lUlt := .T.         
		ENDIF
		
		RestArea(aAreaSH6)

		dbSelectArea("SG2")    
		a630SeekSG2(1,(cAliasSH6)->H6_PRODUTO,xFilial("SG2")+(cAliasSH6)->(H6_PRODUTO+cRoteiro+H6_OPERAC))
		dbSelectArea(cAliasSH6)
		
		cHrPrev		:= R895Calc(cAliasSH6)
		cHrReal		:= TimeH6(NIL, NIL, cAliasSH6)
		If cTipoTemp == "C"
			cHrReal := Val(StrTran(cHrReal, ":", "."))
		EndIf
		oSection1:Cell("G2_DESCRI"):SetValue( SG2->G2_DESCRI )
		oSection1:Cell("HoraPrev"):SetValue( cHrPrev )
		oSection1:Cell("HoraReal"):SetValue( cHrReal )
		
		// Definindo os totalizadores	
		nTotQtdOp	:= (cAliasSH6)->C2_QUANT
		//nTotQtdPrd	:= (cAliasSH6)->H6_QTDPROD
		//nTotQtdPrd	:= (cAliasSH6)->C2_QUJE 
		
		IF lUlt //VERIFICA SÉ É ULTIMA OPERAÇÃO
			aAreaH6		:=  (cAliasSH6)->(GetArea()) 		
		
			nTotQtdPrd += r895ult( (cAliasSH6)->H6_OPERAC,(cAliasSH6)->H6_OP, cWhere01,cOrderBy,nOrdem,(cAliasSH6)->R_E_C_N_O_ )
		
			RESTAREA(aAreaH6)
		
		ENDIF		
				
		nTotQtdPer	+= (cAliasSH6)->H6_QTDPERD
		nTotHrPrev	+= If(cTipoTemp=="N",Val(StrTran(A680ConvHora(cHrPrev, "N", "C"), ":", ".")),cHrPrev)
		nTotHrReal	+= If(cTipoTemp=="N",Val(StrTran(A680ConvHora(cHrReal, "N", "C"), ":", ".")),cHrReal)

		oReport:IncMeter()
		oSection1:PrintLine() // Impressao da secao 1		
		(cAliasSH6)->(dbSkip())
	EndDo
	
	oReport:SkipLine()
           
    oSection2:Cell('C2_QUANT'  ):SetValue( nTotQtdOp  )
    oSection2:Cell('H6_QTDPROD'):SetValue( nTotQtdPrd ) 
    oSection2:Cell('H6_QTDPERD'):SetValue( nTotQtdPer )                       
    oSection2:Cell('HoraPrev'  ):SetValue(If(cTipoTemp=="N",AjustaHora(A680ConvHora(AllTrim(Str(nTotHrPrev)), "C", "N"),9),nTotHrPrev))
    oSection2:Cell('HoraReal'  ):SetValue(If(cTipoTemp=="N",AjustaHora(A680ConvHora(AllTrim(Str(nTotHrReal)), "C", "N"),9),nTotHrReal))
    oSection2:Cell('DescrTot'  ):SetValue( STR0019+" "+aOrdem[nOrdem]+":"  ) 
    
    
	If oSection1:Cell('C2_QUANT'):lVisible 
		oSection2:Cell('C2_QUANT'  ):nCol := oSection1:Cell('C2_QUANT'  ):nCol	
		oSection2:Cell('DescrTot'  ):nCol := oSection1:Cell('C2_QUANT'  ):nCol - 350
	EndIf
	
	If oSection1:Cell('H6_QTDPROD'  ):lVisible
		oSection2:Cell('H6_QTDPROD'  ):nCol := oSection1:Cell('H6_QTDPROD'  ):nCol
	EndIf
	
	If oSection1:Cell('H6_QTDPERD'  ):lVisible
		oSection2:Cell('H6_QTDPERD'  ):nCol := oSection1:Cell('H6_QTDPERD'  ):nCol
	EndIf
	
	If oSection1:Cell('HoraPrev'  ):lVisible
		oSection2:Cell('HoraPrev'  ):nCol := oSection1:Cell('HoraPrev'  ):nCol
	EndIf	
	
	If oSection1:Cell("HoraReal"  ):lVisible
		oSection2:Cell("HoraReal"  ):nCol := oSection1:Cell("HoraReal"  ):nCol
	EndIf
		
	oSection2:PrintLine() // Impressao da secao 2
	If !(cAliasSH6)->(Eof())
   		oReport:SkipLine()
		oReport:ThinLine()
	EndIf
	
	nTotQtdPrd := 0 // Zera o total para o proximo item
EndDo

If !oReport:Cancel()
	oReport:SkipLine()
	oReport:PrintText("(*)"+STR0023, oReport:Row(), 000 ) // "Total QUANTIDADE PRODUZIDA é igual a somatória de todos os"
	oReport:SkipLine()
	oReport:PrintText("   "+STR0024, oReport:Row(), 000 ) // "apontamentos, conforme a quebra definida para impressão"
EndIf

oSection1:Finish()
oSection2:Finish()
(cAliasSH6)->(DbCloseArea())

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡…o ³ PLANO DE MELHORIA CONTINUA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data         |BOPS:		      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³      01  ³                          ³              |                  ³±±
±±³      02  ³Erike Yuri da Silva       ³07/02/2006    |00000092906       ³±±
±±³      03  ³Erike Yuri da Silva       ³22/03/2006    |00000095536       ³±±
±±³      04  ³                          ³              |                  ³±±
±±³      05  ³                          ³              |                  ³±±
±±³      06  ³                          ³              |                  ³±±
±±³      07  ³                          ³              |                  ³±±
±±³      08  ³                          ³              |                  ³±±
±±³      09  ³Erike Yuri da Silva       ³07/02/2006    |00000092906       ³±±
±±³      10  ³Erike Yuri da Silva       ³22/03/2006    |00000095536       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR895  ³ Autor ³Rodrigo de A. Sartorio ³ Data ³ 14/01/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio Comparativo Real X Previsto                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAPCP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo Sart³26/10/98³16974A³ Acerto na impressao do tempo previsto    ³±±
±±³Rodrigo Sart³04/11/98³XXXXXX³ Acerto p/ Bug Ano 2000                   ³±±
±±³Cesar       ³31/03/99³XXXXXX³Manutencao na SetPrint()                  ³±±
±±³Patricia Sal³18/04/00³003265³Imprimir Cod/Descr. da Ferramenta.        ³±±
±±³Iuspa       ³03/10/00³005389³Imprimir Quantidade de Perda da Produção  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR895R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis obrigatorias dos programas de relatorio            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL Tamanho  := "G"
LOCAL titulo   := STR0001	//"Relatorio Comparativo Real X Previsto"
LOCAL cDesc1   := STR0002	//"Comparativo entre o apontamento real da producao e o planejado,"
LOCAL cDesc2   := STR0003	//"baseando-se no Roteiro de Opera‡”es.Os valores referentes aos "
LOCAL cDesc3   := STR0004	//"tempos est„o convertidos conforme o parametro MV_TPHR."
LOCAL cString  := "SH6"
LOCAL aOrd     := {STR0005,STR0006,STR0007,STR0008}	//"Por OP"###"Por Recurso"###"Por Data"###"Por Operador"
LOCAL wnrel    := "MATR895"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aReturn:= {STR0009,1,STR0010, 2, 2, 1, "",1 }	//"Zebrado"###"Administracao"
PRIVATE nLastKey:= 0 ,cPerg := "MTR895"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas - MTR895                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // De  OP									     ³
//³ mv_par02     // Ate OP									     ³
//³ mv_par03     // De  Recurso                                  ³
//³ mv_par04     // Ate Recurso                                  ³
//³ mv_par05     // De  Data                                     ³
//³ mv_par06     // Ate Data                                     ³
//³ mv_par07     // De  Operador                                 ³
//³ mv_par08     // Ate Operador                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey = 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| C895Imp(aOrd,@lEnd,wnRel,titulo,Tamanho)},titulo)

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ C895IMP  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 14/01/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR895  			                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function C895Imp(aOrd,lEnd,WnRel,titulo,Tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL nTipo    := 0
LOCAL cRodaTxt := STR0011	//"REGISTRO(S)"
LOCAL nCntImpr := 0
LOCAL cQuebra,cCampo,cMens
LOCAL cIndex,cRoteiro
LOCAL cHrReal	:= "0000:00"
LOCAL cHrPrev	:= "0000:00"
LOCAL nTotHrReal:= 0
LOCAL nTotHrPrev:= 0
LOCAL nTotQtdOp	:= 0
LOCAL nTotQtdPrd:= 0
LOCAL nTotQtdPer:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao de Filtragem do SH6                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cCond := 'H6_FILIAL=="'+xFilial("SH6")+'".And.H6_TIPO$" P".And.'
		cCond += 'H6_OP>="'+mv_par01+'".And.H6_OP<="'+mv_par02+'".And.'
		cCond += 'H6_RECURSO>="'+mv_par03+'".And.H6_RECURSO<="'+mv_par04+'".And.'
		cCond += 'DTOS(H6_DTAPONT)>="'+DTOS(mv_par05)+'".And.DTOS(H6_DTAPONT)<="'+DTOS(mv_par06)+'"'
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Indice Condicional de acordo com a ordem selecionada.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[8] = 1
	cIndex:="H6_FILIAL+H6_OP+DTOS(H6_DTAPONT)"
	cCampo:="H6_FILIAL+H6_OP"
	cMens:=STR0012	//"da OP:"
ElseIf aReturn[8] = 2
	cIndex:="H6_FILIAL+H6_RECURSO+DTOS(H6_DTAPONT)"
	cCampo:="H6_FILIAL+H6_RECURSO"
	cMens:=STR0013	//"do Recurso:"
ElseIf aReturn[8] = 3
	cIndex:="H6_FILIAL+DTOS(H6_DTAPONT)+H6_RECURSO"
	cCampo:="H6_FILIAL+DTOS(H6_DTAPONT)"
	cMens:=STR0014	//"da Data:"
ElseIf aReturn[8] = 4
	cIndex:="H6_FILIAL+H6_OPERADO+DTOS(H6_DTAPONT)"
	cCampo:="H6_FILIAL+H6_OPERADO"
	cMens:=STR0015	//"do Operador:"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega o nome do arquivo de indice de trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq := CriaTrab("",.F.)

If cTipoTemp == Nil
	cTipoTemp:=GetMV("MV_TPHR")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o indice de trabalho                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SH6")
IndRegua("SH6",cNomArq,cIndex,,cCond,STR0016)	//"Selecionando Registros..."
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis para controlar cursor de progressao     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(LastRec())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo+=" "+aOrd[aReturn[8]]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os codigos de caracter Comprimido/Normal da impressora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o cabecalho.                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := STR0017  // "ORDEM DE      PRODUTO         OPERACAO DESCRICAO          RECURSO                                FERRAMENTA                OPERADOR     QUANTIDADE     (*)QUANTIDADE        QUANTIDADE        TEMPO     TEMPO   DATA DO"
cabec2 := STR0018  //"PRODUCAO                               DA OPERACAO                                                                                      TOTAL DA OP       PRODUZIDA         PERDA             ESTIMADO  REAL    APONTAMENTO"

*****                 1234567890123 123456789012345    12    123456789012345678 123456 123456789012345678901234567890  123456 123456789012345678 1234567890   1234567890123456  1234567890123456  1234567890123456  123456    123456  1234567890
*****                 0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21
*****                 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona os arquivos que serao utilizados na ordem correta para    ³
//³ listar o relatorio.                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC2")
dbSetOrder(1)
dbSelectArea("SB1")
dbSetOrder(1)
dbSelectArea("SH6")

Do While SH6->(!Eof())
	If SH6->(H6_OPERADO) < mv_par07 .Or. SH6->(H6_OPERADO) > mv_par08
		dbSkip()
		Loop
	EndIf	
	cHrReal		:= If(cTipoTemp=="N","0000:00",0)
	cHrPrev		:= cHrReal
	nTotHrReal	:= 0
	nTotHrPrev	:= 0	
	nTotQtdOp	:= 0
	nTotQtdPrd	:= 0
	nTotQtdPer	:= 0
	cQuebra:=SH6->&(cCampo)
	Do While !Eof() .And.SH6->&(cCampo) == cQuebra
		If SH6->H6_OPERADO < mv_par07 .Or. SH6->H6_OPERADO > mv_par08
			dbSkip()
			Loop
		EndIf
		If li > 58
			cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
		EndIf
		dbSelectArea("SH1")
		dbSeek(xFilial("SH1")+SH6->H6_RECURSO)
		dbSelectArea("SH4")
		dbSeek(xFilial("SH4")+SH6->H6_FERRAM)		
		dbSelectArea("SC2")
		dbSeek(xFilial("SC2")+SH6->H6_OP)
		If !Empty(C2_ROTEIRO)
			cRoteiro:=C2_ROTEIRO
		Else
			dbSelectArea("SB1")
			dbSeek(xFilial("SB1")+SH6->H6_PRODUTO)
			cRoteiro:=B1_OPERPAD
		EndIf		

		If Empty(cRoteiro)
			cRoteiro := StrZero(1, Len(SG2->G2_CODIGO))
		Endif	

		dbSelectArea("SG2")
		a630SeekSG2(1,SH6->H6_PRODUTO,xFilial("SG2")+SH6->H6_PRODUTO+cRoteiro+SH6->H6_OPERAC)
		dbSelectArea("SH6")
		cHrReal		:= R895Calc()
		cHrPrev		:= TimeH6()
		If cTipoTemp == "C"
			cHrPrev := Val(StrTran(cHrPrev, ":", "."))
		EndIf

		@ li,000 PSay Substr(SH6->H6_OP,1,13)				Picture PesqPict("SH6","H6_OP",13)
		@ li,014 PSay Substr(SH6->H6_PRODUTO,1,15)    		Picture PesqPict("SH6","H6_PRODUTO",15)
		@ li,033 PSay Substr(SH6->H6_OPERAC,1,2)				Picture PesqPict("SH6","H6_OPERAC",2)
		@ li,039 PSay Substr(SG2->G2_DESCRI,1,18)		Picture PesqPict("SG2","G2_DESCRI",20)
		@ li,058 PSay SH6->H6_RECURSO						Picture PesqPict("SH6","H6_RECURSO",6)
		@ li,065 PSay Substr(SH1->H1_DESCRI,1,30)
		@ li,097 Psay H6_FERRAM                         Picture PesqPict("SH6", "H6_FERRAM")
		@ li,104 PSay Substr(SH4->H4_DESCRI,1,18)
		@ li,123 PSay Substr(SH6->H6_OPERADO,1,10)      Picture PesqPict("SH6", "H6_OPERADO")
		@ li,136 PSay SC2->C2_QUANT						Picture PesqPictQt("C2_QUANT",16)
		@ li,154 PSay SH6->H6_QTDPROD             			Picture PesqPictQt("H6_QTDPROD",16)
		@ li,172 PSay SH6->H6_QTDPERD             			Picture PesqPictQt("H6_QTDPERD",16)
		@ li,190 PSay cHrReal							Picture TimePict()
		@ li,200 PSay cHrPrev							Picture If(cTipoTemp == "C",TimePict(),"@!")    // Converte campo H6_TEMPO para normal
		@ li,208 PSay SH6->H6_DTAPONT						Picture PesqPict("SH6","H6_DTAPONT",8)

		nTotHrReal	+= If(cTipoTemp=="N", Val(StrTran(A680ConvHora(cHrReal, "N", "C"), ":", ".")),cHrReal)
		nTotHrPrev	+= If(cTipoTemp=="N",Val(StrTran(A680ConvHora(cHrPrev, "N", "C"), ":", ".")),cHrPrev)

		nTotQtdOp	+= SC2->C2_QUANT	    	
		nTotQtdPrd	+= SH6->H6_QTDPROD
		nTotQtdPer	+= SH6->H6_QTDPERD		
		li++
		dbSkip()
	EndDo

	If !Empty(nTotQtdOp+nTotQtdPrd+nTotQtdPer)
		li++
		@ li,110 PSay STR0019+cMens   //"Totalizador "
		@ li,136 PSay nTotQtdOp					Picture PesqPictQt("C2_QUANT",16)
		@ li,154 PSay nTotQtdPrd            	Picture PesqPictQt("H6_QTDPROD",16)
		@ li,172 PSay nTotQtdPer            	Picture PesqPictQt("H6_QTDPERD",16)
		@ li,190 PSay If(cTipoTemp=="N",AjustaHora(A680ConvHora(AllTrim(Str(nTotHrReal)), "C", "N"),9),nTotHrReal)		Picture TimePict()
		@ li,200 PSay If(cTipoTemp=="N",AjustaHora(A680ConvHora(AllTrim(Str(nTotHrPrev)), "C", "N"),9),nTotHrPrev)		Picture TimePict()
		li+=3
	Else			
		li++
	EndIf
	If li > 58
		cabec(titulo,cabec1,cabec2,wnrel,Tamanho,nTipo)
	EndIf
EndDo

IF li != 80
	@ 55,000 PSay "(*)"+STR0023 // "Total QUANTIDADE PRODUZIDA é igual a somatória de todos os"
	@ 56,000 PSay "   "+STR0024 // "apontamentos, conforme a quebra definida para impressão"
	Roda(nCntImpr,cRodaTxt,Tamanho)
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais do arquivo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SH6")
Set Filter to

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq += OrdBagExt()
Delete File &(cNomArq)

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R895Calc ³ Autor ³Rodrigo de A. sartorio ³ Data ³ 14/01/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Soma tempo do totalizador                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R895Calc(cAliasSH6)
Local aTotal  := {}
Local cTime   := Nil
Local nLotPad := If(SG2->G2_LOTEPAD==0,1,SG2->G2_LOTEPAD)
Local nQuant  := 0
Local nTemPad := If(SG2->G2_TEMPAD ==0,1,SG2->G2_TEMPAD)
Local nTempo  := Nil

Default cAliasSH6 := "SH6"

nQuant  := (cAliasSH6)->(H6_QTDPROD+H6_QTDPERD)

If cTipoTemp == Nil
	cTipoTemp:=GetMV("MV_TPHR")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se MV_TPHR for N (Normal) devo converter G2_TEMPAD para            ³
//³ centesimal para permitir multiplicar pela quantidade produzida     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTipoTemp == "N"
	nTemPad := Int(nTemPad) + (Mod(nTemPad, 1) / 0.6)
Endi

// Calcula Tempo de Dura‡„o baseado no Tipo de Operacao
If SG2->G2_TPOPER $ " 1"
	nTempo := nQuant * nTemPad / nLotPad
	dbSelectArea("SH1")
	dbSeek(xFilial("SH1")+(cAliasSH6)->H6_RECURSO)
	If Found() .And. SH1->H1_MAOOBRA # 0
		nTempo :=Round( nTempo / H1_MAOOBRA,5)
	EndIf
	dbSelectArea(cAliasSH6)
ElseIf SG2->G2_TPOPER == "4"
	nQuantAloc:= nQuant % nLotPad
	nQuantAloc:= Int(nQuant)+If(nQuantAloc>0,nLotPad-nQuantAloc,0)
	nTempo := Round(nQuantAloc * ( nTemPad / nLotPad ),5)
	dbSelectArea("SH1")
	dbSeek(xFilial("SH1")+(cAliasSH6)->H6_RECURSO)
	If Found() .And. SH1->H1_MAOOBRA # 0
		nTempo :=Round( nTempo / H1_MAOOBRA,5)
	EndIf
	dbSelectArea(cAliasSH6)
ElseIf SG2->G2_TPOPER == "2"
	aTotal := FH6Total(SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN,(cAliasSH6)->H6_OPERAC)
	If nQuant == 0
		nTemPad := (nTemPad/(aTotal[3] + aTotal[2])) * aTotal[3]
		nTempo := (nTemPad/aTotal[3])* 1
	else
		nTemPad := (nTemPad/(aTotal[2] + aTotal[3]))*aTotal[2]
		nTempo := (nTemPad/aTotal[1])* nQuant
	EndIf

ElseIf SG2->G2_TPOPER == "3"
	nTempo := nTemPad
EndIf

If cTipoTemp == "N"
	cTime  := StrZero(Int(nTempo), 3) + ":" + StrZero(Mod(nTempo, 1) * 100, 2)
	cTime := A680ConvHora(cTime, "C", "N")
Endif

Return IF(cTipoTemp=="N",cTime,nTempo)

/*/{Protheus.doc} FH6Total
Retonar as quantidades de apontamentos
@type  Static Function
@author guilherme.bertoldi
@since 18/02/2022
@version 12.1.33
@param 01 cOp, character, numero da OP
@param 02 cOperac, character, Operacao
@return array, array, retorna a quantidade de producao, quantidade de apontamentos e a quantidade apontada sem producao.
/*/
Static Function FH6Total(cOp,cOperac)
	Local nQtdTotal := 0
	Local nQtdApont := 0
	Local nQtdCount := 0

	cAliasSH6 := GetNextAlias()
	//QUANTIDADE TOTAL DE APONTAMENTOS
	BeginSQL alias cAliasSH6

		SELECT
			SUM(SH6.H6_QTDPROD + SH6.H6_QTDPERD) TOTAL, COUNT(SH6.H6_QTDPROD + SH6.H6_QTDPERD) COUNTTOTAL
		FROM
			%table:SH6% SH6
		WHERE
			SH6.%notDel% AND
			SH6.H6_FILIAL = %xfilial:SH6% AND
			(SH6.H6_QTDPROD != '0' OR SH6.H6_QTDPERD != '0') AND
			SH6.H6_OP = %exp:cOp% AND
			SH6.H6_OPERAC = %exp:cOperac%

	EndSQL

	nQtdTotal := (cAliasSH6)->(TOTAL)
	nQtdCount := (cAliasSH6)->(COUNTTOTAL)
	(cAliasSH6)->(dbCloseArea())

		cAliasSH6 := GetNextAlias()
	//QUANTIDADE TOTAL DE APONTAMENTOS
	BeginSQL alias cAliasSH6

		SELECT
			COUNT(SH6.H6_QTDPROD) TOTAL
		FROM
			%table:SH6% SH6
		WHERE
			SH6.%notDel% AND
			SH6.H6_FILIAL = %xfilial:SH6% AND
			SH6.H6_QTDPROD = '0' AND
			SH6.H6_QTDPERD = '0' AND
			SH6.H6_OP = %exp:cOp% AND
			SH6.H6_OPERAC = %exp:cOperac%

	EndSQL

	nQtdApont := (cAliasSH6)->(TOTAL)
	(cAliasSH6)->(dbCloseArea())

Return {nQtdTotal, nQtdCount, nQtdApont}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³AjustaHora³ Autor ³Erike Yuri da Silva    ³ Data ³ 22/03/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retira zeros a esquerda da hora, limitando a var. nTam     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjustaHora(cHora,nTam)
Local nLen := Len(cHora) - nTam
While nLen > 0
	nLen--
	If SubStr(cHora,1,1)<>"0"
		Exit
	EndIf
	cHora := Substr(cHora,2,Len(cHora))
EndDo
Return cHora

/*/{Protheus.doc} r895ult
Busca valor da ultima operacao do registro
@author Thiago.zoppi
@since 17/04/2018
@version 1.0

/*/
Static Function r895ult(noperac,cOp, cWhere01,cOrderBy,nOrdem,cRecno )
local nqtrprod 	:= 0 
local cAliasUlt	:=  GETNEXTALIAS()
local cWhereOrd := ''
cWhereOrd := "%"

	IF nOrdem == 1
	
		cWhereOrd  += "SH6.H6_OP ='"+ cOp+"'" 
	
			
	Else
	  cWhereOrd  += "SH6.H6_OP >='"+ cOp+"'"
	  cWhereOrd  += "AND SH6.H6_OP <='"+ cOp+"'"
	 	  
		//SH6.H6_OP >= %Exp:mv_par01% AND
		//SH6.H6_OP <= %Exp:mv_par02% AND
		
	EndIf
cWhereOrd += "%"

BeginSql Alias cAliasUlt

SELECT 
	//TOP(1) SH6.H6_FILIAL, SH6.H6_OP, SH6.H6_PRODUTO, SH6.H6_OPERAC, SH6.H6_RECURSO,H6_QTDPROD
	H6_QTDPROD, H6_OPERAC

	FROM %table:SH6% SH6
	
	LEFT JOIN %table:SC2% SC2 ON
  		SC2.C2_FILIAL = %xFilial:SC2% AND %Exp:cWhere01% AND	SC2.%NotDel%
	
	LEFT JOIN %table:SB1% SB1 ON
  		SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = SH6.H6_PRODUTO AND SB1.%NotDel%
	
	LEFT JOIN %table:SH1% SH1 ON
  		SH1.H1_FILIAL = %xFilial:SH1% AND SH1.H1_CODIGO = SH6.H6_RECURSO AND SH1.%NotDel%
	
	LEFT JOIN %table:SH4% SH4 ON
  		SH4.H4_FILIAL = %xFilial:SH4% AND SH4.H4_CODIGO = SH6.H6_FERRAM AND SH4.%NotDel%

	WHERE SH6.H6_FILIAL  = %xFilial:SH6% AND
	%Exp:cWhereOrd% AND   
	SH6.H6_RECURSO >= %Exp:mv_par03% AND
	SH6.H6_RECURSO <= %Exp:mv_par04% AND
	SH6.H6_DTAPONT >= %Exp:mv_par05% AND
	SH6.H6_DTAPONT <= %Exp:mv_par06% AND
	SH6.H6_OPERADO >= %Exp:mv_par07% AND
	SH6.H6_OPERADO <= %Exp:mv_par08% AND
	//SH6.H6_OPERAC = %Exp:noperac% AND  
	SH6.R_E_C_N_O_ = %Exp:cRecno% AND  
	SH6.H6_TIPO In ('P',' ' ) AND
	
	SH6.%NotDel%
	
	
	//ORDER BY H6_IDENT DESC 

EndSql 

	IF !EMPTY((cAliasUlt)->H6_QTDPROD )
		nqtrprod := (cAliasUlt)->H6_QTDPROD
	ENDIF 

(cAliasUlt)->(DbCloseArea())


return nqtrprod


