/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR502.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR502  ³ Autor ³ Vendas CRM            ³ Data ³ 20/07/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Comparador de Indicadores de Help Desk                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMKR501(void)                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR502()
Local oReport	//Objeto relatorio TReport (Release 4)
                 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("TMKR502",.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ Mv_Par01           // De                                     ³
	//³ Mv_Par02           // Ate                                    ³
	//³ Mv_Par03           // Indicador 1			                 ³
	//³ Mv_Par04           // Indicador 2                            ³		
	//³ Mv_Par05           // Do Grupo                               ³		
	//³ Mv_Par06           // Ate o Grupo                            ³	
	//³ Mv_Par07           // Do Analista                            ³		
	//³ Mv_Par08           // Ate o Analista                         ³	
	//³ Mv_Par09           // Tipo de Relatorio                      ³		
	//³ MV_PAR10		   // Agrupar por 							 |
	//³ MV_PAR11		   // Exibir chamados						 |
	//³ MV_PAR12		   // Status         						 | 
	//³ MV_PAR13		   // Exibe sub-equipes ?       			 |	
	//³ MV_PAR14		   // Tipo de Data  		       			 |	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog() 

Return(.T.)
                     
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³Vendas CRM          ³ Data ³20/07/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio.                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr501RptDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport 						//Objeto relatorio TReport (Release 4)
Local oSection1         		    //Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2    			        //Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3						//Objeto secao 3 do relatorio (Sintetico)
Local cAlias1	:= GetNextAlias()	// Pega o proximo Alias Disponivel
Local oBreak

// "Cadastro de Concorrentes" # // "Este programa ira emitir uma relacao dos produtos dos concorrentes" #
// "comparando com os produtos ca base de dados." # // "A emissao ocorrera baseada nos parametros do relatorio"
DEFINE REPORT oReport NAME "TMKR502" TITLE STR0001 PARAMETER "TMKR502" ACTION {|oReport| Tkr502PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002 // "Comparador de Indicadores de Help Desk" # "Este programa irá emitir uma relação de chamados que atendem a comparação de indicadores de relatórios. A comparação ocorrerá baseada nos parametros do relatório."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport 	TITLE STR0003 TABLES "ADF"   		// "Grupo"
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0004 TABLES "ADE", "ADF" 	// "Chamados"
DEFINE SECTION oSection3 OF oReport 	TITLE STR0005 						// "Analise Sintética"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADF_CODSU0"	OF oSection1 ALIAS "ADF" TITLE STR0006 BLOCK {||TRIM((cAlias1)->ADF_CODSU0 + " - " + POSICIONE('SU0',1,xFilial('SU0')+(cAlias1)->ADF_CODSU0,'U0_NOME'))} SIZE 40 // "Equipe"		
DEFINE CELL NAME "ADF_CODSU7"	OF oSection1 ALIAS "ADF" TITLE STR0007 BLOCK{||TRIM((cAlias1)->ADF_CODSU7 + " - " + FATPDObfuscate(POSICIONE('SU7',1,XFILIAL('SU7') + (cAlias1)-> ADF_CODSU7, 'U7_NOME'),"U7_NOME",,.T.))} SIZE 30	// "Analista"
                                                                                                                                  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_CODIGO"	OF oSection2 ALIAS "ADE" SIZE 10	
DEFINE CELL NAME "ADE_CHAVE"	OF oSection2 ALIAS "ADE" TITLE STR0008  // "Cliente"
DEFINE CELL NAME "ADE_DESCCH"	OF oSection2 ALIAS "ADE" TITLE STR0009 BLOCK {||FATPDObfuscate(TKENTIDADE((cAlias1)->ADE_ENTIDA,(cAlias1)->ADE_CHAVE,1),"ADE_DESCCH",,.T.)} SIZE 40 // "Descrição"
DEFINE CELL NAME "ADE_CODSB1"	OF oSection2 ALIAS "ADE"	
DEFINE CELL NAME "ADE_NMPROD"	OF oSection2 ALIAS "ADE" TITLE STR0010 BLOCK{||POSICIONE('SB1',1,XFILIAL('SB1')+(cAlias1)->ADE_CODSB1,'B1_DESC')}  SIZE 30		// "Produto"
DEFINE CELL NAME "ADE_DATA" 	OF oSection2 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_DTEXPI" 	OF oSection2 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_HREXPI" 	OF oSection2 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_STATUS" 	OF oSection2 ALIAS "ADE" SIZE 15	      
DEFINE CELL NAME "ADF_CODSU0"	OF oSection2 ALIAS "ADF" TITLE STR0011 BLOCK {||TRIM((cAlias1)->ADF_CODSU0 + " - " + POSICIONE('SU0',1,xFilial('SU0')+(cAlias1)->ADF_CODSU0,'U0_NOME'))} SIZE 40 // "Equipe"		
DEFINE CELL NAME "ADF_CODSU7"	OF oSection2 ALIAS "ADF" TITLE STR0012 BLOCK{||TRIM((cAlias1)->ADF_CODSU7 + " - " + FATPDObfuscate(POSICIONE('SU7',1,XFILIAL('SU7') + (cAlias1)-> ADF_CODSU7, 'U7_NOME'),"U7_NOME",,.T.))} SIZE 30	// "Analista"
DEFINE CELL NAME "COUNT"		OF oSection2 ALIAS ""	 TITLE STR0013 BLOCK{||(cAlias1)->COUNT}	SIZE 25		    // "Repetições"  


DEFINE BREAK oBreak OF oSection1 WHEN oSection2:Cell("ADE_CODIGO")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )
oSection1:SetLineBreak()

DEFINE FUNCTION FROM oSection2:Cell("ADE_CODIGO") FUNCTION COUNT BREAK oBreak NO END SECTION NO END REPORT TITLE STR0023

DEFINE CELL NAME "TKCODSU0"		OF oSection3 ALIAS "" SIZE 20 TITLE STR0014 // "Código"
DEFINE CELL NAME "TKDESCSU0"	OF oSection3 ALIAS "" SIZE 30 TITLE STR0015 // "Descrição" 
DEFINE CELL NAME "TKDESCI1"		OF oSection3 ALIAS "" SIZE 10 TITLE STR0016 // "Indicador 1" 
DEFINE CELL NAME "TKDESCI2"		OF oSection3 ALIAS "" SIZE 10 TITLE STR0017 // "Indicador 2" 
DEFINE CELL NAME "TKPERCENT"		OF oSection3 ALIAS "" SIZE 10 TITLE STR0018 // "Participação do Indicador 2(%)" 

Return(oReport)  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr502PrtRpt ³ Autor ³Vendas CRM          ³ Data ³20/07/2008³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio              ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr501PrtRept(ExpO1,ExpC2)                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC1 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr502PrtRpt(oReport, cAlias1)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3 := oReport:Section(2)		//Objeto secao 3 do relatorio (Sintetico)
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF
Local cAliasAux := GetNextAlias()			//Alias auxiliar para recuperar os itens do indicador 
Local cWhereI1	:= ""						//Condicoes utilizadas na listagem do indicador  
Local cWhereI2	:= ""						//Condicoes utilizadas na listagem do indicador  
Local aTot		:= {0,0,0}     
Local cHaving	:= ""
Local cOrderBy	:= "" 
Local cGroupBy	:= ""
Local cWhere	:= ""        
Local cWhereESql:= ""						//Predicados utilizados na query Embedded SQL     
Local aSintetic	:= {}
Local nPos		:= 0						//Indica a posicao do array encontrado
Local cSQLFields := ""						//Campos que serão selecionados na query 
Local cListSU0  := FormatIn( Tkr501SelGp(Mv_Par05, Mv_Par06), ",")
Local cListSU0E := ""       
Local cField	:= "" // Campos a serem incluidos no Select da query

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR501")      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a lista de Ocorrências x Acoes listadas no indicador 1	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery := ""
cQuery := "SELECT 	UU_CODSU9,	UU_CODSUQ,	UU_CODSUT,	UU_FILIAL		" 
cQuery += "FROM "+RetSqlName("SUU")+" SUU  WHERE "
cQuery += "SUU.UU_FILIAL = '" + xFilial("SUU") + "' AND "
cQuery += "SUU.UU_CODSUT = '" + MV_PAR03 + "' AND "
cQuery += "SUU.D_E_L_E_T_ = ' ' "
cQuery += "ORDER BY SUU.UU_CODSUT "	    

cQuery	:= ChangeQuery(cQuery)
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)	

While (cAliasAux)->(!EOF()) .AND.;
	(cAliasAux)->UU_FILIAL == xFilial("SUU") .AND.;
	(cAliasAux)->UU_CODSUT	== MV_PAR03
	
	If !Empty(cWhereI1)
		cWhereI1 += " OR ("		
	Else	                       
		cWhereI1 += " ("
	EndIf        
															
	If !Empty((cAliasAux)->UU_CODSU9)
		cWhereI1 += " ADF.ADF_CODSU9 = '" + (cAliasAux)->UU_CODSU9 + "' "
	EndIf
	If !Empty((cAliasAux)->UU_CODSU9) .AND. !Empty((cAliasAux)->UU_CODSUQ)
		cWhereI1 += " AND ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	ElseIf !Empty((cAliasAux)->UU_CODSUQ)
		cWhereI1 += " ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	Else          
		cWhereI1 += ")"	   	
	EndIf	   		   	
	(cAliasAux)->(dbSkip())
End         	                                       
(cAliasAux)->(dbCloseArea())
If !Empty(cWhereI1)
	cWhereI1 := "(" + cWhereI1 + ")"	
Else
	cWhereI1 := "(1=1)"	
EndIf       

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a lista de Ocorrências x Acoes listadas no indicador 2	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery := ""
cQuery := "SELECT 	UU_CODSU9,	UU_CODSUQ,	UU_CODSUT,	UU_FILIAL		" 
cQuery += "FROM "+RetSqlName("SUU")+" SUU  WHERE "
cQuery += "SUU.UU_FILIAL = '" + xFilial("SUU") + "' AND "
cQuery += "SUU.UU_CODSUT = '" + MV_PAR04 + "' AND "
cQuery += "SUU.D_E_L_E_T_ = ' ' "
cQuery += "ORDER BY SUU.UU_CODSUT "	    

cQuery	:= ChangeQuery(cQuery)
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)	

While (cAliasAux)->(!EOF()) .AND.;
	(cAliasAux)->UU_FILIAL == xFilial("SUU") .AND.;
	(cAliasAux)->UU_CODSUT	== MV_PAR04
	
	If !Empty(cwhereI2)
		cwhereI2 += " OR ("		
	Else	                       
		cwhereI2 += " ("
	EndIf        
															
	If !Empty((cAliasAux)->UU_CODSU9)
		cwhereI2 += " ADF.ADF_CODSU9 = '" + (cAliasAux)->UU_CODSU9 + "' "
	EndIf
	If !Empty((cAliasAux)->UU_CODSU9) .AND. !Empty((cAliasAux)->UU_CODSUQ)
		cwhereI2 += " AND ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	ElseIf !Empty((cAliasAux)->UU_CODSUQ)
		cwhereI2 += " ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	Else          
		cwhereI2 += ")"	   	
	EndIf	   		   	
	(cAliasAux)->(dbSkip())
End         	                                       
(cAliasAux)->(dbCloseArea())
If !Empty(cwhereI2)
	cWhereI2 := "(" + cwhereI2 + ")"	
Else
	cwhereI2 := "(1=1)"	
EndIf 	 

cWhere := ""
If MV_PAR12 <= 3
	cWhere := " ADE_STATUS = '" + AllTrim(Str(MV_PAR12)) + "' AND "
EndIf	

cQuery := "" 	                        
cQuery += "SELECT	ADE_CODIGO, ADF_CODSU0 "
cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE, " + RetSQLName("ADF") + " ADF "		
cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "
cQuery += "ADF_FILIAL	=	'" + xFilial("ADF") + "'	AND				"
cQuery += "ADE_CODIGO	=	ADF_CODIGO		AND "
//cQuery += "	ADE_STATUS	=	'3'				AND "	
If Type("Mv_Par14") == "N" .AND. Mv_Par14 == 2
	cQuery += "ADF_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
Else
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
EndIf

If Type("Mv_Par13") == "N" .AND. Mv_Par13 == 1
	cQuery += "ADF_CODSU0	IN " + cListSU0 + " AND "
Else
	cQuery += "ADF_CODSU0	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND								"
EndIf	

cQuery += "ADF_CODSU7	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND								"
cQuery += "ADE.D_E_L_E_T_ = ' '   					AND "
cQuery += "ADF.D_E_L_E_T_ = ' '					AND "
cQuery += cWhere + cWhereI1                                
cQuery += " GROUP BY ADF_CODSU0, ADE.ADE_CODIGO "       
cQuery := "SELECT COUNT(*) COUNT FROM (" + cQuery + ") AUX "

cQuery	:= ChangeQuery(cQuery)    	
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
If (cAliasAux)->(!EOF())
	aTot[1] := (cAliasAux)->COUNT
EndIf
(cAliasAux)->(dbCloseArea())

cQuery := ""
cQuery += "SELECT	ADE_CODIGO, ADF_CODSU0 "
cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE, " + RetSQLName("ADF") + " ADF "		
cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "
cQuery += "ADF_FILIAL	=	'" + xFilial("ADF") + "'	AND				"
cQuery += "ADE_CODIGO	=	ADF_CODIGO		AND "
//cQuery += "	ADE_STATUS	=	'3'				AND "	
If Type("Mv_Par14") == "N" .AND. Mv_Par14 == 2
	cQuery += "ADF_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
Else	
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
EndIf

If Type("Mv_Par13") == "N" .AND. Mv_Par13 == 1
	cQuery += "ADF_CODSU0	IN " + cListSU0 + " AND "
Else
	cQuery += "ADF_CODSU0	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND								"
EndIf		

cQuery += "ADF_CODSU7	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND								"
cQuery += "ADE.D_E_L_E_T_ = ' '   					AND "
cQuery += "ADF.D_E_L_E_T_ = ' '					AND "
cQuery += cWhere + cWhereI2                                
cQuery +=" GROUP BY ADF_CODSU0, ADE.ADE_CODIGO			"
cQuery := "SELECT COUNT(*) COUNT FROM (" + cQuery + ") AUX "	

cQuery	:= ChangeQuery(cQuery) 
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
If (cAliasAux)->(!EOF())
	aTot[2] := (cAliasAux)->COUNT
EndIf	                     
(cAliasAux)->(dbCloseArea())	

If aTot[1] > 0
	aTot[3] := Int(aTot[2]/aTot[1]*100)
EndIf       
	
If MV_PAR11 == 1
	cWhereESql := "%" + cWhere + "(" + cWhereI1 + ")%"	
ElseIf MV_PAR11 == 2
	cWhereESql := "%" + cWhere + "(" + cWhereI2 + ")%"	 	
Else
	cWhereESql := "%" + cWhere + "(" + cWhereI1 + " OR " + cWhereI2 + ")%"	 	 	
EndIf  	

If MV_PAR10 == 4 .OR. MV_PAR10 == 3                          
	cOrderBy := "% ADF.ADF_CODSU0, ADF.ADF_CODSU7 %"		
	cGroupBy := "% ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADE.ADE_CODIGO %"		
	cSQLFields	:= "% ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADE.ADE_CODIGO %"
ElseIf MV_PAR10 == 2                                                                                   
	cOrderBy := "% ADF.ADF_CODSU7 %"		
	cGroupBy := "% ADF.ADF_CODSU7, ADE.ADE_CODIGO %"		
	cSQLFields	:= "% ADF.ADF_CODSU7, ADE.ADE_CODIGO %"		
Else
	cOrderBy := "% ADE.ADE_CODIGO %"				
	cGroupBy := "% ADF.ADF_CODIGO %"						
	cSQLFields	:= "% ADF.ADF_CODIGO %"
EndIf	   	
			
If Type("Mv_Par13") == "N" .AND. Mv_Par13 == 1
	cListSU0E += "% ADF_CODSU0	IN " + cListSU0 + " AND "
Else
	cListSU0E += "% ADF_CODSU0	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND	"
EndIf	

If Type("Mv_Par14") == "N" .AND. Mv_Par14 == 2
	cListSU0E += "ADF_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND %"		
Else	                                                                                    
	cListSU0E += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND %"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se existir o campo ADE_HREXPI inclui na query.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cField := ", ADE_HREXPI"
cField := "%" + cField + "%"

BEGIN REPORT QUERY oSection1
BeginSQL alias cAlias1    	                      
	
	SELECT 	ADF.ADF_CODSU0,	ADE.ADE_CODIGO,	ADE.ADE_CHAVE,	ADE.ADE_DATA, 
				ADF.ADF_CODSU7,	ADE.ADE_FILIAL, ADE.ADE_ENTIDA, ADE.ADE_STATUS, ADF.COUNT COUNT,
				ADE.ADE_CODSB1,	ADE.ADE_DTEXPI  %Exp:cField%		
			
	FROM 	%table:ADE% ADE, (
				SELECT ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADE.ADE_CODIGO, COUNT(*) COUNT 
				FROM %table:ADE% ADE , %table:ADF% ADF 
				WHERE ADE_FILIAL = %xFilial:ADE% AND 
				ADF_FILIAL = %xFilial:ADF% AND 
				ADE_CODIGO = ADF_CODIGO AND 					
				%exp:cListSU0E% 
				ADF_CODSU7	BETWEEN %exp:Mv_Par07% AND %exp:Mv_Par08% AND								
				ADE.%notDel%   					AND
				ADF.%notDel%					AND
				%exp:cWhereESql%
				GROUP BY ADF.ADF_CODSU0, ADF.ADF_CODSU7, ADE.ADE_CODIGO
				//GROUP BY %exp:cGroupBy%
	) ADF
	WHERE 	ADE_FILIAL	=	%xFilial:ADE%	AND
			ADE.ADE_CODIGO	=	ADF.ADE_CODIGO		AND
			ADE.%notDel%   									
	ORDER BY %exp:cOrderBy%
	

EndSql    
END REPORT QUERY oSection1 

oSection2:SetParentQuery() 
If MV_PAR10 == 4
	oSection2:SetParentFilter({|cParam|cParam == (cAlias1)->ADF_CODSU0+(cAlias1)->ADF_CODSU7},{|| (cAlias1)->ADF_CODSU0+(cAlias1)->ADF_CODSU7})
ElseIf MV_PAR10 == 3
	oSection2:SetParentFilter({|cParam|cParam == (cAlias1)->ADF_CODSU0},{|| (cAlias1)->ADF_CODSU0})    
ElseIf MV_PAR10 == 2                                                                                   
	oSection2:SetParentFilter({|cParam|cParam == (cAlias1)->ADF_CODSU7},{|| (cAlias1)->ADF_CODSU7})    
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetLineBreak()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR09 == 1     
	If MV_PAR10 == 3
		oSection1:Cell("ADF_CODSU7"):Disable()
	ElseIf MV_PAR10 == 2
		oSection1:Cell("ADF_CODSU0"):Disable() 
	ElseIf MV_PAR10 == 1                   
		oSection1:Hide() 		
	EndIf
	oSection1:Print()
EndIf
                    
oReport:FatLine()                 
oReport:PrintText(" ")
oReport:PrintText(PadR(STR0019 + AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR03, "UT_NOME")) + ": ", 100) + PadL(AllTrim(Str(aTot[1])),10)) // "Total de chamados que atendem " # 
oReport:PrintText(PadR(STR0019 + AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR04, "UT_NOME")) + ": ", 100) + PadL(AllTrim(Str(aTot[2])),10)) // "Total de chamados que atendem "
oReport:PrintText(PadR(STR0020 + AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR04, "UT_NOME")) + STR0021 + AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR03, "UT_NOME")) + ":", 100) + PadL(AllTrim(Str(aTot[3]))+"%",10)) // "Percentual que representa " # " em relação à "

cQuery := "SELECT AUX.ADF_CODSU0, COUNT(*) COUNT FROM("
cQuery += "SELECT	ADF_CODSU0, ADF_CODIGO "
cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE, " + RetSQLName("ADF") + " ADF "		
cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "
cQuery += "ADF_FILIAL	=	'" + xFilial("ADF") + "'	AND				"
cQuery += "ADE_CODIGO	=	ADF_CODIGO		AND "
//cQuery += "	ADE_STATUS	=	'3'				AND "	
If Type("Mv_Par14") == "N" .AND. Mv_Par14 == 2
	cQuery += "ADF_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
Else		
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
EndIf

If Type("Mv_Par13") == "N" .AND. Mv_Par13 == 1
	cQuery += "ADF_CODSU0	IN " + cListSU0 + " AND "
Else
	cQuery += "ADF_CODSU0	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND								"
EndIf

cQuery += "ADF_CODSU7	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND								"
cQuery += "ADE.D_E_L_E_T_ = ' '   					AND "
cQuery += "ADF.D_E_L_E_T_ = ' '					AND "
cQuery += cWhere + cWhereI1                                
cQuery +=" GROUP BY ADF_CODSU0, ADF_CODIGO	"
cQuery +=")AUX GROUP BY ADF_CODSU0"	
		
cQuery	:= ChangeQuery(cQuery) 
// MemoWrite("TMKR001.SQL", cQuery)
cAliasAux := GetNextAlias()
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
While (cAliasAux)->(!EOF())
	aAdd(aSintetic, {	(cAliasAux)->ADF_CODSU0,;	//Cod. Grupo
						(cAliasAux)->COUNT,;		//Indicador 1
						0})							//Indicador 2

	DbSkip()
End
(cAliasAux)->(dbCloseArea())	
		
cQuery := "SELECT AUX.ADF_CODSU0, COUNT(*) COUNT FROM("
cQuery += "SELECT	ADF_CODSU0, ADF_CODIGO "
cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE, " + RetSQLName("ADF") + " ADF "		
cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "
cQuery += "ADF_FILIAL	=	'" + xFilial("ADF") + "'	AND				"
cQuery += "ADE_CODIGO	=	ADF_CODIGO		AND "
//cQuery += "	ADE_STATUS	=	'3'				AND "	
If Type("Mv_Par14") == "N" .AND. Mv_Par14 == 2
	cQuery += "ADF_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
Else		
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
EndIf	

If Type("Mv_Par13") == "N" .AND. Mv_Par13 == 1
	cQuery += "ADF_CODSU0	IN " + cListSU0 + " AND "
Else
	cQuery += "ADF_CODSU0	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND								"
EndIf	

cQuery += "ADF_CODSU7	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND								"
cQuery += "ADE.D_E_L_E_T_ = ' '   					AND "
cQuery += "ADF.D_E_L_E_T_ = ' '					AND "
cQuery += cWhere + cWhereI2         
cQuery +=" GROUP BY ADF_CODSU0, ADF_CODIGO	"
cQuery +=")AUX GROUP BY ADF_CODSU0"		                       
		
cQuery	:= ChangeQuery(cQuery) 
// MemoWrite("TMKR001.SQL", cQuery)
cAliasAux := GetNextAlias()
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
While (cAliasAux)->(!EOF())
	nPos := aScan(aSintetic, {|x|x[1]==(cAliasAux)->ADF_CODSU0})
	If nPos <= 0
		aAdd(aSintetic, {	(cAliasAux)->ADF_CODSU0,;	//Cod. Grupo
							0,;							//Indicador 1
							(cAliasAux)->COUNT})		//Indicador 2
	Else
		aSintetic[nPos,3]	:= (cAliasAux)->COUNT      //Indicador 2
	EndIf
	DbSkip()
End
(cAliasAux)->(dbCloseArea())		       
	
oReport:SkipLine()                
oReport:FatLine()                 
oReport:PrintText(" ")	
oReport:PrintText(" ")		
oReport:PrintText(STR0022)	 // "Resultados por equipes"
oReport:ThinLine()                 
oSection3:Init()
For nPos := 1 To Len(aSintetic)
	oSection3:Cell("TKCODSU0"):SetValue(AllTrim(aSintetic[nPos,1]))
	oSection3:Cell("TKDESCSU0"):SetValue(POSICIONE('SU0',1,xFilial('SU0')+aSintetic[nPos,1],'U0_NOME'))
	oSection3:Cell("TKDESCI1"):cTitle := AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR03, "UT_NOME"))
	oSection3:Cell("TKDESCI1"):SetValue(AllTrim(Str(aSintetic[nPos,2])))
	oSection3:Cell("TKDESCI2"):cTitle := AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR04, "UT_NOME"))
	oSection3:Cell("TKDESCI2"):SetValue(AllTrim(Str(aSintetic[nPos,3])))		                
	
	oSection3:Cell("TKPERCENT"):cTitle := "Participação de " + AllTrim(Posicione("SUT", 1, xFilial("SUT") + MV_PAR04, "UT_NOME")) + "(%)"		                        
	If aSintetic[nPos,2]>0
		oSection3:Cell("TKPERCENT"):SetValue(AllTrim(Str(Int(aSintetic[nPos,3]/aSintetic[nPos,2]*100)))	)	
	Else		                                                                                        
		oSection3:Cell("TKPERCENT"):SetValue("0")
	EndIf
	oSection3:PrintLine()	
Next nPos     
oSection3:Finish()

Return(.T.)

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