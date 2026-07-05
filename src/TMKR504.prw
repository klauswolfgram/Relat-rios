/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR504.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"

Static aRetPrazo := {}

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR504  ³ Autor ³ Vendas CRM            ³ Data ³ 20/07/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ BackLog do Atendimento                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMKR501(void)                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR504()

Local oReport	//Objeto relatorio TReport (Release 4) 

Private aHrsTurno := {}		//Array para guardar os turno de trabalho.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("TMKR504",.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ Mv_Par01           // De                                     ³
	//³ Mv_Par02           // Ate                                    ³
	//³ Mv_Par03           // Do Produto    		                 ³
	//³ Mv_Par04           // Até o Produto                          ³			
	//³ Mv_Par05           // Do Grupo                               ³		
	//³ Mv_Par06           // Ate o Grupo                            ³	
	//³ Mv_Par07           // Do Analista                            ³		
	//³ Mv_Par08           // Ate o Analista                         ³	
	//³ Mv_Par09           // Tipo de Relatorio                      ³		
	//³ MV_PAR10		   // Do Cliente     						 |	
	//³ MV_PAR11		   // Da Loja	     						 |	
	//³ MV_PAR12		   // Ate o Cliente   						 |	
	//³ MV_PAR13		   // Ate a Loja     						 |
	//³ Mv_Par14           // Indicador para Transferencia           ³
	//³ MV_PAR15		   // Exibe sub-equipes ?       			 |
	//³ MV_PAR16		   // Indicador (Inter. Produtivas)?		 |							
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
±±³Fun‡…o    ReportDef ³ Autor ³Vendas CRM              ³ Data ³20/07/2008³±±
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
Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2             //Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3				//Objeto secao 3 do relatorio (Totalizador)
Local cAlias1 := "ADE"     //Alias da consulta Embedded SQL
Local cTransfSQL := ""		// SQL para localizar chamados que foram transferidos
Local oBreak
Local cWhereInt := "" 		//SQL para filtrar os Indicadores (Inter. Produtivas)

#IFDEF TOP
	cAlias1	:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF
                            
// "BackLog de Atendimento" # // "Este programa ira emitir uma relacao dos chamados por equipes." #
// "A emissao ocorrera baseada nos parametros do relatorio"
DEFINE REPORT oReport NAME "TMKR504" TITLE STR0001 PARAMETER "TMKR504" ACTION {|oReport| Tkr504PrtRpt( oReport, cAlias1, @cTransfSQL, @cWhereInt )} DESCRIPTION STR0002 + STR0003
oReport:setLandscape()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport 	TITLE STR0004 TABLES "ADE"   	  		// "Equipes"
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0005 TABLES "ADE" LINE BREAK  	// "Chamados"
DEFINE SECTION oSection3 OF oReport 	TITLE STR0006 TABLES ""   		  		// "Totalizado Sintético"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_GRUPO"	OF oSection1 ALIAS "ADE" 
DEFINE CELL NAME "ADE_DESCGP"	OF oSection1 ALIAS "ADE" BLOCK {||POSICIONE('SU0',1,xFilial('SU0')+(cAlias1)->ADE_GRUPO,'U0_NOME')} SIZE 40

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_CODIGO"	OF oSection2 ALIAS "ADE" SIZE 10	
DEFINE CELL NAME "ADE_CHAVE"	OF oSection2 ALIAS "ADE" SIZE 15 TITLE STR0007 // "Cliente" 
DEFINE CELL NAME "ADE_DESCCH"	OF oSection2 ALIAS "ADE" TITLE STR0008 BLOCK {||FATPDObfuscate(TKENTIDADE((cAlias1)->ADE_ENTIDA,(cAlias1)->ADE_CHAVE,1),"ADE_DESCCH",Nil,.T.)} AUTO SIZE // "Descrição"
DEFINE CELL NAME "ADE_NMPROD" 	OF oSection2 ALIAS "ADE" BLOCK {||POSICIONE('SB1',1,XFILIAL('SB1') +(cAlias1)->ADE_CODSB1, 'B1_DESC')}	      
DEFINE CELL NAME "ADE_DATA" 	OF oSection2 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_HORA" 	OF oSection2 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_DTEXPI" 	OF oSection2 ALIAS "ADE" 
DEFINE CELL NAME "ADE_HREXPI" 	OF oSection2 ALIAS "ADE" 

DEFINE CELL NAME "TKEQTRANSF"	OF oSection2 ALIAS "" 	 TITLE STR0009 	BLOCK {||TkUltIter(3, (cAlias1)->ADE_CODIGO, cTransfSQL, (cAlias1)->ADE_DATA)} AUTO SIZE // "Equipe que transferiu"
DEFINE CELL NAME "TKDTTRANSF"	OF oSection2 ALIAS "" 	 TITLE STR0010	BLOCK {||TkUltIter(4, (cAlias1)->ADE_CODIGO, cTransfSQL)}  AUTO SIZE // "Dt transferência"

DEFINE CELL NAME "ADE_STATUS" 	OF oSection2 ALIAS "ADE" AUTO SIZE//SIZE 15	      
DEFINE CELL NAME "ADE_OPERAD"	OF oSection2 ALIAS "ADE" TITLE STR0011 	BLOCK{||TRIM((cAlias1)->ADE_OPERAD + " - " + FATPDObfuscate(POSICIONE('SU7',1,XFILIAL('SU7') + (cAlias1)-> ADE_OPERAD, 'U7_NOME'),"U7_NOME",Nil,.T.))} AUTO SIZE  // "Analista"
DEFINE CELL NAME "TKULTITER"	OF oSection2 ALIAS ""	 TITLE STR0012 BLOCK {|| aRetPrazo := TKR504CalcPrazo((cAlias1)->ADE_CODIGO,(cAlias1)->ADE_GRUPO,(cAlias1)->K5_CODSLA,(cAlias1)->K5_PAUSED,cWhereInt), If(!Empty(aRetPrazo),aRetPrazo[1][1],.T.) }  AUTO SIZE // "Ult Interação"
DEFINE CELL NAME "TKPRZITER"	OF oSection2 ALIAS ""	 TITLE STR0013 AUTO SIZE BLOCK {|| If(!Empty(aRetPrazo),aRetPrazo[1][2],.T.) }  // "Prazo sem atendimento"
	
DEFINE CELL NAME "TKENTRESP" 	OF oSection2 ALIAS "" SIZE 40 Title STR0022 BLOCK {||TkEntidade((cAlias1)->ADE_ENTREP,(cAlias1)->ADE_CHVREP,1)} //"Entidade Resp."
DEFINE CELL NAME "TKCNTRESP" 	OF oSection2 ALIAS "" SIZE 30 Title STR0023 BLOCK {||FATPDObfuscate(Posicione("SU5",1,xFilial("SU5")+(cAlias1)->ADE_CODREP,"U5_CONTAT"),"U5_CONTAT",Nil,.T.)} //"Contato Resp."
DEFINE CELL NAME "ADE_DDDREP" 	OF oSection2 ALIAS "ADE" 
DEFINE CELL NAME "ADE_TELREP" 	OF oSection2 ALIAS "ADE" 

DEFINE BREAK oBreak OF oSection1 WHEN oSection2:Cell("ADE_CODIGO")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )
oSection1:SetLineBreak()

DEFINE FUNCTION FROM oSection2:Cell("ADE_CODIGO") FUNCTION COUNT BREAK oBreak NO END SECTION NO END REPORT TITLE STR0014 // "Total de Chamados "

DEFINE CELL NAME "TKTOTAREA" 	OF oSection3 ALIAS "" TITLE STR0015 SIZE 10	      // "Equipe"
DEFINE CELL NAME "TKDESCSU0" 	OF oSection3 ALIAS "" TITLE STR0016 SIZE 30	      // "Nome"
DEFINE CELL NAME "TKTOTABERTOS" 	OF oSection3 ALIAS "" TITLE STR0017				// "Qtde de chamados em aberto" 	      
DEFINE CELL NAME "TKTOTATEND" 	OF oSection3 ALIAS "" TITLE STR0018				// "Qtde de interações"	      
DEFINE CELL NAME "TKTOTCLIENT" 	OF oSection3 ALIAS "" TITLE STR0019				// "% Cliente"	      
DEFINE CELL NAME "TKTOTANALIST" 	OF oSection3 ALIAS "" TITLE STR0020			// "% Analista"	      

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
Static Function Tkr504PrtRpt(oReport, cAlias1, cTransfSQL, cWhereInt)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3 := oReport:Section(2)		//Objeto secao 1 do relatorio (Totalizador)
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF
Local cAliasAux := GetNextAlias()			//Alias auxiliar para recuperar os itens do indicador 
Local aSintetic	:= {}     
Local cWhere	:= ""
Local cWhereSQL := ""						//Armazena a query SQL Ansi
Local nPos		:= 0
Local cSQLCampos:= ""   
Local cListSU0  := FormatIn( Tkr501SelGp(Mv_Par05, Mv_Par06), ",")
Local cListSU0E := ""
Private aHrsTurno := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega os indicadores de interação produtivas.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
cWhereInt := GetIndicSQL(MV_PAR16)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("ADE")
While 	SX3->(!Eof()) 														.AND.;
		SX3->X3_ARQUIVO == "ADE"

		If SX3->X3_CONTEXT == "R" 
			If Empty(cSQLCampos)
				cSQLCampos += "ADE." + AllTrim(SX3->X3_CAMPO)
			Else
				cSQLCampos += ",ADE." + AllTrim(SX3->X3_CAMPO)
			EndIf
		EndIf
		SX3->(DbSkip())		
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR504")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a lista de Ocorrências x Acoes listadas no indicador                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery := "SELECT 	UU_CODSU9,	UU_CODSUQ,	UU_CODSUT,	UU_FILIAL		" 
cQuery += "FROM "+RetSqlName("SUU")+" SUU  WHERE "
cQuery += "SUU.UU_FILIAL = '" + xFilial("SUU") + "' AND "
cQuery += "SUU.UU_CODSUT = '" + MV_PAR14 + "' AND "
cQuery += "SUU.D_E_L_E_T_  = '' "
cQuery += "ORDER BY SUU.UU_CODSUT "	    

cQuery	:= ChangeQuery(cQuery)
// MemoWrite("TMKR001.SQL", cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)	

cTransfSQL := ""

While (cAliasAux)->(!EOF()) .AND.;
	(cAliasAux)->UU_FILIAL == xFilial("SUU") .AND.;
	(cAliasAux)->UU_CODSUT	== MV_PAR14
	
	If !Empty(cTransfSQL)
		cTransfSQL += " OR ("		
	Else	                       
		cTransfSQL += " ("
	EndIf        
															
	If !Empty((cAliasAux)->UU_CODSU9)
		cTransfSQL += " ADF.ADF_CODSU9 = '" + (cAliasAux)->UU_CODSU9 + "' "
	EndIf
	If !Empty((cAliasAux)->UU_CODSU9) .AND. !Empty((cAliasAux)->UU_CODSUQ)
		cTransfSQL += " AND ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	ElseIf !Empty((cAliasAux)->UU_CODSUQ)
		cTransfSQL += " ADF.ADF_CODSUQ = '" + (cAliasAux)->UU_CODSUQ + "') "
	Else          
		cTransfSQL += ")"	   	
	EndIf	   		   	
	(cAliasAux)->(dbSkip())
End         	                                       
(cAliasAux)->(dbCloseArea())
If !Empty(cTransfSQL)
	cTransfSQL := "(" + cTransfSQL + ")"	
Else
	cTransfSQL := ""	
EndIf 	      


cWhere := " ADE_STATUS IN('1','2') AND "

If !Empty(MV_PAR10) .OR. (!Empty(MV_PAR12) .AND. MV_PAR12 <> "ZZZZZZ")
	cWhere += "ADE_CHAVE BETWEEN '" + MV_PAR10+MV_PAR11 + "' AND '" + MV_PAR12+MV_PAR13 + "' AND "
	cWhere += "ADE_ENTIDA 	= 'SA1' AND "                    	     			
EndIf	                                                
cWhereSQL := cWhere
cWhere	:= "%" + cWhere + "%"

cSQLCampos := cSQLCampos + ", SK5.K5_FILIAL, SK5.K5_CODSLA, SK5.K5_PAUSED "

cSQLCampos := "%" + cSQLCampos + "%"	

If Type("Mv_Par15") == "N" .AND. Mv_Par15 == 1
	cListSU0E += "% ADE_GRUPO	IN " + cListSU0 + " AND %"
Else
	cListSU0E += "% ADE_GRUPO	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND		%"
EndIf		

BEGIN REPORT QUERY oSection1
BeginSQL alias cAlias1                         
	SELECT %exp:cSQLCampos%
	FROM %table:ADE% ADE LEFT JOIN %table:SK5% SK5 
	ON(	ADE.ADE_REGSLA = SK5.K5_CODIGO AND 
		SK5.K5_FILIAL = %xFilial:SK5% AND 
		SK5.%notDel% ) 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		%exp:cWhere%			                						
		ADE_DATA	BETWEEN %exp:DtoS(Mv_Par01)% AND %exp:DtoS(Mv_Par02)% AND
		ADE_CODSB1	BETWEEN %exp:Mv_Par03% AND %exp:Mv_Par04% AND
		%exp:cListSU0E%
		ADE_OPERAD	BETWEEN %exp:Mv_Par07% AND %exp:Mv_Par08% 									
	ORDER BY ADE_GRUPO, ADE_STATUS 				

EndSql    
END REPORT QUERY oSection1

TCSetField(cAlias1, "K5_PAUSED", "L")

oSection2:SetParentQuery() 
oSection2:SetParentFilter({|cParam|cParam == (cAlias1)->ADE_GRUPO},{|| (cAlias1)->ADE_GRUPO})    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR09 == 1     
	//Carrega os turnos de trabalho
	TKR504HrsTurnos(@aHrsTurno) 
	
	oSection1:SetLineBreak()
	oSection1:Print()       
EndIf

#IFDEF TOP 
	cQuery := ""
	                                  
	If !Empty(oSection1:GetSqlExp())
		cWhereSQL += oSection1:GetSqlExp() + " AND "
	EndIf
    
	cQuery += "SELECT AUX.ADE_GRUPO, COUNT(*) TOT_CHAMA, SUM(AUX.TOT_ATEND) TOT_ATEND FROM ("
	cQuery += "SELECT	ADE_GRUPO, ADE_CODIGO,COUNT(*) TOT_ATEND "
	cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE LEFT JOIN " + RetSQLName("ADF") + " ADF "		
	cQuery += "ON( ADF_FILIAL	=	'" + xFilial("ADF") + "'	AND				"
	cQuery += "ADE.ADE_CODIGO = ADF.ADF_CODIGO AND "
	cQuery += "ADF.D_E_L_E_T_ = '' AND "
	cQuery += "ADE.ADE_GRUPO = ADF.ADF_CODSU0 )"		
	cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "	
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
	cQuery += "ADE_CODSB1	BETWEEN '" + Mv_Par03 + "' AND '" + Mv_Par04 + "' AND	"
	
	If Type("Mv_Par15") == "N" .AND. Mv_Par15 == 1
		cQuery += " ADE_GRUPO	IN " + cListSU0 + " AND "
	Else
		cQuery += " ADE_GRUPO	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND		"
	EndIf			
	
	cQuery += "ADE_OPERAD	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND " 										
	cQuery += cWhereSQL 	
	cQuery += "ADE.D_E_L_E_T_ = ''   "
	cQuery +=" GROUP BY ADE_GRUPO, ADE_CODIGO"
	cQuery +=" ) AUX	"                                    
	cQuery +=" GROUP BY AUX.ADE_GRUPO	"

	       
	cQuery	:= ChangeQuery(cQuery) 
	// MemoWrite("TMKR001.SQL", cQuery)
	cAliasAux := GetNextAlias()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
	If (cAliasAux)->(!EOF())
		While (cAliasAux)->(!EOF())
			nPos := aScan(aSintetic, {|x|x[1]==(cAliasAux)->ADE_GRUPO})
			If nPos <= 0
				aAdd(aSintetic, {	(cAliasAux)->ADE_GRUPO,;	//Cod. Grupo
									(cAliasAux)->TOT_CHAMA,;	//Em aberto
									(cAliasAux)->TOT_ATEND,;	//Atendimento							
									0,;							//Qtde de Recursos
									0,;							//Qtde de Abertos por clientes
									0})							//Qtde de Abertos por analistas
			EndIf                    
			DbSkip()
		End
	EndIf  
	(cAliasAux)->(dbCloseArea())		                                               
	
	cQuery := ""
                                                                                       
    
    //Obtem a qtde de recursos que trabalharam na equipe
    
	//Obtem o numero de chamados abertos por cliente e analista
	cQuery += "SELECT	ADE_GRUPO, ADE_TECNIC,COUNT(*) TOT_ATEND "
	cQuery += "FROM 	"+ RetSqlName("ADE") + " ADE "		
	cQuery += "WHERE 	ADE_FILIAL	=	'" + xFilial("ADE") + "'	AND "	
	cQuery += "ADE_DATA	BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND "
	cQuery += "ADE_CODSB1	BETWEEN '" + Mv_Par03 + "' AND '" + Mv_Par04 + "' AND	"
	
	If Type("Mv_Par15") == "N" .AND. Mv_Par15 == 1
		cQuery += " ADE_GRUPO	IN " + cListSU0 + " AND "
	Else
		cQuery += " ADE_GRUPO	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND		"
	EndIf			
	
	cQuery += "ADE_OPERAD	BETWEEN '" + Mv_Par07 + "' AND '" + Mv_Par08 + "' AND " 										
	cQuery += cWhereSQL 	
	cQuery += "ADE.D_E_L_E_T_ = ''   "
	cQuery +=" GROUP BY ADE_GRUPO, ADE_TECNIC"
	       
	cQuery	:= ChangeQuery(cQuery) 
	// MemoWrite("TMKR001.SQL", cQuery)
	cAliasAux := GetNextAlias()
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
	If (cAliasAux)->(!EOF())
		While (cAliasAux)->(!EOF())
			nPos := aScan(aSintetic, {|x|x[1]==(cAliasAux)->ADE_GRUPO})
			If nPos <= 0
				aAdd(aSintetic, {	(cAliasAux)->ADE_GRUPO,;	//Cod. Grupo
									0,;	//Em aberto
									0,;	//Atendimento							
									0,;							//Qtde de Recursos
									0,;							//Qtde de Abertos por clientes
									0})							//Qtde de Abertos por analista			
			EndIf       
			If Empty((cAliasAux)->ADE_TECNIC)
				aSintetic[nPos,5] += (cAliasAux)->TOT_ATEND	
			Else
				aSintetic[nPos,6] += (cAliasAux)->TOT_ATEND	
			EndIf                    
			DbSkip()
		End
	EndIf  
	(cAliasAux)->(dbCloseArea())		                                               	
	
	oReport:SkipLine()                
	oReport:FatLine()                 
	oReport:PrintText(" ")	
	oReport:PrintText(" ")		
	oReport:PrintText(STR0021)	 // "Resultados por equipes"
	oReport:ThinLine()                 
	oSection3:Init()
	For nPos := 1 To Len(aSintetic)
		oSection3:Cell("TKTOTAREA"):SetValue(AllTrim(aSintetic[nPos,1]))
		oSection3:Cell("TKDESCSU0"):SetValue(POSICIONE('SU0',1,xFilial('SU0')+aSintetic[nPos,1],'U0_NOME'))
		oSection3:Cell("TKTOTABERTOS"):SetValue(AllTrim(Str(aSintetic[nPos,2])))
		oSection3:Cell("TKTOTATEND"):SetValue(AllTrim(Str(aSintetic[nPos,3])))		                                        
		oSection3:Cell("TKTOTCLIENT"):SetValue(AllTrim(Str(Int(aSintetic[nPos,5]/aSintetic[nPos,2]*100))))		                                        		
		oSection3:Cell("TKTOTANALIST"):SetValue(AllTrim(Str(Int(aSintetic[nPos,6]/aSintetic[nPos,2]*100))))		                                        				
		oSection3:PrintLine()	
	Next nPos     
	oSection3:Finish()    	

#ENDIF     

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TKR504HrsTurnos³ Autor ³Vendas CRM        ³ Data ³27/10/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna um array com os turnos de trabalho e a média de	  ³±±
±±³          ³ horas.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TKR504HrsTurnos()                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR504		                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function TKR504HrsTurnos()

Local cQuery 	 := ""
Local cAliasAux  := GetNextAlias()

cQuery := "SELECT PJ_TURNO, (SUM(PJ_HRTOTAL) / COUNT(*)) HRS_TURNO "
cQuery += "FROM "+ RetSqlName("SPJ") + " SPJ "		
cQuery += "WHERE SPJ.PJ_FILIAL	= '" + xFilial("SPJ") + "'	AND " 
cQuery += "SPJ.PJ_HRTOTAL > 0  AND "
cQuery += "SPJ.D_E_L_E_T_ = '' "
cQuery += "GROUP BY SPJ.PJ_TURNO"
       
cQuery	  := ChangeQuery(cQuery) 
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)

While (cAliasAux)->(!Eof())
	aAdd(aHrsTurno,{(cAliasAux)->PJ_TURNO,(cAliasAux)->HRS_TURNO})	
	(cAliasAux)->(dbSkip())
EndDo                                

If Select(cAliasAux) > 0
	(cAliasAux)->(dbCloseArea())
EndIf		

Return aHrsTurno
           
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³TKR504CalcPrazo³ Autor ³Vendas CRM        ³ Data ³27/10/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula o prazo sem atendimento, considerando o turno de   ³±±
±±³          ³ trabalho ou não.                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TKR504CalcPrazo()                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TMKR504		                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function TKR504CalcPrazo(cCodigo,cGrupo,cCodSLA,lPaused,cWhereInt)

Local oSLARegister:= SLARegister():New()	// Classe de SLA, utilizado no calculo da diferença de tempo
Local cQuery 	  := ""	
Local cAliasAux   := ""
Local cAliasSPJ   := ""
Local cTurno 	  := ""
Local cTurnoGrupo := ""
Local dDataInter  := STOD("  /  /  ")
Local cHoraInter  := ""
Local cPrazo	  := ""
Local nTotHrs	  := 0
Local nDias		  := 0
Local nHoras	  := 0
Local nMinutos	  := 0
Local nMediaHrs	  := 0
Local aRet		  := {}
 
If !lPaused
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Pega a data e hora da última interação do chamado. ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQuery := "SELECT ADF.ADF_DATA DATA_INTER, ADF.ADF_HORA HORA_INTER "
	cQuery += "FROM "+ RetSqlName("ADF") + " ADF "		
	cQuery += "INNER JOIN( SELECT MAX(ADF_ITEM) ITEM "
	cQuery += "FROM "+ RetSqlName("ADF") + " ADF "
	cQuery += "WHERE ADF.ADF_FILIAL	= '" + xFilial("ADF") + "'	AND " 
	cQuery += cWhereInt + " AND " 
	cQuery += "ADF.ADF_CODIGO =	'" + cCodigo + "' AND "	
	cQuery += "ADF.D_E_L_E_T_ = '' ) "
	cQuery += "RECNO ON(ADF.ADF_ITEM = RECNO.ITEM ) "
	cQuery += "WHERE ADF.ADF_FILIAL	= '" + xFilial("ADF") + "'	AND " 
	cQuery += "ADF.ADF_CODIGO =	'" + cCodigo + "' AND "	
	cQuery += "ADF.D_E_L_E_T_ = '' "
     
	cQuery	  := ChangeQuery(cQuery) 
	cAliasAux := GetNextAlias()
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)		
	
	TCSetField(cAliasAux, "DATA_INTER", "D")
	
	If (cAliasAux)->(!Eof())
		dDataInter := (cAliasAux)->DATA_INTER
		cHorainter := (cAliasAux)->HORA_INTER
		// Verifica se existe turno cadastrado no grupo, caso contrário, pega do contrato de SLA.
		If !Empty(cGrupo)
			dbSelectArea("SU0")
			dbSetOrder(1)
			If SU0->(dbSeek(xFilial("SU0")+cGrupo)) .And. !Empty(SU0->U0_TURNO)
				cTurnoGrupo := SU0->U0_TURNO
			EndIf
		EndIf				    	
		If !Empty(cTurnoGrupo) 
			cTurno := cTurnoGrupo
		Else
			cTurno := oSLARegister:getTimeShift(cCodSLA)
			If Empty(cTurno)
				cTurno := ""
			EndIf
		EndIf	
		//Busca a média de horas do turno.
		If !Empty(cTurno) .And. !Empty(aHrsTurno)
			nPos := aScan(aHrsTurno,{|x| x[1] == cTurno })
			If nPos > 0
				nMediaHrs := aHrsTurno[nPos][2]
			EndIf
		EndIf
		oDTIni   := TMKDateTime():this(dDataInter, cHorainter)
		oDTFim   := TMKDateTime():this(Date(), Time())
	
		//Retorna o total de horas, considerando o turno ou não.
		nTotHrs	 := Abs(oSLARegister:getTimeElapsed(oDTIni, oDtFim, cTurno))
	
		nDias	 := Int(nTotHrs / IIf(Empty(cTurno),24,nMediaHrs))
		nHoras	 := (nTotHrs - (nDias * IIf(Empty(cTurno),24,nMediaHrs)))
	    nMinutos :=	nHoras - Int(nHoras)
	    nMinutos :=	Int(nMinutos * 60)																	
		cPrazo   := IIf(nDias<10,"0","")+AllTrim(Str(nDias))+"d "+IIf(nHoras<10,"0","")+AllTrim(Str(Int(nHoras)))+"h "+IIf(nMinutos<10,"0","")+AllTrim(Str(nMinutos))+"m"		
	Else
   		cPrazo   := "00d 00h 00m"
	EndIf                                          
	If Select(cAliasAux) > 0
		(cAliasAux)->(dbCloseArea())
	EndIf	
Else
	cPrazo := "00d 00h 00m"
EndIf

aAdd(aRet,{DtoC(dDataInter),cPrazo})

Return (aRet)  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetIndicSQL ºAutor  ³Microsiga         º Data ³  04/11/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna as condicoes da query para atender o indicador.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR504                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetIndicSQL(cCodIndic,cAliasName)

Local cWhere 	:= "" 
Local cQuery	:= ""
Local cAlias	:= GetNextAlias()  

DEFAULT cAliasName := "ADF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a lista de Ocorrências x Acoes listadas no indicador 1	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery := ""
cQuery := "SELECT 	UU_CODSU9,	UU_CODSUQ,	UU_CODSUT,	UU_FILIAL		" 
cQuery += "FROM "+RetSqlName("SUU")+" SUU  WHERE "
cQuery += "SUU.UU_FILIAL = '" + xFilial("SUU") + "' AND "
cQuery += "SUU.UU_CODSUT = '" + cCodIndic + "' AND "
cQuery += "SUU.D_E_L_E_T_<>'*' "
cQuery += "ORDER BY SUU.UU_CODSUT "	    

cQuery	:= ChangeQuery(cQuery)
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAlias, .F., .T.)	

While	(cAlias)->(!EOF()) .AND.;     
		(cAlias)->UU_FILIAL == xFilial("SUU") .AND.;
		(cAlias)->UU_CODSUT	== cCodIndic
	
	If !Empty(cWhere)
		cWhere += " OR ("		
	Else	                       
	   	cWhere += " ("
	EndIf        
   	                                                        
   	If !Empty((cAlias)->UU_CODSU9)
   		cWhere += " " + cAliasName + ".ADF_CODSU9 = '" + (cAlias)->UU_CODSU9 + "' "
   	EndIf
   	If !Empty((cAlias)->UU_CODSU9) .AND. !Empty((cAlias)->UU_CODSUQ)
   		cWhere += " AND " + cAliasName + ".ADF_CODSUQ = '" + (cAlias)->UU_CODSUQ + "') "
   	ElseIf !Empty((cAlias)->UU_CODSUQ)
   		cWhere += " " + cAliasName + ".ADF_CODSUQ = '" + (cAlias)->UU_CODSUQ + "') "
   	Else          
   		cWhere += ")"	   	
   	EndIf	   		   	
	(cAlias)->(DbSkip())
End         	                                       
(cAlias)->(DbCloseArea())

If !Empty(cWhere)
   	cWhere := " (" + cWhere + ") "	
Else
	cWhere := " (1=1) "	
EndIf     	

Return cWhere  

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