/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FATR070.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR070   ºAutor  ³Vendas - CRM        º Data ³  27/01/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Oportunidades X Processos de Vendas                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FATR070                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATR070()

	Local oReport 
	Local aPDFields := {"A1_NOME"}

	If FindFunction("TRepInUse") .And. TRepInUse()
		FATPDLoad(/*cUserPDA*/, /*aAlias*/, aPDFields)
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
		FATPDUnload()
	EndIf	

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
@author Squad CRM & Faturamento
@since 11/09/2019
@version 1.0
/*/
//-------------------------------------------------------------------
Static Function ReportDef()

	Local cPerg  := "FATR070"
	Local cAlias := ""
	Local oReport
   
    Local oRaiz
    Local oCell
    Local oCell1
    Local oCell2
    Local oCell3
	Local oCabPro
	Local oItemPro
	Local oBreak
	Local oTotA
	Local oQtd

	Local cAlias 	:= GetNextAlias()
	Local cAliasADY := GetNextAlias()
	Local cAliasADZ	:= GetNextAlias()

	Pergunte(cPerg, .F.)
	
	//Relatório
	DEFINE REPORT oReport NAME "FATR070" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cPerg, cAlias, cAliasADY,cAliasADZ,oCell,oCell1,oCell2,oCell3)} //"Relatorio de Propostas Comerciais"
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 
				 
	//sessao Pai
	DEFINE SECTION oRaiz OF oReport TITLE STR0002 BREAK HEADER //"Propostas Comerciais"
       
   	//Celulas secao Pai
	DEFINE CELL oCell NAME "ENTIDADE" 	OF oRaiz TITLE STR0003 	SIZE 15 BLOCK {|| IIF((cAlias)->ORIGEM=="SA1",STR0007,STR0008) } // "Entidade" 
	DEFINE CELL 	  NAME "CODIGO" 	OF oRaiz TITLE STR0004	SIZE 15 BLOCK {|| IIF(((cAlias)->ORIGEM=="SA1" .OR. (cAlias)->ORIGEM=="SUS"),(cAlias)->CODIGO + " - " + (cAlias)->LOJA,(cAlias)->CODIGO) } //"Código" 
	DEFINE CELL       NAME "DESCRI" 	OF oRaiz TITLE STR0005 	SIZE 100 BLOCK {|| FATPDObfuscate((cAlias)->DESCRI,"A1_NOME")} //"Descrição"
	
	DEFINE SECTION oCabPro OF oRaiz TITLE STR0006 TABLE "ADY"  BREAK HEADER LEFT MARGIN 5	//"Propostas" 
			
	DEFINE CELL NAME "ADY_PROPOS"		 OF oCabPro ALIAS "ADY" SIZE 15 	    
	DEFINE CELL NAME "ADY_OPORTU"		 OF oCabPro ALIAS "ADY"	SIZE 15    
	DEFINE CELL NAME "ADY_PREVIS"		 OF oCabPro ALIAS "ADY" SIZE 15        
	DEFINE CELL NAME "ADY_TABELA"		 OF oCabPro ALIAS "ADY" SIZE 15     
	DEFINE CELL NAME "ADY_DATA"			 OF oCabPro ALIAS "ADY" SIZE 15 
	DEFINE CELL oCell1 NAME "ADY_ENTIDA" OF oCabPro ALIAS "ADY" SIZE 15 BLOCK {|| IIF(((cAliasADY)->ADY_ENTIDA=="1"),STR0007,STR0008) } //"CLIENTE"##"PROSPECT"
	DEFINE CELL oCell2 NAME "ADY_CODIGO" OF oCabPro ALIAS "ADY" SIZE 15 BLOCK {|| (cAliasADY)->ADY_CODIGO + " / " + (cAliasADY)->ADY_LOJA }
	DEFINE CELL oCell3 NAME "Descricao"  OF oCabPro TITLE STR0005 SIZE 50 BLOCK {|| FATPDObfuscate(IIF(((cAliasADY)->ADY_ENTIDA=="1"),;
	POSICIONE("SA1",1,XFILIAL("SA1") +((cAliasADY)->ADY_CODIGO) + ((cAliasADY)->ADY_LOJA),"A1_NOME"),;
	POSICIONE("SUS",1,XFILIAL("SUS") +((cAliasADY)->ADY_CODIGO) + ((cAliasADY)->ADY_LOJA),"US_NOME")),"A1_NOME")} // "Descrição"
	       
	//Sessao Neta/Entidade
	DEFINE SECTION oItemPro OF oCabPro TITLE STR0009 TABLE "ADZ" BREAK HEADER LEFT MARGIN 10 //"Itens da Proposta"	
	  		
	//Celulas secao Neta/Entidade	        
	DEFINE CELL NAME "ADZ_FOLDER"		OF oItemPro ALIAS "ADZ" SIZE 10 BLOCK {|| IIF((cAliasADZ)->ADZ_FOLDER=="1",STR0010,STR0011) } //"Produto"##"Acessorio"
	DEFINE CELL NAME "ADZ_ITEM"			OF oItemPro ALIAS "ADZ" SIZE 8	    
	DEFINE CELL NAME "ADZ_PRODUT"		OF oItemPro ALIAS "ADZ"	    
	DEFINE CELL NAME "ADZ_DESCRI"		OF oItemPro ALIAS "ADZ"        
	DEFINE CELL NAME "ADZ_UM"			OF oItemPro ALIAS "ADZ" SIZE 9     
	DEFINE CELL NAME "ADZ_MOEDA"		OF oItemPro ALIAS "ADZ" SIZE 7 
	DEFINE CELL NAME "ADZ_CONDPG"		OF oItemPro ALIAS "ADZ" SIZE 18	    
	DEFINE CELL NAME "ADZ_TES"			OF oItemPro ALIAS "ADZ"	SIZE 13    
	DEFINE CELL NAME "ADZ_QTDVEN"		OF oItemPro ALIAS "ADZ"        
	DEFINE CELL NAME "ADZ_PRCVEN"		OF oItemPro ALIAS "ADZ"
	DEFINE CELL NAME "ADZ_PRCTAB"		OF oItemPro ALIAS "ADZ" 	    
	DEFINE CELL NAME "ADZ_TOTAL"		OF oItemPro ALIAS "ADZ"	    
	DEFINE CELL NAME "ADZ_VALDES"		OF oItemPro ALIAS "ADZ" SIZE 30       
	DEFINE CELL NAME "ADZ_DESCON"		OF oItemPro ALIAS "ADZ"	SIZE 15
		
	DEFINE BREAK oBreak OF oItemPro WHEN oItemPro:Cell("ADZ_FOLDER")
		
	DEFINE FUNCTION oQtd FROM oItemPro:Cell("ADZ_ITEM") OF oCabPro FUNCTION COUNT TITLE STR0012 //"Qtd. Itens" 
	DEFINE FUNCTION oTotA FROM oItemPro:Cell("ADZ_TOTAL") OF oCabPro FUNCTION SUM TITLE STR0013     //"Total"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Vendas CRM         º Data ³  07/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Selecao dos itens a serem impressos                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FATRX X                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport, cPerg, cAlias,cAliasADY,cAliasADZ,oCell,;
							oCell1,oCell2,oCell3)

	Local oSection1 	:= oReport:Section(1)                          //define como seção Pai
	Local oSecItem      := oReport:Section(1):Section(1)	           //Define a secao Filha /Propostas
	Local oSecProd      := oReport:Section(1):Section(1):Section(1)  //Define a secao Neta  /Itens da Proposta
	
	Local cFiltro	    := ""      							//String contendo o filtro de busca a ser utilizado com DBF
	Local cSQL          := ""                               //String contendo a expressão utilizada na query 
	Local cVend         := ""                               //Strinfg para busca no AD2_VEND
	Local cAuxSQL       := "%%"								//String contendo parte da expressão SQL
	Local cAuxSQL1      := "%%"                             //String contendo parte da expressão SQL
	Local cAuxSQL2      := ""								//String contendo parte da expressão SQL
	Local cAuxSQL3      := ""                               //String contendo parte da expressão SQL
	Local cAnd1			:= "%''%"                           //Define a tabela de origem
	Local cAnd2			:= "%''%"                           //Define a tabela de origem
	Local cEntCli		:= "%'1'%"                          //Define a entidade como Cliente
	Local cEntPro		:= "%'2'%"                          //Define a entidade como Prospect
	Local cWhere		:= ""                               //Contem a expressão Where na Query
	Local cJoin			:= "%%"                             //Contem a expressão Join na query
	Local cCampos		:= "%%"                             //Contem os campos usados na query
	Local cCamposADY	:= ""
	Local cCamposADZ	:= ""
    Local lSintetico	:= (MV_PAR10==2)	   				//Se o relatório é do tipo sintético ou não

	MakeSqlExp(cPerg)
	
	If lSintetico
		oSecItem:Hide()
		oSecItem:SetHeaderSection(.F.)
		oSecProd:Hide()
	EndIf
	
	If !Empty(MV_PAR01)//Data De:
	   	cSQL += "AND ADY_DATA >= '" + DToS(MV_PAR01) + "' "
	EndIf

	If !Empty(MV_PAR02)//Data Até:
		cSQL += "AND ADY_DATA <= '" + DToS(MV_PAR02) + "' "
	EndIf
    
	If !Empty(MV_PAR03) .AND. (mv_par09<>3)//Vendedores
		cVend := StrTran(MV_PAR03,"AD1_VEND","AD2_VEND")
	   	cSQL += "AND (" + MV_PAR03 + " OR "+ cVend + ")"
	EndIf
	
	If !Empty(MV_PAR04) .AND. (mv_par09<>2) //Produto
	   	cSQL += "AND " + MV_PAR04 + " "
	EndIf
    
    If !Empty(MV_PAR06) .AND. (MV_PAR06 <>3) //Cliente ou Prospect
	   	If(MV_PAR06 == 1 .OR. MV_PAR06 == 2)
	   		cSQL += "AND ADY_ENTIDA = '" + CValToChar(MV_PAR06) + "' "
	   	EndIf	
	EndIf
	
	If (MV_PAR06 == 1) //Cliente
		If !Empty(MV_PAR05) .AND. (mv_par09<>4)
		   U_MontQuery(@cSQL,MV_PAR05,MV_PAR06)
		EndIF
		If !Empty(MV_PAR07) //Cliente
	 		cSQL += "AND " + MV_PAR07 + " "
		EndIf
	ElseIf (MV_PAR06 == 2) //Prospect 
		If !Empty(MV_PAR05) .AND. (mv_par09<>4)
			U_MontQuery(@cSQL,MV_PAR05,MV_PAR06)
		EndIf
		If !Empty(MV_PAR08) //PROSPECT
	   		cSQL += "AND " + MV_PAR08 + " "
		EndIf
	Else
		If !Empty(MV_PAR05) .AND. (mv_par09<>4)
			U_MontQuery(@cSQL,MV_PAR05,MV_PAR06)
		EndIf
		If(MV_PAR09<>1) //Não adicionar no where quando a quebra for entidade.
			If (!Empty(MV_PAR07) .AND. !Empty(MV_PAR08))
				cSQL += "AND (" + MV_PAR07 + " OR " + MV_PAR08 + ")"
			Else
				If !Empty(MV_PAR07) .AND. Empty(MV_PAR08) //Cliente
	 				cSQL += "AND ((" + MV_PAR07 + " AND ADY_ENTIDA = '1') OR (ADY_ENTIDA = '2')) "
				EndIf
				If !Empty(MV_PAR08) .AND. Empty(MV_PAR07) //PROSPECT
	 				cSQL += "AND ((" + MV_PAR08 + " AND ADY_ENTIDA = '2') OR (ADY_ENTIDA = '1')) "	
				EndIf
			EndIf
		EndIf			
	EndIf
	
	cSQL := "%"+cSQL+"%"

	If (MV_PAR09 == 1)//ENTIDADE
		
		oCell1:Disable() 
		oCell2:Disable()
		oCell3:Disable()
		
		If (MV_PAR06 == 1) //Cliente
			
			If !Empty(MV_PAR07)
				cAuxSQL := StrTran(MV_PAR07,"ADY_CODIGO","A1_COD")
				cAuxSQL := "AND " + cAuxSQL + " "
				cAuxSQL := "%"+cAuxSQL+"%"
			EndIf
			
			cAnd1 := "%'SA1' as ORIGEM%" 
		
			BEGIN REPORT QUERY oSection1
				BeginSQL Alias cAlias
					SELECT 	A1_COD as CODIGO, A1_LOJA as LOJA, A1_NOME as DESCRI, %exp:cAnd1% 
						FROM %Table:SA1% SA1                            
				   		WHERE A1_FILIAL = %xFilial:SA1% %exp:cAuxSQL% AND SA1.%NotDel%   
					ORDER BY CODIGO
				EndSQL
			END REPORT QUERY oSection1
		    
			cWhere := "% AND (ADY.ADY_CODIGO = %report_param: (cAlias)->CODIGO%"
			cWhere += " AND ADY.ADY_LOJA = %report_param: (cAlias)->LOJA%"
			cWhere += " AND ADY_ENTIDA = '1' AND %report_param: (cAlias)->ORIGEM% = 'SA1')%"
			
		ElseIf (MV_PAR06 == 2) //Prospect
		
			If !Empty(MV_PAR08)
				cAuxSQL := StrTran(MV_PAR08,"ADY_CODIGO","US_COD")
				cAuxSQL := "AND " + cAuxSQL + " "
				cAuxSQL := "%"+cAuxSQL+"%"
			EndIf
			
			cAnd2 := "%'SUS' as ORIGEM%" 
		
			BEGIN REPORT QUERY oSection1
			BeginSQL Alias cAlias
				SELECT US_COD AS CODIGO, US_LOJA as LOJA, US_NOME as DESCRI, %exp:cAnd2%
					FROM %Table:SUS% SUS
					WHERE US_FILIAL = %xFilial:SUS% %exp:cAuxSQL% AND SUS.%NotDel%   
				ORDER BY CODIGO				
				EndSQL
			END REPORT QUERY oSection1
		
			cWhere += "% AND (ADY.ADY_CODIGO = %report_param: (cAlias)->CODIGO%"
			cWhere += " AND ADY.ADY_LOJA = %report_param: (cAlias)->LOJA%"
			cWhere += " AND ADY_ENTIDA = '2' AND %report_param: (cAlias)->ORIGEM% = 'SUS')%"
			
		ElseIf (MV_PAR06 == 3) //Ambos
						   	
			If !Empty(MV_PAR07) //Filtra pelo cliente
				cAuxSQL := StrTran(MV_PAR07,"ADY_CODIGO","A1_COD")
				cAuxSQL := "AND " + cAuxSQL + " "
				cAuxSQL2 +="AND " + MV_PAR07 + " " "
				cAuxSQL := "%"+cAuxSQL+"%"
	   		EndIf
			   	
			If !Empty(MV_PAR08) //Filtra pelo Prospect
				cAuxSQL1 := StrTran(MV_PAR08,"ADY_CODIGO","US_COD")
				cAuxSQL1 := "AND " + cAuxSQL1 + " "
				cAuxSQL3 +="AND " + MV_PAR08 + " " "
				cAuxSQL1 := "%"+cAuxSQL1+"%"
			EndIf
			   	
			cAnd1 := "%'SA1' as ORIGEM%"
			cAnd2 := "%'SUS' as ORIGEM%" 
			   	 
			   	
			BEGIN REPORT QUERY oSection1
				BeginSQL Alias cAlias
					SELECT 	A1_COD as CODIGO, A1_LOJA as LOJA, A1_NOME as DESCRI, %exp:cAnd1% 
			 			FROM %Table:SA1% SA1                            
			   			WHERE A1_FILIAL = %xFilial:SA1% %exp:cAuxSQL% AND SA1.%NotDel% 
		   			UNION
					SELECT US_COD AS CODIGO, US_LOJA as LOJA, US_NOME as DESCRI, %exp:cAnd2%
						FROM %Table:SUS% SUS
						WHERE US_FILIAL = %xFilial:SUS% %exp:cAuxSQL1% AND SUS.%NotDel%   
					ORDER BY CODIGO				
				EndSQL
			END REPORT QUERY oSection1
			
			cWhere := "% AND ((ADY.ADY_CODIGO = %report_param: (cAlias)->CODIGO%"
			cWhere += 	cAuxSQL2 
			cWhere += " AND ADY.ADY_LOJA = %report_param: (cAlias)->LOJA%"
			cWhere += " AND ADY_ENTIDA = '1' AND %report_param: (cAlias)->ORIGEM% = 'SA1')"
			cWhere += " OR"
			cWhere += " (ADY.ADY_CODIGO = %report_param: (cAlias)->CODIGO%"
			cWhere += 	cAuxSQL3
			cWhere += " AND ADY.ADY_LOJA = %report_param: (cAlias)->LOJA%"
	   		cWhere += " AND ADY_ENTIDA = '2' AND %report_param: (cAlias)->ORIGEM% = 'SUS'))%"    
			
   		EndIf
		
		cJoin := "% INNER JOIN " + RetSqlName("AD1") +  " AD1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_NROPOR = ADY_OPORTU  AND AD1_REVISA = ADY_REVISA AND AD1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("ADZ") +  " ADZ ON ADZ_FILIAL = '" + xFilial("ADZ") + "' AND ADZ_PROPOS = ADY_PROPOS AND ADZ_REVISA = ADY_PREVIS AND ADY.D_E_L_E_T_= ' ' "
		cJoin += " LEFT JOIN " + RetSqlName("AD2") +  " AD2 ON AD2_FILIAL = '" + xFilial("AD2") + "' AND AD2_NROPOR = AD1_NROPOR AND AD2_REVISA = AD1_REVISA AND AD2.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SA1") +  " SA1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_CODCLI = A1_COD AND AD1_LOJCLI = A1_LOJA AND SA1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SUS") +  " SUS ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_PROSPE = US_COD AND AD1_LOJPRO = US_LOJA AND SUS.D_E_L_E_T_= ' '%"
		
	ElseIf (MV_PAR09 == 2)//Produto
		
		oCell:Disable() //desabilita campo Entidade quando a quebra for diferente de Entidade
		
		If !Empty(MV_PAR04) //Filtra pelo Produto
			cAuxSQL := StrTran(MV_PAR04,"ADZ_PRODUT","B1_COD")
			cAuxSQL := "AND " + cAuxSQL + " "
			cAuxSQL := "%"+cAuxSQL+"%"
		EndIf
		
		cAnd1 := "%'SB1' as ORIGEM%"
		
		BEGIN REPORT QUERY oSection1
			BeginSQL Alias cAlias
				SELECT 	B1_COD as CODIGO, B1_DESC as DESCRI,%exp:cAnd1%
		        FROM %Table:SB1% SB1
		   		WHERE B1_FILIAL = %xFilial:SB1% %exp:cAuxSQL% AND SB1.%NotDel%
		   		ORDER BY B1_FILIAL, B1_COD
			EndSQL
		END REPORT QUERY oSection1 

		cWhere := "%  %"   
		
		cJoin := "% INNER JOIN " + RetSqlName("ADZ") + " ADZ ON ADZ_FILIAL = '"+xFilial("ADZ")+"' AND ADZ_PROPOS = ADY_PROPOS"
		cJoin += " AND ADY_PREVIS = ADZ_REVISA"
		cJoin += " AND ADZ_PRODUT = %report_param: (cAlias)->CODIGO% AND ADZ.D_E_L_E_T_ = ''"
		cJoin += " LEFT JOIN " + RetSqlName("AD1") +  " AD1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_NROPOR = ADY_OPORTU AND AD1_REVISA = ADY_REVISA AND AD1.D_E_L_E_T_= ' ' "    
	    cJoin += " LEFT JOIN " + RetSqlName("AD2") +  " AD2 ON AD2_FILIAL = '" + xFilial("AD2") + "' AND AD2_NROPOR = AD1_NROPOR AND AD2_REVISA = AD1_REVISA AND AD2.D_E_L_E_T_= ' ' " 
	    cJoin += " LEFT JOIN " + RetSqlName("SA1") +  " SA1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_CODCLI = A1_COD AND AD1_LOJCLI = A1_LOJA AND SA1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SUS") +  " SUS ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_PROSPE = US_COD AND AD1_LOJPRO = US_LOJA AND SUS.D_E_L_E_T_= ' '%"
	
	ElseIf (MV_PAR09 == 3) //Vendedor
        
        oCell:Disable() //desabilita campo Entidade quando a quebra for diferente de Entidade
        
		If !Empty(MV_PAR03) //Filtra pelo Produto
			cAuxSQL := StrTran(MV_PAR03,"AD1_VEND","A3_COD")
			cAuxSQL := "AND " + cAuxSQL + " "
			cAuxSQL := "%"+cAuxSQL+"%"
		EndIf
		
		cAnd1 := "%'SA3' as ORIGEM%"
	
		BEGIN REPORT QUERY oSection1
			BeginSQL Alias cAlias
				SELECT A3_COD as CODIGO, A3_NOME as DESCRI,%exp:cAnd1%
		        FROM %Table:SA3% SA3
		   		WHERE A3_FILIAL = %xFilial:SA3% %Exp:cAuxSQL% AND SA3.%NotDel%
		   		ORDER BY A3_FILIAL, A3_COD
			EndSQL
		END REPORT QUERY oSection1 

		cCampos := "% ,AD1_NROPOR,AD2_NROPOR %"
		
		cJoin := "% INNER JOIN " + RetSqlName("ADZ") + " ADZ ON ADZ_FILIAL = '" + xFilial("ADZ") + "' AND ADZ_PROPOS = ADY_PROPOS"
		cJoin += " AND ADY_PREVIS = ADZ_REVISA AND ADZ.D_E_L_E_T_ = ''"
		cJoin += " LEFT JOIN " + RetSqlName("AD1") + " AD1"
		cJoin += " ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_NROPOR = ADY_OPORTU AND AD1_REVISA = ADY_REVISA AND AD1.D_E_L_E_T_ = '' "
		cJoin += " LEFT JOIN " + RetSqlName("AD2") + " AD2"
		cJoin += " ON AD2_FILIAL = '" + xFilial("AD2") + "' AND AD2_NROPOR = ADY_OPORTU AND AD2_REVISA = ADY_REVISA AND AD2.D_E_L_E_T_ = '' "
		cJoin += " LEFT JOIN " + RetSqlName("SA1") +  " SA1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_CODCLI = A1_COD AND AD1_LOJCLI = A1_LOJA AND SA1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SUS") +  " SUS ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_PROSPE = US_COD AND AD1_LOJPRO = US_LOJA AND SUS.D_E_L_E_T_= ' '%"		
		
		//Verifica se um dos campos da AD1 ou AD2 eh nulo
		If (Upper(TcGetDb()) $ "ORACLE,POSTGRES,DB2,INFORMIX")
			cWhere := "% AND (AD1_NROPOR IS NOT NULL OR AD2_NROPOR IS NOT NULL ) "
		Else //SQL
			cWhere := "% AND (AD1_NROPOR IS NOT NULL OR AD2_NROPOR IS NOT NULL ) "
		EndIf
		
		cWhere += "AND ((AD1_VEND = %report_param: (cAlias)->CODIGO%) OR (AD2_VEND = %report_param: (cAlias)->CODIGO%)) %" 
		
	Else //Segmento
		
		oCell:Disable()//desabilita campo Entidade quando a quebra for diferente de Entidade
		
		If !Empty(MV_PAR05) //Filtra pelo SEGMENTO
			cAuxSQL := StrTran(MV_PAR05,"A1_SATIV1","X5_CHAVE")
			cAuxSQL := "AND " + cAuxSQL + " "
			cAuxSQL := "%"+cAuxSQL+"%"
		EndIf
		
		cAnd1 := "%'SX5' as ORIGEM%"
	
		BEGIN REPORT QUERY oSection1
			BeginSQL Alias cAlias
				SELECT X5_CHAVE AS CODIGO, X5_DESCRI AS DESCRI,%exp:cAnd1%
		        FROM %Table:SX5% SX5
		   		WHERE X5_FILIAL = %xFilial:SX5% AND X5_TABELA = 'T3' %Exp:cAuxSQL% AND SX5.%NotDel%
		   		ORDER BY X5_FILIAL, X5_CHAVE
			EndSQL
		END REPORT QUERY oSection1 
		
		If (MV_PAR06 == 1) //cliente, busca na tabela SA1
			cWhere += "% AND ((SA1.A1_SATIV1 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV2 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SA1.A1_SATIV3 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV4 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SA1.A1_SATIV5 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV6 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SA1.A1_SATIV7 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV8 = %report_param: (cAlias)->CODIGO%)) %" 
			
		ElseIf (MV_PAR06 == 2) //Prospect, busca na tabela SUS
			cWhere += "% AND ((SUS.US_SATIV = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV2 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV3 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV4 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV5 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV6 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV7 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV8 = %report_param: (cAlias)->CODIGO%)) %"
		Else	
	   		cWhere += "% AND ((SA1.A1_SATIV1 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV2 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR(SA1.A1_SATIV3 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV4 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SA1.A1_SATIV5 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV6 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SA1.A1_SATIV7 = %report_param: (cAlias)->CODIGO%) OR (SA1.A1_SATIV8 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV2 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV3 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV4 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV5 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV6 = %report_param: (cAlias)->CODIGO%) "
			cWhere += " OR (SUS.US_SATIV7 = %report_param: (cAlias)->CODIGO%) OR (SUS.US_SATIV8 = %report_param: (cAlias)->CODIGO%)) %"
		EndIf
			
		cJoin := "% INNER JOIN " + RetSqlName("AD1") +  " AD1 ON AD1_FILIAL = '"+ xFilial("AD1") +"' AND AD1_NROPOR = ADY_OPORTU  AND AD1_REVISA = ADY_REVISA AND AD1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("ADZ") +  " ADZ ON ADZ_FILIAL = '" + xFilial("ADZ") + "' AND ADZ_PROPOS = ADY_PROPOS AND ADZ_REVISA = ADY_PREVIS AND ADY.D_E_L_E_T_= ' ' "
		cJoin += " LEFT JOIN " + RetSqlName("AD2") +  " AD2 ON AD2_FILIAL = '" + xFilial("AD2") + "' AND AD2_NROPOR = AD1_NROPOR AND AD2_REVISA = AD1_REVISA AND AD2.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SA1") +  " SA1 ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_CODCLI = A1_COD AND AD1_LOJCLI = A1_LOJA AND SA1.D_E_L_E_T_= ' '" 
		cJoin += " LEFT JOIN " + RetSqlName("SUS") +  " SUS ON AD1_FILIAL = '" + xFilial("AD1") + "' AND AD1_PROSPE = US_COD AND AD1_LOJPRO = US_LOJA AND SUS.D_E_L_E_T_= ' '%"
		
	EndIf				
 
	cCamposADY := CamposAD("ADY")
	If MV_PAR09 == 3
		cCamposADY +=",AD1_NROPOR,AD2_NROPOR"
	EndIf
	cCamposADY := "%"+cCamposADY+"%"
	// Query das Propostas (1o. Nivel) 
	BEGIN REPORT QUERY oSecItem
	BeginSql alias cAliasADY
		SELECT DISTINCT %exp:cCamposADY%
		FROM %table:ADY% ADY 
		%exp:cJoin%
		WHERE ADY_FILIAL = %xfilial:ADY%  %exp:cWhere%
		AND ADY.%notDel% %exp:cSQL%
		ORDER BY ADY_FILIAL,ADY_PROPOS
	EndSql
	END REPORT QUERY oSecItem
    
	cCamposADZ := CamposAD("ADZ")
	cCamposADZ := "%"+cCamposADZ+"%"
	// Query dos itens das propostas (2o. Nivel)
	BEGIN REPORT QUERY oSecProd
	BeginSql alias cAliasADZ
		SELECT DISTINCT %exp:cCamposADZ%
		FROM %table:ADZ% ADZ 
		WHERE ADZ_FILIAL = %xfilial:ADZ% AND ADZ_PROPOS = %report_param: (cAliasADY)-> ADY_PROPOS %
		AND ADZ_REVISA = %report_param: (cAliasADY)-> ADY_PREVIS %
		AND ADZ.%notDel%
		ORDER BY ADZ_FILIAL,ADZ_FOLDER
	EndSql
	END REPORT QUERY oSecProd                          

	
	While !oReport:Cancel() .AND. (cAlias)->(!Eof()) //Regra de impressao
		oSection1:Init() 

		oSecItem:ExecSql() 	

		If  !(cAliasADY)->(Eof()) 
			oSection1:PrintLine()
		EndIf

		While !oReport:Cancel() .And. !(cAliasADY)->(Eof())
		
			oSecItem:Init()
			oSecItem:SetTotalText(STR0014) //"Total da Proposta" 
			oSecItem:PrintLine()
		
			oReport:IncMeter() 
			     
			oSecProd:ExecSql()
			oSecProd:Init()
		
			While !oReport:Cancel() .And. !(cAliasADZ)->(Eof())
			 
				oSecProd:PrintLine()		
				oReport:IncMeter() 
		
				(cAliasADZ)->(DbSkip()) 
	     
			End
			oSecProd:Finish()
			(cAliasADY)->(DbSkip()) 
	    
	    	If !lSintetico
				oSecItem:Finish()
			EndIf
				
		End
	
		If lSintetico
			oSecItem:Finish()
		EndIf
		
		(cAlias)->(DbSkip())	
		oSection1:Finish()
	
	EndDo

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR070   ºAutor  ³Vendas CRM          º Data ³  08/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta query quando o parametro de segmento de negocios esta º±±
±±º          ³preenchida                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FATR070                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MontQuery(cSQL,MV_PAR05,MV_PAR06)
	Local cCliSeg1
	Local cCliSeg2
	Local cCliSeg3
	Local cCliSeg4
	Local cCliSeg5
	Local cCliSeg6
	Local cCliSeg7
	Local cProSeg1
	Local cProSeg2
	Local cProSeg3
	Local cProSeg4
	Local cProSeg5
	Local cProSeg6
	Local cProSeg7
	Local cProSeg8
	
	If (MV_PAR06 == 1) //CLIENTE
		cSQL += "AND (" + MV_PAR05 + " "
			
	    cCliSeg1 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV2")
	    cCliSeg2 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV3")
	    cCliSeg3 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV4")
	    cCliSeg4 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV5")
	    cCliSeg5 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV6")
	    cCliSeg6 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV7")
	    cCliSeg7 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV8")
	    	
	    cSQL += "OR " + cCliSeg1 + " "
	    cSQL += "OR " + cCliSeg2 + " "
	    cSQL += "OR " + cCliSeg3 + " "
	    cSQL += "OR " + cCliSeg4 + " "
	    cSQL += "OR " + cCliSeg5 + " "
	    cSQL += "OR " + cCliSeg6 + " "
	    cSQL += "OR " + cCliSeg7 + ") "
	    
	ElseIf (MV_PAR06 == 2) //PROSPECT
		
		cProSeg1 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV") 
		cProSeg2 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV2")
		cProSeg3 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV3")
		cProSeg4 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV4")
		cProSeg5 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV5")
		cProSeg6 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV6")
		cProSeg7 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV7")
		cProSeg8 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV8")
		
		cSQL += "AND (" + cProSeg1 + " "
		cSQL += "OR "  + cProSeg2 + " "
		cSQL += "OR "  + cProSeg3 + " "
		cSQL += "OR "  + cProSeg4 + " "
		cSQL += "OR "  + cProSeg5 + " "
		cSQL += "OR "  + cProSeg6 + " "
		cSQL += "OR "  + cProSeg7 + " "
		cSQL += "OR "  + cProSeg8 + ") "
		
	Else //AMBOS
		
		cSQL += "AND (" + MV_PAR05 + " "
			
	    cCliSeg1 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV2")
	    cCliSeg2 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV3")
	    cCliSeg3 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV4")
	    cCliSeg4 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV5")
	    cCliSeg5 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV6")
	    cCliSeg6 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV7")
	    cCliSeg7 = StrTran(MV_PAR05,"A1_SATIV1","A1_SATIV8")
	    cProSeg1 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV") 
		cProSeg2 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV2")
		cProSeg3 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV3")
		cProSeg4 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV4")
		cProSeg5 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV5")
		cProSeg6 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV6")
		cProSeg7 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV7")
		cProSeg8 = StrTran(MV_PAR05,"A1_SATIV1","US_SATIV8")
		
		cSQL += "OR " + cCliSeg1 + " "
	    cSQL += "OR " + cCliSeg2 + " "
	    cSQL += "OR " + cCliSeg3 + " "
	    cSQL += "OR " + cCliSeg4 + " "
	    cSQL += "OR " + cCliSeg5 + " "
	    cSQL += "OR " + cCliSeg6 + " "
	    cSQL += "OR " + cCliSeg7 + " "
	    cSQL += "OR " + cProSeg1 + " "
		cSQL += "OR "  + cProSeg2 + " "
		cSQL += "OR "  + cProSeg3 + " "
		cSQL += "OR "  + cProSeg4 + " "
		cSQL += "OR "  + cProSeg5 + " "
		cSQL += "OR "  + cProSeg6 + " "
		cSQL += "OR "  + cProSeg7 + " "
		cSQL += "OR "  + cProSeg8 + ") "
			
	EndIf
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR070   ºAutor  ³Microsiga           º Data ³  09/02/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retornar campos a serem adicionados a query.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CamposAD(cTab)
Local cRetCampos := ""

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cTab)
While !EOF() .AND. (X3_ARQUIVO == cTab)
	If ( X3Uso(X3_USADO) .OR. "_FILIAL" $ TRIM(SX3->X3_CAMPO) ) .AND. (X3_CONTEXT <> "V") .AND. (X3_TIPO <> "M")
		cRetCampos += X3_CAMPO +","	
	EndIf
	dbSkip()
End
cRetCampos := Substr(cRetCampos,1,Len(cRetCampos)-1) 

Return cRetCampos




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
