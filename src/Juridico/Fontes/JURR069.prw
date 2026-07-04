/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "JURR069.CH"
#include 'protheus.ch'
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR069()
Função que irá imprimir o recibo do Adiantamento (FWMsPrinter)

@param lAutomato, Indica se a chamada foi feita via automação
@param cNameAuto, Nome do arquivo de relatório usado na automação

@author Mauricio Canalle
@since 02/05/16
@version 1.0
/*/
//-------------------------------------------------------------------    
User Function JURR069(lAutomato, cNameAuto)
Local aArea := Getarea()
Local lRet  := .T.

Local oFont18N := TFont():New("Times New Roman", 9, 18, .T., .T.)
Local oFont15N := TFont():New("Times New Roman", 9, 15, .T., .T.)
Local oFont14  := TFont():New("Times New Roman", 9, 14, .T., .F.)
Local oFont14N := TFont():New("Times New Roman", 9, 14, .T., .T.)
Local oFont12N := TFont():New("Times New Roman", 9, 12, .T., .T.)
Local oFont10N := TFont():New("Times New Roman", 9, 10, .T., .T.)
Local oFont10  := TFont():New("Times New Roman", 9, 10, .T., .F.)

Local oPrint2
Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
Local nI              := 0
Local nLin            := 40

Local cRecibo   := Upper(STR0001) // Recibo de adiantamento
Local cTexto    := STR0002  // "Recebemos de @nome, a importância de R$  @valor nesta data, a título de adiantamento de honorários e/ou despesas, dando plena e geral quitação do montante recebido."
Local cLocData  := ''
Local nLargTxt  := 620  // largura em pixel para alinhamento da funcao sayalign
Local dEmissao  := IIF(NWF->(ColumnPos("NWF_DTMOVI")) > 0 .And. !Empty(NWF->NWF_DTMOVI), NWF->NWF_DTMOVI, dDataBase)

Default lAutomato := .F.
Default cNameAuto := ""

// Posiciona cliente e escritorio do adiantamento
SA1->(DbSetOrder(1))
NS7->(DbSetOrder(1))

lRet := SA1->(DbSeek(xFilial('SA1') + NWF->NWF_CCLIEN + NWF->NWF_CLOJA))
lRet := lRet .And. NS7->(DbSeek(xFilial('NS7') + NWF->NWF_CESCR))

If lRet
	// Fazer a substituição no texto do recibo do nome do cliente
	cTexto := StrTran(cTexto, '@nome', Alltrim(SA1->A1_NOME))

	// Fazer a substituição no texto do recibo do valor pago
	cTexto := StrTran(cTexto, '@valor', Alltrim(Transform(NWF->NWF_VALOR, '@e 999,999,999.99')) + " (" + Extenso(NWF->NWF_VALOR) + ")")

	cLocData := AllTrim(POSICIONE('CC2', 1, xFilial('CC2') + NS7->NS7_ESTADO + NS7->NS7_CMUNIC, 'CC2_MUN')) + ', ' + Substr(dtos(dEmissao), 7, 2) + ' de ' + MesExtenso(dEmissao) + ' de ' + Substr(dtos(dEmissao), 1, 4) + '.'

	If !lAutomato
		oPrint2 := FWMsPrinter():New('JU069', IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF")
	Else
		oPrint2 := FWMSPrinter():New(cNameAuto, IMP_SPOOL,,, .T.,,,,.T.) // Inicia o relatório
		// Alterar o nome do arquivo de impressão para o padrão de impressão automatica
		oPrint2:CFILENAME  := cNameAuto
		oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
	EndIf

	oPrint2:SetResolution(78) // Tamanho estipulado
	oPrint2:SetPortrait()
	oPrint2:SetPaperSize(0, 297, 210) // Tamanho da folha
	oPrint2:SetMargin(10,10,10,10)

	oPrint2:StartPage() // Inicia uma nova página

	// CABECALHO
	oPrint2:SayAlign( NLIN, 01, alltrim(NS7->NS7_RAZAO), oFont18N, nLargTxt, 200, CLR_BLACK, 2, 0 )

	nLin += 80

	oPrint2:SayAlign(nLin, 01, cRecibo, oFont15N, nLargTxt, 200, CLR_BLACK, 2, 0)

	// DETALHE
	nLin += 140

	aTexto := JustificaTXT(cTexto, 102)

	For nI := 1 to len(aTexto)
		oPrint2:Say(nlin, 20, aTexto[nI], oFont14)
		nLin += 25
	Next

	nLin += 90

	oPrint2:SayAlign(nLin, 01, cLocData, oFont14, nLargTxt, 200, CLR_BLACK, 1, 0)

	nLin += 70

	oPrint2:SayAlign(nLin, 01, alltrim(NS7->NS7_RAZAO), oFont14N, nLargTxt, 200, CLR_BLACK, 1, 0)

	// RODAPE DO RELATORIO
	nLin += 140

	oPrint2:Say(nLin, 20, SA1->A1_NOME, oFont12N)

	nLin += 15

	oPrint2:Say(nLin, 20, SA1->A1_END, oFont12N)

	nLin += 15

	oPrint2:Say(nLin, 020, SA1->A1_CEP, oFont12N)
	oPrint2:Say(nLin, 090, SA1->A1_MUN, oFont12N)
	oPrint2:Say(nLin, 190, SA1->A1_EST, oFont12N)

	nLin += 15

	oPrint2:Say(nLin, 20, 'At.: '+SA1->A1_CONTATO, oFont12N)

	// RODAPE DA PAGINA
	nLin += 110

	oPrint2:Say(nLin, 20, NS7->NS7_RAZAO, oFont10N)

	nLin += 15

	oPrint2:Say(nLin, 20, NS7->NS7_END, oFont10)

	nLin += 15

	oPrint2:Say(nLin, 020, NS7->NS7_CEP, oFont10)
	oPrint2:Say(nLin, 090, POSICIONE('CC2', 1, xFilial('CC2') + NS7->NS7_ESTADO + NS7->NS7_CMUNIC, 'CC2_MUN'), oFont10)
	oPrint2:Say(nLin, 190, NS7->NS7_ESTADO, oFont10)

	nLin += 15

	oPrint2:Say(nLin, 20, NS7->NS7_TEL, oFont10)

	nLin += 15

	oPrint2:Say(nLin, 20, POSICIONE('SYA', 1, xFilial('SYA') + NS7->NS7_CPAIS, 'YA_DESCR'), oFont10)

	oPrint2:EndPage() // Finaliza a página
	oPrint2:Preview()

Endif

Restarea(aArea)

Return lRet