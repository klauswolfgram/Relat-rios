/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "JURR095M.CH"
#INCLUDE "topconn.ch"
#INCLUDE "SHELL.CH"
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWPrintSetup.ch"

#DEFINE IMP_PDF   6
#DEFINE nColIni   50   // Coluna inicial
#DEFINE nColFim   2350 // Coluna final
#DEFINE nSalto    40   // Salto de uma linha a outra
#DEFINE nFimL     3000 // Linha Final da página de um relatório
#DEFINE nTamCarac 20.5 // Tamanho de um caractere no relatório

//-------------------------------------------------------------------
/*/{Protheus.doc} JURR095M
Regras do relatório de Marcas e patentes

@param cUser Usuario
@param cThread Seção
@param cDir Diretório de trabalho
@param cNomeRel Nome do relatório

@author Wellington Coelho
@since 19/01/16
@version 1.0

/*/
//-------------------------------------------------------------------
User Function JURR095M(cUser, cThread, cDir, cNomerel)
Local oFont      := TFont():New("Arial",,-20,,.T.,,,,.T.,.F.) // Fonte usada no nome do relatório
Local oFontDesc  := TFont():New("Arial",,-12,,.F.,,,,.T.,.F.)   // Fonte usada nos textos
Local oFontTit   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos do relatório (Título de campos e títulos no cabeçalho)
Local oFontSub   := TFont():New("Arial",,-12,,.T.,,,,.F.,.F.)   // Fonte usada nos títulos das sessões
Local aRelat     := {}
Local aCabec     := {}
Local aSessao    := {}

//Título do Relatório
  // 1 - Título,
  // 2 - Posição da descrição,
  // 3 - Fonte do título
aRelat := {STR0001,800,oFont}//"Relatório de Marcas e patentes"		//"Marcas e patentes"

//Cabeçalho do Relatório
  // 1 - Título, 
  // 2 - Conteúdo, 
  // 3 - Posição de início da descrição(considere 20,5 para cada caractere do título, ou seja se o título tiver 6 caracteres indique 6x20,5 = 123. 
  //     Indique esse número para todos os itens do cabeçalho, para que todos tenham o mesmo alinhamento. 
  //     Para isso considere sempre a posição da maior descrição),
  // 4 - Fonte do título, 
  // 5 - Fonte da descrição
aCabec := {{STR0002,DToC(Date()) ,(nTamCarac*9),oFontTit,oFontDesc}}		//"Impressão"

//Campos do Relatório
  //Exemplo da primeira parte -> aAdd(aSessao, {"Relatório de Marcas e patentes",65,oFontSub,.F.,;// 
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
                {STR0003 ,"NSZ","NSZ_COD"    ,"NSZ_COD"    ,"C",65  ,250  ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Processo"
                {STR0004 ,"NSZ","NSZ_NUMPED" ,"NSZ_NUMPED" ,"C",650 ,1000 ,oFontTit,oFontDesc,(nTamCarac*16),.F.},;	//"Número do pedido"
                {STR0005 ,"NSZ","NSZ_BITMAP" ,"NSZ_BITMAP" ,"I",2000,1000 ,oFontTit,oFontDesc,(0),.T.},;			//"Imagem"
                {STR0006 ,"NSZ","NSZ_NOMEMA" ,"NSZ_NOMEMA" ,"C",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Marca"
                {STR0007 ,"NY8","NY8_DESC"   ,"NY8_DESC"   ,"C",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Apresentação"
                {STR0008 ,"NSZ","NSV_DESC"   ,"NSV_DESC"   ,"C",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Classe"
                {STR0009 ,"NSZ","NSZ_DTSOLI" ,"NSZ_DTSOLI" ,"D",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Concessão"
                {STR0010 ,"NSZ","NSZ_DTSITU" ,"NSZ_DTSITU" ,"D",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Data da Situação"
                {STR0011 ,"NSZ","NSZ_SITREL" ,"NSZ_SITREL" ,"C",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.},;	//"Situação"
                {STR0012 ,"NT4","NT4_DESC"   ,"RECNONT4"   ,"M",65  ,1800 ,oFontTit,oFontDesc,(nTamCarac*16),.T.}})	//"Status"

JRelatorio(aRelat,aCabec,aSessao,J95MQrPrin(cUser, cThread),cDir, cNomerel) //Chamada da função de impressão do relatório em TMSPrinter

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} J95MQrPrin(cUser, cThread)
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
Static Function J95MQrPrin(cUser, cThread)
Local cQuery := ""

cQuery := " SELECT NSZ001.NSZ_COD, NSZ_BITMAP, NSV001.NSV_DESC, NY8001.NY8_DESC, NSZ001.NSZ_NOMEMA, "
cQuery += "  NSZ001.NSZ_DTSOLI, NSZ001.NSZ_SITREL, NSZ001.NSZ_DTSITU, NSZ001.NSZ_NUMPED, "
cQuery += "  NSZ001.NSZ_FILIAL, NSZ001.D_E_L_E_T_, NQ3001.NQ3_CUSER, NQ3001.D_E_L_E_T_, NQ3001.NQ3_SECAO, "

cQuery += " (SELECT R_E_C_N_O_ FROM " + RetSqlName("NT4")
cQuery += "  WHERE D_E_L_E_T_ = ' ' AND NT4_FILIAL = NSZ001.NSZ_FILIAL AND NT4_CAJURI=NSZ001.NSZ_COD " 
cQuery += "  AND (NT4_DTANDA||NT4_COD) = (SELECT MAX(NT4_DTANDA||NT4_COD) FROM " + RetSqlName("NT4") + " WHERE D_E_L_E_T_ = ' ' "
cQuery += "  AND NT4_CAJURI = NSZ001.NSZ_COD AND NT4_FILIAL = NSZ001.NSZ_FILIAL  )) RECNONT4 "


cQuery += " FROM " + RetSqlName("NQ3") + " NQ3001 " 

cQuery += "  INNER JOIN "  + RetSqlName("NSZ") + " NSZ001 "
cQuery += "   ON ( NSZ001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NSZ001.NSZ_FILIAL = NQ3001.NQ3_FILORI )"
cQuery += "   AND ( NSZ001.NSZ_COD = NQ3001.NQ3_CAJURI )"

cQuery += "  LEFT OUTER JOIN "  + RetSqlName("NY8") + " NY8001 "
cQuery += "   ON ( NY8001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NY8001.NY8_FILIAL = '" + xFilial("NY8") + "')"
cQuery += "   AND ( NY8001.NY8_COD = NSZ001.NSZ_CNATMA ) "

cQuery += "  LEFT OUTER JOIN " + RetSqlName("NSV") + " NSV001 "
cQuery += "   ON ( NSV001.D_E_L_E_T_ = ' ' )"
cQuery += "   AND ( NSV001.NSV_FILIAL = '" + xFilial("NSV") + "')"
cQuery += "   AND ( NSV001.NSV_COD = NSZ001.NSZ_CCLASS )"

cQuery += " WHERE  NQ3001.D_E_L_E_T_= ' '"
cQuery += "   AND NQ3001.NQ3_FILIAL = '" + xFilial("NQ3") + "'"
cQuery += "   AND NQ3001.NQ3_SECAO = '" +cThread+ "'"
cQuery += "   AND NQ3001.NQ3_CUSER = '" +cUser+ "'"
cQuery += "   AND NQ3001.NQ3_SECAO = '" +cThread+ "'"

cQuery += " ORDER BY NSZ001.NSZ_COD, NSZ001.NSZ_DTSOLI  " 

Return cQuery

//-------------------------------------------------------------------
/*/{Protheus.doc} JRelatorio
Executa a query principal e inicia a impressão do relatório.
Ferramenta TMSPrinter
Uso Geral.

@param aRelat   Dados do título do relatório
@param aCabec   Dados do cabeçalho do relatório
@param aSessao  Dados do conteúdo do relatório
@param cQuery   Query que será executada
@param cDir     Diretório onde será gerado o arquivo
@param cNomerel Nome do arquivo gerado

@Return nil

@author Jorge Luis Branco Martins Junior
@since 07/01/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JRelatorio(aRelat,aCabec,aSessao,cQuery, cDir, cNomerel)
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
Local cTmpDir   := __cUserID +  SubStr(AllTrim(Str(ThreadId())),1,4)

Default cNomeRel := aRelat[1] //Nome do Relatório

oPrint := FWMsPrinter():New( cNomeRel, IMP_PDF,,,.T. ) // Inicia o relatório

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
				nLinCalc2 := nLinCalc // Backup da próxima linha a ser usada, pois na função JDadosCpo abaixo a variavel tem seu conteúdo alterado para
		                      // que seja realizada uma simulação das linhas usadas para impressão do conteúdo. 

				nLinFinal := 0 // Limpa a variável

				For nJ := 6 to Len(aSessao[nI]) // Lê as informações de cada campo a ser impresso. O contador começa em 6 pois é a partir dessa posição que estão as informações sobre o campo
					cTabela  := aSessao[nI][nJ][2] //Tabela
					cCpoTab  := aSessao[nI][nJ][3] //Nome do campo na tabela
					cCpoQry  := aSessao[nI][nJ][4] //Nome do campo na query
					cTipo    := aSessao[nI][nJ][5] //Tipo do campo

					If cTipo == "I"
						
						cDir := Iif( 'spool' $ Lower(cDir), '\spool\' + cTmpDir + "\", cDir)
						cDir := Iif("Linux" $ GetSrvInfo()[2],StrTran(cTmpDir, "\", "/" ), cDir)

						cValor := cDir + (TMP)->NSZ_COD
						cValor += Iif(File(cValor + ".bmp"),".bmp",".jpg")
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

oPrint:CFILENAME := cNomeRel + '.rel'
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
		cValor := AllTrim(AllToChar((TMP)->&(cCpoQry)))
	EndIf
EndIf

Return cValor

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
Static Function JImpRel(aDados, nLin, nLinCalc, oPrint, nLinFinal, lHori, lTitulo, lLinTit, aRelat, aCabec, lSalta, lRecursivo)
Local aSobra    := aClone(aDados)
Local cBarra    := Iif("Linux" $ GetSrvInfo()[2],"/","\")
Local cTitulo   := ""
Local cValor    := ""
Local lImpTit   := .T.
Local lQuebLin  := .F.
Local nJ        := 0
Local nLinAtu   := 0
Local nLinTit   := 0
Local nPos      := 0
Local nPosTit   := 0
Local nPosValor := 0
Local nQtdCar   := 0
Local oFontTit  := Nil
Local oFontVal  := Nil

Default lSalta  := .F.
Default lHori   := .T.

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

		If lHori // Impressão na horizontal -> título e descrição na mesma linha (Ex: Data: 01/01/2016)
			nLinTit  := nLin
			nLinCalc := nLin
			If lTitulo .AND. cTitulo != "Imagem"
				oPrint:Say( nLinTit, nPosTit, cTitulo, oFontTit)// Imprime os títulos das colunas
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
												
					// Deve imprimir apenas uma vez por página para que a letra não fique mais grossa.
					// Se não tiver esse tratamento a impressão será feita várias vezes sobre a mesma palavra devido as condições do laço, 
					// fazendo com que a grossura das letras nas palavras aumente e isso atrapalha.
					
				EndIf
			EndIf
			nPosValor := nPosTit // Indica que a posição (coluna) do conteúdo/valor a ser impresso é a mesma que foi impresso o titulo, ou seja, o conteúdo/valor ficará logo abaixo do título
		EndIf

		nLinAtu := nLinCalc // Controle de linhas usadas para imprimir o conteúdo atual

		If cTitulo == "Imagem"

			If ! File(cValor)
				cDir := SubStr(cValor, 0, rat(cBarra, cValor)) + __cUserID + SubStr(AllTrim(Str(ThreadId())),1,4)
				cValor := cDir + SubStr(cValor, rat(cBarra, cValor))
			EndIf

			oPrint:SayBitmap ( nLinAtu - 30, nPosValor, cValor, 250, 250, .T. )
		Else
			JImpLin(@oPrint,@nLinAtu,nPosValor,cValor,oFontVal,nQtdCar,@aSobra[nJ], @lSalta, lImpTit) //Imprime as linhas com os conteúdos/valores
		EndIf

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
			JImpRel(aSobra[nJ],@nLin,@nLinCalc,@oPrint, @nLinFinal,lHori, @lTitulo, @lLinTit, aRelat,aCabec, @lSalta, .T.)
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
