/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR070.CH"
#INCLUDE "PROTHEUS.CH"

// 09/09/2011 - Alterado tradução das colunas de Debito e Credito para Pais Mexico
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ Ctbr070	³ Autor ³ Pilar S Albaladejo	³ Data ³ 12.09.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Conferencia de Digitacao               	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctbr070()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Generico      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbR070()     

PRIVATE titulo		:= "" 
PRIVATE nomeprog	:= "CTBR070"
PRIVATE aSelFil		:= {} 
PRIVATE cPerg		:= "CTR070" 
PRIVATE cMVFil		:= IIF(cPaisLoc == "CHI","MV_PAR25","MV_PAR23")		       
PRIVATE cPaisLoc	:= GetMv("MV_PAISLOC")

	U_CTBR070R4()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR070R4 ³ Autor³ Daniel Sakavicius		³ Data ³ 19/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Conferencia de Digitacao - R4           	 				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ CTBR070R4												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR070R4()         
                   
Local lGetFil	:= .F.
Local aArea 	:= GetArea()
Local aFilPE 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
Pergunte( CPERG, .T. )

If IsBlind() .And. ExistBlock("CTR70FIL")
	aFilPE := ExecBlock("CTR70FIL",.F.,.F.)

	If Len(aFilPE) <= 0
		Return
	EndIf

	aSelFil := aClone(aFilPE)
EndIf

If &(cMVFil) == 1 .And. Len( aSelFil ) <= 0
	aSelFil := AdmGetFil()
	If Len( aSelFil ) <= 0
		Return
	EndIf
EndIf 

oReport := ReportDef()      

IF ValType( oReport ) == "O"
	oReport :PrintDialog()      
ENDIF
        
RestArea(aArea) 
Return                                

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Daniel Sakavicius		³ Data ³ 20/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo relatorio.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGACTB                                    				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef() 
Local oReport
local aArea	   		:= GetArea()   
Local cReport		:= "CTBR070"
Local cTitulo		:= STR0004				   			// "Conferencia de Digitacao - Modelo 1"
Local cDesc			:= STR0001+STR0002+STR0003	  		// "Este programa ira imprimir o Relatorio para Conferencia"
Local cDifDC  		:= ""			  
Local cDifIF		:= ""
Local cDiger		:= ""
Local cCredito		:= ""
Local cDebito		:= ""                    
Local aTamConta		:= TAMSX3("CT1_CONTA")
Local cSayItem		:= STR0062
Local cSayCC		:= STR0061
Local cSayCV		:= STR0063
Local aTamCusto     := TAMSX3("CTT_CUSTO")		
Local aTamITEM      := TAMSX3("CTD_ITEM")
Local aTamClvl      := TAMSX3("CTH_CLVL")
Local lTot123 		:= If( cPaisLoc = "CHI", mv_par24 == 1, mv_par22 == 1)
Local nX
Local lUseDocHis  := X3USADO("CTC_DOCHIS")

PRIVATE cPerg		:= "CTR070"		   
Private cPictVal  	:= PesqPict("CT2","CT2_VALOR")					

IF MV_PAR09 != 1
	aTamCusto[1] := 0
ENDIF
IF MV_PAR10 != 1 
	aTamITEM[1]  := 0
ENDIF
IF MV_PAR14 != 1 
	aTamClvl[1]  := 0
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//"Este programa tem o objetivo de emitir o Cadastro de Itens Classe de Valor "
//"Sera impresso de acordo com os parametros solicitados pelo"
//"usuario"                                
oReport	:= TReport():New( cReport,cTitulo,cPerg, { |oReport| ReportPrint( oReport ) }, cDesc ) 
oReport:SetLandScape(.T.)
oReport:ParamReadOnly()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection0  := TRSection():New( oReport, STR0032, {"CTC"},, .F., .F. )	//"Resumido"  

TRCell():New( oSection0, "CTC_DATA"  , "CTC",STR0036/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  //DATA
TRCell():New( oSection0, "CTC_LOTE"  , "CTC",STR0037/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  //LOTE
TRCell():New( oSection0, "CTC_SBLOTE", "CTC",STR0038/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  //SUB LOTE
TRCell():New( oSection0, "CTC_DOC"   , "CTC",STR0039/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)   //DOCUMENTO   

TRCell():New( oSection0, "CTC_INF"   , "CTC",STR0040+" "+STR0041/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)   //TOTAL INFORMADO
TRCell():New( oSection0, "CTC_DEBITO", "CTC",STR0042/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")  //VALOR A DEBITO
TRCell():New( oSection0, "CTC_CREDIT", "CTC",STR0043/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")  //VALOR A CREDITO
TRCell():New( oSection0, "CDIFDC"    ,,STR0044,cPictVal/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")  //DIFERENCA

If lTot123 
	TRCell():New( oSection0, "TXTDIF"    ,,"  "/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"LEFT",,"LEFT")
Endif
TRCell():New( oSection0, "CTC_DIG"   , "CTC",STR0040+" "+STR0045/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)  //TOTAL DIGITADO
TRCell():New( oSection0, "CDIFIF"    ,,STR0046,cPictVal/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")  //"DIFERENCA INF/DIG"

If lUseDocHis
	TRCell():New( oSection0, "CTC_DOCHIS", "CTC",STR0058/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)   // HIST.DOCUMENTO
Endif

oSection1  := TRSection():New( oReport, STR0033, {"CT2"},, .F., .F. )	//"Completo"

TRCell():New( oSection1, "CT2_DATA"  , "CT2",STR0012/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "CT2_LOTE"  , "CT2",STR0013/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "CT2_SBLOTE", "CT2",STR0017/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection1, "CT2_DOC"   , "CT2",STR0014/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)

If lUseDocHis
	TRCell():New( oSection1, "CTC_DOCHIS", "CTC",STR0058/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)   // HIST.DOCUMENTO
Endif
oSection11  := TRSection():New( oSection1, STR0034, {"CT2"},, .F., .F. )	//"Lancamentos Contabeis"

TRCell():New( oSection11, "CT2_LINHA" 	, "CT2",STR0047/*Titulo*/,/*Picture*/,3/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection11, "CT2_DC"    	, "CT2",STR0048/*Titulo*/,/*Picture*/,4/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection11, "CCONTAD"		, ,STR0059/*Titulo*/,/*Picture*/,aTamConta[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	
TRCell():New( oSection11, "CCONTAC"		, ,STR0060/*Titulo*/,/*Picture*/,aTamConta[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")		
TRCell():New( oSection11, "CCUSTOD" 	, ,cSayCC+""+STR0010/*Titulo*/,/*Picture*/,aTamCusto[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CCUSTOC" 	, ,cSayCC+""+STR0011/*Titulo*/,/*Picture*/,aTamCusto[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CITEMD" 		, ,cSayItem+""+STR0010/*Titulo*/,/*Picture*/,aTamItem[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CITEMC" 		, ,cSayItem+""+STR0011/*Titulo*/,/*Picture*/,aTamItem[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CCLASSED"	, ,cSayCV+""+STR0010/*Titulo*/,/*Picture*/,aTamClvl[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CCLASSEC"	, ,cSayCV+""+STR0011/*Titulo*/,/*Picture*/,aTamClvl[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CDEBITO" 	, ,STR0050+" "+STR0010,cPictVal/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CCREDITO" 	, ,STR0050+" "+STR0011,cPictVal/*Picture*/,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")
TRCell():New( oSection11, "CT2_HP" 		, ,STR0051,/*Picture*/,TamSx3("CT2_HP")[1]/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)
TRCell():New( oSection11, "CT2_HIST"  	, "CT2",STR0052/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*CodeBlock*/, , .T.)
oSection11:SetHeaderPage(.T.)

oSection11:Cell("CT2_LINHA"):lHeaderSize := .F.

If mv_par17 == 1
	oSection1:Disable()
	oSection11:Disable()
Else
	oSection0:Disable()
Endif

If mv_par09 != 1 
	oSection11:Cell("CCUSTOD"):Disable()
	oSection11:Cell("CCUSTOC"):Disable()
Endif	

If mv_par10 != 1 
	oSection11:Cell("CITEMD"):Disable()
	oSection11:Cell("CITEMC"):Disable()
Endif	

If mv_par14 != 1 
	oSection11:Cell("CCLASSED"):Disable() 
	oSection11:Cell("CCLASSEC"):Disable() 
Endif	

nTamDescTot := 0
For nX := 1 TO 10 //ate a coluna valor de debito
	If oSection11:Cell(nX):lEnabled
		nTamDescTot += oSection11:Cell(nX):GetSize()+1
	EndIf
Next	

oSection2  := TRSection():New( oReport, STR0035,,, .F., .F. )	//"Totais"

TRCell():New( oSection2, "TOT_DESCRI" ,,,,nTamDescTot-1/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)	//Total Debito
TRCell():New( oSection2, "TOT_DEBITO" ,,OemToAnsi(STR0010),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//Total Debito
TRCell():New( oSection2, "TOT_CREDITO",,OemToAnsi(STR0011),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//Total Credito

If cPaisLoc = "CHI"
	If mv_par24 == 1
		TRCell():New( oSection2, "TOT_INF"    ,,OemToAnsi(STR0025),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Total Informado"
		TRCell():New( oSection2, "TOT_DIG"    ,,OemToAnsi(STR0026),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Total "
		TRCell():New( oSection2, "TOT_DIFINF" ,,OemToAnsi(STR0027),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Diferenca:"
	Endif         
Else
	If mv_par22 == 1
		TRCell():New( oSection2, "TOT_INF"    ,,OemToAnsi(STR0025),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Total Informado"
		TRCell():New( oSection2, "TOT_DIG"    ,,OemToAnsi(STR0026),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Total "
		TRCell():New( oSection2, "TOT_DIFINF" ,,OemToAnsi(STR0027),,18/*Tamanho*/,/*lPixel*/,/*CodeBlock*/,"RIGHT",,"RIGHT")	//"Diferenca:"
	Endif                         
Endif

oSection2:Cell("TOT_DESCRI"):HideHeader()
oSection2:Cell("TOT_DEBITO"):HideHeader()
oSection2:Cell("TOT_CREDITO"):HideHeader()

If mv_par17 == 1
	oSection2:Disable()
EndIf

If lTot123
	If oReport:GetOrientation() == 1 //PORTRAIT
		Aviso(STR0053, STR0054, {"Ok"})    //"Atencao"##"A impressão do relatório será alterada para paisagem ! "
		oReport:SetLandScape(.T.)
	EndIf	
Else
	If oReport:GetOrientation() == 2  //LANDSCAPE
		If Aviso(STR0053, STR0055, {STR0056, STR0057},) == 1   //"Atencao"##"Alterar impressão do relatório para retrato ?"##"Sim" ##"Nao"
			oReport:SetPortrait(.T.)
		EndIf	
	EndIf
EndIf	

oreport:DisableOrientation()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Daniel Sakavicius	³ Data ³ 20/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint(oReport)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )

Local oSection0 	:= oReport:Section(1)
Local oSection1 	:= oReport:Section(2)
Local oSection11 	:= oReport:Section(2):Section(1)
Local oSection2 	:= oReport:Section(3)
Local lTotal		:= (mv_par13 == 1)
Local lTot123 		:= If( cPaisLoc = "CHI", mv_par24 == 1, mv_par22 == 1)
Local lResumo		:= (mv_par17 == 1)
Local cMoeda		:= mv_par07 
Local cQuery		:= "CT2"
Local n				:= 0
Local cLote			:= ""
Local cSubLote		:= ""
Local cDoc      	:= ""
Local cLoteRes      := ""
Local cSubRes		:= ""
Local cDocRes    	:= ""
Local nTotalDeb	 	:= 0
Local nTotalCrd	 	:= 0
Local nTotLotDeb	:= 0
Local nTotLotCrd 	:= 0
Local nTotGerDeb 	:= 0
Local nTotGerCrd 	:= 0
Local nTotGerInf 	:= 0
Local nTotGerDig 	:= 0
Local nDifInf	 	:= 0
Local nDifDBCR		:= 0
Local cDebit	 	:= "1"
Local cCredit	 	:= "2"
Local cPdobr	 	:= "3"  
Local nStr		 	:= 0
Local cFilUser	 	:= ".T."
Local lAllSL		:= If(Empty(mv_par11) .or. mv_par11=="*",.T.,.F.)
Local nReccount		:= 0
Local nLotInf		:= 0
Local nLotDig 		:= 0
local nDocInf   	:= 0
Local nDocDig   	:= 0
Local lUseDocHis  := X3USADO("CTC_DOCHIS")
LOCAL cCtaResD		:= ""
LOCAL cCtaResC		:= ""
Local nK			:= 0
Local cFil			:= ""        
Local cFilIni		:= cFilAnt 
Local cFilTit		:= ""
Local cTmpCT2Fil
Local lGestao 		:= ( Len(CT2->CT2_FILIAL) > 2 )
Local dDataFim        := mv_par02

cQuery	:= If(lResumo, "CTC", "CT2")

lCusto := ( mv_par09 == 1 )
lItem := ( mv_par10 == 1 )
lCV := ( mv_par14 == 1 )

aCtbMoeda  	:= CtbMoeda(mv_par07)
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Set Filter To
	Return
Endif

cDescMoeda 	:= Alltrim(aCtbMoeda[2])

If lResumo // se imprimir no modo resumido
	aEval(aSelFil, {|e,nX| cFilTit += e + If(nX<Len(aSelFil),If(nX+1 == Len(aSelFil)," e ",", "),"") } ) 
	Titulo := STR0004+STR0022+cDescMoeda+If(Len(aSelFil)>1," - Filiais: "," - Filial: ")+cFilTit                                                                                                           
	oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport)} )  

	// Filtro do relatorio resumido 
	If ! lGestao
		cFil :=xFilial("CTC")
		If !Empty(cFil)
			If MV_PAR23== 1
				aEval(aSelFil, {|e,nX| cFil += e + If(nX<Len(aSelFil),"/","") } )
		   	EndIf
		EndIf 
	Else
		If Len(aSelFil) > 50
			MsgInfo(STR0064)  //"Para relatorio resumido as filiais selecionadas deve ser inferior a 50."
			Return
		Else
			cFil := GetRngFil( aSelFil, "CTC" )
			cFil := StrTran(cFil, "= ", "")
			cFil := StrTran(cFil, "IN", "")
			cFil := StrTran(cFil, "(", "")
			cFil := StrTran(cFil, ")", "")
			cFil := StrTran(cFil, "','", "|")
			cFil := StrTran(cFil, "'", "")
		EndIf
	EndIf
		
 	cFilter := "CTC->CTC_FILIAL $ '"+cFil+"' .and. "
	cFilter += "DTOS(CTC->CTC_DATA) >=  '"+DTOS(mv_par01)+"' .and. "
	cFilter += "DTOS(CTC->CTC_DATA) <=  '"+DTOS(mv_par02)+"' .and. "
	cFilter += "CTC->CTC_LOTE >= '"+mv_par03+"' .and. "
	cFilter += "CTC->CTC_LOTE <= '"+mv_par04+"' .and. "
	cFilter += "CTC->CTC_SBLOTE >= '"+mv_par15+"' .and. "
	cFilter += "CTC->CTC_SBLOTE <= '"+mv_par16+"' .and. "
	cFilter += "CTC->CTC_DOC >= '"+mv_par05+"' .and. "
	cFilter += "CTC->CTC_DOC <= '"+mv_par06+"' .and. "
	cFilter += "CTC->CTC_MOEDA  =  '"+mv_par07+"' .and. "   
	IF !lAllSL
		cFilter += "CTC->CTC_TPSALD = '" +MV_PAR11+"' .and."
	ENDIF
	cFilter += "CTC->CTC_CREDIT + CTC->CTC_DEBITO + CTC->CTC_DIG +  CTC->CTC_INF <> 0 "

	CTC->(DbSetOrder(1))
	CTC->(DbGotop())
		
	oSection0:SetFilter( cFilter )

	If mv_par12 == 1 //Lote
		oBreak2 := TRBreak():New( oSection0, {|| CTC->(Dtos(CTC_DATA)+CTC_LOTE) } )
		oBreak2:SetPageBreak(.T.)

	ElseIf mv_par12 == 2 //Documento
		oBreak2 := TRBreak():New( oSection0, {|| CTC->(Dtos(CTC_DATA)+CTC_LOTE+CTC_SBLOTE+CTC_DOC) } )
		oBreak2:SetPageBreak(.T.)

	Endif
  
	If lTotal
		oBreak1 := TRBreak():New( oSection0, {|| CTC->(eof()) }, STR0019 )
		
		TRFunction():New(oSection0:Cell("CTC_INF"	 ), ,"SUM",oBreak1/*oBreak*/ ,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
		TRFunction():New(oSection0:Cell("CTC_DEBITO"), ,"SUM",oBreak1/*oBreak */,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
		TRFunction():New(oSection0:Cell("CTC_CREDIT"), ,"SUM",oBreak1/*oBreak*/ ,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
		TRFunction():New(oSection0:Cell("CDIFDC"	 ), ,"SUM",oBreak1/*oBreak*/ ,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
		TRFunction():New(oSection0:Cell("CTC_DIG"	 ), ,"SUM",oBreak1/*oBreak*/ ,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
		TRFunction():New(oSection0:Cell("CDIFIF"	 ), ,"SUM",oBreak1/*oBreak*/ ,STR0019,/*[ cPicture ]*/,/*[ uFormula ]*/,.F.,.F.,)
	Endif
	
	If lTot123
		oSection0:Cell("TXTDIF"):SetBlock( { || nDifDBCR := CTC->CTC_DEBITO - CTC->CTC_CREDIT,If(nDifDBCR > 0,STR0023,If(nDifDBCR < 0,STR0024," "))} )
	Endif
  	oSection0:Cell("CDIFDC"):SetBlock( { || CTC->CTC_CREDIT - CTC->CTC_DEBITO } )
	oSection0:Cell("CDIFIF"):SetBlock( { || CTC->CTC_DIG - CTC->CTC_INF } )  
	
	If lUseDocHis
		oSection0:Cell("CTC_DOCHIS"):SetBlock( { || CTC->CTC_DOCHIS } )
	Endif
	
	oSection0:Print()

Else
	oReport:NoUserFilter()

	cFilUser := oSection1:GetSqlExp()
            
	cQuery := "SELECT * "
	cQuery += "FROM " + RetSqlName("CT2") + " "			

	If lUseDocHis
		cQuery += "LEFT OUTER JOIN " + RetSqlName("CTC") + " ON "
		cQuery +=	"CT2_FILIAL	= CTC_FILIAL	AND "
		cQuery +=	"CT2_DATA	= CTC_DATA		AND "
		cQuery +=	"CT2_LOTE	= CTC_LOTE		AND "
		cQuery +=	"CT2_SBLOTE	= CTC_SBLOTE	AND "
		cQuery +=	"CT2_DOC	= CTC_DOC		AND	" 
		cQuery +=	"CT2_MOEDLC = CTC_MOEDA     AND "
		cQuery +=	RetSqlName("CTC") + ".D_E_L_E_T_ <> '*' "
	EndIf

		cQuery += "WHERE CT2_FILIAL " + GetRngFil( aSelFil, "CT2", .T., @cTmpCT2Fil ) + " AND " 
		cQuery +=       "CT2_DATA   >= '" + DTOS(mv_par01) + "' AND "
		cQuery += 	    "CT2_DATA   <= '" + DTOS(mv_par02) + "' AND "
		cQuery += 	    "CT2_LOTE   >= '" + mv_par03 	   + "' AND "
		cQuery += 	    "CT2_LOTE   <= '" + mv_par04 	   + "' AND "
		cQuery += 	    "CT2_SBLOTE >= '" + mv_par15 	   + "' AND "
		cQuery += 		"CT2_SBLOTE <= '" + mv_par16 	   + "' AND "
		cQuery +=   	"CT2_DOC    >= '" + mv_par05 	   + "' AND "
		cQuery += 		"CT2_DOC    <= '" + mv_par06 	   + "' AND "
		cQuery += 		"CT2_MOEDLC = '"+ mv_par07 + "' AND "
	
	If !lAllSL
		cQuery += 		"CT2_TPSALD = '"+ mv_par11 + "' AND "		
	EndIf
	
		cQuery += 		"CT2_DC <> '4' AND "

	If !Empty(cFilUser)
		cQuery += cFilUser + " AND "
	EndIf
	
		cQuery +=       RetSqlName("CT2")+ ".D_E_L_E_T_ <> '*' " 
							
		cQuery += "ORDER BY CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA"

		cQuery := ChangeQuery(cQuery)		   

	If Select("cArqCT2") > 0
		dbSelectArea("cArqCT2")
		dbCloseArea()
	Endif
        	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"cArqCT2",.T.,.F.)
           
	dbSelectArea("cArqCT2")

    nReccount := 0
    do while ! eof()
	    nReccount += 1
       dbSkip()
    EndDo

    DbGoTop()
            
    aStrSTRU := CT2->(dbStruct())      //// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
        
	For nStr := 1 to Len( CT2->(dbStruct()) )        //// LE A ESTRUTURA DA TABELA
		If aStrSTRU[nStr][2] <> "C" .and. cArqCT2->(FieldPos(aStrSTRU[nStr][1])) > 0
			TcSetField("cArqCT2",aStrSTRU[nStr][1],aStrSTRU[nStr][2],aStrSTRU[nStr][3],aStrSTRU[nStr][4])
		EndIf
	Next

	dbSelectArea("cArqCT2")
	cAliasCT2 := "cArqCT2"            
			
	TRPosition():New(oSection1,"CT2",1,;
				{|| xFilial("CT2")+(cAliasCT2)->(DtoS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA+CT2_TPSALD+CT2_EMPORI+CT2_FILORI+CT2_MOEDLC) })
                                  
    // section 1 
	oSection1:Cell( "CT2_DATA"   ):SetBlock( { || (cAliasCT2)->CT2_DATA	} )
	oSection1:Cell( "CT2_LOTE"   ):SetBlock( { || (cAliasCT2)->CT2_LOTE	} )
	oSection1:Cell( "CT2_SBLOTE" ):SetBlock( { || (cAliasCT2)->CT2_SBLOTE	} )
	oSection1:Cell( "CT2_DOC"    ):SetBlock( { || (cAliasCT2)->CT2_DOC 	} )
	If lUseDocHis
		oSection1:Cell( "CTC_DOCHIS" ):SetBlock( { || (cAliasCT2)->CTC_DOCHIS 	} )
	EndIf

    // section 11
	oSection11:Cell( "CT2_LINHA" ):SetBlock( { || (cAliasCT2)->CT2_LINHA	} )
	oSection11:Cell( "CT2_DC"    ):SetBlock( { || (cAliasCT2)->CT2_DC		} )
	oSection11:Cell( "CT2_HP"    ):SetBlock( { || (cAliasCT2)->CT2_HP 		} )
	oSection11:Cell( "CT2_HIST"  ):SetBlock( { || (cAliasCT2)->CT2_HIST	} )

	oReport:SetMeter( nReccount )

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define bloco de codigo com as variaveis para impressao das celulas de totais  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
   cContfil := (cAliasCT2)->CT2_FILIAL
   
   While (cAliasCT2)->( !Eof() .And. CT2_DATA <= mv_par02) .And. !oReport:Cancel()
   
   		cFilAnt := (cAliasCT2)->CT2_FILIAL 
		Titulo	:= STR0004+" "+alltrim(STR0030)+" "+cDescMoeda+" - Filial: "+cFilAnt                                                                                                  
		oReport:SetCustomText({|| CtCGCCabTR(,,,,,dDataFim,titulo,,,,,oReport)} )  
		
		If oReport:Cancel()
			Exit
		EndIf	

		If U_Ctr070Skip(cAliasCT2,lAllSL)
			Loop
		EndIf
			
		cLote 		:= (cAliasCT2)->CT2_LOTE
		cSubLote 	:= (cAliasCT2)->CT2_SBLOTE
		cDoc		:= (cAliasCT2)->CT2_DOC
		dData 		:= (cAliasCT2)->CT2_DATA
	
		lFirst:= .T.
		nTotalDeb := 0
		nTotalCrd := 0
	
		oSection1:Init()
		oSection1:PrintLine()
		oSection1:Finish()

		oSection11:Init()

		While (cAliasCT2)->( !Eof() 	.And. CT2_FILIAL 		== xFilial("CT2") ;
								 		.And. Dtos(CT2_DATA) 	== Dtos(dData) 	 ;
								 		.And. CT2_LOTE 			== cLote 	;
								 		.And. CT2_SBLOTE		== cSubLote ;
								 		.And. CT2_DOC 			== cDoc )

			If oReport:Cancel()
				Exit
			EndIf
			            
			If U_Ctr070Skip(cAliasCT2,lAllSL)
				Loop
			EndIf
		
			oSection11:Cell( "CT2_LINHA" ):SetBlock( { || (cAliasCT2)->CT2_LINHA	} )

			If lCusto .And. lItem .And. lCv //Se imprime C.C, Item E Cl.Valores
			
				If (cAliasCT2)->CT2_DC = "1" 

					nTotalDeb += (cAliasCT2)->CT2_VALOR

					oSection11:Cell("CT2_DC"):SetBlock( { || cDebit } )									
					
					oSection11:Cell("CCONTAD"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_DEBITO) } )					
    
					oSection11:Cell("CCUSTOD"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCD) } )

					oSection11:Cell("CITEMD"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMD) } )					
					
					oSection11:Cell("CCLASSED"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLDB) } )	

					oSection11:Cell("CDEBITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )					


				ElseIf (cAliasCT2)->CT2_DC = "2" 

					nTotalCrd += (cAliasCT2)->CT2_VALOR

					oSection11:Cell("CT2_DC"):SetBlock( { || cCredit } )									
				                           
					oSection11:Cell("CCONTAC"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_CREDIT) } )
				
					oSection11:Cell("CCUSTOC"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCC) } )

					oSection11:Cell("CITEMC"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMC) } )					
					
					oSection11:Cell("CCLASSEC"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLCR) } )							

					oSection11:Cell("CCREDITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )						

				ElseIf (cAliasCT2)->CT2_DC = "3"
				
					nTotalDeb += (cAliasCT2)->CT2_VALOR
					nTotalCrd += (cAliasCT2)->CT2_VALOR

                    // Imprime quando for Partida dobrada
                    dbSelectArea( cAliasCT2 )

					oSection11:Cell( "CT2_LINHA" ):SetBlock( { || (cAliasCT2)->CT2_LINHA	} )
 					oSection11:Cell( "CT2_DC" ):SetBlock( { || (cAliasCT2)->CT2_DC } )

					                     
					oSection11:Cell("CCONTAD"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_DEBITO) })
					oSection11:Cell("CCONTAC"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_CREDIT) })
					
					oSection11:Cell("CCUSTOD"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCD) } )
					oSection11:Cell("CCUSTOC"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCC) } )
			
					oSection11:Cell("CITEMD"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMD) } )	
					oSection11:Cell("CITEMC"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMC) } )	

					oSection11:Cell("CCLASSED"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLDB) } )							
					oSection11:Cell("CCLASSEC"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLCR) } ) 
				
					oSection11:Cell("CDEBITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )							
					oSection11:Cell("CCREDITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )						
				
				Endif            			
   		        
   			 	IF mv_par21 == 1 .and. (cAliasCT2)->CT2_DC == "3" // Se for partida dobrada, desdobra os lançamentos
					//Debito
					oSection11:Cell("CT2_DC"        ):SetBlock( { || cDebit } )									
					oSection11:Cell( "CCONTAC"		):SetBlock( { || '' } )
					oSection11:Cell( "CCUSTOC"		):SetBlock( { || '' } )
					oSection11:Cell( "CITEMC"		):SetBlock( { || '' } )					
					oSection11:Cell( "CCLASSEC"		):SetBlock( { || '' } )									
					oSection11:Cell( "CCREDITO"		):SetBlock( { || 0  } )

		   			oSection11:Cell( "CT2_HP"    ):SetBlock( { || (cAliasCT2)->CT2_HP} )
					oSection11:Cell( "CT2_HIST"  ):SetBlock( { || (cAliasCT2)->CT2_HIST	} ) 
        			oSection11:PrintLine()             
 
					// faz a impressao do historico detalhado
					RpPrintHist( cAliasCT2 , oSection11 )

                    //Credito		   			
					oSection11:Cell("CT2_DC"        ):SetBlock( { || cCredit } )									
                    oSection11:Cell( "CT2_LINHA"	):SetBlock( { || (cAliasCT2)->CT2_LINHA } )
				
					oSection11:Cell("CCONTAC"		):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_CREDIT) })
				
					oSection11:Cell( "CCONTAD"		):SetBlock( { || '' } )
					oSection11:Cell( "CCUSTOD"		):SetBlock( { || '' } )
					oSection11:Cell( "CCUSTOC"		):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCC) } )
					oSection11:Cell( "CITEMD"		):SetBlock( { || '' } )					
					oSection11:Cell( "CITEMC"		):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMC) } )					
					oSection11:Cell( "CCLASSED"		):SetBlock( { || '' } )									
					oSection11:Cell( "CCLASSEC"		):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLCR) } )									
					oSection11:Cell( "CDEBITO"		):SetBlock( { || 0  } )
					oSection11:Cell( "CCREDITO"		):SetBlock( { || (cAliasCT2)->CT2_VALOR  } )

     			EndIf
     			
			Else
			
				If (cAliasCT2)->CT2_DC = "1"                         
					
					nTotalDeb += (cAliasCT2)->CT2_VALOR

					oSection11:Cell("CCONTAD"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_DEBITO) } )				
				
					oSection11:Cell("CT2_DC"):SetBlock( { || cDebit } )
					oSection11:Cell("CDEBITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )
					oSection11:Cell("CCREDITO"):SetBlock( { || 0 } )

					If mv_par09 == 1				
						oSection11:Cell("CCUSTOD"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCD) } )
					Endif				

					If mv_par10 == 1 				
						oSection11:Cell("CITEMD"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMD) } )					
					Endif

					If mv_par14 == 1 
						oSection11:Cell("CCLASSED"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLDB) } )							
					Endif

				ElseIf (cAliasCT2)->CT2_DC = "2" 
				
					nTotalCrd += (cAliasCT2)->CT2_VALOR

					oSection11:Cell("CCONTAC"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_CREDIT) } )
					
					oSection11:Cell("CT2_DC"):SetBlock( { || cCredit } )				
					oSection11:Cell("CDEBITO"):SetBlock( { || 0 } )					
					oSection11:Cell("CCREDITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )													

					If mv_par09 == 1				
						oSection11:Cell("CCUSTOC"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCC) } )
					Endif				

					If mv_par10 == 1 				
						oSection11:Cell("CITEMC"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMC) } )					
					Endif

					If mv_par14 == 1 
						oSection11:Cell("CCLASSEC"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLCR) } )							
					Endif

				Else         

					nTotalDeb += (cAliasCT2)->CT2_VALOR
					nTotalCrd += (cAliasCT2)->CT2_VALOR
					
					oSection11:Cell("CCONTAD"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_DEBITO)} )											
					oSection11:Cell("CCONTAC"):SetBlock( { || U_Ctr070CT1((cAliasCT2)->CT2_CREDIT)} )
				
					oSection11:Cell("CT2_DC"):SetBlock( { || cPdobr })
					oSection11:Cell("CDEBITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )	
					oSection11:Cell("CCREDITO"):SetBlock( { || (cAliasCT2)->CT2_VALOR } )									

					If mv_par09 == 1				
						oSection11:Cell("CCUSTOD"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCD) } )
						oSection11:Cell("CCUSTOC"):SetBlock( { || U_Ctr070CTT((cAliasCT2)->CT2_CCC) } )
					Endif				

					If mv_par10 == 1 				
						oSection11:Cell("CITEMC"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMC) } )	
						oSection11:Cell("CITEMD"):SetBlock( { || U_Ctr070CTD((cAliasCT2)->CT2_ITEMD) } )					
					Endif

					If mv_par14 == 1 
						oSection11:Cell("CCLASSEC"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLCR) } )
						oSection11:Cell("CCLASSED"):SetBlock( { || U_Ctr070CTH((cAliasCT2)->CT2_CLVLDB) } )	
					Endif

				Endif
			
			Endif
            
			oSection11:Cell( "CT2_HP"    ):SetBlock( { || (cAliasCT2)->CT2_HP} )
			oSection11:Cell( "CT2_HIST"  ):SetBlock( { || (cAliasCT2)->CT2_HIST	} ) 
	   		oSection11:PrintLine()
 
			 // faz a impressao do historico detalhado
			RpPrintHist( cAliasCT2 , oSection11 )
		
			(cAliasCT2)->( DbSkip() )
			
		Enddo

		oSection11:Finish()
	 	
	 	//--------------------- T O T A L  D O C U M E N T O ---------------------
		If lTotal
			oSection2:Cell( "TOT_DESCRI" ):SetBlock( { || STR0018 } )	// "TOTAL DOCUMENTO"
			
			oSection2:Cell( "TOT_DEBITO" ):SetBlock( { || Transform(nTotalDeb,Tm(nTotalDeb, 18) ) } )
			oSection2:Cell( "TOT_CREDITO"):SetBlock( { || Transform(nTotalCrd,Tm(nTotalCrd, 18) ) } )
			If lTot123
							oSection2:Cell( "TOT_INF"    ):SetBlock( { || Transform(cCtcTMP->INFORMADO, Tm(cCtcTMP->INFORMADO, 18) ) } )
				//****************************************************
				//      Totalizador do Documento do Lote (CTC)       *
				//****************************************************
				cCTCChv := xFilial("CTC")+dtos(dData)+cLote+cSubLote+cDoc+cMoeda
				CTC->(MsSeek(cCTCChv))
				Do While cCTCChv==CTC->(CTC_FILIAL+dtos(CTC_DATA)+CTC_LOTE+CTC_SBLOTE+CTC_DOC+CTC_MOEDA)
		
					If lAllSL
		
						nDocInf += CTC->CTC_INF      
						nDocDig += CTC->CTC_DIG      
		
				    ElseIf MV_PAR11 == CTC->CTC_TPSALD
		
				        nDocInf := CTC->CTC_INF      
						nDocDig := CTC->CTC_DIG
						Exit
		
					EndIf
		
					CTC->(DbSkip())
		
				EndDo

	 			 oSection2:Cell( "TOT_INF"    ):SetBlock( { || Transform(nDocInf, Tm(nDocInf, 18) ) } )
				 oSection2:Cell( "TOT_DIG"    ):SetBlock( { || Transform(nDocDig, Tm(nDocDig, 18) ) } )
				 oSection2:Cell( "TOT_DIFINF" ):SetBlock( { || Transform(ROUND(NOROUND(nDocDig - nDocInf,10),2), Tm(nDocDig, 18) ) } )

			Endif


			//****************************************************
			//   Fim do Totalizador do Documento do Lote (CTC)   *
			//****************************************************
		
			oSection2:Init()
			oSection2:PrintLine()
			oSection2:Finish()
	                          
	         nDocInf := 0
             nDocDig := 0

			If mv_par12 == 2
				oReport:EndPage()
			EndIf
			
			nTotalDeb := 0
			nTotalCrd := 0
			//****************************************************
			//           Totalizador do Lote (CT6)               *
			//****************************************************
  			If	cLote <> (cAliasCT2)->CT2_LOTE .Or.;
				cSubLote <> (cAliasCT2)->CT2_SBLOTE .Or.;
				DtoS(dData) <> DtoS((cAliasCT2)->CT2_DATA)
				
				If lAllSL					
					aRetCT6 := CtbSaldoLote(cLote,cSubLote,dData,mv_par07,'*',cFilAnt)		
				Else
					aRetCT6 := CtbSaldoLote(cLote,cSubLote,dData,mv_par07,mv_par11,cFilAnt)
					//Total de Lote
				EndIf
				nTotLotDeb 	:= aRetCT6[1]
				nTotLotCrd 	:= aRetCT6[2]
				nLotInf 		:= aRetCT6[3]
				nLotDig 		:= aRetCT6[4]		
								
				oSection2:Cell( "TOT_DESCRI" ):SetBlock( { || STR0020 } )	// "TOTAL LOTE"
				oSection2:Cell( "TOT_DEBITO" ):SetBlock( { || Transform( nTotLotDeb, Tm(nTotLotDeb, 18) ) } )
				oSection2:Cell( "TOT_CREDITO"):SetBlock( { || Transform( nTotLotCrd, Tm(nTotLotCrd, 18) ) } )
				//***********************************************
				// Imprime total Informado,Digitado e difenreça *
				//***********************************************			
				If lTot123
					oSection2:Cell( "TOT_INF"    ):SetBlock( { || Transform( nLotInf, Tm( nLotInf, 18 ) ) } )
					oSection2:Cell( "TOT_DIG"    ):SetBlock( { || Transform( nLotDig, Tm( nLotDig, 18 ) ) } )
					oSection2:Cell( "TOT_DIFINF" ):SetBlock( { || Transform( ROUND(NOROUND(nLotDig - nLotInf,10),2), Tm(nLotDig, 18 ) ) } )
				Endif  

				oSection2:Init()				
				oSection2:PrintLine()
				oSection2:Finish()

				If mv_par12 == 1
					oReport:EndPage()
				EndIf
                // Pego os valores dos Lotes para o Total geral
				nTotGerDeb 	+= nTotLotDeb
				nTotGerCrd 	+= nTotLotCrd
				nTotGerInf 	+= nLotInf
				nTotGerDig 	+= nLotDig     
				// zero as variais para nao acumular valor
				nTotLotDeb 	:= 0
				nTotLotCrd 	:= 0
     		    nLotInf	   	:= 0
			 	nLotDig		:= 0
					 					
			Endif

			//****************************************************
			//          Fim do totalizador do Lote (CT6)         *
			//****************************************************

		Endif

		dbselectarea( cAliasCT2 )
		oReport:IncMeter()
		If &(cMVFil) = 1 .And. cContFil <> (cAliasCT2)->CT2_FILIAL .AND. !EOF()
			cContFil := (cAliasCT2)->CT2_FILIAL
			oReport:EndPage()
		Endif 
		
	Enddo

Endif  

//----------------- T O T A L  G E R A L ----------------------
If lTotal 

	oSection2:Cell( "TOT_DESCRI" ):SetBlock( { || STR0019 } ) // "TOTAL GERAL"
	oSection2:Cell( "TOT_DEBITO" ):SetBlock( { || Transform( nTotGerDeb, Tm( nTotGerDeb, 18 ) ) } )
	oSection2:Cell( "TOT_CREDITO"):SetBlock( { || Transform( nTotGerCrd, Tm( nTotGerCrd, 18 ) ) } )

	If lTot123
		oSection2:Cell( "TOT_INF"    ):SetBlock( { || Transform( nTotGerInf, Tm(nTotGerInf, 18) ) } )
		oSection2:Cell( "TOT_DIG"    ):SetBlock( { || Transform( nTotGerDig, Tm(nTotGerDig, 18) ) } )
		oSection2:Cell( "TOT_DIFINF" ):SetBlock( { || Transform( ROUND(NOROUND(nTotGerDig - nTotGerInf, 10) , 2), Tm(nTotGerInf, 18) ) } )
	Endif

	oSection2:Init()
	oSection2:PrintLine()
	oSection2:Finish()
    // ZERO AS VARIAS DO TOTAL GERAL PARA NAO ACUMULAR VALOR INDEVIDO
	nTotGerDeb := 0
	nTotGerCrd := 0
	nTotGerInf := 0
	nTotGerDig := 0
Endif

oReport:IncMeter()

CtbTmpErase(cTmpCT2Fil)
cFilAnt := cFilIni 

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Ctr070Skip³ Autor ³ Pilar S Albaladejo	³ Data ³ 02.04.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica condicoes para pular os registros			      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctr070Skip(cAlias) 										  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³ Generico      											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cAlias = Se for TOP, receberá o ALIAS da query gerada.      ±±
±±           ³          O Default será "CT2".                              ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr070Skip(cAlias,lAllSL)
           
DEFAULT cAlias := "CT2"
DEFAULT lAllSL := .F.

If !lAllSL
	If mv_par11 <> (cAlias)->CT2_TPSALD                    
		(cAlias)->( DbSkip() )
		Return .T.
	Endif
EndIf

If ! ( ( cAlias )->CT2_LOTE >= mv_par03 .And. (cAlias)->CT2_LOTE <= mv_par04 )
	MsSeek( Soma1( xFilial("CT2")+DTOS((cAlias)->CT2_DATA)+(cAlias)->CT2_LOTE )+mv_par15+mv_par05, .T.)
	Return .T.
Endif
	
If ! ( (cAlias)->CT2_DOC >= mv_par05 .And. (cAlias)->CT2_DOC <= mv_par06 )
	MsSeek( Soma1( xFilial("CT2")+DTOS((cAlias)->CT2_DATA)+(cAlias)->CT2_LOTE+(cAlias)->CT2_SBLOTE+(cAlias)->CT2_DOC ), .T.)
	Return .T.
Endif
	
If ! ( (cAlias)->CT2_SBLOTE >= mv_par15 .And. (cAlias)->CT2_SBLOTE <= mv_par16 )
	MsSeek( Soma1( xFilial("CT2")+DTOS((cAlias)->CT2_DATA)+(cAlias)->CT2_LOTE+(cAlias)->CT2_SBLOTE )+mv_par05, .T.)
	Return .T.
Endif

If (cAlias)->CT2_MOEDLC <> mv_par07
	(cAlias)->( DbSkip() )
	Return .T.
Endif            

If (cAlias)->CT2_DC = "4"
	(cAlias)->( DbSkip() )
	Return .T.
EndIf

If cPaisLoc == "CHI" .And. ! ( (cAlias)->CT2_SEGOFI >= mv_par22 .And. (cAlias)->CT2_SEGOFI <= mv_par23 )
	(cAlias)->( DbSkip() )
	Return .T.
EndIf	        

Return .F.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  Ctr070CT1 ³ Autor ³ TOTVS				    ³ Data ³ 18.09.19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par08 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   U_Ctr070CT1(cCodCT1)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cCodCT1 = Conteudo a Ser impresso                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCodCT1 = Conta Contábil a ser substituida (se for o caso) ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr070CT1(cCodCT1)
Local aSaveArea := GetArea()

If mv_par08 = 2	
	CT1->(dbSetOrder(1))
	If CT1->(MsSeek(xFilial()+cCodCT1))
		cCodCT1 := CT1->CT1_RES
	EndIf
Endif
RestArea(aSaveArea)

Return cCodCT1
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Ctt ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par15 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Ctr070Ctt(cCC)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cCC = Conteudo a Ser impresso                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cCc = Centro de custo a ser substituido (se for o caso)    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr070Ctt(cCc)

Local aSaveArea := GetArea()

If mv_par18 = 2
	dbSelectArea("CTT")
	dbSetOrder(1)		
	MsSeek(xFilial() + cCC)
	cCC := CTT->CTT_RES
Endif

RestArea(aSaveArea)
Return cCC

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Ctd ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par16 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Ctr070Ctd(cItem)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cItem = Conteudo a Ser impresso                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cItem = Item a ser substituido (se for o caso)    	      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr070Ctd(cItem)

Local aSaveArea := GetArea()

If mv_par19 = 2
	dbSelectArea("CTD")
	dbSetOrder(1)
	MsSeek(xFilial() + cItem)
	cItem := CTD->CTD_RES
Endif

RestArea(aSaveArea)
Return cItem

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ctr070Cth ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 17.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Faz a troca para impressao de codigo reduzido de acordo com ³±±
±±³          ³mv_par17 = 2                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_Ctr070Cth(cClVl)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³cItem = Conteudo a Ser impresso                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Ctbr070                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cClVl = Classe de valor a ser substituida (se for o caso)  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr070Cth(cClVl)

Local aSaveArea := GetArea()

If mv_par20 = 2
	dbSelectArea("CTH")
	dbSetOrder(1)
	MsSeek(xFilial() + cCLVL)
	cCLVL := CTH->CTH_RES
Endif

RestArea(aSaveArea)
Return cCLVL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RpPrintHistºAutor ³Renato F. Campos    º Data ³  02/16/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão do historico detalhado do lançamento contabil    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ R4                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RpPrintHist( cAliasCT2 , oSection11 )

Local cLote 	:= (cAliasCT2)->CT2_LOTE
Local cSubLote 	:= (cAliasCT2)->CT2_SBLOTE
Local cDoc		:= (cAliasCT2)->CT2_DOC
Local dData 	:= (cAliasCT2)->CT2_DATA
Local cSeq 		:= (cAliasCT2)->CT2_SEQLAN
Local cEmpOri	:= (cAliasCT2)->CT2_EMPORI
Local cFilOri	:= (cAliasCT2)->CT2_FILORI
Local nReg		:= 0

Default cAliasCT2 := 'CT2'

oSection11:Cell( "CT2_LINHA"	):SetBlock( { || '' } )
oSection11:Cell( "CCONTAD"		):SetBlock( { || '' } )
oSection11:Cell( "CCONTAC"		):SetBlock( { || '' } )

oSection11:Cell( "CCUSTOD"		):SetBlock( { || '' } )
oSection11:Cell( "CCUSTOC"		):SetBlock( { || '' } )
oSection11:Cell( "CITEMD"		):SetBlock( { || '' } )					
oSection11:Cell( "CITEMC"		):SetBlock( { || '' } )					
oSection11:Cell( "CCLASSED"		):SetBlock( { || '' } )									
oSection11:Cell( "CCLASSEC"		):SetBlock( { || '' } )									
oSection11:Cell( "CDEBITO"		):SetBlock( { || 0  } )
oSection11:Cell( "CCREDITO"		):SetBlock( { || 0  } )

oSection11:Cell( "CT2_HP"   	):SetBlock( { || '' } )
oSection11:Cell( "CT2_HIST" 	):SetBlock( { || '' } )

// Procura pelo complemento de historico
dbSelectArea( cAliasCT2 )
nReg := Recno()

dbSelectArea("CT2")
dbSetOrder( 10 )

oSection11:Cell( "CT2_DC" ):SetBlock( { || '4' } )

If MsSeek(xFilial("CT2")+DTOS(dData)+cLote+cSubLote+cDoc+cSeq+cEmpOri+cFilOri)
	dbSkip()

	If CT2->CT2_DC == "4"

		While CT2->( !Eof() 	.And. CT2_FILIAL == xFilial("CT2") ;
								.And. CT2_LOTE == cLote .And. CT2_DOC == cDoc ;
								.And. CT2_SEQLAN == cSeq .And. CT2_EMPORI == cEmpOri ;
								.And. CT2_FILORI == cFilOri .And. DTOS(CT2_DATA) == DTOS(dData) )

			If CT2->CT2_DC == "4"

				oSection11:Cell( "CT2_LINHA" ):SetBlock( { || CT2->CT2_LINHA	} )
				oSection11:Cell( "CT2_HP"    ):SetBlock( { || CT2->CT2_HP 		} )
				oSection11:Cell( "CT2_HIST"  ):SetBlock( { || CT2->CT2_HIST	} )

		    	oSection11:PrintLine()																	
		  	EndIf
		  	
 			CT2->( dbSkip() )
 			
		EndDo
		
	Endif
	
EndIf

dbSelectArea("CT2")
dbSetOrder(1)					

dbSelectArea(cAliasCT2)
dbGoto( nReg )

Return


//-------------------------------------------------------------------
/*/{Protheus.doc} ScheDef()

Definição de Static Function SchedDef para o novo Schedule

@author TOTVS
@since 23/03/2022
/*/
//-------------------------------------------------------------------

Static Function SchedDef()

Local aParam := {}

aParam := { "R",;            // Tipo R para relatório P para processo
			"CTR070",;       // Pergunte do relatório, caso não use, passar ParamDef
			,;               // Alias     
			,;               // Array de ordens
			STR0004 }        // Título 


Return aParam
