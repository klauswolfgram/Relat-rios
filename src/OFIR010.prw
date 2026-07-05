/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "OFIR010.CH"
#Include "PROTHEUS.Ch"
#INCLUDE "REPORT.CH"

/*/{Protheus.doc} OFIR010 "Relatório de Requisições e Devoluções de peças"

	Pontos de entrada:
		N/A
	Parametros:
		N/A

	@author Renato Vinicius
	@since  04/10/2018
/*/

User Function OFIR010()

Local oReport

	//-- Interface de impressao
	oReport := OR0100015_ReportDef()
	oReport:PrintDialog()

Return

/*/{Protheus.doc} OR0100015_ReportDef
Motagem da interface de impressao
@author Renato Vinicius
@since 04/10/2018
@version 1.0
@return objeto
@param
@type function
/*/

Static Function OR0100015_ReportDef()

Local cAliasQry := GetNextAlias()

Local oReport	:= Nil
Local oSection1	:= Nil
Local oSection2	:= Nil

Private cPerg	:= "OFIR010"

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

OR0100035_ValidPerg(cPerg)

Pergunte(cPerg,.f.)

oReport := TReport():New("OFIR010",;
	STR0001,; //"Relatório de requisições e devoluções de oficina"
	cPerg,;
	{|oReport| OR0100025_ReportPrint(oReport,cAliasQry)},;
	STR0002) //"Este relatório irá imprimir as requisições e devoluções de oficina"
	
oReport:nFontBody := 7
oReport:SetPortrait() // Define orientação de página do relatório como retrato.
oReport:SetTotalInLine(.F.) //Define se os totalizadores serão impressos em linha ou coluna.


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
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New(oReport,STR0003,{"VO1","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	//"Ordem de Serviço"
oReport:Section(1):SetLineStyle() //Define se imprime as células da seção em linhas.
oReport:Section(1):SetCols(3) //Define a quantidade de colunas a serem impressas.

TRCell():New(oSection1,"VO1_NUMOSV"	,"VO1"	,RetTitle("VO1_NUMOSV")	,PesqPict("VO1","VO1_NUMOSV")	,TamSx3("VO1_NUMOSV")[1],/*lPixel*/,{|| (cAliasQry)->VO1_NUMOSV },,,,.t.)
TRCell():New(oSection1,"VO1_CHASSI"	,"VO1"	,RetTitle("VO1_CHASSI")	,PesqPict("VO1","VO1_CHASSI")	,TamSx3("VO1_CHASSI")[1],/*lPixel*/,{|| (cAliasQry)->VO1_CHASSI },,,,.t.)
TRCell():New(oSection1,"cCLILOJ"	,		,STR0004				,PesqPict("VO1","VO1_PROVEI")+PesqPict("VO1","VO1_LOJPRO"),(TamSx3("VO1_PROVEI")[1]+TamSx3("VO1_LOJPRO")[1])+1,/*lPixel*/,{|| (cAliasQry)->VO1_PROVEI+"/"+(cAliasQry)->VO1_LOJPRO},,,,) //"Cliente / Loja"
TRCell():New(oSection1,"A1_NOME"	,"SA1"	,RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")[1]	,/*lPixel*/,{|| SA1->A1_NOME  },,,,)

oSection2 := TRSection():New(oSection1,STR0005,{"VO2","VO3"}) //"Movimentações"
oSection2:SetLeftMargin(3)

TRCell():New(oSection2,"VO2_NOSNUM"	,"VO2"	,RetTitle("VO2_NOSNUM")	,PesqPict("VO2","VO2_NOSNUM")	,TamSx3("VO2_NOSNUM")[1]	,/*lPixel*/,{|| (cAliasQry)->VO2_NOSNUM },,,,)  //Sequencial
TRCell():New(oSection2,"VO2_DATREQ"	,"VO2"	,RetTitle("VO2_DATREQ")	,PesqPict("VO2","VO2_DATREQ")	,TamSx3("VO2_DATREQ")[1]	,/*lPixel*/,{|| (cAliasQry)->VO2_DATREQ },,,,)  //Grupo do Item
TRCell():New(oSection2,"cTipMov"	,""		,STR0015				,"@!"							,3							,/*lPixel*/,{|| cTipMov := OR0100055_TipoMov((cAliasQry)->VO2_DEVOLU) },,,,) // Código do Item
TRCell():New(oSection2,"VO3_TIPTEM"	,"VO3"	,RetTitle("VO3_TIPTEM")	,PesqPict("VO3","VO3_TIPTEM")	,TamSx3("VO3_TIPTEM")[1]	,/*lPixel*/,{|| (cAliasQry)->VO3_TIPTEM },,,,) 		    // "SubLote"
TRCell():New(oSection2,"VO3_GRUITE"	,"VO3"	,RetTitle("VO3_GRUITE")	,PesqPict("VO3","VO3_GRUITE")	,TamSx3("VO3_GRUITE")[1]	,/*lPixel*/,{|| (cAliasQry)->VO3_GRUITE },,,,)  //Descrição do Item
TRCell():New(oSection2,"VO3_CODITE"	,"VO3"	,RetTitle("VO3_CODITE")	,PesqPict("VO3","VO3_CODITE")	,TamSx3("VO3_CODITE")[1]	,/*lPixel*/,{|| (cAliasQry)->VO3_CODITE },,,,)  // "Localização"
TRCell():New(oSection2,"B1_DESC"	,"SB1"	,RetTitle("B1_DESC")	,PesqPict("SB1","B1_DESC")		,20							,/*lPixel*/,{|| SB1->B1_DESC  },,,,)  //Descrição do Item
TRCell():New(oSection2,"VO3_QTDREQ"	,"VO3"	,RetTitle("VO3_QTDREQ")	,PesqPict("VO3","VO3_QTDREQ")	,TamSx3("VO3_QTDREQ")[1]	,/*lPixel*/,{|| (cAliasQry)->VO3_QTDREQ },,,,) 		    // "SubLote"
TRCell():New(oSection2,"VO2_FUNREQ"	,"VO3"	,RetTitle("VO2_FUNREQ")	,PesqPict("VO3","VO2_FUNREQ")	,TamSx3("VO2_FUNREQ")[1]	,/*lPixel*/,{|| (cAliasQry)->VO2_FUNREQ },,,"RIGHT",) 		    // "Quantidade"
TRCell():New(oSection2,"VAI_NOMTEC"	,"VAI"	,RetTitle("VAI_NOMTEC")	,PesqPict("VAI","VAI_NOMTEC")	,20							,/*lPixel*/,{|| VAI->VAI_NOMTEC  },,,,)


Return(oReport)

/*/{Protheus.doc} OR0100025_ReportPrint
Levantamento dos dados que irão compor o relatório
@author Renato Vinicius
@since 04/10/2018
@version 1.0
@return nulo
@param oReport, objeto, Objeto TReport
@param cAliasQry, caracter, Variavel que contem a query
@type function
/*/

Static Function OR0100025_ReportPrint(oReport,cAliasQry)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cMVPAR02 :=""
If !Empty(mv_par02)
	cMVPAR02 := "VO1.VO1_NUMOSV BETWEEN '" + mv_par02 + "' AND '" + mv_par03 + "' AND "
EndIf

cMVPAR01 :=""
If !Empty(mv_par01)
	cMVPAR01 := "VO3.VO3_TIPTEM = '" + mv_par01 + "' AND "
EndIf

cMVPAR06 :=""
If !Empty(mv_par06)
	cMVPAR06 := "VO3.VO3_CODITE BETWEEN '" + mv_par06 + "' AND '" + mv_par07 + "' AND "
EndIf

cMVPAR09 :=""
If !Empty(mv_par09)
	cMVPAR09 := "VO2.VO2_FUNREQ = '" + mv_par09 + "' AND "
EndIf

cMVPAR08 :=""
If mv_par08 == 2
	cMVPAR08 := "VO2.VO2_DEVOLU = '1' AND "
ElseIf mv_par08 == 3
	cMVPAR08 := "VO2.VO2_DEVOLU = '0' AND "
EndIf

cWhere := "%"+cMVPAR02+cMVPAR01+cMVPAR06+cMVPAR09+cMVPAR08+"%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1:BeginQuery()

BeginSql Alias cAliasQry
	SELECT VO1_NUMOSV, VO1_PROVEI, VO1_LOJPRO, VO1_CHASSI, VO2_NOSNUM, VO2_DATREQ, VO2_DEVOLU,
			VO3_GRUITE, VO3_CODITE, VO3_QTDREQ, VO2_FUNREQ, VO3_TIPTEM
	FROM %Table:VO2% VO2
		INNER JOIN
			%Table:VO1% VO1
		ON 
			VO1.VO1_FILIAL = %xfilial:VO1% AND VO2.VO2_NUMOSV = VO1.VO1_NUMOSV AND 
			VO1.%NotDel%
		INNER JOIN
			%Table:VO3% VO3
		ON 
			VO3.VO3_FILIAL = %xfilial:VO3% AND VO2.VO2_NUMOSV = VO3.VO3_NUMOSV AND 
			VO2.VO2_NOSNUM = VO3.VO3_NOSNUM AND 
			VO3.%NotDel%
	WHERE VO2_FILIAL = %xFilial:VO2% AND 
		VO2_DATREQ BETWEEN %Exp:mv_par04% AND %Exp:mv_par05% AND
		VO2.VO2_TIPREQ = 'P' AND
		%Exp:cWhere%
		VO2.%NotDel%
	ORDER BY VO1_NUMOSV,VO3_GRUITE,VO3_CODITE,VO2_NOSNUM,VO2_DATREQ
EndSql 

oSection1:EndQuery(/*Array com os parametros do tipo Range*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasQry)->VO1_PROVEI+(cAliasQry)->VO1_LOJPRO})
TRPosition():New(oReport:Section(1):Section(1),"VAI",1,{|| xFilial("VAI")+(cAliasQry)->VO2_FUNREQ})
TRPosition():New(oReport:Section(1):Section(1),"SB1",7,{|| xFilial("SB1")+(cAliasQry)->VO3_GRUITE+(cAliasQry)->VO3_CODITE})

oSection2:SetParentQuery() // Define que a seção filha utiliza a query da seção pai na impressão da seção.

oBreak := TRBreak():New( oSection2, {|| (cAliasQry)->VO1_NUMOSV }, STR0003 )	// Quebra por ordem de serviço
oBreak:OnPrintTotal({|| IIf(!(cAliasQry)->(EOF()),OR0100045_ExecPosBreak(oReport,oSection1,oSection2),"")})

oSection1:Print()

Return

/*/{Protheus.doc} OR0100035_ValidPerg
Criação dos parametros que irão compor o relatório
@author Renato Vinicius
@since 04/10/2018
@version 1.0
@return nulo
@param cPerg, caracter, Nome do grupo de pergunta do relatório
@type function
/*/

Static Function OR0100035_ValidPerg(cPerg)

Local aRegs := {}

AADD(aRegs,{STR0006, STR0006, STR0006, "mv_ch1", "C", TamSx3("VOI_TIPTEM")[1]	, 0, 0, "G", '' , "mv_par01", ""		, "" , "" , "" , "" , "" 			, "" , "" , "" , "" , "" 			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VOI" , "" , "" , "" , {"Informe o tipo de tempo"},{},{}}) //"Tipo Tempo"
AADD(aRegs,{STR0007, STR0007, STR0007, "mv_ch2", "C", TamSx3("VO1_NUMOSV")[1]	, 0, 0, "G", '' , "mv_par02", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VO1" , "" , "" , "" , {"Informe o número da ordem de serviço"},{},{}}) //"OS Inicial"
AADD(aRegs,{STR0008, STR0008, STR0008, "mv_ch3", "C", TamSx3("VO1_NUMOSV")[1]	, 0, 0, "G", '' , "mv_par03", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VO1" , "" , "" , "" , {"Informe o número da ordem de serviço"},{},{}}) //"OS Final"
aAdd(aRegs,{STR0009, STR0009, STR0009, "mv_ch4", "D", 8							, 0, 0, "G", '' , "mv_par04", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" , "" , "" , {"Informe a data inicial"},{},{}}) //"Data Inicial"
aAdd(aRegs,{STR0010, STR0010, STR0010, "mv_ch5", "D", 8							, 0, 0, "G", '' , "mv_par05", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" , "" , "" , {"Informe a data final"},{},{}}) //"Data Final"
AADD(aRegs,{STR0011, STR0011, STR0011, "mv_ch6", "C", TamSx3("B1_COD")[1]		, 0, 0, "G", '' , "mv_par06", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SB1" , "" , "" , "" , {"Informe o código do item"},{},{}}) //"Item Inicial"
AADD(aRegs,{STR0012, STR0012, STR0012, "mv_ch7", "C", TamSx3("B1_COD")[1]		, 0, 0, "G", '' , "mv_par07", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SB1" , "" , "" , "" , {"Informe o código do item"},{},{}}) //"Item Final"
aAdd(aRegs,{STR0013, STR0013, STR0013, "mv_ch8", "C", 1							, 0, 0, "C", '' , "mv_par08", "Ambos"	, "" , "" , "" , "" , "Requisição"	, "" , "" , "" , "" , "Devolução"	, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""    , "" , "" , "" , {"Informe o tipo de solicitação"},{},{}}) //"Tipo"
AADD(aRegs,{STR0014, STR0014, STR0014, "mv_ch9", "C", TamSx3("VO3_PROREQ")[1]	, 0, 0, "G", '' , "mv_par09", ""		, "" , "" , "" , "" , ""			, "" , "" , "" , "" , ""			, "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "VAI" , "" , "" , "" , {"Informe o código do produtivo"},{""},{}}) //"Produtivo"

FMX_AJSX1(cPerg,aRegs)

Return

/*/{Protheus.doc} OR0100045_ExecPosBreak
Execução dos comandos após quebra de seção
@author Renato Vinicius
@since 04/10/2018
@version 1.0
@return nulo
@param cPerg, caracter, Nome do grupo de pergunta do relatório
@type function
/*/

Static Function OR0100045_ExecPosBreak(oReport,oSection1,oSection2)
	oReport:SkipLine()
	oSection1:PrintLine()
	oSection2:PrintHeader()
Return

/*/{Protheus.doc} OR0100055_TipoMov
Tranformação de conteudo VO2_DEVOLU para impressão
@author Renato Vinicius
@since 04/10/2018
@version 1.0
@return nulo
@param cPerg, caracter, Nome do grupo de pergunta do relatório
@type function
/*/

Static Function OR0100055_TipoMov(cDevolu)

Local cRetorno := ""

	If cDevolu == "1"
		cRetorno := "Req"
	ElseIf cDevolu == "0"
		cRetorno := "Dev"
	EndIf

Return cRetorno