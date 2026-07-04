/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "GCPR002.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GCPR002 บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Quadro de Licita็๕es                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function GCPR002()

Local   oReport		:= nil
Private cTitulo		:= STR0001 //"Quadro de Licita็๕es"
Private cPerg		:= "GCR002"   
Private cAliasQry 	:= GetNextAlias()
Private cAliasQryLic 	:= GetNextAlias()

If TRepInUse()
	oReport:= ReportDef()
	oReport:PrintDialog()  // Imprime o Relat๓rio
Else
	Alert(STR0002)//"Este relat๓rio s๓ estแ disponํvel a partir da Release 4."
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDefบAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Carrega as defini็oes do relatorio                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport  	:= nil
Local oCO1 	   	:= nil
Local oCO2 	   	:= nil
Local oCO3 	   	:= nil
Local oCO1b 	   	:= nil
Local oCO2b 	   	:= nil
Local oCO3b 	   	:= nil
Local oCP3b		:= nil
Local cDesc		:= ""
Local oBreak		:= nil 
Local aOrdem		:= {STR0026,STR0027} // -- "Por Item","Por Lote"
Private nValTot 	:= 0

cDesc += STR0003 //"Este programa tem como objetivo imprimir a  "
cDesc += STR0004 //"listagem dos editais e os produtos "

DEFINE REPORT oReport NAME "GCPR002" TITLE cTitulo PARAMETER cPerg ACTION {|oReport|RepGCP(oReport)} DESCRIPTION cDesc 

		// Visใo - por Item
		DEFINE SECTION oCO1 			OF oReport TITLE STR0005 TABLES "CO1" ORDERS aOrdem//"Licita็ใo"
		DEFINE CELL NAME "CO1_CODEDT"  	OF oCO1 ALIAS "CO1"
		DEFINE CELL NAME "CO1_NUMPRO"   OF oCO1 ALIAS "CO1"
		DEFINE CELL NAME "CO1_DTABER" 	OF oCO1 ALIAS "CO1" 
		DEFINE CELL NAME "CO1_DTPUBL" 	OF oCO1 ALIAS "CO1"
		DEFINE CELL NAME "MODALIDADE"	OF oCO1 BLOCK {|| U_GCPR02MOD() } SIZE 25 TITLE STR0006 LINE BREAK AUTO SIZE  //"Modalidade"
		DEFINE CELL NAME "ETAPA"		OF oCO1 BLOCK {|| U_GCPR02ETP() } SIZE 25 TITLE STR0007 LINE BREAK AUTO SIZE  //"Etapa"
		
		DEFINE SECTION oCO2 OF oCO1 TITLE STR0008 TABLES "CO2","SB1" //"Produtos do Edital"
			DEFINE CELL NAME "CO2_ITEM" 		OF oCO2 ALIAS "CO2" LINE BREAK AUTO SIZE
			DEFINE CELL NAME "CO2_CODPRO" 		OF oCO2 ALIAS "CO2" LINE BREAK AUTO SIZE
			DEFINE CELL NAME "B1_DESC" 	   		OF oCO2 ALIAS "SB1" LINE BREAK AUTO SIZE
			DEFINE CELL NAME 'CO2_QUANT' 		OF oCO2 BLOCK {|| U_GCPR02TOT("2") } LINE BREAK AUTO SIZE
			
			DEFINE SECTION oCO3 OF oCO2 TITLE STR0009 TABLES "CO3" //"Fornecedores/Clientes"
				DEFINE CELL NAME 'TIPO' 			   	OF oCO3 BLOCK {|| U_GCPR02TIP() } SIZE 25 TITLE STR0010 LINE BREAK AUTO SIZE //"Tipo"
				DEFINE CELL NAME 'CO3_CODIGO' 			OF oCO3 ALIAS "CO3" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'CO3_LOJA' 	   		OF oCO3 ALIAS "CO3" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'A1_NOME' 	   	   		OF oCO3 BLOCK {|| U_GCPR02FOR() } SIZE TamSX3("A1_NOME")[1] TITLE STR0011 LINE BREAK AUTO SIZE //"Nome"
				DEFINE CELL NAME 'CO3_VLUNIT' 	   		OF oCO3 ALIAS "SB1" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'VALOR_TOTAL' 	   		OF oCO3 BLOCK {|| U_GCPR02TOT() }  TITLE STR0012 LINE BREAK AUTO SIZE PICTURE X3Picture("CO3_VLUNIT") //"Valor Total"
				DEFINE CELL NAME 'CLASSIFICACAO'   	OF oCO3 BLOCK {|| U_GCPR02LIC() } SIZE 15 TITLE STR0015 LINE BREAK AUTO SIZE // -- Classifica็ใo
				
				
		// Visใo - por Lote
		DEFINE SECTION oCO1b 			OF oReport TITLE STR0005 TABLES "CO1" ORDERS aOrdem//"Licita็ใo"
		DEFINE CELL NAME "CO1_CODEDT"  	OF oCO1b ALIAS "CO1"
		DEFINE CELL NAME "CO1_NUMPRO"   OF oCO1b ALIAS "CO1"
		DEFINE CELL NAME "CO1_DTABER" 	OF oCO1b ALIAS "CO1" 
		DEFINE CELL NAME "CO1_DTPUBL" 	OF oCO1b ALIAS "CO1"
		DEFINE CELL NAME "MODALIDADE"	OF oCO1b BLOCK {|| U_GCPR02MOD() } SIZE 25 TITLE STR0006 LINE BREAK AUTO SIZE  //"Modalidade"
		DEFINE CELL NAME "ETAPA"		OF oCO1b BLOCK {|| U_GCPR02ETP() } SIZE 25 TITLE STR0007 LINE BREAK AUTO SIZE  //"Etapa"
		
		DEFINE SECTION oCP3b OF oCO1b TITLE "Lotes" TABLES "CP3"
			DEFINE CELL NAME "CP3_LOTE" OF oCP3b ALIAS "CP3" LINE BREAK AUTO SIZE
			
			DEFINE SECTION oCO2b OF oCP3b TITLE STR0008 TABLES "CO2","SB1","CP6" //"Produtos do Edital"
				DEFINE CELL NAME "CO2_ITEM" 		OF oCO2b ALIAS "CO2" LINE BREAK AUTO SIZE
				DEFINE CELL NAME "CO2_CODPRO" 		OF oCO2b ALIAS "CO2" LINE BREAK AUTO SIZE
				DEFINE CELL NAME "B1_DESC" 	   		OF oCO2b ALIAS "SB1" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'CO2_QUANT' 		OF oCO2b BLOCK {|| U_GCPR02TOT("2") } LINE BREAK AUTO SIZE
			
			DEFINE SECTION oCO3b OF oCP3b TITLE STR0009 TABLES "CO3" //"Fornecedores/Clientes"
				DEFINE CELL NAME 'TIPO' 			   	OF oCO3b BLOCK {|| U_GCPR02TIP() } SIZE 25 TITLE STR0010 LINE BREAK AUTO SIZE //"Tipo"
				DEFINE CELL NAME 'CO3_CODIGO' 			OF oCO3b ALIAS "CO3" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'CO3_LOJA' 	   		OF oCO3b ALIAS "CO3" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'A1_NOME' 	   	   		OF oCO3b BLOCK {|| U_GCPR02FOR() } SIZE TamSX3("A1_NOME")[1] TITLE STR0011 LINE BREAK AUTO SIZE //"Nome"
				DEFINE CELL NAME 'CO3_VLUNIT' 	   		OF oCO3b ALIAS "SB1" LINE BREAK AUTO SIZE
				DEFINE CELL NAME 'VALOR_TOTAL' 	   		OF oCO3b BLOCK {|| nValTot }  TITLE STR0012 LINE BREAK AUTO SIZE PICTURE X3Picture("CO3_VLUNIT") //"Valor Total"
				DEFINE CELL NAME 'CLASSIFICACAO'   	OF oCO3b BLOCK {|| U_GCPR02LIC() } SIZE 15 TITLE STR0015 LINE BREAK AUTO SIZE // -- Classifica็ใo
		
			
		oCO1:SetAutoSize()
		oCO2:SetAutoSize()
		oCO3:SetAutoSize()		
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGCPR02ETP บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a etapa do Edital                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GCPR02ETP()
Local aArea := GetArea()
Local cRet	:= ""

dbSelectArea("SX5")
dbSetOrder(1)
If MsSeek(xFilial()+"LE"+(cAliasQry)->CO1_ETAPA)
	cRet := (cAliasQry)->CO1_ETAPA + " - " + AllTrim(X5Descri())
EndIf

RestArea( aArea )
Return cRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGCPR02MOD บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a modalidade do Edital                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GCPR02MOD()
Local aArea := GetArea()
Local cRet	:= ""

dbSelectArea("SX5")
dbSetOrder(1)
If MsSeek(xFilial()+"LF"+(cAliasQry)->CO1_MODALI)
	cRet := (cAliasQry)->CO1_MODALI + " - " + AllTrim(X5Descri())
EndIf

RestArea( aArea )
Return cRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGCPR02FOR บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o fornecedor do edital                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GCPR02FOR()
Local aArea := GetArea()
Local cRet	:= ""
Local cModCli := SuperGetMV("MV_GCPMCLI",,"LL\") 
Local lLote	:= IIf(!Empty((cAliasQry)->CO1_AVAL),((cAliasQry)->CO1_AVAL == "2"),.T.)

If lLote
	If !(Empty( (cAliasQryLic)->CO3_CODIGO ))
	    If (cAliasQryLic)->CO3_TIPO == "2" 
			If (cAliasQry)->CO1_MODALI $ cModCli
				cRet:= GetAdvFVal("SA1","A1_NOME",xFilial("SA1")+(cAliasQryLic)->(CO3_CODIGO+CO3_LOJA)	,1) 
		    Else
		    	cRet:= GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+(cAliasQryLic)->(CO3_CODIGO+CO3_LOJA)	,1)
		    EndIf
		 Else
		 	cRet:= GetAdvFVal("CO6",'CO6_NOME',xFilial("CO6")+(cAliasQryLic)->(CO3_CODIGO)	,1)
		 EndIf
	EndIf
Else
	If !(Empty( (cAliasQry)->CO3_CODIGO ))
	    If (cAliasQry)->CO3_TIPO == "2" 
			If (cAliasQry)->CO1_MODALI $ cModCli
				cRet:= GetAdvFVal("SA1","A1_NOME",xFilial("SA1")+(cAliasQry)->(CO3_CODIGO+CO3_LOJA)	,1) 
		    Else
		    	cRet:= GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+(cAliasQry)->(CO3_CODIGO+CO3_LOJA)	,1)
		    EndIf
		 Else
		 	cRet:= GetAdvFVal("CO6",'CO6_NOME',xFilial("CO6")+(cAliasQry)->(CO3_CODIGO)	,1)
		 EndIf
	EndIf
EndIf

RestArea( aArea )
Return cRet 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGCPR02TIP บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o tipo do fornecedor   		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GCPR02TIP()
Local aArea := GetArea()
Local cRet	:= ""
Local cModCli := SuperGetMV("MV_GCPMCLI",,"LL\") 
Local lLote	:= IIf(!Empty((cAliasQry)->CO1_AVAL),((cAliasQry)->CO1_AVAL == "2"),.T.)

If lLote
	If (cAliasQry)->CO1_MODALI $ cModCli
		cRet:= IIF ( (cAliasQryLic)->CO3_TIPO == '1' , STR0016,STR0017 )//"Pre-Cliente"##"Cliente"
	Else
	   	cRet:= IIF ( (cAliasQryLic)->CO3_TIPO == '1' , STR0018,STR0019 )//"Pre-Fornecedor"##"Fornecedor"
	EndIf	
Else
	If (cAliasQry)->CO1_MODALI $ cModCli
		cRet:= IIF ( (cAliasQry)->CO3_TIPO == '1' , STR0016,STR0017 )//"Pre-Cliente"##"Cliente"
	Else
	   	cRet:= IIF ( (cAliasQry)->CO3_TIPO == '1' , STR0018,STR0019 )//"Pre-Fornecedor"##"Fornecedor"
	EndIf	
EndIf

RestArea( aArea )
Return cRet 

//-------------------------------------------------------------------
/*{Protheus.doc} GCPR02TOT
Retorna totais conforme avaliacao do edital

@author Alex Egydio
@since 09/04/2013
@version P11.80
*/
//-------------------------------------------------------------------
User Function GCPR02TOT(cAcao)
Local nRet		:= 0
Local nQuant	:= (cAliasQry)->CO2_QUANT
Local aSldItem	:= {(cAliasQry)->CO1_CODEDT,(cAliasQry)->CO1_NUMPRO,(cAliasQry)->CO2_CODPRO}
Default cAcao := "1"

GCPSldItem("3",aSldItem)
//-- Se nao efetuou a entrega total, abate a quantidade ja entregue (CO2_QUANT - C7_QUJE)
//-- Se efetuou a entrega total devera permanecer com a quantidade original CO2_QUANT
If	aSldItem[1]<nQuant
	nQuant -= aSldItem[1]
EndIf

If	cAcao == "1"
	//-- Avaliacao por Item
	If	(cAliasQry)->CO1_AVAL$" 1"	
		nRet := (cAliasQry)->CO3_VLUNIT * nQuant
	//-- Avaliacao por lote ou edital
	Else
		nRet := (cAliasQry)->CO3_VLUNIT * nQuant
	EndIf
	
ElseIf cAcao == "2"
	nRet := nQuant
EndIf

	
Return(nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRepGCP  บAutor  ณ Totvs              บ Data ณ  01/04/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Carrega as defini็oes as informa็๕es do relatorio          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ GCP - Gestใo de Compras Publicas                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RepGCP(oReport)
Local oCO1 		:= oReport:Section(1)
Local oCO2 		:= oReport:Section(1):Section(1)
Local oCO3 		:= oReport:Section(1):Section(1):Section(1)
Local oCO1b 		:= oReport:Section(2)
Local oCP3b		:= oReport:Section(2):Section(1)
Local oCO2b		:= oReport:Section(2):Section(1):Section(1)
Local oCO3b 		:= oReport:Section(2):Section(1):Section(2)
Local nOpc 		:= oCO1:GetOrder()
Local cCod			:= ""
Local cNum			:= ""
Local cLote		:= ""
Local nQtde	:= 0

MakeSqlExp("GCPR002")

Pergunte(cPerg,.F.)

If nOpc = 1	//Visใo - por Item

	BEGIN REPORT QUERY oCO1
	
	BeginSql alias cAliasQry
	
	SELECT 
		CO1_CODEDT,
		CO1_NUMPRO,
		CO1_ETAPA,
		CO1_MODALI,
		CO1_AVAL,
		CO2_CODEDT,
		CO2_NUMPRO,
		CO2_ITEM,
		CO2_CODPRO,
		CO2_QUANT,
		CO2_LOTE,
		CO3_CODEDT,
		CO3_NUMPRO,
		CO3_CODPRO,
		CO3_CODIGO,
		CO3_LOJA,
		CO3_VLUNIT,
		CO3_TIPO,
		CO3_STATUS		
	FROM 
		%table:CO1% CO1 
	INNER JOIN %table:CO2% CO2 ON
		CO1_CODEDT 	= CO2_CODEDT AND 
		CO1_NUMPRO	= CO2_NUMPRO AND
		CO1_FILIAL   = %xfilial:CO1% AND
		CO2_FILIAL   = %xfilial:CO2% AND
		CO1.%NotDel% AND
		CO2.%NotDel%
	LEFT JOIN %table:CO3% CO3 ON
		CO2_CODEDT 	= CO3_CODEDT AND 
		CO2_NUMPRO	= CO3_NUMPRO AND
		CO2_CODPRO 	= CO3_CODPRO AND
		CO3_FILIAL	= %xfilial:CO3% AND
		CO3_REVOGA <> '1' AND
		CO3.%NotDel%
	WHERE 
		CO1_AVAL    = '1' AND
		CO1_CODEDT >= %EXP:MV_PAR01%	AND
		CO1_NUMPRO >= %EXP:MV_PAR02%	AND
		CO1_CODEDT <= %EXP:MV_PAR03%	AND
		CO1_NUMPRO <= %EXP:MV_PAR04%	AND
		CO1_DTABER >= %EXP:MV_PAR05%	AND
		CO1_DTABER <= %EXP:MV_PAR06%
							
	ORDER BY CO1_CODEDT, CO1_NUMPRO
	
	EndSql
	
	END REPORT QUERY oCO1
	
	oCO2:SetParentQuery()
	oCO2:SetParentFilter({|cParam| (cAliasQry)->(CO2_CODEDT + CO2_NUMPRO) == cParam},{|| (cAliasQry)->(CO1_CODEDT + CO1_NUMPRO)})
	oCO3:SetParentQuery()
	oCO3:SetParentFilter({|cParam| (cAliasQry)->(CO3_CODEDT + CO3_NUMPRO + CO3_CODPRO) == cParam},{|| (cAliasQry)->(CO2_CODEDT + CO2_NUMPRO + CO2_CODPRO)})
	
	TRPosition():New(oCO2, "SB1", 1, {|| xFilial("SB1") + (cAliasQry)->CO2_CODPRO }) //B1_FILIAL+B1_COD
	
	oCO1:Print()
	 
Else // Visใo - por lote

	BEGIN REPORT QUERY oCO1b
	
	BeginSql alias cAliasQry
		
		SELECT CO1_CODEDT,
		       CO1_NUMPRO,
		       CO1_ETAPA,
		       CO1_MODALI,
		       CO1_AVAL,
		       CO2_CODEDT,
		       CO2_NUMPRO,
		       CO2_CODPRO,
		       CO2_ITEM,
		       CO2_QUANT,
		       CO2_LOTE,
		       CP3_LOTE,
		       CP3_CODEDT,
		       CP3_NUMPRO,
       		B1_DESC
		FROM %table:CO1% CO1 
		INNER JOIN %table:CO2% CO2 ON CO1_CODEDT = CO2_CODEDT
		AND CO1_NUMPRO = CO2_NUMPRO
		AND CO1_FILIAL = %xfilial:CO1%
		AND CO2_FILIAL = %xfilial:CO2%
		AND CO1.%NotDel%
		AND CO2.%NotDel%
		INNER JOIN %table:SB1% SB1 ON B1_COD = CO2_CODPRO
		LEFT JOIN %table:CP6% CP6 ON CP6_CODEDT = CO2_CODEDT
		AND CP6_NUMPRO = CO2_NUMPRO
		AND CP6_LOTE = CO2_LOTE
		AND CP6_LOTE = CO2_CODPRO
		AND CP6_FILIAL = %xfilial:CP6%
		AND CP6.%NotDel%
		LEFT JOIN %table:CP3% CP3 ON CP3.CP3_FILIAL = %xfilial:CP3%
		AND CO2.CO2_CODEDT = CP3.CP3_CODEDT
		AND CO2.CO2_NUMPRO = CP3.CP3_NUMPRO
		AND CO2.CO2_REVISA = CP3.CP3_REVISA
		AND CO2.CO2_LOTE = CP3.CP3_LOTE
		AND CP3.%NotDel%
		WHERE CO1_AVAL = '2' AND
			CO1_CODEDT >= %EXP:MV_PAR01%	AND
			CO1_NUMPRO >= %EXP:MV_PAR02%	AND
			CO1_CODEDT <= %EXP:MV_PAR03%	AND
			CO1_NUMPRO <= %EXP:MV_PAR04%	AND
			CO1_DTABER >= %EXP:MV_PAR05%	AND
			CO1_DTABER <= %EXP:MV_PAR06%
		ORDER BY CO1_CODEDT,
		         CO1_NUMPRO,
		         CP3_LOTE,
		         CO2_CODPRO
	
	EndSql
	
	END REPORT QUERY oCO1b

	
	BEGIN REPORT QUERY oCO3b
	
	BeginSql alias cAliasQryLic
	
		SELECT CO1_CODEDT,
	       CO1_NUMPRO,       
	       CO1_AVAL,
	       CO3_CODEDT,
	       CO3_NUMPRO,
	       CO3_CODIGO,
	       CO3_LOJA,
	       CO3_VLUNIT,
	       CO3_TIPO,
	       CO3_STATUS,
	       CO3_LOTE,
	       CP3_LOTE,
	       CP3_CODEDT,
	       CP3_NUMPRO
	       //(CO3_VLUNIT * CO2_QUANT) VALOR_TOTAL
		FROM %table:CO3% CO3 
		LEFT JOIN %table:CP3% CP3 ON CP3.CP3_FILIAL = %xfilial:CO3%
			AND CO3.CO3_CODEDT = CP3.CP3_CODEDT
			AND CO3.CO3_NUMPRO = CP3.CP3_NUMPRO
			AND CO3.CO3_REVISA = CP3.CP3_REVISA
			AND CO3.CO3_LOTE = CP3.CP3_LOTE
			AND CO3.%NotDel%	
		LEFT JOIN %table:CO1% CO1 ON CO1.CO1_CODEDT = CO3_CODEDT
			AND CO1.CO1_NUMPRO = CO3_NUMPRO
			AND CO1.CO1_FILIAL = %xfilial:CO1% 
			AND CO1.%NotDel%			
		WHERE CO1_AVAL = '2' AND
			CO1_CODEDT >= %EXP:MV_PAR01%	AND
			CO1_NUMPRO >= %EXP:MV_PAR02%	AND
			CO1_CODEDT <= %EXP:MV_PAR03%	AND
			CO1_NUMPRO <= %EXP:MV_PAR04%	AND
			CO1_DTABER >= %EXP:MV_PAR05%	AND
			CO1_DTABER <= %EXP:MV_PAR06%
		ORDER BY CO1_CODEDT,
		         CO1_NUMPRO,
		         CP3_LOTE,
		         CO3_CODIGO,
	         	  CO3_LOJA
		
		EndSql
	
	END REPORT QUERY oCO3b
	
	oCP3b:SetParentQuery()
		
	oCO2b:SetParentQuery()
		
	While !(cAliasQry)->(Eof())
		oCO1b:Init()	
		oCO1b:PrintLine()
		cCod	:= (cAliasQry)->CO1_CODEDT
		cNum	:= (cAliasQry)->CO1_NUMPRO
		
		While !(cAliasQry)->(Eof()).AND. cCod+cNum == (cAliasQry)->(CO1_CODEDT+CO1_NUMPRO)
			oCP3b:Init()
			oCP3b:PrintLine()
			cLote	:= (cAliasQry)->CP3_LOTE
			oCO2b:Init()
			nQtde := 0
			While  !(cAliasQry)->(Eof()).AND. cLote	== (cAliasQry)->CO2_LOTE
				nQtde += (cAliasQry)->CO2_QUANT
				oCO2b:PrintLine()
				(cAliasQry)->(dbSkip())
			EndDo
			oCO2b:Finish()
			oCO3b:Init()
			nValTot := 0
			While  !(cAliasQryLic)->(Eof()).AND. (cAliasQryLic)->CO3_LOTE == cLote
				nValTot := (cAliasQryLic)->CO3_VLUNIT * nQtde
				oCO3b:PrintLine()
				(cAliasQryLic)->(dbSkip())
			EndDo						
			oCO3b:Finish()			
			oCP3b:Finish()
		EndDo			
		oCO1b:Finish()
		
	EndDo		
	(cAliasQry)->(DbCloseArea())
	(cAliasQryLic)->(DbCloseArea())

EndIf
	
Return

//-------------------------------------------------------------------
/*{Protheus.doc} GCPR02LIC
Retorna o status do licitante

@author antenor.silva
@since 26/08/2016
@version P12
*/
//-------------------------------------------------------------------
User Function GCPR02LIC()
Local aArea := GetArea()
Local cRet	:= ""
//Local lLote	:= ((cAliasQry)->CO1_AVAL == "2")
Local lLote	:= IIf(!Empty((cAliasQry)->CO1_AVAL),((cAliasQry)->CO1_AVAL == "2"),.T.)

If lLote
	Do Case	
		Case (cAliasQryLic)->CO3_STATUS == '1'
			cRet := STR0020 //'Habilitado'	
		Case (cAliasQryLic)->CO3_STATUS == '2'
			cRet := STR0021 //'Revogado'	
		Case (cAliasQryLic)->CO3_STATUS == '3'
			cRet := STR0022 //'Anulado'	
		Case (cAliasQryLic)->CO3_STATUS == '4'
			cRet := STR0023 //'Remanescente'	
		Case (cAliasQryLic)->CO3_STATUS == '5'
			cRet := STR0024 //'Ganhador'	
		Case (cAliasQryLic)->CO3_STATUS == '6'
			cRet := STR0025 //'Inabilitado'
	EndCase
Else
	Do Case	
		Case (cAliasQry)->CO3_STATUS == '1'
			cRet := STR0020 //'Habilitado'	
		Case (cAliasQry)->CO3_STATUS == '2'
			cRet := STR0021 //'Revogado'	
		Case (cAliasQry)->CO3_STATUS == '3'
			cRet := STR0022 //'Anulado'	
		Case (cAliasQry)->CO3_STATUS == '4'
			cRet := STR0023 //'Remanescente'	
		Case (cAliasQry)->CO3_STATUS == '5'
			cRet := STR0024 //'Ganhador'	
		Case (cAliasQry)->CO3_STATUS == '6'
			cRet := STR0025 //'Inabilitado'
	EndCase	
EndIf

RestArea( aArea )
Return cRet