/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "JURR095S.CH"
#INCLUDE "topconn.ch"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   2350 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     3000 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR095S(cUser, cThread, cTipos, lAutomato, cNomerel, cCaminho, cJsonRel)
Regras do relatório de Societário

@param cUser     Usuario
@param cThread   Seção
@param cTipos    Tipos de envolvidos
@param lAutomato Define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR095S(cUser, cThread, cTipos, lAutomato, cNomerel, cCaminho, cJsonRel)

If !lAutomato
	Processa({|| U_JURRel095S(cUser, cThread, cTipos, lAutomato, cNomerel, cCaminho, cJsonRel)}, STR0041, STR0042) // "Aguarde" "Emitindo relatório"
Else
	U_JURRel095S(cUser, cThread, cTipos, lAutomato, cNomerel, , cJsonRel)
Endif

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURRel095S(cUser, cThread, cTipos, lAutomato, cNomerel, cCaminho, cJsonRel)
Regras do relatório de Assuntos Jurídicos

@param cUser     Usuario
@param cThread   Seção
@param cTipos    Tipos de envolvidos
@param lAutomato Define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@since 10/09/2021
/*/
//-------------------------------------------------------------------
User Function JURRel095S(cUser, cThread, cTipos, lAutomato, cNomerel, cCaminho, cJsonRel)

Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) // Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}
Local cRelat     := STR0001	//"Societário"

Default lAutomato := .F.
Default cNomerel := ""
Default cCaminho := ""
Default cTipos   := ""

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
aRelat := {cRelat,((2300-(10*Len(cRelat)))/2),oFont}//"Relatório de Societário"

//Cabeçalho do Relatório
  // 1 - Título, 
  // 2 - Conteúdo, 
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título, 
  // 5 - Fonte da descrição
aCabec := {{STR0002,DToC(Date()) ,(nTamCarac*9),oFontTit,oFontDesc}}	//"Impressão"	

//Campos do Relatório
  //Exemplo da primeira parte -> aAdd(aSessao, {"Relatório de Societário",65,oFontSub,.F.,;// 
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
aAdd(aSessao, {STR0003,65,oFontSub,.T.,,;	//"Detalhe"
                {STR0004 ,"SA1","A1_NOME"   ,"A1_NOME"   ,"C",65  ,1500 ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"Razão Social:"
                {STR0005 ,"NSZ","NSZ_NOMEFT","NSZ_NOMEFT","C",1200,1800 ,oFontTit,oFontDesc,(nTamCarac*14),.T.},;	//"Nome Fantasia:"
                {STR0006 ,"SX5","X5_DESCRI" ,"X5_DESCRI" ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;	//"Tipo de Sociedade:"
                {STR0007 ,"NSZ","NSZ_DENOM" ,"RECNONSZ"  ,"M",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;	//"Denom. Ant.:"
                {STR0008 ,"NSZ","NSZ_DTCONS","NSZ_DTCONS","D",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"Data Constituição:"
                {STR0009 ,"NSZ","NSZ_INSEST","NSZ_INSEST","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Inscr. Estadual:"
                {STR0010 ,"NSZ","NSZ_INSMUN","NSZ_INSMUN","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.T.},;	//"Inscr. Municipal:"
                {STR0011 ,"NSZ","NSZ_NIRE"  ,"NSZ_NIRE"  ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"NIRE Matriz:"
                {STR0012 ,"NSZ","NSZ_ALVARA","NSZ_ALVARA","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Alvará:"
                {STR0013 ,"NSZ","NSZ_CNAE"  ,"NSZ_CNAE"  ,"C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.T.},;	//"CNAE Principal:"
                {STR0014 ,"NSZ","NSZ_LOGRAD","NSZ_LOGRAD","C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;	//"Logradouro:"
                {STR0015 ,"NSZ","NSZ_LOGNUM","NSZ_LOGNUM","C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"Número:"
                {STR0016 ,"NSZ","NSZ_COMPLE","NSZ_COMPLE","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Complemento:"
                {STR0017 ,"NSZ","NSZ_BAIRRO","NSZ_BAIRRO","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.T.},;	//"Bairro:"
                {STR0018 ,"CC2","CC2_MUN"   ,"CC2_MUN"   ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"Município:"
                {STR0019 ,"NSZ","NSZ_CEP"   ,"NSZ_CEP"   ,"C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"CEP:"
                {STR0020 ,"NSZ","NSZ_ESTADO","NSZ_ESTADO","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.T.},;	//"UF:"
                {STR0021 ,"CTO","CTO_SIMB"  ,"CTO_SIMB"  ,"C",65  ,800  ,oFontTit,oFontDesc,(nTamCarac*18),.F.},;	//"Capital Social:"
                {""      ,"NSZ","NSZ_VLCAPI","NSZ_VLCAPI","C",150 ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.T.},;	///*Valor*/
                {STR0022 ,"NSZ","NSZ_VLACAO","NSZ_VLACAO","C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*18),.T.}})	//"Qtde. Quotas/Ações:"

If !EMPTY(cTipos)
	aAdd(aSessao, {STR0023,65,oFontSub,.F.,J95SQrySoc(),;// Título da sessão do relatório	//"Sócios Envolvidos"
                {STR0024 ,"NT9","NT9_NOME"  ,"NT9_NOME"  ,"C",65   ,1000,oFontTit,oFontDesc,(nTamCarac*4) ,.F.},;	//"Nome"
                {STR0025 ,"NT9","NT9_QTPARC","NT9_QTPARC","C",500  ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.},;	//"Quotas/Ações"
                {STR0026 ,"NT9","NT9_PRECO" ,"NT9_PRECO" ,"C",1000 ,1000,oFontTit,oFontDesc,(nTamCarac*5) ,.F.},;	//"Valor"
                {STR0027 ,"NT9","NT9_PERCAC","NT9_PERCAC","C",1800 ,2800,oFontTit,oFontDesc,(nTamCarac*14),.T.}})	//"% Ações/Quotas"
EndIf

aAdd(aSessao, {STR0028,65,oFontSub,.F.,J95SQryEnv(),;// Título da sessão do relatório	//"Outros Envolvidos"
                {STR0029 ,"NT9","NT9_NOME"  ,"NT9_NOME"   ,"C",65   ,1000,oFontTit,oFontDesc,(nTamCarac*4) ,.F.},;	//"Nome Envolvido"
                {STR0030 ,"NQA","NQA_DESC"  ,"NQA_DESC"   ,"C",1000 ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.},;	//"Tipo Envolvido"
                {STR0031 ,"NT9","NT9_DTENTR","NT9_DTENTR" ,"D",1400 ,1000,oFontTit,oFontDesc,(nTamCarac*5) ,.F.},;	//"Data Ini. Mandato"
                {STR0032 ,"NT9","NT9_DTSAID","NT9_DTSAID" ,"D",1800 ,2800,oFontTit,oFontDesc,(nTamCarac*14),.T.}})	//"Data Fim Mandato"

aAdd(aSessao, {"",65,oFontSub,.T.,,;// Título da sessão do relatório  
                {STR0033 ,"NSZ","NSZ_ULTCON","NSZ_ULTCON","C",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Ult. Consolidação:"
                {STR0034 ,"NSZ","NSZ_ALTPOS","NSZ_ALTPOS","C",1000,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Alt. Posteriores:"
                {STR0035 ,"NSZ","NSZ_DESALT","RECNONSZ"  ,"M",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Descr. Posterior:"
                {STR0036 ,"NSZ","NSZ_OBJSOC","NSZ_OBJSOC","C",65  ,2800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.}})	//"Objeto Social:"

aAdd(aSessao, {STR0037,65,oFontSub,.T.,J95SQryUni(),;// Título da sessão do relatório	//"Unidades"  
                {STR0005 ,"NYJ","NYJ_NOMEFT","NYJ_NOMEFT","C",65  ,1500 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Nome Fantasia:"
                {STR0038 ,"NYJ","NYJ_UNIDAD","NYJ_UNIDAD","C",1500,1000 ,oFontTit,oFontDesc,(nTamCarac*8),.T.},;	//"Unidade:"
                {STR0006 ,"SX5","X5_DESCRI" ,"X5_DESCRI" ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Tipo de Sociedade:"
                {STR0007 ,"NYJ","NYJ_DENOM" ,"RECNONYJ"  ,"M",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Denom. Ant.:"
                {STR0008 ,"NYJ","NYJ_DTCONS","NYJ_DTCONS","D",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Data Constituição:"
                {STR0009 ,"NYJ","NYJ_INSEST","NYJ_INSEST","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Inscr. Estadual:"
                {STR0010 ,"NYJ","NYJ_INSMUN","NYJ_INSMUN","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*15),.T.},;	//"Inscr. Municipal:"
                {STR0011 ,"NYJ","NYJ_NIRE"  ,"NYJ_NIRE"  ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"NIRE Matriz:"
                {STR0012 ,"NYJ","NYJ_ALVARA","NYJ_ALVARA","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Alvará:"
                {STR0013 ,"NYJ","NYJ_CNAE"  ,"NYJ_CNAE"  ,"C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*15),.T.},;	//"CNAE Principal:"
                {STR0014 ,"NYJ","NYJ_LOGRAD","NYJ_LOGRAD","C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Logradouro:"
                {STR0015 ,"NYJ","NYJ_LOGNUM","NYJ_LOGNUM","C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Número:"
                {STR0016 ,"NYJ","NYJ_COMPLE","NYJ_COMPLE","C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"Complemento:"
                {STR0017 ,"NYJ","NYJ_BAIRRO","NYJ_BAIRRO","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*15),.T.},;	//"Bairro:"
                {STR0018 ,"NYJ","CC2_MUN"   ,"CC2_MUN"   ,"C",65  ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Município:"
                {STR0019 ,"NYJ","NYJ_CEP"   ,"NYJ_CEP"   ,"C",1000,1000 ,oFontTit,oFontDesc,(nTamCarac*14),.F.},;	//"CEP:"
                {STR0020 ,"NYJ","NYJ_ESTADO","NYJ_ESTADO","C",1700,1000 ,oFontTit,oFontDesc,(nTamCarac*15),.T.}})	//"UF:"


JRelatorio(aRelat, aCabec, aSessao, J095SQrPrin(cUser, cThread), lAutomato, cNomerel, cCaminho, cJsonRel) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J095SQrPrin(cUser, cThread)
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
Static Function J095SQrPrin(cUser, cThread)
Local cQuery := ""

cQuery := " SELECT NSZ001.NSZ_FILIAL,NQ3001.NQ3_CUSER, NQ3001.NQ3_SECAO, SA1001.A1_NOME, NSZ001.NSZ_NOMEFT, SX5001.X5_DESCRI, " 
cQuery += "  NSZ001.NSZ_DTCONS, NSZ001.NSZ_INSEST, NSZ001.NSZ_INSMUN, NSZ001.NSZ_NIRE, NSZ001.NSZ_ALVARA, "
cQuery += "  NSZ001.NSZ_CNAE, NSZ001.NSZ_LOGRAD, NSZ001.NSZ_LOGNUM, NSZ001.NSZ_COMPLE, NSZ001.NSZ_BAIRRO, "
cQuery += "  CC2001.CC2_MUN, NSZ001.NSZ_CEP, NSZ001.NSZ_ESTADO,NSZ001.NSZ_VLACAO, NSZ001.NSZ_COD, "
cQuery += "  NSZ001.NSZ_ULTCON, NSZ001.NSZ_ALTPOS, NSZ001.NSZ_OBJSOC, SX5001.X5_TABELA, NSZ001.D_E_L_E_T_, "
cQuery += "  CTO001.CTO_SIMB, NSZ001.NSZ_VLCAPI, CC2001.CC2_FILIAL, CTO001.CTO_FILIAL, NQ3001.D_E_L_E_T_, "
cQuery += "  NSZ001.R_E_C_N_O_ RECNONSZ , NT9001.NT9_CAJURI, NT9001.NT9_CTPENV, NT9001.NT9_NOME, "
cQuery += "  NT9001.NT9_QTPARC, NT9001.NT9_PERCAC, NT9001.NT9_PRECO "

cQuery += " FROM " + RetSqlName("NQ3") + " NQ3001 " 

cQuery += "  INNER JOIN "  + RetSqlName("NSZ") + " NSZ001 "
cQuery += "   ON ( NSZ001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NSZ001.NSZ_FILIAL = NQ3001.NQ3_FILORI )"
cQuery += "   AND ( NSZ001.NSZ_COD = NQ3001.NQ3_CAJURI )"

cQuery += "  LEFT OUTER JOIN " + RetSqlName("SA1") + " SA1001 "
cQuery += "   ON ( SA1001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( SA1001.A1_FILIAL = '" + xFilial("SA1") + "')"
cQuery += "   AND ( SA1001.A1_COD = NSZ001.NSZ_CCLIEN ) "
cQuery += "   AND ( SA1001.A1_LOJA = NSZ001.NSZ_LCLIEN ) " 

cQuery += "  INNER JOIN "  + RetSqlName("SX5") + " SX5001 "
cQuery += "   ON ( SX5001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( SX5001.X5_FILIAL = '" + xFilial("SX5") + "')"
cQuery += "   AND ( SX5001.X5_CHAVE = NSZ001.NSZ_CTPSOC ) "

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("CC2") + " CC2001 "
cQuery += "   ON ( CC2001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( CC2001.CC2_FILIAL = '" + xFilial("CC2") + "')"
cQuery += "   AND ( CC2001.CC2_EST = NSZ001.NSZ_ESTADO) "
cQuery += "   AND ( CC2001.CC2_CODMUN = NSZ001.NSZ_CMUNIC ) "

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("CTO") + " CTO001 "
cQuery += "   ON ( CTO001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( CTO001.CTO_FILIAL = '" + xFilial("CTO") + "')"
cQuery += "   AND ( CTO001.CTO_MOEDA = NSZ001.NSZ_CMOCAP ) "

cQuery += "  INNER JOIN "  + RetSqlName("NT9") + " NT9001 "
cQuery += "   ON ( NT9001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NT9001.NT9_FILIAL = '" + xFilial("NT9") + "')"
cQuery += "   AND ( NT9001.NT9_CAJURI = NSZ001.NSZ_COD )"

cQuery += " WHERE  NQ3001.D_E_L_E_T_= ' '"
cQuery += "   AND NQ3001.NQ3_FILIAL = '" + xFilial("NQ3") + "'"
cQuery += "   AND NQ3001.NQ3_SECAO = '" +cThread+ "'"
cQuery += "   AND NQ3001.NQ3_CUSER = '" +cUser+ "'"
cQuery += "   AND SX5001.X5_TABELA = 'J4' "

cQuery += " ORDER BY NSZ001.NSZ_COD, NSZ001.NSZ_DTSOLI  " 

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J95SQrySoc(cCajuri)
Gera a query do sub relatório de Envolvidos
 
Uso Geral.

@param cCajuri Codigo do assunto juridico posicionado

@Return cQueryEnv Query do sub relatório de envolvidos

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J95SQrySoc(cCajuri)
Local cQueryEnv := ""

cQueryEnv := " SELECT NT9001.NT9_CAJURI, NT9001.NT9_CTPENV, NT9001.NT9_NOME, "
cQueryEnv += "  NT9001.NT9_QTPARC, NT9001.NT9_PERCAC, NT9001.NT9_PRECO "
cQueryEnv += " FROM " + RetSqlName("NT9") + " NT9001 "
cQueryEnv += " WHERE  NT9001.NT9_CAJURI = '@#NT9_CAJURI#@' AND NT9001.NT9_FILIAL = '@#NSZ_FILIAL#@'" 
cQueryEnv += "  AND  NT9001.D_E_L_E_T_ = ' '"

Return cQueryEnv

//-------------------------------------------------------------------
/*/{Protheus.doc} J95SQryEnv(cCajuri)
Gera a query do sub relatório de Responsaveis
 
Uso Geral. 

@param cQueryEnv Query do sub relatório de envolvidos

@Return cQueryEnv Query do sub relatório de envolvidos

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J95SQryEnv(cCajuri)
Local cQueryEnv := ""

cQueryEnv := " SELECT NT9001.NT9_CAJURI, NT9001.D_E_L_E_T_, NT9001.NT9_NOME, NQA001.NQA_DESC, "
cQueryEnv += "  NT9001.NT9_DTENTR, NT9001.NT9_DTSAID, NT9001.NT9_CTPENV "
cQueryEnv += " FROM " + RetSqlName("NT9") + " NT9001 "
cQueryEnv += " LEFT OUTER JOIN " + RetSqlName("NQA") + " NQA001 ON (NT9001.NT9_CTPENV = NQA001.NQA_COD) " 
cQueryEnv += " WHERE  NT9001.NT9_CAJURI = '@#NT9_CAJURI#@' "
cQueryEnv += "  AND NT9001.NT9_FILIAL = '@#NSZ_FILIAL#@' AND  NT9001.D_E_L_E_T_ = ' '"
 
Return cQueryEnv

//-------------------------------------------------------------------
/*/{Protheus.doc} J95SQryUni(cCajuri)
Gera a query do sub relatório de Unidades
 
Uso Geral.

@param cQueryUni Query do sub relatório de Unidades

@Return cQueryUni Query do sub relatório de Unidades

@author Wellington Coelho
@since 21/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J95SQryUni(cCajuri)
Local cQueryUni := ""
cQueryUni := " SELECT SX5001.X5_DESCRI, SX5001.X5_TABELA, CC2001.CC2_MUN, NYJ001.NYJ_INSEST, NYJ001.NYJ_ALVARA, " 
cQueryUni += "  NYJ001.NYJ_INSMUN, NYJ001.NYJ_CNAE, NYJ001.NYJ_NIRE, NYJ001.NYJ_LOGRAD, NYJ001.NYJ_LOGNUM, "
cQueryUni += "  NYJ001.NYJ_COMPLE, NYJ001.NYJ_BAIRRO, NYJ001.NYJ_CEP, NYJ001.NYJ_ESTADO, NYJ001.NYJ_NOMEFT, "
cQueryUni += "  NYJ001.NYJ_DTCONS, NYJ001.NYJ_CAJURI, NYJ001.D_E_L_E_T_, NYJ001.NYJ_UNIDAD, " 
cQueryUni += "  CC2001.CC2_FILIAL, NYJ001.R_E_C_N_O_ RECNONYJ "
cQueryUni += " FROM " + RetSqlName("NYJ") + " NYJ001 "

cQueryUni += "  INNER JOIN "  + RetSqlName("SX5") + " SX5001 "
cQueryUni += "   ON ( SX5001.D_E_L_E_T_ = ' ' )"
cQueryUni += "   AND ( SX5001.X5_FILIAL = '" + xFilial("SX5") + "')"
cQueryUni += "   AND ( SX5001.X5_CHAVE = NYJ001.NYJ_CTPSOC ) "

cQueryUni += "  LEFT OUTER JOIN "  + RetSqlName("CC2") + " CC2001 "
cQueryUni += "   ON ( CC2001.D_E_L_E_T_ = ' ' )"
cQueryUni += "   AND ( CC2001.CC2_FILIAL = '" + xFilial("CC2") + "')"
cQueryUni += "   AND ( CC2001.CC2_EST = NYJ001.NYJ_ESTADO) "
cQueryUni += "   AND ( CC2001.CC2_CODMUN = NYJ001.NYJ_CMUNIC ) " 

cQueryUni += " WHERE  NYJ001.NYJ_CAJURI = '@#NSZ_COD#@' " 
cQueryUni += "  AND SX5001.X5_TABELA='J4' "
cQueryUni += "  AND NYJ001.D_E_L_E_T_=' ' "
cQueryUni += " ORDER BY NYJ001.NYJ_UNIDAD "

Return cQueryUni 

//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio(aRelat, aCabec, aSessao, cQuery, lAutomato, cNomerel, cCaminho, cJsonRel)
Executa a query principal e inicia a impressão do relatório.
Ferramenta TMSPrinter
Uso Geral.

@param aRelat    Dados do título do relatório
@param aCabec    Dados do cabeçalho do relatório
@param aSessao   Dados do conteúdo do relatório
@param cQuery    Query que será executada
@param lAutomato Define se vem da automação de testes
@param cNomerel  Nome do relatório
@param cCaminho  Caminho do arquivo quando chamado pelo TOTVS LEGAL
@param cJsonRel  Dados da gestão de relatório do Totvs Jurídico

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat, aCabec, aSessao, cQuery, lAutomato, cNomerel, cCaminho, cJsonRel)
Local lHori      := .F.
Local lQuebPag   := .F.
Local lValor     := .F.
Local lTitulo    := .T. 
Local lLinTit    := .F.
Local nI         := 0    // Contador
Local nJ         := 0    // Contador
Local nLin       := 0    // Linha Corrente
Local nLinCalc   := 0    // Contator de linhas - usada para os cálculos de novas linhas
Local nLinCalc2  := 0
Local nLinFinal  := 0
Local oPrint     := Nil
Local aDados     := {}
Local cTMP       := GetNextAlias()
Local lO17       := FWAliasInDic('O17') .and. !Empty(cJsonRel)
Local oJsonRel   := NIL
Local cCajuris   := ""

Default lAutomato := .F.
Default cNomerel  := ""
Default cCaminho  := ""
Default cJsonRel  := ""

	If (lO17)
		oJsonRel := JsonObject():New()
		oJsonRel:FromJson(cJsonRel)
	EndIf

	cNomerel := Iif(EMPTY(cNomerel), AllTrim(aRelat[1]), cNomerel ) //Nome do Relatório

	If !lAutomato
		oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF" ) // Inicia o relatório
	Else
		oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
		//Alterar o nome do arquivo de impressão para o padrão de impressão automatica
		oPrint:CFILENAME  := cNomeRel
		oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
	Endif

	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cTMP,.T.,.T.)

	If lO17
		J288GestRel(oJsonRel)
		oJsonRel["O17_MIN"] := 0
		oJsonRel["O17_MAX"] := (cTMP)->(ScopeCount())
		(cTMP)->(DbGoTop())
	EndIf

	If (cTMP)->(!EOF())
		While (cTMP)->(!EOF())
			If !(cTMP)->NSZ_FILIAL+(cTMP)->NSZ_COD $ cCajuris
				cCajuris := (cTMP)->NSZ_FILIAL+(cTMP)->NSZ_COD + "|"
				oPrint:EndPage() // Se for um novo assunto jurídico, encerra a página atual
				ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
				lTitulo := .T. // Indica que o título pode ser impresso 
				lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada

				For nI := 1 To Len(aSessao) // Inicia a impressão de cada sessão do relatório
					
					lValor := .F.
					lHori  := aSessao[nI][4]
					
					If !Empty(aSessao[nI][5]) // Nessa posição é indicada a query de um subreport
						JImpSub(aSessao[nI][5], cTMP, aSessao[nI], @nLinCalc, @lQuebPag, aRelat, aCabec, @oPrint, @nLin, @lTitulo, @lLinTit) // Imprime os dados do subreport
					Else

						nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
											// que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 

						nLinFinal := 0 // Limpa a variável

						For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
							cTabela  := aSessao[nI][nJ][2] //Tabela
							cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
							cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
							cTipo    := aSessao[nI][nJ][5] //Tipo do campo
							cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,cTMP,,.F.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
							If !lValor .And. !Empty(AllTrim(cValor))
								lValor := .T.
							EndIf
							aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
						Next 
			
						nLinCalc := nLinCalc2 // Retorno do valor original da variável
						
						If nI > 1 // Inclui uma linha em branco no final de cada sessão do relatório principal, desde que não seja a primeira sessão 
							nLin += nSalto
						EndIf		
						
						If lTitulo .And. !Empty(aSessao[nI][1])
							If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
								oPrint:EndPage() // Se for maior, encerra a página atual
								ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
								nLinCalc := nLin // Inicia o controle das linhas impressas
								lTitulo := .T. // Indica que o título pode ser impresso 
								lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
							EndIf
							If lValor // Se existir valor a ser impresso na sessão imprime o título da sessão.
								JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI]) //Imprime o título da sessão no relatório
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
			
						If nLinFinal > 0
							nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
						EndIf
						
						nLinFinal := 0 // Limpa a variável
						
						nLin := nLinCalc//+nSalto //Recalcula a linha de referência para impressão

					EndIf

				Next

				oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
				oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
				
				nLin += nSalto //Adiciona uma linha em branco após a linha impressa
				nLinCalc := nLin
			EndIf
			(cTMP)->(DbSkip())
		Enddo

		(cTMP)->(dbCloseArea())

		aSize(aDados,0)  //Limpa array de dados
		aSize(aRelat,0)  //Limpa array de dados do relatório
		aSize(aCabec,0)  //Limpa array de dados do cabeçalho do relatório
		aSize(aSessao,0) //Limpa array de dados das sessões do relatório

		oPrint:EndPage() // Finaliza a página

		If !lAutomato
			If Empty(cCaminho)
				oPrint:CFILENAME  := AllTrim(cNomeRel) + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
				oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
			Else
				oPrint:CFILENAME  := cNomeRel
				oPrint:CFILEPRINT := cCaminho + cNomeRel
			EndIf
		Endif

		oPrint:Print()

		If !lAutomato .And. Empty(cCaminho)
			FErase(oPrint:CFILEPRINT)
		Endif

		lRelOk := FILE(cCaminho + cNomeRel)

		If lO17 .AND. !lRelOk
			oJsonRel['O17_DESC']   := STR0036 // "Não foi possível gerar o relatório."
			oJsonRel['O17_STATUS'] := "1" // Erro
			J288GestRel(oJsonRel)
		Endif

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
	ElseIf cTipo == "O" // Lista de opções
		cValor := JTrataCbox( cCpoTab, AllTrim(AllToChar((SUB)->&(cCpoQry))) ) //Retorna o valor do campo
	ElseIf cTipo == "N"
		TcSetField(SUB, cCpoQry, 'N', TamSX3(cCpoTab)[1], TamSX3(cCpoTab)[2] )
		If lPicture
			cValor   := TRANSFORM((SUB)->&(cCpoQry), cPicture)
			cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
		Else
			cValor := AllTrim(CVALTOCHAR((SUB)->&(cCpoQry)))
		EndIf
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
	ElseIf cTipo == "O" // Lista de opções
		cValor := JTrataCbox( cCpoTab, AllTrim(AllToChar((TMP)->&(cCpoQry))) ) //Retorna o valor do campo
	ElseIf cTipo == "N"
		TcSetField(TMP, cCpoQry, 'N', TamSX3(cCpoTab)[1], TamSX3(cCpoTab)[2] )
		If lPicture
			cValor   := TRANSFORM((TMP)->&(cCpoQry), cPicture)
			cValor   := AllTrim(CVALTOCHAR(cValor)) //Conteúdo a ser gravado
		Else
			cValor := AllTrim(CVALTOCHAR((TMP)->&(cCpoQry)))
		EndIf
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
Static Function JImpSub(cQuerySub, TMP, aSessao, nLinCalc,lQuebPag, aRelat, aCabec, oPrint, nLin, lTitulo, lLinTit, lUltSes)
Local nJ           := 0
Local xValor       // Valor do campo
Local nConta       := 0
Local nLinFinal    := 0
Local cValor       := ""
Local cVar         := ""  // CAMPO
Local lTitSes      := .F. // Indica se já imprimiu o título da sessão
Local aDados       := {}
Local cTitSes      := aSessao[1]
Local lHori        := aSessao[4]
Local cTxt         := cQuerySub
Local SUB          := GetNextAlias()

While RAT("#@", cTxt) > 0 // Substitui os nomes dos campos passados na query por seus respectivos valores
	cVar     := SUBSTR(cTxt,AT("@#", cTxt) + 2,AT("#@", cTxt) - (AT("@#", cTxt) + 2))
	xValor   := (TMP)->(FieldGet(FieldPos(cVar)))
	cTxt     := SUBSTR(cTxt, 1,AT("@#", cTxt)-1) + ALLTRIM(xValor) + SUBSTR(cTxt, AT("#@", cTxt)+2)
End

cQuerySub := cTxt
cQuerySub := ChangeQuery(cQuerySub)
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySub),SUB,.T.,.T.)

lUltSes := .F.

If (SUB)->(!EOF()) //.And. lIncLin
	If nLin+80 >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
		oPrint:EndPage() // Se for maior, encerra a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
		nLinCalc := nLin // Inicia o controle das linhas impressas
		lTitulo := .T. // Indica que o título pode ser impresso 
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
	EndIf
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
	oPrint:Line( nLin, nColIni, nLin, nColFim ) // Imprime uma linha na horizontal no relatório
	nLin += 30 //Adiciona uma linha em branco após a linha impressa
	nLinCalc := nLin
EndIf

While (SUB)->(!EOF())
	lUltSes := .T. //Indica que a sessão atual tem registros - Usada na construção da próxima sessão
	If nLin+80 >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
		oPrint:EndPage() // Se for maior, encerra a página atual
		ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
		nLinCalc := nLin // Inicia o controle das linhas impressas
		lTitulo := .T. // Indica que o título pode ser impresso 
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
	EndIf
		nLinCalc := nLin
		nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
		                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 
		
		For nJ := 6 to Len(aSessao) // Lê as informações de cada campo a ser impresso. O contador começa em 7 pois é a partir dessa posição que estão as informações sobre o campo
			
			nLinFinal := 0 // Limpa a variável
						
			cTabela  := aSessao[nJ][2] //Tabela
			cCpoTab  := aSessao[nJ][3] //Nome do campo na tabela
			cCpoQry  := aSessao[nJ][4] //Nome do campo na query
			cTipo    := aSessao[nJ][5] //Tipo do campo
			cValor   := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,,SUB,.T.) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data
			
			aAdd(aDados,JDadosCpo(aSessao[nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
		Next
		
		nLinCalc := nLinCalc2 // Retorno do valor original da variável

		If lTitulo .And. (!Empty(cTitSes) .And. !(cTitSes $ "Env|TotalPed|TotalCus|TotalGar")) // As sessões indicadas na condição não terão seus títulos impressos
			If (nLin + 80) >= nFimL // Verifica se o título da sessão cabe na página
				oPrint:EndPage() // Se for maior, encerra a página atual
				ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
				lTitulo := .T. // Indica que o título pode ser impresso 
				lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
			EndIf
			If !lTitSes
				JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao) //Imprime o título da sessão no relatório
				lTitSes := .T.
			EndIf
		EndIf

		If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
			// Os títulos devem ser impressos
			lTitulo := .T. // Indica que o título pode ser impresso 
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		EndIf

		nConta  := 1

		//Imprime os campos do relatório
		JImpRel(aDados,@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec)
		
		//Limpa array de dados
		aSize(aDados,0)
		aDados := {}

		If nLinFinal > 0
			nLinCalc := nLinFinal //Indica a maior refência de uso de linhas para que sirva como referência para começar a impressão do próximo registro
		EndIf
		
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
Local aDados    := {}
Local cTitulo   := ""
Local nPosTit   := 0
Local oFontTit  := Nil
Local nPos      := 0
Local nQtdCar   := 0
Local oFontVal  := Nil
Local nPosValor := 0
Local lQuebLin  := .F.

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
Static Function JImpRel(aDados, nLin, nLinCalc, oPrint, nLinFinal, lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta, lRecursivo)
Local nJ        := 0
Local lQuebLin  := .F.
Local lImpTit   := .T.
Local cTitulo   := ""
Local cValor    := ""
Local nPosTit   := 0
Local nPos      := 0
Local nQtdCar   := 0
Local nPosValor := 0
Local nLinTit   := 0
Local nLinAtu   := 0
Local aSobra    := aClone(aDados)
Local oFontTit
Local oFontVal

Default lSalta  := .F.
Default lHori   := .T.
Default lRecursivo := .F.

If lRecursivo
	aSobra[4] := ""
Else
	aEval(aSobra,{|x| x[4] := ""}) // Limpa a posição de conteúdo/valor dos campos no array de sobra, pois ele é preenchido com os dados do array aDados. Limpa para que seja preenchido com o conteúdo da sobra.
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
If cTitulo == STR0005	//"Nome Fantasia:"
	lTitulo := .T.
EndIf
If cTitulo == STR0035	//"Unidade:"
	cValor := JTpUni(cValor)
EndIf
If cTitulo == STR0033	//"Ult. Consolidação:"
	lTitulo := .T.
EndIf

	If lHori// Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
		If lImpTit
			nLinTit  := nLin
			nLinCalc := nLin
			oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
		EndIf
	Else // Impressão na vertical -> Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Data
	     //                                                                                                                01/01/2016 )
		
		If !Empty(cTitulo) .And. lImpTit // Essa variável indica se deve imprimir o título dos campos - Será .F. somente quando ocorrer quebra de um conteúdo em mais de uma página (lSalta == .T.).
			If !lLinTit // Como a linha onde será impresso o título dos campos ainda não foi definida entrará nessa condição
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

	If lSalta .And. lQuebLin // Se precisa continuar a impressão do conteúdo atual na próxima página 
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
		aEval(aSobra,{|x| x[4] := ""})
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

aSize(aSobra,0)

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
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao)
Local oBrush1

nLin := Iif (nLin<190,190,nLin)

oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)

oBrush1 := TBrush():New( , CLR_LIGHTGRAY )
oPrint:FillRect( {nLin-20, nColIni, (nLin + 30), nColFim}, oBrush1 )
oBrush1:End()
	
	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão
oPrint:Say( nLin+15, aSessao[2], aSessao[1], aSessao[3])
	
nLin+=80
nLinCalc := nLin

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JTpUni(cTipoUni)
Trata descrição do tipo de unidade
 
Uso Geral.

@param cTipoUni Tipo de unidade

@Return cTipoUni Descrição do tipo de unidade

@author Wellington Coelho
@since 18/04/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JTpUni(cTipoUni)

If cTipoUni == '1'
	cTipoUni := STR0039	//"Matriz"
ElseIf cTipoUni == '2'
	cTipoUni := STR0040	//"Filial"
EndIf
Return cTipoUni
