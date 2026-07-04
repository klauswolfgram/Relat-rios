/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FATR010.CH" 
#INCLUDE "PROTHEUS.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FATR010   ³ Autor ³Eduardo Riera          ³ Data ³25.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatório de oportunidades.                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FATR010( lSigaCRM )

Local oReport

Default lSigaCRM := .F.

Private lFiltroCRM := lSigaCRM

	oReport := ReportDef()
	oReport:PrintDialog()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Eduardo Riera          ³ Data ³25.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oOportunidade
Local oConcorrentes
Local oParceiros
Local oTime
Local oContatos  
Local oEvolucaoVenda  
Local nTamProd  := TamSX3("AD1_CODPRO")[1]

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
oReport := TReport():New("FATR010",STR0001,"FTR010", {|oReport| ReportPrint(oReport)},STR0020) //"Relacao de Oportunidades"###"Este relatorio ira imprimir a relacao de oportunidades de venda conforme os parametros solicitados"
oReport:SetLandscape() 
oReport:SetTotalInLine(.T.)
Pergunte(oReport:uParam,.F.)
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

If ( AliasInDic("AIJ") .AND. AIJ->(FieldPos("AIJ_NROPOR")) > 0 )
	oOportunidade := TRSection():New(oReport,STR0021,{"AD1","SA3","SUS","AC1","AC2","AIJ"},{STR0004,STR0005,STR0006,STR0007,STR0008,STR0031},/*Campos do SX3*/,/*Campos do SIX*/,,,,,,,,,,.T.) //"Oportunidade de Venda"###"Oportunidades"###"Prospects"###"Produtos"###"Representantes"###"Processo de Venda"###"Evolução da Venda"                                                                 
Else	
	oOportunidade := TRSection():New(oReport,STR0021,{"AD1","SA3","SUS","AC1","AC2"},{STR0004,STR0005,STR0006,STR0007,STR0008},/*Campos do SX3*/,/*Campos do SIX*/,,,,,,,,,,.T.) //"Oportunidade de Venda"###"Oportunidades"###"Prospects"###"Produtos"###"Representantes"###"Processo de Venda"
EndIf

oOportunidade:SetTotalInLine(.F.)     

TRCell():New(oOportunidade,"AD1_NROPOR","AD1",STR0022	   ,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/) //"Codigo"
TRCell():New(oOportunidade,"AD1_REVISA","AD1",STR0023	   ,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rev"
TRCell():New(oOportunidade,"AD1_DESCRI","AD1",/*Titulo*/,/*Picture*/,15 /*Tamanho*/		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_VEND"  ,"AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"A3_NOME"   ,"SA3",/*Titulo*/,/*Picture*/,20 /*Tamanho*/		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"US_COD"    ,"SUS",/*Titulo*/,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"US_LOJA"   ,"SUS",/*Titulo*/,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"US_NOME"   ,"SUS",/*Titulo*/,/*Picture*/,38/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_PROVEN","AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AC1_DESCRI","AC1",/*Titulo*/,/*Picture*/,15/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_STAGE" ,"AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AC2_DESCRI","AC2",/*Titulo*/,/*Picture*/,30/*Tamanho*/ 			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_VERBA" ,"AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/  			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_MOEDA" ,"AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/ 			,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_CODPRO","AD1",/*Titulo*/,/*Picture*/,nTamProd /*Tamanho*/, /*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oOportunidade,"AD1_STATUS","AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/  			,/*lPixel*/,/*{|| code-block de impressao }*/)
 
TRFunction():New(oOportunidade:Cell("AD1_VERBA"),/* cID */,"SUM",/*oBreak*/,STR0024,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage*/) //"Total / Verba"
TRFunction():New(oOportunidade:Cell("AD1_NROPOR"),/* cID */,"COUNT",/*oBreak*/,STR0025,/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/) //"Total / Oportunidade"

oConcorrentes := TRSection():New(oOportunidade,STR0026,{"AD3","AC3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Concorrentes"
oConcorrentes:SetTotalInLine(.F.)
TRCell():New(oConcorrentes,"AD3_CODCON","AD3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oConcorrentes,"AC3_NOME"  ,"AC3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oParceiros := TRSection():New(oOportunidade,STR0027,{"AD4","AC4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Parceiros"
oParceiros:SetTotalInLine(.F.)
TRCell():New(oParceiros,"AD4_PARTNE","AD4",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oParceiros,"AC4_NOME"  ,"AC4",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oTime := TRSection():New(oOportunidade,STR0028,{"AD2","SA3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Time de Vendas"
oTime:SetTotalInLine(.F.)
TRCell():New(oTime,"AD2_VEND" ,"AD2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTime,"A3_NOME"  ,"SA3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oContatos := TRSection():New(oOportunidade,STR0029,{"AD9","SU5"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Contatos"
oContatos:SetTotalInLine(.F.)
TRCell():New(oContatos,"AD9_CODCON" ,"AD9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oContatos,"U5_CONTAT"  ,"SU5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

If ( AliasInDic("AIJ") .AND. AIJ->(FieldPos("AIJ_NROPOR")) > 0 )
	oEvolucaoVenda := TRSection():New(oOportunidade,STR0031,{"AIJ"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Evolução da Venda"  
	oEvolucaoVenda:SetTotalInLine(.F.)
	TRCell():New(oEvolucaoVenda,"AIJ_PROVEN","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_STAGE","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_DTINIC","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_HRINIC","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_DTLIMI","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_HRLIMI","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)  
	TRCell():New(oEvolucaoVenda,"AIJ_DTENCE","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_HRENCE","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oEvolucaoVenda,"AIJ_DUREST","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| TKCalcPer(AIJ_DTINIC,AIJ_HRINIC,IIF(!Empty(AIJ_DTENCE),AIJ_DTENCE,dDataBase),IIF(!Empty(AIJ_HRENCE),AIJ_HRENCE,SubStr(Time(),1,5))) })
	TRCell():New(oEvolucaoVenda,"AIJ_STATUS","AIJ",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| FTR10AIJSt(AIJ_PROVEN, AIJ_STAGE, AIJ_DTINIC, AIJ_HRINIC, AIJ_STATUS)  })
EndIf


// Totais por Moeda

If ( AliasInDic("AIJ") .AND. AIJ->(FieldPos("AIJ_NROPOR")) > 0 )
	oTotMoeda := TRSection():New(oReport,STR0021,{"AD1","SA3","SUS","AC1","AC2","AIJ"},{STR0004,STR0005,STR0006,STR0007,STR0008,STR0031},/*Campos do SX3*/,/*Campos do SIX*/,,,,,,,,,,.T.) //"Oportunidade de Venda"###"Oportunidades"###"Prospects"###"Produtos"###"Representantes"###"Processo de Venda"##"Evolução da Venda" 
Else
	oTotMoeda := TRSection():New(oReport,STR0021,{"AD1","SA3","SUS","AC1","AC2"},{STR0004,STR0005,STR0006,STR0007,STR0008},/*Campos do SX3*/,/*Campos do SIX*/,,,,,,,,,,.T.) //"Oportunidade de Venda"###"Oportunidades"###"Prospects"###"Produtos"###"Representantes"###"Processo de Venda"
EndIf

TRCell():New(oTotMoeda,"AD1_MOEDA" ,"AD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oTotMoeda,"AD1_VERBA" ,"AD1",STR0024,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
                                      
oTotMoeda:SetLineStyle(.T.)
oTotMoeda:SetEdit(.F.)      
If nTamProd >= 25
	oOportunidade:SetLineBreak(.T.)  /*Quebra automatica de linha*/
EndIf

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³04.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local cAliasAD1M 	:= "AD1"
Local cAliasAD1  	:= "AD1"
Local cAliasAD2  	:= "AD2"
Local cAliasAD3  	:= "AD3"
Local cAliasAD4 	:= "AD4"
Local cAliasAD9 	:= "AD9" 
Local cAliasAIJ  	:= "AIJ"
Local cWhereA    	:= ""
Local cWhereB    	:= ""
Local cWhere    	:= ""
Local lQuery    	:= .F.
Local aIndexKey 	:= {}
Local bMais     	:= { || .T. }
Local bMenos     	:= { || .T. }
Local cIndice		:= ""
Local cFilCRM 	:= ""
Local cOperador	:= "%" + IIf(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") + "%"

AAdd( aIndexKey, "AD1_NROPOR" ) 
AAdd( aIndexKey, "AD1_PROSPE,AD1_LOJPRO" ) 
AAdd( aIndexKey, "AD1_CODPRO" ) 
AAdd( aIndexKey, "AD1_VEND" )
AAdd( aIndexKey, "AD1_PROVEN,AD1_STAGE" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR19 == 1
	bMais    := {|| .T.}
	cWhereA  += ""
ElseIf MV_PAR19 <> 5
	bMais    := {|| AD1_STATUS == Str(MV_PAR19 - 1, 1)}
	cWhereA := "AD1_STATUS='" + Str(MV_PAR19 - 1, 1) + "' AND "
Else
	cWhereA := "AD1_STATUS='9' AND "
EndIf

If MV_PAR20 == 1
	bMenos  := {|| .T.}
	cWhereB := ""
Else
	If MV_PAR20 <> 5
		bMenos    := {|| AD1_STATUS <> Str(MV_PAR20 - 1, 1)}
		cWhereB   := "AD1_STATUS<>'" + Str(MV_PAR20 - 1, 1) + "' AND "
	Else
		bMenos    := {|| AD1_STATUS <> "9"}
		cWhereB   := "AD1_STATUS<>'9' AND "
	EndIf
EndIf
cWhere := "%"+cWhereA+cWhereB+"%"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cIndice := (aIndexKey[oReport:Section(1):nOrder])
cIndice := '%'+ cIndice + '%'

If lFiltroCRM
	cFilCRM := CRMXFilEnt( "AD1", .T. ) 
	If !Empty(cFilCRM)
		cFilCRM := " ( "+ cFilCRM + "  OR AD2_VEND = '"+ CRMXRetVend() +"' ) AND "
	EndIf
	cFilCRM := "%" + cFilCRM + "%"
EndIf

lQuery := .T.
cAliasAD1 := GetNextAlias()
oReport:Section(1):BeginQuery()

If !Empty(cFilCRM)

	BeginSql Alias cAliasAD1
		SELECT DISTINCT AD1_FILIAL, AD1_NROPOR, AD1_REVISA, AD1_DESCRI, AD1_VEND, AD1_PROSPE, AD1_PROVEN, AD1_STAGE, AD1_VERBA, AD1_MOEDA, AD1_CODPRO, AD1_STATUS 
		FROM  %Table:AD1% AD1  
			INNER JOIN %Table:AD2% AD2 on (AD2.AD2_NROPOR %Exp:cOperador% AD2.AD2_REVISA) = (AD1.AD1_NROPOR %Exp:cOperador% AD1.AD1_REVISA)
			INNER JOIN %Table:AO4% AO4 ON  AO4.AO4_CHVREG = (AD1.AD1_FILIAL %Exp:cOperador% AD1.AD1_NROPOR)
		WHERE 
		AD1_FILIAL=%xFilial:AD1% AND 
		AD1_PROSPE>=%exp:MV_PAR01% AND
		AD1_PROSPE<=%exp:MV_PAR03% AND
		AD1_LOJPRO>=%exp:MV_PAR02% AND
		AD1_LOJPRO<=%exp:MV_PAR04% AND
		AD1_VEND  >=%exp:MV_PAR05% AND
		AD1_VEND  <=%exp:MV_PAR06% AND
		AD1_DTINI >=%exp:DToS(MV_PAR07)% AND
		AD1_DTFIM <=%exp:DToS(MV_PAR08)% AND
		AD1_PROVEN>=%exp:MV_PAR09% AND
		AD1_PROVEN<=%exp:MV_PAR11% AND
		AD1_STAGE >=%exp:MV_PAR10% AND
		AD1_STAGE <=%exp:MV_PAR12% AND
		AD1_CODPRO>=%exp:MV_PAR13% AND
		AD1_CODPRO<=%exp:MV_PAR14% AND
		AD2_NROPOR = AD1_NROPOR AND 
		AD2_HISTOR = '2' AND 
		AD2_REVISA = AD1_REVISA AND
		%exp:cFilCRM%
		AD1.%NotDel% AND		
		%exp:cWhere%				
		( AD1_CODPRO=%exp:Space( Len( AD1->AD1_CODPRO ) )% OR 
		EXISTS ( SELECT B1_COD FROM %Table:SB1% SB1
					WHERE 
					B1_FILIAL=%xFilial:SB1% AND 
        			B1_COD=AD1_CODPRO AND                                                                      
					B1_TIPO>=%exp:MV_PAR15% AND
					B1_TIPO<=%exp:MV_PAR16% AND
					B1_GRUPO>=%exp:MV_PAR17% AND
					B1_GRUPO<=%exp:MV_PAR18% AND
					SB1.%NotDel% ) )
		ORDER BY %exp:cIndice%
	EndSql

Else	

	BeginSql Alias cAliasAD1
		SELECT AD1.* 
		FROM %Table:AD1% AD1 
		WHERE 
		AD1_FILIAL=%xFilial:AD1% AND 
		AD1_PROSPE>=%exp:MV_PAR01% AND
		AD1_PROSPE<=%exp:MV_PAR03% AND
		AD1_LOJPRO>=%exp:MV_PAR02% AND
		AD1_LOJPRO<=%exp:MV_PAR04% AND
		AD1_VEND  >=%exp:MV_PAR05% AND
		AD1_VEND  <=%exp:MV_PAR06% AND
		AD1_DTINI >=%exp:DToS(MV_PAR07)% AND
		AD1_DTFIM <=%exp:DToS(MV_PAR08)% AND
		AD1_PROVEN>=%exp:MV_PAR09% AND
		AD1_PROVEN<=%exp:MV_PAR11% AND
		AD1_STAGE >=%exp:MV_PAR10% AND
		AD1_STAGE <=%exp:MV_PAR12% AND
		AD1_CODPRO>=%exp:MV_PAR13% AND
		AD1_CODPRO<=%exp:MV_PAR14% AND
		AD1.%NotDel% AND		
		%exp:cWhere%				
		( AD1_CODPRO=%exp:Space( Len( AD1->AD1_CODPRO ) )% OR 
		EXISTS ( SELECT B1_COD FROM %Table:SB1% SB1
					WHERE 
					B1_FILIAL=%xFilial:SB1% AND 
        			B1_COD=AD1_CODPRO AND                                                                      
					B1_TIPO>=%exp:MV_PAR15% AND
					B1_TIPO<=%exp:MV_PAR16% AND
					B1_GRUPO>=%exp:MV_PAR17% AND
					B1_GRUPO<=%exp:MV_PAR18% AND
					SB1.%NotDel% ) )
		ORDER BY %exp:cIndice%
	EndSql
EndIf
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1.1                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cAliasAD3 := GetNextAlias()
AD3->(dbSetOrder(1))
BEGIN REPORT QUERY oReport:Section(1):Section(1)
BeginSql Alias cAliasAD3	
	SELECT AD3_CODCON, AC3_NOME 
	FROM %table:AD3% AD3,%table:AC3% AC3 
	WHERE
	AD3_FILIAL=%xFilial:AD3% AND
	AD3_NROPOR=%report_param: (cAliasAD1)->AD1_NROPOR% AND 
	AD3_REVISA=%report_param: (cAliasAD1)->AD1_REVISA% AND 		
	AD3.%NotDel% AND
	AC3_FILIAL=%xFilial:AC3% AND
	AD3_CODCON=AC3_CODCON AND
	AC3.%NotDel%
	ORDER BY %ORDER:AD3% 
EndSql 
END REPORT QUERY oReport:Section(1):Section(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1.2                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cAliasAD4 := GetNextAlias()	
AD4->(dbSetOrder(1))
BEGIN REPORT QUERY  oReport:Section(1):Section(2)
BeginSql Alias cAliasAD4
	SELECT AD4_PARTNE, AC4_NOME
	FROM %table:AD4% AD4,
		%table:AC4% AC4
	WHERE
	AD4_FILIAL=%xFilial:AD4%  AND
	AD4_NROPOR=%report_param: (cAliasAD1)->AD1_NROPOR% AND
	AD4_REVISA=%report_param: (cAliasAD1)->AD1_REVISA% AND
	AD4.%NotDel% AND
	AC4_FILIAL=%xFilial:AC4% AND
	AD4_PARTNE=AC4_PARTNE AND
	AC4.%NotDel%
	ORDER BY %ORDER:AD4% 
EndSql
END REPORT QUERY oReport:Section(1):Section(2)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1.3                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cAliasAD2 := GetNextAlias()	
AD2->(dbSetOrder(1))
BEGIN REPORT QUERY  oReport:Section(1):Section(3)
BeginSql Alias cAliasAD2
	SELECT AD2_VEND, A3_NOME 
	FROM %Table:AD2% AD2,
		%Table:SA3% SA3
	WHERE
	AD2_FILIAL=%xFilial:AD2% AND
	AD2_NROPOR=%report_param: (cAliasAD1)->AD1_NROPOR% AND
	AD2_REVISA=%report_param: (cAliasAD1)->AD1_REVISA% AND
	AD2.%NotDel% AND
	A3_FILIAL=%xFilial:SA3% AND
	AD2_VEND=A3_COD AND
	SA3.%NotDel%
	ORDER BY %ORDER:AD2% 
EndSql 
END REPORT QUERY oReport:Section(1):Section(3)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1.4                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cAliasAD9 := GetNextAlias()	
AD9->(dbSetOrder(1))
BEGIN REPORT QUERY oReport:Section(1):Section(4)
BeginSql Alias cAliasAD9
	SELECT AD9_CODCON, U5_CONTAT 
	FROM %Table:AD9% AD9,
		%Table:SU5% SU5
	WHERE 
	AD9_FILIAL=%xFilial:AD9% AND
	AD9_NROPOR=%report_param: (cAliasAD1)->AD1_NROPOR% AND
	AD9_REVISA=%report_param: (cAliasAD1)->AD1_REVISA% AND
	AD9.%NotDel% AND
	U5_FILIAL=%xFilial:SU5% AND 
	AD9_CODCON=U5_CODCONT AND
	SU5.%NotDel% 
	ORDER BY %ORDER:AD9%
EndSql 
END REPORT QUERY oReport:Section(1):Section(4)

If ( AliasInDic("AIJ") .AND. AIJ->(FieldPos("AIJ_NROPOR")) > 0 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1.5                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lQuery := .T.
	cAliasAIJ := GetNextAlias()	
	AIJ->(dbSetOrder(1))
	BEGIN REPORT QUERY oReport:Section(1):Section(5)
	BeginSql Alias cAliasAIJ
		SELECT AIJ.* 
		FROM %Table:AIJ% AIJ
		WHERE 
		AIJ_FILIAL=%report_param:(cAliasAD1)->AD1_FILIAL% AND
		AIJ_NROPOR=%report_param:(cAliasAD1)->AD1_NROPOR% AND
		AIJ_REVISA=%report_param:(cAliasAD1)->AD1_REVISA% AND
		AIJ.%NotDel% 
		ORDER BY %ORDER:AIJ%
	EndSql 
	END REPORT QUERY oReport:Section(1):Section(5)
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 2 (totais por moeda)                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
cAliasAD1M := GetNextAlias()
oReport:Section(2):BeginQuery()			
BeginSql Alias cAliasAD1M
	SELECT AD1_MOEDA, SUM(AD1_VERBA) AD1_VERBA
	FROM %Table:AD1% AD1 
	WHERE 
	AD1_FILIAL=%xFilial:AD1% AND 
	AD1_PROSPE>=%exp:MV_PAR01% AND
	AD1_PROSPE<=%exp:MV_PAR03% AND
	AD1_LOJPRO>=%exp:MV_PAR02% AND
	AD1_LOJPRO<=%exp:MV_PAR04% AND
	AD1_VEND  >=%exp:MV_PAR05% AND
	AD1_VEND  <=%exp:MV_PAR06% AND
	AD1_DTINI >=%exp:DToS(MV_PAR07)% AND
	AD1_DTFIM <=%exp:DToS(MV_PAR08)% AND
	AD1_PROVEN>=%exp:MV_PAR09% AND
	AD1_PROVEN<=%exp:MV_PAR11% AND
	AD1_STAGE >=%exp:MV_PAR10% AND
	AD1_STAGE <=%exp:MV_PAR12% AND
	AD1_CODPRO>=%exp:MV_PAR13% AND
	AD1_CODPRO<=%exp:MV_PAR14% AND
	AD1.%NotDel% AND		
	%exp:cWhere%				
	( AD1_CODPRO=%exp:Space( Len( AD1->AD1_CODPRO ) )% OR 
	EXISTS ( SELECT B1_COD FROM %Table:SB1% SB1
				WHERE 
				B1_FILIAL=%xFilial:SB1% AND 
    			B1_COD=AD1_CODPRO AND                                                                      
				B1_TIPO>=%exp:MV_PAR15% AND
				B1_TIPO<=%exp:MV_PAR16% AND
				B1_GRUPO>=%exp:MV_PAR17% AND
				B1_GRUPO<=%exp:MV_PAR18% AND
				SB1.%NotDel% ) )
	
	GROUP BY AD1_MOEDA
EndSql
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³                                                                        ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³                                                                        ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(2):EndQuery(/*Array com os parametros do tipo Range*/)		
		
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
TRPosition():New(oReport:Section(1),"SA3",1,{|| xFilial( "SA3" ) + ( cAliasAD1 )->AD1_VEND })
TRPosition():New(oReport:Section(1),"SUS",1,{|| xFilial( "SUS" ) + ( cAliasAD1 )->AD1_PROSPE })
TRPosition():New(oReport:Section(1),"AC1",1,{|| xFilial( "AC1" ) + ( cAliasAD1 )->AD1_PROVEN })
TRPosition():New(oReport:Section(1),"AC2",1,{|| xFilial( "AC2" ) + ( cAliasAD1 )->AD1_PROVEN + ( cAliasAD1 )->AD1_STAGE })
oReport:Section(1):Cell("AD1_VERBA" ):SetBlock({||Iif ((cAliasAD1)->AD1_MOEDA <= MOEDFIN(), xMoeda( (cAliasAD1)->AD1_VERBA, (cAliasAD1)->AD1_MOEDA, MV_PAR22, dDataBase ),xMoeda( (cAliasAD1)->AD1_VERBA, 1, MV_PAR22, dDataBase)) })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR21 <> 1
	oReport:Section(1):Section(1):Hide()
	oReport:Section(1):Section(2):Hide()
	oReport:Section(1):Section(3):Hide()
	oReport:Section(1):Section(4):Hide()
	If ( AliasInDic("AIJ") .AND. AIJ->(FieldPos("AIJ_NROPOR")) > 0 )
		oReport:Section(1):Section(5):Hide()
	EndIf	
EndIf 
oReport:SetMeter((cAliasAD1)->(LastRec()))
oReport:Section(1):Print()
oReport:Section(2):Print()
Return



  

//------------------------------------------------------------------------------
/*/{Protheus.doc} FTR10AIJSt

Adiciona o status da evolucao da venda no relatorio.

@sample 	FTR10AIJSt(cProVen, cStage, cDtIni, cHrIni, cStatus)

@param		ExpC1	Processo de Venda
@param		ExpC2	Estagio
@param		ExpC3	Data Inicial
@param		ExpC4	Hora Final
@param		ExpC4	Status encerrado.


@return	ExpC Status da Evolucao.

@author	Anderson Silva
@since		21/05/2013
@version	P12
/*/
//------------------------------------------------------------------------------
Static Function FTR10AIJSt(cProVen, cStage, cDtIni, cHrIni, cStatus)

Local aArea 		:= GetArea()			// Guarda a area atual.
Local nDtHrLimit	:= 0 					// Data / Hora limite para avancar o estagio.
Local nDtHrBase		:= 0   					// Database do sistema (Data/Hora).
Local dDtNotif		:= cTod("//") 			// Data que comecara a notificacao.
Local cHrNotif		:= ""					// Hora que comecara a notificacao. 
Local nDtHrNotif	:= 0					// Data / Hora de notificacao.
Local dDtLimit		:= cTod("//") 			// Data limite.
Local cHrLimit		:= ""  					// Hora limite.
Local nHrsInt		:= 0					// Hora em inteiro.
Local cRetorno		:= STR0034              // Status da evolucao.

DbSelectArea("AC2")
DbSetOrder(1)

If Empty(cStatus)
	
	If AC2->(DbSeek(xFilial("AC2")+cProVen+cStage))
		
		// Calcula a data e hora limite para avancar o estagio.
		Ft300LtEst(cDtIni, cHrIni, @dDtLimit,@cHrLimit)
		
		If ( AC2->AC2_DNOTIF <> 0 .OR. ( !Empty(AC2->AC2_HNOTIF) .AND. AC2->AC2_HNOTIF <> "00:00" ) )
			
			dDtNotif := dDtLimit - AC2->AC2_DNOTIF
			cHrNotif :=	cHrLimit
			nHrsInt  := HoraToInt(AC2->AC2_HNOTIF)
			
			SubtDiaHor(@dDtNotif,@cHrNotif,nHrsInt)
			
			nDtHrNotif	:= Val(DtoS(dDtNotif)+StrTran(cHrNotif,":",""))
			
		EndIf
		
		nDtHrLimit	:= Val(DtoS(dDtLimit)+StrTran(cHrLimit,":",""))
		nDtHrBase	:= Val(DtoS(dDataBase)+StrTran(SubStr(Time(),1,5),":",""))
		
		// Legenda do estagio atual. 
		If nDtHrLimit <> 0
			If ( nDtHrNotif <> 0 .AND. nDtHrBase >=  nDtHrNotif  .AND. nDtHrNotif <= nDtHrLimit  .AND. nDtHrLimit > nDtHrBase  )
				cRetorno := STR0032 // "Em alerta"
			ElseIf nDtHrBase > nDtHrLimit
				cRetorno := STR0033	// "Em atraso"
			EndIf
		Else
			cRetorno := STR0034 // "Em dia" 
		EndIf		
		
	EndIf
Else
	cRetorno := X3Combo("AIJ_STATUS",cStatus)
EndIf

RestArea(aArea)

Return( cRetorno )