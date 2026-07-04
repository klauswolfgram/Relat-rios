/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'JURR074A.CH'
#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} U_JURR074A()
Função para gerar o relatório de protocolos (FWMsPrinter)

@param lAutomato, Indica se a chamada foi feita via automação
@param cNameAuto, Nome do arquivo de relatório usado na automação

@author Mauricio Canalle
@since 02/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
User Function JURR074A(lAutomato, cNameAuto)
	Local aArea           := Getarea()

	Local oFont14N        := TFont():New("Times New Roman", 9, 14, .T., .T.)
	Local oFont12         := TFont():New("Times New Roman", 9, 12, .T., .F.)

	Local oPrint2         := Nil
	Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
	Local nLargTxt        := 620  // largura em pixel para alinhamento da funcao sayalign
	Local nLin            := 40
	Local cFaturas        := ""
	Local cData           := ""

	Default lAutomato     := .F.
	Default cNameAuto     := ""

	cData := IIf(lAutomato, "", DTOC(dDataBase))

	NXH->(DbSetOrder(1))
	NXI->(DbSetOrder(1))

	NXH->(DbSeek(xFilial('NXH') + MV_PAR01, .T.))

	If !lAutomato
		oPrint2 := FWMsPrinter():New('JU074A', IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF")
	Else
		oPrint2 := FWMSPrinter():New(cNameAuto, IMP_SPOOL,,, .T.,,,, .T.) // Inicia o relatório
		// Alterar o nome do arquivo de impressão para o padrão de impressão automatica
		oPrint2:CFILENAME  := cNameAuto
		oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
	EndIf

	oPrint2:SetResolution(78) // Tamanho estipulado
	oPrint2:SetPortrait()
	oPrint2:SetPaperSize(0, 297, 210) // Tamanho da folha
	oPrint2:SetMargin(10,10,10,10)
	
	While !NXH->(Eof()) .and. xFilial('NXH') == NXH->NXH_FILIAL .and. NXH->NXH_COD >= MV_PAR01 .and. NXH->NXH_COD <= MV_PAR02
		cFaturas := ''

		If NXI->(DbSeek(xFilial('NXI')+NXH->NXH_COD))
			While !NXI->(Eof()) .and. xFilial('NXI') == NXI->NXI_FILIAL .and. NXI->NXI_CPROT == NXH->NXH_COD
				cFaturas += NXI->NXI_CFAT + ' '
				NXI->(DbSkip())
			End
		Endif

		oPrint2:StartPage() // Inicia uma nova página

		oPrint2:Box(nLin, 10, nLin + 50, nLargTxt, "-1")  // Box cabecalho
		oPrint2:SayAlign(nLin + 07, 01,  STR0001 + ' (' + ALLTRIM(NXH->NXH_COD) + ')' , oFont14N, nLargTxt, 200, CLR_BLACK, 2, 0 )  // Protocolo
		oPrint2:SayAlign(nLin + 30, 01,  STR0002, oFont12, nLargTxt, 200, CLR_BLACK, 2, 0 )  // (entrega)

		nLin += 50

		oPrint2:Box(nLin, 010, nLin + 60, nLargTxt, "-1") 
		oPrint2:Box(nLin, nLargTxt - 100, nLin + 60, nLargTxt, "-1") 

		oPrint2:Say(nLin + 12, 020, STR0003 + ' ' + NXH->NXH_CONTAT, oFont12) // Contato:
		oPrint2:Say(nLin + 12, 525, STR0004, oFont12)  // Data:

		oPrint2:Say(nLin+32, 020, STR0005 + ' ' + NXH->NXH_RZSOC, oFont12) // Nome:
		oPrint2:Say(nLin+32, 525, cData, oFont12)

		oPrint2:Say(nLin+52, 020, STR0006 + ' ' + alltrim(NXH->NXH_LOGRAD) + ' ' + alltrim(NXH->NXH_BAIRRO) + ' ' + alltrim(NXH->NXH_CEP) + ' ' + alltrim(NXH->NXH_CID) + ' ' + alltrim(NXH->NXH_UF) + ' ' + alltrim(NXH->NXH_PAIS), oFont12) // End.:

		nLin += 60

		oPrint2:Box(nLin, 010, nLin + 80, nLargTxt, "-1") // Faturas
		oPrint2:Say(nLin + 12, 020, STR0007, oFont12)     // Refere-se a entrega da notas:
		oPrint2:Say(nLin + 26, 020, cFaturas, oFont12)

		nLin += 80

		oPrint2:Box(nLin, 010, nLin + 150, nLargTxt, "-1")
		oPrint2:Say(nLin + 12, 020, STR0008, oFont12) //Obs.:

		oPrint2:Box(nLin, nLargTxt / 2, nLin + 150, nLargTxt, "-1")
		oPrint2:Say(nLin + 12, (nLargTxt / 2) + 7, STR0009, oFont12) // Recebi, em ____/____/_____    Hora: ____:____

		nLin += 100

		oPrint2:Box(nLin, 010, nLin + 50, nLargTxt / 2, "-1")
		oPrint2:Say(nLin + 18, 020, STR0010, oFont12) // Retornar para: Faturamento
		oPrint2:Say(nLin + 25, (nLargTxt / 2) + 85, STR0011, oFont12) // Carimbo e assinatura legível

		nLin := 040

		oPrint2:EndPage() // Finaliza a página

		NXH->(DbSkip())
	End

	oPrint2:Preview()

	RestArea(aArea)

Return