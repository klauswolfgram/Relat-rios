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
#INCLUDE "JURR106P.CH"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   3000 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     2350 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} JURR106(cUser, cThread, cNomeTar, cCaminho, lAutomato, aFilAtiv, cDataIni, cDataFim, cTipos, cStatus, cResp)
Regras do relatório de Follow-ups

@param cUser Usuario
@param cThread Seção
@param cNomeTar Nome enviado quando chamado pelo TOTVS LEGAL
@param cCaminho Caminho do arquivo quando chamado pelo TOTVS LEGAL  
@param lAutomato - Indica se é execução de automação
@param aFilAtiv  - Filtros do painel de atividades (Favoritos / Processos que cuido)
@param cDataIni  - Data inicio
@param cDataFim  - Data Fim
@param cTipos    - Tipos de follow-up
@param cStatus   - Status de follow-up
@param cResp     - Responsáveis do follow-up
@param lRelPauta - Indica se o relatório é de pauta

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR106P(cUser, cThread, cNomeTar, cCaminho, lAutomato)
Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) // Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}

Default cNomeTar  := ""
Default cCaminho  := ""
Default lAutomato := .F.
// Criar o Default dos outros parametros
Default lRelPauta := .F.

	//Título do Relatório
	// 1 - Título,
	// 2 - Posição da descrição,
	// 3 - Fonte do título
	aRelat := {STR0001,65,oFont} //"Pauta de Compromissos"

	//Cabeçalho do Relatório
	// 1 - Título, 
	// 2 - Conteúdo, 
	// 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
	//     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
	//     Para isso considere sempre a posição da maior descrição),
	// 4 - Fonte do título, 
	// 5 - Fonte da descrição
	//aCabec := {{"Data Compromisso: "   ,DToC(Date()) ,(nTamCarac*16),oFontTit,oFontDesc}}//,;
	aCabec := {{""   ,"" ,(nTamCarac*16),oFontTit,oFontDesc}}//,;

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
	aAdd(aSessao, {STR0002 /*"Data Compromisso: "*/,65,oFontSub,.F.,,;
				{STR0003 /*"Data"*/               ,"NTA","NTA_DTFLWP","NTA_DTFLWP"  ,"D",65  ,500 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0004 /*"Horário"*/            ,"NTA","NTA_HORA"  ,"NTA_HORA"    ,"C",300 ,500 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0005 /*"Responsável"*/        ,"RD0","RD0_NOME"  ,"J106QrResp()","C",500 ,680 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0006 /*"Tipo"*/               ,"NQS","NQS_DESC"  ,"NQS_DESC"    ,"C",1000,500 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0007 /*"Status"*/             ,"NQN","NQN_DESC"  ,"NQN_DESC"    ,"C",1400,500 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0008 /*"Cliente"*/            ,"SA1","A1_NREDUZ" ,"A1_NREDUZ"   ,"C",1800,500 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0009 /*"Caso"*/               ,"NVE","NVE_TITULO","NVE_TITULO"  ,"C",2200,1300,oFontTit,oFontDesc,(nTamCarac),.T.},;
				{STR0010 /*"Descrição"*/          ,"NTA","NTA_DESC"  ,"RECNONTA"    ,"M",65  ,5000,oFontTit,oFontDesc,(nTamCarac),.T.}})

	aAdd(aSessao, {"",65,oFontSub,.F.,J106QryIns(),;// Título da sessão do relatório
				{STR0011 /*"Número do Processo"*/ ,"NUQ","NUQ_NUMPRO","NUQ_NUMPRO"  ,"C",65  ,600 ,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0012 /*"Comarca"*/            ,"NQ6","NQ6_DESC"  ,"NQ6_DESC"    ,"C",500 ,1000,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0013 /*"Foro / Tribunal"*/    ,"NQC","NQC_DESC"  ,"NQC_DESC"    ,"C",1100,1000,oFontTit,oFontDesc,(nTamCarac),.F.},;
				{STR0014 /*"Vara / Câmara"*/      ,"NQE","NQE_DESC","NQE_DESC"      ,"C",1700,1000,oFontTit,oFontDesc,(nTamCarac),.T.},;
				{STR0015 /*"Observações"*/        ,"NUQ","NUQ_OBSERV","RECNONUQ"    ,"M",65  ,5000,oFontTit,oFontDesc,(nTamCarac),.F.}})

	aAdd(aSessao, {"",65,oFontSub,.T.,,;// Título da sessão do relatório
				{STR0016 /*"Envolvidos"*/         ,"NT9","NT9_NOME","J106QryEnv()"  ,"C",65  ,4400,oFontTit,oFontDesc,(nTamCarac*10),.T.}})

	JRelatorio(aRelat,aCabec,aSessao,J106QrPrin(cUser, cThread), cNomeTar, cCaminho, lAutomato, cThread) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QrPrin(cUser, cThread)
Gera a query principal do relatório
 
Uso Geral.

@param cUser    - Usuario logado
@param cThread  - Seção do usuário

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QrPrin(cUser, cThread)
Local cQuery := ""

	cQuery :=  " SELECT SA1.A1_NREDUZ,"
	cQuery +=         " NTA.NTA_HORA,"
	cQuery +=         " NQS.NQS_DESC,"
	cQuery +=         " NTA.NTA_DTFLWP,"
	cQuery +=         " NQN.NQN_DESC,"
	cQuery +=         " NTA.NTA_COD,"
	cQuery +=         " NTA.NTA_FILIAL,"
	cQuery +=         " NTA.NTA_CAJURI,"
	cQuery +=         " NVE.NVE_TITULO,"
	cQuery +=         " NTA.R_E_C_N_O_ RECNONTA"
	cQuery +=    " FROM " + RetSqlName("NTA") + " NTA "
	cQuery +=   " INNER JOIN " + RetSqlName("NWG") + " NWG"
	cQuery +=      " ON ( NTA.D_E_L_E_T_ = NWG.D_E_L_E_T_"
	cQuery +=     " AND NTA.NTA_FILIAL = NWG.NWG_FILORI"
	cQuery +=     " AND NTA.NTA_CAJURI = NWG.NWG_CAJURI"
	cQuery +=     " AND NTA.NTA_COD = NWG.NWG_CODFOL )"
	cQuery +=   " INNER JOIN " + RetSqlName("NSZ") + " NSZ"
	cQuery +=      " ON ( NTA.D_E_L_E_T_ = NSZ.D_E_L_E_T_"
	cQuery +=     " AND NTA.NTA_FILIAL = NSZ.NSZ_FILIAL"
	cQuery +=     " AND NTA.NTA_CAJURI = NSZ.NSZ_COD )"
	cQuery +=   " INNER JOIN " + RetSqlName("NQS") + " NQS"
	cQuery +=      " ON ( NTA.D_E_L_E_T_ = NQS.D_E_L_E_T_"
	cQuery +=     " AND NQS.NQS_FILIAL = '" + xFilial("NQS") + "'"
	cQuery +=     " AND NTA.NTA_CTIPO = NQS.NQS_COD )"
	cQuery +=   " INNER JOIN " + RetSqlName("NQN") + " NQN"
	cQuery +=      " ON ( NTA.D_E_L_E_T_ = NQN.D_E_L_E_T_"
	cQuery +=     " AND NQN.NQN_FILIAL = '" + xFilial("NQN") + "'"
	cQuery +=     " AND NTA.NTA_CRESUL = NQN.NQN_COD )"
	cQuery +=    " LEFT JOIN " + RetSqlName("SA1") + " SA1" 
	cQuery +=      " ON ( NSZ.D_E_L_E_T_ = SA1.D_E_L_E_T_"
	cQuery +=     " AND SA1.A1_FILIAL = '" + xFilial("SA1") + "'"
	cQuery +=     " AND NSZ.NSZ_CCLIEN = SA1.A1_COD"
	cQuery +=     " AND NSZ.NSZ_LCLIEN = SA1.A1_LOJA )"
	cQuery +=   " INNER JOIN " + RetSqlName("NVE") + " NVE"
	cQuery +=      " ON ( NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_"
	cQuery +=     " AND NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN"
	cQuery +=     " AND NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN"
	cQuery +=     " AND NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS"

	If JCompTable("NVE") == 'EEE'
		cQuery += " AND NVE.NVE_FILIAL = NSZ.NSZ_FILIAL )"
	Else
		cQuery += " AND NVE.NVE_FILIAL = '" + xFilial("NVE") + "' )"
	EndIf

	cQuery +=   " WHERE NWG_CUSER = '" +cUser+ "'"
	cQuery +=     " AND NWG_SECAO = '" +cThread+ "'"
	cQuery +=     " AND NTA.D_E_L_E_T_ = ' '"
	cQuery +=   " ORDER BY NTA.NTA_DTFLWP, NTA.NTA_HORA"

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QryIns(cCajuri)
Gera a query do sub relatório de Instancias
 
Uso Geral.

@param cCajuri Codigo do assunto juridico posicionado

@Return cQueryIns Query do sub relatório de Instancias

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QryIns(cCajuri)
Local cQueryIns := ""

cQueryIns := " SELECT NUQ.NUQ_INSATU, NUQ.NUQ_NUMPRO, NUQ.NUQ_CAJURI, "
cQueryIns += "  NUQ.D_E_L_E_T_, NUQ.NUQ_FILIAL, NUQ.NUQ_INSTAN, "
cQueryIns += "  NQ6.NQ6_DESC, NQE.NQE_DESC, NQC.NQC_DESC, NUQ.R_E_C_N_O_ RECNONUQ  " 
cQueryIns += " FROM " + RetSqlName("NUQ") + " NUQ "
cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQ6") + " NQ6 " 
cQueryIns += "   ON (NUQ.NUQ_CCOMAR = NQ6.NQ6_COD ) " 
cQueryIns += "   AND (NUQ.D_E_L_E_T_ = NQ6.D_E_L_E_T_ ) "
cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQC") + " NQC " 
cQueryIns += "   ON ( NUQ.NUQ_CLOC2N = NQC.NQC_COD ) "
cQueryIns += "   AND (NUQ.D_E_L_E_T_ = NQC.D_E_L_E_T_ ) "
cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQE") + " NQE "
cQueryIns += "   ON ( NUQ.NUQ_CLOC3N = NQE.NQE_COD ) "
cQueryIns += "   AND ( NUQ.D_E_L_E_T_ = NQE.D_E_L_E_T_ ) "
cQueryIns += " WHERE NUQ.NUQ_INSATU = '1'"
cQueryIns += "   AND NUQ.NUQ_CAJURI =  '@#NTA_CAJURI#@'"  
cQueryIns += "   AND NUQ.NUQ_FILIAL = '@#NTA_FILIAL#@' "

Return cQueryIns

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QrResp(aDados, cFollowUp, cFilFup, cCajuri)
Busca o(s) responsável(eis) do follow-up e retorna o nome do(s) responsável(eis).

@param aDados    Array com os dados dos responsáveis pelos follow-ups
@param cFollowUp Codigo do Follow-up
@param cFilFUP   Filial do Follow-up
@param cCajuri   Cajuri do Follow-up

@Return cResp    Nome do(s) responsável(eis) do follow-up concatenados.

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QrResp(aDados, cFilFup, cCajuri, cFollowUp)
Local cResp := ""

	nI := aScan(aDados, {|x| x["filial"] == cFilFup .AND. ;
							 x["cajuri"] == cCajuri .AND. ;
							 x["codFup"] == cFollowUp})

	If nI > 0
		cResp := aDados[nI]["nomeResp"]
	EndIf

Return cResp

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QryEnv(cCajuri, cFilPro)
Gera a query do sub relatório de Envolvidos
Uso Geral.

@param cCajuri Codigo do assunto juridico posicionado
@param cFilPro Filial do assunto juridico posicionado

@Return cQueryEnv Query do sub relatório de envolvidos

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QryEnv(aDados, cFilPro, cCajuri, cFollowUp)
Local cEnv := ""

	nI := aScan(aDados, {|x| x["filial"] == cFilPro .AND. ;
							 x["cajuri"] == cCajuri .AND. ;
							 x["codFup"] == cFollowUp})

	If nI > 0
		cEnv := aDados[nI]["nomeEnv"]
	EndIf

Return cEnv
//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio(aRelat, aCabec, aSessao, cQuery, cNomeTar, cCaminho, lAutomato, cThread)
Executa a query principal e inicia a impressão do relatório.
Ferramenta TMSPrinter
Uso Geral.

@param aRelat   Dados do título do relatório
@param aCabec   Dados do cabeçalho do relatório
@param aSessao  Dados do conteúdo do relatório
@param cQuery   Query que será executada
@param cNomeTar Nome do arquivo enviado pelo TOTVS LEGAL
@param cCaminho Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param lAutomato - Indica se é execução de automação

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat, aCabec, aSessao, cQuery, cNomeTar, cCaminho, lAutomato, cThread)
Local cNomeRel  := ""
Local lHori     := .F.
Local lQuebPag  := .F.
Local lTitulo   := .T. 
Local lLinTit   := .F.
Local nI        := 0    // Contador
Local nJ        := 0    // Contador
Local nLin      := 0    // Linha Corrente
Local nLinCalc  := 0    // Contator de linhas - usada para os cálculos de novas linhas
Local nLinCalc2 := 0
Local nLinFinal := 0
Local oPrint    := Nil
Local aDados    := {}
Local aDadosRsp := {}
Local aDadosEnv := {}
Local cData     := ""
Local TMP       := GetNextAlias()


	cNomeRel := IIF( !Empty(cNomeTar) .AND. lAutomato, cNomeTar, aRelat[1] ) //Nome do Relatório

	If !lAutomato
		oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF", .T. ) // Inicia o relatório
	Else
		oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
		oPrint:CFILENAME  := cNomeRel
		oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
	EndIf

	// Busca os dados dos responsáveis do follow-up concatenando os nomes
	aDadosRsp := findRspFup(cThread)
	// Busca os dados dos envolvidos do follow-up concatenando os nomes
	aDadosEnv := findEnvFup(cThread)

	cQuery := ChangeQuery(cQuery)
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
				
				lHori := aSessao[nI][4]
				
				If !Empty(aSessao[nI][5]) // Nessa posição é indicada a query de um subreport
					JImpSub(aSessao[nI][5], TMP, aSessao[nI],@nLinCalc,@lQuebPag, aRelat, aCabec, @oPrint, @nLin, @lTitulo, @lLinTit) // Imprime os dados do subreport
				Else
					nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
										// que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 

					nLinFinal := 0 // Limpa a variável

					For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
						cTabela  := aSessao[nI][nJ][2] //Tabela
						cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
						cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
						cTipo    := aSessao[nI][nJ][5] //Tipo do campo

						If cCpoQry == "J106QrResp()"
							cValor := J106QrResp(aDadosRsp, (TMP)->NTA_FILIAL, (TMP)->NTA_CAJURI, (TMP)->NTA_COD)
						ElseIf cCpoQry == "J106QryEnv()"
							cValor := J106QryEnv(aDadosEnv, (TMP)->NTA_FILIAL, (TMP)->NTA_CAJURI, (TMP)->NTA_COD)
						Else
							cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
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

					If lTitulo .And. !Empty(aSessao[nI][1])
						If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
							oPrint:EndPage() // Se for maior, encerra a página atual
							ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
							nLinCalc := nLin // Inicia o controle das linhas impressas
							lTitulo := .T. // Indica que o título pode ser impresso 
							lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
						EndIf
						
					EndIf

					If nI == 1 .And. cData <> alltochar((TMP)->NTA_DTFLWP)
						JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], alltochar((TMP)->NTA_DTFLWP)) //Imprime o título da sessão no relatório
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

			cData := alltochar((TMP)->NTA_DTFLWP)

			(TMP)->(DbSkip())
		End

		(TMP)->(dbCloseArea())
		
		aSize(aDados, 0) //Limpa array de dados
		aSize(aRelat, 0) //Limpa array de dados do relatório
		aSize(aCabec, 0) //Limpa array de dados do cabeçalho do relatório
		aSize(aSessao,0) //Limpa array de dados das sessões do relatório
		
		oPrint:EndPage() // Finaliza a página

		If Empty(cNomeTar)
			oPrint:CFILENAME  := cNomeRel + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
			oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
		ElseIf !lAutomato
			oPrint:CFILENAME  := cNomeTar
			oPrint:CFILEPRINT := cCaminho + cNomeTar
		EndIf

		oPrint:Print()

		If Empty(cNomeTar)
			FErase(oPrint:CFILEPRINT)
		EndIf

	EndIf



Return(Nil)

//-------------------------------------------------------------------
/*/{Protheus.doc} findRspFup(cThread)
Busca os responsáveis pelos follow-ups e retorna um array com os dados concatenados.

@param cThread Seção do usuário
@Return aDadosRsp Array com os dados dos responsáveis pelos follow-ups

@author Victor Gonçalves
@since 10/07/2025
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function findRspFup(cThread)
Local oQuery     := Nil
Local aDadosRsp  := {}
Local aParams    := {}
Local cAlias     := GetNextAlias()
Local cQuery     := ""
Local cKey       := ""
Local cKeyAtual  := ""
Local nIndex     := 0

	cQuery := "SELECT NTE.NTE_FILIAL FILIAL,"
	cQuery +=       " NTE.NTE_CAJURI CAJURI,"
	cQuery +=       " NTE.NTE_CFLWP  CODFUP,"
	cQuery +=       " RD0.RD0_CODIGO CODRESP,"
	cQuery +=       " RD0.RD0_SIGLA  SIGLARESP,"
	cQuery +=       " RD0.RD0_NOME   NOMERESP"
	cQuery +=  " FROM " + RetSqlName("NWG") + " NWG"
	cQuery += " INNER JOIN " + RetSqlName("NTE") + " NTE"
	cQuery +=    " ON ( NTE.NTE_FILIAL = NWG.NWG_FILORI"
	cQuery +=   " AND NTE.NTE_CAJURI = NWG.NWG_CAJURI"
	cQuery +=   " AND NTE.NTE_CFLWP  = NWG.NWG_CODFOL"
	cQuery +=   " AND NTE.D_E_L_E_T_ = ' ')"
	cQuery += " INNER JOIN " + RetSqlName("RD0") + " RD0"
	cQuery +=    " ON ( RD0.RD0_CODIGO = NTE.NTE_CPART"
	cQuery +=   " AND RD0.RD0_FILIAL = '" + xFilial("RD0") + "'"
	cQuery +=   " AND RD0.D_E_L_E_T_ = ' ')"
	cQuery += " WHERE NWG.D_E_L_E_T_ = ' '"
	cQuery +=   " AND NWG.NWG_CUSER = ?"
	aAdd(aParams, {"C", __CUSERID})
	cQuery +=   " AND NWG.NWG_SECAO = ?"
	aAdd(aParams, {"C", cThread})
	cQuery += " ORDER BY NTE.NTE_FILIAL,"
	cQuery +=          " NTE.NTE_CAJURI,"
	cQuery +=          " NTE.NTE_CFLWP"

	oQuery := FWPreparedStatement():New(cQuery)
	oQuery := JQueryPSPr(oQuery, aParams)
	cQuery := oQuery:GetFixQuery()
	MpSysOpenQuery(cQuery, cAlias)

	While (cAlias)->(!EoF())
		// Concatena filial, cajuri e codfup para controle da concatenação dos responsáveis
		cKeyAtual := (cAlias)->FILIAL + Alltrim((cAlias)->CAJURI) + Alltrim((cAlias)->CODFUP)

		If !Empty(cKey) .AND. cKeyAtual == cKey
			// Concatena os dados do responsável no array
			aDadosRsp[nIndex]["codResp"]   += " / " + Alltrim((cAlias)->CODRESP)   // Código do responsável
			aDadosRsp[nIndex]["siglaResp"] += " / " + Alltrim((cAlias)->SIGLARESP) // Sigla do responsável
			aDadosRsp[nIndex]["nomeResp"]  += " / " + Alltrim((cAlias)->NOMERESP)  // Nome do responsável

		Else
			nIndex++
			// Adiciona um novo registro no array
			aAdd(aDadosRsp, JsonObject():New())
			aDadosRsp[nIndex]["filial"]    := (cAlias)->FILIAL             // Filial do follow-up
			aDadosRsp[nIndex]["cajuri"]    := Alltrim((cAlias)->CAJURI)    // Código do assunto jurídico
			aDadosRsp[nIndex]["codFup"]    := Alltrim((cAlias)->CODFUP)    // Código do follow-up
			aDadosRsp[nIndex]["codResp"]   := Alltrim((cAlias)->CODRESP)   // Código do responsável
			aDadosRsp[nIndex]["siglaResp"] := Alltrim((cAlias)->SIGLARESP) // Sigla do responsável
			aDadosRsp[nIndex]["nomeResp"]  := Alltrim((cAlias)->NOMERESP)  // Nome do responsável

			// Atualiza a variável de controle
			cKey := (cAlias)->FILIAL + Alltrim((cAlias)->CAJURI) + Alltrim((cAlias)->CODFUP)

		EndIf
		
		(cAlias)->(DbSkip())
	EndDo

	(cAlias)->(DbCloseArea())
	aSize(aParams, 0)
	oQuery := Nil
	aParams := Nil

Return aDadosRsp

//-------------------------------------------------------------------
/*/{Protheus.doc} findEnvFup(cCajuri, cFilPro)
Busca os nome dos envolvidos concatenados de acordo com o cajuri.

@param  cThread   Seção do usuário
@Return aDadosEnv Array com os dados dos responsáveis pelos follow-ups

@author Victor Gonçalves
@since 10/07/2025
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function findEnvFup(cThread)
Local oQuery     := Nil
Local aDadosEnv  := {}
Local aParams    := {}
Local cAlias     := GetNextAlias()
Local cQuery     := ""
Local cKey       := ""
Local cKeyAtual  := ""
Local nIndex     := 0

	cQuery := " SELECT NT9.NT9_FILIAL FILIAL,"
	cQuery +=        " NT9.NT9_CAJURI CAJURI,"
	cQuery +=        " NWG.NWG_CODFOL CODFUP,"
	cQuery +=        " NT9.NT9_NOME NOMEENV"
	cQuery +=   " FROM " + RetSqlName("NWG") + " NWG "
	cQuery +=  " INNER JOIN " + RetSqlName("NT9") + " NT9 "
	cQuery +=     " ON ( NT9.NT9_CAJURI = NWG.NWG_CAJURI"
	cQuery +=    " AND NT9.NT9_FILIAL = NWG.NWG_FILORI "
	cQuery +=    " AND NT9.D_E_L_E_T_ = ' ' )"
	cQuery +=  " WHERE NWG.D_E_L_E_T_ = ' '"
	cQuery +=    " AND NWG.NWG_CUSER = ?"
	aAdd(aParams, {"C", __CUSERID})
	cQuery +=   " AND NWG.NWG_SECAO = ?"
	aAdd(aParams, {"C", cThread})
	cQuery +=  " ORDER BY NT9.NT9_FILIAL,"
	cQuery +=           " NT9.NT9_CAJURI,"
	cQuery +=           " NWG.NWG_CODFOL,"
	cQuery +=           " NT9.NT9_NOME"

	oQuery := FWPreparedStatement():New(cQuery)
	oQuery := JQueryPSPr(oQuery, aParams)
	cQuery := oQuery:GetFixQuery()
	MpSysOpenQuery(cQuery, cAlias)

	While (cAlias)->(!EOF())
		
		// Concatena filial, cajuri e codfup para controle da concatenação dos envolvidos
		cKeyAtual := (cAlias)->FILIAL + Alltrim((cAlias)->CAJURI) + Alltrim((cAlias)->CODFUP)

		If !Empty(cKey) .AND. cKeyAtual == cKey
			// Concatena os nomes dos envolvidos no array
			aDadosEnv[nIndex]["nomeEnv"] += " / " + Alltrim((cAlias)->NOMEENV)  // Nome do envolvido

		Else
			nIndex++
			// Adiciona um novo registro no array
			aAdd(aDadosEnv, JsonObject():New())
			aDadosEnv[nIndex]["filial"]  := (cAlias)->FILIAL             // Filial do follow-up
			aDadosEnv[nIndex]["cajuri"]  := Alltrim((cAlias)->CAJURI)    // Código do assunto jurídico
			aDadosEnv[nIndex]["codFup"]  := Alltrim((cAlias)->CODFUP)    // Código do follow-up
			aDadosEnv[nIndex]["nomeEnv"] := Alltrim((cAlias)->NOMEENV)  // Nome do envolvido

			// Atualiza a variável de controle
			cKey := (cAlias)->FILIAL + Alltrim((cAlias)->CAJURI) + Alltrim((cAlias)->CODFUP)

		EndIf
		(cAlias)->(DbSkip())
	End

	(cAlias)->(dbCloseArea())

Return aDadosEnv

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
Local cPicture := ""

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
	Else
		If cCpoTab == "NTA_HORA" 
			cPicture := JURX3INFO(cCpoTab,"X3_PICTURE")
			If !Empty(cPicture)
				cValor := TRANSFORM((TMP)->&(cCpoQry), cPicture)
				cValor := AllTrim(cValor)
			Else
				cValor := AllTrim(AllToChar((TMP)->&(cCpoQry)))
			EndIf
		Else
			cValor := AllTrim(AllToChar((TMP)->&(cCpoQry)))
		EndIf
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
Static Function JImpSub(cQuerySub, TMP, aSessao, nLinCalc, lQuebPag ,aRelat , aCabec, oPrint, nLin, lTitulo, lLinTit)

Local nJ
Local cValor := ""
Local aDados := {}
Local SUB := GetNextAlias()
Local lHori := aSessao[4]
Local cTxt := cQuerySub
Local cVar    := "" // CAMPO
Local xValor        // Valor do campo

	While RAT("#@", cTxt) > 0 // Substitui os nomes dos campos passados na query por seus respectivos valores
		cVar     := SUBSTR(cTxt,AT("@#", cTxt) + 2,AT("#@", cTxt) - (AT("@#", cTxt) + 2))
		xValor   := (TMP)->(FieldGet(FieldPos(cVar)))
		cTxt     := SUBSTR(cTxt, 1,AT("@#", cTxt)-1) + ALLTRIM(xValor) + SUBSTR(cTxt, AT("#@", cTxt)+2)
	End

	cQuerySub := cTxt

	cQuerySub := ChangeQuery(cQuerySub)
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
			
			//Imprime os campos do relatório
			JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec)
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
Local nTam      := 0
Local aCampForm := {} // Array com cada palavra a ser escrita.
Local cValor    := ""
Local cValImp   := "" // Valor impresso
Local nX        := 0
Local nLargura  := 0

cTexto := StrTran(cTexto, Chr(13)+Chr(10), '')
cTexto := StrTran(cTexto, Chr(10), '')
aCampForm := STRTOKARR(cTexto, " ")

If nRazao == 0 //Tratamento para o server é linux
	nRazao := 288
EndIf

nTam := (nRazao * nQtdCar) / 350

If Len(aCampForm) == 0 // Caso não exista conteúdo/valor
	If lImpTit // E o título do campo foi impresso 
		oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Será inserida a linha com conteúdo em branco
		nLinAtu += nSalto // Pula uma linha
	EndIf
Else // Caso exista conteúdo/valor
	For nX := 1 To Len(aCampForm) // Laço para cada palavra a ser escrita

	 	nLargura := oPrint:GetTextWidth( cValor + aCampForm[nX], oFontVal )

		If nLargura == 0 // Tratamento para o server é linux
			nLargura := (Len( cValor + aCampForm[nX] ) * 17)
		EndIf 

		If nLargura <= nTam // Se a palavra atual for impressa e NÃO passar do limite de tamanho da linha
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
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao, cData)
Local oBrush1

oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)

oBrush1 := TBrush():New( , CLR_LIGHTGRAY )
oPrint:FillRect( {nLin-20, nColIni, (nLin + 30), nColFim}, oBrush1 )
oBrush1:End()
	
	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão
oPrint:Say( nLin+15, aSessao[2], aSessao[1] + cData, aSessao[3])
	
nLin+=80
nLinCalc := nLin

Return
