/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QIPR160.ch"
#INCLUDE "TOTVS.CH"              
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIPR160   ºAutor  ³Leandro Sabino      º Data ³  04/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relacao Das Ordens de Producao                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAQIP                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QIPR160()
Local cPerg   := "QPR160 "
Local oReport := ReportDef()

Private  __cPRODUTO := CriaVar("QP6_PRODUT") //Codigo do Produto, quando a Especificacao for em Grupo      
Private lProduto   := .F.

// Variaveis utilizadas para parametros                    
// mv_par01        	// Da OP                            
// mv_par02        	// Ate a OP                         
// mv_par03        	// Do Produto                       
// mv_par04        	// Ate o Produto                    
// mv_par05        	// Da data                          
// mv_par06        	// Ate a data                       
// mv_par07        	// 1-ENCERRADAS  2-SUSPENSAS 3-TODAS

	Pergunte(cPerg,.F.) 
    oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 04/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR160                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cTitulo1	:= STR0001 //"Relacao das Ordens de Producao Indisponiveis"
Local cDesc1	:= STR0002 //"Este programa ira imprimir a Rela‡„o das Ordens de Produ‡„o Indisponiveis."
Local nTamOp	:= ( TamSx3("C2_NUM")[1] + TamSx3("C2_ITEM")[1] + TamSx3("C2_SEQUEN")[1] )
Local cPerg     := "QPR160 "
Local oSection1 

DEFINE REPORT oReport NAME "QIPR160" TITLE cTitulo1 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)
oReport:SetPortrait(.T.)

DEFINE SECTION oSection1 OF oReport TABLES "SC2"  TITLE STR0010//Ordem de Producao
DEFINE CELL NAME "OP"         OF oSection1             TITLE OemToAnsi(STR0010) SIZE nTamOp //"Ordem de Produção"
DEFINE CELL NAME "C2_PRODUTO" OF oSection1 ALIAS "SC2"  
DEFINE CELL NAME "cDESCR"     OF oSection1 ALIAS "SC2" TITLE OemToAnsi(STR0008) SIZE 20 //"Descricao"
DEFINE CELL NAME "C2_QUANT"   OF oSection1 ALIAS "SC2"  
DEFINE CELL NAME "C2_EMISSAO" OF oSection1 ALIAS "SC2"  
DEFINE CELL NAME "cStatus"    OF oSection1 ALIAS "SC2" TITLE OemToAnsi(STR0009) SIZE 10//"STATUS da OP"

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 04/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao Das Ordens de Producao                       	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIPR160                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1	:= oReport:Section(1)
Local cAlias	:= "SC2"
Local cCond     := ""

Local cOrder := ""
Local cCondR4:= ""
                   
dbSelectArea("SC2")
dbSetOrder(1)


MakeSqlExpr(oReport:uParam)

	If Upper(TcGetDb()) $ "ORACLE,POSTGRES,DB2,INFORMIX"		// Sinal de concatencao nesses ambientes
		mv_par01 := StrTran( mv_par01, "C2_NUM", "C2_NUM||C2_ITEM||C2_SEQUEN" )
        Else
		mv_par01 := StrTran( mv_par01, "C2_NUM", "C2_NUM+C2_ITEM+C2_SEQUEN" )
	EndIf
	 	
    cOrder := "%C2_FILIAL,C2_NUM,C2_ITEM,C2_SEQUEN%"
	
	cAlias := GetNextAlias()

	BeginSQL Alias cAlias

	SELECT SC2.C2_FILIAL,SC2.C2_NUM,SC2.C2_ITEM,SC2.C2_SEQUEN,SC2.C2_PRODUTO,
	       SC2.C2_REVI,SC2.C2_ROTEIRO,SC2.C2_QUANT,SC2.C2_EMISSAO,SC2.C2_STATUS,
	       SC2.C2_DATRF,SC2.C2_QUJE,SC2.C2_PERDA
	
	FROM %table:SC2% SC2

	WHERE C2_FILIAL = %xFilial:SC2% 
	 	AND C2_NUM    >=%Exp:Substr(mv_par01,1,6)%
	 	AND C2_ITEM   >=%Exp:Substr(mv_par01,7,2)%
	    AND C2_SEQUEN >=%Exp:Substr(mv_par01,9,3)%
	
	    AND C2_NUM    <=%Exp:Substr(mv_par02,1,6)%
	    AND C2_ITEM   <=%Exp:Substr(mv_par02,7,2)%
		AND C2_SEQUEN <=%Exp:Substr(mv_par02,9,3)%
	
	 	AND C2_PRODUTO>=%Exp:mv_par03%
	 	AND C2_PRODUTO<=%Exp:mv_par04%
	
		AND C2_EMISSAO>=%Exp:Dtos(mv_par05)%
		AND C2_EMISSAO<=%Exp:Dtos(mv_par06)%
	
	    AND SC2.%notDel% 
	    
	    ORDER BY %Exp:cOrder%       
	    
	EndSql
    
		oSection1:EndQuery()
                    

oSection1:Init()

If !Empty(AllTrim(oSection1:GetSqlExp("SC2")))
	cCondR4 += oSection1:GetSqlExp("SC2")
EndIf

dbSelectArea(cAlias)
While !oReport:Cancel() .And. (cAlias)->(!Eof())	

	If !Empty(cCondR4)
		If !(cAlias)->(&(cCondR4))
			(cAlias)->(DbSkip())
			loop
		Endif
	Endif				

	
	cStatus := ""
	If mv_par07 == 1 //O.P.S ENCERRADAS
		cStatus := STR0006 //"Encerrada"
		If aSC2Sld() > 0 .And. Empty((cAlias)->C2_DATRF)
			(cAlias)->(dbSkip())
			Loop
		Endif
			
	ElseIf mv_par07	== 2 //O.P.S SUSPENSAS
		cStatus := STR0007 //"Suspensa"
		If (cAlias)->C2_STATUS <> "U"
			(cAlias)->(dbSkip())
			Loop
		Endif
	Else
		If (cAlias)->C2_STATUS == "U"
			cStatus := STR0007 //"Suspensa"
		Else
			If Empty((cAlias)->C2_DATRF)
				(cAlias)->(dbSkip())
				Loop
			EndIf	
			cStatus := STR0006 //"Encerrada"
		EndIf
	EndIf

	    
	cRevi := Iif(Empty((cAlias)->C2_REVI),Inverte(QA_UltRevEsp((cAlias)->C2_PRODUTO,,,,"QIP")),Inverte((cAlias)->C2_REVI))  
	oSection1:Cell("OP"):SetValue((cAlias)->(C2_NUM+C2_ITEM+C2_SEQUEN))
	oSection1:Cell("cDESCR"):SetValue(Posicione("QP6",1,xFilial("QP6")+(cAlias)->C2_PRODUTO+cRevi,"QP6_DESCPO")) 
	oSection1:Cell("cStatus"):SetValue(cStatus)
	oSection1:PrintLine()

	(cAlias)->(dbSkip())
	
EndDo

oSection1:Finish()

Return Nil
