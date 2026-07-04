/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "JURRPAD026.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

Static __lAuto := .F. // Execução via automação de testes

//-------------------------------------------------------------------
/*/{Protheus.doc} JURRPAD026
Rotina para o processamento do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//------------------------------------------------------------------- 
 User Function JURRPAD026(cAnoMes, cEscri, cGrpCli, cCliente, cLoja, cContrato, cRelatorio, lAutomato, cNameAuto)
	Local aArea := Getarea()

	Local oFont14N := TFont():New("Times New Roman", 9, 14, .T., .T.)
	Local oFont10  := TFont():New("Times New Roman", 9, 10, .T., .F.)
	Local oFont09  := TFont():New("Courier New", 9, 09, .T., .F.)
	Local oFont10N := TFont():New("Times New Roman", 9, 10, .T., .T.)
	Local oFont12N := TFont():New("Times New Roman", 9, 12, .T., .T.)

	Local oPrint2
	Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
	Local nLargTxt 		  := 900 // largura em pixel para alinhamento da funcao sayalign
	Local nLin            := 03
	Local lNewPage        := .T. // controla pagina nova - salto de pagina
	Local nCntPage        := 1  // contador de pagina     
	Local cEscrit         := ''  // controle de quebra por escritorio
	Local cCliAnt         := '' // controle de quebra por cliente
	Local aTotEscA        := {0,0,0,0,0,0,0,0,0,0} // Total por escritorio
	Local aTotEscAC       := {0,0,0,0,0,0,0,0,0,0} // Total por escritorio acumulado
	Local aTotGerA        := {0,0,0,0,0,0,0,0,0,0} // Total Geral
	Local aTotGerAC       := {0,0,0,0,0,0,0,0,0,0} // Total Geral acumulado
	Local oBrush1         := Nil

	Default lAutomato := .F.
	Default cNameAuto := ""

	__lAuto := lAutomato

   	JA026QryRel(cAnoMes, cEscri, cGrpCli, cCliente, cLoja, cContrato)   // query principal do relatório
	
	If !TMP->(Eof())
		If __lAuto //Alterar o nome do arquivo de impressão para o padrão de impressão automatica
			oPrint2 := FWMsPrinter():New(cNameAuto, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
			oPrint2:CFILENAME  := cNameAuto
			oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
		Else
			oPrint2 := FWMsPrinter():New( cRelatorio, IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF" )
		EndIf
					
		oPrint2:SetResolution(78) // Tamanho estipulado
		oPrint2:SetLandscape()
		oPrint2:SetPaperSize(0, 210, 297)   // tamanho da folha 
		oPrint2:SetMargin(10,10,10,10)
			
		While !TMP->(Eof())
		    If lNewpage  // NOVA PAGINA - cabecalho		    
		        J026Cabec(@oPrint2, cAnoMes, @nLin, oFont10, oFont14N, nLargTxt)
		    	
		    	lNewPage := .F.
		    Endif	

	        If cEscrit <> TMP->OH0_CESCR   // controle de quebra por escritorio     	
	        	oPrint2:Say(nlin, 001, Posicione('NS7', 1, xFilial('NS7')+TMP->OH0_CESCR, 'NS7_COD')+' - '+Posicione('NS7', 1, xFilial('NS7')+TMP->OH0_CESCR, 'NS7_NOME'), oFont12N) // Escritório
			
		       	nLin += 15
		       	
		       	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
		       	
		       	nLin += 12
	        	
	        	cEscrit := TMP->OH0_CESCR
	        	cCliAnt := ''  // sempre que quebra o escritorio forço a impressao do cliente
	        Endif
	        
	        If cCliAnt <> TMP->A1_COD+TMP->A1_LOJA   // controle de quebra por cliente	
	        	oPrint2:Say(nlin, 001, STR0004+' '+TMP->A1_COD+"/"+TMP->A1_LOJA+' - '+Posicione('SA1', 1, xFilial('SA1')+TMP->A1_COD+TMP->A1_LOJA,"A1_NOME"), oFont12N) // Cliente:

	        	nLin += 10
			
		       	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
		       	
		       	nLin += 15
	        	
	        	cCliAnt := TMP->A1_COD+TMP->A1_LOJA 
	        Endif	
	        	
			// detalhe			
			oPrint2:Say(nlin, 001, STR0009+' '+TMP->OH0_CCONTR+" - "+Posicione('NT0', 1, xFilial('NT0')+TMP->OH0_CCONTR, "NT0_NOME"), oFont10N)  // Contrato:
			
			nLin += 12			 					
			
			oPrint2:Say(nlin, 070, STR0006, oFont09)  // Adicional
			oPrint2:Say(nlin, 135, STR0007, oFont09)  // Exito 
			oPrint2:Say(nlin, 180, STR0008, oFont09)  // Final Contrato
			oPrint2:Say(nlin, 290, STR0009, oFont09)  // Fixo
			oPrint2:Say(nlin, 340, STR0010, oFont09)  // Limite Geral
			oPrint2:Say(nlin, 425, STR0011, oFont09)  // Mínimo / Misto
			oPrint2:Say(nlin, 520, STR0012, oFont09)  // Não Cobrar
			oPrint2:Say(nlin, 595, STR0013, oFont09)  // Pré-def./Ocor.
			oPrint2:Say(nlin, 690, STR0014, oFont09)  // Por Hora
			oPrint2:Say(nlin, 760, STR0015, oFont09)  // Provisório
			oPrint2:Say(nlin, 820, STR0016, oFont09)  // Total do Contrato
			
			nLin += 12			
			
			oBrush1 := TBrush():New( , CLR_HGRAY)
			oPrint2:Fillrect( {nLin-9, 001, (nLin-9)+12, nLargTxt }, oBrush1, "-1")
			
			oPrint2:Say(nlin, 001, STR0004, oFont09)  // Ref.
			oPrint2:Say(nlin, 047, Transform(TMP->FAVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 135, If(TMP->EXVAL=='S', 'Sim', '')		 , oFont09)   
			oPrint2:Say(nlin, 179, Transform(TMP->FCVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 245, Transform(TMP->FXVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 330, Transform(TMP->LIVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 425, Transform(TMP->MIVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 501, Transform(TMP->NCVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 591, Transform(TMP->POVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 663, Transform(TMP->HRVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 743, Transform(TMP->PRVAL, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 833, Transform((TMP->FAVAL + TMP->FCVAL + TMP->FXVAL + TMP->LIVAL + TMP->MIVAL + TMP->NCVAL + TMP->POVAL + TMP->HRVAL + TMP->PRVAL), '@e 999,999,999.99'), oFont09)  
						
			nLin += 15						

			oPrint2:Say(nlin, 001, STR0005, oFont09)  // Acum.						
			oPrint2:Say(nlin, 047, Transform(TMP->FAACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 135, ''								, oFont09)   
			oPrint2:Say(nlin, 179, Transform(TMP->FCACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 245, Transform(TMP->FXACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 330, Transform(TMP->LIACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 425, Transform(TMP->MIACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 501, Transform(TMP->NCACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 591, Transform(TMP->POACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 663, Transform(TMP->HRACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 743, Transform(TMP->PRACUM, '@e 999,999,999.99'), oFont09)  
			oPrint2:Say(nlin, 833, Transform((TMP->FAACUM + TMP->FCACUM + TMP->FXACUM + TMP->LIACUM + TMP->MIACUM + TMP->NCACUM + TMP->POACUM + TMP->HRACUM + TMP->PRACUM), '@e 999,999,999.99'), oFont09)  
			
			nLin += 20
	
			aTotEscA[01] += TMP->FAVAL
			aTotEscA[02] += TMP->FCVAL 
			aTotEscA[03] += TMP->FXVAL 
			aTotEscA[04] += TMP->LIVAL
			aTotEscA[05] += TMP->MIVAL 
			aTotEscA[06] += TMP->NCVAL 
			aTotEscA[07] += TMP->POVAL 
			aTotEscA[08] += TMP->HRVAL 
			aTotEscA[09] += TMP->PRVAL
			aTotEscA[10] += (TMP->FAVAL + TMP->FCVAL + TMP->FXVAL + TMP->LIVAL + TMP->MIVAL + TMP->NCVAL + TMP->POVAL + TMP->HRVAL + TMP->PRVAL) 
			
			aTotGerA[01] += TMP->FAVAL
			aTotGerA[02] += TMP->FCVAL
			aTotGerA[03] += TMP->FXVAL
			aTotGerA[04] += TMP->LIVAL
			aTotGerA[05] += TMP->MIVAL
			aTotGerA[06] += TMP->NCVAL
			aTotGerA[07] += TMP->POVAL 
			aTotGerA[08] += TMP->HRVAL 
			aTotGerA[09] += TMP->PRVAL
			aTotGerA[10] += (TMP->FAVAL + TMP->FCVAL + TMP->FXVAL + TMP->LIVAL + TMP->MIVAL + TMP->NCVAL + TMP->POVAL + TMP->HRVAL + TMP->PRVAL)	

			aTotEscAC[01] += TMP->FAACUM
			aTotEscAC[02] += TMP->FCACUM
			aTotEscAC[03] += TMP->FXACUM
			aTotEscAC[04] += TMP->LIACUM
			aTotEscAC[05] += TMP->MIACUM
			aTotEscAC[06] += TMP->NCACUM
			aTotEscAC[07] += TMP->POACUM
			aTotEscAC[08] += TMP->HRACUM
			aTotEscAC[09] += TMP->PRACUM
			aTotEscAC[10] += (TMP->FAACUM + TMP->FCACUM + TMP->FXACUM + TMP->LIACUM + TMP->MIACUM + TMP->NCACUM + TMP->POACUM + TMP->HRACUM + TMP->PRACUM)
			
			aTotGerAC[01] += TMP->FAACUM
			aTotGerAC[02] += TMP->FCACUM
			aTotGerAC[03] += TMP->FXACUM
			aTotGerAC[04] += TMP->LIACUM
			aTotGerAC[05] += TMP->MIACUM
			aTotGerAC[06] += TMP->NCACUM
			aTotGerAC[07] += TMP->POACUM
			aTotGerAC[08] += TMP->HRACUM
			aTotGerAC[09] += TMP->PRACUM
			aTotGerAC[10] += (TMP->FAACUM + TMP->FCACUM + TMP->FXACUM + TMP->LIACUM + TMP->MIACUM + TMP->NCACUM + TMP->POACUM + TMP->HRACUM + TMP->PRACUM)		
									
			nLin += 15		
				
			TMP->(DbSkip())	
			
			If cEscrit <> TMP->OH0_CESCR  // total do escritorio
			   nLin += 05
			   
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   nLin += 3
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   
			   nLin += 08			   
			   
			  oPrint2:SayAlign( nLin, 001,  alltrim(STR0017+':   '+cEscrit+' - '+Posicione('NS7', 1, xFilial('NS7')+cEscrit, 'NS7_NOME')), oFont12N, nLargTxt, 200, CLR_BLACK, 2, 0 )

			   nLin += 15	
			   
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")

			   nLin += 10
			   
				oPrint2:Say(nlin, 070, STR0006, oFont09)  // Adicional
				oPrint2:Say(nlin, 135, STR0007, oFont09)  // Exito 
				oPrint2:Say(nlin, 180, STR0008, oFont09)  // Final Contrato
				oPrint2:Say(nlin, 290, STR0009, oFont09)  // Fixo
				oPrint2:Say(nlin, 340, STR0010, oFont09)  // Limite Geral
				oPrint2:Say(nlin, 425, STR0011, oFont09)  // Mínimo / Misto
				oPrint2:Say(nlin, 520, STR0012, oFont09)  // Não Cobrar
				oPrint2:Say(nlin, 595, STR0013, oFont09)  // Pré-def./Ocor.
				oPrint2:Say(nlin, 690, STR0014, oFont09)  // Por Hora
				oPrint2:Say(nlin, 760, STR0015, oFont09)  // Provisório
				oPrint2:Say(nlin, 875, STR0003, oFont09)  // Total 
				
				nLin += 12
				
				oPrint2:Say(nlin, 001, STR0004, oFont09)  // Ref.
				oPrint2:Say(nlin, 047, Transform(aTotEscA[01], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 135, ''								, oFont09)   
				oPrint2:Say(nlin, 179, Transform(aTotEscA[02], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 245, Transform(aTotEscA[03], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 330, Transform(aTotEscA[04], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 425, Transform(aTotEscA[05], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 501, Transform(aTotEscA[06], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 591, Transform(aTotEscA[07], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 663, Transform(aTotEscA[08], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 743, Transform(aTotEscA[09], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 833, Transform(aTotEscA[10], '@e 999,999,999.99'), oFont09)  
							
				nLin += 15						
	
				oPrint2:Say(nlin, 001, STR0005, oFont09)  // Acum.						
				oPrint2:Say(nlin, 047, Transform(aTotEscAC[01], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 135, ''								, oFont09)   
				oPrint2:Say(nlin, 179, Transform(aTotEscAC[02], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 245, Transform(aTotEscAC[03], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 330, Transform(aTotEscAC[04], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 425, Transform(aTotEscAC[05], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 501, Transform(aTotEscAC[06], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 591, Transform(aTotEscAC[07], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 663, Transform(aTotEscAC[08], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 743, Transform(aTotEscAC[09], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 833, Transform(aTotEscAC[10], '@e 999,999,999.99'), oFont09)  	
				
				nLin += 10
			    oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			    nLin += 2
			    oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   
			    nLin += 20
			    
			    aTotEscA        := {0,0,0,0,0,0,0,0,0,0} // Total por escritorio
			    aTotEscAC       := {0,0,0,0,0,0,0,0,0,0} // Total por escritorio acumulado			    
			Endif
			
			// CONTROLE DE SALTO DE PAGINA
			If nLin >= 500			    
			    oPrint2:Say(If(nLin > 570, nLin, 570), 001, STR0019+' '+cMoedaNac+' - '+Posicione('CTO', 1, xFilial('CTO')+cMoedaNac, 'CTO_SIMB'), oFont09) // "Acesso restrito"
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 580, nLin, 580), 01, Strzero(nCntPage, 3), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página
  		   
				nLin     := 03
				lNewPage := .T.
				nCntPage++
				
				If TMP->(Eof()) 
				   J026Cabec(@oPrint2, cAnoMes, @nLin, oFont10, oFont14N, nLargTxt)
				Endif
			Endif
			
			If TMP->(Eof())   // total geral
			   nLin += 05
			   
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   nLin += 3
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			   
			   nLin += 08			   
			   
			   oPrint2:SayAlign( nLin, 001,  STR0018, oFont12N, nLargTxt, 200, CLR_BLACK, 2, 0 )

			   nLin += 15	
			   
			   oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")

			   nLin += 10
			   
				oPrint2:Say(nlin, 070, STR0006, oFont09)  // Adicional
				oPrint2:Say(nlin, 135, STR0007, oFont09)  // Exito 
				oPrint2:Say(nlin, 180, STR0008, oFont09)  // Final Contrato
				oPrint2:Say(nlin, 290, STR0009, oFont09)  // Fixo
				oPrint2:Say(nlin, 340, STR0010, oFont09)  // Limite Geral
				oPrint2:Say(nlin, 425, STR0011, oFont09)  // Mínimo / Misto
				oPrint2:Say(nlin, 520, STR0012, oFont09)  // Não Cobrar
				oPrint2:Say(nlin, 595, STR0013, oFont09)  // Pré-def./Ocor.
				oPrint2:Say(nlin, 690, STR0014, oFont09)  // Por Hora
				oPrint2:Say(nlin, 760, STR0015, oFont09)  // Provisório
				oPrint2:Say(nlin, 875, STR0003, oFont09)  // Total 
				
				nLin += 12
				
				oPrint2:Say(nlin, 001, STR0004, oFont09)  // Ref.
				oPrint2:Say(nlin, 047, Transform(aTotGerA[01], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 135, ''								, oFont09)   
				oPrint2:Say(nlin, 179, Transform(aTotGerA[02], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 245, Transform(aTotGerA[03], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 330, Transform(aTotGerA[04], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 425, Transform(aTotGerA[05], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 501, Transform(aTotGerA[06], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 591, Transform(aTotGerA[07], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 663, Transform(aTotGerA[08], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 743, Transform(aTotGerA[09], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 833, Transform(aTotGerA[10], '@e 999,999,999.99'), oFont09)  
							
				nLin += 15						
	
				oPrint2:Say(nlin, 001, STR0005, oFont09)  // Acum.						
				oPrint2:Say(nlin, 047, Transform(aTotGerAC[01], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 135, ''								, oFont09)   
				oPrint2:Say(nlin, 179, Transform(aTotGerAC[02], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 245, Transform(aTotGerAC[03], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 330, Transform(aTotGerAC[04], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 425, Transform(aTotGerAC[05], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 501, Transform(aTotGerAC[06], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 591, Transform(aTotGerAC[07], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 663, Transform(aTotGerAC[08], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 743, Transform(aTotGerAC[09], '@e 999,999,999.99'), oFont09)  
				oPrint2:Say(nlin, 833, Transform(aTotGerAC[10], '@e 999,999,999.99'), oFont09)				
				
				nLin += 10
			    oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			    nLin += 2
			    oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")

			    oPrint2:Say(If(nLin > 570, nLin, 570), 001, STR0019+' '+cMoedaNac+' - '+Posicione('CTO', 1, xFilial('CTO')+cMoedaNac, 'CTO_SIMB'), oFont09) //
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 580, nLin, 580), 01, Strzero(nCntPage, 3), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página		
			Endif
		End
		
		oPrint2:Preview()			
	Endif
	
	TMP->(DbCloseArea())
	
	RestArea(aArea)
Return 

//-------------------------------------------------------------------
/*/{Protheus.doc} JA026QryRel
Query Principal do relatorio

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JA026QryRel(cAnoMes, cEscri, cGrpCli, cCliente, cLoja, cContrato)
Local cQuery := ""
Local aArea  := GetArea() 
Local TMP    := GetNextAlias()

	 cQuery := "SELECT OH0_CCONTR, OH0_CESCR, A1_COD, A1_LOJA,"
	 
	 cQuery += " (SELECT 'S'			 FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'EX' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) EXVAL,"	 
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FA' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FAVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FA' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FAACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FX' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FXVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FX' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FXACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FC' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FCVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'FC' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) FCACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'LI' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) LIVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'LI' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) LIACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'MI' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) MIVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'MI' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) MIACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'NC' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) NCVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'NC' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) NCACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'PO' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) POVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'PO' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) POACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'HR' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) HRVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'HR' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) HRACUM,"
	 cQuery += " (SELECT SUM(OH0_VLAM)   FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'PR' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) PRVAL,"
	 cQuery += " (SELECT SUM(OH0_VLACUM) FROM "+RetSqlName('OH0')+" OH1 WHERE OH1.OH0_FILIAL = '"+xFilial('OH0')+"' AND OH1.D_E_L_E_T_ = ' '  AND OH1.OH0_CUSER = '"+__CUSERID+"' AND OH1.OH0_TIPO = 'PR' AND OHP.OH0_CCONTR = OH1.OH0_CCONTR) PRACUM"
	 
	 cQuery += " FROM   "+RetSqlName('OH0')+" OHP"
	 cQuery += " INNER JOIN "+RetSqlName('NT0')+" NT0 ON NT0.NT0_FILIAL = '"+xFilial('NT0')+"' AND OHP.OH0_CCONTR = NT0.NT0_COD  AND NT0.D_E_L_E_T_ = ' '"
	 
	 If !empty(cCliente) .and. !empty(cLoja)
	  	cQuery += " AND NT0.NT0_CCLIEN ='"+cCliente+"' AND NT0.NT0_CLOJA = '"+cLoja+"'"
	 Endif	 
	 	 
	 cQuery += " INNER JOIN "+RetSqlName('SA1')+" SA1 ON SA1.A1_FILIAL  = '"+xFilial('SA1')+"' AND NT0.NT0_CCLIEN = SA1.A1_COD  AND NT0.NT0_CLOJA = SA1.A1_LOJA AND SA1.D_E_L_E_T_ = ' '"
	 
	 If !empty(cGrpCli)
	 	cQuery += " AND SA1.A1_GRPVEN ='"+cGrpCli+"'"
	 Endif
	 
	 cQuery += " WHERE  OHP.OH0_FILIAL = '"+xFilial('OH0')+"' AND OHP.OH0_CUSER='"+__CUSERID+"' AND OHP.D_E_L_E_T_=' '"
	 
	 If !empty(cEscri)
	    cQuery += " AND OHP.OH0_CESCR = '"+cEscri+"'" 	
	 Endif
	 
	 If !empty(cContrato)
	 	cQuery += " AND OHP.OH0_CCONTR = '"+cContrato+"'"	
	 Endif
	 
	 cQuery += " GROUP BY OH0_CCONTR, OH0_CESCR, A1_COD, A1_LOJA"
	 cQuery += " ORDER BY OH0_CESCR, A1_COD, A1_LOJA, OH0_CCONTR"
 
     DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP",.T.,.T.)
     
	RestArea(aArea)
  
Return  
 
//-------------------------------------------------------------------
/*/{Protheus.doc} J026Cabec
Geracao do cabecalho

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
 Static Function J026Cabec(oPrint2, cAnoMes, nLin, oFont10, oFont14N, nLargTxt)
    oPrint2:StartPage() // Inicia uma nova página
    
    nLin := 03
	
	If !__lAuto
		oPrint2:SayAlign( nLin, 001,  dtoc(dDataBase), oFont10, nLargTxt, 200, CLR_BLACK, 1, 0 )
	EndIf
						
   	nLin += 15
				 
   	oPrint2:SayAlign( nLin, 001,  STR0001, oFont14N, nLargTxt, 200, CLR_BLACK, 2, 0 )  // PREVISÃO DE FATURAMENTO
					    	
   	nLin += 15
			
   	oPrint2:SayAlign( nLin, 001, STR0002+' '+Substr(cAnoMes, 1, 4)+'-'+Substr(cAnoMes, 5, 2), oFont10, nLargTxt, 200, CLR_BLACK, 2, 0) // Referência:
					    			    	
   	nLin += 25
Return