/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER253
	
@author siegklenes.beulke
@since 12/09/2013
@version 1.0

@description
Relatório de Vale Pedágio,
Apresenta os Romaneios e as informações de vale pedágio

-------------------------------------------------------------*/

User Function GFER253()
	Local oReport
	Local aArea := GetArea()
	
	Private cAliasTot // tabela totalizadora
	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)	
	GFEDelTab(cAliasTot)
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 12/09/2013
@return oReport Objeto do Relatorio.

/*/
//--------------------------------------------------------------------------------------------------------

Static Function ReportDef()
	Local oReport, oSection, oSection2
	
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
																	
	oReport := TReport():New("GFER253","Relatório de Romaneios com Vale-pedágio","GFER253", {|oReport| ReportPrint(oReport)},"Emite Relatório do Vale Pedágio do Romaneio."/*Descricao do relatório*/)
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
	
	oSection := TRSection():New(oReport,"Vale Pedágio",{"GWN"},{"Vale Pedágio"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
	
	TRCell():New(oSection,"GWN->GWN_VPCDOP","GWN","Código da Operadora",GetSx3Inf("GWN_VPCDOP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_VPNMOP","GWN","Nome da Operadora",GetSx3Inf("GWN_VPNMOP")[3],/*Tamanho*/,/*lPixel*/,{||Posicione("GU3",1,xFilial("GU3") + GWN->GWN_VPCDOP,"GU3_NMEMIT") })
	
	TRCell():New(oSection,"GWN->GWN_NRROM","GWN","Número do Romaneio",GetSx3Inf("GWN_NRROM")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTIMPL","GWN","Data da Criação",GetSx3Inf("GWN_DTIMPL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTSAI","GWN","Data da Liberação",GetSx3Inf("GWN_DTSAI")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_PLACAD","GWN","Placa Dianteira",GetSx3Inf("GWN_PLACAD")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_CDTRP","GWN","Código da Operadora",GetSx3Inf("GWN_CDTRP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DSTRP","GWN"," Nome do Transportador",GetSx3Inf("GWN_DSTRP")[3],/*Tamanho*/,/*lPixel*/,{||Posicione("GU3",1,xFilial("GU3") + GWN->GWN_CDTRP,"GU3_NMEMIT") })
	TRCell():New(oSection,"GWN->GWN_VPNUM","GWN","Número do Comprovante",GetSx3Inf("GWN_VPNUM")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_VPVAL","GWN","Valor do Pedágio",GetSx3Inf("GWN_VPVAL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_VALEP","GWN","Situação do Vale Pedágio",GetSx3Inf("GWN_VALEP")[3],/*Tamanho*/,/*lPixel*/,{|| GetStrCbox(GetSx3Inf("GWN_VALEP")[2],GWN->GWN_VALEP) })
	
	oSection2 := TRSection():New(oSection,"Totalizadores",{"(cAliasTot)"}) //  //"Totalizadores"
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"cTotal","","Totalizadores",,2,,{||'Total'})
	TRCell():New(oSection2,"cTotal","","",,2,,{||''})
	TRCell():New(oSection2,"cTotal","","",,2,,{||''})
	TRCell():New(oSection2,"cTotal","","",,2,,{||''})
	TRCell():New(oSection2,"cTotal","","",,2,,{||''})
	TRCell():New(oSection2,"(cAliasTot)->GWN_QTROM","(cAliasTot)","Qtde Romaneios","",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasTot)->GWN_VPVAL","(cAliasTot)","Valor Total Pedágio","@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasTot)->GWN_QTCONF","(cAliasTot)","Qtde Conferidos","",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasTot)->GWN_VALCOF","(cAliasTot)","Valor Conferido","@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasTot)->GWN_QACONF","(cAliasTot)","Qtde a Conferir","",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasTot)->GWN_VACONF","(cAliasTot)","Valor a Conferir","@E 9,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
	
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
	Local aAreaGWN := GWN->(GetArea())
	Local cSit
	CriaTabTemp()
	
	oSection:Init()

	dbSelectArea("GWN")
	dbSetOrder(1)
	dbGoTop()
	
	RecLock(cAliasTot,.T.)
	
	/* Pergunte
		01 Filial de 
		02 Filial ate
		03 Cod Oper de / Cod operadora vale pedagio (fornecedores)
		04 Cod Oper ate / Cod operadora vale pedagio (fornecedores)
		05 Cod Transp de / Cod Transportador romaneio (transportadores)
		06 Cod Transp ate / Cod Transportador romaneio (transportadores)
		07 Numero Romaneio de 
		08 Numero Romaneio ate
		09 Data Criacao de / Do Romaneio
		10 Data Criacao ate / Do Romaneio
		11 Data Liberacao de / Do Romaneio
		12 Data Liberacao ate / Do Romaneio
		13 Vale Pedagio Do Romaneio / (1=Conferido;2=Não Conferido;3=Ex nao se aplic) 
	*/
		If MV_PAR13 == 1
			cSit := "GWN->GWN_VALEP == '3'"
		ElseIf MV_PAR13 == 2
			cSit := "GWN->GWN_VALEP == '2'"
		Else
			cSit := "GWN->GWN_VALEP $ '23'"
		EndIf
	While !GWN->(Eof())
		If 	GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02 ;
			.And. GWN->GWN_VPCDOP >= MV_PAR03 .And. GWN->GWN_VPCDOP <= MV_PAR04 ;
			.And. GWN->GWN_CDTRP >= MV_PAR05 .And. GWN->GWN_CDTRP <= MV_PAR06 ;
			.And. GWN->GWN_NRROM >= MV_PAR07 .And. GWN->GWN_NRROM <= MV_PAR08 ;
			.And. GWN->GWN_DTIMPL >= MV_PAR09 .And. GWN->GWN_DTIMPL <= MV_PAR10 ;
			.And. GWN->GWN_DTSAI >= MV_PAR11 .And. GWN->GWN_DTSAI <= MV_PAR12 ;
			.And. &(cSit)
				
				oSection:PrintLine()
				
				(cAliasTot)->GWN_QTROM	+= 1
				(cAliasTot)->GWN_VPVAL	+= GWN->GWN_VPVAL
				
				If GWN->GWN_VALEP == "3"
					(cAliasTot)->GWN_QTCONF	+= 1
					(cAliasTot)->GWN_VALCOF	+= GWN->GWN_VPVAL
				ElseIf GWN->GWN_VALEP == "2"
					(cAliasTot)->GWN_QACONF	+= 1
					(cAliasTot)->GWN_VACONF	+= GWN->GWN_VPVAL
				EndIf
			
		EndIf	
		GWN->(dbSkip())
		 
	EndDo
	
	MsUnlock(cAliasTot)
	
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
	oSection:Finish()
	
	
	RestArea(aAreaGWN)
Return Nil


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
A funcao estatica CriaTabTemp Cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER253() 

@author siegklenes.beulke
@version 1.0
@since 12/09/2013
@return {aStru} Array com Struct dos campos

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local  aStru
	
	aStru 	:= {; 	
						{"GWN_QTROM"	,"N",9,0},; //QTDE ROMANEIOS
						{"GWN_VPVAL"	,"N",12,2},; //TOTAL DO VALOR PEDAGIO
						{"GWN_QTCONF"	,"N",9,0},; //TOTAL QTD CONFERIDO
						{"GWN_VALCOF"	,"N",12,2},;//TOTAL VALOR PEDIGO CONFERIDO
						{"GWN_QACONF"	,"N",9,0},; // TOTAL QTD A CONFERIR
						{"GWN_VACONF"	,"N",12,2}; // TOTAL VALOR A CONFERIR
					}
	
	cAliasTot :=  GFECriaTab({aStru,{"GWN_QTROM"}})
	(cAliasTot)->(dbSetOrder(1))
Return {aStru}

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

/*/{Protheus.doc} GetStrCbox
	
@author siegklenes.beulke
@since 16/07/2013
@version 1.0

@param cBox, character, Caracter Representando X3Cbox
@param cVal, character, Valor de pesquisa

@description

Retorna o valor do combo dado o valor da sequencia

@example

GetStrCbox("1=Sim;2=Nao","1") // retorna "Sim" 

@return cRet Valor Buscado
/*/

Static Function GetStrCbox(cBox,cVal)
	Local aArr := STRTOKARR(cBox,";")
	Local aArr2 := {}
	Local nCont,nPos,cRet:=""
	For nCont :=1 to Len(aArr)
		aAdd(aArr2,STRTOKARR(aArr[ncont],"="))
	Next nCont
	If Len(aArr2) > 0 
		nPos := aScan(aArr2,{|x|x[1]==cVal})
		If nPos > 0
			cRet := aArr2[nPos][2]
		EndIf
	EndIf
Return cRet
