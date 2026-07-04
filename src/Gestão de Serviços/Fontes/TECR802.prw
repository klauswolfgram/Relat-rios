/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TECR802.CH"
#INCLUDE "TOPCONN.CH"
Static cAutoPerg := "TECR802"
//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TECR802()

Equipamentos x Locais

@sample 	U_TECR802()
@param 
@since		17/05/2015
@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function TECR802()
Local oReport

#IFDEF TOP
	oReport := ReportDef()
	oReport:PrintDialog()
#ELSE
	Help( ,, 'Help',, STR0014, 1, 0 )
#ENDIF

Return

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef()

Processamento do relatorio de Equipamentos x Locais e Locais x Equipamentos

@sample 	ReportDef()
@param 
@since		17/05/2015
@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function ReportDef()
Local oReport  := Nil
Local oSection1:= Nil
Local oSection2:= Nil

oReport:= TReport():New("TECR802",STR0001,"TECR802", {|oReport| ReportPrint(oReport)},STR0002 + " " + STR0003)	// "Equipamentos x Locais"###"Emissão do relatório que irá listar as movimentações de equipamentos"###"por postos."
oReport:SetPortrait(.T.) 
oReport:SetTotalInLine(.F.)

oSection1 := TRSection():New(oReport, "STR0004", {"TRB"},{STR0005,STR0006} , .F., .F.) // "Resumo"###"Equipamento"###"Local"
oSection1:SetTotalInLine(.F.)

oSection2 := TRSection():New(oReport,STR0004,{"TRB"},,/*Campos do SX3*/,/*Campos do SIX*/)	
oSection2:SetTotalInLine(.F.)

Pergunte(oReport:uParam,.F.)

Return(oReport)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportPrint(oReport)

Regra de impressao e geracao do relatorio

@sample 	ReportPrint()
@param 		oReport = Objeto TREPORT do relatorio
@since		17/05/2015
@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
Local cExpOrder := ""
Local cExpFiltro:= ""
Local cKeyFiltro:= ""
Local cQuery    := ""

If oReport:Section(1):GetOrder() == 1
	cExpOrder := "TFI_PRODUT, TEW_BAATD, TFI_PERINI"
	cExpFiltro:= "TFI_PRODUT+TEW_BAATD"
	
Else
	cExpOrder := "TFI_LOCAL, TFI_PERINI"
	cExpFiltro:= "TFI_LOCAL"
	
EndIf

//Definicao das colunas conforme ordem
If oReport:Section(1):GetOrder() == 1 //Por Equipamento
	TRCell():New(oReport:Section(1),"CCODPROD" 		,/*Tabela*/,FwNoAccent(STR0011)								,/*Picture*/	 			 ,TamSx3("TFI_PRODUT"  )[1],/*lPixel*/,{|| TRB->TFI_PRODUT	    })	
	TRCell():New(oReport:Section(1),"CDESCPRD" 		,/*Tabela*/,FwNoAccent(STR0012)								,/*Picture*/	 			 ,TamSx3("B1_DESC"     )[1],/*lPixel*/,{|| TRB->B1_DESC		    })
	TRCell():New(oReport:Section(1),"CNRSERIE" 		,/*Tabela*/,FwNoAccent(STR0013)								,/*Picture*/	 			 ,TamSx3("TEW_BAATD"   )[1],/*lPixel*/,{|| TRB->TEW_BAATD      })	

	TRCell():New(oReport:Section(2),"CCODPOSTO" 	,/*Tabela*/,FwNoAccent(STR0007)								,/*Picture*/	 			 ,TamSx3("TFI_LOCAL"   )[1],/*lPixel*/,{|| TRB->TFI_LOCAL   	})	
	TRCell():New(oReport:Section(2),"CNOMEPOSTO" 	,/*Tabela*/,FwNoAccent(STR0008)								,/*Picture*/	 			 ,TamSx3("ABS_DESCRI"  )[1],/*lPixel*/,{|| TRB->ABS_DESCRI		})	
	TRCell():New(oReport:Section(2),"DDTINICIO" 	,/*Tabela*/,FwNoAccent(STR0009)								,/*Picture*/	 			 ,TamSx3("TFI_PERINI"  )[1],/*lPixel*/,{|| TRB->TFI_PERINI	    })	
	TRCell():New(oReport:Section(2),"DDTFIM" 	    ,/*Tabela*/,FwNoAccent(STR0010)								,/*Picture*/	 			 ,TamSx3("TFI_PERFIM"  )[1],/*lPixel*/,{|| TRB->TFI_PERFIM      })	

Else //Por Posto
	TRCell():New(oReport:Section(1),"CCODPOSTO" 	,/*Tabela*/,FwNoAccent(STR0007)								,/*Picture*/	 			 ,TamSx3("TFI_LOCAL"   )[1],/*lPixel*/,{|| TRB->TFI_LOCAL	   })	
	TRCell():New(oReport:Section(1),"CNOMEPOSTO" 	,/*Tabela*/,FwNoAccent(STR0008)								,/*Picture*/	 			 ,TamSx3("ABS_DESCRI"  )[1],/*lPixel*/,{|| TRB->ABS_DESCRI     })	

	TRCell():New(oReport:Section(2),"CCODPROD" 		,/*Tabela*/,FwNoAccent(STR0011)								,/*Picture*/	 			 ,TamSx3("TFI_PRODUT"  )[1],/*lPixel*/,{|| TRB->TFI_PRODUT	   })	
	TRCell():New(oReport:Section(2),"CDESCPRD" 		,/*Tabela*/,FwNoAccent(STR0012)								,/*Picture*/	 			 ,TamSx3("B1_DESC"     )[1],/*lPixel*/,{|| TRB->B1_DESC		   })	
	TRCell():New(oReport:Section(2),"CNRSERIE" 		,/*Tabela*/,FwNoAccent(STR0013)								,/*Picture*/	 			 ,TamSx3("TEW_BAATD"   )[1],/*lPixel*/,{|| TRB->TEW_BAATD      })	
	TRCell():New(oReport:Section(2),"DDTINICIO" 	,/*Tabela*/,FwNoAccent(STR0009)								,/*Picture*/	 			 ,TamSx3("TFI_PERINI"  )[1],/*lPixel*/,{|| TRB->TFI_PERINI     })	
	TRCell():New(oReport:Section(2),"DDTFIM" 	    ,/*Tabela*/,FwNoAccent(STR0010)								,/*Picture*/	 			 ,TamSx3("TFI_PERFIM"  )[1],/*lPixel*/,{|| TRB->TFI_PERFIM     })	
EndIf

//Query do relatorio 
cQuery := " SELECT TFI_LOCAL, ABS_DESCRI, TFI_PRODUT, B1_DESC, TEW_BAATD, TFI_PERINI, TFI_PERFIM "
cQuery += " FROM " + RetSQLName("TEW") + " TEW, " + RetSQLName("TFI") + " TFI, " + RetSQLName("SB1") + " SB1, " + RetSQLName("ABS") + " ABS "
cQuery += "	WHERE TEW_FILIAL  = '" + xFilial("TEW") + "' AND TEW.D_E_L_E_T_ = ' ' AND "
cQuery += "       TFI_FILIAL  = '" + xFilial("TFI") + "' AND TFI_COD = TEW_CODEQU AND TFI.D_E_L_E_T_ = ' ' AND "
cQuery += "	      B1_FILIAL   = '" + xFilial("SB1") + "' AND B1_COD = TFI_PRODUT AND SB1.D_E_L_E_T_ = ' ' AND "
cQuery += "	      ABS_FILIAL  = '" + xFilial("ABS") + "' AND ABS_LOCAL = TFI_LOCAL AND ABS.D_E_L_E_T_ = ' ' AND "
cQuery += "       TFI_PERINI >= '" + DToS(mv_par01) + "' AND TFI_PERFIM <= '" + DToS(mv_par02) + "' AND "
cQuery += " 	  TFI_PRODUT >= '" + mv_par03 + "' AND TFI_PRODUT <= '" + mv_par04 + "' AND "
cQuery += "	      TEW_BAATD  >= '" + mv_par05 + "' AND TEW_BAATD <= '" + mv_par06 + "' AND "
cQuery += " 	  TFI_LOCAL  >= '" + mv_par07 + "' AND TFI_LOCAL <= '" + mv_par08 + "' "
cQuery += " ORDER BY " + cExpOrder

cQuery := ChangeQuery(cQuery)

If Select("TRB") <> 0
	dbSelectArea("TRB")
	dbCloseArea()
EndIf

TCQuery cQuery New Alias "TRB"	

//Processamento do relatorio
dbSelectArea("TRB")
TRB->(dbGoTop())

oReport:SetMeter(RecCount())

While TRB->(!Eof())
	If oReport:Cancel()
		Exit
	EndIf
	
	oReport:Section(1):Init()

	If oReport:Section(1):GetOrder() == 1
		oReport:Section(1):Cell("CCODPROD"):SetValue(TRB->TFI_PRODUT)
		oReport:Section(1):Cell("CDESCPRD"):SetValue(TRB->B1_DESC)
	
	Else
		oReport:Section(1):Cell("CCODPOSTO"):SetValue(TRB->TFI_LOCAL)
		oReport:Section(1):Cell("CNOMEPOSTO"):SetValue(TRB->ABS_DESCRI)
	
	EndIf
	If !isBlind()
		oReport:Section(1):PrintLine()
	EndIF
	//Secao 2 - dados analiticos
	cKeyFiltro := TRB->&(cExpFiltro)
	oReport:Section(2):Init()
	While TRB->(!Eof()) .And. TRB->&(cExpFiltro) == cKeyFiltro
		oReport:IncMeter()
		
		If oReport:Section(1):GetOrder() == 1
			oReport:Section(2):Cell("CCODPOSTO"):SetValue(TRB->TFI_LOCAL)
			oReport:Section(2):Cell("CNOMEPOSTO"):SetValue(TRB->ABS_DESCRI)	
			oReport:Section(2):Cell("DDTINICIO"):SetValue(DToC(SToD(TRB->TFI_PERINI)))
			oReport:Section(2):Cell("DDTFIM"):SetValue(DToC(SToD(TRB->TFI_PERFIM)))
		
		Else
			oReport:Section(2):Cell("CCODPROD"):SetValue(TRB->TFI_PRODUT)
			oReport:Section(2):Cell("CDESCPRD"):SetValue(TRB->B1_DESC)
			oReport:Section(2):Cell("CNRSERIE"):SetValue(TRB->TEW_BAATD)
			oReport:Section(2):Cell("DDTINICIO"):SetValue(DToC(SToD(TRB->TFI_PERINI)))
			oReport:Section(2):Cell("DDTFIM"):SetValue(DToC(SToD(TRB->TFI_PERFIM)))
		
		EndIf
		If !isBlind()
			oReport:Section(2):PrintLine()
		EndIf
		TRB->(dbSkip())
	EndDo
	
	oReport:Section(2):Finish()
	oReport:Section(1):Finish()
EndDo

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return ReportPrint( oReport )

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg