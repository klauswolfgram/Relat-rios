/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "FATR050.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FATR050  ³ Autor ³ Marco Bianchi         ³ Data ³25/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Relatorio de metas de vendas x realizado                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATR050()

Local oReport

If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	U_FATR050R3()
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³25/05/2006³±±
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
/*/
Static Function ReportDef()

Local oReport
Local cAliasQry := GetNextAlias() 
Local nTamProd  := TamSX3("CT_PRODUTO")[1] 

Private nValReal := 0					// Valor Real
Private nQtdReal := 0					// Quantidade Real
Private nValMeta := 0					// Valor da Meta
Private aVendas  := { 0, 0, 0 } 		
Private aDevol   := { 0, 0, 0 }   

	
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
oReport := TReport():New("FATR050",STR0007,"FTR050P9R1", {|oReport| ReportPrint(oReport,cAliasQry)},STR0008+ " " + STR0009)
oReport:SetLandscape() 
oReport:SetTotalInLine(.F.)

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
oMetas := TRSection():New(oReport,STR0020,{"SCT"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oMetas:SetTotalInLine(.F.)

TRCell():New(oMetas,"CT_DOC"    ,"SCT",STR0019   ,/*Picture*/			  			,TamSX3("CT_DOC")        [1],/*lPixel*/,/*{|| code-block de impressao }*/)				 			// Codigo da Meta
TRCell():New(oMetas,"CT_SEQUEN" ,"SCT",STR0012   ,/*Picture*/			  			,TamSX3("CT_SEQUEN")     [1],/*lPixel*/,/*{|| code-block de impressao }*/)							// Sequencia da Meta
TRCell():New(oMetas,"CT_DESCRI" ,"SCT",STR0011   ,/*Picture*/			  			,IIf(nTamProd==30,21, TamSX3("CT_DESCRI")[1]),/*lPixel*/,/*{|| code-block de impressao }*/)	 			// Descricao da Meta
TRCell():New(oMetas,"CT_DATA"   ,"SCT",/*Titulo*/,/*Picture*/			  			,10					 ,/*lPixel*/,/*{|| code-block de impressao }*/)			  				// Data da Meta
TRCell():New(oMetas,"CT_VEND"   ,"SCT",/*Titulo*/,/*Picture*/			  			,TamSX3("CT_VEND")    	    [1],/*lPixel*/,/*{|| code-block de impressao }*/)			  				// Codigo do Vendedor
TRCell():New(oMetas,"CT_REGIAO" ,"SCT",/*Titulo*/,/*Picture*/			  			,TamSX3("CT_REGIAO")	    [1],/*lPixel*/,/*{|| code-block de impressao }*/)			  				// Regiao
TRCell():New(oMetas,"CT_PRODUTO","SCT",/*Titulo*/,/*Picture*/			  			,TamSX3("CT_PRODUTO") 	    [1],/*lPixel*/,/*{|| code-block de impressao }*/)			  				// Codigo do Produto
TRCell():New(oMetas,"CT_GRUPO"  ,"SCT",/*Titulo*/,/*Picture*/			  			,TamSX3("CT_GRUPO")	    [1],/*lPixel*/,/*{|| code-block de impressao }*/)							// Grupo do Produto
TRCell():New(oMetas,"CT_TIPO"   ,"SCT",STR0013   ,/*Picture*/			  			,TamSX3("CT_TIPO")	    [1],/*lPixel*/,/*{|| code-block de impressao }*/)							// Tipo do Produto
TRCell():New(oMetas,"NVALMETA"  ,"   ",STR0010   ,PesqPict("SCT","CT_VALOR")				,TamSX3("CT_VALOR")	    [1],/*lPixel*/,{|| xMoeda( CT_VALOR, CT_MOEDA, MV_PAR10, CT_DATA ) },,,"RIGHT")	// Valor da Meta
TRCell():New(oMetas,"CT_QUANT"  ,"SCT",STR0018   ,PesqPict("SCT","CT_QUANT")	 			,TamSX3("CT_QUANT")	    [1],/*lPixel*/,/*{|| code-block de impressao }*/,,,"RIGHT")					// Quantidade da Meta
TRCell():New(oMetas,"NVALREAL"  ,"   ",STR0014   ,PesqPict("SCT","CT_VALOR")				,TamSX3("CT_VALOR")	    [1],/*lPixel*/,{|| nValReal },,,"RIGHT")			        				// Valor Real
TRCell():New(oMetas,"NQTDREAL"  ,"   ",STR0015   ,PesqPict("SCT","CT_QUANT")				,TamSX3("CT_QUANT")	    [1],/*lPixel*/,{|| nQtdReal },,,"RIGHT")								// Quantidade Real
TRCell():New(oMetas,"nVRMM"     ,"   ",STR0016   ,PesqPict("SCT","CT_VALOR")				,TamSX3("CT_VALOR")	    [1],/*lPixel*/,{|| nValReal - nValMeta },,,"RIGHT")						// Valor Real - Meta
TRCell():New(oMetas,"nQRMM"     ,"   ",STR0017   ,PesqPict("SCT","CT_QUANT")				,TamSX3("CT_QUANT")	    [1],/*lPixel*/,{|| nQtdReal - CT_QUANT },,,"RIGHT")			 			// Quantidade Real - Meta

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
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasQry)

Local cEstoq 		:= If( (mv_par12 == 1),"'S'",If( (mv_par12 == 2),"'N'","'S','N'" ) )
Local cDupli 		:= If( (mv_par11 == 1),"'S'",If( (mv_par11 == 2),"'N'","'S','N'" ) )
Local lExtEstNeg	:= GetMv("MV_CRMESTN",.F.,.F.) 
Local cCodVend		:= ""
Local aNvlEstrut	:= {}
Local aNlvEstFmt	:= {}
Local nNivel		:= 1
Local cIDSA3		:= ""
Local cOrder		:= ""		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()	
		
	If nModulo == 73 .AND. lExtEstNeg 
		
		cCodVend	:= CRMXRetVend()
		aNvlEstrut	:= CRMXNvlEst(cCodVend)
		aNlvEstFmt	:= CRMXFmtNvl(aNvlEstrut[1])
		For nNivel := 1 To Len(aNlvEstFmt)
			cIDSA3 += "A3_NVLSTR LIKE '" + aNlvEstFmt[nNivel] + "%' "
			If nNivel < Len(aNlvEstFmt)
				cIDSA3 += " OR "
			EndIf
		Next
		cIDSA3 := "%" + cIDSA3 + "%"
		
		BeginSql Alias cAliasQry
		    SELECT SCT.* 
				FROM %table:SCT% SCT
				INNER JOIN %table:SA3% SA3
				ON SA3.A3_FILIAL = %xFilial:SA3% AND 
				SA3.A3_COD = SCT.CT_VEND  AND
				SA3.%NotDel%  
				WHERE SCT.CT_FILIAL = %xFilial:SCT% AND  
				SCT.CT_REGIAO >= %Exp:MV_PAR03% AND 
				SCT.CT_REGIAO <= %Exp:MV_PAR04% AND 		
				SCT.CT_DATA   >= %Exp:DToS(MV_PAR08)% AND 
				SCT.CT_DATA   <= %Exp:DToS(MV_PAR09)% AND
				(%Exp:cIDSA3% OR SA3.A3_COD = %Exp:cCodVend% ) AND SCT.%notdel% 
		EndSql
 
	Else
		cOrder := "%" + SCT->(IndexKey()) + "%"
		BeginSql Alias cAliasQry
		    SELECT SCT.* 
				FROM %table:SCT% SCT
				WHERE SCT.CT_FILIAL = %xFilial:SCT% AND  
				SCT.CT_REGIAO >= %Exp:MV_PAR03% AND 
				SCT.CT_REGIAO <= %Exp:MV_PAR04% AND 		
				SCT.CT_DATA   >= %Exp:DToS(MV_PAR08)% AND 
				SCT.CT_DATA   <= %Exp:DToS(MV_PAR09)% AND
				SCT.%notdel% 
				ORDER BY %Exp:SqlOrder(cOrder)%
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
oReport:Section(1):EndQuery({MV_PAR05,MV_PAR06})
	
	
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SCT->(LastRec()))


dbSelectArea(cAliasQry)
dbGoTop()
oReport:Section(1):Init()
While !oReport:Cancel() .And. !(cAliasQry)->(Eof())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chama a funcao de calculo das vendas                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aVendas := FtNfVendas(4,(cAliasQry)->CT_VEND,MV_PAR01,MV_PAR02,(cAliasQry)->CT_REGIAO,(cAliasQry)->CT_TIPO,(cAliasQry)->CT_GRUPO,(cAliasQry)->CT_PRODUTO,MV_PAR10,"","","",,cDupli,cEstoq, (cAliasQry)->CT_CATEGO)
	
	aDevol := { 0,0,0 }
	If MV_PAR07 == 1  	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chama a funcao de calculo das devolucoes de venda            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aDevol := FtNfDevol(4,(cAliasQry)->CT_VEND,MV_PAR01,MV_PAR02,(cAliasQry)->CT_REGIAO,(cAliasQry)->CT_TIPO,(cAliasQry)->CT_GRUPO,(cAliasQry)->CT_PRODUTO,MV_PAR10,"","",,cDupli,cEstoq, (cAliasQry)->CT_CATEGO)
	EndIf 			
 	nValReal := aVendas[ 1 ] - aDevol[ 1 ]
 	nQtdReal := aVendas[ 2 ] - aDevol[ 2 ]
	nValMeta := xMoeda( ( cAliasQry )->CT_VALOR, ( cAliasQry )->CT_MOEDA, MV_PAR10, ( cAliasQry )->CT_DATA ) 

	oReport:Section(1):PrintLine()
	
	
	dbSelectArea(cAliasQry)
	dbSkip()
	oReport:IncMeter()
EndDo
oReport:Section(1):Finish()
oReport:Section(1):SetPageBreak(.T.) 

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FATR050R3³ Autor ³ Sergio Silveira       ³ Data ³09/09/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Relatorio de metas de vendas x realizado                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATR050R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Vari veis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := OemToAnsi(STR0001)  //"Relacao de metas de vendas x vendas realizadas"
Local cDesc1  := OemToAnsi(STR0002) //"Este relatorio ira imprimir a relacao das metas de vendas"
Local cDesc2  := OemToAnsi(STR0003) //"em relacao as vendas realizadas conforme parametros"
Local cDesc3  := OemToAnsi("") 

Local cString    := "SCT"  // Alias utilizado na Filtragem
Local lDic       := .F.    // Habilita/Desabilita Dicionario
Local lComp      := .T.    // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro    := .T.    // Habilita/Desabilita o Filtro
Local wnrel      := "FATR050"  // Nome do Arquivo utilizado no Spool
Local nomeprog   := "FATR050"  // nome do programa
Local aOrderKey  := {} 

Private Tamanho  := "G"  // P/M/G
Private Limite   := 220  // 80/132/220
Private cPerg    := "FTR050"  // Pergunta do Relatorio
Private aReturn  := { STR0004, 1, STR0005, 1, 2, 1, "",1 }   //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd     := .F.// Controle de cancelamento do relatorio
Private m_pag    := 1  // Contador de Paginas
Private nLastKey := 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
Endif

RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Sergio Silveira       ³ Data ³09/09/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Controle de Fluxo do Relatorio.                            ³±±
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
*/

Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

Local aRegAD6     := {} 
Local aVendas     := { 0, 0, 0 } 
Local aDevol      := { 0, 0, 0 } 

Local bCondFil    := { || .T. }    
Local bWhile      := { || .T. } 
Local bBlock      := { || .T. } 

Local cCabec1     := STR0006 //"NUMERO  SEQ  DESCRICAO                       DATA        VENDEDOR  REGIAO  PRODUTO          GRUPO  TIPO          VALOR/META      QUANT/META          VALOR/REAL      QUANT/REAL     DIFERENCA VALOR   DIFERENCA QTD"
Local cCabec2     := ""

Local cTit1       := ""        // Titulo da 1.o Quebra recebe o valor de um campo
Local cTit2       := ""        // Titulo da 2.o Quebra recebe o valor de um campo
Local cTitulo1    := ""        // Titulo descritivo em formato texto
Local cTitulo2    := ""        // Titulo descritivo em formato texto
Local cbCont      := 0         // Numero de Registros Processados
Local cbText      := ""        // Mensagem do Rodape
Local cAliasSCT   := ""
Local cIndSCT     := ""
Local cQuery      := ""
Local cCond       := ""
Local cKey        := ""
Local cBlockFil   := "" 
Local cArqInd     := "" 

Local lImp        := .F.       // Indica se algo foi impresso
Local cEstoq 	  := If( (mv_par14 == 1),"'S'",If( (mv_par14 == 2),"'N'","'S','N'" ) )
Local cDupli 	  := If( (mv_par13 == 1),"'S'",If( (mv_par13 == 2),"'N'","'S','N'" ) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ VARIAVEIS DE COLUNAS                                                   ³
//³ As variaveis abaixo nCol???, guardam valores das colunas que serÆo     ³
//³ usadas na impressao, pois como tem 4 formas de quebra, a cada forma de ³
//³ um cabecalho diferente as colunas irÆo mudar.                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOrdem      := aReturn[ 8 ] 
Local nLoop       := 0
Local nValor      := 0 
Local nValorQueb  := 0 
Local nValorTot   := 0 
Local nValReal    := 0 
Local nValMeta    := 0 
Local nQtdReal    := 0 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                     ³
//³                                                          ³
//³ mv_par01            // Dt. emissao de ?                  ³
//³ mv_par02            // Dt. emissao ate ?                 ³
//³ mv_par03            // Regiao de ?                       ³
//³ mv_par04            // Regiao ate ?                      ³
//³ mv_par05            // Tipo de ?                         ³
//³ mv_par06            // Tipo ate ?                        ³
//³ mv_par07            // Grupo de ?                        ³
//³ mv_par08            // Grupo ate ?                       ³
//³ mv_par09            // Considera devolucao Sim/Nao       ³
//³ mv_par10            // Dt. emissao de ?                  ³
//³ mv_par11            // Dt. emissao ate ?                 ³
//³ mv_par12            // Moeda ?                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Li := 100 

dbSelectArea(cString)
SetRegua(LastRec())
dbSetOrder(1)
dbSeek(xFilial())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o code-block de filtro do usuario                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

If !Empty( aReturn[7] ) 
	cBlockFil := "{ || " + aReturn[ 7 ] + " }"
	bCondFil  := &cBlockFil 
EndIf 	

AD5->( dbSetOrder( 1 ) ) 
cKey := AD5->( IndexKey() ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecao dos registros validos para o processamento           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Logica para SQL                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAliasSCT := GetNextAlias()

aStruSCT := SCT->( dbStruct() ) 
                
If Empty( aReturn[ 7 ] ) 
	cQuery := "SELECT CT_DOC,CT_SEQUEN,CT_TIPO,CT_GRUPO,CT_PRODUTO,CT_VEND,CT_REGIAO,CT_MOEDA,CT_DESCRI,CT_DATA,CT_VALOR,CT_QUANT, CT_CATEGO "
Else	
	cQuery := "SELECT * "
EndIf 
	
cQuery += "FROM "
cQuery += RetSQLName("SCT")+" SCT "
cQuery += "WHERE CT_FILIAL='"+xFilial("SCT")+"' AND "
cQuery += "CT_REGIAO>='"+MV_PAR03+"' AND "
cQuery += "CT_REGIAO<='"+MV_PAR04+"' AND "	
cQuery += "CT_TIPO>='"  +MV_PAR05+"' AND "
cQuery += "CT_TIPO<='"  +MV_PAR06+"' AND "	
cQuery += "CT_GRUPO>='" +MV_PAR07+"' AND "
cQuery += "CT_GRUPO<='" +MV_PAR08+"' AND "	
cQuery += "CT_DATA>='"  +DToS(MV_PAR10)+"' AND "
cQuery += "CT_DATA<='"  +DToS(MV_PAR11)+"' AND "	

cQuery += "SCT.D_E_L_E_T_=' '" 

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSCT,.T.,.T.)

For nLoop := 1 To Len( aStruSCT ) 
	If aStruSCT[ nLoop, 2 ] <> "C" .And. !Empty( ( cAliasSCT )->( FieldPos( aStruSCT[ nLoop, 1 ] ) ) )
		TcSetField(cAliasSCT,aStruSCT[ nLoop, 1 ],aStruSCT[ nLoop, 2 ],aStruSCT[ nLoop, 3 ],aStruSCT[ nLoop, 4 ] )
	EndIf 		
Next nLoop 	

bWhile := { || !( cAliasSCT )->( Eof() ) }

nValor := 0 
nQuant := 0     
	
While Eval( bWhile ) 
      
	If Empty( aReturn[ 7 ] ) .Or. &( aReturn[ 7 ] )       
                              
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chama a funcao de calculo das vendas                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aVendas := FtNfVendas(4,(cAliasSCT)->CT_VEND,MV_PAR01,MV_PAR02,(cAliasSCT)->CT_REGIAO,(cAliasSCT)->CT_TIPO,(cAliasSCT)->CT_GRUPO,(cAliasSCT)->CT_PRODUTO,MV_PAR12,"","","",,cDupli,cEstoq, (cAliasSCT)->CT_CATEGO)
	
		aDevol := { 0,0,0 }
		
		If MV_PAR09 == 1  	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Chama a funcao de calculo das devolucoes de venda            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aDevol := FtNfDevol(4,(cAliasSCT)->CT_VEND,MV_PAR01,MV_PAR02,(cAliasSCT)->CT_REGIAO,(cAliasSCT)->CT_TIPO,(cAliasSCT)->CT_GRUPO,(cAliasSCT)->CT_PRODUTO,MV_PAR12,"","",,cDupli,cEstoq, (cAliasSCT)->CT_CATEGO)
		EndIf 			
				
		Li++                     
		
		nValMeta := xMoeda( ( cAliasSCT )->CT_VALOR, ( cAliasSCT )->CT_MOEDA, MV_PAR12, ( cAliasSCT )->CT_DATA ) 
	
		If ( Li > 58 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif         
	
	//     NUMERO    SEQ DESCRICAO                  DATA       VENDEDOR  REGIAO  PRODUTO                        GRUPO  TIPO        VALOR/META         QUANT/META        VALOR/REAL   QUANT/REAL       DIFERENCA VALOR   DIFERENCA QTD
	//               1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	//     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//     XXXXXXXXX XXX XXXXXXXXXXXXXXXXXXXXXXXXX  XX/XX/XXXX XXXXXX    XXX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXX    XX   9,999,999,999.99       9,999,999.99  9,999,999,999.99 9,999,999.99      9,999,999,999.99    9,999,999.99     
	 	
	 	@ Li, 00 PSAY ( cAliasSCT )->CT_DOC
	 	@ Li, 10 PSAY ( cAliasSCT )->CT_SEQUEN	 	
	 	@ Li, 14 PSAY Left((cAliasSCT)->CT_DESCRI, 25) 
	 	@ Li, 41 PSAY ( cAliasSCT )->CT_DATA 
	
	 	@ Li, 52 PSAY ( cAliasSCT )->CT_VEND 	 	
	 	
	 	@ Li, 62  PSAY ( cAliasSCT )->CT_REGIAO 	 	
	 	@ Li, 70  PSAY ( cAliasSCT )->CT_PRODUTO
	 	@ Li, 101 PSAY ( cAliasSCT )->CT_GRUPO 	
	 	@ Li, 109 PSAY ( cAliasSCT )->CT_TIPO 		 	
	 	
	 	@ Li,114 PSAY nValMeta                PICTURE "@E 9,999,999,999.99"
	 	@ Li,137 PSAY ( cAliasSCT )->CT_QUANT PICTURE "@E 9,999,999.99"	 	
	 	
	 	nValReal := aVendas[ 1 ] - aDevol[ 1 ]
	 	nQtdReal := aVendas[ 2 ] - aDevol[ 2 ]
	 	
		@ Li,151 PSAY nValReal PICTURE "@E 9,999,999,999.99" 
		@ Li,168 PSAY nQtdReal PICTURE "@E 999,999,999.99" 
		                                                       
		@ Li,186 PSAY nValReal - nValMeta                 PICTURE "@E 9,999,999,999.99"
		@ Li,206 PSAY nQtdReal - ( cAliasSCT )->CT_QUANT  PICTURE "@E 9,999,999.99"

	EndIf 
			
	( cAliasSCT )->( dbSkip() ) 
	
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integridade da rotina                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
( cAliasSCT )->( dbCloseArea() ) 
dbSelectArea( "SCT" ) 
	
If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf       

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

dbSelectArea( "SCT" )
RetIndex("SCT")

Return(.T.)