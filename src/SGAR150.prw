/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "SGAR150.ch"
#include "Protheus.ch"
#INCLUDE "Shell.CH"

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ SGAR150  ≥ Autor ≥ Felipe Nathan Welter  ≥ Data ≥ 22/02/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ RelatÛrio de Historico de Avaliacoes de Aspectos/Impactos  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ SigaSGA                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function SGAR150( lParam )

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Guarda conteudo e declara variaveis padroes ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Local aNGBEGINPRM := NGBEGINPRM()
Local oReport
Local oTempTRB1, oTempTRB2

Default lParam := .T.

Private lPerg := lParam
Private cPerg := "SGR150"

aDBF1 := {{"ORDEM","C",TAMSX3("TAB_ORDEM")[1],0},;
			{"DTRESU","D",TAMSX3("TAB_DTRESU")[1],0},;
			{"CODNIV","C",TAMSX3("TAB_CODNIV")[1],0},;
			{"CODPLA","C",TAMSX3("TAB_CODPLA")[1],0},;
			{"CODEME","C",TAMSX3("TAB_CODEME")[1],0},;
			{"CODASP","C",TAMSX3("TAB_CODASP")[1],0},;
			{"CODIMP","C",TAMSX3("TAB_CODIMP")[1],0},;
			{"CODCLA","C",TAMSX3("TAB_CODCLA")[1],0},;
			{"CODHIS","C",TAMSX3("TAO_CODHIS")[1],0},;
			{"RESULT","N",TAMSX3("TAB_RESULT")[1],2},;
			{"RECNO_TAB","N",10,0}}


cTRB1 := GetNextAlias()
oTempTRB1 := FWTemporaryTable():New( cTRB1, aDBF1 )
oTempTRB1:AddIndex( "1", {"CODHIS","ORDEM","CODASP","CODIMP"} )
oTempTRB1:Create()

aDBF2 := {{"ORDEM","C",TAMSX3("TAB_ORDEM")[1],0},;
			{"INDICA","C",TAMSX3("TAD_INDICA")[1],0},;
			{"CODAVA","C",TAMSX3("TAD_CODAVA")[1],0},;
			{"CODHIS","C",TAMSX3("TAP_CODHIS")[1],0},;
			{"CODOPC","C",TAMSX3("TAD_CODOPC")[1],0}}

cTRB2 := GetNextAlias()
oTempTRB2 := FWTemporaryTable():New( cTRB2, aDBF2 )
oTempTRB2:AddIndex( "1", {"CODHIS","ORDEM","INDICA","CODAVA","CODOPC"} )
oTempTRB2:Create()

If !lPerg .Or. Pergunte(cPerg,.T.) // 2013/03 - Gera em Excell
	If Mv_Par10 == 2 // Gera Execl
		Processa({ |lEnd| GeraXLS()},STR0029) //"Processando Arquivo..."
		Return
	ElseIf Mv_Par10 == 1
		If FindFunction("TRepInUse") .And. TRepInUse()
			//-- Interface de impressao
			oReport := ReportDef()
			oReport:SetLandScape() //Default Landspcape
			oReport:PrintDialog()
		Else
			U_SGAR150REL()
		EndIf
	Endif
Endif

oTempTRB1:Delete()
oTempTRB2:Delete()

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Retorna conteudo de variaveis padroes       ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
NGRETURNPRM(aNGBEGINPRM)

Return .T.

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥ ReportDef≥ Autor ≥ Felipe Nathan Welter  ≥ Data ≥ 22/01/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥ Define as secoes impressas no relatorio                    ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ SGAR150                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function ReportDef()
Local oReport
Local oSection1, oSection2, oSection3
Local oTotaliz
Local oCell

//LAYOUT
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
// Ordem   Cod.Historico  Dt.Desempenho   CÛdigo NÌvel Estrutur.  CÛdigo  Plano de AÁ„o   CÛdigo Plano Emerge.   CÛdigo Signific‚ncia______________________________
// 999999         999999     99/99/9999      999 XXXXXXXXXXXXXXX     999   XXXXXXXXXXXX       999 XXXXXXXXXXXX      999 XXXXXXXXXXXXX
//
//Aspecto_________________AvaliaÁ„o____________________OpÁ„o__________________________
//XXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//                                                     XXXXXXXXXXXXXX
//                        XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//                        XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//                                                     XXXXXXXXXXXXXX
//
//Impacto_________________AvaliaÁ„o____________________OpÁ„o__________________________
//XXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//                        XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//                        XXXXXXXXXXXXXXXXXXXXXX       XXXXXXXXXXXXXX
//

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Criacao do componente de impressao                                      ≥
//≥                                                                        ≥
//≥TReport():New                                                           ≥
//≥ExpC1 : Nome do relatorio                                               ≥
//≥ExpC2 : Titulo                                                          ≥
//≥ExpC3 : Pergunte                                                        ≥
//≥ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ≥
//≥ExpC5 : Descricao                                                       ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
oReport := TReport():New("SGAR150",OemToAnsi(STR0013),"",{|oReport| ReportPrint(oReport)},STR0013) //"HistÛrico das AvaliaÁıes de Aspectos/Impactos"###"HistÛrico das AvaliaÁıes de Aspectos/Impactos"
oReport:ParamReadOnly(.T.)
oReport:lDisableOrientation := .T.
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis utilizadas para parametros                       			   ≥
//≥ MV_PAR01     //  De Aspecto ?                                          ≥
//≥ MV_PAR02     //  Ate Aspecto ?                                         ≥
//≥ MV_PAR03     //  De Impacto ?                                          ≥
//≥ MV_PAR04     //  Ate Impacto ?                                         ≥
//≥ MV_PAR05     //  De Nivel Estrutura ?                                  ≥
//≥ MV_PAR06     //  Ate Nivel Estrutura ?                                 ≥
//≥ MV_PAR07     //  De Data ?                                             ≥
//≥ MV_PAR08     //  Ate Data ?                                            ≥
//≥ MV_PAR09     //  Apresenta Ord. Hist. ?                                ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

Pergunte(oReport:uParam,.F.)

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Criacao da secao utilizada pelo relatorio                               ≥
//≥                                                                        ≥
//≥TRSection():New                                                         ≥
//≥ExpO1 : Objeto TReport que a secao pertence                             ≥
//≥ExpC2 : Descricao da seÁao                                              ≥
//≥ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ≥
//≥        sera considerada como principal para a seÁ„o.                   ≥
//≥ExpA4 : Array com as Ordens do relatÛrio                                ≥
//≥ExpL5 : Carrega campos do SX3 como celulas                              ≥
//≥        Default : False                                                 ≥
//≥ExpL6 : Carrega ordens do Sindex                                        ≥
//≥        Default : False                                                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Criacao da celulas da secao do relatorio                                ≥
//≥                                                                        ≥
//≥TRCell():New                                                            ≥
//≥ExpO1 : Objeto TSection que a secao pertence                            ≥
//≥ExpC2 : Nome da celula do relatÛrio. O SX3 ser· consultado              ≥
//≥ExpC3 : Nome da tabela de referencia da celula                          ≥
//≥ExpC4 : Titulo da celula                                                ≥
//≥        Default : X3Titulo()                                            ≥
//≥ExpC5 : Picture                                                         ≥
//≥        Default : X3_PICTURE                                            ≥
//≥ExpC6 : Tamanho                                                         ≥
//≥        Default : X3_TAMANHO                                            ≥
//≥ExpL7 : Informe se o tamanho esta em pixel                              ≥
//≥        Default : False                                                 ≥
//≥ExpB8 : Bloco de cÛdigo para impressao.                                 ≥
//≥        Default : ExpC2                                                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

oSection1 := TRSection():New(oReport,STR0014,{cTRB1,"TAB","TAO","TAF","TAA","TBB","TA8"})  //"Ordem"
TRCell():New(oSection1,"(cTRB1)->ORDEM"  ,cTRB1,STR0014 ,/*Picture*/ ,TAMSX3("TAO_ORDEM")[1]+6) //"Ordem"
TRCell():New(oSection1,"CODHIS"          ,""     ,STR0015 ,"@!"        ,TAMSX3("TAO_CODHIS")[1]+22,/*lPixel*/,{|| cCodHis}) //"Cod.Historico"
TRCell():New(oSection1,"(cTRB1)->DTRESU" ,cTRB1,STR0016 ,"99/99/9999",TAMSX3("TAB_DTRESU")[1]+15) //"Dt. Desempenho"
TRCell():New(oSection1,"(cTRB1)->CODNIV" ,cTRB1,STR0017 ,/*Picture*/ ,TAMSX3("TAB_CODNIV")[1]+8) //"CÛdigo"
TRCell():New(oSection1,"TAF_NOMNIV"      ,"TAF"  ,STR0018 ,/*Picture*/ ,45 ,/*lPixel*/,{|| SubStr(TAF->TAF_NOMNIV, 1, 20) }) //"NÌvel Estrut."
TRCell():New(oSection1,"(cTRB1)->CODPLA" ,cTRB1,STR0017 ,/*Picture*/ ,TAMSX3("TAB_CODPLA")[1]+5) //"CÛdigo"
TRCell():New(oSection1,"TAA_NOME"        ,"TAA"  ,STR0019 ,/*Picture*/ ,75 ,/*lPixel*/,{|| SubStr(TAA->TAA_NOME, 1, 35) }) //"Plano de AÁ„o"
TRCell():New(oSection1,"(cTRB1)->CODEME" ,cTRB1,STR0017 ,/*Picture*/ ,TAMSX3("TAB_CODEME")[1]+5) //"CÛdigo"
TRCell():New(oSection1,"TBB_DESPLA"      ,"TBB"  ,STR0020 ,/*Picture*/ ,75 ,/*lPixel*/,{|| SubStr(TBB->TBB_DESPLA, 1, 35) }) //"Plano Emerge."
TRCell():New(oSection1,"(cTRB1)->CODCLA" ,cTRB1,STR0017 ,/*Picture*/ ,TAMSX3("TAB_CODCLA")[1]+5) //"CÛdigo"
TRCell():New(oSection1,"TA8_DESCRI"      ,"TA8"  ,STR0021 ,/*Picture*/ ,45 ,/*lPixel*/,{|| SubStr(TBB->TBB_DESPLA, 1, 20) }) //"Signific‚ncia"
TRPosition():New(oSection1,"TAF",2,{|| xFilial("TAF")+'001'+(cTRB1)->CODNIV})
TRPosition():New(oSection1,"TAA",1,{|| xFilial("TAA")+(cTRB1)->CODPLA})
TRPosition():New(oSection1,"TBB",1,{|| xFilial("TBB")+(cTRB1)->CODEME})
TRPosition():New(oSection1,"TA8",1,{|| xFilial("TA8")+(cTRB1)->CODCLA})

oSection2 := TRSection():New(oSection1,STR0022,{cTRB1,cTRB2,"TAD","TAP","TA4","TA6","TA7"}) //"Aspecto"
oCell := TRCell():New(oSection2,"(cTRB1)->CODASP" ,cTRB1,STR0022  ,"@!",TAMSX3("TAB_CODASP")[1]+15,/*lPixel*/,/*{|| code-block de impressao }*/) //"Aspecto"
oCell := TRCell():New(oSection2,"TA4_DESCRI"      ,"TA4"  ,""         ,/*Picture*/,TAMSX3("TA4_DESCRI")[1]+15)
oCell := TRCell():New(oSection2,"(cTRB2)->CODAVA" ,cTRB2,STR0023,"@!",TAMSX3("TAD_CODAVA")[1]+15,/*lPixel*/,/*{|| code-block de impressao }*/) //"AvaliaÁ„o"
oCell := TRCell():New(oSection2,"TA6_DESCRI"      ,"TA6"  ,""         ,/*Picture*/,TAMSX3("TA6_DESCRI")[1]+15)
oCell := TRCell():New(oSection2,"(cTRB2)->CODOPC" ,cTRB2,STR0024    ,"@!",TAMSX3("TAD_CODOPC")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"OpÁ„o"
oCell := TRCell():New(oSection2,"TA7_OPCAO"       ,"TA7"  ,""         ,/*Picture*/,TAMSX3("TA7_OPCAO")[1])
TRPosition():New(oSection2,"TA4",1,{|| xFilial("TA4")+(cTRB1)->CODASP})
TRPosition():New(oSection2,"TA6",1,{|| xFilial("TA6")+(cTRB2)->CODAVA})
TRPosition():New(oSection2,"TA7",1,{|| xFilial("TA7")+(cTRB2)->CODAVA+(cTRB2)->CODOPC})

oSection3 := TRSection():New(oSection1,STR0025,{cTRB1,cTRB2,"TAD","TAP","TAE","TA6","TA7"}) //"Impacto"
oCell := TRCell():New(oSection3,"(cTRB1)->CODIMP" ,cTRB1,STR0025  ,"@!",TAMSX3("TAB_CODIMP")[1]+6,/*lPixel*/,/*{|| code-block de impressao }*/) //"Impacto"
oCell := TRCell():New(oSection3,"TAE_DESCRI"      ,"TAE"  ,""         ,/*Picture*/,TAMSX3("TAE_DESCRI")[1]+15)
oCell := TRCell():New(oSection3,"(cTRB2)->CODAVA" ,cTRB2,STR0023,"@!",TAMSX3("TAD_CODAVA")[1]+6,/*lPixel*/,/*{|| code-block de impressao }*/) //"AvaliaÁ„o"
oCell := TRCell():New(oSection3,"TA6_DESCRI"      ,"TA6"  ,""         ,/*Picture*/,TAMSX3("TA6_DESCRI")[1]+15)
oCell := TRCell():New(oSection3,"(cTRB2)->CODOPC" ,cTRB2,STR0026    ,"@!",TAMSX3("TAD_CODOPC")[1],/*lPixel*/,/*{|| code-block de impressao }*/) //"OpÁ„o"
oCell := TRCell():New(oSection3,"TA7_OPCAO"       ,"TA7"  ,""         ,/*Picture*/,TAMSX3("TA7_OPCAO")[1])
TRPosition():New(oSection3,"TAE",1,{|| xFilial("TAE")+(cTRB1)->CODIMP})
TRPosition():New(oSection3,"TA6",1,{|| xFilial("TA6")+(cTRB2)->CODAVA})
TRPosition():New(oSection3,"TA7",1,{|| xFilial("TA7")+(cTRB2)->CODAVA+(cTRB2)->CODOPC})

Return oReport

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÖo    ≥ SGAR150REL≥ Autor ≥ Felipe Nathan Welter ≥ Data ≥ 22/01/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÖo ≥ Relatorio "HistÛrico das AvaliaÁıes de Aspectos/Impactos"  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ SGAR150                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
User Function SGAR150REL()

Local  WNREL     := "SGAR150REL"
Local  LIMITE    := 132
Local  cDesc1    := STR0013 //"HistÛrico das AvaliaÁıes de Aspectos/Impactos"
Local  cDesc2    := ""
Local  cDesc3    := ""
Local  cSTRING   := "TAB"

Private NOMEPROG  := "SGAR150"
Private TAMANHO   := "M"
Private aRETURN   := {STR0027,1,STR0028,1,2,1,"",1} //"Zebrado"###"Administracao"
Private nTIPO     := 0
Private nLASTKEY  := 0
Private Titulo    := STR0013 //"HistÛrico das AvaliaÁıes de Aspectos/Impactos"

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Verifica as perguntas selecionadas                           ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Variaveis utilizadas para parametros                       			   ≥
//≥ MV_PAR01     //  De Aspecto ?                                          ≥
//≥ MV_PAR02     //  Ate Aspecto ?                                         ≥
//≥ MV_PAR03     //  De Impacto ?                                          ≥
//≥ MV_PAR04     //  Ate Impacto ?                                         ≥
//≥ MV_PAR05     //  De Nivel Estrutura ?                                  ≥
//≥ MV_PAR06     //  Ate Nivel Estrutura ?                                 ≥
//≥ MV_PAR07     //  De Data ?                                             ≥
//≥ MV_PAR08     //  Ate Data ?                                            ≥
//≥ MV_PAR09     //  Apresenta Ord. Hist. ?                                ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Pergunte(cPerg,.F.)
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Envia controle para a funcao SETPRINT                        ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
WNREL:=SetPrint(cSTRING,WNREL,"",TITULO,cDESC1,cDESC2,cDESC3,.F.,"")
If nLASTKEY = 27
	Set Filter To
	dbSelectArea("TAB")
	Return
EndIf
SetDefault(aRETURN,cSTRING)
RptStatus({|lEND|SGAR150Imp(@lEND,WNREL,TITULO,TAMANHO)},TITULO)
dbSelectArea("TAB")

Return .T.

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥SGAR150Imp ≥ Autor ≥ Felipe Nathan Welter ≥ Data ≥ 22/10/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥Chamada do Relat¢rio                                        ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥SGAR150                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function SGAR150Imp(lEND,WNREL,TITULO,TAMANHO)

Local cRODATXT := ""
Local nCNTIMPR := 0

Private nomeprog := "SGAR150"
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Contadores de linha e pagina                                 ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Private li := 80 ,m_pag := 1
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Verifica se deve comprimir ou nao                            ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
nTIPO  := IIF(aRETURN[4]==1,15,18)
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta os Cabecalhos                                          ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
Private Cabec1   := " "
Private Cabec2   := " "

//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥ Monta os Cabecalhos                                          ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
// Ordem: 999999_______________________________________________________________________________________
//     Data do Desempenho: 99/99/99                         Nivel Estrutura: 999 - XXXXXXXXXXXXXX
//     Plano de Acao: 999999 - XXXXXXXXXXXXXXXXXXXX
//     Plano Emerge.: 999999 - XXXXXXXXXXXXXXXXXXXX
//
//     Aspecto: 999 - XXXX_____________________________________________________________________________
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//                                                 999 - XXXX
//                                                 999 - XXXX
//                                                 999 - XXXX
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//                                                 999 - XXXX
//
//     Impacto: 999 - XXXX_____________________________________________________________________________
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//
//     Signific‚ncia: XXXX - XXXXXXXXXXXXXXXXXXXXXX
//
// Ordem: 999999________________Cod.Historico: 999999__________________________________________________
//     Data Desemp..: 99/99/99                         Nivel Estrutura: 999 - XXXXXXXXXXXXXX
//     Plano de Acao: 999999 - XXXXXXXXXXXXXXXXXXXX
//     Plano Emerge.: 999999 - XXXXXXXXXXXXXXXXXXXX
//
//     Aspecto: 999 - XXXX_____________________________________________________________________________
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//
//     Impacto: 999 - XXXX_____________________________________________________________________________
//          999 - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX : 999 - XXXX
//
//     Signific‚ncia: XXXX - XXXXXXXXXXXXXXXXXXXXXX

//Ajusta parametros de/atÈ NÌvel Estrutura
If MV_PAR05 > MV_PAR06
	cTempPar  := MV_PAR05
	MV_PAR05 := MV_PAR06
	MV_PAR06 := cTempPar
EndIf

//Processa arquivo temporario
Processa({ |lEnd| SGAR150TRB()},STR0029) //"Processando Arquivo..."

NGSomaLi(58)

dbSelectArea(cTRB1)
dbSetOrder(01)
dbGoTop()

If (cTRB1)->(RecCount()) == 0
	MsgInfo(STR0050)  //"N„o h· nada para imprimir no relatÛrio."
	Return .F.
Endif

SetRegua((cTRB1)->(RecCount()))
While !Eof()

	IncRegua()

	@ Li,001 PSay STR0014+":" //"Ordem"
	@ Li,008 PSay (cTRB1)->ORDEM
	@ Li,030 PSay If(!Empty((cTRB1)->CODHIS),STR0015+": "+(cTRB1)->CODHIS,'') //"Cod.Historico"

	NgSomaLi(58)
	@ Li,001 PSay Replicate("-",100)
	NGSomaLi(58)

	@ Li,005 PSay STR0030+":" //"Data do Desempenho"
	@ Li,020 PSay DTOC((cTRB1)->DTRESU)
	@ Li,058 PSay STR0031+":" //"NÌvel Estrutura"
	@ Li,075 PSay (cTRB1)->CODNIV+" - "+NGSEEK("TAF",'001'+(cTRB1)->CODNIV,2,"TAF_NOMNIV")
	NGSomaLi(58)

	@ Li,005 PSay STR0019+":" //"Plano de AÁ„o"
	If !Empty((cTRB1)->CODPLA)
		@ Li,020 PSay (cTRB1)->CODPLA+" - "+SubStr(NGSEEK("TAA",(cTRB1)->CODPLA,1,"TAA_NOME"),1,40)
	EndIf
	NGSomaLi(58)

	@ Li,005 PSay STR0020+":" //"Plano Emerge."
	If !Empty((cTRB1)->CODEME)
		@ Li,020 PSay (cTRB1)->CODEME+" - "+SubStr(NGSEEK("TBB",(cTRB1)->CODEME,1,"TBB_DESPLA"),1,40)
	EndIf
	NGSomaLi(58)


	cChave1 := "(cTRB1)->CODHIS+(cTRB1)->ORDEM"
	cChave2 := "(cTRB2)->CODHIS+(cTRB2)->ORDEM"

	NGSomaLi(58)
	@ Li,005 PSay STR0022+":" //"Aspecto"
	@ Li,014 PSay (cTRB1)->CODASP+" - "+NGSEEK("TA4",(cTRB1)->CODASP,1,"TA4_DESCRI")
	NGSomaLi(58)
	@ Li,005 PSay Replicate("-",80)
	NGSomaLi(58)

	//Impressao do Aspecto
	dbSelectArea(cTRB2)
	dbSetOrder(01)
	dbSeek(&cChave1,.T.)
	While !Eof() .And. &cChave1 == &cChave2

		If (cTRB2)->INDICA == "1"

			@ Li,010 PSay (cTRB2)->CODAVA+" - "+SubStr(NGSEEK("TA6",(cTRB2)->CODAVA,1,"TA6_DESCRI"),1,30)
			cCodAva := (cTRB2)->CODAVA

			While !Eof() .And. cCodAva == (cTRB2)->CODAVA
				@ Li,049 PSay (cTRB2)->CODOPC+" - "+NGSEEK("TA7",(cTRB2)->CODAVA+(cTRB2)->CODOPC,1,"TA7_OPCAO")
				NGSomaLi(58)
				dbSelectArea(cTRB2)
				dbSkip()
			EndDo

		Else
			dbSelectArea(cTRB2)
			dbSkip()
		EndIf

	EndDo

	NGSomaLi(58)
	@ Li,005 PSay STR0025+":" //"Impacto"
	@ Li,014 PSay (cTRB1)->CODIMP+" - "+NGSEEK("TAE",(cTRB1)->CODIMP,1,"TAE_DESCRI")
	NGSomaLi(58)
	@ Li,005 PSay Replicate("-",80)
	NGSomaLi(58)

	//Impressao do Impacto
	dbSelectArea(cTRB2)
	dbSetOrder(01)
	dbSeek(&cChave1,.T.)
	While !Eof() .And. &cChave1 == &cChave2

		If (cTRB2)->INDICA == "2"

			@ Li,010 PSay (cTRB2)->CODAVA+" - "+SubStr(NGSEEK("TA6",(cTRB2)->CODAVA,1,"TA6_DESCRI"),1,30)
			@ Li,049 PSay (cTRB2)->CODOPC+" - "+NGSEEK("TA7",(cTRB2)->CODAVA+(cTRB2)->CODOPC,1,"TA7_OPCAO")
			NGSomaLi(58)

		EndIf

		dbSelectArea(cTRB2)
		dbSkip()

	EndDo

	NGSomaLi(58)
	@ Li,005 PSay STR0021+":" //"Signific‚ncia"
	@ Li,020 PSay (cTRB1)->CODCLA+" - "+NGSEEK("TA8",(cTRB1)->CODCLA,1,"TA8_DESCRI")
	NGSomaLi(58)

	NGSomaLi(58)
	dbSelectArea(cTRB1)
	dbSkip()

EndDo


RODA(nCNTIMPR,cRODATXT,TAMANHO)
//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
//≥Apaga arquivo de Trabalho                                  ≥
//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
RetIndex("TAB")
RetIndex("TAD")
RetIndex("TAO")
RetIndex("TAP")

Set Device To Screen
If aRETURN[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(WNREL)
EndIf
MS_FLUSH()

Return Nil

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥ReportPrint≥ Autor ≥ Felipe Nathan Welter  ≥ Data ≥ 22/01/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥Chamada do Relat¢rio                                         ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥ReportDef                                                    ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(2)

//Variaveis para controle de impressao de cabecalhos/titulos/secoes
Local lImpAsp := lImpImp := lImpAva := .T.

//Vari·veis utilizadas em code-block de impress„o
Private cCodHis

//Ajusta parametros de/atÈ NÌvel Estrutura
If MV_PAR05 > MV_PAR06
	cTempPar  := MV_PAR05
	MV_PAR05 := MV_PAR06
	MV_PAR06 := cTempPar
EndIf

//Processa arquivo temporario
Processa({ |lEnd| SGAR150TRB()},STR0029) //"Processando Arquivo..."

If (cTRB1)->(RecCount()) == 0
	MsgInfo(STR0050)  //"N„o h· nada para imprimir no relatÛrio."
	Return .F.
Endif

dbSelectArea(cTRB1)
dbSetOrder(01)
dbGoTop()
oReport:SetMeter((cTRB1)->(RecCount()))
While !Eof() .And. !oReport:Cancel()

	lImpAsp := .T.
	lImpImp := .T.

	cCodHis := If(!Empty((cTRB1)->CODHIS),(cTRB1)->CODHIS,'')

	oReport:IncMeter()

	oSection1:Init()
	oSection1:PrintLine()

		oSection2:Init()
		oSection3:Init()

		cChave1 := "(cTRB1)->CODHIS+(cTRB1)->ORDEM"
		cChave2 := "(cTRB2)->CODHIS+(cTRB2)->ORDEM"

		dbSelectArea(cTRB2)
		dbSetOrder(01)
		dbSeek(&cChave1,.T.)
		While !Eof() .And. &cChave1 == &cChave2

			If (cTRB2)->INDICA == "1"  //Impress„o de Aspectos

				cCodAva := (cTRB2)->CODAVA

				While !Eof() .And. cCodAva == (cTRB2)->CODAVA

					If lImpAsp
						oSection2:Cell("(cTRB1)->CODASP"):Show()
						oSection2:Cell("TA4_DESCRI"):Show()
						lImpAsp := .F.
					Else
						oSection2:Cell("(cTRB1)->CODASP"):Hide()
						oSection2:Cell("TA4_DESCRI"):Hide()
					EndIf

					If lImpAva
						oSection2:Cell("(cTRB2)->CODAVA"):Show()
						oSection2:Cell("TA6_DESCRI"):Show()
						lImpAva := .F.
					Else
						oSection2:Cell("(cTRB2)->CODAVA"):Hide()
						oSection2:Cell("TA6_DESCRI"):Hide()
					EndIf

					oSection2:PrintLine()

					dbSelectArea(cTRB2)
					dbSkip()

				EndDo

				lImpAva := .T.

			Else
				dbSelectArea(cTRB2)
				dbSkip()
			EndIf

		EndDo

		dbSelectArea(cTRB2)
		dbSetOrder(01)
		dbSeek(&cChave1,.T.)
		While !Eof() .And. &cChave1 == &cChave2

			If (cTRB2)->INDICA == "2"  //Impress„o de Impactos

				If lImpImp
					oSection3:Cell("(cTRB1)->CODIMP"):Show()
					oSection3:Cell("TAE_DESCRI"):Show()
					lImpImp := .F.
				Else
					oSection3:Cell("(cTRB1)->CODIMP"):Hide()
					oSection3:Cell("TAE_DESCRI"):Hide()
				EndIf

				oSection3:PrintLine()

			EndIf

			dbSelectArea(cTRB2)
			dbSkip()

		EndDo

		oSection2:Finish()
		oSection3:Finish()

	oSection1:Finish()

	dbSelectArea(cTRB1)
	dbSkip()

End

Return Nil

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥FunáÑo    ≥SGAR150TRB≥ Autor ≥ Felipe Nathan Welter  ≥ Data ≥ 22/01/10 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥DescriáÑo ≥Processa os arquivos e carrega arquivo temporario           ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso       ≥SGAR150                                                     ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
/*/
Static Function SGAR150TRB()

Local cQuery1, cQuery2

//Query seleciona Ordens de Resultados de Avaliacoes (TAB)
cQuery1 := " SELECT TAB_ORDEM AS ORDEM, TAB_DTRESU AS DTRESU, TAB_CODNIV AS CODNIV,"
cQuery1 += " TAB_CODPLA AS CODPLA, TAB_CODEME AS CODEME, TAB_CODASP AS CODASP,"
cQuery1 += " TAB_CODIMP AS CODIMP, TAB_CODCLA AS CODCLA, '' AS CODHIS , TAB_RESULT AS RESULT, TAB.R_E_C_N_O_ AS RECNO_TAB "

cQuery1 += " FROM "+RetSQLName("TAB")+" TAB"
cQuery1 += " WHERE TAB_CODASP BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
cQuery1 += " AND TAB_CODIMP BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
cQuery1 += " AND TAB_CODNIV BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
If NGCADICBASE("TAB_REVISA","A","TAB",.F.) .AND. !Empty(Mv_Par11) // Se Estiver implementado o Controle de Revis„o Filtra pela Revis„o
	cQuery1 += " AND TAB_REVISA  = '"+Mv_Par11+"' "
Else
cQuery1 += " AND TAB_DTRESU BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"' "
Endif
cQuery1 += " AND TAB.TAB_FILIAL = '"+xFilial("TAB")+"' AND TAB.D_E_L_E_T_ <> '*'"
SqlToTrb(cQuery1,aDBF1,cTRB1)

//Query seleciona Aspectos e Impactos de cada avaliacao (TAD)
cQuery2 := " SELECT TAD_ORDEM AS ORDEM, TAD_INDICA AS INDICA, TAD_CODAVA AS CODAVA, TAD_CODOPC AS CODOPC,"
cQuery2 += " '' AS CODHIS"
cQuery2 += " FROM "+RetSQLName("TAD")+" TAD"
cQuery2 += " WHERE TAD_ORDEM IN (SELECT DISTINCT ORDEM FROM ("+cQuery1+") TRB )"
If NGCADICBASE("TAD_OK","A","TAD",.F.)
	cQuery2 += " AND TAD.TAD_OK = '1'"
EndIf
cQuery2 += " AND TAD.TAD_FILIAL = '"+xFilial("TAD")+"' AND TAD.D_E_L_E_T_ <> '*'"
SqlToTrb(cQuery2,aDBF2,cTRB2)

If MV_PAR09 == 1

	//Query seleciona Ordens de Resultados de Avaliacoes - Historico (TAO)
	cQuery1 := " SELECT TAO_ORDEM AS ORDEM, TAO_DTRESU AS DTRESU, TAO_CODNIV AS CODNIV,"
	cQuery1 += " TAO_CODPLA AS CODPLA, TAO_CODEME AS CODEME, TAO_CODASP AS CODASP,"
	cQuery1 += " TAO_CODIMP AS CODIMP, TAO_CODCLA AS CODCLA, TAO_CODHIS AS CODHIS, TAO_RESULT AS RESULT, TAO.R_E_C_N_O_ AS RECNO_TAB "
	cQuery1 += " FROM "+RetSQLName("TAO")+" TAO"
	cQuery1 += " WHERE TAO_CODASP BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
	cQuery1 += " AND TAO_CODIMP BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
	cQuery1 += " AND TAO_CODNIV BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
	cQuery1 += " AND TAO_DTRESU BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"' "
	cQuery1 += " AND TAO.TAO_FILIAL = '"+xFilial("TAO")+"' AND TAO.D_E_L_E_T_ <> '*'"
	SqlToTrb(cQuery1,aDBF1,cTRB1)

	//Query seleciona Aspectos e Impactos de cada avaliacao - Historico (TAP)
	cQuery2 := " SELECT TAP_ORDEM AS ORDEM, TAP_INDICA AS INDICA, TAP_CODAVA AS CODAVA, TAP_CODOPC AS CODOPC,"
	cQuery2 += " TAP_CODHIS AS CODHIS"
	cQuery2 += " FROM "+RetSQLName("TAP")+" TAP"
	cQuery2 += " WHERE TAP_ORDEM IN (SELECT DISTINCT ORDEM FROM ("+cQuery1+") TRB )"
	cQuery2 += " AND TAP.TAP_FILIAL = '"+xFilial("TAP")+"' AND TAP.D_E_L_E_T_ <> '*'"
	SqlToTrb(cQuery2,aDBF2,cTRB2)

EndIf

Return Nil

//---------------------------------------------------------------------
/*/{Protheus.doc} GeraXLS
Processa os Dados da PLanilha a ser gerada
@author Alessandro Arnold
@since 03/2012
@version P11
@return Nil
/*/
//---------------------------------------------------------------------
Static Function GeraXLS()

Local nA
Local nB
Local aMonitor := {}
Local cAspect
Local cImpact
Local oTempLeg

SGAR150TRB()

aCabec     := {}
aRespostas := {}
aLegenda   := {}
aOpcoes    := {}

DbSelectArea("TCD")
TCD->(DbSetOrder(1))
TCD->(DbSeek(xFilial("TCD")))
While !TCD->(Eof()) .AND. TCD->TCD_FILIAL == xFilial("TCD")

	AADD(aMonitor,{TCD->TCD_ASPECT,TCD->TCD_IMPACT})
	TCD->(DbSkip())
Enddo

dbSelectArea(cTRB1)
dbSetOrder(01)
dbGoTop()

While (cTRB1)->( !Eof() )

   If !Empty( ( cTRB1 )->CODHIS )
   	dbSelectArea( "TAO" )
	   dbSetorder( 1 )
	   dbSeek( xFilial( "TAO" ) + ( cTRB1 )->CODHIS + ( cTRB1 )->ORDEM )
	   cAspect := TAO->TAO_CODASP
	   cImpact := TAO->TAO_CODIMP
	   cDescri := TAO->TAO_DESCRI
	   If NGCADICBASE("TAB_CODOBJ","A","TAB",.F.) //
	   	cCodObj := TAO->TAO_CODOBJ
	   EndIf
   Else
	   dbSelectArea( "TAB" )
	   dbSetorder( 1 )
	   dbSeek( xFilial( "TAB" ) + ( cTRB1 )->ORDEM )
	   cAspect := TAB->TAB_CODASP
	   cImpact := TAB->TAB_CODIMP
	   cDescri := TAB->TAB_DESCRI
	   If NGCADICBASE("TAB_CODOBJ","A","TAB",.F.) //
	   	cCodObj := TAB->TAB_CODOBJ
	   EndIf
	Endif

	dbSelectArea(cTRB1)

	cOrdem     := (cTRB1)->ORDEM
	cCodNIV    := (cTRB1)->CODNIV
	cAtividade := NGSEEK("TAF",'001'+(cTRB1)->CODNIV,2,"TAF_NOMNIV")
	cAspecto   := NGSEEK("TA4",(cTRB1)->CODASP,1,"TA4_DESCRI")
	cImpacto   := NGSEEK("TAE",(cTRB1)->CODIMP,1,"TAE_DESCRI")

	cChave1 := "(cTRB1)->CODHIS+(cTRB1)->ORDEM"
	cChave2 := "(cTRB2)->CODHIS+(cTRB2)->ORDEM"

	//Impressao do Aspecto
	dbSelectArea(cTRB2)
	dbSetOrder(01)
	dbSeek(&cChave1,.T.)

	While (cTRB2)->( !Eof() ) .And. &cChave1 == &cChave2
		DbSelectArea('TA6')
		DbSeek(xFilial('TA6')+(cTrb2)->CODAVA)
		cRequisito := '' //Requisitos Legais Associados

		DbSelectArea("TAJ")
		TAJ->(DbSetOrder(1))
		IF TAJ->(DbSeek(xFilial("TAJ")+cAspect))

			While !TAJ->(Eof()) .AND. TAJ->TAJ_FILIAL == xFilial("TAJ") .AND. TAJ->TAJ_CODASP == cAspect
				If !((Alltrim(TAJ->TAJ_CODLEG)+";") $ cRequisito) .AND. !Empty(TAJ->TAJ_CODLEG)

					cRequisito+=Alltrim(TAJ->TAJ_CODLEG)+"; "

				Endif
				TAJ->(DbSkip())
			Enddo

		Endif

		DbSelectArea("TAI")
		TAI->(DbSetOrder(1))
		IF TAI->(DbSeek(xFilial("TAI")+cImpact))

			While !TAI->(Eof()) .AND. TAI->TAI_FILIAL == xFilial("TAI") .AND. TAI->TAI_CODIMP == cImpact
				If !((Alltrim(TAI->TAI_CODLEG)+";") $ cRequisito) .AND. !Empty(TAI->TAI_CODLEG)

					cRequisito+=Alltrim(TAI->TAI_CODLEG)+"; "

				Endif
				TAI->(DbSkip())
			Enddo

		Endif

		cMonitPla  := '' //Monitoramento e Plano de AÁ„o

		cMonitora  := '' //Monitoramento

		If !Empty(aMonitor)

			If aScan(aMonitor,{|x| x[1]== cAspect .AND. x[2]== cImpact}) > 0

				cMonitora := "X"

			Endif

		Endif

		cPlnEmerg  := IIF(!Empty((cTRB1)->CODEME),'X','')  //Plano de Emergencia
		cPlnAcao   := IIF(!Empty((cTRB1)->CODPLA),'X','')  //Plano de Acao
		cControle  := cDescri // Controle aplicado
		cObjetivo  := '' // Objetivos
		If NGCADICBASE("TAB_CODOBJ","A","TAB",.F.) //
		   cObjetivo := IIF(!Empty(cCodObj),'X','')
		Endif

		cMonitPla := If( !Empty( cMonitora ) .Or. !Empty( cPlnAcao ) , 'X' , '' )
		//                1         2      3        4          5         6             7                 8               9                10         11           12       13         14       15    16
		aadd(aRespostas,{cOrdem,cCodNIV,cAtividade,cAspecto,cImpacto,(cTrb2)->CODAVA,(cTrb2)->CODOPC,TA6->TA6_TIPO,(cTRB1)->RESULT,(cTRB1)->CODCLA,cRequisito,cMonitPla,cObjetivo,cPlnEmerg,/*cPlnAcao*/,cControle})
		nOpcao := aScan(aOpcoes,{|X| X[1] == (cTrb2)->CODAVA })
		If nOpcao == 0
			aAdd(aOpcoes,{(cTrb2)->CODAVA,TA6->TA6_TIPO,TA6->TA6_DESCRI})
		Endif
		dbSelectArea(cTRB2)
		dbSkip()
	EndDo

	dbSelectArea(cTRB1)
	dbSkip()

EndDo

// Cria Arquivo Temporario para Armazenar os dados do Relatorio
aEstru  := {}
cArqui := ""

aSort(aOpcoes,,,{|x,y| x[1] < y[1]})

aadd(aEstru,{"TAB_ORDEM"  ,"C",006,0})
aadd(aEstru,{"TAB_CODNIV" ,"C",003,0})
aadd(aEstru,{"ATIVIDADE"  ,"C",060,0})

//Monta a Estrutura das ATIVIDADEacoes
For nA := 1 To Len(aOpcoes)
	If aOpcoes[nA][2] == '3'
		cVariavel := 'LOCALI_'+aOpcoes[nA][1]
		aadd(aEstru,{cVariavel,"C",003,0})
	Endif
Next

aadd(aEstru,{"ASPECTO"  ,"C",050,0})
//Monta a Estrutura das Aspectos
For nA := 1 To Len(aOpcoes)
	If aOpcoes[nA][2] == '1'
		cVariavel := 'ASPECT_'+aOpcoes[nA][1]
		aadd(aEstru,{cVariavel,"C",003,0})
	Endif
Next

aadd(aEstru,{"IMPACTO"  ,"C",050,0})
//Monta a Estrutura das Aspectos
For nA := 1 To Len(aOpcoes)
	If aOpcoes[nA][2] == '2'
		cVariavel := 'IMPACT_'+aOpcoes[nA][1]
		aadd(aEstru,{cVariavel,"C",003,0})
	Endif
Next

// Pontuacao Significancia
aadd(aEstru,{"PONTUACAO"  ,"N",009,2})
aadd(aEstru,{"SIGNFICAN"  ,"C",006,0})
aadd(aEstru,{"REQUISITO"  ,"C",050,0})
aadd(aEstru,{"MONITPLAN"  ,"C",003,0})
If NGCADICBASE("TAB_CODOBJ","A","TAB",.F.) //
	aadd(aEstru,{"OBJETIVOS"  ,"C",003,0})
EndIf
aadd(aEstru,{"PLAN_EMER"  ,"C",003,0})
//aadd(aEstru,{"PLAN_ACAO"  ,"C",003,0})
aadd(aEstru,{"CONTROLE"   ,"C",LEN(TAB->TAB_DESCRI),0})

oTempTMP := FWTemporaryTable():New( "TMPDBF", aEstru )
oTempTMP:AddIndex( "1", {"TAB_ORDEM","TAB_CODNIV"} )
oTempTMP:Create()

For nB := 1 To Len(aRespostas)

	cChave    := aRespostas[nB][1]+aRespostas[nB][2]
	nRecno    := 0

	cCampo := ''
	If aRespostas[nB][8] == "1" // Aspecto
		cCampo := 'ASPECT_'+aRespostas[nB][6]
	ElseIf aRespostas[nB][8] == "2" // Impacto
		cCampo := 'IMPACT_'+aRespostas[nB][6]
	Else  // Localizacao
		cCampo := 'LOCALI_'+aRespostas[nB][6]
	Endif

	// Verifica Se J· existe registro para este a Localizacao/aspecto/impacto
	// Se somente algum aspecto for preenchido aproveita do registro
	DbSelectArea('TMPDBF')
	DbSeek(cChave)
	Do While !Eof() .and. TMPDBF->TAB_ORDEM+TMPDBF->TAB_CODNIV == cChave
		If Empty(&cCampo)
			nRecno := TMPDBF->(Recno())
			Exit
		Endif
		DbSelectArea('TMPDBF')
		DbSkip()
	Enddo

	xConteudo := AllTrim(aRespostas[nB][7]) // Legenda
	//  xConteudo := NGSEEK("TA7",aRespostas[nB][6]+aRespostas[nB][7],1,"TA7_OPCAO") // conteudo da legenda
	If nRecno == 0
		DbSelectArea('TMPDBF')
		RecLock('TMPDBF',.T.)
		TMPDBF->TAB_ORDEM  := aRespostas[nB][1]
		TMPDBF->TAB_CODNIV := aRespostas[nB][2]
		TMPDBF->ATIVIDADE  := Alltrim(aRespostas[nB][3])
		TMPDBF->ASPECTO    := Alltrim(aRespostas[nB][4])
		TMPDBF->IMPACTO    := Alltrim(aRespostas[nB][5])
		TMPDBF->PONTUACAO  := aRespostas[nB][09]
		TMPDBF->SIGNFICAN  := aRespostas[nB][10]
		TMPDBF->REQUISITO  := aRespostas[nB][11]
		TMPDBF->MONITPLAN  := aRespostas[nB][12]
		If NGCADICBASE("TAB_CODOBJ","A","TAB",.F.)
			TMPDBF->OBJETIVOS  := aRespostas[nB][13]
		EndIf
		TMPDBF->PLAN_EMER  := aRespostas[nB][14]
//		TMPDBF->PLAN_ACAO  := aRespostas[nB][15]
		TMPDBF->CONTROLE   := aRespostas[nB][16]
		FIELDPUT(FIELDPOS(cCampo),xConteudo)
		MsUnLock()
	Else
		DbSelectArea('TMPDBF')
		DbGoto(nRecno)
		RecLock('TMPDBF',.F.)
		FIELDPUT(FIELDPOS(cCampo),xConteudo)
		MsUnLock()
	Endif
Next nB

//Monta a Legenda
aLegenda := {}
For nA := 1 To Len(aOpcoes)
	cVariavel := 'LEGEND_'+aOpcoes[nA][1]
	aadd(aLegenda,{cVariavel,"C",035,0})
Next

If Empty(aLegenda)

	aadd(aLegenda,{'LEGEND_001',"C",035,0})

Endif

oTempLeg := FWTemporaryTable():New( "TMPLEG", aLegenda )
oTempLeg:Create()

For nA := 1 To Len(aOpcoes)
	cCampo    := 'LEGEND_'+aOpcoes[nA][1]
	xConteudo := aOpcoes[nA][1]
	DbSelectArea('TA7')
	DbSetOrder(1)
	DbSeek(xFilial('TA7')+xConteudo)
	Do While !Eof() .and. TA7_CODAVA == xConteudo
		cLegenda := TA7_CODOPC+'-'+TA7_OPCAO
		nRecno := 0
		DbSelectArea('TMPLEG')
		DbGoTop()
		Do While !Eof()
			If Empty(&cCampo)
				nRecno := TMPLEG->(Recno())
				Exit
			Endif
			DbSkip()
		Enddo
		If nRecno == 0
			RecLock('TMPLEG',.T.)
		Else
			DbSelectArea('TMPLEG')
			DbGoto(nRecno)
			RecLock('TMPLEG',.F.)
		Endif
		FIELDPUT(FIELDPOS(cCampo),cLegenda)
		MsUnLock()
		DbSelectArea('TA7')
		DbSkip()
	Enddo
Next

MontaXLS(aEstru,aLegenda)

oTempLeg:Delete()
oTempTMP:Delete()

Return

//---------------------------------------------------------------------
/*/{Protheus.doc} MontaXLS
Monta a planilha e abre no excell
@author Alessandro Arnold
@since 03/2012
@version P11
@return Nil
/*/
//---------------------------------------------------------------------
Static Function MontaXLS(aEstrutura,aLegenda)

Local nA , nB , cStyle
Local nHandle
Local cArqPesq   := ""
Local cPath	     := AllTrim(GetTempPath())
Local cStyleBor  := ""
cArqXML := CriaTrab(,.F.)

nColAti := 1  // Coluna que ser· impresso a atividade para depois alinhamento de impress„o da Legenda
nColAsp := 0  // Coluna que ser· impresso o Aspecto   para depois alinhamento de impress„o da Legenda
nColCTR := 0  // Coluna do Controle Aplicado
//Monta o Cabecario dos Aspectos de acordo com a Estrutura do Arquivo
aCabec := {}
For nA := 3 To Len(aEstrutura)
	cCampo := aEstrutura[nA][1]
	cCor   := 's50'
	cTam   := '50'
	If AT("ATIVIDADE",cCampo) <> 0 // Atividade È Fundo Laranja na horizontal
		cCor := 's80'
		cTam := '222'
	ElseIf AT("LOCALI_",cCampo) <> 0 // LOcalizacao È Fundo Laranja na vertical
		cCodAva := Substr(cCampo,8,3)
		cCampo  := NGSEEK("TA6",cCodAVA,1,"TA6_DESCRI")
		cCor := 's81'
		cTam := '23'
	ElseIf AT("ASPECTO",cCampo) <> 0 // Aspecto È verde horizontal
		cCor := 's82'
		nColAsp := Len(aCabec)+1
		cTam := '250'
	ElseIf AT("ASPECT_",cCampo) <> 0 // Descricao do Aspecto e verde veritical
		cCodAva := Substr(cCampo,8,3)
		cCampo  := NGSEEK("TA6",cCodAVA,1,"TA6_DESCRI")
		cCor := 's83'
		cTam := '23'
	ElseIf AT("IMPACTO",cCampo) <> 0 // impacto È azul
		cCor := 's84'
		cTam := '250'
	ElseIf AT("IMPACT_",cCampo) <> 0 // Descricao do impacto e azul veritical
		cCodAva := Substr(cCampo,8,3)
		cCampo  := NGSEEK("TA6",cCodAVA,1,"TA6_DESCRI")
		cCor := 's85'
		cTam := '23'
	ElseIf AT("PONTUACAO",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0039 // Pontuacao
		cCor := 's87'
		cTam := '23'
	ElseIf AT("SIGNFICAN",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0040 // Signific‚ncia
		cCor := 's87'
		cTam := '32'
	ElseIf AT("REQUISITO",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0041 // "Requisitos Legais Associados"
		cCor := 's50quebra'
		cTam := '150'
	ElseIf AT("MONITPLAN",cCampo) <> 0// Fundo Cinza 90 Graus
		cCampo  := STR0051 // "Controle Operacional ou Monitoramento"
		cCor := 's89'
		cTam := '35'
	ElseIf AT("OBJETIVOS",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0043 // "OBJETIVOS E METAS"
		cCor := 's89'
		cTam := '23'
	ElseIf AT("PLAN_EMER",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0044 // "PLANO EMERGENCIAL"
		cCor := 's89'
		cTam := '23'
	/*ElseIf AT("PLAN_ACAO",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  := STR0045 // "PLANO DE A«√O"
		cCor := 's89'
		cTam := '23'*/
	ElseIf AT("CONTROL",cCampo) <> 0 // Fundo Cinza 90 Graus
		cCampo  :=  STR0046 // "CONTROLE APLICADO"
		cCor := 's50quebra'
		cTam := '150'
		nColCTR := Len(aCabec)+1
	Endif
	aadd(aCabec,{Alltrim(cCampo),cCor,cTam})
Next

// Monta o Cabec das Legendas
aLegCAB := {}
For nA := 1 to Len(aLegenda)
	cCodAva := Substr(aLegenda[nA][1],8,3)
	cCampo  := NGSEEK("TA6",cCodAVA,1,"TA6_DESCRI")
	cCor := 's50'
	aadd(aLegCAB,{cCampo,cCor})
Next

//Adiciona Significancia
aadd(aLegCAB,{STR0040,cCor}) // 'SIGNIFIC¬NCIA'

cArqPesq := cPath+cArqXML+".xml"
nHandle  := FCREATE(cArqPesq, 0) //Cria arquivo no diretÛrio

//----------------------------------------------------------------------------------
// Verifica se o arquivo pode ser criado, caso contrario um alerta sera exibido
//----------------------------------------------------------------------------------
If FERROR() <> 0
	MsgAlert("N„o foi possÌvel abrir ou criar o arquivo: " + cArqPesq )
	Return
Endif

FWrite( nHandle, '<?xml version="1.0" encoding="ISO-8859-1" ?>' + CRLF ) //Esta tag e' necessaria pois indica para o excel que este e' um arquivo xml
FWrite( nHandle, '<?mso-application progid="Excel.Sheet"?>' + CRLF )//Esta tag informa que e' excel e utilizara' o Sheet (Folha)
FWrite( nHandle, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"' + CRLF )//Tag para montagem do workbook, que representa uma pasta de trabalho do excel
FWrite( nHandle, ' xmlns:o="urn:schemas-microsoft-com:office:office"' + CRLF )
FWrite( nHandle, ' xmlns:x="urn:schemas-microsoft-com:office:excel"' + CRLF )
FWrite( nHandle, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"' + CRLF )
FWrite( nHandle, ' xmlns:html="http://www.w3.org/TR/REC-html40">' + CRLF )

// -------------------------- INICIO DO ESTILOS --------------------------
FWrite( nHandle, '<Styles>' + CRLF )
// -------------------------- INICIO DO ESTILOS --------------------------
FWrite( nHandle, '  <Style ss:ID="Default" ss:Name="Normal">' + CRLF )
FWrite( nHandle, '   <Alignment ss:Vertical="Bottom"/>' + CRLF )
FWrite( nHandle, '   <Borders/>' + CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>' + CRLF )
FWrite( nHandle, '   <Interior/>' + CRLF )
FWrite( nHandle, '   <NumberFormat/>' + CRLF )
FWrite( nHandle, '   <Protection/>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )


//colunas com bordas e borda superior grossa
FWrite( nHandle, '  <Style ss:ID="UpThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

//colunas com bordas e borda superior, inferior e direita grossa
FWrite( nHandle, '  <Style ss:ID="UpRightThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"' + CRLF )
FWrite( nHandle, '   	ss:Bold="1"/>' + CRLF )
FWrite( nHandle, '   <Interior ss:Color="#FAC090" ss:Pattern="Solid"/>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )


//colunas com bordas e borda superior, inferior e esquerda grossa
FWrite( nHandle, '  <Style ss:ID="UpLeftThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"' + CRLF )
FWrite( nHandle, '   	ss:Bold="1"/>' + CRLF )
FWrite( nHandle, '   <Interior ss:Color="#FAC090" ss:Pattern="Solid"/>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

//colunas com bordas e borda esquerda grossa
FWrite( nHandle, '  <Style ss:ID="LeftThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

//colunas com bordas e borda direita grossa
FWrite( nHandle, '  <Style ss:ID="RightThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

//colunas com bordas e borda superior grossa
FWrite( nHandle, '  <Style ss:ID="OnlyUpThick">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="3"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Coluna com Bordas
FWrite( nHandle, '  <Style ss:ID="s50">' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Coluna sem Bordas
FWrite( nHandle, '  <Style ss:ID="s50sembordas">' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Coluna com Bordas e Quebra
FWrite( nHandle, '  <Style ss:ID="s50quebra">' + CRLF )
FWrite( nHandle, '   <Alignment ss:WrapText="1"/>' + CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Coluna com Bordas Centralizado
FWrite( nHandle, '  <Style ss:ID="s50center">' + CRLF )
FWrite( nHandle, '     <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+ CRLF )
FWrite( nHandle, '   <Borders>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>' + CRLF )
FWrite( nHandle, '   </Borders>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Texto tamanho 25 centralizado do titulo
FWrite( nHandle, '    <Style ss:ID="s64">'+ CRLF )
FWrite( nHandle, '     <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+ CRLF )
FWrite( nHandle, '     <Borders>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '     </Borders>'+ CRLF )
FWrite( nHandle, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="25" ss:Color="#000000"'+ CRLF )
FWrite( nHandle, '      ss:Bold="1"/>'+ CRLF )
FWrite( nHandle, '    </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s71">' + CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>' + CRLF )
FWrite( nHandle, '  </Style>' + CRLF )

// Texto tamanho 25 esquerda do titulo
FWrite( nHandle, '    <Style ss:ID="s64left">'+ CRLF )
FWrite( nHandle, '     <Borders>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '     </Borders>'+ CRLF )
FWrite( nHandle, '     <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="13" ss:Color="#000000"'+ CRLF )
FWrite( nHandle, '      ss:Bold="1"/>'+ CRLF )
FWrite( nHandle, '    </Style>'+ CRLF )

// Titulos Variaveis
FWrite( nHandle, '  <Style ss:ID="s80">'+ CRLF ) // Fundo Laranja 90 graus - Localizacao
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#FAC090" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s81"> '+ CRLF ) // Fundo Laranja 90 graus - Localizacao
FWrite( nHandle, '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom" ss:Rotate="90"/>'+ CRLF )
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#FAC090" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s82">'+ CRLF ) // Fundo Azul - Horizontal Aspecto
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#B6DDE8" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s83">'+ CRLF ) // Fundo Azul - 90 graus Aspectos
FWrite( nHandle, '   <Alignment ss:Vertical="Bottom" ss:Rotate="90"/>'+ CRLF )
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#B6DDE8" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s84">'+ CRLF ) // Fundo verde-Impactos
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#92D050" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s85"> // Fundo verde-impactos 90 graus'+ CRLF )
FWrite( nHandle, '   <Alignment ss:Vertical="Bottom" ss:Rotate="90"/>'+ CRLF )
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior ss:Color="#92D050" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s86">'+ CRLF ) //fundo cinza
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '     <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s87">'+ CRLF ) //fundo cinza 90 graus
FWrite( nHandle, '   <Alignment ss:Vertical="Bottom" ss:Rotate="90"/>'+ CRLF )
FWrite( nHandle, '   <Borders>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '   </Borders>'+ CRLF )
FWrite( nHandle, '     <Interior ss:Color="#808080" ss:Pattern="Solid"/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '  <Style ss:ID="s88"> '+ CRLF ) // Fundo Branco
FWrite( nHandle, '     <Borders>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '     </Borders>'+ CRLF )
FWrite( nHandle, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Color="#000000"/>'+ CRLF )
FWrite( nHandle, '   <Interior/>'+ CRLF )
FWrite( nHandle, '  </Style>'+ CRLF )
FWrite( nHandle, '    <Style ss:ID="s89">'+ CRLF ) // Fundo Branco 90 Graus
FWrite( nHandle, '     <Alignment ss:WrapText="1" ss:Vertical="Bottom" ss:Rotate="90"/>'+ CRLF )
FWrite( nHandle, '     <Borders>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '     </Borders>'+ CRLF )
FWrite( nHandle, '    </Style>'+ CRLF )
FWrite( nHandle, '    <Style ss:ID="s90">'+ CRLF ) // Mesclado a esquerda
FWrite( nHandle, '      <Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>'+ CRLF )
FWrite( nHandle, '      <Borders>'+ CRLF )
FWrite( nHandle, '      <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+ CRLF )
FWrite( nHandle, '      </Borders>'+ CRLF )
FWrite( nHandle, '     </Style>'+ CRLF )
// -------------------------- FIM DO ESTILOS --------------------------
FWrite( nHandle, '</Styles>' + CRLF )
// -------------------------- FIM DO ESTILOS --------------------------

// -------------------------- INICIO DAS DEFINICOES DE LARGURA DE COLUNA --------------------------
FWrite( nHandle, '<Worksheet ss:Name="SGAR150">' + CRLF )//Declara a primeira pasta de trabalho como sendo 'ENG2R202'
FWrite( nHandle, ' <Table x:FullColumns="1" ' + CRLF ) //ss:ExpandedRowCount="18"
FWrite( nHandle, '   x:FullRows="1" ss:DefaultRowHeight="15">' + CRLF )
For nA := 1 To Len(aCabec)
	cTam := aCabec[nA][3]
	FWrite( nHandle, '   <Column ss:Width="'+cTam+'"/>' + CRLF )
Next
/*
FWrite( nHandle, '   <Column ss:Index="1" ss:Width="222"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="2" ss:Width="260"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="3" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="4" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="5" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="6" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="7" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="8" ss:AutoFitWidth="0" ss:Width="113.25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="9" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="10" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="11" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="12" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="13" ss:Width="25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="14" ss:Width="25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="15" ss:Width="222"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="16" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="17" ss:Width="128.25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="18" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="19" ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="20" ss:AutoFitWidth="0" ss:Width="150"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="21" ss:AutoFitWidth="0" ss:Width="150"/>' + CRLF )

FWrite( nHandle, '   <Column ss:Width="222"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="21"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="17.25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="508.5"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="21" ss:Span="4"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="10" ss:Width="229.5"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="21" ss:Span="3"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="15" ss:Width="19.5" ss:Span="1"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="17" ss:Width="128.25"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Width="19.5" ss:Span="3"/>' + CRLF )
FWrite( nHandle, '   <Column ss:Index="22" ss:Width="120"/>' + CRLF )*/
// -------------------------- FIM DAS DEFINICOES DE LARGURA DE COLUNA --------------------------

// -------------------------- Titulo --------------------------
cRevisao :=  IIF(!Empty(MV_Par11) ,STR0047  + MV_PAR11 , ' ' ) // Revis„o
cTitPlan :=  STR0048 //+ ' ' + cRevisao       // 'LEVANTAMENTO DE ASPECTOS E IMPACTOS '
cColunas := Str(Len(aCabec)-2)
FWrite( nHandle, '<Row ss:Height="33">' + CRLF )
FWrite( nHandle, '<Cell ss:MergeAcross="'+cColunas+'" ss:MergeDown="1" ss:StyleID="s64"><Data ss:Type="String">'+cTitPlan+'</Data></Cell>' + CRLF )
FWrite( nHandle, '<Cell ss:StyleID="s64left"><Data ss:Type="String">VERS√O:</Data></Cell>' + CRLF )
FWrite( nHandle, '</Row>' + CRLF )
FWrite( nHandle, '<Row ss:Height="33">' + CRLF )
FWrite( nHandle, '<Cell ss:Index="'+cValToChar(Val(cColunas)+2)+'" ss:StyleID="s64left"><Data ss:Type="String">P¡GINA:</Data></Cell>' + CRLF )
FWrite( nHandle, '</Row>' + CRLF )
// -------------------------- Final do Titulo --------------------------

// -------------------------- Cabecario --------------------------
lFirst := .T.
FWrite( nHandle, '<Row>' + CRLF )
For nA := 1 To Len(aCabec)
	cCampo := aCabec[nA][1]
	cCor   := aCabec[nA][2]
	If !( Upper( cCampo ) $ Upper( STR0043+"/"+STR0044+"/"+STR0051+"/"+STR0046 ) )
		FWrite( nHandle, '<Cell ss:MergeDown="1" ss:StyleID="'+cCor+'"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )
	Else
		If lFirst
			FWrite( nHandle, '<Cell ss:MergeAcross="3" ss:StyleID="s50center"><Data ss:Type="String">'+STR0045+'</Data></Cell>' + CRLF )
			FWrite( nHandle, '</Row>' + CRLF )
			FWrite( nHandle, '<Row ss:Height="170">' + CRLF )
			FWrite( nHandle, '<Cell ss:Index="'+Alltrim(Str(nA))+'" ss:StyleID="'+cCor+'"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )
			lFirst:= .F.
		Else
			FWrite( nHandle, '<Cell ss:StyleID="'+cCor+'"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )
		EndIf
	EndIf
Next
FWrite( nHandle, '</Row>' + CRLF )
// -------------------------- Final do Cabecalho --------------------------

// -------------------------- Itens --------------------------
DbSelectArea('TMPDBF')
DbGotop()
Do While !Eof()
	FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
	For nA := 3 To Len(aEstrutura) // Despreza os dois primeiros campos de controle
		cCampo    := aEstrutura[nA][1]
		xConteudo := &cCampo
		If aEstrutura[nA][2] == 'N'
			xConteudo := Alltrim(Str(xConteudo))
		Endif
		FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+xConteudo+'</Data></Cell>' + CRLF )
	Next
	FWrite( nHandle, '</Row>' + CRLF )
	DbSelectArea('TMPDBF')
	DbSkip()
Enddo
// -------------------------- Final dos itens --------------------------
/*FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
FWrite( nHandle, '<Cell ss:StyleID="Default"><Data ss:Type="String"></Data></Cell>' + CRLF )
FWrite( nHandle, '</Row>' + CRLF )*/

// -------------------------- Cabec Legenda --------------------------
FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF ) // Pula uma linha para deixar espaÁo da planilha de levantamento e o inÌcio da legenda
FWrite( nHandle, '</Row>' + CRLF )
FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
For nA := 1 To Len(aCabec)
	cCampo := ''
	If nA == 1
		cCampo := 'Legenda'       // STR????
	Elseif nA == 2
		cCampo := 'OpÁ„o'      // STR????
	Elseif nA == nColCTR // Data da GeraÁ„o
		cCampo := 'Data Impress„o: '+ Dtoc(Date()) // STR????
	Endif

	If nA == 1
		FWrite( nHandle, '<Cell ss:StyleID="UpLeftThick"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )

	ElseIf nA ==2
//		FWrite( nHandle, '<Cell ss:StyleID="UpThick" ss:Index="'+Alltrim(Str(nA))+'"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )
//	ElseIf nA == 4
	                                                                                     //
	  	FWrite( nHandle, '<Cell ss:StyleID="UpRightThick" ss:MergeAcross="'+AllTrim(Str(nColCTR-3))+'" ><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )

	ElseIf nA == nColCTR
	   If Empty(cCampo)
	   	cStyleBor := "s50sembordas"
	   Else
	   	cStyleBor := "s50"
	   EndIf

		FWrite( nHandle, '<Cell ss:StyleID="'+cStyleBor+'"><Data ss:Type="String">'+cCampo+'</Data></Cell>' + CRLF )
	Endif
Next

FWrite( nHandle, '</Row>' + CRLF )
// -------------------------- Final Cabec Legenda --------------------------

// -------------------------- Imprime a Legenda --------------------------
nCntPart := 0
For nA := 1 To Len(aLegenda)
	cDescri  := Alltrim(aLegCAB[nA,1])
	cLegenda := ''
	cStyle := ""
	DbSelectArea('TMPLEG')
	DbGotop()
	Do While !Eof()
		cCampo    := aLegenda[nA][1]
		If !Empty(&cCampo)
			If !Empty( cLegenda )
				cLegenda += ', '
			EndIf
			xConteudo := &cCampo
			cLegenda  += Alltrim(xConteudo)
		Endif
		DbSelectArea('TMPLEG')
		DbSkip()
	Enddo
	FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
	For nB := 1 To 2
		xConteudo := ''
		If nB == 1
			xConteudo := cDescri
			cStyle := "LeftThick"

			FWrite( nHandle, '<Cell ss:StyleID="'+cStyle+'"><Data ss:Type="String">'+xConteudo+'</Data></Cell>' + CRLF )

		Else
			xConteudo := cLegenda
			cStyle := "RightThick"
			FWrite( nHandle, '<Cell ss:StyleID="'+cStyle+'" ss:MergeAcross="'+AllTrim(Str(nColCTR-3))+'" ><Data ss:Type="String">'+xConteudo+'</Data></Cell>' + CRLF )
		Endif

	Next
	If nCntPart < 4
		nCntPart++
		If !Empty(cRevisao) .And. nCntPart == 1
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ cRevisao +'</Data></Cell>' + CRLF )
		ElseIf ( Empty(cRevisao) .And. nCntPart == 1 ) .Or. nCntPart == 2
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Respons·veis" +':</Data></Cell>' + CRLF )
		Else
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Nome/FunÁ„o" +':</Data></Cell>' + CRLF )
		EndIf
	EndIf
	FWrite( nHandle, '</Row>' + CRLF )
Next nA

//imprimindo significancia na legenda
xConteudo := ""
DbSelectArea("TA8")
TA8->(DbSetOrder(1))
If TA8->(DbSeek(xFilial("TA8")))

	While !TA8->(Eof()) .AND. TA8->TA8_FILIAL == xFilial("TA8")
		If !Empty( xConteudo )
			xConteudo += ", "
		EndIf

	  	xConteudo += Alltrim(TA8->TA8_CODCLA)+"-"+Alltrim(TA8->TA8_DESCRI)
		TA8->(DbSkip())
	Enddo

Endif

If !Empty(xConteudo)

	FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
	FWrite( nHandle, '<Cell ss:StyleID="LeftThick" ss:Index="1"><Data ss:Type="String">'+TRANSFORM(STR0021,"@!")+'</Data></Cell>' + CRLF )//#SIGNIFICANCIA
	//FWrite( nHandle, '<Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>' + CRLF )
	//FWrite( nHandle, '<Cell ss:StyleID="s90"><Data ss:Type="String"></Data></Cell>' + CRLF )
	FWrite( nHandle, '<Cell ss:StyleID="RightThick" ss:Index="2" ss:MergeAcross="'+AllTrim(Str(nColCTR-3))+'"><Data ss:Type="String">'+xConteUdo+'</Data></Cell>' + CRLF )
	If nCntPart < 4
		nCntPart++
		If !Empty(cRevisao) .And. nCntPart == 1
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ cRevisao +'</Data></Cell>' + CRLF )
		ElseIf ( Empty(cRevisao) .And. nCntPart == 1 ) .Or. nCntPart == 2
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Respons·veis" +':</Data></Cell>' + CRLF )
		Else
			FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Nome/FunÁ„o" +':</Data></Cell>' + CRLF )
		EndIf
	EndIf
	FWrite( nHandle, '</Row>' + CRLF )


Endif

// -------------------------- Final da Legenda -----------------------------
FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )


FWrite( nHandle, '<Cell ss:StyleID="OnlyUpThick" ss:Index="1"><Data ss:Type="String"></Data></Cell>' + CRLF )
FWrite( nHandle, '<Cell ss:StyleID="OnlyUpThick" ss:Index="2" ss:MergeAcross="'+AllTrim(Str(nColCTR-3))+'"><Data ss:Type="String"></Data></Cell>' + CRLF )
If nCntPart < 4
	nCntPart++
	If !Empty(cRevisao) .And. nCntPart == 1
		FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ cRevisao +'</Data></Cell>' + CRLF )
	ElseIf ( Empty(cRevisao) .And. nCntPart == 1 ) .Or. nCntPart == 2
		FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Respons·veis" +':</Data></Cell>' + CRLF )
	Else
		FWrite( nHandle, '<Cell ss:StyleID="s50"><Data ss:Type="String">'+ "Nome/FunÁ„o" +':</Data></Cell>' + CRLF )
	EndIf
EndIf
FWrite( nHandle, '</Row>' + CRLF )

If nCntPart < 3
	nCntPart++
	For nA := nCntPart To 4
		FWrite( nHandle, '<Row ss:AutoFitHeight="0">' + CRLF )
		If !Empty(cRevisao) .And. nA == 1
			FWrite( nHandle, '<Cell ss:StyleID="s50" ss:Index="'+Alltrim(Str(nColCTR))+'"><Data ss:Type="String">'+ cRevisao +'</Data></Cell>' + CRLF )
		ElseIf ( Empty(cRevisao) .And. nA == 1 ) .Or. nA == 2
			FWrite( nHandle, '<Cell ss:StyleID="s50" ss:Index="'+Alltrim(Str(nColCTR))+'"><Data ss:Type="String">'+ "Respons·veis" +':</Data></Cell>' + CRLF )
		Else
			FWrite( nHandle, '<Cell ss:StyleID="s50" ss:Index="'+Alltrim(Str(nColCTR))+'"><Data ss:Type="String">'+ "Nome/FunÁ„o" +':</Data></Cell>' + CRLF )
		EndIf
		FWrite( nHandle, '</Row>' + CRLF )
	Next nA
EndIf

//-------------------------- Final da Planilha -----------------------------
FWrite( nHandle, '</Table>' + CRLF )
//--AutoAjuste
FWrite( nHandle, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">' + CRLF )
FWrite( nHandle, '   <PageSetup>' + CRLF )
FWrite( nHandle, '    <Header x:Margin="0.4921259845"/>' + CRLF )
FWrite( nHandle, '    <Footer x:Margin="0.4921259845"/>' + CRLF )
FWrite( nHandle, '    <PageMargins x:Bottom="0.984251969" x:Left="0.78740157499999996"' + CRLF )
FWrite( nHandle, '     x:Right="0.78740157499999996" x:Top="0.984251969"/>' + CRLF )
FWrite( nHandle, '   </PageSetup>' + CRLF )
FWrite( nHandle, '   <Unsynced/>' + CRLF )
FWrite( nHandle, '   <Selected/>' + CRLF )
FWrite( nHandle, '   <Panes>' + CRLF )
FWrite( nHandle, '    <Pane>' + CRLF )
FWrite( nHandle, '     <Number>3</Number>' + CRLF )
FWrite( nHandle, '     <RangeSelection>R1:R1048576</RangeSelection>' + CRLF )
FWrite( nHandle, '    </Pane>' + CRLF )
FWrite( nHandle, '   </Panes>' + CRLF )
FWrite( nHandle, '   <ProtectObjects>False</ProtectObjects>' + CRLF )
FWrite( nHandle, '   <ProtectScenarios>False</ProtectScenarios>' + CRLF )
FWrite( nHandle, '  </WorksheetOptions>' + CRLF )
//---
FWrite( nHandle, '</Worksheet>' + CRLF )
FWrite( nHandle, '</Workbook>' + CRLF )
FCLOSE(nHandle)

dbCommit()
//--------------------------------
// Exporta relatorio para Excel
//--------------------------------
If !ApOleClient('MsExcel')
	MsgStop(STR0049) //'MsExcel n„o instalado!'
	Return
EndIf

ShellExecute("open", "excel", cArqPesq ,"" , SW_MAXIMIZE ) //- Microsoft Excel

Return
