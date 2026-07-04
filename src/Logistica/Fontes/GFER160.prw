/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER160
	
@author siegklenes.beulke
@since 16/10/2013
@version 1.0

@description
Relatório de Frete Frota Dedicada

-------------------------------------------------------------*/

User Function GFER160()
	Local oReport
	Local aArea := GetArea()
	Private cAliTransp	
	Private cAliCompo

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	GfeDelTab(cAliTransp)	
	GfeDelTab(cAliCompo)
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
																	
	oReport := TReport():New("GFER160","Frete Frota Dedicada","GFER160", {|oReport| ReportPrint(oReport)},"Emite Relatório de Utilização de Veículos por Transportador."/*Descricao do relatório*/)
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
	oSection := TRSection():New(oReport,"Transportador",{"(cAliTransp)","GU3","GWF","GWI"},{"Transportador"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	
	TRCell():New(oSection,"(cAliTransp)->GWF_TRANSP","GWN","Código do Transportador",GetSx3Inf("GWF_TRANSP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->GWF_DSTRP","GWN","Nome do Transportador",GetSx3Inf("GU3_NMEMIT")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection,"(cAliTransp)->VLRFRETE","GWN","Valor Calc Normal",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->VLRCOTA","GWN","Valor Ating. Cota",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->VLRLOCA","GWN","Valor Locação",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->VLRFRANQ","GWN","Valor Exced Franquia",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)			
	
	oSection2 := TRSection():New(oSection,"Cálculos",{"GWF","GWG","GWN","GWH","GW1"},{"Cálculos"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection2:SetTotalInLine(.T.)
	
	TRCell():New(oSection2,"GWF->GWF_DTCRIA","GWF","Data do Cálculo",GetSx3Inf("GWF_DTCRIA")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GWG->GWG_NRTAB","GWG","Tabela",GetSx3Inf("GWG_NRTAB")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"GWG->GWG_NRNEG","GWG","Negociação",GetSx3Inf("GWG_NRNEG")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"GWG->GWG_CDTPOP","GWG","Tipo Operação",GetSx3Inf("GWG_CDTPOP")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"GWG->GWG_CDCLFR","GWG","Classificação de Frete",GetSx3Inf("GWG_CDCLFR")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"GWG->GWG_CDTPVC","GWG","Tipo de Veículo",GetSx3Inf("GWG_CDTPVC")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"GWG->GWN_PLACAD","GWN","Veículo",GetSx3Inf("GWN_PLACAD")[3],/*Tamanho*/,/*lPixel*/,{||GetVeiculo()})
	
	oSection3 := TRSection():New(oSection2,"Componentes do Cálculo",{"GWF","GWI", "(cAliCompo)" },{"Veículos"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection3:SetTotalInLine(.T.)
	
	TRCell():New(oSection3,"(cAliCompo)->GWI_CDCOMP","(cAliCompo)","Componente",GetSx3Inf("GWI_CDCOMP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"(cAliCompo)->GWI_VLFRET","(cAliCompo)","Valor",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,)
	
		
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
	Local oSection3  := oReport:Section(1):Section(1):Section(1)
	Local cCalc := ""
	Local cTransp := ""
	Local lMovCompo
	/*
		01 Filial de 
		02 Filial ate
		03 Transportador
		04 Data Criação romaneio de 
		05 Data Criação romaneio ate
		06 Data de saida romaneio de
		07 Data de saida romaneio ate
		08 Data de calculo de
		09 Data de calculo ate
		10 Tipo de Operacao
		GWF->GWF_ORIGEM == "3"
	*/
	
	dbSelectArea("GWI")
	GWI->(dbSetOrder(1))
	dbSelectArea("GV9")
	GV9->(dbSetOrder(1))
	dbSelectArea("GWG")
	GWG->(dbSetOrder(1))
	dbSelectArea("GU3")
	GU3->(dbSetOrder(1))
	dbSelectArea("GWF")
	GWF->(dbSetOrder(1))
	GWF->(dbGoTop())
	While !GWF->(Eof()) .And. GWF->GWF_FILIAL >= MV_PAR01 .And. GWF->GWF_FILIAL <= MV_PAR02
		If !Empty(GWF->GWF_TRANSP) .And. GWF->GWF_ORIGEM == "3";
			.And. (GWF->GWF_TRANSP == MV_PAR03 .Or. Empty(MV_PAR03));
			.And. GWF->GWF_DTCRIA >= MV_PAR08 .And. GWF->GWF_DTCRIA <= MV_PAR09
									
			If (cAliTransp)->(dbSeek(GWF->GWF_TRANSP))	
				RecLock(cAliTransp,.F.)			
			Else
				RecLock(cAliTransp,.T.)
				(cAliTransp)->GWF_TRANSP := GWF->GWF_TRANSP
				(cAliTransp)->GWF_DSTRP := Posicione("GU3",1,xFilial("GU3")+GWF->GWF_TRANSP,"GU3_NMEMIT")	
				(cAliTransp)->FILTROGWG := .F.
			(cAliTransp)->FILTROGWN := .F.
			EndIf
			(cAliTransp)->VLRFRETE += GFER160_VLTOTFRET()
			
			If GWG->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC ));
				.And. (GWG->GWG_CDTPOP == MV_PAR10 .Or. Empty(MV_PAR10))
				(cAliTransp)->FILTROGWG := .T.
				If !(cAliTransp)->FILTROGWN
					GetVeiculo(cAliTransp) // Valida Filtro
				EndIf 
				If GV9->(dbSeek(xFilial("GV9") + GWG->GWG_CDEMIT + GWG->GWG_NRTAB + GWG->GWG_NRNEG))
					
					If !Empty(GV9->GV9_CFCOTA) .And. GWI->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC + GWG->GWG_CDCLFR + GWG->GWG_CDTPOP + GV9->GV9_CFCOTA)) // componente Cota 
						If (cAliCompo)->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_TRANSP + GWF->GWF_NRCALC +  GWI->GWI_CDCOMP))
							RecLock(cAliCompo,.F.)
						Else
							RecLock(cAliCompo,.T.)
							(cAliCompo)->GWF_FILIAL := GWF->GWF_FILIAL
							(cAliCompo)->GWF_TRANSP := GWF->GWF_TRANSP
							(cAliCompo)->GWF_NRCALC := GWF->GWF_NRCALC
							(cAliCompo)->GWI_CDCOMP := GWI->GWI_CDCOMP
						EndIf					
						(cAliCompo)->GWI_VLFRET := GWI->GWI_VLFRET
						(cAliTransp)->VLRCOTA += GWI->GWI_VLFRET
						MsUnLock(cAliCompo)
					EndIf
					
					If !Empty(GV9->GV9_CFALUG) .And. GWI->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC + GWG->GWG_CDCLFR + GWG->GWG_CDTPOP + GV9->GV9_CFALUG)) // componente locacao 
						If (cAliCompo)->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_TRANSP + GWF->GWF_NRCALC +  GWI->GWI_CDCOMP))
							RecLock(cAliCompo,.F.)
						Else
							RecLock(cAliCompo,.T.)
							(cAliCompo)->GWF_FILIAL := GWF->GWF_FILIAL
							(cAliCompo)->GWF_TRANSP := GWF->GWF_TRANSP
							(cAliCompo)->GWF_NRCALC := GWF->GWF_NRCALC
							(cAliCompo)->GWI_CDCOMP := GWI->GWI_CDCOMP
						EndIf					
						(cAliCompo)->GWI_VLFRET := GWI->GWI_VLFRET
						(cAliTransp)->VLRLOCA += GWI->GWI_VLFRET
						MsUnLock(cAliCompo)
					EndIf
					
					If !Empty(GV9->GV9_CFEXCD) .And. GWI->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC + GWG->GWG_CDCLFR + GWG->GWG_CDTPOP + GV9->GV9_CFEXCD)) // compo execente km 
						If (cAliCompo)->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_TRANSP + GWF->GWF_NRCALC +  GWI->GWI_CDCOMP))
							RecLock(cAliCompo,.F.)
						Else
							RecLock(cAliCompo,.T.)
							(cAliCompo)->GWF_FILIAL := GWF->GWF_FILIAL
							(cAliCompo)->GWF_TRANSP := GWF->GWF_TRANSP
							(cAliCompo)->GWF_NRCALC := GWF->GWF_NRCALC
							(cAliCompo)->GWI_CDCOMP := GWI->GWI_CDCOMP
						EndIf					
						(cAliCompo)->GWI_VLFRET := GWI->GWI_VLFRET
						(cAliTransp)->VLRFRANQ += GWI->GWI_VLFRET
						MsUnLock(cAliCompo)
					EndIf
				EndIf
			EndIf				
			MsUnlock(cAliTransp)
		EndIf
		GWF->(dbSkip())
	EndDo
	(cAliCompo)->(dbGoTop())
	While !(cAliCompo)->(Eof())
		If (cAliTransp)->(dbSeek((cAliCompo)->GWF_TRANSP)) .And. (cAliTransp)->FILTROGWG .And. (cAliTransp)->FILTROGWN
			If cTransp != (cAliCompo)->GWF_TRANSP
				oSection:Init()
				oSection:PrintLine()
				cTransp:= (cAliCompo)->GWF_TRANSP
			EndIf
			If GWF->(dbSeek((cAliCompo)->GWF_FILIAL + (cAliCompo)->GWF_NRCALC))
				lMovCompo := .F.
				While !GWF->(Eof()) .And. (cAliCompo)->GWF_FILIAL + (cAliCompo)->GWF_NRCALC == GWF->GWF_FILIAL + GWF->GWF_NRCALC
					If GWF->GWF_TRANSP == cTransp .And. GWF->GWF_ORIGEM == "3" .And. GWG->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC))
						oSection2:Init()
						oSection2:PrintLine()						
						oSection2:Finish()
						cCalc := (cAliCompo)->GWF_FILIAL + (cAliCompo)->GWF_TRANSP + (cAliCompo)->GWF_NRCALC
						oSection3:Init()					
						While !(cAliCompo)->(Eof()) .And. cCalc == (cAliCompo)->GWF_FILIAL + (cAliCompo)->GWF_TRANSP + (cAliCompo)->GWF_NRCALC
							oSection3:PrintLine()
							(cAliCompo)->(dbSkip())
							lMovCompo := .T.
						EndDo
						oSection3:Finish()
					EndIf
				GWF->(dbskip())
				EndDo
			EndIf
			If cTransp != (cAliCompo)->GWF_TRANSP				
				oSection:Finish()
			EndIf
			If lMovCompo				
				(cAliCompo)->(dbSkip(-1))
				cTransp := (cAliCompo)->GWF_TRANSP
			EndIf
		EndIf
		oSection:Finish()
		(cAliCompo)->(dbSkip())
	EndDo
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
				{"GWF_TRANSP","C", TamSx3("GWF_TRANSP")[1],0},;
				{"GWF_DSTRP","C", TamSx3("GU3_NMEMIT")[1],0},;
				{"VLRFRETE","N", 9,2},; // Cálculo normal
				{"VLRCOTA","N", 9,2},;  // gwi componente = GV9_CFCOTA
				{"VLRLOCA","N", 9,2},;  // gwi componente = GV9_CFALUG
				{"VLRFRANQ","N", 9,2},;  // gwi componente = GV9_CFEXCD
				{"FILTROGWG","L", 1,0},;
				{"FILTROGWN","L", 1,0}; 
				}
	
	cAliTransp :=  GFECriaTab({aStru,{"GWF_TRANSP"}})
	dbSelectArea(cAliTransp)
	(cAliTransp)->(dbSetOrder(1))
	
	aStru 	:= {;
				{"GWF_FILIAL"	,"C",TamSx3("GWF_FILIAL")[1],0},;
				{"GWF_TRANSP" ,"C",TamSx3("GWF_TRANSP")[1],0},;				
				{"GWF_NRCALC"	,"C",TamSx3("GWF_NRCALC")[1],0},;				
				{"GWI_CDCOMP"	,"C",TamSx3("GWI_CDCOMP")[1],0},;
				{"GWI_VLFRET"	,"N",TamSx3("GWI_VLFRET")[1],TamSx3("GWI_VLFRET")[2]};				
				}	
	cAliCompo :=  GFECriaTab({aStru,{"GWF_FILIAL+GWF_TRANSP+GWF_NRCALC+GWI_CDCOMP"}}) 
	dbSelectArea(cAliCompo)
	(cAliCompo)->(dbSetOrder(1))
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

Static Function GFER160_VLTOTFRET() // começa com o cálculo complementar
	Local VlTotal := 0
	Local aAreaGWF := GWF->(GetArea())
	Local aRoms := {}
	Local nX := 1
	dbSelectArea("GWF")
	GWF->(dbSetOrder(4))
	dbSelectArea("GWH")
	GWH->(dbSetOrder(1))
	dbSelectArea("GW1")
	GW1->(dbSetOrder(1))
	GWH->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC))
	While !GWH->(Eof()) .And. GWF->GWF_FILIAL + GWF->GWF_NRCALC == GWH->GWH_FILIAL + GWH->GWH_NRCALC
		If GW1->(dbSeek(GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC))
			If !Empty(GW1->GW1_NRROM)
				If aScan(aRoms,{|x| x == GW1->GW1_FILIAL +  GW1->GW1_NRROM}) == 0
					aAdd(aRoms,GW1->GW1_FILIAL +  GW1->GW1_NRROM)
				EndIf
			EndIf
		EndIf
		GWH->(dbSkip())
	EndDo
	For nX := 1 to Len(aRoms)
		If GWF->(dbSeek(aRoms[nX])) .And. GWF->GWF_TPCALC == "1" 
			dbSelectArea("GWI")
			GWI->(dbSetOrder(1))
			GWI->(dbSeek(GWF->GWF_FILIAL+GWF->GWF_NRCALC))
			While GWI->(!Eof()) .And. GWI->GWI_FILIAL == GWF->GWF_FILIAL .And. GWI->GWI_NRCALC == GWF->GWF_NRCALC
				If GWI->GWI_TOTFRE == "1"
					VlTotal := VlTotal + GWI->GWI_VLFRET
				Endif
				GWI->(dbSkip())
			EndDo
			Vltotal += GWF->GWF_VLAJUS
		EndIf
	Next nX
	
	RestArea(aAreaGWF)
Return VlTotal

Static Function GetVeiculo(cAli)
	Local cVeiculo := ""
	dbSelectArea("GWH")
	GWH->(dbSetOrder(1))
	dbSelectArea("GW1")
	GW1->(dbSetOrder(1))
	dbSelectArea("GWN")
	GW1->(dbSetOrder(1))

	If GWH->(dbSeek(GWF->GWF_FILIAL + GWF->GWF_NRCALC));
	.And. GW1->(dbSeek(GWH->GWH_FILIAL + GWH->GWH_CDTPDC + GWH->GWH_EMISDC + GWH->GWH_SERDC + GWH->GWH_NRDC));
	.And. GWN->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_NRROM))
		cVeiculo := GWN->GWN_PLACAD		
	EndIf
	If !Empty(cAli);
	.And. GWN->GWN_DTIMPL >= MV_PAR04 .And. GWN->GWN_DTIMPL <= MV_PAR05;
	.And. GWN->GWN_DTSAI >= MV_PAR06 .And. GWN->GWN_DTSAI <= MV_PAR07
		(cAli)->FILTROGWN := .T.		
	EndIf
Return cVeiculo
