/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TECR015.ch"
#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "MSOLE.CH"

Static cPerg 	:= "TECR015"
Static cLocal 	:= ""
Static cItemRH	:= ""

User Function TECR015()
	If SuperGetMV('MV_ORCPRC')  
		If TFF->( ColumnPos( "TFF_TABXML" ) ) > 0
			U_TECR015()
		Else
			MsgAlert(STR0001,STR0002) //"O campo TFF_TABXML não existe no seu dicionário de dados, não será possível extrair dados deste relatório" //"Alerta"
		EndIf
	Else
		If Pergunte(cPerg,.T.)
			U_At15GerExc()
		EndIf
						
	EndIf	
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
@return 
/*/
//-------------------------------------------------/------------------------------------
user function TECR015()
	Local oReport
        
	If TRepInUse() 
		Pergunte(cPerg,.F.)	
		oReport := RepInit() 
		oReport:SetLandScape()
		oReport:PrintDialog()	
	EndIf
	
return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} RepInit
Função responsavel por elaborar o layout do relatorio a ser impresso

@version P12
/*/
//-------------------------------------------------------------------------------------
Static Function RepInit()
	Local oReport
	Local oSection1
	Local oSection2		
	Local oBreak1	:= Nil	
	Local oBreak2	:= Nil
	
	oReport := TReport():New("TECR015",STR0003,cPerg,{|oReport| PrintReport(oReport)},STR0003)				 //"Demonstrativo de formação de preço"
	oSection1 := TRSection():New(oReport	,STR0004 ,{"TFF"},,,,,,,.T.) //"Produto"
	oSection2 := TRSection():New(oSection1	,STR0014,{"TFF"},,,,,,,.T.) //"Demonstrativo"	
		
	TRCell():New(oSection1,"TFF_PRODUT"		,"TFF"	,STR0004,,,,,,,,,,,,,.T.)	 //"Produto"
	TRCell():New(oSection1,"B1_DESC"		,"SB1"	,STR0006,,,,,,,,,,,,,.T.) //"Descrição"
	TRCell():New(oSection1,"TFL_LOCAL"		,"TFL"	,STR0005,,,,,,,,,,,,,.T.) //"Local de atendimento"
	TRCell():New(oSection1,"ABS_DESCRI"		,"ABS"	,STR0006,,,,,,,,,,,,,.T.) //"Descrição"
	TRCell():New(oSection1,"TFF_QTDVEN"		,"TFF"	,STR0007,,,,,,,,,,,,,.T.) //"Quantidade"
	TRCell():New(oSection1,"TFF_PERINI"		,"TFF"	,STR0008,,,,,,,,,,,,,.T.) //"Per Início"
	TRCell():New(oSection1,"TFF_PERFIM"		,"TFF"	,STR0009,,,,,,,,,,,,,.T.) //"Per Fim"
	TRCell():New(oSection1,"TFF_PRCVEN"		,"TFF"	,STR0010,,,,,,,,,,,,,.T.) //"Preço"
	
	
	
	TRCell():New(oSection2,"ZZZ_CAMPO","",STR0011,,,,,,,,,,.T.,,,) //"Campo"
	TRCell():New(oSection2,"ZZZ_DESC","",STR0006,,,,,,,,,,.T.,,,)	 //"Descrição"
	TRCell():New(oSection2,"ZZZ_VALOR","",STR0012,,,,,,,,,,.T.,,,) //"Valor"
	TRCell():New(oSection2,"ZZZ_FORM","",STR0013,,,,,,,,,,.T.,,,) //"Formula"
	
	oBreak1 := TRBreak():New( oSection1,{|| QRY_TFF->REC} )
	oBreak2 := TRBreak():New( oSection2,{|| QRY_TFF->REC} )
		
Return oReport


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

@author  Matheus Lando Raimundo
@version P12
@since 	 16/02/2017
@return 
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)	
	Local oSection2 := oReport:Section(1):Section(1)										
	Local cCodOrc	:= MV_PAR01
	Local nI		:= 1
	Local cExpLoc	:= "% 0 = 0 %"
	Local cExpRH	:= "% 0 = 0 %"	
	
	If !Empty(MV_PAR02)
		cExpLoc := "% TFL.TFL_CODIGO = '" + MV_PAR02 + "'%"		
	EndIf

	If !Empty(MV_PAR03)
		cExpRH := "% TFF.TFF_COD = '" + MV_PAR03 + "'%"		
	EndIf  
	
			
	//Busca os dados da Secao principal
	oSection1:BeginQuery()
	BeginSql alias "QRY_TFF"			 		 				
		SELECT TFF.R_E_C_N_O_ REC, TFL.TFL_LOCAL, ABS.ABS_DESCRI, TFF_PRODUT, SB1.B1_DESC, TFF_QTDVEN, TFF_PERINI, TFF_PERFIM, TFF_PRCVEN FROM %table:TFF% TFF			
			INNER JOIN %table:TFL% TFL ON TFL_FILIAL = %xfilial:TFL% AND TFF.TFF_CODPAI = TFL.TFL_CODIGO
			INNER JOIN %table:ABS% ABS ON ABS_FILIAL = %xfilial:ABS% AND ABS.ABS_LOCAL = TFL.TFL_LOCAL
			INNER JOIN %table:SB1% SB1 ON SB1.B1_FILIAL = %xfilial:SB1% AND SB1.B1_COD = TFF.TFF_PRODUT
			
			WHERE TFF.TFF_FILIAL = %xfilial:TFF% 			
			AND TFL.TFL_CODPAI = %Exp:cCodOrc%
			AND (TFF.TFF_TABXML <> '' OR TFF.TFF_TABXML IS NOT NULL) 
			AND %Exp:cExpLoc%
			AND %Exp:cExpRH%
			AND SB1.%notDel%
			AND ABS.%notDel%
			AND TFF.%notDel%
			AND TFL.%notDel%
			 					
	EndSql
	
	oSection1:EndQuery()
	oSection1:SetParentQuery(.F.)
		
	oSection1:Init()
	While QRY_TFF->(!Eof())
		oSection1:PrintLine()
		
		TFF->(DbGotO(QRY_TFF->(REC)))
		cXml := TFF->TFF_TABXML 	 	
		
		aDados := U_getDataXML(cXml)
		oSection2:Init()
		For nI := 1 To Len(aDados)			
			oSection2:Cell("ZZZ_CAMPO"):SetBlock( {||AllTrim(aDados[nI,1])})
			oSection2:Cell("ZZZ_DESC"):SetBlock( {||AllTrim(aDados[nI,2])})
			oSection2:Cell("ZZZ_VALOR"):SetBlock( {||AllTrim(aDados[nI,3])})				
			oSection2:Cell("ZZZ_FORM"):SetBlock( {||AllTrim(aDados[nI,4])})
	 		oSection2:PrintLine()
	 	Next nI	
	 	QRY_TFF->(DbSkip())
	EndDo	
Return


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} getDataXML

@author  Matheus Lando Raimundo
@version P12
@since 	 28/06/2018
@return 
/*/
//-------------------------------------------------------------------------------------
User Function getDataXML(cXML)
Local aRet 	  	:= {}
Local oXml 	    := ""
Local cError	:= ""
Local cWarning  := ""
Local nI		:= 1
Local aItens	:= {}

oXml := XmlParser( cXml, "_", @cError, @cWarning )
aItens := oXml:_FWMODELSHEET:_MODEL_SHEET:_MODEL_CELLS:_ITEMS:_ITEM

For nI := 1 To Len(aItens)
	If Mod(nI,2) <> 0 .And. Len(aItens) <> nI 
		Aadd(aRet, {aItens[nI + 1]:_NICKNAME:TEXT, aItens[nI]:_VALUE:TEXT, aItens[nI + 1]:_VALUE:TEXT, aItens[nI + 1]:_FORMULA:TEXT, aItens[nI + 1]:_PICTURE:TEXT})
	EndIf	
Next nI 

Return aRet

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} At15GerExc

@author  Matheus Lando Raimundo
@version P12
@since 	 13/08/2018
@return 
/*/
//-------------------------------------------------------------------------------------
User Function At15GerExc()
Local cCodOrc	:= MV_PAR01	
Local cError	:= ""
Local cWarning	:= ""
Local cXml 		:= ""
Local oFWSheet	:= Nil
Local oExcel 	:= Nil 
Local cPlan		:= ""
Local aDados	:= {}
Local nY		:= 0
Local nW		:= 0
Local cFile		:= ""
Local xValor	:= ""
Local cExpRH	:= "% 0 = 0 %"
Local cExpLoc	:= "% 0 = 0 %"
Local lCriaObj 		:= .F.
	
If !Empty(MV_PAR02)
	cExpLoc := "% TFL.TFL_CODIGO = '" + MV_PAR02 + "'%"		
EndIf

If !Empty(MV_PAR03)
	cExpRH := "% TFF.TFF_COD = '" + MV_PAR03 + "'%"		
EndIf  
	
BeginSql alias "QRY_TFF"			 		 							
	SELECT TFF.R_E_C_N_O_ REC, TFF_COD FROM %table:TFF% TFF
		INNER JOIN %table:TFL% TFL ON TFL_FILIAL = %xfilial:TFL% AND TFF.TFF_CODPAI = TFL.TFL_CODIGO				
		
		WHERE TFF.TFF_FILIAL = %xfilial:TFF% 			
		AND TFL.TFL_CODPAI = %Exp:cCodOrc%
		AND (TFF.TFF_CALCMD <> '' OR TFF.TFF_CALCMD IS NOT NULL) 
		AND %Exp:cExpLoc%
		AND %Exp:cExpRH%		
		AND TFF.%notDel%
		AND TFL.%notDel%
		 					
EndSql

While QRY_TFF->(!Eof())

	If !lCriaObj
		oExcel := FWMSExcel():New() // Define o objeto
		lCriaObj := .T.
	EndIf
	
	TFF->(DbGotO(QRY_TFF->(REC)))
	cXml := TFF->TFF_CALCMD
	oFWSheet := FWUIWorkSheet():New(,.F. ) //instancia a planilha sem exibição
	oFWSheet:LoadXmlModel(cXml)
		
	oExcel:AddworkSheet(Alltrim(TFF->TFF_COD)) // Define o titulo da planilha 
	oExcel:AddTable(Alltrim(TFF->TFF_COD),cPlan)
	 
	For nY := 1 To Len(oFWSheet:aCells) //linha
		For nW := 2 To Len(oFWSheet:aCells[nY]) //Coluna
			xValor := oFWSheet:aCells[nY][nW]
			If nY == 1
				oExcel:AddColumn(Alltrim(TFF->TFF_COD),cPlan,Iif(ValType(xValor) == "U","",xValor),2,1)
			Else
				aAdd(aDados,Iif(ValType(xValor) == "U","",xValor))
			EndIf 
		Next nW
 		If nY != 1 			
			oExcel:AddRow(Alltrim(TFF->TFF_COD),cPlan,aDados)		
			aDados := {}
		EndIf
	Next nY
	
	oFWSheet := Nil  
	QRY_TFF->(DbSkip())
EndDo

If lCriaObj
	oExcel:Activate()
	
	cFile := cGetFile(STR0015,STR0016,1,"C:\",.F.,nOR(GETF_LOCALHARD,GETF_LOCALFLOPPY),.T.,.T.) //'Arquivo XML|*.xml'#'Salvar Planilha'
	
	If !Empty(cFile)
		If At('.xml',cFile) == 0
			cFile := cFile+'.xml'
		EndIf
		
		oExcel:GetXMLFile(cFile)
		
		If File(cFile)
			If MsgYesNo(STR0017)			
				MsgRun(STR0018, STR0019,{|| ShellExecute("open",cFile ,"","",2) } ) //'Verificando alocacao da equipe '						
			EndIf		
		Else
			Help(,,"AT015NGER",,STR0020,1,0) 				
		EndIf
	EndIf	
Else
	Help(,,"AT015NREG",,STR0021,1,0)		
EndIf


Return 

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} at015Loc 
Filtra os locais do orçamento

@author  Matheus Lando Raimundo
@version P12
@since 	 13/08/2018
@return 
/*/
//-------------------------------------------------------------------------------------
User Function at015Loc()
Local lRet           := .F.
Local oBrowse        := Nil
Local cAls              := GetNextAlias()
Local nSuperior      := 0
Local nEsquerda      := 0
Local nInferior      := 0
Local nDireita       := 0
Local oDlgTela := Nil
Local cQry   := ""
//Definição do índice da Consulta Padrão
Local aIndex := {"ABS_LOCAL"}
//Definição da Descrição da Chave de Pesquisa da Consulta Padrão
Local aSeek := {{ STR0022, {{STR0023,"C",TamSx3('TFL_CODIGO')[1],0,"",,}} }}
Local cCodOrc := MV_PAR01
Local cRet := ""
Local cPictTot := PesqPict("TFL","TFL_TOTMC")

cQry := " SELECT " 
cQry += " ABS_FILIAL, "
cQry += " TFL_CODIGO,"
cQry += " ABS_LOCAL, "  	
cQry += " ABS_DESCRI, "
cQry += " TFL_DTINI,"  
cQry += " TFL_DTFIM,"  
cQry += " TFL_TOTRH,"
cQry += " TFL_TOTMI,"
cQry += " TFL_TOTMC,"
cQry += " TFL_TOTLE"    
cQry += " FROM " + RetSqlName("ABS") + " ABS "  
cQry += " INNER JOIN " + RetSqlName("TFL") + " TFL "
cQry += " ON TFL.TFL_FILIAL = '" +   xFilial('TFL') + "'"
cQry += " AND TFL.TFL_LOCAL = ABS.ABS_LOCAL "  
cQry += " AND TFL.D_E_L_E_T_=' '"  
cQry += " AND TFL_CODPAI =  '" + cCodOrc  + "'"
cQry += " WHERE ABS_FILIAL = '" +  xFilial('ABS') + "'"
cQry += " AND ABS.D_E_L_E_T_=' '"
  
nSuperior := 0
nEsquerda := 0
nInferior := 460
nDireita  := 800

DEFINE MSDIALOG oDlgTela TITLE STR0022 FROM nSuperior,nEsquerda TO nInferior,nDireita PIXEL 
 
oBrowse := FWFormBrowse():New()
oBrowse:SetDescription(STR0022) 
oBrowse:SetAlias(cAls)
oBrowse:SetDataQuery()
oBrowse:SetQuery(cQry)
oBrowse:SetOwner(oDlgTela)
oBrowse:SetDoubleClick({ || cRet := (oBrowse:Alias())->TFL_CODIGO,  , lRet := .T., oDlgTela:End()})
oBrowse:AddButton( OemTOAnsi(STR0024), {|| cRet := (oBrowse:Alias())->TFL_CODIGO,  lRet := .T., oDlgTela:End()},, 2 )
oBrowse:AddButton( OemTOAnsi(STR0025),  {|| cRet := "", oDlgTela:End()} ,, 2 )
oBrowse:DisableDetails()
oBrowse:SetQueryIndex(aIndex)
oBrowse:SetSeek(,aSeek)

ADD COLUMN oColumn DATA { ||  ABS_FILIAL } TITLE STR0026 SIZE TamSx3('ABS_FILIAL')[1] OF oBrowse
ADD COLUMN oColumn DATA { ||  TFL_CODIGO } TITLE STR0027 SIZE TamSx3('TFL_CODIGO')[1] OF oBrowse
ADD COLUMN oColumn DATA { ||  ABS_LOCAL} TITLE STR0028 SIZE TamSx3('ABS_LOCAL')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  ABS_DESCRI } TITLE STR0029 SIZE TamSx3('ABS_DESCRI')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFL_TOTRH,cPictTot) } TITLE STR0032 SIZE TamSx3('TFL_TOTRH')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFL_TOTMI,cPictTot) } TITLE STR0033 SIZE TamSx3('TFL_TOTMI')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFL_TOTMC,cPictTot) } TITLE STR0034 SIZE TamSx3('TFL_TOTMC')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFL_TOTLE,cPictTot) } TITLE STR0035 SIZE TamSx3('TFL_TOTLE')[1]  OF oBrowse



If !IsBlind()            
	oBrowse:Activate()
	
	ACTIVATE MSDIALOG oDlgTela CENTERED
EndIf	
 
If lRet
	cLocal := cRet 
EndIf
     
     
Return lRet

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} at015RetLc 
Filtra os locais do orçamento
Retorna o local selecionado
@author  Matheus Lando Raimundo
@version P12
@since 	 13/08/2018
@return 
/*/
//-------------------------------------------------------------------------------------
User Function at015RetLc()

Return cLocal


//-------------------------------------------------------------------
/*/{Protheus.doc} U_At015PrdRH()
Filtra os itens de rh do orçamento


@author Matheus Lando Raimundo      

/*/
//------------------------------------------------------------------
User Function At015PrdRH()

Local lRet           := .F.
Local oBrowse        := Nil
Local cAls              := GetNextAlias()
Local nSuperior      := 0	
Local nEsquerda      := 0
Local nInferior      := 0
Local nDireita       := 0
Local oDlgTela := Nil
Local cQry   := ""
//Definição do índice da Consulta Padrão
Local aIndex := {"TFF_PRODUT"}
//Definição da Descrição da Chave de Pesquisa da Consulta Padrão
Local aSeek := {{ STR0036, {{STR0037,"C",TamSx3("TFF_PRODUT")[1],0,"",,}} }}
Local cCodOrc := MV_PAR01
Local cLocal := MV_PAR02
Local cPictQtd := PesqPict("TFF","TFF_QTDVEN")
Local cPictPrc := PesqPict("TFF","TFF_PRCVEN")
Local cRet := ""

cQry := " SELECT " 
cQry += " TFF_FILIAL,"
cQry += " TFF_COD, "
cQry += " TFF_PRODUT, "
cQry += " B1_DESC, "
cQry += " TFF_QTDVEN, "
cQry += " TFF_PRCVEN, "
cQry += " TFF_PERINI, "
cQry += " TFF_PERFIM "  
cQry += " FROM " + RetSqlName("TFF") + " TFF "
cQry += " INNER JOIN " + RetSqlName("SB1") + " SB1 "
cQry += " ON SB1.B1_FILIAL = '" +  xFilial('SB1') + "'"
cQry += " AND SB1.B1_COD = TFF.TFF_PRODUT"  
cQry += " AND SB1.D_E_L_E_T_=' '"

cQry += " INNER JOIN " + RetSqlName("TFL") + " TFL "
cQry += " ON TFL.TFL_FILIAL = '" +  xFilial('TFL') + "'"
cQry += " AND TFL.TFL_CODPAI = '"  + cCodOrc + "'"
cQry += " AND TFL.TFL_CODIGO = '"  + cLocal + "'"
cQry += " AND TFL.TFL_CODIGO = TFF.TFF_CODPAI"
cQry += " AND TFL.D_E_L_E_T_=' '"
  
cQry += " WHERE TFF_FILIAL = '" + xFilial('TFF') + "'"
cQry += " AND TFF.D_E_L_E_T_=' '"
  
nSuperior := 0
nEsquerda := 0
nInferior := 460
nDireita  := 800

DEFINE MSDIALOG oDlgTela TITLE STR0037 FROM nSuperior,nEsquerda TO nInferior,nDireita PIXEL 
 
oBrowse := FWFormBrowse():New()
oBrowse:SetDescription(STR0036) 
oBrowse:SetAlias(cAls)
oBrowse:SetDataQuery()
oBrowse:SetQuery(cQry)
oBrowse:SetOwner(oDlgTela)
oBrowse:SetDoubleClick({ || cRet := (oBrowse:Alias())->TFF_COD,  lRet := .T., oDlgTela:End()})
oBrowse:AddButton( OemTOAnsi(STR0024), {|| cRet := (oBrowse:Alias())->TFF_COD, lRet := .T.,  oDlgTela:End()},, 2 )
oBrowse:AddButton( OemTOAnsi(STR0025),  {|| cRet := "", oDlgTela:End()} ,, 2 )
oBrowse:DisableDetails()
oBrowse:SetQueryIndex(aIndex)
oBrowse:SetSeek(,aSeek)

ADD COLUMN oColumn DATA { ||  TFF_FILIAL } TITLE STR0026 SIZE TamSx3('TFF_FILIAL')[1] OF oBrowse
ADD COLUMN oColumn DATA { ||  TFF_COD} TITLE STR0027 SIZE TamSx3('TFF_COD')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  TFF_PRODUT } TITLE STR0037 SIZE TamSx3('TFF_PRODUT')[1] OF oBrowse
ADD COLUMN oColumn DATA { ||  B1_DESC } TITLE STR0029 SIZE TamSx3('B1_DESC')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFF_QTDVEN, cPictQtd)  } TITLE STR0038 SIZE TamSx3('TFF_QTDVEN')[1]  OF oBrowse
ADD COLUMN oColumn DATA { ||  Transform(TFF_PRCVEN, cPictPrc)  } TITLE STR0038 SIZE TamSx3('TFF_PRCVEN')[1]  OF oBrowse

If !IsBlind()             
	oBrowse:Activate()
	
	ACTIVATE MSDIALOG oDlgTela CENTERED
EndIf

If lRet
	cItemRH := cRet 
EndIf

     
Return lRet

//-------------------------------------------------------------------
/*/{Protheus.doc} U_at015RetRH()
Retorna o item de RH selecionado


@author Matheus Lando Raimundo      

/*/
//------------------------------------------------------------------
User Function at015RetRH()

Return cItemRH
