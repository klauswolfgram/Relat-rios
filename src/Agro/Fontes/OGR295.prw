/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.ch
#INCLUDE 'TopConn.ch'
#INCLUDE 'OGR295.ch'

/** {Protheus.doc} OGR295
Listagem Romaneios de Entregas do Produtor (Vulgo Ext. Produtor na Sementes Goias)
Este rel. foi elaborado de acordo com a necessidade da Sementes Goias
@param: 	Nil
@author: 	Emerson coelho
@since: 	25/03/2015
@Uso: 		Agro Industria
@type function
*/
//--< variáveis >---------------------------------------------------------------------------
Static cPerg	 	:= "OGR295"
Static oBreak1,oBreak2,oBreak3,oBreak1B,oBreak3B
Static lPlanilha
Static oReport,oSec2,oSec3
Static _nResPad	:= 50
//--Colunas com Posições Fixas--//
Static nPoscolA := 10 //110 //FILIAL
Static nPoscolB := 120 //160 //EMISSAO 
Static nPoscolC := 280 //55 //TIPO
Static nPoscolD := 320 //160 //ROMANEIO 
Static nPoscolE := 480 //110 //CONTRATO
Static nPoscolF := 590 //90 //PLACA
Static nPoscolG := 680 //255 //1 PESAGEM 
Static nPoscolH := 930 //255 //2 PESAGEM 
Static nPoscolI := 1180 //215 //LIG SEM DESCONTO(BRUTO)
Static nPoscolJ := 1395 //250//DESCONTO
Static nPoscolK := 1645 // 255 //PESO LIQUIDO
Static nPoscolK1 := 1905 //145 //NF

Static nPoscolL := 2050//170 //TRANSGENIA
Static nPoscolM := 2220 //70
Static nPoscolN := 2290 //120
Static nPoscolO := 2410 //70
Static nPoscolP := 2480 //120
Static nPoscolQ := 2600 //70
Static nPoscolR := 2670 //120
Static nPoscolS := 2790 //70
Static nPoscolT := 2860 //120
Static nPoscolU := 2980 //70
Static nPoscolV := 3050	//120		
Static nPoscolX := 3170 //70
Static nPoscolZ := 3240 //----
Static lTemdado := .f.
Static __lAutomato   := IiF(IsBlind(),.T.,.F.) 
Static _cPicTotPeso := "999,999,999" //picture padrão para os campos de totais das colunas dos pesos do romaneio
Static _nTamTotPeso := 14 //tamanho padrão para os campos de totais das colunas dos pesos do romaneio
Static cCodCtr := ''
/** {Protheus.doc} OGR295
Relatorio Extrato do Produtor - imprime relatorio conforme dados definidos nos parametros do relatorio.
@author Emerson coelho
@since	25/03/2015
@Uso 	Agro Industria
@type function
*/
User Function OGR295()	
	
	Pergunte(cPerg,.f.)

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/** {Protheus.doc} OGR295
Montando a estrutura/layout do tReport
@author 	Emerson coelho
@since 	25/03/2015
@Uso 		Agro Industria
@type function
*/
Static Function ReportDef()
	Local nI	:=	0
	Local aPicture := {}

	If _nTamTotPeso < TamSX3("NJJ_PSLIQU")[1]
		_nTamTotPeso := TamSX3("NJJ_PSLIQU")[1]
	EndIf
	
	aPicture := AGRGerPic(_nTamTotPeso,TamSX3("NJJ_PSLIQU")[2],)
	_cPicTotPeso := IIF((Len(aPicture) > 2 .and. aPicture[1] == .T.) , aPicture[2], "999,999,999")
    
//Montando o objeto oReport
	oReport := TReport():NEW("OGR295", STR0001, cPerg, {|oReport|PrintReport(oReport)}, STR0001) //"Listagem de Romaneios Por Entidade,loja e produto"

//Para não imprimir a página de parâmetros
	oReport:lParamPage := .f.
	oReport:GetOrientation(2)
	oreport:nFontBody := 6
	oReport:CFONTBODY			:= "Courier New"
	oReport:nLineHeight:=30
	oReport:SetDevice(2) //iMPRESSORA
	oReport:oPage:setPaperSize(9) // 9 e 10 sao A4
	
	oSec2 := TRSection():New(oReport,STR0002,{}) //"Romaneios"
	
	oSec2:SettotalInline(.f.)
	osec2:lbold:=.f.

	oSec2:lAutosize:=.f.
	osec2:llinebreak:=.f.
	oSec2:lEdit	:= .f. // Usu n. pode editar a secao
	
	oSec2:SetHeaderSection(.f.)
	TRCell():New(oSec2,"Filial"			,"",STR0003	,'@!'							,08	,.f.) //'Filial'
	TRCell():New(oSec2,"EMISSAO"		,"",STR0004 ,PesqPict('NJJ',"NJJ_DOCEMI")	,10	,.f.) //'Emissão   '
	TRCell():New(oSec2,"TPMVTO"			,"",STR0005 ,"@!"							,2	,.f.) //'TP'	
	TRCell():New(oSec2,"ROMAN"			,"",STR0006 ,'@!'							,10	,.f.) //'Romaneio  '	 
	TRCell():New(oSec2,"CONTRATO"		,"",STR0007	,'@!'							,08	,.f.) //'Contrato'
	TRCell():New(oSec2,"PLACA"     		,"",STR0008	,'@!'		         			,08	,.f.) //"Placa   "
	TRCell():New(oSec2,"PESO1"     		,"",STR0009	, _cPicTotPeso					,_nTamTotPeso	,.f.) //"   1aPesagem"
	TRCell():New(oSec2,"PESO2"     		,"",STR0010	, _cPicTotPeso					,_nTamTotPeso	,.f.) //"   2aPesagem"
	TRCell():New(oSec2,"PESOBRUTO"    	,"",STR0011	, _cPicTotPeso					,_nTamTotPeso	,.f.) //"  Liq S/Desc"
	TRCell():New(oSec2,"DESCONTOS"      ,"",STR0012	, _cPicTotPeso					,_nTamTotPeso	,.f.) //" Descontos"
	TRCell():New(oSec2,"PESOLIQ"     	,"",STR0013	, _cPicTotPeso					,_nTamTotPeso	,.f.) //"   P.Liquido"
	TRCell():New(oSec2,"DOCTO"     		,"",STR0014	,'@!'							,TamSX3("NJM_DOCNUM" )[1],.f.) //"Docto     "	
	TRCell():New(oSec2,"TRANSGENIA"   	,"",PADL(STR0015,30)	,'@!'				,30	,.f.) //"Transgenia"
	
	/*/ Lembrando o Cab. das Celulas de desconto são dianmicos de acordo com o Mv_par19
		Defino as Cells de Descto com o Header da Cell definido para imprimir em Planilha, Antes de
	  	imprimir verifico se o user escolheu outro device então re-ajusto o Kbeçalho da seçaõ para
	  	ficar em um formato Visivel e q caiba no papel A4
	/*/
	
	/*Totais*/
	oSec3 := TRSection():New(oReport,"Totais",{}) //"Totais"
	oSec3:SettotalInline(.f.)
	osec3:lbold:=.f.
	oSec3:lAutosize:=.f.
	osec3:llinebreak:=.f.
	oSec3:lEdit	:= .f. 
	
	TRCell():New(oSec3,"PRODUTO"		,"","Produto" ,PesqPict('SB1',"B1_DESC")   	,30	,.f.) //'Produto   '
	TRCell():New(oSec3,"PESO1"     		,"",STR0009	, _cPicTotPeso	,12	,.f.) //"   1aPesagem"
	TRCell():New(oSec3,"PESO2"     		,"",STR0010	, _cPicTotPeso	,12	,.f.) //"   2aPesagem"
	TRCell():New(oSec3,"PESOBRUTO"    	,"",STR0011	, _cPicTotPeso	,12	,.f.) //"  Liq S/Desc"
	TRCell():New(oSec3,"DESCONTOS"      ,"",STR0012	, _cPicTotPeso	,12	,.f.) //" Descontos"
	TRCell():New(oSec3,"PESOLIQ"     	,"",STR0013	, _cPicTotPeso	,12	,.f.) //"   P.Liquido"
	
	aAux	:= {}
	aAdd(aAux,'')
	aAdd(aAux,'')
	aAdd(aAux,'')
	aAdd(aAux,'')
	aAdd(aAux,'')
	aAdd(aAux,'')
	aAuxA 	:= separa(MV_PAR19, ';')
	
	For nI := 1 to Len(aAuxa)
	  aAux[nI] := aAuxa[ni]
	nExt
		
	TRCell():New(oSec2,"VRDESC1"    	,"",aAux[1] + " " + STR0016,'@E 99.99'						,07,.f.)
	TRCell():New(oSec2,"DESC1"     		,"",aAux[1] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec2,"VRDESC2"    	,"",aAux[2] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec2,"DESC2"     		,"",aAux[2] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec2,"VRDESC3"    	,"",aAux[3] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec2,"DESC3"     		,"",aAux[3] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec2,"VRDESC4"    	,"",aAux[4] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec2,"DESC4"     		,"",aAux[4] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec2,"VRDESC5"    	,"",aAux[5] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec2,"DESC5"     		,"",aAux[5] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec2,"VRDESC6"    	,"",aAux[6] + " " + STR0016,'@E 99.99'						,07,.f.)
	TRCell():New(oSec2,"DESC6"     		,"",aAux[6] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	
	/*totais*/
	TRCell():New(oSec3,"VRDESC1"    	,"",aAux[1] + " " + STR0016,'@E 99.99'						,07,.f.)
	TRCell():New(oSec3,"DESC1"     		,"",aAux[1] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec3,"VRDESC2"    	,"",aAux[2] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec3,"DESC2"     		,"",aAux[2] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec3,"VRDESC3"    	,"",aAux[3] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec3,"DESC3"     		,"",aAux[3] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec3,"VRDESC4"    	,"",aAux[4] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec3,"DESC4"     		,"",aAux[4] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec3,"VRDESC5"    	,"",aAux[5] + " " + STR0016,'@E 99.99'						,07	,.f.)
	TRCell():New(oSec3,"DESC5"     		,"",aAux[5] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	TRCell():New(oSec3,"VRDESC6"    	,"",aAux[6] + " " + STR0016,'@E 99.99'						,07,.f.)
	TRCell():New(oSec3,"DESC6"     		,"",aAux[6] + " " + STR0017,'@E 9999,999'					,09	,.f.)
	
	//--Ajustando alinhamento das Celulas e Tit;Cabeçalho dos Descontos--//
		
	oSec2:Cell( "PESO1"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "PESO1"		):SetAlign('RIGHT' )
	     
	oSec2:Cell( "PESO2" 	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "PESO2" 	):SetAlign('RIGHT' )
	     
	oSec2:Cell( "PESOBRUTO"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "PESOBRUTO"	):SetAlign('RIGHT' )
		
	oSec2:Cell( "DESCONTOS"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESCONTOS"	):SetAlign('RIGHT' )
		 
	oSec2:Cell( "PESOLIQ"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "PESOLIQ"	):SetAlign('RIGHT' )
	
	oSec2:Cell( "VRDESC1"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC1"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC1"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC1"		):SetAlign('RIGHT' )
	     
	oSec2:Cell( "VRDESC2"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC2"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC2"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC2"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC3"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC3"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC3"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC3"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC4"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC4"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC4"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC4"		):SetAlign('RIGHT' )
	     
	oSec2:Cell( "VRDESC5"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC5"	):SetAlign('RIGHT' )
	   	
	oSec2:Cell( "DESC5"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC5"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC6"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC6"	):SetAlign('RIGHT' )
           
	oSec2:Cell( "DESC6"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC6"		):SetAlign('RIGHT' )
	
	
	/**TOTAIS**/
	oSec3:Cell( "PESO1"		):SetHeaderAlign('RIGHT' )
	oSec3:Cell( "PESO1"		):SetAlign('RIGHT' )
	     
	oSec3:Cell( "PESO2" 		):SetHeaderAlign('RIGHT' )
	oSec3:Cell( "PESO2" 		):SetAlign('RIGHT' )
	     
	oSec3:Cell( "PESOBRUTO"	):SetHeaderAlign('RIGHT' )
	oSec3:Cell( "PESOBRUTO"	):SetAlign('RIGHT' )
		
	oSec2:Cell( "DESCONTOS"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESCONTOS"	):SetAlign('RIGHT' )
		 
	oSec2:Cell( "PESOLIQ"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "PESOLIQ"	):SetAlign('RIGHT' )
	
	oSec2:Cell( "VRDESC1"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC1"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC1"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC1"		):SetAlign('RIGHT' )
	     
	oSec2:Cell( "VRDESC2"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC2"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC2"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC2"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC3"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC3"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC3"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC3"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC4"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC4"	):SetAlign('RIGHT' )
		   
	oSec2:Cell( "DESC4"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC4"		):SetAlign('RIGHT' )
	     
	oSec2:Cell( "VRDESC5"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC5"	):SetAlign('RIGHT' )
	   	
	oSec2:Cell( "DESC5"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC5"		):SetAlign('RIGHT' )
		     
	oSec2:Cell( "VRDESC6"	):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "VRDESC6"	):SetAlign('RIGHT' )
           
	oSec2:Cell( "DESC6"		):SetHeaderAlign('RIGHT' )
	oSec2:Cell( "DESC6"		):SetAlign('RIGHT' )
	

	oBreak1 := TRBreak():New( oSec2, {||QryNJM->(NJM_CODENT + NJM_LOJENT+NJM_CODPRO)}	, /*{||fSaltaPage(3)}*/) 	// "Total do PRODUTO
	oBreak1B := TRBreak():New( oSec2, {||QryNJM->(NJM_CODENT + NJM_LOJENT+NJM_CODPRO)}	, /*{||fSaltaPage(3)}*/) 	// "Total de MOVIMENTOS POR PRODUTO
	oBreak2 := TRBreak():New( oSec2, {||QryNJM->(NJM_CODENT + NJM_LOJENT)}				, /*{||fSaltaPage(3)}*/) 	// 	"Total da Loja
	oBreak3 := TRBreak():New( oSec2, {||QryNJM->NJM_CODENT}								, /*{||fSaltaPage(3)}*/) 	//	Total a Entidade
	oBreak3B := TRBreak():New( oSec2, {||QryNJM->NJM_CODENT}								, /*{||fSaltaPage(3)}*/) 	//	Total de MOVIMENTOS POR ENTIDADE

	///TRFUNCTION():New(oCell,cName,cFunction,oBreak,cTitle,cPicture,uFormula,lEndSection,lEndReport,lEndPage,oParent,bCondition,lDisable,bCanPrint) 
	TRFunction():New(oSec2:Cell("PESO1")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESO2")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOBRUTO")	,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESCONTOS")	,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOLIQ")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC1")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC1")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC2")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC2")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC3")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC3")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC4")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC4")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC5")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC5")		,,"SUM",	oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC6")		,,"AVERAGE",oBreak1,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC6")		,,"SUM",	oBreak1,,,, .f., .f. )

	TRFunction():New(oSec2:Cell("PESO1")		,,"COUNT",	oBreak1B,,,, .f., .f. )	
		
	TRFunction():New(oSec2:Cell("PESO1")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESO2")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOBRUTO")	,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESCONTOS")	,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOLIQ")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC1")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC1")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC2")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC2")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC3")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC3")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC4")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC4")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC5")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC5")		,,"SUM",	oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC6")		,,"AVERAGE",oBreak2,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC6")		,,"SUM",	oBreak2,,,, .f., .f. )
		
	TRFunction():New(oSec2:Cell("PESO1")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESO2")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOBRUTO")	,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESCONTOS")	,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("PESOLIQ")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC1")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC1")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC2")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC2")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC3")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC3")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC4")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC4")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC5")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC5")		,,"SUM",	oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("VRDESC6")		,,"AVERAGE",oBreak3,,,, .f., .f. )
	TRFunction():New(oSec2:Cell("DESC6")		,,"SUM",	oBreak3,,,, .f., .f. )

	TRFunction():New(oSec2:Cell("PESO1")		,,"COUNT",	oBreak3B,,,, .f., .f. )

	oReport:SetLandScape()
	oReport:DisableOrientation()
	 
	oReport:OnPageBreak({|| fPrnCabEsp("P") /*Cabeçalho Principal*/  })  	// Irá Forçar Imprimir o Cabeçalho Especifico
	///oReport:SetPageFooter(2, {|| fRodape()}) n. funciona como deveria
	
Return(oReport)


/** {Protheus.doc} 
    Filtra e imprime a listagem
@author	Emerson coelho
@since	25/03/2015
@Uso 		Agro Industria
@type function
*/

Static Function PrintReport(oReport)
	Local nI			:= 0
	Local limpLine	:= .f.
	Local cFilialIni	:= MV_PAR01
	Local cFilialFim	:= MV_PAR02
	Local cEntidIni 	:= MV_PAR03
	Local cLojaIni 	:= MV_PAR04
	Local cEntidFim 	:= MV_PAR05
	Local cLojaFim 	:= MV_PAR06
	Local cCtrIni		:= MV_PAR07
	Local cCtrFim     := MV_PAR08
	Local cCodSafIni  := MV_PAR09
	Local cCodSafFim  := MV_PAR10
	Local nTpDataLst     :=MV_PAR11
	Local dDtIni        :=MV_PAR12
    Local dDtFim        :=MV_PAR13
    
	Local cGrpPrdIni	:=MV_PAR14
	Local cGrpPrdFim	:=MV_PAR15
	Local cProdutIni 	:=MV_PAR16
	Local cProdutFim	:=MV_PAR17


	Local cIdTransg    	:=MV_PAR18    //--Contera os Tps desctos Ref. a Transgenia, O usuario precisa Informar		--//
	Local cDesctos     	:=MV_PAR19   	//--Contera os Tps Desctos que devem ser impressos no Maximo 6 Para caber em A4 	--//
	Local nTpMvRom		:=MV_PAR20
	Local nTpRom		:=MV_PAR21
	Local cStatusLst    :=MV_PAR22

	
	Local nValor1			:= 0
	Local nDesc1			:= 0
	Local nValor2			:= 0
	Local nDesc2			:= 0
	
	Local nValor3			:= 0
	Local nDesc3			:= 0
	
	Local nValor4			:= 0
	Local nDesc4			:= 0
	
	Local nValor5			:= 0
	Local nDesc5			:= 0
	
	Local nValor6			:= 0
	Local nDesc6			:= 0
	Local nx,x
	
	Local	 cQuery	:= ""
	Local	 cJoinFil	:= ""
    Local    aTotalPro   := {} 
	Local    vVetGera := {0,0,0,0,0}
	
	lPlanilha := IIF(oReport:ndevice = 4, .t.,.f.)
	
	nCont	:= 0
	nPag	:= 1

	oReport:SetPageNumber(nPag)
	oReport:Page(nPag)
	
	cquery:=''
	cQuery += " SELECT "
	cQuery += " 		(CASE "
	cQuery += "  			WHEN NJM.NJM_TIPO  IN ('1' , '3' , '5', '7' , '9','A') THEN 'E'"	//Romaneios de Entrada
	cQuery += "  			WHEN NJM.NJM_TIPO  IN ('2' , '4' , '6', '8' , 'B' ) THEN 'S'"	//Romaneios de Saida
	cQuery += "  		END) AS TPROM, "
	cQuery += " 		SB1.*, NJJ.*, NJM.* , "
	cQuery += " ( "
	cQuery += "	SELECT SUM(NJK.NJK_QTDDES) FROM " + RetSqlName('NJK')+ " NJK "
	cQuery += " WHERE "
	
	  //--Encontrando a Filial do Inner NJK --
    cJoinFil :=''
	If FWModeAccess("NJK") == "E" .And. FWModeAccess("NJM") == "E"
		cJoinFil += "  NJK.NJK_FILIAL = NJM.NJM_FILIAL AND "
	ElseIf FWModeAccess("NJK",3) == "E"
		cJoinFil += " NJK.NJK_FILIAL >= '" + cFilialIni + "' AND "
		cJoinFil += " NJK.NJK_FILIAL <= '" + cFilialFim + "' AND "
	ElseIf FWModeAccess("NJK",2) == "E"
		cJoinFil += " NJK.NJK_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
		cJoinFil += " NJK.NJK_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
	ElseIf FWModeAccess("NJK",1) == "E"
		cJoinFil += " NJK.NJK_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
		cJoinFil += " NJK.NJK_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
	Else
		cJoinFil += " NJK.NJK_FILIAL >= '" + Space(FWSizeFilial()) + "' AND "
		cJoinFil += " NJK.NJK_FILIAL <= '" + Space(FWSizeFilial()) + "' AND "
	EndIf
   //------------------------------------------------------------------------
   	cQuery +=  cJoinfil + " NJK.NJK_CODROM = NJM.NJM_CODROM AND NJK.D_E_L_E_T_ = ' ' "
	
	cQuery += " ) AS DESCONTO "
	cQuery += " FROM " + RetSqlName('NJM')+ " NJM "
	cQuery += " LEFT JOIN " + RetSqlName('SB1')+ " SB1 ON "

    //--Encontrando a Filial do Inner Join SB1 --
    cJoinFil :=''
	If FWModeAccess("SB1") == "E" .And. FWModeAccess("NJM") == "E"
		cJoinFil += "  SB1.B1_FILIAL = NJM.NJM_FILIAL AND "
	ElseIf FWModeAccess("SB1",3) == "E"
		cJoinFil += " SB1.B1_FILIAL >= '" + cFilialIni + "' AND "
		cJoinFil += " SB1.B1_FILIAL <= '" + cFilialFim + "' AND "
	ElseIf FWModeAccess("SB1",2) == "E"
		cJoinFil += " SB1.B1_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
		cJoinFil += " SB1.B1_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
	ElseIf FWModeAccess("SB1",1) == "E"
		cJoinFil += " SB1.B1_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
		cJoinFil += " SB1.B1_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
	Else
		cJoinFil += " SB1.B1_FILIAL >= '" + Space(FWSizeFilial()) + "' AND "
		cJoinFil += " SB1.B1_FILIAL <= '" + Space(FWSizeFilial()) + "' AND "
	EndIf
   //-----------------------------------------------------------------------
	cQuery += cJoinFil +" SB1.B1_COD = NJM.NJM_CODPRO AND SB1.D_E_L_E_T_ = ' '"   		
	
	cQuery += " LEFT JOIN " + RetSqlName('NJJ')+ " NJJ ON "

    //--Encontrando a Filial do Inner Join NJJ --
    cJoinFil :=''
	If FWModeAccess("NJJ") == "E" .And. FWModeAccess("NJM") == "E"
		cJoinFil += "  NJJ.NJJ_FILIAL = NJM.NJM_FILIAL AND "
	ElseIf FWModeAccess("NJJ",3) == "E"
		cJoinFil += " NJJ.NJJ_FILIAL >= '" + cFilialIni + "' AND "
		cJoinFil += " NJJ.NJJ_FILIAL <= '" + cFilialFim + "' AND "
	ElseIf FWModeAccess("NJJ",2) == "E"
		cJoinFil += " NJJ.NJJ_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
		cJoinFil += " NJJ.NJJ_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1)) +Len(FWSM0Layout(,2))),FWSizeFilial()) + "' AND "
	ElseIf FWModeAccess("NJJ",1) == "E"
		cJoinFil += " NJJ.NJJ_FILIAL >= '" + PadR(Substr(cFilialIni,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
		cJoinFil += " NJJ.NJJ_FILIAL <= '" + PadR(Substr(cFilialFim,1,Len(FWSM0Layout(,1))),FWSizeFilial()) + "' AND "
	Else
		cJoinFil += " NJJ.NJJ_FILIAL >= '" + Space(FWSizeFilial()) + "' AND "
		cJoinFil += " NJJ.NJJ_FILIAL <= '" + Space(FWSizeFilial()) + "' AND "
	EndIf
  
 	cQuery += cJoinFil + " NJJ.NJJ_CODROM = NJM.NJM_CODROM AND NJJ.D_E_L_E_T_ = ' '"
 
	cQuery += " WHERE  NJM.NJM_CODENT BETWEEN '" + cEntidIni + "' AND '" + cEntidFim	+ 	"'"
	cQuery += "  	AND NJM.NJM_LOJENT	 BETWEEN '" + cLojaIni + "' AND '" + cLojaFim	+ 	"'"
	cQuery += "  	AND NJM.NJM_CODCTR BETWEEN '" + cCtrIni + "' AND '" + cCtrFim	+	"'"
	cQuery += " 	AND SB1.B1_GRUPO BETWEEN '" + cGrpPrdIni	+ "' AND '" + cGrpPrdFim	+ 	"'"
	cQuery += "	AND NJM.NJM_CODPRO 	BETWEEN '"  	+ cProdutIni 	+ "' AND '" + cProdutFim	+	"'"
	cQuery += "	AND NJM.NJM_CODSAF 	BETWEEN '"		+ cCodSafIni  + "' AND '" + cCodSafFim	+	"'"
	
	// Automacao
	If  __lAutomato
	       cQuery += "  AND NJM.NJM_CODROM = '0000000001'"	
	EndIF
	
	//considera autorização
	If !empty(mv_par24)
		cQuery += "  AND NJM.NJM_CODAUT IN (" + AGRMULTOPQRY(mv_par24) + ")"
	Endif
	
	///cQuery += "	AND NJM.NJM_FILIAL 	= 	'"			+ FwXfilial('NJM') + "'"
	cQuery += "	AND NJM.NJM_FILIAL 	BETWEEN '" 	+ cFilialIni 	+ "' AND '" +	cFilialFim	 + "'"
	IF nTpMvRom == 02 //Considera somente entradas
		cQuery += " AND NJM.NJM_TIPO  IN ('1' , '3' , '5', '7' , '9' , 'A') "
	ElseIF nTpMvRom == 03 //Considera somente Saidas
		cQuery += " AND NJM.NJM_TIPO  IN ('2' , '4' , '6', '8' , 'B') "
	////ElseIF nTpMvRom == 01 // Considera todos os Romaneios //
	EndIF
	
	IF nTpRom == 4 //Considera Romaneios Simbolicos
		cQuery += " AND NJJ.NJJ_TIPENT = '2' "
	ElseIF nTpRom == 3 //Considera Romaneios Gerenciais
		cQuery += " AND NJJ.NJJ_TIPENT = '1' "
	ElseIF nTpRom == 2 //Considera Romaneios Fisicos
		cQuery += " AND NJJ.NJJ_TIPENT = '0' "
	//IF nTpRom == 1 //Considera todos os romaneios..
	EndIF
		
	//considera Paracer da qualidade
	If !empty(mv_par23)
		cQuery += "  AND NJJ.NJJ_LIBQLD IN (" + AGRMULTOPQRY(mv_par23,"N") + ")"
	Endif
	
	if nTpDataLst = 1    //"Data do Romaneio" - "NJJ_DATA";	
	   cQuery += " AND NJJ.NJJ_DATA        BETWEEN '"      + dTOS(dDtIni)      + "' AND '" + dTOs(dDtFim)  +   "'"
	elseif nTpDataLst = 2 // "Data da Pesagem 1" - "NJJ_DATPS1"; 
	   cQuery += " AND NJJ.NJJ_DATPS1      BETWEEN '"      + dTOS(dDtIni)      + "' AND '" + dTOs(dDtFim)  +   "'"
	elseif nTpDataLst = 3 //"Data da Pesagem 2" - "NJJ_DATPS2";
	   cQuery += " AND NJJ.NJJ_DATPS2       BETWEEN '"      + dTOS(dDtIni)      + "' AND '" + dTOs(dDtFim)  +   "'"
	elseif nTpDataLst = 4 //"Emissao do Documento Fiscal" - "NJM_DOCEMI"; 
	   cQuery += " AND NJM.NJM_DOCEMI       BETWEEN '"      + dTOS(dDtIni)      + "' AND '" + dTOs(dDtFim)  +   "'"
	elseif nTpDataLst = 5 // "Data da Transação" -  "NJM_DTRANS"
	   cQuery += " AND NJM.NJM_DTRANS        BETWEEN '"      + dTOS(dDtIni)      + "' AND '" + dTOs(dDtFim)  +   "'"
	endif
	
	//considera os status
	if !empty(cStatusLst)
		
		aListSts  := separa(cStatusLst, ';') //pega todos os status
		cAuxQuery := ""
		
		For nI := 1 to Len(aListSts) Step 1
			if cAuxQuery == ""
				cAuxQuery := "'" + allTrim(aListSts[nI]) + "'"
			else
				cAuxQuery += " , '" + allTrim(aListSts[nI]) + "'"
			endif
		nExt nI
		
		cQuery += "   AND NJJ.NJJ_STATUS IN (" + cAuxQuery + ")"
		
	else
		cQuery += "   AND NJJ_STATUS NOT IN ('4') " // n. listar Cancelados 
	endif
		
	cQuery += "	AND NJM.D_E_L_E_T_ = ' ' "
	
	cquery += " ORDER BY NJJ_FILIAL,NJM.NJM_CODENT, NJM.NJM_LOJENT, NJM.NJM_CODCTR, 1 , NJJ_DATA ASC" //1 é a coluna Calculada por tp.movto Entrada ou Saida

	cQuery:= ChangeQuery(cQuery)

	If select("QryNJM") <> 0
		QryNJM->( dbCloseArea() )
	endif

	TCQUERY cQuery NEW ALIAS "QryNJM"
	
	Count To nRecCount			//Contando o registro da query
		
	oReport:SetMeter( nRecCount )

//-- Visao do Header , quebra na ordem: Entidade,Fazenda(lja),Produto, no Footer é ao contrario 1o/Produto,Fazenda(lja),Entidade --
	cQuebra1 := ''	// Quebra Por Entidade
	cQuebra2 := ''	// Quebra Por Entidade e Loja
	cQuebra3 := ''	//	Quebra Por Produto
	nLine:=0
	
	oSec2:Init()	

	QryNJM->( DbGoTop() )
	nCont := 0

	While (.t.)//QryNJM->(!Eof())
		IF oReport:Cancel()
			Exit
		EndIF
	
		oReport:IncMeter()
		
		//--Verificando se as Quebras iram acontecer na Proxima Linha Se Sim, forço a imprimir os totais--/
		IF oBreak1:Execute(.f.) //Produto
			fSaltaPage(3) //Tenho q imprimir 2 linhas a do total + a linha do rodape
			oReport:SkipLine()
			oreport:PrintText (STR0018 ,oreport:row() 	, 10) //"Total do Produto"
			IIF(lPlanilha, oBreak1:Printtotal(),fTotProd() ) 
			lImpLine := .t.
		EndIF
		IF oBreak1B:Execute(.f.) //MOVIMENTO POR Produto
			fSaltaPage(3) //Tenho q imprimir 2 linhas a do total + a linha do rodape
			oReport:SkipLine()
			oreport:PrintText (STR0096 ,oreport:row() 	, 10) //"Total de Movtos do Produto"
			IIF(lPlanilha, oBreak1B:Printtotal(),fTotMovProd() ) 
			lImpLine := .t.
		EndIF
		IF oBreak2:Execute(.f.) //Loja
			fSaltaPage(3)//Tenho q imprimir 2 linhas a do total + a linha do rodape
			oReport:SkipLine()
			oreport:PrintText (STR0019,oreport:row() 	, 10) //"Total da Loja"
			IIF(lPlanilha, oBreak2:Printtotal(),fTotLoja() )
			lImpLine := .t.
		EndIF
		IF oBreak3:Execute(.f.) //Entidade
			fsaltaPage(3) //Tenho q imprimir 2 linhas a do total + a linha do rodape
			oReport:SkipLine()
			oreport:PrintText (STR0020 ,oreport:row() 	, 10) //"Total da Entidade"
			IIF(lPlanilha, oBreak3:Printtotal(),fTotEnt() )
			lImpLine := .t.
		EndIF
		IF oBreak3B:Execute(.f.) //Entidade
			fsaltaPage(3) //Tenho q imprimir 2 linhas a do total + a linha do rodape
			oReport:SkipLine()
			oreport:PrintText (STR0097 ,oreport:row() 	, 10) //"Total de Movtos da Entidade"
			IIF(lPlanilha, oBreak3B:Printtotal(),fTotMovEnt() )
			lImpLine := .t.
		EndIF
		//-- Qdo Tem Quebra apos o Total , preciso imprimir uma Linha para separar o total dos titulos Entidade,Loja,Produto --//
		IF limpLine == .t.
			IF !fSaltaPage(2)
			    oReport:SkipLine()
				oReport:Fatline()
				limpline := .f.
			EndIF
		EndIF
		
		//--Se for fim de arquivo deve-se Sair do Loop-//
		IF QryNJM->(Eof())
		   Exit
		EndIf
		//--------------------------------------------//
		
	// -- Verificando se A Entidade Mudou Para imprimir os Dados da Entidade -- //	
		IF cQuebra1 != QryNJM->NJM_CODENT
			cQuebra1 	:= QryNJM->NJM_CODENT
			cAux		:= AlltRim(QryNJM->NJM_CODENT) + "-" + POSICIONE('NJ0',1,XFILIAL('NJ0')+QryNJM->NJM_CODENT+QryNJM->NJM_LOJENT,'NJ0_NOME')
			oreport:nFontBody 	:=08 //Aumento a Fonte Para 08
		
			fSaltaPage(2) ////Verifica se precisa Saltar a Pagina
			oreport:PrintText ( cAux 			,oreport:row() 	, 10)
			oreport:SkipLine(2) //oreport:incrow(50) // Pula 25 Pixels
		EndIF
	// -- Verificando se A Entidade e Loja Mudou Para imprimir os Dados da Loja (Fazenda)-- //
		IF cQuebra2 != QryNJM->(NJM_CODENT 	+ NJM_LOJENT)
			cQuebra2 	:= QryNJM->(NJM_CODENT 	+ NJM_LOJENT)
			cAux		:= Alltrim(QryNJM->NJM_CODENT) 	+ '-' + QryNJM->NJM_LOJENT + "-" + POSICIONE('NJ0',1,XFILIAL('NJ0')+QryNJM->NJM_CODENT+QryNJM->NJM_LOJENT,'NJ0_NOMLOJ')
			cAux		+= " - " + STR0021 //"Inscrição :"
			cAux		+= Alltrim(Posicione( "NJ0", 1, xFilial( "NJ0" ) + QryNJM->( NJM_CODENT+NJM_LOJENT ), "NJ0_INSCR" ))
			
			oreport:nFontBody := 08 //Aumento a Fonte Para 08
			
			fSaltaPage(2) //Verifica se precisa Saltar a Pagina
			oreport:PrintText ( cAux 			,oreport:row() 	, 30)
			oreport:SkipLine(2)//oreport:incrow(50) // Pula 25 Pixels
		EndIF
			
	// -- Verificando Se o Produto Mudou Para imprimir os Dados do Produto-- //
		IF cQuebra3 != QryNJM->(NJM_CODENT + NJM_LOJENT 	+ NJM_CODPRO )
			cQuebra3	:= QryNJM->(NJM_CODENT + NJM_LOJENT 	+ NJM_CODPRO )
			cAux		:= AllTrim(QryNJM->NJM_CODPRO)  + "-"		+ QryNJM->B1_DESC 	

			oreport:nFontBody := 08 //Aumento a Fonte Para 08
			
			fSaltaPage(2) //Verifica se precisa Saltar a Pagina
			oreport:PrintText ( cAux 			,oreport:row() 	, 60)
			oReport:SkipLine(2)//oreport:incrow(50) // Pula 25 Pixels
		EndIF
		
		///oReport:nLineHeight:=30
		oreport:nFontBody := 6 // Retorno a Fonte ao Tamanho Normal.
		
		cPrnFil 	:= Alltrim(QryNJM->NJM_FILIAL)
		dEmissao	:= StoD(QryNJM->NJJ_DATA)
		cFilRom 	:= QryNJM->NJJ_FILIAL	
		cTipoRo 	:= Substr(Posicione("SX5",1,xFilial("SX5")+"K5"+QryNJM->NJJ_TIPO,"X5DESCRI()"),2,1)
		cTipoRo 	+= QryNJM->NJJ_TIPO
		cCodRom 	:= QryNJM->NJM_CODROM
		cCodCtr		:= QryNJM->NJM_CODCTR 
		cPlaca		:= QryNJM->NJJ_PLACA
		cDocto		:= QryNJM->NJM_DOCNUM //QryNJM->NJM_DOCSER + " " + QryNJM->NJM_DOCNUM
		nPeso1 		:= QryNJM->NJJ_PESO1
		nPeso2 		:= QryNJM->NJJ_PESO2
		nDesconto 	:= QryNJM->DESCONTO
		nPercRom  	:= QryNJM->NJM_PERDIV
		//Verificando se o item do Romaneio e 100 % da Carga 
		IF ! nPercRom=100
			nPeso1 	    *= nPercRom / 100
			nPeso2  	*= nPercRom / 100
			nDesconto 	*= nPercRom / 100
		EndIF
		
		If nPeso1 > nPeso2
			nPesoBruto := ( nPeso1 - nPeso2 )	
		Else
			nPesoBruto := ( nPeso2 - nPeso1 )	
		EndIf

		//--Identifica Transgenia, o cIdTransg é o Tipo de Desconto inf. Pelo Usuario --//
		cResTransg	:=''
		dBselectArea("NJK")
		NJK->( dbSetOrder( 1 ) )	//NJK_FILIAL+NJK_CODROM+NJK_ITEM
		NJK->( dbSeek( fWxFilial( "NJK" ) + QryNJM->NJM_CODROM ) )
		While ! NJK->( Eof() ) .and. NJK->(NJK_FILIAL+NJK_CODROM)== fWxFilial( "NJK" ) + QryNJM->NJM_CODROM
			IF AllTrim(cIdTransg) == Alltrim(NJK->NJK_CODDES)
				cResTransg := NJK->NJK_DESRES
			Endif
			NJK->( DbSkip() )
		EndDo
		IF Len(Alltrim(cResTransg)) > 14  //14 Eh o tamanho q cabe no papel porem o sistema tem uma var de 40
			cResTransg := Substr(AllTrim(cResTransg),1,14)+'.'
		EndIF	
		
		//--Identificando os Descontos--//
		cDesctos	:= MV_PAR19
		cCodRom 	:= QryNJM->NJM_CODROM
		
		//--O Retorno é o Vr. Já proporcional ao NJM_PERDIV--// 
		fGAnalise(cdesctos,cFilRom,cCodRom,@nValor1,@nDesc1,@nValor2,@nDesc2,@nValor3,@nDesc3,@nValor4,@nDesc4,@nValor5,@nDesc5,@nValor6,@nDesc6)
	    nPesoLiq := nPesoBruto - nDesconto
	       	   		
		if QryNJM->TpRom == 'S' .and.  nPesoBruto < 1  // se for romaneio de saida e o peso bruto for negativo, soma o desconto
		      nPesoLiq := nPesoBruto + nDesconto 
		EndIF		

		//Se for selecionado todos os tipos de romaneios (saida e entrada junto) Se o romaneio for de saida, os valores irão aparecer negativo
		IF nTpMvRom == 01 .and. QryNJM->NJJ_TIPO $ "2|4|6|8|B"
			nPesoBruto := nPesoBruto * -1
			nPesoLiq   := nPesoLiq   * -1
			nPeso1 	   := nPeso1     * -1
			nPeso2	   := nPeso2     * -1	
		EndIf	 
	   
//--Abastecendo as Celulas da Seção--//
		oSec2:Cell( "FILIAL"		):SetValue( cPrnFil 			)
		oSec2:Cell( "EMISSAO"	):SetValue( DtoC(dEmissao) 	)
		oSec2:Cell( "TPMVTO"		):SetValue( cTipoRo 			)		
		oSec2:Cell( "ROMAN" 		):SetValue( cCodRom 			)
		oSec2:Cell( "CONTRATO"	):SetValue( cCodCtr			)
		oSec2:Cell( "PLACA"		):SetValue( cPlaca 			)
		oSec2:Cell( "PESO1"		):SetValue( nPeso1 			)
		oSec2:Cell( "PESO2" 		):SetValue( nPeso2 			)
		oSec2:Cell( "PESOBRUTO"	):SetValue( nPesoBruto 		)
		oSec2:Cell( "DESCONTOS"	):SetValue( nDesconto  		)
		oSec2:Cell( "PESOLIQ"	):SetValue( nPesoLiq			)
		oSec2:Cell( "DOCTO"		):SetValue( cDocto			)		
		oSec2:Cell( "TRANSGENIA"	):SetValue(cResTransg		)
		oSec2:Cell( "VRDESC1"	):SetValue( nValor1 			)
		oSec2:Cell( "DESC1"		):SetValue( nDesc1 			)
		oSec2:Cell( "VRDESC2"	):SetValue( nvalor2			)
		oSec2:Cell( "DESC2"		):SetValue( nDesc2			)
		oSec2:Cell( "VRDESC3"	):SetValue( nValor3			)
		oSec2:Cell( "DESC3"		):SetValue( nDesc3			)
		oSec2:Cell( "VRDESC4"	):SetValue( nValor4			)
		oSec2:Cell( "DESC4"		):SetValue( nDesc4			)
		oSec2:Cell( "VRDESC5"	):SetValue( nValor5			)
		oSec2:Cell( "DESC5"		):SetValue( nDesc5			)
		oSec2:Cell( "VRDESC6"	):SetValue( nValor6			)
		oSec2:Cell( "DESC6"		):SetValue( nDesc6			)
		
		vVetGera[1] += nPeso1
		vVetGera[2] += nPeso2
		vVetGera[3] += nPesoBruto
		vVetGera[4] += nDesconto
		vVetGera[5] += nPesoLiq
		lTemdado := .t.
		
		//colocar o totalizador de produto -- verifica se existe e coloca ele na posição (soma valores) 
	    nPos  := aScan(aTotalPro,{|x| AllTrim(x[1]) == "C" + Alltrim(QryNJM->NJM_CODPRO) })
	    If nPos > 0
	    	//soma dados
	    	aTotalPro[nPos][3] += nPeso1 //"PESO1"
	    	aTotalPro[nPos][4] += nPeso2 //"PESO2"
	    	aTotalPro[nPos][5] += nPesoBruto //"PESOBRUTO"
	    	aTotalPro[nPos][6] += nDesconto //"DESCONTOS"   
	    	aTotalPro[nPos][7] += nPesoLiq //"PESOLIQ"  
	    	aTotalPro[nPos][8] += nValor1 //VRDESC1
	        aTotalPro[nPos][9] += nDesc1 //DESC1
			aTotalPro[nPos][10] += nValor2 //VRDESC1
			aTotalPro[nPos][11] += nDesc2 //DESC1			
			aTotalPro[nPos][12] += nValor3 //VRDESC1
			aTotalPro[nPos][13] += nDesc3 //DESC1			
			aTotalPro[nPos][14] += nValor4 //VRDESC1
			aTotalPro[nPos][15] += nDesc4 //DESC1			
			aTotalPro[nPos][16] += nValor5 //VRDESC1
			aTotalPro[nPos][17] += nDesc5 //DESC1			
			aTotalPro[nPos][18] += nValor6 //VRDESC1
			aTotalPro[nPos][19] += nDesc6 //DESC1
			aTotalPro[nPos][20] += 1 //Contador de item	 	    		
	    else
	        /*cria novo*/
	        aadd (aTotalPro, {"C"+Alltrim(QryNJM->NJM_CODPRO), QryNJM->B1_DESC, nPeso1, nPeso2 ,nPesoBruto	, nDesconto, nPesoLiq, nValor1, nDesc1, nValor2, nDesc2, nValor3, nDesc3, nValor4, nDesc4, nValor5, nDesc5, nValor6, nDesc6, 1  } )   
	    end.
		
		fSaltaPage(1) 	//Verifica se Salta Pagina
		oSec2:Show()		//Indica que a seçao irá aparecer
		
		IF !lPlanilha //Verifica se n. é impressão em planilha
			//--Qdo não é em planilha imprimo de forma manual devido ao ncolspace n. funcionar como necessario, forçando a quebrar
			//--a impressão em linha qdo o papel é A4 o que não queremos.
		
			oreport:PrintText (cPrnFil,			oreport:row() 			, 	nPosColA)
			oreport:PrintText (DtoC(dEmissao),	oreport:row() 			, 	nPosColB)
			oreport:PrintText (cTipoRo,			oreport:row() 			, 	nPosColC)
			oreport:PrintText (cCodRom,			oreport:row() 			, 	nPosColD)
			oreport:PrintText (cCodCtr,			oreport:row() 			, 	nPosColE)
		
			oreport:PrintText (Transform(cPlaca,						"@!" ),			oreport:row()	, 	nPosColF)
			oreport:PrintText (Transform(nPeso1,						_cPicTotPeso),	oreport:row()	, 	nPosColG)  
			oreport:PrintText (Transform(nPeso2,						_cPicTotPeso),	oreport:row()	, 	nPosColH)  
			oreport:PrintText (Transform(nPesoBruto,					_cPicTotPeso),	oreport:row()	, 	nPosColI)  
			oreport:PrintText (Transform(nDesconto,						_cPicTotPeso),	oreport:row()	, 	nPosColJ)  
			oreport:PrintText (Transform(nPesoLiq,						_cPicTotPeso),	oreport:row()	, 	nPosColK)  
			oreport:PrintText (cDocto,													oreport:row()	, 	nPosColK1) 
			oreport:PrintText (cResTransg,												oreport:row() , 	nPosColL)
		
			AaUX := {}
			aAux 	:= separa(MV_PAR19, ';')
			For	nI:=Len(aAux) to 6
				aAdd(aAux,'')
			nExt nI
			IF ! Empty(aAux[1] )
				oreport:PrintText (Transform(nValor1 	,"@E 99,999.99"),oreport:row() 	, 	nPosColM - _nResPad)  	//80
				oreport:PrintText (Transform(nDesc1 	,"@E 9999,999" ),oreport:row() 	, 	nPosColN)	// 110
			EndIF

			IF ! Empty(aAux[2] )
				oreport:PrintText (Transform(nValor2	,"@E 99,999.99"),oreport:row() 	, 	nPosColO - _nResPad)  	//80
				oreport:PrintText (Transform(nDesc2 	,"@E 9999,999" ),oreport:row() 	, 	nPosColP)	// 110
			EndIF

			IF ! Empty(aAux[3] )
				oreport:PrintText (Transform(nValor3	,"@E 99,999.99"),oreport:row() 	, 	nPosColQ - _nResPad)  	//80
				oreport:PrintText (Transform(ndesc3		,"@E 9999,999" ),oreport:row() 	, 	nPosColR)	// 110
			EndIF
		
			IF ! Empty(aAux[4] )
				oreport:PrintText (Transform(nValor4	,"@E 99,999.99"),oreport:row() 	, 	nPosColS - _nResPad)  	//80
				oreport:PrintText (Transform(nDesc4		,"@E 9999,999" ),oreport:row() 	, 	nPosColT)	// 110
			EndIF
		
			IF ! Empty(aAux[5] )
				oreport:PrintText (Transform(nValor5	,"@E 99,999.99"),oreport:row() 	, 	nPosColU - _nResPad)  	//80
				oreport:PrintText (Transform(nDesc5		,"@E 9999,999" ),oreport:row() 	, 	nPosColV)	// 110
			EndIF

			IF ! Empty(aAux[6] )
				oreport:PrintText (Transform(nValor6	,"@E 99,999.99"),oreport:row() 	, 	nPosColX - _nResPad)  	//80
				oreport:PrintText (Transform(nDesc6		,"@E 9999,999" ),oreport:row() 	, 	nPosColZ)	// 110
			EndIF
			oSec2:Hide()
			oReport:SkipLine(1)	
		EndIF
		
		oSec2:Printline()
		QryNJM->(DbSkip())	
	Enddo

	QryNJM->( dbCloseArea() )
	
	/*busca os totais*/
	if ! Empty(aTotalPro)
		oReport:OnPageBreak({|| fPrnCabEsp("T") /*Cabeçalho Principal*/  })  
		oReport:SkipLine(1) 
				
		IF ! fSaltaPage(3)  //Verifica se precisa Saltar a Pagina
  		   oreport:PrintText ( "TOTAIS POR PRODUTO" ,oreport:row() 	, 10)
  		   oReport:SkipLine(1)
		   fPrnCabEsp("T") /*Cabeçalho total*/
		Else
		 oreport:PrintText ( "TOTAIS POR PRODUTO" ,oreport:row() 	, 10)
		 oReport:SkipLine(1)
		EndIf

		oSec3:Init()   
		oSec3:show()
		
		for  nx := 1 To Len(aTotalPro) 
		
		    oSec3:Cell("PRODUTO"):SetValue( aTotalPro[nx][2] )
			oSec3:Cell("PESO1"):SetValue( aTotalPro[nx][3] )
	    	oSec3:Cell("PESO2"):SetValue( aTotalPro[nx][4] )
	    	oSec3:Cell("PESOBRUTO"):SetValue( aTotalPro[nx][5] )
	    	oSec3:Cell("DESCONTOS"):SetValue( aTotalPro[nx][6] )
	    	oSec3:Cell("PESOLIQ"):SetValue( aTotalPro[nx][7] )  
	    	oSec3:Cell("VRDESC1"):SetValue( aTotalPro[nx][8] / aTotalPro[nX, 20] ) //average
	        oSec3:Cell("DESC1"):SetValue( aTotalPro[nx][9] )
			oSec3:Cell("VRDESC2"):SetValue( aTotalPro[nx][10] / aTotalPro[nX, 20] ) //average
			oSec3:Cell("DESC2"):SetValue( aTotalPro[nx][11] )		
			oSec3:Cell("VRDESC3"):SetValue( aTotalPro[nx][12] / aTotalPro[nX, 20] ) //average
			oSec3:Cell("DESC3"):SetValue( aTotalPro[nx][13] )	 
			oSec3:Cell("VRDESC4"):SetValue( aTotalPro[nx][14] / aTotalPro[nX, 20] ) //average
			oSec3:Cell("DESC4"):SetValue( aTotalPro[nx][15] )			
			oSec3:Cell("VRDESC5"):SetValue( aTotalPro[nx][16] / aTotalPro[nX, 20] ) //average
			oSec3:Cell("DESC5"):SetValue( aTotalPro[nx][17] )			
			oSec3:Cell("VRDESC6"):SetValue( aTotalPro[nx][18] / aTotalPro[nX, 20] ) //average
			oSec3:Cell("DESC6"):SetValue( aTotalPro[nx][19] )	 
			
			IF !lPlanilha
				
				oreport:PrintText (aTotalPro[nx][2],								oreport:row() 			, 	nPosColA) /*produto*/
			    oreport:PrintText (Transform( aTotalPro[nx][3],		_cPicTotPeso),	oreport:row()	, 	nPosColG)  
				oreport:PrintText (Transform( aTotalPro[nx][4],		_cPicTotPeso),	oreport:row()	, 	nPosColH)  
				oreport:PrintText (Transform( aTotalPro[nx][5],		_cPicTotPeso),	oreport:row()	, 	nPosColI)  
				oreport:PrintText (Transform( aTotalPro[nx][6],		_cPicTotPeso),	oreport:row()	, 	nPosColJ)  
				oreport:PrintText (Transform( aTotalPro[nx][7],		_cPicTotPeso),	oreport:row()	, 	nPosColK)  
			
				AaUX := {}
				aAux 	:= separa(MV_PAR19, ';')
				For	nI:=Len(aAux) to 6
					aAdd(aAux,'')
				nExt nI
				IF ! Empty(aAux[1] )
					oreport:PrintText (Transform(aTotalPro[nx][8] / aTotalPro[nX, 20]  	,"@E 99,999.99"),oreport:row() 	, 	nPosColM - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][9] 						,"@E 9999,999" ),oreport:row() 	, 	nPosColN)	
				EndIF
	
				IF ! Empty(aAux[2] )
					oreport:PrintText (Transform(aTotalPro[nx][10] / aTotalPro[nX, 20] 	,"@E 99,999.99"),oreport:row() 	, 	nPosColO - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][11] 						,"@E 9999,999" ),oreport:row() 	, 	nPosColP)	
				EndIF
	
				IF ! Empty(aAux[3] )
					oreport:PrintText (Transform(aTotalPro[nx][12] / aTotalPro[nX, 20] 	,"@E 99,999.99"),oreport:row() 	, 	nPosColQ - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][13]						,"@E 9999,999" ),oreport:row() 	, 	nPosColR)	
				EndIF
			
				IF ! Empty(aAux[4] )
					oreport:PrintText (Transform(aTotalPro[nx][14] / aTotalPro[nX, 20] 	,"@E 99,999.99"),oreport:row() 	, 	nPosColS - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][15]						,"@E 9999,999" ),oreport:row() 	, 	nPosColT)	
				EndIF
			
				IF ! Empty(aAux[5] )
					oreport:PrintText (Transform(aTotalPro[nx][16] / aTotalPro[nX, 20] 	,"@E 99,999.99"),oreport:row() 	, 	nPosColU - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][17]						,"@E 9999,999" ),oreport:row() 	, 	nPosColV)	
				EndIF
	
				IF ! Empty(aAux[6] )
					oreport:PrintText (Transform(aTotalPro[nx][18] / aTotalPro[nX, 20] 	,"@E 99,999.99"),oreport:row() 	, 	nPosColX - _nResPad)  	
					oreport:PrintText (Transform(aTotalPro[nx][19]						,"@E 9999,999" ),oreport:row() 	, 	nPosColZ)	
				EndIF
				oSec3:Hide()
				oReport:SkipLine(1)	
			
			endif
			
			oSec3:PrintLine( )	
		end.
		
		oSec3:Finish()
	end.
	
	If lTemdado 
     	vVetColG := {nPosColG,nPosColH,nPosColI,nPosColJ,nPosColK}	
		 
     	For nx := 1 To 5
   			oreport:PrintText("___________________",oreport:row(),vVetColG[nx])
   		Next nx
		oReport:SkipLine(1)
		oreport:PrintText("TOTAIS GERAL",oreport:row(),10)
		For nx := 1 To 5
			oreport:PrintText(Transform(vVetGera[nx], _cPicTotPeso),oreport:row(),vVetColG[nx])
		Next nx
   EndIf   		
Return oReport

/*
@description Funcao para Impressão de Cabeçalho especifico
				esta função ajusta o kbeçalho da seção
@author Emerson Coelho
@since 09/09/2013
@type function
*/
Static Function fPrnCabEsp(cModo)
//--<< Imprime Cabeçalho Especifico na Pagina >>--

	Local aAux	:= {}
	Local nI	:= {}
																			
	aAux 	:= separa(MV_PAR19, ';')
	For	nI:=Len(aAux) to 6
		aAdd(aAux,'')
	nExt nI

	IF ! lPlanilha 	//Qdo não for impressão em Planilha
		//--Ajusta o Header da seção qdo será impresso --//
       //Printing Cod dos Desctos escolhidos Cab. dinamico//
		IIf(!Empty( aAux[1] ),oreport:PrintText (PADC( Alltrim(aAux[1]) ,14),oreport:row() 	, 	nPosColM),'')
		IIf(!Empty( aAux[2] ),oreport:PrintText (PADC( Alltrim(aAux[2]) ,14),oreport:row() 	, 	nPosColO),'')
		IIf(!Empty( aAux[3] ),oreport:PrintText (PADC( Alltrim(aAux[3]) ,14),oreport:row() 	, 	nPosColQ),'')
		IIf(!Empty( aAux[4] ),oreport:PrintText (PADC( Alltrim(aAux[4]) ,14),oreport:row() 	, 	nPosColS),'')
		IIf(!Empty( aAux[5] ),oreport:PrintText (PADC( Alltrim(aAux[5]) ,14),oreport:row() 	, 	nPosColU),'')
		IIf(!Empty( aAux[6] ),oreport:PrintText (PADC( Alltrim(aAux[6]) ,14),oreport:row() 	, 	nPosColX),'')

		oreport:SkipLine(1)
		
		IIf(!Empty( aAux[1] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColM),'')
		IIf(!Empty( aAux[2] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColO),'')
		IIf(!Empty( aAux[3] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColQ),'')
		IIf(!Empty( aAux[4] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColS),'')
		IIf(!Empty( aAux[5] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColU),'')
		IIf(!Empty( aAux[6] ),oreport:PrintText ("==============",oreport:row() 	, 	nPosColX),'')

		oreport:Skipline(1)
		
		if cModo = "P" /*Principal*/
			oreport:PrintText (PadR(STR0003,6),oreport:row() 			, 	nPosColA) //Filial
			oreport:PrintText (PadR(STR0004,8),oreport:row() 			, 	nPosColB) //Emissao
			oreport:PrintText (PadR(STR0005,2),oreport:row() 			, 	nPosColC) //TP
			oreport:PrintText (PadR(STR0006,10),oreport:row() 			, 	nPosColD) //Romaneio
			oreport:PrintText (PadR(STR0007,8),oreport:row() 			, 	nPosColE) //Contrato
			oreport:PrintText (PadR(STR0008,10),oreport:row() 			, 	nPosColF) //Placa
	
			oreport:PrintText (PadL(STR0009,12),oreport:row() 			, 	nPosColG)  //1a Pesagem
			oreport:PrintText (PadL(STR0010,12),oreport:row() 			, 	nPosColH)  //2a Pesagem
			oreport:PrintText (PadL(STR0011,12),oreport:row() 			, 	nPosColI)  //Liq.S/Descto
			oreport:PrintText (PadL(STR0012,12),oreport:row() 			, 	nPosColJ)  //Descontos
			oreport:PrintText (PadL(STR0013,12),oreport:row() 			, 	nPosColK)  //Peso Liquido
			oreport:PrintText (PadR(STR0069,10),oreport:row() 			, 	nPosColK1) //Docto(NF)
			oreport:PrintText (PadR(STR0015,30),oreport:row() 			, 	nPosColL) //Transgenia
		
		elseif cModo = "T" /*Total*/
		
			oreport:PrintText (PadR("Produto",44),oreport:row() 		, 	nPosColA) //Filial

			oreport:PrintText (PadL(STR0009,12),oreport:row() 			, 	nPosColG)  //1a Pesagem
			oreport:PrintText (PadL(STR0010,12),oreport:row() 			, 	nPosColH)  //2a Pesagem
			oreport:PrintText (PadL(STR0011,12),oreport:row() 			, 	nPosColI)  //Liq.S/Descto
			oreport:PrintText (PadL(STR0012,12),oreport:row() 			, 	nPosColJ)  //Descontos
			oreport:PrintText (PadL(STR0013,12),oreport:row() 			, 	nPosColK)  //Peso Liquido

		EndIf
		
		If !Empty( aAux[1] ) 
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColM)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColN)	//Descto
		EndIf

		If !Empty( aAux[2] )
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColO)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColP)	//Descto
		EndIF
		If !Empty( aAux[3] )
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColQ)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColR)	//Descto
		EndIF
		If !Empty( aAux[4] )
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColS)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColT)	//Descto
		EndIF
		If !Empty( aAux[5] )
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColU)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColV)	//Descto
		EndIF
		If !Empty( aAux[6] )
			oreport:PrintText (PadL(STR0070,5),oreport:row() 			, 	nPosColX)  	//Resul
			oreport:PrintText (PadL(STR0071,8),oreport:row() 			, 	nPosColZ)	//Descto
		EndIF
		oReport:SkipLine(2)
		oReport:Fatline()
	
	Else
		if cModo = "P" /*Principal*/
			oSec2:SetHeaderSection(.t.)
			oSeC2:PrintHeader()
			oSec2:SetHeaderSection(.f.)
		elseif cModo = "T" /*Total*/
			oSec3:SetHeaderSection(.t.)
			oSeC3:PrintHeader()
			oSec3:SetHeaderSection(.f.)
		end.		
	EndIF

Return

/*
Função que encontra os descontos informados a serem listados pelo usuario
@param: 
		cDesctos 			= MV_PAR19, com os 6 codigos dos discontos a serem listados.
		cCodrom 			= Codigo do romaneio que está sendo impresso
		nValor1 a nValor6	= % de desconto que será retornado (passado via ponteiro)
		ndesc1  a nDesc6	= Qtd. do desconto	(Passado via Ponteiro)
@description: 
@author Emerson Coelho
@since 09/09/2013
@return: empty
@type function
*/
Static Function  fGAnalise(cdesctos,cFilRom,cCodRom,nValor1,nDesc1,nValor2,nDesc2,nValor3,nDesc3,nValor4,nDesc4,nValor5,nDesc5,nValor6,nDesc6)
//--<<Abastece as 6 possibilidades de impressão de análise com os Dados, As mesmas viram como Ponteiros >>--
	Local cquery		:= 0
	Local cAlias1		:= GetNextAlias()
	Local nI			:= 0
	Local cControlCtr 	:= 0
	Local cTipoCtr   	:= Posicione('NJR',1,xFilial("NJR") + cCodCtr ,"NJR_Tipo")
	Local lAgoClas   	:= SuperGetMV("MV_AGOCLAS",.F.,.F.) //PARAMETRO SE HABILITA CONTROLE FISICO/FISCAL

	nValor1	:=0
	nDesc1	:=0
	nValor2	:=0
	nDesc2	:=0
	nValor3	:=0
	nDesc3	:=0
	nValor4	:=0
	nDesc4	:=0
	nValor5	:=0
	nDesc5	:=0
	nValor6	:=0
	nDesc6	:=0


	aAux :=  separa(cDesctos , ';')  //cDesctos (MV_PAR19) Descontos a serem listados.
	cTpDesctos	:=	""
	For nI:=1 to Len(aAux) sTep 1  // Tenho os Tps Movtos no formato: '001','002','003','501','503','504','550','551','600'
		cTpDesctos += "'" + Trim(aAux[nI]) + "'"
		IF ! nI = Len(aAux)
			cTpDesctos += " , "
		EndIF
	next nI
	cQuery:=''

	cQuery := " SELECT NJK_CODDES, NJK_BASDES, NJK_TPCLAS, NJK_PERDES, NJK_READES, NJK_QTDDES FROM " + RETSQLTAB("NJK")
	cQuery += " WHERE	NJK_CODROM	= '" 	+ cCodRom 				+ "'"
	cQuery += " AND NJK_CODDES	IN (" 	+ cTpDesctos 			+ ")"
	cQuery += " AND 	NJK_FILIAL = '" 	+ cFilRom 	+ "'"
	cQuery += " AND 	D_E_L_E_T_ =' ' ORDER BY NJK_TPCLAS"

	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAlias1,.T.,.T.)
    
	aDesctos := {} // Array q conterá  6 Linhas com  Percentual de Desconto e a Qtd. de desconto.
   
	aAdd(aDesctos,{0,0})
	aAdd(aDesctos,{0,0})
	aAdd(aDesctos,{0,0})
	aAdd(aDesctos,{0,0})
	aAdd(aDesctos,{0,0})
	aAdd(aDesctos,{0,0})
	
	IF cTipoCtr $ "1|2"
		cControlCtr := Posicione('NJR',1,xFilial("NJR") + cCodCtr ,"NJR_CLASSP")
	Else
		cControlCtr := '1'
	EndIf

	For nI := 1 to Len(aAux)
   
		While !(cAlias1)->(EOF())

			IF !lAgoClas .AND. Alltrim( aAux[nI] ) == Alltrim( (cAlias1)->NJK_CODDES )
				aDesctos[nI,1] :=	(cAlias1)->NJK_PERDES
				aDesctos[nI,2] :=	(cAlias1)->NJK_QTDDES
				Exit
			ElseIf ( cControlCtr  == (cAlias1)->NJK_TPCLAS  ) .AND. Alltrim( aAux[nI] ) == Alltrim( (cAlias1)->NJK_CODDES )
				aDesctos[nI,1] :=	(cAlias1)->NJK_PERDES
				aDesctos[nI,2] :=	(cAlias1)->NJK_QTDDES
				Exit			
			EndIf

			(cAlias1)->(dbSkip())
		EndDo
	
		(cAlias1)->(DbGoTop())
	
	nExt nI
	
	(cAlias1)->( dBCloseArea() )

//--Abastecendo Variaveis de impressao --//	   
	nValor1 	:= 	aDesctos[1,1] 	//Percentual
	nDesc1		:=	aDesctos[1,2] 	//Qtd Desctada

	nValor2		:= 	aDesctos[2,1]
	nDesc2		:=	aDesctos[2,2]

	nValor3 	:= 	aDesctos[3,1]
	nDesc3		:=	aDesctos[3,2]

	nValor4 	:= 	aDesctos[4,1]
	nDesc4		:=	aDesctos[4,2]

	nValor5 	:= 	aDesctos[5,1]
	nDesc5		:=	aDesctos[5,2]

	nValor6 	:= 	aDesctos[6,1]
	nDesc6		:=	aDesctos[6,2]
	
//--Ajustando a Qtd. de Desconto Com a percentagem do Item no Romaneio --//
	IF !QryNJM->NJM_PERDIV = 100
		nDesc1		:=	Round((nDesc1 * QryNJM->NJM_PERDIV / 100), 0 )
		nDesc2		:=	Round((nDesc2 * QryNJM->NJM_PERDIV / 100), 0 )
		nDesc3		:=	Round((nDesc3 * QryNJM->NJM_PERDIV / 100), 0 )
		nDesc4		:=	Round((nDesc4 * QryNJM->NJM_PERDIV / 100), 0 )
		nDesc5		:=	Round((nDesc5 * QryNJM->NJM_PERDIV / 100), 0 )
		nDesc6		:=	Round((nDesc6 * QryNJM->NJM_PERDIV / 100), 0 )
	EndIF
//--Tenho Agora o % de Desconto e descontos, a listar --//	
Return()

//--Valida as Análises a Serem Impressas, Garante que o Array contenha 6 Tps Desctos Válidos --//
/*
@param: nil
@description: Função que Valida a pergunta ref. aos 6 descontos , garantindo que
              o MV_PAR19 sempre tenha 6 descontos separados por (;)
@author: Emerson Coelho
@since: 09/09/2013
@return: empty
*/

User Function fOgrvldA()
	Local lOk 		:= .t.
	Local nI		:=0
	local aAux 	:= Separa(MV_PAR19,';')
	
	If lOk
		NNH->( dbSetOrder( 1 ) )
		For nI := 1 to Len(aAux) Step 1
			IF !NNH->( dbSeek( fWxFilial( "NNH" ) + aAux[nI] ))
				lok := .f.
				Exit
			EndIF
		nExt
	EndIF
	IF !lOk
		Help( ,, "HELP" ,, STR0072, 1, 0) //Selecione 6 tipos de decontos válidos para listar. Separe-os com (;) Ex: UMI;TRA;ARD
	EndIF

Return( lOk )

/*
@param: nil
@description: Função que Valida a pergunta ref. aos status.
@author: Equipe Agroindústria
@since: 13/08/2015
@return: empty
*/

User Function fOgr295vdB()
	Local lOk 		:= .t.
	Local nI		:= 0
	local aLstSts := gGetStsNJJ() //obtem lista de status
	local aAux 	:= Separa(MV_PAR22,';')
	local nPos    := 0   
		
	If !empty(MV_PAR22)
		For nI := 1 to Len(aAux) Step 1
			nPos  := aScan(aLstSts,{|x| AllTrim(x[1]) == Alltrim(aAux[nI]) })
			If nPos < 1 //não encontrou o status
				lok := .f.
				Exit
			EndIF
		nExt
	EndIF
	IF !lOk
		Help( ,, "HELP" ,, STR0084, 1, 0) //Selecione status válidos para listar. Separe-os com (;) Ex: UMI;TRA;ARD
	EndIF

Return( lOk )

/*
+=================================================================================================+
| Função    : fOgr295PQU                                                                          |
| Descrição : Validação o parecer da qualidade                                                    |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 16/03/2016                                                                          |
+=================================================================================================+ 
| Referência: Dicionário de dados SX1                                                             |
+=================================================================================================+ 
*/ 
User Function fOgr295PQU()
Local lOk := .t., nI,nPos
Local aLstSts := gGetPQUNJJ() //obtem lista de PARECER
Local aAux 	 := Separa(MV_PAR23,';')
		
If !Empty(MV_PAR23)
	For nI := 1 to Len(aAux) Step 1
		nPos  := aScan(aLstSts,{|x| AllTrim(x[1]) == Alltrim(aAux[nI]) })
		If nPos < 1 //não encontrou o status
			lOk := .f.
			Exit
		EndIF
	Next nI
EndIF
If !lOk
	Help(,,"HELP",,"Selecione parecer válidos para listar. Separe-os com (;)"+" Ex. 0;1;2;...",1,0)
EndIf
Return lOk 

/*
+=================================================================================================+
| Função    : gGetPQUNJJ                                                                          |
| Descrição : Monta matriz com as opções do parecer da qualidade                                  |
| Autor     : Inácio Luiz Kolling                                                                 |
| Data      : 16/03/2016                                                                          |
+=================================================================================================+ 
*/ 
Static Function gGetPQUNJJ()
Local aPQUNJJ := {},aAux2 := {}
Local nI,aAux := Separa(AGRRETSX3BOX("NJJ_LIBQLD"),';')
        
For nI := 1 to Len(aAux) Step 1
   aAux2 = separa(aAux[nI],'=')
   aAdd(aPQUNJJ,{alltrim(aAux2[1]),alltrim(aAux2[2])})
Next
Return aPQUNJJ

/*
@param: nil
@description: Função que obtem os dados dos status da NJJ.
@author: Equipe Agroindústria
@since: 13/08/2015
@return: array
*/
static function gGetStsNJJ()
    local aStsNJJ := {}
    Local nI        := 0
    local aAux  := Separa(AGRRETSX3BOX("NJJ_STATUS"),';')
    local aAux2   := {}
        
    For nI := 1 to Len(aAux) Step 1
          aAux2 = separa(aAux[nI],'=')
          aAdd(aStsNJJ,{alltrim(aAux2[1]),alltrim(aAux2[2])})
    nExt
    
return (aStsNJJ)

/*
@param: nil 
@description: Funcao que verifica se preciso imprimir o rodape
   				e pular a pagina
@author: Emerson Coelho
@since: 09/09/2013
@return: array com 3 linhas contendo as descrições do tipo de movto.
*/

Static Function fSaltaPage(nLines)
	Local lSaltou := .f.
	Local ni:=0
	ni:=1

	While oReport:ChkIncRow(nLines,.t.)
		if nI == 1
			oReport:Fatline()  //Somente essa linha como rodape
			lSaltou := .t.
		ELSE
			oReport:SkipLine(1)
		EndIF
		ni++
			
	EndDo

Return(lSaltou)


/*
@param: nil 
@description: FTotProd Print, o total do produto
@author: Emerson Coelho
@since: 09/09/2013
@return: array com 3 linhas contendo as descrições do tipo de movto.
*/

Static Function fTotProd()
	Local nI := 0
	aAux 	:= separa(MV_PAR19, ';')
	For	nI:=Len(aAux) to 6
		aAdd(aAux,'')
	nExt nI
	
	oReport:Fatline()
	oreport:PrintText (Transform(Obreak1:aFunction[01]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColG)
	oreport:PrintText (Transform(Obreak1:aFunction[02]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColH)  	
	oreport:PrintText (Transform(Obreak1:aFunction[03]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColI)  	
	oreport:PrintText (Transform(Obreak1:aFunction[04]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColJ)  	
	oreport:PrintText (Transform(Obreak1:aFunction[05]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColK)  	
	
	IF ! Empty(aAux[1] )
		oreport:PrintText (Transform(Obreak1:aFunction[06]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColM - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[07]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColN)	
	EndIF
	IF ! Empty(aAux[2] )
		oreport:PrintText (Transform(Obreak1:aFunction[08]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColO - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[09]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColP)	
	EndIF
	IF ! Empty(aAux[3] )
		oreport:PrintText (Transform(Obreak1:aFunction[10]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColQ - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[11]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColR)	
	EndIF
	IF ! Empty(aAux[4] )
		oreport:PrintText (Transform(Obreak1:aFunction[12]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColS - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[13]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColT)	
	EndIF
	IF ! Empty(aAux[5] )
		oreport:PrintText (Transform(Obreak1:aFunction[14]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColU - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[15]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColV)	
	EndIF
	IF ! Empty(aAux[6] )
		oreport:PrintText (Transform(Obreak1:aFunction[16]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColX - _nResPad)  	
		oreport:PrintText (Transform(Obreak1:aFunction[17]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColZ)	
	EndIF
	For ni:=1 to Len(oBreak1:aFunction)
		oBreak1:aFunction[nI]:Reset()
	nExt
	oreport:Skipline()

Return
/*
@param: nil 
@description: FTotLojaPrint, Imprime o total da Loja
@author: Emerson Coelho
@since: 09/09/2013
*/

Static Function fTotLoja()
	Local ni	:=0
	Local aAux	:= {}
	
	aAux 	:= separa(MV_PAR19, ';')
	For	nI:=Len(aAux) to 6
		aAdd(aAux,'')
	nExt nI
	

	oReport:Fatline()
	oreport:PrintText (Transform(oBreak2:aFunction[01]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColG)
	oreport:PrintText (Transform(oBreak2:aFunction[02]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColH)  	
	oreport:PrintText (Transform(oBreak2:aFunction[03]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColI)  	
	oreport:PrintText (Transform(oBreak2:aFunction[04]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColJ)  	
	oreport:PrintText (Transform(oBreak2:aFunction[05]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColK)  	
	IF ! Empty(aAux[1] )
		oreport:PrintText (Transform(oBreak2:aFunction[06]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColM - _nResPad)  	
		oreport:PrintText (Transform(oBreak2:aFunction[07]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColN)	
	EndIF
	IF ! Empty(aAux[2] )
		oreport:PrintText (Transform(oBreak2:aFunction[08]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColO - _nResPad)  	
		oreport:PrintText (Transform(oBreak2:aFunction[09]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColP)	
	EndIF
	IF ! Empty(aAux[3] )
		oreport:PrintText (Transform(oBreak2:aFunction[10]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColQ - _nResPad) 
		oreport:PrintText (Transform(oBreak2:aFunction[11]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColR)	
	EndIF
	IF ! Empty(aAux[4] )
		oreport:PrintText (Transform(oBreak2:aFunction[12]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColS - _nResPad)
		oreport:PrintText (Transform(oBreak2:aFunction[13]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColT)	
	EndIF
	IF ! Empty(aAux[5] )
		oreport:PrintText (Transform(oBreak2:aFunction[14]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColU - _nResPad)  
		oreport:PrintText (Transform(oBreak2:aFunction[15]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColV)	
	EndIF
	IF ! Empty(aAux[6] )
		oreport:PrintText (Transform(oBreak2:aFunction[16]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColX - _nResPad) 
		oreport:PrintText (Transform(oBreak2:aFunction[17]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColZ)	
	EndIF
		
	For ni:=1 to Len(oBreak2:aFunction)
		oBreak2:aFunction[nI]:Reset()
	nExt
	oReport:SkipLine()
Return
/*
@param: nil 
@description: FTotEnt Print, Imprime o Total Entidade
@author: Emerson Coelho
@since: 09/09/2013
*/

Static Function fTotEnt()
	Local nI 	:=0
	Local aAux	:= {}
	
	aAux 	:= separa(MV_PAR19, ';')
	For	nI:=Len(aAux) to 6
		aAdd(aAux,'')
	nExt nI
	

	oReport:Fatline()
	oreport:PrintText (Transform(oBreak3:aFunction[01]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColG)
	oreport:PrintText (Transform(oBreak3:aFunction[02]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColH)  	
	oreport:PrintText (Transform(oBreak3:aFunction[03]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColI)  	
	oreport:PrintText (Transform(oBreak3:aFunction[04]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColJ)  	
	oreport:PrintText (Transform(oBreak3:aFunction[05]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColK)  	
	IF ! Empty(aAux[1] )
		oreport:PrintText (Transform(oBreak3:aFunction[06]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColM - _nResPad)  	
		oreport:PrintText (Transform(oBreak3:aFunction[07]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColN)	
	EndIF
	IF ! Empty(aAux[2] )
		oreport:PrintText (Transform(oBreak3:aFunction[08]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColO - _nResPad)  	
		oreport:PrintText (Transform(oBreak3:aFunction[09]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColP)	
	EndIF		
	IF ! Empty(aAux[3] )
		oreport:PrintText (Transform(oBreak3:aFunction[10]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColQ - _nResPad)  	
		oreport:PrintText (Transform(oBreak3:aFunction[11]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColR)	
	EndIF
	IF ! Empty(aAux[4] )
		oreport:PrintText (Transform(oBreak3:aFunction[12]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColS - _nResPad)  	
		oreport:PrintText (Transform(oBreak3:aFunction[13]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColT)	
	EndIF
	IF ! Empty(aAux[5] )
		oreport:PrintText (Transform(oBreak3:aFunction[14]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColU - _nResPad) 
		oreport:PrintText (Transform(oBreak3:aFunction[15]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColV)	
	EndIF
	IF ! Empty(aAux[6] )
		oreport:PrintText (Transform(oBreak3:aFunction[16]:GetValue(),	"@E 99,999.99"),	oreport:row(), 	nPosColX - _nResPad) 
		oreport:PrintText (Transform(oBreak3:aFunction[17]:GetValue(),	"@E 9999,999"),		oreport:row(), 	nPosColZ)
	EndIF			
		
	For ni:=1 to Len(oBreak3:aFunction)
		oBreak3:aFunction[nI]:Reset()
	nExt

	oReport:SkipLine(1)
		
Return

/*
@param: nil 
@description: fTotMovProd, Imprime o total de movimentos do Produto 
@author: claudineia.reinert
@since: 28/08/2020
*/
Static Function fTotMovProd()
	Local nI 	:=0

	oReport:Fatline()
	oreport:PrintText (Transform(oBreak1B:aFunction[01]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColG)
	For ni:=1 to Len(oBreak1B:aFunction)
		oBreak1B:aFunction[nI]:Reset()
	nExt

	oReport:SkipLine(1)

Return nil

/*
@param: nil 
@description: fTotMovEnt, Imprime o total de movimentos da Entidade 
@author: claudineia.reinert
@since: 28/08/2020
*/
Static Function fTotMovEnt()
	Local nI 	:=0

	oReport:Fatline()
	oreport:PrintText (Transform(oBreak3B:aFunction[01]:GetValue(),	_cPicTotPeso),	oreport:row(), 	nPosColG)
	For ni:=1 to Len(oBreak3B:aFunction)
		oBreak3B:aFunction[nI]:Reset()
	nExt

	oReport:SkipLine(1)

Return nil
