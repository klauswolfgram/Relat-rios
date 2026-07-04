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
#INCLUDE "JURR106.CH"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   2350 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     3000 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR106(cUser, cThread, lAndam)
Regras do relatório de Follow-ups

@param cUser Usuario
@param cThread Seção
@param lAndam Indica se os Andamentos devem ser apresentados no relatório
@param lAutomato - Indica se é execução de automação
@param cNomeRel  - Indica o nome do arquivo que será gravado (automação)

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR106(cUser, cThread, lAndam, lAutomato, cNomeRel)

Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) // Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}

Default lAutomato := .F.
Default cNomeRel  := ""

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
aRelat := {STR0001,800,oFont}//"Relatório de Follow-ups"

//Cabeçalho do Relatório
  // 1 - Título, 
  // 2 - Conteúdo, 
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título, 
  // 5 - Fonte da descrição
aCabec := {{STR0002,DToC(Date()) ,(nTamCarac*9),oFontTit,oFontDesc}} //"Impressão"

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
aAdd(aSessao, {"",65,oFontSub,.T.,,;
                {STR0003 /*"Cliente"*/                ,"SA1","A1_NOME"   ,"A1_NOME"   ,"C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*7),.T.},;
                {STR0004 /*"Filial "*/                ,"NTA","NTA_FILIAL","NTA_FILIAL","C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*7),.T.},;
                {STR0005 /*"Caso   "*/                ,"NVE","NVE_NUMCAS","NVE_NUMCAS","C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*11),.T.},;
                {STR0006 /*"Titulo "*/                ,"NVE","NVE_TITULO","NVE_TITULO","C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*11),.T.}})

aAdd(aSessao, {"",65,oFontSub,.T.,J106QryEnv(),;// Título da sessão do relatório
                {"ENVOLVIDO","NT9","NT9_NOME","NT9_NOME"  ,"C",120  ,2800,oFontTit,oFontDesc,(nTamCarac*19),.T.}})

aAdd(aSessao, {"",65,oFontSub,.T.,J106QryIns(),;// Título da sessão do relatório  
                {STR0007 /*"Natureza"*/              ,"NQ1","NQ1_DESC","NQ1_DESC"    ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0008 /*"Tipo Ação"*/             ,"NQU","NQU_DESC","NQU_DESC"    ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0009 /*"Numero do Processo"*/    ,"NUQ","NUQ_NUMPRO","NUQ_NUMPRO","C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0010 /*"Comarca"*/               ,"NQ6","NQ6_DESC","NQ6_DESC"    ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0011 /*"Foro / Tribunal"*/       ,"NQC","NQC_DESC","NQC_DESC"    ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0012 /*"Vara / Câmara"*/         ,"NQE","NQE_DESC","NQE_DESC"    ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.},;
                {STR0013 /*"Correspondente"*/        ,"SA2","A2_NOME","A2_NOME"      ,"C",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*19),.T.}})

aAdd(aSessao, {"",65,oFontSub,.T.,,;// Título da sessão do relatório
                {STR0014 /*"Data"*/                  ,"NTA","NTA_DTFLWP","NTA_DTFLWP","D",65  ,530  ,oFontTit,oFontDesc,(nTamCarac*9) ,.F.},;
                {STR0015 /*"Data da inclusão"*/      ,"NTA","NTA_DTINC","NTA_DTINC"  ,"D",650 ,1500 ,oFontTit,oFontDesc,(nTamCarac*17),.F.},;
                {STR0016 /*"Usuário Inclusão"*/      ,"NTA","NTA_USUINC","NTA_USUINC","C",1500,1500 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;
                {STR0017 /*"Hora"*/                  ,"NTA","NTA_HORA","NTA_HORA"    ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*9) ,.F.},;
                {STR0018 /*"Data Alteração"*/        ,"NTA","NTA_DTALT","NTA_DTALT"  ,"D",650 ,1500 ,oFontTit,oFontDesc,(nTamCarac*17),.F.},;
                {STR0019 /*"Usuário Alteração"*/     ,"NTA","NTA_USUALT","NTA_USUALT","C",1500,2800 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;
                {STR0020 /*"Tipo"*/                  ,"NQS","NQS_DESC","NQS_DESC"    ,"C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*9) ,.T.},;
                {STR0021 /*"Descrição"*/             ,"NTA","NTA_DESC","RECNONTA"    ,"M",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*9) ,.T.},;
                {STR0022 /*"Status"*/                ,"NQN","NQN_DESC","NQN_DESC"    ,"C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*8) ,.T.}})
 
aAdd(aSessao, {"",65,oFontSub,.T.,J106QrResp(),;// Título da sessão do relatório
                {STR0023 /*"Responsáveis"*/          ,"RD0","RD0_NOME","RD0_NOME"    ,"C",120  ,2800,oFontTit,oFontDesc,(nTamCarac*13),.T.}})
If lAndam
                
	aAdd(aSessao, {"",65,oFontSub,.F.,J106QryAnd(),;// Título da sessão do relatório
	                {STR0014 /*"Data"*/                   ,"NT4","NT4_DTANDA","NT4_DTANDA","D",120 ,500  ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;
	                {STR0024 /*"Ato Processual"*/         ,"NRO","NRO_DESC"  ,"NRO_DESC"  ,"C",355 ,1250 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;
	                {STR0025 /*"Fase Processual"*/        ,"NQG","NQG_DESC"  ,"NQG_DESC"  ,"C",1300,1250 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;
	                {STR0026 /*"Andamento"*/              ,"NT4","NT4_DESC"  ,"RECNONT4"  ,"M",120 ,2800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.}})
EndIf

JRelatorio(aRelat,aCabec,aSessao,J106QrPrin(cUser, cThread), lAutomato, cNomeRel) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QrPrin(cUser, cThread)
Gera a query principal do relatório
 
Uso Geral.

@param cUser Usuario
@param cThread Seção

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QrPrin(cUser, cThread)
Local cQuery := ""

cQuery := " SELECT NTA001.NTA_CAJURI, SA1.A1_NOME, NVE.NVE_NUMCAS, NVE.NVE_TITULO, "
cQuery += "  NTA001.NTA_DTFLWP, NTA001.NTA_DTINC, NTA001.NTA_USUINC, NTA001.NTA_HORA, NTA001.NTA_DTALT, "
cQuery += "  NTA001.NTA_USUALT, NTA001.NTA_FILIAL, NQS.NQS_DESC, NTA001.R_E_C_N_O_ RECNONTA, NQN.NQN_DESC, NTA001.NTA_COD "

cQuery += " FROM " + RetSqlName("NTA") + " NTA001 " 

cQuery += "  INNER JOIN "  + RetSqlName("NWG") + " NWG "
cQuery += "   ON ( NTA001.D_E_L_E_T_ = NWG.D_E_L_E_T_ ) "
cQuery += "   AND ( NTA001.NTA_FILIAL = NWG.NWG_FILORI ) "
cQuery += "   AND ( NTA001.NTA_CAJURI = NWG.NWG_CAJURI )"
cQuery += "   AND ( NTA001.NTA_COD = NWG.NWG_CODFOL )"

cQuery += "  INNER JOIN "  + RetSqlName("NSZ") + " NSZ "
cQuery += "   ON ( NTA001.D_E_L_E_T_ = NSZ.D_E_L_E_T_ ) "
cQuery += "   AND ( NTA001.NTA_FILIAL = NSZ.NSZ_FILIAL ) "
cQuery += "   AND ( NTA001.NTA_CAJURI = NSZ.NSZ_COD )"

cQuery += "  INNER JOIN " + RetSqlName("NQS") + " NQS "
cQuery += "   ON ( NTA001.D_E_L_E_T_ = NQS.D_E_L_E_T_ ) "
cQuery += "   AND ( NQS.NQS_FILIAL = '" + xFilial("NQS") + "') "
cQuery += "   AND ( NTA001.NTA_CTIPO = NQS.NQS_COD ) "

cQuery += "  INNER JOIN " + RetSqlName("NQN") + " NQN"
cQuery += "   ON ( NTA001.D_E_L_E_T_ = NQN.D_E_L_E_T_ ) "
cQuery += "   AND ( NQN.NQN_FILIAL = '" + xFilial("NQN") + "') "
cQuery += "   AND ( NTA001.NTA_CRESUL = NQN.NQN_COD ) "

cQuery += "  LEFT JOIN " + RetSqlName("SA1") + " SA1 " 
cQuery += "   ON ( NSZ.D_E_L_E_T_ = SA1.D_E_L_E_T_ ) "
cQuery += "   AND (SA1.A1_FILIAL = SUBSTRING(NSZ.NSZ_FILIAL,0," + cValToChar(LEN(xFilial("SA1"))) + ")) "
cQuery += "   AND ( NSZ.NSZ_CCLIEN = SA1.A1_COD ) "
cQuery += "   AND ( NSZ.NSZ_LCLIEN = SA1.A1_LOJA )  "

cQuery += "  INNER JOIN " + RetSqlName("NVE") + " NVE " 
cQuery += "   ON ( NSZ.D_E_L_E_T_ = NVE.D_E_L_E_T_ ) "
cQuery += "   AND ( NVE.NVE_FILIAL = '" + xFilial("NVE") + "' ) "
cQuery += "   AND ( NSZ.NSZ_CCLIEN = NVE.NVE_CCLIEN ) " 
cQuery += "   AND ( NSZ.NSZ_LCLIEN = NVE.NVE_LCLIEN ) " 
cQuery += "   AND ( NSZ.NSZ_NUMCAS = NVE.NVE_NUMCAS ) " 

cQuery += " WHERE NWG_CUSER = '" +cUser+ "'"
cQuery += "   AND NWG_SECAO = '" +cThread+ "'" 

cQuery += " ORDER BY NTA001.NTA_DTFLWP " 

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QryEnv(cCajuri)
Gera a query do sub relatório de Envolvidos
 
Uso Geral.

@param cCajuri Codigo do assunto juridico posicionado

@Return cQueryEnv Query do sub relatório de envolvidos

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QryEnv(cCajuri)
Local cQueryEnv := ""

cQueryEnv := " SELECT NT9.NT9_CAJURI, NT9.NT9_FILIAL, NT9.NT9_TIPOEN, NT9.NT9_NOME "
cQueryEnv += " FROM " + RetSqlName("NT9") + " NT9 "
cQueryEnv += " WHERE  NT9.NT9_CAJURI = '@#NTA_CAJURI#@' AND NT9.NT9_FILIAL = '@#NTA_FILIAL#@' AND  NT9.D_E_L_E_T_ = ' '"

Return cQueryEnv

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

cQueryIns := " SELECT NUQ.NUQ_CAJURI, NQ1.NQ1_DESC, NQU.NQU_DESC, "
cQueryIns += "  NQC.NQC_DESC, NQE.NQE_DESC, NQ6.NQ6_DESC, "
cQueryIns += "  NUQ.NUQ_NUMPRO, SA2.A2_NOME, NQ6.NQ6_UF, "
cQueryIns += "  NUQ.NUQ_INSTAN, NUQ.NUQ_FILIAL "
cQueryIns += " FROM " + RetSqlName("NUQ") + " NUQ "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQE") + " NQE " 
cQueryIns += "   ON ( NUQ.NUQ_CLOC3N = NQE.NQE_COD ) "
cQueryIns += "   AND ( NUQ.NUQ_CLOC2N = NQE.NQE_CLOC2N ) AND ( NUQ.D_E_L_E_T_ = NQE.D_E_L_E_T_ ) "
cQueryIns += "   AND ( NQE.NQE_FILIAL = '" + xFilial("NQE") + "') "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQC") + " NQC " 
cQueryIns += "   ON ( NUQ.NUQ_CLOC2N = NQC.NQC_COD ) AND (NUQ.D_E_L_E_T_ = NQC.D_E_L_E_T_ ) " 
cQueryIns += "   AND (NUQ.NUQ_CCOMAR = NQC.NQC_CCOMAR ) "
cQueryIns += "   AND ( NQC.NQC_FILIAL = '" + xFilial("NQC") + "') "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQ6") + " NQ6 " 
cQueryIns += "   ON (NUQ.NUQ_CCOMAR = NQ6.NQ6_COD ) AND (NUQ.D_E_L_E_T_ = NQ6.D_E_L_E_T_ ) "
cQueryIns += "   AND ( NQ6.NQ6_FILIAL = '" + xFilial("NQ6") + "') "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQU") + " NQU " 
cQueryIns += "   ON (NUQ.NUQ_CTIPAC = NQU.NQU_COD ) AND (NUQ.D_E_L_E_T_ = NQU.D_E_L_E_T_ ) "
cQueryIns += "   AND ( NQU.NQU_FILIAL = '" + xFilial("NQU") + "') "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("NQ1") + " NQ1 "
cQueryIns += "   ON (NUQ.NUQ_CNATUR = NQ1.NQ1_COD ) AND ( NUQ.D_E_L_E_T_ = NQ1.D_E_L_E_T_ ) "
cQueryIns += "   AND ( NQ1.NQ1_FILIAL = '" + xFilial("NQ1") + "') "

cQueryIns += "  LEFT OUTER JOIN " + RetSqlName("SA2") + " SA2 "
cQueryIns += "   ON (NUQ.NUQ_CCORRE = SA2. A2_COD) AND (NUQ.NUQ_LCORRE = SA2.A2_LOJA ) "
cQueryIns += "   AND (NUQ.D_E_L_E_T_ = SA2.D_E_L_E_T_ ) "
cQueryIns += "   AND (SA2.A2_FILIAL = SUBSTRING(SA2.A2_FILIAL,0," + cValToChar(LEN(xFilial("SA2"))) + ")) "

cQueryIns += " WHERE NUQ.NUQ_CAJURI = '@#NTA_CAJURI#@' AND NUQ.NUQ_FILIAL = '@#NTA_FILIAL#@' "

Return cQueryIns

//-------------------------------------------------------------------
/*/{Protheus.doc} J106QrResp(cCodFollow)
Gera a query do sub relatório de Responsaveis
 
Uso Geral.

@param cCodFollow Codigo do Follow-up

@Return cQueryResp query do sub relatório de Responsaveis

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QrResp(cCodFollow)
Local cQueryResp := ""

cQueryResp := " SELECT RD0.RD0_NOME, NTE.NTE_CFLWP, NTE.NTE_FILIAL "
cQueryResp += " FROM " + RetSqlName("RD0") + " RD0 "
cQueryResp += "  INNER JOIN " + RetSqlName("NTE") + " NTE "
cQueryResp += "   ON (RD0.D_E_L_E_T_ = NTE.D_E_L_E_T_ ) AND ( RD0.RD0_CODIGO = NTE.NTE_CPART ) AND (RD0.RD0_FILIAL = NTE.NTE_FILIAL)" 
cQueryResp += " WHERE  NTE.NTE_CFLWP = '@#NTA_COD#@'  AND NTE.NTE_FILIAL = '"+xFilial("NTE")+"' "

Return cQueryResp

//-------------------------------------------------------------------
/*/{Protheus.doc} JA100QryRel(cCajuri)
Gera a query do sub relatório de Andamentos
 
Uso Geral.

@param cCajuri Codigo do assunto juridico posicionado

@Return cQueryAnd Query do sub relatório de andamentos

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J106QryAnd(cCajuri)
Local cQueryAnd := ""

	cQueryAnd := " SELECT NT4.NT4_DTANDA, NRO.NRO_DESC, NT4.NT4_CAJURI, "
	cQueryAnd += "  NQG.NQG_DESC, NT4.NT4_FILIAL, NT4.R_E_C_N_O_ RECNONT4 "
	cQueryAnd += " FROM " + RetSqlName("NT4") + " NT4 "
	cQueryAnd +=  " LEFT JOIN " + RetSqlName("NRO") + " NRO " 
	cQueryAnd +=   " ON (NRO.D_E_L_E_T_ = ' '"
	cQueryAnd +=   " AND NRO_FILIAL = '" + xFilial("NRO") + "' "
	cQueryAnd +=   " AND NRO_COD = NT4_CATO) "
	cQueryAnd +=  " LEFT OUTER JOIN " + RetSqlName("NQG") + " NQG "
	cQueryAnd +=   " ON ( NQG.D_E_L_E_T_ = ' '" 
	cQueryAnd +=   " AND NQG_FILIAL = '" + xFilial("NQG") + "' " 
	cQueryAnd +=   " AND NQG_COD = NT4_CFASE) "
	cQueryAnd += " WHERE NT4_FILIAL = '@#NTA_FILIAL#@' "
	cQueryAnd +=   " AND NT4_CAJURI = '@#NTA_CAJURI#@' "
	cQueryAnd +=   " AND NT4.D_E_L_E_T_ = ' ' "

Return cQueryAnd

//-------------------------------------------------------------------
/*/{Protheus.doc} JTpEnv(cTipoEnv)
Trata descrição do polo de acordo com o cadastro de tipo de envolvido
 
Uso Geral.

@param cTipoEnv Tipo de envolvido

@Return cTipoEnv Descrição do tipo de envolvido

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JTpEnv(cTipoEnv)

If cTipoEnv == '1'
	cTipoEnv := "Polo Ativo"
ElseIf cTipoEnv == '2'
	cTipoEnv := "Polo Passivo"
ElseIf cTipoEnv == '3'
	cTipoEnv := "Terceiro interessado"
Else
	cTipoEnv := "Envolvido"	
EndIf
	
Return cTipoEnv

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
Local nI        := 0    // Contador
Local nJ        := 0    // Contador
Local nLin      := 0    // Linha Corrente
Local nLinCalc  := 0    // Contator de linhas - usada para os cálculos de novas linhas
Local nLinCalc2 := 0
Local nLinFinal := 0
Local oPrint    := Nil
Local aDados    := {}
Local TMP       := GetNextAlias()

cNomeRel := IIF( VALTYPE(cNomeArq) <> "U" .AND. !Empty(cNomeArq), cNomeArq, aRelat[1]) //Nome do Relatório

If !lAutomato
	oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,,.T. ) // Inicia o relatório
Else
	oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
	oPrint:CFILENAME  := cNomeRel
	oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
EndIf

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
					cValor := JXFTratVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
					
					aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag,TMP)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
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
				
				If nI > 1 // Inclui uma linha em branco no final de cada sessão do relatório principal, desde que não seja a primeira sessão 
					nLin += nSalto
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
		
		//nLin := nLinCalc + nSalto //Após a impressão da sessão recalcula a linha de referência para impressão
		
		oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
		oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
		
		nLin += nSalto //Adiciona uma linha em branco após a linha impressa
		nLinCalc := nLin
		
		(TMP)->(DbSkip())
	End

	(TMP)->(dbCloseArea())

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
Local nPosValor  := 0
Local nSaltoCabe := 30
Local nI         := 0
Local oFontValor 
Local oFontRoda  := TFont():New("Arial",,-8,,.F.,,,,.T.,.F.) // Fonte usada no Rodapé

oPrint:SetPortrait()   // Define a orientação do relatório como retrato (Portrait).

oPrint:SetPaperSize(9) //A4 - 210 x 297 mm

// Inicia a impressao da pagina
oPrint:StartPage()
oPrint:Say( nFimL, nColFim - 100, alltochar(oPrint:NPAGECOUNT), oFontRoda )
oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
oPrint:Line( nSaltoCabe, nColIni, nSaltoCabe, nColFim ) // Imprime uma linha na horizontal no relatório
nLin := 90

// Imprime o cabecalho
oPrint:Say( nLin, nColTit, cTit, oFontTit )

//nLin += nSaltoCabe // Espaço para que o cabeçalho fique um pouco abaixo do Título do Relatório 

If Len(aCabec) > 0
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

nLin+= nSaltoCabe // Inclui duas linhas em branco após a impressão do cabeçalho
//nLin+=10
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório

nLin+=40 //Recalcula a linha de referência para impressão

Return nil

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
Local nCont := 0

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
			cValor   := JXFTratVal(cTabela,cCpoTab,cCpoQry,cTipo,,SUB,.T.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data

			aAdd(aDados,JDadosCpo(aSessao[nJ],cValor,@nLinCalc,@lQuebPag,SUB)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
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

		If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
			// Os títulos devem ser impressos
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf
		
		If cTabela == 'RD0' .And. nCont > 0
			lTitulo := .F.
			lLinTit := .T.
		ElseIf cTabela == 'RD0' 
			nCont := 1
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
Static Function JDadosCpo(aSessao, cValor, nLinCalc, lQuebPag, TMP)
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
If cTitulo == "ENVOLVIDO"
	cTitulo := JTpEnv((TMP)->NT9_TIPOEN)
EndIf
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
Static Function JImpRel(aDados, nLin, nLinCalc, oPrint, nLinFinal, lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta, lRecursivo)
Local nJ, nI
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
Local aSobra

Default lSalta  := .F.
Default lHori   := .T.

// Verificação se o aDados é um array. Se ele for, utiliza o aClone, senão só transfere os valores para o aSobra
if ((valtype(aDados)) = 'A')
	aSobra = aClone(aDados)
else
	aSobra = aDados
endif

If lRecursivo
	aSobra[4] := ''
Else
	// Limpa a posição de conteúdo/valor dos campos no array de sobra, pois ele é preenchido com os dados do array aDados. Limpa para que seja preenchido com o conteúdo da sobra.
	for nI := 1 to Len(aSobra)
		if (valtype(aSobra[nI]) == 'A')
			aEval(aSobra, {|x| x[4] := ""})
		else 
			aSobra[4] := ""
		endif
	next nI
EndIf

If lSalta // Se for continuação de impressão do conteúdo que não coube na página anterior 
	lImpTit := .F. // Indica que os títulos não precisam ser impressos
	lSalta  := .F. // Limpa variável
EndIf

For nJ := 1 to Len(aDados)

	If lRecursivo
		cTitulo  := aDados[1] //Título da Coluna
		nPosTit  := aDados[2] //Indica a coordenada horizontal em pixels ou caracteres
		oFontTit := aDados[3] //Fonte do título
		cValor   := aDados[4] //Valor a ser impresso
		nQtdCar  := aDados[5] //Quantidade de caracteres para que seja feita a quebra de linha
		oFontVal := aDados[6] //Fonte usada para impressão do conteúdo
		nPos     := aDados[7] //Indica a coordenada horizontal para imprimir o valor do campo
		nPosValor:= aDados[8] + nPos //Indica a coordenada horizontal para imprimir o valor do campo
		lQuebLin := aDados[9] // Indica se deve existir quebra de linha após a impressão do campo
	Else
		cTitulo  := aDados[nJ][1] //Título da Coluna
		nPosTit  := aDados[nJ][2] //Indica a coordenada horizontal em pixels ou caracteres
		oFontTit := aDados[nJ][3] //Fonte do título
		cValor   := aDados[nJ][4] //Valor a ser impresso
		nQtdCar  := aDados[nJ][5] //Quantidade de caracteres para que seja feita a quebra de linha
		oFontVal := aDados[nJ][6] //Fonte usada para impressão do conteúdo
		nPos     := aDados[nJ][7] //Indica a coordenada horizontal para imprimir o valor do campo
		nPosValor:= aDados[nJ][8] + nPos //Indica a coordenada horizontal para imprimir o valor do campo
		lQuebLin := aDados[nJ][9] // Indica se deve existir quebra de linha após a impressão do campo
	EndIf

	If lHori // Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
		nLinTit  := nLin
		nLinCalc := nLin
		If lTitulo
			oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
		EndIf
		
		If cTitulo == "Responsáveis" .OR. cTitulo == "Andamento"
			lTitulo := .T.
		EndIf
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
				If cTitulo == "Andamento"
					lTitulo := .T.
				EndIf
				                             
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

	If lSalta .And. lQuebLin // Se precisa continuar a impressão do conteúdo atual na próxima página 
		oPrint:EndPage() // Finaliza a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho na próxima página
		nLinCalc  := nLin // Inicia o controle das linhas a serem impressas
		nLinAtu   := nLinCalc // Atualiza variável linha atual
		lQuebPag  := .F. // Indica que não é necessário ocorrer a quebra de pagina, pois já está sendo quebrada nesse momento.
		lTitulo   := .T. // Indica que o título pode ser impresso 
		lLinTit   := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
		nLinFinal := 0 // Limpa variável de controle da última linha impressa.
		
		// Verificação do tipo de aSobra[nJ] para não enviar string para a função
		If (valtype(aSobra[nJ]) == 'A')
			JImpRel(aSobra[nJ],@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec, @lSalta, .T.)// Imprime o restante do conteúdo que não coube na página anterior.
			aEval(aSobra,{|x| x[4] := ""})
		Else
			// Tratamento para quando o aSobra[x] for string, trocar as posições dos valores de [1] e [4], colocando o [1] como igual ao [1] do aDados 
			aSobra[4] := aSobra[1] 
			aSobra[1] := aDados[1]
			JImpRel(aSobra,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec, @lSalta, .T.)// Imprime o restante do conteúdo que não coube na página anterior.
			aSobra[4] := ""
		EndIf
	EndIf

	If lQuebLin // Indica que é necessária quebra de linha, ou seja, o próximo campo será impresso na próxima linha
		If nLinFinal >= nLin // Se a próxima linha a ser impressa (nLin) for menor que a última linha que tem conteúdo impresso (nLinFinal)
			nLin     := nLinFinal // Deve-se indicar a maior referência
		Else
			nLin     += nSalto // Caso contrário, pule uma linha.
		EndIf
		
		If nLin >= nFimL
			oPrint:EndPage() // Se for maior, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
			nLinFinal := 0 // Limpa variável de controle da última linha impressa.
		Else
			nLinTit  := nLin // Recebe a próxima linha disponível para impressão do título
			nLinCalc := nLin // Atualiza variável de cálculo de linhas
			lLinTit  := .F.  // Indica que a linha de impressão do título precisa ser definida, pois iniciará uma nova linha.
		EndIf
	EndIf
	If lRecursivo
		Exit
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
		oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal, Nil ) // Será inserida a linha com conteúdo em branco
		nLinAtu += nSalto // Pula uma linha
	EndIf
Else // Caso exista conteúdo/valor
	For nX := 1 To Len(aCampForm) // Laço para cada palavra a ser escrita
		If oPrint:GetTextWidth( cValor + aCampForm[nX], oFontVal ) <= nTam // Se a palavra atual for impressa e NÃO passar do limite de tamanho da linha
			cValor += aCampForm[nX] + " " // Preenche a linha com a palavra atual
		
			If Len(aCampForm) == nX // Caso esteja na última palavra
				oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal, nil ) // Insere a linha com o conteúdo que estava em cValor
				nLinAtu += nSalto // Pula para a próxima linha
			EndIf
	
		Else // Se a palavra atual for impressa e passar do limite de tamanho da linha
			oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal, nil ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
			nLinAtu += nSalto // Pula para a próxima linha
					
			If nLinAtu + 2*nSalto > nFimL // Se a próxima linha a ser impressa NÃO couber na página atual
				lSalta := .T. // Indica que precisa continuar a impressão do conteúdo atual na próxima página 
				If Empty(SubStr(cTexto,Len(cValImp+cValor)+2,1))
					If Valtype( aSobra ) == 'A' // Verificação para não atribuir indice quando aSobra é string
						aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+3,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
					Else
						aSobra := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+3,Len(cTexto)))
					EndIf
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor)+1,1))
					If Valtype( aSobra ) == 'A' // Verificação para não atribuir indice quando aSobra é string
						aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+2,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
					Else
						aSobra := AllTrim(SubStr(cTexto,Len(cValImp+cValor)+2,Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
					EndIf
				ElseIf Empty(SubStr(cTexto,Len(cValImp+cValor),1))
					If Valtype( aSobra ) == 'A' // Verificação para não atribuir indice quando aSobra é string
						aSobra[4] := AllTrim(SubStr(cTexto,Len(cValImp+cValor),Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
					Else
						aSobra := AllTrim(SubStr(cTexto,Len(cValImp+cValor),Len(cTexto))) // Preenche o array aSobra com o valor que falta ser impresso
					EndIf
				EndIf
				Exit
			Else // Se a próxima linha a ser impressa couber na página atual
				cValImp += cValor // Guarda todo o texto que já foi impresso para que caso necessite de quebra o sistema saiba até qual parte o texto já foi impresso.
				cValor := aCampForm[nX] + " " // Preenche a linha com a palavra atual
			EndIf
			
			If Len(aCampForm) == nX
				oPrint:Say(nLinAtu,nPosValor,cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
				nLinAtu += nSalto // Pula para a próxima linha	
			EndIf
			
		EndIf
		
	Next
EndIf

//Limpa array
aSize(aCampForm,0)

Return Nil
