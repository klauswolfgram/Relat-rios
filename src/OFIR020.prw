/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "PROTHEUS.CH"
#Include "FWCOMMAND.CH"
#INCLUDE "OFIR020.CH"

/*/{Protheus.doc} OFIR020
Impressao das Divergencias das Conferencias

@author Andre Luis Almeida
@since 19/11/2019
@type function

/*/
User Function OFIR020()
Local oReport
Pergunte("OFR020",.f.)
oReport := ReportDef() // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
oReport:PrintDialog()  // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Função para criar as celulas que serão impressas

@author Andre Luis Almeida
@since 19/11/2019
@type function

/*/
Static Function ReportDef()

Local cTit_Imp := STR0001 // Impressão das Divergencias na Conferencia de Peças
Private cAuxImpr := ""

oReport := TReport():New("OFIR020",;	// Nome do Relatório
	cTit_Imp,;							// 
	"OFR020",;							// Nome da Pergunta
	{|oReport| ReportPrint(oReport)},;	// Bloco de código que será executado na confirmação
	cTit_Imp )							// 
	
oReport:SetTotalInLine(.f.) //Define se os totalizadores serão impressos em linha ou coluna.

// NF ENTRADA DE PECAS //
oSection1 := TRSection():New(oReport,STR0002,{"VM0","VM2","SA2","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// NF Entrada de Peças
oSection1:SetAutoSize(.t.)
	TRCell():New(oSection1, "FILIAL" , "", RetTitle("VM0_FILIAL") , "@!"     , 30,, {|| VM0->VM0_FILIAL } ,,, "LEFT" , .t.) // Filial
	TRCell():New(oSection1, "DOC"    , "", RetTitle("VM0_DOC")    , "@!"     , 30,, {|| VM0->VM0_DOC    } ,,, "LEFT" , .t.) // Doc NF
	TRCell():New(oSection1, "SERIE"  , "", RetTitle("VM0_SERIE")  , "@!"     , 15,, {|| VM0->VM0_SERIE  } ,,, "LEFT" , .t.) // Serie
	TRCell():New(oSection1, "FORNEC" , "", RetTitle("VM0_FORNEC") , "@!"     , 30,, {|| VM0->VM0_FORNEC } ,,, "LEFT" , .t.) // Fornecedor
	TRCell():New(oSection1, "LOJA"   , "", RetTitle("VM0_LOJA")   , "@!"     , 15,, {|| VM0->VM0_LOJA   } ,,, "LEFT" , .t.) // Loja
	TRCell():New(oSection1, "NOME"   , "", RetTitle("A2_NOME")    , "@!"     , 50,, {|| SA2->A2_NOME    } ,,, "LEFT" , .t.) // Nome
	TRCell():New(oSection1, "STATUS" , "", RetTitle("VM2_STATUS") , "@!"     , 20,, {|| STR0011         } ,,, "LEFT" , .t.) // Status: Aprovado
	TRCell():New(oSection1, "CODAPR" , "", RetTitle("VM2_USRSTA") , "@!"     , 20,, {|| VM2->VM2_USRSTA } ,,, "LEFT" , .t.) // Codigo do Usuario Aprovador
	TRCell():New(oSection1, "NOMEAPR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario Aprovador
	TRCell():New(oSection1, "DATAAPR", "", RetTitle("VM2_DATSTA") , "@D"     , 20,, {|| VM2->VM2_DATSTA } ,,, "LEFT" , .t.) // Data Aprovacao
	TRCell():New(oSection1, "HORAAPR", "", RetTitle("VM2_HORSTA") , "@!"     , 20,, {|| left(VM2->VM2_HORSTA,5) } ,,, "LEFT" , .t.) // Hora Aprovacao
oSection2 := TRSection():New(oReport,STR0003,{"SB1","VM1","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Itens relacionados a NF Entrada
oSection2:SetAutoSize(.t.)
	TRCell():New(oSection2, "GRUPO"  , "", RetTitle("B1_GRUPO")   , "@!"     , 20,, {|| SB1->B1_GRUPO   } ,,, "LEFT" , .t.) // Grupo
	TRCell():New(oSection2, "CODITE" , "", RetTitle("B1_CODITE")  , "@!"     , 30,, {|| SB1->B1_CODITE  } ,,, "LEFT" , .t.) // Codigo Item
	TRCell():New(oSection2, "DESC"   , "", RetTitle("B1_DESC")    , "@!"     , 40,, {|| SB1->B1_DESC    } ,,, "LEFT" , .t.) // Descricao
	TRCell():New(oSection2, "CUSTO"  , "", RetTitle("VM1_CUSPRO") , GetSX3Cache("VM1_CUSPRO","X3_PICTURE"), 30,, {|| VM1->VM1_CUSPRO } ,,, "RIGHT", .t.) // Custo
	TRCell():New(oSection2, "QTORIG" , "", RetTitle("VM1_QTORIG") , GetSX3Cache("VM1_QTORIG","X3_PICTURE"), 20,, {|| VM1->VM1_QTORIG } ,,, "RIGHT", .t.) // Qtde.Original
	TRCell():New(oSection2, "QTCONF" , "", RetTitle("VM1_QTCONF") , GetSX3Cache("VM1_QTCONF","X3_PICTURE"), 20,, {|| VM1->VM1_QTCONF } ,,, "RIGHT", .t.) // Qtde.Conferida
	TRCell():New(oSection2, "QTDIVE" , "", RetTitle("VM1_QTDIVE") , GetSX3Cache("VM1_QTDIVE","X3_PICTURE"), 20,, {|| VM1->VM1_QTCONF-VM1->VM1_QTORIG } ,,, "RIGHT", .t.) // Qtde.Divergencia
	TRCell():New(oSection2, "CODUSR" , "", RetTitle("VM1_USRCON") , "@!"     , 20,, {|| VM1->VM1_USRCON } ,,, "LEFT" , .t.) // Codigo do Usuario
	TRCell():New(oSection2, "NOMEUSR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario
	TRCell():New(oSection2, "CODMOV" , "", RetTitle("VM1_DOCSDB") , "@!"     , 20,, {|| VM1->VM1_DOCSDB } ,,, "LEFT" , .t.) // Codigo da Movimentacao

// PECAS OFICINA //
oSection3 := TRSection():New(oReport,STR0004,{"VM3","VM2","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Peças Oficina
oSection3:SetAutoSize(.t.)
	TRCell():New(oSection3, "FILIAL" , "", RetTitle("VM3_FILIAL") , "@!"     , 30,, {|| VM3->VM3_FILIAL } ,,, "LEFT" , .t.) // Filial
	TRCell():New(oSection3, "NUMOSV" , "", RetTitle("VM3_NUMOSV") , "@!"     , 30,, {|| VM3->VM3_NUMOSV } ,,, "LEFT" , .t.) // Nro.OS
	TRCell():New(oSection3, "STATUS" , "", RetTitle("VM2_STATUS") , "@!"     , 20,, {|| STR0011         } ,,, "LEFT" , .t.) // Status: Aprovado
	TRCell():New(oSection3, "CODAPR" , "", RetTitle("VM2_USRSTA") , "@!"     , 20,, {|| VM2->VM2_USRSTA } ,,, "LEFT" , .t.) // Codigo do Usuario Aprovador
	TRCell():New(oSection3, "NOMEAPR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario Aprovador
	TRCell():New(oSection3, "DATAAPR", "", RetTitle("VM2_DATSTA") , "@D"     , 20,, {|| VM2->VM2_DATSTA } ,,, "LEFT" , .t.) // Data Aprovacao
	TRCell():New(oSection3, "HORAAPR", "", RetTitle("VM2_HORSTA") , "@!"     , 20,, {|| left(VM2->VM2_HORSTA,5) } ,,, "LEFT" , .t.) // Hora Aprovacao
oSection4 := TRSection():New(oReport,STR0005,{"SB1","VM4","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Itens relacionados a Oficina
oSection4:SetAutoSize(.t.)
	TRCell():New(oSection4, "GRUPO"  , "", RetTitle("B1_GRUPO")   , "@!"     , 20,, {|| SB1->B1_GRUPO   } ,,, "LEFT" , .t.) // Grupo
	TRCell():New(oSection4, "CODITE" , "", RetTitle("B1_CODITE")  , "@!"     , 30,, {|| SB1->B1_CODITE  } ,,, "LEFT" , .t.) // Codigo Item
	TRCell():New(oSection4, "DESC"   , "", RetTitle("B1_DESC")    , "@!"     , 40,, {|| SB1->B1_DESC    } ,,, "LEFT" , .t.) // Descricao
	TRCell():New(oSection4, "QTSOLI" , "", RetTitle("VM4_QTSOLI") , GetSX3Cache("VM4_QTSOLI","X3_PICTURE"), 20,, {|| VM4->VM4_QTSOLI } ,,, "RIGHT", .t.) // Qtde.Solicitada
	TRCell():New(oSection4, "QTCONF" , "", RetTitle("VM4_QTCONF") , GetSX3Cache("VM4_QTCONF","X3_PICTURE"), 20,, {|| VM4->VM4_QTCONF } ,,, "RIGHT", .t.) // Qtde.Conferida
	TRCell():New(oSection4, "QTDIVE" , "", RetTitle("VM4_QTDIVE") , GetSX3Cache("VM4_QTDIVE","X3_PICTURE"), 20,, {|| VM4->VM4_QTCONF-VM4->VM4_QTSOLI } ,,, "RIGHT", .t.) // Qtde.Divergencia
	TRCell():New(oSection4, "CODUSR" , "", RetTitle("VM4_USRCON") , "@!"     , 20,, {|| VM4->VM4_USRCON } ,,, "LEFT" , .t.) // Codigo do Usuario
	TRCell():New(oSection4, "NOMEUSR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario

// PECAS ORCAMENTO //
oSection5 := TRSection():New(oReport,STR0006,{"VM5","VM2","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Peças do Orçamento
oSection5:SetAutoSize(.t.)
	TRCell():New(oSection5, "FILIAL" , "", RetTitle("VM5_FILIAL") , "@!"     , 30,, {|| VM5->VM5_FILIAL } ,,, "LEFT" , .t.) // Filial
	TRCell():New(oSection5, "NUMORC" , "", RetTitle("VM5_NUMORC") , "@!"     , 30,, {|| VM5->VM5_NUMORC } ,,, "LEFT" , .t.) // Nro.Orcamento
	TRCell():New(oSection5, "STATUS" , "", RetTitle("VM2_STATUS") , "@!"     , 20,, {|| STR0011         } ,,, "LEFT" , .t.) // Status: Aprovado
	TRCell():New(oSection5, "CODAPR" , "", RetTitle("VM2_USRSTA") , "@!"     , 20,, {|| VM2->VM2_USRSTA } ,,, "LEFT" , .t.) // Codigo do Usuario Aprovador
	TRCell():New(oSection5, "NOMEAPR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario Aprovador
	TRCell():New(oSection5, "DATAAPR", "", RetTitle("VM2_DATSTA") , "@D"     , 20,, {|| VM2->VM2_DATSTA } ,,, "LEFT" , .t.) // Data Aprovacao
	TRCell():New(oSection5, "HORAAPR", "", RetTitle("VM2_HORSTA") , "@!"     , 20,, {|| left(VM2->VM2_HORSTA,5) } ,,, "LEFT" , .t.) // Hora Aprovacao
oSection6 := TRSection():New(oReport,STR0007,{"SB1","VM6","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Itens relacionados ao Orçamento
oSection6:SetAutoSize(.t.)
	TRCell():New(oSection6, "GRUPO"  , "", RetTitle("B1_GRUPO")   , "@!"     , 20,, {|| SB1->B1_GRUPO   } ,,, "LEFT" , .t.) // Grupo
	TRCell():New(oSection6, "CODITE" , "", RetTitle("B1_CODITE")  , "@!"     , 30,, {|| SB1->B1_CODITE  } ,,, "LEFT" , .t.) // Codigo Item
	TRCell():New(oSection6, "DESC"   , "", RetTitle("B1_DESC")    , "@!"     , 40,, {|| SB1->B1_DESC    } ,,, "LEFT" , .t.) // Descricao
	TRCell():New(oSection6, "QTORIG" , "", RetTitle("VM6_QTORIG") , GetSX3Cache("VM6_QTORIG","X3_PICTURE"), 20,, {|| VM6->VM6_QTORIG } ,,, "RIGHT", .t.) // Qtde.Original
	TRCell():New(oSection6, "QTCONF" , "", RetTitle("VM6_QTCONF") , GetSX3Cache("VM6_QTCONF","X3_PICTURE"), 20,, {|| VM6->VM6_QTCONF } ,,, "RIGHT", .t.) // Qtde.Conferida
	TRCell():New(oSection6, "QTDIVE" , "", RetTitle("VM6_QTDIVE") , GetSX3Cache("VM6_QTDIVE","X3_PICTURE"), 20,, {|| VM6->VM6_QTCONF-VM6->VM6_QTORIG } ,,, "RIGHT", .t.) // Qtde.Divergencia
	TRCell():New(oSection6, "CODUSR" , "", RetTitle("VM6_USRCON") , "@!"     , 20,, {|| VM6->VM6_USRCON } ,,, "LEFT" , .t.) // Codigo do Usuario
	TRCell():New(oSection6, "NOMEUSR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario

// VOLUME ENTRADA DE PECAS //
oSection7 := TRSection():New(oReport,STR0009,{"VM7","VM2","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Volume de Entrada de Peças
oSection7:SetAutoSize(.t.)
	TRCell():New(oSection7, "FILIAL" , "", RetTitle("VM7_FILIAL") , "@!"     , 30,, {|| VM7->VM7_FILIAL } ,,, "LEFT" , .t.) // Filial
	TRCell():New(oSection7, "VOLUME" , "", RetTitle("VM7_VOLUME") , "@!"     , 30,, {|| VM7->VM7_VOLUME } ,,, "LEFT" , .t.) // Volume
	TRCell():New(oSection7, "STATUS" , "", RetTitle("VM2_STATUS") , "@!"     , 20,, {|| STR0011         } ,,, "LEFT" , .t.) // Status: Aprovado
	TRCell():New(oSection7, "CODAPR" , "", RetTitle("VM2_USRSTA") , "@!"     , 20,, {|| VM2->VM2_USRSTA } ,,, "LEFT" , .t.) // Codigo do Usuario Aprovador
	TRCell():New(oSection7, "NOMEAPR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario Aprovador
	TRCell():New(oSection7, "DATAAPR", "", RetTitle("VM2_DATSTA") , "@D"     , 20,, {|| VM2->VM2_DATSTA } ,,, "LEFT" , .t.) // Data Aprovacao
	TRCell():New(oSection7, "HORAAPR", "", RetTitle("VM2_HORSTA") , "@!"     , 20,, {|| left(VM2->VM2_HORSTA,5) } ,,, "LEFT" , .t.) // Hora Aprovacao
oSection8 := TRSection():New(oReport,STR0010,{"SB1","VM8","VAI"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// Itens relacionados ao Volume de Entrada
oSection8:SetAutoSize(.t.)
	TRCell():New(oSection8, "GRUPO"  , "", RetTitle("B1_GRUPO")   , "@!"     , 20,, {|| SB1->B1_GRUPO   } ,,, "LEFT" , .t.) // Grupo
	TRCell():New(oSection8, "CODITE" , "", RetTitle("B1_CODITE")  , "@!"     , 30,, {|| SB1->B1_CODITE  } ,,, "LEFT" , .t.) // Codigo Item
	TRCell():New(oSection8, "DESC"   , "", RetTitle("B1_DESC")    , "@!"     , 40,, {|| SB1->B1_DESC    } ,,, "LEFT" , .t.) // Descricao
	TRCell():New(oSection8, "CUSTO"  , "", RetTitle("VM8_CUSPRO") , GetSX3Cache("VM8_CUSPRO","X3_PICTURE"), 30,, {|| VM8->VM8_CUSPRO } ,,, "RIGHT", .t.) // Custo
	TRCell():New(oSection8, "QTORIG" , "", RetTitle("VM8_QTORIG") , GetSX3Cache("VM8_QTORIG","X3_PICTURE"), 20,, {|| VM8->VM8_QTORIG } ,,, "RIGHT", .t.) // Qtde.Original
	TRCell():New(oSection8, "QTCONF" , "", RetTitle("VM8_QTCONF") , GetSX3Cache("VM8_QTCONF","X3_PICTURE"), 20,, {|| VM8->VM8_QTCONF } ,,, "RIGHT", .t.) // Qtde.Conferida
	TRCell():New(oSection8, "QTDIVE" , "", RetTitle("VM8_QTDIVE") , GetSX3Cache("VM8_QTDIVE","X3_PICTURE"), 20,, {|| VM8->VM8_QTCONF-VM8->VM8_QTORIG } ,,, "RIGHT", .t.) // Qtde.Divergencia
	TRCell():New(oSection8, "CODUSR" , "", RetTitle("VM8_USRCON") , "@!"     , 20,, {|| VM8->VM8_USRCON } ,,, "LEFT" , .t.) // Codigo do Usuario
	TRCell():New(oSection8, "NOMEUSR", "", RetTitle("VAI_NOMTEC") , "@!"     , 30,, {|| VAI->VAI_NOMTEC } ,,, "LEFT" , .t.) // Nome do Usuario
	TRCell():New(oSection8, "CODMOV" , "", RetTitle("VCX_DOCSDB") , "@!"     , 60,, {|| cAuxImpr } ,,, "LEFT" , .t.) // Codigo da Movimentacao

Return oReport

/*/{Protheus.doc} ReportPrint
Função para adicionar as informações que serão impressas

@author Andre Luis Almeida
@since 19/11/2019
@type function

/*/
Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1) // NF Entrada de Pecas
Local oSection2 := oReport:Section(2) // NF Entrada de Pecas
Local oSection3 := oReport:Section(3) // Pecas Oficina
Local oSection4 := oReport:Section(4) // Pecas Oficina
Local oSection5 := oReport:Section(5) // Pecas Orcamento
Local oSection6 := oReport:Section(6) // Pecas Orcamento
Local oSection7 := oReport:Section(7) // Volume Entrada de Pecas
Local oSection8 := oReport:Section(8) // Volume Entrada de Pecas
Local cQuery    := ""
Local cQAlSQL   := "SQLPRINCIPAL"
Local cQAlAux   := "SQLAUXILIAR"
Local cQAlVCX   := "SQLVCX"

Do Case

	Case MV_PAR01 == 1 // NF de Entrada

		oReport:SetTitle( STR0008+" - "+STR0002 ) // Divergencias na Conferencia / NF Entrada de Peças

		cQuery := "SELECT VM0.R_E_C_N_O_ AS RECVM0 ,"
		cQuery += "       SA2.R_E_C_N_O_ AS RECSA2 ,"
		cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
		cQuery += "  FROM "+RetSQLName("VM2")+" VM2 "
		cQuery += "  JOIN "+RetSQLName("VM0")+" VM0 ON ( VM0.VM0_FILIAL='"+xFilial("VM0")+"' AND VM0.VM0_CODIGO=VM2.VM2_CODIGO AND VM0.VM0_DIVERG='1'AND VM0.D_E_L_E_T_ = ' ' ) "
		cQuery += "  JOIN "+RetSQLName("SA2")+" SA2 ON ( SA2.A2_FILIAL='"+xFilial("SA2")+"' AND SA2.A2_COD=VM0.VM0_FORNEC AND SA2.A2_LOJA=VM0.VM0_LOJA AND SA2.D_E_L_E_T_ = ' ' ) "
		cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM2.VM2_USRSTA AND VAI.D_E_L_E_T_ = ' ' ) "
		cQuery += " WHERE VM2.VM2_FILIAL = '"+xFilial("VM2")+"'"
		cQuery += "   AND VM2.VM2_TIPO = '1' " // Tipo: NF Entrada
		cQuery += "   AND VM2.VM2_STATUS = '4' " // Status: Aprovado
		cQuery += "   AND VM2.VM2_DATSTA >= '"+dtos(MV_PAR02)+"' AND VM2.VM2_DATSTA <= '"+dtos(MV_PAR03)+"' "
		cQuery += "   AND VM2.D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSQL, .F., .T. )
		While !(cQAlSQL)->(Eof())
			//
			VM0->(DbGoto( (cQAlSQL)->( RECVM0 ) ))
			SA2->(DbGoto( (cQAlSQL)->( RECSA2 ) ))
			VAI->(DbGoto( (cQAlSQL)->( RECVAI ) ))
			oSection1:Init()
			oSection1:PrintLine()
			oSection1:Finish()
			//
			oSection2:Init()
			cQuery := "SELECT VM1.R_E_C_N_O_ AS RECVM1 ,"
			cQuery += "       SB1.R_E_C_N_O_ AS RECSB1 ,"
			cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
			cQuery += "  FROM "+RetSQLName("VM1")+" VM1 "
			cQuery += "  JOIN "+RetSQLName("SB1")+" SB1 ON ( SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=VM1.VM1_COD AND SB1.D_E_L_E_T_ = ' ' ) "
			cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM1.VM1_USRCON AND VAI.D_E_L_E_T_ = ' ' ) "
			cQuery += " WHERE VM1.VM1_FILIAL = '"+xFilial("VM1")+"'"
			cQuery += "   AND VM1.VM1_CODVM0 = '"+VM0->VM0_CODIGO+"' "
			cQuery += "   AND VM1.VM1_QTORIG <> VM1.VM1_QTCONF"
			cQuery += "   AND VM1.D_E_L_E_T_ = ' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
			While !(cQAlAux)->(Eof())
				//
				VM1->(DbGoto( (cQAlAux)->( RECVM1 ) ))
				SB1->(DbGoto( (cQAlAux)->( RECSB1 ) ))
				VAI->(DbGoto( (cQAlAux)->( RECVAI ) ))
				oSection2:PrintLine()
				//
				(cQAlAux)->(dbSkip())
			EndDo
			(cQAlAux)->(dbCloseArea())
			oSection2:Finish()
			//
			(cQAlSQL)->(dbSkip())
		EndDo
		(cQAlSQL)->(dbCloseArea())
		DbSelectArea("VM0")

	Case MV_PAR01 == 2 // Pecas Oficina

		oReport:SetTitle( STR0008+" - "+STR0004 ) // Divergencias na Conferencia / Peças Oficina

		cQuery := "SELECT VM3.R_E_C_N_O_ AS RECVM3 ,"
		cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
		cQuery += "  FROM "+RetSQLName("VM2")+" VM2 "
		cQuery += "  JOIN "+RetSQLName("VM3")+" VM3 ON ( VM3.VM3_FILIAL='"+xFilial("VM3")+"' AND VM3.VM3_CODIGO=VM2.VM2_CODIGO AND VM3.VM3_DIVERG='1'AND VM3.D_E_L_E_T_ = ' ' ) "
		cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM2.VM2_USRSTA AND VAI.D_E_L_E_T_ = ' ' ) "
		cQuery += " WHERE VM2.VM2_FILIAL = '"+xFilial("VM2")+"'"
		cQuery += "   AND VM2.VM2_TIPO = '2' " // Tipo: Pecas Oficina
		cQuery += "   AND VM2.VM2_STATUS = '4' " // Status: Aprovado
		cQuery += "   AND VM2.VM2_DATSTA >= '"+dtos(MV_PAR02)+"' AND VM2.VM2_DATSTA <= '"+dtos(MV_PAR03)+"' "
		cQuery += "   AND VM2.D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSQL, .F., .T. )
		While !(cQAlSQL)->(Eof())
			//
			VM3->(DbGoto( (cQAlSQL)->( RECVM3 ) ))
			VAI->(DbGoto( (cQAlSQL)->( RECVAI ) ))
			oSection3:Init()
			oSection3:PrintLine()
			oSection3:Finish()
			//
			oSection4:Init()
			cQuery := "SELECT VM4.R_E_C_N_O_ AS RECVM4 ,"
			cQuery += "       SB1.R_E_C_N_O_ AS RECSB1 ,"
			cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
			cQuery += "  FROM "+RetSQLName("VM4")+" VM4 "
			cQuery += "  JOIN "+RetSQLName("SB1")+" SB1 ON ( SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=VM4.VM4_COD AND SB1.D_E_L_E_T_ = ' ' ) "
			cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM4.VM4_USRCON AND VAI.D_E_L_E_T_ = ' ' ) "
			cQuery += " WHERE VM4.VM4_FILIAL = '"+xFilial("VM4")+"'"
			cQuery += "   AND VM4.VM4_CODVM3 = '"+VM3->VM3_CODIGO+"' "
			cQuery += "   AND VM4.VM4_QTSOLI <> VM4.VM4_QTCONF"
			cQuery += "   AND VM4.D_E_L_E_T_ = ' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
			While !(cQAlAux)->(Eof())
				//
				VM4->(DbGoto( (cQAlAux)->( RECVM4 ) ))
				SB1->(DbGoto( (cQAlAux)->( RECSB1 ) ))
				VAI->(DbGoto( (cQAlAux)->( RECVAI ) ))
				oSection4:PrintLine()
				//
				(cQAlAux)->(dbSkip())
			EndDo
			(cQAlAux)->(dbCloseArea())
			oSection4:Finish()
			//
			(cQAlSQL)->(dbSkip())
		EndDo
		(cQAlSQL)->(dbCloseArea())
		DbSelectArea("VM3")

	Case MV_PAR01 == 3 // Pecas Orcamento

		oReport:SetTitle( STR0008+" - "+STR0006 ) // Divergencias na Conferencia / Peças do Orçamento

		cQuery := "SELECT VM5.R_E_C_N_O_ AS RECVM5 ,"
		cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
		cQuery += "  FROM "+RetSQLName("VM2")+" VM2 "
		cQuery += "  JOIN "+RetSQLName("VM5")+" VM5 ON ( VM5.VM5_FILIAL='"+xFilial("VM5")+"' AND VM5.VM5_CODIGO=VM2.VM2_CODIGO AND VM5.VM5_DIVERG='1'AND VM5.D_E_L_E_T_ = ' ' ) "
		cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM2.VM2_USRSTA AND VAI.D_E_L_E_T_ = ' ' ) "
		cQuery += " WHERE VM2.VM2_FILIAL = '"+xFilial("VM2")+"'"
		cQuery += "   AND VM2.VM2_TIPO = '3' " // Tipo: Pecas Orcamento
		cQuery += "   AND VM2.VM2_STATUS = '4' " // Status: Aprovado
		cQuery += "   AND VM2.VM2_DATSTA >= '"+dtos(MV_PAR02)+"' AND VM2.VM2_DATSTA <= '"+dtos(MV_PAR03)+"' "
		cQuery += "   AND VM2.D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSQL, .F., .T. )
		While !(cQAlSQL)->(Eof())
			//
			VM5->(DbGoto( (cQAlSQL)->( RECVM5 ) ))
			VAI->(DbGoto( (cQAlSQL)->( RECVAI ) ))
			oSection5:Init()
			oSection5:PrintLine()
			oSection5:Finish()
			//
			oSection6:Init()
			cQuery := "SELECT VM6.R_E_C_N_O_ AS RECVM6 ,"
			cQuery += "       SB1.R_E_C_N_O_ AS RECSB1 ,"
			cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
			cQuery += "  FROM "+RetSQLName("VM6")+" VM6 "
			cQuery += "  JOIN "+RetSQLName("SB1")+" SB1 ON ( SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=VM6.VM6_COD AND SB1.D_E_L_E_T_ = ' ' ) "
			cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM6.VM6_USRCON AND VAI.D_E_L_E_T_ = ' ' ) "
			cQuery += " WHERE VM6.VM6_FILIAL = '"+xFilial("VM6")+"'"
			cQuery += "   AND VM6.VM6_CODVM5 = '"+VM5->VM5_CODIGO+"' "
			cQuery += "   AND VM6.VM6_QTORIG <> VM6.VM6_QTCONF"
			cQuery += "   AND VM6.D_E_L_E_T_ = ' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
			While !(cQAlAux)->(Eof())
				//
				VM6->(DbGoto( (cQAlAux)->( RECVM6 ) ))
				SB1->(DbGoto( (cQAlAux)->( RECSB1 ) ))
				VAI->(DbGoto( (cQAlAux)->( RECVAI ) ))
				oSection6:PrintLine()
				//
				(cQAlAux)->(dbSkip())
			EndDo
			(cQAlAux)->(dbCloseArea())
			oSection6:Finish()
			//
			(cQAlSQL)->(dbSkip())
		EndDo
		(cQAlSQL)->(dbCloseArea())
		DbSelectArea("VM5")

	Case MV_PAR01 == 4 // Volume de Entrada

		oReport:SetTitle( STR0008+" - "+STR0009 ) // Divergencias na Conferencia / Volume de Entrada de Peças

		cQuery := "SELECT VM7.R_E_C_N_O_ AS RECVM7 ,"
		cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
		cQuery += "  FROM "+RetSQLName("VM2")+" VM2 "
		cQuery += "  JOIN "+RetSQLName("VM7")+" VM7 ON ( VM7.VM7_FILIAL='"+xFilial("VM7")+"' AND VM7.VM7_CODIGO=VM2.VM2_CODIGO AND VM7.VM7_DIVERG='1'AND VM7.D_E_L_E_T_ = ' ' ) "
		cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM2.VM2_USRSTA AND VAI.D_E_L_E_T_ = ' ' ) "
		cQuery += " WHERE VM2.VM2_FILIAL = '"+xFilial("VM2")+"'"
		cQuery += "   AND VM2.VM2_TIPO = '4' " // Tipo: Volume Entrada
		cQuery += "   AND VM2.VM2_STATUS = '4' " // Status: Aprovado
		cQuery += "   AND VM2.VM2_DATSTA >= '"+dtos(MV_PAR02)+"' AND VM2.VM2_DATSTA <= '"+dtos(MV_PAR03)+"' "
		cQuery += "   AND VM2.D_E_L_E_T_ = ' '"
		dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSQL, .F., .T. )
		While !(cQAlSQL)->(Eof())
			//
			VM7->(DbGoto( (cQAlSQL)->( RECVM7 ) ))
			VAI->(DbGoto( (cQAlSQL)->( RECVAI ) ))
			oSection7:Init()
			oSection7:PrintLine()
			oSection7:Finish()
			//
			oSection8:Init()
			cQuery := "SELECT VM8.R_E_C_N_O_ AS RECVM8 ,"
			cQuery += "       SB1.R_E_C_N_O_ AS RECSB1 ,"
			cQuery += "       VAI.R_E_C_N_O_ AS RECVAI  "
			cQuery += "  FROM "+RetSQLName("VM8")+" VM8 "
			cQuery += "  JOIN "+RetSQLName("SB1")+" SB1 ON ( SB1.B1_FILIAL='"+xFilial("SB1")+"' AND SB1.B1_COD=VM8.VM8_COD AND SB1.D_E_L_E_T_ = ' ' ) "
			cQuery += "  JOIN "+RetSQLName("VAI")+" VAI ON ( VAI.VAI_FILIAL='"+xFilial("VAI")+"' AND VAI.VAI_CODUSR=VM8.VM8_USRCON AND VAI.D_E_L_E_T_ = ' ' ) "
			cQuery += " WHERE VM8.VM8_FILIAL = '"+xFilial("VM8")+"'"
			cQuery += "   AND VM8.VM8_CODVM7 = '"+VM7->VM7_CODIGO+"' "
			cQuery += "   AND VM8.VM8_QTORIG <> VM8.VM8_QTCONF"
			cQuery += "   AND VM8.D_E_L_E_T_ = ' '"
			dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlAux, .F., .T. )
			While !(cQAlAux)->(Eof())
				//
				VM8->(DbGoto( (cQAlAux)->( RECVM8 ) ))
				SB1->(DbGoto( (cQAlAux)->( RECSB1 ) ))
				VAI->(DbGoto( (cQAlAux)->( RECVAI ) ))
				cAuxImpr := ""
				cQuery := "SELECT DISTINCT VCX_DOCSDB"
				cQuery += "  FROM " + RetSqlName("VCX")
				cQuery += " WHERE VCX_FILIAL = '"+xFilial("VCX")+"'"
				cQuery += "   AND VCX_VOLUME = '"+VM7->VM7_VOLUME+"'"
				cQuery += "   AND VCX_COD    = '"+VM8->VM8_COD+"'"
				cQuery += "   AND VCX_DOCSDB <>' '"
				cQuery += "   AND D_E_L_E_T_ = ' '"
				dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlVCX, .F., .T. )
				While !(cQAlVCX)->(Eof())
					cAuxImpr += (cQAlVCX)->( VCX_DOCSDB )+"/"
					(cQAlVCX)->(DbSkip())
				EndDo
				(cQAlVCX)->(dbCloseArea())
				oSection8:PrintLine()
				//
				(cQAlAux)->(dbSkip())
			EndDo
			(cQAlAux)->(dbCloseArea())
			oSection8:Finish()
			//
			(cQAlSQL)->(dbSkip())
		EndDo
		(cQAlSQL)->(dbCloseArea())
		DbSelectArea("VM7")

EndCase

Return