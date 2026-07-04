/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE 'Protheus.ch'
#INCLUDE "report.ch"
#INCLUDE "CTBR750.CH"

/*/{Protheus.doc} CTBR751
Relatório cadastros de apuração contábil.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
User Function CTBR751()
	//MV_PAR01 - Apuração de?
	//MV_PAR02 - Apuração até?
	//MV_PAR03 - Tipo de Saldo.
	//MV_PAR04 - Data Inicial
	//MV_PAR05 - Data Final
	//MV_PAR06 - Periodo Efetivado?
	//MV_PAR07 - Método POC?
	//MV_PAR08 - Seleciona Filial
	Local oReport
	Local lTReport	:= TRepInUse()
	Local cPergunte	:= "CTBR751"
	Local aFilial	:= {}
	
	If Pergunte( cPergunte )
		If !lTReport
			Help("  ",1,"FINR677R4",,,1,0) //"Função disponível apenas para TReport, por favor atualiçzar ambiente e verificar parametro MV_TREPORT"
			Return
		EndIf
		If MV_PAR08 == 1 //Sim
			aFilial := AdmGetFil()
		EndIf
		oReport:= ReportDef(aFilial)
		oReport:PrintDialog()
	EndIf
	
Return

/*/{Protheus.doc} ReportDef
Definição Layout do Relatório.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
Static Function ReportDef(aFilial)
	Local oReport	:= Nil
	Local cReport	:= "CTBR751"
	Local cAliasCad	:= GetNextAlias()
	Local cDescri	:= ''
	Local oCQE		:= Nil
	Local oCQF		:= Nil
	Local oCQG		:= Nil
	Local oCQH		:= Nil
	
	DEFINE REPORT oReport NAME cReport TITLE STR0010 ACTION {|oReport| PrintReport(oReport,cAliasCad,aFilial)} DESCRIPTION cDescri
	DEFINE SECTION oCQE OF oReport TABLES "CQE" //"Cabeçalho."
	
	oCQE:SetLineStyle()
	oCQE:SetCols(7)
	//Cabeçalho.
	DEFINE CELL NAME "CQE_FILIAL"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_FILIAL")[1]
	DEFINE CELL NAME "CQE_CODAPU"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_CODAPU")[1]
	DEFINE CELL NAME "CQE_CODCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_CODCON")[1]
	DEFINE CELL NAME "CQE_DESCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_DESCON")[1]
	DEFINE CELL NAME "CQE_INICON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_INICON")[1]
	DEFINE CELL NAME "CQE_RECCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_RECCON")[1]
	DEFINE CELL NAME "CQE_FIMCON"	OF oCQE ALIAS "CQE" SIZE TamSX3("CQE_FIMCON")[1]
	
	oCQE:Cell('CQE_FIMCON'):SetCellBreak() // Quebra de linha
	
	//Tipos de Saldo.
	DEFINE SECTION oCQF OF oCQE TABLES "CQF"
	oCQF:SetCols(3)
	DEFINE CELL NAME "CQF_ITESAL"	OF oCQF ALIAS "CQF" SIZE TamSX3("CQF_ITESAL")[1]
	DEFINE CELL NAME "CQF_TPSALD"  	OF oCQF ALIAS "CQF" SIZE TamSX3("CQF_TPSALD")[1]
	DEFINE CELL NAME "CQF_METPOC"  	OF oCQF ALIAS "CQF" SIZE TamSX3("CQF_METPOC")[1]
	
	//Periodo de Apontamento.
	DEFINE SECTION oCQG OF oCQF TABLES "CQG"
	oCQG:SetCols(4)
	DEFINE CELL NAME "CQG_ITEPER"	OF oCQG ALIAS "CQG" SIZE TamSX3("CQG_ITEPER")[1]
	DEFINE CELL NAME "CQG_INIPER"  	OF oCQG ALIAS "CQG" SIZE TamSX3("CQG_INIPER")[1]
	DEFINE CELL NAME "CQG_FIMPER"  	OF oCQG ALIAS "CQG" SIZE TamSX3("CQG_FIMPER")[1]
	DEFINE CELL NAME "CQG_MARGEM"  	OF oCQG ALIAS "CQG" SIZE TamSX3("CQG_MARGEM")[1]
	//Tipos de Apontamento.
	DEFINE SECTION oCQH OF oCQG TABLES "CQH"
	oCQH:SetCols(6)
	DEFINE CELL NAME "CQH_ITEAPO"	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_ITEAPO")[1]
	DEFINE CELL NAME "CQH_TPAPON"  	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_TPAPON")[1]
	DEFINE CELL NAME "CQH_VALOR"  	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_VALOR")[1]
	DEFINE CELL NAME "CQH_PERCEN"  	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_PERCEN")[1]
	DEFINE CELL NAME "CQH_DIFPER"  	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_DIFPER")[1]
	DEFINE CELL NAME "CQH_ORIGEM"  	OF oCQH ALIAS "CQH" SIZE TamSX3("CQH_ORIGEM")[1]
	
Return oReport

/*/{Protheus.doc} PrintReport
Impressão dos dados.
@author william.gundim
@since 12/02/2015
@version 1.0
/*/
Static Function PrintReport(oReport,cAliasCad,aFilial)
	Local oCQE    := oReport:Section(1)
	Local oCQF    := oReport:Section(1):Section(1)
	Local oCQG    := oReport:Section(1):Section(1):Section(1)
	Local oCQH 	  := oReport:Section(1):Section(1):Section(1):Section(1)
	Local cFiltro := ""
	Local cAux    := ""
	Local nX	  := 0
	//Efetivado
	If MV_PAR06 == 1
		cFiltro += "%CQE_STATUS = '1'"
	Else
		cFiltro += "%CQE_STATUS <> '1'"	
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
		BeginSql alias cAliasCad
			SELECT DISTINCT CQE_FILIAL,
			CQF_FILIAL,
			CQG_FILIAL,
			CQH_FILIAL,
			CQE_CODAPU,
			CQF_CODAPU,
			CQG_CODAPU,
			CQH_CODAPU,
			CQE_CODCON,
			CQE_DESCON,
			CQE_INICON,
			CQE_RECCON,
			CQE_FIMCON,
			CQF_ITESAL,
			CQG_ITESAL,
			CQH_ITESAL,
			CQF_TPSALD,
			CQF_METPOC,
			CQG_ITEPER,
			CQH_ITEPER,
			CQG_INIPER,
			CQG_FIMPER,
			CQG_MARGEM,
			CQH_ITEAPO,
			CQH_TPAPON,
			CQH_VALOR,
			CQH_PERCEN,
			CQH_DIFPER,
			CQH_ORIGEM
			
			FROM %table:CQE% CQE
			
			INNER JOIN %table:CQF% CQF  ON CQE_FILIAL = CQF_FILIAL AND CQE_CODAPU = CQF_CODAPU
			INNER JOIN %table:CQG% CQG  ON CQF_FILIAL = CQG_FILIAL AND CQF_CODAPU = CQG_CODAPU AND CQF_ITESAL = CQG_ITESAL
			INNER JOIN %table:CQH% CQH  ON CQG_FILIAL = CQH_FILIAL AND CQG_CODAPU = CQH_CODAPU AND CQH_ITESAL = CQG_ITESAL AND CQH_ITEPER = CQG_ITEPER
			WHERE
				%Exp:cFiltro% AND
				CQE_CODAPU >= %Exp:MV_PAR01% AND
				CQE_CODAPU <= %Exp:MV_PAR02% AND
				CQF_TPSALD =  %Exp:MV_PAR03% AND
				CQG_INIPER >= %Exp:MV_PAR04% AND
				CQG_FIMPER <= %Exp:MV_PAR05% AND
				CQF_METPOC =  %Exp:MV_PAR07%   		 
		EndSql
		
	END REPORT QUERY oCQE
	
	oCQF:SetParentQuery()
	oCQF:SetParentFilter({|cParam| (cAliasCad)->(CQF_FILIAL+CQF_CODAPU) == cParam},{|| (cAliasCad)->(CQE_FILIAL+CQE_CODAPU) })
	//
	oCQG:SetParentQuery()
	oCQG:SetParentFilter({|cParam| (cAliasCad)->(CQG_FILIAL+CQG_CODAPU+CQG_ITESAL) == cParam},{|| (cAliasCad)->(CQF_FILIAL+CQF_CODAPU+CQF_ITESAL) })
	//
	oCQH:SetParentQuery()
	oCQH:SetParentFilter({|cParam| (cAliasCad)->(CQH_FILIAL+CQH_CODAPU+CQH_ITESAL+CQH_ITEPER) == cParam},{|| (cAliasCad)->(CQG_FILIAL+CQG_CODAPU+CQG_ITESAL+CQG_ITEPER) })
	//
	TRPosition():New(oCQE, "CQE", 1, {|| xFilial("CQE") + (cAliasCad)->(CQE_CODAPU) }) //A2_FILIAL+A2_COD+A2_LOJA 
	//
	oCQE:Print()
	
Return
