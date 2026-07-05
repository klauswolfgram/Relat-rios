/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "WMSR100.CH"
//------------------------------------------------------------------------------------------//
//-------------------------Rotina que permite gerar um relatório do-------------------------//
//--------------------------------Reabastecimento de Picking--------------------------------//
//------------------------------------------------------------------------------------------//
User Function WMSR100(aMsg)
	
	Local oReport	
	Private aMsgLog := aMsg
	Private nLin 	 := 1
		
	If FindFunction("TRepInUse") .And. TRepInUse() //Teste padrão
		//Interface de impressão
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return

//-------------------------------------------------------------------------------------//
//-------------------------Define as propriedades do relatório-------------------------//
//-------------------------------------------------------------------------------------//
Static Function ReportDef()

	Local oReport, oSection
		
	oReport 	:= TReport():New('WMSR100',STR0001,'',{|oReport| ReportPrint(oReport)},'')
	oReport:HideParamPage()
	
	oSection	:= TRSection():New(oReport,STR0001)
	TRCell():New(oSection,'BE_LOCALIZ','SBE',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aMsgLog[nLin,3]})
	TRCell():New(oSection,'B1_COD','SB1',,,,,{||,aMsgLog[nLin,4]})
	TRCell():New(oSection,'B1_DESC','SB1',,,,,{||,aMsgLog[nLin,5]})
	TRCell():New(oSection,STR0002,,,'@E 999999.99',9,,{||,aMsgLog[nLin,7]})
	TRCell():New(oSection,STR0003,,,'@E 999999.99',9,,{||,aMsgLog[nLin,8]})
	TRCell():New(oSection,STR0004,,,'@#',120,,{||,aMsgLog[nLin,9]})

Return(oReport)

//-------------------------------------------------------------------------------------------//
//-------------------------Executa a impressão da seção do relatório-------------------------//
//-------------------------------------------------------------------------------------------//
Static Function ReportPrint(oReport)
	
	Local oSection := oReport:Section(1)
	Local nCount
	
	oSection:Init()
	For nCount := 1 To Len(aMsgLog)
		oSection:PrintLine()
		nLin++
	Next
	oSection:Finish()
	
	oReport:IncMeter()
	
Return