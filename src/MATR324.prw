/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "report.ch"

User Function matr324()
Local oReport
Local oDH0

Pergunte("MTR324",.F.)

DEFINE REPORT oReport NAME "matr324" TITLE "Documento de Entrada"  PARAMETER "MTR324" ACTION {|oReport| PrintReport(oReport)}

	DEFINE SECTION oDH0 OF oReport TITLE "Documento de Entradas" TABLES "DH0" 

	DEFINE CELL NAME "DH0_DOC" 		OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_SERIE" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_ITEM" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_FORNEC" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_LOJA" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_NUMSEQ" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_DATA" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_QUANT" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_CUSTO" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_VALICM" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_VALIPI" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_VALPIS" 	OF oDH0 ALIAS "DH0"
	DEFINE CELL NAME "DH0_VALCOF" 	OF oDH0 ALIAS "DH0"
	oReport:PrintDialog()
Return

Static Function PrintReport(oReport)
Local cAlias 	:= GetNextAlias()
Local cWhere	:= ""

If !Empty(mv_par01)
	cWhere	:= " AND DH0_DATA BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "' "
EndIf

cWhere	:= "%" + cWhere + "%"

BEGIN REPORT QUERY oReport:Section(1)
BeginSql alias cAlias
	SELECT *
	FROM %Table:DH0% DH0 
	WHERE DH0.%NotDel%
	%Exp:cWhere%
	ORDER BY DH0_DOC,DH0_SERIE
EndSql
END REPORT QUERY oReport:Section(1)

oReport:Section(1):Print()
Return