/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR590.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWIZARD.CH"
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR590   บAutor  ณ Marylly A. Silva   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de Demonstrativos Contแbeis utilizando Multiplas บฑฑ
ฑฑบ          ณ Vis๕es Gerenciais (Multi Saldos/Multi Perํodos)            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTBR590()

Local nGetQtVis		:= 0
Local cGetMoeda		:= CriaVar("CTO_MOEDA",.F.)
Local cGetMTaxa		:= CriaVar("M2_TXMOED2")
Local cComboFil 	:= '2'
Local aPeriodos		:= {}
Local aClVisoes		:= {}
Local aClCalPer		:= {}
Local oCTR590Wiz 	:= Nil
Local aSelFil		:= {}

Local lOutrEnt		:= .F.
Local lEnt06		:= .F.
Local lEnt07		:= .F.
Local lEnt08		:= .F.
Local lEnt09		:= .F.

//Se existir alguma das entidades adicionais.
If   CTS->( FieldPos( "CTS_E05INI" ))  > 0   .Or.  CTS->( FieldPos( "CTS_E06INI" ))  > 0 .Or.  CTS->( FieldPos( "CTS_E07INI" ))  > 0 ; 
	.Or.  CTS->( FieldPos( "CTS_E08INI" ))  > 0 .Or.  CTS->( FieldPos( "CTS_E09INI" ))  > 0
	
	If GetMV("MV_CTBCUBE",.T.,"0") == "1"
		Help(" ",1,"CTBENTR590",, STR0042,3,1) //"Relat๓rio nใo disponํvel para utilizar com as entidades adicionais"
		Return Nil	
	EndIf
EndIf

/*
 * Tela de Sele็ใo de informa็๕es que serใo utilizadas para emissใo dos
 * Demonstrativos Contแbeis:
 * - Tela Inicial (Informa็๕es)
 * - Informa็๕es Iniciais
 * - Vis๕es Gerenciais;
 * - Calendแrio Contแbil;
 * - Periodicidade (Quinzenal/Mensal/Trimestral/Semestral/Anual).
 */

/*
 * Painel 1 - Tela Inicial do Wizard
 */
oCTR590Wiz := APWizard():New(;
STR0001		,; //< ch Title> 	//"Demonstrativos Contแbeis M๚ltiplas Vis๕es Gerenciais"
STR0002		,; //< chMsg >		// "Apresenta็ใo"
STR0003		,; //< cTitle >		//"Bem-Vindo "
STR0004		,; //<chMsg>		//"Esta ferramenta irแ auxiliar a preencher as informa็๕es necessแrias para confira็ใo da emissใo de demonstrativos contแbeis utilizando m๚ltiplas vis๕es gerenciais"
{||.T.} 	,;	//< bNext >
{||.T.}		,;	//< bFinish >
.F.			,;	//<.lPanel.>
			,;	//< cResHead >
			,;	//< bExecute >
			,;	//<.lNoFirst.>
			)	//< aCoord >  

/*
 * Painel 2 - Defini็ใo de Parโmetros Gerais
 */
oCTR590Wiz:NewPanel(;
STR0005 	,; //<chTitle> //"Parโmetros Iniciais"
STR0006		,; //<chMsg> //"Defini็ใo de parโmetros inicias do relat๓rio"
{||.T.}		,; //<bBack>
{|| CTB590Next(@oCTR590Wiz,@cComboFil,@nGetQtVis,@cGetMoeda,1)},; //<bNext>
{||.T.}		,; //<bFinish>
.T.			,; //<.lPanel.>
{|| CTR590Info(@oCTR590Wiz,@nGetQtVis,@cGetMoeda,@cGetMTaxa,@cComboFil) })  //<bExecute>

/*
 * Painel 3 - Selecใo de Filiais
 */
oCTR590Wiz:NewPanel(;
STR0007		,; //<chTitle>"Sele็ใo de Filiais"
STR0008		,; //<chMsg> // "Filtro por Filiais/Unid.Neg๓cio/Empresa"
{||.T.}		,; //<bBack>
{||.T.} 	,; //<bNext>
{||.T.}		,; //<bFinish>
.T.			,; //<.lPanel.>
{|| aSelFil := CTR590Fil(@cComboFil)})  //<bExecute>

/*
 * Painel 4 - Defini็ใo de Calendแrios Contแbeis X Periodicidade
 */
oCTR590Wiz:NewPanel(;
STR0009		,;//<chTitle> /"Calendแrio Contแbil X Periodicidade"
""			,; //<chMsg>
{|| CTB590Next(@oCTR590Wiz,@cComboFil,,,2)},; //<bBack>
{||	CTB590Next(@oCTR590Wiz,@cComboFil,,,,@aClCalPer,@aPeriodos) },; //<bNext>
{||.T.}		,; //<bFinish>
.T.			,; //<.lPanel.>
{|| CTR590Cal(@oCTR590Wiz,@cComboFil,@aClCalPer) } ) //<bExecute>

/*
 * Painel 5 - Defini็ใo das Vis๕es Gerenciais
 */
oCTR590Wiz:NewPanel(;
STR0010		,; //<chTitle>  // "Vis๕es Gerenciais"
""			,; //<chMsg>
{||.T.}		,; //<bBack>
{||.T.}		,; //<bNext>
{|| CTR590Rpt(@aClVisoes,aSelFil,cGetMoeda,cGetMTaxa,aPeriodos)}	,; //<bFinish>
.T.			,; //<.lPanel.>
{|| CTR590Vis(@oCTR590Wiz,@nGetQtVis,@cComboFil,@aClVisoes) })  //<bExecute>

oCTR590Wiz:Activate()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณCTBR900   บAutor  ณ Marylly A. Silva   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para parametriza็ใo de inํcio das informa็๕es dos 	  บฑฑ
ฑฑบ          ณ demonstrativos contab้is com visใo gerencial 		      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Info(oCTR590Wiz,nGetQtVis,cGetMoeda,cGetMTaxa,cComboFil)

Local lRet 		:= .F.
Local oPnPrInfo	:= oCTR590Wiz:oMPanel[oCTR590Wiz:nPanel]
Local oFoPrInfo 	:= Nil
Local oGetQtVis	:= Nil
Local oSayQtVis	:= Nil
Local oGetMoeda	:= Nil
Local oSayMoeda	:= Nil
Local oGetMTaxa	:= Nil
Local oSayMTaxa	:= Nil
Local oComboFil	:= Nil
Local aComboFil	:= {"1=" + STR0011,"2=" + STR0012} // "Sim" # "Nใo"
Local oSayCmFil := Nil

// Cria Fonte para visualiza็ใo
oFoPrInfo := TFont():New('Courier new',,-12,.T.)
   
// Usando o m้todo New
oSayQtVis := TSay():New(06,01,{||STR0013},oPnPrInfo,,oFoPrInfo,,,,.T.,,,200,20) //"Quant. Vis๕es Gerenciais:"
oGetQtVis := TSpinBox():New(05, 100, oPnPrInfo, {|x| nGetQtVis := x }, 30, 13)
oGetQtVis:setRange(0, 4)
oGetQtVis:setStep(1)
oGetQtVis:setValue(nGetQtVis)
    
oSayMoeda := TSay():New( 26,01,{|| STR0014},oPnPrInfo,,oFoPrInfo,,,,.T.,,,200,20)  //"Moeda: "                             
oGetMoeda := TGet():New( 25,100,{|u| Iif( PCount() > 0, cGetMoeda := u, cGetMoeda)},oPnPrInfo,030,009,PesqPict("CTO","CTO_MOEDA"), {|| ExistCPO('CTO',cGetMoeda)},0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,"CTO","cGetMoeda",,,,)

oSayMTaxa := TSay():New( 46,01,{|| STR0015},oPnPrInfo,,oFoPrInfo,,,,.T.,,,200,20) //"Taxa de Moeda: "
oGetMTaxa := TGet():New( 45,100,{|u| Iif( PCount() > 0, cGetMTaxa := u, cGetMTaxa)},oPnPrInfo,030,009,PesqPict("SM2","M2_TXMOED2"),,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,"cGetMTaxa",,,,)

oSayCmFil := TSay():New( 66,01,{|| STR0016},oPnPrInfo,,oFoPrInfo,,,,.T.,,,200,20) //"Considera Filiais ?"
oComboFil := TComboBox():New(65,100,{|u|if(PCount()>0,cComboFil:=u,cComboFil)},aComboFil,100,20,oPnPrInfo,,{||},,,,.T.,,,,,,,,,'cComboFil')

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590CalบAutor  ณ Marylly A. Silva   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para sele็ใo dos calendแrios contab้is que serใo usadosบฑฑ
ฑฑบ          ณ nos demonstrativos contab้is com visใo gerencial 	      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Cal(oCTR590Wiz,cComboFil,aClCalPer)

Local lRet 		:= .F.
Local nCpos		:= 0
Local oPnCalPer	:= oCTR590Wiz:oMPanel[oCTR590Wiz:nPanel]
Local lCheck		:= .F.
Local oGetCalPer	:= Nil
Local cCTGAls		:= GetNextAlias()
Local cCTGQry		:= ""
Local aCTGArea	:= {}
Local aAux			:= {}
Local nContPerid	:= 1
Local nPosCal		:= 0
Local oCheckAll	:= Nil

/*
 * Monta Grid para defini็ใo dos Calendแrios Contแbeis e a sua Periodicidade
 */
Local aHdCalPer	:= {}

DEFAULT aClCalPer := {}

aAux 		:= aClCalPer
aClCalPer	:= {}

aAdd(aHdCalPer, {;
		"Mark" 					  		  							,; 	// 01 - Titulo
		"CSELECTED"	  			 				  			,;	// 02 - Campo
		"@BMP"						 							,;	// 03 - Picture
		15						   								,;	// 04 - Tamanho
		0								  						,;	// 05 - Decimal
		""							 	 						,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"L"			 				   						 	,;	// 08 - Tipo
		""	   						  							,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		''														,;
		''														,;
		''														,;
		''														,;
		})


aAdd(aHdCalPer, {;
		STR0017				  		  							,; 	// 01 - Titulo  //"Calendแrio"
		"CCALENDA"	  			 				  				,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		TamSX3("CTG_CALEND")[1]	   								,;	// 04 - Tamanho
		TamSX3("CTG_CALEND")[2]			  						,;	// 05 - Decimal
		'EXISTCPO("CTG",CCALENDA,1)' 	 						,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		"CTG"	 					  							,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		''														,;
		''														,;
		''														,;
		''														,;
		})


aAdd(aHdCalPer, {;
		STR0018				  		  							,; 	// 01 - Titulo //"Periodicidade"
		"CPERIODO"		  			 							,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		1	   													,;	// 04 - Tamanho
		0			  											,;	// 05 - Decimal
		"" 														,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		""	 					  								,;	// 09 - F3
		"R"							  							,;  // 10 - Contexto
		"1=" + STR0019 + ";2=" + STR0020 + ";3=" +  STR0021 + ";4=" + STR0022 + ";5= " + STR0023 ,;  // #"Quinzenal" #"Mensal" #"Trimestral" #"Semestral" #"Anual"
		''														,;
		''														,;
		''														,;
		})

DbSelectArea("CTG")
aCTGArea := CTG->(GetArea())

cCTGQry := "SELECT "
cCTGQry += " CTG.CTG_CALEND "
cCTGQry += " FROM " + RetSQLTab("CTG") + " "
cCTGQry += " WHERE "
cCTGQry += RetSqlCond("CTG")
cCTGQry += " GROUP BY CTG.CTG_CALEND "

cCTGQry := ChangeQuery(cCTGQry)
	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCTGQry),cCTGAls,.T.,.T.)

While (cCTGAls)->(!Eof())
	nPosCal := aScan(aAux,{|x| x[2] == (cCTGAls)->CTG_CALEND}) 
	If nPosCal <> 0
		aAdd(aClCalPer,aAux[nPosCal])	
	Else
		aAdd(aClCalPer,{"UNCHECKED",(cCTGAls)->CTG_CALEND," ",.F.})
	EndIf
	(cCTGAls)->(DbSkip())	
EndDo
RestArea(aCTGArea)
				
oGetCalPer := MsNewGetDados():New(005,008,125,285,;
	GD_UPDATE			,;
	Nil					,;
	Nil					,;
	Nil					,;
	{"CSELECTED","CPERIODO"},;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	oPnCalPer			,;
	aHdCalPer			,;
	aClCalPer)

oGetCalPer:AddAction("CSELECTED",{ || CTR590AtCl(@oGetCalPer,@lCheck,1,.F.,@aClCalPer) })
oGetCalPer:oBrowse:blDblClick := { || CTR590AtCl(@oGetCalPer,@lCheck,1,.F.,@aClCalPer) }

oCheckAll := TCheckBox():New(130,008,STR0024,{|| lCheck},oPnCalPer,100,10,,,,,,,,.T.,,,) //"&Marca/Demarca Todos"
OCheckAll:bChange := { || CTR590AtCl(@oGetCalPer,@lCheck,2,.T.,@aClCalPer) }

aClCalPer := oGetCalPer:aCols

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590VisบAutor  ณ Marylly A. Silva   บ Data ณ  16/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela para configura็ใo dos livros contแbeis para emissใo   บฑฑ
ฑฑบ          ณ de cada demonstrativo contแbil com uma visใo gerencial     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Vis(oCTR590Wiz,nGetQtVis,cComboFil,aClVisoes)

Local cCombo		:= ""
Local lRet 		:= .F.
Local oPnVisoes	:= oCTR590Wiz:oMPanel[oCTR590Wiz:nPanel]
Local nContVis	:= 0
Local nContrvi:= ""
/*
 * Monta Grid para defini็ใo dos Calendแrios Contแbeis e a sua Periodicidade
 */
Local aHdVisoes	:= {}


aAdd(aHdVisoes, {;
		STR0025				  		  						,; 	// 01 - Titulo // "Conf. Livro"
		"CLIVRO"	  			 				  				,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		TamSX3("CTN_CODIGO")[1]	   							,;	// 04 - Tamanho
		TamSX3("CTN_CODIGO")[2]			  					,;	// 05 - Decimal
		'EXISTCPO("CTN",CLIVRO,1) .And. U_CTR590Dsc()'		,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		"CTN"	 					  							,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		''														,;  // 11 - ComboBox
		''														,;	// 12 - Relacao
		''														,;	// 13 - Alterar
		''														,;  // 14 - Visual
		''														,;	// 15 - Valid Usuario
		''														,;	// 16 - Picture Variavel
		})															// 17 - Obrigatorio

aAdd(aHdVisoes, {;
		STR0026			 	 		  						,; 	// 01 - Titulo //"Descri็ใo"
		"CDSCLIV"	  			 				  				,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		TamSX3("CTN_DESC")[1]	   							,;	// 04 - Tamanho
		TamSX3("CTN_DESC")[2]			  					,;	// 05 - Decimal
		'' 							 	   						,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		""							  							,;	// 09 - F3
		"V"							  							,;	// 10 - Contexto
		''														,;
		'Alltrim(GETADVFVAL("CTN", "CTN_DESC", XFILIAL("CTN")+CLIVRO, 1, "" ))'	,;
		''														,;
		'V'														,;
		})
		
				
aAdd(aHdVisoes, {;
		STR0027				  		  						,; 	// 01 - Titulo //"Tipo Saldo"
		"CTPSLD"	  			 				  				,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		TamSX3("CT2_TPSALD")[1]	   							,;	// 04 - Tamanho
		TamSX3("CT2_TPSALD")[2]			  					,;	// 05 - Decimal
		'EXISTCPO("SX5","SL"+CTPSLD)'		 	 			,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		"SLW"	 					  							,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		''														,;
		''														,;
		''														,;
		''														,;
		})

If FieldPos("CTS_PICTUR")> 0
nContrvi:= TamSX3("CTS_PICTUR")[1]
aAdd(aHdVisoes, {;
		STR0040				  		  						,; 	// 01 - Titulo //"Pict. Tot."
		"PCTTOT"	  			 				  				,;	// 02 - Campo
		""						 								,;	// 03 - Picture
		TamSX3("CTS_PICTUR")[1]	   							,;	// 04 - Tamanho
		TamSX3("CTS_PICTUR")[2]			  					,;	// 05 - Decimal
		""		 	 											,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		""	 					  								,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		''														,;
		''														,;
		''														,;
		''														,;
		})
EndIf



dbSelectArea("SX3")
dbSetOrder(2)
If dbSeek("CTS_TPVALO")
	cCombo := X3Cbox()
EndIf
	
aAdd(aHdVisoes, {;
		STR0041				  		  						,; 	// 01 - Titulo //"Tp. Val. Tot."
		"TPTOT"	  			 				  				,;	// 02 - Campo
		"@!"						 							,;	// 03 - Picture
		TamSX3("CTS_TPVALO")[1]	   							,;	// 04 - Tamanho
		TamSX3("CTS_TPVALO")[2]			  					,;	// 05 - Decimal
		""		 	 											,;	// 06 - Valid
		""			  					 						,;	// 07 - Usado
		"C"			 				   						 	,;	// 08 - Tipo
		""	 					  								,;	// 09 - F3
		"R"							  							,;	// 10 - Contexto
		cCombo													,;
		''														,;
		''														,;
		''														,;
		})

If Len(aClVisoes) != nGetQtVis
	aClVisoes := {}
	For nContVis := 1 To nGetQtVis
		aAdd(aClVisoes,{Space(TamSX3("CTN_CODIGO")[1]),Space(TamSX3('CTN_DESC')[1]),"1",Space(TamSX3('CTS_PICTUR')[1]),"D",.F.})
	Next nContVis
EndIf

oGetVisoes := MsNewGetDados():New(005,008,125,285,;
	GD_UPDATE			,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	Nil					,;
	oPnVisoes			,;
	aHdVisoes			,;
	aClVisoes)

aClVisoes := oGetVisoes:aCols

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590RDefบAutor  ณ Marylly A. Silva   บ Data ณ  18/11/11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo exibi็ใo da tela de parโmetros e emissใo do relat๓rioบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @oReport (Objeto do relat๓rio)					  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Rpt(aClVisoes,aSelFil,cGetMoeda,cGetMTaxa,aPeriodos,cPeriodic)
Local lRet			:= .T.
Local oReport		:= Nil
Local aArea 		:= GetArea()
Local cTitulo		:= STR0001 // "Demonstrativos Contแbeis M๚ltiplas Vis๕es Gerenciais"
Local nCtVis   		:= 0

For nCtVis := 1 To Len(aClVisoes)
	If AllTrim(aCLVisoes[nCtVis][1]) == ""
		Alert(STR0028 + CVALTOCHAR(nCtVis) + "บ ") //"Informe a configura็ใo do livro contแbil da linha "
    	lRet := .F.
    	Exit
	ElseIf AllTrim(aCLVisoes[nCtVis][3]) == ""
		Alert(STR0029 + CVALTOCHAR(nCtVis) + "บ ")  //"Informe o tipo de saldo contแbil da linha "
		lRet := .F.
    	Exit
	EndIf	
Next nCtVis

If lRet 
	oReport := CTR590RDef(cTitulo,aClVisoes,aSelFil,cGetMoeda,cGetMTaxa,aPeriodos)		
	oReport:PrintDialog() // Tela de parโmetros para impressใo do relatดrio do TReport
EndIf

RestArea( aArea )

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590RDefบAutor  ณ Marylly A. Silva   บ Data ณ  18/11/11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para defini็ใo do layout e estrututra do relat๓rio  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @oReport (Objeto do relat๓rio)					  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590RDef(cTitulo,aVisoes,aSelFil,cGetMoeda,cGetMTaxa,aPeriodos)

Local oReport		:= Nil
Local oSecHeader	:= Nil 
Local oSecDados		:= Nil
Local nContPerid	:= 1
Local nSizeColum	:= 0
Local nQtdPeriodo	:= Len(aPeriodos)

If nQtdPeriodo >= 1 .AND. nQtdPeriodo <= 3
	nSizeColum := 110
ElseIf nQtdPeriodo > 3 .AND. nQtdPeriodo <= 6
	nSizeColum := 60
ElseIf nQtdPeriodo > 6 .AND. nQtdPeriodo <= 12
	nSizeColum := 90
ElseIf nQtdPeriodo > 12 .AND. nQtdPeriodo <= 15
	nSizeColum := 80
ElseIf nQtdPeriodo > 15 .AND. nQtdPeriodo <= 20
	nSizeColum := 60
EndIf

/*ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 *ณCria็ใo dos componentes de impressใo                                    ณ
 *ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
 */
oReport := TReport():New( FunName() )
oReport:SetTitle( cTitulo )
oReport:SetAction( { |oReport| RPT590Imp( oReport, aVisoes, aSelFil, cGetMoeda, cGetMTaxa, aPeriodos ) } )
oReport:SetDescription( STR0001 ) //"Demonstrativos Contแbeis M๚ltiplas Vis๕es Gerenciais"
oReport:SetLandScape()

/*
 * Cabe็alho do Relat๓rio de Demonstra็ใo de Resultados do Exercํcio
 */
oSecHeader := TRSection():New(oReport,"")
oSecHeader:SetLineStyle() //Define a impressao da secao em linha
oSecHeader:SetBorder("TOP")
oSecHeader:SetBorder("BOTTOM")
oSecHeader:SetBorder("LEFT")
oSecHeader:SetBorder("RIGHT")
oSecHeader:SetAutoSize(.T.)

TRCell():New( oSecHeader, "TITULO" ,/*Alias*/, " "/*SuperGetMV("MV_SIMB" + AllTrim( Str( nMoeda ) ) )*/,""/*Picture*/,195,/*lPixel*/,/*{|| code-block de impressao }*/)	// Valor Moeda1
oSecHeader:Cell("TITULO"):SetAlign("CENTER") 

oSecDados := TRSection():New(oReport,"")
oSecDados:SetBorder("TOP")
oSecDados:SetBorder("BOTTOM")
oSecDados:SetBorder("LEFT")
oSecDados:SetBorder("RIGHT")

TRCell():New( oSecDados, "CONTA", /*Alias*/, " "/*SuperGetMV("MV_SIMB" + AllTrim( Str( nMoeda ) ) )*/,""/*Picture*/,150,/*lPixel*/,/*{|| code-block de impressao }*/)
oSecDados:Cell("CONTA"):SetTitle("")
oSecDados:Cell("CONTA"):SetAlign("LEFT")
oSecDados:SetCellBorder("RIGHT")
oSecDados:SetCellBorder("LEFT")
oSecDados:SetCellBorder("TOP")
oSecDados:SetCellBorder("BOTTOM")
oSecDados:SetHeaderSize(.T.,nSizeColum,0,50)

For nContPerid := 1 To Len(aPeriodos)
	TRCell():New( oSecDados, "PERI" + CVALTOCHAR(nContPerid),/*Alias*/, " "/*SuperGetMV("MV_SIMB" + AllTrim( Str( nMoeda ) ) )*/,""/*Picture*/,nSizeColum,.F.,/*{|| code-block de impressao }*/)
	oSecDados:Cell("PERI" + CVALTOCHAR(nContPerid)):SetTitle(aPeriodos[nContPerid][1])
	oSecDados:Cell("PERI" + CVALTOCHAR(nContPerid)):SetHeaderAlign("CENTER")	
	oSecDados:Cell("PERI" + CVALTOCHAR(nContPerid)):SetAlign("CENTER")	
	
  	//Totalizador
  	TRFunction():New(oSecDados:Cell("PERI" + CVALTOCHAR(nContPerid)),"PERI" + CVALTOCHAR(nContPerid) ,"ONPRINT",,STR0039/*cTitle*/,/*cPicture*/,,.T./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/) //"Total"
	oSecDados:Cell("PERI" + CVALTOCHAR(nContPerid)):SetTotalText(" ")
Next nContPerid

oSecDados:SetTotalText(STR0039)
oSecDados:SetTotalInLine(.F.)

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ RPT590ImpบAutor  ณ Marylly A. Silva   บ Data ณ  22/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para processamento dos dados e emissใo do relat๓rio บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @oReport (Objeto do relat๓rio)					  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RPT590Imp(oReport, aVisoes, aSelFil, cGetMoeda, cGetMTaxa, aPeriodos)

Local oDlg			:= Nil
Local oMeter		:= Nil
Local oText			:= Nil
Local lEnd			:= .F.
Local cArqTmp		:= ""
Local dFinal		:= CTOD(" / / ")
Local oSecHeader	:= oReport:Section(1) //Header
Local oSecDados		:= oReport:Section(2) //Dados                           
Local cAlias        := "CT7"
/*
Este relatorio nใo estแ preparado para multiplas entidades somente para as que estใo na CT7
Local cAlias		:= Iif(GetMV("MV_CTBCUBE",.T.,"0") == "1","CVY","CT7") //Verifica se estแ utilizando + de 4 entidades contแbeis
*/
Local cHeader		:= "CT1"
Local lMovPeriod	:= .T.
Local aSetOfBook	:= {}                                    
Local aCtbMoeda 	:= {}
Local cDescMoeda	:= ""
Local cSaldos		:= "" //Or็ado - Real - Previsto
Local cAlsTmp		:= ""
Local nContPer		:= 1
Local nX			:= 1
Local aDados		:= {}
Local nDecimais 	:= 0
Local nContDad		:= 0	
Local cPicture		:= ""
Local cTpVal		:= ""
Local cNormal		:= ""
Local oTotais		:= Nil
Local aTotal 		:= {}

If cGetMTaxa == 0.00
	 cGetMTaxa := 1
EndIf

For nContPer := 1 To Len(aPeriodos)	
	oSecDados:GetFunction("PERI" + CVALTOCHAR(nContPer)):SetFormula(&("{|| ValorCTB(aTotal["+AllTrim(Str(nContPer))+"],,,130,2,.T.,cPicture,,,,,cTpVal,,.T.,.F.)}"))
Next nContPer

For nX := 1 To Len(aVisoes)
	aSetOfBook	:= CTBSetOf( aVisoes[nX][1] )
	cTitulo		:= CTBNomeVis( aSetOfBook[5] )
	aCtbMoeda 	:= CtbMoeda( cGetMoeda, aSetOfBook[9] )
	cDescMoeda	:= AllTrim( aCtbMoeda[3] )

	cSaldos	:= aVisoes[nX][3]
	
	nDecimais 	:= DecimalCTB(aSetOfBook,cGetMoeda)
	aDados		:= {}
	
	//Variแveis para formata็ใo do totalizador
	cPicture 	:= aSetOfBook[4]
	cTpVal		:= aVisoes[nX][4]
	
	oSecHeader:Init()     
	oSecHeader:Cell("TITULO"):SetValue(AllTrim(cTitulo))
	oSecHeader:PrintLine()		
	oSecHeader:Finish()
		
	For nContPer := 1 To Len(aPeriodos)
		dInicial	:= aPeriodos[nContPer][2]
		dFinal		:= aPeriodos[nContPer][3]
		CTGerPlan(	oMeter,;		// 1
					oText,;			// 2
					oDlg,;			// 3
					@lEnd,;			// 4
					@cArqTmp,;		// 5
					dInicial,;		// 6
					dFinal,;		// 7
					cAlias,;		// 8
					"",;			// 9
					"",;			// 10
					Repl("Z", TamSX3("CT1_CONTA")[1]),;// 11
					"",;			// 12
					Repl("Z", TamSX3("CTT_CUSTO")[1]),;// 13
					"",;			// 14
					Repl("Z", TamSX3("CTD_ITEM")[1]),;	// 15
					"",;			// 16
					Repl("Z", TamSX3("CTH_CLVL")[1]),;	// 17
					cGetMoeda,;		// 18
					cSaldos,;		// 19
					aSetOfBook,;	// 20
					Space(2),;		// 21
					Space(20),;		// 22
					Repl("Z", 20),;	// 23
					Space(30),;		// 24
					,;				// 25
					,;				// 26
					,;				// 27
					cHeader,;		// 28
					.F.,; 			// 29
					,;      		// 30
					0,;				// 31
					.T.,;			// 32
					,;				// 33
					,;				// 34
					,;				// 35
					,;				// 36
					,;				// 37
					,;				// 38
					,;				// 39
					,;				// 40
					,;				// 41
					,;				// 42
					,;				// 43
					,;				// 44
					,;				// 45
					,;				// 46
					,;				// 47
					,;				// 48
					,;				// 49
					,;				// 50
					,;				// 51
					,;				// 52
					,;				// 53
					,;				// 54
					,;				// 55
					,;				// 56
					cGetMoeda,;		// 57
					lMovPeriod,;	// 58
					aSelFil,;		// 59
					,;				// 60
					,;				// 61
					.F.,; 			// 62
					,;				// 63
					,;				// 64
					.T.,;			// 65
					,;				// 66
					)	 			// 67
		
		cAlsTmp := "cArqTmp"
		DbSelectArea(cAlsTmp)
		(cAlsTmp)->(DbGoTop())
	
        While (cAlsTmp)->(!Eof())   	
        	If (nPosConta := aScan(aDados, {|x| x[1] == (cAlsTmp)->CONTA})) > 0
				aAdd(aDados[nPosConta][3],(cAlsTmp)->SALDOATU*cGetMTaxa)								
			Else
				aAdd(aDados,{(cAlsTmp)->CONTA,;
					  		(cAlsTmp)->DESCCTA,;
							{(cAlsTmp)->SALDOATU*cGetMTaxa},;
							(cAlsTmp)->TIPOCONTA,;
    					 		cPicture,;
    					 		(cAlsTmp)->NORMAL,;
    					 		cTpVal } )										
			EndIf			
		 	(cAlsTmp)->(DbSkip())		
		EndDO
		(cAlsTmp)->(DbCloseArea())
	Next nContPer
    
	/* Impressใo dos dados relat๓rio de resultados */		
 	oSecDados:Init()
 	
 	/* Executa a impressใo do relat๓rio */
 	
 	aTotal := Array(Len(aPeriodos))
	aFill(aTotal,0)
 	
 	For nContDad := 1 To Len(aDados) 		
		
		oSecDados:Cell("CONTA"):SetValue( Iif(aDados[nContDad][4] == "2",Space(4),"") + AllTrim(aDados[nContDad][1]) + "-" + AllTrim(aDados[nContDad][2]))
		
		For nContPer := 1 To Len(aPeriodos)
			oSecDados:Cell("PERI" + CVALTOCHAR(nContPer)):SetValue(AllTrim(ValorCTB(aDados[nContDad][3][nContPer],,,130,2,.T.,aDados[nContDad][5],aDados[nContDad][6],aDados[nContDad][1],,,aDados[nContDad][7],,.T.,.F.)))
			
			//Soma as analํticas para o totalizador
			If aDados[nContDad][4] == "2"
				aTotal[nContPer] += aDados[nContDad][3][nContPer]
			EndIf
				
		Next nContPer
		
		oSecDados:PrintLine(.T.)
			
	Next nContDad

	/* Finaliza impressใo inicializada pelo m้todo Init() */
  	oSecDados:Finish()
       
	/* Ap๓s finaliza็ใo do processamento de dados do relat๓rio, quebra a pแgina do relat๓rio */
	oReport:EndPage()
Next nX

/* Define a barra de progresso para impressใo do relat๓rio */
oReport:SetMeter(300)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590AtClบAutor  ณ Marylly A. Silva   บ Data ณ  18/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza a imagem de Check/UnCheck da sele็ใo dos calendแ- บฑฑ
ฑฑบ          ณ rios contแbeis na parametriza็ใo do relat๓rio.			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @oGetCalend (Objeto da GetDados Calendแrios)	  บฑฑ
ฑฑบ          ณ Parโmetro @lCheck (Se a linha estแ selecionada)	          บฑฑ
ฑฑบ          ณ Parโmetro @nTipo (Se ้ apenas uma linha ou todos da tela)  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590AtCl(oGetCalend,lCheck,nTipo,lAll,aClCalPer)

Local nCpoPos	:= oGetCalend:oBrowse:nColPos
Local nI		:= 0
Local nPosCheck	:= Ascan(oGetCalend:AHeader , { | x | AllTrim( X[ 2 ] ) == 'CSELECTED' } )

DEFAULT lAll := .F.
Default aClCalPer := oGetCalend:ACOLS

If nTipo == 2 // Marca/Desmarca todos
	lCheck := !lCheck
	For nI := 1 To Len(oGetCalend:ACOLS)
		If lCheck
			oGetCalend:ACOLS[nI][1] := "CHECKED"		
		Else
			oGetCalend:ACOLS[nI][1] := "UNCHECKED"		
		EndIf			
	Next nI
ElseIf nTipo == 1 //Marca็ใo individual
	If oGetCalend:aCols[oGetCalend:nAT,1] == "UNCHECKED" .AND. nCpoPos == nPosCheck
		oGetCalend:aCols[oGetCalend:nAT,1] := "CHECKED"
	ElseIf nCpoPos == nPosCheck
		oGetCalend:aCols[oGetCalend:nAT,1] := "UNCHECKED"
	EndIf
EndIf   

If nCpoPos != nPosCheck .And. !lAll // Se nใo for o checkbox, permite a edi็ใo da c้lula
	oGetCalend:EditCell()
EndIf

oGetCalend:Refresh()
aClCalPer := oGetCalend:ACOLS

Return(oGetCalend)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTB590NextบAutor  ณ Marylly A. Silva   บ Data ณ  18/11/11  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo do Bloco de comando do botใo Next ou Back 		  บฑฑ
ฑฑบ          ณ do Wizard para parametriza็ใo do relat๓rio.				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @cComboFil (Considera Filiais ?)				  บฑฑ
ฑฑบ          ณ Parโmetro @oCTR590Wiz (Objeto do Wizard)	         		  บฑฑ
ฑฑบ          ณ Parโmetro @nNextBack (Se Next ou Back) 					  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTB590Next(oCTR590Wiz,cComboFil,nGetQtVis,cGetMoeda,nNextBack,aClCalPer,aPeriodos)
Local lRet 		:= .T.
Local nContPerid:= 0
Local nNumAux	:= 0
Local aArrAux	:= {}
Local nNumCtl	:= 1
Local aCTOArea	:= {}

Default cComboFil := 0
Default nNextBack := 0
Default aClCalPer := {}
Default aPeriodos := {}

If oCTR590Wiz:nPanel == 2 .OR. oCTR590Wiz:nPanel == 3
	DbSelectArea("CTO")
	aCTOArea :=	CTO->(GetArea())
	
	If EMPTY(cComboFil)
		Alert(STR0030) //"Defina se serใo consideradas as filiais/Und.Neg๓cio/Empresa no relat๓rio"
		lRet := .F.	
	ElseIf (nGetQtVis <= 0)
		Alert(STR0031) //"Deve ser definia uma quantidade de vis๕es gerenciais que serใo utilizadas no relat๓rio, pelo menos uma deve ser definida"
		lRet := .F.
	ElseIf AllTrim(cGetMoeda) == ''
		Alert(STR0032) //"Deve ser definida a moeda dos saldos do relat๓rio de demonstrativos contแbeis."
		lRet := .F.
	ElseIf !ExistCPO("CTO",cGetMoeda)
		Alert(STR0033) //"Moeda definida invแlida."
		lRet := .F.
	EndIf
	RestArea(aCTOArea)
ElseIf oCTR590Wiz:nPanel == 4 .And. nNextBack != 2
	aPeriodos := {}
	For nContPerid := 1 To Len(aClCalPer)
		If AllTrim(aClCalPer[nContPerid][1]) == "CHECKED"
			aArrAux := CTR590Clc(aClCalPer[nContPerid][2],aClCalPer[nContPerid][3])
			For nNumAux := 1 To Len(aArrAux)
				If aClCalPer[nContPerid][3] == "1"		// Periodicidade Quinzenal
					If PADL(Day(aArrAux[nNumAux][1]),2,"0") $ "01|02|03|04|05|06|07|08|09|10|11|12|13|14|15"
						nNumCtl := 1
					Else
						nNumCtl := 2
					EndIf
					aAdd(aPeriodos,;
						{CVALTOCHAR(nNumCtl) + "ช " + STR0034 + " " + CRLF  + CVALTOCHAR(MONTH(aArrAux[nNumAux][1])) + "/" + CVALTOCHAR(YEAR(aArrAux[nNumAux][1])),; // Label do Perํodo //"Quinzena"
						aArrAux[nNumAux][1],; 						// Data Inicial do Intervalo
						aArrAux[nNumAux][2]}) 						// Data Final do Intervalo
				ElseIf aClCalPer[nContPerid][3] == "2"	// Periodicidade Mensal
					aAdd(aPeriodos,;
						{FG_CMONTH(aArrAux[nNumAux][1]) + "/" + CVALTOCHAR(YEAR(aArrAux[nNumAux][1])),; // Label do Perํodo
						aArrAux[nNumAux][1],; 						// Data Inicial do Intervalo
						aArrAux[nNumAux][2]}) 						// Data Final do Intervalo
				ElseIf aClCalPer[nContPerid][3] == "3"	// Periodicidade Trimestral
					If PADL(MONTH(aArrAux[nNumAux][1]),2,"0") $ "01|02|03"
						nNumCtl := 1
					ElseIf PADL(MONTH(aArrAux[nNumAux][1]),2,"0") $ "04|05|06"
						nNumCtl := 2
					ElseIf PADL(MONTH(aArrAux[nNumAux][1]),2,"0") $ "07|08|09"
						nNumCtl := 3
					Else
						nNumCtl := 4				
					EndIf
					aAdd(aPeriodos,;
						{CVALTOCHAR(nNumCtl) + "บ " + STR0035 + " " + CRLF + CVALTOCHAR(YEAR(aArrAux[nNumAux][1])),;	 // Label do Perํodo  //"Trimestre"
						aArrAux[nNumAux][1],; 						// Data Inicial do Intervalo
						aArrAux[nNumAux][2]}) 				  		// Data Final do Intervalo
				ElseIf aClCalPer[nContPerid][3] == "4"	// Periodicidade Semestral
					If PADL(MONTH(aArrAux[nNumAux][1]),2,"0") $ "01|02|03|04|05|06"
						nNumCtl := 1
					ElseIf PADL(MONTH(aArrAux[nNumAux][1]),2,"0") $ "07|08|09|10|11|12"
						nNumCtl := 2			
					EndIf
					aAdd(aPeriodos,;
						{CVALTOCHAR(nNumCtl) + "บ " + STR0036 + " " + CRLF + CVALTOCHAR(YEAR(aArrAux[nNumAux][1])),; // Label do Perํodo  //"Semestre"
						aArrAux[nNumAux][1],; 		   				// Data Inicial do Intervalo
						aArrAux[nNumAux][2]}) 				  		// Data Final do Intervalo
				ElseIf aClCalPer[nContPerid][3] == "5"	// Periodicidade Anual
			 		aAdd(aPeriodos,;
						{CVALTOCHAR(YEAR(aArrAux[nNumAux][1])),;	// Label do Perํodo
						aArrAux[nNumAux][1],; 						// Data Inicial do Intervalo
						aArrAux[nNumAux][2]}) 						// Data Final do Intervalo  
				EndIf
			Next nNumAux
		EndIf
	Next nContPerid

	If Len(aPeriodos) > 19
		Alert(I18N(STR0037,{20})) //"Quantidade de perํodos superou o limite de #1[Limite Colunas]# colunas. Altere os calendแrios e perํodos desejados."
		lRet := .F.
	ElseIf Len(aPeriodos) == 0
		Alert(STR0038) //"Defina pelo menos um calendแrio e periodicidade."
		lRet := .F.
	EndIf
EndIf

If nNextBack == 1 .AND. cComboFil == '2' .AND. oCTR590Wiz:nPanel == 2 
	oCTR590Wiz:nPanel := oCTR590Wiz:nPanel+1
ElseIf nNextBack == 2 .AND. cComboFil == '2' .AND. oCTR590Wiz:nPanel == 4 
	oCTR590Wiz:nPanel := oCTR590Wiz:nPanel-1 
ElseIf EMPTY(cComboFil)
	lRet := .F.
EndIf	
		
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590FilบAutor  ณ Marylly A. Silva   บ Data ณ  18/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Carrega tela de sele็ใo de Empresa/Unid.Neg๓cio/Filiais	  บฑฑ
ฑฑบ          ณ t๓rio de acordo com o caledแrio contแbil informado.		  บฑฑ
ฑฑบ          ณ Perํodos possํveis (Parโmetro nPeriodic):  		  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @cComboFil(Considera Filiais?)					  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Fil(cComboFil)
Return AdmGetFil()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590ClcบAutor  ณ Marylly A. Silva   บ Data ณ  21/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna os intervalos de datas que serใo exibidos no rela- บฑฑ
ฑฑบ          ณ t๓rio de acordo com o caledแrio contแbil informado.		  บฑฑ
ฑฑบ          ณ Perํodos possํveis (Parโmetro nPeriodic):  		  		  บฑฑ
ฑฑบ          ณ 1 - Semana												  บฑฑ
ฑฑบ          ณ 2 - Dec๊ndio												  บฑฑ
ฑฑบ          ณ 3 - Quinzena												  บฑฑ
ฑฑบ          ณ 4 - Mensal												  บฑฑ
ฑฑบ          ณ 5 - Bimestral											  บฑฑ
ฑฑบ          ณ 6 - Trimestral											  บฑฑ
ฑฑบ          ณ 7 - Semestral											  บฑฑ
ฑฑบ          ณ 8 - Anual												  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Parโmetro @cCalend(Calendแrio Contแbil)					  บฑฑ
ฑฑบ          ณ Parโmetro @nPeriodic (Periodicidade a ser utilizada)		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CTR590Clc(cCalend,nPeriodic)

Local aPeriodos := {}
Local aCTGArea	:= {}
Local cCTGQry	:= ""
Local cCTGAls	:= GetNextAlias()

If nPeriodic == "1" 	// Quinzenal
	nPeriodic := "3"
ElseIf nPeriodic == "2"	// Mensal
	nPeriodic := "4"
ElseIf nPeriodic == "3"	// Trimestral
	nPeriodic := "6"
ElseIf nPeriodic == "4"	// Semestral
	nPeriodic := "7"
ElseIf nPeriodic == "5"	// Anual
	nPeriodic := "8"
EndIf

DbSelectArea("CTG")
aCTGArea := CTG->(GetArea())

cCTGQry := "SELECT "
cCTGQry += " MIN(CTG.CTG_DTINI) CTG_DTINI "
cCTGQry += " ,MAX(CTG.CTG_DTFIM) CTG_DTFIM "
cCTGQry += " FROM " + RetSQLTab("CTG") + " "
cCTGQry += " WHERE "
cCTGQry += " CTG.CTG_CALEND = '" + cCalend + "' "
cCTGQry += " AND " + RetSqlCond("CTG")

cCTGQry := ChangeQuery(cCTGQry)
	
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCTGQry),cCTGAls,.T.,.T.)

TcSetField(cCTGAls, "CTG_DTINI", "D")
TcSetField(cCTGAls, "CTG_DTFIM", "D")

While (cCTGAls)->(!Eof())
	aPeriodos := CTBClcPrd((cCTGAls)->CTG_DTINI,(cCTGAls)->CTG_DTFIM,nPeriodic)
	(cCTGAls)->(DbSkip())	
EndDo
RestArea(aCTGArea)
Return aPeriodos

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFun็ใo    ณ CTR590DscบAutor  ณ Marylly A. Silva   บ Data ณ  05/12/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descri็ใo da configura็ใo do livro contabํl no   บฑฑ
ฑฑบ          ณ tela do Wizard de informa็ใo das vis๕es gerenciais do 	  บฑฑ
ฑฑบ          ณ relat๓rio										  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบPrograma  ณ CTBR900 - Relat๓rio de Demonstrativos Contแbeis 			  บฑฑ
ฑฑบ          ณ utilizando Multiplas Vis๕es Gerenciais 			          บฑฑ
ฑฑบ          ณ (Multi Saldos/Multi Perํodos)							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 															  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTR590Dsc()
Local lRet		:= .T.

GDFIELDPUT("CDSCLIV",Alltrim(GETADVFVAL("CTN", "CTN_DESC", XFILIAL("CTN")+GDFIELDGET("CLIVRO",,.T.), 1, "" )))

Return lRet
