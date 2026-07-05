/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "JURR094.CH"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   3000 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     2350 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR094(cPedido)
Regras do relatório de Objetos

@param cPedido   - Código do pedido
@param lAutomato - Indica se é execução de automação
@param cNomeRel  - Indica o nome do arquivo que será gravado (automação)

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR094(cPedido, lAutomato, cNomeRel)
Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) 	// Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}
Local nEspaco 	 := nTamCarac * 6

Default lAutomato := .F.
Default cNomeRel  := ""

//Atualiza dados da tabela NT6
AtuNT6(cPedido)

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
aRelat := {STR0001,65,oFont} //"Histórico de Alterações"

//Cabeçalho do Relatório
  // 1 - Título, 
  // 2 - Conteúdo, 
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título, 
  // 5 - Fonte da descrição
aCabec := { {STR0023, DtoC(Date()), (nTamCarac*16), oFontTit, oFontDesc} }//,;

//Campos do Relatório
  //Exemplo da primeira parte -> aAdd(aSessao, {"Relatório de Follow-ups",65,oFontSub,.F.,;// 
  // 1 - Título da sessão do relatório,
  // 2 - Posição de início da descrição, 
  // 3 - Fonte no quadro com título da sessão,
  // 4 - Impressão na horizontal -> Título e descrição na mesma linha (Ex: Data: 01/01/2016)
  // 5 - Query do subreport - Se for parte do relatório principal não precisa ser indicado
    // Arrays a partir da 6ª posição
      // 1 - Título do campo,
      // 2 - Tabela do campo,
      // 3 - Nome do campo no dicionário,
      // 4 - Nome do Campo na Query,
      // 5 - Tipo do Campo,
      // 6 - Indica a coordenada horizontal em pixels ou caracteres, 
      // 7 - Tamanho que o conteúdo pode ocupar,
      // 8 - Fonte do título, 
      // 9 - Fonte da descrição
      // 10 - Posição de início da descrição
      // 11 - Quebra Linha após impressão do conteúdo?
aAdd(aSessao, {STR0002,65,oFontSub,.T.,,; //"Detalhe"
                {STR0005 /*"Data Alteração:"   */,"NT6","NT6_DTALT" ,"NT6_DTALT" ,"D",65,250 ,oFontTit,oFontDesc,(nTamCarac*17),.T.},;
                {STR0026 /*"Usuário Alteração:"*/,"NT6","NT6_USUALT","NT6_USUALT","C",65,1200,oFontTit,oFontDesc,(nTamCarac*17),.T.},;
                {STR0024 /*"Objeto:"		   */,"NSP","NSP_DESC"  ,"NSP_DESC"  ,"C",65,500 ,oFontTit,oFontDesc,(nTamCarac*17),.T.},;
                {STR0006 /*"Instancia:"        */,"NUQ","NUQ_INSTAN","NUQ_INSTAN","O",65,1200,oFontTit,oFontDesc,(nTamCarac*17),.T.},;
                {STR0007 /*"Descrição Decisao:"*/,"NQQ","NQQ_DESC"  ,"NQQ_DESC"  ,"C",65,1200,oFontTit,oFontDesc,(nTamCarac*17),.T.},;
                {STR0008 /*"Descr.Prognostico:"*/,"NQ7","NQ7_DESC"  ,"NQ7_DESC"  ,"C",65,1200,oFontTit,oFontDesc,(nTamCarac*17),.T.}})

aAdd(aSessao, {STR0003,65,oFontSub,.F.,,;// Título da sessão do relatório "Pedidos"
                {STR0009 /*"Correção"     */    ,"NW7B","NW7_DESC"  ,"BNW7_DESC" ,"C",65  		   		,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0010 /*"Data Pedido"  */    ,"NT6" ,"NT6_PEDATA","NT6_PEDATA","D",230 + nEspaco		,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0011 /*"Data Juros"   */    ,"NT6" ,"NT6_DTJURO","NT6_DTJURO","D",430 + nEspaco 	,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0012 /*"Simbolo Moeda"*/    ,"CTOB","CTO_SIMB"  ,"BCTO_DESC" ,"C",630 + nEspaco		,060 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {""  /*"Valor Pedido"     */    ,"NT6" ,"NT6_PEVLR" ,"NT6_PEVLR" ,"N",690 + nEspaco		,340 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0013 /*"Data Multa"   */    ,"NT6" ,"NT6_DTMULT","NT6_DTMULT","D",1030 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0014 /*"% Multa"      */    ,"NT6" ,"NT6_PERMUL","NT6_PERMUL","C",1180 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0015 /*"Ped.Inest"    */    ,"NT6" ,"NT6_PEINVL","NT6_PEINVL","O",1330 + nEspaco	,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0009 /*"Correção "    */    ,"NT6" ,"NT6_CCORPE","NT6_CCORPE","N",1530 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0016 /*"Juros"        */    ,"NT6" ,"NT6_CJURPE","NT6_CJURPE","N",1680 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0017 /*"Vlr.Multa Atu"*/    ,"NT6" ,"NT6_MULATU","NT6_MULATU","N",1830 + nEspaco	,250 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0018 /*"Valor Atual"  */    ,"NT6" ,"NT6_PEVLRA","NT6_PEVLRA","N",2080 + nEspaco	,250 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.T.}})

aAdd(aSessao, {STR0004,65,oFontSub,.F.,,;// Título da sessão do relatório "Contingência"
                {STR0009 /*"Correção"     */    ,"NW7A","NW7_DESC"  ,"ANW7_DESC" ,"C",65  				,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0019 /*"Data Cont."   */    ,"NT6" ,"NT6_DTCONT","NT6_DTCONT","D",230 + nEspaco 	,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0011 /*"Data Juros"   */    ,"NT6" ,"NT6_DTJURC","NT6_DTJURC","D",430 + nEspaco 	,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0020 /*"Simbolo Moeda"*/    ,"CTOA","CTO_SIMB"  ,"ACTO_DESC" ,"C",630 + nEspaco 	,060 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {""  /*"Valor Contig"     */    ,"NT6" ,"NT6_VLCONT","NT6_VLCONT","N",690  + nEspaco	,340 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0013 /*"Data Multa"   */    ,"NT6" ,"NT6_DTMULC","NT6_DTMULC","D",1030 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0014 /*"% Multa"      */    ,"NT6" ,"NT6_PERMUC","NT6_PERMUC","C",1180 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0021 /*"Contig Inest" */    ,"NT6" ,"NT6_INECON","NT6_INECON","O",1330 + nEspaco	,200 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0009 /*"Correção"     */    ,"NT6" ,"NT6_CCORPC","NT6_CCORPC","N",1530 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0016 /*"Juros"        */    ,"NT6" ,"NT6_CJURPC","NT6_CJURPC","N",1680 + nEspaco	,150 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0017 /*"Vlr.Multa Atu"*/    ,"NT6" ,"NT6_MULATC","NT6_MULATC","N",1830 + nEspaco	,250 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.F.},;
                {STR0018 /*"Valor Atual"  */    ,"NT6" ,"NT6_VLCONA","NT6_VLCONA","N",2080 + nEspaco	,250 + nEspaco	,oFontTit,oFontDesc,(nTamCarac),.T.}})

Processa( {|| JRelatorio(aRelat, aCabec, aSessao, J94QrPrin(cPedido), lAutomato, cNomeRel) } , , STR0025, .F.)	//"Gerando Relátorio..."

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J94QrPrin()
Gera a query principal do relatório
 
Uso Geral.

@param aFiltro Filtros que foram utilizados na pesquisa de follow-ups

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J94QrPrin(cPedido)
Local cQuery := ""

ProcRegua(0)

cQuery := " SELECT NT6.NT6_DTALT, NT6.NT6_USUALT, NUQ.NUQ_INSTAN, NQQ.NQQ_DESC, NQ7.NQ7_DESC, NW7B.NW7_DESC BNW7_DESC , NT6.NT6_PEDATA, NT6.NT6_DTJURO, "
cQuery += " CTOB.CTO_SIMB BCTO_DESC, NT6.NT6_PEVLR, NT6.NT6_DTMULT, NT6.NT6_PERMUL, NT6.NT6_PEINVL, NT6.NT6_CCORPE, NT6.NT6_CJURPE, "
cQuery += " NT6.NT6_MULATU, NT6.NT6_PEVLRA, NW7A.NW7_DESC ANW7_DESC, NT6.NT6_DTCONT, NT6.NT6_DTJURC, CTOA.CTO_SIMB ACTO_DESC, NT6.NT6_DTMULC, "
cQuery += " NT6.NT6_PERMUC, NT6.NT6_INECON, NT6.NT6_VLCONT,NT6.NT6_CCORPC, NT6.NT6_CJURPC, NT6.NT6_MULATC, NT6.NT6_VLCONA, "
cQuery += " NSP.NSP_DESC "

cQuery += " FROM " + RetSqlName("NT6") + " NT6 "  

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("NSY") + " NSY "
cQuery += "   ON  ( NSY.NSY_FILIAL = NT6.NT6_FILIAL )"
cQuery += "   AND ( NSY.NSY_COD    = NT6.NT6_CPEDID )"
cQuery += "   AND ( NSY.NSY_CFCORC = NT6.NT6_CFCORC )"
cQuery += "   AND ( NSY.NSY_CMOCON = NT6.NT6_CMOCON )"
cQuery += "   AND ( NSY.NSY_CCOMON = NT6.NT6_CCOMON )"
cQuery += "   AND ( NSY.NSY_CMOPED = NT6.NT6_CMOPED )"
cQuery += "   AND ( NSY.D_E_L_E_T_ = ' ' )" 

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("NUQ") + " NUQ "
cQuery += "   ON  ( NUQ.NUQ_FILIAL = NSY.NSY_FILIAL)"
cQuery += "   AND ( NUQ.NUQ_COD    = NT6.NT6_CINSTA )"
cQuery += "   AND ( NUQ.D_E_L_E_T_ = ' ' )" 

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("NQQ") + " NQQ "
cQuery += "   ON  ( NQQ.NQQ_FILIAL = '"+xFilial("NQQ")+"')"
cQuery += "   AND ( NQQ.NQQ_COD    = NT6.NT6_CDECPE )"
cQuery += "   AND ( NQQ.D_E_L_E_T_ = ' ' )" 

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("NQ7") + " NQ7 "
cQuery += "   ON  ( NQ7.NQ7_FILIAL = '"+xFilial("NQ7")+"')"
cQuery += "   AND ( NQ7.NQ7_COD    = NT6.NT6_CPROG )"
cQuery += "   AND ( NQ7.D_E_L_E_T_ = ' ' )" 

cQuery += "  LEFT OUTER JOIN " + RetSqlName("NW7") + " NW7A " 
cQuery += "   ON  ( NW7A.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NW7A.NW7_FILIAL = '"+xFilial("NW7")+"')"
cQuery += "   AND ( NW7A.NW7_COD    = NT6.NT6_CFCORC )"

cQuery += "  LEFT OUTER JOIN " + RetSqlName("NW7") + " NW7B " 
cQuery += "   ON  ( NW7B.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NW7B.NW7_FILIAL = '"+xFilial("NW7")+"')"
cQuery += "   AND ( NW7B.NW7_COD    = NT6.NT6_CCOMON )"

cQuery += "  LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOA " 
cQuery += "   ON  ( CTOA.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( CTOA.CTO_FILIAL = '"+xFilial("CTO")+"')"
cQuery += "   AND ( CTOA.CTO_MOEDA  = NT6.NT6_CMOCON )"

cQuery += "  LEFT OUTER JOIN " + RetSqlName("CTO") + " CTOB " 
cQuery += "   ON  ( CTOB.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( CTOB.CTO_FILIAL = '"+xFilial("CTO")+"')"
cQuery += "   AND ( CTOB.CTO_MOEDA  = NT6.NT6_CMOPED )"

cQuery += "  LEFT JOIN " + RetSqlName("NSP") + " NSP " 
cQuery += "   ON  NSP.D_E_L_E_T_ = ' '"
cQuery += "   AND NSP.NSP_FILIAL = '"+xFilial("NSP")+"' "
cQuery += "   AND NSY.NSY_CPEVLR = NSP.NSP_COD "

cQuery += " WHERE NT6.D_E_L_E_T_ = ' ' "
cQuery += "   AND NT6.NT6_FILIAL = '" + xFilial("NT6") + "' "
cQuery += "   AND NT6.NT6_CPEDID = '" + cPedido + "' "

cQuery += " ORDER BY NT6.NT6_DTALT DESC, NT6.NT6_COD DESC " 

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio(aRelat,aCabec,aSessao,cQuery)
Executa a query principal e inicia a impressão do relatório.
Ferramenta TMSPrinter
Uso Geral.

@param aRelat  Dados do título do relatório
@param aCabec  Dados do cabeçalho do relatório
@param aSessao Dados do conteúdo do relatório
@param cQuery  Query que será executada
@param lAutomato - Indica se é execução de automação
@param cNomeRel  - Indica o nome do arquivo que será gravado (automação)

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat,aCabec,aSessao,cQuery, lAutomato, cNomeArq)

Local cNomeRel  := ""
Local lHori     := .F.
Local lQuebPag  := .F.
Local lTitulo   := .T. 
Local lLinTit   := .F.
Local lValor    := .F.
Local nI        := 0    // Contador
Local nJ        := 0    // Contador
Local nLin      := 0    // Linha Corrente
Local nLinCalc  := 0    // Contator de linhas - usada para os cálculos de novas linhas
Local nLinCalc2 := 0
Local nLinFinal := 0
Local oPrint    := Nil
Local aDados    := {}
Local cData     := ""
Local TMP       := GetNextAlias()

cNomeRel  := IIF( VALTYPE(cNomeArq) <> "U" .AND. !Empty(cNomeArq), cNomeArq, aRelat[1]) //Nome do Relatório

ProcRegua(0)
If !lAutomato
	oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF" ) // Inicia o relatório
Else
	oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
	oPrint:CFILENAME  := cNomeRel
	oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),TMP,.T.,.T.)

If (TMP)->(!EOF())

	ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Imprime cabeçalho
	nLinCalc := nLin // Inicia o controle das linhas impressas

	While (TMP)->(!EOF())

		If nLin >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
			oPrint:EndPage() // Se for maior, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf

		For nI := 1 To Len(aSessao) // Inicia a impressão de cada sessão do relatório
			
			lValor := .F.
			lHori  := aSessao[nI][4]
			
			If Empty(aSessao[nI][5]) // Nessa posição é indicada a query de um subreport
				nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
		                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 

				nLinFinal := 0 // Limpa a variável

				For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
					cTabela  := aSessao[nI][nJ][2] //Tabela
					cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
					cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
					cTipo    := aSessao[nI][nJ][5] //Tipo do campo
					cValor   := JXFTratVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
					If !lValor .And. !Empty(AllTrim(cValor))
						lValor := .T.
					EndIf
					
					aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
				Next nJ
				
				nLinCalc := nLinCalc2 // Retorno do valor original da variável
				
				
				If lQuebPag // Verifica se é necessário ocorrer a quebra de pagina
					oPrint:EndPage() // Se é necessário, encerra a página atual
					ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
					nLinCalc := nLin // Inicia o controle das linhas impressas
					lQuebPag := .F. // Limpa a variável de quebra de página
					lTitulo  := .T. // Indica que o título pode ser impresso 
					lLinTit  := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
				EndIf

				If nI == 1 .And. cData <> alltochar((TMP)->NT6_DTALT)
					JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI],, TMP) //Imprime o título da sessão no relatório
				EndIf

				If /*lTitulo .And.*/ !Empty(aSessao[nI][1])
					If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
						oPrint:EndPage() // Se for maior, encerra a página atual
						ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
						nLinCalc := nLin // Inicia o controle das linhas impressas
						lTitulo := .T. // Indica que o título pode ser impresso 
						lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
					EndIf
					If lValor // Se existir valor a ser impresso na sessão imprime o título da sessão.
						JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], 1, TMP) //Imprime o título da sessão no relatório
					EndIf
				EndIf

				If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
					// Os títulos devem ser impressos
					lTitulo := .T. // Indica que o título pode ser impresso 
					lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
				EndIf
				
				//Imprime os campos do relatório
				JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec)
				
				//Limpa array de dados
				aSize(aDados,0)
				aDados := {}

				nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
				nLinFinal := 0 // Limpa a variável
				nLin := nLinCalc+nSalto //Recalcula a linha de referência para impressão
				nLinCalc := nLin //Indica a linha de referência para impressão	

			EndIf

		Next nI

		oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
		oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
		
		nLin += nSalto //Adiciona uma linha em branco após a linha impressa
		nLinCalc := nLin
		
		cData := alltochar((TMP)->NT6_DTALT)
		
		(TMP)->(DbSkip())
	Enddo

	aSize(aDados,0)  //Limpa array de dados
	aSize(aRelat,0)  //Limpa array de dados do relatório
	aSize(aCabec,0)  //Limpa array de dados do cabeçalho do relatório
	aSize(aSessao,0) //Limpa array de dados das sessões do relatório

	oPrint:EndPage() // Finaliza a página

	If !lAutomato
		oPrint:CFILENAME := cNomeRel + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
		oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
	EndIf
	oPrint:Print()

	If !lAutomato
		FErase(oPrint:CFILEPRINT)
	EndIf
Else
	If !lAutomato
		ApMsgInfo(STR0022) //"Não há histórico de alteração a ser impresso"
	Else
		Conout(STR0022) //"Não há histórico de alteração a ser impresso"
	EndIf
EndIf

(TMP)->(dbCloseArea())

Return(Nil)
//-------------------------------------------------------------------
/*/{Protheus.doc} ImpCabec(oPrint, nLin, aRelat, aCabec)
Imprime cabeçalho do relatório
 
Uso Geral.

@param oPrint  Objeto do Relatório (TMSPrinter)
@param nLin    Linha Corrente
@param aRelat  Dados do título do relatório
@param aCabec  Dados do cabeçalho do relatório

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ImpCabec(oPrint, nLin, aRelat, aCabec)
Local cTit       := aRelat[1] // Título
Local nColTit    := aRelat[2] // Posição da Título
Local oFontTit   := aRelat[3] // Fonte do Título
Local cTitulo    := ""
Local cValor     := ""
Local nPosValor  := 0
Local nSaltoCabe := 10
Local nI         := 0
Local oFontValor 
Local oFontRoda  := TFont():New("Arial",,-8,,.F.,,,,.T.,.F.) // Fonte usada no Rodapé

oPrint:SetLandscape()

oPrint:SetPaperSize(9) //A4 - 210 x 297 mm

// Inicia a impressao da pagina
oPrint:StartPage()
oPrint:Say( nFimL, nColFim - 100, alltochar(oPrint:NPAGECOUNT), oFontRoda )
nLin := 150

// Imprime o cabecalho
oPrint:Say( nLin, nColTit, cTit, oFontTit )
nLin += 2.5 * nSaltoCabe // Espaço para que o cabeçalho fique um pouco abaixo do Título do Relatório 

If Len(aCabec) > 0
	If !EMPTY(aCabec[1][1])
		For nI := 1 to Len(aCabec)
			cTitulo    := aCabec[nI][1] // Título
			cValor     := aCabec[nI][2] // Conteúdo
			nPosValor  := aCabec[nI][3] // Posição do conteúdo (considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. Para isso considere sempre a posição da maior descrição)
			oFontTit   := aCabec[nI][4] // Fonte do título
			oFontValor := aCabec[nI][5] // Fonte do conteúdo
		
			oPrint:Say( nLin += nSaltoCabe, 070, cTitulo + ": " +cValor, oFontValor ) //Imprime o Título
		Next
	EndIf
EndIf

nLin+=20
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório

nLin+=40 //Recalcula a linha de referência para impressão

Return nil
//-------------------------------------------------------------------
/*/{Protheus.doc} JDadosCpo(aSessao, cValor, nLinCalc, lQuebPag)
Função para montar array com as descrições e conteúdos dos campos que serão impressos, 
assim como suas coordenadas, fontes e quebra de linha após a impressão de cada campo. 
 
Uso Geral.

@param aSessao  Dados do conteúdo do relatório
@param cValor   Conteúdo do campo que será impresso
@param nLinCalc Variável de cálculo de linhas
@param lQuebPag Indica se deve existir quebra de pagina

@return aDados Array com a Sessão formatada

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JDadosCpo(aSessao, cValor, nLinCalc, lQuebPag)
Local aDados := {}
Local cTitulo := ""
Local nPosTit := 0
Local oFontTit
Local nPos := 0
Local nQtdCar := 0
Local oFontVal
Local nPosValor := 0
Local lQuebLin := .F.

cTitulo  := aSessao[1] //Título da Coluna
nPosTit  := aSessao[6] //Indica a coordenada horizontal em pixels ou caracteres
oFontTit := aSessao[8] //Fonte do título
nPos     := aSessao[6] //Indica a coordenada horizontal para imprimir o valor do campo
nQtdCar  := aSessao[7] //Quantidade de caracteres para que seja feita a quebra de linha
oFontVal := aSessao[9] //Fonte usada para impressão do conteúdo
nPosValor:= aSessao[10] //Fonte usada para impressão do conteúdo
lQuebLin := aSessao[11] //Indica se deve existir a quebra de linha

If !lQuebPag // Verifica se será necessária quebra de página para essa sessão
	lQuebPag := ((Int((Len(cValor)/nQtdCar) + 1) * nSalto) + nLinCalc) > nFimL
	nLinCalc += (Int((Len(cValor)/nQtdCar) + 1) * nSalto) // Indica a linha que será usada para cada valor quando forem impressos - Usado apenas para uma simulação.
EndIf

aDados := {cTitulo, nPosTit, oFontTit, cValor, nQtdCar, oFontVal, nPos, nPosValor, lQuebLin}

Return aDados

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpRel(aDados, nLin, nLinCalc, oPrint, nLinFinal, lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta)
Função que trata as quebras de pagina e imprime as Sessões na vertical e horizontal 
 
Uso Geral.

@param aDados    Array com a Sessão formatada
@param nLin      Linha Corrente
@param nLinCalc  Variável de cálculo de linhas
@param oPrint    Objeto do Relatório (TMSPrinter)
@param nLinFinal Ultima linha que tem conteúdo impresso 
@param lHori     Indica se impressão será na horizontal ou vertical
@param lTitulo   Indica se o titulo deve ser impresso
@param lLinTit   Indica se a linha onde será impresso o titulo foi definida
@param aRelat    Dados do título do relatório
@param aCabec    Dados do cabeçalho do relatório 
@param lSalta    Indica se precisa continuar a impressão do conteúdo atual na próxima página

@return nil

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpRel(aDados, nLin, nLinCalc, oPrint, nLinFinal, lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta)
Local nJ
Local cTitulo := ""
Local nPosTit := 0
Local oFontTit
Local nPos := 0
Local nQtdCar := 0
Local oFontVal
Local nPosValor := 0
Local lQuebLin  := .F.
Local lImpTit   := .T.
Local cValor   := ""
Local nLinTit  := 0
Local nLinAtu  := 0
Local aSobra   := aClone(aDados)

aEval(aSobra,{|x| x[4] := ""}) // Limpa a posição de conteúdo/valor dos campos no array de sobra, pois ele é preenchido com os dados do array aDados. Limpa para que seja preenchido com o conteúdo da sobra. 

Default lSalta  := .F.
Default lHori   := .T.

If lSalta // Se for continuação de impressão do conteúdo que não coube na página anterior 
	lImpTit := .F. // Indica que os títulos não precisam ser impressos
	lSalta  := .F. // Limpa variável
EndIf

For nJ := 1 to Len(aDados)

	cTitulo  := aDados[nJ][1] //Título da Coluna
	nPosTit  := aDados[nJ][2] //Indica a coordenada horizontal em pixels ou caracteres
	oFontTit := aDados[nJ][3] //Fonte do título
	cValor   := aDados[nJ][4] //Valor a ser impresso
	nQtdCar  := aDados[nJ][5] //Quantidade de caracteres para que seja feita a quebra de linha
	oFontVal := aDados[nJ][6] //Fonte usada para impressão do conteúdo
	nPos     := aDados[nJ][7] //Indica a coordenada horizontal para imprimir o valor do campo
	nPosValor:= aDados[nJ][8] + nPos //Indica a coordenada horizontal para imprimir o valor do campo
	lQuebLin := aDados[nJ][9] // Indica se deve existir quebra de linha após a impressão do campo

	If lHori // Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
		nLinTit  := nLin
		nLinCalc := nLin
		oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
	Else // Impressão na vertical -> Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Data
	     //                                                                                                                01/01/2016 )
		
		If lImpTit // Essa variável indica se deve imprimir o título dos campos - Será .F. somente quando ocorrer quebra de um conteúdo em mais de uma página (lSalta == .T.).
			If !lLinTit // Como a linha onde será impresso o título dos campos ainda não foi definida entrará nessa condição
				
				If (nLin + 2*nSalto) >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
					oPrint:EndPage() // Se for maior, encerra a página atual
					ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
					nLinCalc := nLin // Inicia o controle das linhas impressas
					lTitulo := .T. // Indica que o título pode ser impresso 
					lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
					nLinFinal := 0 
				EndIf
				
				nLinTit  := nLin
				nLin     += nSalto
				nLinCalc := nLin
				lLinTit := .T. // Indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
			EndIf
			
			If lTitulo // Indica que o título pode ser impresso
				oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
				lTitulo := Len(aDados) <> nJ // Enquanto estiver preenchendo os títulos indica .T., para que os outros títulos sejam impressos. 
				                             // Após o preenchimento do último título indica .F., não premitindo mais a impressão dos títulos nessa página.

				// Deve imprimir apenas uma vez por página para que a letra não fique mais grossa.
				// Se não tiver esse tratamento a impressão será feita várias vezes sobre a mesma palavra devido as condições do laço, 
				// fazendo com que a grossura das letras nas palavras aumente e isso atrapalha.
				
			EndIf
		EndIf
		nPosValor := nPosTit // Indica que a posição (coluna) do conteúdo/valor a ser impresso é a mesma que foi impresso o titulo, ou seja, o conteúdo/valor ficará logo abaixo do título
	EndIf

	nLinAtu := nLinCalc // Controle de linhas usadas para imprimir o conteúdo atual

	JImpLin(@oPrint,@nLinAtu,nPosValor,cValor,oFontVal,nQtdCar,@aSobra[nJ], @lSalta, lImpTit) //Imprime as linhas com os conteúdos/valores

	// Verifica qual campo precisou de mais linhas para ser impresso
	// para usar esse valor como referência para começar a impressão do próximo registro
	If nLinAtu > nLinFinal
		nLinFinal := nLinAtu
	EndIf

	If lQuebLin // Indica que é necessária quebra de linha, ou seja, o próximo campo será impresso na próxima linha
		If nLinFinal >= nLin // Se a próxima linha a ser impressa (nLin) for menor que a última linha que tem conteúdo impresso (nLinFinal)
			nLin     := nLinFinal // Deve-se indicar a maior referência
		Else
			nLin     += nSalto // Caso contrário, pule uma linha.
		EndIf
		nLinTit  := nLin // Recebe a próxima linha disponível para impressão do título
		nLinCalc := nLin // Atualiza variável de cálculo de linhas
		lLinTit  := .F.  // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
	EndIf
Next nJ

If lSalta // Se precisa continuar a impressão do conteúdo atual na próxima página 
	oPrint:EndPage() // Finaliza a página atual
	ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho na próxima página
	nLinCalc  := nLin // Inicia o controle das linhas a serem impressas
	nLinAtu   := nLinCalc // Atualiza variável linha atual
	lQuebPag  := .F. // Indica que não é necessário ocorrer a quebra de pagina, pois já está sendo quebrada nesse momento.
	lTitulo   := .T. // Indica que o título pode ser impresso 
	lLinTit   := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
	nLinFinal := 0 // Limpa variável de controle da última linha impressa.
	
	// Imprime o restante do conteúdo que não coube na página anterior.
	JImpRel(aSobra,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec, @lSalta)
EndIf

Return nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpLin(oPrint, nLinAtu, nPosValor, cTexto, oFontVal, nQtdCar, aSobra, lSalta, lImpTit)
Função para montar array de titulos das colunas
 
Uso Geral.

@param oPrint    Objeto do Relatório (TMSPrinter)
@param nLinAtu   Linha onde será impresso a próxima informação
@param nPosValor Posição do conteúdo
@param cTexto    Conteúdo completo de cada coluna
@param oFontVal  Fonte usada para impressão do conteúdo
@param nQtdCar   Quantidade de caracteres para que seja feita a quebra de linha
@param aSobra    Array com o valor que não coube em alguma das colunas da página anterior, e falta ser impresso
@param lSalta    Indica se precisa continuar a impressão do conteúdo atual na próxima página
@param lImpTit   Indica se o título precisa ser impresso

@return nil

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpLin(oPrint, nLinAtu, nPosValor, cTexto, oFontVal, nQtdCar, aSobra, lSalta, lImpTit)
Local nRazao    := oPrint:GetTextWidth( "oPrint:nPageWidth", oFontVal )
Local nTam      := (nRazao * nQtdCar) / 350
Local aCampForm := {} // Array com cada palavra a ser escrita.
Local cValor    := ""
Local cValImp   := "" // Valor impresso
Local nX        := 0

cTexto := StrTran(cTexto, Chr(13)+Chr(10), '')
cTexto := StrTran(cTexto, Chr(10), '')
aCampForm := STRTOKARR(cTexto, " ")

If Len(aCampForm) == 0 // Caso não exista conteúdo/valor
	If lImpTit // E o título do campo foi impresso 
		oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Será inserida a linha com conteúdo em branco
		nLinAtu += nSalto // Pula uma linha
	EndIf
Else // Caso exista conteúdo/valor
	For nX := 1 To Len(aCampForm) // Laço para cada palavra a ser escrita
		If oPrint:GetTextWidth( cValor + aCampForm[nX], oFontVal ) <= nTam // Se a palavra atual for impressa e NÃO passar do limite de tamanho da linha
			cValor += aCampForm[nX] + " " // Preenche a linha com a palavra atual
		
			If Len(aCampForm) == nX // Caso esteja na última palavra
				oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor
				nLinAtu += nSalto // Pula para a próxima linha
			EndIf
	
		Else // Se a palavra atual for impressa e passar do limite de tamanho da linha
			oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
			nLinAtu += nSalto // Pula para a próxima linha
					
			If nLinAtu + 2*nSalto > nFimL // Se a próxima linha a ser impressa NÃO couber na página atual
				lSalta := .T. // Indica que precisa continuar a impressão do conteúdo atual na próxima página 
				If Empty(SubStr(cTexto,Len(cValImp+cValor)+2,1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+3,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor)+1,1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+2,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor),1))
					aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor),Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
				EndIf
				Exit
			Else // Se a próxima linha a ser impressa couber na página atual
				cValImp += cValor // Guarda todo o texto que já foi impresso para que caso necessite de quebra o sistema saiba até qual parte o texto já foi impresso.
				cValor := aCampForm[nX] + " " // Preenche a linha com a palavra atual
				If Len(aCampForm) == nX
					oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
					nLinAtu += nSalto // Pula para a próxima linha	
				EndIf
			EndIf
		EndIf
	Next nX
EndIf

//Limpa array
aSize(aCampForm,0)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpTitSes()
Imprime o título da sessão no relatório
 
Uso Geral.

@param cTabela  Nome da tabela
        cCpoTab  Nome do campo na tabela
        cCpoQry  Nome do campo na query
        cTipo    Tipo do campo
        TMP      Alias aberto

@return cValor Valor do campo na Query

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao, nTipo, TMP)
Local oBrush1

Default nTipo := 0

If nTipo == 0
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	
	oBrush1 := TBrush():New( , CLR_LIGHTGRAY )
	oPrint:FillRect( {nLin-20, nColIni, (nLin + 30), nColFim}, oBrush1 )
	oBrush1:End()
		
		//aSessao[1] - Título da sessão do relatório
		//aSessao[2] - Posição da descrição
		//aSessao[3] - Fonte da sessão
	oPrint:Say( nLin+15, aSessao[2], "Data Histórico: " + alltochar((TMP)->NT6_DTALT), aSessao[3])

	nLin+=80
	nLinCalc := nLin
Else
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Say( nLin+15, aSessao[2], aSessao[1], aSessao[3])
	
	nLin+=70
	nLinCalc := nLin
EndIf


Return

//-------------------------------------------------------------------
/*/{Protheus.doc} AtuNT6
Atualiza a tabela NT6, com os campos de valores da tabela NSY que apenas
são atualizados na correção de valores e correção monetária

@param	 cPedido -  
@author  Rafael Tenorio da Costa
@since   20/10/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function AtuNT6( cPedido )

	Local aArea  	:= GetArea()
	Local aAreaSX3 	:= SX3->( GetArea() )
	Local aAreaNT6 	:= NT6->( GetArea() )
	Local cQuery 	:= ""
	Local cCampoNT6	:= "" 
	Local cCampoNSY	:= ""
	Local aRetorno	:= {}
	Local lIncluiNT6:= .T. 

	cQuery += " SELECT NT6_FILIAL, NT6_CPEDID, NT6_COD, NT6_CINSTA" 
	cQuery += " FROM " + RetSqlName("NT6")
	cQuery += " WHERE NT6_CPEDID = '" +cPedido+ "'" 
	cQuery += 	" AND NT6_COD	 = (SELECT MAX(NT6_COD) FROM " + RetSqlName("NT6") + " WHERE NT6_CPEDID = '" +cPedido+ "' AND D_E_L_E_T_ = ' ')"
	cQuery += 	" AND NT6_CINSTA = '" + NSY->NSY_CINSTA + "'" 
	cQuery += 	" AND NT6_CDECPE = '" + NSY->NSY_CDECPE + "'" 
	cQuery += 	" AND NT6_CPROG  = '" + NSY->NSY_CPROG 	+ "'"
	cQuery += 	" AND NT6_PEVLR  = '" + cValToChar(NSY->NSY_PEVLR) 	+ "'"
	cQuery += 	" AND NT6_VLCONT = '" + cValToChar(NSY->NSY_VLCONT) + "'"
	cQuery += 	" AND D_E_L_E_T_ = ' '"
	 
	aRetorno := JurSQL(cQuery, {"NT6_FILIAL", "NT6_CPEDID", "NT6_COD", "NT6_CINSTA"})

	If Len(aRetorno) > 0
	
		lIncluiNT6 := .F.
		
		DbSelectArea("NT6")
		NT6->( DbSetOrder(1) )	//NT6_FILIAL, NT6_CPEDID, NT6_COD
		NT6->( DbSeek(aRetorno[1][1] + aRetorno[1][2] + aRetorno[1][3]) )
	Else
	
		lIncluiNT6 := .T.
	EndIf
	
	SX3->( DbSetOrder(1) )	//X3_ARQUVIO + X3_ORDEM
	If SX3->( DbSeek("NT605") )
	
		Begin Transaction
		RecLock("NT6", lIncluiNT6)
			
			If lIncluiNT6
				NT6->NT6_FILIAL := NSY->NSY_FILIAL
				NT6->NT6_COD    := GetSxeNum("NT6", "NT6_COD")
				NT6->NT6_CPEDID := NSY->NSY_COD
				NT6->NT6_DTALT  := Date()
				NT6->NT6_USUALT := USRRETNAME(__CUSERID)
			EndIf
				
			While !SX3->( Eof() ) .And. SX3->X3_ARQUIVO == "NT6"
			
				cCampoNT6 := AllTrim(SX3->X3_CAMPO)
				cCampoNSY := StrTran(cCampoNT6, "NT6", "NSY")
				
				If NSY->(FieldPos(cCampoNSY)) > 0 
					NT6->&(cCampoNT6) := NSY->&(cCampoNSY)
				EndIf
				
				SX3->( DbSkip() )
			EndDo
			
			If lIncluiNT6
				ConfirmSX8()
			EndIf	
			
		NT6->( MsUnLock() )
		End Transaction
	EndIf 

	Asize(aRetorno, 0)
	
	RestArea( aAreaNT6 )
	RestArea( aAreaSX3 )
	RestArea( aArea )

Return Nil
