/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TOTVS.CH"
#Include "MATR882.CH"
#Include "FIVEWIN.CH"

/*----------------------------------------------------------------------*/
/*/{Protheus.doc} MATR882
MRP

@author Ricardo Prandi
@since 30/10/2013
@version P11
@obs Programa cópia do MATR880, lendo as novas tabelas do MRP
/*/
/*----------------------------------------------------------------------*/

User Function MATR882(lUsed)
Local   oReport

Default lUsed := .F.

// Tela com aviso de descontinuação do programa
cLinkRot := "https://tdn.totvs.com/display/PROT/Resultados+do+MRP"
cMsgSoluc := I18n(STR0034, {cLinkRot}) // "Utilize a nova rotina: <b><a target='#1[link]#'>Resultados MRP </a></b>."
If GetRpoRelease() >= "12.1.2510" .Or. DtoS(dDataBase) >= '20260101'
	cMsgDesc := STR0035 // "Esse programa foi bloqueado no release 12.1.2510 e desativado (em todos os releases) a partir de Janeiro de 2026."
	PCPMsgExp("MATR882", STR0033, "https://tdn.totvs.com/pages/viewpage.action?pageId=652585901", cLinkRot, Nil, 0, cMsgDesc, cMsgSoluc) // "Resultados MRP (resultadomrp)"
	Return Nil
Else
	cMsgDesc := STR0036+CHR(13)+CHR(10)+STR0037+CHR(13)+CHR(10)+STR0038 // "1) Este programa foi descontinuado e não sofre mais manutenção. " //"2) Sua utilização será bloqueada a partir do release 12.1.2510." //"3) Para os releases anteriores, será definitivamente desativado a partir de Janeiro/2026."
	PCPMsgExp("MATR882", STR0033, "https://tdn.totvs.com/pages/viewpage.action?pageId=652585901", cLinkRot, Nil, 0, cMsgDesc, cMsgSoluc) // "Resultados MRP (resultadomrp)"
EndIf

If TRepInUse()
	//Interface de impressao                                                  
	oReport := ReportDef(lUsed)
	oReport:PrintDialog()
Else
	U_MATR882R3(lUsed)
EndIf

Return NIL

/*------------------------------------------------------------------------//
//Programa:	ReportDef 
//Autor:		Felipe Nunes Toledo    
//Data:		11/07/06
//Descricao:	A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function ReportDef(lUsed)
Local oReport
Local oSection1
Local cTitle := OemToAnsi(STR0001) //"MRP"

//Criacao do componente de impressao                                      
//TReport():New                                                           
//ExpC1 : Nome do relatorio                                               
//ExpC2 : Titulo                                                          
//ExpC3 : Pergunte                                                        
//ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  
//ExpC5 : Descricao                                                       
oReport:= TReport():New("MATR882",cTitle,"MATR882", {|oReport| ReportPrint(oReport,cTitle,lUsed)},OemToAnsi(STR0002)) //"Este programa ira imprimir a Rela‡„o do MRP"
oReport:SetPortrait() //Define a orientacao de pagina do relatorio como paisagem.

//Criacao das secoes utilizadas pelo relatorio                            
//                                                                        
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

//oSection1                                                  
oSection1 := TRSection():New(oReport,STR0027,{"SB1"},/*Ordem*/) //"Produtos"
oSection1:SetHeaderPage()

TRCell():New(oSection1,'B1_COD'    ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_DESC' 	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_UM'   	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'B1_LE'   	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,  {|| RetFldProd(SB1->B1_COD,"B1_LE") })
TRCell():New(oSection1,'B1_ESTSEG' ,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,  {|| RetFldProd(SB1->B1_COD,"B1_ESTSEG") })
TRCell():New(oSection1,'B1_EMIN' 	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,  {|| RetFldProd(SB1->B1_COD,"B1_EMIN") })
TRCell():New(oSection1,'B1_TIPO' 	,'SB1',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)

/*------------------------------------------------------------------------//
//Programa:	ReportPrint 
//Autor:		Felipe Nunes Toledo    
//Data:		11/07/06
//Descricao:	A funcao estatica ReportPrint devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function ReportPrint(oReport,cTitle,lUsed)
//Variaveis do tipo objeto
Local oSection1 := oReport:Section(1)
Local oSection2,oSection3,oSection4,oSection5,oBreak

Local lContinua 	:= .T.
Local lVNecesEst	:= .F. 
Local lLista		:= .F.
Local lAchou    	:= .T.
Local lLogMrp		:= .F.

Local nTipo     	:= 0
Local j         	:= 0
Local i				:= 0
Local nCusto    	:= 0
Local nRec		 	:= 0
Local nParRel		:= 0
Local nTotValor		:= 0
Local nQtdPer		:= 0
Local nH5_Quant 	:= 0

Local cSeekLog		:= ""
Local cCondSH5 		:= "CZI_PROD != '"+Criavar("B1_COD",.F.)+"'"
Local cCampo		:= ""
Local cFilUsrSB1	:= ""  
Local cFil		  	:= ""
Local cAliasCZJ 	:= ""
Local cAliasTop		:= ""
Local cQuery		:= ""
Local cProDocAnt 	:= ""

Local aPerOri   	:= {}
Local aTam     		:= TamSX3("B2_QFIM")
Local lValPer       := .F.

Private aPerQuebra  := {}
Private cPerg       := "MATR882"
Private nPeriodos   := 0
Private nTipoCusto  := 1
Private aPeriodos	:= {}
Private lQuebraPer	:= .F.
Private nNumPer		:= 0

//Verifica as perguntas selecionadas (MATR882)                 
//Variaveis utilizadas para parametros                                    
//mv_par01 - Lista ? Tudo     So' c/ Saidas   So' c/ Neces.               
//mv_par02 - De Produto                                                   
//mv_par03 - Ate Produto                                                  
//mv_par04 - Lista log de eventos  1 = sim 2 = nao                        
//mv_par05 - Custo Produto: 1-Custo Standard;2-Custo Medio;3-Preco Compra 
//mv_par06 - Aglutina Periodos     1 = sim 2 = nao                        
//mv_par07 - Periodos para aglutina                                       
//mv_par08 - Lista a Necess. da Estrutura? 1 = sim 2 = nao                

Pergunte(oReport:GetParam(),.F.)

nParRel     := mv_par01
nTipoCusto  := mv_par05
lLogMrp     := mv_par04 == 1
lQuebraPer  := mv_par06 == 1
nNumPer     := mv_par07
lVNecesEst  := mv_par08 == 1

//Monta os Cabecalhos                                         
If lUsed != .T.
	lContinua := MATA712LCK()
EndIf

If lContinua
	dbSelectArea("CZI")
	
	If !Empty(dbFilter())
		dbClearFilter()
	EndIf
	
	dbSetOrder(1)
	//dbGoTop()
	dbSeek(xFilial("CZI"))
	
	//Definindo o titulo do relatorio
	oReport:SetTitle(cTitle+" - "+STR0018+" "+CZI->CZI_NRMRP) //"MRP"##"Programacao"
	
	aPeriodos := R882PER(@nTipo)
	
	If nParRel == 1
		cAliasCZJ := U_MTA712MVW2()
	Else
		cAliasCZJ := MATA712MVW()
	EndIf
	
	If lQuebraPer
		aPerOri    := aClone(aPeriodos)
		aPerQuebra := U_R882DivPeriodo(aPeriodos,.T.)
		aPeriodos  := U_R882DivPeriodo(aPeriodos)
	EndIf
	
	dbSelectArea("CZI")
	Set Filter to &cCondSH5
Else
	If nParRel == 1
		cAliasCZJ := U_MTA712MVW2()
	Else
		cAliasCZJ := MATA712MVW()
	EndIf
EndIf

//oSection2                                                  
oSection2 := TRSection():New(oSection1,cTitle,{cAliasCZJ,"SB1","CZI"},/*Ordem*/) //"MRP"
oSection2:SetHeaderPage()

TRCell():New(oSection2,'TEXTO',cAliasCZJ,STR0026,'',25,/*lPixel*/,/*{|| code-block de impressao }*/) //Periodos

For i := 1 to Len(aPeriodos)
	cCampo := "PER"+StrZero(i,3)
	TRCell():New(oSection2,cCampo,cAliasCZJ,DtoC(aPeriodos[i]),"999999999999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection2:Cell(cCampo):SetLineBreak() // Define quebra de linha caso as colunas nao couberem na pagina
Next i

TRCell():New(oSection2,'PRODUTO',cAliasCZJ,STR0027,'',/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //pRODUTOS

//oSection3                                                  
oSection3 := TRSection():New(oSection2,cTitle,{cAliasCZJ,"SB1","CZI"},/*Ordem*/) //"MRP"
oSection3:SetHeaderPage(.F.)
oSection3:SetHeaderSection(.F.)

TRCell():New(oSection3,'TEXTO',cAliasCZJ,STR0026,'',25,/*lPixel*/,/*{|| code-block de impressao }*/)

For i := 1 to Len(aPeriodos)
	cCampo := "PER"+StrZero(i,3)
	TRCell():New(oSection3,cCampo,cAliasCZJ,DtoC(aPeriodos[i]),"999999999999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) 
	oSection2:Cell(cCampo):SetLineBreak() // Define quebra de linha caso as colunas nao couberem na pagina
Next i

If lVNecesEst //-- Lista Neces. da Estrutura
	//oSection4                                                  
	oSection4 := TRSection():New(oSection2,cTitle,{cAliasCZJ,"SB1","CZI"},/*Ordem*/) //"MRP"
	oSection4:SetHeaderPage(.F.)
	oSection4:SetHeaderSection(.F.)

	TRCell():New(oSection4,'CZI_DOC','CZI',STR0026,'',25,/*lPixel*/,/*{|| code-block de impressao }*/)
	For i := 1 to Len(aPeriodos)
		cCampo := "PER"+StrZero(i,3)
		TRCell():New(oSection4,cCampo,'CZI',DtoC(aPeriodos[i]),"999999999999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
		oSection4:Cell(cCampo):SetLineBreak() // Define quebra de linha caso as colunas nao couberem na pagina
	Next i
EndIf

If lLogMRP //-- Lista Log do MRP
	//oSection5 (Log do MRP)                                      
	oSection5 := TRSection():New(oSection3,cTitle,{cAliasCZJ,"SHG"},/*Ordem*/) //"MRP"
	oSection5:SetHeaderPage(.F.)
	oSection5:SetHeaderSection(.F.)
	
	TRCell():New(oSection5,'HG_LOGMRP','SHG',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	oSection5:Cell('HG_LOGMRP'):SetLineBreak() // Define quebra de linha caso as colunas nao couberem na pagina
EndIf

//Definindo a Quebra
oBreak := TRBreak():New(oSection2,oSection2:Cell("PRODUTO"),NIL,.F.)

If lContinua
	dbSelectArea(cAliasCZJ)
	//Condicao de Filtragem do CZJ                                 ³
	Set Filter to PRODUTO >= MV_PAR02 .And. PRODUTO <= MV_PAR03
	dbGotop()

	//Transforma parametros Range em expressao ADVPL                         
	MakeAdvplExpr(oReport:GetParam())

	//Posicionamento da tabela SB1 
	TRPosition():New(oSection1,"SB1",1,{||xFilial("SB1")+(cAliasCZJ)->PRODUTO})

	//Inibindo Celula
	oSection2:Cell("PRODUTO"):Hide()
	oSection2:Cell("PRODUTO"):HideHeader()
	
	//Inicio da impressao do fluxo do relatorio                               
	oReport:SetMeter((cAliasCZJ)->(LastRec()) )
	oSection1:Init()
	oSection2:Init()
	oSection3:Init()
	
	cFilUsrSB1:= oSection1:GetAdvplExp()
	
	While !oReport:Cancel() .And. !(cAliasCZJ)->(Eof())
		If !Empty(cFilUsrSB1)
		    SB1->(MsSeek(xFilial("SB1")+(cAliasCZJ)->PRODUTO))
		    If !(&("SB1->"+cFilUsrSB1))
		       (cAliasCZJ)->(dbSkip())
	    	   Loop
	    	EndIf   
		EndIf
		
		lLista := R882FILTRO(nParRel,nTipo,cAliasCZJ) //-- Filtro conforme MV_PAR01
		
		If lLista
			oSection1:PrintLine() //-- Impressao da secao 1
			oReport:SkipLine()
	       	cFil	  := xFilial("CZI")
	       	cProdAnt := (cAliasCZJ)->PRODUTO
	       	cOpcAnt  := (cAliasCZJ)->OPCIONAL
	       	cSeekLog := (cAliasCZJ)->MRP+(cAliasCZJ)->PRODUTO
    	   	nPerIni  := 1
	       	While (cAliasCZJ)->PRODUTO == cProdAnt .And. (cAliasCZJ)->OPCIONAL == cOpcAnt 
				If lQuebraPer
					For i := 1 to 6
						For j := 1 to 6
							If j > Len(aPeriodos)
								Exit
							EndIf
							nQtdPer := U_R882ValField(j,cAliasCZJ)
							cCampo  := "PER"+StrZero(j,3)
							oSection2:Cell(cCampo):SetValue( nQtdPer )
						Next
						oReport:IncMeter()
						oSection2:PrintLine() //-- Impressao da secao 2
						nRec := Recno()
						(cAliasCZJ)->(dbSkip())
					Next
				Else
					oReport:IncMeter()
					oSection2:PrintLine() //-- Impressao da secao 2
					nRec := Recno()
					(cAliasCZJ)->(dbSkip())
				EndIf
			EndDo
			
			//Definindo o Valor da Necessidade
			nTotValor := 0
			(cAliasCZJ)->(DbGoto(nRec))
		   	oSection3:Cell('TEXTO'):SetValue("Valor")
			
			For i:= 1 To Len(aPeriodos)
	  			nCusto	:= U_R882Custo((cAliasCZJ)->PRODUTO)
	  			dbSelectArea(cAliasCZJ)
	  			nQtdPer := U_R882ValField(i,cAliasCZJ)
	  			cCampo  := "PER"+StrZero(i,3)
				oSection3:Cell(cCampo):SetValue(nQtdPer * nCusto)
				nTotValor += oSection3:Cell(cCampo):GetValue()
	       Next i	
			oSection3:PrintLine() //-- Impressao da secao 3
			(cAliasCZJ)->(dbSkip())    

			//Lista a necessidade da estrutura do produto possicionado a partir da tabela CZI com CZI_ALIAS igual a "CZJ".                               ³
			If lVNecesEst 
				oSection4:Init()
				
				cAliasTop := "NECESESTRUT"
				
				cQuery := " SELECT CZI.CZI_PROD, " +;
				                 " CZI.CZI_ALIAS, " +;
				                 " CZI.CZI_DOC, " +;
				                 " CZI.CZI_PERMRP, " +;
				                 " CZI.CZI_DTOG, " +;
				                 " CZI.CZI_QUANT " +;
				            " FROM " + RetSqlName("CZI") + " CZI " +;
				           " WHERE CZI.CZI_FILIAL = '" + xFilial("CZI") + "' " +;
				             " AND CZI.CZI_PROD   = '" + cProdAnt + "' " +;
				             " AND CZI.CZI_ALIAS  = 'CZJ' " +;
				           " ORDER BY CZI.CZI_FILIAL, " +;
				                    " CZI.CZI_PROD, " +;
				                    " CZI.CZI_ALIAS, " +;
				                    " CZI.CZI_DOC, " +;
				                    " CZI.CZI_DTOG "
				
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTop,.T.,.T.)
				dbSelectArea(cAliasTop)
				
				If !((cAliasTop)->(EOF()))
					oReport:SkipLine()
					oReport:PrintText(STR0022)
				EndIf
				
				nH5_Quant:=0
				
				While (cAliasTop)->(!Eof() .AND. CZI_PROD+CZI_ALIAS == cProdAnt+"CZJ")
					oSection4:Cell('CZI_DOC'):SetValue((cAliasTop)->CZI_DOC )
					lExit := .F.
					
					If cProDocAnt # (cAliasTop)->CZI_DOC
						For i:= 1 To Len(aPeriodos)
							cCampo  := "PER"+StrZero(i,3)  
							oSection4:Cell(cCampo):SetValue( 0 )
						Next i
						
						cProDocAnt := (cAliasTop)->CZI_DOC
					EndIf
					
					For i:= 1 To Len(aPeriodos)
						cCampo  := "PER"+StrZero(i,3)
						lValPer := IIF(STOD((cAliasTop)->CZI_DTOG) >= aPeriodos[i],IIF(i<Len(aPeriodos),STOD((cAliasTop)->CZI_DTOG) < aPeriodos[i+1],.T.),.F.)
						If lValPer .And. !lExit								
							oSection4:Cell(cCampo):SetValue(oSection4:Cell(cCampo):GetValue() + (cAliasTop)->CZI_QUANT)
							Exit							
							
							If (cAliasTop)->(Eof()) .Or. (cAliasTop)->CZI_PROD+(cAliasTop)->CZI_ALIAS # cProdAnt+"CZJ"
								lExit := .T.
							EndIf
						EndIf
					Next i
					
					If (cAliasTop)->(!Eof())
						(cAliasTop)->(dbSkip())
					Endif
					
					If cProDocAnt # (cAliasTop)->CZI_DOC .Or. (cAliasTop)->(Eof())
						oSection4:PrintLine() //-- Impressao da secao 4
					EndIf
				EndDo
				
				(cAliasTop)->(dbCloseArea())
				
				If lQuebraPer .And. lAchou
					oSection4:Cell(cCampo):SetValue( nH5_Quant )  
					oSection4:PrintLine() //-- Impressao da secao 4
				EndIf
				
				oSection4:Finish()
			EndIf
   			oReport:SkipLine()
			//Imprime o Vlr. Total do Produto
		    oReport:PrintText(STR0021+"          "+Str(nTotValor,aTam[1],aTam[2]))
		    
 			//Lista os eventos de log desse produto
			If lLogMrp
				oSection5:Init()
				dbSelectArea("SHG")
				If dbSeek(xFilial("SHG")+cSeekLog)
					oReport:PrintText(STR0019) //"Eventos relacionados ao produto"
					While !EOF() .AND. xFilial("SHG")+cSeekLog == HG_FILIAL+HG_SEQMRP+HG_COD
						oSection5:PrintLine() //-- Impressao da secao 5
						SHG->(dbSkip())
					EndDo
				EndIf
				oSection5:Finish()
				oReport:SkipLine()
				dbSelectArea(cAliasCZJ)
			EndIf
			oReport:ThinLine()
		Else
	    	(cAliasCZJ)->(dbSkip(6))
	    EndIf
	EndDo
	oSection3:Finish()
	oSection2:Finish()
	oSection1:Finish()

EndIf
If (lContinua = .T.) .And. (lUsed != .T.)
	dbSelectArea(cAliasCZJ)
	dbCloseArea()
	dbSelectArea("CZI")
	dbCloseArea()
ElseIf lContinua
	(cAliasCZJ)->(dbClearFilter())
	CZI->(dbClearFilter())
EndIF

dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)

Return Nil

/*-------------------------------------------------------------------------/
//Programa:    MTA712MVW2
//Autor:       Ricardo Peixoto
//Data:        05/07/2017
//Descricao:   Monta o arquivo temporário da CZJ e CZK para mostrar em tela   
//Parametros:  aCampos - Arry de campos (por referência)
//Uso:         MATR882
//------------------------------------------------------------------------*/
User Function MTA712MVW2(lAtualiza)
Local cCriaTrab    := ""
Local cQuery    := ""
Local cProdAnt    := ""
Local cOpcAnt    := ""
Local cRevAnt    := ""
Local cNameIdx     := ""
Local cAliasTab    := "CRIATAB"
Local cAliasTop    := "BUSCADADOS"
Local aIndex    := {"PRODUTO","OPCIONAL","REVISAO"}
Local nInd        := 0
Local nIndProd    := 0
Local aTamQuant := TamSX3("B2_QFIM")
Local aRecNo    := {}
Local aFields    := {}
Local aStruct   := {}
Local oTabela

Default lAtualiza := .T.

//Autaliza LOG
ProcLogAtu("MENSAGEM","Inicio montagem arquivo de trabalho","Inicio montagem arquivo de trabalho")

//Cria o array dos campos para o arquivo
AADD(aFields,{"TIPO","C",1,0})
AADD(aFields,{"TEXTO","C",20,0})
AADD(aFields,{"PRODUTO","C",LEN(CZJ->CZJ_PROD),0})
AADD(aFields,{"PRODSHOW","C",LEN(CZJ->CZJ_PROD),0})
AADD(aFields,{"OPCIONAL","C",LEN(CZJ->CZJ_OPCORD),0})
AADD(aFields,{"OPCSHOW","C",LEN(CZJ->CZJ_OPCORD),0})
AADD(aFields,{"REVISAO","C",4,0})
AADD(aFields,{"REVSHOW","C",4,0})
AADD(aFields,{"MRP","C",6,0}) //TREXG3

For nInd := 1 to Len(aPeriodos)
    AADD(aFields,{"PER"+StrZero(nInd,3),"N",aTamQuant[1],aTamQuant[2]})
Next nInd

aStruct := {aFields, aIndex}
      
//Cria o arquivo 
oTabela := SFCCriFWTa(aStruct)
cAliasTab := oTabela:getAlias()

cQuery := " SELECT CZJ.CZJ_PROD, " +;
                 " CZJ.CZJ_OPCORD, " +;
                 " CZJ.CZJ_NRRV, " +;
                 " CZJ.CZJ_NRMRP, " +; //TREXG3
                 " CZK.CZK_PERMRP, " +;
                 " CZK.CZK_QTSLES, " +;
                 " CZK.CZK_QTENTR, " +;
                 " CZK.CZK_QTSAID, " +;
                 " CZK.CZK_QTSEST, " +;
                 " CZK.CZK_QTSALD, " +;
                 " CZK.CZK_QTNECE " +;
            " FROM " + RetSqlName("CZJ") + " CZJ, " +;
                       RetSqlName("CZK") + " CZK " +;
           " WHERE CZJ.CZJ_FILIAL   = '" + xFilial("CZJ") + "' " +; 
             " AND CZK.CZK_FILIAL   = '" + xFilial("CZK") + "' " +;
             " AND CZJ.R_E_C_N_O_   = CZK.CZK_RGCZJ " +;
           " ORDER BY CZJ.CZJ_PROD, " +;
                    " CZJ.CZJ_OPCORD, " +;
                    " CZJ.CZJ_NRRV, " +;
                    " CZK.CZK_PERMRP "

cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTop,.T.,.T.)
dbSelectArea(cAliasTop)

While !Eof()
    nInd := VAL((cAliasTop)->CZK_PERMRP)
    
    //Se mudar o item, grava novo registro
    If cProdAnt # (cAliasTop)->CZJ_PROD .Or. cOpcAnt # (cAliasTop)->CZJ_OPCORD .Or. cRevAnt # (cAliasTop)->CZJ_NRRV
        cProdAnt     := (cAliasTop)->CZJ_PROD
        cOpcAnt      := (cAliasTop)->CZJ_OPCORD
        cRevAnt      := (cAliasTop)->CZJ_NRRV
        aRecNo        := {}
                
        //Grava Saldo inicial
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '1'
        (cAliasTab)->TEXTO      := STR0028
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->PRODSHOW := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->OPCSHOW     := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->REVSHOW  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->MRP          := (cAliasTop)->CZJ_NRMRP //TREXG3
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSLES
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
        
        //Grava Entradas
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '2'
        (cAliasTab)->TEXTO := STR0029
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTENTR
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
        
        //Grava Saida
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '3'
        (cAliasTab)->TEXTO := STR0030
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSAID
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
         
        //Grava Saida por estrutura
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '4'
        (cAliasTab)->TEXTO := STR0031
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSEST
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
        
        //Grava Saldo final
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '5'
        (cAliasTab)->TEXTO := STR0032
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSALD
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
        
        //Grava Necessidades
        RecLock(cAliasTab,.T.)
        (cAliasTab)->TIPO      := '6'
        (cAliasTab)->TEXTO := STR0009
        (cAliasTab)->PRODUTO  := (cAliasTop)->CZJ_PROD
        (cAliasTab)->OPCIONAL := (cAliasTop)->CZJ_OPCORD
        (cAliasTab)->REVISAO  := (cAliasTop)->CZJ_NRRV
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTNECE
        MsUnLock(cAliasTab)
        
        AADD(aRecNo,{(cAliasTab)->(RecNo())})
    Else
        dbSelectArea(cAliasTab)
        (cAliasTab)->(dbGoTo(aRecNo[1][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSLES
        MsUnLock(cAliasTab)
        
        (cAliasTab)->(dbGoTo(aRecNo[2][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTENTR
        MsUnLock(cAliasTab)
        
        (cAliasTab)->(dbGoTo(aRecNo[3][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSAID
        MsUnLock(cAliasTab)
        
        (cAliasTab)->(dbGoTo(aRecNo[4][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSEST
        MsUnLock(cAliasTab)
        
        (cAliasTab)->(dbGoTo(aRecNo[5][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTSALD
        MsUnLock(cAliasTab)
        
        (cAliasTab)->(dbGoTo(aRecNo[6][1]))
        
        RecLock(cAliasTab,.F.)
        (cAliasTab)->&("PER"+StrZero(nInd,3)) := (cAliasTop)->CZK_QTNECE
        MsUnLock(cAliasTab)
    EndIf
    
    dbSelectArea(cAliasTop)
    dbSkip()
End

(cAliasTab)->(DbGoTop())

(cAliasTop)->(dbCloseArea())

//Autaliza LOG
ProcLogAtu("MENSAGEM","Fim montagem arquivo de trabalho","Fim montagem arquivo de trabalho")

Return cAliasTab

/*------------------------------------------------------------------------//
//Programa:	MATR882R3 
//Autor:		Rodrigo de A Sartorio
//Data:		02/09/02
//Descricao:	MRP
//Uso: 		MATR882
//------------------------------------------------------------------------*/
User Function MATR882R3(lUsed)
Local titulo 		:= STR0001  // "MRP"
Local wnrel   	:= "MATR882"
Local tamanho 	:= "M"
Local cString 	:= "SB1"
Local cDesc   	:= STR0002  //"Este programa ira imprimir a Rela‡„o do MRP"
Local cProdIni	:= ""
Local cProdFim	:= ""
Local lLogMrp		:= .F.
Local lVNecesEst	:= 0
Local lContinua	:= .T.
Local nParRel		:= 0

Local aArea   	:= GetArea()

Private aReturn     := {STR0003,1,STR0004, 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private nLastKey    := 0
Private cPerg       := "MATR882"
Private nTipoCusto  := 1
Private nPeriodos   := 0

Default lUsed := .F.

//Verifica as perguntas selecionadas                                     
// Variaveis utilizadas para parametros                                    
// mv_par01 - Lista ? Tudo     So' c/ Saidas   So' c/ Neces.               
// mv_par02 - De Produto                                                   
// mv_par03 - Ate Produto                                                  
// mv_par04 - Lista log de eventos  1 = sim 2 = nao                        
// mv_par05 - Custo Produto: 1-Custo Standard;2-Custo Medio;3-Preco Compra 
// mv_par06 - Aglutina Periodos     1 = sim 2 = nao                        
// mv_par07 - Periodos para aglutina                                       
// mv_par08 - Lista a Necess. da Estrutura? 1 = sim 2 = nao                

Pergunte(cPerg,.F.)

wnrel       := SetPrint(cString,wnrel,cPerg,@titulo,cDesc,"","",.F.,"",,Tamanho)
nParRel     := mv_par01
cProdIni    := mv_par02
cProdFim    := mv_par03
lLogMrp     := mv_par04==1
nTipoCusto  := mv_par05
lQuebraPer  := mv_par06 == 1
nNumPer     := mv_par07
lVNecesEst  := mv_par08 ==1

If nLastKey = 27
	dbClearFilter()
	lContinua := .F.
EndIf

If lContinua
	SetDefault(aReturn,cString)
EndIf

If lContinua .And. nLastKey = 27
	dbClearFilter()
	lContinua := .F.
EndIf

If lContinua
	RptStatus({|lEnd| R882Imp(@lEnd,wnRel,titulo,tamanho,lUsed,nParRel,cProdIni,cProdFim,lLogMrp,lVNecesEst)},titulo)
EndIf

RestArea(aArea)
Return NIL

/*------------------------------------------------------------------------//
//Programa:	R882Imp 
//Autor:		Rodrigo de A Sartorio
//Data:		02/09/02
//Descricao:	Chamada do Relat¢rio 
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function R882Imp(lEnd,wnRel,titulo,tamanho,lUsed,nParRel,cProdIni,cProdFim,lLogMrp,lVNecesEst)
Local i			:= 0
Local j			:= 0
Local nTotLin		:= 0
Local nTotProd  	:= 0
Local nTipo     	:= 0
Local nNecEstr  	:= 0
Local nCusto    	:= 0
Local nQtdPer   	:= 0
Local nC        	:= 0

Local nomeprog  	:= "MATR882"
Local CbTxt		:= ""
Local CbCont		:= ""
Local cSeekLog	:= ""
Local cNecEstrAtu	:= ""
Local cAliasCZJ 	:= ""
Local cCondSH5  	:= "CZI_PROD != '"+Criavar("B1_COD",.F.)+"'"

Local aPerOri   	:= {}
Local aNeces    	:= {}
Local aListaNec 	:= {}
Local aOrdem    	:= Array(6)

Local lLista		:= .F.
Local lImprimiu	:= .F.
Local lContinua 	:= .T.

Private aPerQuebra := {}
Private aPeriodos := {}

aOrdem[1] := STR0005
aOrdem[2] := STR0006
aOrdem[3] := STR0007
aOrdem[4] := STR0017
aOrdem[5] := STR0008
aOrdem[6] := STR0009

//Variaveis utilizadas para Impressao do Cabecalho e Rodape    
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

//Monta os Cabecalhos                                          
If lUsed != .T.
	lContinua := MATA712LCK()
EndIf

If lContinua
	dbSelectArea("CZI")
	If !Empty(dbFilter())
		dbClearFilter()
	EndIf
	
	dbSetOrder(1)
	dbGotop()
	
	dbSelectArea("SHG")
	dbSetOrder(1)
	
	aPeriodos := R882PER(@nTipo)
	If nParRel == 1
		cAliasCZJ := U_MTA712MVW2()
	Else
		cAliasCZJ := MATA712MVW()
	EndIf
	
	If lQuebraPer
		aPerOri    := aClone(aPeriodos)
		aPerQuebra := U_R882DivPeriodo(aPeriodos, .T.)
		aPeriodos  := U_R882DivPeriodo(aPeriodos)
	EndIf
	
	dbSelectArea("CZI")
	Set Filter to &cCondSH5
EndIf	

If lContinua
	dbSelectArea(cAliasCZJ)
	dbGoTop()
	//dbSetOrder(1)
	//dbSeek(xFilial("CZJ"))
	SetRegua(LastRec())
	Titulo  := Titulo+" - "+STR0018+" "+CZI->CZI_NRMRP
	NTotLin := Len(aPeriodos) / 5
	nTotLin := If(Len(aPeriodos) % 6 > 0,++nTotLin,nTotLin)
	While !Eof() //.And. CZJ->CZJ_FILIAL == xFilial("CZJ")
		If lEnd
			@ Prow()+1,001 PSay STR0011	//"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		IncRegua()
		nRec := Recno()
		cSeekLog  := CZJ->CZJ_NRMRP+(cAliasCZJ)->PRODUTO
		lImprimiu := .F.
		
		If (cAliasCZJ)->PRODUTO >= cProdIni .And. (cAliasCZJ)->PRODUTO <= cProdFim .And. SB1->(dbSeek(xFilial("SB1")+(cAliasCZJ)->PRODUTO))
			If li > 50
				cabec(titulo,"","",nomeprog,tamanho,18)
				@ li,00 PSay __PrtFatLine()
				li++
			EndIf
			lLista		:= R882FILTRO(nParRel,nTipo,cAliasCZJ)
			lImprimiu	:= .f.
			If lLista
				nTotProd	:= 0
				lImprimiu	:= .t.
				nCusto		:= U_R882Custo(SB1->B1_COD)
				@ li,00 PSay STR0012 +SB1->B1_COD +SPACE(3) + Substr(SB1->B1_DESC,1,30) + SPACE(3) +STR0013;	//"PRODUTO: "###"UM:"
				+ SB1->B1_UM + SPACE(3)+STR0014 + Str(RetFldProd(SB1->B1_COD,"B1_LE"), Posicione("SX3", 2, "B1_LE", "X3_TAMANHO"), Posicione("SX3", 2, "B1_LE", "X3_DECIMAL")) + SPACE(3) + Upper(AllTrim(RetTitle("B1_ESTSEG"))) + ": " + Str(RetFldProd(SB1->B1_COD,"B1_ESTSEG"), Posicione("SX3", 2, "B1_ESTSEG", "X3_TAMANHO"), Posicione("SX3", 2, "B1_ESTSEG", "X3_DECIMAL")) + SPACE(3) + Upper(AllTrim(RetTitle("B1_EMIN"))) + ": " + Str(RetFldProd(SB1->B1_COD,"B1_EMIN"), Posicione("SX3", 2, "B1_EMIN", "X3_TAMANHO"), Posicione("SX3", 2, "B1_EMIN", "X3_DECIMAL")) + Space(3) + STR0015+ SB1->B1_TIPO	//"LOTE ECON: "### "TIPO: "
				li++
				dbSelectArea(cAliasCZJ)
				nPerIni := 1
				While .t.
					dbGoto(nRec)
					nCol := 23
					li++
					// ---- Imprime Periodos
					@ li,00 PSay STR0016  //"Periodos"
					If lQuebraPer .And. nNumPer > 1
						@ li,10 PSay STR0024  //"(inicial)"
					EndIf
					For i:= nPerIni to nPerIni+5
						If i > Len(aPeriodos)
							Exit
						EndIf
						@ li,nCol PSay DtoC(aPeriodos[i])
						nCol += 15
					Next i
					// ---- Se Aglutina em mais de 1 periodo, Imprime data final do periodo
					If lQuebraPer .And. nNumPer > 1
						nCol := 23
						li++
						@ li,10 PSay STR0025  //"(final)"
						For i:= nPerIni to nPerIni+5
							If i > Len(aPeriodos)
								Exit
							EndIf
							// ---- Calcula posicao no array de periodos
							// ---- = (coluna-1)*nro.periodos p/ aglutinar+len(array periodos aglutinados)
							nC := (i-1)*nNumPer+Len(aPerQuebra[i,2])
							@ li,nCol PSay DtoC(aPerOri[nC])
							nCol += 15
						Next i
					EndIf
					// ----
					li += 2
					aNeces := {}
					For i := 1 to 6
						nCol := 16
						@ li,00 PSay aOrdem[i]
						For j := nPerIni to nPerIni+5
							If j > Len(aPeriodos)
								Exit
							EndIf
	
							@ li,nCol PSay nQtdPer := U_R882ValField(j,cAliasCZJ) Picture "999999999999.99"
							nCol+=15
							If i == 6
								aAdd(aNeces, nQtdPer)
								nTotProd+=nQtdPer
							EndIf
						Next
						(cAliasCZJ)->(dbSkip())
						li++
					Next
	
					nCol := 16
					@ li,00 PSay STR0020 // "Valor"
					For j := 1 to Len(aNeces)
						@ li,nCol PSay aNeces[j] * nCusto Picture "999999999999.99"
						nCol+=15
					Next
	
					//Lista a necessidade da estrutura do produto possicionado a partir da tabela CZI com CZI_ALIAS igual a CZJ.                               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If lVNecesEst
						//Reposiciono no produto
						DbSelectArea(cAliasCZJ)
						DbGoto(nRec)
						aListaNec := R882LstNec(xFilial("CZI")+(cAliasCZJ)->PRODUTO+"CZJ",aPeriodos,nPerIni)
						If !Empty(aListaNec)
							li+=2
							@ li,00 PSay STR0022
							cNecEstrAtu := ""
							For i:=1 To Len(aListaNec)
								If cNecEstrAtu<>aListaNec[i,1] .Or. !lQuebraPer
									cNecEstrAtu := aListaNec[i,1]
									li++
								EndIf
								@ li,000 PSay aListaNec[i,1]
								nCol := 16
								For j := nPerIni to nPerIni+5
									If j > Len(aPeriodos)
										Exit
									EndIf
									nNecEstr := 0
									If aPeriodos[j]==aListaNec[i,3]
										nNecEstr := aListaNec[i,2]
									EndIf
									@ li,nCol PSay nNecEstr Picture "999999999999.99"
									nCol+=15
								Next
	
								If li > 60
									cabec(titulo,"","",nomeprog,tamanho,18)
									@ li,00 PSay __PrtFatLine()
									li++
								EndIf
							Next
							li++
						EndIf
					EndIf
					nPerIni+=6
					If nPerIni > Len(aPeriodos)
						Exit
					EndIf
					If li > 50
						cabec(titulo,"","",nomeprog,tamanho,18)
						@ li,00 PSay __PrtFatLine()
						li++
					EndIf
					li++
				Enddo
				li+= 2
	
				nCol := 16
				@ li,00 PSay STR0021	//"Tot Vl. Produto:"
				@ li,nCol PSay nTotProd * nCusto Picture "999999999999.99"
	
				li+= 2
				nTotProd := 0
			EndIf
	
			// Lista os eventos de log desse produto
			If lLogMrp
				dbSelectArea("SHG")
				If dbSeek(xFilial("SHG")+cSeekLog)
					If li > 50
						cabec(titulo,"","",nomeprog,tamanho,18)
					EndIf
					@ li,00 PSay OemToAnsi(STR0019) //"Eventos relacionados ao produto"
					li++
					li++
					While !EOF() .AND. xFilial("SHG")+cSeekLog == HG_FILIAL+HG_SEQMRP+HG_COD
						If li > 50
							cabec(titulo,"","",nomeprog,tamanho,18)
						EndIf
						@ li,00 PSay HG_LOGMRP
						li++
						dbSkip()
					End
					li++
				EndIf
			EndIf
			dbSelectArea(cAliasCZJ)
		EndIf
		DbGoto(nRec)
		DbSkip(6)
		If lImprimiu
			@ li,00 PSay __PrtThinLine()
			li++
		EndIf
	End
	
	If li != 80
		roda(cbcont,cbtxt)
	EndIf

EndIf	
If (lContinua = .T.) .And. (lUsed != .T.)
	dbSelectArea(cAliasCZJ)
	dbCloseArea()
	dbSelectArea("CZI")
	dbCloseArea()
EndIf
dbSelectArea("SB1")
dbClearFilter()
dbSetOrder(1)
If aReturn[5] = 1
	Set Printer TO
	Commit
	ourspool(wnrel)
EndIf
MS_FLUSH()
Return NIL

/*------------------------------------------------------------------------//
//Programa:	R882Per 
//Autor:		Rodrigo de A Sartorio
//Data:		03/02/97
//Descricao:	Rotina de montagem de array aperiodos para Impressao
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function R882PER(nTipo)
Local aAreaCZI    := CZI->(GetArea())
Local aRet        := {}
Local cForAno     := ""
Local dInicio     := Nil
Local lConsSabDom := Nil
Local nI          := 0
Local nPosAno     := 0
Local nTamAno     := 0

Pergunte("MTA712",.F.)
lConsSabDom := mv_par12 == 1
Pergunte(cPerg, .F.)

If __SetCentury()
	nPosAno := 1
	nTamAno := 4
	cForAno := "ddmmyyyy"
Else
	nPosAno := 3
	nTamAno := 2
	cForAno := "ddmmyy"
EndIf

//Adiciona registro em array totalizador utilizado no TREE  
dbSelectArea("CZI")
CZI->(dbSetOrder(1))
If CZI->(DbSeek(xFilial("CZI")))
	While CZI->(!Eof()) .And. xFilial("CZI") == CZI->CZI_FILIAL
		// Recupera parametrizacao gravada no ultimo processamento
		// A T E N C A O
		// Quando utilizado o processamento por periodos variaveis o sistema monta o array com
		// os periodos de maneira desordenada, por causa do indice do arquivo SH5
		// O array aRet é corrigido logo abaixo
		If CZI->CZI_ALIAS == "PAR"
			nTipo       := CZI->CZI_NRRGAL
			dInicio     := CZI->CZI_DTOG
			nPeriodos   := CZI->CZI_QUANT
			If nTipo == 7
				AADD(aRet,DTOS(CTOD(Alltrim(CZI->CZI_OPCORD))))
			EndIf
			//NUMERO DO MRP                                                ³
			c711NumMRP := CZI_NRMRP
		EndIf
		CZI->(dbSkip())
	End
EndIf

//Somente para nTipo==7 (Periodos Diversos) re-ordena aRet
//pois como o H5_OPC esta gravado a data como caracter ex:(09/10/05)
//o arquivo esta indexado incorretamente (diferente de 20051009)
If !Empty(aRet)
	ASort(aRet)
	For nI:=1 To Len(aRet)
		aRet[nI] := STOD(aRet[nI])
	Next nI
EndIf

If (nTipo == 2)                         // Semanal
	While Dow(dInicio)!=2
		dInicio--
	EndDo
ElseIf (nTipo == 3) .or. (nTipo=4)      // Quinzenal ou Mensal
		dInicio:= CtoD("01/"+Substr(DtoS(dInicio),5,2)+Substr(DtoC(dInicio),6),cForAno)
ElseIf (nTipo == 5)                     // Trimestral
	If Month(dInicio) < 4
		dInicio := CtoD("01/01/"+Substr(DtoC(dInicio),7),cForAno)
	ElseIf (Month(dInicio) >= 4) .and. (Month(dInicio) < 7)
		dInicio := CtoD("01/04/"+Substr(DtoC(dInicio),7),cForAno)
	ElseIf (Month(dInicio) >= 7) .and. (Month(dInicio) < 10)
		dInicio := CtoD("01/07/"+Substr(DtoC(dInicio),7),cForAno)
	ElseIf (Month(dInicio) >=10)
		dInicio := CtoD("01/10/"+Substr(DtoC(dInicio),7),cForAno)
	EndIf
ElseIf (nTipo == 6)                     // Semestral
	If Month(dInicio) <= 6
		dInicio := CtoD("01/01/"+Substr(DtoC(dInicio),7),cForAno)
	Else
		dInicio := CtoD("01/07/"+Substr(DtoC(dInicio),7),cForAno)
	EndIf
EndIf

If nTipo != 7
	For nI := 1 to nPeriodos
		AADD(aRet,dInicio)
		If nTipo == 1
			dInicio ++
			While !lConsSabDom .And. ( DOW(dInicio) == 1 .or. DOW(dInicio) == 7 )
				dInicio++
			EndDo
		ElseIf nTipo == 2
			dInicio+=7
		ElseIf nTipo == 3
			dInicio := StoD(If(Substr(DtoS(dInicio),7,2)<"15",Substr(DtoS(dInicio),1,6)+"15",;
	 		If(Month(dInicio)+1<=12,Str(Year(dInicio),4)+StrZero(Month(dInicio)+1,2)+"01",;
			Str(Year(dInicio)+1,4)+"0101")),cForAno)			
		ElseIf nTipo == 4
			dInicio := CtoD("01/"+If(Month(dInicio)+1<=12,StrZero(Month(dInicio)+1,2)+;
			"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		ElseIf nTipo == 5
			dInicio := CtoD("01/"+If(Month(dInicio)+3<=12,StrZero(Month(dInicio)+3,2)+;
			"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		ElseIf nTipo == 6
			dInicio := CtoD("01/"+If(Month(dInicio)+6<=12,StrZero(Month(dInicio)+6,2)+;
			"/"+Substr(Str(Year(dInicio),4),nPosAno,nTamAno),"01/"+Substr(Str(Year(dInicio)+1,4),nPosAno,nTamAno)),cForAno)
		EndIf
	Next nI
EndIf

RestArea(aAreaCZI)
Return aRet

/*------------------------------------------------------------------------//
//Programa:	R882FILTRO 
//Autor:	Rodrigo de A Sartorio
//Data:		03/02/97
//Descricao:Filtra período
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function R882FILTRO(nParRel,nTipo,cAliasCZJ)
Local ni		:= 0
Local lRet 		:= .F.
Local aArea 	:= GetArea()
Local nReg		:= 0

dbSelectArea(cAliasCZJ)
nReg := Recno()

If nParRel == 1
	lRet := .T.
ElseIf nParRel == 2
	dbSkip(2)
	For ni := 1 to nPeriodos
		cCampo := "PER"+StrZero(ni,3)
		If &(cCampo) != 0
			lRet := .t.
			Exit
		EndIf
	Next
	If !lRet
		dbSkip()
		For ni := 1 to nPeriodos
			cCampo := "PER"+StrZero(ni,3)
			If &(cCampo) != 0
				lRet := .t.
				Exit
			EndIf
		Next
	EndIf
ElseIf nParRel == 3
	dbSkip(5)
	For ni := 1 to nPeriodos
		cCampo := "PER"+StrZero(ni,3)
		If &(cCampo) != 0
			lRet := .t.
			Exit
		EndIf
	Next
EndIf

dbGoto(nReg)
RestArea(aArea)

Return (lRet)

/*------------------------------------------------------------------------//
//Programa:	R882Custo 
//Autor:		Marcelo Iuspa 
//Data:		05/01/05 
//Descricao:	Retorna o custo do produto informado baseado na opcao do pergunte (mv_par05):
//				Custo Produto: 1-Custo Standard;2-Custo Medio;3-Preco Compra
//Uso: 		MATR882
//------------------------------------------------------------------------*/
User Function R882Custo(cProd)
Local nCusto := 0

SB1->(MsSeek(xFilial("SB1") + cProd))
If nTipoCusto == 1
	nCusto := RetFldProd(SB1->B1_COD,"B1_CUSTD")
	cStr:="1"
ElseIf nTipoCusto == 2
	nCusto := PegaCmAtu(cProd, RetFldProd(SB1->B1_COD,"B1_LOCPAD"))[1]
	cStr:="2"
ElseIf nTipoCusto == 3
	nCusto := RetFldProd(SB1->B1_COD,"B1_UPRC")
	cStr:="3"
EndIf

Return(nCusto)

/*------------------------------------------------------------------------//
//Programa:	R882DivPeriodo 
//Autor:		Marcelo Iuspa 
//Data:		18/01/05
//Descricao:	Retorna o array de periodos aglutinados conforme parametro
//Uso: 		MATR882
//------------------------------------------------------------------------*/
User Function R882DivPeriodo(aPeriodos, lRetQuebra)
Local nLenArr := Len(aPeriodos)
Local nLoop   := Nil
Local nAglut  := 1
Local aRetPer := {aPeriodos[1]}
Local aQuebra := {{1, {1}}}

Default lRetQuebra := .F.

For nLoop := 2 to nLenArr
	If nAglut >= nNumPer
		Aadd(aRetPer, aPeriodos[nLoop])
		Aadd(aQuebra, {Len(aQuebra)+1, {}})
		nAglut := 1
	Else
		nAglut ++
	EndIf
	Aadd(aQuebra[Len(aQuebra), 2], nLoop)
Next

Return(If(lRetQuebra, aQuebra, aRetPer))

/*------------------------------------------------------------------------//
//Programa:	R882ValField 
//Autor:		Marcelo Iuspa 
//Data:		18/01/05
//Descricao:	Retorna o array de periodos aglutinados conforme parametro
//Uso: 		MATR882
//------------------------------------------------------------------------*/
User Function R882ValField(nPeriodo,cAliasCZJ)
Local nRet  := 0
Local nLoop := 0
Local aPer  := Nil

If ! lQuebraPer
	nRet := (cAliasCZJ)->(FieldGet(FieldPos("PER" + StrZero(nPeriodo, 3))))
Else
	aPer := aPerQuebra[nPeriodo, 2]
	For nLoop := 1 to Len(aPer)
		nRet += (cAliasCZJ)->(FieldGet(FieldPos("PER" + StrZero(aPer[nLoop], 3))))
		If (cAliasCZJ)->TIPO == "1"
			Exit
		ElseIf (cAliasCZJ)->TIPO == "5"
			nRet := (cAliasCZJ)->(FieldGet(FieldPos("PER" + StrZero(aPer[nLoop], 3))))
		EndIf
	Next
EndIf
Return(nRet)

/*------------------------------------------------------------------------//
//Programa:	R882LstNec 
//Autor:		Erike Y. da Silva
//Data:		09/05/05
//Descricao:	Lista a estrutura da necessidade do produto    
//Uso: 		MATR882
//------------------------------------------------------------------------*/
Static Function R882LstNec(cChave,aPeriodos,nPerIni)
Local nPos			:= 0
Local nI			:= 0
Local nTamPer   	:= Len(aPeriodos)
Local lContinua 	:= .F.
Local aLista    	:= {}
Local cAlias    	:= Alias()
Local aAreaSH5  	:= CZI->(GetArea())

DbSelectArea("CZI")
CZI->(dbSetOrder(3))
CZI->(dbSeek(cChave))

While CZI->(!Eof() .AND. CZI_PROD+CZI_ALIAS==cChave)
	lContinua := .F.
	For nI:=nPerIni To nPerIni+5
		If nI> nTamPer
			Exit
		EndIf
		If aPeriodos[nI]==CZI->CZI_DTOG
			lContinua := .T.
			Exit
		EndIf
	Next

	If !lContinua
		CZI->(DbSkip())
		Loop
	EndIf

	nPos := AsCan(aLista,{|x|x[1]==CZI->CZI_DOC .and. x[3]==CZI->CZI_DTOG})
	If Empty(nPos) .Or. !lQuebraPer
		SB1->(MsSeek(xFilial("SB1") + CZI->CZI_DOC))
		Aadd(aLista,{CZI->CZI_DOC,CZI->CZI_QUANT,CZI->CZI_DTOG})
	Else
		aLista[nPos,2] += CZI->CZI_QUANT
	EndIf
	CZI->(DbSkip())
EndDo

If !Empty(aLista)
	aLista := aSort(aLista,,,{|x,y|x[1]<y[1]})
EndIf

RestArea(aAreaSH5)           
DbSelectArea(cAlias)

Return aClone(aLista)
