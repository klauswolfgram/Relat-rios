/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER163
	
@author siegklenes.beulke
@since 16/10/2013
@version 1.0

@description
Relatório de Negociações com Frota Dedicada 

-------------------------------------------------------------*/

User Function GFER163()
	Local oReport
	Local aArea := GetArea()
	Private cAliTransp	
	Private cAliNeg
	Private cAliTpVc

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	GfeDelTab(cAliTransp)	
	GfeDelTab(cAliNeg)
	GfeDelTab(cAliTpVc)	
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 16/10/2013
@return oReport Objeto do Relatorio.

/*/
//--------------------------------------------------------------------------------------------------------

Static Function ReportDef()
	Local oReport 
	Local oSection
	Local oSection2
	
	//+------------------------------------------------------------------------+
//| "Criacao do componente de impressao                                      | "
//| "                                                                        | "
//| "TReport():New                                                           | "
//| "ExpC1 : Nome do relatorio                                               | "
//| "ExpC2 : Titulo                                                          | "
//| "ExpC3 : Pergunte                                                        | "
//| "ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  | "
//| "ExpC5 : Descricao                                                       | "
//| "                                                                        | "
//+------------------------------------------------------------------------+
																	
	oReport := TReport():New("GFER163","Negociações Frota Dedicada","GFER163", {|oReport| ReportPrint(oReport)},"Emite Relatório de Utilização de Veículos por Transportador."/*Descricao do relatório*/)
	oReport:SetLandscape(.T.)   //Define a oriadmientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	oReport:HideParamPage() //Oculta página de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)  
	EndIf
	
//+------------------------------------------------------------------------+
//|Criacao da celulas da secao do relatorio                                |
//|                                                                        |
//|TRCell():New                                                            |
//|ExpO1 : Objeto TSection que a secao pertence                            |
//|ExpC2 : Nome da celula do relatório. O SX3 será consultado              |
//|ExpC3 : Nome da tabela de referencia da celula                          |
//|ExpC4 : Titulo da celula                                                |
//|        Default : X3Titulo()                                            |
//|ExpC5 : Picture                                                         |
//|        Default : X3_PICTURE                                            |
//|ExpC6 : Tamanho                                                         |
//|        Default : X3_TAMANHO                                            |
//|ExpL7 : Informe se o tamanho esta em pixel                              |
//|        Default : False                                                 |
//|ExpB8 : Bloco de código para impressao.                                 |
//|        Default : ExpC2                                                 |
//|                                                                        |
//+------------------------------------------------------------------------+
//	GetSx3Inf @return aRetorno Array {cTitulo,cCbox,cPicture}
	//TRCell():New(oSection,/*X3_CAMPO*/,/*Tabela*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	CriaTabTemp()
	oSection := TRSection():New(oReport,"Transportador",{"(cAliTransp)","GU3","GV9"},{"Transportador"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	TRCell():New(oSection,"(cAliTransp)->GV9_CDEMIT","GV9","Código do Transportador",GetSx3Inf("GV9_CDEMIT")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->GV9_DSTRP","GV9","Nome do Transportador",GetSx3Inf("GU3_NMEMIT")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection,"(cAliTransp)->QTDROMAN","GWN","Qtde Romaneios","999999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->QTDVEIC","GWN","Qtde Veículos","999999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->VLRFRETE","GWN","Valor Frete","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->VLRFECHAM","GWN","Valor Fechamento","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		
	oSection2 := TRSection():New(oSection,"Negociações",{"GWG","GV9","GV7","(cAliNeg)"},{"Negociações"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection2:SetTotalInLine(.T.)
	
	TRCell():New(oSection2,"(cAliNeg)->GWG_NRTAB","(cAliNeg)","Tabela",GetSx3Inf("GWG_NRTAB")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliNeg)->GWG_NRNEG","(cAliNeg)","Nr Negociação",GetSx3Inf("GWG_NRNEG")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->GWG_CDTPOP","(cAliNeg)","Tipo Operação",GetSx3Inf("GWG_CDTPOP")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->GWG_CDCLFR","(cAliNeg)","Classificação de Frete",GetSx3Inf("GWG_CDCLFR")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->GV7_VLALUG","(cAliNeg)","Locação",GetSx3Inf("GV7_VLALUG")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->GV7_FRQKM","(cAliNeg)","Franquia",GetSx3Inf("GV7_FRQKM")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->GV7_QTCOTA","(cAliNeg)","Cota",GetSx3Inf("GV7_QTCOTA")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliNeg)->QTDROMAN","(cAliNeg)","Qtde Romaneios","999999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliNeg)->QTDVEIC","GWN","Qtde Veículos","999999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliNeg)->VLRFRETE","GWN","Valor Frete","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliNeg)->VLRFECHAM","GWN","Valor Fechamento","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	oSection3 := TRSection():New(oSection,"Tipo de Veículo",{"GWG","(cAliTpVc)"},{"Veículos"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection3:SetTotalInLine(.T.)
	
	TRCell():New(oSection3,"(cAliTpVc)->GWG_CDTPVC","(cAliTpVc)","Tipo de Veículo",GetSx3Inf("GWG_CDTPVC")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"(cAliTpVc)->QTDROMAN","(cAliTpVc)","Qtde Romaneios","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection3,"(cAliTpVc)->QTDVEIC","(cAliTpVc)","Qtde Veículos","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection3,"(cAliTpVc)->VLRFRETE","GWN","Valor Frete","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"(cAliTpVc)->VLRFECHAM","GWN","Valor Fechamento","@E 999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
		
Return oReport

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author Siegklenes.beulke
@version 1.0
@since 12/09/2013
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local oSection3  := oReport:Section(1):Section(2)
	Local aRomanCont := {} // romaneios que foram testados
	Local aContRoman := {}
	Local aVlNeg := {} //faixas do transportador 
	Local nRoman := 0
	Local nQtVeic := 0
	Local nVlfFech := 0
	Local nCalc := 0
	Local lFiltroGWN := .F.
	Local cFilRom := Nil
	Local cNrRom  := Nil
	
	/* Pergunte
		01 Filial de 
		02 Filial ate
		03 Cod Transp / Cod Transportador romaneio (transportadores)
		04 Vigente em / Vigencia da tabela(gv9)
		05 Data Criacao de / Do Romaneio
		06 Data Criacao ate / Do Romaneio
		07 Data Saida de / Do Romaneio
		08 Data Saida ate / Do Romaneio
		09 Data Cálc Fret de / Do Romaneio
		10 Data Cálc Fret ate / Do Romaneio
		11 Data Fechament de/ Do Romaneio
		12 Data Fechament ate / Do Romaneio
		13 Tipo Operação / Do romaneio
		GV9_TPLOTA == "3"
	*/
		
	dbSelectArea("GW1")
	GW1->(dbSetOrder(1))
	dbSelectArea("GWH")
	GWH->(dbSetOrder(1))
	dbSelectArea("GWN")
	GWN->(dbSetOrder(1))
	dbSelectArea("GWF")
	GWF->(dbSetOrder(1))
	dbSelectArea("GWG")
	GWG->(dbSetOrder(2))	
	dbSelectarea("GU3")
	GU3->(dbSetOrder(1))
	dbSelectarea("GV7")
	GV7->(dbSetOrder(1))
	dbSelectArea("GV9")
	GV9->(dbSetOrder(1))
	GV9->(dbGoTop())
	
	While !GV9->(Eof())
		If 	GV9->GV9_TPLOTA == "3" .And. GV9->GV9_DTVALI <= MV_PAR04 .And. (GV9->GV9_DTVALF >= MV_PAR05 .Or. Empty(GV9->GV9_DTVALF))		
			If !(cAliTransp)->(dbSeek(GV9->GV9_CDEMIT))
				RecLock(cAliTransp,.T.)
				(cAliTransp)->GV9_CDEMIT := GV9->GV9_CDEMIT
				(cAliTransp)->GV9_DSTRP	 := Posicione("GU3",1,xFilial("GU3") + GV9->GV9_CDEMIT,"GU3_NMEMIT")
				(cAliTransp)->FILTROGWN  := .F.
				lFiltroGWN := .F.
				MsUnlock(cAliTransp)
			EndIf
			If GWG->(dbSeek(xFilial("GWG") + GV9->GV9_CDEMIT + GV9->GV9_NRTAB + GV9->GV9_NRNEG))
				While !GWG->(Eof()) .And. xFilial("GWG") + GV9->GV9_CDEMIT + GV9->GV9_NRTAB + GV9->GV9_NRNEG == GWG->GWG_FILIAL + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG
					If (cAliNeg)->(dbSeek(GWG->GWG_CDEMIT+GWG->GWG_NRTAB+GWG->GWG_NRNEG))
						RecLock(cAliNeg,.F.)
					Else
						RecLock(cAliNeg,.T.)
						(cAliNeg)->GV9_CDEMIT	:= GWG->GWG_CDEMIT
						(cAliNeg)->GWG_NRTAB		:= GWG->GWG_NRTAB
						(cAliNeg)->GWG_NRNEG		:= GWG->GWG_NRNEG
						(cAliNeg)->GWG_CDTPOP	:= GV9->GV9_CDTPOP
						(cAliNeg)->GWG_CDCLFR	:= GV9->GV9_CDCLFR						
					EndIf
					If GWF->(dbSeek(GWG->GWG_FILIAL + GWG->GWG_NRCALC))
						While !GWF->(Eof()) .And. GWG->GWG_FILIAL + GWG->GWG_NRCALC == GWF->GWF_FILIAL + GWF->GWF_NRCALC
							If GWF->GWF_ORIGEM $ '1;2'
								If GFXCP1212210('GWF_FILROM')
									cFilRom := GWF->GWF_FILROM
								Else
									cFilRom := GWF->GWF_FILIAL
								EndIf
								cNrRom  := GWF->GWF_NRROM
								If GWN->(dbSeek(cFilRom + cNrRom)) ;
									.And. GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
									.And. (Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
									.And. GWN->GWN_DTIMPL >= MV_PAR05 .And. GWN->GWN_DTIMPL <= MV_PAR06 ;
									.And. GWN->GWN_DTSAI >= MV_PAR07 .And. GWN->GWN_DTSAI <= MV_PAR08 ;
									.And. GWN->GWN_DTCALC >= MV_PAR09 .And. GWN->GWN_DTCALC <= MV_PAR10 ;
									.And. GWN->GWN_DTFECH >= MV_PAR11 .And. GWN->GWN_DTFECH <= MV_PAR12 ;
									.And. (Empty(MV_PAR13) .Or. GWN->GWN_CDTPOP == MV_PAR13)
									lFiltroGWN:= .T.
									If aScan(aContRoman,{|x| x == GWN->GWN_FILIAL + GWN->GWN_NRROM }) == 0
										aAdd(aContRoman,GWN->GWN_FILIAL + GWN->GWN_NRROM)
										nRoman += 1
										If !Empty(GWN->GWN_PLACAD)
											nQtVeic += 1
										EndIf
									EndIf
									nCalc +=VLTOTFRET()
								EndIf								
							Else
								If GWH->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC))
									While !GWH->(Eof()) .And. GWF->GWF_FILIAL + GWF->GWF_NRCALC == GWH->GWH_FILIAL + GWH->GWH_NRCALC
										If GW1->(dbSeek(GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC))
											While !GW1->(Eof()) .And. GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC == GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC
												If GFXCP1212210('GW1_FILROM')
													cFilRom := GW1->GW1_FILROM
												Else
													cFilRom := GW1->GW1_FILIAL
												EndIf
												cNrRom := GW1->GW1_NRROM
												If GWN->(dbSeek(cFilrom + cNrRom)) ;
													.And. GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
													.And. (Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
													.And. GWN->GWN_DTIMPL >= MV_PAR05 .And. GWN->GWN_DTIMPL <= MV_PAR06 ;
													.And. GWN->GWN_DTSAI >= MV_PAR07 .And. GWN->GWN_DTSAI <= MV_PAR08 ;
													.And. GWN->GWN_DTCALC >= MV_PAR09 .And. GWN->GWN_DTCALC <= MV_PAR10 ;
													.And. GWN->GWN_DTFECH >= MV_PAR11 .And. GWN->GWN_DTFECH <= MV_PAR12 ;
													.And. (Empty(MV_PAR13) .Or. GWN->GWN_CDTPOP == MV_PAR13)
													lFiltroGWN:= .T.
													If aScan(aContRoman,{|x| x == GWN->GWN_FILIAL + GWN->GWN_NRROM }) == 0
														aAdd(aContRoman,GWN->GWN_FILIAL + GWN->GWN_NRROM)
														nRoman += 1
														If !Empty(GWN->GWN_PLACAD)
															nQtVeic += 1						
														EndIf
													EndIf
													nVlfFech +=VLTOTFRET()
												EndIf
												GW1->(dbSkip())
											EndDo
										EndIf
										GWH->(dbSkip())
									EndDo
									
								EndIf
							EndIf							
							GWF->(dbSkip())
						EndDo
					EndIf
					GV7->(dbSetOrder(1))
					If GV7->(dbSeek(xFilial("GV7") + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG))
						While !GV7->(Eof()) .And. xFilial("GV7") + GV7->GV7_CDEMIT + GV7->GV7_NRTAB + GV7->GV7_NRNEG == xFilial("GV7") + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG
							If aScan(aVlNeg,{|x| x == xFilial("GV7") + GV7->GV7_CDEMIT + GV7->GV7_NRTAB + GV7->GV7_NRNEG + GV7->GV7_CDFXTV}) == 0
								(cAliNeg)->GV7_VLALUG += GV7->GV7_VLALUG
								(cAliNeg)->GV7_FRQKM += GV7->GV7_FRQKM
								(cAliNeg)->GV7_QTCOTA += GV7->GV7_QTCOTA
								aAdd(aVlNeg,xFilial("GV7") + GV7->GV7_CDEMIT + GV7->GV7_NRTAB + GV7->GV7_NRNEG + GV7->GV7_CDFXTV)
							EndIf	
							GV7->(dbSkip())
						EndDo
					EndIf
					(cAliNeg)->QTDROMAN += nRoman
					(cAliNeg)->QTDVEIC += nQtVeic
					(cAliNeg)->VLRFRETE += nCalc
					(cAliNeg)->VLRFECHAM += nVlfFech
					MsUnLock(cAliNeg)
					
					RecLock(cAliTransp,.F.)
					(cAliTransp)->QTDROMAN += nRoman
					(cAliTransp)->QTDVEIC += nQtVeic
					(cAliTransp)->VLRFRETE += nCalc
					(cAliTransp)->VLRFECHAM += nVlfFech
					(cAliTransp)->FILTROGWN := lFiltroGWN
					MsUnlock(cAliTransp)
					
					nRoman := nQtVeic := nCalc := nVlfFech := 0					
					
					If (cAliTpVc)->(dbSeek(GWG->GWG_CDEMIT+GWG->GWG_CDTPVC))
						RecLock(cAliTpVc,.F.)
					Else
						RecLock(cAliTpVc,.T.)
						(cAliTpVc)->GWG_CDEMIT := GWG->GWG_CDEMIT
						(cAliTpVc)->GWG_CDTPVC := GWG->GWG_CDTPVC
					EndIf
					GV7->(dbSetOrder(2))

					If GV7->(dbSeek(xFilial("GV7") + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG))
						While !GV7->(Eof()) .And. xFilial("GV7") + GV7->GV7_CDEMIT + GV7->GV7_NRTAB + GV7->GV7_NRNEG == xFilial("GV7") + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG
							If GV7->GV7_CDTPVC == GWG->GWG_CDTPVC
								If GWF->(dbSeek(GWG->GWG_FILIAL + GWG->GWG_NRCALC))
									While !GWF->(Eof()) .And. GWG->GWG_FILIAL + GWG->GWG_NRCALC == GWF->GWF_FILIAL + GWF->GWF_NRCALC
										If GWF->GWF_ORIGEM $ '1;2'
											If GFXCP1212210('GWF_FILROM')
												cFilRom := GWF->GWF_FILROM
											Else
												cFilRom := GWF->GWF_FILIAL
											EndIf
											cNrRom := GWF->GWF_NRROM
											If GWN->(dbSeek(cFilRom + cNrRom));
												.And. GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
												.And. (Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
												.And. GWN->GWN_DTIMPL >= MV_PAR05 .And. GWN->GWN_DTIMPL <= MV_PAR06 ;
												.And. GWN->GWN_DTSAI >= MV_PAR07 .And. GWN->GWN_DTSAI <= MV_PAR08 ;
												.And. GWN->GWN_DTCALC >= MV_PAR09 .And. GWN->GWN_DTCALC <= MV_PAR10 ;
												.And. GWN->GWN_DTFECH >= MV_PAR11 .And. GWN->GWN_DTFECH <= MV_PAR12 ;
												.And. (Empty(MV_PAR13) .Or. GWN->GWN_CDTPOP == MV_PAR13)
												lFiltroGWN := .T.
												If aScan(aRomanCont,{|x| x == GWN->GWN_FILIAL + GWN->GWN_NRROM }) == 0
													aAdd(aRomanCont,GWN->GWN_FILIAL + GWN->GWN_NRROM)
													nRoman += 1
													If !Empty(GWN->GWN_PLACAD)
														nQtVeic += 1
													EndIf
												EndIf
												nCalc +=VLTOTFRET()
											EndIf
										Else //apuração periodo
											If GWH->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC))
												While !GWH->(Eof()) .And. GWF->GWF_FILIAL + GWF->GWF_NRCALC == GWH->GWH_FILIAL + GWH->GWH_NRCALC
													If GW1->(dbSeek(GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC))
														While !GW1->(Eof()) .And. GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC == GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC
															If GFXCP1212210('GW1_FILROM')
																cFilRom := GW1->GW1_FILROM
															Else
																cFilRom := GW1->GW1_FILIAL
															EndIf
															cNrRom := GW1->GW1_NRROM
															If GWN->(dbSeek(cFilRom + cNrRom));
																.And. GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
																.And. (Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
																.And. GWN->GWN_DTIMPL >= MV_PAR05 .And. GWN->GWN_DTIMPL <= MV_PAR06 ;
																.And. GWN->GWN_DTSAI >= MV_PAR07 .And. GWN->GWN_DTSAI <= MV_PAR08 ;
																.And. GWN->GWN_DTCALC >= MV_PAR09 .And. GWN->GWN_DTCALC <= MV_PAR10 ;
																.And. GWN->GWN_DTFECH >= MV_PAR11 .And. GWN->GWN_DTFECH <= MV_PAR12 ;
																.And. (Empty(MV_PAR13) .Or. GWN->GWN_CDTPOP == MV_PAR13)
																lFiltroGWN := .T.
																If aScan(aRomanCont,{|x| x == GWN->GWN_FILIAL + GWN->GWN_NRROM }) == 0
																	aAdd(aRomanCont,GWN->GWN_FILIAL + GWN->GWN_NRROM)
																	nRoman += 1
																	If !Empty(GWN->GWN_PLACAD)
																		nQtVeic += 1						
																	EndIf
																EndIf
																nVlfFech +=VLTOTFRET()
															EndIf
															GW1->(dbSkip())
														EndDo
													EndIf
													GWH->(dbSkip())
												EndDo
											EndIf
										EndIf							
										GWF->(dbSkip())
									EndDo
								EndIf
							EndIf
							GV7->(dbSkip())
						EndDo
					EndIf
					(cAliTpVc)->QTDROMAN += nRoman
					(cAliTpVc)->QTDVEIC += nQtVeic
					(cAliTpVc)->VLRFRETE += nCalc
					(cAliTpVc)->VLRFECHAM += nVlfFech
					MsUnLock(cAliTpVc)
					nRoman := nQtVeic := nCalc := nVlfFech := 0					
					GWG->(dbSkip())
				EndDo
			EndIf
		EndIf
		GV9->(dbSkip())
	EndDo
	
	(cAliTransp)->(dbGoTop())
	If !(cAliTransp)->(Eof())
		While !(cAliTransp)->(Eof())
			If (cAliTransp)->FILTROGWN .And. ((cAliNeg)->(dbSeek((cAliTransp)->GV9_CDEMIT)) .Or. (cAliTpVc)->(dbSeek((cAliTransp)->GV9_CDEMIT)))
				oSection:Init()
				oSection:PrintLine()
				
				If !(cAliNeg)->(Eof())
					oSection2:Init()
					While !(cAliNeg)->(Eof()) .And. (cAliNeg)->GV9_CDEMIT == (cAliTransp)->GV9_CDEMIT
						oSection2:PrintLine()
						(cAliNeg)->(dbSkip())
					EndDo
					oSection2:Finish()
				EndIF
				
				If (cAliTpVc)->(dbSeek((cAliTransp)->GV9_CDEMIT))
					oSection3:Init()
					While !(cAliTpVc)->(Eof()) .And. (cAliTpVc)->GWG_CDEMIT == (cAliTransp)->GV9_CDEMIT
						oSection3:PrintLine()
						(cAliTpVc)->(dbSkip())
					EndDo
					oSection3:Finish()
				EndIF
				oSection:Finish()
			EndIf	
			(cAliTransp)->(dbSkip())
			
		EndDo
	EndIf
Return Nil


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
A funcao estatica CriaTabTemp Cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em GFER253() 

@author siegklenes.beulke
@version 1.0
@since 18/10/2013

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local  aStru
	aStru := {;
				{"GV9_CDEMIT","C", TamSx3("GV9_CDEMIT")[1],0},;
				{"GV9_DSTRP","C", TamSx3("GU3_NMEMIT")[1],0},;
				{"QTDROMAN","N", 6,0},;
				{"QTDVEIC","N", 6,0},;
				{"VLRFRETE","N", 10,2},;
				{"VLRFECHAM","N", 10,2},;
				{"FILTROGWN", "L",1,0};				
				}
	
	cAliTransp :=  GFECriaTab({aStru,{"GV9_CDEMIT"}})
	dbSelectArea(cAliTransp)
	(cAliTransp)->(dbSetOrder(1))

	aStru 	:= {;
				{"GV9_CDEMIT"  ,"C",TamSx3("GV9_CDEMIT")[1],0},;
				{"GWG_NRTAB"	,"C",TamSx3("GWG_NRTAB")[1],0},;
				{"GWG_NRNEG"	,"C",TamSx3("GWG_NRNEG")[1],0},;
				{"GWG_CDTPOP"	,"C",TamSx3("GWG_CDTPOP")[1],0},;
				{"GWG_CDCLFR"	,"C",TamSx3("GWG_CDCLFR")[1],0},;
				{"GV7_VLALUG"	,"N",TamSx3("GV7_VLALUG")[1],TamSx3("GV7_VLALUG")[2]},;
				{"GV7_FRQKM"	,"N",TamSx3("GV7_FRQKM")[1],TamSx3("GV7_FRQKM")[2]},;
				{"GV7_QTCOTA"	,"N",TamSx3("GV7_QTCOTA")[1],TamSx3("GV7_QTCOTA")[2]},;
				{"QTDROMAN","N", 6,0},;
				{"QTDVEIC","N", 6,0},;
				{"VLRFRETE","N", 10,2},;
				{"VLRFECHAM","N", 10,2};	
				}
	
	cAliNeg :=  GFECriaTab({aStru,{"GV9_CDEMIT+GWG_NRTAB+GWG_NRNEG"}})
	dbSelectArea(cAliNeg)
	(cAliNeg)->(dbSetOrder(1))
	
	aStru	:= {;
				{"GWG_CDEMIT"  ,"C",TamSx3("GV9_CDEMIT")[1],0},;
				{"GWG_CDTPVC"	,"C",TamSx3("GWG_CDTPVC")[1],0},; 
				{"QTDROMAN","N", 6,0},;
				{"QTDVEIC","N", 6,0},;
				{"VLRFRETE","N", 10,2},;
				{"VLRFECHAM","N", 10,2};	
				}	
	cAliTpVc :=  GFECriaTab({aStru,{"GWG_CDEMIT+GWG_CDTPVC"}}) 
	dbSelectArea(cAliTpVc)
	(cAliTpVc)->(dbSetOrder(1))
Return 

/*/{Protheus.doc} GetSx3Inf
	
@author siegklenes.beulke
@since 16/07/2013
@version 1.0

@param cCampo, character, Campo  do Banco de dados 
@param aRetorno, array, Opcional, Informações de Retorno caso não encontre o Campo

@description

Função que busca no sx3 as informações de titulo,cbox,picture e descrição do campo
e retorna um array nessa ordem, ou caso não encontre o campo, retorna o segundo parametro

@example

GetSx3Inf("GW1_FILIAL") Retorno {"Filial","","@!","Filial"}
GetSx3Inf("GW1_FILI",{"Fila","1=Sim;2=Nao","","Fila de espera"})Retorno {"Fila","1=Sim;2=Nao","","Fila de espera"} 

@return aArray:={X3Titulo, X3Cbox,X3Picture,X3DESCRIC}
/*/

Static Function GetSx3Inf(cCampo,aRetorno)
Local nCont := 1
Local aArea := GetArea("SX3")
Default aRetorno := {"","","",""}
	For nCont := 1 to 4-Len(aRetorno)
		aAdd(aRetorno,"")
	Next
	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek( cCampo )   
		aRetorno[1] := X3Titulo()
		aRetorno[2] := X3Cbox()
		aRetorno[3] := X3Picture()
		aRetorno[4] := X3DESCRIC()
	EndIf
	RestArea(aArea)
Return aRetorno
