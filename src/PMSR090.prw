/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "pmsr090.ch"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

//--------------------------RELEASE 4-------------------------------------------//
User Function PMSR090()
Local aArea		:= GetArea()

Private nQtdIns := 0

If PMSBLKINT()
	Return Nil
EndIf

oReport := ReportDef()
Pergunte(oReport:uParam,.F.)
oReport:PrintDialog()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³21/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport

Local oProjeto
Local oRecurso
Local oEquipe
Local oGrupo
Local oRecurso5
Local oTarefa5
Local oTarefa
Local oTarefa2
Local cObfNRecur := IIF(FATPDIsObfuscate("AE8_DESCRI",,.T.),FATPDObfuscate("RESOURCE NAME","AE8_DESCRI",,.T.),"")  

Local aOrdem := {}

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
oReport := TReport():New("PMSR090",STR0002,"PMR90A", ;
			{|oReport| ReportPrint(oReport)},;
			STR0001 )

//STR0001 "Este relatorio ira imprimir os detalhes da alocacao dos recursos nos projetos no periodo solicitado."
//STR0002 "Alocacao de Recursos"

oReport:SetLandScape()
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
//adiciona ordens do relatorio
aAdd(aOrdem, STR0003 )  //"PROJETO+TAREFA"
aAdd(aOrdem, STR0004 )  //"RECURSO+DATA DE ALOCACAO"
aAdd(aOrdem, STR0012 )  //"EQUIPE+DATA DE ALOCACAO"
aAdd(aOrdem, STR0020 )  //"PROJETO+GRUPO DE TAREFAS+TAREFA+RECURSO"
aAdd(aOrdem, STR0032 )  //"REC+PRJ+TRF+DATA"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


oProjeto := TRSection():New(oReport,STR0031+ "1: "+ STR0025,{"AF8" },aOrdem,.F.,.F.) //"Projeto"
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_PROJET })
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_DESCRI })
oProjeto:SetLineStyle()

oTarefa := TRSection():New(oProjeto, STR0026,{"AF9", "AFA","AE8","AED","SB1"},/*aOrdem*/,.F.,.F.) //"Tarefa"
TRCell():New(oTarefa,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTarefa,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DESCRI })
TRCell():New(oTarefa,	"AFA_RECURS"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_RECURS })
TRCell():New(oTarefa,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur) })
TRCell():New(oTarefa,	"AE8_EQUIP"		,"AE8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AE8->AE8_EQUIP })
TRCell():New(oTarefa,	"AED_DESCRI"	,"AED",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| AED->AED_DESCRI })
TRCell():New(oTarefa,	"AFA_START"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_START })
TRCell():New(oTarefa,	"AFA_HORAI"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAI })
TRCell():New(oTarefa,	"AFA_FINISH"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_FINISH })
TRCell():New(oTarefa,	"AFA_HORAF"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAF })
TRCell():New(oTarefa,	"AFA_ALOC"		,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_ALOC })
TRCell():New(oTarefa,	"AFA_QUANT"		,"AFA",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oTarefa,	"B1_UM"		,"SB1",STR0023/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||If(!Empty(AFA->AFA_PRODUT),SB1->B1_UM,"")}) //"UM"
TRCell():New(oTarefa,	"AFA_CUSTD"		,"AFA",STR0017/*Titulo*/,/*Picture*/,5/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_CUSTD })  //"Custo Prv."
TRCell():New(oTarefa,	"AFA_CUSTD1"	,"AFA",STR0018/*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Total Prv."
oTarefa:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa:Cell("AE8_DESCRI"):SetLineBreak()
oTarefa:Cell("AED_DESCRI"):SetLineBreak()
oTarefa:SetLinesBefore(0)
oTarefa:SetLeftMargin(5)


oRecurso := TRSection():New(oReport,STR0031+ "2: "+STR0027, {"AE8","AED"},/*aOrdem*/,.F.,.F.) //"Recurso"
TRCell():New(oRecurso,	"AE8_RECURS"	,"AE8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AE8->AE8_RECURS })
TRCell():New(oRecurso,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur) })
TRCell():New(oRecurso,	"AED_EQUIP"		,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,	{|| If(AED->(Found()),AED->AED_EQUIP,"") })
TRCell():New(oRecurso,	"AED_DESCRI"	,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(AED->(Found()),AED->AED_DESCRI,"") })
oRecurso:SetLineStyle()

oTarefa2 := TRSection():New(oRecurso,STR0028, {"AF9","AF8","AFA","AE8","AED","SB1"},/*aOrdem*/,.F.,.F.) //"Alocação de Recurso"
TRCell():New(oTarefa2,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_PROJET })
TRCell():New(oTarefa2,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_DESCRI })
TRCell():New(oTarefa2,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTarefa2,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DESCRI })
TRCell():New(oTarefa2,	"AFA_START"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_START })
TRCell():New(oTarefa2,	"AFA_HORAI"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAI })
TRCell():New(oTarefa2,	"AFA_FINISH"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_FINISH })
TRCell():New(oTarefa2,	"AFA_HORAF"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAF })
TRCell():New(oTarefa2,	"AFA_ALOC"		,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_ALOC })
TRCell():New(oTarefa2,	"AFA_QUANT"		,"AFA",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oTarefa2,	"B1_UM"		,"SB1",STR0023/*Titulo*/,/*Picture*/,2/*Tamanho*/,/*lPixel*/,{||If(!Empty(AFA->AFA_PRODUT),SB1->B1_UM,"")}) //"UM"
TRCell():New(oTarefa2,	"AFA_CUSTD"		,"AFA",STR0017/*Titulo*/,/*Picture*/,5/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_CUSTD })  //"Custo Prv."
TRCell():New(oTarefa2,	"AFA_CUSTD1"	,"AFA",STR0018/*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Total Prv."
oTarefa2:Cell("AF8_DESCRI"):SetLineBreak()
oTarefa2:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa2:SetLinesBefore(0)
oTarefa2:SetLeftMargin(5)


oEquipe := TRSection():New(oReport, STR0031+ "3: "+STR0029, {"AED"},/*aOrdem*/,.F.,.F.) //"Equipe"
TRCell():New(oEquipe,	"AED_EQUIP"		,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,	{|| AED->AED_EQUIP })
TRCell():New(oEquipe,	"AED_DESCRI"	,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AED->AED_DESCRI })
TRCell():New(oEquipe,	"UMaxEquip"		,"",STR0016/*Titulo*/,/*Picture*/,10/*Tamanho*/,/*lPixel*/,{|| Str(UMaxEquip(AED->AED_EQUIP)) })//"Un. Max  :"

oTarefa3:= TRSection():New(oEquipe, STR0030, {"AF9", "AF8", "AFA", "AE8", "AED", "SB1"},/*aOrdem*/,.F.,.F.) //"Tarefa + Alocação de Equipe"
TRCell():New(oTarefa3,	"AFA_PROJET"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_PROJET })
TRCell():New(oTarefa3,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| U_GetProjDesc(AFA->AFA_PROJET) })
TRCell():New(oTarefa3,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTarefa3,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DESCRI })
TRCell():New(oTarefa3,	"AFA_RECURS"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_RECURS })
TRCell():New(oTarefa3,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur)  })
TRCell():New(oTarefa3,	"AFA_START"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_START })
TRCell():New(oTarefa3,	"AFA_HORAI"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAI })
TRCell():New(oTarefa3,	"AFA_FINISH"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_FINISH })
TRCell():New(oTarefa3,	"AFA_HORAF"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAF })
TRCell():New(oTarefa3,	"AFA_ALOC"		,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_ALOC })
TRCell():New(oTarefa3,	"AFA_QUANT"		,"AFA",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oTarefa3,	"B1_UM"		,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||If(!Empty(AFA->AFA_PRODUT),SB1->B1_UM,"")})
TRCell():New(oTarefa3,	"AFA_CUSTD"		,"AFA",STR0017/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_CUSTD })  //"Custo Prv."
TRCell():New(oTarefa3,	"AFA_CUSTD1"	,"AFA",STR0018/*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Total Prv."
oTarefa3:Cell("AF8_DESCRI"):SetLineBreak()
oTarefa3:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa3:Cell("AE8_DESCRI"):SetLineBreak()
oTarefa3:SetLeftMargin(5)


oProjeto2 := TRSection():New(oReport,STR0031+ "4: "+STR0025,{"AF8" },/*aOrdem*/,.F.,.F.) //"Projeto"
TRCell():New(oProjeto2,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_PROJET })
TRCell():New(oProjeto2,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_DESCRI })
oProjeto2:SetLineStyle()

oGrupo := TRSection():New(oProjeto2, STR0019, {"AE5"},/*aOrdem*/,.F.,.F.)  //"Grupo de Composicao"
TRCell():New(oGrupo,	"AE5_GRPCOM"	,"AE5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,	{|| If(AE5->(Found()), AE5->AE5_GRPCOM, "Outros") })
TRCell():New(oGrupo,	"AE5_DESCRI"	,"AE5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(AE5->(Found()), AE5->AE5_DESCRI, "Nao especificado") })
oGrupo:SetLinesBefore(0)
oGrupo:SetLineStyle()
oGrupo:SetLeftMargin(5)

oTarefa4:= TRSection():New(oGrupo, STR0030, {"AF9", "AF8","AE5", "AFA", "AE8", "AED", "SB1"},/*aOrdem*/,.F.,.F.) //"Tarefa + Alocação de Equipe"
TRCell():New(oTarefa4,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTarefa4,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DESCRI })
TRCell():New(oTarefa4,	"AFA_RECURS"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_RECURS })
TRCell():New(oTarefa4,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur)  })
TRCell():New(oTarefa4,	"AFA_START"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_START })
TRCell():New(oTarefa4,	"AFA_HORAI"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAI })
TRCell():New(oTarefa4,	"AFA_FINISH"	,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_FINISH })
TRCell():New(oTarefa4,	"AFA_HORAF"		,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_HORAF })
TRCell():New(oTarefa4,	"AFA_ALOC"		,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_ALOC })
TRCell():New(oTarefa4,	"AFA_QUANT"		,"AFA",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oTarefa4,	"B1_UM"		,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||If(!Empty(AFA->AFA_PRODUT),SB1->B1_UM,"")})
TRCell():New(oTarefa4,	"AFA_CUSTD"		,"AFA",STR0017/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFA->AFA_CUSTD })  //"Custo Prv."
TRCell():New(oTarefa4,	"AFA_CUSTD1"	,"AFA",STR0018/*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Total Prv."
oTarefa4:SetLinesBefore(0)
oTarefa4:SetLeftMargin(10)


oRecurso5 := TRSection():New(oReport,STR0031+ "5: "+STR0033, {"AE8","AED"},/*aOrdem*/,.F.,.F.) //"Recurso(Projeto)"
TRCell():New(oRecurso5,	"AE8_RECURS"	,"AE8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AE8->AE8_RECURS })
TRCell():New(oRecurso5,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur) })
TRCell():New(oRecurso5,	"AED_EQUIP"		,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,	{|| If(AED->(Found()),AED->AED_EQUIP,"") })
TRCell():New(oRecurso5,	"AED_DESCRI"	,"AED",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| If(AED->(Found()),AED->AED_DESCRI,"") })
oRecurso5:SetLineStyle()

oTarefa5 := TRSection():New(oRecurso5,STR0028, {"AF9","AF8","AFA","AE8","AED","SB1"},/*aOrdem*/,.F.,.F.) //"Alocação de Recurso"
TRCell():New(oTarefa5,"AF8_PROJET","AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AF8_DESCRI","AF8",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AF9_TAREFA","AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AF9_DESCRI","AF9",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_START" ,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_HORAI" ,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_FINISH","AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_HORAF" ,"AFA",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_ALOC"  ,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New(oTarefa5,"AFA_QUANT" ,"AFA",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oTarefa5,"B1_UM"     ,"SB1",STR0023/*Titulo*/,/*Picture*/,2/*Tamanho*/,/*lPixel*/,) //"UM"
TRCell():New(oTarefa5,"AFA_CUSTD" ,"AFA",STR0017/*Titulo*/,/*Picture*/,5/*Tamanho*/,/*lPixel*/,)  //"Custo Prv."
TRCell():New(oTarefa5,"AFA_CUSTD1","AFA",STR0018/*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,5/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Total Prv."
oTarefa5:Cell("AF8_DESCRI"):SetLineBreak()
oTarefa5:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa5:SetLinesBefore(0)
oTarefa5:SetLeftMargin(5)
oTarefa5:SetTotalInLine(.F.)

oTrfCU04:= TRSection():New(oGrupo, STR0030, {"AF9", "AF8","AE5", "AFA", "AE8", "AED", "SB1"},/*aOrdem*/,.F.,.F.) //"Tarefa + Alocação de Equipe"
TRCell():New(oTrfCU04,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTrfCU04,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DESCRI })
TRCell():New(oTrfCU04,	"AJY_RECURS"	,"AJY",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AJY->AJY_RECURS })
TRCell():New(oTrfCU04,	"AE8_DESCRI"	,"AE8",/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNRecur), AE8->AE8_DESCRI,cObfNRecur) })
TRCell():New(oTrfCU04,	"AF9_START"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_START })
TRCell():New(oTrfCU04,	"AF9_HORAI"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_HORAI })
TRCell():New(oTrfCU04,	"AF9_FINISH"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_FINISH })
TRCell():New(oTrfCU04,	"AF9_HORAF"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_HORAF })
TRCell():New(oTrfCU04,	"AFA_ALOC"		,"AFA",/*Titulo*/,"@E 999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| GetAloc() })
TRCell():New(oTrfCU04,	"AEL_QUANT"		,"AEL",/*Titulo*/,"@E 999999999.99"/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| nQtdIns })
TRCell():New(oTrfCU04,	"B1_UM"			,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||If(!Empty(AJY->AJY_PRODUT),SB1->B1_UM,"")})
TRCell():New(oTrfCU04,	"AJY_CUSTD"		,"AJY",STR0017/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AJY->AJY_CUSTD })  //"Custo Prv."
oTrfCU04:SetLinesBefore(0)
oTrfCU04:SetLeftMargin(10)

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Paulo Carnelossi      ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³que faz a chamada desta funcao ReportPrint()                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpO1: Objeto TReport                                       ³±±
±±³          ³ExpC2: Alias da tabela de Planilha Orcamentaria (AK1)       ³±±
±±³          ³ExpC3: Alias da tabela de Contas da Planilha (Ak3)          ³±±
±±³          ³ExpC4: Alias da tabela de Revisoes da Planilha (AKE)        ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local nOrdem    := oReport:Section(1):GetOrder()
Local oProjeto  := oReport:Section(1)
Local oTarefa   := oReport:Section(1):Section(1)
Local oRecurso  := oReport:Section(2)
Local oTarefa2  := oReport:Section(2):Section(1)
Local oEquipe   := oReport:Section(3)
Local oTarefa3  := oReport:Section(3):Section(1)
Local oProjeto2 := oReport:Section(4)
Local oGrupo    := oReport:Section(4):Section(1)
Local oTarefa4  := oReport:Section(4):Section(1):Section(1)
Local oRecurso5 := oReport:Section(5)
Local oTarefa5  := oReport:Section(5):Section(1)
Local oTrfCU04  := oReport:Section(4):Section(1):Section(2)

Local oBreak, oBreakGer, oBreakPrj, oTotal, oTotalGer, oTotalPrj
Local nQuantAFA := 0
Local nDecCst   := TamSX3("AF9_CUSTO")[2]
Local cTrunca   := "1"
Local cRecurso  := ""
Local cEquipe   := ""
Local cProjeto  := ""
Local nTotSecao := 0
Local nTotGeral := 0
Local nTotProje := 0
Local aDados    := {}
Local nX        := 0

Do Case

	//----------------------------------
	// PROJETO + TAREFA
	//----------------------------------	
	Case nOrdem == 1
		oTarefa:SetTotalInLine(.F.)
	
		oTarefa:Cell("AFA_QUANT")	:SetBlock({||nQuantAFA})
		oTarefa:Cell("AFA_CUSTD1")	:SetBlock({||PmsTrunca(cTrunca,AFA->AFA_CUSTD*nQuantAFA,nDecCst,AF9->AF9_QUANT)})

		oBreak := TRBreak():New(oTarefa,{||.T.},STR0009) //"Total"
		oTotal := TRFunction():New(oTarefa:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,{||nTotSecao}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Total"

		oBreakGer := TRBreak():New(oProjeto,{||.T.},STR0021) //"Total Geral"
		oTotalGer := TRFunction():New(oTarefa:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",,/*cTitle*/,/*cPicture*/,{||nTotGeral}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

		oReport:SetMeter(AFA->(LastRec()))
	    
		dbSelectArea("AF8")
		dbSetOrder(1) // AF8_FILIAL + AF8_PROJET
		MSSeek(xFilial("AF8") + mv_par01,.T.)
		While !Eof() .And. xFilial("AF8") == AF8->AF8_FILIAL ;
					 .And. AF8->AF8_PROJET <= mv_par02 .AND. !oReport:Cancel()
					 
			If AF8->AF8_DATA < mv_par03 .Or. AF8->AF8_DATA > mv_par04
				AF8->( DbSkip() )
				Loop
			EndIf
			// valida o filtro do usuario
			If !Empty(oProjeto:GetAdvplExp('AF8')) .And. !AF8->(&(oProjeto:GetAdvplExp('AF8')))
				AF8->( DbSkip() )
				Loop
			EndIf

			If AF8->AF8_PROJET < mv_par01 .Or. AF8->AF8_PROJET > mv_par02
				AF8->( DbSkip() )
				Loop
			EndIf

			If PmrPertence(AF8->AF8_FASE,MV_PAR06) 
				cTrunca:= AF8->AF8_TRUNCA
				cRevisa := If(Empty(mv_par05),AF8->AF8_REVISA,mv_par05) 

				dbSelectArea("AFA")
				dbSetOrder(1)
				If MSSeek(xFilial()+AF8->AF8_PROJET+cRevisa)
	
					While !Eof() .And. xFilial()+AF8->AF8_PROJET+cRevisa==;
										AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA .AND. !oReport:Cancel()
						
						If !Empty(AFA->AFA_RECURS)
							If (!Empty(mv_par05) .And. AFA->AFA_REVISA != mv_par05) .Or.;
								(Empty(mv_par05) .And. AFA->AFA_REVISA != AF8->AF8_REVISA)
								dbSelectArea("AFA")
								dbSkip()
								loop
							EndIf
							If (AFA->AFA_START < mv_par09 .And. AFA->AFA_FINISH < mv_par09) .Or.;
								(AFA->AFA_START > mv_par10 .And. AFA->AFA_FINISH > mv_par10)
								dbSelectArea("AFA")
								dbSkip()
								loop
							EndIf
							If AFA->AFA_PROJET < mv_par01 .Or. AFA->AFA_PROJET > mv_par02
								dbSelectArea("AFA")
								dbSkip()
								loop
							EndIf
							// valida o filtro do usuario
							If !Empty(oProjeto:GetAdvplExp('AFA')) .And. !AFA->(&(oProjeto:GetAdvplExp('AFA')))
								dbSelecTArea("AFA")
								dbSkip()
								Loop
							EndIf
							AE8->(dbSetOrder(1))
							AE8->(MSSeek(xFilial()+AFA->AFA_RECURS))
				
							If AE8->AE8_RECURS < mv_par07 .Or. AE8->AE8_RECURS > mv_par08
								dbSelectArea("AFA")
								dbSkip()
								Loop
							EndIf
							If (AE8->AE8_EQUIP < mv_par12 .Or. AE8->AE8_EQUIP > mv_par13)
								dbSelectArea("AFA")
								dbSkip()
								Loop	
							End If

							// valida o filtro do usuario
							If !Empty(oProjeto:GetAdvplExp('AE8')) .And. !AE8->(&(oProjeto:GetAdvplExp('AE8')))
								dbSelecTArea("AFA")
								dbSkip()
								Loop
							EndIf

							dbSelecTArea("AF9")
							dbSetOrder(1)
							MsSeek(xFilial()+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
							dbSelecTArea("AFA")
							// valida o filtro do usuario
							If !Empty(oProjeto:GetAdvplExp('AF9')) .And. !AF9->(&(oProjeto:GetAdvplExp('AF9')))
								dbSelecTArea("AFA")
								dbSkip()
								Loop
							EndIf
		
				
							If	(mv_par11==1).Or.; //Todas as tarefas 
								(mv_par11==3.And.!Empty(AF9->AF9_DTATUF)).Or.; //Tarefas finalizadas
								(mv_par11==2.And.Empty(AF9->AF9_DTATUF)) // Tarefas a executar
		
								AED->(dbSetOrder(1))
								AED->(MSSeek(xFilial()+AE8->AE8_EQUIP))
								// valida o filtro do usuario
								If !Empty(oProjeto:GetAdvplExp('AED')) .And. !AED->(&(oProjeto:GetAdvplExp('AED')))
									dbSelecTArea("AFA")
									dbSkip()
									Loop
								EndIf
								If !Empty(AFA->AFA_PRODUT)
									SB1->(dbSetOrder(1))
									SB1->(MSSeek(xFilial()+AFA->AFA_PRODUT))
									// valida o filtro do usuario
									If !Empty(oProjeto:GetAdvplExp('SB1')) .And. !SB1->(&(oProjeto:GetAdvplExp('SB1')))
										dbSelecTArea("AFA")
										dbSkip()
										Loop
									EndIf
								Endif
								If cProjeto <> AF8->AF8_PROJET
									oReport:SkipLine()
									oProjeto:Init()
									oProjeto:PrintLine()
									oTarefa:Init()
									cProjeto	:=	AF8->AF8_PROJET
									nTotSecao  := 0
								Endif	

								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³realiza o tratamento para a quantidade quando o projeto³
								//³usa composicoes aux                                    ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								nQuantAFA:= PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)

								oTarefa:PrintLine()
								nTotSecao += nQuantAFA
								nTotGeral += nQuantAFA
							EndIf
							
						EndIf                    
			
						dbSelectArea("AFA")
						dbSkip()
		
						oReport:IncMeter()				
		
					EndDo
			
					oTarefa:Finish()
					oProjeto:Finish()
				EndIf
			EndIf
			dbSelectArea("AF8")
			dbSkip()
		EndDo

		// verifica o cancelamento pelo usuario..
		If oReport:Cancel()
			oReport:SkipLine()
			oReport:PrintText(STR0034) //"*** CANCELADO PELO OPERADOR ***"
		Else
			oTotalGer:SetBreak(oBreakGer)
			oProjeto:Init()
			oBreakGer:Execute()
			oProjeto:Finish()
		EndIf

	//----------------------------------
	// RECURSO + DATA DE ALOCACAO
	//----------------------------------	
	Case nOrdem == 2
		oTarefa2:SetTotalInLine(.F.)
	
		oTarefa2:Cell("AFA_QUANT")	:SetBlock({||nQuantAFA})
		oTarefa2:Cell("AFA_CUSTD1"):SetBlock({||PmsTrunca(cTrunca,AFA->AFA_CUSTD*nQuantAFA,nDecCst,AF9->AF9_QUANT)})

		oBreak := TRBreak():New(oTarefa2,{||.T.},STR0009) //"Total"
		oTotal := TRFunction():New(oTarefa2:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreak,STR0009/*cTitle*/,/*cPicture*/,{||nTotSecao}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Total"

		oBreakGer := TRBreak():New(oRecurso,{||.T.},STR0021) //"Total Geral"
		oTotalGer := TRFunction():New(oTarefa2:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",,/*cTitle*/,/*cPicture*/,{||nTotGeral}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

    	oReport:SetMeter(AFA->(LastRec()))

		dbSelectArea("AE8")
		dbSetOrder(1)  // AE8_FILIAL + AE8_RECURS
		MSSeek(xFilial("AE8") + mv_par07, .T.)

		While !Eof() .And. xFilial("AE8") == AE8->AE8_FILIAL ;
					 .And. AE8->AE8_RECURS <= mv_par08 .AND. !oReport:Cancel()
			
			If (AE8->AE8_EQUIP < mv_par12 .Or. AE8->AE8_EQUIP > mv_par13)
				dbSelectArea("AE8")
				dbSkip()
				Loop	
			End If
			
			// valida o filtro do usuario
			If !Empty(oRecurso:GetAdvplExp('AE8')) .And. !AE8->(&(oRecurso:GetAdvplExp('AE8')))
				dbSelecTArea("AE8")
				dbSkip()
				Loop
			EndIf

			dbSelectArea("AFA")
			dbSetOrder(3) //AFA_FILIAL+AFA_RECURS+DTOS(AFA_START)+AFA_HORAI
			MSSeek(xFilial()+AE8->AE8_RECURS)
			While !Eof() .And. AFA->AFA_FILIAL==xFilial("AFA") .And.;
								AFA->AFA_RECURS==AE8->AE8_RECURS

				// valida o filtro do usuario
				If !Empty(oRecurso:GetAdvplExp('AFA')) .And. !AFA->(&(oRecurso:GetAdvplExp('AFA')))
					dbSelecTArea("AFA")
					dbSkip()
					Loop
				EndIf

				AF8->(dbSetOrder(1))
				AF8->(MSSeek(xFilial()+AFA->AFA_PROJET))
				// valida o filtro do usuario
				If !Empty(oRecurso:GetAdvplExp('AF8')) .And. !AF8->(&(oRecurso:GetAdvplExp('AF8')))
					dbSelecTArea("AFA")
					dbSkip()
					Loop
				EndIf
				
				If PmrPertence(AF8->AF8_FASE,MV_PAR06) 
					// valida o filtro do usuario
					dbSelecTArea("AF9")
					dbSetOrder(1)
					MsSeek(xFilial()+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
					// valida o filtro do usuario
					If !Empty(oRecurso:GetAdvplExp('AF9')) .And. !AF9->(&(oRecurso:GetAdvplExp('AF9')))
						dbSelecTArea("AFA")
						dbSkip()
						Loop
					EndIf

					dbSelecTArea("AFA")
					If AFA->AFA_PROJET < mv_par01 .Or. AFA->AFA_PROJET > mv_par02
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
					
					If AF8->AF8_DATA < mv_par03 .Or. AF8->AF8_DATA > mv_par04
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
					
					If (!Empty(mv_par05) .And. AFA->AFA_REVISA != mv_par05) .Or.;
					    (Empty(mv_par05) .And. AFA->AFA_REVISA != AF8->AF8_REVISA)
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
	
					If (AFA->AFA_START < mv_par09 .And. AFA->AFA_FINISH < mv_par09) .Or.;
						(AFA->AFA_START > mv_par10 .And. AFA->AFA_FINISH > mv_par10)
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
		
					If (mv_par11==1).Or.; //Todas as tarefas 
					   (mv_par11==3.And.!Empty(AF9->AF9_DTATUF)).Or.; //Tarefas finalizadas
					   (mv_par11==2.And.Empty(AF9->AF9_DTATUF)) // Tarefas a executar

						dbSelectArea("AED")
						AED->(dbSetOrder(1))
						AED->(MSSeek(xFilial() + AE8->AE8_EQUIP))
	
						// valida o filtro do usuario
						If !Empty(oRecurso:GetAdvplExp('AED')) .And. !AED->(&(oRecurso:GetAdvplExp('AED')))
							dbSelecTArea("AFA")
							dbSkip()
							Loop
						EndIf
						If !Empty(AFA->AFA_PRODUT)
							SB1->(dbSetOrder(1))
							SB1->(MSSeek(xFilial()+AFA->AFA_PRODUT))
							// valida o filtro do usuario
							If !Empty(oRecurso:GetAdvplExp('SB1')) .And. !SB1->(&(oRecurso:GetAdvplExp('SB1')))
								dbSelecTArea("AFA")
								dbSkip()
								Loop
							EndIf
						Endif

						If cRecurso <> AE8->AE8_RECURS
							oReport:SkipLine()
							cRecurso := AE8->AE8_RECURS
							
							oRecurso:Init()
							oRecurso:PrintLine()
							oTarefa2:Init()
							nTotSecao := 0
						Endif

						nQuantAFA := PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)

						oTarefa2:PrintLine()
						nTotSecao += nQuantAFA
						nTotGeral += nQuantAFA
						
					EndIf
				EndIf
				
				dbSelectArea("AFA")
				dbSkip()    
				
				oReport:IncMeter()
				
			EndDo

			oTarefa2:Finish()
			nTotSecao := 0

			oTarefa2:Finish()
			oRecurso:Finish()

			dbSelectArea("AE8")
			dbSkip()
		EndDo

		// verifica o cancelamento pelo usuario..
		If oReport:Cancel()
			oReport:SkipLine()
			oReport:PrintText(STR0034) //"*** CANCELADO PELO OPERADOR ***"
		Else
			oTotalGer:SetBreak(oBreakGer)
			oRecurso:Init()
			oBreakGer:Execute()
			oRecurso:Finish()
		EndIf
					
	//----------------------------------
	// EQUIPE + DATA DE ALOCACAO
	//----------------------------------	
	Case nOrdem==3
		oTarefa3:SetTotalInLine(.F.)

		oTarefa3:Cell("AFA_QUANT")	:SetBlock({||nQuantAFA})
		oTarefa3:Cell("AFA_CUSTD1"):SetBlock({||PmsTrunca(cTrunca,AFA->AFA_CUSTD*nQuantAFA,nDecCst,AF9->AF9_QUANT)})

		oBreak := TRBreak():New(oTarefa3,{||.T.},STR0009) //"Total"
		oTotal := TRFunction():New(oTarefa3:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,{||nTotSecao}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

		oBreakGer := TRBreak():New(oEquipe,{||.T.},STR0021) //"Total Geral"
		oTotalGer := TRFunction():New(oTarefa3:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",,/*cTitle*/,/*cPicture*/,{||nTotGeral}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

    	oReport:SetMeter(AFA->(LastRec()))
	
		dbSelectArea("AED")
		dbSetOrder(1)  // AED_FILIAL + AE8_EQUIP 
		MSSeek(xFilial("AED") + mv_par12,.T.)

		While !Eof() .And. xFilial("AED") == AED->AED_FILIAL ;
					 .And. AED->AED_EQUIP <= mv_par13 .and. !oReport:Cancel()

			If (AED->AED_EQUIP < mv_par12 .Or. AED->AED_EQUIP > mv_par13)
				dbSelectArea("AED")
				AED->(dbSkip())
				Loop	
			EndIf
			// valida o filtro do usuario
			If !Empty(oEquipe:GetAdvplExp('AED')) .And. !AED->(&(oEquipe:GetAdvplExp('AED')))
				dbSelecTArea("AED")
				dbSkip()
				Loop
			EndIf
 
			dbSelectArea("AE8")
			AE8->(dbSetOrder(4))
			AE8->(MSSeek(xFilial() + AED->AED_EQUIP))

			While !AE8->(Eof()) .And. xFilial("AE8")+AED->AED_EQUIP==AE8->AE8_FILIAL+AE8->AE8_EQUIP	

				If AE8->AE8_RECURS < mv_par07 .Or. AE8->AE8_RECURS > mv_par08
					dbSelectArea("AE8")
					dbSkip()
					Loop
				EndIf
				// valida o filtro do usuario
				If !Empty(oEquipe:GetAdvplExp('AE8')) .And. !AE8->(&(oEquipe:GetAdvplExp('AE8')))
					dbSelecTArea("AE8")
					dbSkip()
					Loop
				EndIf
						
				// procura cada recurso na tabela AFA - tarefa x recurso
				dbSelectArea("AFA")
				AFA->(dbSetOrder(3))
				AFA->(MSSeek(xFilial() + AE8->AE8_RECURS))
				
				While AFA->(! Eof() .And. AE8->AE8_FILIAL+AE8->AE8_RECURS == xFilial()+AFA->AFA_RECURS)
					dbSelectArea("AF8")
					dbSetOrder(1)
					AF8->(MSSeek(xFilial() + AFA->AFA_PROJET))
					If AFA->AFA_PROJET < mv_par01 .Or. AFA->AFA_PROJET > mv_par02
						dbSelectArea("AFA")
						dbSkip()
						loop
					EndIf
										
					If AF8->AF8_DATA < mv_par03 .Or. AF8->AF8_DATA > mv_par04
						dbSelectArea("AFA")
						dbSkip()
						loop
					EndIf

					If !PmrPertence(AF8->AF8_FASE,MV_PAR06) 
						dbSelectArea("AFA")
						dbSkip()
						loop
					EndIf
					
					If (!Empty(mv_par05) .And. AFA->AFA_REVISA != mv_par05) .Or.;
					    (Empty(mv_par05) .And. AFA->AFA_REVISA != AF8->AF8_REVISA)
						dbSelectArea("AFA")
						dbSkip()
						loop
					EndIf
		
					If (AFA->AFA_START < mv_par09 .And. AFA->AFA_FINISH < mv_par09) .Or.;
						(AFA->AFA_START > mv_par10 .And. AFA->AFA_FINISH > mv_par10)
						dbSelectArea("AFA")
						dbSkip()
						loop
					EndIf	
					// valida o filtro do usuario
					If !Empty(oEquipe:GetAdvplExp('AFA')) .And. !AFA->(&(oEquipe:GetAdvplExp('AFA')))
						dbSelecTArea("AFA")
						dbSkip()
						Loop
					EndIf

					dbSelectArea("AF9")
					dbSetOrder(1)
					MsSeek(xFilial()+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
					// valida o filtro do usuario
					If !Empty(oEquipe:GetAdvplExp('AF9')) .And. !AF9->(&(oEquipe:GetAdvplExp('AF9')))
						dbSelecTArea("AFA")
						dbSkip()
						Loop
					EndIf

					AF8->(dbSetOrder(1))
					AF8->(MSSeek(xFilial()+AFA->AFA_PROJET))
					// valida o filtro do usuario
					If !Empty(oEquipe:GetAdvplExp('AF8')) .And. !AF8->(&(oEquipe:GetAdvplExp('AF8')))
						dbSelecTArea("AFA")
						dbSkip()
						Loop
					EndIf
					If !Empty(AFA->AFA_PRODUT)
						SB1->(dbSetOrder(1))
						SB1->(MSSeek(xFilial()+AFA->AFA_PRODUT))
						// valida o filtro do usuario
						If !Empty(oEquipe:GetAdvplExp('SB1')) .And. !SB1->(&(oEquipe:GetAdvplExp('SB1')))
							dbSelecTArea("AFA")
							dbSkip()
							Loop
						EndIf
					Endif
					dbSelecTArea("AFA")

					If cEquipe <> AED->AED_EQUIP
						cEquipe := AED->AED_EQUIP
						oEquipe:Init()
						oEquipe:PrintLine()
						oTarefa3:Init()
						nTotSecao  := 0
					Endif				
			
					nQuantAFA := PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)

					oTarefa3:PrintLine()
					nTotSecao += nQuantAFA
					nTotGeral += nQuantAFA

					dbSelectArea("AFA")
					AFA->(dbSkip())
					
					oReport:IncMeter()
					
				EndDo

				oTarefa3:Finish()
				nTotSecao  := 0

				dbSelectArea("AE8")
				AE8->(dbSkip())
			EndDo

			oTarefa3:Finish()
			oEquipe:Finish()
			
			dbSelectArea("AED")
			AED->(dbSkip())

		EndDo

		// verifica o cancelamento pelo usuario..
		If oReport:Cancel()
			oReport:SkipLine()
			oReport:PrintText(STR0034) //"*** CANCELADO PELO OPERADOR ***"
		Else
			oTotalGer:SetBreak(oBreakGer)
			oEquipe:Init()
			oBreakGer:Execute()
			oEquipe:Finish()
		EndIf
	
	//----------------------------------
	// PROJETO+GRUPO DE TAREFAS+TAREFA+RECURSO
	//----------------------------------	
	Case nOrdem == 4

		oTarefa4:SetTotalInLine()
		
		oTarefa4:Cell("AFA_QUANT")	:SetBlock({|| nQuantAFA})
		oTarefa4:Cell("AFA_CUSTD1"):SetBlock({|| PmsTrunca(cTrunca,AFA->AFA_CUSTD*nQuantAFA,nDecCst,AF9->AF9_QUANT) } )

		oBreak := TRBreak():New(oTarefa4,{||.T.},STR0022) //"Grupo"
		oTotal := TRFunction():New(oTarefa4:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,{||nTotSecao}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

		oBreakPrj := TRBreak():New(oGrupo,{||.T.},STR0025) //"Projeto"
		oTotalPrj := TRFunction():New(oTarefa4:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreakPrj,/*cTitle*/,/*cPicture*/,{||nTotProje}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

		oBreakGer := TRBreak():New(oProjeto2,{||.T.},STR0021) //"Total Geral"
		oTotalGer := TRFunction():New(oTarefa4:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",,/*cTitle*/,/*cPicture*/,{||nTotGeral}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

		cGrupo 	:= "XX"
		oReport:SetMeter(AFA->(LastRec()))
	
		dbSelectArea("AF8")
		dbSetOrder(1) // AF8_FILIAL + AF8_PROJET
		MSSeek(xFilial("AF8") + mv_par01,.T.)


		While !Eof() .And. xFilial("AF8") == AF8->AF8_FILIAL ;
					 .And. AF8->AF8_PROJET <= mv_par02 .AND. !oReport:Cancel()

			If AF8->AF8_DATA < mv_par03 .Or. AF8->AF8_DATA > mv_par04
				dbSelectArea("AF8")
				dbSkip()
				loop
			EndIf
			If !Empty(oProjeto2:GetAdvplExp('AF8')) .And. !AF8->(&(oProjeto2:GetAdvplExp('AF8')))
				dbSelecTArea("AF8")
				dbSkip()
				Loop
			EndIf
			If PmrPertence(AF8->AF8_FASE,MV_PAR06) 

				cTrunca := AF8->AF8_TRUNCA
				cRevisa := If(Empty(mv_par05),AF8->AF8_REVISA,mv_par05)
				 
				dbSelectArea("AF9")
				dbSetOrder(4) //AF9_FILIAL+AF9_PROJET+AF9_REVISA+AF9_GRPCOM+AF9_TAREFA+AF9_ORDEM
				If MSSeek(xFilial()+AF8->AF8_PROJET+cRevisa)
					While !Eof() .And. xFilial()+AF8->AF8_PROJET+cRevisa==;
											AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA
		
			
						dbSelectArea("AE5")
						dbSetOrder(1)
						dbSeek(xFilial()+AF9->AF9_GRPCOM)
						If !Empty(oProjeto2:GetAdvplExp('AE5')) .And. !AF9->(&(oProjeto2:GetAdvplExp('AE5')))
							dbSelecTArea("AF9")
							dbSkip()
							Loop
						EndIf
						// valida o filtro do usuario
						If !Empty(oProjeto2:GetAdvplExp('AF9')) .And. !AF9->(&(oProjeto2:GetAdvplExp('AF9')))
							dbSelecTArea("AF9")
							dbSkip()
							Loop
						EndIf

						dbSelectArea("AFA")
						dbSetOrder(1)
						If MSSeek(xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA)
		
							While !Eof() .And. xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA==;
													AFA->AFA_FILIAL+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA
								If !Empty(AFA->AFA_RECURS)
									If AFA->AFA_PROJET < mv_par01 .Or. AFA->AFA_PROJET > mv_par02
										dbSelectArea("AFA")
										dbSkip()
										loop
									EndIf
									// valida o filtro do usuario
									If !Empty(oProjeto2:GetAdvplExp('AFA')) .And. !AFA->(&(oProjeto2:GetAdvplExp('AFA')))
										dbSelecTArea("AFA")
										dbSkip()
										Loop
									EndIf
					
									AE8->(dbSetOrder(1))
									AE8->(MSSeek(xFilial()+AFA->AFA_RECURS))
									If (AE8->AE8_EQUIP < mv_par12 .Or. AE8->AE8_EQUIP > mv_par13)
										dbSelectArea("AFA")
										dbSkip()
										Loop	
									End If
						

									dbSelectArea("AFA")
									If !Empty(oProjeto2:GetAdvplExp('AE8')) .And. !AE8->(&(oProjeto2:GetAdvplExp('AE8')))
										dbSelecTArea("AFA")
										dbSkip()
										Loop
									EndIf
						
									If AE8->AE8_RECURS < mv_par07 .Or. AE8->AE8_RECURS > mv_par08
										dbSelectArea("AFA")
										dbSkip()
										Loop
									EndIf
									If (!Empty(mv_par05) .And. AFA->AFA_REVISA != mv_par05) .Or.;
										(Empty(mv_par05) .And. AFA->AFA_REVISA != AF8->AF8_REVISA)
										dbSelectArea("AFA")
										dbSkip()
										loop
									EndIf
									If (AFA->AFA_START < mv_par09 .And. AFA->AFA_FINISH < mv_par09) .Or.;
										(AFA->AFA_START > mv_par10 .And. AFA->AFA_FINISH > mv_par10)
										dbSelectArea("AFA")
										dbSkip()
										loop
									EndIf

									AED->(dbSetOrder(1))
									AED->(MSSeek(xFilial() + AE8->AE8_EQUIP))
									// valida o filtro do usuario
									If !Empty(oProjeto2:GetAdvplExp('AED')) .And. !AED->(&(oProjeto2:GetAdvplExp('AED')))
										dbSelecTArea("AFA")
										dbSkip()
										Loop
									EndIf
										
									If !Empty(AFA->AFA_PRODUT)
										SB1->(dbSetOrder(1))
										SB1->(MSSeek(xFilial()+AFA->AFA_PRODUT))
										// valida o filtro do usuario
										If !Empty(oProjeto:GetAdvplExp('SB1')) .And. !SB1->(&(oProjeto:GetAdvplExp('SB1')))
											dbSelecTArea("AFA")
											dbSkip()
											Loop
										EndIf
									Endif
						
									If	(mv_par11==1).Or.; //Todas as tarefas 
										(mv_par11==3.And.!Empty(AF9->AF9_DTATUF)).Or.; //Tarefas finalizadas
										(mv_par11==2.And.Empty(AF9->AF9_DTATUF)) // Tarefas a executar
				
										If cProjeto <> AF8->AF8_PROJET
											
											oProjeto2:Init()
											oProjeto2:PrintLine()
											cProjeto	:=	AF8->AF8_PROJET

											oGrupo:Init()
											oGrupo:PrintLine()
											cGrupo := AF9->AF9_GRPCOM
											nTotSecao := 0
											nTotProje := 0
											oTarefa4:Init()
										Else				
											If cGrupo <> AF9->AF9_GRPCOM
												If oGrupo:lPrinting
													oTarefa4:Finish()
													oGrupo:Finish()
												EndIf
												oReport:SkipLine()
												oGrupo:Init()
												oGrupo:PrintLine()
												cGrupo := AF9->AF9_GRPCOM
												nTotSecao := 0
												oTarefa4:Init()
											Endif				
										Endif		

										nQuantAFA := PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)
					
										oTarefa4:PrintLine()
										nTotSecao += nQuantAFA
										nTotProje += nQuantAFA
										nTotGeral += nQuantAFA

									EndIf
								EndIf
					
								dbSelectArea("AFA")
								dbSkip()
								oReport:IncMeter()
								
							EndDo
						EndIf

						dbSelectArea("AF9")
						dbSkip()
					EndDo
				
					If oTarefa4:lPrinting .OR. oTrfCU04:lPrinting
						oTarefa4:Finish()
						oGrupo:Finish()
						oProjeto2:Finish()
					EndIf
		   		EndIf
			EndIf
            
			dbSelectArea("AF8")
			dbSkip()

		EndDo

		// verifica o cancelamento pelo usuario..
		If oReport:Cancel()
			oReport:SkipLine()
			oReport:PrintText(STR0034) //"*** CANCELADO PELO OPERADOR ***"
		Else
			oTotalGer:SetBreak(oBreakGer)
			oProjeto2:Init()
			oBreakGer:Execute()
			oProjeto2:Finish()
		EndIf

	//------------------------------------------
	// RECURSO + PRJ + TAREFA + DATA DE ALOCACAO
	//------------------------------------------
	Case nOrdem == 5
		
		oTarefa5:Cell("AF8_PROJET"):SetBlock({||aDados[nX,1]})
		oTarefa5:Cell("AF8_DESCRI"):SetBlock({||aDados[nX,2]})
		oTarefa5:Cell("AF9_TAREFA"):SetBlock({||aDados[nX,3]})
		oTarefa5:Cell("AF9_DESCRI"):SetBlock({||aDados[nX,4]})
		oTarefa5:Cell("AFA_START") :SetBlock({||aDados[nX,5]})
		oTarefa5:Cell("AFA_HORAI") :SetBlock({||aDados[nX,6]})
		oTarefa5:Cell("AFA_FINISH"):SetBlock({||aDados[nX,7]})
		oTarefa5:Cell("AFA_HORAF") :SetBlock({||aDados[nX,8]})
		oTarefa5:Cell("AFA_ALOC")  :SetBlock({||aDados[nX,9]})
		oTarefa5:Cell("AFA_QUANT") :SetBlock({||aDados[nX,10]})
		oTarefa5:Cell("B1_UM")     :SetBlock({||aDados[nX,11]})
		oTarefa5:Cell("AFA_CUSTD") :SetBlock({||aDados[nX,12]})
		oTarefa5:Cell("AFA_CUSTD1"):SetBlock({||aDados[nX,13]})

		TRPosition():New(oTarefa5,"AF9",1,{|| AF9->(DbGoTo(aDados[nX,14])) },.F.)
		TRPosition():New(oTarefa5,"AF8",1,{|| AF8->(DbGoTo(aDados[nX,15])) },.F.)
		TRPosition():New(oTarefa5,"AFA",1,{|| AFA->(DbGoTo(aDados[nX,16])) },.F.)
		TRPosition():New(oTarefa5,"AED",1,{|| AED->(DbGoTo(aDados[nX,17])) },.F.)
		TRPosition():New(oTarefa5,"SB1",1,{|| SB1->(DbGoTo(aDados[nX,18])) },.F.)

		oBreak := TRBreak():New(oTarefa5,{||.T.},STR0009) //"Total"
		oTotal := TRFunction():New(oTarefa5:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",oBreak,STR0009/*cTitle*/,/*cPicture*/,{||nTotSecao}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Total"

		oBreakGer := TRBreak():New(oRecurso5,{||.T.},STR0021) //"Total Geral"
		oTotalGer := TRFunction():New(oTarefa5:Cell("AFA_QUANT"),"NQUANTAFA" ,"ONPRINT",,/*cTitle*/,/*cPicture*/,{||nTotGeral}/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

    	oReport:SetMeter(AFA->(LastRec()))

		dbSelectArea("AE8")
		dbSetOrder(1)  // AE8_FILIAL + AE8_RECURS
		AE8->(DbSeek(xFilial("AE8") + mv_par07, .T.))

		While AE8->(!Eof()) .And. xFilial("AE8") == AE8->AE8_FILIAL .And. AE8->AE8_RECURS <= mv_par08
			
			If (AE8->AE8_EQUIP < mv_par12 .Or. AE8->AE8_EQUIP > mv_par13)
				AE8->(DbSkip())
				Loop	
			EndIf
			// valida o filtro do usuario
			If !Empty(oRecurso:GetAdvplExp('AE8')) .And. !AE8->(&(oRecurso:GetAdvplExp('AE8')))
				AE8->(DbSkip())
				Loop
			EndIf
			
			nX     := 0
			aDados := {}

			dbSelectArea("AFA")
			dbSetOrder(3) //AFA_FILIAL+AFA_RECURS+DTOS(AFA_START)+AFA_HORAI
			AFA->(DbSeek(xFilial("AFA")+AE8->AE8_RECURS))
			While AFA->(!Eof()) .And. AFA->AFA_FILIAL==xFilial("AFA") .And. AFA->AFA_RECURS==AE8->AE8_RECURS

				// valida o filtro do usuario
				If !Empty(oRecurso:GetAdvplExp('AFA')) .And. !AFA->(&(oRecurso:GetAdvplExp('AFA')))
					dbSelecTArea("AFA")
					dbSkip()
					Loop
				EndIf

				AF8->(dbSetOrder(1))
				AF8->(MSSeek(xFilial()+AFA->AFA_PROJET))
				// valida o filtro do usuario
				If !Empty(oRecurso:GetAdvplExp('AF8')) .And. !AF8->(&(oRecurso:GetAdvplExp('AF8')))
					dbSelecTArea("AFA")
					dbSkip()
					Loop
				EndIf
				
				If PmrPertence(AF8->AF8_FASE,MV_PAR06) 
					// valida o filtro do usuario
					dbSelecTArea("AF9")
					dbSetOrder(1)
					MsSeek(xFilial()+AFA->AFA_PROJET+AFA->AFA_REVISA+AFA->AFA_TAREFA)
					// valida o filtro do usuario
					If !Empty(oRecurso:GetAdvplExp('AF9')) .And. !AF9->(&(oRecurso:GetAdvplExp('AF9')))
						dbSelecTArea("AFA")
						dbSkip()
						Loop
					EndIf

					dbSelecTArea("AFA")
					If AFA->AFA_PROJET < mv_par01 .Or. AFA->AFA_PROJET > mv_par02
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
					
					If AF8->AF8_DATA < mv_par03 .Or. AF8->AF8_DATA > mv_par04
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
					
					If (!Empty(mv_par05) .And. AFA->AFA_REVISA != mv_par05) .Or.;
					    (Empty(mv_par05) .And. AFA->AFA_REVISA != AF8->AF8_REVISA)
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
	
					If (AFA->AFA_START < mv_par09 .And. AFA->AFA_FINISH < mv_par09) .Or.;
						(AFA->AFA_START > mv_par10 .And. AFA->AFA_FINISH > mv_par10)
						dbSelectArea("AFA")
						dbSkip()
						Loop
					EndIf
		
					If (mv_par11==1).Or.; //Todas as tarefas 
					   (mv_par11==3.And.!Empty(AF9->AF9_DTATUF)).Or.; //Tarefas finalizadas
					   (mv_par11==2.And.Empty(AF9->AF9_DTATUF)) // Tarefas a executar

						dbSelectArea("AED")
						AED->(dbSetOrder(1))
						AED->(MSSeek(xFilial() + AE8->AE8_EQUIP))
	
						// valida o filtro do usuario
						If !Empty(oRecurso:GetAdvplExp('AED')) .And. !AED->(&(oRecurso:GetAdvplExp('AED')))
							dbSelecTArea("AFA")
							dbSkip()
							Loop
						EndIf
						If !Empty(AFA->AFA_PRODUT)
							SB1->(dbSetOrder(1))
							SB1->(MSSeek(xFilial()+AFA->AFA_PRODUT))
							// valida o filtro do usuario
							If !Empty(oRecurso:GetAdvplExp('SB1')) .And. !SB1->(&(oRecurso:GetAdvplExp('SB1')))
								dbSelecTArea("AFA")
								dbSkip()
								Loop
							EndIf
						Endif

						If cRecurso <> AE8->AE8_RECURS
							oReport:SkipLine()
							cRecurso := AE8->AE8_RECURS
							
							oRecurso5:Init()
							oRecurso5:PrintLine()
							oTarefa5:Init()
							nTotSecao := 0
						Endif

						nQuantAFA := PmsAFAQuant(AFA->AFA_PROJET,AFA->AFA_REVISA,AFA->AFA_TAREFA,AFA->AFA_PRODUT,AF9->AF9_QUANT,AFA->AFA_QUANT,AF9->AF9_HDURAC)

						aAdd(aDados,Array(18))
						nX++
						aDados[nX,1] := AF8->AF8_PROJET
						aDados[nX,2] := AF8->AF8_DESCRI
						aDados[nX,3] := AF9->AF9_TAREFA
						aDados[nX,4] := AF9->AF9_DESCRI
						aDados[nX,5] := AFA->AFA_START
						aDados[nX,6] := AFA->AFA_HORAI
						aDados[nX,7] := AFA->AFA_FINISH
						aDados[nX,8] := AFA->AFA_HORAF
						aDados[nX,9] := AFA->AFA_ALOC
						aDados[nX,10] := nQuantAFA
						aDados[nX,11] := If(!Empty(AFA->AFA_PRODUT),SB1->B1_UM,"")
						aDados[nX,12] := AFA->AFA_CUSTD
						aDados[nX,13] := PmsTrunca(cTrunca,AFA->AFA_CUSTD*nQuantAFA,nDecCst,AF9->AF9_QUANT)
						aDados[nX,14] := AF9->(Recno())
						aDados[nX,15] := AF8->(Recno())
						aDados[nX,16] := AFA->(Recno())
						aDados[nX,17] := AED->(Recno())
						aDados[nX,18] := SB1->(Recno())
						
						//oTarefa2:PrintLine()
						nTotSecao += nQuantAFA
						nTotGeral += nQuantAFA
						
					EndIf
				EndIf
				
				dbSelectArea("AFA")
				dbSkip()    
				
				oReport:IncMeter()
			EndDo

			aSort(aDados,,,{|x,y| x[1]+x[3]+DtoS(x[5])+x[6] < y[1]+y[3]+DtoS(y[5])+y[6] })
			For nX:=1 to Len(aDados)
				oTarefa5:PrintLine()
			Next
			
			oTarefa5:Finish()
			oRecurso5:Finish()

			dbSelectArea("AE8")
			dbSkip()

		EndDo

		// verifica o cancelamento pelo usuario..
		If oReport:Cancel()
			oReport:SkipLine()
			oReport:PrintText(STR0034) //"*** CANCELADO PELO OPERADOR ***"
		Else
			oTotalGer:SetBreak(oBreakGer)
			oRecurso5:Init()
			oBreakGer:Execute()
			oRecurso5:Finish()
		EndIf

EndCase

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetProjDe³ Autor ³ Adriano Ueda                  ³ Data ³28.05.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna a descricao de um projeto a partir de seu codigo           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GetProjDesc(cCode)
Local aAreaAF8 := GetArea("AF8")
Local cBuffer  := ""

dbSelectArea("AF8")
AF8->(dbSetOrder(1))

If AF8->(MSSeek(xFilial("AF8") + cCode))
	cBuffer := AF8->AF8_DESCRI
EndIf

RestArea(aAreaAF8)
Return cBuffer


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetAloc  ³ Autor ³ Totvs                         ³ Data ³03.06.2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna o percentual de alocacao do recurso                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetAloc()
Local nQuant	:= PmsAELQuant(AF9->AF9_PROJET, AF9->AF9_REVISA, AF9->AF9_TAREFA, AF9->AF9_QUANT, nQtdIns, .T. )
Local nHrsItvs	:= PmsHrsItvl(AF9->AF9_START,AF9->AF9_HORAI,AF9->AF9_FINISH,AF9->AF9_HORAF,If(!Empty(AE8->AE8_CALEND),AE8->AE8_CALEND,AF9->AF9_CALEND),AF9->AF9_PROJET,AE8->AE8_RECURS)
Return nQuant/nHrsItvs * 100

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
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
	Remover essa função quando não houver releases menor que 12.1.27

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
    Função que verifica se a melhoria de Dados Protegidos existe.

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

