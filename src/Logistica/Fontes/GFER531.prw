/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"        

//-------------------------------------------------------------------
/*/{Protheus.doc} GFER531

Relátorio de Ocorrências de Movimentação

@author Helder Fuckner dos Santos
@since 13/03/14
@version 1.0 
/*/
//-------------------------------------------------------------------
User Function GFER531()
	Local oReport
	Local aArea := GetArea()
	Private cTabTotMD
	Private cAliasOM // Registros referente a consultaSQL
	Private cSit := ""
	
	If TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea( aArea )
	GFEDelTab(cTabTotMD)
	If !Empty(cAliasOM)
		(cAliasOM)->( dbCloseArea() )
	EndIf

Return

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.          
//
//Uso       GFER531                                                    
//---------------------------------------------------------------------------

Static Function ReportDef()                                                                      	
	Local oReport, oSection1
	Local aOrdem    	:= {}
	
	//--------------------------------------------------------------------------
	//Criacao do componente de impressao                                      
	//--------------------------------------------------------------------------
	//TReport():New                                                           
	//ExpC1 : Nome do relatorio                                               
	//ExpC2 : Titulo                                                          
	//ExpC3 : Pergunte                                                        
	//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
	//ExpC5 : Descricao                                                       
	//--------------------------------------------------------------------------
	
	oReport:= TReport():New("GFER531","Ocorrências de Movimentação","GFER531", {|oReport| ReportPrint(oReport)},"Emite relatório de Ocorrências de Movimentação conforme os parâmetros informados.") //"Ocorrências de Movimentação"
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna
	oReport:HideParamPage()   	// Desabilita a impressao da pagina de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)
	EndIf

	//--------------------------------------------------------------------------
	//Criacao da secao utilizada pelo relatorio                               
	//--------------------------------------------------------------------------
	//TRSection():New                                                         
	//ExpO1 : Objeto TReport que a secao pertence                             
	//ExpC2 : Descricao da seçao                                              
	//ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   
	//        sera considerada como principal para a seção.                   
	//ExpA4 : Array com as Ordens do relatório                                
	//ExpL5 : Carrega campos do SX3 como celulas                              
	//        Default : False                                                 
	//ExpL6 : Carrega ordens do Sindex                                        
	//        Default : False                                                 
	//--------------------------------------------------------------------------
	//Criacao da celulas da secao do relatorio                                
	//                                                                        
	//TRCell():New                                                            
	//ExpO1 : Objeto TSection que a secao pertence                            
	//ExpC2 : Nome da celula do relatório. O SX3 será consultado              
	//ExpC3 : Nome da tabela de referencia da celula                          
	//ExpC4 : Titulo da celula                                                
	//        Default : X3Titulo()                                            
	//ExpC5 : Picture                                                         
	//        Default : X3_PICTURE                                            
	//ExpC6 : Tamanho                                                         
	//        Default : X3_TAMANHO                                            
	//ExpL7 : Informe se o tamanho esta em pixel                              
	//        Default : False                                                 
	//ExpB8 : Bloco de código para impressao.                                 
	//        Default : ExpC2                                                 
	//--------------------------------------------------------------------------     
	
	Aadd( aOrdem, "Ocorrências de Movimentação" ) // "Ocorrências de Movimentação"
	
	oSection1 := TRSection():New(oReport,"Ocorrências de Movimentação",{"(cAliasOM)"},aOrdem) //"Ocorrências de Movimentação"
	oSection1:SetTotalInLine(.T.)
	oSection1:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	// EXEMPLO: TRCell():New(oSection1,"(cAliasOM)->GWD_NROCO" ,"(cAliasOM)","Nr Ocorrência",GetSx3Inf("GWD_NROCO")[3],8,/*lPixel*/,/*{|| code-block de impressao }*/)
	/*
 	TRCell():New(oSection1,"(cAliasOM)->GWD_NROCO" ,"(cAliasOM)","Nr Ocorrência",GetSx3Inf("GWD_NROCO")[3],8,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_DSOCOR","(cAliasOM)","Descrição",GetSx3Inf("GWD_DSOCOR")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GU5_DESC"  ,"(cAliasOM)","Tipo",GetSx3Inf("GU5_DESC")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GU6_DESC"  ,"(cAliasOM)","Motivo",GetSx3Inf("GU6_DESC")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_DTOCOR","(cAliasOM)","Dt. Ocorr.",,10,,{|| If(Vazio((cAliasOM)->GWD_DTOCOR),(cAliasOM)->GWD_DTOCOR,SubStr((cAliasOM)->GWD_DTOCOR,7,2) + '/' + SubStr((cAliasOM)->GWD_DTOCOR,5,2)+ '/' + SubStr((cAliasOM)->GWD_DTOCOR,1,4) ) })
	TRCell():New(oSection1,"(cAliasOM)->GWD_HROCOR","(cAliasOM)","Hr. Ocorr.",,5,,{|| If(Vazio((cAliasOM)->GWD_HROCOR), (cAliasOM)->GWD_HROCOR,SubStr((cAliasOM)->GWD_HROCOR,1,2) + ':' + SubStr((cAliasOM)->GWD_HROCOR,3,2) ) })	
	TRCell():New(oSection1,"cSit"                  ,"","Situação","@!",9,,{|| cSit })
	TRCell():New(oSection1,"(cAliasOM)->GWD_NRMOV" ,"(cAliasOM)","Nr Movto",GetSx3Inf("GWD_NRMOV")[3],8,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_CDPTCT","(cAliasOM)","Ponto de Controle",GetSx3Inf("GWD_CDPTCT")[3],16,,)
	*/
 	TRCell():New(oSection1,"(cAliasOM)->GWD_NROCO" ,"(cAliasOM)","Nr Ocorrência",GetSx3Inf("GWD_NROCO")[3],8,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_NRMOV" ,"(cAliasOM)","Nr Movto",GetSx3Inf("GWD_NRMOV")[3],8,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_CDPTCT","(cAliasOM)","Ponto de Controle",GetSx3Inf("GWD_CDPTCT")[3],16,,)
	TRCell():New(oSection1,"(cAliasOM)->GU5_DESC"  ,"(cAliasOM)","Tipo",GetSx3Inf("GU5_DESC")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GU6_DESC"  ,"(cAliasOM)","Motivo",GetSx3Inf("GU6_DESC")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_DSOCOR","(cAliasOM)","Descrição",GetSx3Inf("GWD_DSOCOR")[3],50,,)
	TRCell():New(oSection1,"(cAliasOM)->GWD_DTOCOR","(cAliasOM)","Dt. Ocorr.",,10,,{|| If(Vazio((cAliasOM)->GWD_DTOCOR),(cAliasOM)->GWD_DTOCOR,SubStr((cAliasOM)->GWD_DTOCOR,7,2) + '/' + SubStr((cAliasOM)->GWD_DTOCOR,5,2)+ '/' + SubStr((cAliasOM)->GWD_DTOCOR,1,4) ) })
	TRCell():New(oSection1,"(cAliasOM)->GWD_HROCOR","(cAliasOM)","Hr. Ocorr.",,5,,{|| If(Vazio((cAliasOM)->GWD_HROCOR), (cAliasOM)->GWD_HROCOR,SubStr((cAliasOM)->GWD_HROCOR,1,2) + ':' + SubStr((cAliasOM)->GWD_HROCOR,3,2) ) })	
	TRCell():New(oSection1,"cSit"                  ,"","Situação","@!",9,,{|| cSit })
	
Return(oReport)

//---------------------------------------------------------------------------
//Descrição A funcao estatica ReportDef devera ser criada para todos os 
//          relatorios que poderao ser agendados pelo usuario.         
//---------------------------------------------------------------------------
//Parametros³ExpO1: Objeto Report do Relatório
//---------------------------------------------------------------------------
//Uso  GFER531                                                    
//---------------------------------------------------------------------------

Static Function ReportPrint(oReport)
	Local oSection1 := oReport:Section(1)
	
	CarregaDados()

	//----------------------------------------------------------
	//Seta regua de processamento
	//----------------------------------------------------------
	oReport:SetMeter(GFENumReg(cAliasOM))
	
	oSection1:Init()
	
	(cAliasOM)->(dbGoTop())	
	While !oReport:Cancel() .And. !(cAliasOM)->( Eof() )
	
		//GWD_SIT --- 1=Pendente 2=Aprovada 3=Reprovada
		Do Case
			Case (cAliasOM)->GWD_SIT == '1'
				cSit := "Pendente"
			Case (cAliasOM)->GWD_SIT == '2'
				cSit := "Aprovada"
			Case (cAliasOM)->GWD_SIT == '3'
				cSit := "Reprovada"
		EndCase
			 
		// Imprime
		oSection1:PrintLine()

		(cAliasOM)->( dbSkip() )
	EndDo
	
	oSection1:Finish()
	
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabTotMD 
Faz a leitura do Pergunte GFER531
@author helder.santos
@version 1.0
@since 03/03/2014
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local aArea := GetArea(), cQuery := ""
	Local cFltrGX3 := "" 

	CriaTabTemp()

	cFltrGX3 += " AND GX3.GX3_FILIAL >= '" + MV_PAR01 		+ "' AND GX3.GX3_FILIAL <= '" + MV_PAR02 + "' "	
	cFltrGX3 += " AND GWD.GWD_DTOCOR >= '" + DTOS(MV_PAR03) + "' AND GWD.GWD_DTOCOR <= '" + DTOS(MV_PAR04) + "' "
	If AllTrim(MV_PAR05) != "" .And. AllTrim(MV_PAR06) != ""
		cFltrGX3 += " AND GWD.GWD_DTBAI >= '" + DTOS(MV_PAR05) + "' AND GWD.GWD_DTBAI <= '" + DTOS(MV_PAR06) + "' "
	EndIf
	cFltrGX3 += " AND GWD.GWD_CDTIPO >= '" + MV_PAR07 + "' AND GWD.GWD_CDTIPO <= '" + MV_PAR08	+ "' "
	cFltrGX3 += " AND GWD.GWD_CDMOT  >= '" + MV_PAR09 + "' AND GWD.GWD_CDMOT  <= '" + MV_PAR10 + "' "
	If AllTrim(MV_PAR11) != ""
		cFltrGX3 += " AND GX3.GX3_CDEMIT = '" + MV_PAR11 + "'"
	EndIf

	cAliasOM := GetNextAlias()

	cQuery += "SELECT GWD.GWD_NROCO, GWD.GWD_DSOCOR, GU5.GU5_DESC, GU6.GU6_DESC, "
	cQuery += "	    GWD.GWD_DTOCOR, GWD.GWD_HROCOR, GWD.GWD_SIT, GWD.GWD_NRMOV, GWD.GWD_CDPTCT "
	cQuery += "  FROM " + RetSQLName("GWD") + " GWD "
	cQuery += "  LEFT JOIN " + RetSQLName("GX3") + " GX3 ON GWD.GWD_FILIAL = GX3.GX3_FILIAL "
	cQuery += "  					  						   AND GWD.GWD_NRMOV = GX3.GX3_NRMOV "
	cQuery += "  LEFT JOIN " + RetSQLName("GU5") + " GU5 ON GU5.GU5_CDTIPO = GWD.GWD_CDTIPO "
	cQuery += "  LEFT JOIN " + RetSQLName("GU6") + " GU6 ON GU6.GU6_CDMOT = GWD.GWD_CDMOT "
	cQuery += " WHERE GX3.D_E_L_E_T_ = '' AND GWD.D_E_L_E_T_ = '' " + cFltrGX3
	cQuery += " ORDER BY GWD.GWD_NROCO, GWD.GWD_NRMOV, GWD.GWD_CDPTCT, GWD.GWD_CDTIPO, GWD.GWD_CDMOT, GU6.GU6_DESC, GWD.GWD_DTOCOR, GWD.GWD_HROCOR, GWD.GWD_SIT "

	// Nr Ocorrência, Nr Movto, Ponto de Controle, Tipo, Motivo, Descrição, Dt. Ocorr., Hr. Ocorr., Situação

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasOM, .F., .T.)
	dbSelectArea( (cAliasOM) )
	(cAliasOM)->( dbGoTop() )

	RestArea(aArea)
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
Esta funcao estatica cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER531() 

@author helder.santos
@version 1.0
@since 03/03/2014
@return {aStruOpTot} Array com Struct dos campos
/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local aStruOpTot
	
	aStruOpTot :=	{	{"GWD_NROCO","C",16,0};
					}

	cTabTotMD := GFECriaTab({aStruOpTot,{"GWD_NROCO"}})
	
Return {aStruOpTot}

/*/{Protheus.doc} GetSx3Inf
	
@author helder.santos
@since 03/03/2014
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