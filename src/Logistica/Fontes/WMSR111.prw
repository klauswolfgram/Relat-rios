/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "WMSR111.CH"

//-----------------------------------------------------------
/*/{Protheus.doc} WMSR111
Rotina que permite gerar um relatório da busca de saldo para 
para o apanhe

@author  Flavio Luiz Vicco
@version	P11
@since   17/10/06 - revisão 18/09/14
/*/
//-----------------------------------------------------------
User Function WMSR111(aLogAux)
Local oReport
Private nOS := 2
Private nTB := 1
Private nED := 1
Private aLogSld := aLogAux
	If !SuperGetMv("MV_WMSNEW",.F.,.F.)
		Return WMSR110()
	EndIf

	If Type("aLogSld") != "A"
		Return Nil
	EndIf

	oReport := ReportDef()
	oReport:PrintDialog()
Return
//---------------------------------------------------------- 
// Definições do relatório
//---------------------------------------------------------- 
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3, oSection4, oSection5 := Nil
Local bRegraWms := Nil

	oReport  := TReport():New('WMSR111',STR0001,'',{|oReport| ReportPrint(oReport)},'') // Busca Saldo
	oReport:HideParamPage()
	oReport:SetLandscape(.T.)
	
	// 1=Lote;2=Nr de Serie;3=Data/Seq.Abastecimento;4=Data
	bRegraWms := {||,Iif(aLogSld[nOS,6]=="1",STR0002/*"Lote"*/,Iif(aLogSld[nOS,6]=="2",STR0003/*"Serie"*/,Iif(aLogSld[nOS,6]=="3",STR0004/*"Seq./Data"*/,Iif(aLogSld[nOS,6]=="4",STR0005/*"Data"*/,''))))}
	oSection1 := TRSection():New(oReport, STR0006) // Ordem de Serviço
	TRCell():New(oSection1,'DCF_CARGA' ,'DCF',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogSld[nOS,1]})
	TRCell():New(oSection1,'DCF_DOCTO' ,'DCF',,,,,{||,aLogSld[nOS,2]})
	TRCell():New(oSection1,'DCF_CODPRO','DCF',,,,,{||,aLogSld[nOS,3]})
	TRCell():New(oSection1,'B1_DESC'   ,'SB1',,,,,{||,aLogSld[nOS,4]})
	TRCell():New(oSection1,'DCF_QUANT' ,'DCF',,,,,{||,aLogSld[nOS,5]})
	TRCell():New(oSection1,'DCF_REGRA' ,'DCF',,,10,,bRegraWms)
	oSection1:SetHeaderBreak(.T.)
	oSection1:Cell('DCF_REGRA'):SetAutoSize(.T.)
	TRBreak():New(oSection1,{||oSection1:Cell('DCF_CARGA'):uPrint+oSection1:Cell('DCF_DOCTO'):uPrint+oSection1:Cell('DCF_CODPRO'):uPrint},STR0006,.F.,'DCF_QUEBRA',.F.) // Ordem de Serviço
	
	oSection2 := TRSection():New(oSection1, STR0025) // Dados do Produto
	TRCell():New(oSection2,'B1_COD','SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogSld[nOS,3]})
	oSection2:Cell("B1_COD"):Disable()
	TRCell():New(oSection2,'B1_UM','SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogSld[nOS,8,1,1]})
	TRCell():New(oSection2,'B1_SEGUM','SB1',,,,,{||,aLogSld[nOS,8,1,2]})
	TRCell():New(oSection2,'B1_CONV','SB1',,,,,{||,aLogSld[nOS,8,1,3]})
	TRCell():New(oSection2,'B1_TIPCONV','SB1',,,,,{||,aLogSld[nOS,8,1,4]})
	TRCell():New(oSection2,'B5_CODZON','SB5',,,,,{||,aLogSld[nOS,8,1,5]})
	TRCell():New(oSection2,'B5_WMSEMB','SB5',,,3,,{||,Iif( aLogSld[nOS,8,1,6] == "1",STR0027,STR0028)}) // Sim // Não
	TRCell():New(oSection2,'B5_UMIND','SB5',,,5,,{||,Iif( aLogSld[nOS,8,1,7] == "1",STR0029,STR0030)}) //1a UM // 2a UM
	TRCell():New(oSection2,'B5_CTRWMS','SB5',,,3,,{||,Iif( aLogSld[nOS,8,1,8] == "1",STR0027,STR0028)}) // Sim // Não
	TRCell():New(oSection2,'ENDERFIXOS','',STR0031,,,,{||,EnderFixos(aLogSld[nOS,3],aLogSld[nOS,9])}) // Endereços Fixos
	oSection2:Cell('ENDERFIXOS'):SetAutoSize(.T.)
	oSection2:SetHeaderBreak(.T.)
	TRBreak():New(oSection2,{||oSection1:Cell('DCF_CARGA'):uPrint+oSection1:Cell('DCF_DOCTO'):uPrint+oSection1:Cell('DCF_CODPRO'):uPrint},STR0006,.F.,'DCF_QUEBRA',.F.)

	oSection3 := TRSection():New(oSection1, STR0026,{"DC3","DC2"}) // Sequência de Abastecimento
	TRCell():New(oSection3,'DC3_CODPRO','DC3')
	oSection3:Cell("DC3_CODPRO"):Disable()
	TRCell():New(oSection3,'DC3_LOCAL','DC3')
	TRCell():New(oSection3,'DC3_ORDEM','DC3')
	TRCell():New(oSection3,'DC3_TPESTR','DC3')
	TRCell():New(oSection3,'DC3_CODNOR','DC3')
	TRCell():New(oSection3,'DC2_LASTRO','DC2')
	TRCell():New(oSection3,'DC2_CAMADA','DC2')
	TRCell():New(oSection3,'DC3_TIPREP','DC3')
	TRCell():New(oSection3,'DC3_PERREP','DC3')
	TRCell():New(oSection3,'DC3_PERAPM','DC3')
	TRCell():New(oSection3,'DC3_TIPSEP','DC3')
	TRCell():New(oSection3,'DC3_QTDUNI','DC3')
	TRCell():New(oSection3,'DC3_NUNITI','DC3')
	TRCell():New(oSection3,'DC3_EMBDES','DC3')
	TRCell():New(oSection3,'DC3_TIPEND','DC3')
	TRCell():New(oSection3,'DC3_PRIEND','DC3')
	TRCell():New(oSection3,'DC3_UMMOV','DC3')
	TRCell():New(oSection3,'DC3_ENDMIN','DC3')
	oSection3:SetHeaderBreak(.T.)
	TRBreak():New(oSection3,{||oSection1:Cell('DCF_CARGA'):uPrint+oSection1:Cell('DCF_DOCTO'):uPrint+oSection1:Cell('DCF_CODPRO'):uPrint},STR0006,.F.,'DCF_QUEBRA',.F.)

	oSection4 := TRSection():New(oSection2, STR0007) // Tipo Busca
	TRCell():New(oSection4,'TIP_BUSCA',,STR0007,'@#',100,,{||,aLogSld[nOS,7,nTB,1]}) // Tipo Busca
	oSection4:SetHeaderBreak(.T.)
	oSection4:Cell('TIP_BUSCA'):SetAutoSize(.T.)
	TRBreak():New(oSection4,oSection4:Cell('TIP_BUSCA'),STR0007,.F.,'TIP_BUSCA',.F.) // Tipo Busca
	
	oSection5 := TRSection():New(oSection4, STR0008) // Endereços
	TRCell():New(oSection5,'D14_ESTFIS','D14',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{||,aLogSld[nOS,7,nTB,2,nED,1]})
	TRCell():New(oSection5,'D14_ENDER' ,'D14',,,,,{||,aLogSld[nOS,7,nTB,2,nED,2]})
	TRCell():New(oSection5,'D14_LOTECT','D14',,,,,{||,aLogSld[nOS,7,nTB,2,nED,3]})
	TRCell():New(oSection5,'B8_DTVALID','SB8',,,,,{||,aLogSld[nOS,7,nTB,2,nED,4]})
	TRCell():New(oSection5,'D14_IDUNIT','D14',,,,,{||,aLogSld[nOS,7,nTB,2,nED,5]})
	TRCell():New(oSection5,'D14_QTDEST'  ,,STR0009,Posicione('SX3',2,'D14_QTDEST','X3_PICTURE'),TamSX3('D14_QTDEST')[1],,{||,aLogSld[nOS,7,nTB,2,nED,6]},'RIGHT') // Saldo D14
	TRCell():New(oSection5,'D14_QTDSPR'  ,,STR0014 ,Posicione('SX3',2,'D14_QTDEST','X3_PICTURE'),TamSX3('D14_QTDEST')[1],,{||,aLogSld[nOS,7,nTB,2,nED,7]},'RIGHT') // Saída RF
	TRCell():New(oSection5,'D14_QTDES2'  ,,STR0010 ,Posicione('SX3',2,'D14_QTDEST','X3_PICTURE'),TamSX3('D14_QTDEST')[1],,{||,aLogSld[nOS,7,nTB,2,nED,8]},'RIGHT') // Solicitado
	TRCell():New(oSection5,'D14_QTDEP2'  ,,STR0011 ,Posicione('SX3',2,'D14_QTDEST','X3_PICTURE'),TamSX3('D14_QTDEST')[1],,{||,aLogSld[nOS,7,nTB,2,nED,9]},'RIGHT') // Utilizado
	TRCell():New(oSection5,'D14_MSGINFO',,STR0012,'@#',50,,{||,aLogSld[nOS,7,nTB,2,nED,10]}) // Mensagem
	oSection5:Cell('D14_MSGINFO'):SetAutoSize(.T.)

Return(oReport)
//----------------------------------------------
// Impressão do relatório.
//----------------------------------------------
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oSection1:Section(1)
Local oSection3 := oSection1:Section(2)
Local oSection4 := oSection2:Section(1)
Local oSection5 := oSection4:Section(1)
Local nOS1      := 1
Local nTB1      := 1
Local nED1      := 1  
Local nSaldo    := 0
Local cMensagem := ""
Local cAliasDC3 := GetNextAlias()
Local oBrush    := TBrush():New(,CLR_HBLUE)

	oReport:SetMeter(Len(aLogSld))

	oSection1:Init()
	oSection2:Init()
	oSection3:Init()

	For nOS1 := 2 To Len(aLogSld)
		nOS := nOS1
		oSection1:PrintLine()
		oSection2:PrintLine()

		QueryDC3(oSection3,aLogSld[nOS1][3],aLogSld[nOS1][9],cAliasDC3)
		While (cAliasDC3)->(!Eof())
			oSection3:PrintLine()
			(cAliasDC3)->(DbSkip())
		EndDo

		oSection4:Init()
		For nTB1 := 1 To Len(aLogSld[nOS,7])
			nTB := nTB1
			oSection4:PrintLine()
			oSection5:Init()
			For nED1 := 1 To Len(aLogSld[nOS,7,nTB,2])
				nED := nED1
				// Se a linha atual trata-se de uma mensagem do reabastecimento, desconsidera a mesma
				If !aLogSld[nOS,7,nTB,2,nED,11]
					nSaldo := aLogSld[nOS,7,nTB,2,nED,8] - aLogSld[nOS,7,nTB,2,nED,9]
				EndIf
				oSection5:PrintLine()
			Next
			oSection5:Finish()
		Next
		oSection4:Finish()
		// Se sobrou saldo deste produto, deve imprimir uma mensagem
		If nSaldo > 0
			cMensagem := WmsFmtMsg(STR0013,{{"[VAR01]",aLogSld[nOS,3]},{"[VAR02]",Str(nSaldo)}}) // "Produto [VAR01] não foi totalmente atendido. Saldo restante: [VAR02]. Atenção! As movimentações desta OS foram estornadas."                
			oReport:PrintText(cMensagem,,,255)
		EndIf 
		oReport:FillRect({oReport:nRow,oReport:nCol,oReport:nRow+3,oReport:oPage:nHorzRes},oBrush)
		oReport:SkipLine(1)
		oReport:IncMeter()
	Next
	oSection3:Finish()
	oSection2:Finish()
	oSection1:Finish()

	(cAliasDC3)->(DbCloseArea())

	oReport:PrintText(STR0015) //Parâmetros Gerais Separação
	oReport:PrintText(STR0016+Iif(aLogSld[1,1],STR0023,STR0024)) //Reabastecimento único (MV_WMSMABP)? //Habilitado // Desabilitado
	oReport:PrintText(STR0017+Iif(aLogSld[1,2],STR0023,STR0024)) //Múltiplos pickings (MV_WMSMULP)? //Habilitado // Desabilitado 
	oReport:PrintText(STR0018+Iif(aLogSld[1,3],STR0023,STR0024)) //Novo WMS (MV_WMSNEW)? //Habilitado // Desabilitado 
	oReport:PrintText(STR0019+Iif(aLogSld[1,5],STR0023,STR0024)) //Picking master (MV_WMSPKMA)? //Habilitado // Desabilitado 
	oReport:PrintText(STR0020+Iif(aLogSld[1,6],STR0023,STR0024)) //Reinicia busca unitária (MV_WMSQTAP)? //Habilitado // Desabilitado
	oReport:PrintText(STR0021+Iif(aLogSld[1,7],STR0023,STR0024)) //Considera lotes vencidos (MV_LOTVENC)? //Habilitado // Desabilitado
	oReport:PrintText(STR0022+cValToChar(aLogSld[1,4])) //Limite pickings (MV_WMSNRPO)? //Habilitado // Desabilitado

	oBrush := Nil
Return

Static Function QueryDC3(oSection,cProduto,cLocal,cAliasDC3)
	oSection:BeginQuery()
	BeginSQL Alias cAliasDC3
		SELECT DC3.DC3_FILIAL,
			   DC3.DC3_LOCAL,
			   DC3.DC3_CODPRO,
			   DC3.DC3_REABAS,
			   DC3.DC3_ORDEM,
			   DC3.DC3_TPESTR,
			   DC3.DC3_CODNOR,
			   DC3.DC3_DESPIC,
			   DC3.DC3_TIPREP,
			   DC3.DC3_PERREP,
			   DC3.DC3_PERAPM,
			   DC3.DC3_TIPSEP,
			   DC3.DC3_QTDUNI,
			   DC3.DC3_NUNITI,
			   DC3.DC3_EMBDES,
			   DC3.DC3_TIPEND,
			   DC3.DC3_PRIEND,
			   DC3.DC3_UMMOV,
			   DC3.DC3_ENDMIN,
			   DC2.DC2_LASTRO,
			   DC2.DC2_CAMADA
		 FROM %Table:DC3% DC3
		INNER JOIN %Table:DC2% DC2
		   ON DC2.DC2_FILIAL = %xFilial:DC2%
		  AND DC2.DC2_CODNOR = DC3.DC3_CODNOR
		  AND DC2.%NotDel%
		WHERE DC3.DC3_FILIAL = %xFilial:DC3%
		  AND DC3.DC3_CODPRO = %Exp:cProduto%
		  AND DC3.DC3_LOCAL = %Exp:cLocal%
		  AND DC3.%NotDel%
	EndSql
	oSection:EndQuery()
Return

Static Function EnderFixos(cCodProd,cArmazem)
Local cAliasSBE := GetNextAlias()
Local cTexto := ""
Local nCount := 0

	BeginSql Alias cAliasSBE
		SELECT SBE.BE_LOCALIZ
		  FROM %Table:SBE% SBE
		 WHERE SBE.BE_FILIAL = %xFilial:SBE%
		   AND SBE.BE_CODPRO = %Exp:cCodProd%
		   AND SBE.BE_LOCAL = %Exp:cArmazem%
		   AND SBE.%NotDel%
	EndSql
	While (cAliasSBE)->(!EoF()) .And. nCount <= 4
		If Empty(cTexto)
			cTexto += Alltrim((cAliasSBE)->BE_LOCALIZ)
		Else
			cTexto += ", "+Alltrim((cAliasSBE)->BE_LOCALIZ)
		EndIf
		nCount++
		(cAliasSBE)->(DbSkip())
	EndDo
	If (cAliasSBE)->(!EoF())
		cTexto += " [...]"
	EndIf
	(cAliasSBE)->(DbCloseArea())
Return cTexto
