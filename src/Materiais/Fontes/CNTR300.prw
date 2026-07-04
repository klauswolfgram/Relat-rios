/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'report.ch'
#Include 'cntr300.ch'

//-------------------------------------------------------------------
/*{Protheus.doc} CNTR300
Multas e bonificações aplicadas na medição - POR CONTRATO

@author antenor.silva
@since 04/05/2015
@version P12.00
*/
//-------------------------------------------------------------------
User Function CNTR300()
Local oReport
Local oBreakCTRT
Local oBreakCTRT2
Local oBreakCTRT3
Local oCNR
Local oCTRT
Local oCNR2
Local oCTRT2
Local cAliasCNR 	:= GetNextAlias()
Local aOrdem		:= {STR0001,STR0002} // -- "Por Contrato","Por Multa/Bonificação"

Pergunte("CNTR300",.F.)

DEFINE REPORT oReport NAME STR0003 TITLE STR0003 PARAMETER "CNTR300" ACTION {|oReport| PrintReport(oReport,cAliasCNR)} // --"Multas e Bonificações por Contrato"
	
	//Visão - por contrato
	DEFINE SECTION oCTRT OF oReport TITLE STR0004 TABLES "CN9" ORDERS aOrdem // -- "Contratos"
		DEFINE CELL NAME "CN9_NUMERO" OF oCTRT ALIAS "CN9"
		DEFINE CELL NAME "CN9_REVISA" OF oCTRT ALIAS "CN9"		
						
	DEFINE SECTION oCNR OF oCTRT TITLE STR0001 TABLES "CNR","CND","CN4"
		DEFINE CELL NAME "CND_NUMMED" 	OF oCNR ALIAS "CND"
		DEFINE CELL NAME "CND_DTFIM"	OF oCNR ALIAS "CND"
		DEFINE CELL NAME "CN4_CODIGO" 	OF oCNR ALIAS "CN4"
		DEFINE CELL NAME "CNR_DESCRI" 	OF oCNR ALIAS "CN4"		
		DEFINE CELL NAME "CNR_VALOR" 	OF oCNR ALIAS "CNR"
		
		DEFINE BREAK oBreakCTRT OF oCNR WHEN  {|| (cAliasCNR)->CN9_NUMERO+(cAliasCNR)->CNR_TIPO}
		DEFINE FUNCTION FROM oCNR:Cell("CNR_VALOR") BREAK oBreakCTRT FUNCTION SUM NO END SECTION NO END REPORT
		
	// Visão - por Multa/bonificação	
	DEFINE SECTION oCTRT2 OF oReport TITLE STR0005 TABLES "CN4","CNR" // -- "Multa/Bonificação"
		DEFINE CELL NAME "CN4_CODIGO" OF oCTRT2 ALIAS "CN4"
		DEFINE CELL NAME "CNR_DESCRI" OF oCTRT2 ALIAS "CN4"
					
	DEFINE SECTION oCNR2 OF oCTRT2 TITLE STR0002 TABLES "CNR","CND","CN9"
		DEFINE CELL NAME "CN9_NUMERO" 	OF oCNR2 ALIAS "CN9"
		DEFINE CELL NAME "CN9_REVISA" 	OF oCNR2 ALIAS "CN9"
		DEFINE CELL NAME "CND_NUMMED" 	OF oCNR2 ALIAS "CND"
		DEFINE CELL NAME "CND_DTFIM" 	OF oCNR2 ALIAS "CND"	
		DEFINE CELL NAME "CNR_VALOR" 	OF oCNR2 ALIAS "CNR"
		
		DEFINE BREAK oBreakCTRT2 OF oCNR2 WHEN  {|| (cAliasCNR)->CNR_CODIGO }
		DEFINE FUNCTION FROM oCNR2:Cell("CNR_VALOR") BREAK oBreakCTRT2 FUNCTION SUM NO END SECTION NO END REPORT	
		
oReport:PrintDialog()
Return

//-------------------------------------------------------------------
/*{Protheus.doc} PrintReport
PrintReport

@author antenor.silva
@since 04/05/2015
@version P12.00
*/
//-------------------------------------------------------------------
Static Function PrintReport(oReport,cAliasCNR)
Local oSecCTRT  	:= oReport:Section(1)
Local oSecMuBo	:= oReport:Section(1):Section(1)
Local oSecCTRT2  	:= oReport:Section(2)
Local oSecMuBo2	:= oReport:Section(2):Section(1)
Local nOpc 		:= oSecCTRT:GetOrder()
MakeSqlExp("CNTR300")

If nOpc = 1	//Visão - por contrato
	BEGIN REPORT QUERY oSecCTRT
		
	BeginSql Alias cAliasCNR	
		
		SELECT CNR.CNR_CONTRA, CNR.CNR_NUMMED, CNR.CNR_CODIGO, CNR.CNR_TIPO, CNR.CNR_DESCRI, CNR.CNR_VALOR,
				CN9.CN9_NUMERO,CN9.CN9_REVISA, CN4.CN4_CODIGO, CN4.CN4_DESCRI, CND.CND_DTFIM, CND.CND_REVISA, CND.CND_NUMMED
				
		FROM  %Table:CNR% CNR
			INNER JOIN  %Table:CN9% CN9 ON CN9.CN9_FILIAL =  %xFilial:CNR%  AND CN9.CN9_NUMERO = CNR.CNR_CONTRA
			INNER JOIN  %Table:CND% CND ON CND.CND_FILIAL =  %xFilial:CNR%  AND CND.CND_CONTRA = CNR.CNR_CONTRA AND CND.CND_NUMMED = CNR.CNR_NUMMED AND CND.CND_REVISA = CN9.CN9_REVISA
			LEFT JOIN  %Table:CN4% CN4  ON CN4.CN4_FILIAL =  %xFilial:CNR%  AND CN4.CN4_CODIGO = CNR.CNR_CODIGO
			LEFT JOIN  %Table:CNA% CNA ON CNA.CNA_FILIAL =  %xFilial:CNR%  AND CNA.CNA_CONTRA = CNR.CNR_CONTRA AND CNA.CNA_REVISA = CN9.CN9_REVISA
		
		WHERE CNR.%notDel% AND CN9.CN9_REVATU = '' AND CND.%notDel% AND CN9.%notDel%
		
		ORDER BY CNR.CNR_CONTRA, CN9.CN9_REVISA, CNR.CNR_TIPO, CNR.CNR_CODIGO, CNR.CNR_NUMMED 
		
	EndSql
	
	END REPORT QUERY oSecCTRT PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05, MV_PAR06
	
	oSecMuBo:SetParentQuery()
	oSecMuBo:SetParentFilter({|cParam| (cAliasCNR)->CNR_CONTRA+(cAliasCNR)->CND_REVISA == cParam}, {|| (cAliasCNR)->CN9_NUMERO+(cAliasCNR)->CN9_REVISA})
	
	oSecCTRT:print()
	
	(cAliasCNR)->(dbCloseArea())
	
Else // Visão - por Multa/bonificação

	BEGIN REPORT QUERY oSecCTRT2
		
	BeginSql Alias cAliasCNR	
		
		SELECT CNR.CNR_CONTRA, CNR.CNR_NUMMED, CNR.CNR_CODIGO, CNR.CNR_TIPO, CNR.CNR_DESCRI, CNR.CNR_VALOR,
				CN9.CN9_NUMERO,CN9.CN9_REVISA, CN4.CN4_CODIGO, CN4.CN4_DESCRI, CND.CND_DTFIM, CND.CND_REVISA, CND.CND_NUMMED
				
		FROM  %Table:CNR% CNR
			INNER JOIN  %Table:CN9% CN9 ON CN9.CN9_FILIAL =  %xFilial:CNR%  AND CN9.CN9_NUMERO = CNR.CNR_CONTRA
			INNER JOIN  %Table:CND% CND ON CND.CND_FILIAL =  %xFilial:CNR%  AND CND.CND_CONTRA = CNR.CNR_CONTRA AND CND.CND_NUMMED = CNR.CNR_NUMMED AND CND.CND_REVISA = CN9.CN9_REVISA
			LEFT JOIN  %Table:CN4% CN4 ON CN4.CN4_FILIAL =  %xFilial:CNR%  AND CN4.CN4_CODIGO = CNR.CNR_CODIGO
			LEFT JOIN  %Table:CNA% CNA ON CNA.CNA_FILIAL =  %xFilial:CNR%  AND CNA.CNA_CONTRA = CNR.CNR_CONTRA AND CNA.CNA_REVISA = CN9.CN9_REVISA
			
		WHERE CNR.%notDel% AND CN9.CN9_REVATU = '' AND CND.%notDel% AND CN9.%notDel%
		
		ORDER BY CNR.CNR_TIPO, CNR.CNR_CODIGO, CNR.CNR_CONTRA, CN9.CN9_REVISA, CNR.CNR_NUMMED
			
	EndSql
	
	END REPORT QUERY oSecCTRT2 PARAM MV_PAR01, MV_PAR02, MV_PAR03, MV_PAR04, MV_PAR05, MV_PAR06
	
	oSecMuBo2:SetParentQuery()
	oSecMuBo2:SetParentFilter({|cParam| (cAliasCNR)->CNR_CODIGO == cParam}, {|| (cAliasCNR)->CN4_CODIGO})
	
	oSecCTRT2:print()
	
	(cAliasCNR)->(dbCloseArea())

EndIf		
	
Return