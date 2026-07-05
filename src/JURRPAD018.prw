/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "JURRPAD018.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

Static __lAuto := .F.

//-------------------------------------------------------------------
/*/{Protheus.doc} JURRPAD018
Rotina para o processamento do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
User Function JURRPAD018(dDtIni, dDtFim, cGrpCliente, cCliente, cLoja, cMoeda, cQuebra, cTpDespesa, cRelatorio, lAutomato)
	Local aArea := Getarea()

	Local oFont14N := TFont():New("Times New Roman", 9, 14, .T., .T.)
	Local oFont12  := TFont():New("Times New Roman", 9, 12, .T., .F.)
	Local oFont12N := TFont():New("Times New Roman", 9, 12, .T., .T.)
	Local oFont11CN:= TFont():New("Courier New", 9, 11, .T., .T.)
	Local oFont11  := TFont():New("Times New Roman", 9, 11, .T., .F.)
	Local oFont11C := TFont():New("Courier New", 9, 11, .T., .F.)

	Local oPrint2         := Nil
	Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
	Local nLargTxt 		  := 620  // largura em pixel para alinhamento da funcao sayalign
	Local nLin            := 03
	Local nI			  := 0
	Local lNewPage        := .T. // controla pagina nova - salto de pagina
	Local nCntPage        := 1  // contador de pagina     
	Local aVetRel         := {}	
	Local cSimbMoe        := ''

	Default lAutomato := .F.

	__lAuto := lAutomato
	
	JA018QryRel(dDtIni, dDtFim, cGrpCliente, cCliente, cLoja, cMoeda, cTpDespesa, @aVetRel, @cSimbMoe)   // query principal do relatório
					
	If Len(aVetRel) > 0	
	//Configurações do relatório
		
		If __lAuto
			oPrint2 := FWMsPrinter():New( cRelatorio, IMP_SPOOL,,, .T.,,,)
			oPrint2:CFILENAME  := cRelatorio
			oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
		Else
			oPrint2 := FWMsPrinter():New( cRelatorio, IMP_PDF,lAdjustToLegacy,, .T.,,, "PDF" ) 
		EndIf
		oPrint2:SetResolution(78) // Tamanho estipulado
		oPrint2:SetPortrait()
		oPrint2:SetPaperSize(0, 297, 210)   // tamanho da folha 
		oPrint2:SetMargin(10,10,10,10)
		
		For nI := 1 to len(aVetRel)
	        If cQuebra == '1' .and. aVetRel[nI, 1]  == 'A'  .and. !lNewpage  // quebra por cliente	
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 810, nLin, 810), 01, Strzero(nCntPage, 3), oFont12, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página
  		   
				nLin     := 03
				lNewPage := .T.
				nCntPage++
		    Endif
		       
			If lNewpage  // NOVA PAGINA
				oPrint2:StartPage() // Inicia uma nova página      
				If !__lAuto
		    		oPrint2:Say(nlin, 001, dtoc(dDataBase), oFont12)
				EndIf
			
		    	nLin += 12
			 
		    	oPrint2:SayAlign( nLin, 01,  STR0001, oFont14N, nLargTxt, 200, CLR_BLACK, 2, 0 )  // RELAÇÃO DE DESPESAS
		    	
		    	nLin += 35

		    	oPrint2:Say(nLin, 001, STR0002, oFont12N) // Periodo:
		    	If !__lAuto
					oPrint2:Say(nLin, 050, dtoc(dDtIni) + ' a ' + dtoc(dDtFim), oFont12) 
				EndIf

		    	oPrint2:Say(nLin, 400, STR0003, oFont12N) // Valor
		    	oPrint2:Say(nLin, 445, STR0004, oFont12N) // Situação da Despesa

		    	nLin += 10
		    	
		    	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 
		    	
		    	lNewPage := .F.
		    Endif	
		    
		    If aVetRel[nI, 1]  == 'A'  // cliente
		       nLin += 12
		       oPrint2:Say(nLin, 001, aVetRel[nI, 2], oFont14N)
		       nLin += 08
		    	
		       oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")	
		       nLin += 12	       
		       
		    ElseIf aVetRel[nI, 1]  == 'B'   
		       oPrint2:Say(nLin, 001, aVetRel[nI, 2], oFont12N)  // caso
		       nLin += 15
		       oPrint2:Say(nLin, 010, STR0005+' '+cSimbMoe, oFont12N)  // Lançamento em:
		       oPrint2:Say(nLin, 350, aVetRel[nI, 3], oFont11CN)
		       nLin += 08
		    	
		       oPrint2:Line( nLin, 01, nLin, 430, CLR_BLACK, "-1")
		       nLin += 12		       
		         
		    ElseIf aVetRel[nI, 1]  == 'C'  // ano mes
		       nLin += 10
		       oPrint2:Say(nLin, 020, Substr(aVetRel[nI, 2], 1, 4)+'-'+Substr(aVetRel[nI, 2], 5, 2), oFont12N)
		       oPrint2:Say(nLin, 350, aVetRel[nI, 3], oFont11CN)
		       nLin += 18

		    ElseIf aVetRel[nI, 1]  == 'D'  // despesa
		       nLin += 10
		       oPrint2:Say(nLin, 030, aVetRel[nI, 2], oFont12N)
		       oPrint2:Say(nLin, 350, aVetRel[nI, 3], oFont11CN)
		       nLin += 16

		    ElseIf aVetRel[nI, 1]  == 'E'  // lancamentos
               oPrint2:Say(nLin, 040, aVetRel[nI, 2, 1], oFont11)
		       oPrint2:Say(nLin, 100, aVetRel[nI, 2, 2], oFont11)
               oPrint2:Say(nLin, 150, aVetRel[nI, 2, 3], oFont11)
		       oPrint2:Say(nLin, 190, aVetRel[nI, 2, 4], oFont11)
               oPrint2:Say(nLin, 350, aVetRel[nI, 2, 5], oFont11C)
		       oPrint2:Say(nLin, 445, aVetRel[nI, 2, 6], oFont11)
		       
		       nLin += 15
		    Endif

			// CONTROLE DE SALTO DE PAGINA
			If nLin >= 700 .or. nI ==  len(aVetRel)
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 810, nLin, 810), 01, Strzero(nCntPage, 3), oFont12, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página
  		   
				nLin     := 03
				lNewPage := .T.
				nCntPage++
			Endif
		Next
		
		oPrint2:Preview()
	Endif

	RestArea(aArea)
Return
 
//-------------------------------------------------------------------
/*/{Protheus.doc} JA018QryRel
Rotina para o processamento da query principal e montagem de vetor
para impressão e totalização do relatorio em FWMSPRINTER.

@author Mauricio Canalle
@since 03/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
 
Static Function JA018QryRel(dDtIni, dDtFim, cGrpCliente, cCliente, cLoja, cMoeda, cTpDespesa, aVetRel, cSimbMoe)
Local cQuery := ""
Local aArea  := GetArea() 
Local TMP    := GetNextAlias()
Local cSituac         := ''
Local cCliAnt         := ''
Local cCasoAnt        := ''
Local cMesAnt         := ''
Local cDespAnt        := ''
Local nTotCaso        := 0
Local nTotMes         := 0
Local nTotDesp        := 0
Local nPosCaso        := 0
Local nPosMes         := 0
Local nPosDesp        := 0
 
 	NVZ->(DbSetOrder(1))
 
 	cQuery := "SELECT NVY_CCLIEN, NVY_CLOJA, NVY_DATA, NVY_ANOMES, NVY_CTPDSP, NVY_CCASO, RD0_SIGLA, NUS_CESCR, NVY_VALOR, NVY.R_E_C_N_O_ RECNVY, NVY_CMOEDA, NVY_SITUAC, NVY_COD"
 	cQuery += " FROM "+RetSqlName('NVY')+" NVY"
 	cQuery += " INNER JOIN "+RetSqlName('RD0')+" RD0 ON RD0.RD0_FILIAL = '"+xFilial("RD0")+"' AND RD0.RD0_CODIGO = NVY.NVY_CPART AND RD0.D_E_L_E_T_ = ' '"
 	cQuery += " INNER JOIN "+RetSqlName('NUS')+" NUS ON NUS.NUS_FILIAL = '"+xFilial("NUS")+"' AND NUS.NUS_CPART  = NVY.NVY_CPART AND NVY.NVY_ANOMES >= NUS.NUS_AMINI AND NUS.D_E_L_E_T_ = ' '"	
 	cQuery += " WHERE  NVY.NVY_FILIAL = '"+xFilial("NVY")+"' AND NVY.NVY_DATA >= '"+dtos(dDtIni)+"' AND NVY.NVY_DATA <= '"+dtos(dDtFim)+"' AND NVY.D_E_L_E_T_ = ' '"

 	IIF( !empty(cGrpCliente) ,;
	   cQuery += " AND NVY.NVY_CGRUPO = '"+cGrpCliente+"'"	, )
 	
 	IIF( !empty(cCliente) .and. !empty(cLoja),;
	 	  cQuery += " AND NVY.NVY_CCLIEN = '"+cCliente+"' AND NVY.NVY_CLOJA = '"+cLoja+"'", )	
 	
 	IIF( !empty(cTpDespesa),;
       cQuery += " AND NVY.NVY_CTPDSP = '"+cTpDespesa+"'", )	
 	
 	IIF( !empty(cMoeda), ;
       cQuery += " AND NVY.NVY_CMOEDA = '"+cMoeda+"'", )	
 	
 	cQuery += " ORDER BY NVY_CCLIEN, NVY_CLOJA, NVY_CCASO, NVY_ANOMES, NVY_CTPDSP, NVY_DATA, NVY_COD"
    
    DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP",.T.,.T.)
    
    // Montagem do vetor com os dados do relatorio separando por tipo de registo e controle de quebra    
    While !TMP->(Eof())
        // Quebra por cliente
	    If cCliAnt <> (TMP->NVY_CCLIEN+TMP->NVY_CLOJA)	       
	       Aadd(aVetRel, {'A', TMP->NVY_CCLIEN+'-'+TMP->NVY_CLOJA+' - '+Posicione('SA1', 1, xFilial('SA1')+TMP->NVY_CCLIEN+TMP->NVY_CLOJA, 'A1_NOME'), 0})
		   cCliAnt := (TMP->NVY_CCLIEN+TMP->NVY_CLOJA)  		   
	    Endif
		    
	    // Quebra por caso
	    If cCasoAnt <> TMP->NVY_CCASO
	       Aadd(aVetRel, {'B', TMP->NVY_CCASO+' - '+Posicione('NVE', 1, xFilial('NVE')+TMP->NVY_CCLIEN+TMP->NVY_CLOJA+TMP->NVY_CCASO,'NVE_TITULO'), 0})
	       nPosCaso := len(aVetRel)
	       cCasoAnt := TMP->NVY_CCASO
	       cSimbMoe := Posicione('CTO', 1, xFilial('CTO')+TMP->NVY_CMOEDA,'CTO_SIMB')
	    Endif
		    
	    // Quebra por ano mes
	    If cMesAnt <> TMP->NVY_ANOMES
	        Aadd(aVetRel, {'C', TMP->NVY_ANOMES, 0})
	        nPosMes := len(aVetRel)
	    	cMesAnt := TMP->NVY_ANOMES
	    Endif
		    
	    // Quebra por despesa
	    If cDespAnt <> TMP->NVY_CTPDSP
	    	Aadd(aVetRel, {'D', TMP->NVY_CTPDSP+' - '+Posicione('NRH', 1, xFilial('NRH')+TMP->NVY_CTPDSP, 'NRH_DESC'), 0})
	    	nPosDesp := len(aVetRel)
	    	cDespAnt := TMP->NVY_CTPDSP
	    Endif

	    cSituac := ''
	    If NVZ->(DbSeek(xFilial("NVZ")+TMP->NVY_COD))
	       If TMP->NVY_SITUAC == '1' .Or. (TMP->NVY_SITUAC == '2' .And. !empty(NVZ->NVZ_CFATUR) .and. NVZ->NVZ_CANC == '1' )
	    	  cSituac := 'Pendente' 	    	
	       Else
	          If TMP->NVY_SITUAC == '2' 
	             If !empty(NVZ->NVZ_CWO)
	                cSituac := 'WO - '+NVZ->NVZ_CWO
	             Else
	                If !empty(NVZ->NVZ_CFATUR)
	                   cSituac := 'FT - ' + NVZ->NVZ_CESCR + '/' + NVZ->NVZ_CFATUR
	                Endif
	             Endif   
	          Endif   
	       Endif 
	    Endif
    
    	NVY->(DbGoTo(TMP->RECNVY))   // posiciono o NVY para usar o campo tipo memo NVY_DESCRI		
   
	    Aadd(aVetRel, {'E', {DTOC(STOD(TMP->NVY_DATA)), TMP->RD0_SIGLA, TMP->NUS_CESCR, NVY->NVY_DESCRI, Transform(TMP->NVY_VALOR, "@e 999,999,999.99"), cSituac}, 0})
    
	    nTotDesp += TMP->NVY_VALOR
	    nTotCaso += TMP->NVY_VALOR
	    nTotMes  += TMP->NVY_VALOR
    
	    TMP->(DbSkip())
              
        // Quebra por cliente
	    If cCliAnt <> (TMP->NVY_CCLIEN+TMP->NVY_CLOJA)
	    	aVetRel[nPosCaso, 3] := Transform(nTotCaso, "@e 999,999,999.99")
	    	aVetRel[nPosMes,  3] := Transform(nTotMes , "@e 999,999,999.99")
	    	aVetRel[nPosDesp, 3] := Transform(nTotDesp, "@e 999,999,999.99")

	    	nTotDesp := 0
	    	nTotCaso := 0
	    	nTotMes  := 0
	    	
	    	cCliAnt  := ''
	    	cCasoAnt := ''
	    	cMesAnt  := ''
	    	cDespAnt := ''
	    Else
	    	// Quebra por caso
	    	If cCasoAnt <> TMP->NVY_CCASO
	    		aVetRel[nPosCaso, 3] := Transform(nTotCaso, "@e 999,999,999.99")
	    		aVetRel[nPosMes,  3] := Transform(nTotMes , "@e 999,999,999.99")
	    		aVetRel[nPosDesp, 3] := Transform(nTotDesp, "@e 999,999,999.99")

	    		nTotDesp := 0
	    		nTotCaso := 0
	    		nTotMes  := 0
	    	
	    		cCasoAnt := ''
	    		cMesAnt  := ''
	    		cDespAnt := ''	    		
	    	Else
	    		// Quebra por ano mes
	    		If cMesAnt <> TMP->NVY_ANOMES
	    			aVetRel[nPosMes,  3] := Transform(nTotMes , "@e 999,999,999.99")
	    			aVetRel[nPosDesp, 3] := Transform(nTotDesp, "@e 999,999,999.99")

	    			nTotDesp := 0
	    			nTotMes  := 0
	    		
	    			cMesAnt  := ''
	    			cDespAnt := ''
	    		Else
	    			// Quebra por despesa
	    			If cDespAnt <> TMP->NVY_CTPDSP
	    				aVetRel[nPosDesp, 3] := Transform(nTotDesp, "@e 999,999,999.99")

	    				nTotDesp := 0
	    				
	    				cDespAnt := ''
	    			Endif
	    		Endif
	    	Endif	
	    Endif
    End
     
    TMP->(DbCloseArea()) 
	RestArea(aArea)  
Return 