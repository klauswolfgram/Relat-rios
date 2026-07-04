/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER162
	
@author siegklenes.beulke
@since 16/10/2013
@version 1.0

@description
Relatório de Uso de Veículos,
Apresenta os veículos por transportador 

-------------------------------------------------------------*/
User Function GFER162()
	Local oReport
	Local aArea := GetArea()
	Private cAliTransp	
	Private cAliTpVc
	Private cAliPlac

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	GfeDelTab(cAliTransp)	
	GfeDelTab(cAliTpVc)
	GfeDelTab(cAliPlac)	
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
																	
	oReport := TReport():New("GFER162 - Utilização de Veículos","Utilização de Veículos","GFER162", {|oReport| ReportPrint(oReport)},"Emite Relatório de Utilização de Veículos por Transportador."/*Descricao do relatório*/)
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
	oSection := TRSection():New(oReport,"Transportador",{"(cAliTransp)","GU3"},{"Transportador"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	TRCell():New(oSection,"(cAliTransp)->GWN_FILIAL","GWN","Filial",GetSx3Inf("GWN_FILIAL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->GWN_CDTRP","GWN","Código do Transportador",GetSx3Inf("GWN_CDTRP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliTransp)->GWN_DSTRP","GWN","Nome do Transportador",GetSx3Inf("GU3_NMEMIT")[3],/*Tamanho*/,/*lPixel*/,)
	
	oSection2 := TRSection():New(oSection,"Tipos de Veículo",{"GWN","(cAliTpVc)"},{"Tipo de Veículo"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection2:SetTotalInLine(.T.)
	
	TRCell():New(oSection2,"(cAliTpVc)->GWN_CDTPVC","GWN","Tipo de Veículo",GetSx3Inf("GWN_CDTPVC")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliTpVc)->QTDROMAN","(cAliTpVc)","Qtde Romaneios","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliTpVc)->DISTPERC","(cAliTpVc)","Distancia Percorrida Real","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection2,"(cAliTpVc)->DIASTRANS","(cAliTpVc)","Dias em Trânsito","",/*Tamanho*/,/*lPixel*/,)
	
	oSection3 := TRSection():New(oSection2,"Veículos",{"GWN","(cAliPlac)"},{"Veículos"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection3:SetTotalInLine(.T.)
	
	TRCell():New(oSection3,"(cAliPlac)->GWN_PLACAD","GWN","Placa",GetSx3Inf("GWN_PLACAD")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"(cAliPlac)->QTDROMAN","(cAliPlac)","Qtde Romaneios","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection3,"(cAliPlac)->DISTPERC","(cAliPlac)","Distancia Percorrida Real","",/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection3,"(cAliPlac)->DIASTRANS","(cAliPlac)","Dias em Trânsito","",/*Tamanho*/,/*lPixel*/,)
	
		
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
	Local oSection2 := oReport:Section(1):Section(1)
	Local oSection3 := oReport:Section(1):Section(1):Section(1)
	Local aAreaGWN  := GWN->(GetArea())
	Local aTipoProp := {"$ '1234'","== '3'" ,"== '2'"}
	Local cChave    := ""
	Local cTipoProp := ""
	Local cTpVc     := ""
	Local cAliasGW1 := Nil
	Local cWhere    := Nil

	dbSelectArea("GU8")
	GU8->(dbSetOrder(2))
	dbSelectArea("GW1")
	GW1->(dbSetOrder(1))
	dbSelectArea("GWU")
	GWU->(dbSetOrder(1))
	dbSelectArea("GU3")
	GU3->(dbSetOrder(1))
	dbSelectArea("GWN")
	GWN->(dbSetOrder(2))
	GWN->(dbGoTop())

	/* Pergunte
		01 Filial de 
		02 Filial ate
		03 Cod Transp / Cod Transportador romaneio (transportadores)
		04 Data Criacao de / Do Romaneio
		05 Data Criacao ate / Do Romaneio
		06 Data Saida de / Do Romaneio
		07 Data Saida ate / Do Romaneio
		08 Data Retorno de / Do romaneio
		09 Data Retorno ate / Do romaneio
		10 Tipo Operação / Do romaneio
		11 Tipo de Proprietário / do veículo
	*/
	cTipoProp :=  '(Posicione("GU8",2,xFilial("GU8") + GWN->GWN_PLACAD , "GU8_TPPROP")' + aTipoProp[MV_PAR11] + '  .Or. Empty(GWN->GWN_PLACAD))'
	While !GWN->(Eof())
		If 	!Empty(GWN->GWN_CDTRP) .And. GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
			.And. (Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
			.And. GWN->GWN_DTIMPL >= MV_PAR04 .And. GWN->GWN_DTIMPL <= MV_PAR05 ;
			.And. GWN->GWN_DTSAI >= MV_PAR06 .And. GWN->GWN_DTSAI <= MV_PAR07 ;
			.And. GWN->GWN_DTRET >= MV_PAR08 .And. GWN->GWN_DTRET <= MV_PAR09 ;
			.And. (Empty(MV_PAR10) .Or. GWN->GWN_CDTPOP == MV_PAR10);
			.And. &(cTipoProp)
			
			If cChave!= GWN->GWN_FILIAL + GWN->GWN_CDTRP 
				cChave := GWN->GWN_FILIAL + GWN->GWN_CDTRP
				RecLock(cAliTransp,.T.)
				(cAliTransp)->GWN_FILIAL := GWN->GWN_FILIAL
				(cAliTransp)->GWN_CDTRP  := GWN->GWN_CDTRP
				(cAliTransp)->GWN_DSTRP  := Posicione("GU3",1,xFilial("GU3") + GWN->GWN_CDTRP,"GU3_NMEMIT")
				MsUnLock(cAliTransp)	
			EndIf
			cTpVc := If(Empty(GWN->GWN_CDTPVC),"S/TIPO VEÍCULO",GWN->GWN_CDTPVC)
			If !Empty(cTpVc) .Or. !Empty(GWN->GWN_PLACAD)
				If (cAliTpVc)->(dbSeek(GWN->GWN_FILIAL + GWN->GWN_CDTRP + cTpVc))
					RecLock(cAliTpVc,.F.)
				Else
					RecLock(cAliTpVc,.T.)
				EndIf
				(cAliTpVc)->GWN_FILIAL := GWN->GWN_FILIAL
				(cAliTpVc)->GWN_CDTRP := GWN->GWN_CDTRP
				(cAliTpVc)->GWN_CDTPVC := cTpVc
				(cAliTpVc)->QTDROMAN += 1
				(cAliTpVc)->DISTPERC += If (GWN->GWN_HODRET >= GWN->GWN_HODSAI,GWN->GWN_HODRET - GWN->GWN_HODSAI, (GWN->GWN_HODRET+1000000)-GWN->GWN_HODSAI) 
				If !Empty(GWN->GWN_DTRET)
					(cAliTpVc)->DIASTRANS += ABS(GWN->GWN_DTRET - GWN->GWN_DTSAI)
				Else
					If GFXCP1212210('GW1_FILROM')
						cWhere := "GW1.GW1_FILROM = '" + GWN->GWN_FILIAL + "'"
					Else
						cWhere := "GW1.GW1_FILIAL = '" + GWN->GWN_FILIAL + "'"
					EndIf
					cWhere := "%" + cWhere + "%"

					cAliasGW1 := GetNextAlias()
					BeginSql Alias cAliasGW1
						SELECT GW1_FILIAL, GW1_CDTPDC, GW1_EMISDC, GW1_SERDC, GW1_NRDC, GW1.R_E_C_N_O_ AS GW1RECNO
						FROM %table:GW1% GW1
						WHERE %Exp:cWhere%
						AND GW1.GW1_NRROM  = %Exp:GWN->GWN_NRROM%
						AND GW1.%NotDel%
						ORDER BY GW1.GW1_FILIAL,GW1.GW1_NRDC
					EndSql
					While !(cAliasGW1)->(Eof())
						GW1->(dbGoTo( (cAliasGW1)->GW1RECNO ))

						If GWU->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC))	
							While !GWU->(Eof()) ;
								.And. GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC == GWU->GWU_FILIAL + GWU->GWU_CDTPDC + GWU->GWU_EMISDC + GWU->GWU_SERDC + GWU->GWU_NRDC
								GWU->(dbSkip())									
							EndDo
							GWU->(dbSkip(-1)) // Ultimo trecho
							While !GWU->(Eof()) .And. !GWU->(Bof()) ;
								.And. GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC == GWU->GWU_FILIAL + GWU->GWU_CDTPDC + GWU->GWU_EMISDC + GWU->GWU_SERDC + GWU->GWU_NRDC
								If !Empty(GWU->GWU_DTENT) 
									(cAliTpVc)->DIASTRANS += ABS(GWU->GWU_DTENT - GWN->GWN_DTSAI)
									Exit								
								EndIf
								GWU->(dbSkip(-1))									
							EndDo		 
						EndIf

						(cAliasGW1)->(dbSkip())
					EndDo	
					(cAliasGW1)->(dbCloseArea())
				EndIf
				MsUnLock(cAliTpVc)
			EndIf
			If !Empty(GWN->GWN_PLACAD)
				If (cAliPlac)->(dbSeek(GWN->GWN_CDTRP + cTpVc + GWN->GWN_PLACAD))
					RecLock(cAliPlac,.F.)
				Else
					RecLock(cAliPlac,.T.)
				EndIf
				(cAliPlac)->GWN_FILIAL := GWN->GWN_FILIAL
				(cAliPlac)->GWN_CDTRP := GWN->GWN_CDTRP
				(cAliPlac)->GWN_CDTPVC := cTpVc
				(cAliPlac)->GWN_PLACAD := GWN->GWN_PLACAD
				(cAliPlac)->QTDROMAN += 1
				(cAliPlac)->DISTPERC += If (GWN->GWN_HODRET >= GWN->GWN_HODSAI,GWN->GWN_HODRET - GWN->GWN_HODSAI, (GWN->GWN_HODRET+1000000)-GWN->GWN_HODSAI)
				If !Empty(GWN->GWN_DTRET)
					(cAliPlac)->DIASTRANS += ABS(GWN->GWN_DTRET - GWN->GWN_DTSAI)
				Else
					If GFXCP1212210('GW1_FILROM')
						cWhere := "GW1.GW1_FILROM = '" + GWN->GWN_FILIAL + "'"
					Else
						cWhere := "GW1.GW1_FILIAL = '" + GWN->GWN_FILIAL + "'"
					EndIf
					cWhere := "%" + cWhere + "%"

					cAliasGW1 := GetNextAlias()
					BeginSql Alias cAliasGW1
						SELECT GW1_FILIAL, GW1_CDTPDC, GW1_EMISDC, GW1_SERDC, GW1_NRDC, GW1.R_E_C_N_O_ AS GW1RECNO
						FROM %table:GW1% GW1
						WHERE %Exp:cWhere%
						AND GW1.GW1_NRROM  = %Exp:GWN->GWN_NRROM%
						AND GW1.%NotDel%
						ORDER BY GW1.GW1_FILIAL,GW1.GW1_NRDC
					EndSql
					While !(cAliasGW1)->(Eof())
						GW1->(dbGoTo( (cAliasGW1)->GW1RECNO ))
						
						If GWU->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC))	
							While !GWU->(Eof()) ;
								.And. GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC == GWU->GWU_FILIAL + GWU->GWU_CDTPDC + GWU->GWU_EMISDC + GWU->GWU_SERDC + GWU->GWU_NRDC
								GWU->(dbSkip())									
							EndDo
							GWU->(dbSkip(-1)) //Ultimo trecho
							While !GWU->(Eof()) .And. !GWU->(Bof()) ;
								.And. GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC == GWU->GWU_FILIAL + GWU->GWU_CDTPDC + GWU->GWU_EMISDC + GWU->GWU_SERDC + GWU->GWU_NRDC
								If !Empty(GWU->GWU_DTENT) 
									(cAliPlac)->DIASTRANS += ABS(GWU->GWU_DTENT - GWN->GWN_DTSAI)
									Exit								
								EndIf
								GWU->(dbSkip(-1))									
							EndDo		 
						EndIf
					
						(cAliasGW1)->(dbSkip())
					EndDo	
					(cAliasGW1)->(dbCloseArea())
				EndIf
				MsUnLock(cAliPlac)
			EndIf
		EndIF	
		GWN->(dbSkip())		 
	EndDo
	(cAliTransp)->(dbGoTop())
	If !(cAliTransp)->(Eof())
		While !(cAliTransp)->(Eof())
			If (cAliTpVc)->(dbSeek((cAliTransp)->GWN_FILIAL + (cAliTransp)->GWN_CDTRP))
				oSection:Init()
				oSection:PrintLine()

				While !(cAliTpVc)->(Eof()) .And. (cAliTpVc)->GWN_CDTRP  == (cAliTransp)->GWN_CDTRP .And. (cAliTpVc)->GWN_FILIAL == (cAliTransp)->GWN_FILIAL
						oSection2:Init()
						oSection2:PrintLine()
					If (cAliPlac)->(dbSeek((cAliTpVc)->GWN_FILIAL + (cAliTpVc)->GWN_CDTRP + (cAliTpVc)->GWN_CDTPVC ))
						While !(cAliPlac)->(Eof()) .And. (cAliPlac)->GWN_FILIAL == (cAliTpVc)->GWN_FILIAL .And. (cAliPlac)->GWN_CDTRP == (cAliTpVc)->GWN_CDTRP .And. (cAliPlac)->GWN_CDTPVC == (cAliTpVc)->GWN_CDTPVC
							oSection3:Init()
							oSection3:PrintLine()
							(cAliPlac)->(dbSkip())
						EndDo
						oSection3:Finish()
					EndIF
					(cAliTpVc)->(dbSkip())
				EndDo
				oSection2:Finish()									
			EndIF
			(cAliTransp)->(dbSkip())
			oSection:Finish()
		EndDo
	EndIf
	
	RestArea(aAreaGWN)
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
	Local  aStru2
	Local  aStru3
	
	aStru 	:= {; 
				{"GWN_FILIAL","C", TamSx3("GWN_FILIAL")[1],0},;
				{"GWN_CDTRP","C", TamSx3("GWN_CDTRP")[1],0},;
				{"GWN_DSTRP","C", TamSx3("GU3_NMEMIT")[1],0};
				}
	
	cAliTransp :=  GFECriaTab({aStru,{"GWN_FILIAL+GWN_CDTRP"}})
	dbSelectArea(cAliTransp)
	(cAliTransp)->(dbSetOrder(1))
	
	aStru2 	:= {;
				{"GWN_FILIAL","C", TamSx3("GWN_FILIAL")[1],0},;
				{"GWN_CDTRP"  ,"C",TamSx3("GWN_CDTRP")[1],0},;
				{"GWN_CDTPVC"	,"C",14,0},; 
				{"QTDROMAN"	,"N",6,0},;
				{"DISTPERC"	,"N",6,0},;
				{"DIASTRANS"	,"N",6,0};
				}
	
	cAliTpVc :=  GFECriaTab({aStru2,{"GWN_FILIAL+GWN_CDTRP+GWN_CDTPVC"}})
	dbSelectArea(cAliTpVc)
	(cAliTpVc)->(dbSetOrder(1))
	
	aStru3 	:= {;
				{"GWN_FILIAL","C", TamSx3("GWN_FILIAL")[1],0},;
				{"GWN_CDTRP"  ,"C",TamSx3("GWN_CDTRP")[1],0},;
				{"GWN_CDTPVC"  ,"C",14,0},;
				{"GWN_PLACAD"	,"C",TamSx3("GWN_PLACAD")[1],0},; 
				{"QTDROMAN"	,"N",6,0},;  
				{"DISTPERC"	,"N",6,0},;
				{"DIASTRANS"	,"N",6,0};
				}	
	cAliPlac :=  GFECriaTab({aStru3,{"GWN_FILIAL+GWN_CDTRP+GWN_CDTPVC+GWN_PLACAD"}}) 
	dbSelectArea(cAliPlac)
	(cAliPlac)->(dbSetOrder(1))
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
