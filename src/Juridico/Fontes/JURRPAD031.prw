/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "JURRPAD031.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE 'FWPrintSetup.ch'
#INCLUDE "RPTDEF.CH"

Static __lAuto := .F. // Execução via automação de testes

//-------------------------------------------------------------------
/*/{Protheus.doc} JURRPAD031
Função para gerar o relatório de WO (FWMsPrinter)

@author Mauricio Canalle
@since 02/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
User Function JURRPAD031(dDtIni, dDtFim, cSAtivos, cRelatorio, lAutomato, cNameAuto)
	Local aArea := Getarea()

	Local oFont14N := TFont():New("Times New Roman", 9, 14, .T., .T.)
	Local oFont12  := TFont():New("Times New Roman", 9, 12, .T., .F.)
	Local oFont12N := TFont():New("Times New Roman", 9, 12, .T., .T.)

	Local oPrint2
	Local lAdjustToLegacy := .F. // Inibe legado de resolução com a TMSPrinter
	Local nLargTxt 		  := 620  // largura em pixel para alinhamento da funcao sayalign
	Local nLin            := 03
	Local lNewPage        := .T. // controla pagina nova - salto de pagina
	Local nCntPage        := 1  // contador de pagina     
	Local cMotEm          := ''
	Local nSubTot         := 0
	Local nTotGer         := 0
	
	Default lAutomato := .F.
	Default cNameAuto := ""

	__lAuto := lAutomato

	JA031QryRel(dDtIni, dDtFim, cSAtivos)   // query principal do relatório
	
	If !TMP->(Eof())		
		If __lAuto //Alterar o nome do arquivo de impressão para o padrão de impressão automatica
			oPrint2 := FWMsPrinter():New(cNameAuto, IMP_SPOOL,,, .T.,,,) // Inicia o relatório
			oPrint2:CFILENAME  := cNameAuto
			oPrint2:CFILEPRINT := oPrint2:CPATHPRINT + oPrint2:CFILENAME
		Else
			oPrint2 := FWMsPrinter():New( cRelatorio, IMP_PDF, lAdjustToLegacy,, .T.,,, "PDF" )
		EndIf
					
		oPrint2:SetResolution(78) // Tamanho estipulado
		oPrint2:SetPortrait()
		oPrint2:SetPaperSize(0, 297, 210)   // tamanho da folha 
		oPrint2:SetMargin(10,10,10,10)
			
		While !TMP->(Eof())
		    If lNewpage  // NOVA PAGINA
		    	oPrint2:StartPage() // Inicia uma nova página      
			
		    	oPrint2:Say(nlin, 001, STR0002, oFont12N) // Data de Emissão:
		    	If !__lAuto
					oPrint2:Say(nlin, 090, dtoc(dDataBase), oFont12)
				EndIf
			
		    	nLin += 15
			 
		    	oPrint2:SayAlign( nLin, 01,  STR0001, oFont14N, nLargTxt, 200, CLR_BLACK, 2, 0 )  // Relatório de WO
		    	
		    	nLin += 15

		    	oPrint2:Say(nLin+10, 001, STR0003, oFont12N) // Periodo:
				If !__lAuto
					oPrint2:Say(nLin+10, 050, dtoc(dDtIni) + ' a ' + dtoc(dDtFim), oFont12)
				EndIf
		    	
		    	oPrint2:SayAlign( nLin, 01,  STR0005+": "+If(cSAtivos=='1','Sim','Não'), oFont12N, nLargTxt, 200, CLR_BLACK, 1, 0 )  // Somente Ativos

		    	nLin += 15
		    	
		    	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1") 
		    	
		    	nLin += 12
		    	
		    	lNewPage := .F.
		    Endif	
	
	        If cMotEm <> TMP->NUF_CMOTEM   // controle de quebra por motivo     	
	        	oPrint2:Say(nlin, 001, TMP->NUF_CMOTEM+' - '+alltrim(Posicione('NXV', 1, xFilial('NXV')+TMP->NUF_CMOTEM, 'NXV_DESC')), oFont14N) // MOTIVO WO
			
	        	nLin += 10
			
	        	oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			
	        	nLin += 15
	        	
	        	cMotEm := TMP->NUF_CMOTEM 
	        Endif	
			
			oPrint2:Say(nlin, 001, STR0006, oFont12N) // Informações do WO
			
			nLin += 15
			
			oPrint2:Say(nlin, 001, STR0007, oFont12N) // Código
			oPrint2:Say(nlin, 230, STR0008, oFont12N) // Situação
			oPrint2:Say(nlin, 390, STR0009, oFont12N) // Emissão
			oPrint2:Say(nlin, 520, STR0010, oFont12N) // Sigla

			oPrint2:Say(nlin, 045, TMP->NUF_COD, oFont12) // Código
			oPrint2:Say(nlin, 280, If(TMP->NUF_SITUAC=='1','Ativo','Cancelado'), oFont12) // Situação
			oPrint2:Say(nlin, 440, DTOC(STOD(TMP->NUF_DTEMI)), oFont12) // Emissão
			oPrint2:Say(nlin, 555	, TMP->RD0_SIGLA, oFont12) // Sigla
			
			nLin += 20
			
			oPrint2:Say(nlin, 001, STR0011, oFont12N) // Fatura					
			oPrint2:Say(nlin, 230, STR0012, oFont12N) //Obs. emissão						
			
			oPrint2:Say(nlin, 045, alltrim(TMP->NUF_CFATU) + ' / ' + alltrim(TMP->NUF_CESCR), oFont12) // Fatura					
			oPrint2:Say(nlin, 300, TMP->NUF_OBSEMI, oFont12) //Obs. emissão
			
			nLin += 20
			
			oPrint2:Say(nlin, 001, STR0013, oFont12N) // Tem TS
			oPrint2:Say(nlin, 120, STR0014, oFont12N) // Tem DP
			oPrint2:Say(nlin, 230, STR0015, oFont12N) // Tem LT
			oPrint2:Say(nlin, 360, STR0016, oFont12N) // Tem FX
			oPrint2:Say(nlin, 480, STR0017, oFont12N) // Tem FA
			
			oPrint2:Say(nlin, 051, RetTem031('NW0', 8, TMP->NUF_COD), oFont12) // Tem TS
			oPrint2:Say(nlin, 170, RetTem031('NVZ', 8, TMP->NUF_COD), oFont12) // Tem DP
			oPrint2:Say(nlin, 280, RetTem031('NW4', 3, TMP->NUF_COD), oFont12) // Tem LT
			oPrint2:Say(nlin, 410, RetTem031('NWE', 6, TMP->NUF_COD), oFont12) // Tem FX
			oPrint2:Say(nlin, 530, RetTem031('NWD', 6, TMP->NUF_COD), oFont12) // Tem FA
			
			// Tratamento de cancelamento
			If !empty(TMP->NUF_DTCAN)
				nLin += 20
			
				oPrint2:Say(nlin, 001, STR0018, oFont12N) // Informações do cancelamento
			
				nLin += 15
			
				oPrint2:Say(nlin, 001, STR0019, oFont12N) // Data:
				oPrint2:Say(nlin, 230, STR0020, oFont12N) // Motivo:
				
				oPrint2:Say(nlin, 045, dtoc(stod(TMP->NUF_DTCAN)), oFont12) // Data:
				oPrint2:Say(nlin, 280, TMP->NUF_CMOTCA+' - '+Posicione('NXV', 1, xFilial('NXV')+TMP->NUF_CMOTCA, 'NXV_DESC'), oFont12) // Motivo:
			
				nLin += 20
			
				oPrint2:Say(nlin, 001, STR0010, oFont12N) // Sigla:
				oPrint2:Say(nlin, 230, STR0021, oFont12N) // Obs. canc.:
				
				oPrint2:Say(nlin, 045, TMP->RD0_SIGLA, oFont12) // Sigla:
				oPrint2:Say(nlin, 290, TMP->NUF_OBSCAN, oFont12) // Obs. canc.				
			Endif
			
			nLin += 15

			oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")
			
			nLin += 12			
						
			nSubtot++		
				
			TMP->(DbSkip())
			
			If cMotEm <> TMP->NUF_CMOTEM
			   nLin += 5
			   
			   // sub total por motivo
			   oPrint2:SayAlign(nLin, 01, STR0022+' '+cMotEm+' - '+alltrim(Posicione('NXV', 1, xFilial('NXV')+cMotEm, 'NXV_DESC'))+Str(nSubTot,6), oFont12N, nLargTxt, 200, CLR_BLACK, 1, 0)  //Sub-Total:

			   nLin += 25
			   
			   nTotGer += nSubtot
			   nSubtot := 0	   
			   
			   If TMP->(Eof())  // imprime o total geral
			   		oPrint2:SayAlign(nLin, 01, STR0023+Str(nTotGer, 6), oFont14N, nLargTxt, 200, CLR_BLACK, 1, 0)	  //Total Geral:		    
			   Else
			   		oPrint2:Line( nLin, 01, nLin, nLargTxt, CLR_BLACK, "-1")   			
			   Endif
			   
			   nLin += 12	
			Endif
			
			// CONTROLE DE SALTO DE PAGINA
			If nLin >= 700 .or. TMP->(Eof())
				If !__lAuto
					oPrint2:SayAlign(If(nLin > 810, nLin, 810), 01, Strzero(nCntPage, 3), oFont12, nLargTxt, 200, CLR_BLACK, 1, 0)  // numero da pagina
				EndIf
	       	
				oPrint2:EndPage() // Finaliza a página
  		   
				nLin     := 03
				lNewPage := .T.
				nCntPage++
			Endif
		End
		
		oPrint2:Preview()			
	Endif
	
	TMP->(DbCloseArea())
	
	RestArea(aArea)
Return
 
//-------------------------------------------------------------------
/*/{Protheus.doc} JA031QryRel()
Função para gerar a query principal do relatório de WO (FWMsPrinter)

@author Mauricio Canalle
@since 02/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function JA031QryRel(dDtIni, dDtFim, cSAtivos)
Local cQuery := ""
Local aArea  := GetArea() 
Local TMP    := GetNextAlias()
 
	cQuery := "SELECT NUF_COD, NUF_SITUAC, NUF_DTEMI, NUF_CMOTEM, NUF_OBSEMI, NUF_DTCAN, NUF_OBSCAN, NUF_CFATU, NUF_CESCR, NUF_CMOTCA, RD0_SIGLA"
	cQuery += " FROM " + RetSqlName('NUF')+' NUF'
	cQuery += " INNER JOIN  " + RetSqlName('RD0') + " RD0 ON RD0.RD0_FILIAL = '"+xFilial('RD0')+"' AND RD0.RD0_USER = NUF.NUF_USREMI AND RD0.D_E_L_E_T_ = ' '"
	cQuery += " WHERE NUF.NUF_FILIAL = '"+xFilial('NUF')+"' AND NUF.NUF_DTEMI BETWEEN '"+DTOS(dDtIni)+"' AND '"+DTOS(dDtFim)+"' AND NUF.D_E_L_E_T_ = ' '"
	
	If cSAtivos == '1'  // somente os ativos
	   cQuery += " AND NUF.NUF_SITUAC = '1'"
    Endif
    
    cQuery += " ORDER BY NUF.NUF_CMOTEM, NUF.NUF_COD"
    
    DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TMP",.T.,.T.)
     
	RestArea(aArea)
  
Return  

//-------------------------------------------------------------------
/*/{Protheus.doc} RetTem031()
Função genérica para retornar Sim/Nao tratando os seguintes campos e tabelas
do relatório

Tabela NW0 - Tem TS
Tabela NVZ - Tem DP
Tabela NW4 - Tem LT
Tabela NWE - Tem FX
Tabela NWD - Tem FA	

@author Mauricio Canalle
@since 02/05/16
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function RetTem031(cTabela, nIndOrd, cChave)
Local cRet  := ''
Local aArea := Getarea()

	(cTabela)->(DbSetOrder(nIndOrd))
	If (cTabela)->(DbSeek(xFilial(cTabela)+cChave))
	   cRet := 'Sim'
	Else
	   cRet := 'Não'
	Endif

	RestArea(aArea)

Return cRet