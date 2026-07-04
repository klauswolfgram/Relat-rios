/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "protheus.ch"
#INCLUDE "OFIOR450.CH"
#INCLUDE "OFIXDEF.CH"
#INCLUDE "TopConn.CH"
#INCLUDE "report.ch"
#INCLUDE "rptdef.ch"

// Posicao da Matriz aAuxTT
#DEFINE ATT_TIPTEM		01 // Tipo de Tempo
#DEFINE ATT_LIBVOO 		02 // Numero da Liberacao do TT (VOO_LIBVOO)
#DEFINE ATT_CLIENTE 	03 // Cliente Faturar Para
#DEFINE ATT_LOJA 		04 // Loja Faturar Para
#DEFINE ATT_PRODUTIVO 	05 // Produtivo que fechou o TT
#DEFINE ATT_NUMNFI 		06 // Numero da Nota Fiscal
#DEFINE ATT_SERNFI 		07 // Serie da Nota Fiscal
#DEFINE ATT_TOTPECA 	08 // Total de Pecas
#DEFINE ATT_TEMPAD 		09 // Tempo Padrao
#DEFINE ATT_TEMTRA 		10 // Tempo Trabalhado
#DEFINE ATT_TEMCOB 		11 // Tempo Cobrado
#DEFINE ATT_TEMVEN 		12 // Tempo Vendido
#DEFINE ATT_TOTSRVC 	13 // Total Servicos
#DEFINE ATT_DEPINT 		14 // Departamento Interno
#DEFINE ATT_DEPGAR 		15 // Departamento Garantia
#DEFINE ATT_DATLIB 		16 // Data de Liberacao
#DEFINE ATT_DATFEC 		17 // Data de Fechamento
#DEFINE ATT_DATCAN 		18 // Data de Cancelamento
#DEFINE ATT_QTDPECA 	19 // Total de qtde de Pecas
#DEFINE ATT_NOME		20 // Nome do Cliente Faturar Para
#DEFINE ATT_SITTPO		21 // Situação do Tipo de Tempo

static nPosTP      := Iif(cPaisLoc == "BRA", 29, 30)
static nPosLIBVOO  := Iif(cPaisLoc == "BRA", 30, 31)
static nPosFATPAR  := Iif(cPaisLoc == "BRA", 31, 32)
static nPosLJPAR   := Iif(cPaisLoc == "BRA", 32, 33)
static nPosNOMEPA  := Iif(cPaisLoc == "BRA", 33, 34)
static nPosDEPTOG  := Iif(cPaisLoc == "BRA", 34, 35)
static nPosDEPTOI  := Iif(cPaisLoc == "BRA", 35, 36)
static nPosCONSFE  := Iif(cPaisLoc == "BRA", 36, 37)
static nPosDTLIB   := Iif(cPaisLoc == "BRA", 37, 38)
static nPosDTFEC   := Iif(cPaisLoc == "BRA", 38, 39)
static nPosDTCAN   := Iif(cPaisLoc == "BRA", 39, 40)
static nPosNRONF   := Iif(cPaisLoc == "BRA", 40, 41)
static nPosSERIEN  := Iif(cPaisLoc == "BRA", 41, 42)
static nPosPECATT  := Iif(cPaisLoc == "BRA", 42, 43)
static nPosTOPATT  := Iif(cPaisLoc == "BRA", 43, 44)
static nPosTOTRTT  := Iif(cPaisLoc == "BRA", 44, 45)
static nPosTOCOTT  := Iif(cPaisLoc == "BRA", 45, 46)
static nPosTOVETT  := Iif(cPaisLoc == "BRA", 46, 47)
static nPosSERVTT  := Iif(cPaisLoc == "BRA", 47, 48)
static nPosRELACA  := Iif(cPaisLoc == "BRA", 48, 49)
static nPosGRUPO   := Iif(cPaisLoc == "BRA", 49, 50)
static nPosCODITE  := Iif(cPaisLoc == "BRA", 50, 51)
static nPosDESITE  := Iif(cPaisLoc == "BRA", 51, 52)
static nPosQTDADE  := Iif(cPaisLoc == "BRA", 52, 53)
static nPosPRODRE  := Iif(cPaisLoc == "BRA", 53, 54)
static nPosFORMUL  := Iif(cPaisLoc == "BRA", 54, 55)
static nPosVLRUNI  := Iif(cPaisLoc == "BRA", 55, 56)
static nPosVLRTOT  := Iif(cPaisLoc == "BRA", 56, 57)
static nPosTIPOSR  := Iif(cPaisLoc == "BRA", 57, 58)
static nPosGRUPOS  := Iif(cPaisLoc == "BRA", 58, 59)
static nPosCODSRV  := Iif(cPaisLoc == "BRA", 59, 60)
static nPosDESSRV  := Iif(cPaisLoc == "BRA", 60, 61)
static nPosPRODUT  := Iif(cPaisLoc == "BRA", 61, 62)
static nPosNOMEPR  := Iif(cPaisLoc == "BRA", 62, 63)
static nPosTPOPAD  := Iif(cPaisLoc == "BRA", 63, 64)
static nPosTPOTRA  := Iif(cPaisLoc == "BRA", 64, 65)
static nPosTPOCOB  := Iif(cPaisLoc == "BRA", 65, 66)
static nPosTPOVEN  := Iif(cPaisLoc == "BRA", 66, 67)
static nPosSERV    := Iif(cPaisLoc == "BRA", 67, 68)
static nPosKMRODA  := Iif(cPaisLoc == "BRA", 68, 69)
static nPosORIPAR  := Iif(cPaisLoc == "BRA", 69, 70)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OFIOR450 º Autor ³ Rubens Takahashi   º Data ³ 27/12/12    º±±
±±ºPrograma  ³ OFIOR450 º Autor ³ Alecsandre Ferreira º Data ³ 10/12/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Impressão de Ordens de Serviços                            º±±
±±ºDescricao2 ³ Adaptação da LGPD.                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR450
	Local oReport
	Private lVO1DATSTA  := VO1->(FieldPos("VO1_DATSTA")) > 0
	Private aEmp      := FwLoadSM0()
	Private nEmp      := aScan(aEmp, {|i| i[1] == cEmpAnt .AND. i[2] == cFilAnt})
	Private lA1_IBGE	:= SA1->(FieldPos("A1_IBGE")) <> 0

	DbSelectArea("SA1")
	DbSetOrder(1) // A1_FILIAL+A1_COD+A1_LOJA

	if lA1_IBGE
	DbSelectArea("VAM")
	DbSetOrder(1) // VAM_FILIAL+VAM_IBGE
	endif

	DbSelectArea("VE1")
	DbSetOrder(1) // VE1_FILIAL+VE1_CODMAR

	DbSelectArea("VO1")
	DbSetOrder(1) // VO1_FILIAL+VO1_NUMOSV

	DbSelectArea("VVC")
	DbSetOrder(1) // VVC_FILIAL+VVC_CODMAR+VVC_CORVEI

	DbSelectArea("VV1")
	DbSetOrder(1) // VV1_FILIAL+VV1_CHAINT

	DbSelectArea("VV2")
	DbSetOrder(1) // VV2_FILIAL+VV2_CODMAR+VV2_MODVEI+VV2_SEGMOD

	Pergunte("OFR450", .F.)
	oReport := RptDefOS()
    oReport:nFontBody := 8
    oReport:oPage:nPaperSize := 9
    oReport:PrintDialog()
Return

Static Function RptDefOS()
	Local oReport
	Local cPerg			:= "OFR450"
	Local cDesc         := STR0226 // Este relatório tem por objetivo relacionar as ordens de serviços existentes no sistema por meio de diversos filtros, bem como exportar para planilha eletrônica. Desta forma, o usuário poderá configurar este relatório de acordo com suas necessidades e listar as ordens de serviço desejadas para realizar seus acompanhamentos e controles.
	Local oSection1
	Local oSection2
	Local oSection3
	Local oSection4
	Local oSection5
	Local oSection6
	Local oSection7
	Local oSection8

	Private cTitulo		:= STR0029 // Relatório de Ordens de Serviços
	Private cNomeRel	:= 'OFIOR450'

	oReport := TReport():New(;
        cNomeRel,;
        cTitulo,;
        cPerg,;
        {|oReport| RunRptOS(oReport)},;
        cDesc;
    )

	oReport:SetLineHeight(45)
	oReport:SetLandscape()
	oReport:DisableOrientation()

	// Dados da Empresa
	oSection1 := TRSection():New(oReport, STR0228, "SM0") // Dados da Empresa
	oSection1:ShowHeader()
	TrCell():New(oSection1, "M0_NOMECOM", "SM0", STR0154,, 40) // Nome
	If !Empty(SM0->M0_ENDENT) // Endereço de Entrega
		TRCell():New(oSection1, "M0_ENDENT", "SM0", STR0155,, 30) // Endereço
	Endif
	If !Empty(SM0->M0_CIDENT) // Cidade de Entrega
		TRCell():New(oSection1, "M0_CIDENT", "SM0", STR0156,, 12) // Cidade
	Endif
	If !Empty(SM0->M0_ESTENT) // Estado de Entrega
		TRCell():New(oSection1, "M0_ESTENT", "SM0", STR0157,, 10) // Estado
	Endif
	If !Empty(SM0->M0_CEPENT) // CEP Entrega
		TRCell():New(oSection1, "M0_CEPENT", "SM0", STR0158,, 15) // CEP
	Endif
	TRCell():New(oSection1, "M0_TEL",  "SM0", STR0159,, 15) // Telefone
	TRCell():New(oSection1, "M0_CGC",  "SM0", STR0160,, 20) // CNPJ
	TRCell():New(oSection1, "M0_INSC", "SM0", STR0161,, 20) // IE
	If !Empty(SM0->M0_CODMUN)
		TRCell():New(oSection1, "M0_CODMUN", "SM0", STR0162,, 10) // Cód. Mun
	Endif
	oSection1:SetLinesBefore(1)
	oSection1:SetReadOnly()

	// Resumo
	oSection2 := TRSection():New(oReport, STR0035, {"VO1", "VO3", "VO4", "VOI", "VOK"}) // Resumo 
	oSection2:ShowHeader()
	TrCell():New(oSection2, "VOI_TIPTEM", "VOI", STR0163, "@!", 80,,,,,,,,,,, .T.) // Tipo de Tempo
	TrCell():New(oSection2, "VOI_DESTTE", "VOI", STR0164, "@!", 40) // Descrição
	TrCell():New(oSection2, "VO3_QTDREQ", "VO3", STR0165, "@!", 40,,, "RIGHT",, "RIGHT") // Qtde.
	TrCell():New(oSection2, "COUNT_PEC",  "",    STR0166, "@!", 40,,, "RIGHT") // Peças
	TrCell():New(oSection2, "VO4_TEMPAD", "VO4", STR0167, "@!", 40,,, "RIGHT") // Padrão
	TrCell():New(oSection2, "VO4_TEMTRA", "VO4", STR0168, "@!", 40,,, "RIGHT") // Trabal.
	TrCell():New(oSection2, "VO4_TEMCOB", "VO4", STR0169, "@!", 40,,, "RIGHT") // Cobrado
	TrCell():New(oSection2, "VO4_TEMVEN", "VO4", STR0170, "@!", 40,,, "RIGHT") // Vendido
	if cPaisLoc == "BRA"
		TrCell():New(oSection2, "VO4_VALSER", "",    STR0171, "@!", 40,,, "RIGHT") // Serviços
	else
		TrCell():New(oSection2, "VALSER", "",    STR0171, "@!", 40,,, "RIGHT") // Serviços
	endif
	TrCell():New(oSection2, "COUNT_TT",   "",    STR0172, "@!", 40,,, "RIGHT") // Qtde. T.T.
	TrCell():New(oSection2, "COUNT_OS",   "",    STR0173, "@!", 40,,, "RIGHT",,,,,,,, .T.) //  Qtde. O.S.
	oSection2:SetReadOnly()

	// Resumo Departamento
	oSection3 := TRSection():New(oReport, STR0230, {"VO1", "VO3", "VO4"}) // Resumo Departamento
	oSection3:ShowHeader()
	TrCell():New(oSection3, "VO4_DEPGAR", "VO4", STR0174, "@!", 80,,,,,,,,,,, .T.) // Departamento
	TrCell():New(oSection3, "VO3_QTDREQ", "VO3", STR0165, "@!", 40) // Qtde.
	TrCell():New(oSection3, "COUNT_PEC",  "",    STR0166, "@!", 40) // Peças
	TrCell():New(oSection3, "VO4_TEMPAD", "VO4", STR0167, "@!", 40) // Padrão
	TrCell():New(oSection3, "VO4_TEMTRA", "VO4", STR0168, "@!", 40) // Trabal.
	TrCell():New(oSection3, "VO4_TEMCOB", "VO4", STR0169, "@!", 40) // Cobrado
	TrCell():New(oSection3, "VO4_TEMVEN", "VO4", STR0170, "@!", 40) // Vendido
	if cPaisLoc == "BRA"
		TrCell():New(oSection3, "VO4_VALSER", "VO4",    STR0171, "@!", 40) // Serviços
	else
		TrCell():New(oSection3, "VALSER", "",    STR0171, "@!", 40) // Serviços
	endif
	
	TrCell():New(oSection3, "COUNT_OS",	  "",    STR0173, "@!", 40) // Qtde. O.S.
	oSection3:SetReadOnly()

	// Resumo Tipo de Serviço
	oSection4 := TRSection():New(oReport,  STR0231, {"VOK", "VO4"}) // Resumo Tipo de Serviço
	oSection4:ShowHeader()
	TrCell():New(oSection4, "VOK_TIPSER", "VOK", STR0175, "@!", 80,,,,,,,,,,, .T.) //
	TrCell():New(oSection4, "VOK_DESSER", "VOK", STR0164, "@!", 40) // Descrição
	TrCell():New(oSection4, "VO4_TEMPAD", "VO4", STR0167, "@!", 40) // Padrão
	TrCell():New(oSection4, "VO4_TEMVEN", "VO4", STR0170, "@!", 40) // Vendido
	TrCell():New(oSection4, "VO4_TEMTRA", "VO4", STR0168, "@!", 40) // Trabal.
	TrCell():New(oSection4, "VO4_TEMCOB", "VO4", STR0169, "@!", 40) // Cobrado
	if cPaisLoc == "BRA"
		TrCell():New(oSection4, "VO4_VALSER", "VO4", STR0171, "@!", 40) // Valor Serv.
	else
		TrCell():New(oSection4, "VALSER", "", STR0171, "@!", 40) // Valor Serv.
	endif
	TrCell():New(oSection4, "COUNT_OS",   "",    STR0173, "@!", 40) // Qtde. O.S.
	oSection4:SetReadOnly()

	// Cabecalho Sintético
	oSection5 := TRSection():New(oReport, STR0232, {"VO1", "SA1", "VE1", "VV1", "VV2", "VVC"}) // Cabecalho Sintético
	oSection5:ShowHeader()
	TrCell():New(oSection5, "COD_FILIAL", "", STR0177,, 24) // Filial // TODO: Verificar se é possivel não usar a tabela SM0, trazendo o conteúdo da filial através da função FWGetFilial()
	TrCell():New(oSection5, "VO1_NUMOSV", "VO1", STR0178,, 27) // Nro. O.S.
	TrCell():New(oSection5, "VO1_STATUS", "VO1", STR0179,, 30) // Status
	TrCell():New(oSection5, "VO1_DATABE", "VO1", STR0180,, 20) // Dt. Abert.
	TrCell():New(oSection5, "VO1_HORABE", "VO1", STR0181,, 26,,, "LEFT") // Hr. Abert.
	TrCell():New(oSection5, "VO1_FUNABE", "VO1", STR0182,, 40) // Consult. Abert.
	TrCell():New(oSection5, "A1_COD",     "SA1", STR0183,, 15) // Proprietário
	TrCell():New(oSection5, "A1_LOJA",    "SA1", STR0184,, 10) // Loja
	TrCell():New(oSection5, "A1_NOME",    "SA1", STR0154,, 40) // Nome
	TrCell():New(oSection5, "A1_CGC",     "SA1", STR0185, "@!", 30) // CPF/CNPJ
	TrCell():New(oSection5, "A1_END",     "SA1", STR0155,, 30) // Endereço
	If lA1_IBGE
		TrCell():New(oSection5, "VAM_DESCID", "VAM", STR0156,, 20) // Cidade
		TrCell():New(oSection5, "VAM_ESTADO", "VAM", STR0076,, 10) // UF
	Else
		TrCell():New(oSection5, "A1_MUN",     "SA1", STR0156,, 20) // Cidade
		TrCell():New(oSection5, "A1_EST",     "SA1", STR0076,, 10) // UF
	EndIf
	TrCell():New(oSection5, "A1_TEL",     "SA1", STR0159,, 30) // Telefone
	TrCell():New(oSection5, "VE1_CODMAR", "VE1", STR0186,, 15) // Marca
	TrCell():New(oSection5, "VE1_DESMAR", "VE1", STR0164,, 25) // Descrição
	TrCell():New(oSection5, "VV1_FABMOD", "VV1", STR0187,, 15) // Fab/Mod
	TrCell():New(oSection5, "VV1_MODVEI", "VV1", STR0188,, 15) // Modelo
	TrCell():New(oSection5, "VV2_DESMOD", "VV2", STR0189,, 25) // Desc. Mod.
	TrCell():New(oSection5, "VVC_DESCRI", "VVC", STR0190,, 15) // Cor
	TrCell():New(oSection5, "VV1_CHASSI", "VV1", STR0191,, 30) // Chassi
	TrCell():New(oSection5, "VV1_CHAINT", "VV1", STR0192,, 30) // Chassi Int.
	TrCell():New(oSection5, "VO1_KILOME", "VO1", STR0193,, 20,,, "LEFT") // Km.
	TrCell():New(oSection5, "VV1_PLAVEI", "VV1", STR0194,, 20) // Placa
	TrCell():New(oSection5, "VV1_CODFRO", "VV1", STR0195,, 30) // Cód. Frota
	if cPaisLoc $ "ARG|MEX|PAR"
		TrCell():New(oSection5, "VO1_MOEDA",  "VO1", STR0236,, 30) // Moeda
	endif
	
	oSection5:SetLineStyle()

	// Cabecalho Sintético OS
	oSection6 := TRSection():New(oReport, STR0233, {"VOI", "SA1", "VO4", "VOO", "SF2"}) // Cabecalho Sintético OS
	oSection6:ShowHeader()
	TrCell():New(oSection6, "VOI_TIPTEM", "VOI", STR0196,, 15) // Tp. Tempo
	TrCell():New(oSection6, "VOI_SITTPO", "VOI", STR0197,, 85) // Situação
	TrCell():New(oSection6, "A1_COD",	  "SA1", STR0198,, 15) // Cód. Cliente
	TrCell():New(oSection6, "A1_LOJA", 	  "SA1", STR0184,, 10) // Loja
	TrCell():New(oSection6, "A1_NOME", 	  "SA1", STR0154,, 75) // Nome
	TrCell():New(oSection6, "VO4_DEPGAR", "VO4", STR0199,, 15) // Dep. Garantia
	TrCell():New(oSection6, "VO4_DEPINT", "VO4", STR0200,, 85) // Dep. Interno
	TrCell():New(oSection6, "VO4_DATDIS", "VO4", STR0201,, 20) // Dt. Lib.
	TrCell():New(oSection6, "VO4_DATFEC", "VO4", STR0202,, 20) // Dt. Fechada
	TrCell():New(oSection6, "VO4_DATCAN", "VO4", STR0203,, 60) // Dt. Cancel.
	TrCell():New(oSection6, "VOO_LIBVOO", "VOO", STR0204,, 15) // Num. Lib.
	TrCell():New(oSection6, "VO4_FUNFEC", "VO4", STR0205,, 15) // Prdt. Fechou O.S.
	TrCell():New(oSection6, "F2_DOC", 	  "SF2", STR0206,, 25) // Num. NF
	TrCell():New(oSection6, "F2_SERIE",   "SF2", STR0207,, 35) // Série
	TrCell():New(oSection6, "VO4_TEMPAD", "VO4", STR0208,, 15,,, "LEFT") // Tp. Padrão
	TrCell():New(oSection6, "VO4_TEMTRA", "VO4", STR0209,, 15,,, "LEFT") // Tp. Trabalhado
	TrCell():New(oSection6, "VO4_TEMCOB", "VO4", STR0211,, 15,,, "LEFT") // Tp. Cobrado
	TrCell():New(oSection6, "VO4_TEMVEN", "VO4", STR0210,, 35,,, "LEFT") // Tp. Vendido

	if cPaisLoc == "BRA"
		TrCell():New(oSection6, "VO3_VALPEC", "VO3", STR0166, GetSX3Cache("F2_VALBRUT", "X3_PICTURE"), 60,,, "LEFT") // Peças
		TrCell():New(oSection6, "VO4_VALSER", "VO4", STR0171, GetSX3Cache("F2_VALBRUT", "X3_PICTURE"), 60,,, "LEFT") // Serviços
	else
		TrCell():New(oSection6, "VALPEC", "", STR0166, , 60,,, "LEFT") // Peças
		TrCell():New(oSection6, "VALSER", "", STR0171, , 60,,, "LEFT") // Serviços
	endif
	oSection6:SetLineStyle()
	oSection6:SetReadOnly()

	oSection7 := TRSection():New(oReport, STR0234,{ "SBM", "SB1", "VO3" }) // Peças Requisitadas
	oSection7:ShowHeader()
	TrCell():New(oSection7, "BM_GRUPO",   "SBM", STR0212,, 40) // Grupo
	TrCell():New(oSection7, "B1_CODITE",  "SB1", STR0213,, 40) // Cód. Peça
	TrCell():New(oSection7, "B1_DESC",    "SB1", STR0164,, 40) // Descrição
	TrCell():New(oSection7, "VO3_QTDREQ", "VO3", STR0214,, 40) // Quant.
	TrCell():New(oSection7, "VO3_PROREQ", "VO3", STR0215,, 40) // Prod. Req.
	TrCell():New(oSection7, "VO3_FORMUL", "VO3", STR0216,, 40) // Fórmula
	if cPaisLoc == "BRA"
		TrCell():New(oSection7, "VO3_VALPEC", "VO3", STR0217,, 40) // Valor Unit.
		TrCell():New(oSection7, "VO3_VALTOT", "",    STR0218, GetSX3Cache("VO3_VALPEC", "X3_PICTURE"), 40) // Valor Total
	else
		TrCell():New(oSection7, "VALPEC", "", STR0217,, 40) // Valor Unit.
		TrCell():New(oSection7, "VALTOT", "", STR0218,, 40) // Valor Total
	endif
	oSection7:SetReadOnly()

	oSection8 := TRSection():New(oReport,STR0235, { "VO4", "VO6", "VOK", "VOS", "VAI"},,,,, .T.) // Serviços Requisitados
	oSection8:ShowHeader()
	TrCell():New(oSection8, "VOK_TIPSER", "VOK", STR0175,"@!", 40) // Tipo Serv.
	TrCell():New(oSection8, "VOS_CODGRU", "VOS", STR0219,, 40) // Grupo Serv.
	TrCell():New(oSection8, "VO6_CODSER", "VO6", STR0220,, 40) // Cód Serv.
	TrCell():New(oSection8, "VO6_DESSER", "VO6", STR0164,, 40) // Descrição
	TrCell():New(oSection8, "VAI_CODTEC", "VAI", STR0221,, 40) // Cód. Prod.
	TrCell():New(oSection8, "VAI_NOMTEC", "VAI", STR0154,, 40) // Nome
	TrCell():New(oSection8, "VO4_KILROD", "VO4", STR0222, "@!", 40) // Kil. Rod.
	TrCell():New(oSection8, "VO4_TEMPAD", "VO4", STR0208,, 40) // Tp. Padrão    
	TrCell():New(oSection8, "VO4_TEMTRA", "VO4", STR0209,, 40) // Tp. Trabalhado
	TrCell():New(oSection8, "VO4_TEMCOB", "VO4", STR0211,, 40) // Tp. Cobrado   
	TrCell():New(oSection8, "VO4_TEMVEN", "VO4", STR0210,, 40) // Tp. Vendido   

	if cPaisLoc == "BRA"
		TrCell():New(oSection8, "VO4_VALSER", "VO4", STR0223,, 40) // Vlr. Tot. Serv.
	else
		TrCell():New(oSection8, "VALSER", "", STR0223,, 40) // Vlr. Tot. Serv.
	endif

	oSection8:SetReadOnly()

Return oReport

/* /
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  27/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/ */

Static Function RunRptOS(oReport)
	Local nI, nJ
	Local nCont
	Local nContTT
	Local nCntFil
	Local nContApon
	Local nTemCobApo		:= 0
	Local nAuxTemCob		:= 0
	Local nAuxTemTra		:= 0
	Local nAuxTemVen		:= 0
	Local nPassagens		:= 0
	Local nAuxValorSrvc		:= 0
	Local nTamVV2TipVei		:= GetSX3Cache("VV2_TIPVEI", "X3_TAMANHO")
	Local nCntFor			:= 0
	Local cFilTT
	Local cFilDe
	Local cFilAte
	Local cFilBkp			:= cFilAnt
	Local cQuery
	Local cQueryVO3			:= ""
	Local cQueryVO4			:= ""
	Local cFilSA1			:= ""
	Local cFilSB1			:= ""
	Local cFilVOD			:= ""
	Local cFilVOI			:= ""
	Local cFilVOK			:= ""
	Local cFilSX5			:= ""
	Local cFilVS1			:= ""
	Local cFilVV8			:= ""
	Local cProcTIPSER
	Local cProcTIPTEM
	Local cProcSITTPO
	Local cAuxProdutivo
	Local cQueryVO4DTCanc	:= ""
	Local lFilVO3VO4
	Local lConsVenda		:= .F.
	Local lReqZerada
	Local lFirstS5 			:= .T.
	Local aSM0				:= FWLoadSM0()
	Local aAuxApon
	Local aResDepto			:= {}	// Resumo por Departamento
	Local aResTipSer		:= {}	// Resumo por Tipo de Servico
	Local aResTipTem		:= {}	// Resumo por Tipo de Tempo
	Local aResSitTpo		:= {}	// Resumo por Situacao do Tempo do Tipo de Tempo
	Local aAuxLinPeca
	Local aAuxLinSrvc
	Local lPrimLinha
	Local oExcel 			
	Local oSection1			:= oReport:Section(STR0228) // "Dados da Empresa"
	Local oSection5			:= oReport:Section(STR0232) // "Cabecalho Sintético"
	Local oSection6			:= oReport:Section(STR0233) // "Cabecalho Sintético OS"
	Local oSection7			:= oReport:Section(STR0234) // "Peças Requisitadas"
	Local oSection8			:= oReport:Section(STR0235) // "Serviços Requisitados"
	Local nPos              := 0
	Local nMoedaAtua 	    := 0
	Local aRow				:= {}
	Local aFldDate			:= Iif(cPaisLoc $ "ARG|MEX|PAR", {5, 38, 39, 40}, {4, 37, 38, 39})

	Private nCbCont     	:= 0
	Private nContFl     	:= 1
	Private nPosicao 		:= 0
	Private CbTxt       	:= Space(10)
	Private cString     	:= ""
	Private cTamanho    	:= "G"
	Private lEnd        	:= .F.
	Private lAbortPrint 	:= .F.
	Private lVO1DATSTA  	:= VO1->(FieldPos("VO1_DATSTA")) > 0
	Private aAuxTT
	Private aImpXls			:= {}
	Private aSimbolos       := {}

	lFilVO3VO4 := .F. // Filtra o VO1 de acordo com o VO3 e VO4

	If Empty(MV_PAR18) .AND. Upper(MV_PAR19) == "ZZZ"
		MsgInfo(STR0143 + STR0019 + STR0144, STR0045) //  "Se deseja verificar TODOS os TIPOS DE SERVIÇOS a pergunta " # " deverá estar com conteúdo VAZIO!" # "Atenção"
		Return
	Endif

	nI := 1
	while !Empty(GetMV("MV_SIMB"+Str(nI, 1, 0),,""))
		Aadd(aSimbolos, GetMV("MV_SIMB"+Str(nI, 1, 0)))
		nI++
	end

	// Filtro por Tipo de Tempo
	If !Empty(Left(MV_PAR01, 1))
		// Monta string de filtro de tipo de tempo
		cFilTT := ""
		For nCont := 1 to Len(MV_PAR01) Step (GetSX3Cache("VOO_TIPTEM", "X3_TAMANHO") + 1)
			If !Empty(SubStr(MV_PAR01, nCont, GetSX3Cache("VOO_TIPTEM", "X3_TAMANHO")))
				cFilTT += SubStr(MV_PAR01, nCont, GetSX3Cache("VOO_TIPTEM", "X3_TAMANHO")) + ","
			EndIf
		Next
		If !Empty(cFilTT)
			cFilTT := FormatIN(Left(cFilTT, Len(cFilTT) - 1 ), ",")
		EndIf
		
		cQueryVO3 += " AND VO3.VO3_TIPTEM IN " + cFilTT
		cQueryVO4 += " AND VO4.VO4_TIPTEM IN " + cFilTT
	EndIf

	Do Case // Filtro por Status do Tipo de Tempo
		Case MV_PAR02 == 2 // Tipo de Tempo Aberto
			cQueryVO3 += " AND VO3.VO3_DATDIS = ' ' "
			cQueryVO3 += " AND VO3.VO3_DATFEC = ' ' " 
			cQueryVO3 += " AND VO3.VO3_DATCAN = ' ' "

			cQueryVO4 += " AND VO4.VO4_DATDIS = ' ' "
			cQueryVO4 += " AND VO4.VO4_DATFEC = ' ' " 
			cQueryVO4 += " AND VO4.VO4_DATCAN = ' ' "
		Case MV_PAR02 == 3 // Tipo de Tempo Liberado
			cQueryVO3 += " AND VO3.VO3_DATDIS <> ' ' "
			cQueryVO3 += " AND VO3.VO3_DATFEC = ' ' "
			cQueryVO3 += " AND VO3.VO3_DATCAN = ' ' "

			cQueryVO4 += " AND VO4.VO4_DATDIS <> ' ' "
			cQueryVO4 += " AND VO4.VO4_DATFEC = ' ' " 
			cQueryVO4 += " AND VO4.VO4_DATCAN = ' ' "
		Case MV_PAR02 == 4 // Tipo de Tempo Fechado
			cQueryVO3 += " AND VO3.VO3_DATDIS <> ' ' "
			cQueryVO3 += " AND VO3.VO3_DATFEC <> ' ' " 
			cQueryVO3 += " AND VO3.VO3_DATCAN = ' ' "

			cQueryVO4 += " AND VO4.VO4_DATDIS <> ' ' "
			cQueryVO4 += " AND VO4.VO4_DATFEC <> ' ' "
			cQueryVO4 += " AND VO4.VO4_DATCAN = ' ' "
		Case MV_PAR02 == 5 // Tipo de Tempo Cancelado
			cQueryVO3 += " AND VO3.VO3_DATCAN <> ' ' "
			cQueryVO4 += " AND VO4.VO4_DATCAN <> ' ' "
	End Case

	// Filtro por Data a Ser Considerada
	Do Case
		Case MV_PAR04 == 2 // Data de Liberacao
			cQueryVO3 += " AND VO3.VO3_DATDIS >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO3 += " AND VO3.VO3_DATDIS <= '" + DtoS(MV_PAR06) + "' "

			cQueryVO4 += " AND VO4.VO4_DATDIS >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO4 += " AND VO4.VO4_DATDIS <= '" + DtoS(MV_PAR06) + "' "
		Case MV_PAR04 == 3 // Data de Fechamento
			cQueryVO3 += " AND VO3.VO3_DATFEC >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO3 += " AND VO3.VO3_DATFEC <= '" + DtoS(MV_PAR06) + "' "

			cQueryVO4 += " AND VO4.VO4_DATFEC >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO4 += " AND VO4.VO4_DATFEC <= '" + DtoS(MV_PAR06) + "' "
		Case MV_PAR04 == 4 // Data de Cancelamento
			cQueryVO3 += " AND VO3.VO3_DATCAN >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO3 += " AND VO3.VO3_DATCAN <= '" + DtoS(MV_PAR06) + "' "

			cQueryVO4 += " AND VO4.VO4_DATCAN >= '" + DtoS(MV_PAR05) + "' "
			cQueryVO4 += " AND VO4.VO4_DATCAN <= '" + DtoS(MV_PAR06) + "' "
			If lVO1DATSTA
				cQueryVO4DTCanc := " OR ( "
				cQueryVO4DTCanc += " 	VO4.VO4_DATCAN IS NULL "
				cQueryVO4DTCanc += " 	AND ( "
				cQueryVO4DTCanc += " 		VO1.VO1_DATSTA >= '" + DtoS(MV_PAR05) + "' "
				cQueryVO4DTCanc += " 		AND VO1.VO1_DATSTA <= '" + DtoS(MV_PAR06) + "' "
				cQueryVO4DTCanc += " 	) "
				cQueryVO4DTCanc += " ) "
			EndIf
	End Case

	If !Empty(MV_PAR09) .or. !Empty(MV_PAR10) // Filtro por Faturar Para
		cQueryVO3 += " AND VO3.VO3_FATPAR = '" + MV_PAR09 + "' "
		cQueryVO3 += IIf(!Empty(MV_PAR10), " AND VO3.VO3_LOJA = '" + MV_PAR10 + "' ", " ")

		cQueryVO4 += " AND VO4.VO4_FATPAR = '" + MV_PAR09 + "' "
		cQueryVO4 += IIf(!Empty(MV_PAR10), " AND VO4.VO4_LOJA = '" + MV_PAR10 + "' ", " ")
	EndIf
	If !Empty(MV_PAR15) // Filtro por Consultor de Fechamento
		cQueryVO3 += " AND VO3.VO3_FUNFEC = '" + MV_PAR15 + "' "
		cQueryVO4 += " AND VO4.VO4_FUNFEC = '" + MV_PAR15 + "' "
	EndIf
	If !Empty(MV_PAR16) // Filtro por Produtivo
		cQueryVO3 += " AND VO3.VO3_PROREQ = '" + MV_PAR16 + "' "
		cQueryVO4 += " AND VO4.VO4_CODPRO = '" + MV_PAR16 + "' "
	EndIf
	If !Empty(MV_PAR18) .or. !Empty(MV_PAR19) // Filtro por Tipo de Servico
		cQueryVO4 += " AND VO4.VO4_TIPSER >= '" + MV_PAR18 + "' "
		cQueryVO4 += " AND VO4.VO4_TIPSER <= '" + MV_PAR19 + "' "
	EndIf
	If !Empty(MV_PAR21) // Filtro por departamento interno
		cQueryVO3 += " AND VO3.VO3_DEPINT = '" + MV_PAR21 + "' "
		cQueryVO4 += " AND VO4.VO4_DEPINT = '" + MV_PAR21 + "' "
	EndIf
	If !Empty(MV_PAR22) // Filtro por departamento de garantia
		cQueryVO3 += " AND VO3.VO3_DEPGAR = '" + MV_PAR22 + "'"
		cQueryVO4 += " AND VO4.VO4_DEPGAR = '" + MV_PAR22 + "'"
	EndIf
	If !Empty(cQueryVO3) .AND. MV_PAR30 <> 3 // Criou algum filtro de Peca ...
		cQueryVO3 := SubStr(cQueryVO3, 5)
		lFilVO3VO4 := .T.
	Else
		cQueryVO3 := " "
	EndIf

	If !Empty(cQueryVO4) .AND. MV_PAR30 <> 2 // Criou algum filtro de Servico ...
		cQueryVO4 := SubStr(cQueryVO4, 5)
		lFilVO3VO4 := .T.
	Else
		cQueryVO4 := " "
	EndIf

	If !Empty(MV_PAR24) .OR. !Empty(MV_PAR25) // Filtro de Filial
		cFilDe  := MV_PAR24
		cFilAte := MV_PAR25
	Else
		cFilDe  := cFilAnt
		cFilAte := cFilAnt
	EndIf

	// Dados da Empresa
	oSection1:Init()
	oSection1:Cell("M0_NOMECOM"):SetValue(aEmp[nEmp, SM0_NOMECOM]) // Nome Comercial 
	If !Empty(SM0->M0_ENDENT)
		oSection1:Cell("M0_ENDENT"):SetValue(SM0->M0_ENDENT) 
	Endif
	If !Empty(SM0->M0_CIDENT)
		oSection1:Cell("M0_CIDENT"):SetValue(SM0->M0_CIDENT) //Cidade de Entrega
	Endif
	If !Empty(SM0->M0_ESTENT)
		oSection1:Cell("M0_ESTENT"):SetValue(SM0->M0_ESTENT) // Estado de Entrega
	Endif
	If !Empty(SM0->M0_CEPENT)
		oSection1:Cell("M0_CEPENT"):SetValue(SM0->M0_CEPENT) // CEP Entrega
	Endif
	If !Empty(SM0->M0_CODMUN)
		oSection1:Cell("M0_CODMUN"):SetValue(SM0->M0_CODMUN)
	Endif
	oSection1:PrintLine()
	oSection1:Finish()

	// Gera Planilha
	If MV_PAR26 == 2
		oExcel := FWMSEXCEL():New()
		oExcel:AddWorkSheet(STR0124)
		oExcel:AddTable(STR0124, STR0064)
		oExcel:AddColumn(STR0124, STR0064, STR0063, 1, 1) 				 // 01 - "FILIAL"
		oExcel:AddColumn(STR0124, STR0064, STR0065, 1, 1) 				 // 02 - "NRO_OS"
		if cPaisLoc $ "ARG|MEX|PAR"
			oExcel:AddColumn(STR0124, STR0064, STR0236, 1, 1) 				 // 03 - "MOEDA"
		endif
		oExcel:AddColumn(STR0124, STR0064, STR0138, 1, 1) 				 // 03/04 - "TP_ATEND"
		oExcel:AddColumn(STR0124, STR0064, STR0066, 1, 1) 				 // 04/05 - "DT_ABERT"
		oExcel:AddColumn(STR0124, STR0064, STR0067, 1, 1) 				 // 05/06 - "HR_ABERT"
		oExcel:AddColumn(STR0124, STR0064, STR0068, 1, 1) 				 // 06/07 - "CONS_ABE"
		oExcel:AddColumn(STR0124, STR0064, STR0069, 1, 2) 				 // 07/08 - "KM"
		oExcel:AddColumn(STR0124, STR0064, STR0070, 1, 1) 				 // 08/09 - "PROPRIETAR"
		oExcel:AddColumn(STR0124, STR0064, STR0071, 1, 1) 				 // 09/10 - "LOJA"
		oExcel:AddColumn(STR0124, STR0064, STR0072, 1, 1) 				 // 10/11 - "NOME_CLIEN"
		oExcel:AddColumn(STR0124, STR0064, STR0145, 1, 1) 				 // 11/12 - "CGC_CLI
		oExcel:AddColumn(STR0124, STR0064, STR0073, 1, 1) 				 // 12/13 - "ORÇAMENTO"
		oExcel:AddColumn(STR0124, STR0064, STR0074, 1, 1) 				 // 13/14 - "ENDEREÇO"
		oExcel:AddColumn(STR0124, STR0064, STR0075, 1, 1) 				 // 14/15 - "CIDADE"
		oExcel:AddColumn(STR0124, STR0064, STR0076, 1, 1) 				 // 15/16 - "UF"
		oExcel:AddColumn(STR0124, STR0064, STR0077, 1, 1) 				 // 16/17 - "TELEFONE"
		oExcel:AddColumn(STR0124, STR0064, STR0078, 1, 1) 				 // 17/18 - "MARCA"
		oExcel:AddColumn(STR0124, STR0064, STR0079, 1, 1) 				 // 18/19 - "MODELO"
		oExcel:AddColumn(STR0124, STR0064, STR0080, 1, 1) 				 // 19/20 - "FAB_MOD"
		oExcel:AddColumn(STR0124, STR0064, STR0081, 1, 1) 				 // 20/21 - "COR"
		oExcel:AddColumn(STR0124, STR0064, STR0082, 1, 1) 				 // 21/22 - "CHASSI_INT"
		oExcel:AddColumn(STR0124, STR0064, STR0083, 1, 1) 				 // 22/23 - "CHASSI"
		oExcel:AddColumn(STR0124, STR0064, STR0084, 1, 1) 				 // 23/24 - "PLACA"
		oExcel:AddColumn(STR0124, STR0064, STR0085, 1, 1) 				 // 24/25 - "COD_FROTA"
		oExcel:AddColumn(STR0124, STR0064, STR0128, 1, 1) 				 // 25/26 - "SEQ_INCON"
		oExcel:AddColumn(STR0124, STR0064, STR0129, 1, 1) 				 // 26/27 - "GRP_INCON"
		oExcel:AddColumn(STR0124, STR0064, STR0130, 1, 1) 				 // 27/28 - "COD_INCON"
		oExcel:AddColumn(STR0124, STR0064, STR0131, 1, 1) 				 // 28/29 - "DES_INCON"
		oExcel:AddColumn(STR0124, STR0064, STR0086, 1, 1) 				 // 29/30 - "TP"
		oExcel:AddColumn(STR0124, STR0064, STR0087, 1, 1) 				 // 30/31 - "LIB_VOO"
		oExcel:AddColumn(STR0124, STR0064, STR0088, 1, 1) 				 // 31/32 - "FAT_PAR"
		oExcel:AddColumn(STR0124, STR0064, STR0089, 1, 1) 				 // 32/33 - "LJ_PAR"
		oExcel:AddColumn(STR0124, STR0064, STR0090, 1, 1) 				 // 33/34 - "NOME_PAR"
		oExcel:AddColumn(STR0124, STR0064, STR0091, 1, 1) 				 // 34/35 - "DEPTO_GAR"
		oExcel:AddColumn(STR0124, STR0064, STR0092, 1, 1) 				 // 35/36 - "DEPTO_INT"
		oExcel:AddColumn(STR0124, STR0064, STR0093, 1, 1) 				 // 36/37 - "CONS_FEC"
		oExcel:AddColumn(STR0124, STR0064, STR0094, 1, 1) 				 // 37/38 - "DT_LIB"
		oExcel:AddColumn(STR0124, STR0064, STR0095, 1, 1) 				 // 38/39 - "DT_FEC"
		oExcel:AddColumn(STR0124, STR0064, STR0096, 1, 1) 				 // 39/40 - "DT_CAN"
		oExcel:AddColumn(STR0124, STR0064, STR0097, 1, 1) 				 // 40/41 - "NRO_NF"
		oExcel:AddColumn(STR0124, STR0064, STR0227, 1, 1)             	 // 41/42 - SERIE_NF
		oExcel:AddColumn(STR0124, STR0064, STR0098, 1, 1) 				 // 42/43 - "PECAS_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0099, 1, 1) 				 // 43/44 - "TPOPAD_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0100, 1, 1) 				 // 44/45 - "TPOTRA_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0101, 1, 1) 				 // 45/46 - "TPOCOB_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0102, 1, 1) 				 // 46/47 - "TPOVEN_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0103, 1, 1) 				 // 47/48 - "SERVICO_TT"
		oExcel:AddColumn(STR0124, STR0064, STR0104, 1, 1) 				 // 48/49 - "RELACAO"
		oExcel:AddColumn(STR0124, STR0064, STR0105, 1, 1) 				 // 49/50 - "GRUPO"
		oExcel:AddColumn(STR0124, STR0064, STR0106, 1, 1) 				 // 50/51 - "COD_ITEM"
		oExcel:AddColumn(STR0124, STR0064, STR0107, 1, 1) 				 // 51/52 - "DES_ITEM"
		oExcel:AddColumn(STR0124, STR0064, STR0108, 1, 2) 				 // 52/53 - "QTDADE"
		oExcel:AddColumn(STR0124, STR0064, STR0109, 1, 1) 				 // 53/54 - "PROD_REQ"
		oExcel:AddColumn(STR0124, STR0064, STR0110, 1, 1) 				 // 54/55 - "FORMULA"
		oExcel:AddColumn(STR0124, STR0064, STR0111, 1, 1) 				 // 55/56 - "VLR_UNIT"
		oExcel:AddColumn(STR0124, STR0064, STR0112, 1, 1) 				 // 56/57 - "VLR_TOTAL"
		oExcel:AddColumn(STR0124, STR0064, STR0113, 1, 1) 				 // 57/58 - "TIPO_SRV"
		oExcel:AddColumn(STR0124, STR0064, STR0114, 1, 1) 				 // 58/59 - "GRUPO_SRV"
		oExcel:AddColumn(STR0124, STR0064, STR0115, 1, 1) 				 // 59/60 - "COD_SRV"
		oExcel:AddColumn(STR0124, STR0064, STR0116, 1, 1) 				 // 60/61 - "DES_SRV"
		oExcel:AddColumn(STR0124, STR0064, STR0117, 1, 1) 				 // 61/62 - "PRODUTIVO"
		oExcel:AddColumn(STR0124, STR0064, STR0118, 1, 1) 				 // 62/63 - "NOME_PROD"
		oExcel:AddColumn(STR0124, STR0064, STR0119, 1, 1) 				 // 63/64 - "TPOPAD"
		oExcel:AddColumn(STR0124, STR0064, STR0120, 1, 1) 				 // 64/65 - "TPOTRA"
		oExcel:AddColumn(STR0124, STR0064, STR0121, 1, 1) 				 // 65/66 - "TPOCOB"
		oExcel:AddColumn(STR0124, STR0064, STR0122, 1, 1) 				 // 66/67 - "TPOVEN"
		oExcel:AddColumn(STR0124, STR0064, STR0123, 1, 1) 				 // 67/68 - "SERVIÇO"
		oExcel:AddColumn(STR0124, STR0064, RetTitle("VO4_KILROD"), 1, 2) // 68/69 - KM Rodado
		oExcel:AddColumn(STR0124, STR0064, STR0225, 1, 1) 			 	 // 69/70 - Ori/Par
		oExcel:AddColumn(STR0124, STR0064, STR0179, 1, 1) 			 	 // 70/71 - Status
	EndIf

	For nCntFil := 1 to Len(aSM0)
		// Filtro de Filial
		If !(aSM0[nCntFil, 1] == cEmpAnt .and. (aSM0[nCntFil, 2] >= cFilDe .and. aSM0[nCntFil, 2] <= cFilAte))
			Loop
		EndIf

		nMoedaAtua := 0
		aResSitTpo := {}
		aResTipTem := {}
		aResDepto := {} 
		aResTipSer := {}
	
		// Altera filial corrente...
		cFilAnt := aSM0[nCntFil, 2]
		nPassagens += FMX_OFIPASS(MV_PAR05, MV_PAR06, .F.)[1, 2]

		cFilSA1 := FWxFilial("SA1")
		cFilSB1 := FWxFilial("SB1")
		cFilVOK := FWxFilial("VOK")
		cFilSX5 := FWxFilial("SX5")
		cFilVOI := FWxFilial("VOI")
		cFilVOD := FWxFilial("VOD")
		cFilVV8 := FWxFilial("VV8")
		cFilVS1 := FWxFilial("VS1")
		cFilVE1 := FWxFilial("VE1")

		cQuery := " SELECT "
		cQuery += "		* "
		cQuery += " FROM ( "
		cQuery += " 	SELECT "
		cQuery += "			VO1.VO1_FILIAL, "
		if cPaisLoc $ "ARG|MEX|PAR"
			cQuery += "			CASE VO1.VO1_MOEDA WHEN 0 THEN 1 ELSE VO1.VO1_MOEDA END VO1_MOEDA, "
			cQuery += "			VO1.VO1_TXMOED, "
		endif
		cQuery += "			VO1.VO1_NUMOSV, "
		cQuery += "			VO1.VO1_TPATEN, "
		cQuery += "			VO1.VO1_PROVEI, "
		cQuery += "			VO1.VO1_LOJPRO, "
		cQuery += "			VO1.VO1_DATABE, "
		cQuery += "			VO1.VO1_FUNABE, "
		cQuery += "			VO1.VO1_HORABE, "
		cQuery += "			VO1.VO1_NUMORC, "
		cQuery += "			VO1.VO1_KILOME, "
		cQuery += "			VO1.VO1_NUMAGE, "
		cQuery += "			VO1.R_E_C_N_O_ RECVO1, "
		cQuery += " 		COUNT(VO2.VO2_NOSNUM) COUNTVO2, "
		cQuery += " 		SA1.A1_NOME, "
		cQuery += "			SA1.A1_TEL, "
		cQuery += "			SA1.A1_END, "
		cQuery += "			SA1.A1_CGC, "
		cQuery += " 		SA1.A1_PESSOA, "
		If lA1_IBGE
			cQuery += " 	VAM.VAM_DESCID, "
			cQuery += " 	VAM.VAM_ESTADO, "
			cQuery += " 	VAM.R_E_C_N_O_ RECVAM, "
		Else
			cQuery += " 	SA1.A1_MUN, "
			cQuery += " 	SA1.A1_EST, "
		EndIf
		cQuery += " 		SA1.R_E_C_N_O_ RECSA1, "
		cQuery += " 		VV1.VV1_CODMAR, "
		cQuery += " 		VV1.VV1_MODVEI, "
		cQuery += " 		VV1.VV1_CHAINT, "
		cQuery += " 		VV1.VV1_FABMOD, "
		cQuery += " 		VV1.VV1_CHASSI, "
		cQuery += " 		VV1.VV1_PLAVEI, "
		cQuery += " 		VV1.VV1_CODFRO, "
		cQuery += " 		VV1.VV1_PROATU, "
		cQuery += " 		VV1.VV1_LJPATU, "
		cQuery += " 		VV1.R_E_C_N_O_ RECVV1, "
		cQuery += " 		VV2.VV2_DESMOD, "
		cQuery += " 		VV2.VV2_TIPVEI, "
		cQuery += " 		VV2.R_E_C_N_O_ RECVV2, "
		cQuery += " 		VVC.VVC_DESCRI, "
		cQuery += " 		VVC.R_E_C_N_O_ RECVVC, "
		/* If MV_PAR28 == 2 .AND. MV_PAR26 == 2 // Causa Duplicação na Impressão. Só era utilizado na impressão da planilha, desta forma, a consulta é feita somente no preenchimento da planilha
			cQuery += " 	VST.VST_CODIGO, "
			cQuery += " 	VST.VST_SEQINC, "
			cQuery += " 	VST.VST_GRUINC, "
			cQuery += " 	VST.VST_CODINC, "
			cQuery += " 	VST.VST_DESINC, "
		Endif */
		If MV_PAR04 == 4 // Considera pela data de Cancelamento
			cQuery += " 	VO3.VO3_DATCAN, "
			cQuery += " 	VO4.VO4_DATCAN, "
		EndIf
		If lVO1DATSTA
			cQuery += "		VO1.VO1_DATSTA, "
		EndIf
		cQuery += " 		VO1.VO1_STATUS "
		cQuery += " 	FROM "
		cQuery += " 		" + RetSQLName("VO1") + " VO1 "
		cQuery += " 		LEFT JOIN " + RetSQLName("SA1") + " SA1 "
		cQuery += "			ON "
		cQuery += "				SA1.A1_FILIAL = '" + xFilial("SA1") + "' "
		cQuery += "				AND SA1.A1_COD = VO1.VO1_PROVEI "
		cQuery += "				AND SA1.A1_LOJA = VO1.VO1_LOJPRO "
		cQuery += "				AND SA1.D_E_L_E_T_ = ' ' "
		If lA1_IBGE
			cQuery += "		LEFT JOIN " + RetSQLName("VAM") + " VAM "
			cQuery += "		ON "
			cQuery += "			VAM.VAM_FILIAL = '" + xFilial("VAM") + "' "
			cQuery += "			AND VAM.VAM_IBGE = SA1.A1_IBGE "
			cQuery += "			AND VAM.D_E_L_E_T_ = ' ' "
		EndIf
		cQuery += " 		LEFT JOIN " + RetSqlName("VV1") + " VV1 "
		cQuery += "			ON "
		cQuery += "				VV1.VV1_FILIAL = '" + xFilial("VV1") + "' "
		cQuery += "				AND VV1.VV1_CHAINT = VO1.VO1_CHAINT "
		cQuery += "				AND VV1.D_E_L_E_T_ = ' ' "
		cQuery += " 		LEFT JOIN " + RetSqlName("VV2") + " VV2 "
		cQuery += "			ON "
		cQuery += "				VV2.VV2_FILIAL = '" + xFilial("VV2") + "' "
		cQuery += "				AND VV2.VV2_CODMAR = VV1.VV1_CODMAR "
		cQuery += "				AND VV2.VV2_MODVEI = VV1.VV1_MODVEI "
		cQuery += "				AND VV2.VV2_SEGMOD = VV1.VV1_SEGMOD "
		cQuery += "				AND VV2.D_E_L_E_T_ = ' ' "
		cQuery += " 		LEFT JOIN " + RetSqlName("VVC") + " VVC "
		cQuery += "			ON "
		cQuery += "				VVC.VVC_FILIAL = '" + xFilial("VVC") + "' "
		cQuery += "				AND VVC.VVC_CODMAR = VV1.VV1_CODMAR "
		cQuery += "				AND VVC.VVC_CORVEI = VV1.VV1_CORVEI "
		cQuery += "				AND VVC.D_E_L_E_T_ = ' ' "
		If MV_PAR20 == 2 .AND. (MV_PAR04 == 1 .OR. (MV_PAR04 == 4 .AND. lVO1DATSTA)) // Lista OS Sem Requisicao e (Filtra Data de Abertura ou Data de Cancelamento e Existe o Campo VO1_DATSTA)
			cQuery += "		LEFT "
		EndIf
		cQuery += " 		JOIN " + RetSqlName("VO2") + " VO2 "
		cQuery += "			ON "
		cQuery += "				VO2.VO2_FILIAL = '" + xFilial("VO2") + "' "
		cQuery += "				AND VO2.VO2_NUMOSV = VO1.VO1_NUMOSV "
		cQuery += "				AND VO2.D_E_L_E_T_ = ' ' "
		If lFilVO3VO4 .OR. (MV_PAR28 == 2 .AND. MV_PAR26 == 2) // Utiliza requisicao de peca/servico para filtrar...
			cQuery += " 	LEFT JOIN " + RetSqlName("VO3") + " VO3 "
			cQuery += "		ON "
			cQuery += "			VO3.VO3_FILIAL = '" + xFilial("VO3") + "' "
			cQuery += "			AND VO2.VO2_TIPREQ = 'P' "
			cQuery += "			AND VO3.VO3_NOSNUM = VO2.VO2_NOSNUM "
			cQuery += "			AND VO3.D_E_L_E_T_ = ' ' "
			cQuery += " 	LEFT JOIN " + RetSqlName("VO4") + " VO4 "
			cQuery += "		ON "
			cQuery += "			VO4.VO4_FILIAL = '" + xFilial("VO4") + "' "
			cQuery += "			AND VO2.VO2_TIPREQ = 'S' "
			cQuery += "			AND VO4.VO4_NOSNUM = VO2.VO2_NOSNUM "
			cQuery += "			AND VO4.D_E_L_E_T_ = ' ' "
		EndIf
		/*IF MV_PAR28 == 2 .AND. MV_PAR26 == 2 // Causa Duplicação na Impressão. Só era utilizado na impressão da planilha, desta forma, a consulta é feita somente no preenchimento da planilha
			cQuery += " 	LEFT JOIN " + RetSqlName("VST") + " VST "
			cQuery += "		ON "
			cQuery += "			VST.VST_FILIAL = '" + xFilial("VO3") + "' "
			cQuery += "			AND VO1.VO1_NUMOSV = VST.VST_CODIGO "
			cQuery += "			AND (VO4.VO4_SEQINC = VST.VST_SEQINC "
			cQuery += "				OR VO3.VO3_SEQINC = VST.VST_SEQINC) "
			cQuery += "			AND VST.D_E_L_E_T_ = ' ' "
		Endif*/
		cQuery += " 	WHERE "
		cQuery += " 		VO1.VO1_FILIAL = '" + xFilial("VO1") + "' "
		If !Empty(MV_PAR07)
			cQuery += " 	AND VO1.VO1_NUMOSV >= '" + MV_PAR07 + "' "
		EndIf
		If !Empty(MV_PAR08)
			cQuery += " 	AND VO1.VO1_NUMOSV <= '" + MV_PAR08 + "' "
		EndIf
		If MV_PAR04 == 1 // Considera pela data de Abertura
			cQuery += " 	AND VO1.VO1_DATABE >= '" + DtoS(MV_PAR05) + "' "
			cQuery += "		AND VO1.VO1_DATABE <= '" + DtoS(MV_PAR06) + "' "
		EndIf
		If !Empty(MV_PAR13)
			cQuery += " 	AND VO1.VO1_CHAINT = '" + MV_PAR13 + "' "
		EndIf
		If !Empty(MV_PAR14)
			cQuery += " 	AND VO1.VO1_FUNABE = '" + MV_PAR14 + "' "
		EndIf
		If !Empty(MV_PAR29)
			cQuery += " 	AND VO1.VO1_TPATEN = '" + MV_PAR29 + "' "
		EndIf
		If MV_PAR31 == 2 // Verifica status da O.S.
			cQuery += " 	AND VO1.VO1_STATUS = 'A' "
		Elseif MV_PAR31 == 3
			cQuery += " 	AND VO1.VO1_STATUS = 'D' "
		Elseif MV_PAR31 == 4
			cQuery += " 	AND VO1.VO1_STATUS = 'F' "
		Elseif MV_PAR31 == 5
			cQuery += " 	AND VO1.VO1_STATUS = 'C' "
		EndIf
		cQuery += " 		AND VO1.D_E_L_E_T_ = ' ' "		
		If !Empty(MV_PAR11) // Filtro por Marca de Veiculo
			cQuery += " 	AND VV1.VV1_CODMAR = '" + MV_PAR11 + "' "
		EndIf
		If !Empty(MV_PAR12) // Filtro por Modelo do Veiculo
			cQuery += " 	AND VV1.VV1_MODVEI = '" + MV_PAR12 + "' "
		EndIf
		If lFilVO3VO4 // Utiliza requisicao de peca/servico para filtrar ...
			cQuery += " 	AND ( "
			if !Empty(cQueryVO3) //  Filtro de Pecas
				cQuery += " 	(VO2.VO2_TIPREQ = 'P' "
				cQuery += "		AND " + cQueryVO3 + ") "
				cQuery += "     " + IIf(!Empty(cQueryVO4)," OR", "") + " "
			Endif
			if !Empty(cQueryVO4) //  Filtro de Servicos
				cQuery += " 	( "
				cQuery += "			(VO2.VO2_TIPREQ = 'S' "
				cQuery += " 		AND " + cQueryVO4 + ") "
				If !Empty(cQueryVO4DTCanc)
					cQuery += cQueryVO4DTCanc + " "
				EndIf
				cQuery += " 	) "
			Endif
			If MV_PAR20 == 2 .AND. MV_PAR04 == 1 // Lista OS's sem requisicao
				cQuery += " 	OR ( "
				cQuery += "			VO2.VO2_FILIAL IS NULL "
				///////////////////////////////////////////////////////////////////////////
				// ATENCAO: Quando NAO existir Requisicoes para a OS e o usuario filtrou //
				// um Tipo de Tempo especifico, a rotina deverá verificar o Status da OS //
				//                                                                       //
				// Exemplo: Se o usuario filtrar somente o Tipo de Tempo "Disponivel"    //
				//          NÂO serão listadas as OS sem requisição que estao com Status //
				//          de OS Cancelada                                              //
				///////////////////////////////////////////////////////////////////////////
				Do Case
					Case MV_PAR02 == 2 // Tipo de Tempo Aberto
						cQuery += " AND VO1.VO1_STATUS = 'A' "
					Case MV_PAR02 == 3 // Tipo de Tempo Liberado
						cQuery += " AND VO1.VO1_STATUS = 'D' "
				EndCase
				cQuery += " 	) "
			EndIf
			cQuery += " 	) "
		EndIf
		cQuery += " 	GROUP BY "
		cQuery += " 		VO1.VO1_FILIAL, "
		if cPaisLoc $ "ARG|MEX|PAR"
			cQuery += "			VO1.VO1_MOEDA, "
			cQuery += "			VO1.VO1_TXMOED, "
		endif
		cQuery += " 		VO1.VO1_NUMOSV, "
		cQuery += " 		VO1.VO1_TPATEN, "
		cQuery += " 		VO1.VO1_PROVEI, "
		cQuery += " 		VO1.VO1_LOJPRO, "
		cQuery += " 		VO1.VO1_DATABE, "
		cQuery += " 		VO1.VO1_FUNABE, "
		cQuery += " 		VO1.VO1_HORABE, "
		cQuery += " 		VO1.VO1_NUMORC, "
		cQuery += " 		VO1.VO1_KILOME, "
		cQuery += " 		VO1.VO1_NUMAGE, "
		cQuery += " 		VO1.R_E_C_N_O_, "
		cQuery += " 		SA1.A1_NOME, "
		cQuery += " 		SA1.A1_TEL, "
		cQuery += " 		SA1.A1_END, "
		cQuery += " 		SA1.A1_CGC, "
		cQuery += " 		SA1.A1_PESSOA, "
		If lA1_IBGE
			cQuery += " 	VAM.VAM_DESCID, "
			cQuery += " 	VAM.VAM_ESTADO, "
			cQuery += " 	VAM.R_E_C_N_O_, "
		Else
			cQuery += " 	SA1.A1_MUN, "
			cQuery += " 	SA1.A1_EST, "
		EndIf
		cQuery += " 		SA1.R_E_C_N_O_, "
		cQuery += " 		VV1.VV1_CODMAR, "
		cQuery += " 		VV1.VV1_MODVEI, "
		cQuery += " 		VV1.VV1_CHAINT, "
		cQuery += " 		VV1.VV1_FABMOD, "
		cQuery += " 		VV1.VV1_CHASSI, "
		cQuery += " 		VV1.VV1_PLAVEI, " 
		cQuery += " 		VV1.VV1_CODFRO, "
		cQuery += " 		VV1.VV1_PROATU, " 
		cQuery += " 		VV1.VV1_LJPATU, "
		cQuery += " 		VV1.R_E_C_N_O_, "
		cQuery += " 		VV2.VV2_DESMOD, "
		cQuery += " 		VV2.VV2_TIPVEI, "
		cQuery += " 		VV2.R_E_C_N_O_, "
		cQuery += " 		VVC.VVC_DESCRI, "
		cQuery += " 		VVC.R_E_C_N_O_, "
		// If MV_PAR28 == 2 .AND. MV_PAR26 == 2 // Causa Duplicação na Impressão. Só era utilizado na impressão da planilha, desta forma, a consulta é feita somente no preenchimento da planilha
		// 	cQuery += "		VST.VST_CODIGO, "
		// 	cQuery += "		VST.VST_SEQINC, "
		// 	cQuery += "		VST.VST_GRUINC, "
		// 	cQuery += " 	VST.VST_CODINC, "
		// 	cQuery += " 	VST.VST_DESINC, "
		// Endif
		If MV_PAR04 == 4 // Considera pela data de Cancelamento
			cQuery += " 	VO3.VO3_DATCAN, "
			cQuery += " 	VO4.VO4_DATCAN, "
		EndIf
		If lVO1DATSTA
			cQuery += " 	VO1.VO1_DATSTA, "
		EndIf
		cQuery += "			VO1.VO1_STATUS "
		cQuery += " 	) TMP"
		If MV_PAR04 == 4 // Considera pela data de Cancelamento
			cQuery += " WHERE "
			cQuery += " 	TMP.VO3_DATCAN IS NOT NULL "
			cQuery += " 	OR TMP.VO4_DATCAN IS NOT NULL "
			If lVO1DATSTA
				cQuery += " OR ( "
				cQuery += " 	TMP.VO1_DATSTA >= '" + DtoS(MV_PAR05) + "' "
				cQuery += " 	AND TMP.VO1_DATSTA <= '" + DtoS(MV_PAR06) + "' "
				cQuery += " ) "
			EndIf
		EndIf
		cQuery += " ORDER BY "
		if cPaisLoc $ "ARG|MEX|PAR"
			cQuery += "		TMP.VO1_MOEDA, "
		endif
		cQuery += "		TMP.VO1_NUMOSV "
		TcQuery cQuery New Alias "QRYOS"

		While !QRYOS->(Eof())

			if cPaisLoc $ "ARG|MEX|PAR"
				if !Empty(nMoedaAtua) .and. nMoedaAtua != QRYOS->VO1_MOEDA
					ImpResumos(oReport, nMoedaAtua, aResSitTpo, aResTipTem, aResDepto, aResTipSer, nPassagens)
					nMoedaAtua := QRYOS->VO1_MOEDA
					aResSitTpo := {}
					aResTipTem := {}
					aResDepto := {}
					aResTipSer := {}
				elseif Empty(nMoedaAtua)
					nMoedaAtua := QRYOS->VO1_MOEDA
				endif
			endif

			VO1->(DbGoTo(QRYOS->RECVO1))
			SA1->(DbGoTo(QRYOS->RECSA1))
			VV1->(DbGoTo(QRYOS->RECVV1))
			VV2->(DbGoTo(QRYOS->RECVV2))
			VVC->(DbGoTo(QRYOS->RECVVC))
			VE1->(DbSeek(cFilVE1+QRYOS->VV1_CODMAR))

			If lA1_IBGE
				VAM->(DbGoTo(QRYOS->RECVAM))
			EndIf

			// Valida Segmento do Cliente
			If !Empty(MV_PAR23)
				cQuery := " SELECT "
				cQuery += " 	A1_SATIV1"
				cQuery += " FROM "
				cQuery += " 	" + RetSqlName("SA1") + " "
				cQuery += " WHERE "
				cQuery += " 	A1_FILIAL = '" + cFilSA1 + "' "
				If !Empty(QRYOS->VV1_PROATU)
					cQuery += " AND A1_COD = '" + QRYOS->VV1_PROATU + "' "
					cQuery += " AND A1_LOJA = '" + QRYOS->VV1_LJPATU + "' "
				Else
					cQuery += " AND A1_COD = '" + QRYOS->VO1_PROVEI + "' "
					cQuery += " AND A1_LOJA = '" + QRYOS->VO1_LOJPRO + "' "
				Endif
				cQuery += " 	AND D_E_L_E_T_ = ' ' "

				If FM_SQL(cQuery) != MV_PAR23
					QRYOS->(dbSkip())
					Loop
				Endif
			EndIf

			If MV_PAR20 == 1
				lReqZerada := .T.
			Else
				lReqZerada := .F.
			endif

			If MV_PAR32 == 2 // Verifica se OS tem Agendamento 
				If Empty(QRYOS->VO1_NUMAGE)
					cQuery := " SELECT "
					cQuery += "		VS1_NUMAGE "
					cQuery += " FROM "
					cQuery += " 	" + RetSqlName("VS1") + " "
					cQuery += " WHERE "
					cQuery += "		VS1_FILIAL = '" + cFilVS1 + "' "
					cQuery += " 	AND VS1_NUMOSV = '" + QRYOS->VO1_NUMOSV + "' "
					cQuery += " 	AND D_E_L_E_T_ = ' ' "
					If Empty(FM_SQL(cQuery))
						QRYOS->(dbSkip())
						Loop
					EndIf
				EndIf
			Endif

			aCalPeca := {}
			aCalSrvc := {}

			If MV_PAR30 <> 3 // Levanta as peças somente se o parametro for diferente de SO SERVICOS
				aCalPeca :=;
					FMX_CALPEC(;
						QRYOS->VO1_NUMOSV,; // cNumOS
	 					,;            		// cTipTem
	 					,;            		// cGruIte
	 					,;            		// cCodIte
	 					.T.,;        		// lMov
	 					.T.,;        		// lNegoc
	 					lReqZerada,; 		// lReqZerada
	 					.T.,;        		// lRetAbe
	 					.T.,;        		// lRetLib
	 					.T.,;        		// lRetFec
	 					.T.,;        		// lRetCan
	 					,;            		// cLibVOO
	 					cQueryVO3;    		// cFiltroSQL
					)
			EndIf

			If MV_PAR30 <> 2 // Levanta os servicos somente se o parametro for diferente de SO PECAS
				aCalSrvc :=;
					FMX_CALSER(;
						QRYOS->VO1_NUMOSV,; // cNumOS
						,;            		// cTipTem
						,;           		// cGruSer
						,;           		// cCodSer
						.T.,;        		// lApont
						.T.,;        		// lNegoc
						.T.,;        		// lRetAbe
						.T.,;        		// lRetLib
						.T.,;        		// lRetFec
						.T.,;        		// lRetCan
						,;           		// cLibVOO
						cQueryVO4;   		// cFiltroSQL
				)
			EndIf

			If MV_PAR20 == 1 .and. Len(aCalPeca) == 0 .and. Len(aCalSrvc) == 0 // Nao lista OS sem Requisicao
				QRYOS->(dbSkip())
				Loop
			Endif

			If MV_PAR03 <> 1 // Impressao diferente de resumida
				VV8->(DbSeek(cFilVV8+QRYOS->(VV2_TIPVEI)))
				cDesModFab := IIf( VV8->(FieldPos("VV8_TPVFAB")) > 0 , OFIOA560DS("053",VV8->VV8_TPVFAB) , Space(nTamVV2TipVei) ) // Tipo de Veículo - EDI
				If !lFirstS5
					For nCntFor := 1 to 3
						oReport:IncRow()
					Next
				Endif
				oSection5:Init()
				oSection5:Cell("COD_FILIAL"):SetValue(QRYOS->VO1_FILIAL)
				If lVO1DATSTA
					oSection5:Cell("VO1_STATUS"):SetValue(X3CBOXDESC("VO1_STATUS", QRYOS->VO1_STATUS) + " - " + Dtoc(Stod(QRYOS->VO1_DATSTA)))
				Else
					oSection5:Cell("VO1_STATUS"):SetValue(X3CBOXDESC("VO1_STATUS", QRYOS->VO1_STATUS))
				Endif
				
				if cPaisLoc $ "ARG|MEX|PAR"
					oSection5:Cell("A1_CGC"):SetValue(Transform(SA1->A1_CGC, PesqPict("SA1", "A1_CGC")))
				else
					oSection5:Cell("A1_CGC"):SetValue(Transform(SA1->A1_CGC, IIF(QRYOS->A1_PESSOA == 'J', "@!R NN.NNN.NNN/NNNN-99", "@R 999.999.999-99")))
				endif
				
				oSection5:Cell("VE1_CODMAR"):SetValue(QRYOS->VV1_CODMAR)
				oSection5:Cell("VE1_DESMAR"):SetValue(cDesModFab)
				oSection5:PrintLine()
				oSection5:Finish()
				lFirstS5 := .F.
			EndIf

			SA1->(DbSetOrder(1))
			VOI->(dbSetOrder(1))

			aAuxTT := {}
			For nI := 1 to Len(aCalPeca)
				If aScan(aAuxTT, {|y| y[1] == aCalPeca[nI, 3] .and. y[2] == aCalPeca[nI, 25]}) == 0
					SA1->(DbSeek(cFilSA1+aCalPeca[nI, 15]+aCalPeca[nI, 16]))
					VOI->(DbSeek(cFilVOI+aCalPeca[nI, 3]))

					AADD(aAuxTT, {;
						aCalPeca[nI, 3],;							// 01 - Tipo de Tempo
						aCalPeca[nI, 25],;							// 02 - Numero da Liberacao do TT (VOO_LIBVOO)
						aCalPeca[nI, 15],;							// 03 - Cliente Faturar Para
						aCalPeca[nI, 16],;							// 04 - Loja Faturar Para
						"",;										// 05 - Produtivo que fechou o TT
						"",;										// 06 - Numero da Nota Fiscal
						"",;										// 07 - Série da Nota Fiscal
						0,;											// 08 - Total de Pecas
						0,;											// 09 - Tempo Padrao
						0,;											// 10 - Tempo Trabalhado
						0,;											// 11 - Tempo Cobrado
						0,;											// 12 - Tempo Vendido
						0,;											// 13 - Total Servicos
						"",;										// 14 - Departamento Interno
						"",;										// 15 - Departamento Garantia
						aCalPeca[nI, 17],;							// 16 - Data de Liberacao
						aCalPeca[nI, 19],;							// 17 - Data de Fechamento
						aCalPeca[nI, 18],;							// 18 - Data de Cancelamento
						0,;											// 19 - Total de qtde de Pecas
						SA1->A1_NOME,;								// 20 - Nome do Cliente Faturar Para
						X3CBOXDESC("VOI_SITTPO", VOI->VOI_SITTPO)}; // 21 - Situação do Tipo de Tempo
					)
				EndIf
			Next

			For nI := 1 to Len(aCalSrvc)
				If aScan(aAuxTT, {|y| y[1] == aCalSrvc[nI, 4] .AND. y[2] == aCalSrvc[nI, 38]}) == 0
					SA1->(DbSeek(cFilSA1+aCalSrvc[nI, 20]+aCalSrvc[nI, 21]))
					VOI->(DbSeek(cFilVOI+aCalSrvc[nI, 4]))

					AADD(aAuxTT, {;
						aCalSrvc[nI, 4],;							// 01 - Tipo de Tempo
						aCalSrvc[nI, 38],;							// 02 - Numero da Liberacao do TT (VOO_LIBVOO)
						aCalSrvc[nI, 20],;							// 03 - Cliente Faturar Para
						aCalSrvc[nI, 21],;							// 04 - Loja Faturar Para
						"",;										// 05 - Produtivo que fechou o TT
						"",;										// 06 - Numero da Nota Fiscal
						"",;										// 07 - Serie da NF
						0,;											// 08 - Total de Pecas
						0,;											// 09 - Tempo Padrao
						0,;											// 10 - Tempo Trabalhado
						0,;											// 11 - Tempo Cobrado
						0,;											// 12 - Tempo Vendido
						0,;											// 13 - Total Servicos
						"",;										// 14 - Departamento Interno
						"",;										// 15 - Departamento Garantia
						aCalSrvc[nI, 22],;							// 16 - Data de Liberacao
						aCalSrvc[nI, 24],;							// 17 - Data de Fechamento
						aCalSrvc[nI, 23],;							// 18 - Data de Cancelamento
						0,;											// 19 - Total de qtde de Pecas
						SA1->A1_NOME,;								// 20 - Nome do Cliente Faturar Para
						X3CBOXDESC("VOI_SITTPO", VOI->VOI_SITTPO)}; // 21 - Situação do Tipo de Tempo
					)
				EndIf
			Next

			// Ordena por tipo de tempo e liberacao da VOO
			aSort(aAuxTT,,, {|x, y| x[ATT_TIPTEM] + x[ATT_LIBVOO] < y[ATT_TIPTEM] + y[ATT_LIBVOO]})

			If MV_PAR26 == 2 .and. Len(aAuxTT) == 0 // Gera Planilha, se nao houver requisicao, cria uma linha so com informacoes da OS
				OR450APPEND(0)
			EndIf

			// Processa Tipo de Tempo ...
			cProcTIPSER := " "
			For nContTT := 1 to Len(aAuxTT)
				aAuxLinPeca := {}
				aAuxLinSrvc := {}
				SB1->(DbSetOrder(7))
				VOK->(DbSetOrder(1))
				VOI->(DbSetOrder(1))
				VOI->(DbSeek(cFilVOI+aAuxTT[nContTT, ATT_TIPTEM]))

				For nCont := 1 to Len(aCalPeca) // Processa Requisicao de Pecas
					If !(aCalPeca[nCont, 3] == aAuxTT[nContTT, ATT_TIPTEM] .AND. aCalPeca[nCont, 25] == aAuxTT[nContTT, ATT_LIBVOO]) // Compara tipo de tempo e liberacao do VOO
						Loop
					EndIf
					If aCalPeca[nCont, 05] == 0 // Se a quantidade for maior que 0 não considera o item
						Loop
					EndIf

					VO3->(DbGoTo(aCalPeca[nCont, 14, 01, 05]))
					SB1->(DbSeek(cFilSB1+aCalPeca[nCont, 01]+aCalPeca[nCont, 02]))
					SBM->(DbSetOrder(1))
					SBM->(DbSeek(xFilial("SBM")+aCalPeca[nCont, 01]))
					if SBM->BM_PROORI == "1"
						cParOri := STR0151 // "Original"
					Else
						cParOri := STR0152 // "Paralelo"
					Endif
					aAuxTT[nContTT, ATT_PRODUTIVO] := VO3->VO3_FUNFEC
					aAuxTT[nContTT, ATT_NUMNFI]    := VO3->VO3_NUMNFI
					aAuxTT[nContTT, ATT_SERNFI]	   := VO3->VO3_SERNFI
					aAuxTT[nContTT, ATT_DEPINT]    := VO3->VO3_DEPINT
					aAuxTT[nContTT, ATT_DEPGAR]    := VO3->VO3_DEPGAR
					aAuxTT[nContTT, ATT_QTDPECA]   += aCalPeca[nCont, 05]
					aAuxTT[nContTT, ATT_TOTPECA]   += aCalPeca[nCont, 10] - aCalPeca[nCont, 07]

					// Impressao analitica
					If MV_PAR03 == 3
						AADD(aAuxLinPeca, {;
							VO3->VO3_NOSNUM,;							// 01 - Numero da Requisicao
							aCalPeca[nCont, 01],;						// 02 - Grupo da Peca
							aCalPeca[nCont, 02],;						// 03 - Codigo da Peca
							SB1->B1_DESC,;								// 04 - Descricao da Peca
							aCalPeca[nCont, 05],;						// 05 - Quantidade
							VO3->VO3_PROREQ,;							// 06 - Produtivo que Requisitou
							aCalPeca[nCont, 27],;						// 07 - Formula
							aCalPeca[nCont, 09] - (aCalPeca[nCont, 07] / aCalPeca[nCont, 05]),;	// 08 - Valor Unitario
							aCalPeca[nCont, 10] - aCalPeca[nCont, 07],;	// 09 - Valor Total
							cParOri};  									// 10 - Original ou paralelo
						)
					EndIf
				Next
				
				For nCont := 1 to Len(aCalSrvc) // Processa Requisicao de Servicos
					// Compara tipo de tempo e liberacao do VOO
					If !(aCalSrvc[nCont, 4] == aAuxTT[nContTT, ATT_TIPTEM] .and. aCalSrvc[nCont, 38] == aAuxTT[nContTT, ATT_LIBVOO])
						Loop
					EndIf

					VO4->(DbGoTo(aCalSrvc[nCont, 14, 01, 08]))
					aAuxTT[nContTT, ATT_PRODUTIVO] := VO4->VO4_FUNFEC
					aAuxTT[nContTT, ATT_NUMNFI]    := VO4->VO4_NUMNFI
					aAuxTT[nContTT, ATT_SERNFI]    := VO4->VO4_SERNFI
					aAuxTT[nContTT, ATT_DEPINT]    := VO4->VO4_DEPINT
					aAuxTT[nContTT, ATT_DEPGAR]    := VO4->VO4_DEPGAR
					aAuxTT[nContTT, ATT_TEMPAD]    += aCalSrvc[nCont, 10]	// [08] - Tempo Padrao
					aAuxTT[nContTT, ATT_TEMTRA]    += aCalSrvc[nCont, 11]	// [09] - Tempo Trabalhado
					
					lConsVenda := (VOI->VOI_SITTPO <> "3" .OR. (VOI->VOI_SITTPO == "3" .AND. MV_PAR17 == 2))
					If lConsVenda // Nao é TT interno ou é interno deve exibir valores (MV_PAR17)
						nAuxTemCob := aCalSrvc[nCont, 12]
						nAuxTemVen := aCalSrvc[nCont, 13]
						aAuxTT[nContTT, ATT_TOTSRVC] += aCalSrvc[nCont, 09]	// [12] - Total Servicos
					Else
						nAuxTemCob := 0
						nAuxTemVen := 0
					Endif

					aAuxTT[nContTT, ATT_TEMCOB] += nAuxTemCob				// [10] - Tempo Cobrado
					aAuxTT[nContTT, ATT_TEMVEN] += nAuxTemVen				// [11] - Tempo Vendido

					VOD->(DbSetOrder(1))
					If MV_PAR03 == 3 // Impressao analitica
						// Totaliza por apontamento
						aAuxApon      := {}
						nAuxTemTra    := 0
						nTemCobApo    := 0
						nTemVenApo    := 0
						nAuxValorSrvc := 0
						cAuxProdutivo := aCalSrvc[nCont, 14, 01, 01]
						lPrimLinha    := .T.

						For nContApon := 1 to Len(aCalSrvc[nCont, 14])
							nAuxTemTra += aCalSrvc[nCont, 14, nContApon, 06]					// Tempo Trabalhado
							If lConsVenda // Nao é TT interno ou é interno deve exibir valores (MV_PAR17)
								If aCalSrvc[nCont, 6] == "2"
									nAuxValorSrvc := aCalSrvc[nCont, 14, nContApon, 10]
								Else
									VOK->(DbSeek(cFilVOK+aCalSrvc[nCont, 05]))									
									If Empty(aCalSrvc[nCont, 24]) .AND. VOK->VOK_INCTEM <> "3"	// Se nao estiver faturado, exibe o valor total do servico
										// nAuxValorSrvc := aCalSrvc[nCont,09]
										nAuxValorSrvc += aCalSrvc[nCont, 14, nContApon, 10]		// Valor do Servico
									EndIf
									If !Empty(aCalSrvc[nCont, 24]) .OR. VOK->VOK_INCTEM == "3"  // Se estiver faturado, exibe o valor por apontamento
										nAuxValorSrvc += aCalSrvc[nCont, 14, nContApon, 10]		// Valor do Servico
									EndIf
									nTemCobApo += aCalSrvc[nCont, 14, nContApon, 13]			// Tempo Cobrado
									nTemVenApo += aCalSrvc[nCont, 14, nContApon, 27]			// Tempo Vendido
								EndIf
							EndIf
							
							If (nContApon == Len(aCalSrvc[nCont, 14]) .OR. cAuxProdutivo <> aCalSrvc[nCont, 14, (nContApon + 1), 01] .OR.; // É o ultimo registro de apontamento ou mudou o produtivo ...
							aCalSrvc[nCont, 6] == "2")
								VOD->(DbSeek(cFilVOD+aCalSrvc[nCont, SRVC_CODSEC]))
								AADD(aAuxLinSrvc, {;
									aCalSrvc[nCont, 05],;                          // 01 - Tipo de Servico
									aCalSrvc[nCont, 01],;                          // 02 - Grupo do Servico
									aCalSrvc[nCont, 02],;                          // 03 - Codigo do Servico
									aCalSrvc[nCont, 15],;                          // 04 - Descricao do Servico
									cAuxProdutivo,;                                // 05 - Codigo do Produtivo
									Left(aCalSrvc[nCont, 14, nContApon, 12], 19),; // 06 - Nome do Produtivo
									IIf(lPrimLinha, aCalSrvc[nCont, 10], 0),;      // 07 - Tempo Padrao
									nAuxTemTra,;                                   // 08 - Tempo Trabalhado
									nTemCobApo,;                                   // 09 - Tempo Cobrado
									nTemVenApo,;                                   // 10 - Tempo Vendido
									nAuxValorSrvc,;                                // 11 - Valor do Servico (Liquido)
									aCalSrvc[nCont, SRVC_KILROD],;                 // 12 - Kilometragem rodada
									aCalSrvc[nCont, SRVC_INCMOB],;                 // 13 - Tipo de Cobranca
									VOD->VOD_DESSEC};                              // 14 - Codigo da Secao
								)
								
								If nContApon < Len(aCalSrvc[nCont,14]) // Zera contadores ...
									nAuxTemTra := 0
									nTemCobApo := 0
									nTemVenApo := 0
									nAuxValorSrvc := 0
									cAuxProdutivo := aCalSrvc[nCont, 14, (nContApon + 1), 01]
								EndIf
								lPrimLinha := .f.
							Endif
						Next

						If lConsVenda // .AND. Len(aCalSrvc[nCont, 14]) > 1
							// Totalizador do Serviço
							AADD(aAuxLinSrvc, {;
								" ",;                      // 01 - Tipo de Servico
								" ",;                      // 02 - Grupo do Servico
								" ",;                      // 03 - Codigo do Servico
								" ",;                      // 04 - Descricao do Servico
								" ",;                      // 05 - Codigo do Produtivo
								STR0038,; 		           // 06 - Nome do Produtivo
								aCalSrvc[nCont, 10],;      // 07 - Tempo Padrao
								aCalSrvc[nCont, 11],;      // 08 - Tempo Trabalhado
								aCalSrvc[nCont, 12],;      // 09 - Tempo Cobrado
								aCalSrvc[nCont, 13],;      // 10 - Tempo Vendido
								aCalSrvc[nCont, 09],;      // 11 - Valor do Servico (Liquido)
								aCalSrvc[1, SRVC_KILROD],; // 12 - Kilometragem rodada
								aCalSrvc[1, SRVC_INCMOB],; // 13 - Tipo de Cobranca
								VOD->VOD_DESSEC};          // 14 - Codigo da Secao
							)
						Endif
					Endif

					// Gera Resumo por Tipo de Servico
					If (nPosTipSer := aScan(aResTipSer, {|x| x[01] == QRYOS->VO1_FILIAL .AND. x[02] == aCalSrvc[nCont, 05]})) == 0
						VOK->(DbSeek(cFilVOK+aCalSrvc[nCont, 05]))
						AADD(aResTipSer, {QRYOS->VO1_FILIAL, aCalSrvc[nCont, 05], VOK->VOK_DESSER, VOK->VOK_TIPHOR, 0, 0, 0, 0, 0, 0})
						nPosTipSer := Len(aResTipSer)
					EndIf
					aResTipSer[nPosTipSer, 05] += aCalSrvc[nCont, 10] 		// [08] - Tempo Padrao
					aResTipSer[nPosTipSer, 07] += aCalSrvc[nCont, 11] 		// [09] - Tempo Trabalhado
					If lConsVenda // Nao é TT interno ou é interno deve exibir valores (MV_PAR17)
						aResTipSer[nPosTipSer, 08] += aCalSrvc[nCont, 12] 	// [10] - Tempo Cobrado
						aResTipSer[nPosTipSer, 06] += aCalSrvc[nCont, 13] 	// [11] - Tempo Vendido
						aResTipSer[nPosTipSer, 09] += aCalSrvc[nCont, 09] 	// [12] - Total Servicos
					Endif
					If !( aCalSrvc[nCont, 05] $ cProcTIPSER) // Soma a qtde de OS por Tipo de Servico
						aResTipSer[nPosTipSer, 10]++
					EndIf
					cProcTIPSER += aCalSrvc[nCont, 05] + "/" // Atualiza para nao calcular duplicado a qtde de tipo de servico na OS
				Next

				// Impressao sintetica ou impressao analitica
				If MV_PAR03 == 2 .OR. MV_PAR03 == 3
					oSection6:init()
					oSection6:Cell("VOI_TIPTEM"):SetValue(aAuxTT[nContTT, ATT_TIPTEM]) 				// Tipo de Tempo
					oSection6:Cell("VOI_SITTPO"):SetValue(aAuxTT[nContTT, ATT_SITTPO])				// Situação do Tipo de Tempo
					oSection6:Cell("A1_COD"):SetValue(aAuxTT[nContTT, ATT_CLIENTE])					// Cliente Faturar Para
					oSection6:Cell("A1_LOJA"):SetValue(aAuxTT[nContTT, ATT_LOJA])					// Loja Faturar Para
					oSection6:Cell("A1_NOME"):SetValue(aAuxTT[nContTT, ATT_NOME])					// Nome Cliente
					oSection6:Cell("VO4_DEPGAR"):SetValue(aAuxTT[nContTT, ATT_DEPGAR])				// Departamento Garantia
					oSection6:Cell("VO4_DEPINT"):SetValue(aAuxTT[nContTT, ATT_DEPINT])				// Departamento Interno
					oSection6:Cell("VO4_FUNFEC"):SetValue(aAuxTT[nContTT, ATT_PRODUTIVO])			// Produtivo que fechou a OS
					oSection6:Cell("VO4_DATDIS"):SetValue(OR450FDATA(aAuxTT[nContTT, ATT_DATLIB]))	// Data de Liberacao
					oSection6:Cell("VO4_DATFEC"):SetValue(OR450FDATA(aAuxTT[nContTT, ATT_DATFEC]))	// Data de Fechamento
					oSection6:Cell("VO4_DATCAN"):SetValue(OR450FDATA(aAuxTT[nContTT, ATT_DATCAN]))	// Data de Cancelamento
					oSection6:Cell("VOO_LIBVOO"):SetValue(aAuxTT[nContTT, ATT_LIBVOO])				// Liberacao do VOO
					oSection6:Cell("F2_DOC"):SetValue(aAuxTT[nContTT, ATT_NUMNFI])					// Numero da Nota Fiscal
					oSection6:Cell("F2_SERIE"):SetValue(aAuxTT[nContTT, ATT_SERNFI])				// Série da Nota Fiscal
					oSection6:Cell("VO4_TEMPAD"):SetValue(aAuxTT[nContTT, ATT_TEMPAD])				// Tempo Padrao
					oSection6:Cell("VO4_TEMTRA"):SetValue(aAuxTT[nContTT, ATT_TEMTRA])				// Tempo Trabalhado
					oSection6:Cell("VO4_TEMCOB"):SetValue(aAuxTT[nContTT, ATT_TEMCOB])				// Tempo Cobrado
					oSection6:Cell("VO4_TEMVEN"):SetValue(aAuxTT[nContTT, ATT_TEMVEN])				// Tempo Vendido
					if cPaisLoc == "BRA"
						oSection6:Cell("VO4_VALSER"):SetValue(aAuxTT[nContTT, ATT_TOTSRVC])				// Total Servicos
						oSection6:Cell("VO3_VALPEC"):SetValue(aAuxTT[nContTT, ATT_TOTPECA])				// Total de Pecas
					else
						oSection6:Cell("VALSER"):SetValue(aSimbolos[QRYOS->VO1_MOEDA] + " " + Transform(aAuxTT[nContTT, ATT_TOTSRVC], GetSX3Cache("F2_VALBRUT", "X3_PICTURE")))	// Total Servicos
						oSection6:Cell("VALPEC"):SetValue(aSimbolos[QRYOS->VO1_MOEDA] + " " + Transform(aAuxTT[nContTT, ATT_TOTPECA], GetSX3Cache("F2_VALBRUT", "X3_PICTURE")))	// Total de Pecas
					endif

					oSection6:PrintLine()
					oSection6:Finish()
				EndIf

				If MV_PAR03 == 3 // Impressao analitica
					// Imprime pecas
					If Len(aAuxLinPeca) > 0
						oSection7:Init()
						For nCont := 1 to Len(aAuxLinPeca)
							oSection7:Cell("BM_GRUPO"):SetValue(aAuxLinPeca[nCont,02])		// Grupo da Peca
							oSection7:Cell("B1_CODITE"):SetValue(aAuxLinPeca[nCont,03])		// Codigo da Peca
							oSection7:Cell("B1_DESC"):SetValue(aAuxLinPeca[nCont, 04])		// Descricao da Peca
							oSection7:Cell("VO3_QTDREQ"):SetValue(aAuxLinPeca[nCont, 05])	// Quantidade
							oSection7:Cell("VO3_PROREQ"):SetValue(aAuxLinPeca[nCont, 06])	// Produtivo que Requisitou
							oSection7:Cell("VO3_FORMUL"):SetValue(aAuxLinPeca[nCont, 07])	// Formula
							if cPaisLoc == "BRA"
								oSection7:Cell("VO3_VALPEC"):SetValue(aAuxLinPeca[nCont, 08])	// Valor Unitario
								oSection7:Cell("VO3_VALTOT"):SetValue(aAuxLinPeca[nCont, 09])	// Valor Total
							else
								oSection7:Cell("VALPEC"):SetValue(aSimbolos[QRYOS->VO1_MOEDA] + " " + Transform(aAuxLinPeca[nCont, 08], GetSX3Cache("F2_VALBRUT", "X3_PICTURE")))	// Valor Unitario
								oSection7:Cell("VALTOT"):SetValue(aSimbolos[QRYOS->VO1_MOEDA] + " " + Transform(aAuxLinPeca[nCont, 09], GetSX3Cache("F2_VALBRUT", "X3_PICTURE")))	// Valor Total
							endif

							oSection7:PrintLine()
						Next
						oSection7:Finish()
					Endif

					// Imprime Servicos
					If Len(aAuxLinSrvc) > 0
						oSection8:Init()
						For nCont := 1 to Len(aAuxLinSrvc)
							oSection8:Cell("VOK_TIPSER"):SetValue(aAuxLinSrvc[nCont, 01]) 							// Tipo de Servico
							oSection8:Cell("VOS_CODGRU"):SetValue(aAuxLinSrvc[nCont, 02]) 							// Grupo do Servico
							oSection8:Cell("VO6_CODSER"):SetValue(aAuxLinSrvc[nCont, 03]) 							// Codigo do Servico
							oSection8:Cell("VO6_DESSER"):SetValue(aAuxLinSrvc[nCont, 04]) 							// Descricao do Servico
							oSection8:Cell("VAI_CODTEC"):SetValue(aAuxLinSrvc[nCont, 05]) 							// Codigo do Produtivo
							if Alltrim(aAuxLinSrvc[nCont, 06]) == "TOTAL"
								oReport:IncRow()
							Endif
							oSection8:Cell("VAI_NOMTEC"):SetValue(aAuxLinSrvc[nCont, 06]) 							// Nome do Produtivo
							oSection8:Cell("VO4_KILROD"):SetValue(IIF(aAuxLinSrvc[nCont, 13] == "5",Transform(aAuxLinSrvc[nCont, 12], GetSX3Cache("VO4_KILROD", "X3_PICTURE")), " ")) // Quilometragem Rodada
							oSection8:Cell("VO4_TEMPAD"):SetValue(aAuxLinSrvc[nCont, 07]) 							// Tempo Padrao
							oSection8:Cell("VO4_TEMTRA"):SetValue(aAuxLinSrvc[nCont, 08]) 							// Tempo Trabalhado
							oSection8:Cell("VO4_TEMCOB"):SetValue(aAuxLinSrvc[nCont, 09]) 							// Tempo Cobrado
							oSection8:Cell("VO4_TEMVEN"):SetValue(aAuxLinSrvc[nCont, 10]) 							// Tempo Vendido
							if cPaisLoc == "BRA"
								oSection8:Cell("VO4_VALSER"):SetValue(aAuxLinSrvc[nCont, 11]) 							// Valor do Servico (Liquido)
							else
								oSection8:Cell("VALSER"):SetValue(aSimbolos[QRYOS->VO1_MOEDA] + " " + Transform(aAuxLinSrvc[nCont, 11], GetSX3Cache("F2_VALBRUT", "X3_PICTURE"))) // Valor do Servico (Liquido)
							endif
							
							oSection8:PrintLine()
							if Alltrim(aAuxLinSrvc[nCont, 06]) == "TOTAL"
								oReport:IncRow()
							Endif
						Next
						oSection8:Finish()
					EndIf

					If MV_PAR26 == 2 // Gera Planilha
						If Len(aAuxTT) == 0 .OR. (Len(aAuxLinPeca) == 0 .AND. Len(aAuxLinSrvc) == 0) // Gera Planilha, se nao houver requisicao, cria uma linha so com informacoes da OS
							OR450APPEND(0)
						EndIf

						For nCont := 1 to Len(aAuxLinPeca) // Adiciona Pecas
							OR450APPEND(nContTT)
							aImpXls[nPosicao, nPosRELACA] := aAuxLinPeca[nCont, 01] // 01 - Numero da Requisicao
							aImpXls[nPosicao, nPosGRUPO]  := aAuxLinPeca[nCont, 02] // 02 - Grupo da Peca
							aImpXls[nPosicao, nPosCODITE] := aAuxLinPeca[nCont, 03] // 03 - Codigo da Peca
							aImpXls[nPosicao, nPosDESITE] := aAuxLinPeca[nCont, 04] // 04 - Descricao da Peca
							aImpXls[nPosicao, nPosQTDADE] := aAuxLinPeca[nCont, 05] // 05 - Quantidade
							aImpXls[nPosicao, nPosPRODRE] := aAuxLinPeca[nCont, 06] // 06 - Produtivo que Requisitou
							aImpXls[nPosicao, nPosFORMUL] := aAuxLinPeca[nCont, 07] // 07 - Formula
							aImpXls[nPosicao, nPosVLRUNI] := aAuxLinPeca[nCont, 08] // 08 - Valor Unitario
							aImpXls[nPosicao, nPosVLRTOT] := aAuxLinPeca[nCont, 09] // 09 - Valor Total
							aImpXls[nPosicao, nPosORIPAR] := aAuxLinPeca[nCont, 10] // 10 - Original ou Paralelo
						Next

						For nCont := 1 to Len(aAuxLinSrvc) // Adiciona Servicos
							If Alltrim(aAuxLinSrvc[nCont, 06]) == STR0038
								Loop
							Endif

							OR450APPEND(nContTT)
							aImpXls[nPosicao, nPosTIPOSR] := aAuxLinSrvc[nCont, 01]	// 01 - Tipo de Servico
							aImpXls[nPosicao, nPosGRUPOS] := aAuxLinSrvc[nCont, 02]	// 02 - Grupo do Servico
							aImpXls[nPosicao, nPosCODSRV] := aAuxLinSrvc[nCont, 03]	// 03 - Codigo do Servico
							aImpXls[nPosicao, nPosDESSRV] := aAuxLinSrvc[nCont, 04]	// 04 - Descricao do Servico
							aImpXls[nPosicao, nPosPRODUT] := aAuxLinSrvc[nCont, 05]	// 05 - Codigo do Produtivo
							aImpXls[nPosicao, nPosNOMEPR] := aAuxLinSrvc[nCont, 06]	// 06 - Nome do Produtivo
							aImpXls[nPosicao, nPosTPOPAD] := Transform(aAuxLinSrvc[nCont, 07], "@E 99999:99")	// 07 - Tempo Padrao
							aImpXls[nPosicao, nPosTPOTRA] := Transform(aAuxLinSrvc[nCont, 08], "@E 99999:99")	// 08 - Tempo Trabalhado
							aImpXls[nPosicao, nPosTPOCOB] := aAuxLinSrvc[nCont, 10]	// 10 - Tempo Vendido
							aImpXls[nPosicao, nPosTPOVEN] := aAuxLinSrvc[nCont, 09]	// 09 - Tempo Cobrado
							aImpXls[nPosicao, nPosSERV  ] := aAuxLinSrvc[nCont, 11]	// 11 - Valor do Servico (Liquido)
							aImpXls[nPosicao, nPosKMRODA] := aAuxLinSrvc[nCont, 12]	// 12 - KM Rodado
						Next
					EndIf
				EndIf
			Next

			// Atualizando RESUMO
			cProcSITTPO := "" // Controla a Situacao do Tempo que ja foi calculada no resumo
			cProcTIPTEM := ""
			For nCont := 1 to Len(aAuxTT)
				VOI->(DbSetOrder(1))
				VOI->(DbSeek(xFilial("VOI") + aAuxTT[nCont, ATT_TIPTEM]))
				// Gera Resumo de Tipo de Tempo
				If (nPos := aScan(aResTipTem, {|x| x[01] == aAuxTT[nCont, ATT_TIPTEM]})) == 0
					AADD(aResTipTem, {aAuxTT[nCont, ATT_TIPTEM], VOI->VOI_SITTPO, VOI->VOI_DESTTE, 0, 0, 0, 0, 0, 0, 0, 0})
					nPos := Len(aResTipTem)
				EndIf
				aResTipTem[nPos, 04] += aAuxTT[nCont, ATT_QTDPECA]	// Qtde de Pecas
				aResTipTem[nPos, 05] += aAuxTT[nCont, ATT_TOTPECA]	// Total de Pecas
				aResTipTem[nPos, 06] += aAuxTT[nCont, ATT_TEMPAD]	// Tempo Padrao
				aResTipTem[nPos, 07] += aAuxTT[nCont, ATT_TEMTRA]	// Tempo Trabalhado
				aResTipTem[nPos, 08] += aAuxTT[nCont, ATT_TEMCOB]	// Tempo Cobrado
				aResTipTem[nPos, 09] += aAuxTT[nCont, ATT_TEMVEN]	// Tempo Vendido
				aResTipTem[nPos, 10] += aAuxTT[nCont, ATT_TOTSRVC]	// Total de Servicos

				If !(aAuxTT[nCont, ATT_TIPTEM] $ cProcTIPTEM) // Soma a qtde de OS por Tipo de Tempo
					aResTipTem[nPos, 11]++ // Total de Tipo de Tempo
				EndIf

				If !(aResTipTem[nPos, 02] $ cProcSITTPO) // Soma a qtde de OS por Situacao do Tempo
					If (nPos2 := aScan(aResSitTpo, {|x| x[01] == aResTipTem[nPos, 02]})) == 0 // Verifica se existe registro na matriz de resumo de situacao do tempo do tipo de tempo
						AADD(aResSitTpo, {aResTipTem[nPos, 02], 0})
						nPos2 := Len(aResSitTpo)
					EndIf
					cProcSITTPO += aResTipTem[nPos, 02] + "/"
					++aResSitTpo[nPos2, 2]
				EndIf

				Do Case // Gera Resumo por Departamento
					Case !Empty(aAuxTT[nCont, ATT_DEPINT])
						cAuxTabX5 := "VD"
						cAuxDepto := aAuxTT[nCont, ATT_DEPINT]
					Case !Empty(aAuxTT[nCont, ATT_DEPGAR])
						cAuxTabX5 := "VF"
						cAuxDepto := aAuxTT[nCont, ATT_DEPGAR]
					Otherwise
						cAuxDepto := " "
				End Case

				If (nPos := aScan(aResDepto, {|x| x[01] == VOI->VOI_SITTPO .AND. x[02] == cAuxDepto})) == 0
					If !Empty(cAuxDepto)
						SX5->(DbSetOrder(1))
						SX5->(DbSeek(cFilSX5+cAuxTabX5+cAuxDepto))
					EndIf
					AADD(aResDepto, {;
						VOI->VOI_SITTPO,;
						cAuxDepto,;
						Iif(!Empty(cAuxDepto), Substr(SX5->X5_DESCRI, 1, 20), STR0224),; // SEM DEPARTAMENTO
						0,;
						0,;
						0,;
						0,;
						0,;
						0,;
						0,;
						0};
					)
					nPos := Len(aResDepto)
				EndIf
				aResDepto[nPos, 04] += aAuxTT[nCont, ATT_QTDPECA] // Qtde de Pecas
				aResDepto[nPos, 05] += aAuxTT[nCont, ATT_TOTPECA] // Total de Pecas
				aResDepto[nPos, 06] += aAuxTT[nCont, ATT_TEMPAD]  // Tempo Padrao
				aResDepto[nPos, 07] += aAuxTT[nCont, ATT_TEMTRA]  // Tempo Trabalhado
				aResDepto[nPos, 08] += aAuxTT[nCont, ATT_TEMCOB]  // Tempo Cobrado
				aResDepto[nPos, 09] += aAuxTT[nCont, ATT_TEMVEN]  // Tempo Vendido
				aResDepto[nPos, 10] += aAuxTT[nCont, ATT_TOTSRVC] // Total de Servicos

				If !(aAuxTT[nCont, ATT_TIPTEM] $ cProcTIPTEM) // Soma a qtde de OS por Tipo de Tempo
					aResDepto[nPos, 11]++ // Total de Tipo de Tempo
				EndIf

				// Atualiza para nao calcular duplicado quando o Tipo de Tempo possui varias liberacoes (VOO_LIBVOO)
				cProcTIPTEM += aAuxTT[nCont, ATT_TIPTEM] + "/"
			Next
			QRYOS->(DbSkip())
		EndDo
		QRYOS->(DbCloseArea())

		if cPaisLoc == "BRA" .or. !Empty(nMoedaAtua)
			ImpResumos(oReport, nMoedaAtua, aResSitTpo, aResTipTem, aResDepto, aResTipSer, nPassagens)
		endif

	Next

	If MV_PAR26 == 2 // Gera Planilha
		For nI := 1 to Len(aImpXls)
			aRow := {}
			for nJ := 1 to Iif(cPaisLoc $ "ARG|MEX|PAR", 71, 70)
				if aScan(aFldDate, {|x| x == nJ}) > 0
					AAdd(aRow, DToC(aImpXls[ni, nJ]))
				else
					AAdd(aRow, aImpXls[nI, nJ])
				endif
			next
			oExcel:AddRow(STR0124, STR0064, aClone(aRow))
		Next
	Endif

	cFilAnt := cFilBkp
	If MV_PAR26 == 2 // Gera Planilha
		If ExistBlock("OR450XLS")
			ExecBlock("OR450XLS", .f., .f., {aImpXls})
		EndIf

		If MV_PAR03 == 3
			cNomeArq := Alltrim(MV_PAR27) + "OFIOR450.xls"
			oExcel:Activate()
			oExcel:GetXMLFile(cNomeArq)
			oExcel:DeActivate()
			MsgInfo(STR0044 + CHR(13) + CHR(10) + CHR(13) + CHR(10) + cNomeArq, STR0045)	// "Planilha gerada com sucesso!" # "Atenção"
		ElseIf MV_PAR03 == 1 .or. MV_PAR03 == 2
			MsgInfo(STR0126)
		Endif
	EndIf

Return


static function ImpResumos(oReport, nMoeda, aResSitTpo, aResTipTem, aResDepto, aResTipSer, nPassagens)
Local oSection2			:= oReport:Section(STR0035) // "Resumo"
Local oSection3			:= oReport:Section(STR0230) // "Resumo Departamento"
Local oSection4			:= oReport:Section(STR0231) // "Resumo Tipo de Serviço"
Local aAuxResumo		:= {}
Local cProcSITTPO		:= ""
Local nPos 				:= 0
Local nCont 			:= 0

	If Len(aResTipTem) > 0 // Imprime resumo

		aAuxResumo := Array(08)
		aFill(aAuxResumo, 0)

		aSort(aResTipTem,,, {|x, y| x[2] + x[1] < y[2] + y[1] } )
		cProcSITTPO := " "

		// static function CabSection(oReport, cText, lFatLine, lThinLine)
		CabSection(oReport, "******** " + STR0035 + Iif(!(cPaisLoc == "BRA"), " " + aSimbolos[nMoeda], "") + " ********",, .f.)
		CabSection(oReport, "******** " + STR0036 + " ********",.f.)

		oSection2:Init()
		For nCont := 1 to Len(aResTipTem)
			If cProcSITTPO <> aResTipTem[nCont, 02]
				nPos := aScan(aResSitTpo, {|x| x[1] == aResTipTem[nCont, 02]})
				oSection2:Cell("VOI_TIPTEM"):SetValue("<< " + X3CBOXDESC("VOI_SITTPO", aResSitTpo[nPos, 01]) + " >>")
				oSection2:Cell("VOI_DESTTE"):SetValue("")
				oSection2:Cell("VO3_QTDREQ"):SetValue("")
				oSection2:Cell("COUNT_PEC"):SetValue("")
				oSection2:Cell("VO4_TEMPAD"):SetValue("")
				oSection2:Cell("VO4_TEMTRA"):SetValue("")
				oSection2:Cell("VO4_TEMCOB"):SetValue("")
				oSection2:Cell("VO4_TEMVEN"):SetValue("")
				if cPaisLoc == "BRA"
					oSection2:Cell("VO4_VALSER"):SetValue("")
				else
					oSection2:Cell("VALSER"):SetValue("")
				endif
				
				oSection2:Cell("COUNT_TT"):SetValue("")
				oSection2:Cell("COUNT_OS"):SetValue(Transform(aResSitTpo[nPos, 02], "@E 999,999,999"))
				oSection2:PrintLine()
				oSection2:Cell("COUNT_OS"):SetValue("")
				cProcSITTPO := aResTipTem[nCont, 02]
				aAuxResumo[08] += aResSitTpo[nPos, 02]
			EndIf

			// Resumo
			oSection2:Cell("VOI_TIPTEM"):SetValue(aResTipTem[nCont, 01])
			oSection2:Cell("VOI_DESTTE"):SetValue(aResTipTem[nCont, 03])
			oSection2:Cell("VO3_QTDREQ"):SetValue(Transform(aResTipTem[nCont, 04], GetSX3Cache("VO3_QTDREQ", "X3_PICTURE")))
			oSection2:Cell("COUNT_PEC"):SetValue(Transform(aResTipTem[nCont, 05], "@E 99,999,999.99"))
			oSection2:Cell("VO4_TEMPAD"):SetValue(Transform(aResTipTem[nCont, 06], GetSX3Cache("VO4_TEMPAD", "X3_PICTURE")))
			oSection2:Cell("VO4_TEMTRA"):SetValue(Transform(aResTipTem[nCont, 07], GetSX3Cache("VO4_TEMTRA", "X3_PICTURE")))
			oSection2:Cell("VO4_TEMCOB"):SetValue(Transform(aResTipTem[nCont, 08], GetSX3Cache("VO4_TEMCOB", "X3_PICTURE")))
			oSection2:Cell("VO4_TEMVEN"):SetValue(Transform(aResTipTem[nCont, 09], GetSX3Cache("VO4_TEMVEN", "X3_PICTURE")))
			if cPaisLoc == "BRA"
				oSection2:Cell("VO4_VALSER"):SetValue(Transform(aResTipTem[nCont, 10], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			else
				oSection2:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aResTipTem[nCont, 10], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			endif
			oSection2:Cell("COUNT_TT"):SetValue(Transform(aResTipTem[nCont, 11], "@E 99,999,99"))
			oSection2:PrintLine()

			aAuxResumo[01] += aResTipTem[nCont, 04]	// Qtde de Pecas
			aAuxResumo[02] += aResTipTem[nCont, 05]	// Total de Pecas
			aAuxResumo[03] += aResTipTem[nCont, 06]	// Tempo Padrao
			aAuxResumo[04] += aResTipTem[nCont, 07]	// Tempo Trabalhado
			aAuxResumo[05] += aResTipTem[nCont, 08]	// Tempo Cobrado
			aAuxResumo[06] += aResTipTem[nCont, 09]	// Tempo Vendido
			aAuxResumo[07] += aResTipTem[nCont, 10]	// Total de Servico
		Next
		oReport:IncRow()

		//Totais
		oSection2:Cell("VOI_TIPTEM"):SetValue(STR0038)
		oSection2:Cell("VOI_DESTTE"):SetValue("")
		oSection2:Cell("VO3_QTDREQ"):SetValue(Transform(aAuxResumo[01], GetSX3Cache("VO3_QTDREQ", "X3_PICTURE")))
		oSection2:Cell("COUNT_PEC"):SetValue(Transform(aAuxResumo[02], "@E 99,999,999.99"))
		oSection2:Cell("VO4_TEMPAD"):SetValue(Transform(aAuxResumo[03], GetSX3Cache("VO4_TEMPAD", "X3_PICTURE")))
		oSection2:Cell("VO4_TEMTRA"):SetValue(Transform(aAuxResumo[04], GetSX3Cache("VO4_TEMTRA", "X3_PICTURE")))
		oSection2:Cell("VO4_TEMCOB"):SetValue(Transform(aAuxResumo[05], GetSX3Cache("VO4_TEMCOB", "X3_PICTURE")))
		oSection2:Cell("VO4_TEMVEN"):SetValue(Transform(aAuxResumo[06], GetSX3Cache("VO4_TEMVEN", "X3_PICTURE")))
		if cPaisLoc == "BRA"
			oSection2:Cell("VO4_VALSER"):SetValue(Transform(aAuxResumo[07], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
		else
			oSection2:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aAuxResumo[07], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
		endif
		oSection2:Cell("COUNT_OS"):SetValue(Transform(aAuxResumo[08], "@E 999,999,999"))
		oSection2:PrintLine()

		oReport:IncRow()

		oSection2:Cell("VOI_TIPTEM"):SetValue(STR0039 + ": ") // "Qtd.Passagem Chassi"
		oSection2:Cell("VOI_DESTTE"):SetValue(Transform(nPassagens, "@E 999,999,999"))
		oSection2:Cell("VO3_QTDREQ"):SetValue("")
		oSection2:Cell("COUNT_PEC"):SetValue("")
		oSection2:Cell("VO4_TEMPAD"):SetValue("")
		oSection2:Cell("VO4_TEMTRA"):SetValue("")
		oSection2:Cell("VO4_TEMCOB"):SetValue("")
		oSection2:Cell("VO4_TEMVEN"):SetValue("")
		if cPaisLoc == "BRA"
			oSection2:Cell("VO4_VALSER"):SetValue("")
		else
			oSection2:Cell("VALSER"):SetValue("")
		endif
		
		oSection2:Cell("COUNT_TT"):SetValue("")
		oSection2:Cell("COUNT_OS"):SetValue("")
		oSection2:PrintLine()
		oSection2:Finish()
	EndIf

	If Len(aResDepto) <> 0
		aFill(aAuxResumo,0)

		// static function CabSection(oReport, cText, lFatLine, lThinLine)
		CabSection(oReport, "******** " + STR0040 + " ********",, .f.)
		CabSection(oReport, "******** " + STR0036 + " ********",.f.)

		oSection3:Init()
		aSort(aResDepto,,, {|x, y| x[1] + x[2] < y[1] + y[2]})
		cProcSITTPO := ""
		For nCont := 1 to Len(aResDepto)
			If cProcSITTPO <> aResDepto[nCont, 01]
				oSection3:Cell("VO4_DEPGAR"):SetValue("<< " + X3CBOXDESC("VOI_SITTPO", aResDepto[nCont, 01]) + " >>")
				oSection3:Cell("VO3_QTDREQ"):SetValue("")
				oSection3:Cell("COUNT_PEC" ):SetValue("")
				oSection3:Cell("VO4_TEMPAD"):SetValue("")
				oSection3:Cell("VO4_TEMTRA"):SetValue("")
				oSection3:Cell("VO4_TEMCOB"):SetValue("")
				oSection3:Cell("VO4_TEMVEN"):SetValue("")
				if cPaisLoc == "BRA"
					oSection3:Cell("VO4_VALSER"):SetValue("")
				else
					oSection3:Cell("VALSER"):SetValue("")
				endif
				oSection3:Cell("COUNT_OS"  ):SetValue("")
				oSection3:PrintLine()
				cProcSITTPO := aResDepto[nCont, 01]
			EndIf
			oSection3:Cell("VO4_DEPGAR"):SetValue(aResDepto[nCont, 02] + " - " + aResDepto[nCont, 03])
			oSection3:Cell("VO3_QTDREQ"):SetValue(Transform(aResDepto[nCont, 04], GetSX3Cache("VO3_QTDREQ", "X3_PICTURE")))
			oSection3:Cell("COUNT_PEC" ):SetValue(Transform(aResDepto[nCont, 05], "@E 99,999,999.99"))
			oSection3:Cell("VO4_TEMPAD"):SetValue(Transform(aResDepto[nCont, 06], GetSX3Cache("VO4_TEMPAD", "X3_PICTURE")))
			oSection3:Cell("VO4_TEMTRA"):SetValue(Transform(aResDepto[nCont, 07], GetSX3Cache("VO4_TEMTRA", "X3_PICTURE")))
			oSection3:Cell("VO4_TEMCOB"):SetValue(Transform(aResDepto[nCont, 08], GetSX3Cache("VO4_TEMCOB", "X3_PICTURE")))
			oSection3:Cell("VO4_TEMVEN"):SetValue(Transform(aResDepto[nCont, 09], GetSX3Cache("VO4_TEMVEN", "X3_PICTURE")))
			if cPaisLoc == "BRA"
				oSection3:Cell("VO4_VALSER"):SetValue(Transform(aResDepto[nCont, 10], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			else
				oSection3:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aResDepto[nCont, 10], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			endif
			
			oSection3:Cell("COUNT_OS"  ):SetValue(Transform(aResDepto[nCont, 11], "@E 999,999,999"))
			oSection3:PrintLine()

			aAuxResumo[01] += aResDepto[nCont, 04] // Qtde de Pecas
			aAuxResumo[02] += aResDepto[nCont, 05] // Total de Pecas
			aAuxResumo[03] += aResDepto[nCont, 06] // Tempo Padrao
			aAuxResumo[04] += aResDepto[nCont, 07] // Tempo Trabalhado
			aAuxResumo[05] += aResDepto[nCont, 08] // Tempo Cobrado
			aAuxResumo[06] += aResDepto[nCont, 09] // Tempo Vendido
			aAuxResumo[07] += aResDepto[nCont, 10] // Total de Servico
			aAuxResumo[08] += aResDepto[nCont, 11] // Total de OS
		Next
		oReport:IncRow()

		//Totais
		oSection3:Cell("VO4_DEPGAR"):SetValue(STR0038)
		oSection3:Cell("VO3_QTDREQ"):SetValue(Transform(aAuxResumo[01], "@E 99999999.99"))
		oSection3:Cell("COUNT_PEC" ):SetValue(Transform(aAuxResumo[02], "@E 99,999,999.99"))
		oSection3:Cell("VO4_TEMPAD"):SetValue(Transform(aAuxResumo[03], "@R 999999:99"))
		oSection3:Cell("VO4_TEMTRA"):SetValue(Transform(aAuxResumo[04], "@R 999999:99"))
		oSection3:Cell("VO4_TEMCOB"):SetValue(Transform(aAuxResumo[05], "@R 999999:99"))
		oSection3:Cell("VO4_TEMVEN"):SetValue(Transform(aAuxResumo[06], "@R 999999:99"))
		if cPaisLoc == "BRA"
			oSection3:Cell("VO4_VALSER"):SetValue(Transform(aAuxResumo[07], "@E 99,999,999.99"))
		else
			oSection3:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aAuxResumo[07], "@E 99,999,999.99"))
		endif
		oSection3:Cell("COUNT_OS"  ):SetValue(Transform(aAuxResumo[08], "@E 999,999,999"))
		oSection3:PrintLine()
	EndIf

	If Len(aResTipSer) <> 0
		aFill(aAuxResumo, 0)

		CabSection(oReport, "******** " + STR0042 + " ********",,.f.)
		CabSection(oReport, "******** " + STR0036 + " ********",.f.)

		oSection4:Init()
		aSort(aResTipSer,,, {|x, y| x[4] + x[1] + x[2] < y[4] + y[1] + y[2]})
		cProcSITTPO := ""
		For nCont := 1 to Len(aResTipSer)
			If cProcSITTPO <> aResTipSer[nCont, 04]
				oSection4:Cell("VOK_TIPSER"):SetValue("<< " + X3CBOXDESC("VOK_TIPHOR", aResTipSer[nCont, 04]) + " >>")
				oSection4:Cell("VOK_DESSER"):SetValue("")
				oSection4:Cell("VO4_TEMPAD"):SetValue("")
				oSection4:Cell("VO4_TEMVEN"):SetValue("")
				oSection4:Cell("VO4_TEMTRA"):SetValue("")
				oSection4:Cell("VO4_TEMCOB"):SetValue("")
				if cPaisLoc == "BRA"
					oSection4:Cell("VO4_VALSER"):SetValue("")
				else	
					oSection4:Cell("VALSER"):SetValue("")
				endif
				oSection4:Cell("COUNT_OS"):SetValue("")
				oSection4:PrintLine()
				cProcSITTPO := aResTipSer[nCont, 04]
			EndIf
			oSection4:Cell("VOK_TIPSER"):SetValue(aResTipSer[nCont, 01] + " - " + aResTipSer[nCont, 02])
			oSection4:Cell("VOK_DESSER"):SetValue(aResTipSer[nCont, 03])
			oSection4:Cell("VO4_TEMPAD"):SetValue(Transform(aResTipSer[nCont, 05], GetSX3Cache("VO4_TEMPAD", "X3_PICTURE")))
			oSection4:Cell("VO4_TEMVEN"):SetValue(Transform(aResTipSer[nCont, 06], GetSX3Cache("VO4_TEMVEN", "X3_PICTURE")))
			oSection4:Cell("VO4_TEMTRA"):SetValue(Transform(aResTipSer[nCont, 07], GetSX3Cache("VO4_TEMTRA", "X3_PICTURE")))
			oSection4:Cell("VO4_TEMCOB"):SetValue(Transform(aResTipSer[nCont, 08], GetSX3Cache("VO4_TEMCOB", "X3_PICTURE")))
			if cPaisLoc == "BRA"
				oSection4:Cell("VO4_VALSER"):SetValue(Transform(aResTipSer[nCont, 09], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			else
				oSection4:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aResTipSer[nCont, 09], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
			endif
			oSection4:Cell("COUNT_OS"):SetValue(Transform(aResTipSer[nCont, 10], "@E 9999,999"))
			oSection4:PrintLine()

			aAuxResumo[01] += aResTipSer[nCont, 05]	// Tempo Padrao
			aAuxResumo[02] += aResTipSer[nCont, 06]	// Tempo Trabalhado
			aAuxResumo[03] += aResTipSer[nCont, 07]	// Tempo Cobrado
			aAuxResumo[04] += aResTipSer[nCont, 08]	// Tempo Vendido
			aAuxResumo[05] += aResTipSer[nCont, 09]	// Total de Strervico
			aAuxResumo[06] += aResTipSer[nCont, 10]	// Total de OS
		Next
		
		oReport:IncRow()
		
		oSection4:Cell("VOK_TIPSER"):SetValue(STR0038)
		oSection4:Cell("VOK_DESSER"):SetValue("")
		oSection4:Cell("VO4_TEMPAD"):SetValue(Transform(aAuxResumo[01], GetSX3Cache("VO4_TEMPAD", "X3_PICTURE")))
		oSection4:Cell("VO4_TEMVEN"):SetValue(Transform(aAuxResumo[02], GetSX3Cache("VO4_TEMVEN", "X3_PICTURE")))
		oSection4:Cell("VO4_TEMTRA"):SetValue(Transform(aAuxResumo[03], GetSX3Cache("VO4_TEMTRA", "X3_PICTURE")))
		oSection4:Cell("VO4_TEMCOB"):SetValue(Transform(aAuxResumo[04], GetSX3Cache("VO4_TEMCOB", "X3_PICTURE")))
		if cPaisLoc == "BRA"
			oSection4:Cell("VO4_VALSER"):SetValue(Transform(aAuxResumo[05], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
		else
			oSection4:Cell("VALSER"):SetValue(aSimbolos[nMoeda] + " " + Transform(aAuxResumo[05], GetSX3Cache("VO4_VALSER", "X3_PICTURE")))
		endif
		oSection4:Cell("COUNT_OS"):SetValue(Transform(aAuxResumo[06], "@E 9999,999"))
		oSection4:PrintLine()
		oSection4:Finish()
	EndIf

return nil





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OR450FDATA ºAutor  ³ Takahashi          º Data ³  27/12/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Formata data para impressão do relatorio                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ dData - Data a ser formatada                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OR450FDATA(dData)
	Local cRetorno := ""
	If Empty(dData)
		cRetorno := "  /  /  "
	Else
		cRetorno := StrZero(Day(dData), 2) + "/" + StrZero(Month(dData), 2) + "/" + Right(Str(Year(dData), 4), 2)
	EndIf
Return cRetorno

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OR450APPEND ºAutor  ³ Takahashi         º Data ³  27/12/12 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adiciona uma linha na tabela utilizada na ger. de planilha º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ nPosTT - Posicao da matriz de Tipo de Tempo                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function OR450APPEND(nPosTT)
	Local cQryInc := " "
	Local cSeqInc := " "
	Local cGruInc := " "
	Local cCodInc := " "
	Local cDesInc := " "

	if MV_PAR28 == 2 .AND. nPosTT > 0
		cQryInc := " SELECT "
		cQryInc += " DISTINCT VST_SEQINC, "
		cQryInc += " VST_GRUINC, "
		cQryInc += " VST_CODINC, "
		cQryInc += " VST_DESINC "
		cQryInc += " FROM "
		cQryInc += " 	" + RetSqlName("VST") + " VST "
		cQryInc += " WHERE "
		cQryInc += " 	VST_FILIAL = '" + xFilial("VST") + "' "
		cQryInc += " 	AND VST_CODIGO = '" + QRYOS->VO1_NUMOSV + "' "
		cQryInc += " 	AND VST_SEQINC IN ("
		cQryInc += 			"'" + Iif(Len(aCalPeca) >= nPosTT, aCalPeca[nPosTT, PECA_INCONV_SEQ], "") + "', "
		cQryInc += 			"'" + Iif(Len(aCalSrvc) >= nPosTT, aCalSrvc[nPosTT, SRVC_INCONV_SEQ], "") + "') "
		cQryInc += " 	AND VST.D_E_L_E_T_ = ' '  "
		TcQuery cQryInc New Alias "QRYINC"

		cSeqInc := QRYINC->VST_SEQINC
		cGruInc := QRYINC->VST_GRUINC
		cCodInc := QRYINC->VST_CODINC
		cDesInc := QRYINC->VST_DESINC
		QRYINC->(DbCloseArea())
	Endif

	dDtCanc := IIF(QRYOS->VO1_STATUS == "C",Stod(QRYOS->VO1_DATSTA),ctod(" / / "))

	if cPaisLoc == "BRA"
		AADD(;
			aImpXls,;
			{;
				QRYOS->VO1_FILIAL,; 														// 01 - "FILIAL"
				QRYOS->VO1_NUMOSV,; 														// 02 - "NRO_OS"
				UPPER(X3COMBO("VO1_TPATEN", QRYOS->VO1_TPATEN)),;							// 03 - "TP_ATEND"
				StoD(QRYOS->VO1_DATABE),; 													// 04 - "DT_ABERT"
				transform(QRYOS->VO1_HORABE, "@E 999:99"),; 								// 05 - "HR_ABERT"
				QRYOS->VO1_FUNABE,; 														// 06 - "CONS_ABE"
				QRYOS->VO1_KILOME,; 														// 07 - "KM"
				QRYOS->VO1_PROVEI,; 														// 08 - "PROPRIETAR"
				QRYOS->VO1_LOJPRO,; 														// 09 - "LOJA"
				QRYOS->A1_NOME,; 															// 10 - "NOME_CLIEN"
				QRYOS->A1_CGC,; 															// 11 - "CGC_CLI
				QRYOS->VO1_NUMORC,; 														// 12 - "ORÇAMENTO"
				QRYOS->A1_END,; 															// 13 - "ENDEREÇO"
				Iif(lA1_IBGE, QRYOS->VAM_DESCID, QRYOS->A1_MUN),; 							// 14 - "CIDADE"
				Iif(lA1_IBGE, QRYOS->VAM_ESTADO, QRYOS->A1_EST),; 							// 15 - "UF"
				QRYOS->A1_TEL,; 															// 16 - "TELEFONE"
				QRYOS->VV1_CODMAR,; 														// 17 - "MARCA"
				Left(Alltrim(QRYOS->VV1_MODVEI) + " - " + Alltrim(QRYOS->VV2_DESMOD), 30),; // 18 - "MODELO"
				Transform(QRYOS->VV1_FABMOD, "@R 9999/9999"),; 								// 19 - "FAB_MOD"
				QRYOS->VVC_DESCRI,; 														// 20 - "COR"
				QRYOS->VV1_CHAINT,; 														// 21 - "CHASSI_INT"
				QRYOS->VV1_CHASSI,; 														// 22 - "CHASSI"
				Transform(QRYOS->VV1_PLAVEI, X3Picture("VV1_PLAVEI")),; 					// 23 - "PLACA"
				QRYOS->VV1_CODFRO,; 														// 24 - "COD_FROTA"
				cSeqInc,; 																	// 25 - "SEQ_INCON"
				cGruInc,; 																	// 26 - "GRP_INCON"
				cCodInc,; 																	// 27 - "COD_INCON"
				cDesInc,; 																	// 28 - "DES_INCON"
				"",;																		// 29 - "TP"
				"",;																		// 30 - "LIB_VOO"
				"",;																		// 31 - "FAT_PAR"
				"",;																		// 32 - "LJ_PAR"
				"",;																		// 33 - "NOME_PAR"
				"",;																		// 34 - "DEPTO_GAR"
				"",;																		// 35 - "DEPTO_INT"
				"",;																		// 36 - "CONS_FEC"
				ctod("  /  /  "),;															// 37 - "DT_LIB"
				ctod("  /  /  "),;															// 38 - "DT_FEC"
				dDtCanc,;																	// 39 - "DT_CAN"
				"",;																		// 40 - "NRO_NF"
				"",;																		// 41 - SERIE_NF
				0,;																			// 42 - "PECAS_TT"
				0,;																			// 43 - "TPOPAD_TT"
				0,;																			// 44 - "TPOTRA_TT"
				0,;																			// 45 - "TPOCOB_TT"
				0,;																			// 46 - "TPOVEN_TT"
				"",;																		// 47 - "SERVICO_TT"
				"",;																		// 48 - "RELACAO"
				"",;																		// 49 - "GRUPO"
				"",;																		// 50 - "COD_ITEM"
				"",;																		// 51 - "DES_ITEM"
				0,;																			// 52 - "QTDADE"
				"",;																		// 53 - "PROD_REQ"
				"",;																		// 54 - "FORMULA"
				0,;																			// 55 - "VLR_UNIT"
				0,;																			// 56 - "VLR_TOTAL"
				"",;																		// 57 - "TIPO_SRV"
				"",;																		// 58 - "GRUPO_SRV"
				"",;																		// 59 - "COD_SRV"
				"",;																		// 60 - "DES_SRV"
				"",;																		// 61 - "PRODUTIVO"
				"",;																		// 62 - "NOME_PROD"
				0,;																			// 63 - "TPOPAD"
				0,;																			// 64 - "TPOTRA"
				0,;																			// 65 - "TPOCOB"
				0,;																			// 66 - "TPOVEN"
				"",;																		// 67 - "SERVIÇO"
				0,; 																		// 68 - KM Rodado
				"",;																		// 69 - Ori/Par
				QRYOS->VO1_STATUS;															// 70 - Status
			};
		)
	else
		AADD(;
			aImpXls,;
			{;
				QRYOS->VO1_FILIAL,; 														// 01 - "FILIAL"
				QRYOS->VO1_NUMOSV,; 														// 02 - "NRO_OS"
				Iif(VO1->VO1_MOEDA == 0, aSimbolos[1], aSimbolos[VO1->VO1_MOEDA]),;			// 03 - "MOEDA"
				UPPER(X3COMBO("VO1_TPATEN", QRYOS->VO1_TPATEN)),;							// 04 - "TP_ATEND"
				StoD(QRYOS->VO1_DATABE),; 													// 05 - "DT_ABERT"
				transform(QRYOS->VO1_HORABE, "@E 999:99"),; 								// 06 - "HR_ABERT"
				QRYOS->VO1_FUNABE,; 														// 07 - "CONS_ABE"
				QRYOS->VO1_KILOME,; 														// 08 - "KM"
				QRYOS->VO1_PROVEI,; 														// 09 - "PROPRIETAR"
				QRYOS->VO1_LOJPRO,; 														// 10 - "LOJA"
				QRYOS->A1_NOME,; 															// 11 - "NOME_CLIEN"
				QRYOS->A1_CGC,; 															// 12 - "CGC_CLI
				QRYOS->VO1_NUMORC,; 														// 13 - "ORÇAMENTO"
				QRYOS->A1_END,; 															// 14 - "ENDEREÇO"
				Iif(lA1_IBGE, QRYOS->VAM_DESCID, QRYOS->A1_MUN),; 							// 15 - "CIDADE"
				Iif(lA1_IBGE, QRYOS->VAM_ESTADO, QRYOS->A1_EST),; 							// 16 - "UF"
				QRYOS->A1_TEL,; 															// 17 - "TELEFONE"
				QRYOS->VV1_CODMAR,; 														// 18 - "MARCA"
				Left(Alltrim(QRYOS->VV1_MODVEI) + " - " + Alltrim(QRYOS->VV2_DESMOD), 30),; // 19 - "MODELO"
				Transform(QRYOS->VV1_FABMOD, "@R 9999/9999"),; 								// 20 - "FAB_MOD"
				QRYOS->VVC_DESCRI,; 														// 21 - "COR"
				QRYOS->VV1_CHAINT,; 														// 22 - "CHASSI_INT"
				QRYOS->VV1_CHASSI,; 														// 23 - "CHASSI"
				Transform(QRYOS->VV1_PLAVEI, X3Picture("VV1_PLAVEI")),; 					// 24 - "PLACA"
				QRYOS->VV1_CODFRO,; 														// 25 - "COD_FROTA"
				cSeqInc,; 																	// 26 - "SEQ_INCON"
				cGruInc,; 																	// 27 - "GRP_INCON"
				cCodInc,; 																	// 28 - "COD_INCON"
				cDesInc,; 																	// 29 - "DES_INCON"
				"",;																		// 30 - "TP"
				"",;																		// 31 - "LIB_VOO"
				"",;																		// 32 - "FAT_PAR"
				"",;																		// 33 - "LJ_PAR"
				"",;																		// 34 - "NOME_PAR"
				"",;																		// 35 - "DEPTO_GAR"
				"",;																		// 36 - "DEPTO_INT"
				"",;																		// 37 - "CONS_FEC"
				ctod("  /  /  "),;															// 38 - "DT_LIB"
				ctod("  /  /  "),;															// 39 - "DT_FEC"
				dDtCanc,;																	// 40 - "DT_CAN"
				"",;																		// 41 - "NRO_NF"
				"",;																		// 42 - SERIE_NF
				0,;																			// 43 - "PECAS_TT"
				0,;																			// 44 - "TPOPAD_TT"
				0,;																			// 45 - "TPOTRA_TT"
				0,;																			// 46 - "TPOCOB_TT"
				0,;																			// 47 - "TPOVEN_TT"
				"",;																		// 48 - "SERVICO_TT"
				"",;																		// 49 - "RELACAO"
				"",;																		// 50 - "GRUPO"
				"",;																		// 51 - "COD_ITEM"
				"",;																		// 52 - "DES_ITEM"
				0,;																			// 53 - "QTDADE"
				"",;																		// 54 - "PROD_REQ"
				"",;																		// 55 - "FORMULA"
				0,;																			// 56 - "VLR_UNIT"
				0,;																			// 57 - "VLR_TOTAL"
				"",;																		// 58 - "TIPO_SRV"
				"",;																		// 59 - "GRUPO_SRV"
				"",;																		// 60 - "COD_SRV"
				"",;																		// 61 - "DES_SRV"
				"",;																		// 62 - "PRODUTIVO"
				"",;																		// 63 - "NOME_PROD"
				0,;																			// 64 - "TPOPAD"
				0,;																			// 65 - "TPOTRA"
				0,;																			// 66 - "TPOCOB"
				0,;																			// 67 - "TPOVEN"
				"",;																		// 68 - "SERVIÇO"
				0,; 																		// 69 - KM Rodado
				"",;																		// 70 - Ori/Par
				QRYOS->VO1_STATUS;															// 71 - Status
			};
		)
	endif
	nPosicao := Len(aImpXls)

	If nPosTT <> 0
		aImpXls[nPosicao, nPosTP    ] := aAuxTT[nPosTT, ATT_TIPTEM]
		aImpXls[nPosicao, nPosLIBVOO] := aAuxTT[nPosTT, ATT_LIBVOO]
		aImpXls[nPosicao, nPosFATPAR] := aAuxTT[nPosTT, ATT_CLIENTE]
		aImpXls[nPosicao, nPosLJPAR ] := aAuxTT[nPosTT, ATT_LOJA]
		aImpXls[nPosicao, nPosNOMEPA] := aAuxTT[nPosTT, ATT_NOME]
		aImpXls[nPosicao, nPosDEPTOG] := aAuxTT[nPosTT, ATT_DEPGAR]
		aImpXls[nPosicao, nPosDEPTOI] := aAuxTT[nPosTT, ATT_DEPINT]
		aImpXls[nPosicao, nPosCONSFE] := aAuxTT[nPosTT, ATT_PRODUTIVO]
		aImpXls[nPosicao, nPosDTLIB ] := aAuxTT[nPosTT, ATT_DATLIB]
		aImpXls[nPosicao, nPosDTFEC ] := aAuxTT[nPosTT, ATT_DATFEC]
		aImpXls[nPosicao, nPosDTCAN ] := aAuxTT[nPosTT, ATT_DATCAN]
		aImpXls[nPosicao, nPosNRONF ] := aAuxTT[nPosTT, ATT_NUMNFI]
		aImpXls[nPosicao, nPosSERIEN] := aAuxTT[nPosTT, ATT_SERNFI]
		aImpXls[nPosicao, nPosPECATT] := aAuxTT[nPosTT, ATT_TOTPECA]
		aImpXls[nPosicao, nPosTOPATT] := Transform(aAuxTT[nPosTT, ATT_TEMPAD], "@E 99999:99")
		aImpXls[nPosicao, nPosTOTRTT] := Transform(aAuxTT[nPosTT, ATT_TEMTRA], "@E 99999:99")
		aImpXls[nPosicao, nPosTOCOTT] := Transform(aAuxTT[nPosTT, ATT_TEMCOB], "@E 99999:99")
		aImpXls[nPosicao, nPosTOVETT] := Transform(aAuxTT[nPosTT, ATT_TEMVEN], "@E 99999:99")
		aImpXls[nPosicao, nPosSERVTT] := aAuxTT[nPosTT, ATT_TOTSRVC] 
	EndIf
Return

Static Function CabSection(oReport, cText, lFatLine, lThinLine)
Local oFontTmp := oReport:oFontBody

Default lFatLine := .T.
Default lThinLine := .T.

	oReport:oFontBody := TFont():New(oReport:cFontBody,0,-10,,.T.)
	If lFatLine
		oReport:FatLine()
	EndIf
	oReport:PrintText(cText,, (oReport:PageWidth() + oReport:LeftMargin() - oReport:Char2Pix(Len(cText)))/2)
	If lThinLine
		oReport:ThinLine()
	Else
		oReport:SkipLine() // Não adiciona linha na tabela, somente no relatório.
	EndIf
	oReport:oFontBody := oFontTmp

Return nil

