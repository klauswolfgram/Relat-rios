/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "JURRPAD025.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

Static __lAuto := .F. // Execução via automação de testes

//-------------------------------------------------------------------
/*/{Protheus.doc} JURRPAD025
Rotina para o processamento do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
User Function JURRPAD025(dDtIni, dDtFim, cEscritorio, cQuebra, cRelatorio, lAutomato, cNameAuto, cFatCancel)
Local aArea := Getarea()

Local oFont14N := TFont():New("Times New Roman", 9, 14, .T., .T.)
Local oFont10  := TFont():New("Times New Roman", 9, 10, .T., .F.)
Local oFont09  := TFont():New("Courier New", 9, 07, .T., .F.)
Local oFont09N := TFont():New("Courier New", 9, 07, .T., .T.)
Local oFont10N := TFont():New("Times New Roman", 9, 08, .T., .T.)
Local oFont12N := TFont():New("Times New Roman", 9, 12, .T., .T.)

Local oPrint2
Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
Local nLargTxt 		  := 900 // largura em pixel para alinhamento da funcao sayalign
Local nLin            := 03
Local lNewPage        := .T. // controla pagina nova - salto de pagina
Local nCntPage        := 1  // contador de pagina     
Local cEscrit         := ''  // controle de quebra por escritorio
Local cDtEmis         := '' // controle de quebra por data de emissao
Local aTotEsc         := {0,0,0,0,0,0,0,0,0,0,0} // Total por escritorio
Local aTotGer         := {0,0,0,0,0,0,0,0,0,0,0} // Total Geral
Local nHonor          := 0
Local nHonorLiq       := 0
Local nImpostos       := 0
Local nTotGeral       := 0
Local nI              := 0
Local nCol            := 0
Local lFatCancel      := Iif(cFatCancel == '2', .T., .F.)
Local nQtdCar         := Iif(lFatCancel, 640, 783)
Local cDescricao      := ""

Default lAutomato := .F.
Default cNameAuto := ""

	__lAuto := lAutomato

	JA025QryRel(dDtIni, dDtFim, cEscritorio, lFatCancel)   // query principal do relatório
	
	If !TMP->(Eof())
		If __lAuto //Alterar o nome do arquivo de impressão para o padrão de impressão automatica
			oPrint2 := FWMsPrinter():New(cNameAuto, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
			oPrint2:cPrinter   := "PDF" // Seta impressão padrão para não ocorrer o erro Runtime Printer.exe
			oPrint2:CFILENAME  := cNameAuto
			oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
		Else
			oPrint2 := FWMsPrinter():New( cRelatorio, IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF" )
		EndIf

		oPrint2:SetResolution(78) // Tamanho estipulado
		oPrint2:SetLandscape()
		oPrint2:SetPaperSize(0, 210, 297 )   // tamanho da folha 
		oPrint2:SetMargin(10,10,10,10)
			
		While !TMP->(Eof())
			If lNewpage  // NOVA PAGINA - cabecalho
				JA025NewPage(@nLin, oPrint2, oFont10N, oFont10, nLargTxt, oFont14N, dDtIni, dDtFim, lFatCancel)
				lNewPage := .F.
			Endif

	        If cEscrit <> TMP->NXA_CESCR   // controle de quebra por escritorio     	
	        	oPrint2:Say(nlin, 001, STR0001+": "+TMP->NXA_CESCR+' - '+alltrim(Posicione('NS7', 1, xFilial('NS7')+TMP->NXA_CESCR, 'NS7_NOME')), oFont12N) // Escritório
			
		       	nLin += 20
	        	
	        	cEscrit := TMP->NXA_CESCR
	        	cDtEmis := ''  // sempre que quebra o escritorio forço a impressao da data de emissao
	        Endif
	        
	        If cDtEmis <> TMP->NXA_DTEMI   // controle de quebra por data de emissao     	
	        	If !__lAuto
					oPrint2:Say(nlin, 001, STR0017+' '+dtoc(stod(TMP->NXA_DTEMI)), oFont10N) // Data de emissão:
				EndIf
			
		       	nLin += 15
	        	
	        	cDtEmis := TMP->NXA_DTEMI 
	        Endif	
	        	
			// detalhe			
			nHonor    := TMP->NXA_FATHMN + TMP->NXA_ACREMN - TMP->NXA_DESCMN
			nImpostos := TMP->NXA_IRRF + TMP->NXA_CSLL + TMP->NXA_PIS + TMP->NXA_COFINS

			nHonorLiq := IIf(nHonor > 0 .And. nHonor > nImpostos , nHonor - nImpostos, 0)
			nTotGeral := nHonor + TMP->NXA_FATDMN - nImpostos

			oPrint2:Say(nlin, 010, TMP->NXA_COD, oFont09)

			cDescricao := alltrim(TMP->NXA_CLIPG)+'/'+alltrim(TMP->NXA_LOJPG)+'-'+alltrim(Posicione('SA1', 1, xFilial('SA1')+TMP->NXA_CLIPG+TMP->NXA_LOJPG, 'A1_NREDUZ'))

			JImpriDesc(@oPrint2,@nlin, 055 , cDescricao, oFont09, nQtdCar) 

			If lFatCancel
				oPrint2:Say(nlin, 190, TMP->SITUACAO, oFont09) // Situação
			EndIf
			oPrint2:Say(nlin, 215, Transform(TMP->NXA_FATHMN, '@e 999,999,999.99'), oFont09) // Honor. Bruto
			oPrint2:Say(nlin, 275, Transform(TMP->NXA_ACREMN, '@e 999,999,999.99'), oFont09) // Acréscimo
			oPrint2:Say(nlin, 335, Transform(TMP->NXA_DESCMN, '@e 999,999,999.99'), oFont09) // Desconto 
			oPrint2:Say(nlin, 395, Transform(nHonor, '@e 999,999,999.99'), oFont09) // Honorário
			oPrint2:Say(nlin, 455, Transform(TMP->NXA_IRRF, '@e 999,999,999.99'), oFont09) // IRRF
			oPrint2:Say(nlin, 515, Transform(TMP->NXA_PIS, '@e 999,999,999.99'), oFont09) // PIS
			oPrint2:Say(nlin, 575, Transform(TMP->NXA_COFINS, '@e 999,999,999.99'), oFont09) // COFINS 
			oPrint2:Say(nlin, 635, Transform(TMP->NXA_CSLL, '@e 999,999,999.99'), oFont09) //CSLL
			oPrint2:Say(nlin, 695, Transform(nHonorLiq, '@e 999,999,999.99'), oFont09)  // Honor. Líquido 
			oPrint2:Say(nlin, 755, Transform(TMP->NXA_FATDMN, '@e 999,999,999.99'), oFont09)  // DESPESAS
			oPrint2:Say(nlin, 815, Transform(nTotGeral, '@e 999,999,999.99'), oFont09) // Total Líquido
				
			aTotEsc[01] += TMP->NXA_FATHMN
			aTotEsc[02] += TMP->NXA_ACREMN
			aTotEsc[03] += TMP->NXA_DESCMN
			aTotEsc[04] += nHonor
			aTotEsc[05] += TMP->NXA_IRRF
			aTotEsc[06] += TMP->NXA_PIS
			aTotEsc[07] += TMP->NXA_COFINS
			aTotEsc[08] += TMP->NXA_CSLL
			aTotEsc[09] += nHonorLiq
			aTotEsc[10] += TMP->NXA_FATDMN
			aTotEsc[11] += nTotGeral
						
			nLin += 15		
				
			TMP->(DbSkip())			
			
			If cEscrit <> TMP->NXA_CESCR   // total do escritorio
			   nLin += 5
			   
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   
			   nLin += 15			   
			   nCol := 215
			   
			   For nI := 1 to Len(aTotEsc)
			       oPrint2:Say(nlin, nCol, Transform(aTotEsc[nI], '@e 999,999,999.99'), oFont09)
			       
			      nCol += 60
			       
			       aTotGer[nI] += aTotEsc[nI] 
			   Next
			   
			   aTotEsc := {0,0,0,0,0,0,0,0,0,0,0}		
			   
			   nLin += 15
			   
			   If !TMP->(Eof()) .and. cQuebra == '1'   // quebra pagina por escritorio
					If !__lAuto
						oPrint2:SayAlign(If(nLin > 580, nLin, 580), 01, Strzero(nCntPage, 3), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
					EndIf
					oPrint2:EndPage() // Finaliza a página

					nLin     := 03
					lNewPage := .T.
					nCntPage++
			   EndIf
			EndIf
			
			// CONTROLE DE SALTO DE PAGINA
			If nLin >= 500 .or. TMP->(Eof()) 
			    If TMP->(Eof())  .and.  cQuebra == '2'  // total geral - sem quebra por escritorio
		           JA025ImpTot(@nLin, oPrint2, aTotGer, oFont09N, nLargTxt)   // imprime o total geral
			    Endif
			
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 580, nLin, 580), 01, Strzero(nCntPage, 3), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página
  		   
				nLin     := 03
				lNewPage := .T.
				nCntPage++
				
				// total geral - quebra por escritorio
				If TMP->(Eof()) .and. cQuebra == '1'
					JA025NewPage(@nLin, oPrint2, oFont10N, oFont10, nLargTxt, oFont14N, dDtIni, dDtFim, lFatCancel)
				
					JA025ImpTot(@nLin, oPrint2, aTotGer, oFont09N, nLargTxt)   // imprime o total geral
				
					If !__lAuto
						oPrint2:SayAlign(If(nLin > 580, nLin, 580), 01, Strzero(nCntPage, 3), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
					EndIf
				
					oPrint2:EndPage() // Finaliza a página
				Endif
			Endif
		End
		
		oPrint2:Preview()
	Endif
	
	TMP->(DbCloseArea())
	
	RestArea(aArea)
Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JA025QryRel
Rotina para o processamento da query principal do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//------------------------------------------------------------------- 
Static Function JA025QryRel(dDtIni, dDtFim, cEscritorio, lFatCancel)
Local cQuery      := ""
Local aArea       := GetArea()
Local TMP         := GetNextAlias()
Local cValido     := ""
Local cCancel     := ""
Local lCpoGrosHon := NXA->(ColumnPos("NXA_GRSHMN")) > 0 // @12.1.2310

	cQuery := " SELECT NXA_CESCR, NXA_COD, NXA_CLIPG, NXA_LOJPG, NXA_FATHMN + " + Iif(lCpoGrosHon, "NXA_GRSHMN", "0") + " NXA_FATHMN,"
	cQuery += " NXA_ACREMN, NXA_DESCMN, NXA_IRRF, NXA_PIS, NXA_COFINS, NXA_CSLL, NXA_FATDMN, NXA_DTEMI "
	
	If lFatCancel
		cValido := JTrataCbox( 'NXA_SITUAC', '1' )
		cCancel := JTrataCbox( 'NXA_SITUAC', '2' )

		cQuery +=       " ,(CASE WHEN NXA_SITUAC = '1' "
		cQuery +=                " THEN '" + cValido + "'"
		cQuery +=                " ELSE '" + cCancel + "' END "
		cQuery +=        "  ) SITUACAO "
	EndIf
	
	cQuery += " FROM "+RetSqlName('NXA')
 	cQuery += " WHERE  NXA_FILIAL = '"+xFilial("NXA")+"' AND NXA_DTEMI >= '"+dtos(dDtIni)+"' AND NXA_DTEMI <= '"+dtos(dDtFim)+"' AND NXA_TIPO = 'FT' AND D_E_L_E_T_ = ' '"
 	
 	If !empty(cEscritorio)
		cQuery += " AND NXA_CESCR = '"+cEscritorio+"'"	
 	Endif

	If !lFatCancel //Apenas faturas válidas
		cQuery += " AND NXA_SITUAC = '1'"
	EndIf
 	
 	cQuery += " ORDER BY NXA_CESCR, NXA_DTEMI, NXA_COD"

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP",.T.,.T.)

	RestArea(aArea)

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} JA025NewPage
Rotina para impressão de nova página (cabeçalho) do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//------------------------------------------------------------------- 
Static Function JA025NewPage(nLin, oPrint2, oFont10N, oFont10, nLargTxt, oFont14N, dDtIni, dDtFim, lFatCancel)
    oPrint2:StartPage() // Inicia uma nova página      
    
    nLin := 03

	If !__lAuto
   		oPrint2:Say(nlin, 001, dtoc(dDataBase), oFont10) 
	EndIf

   	nLin += 15

   	oPrint2:SayAlign( nLin, 01,  STR0002+" "+Posicione("CTO",1,xFilial("CTO")+SuperGetMv("MV_JMOENAC",,"01"),"CTO_SIMB"), oFont14N, nLargTxt, 200, CLR_BLACK, 2, 0 )  // FATURAS EMITIDAS EM

   	nLin += 15

	If !__lAuto
		oPrint2:Say(nLin+10, 001, STR0003+" "+ dtoc(dDtIni) + ' a ' + dtoc(dDtFim)  + Iif(lFatCancel, "", ' - ' + STR0020), oFont10) // Periodo: - "Faturas válidas"
	EndIf

   	nLin += 15
		    	
   	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 
		    	
   	nLin += 12
		    	
   	// Cabecalho
		    	
   	oPrint2:Say(nlin, 010, STR0004, oFont10N) // Fatura
   	oPrint2:Say(nlin, 055, STR0005, oFont10N) // Cliente
	If lFatCancel
		oPrint2:Say(nlin, 190, STR0019, oFont10N) // Situação
	EndIf
   	oPrint2:Say(nlin, 230, STR0006, oFont10N) // Honor. Bruto
   	oPrint2:Say(nlin, 298, STR0007, oFont10N) // Acréscimo
   	oPrint2:Say(nlin, 360, STR0008, oFont10N) // Desconto
   	oPrint2:Say(nlin, 418, STR0009, oFont10N) // Honorário
   	oPrint2:Say(nlin, 490, STR0010, oFont10N) // IRRF
   	oPrint2:Say(nlin, 560, STR0011, oFont10N) // PIS
   	oPrint2:Say(nlin, 605, STR0012, oFont10N) // COFINS
   	oPrint2:Say(nlin, 672, STR0013, oFont10N) // CSLL
   	oPrint2:Say(nlin, 703, STR0014, oFont10N) // Honor. Líquido
   	oPrint2:Say(nlin, 784, STR0015, oFont10N) // Despesas
   	oPrint2:Say(nlin, 828, STR0016, oFont10N) // Total Líquido

   	nLin += 12

   	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 

	nLin += 12

Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} JA025ImpTot
Rotina para impressão dos totais do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JA025ImpTot(nLin, oPrint2, aTotGer, oFont09N, nLargTxt)
	Local nI
	Local nCol := 215

    nLin += 20
			   
	oPrint2:Say(nlin, 055, STR0018, oFont09N)  // TOTAL GERAL
	For nI := 1 to Len(aTotGer)
		oPrint2:Say(nlin, nCol, Transform(aTotGer[nI], '@e 999,999,999.99'), oFont09N)
       
		nCol += 60
	Next
			   		
	nLin += 6	
	oPrint2:Line( nLin, 215, nLin, nLargTxt, CLR_BLACK, "-1")
	nLin += 3
	oPrint2:Line( nLin, 215, nLin, nLargTxt, CLR_BLACK, "-1")
	
Return


//-------------------------------------------------------------------
/*/{Protheus.doc} JImpriDesc(aDados)
Realiza a impressão da descrição e quebra linha se necessário.

@param oPrint    Objeto TMSPrinter (Estrutura do relatório)
       nLin      Linha para impresão
       nPosValor Orientação de posicionamento do campo na horizontal no relatório
       cTexto    Conteúdo a ser impresso
       oFontVal  Fonte usada na impressão do conteúdo
       nQtdCar   Tamanho limite para que seja feita a quebra de linha
@return

@author Breno Gomes
@since 29/06/2022
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JImpriDesc(oPrint, nLin, nPosValor, cTexto, oFontVal, nQtdCar)
Local nPgWidth  := oPrint:GetTextWidth( "oPrint:nPageWidth", oFontVal )
Local nTam      := (nPgWidth * nQtdCar) / 350
Local aPalavras := {}
Local cValor    := ""
Local nX        := 0
Local nSalto    := 10
Local nFimL     := 3000 // Linha Final da página de um relatório

cTexto    := StrTran(cTexto, Chr(13)+Chr(10), '')
cTexto    := StrTran(cTexto, Chr(10), '')
aPalavras := STRTOKARR(cTexto, " ")

	For nX := 1 To Len(aPalavras) // Laço com cada palavra
		If oPrint:GetTextWidth( cValor + aPalavras[nX], oFontVal ) <= nTam // Se a palavra atual for impressa e NÃO passar do limite de tamanho da linha
			cValor += aPalavras[nX] + " "
		
			If Len(aPalavras) == nX // Caso esteja na última palavra
				oPrint:Say(nLin, nPosValor, cValor, oFontVal )
			EndIf
		Else // Passou do limite de tamanho da linha
			oPrint:Say(nLin, nPosValor, cValor, oFontVal )
			nLin += nSalto

			If nLin + 2 * nSalto < nFimL // Se a próxima linha a ser impressa couber na página atual
				cValor := aPalavras[nX] + " "
			EndIf

			If Len(aPalavras) == nX
				oPrint:Say(nLin, nPosValor, cValor, oFontVal ) // Insere a linha com o conteúdo que estava em cValor sem a palavra que ocasionou a quebra.
			EndIf
		EndIf
	Next

aSize(aPalavras,0)

Return Nil
