/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "rwmake.ch"  
#include "wmsr450.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} novo
Montagem da tela de processamento

@author    Tiago Filipe
@version   P12
@since     22/08/2013
/*/
//------------------------------------------------------------------------------------------
User Function WMSR451()
Local oReport
	If !SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR450()
	EndIf	
	oReport:= ReportDef()
	oReport:PrintDialog()
Return
//------------------------------------------------------------
//  Definições do relatório
//------------------------------------------------------------
Static Function ReportDef()
Local cTitle := OemToAnsi(STR0001) // Giro do PROD
Local cQryRel := GetNextAlias()
Local oReport 
Local oSection1
	
	// Criacao do componente de impressao
	oReport := TReport():New('WMSR451',cTitle,'WMSR451',{|oReport| ReportPrint(oReport,cQryRel)},STR0001) // Giro do PROD
	
	Pergunte(oReport:uParam,.F.)
	
	// Criacao da secao utilizada pelo relatorio
	oSection1:= TRSection():New(oReport,STR0010,{"D13"},/*aOrdem*/) // Relatorio Giro do PROD'
	
	TRCell():New(oSection1,"D13_LOCAL"   ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Armazem
	TRCell():New(oSection1,"D13_PRODUT"  ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // PROD
	TRCell():New(oSection1,"DESC"        ,""   ,STR0005   ,/*Picture*/,TamSx3("B1_DESC")[1],/*lPixel*/,{||Posicione("SB1",1,xFilial("SB1")+(cQryRel)->D13_PRODUT,"B1_DESC")}  )  // Descrição
	TRCell():New(oSection1,"D13_ENDER"   ,"D13",/*Titulo*/,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Endereço
	TRCell():New(oSection1,"ENTRADAS"    ,"D13",STR0007   ,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Entrada
	TRCell():New(oSection1,"MOV_ENTRADAS","D13",STR0008   ,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Movimentos
	TRCell():New(oSection1,"SAIDAS"      ,"D13",STR0009   ,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Saida
	TRCell():New(oSection1,"MOV_SAIDAS"  ,"D13",STR0008   ,/*Picture*/,/*Tamanho*/         ,/*lPixel*/,/*{|| code-block de impressao }*/) // Movimentos

Return(oReport)
//-----------------------------------------------------------
// Impressão do relatório
//-----------------------------------------------------------
Static Function ReportPrint(oReport,cQryRel)
Local oSection1 := oReport:Section(1)
Local cSameProd := ""
  
	// Transforma parametros Range em expressao SQL
	MakeSqlExpr(oReport:GetParam())
	
	If MV_PAR11 == 1
		cOrderBy := "%ORDER BY D13_PRODUT, ENTRADAS%"
	ElseIf MV_PAR11 == 2
		cOrderBy := "%ORDER BY D13_PRODUT, MOV_ENTRADAS%"
	ElseIf MV_PAR11 == 3
		cOrderBy := "%ORDER BY D13_PRODUT, SAIDAS%"
	ElseIf MV_PAR11 == 4
		cOrderBy := "%ORDER BY D13_PRODUT, MOV_SAIDAS%"
	EndIf
	
	// Query do relatorio
	oSection1:BeginQuery()
	BeginSql Alias cQryRel
		SELECT D13.D13_LOCAL, 
		       D13.D13_PRODUT, 
		       D13.D13_ENDER,
		       SUM(CASE WHEN D13.D13_TM = '499' THEN D13.D13_QTDEST ELSE 0 END) AS ENTRADAS,
		       SUM(CASE WHEN D13.D13_TM = '499' THEN 1 ELSE 0 END) MOV_ENTRADAS,
		       SUM(CASE WHEN D13.D13_TM = '999' THEN D13.D13_QTDEST ELSE 0 END) AS SAIDAS,
		       SUM(CASE WHEN D13.D13_TM = '999' THEN 1 ELSE 0 END) MOV_SAIDAS
		  FROM %table:D13% D13 
		 INNER JOIN %table:SBE% SBE
		    ON SBE.BE_LOCAL   = D13.D13_LOCAL
		   AND SBE.BE_LOCALIZ = D13.D13_ENDER
		   AND SBE.BE_FILIAL  = %xFilial:SBE%
		   AND SBE.%NotDel%
		 WHERE D13.D13_FILIAL = %xFilial:D13% 
		   AND D13.%NotDel%
		   AND D13.D13_LOCAL  <> ''
		   AND D13.D13_ENDER  <> ''
		   AND D13.D13_PRODUT BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
		   AND D13.D13_ENDER  BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
		   AND D13.D13_LOCAL  BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
		   AND SBE.BE_ESTFIS  BETWEEN %Exp:MV_PAR07% AND %Exp:MV_PAR08%
		   AND D13.D13_DTESTO BETWEEN %Exp:MV_PAR09% AND %Exp:MV_PAR10%
		 GROUP BY D13.D13_LOCAL, D13.D13_PRODUT, D13.D13_ENDER
		 UNION
		SELECT 'TOTAL' AS D13_LOCAL, 
		       D13.D13_PRODUT AS PRODUTO, 
		       '' AS D13_ENDER, 
		       SUM(CASE WHEN D13.D13_TM = '499' THEN D13.D13_QTDEST ELSE 0 END) AS ENTRADAS,
		       SUM(CASE WHEN D13.D13_TM = '499' THEN 1 ELSE 0 END) MOV_ENTRADAS,
		       SUM(CASE WHEN D13.D13_TM = '999' THEN D13.D13_QTDEST ELSE 0 END) AS SAIDAS,
		       SUM(CASE WHEN D13.D13_TM = '999' THEN 1 ELSE 0 END) MOV_SAIDAS
		  FROM %table:D13% D13 
		 INNER JOIN %table:SBE% SBE
		    ON SBE.BE_LOCAL   = D13.D13_LOCAL
		   AND SBE.BE_LOCALIZ = D13.D13_ENDER
		   AND SBE.BE_FILIAL  = %xFilial:SBE%
		   AND SBE.%NotDel%
		 WHERE D13.D13_FILIAL = %xFilial:D13% 
		   AND D13.%NotDel%
		   AND D13.D13_LOCAL  <> ''
		   AND D13.D13_ENDER  <> ''
		   AND D13.D13_PRODUT BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
		   AND D13.D13_ENDER  BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
		   AND D13.D13_LOCAL  BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
		   AND SBE.BE_ESTFIS  BETWEEN %Exp:MV_PAR07% AND %Exp:MV_PAR08%
		   AND D13.D13_DTESTO BETWEEN %Exp:MV_PAR09% AND %Exp:MV_PAR10%
		 GROUP BY D13.D13_PRODUT
		 %Exp:cOrderBy%
	EndSql
	oSection1:EndQuery()
	
	oReport:SetMeter((cQryRel)->(RecCount()))
	
	oSection1:Init()
	
	While !oReport:Cancel() .And. !(cQryRel)->(Eof())
		
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oSection1:Cell("D13_LOCAL"):Hide()
		oSection1:Cell("D13_PRODUT"):Hide()
		oSection1:Cell("DESC"):Hide()
		
		If cSameProd != (cQryRel)->(D13_PRODUT)
			cSameProd := (cQryRel)->(D13_PRODUT)
			oSection1:Cell("D13_LOCAL"):Show()
			oSection1:Cell("D13_PRODUT"):Show()
			oSection1:Cell("DESC"):Show()
		EndIf

		If (cQryRel)->(D13_LOCAL) == "TOTAL"
			oSection1:Cell("D13_LOCAL"):Hide()
			oSection1:Cell("D13_PRODUT"):Hide()
			oSection1:Cell("DESC"):Hide()
		EndIf
		
		oSection1:Cell("D13_ENDER"):Show()
		oSection1:Cell("ENTRADAS"):Show()
		oSection1:Cell("ENTRADAS"):SetAlign("LEFT")
		oSection1:Cell("MOV_ENTRADAS"):Show()
		oSection1:Cell("MOV_ENTRADAS"):SetAlign("LEFT")
		oSection1:Cell("SAIDAS"):Show()
		oSection1:Cell("SAIDAS"):SetAlign("LEFT")
		oSection1:Cell("MOV_SAIDAS"):Show()
		oSection1:Cell("MOV_SAIDAS"):SetAlign("LEFT")
		
		If (cQryRel)->(D13_LOCAL) == "TOTAL"
			oReport:PrintText(STR0002) // Total do Poduto
		EndIf
		
		oSection1:PrintLine()
		
		If (cQryRel)->(D13_LOCAL) == "TOTAL"
			oReport:FatLine()
			oReport:SkipLine()
		EndIf
		
		(cQryRel)->(DbSkip())
	EndDo
	
	oSection1:Finish()
	oReport:EndPage()

	(cQryRel)->(DbCloseArea())
Return