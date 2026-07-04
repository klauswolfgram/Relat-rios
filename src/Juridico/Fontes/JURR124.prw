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
#INCLUDE "JURR124.CH"

#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   3000 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     2350 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR124(cUser, cThread)
Regras do relatório de Concessões

@param aFiltro Filtros utilizados na pesquisa de follow-up
@param lAtvAnd Indica se os Andamentos devem ser apresentados no relatório

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR124(cUser, cThread)
	Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) 	// Fonte usada no nome do relatório
	Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
	Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
	Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões

	Local cQuery     := ""
	Local aRelat     := {}
	Local aCabec     := {}
	Local aSessao    := {}

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
	aRelat := {STR0001,2700/2,oFont} //"Relatório de Concessões"

//Cabeçalho do Relatório
  // 1 - Título, 
  // 2 - Conteúdo, 
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título, 
  // 5 - Fonte da descrição
//aCabec := {{"Data Compromisso: "   ,DToC(Date()) ,(nTamCarac*16),oFontTit,oFontDesc}}//,;
	aCabec := {{STR0019,DToC(Date()) ,(nTamCarac*8),oFontTit,oFontDesc}}//,;

//Campos do Relatório
  //Exemplo da primeira parte -> aAdd(aSessao, {"Relatório de Concessões",65,oFontSub,.F.,;// 
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

aAdd(aSessao, {STR0002,65,oFontSub,.F.,,; // Título da sessão do relatório "Detalhe"
		{STR0003 /*"Empresa"      */,"NT9" ,"NT9_CEMPCL" ,"NT9_CEMPCL" ,"C",060 ,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{"" /*"Cod Loja"          */,"NT9" ,"NT9_LOJACL" ,"NT9_LOJACL" ,"C",150 ,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0004 /*"Nome"         */,"NT9" ,"NT9_NOME "  ,"NT9_NOME "  ,"C",250 ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0005 /*"Tipo Envol."  */,"NQA" ,"NQA_DESC"   ,"NQA_DESC"   ,"C",850 ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0007 /*"Gênero"       */,"NWV" ,"NWV_DESC"   ,"NWV_DESC"   ,"C",1500,1200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0008 /*"Espécie"      */,"NWX" ,"NWX_DESC"   ,"NWX_DESC"   ,"C",2250,1200,oFontTit,oFontDesc,(nTamCarac*12),.T.},;
		{STR0006 /*"Particip."    */,"NT9" ,"NT9_QTPARC" ,"NT9_QTPARC" ,"C",060 ,150 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0009 /*"Abrangência"  */,"NWY" ,"NWY_DESC"   ,"NWY_DESC"   ,"C",250 ,1500,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0010 /*"Município"    */,"CC2" ,"CC2_MUN"    ,"CC2_MUN"    ,"C",1500,800 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0011 /*"Ini. Outorga" */,"NWU" ,"NWU_DTINIO" ,"NWU_DTINIO" ,"D",2100,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0012 /*"Vcto.Outorga" */,"NWU" ,"NWU_DTVENO" ,"NWU_DTVENO" ,"D",2300,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0013 /*"Ini.Renov."   */,"NWU" ,"NWU_DTINIP" ,"NWU_DTINIP" ,"D",2500,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0014 /*"Fim Renov."   */,"NWU" ,"NWU_DTFIMP" ,"NWU_DTFIMP" ,"D",2700,200 ,oFontTit,oFontDesc,(nTamCarac*12),.T.}})

aAdd(aSessao, {STR0015,65,oFontSub,.F.,J124QrResu(),; // Título da sessão do relatório "Resumo"
		{STR0016 /*"Cod Cliente"  */,"NT9" ,"NT9_CEMPCL" ,"NT9_CEMPCL" ,"C",060 ,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0017 /*"Loja"         */,"NT9" ,"NT9_LOJACL" ,"NT9_LOJACL" ,"C",230 ,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0004 /*"Nome"         */,"NT9" ,"NT9_NOME "  ,"NT9_NOME "  ,"C",370 ,900,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0018 /*"Estado"       */,"NWU" ,"NWU_ESTADO" ,"NWU_ESTADO" ,"C",1050,300,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0007 /*"Gênero"       */,"NWV" ,"NWV_DESC"   ,"NWV_DESC"   ,"C",1250,1200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0008 /*"Espécie"      */,"NWX" ,"NWX_DESC"   ,"NWX_DESC"   ,"C",2150,1200,oFontTit,oFontDesc,(nTamCarac*12),.T.}})

		JRelatorio(aRelat,aCabec,aSessao,J124QrFila(cUser, cThread)) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J124QrFila(cUser, cThread)
Gera a query principal do relatório
 
Uso Geral.

@param aFiltro Filtros que foram utilizados na pesquisa de Concessões

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J124QrFila(cUser, cThread)
	Local cQuery := ""

	cQuery := "SELECT NQ3.NQ3_CAJURI CAJURI" + CRLF
	cQuery += " FROM " + RetSqlName("NQ3") + " NQ3 " + CRLF
	cQuery += " WHERE NQ3.D_E_L_E_T_ = ' ' " + CRLF
	cQuery +=   " AND NQ3.NQ3_FILIAL = '" + xFilial("NQ3") + "' " + CRLF
	cQuery +=   " AND NQ3.NQ3_SECAO  = '" + cThread        + "' " + CRLF
	cQuery +=   " AND NQ3.NQ3_CUSER  = '" + cUser          + "' " + CRLF
	cQuery += " ORDER BY NQ3.NQ3_CAJURI"

	cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J124QrPrin(cCajuri)
Gera a query principal do relatório
 
Uso Geral.

@param aFiltro Filtros que foram utilizados na pesquisa de Concessões

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J124QrPrin(cCajuri)
	Local cQuery := ""

	cQuery := "SELECT NT9.NT9_CEMPCL, NT9.NT9_LOJACL, NT9.NT9_NOME, NT9.NT9_QTPARC, NT9.NT9_PRINCI, " + CRLF
	cQuery += "NQA.NQA_DESC, NWV.NWV_DESC, NWX.NWX_DESC, NWY.NWY_DESC, CC2.CC2_MUN, NWU.NWU_DTINIO, " + CRLF
	cQuery += "NWU.NWU_DTVENO, NWU.NWU_DTINIP, NWU.NWU_DTFIMP, NWU.NWU_COD, NWU.NWU_CAJURI, " + CRLF
	cQuery += "NT9.NT9_CAJURI, NWU.NWU_CESPEC, NWU.NWU_CGENER " + CRLF
	cQuery += " FROM " + RetSqlName("NT9") + " NT9 " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWU") + " NWU ON ( " + CRLF
	cQuery +=   " NT9.NT9_CAJURI = NWU.NWU_CAJURI AND " + CRLF
	cQuery +=   " NWU.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWU.NWU_FILIAL = '"+xFilial("NWU")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWV") + " NWV ON ( " + CRLF
	cQuery +=   " NWU.NWU_CGENER = NWV.NWV_COD AND " + CRLF
	cQuery +=   " NWV.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWV.NWV_FILIAL = '"+xFilial("NWV")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWX") + " NWX ON ( " + CRLF
	cQuery +=   " NWU.NWU_CESPEC = NWX.NWX_COD AND " + CRLF
	cQuery +=   " NWX.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWX.NWX_FILIAL = '"+xFilial("NWX")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWY") + " NWY ON ( " + CRLF
	cQuery +=   " NWU.NWU_CAREA  = NWY.NWY_COD AND " + CRLF
	cQuery +=   " NWY.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWY.NWY_FILIAL = '"+xFilial("NWY")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("CC2") + " CC2 ON ( " + CRLF
	cQuery +=   " NWU.NWU_ESTADO = CC2.CC2_EST AND " + CRLF
	cQuery +=   " NWU.NWU_CMUNIC = CC2.CC2_CODMUN AND " + CRLF
	cQuery +=   " CC2.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " CC2.CC2_FILIAL = '"+xFilial("CC2")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NQA") + " NQA ON ( " + CRLF
	cQuery +=   " NT9.NT9_CTPENV = NQA.NQA_COD AND " + CRLF
	cQuery +=   " NQA.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NQA.NQA_FILIAL = '"+xFilial("NQA")+"') " + CRLF
	cQuery += " WHERE NT9.NT9_PRINCI = '1' AND" + CRLF
	cQuery +=       " NT9.NT9_CAJURI = '"+cCajuri+"' AND " + CRLF
	cQuery +=       " NT9.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=       " NT9.NT9_FILIAL = '"+xFilial("NT9")+"'" + CRLF
	cQuery += " ORDER BY NWU.NWU_COD, NT9.NT9_CEMPCL, NT9.NT9_LOJACL "

	cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J124QrResu()
Gera a query do relatório resumo 
 
Uso Geral.

@param aFiltro Filtros que foram utilizados na pesquisa de Concessões

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J124QrResu()
	Local cQuery := ""

	cQuery := "SELECT NT9.NT9_CEMPCL, NT9.NT9_LOJACL, NT9.NT9_CAJURI, NT9.NT9_NOME, NWX.NWX_DESC, " + CRLF
	cQuery += "NWV.NWV_DESC, NWU.NWU_COD, NWU.D_E_L_E_T_, NWU.NWU_ESTADO, NWU.NWU_CAJURI " + CRLF
	cQuery += " FROM " + RetSqlName("NT9") + " NT9 " + CRLF
	cQuery += " INNER JOIN " + RetSqlName("NWU") + " NWU ON ( " + CRLF
	cQuery +=   " NT9.NT9_CAJURI  = NWU.NWU_CAJURI AND " + CRLF
	cQuery +=   " NWU.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWU.NWU_FILIAL = '"+xFilial("NWU")+"') " + CRLF
	//cQuery +=   " AND NWU.NWU_CGENER = '@#NWU_CGENER#@' " + CRLF
	//cQuery +=   " AND NWU.NWU_CESPEC = '@#NWU_CESPEC#@' " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWV") + " NWV ON ( " + CRLF
	cQuery +=   " NWU.NWU_CGENER  = NWV.NWV_COD AND " + CRLF
	cQuery +=   " NWV.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWV.NWV_FILIAL = '"+xFilial("NWV")+"') " + CRLF
	cQuery += " LEFT OUTER JOIN " + RetSqlName("NWX") + " NWX ON ( " + CRLF
	cQuery +=   " NWU.NWU_CESPEC = NWX.NWX_COD AND " + CRLF
	cQuery +=   " NWX.D_E_L_E_T_ = ' ' AND " + CRLF
	cQuery +=   " NWX.NWX_FILIAL = '"+xFilial("NWX")+"') " + CRLF
	cQuery += " WHERE NT9.D_E_L_E_T_ = ' '"+ CRLF
	cQuery +=   " AND NT9.NT9_FILIAL = '"+xFilial("NT9")+"' " + CRLF
	cQuery +=   " AND NT9.NT9_CAJURI = '@#NT9_CAJURI#@' " + CRLF
	//cQuery +=   " AND NWU.NWU_COD = '@#NWU_COD#@' " + CRLF
	cQuery += " ORDER BY NWU.NWU_COD " 

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

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat,aCabec,aSessao,cQuery)

	Local cNomeRel  := aRelat[1] //Nome do Relatório
	Local lHori     := .F.
	Local lQuebPag  := .F.
	Local lTitulo   := .T.
	Local lLinTit   := .F.
	Local lValor    := .F.
	Local nI        := 0    // Contador
	Local nJ        := 0    // Contador
	Local nX        := 0    // Contador
	Local nLin      := 0    // Linha Corrente
	Local nLinCalc  := 0    // Contator de linhas - usada para os cálculos de novas linhas
	Local nLinCalc2 := 0
	Local nLinFinal := 0
	Local nConta    := 0
	Local oPrint    := Nil
	Local aDados    := {}
	Local aResumo   := {}
	Local cCodgrp   := ""
	Local cQuerySub := ""
	Local cTxt      := ""
	Local cVar      := "" // CAMPO
	Local xValor    // Valor do campo
	Local RELAT     := GetNextAlias()
	Local TMP

	oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF" ) // Inicia o relatório

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),RELAT,.T.,.T.)

	If (RELAT)->(!EOF())

		While (RELAT)->(!EOF())

			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada

			nConta := 0
			cQuery := J124QrPrin((RELAT)->CAJURI)
			TMP    := GetNextAlias()
			
			DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),TMP,.T.,.T.)
		
			If (TMP)->(!EOF())
		
				ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Imprime cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
		
				While (TMP)->(!EOF())
		
					If nLin >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
						oPrint:EndPage() // Se for maior, encerra a página atual
						ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
						nConta := 0
						nLinCalc := nLin // Inicia o controle das linhas impressas
						lTitulo := .T. // Indica que o título pode ser impresso
						lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
					EndIf
		
					For nI := 1 To Len(aSessao) // Inicia a impressão de cada sessão do relatório
					
						lValor := .F.
						lHori  := aSessao[nI][4]
					
						If !Empty(aSessao[nI][5]) // Nessa posição é indicada a query de um subreport
						
							cQuerySub := aSessao[nI][5]
							
							cTxt := cQuerySub
							cVar    := "" // CAMPO
							
							While RAT("#@", cTxt) > 0 // Substitui os nomes dos campos passados na query por seus respectivos valores
								cVar     := SUBSTR(cTxt,AT("@#", cTxt) + 2,AT("#@", cTxt) - (AT("@#", cTxt) + 2))
								xValor   := (TMP)->(FieldGet(FieldPos(cVar)))
								cTxt     := SUBSTR(cTxt, 1,AT("@#", cTxt)-1) + ALLTRIM(xValor) + SUBSTR(cTxt, AT("#@", cTxt)+2)
							End

							cQuerySub := cTxt

							If Len(aResumo) == 0
								aAdd(aResumo,{cQuerySub,aSessao[nI],aRelat, aCabec, .T., .F.})
							EndIf

						Else
		
							nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
				                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 
		
							nLinFinal := 0 // Limpa a variável
		
							For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
								cTabela  := aSessao[nI][nJ][2] //Tabela
								cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
								cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
								cTipo    := aSessao[nI][nJ][5] //Tipo do campo
								cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
								
								If !lValor .And. !Empty(AllTrim(cValor))
									lValor := .T.
								EndIf
								
								aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
							Next nJ
						
							nLinCalc := nLinCalc2 // Retorno do valor original da variável
						
							If lQuebPag // Verifica se é necessário ocorrer a quebra de pagina
								oPrint:EndPage() // Se é necessário, encerra a página atual
								ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
								nConta := 0
								nLinCalc := nLin // Inicia o controle das linhas impressas
								lQuebPag := .F. // Limpa a variável de quebra de página
								lTitulo  := .T. // Indica que o título pode ser impresso
								lLinTit  := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
							EndIf

							If lTitulo .And. !Empty(aSessao[nI][1])
								If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
									oPrint:EndPage() // Se for maior, encerra a página atual
									ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
									nConta := 0
									nLinCalc := nLin // Inicia o controle das linhas impressas
									lTitulo := .T. // Indica que o título pode ser impresso
									lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
								EndIf
								If lValor .And. nConta == 0 // Se existir valor a ser impresso na sessão imprime o título da sessão.
									JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], 1) //Imprime o título da sessão no relatório
									nConta := 1
								EndIf
							EndIf

						//Imprime os campos do relatório
							JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, lTitulo, lLinTit, aRelat,aCabec)
						
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
				
					cCodgrp := alltochar((TMP)->NWU_COD)
				
					(TMP)->(DbSkip())
				Enddo
		
				If Len(aResumo) > 0
					JImpTitSes(@oPrint, @nLin, @nLinCalc, aResumo[1][2], 1) //Imprime o título da sessão no relatório
					For nI := 1 to Len(aResumo)
						JImpSub(aResumo[nI][1], /*TMP,*/ aResumo[nI][2],@nLinCalc,@lQuebPag, aResumo[nI][3], aResumo[nI][4], @oPrint, @nLin, aResumo[nI][5], aResumo[nI][6]) // Imprime os dados do subreport
					Next
				EndIf
				
				aResumo := {}
		
				(TMP)->(dbCloseArea())

			EndIf

			(RELAT)->(DbSkip())
			
		Enddo

		(RELAT)->(dbCloseArea())
		
		aSize(aDados,0)  //Limpa array de dados
//		aSize(aRelat,0)  //Limpa array de dados do relatório
//		aSize(aCabec,0)  //Limpa array de dados do cabeçalho do relatório
		aSize(aSessao,0) //Limpa array de dados das sessões do relatório
		aSize(aResumo,0)

		oPrint:EndPage() // Finaliza a página

		oPrint:CFILENAME := cNomeRel + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
		oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
		oPrint:Print()

		FErase(oPrint:CFILEPRINT)
		
	EndIf

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
	Local nPosTit    := 0
	Local nPosValor  := 0
	Local nSaltoCabe := 10
	Local nI         := 0
	Local oFontTit
	Local oFontValor
	Local oFontRoda  := TFont():New("Arial",,-8,,.F.,,,,.T.,.F.) // Fonte usada no Rodapé

//oPrint:SetPortrait()   // Define a orientação do relatório como retrato (Portrait).

	oPrint:SetLandscape()

	oPrint:SetPaperSize(9) //A4 - 210 x 297 mm

// Inicia a impressao da pagina
	oPrint:StartPage()
	oPrint:Say( nFimL, nColFim - 100, alltochar(oPrint:NPAGECOUNT), oFontRoda )
//oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
//oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
	nLin := 150

// Imprime o cabecalho
	oPrint:Say( nLin, nColTit, cTit, oFontTit )
//nLin := 40

	nLin += 2*nSaltoCabe // Espaço para que o cabeçalho fique um pouco abaixo do Título do Relatório

	If Len(aCabec) > 0
		If !EMPTY(aCabec[1][1])
			For nI := 1 to Len(aCabec)
				cTitulo    := aCabec[nI][1] // Título
				cValor     := aCabec[nI][2] // Conteúdo
				nPosValor  := aCabec[nI][3] // Posição do conteúdo (considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. Para isso considere sempre a posição da maior descrição)
				oFontTit   := aCabec[nI][4] // Fonte do título
				oFontValor := aCabec[nI][5] // Fonte do conteúdo
		
				oPrint:Say( nLin += nSaltoCabe, 070                        , cTitulo + ":" , oFontTit   ) //Imprime o Título
				oPrint:Say( nLin              , nPosValor + (nTamCarac * 4), cValor        , oFontValor ) //Imprime o Conteúdo - Esse (nTamCarac * 4) é para dar um espaço de 4 caracteres a mais do que o tamanho da descrição
			Next
		EndIf
	EndIf

	nLin+=20
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório

	nLin+=40 //Recalcula a linha de referência para impressão

Return nil

//-------------------------------------------------------------------
/*/{Protheus.doc} JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,SUB,lSub)
Trata os tipos de campos e imprime os valores
 
Uso Geral.

@param cTabela Nome da tabela
@param cCpoTab Nome do campo na tabela
@param cCpoQry Nome do campo na query
@param cTipo   Tipo do campo
@param TMP     Alias aberto da query principal
@param SUB     Alias aberto da query do sub relatório que esta sendo impresso
@param lSub    Indica se é um sub relatório

@return cValor Valor do campo na Query

@author Jorge Luis Branco Martins Junior
@since 15/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,SUB,lSub)
	Local cValor := ""
	Local cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")
	Local lPicture := Iif(Empty(cPicture),.F.,.T.)

	If lSub
		If cTipo == "D" // Tipo do campo
			TCSetField(SUB, cCpoQry 	, "D") //Muda o tipo do campo para data.
			cValor   := AllTrim(AllToChar((SUB)->&(cCpoQry))) //Conteúdo a ser gravado
		ElseIf cTipo == "M"
			DbSelectArea(cTabela)
			(cTabela)->(dbGoTo((SUB)->&(cCpoQry))) // Esse seek é para retornar o valor de um campo MEMO
			cValor := AllTrim(AllToChar((cTabela)->&(cCpoTab) )) //Retorna o valor do campo
		Else
			cValor := AllTrim(AllToChar((SUB)->&(cCpoQry)))
		EndIf
	Else
		If cTipo == "D" // Tipo do campo
			TCSetField(TMP, cCpoQry 	, "D") //Muda o tipo do campo para data.
			cValor   := AllTrim(AllToChar((TMP)->&(cCpoQry))) //Conteúdo a ser gravado
		ElseIf cTipo == "M"
			DbSelectArea(cTabela)
			(cTabela)->(dbGoTo((TMP)->&(cCpoQry))) // Esse seek é para retornar o valor de um campo MEMO
			cValor := AllTrim(AllToChar((cTabela)->&(cCpoTab) )) //Retorna o valor do campo
		ElseIf cTipo == "N"
			TcSetField(TMP, cCpoQry, 'N', TamSX3(cCpoTab)[1], TamSX3(cCpoTab)[2] )
			If lPicture
				cValor   := TRANSFORM((TMP)->&(cCpoQry), cPicture)
				cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
			Else
				cValor := AllTrim(CVALTOCHAR((TMP)->&(cCpoQry)))
			EndIf
		ElseIf cTipo == "O" // Lista de opções
			cValor := JTrataCbox( cCpoTab, AllTrim(AllToChar((TMP)->&(cCpoQry))) ) //Retorna o valor do campo
		Else
			cValor := AllTrim(AllToChar((TMP)->&(cCpoQry)))
		EndIf
	EndIf

Return cValor

//-------------------------------------------------------------------
/*/{Protheus.doc} JImpSub(cQuerySub, TMP, aSessao, nLinCalc,lQuebPag, aRelat, aCabec, oPrint, nLin, lTitulo, lLinTit)
Imprime o sub relatório
 
Uso Geral.

@param cQuerySub  Query do sub Relatório
@param TMP         Alias aberto da query principal 
@param aSessao    Dados do conteúdo do relatório
@param nLinCalc   Variável de cálculo de linhas
@param lQuebPag   Indica se deve existir quebra de pagina
@param aRelat     Dados do título do relatório
@param aCabec     Dados do cabeçalho do relatório
@param oPrint     Objeto do Relatório (TMSPrinter)
@param nLin       Linha Corrente
@param lTitulo    Indica se o titulo de ser impresso
@param lLinTit    Indica se a linha onde será impresso o titulo foi definida 

@return nil

@author Jorge Luis Branco Martins Junior
@since 18/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpSub(cQuerySub, /*TMP,*/ aSessao, nLinCalc, lQuebPag ,aRelat , aCabec, oPrint, nLin, lTitulo, lLinTit)
	Local cParam := ""
	Local nI
	Local nJ
	Local cValor := ""
	Local aDados := {}
	Local SUB := GetNextAlias()
	Local lHori := aSessao[4]
	Local cTxt := cQuerySub
	Local cVar    := "" // CAMPO
	Local xValor        // Valor do campo
	Local lTitSes := .F. // Indica se já imprimiu o título da sessão
	Local nConta := 0
	
	cQuerySub := cTxt

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySub),SUB,.T.,.T.)

	While (SUB)->(!EOF())

		If nLin >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
			oPrint:EndPage() // Se for maior, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf
		
		nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
		                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 
		
		For nJ := 6 to Len(aSessao) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
			
			nLinFinal := 0 // Limpa a variável
						
			cTabela  := aSessao[nJ][2] //Tabela
			cCpoTab  := aSessao[nJ][3] //Nome do campo na tabela
			cCpoQry  := aSessao[nJ][4] //Nome do campo na query
			cTipo    := aSessao[nJ][5] //Tipo do campo
			cValor   := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,,SUB,.T.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data

			aAdd(aDados,JDadosCpo(aSessao[nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
		Next

		nLinCalc := nLinCalc2 // Retorno do valor original da variável

		If lQuebPag // Verifica se é necessário ocorrer a quebra de pagina
			oPrint:EndPage() // Se é necessário, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lQuebPag := .F. // Limpa a variável de quebra de página
			lTitulo  := .T. // Indica que o título pode ser impresso
			lLinTit  := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf

		If lTitulo .And. !Empty(aSessao[1])
			If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
				oPrint:EndPage() // Se for maior, encerra a página atual
				ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
				lTitulo := .T. // Indica que o título pode ser impresso
				lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
			EndIf

		EndIf
		
		If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
			// Os títulos devem ser impressos
			lTitulo := .T. // Indica que o título pode ser impresso
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf
		
		If nConta > 0 // Sessões que são na vertical e aparecem o título somente no topo uma única vez, e não registro a registro 
			lTitulo := .F.
			lLinTit := .T.
		Else
			nConta  := 1
		EndIf
		
		//Imprime os campos do relatório
		JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, lTitulo, lLinTit, aRelat,aCabec)
		//Limpa array de dados
		aSize(aDados,0)
		aDados := {}

		nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
		
		nLinFinal := 0 // Limpa a variável
		
		nLin := nLinCalc
	
		(SUB)->(DbSkip())
	End

	aSize(aDados,0)

	(SUB)->(dbCloseArea())

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
	Local cTabela := ""
	Local cCpoTab := ""
	Local cCpoQry := ""
	Local cTipo   := ""
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
	Local nJ, nX
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
	Local nForTo   := 0
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
		JImpRel(aSobra,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, lTitulo, lLinTit, aRelat,aCabec, @lSalta)
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
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao, nTipo)
	Local oBrush1

	Default nTipo := 0

	If nTipo == 0
/*
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	
		oBrush1 := TBrush():New( , CLR_LIGHTGRAY )
		oPrint:FillRect( {nLin-20, nColIni, (nLin + 30), nColFim}, oBrush1 )
		oBrush1:End()
		
		//aSessao[1] - Título da sessão do relatório
		//aSessao[2] - Posição da descrição
		//aSessao[3] - Fonte da sessão

//		oPrint:Say( nLin+15, aSessao[2], "Grupo: " + alltochar((TMP)->NWU_COD), aSessao[3])

		//oPrint:Say( nLin+15, aSessao[2], aSessao[1] + ": " + alltochar((TMP)->NT6_DTALT), aSessao[3])
		
		nLin+=80
		nLinCalc := nLin
*/
	Else
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
		
	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão

		oPrint:Say( nLin+15, aSessao[2], aSessao[1], aSessao[3])
	
		nLin+=70
		nLinCalc := nLin
	EndIf

Return