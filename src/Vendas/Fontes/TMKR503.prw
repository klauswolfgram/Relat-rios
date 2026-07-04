/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR503.CH"
#INCLUDE "REPORT.CH"

Static cAtrasoHrs  := ""

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR503  ³ Autor ³ Vendas CRM            ³ Data ³ 20/07/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ EXTRATO DE SLA                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ TMKR501(void)                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR503()
Local oReport	//Objeto relatorio TReport (Release 4)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("TMKR503",.F.)
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
	//³ MV_PAR10		   // Status         						 |
	//³ MV_PAR11		   // Do Cliente     						 |	
	//³ MV_PAR12		   // Da Loja	     						 |	
	//³ MV_PAR13		   // Ate o Cliente   						 |	
	//³ MV_PAR14		   // Ate a Loja     						 |				
	//³ MV_PAR15		   // Exibe sub-equipes ?       			 |		
	//³ MV_PAR16		   // Exibe pausa ? 		      			 |		
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
±±³Fun‡…o    ³TKR502RptDef ³ Autor ³Vendas CRM          ³ Data ³20/07/2008³±±
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
Local oSection1    		       		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2             		//Objeto secao 2 do relatorio (Produto)
Local oSection3     		        //Objeto secao 3 do relatorio (Itens, campos da tabela SU2)
Local oSection4						//Objeto secao 4 do relatorio (Totalizador) 
Local oSection5						//Objeto secao 5 do relatorio (Registros de SLA) 
Local cAlias1	:= GetNextAlias()	// Pega o proximo Alias Disponivel
Local oBreak

// "Extrato de SLA" # "Este relatório deverá exibir o extrato de SLA dos chamados registrados no sistema."
DEFINE REPORT oReport NAME "TMKR503" TITLE STR0001 PARAMETER "TMKR503" ACTION {|oReport| Tkr503PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002

oReport:SetLandScape(.T.)	//Imprime no modo retrato

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport 	TITLE STR0003 TABLES "ADE" PAGE BREAK   // "Equipes"
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0004 TABLES "ADE"   			// "Produto"
DEFINE SECTION oSection3 OF oSection2 	TITLE STR0005 TABLES "ADE", "SK5" 		// "Chamados"             
DEFINE SECTION oSection5 OF oSection3	TITLE STR0031 TABLES ""					// "Registros de SLA"
DEFINE SECTION oSection4 OF oReport 	TITLE STR0006 TABLES ""   				// "Totalizado Sintético"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_GRUPO"	OF oSection1 ALIAS "ADE" 
DEFINE CELL NAME "ADE_DESCGP"	OF oSection1 ALIAS "ADE" BLOCK {||POSICIONE('SU0',1,xFilial('SU0')+(cAlias1)->ADE_GRUPO,'U0_NOME')} SIZE 40
                                                    
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao2³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_CODSB1" 	OF oSection2 ALIAS "ADE"
DEFINE CELL NAME "ADE_NMPROD" 	OF oSection2 ALIAS "ADE" BLOCK {||POSICIONE('SB1',1,XFILIAL('SB1') +(cAlias1)->ADE_CODSB1, 'B1_DESC')}	      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao3³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "ADE_CODIGO"	OF oSection3 ALIAS "ADE" 
DEFINE CELL NAME "ADE_CHAVE"	OF oSection3 ALIAS "ADE"  TITLE STR0007 // "Cliente" 
DEFINE CELL NAME "ADE_DESCCH"	OF oSection3 ALIAS "ADE"  TITLE STR0008 BLOCK {||FATPDObfuscate(TKENTIDADE((cAlias1)->ADE_ENTIDA,(cAlias1)->ADE_CHAVE,1),"U7_NOME",,.T.)} // "Descrição"
DEFINE CELL NAME "ADE_DATA" 	OF oSection3 ALIAS "ADE" 	      
DEFINE CELL NAME "ADE_HORA" 	OF oSection3 ALIAS "ADE" 	      
DEFINE CELL NAME "ADE_DTEXPI" 	OF oSection3 ALIAS "ADE" 
DEFINE CELL NAME "ADE_HREXPI" 	OF oSection3 ALIAS "ADE" 
DEFINE CELL NAME "TKATRASO"		OF oSection3 ALIAS ""	 TITLE STR0009  // "Atrasado"
DEFINE CELL NAME "TKATRASODIAS"	OF oSection3 ALIAS ""	 TITLE STR0032  // "Atraso"
DEFINE CELL NAME "TKPERCSLA"	OF oSection3 ALIAS ""	 TITLE STR0039 PICTURE "@E 99999.99" BLOCK {||nPerc:=0,RetSlaStatus((cAlias1)->ADE_REGSLA,,@nPerc),nPerc} SIZE 8 //% SLA
DEFINE CELL NAME "ADE_STATUS" 	OF oSection3 ALIAS "ADE" 	      
DEFINE CELL NAME "ADE_OPERAD"	OF oSection3 ALIAS "ADE" SIZE 30 TITLE STR0011 	BLOCK {||TRIM((cAlias1)->ADE_OPERAD + " - " + FATPDObfuscate(POSICIONE('SU7',1,XFILIAL('SU7') + (cAlias1)-> ADE_OPERAD, 'U7_NOME'),"U7_NOME",,.T.))} // "Analista"
DEFINE CELL NAME "K5_CODRESP" 	OF oSection3 ALIAS "ADE" TITLE STR0012 // "Resp. SLA"	      
DEFINE CELL NAME "TKRESPSLA" 	OF oSection3 ALIAS "" 	 TITLE STR0013 BLOCK {||FATPDObfuscate(POSICIONE('SK8',1,xFilial('SK8')+(cAlias1)->K5_CODRESP,'K8_NOME'),"K8_NOME",,.T.)} // "Nome Resp. SLA"
DEFINE CELL NAME "ADE_FNC" 		OF oSection3 ALIAS "ADE"	      
DEFINE CELL NAME "ADE_FNCREV" 	OF oSection3 ALIAS "ADE"  	
DEFINE CELL NAME "TKENTRESP" 	OF oSection3 ALIAS "" SIZE 40 Title STR0040 BLOCK {||TkEntidade((cAlias1)->ADE_ENTREP,(cAlias1)->ADE_CHVREP,1)} //"Entidade Resp."
DEFINE CELL NAME "TKCNTRESP" 	OF oSection3 ALIAS "" SIZE 30 Title STR0041 BLOCK {||FATPDObfuscate(Posicione("SU5",1,xFilial("SU5")+(cAlias1)->ADE_CODREP,"U5_CONTAT"),"U5_CONTAT",,.T.)} //"Contato Resp."
DEFINE CELL NAME "ADE_DDDREP" 	OF oSection3 ALIAS "ADE" 
DEFINE CELL NAME "ADE_TELREP" 	OF oSection3 ALIAS "ADE" 

DEFINE CELL NAME "TKDPSEUL"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0033  BLOCK {||DtoC((cAlias1)->ADE_DPSEUL)} //"Dt. Ul Pausa SLA"
DEFINE CELL NAME "TKHPSEUL"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0034  BLOCK {||(cAlias1)->ADE_HPSEUL} //"Hr. Ul Pausa SLA"
DEFINE CELL NAME "TKDENCSL"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0035  BLOCK {||DtoC((cAlias1)->ADE_DENCSL)} //"Dt.Enc SLA"
DEFINE CELL NAME "TKHENCSL"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0036  BLOCK {||(cAlias1)->ADE_HENCSL} //""Hr.Enc SLA""
DEFINE CELL NAME "TKDENCCH"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0037  BLOCK {||DtoC((cAlias1)->ADE_DENCSL)} //"Dt.Enc SLA"
DEFINE CELL NAME "TKHENCSH"		OF oSection3 ALIAS ""	 SIZE 12  TITLE STR0038  BLOCK {||(cAlias1)->ADE_HENCSL} //""Hr.Enc SLA""

DEFINE CELL NAME "TKSLADTINI" 	OF oSection5 ALIAS "" TITLE STR0026 // "Data Inicio"  
DEFINE CELL NAME "TKSLAHRINI" 	OF oSection5 ALIAS "" TITLE STR0027 // "Hora Inicio"    
DEFINE CELL NAME "TKSLADTFIM" 	OF oSection5 ALIAS "" TITLE STR0028 // "Data Fim"    
DEFINE CELL NAME "TKSLAHRFIM" 	OF oSection5 ALIAS "" TITLE STR0029 // "Hora Fim"    
DEFINE CELL NAME "TKSLADUR" 	OF oSection5 ALIAS "" TITLE STR0030 // "Duração"    	      

DEFINE BREAK oBreak OF oSection1 WHEN oSection3:Cell("ADE_CODIGO")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )
oSection1:SetLineBreak() 
oSection3:SetLineBreak() 

DEFINE FUNCTION FROM oSection3:Cell("ADE_CODIGO") FUNCTION COUNT BREAK oBreak NO END SECTION NO END REPORT TITLE STR0014

DEFINE CELL NAME "TKTOTAREA" 	OF oSection4 ALIAS "" TITLE STR0015 SIZE 10	      		// "Equipe"
DEFINE CELL NAME "TKDESCSU0" 	OF oSection4 ALIAS "" TITLE STR0016 SIZE 30	      		// "Nome"
DEFINE CELL NAME "TKTOTATRASO" 	OF oSection4 ALIAS "" TITLE STR0017	      				// "Qtde de chamados em atraso"
DEFINE CELL NAME "TKTOTEMDIA" 	OF oSection4 ALIAS "" TITLE STR0018						// "Qtde de chamados em dia"	      
DEFINE CELL NAME "TKTOTCHAMA" 	OF oSection4 ALIAS "" TITLE STR0019						// "Qtde total de chamados"	      

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
Static Function Tkr503PrtRpt(oReport, cAlias1)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3 := oSection2:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection4 := oReport:Section(2)		//Objeto secao 1 do relatorio (Totalizador)                
Local oSection5 := oSection3:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF
Local cAliasAux := GetNextAlias()			//Alias auxiliar para recuperar os itens do indicador 
Local aSintetic	:= {}     
Local cWhere	:= ""
Local cWhereSQL := ""						//Armazena a query SQL Ansi
Local nPos		:= 0  
Local cListSU0  := FormatIn( Tkr501SelGp(Mv_Par05, Mv_Par06), ",")
Local cListSU0E := ""       
Local bSQLS5	:= {||}
Local cGrupo	:= ""     
Local cSLAList	:= "" 
Local oSLARegister := SLARegister():New()	// Classe de SLA, utilizado no calculo da diferença de tempo
Local cTurnoGrupo := ""
Local cTurno	:= ""
Local dDtFim	:= STOD("  /  /  ")
Local cHrFim	:= ""
Local cSelCpos	:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR503")      

cSelCpos := "ADE_GRUPO, ADE_CODSB1, ADE_CODIGO, ADE_REGSLA, ADE_DATA, ADE_HORA, ADE_ENTIDA, ADE_CHAVE, ADE_OPERAD, ADE_STATUS, ADE_DTEXPI, ADE_FNC, ADE_FNCREV"

cSelCpos += ", ADE_HREXPI"

cSelCpos += ", ADE_CODREP,ADE_ENTREP,ADE_CHVREP,ADE_DDDREP,ADE_TELREP"

cSelCpos += ", K5_CODIGO, K5_DTENCER, K5_STATUS, K5_CODANT, K5_PAUSED, K5_DTATUA, K5_HRATUA, K5_CODRESP"

cSelCpos += ", ADE_DPSEUL, ADE_HPSEUL, ADE_DENCSL, ADE_HENCSL "

cSelCpos := "%" + cSelCpos + "%"

If MV_PAR10 <= 3
	cWhere := " ADE_STATUS = '" + AllTrim(Str(MV_PAR10)) + "' AND "
EndIf 	                       
If !Empty(MV_PAR11) .OR. (!Empty(MV_PAR13) .AND. MV_PAR13 <> "ZZZZZZ")
	cWhere += "ADE_CHAVE BETWEEN '" + MV_PAR11+MV_PAR12 + "' AND '" + MV_PAR13+MV_PAR14 + "' AND "
	cWhere += "ADE_ENTIDA 	= 'SA1' AND "                    	     			
EndIf	                                                
cWhereSQL := cWhere
cWhere	:= "%" + cWhere + "%"	

If Type("Mv_Par15") == "N" .AND. Mv_Par15 == 1
	cListSU0E += "% ADE_GRUPO	IN " + cListSU0 + " AND %"
Else
	cListSU0E += "% ADE_GRUPO	BETWEEN '" + Mv_Par05 + "' AND '" + Mv_Par06 + "' AND		%"
EndIf	

BEGIN REPORT QUERY oSection1
BeginSQL alias cAlias1                         
	SELECT %exp:cSelCpos%
	FROM %table:ADE% ADE LEFT JOIN %table:SK5% SK5 
	ON(	ADE.ADE_REGSLA = SK5.K5_CODIGO AND 
		SK5.K5_FILIAL = %xFilial:SK5% AND 
		SK5.K5_STATUS IN('0','2') AND
		SK5.%notDel%) 
	WHERE ADE.ADE_FILIAL = %xFilial:ADE% AND 			
		ADE.%notDel%   					AND			
		%exp:cWhere%			                						
		ADE_DATA	BETWEEN %exp:DtoS(Mv_Par01)% AND %exp:DtoS(Mv_Par02)% AND
		ADE_CODSB1	BETWEEN %exp:Mv_Par03% AND %exp:Mv_Par04% AND
		%exp:cListSU0E%
		ADE_OPERAD	BETWEEN %exp:Mv_Par07% AND %exp:Mv_Par08% 									
	ORDER BY ADE_GRUPO, ADE_CODSB1 				

EndSql    
END REPORT QUERY oSection1 

TCSetField(cAlias1, "ADE_DTEXPI", "D")
TCSetField(cAlias1, "K5_DTENCER", "D")  

oSection2:SetParentQuery() 
oSection3:SetParentQuery() 	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR09 == 1               
	nIncMeter := 0
	While	(cAlias1)->(!Eof())
		nIncMeter++
		(cAlias1)->(DbSkip())
	EndDo 

	(cAlias1)->(DbGoTop())
	oReport:SetMeter(nIncMeter)		

	While	(cAlias1)->(!Eof())	
		cSection1 := (cAlias1)->ADE_GRUPO		
		oSection1:Init()
		oSection1:SetLineBreak()			
		oSection1:PrintLine()                                             
		oSection2:Init()

		While	(cAlias1)->(!Eof()) .AND.;
				(cAlias1)->ADE_GRUPO == cSection1
				
			cSection2 := (cAlias1)->ADE_GRUPO + (cAlias1)->ADE_CODSB1
			oSection2:PrintLine()  				

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Prepara o array para ser utilizado na³
			//³ impressao do resultado por equipe.   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nPos := aScan(aSintetic, {|x|x[1]==(cAlias1)->ADE_GRUPO})
			If nPos <= 0
				aAdd(aSintetic, {	(cAlias1)->ADE_GRUPO,;	//Cod. Grupo
									0,;						//SLA EM DIA
									0,;						//SLA ATRASADO
									0})						//TOTAL
				nPos := Len(aSintetic)
			EndIf                    
			
			If MV_PAR16 == 1	   
				cTurnoGrupo := ""						
				If !Empty((cAlias1)->ADE_GRUPO)
					DbSelectArea("SU0")
					DbSetOrder(1)
					If SU0->(DbSeek( xFilial("SU0") + (cAlias1)->ADE_GRUPO)) .And. !Empty(SU0->U0_TURNO)
						cTurnoGrupo := SU0->U0_TURNO
					EndIf
				EndIf				    
			EndIf		
			
			While	(cAlias1)->(!Eof()) .AND.;
					(cAlias1)->ADE_GRUPO + (cAlias1)->ADE_CODSB1 == cSection2 				

				If oReport:Cancel()
					Return
				EndIf

				oSection3:Init()

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprime as etapas do SLA³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cSLAList	:= ""
				DbSelectArea("SK5") 
				DbSetOrder(1)
				If !Empty((cAlias1)->ADE_REGSLA) .AND. DbSeek( xFilial("SK5") + (cAlias1)->ADE_REGSLA )						
					cSLAList	:= "'" + (cAlias1)->ADE_REGSLA + "'"						
					While !Empty(SK5->K5_CODANT)                                                        
						If DbSeek( xFilial("SK5") + SK5->K5_CODANT )															
							cSLAList	+= ",'" + SK5->K5_CODIGO + "'"
						Else
							Exit
						EndIf					   						
					EndDo					
				EndIf
				If !Empty(cSLAList)
					cQuery := "SELECT K5_CODIGO, K5_ITEM, K5_DTENCER, K5_HRENCER, K5_DTATUA, K5_HRATUA, K5_DATA, K5_HORA, K5_PAUSED, K5_STATUS, K5_CODSLA, R_E_C_N_O_ "
					cQuery += "FROM " + RetSQLName("SK5") + " SK5 "		
					cQuery += "WHERE SK5.K5_FILIAL = '" + xFilial("SK5") + "' AND "					
					cQuery += "SK5.K5_CODIGO IN(" + cSLAList + ") " 
					cQuery += "ORDER BY R_E_C_N_O_ "
			
					cQuery	:= ChangeQuery(cQuery) 
					cAliasAux := GetNextAlias()
					DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasAux, .F., .T.)			
					TCSetField(cAliasAux, "K5_DTENCER", "D") 
					TCSetField(cAliasAux, "K5_DTATUA", "D")
					TCSetField(cAliasAux, "K5_DATA", "D")
					TCSetField(cAliasAux, "K5_PAUSED", "L")
					
					dDtFim := STOD("  /  /  ")
					cHrFim := ""

					While (cAliasAux)->(!Eof()) 	
						If (!(cAliasAux)->K5_PAUSED) .And. ((cAliasAux)->K5_STATUS == '2')							                         	                         	 
							dDtFim := (cAliasAux)->K5_DTENCER   
							cHrFim := (cAliasAux)->K5_HRENCER 
						ElseIf ((cAliasAux)->K5_STATUS <> '2')
							dDtFim := STOD("  /  /  ")
							cHrFim := ""
						EndIf
						(cAliasAux)->(dbSkip()) 
					EndDo                            

					oSection3:Cell("TKATRASO"):SetValue(If(CheckAtraso((cAlias1)->ADE_DTEXPI,(cAlias1)->ADE_HREXPI,dDtFim,cHrFim,cAlias1),STR0022,STR0021))
					
					oSection3:Cell("TKATRASODIAS"):SetValue(cAtrasoHrs)

					If CheckAtraso( (cAlias1)->ADE_DTEXPI,(cAlias1)->ADE_HREXPI,;
									dDtFim,cHrFim,cAlias1)
						aSintetic[nPos,3]++ 
					Else
						aSintetic[nPos,2]++ 
					EndIf
					aSintetic[nPos,4]++
					oSection3:PrintLine()
					If MV_PAR16 == 1 
						(cAliasAux)->(dbGotop())
						oSection5:Init()							
						lFirst := .T.
						nDuraTot := 0
						While (cAliasAux)->(!Eof()) 
							If oReport:Cancel()
								Return
							EndIf
							lPaused := .F.
							If !Empty(cTurnoGrupo) 
								cTurno := cTurnoGrupo
							Else
								cTurno := oSLARegister:getTimeShift((cAliasAux)->K5_CODSLA)
								If Empty(cTurno)
									cTurno := ""
								EndIf
							EndIf								
							If lFirst
								oDTIni := TMKDateTime():this((cAliasAux)->K5_DATA, (cAliasAux)->K5_HORA)
								oDTFim := TMKDateTime():this(Date(), Time())
								lFirst := .F.
							EndIf      
							If (cAliasAux)->K5_PAUSED
								oSection5:Cell("TKSLADTINI"):SetValue(oDTIni:getDate())	
								oSection5:Cell("TKSLAHRINI"):SetValue(SubStr(oDTIni:getTime(),1,5))	
								oSection5:Cell("TKSLADTFIM"):SetValue(oDTFim:getDate())	
								oSection5:Cell("TKSLAHRFIM"):SetValue(SubStr(oDTFim:getTime(),1,5))
								
								nHoras 	:= Abs(oSLARegister:getTimeElapsed(oDTIni, oDtFim, cTurno)) 
								nDuraTot += nHoras
								nMinutos:=	nHoras - Int(nHoras)
								nMinutos:=	Int(nMinutos *60)																	
								oSection5:Cell("TKSLADUR"):SetValue( IIf(nHoras<10,"0","") + AllTrim(Str(Int(nHoras))) + ":" + IIf(nMinutos<10,"0","") + AllTrim(Str(nMinutos)) ) 
								oSection5:PrintLine()
								lPaused := .T.
								oDTIni := TMKDateTime():this((cAliasAux)->K5_DTATUA, (cAliasAux)->K5_HRATUA)
							EndIf
							If !lPaused .And. (cAliasAux)->K5_STATUS == '2' 
								oDTFim := TMKDateTime():this((cAliasAux)->K5_DTENCER, (cAliasAux)->K5_HRENCER)							
							EndIf   
							cLastStatus := (cAliasAux)->K5_STATUS
							(cAliasAux)->(dbSkip()) 
							If	(cAliasAux)->(Eof()) 									
								If !lPaused							
									oSection5:Cell("TKSLADTINI"):SetValue(oDTIni:getDate())	
									oSection5:Cell("TKSLAHRINI"):SetValue(SubStr(oDTIni:getTime(),1,5))	
									If cLastStatus == "2"
										oSection5:Cell("TKSLADTFIM"):SetValue(oDTFim:getDate())	
										oSection5:Cell("TKSLAHRFIM"):SetValue(SubStr(oDTFim:getTime(),1,5))
										nHoras 	:= Abs(oSLARegister:getTimeElapsed(oDTIni, oDtFim, cTurno))
										nDuraTot += nHoras
										nMinutos:=	nHoras - Int(nHoras)
										nMinutos:=	Int(nMinutos *60)																	
										oSection5:Cell("TKSLADUR"):SetValue( IIf(nHoras<10,"0","") + AllTrim(Str(Int(nHoras))) + ":" + IIf(nMinutos<10,"0","") + AllTrim(Str(nMinutos)) ) 		
									Else
										oSection5:Cell("TKSLADTFIM"):SetValue("--/--/--")	
										oSection5:Cell("TKSLAHRFIM"):SetValue("--:--")
										oSection5:Cell("TKSLADUR"):SetValue("--:--") 																																				
									EndIf  
									oSection5:PrintLine()
								EndIf
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³Imprime o total³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								nHoras 	:= nDuraTot 
								nDuraTot += nHoras
								nMinutos:=	nHoras - Int(nHoras)
								nMinutos:=	Int(nMinutos *60)																	
								oSection5:Cell("TKSLADTINI"):SetValue("")	
								oSection5:Cell("TKSLAHRINI"):SetValue("")	
								oSection5:Cell("TKSLADTFIM"):SetValue("")	
								oSection5:Cell("TKSLAHRFIM"):SetValue("")									
								oSection5:Cell("TKSLADUR"):SetValue( IIf(nHoras<10,"0","") + AllTrim(Str(Int(nHoras))) + ":" + IIf(nMinutos<10,"0","") + IIf(nMinutos>0,AllTrim(Str(nMinutos)),"1") ) 										
								oSection5:PrintLine()																
							EndIf
						EndDo							
						oSection5:Finish()
					EndIf																	
				EndIf
				If ( Select(cAliasAux) > 0 )
					(cAliasAux)->(dbCloseArea())
				EndIf
				oSection3:Finish()
				oReport:IncMeter()
				(cAlias1)->(dbSkip())
			EndDo
		EndDo
		oSection2:Finish() 
		oSection1:Finish() 			
		If (cAlias1)->(!Eof())
			oReport:EndPage()	                        		
		EndIf
	EndDo 		
EndIf			
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a impressão dos Resultados por Equipes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine()                
oReport:FatLine()                 
oReport:PrintText(" ")	
oReport:PrintText(" ")		
oReport:PrintText(STR0020)	// "Resultados por equipes"
oReport:ThinLine()                 
oSection4:Init()
For nPos := 1 To Len(aSintetic)
	oSection4:Cell("TKTOTAREA"):SetValue(AllTrim(aSintetic[nPos,1]))
	oSection4:Cell("TKDESCSU0"):SetValue(POSICIONE('SU0',1,xFilial('SU0')+aSintetic[nPos,1],'U0_NOME'))
	oSection4:Cell("TKTOTEMDIA"):SetValue(AllTrim(Str(aSintetic[nPos,2])))
	oSection4:Cell("TKTOTATRASO"):SetValue(AllTrim(Str(aSintetic[nPos,3])))		                                        
	oSection4:Cell("TKTOTCHAMA"):SetValue(AllTrim(Str(aSintetic[nPos,4])))		                                        		
	oSection4:PrintLine()	
Next nPos     
oSection4:Finish()    
If ( Select(cAlias1) > 0 )
	(cAlias1)->(dbCloseArea())
EndIf

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CheckAtraso  ³ Autor ³Vendas CRM          ³ Data ³20/07/2008³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se ocorreu atraso.                                 ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CheckAtraso(ExpD1,ExpD2) 	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dDataSLA = A data do SLA 								  ³±±
±±³          ³ cHoraSLA = A hora do SLA                                   ³±±
±±³          ³ dDataEncerramento = Data de encerramento do chamado        ³±±
±±³          ³ cHoraEncerramento = Hora de encerramento do chamado        ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CheckAtraso(dDataSLA, cHoraSLA, dDataEncerramento, cHoraEncerramento, cAliasTemp)             

Local lRet	:= .F.
Local oDTIni
Local oDTFim
Local nTotHrs := 0
Local nDias	  := 0
Local nHoras  := 0 
Local nMinutos:= 0

cAtrasoHrs  := ""   

If Empty(dDataEncerramento)               
	If !Empty(dDataSLA)
		If ((cAliasTemp)->K5_STATUS <> "2") .Or. (!(cAliasTemp)->K5_PAUSED)
			If dDataSLA > Date()
				lRet := .F.
			ElseIf dDataSLA < Date()
				lRet := .T.	
				oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
				oDTFim := TMKDateTime():this(Date(),Time())			
			ElseIf dDataSLA == Date()
				If cHoraSLA != Nil
					If cHoraSLA >= Time()
						lRet := .F.
					Else
						lRet := .T.
						oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
						oDTFim := TMKDateTime():this(Date(),Time())
					EndIf
				EndIf
			EndIf         
		Else
            If !Empty((cAliasTemp)->K5_DTATUA)
				If dDataSLA > (cAliasTemp)->K5_DTATUA
					lRet := .F.
				ElseIf dDataSLA < (cAliasTemp)->K5_DTATUA
					lRet := .T.  	
					oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
					oDTFim := TMKDateTime():this((cAliasTemp)->K5_DTATUA,(cAliasTemp)->K5_HRATUA)
				ElseIf dDataSLA == (cAliasTemp)->K5_DTATUA
					If cHoraSLA != Nil
						If cHoraSLA >= (cAliasTemp)->K5_HRATUA
							lRet := .F.
						Else
							lRet := .T.
							oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
							oDTFim := TMKDateTime():this((cAliasTemp)->K5_DTATUA,(cAliasTemp)->K5_HRATUA)
						EndIf
					EndIf
				EndIf
            Else
            	lRet := .F.
            EndIf
		EndIf
    Else 
    	lRet := .F.
    EndIf
Else 
	If dDataSLA > dDataEncerramento		
		lRet := .F.
	ElseIf  dDataSLA > dDataEncerramento		
		lRet := .T.			  			
		oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
		oDTFim := TMKDateTime():this(dDataEncerramento,cHoraEncerramento)
	ElseIf dDataSLA == dDataEncerramento
		If cHoraSLA != Nil
			If cHoraSLA >= cHoraEncerramento
				lRet := .F.
			Else
				lRet := .T.
				oDTIni := TMKDateTime():this(dDataSLA,cHoraSLA)			  	
				oDTFim := TMKDateTime():this(dDataEncerramento,cHoraEncerramento)
			EndIf
		EndIf
	EndIf
EndIf  

If lRet
	nTotHrs		:= oDTIni:diffInHours(oDtFim)
	nDias		:= Int(nTotHrs / 24)
	nHoras		:= (nTotHrs - (nDias * 24))
    nMinutos	:=	nHoras - Int(nHoras)
    nMinutos	:=	Int(nMinutos * 60)																	
	cAtrasoHrs 	:= AllTrim(Str(nDias))+"d "+IIf(nHoras<10,"0","")+AllTrim(Str(Int(nHoras)))+"h "+IIf(nMinutos<10,"0","")+AllTrim(Str(nMinutos))+"m"
Else
	cAtrasoHrs 	:= "0d 00h 00m"
EndIf

Return lRet

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