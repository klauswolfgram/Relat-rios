/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'MATR280.CH'
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR280  ³ Autor ³ Ricardo Berti         ³ Data ³20.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Listagem do pre'-inventario                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAEST                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR280()
Local oReport
Private cAliasSB1 := "SB1"
Private cAliasSB2 := "SB2"

	If SuperGetMV("MV_WMSNEW",.F.,.F.)
		If FindFunction('WMSR460')
			WMSR460()
			Return
		EndIf
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Ricardo Berti 		³ Data ³20.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
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
Static Function ReportDef()

Local aOrdem	:= {}
Local cPerg		:= "MTR280"
Local oReport
Local oCell
Local oSection1
Local oSection2

If !__lPyme
	aOrdem := {STR0005,STR0006,STR0007,STR0008,STR0017}   //' Por Codigo         '###' Por Tipo           '###' Por Descricao    '###' Por Grupo        '###' Por Endereco     '
Else
	aOrdem := {STR0005,STR0006,STR0007,STR0008}   //' Por Codigo         '###' Por Tipo           '###' Por Descricao    '###' Por Grupo        '
EndIf	
                
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
oReport := TReport():New("MATR280",STR0001,cPerg, {|oReport| ReportPrint(oReport)},STR0002+" "+STR0003+" "+STR0004) // 'Listagem para Inventario'##'Este programa emite um relatorio que facilita a digitacao'##'das quantidades inventariadas.'##"Ele e' emitido de acordo com os parametros informados."
oReport:SetLandScape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // Almox. de                                    ³
//³ mv_par02     // Almox. ate                                   ³
//³ mv_par03     // Produto de                                   ³
//³ mv_par04     // Produto ate                                  ³
//³ mv_par05     // tipo de                                      ³
//³ mv_par06     // tipo ate                                     ³
//³ mv_par07     // grupo de                                     ³
//³ mv_par08     // grupo ate                                    ³
//³ mv_par09     // descricao de                                 ³
//³ mv_par10     // descricao ate                                ³
//³ mv_par11     // data Selecao de                              ³
//³ mv_par12     // data Selecao ate                             ³
//³ mv_par13     // Imprime Lote/Sub-Lote e N£mero de S‚rie ?    ³
//³ mv_par14     // Lista Prod. C/ Sld Zerado ? (Sim/Nao)        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao das celulas da secao do relatorio                               ³
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection1 := TRSection():New(oReport,STR0024,{"SB1","SB2","NNR"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //"Produtos"

TRCell():New(oSection1,"B1_COD","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_TIPO","SB1")
TRCell():New(oSection1,"B1_GRUPO","SB1")
TRCell():New(oSection1,"B1_DESC","SB1")
TRCell():New(oSection1,"B1_UM","SB1")
TRCell():New(oSection1,"B2_LOCAL","SB2")
TRCell():New(oSection1,"NNR_DESCRI","NNR")

If !__lPyme
	oCell := TRCell():New(oSection1,"LOCALIZ","")
	oCell:GetFieldInfo("BF_LOCALIZ")
EndIf	

	oCell := TRCell():New(oSection1,"LOTECTL","")
	oCell:GetFieldInfo("BF_LOTECTL")
	oCell := TRCell():New(oSection1,"NUMLOTE","")
	oCell:GetFieldInfo("BF_NUMLOTE")
           
If !__lPyme
	oCell := TRCell():New(oSection1,"NUMSERI","")
	oCell:GetFieldInfo("BF_NUMSERI")
	oCell:SetSize(14)
EndIf

TRCell():New(oSection1,"QTD1","",STR0018+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______1a."###"Quantidade"
TRCell():New(oSection1,"ETQ1","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"
TRCell():New(oSection1,"QTD2","",STR0022+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______2a."###"Quantidade"
TRCell():New(oSection1,"ETQ2","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"
TRCell():New(oSection1,"QTD3","",STR0023+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______3a."###"Quantidade"
TRCell():New(oSection1,"ETQ3","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"

// Secao para a ordem por ENDERECO (muda o arq.base)
If !__lPyme
	
	oSection2 := TRSection():New(oReport,STR0025,{"SBE","SB1","SB2","NNR"}) //"Saldos por Endereço"
	
	oCell:=TRCell():New(oSection2,"B1COD","SB1",,,,,{|| (cAliasSB1)->B1_COD})
	oCell:GetFieldInfo("B1_COD")
	oCell:=TRCell():New(oSection2,"B1TIPO","SB1",,,,,{|| (cAliasSB1)->B1_TIPO})
	oCell:GetFieldInfo("B1_TIPO")
	oCell:=TRCell():New(oSection2,"B1GRUPO","SB1",,,,,{|| (cAliasSB1)->B1_GRUPO})
	oCell:GetFieldInfo("B1_GRUPO")
	oCell:=TRCell():New(oSection2,"B1DESC","SB1",,,,,{|| (cAliasSB1)->B1_DESC})
	oCell:GetFieldInfo("B1_DESC")
	oCell:=TRCell():New(oSection2,"B1UM","SB1",,,,,{|| (cAliasSB1)->B1_UM})
	oCell:GetFieldInfo("B1_UM")
	oCell:=TRCell():New(oSection2,"B2LOCAL","SB2",,,,,{|| (cAliasSB2)->B2_LOCAL})
	oCell:GetFieldInfo("B2_LOCAL")

	oCell:=TRCell():New(oSection2,"NNRDESCRI","NNR",,,,,{|| (cAliasSB1)->NNR_DESCRI})
	oCell:GetFieldInfo("NNR_DESCRI")

	oCell := TRCell():New(oSection2,"LOCALIZ2","")
	oCell:GetFieldInfo("BF_LOCALIZ")
	oCell := TRCell():New(oSection2,"LOTECTL2","")
	oCell:GetFieldInfo("BF_LOTECTL")
	oCell := TRCell():New(oSection2,"NUMLOTE2","")
	oCell:GetFieldInfo("BF_NUMLOTE")
	oCell := TRCell():New(oSection2,"NUMSERI2","")
	oCell:GetFieldInfo("BF_NUMSERI")
	oCell:SetSize(14)
	TRCell():New(oSection2,"QTD1_2","",STR0018+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______1a."###"Quantidade"
	TRCell():New(oSection2,"ETQ1_2","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"
	TRCell():New(oSection2,"QTD2_2","",STR0022+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______2a."###"Quantidade"
	TRCell():New(oSection2,"ETQ2_2","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"
	TRCell():New(oSection2,"QTD3_2","",STR0023+CRLF+STR0019,,11,,{|| "[         ]" }) //" _______3a."###"Quantidade"
	TRCell():New(oSection2,"ETQ3_2","",STR0020+CRLF+STR0021,, 8,,{|| "[      ]" }) //"Contagem"###"Etiqueta"
	
EndIf

Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti         ³ Data ³20.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local cAliasQRY  := ""
Local cAliasSBF  := 'SBF'
Local cCondicao1 := ""
Local cLoteAnt   := ""
Local cOrdem     := ""
Local lImpLote   := If(mv_par13==1,.T.,.F.)
Local nOrdem     := oReport:Section(1):GetOrder()
Local lFirst     := .T.
Local lRastro    := .F.
Local lRastroS   := .F.
Local lCLocal    := .F.
Local oSection1  := oReport:Section(1)
Local oSection2  := oReport:Section(2)
Local cWhereSBF  := ''
Local dDataInv   := ''
Local lWmsNew    := SuperGetMV("MV_WMSNEW",.F.,.F.)
Local cWhere     := ''

If nOrdem == 1
	cOrdem := STR0005
ElseIf nOrdem == 2
	cOrdem := STR0006
ElseIf nOrdem == 3
	cOrdem := STR0007
ElseIf nOrdem == 4
	cOrdem := STR0008
ElseIf nOrdem == 5
	cOrdem := STR0017
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os Arquivos e Ordens a serem utilizados           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 5
	oSection2:SetHeaderPage()
	dbSelectArea("SBE")
	dbSetOrder(1)
Else
	oSection1:SetHeaderPage()
EndIf
oReport:SetTitle(oReport:Title()+" ("+AllTrim(cOrdem)+")" )

dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB8')
dbSetOrder(3)

dbSelectArea('SBF')
dbSetOrder(2)

dbSelectArea('SB1')
dbSetOrder(nOrdem)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasQRY := GetNextAlias()
	cAliasSB1 := cAliasQRY
	cAliasSB2 := cAliasQRY

	cWhere := "%"
	If mv_par14 == 2
		cWhere += " AND B2_QATU <> 0 "
	EndIf
	cWhere += "%"
	
	cWhereSBF := "%"
	If MV_PAR14 == 2
		cWhereSBF += " AND BF_QUANT <> 0 "
	EndIf
	cWhereSBF += "%"

	If !__lPyme .And. nOrdem == 5

		cAliasSBF := cAliasQRY
		
		oSection2:BeginQuery()

		BeginSql Alias cAliasQRY
			SELECT	BE_FILIAL,BE_LOCAL,BE_LOCALIZ,BF_FILIAL,
					BF_PRODUTO,BF_LOCAL,BF_LOCALIZ,BF_LOTECTL,BF_NUMLOTE,BF_NUMSERI,BF_DINVENT,
					B1_FILIAL,B1_COD,B1_TIPO,B1_GRUPO,B1_DESC,B1_UM,B1_PERINV,
					B2_FILIAL,B2_COD,B2_LOCAL,NNR_DESCRI,B2_DINVENT,B2_DINVFIM,B2_DTINV
	
			FROM %table:SB1% SB1, %table:SB2% SB2, %table:NNR% NNR, %table:SBE% SBE
			  JOIN %table:SBF% SBF
			  ON	SBF.BF_FILIAL  = %xFilial:SBF% AND
			  		SBF.BF_LOCAL   = SBE.BE_LOCAL AND
			  		SBF.BF_LOCALIZ = SBE.BE_LOCALIZ AND
					SBF.BF_PRODUTO >= %Exp:mv_par03% AND 
					SBF.BF_PRODUTO <= %Exp:mv_par04% AND 
					SBF.%NotDel%
		 	  WHERE	SBE.BE_FILIAL  = %xFilial:SBE% AND
					SBE.BE_LOCAL  >= %Exp:mv_par01% AND 
					SBE.BE_LOCAL  <= %Exp:mv_par02% AND 
		 	       	SB1.B1_FILIAL  = %xFilial:SB1% AND
					SB1.B1_COD     = SBF.BF_PRODUTO AND
					SB1.B1_TIPO   >= %Exp:mv_par05% AND 
					SB1.B1_TIPO   <= %Exp:mv_par06% AND 
					SB1.B1_GRUPO  >= %Exp:mv_par07% AND 
					SB1.B1_GRUPO  <= %Exp:mv_par08% AND 
					SB1.B1_DESC   >= %Exp:mv_par09% AND 
					SB1.B1_DESC   <= %Exp:mv_par10% AND 
		 	       	SB2.B2_FILIAL  = %xFilial:SB2% AND
					SB2.B2_COD     = SBF.BF_PRODUTO AND
					SB2.B2_LOCAL   = SBF.BF_LOCAL AND
					NNR.NNR_FILIAL = %xFilial:NNR% AND
					NNR.NNR_CODIGO = SBE.BE_LOCAL AND
					SB1.%NotDel% AND
					SB2.%NotDel% AND
	 				SBE.%NotDel% AND
	 				NNR.%NotDel%
					%Exp:cWhere%           
				
			ORDER BY %Order:SBE% 
					
		EndSql
		
		oSection2:EndQuery(/*Array com os parametros do tipo Range*/)

	Else
		oSection1:BeginQuery()	

		BeginSql Alias cAliasQRY
			SELECT B1_FILIAL,B1_COD,B1_TIPO,B1_GRUPO,B1_DESC,B1_UM,B1_PERINV,B2_FILIAL,B2_COD,B2_LOCAL,NNR_DESCRI,B2_DINVENT,B2_DINVFIM,B2_DTINV
		
			FROM %table:NNR% NNR, %table:SB1% SB1 
			  JOIN %table:SB2% SB2
			  ON	B2_FILIAL  = %xFilial:SB2% AND
					B2_COD     = B1_COD AND
					B2_LOCAL  >= %Exp:mv_par01% AND 
					B2_LOCAL  <= %Exp:mv_par02% AND 
					SB2.%NotDel%
		 	  WHERE	B1_FILIAL  = %xFilial:SB1% AND
					B1_COD    >= %Exp:mv_par03% AND 
					B1_COD    <= %Exp:mv_par04% AND 
					B1_TIPO   >= %Exp:mv_par05% AND 
					B1_TIPO   <= %Exp:mv_par06% AND 
					B1_GRUPO  >= %Exp:mv_par07% AND 
					B1_GRUPO  <= %Exp:mv_par08% AND 
					B1_DESC   >= %Exp:mv_par09% AND 
					B1_DESC   <= %Exp:mv_par10% AND
					NNR_FILIAL = %xFilial:NNR% AND
					NNR_CODIGO = B2_LOCAL AND 
					SB1.%NotDel% AND
					NNR.%NotDel%
					%Exp:cWhere%           
				
			ORDER BY %Order:SB1% 
					
		EndSql

		oSection1:EndQuery(/*Array com os parametros do tipo Range*/)
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Metodo EndQuery ( Classe TRSection )                                    ³
	//³                                                                        ³
	//³Prepara o relatório para executar o Embedded SQL.                       ³
	//³                                                                        ³
	//³ExpA1 : Array com os parametros do tipo Range                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//oReport:Section(2):SetParentQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do relatorio		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasQRY)

	If ! lImpLote
		If nOrdem == 5
		If !__lPyme
			oSection2:Cell("LOCALIZ2"):Disable()
		EndIf
		oSection2:Cell("LOTECTL2"):Disable()
		oSection2:Cell("NUMLOTE2"):Disable()
		If !__lPyme
			oSection2:Cell("NUMSERI2"):Disable()
		EndIf
	Else
		If !__lPyme
			oSection1:Cell("LOCALIZ"):Disable()
    	EndIf
		oSection1:Cell("LOTECTL"):Disable()
		oSection1:Cell("NUMLOTE"):Disable()
		If !__lPyme
			oSection1:Cell("NUMSERI"):Disable()
		EndIf
	EndIf
Else
	If nOrdem == 5
		If !__lPyme
			oSection2:Cell("LOCALIZ2"):Enable()
		EndIf
		oSection2:Cell("LOTECTL2"):Enable()
		oSection2:Cell("NUMLOTE2"):Enable()
		If !__lPyme
			oSection2:Cell("NUMSERI2"):Enable()
		EndIf
	Else
		If !__lPyme	
			oSection1:Cell("LOCALIZ"):Enable()
		EndIf
		oSection1:Cell("LOTECTL"):Enable()
		oSection1:Cell("NUMLOTE"):Enable()
		If !__lPyme	
			oSection1:Cell("NUMSERI"):Enable()
		EndIf
	EndIf
EndIf

If !__lPyme .And. nOrdem == 5
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordem por ENDERECO                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SetMeter(SBE->(LastRec()))
	oSection2:Init()

	Do While !oReport:Cancel() .And. !Eof()
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()

		Do While !oReport:Cancel() .And. !(cAliasSBF)->(Eof()) .And. ;
			xFilial('SBF')+(cAliasQRY)->BE_LOCAL+(cAliasQRY)->BE_LOCALIZ == ;
			(cAliasSBF)->BF_FILIAL+(cAliasSBF)->BF_LOCAL+(cAliasSBF)->BF_LOCALIZ
			
			lCLocal	  := Localiza((cAliasSB1)->B1_COD)

			If mv_par15 == 2
				If lCLocal
					dDataInv := (cAliasSBF)->BF_DINVENT			
				ElseIf lWmsNew
					dDataInv := CTOD('01/01/01')
				Else
					dDataInv := (cAliasSB2)->B2_DTINV
				Endif
				
				If Empty((cAliasSB2)->B2_DINVFIM) .Or. (cAliasSB2)->B2_DINVFIM < mv_par11 .Or. dDataInv > mv_par12
					(cAliasSBF)->(dbSkip())
					Loop
				EndIf			    
			Else
				If lCLocal
					dDataInv := (cAliasSBF)->BF_DINVENT			
				ElseIf lWmsNew
					dDataInv := CTOD('01/01/01')
				Else
					dDataInv := (cAliasSB2)->B2_DTINV
				Endif
				
				If (!Empty(dDataInv) .And. ;
					(((dDataInv + (cAliasSB1)->B1_PERINV) < mv_par11) .Or. ;
					((dDataInv + (cAliasSB1)->B1_PERINV) > mv_par12)))
					(cAliasSBF)->(dbSkip())
					Loop
				EndIf
			EndIf

			lRastro	  := Rastro((cAliasSB1)->B1_COD)
			lRastroS  := Rastro((cAliasSB1)->B1_COD, 'S')
			lFirst := .T.

			If lCLocal .And. lImpLote
			    If lFirst
					oSection2:Cell("B1COD"):Show()
					oSection2:Cell("B1TIPO"):Show()
					oSection2:Cell("B1GRUPO"):Show()
					oSection2:Cell("B1DESC"):Show()
					oSection2:Cell("B1UM"):Show()
					oSection2:Cell("B2LOCAL"):Show()

					oSection2:Cell("NNRDESCRI"):Show()
					lFirst := .F.
			    Else
					oSection2:Cell("B1COD"):Hide()
					oSection2:Cell("B1TIPO"):Hide()
					oSection2:Cell("B1GRUPO"):Hide()
					oSection2:Cell("B1DESC"):Hide()
					oSection2:Cell("B1UM"):Hide()
					oSection2:Cell("B2LOCAL"):Hide()

					oSection2:Cell("NNRDESCRI"):Hide()
			    EndIf   
				oSection2:Cell("LOCALIZ2"):SetValue((cAliasSBF)->BF_LOCALIZ)
				oSection2:Cell("LOTECTL2"):SetValue((cAliasSBF)->BF_LOTECTL)
				oSection2:Cell("NUMLOTE2"):SetValue((cAliasSBF)->BF_NUMLOTE)
				oSection2:Cell("NUMSERI2"):SetValue((cAliasSBF)->BF_NUMSERI)
			   	oSection2:PrintLine()	
			ElseIf lRastro .And. lImpLote .And.;
				SB8->(dbSeek(xFilial('SB8') + (cAliasSB1)->B1_COD + (cAliasSBF)->BF_LOCAL, .F.))
				cCondicao1 := 'SB8->B8_FILIAL + SB8->B8_PRODUTO + SB8->B8_LOCAL + SB8->B8_LOTECTL ' + If(lRastroS,'+ SB8->B8_NUMLOTE','')
				Do While !oReport:Cancel() .And. !SB8->(Eof()) .And. ;
					xFilial('SB8') + (cAliasSB1)->B1_COD + (cAliasSBF)->BF_LOCAL + SB8->B8_LOTECTL + If(lRastroS,SB8->B8_NUMLOTE,'') == &(cCondicao1)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se o saldo esta' zerado (mv_par14 == 2 (Nao))       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par14 == 2 .And. SB8->B8_SALDO == 0
						SB8->(dbSkip())
						Loop
					EndIf									    
				    If lFirst
						oSection2:Cell("B1COD"):Show()
						oSection2:Cell("B1TIPO"):Show()
						oSection2:Cell("B1GRUPO"):Show()
						oSection2:Cell("B1DESC"):Show()
						oSection2:Cell("B1UM"):Show()
						oSection2:Cell("B2LOCAL"):Show()

						oSection2:Cell("NNRDESCRI"):Show()
						lFirst := .F.
				    Else
						oSection2:Cell("B1COD"):Hide()
						oSection2:Cell("B1TIPO"):Hide()
						oSection2:Cell("B1GRUPO"):Hide()
						oSection2:Cell("B1DESC"):Hide()
						oSection2:Cell("B1UM"):Hide()
						oSection2:Cell("B2LOCAL"):Hide()

						oSection2:Cell("NNRDESCRI"):Hide()
				    EndIf   
					oSection2:Cell("LOCALIZ2"):SetValue("")
					oSection2:Cell("LOTECTL2"):SetValue(SB8->B8_LOTECTL)
					oSection2:Cell("NUMLOTE2"):SetValue(If(lRastroS,SB8->B8_NUMLOTE,""))
					oSection2:Cell("NUMSERI2"):SetValue("")
				   	oSection2:PrintLine()
					SB8->(dbSkip())
				EndDo
			Else
				oSection2:Cell("B1COD"):Show()
				oSection2:Cell("B1TIPO"):Show()
				oSection2:Cell("B1GRUPO"):Show()
				oSection2:Cell("B1DESC"):Show()
				oSection2:Cell("B1UM"):Show()
				oSection2:Cell("B2LOCAL"):Show()

				oSection2:Cell("NNRDESCRI"):Show()
				oSection2:Cell("LOCALIZ2"):SetValue("")
				oSection2:Cell("LOTECTL2"):SetValue("")
				oSection2:Cell("NUMLOTE2"):SetValue("")
				oSection2:Cell("NUMSERI2"):SetValue("")
			   	oSection2:PrintLine()	
			EndIf
			(cAliasSBF)->(dbSkip())
		EndDo
		
	EndDo
	oSection2:Finish()

Else

	oReport:SetMeter(SB1->(LastRec()))
	oSection1:Init()

	Do While !oReport:Cancel() .And. !Eof()
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
	
		Do While  !oReport:Cancel() .And. !(cAliasSB2)->(Eof()) .And. ;
			(cAliasSB2)->B2_FILIAL + (cAliasSB2)->B2_COD == xFilial('SB2') + (cAliasQRY)->B1_COD
			
			If mv_par15 == 2
				If Empty((cAliasSB2)->B2_DINVFIM) .Or. (cAliasSB2)->B2_DINVFIM < mv_par11 .Or. (cAliasSB2)->B2_DTINV > mv_par12
					(cAliasSB2)->(dbSkip())
					Loop
				EndIf			    
			Else
				If (!Empty((cAliasSB2)->B2_DINVENT) .And. ;
					((((cAliasSB2)->B2_DINVENT + (cAliasQRY)->B1_PERINV) < mv_par11) .Or. ;
					(((cAliasSB2)->B2_DINVENT + (cAliasQRY)->B1_PERINV) > mv_par12)))
					(cAliasSB2)->(dbSkip())
					Loop
				EndIf
			EndIf
								
			lRastro	  := Rastro((cAliasQRY)->B1_COD)
			lRastroS  := Rastro((cAliasQRY)->B1_COD, 'S')
			lCLocal	  := Localiza((cAliasQRY)->B1_COD)
			lFirst := .T.
			
			If lCLocal .And. lImpLote .And.;
				SBF->(dbSeek(xFilial('SBF') + (cAliasQRY)->B1_COD + (cAliasSB2)->B2_LOCAL, .F.))
				Do While !oReport:Cancel() .And. !SBF->(Eof()) .And. ;
					(xFilial('SBF') + (cAliasQRY)->B1_COD + (cAliasSB2)->B2_LOCAL == SBF->BF_FILIAL + SBF->BF_PRODUTO + SBF->BF_LOCAL)
					If MV_PAR14 == 2 .And. SBF->BF_QUANT == 0
						SBF->(DbSkip())
						Loop
					EndIf
				    If lFirst
						oSection1:Cell("B1_COD"):Show()
						oSection1:Cell("B1_TIPO"):Show()
						oSection1:Cell("B1_GRUPO"):Show()
						oSection1:Cell("B1_DESC"):Show()
						oSection1:Cell("B1_UM"):Show()
						oSection1:Cell("B2_LOCAL"):Show()
					    If !__lPyme
							oSection1:Cell("NNR_DESCRI"):Show()
						EndIf
						lFirst := .F.
				    Else
						oSection1:Cell("B1_COD"):Hide()
						oSection1:Cell("B1_TIPO"):Hide()
						oSection1:Cell("B1_GRUPO"):Hide()
						oSection1:Cell("B1_DESC"):Hide()
						oSection1:Cell("B1_UM"):Hide()
						oSection1:Cell("B2_LOCAL"):Hide()
					    If !__lPyme
							oSection1:Cell("NNR_DESCRI"):Hide()
						EndIf
				    EndIf   
				   	If !__lPyme
					   	oSection1:Cell("LOCALIZ"):SetValue(SBF->BF_LOCALIZ)
					EndIf
					oSection1:Cell("LOTECTL"):SetValue(SBF->BF_LOTECTL)
					oSection1:Cell("NUMLOTE"):SetValue(SBF->BF_NUMLOTE)
					If !__lPyme
						oSection1:Cell("NUMSERI"):SetValue(SBF->BF_NUMSERI)
					EndIf
				   	oSection1:PrintLine()	
					SBF->(dbSkip())
				EndDo
			ElseIf lRastro .And. lImpLote .And.;
				SB8->(dbSeek(xFilial('SB8') + (cAliasQRY)->B1_COD + (cAliasSB2)->B2_LOCAL, .F.))
				cLoteAnt   := ""
				cCondicao1 := 'SB8->B8_FILIAL + SB8->B8_PRODUTO + SB8->B8_LOCAL + SB8->B8_LOTECTL ' + If(lRastroS,'+ SB8->B8_NUMLOTE','')
				Do While !oReport:Cancel() .And. !SB8->(Eof()) .And. ;
					xFilial('SB8') + (cAliasQRY)->B1_COD + (cAliasSB2)->B2_LOCAL + SB8->B8_LOTECTL + If(lRastroS,SB8->B8_NUMLOTE,'') == &(cCondicao1)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se o saldo esta' zerado (mv_par14 == 2 (Nao))       ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par14 == 2 .And. SB8->B8_SALDO == 0
						SB8->(dbSkip())
						Loop
					EndIf										
                    If !(cLoteAnt==SB8->B8_LOTECTL) .Or. lRastroS
					    If lFirst
							oSection1:Cell("B1_COD"):Show()
							oSection1:Cell("B1_TIPO"):Show()
							oSection1:Cell("B1_GRUPO"):Show()
							oSection1:Cell("B1_DESC"):Show()
							oSection1:Cell("B1_UM"):Show()
							oSection1:Cell("B2_LOCAL"):Show()
							If !__lPyme
								oSection1:Cell("NNR_DESCRI"):Show()
							EndIf
							lFirst := .F.
					    Else
							oSection1:Cell("B1_COD"):Hide()
							oSection1:Cell("B1_TIPO"):Hide()
							oSection1:Cell("B1_GRUPO"):Hide()
							oSection1:Cell("B1_DESC"):Hide()
							oSection1:Cell("B1_UM"):Hide()
							oSection1:Cell("B2_LOCAL"):Hide()
						    If !__lPyme
								oSection1:Cell("NNR_DESCRI"):Hide()
							EndIf
					    EndIf   
						If !__lPyme 
							oSection1:Cell("LOCALIZ"):SetValue("")
						EndIf					   
						oSection1:Cell("LOTECTL"):SetValue(SB8->B8_LOTECTL)
						oSection1:Cell("NUMLOTE"):SetValue(If(lRastroS,SB8->B8_NUMLOTE,""))
						If !__lPyme
							oSection1:Cell("NUMSERI"):SetValue("")
						EndIf
						cLoteAnt := SB8->B8_LOTECTL
                        
					   	oSection1:PrintLine()	
					Endif	
					SB8->(dbSkip())
				EndDo
			Else
				oSection1:Cell("B1_COD"):Show()
				oSection1:Cell("B1_TIPO"):Show()
				oSection1:Cell("B1_GRUPO"):Show()
				oSection1:Cell("B1_DESC"):Show()
				oSection1:Cell("B1_UM"):Show()
				oSection1:Cell("B2_LOCAL"):Show()

				If !__lPyme 
					oSection1:Cell("NNR_DESCRI"):Show()
					oSection1:Cell("LOCALIZ"):SetValue("")
				EndIf
				oSection1:Cell("LOTECTL"):SetValue("")
				oSection1:Cell("NUMLOTE"):SetValue("")
				If !__lPyme
					oSection1:Cell("NUMSERI"):SetValue("")
				EndIf
				
			   	oSection1:PrintLine()	
			EndIf
			
			(cAliasSB2)->(dbSkip())
		EndDo
		
	EndDo
	oSection1:Finish()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SB1->(dbSetOrder(1))
SB2->(dbSetOrder(1))
SB8->(dbSetOrder(1))
SBF->(dbSetOrder(1))

Return NIL
