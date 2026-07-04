/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ษออออออออหออออออออป
// บ Versao บ 24     บ
// ศออออออออสออออออออผ
#INCLUDE "PROTHEUS.CH"
#INCLUDE "VEIVR050.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEIVR050  บ Autor ณ Ricardo Farinelli  บ Data ณ  31/05/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Veiculos Vendidos por Periodo.                บฑฑ
ฑฑบ          ณ Podera ou nao levar as devolucoes em consideracao.         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VEIVR050()
Private lA1_IBGE := IIf(SA1->(FieldPos("A1_IBGE")) > 0, .t., .f.)
Private cGruVei  := PadR(AllTrim(GetMv("MV_GRUVEI")), TamSx3("B1_GRUPO")[1], " ")

U_VR050R3()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ OFPR140R3ณ Autor ณ  Thiago        ณ Data ณ 21/06/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescriao ณ Pecas sem Movimento de ENTRADA e SAIDA              |ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VR050R3()
Local cPict          := ""
Local aRet           := {}
Local aParambox      := {}

Private Titulo       := STR0004 //Vendas de Veiculos no Periodo
Private nTipo        := 15
Private aReturn      := { STR0007, 1, STR0008, 1, 2, 1, "", 1} //### //"Zebrado"###"Administracao"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01

dbSelectArea("VV0")
dbSetOrder(1)

AADD(aParamBox, {1, STR0087, (dDataBase - day(dDataBase) + 1), "@D", "Naovazio()"                         , ""   , ".T.", 50, .T.}) // Data Inicial?
AADD(aParamBox, {1, STR0088, dDataBase                       , "@D", "Naovazio() .and. MV_PAR02>=MV_PAR01", ""   , ".T.", 50, .T.}) // Data Final?

AADD(aParamBox, {2, STR0089, "5", {'0=' + STR0027, '1=' + STR0028, '2=' + STR0029, '3=' + STR0030, '4=' + STR0031, '5=' + STR0049}, 100, "", .f.}) // Cons. Operacao?
AADD(aParamBox, {2, STR0090, "1", {'1=' + STR0091, '2=' + STR0092, '3=' + STR0093}                                                , 100, "", .f.}) // Tipo de Veiculo

AADD(aParamBox, {1, STR0094, Space(6)                        , "@!", ""                                  , "SA3", ".T.", 50, .F.}) // Vendedor
AADD(aParamBox, {1, STR0096, dDataBase                       , "@D", "MV_PAR06<=dDataBase"               , ""   , ".T.", 50, .F.}) // Data Referencia

AADD(aParamBox, {1, STR0118, Space(TamSX3("VV0_FILIAL")[1]), "@!", "Naovazio()"                         , "SM0"   , ".T.", TamSX3("VV0_FILIAL")[1], .T.}) // Filial de?
AADD(aParamBox, {1, STR0119, Space(TamSX3("VV0_FILIAL")[1]), "@!", "Naovazio()" 						 , "SM0"   , ".T.", TamSX3("VV0_FILIAL")[1], .T.}) // Filial ate?


If ParamBox(aParamBox, STR0004, @aRet,,,,,,,, .t., .t.)
	MV_PAR01 := aRet[1]
	MV_PAR02 := aRet[2]
	MV_PAR03 := aRet[3]
	MV_PAR04 := aRet[4]
	MV_PAR05 := aRet[5]
	MV_PAR06 := aRet[6]
	MV_PAR07 := aRet[7]
	MV_PAR08 := aRet[8]

	nTipo := IIf(aReturn[4] == 1, 15, 18)

	VR0500016_ChamadaImpressaoVeiculosVendidos()
EndIf
Return

/*/{Protheus.doc} VR0500016_ChamadaImpressaoVeiculosVendidos
Chamada para impressใo dos Veํculos Vendidos por Perํodo

@author Fernando Vitor Cavani
@since 14/08/2018
@version undefined

@type function
/*/
Static Function VR0500016_ChamadaImpressaoVeiculosVendidos()
Local oReport

oReport := ReportDef() // Nesta fun็ใo n๓s definimos a estrutura do relat๓rio, por exemplo as se็๕es, campos, totalizadores e etc.
oReport:SetLandscape() // Define orienta็ใo de pแgina do relat๓rio como paisagem.
oReport:PrintDialog()  // Essa fun็ใo serve para disparar a impressใo do TReport, ela que faz com que seja exibida a tela de configura็ใo de impressora e os bot๕es de parโmetros.
Return

/*/{Protheus.doc} ReportDef
Criando o padrใo para impressใo dos Veํculos Vendidos por Perํodo

@author Fernando Vitor Cavani
@since 14/08/2018
@version undefined

@type function
/*/
Static Function ReportDef()
Local cDesc := "" 
Local oReport
Local oSection1
Local oSection2
Local oSection3
Local oSection4

cSerNFI := cSituac := cDatMov := cTipFat := cCodTip := ""
cTipVen := cCodClL := cCidade := cEstado := cCodVen := ""
cTraCpa := cChaInt := cCodMar := cFabMod := cChassi := ""
cModVei := cDesMod := cComMod := cCorVei := cNumTra := ""
cFatMov := cPisVen := cCofVen := cTotICM := cAliICM := ""
cComInt := cLucBru := cVCAVei := cValIPI := cCoPgto := ""
cForPag := cTelFon := cEndCEP := cDtDigt := ""

cPreFor := cParcel := cVencto := cValor  := ""

cToVNot := cToPNot := cToCNot := ""
cToINot := cTCINot := cLuBNot := ""

cResOpe := cToVOpe := cToPOpe := cToCOpe := ""
cToIOpe := cTCIOpe := cLuBOpe := ""

cSerFil := ""

// Descri็ใo
cDesc := STR0001 // Este programa tem como objetivo imprimir as vendas
cDesc += CHR(10) + CHR(13)
cDesc += STR0002 // de veiculos realizadas no periodo selecionado.     
cDesc += CHR(10) + CHR(13)
cDesc += STR0003 // Poderao ser consideradas as devolucoes.

// Tํtulo (Vendas de Veiculos no Periodo)
Titulo += STR0009 + Dtoc(MV_PAR01) + STR0010 + Dtoc(MV_PAR02) // de # a
Titulo += IIF(MV_PAR03 == "0", STR0011,;                      // Vendas
		  IIF(MV_PAR03 == "1", STR0012,;                      // Simulacao
		  IIF(MV_PAR03 == "2", STR0013,;                      // Transferencia,"
		  IIf(MV_PAR03 == "3", STR0014,;                      // Remessa,"
		  IIf(MV_PAR03 == "4", STR0015, STR0016)))))          // Devolucao,Todas Operacoes
Titulo += STR0018 // "c/NF Cancelada)"###"c/NF Normal)"###"NF Canceladas e Normais)"

// TReport
oReport := TReport():New(           ;
	"VR050R",                       ;
	Titulo,                         ;
	,                               ;
	{|oReport| U_VEIVR50IMP(oReport)},;
	cDesc)

// Dados
oSection1 := TRSection():New(oReport, "oDados")

oReport:Section(1):SetLineStyle() // Define se imprime as c้lulas da se็ใo em linhas
oSection1:SetLinesBefore(0)       // Define a quantidade de linhas que serใo saltadas antes da impressใo da se็ใo

TRCell():New(oSection1, "oSerFil",, STR0125, "@!"               , 18,, {|| cSerFil },,,,) // [Fil. da NF/SER] 
TRCell():New(oSection1, "oSerNFI",, STR0098, "@!"               , 12,, {|| cSerNFI },,,,) // [No.NF/Ser]
TRCell():New(oSection1, "oSituac",, STR0099, "@!"               , 12,, {|| cSituac },,,,) // [Situacao]
TRCell():New(oSection1, "oDatMov",, STR0100, "@!"               , 12,, {|| cDatMov },,,,) // [Dt Vda]
TRCell():New(oSection1, "oTipFat",, STR0101, "@!"               , 15,, {|| cTipFat },,,,) // [Tp Faturam.]
TRCell():New(oSection1, "oCodTip",, STR0102, "@!"               , 33,, {|| cCodTip },,,,) // [Tipo de Venda------------------]
TRCell():New(oSection1, "oTipVen",, STR0103, "@!"               , 15,, {|| cTipVen },,,,) // [Tipo Operacao]
TRCell():New(oSection1, "oCodClL",, STR0104, "@!"               , 33,, {|| cCodClL },,,,) // [Cliente----------------------]
TRCell():New(oSection1, "oCidade",, STR0105, "@!"               , 25,, {|| cCidade },,,,) // [Cidade----------------]
TRCell():New(oSection1, "oEstado",, STR0106, "@!"               ,  5,, {|| cEstado },,,,) // [UF]
TRCell():New(oSection1, "oCodVen",, STR0107, "@!"               , 25,, {|| cCodVen },,,,) // [Vendedor-------------]
TRCell():New(oSection1, "oTraCpa",, STR0108, "@!"               , 12,, {|| cTraCpa },,,,) // [Tran.Ent]
TRCell():New(oSection1, "oChaInt",, STR0109, "@!"               , 12,, {|| cChaInt },,,,) // [C.In]
TRCell():New(oSection1, "oCodMar",, STR0110, "@!"               , 18,, {|| cCodMar },,,,) // [Marca------]
TRCell():New(oSection1, "oFabMod",, STR0111, "@!"               , 10,, {|| cFabMod },,,,) // [Fab/Mod]
TRCell():New(oSection1, "oChassi",, STR0112, "@!"               , 25,, {|| cChassi },,,,) // [Chassi do Veiculo------]
TRCell():New(oSection1, "oModVei",, STR0113, "@!"               , 33,, {|| cModVei },,,,) // [Codigo Modelo---------------]
TRCell():New(oSection1, "oDesMod",, STR0114, "@!"               , 33,, {|| cDesMod },,,,) // [Descricao Modelo------------]
TRCell():New(oSection1, "oComMod",, STR0115, "@!"               , 20,, {|| cComMod },,,,) // [Complemento Modelo]
TRCell():New(oSection1, "oCorVei",, STR0116, "@!"               , 40,, {|| cCorVei },,,,) // [Cor do Veiculo------------------------]
TRCell():New(oSection1, "oNumTra",, STR0117, "@!"               , 12,, {|| cNumTra },,,,) // [Tran.Sai]
TRCell():New(oSection1, "oFatMov",, STR0032, "@E 999,999,999.99", 14,, {|| cFatMov },,,,) // Valor da Venda
TRCell():New(oSection1, "oPisVen",, STR0033, "@E 999,999,999.99", 14,, {|| cPisVen },,,,) // Valor Pis
TRCell():New(oSection1, "oCofVen",, STR0034, "@E 999,999,999.99", 14,, {|| cCofVen },,,,) // Valor Cofins
TRCell():New(oSection1, "oTotICM",, STR0035, "@E 999,999,999.99", 14,, {|| cTotICM },,,,)// Valor ICMS
TRCell():New(oSection1, "oAliICM",, STR0036, "@E 999.99"        ,  7,, {|| cAliICM },,,,)// Aliq. ICMS
TRCell():New(oSection1, "oComInt",, STR0037, "@E 999,999,999.99", 14,, {|| cComInt },,,,)// Comissao Intermediarios
TRCell():New(oSection1, "oLucBru",, STR0038, "@E 999,999,999.99", 14,, {|| cLucBru },,,,)// Lucro Bruto
TRCell():New(oSection1, "oVCAVei",, STR0074, "@E 999,999,999.99", 14,, {|| cVCAVei },,,,)// Valor Custo
TRCell():New(oSection1, "oValIPI",, STR0086, "@E 999,999,999.99", 14,, {|| cValIPI },,,,)// Valor do IPI
TRCell():New(oSection1, "oForPag",, STR0120, "@!"               , 20,, {|| cCoPgto },,,,)
TRCell():New(oSection1, "oForPag",, STR0121, "@!"               , 20,, {|| cForPag },,,,)
TRCell():New(oSection1, "oTelFon",, STR0122, "@!"               , 20,, {|| cTelFon },,,,) // Tel
TRCell():New(oSection1, "oEndCEP",, STR0123, "@!"               , 33,, {|| cEndCEP },,,,) // End # CEP
TRCell():New(oSection1, "oDtDigt",, STR0124, "@!"               , 12,, {|| cDtDigt },,,,)
// Parcelas
oSection2 := TRSection():New(oReport, "oParcelas")

oSection2:SetLeftMargin(129) // Define o tamanho da margem a esquerda
oSection2:SetLinesBefore(0)  // Define a quantidade de linhas que serใo saltadas antes da impressใo da se็ใo

TRCell():New(oSection2, "oPreFor",, STR0040, "@!"               , 20,, {|| cPreFor },,,,)         // Numero
TRCell():New(oSection2, "oParcel",, STR0041, "@!"               , 10,, {|| cParcel },,,,)         // Parcela
TRCell():New(oSection2, "oVencto",, STR0042, "@!"               , 12,, {|| cVencto },,,,)         // Vencimento
TRCell():New(oSection2, "oValor" ,, STR0043, "@E 999,999,999.99", 14,, {|| cValor } ,,, "RIGHT",) // Valor

// Totais (Notas)
oSection3 := TRSection():New(oReport, "oTotNotas")

oSection3:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection3:SetLinesBefore(5) // Define a quantidade de linhas que serใo saltadas antes da impressใo da se็ใo

TRCell():New(oSection3, "oResNot",, STR0050, "@!"               , 25,, {|| STR0058 },,,,)         // [-Resumo de Notas--] / Normais........
TRCell():New(oSection3, "oToVNot",, STR0051, "@E 999,999,999.99", 30,, {|| cToVNot },,, "RIGHT",) // [-Total da Venda--]
TRCell():New(oSection3, "oToPNot",, STR0052, "@E 999,999,999.99", 30,, {|| cToPNot },,, "RIGHT",) // [----Total Pis----]
TRCell():New(oSection3, "oToCNot",, STR0053, "@E 999,999,999.99", 30,, {|| cToCNot },,, "RIGHT",) // [--Total Cofins---]
TRCell():New(oSection3, "oToINot",, STR0054, "@E 999,999,999.99", 30,, {|| cToINot },,, "RIGHT",) // [---Total ICMS----]
TRCell():New(oSection3, "oToCNot",, STR0055, "@E 999,999,999.99", 30,, {|| cTCINot },,, "RIGHT",) // [Total Com. Inter.]
TRCell():New(oSection3, "oLuBNot",, STR0056, "@E 999,999,999.99", 30,, {|| cLuBNot },,, "RIGHT",) // [---Lucro Bruto---]

// Totais (Opera็๕es)
oSection4 := TRSection():New(oReport, "oTotOperacoes")

oSection4:SetLeftMargin(2)  // Define o tamanho da margem a esquerda
oSection4:SetLinesBefore(2) // Define a quantidade de linhas que serใo saltadas antes da impressใo da se็ใo

TRCell():New(oSection4, "oResOpe",, STR0059, "@!"               , 25,, {|| cResOpe },,,,)         // [-Resumo Operacoes-]
TRCell():New(oSection4, "oToVOpe",, STR0051, "@E 999,999,999.99", 30,, {|| cToVOpe },,, "RIGHT",) // [-Total da Venda--]
TRCell():New(oSection4, "oToPOpe",, STR0052, "@E 999,999,999.99", 30,, {|| cToPOpe },,, "RIGHT",) // [----Total Pis----]
TRCell():New(oSection4, "oToCOpe",, STR0053, "@E 999,999,999.99", 30,, {|| cToCOpe },,, "RIGHT",) // [--Total Cofins---]
TRCell():New(oSection4, "oToIOpe",, STR0054, "@E 999,999,999.99", 30,, {|| cToIOpe },,, "RIGHT",) // [---Total ICMS----]
TRCell():New(oSection4, "oToCOpe",, STR0055, "@E 999,999,999.99", 30,, {|| cTCIOpe },,, "RIGHT",) // [Total Com. Inter.]
TRCell():New(oSection4, "oLuBOpe",, STR0056, "@E 999,999,999.99", 30,, {|| cLuBOpe },,, "RIGHT",) // [---Lucro Bruto---]
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVEIVR50IMPบ Autor ณ Ricardo Farinelli  บ Data ณ  31/05/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio de vendas no บฑฑ
ฑฑบ          ณ periodo informado                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VEIVR50IMP(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)

Local nwnk     := 1
Local cCodCli  := ""
Local cLojCli  := ""
Local dDataVer := Ctod("")
Local dDataDev := Ctod("")
Local cSitNFI  := ""

Private nValTot   := 0 // Valor Total da Transacao (valida)
Private nValPis   := 0 // Valor Total de Pis (valida)
Private nValCof   := 0 // Valor Total de Cofins (valida)
Private nValICM   := 0 // Valor Total de Icms (valida)
Private nValCom   := 0 // Valor Total de Comissao de Intermediarios (valida)
Private nValBru   := 0 // Valor Total de Lucro Bruto (valida)
Private nValTotC  := 0 // Valor Total da Transacao (cancelada)
Private nValPisC  := 0 // Valor Total de Pis (cancelada)
Private nValCofC  := 0 // Valor Total de Cofins (cancelada)
Private nValICMC  := 0 // Valor Total de Icms (cancelada)
Private nValComC  := 0 // Valor Total de Comissao de Intermediarios (cancelada)
Private nValBruC  := 0 // Valor Total de Lucro Bruto (cancelada)
Private aValores  := {} // vetor com os totais por tipo de operacao
Private cTipo     := ""
Private cAliasVV0 := "SQLVV0"

dbSelectArea("VV0")
dbSetOrder(2)

// Imprime primeiro as vendas, depois as devolucoes caso o parametro esteja configurado para considerar devolucoes
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Data Inicial                                                     ณ
//ณMV_PAR02 = Data Final                                                       ณ
//ณMV_PAR03 = 0-venda,1-simulacao,2-transferencia,3-remessa,4-devolucao,5-todasณ
//ณMV_PAR04 = Considera Situacao da Nota Fiscal = Normal, Cancelada, Todas     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nwnk := 1 to Iif(MV_PAR03 == "5", 5, 1)
	cTipo := Alltrim(Str(IIf(MV_PAR03 == "5", nwnk - 1, Val(MV_PAR03)), 0))

	cQuery := "SELECT VV0.R_E_C_N_O_ AS RECVV0, "
	cQuery += "VVA.R_E_C_N_O_ AS RECVVA "
	cQuery += "FROM "+RetSqlName("VV0")+" VV0 "
	cQuery += "INNER JOIN "+RetSQLName("VVA")+" VVA "
	cQuery += " 	ON VVA.VVA_FILIAL = VV0.VV0_FILIAL "
	cQuery += "  	AND VVA.VVA_NUMTRA = VV0.VV0_NUMTRA AND VVA.D_E_L_E_T_ = ' ' "
	cQuery += "WHERE VV0.VV0_FILIAL BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' " 
	cQuery += "AND VV0.VV0_OPEMOV = '"+cTipo+"' "
	cQuery += "AND VV0.VV0_DATMOV >= '"+Dtos(MV_PAR01)+"' AND VV0.VV0_DATMOV <= '"+Dtos(MV_PAR02)+"' AND "
	If !Empty(MV_PAR05)
		cQuery += "VV0.VV0_CODVEN = '" + MV_PAR05 + "' AND "
	EndIf
	cQuery += "VV0.VV0_NUMNFI <> ' ' AND "
	If MV_PAR04 <> "1"
		If MV_PAR04 == "2"
			cQuery += "VV0.VV0_TIPFAT = '0' AND " // NOVOS
		ElseIf MV_PAR04 == "3"
			cQuery += "VV0.VV0_TIPFAT = '1' AND " // USADOS
		EndIf
	EndIf
	cQuery += "VV0.D_E_L_E_T_ = ' '"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV0, .T., .T. )

	Do While !(cAliasVV0 )->(Eof())
		VV0->(DbGoto((cAliasVV0)->(RECVV0)))

		// Posiciona nos principais arquivos
		VEIVR50POS()

		cSitNFI := VV0->VV0_SITNFI
		If VV0->VV0_SITNFI == "2" // Verifica se NF estava devolvida na data informada no Parโmetro
			dDataDev := FM_SQL("SELECT D1_DTDIGIT FROM " + RetSQLName("SD1") + " WHERE D1_FILIAL = '" + xFilial("SD1") + "' " +;
				" AND D1_NFORI = '" + VV0->VV0_NUMNFI + "' AND D1_SERIORI='" + VV0->VV0_SERNFI + "' AND D_E_L_E_T_ = ' '")
			If !Empty(MV_PAR06)
				dDataVer := Dtos(MV_PAR06)
			Else
				dDataVer := Dtos(dDataBase)
			EndIf

			If dDataDev <= dDataVer
				cSitNFI := "2"
			Else
				cSitNFI := "1"
			EndIf
		EndIf

		// Dados
		oSection1:Init()

		cSerFil := VV0->VV0_FILIAL + " " +FWFilialName(cEmpAnt, VV0->VV0_FILIAL,1) 
		cSerNFI := VV0->VV0_NUMNFI + "/" + FGX_MILSNF("VV0", 2, "VV0_SERNFI")
		cSituac := IIf(cSitNfi == "1", STR0021, IIf(cSitNfi == "2", STR0022, STR0023)) // "Valida"# #"Devolvida"# #"Cancelada"
		cDatMov := VV0->VV0_DATMOV
		cTipFat := IIf(VV0->VV0_TIPFAT == "0", STR0024, IIf(VV0->VV0_TIPFAT == "1", STR0025, STR0026)) // "Veiculo Novo"# #"Veiculo Usado"# #"Fat.Direto"
		cCodTip := VV0->VV0_TIPVEN + "-" + Left(VV3->VV3_DESCRI, 18)
		cTipVen := IIf(cTipo == "0", STR0027,     ;            // Venda
						IIf(cTipo == "1", STR0028,;            // Simulacao
						IIf(cTipo == "2", STR0029,;            // Transferencia
						IIf(cTipo == "3", STR0030, STR0031)))) // Remessa # Devolucao
		cCodClL := VV0->VV0_CODCLI + "/" + VV0->VV0_LOJA + "-" + Substr(SA1->A1_NOME, 1, 21)
		If lA1_IBGE
			cCidade := Left(VAM->VAM_DESCID, 23)
			cEstado := VAM->VAM_ESTADO
		Else
			cCidade := Left(SA1->A1_MUN, 23)
			cEstado := SA1->A1_EST
		EndIf
		cCodVen := Left(VV0->VV0_CODVEN + "-" + IIf(Empty(SA3->A3_NREDUZ), Substr(SA3->A3_NOME, 1, 15), SA3->A3_NREDUZ), 23)
		cTraCpa := VVA->VVA_TRACPA
		cChaInt := VVA->VVA_CHAINT
		cCodMar := VV1->VV1_CODMAR + "-" + Subs(VE1->VE1_DESMAR, 1, 10)
		cFabMod := Transform(VV1->VV1_FABMOD, "@R ####/####")
		cChassi := VV1->VV1_CHASSI
		cModVei := VV1->VV1_MODVEI
		cDesMod := VV2->VV2_DESMOD
		cComMod := VV1->VV1_COMMOD
		cCorVei := VV1->VV1_CORVEI + "-" + VVC->VVC_DESCRI
		cNumTra := VVA->VVA_NUMTRA

		// Valores
		// So existe registro no VVA se for venda ou devolucao
		If cTipo $ "04"
			cFatMov := VVA->VVA_FATTOT // Valor da Venda
			cPisVen := VVA->VVA_PISVEN // Valor Pis
			cCofVen := VVA->VVA_COFVEN // Valor Cofins
			cTotICM := VVA->VVA_ICMVEN // Valor ICMS
			cAliICM := VVA->VVA_ALIICM // Aliq. ICMS
			cComInt := 0               // Comissao Intermediarios
			cLucBru := VVA->VVA_LUCBRU // Lucro Bruto
			cVCAVei := VVA->VVA_VCAVEI // Valor Custo

			FGX_VV1SB1("CHAINT", VVA->VVA_CHAINT , /* cMVMIL0010 */ , cGruVei )

			cCodCli := VV0->VV0_CODCLI
			cLojCli := VV0->VV0_LOJA

			// LEASING -> Cliente Banco //
			If VV0->VV0_CATVEN == "7" .and. !Empty(VV0->VV0_CLIALI + VV0->VV0_LOJALI)
				cCodCli := VV0->VV0_CLIALI
				cLojCli := VV0->VV0_LOJALI
			EndIf

			DbSelectArea("SD2")
			DbSetOrder(3)
			If DbSeek(xFilial("SD2") + VV0->VV0_NUMNFI + VV0->VV0_SERNFI + cCodCli + cLojCli + SB1->B1_COD)
				cValIPI := SD2->D2_VALIPI // Valor do IPI
			Else
				cValIPI := 0 // Valor do IPI
			EndIf
		Else
			cFatMov := VV0->VV0_VALMOV // Valor da Venda
			cPisVen := 0               // Valor Pis
			cCofVen := 0               // Valor Cofins
			cTotICM := VV0->VV0_TOTICM // Valor ICMS
			cAliICM := VV0->VV0_ALIICM // Aliq. ICMS
			cComInt := 0               // Comissao Intermediarios
			cLucBru := 0               // Lucro Bruto
			cVCAVei := 0               // Valor Custo
			cValIPI := 0               // Valor do IPI
		EndIf

		// Totaliza Relatorio
		VEI50TOT()

		// Imprime Os Titulos Referentes a venda
		If cTipo == "0" .and. (!VV0->VV0_SITNFI $ "02") // cancelamento ou devolucao
			cCoPgto := VV0->VV0_FORPAG                                                            // Cond. Pagamento:
			cForPag := SE4->E4_DESCRI
			cTelFon := STR0082 + ": (" + SA1->A1_DDD + ")" + SA1->A1_TEL                   // Tel
			cEndCEP := STR0083 + ": " + substr(SA1->A1_END, 1, 35) + STR0084 + SA1->A1_CEP // End # CEP
			cDtDigt := SD1->D1_DTDIGIT

			oSection1:PrintLine()

			// Parcelas
			oSection2:Init()

			Do While !SE1->(Eof()) .and. SE1->E1_FILIAL == xFilial("SE1") .and. (SE1->E1_PREFIXO + Alltrim(SE1->E1_NUM)) == (SF2->F2_PREFIXO + VV0->VV0_NUMPED)
				If SE1->E1_PREFORI <> GetNewPar("MV_PREFVEI", "VEI")
					dbSelectArea("SE1")
					DBSkip()
					Loop
				EndIf

				cPreFor := SE1->E1_PREFORI + "/" + SE1->E1_NUM // Numero
				cParcel := SE1->E1_PARCELA                     // Parcela
				cVencto := SE1->E1_VENCTO                      // Vencimento
				cValor  := SE1->E1_VALOR                       // Valor

				oSection2:PrintLine()

				SE1->(Dbskip())
			EndDo

			oSection2:Finish()
		Else
			cCoPgto := "" // Cond. Pagamento:
			cForPag := ""
			cTelFon := "" // Tel
			cEndCEP := "" // End # CEP
			cDtDigt := ""

			oSection1:PrintLine()
		EndIf

		oSection1:Finish()

		oReport:ThinLine()

		dbSelectArea(cAliasVV0)
		(cAliasVV0)->(Dbskip())
	EndDo

	(cAliasVV0)->(dbCloseArea())
Next

// Totais
VEI50IMTOT(oReport)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEIVR50POSบAutor  ณRicardo Farinelli   บ Data ณ  11/22/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPosiciona nos arquivos a serem utilizados pela rotina de    บฑฑ
ฑฑบ          ณimpressao                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEIVR50POS()
// Saida de Veiculos - Avaliacao
VVA->(DbGoto((cAliasVV0)->(RECVVA)))

// Cadastro de Veiculos
VV1->(DbsetOrder(1))
VV1->(Dbseek(xFilial("VV1") + VVA->VVA_CHAINT))

// Cadastro de Vendedores
VVF->(DbSetOrder(1))
VVF->(DbSeek(xFilial("VVF") + VV1->VV1_TRACPA))

SD1->(DbSetOrder(1))
SD1->(DbSeek(xFilial("SD1") + VVF->VVF_NUMNFI))
SA3->(DbsetOrder(1))
SA3->(Dbseek(xFilial("SA3") + VV0->VV0_CODVEN))

// Titulos e Receber (caso seja venda normal)
If cTipo == "0"
	SF2->(DBSetOrder(1))
	SF2->(DBSeek(xFilial("SF2") + VV0->VV0_NUMNFI + VV0->VV0_SERNFI))
	SE1->(DbsetOrder(1))
	SE1->(Dbseek(xFilial("SE1") + SF2->F2_PREFIXO + VV0->VV0_NUMPED))
Endif

// Cadastro de Cores
VVC->(DbsetOrder(1))
VVC->(Dbseek(xFilial("VVC") + VV1->VV1_CODMAR + VV1->VV1_CORVEI))

// Tipo de Venda
VV3->(Dbsetorder(1))
VV3->(Dbseek(xFilial("VV3") + VV0->VV0_TIPVEN))

// Marca
VE1->(DbsetOrder(1))
VE1->(Dbseek(xFilial("VV1") + VV1->VV1_CODMAR))

// Modelo
VV2->(DbsetOrder(1))
VV2->(Dbseek(xFilial("VV2") + VV1->(VV1_CODMAR+VV1_MODVEI)))

// Condicao de Pagamento
SE4->(DbsetOrder(1))
SE4->(Dbseek(xFilial("SE4") + VV0->VV0_FORPAG))

// Cadastro de Clientes
SA1->(DbsetOrder(1))
SA1->(Dbseek(xFilial("SA1") + VV0->VV0_CODCLI + VV0->VV0_LOJA))

// Cadastro de Cidades
If lA1_IBGE
	VAM->(DbsetOrder(1))
	VAM->(Dbseek(xFilial("VAM") + SA1->A1_IBGE))
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEI50TOT  บAutor  ณRicardo Farinelli   บ Data ณ  05/30/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTotaliza as variaveis de rodape tanto de venda normal quantoบฑฑ
ฑฑบ          ณde devolucao                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEI50TOT()
Local nPos := 0

If cTipo $ "04"
	If VV0->VV0_SITNFI == "0" // Nf Cancelada
		nValTotC += VVA->VVA_FATTOT
		nValPisC += VVA->VVA_PISVEN
		nValCofC += VVA->VVA_COFVEN
		nValICMC += VVA->VVA_ICMVEN
		nValComC += 0
		nValBruC += VVA->VVA_LUCBRU
	ElseIf VV0->VV0_SITNFI == "1" // Nf Valida
		nValTot  += VVA->VVA_FATTOT
		nValPis  += VVA->VVA_PISVEN
		nValCof  += VVA->VVA_COFVEN
		nValICM  += VVA->VVA_ICMVEN
		nValCom  += 0
		nValBru  += VVA->VVA_LUCBRU
	EndIf
Else
	If VV0->VV0_SITNFI == "0" // Nf Cancelada
		nValTotC += VV0->VV0_VALMOV
		nValICMC += VV0->VV0_TOTICM
	ElseIf VV0->VV0_SITNFI == "1" // Nf Valida
		nValTot  += VV0->VV0_VALMOV
		nValICM  += VV0->VV0_TOTICM
	EndIf
EndIf

If cTipo $ "04"
	If (nPos := Ascan(aValores, ({|x| x[1] == cTipo + VV0->VV0_SITNFI}))) > 0
		aValores[nPos,2] += VVA->VVA_FATTOT
		aValores[nPos,3] += VVA->VVA_PISVEN
		aValores[nPos,4] += VVA->VVA_COFVEN
		aValores[nPos,5] += VVA->VVA_ICMVEN
		aValores[nPos,6] += 0
		aValores[nPos,7] += VVA->VVA_LUCBRU
	Else
		AAdd(aValores, ({cTipo + VV0->VV0_SITNFI, VVA->VVA_FATTOT, VVA->VVA_PISVEN, VVA->VVA_COFVEN, VVA->VVA_ICMVEN, 0, VVA->VVA_LUCBRU}))
	EndIf
Else
	If (nPos := Ascan(aValores, ({|x| x[1] == cTipo + VV0->VV0_SITNFI}))) > 0
		aValores[nPos,2] += VV0->VV0_VALMOV
		aValores[nPos,5] += VV0->VV0_TOTICM
		aValores[nPos,6] += 0
	Else
		AAdd(aValores, ({cTipo + VV0->VV0_SITNFI, VV0->VV0_VALMOV, 0, 0, VV0->VV0_TOTICM, 0, 0}))
	EndIf
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEI50IMTOTบAutor  ณRicardo Farinelli   บ Data ณ  05/30/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressao da linha dos totais de venda ou devolucao         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEI50IMTOT(oReport)
Local nwnk := 0
Local oSection1 := oReport:Section(3)
Local oSection2 := oReport:Section(4)

// Totais (Notas)
oSection1:Init()

cToVNot := nValTot // [-Total da Venda--]
cToPNot := nValPis // [----Total Pis----]
cToCNot := nValCof // [--Total Cofins---]
cToINot := nValIcm // [---Total ICMS----]
cTCINot := nValCom // [Total Com. Inter.]
cLuBNot := nValBru // [---Lucro Bruto---]

oSection1:PrintLine()
oSection1:Finish()

oReport:ThinLine()

// Totais (Opera็๕es)
If !Empty(aValores)
	oSection2:Init()

	Asort(aValores,,, {|x, y| x[1] < [y]})

	For nwnk := 1 to Len(aValores)
		cResOpe := Iif(aValores[nwnk, 1] == "01", STR0060,;      // Vendas.........
			Iif(aValores[nwnk, 1] == "11", STR0061,       ;      // Simulacao......
			Iif(aValores[nwnk, 1] == "21", STR0062,       ;      // Transferencia..
			Iif(aValores[nwnk, 1] == "31", STR0063,       ;      // Remessa........
			Iif(aValores[nwnk, 1] == "41", STR0064,       ;      // Devolucao......
			Iif(aValores[nwnk, 1] == "00", STR0065,       ;      // Vendas(c)......
			Iif(aValores[nwnk, 1] == "10", STR0066,       ;      // Simulacao(c)...
			Iif(aValores[nwnk, 1] == "20", STR0067,       ;      // Transf.(c).....
			Iif(aValores[nwnk, 1] == "30", STR0068,       ;      // Remessa(c).....
			Iif(aValores[nwnk, 1] == "40", STR0069, "")))))))))) // Devolucao(c)...

		cToVOpe := aValores[nwnk, 2] // [-Total da Venda--]
		cToPOpe := aValores[nwnk, 3] // [----Total Pis----]
		cToCOpe := aValores[nwnk, 4] // [--Total Cofins---]
		cToIOpe := aValores[nwnk, 5] // [---Total ICMS----]
		cTCIOpe := aValores[nwnk, 6] // [Total Com. Inter.]
		cLuBOpe := aValores[nwnk, 7] // [---Lucro Bruto---]

		oSection2:PrintLine()
	Next

	oSection2:Finish()

	oReport:ThinLine()
EndIf
Return