/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
/*---------------------------------------------------------
{Protheus.doc} GFER161
	
@author siegklenes.beulke
@since 16/10/2013
@version 1.0

@description
Relatório de Romaneios com Frota Dedicada,
Apresenta os romaneios com frota dedicada

-------------------------------------------------------------*/

User Function GFER161()
	Local oReport
	Local aArea := GetArea()
	Private nTotRom := 0
	Private nFrt := 0
	Private nTotFrt := 0 

	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)	
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
	Local cTotal := "Total"
	
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
																	
	oReport := TReport():New("GFER161","Relatório de Romaneios de Frota Dedicada","GFER161", {|oReport| ReportPrint(oReport)},"Emite Relatório de Frete com Frota Dedicada."/*Descricao do relatório*/)
	
	//configura a tela de paramêtros para vir selecionado a opção planilha
//	oReport:NDEVICE := 4
//	oReport:NENVIRONMENT := 1
//	oReport:NEXCEL := 7
	
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
	dbSelectArea("GWF")
	GWF->(dbSetOrder(4))
	oSection := TRSection():New(oReport,"Romaneios",{"GWN","GU3","GV3","GWF","GWI"},{"Romaneios"}/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	oSection:SetHeaderSection(.T.)
	TRCell():New(oSection,"GWN->GWN_NRROM","GWN","Nr. Romaneio",GetSx3Inf("GWN_NRROM")[3],/*Tamanho*/,/*lPixel*/,{|| nTotRom++,GWN->GWN_NRROM })
	TRCell():New(oSection,"GWN->GWN_CDTRP","GWN","Transportador",GetSx3Inf("GWN_CDTRP")[3],/*Tamanho*/,/*lPixel*/,)
	TRCell():New(oSection,"NMTRP","GWN","Nome Transportador","@!",/*Tamanho*/,/*lPixel*/,{||Posicione("GU3",1,xFilial("GU3") + GWN->GWN_CDTRP,"GU3_NMEMIT")}/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTIMPL","GWN","Data Criação",GetSx3Inf("GWN_DTIMPL")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTSAI","GWN","Data Saída",GetSx3Inf("GWN_DTSAI")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTRET","GWN","Data Retorno",GetSx3Inf("GWN_DTRET")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_DTFECH","GWN","Data Fechamento",GetSx3Inf("GWN_DTFECH")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_CDTPOP","GWN","Tipo Operação",GetSx3Inf("GWN_CDTPOP")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_CDCLFR","GWN","Classificação de Frete",GetSx3Inf("GWN_CDCLFR")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"GWN->GWN_CDTPVC","GWN","Tipo de Veículo",GetSx3Inf("GV3_DSTPVC")[3],/*Tamanho*/,/*lPixel*/,{|| Posicione("GV3",1,xFilial("GV3") + GWN->GWN_CDTPVC,"GV3_DSTPVC") })
	TRCell():New(oSection,"GWN->GWN_FECHAM","GWN","Apuração Fechamento",GetSx3Inf("GWN_FECHAM")[3],/*Tamanho*/,/*lPixel*/,{|| GetStrCbox(GetSx3Inf("GWN_FECHAM")[2],GWN->GWN_FECHAM) })
	TRCell():New(oSection,"GWI->GWI_VLFRET","GWN","Valor Frete",GetSx3Inf("GWI_VLFRET")[3],/*Tamanho*/,/*lPixel*/,{|| GWF->(dbSeek(GWN->GWN_FILIAL+GWN->GWN_NRROM)),(nFrt:=VLTOTFRET()) })
	
	oSection2 := TRSection():New(oSection,"Totalizadores",{"GWN","GWF","GWI"}) //  //"Totalizadores"
	oSection2:SetTotalInLine(.T.)
	oSection2:SetHeaderSection(.T.)
	TRCell():New(oSection2,"cTotal","","Totalizadores",,2,,{||cTotal})
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","",,2)
	TRCell():New(oSection2,"cTotal","","Romaneios",,,,{||nTotRom})
	TRCell():New(oSection2,"cTotal","","Valor Frete",,,,{||nTotFrt})
		
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
	Local aAreaGWN := GWN->(GetArea())
	Local aApura := {"$ '234'","== '2'" ,"== '3'","== '4'"}
	Local cApura := ""
	oSection:Init()
	
	dbSelectArea("GU3")
	GU3->(dbSetOrder(1))
	dbSelectArea("GWN")
	GWN->(dbSetOrder(1))
	GWN->(dbGoTop())
	
	
	/* Pergunte
		01 Filial de 
		02 Filial ate
		03 Cod Transp / Cod Transportador romaneio (transportadores)
		04 Data Criacao de / Do Romaneio
		05 Data Criacao ate / Do Romaneio
		06 Data Saida de / Do Romaneio
		07 Data Saida ate / Do Romaneio
		08 Data Cálc Fret de / Do Romaneio
		09 Data Cálc Fret ate / Do Romaneio
		10 Data Fechament de/ Do Romaneio
		11 Data Fechament ate / Do Romaneio
		12 Tipo Operação / Do romaneio
		13 Apuração Periodo ([1=exc nao se aplica,2=Pendente,3=Efetuado,4=Sem Efeito] )
	*/
	cApura :=  'GWN->GWN_FECHAM ' + aApura[MV_PAR13]
		
	While !GWN->(Eof()) 
		
		If  (GWN->GWN_FILIAL >= MV_PAR01 .And. GWN->GWN_FILIAL <= MV_PAR02) ;
			.And.(Empty(MV_PAR03) .Or. GWN->GWN_CDTRP == MV_PAR03);
			.And. GWN->GWN_DTIMPL >= MV_PAR04 .And. GWN->GWN_DTIMPL <= MV_PAR05 ;
			.And. GWN->GWN_DTSAI >= MV_PAR06 .And. GWN->GWN_DTSAI <= MV_PAR07 ;
			.And. GWN->GWN_DTCALC >= MV_PAR08 .And. GWN->GWN_DTCALC <= MV_PAR09 ;
			.And. GWN->GWN_DTFECH >= MV_PAR10 .And. GWN->GWN_DTFECH <= MV_PAR11 ;
			.And. (Empty(MV_PAR12) .Or. GWN->GWN_CDTPOP == MV_PAR12) ;
			.And. &(cApura) 
			
			oSection:PrintLine()
			nTotFrt += nFrt
		EndIf	
		GWN->(dbSkip())
		 
	EndDo
	
	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
	
	oSection:Finish()
	
	RestArea(aAreaGWN)
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
