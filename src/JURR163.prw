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
#INCLUDE "JURR163.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "PARMTYPE.CH"

#DEFINE IMP_SPOOL 2
#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   3000 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     2350 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR163()
Regras do relatório de Auditoria de acessos de usuários

@param lAutomato - Indica se é execução de automação
@param aUsuarios - Indica os usuários que serão considerados no relatório (automação)
@param cNomeRel  - Indica o nome do arquivo que será gravado (automação)

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR163(lAutomato, aUsuarios, cNomeRel)

	Processa( {|| J163Relat(lAutomato, aUsuarios, cNomeRel)} )

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J163Relat()
Monta o relatorio

@param lAutomato - Indica se é execução de automação
@param aUsuarios - Indica os usuários que serão considerados no relatório (automação)
@param cNomeRel  - Indica o nome do arquivo que será gravado (automação)

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
Static Function J163Relat(lAutomato, aUsuarios, cNomeRel)

Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) 	// Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}

ProcRegua(0)
IncProc(STR0030)	//"Gerando... Relatório"

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
aRelat := {STR0001,2400/2,oFont} //"Auditoria de acessos de usuários"

//Cabeçalho do Relatório
  // 1 - Título,
  // 2 - Conteúdo,
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123.
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento.
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título,
  // 5 - Fonte da descrição
aCabec := {{STR0002,DToC(Date()) ,(nTamCarac*8),oFontTit,oFontDesc}}//"Data"

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

aAdd(aSessao, {STR0003,65,oFontSub,.F.,,; // Título da sessão do relatório "Usuário"
		{STR0004/*"Código pesquisa"*/   ,"NVK","NVK_CPESQ" 	,"NVK_CPESQ"  	,"C",060 ,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0005/*"Descrição pesquisa"*/,"NVG","NVG_DESC"  	,"NVG_DESC"   	,"C",300 ,300 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0006/*"Tipo de pesquisa"*/  ,"NVG","NVG_TPPESQ"	,"NVG_TPPESQ" 	,"O",600 ,300 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0007/*"Tipo de acesso"*/    ,"NVK","NVK_TIPOA" 	,"NVK_TIPOA"  	,"O",900 ,500 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0029/*"Grupo"*/     		,"NZX","NZX_DESC" 	,"NZX_DESC" 	,"C",1250,1500,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0028/*"Correspondente"*/	,"SA2","A2_NOME" 	,"A2_NOME"  	,"C",2300,1700,oFontTit,oFontDesc,(nTamCarac*12),.F.}	})

aAdd(aSessao, {STR0008,100,oFontSub,.F.,J163RstCli(),; // Título da sessão do relatório "Restrição de clientes"
		{STR0009/*"Código Cliente"*/ ,"NWO" ,"NWO_CCLIEN" ,"NWO_CCLIEN" ,"C",150 ,500 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0010/*"Loja"*/           ,"NWO" ,"NWO_CLOJA"  ,"NWO_CLOJA"  ,"C",650 ,350 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0011/*"Razão social"*/   ,"SA1" ,"A1_NOME "   ,"A1_NOME "   ,"C",1000,2000,oFontTit,oFontDesc,(nTamCarac*12),.F.}})

aAdd(aSessao, {STR0012,100,oFontSub,.F.,J163RstGru(),; // Título da sessão do relatório "Restrição de grupos de clientes"
		{STR0013/*"Código Grupo"*/ ,"NY2" ,"NY2_CGRUP" ,"NY2_CGRUP" ,"C",150 ,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0014/*"Nome grupo"*/   ,"ACY" ,"ACY_DESCRI","ACY_DESCRI","C",650 ,900,oFontTit,oFontDesc,(nTamCarac*12),.F.}})

aAdd(aSessao, {STR0015,100,oFontSub,.F.,J163RstRot(),; // Título da sessão do relatório "Restrição de acesso a rotinas"
		{STR0016/*"Código rotina"*/ ,"NWP" ,"NWP_CROT"  ,"NWP_CROT"  ,"C",150 ,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0017/*"Nome rotina"*/   ,"SX5" ,"X5_DESCRI" ,"X5_DESCRI" ,"C",400 ,500,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0018/*"Visualizar?"*/   ,"NWP" ,"NWP_CVISU" ,"NWP_CVISU" ,"O",800 ,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0019/*"Incluir?"*/      ,"NWP" ,"NWP_CINCLU","NWP_CINCLU","O",1150,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0020/*"Alterar?"*/      ,"NWP" ,"NWP_CALTER","NWP_CALTER","O",1500,200,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0021/*"Excluir?"*/      ,"NWP" ,"NWP_CEXCLU","NWP_CEXCLU","O",2000,200,oFontTit,oFontDesc,(nTamCarac*12),.F.}})

aAdd(aSessao, {STR0022,100,oFontSub,.F.,J163RstEsc(),; // Título da sessão do relatório "Restrição de escritório"
		{STR0023/*"Código escritório"*/    ,"NYK" ,"NYK_CESCR","NYK_CESCR","C",150 ,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0024/*"Descrição escritório"*/ ,"NS7" ,"NS7_NOME" ,"NS7_NOME" ,"C",400 ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.}})

aAdd(aSessao, {STR0025,100,oFontSub,.F.,J163RstArea(),; // Título da sessão do relatório "Restrição de área"
		{STR0026/*"Código Área"*/     ,"NYL" ,"NYL_CAREA" ,"NYL_CAREA" ,"C",150 ,200 ,oFontTit,oFontDesc,(nTamCarac*12),.F.},;
		{STR0027/*"Descrição Área"*/  ,"NRB" ,"NRB_DESC " ,"NRB_DESC " ,"C",400 ,1000,oFontTit,oFontDesc,(nTamCarac*12),.F.}})

JRelatorio(aRelat,aCabec,aSessao, lAutomato, aUsuarios, cNomeRel)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J163QrPrin(cUsuario)
Gera a query principal do relatório

Uso Geral.

@param cUsuario código do usuário

@Return cQuery Query principal do relatório

@author Wellington Coelho
@since 15/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163QrPrin(cUsuario)
Local cQuery := ""

cQuery := "SELECT NVK.NVK_CPESQ,NVG.NVG_DESC,NVG.NVG_TPPESQ,NVK.NVK_COD,NVK.NVK_TIPOA,NZX.NZX_DESC,SA2.A2_NOME "
cQuery += "FROM " + RetSqlName("NVK") + " NVK JOIN " + RetSqlName("NVG") + " NVG "
cQuery += "ON (NVK.NVK_CPESQ = NVG.NVG_CPESQ) "
cQuery += "LEFT JOIN " + RetSqlName("NZX") + " NZX "
cQuery += "ON (NZX.NZX_FILIAL = '" + xFilial("NZX") + "' AND NVK.NVK_CGRUP = NZX.NZX_COD AND NZX.D_E_L_E_T_ = ' ') "
cQuery += "LEFT JOIN " + RetSqlName("SA2") + " SA2 "
cQuery += "ON (SA2.A2_FILIAL = '" + xFilial("SA2") + "' AND NVK.NVK_CCORR = SA2.A2_COD AND NVK.NVK_CLOJA = SA2.A2_LOJA AND SA2.D_E_L_E_T_ = ' ') "
cQuery += "WHERE NVG.NVG_FILIAL = '" + xFilial("NVG") + "' "
cQuery += "AND NVK.NVK_FILIAL = '" + xFilial("NVK") + "' "
cQuery += "AND NVK.NVK_CUSER = '" + cUsuario + "' "
cQuery += "AND NVG.D_E_L_E_T_='' AND NVK.D_E_L_E_T_=''"

cQuery += " UNION "

cQuery += "SELECT NVK.NVK_CPESQ,NVG.NVG_DESC,NVG.NVG_TPPESQ,NVK.NVK_COD,NVK.NVK_TIPOA,NZX.NZX_DESC,SA2.A2_NOME "
cQuery += "FROM " + RetSqlName("NVK") + " NVK JOIN " + RetSqlName("NVG") + " NVG "
cQuery += "ON (NVK.NVK_CPESQ = NVG.NVG_CPESQ) "
cQuery += "LEFT JOIN " + RetSqlName("NZX") + " NZX "
cQuery += "ON (NZX.NZX_FILIAL = '" + xFilial("NZX") + "' AND NVK.NVK_CGRUP = NZX.NZX_COD AND NZX.D_E_L_E_T_ = ' ') "
cQuery += "LEFT JOIN " + RetSqlName("SA2") + " SA2 "
cQuery += "ON (SA2.A2_FILIAL = '" + xFilial("SA2") + "' AND NVK.NVK_CCORR = SA2.A2_COD AND NVK.NVK_CLOJA = SA2.A2_LOJA AND SA2.D_E_L_E_T_ = ' ') "
cQuery += "WHERE NVG.NVG_FILIAL = '" + xFilial("NVG") + "' "
cQuery += "AND NVK.NVK_FILIAL = '" + xFilial("NVK") + "' "
cQuery += "AND NVG.D_E_L_E_T_=' ' "
cQuery += "AND NVK.D_E_L_E_T_=' ' "
cQuery += "AND NVK.NVK_CGRUP IN ( "
//Grupos que esse usuario esta cadastrado
cQuery += "SELECT NZX.NZX_COD FROM " + RetSqlName("NZX") + " NZX "
cQuery += "INNER JOIN " + RetSqlName("NZY") + " NZY "
cQuery += "ON(NZY.NZY_CUSER = '"+ cUsuario + "')"
cQuery += "AND NZY.NZY_CGRUP = NZX.NZX_COD "
cQuery += "AND NZY.D_E_L_E_T_ = ' ' "
cQuery += "AND NZY.NZY_FILIAL = '" + xFilial("NZY") + "' "

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J163RstCli()
Gera a query da aba de restrição de clientes
Uso Geral.

@Return cQuery da aba de restrição de clientes

@author Wellington Coelho
@since 16/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163RstCli()
Local cQuery := ""

cQuery := "SELECT NWO.NWO_CCLIEN, NWO.NWO_CLOJA, SA1.A1_NOME "
cQuery += " FROM " + RetSqlName("NWO") + " NWO "
cQuery += " INNER JOIN " + RetSqlName("SA1") + " SA1 "
cQuery += "  ON ( NWO.NWO_CCLIEN = SA1.A1_COD "
cQuery += "  AND NWO.NWO_CLOJA = SA1.A1_LOJA "
cQuery += "  AND SA1.D_E_L_E_T_ = '' "
cQuery += "  AND SA1.A1_FILIAL = '"+xFilial("SA1")+"') "

cQuery += " WHERE NWO.D_E_L_E_T_ = ' '"
cQuery +=   " AND NWO.NWO_FILIAL = '"+xFilial("NWO")+"' "
cQuery +=   " AND NWO.NWO_CCONF = '@#NVK_COD#@' "
cQuery += " ORDER BY NWO.NWO_CCLIEN "

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J163RstGru()
Gera a query da aba de restrição de grupos de clientes
Uso Geral.

@Return cQuery da aba de restrição de grupos de clientes

@author Wellington Coelho
@since 17/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163RstGru()
Local cQuery := ""

cQuery := "SELECT NY2.NY2_CGRUP, ACY_DESCRI "
cQuery += " FROM " + RetSqlName("NY2") + " NY2 "
cQuery += " INNER JOIN " + RetSqlName("ACY") + " ACY "
cQuery += "  ON ( NY2_CGRUP = ACY.ACY_GRPVEN "
cQuery += "  AND ACY.D_E_L_E_T_ = '' "
cQuery += "  AND ACY.ACY_FILIAL = '"+xFilial("ACY")+"') "

cQuery += " WHERE NY2.D_E_L_E_T_ = ' '"
cQuery +=   " AND NY2.NY2_FILIAL = '"+xFilial("NY2")+"' "
cQuery +=   " AND NY2.NY2_CCONF = '@#NVK_COD#@' "
cQuery += " ORDER BY NY2.NY2_CGRUP "

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J163RstRot()
Gera a query da aba de restrição de rotinas
Uso Geral.

@Return cQuery da aba de restrição de rotinas

@author Wellington Coelho
@since 17/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163RstRot()
Local cQuery := ""

cQuery := "SELECT NWP.NWP_CROT, NWP.NWP_CVISU, NWP.NWP_CALTER, "
cQuery += " NWP.NWP_CINCLU, NWP.NWP_CEXCLU, X5_DESCRI "
cQuery += " FROM " + RetSqlName("NWP") + " NWP "
cQuery += " INNER JOIN " + RetSqlName("SX5") + " SX5 "
cQuery += "  ON ( NWP.NWP_CROT = X5_CHAVE "
cQuery += "  AND SX5.X5_TABELA = 'JX' "
cQuery += "  AND SX5.D_E_L_E_T_ = '' "
cQuery += "  AND SX5.X5_FILIAL = '"+xFilial("SX5")+"') "

cQuery += " WHERE NWP.D_E_L_E_T_ = ' '"
cQuery +=   " AND NWP.NWP_FILIAL = '"+xFilial("NWP")+"' "
cQuery +=   " AND NWP.NWP_CCONF = '@#NVK_COD#@' "
cQuery += " ORDER BY NWP.NWP_CROT "

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J163RstEsc()
Gera a query da aba de restrição de escritório
Uso Geral.

@Return cQuery da aba de restrição de escritório

@author Wellington Coelho
@since 17/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163RstEsc()
Local cQuery := ""

cQuery := "SELECT NYK.NYK_CESCR, NS7.NS7_NOME "
cQuery += " FROM " + RetSqlName("NYK") + " NYK "
cQuery += " INNER JOIN " + RetSqlName("NS7") + " NS7 "
cQuery += "  ON ( NYK.NYK_CESCR = NS7.NS7_COD "
cQuery += "  AND NS7.D_E_L_E_T_ = '' "
cQuery += "  AND NS7.NS7_FILIAL = '"+xFilial("NS7")+"') "

cQuery += " WHERE NYK.D_E_L_E_T_ = ' '"
cQuery +=   " AND NYK.NYK_FILIAL = '"+xFilial("NYK")+"' "
cQuery +=   " AND NYK.NYK_CCONF = '@#NVK_COD#@' "
cQuery += " ORDER BY NYK.NYK_CESCR "

cQuery := ChangeQuery(cQuery)

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} J163RstArea()
Gera a query da aba de restrição de área
Uso Geral.

@Return cQuery da aba de restrição de área

@author Wellington Coelho
@since 17/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function J163RstArea()
Local cQuery := ""

cQuery := "SELECT NYL.NYL_CAREA, NRB.NRB_DESC "
cQuery += " FROM " + RetSqlName("NYL") + " NYL "
cQuery += " INNER JOIN " + RetSqlName("NRB") + " NRB "
cQuery += "  ON ( NYL.NYL_CAREA = NRB.NRB_COD "
cQuery += "  AND NRB.D_E_L_E_T_ = '' "
cQuery += "  AND NRB.NRB_FILIAL = '"+xFilial("NRB")+"') "

cQuery += " WHERE NYL.D_E_L_E_T_ = ' '"
cQuery +=   " AND NYL.NYL_FILIAL = '"+xFilial("NYL")+"' "
cQuery +=   " AND NYL.NYL_CCONF = '@#NVK_COD#@' "
cQuery += " ORDER BY NYL.NYL_CAREA "


Return cQuery
//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio(aRelat,aCabec,aSessao)
Executa a query principal e inicia a impressão do relatório.
Ferramenta TMSPrinter
Uso Geral.

@param aRelat  Dados do título do relatório
@param aCabec  Dados do cabeçalho do relatório
@param aSessao Dados do conteúdo do relatório
@param lAutomato - Indica se é execução de automação
@param aAutoUsr  - Indica os usuários que serão considerados no relatório (automação)
@param cNomeArq  - Indica o nome do arquivo que será gravado (automação)

@Return nil

@author Wellington Coelho
@since 15/06/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat,aCabec,aSessao, lAutomato, aAutoUsr, cNomeArq)

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
Local nConta    := 0
Local oPrint    := Nil
Local aDados    := {}
Local cQuerySub := ""
Local aUsuarios := ""
Local cTxt      := ""
Local cVar      := "" // CAMPO
Local xValor    // Valor do campo
Local TMP
Local nContUsu  := 0    // Contador
Local lFindFunc := FINDFUNCTION( 'FWSFALLUSERS' )
Local aAux      := {}

Default lAutomato := .F.
Default aAutoUsr  := {}
Default cNomeRel  := ""

cNomeRel := IIF( VALTYPE(cNomeArq) <> "U" .AND. !Empty(cNomeArq), cNomeArq, aRelat[1]) //Nome do Relatório

If !lAutomato
	oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,, .T.,,, "PDF" ) // Inicia o relatório
Else
	oPrint := FWMsPrinter():New( cNomeRel, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
	oPrint:CFILENAME  := cNomeRel
	oPrint:CFILEPRINT := oPrint:CPATHPRINT + oPrint:CFILENAME
EndIf

If lAutomato
	aUsuarios := aClone({ aAutoUsr })
Else 
	If lFindFunc
		aUsuarios := FWSFALLUSERS()
	Else
		aUsuarios := AllUsers()
	EndIf
EndIf

If Len (aUsuarios) > 0

	If lFindFunc
		ASORT(aUsuarios, , , { | x,y | x[4] < y[4] } )//Ordena array de usuários por nome
	Else
		ASORT(aUsuarios, , , { | x,y | x[1][2] < y[1][2] } )//Ordena array de usuários por nome
	EndIf

	For nContUsu := 1 To Len(aUsuarios)

		If lFindFunc
			aAux   := aClone( aUsuarios[nContUsu] )
			cQuery := J163QrPrin(aAux[2])
		Else
			aAux   := aClone( aUsuarios[nContUsu][1] )
			cQuery := J163QrPrin(aAux[1])
		EndIf

		nLinCalc := nLin // Inicia o controle das linhas impressas
		lTitulo := .T. // Indica que o título pode ser impresso
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
		nConta := 0

		TMP    := GetNextAlias()

		DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),TMP,.T.,.T.)

		If (TMP)->(!EOF())

			nConta := 0

			If nLin == 0//Verifica se é inicio de pagina
				ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Imprime cabeçalho
				nLinCalc := nLin // Inicia o controle das linhas impressas
			EndIf

			While (TMP)->(!EOF())

				For nI := 1 To Len(aSessao) // Inicia a impressão de cada sessão do relatório

					lValor := .F.
					lHori  := aSessao[nI][4]

					If nLin + nSalto >= nFimL // Verifica se a linha corrente é maior que linha final permitida por página
						oPrint:EndPage() // Se for maior, encerra a página atual
						ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
						nConta := 0
						nLinCalc := nLin // Inicia o controle das linhas impressas
						lTitulo := .T. // Indica que o título pode ser impresso
						lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada

						JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], 1, aAux) //Imprime o título da sessão no relatório
					EndIf

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

						nConta := 0

						JImpSub(cQuerySub, aSessao[nI],@nLinCalc,@lQuebPag, aRelat, aCabec, @oPrint, @nLin, @lTitulo, @lLinTit, @nConta, aUsuarios, nContUsu)	// Imprime os dados do subreport

					Else

						nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
			                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo.

						nLinFinal := 0 // Limpa a variável

						For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
							cTabela  := aSessao[nI][nJ][2] //Tabela
							cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
							cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
							cTipo    := aSessao[nI][nJ][5] //Tipo do campo
							cValor := JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,,.F.,aAux) // Retorna o conteúdo/valor a ser impresso. Chama essa função para tratar o valor caso seja um memo ou data

							If !lValor .And. !Empty(AllTrim(cValor))//verifica se existe valor a ser exibido. Caso tenha imprime o titulo
								lValor := .T.
							EndIf

							aAdd(aDados,JDadosCpo(aSessao[nI][nJ],cValor,@nLinCalc,@lQuebPag)) // Título e conteúdo de cada campo são inseridos do array com os dados para serem impressos abaixo
						Next nJ

						nLinCalc := nLinCalc2 // Retorno do valor original da variável

						If lValor .And. nConta == 0 // Se existir valor a ser impresso na sessão imprime o título da sessão.
							JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], 1, aAux) //Imprime o título da sessão no relatório
						EndIf

						If lQuebPag // Verifica se é necessário ocorrer a quebra de pagina
							oPrint:EndPage() // Se é necessário, encerra a página atual
							ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
							nConta := 0
							nLinCalc := nLin // Inicia o controle das linhas impressas
							lQuebPag := .F. // Limpa a variável de quebra de página
							lTitulo  := .T. // Indica que o título pode ser impresso
							lLinTit  := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
							If lValor .And. nConta == 0 // Se existir valor a ser impresso na sessão imprime o título da sessão.
								JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao[nI], 1, aAux) //Imprime o título da sessão no relatório
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

				(TMP)->(DbSkip())

				nConta := 1
				lTitulo := .T.
				lLinTit := .F.
			Enddo

		EndIf

		(TMP)->(dbCloseArea())

	Next nContUsu

	aSize(aDados,0)  //Limpa array de dados
	aSize(aSessao,0) //Limpa array de dados das sessões do relatório
	oPrint:EndPage() // Finaliza a página

	If !lAutomato
		oPrint:CFILENAME  := cNomeRel + '-' + SubStr(AllTrim(Str(ThreadId())),1,4) + RetCodUsr() + StrTran(Time(),':','') + '.rel'
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
Static Function JTrataVal(cTabela,cCpoTab,cCpoQry,cTipo,TMP,SUB,lSub,aUsuarios)
Local cValor := ""
Local cPicture := GetSx3Cache(cCpoTab,"X3_PICTURE")
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
Static Function JImpSub(cQuerySub, aSessao, nLinCalc, lQuebPag ,aRelat , aCabec, oPrint, nLin, lTitulo, lLinTit, nConta, aUsuarios, nContUsu)
Local nJ        := 0
Local cValor    := ""
Local aDados    := {}
Local SUB       := GetNextAlias()
Local lHori     := aSessao[4]
Local cTxt      := cQuerySub
Local lValor    := .F.
Local lFindFunc := FINDFUNCTION( 'FWSFALLUSERS' )
Local aAux      := {}

cQuerySub := cTxt

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerySub),SUB,.T.,.T.)

While (SUB)->(!EOF())
	If lFindFunc
		aAux := aClone( aUsuarios[nContUsu] )
	Else
		aAux := aClone( aUsuarios[nContUsu][1] )
	EndIf


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

		If !lValor .And. !Empty(AllTrim(cValor))
			lValor := .T.
		EndIf

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

		JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao, 1, aAux) //Imprime o título da sessão no relatório
	EndIf

	If lTitulo .And. !Empty(aSessao[1])
		If (nLin + 120) >= nFimL // Verifica se o título da sessão cabe na página
			oPrint:EndPage() // Se for maior, encerra a página atual
			ImpCabec(@oPrint, @nLin, aRelat, aCabec) // Cria um novo cabeçalho
			nLinCalc := nLin // Inicia o controle das linhas impressas
			lTitulo := .T. // Indica que o título pode ser impresso
			lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada

			JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao, 1, aAux) //Imprime o título da sessão no relatório
		EndIf

	EndIf

	If lValor .And. nConta == 0 // Se existir valor a ser impresso na sessão imprime o título da sessão.
		JImpTitSes(@oPrint, @nLin, @nLinCalc, aSessao, 0) //Imprime o título da sessão no relatório
	EndIf

	If !lHori // Caso a impressão dos títulos seja na vertical - Todos os títulos na mesma linha e os conteúdos vem em colunas abaixo dos títulos (Ex: Relatório de andamentos)
		// Os títulos devem ser impressos
		lTitulo := .T. // Indica que o título pode ser impresso
		lLinTit := .F. // Essa variável indica que a linha onde será impresso o título dos campos já foi definida e não será mais alterada
	EndIf

	If nConta > 0 // Sessões que são na vertical e aparecem o título somente no topo uma única vez, e não registro a registro
		lTitulo := .F.
		lLinTit := .T.
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

	nConta  := 1

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
Local nJ        := 0
Local cTitulo   := ""
Local nPosTit   := 0
Local oFontTit
Local nPos      := 0
Local nQtdCar   := 0
Local oFontVal
Local nPosValor := 0
Local lQuebLin  := .F.
Local lImpTit   := .T.
Local cValor    := ""
Local nLinTit   := 0
Local nLinAtu   := 0
Local aSobra    := aClone(aDados)

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
Static Function JImpTitSes(oPrint, nLin, nLinCalc, aSessao, nTipo, aUsuarios)

Local lFindFunc := FINDFUNCTION( 'FWSFALLUSERS' )

Default nTipo := 0

If nTipo == 0
	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão

	oPrint:Say( nLin+15, aSessao[2], aSessao[1], aSessao[3])

	nLin+=80
	nLinCalc := nLin

Else
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)
	oPrint:Box( nLin-20, nColIni, (nLin+30), nColFim)

	//aSessao[1] - Título da sessão do relatório
	//aSessao[2] - Posição da descrição
	//aSessao[3] - Fonte da sessão

	If lFindFunc
		oPrint:Say( nLin+15, aSessao[2], aUsuarios[2] + "  -  " +aUsuarios[4], aSessao[3])
	Else
		oPrint:Say( nLin+15, aSessao[2], aUsuarios[1] + "  -  " +aUsuarios[2], aSessao[3])
	EndIf

	nLin+=70
	nLinCalc := nLin
EndIf

Return
