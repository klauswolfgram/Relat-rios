/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR840.CH"
#Include "FIVEWIN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR840   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 21/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao Das Operacoes por Produto.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           
*/
User Function MATR840()
Local cExpData    := ""
Local lRetMsg     := .T.
Local oReport

If GetRpoRelease() >= "12.1.2410"
	cExpData := "20260331"
	lRetMsg  := PCPExpSV(cExpData,"MATR840", "PCPR840")
EndIf

If lRetMsg  
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:= ReportDef()
		oReport:PrintDialog()
	Else
		U_MATR840R3()
	EndIf
EndIf

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³21/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR840			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSecProduto // secao 1
Local oSecRoteiro // secao 2 
Local oSecAlternativo // secao 3

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
oReport:= TReport():New("MATR840",OemToAnsi(STR0001),"MTR840", {|oReport| ReportPrint(oReport)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)) //##"Este programa ira imprimir a relacao do Cadastro dos Roteiros de Operacoes."
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas (MTR840)                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                           ³
//³ mv_par01        	// Do Produto   		                   ³
//³ mv_par02        	// Ate o Produto     		               ³
//³ mv_par03        	// Do Roteiro        		               ³
//³ mv_par04        	// Ate o Roteiro     		               ³
//³ mv_par05        	// Lista so Roteiro Padrao     (S)im (N)ao ³
//³ mv_par06        	// Lista Rec. Alternativos     (S)im (N)ao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao das secoes utilizada pelo relatorio                             ³
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ secao 1 (oSecProduto)                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecProduto := TRSection():New(oReport,STR0020,{"SG2","SB1"}) //"Produtos"

TRCell():New(oSecProduto,'G2_PRODUTO'  	,'SG2',/*Titulo*/,/*Picture*/, 25        ,/*lPixel*/, {|| STR0009+(cQryRote)->G2_PRODUTO } )
TRCell():New(oSecProduto,'B1_DESC'	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| STR0010+(cQryRote)->B1_DESC } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ secao 2 (oSecRoteiro)                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSecRoteiro := TRSection():New(oSecProduto,STR0021,{"SG2","SH1"}) //"Operações"
oSecRoteiro:SetHeaderPage()

TRCell():New(oSecRoteiro,'G2_RECURSO'	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_RECURSO } )
TRCell():New(oSecRoteiro,'H1_DESCRI'	,'SH1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->H1_DESCRI } )
TRCell():New(oSecRoteiro,'G2_OPERAC' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_OPERAC   }  )
TRCell():New(oSecRoteiro,'G2_DESCRI'  	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_DESCRI   }  )
TRCell():New(oSecRoteiro,'G2_TPOPER'  	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TPOPER   }  )
TRCell():New(oSecRoteiro,'G2_FERRAM'  	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_FERRAM   }  )
TRCell():New(oSecRoteiro,'G2_LINHAPR' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_LINHAPR  }  )
TRCell():New(oSecRoteiro,'G2_TPLINHA' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TPLINHA  }  )
TRCell():New(oSecRoteiro,'G2_MAOOBRA' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_MAOOBRA  }  )
TRCell():New(oSecRoteiro,'G2_SETUP' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_SETUP    }  )
TRCell():New(oSecRoteiro,'G2_LOTEPAD' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_LOTEPAD  }  )
TRCell():New(oSecRoteiro,'G2_TEMPAD'  	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TEMPAD   }  )
TRCell():New(oSecRoteiro,'G2_TEMPSOB' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TEMPSOB  }  )
TRCell():New(oSecRoteiro,'G2_TPSOBRE' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TPSOBRE  }  )
TRCell():New(oSecRoteiro,'G2_TEMPDES' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TEMPDES  }  )
TRCell():New(oSecRoteiro,'G2_TPDESD' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_TPDESD   }  )
TRCell():New(oSecRoteiro,'G2_DESPROP' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_DESPROP  }  )
TRCell():New(oSecRoteiro,'G2_CTRAB'  	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_CTRAB    }  )
TRCell():New(oSecRoteiro,'G2_FORMSTP' 	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cQryRote)->G2_FORMSTP  }  )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ secao 3 (oSecAlternativo)                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecAlternativo := TRSection():New(oSecRoteiro,STR0022,{"SG2"}) //"Recursos alternativos e secundários"
oSecAlternativo:SetHeaderPage()

TRCell():New(oSecAlternativo,'H2_RECALTE' ,'SH2',/*Titulo*/,/*Picture*/, 24+07     ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT")
TRCell():New(oSecAlternativo,'H1_DESCRI'  ,'SH1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSecAlternativo,'H2_TIPO'  	,'SH2',/*Titulo*/,/*Picture*/, 17        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSecAlternativo,'H3_EFICIEN' ,'SH3',/*Titulo*/, ''        , 18        ,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³21/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR840			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oSecProduto     := oReport:Section(1)
Local oSecRoteiro     := oReport:Section(1):Section(1)
Local oSecAlternativo := oReport:Section(1):Section(1):Section(1)
Local cProdAnt
Local cRotAnt
Local i

Private aAlter:={}
Private aSecun:={}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SG2")
dbSetOrder(1)	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1 (oSecProduto)                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSecProduto:BeginQuery()	

cQryRote := GetNextAlias()
    
    BeginSql Alias cQryRote

SELECT SG2.*,
B1_COD, B1_DESC, B1_OPERPAD, 
H1_CODIGO, H1_DESCRI

FROM %table:SG2% SG2 
INNER JOIN %table:SB1% SB1 ON B1_COD = G2_PRODUTO   
LEFT JOIN %table:SH1% SH1 ON H1_CODIGO = G2_RECURSO AND H1_FILIAL = %xFilial:SH1% AND SH1.%NotDel% 

WHERE G2_FILIAL    = %xFilial:SG2%	 AND
      B1_FILIAL    = %xFilial:SB1%	 AND
      G2_PRODUTO   = B1_COD          AND
  	  G2_PRODUTO  >= %Exp:mv_par01%	 AND 
 	  G2_PRODUTO  <= %Exp:mv_par02%	 AND 
 	  G2_CODIGO   >= %Exp:mv_par03%	 AND 
 	  G2_CODIGO   <= %Exp:mv_par04%	 AND 
 	  SG2.%NotDel%            		 AND
 	  SB1.%NotDel%             	     
 	               	 

ORDER BY %Order:SG2%
		
EndSql 

oSecProduto:EndQuery()

oSecRoteiro:SetParentQuery()
oSecAlternativo:SetParentQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inibindo titulo das celulas da secao 1 (oSecProduto)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecProduto:Cell('G2_PRODUTO'):HideHeader()
oSecProduto:Cell('B1_DESC'):HideHeader()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inibindo titulo das celulas da secao 3 (oSecAlternativo)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecAlternativo:Cell('H2_RECALTE'):HideHeader()
oSecAlternativo:Cell('H1_DESCRI'):HideHeader()
oSecAlternativo:Cell('H2_TIPO'):HideHeader()
oSecAlternativo:Cell('H3_EFICIEN'):HideHeader()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SG2->(LastRec()))

dbSelectArea(cQryRote)
Do While !oReport:Cancel() .And. !(cQryRote)->(Eof())
    oSecAlternativo:Init()
    oSecRoteiro:Init()
    oSecProduto:Init()
    cRotAnt  := ""
    cProdAnt := (cQryRote)->G2_FILIAL+(cQryRote)->G2_PRODUTO
	If mv_par05 == 1 .And. !(IIF(cQryRote<>"SG2",(cQryRote)->B1_OPERPAD,SB1->B1_OPERPAD) == (cQryRote)->G2_CODIGO)
		dbSelectArea(cQryRote)
		dbSkip()
		Loop
	EndIf
	oSecProduto:PrintLine() // Impressao da Secao 1
	Do While (cQryRote)->G2_FILIAL+(cQryRote)->G2_PRODUTO = cProdAnt 
		If mv_par05 == 1 .And. !(IIF(cQryRote<>"SG2",(cQryRote)->B1_OPERPAD,SB1->B1_OPERPAD) == (cQryRote)->G2_CODIGO)
			dbSelectArea(cQryRote)
			dbSkip()
			Loop
		EndIf
		IF (cQryRote)->G2_CODIGO <> cRotAnt
			oReport:SkipLine()
			oReport:PrintText(STR0011+(cQryRote)->G2_CODIGO+" "+IIF((cQryRote)->G2_CODIGO== IIF(cQryRote<>"SG2",(cQryRote)->B1_OPERPAD,SB1->B1_OPERPAD),STR0012,""))//"Roteiro : "###"(Roteiro Padrao)"
		EndIF
		oSecRoteiro:PrintLine() // Impressao da Secao 2
		oReport:IncMeter()
		cRotAnt := (cQryRote)->G2_CODIGO
		IF mv_par06 == 1
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Monta arrays com Recursos Alternativos / Secundarios.        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			R840Alter(cQryRote,.F.)
			If !Empty(aAlter) .Or. !Empty(aSecun)
				For i:=1 to Len(aAlter)
					oSecAlternativo:Cell('H2_RECALTE'):SetValue(STR0019+aAlter[i][1]) //"Recursos: "
					dbSelectarea("SH1")
					dbSeek(xFilial("SH1")+aAlter[i][1])
					oSecAlternativo:Cell('H1_DESCRI'):SetValue(SH1->H1_DESCRI)
					oSecAlternativo:Cell('H2_TIPO'):SetValue(STR0014+STR0016) //"Tipo: "##"Alternativo"
					oSecAlternativo:Cell('H3_EFICIEN'):SetValue(STR0015+STRZERO(aAlter[i][2],3,0)+ "%") //"Eficiencia: "
					oSecAlternativo:PrintLine() // Impressao da Secao 3
				Next i
				For i:=1 to Len(aSecun)
					oSecAlternativo:Cell('H2_RECALTE'):SetValue(STR0019+aSecun[i][1]) //"Recursos: "
					dbSelectarea("SH1")
					dbSeek(xFilial("SH1")+aSecun[i][1])
					oSecAlternativo:Cell('H1_DESCRI'):SetValue(SH1->H1_DESCRI)
					oSecAlternativo:Cell('H2_TIPO'):SetValue(STR0014+STR0017) //"Tipo: "	##"Secundario"
					oSecAlternativo:Cell('H3_EFICIEN'):SetValue(STR0015+STRZERO(aSecun[i][2],3,0)+ "%") //"Eficiencia: "
					oSecAlternativo:PrintLine() // Impressao da Secao 3
				Next i
				oReport:SkipLine()
			EndIF
 		EndIF
		dbSelectArea(cQryRote)
		dbSkip()
	EndDo
	IF !(cQryRote)->(Eof()) // Nao Imprime linha da quebra se for ultimo registro
		oReport:SkipLine()
		oReport:ThinLine()
	EndIF
	oSecAlternativo:Finish()
	oSecRoteiro:Finish()
	oSecProduto:Finish()
EndDo

oSecAlternativo:Finish()
oSecRoteiro:Finish()
oSecProduto:Finish()
(cQryRote)->(DbCloseArea())

Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR840  ³ Autor ³ Paulo Boschetti       ³ Data ³ 11.08.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao Das Operacoes por Produto                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MATR840(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo     ³11/09/98³16474A³ Acerto na filtragem dos roteiros         ³±±
±±³Cesar       ³31/03/99³XXXXXX³Manutencao na SetPrint()                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR840R3()
LOCAL titulo := STR0001	//"Relacao das Operacoes por Produto"
LOCAL cString:="SG2"
LOCAL wnrel:="MATR840"
LOCAL cDesc1 :=STR0002	//"Este programa ira imprimir a relacao do Cadastro"
LOCAL cDesc2 :=STR0003	//"dos Roteiros de Operacoes."
LOCAL cDesc3 :=""
LOCAL tamanho:="G"
PRIVATE aReturn  := {STR0004,1,STR0005, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
PRIVATE cPerg    :="MTR840"
PRIVATE nLastKey := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTR840",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                           ³
//³ mv_par01        	// Do Produto   		                   ³
//³ mv_par02        	// Ate o Produto     		               ³
//³ mv_par03        	// Do Roteiro        		               ³
//³ mv_par04        	// Ate o Roteiro     		               ³
//³ mv_par05        	// Lista so Roteiro Padrao     (S)im (N)ao ³
//³ mv_par06        	// Lista Rec. Alternativos     (S)im (N)ao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey = 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| R840Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R840Imp  ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR840			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R840Imp(lEnd,wnRel,titulo,tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt
LOCAL CbCont,cabec1,cabec2
LOCAL nomeprog:="MATR840"
LOCAL cProdAnt := ""
LOCAL lFirst  := .F. // Variavel que indica se e' o primeiro produto
LOCAL lProd   := .F. // Variavel que indica se imprime mensagem do Produto
LOCAL lOk:=.F.   		// Variavel que indica se Registro Satisfaz Condicoes
LOCAL lRoteiro:=.F.  // Variavel que indica se imprime mensagem do Roteiro
LOCAL lAlter:=.F.    // Variavel que indica se imprime Rec. Alternativos
LOCAL I := 1
LOCAL cIndSG2:="",cChave:="",cFilter:=""

PRIVATE aAlter:={}
PRIVATE aSecun:={}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cabec1 :=STR0006	// "RECURSO DESCRICAO DO RECURSO           OPERACAO   DESCRICAO DA OPERACAO            TIPO  FERRAMENTA LINHA DE  TIPO DE    MAO DE     SETUP    LOTE     TEMPO    TEMPO    TIPO    TEMPO     TIPO    DESDOBR    CENTRO  FORMULA"
cabec2 :=STR0007	// "                                                                                   OPER             PRODUCAO   LINHA      OBRA              PADRAO    PADRAO   SOBREP.  SOBREP. DESDOBRA DESDOBRA  PROPOR   TRABALHO  SETUP"
// 				       123456  123456789012345678901234567890    12      12345678901234567890              1      123456    123        1      1234    12345  123456  12345   12345     1      12345       1         1      123456   12345678  123
//           	  		   	     1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21
//				          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

dbSelectarea("SG2")
dbSetOrder(1)
cChave:=Indexkey()
cIndSG2:=CriaTrab(NIL,.F.)
cFilter:='G2_FILIAL=="'+xFilial("SG2")+'".And.G2_PRODUTO>="'+mv_par01+'".And.'
cFilter+='G2_PRODUTO<="'+mv_par02+'".And.G2_CODIGO>="'+mv_par03+'".And.'
cFilter+='G2_CODIGO<="'+mv_par04+'"'
IndRegua("SG2",cIndSG2,cChave,,cFilter,STR0018)	//"Criando Indices ...."

SetRegua(LastRec())
While !Eof()
	If lEnd
		@ Prow()+1,001 PSay STR0008	//"CANCELADO PELO OPERADOR"
		dbSelectArea("SG2")
		RetIndex("SG2")
		Set Filter To
		dbSetOrder(1)
		Ferase(cIndSG2+OrdBagExt())
		Exit
	EndIF
	
	dbSelectarea("SB1")
	If dbSeek(cFilial+SG2->G2_PRODUTO) .And. mv_par05 == 1 .And. !(B1_OPERPAD == SG2->G2_CODIGO)
		dbSelectArea("SG2")
		dbSkip()
		Loop
	EndIf
	dbSelectArea("SG2")
	
	lProd:=.T.
	cProdAnt := cFilial+G2_PRODUTO
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quebra por Produto.											 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !Eof() .And. G2_FILIAL+G2_PRODUTO = cProdAnt
		
		IncRegua()
		
		lRoteiro:=.T.
		cRoteiro := G2_CODIGO
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Quebra por Roteiro.											 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		While !Eof() .And. G2_FILIAL+G2_PRODUTO+G2_CODIGO = cProdAnt+cRoteiro
			
			dbSelectarea("SB1")
			If dbSeek(cFilial+SG2->G2_PRODUTO) .And. mv_par05 == 1 .And. !(B1_OPERPAD == SG2->G2_CODIGO)
				dbSelectArea("SG2")
				dbSkip()
				Loop
			EndIf
			dbSelectArea("SG2")
			
			lOk:=.T.
			
			IF li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
			EndIF
			
			If lProd .And. lOk
				If lFirst
					@Li,00 PSay __PrtThinLine()
					Li+=2
				EndIf
				@Li,00 PSay STR0009+G2_PRODUTO	//"Produto : "
				@Li,29 PSay STR0010+Substr(SB1->B1_DESC,1,30)	//"Denominacao : "
				Li+=2
				lProd := .F.
				lFirst:=.T.
			Endif
			
			If lRoteiro .And. lOk
				@Li,00 PSay STR0011+cRoteiro+" "+IIF(cRoteiro==SB1->B1_OPERPAD,STR0012,"")	//"Roteiro : "###"(Roteiro Padrao)"
				li++
				aAlter:={}
				aSecun:={}
				lRoteiro  :=.F.
			EndIf
			
			IF Li > 58
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
			EndIF
			
			If !Empty(aAlter) .Or. !Empty(aSecun)
				Li+=2
			Else
				Li++
			EndIf
			
			@Li,000 PSay G2_RECURSO     Picture PesqPict("SG2","G2_RECURSO",7)
			dbSelectarea("SH1")
			dbSeek(cFilial+SG2->G2_RECURSO)
			dbSelectarea("SG2")

			@ Li,008 PSay Pad(Transform(SH1->H1_DESCRI, PesqPict("SH1","H1_DESCRI"  )),30)
			@ Li,041 PSay Pad(Transform(G2_OPERAC     , PesqPict("SG2","G2_OPERAC"  )), 4)
			@ Li,050 PSay Pad(Transform(G2_DESCRI     , PesqPict("SG2","G2_DESCRI"  )),30)
			@ Li,084 PSay Pad(Transform(G2_TPOPER     , PesqPict("SG2","G2_TPOPER"  )), 2)
			@ Li,091 PSay Pad(Transform(G2_FERRAM     , PesqPict("SG2","G2_FERRAM"  )), 8)
			@ Li,102 PSay Pad(Transform(G2_LINHAPR    , PesqPict("SG2","G2_LINHAPR" )), 5)
			@ Li,113 PSay Pad(Transform(G2_TPLINHA    , PesqPict("SG2","G2_TPLINHA" )), 1)
			@ Li,120 PSay     Transform(G2_MAOOBRA    , PesqPictQt("G2_MAOOBRA"       , 8))
			@ Li,130 PSay     Transform(G2_SETUP      , PesqPictQt("G2_SETUP"         , 7))
			@ Li,139 PSay     Transform(G2_LOTEPAD    , PesqPictQt("G2_LOTEPAD"       , 7))
			@ Li,150 PSay     Transform(G2_TEMPAD     , PesqPictQt("G2_TEMPAD"        ,10))
			@ Li,161 PSay     Transform(G2_TEMPSOB    , PesqPictQt("G2_TEMPSOB"       , 5))
			@ Li,171 PSay Pad(Transform(G2_TPSOBRE    , PesqPict("SG2","G2_TPSOBRE" )), 2)
			@ Li,178 PSay     Transform(G2_TEMPDES    , PesqPictQt("G2_TEMPDES"       , 5))
			@ Li,189 PSay Pad(Transform(G2_TPDESD     , PesqPict("SG2","G2_TPDESD"  )), 2)
			@ Li,199 PSay Pad(Transform(G2_DESPROP    , PesqPict("SG2","G2_DESPROP" )), 1)
			@ Li,205 PSay Pad(Transform(G2_CTRAB      , PesqPict("SG2","G2_CTRAB"   )), 8)
			@ Li,215 PSay Pad(Transform(G2_FORMSTP    , PesqPict("SG2","G2_FORMSTP" )), 3)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se Lista Recursos Alternativos / Secundarios.       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par06 = 1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta arrays com Recursos Alternativos / Secundarios.        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				R840Alter()
				If !Empty(aAlter) .Or. !Empty(aSecun)
					Li++
					IF li > 58
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
					EndIF
					@Li,08 PSay STR0013	//"Recursos: "
					@Li,60 PSay STR0014	//"Tipo: "
					@Li,81 PSay STR0015	//"Eficiencia: "
				EndIf
				If !Empty(aAlter)
					IF li > 58
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
					EndIF
					For i:=1 to Len(aAlter)
						lAlter:=.T.
						@Li ,18 PSay aAlter[i][1]
						dbSelectarea("SH1")
						dbSeek(cFilial+aAlter[i][1])
						dbSelectarea("SG2")
						@Li,25 PSay SH1->H1_DESCRI  Picture PesqPict("SH1","H1_DESCRI",30)
						@Li,66 PSay STR0016	//"Alternativo"
						@Li,93 PSay STRZERO(aAlter[i][2],3,0)+ "%"
						If i != Len(aAlter)
							Li++
						EndIf
					Next i
				EndIf
				If !Empty(aSecun)
					If lAlter
						Li++
					EndIf
					IF li > 58
						cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
					EndIF
					For i:=1 to Len(aSecun)
						@Li ,18 PSay aSecun[i][1]
						dbSelectarea("SH1")
						dbSeek(cFilial+aSecun[i][1])
						dbSelectarea("SG2")
						@Li,25 PSay SH1->H1_DESCRI  Picture PesqPict("SH1","H1_DESCRI",30)
						@Li,66 PSay STR0017	//"Secundario"
						@Li,93 PSay STRZERO(aSecun[i][2],3,0)+ "%"
						If i != Len(aSecun)
							Li++
						EndIf
					Next i
				EndIf
			EndIf
			dbSkip()
		EndDo
		If !lRoteiro
			Li+=2
		EndIf
	EndDo
EndDo

IF  LI != 80
	roda(cbcont,cbtxt,tamanho)
EndIF

dbSelectArea("SG2")
RetIndex("SG2")
Set Filter To
dbSetOrder(1)
Ferase(cIndSG2+OrdBagExt())

If aReturn[5] = 1
	Set Printer To
	dbCommitall()
	ourspool(wnrel)
Endif

MS_FLUSH()
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R840Alter ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 05/09/95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Montagem de Arrays com maquinas alternativas e secundarias ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATA690                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R840Alter(cAliasSG2,lAjustSB1)
Local cAlias := Alias(),nAlt,nSec
Default cAliasSG2 := "SG2"
Default lAjustSB1 := .T.

aAlter:={}
aSecun:={}

dbSelectArea("SH2")
dbSetOrder(3)
dbSeek(xFilial("SH2")+(cAliasSG2)->G2_RECURSO)
While !Eof() .And. xFilial("SH2")+(cAliasSG2)->G2_RECURSO == H2_FILIAL+H2_RECPRIN
	If Ascan( aAlter ,{|x| x[1]==H2_RECALTE}) == 0 .And. Ascan( aSecun ,{|x| x[1]==H2_RECALTE}) == 0
		If H2_TIPO == "A"
			Aadd( aAlter , {H2_RECALTE ,100})
		ElseIf H2_TIPO == "S"
			Aadd( aSecun , {H2_RECALTE ,100})
		EndIf
	EndIf
	dbSkip()
End
dbSetOrder(1)

IF lAjustSB1
	dbSelectArea("SB1")
	If Empty(B1_OPERPAD)
		dbSelectArea("SG2")
		dbSeek(xFilial("SB1")+SB1->B1_COD+"01")
		If Found()
			RecLock("SB1")
			Replace B1_OPERPAD With "01"
			MsUnLock()
		Else
			Help(" ",1,"A690OPERPA",,SB1->B1_COD,02,16)
			dbSelectArea(cAlias)
			Return NIL
		EndIf
	EndIf
EndIF

dbSelectArea("SH3")
dbSeek(xFilial("SH3")+(cAliasSG2)->G2_PRODUTO+(cAliasSG2)->G2_CODIGO+(cAliasSG2)->G2_OPERAC)
While !Eof() .And. xFilial("SH3")+(cAliasSG2)->G2_PRODUTO+(cAliasSG2)->G2_CODIGO+(cAliasSG2)->G2_OPERAC == H3_FILIAL+H3_PRODUTO+H3_CODIGO+H3_OPERAC
	If H3_TIPO == "F"
		dbSkip()
		Loop
	EndIf
	nAlt:=Ascan( aAlter ,{|x| x[1]==H3_RECALTE})
	nSec:=Ascan( aSecun ,{|x| x[1]==H3_RECALTE})
	If nAlt = 0 .And. nSec = 0
		If H3_TIPO == "A"
			Aadd( aAlter , {H3_RECALTE ,H3_EFICIEN})
		ElseIf H3_TIPO == "S"
			Aadd( aSecun , {H3_RECALTE ,H3_EFICIEN})
		EndIf
	ElseIf nAlt != 0 .And. nSec != 0
		aAlter[nAlt][2]:=H3_EFICIEN
		aSecun[nSec][2]:=H3_EFICIEN
	ElseIf nAlt != 0 .And. nSec = 0
		aAlter[nAlt][2]:=H3_EFICIEN
	ElseIf nAlt = 0 .And. nSec != 0
		aSecun[nSec][2]:=H3_EFICIEN
	EndIf
	dbSkip()
End

dbSelectArea(cAlias)
Return NIL
