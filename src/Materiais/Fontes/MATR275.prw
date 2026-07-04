/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR275.CH"  
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR275	³ Autor ³ Nereu Humberto Junior ³ Data ³ 03/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Kardex p/ Lote Sobre o SDB                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR275()

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Nereu Humberto Junior  ³ Data ³03.08.2006³±±
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
Local oSection 
Local cTamQtd	:=	TamSX3('DB_QUANT')[1]
Local cTamDoc	:=	TamSX3('DB_DOC')[1]
Local cTamSer	:=	SerieNFId("SDB",6,"DB_SERIE")
Local cPerg  := "MTR276P9R1"
Local lQuery := .T.

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
oReport := TReport():New("MATR275",STR0003,cPerg, {|oReport| ReportPrint(oReport,cPerg)},STR0001+" "+STR0002) //"Kardex por Localizacao (por produto)"##//"Este programa emitir  um Kardex com todas as movimenta‡”es"##//"do estoque por Localizacao e Numero de Serie, diariamente."
oReport:SetLandscape()    

Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                        		³
//³ mv_par01         	// Produto ?	                        		³
//³ mv_par02        	// Lote ?		                        		³
//³ mv_par03        	// Sub-Lote ?                           		³
//³ mv_par04        	// Do  Armazem                          		³
//³ mv_par05        	// Ate Armazem                          		³
//³ mv_par06        	// De  Data                             		³
//³ mv_par07        	// Ate Data                             		³
//³ mv_par08        	// Endereco ?                    				³
//³ mv_par09        	// Numero de Serie ?	                		³
//³ mv_par10        	// Lista os Estornos ?                  		³
//³ mv_par11        	// Exibe Quantidades em qual UM?        		³
//³ mv_par12        	// Para Movimentacoes de CQ?       				³
//³ mv_par13        	// Seleciona Filiais ? (Sim/Nao)				³
//³ mv_par14        	// Lista Produtos sem movimento ?(1=Sim/2=Nao)	³
//| mv_par15         // Ordena por sequencia ou por documento   	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection := TRSection():New(oReport,STR0016,{"SDB","SB1","SD7"}) // "Movimentos por Endereco"
oSection :SetHeaderPage()
oSection:SetNoFilter("SB1")
oSection:SetNoFilter("SD7")

TRCell():New(oSection,"DB_PRODUTO"	,"SDB",/*Titulo*/	,/*Picture*/					,/*Tamanho*/,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_PRODUTO }))
If TamSX3('DB_PRODUTO')[1]<= 15
	TRCell():New(oSection,"B1_DESC"		,"SB1",/*Titulo*/	,/*Picture*/					,30			,/*lPixel*/,/*{|| code-block de impressao }*/)
EndIf
TRCell():New(oSection,"DB_LOCAL"	,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_LOCAL }))
TRCell():New(oSection,"DB_LOCALIZ"	,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_LOCALIZ }))
TRCell():New(oSection,"DB_NUMSERI"	,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_NUMSERI }))
TRCell():New(oSection,"DB_LOTECTL"	,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_LOTECTL }))
TRCell():New(oSection,"DB_NUMLOTE"	,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_NUMLOTE }))
TRCell():New(oSection,"DB_DATA"		,"SDB",/*Titulo*/	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_DATA }))
TRCell():New(oSection,"cDoc"		,"   ",STR0009	,"@!"								,cTamDoc		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,"cSerie"		,"   ",STR0010	,"@!"								,cTamSer		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,"DB_ESTORNO"	,"SDB",STR0011	,/*Picture*/						,/*Tamanho*/	,/*lPixel*/,If(lQuery,Nil,{|| TRB->DB_ESTORNO }))
TRCell():New(oSection,"nSaldoIni"	,"   ",STR0012	,PesqPict("SDB","DB_QUANT",14)	,cTamQtd		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,"nEntrada"	,"   ",STR0013	,PesqPict("SDB","DB_QUANT",14)	,cTamQtd		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,"nSaida"		,"   ",STR0014	,PesqPict("SDB","DB_QUANT",14)	,cTamQtd		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,"nSaldo"		,"   ",STR0015	,PesqPict("SDB","DB_QUANT",14)	,cTamQtd		,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Nereu Humberto Junior  ³ Data ³03.08.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cPerg)

Local oSection  := oReport:Section(1)
Local aStrucSDB := SDB->(dbStruct())
Local cAliasSDB := GetNextAlias()
Local nSaldoIni :=nEntrada:=nSaida:=0
Local cProd	  := ""
Local cLocal, cLocaliz, cLoteCtl, cNumLote, cNumSerie, lFirst
Local nUM       := mv_par11
Local lImpCQOrig:= (mv_par12==2)
Local cDocSDB   := ''
Local cSerieSDB := ''
Local lMovtoProd:= .F.
Local cSeqDoc := IIF (MV_PAR15 == 2,"%SDB.DB_DOC%", "%SDB.DB_NUMSEQ%" )
Local cFilUsrSDB:= ""
Local cName		:= ""
Local cSelect	:= ""
Local cOn    := "%%"
Local cWhere := "%%"
Local cWhereBZ := "%%"
Local cDadosProd  := Upper(SuperGetMV("MV_ARQPROD",.F.,"SB1"))
Local nQryAd	:= 0
Local nX		:= 0

Local aFilsCalc := {}
Local nForFilial:= 0
Local cFilBack  := cFilAnt

static lPrRange := .T.
static cPrNoRang := ''

aFilsCalc:= MatFilCalc( mv_par13 == 1 ) 

If Empty(aFilsCalc)
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Converte os parametros do tipo range, para um range cheio,  ³
//³caso o conteudo do parametro esteja vazio                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FullRange(cPerg)

oReport:NoUserFilter()  // Desabilita a aplicacao do filtro do usuario no filtro/query das secoes

For nForFilial := 1 To Len( aFilsCalc )

	If aFilsCalc[ nForFilial, 1 ]
	
		cFilAnt := aFilsCalc[ nForFilial, 2 ]
		
		oReport:EndPage() //Reinicia Paginas

		oReport:SetTitle( STR0003 + " - " + aFilsCalc[ nForFilial, 3 ] )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Filtragem do relatório                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   	cFilUsrSDB:= oSection:GetAdvplExp()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        IF AT('-',MV_PAR01) > 0
         	lPrRange := .T.
          	DbSelectArea("SB1")
           	DbSetOrder(1)
           	If MsSeek(xFilial("SB2")+MV_PAR01)       
           	   lPrRange := .F.
           	   cPrNoRang := MV_PAR01
           	EndIf
	    EndIf
		MakeSqlExpr(cPerg)					

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Esta rotina foi escrita para adicionar no select os campos         ³
		//³usados no filtro do usuario, quando houver.                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SDB")
	    If !Empty(cFilUsrSDB) .And. nQryAd == 0   
			For nX := 1 To SDB->(FCount())
				cName := SDB->(FieldName(nX))
			 	If AllTrim( cName ) $ cFilUsrSDB
			   		If aStrucSDB[nX,2] <> "M"  
			   			If !cName $ cSelect 
			        		If Empty(cSelect) 
			        			cSelect := "%" 
			        			cSelect += cName
			        		Else
			        			cSelect += ","+cName
			        		EndIf
				        		nQryAd ++
			          	Endif 	
			       EndIf
				EndIf 			       	
			Next nX 
			If !Empty(cSelect)
				cSelect += "%"
			EndIf
		Endif    

		cOn :="%"
		If !Empty(mv_par01)
				If !lPrRange
			       	cOn += "DB_PRODUTO IN ('"+alltrim(cPrNoRang)+"') AND"
			 	Else
					cOn += mv_par01+' AND '
     			EndIf
		EndIf
		If !Empty(mv_par02)
			cOn += mv_par02+' AND '
		EndIf
		If !Empty(mv_par03)
			cOn += mv_par03+' AND '
		EndIf
		If !Empty(mv_par08)
			cOn += mv_par08+' AND '
		EndIf
		If !Empty(mv_par09)
			cOn += mv_par09+' '
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Adaptacao ao APDL - Considera somente mov. que atual. Estoque³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOn += " AND NOT (SDB.DB_ATUEST = 'N')"
		cOn += "%"
		cWhere :="%"+ StrTran(MV_PAR01,"DB_PRODUTO"," ( CASE WHEN( SBZ.BZ_COD IS NOT NULL ) THEN( SBZ.BZ_COD ) ELSE( SB1.B1_COD ) END ) ") +"%"
		If cDadosProd == 'SB1'
			cWhereBZ := "% SB1.B1_LOCALIZ = 'S' %"
		Else
			cWhereBZ := "% ( CASE WHEN( SBZ.BZ_LOCALIZ IS NOT NULL ) THEN( SBZ.BZ_LOCALIZ ) ELSE( SB1.B1_LOCALIZ ) END ) = 'S' %"
		EndIf
		
		dbSelectArea("SBZ")
		dbSetOrder(1)

		dbSelectArea("SB1")
		dbSetOrder(1)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query do relatório da secao 1                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):BeginQuery()	
		
		BeginSql Alias cAliasSDB
			SELECT DISTINCT SDB.DB_FILIAL,SDB.DB_PRODUTO,SDB.DB_LOCAL,SDB.DB_LOCALIZ,SDB.DB_NUMSERI,SDB.DB_LOTECTL,
				       SDB.DB_NUMLOTE,SDB.DB_DATA,SDB.DB_NUMSEQ,SDB.DB_IDOPERA,SDB.DB_DOC,SDB.DB_SERIE,SDB.DB_TM,
				       SDB.DB_QUANT,SDB.DB_ESTORNO, SB1.B1_COD, SB1.B1_DESC, SB2.B2_LOCAL ,
					   %Exp:cSelect%
				
			FROM %table:SB2% SB2
				INNER JOIN %table:SB1% SB1 ON ( SB1.B1_FILIAL =  %xFilial:SB1%  AND SB2.B2_FILIAL =  %xFilial:SB2% AND SB1.B1_COD = SB2.B2_COD )
				LEFT OUTER JOIN %table:SBZ% SBZ ON ( SBZ.BZ_FILIAL = %xFilial:SBZ%  AND SB1.B1_FILIAL =  %xFilial:SB1%  AND SBZ.BZ_COD = SB1.B1_COD AND SBZ.%NotDel% )	
				LEFT JOIN %Table:SDB% SDB ON
					(SDB.DB_FILIAL = %xFilial:SDB%  AND SB2.B2_FILIAL =  %xFilial:SB2% AND 
					SDB.DB_PRODUTO = SB2.B2_COD AND 
					SDB.DB_LOCAL = SB2.B2_LOCAL AND
					SDB.DB_LOCAL >= %Exp:mv_par04% AND 
					SDB.DB_LOCAL <= %Exp:mv_par05% AND 
					SDB.DB_DATA >= %Exp:mv_par06% AND 
					SDB.DB_DATA <= %Exp:mv_par07% AND 
					SDB.%NotDel% AND %Exp:cOn%)				

			WHERE %Exp:cWhereBZ%
					AND SB2.B2_LOCAL >= %Exp:mv_par04% AND SB2.B2_LOCAL <= %Exp:mv_par05%
					AND SB1.%NotDel% 
					AND SB2.%NotDel% 
					AND %Exp:cWhere%	

			ORDER BY SB1.B1_COD,SDB.DB_LOCAL,SDB.DB_LOCALIZ,SDB.DB_NUMSERI,SDB.DB_LOTECTL,SDB.DB_NUMLOTE,SDB.DB_DATA,%Exp:cSeqDoc%,SDB.DB_SERIE

		EndSql 
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
		TRPosition():New(oSection,"SB1",1,{|| xFilial("SB1")+(cAliasSDB)->DB_PRODUTO})
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicio da impressao do fluxo do relatório                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea(cAliasSDB)
		oReport:SetMeter(SDB->(LastRec()))
		oSection:Init()
		cProd := ''
		While !oReport:Cancel() .And. !(cAliasSDB)->(Eof())
		    
			lFirst  := .F.  
			lNprod  := .F.
			If oReport:Cancel()
				Exit
			EndIf
			
			oReport:IncMeter()

			If (cAliasSDB)->DB_ESTORNO == "S"  .And. mv_par10 == 2
				DbSkip()
				Loop
			EndIf			

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Considera filtro de usuario                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(cFilUsrSDB) .And. !(&(cFilUsrSDB))
				DbSkip()
				Loop
			EndIf			
					
			nSaldoIni:=nEntrada:=nSaida:=0                                         
			
			If !Empty((cAliasSDB)->DB_LOCAL) // Se DB_LOCAL vazio nao houve movimentacao no armazem
				nSaldoIni := CalcEstL((cAliasSDB)->B1_COD,(cAliasSDB)->DB_LOCAL,mv_par06,(cAliasSDB)->DB_LOTECTL,(cAliasSDB)->DB_NUMLOTE,(cAliasSDB)->DB_LOCALIZ,(cAliasSDB)->DB_NUMSERI)[1]
			Else
				nSaldoIni := CalcEst((cAliasSDB)->B1_COD,(cAliasSDB)->B2_LOCAL,mv_par06,,,)[1]
			EndIf                                      
			
			//-- Converte o Saldo inicial para Segunda Unidade de Medida
			If nUm == 2
				nSaldoIni := ConvUM((cAliasSDB)->DB_PRODUTO, nSaldoIni, 0, 2)
			EndIf	

 			If mv_par14 == 2 .And. Empty((cAliasSDB)->DB_DATA) .And. nSaldoIni == 0
 				lNprod := .T.
 				DbSkip()
 				Loop			
			EndIf

			If !Empty(cProd) .And. cProd <> (cAliasSDB)->DB_PRODUTO
				oReport:SkipLine(1)
				If !lMovtoProd
					oReport:PrintText(STR0017)	//"Não houve movimentação para este produto"
    			EndIf
				oReport:ThinLine()
				lMovtoProd := .F.
				oReport:SkipLine(1)
			EndIf
			
			If (DB_DATA >= mv_par06 .And. DB_DATA <= mv_par07)  
				oSection:Cell("DB_PRODUTO"):Show()
				If TamSX3('DB_PRODUTO')[1]<= 15
					oSection:Cell("B1_DESC"):Show()
				EndIf
				oSection:Cell("DB_LOCAL"):Show()
				oSection:Cell("DB_LOCALIZ"):Show()
				oSection:Cell("DB_LOTECTL"):Show()
				oSection:Cell("DB_NUMLOTE"):Show()
				oSection:Cell("nSaldoIni"):Show()
				
				oSection:Cell("DB_NUMSERI"):Hide()
				oSection:Cell("DB_DATA"):Hide()
				oSection:Cell("cDoc"):Hide()
				oSection:Cell("cSerie"):Hide()
				oSection:Cell("DB_ESTORNO"):Hide()
				oSection:Cell("nEntrada"):Hide()
				oSection:Cell("nSaida"):Hide()
				oSection:Cell("nSaldo"):Hide()

				oSection:Cell("DB_PRODUTO"):SetValue((cAliasSDB)->DB_PRODUTO)
				If TamSX3('DB_PRODUTO')[1]<= 15
					oSection:Cell("B1_DESC"):SetValue((cAliasSDB)->B1_DESC)
				EndIf
				oSection:Cell("DB_LOCAL"  ):SetValue((cAliasSDB)->DB_LOCAL)
				oSection:Cell("DB_LOCALIZ"):SetValue((cAliasSDB)->DB_LOCALIZ)
				oSection:Cell("DB_LOTECTL"):SetValue((cAliasSDB)->DB_LOTECTL)
				oSection:Cell("DB_NUMLOTE"):SetValue((cAliasSDB)->DB_NUMLOTE)
				oSection:Cell("nSaldoIni"):SetValue(nSaldoIni)
				oSection:PrintLine()
			EndIf
			        
			cProd    := (cAliasSDB)->DB_PRODUTO
			cLocal   := If(Empty((cAliasSDB)->DB_LOCAL),(cAliasSDB)->B2_LOCAL,(cAliasSDB)->DB_LOCAL)
			cLocaliz := (cAliasSDB)->DB_LOCALIZ
			cLoteCtl := (cAliasSDB)->DB_LOTECTL
			cNumLote := (cAliasSDB)->DB_NUMLOTE
			cNumSerie:= (cAliasSDB)->DB_NUMSERI 
		
			Do While !Eof() .And. cProd+cLocal+cLocaliz+cNumSerie+cLoteCtl+cNumLote == ;
				(cAliasSDB)->DB_PRODUTO+If(Empty((cAliasSDB)->DB_LOCAL),(cAliasSDB)->B2_LOCAL,(cAliasSDB)->DB_LOCAL)+;
				(cAliasSDB)->DB_LOCALIZ+(cAliasSDB)->DB_NUMSERIE+(cAliasSDB)->DB_LOTECTL+(cAliasSDB)->DB_NUMLOTE
			    
				If (cAliasSDB)->DB_ESTORNO == "S"  .And. mv_par10 == 2
					DbSkip()
					Loop
				EndIf			

	 			If mv_par14 == 2 .And. Empty((cAliasSDB)->DB_DATA)
	 				lNprod := .T.
	 				DbSkip()
	 				Loop			
				EndIf
					
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera filtro de usuario                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty(cFilUsrSDB) .And. !(&(cFilUsrSDB))
	 				DbSkip()
	 				Loop			
				EndIf
				
				oSection:Cell("DB_PRODUTO"):Hide()
				If TamSX3('DB_PRODUTO')[1]<= 15	
					oSection:Cell("B1_DESC"):Hide()
				EndIf
				oSection:Cell("DB_LOCAL"):Hide()
				oSection:Cell("DB_LOCALIZ"):Hide()
				oSection:Cell("DB_LOTECTL"):Hide()
				oSection:Cell("DB_NUMLOTE"):Hide()
				oSection:Cell("nSaldoIni"):Hide()

				oSection:Cell("DB_NUMSERI"):Show()
				oSection:Cell("DB_DATA"):Show()
				oSection:Cell("cDoc"):Show()
				oSection:Cell("cSerie"):Show()
				oSection:Cell("DB_ESTORNO"):Show()
				oSection:Cell("nEntrada"):Show()
				oSection:Cell("nSaida"):Show()
				oSection:Cell("nSaldo"):Show()

				cDocSDB   := (cAliasSDB)->DB_DOC
				cSerieSDB := (cAliasSDB)->DB_SERIE

				//-- Imprime os Numeros de DOC e SERIE originais para Movimentacoes de CQ
				If lImpCQOrig
					MTR275OrCQ(@cDocSDB, @cSerieSDB)
				EndIf

				oSection:Cell("cDoc"):SetValue(cDocSDB)
				oSection:Cell("cSerie"):SetValue(SubStr(AllTrim(cSerieSDB),1,3))
				
				If (cAliasSDB)->DB_TM <= "500" .Or. Substr((cAliasSDB)->DB_TM,1,1) $ "PD"
					oSection:Cell("nEntrada"):Show()
					If nUm == 1	
						nEntrada+=(cAliasSDB)->DB_QUANT
						oSection:Cell("nEntrada"):SetValue((cAliasSDB)->DB_QUANT)
					Else
						//-- Converte as Entradas para a 2a Unidade de Medida
						nEntrada += ConvUM((cAliasSDB)->DB_PRODUTO, (cAliasSDB)->DB_QUANT, 0, 2)
						oSection:Cell("nEntrada"):SetValue(ConvUM((cAliasSDB)->DB_PRODUTO, (cAliasSDB)->DB_QUANT, 0, 2))
					EndIf	
					oSection:Cell("nSaida"):Hide()
					oSection:Cell("nSaida"):SetValue(0)
				Else
					oSection:Cell("nSaida"):Show()
					If nUm == 1	
						nSaida+=(cAliasSDB)->DB_QUANT
						oSection:Cell("nSaida"):SetValue((cAliasSDB)->DB_QUANT)
					Else
						//-- Converte as Saidas para a 2a Unidade de Medida
						nSaida += ConvUM((cAliasSDB)->DB_PRODUTO, (cAliasSDB)->DB_QUANT, 0, 2)
						oSection:Cell("nSaida"):SetValue(ConvUM((cAliasSDB)->DB_PRODUTO, (cAliasSDB)->DB_QUANT, 0, 2))
					EndIf	
					oSection:Cell("nEntrada"):Hide()
					oSection:Cell("nEntrada"):SetValue(0)
				EndIf
				oSection:Cell("nSaldo"):SetValue((nSaldoIni+nEntrada) - nSaida)
				lFirst := .T.					
				lMovtoProd := .T.
				If (DB_DATA >= mv_par06 .And. DB_DATA <= mv_par07) 
					oSection:PrintLine()
				EndIf
					// Tratamento para apresentar produtos sem movimento no periodo	
				If mv_par14 == 1 .And. !(DB_DATA >= mv_par06 .And. DB_DATA <= mv_par07)  
						M275SldIni(B1_COD,B1_DESC,B2_LOCAL,@oSection,@oReport)
				EndIf	
				dbSkip()
			EndDo

			If !lFirst .And. MV_PAR14 == 2 .And. !lNprod
				dbSkip()				
			EndIF

		EndDo

		If !Empty(cProd)
			If !lMovtoProd
				oReport:PrintText(STR0017)	//"Não houve movimentação para este produto"
   				EndIf
			oReport:ThinLine()
		EndIf
		oSection:Finish()			
	EndIf
	
Next nForFilial

cFilAnt := cFilBack

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTR275OrCQºAutor  ³Microsiga           º Data ³  06/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function MTR275OrCQ(cDoc, cSerie)

Local aAreaAnt   := GetArea()

dbSelectArea('SD7')
dbSetorder(1)
If MsSeek(xFilial('SD7')+cDoc, .F.)
	cDoc   := SD7->D7_DOC
	cSerie := SD7->D7_SERIE
EndIf

RestArea(aAreaAnt)
Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ M275SldIni ³ Autor ³ Materiais           ³ Data ³ 04/12/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna saldo Inicial do Armazem caso nao exista movimentos³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ MATR275                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function M275SldIni(cProduto,cDesc,cLocal,oSection,oReport)

Local nSldIni   := 0
Local cQuery    := ""
Local lPrint    := .F.
Local aArea     := GetArea()
Local cAliSld   := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devido a SBF ser apagada quando o saldo do Endereco eh zero, eh necessario ³
//³ verificar na SDB  quais Enderecos do Armazem o Produto ja movimentou para  ³
//³ entao apresentar obter o saldo dos Enderecos onde o Produto possui saldo   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery := " SELECT DISTINCT	SDB.DB_PRODUTO,SDB.DB_LOCAL,SDB.DB_LOCALIZ,SDB.DB_LOTECTL,SDB.DB_NUMLOTE "
cQuery += " FROM "+RetSqlName("SDB") +" SDB "
cQuery += " 	INNER JOIN "+RetSqlName("SB1")+" SB1 ON ( SB1.B1_FILIAL = '"+xFilial('SB1')+"' AND SDB.DB_FILIAL = '"+xFilial('SDB')+"'AND SB1.B1_COD = SDB.DB_PRODUTO ) "
cQuery += " WHERE SDB.DB_ESTORNO = ' ' "
cQuery += " 	AND SDB.DB_PRODUTO = '"+cProduto+"' 
cQuery += " 	AND SDB.DB_LOCAL = '"+cLocal+"' "
cQuery += " 	AND SB1.D_E_L_E_T_ = ' ' "
cQuery += " 	AND SDB.D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY 1,2,3,4"

cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliSld,.T.,.T.)

oSection:Cell("DB_PRODUTO"):Show()
If TamSX3('DB_PRODUTO')[1]<= 15
	oSection:Cell("B1_DESC"):Show()
EndIf
oSection:Cell("DB_LOCAL"  ):Show() 
oSection:Cell("DB_LOCALIZ"):Show()
oSection:Cell("DB_LOTECTL"):Show()
oSection:Cell("DB_NUMLOTE"):Show()
oSection:Cell("nSaldoIni" ):Show()
oSection:Cell("nSaldo"    ):Show()
oSection:Cell("nEntrada"  ):Hide()
oSection:Cell("DB_DATA"   ):Hide()

While !(cAliSld)->(Eof())
	nSldIni := CalcEstL(cProduto,cLocal,mv_par06,(cAliSld)->DB_LOTECTL,(cAliSld)->DB_NUMLOTE,(cAliSld)->DB_LOCALIZ)[1]
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ So imprime o saldo caso seja maior de 0 (zero) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nSldIni > 0
		lPrint := .T.
		oSection:Cell("DB_PRODUTO"):SetValue(cProduto)
		If TamSX3('DB_PRODUTO')[1]<= 15
			oSection:Cell("B1_DESC"):SetValue(cDesc)
		EndIf
		oSection:Cell("DB_LOCAL"  ):SetValue(cLocal)
		oSection:Cell("DB_LOCALIZ"):SetValue((cAliSld)->DB_LOCALIZ)
		oSection:Cell("DB_LOTECTL"):SetValue((cAliSld)->DB_LOTECTL)
		oSection:Cell("DB_NUMLOTE"):SetValue((cAliSld)->DB_NUMLOTE)
		oSection:Cell("nSaldoIni" ):SetValue(nSldIni)
		oSection:Cell("nSaldo"    ):SetValue(nSldIni)
		oSection:PrintLine()
	EndIf
	(cAliSld)->(dbSkip())
EndDo
(cAliSld)->(DbCloseArea())

If lPrint 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ So imprime o rodape com as informacoes que o produto nao possui ³
	//³ movimento se imprimiu alguma linha de saldo no relatorio        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine(1)
	oReport:PrintText(STR0017)
	oReport:SkipLine(1)
	oReport:ThinLine()
EndIf

RestArea(aArea)

Return Nil
