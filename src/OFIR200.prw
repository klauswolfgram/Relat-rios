/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE 'TOPCONN.CH'
#INCLUDE "OFIR200.CH"

/*/{Protheus.doc} U_OFIR200()
Impressão DEF Detalhado (especifico) por Campo - VCV - Histórico DEF Analitico

@author Andre Luis Almeida
@since 12/08/2022
@version 1.0
@return NIL
/*/
User Function OFIR200( cFilDEF , cCodDEF , dDatDEF )
Local oReport
Default cFilDEF := ""
Default cCodDEF := "" 
Default dDatDEF := ctod("")
oReport := ReportDef( cFilDEF , cCodDEF , dDatDEF ) // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
oReport:PrintDialog() // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Função para criar as celulas que serão impressas

@author Andre Luis Almeida
@since 12/08/2022
@type function
/*/
Static Function ReportDef( cFilDEF , cCodDEF , dDatDEF )

oReport := TReport():New("OFIR200",;	// Nome do Relatório
	STR0001,;							// Detalhado por Campo DEF
	IIf(!Empty(cCodDEF),"","OFIR200"),;							// Nome da Pergunta
	{|oReport| ReportPrint( oReport , cFilDEF , cCodDEF , dDatDEF )},;	// Bloco de código que será executado na confirmação
	STR0001 )							// Detalhado por Campo DEF

oReport:SetTotalInLine(.f.) //Define se os totalizadores serão impressos em linha ou coluna.

oSection1 := TRSection():New(oReport,"",{"VD7","VCU"},,) // Campo DEF / Centro de Custo, Conta e Item Contabil
oReport:Section(1):SetLineStyle() // Define se imprime as células da seção em linhas
oSection1:SetLinesBefore(1)       // Define a quantidade de linhas que serão saltadas antes da impressão da seção
TRCell():New(oSection1, "VCU_CODDEF" , "VCU" , RetTitle("VCU_CODDEF") , GetSX3Cache("VCU_CODDEF","X3_PICTURE") , 25 ) // Codigo DEF
if VD7->(FieldPos("VD7_MOEDAC")) > 0
	TRCell():New(oSection1, "VD7_MOEDAC" , "VD7" , RetTitle("VD7_MOEDAC") , GetSX3Cache("VD7_MOEDAC","X3_PICTURE") , 10 ,,,"LEFT") // Moeda Contabil
endif


oSection2 := TRSection():New(oReport,STR0003+", "+STR0004,{"VCV"},,) // Campo DEF / Centro de Custo, Conta e Item Contabil
oSection2:SetAutoSize(.t.)
//TRCell():New(oSection2, "VCV_CODDEF" , "VCV" , RetTitle("VCV_CODDEF") , GetSX3Cache("VCV_CODDEF","X3_PICTURE") , 25 ) // Codigo DEF
TRCell():New(oSection2, "VCV_CPODEF" , "VCV" , RetTitle("VCV_CPODEF") , GetSX3Cache("VCV_CPODEF","X3_PICTURE") , 25 ) // Campo DEF
TRCell():New(oSection2, "VCV_DATA"   , "VCV" , RetTitle("VCV_DATA")   , GetSX3Cache("VCV_DATA","X3_PICTURE")   , 25 ) // Data
TRCell():New(oSection2, "VCV_CCTCTB" , "VCV" , RetTitle("VCV_CCTCTB") , GetSX3Cache("VCV_CCTCTB","X3_PICTURE") , 25 ) // Conta Contabil
TRCell():New(oSection2, "VCV_CCUSTO" , "VCV" , RetTitle("VCV_CCUSTO") , GetSX3Cache("VCV_CCUSTO","X3_PICTURE") , 25 ) // Centro de Custo
TRCell():New(oSection2, "VCV_ITEMCT" , "VCV" , RetTitle("VCV_ITEMCT") , GetSX3Cache("VCV_ITEMCT","X3_PICTURE") , 25 ) // Item Conta
if VCV->(FieldPos("VCV_CLVL")) > 0
	TRCell():New(oSection2, "VCV_CLVL" , "VCV" , RetTitle("VCV_CLVL") , GetSX3Cache("VCV_CLVL","X3_PICTURE") , 25 ) // Classe de Valor
endif
TRCell():New(oSection2, "VCV_VALOR"  , "VCV" , RetTitle("VCV_VALOR")  , GetSX3Cache("VCV_VALOR","X3_PICTURE")  , 25 ) // Valor

Return oReport

/*/{Protheus.doc} ReportPrint
Função para adicionar as informações que serão impressas

@author Andre Luis Almeida
@since 12/08/2022
@type function
/*/
Static Function ReportPrint( oReport , cFilDEF , cCodDEF , dDatDEF )
Local oSection1
Local cQuery    := ""
Local cQAlVCU   := "SQLVCU"
Local cQAlVCV   := "SQLVCV"
If Empty(cCodDEF) // Caso não recebeu por parametro, utilizar a Pergunte dos parametros
	Pergunte("OFIR200",.f.)
	cFilDEF := xFilial("VCV")
	cCodDEF := MV_PAR01
	dDatDEF := MV_PAR02
EndIf
// Impressao do VCU
oSection1 := oReport:Section(1)
oSection1:Init()
cQuery := "SELECT R_E_C_N_O_ AS RECVCU "
cQuery += "  FROM "+RetSQLName("VCU")
cQuery += " WHERE VCU_FILIAL = '" + cFilDEF + "'"
cQuery += "   AND VCU_CODDEF = '" + cCodDEF + "'"
cQuery += "   AND VCU_DATA   = '" + dtos(dDatDEF) + "'"
cQuery += "   AND D_E_L_E_T_ = ' '"
cQuery += " ORDER BY VCU_CODDEF, VCU_CPODEF"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVCU, .F., .T. )
if ! (cQAlVCU)->(Eof()) .and. !oReport:Cancel()
	VCU->(DbGoTo((cQAlVCU)->( RECVCU )))

	VD7->(dbSetOrder(1))
	VD7->(dbSeek(FWxFilial("VD7") + VCU->VCU_CODDEF))

	oSection1:PrintLine() // Imprimir Linhas
	(cQAlVCU)->(dbSkip())
endif
(cQAlVCU)->(dbCloseArea())
oSection1:Finish()

// Impressão do VCV - Histórico DEF Analitico 
oSection2 := oReport:Section(2) // VCV - VCV_CODDEF , VCV_CPODEF , VCV_DATA , VCV_CCUSTO , VCV_CCTCTB , VCV_ITEMCT
oSection2:Init()
cQuery := "SELECT R_E_C_N_O_ AS RECVCV "
cQuery += "  FROM "+RetSQLName("VCV")
cQuery += " WHERE VCV_FILIAL = '" + cFilDEF + "'"
cQuery += "   AND VCV_CODDEF = '" + cCodDEF + "'"
cQuery += "   AND VCV_DATA   = '" + dtos(dDatDEF) + "'"
cQuery += "   AND D_E_L_E_T_ = ' '"
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVCV, .F., .T. )
While !(cQAlVCV)->(Eof()) .and. !oReport:Cancel()
	VCV->(DbGoTo((cQAlVCV)->( RECVCV )))
	oSection2:PrintLine() // Imprimir Linhas
	(cQAlVCV)->(dbSkip())
EndDo
(cQAlVCV)->(dbCloseArea())
oSection2:Finish()
DbSelectArea("VCU")
Return