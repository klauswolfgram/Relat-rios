/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER058
Relatório Eficiência de Entrega do Transportador

@sample 
U_GFER058()   

@author Alan Victor lamb
@since 07/06/13
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER058()
	Local oReport
	Local aArea := GetArea()
	
	Private cNome := "Relatório de Eficiência de Entrega dos Transportadores"
		
	If TRepInUse() // teste padrão 
		//-- Interface de impressao
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
	Local oReport	 := TReport():New("GFER058",cNome,"GFER058", {|oReport| ReportPrint(oReport)},cNome)
	Local aOrdem   := {}

	oReport:SetLandscape()    // define se o relatorio saira deitado
	oReport:HideParamPage()   // Desabilita a impressao da pagina de parametros.
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody	:= 10 // Define o tamanho da fonte.
	oReport:nLineHeight	:= 50 // Define a altura da linha.    
	oReport:NDEVICE := 4
	
	Pergunte("GFER058",.F.)
	
	Aadd(aOrdem,cNome)
	
	oSection1 := TRSection():New(oReport,cNome,{"(cAliasRep)"},aOrdem)
	TRCell():New(oSection1,"(cAliasRep)->GU3_CDEMIT","(cAliasRep)","Código Transportador","@!"            ,14,/*lPixel*/,)     
	TRCell():New(oSection1,"(cAliasRep)->GU3_NMEMIT","(cAliasRep)","Nome Transportador"  ,"@!"            ,14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_DOCTO","(cAliasRep)","Qtde de Documentos"   ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_PRAZO","(cAliasRep)","Qtde no Prazo"        ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->PCT_PRAZO","(cAliasRep)","% no Prazo"           ,"@E 999,999.99" ,14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_ATRAS","(cAliasRep)","Qtde Atrasadas"       ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->PCT_ATRAS","(cAliasRep)","% Atrasadas"          ,"@E 999,999.99" ,14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_ADIAN","(cAliasRep)","Qtde Adiantadas"      ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->QTD_PENDE","(cAliasRep)","Qtde Pendentes"       ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->TOT_ATRAS","(cAliasRep)","Atraso Total"         ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->MED_ATRAS","(cAliasRep)","Atraso Médio"         ,"@E 999,999.99" ,14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->TOT_DESVI","(cAliasRep)","Desvio Total"         ,"@E 999,999,999",14,/*lPixel*/,)
	TRCell():New(oSection1,"(cAliasRep)->MED_DESVI","(cAliasRep)","Desvio Médio"         ,"@E 999,999.99" ,14,/*lPixel*/,)
Return(oReport)

Static Function CriaTab()
	Local nCount
	Local aStruct := {}
	
	Local aRepFields
	Local aRepIndex
	Local cAliasRep
	
	aRepFields := ;
	{{"Cod Emit"	    ,"GU3_CDEMIT","C",TamSX3("GU3_CDEMIT")[1],0,"",1},;
	{"Desc Emit"	   	,"GU3_NMEMIT","C",TamSX3("GU3_NMEMIT")[1],0,"",1},;
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
	       nDesvioTot, nDesvioMed
	       
	Local cTmpGw1
	Local cAliasRep
	Local cFilIni   := MV_PAR01 // Filial de
	Local cFilFin   := MV_PAR02 // Filial até
	Local dDtEmIni  := MV_PAR03 // Data emissão inicial
	Local dDtEmFin  := MV_PAR04 // Data emissão final
	Local cTpDc     := MV_PAR05 // Tipo de documento
	Local dDtSaIni  := MV_PAR06 // Data saída inicial
	Local dDtSaFin  := MV_PAR07 // Data saída final
	Local dDtEntIni := MV_PAR08 // Data entrega inicial
	Local dDtEntFin := MV_PAR09 // Data entrega final
	Local cCdTrpIni := MV_PAR10 // Cod transportadora inicial
	Local cCdTrpFin := MV_PAR11 // Cod transportadora final
	Local cGrpTrp   := MV_PAR12 // Grupo transportador
	Local cUFDest   := MV_PAR13 // UF destinatário
	Local cRegGer   := MV_PAR14 // Região Gerencial
	Local cCodCid   := MV_PAR15 // Código cidade
	Local cCEPIni   := MV_PAR16 // CEP inicial
	Local cCEPFin   := MV_PAR17 // CEP final
	Local cCodDes   := MV_PAR18 // Codigo destinatário
	Local cGrpCli   := MV_PAR19 // Grupo cliente gerencial
	Local cSemDtPrv := MV_PAR20 // Entrega sem data prevista
	
	Local lContinua := .T.
	
	cAliasRep := CriaTab()
	
	dbSelectArea("GU3")
	GU3->(dbSetOrder(1))
	GU3->(dbGoTop())
	
	While GU3->(!Eof())
		// Verifica se é transportadora ou autonomo
		If (GU3->GU3_TRANSP == '1' .Or. GU3->GU3_AUTON == '1') .And.;
		    ((!Empty(cGrpTrp) .And. AllTrim(cGrpTrp) == AllTrim(GU3->GU3_CDGRGL)) .Or. ;
		    (Empty(cGrpTrp) .And. GU3->GU3_CDEMIT >= cCdTrpIni .And. GU3->GU3_CDEMIT <= cCdTrpFin)) // Valida grupo gerencial do transportador OU faixa de transportador 
			nQtdDocs      := 0
			nQtdNoPrazo   := 0
			nQtdAtrasados := 0
	        nQtdAdian  := 0
	        nQtdPend   := 0
	        nAtrasoTot := 0 
	        nAtrasoMed := 0
	        nDesvioTot := 0
	        nDesvioMed := 0
			cTmpGw1    := ""
			
			//Busca os trechos daquele transportador
			dbSelectArea("GWU")
			GWU->(dbSetOrder(5))
			If GWU->(dbSeek(GU3->GU3_CDEMIT))
				While GWU->(!Eof()) .And.;
				       GWU->GWU_CDTRP == GU3->GU3_CDEMIT
				       
				    // Só considera trechos a pagar
					If GWU->GWU_PAGAR == '1' .And.;
					   U_GFER058ENT(dDtEntIni, dDtEntFin, GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC)) .And. ;// Verifica Ultimo trecho
					   (Empty(cTpDc) .Or. GWU->GWU_CDTPDC == cTpDc) .And.; // Verificação parametro Tipo de Documento
					   AllTrim(GWU->GWU_FILIAL) >= AllTrim(cFilIni) .And. AllTrim(GWU->GWU_FILIAL) <= AllTrim(cFilFin) .And.;// Verificação faixa filiais
					   (((cSemDtPrv == 1 .And. !Empty(GWU->GWU_DTPENT))) .Or. cSemDtPrv != 1) // Desconsidera todas entregas sem data prevista
						dbSelectArea("GW1")
						GW1->(dbSetOrder(1))
						
						// 
						// Busca documento de carga
						// 
						If GW1->(dbSeek(GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC)))
							
							//Código Destinatário
							lContinua := Empty(cCodDes) .Or. AllTrim(GW1->GW1_CDDEST) == AllTrim(cCodDes)
							
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
								If lContinua .And. (!Empty(cCEPIni) .Or. !Empty(cCEPFin))
									If !(Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CEP") >= AllTrim(cCEPIni) .And.; //AllTrim pois o parâmetro possui 9 dígitos ao passo que o campo possui 8
										Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CEP") <= cCEPFin)
										lContinua := .F.
									EndIf
								EndIf
								
								//Grupo Cliente Gerencial
								If lContinua .And. !Empty(cGrpCli) .And. ;
									AllTrim(Posicione("GU3",1,xFilial("GU3")+GW1->GW1_CDDEST,"GU3_CDGRGL")) != AllTrim(cGrpCli)
									lContinua := .F.   
								EndIf
								
								RestArea(aArea)
							EndIf
							
							//
							// Verificação da data de emissão e data de saída
							//
							If lContinua .And. GW1->GW1_DTEMIS >= dDtEmIni .And. GW1->GW1_DTEMIS <= dDtEmFin .And.;
							   GW1->GW1_DTSAI >= dDtSaIni .And. GW1->GW1_DTSAI <= dDtSaFin
								If cTmpGw1 != GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC)
									// Incrementa o contador de documentos de carga do transportador
									nQtdDocs += 1
									cTmpGw1  := GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC)
								EndIf
								
								If Empty(GWU->GWU_DTENT)
									// Incrementa contador PENDENTES
									nQtdPend += 1
								ElseIf !Empty(GWU->GWU_DTPENT) .And. !Empty(GWU->GWU_DTENT) .And.;
								        GWU->GWU_DTENT > GWU->GWU_DTPENT
									// Incrementa contador ATRASADOS
									nQtdAtrasados += 1
									// Conta dias de atraso
									nAtrasoTot += GWU->GWU_DTENT - GWU->GWU_DTPENT
								ElseIf !Empty(GWU->GWU_DTPENT) .And. !Empty(GWU->GWU_DTENT) .And.;
								        GWU->GWU_DTENT < GWU->GWU_DTPENT
								    //Incrementa contador ADIANTADOS
								    nQtdAdian += 1
								    // Conta dias de adiantados
									nDesvioTot += GWU->GWU_DTPENT - GWU->GWU_DTENT
							    Else
								    //Incrementa contador no Prazo (inclusive sem data prevista)
								    nQtdNoPrazo += 1 
								EndIf
							EndIf
						EndIf
					EndIf
					GWU->(dbSkip())
				EndDo
			EndIf
			
			// Grava dados do Transportador na tabela temporária
			nDesvioTot += nAtrasoTot             // Desvios: Total Adiantamentos + Total Atrasos (Dias)
			nAtrasoMed := nAtrasoTot / nQtdDocs
			nDesvioMed := nDesvioTot / nQtdDocs
			
			RecLock(cAliasRep, .T.)
			(cAliasRep)->GU3_CDEMIT := GU3->GU3_CDEMIT
			(cAliasRep)->GU3_NMEMIT := GU3->GU3_NMEMIT
			(cAliasRep)->QTD_DOCTO  := nQtdDocs
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
		
		GU3->(dbSkip())
	EndDo
Return cAliasRep

Static Function ReportPrint(oReport)
	Local oSection1  := oReport:Section(1)
	
	cAliasRep := CarregaDados()
	
	dbSelectArea(cAliasRep)
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

//
// Verifica faixa da data de entrega do último trecho
//
User Function GFER058ENT(dDtEntIni, dDtEntFin, cChave)	
	Local aArea
	Local lRet := .F.
	
	If Empty(dDtEntIni) .And. Empty(dDtEntFin)
		lRet := .T.
	Else	
		dbSelectArea("GWU")
		aArea := GWU->(GetArea())
		GWU->(dbSetOrder(1))
		GWU->(dbSeek(cChave + "zz", .T.))
		GWU->(dbSkip(-1))
		
		While !GWU->(Bof()) .And.;
		       GWU->(GWU_FILIAL+GWU_CDTPDC+GWU_EMISDC+GWU_SERDC+GWU_NRDC) == cChave
			If GWU->GWU_PAGAR == '1'
				lRet := GWU_DTENT >= dDtEntIni .And. GWU_DTENT <= dDtEntFin
				Exit
			EndIf
			 
			GWU->(dbSkip(-1))
		EndDo
		
		RestArea(aArea)
	EndIf
Return lRet