/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"


/*---------------------------------------------------------
{Protheus.doc} GFER053   
	
@author siegklenes.beulke
@since 31/07/2013 
@version 1.0

@description
Relatório de Estoque em Trânsito por Transportador,
Apresenta os itens em trânsito por transportador

-------------------------------------------------------------*/
User Function GFER053()
	Local oReport
	Local aArea := GetArea()
	
	Private cAliasTran // tabela temporaria de produtos
	Private cAliasItem // tabela temporaria de itens agrupados
	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)	
	GFEDelTab(cAliasTran)
	GFEDelTab(cAliasItem)
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author siegklenes.beulke
@version 1.0
@since 25/07/2013
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
																	
	oReport := TReport():New("GFER053","Relatório de Estoque em Trânsito por Transportador","GFER053", {|oReport| ReportPrint(oReport)},"Emite relatório de Estoque em Trânsito por Transportador conforme os parâmetros informados."/*Descricao do relatório*/)
	oReport:SetLandscape(.T.)   //Define a oriadmientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	oReport:HideParamPage() //Oculta página de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)  
	EndIf
	oSection := TRSection():New(oReport,"Estoque em Trânsito",{"(cAliasTran)","GU3"},{"Estoque em Trânsito"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	//Exemplo utilizando a tabela de clientes.
	//oSection := TRSection():New(oReport,"Clientes",{"SA1"})
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
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
	
	TRCell():New(oSection,"(cAliasTran)->GWU_CDTRP","(cAliasTran)","Transportador",GetSx3Inf("GU3_CDEMIT")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GU3->GU3_NMEMIT","(cAliasTran)",GetSx3Inf("GU3_NMEMIT")[1],"@!",/*Tamanho*/,/*lPixel*/,{||Posicione("GU3",1,xFilial("GU3") + (cAliasTran)->GWU_CDTRP,"GU3_NMEMIT")}/*{|| code-block de impressao }*/)
	
	
	TRCell():New(oSection,"(cAliasTran)->GW1_QTVOL", "(cAliasTran)", "Qtde Volumes",GetSx3Inf("GW1_QTVOL")[3],,,)
	TRCell():New(oSection,"(cAliasTran)->GW8_PESOR", "(cAliasTran)", "Peso Bruto",GetSx3Inf("GW8_PESOR")[3],,,)
	TRCell():New(oSection,"(cAliasTran)->GW8_VALOR", "(cAliasTran)", "Valor Carga",GetSx3Inf("GW8_VALOR")[3],,,)
	TRCell():New(oSection,"(cAliasTran)->GW8_VOLUME", "(cAliasTran)", "Volume Carga",GetSx3Inf("GW8_VOLUME")[3],,,)
	TRCell():New(oSection,"(cAliasTran)->GW1_NRDC", "(cAliasTran)", "Qtde Documentos",GetSx3Inf("GW1_NRDC")[3],,,)
	oSection2 := TRSection():New(oSection,"Itens em Trânsito",{"(cAliasItem)"},{"Itens em Trânsito"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"(cAliasItem)->GW8_ITEM","(cAliasItem)","Código do Item",GetSx3Inf("GW8_ITEM")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasItem)->GW8_DSITEM","(cAliasItem)","Descrição","@!",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasItem)->GW8_QTDE","(cAliasItem)","Qtde Itens",GetSx3Inf("GW8_QTDE")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasItem)->GW8_PESOR","(cAliasItem)","Peso Bruto",GetSx3Inf("GW8_PESOR")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasItem)->GW8_VALOR","(cAliasItem)","Valor Itens",GetSx3Inf("GW8_VALOR")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"(cAliasItem)->GW8_VOLUME","(cAliasItem)","Volume",GetSx3Inf("GW8_VOLUME")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	
Return oReport

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author Siegklenes.beulke
@version 1.0
@since 01/08/2013
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection  := oReport:Section(1)
	Local oSection2  := oReport:Section(1):Section(1)
	Local aArea := GetArea()

	Private cAliasTran // tabela temporaria de produtos
	Private cAliasItem // tabela temporaria de itens agrupados

	CarregaDados()
	
	While !(cAliasTran)->(Eof())
		oSection:Init()
		oSection:PrintLine()
		If (cAliasItem)->(dbSeek((cAliasTran)->GWU_CDTRP))
			oSection2:Init()
			While !(cAliasItem)->(Eof()) .And. (cAliasTran)->GWU_CDTRP == (cAliasItem)->GWU_CDTRP
				oSection2:PrintLine()
				(cAliasItem)->(dbSkip())
			EndDo
			oSection2:Finish()
		EndIf
		
		(cAliasTran)->(dbSkip())
		oSection:Finish()
	EndDo
	
	RestArea(aArea)
Return Nil


//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
A funcao estatica CriaTabTemp Cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER053() 

@author siegklenes.beulke
@version 1.0
@since 01/08/2013
@return {aStruTran, aStruItem} Array com Struct dos campos

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local  aStruTran, aStruItem
	
	aStruTran 	:= {; 	
						{"GWU_CDTRP","C",TamSX3("GWU_CDTRP" )[1],TamSX3("GWU_CDTRP" )[2]},; 
						{"GW1_NRDC","N",TamSX3("GW1_NRDC" )[1],TamSX3("GW1_NRDC" )[2]},; 
						{"GW1_QTVOL","N",TamSX3("GW1_QTVOL" )[1],TamSX3("GW1_QTVOL" )[2]},; 
						{"GW8_PESOR","N",TamSX3("GW8_PESOR" )[1],TamSX3("GW8_PESOR" )[2]},; 
						{"GW8_VALOR","N",TamSX3("GW8_VALOR" )[1],TamSX3("GW8_VALOR" )[2]},; 
						{"GW8_VOLUME","N",TamSX3("GW8_VOLUME" )[1],TamSX3("GW8_VOLUME" )[2]};
					}
					
	aStruItem	:= {;
						{"GWU_CDTRP","C",TamSX3("GWU_CDTRP" )[1],TamSX3("GWU_CDTRP" )[2]},;
						{"GW8_ITEM","C",TamSX3("GW8_ITEM" )[1],TamSX3("GW8_ITEM" )[2]},;
						{"GW8_DSITEM","C",TamSX3("GW8_DSITEM" )[1],TamSX3("GW8_DSITEM" )[2]},;
						{"GW8_QTDE","N",TamSX3("GW8_QTDE" )[1],TamSX3("GW8_QTDE" )[2]},;
						{"GW8_PESOR","N",TamSX3("GW8_PESOR" )[1],TamSX3("GW8_PESOR" )[2]},;
						{"GW8_VALOR","N",TamSX3("GW8_VALOR" )[1],TamSX3("GW8_VALOR" )[2]},;
						{"GW8_VOLUME","N",TamSX3("GW8_VOLUME" )[1],TamSX3("GW8_VOLUME" )[2]};
					}
	cAliasTran :=  GFECriaTab({aStruTran,{"GWU_CDTRP"}})
	cAliasItem :=  GFECriaTab({aStruItem,{"GWU_CDTRP+GW8_ITEM"}})
	(cAliasTran)->(dbSetOrder(1))
	(cAliasItem)->(dbSetOrder(1))
Return {aStruTran,aStruItem}


/*/{Protheus.doc} CarregaDados()
	
@author siegklenes.beulke
@since 02/08/2013
@version 1.0
	
@description
	A função estática CarregaDados alimenta as tabelas temporárias,(cAliasTran) e (cAliasItem), para uso no relatório
@example
	CarregaDados()

/*/

Static Function CarregaDados()
	Local cChaveGW1 := ""
	
	/* 	Pergunte
		01 Filial de
		02 Filial até
		03 Data da emissao documento de
		04 Data da emissao documento ate
		05 Data saida de
		06 Data saida até
		07 Representante de
		08 Representante ate
		09 Cidade Dest de
		10 Cidade Dest Ate
		11 destinatario de
		12 destinatario ate
	*/
	
	CriaTabTemp()

	dbSelectArea("GW1")
	GW1->(dbSetOrder(1))
	GW1->(dbGoTop())
	
	dbSelectArea("GWU")
	GWU->(dbSetOrder(1))
	
	dbSelectArea("GW8")
	GW8->(dbSetOrder(2))
	
	While !GW1->(Eof()) 
		If !Empty(GW1->GW1_DTSAI) .And. GW1->GW1_SIT == '4';
			.And. GW1->GW1_FILIAL >= MV_PAR01 .And. GW1->GW1_FILIAL <= MV_PAR02;
			.And. GW1->GW1_DTEMIS >= MV_PAR03 .And. GW1->GW1_DTEMIS <= MV_PAR04;
			.And. GW1->GW1_DTSAI >= MV_PAR05 .And. GW1->GW1_DTSAI <= MV_PAR06;
			.And. GW1->GW1_REPRES >= MV_PAR07 .And. GW1->GW1_REPRES <= MV_PAR08;
			.And. If(Vazio(GW1->GW1_ENTNRC),Posicione("GU3",1,xFilial("GU3") + GW1->GW1_CDDEST, "GU3_NRCID") , GW1->GW1_ENTNRC) >= MV_PAR09;
			.And. If(Vazio(GW1->GW1_ENTNRC),Posicione("GU3",1,xFilial("GU3") + GW1->GW1_CDDEST, "GU3_NRCID") , GW1->GW1_ENTNRC) <= MV_PAR10;
			.And. GW1->GW1_CDDEST >= MV_PAR11 .And. GW1->GW1_CDDEST <= MV_PAR12
			
			cChaveGW1 := GW1->GW1_FILIAL+GW1->GW1_CDTPDC+GW1->GW1_EMISDC+GW1->GW1_SERDC+GW1->GW1_NRDC
			GWU->(dbSeek(cChaveGW1))
			While !GWU->(Eof()) ;
				.And.  cChaveGW1 == GWU->GWU_FILIAL+GWU->GWU_CDTPDC+GWU->GWU_EMISDC+GWU->GWU_SERDC+GWU->GWU_NRDC
				If GWU->GWU_PAGAR == '1' .And. Empty(GWU->GWU_DTENT) 
					If  GW8->(dbSeek(cChaveGW1)) 
						If !(cAliasTran)->(dbSeek(GWU->GWU_CDTRP))
							RecLock((cAliasTran),.T.)
							(cAliasTran)->GWU_CDTRP := GWU->GWU_CDTRP
						Else
							RecLock((cAliasTran),.F.)
						EndIf
						(cAliasTran)->GW1_NRDC += 1
						(cAliasTran)->GW1_QTVOL += GW1->GW1_QTVOL 
						While !GW8->(Eof()) .And. cChaveGW1 == GW8->GW8_FILIAL+GW8->GW8_CDTPDC+GW8->GW8_EMISDC+GW8->GW8_SERDC+GW8->GW8_NRDC					
							(cAliasTran)->GW8_PESOR += GW8->GW8_PESOR
							(cAliasTran)->GW8_VALOR += GW8->GW8_VALOR
							(cAliasTran)->GW8_VOLUME += GW8->GW8_VOLUME
							GW8->(dbSkip())
						EndDo
						MsUnlock((cAliasTran))
					EndIf
					
					If  GW8->(dbSeek(cChaveGW1))
						While !GW8->(Eof()) .And. cChaveGW1 == GW8->GW8_FILIAL+GW8->GW8_CDTPDC+GW8->GW8_EMISDC+GW8->GW8_SERDC+GW8->GW8_NRDC
							If !(cAliasItem)->(dbSeek(GWU->GWU_CDTRP+GW8->GW8_ITEM))
								
								RecLock((cAliasItem),.T.)
								(cAliasItem)->GWU_CDTRP := GWU->GWU_CDTRP
								(cAliasItem)->GW8_ITEM := GW8->GW8_ITEM
								(cAliasItem)->GW8_DSITEM := GW8->GW8_DSITEM
							Else
								
								RecLock((cAliasItem),.F.)
							EndIf
							(cAliasItem)->GW8_QTDE += GW8->GW8_QTDE
							(cAliasItem)->GW8_PESOR += GW8->GW8_PESOR
							(cAliasItem)->GW8_VALOR += GW8->GW8_VALOR
							(cAliasItem)->GW8_VOLUME += GW8->GW8_VOLUME
							MsUnlock((cAliasItem))
							GW8->(dbSkip())
						EndDo
					EndIf
					cChaveGW1 := ""
				EndIf
			GWU->(dbSkip())
			EndDo
		EndIf
		GW1->(dbSkip())
	EndDo
	(cAliasTran)->(dbGoTop())
	(cAliasItem)->(dbGoTop())
Return Nil

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