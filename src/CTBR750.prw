/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#include "report.ch"
#INCLUDE "CTBR750.CH"

/*/{Protheus.doc} CTBR750
Relatório de movimentos de apuração contábil.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
User Function CTBR750()
	//MV_PAR01 - Apuração de?
	//MV_PAR02 - Apuração até?
	//MV_PAR03 - Tipo de Saldo.
	//MV_PAR04 - Tipo de Relatório.
	//MV_PAR05 - Data Inicial
	//MV_PAR06 - Data Final
	//MV_PAR07 - Contabilizado
	//MV_PAR08 - Método POC
	//MV_PAR09 - Seleciona Filial
	//MV_PAR10 - Total por Apuração
	//MV_PAR11 - Total por Filial
	Local oReport
	Local lTReport	:= TRepInUse()
	Local cPergunte	:= "CTBR750"
	Local aFilial	:= {}
	Private nRecAuf	:= 0
	Private nCustRec:= 0
	Private nFat	:= 0
	Private nLucro	:= 0
	Private nPrej	:= 0
	Private nCtbPos := 0
	Private nCtbNeg := 0
	
	If Pergunte( cPergunte )
		If !lTReport
			Help("  ",1,"FINR677R4",,,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
			Return
		EndIf
		If MV_PAR09 == 1 //Sim
			aFilial := AdmGetFil()
		EndIf
		oReport:= ReportDef(aFilial)
		oReport:PrintDialog()
	EndIf
	
Return

/*/{Protheus.doc} CTBR750
Definição Layout do Relatório.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
Static Function ReportDef(aFilial)
	Local oReport	:= Nil
	Local cReport	:= "CTBR750"
	Local cAliasMov	:= GetNextAlias()
	Local cDescri	:= ''
	Local oCQE		:= Nil
	Local oCQF		:= Nil
	Local oCQI		:= Nil
	Local oResTot	:= Nil
	Local oResFil	:= Nil
	
	DEFINE REPORT oReport NAME cReport TITLE STR0009 ACTION {|oReport| PrintReport(oReport,cAliasMov,aFilial)} DESCRIPTION cDescri
	DEFINE SECTION oCQE OF oReport TABLES "CQE" //"Cabeçalho."
	
	oCQE:SetLineStyle()
	oCQE:SetCols(4)
	oCQE:SetAutoSize()
	//Cabeçalho.
	DEFINE CELL NAME "CQE_FILIAL"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_FILIAL")[1]
	DEFINE CELL NAME "CQE_CODAPU"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_CODAPU")[1]
	DEFINE CELL NAME "CQE_CODCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_CODCON")[1]
	DEFINE CELL NAME "CQE_DESCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_DESCON")[1]

	oCQE:Cell('CQE_DESCON'):SetCellBreak() // Quebra de linha
	
	//Tipos de Saldo.
	DEFINE SECTION oCQF OF oCQE TABLES "CQF"
	oCQF:SetCols(2)
	DEFINE CELL NAME "CQF_TPSALD"  	OF oCQF ALIAS "CQF" SIZE TamSX3("CQF_TPSALD")[1]
	DEFINE CELL NAME "CQF_METPOC"  	OF oCQF ALIAS "CQF" SIZE TamSX3("CQF_METPOC")[1]
	
	If MV_PAR04 == 1 //Analitico 
		//Movimentos.
		DEFINE SECTION oCQI OF oCQF TABLES "CQI"
		oCQI:SetCols(6)
		oCQI:SetAutoSize()
		DEFINE CELL NAME "CQI_DTMOV"	OF oCQI ALIAS "CQI" SIZE TamSX3("CQI_DTMOV")[1]
		DEFINE CELL NAME "CQI_OCOR"  	OF oCQI ALIAS "CQI" SIZE TamSX3("CQI_OCOR")	[1]
		DEFINE CELL NAME "CQI_VALOR"  	OF oCQI ALIAS "CQI" SIZE TamSX3("CQI_VALOR")[1]
		DEFINE CELL NAME "CQI_DTCTB"  	OF oCQI ALIAS "CQI" SIZE TamSX3("CQI_DTCTB")[1]
		//		
		oCQI:OnPrintLine( {|| U_CBR750Total(cAliasMov) })
	Else

		DEFINE SECTION oResTot OF oReport TABLE "CQI" TITLE STR0001
		oResTot:SetCols(1) //"Quantidade de colunas" 
		oResTot:SetAutoSize()		
	   	DEFINE CELL NAME "RESMOED1" OF oResTot SIZE 20 TITLE STR0007
		DEFINE CELL NAME "RECAUF" 	OF oResTot SIZE 20 TITLE STR0002 BLOCK {|| nRecAuf}	
		DEFINE CELL NAME "CUSTREC" 	OF oResTot SIZE 20 TITLE STR0003 BLOCK {|| nCustRec}	
		DEFINE CELL NAME "FATPER" 	OF oResTot SIZE 20 TITLE STR0004 BLOCK {|| nFat}	
		DEFINE CELL NAME "LUCRO" 	OF oResTot SIZE 20 TITLE STR0005 BLOCK {|| nLucro}	
		DEFINE CELL NAME "PREJ" 	OF oResTot SIZE 20 TITLE STR0006 BLOCK {|| nPrej}	
				
	EndIf
	//Total da Apuração
	If MV_PAR10 == 1 .AND. MV_PAR04 == 1
		DEFINE SECTION oResTot OF oReport TABLE "CQI" TITLE STR0007
		oResTot:SetCols(1) //"Quantidade de colunas" 
		oResTot:SetAutoSize()
	   	DEFINE CELL NAME "RESMOED1" OF oResTot SIZE 20 TITLE STR0007
		DEFINE CELL NAME "RECAUF" 	OF oResTot SIZE 20 TITLE STR0002 BLOCK {|| nRecAuf}	
		DEFINE CELL NAME "CUSTREC" 	OF oResTot SIZE 20 TITLE STR0003 BLOCK {|| nCustRec}	
		DEFINE CELL NAME "FATPER" 	OF oResTot SIZE 20 TITLE STR0004 BLOCK {|| nFat}	
		DEFINE CELL NAME "LUCRO" 	OF oResTot SIZE 20 TITLE STR0005 BLOCK {|| nLucro}	
		DEFINE CELL NAME "PREJ" 	OF oResTot SIZE 20 TITLE STR0006 BLOCK {|| nPrej}	
	EndIf
	//Total da Filial
	If MV_PAR11 == 1
		DEFINE SECTION oResFil OF oReport TABLE "CQI" TITLE STR0008
		oResFil:SetCols(1) //"Quantidade de colunas" 
		oResFil:SetAutoSize()
		DEFINE CELL NAME "RESMOED1" OF oResFil SIZE 20 TITLE STR0008	
		DEFINE CELL NAME "RECAUF" 	OF oResFil SIZE 20 TITLE STR0002 BLOCK {|| nRecAuf}	
		DEFINE CELL NAME "CUSTREC" 	OF oResFil SIZE 20 TITLE STR0003 BLOCK {|| nCustRec}	
		DEFINE CELL NAME "FATPER" 	OF oResFil SIZE 20 TITLE STR0004 BLOCK {|| nFat}	
		DEFINE CELL NAME "LUCRO" 	OF oResFil SIZE 20 TITLE STR0005 BLOCK {|| nLucro}	
		DEFINE CELL NAME "PREJ" 	OF oResFil SIZE 20 TITLE STR0006 BLOCK {|| nPrej}					
	EndIf
	//
Return oReport

/*/{Protheus.doc} PrintReport
Impressão dos dados.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
Static Function PrintReport(oReport,cAliasMov,aFilial)
	Local oCQE := oReport:Section(1)
	Local oCQF := oReport:Section(1):Section(1)
	Local oCQI := oReport:Section(1):Section(1):Section(1)
	Local oResTot := oReport:Section(2)
	Local oResFil := oReport:Section(3)
	Local cFiltro := ""
	Local cAux	  := ""
	Local nX 		:= 0	
	
	//Contabilizado
	If MV_PAR07 == 1
		cFiltro += "%CQG_STATUS = '2'"
	Else
		cFiltro += "%CQG_STATUS = '1'"		
	EndIf
	//Filiais selecionadas.
	If !Empty(aFilial)
		For nX := 1 To Len(aFilial)
			cAux += "'" + aFilial[nX] + "',"
		Next nX
		cAux := " AND CQE_FILIAL IN(" + Substr(cAux,1, Len(cAux) - 1 ) + ") %"
	Else
		cAux := " AND CQE_FILIAL = '" + cFilAnt + "'%"
	EndIf
	cFiltro += cAux
	//	
	BEGIN REPORT QUERY oCQE
		BeginSql alias cAliasMov
			SELECT DISTINCT CQE_FILIAL,
			CQF_FILIAL,
			CQI_FILIAL,
			CQF_CODAPU,
			CQE_CODAPU,
			CQE_CODCON,
			CQE_DESCON,
			CQE_INICON,
			CQE_RECCON,
			CQE_FIMCON,
			CQF_ITESAL,
			CQF_TPSALD,
			CQF_METPOC,
			CQI_DTMOV,
			CQI_OCOR,
			CQI_VALOR,
			CQI_DTCTB,
			CQI_CODAPU
			
			FROM %table:CQE% CQE
			
			INNER JOIN %table:CQF% CQF  ON CQE_FILIAL = CQF_FILIAL AND CQE_CODAPU = CQF_CODAPU
			INNER JOIN %table:CQG% CQG  ON CQF_FILIAL = CQG_FILIAL AND CQF_CODAPU = CQG_CODAPU
			INNER JOIN %table:CQI% CQI  ON CQI_FILIAL = CQG_FILIAL AND CQI_CODAPU = CQG_CODAPU AND CQI_ITESAL = CQG_ITESAL AND CQI_ITEPER = CQG_ITEPER
			WHERE
				%Exp:cFiltro% AND
				CQE_CODAPU >= %Exp:MV_PAR01% AND
				CQE_CODAPU <= %Exp:MV_PAR02% AND
				CQF_TPSALD =  %Exp:MV_PAR03% AND
				CQG_INIPER >= %Exp:MV_PAR05% AND
				CQG_FIMPER <= %Exp:MV_PAR06% AND
				CQF_METPOC =  %Exp:cValToChar(MV_PAR08)% AND
				CQE.%notDel% AND
				CQF.%notDel% AND
				CQG.%notDel% AND
				CQI.%notDel% 
			
		EndSql
		
	END REPORT QUERY oCQE
	
	oCQF:SetParentQuery()
	oCQF:SetParentFilter({|cParam| (cAliasMov)->(CQF_FILIAL+CQF_CODAPU) == cParam},{|| (cAliasMov)->(CQE_FILIAL+CQE_CODAPU) })
	//
	If MV_PAR04 == 1
		oCQI:SetParentQuery()
		oCQI:SetParentFilter({|cParam| (cAliasMov)->(CQI_FILIAL+CQI_CODAPU) == cParam},{|| (cAliasMov)->(CQE_FILIAL+CQE_CODAPU) })
	EndIf
	//
	TRPosition():New(oCQE, "CQE", 1, {|| xFilial("CQE") + (cAliasMov)->(CQE_CODAPU) }) //A2_FILIAL+A2_COD+A2_LOJA 
	//
	oCQE:Print()
	
	If ValType(oResTot) == "O" //Regra para criar o objeto no ReportDef: MV_PAR10 == 1 .AND. MV_PAR04 == 1
		oResTot:init()
		oResTot:PrintLine()
		oResTot:finish()
	EndIf

	If ValType(oResFil) == "O" //Regra para criar o objeto no ReportDef: MV_PAR11 == 1
		oResFil:init()
		oResFil:PrintLine()
		oResFil:finish()
	EndIf
Return

User Function CBR750Total(cAliasMov)
Local cOcor :=  (cAliasMov)->CQI_OCOR

Do Case
	
	Case cOcor == '01' //Receita Auferida
		nRecAuf := (cAliasMov)->CQI_VALOR
	Case cOcor == '02' //Custo da Receitaadmin
		nCustRec := (cAliasMov)->CQI_VALOR
	Case cOcor == '03' //Faturamento
		nFat := (cAliasMov)->CQI_VALOR
	Case cOcor == '04' //Lucro Auferido
		nLucro := (cAliasMov)->CQI_VALOR
	Case cOcor == '05' //Prejuizo Auferido
		nPrej := (cAliasMov)->CQI_VALOR
	Case cOcor == '06' //Ajuste Contabil - Positivo
		nCtbPos := (cAliasMov)->CQI_VALOR
	Case cOcor == '07' //Ajuste Contabil - Negativo
		nCtbNeg := (cAliasMov)->CQI_VALOR
EndCase

Return 