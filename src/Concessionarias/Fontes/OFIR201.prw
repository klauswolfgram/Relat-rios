/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE 'TOPCONN.CH'
#INCLUDE "OFIR200.CH" // mesmo CH do OFIR200

/*/{Protheus.doc} U_OFIR201()
Impressão DEF Consolidado (todas Filiais agrupadas) por Campo - VCV - Histórico DEF Analitico

@author Andre Luis Almeida
@since 12/08/2022
@version 1.0
@return NIL
/*/
User Function OFIR201( cCodDEF , dDatDEF )
Local oReport
Default cCodDEF := "" 
Default dDatDEF := ctod("")
oReport := ReportDef( cCodDEF , dDatDEF ) // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
oReport:PrintDialog()  // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Função para criar as celulas que serão impressas

@author Andre Luis Almeida
@since 12/08/2022
@type function
/*/
Static Function ReportDef( cCodDEF , dDatDEF )

oReport := TReport():New("OFIR201",;	// Nome do Relatório
	STR0002,;							// Consolidado por Campo DEF
	IIf(!Empty(cCodDEF),"","OFIR201"),;							// Nome da Pergunta
	{|oReport| ReportPrint( oReport , cCodDEF , dDatDEF )},;	// Bloco de código que será executado na confirmação
	STR0002 )							// Consolidado por Campo DEF

oReport:SetTotalInLine(.f.) //Define se os totalizadores serão impressos em linha ou coluna.

oSection1 := TRSection():New(oReport,"",{"VD7","VCU"},,) // Campo DEF / Centro de Custo, Conta e Item Contabil
oReport:Section(1):SetLineStyle() // Define se imprime as células da seção em linhas
oSection1:SetLinesBefore(1)       // Define a quantidade de linhas que serão saltadas antes da impressão da seção
TRCell():New(oSection1, "VCU_CODDEF" , "VCU" , RetTitle("VCU_CODDEF") , GetSX3Cache("VCU_CODDEF","X3_PICTURE") , 25 ) // Codigo DEF
if VD7->(FieldPos("VD7_MOEDAC")) > 0
	TRCell():New(oSection1, "VD7_MOEDAC" , "VD7" , RetTitle("VD7_MOEDAC") , GetSX3Cache("VD7_MOEDAC","X3_PICTURE") , 10 ,,,"LEFT") // Moeda Contabil
endif

oSection2 := TRSection():New(oReport,STR0003+", "+STR0004,{""},,) // Campo DEF / Centro de Custo, Conta e Item Contabil
oSection2:SetAutoSize(.t.) // Impressão do SQL agrupado
TRCell():New(oSection2, "VCV_CPODEF" , "" , RetTitle("VCV_CPODEF") , , 25 ,, {|| (cQAlVCV)->( VCV_CPODEF ) } ) // Campo DEF
TRCell():New(oSection2, "VCV_DATA"   , "" , RetTitle("VCV_DATA")   , , 25 ,, {|| Transform(stod((cQAlVCV)->( VCV_DATA )),"@D") } ) // Data
TRCell():New(oSection2, "VCV_CCTCTB" , "" , RetTitle("VCV_CCTCTB") , , 25 ,, {|| (cQAlVCV)->( VCV_CCTCTB ) } ) // Conta Contabil
TRCell():New(oSection2, "VCV_CCUSTO" , "" , RetTitle("VCV_CCUSTO") , , 25 ,, {|| (cQAlVCV)->( VCV_CCUSTO ) } ) // Centro de Custo
TRCell():New(oSection2, "VCV_ITEMCT" , "" , RetTitle("VCV_ITEMCT") , , 25 ,, {|| (cQAlVCV)->( VCV_ITEMCT ) } ) // Item Conta
if VCV->(FieldPos("VCV_CLVL")) > 0
	TRCell():New(oSection2, "VCV_CLVL" , "" , RetTitle("VCV_CLVL") , GetSX3Cache("VCV_CLVL","X3_PICTURE") , 25 ,, {|| (cQAlVCV)->( VCV_CLVL ) } ) // Item Conta
endif
TRCell():New(oSection2, "VCV_VALOR"  , "" , RetTitle("VCV_VALOR")  , GetSX3Cache("VCV_VALOR","X3_PICTURE") , 25 ,, {|| (cQAlVCV)->( VCV_VALOR ) } ) // Valor

Return oReport

/*/{Protheus.doc} ReportPrint
Função para adicionar as informações que serão impressas

@author Andre Luis Almeida
@since 12/08/2022
@type function
/*/
Static Function ReportPrint( oReport , cCodDEF , dDatDEF )
Local oSection1
Local oSection2
Local cQuery    := ""
//Local cFilVCU   := ""
local lVCVCLVL := VCV->(FieldPos("VCV_CLVL")) > 0
//Local aFilCont  := {}
//Local nCntFor   := 0
Private cQAlVCU := "SQLVCU"
Private cQAlVCV := "SQLVCV"
Private cFilImp := ""
If Empty(cCodDEF) // Caso não recebeu por parametro, utilizar a Pergunte dos parametros
	Pergunte("OFIR201",.f.)
	cCodDEF := MV_PAR01
	dDatDEF := MV_PAR02
EndIf

// Impressao do VCU
oSection1 := oReport:Section(1)
oSection1:Init()
cQuery := "SELECT R_E_C_N_O_ AS RECVCU "
cQuery += "  FROM "+RetSQLName("VCU")
cQuery += " WHERE VCU_FILIAL IN (SELECT DISTINCT VCU_FILIAL FROM "+ RetSQLName("VCU") + " WHERE D_E_L_E_T_ = ' ') "
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
cQuery := "SELECT VCV_CODDEF , VCV_CPODEF , VCV_DATA , VCV_CCUSTO , VCV_CCTCTB , VCV_ITEMCT "
if lVCVCLVL
	cQuery += " , VCV_CLVL "
endif
cQuery += ", SUM(VCV_VALOR) AS VCV_VALOR "
cQuery += "  FROM "+RetSQLName("VCV")
cQuery += " WHERE VCV_FILIAL IN (SELECT DISTINCT VCV_FILIAL FROM "+ RetSQLName("VCV") + " WHERE D_E_L_E_T_ = ' ') "
cQuery += "   AND VCV_CODDEF = '" + cCodDEF + "'"
cQuery += "   AND VCV_DATA   = '" + dtos(dDatDEF) + "'"
cQuery += "   AND D_E_L_E_T_ = ' '"
cQuery += " GROUP BY VCV_CODDEF , VCV_CPODEF , VCV_DATA , VCV_CCUSTO , VCV_CCTCTB , VCV_ITEMCT"
if lVCVCLVL
	cQuery += " , VCV_CLVL "
endif
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVCV, .F., .T. )
While !(cQAlVCV)->(Eof()) .and. !oReport:Cancel()
	oSection2:PrintLine() // Imprimir Itens
	(cQAlVCV)->(dbSkip())
EndDo
(cQAlVCV)->(dbCloseArea())
oSection2:Finish()

DbSelectArea("VCU")
Return