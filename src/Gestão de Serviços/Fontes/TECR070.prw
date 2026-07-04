/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#include "report.ch"
#include "TECR070.ch"

//------------------------------------------------------------------------------
/*/{Protheus.doc} TECR070
@description	Relatorio de picking de equipamentos para locacao
@sample	 	TECR170() 
@param		Nenhum
@return		Nil
@author		Rogerio Melonio
@since		04/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
User Function TECR070()

Local aArea := GetArea()	//Guarda a area atual
Local oReport
	
Private cPerg := "TECR070"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ PARAMETROS                                                          ³
//³ MV_PAR01 : Inicio Contrato De ?                                     ³
//³ MV_PAR02 : Inicio Contrato Ate ?                                    ³
//³ MV_PAR03 : Final Contrato De ?                                      ³
//³ MV_PAR04 : Final Contrato De ?                                      ³
//³ MV_PAR05 : Entrega Equipamento De ?                                 ³
//³ MV_PAR06 : Entrega Equipamento Ate ?                                ³
//³ MV_PAR07 : Coleta Equipamento De ?                                  ³
//³ MV_PAR08 : Coleta Equipamento Ate ?                                 ³
//³ MV_PAR09 : Produto De ?                                             ³
//³ MV_PAR10 : Produto Ate ?                                            ³
//³ MV_PAR11 : Cliente De ?                                             ³
//³ MV_PAR12 : Cliente Ate ?                                            ³
//³ MV_PAR13 : Somente Equip. Separado ?                                ³
//³ MV_PAR14 : Equipamento Reservado ?                                  ³
//³ MV_PAR15 : Confirmcao de Entrega ?                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
Pergunte(cPerg, .F.)

oReport:= Rt070Def(cPerg)
oReport:PrintDialog()
	
RestArea( aArea )

Return (.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt070Def()

Consulta coleta e entrega do equipamento - monta as Section's para impressão do relatorio

@sample Rt070Def(cPerg)
@param cPerg 
@return oReport

@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function Rt070Def(cPerg)

Local oReport	
Local oSection
Local aOrdem   := {STR0002, STR0003, STR0004} //"Por Produto", "Data Inicio Contrato", "Entrega do Equipamento"
	
//Define a criacao do objeto oReport
DEFINE REPORT oReport NAME "TECR070" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg, aOrdem)} //"Relatório de Picking"
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 
	
	//Define a secao1 do relatorio
	DEFINE SECTION oSection OF oReport TITLE STR0001 ORDERS aOrdem TABLES "TEW","TFI","TFL","TFJ","SA1","SB1","AA3"//"Relatório de Picking"
			
		//Define as celulas que irao aparecer na secao1		
		DEFINE CELL NAME "TFI_PERINI"	OF oSection ALIAS "TFI"  
		DEFINE CELL NAME "TFI_ENTEQP"	OF oSection ALIAS "TFI" 
		DEFINE CELL NAME "TFI_COLEQP"	OF oSection ALIAS "TFI"
		DEFINE CELL NAME "ABS_DESCRI"	OF oSection TITLE STR0005 ALIAS "ABS"     
		DEFINE CELL NAME "A1_NOME"		OF oSection TITLE STR0006 ALIAS ALIAS "SA1"
		DEFINE CELL NAME "B1_DESC"		OF oSection TITLE STR0007 ALIAS ALIAS "SB1" 
		DEFINE CELL NAME "AA3_LOCAL"	OF oSection ALIAS "AA3"      
		DEFINE CELL NAME "TEW_BAATD"	OF oSection ALIAS "TEW"  
		DEFINE CELL NAME "TEW_NUMPED"	OF oSection ALIAS "TEW" 	    
		DEFINE CELL NAME "TEW_DTSEPA"	OF oSection ALIAS "TEW"
		DEFINE CELL NAME "TFI_RESERV"	OF oSection ALIAS "TIF"
			
Return oReport

//------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
@description	Relatorio de picking de equipamentos para locacao
@sample	 	TECR170() 
@param		Nenhum
@return		objeto do relatorio
@author		Rogerio Melonio
@since		04/04/2016
@version	P12   
/*/
//------------------------------------------------------------------------------
Static Function PrintReport(oReport,cPerg, aOrdem)

Local cAlias := GetNextAlias()
Local oSection1 := oReport:Section(1)
Local cSql := ""
Local cChave := ""
Local nOrder    := 0
	
nOrder    := oReport:Section(1):GetOrder()
	
MakeSqlExp(cPerg)
		
If !Empty(MV_PAR01)
	cSql += " AND TFI_PERINI >= '" + Dtos(MV_PAR01) + "' "
Endif
	
If !Empty(MV_PAR02)
	cSql += " AND TFI_PERINI <= '" + Dtos(MV_PAR02) + "' "
Endif
	
If !Empty(MV_PAR03)
	cSql += " AND TFI_PERFIM >= '" + Dtos(MV_PAR03) + "' "
Endif
	
If !Empty(MV_PAR04)
	cSql += " AND TFI_PERFIM <= '" + Dtos(MV_PAR04) + "' "
Endif
	
If !Empty(MV_PAR05)
	cSql += " AND TFI_ENTEQP >= '" + Dtos(MV_PAR05) + "' "
Endif
	
If !Empty(MV_PAR06)
	cSql += " AND TFI_ENTEQP <= '" + Dtos(MV_PAR06) + "' "
Endif
	
If !Empty(MV_PAR07)
	cSql += " AND TFI_COLEQP >= '" + Dtos(MV_PAR07) + "' "
Endif
	
If !Empty(MV_PAR08)
	cSql += " AND TFI_COLEQP <= '" + Dtos(MV_PAR08) + "' "
Endif
	
If MV_PAR13 = 1
	cSql += " AND TEW_DTSEPA <> '' "
ElseIf MV_PAR13 = 2
	cSql += " AND TEW_DTSEPA = '' "
EndIf
	
If MV_PAR14 = 1
	cSql += " AND TFI_RESERV <> '' "
ElseIf MV_PAR14 = 2
	cSql += " AND TFI_RESERV = '' "
EndIf
	
If MV_PAR15 == 1
	cSql += "AND TFI_CONENT = '1'"
ElseIf MV_PAR15 == 2
	cSql += "AND TFI_CONENT = '2'"
ElseIf MV_PAR15 == 3
	cSql += "AND (TFI_CONENT = '1' OR TFI_CONENT = '2')"
EndIf
	
cSql := "%" + cSql + "%"
	
If oSection1:nOrder == 1 
    cChave := "%TEW.TEW_PRODUT%"
    oReport:SetTitle( STR0001 + STR0002 ) //"Relatório de Picking"##" - Por Produto
ElseIf oSection1:nOrder == 2  
    cChave := "%TFI.TFI_PERINI%"
    oReport:SetTitle( STR0001 + STR0003 ) //"Relatório de Picking"##" - "Data Inicio Contrato"
ElseIf oSection1:nOrder == 3 
    cChave := "%TFI.TFI_ENTEQP%"
    oReport:SetTitle( STR0001 + STR0004 ) //"Relatório de Picking"##" - "Entrega do Equipamento"
EndIf
		
BEGIN REPORT QUERY oReport:Section(1)
	
	BeginSql alias cAlias
		SELECT TFI.TFI_PERINI, TFI.TFI_PERFIM, TFI.TFI_ENTEQP, TFI.TFI_COLEQP, TEW.TEW_PRODUT,
		       TEW.TEW_BAATD,  TEW.TEW_NUMPED, TEW.TEW_DTSEPA, AA3.AA3_LOCAL,  TFJ.TFJ_CODENT, 
		       SA1.A1_NOME,    SB1.B1_DESC,    ABS.ABS_DESCRI, TFI.TFI_RESERV
		  FROM %table:TEW% TEW
		       INNER JOIN %Table:TFI% TFI ON TFI.TFI_FILIAL = %xFilial:TFI% 
		                                 AND TFI.TFI_COD = TEW.TEW_CODEQU
		                                 AND TFI.%notDel% 
		       INNER JOIN %Table:TFL% TFL ON TFL.TFL_FILIAL = %xFilial:TFL% 
		                                 AND TFL.TFL_CODIGO = TFI.TFI_CODPAI 
		                                 AND TFL.%notDel% 
		       INNER JOIN %Table:TFJ% TFJ ON TFJ.TFJ_FILIAL = %xFilial:TFJ% 
		                                 AND TFJ.TFJ_CODIGO = TFL.TFL_CODPAI 
		                                 AND TFL.%notDel% 
		       INNER JOIN %Table:SA1% SA1 ON SA1.A1_FILIAL = %xFilial:SA1% 
		                                 AND SA1.A1_COD = TFJ.TFJ_CODENT 
		                                 AND SA1.A1_LOJA = TFJ.TFJ_LOJA 
		                                 AND SA1.%notDel% 
		       INNER JOIN %Table:SB1% SB1 ON SB1.B1_FILIAL = %xFilial:SB1% 
		                                 AND SB1.B1_COD = TEW.TEW_PRODUT 
		                                 AND SB1.%notDel% 
		       LEFT JOIN %Table:AA3% AA3 ON AA3.AA3_FILIAL = %xFilial:AA3% 
		                                 AND TEW.TEW_BAATD = AA3.AA3_NUMSER 
		                                 AND AA3.%notDel% 
		       INNER JOIN %Table:ABS% ABS ON ABS.ABS_FILIAL = %xFilial:ABS% 
		                                 AND ABS.ABS_LOCAL = TFL.TFL_LOCAL 
		                                 AND ABS.%notDel%
		 WHERE TEW.TEW_FILIAL = %xfilial:TEW%
		   AND	TEW.%notDel%
		       %exp:cSql%
		   AND TFJ.TFJ_ENTIDA = '1'
		   AND TEW_PRODUT BETWEEN %exp:MV_PAR09% AND %exp:MV_PAR10%
		   AND TFJ_CODENT BETWEEN %exp:MV_PAR11% AND %exp:MV_PAR12% 
		 ORDER BY %Exp:cChave%

	EndSql
	
END REPORT QUERY oReport:Section(1)
		
oReport:Section(1):Print()
Return