/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "ATFR095.CH"
#INCLUDE "DBINFO.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR095   ºAutor  ³Jair Ribeiro        º Data ³  02/21/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Demonstrativo de ativos reavaliados		                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ATFR095()
Local oReport	:= Nil
Local cPerg		:=  "AFR095" 
Local lAtf95Fil	:= .F.
Local aAtf95Fil	:= {}
Local aAtf95Moe	:= {}
Local lContinua	:= .T.
Local lDefTop 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local aSelClass := {}

If !lDefTop
	Help("  ",1,"AFR095TOP",,STR0002 ,1,0)//"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If Pergunte(cPerg,.T.)
	If MV_PAR12 == 1							//Seleciona Filiais
		aAtf95Fil	:=	AdmGetFil(@lAtf95Fil)
		lContinua	:= Len(aAtf95Fil)>0
	Else
		aAtf95Fil := {cFilAnt}
	EndIf     
	
	If MV_PAR13 == 1 .and. lContinua
		aAtf95Moe 	:= ADMGETMOED()				//Seleciona Moedas
		lContinua	:= Len(aAtf95Moe)>0
		If lContinua
			If Len(aAtf95Moe) > 5
				Help(" ",1,"ATR072MOE",,STR0001,1,0)//"Deve ser selecionado no máximo 5 moedas"
				lContinua:=.F.
			EndIf
		EndIf
	ElseIf lContinua
		aAtf95Moe := {"01"}
	EndIf
	
	//Seleciona as classificações patrimoniais 
	If MV_PAR14 == 1 .And. Len( aSelClass ) <= 0
		aSelClass := AdmGetClas() 
		If Len( aSelClass ) <= 0
			Return
		EndIf 	
	EndIf
	
	
	If lContinua
		oReport:= ATFR095RDf(cPerg,lAtf95Fil,aAtf95Fil,aAtf95Moe,aSelClass)
		oReport:PrintDialog()
	EndIf
EndIf

Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |ATFR095RDfºAutor  ³Jair Ribeiro	     º Data ³  02/21/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Estrutura Relatorio                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cPerg: Grupo de perguntas 			                      º±±
±±º			 ³lAtf95Fil: Indica se todas filiais foram selecionadas       º±±
±±º			 ³aAtf95Fil: Array com filiais selecionadas                   º±±
±±º			 ³aAtf95Moe: Array com moedas selecionadas                    º±±
±±º			 ³aClassif : Array com classificações selecionadas            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno	 ³oReport: Objeto TReport estruturado para impressao          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR095RDF(cPerg,lAtf95Fil,aAutoFil,aAutoMoe,aAutoClassif)
Local oReport		:= Nil		//Objeto TReport
Local oSecAtivo	:= Nil		//Secao Dados do Ativo
Local oSecSaldo	:= Nil		//Secao Saldo e Valores
Local cDesc		:= STR0004 //"Demonstrativo de Ativos Reavaliados"  
Local aClassif   := {}
Local aAtf95Fil  := {}
Local aAtf95Moe  := {}

Default aAutoClassif := {}

aAtf95Fil := aClone(aAutoFil)
aAtf95Moe := aClone(aAutoMoe)
aClassif  := aClone(aAutoClassif)

oReport:= TReport():New(cPerg,cDesc,cPerg,{|oReport| ATFR095PRC(oReport,lAtf95Fil,aAtf95Fil,aAtf95Moe,aClassif)},cDesc)
oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                   						DADOS DO ATIVO		                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecAtivo := TRSection():New(oReport,STR0027,{"SN1","NAOUSADO"}) //"Dados da Ficha do Ativo"
TRCell():New(oSecAtivo	,"N1_FILIAL"	,	,			   				,									,12,,,,.T.,,,,.T.)			//FILIAL
TRCell():New(oSecAtivo	,"N1_CBASE"		,	,			  				,									,10,,,,.T.,,,,.T.)			//CODIGO BASE
TRCell():New(oSecAtivo	,"N1_ITEM"		,	,			  				,									,04,,,,.T.,,,,.T.)			//ITEM
TRCell():New(oSecAtivo	,"N1_DESCRIC"	,	,			  				,									,40,,,,.T.,,,,.T.)    		//DESCRICAO SINTETICA
TRCell():New(oSecAtivo	,"N3_TIPO"		,	,			   				,									,02,,,,.T.,,,,.T.)			//TIPO
TRCell():New(oSecAtivo	,"DESCTIPO"		,""	,STR0005	,									,15,,,,.T.,,,,.T.)			//"Desc. Tipo"
TRCell():New(oSecAtivo	,"CLASTIPO"		,""	,STR0006	,									,15,,,,.T.,,,,.T.)			//"Class. Tipo"
TRCell():New(oSecAtivo	,"N1_GRUPO"		,	,							,									,06,,,,.T.,,,,.T.)    		//GRUPO
TRCell():New(oSecAtivo	,"N1_QUANTD"	,	,	,PesqPict("SN1","N1_QUANTD" ,19,1)	,19,,,,.T.,,,,.T.)    		//QUANTIDADE
TRCell():New(oSecAtivo	,"TPDEPR"		,""	, STR0007 	,									,20,,,,.T.,,,,.T.)    		//"Tipo Depr."
oSecAtivo:Cell("N1_QUANTD"):SetHeaderAlign("RIGHT")
oSecAtivo:SetHeaderPage(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                   						SALDOS E VALORES	                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecSaldo := TRSection():New(oSecAtivo,STR0028,{"SN3","NAOUSADO"})//"Saldo e Dados Contábeis"
TRCell():New(oSecSaldo,"N3_CCONTAB"	,	,				 				,									,25,,,,.T.,,,,.T.) 	//CONTA CONTABIL
TRCell():New(oSecSaldo,"N3_CCUSTO"	,	,				 	 			,									,20,,,,.T.,,,,.T.)		//CENTRO DE CUSTO
TRCell():New(oSecSaldo,"N3_SUBCTA"	,	,				 				,									,20,,,,.T.,,,,.T.)		//ITEM CONTABIL
TRCell():New(oSecSaldo,"N3_CLVL"	,	,								,									,20,,,,.T.,,,,.T.)		//CLASSE DE VALOR
TRCell():New(oSecSaldo,"N3_AQUISIC"	,	,STR0029     					,									,12,,,,.T.,,,,.T.)		//"Dt Aquisic"
TRCell():New(oSecSaldo,"ATFBAIXA"	,""	,STR0008				,									,10,,,,.T.,,,,.T.)	   	//BAIXA - Verificação(SN3): "Total/Parcial/Ativo" ATFXBAIXA(cChave)
//-------------------------------------VALORES---------------------------------------
TRCell():New(oSecSaldo,"SIMBMOEDA"	,""	,STR0009				,									,10,,,,.T.,,,,.T.) 	//"Moeda"
TRCell():New(oSecSaldo,"VIDAUTIL"	,""	,STR0010 			,PesqPict("SN3","N3_VORIG1"	,19,1)	,19,,,,.T.,,,,.T.)		//"Vida Util"
TRCell():New(oSecSaldo,"VLRORIG"	,""	,STR0011 		,PesqPict("SN3","N3_VORIG1"	,19,1)	,19,,,,.T.,,,,.T.)		//"Vlr. Original"
TRCell():New(oSecSaldo,"VLRREAV"	,""	,STR0012	,PesqPict("SN3","N3_VORIG1" ,19,1)	,19,,,,.T.,,,,.T.)		//"Vlr. Reavaliacao"
TRCell():New(oSecSaldo,"VLRAMPL"	,""	,STR0025	,PesqPict("SN3","N3_VORIG1" ,19,1)	,19,,,,.T.,,,,.T.)		//"Vlr. Ampliação"
TRCell():New(oSecSaldo,"VLRDPRAC"	,""	,STR0013		,PesqPict("SN3","N3_VRDACM1",19,1)	,19,,,,.T.,,,,.T.)		//"Vlr.Dpr. Acum"
TRCell():New(oSecSaldo,"VLRBAIX"	,""	,STR0026 	,PesqPict("SN3","N3_VORIG1" ,19,1)	,19,,,,.T.,,,,.T.)    //"Vlr Baixa"
TRCell():New(oSecSaldo,"VLRRESID"	,""	,STR0015		,PesqPict("SN3","N3_VORIG1" ,19,1)	,19,,,,.T.,,,,.T.)		//"Vlr. Residual" 


oSecSaldo:Cell("VIDAUTIL"):SetHeaderAlign("RIGHT")
oSecSaldo:Cell("VLRORIG"):SetHeaderAlign("RIGHT")
oSecSaldo:Cell("VLRREAV"):SetHeaderAlign("RIGHT")
oSecSaldo:Cell("VLRDPRAC"):SetHeaderAlign("RIGHT")
oSecSaldo:Cell("VLRBAIX"):SetHeaderAlign("RIGHT")
oSecSaldo:Cell("VLRRESID"):SetHeaderAlign("RIGHT")
oSecSaldo:SetHeaderPage(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                   						TOTAIS				                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecTotal := TRSection():New(oReport,STR0016)//"Total "
TRCell():New(oSecTotal,"TOTAL",,,,,,,,.T.,,,,.T.)	
TRCell():New(oSecTotal,"TIPO"	,,,,,,,,.T.,,,,.T.)	
TRCell():New(oSecTotal,"FILIAL",,,,,,,,.T.,,,,.T.)		

oSecTotal:SetHeaderSection(.F.)
Return oReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR095PRCºAutor  ³Jair Ribeiro        º Data ³  02/27/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao dos dados                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport	 			                      º±±
±±º			 ³lAtf95Fil: Indica se todas filiais foram selecionadas       º±±
±±º			 ³aAtf95Fil: Array com filiais selecionadas                   º±±
±±º			 ³aAtf95Moe: Array com moedas selecionadas                    º±±   
±±º			 ³aClassif : Array com classificações selecionadas            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR095PRC(oReport,lAtf95Fil,aAtf95Fil,aAtf95Moe,aClassif)
Local cIndice	:= ""
Local cSeek		:= ""
Local cMoeda	:= ""
Local cEntid	:= ""
Local cBaixa	:= "3"
Local oSecAtivo	:= oReport:Section(1)
Local oSecSaldo := oReport:Section(1):Section(1)
Local oSecTotal	:= oReport:Section(2)

//Variaveis para funcao ATFGERSLDM
Local oMeter
Local oText
Local oDlg
Local lEnd
Local cAliasQry	:= Criatrab( , .F. )
Local dAquFim	:= MV_PAR01
Local dDataSLD	:= MV_PAR01
Local cBemIni	:= MV_PAR02
Local cBemFim   := MV_PAR03
Local cItemIni	:= MV_PAR04
Local cItemFim	:= MV_PAR05
Local cGrupoIni	:= MV_PAR06
Local cGrupoFim	:= MV_PAR07
Local aMoeda	:= aAtf95Moe
Local aSelFil	:= aAtf95Fil
Local lTodasFil	:= lAtf95Fil
Local cChave   	:= ""
Local aTipos   	:= {"01","02","05"} //Tipos de ativos
Local cArqAux                       // Arquivo gerado

//Variaveis para controle dos totalizadores
Local cWhereBem	:= ""
Local cTotalBem	:= ""
Local lTotalBase:= (MV_PAR09 == 1)
Local cTotalBase:= ""
Local cWhereBase:= ""
Local lTotalEnt	:= (MV_PAR10 == 1)
Local cTotalEnt	:= ""
Local cWhereEnt	:= ""
Local cTotalFil	:= ""
Local cWhereFil	:= ""
Local lTotalGer	:= .F.
Local lLine		:= .T.
Local cTabName	:= "" //Armazena o nome real da tabela para ser utilizada em query

Default aClassif := {}

While MsFile(cAliasQry)
	cAliasQry	:= Criatrab( , .F. )
EndDo

If MV_PAR10 != 1
	cChave 	:= "FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+MOEDA"
	cIndice	:= "FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ"
ElseIf MV_PAR11 == 1
	cChave 	:= "FILIAL+CONTA+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+MOEDA"
	cIndice	:= "FILIAL+CONTA+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ"
	cEntid	:= "CONTA"
ElseIf MV_PAR11 == 2
	cChave 	:= "FILIAL+CCUSTO+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+MOEDA"
	cIndice	:= "FILIAL+CCUSTO+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ"
	cEntid	:= "CCUSTO"
ElseIf MV_PAR11 == 3
	cChave 	:= "FILIAL+SUBCTA+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+MOEDA"
	cIndice	:= "FILIAL+SUBCTA+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ"
	cEntid	:= "SUBCTA"
ElseIf MV_PAR11 == 4
	cChave 	:= "FILIAL+CLVL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+MOEDA"
	cIndice	:= "FILIAL+CLVL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ"
	cEntid	:= "CLVL"
EndIf

If MV_PAR08 == 1
	cBaixa:= "1"
ElseIf MV_PAR08 == 2
	cBaixa:= "2"
EndIf

MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
ATFGERSLDM(oMeter,oText,oDlg,lEnd,cAliasQry,,dAquFim,dDataSLD,cBemIni,cBemFim,cItemIni,cItemFim,,,	,,,,,,;
cGrupoIni,cGrupoFim,aMoeda,aSelFil,lTodasFil,cChave,,aTipos,,cBaixa,,aClassif,,@cTabName)},;
STR0017 ,;//"Criando Arquivo Temporário..."
STR0018)//"Demonstrativo de Ativos Reavaliados"

(cAliasQry)->(dbGoTop())
While (cAliasQry)->(!EOF()) .And. !oReport:Cancel()
	If !Empty(cEntid)
		If Empty((cAliasQry)->&(cEntid))
			(cAliasQry)->(dbSkip())
			Loop
		EndIf
	EndIf
	
	//Valida apenas bens que possuam os tipos de reavaliação 01 ou 05
	If !(AFR095ValTp( cTabName, (cAliasQry)->FILIAL, (cAliasQry)->CBASE, (cAliasQry)->ITEM, (cAliasQry)->TIPO ))
		(cAliasQry)->(dbSkip())
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TOTAL POR BEM                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cTotalBem) .and. (cAliasQry)->(FILIAL+CBASE+ITEM) != cTotalBem
		ATFR095TOT(cTabName,cWhereBem,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0019+cTotalBem,cEntid)//"Por Bem: "
		lLine		:= .F.
		cTotalBem	:= ""
	EndIf
	If Empty(cTotalBem)
		cTotalBem	:=(cAliasQry)->(FILIAL+CBASE+ITEM)
		cWhereBem	:= " CBASE = '"+(cAliasQry)->(CBASE)+"' AND ITEM = '"+(cAliasQry)->(ITEM)+"' "
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TOTAL POR CODIGO BASE                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cTotalBase) .and. (cAliasQry)->(FILIAL+CBASE) != cTotalBase .and. lTotalBase
		ATFR095TOT(cTabName,cWhereBase,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0020+cTotalBase,cEntid)//"Por Codigo Base: "
		lLine		:= .F.
		cTotalBase	:= ""
	EndIf
	If Empty(cTotalBase)
		cTotalBase	:=(cAliasQry)->(FILIAL+CBASE)
		cWhereBase	:= " CBASE = '"+(cAliasQry)->(CBASE)+"' "
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TOTAL POR ENTIDADE CONTABIL                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lTotalEnt
		If !Empty(cTotalEnt) .and. (cAliasQry)->(FILIAL+&(cEntid)) != cTotalEnt
			ATFR095TOT(cTabName,cWhereEnt,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0021+cTotalEnt,cEntid)//"Por Entidade Contabil: "
			lLine		:= .F.
			cTotalEnt	:= ""
		EndIf
		If Empty(cTotalEnt)
			cTotalEnt	:=(cAliasQry)->(FILIAL+&(cEntid))
			cWhereEnt	:= cEntid+" = '"+(cAliasQry)->&(cEntid)+"' "
		EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³TOTAL POR FILIAL                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cTotalFil) .and. (cAliasQry)->(FILIAL) != cTotalFil
		ATFR095TOT(cTabName,cWhereFil,"",cIndice,oReport,.T.,cTotalFil,STR0022,cEntid)//"Por Filial"
		lLine		:= .F.
		cTotalFil	:= ""
		lTotalGer	:= .T.
	EndIf
	If Empty(cTotalFil)
		cTotalFil	:=(cAliasQry)->(FILIAL)
		cWhereFil	:= " FILIAL = '"+(cAliasQry)->(FILIAL)+"' "
	EndIf
	
	
	If !lLine
		oReport:ThinLine()
		lLine:=.T.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³IMPRESSAO DOS DADOS                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSeek	:=(cAliasQry)->&(cIndice)
	TRPosition():New(oSecAtivo,"SN1",1,{|| xFilial("SN1",(cAliasQry)->(FILIAL)) + (cAliasQry)->CBASE + (cAliasQry)->ITEM })
	oSecAtivo:Init()
	oSecAtivo:Cell("N1_FILIAL"):SetValue( (cAliasQry)->FILIAL)
	oSecAtivo:Cell("N1_CBASE"):SetValue( (cAliasQry)->CBASE)
	oSecAtivo:Cell("N1_ITEM"):SetValue( (cAliasQry)->ITEM)
	oSecAtivo:Cell("N1_DESCRIC"):SetValue( Iif((cAliasQry)->TIPO == "01",(cAliasQry)->DESC_SINT,""))
	oSecAtivo:Cell("N3_TIPO"):SetValue( (cAliasQry)->TIPO)
	oSecAtivo:Cell("DESCTIPO"):SetValue( GetAdvFVal("SX5","X5_DESCRI",xFilial("SX5")+"G1"+(cAliasQry)->TIPO))
	oSecAtivo:Cell("CLASTIPO"):SetValue( ATFxDTpBem((cAliasQry)->TIPO))
	oSecAtivo:Cell("N1_GRUPO"):SetValue( (cAliasQry)->GRUPO)
	oSecAtivo:Cell("N1_QUANTD"):SetValue( (cAliasQry)->QUANTD)
	oSecAtivo:Cell("TPDEPR"):SetValue( GetAdvFVal("SN0","N0_DESC01",xFilial("SN0")+"04"+GetAdvFVal("SN3","N3_TPDEPR",(cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ))))
	oSecAtivo:PrintLine()
	
	oSecSaldo:Init()
	cMoeda	:= SuperGetMV("MV_SIMB"+CValtoChar(Val((cAliasQry)->MOEDA)))
	TRPosition():New(oSecSaldo,"SN3",1, {|| xFilial("SN3",(cAliasQry)->FILIAL ) + (cAliasQry)->( CBASE + ITEM + TIPO + FLAGBAIXA + SEQ + SEQREAV)} )
	oSecSaldo:Cell("N3_CCONTAB"):SetValue( (cAliasQry)->CONTA)
	oSecSaldo:Cell("N3_CCUSTO"):SetValue( (cAliasQry)->CCUSTO)
	oSecSaldo:Cell("N3_SUBCTA"):SetValue( (cAliasQry)->SUBCTA)
	oSecSaldo:Cell("N3_CLVL"):SetValue( (cAliasQry)->CLVL)
	oSecSaldo:Cell("N3_AQUISIC"):SetValue( (cAliasQry)->AQUISIC)
	oSecSaldo:Cell("ATFBAIXA"):SetValue( ATFXBAIXA((cAliasQry)->( FILIAL + CBASE + ITEM + TIPO ), MV_PAR01, (cAliasQry)->SEQREAV )) 
	
	oSecSaldo:Cell("SIMBMOEDA"):SetValue(cMoeda)
	oSecSaldo:Cell("VIDAUTIL"):SetValue( ATFR095VUt((cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ),GetAdvFVal("SN3","N3_TXDEPR"+CValtoChar(Val((cAliasQry)->MOEDA)),(cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ))))
	oSecSaldo:Cell("VLRORIG"):SetValue( Iif((cAliasQry)->TIPO == "01", (cAliasQry)->ORIGINAL,0))
	oSecSaldo:Cell("VLRREAV"):SetValue( Iif((cAliasQry)->TIPO != "01", (cAliasQry)->ORIGINAL,0))
	oSecSaldo:Cell("VLRAMPL"):SetValue( (cAliasQry)->AMPLIACAO)
	oSecSaldo:Cell("VLRDPRAC"):SetValue( (cAliasQry)->DEPRECACM)
	oSecSaldo:Cell("VLRBAIX"):SetValue( (cAliasQry)->VLBAIXAS)
	oSecSaldo:Cell("VLRRESID"):SetValue( ((cAliasQry)->RESIDUAL))
	oSecSaldo:PrintLine()
	
	(cAliasQry)->(DbSkip())
	
	While cSeek ==(cAliasQry)->&(cIndice)
		cMoeda	:= SuperGetMV("MV_SIMB"+CValtoChar(Val((cAliasQry)->MOEDA)))
		
		oSecSaldo:Cell("N3_CCONTAB"):SetValue("")
		oSecSaldo:Cell("N3_CCUSTO"):SetValue( "")
		oSecSaldo:Cell("N3_SUBCTA"):SetValue( "")
		oSecSaldo:Cell("N3_CLVL"):SetValue( "")
		oSecSaldo:Cell("N3_AQUISIC"):SetValue( "")
		oSecSaldo:Cell("ATFBAIXA"):SetValue( "")
		oSecSaldo:Cell("SIMBMOEDA"):SetValue(cMoeda)
		oSecSaldo:Cell("VIDAUTIL"):SetValue( ATFR095VUt((cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ+SEQREAV),GetAdvFVal("SN3","N3_TXDEPR"+CValtoChar(Val((cAliasQry)->MOEDA)),(cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ))))
		oSecSaldo:Cell("VLRORIG"):SetValue( Iif((cAliasQry)->TIPO == "01", (cAliasQry)->ORIGINAL,0))
		oSecSaldo:Cell("VLRREAV"):SetValue( Iif((cAliasQry)->TIPO != "01", (cAliasQry)->ORIGINAL,0))
		oSecSaldo:Cell("VLRAMPL"):SetValue( (cAliasQry)->AMPLIACAO)
		oSecSaldo:Cell("VLRDPRAC"):SetValue( (cAliasQry)->DEPRECACM)
		oSecSaldo:Cell("VLRBAIX"):SetValue( (cAliasQry)->VLBAIXAS)
		oSecSaldo:Cell("VLRRESID"):SetValue( ((cAliasQry)->RESIDUAL))
		oSecSaldo:PrintLine()
		(cAliasQry)->(DbSkip())
	EndDo
	oSecSaldo:Finish()
	oSecAtivo:Finish()
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTAL POR BEM                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cTotalBem) .and. (cAliasQry)->(FILIAL+CBASE+ITEM) != cTotalBem
	ATFR095TOT(cTabName,cWhereBem,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0019+cTotalBem,cEntid)//"Por Bem: "
	lLine		:= .F.
	cTotalBem	:= ""
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTAL POR CODIGO BASE                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cTotalBase) .and. (cAliasQry)->(FILIAL+CBASE) != cTotalBase .and. lTotalBase
	ATFR095TOT(cTabName,cWhereBase,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0020+cTotalBase,cEntid)//"Por Codigo Base: "
	lLine		:= .F.
	cTotalBase	:= ""
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTAL POR ENTIDADE CONTABIL                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTotalEnt
	If !Empty(cTotalEnt) .and. (cAliasQry)->(FILIAL+&(cEntid)) != cTotalEnt
		ATFR095TOT(cTabName,cWhereEnt,cTotalFil,cIndice,oReport,lLine,cTotalFil,STR0021+cTotalEnt,cEntid)//"Por Entidade Contabil: "
		lLine		:= .F.
		cTotalEnt	:= ""
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTAL POR FILIAL                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cTotalFil) .and. (cAliasQry)->&(FILIAL) != cTotalFil
	ATFR095TOT(cTabName,cWhereFil,"",cIndice,oReport,.T.,cTotalFil,STR0022,cEntid)//"Por Filial"
	lLine		:= .F.
	cTotalFil	:= ""
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTAL GERAL		                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTotalGer
	ATFR095TOT(cTabName,"","",cIndice,oReport,.T.,"",STR0023,cEntid)//"Total Geral"
EndIf

If Select(cAliasQry) > 0
	dbSelectArea(cAliasQry)
	cArqAux := (cAliasQry)->(dbInfo(DBI_FULLPATH))
	cArqAux := AllTrim(Substr(cArqAux,RAT("\",cArqAux)+1))
	DbCloseArea()
	MsErase(cArqAux)
EndIf

Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR092TOTºAutor  ³Microsiga           º Data ³  03/02/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Impressao dos totais                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cAliasQry: Alias do Arquivo de trabalho                     º±±
±±º			 |cWhere: Condicao para filtro da query no arquivo            º±±
±±º			 ³cExpFil: Filial filtrada na query		                      º±±
±±º			 ³cIndice: Ordenacao na query				                  º±±
±±º			 ³oReport: Objeto TReport					                  º±±
±±º			 ³lLine: Indica se sera impressa linha				          º±±
±±º			 ³cTotalFil: Indentificacao da filial a ser impressa          º±±
±±º			 ³cTextoInd: Texto identificador do totalizador               º±±
±±º			 |cEntid: Tratamento para entidade 			                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR095TOT(cAliasQry,cWhere,cExpFil,cIndice,oReport,lLine,cTotalFil,cTextoInd,cEntid)
Local cQuery	:= ""
Local cOrder	:= IiF(!Empty(cIndice), STRTRAN(cIndice,"+",","), "FILIAL")
Local cAliasTot	:= "TOTALTRB"
Local aTotal	:= {}
Local aSubTotal	:= {}
Local nPostipo	:= 0
Local nPosMoeda	:= 0
Local cMoeda	:= ""
Local nlI		:= 0
Local nlX		:= 0
Local oSecSaldo := oReport:Section(1):Section(1)
Local oSecTotal	:= oReport:Section(2)     
Local aArea		:= GetArea()
Local aAreaSM0 := SM0->(GetArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³BUSCA NO ARQUIVO cAliasQry                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cExpFil)
	cExpFil := "AND FILIAL = '"+cExpFil+"' "
EndIf
If lLine
	oReport:ThinLine()
EndIf

cQuery:= "SELECT "
cQuery+= " FILIAL "
cQuery+= " ,CBASE "
cQuery+= " ,ITEM "
cQuery+= " ,TIPO "
cQuery+= " ,FLAGBAIXA "
cQuery+= " ,SEQ "
cQuery+= " ,MOEDA "
cQuery+= " ,ORIGINAL"
cQuery+= " ,AMPLIACAO "
cQuery+= " ,DEPRECACM "
cQuery+= " ,VLBAIXAS "
cQuery+= " ,RESIDUAL "

If !Empty(cEntid)
	cQuery+= ","+cEntid
EndIf
cQuery+= " FROM "+cAliasQry
If !Empty(cWhere)
	cQuery+= " WHERE "
	cQuery+= cWhere
	cQuery+= cExpFil
EndIf
cQuery+= " ORDER BY "+cOrder

cQuery := ChangeQuery(cQuery )
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTot,.T.,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³TOTALIZADOR		                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While (cAliasTot)->(!EOF())
	If !Empty(cEntid)
		If Empty((cAliasTot)->&(cEntid))
			(cAliasTot)->(dbSkip())
			Loop
		EndIf
	EndIf
	cMoeda	:= SuperGetMV("MV_SIMB"+CValtoChar(Val((cAliasTot)->MOEDA)))
	
	If(nPostipo := aScan(aTotal,{ |x| Alltrim(x[1]) == ALLTRIM(ATFxDTpBem((cAliasTot)->(TIPO)))})) == 0
		aAdd(aTotal,{ATFxDTpBem((cAliasTot)->TIPO),{}})
		nPostipo:= Len(aTotal)
		aAdd(aSubTotal,{"",0,0,0,0,0,0})
		nPosMoeda := Len(aSubTotal)
		
		If (cAliasTot)->TIPO != "05"
			aSubTotal[nPosMoeda,1]:= cMoeda
			aSubTotal[nPosMoeda,2]+= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aSubTotal[nPosMoeda,3]+= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aSubTotal[nPosMoeda,4]+= (cAliasTot)->AMPLIACAO
			aSubTotal[nPosMoeda,5]+= (cAliasTot)->DEPRECACM
			aSubTotal[nPosMoeda,6]+= (cAliasTot)->VLBAIXAS
			aSubTotal[nPosMoeda,7]+= (cAliasTot)->RESIDUAL
		Else
			aSubTotal[nPosMoeda,1]:= cMoeda
			aSubTotal[nPosMoeda,2]-= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aSubTotal[nPosMoeda,3]-= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aSubTotal[nPosMoeda,4]-= (cAliasTot)->AMPLIACAO
			aSubTotal[nPosMoeda,5]-= (cAliasTot)->DEPRECACM
			aSubTotal[nPosMoeda,6]-= (cAliasTot)->VLBAIXAS
			aSubTotal[nPosMoeda,7]-= (cAliasTot)->RESIDUAL
		EndIf
		aTotal[nPostipo,2]:= aSubTotal
		
	ElseIf(nPosMoeda := aScan(aTotal[nPostipo,2],{ |x| Alltrim(x[1]) == cMoeda})) == 0
		aAdd(aTotal[nPostipo,2],{"",0,0,0,0,0,0})
		nPosMoeda := Len(aTotal[nPostipo,2])
		If (cAliasTot)->TIPO != "05"
			aTotal[nPostipo,2,nPosMoeda,1]:= cMoeda
			aTotal[nPostipo,2,nPosMoeda,2]+= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,3]+= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,4]+= (cAliasTot)->AMPLIACAO
			aTotal[nPostipo,2,nPosMoeda,5]+= (cAliasTot)->DEPRECACM
			aTotal[nPostipo,2,nPosMoeda,6]+= (cAliasTot)->VLBAIXAS
			aTotal[nPostipo,2,nPosMoeda,7]+= (cAliasTot)->RESIDUAL
			
		Else
			aTotal[nPostipo,2,nPosMoeda,1]:= cMoeda
			aTotal[nPostipo,2,nPosMoeda,2]-= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,3]-= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,4]-= (cAliasTot)->AMPLIACAO
			aTotal[nPostipo,2,nPosMoeda,5]-= (cAliasTot)->DEPRECACM
			aTotal[nPostipo,2,nPosMoeda,6]-= (cAliasTot)->VLBAIXAS
			aTotal[nPostipo,2,nPosMoeda,7]-= (cAliasTot)->RESIDUAL
		EndIf
	Else
		If (cAliasTot)->TIPO != "05"
			aTotal[nPostipo,2,nPosMoeda,2]+= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,3]+= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,4]+= (cAliasTot)->AMPLIACAO
			aTotal[nPostipo,2,nPosMoeda,5]+= (cAliasTot)->DEPRECACM
			aTotal[nPostipo,2,nPosMoeda,6]+= (cAliasTot)->VLBAIXAS
			aTotal[nPostipo,2,nPosMoeda,7]+= (cAliasTot)->RESIDUAL
		Else
			aTotal[nPostipo,2,nPosMoeda,2]-= Iif((cAliasTot)->TIPO  == "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,3]-= Iif((cAliasTot)->TIPO  != "01", (cAliasTot)->ORIGINAL,0)
			aTotal[nPostipo,2,nPosMoeda,4]-= (cAliasTot)->AMPLIACAO
			aTotal[nPostipo,2,nPosMoeda,5]-= (cAliasTot)->DEPRECACM
			aTotal[nPostipo,2,nPosMoeda,6]-= (cAliasTot)->VLBAIXAS
			aTotal[nPostipo,2,nPosMoeda,7]-= (cAliasTot)->RESIDUAL
		EndIf
	EndIf
	(cAliasTot)->(DbSKip())
EndDo
(cAliasTot)->(dbCloseArea())

dbSelectArea("SM0")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³IMPRIME TOTAIS	                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSecTotal:Init()
oSecSaldo:Init()
For nlI := 1 To Len(aTotal)
	
	oSecTotal:Cell("TOTAL"):SetValue( "Total *** " +aTotal[nlI,1]+ " *** ")
	oSecTotal:Cell("TIPO"):SetValue( cTextoInd )
	oSecTotal:Cell("FILIAL"):SetValue( IiF(!Empty(cTotalFil), STR0024 +cTotalFil+ " - " + GetAdvFval("SM0","M0_FILIAL",cEmpAnt+cTotalFil,1,"" ) ,"" ) )  //"Filial: "
	oSecTotal:PrintLine()
	
	For nlX := 1 To Len(aTotal[nlI,2])
		oSecSaldo:Cell("N3_CCONTAB"):SetValue("")
		oSecSaldo:Cell("N3_CCUSTO"):SetValue( "")
		oSecSaldo:Cell("N3_SUBCTA"):SetValue( "")
		oSecSaldo:Cell("N3_CLVL"):SetValue( "")
		oSecSaldo:Cell("N3_AQUISIC"):SetValue( "")
		oSecSaldo:Cell("ATFBAIXA"):SetValue( "")
		oSecSaldo:Cell("SIMBMOEDA"):SetValue( aTotal[nlI,2,nlX,1])
		oSecSaldo:Cell("VIDAUTIL"):Hide()
		oSecSaldo:Cell("VLRORIG"):SetValue( aTotal[nlI,2,nlX,2])
		oSecSaldo:Cell("VLRREAV"):SetValue( aTotal[nlI,2,nlX,3])
		oSecSaldo:Cell("VLRAMPL"):SetValue( aTotal[nlI,2,nlX,4])
		oSecSaldo:Cell("VLRDPRAC"):SetValue( aTotal[nlI,2,nlX,5])
		oSecSaldo:Cell("VLRBAIX"):SetValue( aTotal[nlI,2,nlX,6])
		oSecSaldo:Cell("VLRRESID"):SetValue( aTotal[nlI,2,nlX,7])
		oSecSaldo:PrintLine()
	Next nlX
Next nlI

oSecSaldo:Cell("VIDAUTIL"):Show()
oSecTotal:Finish()
oSecSaldo:Finish()

RestArea(aAreaSM0)
RestArea(aArea)
Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR095VUtºAutor  ³Jair Ribeiro        º Data ³  02/27/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Posiciona arquivo para chamada da funcao ATFXVUTIL		  º±±
±±º          ³ retornando a vida util do bem	                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cChave:Chave de busca FILIAL+CBASE+ITEM+TIPO+FLAGBAIXA+SEQ  º±±
±±º			 |nTaxaMoed: Taxa da moeda							          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno	 ³nVidaUtil:Vida Util								          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR095VUt(cChave,nTaxaMoed)
Local aArea := SN3->(GetArea())
Local nVidaUtil	:= 0
SN3->(DbSetOrder(1))
If SN3->(DbSeek(cChave))
	nVidaUtil:= ATFXVUTIL(SN3->N3_TPDEPR,nTaxaMoed,SN3->N3_PERDEPR,SN3->N3_PRODANO,SN3->N3_PRODMES)
EndIf
RestArea(aArea)
Return nVidaUtil 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFR095ValTp   ºAutor  ³Microsiga           º Data ³  05/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se o bem pode ser impresso. Apenas tipos de reavaliaçãoº±±
±±º          ³ou tipo 01 fiscal com reavaliação podem ser impressos       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AFR095ValTp( cTabela, cFilBem, cCbase, cItem, cTipo )
Local aArea := GetArea()
Local aAreaSN3 := SN3->(GetArea())
Local lRet := .T.
Local cTabAux	:= Criatrab( , .F. )
Local cQuery := " "

SN3->(dbSetOrder(1))//N3_FILIAL+N3_CBASE+N3_ITEM+N3_TIPO+N3_BAIXA+N3_SEQ

If !(cTipo $ '02/05')
	cQuery += " SELECT CBASE " + CRLF
	cQuery += " FROM " + cTabela + CRLF
	cQuery += " WHERE " + CRLF
	cQuery += " FILIAL = '"+cFilBem+"' AND" + CRLF
	cQuery += " CBASE = '"+cCbase+"' AND" + CRLF
	cQuery += " ITEM = '"+cItem+"' AND" + CRLF
	cQuery += " TIPO IN ('02','05') " + CRLF
	cQuery := ChangeQuery(cQuery )
	dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cTabAux , .T. , .F.)
	
	If (cTabAux)->(EOF())
		lRet := .F.	
	EndIf

	(cTabAux)->(dbCloseArea())

EndIf

RestArea(aAreaSN3)
RestArea(aArea)
Return lRet