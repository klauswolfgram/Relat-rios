/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR010.CH" 
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR010   ³ Autor ³ Eduardo Riera         ³ Data ³09.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Lista de Precos                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
/*/

User Function OMSR010()

Local oReport
Local cAliasSB1 := "SB1"
Local cAliasDA0 := "DA0"
Local cAliasDA1 := "DA1"

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef(@cAliasSB1,@cAliasDA0,@cAliasDA1)
	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf	
	oReport:PrintDialog()
Else
	U_OMSR010R3()
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Eduardo Riera          ³ Data ³08.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpC1: Alias da tabela de produto                           ³±±
±±³          ³ExpC2: Alias da tabela de preco                             ³±±
±±³          ³ExpC3: Alias da tabela de itens da tabela de preco          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(cAliasSB1,cAliasDA0,cAliasDA1)

Local oReport
Local oTabPrc
Local oItemTab
Local oTabBase

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
oReport := TReport():New("OMSR010",STR0024,"OMR010",{|oReport| ReportPrint(oReport,@cAliasSB1,@cAliasDA0,@cAliasDA1)},STR0025)	// "Listagem de Precos"###"Este relatorio ira imprimir as tabelas de precos de acordo com os parametros informados pelo usuario."
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
oTabPrc := TRSection():New(oReport,STR0026,{"DA0"},{STR0027,STR0028,STR0029,STR0030},.F.,.F.)	// "Tabela de Preço"###"Tipo"###"Grupo"###"Descrição de produto"###"Código de produto"
TRCell():New(oTabPrc,"DA0_CODTAB","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA0)->DA0_CODTAB})
TRCell():New(oTabPrc,"DA0_DESCRI","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA0)->DA0_DESCRI})
TRCell():New(oTabPrc,"DA0_DATDE","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/ ,{|| (cAliasDA0)->DA0_DATDE})
TRCell():New(oTabPrc,"DA0_HORADE","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA0)->DA0_HORADE})
TRCell():New(oTabPrc,"DA0_DATATE","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA0)->DA0_DATATE})
TRCell():New(oTabPrc,"DA0_HORATE","DA0",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA0)->DA0_HORATE})

oItemTab := TRSection():New(oTabPrc,STR0031,{"DA1","SB1"},/*aOrdem*/,.F.,.F.)	// "Produtos da tabela de preço"
TRCell():New(oItemTab,"DA1_CODPRO","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf((cAliasSB1)->B1_GRADE == "S",Substr((cAliasDA1)->DA1_CODPRO,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2))),(cAliasDA1)->DA1_CODPRO)})
TRCell():New(oItemTab,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIf(MV_PAR12 == 1.And.(cAliasSB1)->B1_GRADE=="S",SB4->B4_DESC,(cAliasSB1)->B1_DESC)})
TRCell():New(oItemTab,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_UM})
TRCell():New(oItemTab,"DA1_QTDLOT","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_QTDLOT})
TRCell():New(oItemTab,"DA1_PRCBAS","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_PRV1})
TRCell():New(oItemTab,"DA1_PRCVEN","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_PRCVEN})
TRCell():New(oItemTab,"DA1_MOEDA" ,"DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_MOEDA})
TRCell():New(oItemTab,"DA1_VLRDES","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_VLRDES})
TRCell():New(oItemTab,"DA1_PERDES","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_PERDES})
TRCell():New(oItemTab,"DA1_ESTADO","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasDA1)->DA1_ESTADO})
TRCell():New(oItemTab,"DA1_TPOPER","DA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| X3Combo("DA1_TPOPER",(cAliasDA1)->DA1_TPOPER)})

oTabBase := TRSection():New(oReport,STR0032,{"SB1"},{STR0027,STR0028,STR0029,STR0030},.F.,.F.)	// "Lista de Preços ( Base )"###"Tipo"###"Grupo"###"Descrição de produto"###"Código de produto"
TRCell():New(oTabBase,"B1_TIPO"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_TIPO})
TRCell():New(oTabBase,"B1_GRUPO"  ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_GRUPO})
TRCell():New(oTabBase,"B1_COD"    ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF((cAliasSB1)->B1_GRADE == "S",Substr((cAliasSB1)->B1_COD,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2))),(cAliasSB1)->B1_COD)})
TRCell():New(oTabBase,"B1_DESC"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF((cAliasSB1)->B1_GRADE == "S" .And. MV_PAR12 == 1,Substr((cAliasSB1)->B1_COD,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2))),(cAliasSB1)->B1_DESC)})
TRCell():New(oTabBase,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_UM})
TRCell():New(oTabBase,"B1_QE"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| RetFldProd((cAliasSB1)->B1_COD,"B1_QE",cAliasSB1)})
TRCell():New(oTabBase,"B1_PRV1"   ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasSB1)->B1_PRV1})

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Eduardo Riera          ³ Data ³08.05.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³ExpC2: Alias da tabela de produto                           ³±±
±±³          ³ExpC3: Alias da tabela de preco                             ³±±
±±³          ³ExpC4: Alias da tabela de itens da tabela de preco          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSB1,cAliasDA0,cAliasDA1)

Local cTabAnt   := ""
Local cProdRef  := ""
Local lNotGrade := .T.
Local cOrderBy  := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam/*Nome da Pergunte*/)
If ( MV_PAR11 == 2 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()		
	Do Case
    	Case oReport:Section(1):nOrder == 1
		    cOrderBy := "%DA0_FILIAL,DA0_CODTAB,B1_TIPO%"
		Case oReport:Section(1):nOrder == 2
			cOrderBy :=  "%DA0_FILIAL,DA0_CODTAB,B1_GRUPO%"
		Case oReport:Section(1):nOrder == 3
			cOrderBy :=  "%DA0_FILIAL,DA0_CODTAB,B1_DESC%"
		Case oReport:Section(1):nOrder == 4
			cOrderBy :=  "%DA0_FILIAL,DA0_CODTAB,DA1_CODPRO%"
	EndCase

	cAtivo := Iif(Str(mv_par13,1) $ ("1/2") ,Str(mv_par13,1),"'1','2'") 
	If (Str(mv_par13,1) <> "3")
	   cAtivo := "'" + cAtivo + "'"  
	Endif
	cAtivo := "(" + cAtivo + ")"
	cAtivo := "% " + cAtivo + " %" 
	
	cAliasDA0 := GetNextAlias()
	cAliasDA1 := cAliasDA0
	cAliasSB1 := cAliasDA1
	
	BeginSql Alias cAliasDA0
	SELECT DA0_CODTAB,DA0_DESCRI,DA0_DATDE,DA0_DATATE,DA0_HORADE,DA0_HORATE,
                    DA1_FILIAL,DA1_CODTAB,DA1_CODPRO,DA1_QTDLOT,DA1_PRCVEN,DA1_MOEDA,DA1_VLRDES,DA1_PERDES,DA1_ESTADO,DA1_TPOPER,DA1_ATIVO,
                    B1_TIPO,B1_GRUPO,B1_DESC,B1_UM,B1_GRADE,B1_PRV1
        FROM %table:SB1% SB1,%table:DA1% DA1,%table:DA0% DA0
        WHERE DA0.DA0_FILIAL = %xFilial:DA0% AND 
                    DA0.DA0_CODTAB >= %Exp:mv_par01% AND
                    DA0.DA0_CODTAB <= %Exp:mv_par02% AND
                    DA0.%NotDel% AND 
                    DA1.DA1_FILIAL = %xFilial:DA1% AND 
                    DA1.DA1_CODTAB = DA0.DA0_CODTAB AND 
                    DA1.DA1_ATIVO IN %Exp:cAtivo% AND
                    DA1.%NotDel% AND 
                    SB1.B1_FILIAL = %xFilial:SB1% AND 
                    SB1.B1_COD   =  DA1.DA1_CODPRO AND 
                    SB1.B1_TIPO  >= %Exp:mv_par03% AND
                    SB1.B1_TIPO  <= %Exp:mv_par04% AND
                    SB1.B1_GRUPO >= %Exp:mv_par05% AND
                    SB1.B1_GRUPO <= %Exp:mv_par06% AND
                    SB1.B1_COD   >= %Exp:mv_par07% AND
                    SB1.B1_COD   <= %Exp:mv_par08% AND
                    SB1.%NotDel% 
        ORDER BY %Exp:cOrderBy%
    EndSql 	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):EndQuery(/*ExpA1*/)
	oReport:Section(1):Section(1):SetParentQuery()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatório da secao 2                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(2):BeginQuery()	
	Do Case
    	Case oReport:Section(1):nOrder == 1
		    cOrderBy := "%B1_FILIAL,B1_TIPO,B1_COD%"
		Case oReport:Section(1):nOrder == 2
			cOrderBy :=  "%B1_FILIAL,B1_GRUPO,B1_COD%"
		Case oReport:Section(1):nOrder == 3
			cOrderBy :=  "%B1_FILIAL,B1_DESC%"
		Case oReport:Section(1):nOrder == 4
			cOrderBy :=  "%B1_FILIAL,B1_COD%"
	EndCase

	cAliasDA0 := GetNextAlias()
	cAliasDA1 := cAliasDA0
	cAliasSB1 := cAliasDA1

    BeginSql Alias cAliasSB1
        SELECT B1_TIPO,B1_GRUPO,B1_COD,B1_DESC,B1_UM,B1_GRADE,B1_PRV1,B1_QE
        FROM %table:SB1% SB1
        WHERE SB1.B1_FILIAL = %xFilial:SB1% AND 
              SB1.B1_TIPO  >= %Exp:mv_par03% AND
              SB1.B1_TIPO  <= %Exp:mv_par04% AND
              SB1.B1_GRUPO >= %Exp:mv_par05% AND
              SB1.B1_GRUPO <= %Exp:mv_par06% AND
              SB1.B1_COD   >= %Exp:mv_par07% AND
              SB1.B1_COD   <= %Exp:mv_par08% AND
              SB1.%NotDel%
        ORDER BY %Exp:cOrderBy%
    EndSql
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//³                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(2):EndQuery(/*ExpA1*/)
EndIf
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
TRPosition():New(oReport:Section(1):Section(1),"SB1",1,{|| xFilial("SB1")+(cAliasDA1)->DA1_CODPRO})
TRPosition():New(oReport:Section(1):Section(1),"SB4",1,{|| xFilial("SB4")+Substr((cAliasDA1)->DA1_CODPRO,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))})
TRPosition():New(oReport:Section(2),"SB4",1,{|| xFilial("SB4")+Substr((cAliasSB1)->B1_COD,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))})
If ( MV_PAR11 == 2 )
	oReport:SetMeter(DA0->(LastRec()))
	
	
	dbSelectArea(cAliasDA0)
	While !Eof() .And. !oReport:Cancel()	               
      oReport:Section(1):Init()
		oReport:Section(1):PrintLine()
		oReport:Section(1):Section(1):Init()
		        
		lNotGrade := .T.
		cTabAnt   := (cAliasDA0)->DA0_CODTAB
			
		dbSelectArea(cAliasDA1)			
		While !oReport:Cancel() .And. !Eof() .And. (cAliasDA1)->DA1_FILIAL == xFilial("DA1") .And. (cAliasDA1)->DA1_CODTAB == cTabAnt
		
			If ValidMasc((cAliasDA1)->DA1_CODPRO,MV_PAR09)
				If MV_PAR12 == 1
					lNotGrade := .T.							
					If (cAliasSB1)->B1_GRADE == "S" .And. !Empty(cProdRef) .And. cProdRef == Substr((cAliasDA1)->DA1_CODPRO,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))
						lNotGrade := .F.
					EndIf
				EndIf

				If lNotGrade
					oReport:Section(1):Section(1):PrintLine()
    			EndIf
			EndIf
			cProdRef := Substr((cAliasDA1)->DA1_CODPRO,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))
 		
 			dbSelectarea(cAliasDA1)
			dbSkip()
						
		EndDo
		oReport:Section(1):Section(1):Finish()
		If mv_par10 == 1
			oReport:Section(1):SetPageBreak(.T.)
		Else			
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oReport:Section(1):Finish()
		oReport:IncMeter()
		
	EndDo
	
Else			
	oReport:SetMeter(SB1->(LastRec()))
	
	dbSelectArea(cAliasSB1)
	dbGotop()

	While !oReport:Cancel() .And. !(cAliasSB1)->(Eof())		
		lNotGrade := .T.
		oReport:Section(2):Init()			
		While !oReport:Cancel() .And. !(cAliasSB1)->(Eof())
			If ValidMasc((cAliasSB1)->B1_COD,MV_PAR09)
				If MV_PAR12 == 1      
					lNotGrade := .T.
					If (cAliasSB1)->B1_GRADE == "S" .And. !Empty(cProdRef) .And. cProdRef == Substr((cAliasSB1)->B1_COD,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))
						lNotGrade := .F.
					EndIf
				EndIf
				If lNotGrade			        
					oReport:Section(2):PrintLine()					
    			EndIf
			EndIf
			cProdRef := Substr((cAliasSB1)->B1_COD,1,Val(Substr(SuperGetMv("MV_MASCGRD",.F.),1,2)))
			dbSelectArea(cAliasSB1)
			dbSkip()		
		EndDo
		oReport:Section(2):Finish()		
	EndDo
EndIf
	If Select(cAliasDA0)  > 0 
		DbSelectArea(cAliasDA0) 
		DbCloseArea()
	EndIf
	If Select(cAliasDA1)  > 0 
		DbSelectArea(cAliasDA1) 
		DbCloseArea()
	EndIf
	If Select(cAliasSB1)  > 0 
		DbSelectArea(cAliasSB1) 
		DbCloseArea()
	EndIf
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR010R3 ³ Autor ³ Henry Fila            ³ Data ³ 20.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Listagem de Precos                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
/*/
User Function OMSR010R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	Local Titulo  := OemToAnsi(STR0001) //"Listagem de Precos"
	Local cDesc1  := OemToAnsi(STR0017) //"Este relatorio ira imprimir as tabelas de precos de acordo"
	Local cDesc2  := OemToAnsi(STR0018) //"com os parametros informados pelo usuario"
	Local cDesc3  := OemToAnsi("") //""  // Descricao 3
#ELSE
	Local Titulo  := STR0001 // "Listagem de Precos"
	Local cDesc1  := STR0017 //"Este relatorio ira imprimir as tabelas de precos de acordo"
	Local cDesc2  := STR0018 //"com os parametros informados pelo usuario"
	Local cDesc3  := ""
#ENDIF
Local cString := "DA0"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "OMSR010"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "OMSR010"  // nome do programa

Private Tamanho := "M" // P/M/G
Private Limite  := 132 // 80/132/220
Private aOrdem  := {STR0015,STR0016,STR0019,STR0023}		//" Por Tipo           "###" Por Grupo        "###"Por descrição do produto"###"Por produto"
Private cPerg   := "OMR010"  // Pergunta do Relatorio
Private aReturn := { STR0002, 1,STR0003, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Funcao utilizada para verificar a ultima versao dos fontes      ³
//³ SIGACUS.PRW, SIGACUSA.PRX e SIGACUSB.PRX, aplicados no rpo do   |
//| cliente, assim verificando a necessidade de uma atualizacao     |
//| nestes fontes. NAO REMOVER !!!							        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF !(FindFunction("SIGACUS_V") .and. SIGACUS_V() >= 20050512)
    Final("Atualizar SIGACUS.PRW !!!")
Endif
IF !(FindFunction("SIGACUSA_V") .and. SIGACUSA_V() >= 20050512)
    Final("Atualizar SIGACUSA.PRX !!!")
Endif
IF !(FindFunction("SIGACUSB_V") .and. SIGACUSB_V() >= 20050512)
    Final("Atualizar SIGACUSB.PRX !!!")
Endif

Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
EndIf
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
EndIf
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
#ELSE
	ImpDet(.F.,wnrel,cString,nomeprog,Titulo)
#ENDIF

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
/*/

Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

Local lImp      := .F. // Indica se algo foi impresso
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local aStruQry  := {}            
Local cQry      := ""
Local nX        := 0


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime a tabela de precos baseado no DA0 e no DA1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par11 == 2

	dbSelectArea("SX3")
	dbSetOrder(2)
	MsSeek("DA0_DATDE")
	aadd(aStruQry,{"TRB_DATDE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			

	MsSeek("DA0_DATATE")
	aadd(aStruQry,{"TRB_DATATE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			
	
	MsSeek("DA1_QTDLOT")
	aadd(aStruQry,{"TRB_QTDLOT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			

	MsSeek("DA1_PRCVEN")
	aadd(aStruQry,{"TRB_PRCVEN",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			

	MsSeek("DA1_MOEDA")
	aadd(aStruQry,{"TRB_MOEDA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			
	
	MsSeek("DA1_VLRDES")
	aadd(aStruQry,{"TRB_VLRDES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			

	MsSeek("DA1_PERDES")
	aadd(aStruQry,{"TRB_PERDES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			

	MsSeek("B1_PRV1")
	aadd(aStruQry,{"TRB_PRV1",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})			
		
	cQry := "SELECT DA0_CODTAB TRB_CODTAB,DA0_DESCRI TRB_DESTAB,DA0_DATDE TRB_DATDE,DA0_HORADE TRB_HORADE,DA0_DATATE TRB_DATATE,"
	cQry += "DA0_HORATE TRB_HORATE,DA1_CODPRO TRB_CODPRO,DA1_QTDLOT TRB_QTDLOT, DA1_PRCVEN TRB_PRCVEN, DA1_MOEDA TRB_MOEDA, DA1_VLRDES TRB_VLRDES, "
	cQry += "DA1_PERDES TRB_PERDES, DA1_ESTADO TRB_ESTADO ,DA1_TPOPER TRB_TPOPER ,"
	cQry += "B1_TIPO TRB_TIPO ,B1_GRUPO TRB_GRUPO ,B1_DESC TRB_DESPRO ,B1_UM TRB_UM,B1_GRADE TRB_GRADE,B1_PRV1 TRB_PRV1"
	cQry += " FROM "+RetSqlName('SB1')+" SB1,"
	cQry += " "+RetSqlName('DA1')+" DA1,"
	cQry += " "+RetSqlName('DA0')+" DA0"		
	
	cQry += " WHERE "
	cQry += " DA0_FILIAL = '"+xFilial('DA1')+"'"
	cQry += " AND DA0_CODTAB >= '"+mv_par01+"' "
	cQry += " AND DA0_CODTAB <= '"+mv_par02+"' "
	cQry += " AND DA0.D_E_L_E_T_ = ' '"         
	
	cQry += " AND DA1_FILIAL = '"+xFilial('DA1')+"'"
    cQry += " AND DA1_CODTAB = DA0_CODTAB "
	
	If mv_par13 <> 3			
		cQry += " AND DA1_ATIVO = '"+Str(mv_par13,1)+"' "
 	EndIf
    
	cQry += " AND DA1.D_E_L_E_T_ = ' '"         

	cQry += " AND B1_FILIAL = '"+xFilial('SB1')+"'"
	cQry += " AND B1_COD = DA1_CODPRO "
	cQry += " AND B1_TIPO >= '"+mv_par03+"' "		
	cQry += " AND B1_TIPO <= '"+mv_par04+"' "		
	cQry += " AND B1_GRUPO >='"+mv_par05+"' "		
	cQry += " AND B1_GRUPO <='"+mv_par06+"' "		
	cQry += " AND B1_COD >= '"+mv_par07+"' "	
	cQry += " AND B1_COD <='"+mv_par08+"' "	
	cQry += " AND SB1.D_E_L_E_T_ = ' '"

	Do Case

    	Case aReturn[8] == 1
		    cQry += " ORDER BY TRB_CODTAB,TRB_TIPO"
		Case aReturn[8] == 2
		    cQry += " ORDER BY TRB_CODTAB,TRB_GRUPO"
		Case aReturn[8] == 3				        
		    cQry += " ORDER BY TRB_CODTAB,TRB_DESPRO"
		Case aReturn[8] == 4
		    cQry += " ORDER BY TRB_CODTAB,TRB_CODPRO"
	EndCase
	
	cQry := ChangeQuery(cQry)
	dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQry),"TRBPRC",.f.,.t.)

	For nX := 1 To Len(aStruQry)
		If ( aStruQry[nX][2] <> "C" )
			TcSetField("TRBPRC",aStruQry[nX][1],aStruQry[nX][2],aStruQry[nX][3],aStruQry[nX][4])
		EndIf
	Next nX
	 		
	lImp := .T.			
	
	cAliasSB1 := "TRBLIS"
	cAliasDA0 := "TRBLIS"
	cAliasDA1 := "TRBLIS"		

	dbSelectArea("TRBPRC")
	dbGotop()  
EndIf

Omr010Imp(lEnd,wnrel,cString,nomeprog,Titulo,mv_par11)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se usou a tabela do DA0 fecha arquivo temporario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par11 == 2
	dbSelectArea("TRBPRC")
	dbClearFilter()
	dbCloseArea()
EndIf	
If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf
Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Omr010Imp   ºAutor  ³Henry Fila          º Data ³  21/06/01 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria arquivo temporario para tabela de precos              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5dl                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Omr010Imp(lEnd,wnrel,cString,nomeprog,Titulo,nTipo)

Local cTabant  := ""
Local cProdRef := ""                       
Local cMascara :=GetMv("MV_MASCGRD")
Local li       := 100 // Contador de Linhas
Local lRet     := .T.
Local cKeySB1  := ""
Local cIndSB1  := ""
Local cCondSB1 := ""
Local condicao := ""

//
//                                    1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                          XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX    XXX,XXX.XX    XXX,XXX.XX  XXX,XXX.XX   XXX,XXX.XX  XXX.XXX  XX     XXXXXXXXXX
Local cCabec1 := STR0004 //"CODIGO          DESCRICAO                      UM     FAIXA ATE         PRECO       PRECO MO- DESCONTO    FATOR  ESTADO TP.OPERACAO" 
Local cCabec2 := STR0005 //"                                                                         BASE      TABELA EDA" 

Local nTamRef :=Val(Substr(cMascara,1,2))
Local nCol    := 0 
Local nIndSB1  := 0

If nTipo == 2

	dbSelectArea("TRBPRC")
	SetRegua(RecCount())
	dbGotop()	
	
	While !Eof()	
	
		lRet    := .T.
		cTabAnt := TRBPRC->TRB_CODTAB	
		
		If lEnd
			@ Prow()+1,001 PSAY STR0006 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	
		If ( li > 58 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		EndIf
		
		@ li,000 PSAY STR0007 + TRBPRC->TRB_CODTAB + " - " +TRBPRC->TRB_DESTAB //"TABELA :"
		li++
		
		If ( li > 58 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		EndIf
			
		@ li,000 PSAY STR0008 + DtoC(TRBPRC->TRB_DATDE) + " as " + TRBPRC->TRB_HORADE + " Ate " + DtoC(TRBPRC->TRB_DATATE) + " as " + TRBPRC->TRB_HORATE //"VALIDADE :"
		li++
			
		If ( li > 58 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		EndIf
	
		@ li,000 PSAY __PrtThinLine()
		li++
		
		While !Eof() .And. TRBPRC->TRB_CODTAB == cTabAnt
		
			If ( li > 58 )
				li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
				li++
			EndIf

			If mv_par12 == 1
				
				If TRBPRC->TRB_GRADE == "S" .And. !Empty(cProdRef) .And. cProdRef == Substr(TRBPRC->TRB_CODPRO,1,nTamRef)
					lRet := .F.
				Endif	
				
			Endif

			If lRet

				If TRBPRC->TRB_GRADE == "S"
					@ li,000 PSAY Substr(TRBPRC->TRB_CODPRO,1,nTamRef)
					
					If mv_par12 == 1
						dbSelectArea("SB4")
						If MsSeek(xFilial("SB4")+Substr(TRBPRC->TRB_CODPRO,1,nTamRef))
						 	@ li,016 PSAY SB4->B4_DESC
						Endif						 	
					Else 	                    
						@ li,016 PSAY TRBPRC->TRB_DESPRO
					Endif
				Else
					@ li,000 PSAY TRBPRC->TRB_CODPRO
				 	@ li,016 PSAY Substr(TRBPRC->TRB_DESPRO,1,30)					
				Endif	

	 			@ li,047 PSAY TRBPRC->TRB_UM
		 		@ li,050 PSAY TRBPRC->TRB_QTDLOT Picture Pesqpict("DA1","DA1_QTDLOT")
		 		@ li,064 PSAY TRBPRC->TRB_PRV1   Picture x3Picture("DA1_PRCBAS")		
	 			@ li,076 PSAY TRBPRC->TRB_PRCVEN Picture Pesqpict("DA1","DA1_PRCVEN")			 			
	 			@ li,090 PSAY TRBPRC->TRB_MOEDA
		 		@ li,094 PSAY TRBPRC->TRB_VLRDES Picture Pesqpict("DA1","DA1_VLRDES")
		 		@ li,108 PSAY TRBPRC->TRB_PERDES Picture Pesqpict("DA1","DA1_PERDES")
	 			@ li,115 PSAY TRBPRC->TRB_ESTADO
                                                       
				Do case
					Case TRBPRC->TRB_TPOPER == "1"
		 				cDescOper := STR0009 //"Estadual"
					Case TRBPRC->TRB_TPOPER == "2"
						cDescOper := STR0010 //"Inter-Esta"
					Case TRBPRC->TRB_TPOPER == "3"
						cDescOper := STR0011 //"Norte/Nord"
					Case TRBPRC->TRB_TPOPER == "4"
						cDescOper := STR0012 //"Todos"
		 						
				EndCase	 					
		 					
				@ li,122 PSAY cDescOper
    
			Endif

			cProdRef:=Substr(TRBPRC->TRB_CODPRO,1,nTamRef)
	 				
		    LI++
			dbSelectarea("TRBPRC")
			dbSkip()
		EndDo
		
		If mv_par10 == 1
			li := 80
		Else			
			li += 2	
		EndIf		
	EndDo	
	
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime a tabela de precos baseado no SB1     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	dbSelectArea("SB1")           
	SetRegua(RecCount())		// Total de Elementos da regua
	Do Case              
    Case aReturn[8] == 1
		cOrdem := OemtoAnsi(STR0021) //  "TIPO "
		cCampo := "B1_TIPO"
	Case aReturn[8] == 2
		cOrdem := OemtoAnsi(STR0022) //  "GRUPO"
		cCampo := "B1_GRUPO"
	Case aReturn[8] == 3
		cOrdem := "     "
		cCampo := "B1_COD"
	Case aReturn[8] == 4
		cOrdem := "     "
		cCampo := "B1_COD"		
	EndCase
    
	titulo := STR0001          //"Listagem de Precos"
	cabec1 := cOrdem+STR0013 //"   CODIGO                         DESCRICAO  DO  PRODUTO         UM            QTD P/     BASE    "
	cabec2 := Space(5)+STR0014	//"                                                          EMBAL."
	nTipo:=IIF(aReturn[4]==1,GetMV("MV_COMP"),GetMV("MV_NORM")) 

	Do Case
	Case aReturn[8] == 1
		dbSetOrder(2)
		dbSeek(xFilial()+mv_par03,.T.)
		condicao := "B1_TIPO <= MV_PAR04"
	Case  aReturn[8] == 2
		dbSetOrder(4)
		dbSeek(xFilial()+mv_par05,.T.)
		condicao := "B1_GRUPO <= MV_PAR06"
	Case  aReturn[8] == 3                
		condicao := ".T."
	
		dbSetOrder(3)                           
		cKeySB1 := SB1->(IndexKey())
		cIndSB1 := CriaTrab(NIL,.F.)
		cCondSB1 += 'B1_FILIAL == "'+xFilial("SB1")+'" .And.' 
		cCondSB1 += 'B1_COD >= "'+mv_par07+'" .And.B1_COD <= "'+mv_par08+'" .And.'
		cCondSB1 += 'B1_TIPO >= "'+mv_par03+'" .And.B1_TIPO <= "'+mv_par04+'" .And.'
		cCondSB1 += 'B1_GRUPO >= "'+mv_par05+'" .And.B1_GRUPO <= "'+mv_par06+'"'			
		
		IndRegua("SB1",cIndSB1,cKeySB1,,cCondSB1) //"Selecionando Registros ..."    
		
		nIndSB1 := RetIndex("SB1")

		dbSetOrder(nIndSB1+1)       
		dbGotop()     

	Case  aReturn[8] == 4
		condicao := ".T."
	
		dbSetOrder(1)
		cKeySB1 := SB1->(IndexKey())
		cIndSB1 := CriaTrab(NIL,.F.)
		cCondSB1 += 'B1_FILIAL == "'+xFilial("SB1")+'" .And.' 
		cCondSB1 += 'B1_COD >= "'+mv_par07+'" .And.B1_COD <= "'+mv_par08+'" .And.'
		cCondSB1 += 'B1_TIPO >= "'+mv_par03+'" .And.B1_TIPO <= "'+mv_par04+'" .And.'
		cCondSB1 += 'B1_GRUPO >= "'+mv_par05+'" .And.B1_GRUPO <= "'+mv_par06+'"'			
		
		IndRegua("SB1",cIndSB1,cKeySB1,,cCondSB1) //"Selecionando Registros ..."    
		
		nIndSB1 := RetIndex("SB1")

		dbSetOrder(nIndSB1+1)       
		dbGotop()     
		
	EndCase

	While !Eof().And.B1_FILIAL=xFilial().And.&condicao
	
		IncRegua()  
		
		lRet := .T.
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida o produto conforme a mascara         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ValidMasc(SB1->B1_COD,MV_PAR09)
		
			IF lEnd
				@Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
				Exit
			EndIf
	
			cCodant := &cCampo
			
			While !Eof().And.SB1->B1_FILIAL==xFilial().And.cCodant == &cCampo
		    	lRet := .T.
		
				If lEnd
					@ Prow()+1,001 PSAY STR0011	//"CANCELADO PELO OPERADOR"
					exit
				EndIf
		
				IncRegua()

		       IF (B1_GRUPO < mv_par05 .Or. B1_GRUPO > mv_par06) .Or. (B1_TIPO <= mv_par03 .Or. B1_TIPO >= mv_par04)
						lRet := .F.
					EndIf
		
				IF SB1->B1_COD >= mv_par07 .And. SB1->B1_COD <= mv_par08 .And. ValidMasc(SB1->B1_COD,MV_PAR09) .And. lRet
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Valida o produto conforme a mascara         ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		
					IF LI > 55
						li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
						li++
					EndIf
				
					If mv_par12 == 1
					
						If SB1->B1_GRADE == "S" .And. !Empty(cProdRef) .And. cProdRef == Substr(SB1->B1_COD,1,nTamRef)
							lRet := .F.
						Endif	

					Endif

					If lRet                          
				       
						If aReturn[8] <> 3 .And. aReturn[8] <> 4
							@ li,00 PSAY &cCampo
						Endif
							
						@ li,08 PSAY IIF(SB1->B1_GRADE == "S",Substr(B1_COD,1,nTamRef),B1_COD)
						@ li,39 PSAY IIF(SB1->B1_GRADE == "S" .And. mv_par12 == 1,Substr(B1_COD,1,nTamRef),Substr(B1_DESC,1,30))
						@ li,72 PSAY B1_UM
						@ li,75 PSAY RetFldProd(SB1->B1_COD,"B1_QE") Picture AllTrim(X3PICTURE("B1_QE"))
						@ li,82 pSay SB1->B1_PRV1 Picture PesqPict("SB1", "B1_PRV1",18)
						
						cProdRef:=Substr(SB1->B1_COD,1,nTamRef)
											
						li++
					Endif						
			
				Endif	
				
				dbSelectArea("SB1")
				dbSkip()
			
			EndDo
	
			dbSelectArea("SB1")
			@ li,00 PSAY __PrtThinLine()
			li++
			
		Endif			
		
	EndDo
EndIf

RetIndex("SB1")
dbSelectArea("SB1")
dbSetOrder(1)
		
Return