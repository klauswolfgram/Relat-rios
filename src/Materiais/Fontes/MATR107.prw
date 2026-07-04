/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include 'Protheus.ch'
#Include 'report.ch'
#Include 'Matr107.ch'
 
//-------------------------------------------------------------------
/*{Protheus.doc} MATR107
Termo de retirada de material

@author antenor.silva
@since 23/02/2015
@version P12.00
*/
//-------------------------------------------------------------------
User Function MATR107()
Local oReport
Local oBreakSol
Local oBreakNum
Local oSCP
Local oSOL

Pergunte("MATR107",.F.)

DEFINE REPORT oReport NAME STR0001 TITLE STR0001 PARAMETER "MATR107" ACTION {|oReport| PrintReport(oReport,)}

	DEFINE SECTION oSOL OF oReport TITLE STR0003 TABLES "SCP"

	DEFINE SECTION oSCP OF oSOL TITLE STR0003 TABLES "SCP" BREAK HEADER

		DEFINE CELL NAME "CP_NUM" 		OF oSCP ALIAS "SCP"
		DEFINE CELL NAME "CP_ITEM" 		OF oSCP ALIAS "SCP"
		DEFINE CELL NAME "CP_EMISSAO" 	OF oSCP ALIAS "SCP"
		DEFINE CELL NAME "CP_SOLICIT" 	OF oSCP ALIAS "SCP"	
		
		DEFINE CELL NAME "CP_PRODUTO" 	OF oSCP ALIAS "SCP"
		DEFINE CELL NAME "CP_QUJE" 		OF oSCP ALIAS "SCP"
		DEFINE CELL NAME "Status SA" 	OF oSCP ALIAS "SCP"   SIZE 25

		DEFINE BREAK oBreakSol OF oSCP WHEN oSCP:Cell("CP_SOLICIT") PAGE BREAK
		DEFINE BREAK oBreakNum OF oSCP WHEN oSCP:Cell("CP_NUM")

oReport:PrintDialog()
Return

//-------------------------------------------------------------------
/*{Protheus.doc} PrintReport
PrintReport

@author antenor.silva
@since 23/02/2015
@version P12.00
*/
//-------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local cAliasSCP 	:= GetNextAlias()
	Local oSection  	:= oReport:Section(1)
	Local oSection1		:= oReport:Section(1):Section(1)
	Local cSolic		:= ""
	Local cWhere		:= ""
	
	MakeSqlExpr("MATR107")

	If !Empty(mv_par01)
		cWhere+= mv_par01 +" AND "
	EndIf
	
	If !Empty(mv_par04)
		cWhere+= " SCP.CP_SOLICIT = '" +UsrRetName(mv_par04) + "' AND "
	EndIf
	
	cWhere:= "%" +cWhere +"%"

	BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias cAliasSCP
		SELECT CP_NUM,CP_SOLICIT,CP_EMISSAO,CP_PREREQU,CP_QUJE,
				SCP.CP_ITEM,SCP.CP_PRODUTO,SCP.CP_QUANT,SCP.CP_QUJE,
				SCP.R_E_C_N_O_ RECNOSCP, SCP.CP_STATUS
		FROM %Table:SCP% SCP
		WHERE SCP.%NotDel% AND
			SCP.CP_FILIAL = %xFilial:SCP% AND
			%Exp:cWhere%	
			SCP.CP_EMISSAO BETWEEN %Exp:DtoS(mv_par02)% AND %Exp:DtoS(mv_par03)%
		ORDER BY SCP.CP_SOLICIT, SCP.CP_NUM
	EndSql

	END REPORT QUERY oReport:Section(1) PARAM mv_par01

	oSection1:SetParentQuery()
	oSection1:SetParentFilter({|cParam| (cAliasSCP)->CP_SOLICIT == cParam},{|| (cAliasSCP)->CP_SOLICIT})

	If !oReport:Cancel() .And. !(cAliasSCP)->(EOF())
		oSection:Init()
		oSection:PrintLine()
		While !oReport:Cancel() .And. !(cAliasSCP)->(EOF())
			cSolic	:= (cAliasSCP)->CP_SOLICIT	
			oSection1:Init()
			oReport:SkipLine(2)
			oReport:PrintText(STR0004 + Replicate('_',50) + STR0005 + Replicate('_',20))
			oReport:PrintText(STR0006)
			oReport:SkipLine(2)
			While (cAliasSCP)->CP_SOLICIT == cSolic .And. !(cAliasSCP)->(EOF())
				SCP->(dbgoto((cAliasSCP)->RECNOSCP))      //posiciona para caso personalize campos no relatorio
				aStatus:= U_ScPStatus(cAliasSCP)
				If Len(aStatus)> 0
					IF MV_PAR05 == aStatus[1][2] .Or. MV_PAR05 == 1
						oSection1:Cell("Status SA"):SetBlock({|| aStatus[1][1]	})
						oSection1:PrintLine()
						oReport:IncMeter()
						aStatus:= {}
						(cAliasSCP)->(dbSkip())
					Else
						aStatus:= {} 
						(cAliasSCP)->(dbSkip())
						
					EndIf
				Else
					oSection1:PrintLine()
					oReport:IncMeter()
					(cAliasSCP)->(dbSkip())
				EndIf
		   	EndDo
			oReport:SkipLine(5)
			oReport:PrintText( RTRIM(SM0->M0_CIDENT) +", "+ cValToChar(Day(dDataBase)) +' '+STR0007+' '+ MesExtenso(dDataBase) +' '+STR0007+' '+cValToChar(Year(dDataBase)) )
		
			oReport:SkipLine(15)
			oReport:PrintText(Replicate('_',50))
			oReport:PrintText(STR0008)
		
			oReport:SkipLine(10)
			oReport:PrintText(Replicate('_',50))
			oReport:PrintText(STR0009)
			oSection1:Finish()
		EndDo		
		oSection:Finish()
	EndIf
	(cAliasSCP)->(dbCloseArea())

Return

/*/{Protheus.doc} ScPStatus
Retorna o Status da SA
@author Andre.Maximo
@since 27/04/2016
@version 1.0
@param aLiasSCP - Query SCP
/*/

User Function ScPStatus(aLiasSCP)

Local cRetorno := ""
Local aRetCod  := {}

If !Empty((aLiasSCP)->CP_STATUS) .And. (aLiasSCP)->CP_PREREQU == "S" .And. (QtdComp((aLiasSCP)->CP_QUANT) == QtdComp((aLiasSCP)->CP_QUJE))
	cRetorno := STR0010 //"Pré. Req. Baix/Ence"
	nCod:= 2
ElseIf Empty((aLiasSCP)->CP_STATUS) .And. (aLiasSCP)->CP_PREREQU == "S" .And. QtdComp((aLiasSCP)->CP_QUJE) == QtdComp(0)
	cRetorno := STR0011 //"Baixar Pré Req"
	nCod := 3
ElseIf Empty((aLiasSCP)->CP_STATUS) .And. Empty((aLiasSCP)->CP_PREREQU)
	cRetorno := STR0012 //"Gerar Pré Req"
	nCod := 4
ElseIf !Empty((aLiasSCP)->CP_STATUS) .And. (aLiasSCP)->CP_PREREQU == "S" .And. (QtdComp((aLiasSCP)->CP_QUANT) > QtdComp((aLiasSCP)->CP_QUJE))
	cRetorno := STR0010 //"Pré Req Baix/Ence"
	nCod := 2
ElseIf Empty((aLiasSCP)->CP_STATUS) .And. (aLiasSCP)->CP_PREREQU == "S" .And. QtdComp((aLiasSCP)->CP_QUJE) > QtdComp(0)
	cRetorno := STR0013 //"Parc. Baixada"
	nCod := 5
EndIf

If !Empty(cRetorno) .And. !Empty(nCod)
	Aadd(aRetCod,{cRetorno, nCod})
EndIF


Return aRetCod            
