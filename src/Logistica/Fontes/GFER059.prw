/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER059
Relatório Eficiência de Entrega do Embarcador

@sample   
U_GFER059()

@author Alan Victor lamb
@since 07/06/13 
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER059()
	Local oReport
	Local aArea := GetArea()
	
	Private cNome := "Relatório de Eficiência de Entrega das Filiais"
	
	If TRepInUse() // teste padrão 
		//-- Interface de impressao --//
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Monta a estrutura do relatório

@sample

@author Alan Victor Lamb
@since 07/06/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
	Local oReport	 := TReport():New("GFER059",cNome,"GFER059", {|oReport| ReportPrint(oReport)},cNome)
	Local aOrdem   := {}

	oReport:SetLandscape()    // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	oReport:nLineHeight := 50 // Define a altura da linha.    
	oReport:NDEVICE := 4
	
	Pergunte("GFER059",.F.)
	
	Aadd(aOrdem,cNome)
	
	oSection1 := TRSection():New(oReport,cNome,{"(cAliasRep)"},aOrdem)
	TRCell():New(oSection1,"(cAliasRep)->CODFIL","(cAliasRep)","Código Filial","@!",14,/*lPixel*/,)     
	TRCell():New(oSection1,"(cAliasRep)->FILIAL","(cAliasRep)","Razão Social Filial","@!",25,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_TRECH","(cAliasRep)","Qtde de Trechos","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_DOCTO","(cAliasRep)","Qtde de Documentos","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_PRAZO","(cAliasRep)","Qtde no Prazo","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->PCT_PRAZO","(cAliasRep)","% no Prazo","@E 999.99",14,/*lPixel*/,) 
	TRCell():New(oSection1,"(cAliasRep)->QTD_ATRAS","(cAliasRep)","Qtde Atrasadas","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->PCT_ATRAS","(cAliasRep)","% Atrasadas","@E 999.99",14,/*lPixel*/,) 
	TRCell():New(oSection1,"(cAliasRep)->QTD_ADIAN","(cAliasRep)","Qtde Adiantadas","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_PENDE","(cAliasRep)","Qtde Pendentes","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->TOT_ATRAS","(cAliasRep)","Atraso Total","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->MED_ATRAS","(cAliasRep)","Atraso Médio","@E 999.99",14,/*lPixel*/,) 
	TRCell():New(oSection1,"(cAliasRep)->TOT_DESVI","(cAliasRep)","Desvio Total","@!",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->MED_DESVI","(cAliasRep)","Desvio Médio","@E 999.99",14,/*lPixel*/,)
Return(oReport)

Static Function CriaTab()
	Local nCount
	Local aStruct := {}
	
	Local aRepFields
	Local aRepIndex
	Local cAliasRep
	
	aRepFields := ;
	{{"Cod Fil"	      ,"CODFIL","C",14,0,"",1},;
	{"Razão Soc"	  ,"FILIAL","C",25,0,"@!",1},;
	{"Qtde trechos"   ,"QTD_TRECH","N",15,0,"",1},;
	{"Qtde doc carga" ,"QTD_DOCTO","N",15,0,"",1},;
	{"Qtde no prazo"  ,"QTD_PRAZO" ,"N",15,0,"",1},;
	{"% no prazo","PCT_PRAZO" ,"N",10,2,"",1},;
	{"Qtde atrasado"  ,"QTD_ATRAS" ,"N",15,0,"",1},;
	{"% atrasado","PCT_ATRAS" ,"N",10,2,"",1},;
	{"Qtde adiantado" ,"QTD_ADIAN" ,"N",15,0,"",1},;
	{"Qtde pendente"  ,"QTD_PENDE" ,"N",15,0,"",1},;
	{"Total atrasos"  ,"TOT_ATRAS" ,"N",15,0,"",1},;
	{"Média atrasos"  ,"MED_ATRAS" ,"N",12,2,"",1},;
	{"Desvio total"   ,"TOT_DESVI","N",15,0,"",2},;
	{"Desvio médio"   ,"MED_DESVI","N",12,2,"",2}}
	
	
	aRepIndex := {"DESCEND(QTD_DOCTO)"}	
	For nCount := 1 To Len(aRepFields)
		aADD(aStruct,{aRepFields[nCount][2],;  //Nome do campo
						aRepFields[nCount][3],;  //Tipo
						aRepFields[nCount][4],;  //Tamanho
						aRepFields[nCount][5]}) //Decimal
	Next nCont
	
	cAliasRep := GFECriaTab({aStruct,aRepIndex})
Return cAliasRep

Static Function CarregaDados()
	Local nQtdDocs, nQtdNoPrazo, nQtdAtrasados,;
	       nQtdAdian, nQtdPend, nAtrasoTot, nAtrasoMed,;
	       nDesvioTot, nDesvioMed, nQtdTrecho
	       
	Local dDtEnt
	Local cAliasRep
	Local cFilIni   := MV_PAR01 // Filial de
	Local cFilFin   := MV_PAR02 // Filial até
	Local dDtEmIni  := MV_PAR03 // Data emissão inicial
	Local dDtEmFin  := MV_PAR04 // Data emissão final
	Local cTpDc     := MV_PAR05 // Tipo de documento
	Local dDtSaIni  := MV_PAR06 // Data saída inicial
	Local dDtSaFin  := MV_PAR07 // Data saída final
	Local cUFDest   := MV_PAR08 // UF destinatário
	Local cRegGer   := MV_PAR09 // Região Gerencial
	Local cCodCid   := MV_PAR10 // Código cidade
	Local cCEPIni   := MV_PAR11 // CEP inicial
	Local cCEPFin   := MV_PAR12 // CEP final
	Local cCodDes   := MV_PAR13 // Codigo destinatário
	Local cGrpCli   := MV_PAR14 // Grupo cliente gerencial
	Local cSemDtPrv := MV_PAR15 // Entrega sem data prevista
	
	Local lContinua := .T.
	
	// Array para retornar as informações das filiais
	// [1] - M0_CODIGO
	// [2] - M0_CODFIL
	// [7] - M0_FILIAL
	Local aDispFil  := FWLoadSM0()
	Local nX
	
	cAliasRep := CriaTab()
	
	For nX := 1 To Len(aDispFil)
		If AllTrim(aDispFil[nX][2]) >= AllTrim(cFilIni) .And. AllTrim(aDispFil[nX][2]) <= AllTrim(cFilFin) .And. AllTrim(aDispFil[nX][1]) == cEmpAnt // Verificação da Faixa de filiais
			nQtdDocs      := 0
			nQtdNoPrazo   := 0
			nQtdAtrasados := 0
			nQtdAdian  	  := 0
			nQtdPend   	  := 0
			nAtrasoTot 	  := 0 
			nAtrasoMed 	  := 0
			nDesvioTot 	  := 0
			nDesvioMed 	  := 0
			nQtdTrecho 	  := 0
			cTmpGw1    	  := ""
		    
			GW1->(dbSetOrder(1))
			GW1->(dbSeek(Substr(aDispFil[nX][2], 1, FWSizeFilial())))
			
			//Verificação data de emissão e data de saída
			While !GW1->(Eof()) .And. GW1->GW1_FILIAL == Substr(aDispFil[nX][2], 1, FWSizeFilial())
				
				If GW1->GW1_DTEMIS >= dDtEmIni .And. GW1->GW1_DTEMIS <= dDtEmFin .And.;
				   GW1->GW1_DTLIB >= dDtSaIni .And. GW1->GW1_DTLIB <= dDtSaFin .And.;
				   (Empty(cTpDc) .Or. GW1->GW1_CDTPDC == cTpDc) .And.; // Verificação parametro Tipo de Documento
				   (((cSemDtPrv == 1 .And. !Empty(GW1->GW1_DTPENT))) .Or. cSemDtPrv != 1) // Desconsiderar/No prazo docs sem data prevista
				   
				   //Código Destinatário
				   lContinua := Empty(cCodDes) .Or. GW1->GW1_CDDEST == cCodDes 
				   
				   If lContinua
						aArea := GU3->(GetArea())
						
						// UF destino
						If !Empty(cUFDest) .And. ;
							AllTrim(Posicione("GU7",1,XFILIAL("GU7")+Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_NRCID"),"GU7_CDUF")) != AllTrim(cUFDest)
							lContinua := .F.   
						EndIf 
						
						// Cod Cidade
						If lContinua .And. !Empty(cCodCid) .And. ;
						   AllTrim(Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_NRCID")) != AllTrim(cCodCid)
							lContinua := .F.   
						EndIf 
						
						//Região Gerencial
						If !Empty(cRegGer) .And. ;
							AllTrim(Posicione("GU7",1,XFILIAL("GU7")+Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_NRCID"),"GU7_REGREL")) != AllTrim(cRegGer)
							lContinua := .F.
						EndIf 
						
						// Faixa CEP
						If lContinua .And. !Empty(cCEPIni) .And. !Empty(cCEPFin) .And. ;
						   !(Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CEP") >= cCEPIni .And.;
						   Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CEP") <= cCEPFin)
							lContinua := .F.   
						EndIf 
						
						//Grupo Cliente Gerencial
						If lContinua .And. !Empty(cGrpCli) .And. ;
						   AllTrim(Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CDGRGL")) != AllTrim(cGrpCli)
							lContinua := .F.   
						EndIf
						
						RestArea(aArea)
					EndIf
				    
				    If lContinua
					    // Incrementa o contador de documentos de carga do Embarcador
						nQtdDocs += 1
						nQtdTrecho += CountGWU(GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC))
						dDtEnt := U_GFER059DTE(GW1->(GW1_FILIAL+GW1_CDTPDC+GW1_EMISDC+GW1_SERDC+GW1_NRDC))
							
						If Empty(dDtEnt)
							// Incrementa contador PENDENTES
							nQtdPend += 1
						ElseIf !Empty(GW1->GW1_DTPENT) .And. !Empty(dDtEnt) .And.;
						        dDtEnt > GW1->GW1_DTPENT
							// Incrementa contador ATRASADOS
							nQtdAtrasados += 1
							// Conta dias de atraso
							nAtrasoTot += dDtEnt - GW1->GW1_DTPENT
						ElseIf !Empty(GW1->GW1_DTPENT) .And. !Empty(dDtEnt) .And.;
						        dDtEnt < GW1->GW1_DTPENT
						    //Incrementa contador ADIANTADOS
						    nQtdAdian += 1
						    // Conta dias de adiantados
							nDesvioTot += GW1->GW1_DTPENT - dDtEnt
						Else
						    //Incrementa contador no Prazo (inclusive sem data prevista)
						    nQtdNoPrazo += 1 
						EndIf
					EndIf
				EndIf
				
				GW1->(dbSkip())
			EndDo
		
			// Grava dados do Embarcador na tabela temporária
			nDesvioTot += nAtrasoTot             // Desvios: Total Adiantamentos + Total Atrasos (Dias)
			nAtrasoMed := nAtrasoTot / nQtdDocs
			nDesvioMed := nDesvioTot / nQtdDocs
			
			RecLock(cAliasRep, .T.)
				(cAliasRep)->CODFIL  	:= aDispFil[nX][2]
				(cAliasRep)->FILIAL  	:= aDispFil[nX][7]
				(cAliasRep)->QTD_DOCTO  := nQtdDocs
				(cAliasRep)->QTD_TRECH  := nQtdTrecho
				(cAliasRep)->QTD_PRAZO  := nQtdNoPrazo
				(cAliasRep)->PCT_PRAZO  := nQtdNoPrazo / nQtdDocs * 100
				(cAliasRep)->QTD_ATRAS  := nQtdAtrasados
				(cAliasRep)->PCT_ATRAS  := nQtdAtrasados / nQtdDocs * 100
				(cAliasRep)->QTD_ADIAN  := nQtdAdian
				(cAliasRep)->QTD_PENDE  := nQtdPend
				(cAliasRep)->TOT_ATRAS  := nAtrasoTot
				(cAliasRep)->MED_ATRAS  := nAtrasoMed
				(cAliasRep)->TOT_DESVI  := nDesvioTot
				(cAliasRep)->MED_DESVI  := nDesvioMed
			MsUnlock(cAliasRep)
		EndIf
		
	Next nX
Return cAliasRep

Static Function CountGWU(cChave)
	Local nRet := 0
	Local aArea
	
	aArea := GWU->(GetArea())
	
	GWU->(dbSetOrder(1))
	
	If GWU->(dbSeek(cChave))
		While !GWU->(Eof()) .And.;
		       GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC) == cChave
		       
			If GWU->GWU_PAGAR == '1'
				nRet += 1
			EndIf
			
			GWU->(dbSkip())
		EndDo
	EndIf
		
	RestArea(aArea)
Return nRet

//
// Retorna a data de entrega do último trecho pago de um doc carga
//
User Function GFER059DTE(cChave)	
	Local aArea
	Local dData
	
	aArea := GWU->(GetArea())
	
	GWU->(dbSetOrder(1))
	GWU->(dbSeek(cChave + "zz", .T.))
	GWU->(dbSkip(-1))
	
	While !GWU->(Bof()) .And.;
	       GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC) == cChave
		If GWU->GWU_PAGAR == '1'
			dData := GWU->GWU_DTENT
			Exit
		EndIf
		
		GWU->(dbSkip(-1))
	EndDo
	
	RestArea(aArea)
	
Return dData

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	
	cAliasRep := CarregaDados()
	
	oReport:SetMeter((cAliasRep)->(LastRec()))
	
	(cAliasRep)->(dbGoTop())
	
	oSection1:Init()
	While (cAliasRep)->(!Eof())
	    oReport:IncMeter()
		oSection1:PrintLine()
		(cAliasRep)->(dbSkip())
	EndDo
   
	oSection1:Finish()
	
	GFEDelTab(cAliasRep)
Return 