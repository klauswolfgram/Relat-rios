/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "pmsr380.ch"

Static _oPMSR3801

User Function PMSR380()
	Local oReport

	Private cArqTmp

	If PMSBLKINT()
		Return Nil
	EndIf

	dbSelectArea("AF8")
	dbSetOrder(1)
	dbSeek(xFilial("AF8"))

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInterface de impressao                                                  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oReport := ReportDef()
	oReport:PrintDialog()

	If _oPMSR3801 <> Nil
		_oPMSR3801:Delete()
		_oPMSR3801 := Nil
	Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณMarcelo Akama       บ Data ณ  17/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local cPerg		:= "PMR380"
Local cDesc1	:= STR0001 //"Este programa tem como objetivo imprimir relatorio "
Local cDesc2	:= STR0002 //"de acordo com os parametros informados pelo usuario."
Local cDesc3	:= STR0003 //"Previsto X Realizado de Recursos do Projeto"

Local oReport
Local oApont_AFU
Local oRecurso
Local oApontamentoR
Local oProjeto
Local oApontamentoP
Local oEquipe
Local oApontamentoE
Local aOrdem  := {}

Local aCfg:={;
				{ Titulo("AFU_DATA"  ),   X3Picture("AFU_DATA"), TamSX3("AFU_DATA")[1]+4 },;	// Data 
				{ Titulo("AE8_RECURS"), X3Picture("AE8_RECURS"), TamSX3("AE8_RECURS")[1] },;	// Cod Recurso
				{ Titulo("AE8_DESCRI"), X3Picture("AE8_DESCRI"), TamSX3("AE8_DESCRI")[1] },;	// Nome Recurso
				{ Titulo("AED_EQUIP" ), X3Picture("AED_EQUIP" ), TamSX3("AED_EQUIP" )[1] },;	// Cod Equipe
				{ Titulo("AED_DESCRI"), X3Picture("AED_DESCRI"), TamSX3("AED_DESCRI")[1] },;	// Descr. Equipe
				{ Titulo("AF8_PROJET"), X3Picture("AF8_PROJET"), TamSX3("AF8_PROJET")[1] },;	// Cod Projeto
				{ Titulo("AF8_DESCRI"), X3Picture("AF8_DESCRI"), TamSX3("AF8_DESCRI")[1] },;	// Titulo do projeto
				{ Titulo("AF9_TAREFA"), X3Picture("AF9_TAREFA"), TamSX3("AF9_TAREFA")[1] },;	// Tarefa
				{ Titulo("AF9_DESCRI"), X3Picture("AF9_DESCRI"), TamSX3("AF9_DESCRI")[1] },;	// Descr Tarefa
				{ STR0014             , X3Picture("AFU_HQUANT"), TamSX3("AFU_HQUANT")[1] },;	// Horas Prevista
				{ STR0015             , X3Picture("AFU_CUSTO1"), TamSX3("AFU_CUSTO1")[1] },;	// Custo Previsto
				{ STR0016             , X3Picture("AFU_HQUANT"), TamSX3("AFU_HQUANT")[1] },;	// Horas Realizadas
				{ STR0017             , X3Picture("AFU_CUSTO1"), TamSX3("AFU_CUSTO1")[1] };		// Custo Realizado
			}


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do componente de impressao                                      ณ
//ณ                                                                        ณ
//ณTReport():New                                                           ณ
//ณExpC1 : Nome do relatorio                                               ณ
//ณExpC2 : Titulo                                                          ณ
//ณExpC3 : Pergunte                                                        ณ
//ณExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ณ
//ณExpC5 : Descricao                                                       ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oReport := TReport():New("PMSR380",STR0003, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1+CRLF+cDesc2+CRLF+cDesc3 )
//STR0003 "Previsto X Realizado de Recursos do Projeto"

Pergunte(cPerg,.F.)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ PARAMETROS                                                             ณ
//ณ MV_PAR01 : Projeto de  ?                                               ณ
//ณ MV_PAR02 : Projeto ate ?                                               ณ
//ณ MV_PAR03 : Recurso de  ?                                               ณ
//ณ MV_PAR04 : Recurso ate ?                                               ณ
//ณ MV_PAR05 : Data de     ?                                               ณ
//ณ MV_PAR06 : Data ate    ?                                               ณ
//ณ MV_PAR07 : Quebra      ?  1 - Por Recurso / 2 - Por Projeto /          ณ
//                                              3 - Por Equipe             ณ
//ณ MV_PAR08 : Equipe de   ?                                               ณ
//ณ MV_PAR09 : Equipe ate  ?                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oReport:SetLandscape()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao da secao utilizada pelo relatorio                               ณ
//ณ                                                                        ณ
//ณTRSection():New                                                         ณ
//ณExpO1 : Objeto TReport que a secao pertence                             ณ
//ณExpC2 : Descricao da se็ao                                              ณ
//ณExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ณ
//ณ        sera considerada como principal para a se็ใo.                   ณ
//ณExpA4 : Array com as Ordens do relat๓rio                                ณ
//ณExpL5 : Carrega campos do SX3 como celulas                              ณ
//ณ        Default : False                                                 ณ
//ณExpL6 : Carrega ordens do Sindex                                        ณ
//ณ        Default : False                                                 ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oRecurso := TRSection():New(oReport, STR0004, {"cArqTmp"}, aOrdem /*{}*/, .F., .F.)
TRCell():New(oRecurso,	"RECURSO"		,"cArqTmp",aCfg[ 2,1],aCfg[ 2,2],aCfg[ 2,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oRecurso,	"NOME"			,"cArqTmp",aCfg[ 3,1],aCfg[ 3,2],aCfg[ 3,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oRecurso,	"EQUIPE"		,"cArqTmp",aCfg[ 4,1],aCfg[ 4,2],aCfg[ 4,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)

oRecurso:SetLineStyle()

oApontamentoR := TRSection():New(oRecurso, STR0013, {"cArqTmp"}, /*{aOrdem}*/, .F., .F.) //"Previsto X Realizado"
TRCell():New(oApontamentoR,	"DT"			,"cArqTmp",aCfg[ 1,1],aCfg[ 1,2],aCfg[ 1,3],/*lPixel*/,{|| DTOC(("cArqTmp")->DT) })
TRCell():New(oApontamentoR,	"PROJETO"		,"cArqTmp",aCfg[ 6,1],aCfg[ 6,2],aCfg[ 6,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"DSCPROJ"		,"cArqTmp",aCfg[ 7,1],aCfg[ 7,2],aCfg[ 7,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"TAREFA"		,"cArqTmp",aCfg[ 8,1],aCfg[ 8,2],aCfg[ 8,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"DSCTAREFA"		,"cArqTmp",aCfg[ 9,1],aCfg[ 9,2],aCfg[ 9,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"EQUIPE"		,"cArqTmp",aCfg[ 4,1],aCfg[ 4,2],aCfg[ 4,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"DSCEQUIPE"		,"cArqTmp",aCfg[ 5,1],aCfg[ 5,2],aCfg[ 5,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"HORAPREV"		,"cArqTmp",aCfg[10,1],aCfg[10,2],aCfg[10,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"CUSTPREV"		,"cArqTmp",aCfg[11,1],aCfg[11,2],aCfg[11,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"HORAREAL"		,"cArqTmp",aCfg[12,1],aCfg[12,2],aCfg[12,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoR,	"CUSTREAL"		,"cArqTmp",aCfg[13,1],aCfg[13,2],aCfg[13,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)


oApontamentoR:Cell("PROJETO"):SetLineBreak()
oApontamentoR:Cell("TAREFA"):SetLineBreak()
oApontamentoR:Cell("EQUIPE"):SetLineBreak()

oProjeto := TRSection():New(oReport, STR0005, {"cArqTmp"}, aOrdem /*{}*/, .F., .F.)
TRCell():New(oProjeto,	"PROJETO"		,"cArqTmp",aCfg[ 6,1],aCfg[ 6,2],aCfg[ 6,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"DSCPROJ"		,"cArqTmp",aCfg[ 7,1],aCfg[ 7,2],aCfg[ 7,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
oProjeto:SetLineStyle()

oApontamentoP := TRSection():New(oProjeto, STR0013, {"cArqTmp"}, /*{aOrdem}*/, .F., .F.) //"Previsto X Realizado"
TRCell():New(oApontamentoP,	"DT"			,"cArqTmp",aCfg[ 1,1],aCfg[ 1,2],aCfg[ 1,3],/*lPixel*/,{|| DTOC(("cArqTmp")->DT) })
TRCell():New(oApontamentoP,	"TAREFA"		,"cArqTmp",aCfg[ 8,1],aCfg[ 8,2],aCfg[ 8,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"DSCTAREFA"		,"cArqTmp",aCfg[ 9,1],aCfg[ 9,2],aCfg[ 9,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"RECURSO"		,"cArqTmp",aCfg[ 2,1],aCfg[ 2,2],aCfg[ 2,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"NOME"			,"cArqTmp",aCfg[ 3,1],aCfg[ 3,2],aCfg[ 3,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"EQUIPE"		,"cArqTmp",aCfg[ 4,1],aCfg[ 4,2],aCfg[ 4,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"DSCEQUIPE"		,"cArqTmp",aCfg[ 5,1],aCfg[ 5,2],aCfg[ 5,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"HORAPREV"		,"cArqTmp",aCfg[10,1],aCfg[10,2],aCfg[10,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"CUSTPREV"		,"cArqTmp",aCfg[11,1],aCfg[11,2],aCfg[11,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"HORAREAL"		,"cArqTmp",aCfg[12,1],aCfg[12,2],aCfg[12,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoP,	"CUSTREAL"		,"cArqTmp",aCfg[13,1],aCfg[13,2],aCfg[13,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)

oApontamentoP:Cell("TAREFA"):SetLineBreak()
oApontamentoP:Cell("EQUIPE"):SetLineBreak()
oApontamentoP:Cell("RECURSO"):SetLineBreak()

oEquipe := TRSection():New(oReport, STR0006, {"cArqTmp"}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oEquipe,	"EQUIPE"		,"cArqTmp",aCfg[ 4,1],aCfg[ 4,2],aCfg[ 4,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oEquipe,	"DSCEQUIPE"		,"cArqTmp",aCfg[ 5,1],aCfg[ 5,2],aCfg[ 5,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
oEquipe:SetLineStyle()

oApontamentoE := TRSection():New(oEquipe, STR0013, {"cArqTmp"}, /*{aOrdem}*/, .F., .F.) //"Previsto X Realizado"
TRCell():New(oApontamentoE,	"DT"			,"cArqTmp",aCfg[ 1,1],aCfg[ 1,2],aCfg[ 1,3],/*lPixel*/,{|| DTOC(("cArqTmp")->DT) })
TRCell():New(oApontamentoE,	"PROJETO"		,"cArqTmp",aCfg[ 6,1],aCfg[ 6,2],aCfg[ 6,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"DSCPROJ"		,"cArqTmp",aCfg[ 7,1],aCfg[ 7,2],aCfg[ 7,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"TAREFA"		,"cArqTmp",aCfg[ 8,1],aCfg[ 8,2],aCfg[ 8,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"DSCTAREFA"		,"cArqTmp",aCfg[ 9,1],aCfg[ 9,2],aCfg[ 9,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"RECURSO"		,"cArqTmp",aCfg[ 2,1],aCfg[ 2,2],aCfg[ 2,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"NOME"			,"cArqTmp",aCfg[ 3,1],aCfg[ 3,2],aCfg[ 3,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"HORAPREV"		,"cArqTmp",aCfg[10,1],aCfg[10,2],aCfg[10,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"CUSTPREV"		,"cArqTmp",aCfg[11,1],aCfg[11,2],aCfg[11,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"HORAREAL"		,"cArqTmp",aCfg[12,1],aCfg[12,2],aCfg[12,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oApontamentoE,	"CUSTREAL"		,"cArqTmp",aCfg[13,1],aCfg[13,2],aCfg[13,3],/*lPixel*/,/*{|| bloco-de-impressao }*/)

oApontamentoE:Cell("PROJETO"):SetLineBreak()
oApontamentoE:Cell("TAREFA"):SetLineBreak()
oApontamentoE:Cell("RECURSO"):SetLineBreak()

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor  ณMarcelo Akama     บ Data ณ  17/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)
Local aArea		:= GetArea()

Private oProcess := NIL

//Cria tabela temporแria no banco de dados
CriaTrb()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta tabela temporaria para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !IsBlind()	
	oProcess := MsNewProcess():New( {|lEnd| FillTrb(cArqTmp, lEnd, oProcess)} , STR0018 )	// "Criando Arquivo Temporario..."
	oProcess:Activate()
Else
	FillTrb("cArqTmp")
Endif

dbSelectArea("cArqTmp")
dbSetOrder(1)
dbGoTop()

Do Case
	Case mv_par07 == 1
		Pmr380_Rec(oReport)
	Case mv_par07 == 2
		Pmr380_Prj(oReport)
	Case mv_par07 == 3
		Pmr380_Eqp(oReport)
End Case

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPmr380_Rec  บAutor  ณMarcelo Akama     บ Data ณ  17/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pmr380_Rec(oReport)
Local oRecurso 		:= oReport:Section(1)
Local oApontamento 	:= oReport:Section(1):Section(1)
Local oTotCustP, oTotHoraP, oTotCustR, oTotHoraR

("cArqTmp")->(dbGoTop())

If !("cArqTmp")->(EoF())

	oReport:SetMeter(("cArqTmp")->(RecCount()))
	
	oApontamento:SetParentFilter({|cParam| ("cArqTmp")->(RECURSO+TAREFA) == cParam  },{|| ("cArqTmp")->(RECURSO+TAREFA)})

	oApontamento:SetLinesBefore(0)
	oApontamento:SetHeaderPage()
	
	oTotHoraP := TRFunction():New(oApontamento:Cell("HORAPREV"),"NSUMHORAP"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustP := TRFunction():New(oApontamento:Cell("CUSTPREV"),"NSUMCUSTOP" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotHoraR := TRFunction():New(oApontamento:Cell("HORAREAL"),"NSUMHORAR"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustR := TRFunction():New(oApontamento:Cell("CUSTREAL"),"NSUMCUSTOR" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)

	oApontamento:SetTotalInLine(.F.)
	oReport:SetTotalInLine(.F.)

	oApontamento:SetTotalText(STR0007) //"TOTAIS DO RECURSO "
	oReport:SetTotalText(STR0008) //"TOTAL GERAL DOS RECURSOS "

	oRecurso:Print()
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPmr380_Prj  บAutor  ณMarcelo Akama     บ Data ณ  17/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pmr380_Prj(oReport)
Local oRecurso     := oReport:Section(2)
Local oApontamento := oReport:Section(2):Section(1)
Local oTotCustP, oTotHoraP, oTotCustR, oTotHoraR

("cArqTmp")->(dbGoTop())

If !("cArqTmp")->(EoF())

	oReport:SetMeter(("cArqTmp")->(RecCount()))
	
	oApontamento:SetParentFilter({|cParam| ("cArqTmp")->(PROJETO+REVISAO+TAREFA+RECURSO) == cParam  },{|| ("cArqTmp")->(PROJETO+REVISAO+TAREFA+RECURSO) })

	oApontamento:SetLinesBefore(0)
	oApontamento:SetHeaderPage()
	
	oTotHoraP := TRFunction():New(oApontamento:Cell("HORAPREV"),"NSUMHORAP"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustP := TRFunction():New(oApontamento:Cell("CUSTPREV"),"NSUMCUSTOP" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotHoraR := TRFunction():New(oApontamento:Cell("HORAREAL"),"NSUMHORAR"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustR := TRFunction():New(oApontamento:Cell("CUSTREAL"),"NSUMCUSTOR" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)

	oApontamento:SetTotalInLine(.F.)
	oReport:SetTotalInLine(.F.)

	oApontamento:SetTotalText(STR0007) //"TOTAIS DO RECURSO "
	oReport:SetTotalText(STR0010) //"TOTAL GERAL DOS PROJETOS "

	oRecurso:Print()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPmr380_Eqp  บAutor  ณMarcelo Akama     บ Data ณ  17/08/09   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pmr380_Eqp(oReport)
Local oRecurso 		:= oReport:Section(3)
Local oApontamento 	:= oReport:Section(3):Section(1)
Local oTotCustP, oTotHoraP, oTotCustR, oTotHoraR

("cArqTmp")->(dbGoTop())

If !("cArqTmp")->(EoF())

	oReport:SetMeter(("cArqTmp")->(RecCount()))
	
oApontamento:SetParentFilter({|cParam| ("cArqTmp")->EQUIPE == cParam  },{|| ("cArqTmp")->EQUIPE })

	oApontamento:SetLinesBefore(0)
	oApontamento:SetHeaderPage()
	
	oTotHoraP := TRFunction():New(oApontamento:Cell("HORAPREV"),"NSUMHORAP"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustP := TRFunction():New(oApontamento:Cell("CUSTPREV"),"NSUMCUSTOP" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotHoraR := TRFunction():New(oApontamento:Cell("HORAREAL"),"NSUMHORAR"  ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)
	oTotCustR := TRFunction():New(oApontamento:Cell("CUSTREAL"),"NSUMCUSTOR" ,"SUM",,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/)

	oApontamento:SetTotalInLine(.F.)
	oReport:SetTotalInLine(.F.)

	oApontamento:SetTotalText(STR0011) //"TOTAIS DA EQUIPE "
	oReport:SetTotalText(STR0012) //"TOTAL GERAL DAS EQUIPES "
	oReport:SetTotalInLine(.F.)

	oRecurso:Print()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSeekCusto1  บAutor  ณReynaldo Miyashitaบ Data ณ  25/02/08   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBusca o custo do apontamento do recurso, caso o tipo de     บฑฑ
ฑฑบ          ณ apontamento seja por custo m้dio. Pois deve procurar a     บฑฑ
ฑฑบ          ณ movimentacao interna gerada pelo apontamento.              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SeekCusto1(cCodTipoReal,cCodProduto ,cLocal ,cNumSeq ,nCusto)
Local aAreaSD3 := SD3->(GetArea())

DEFAULT nCusto := 0

	If cCodTipoReal == "1" // Custo real por custo medio, ou seja a movimentacao interna
		dbSelectArea("SD3")
		dbSetOrder(3)
		If dbSeek(xFilial("SD3")+cCodProduto+cLocal+cNumSeq)
			nCusto := SD3->D3_CUSTO1
		EndIf
	EndIf
	
RestArea(aAreaSD3)
Return nCusto


Static Function Titulo(cField)
Local cRet:=''
Local aArea:=GetArea()

dbSelectArea("SX3")
dbSetOrder(2)
If dbSeek(cField)
	cRet:=X3Titulo()
EndIf

RestArea(aArea)
Return cRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณ Fun…o    ณCriaTrb   ณ Autor ณ Marcelo Akama         ณ Data ณ 18/08/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Descri…o ณCria Arquivo Temporario para imprimir o Relatorio           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Sintaxe   ณCriaTrb()                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno    ณNome do arquivo temporario                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso       ณ SIGACTB                                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametros ณ                                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function CriaTrb()
			
Local aTamCusto	:= TamSX3("AFU_CUSTO1")
Local aTamHoras	:= TamSX3("AFU_HQUANT")
Local aTamRecur	:= TamSX3("AE8_RECURS")
Local aTamProje	:= TamSX3("AF8_PROJET")
Local aTamRevis	:= TamSX3("AF8_REVISA")
Local aTamTaref	:= TamSX3("AF9_TAREFA")
Local aTamEquip	:= TamSX3("AED_EQUIP")
Local aCampos
Local aChave

aCampos	:=	{;
				{ "DT"			, "D",            8,            0},;	// Data
				{ "RECURSO"		, "C", aTamRecur[1],            0},;	// Cod Recurso
				{ "NOME"		, "C",           30,            0},;	// Nome Recurso
				{ "EQUIPE"		, "C", aTamEquip[1],            0},;	// Cod Equipe
				{ "DSCEQUIPE"	, "C",           30,            0},;	// Descr. Equipe
				{ "PROJETO"		, "C", aTamProje[1],            0},;	// Cod Projeto
				{ "REVISAO"		, "C", aTamRevis[1],            0},;	// Revisao Projeto
				{ "DSCPROJ"		, "C",           90,            0},;	// Titulo do projeto
				{ "TAREFA"		, "C", aTamTaref[1],            0},;	// Tarefa
				{ "DSCTAREFA"	, "C",           90,            0},;	// Descr Tarefa
				{ "CUSTPREV"	, "N", aTamCusto[1], aTamCusto[2]},;	// Custo Previsto
				{ "HORAPREV"	, "N", aTamHoras[1], aTamHoras[2]},;	// Horas Prevista
				{ "CUSTREAL"	, "N", aTamCusto[1], aTamCusto[2]},;	// Custo Realizado
				{ "HORAREAL"	, "N", aTamHoras[1], aTamHoras[2]};		// Horas Realizadas
			}

If mv_par07 == 1
	aChave  := {"RECURSO","DT","PROJETO","REVISAO","TAREFA"}
ElseIf mv_par07 == 2
	aChave  := {"PROJETO","REVISAO","TAREFA","RECURSO","DT"}
Else
	aChave  := {"EQUIPE","RECURSO","DT","PROJETO","REVISAO","TAREFA"}
EndIf

If _oPMSR3801 <> Nil
	_oPMSR3801:Delete()
	_oPMSR3801 := Nil
Endif

_oPMSR3801 := FWTemporaryTable():New( "cArqTmp" )  
_oPMSR3801:SetFields(aCampos) 	
_oPMSR3801:AddIndex("1", aChave)
_oPMSR3801:AddIndex("2", {"DT","RECURSO","PROJETO","REVISAO","TAREFA"})

//------------------
//Cria็ใo da tabela temporaria
//------------------
_oPMSR3801:Create()	

Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณ Fun…o    ณFillTrb   ณ Autor ณ Marcelo Akama         ณ Data ณ 18/08/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Descri…o ณPopula o Arquivo Temporario para imprimir o Relatorio       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Sintaxe   ณFillTrb(cArqTmp,lEnd,oProc)                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno    ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso       ณ SIGACTB                                                    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametros ณ ExpC1 = Arquivo temporario                                 ณฑฑ
ฑฑณ           ณ ExpL1 = Acao do Codeblock                                  ณฑฑ
ฑฑณ           ณ ExpO1 = Objeto oProcess                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function FillTrb(cArqTmp,lEnd,oProc)
			
Local cIndTmp
Local dDtAux
Local lAppend
Local nHrs
Local nCust
Local dtIni
Local dtFim
Local cHoraIni
Local cHoraFim
Local nTot, nRec, nTasks
Local cObfNRecur := IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")  

dbSelectArea("AFU")
AFU->(dbSetOrder(1))

dbSelectArea("AF9")
AF9->(dbSetOrder(1))

dbSelectArea("AED")
AED->(dbSetOrder(1))

dbSelectArea("AE8")
AE8->(dbSetOrder(1))

dbSelectArea("AFA")
AFA->(dbSetOrder(1))

dbSelectArea("AF8")
AF8->(dbSetOrder(1))
AF8->(dbSeek( xFilial("AF8") + alltrim(mv_par01) ))
nTot:=0
nRec:=0
dbEval( {|x| nTot++ },,{|| !Eof() .And. AF8->AF8_FILIAL+AF8->AF8_PROJET <= xFilial("AF8")+alltrim(mv_par02)} )

If !IsBlind()	
	oProc:SetRegua1(nTot)
Endif

AF8->(dbSeek( xFilial("AF8") + alltrim(mv_par01) ))
Do While !AF8->(Eof()) .And. AF8->AF8_FILIAL+AF8->AF8_PROJET <= xFilial("AF8")+alltrim(mv_par02)
	nRec++
	
	If !IsBlind()	
		oProc:IncRegua1( STR0020+' '+alltrim(str(nRec))+' '+STR0021+' '+alltrim(str(nTot)) )
	Endif
	
	AFA->(dbSeek( xFilial("AFA") + AF8->AF8_PROJET + AF8->AF8_REVISA ))
	nTasks:=0
	AFA->( dbEval( {|x| nTasks++ },,{|| !AFA->(Eof()) .And. AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA == xFilial("AFA")+AF8->AF8_PROJET+AF8->AF8_REVISA} ) )
	AFA->(dbSeek( xFilial("AFA") + AF8->AF8_PROJET + AF8->AF8_REVISA ))
	
	If !IsBlind()	
		oProc:SetRegua2(nTasks)
	Endif
	
	Do While !AFA->(Eof()) .And. AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA == xFilial("AFA")+AF8->AF8_PROJET+AF8->AF8_REVISA
		
		If !IsBlind()	
			oProc:IncRegua2(STR0022)
		Endif
		
		If !Empty(AFA->AFA_RECURS) .And. AFA->AFA_RECURS >= alltrim(mv_par03) .And. AFA->AFA_RECURS <= alltrim(mv_par04)
			If AE8->(dbSeek( xFilial("AE8")+AFA->AFA_RECURS ))
				AED->(dbSeek( xFilial("AED")+AE8->AE8_EQUIP ))
				AF9->(dbSeek( xFilial("AF9")+AF8->AF8_PROJET+AF8->AF8_REVISA+AFA->AFA_TAREFA ))

				dtIni := AFA->AFA_START
                If DTOS(dtIni)<DTOS(mv_par05)
                	dtIni := mv_par05
                EndIf
				dtFim := AFA->AFA_FINISH
                If DTOS(dtFim)>DTOS(mv_par06)
                	dtFim := mv_par06
                EndIf
                
				dDtAux := dtIni
				Do While dDtAux <= dtFim
					If dDtAux == AFA->AFA_START
						cHoraIni := AFA->AFA_HORAI
					Else
						cHoraIni := "00:00"
					EndIf
					If dDtAux == AFA->AFA_FINISH
						cHoraFim := AFA->AFA_HORAF
					Else
						cHoraFim := "24:00"
					EndIf
					nHrs := PmsHrUtil(dDtAux,"00"+cHoraIni,"00"+cHoraFim,AE8->AE8_CALEND,,AF8->AF8_PROJET,AE8->AE8_RECURS) * (AFA->AFA_ALOC / 100)
					nCust:= AFA->AFA_CUSTD * nHrs
					If ("cArqTmp")->(dbSeek( DTOS(dDtAux)+AE8->AE8_RECURS+AF8->AF8_PROJET+AF8->AF8_REVISA+AF9->AF9_TAREFA ))
						lAppend := .F.
						nHrs    := nHrs  + ("cArqTmp")->HORAPREV
						nCust   := nCust + ("cArqTmp")->CUSTPREV
					Else
						lAppend := .T.
					EndIf				
					RecLock("cArqTmp", lAppend)
					("cArqTmp")->DT			:= dDtAux
					("cArqTmp")->RECURSO	:= AE8->AE8_RECURS
					("cArqTmp")->NOME		:= IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur) 
					("cArqTmp")->EQUIPE		:= AED->AED_EQUIP
					("cArqTmp")->DSCEQUIPE	:= AED->AED_DESCRI
					("cArqTmp")->PROJETO	:= AF8->AF8_PROJET
					("cArqTmp")->REVISAO	:= AF8->AF8_REVISA
					("cArqTmp")->DSCPROJ	:= AF8->AF8_DESCRI
					("cArqTmp")->TAREFA		:= AF9->AF9_TAREFA
					("cArqTmp")->DSCTAREFA	:= AF9->AF9_DESCRI
					("cArqTmp")->CUSTPREV	:= nCust
					("cArqTmp")->HORAPREV	:= nHrs
					MsUnlock()
					dDtAux := dDtAux + 1
				EndDo
			EndIf
		EndIf

		AFA->(dbSkip())
	EndDo

	AFU->(dbSeek( xFilial("AFU") + "1" + AF8->AF8_PROJET + AF8->AF8_REVISA ))
	nTasks:=0
	AFU->( dbEval( {|x| nTasks++ },,{|| !AFU->(Eof()) .And. AFU->AFU_FILIAL+AFU->AFU_CTRRVS+AFU->AFU_PROJET+AFU->AFU_REVISA == xFilial("AFU")+"1"+AF8->AF8_PROJET+AF8->AF8_REVISA} ) )
	AFU->(dbSeek( xFilial("AFU") + "1" + AF8->AF8_PROJET + AF8->AF8_REVISA ))
	
	If !IsBlind()	
		oProc:SetRegua2(nTasks)
	Endif	
	
	Do While !AFU->(Eof()) .And. AFU->AFU_FILIAL+AFU->AFU_CTRRVS+AFU->AFU_PROJET+AFU->AFU_REVISA == xFilial("AFU")+"1"+AF8->AF8_PROJET+AF8->AF8_REVISA
		
		If !IsBlind()	
			oProc:IncRegua2(STR0023)
		Endif
		
		If  AFU->AFU_RECURS >= alltrim(mv_par03) .And. AFU->AFU_RECURS <= alltrim(mv_par04);
				.And. DTOS(AFU->AFU_DATA) >= DTOS(mv_par05) .And. DTOS(AFU->AFU_DATA) <= DTOS(mv_par06);
				.And. AE8->(dbSeek( xFilial("AE8")+AFU->AFU_RECURS ))
			AED->(dbSeek( xFilial("AED")+AE8->AE8_EQUIP ))
			AFA->(dbSeek( xFilial("AFA")+AF8->AF8_PROJET+AF8->AF8_REVISA+AFU->AFU_TAREFA ))
			AF9->(dbSeek( xFilial("AF9")+AF8->AF8_PROJET+AF8->AF8_REVISA+AFA->AFA_TAREFA ))
			nHrs := AFU->AFU_HQUANT
			nCust:= SeekCusto1(AFU->AFU_TPREAL, AFU->AFU_COD, AFU->AFU_LOCAL, AFU->AFU_NUMSEQ, AFU->AFU_CUSTO1)
			If ("cArqTmp")->(dbSeek( DTOS(AFU->AFU_DATA)+AE8->AE8_RECURS+AF8->AF8_PROJET+AF8->AF8_REVISA+AFU->AFU_TAREFA ))
				lAppend := .F.
				nHrs    := nHrs  + ("cArqTmp")->HORAREAL
				nCust   := nCust + ("cArqTmp")->CUSTREAL
			Else
				lAppend := .T.
			EndIf
			
			aAreaAF9 := GetArea()
				posicione("AF9",1, XFILIAL("AF9")+AF8->AF8_PROJET+AF8->AF8_REVISA+AFU->AFU_TAREFA, "AF9_DESCRI")
			RestArea(aAreaAF9)
							
			RecLock("cArqTmp", lAppend)
			("cArqTmp")->DT			:= AFU->AFU_DATA
			("cArqTmp")->RECURSO	:= AE8->AE8_RECURS
			("cArqTmp")->NOME		:= IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur)   
			("cArqTmp")->EQUIPE		:= AED->AED_EQUIP
			("cArqTmp")->DSCEQUIPE	:= AED->AED_DESCRI
			("cArqTmp")->PROJETO	:= AF8->AF8_PROJET
			("cArqTmp")->REVISAO	:= AF8->AF8_REVISA
			("cArqTmp")->DSCPROJ	:= AF8->AF8_DESCRI
			("cArqTmp")->TAREFA		:= AFU->AFU_TAREFA
			("cArqTmp")->DSCTAREFA	:= AF9->AF9_DESCRI
			("cArqTmp")->CUSTREAL	:= nCust
			("cArqTmp")->HORAREAL	:= nHrs
			MsUnlock()
		EndIf

		AFU->(dbSkip())
	EndDo

	AF8->(dbSkip())
EndDo
			
dbSelectArea("cArqTmp")
dbSetOrder(1)

Return

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta fun็ใo deve utilizada somente ap๓s 
    a inicializa็ใo das variaveis atravez da fun็ใo FATPDLoad.
	Remover essa fun็ใo quando nใo houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, L๓gico, Retorna se o campo serแ ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa fun็ใo quando nใo houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Fun็ใo que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  