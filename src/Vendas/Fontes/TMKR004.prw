/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR004.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR004  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 14/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ranking de vendas por vendedores / Operadores              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR004(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K.³14/07/03³      ³1) Alteracao da QUERY para nao considerar o ³±±
±±³          ³        ³      ³SUB - os totais estao no SUA                ³±±
±±³          ³        ³      ³2) Imprimir a descricao "Operador" quando   ³±±
±±³          ³        ³      ³houver quebra pelo Operador                 ³±±
±±³Michel W. ³24/07/03³99179 ³Atualizacao para relatorio release 4.       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                   
User Function TMKR004()
Local oReport	//Objeto relatorio TReport (Release 4)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
Pergunte("TMK004",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Do Vendedor                            ³
//³ Mv_Par02           // Ate o Vendedor                         ³
//³ Mv_Par03           // A Partir de                            ³
//³ Mv_Par04           // Ate a Data                             ³
//³ Mv_Par05           // Total por Operador                     ³
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
±±³Fun‡…o    ³TKR004RptDef ³ Autor ³Michel W. Mosca     ³ Data ³24/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Ranking de Vendas no release 4.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SUA e SA3)
Local oSection2             //Objeto secao 2 do relatorio (Itens, campos das tabelas SUA e SU7)
Local oSection3             //Objeto secao 3 do relatorio (Totalizador)
Local oSumLiq
Local cAlias1 := "SUA"     //Alias da consulta Embedded SQL


cAlias1	:= GetNextAlias()						// Pega o proximo Alias Disponivel

// "Ranking de Vendas" # // "Este programa ira emitir uma listagem contendo os vendedores e os totais" #
// "das vendas realizadas por eles e tambem podendo ser analisado por operador" #
// "A emissao ocorrera baseada nos parametros do relatorio"
DEFINE REPORT oReport NAME "TMKR004" TITLE STR0001 PARAMETER "TMK004" ACTION {|oReport| Tkr004PrtRpt( oReport, cAlias1 )} DESCRIPTION STR0002 + STR0003 + STR0004

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0011 TABLES "SUA", "SA3" //Vendedor
DEFINE SECTION oSection2 OF oSection1 TITLE STR0018 TABLES "SUA", "SU7" //Operador 
DEFINE SECTION oSection3 OF oReport TITLE STR0019 //Total do ranking 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
DEFINE CELL NAME "UA_VEND" 	OF oSection1 SIZE 10
DEFINE CELL NAME "A3_NOME" 	OF oSection1 SIZE 30
DEFINE CELL NAME "S1_VRFAT" OF oSection1 TITLE STR0017 SIZE 15 	// "Valor faturado"
DEFINE CELL NAME "S1_RANK" 	OF oSection1 TITLE STR0018 SIZE 8 	// "Ranking"

DEFINE CELL NAME "UA_VEND" 	OF oSection2 SIZE 10
DEFINE CELL NAME "U7_NOME" 	OF oSection2 SIZE 30
DEFINE CELL NAME "S1_VRFAT" OF oSection2 TITLE STR0017 SIZE 15	// "Valor faturado"
DEFINE CELL NAME "S1_RANK" 	OF oSection2 TITLE STR0018 SIZE 8 	// "Ranking"

DEFINE CELL NAME "S3_LABEL"	OF oSection3 TITLE STR0020 SIZE 50 	// "Descrição"
DEFINE CELL NAME "S3_VRFAT"	OF oSection3 TITLE STR0019 SIZE 15	// "Total faturado"
DEFINE CELL NAME "S3_RANK"	OF oSection3 TITLE STR0018 SIZE 8	// "Ranking"

Return(oReport)  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr004PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³24/07/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Ranking de vendas no release 4.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr004PrtRept(ExpO1,ExpC2)                                 ³±±
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
Static Function Tkr004PrtRpt(oReport, cAlias1)
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SUA e SB1)
Local oSection2 := oSection1:Section(1)		//Objeto secao 2 do relatorio (Itens, campos da tabela SU2)
Local oSection3 := oReport:Section(2)		//Objeto secao 3 do relatorio (Totalizador)
Local cFiltro	:= ""                      //String contendo o filtro de busca a ser utilizado com DBF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nTotGer	:= 0			// Total geral
Local aTotVend	:= {}			// Total por vendedor
Local aTotOper	:= {}			// Total por operador
Local nI		:= 0			// Controle
Local nPos		:= 0			// Ponteiro da pesquisa no array
Local cNomeVen	:= ""


Local cCanc := " "               //Codigo para cancelados
Local cMV03 := DtoS(mv_par03)	//Parametro 03 convertido no formato de data do sistema
Local cMV04 := DtoS(mv_par04)	//Parametro 04 convertido no formato de data do sistema


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMKR007")      

BEGIN REPORT QUERY oSection1
BeginSQL alias cAlias1
	SELECT 	UA_FILIAL,	UA_VEND,	UA_CANC,	UA_EMISSAO
			UA_OPER,	UA_VLRLIQ,	UA_OPERADO		
	FROM 	%table:SUA% SUA
	WHERE	 SUA.UA_FILIAL = %xFilial:SUA% AND
			 SUA.UA_VEND BETWEEN %exp:mv_par01% AND %exp:mv_par02% AND
			 SUA.UA_EMISSAO BETWEEN %exp:cMV03% AND %exp:cMV04% AND				 				 
			 SUA.UA_OPER = '1' AND
			 SUA.UA_CANC = %exp:cCanc% AND
			 SUA.%notDel%
	ORDER BY UA_FILIAL, UA_VEND, UA_OPERADO    

EndSql    
END REPORT QUERY oSection1 

While	(!Eof())							.AND.;
		(cAlias1)->UA_FILIAL == xFilial("SUA")	.AND.;
		(cAlias1)->UA_VEND	>=	Mv_Par01		.AND.;
		(cAlias1)->UA_VEND	<=	Mv_Par02

	If oReport:Cancel()
		Exit
	EndIf	
			
	nTotGer+=(cAlias1)->UA_VLRLIQ
			
	// Procura pelo codigo do vendedor desse atendimento
	nPos := ASCAN(aTotVend, {|x| x[1]==(cAlias1)->UA_VEND} )
	If nPos == 0
		// Adiciona o Vendedor no array de totais
		AAdd( aTotVend, {(cAlias1)->UA_VEND, (cAlias1)->UA_VLRLIQ })
	Else
		// Acumula o total desse atendimento para esse vendedor
		aTotVend[nPos][2] += (cAlias1)->UA_VLRLIQ
	Endif
			
	nPos := ASCAN(aTotOper, {|x| x[1] == (cAlias1)->UA_VEND .AND. x[2] == (cAlias1)->UA_OPERADO })
	If nPos == 0
		AAdd( aTotOper, {(cAlias1)->UA_VEND, (cAlias1)->UA_OPERADO, (cAlias1)->UA_VLRLIQ })
	Else
		aTotOper[nPos][3] += (cAlias1)->UA_VLRLIQ
	Endif
	
	DbSelectArea(cAlias1)
	DbSkip()                
	oReport:IncMeter()	
End  

If nTotGer > 0
	oSection1:Init()
	aSort(aTotVend,,, {|x,y| x[2] > y[2]} )		// Decrescente
	aSort(aTotOper,,, {|x,y| x[1] < y[1]} )		// Crescente
	
	For nI := 1 To Len(aTotVend)
			
		DbSelectArea("SA3")
		DbSetOrder(1)
		If MsSeek(xFilial("SA3") + aTotVend[nI][1])
		   cNomeVen := SA3->A3_NOME
		Else
		   cNomeVen := STR0013 //"Nao Localizado"  
		Endif	   
		oSection1:Cell("UA_VEND"):SetValue(aTotVend[nI][1])
		oSection1:Cell("A3_NOME"):SetValue(cNomeVen)
		oSection1:Cell("S1_VRFAT"):SetValue(Transform(aTotVend[nI][2],'@E 999,999,999.99'))
		oSection1:Cell("S1_RANK"):SetValue(Transform(aTotVend[nI][2]/nTotGer*100,'@E 999.99') + " %")
		oSection1:PrintLine()
		
		// Se foi selecionado a quebra por Operador
		If Mv_Par05 == 1		
			nPos := ASCAN(aTotOper, {|x| x[1] == aTotVend[nI][1] })
			If nPos > 0      
                oSection2:Init()
				While aTotOper[nPos][1] == aTotVend[nI][1]
					
					DbSelectArea("SU7")
					DbSetOrder(1)
					MsSeek(xFilial("SU7") + aTotOper[nPos][2])
					

			  		oSection2:Cell("UA_VEND"):SetValue(aTotOper[nPos][2])
			  		oSection2:Cell("U7_NOME"):SetValue(STR0014+SU7->U7_NOME)
			  		oSection2:Cell("S1_VRFAT"):SetValue(Transform(aTotOper[nPos][3],'@E 999,999,999.99'))
			  		oSection2:Cell("S1_RANK"):SetValue(Transform(aTotOper[nPos][3]/aTotVend[nI][2]*100,'@E 999.99') + " %")
					oSection2:PrintLine()

					
					nPos++
					If nPos > Len(aTotOper)
						Exit
					Endif
				End
				oSection2:Finish()
			Endif
			
			
		Endif
	
	Next nI
	oSection1:Finish()	
	If nTotGer > 0
		oSection3:Init()
		oReport:FatLine()
		oSection3:Cell("S3_LABEL"):SetValue(STR0010 + DtoC(Mv_Par03) + "a" + DtoC(Mv_Par04))//"Faturamento no periodo de "###" a "
		oSection3:Cell("S3_VRFAT"):SetValue(Transform(nTotGer,'@E 999,999,999.99'))	
		oSection3:Cell("S3_RANK"):SetValue("100.00 %")
		oSection3:PrintLine()                         
		oReport:FatLine()		
		oSection3:Finish()
	Endif                           

Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Caso nada tenha sido impresso, entao imprime uma menssagem de aviso³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText(STR0012)  	
EndIf	
            



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetLineBreak()



Return(.T.)