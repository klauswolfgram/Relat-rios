/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FINR905.CH"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tipo de Relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#DEFINE ANALITICO	       		1
#DEFINE SINTETICO	          	2


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FINR905   ºAutor  ³Alvaro Camillo Neto º Data ³  04/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de conferencia de Processo de Ajuste              º±±
±±º          ³Contas a receber                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR905()
Local oReport	:= nil

Private cTitulo	:= STR0001//"Títulos em processo de AVP"
Private cPerg	:= "FIN905"

If Pergunte(cPerg,.T.)
	oReport := ReportDef()
	oReport:PrintDialog()
Endif
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Alvaro Camillo Neto º Data ³  04/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definição do Relatorio                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR905                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport	:= nil
Local oFIN   	:= nil
Local oFIP		:= nil
Local cDesc		:= STR0003 //"Esse relatório tem o objetivo de listar os títulos a receber em processo de ajuste de valor presente, demonstrando o valor presente do titulo e suas movimentações"
Local nX		:= 0


DEFINE REPORT oReport NAME "FINR905" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| RepFR905(oReport,cPerg)} DESCRIPTION cDesc
	oReport:DisableOrientation()
	oReport:SetLandScape()
	oReport:ParamReadOnly()
	Pergunte(cPerg,.F.)
	DEFINE SECTION oFIN OF oReport TITLE STR0004 TABLES "FIN","SE1","SA1" //"Título em AVP"
		DEFINE CELL NAME "E1_PREFIXO" 	  	OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_NUM" 	  	  	OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_PARCELA" 		OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_TIPO" 			OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_CLIENTE" 		OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_LOJA" 			OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "A1_NOME" 			OF oFIN ALIAS "SA1"
		DEFINE CELL NAME "E1_EMISSAO" 		OF oFIN ALIAS "SE1"
		DEFINE CELL NAME "E1_VALOR" 		OF oFIN ALIAS "SE1"
		DEFINE CELL NAME 'FIN_DTAVP'	 	OF oFIN ALIAS "FIN"
		DEFINE CELL NAME 'FIN_SEQ'			OF oFIN ALIAS "FIN"
		DEFINE CELL NAME 'FIN_VLRAVP' 		OF oFIN ALIAS "FIN"
		DEFINE CELL NAME 'FIN_TAXAVP'		OF oFIN ALIAS "FIN"
		DEFINE CELL NAME 'FIN_PERIOD' 		OF oFIN ALIAS "FIN" SIZE 15
		DEFINE CELL NAME 'FIN_STATUS' 		OF oFIN ALIAS "FIN" SIZE 15

		oFIN:SetAutoSize()
		oFIN:SetHeaderPage(.T.)
		oFIN:SetLinesBefore(1)

		If MV_PAR01 == ANALITICO
			For nX := 1 To Len(oFIN:aCell)
				oFIN:Cell(nX):SetBorder("BOTTOM")
			Next
			DEFINE SECTION oFIP OF oFIN TITLE STR0005 TABLES "FIP" //"Movimentos de AVP"
				DEFINE CELL NAME "FIP_DTAVP"	OF oFIP ALIAS "FIP"
				DEFINE CELL NAME "FIP_PROC"		OF oFIP ALIAS "FIP"
				DEFINE CELL NAME "FIP_TIPAVP"	OF oFIP ALIAS "FIP" SIZE 15
				DEFINE CELL NAME "FIP_VLRAVP"	OF oFIP ALIAS "FIP"
				oFIP:SetAutoSize()
				oFIP:SetHeaderPage(.T.)
				oFIP:SetLinesBefore(0)
		EndIf
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RepFR905  ºAutor  ³ Alvaro Camillo Netoº Data ³  13/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Realiza a query dos dados                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR904                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RepFR905(oReport,cPerg)
Local oFIN		:= oReport:Section(1)
Local oFIP		:= Nil
Local cStatus	:= "E"
Local cAliasQry	:= ""

Pergunte(cPerg,.F.)

cAliasQry	:= GetNextAlias()

If MV_PAR01 == ANALITICO
	BEGIN REPORT QUERY oFIN
		BeginSql Alias cAliasQry
			SELECT
				FIN_FILIAL ,
				FIN_PREFIX ,
				FIN_NUM	  ,
				FIN_PARCEL ,
				FIN_TIPO   ,
				FIN_CLIENT ,
				FIN_LOJA	  ,
				FIN_SEQ	  ,
				FIN_STATUS ,
				FIP_FILIAL ,
				FIP_PREFIX ,
				FIP_NUM	  ,
				FIP_PARCEL ,
				FIP_TIPO   ,
				FIP_CLIENT ,
				FIP_LOJA	  ,
				FIP_SEQ	  ,
				FIN_DTAVP  ,
				FIN_VLRAVP ,
				FIN_TAXAVP ,
				FIN_PERIOD ,
				FIP_DTAVP  ,
				FIP_PROC   ,
				FIP_VLRAVP ,
				FIP_TIPAVP

			FROM  %table:FIN% FIN
			INNER JOIN %table:FIP% FIP  ON
				FIN_FILIAL 		= FIP_FILIAL 	AND
				FIN_PREFIX 		= FIP_PREFIX 	AND
				FIN_NUM	 		= FIP_NUM 		AND
				FIN_PARCEL 		= FIP_PARCEL 	AND
				FIN_TIPO 	 	= FIP_TIPO 		AND
				FIN_CLIENT 		= FIP_CLIENT 	AND
				FIN_LOJA		= FIP_LOJA 		AND
				FIN_SEQ	 		= FIP_SEQ		AND
				FIP_FILIAL   	= %xfilial:FIP%	AND
				FIP_STATUS		= 'E'			AND
				FIP.%NotDel%
			WHERE
				FIN_DTAVP 	>= %exp:MV_PAR02%	AND
				FIN_DTAVP 	<= %exp:MV_PAR03%	AND
				FIN_PREFIX 	>= %exp:MV_PAR04%	AND
				FIN_PREFIX 	<= %exp:MV_PAR05%	AND
				FIN_NUM 	>= %exp:MV_PAR06%	AND
				FIN_NUM 	<= %exp:MV_PAR07%	AND
				FIN_PARCEL 	>= %exp:MV_PAR08%	AND
				FIN_PARCEL 	<= %exp:MV_PAR09%	AND
				FIN_TIPO 	>= %exp:MV_PAR10%	AND
				FIN_TIPO 	<= %exp:MV_PAR11%	AND
				FIN_CLIENT 	>= %exp:MV_PAR12%	AND
				FIN_LOJA 	>= %exp:MV_PAR13%	AND
				FIN_CLIENT 	<= %exp:MV_PAR14%	AND
				FIN_LOJA 	<= %exp:MV_PAR15%	AND
				FIN_FILIAL  = %xfilial:FIN% 	AND
				FIN.%NotDel%
			ORDER BY  FIP_FILIAL,FIP_PREFIX,FIP_NUM,FIP_PARCEL,FIP_TIPO,FIP_CLIENT,FIP_LOJA,FIP_DTAVP
		EndSql
	END REPORT QUERY oFIN
Else
	BEGIN REPORT QUERY oFIN
		BeginSql Alias cAliasQry
			SELECT
				FIN_FILIAL ,
				FIN_PREFIX ,
				FIN_NUM	  ,
				FIN_PARCEL ,
				FIN_TIPO   ,
				FIN_CLIENT ,
				FIN_LOJA	  ,
				FIN_SEQ	  ,
				FIN_DTAVP  ,
				FIN_VLRAVP ,
				FIN_TAXAVP ,
				FIN_PERIOD ,
				FIN_STATUS
			FROM  %table:FIN% FIN
			WHERE
				FIN_DTAVP 	>= %exp:MV_PAR02%	AND
				FIN_DTAVP 	<= %exp:MV_PAR03%	AND
				FIN_PREFIX 	>= %exp:MV_PAR04%	AND
				FIN_PREFIX 	<= %exp:MV_PAR05%	AND
				FIN_NUM 	>= %exp:MV_PAR06%	AND
				FIN_NUM 	<= %exp:MV_PAR07%	AND
				FIN_PARCEL 	>= %exp:MV_PAR08%	AND
				FIN_PARCEL 	<= %exp:MV_PAR09%	AND
				FIN_TIPO 	>= %exp:MV_PAR10%	AND
				FIN_TIPO 	<= %exp:MV_PAR11%	AND
				FIN_CLIENT 	>= %exp:MV_PAR12%	AND
				FIN_LOJA 	>= %exp:MV_PAR13%	AND
				FIN_CLIENT 	<= %exp:MV_PAR14%	AND
				FIN_LOJA 	<= %exp:MV_PAR15%	AND
				FIN_FILIAL  = %xfilial:FIN% 	AND
				FIN.%NotDel%
			ORDER BY  FIN_FILIAL,FIN_PREFIX,FIN_NUM,FIN_PARCEL,FIN_TIPO,FIN_CLIENT,FIN_LOJA,FIN_DTAVP
		EndSql
	END REPORT QUERY oFIN
EndIf

If MV_PAR01 == ANALITICO
	oFIP := oReport:Section(1):Section(1)
	oFIP:SetParentQuery()
	oFIP:SetParentFilter({|cParam| (cAliasQry)->(FIN_FILIAL+FIN_PREFIX+FIN_NUM+FIN_PARCEL+FIN_TIPO+FIN_CLIENT+FIN_LOJA+FIN_SEQ) == cParam},{|| (cAliasQry)->(FIP_FILIAL+FIP_PREFIX+FIP_NUM+FIP_PARCEL+FIP_TIPO+FIP_CLIENT+FIP_LOJA+FIP_SEQ)})
EndIf
TRPosition():New(oFIN, "SE1", 2, {|| xFilial("SE1") + (cAliasQry)->(FIN_CLIENT+FIN_LOJA+FIN_PREFIX+FIN_NUM+FIN_PARCEL+FIN_TIPO) }) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
TRPosition():New(oFIN, "SA1", 1, {|| xFilial("SA1") + (cAliasQry)->(FIN_CLIENT+FIN_LOJA) }) //A1_FILIAL+A1_COD+A1_LOJA

oFIN:Print()

Return
