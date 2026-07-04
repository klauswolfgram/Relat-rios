/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/


#INCLUDE "PMSR360.CH"
#INCLUDE "PROTHEUS.CH"

Static _oPMSR3601

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณ PMSR360  ณ Autor ณ Daniel Tadashi Batori     ณ Data ณ 10.01.07 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Relatorio de Produtos Empenhados                               ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe e ณ U_PMSR360(void)                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Generico                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PMSR360()
Local oReport

If PMSBLKINT()
	Return Nil
EndIf

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ ReportDefณ Autor ณ Daniel Batori         ณ Data ณ 10/01/2007 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Definicao do layout do Relatorio									    ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ ReportDef(void)                                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                     ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport  
Local oSec1
Local oSec11
Local oSec111
Local oSec2
Local oSec21
//array com tamanho das celulas
//         {Origem,Numero}
Local aTam := {15,    10}
Local lEmpEst := .F. 
Private nTamDesc := 70

Pergunte("PMR360", .F.)

oReport := TReport():New("PMSR360",STR0001,"PMR360",; //"Produtos Empenhados"
{|oReport| ReportPrint(oReport)},STR0002) //"Relat๓rio dos Produtos Empenhados dos Projetos"

oReport:SetPortrait()

dbSelectArea("AFJ")
lEmpEst := .T.
dbCloseArea()

oSec1 := TRSection():New(oReport,STR0006+STR0010,{"TRB","AF8","SA1"},{STR0003,STR0004},.F.,.F.) //"PROJETO+TAREFA+PRODUTO","PRODUTO+PROJETO+TAREFA"
TRCell():New(oSec1,"AF8_PROJET","AF8",,,,.F.,{|| AF8->AF8_PROJET } )
TRCell():New(oSec1,"AF8_DESCRI","AF8",,,,.F.,{|| AF8->AF8_DESCRI } )
TRCell():New(oSec1,"A1_COD","SA1",,,,.F.,{|| SA1->A1_COD } )
TRCell():New(oSec1,"A1_LOJA","SA1",,,,.F.,{|| SA1->A1_LOJA } )
TRCell():New(oSec1,"A1_NOME","SA1",,,,.F.,{|| FATPDObfuscate(SA1->A1_NOME,"A1_NOME",Nil,.T.) } )
TRPosition():New(oSec1,"AF8",1, {|| xFilial("AF8") + TRB->AFJ_PROJET })
TRPosition():New(oSec1,"SA1",1, {|| xFilial("SA1") + AF8->(AF8_CLIENT+AF8_LOJA) })

oSec11 := TRSection():New(oSec1,STR0007,{"TRB","AF9"},,.F.,.F.) //"Tarefa"
TRCell():New(oSec11,"AF9_TAREFA","AF9",,,,.F.,{|| AF9->AF9_TAREFA } )
TRCell():New(oSec11,"AF9_DESCRI","AF9",,,,.F.,{|| AF9->AF9_DESCRI } )
TRPosition():New(oSec11,"AF9",5, {|| xFilial("AF9") + TRB->(AFJ_PROJET+AFJ_TAREFA) })
oSec11:SetLeftMargin(5)

oSec111 := TRSection():New(oSec11,STR0008,{"TRB","SB1"},,.F.,.F.) //"Produto"
TRCell():New(oSec111,"B1_COD","SB1",,,,.F.,{|| SB1->B1_COD } )
TRCell():New(oSec111,"B1_DESC","SB1",,,,.F.,{|| SB1->B1_DESC } )
TRCell():New(oSec111,"AFJ_QEMP","AFJ",,,,.F.,{|| TRB->AFJ_QEMP },,,"RIGHT" )
TRCell():New(oSec111,"AFJ_QATU","AFJ",,,,.F.,{|| TRB->AFJ_QATU },,,"RIGHT" )
TRCell():New(oSec111,"ORIGEM","",STR0012,,aTam[1],.F.,{|| Origem() },,, ) //"Origem"
TRCell():New(oSec111,"NUMERO","",STR0013,,aTam[2],.F.,{|| Numero() },,, ) //"N๚mero"


If lEmpEst
	TRCell():New(oSec111,"SALDO","",STR0018,,aTam[2],.F.,{|| TRB->AFJ_QEMP - (TRB->AFJ_QATU + TRB->AFJ_EMPEST) },,,) //"Saldo"
EndIf

TRPosition():New(oSec111,"SB1",1,{|| xFilial("SB1") + TRB->AFJ_COD })
oSec111:SetLeftMargin(5)

oSec11:SetParentFilter ( {|cParam| TRB->AFJ_PROJET == cParam},{|| TRB->AFJ_PROJET })
oSec111:SetParentFilter( {|cParam| TRB->(AFJ_PROJET+AFJ_TAREFA) == cParam},{|| TRB->(AFJ_PROJET+AFJ_TAREFA) })


oSec2 := TRSection():New(oReport,STR0008+STR0011,{"TRB","SB1"},,.F.,.F.) //"Produto"
TRCell():New(oSec2,"B1_COD","SB1",,,,.F.,{|| SB1->B1_COD } )
TRCell():New(oSec2,"B1_DESC","SB1",,,,.F.,{|| SB1->B1_DESC } )
TRPosition():New(oSec2,"SB1",1,{|| xFilial("SB1") + TRB->AFJ_COD })

oSec21 := TRSection():New(oSec2,STR0006+"+"+STR0007,{"TRB","AF8","AF9","AFJ"},,.F.,.F.) //"Projeto"+"Tarefa"
TRCell():New(oSec21,"AF8_PROJET","AF8",,,,.F.,{|| AF8->AF8_PROJET } )
TRCell():New(oSec21,"AF8_DESCRI","AF8",,,nTamDesc,.F.,{|| AF8->AF8_DESCRI } )
TRCell():New(oSec21,"AF9_TAREFA","AF9",,,,.F.,{|| AF9->AF9_TAREFA } )
TRCell():New(oSec21,"AF9_DESCRI","AF9",,,nTamDesc,.F.,{|| AF9->AF9_DESCRI } )
TRCell():New(oSec21,"AFJ_QEMP","AFJ",,,,.F.,{|| TRB->AFJ_QEMP },,,"RIGHT" )
TRCell():New(oSec21,"AFJ_QATU","AFJ",,,,.F.,{|| TRB->AFJ_QATU },,,"RIGHT" )
TRCell():New(oSec21,"ORIGEM","",STR0012,,aTam[1],.F.,{|| Origem() },,,) //"Origem"
TRCell():New(oSec21,"NUMERO","",STR0013,,aTam[2],.F.,{|| Numero() },,,) //"N๚mero"

If lEmpEst
	TRCell():New(oSec21,"SALDO","",STR0018,,aTam[2],.F.,{|| TRB->AFJ_QEMP - (TRB->AFJ_QATU + TRB->AFJ_EMPEST) },,,) //"Saldo"
EndIf

TRPosition():New(oSec21,"AF8",1, {|| xFilial("AF8") + TRB->AFJ_PROJET })
TRPosition():New(oSec21,"AF9",5, {|| xFilial("AF9") + TRB->(AFJ_PROJET+AFJ_TAREFA) })
TRFunction():New(oSec21:Cell("AFJ_QEMP"),"TOT_EMP","SUM",,,,,.T.,.F.)
TRFunction():New(oSec21:Cell("AFJ_QATU"),"TOT_ATU","SUM",,,,,.T.,.F.)
oSec21:SetTotalInLine(.F.)
oSec21:SetLeftMargin(5)
oSec21:SetTotalText(STR0009) //"Total"

oSec21:SetParentFilter ( {|cParam| TRB->AFJ_COD == cParam},{|| TRB->AFJ_COD })

Return oReport                                                                              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณReportPrintณ Autor ณDaniel Batori          ณ Data ณ10/01/2007ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณA funcao estatica ReportDef devera ser criada para todos os  ณฑฑ
ฑฑณ          ณrelatorios que poderao ser agendados pelo usuario.           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณNenhum                                                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณExpO1: Objeto Report do Relat๓rio                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao efetuada                          ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                             ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)
Local oSec := oReport:Section(oReport:Section(1):GetOrder())

CRIATRB(oReport)
TRB->(DbGotop())

dbSelectArea("AFJ")
	If oReport:GetOrientation() == 1
		nTamDesc := 40
	Else
		nTamDesc := 70
	EndIf		

oSec:Print()

dbSelectArea("TRB")
dbCloseArea()

If _oPMSR3601 <> Nil
	_oPMSR3601:Delete()
	_oPMSR3601 := Nil
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCRIATRB   บAutor  ณDaniel Tadashi Batori  บ Data ณ  10/01/2007 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o arquivo temporario que contem os registros a serem      บฑฑ
ฑฑบ          ณimpressos                                                      บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณoReport : objeto da classe TReport                             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PMSR360                                                       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CRIATRB(oReport)
Local nOrdem  := oReport:Section(1):GetOrder()
Local oSec    := oReport:Section(nOrdem)
Local aEstru  :={}
Local cArqInd
Local aChave  := {}
Local cFiltro := ""
Local lEmpEst := .F.
#IFDEF TOP
	Local cAliasQry := GetNextAlias()
#ENDIF

aTam := TamSX3("AFJ_PROJET")
Aadd(aEstru, { "AFJ_PROJET" , "C" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_TAREFA")
Aadd(aEstru, { "AFJ_TAREFA" , "C" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_COD")
Aadd(aEstru, { "AFJ_COD"    , "C" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_QEMP")
Aadd(aEstru, { "AFJ_QEMP"   , "N" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_QATU")
Aadd(aEstru, { "AFJ_QATU"   , "N" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_ROTGER")
Aadd(aEstru, { "AFJ_ROTGER" , "C" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_TRT")
Aadd(aEstru, { "AFJ_TRT"    , "C" , aTam[1] , aTam[2] } )
aTam := TamSX3("AFJ_PLANEJ")
Aadd(aEstru, { "AFJ_PLANEJ" , "C" , aTam[1] , aTam[2] } )

dbSelectArea("AFJ")
lEmpest := .T.
dbCloseArea()

If lEmpEst
	aTam := TamSX3("AFJ_EMPEST")
	aAdd(aEstru, {"AFJ_EMPEST", "N", aTam[1] , aTam[2] } )
EndIf	

If nOrdem == 1
	aChave := {"AFJ_PROJET","AFJ_TAREFA","AFJ_COD"}
Else
	aChave := {"AFJ_COD","AFJ_PROJET","AFJ_TAREFA"}
EndIf

If _oPMSR3601 <> Nil
	_oPMSR3601:Delete()
	_oPMSR3601 := Nil
Endif

_oPMSR3601 := FWTemporaryTable():New( "TRB" )  
_oPMSR3601:SetFields(aEstru) 	
_oPMSR3601:AddIndex("1", aChave)

//------------------
//Cria็ใo da tabela temporaria
//------------------
_oPMSR3601:Create()	

oReport:NoUserFilter()
cFiltro := oSec:GetSqlExp()
If !Empty(cFiltro)
	cFiltro := " AND " + cFiltro
EndIf

//Transforma parametros do tipo Range em expressao SQL para ser utilizada no filtro
MakeSqlExpr("PMR360")
If !Empty(Mv_Par01)
	cFiltro += " AND " + Mv_Par01
EndIf
If !Empty(Mv_Par02)
	cFiltro += " AND " + Mv_Par02
EndIf

cFiltro := "% " + cFiltro + " %"

If lEmpEst 
BeginSql Alias cAliasQry
		SELECT AFJ_PROJET, AFJ_TAREFA, AFJ_COD, AFJ_QEMP, AFJ_QATU, AFJ_ROTGER, AFJ_TRT, AFJ_PLANEJ, AFJ_EMPEST
		FROM %Table:AFJ% AFJ
				JOIN %table:AF8% AF8 ON AF8_FILIAL = %xFilial:AF8% AND AF8_PROJET = AFJ_PROJET AND AF8.%NotDel%
				JOIN %table:AF9% AF9 ON AF9_FILIAL = %xFilial:AF9% AND AF9_PROJET = AFJ_PROJET AND AF9_REVISA = AF8_REVISA AND AF9_TAREFA = AFJ_TAREFA AND AF9.%NotDel%
				JOIN %table:SB1% SB1 ON  B1_FILIAL = %xFilial:SB1% AND B1_COD = AFJ_COD AND SB1.%NotDel%
				LEFT JOIN %table:SA1% SA1 ON  A1_FILIAL = %xFilial:SA1% AND A1_COD = AF8_CLIENT AND A1_LOJA = AF8_LOJA AND SA1.%NotDel%
		WHERE AFJ_FILIAL = %xFilial:AFJ% AND
				AFJ.%NotDel%
				%Exp:cFiltro%
	EndSQL			
Else
	BeginSql Alias cAliasQry
		SELECT AFJ_PROJET, AFJ_TAREFA, AFJ_COD, AFJ_QEMP, AFJ_QATU, AFJ_ROTGER, AFJ_TRT, AFJ_PLANEJ
		FROM %Table:AFJ% AFJ
				JOIN %table:AF8% AF8 ON AF8_FILIAL = %xFilial:AF8% AND AF8_PROJET = AFJ_PROJET AND AF8.%NotDel%
				JOIN %table:AF9% AF9 ON AF9_FILIAL = %xFilial:AF9% AND AF9_PROJET = AFJ_PROJET AND AF9_REVISA = AF8_REVISA AND AF9_TAREFA = AFJ_TAREFA AND AF9.%NotDel%
				JOIN %table:SB1% SB1 ON  B1_FILIAL = %xFilial:SB1% AND B1_COD = AFJ_COD AND SB1.%NotDel%
				LEFT JOIN %table:SA1% SA1 ON  A1_FILIAL = %xFilial:SA1% AND A1_COD = AF8_CLIENT AND A1_LOJA = AF8_LOJA AND SA1.%NotDel%
		WHERE AFJ_FILIAL = %xFilial:AFJ% AND
				AFJ.%NotDel%
				%Exp:cFiltro%
	EndSQL
EndIf

(cAliasQry)->(dbGoTop())

While (cAliasQry)->(!Eof())
	If ( Mv_Par03==1 .And. (cAliasQry)->(AFJ_QEMP-(AFJ_QATU+AFJ_EMPEST))<=0 ) .Or.; //Empenhos em Aberto
		( Mv_Par03==3 .And. (cAliasQry)->(AFJ_QEMP-(AFJ_QATU+AFJ_EMPEST))!=0 )       //Empenhos Fechados
		(cAliasQry)->(dbSkip())
		Loop
	EndIf

	RecLock( "TRB" , .T. )
	TRB->AFJ_PROJET := (cAliasQry)->AFJ_PROJET
	TRB->AFJ_TAREFA := (cAliasQry)->AFJ_TAREFA
	TRB->AFJ_COD    := (cAliasQry)->AFJ_COD
	TRB->AFJ_QEMP   := (cAliasQry)->AFJ_QEMP
	TRB->AFJ_QATU   := (cAliasQry)->AFJ_QATU
	TRB->AFJ_ROTGER := (cAliasQry)->AFJ_ROTGER
	TRB->AFJ_TRT    := (cAliasQry)->AFJ_TRT
	TRB->AFJ_PLANEJ := (cAliasQry)->AFJ_PLANEJ
	If lEmpEst
		TRB->AFJ_EMPEST := (cAliasQry)->AFJ_EMPEST 
	EndIf
	MsUnlock()
	(cAliasQry)->(dbSkip())
EndDo

(cAliasQry)->(DbCloseArea())
                                                       		
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOrigem    บAutor  ณDaniel Tadashi Batori  บ Data ณ  10/01/2007 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณfuncao para retornar a origem do empenho                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณdescricao da origem (string)                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PMSR360                                                       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Origem()
Local cRet := ""

Do Case
	Case TRB->AFJ_ROTGER == "1"
		cRet := STR0014 //"Solic.Compra"
   Case TRB->AFJ_ROTGER == "2"
  		cRet := STR0015 //"Ord.Prod"
	Case TRB->AFJ_ROTGER == "3"
		cRet := STR0016 //"Ped.Compra"
	Case TRB->AFJ_ROTGER == "4"
		cRet := STR0017 //"Planejam."
EndCase

Return cRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัอออออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNumero    บAutor  ณDaniel Tadashi Batori  บ Data ณ  10/01/2007 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o numero do documento de origem do empenho             บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณnumero do documento de origem                                  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PMSR360                                                       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Numero()
Local cRet
Do Case
	Case TRB->AFJ_ROTGER == "1" //"Solic.Compra"
		AFG->(DbSetOrder(4))
		AFG->(DbSeek( xFilial("AFG") + TRB->AFJ_PROJET + AF8->AF8_REVISA + TRB->AFJ_TAREFA + TRB->AFJ_TRT ))
		cRet := AFG->AFG_NUMSC
   Case TRB->AFJ_ROTGER == "2" //"Ord.Prod"
   	AFM->(DbSetOrder(4))
		AFM->(DbSeek( xFilial("AFM") + TRB->AFJ_PROJET + AF8->AF8_REVISA + TRB->AFJ_TAREFA + TRB->AFJ_TRT ))
		cRet := AFM->AFM_NUMOP
	Case TRB->AFJ_ROTGER == "3" //"Ped.Compra"
   	AJ7->(DbSetOrder(4))
		AJ7->(DbSeek( xFilial("AJ7") + TRB->AFJ_PROJET + TRB->AFJ_TAREFA + TRB->AFJ_TRT ))
		cRet := AJ7->AJ7_NUMPC
	Case TRB->AFJ_ROTGER == "4" //"Planejam."
		cRet := TRB->AFJ_PLANEJ
EndCase

Return cRet

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

