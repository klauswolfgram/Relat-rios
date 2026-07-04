/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER010.CH"
#Include "PROTHEUS.CH"
#Include "report.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQIER010   บAutor  ณTelso Carneiro      บ Data ณ  30/05/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio Da Amarracao Produto X Fornecedor                บฑฑ
ฑฑบ          ณ (Versao Relatorio Personalizavel)                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function QIER010()
Local oReport	

Pergunte("QER010 ",.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return


Static Function ReportDef()
Local cTitulo	:= OemToAnsi(STR0003) //"Amarracao Produto x Fornecedor"
Local cDesc1 	:= OemToAnsi(STR0001) //"Serao relacionados os Fornecedores com seus "
Local cDesc2 	:= OemToAnsi(STR0002) //"respectivos Produtos."
Local wnrel  	:= "QIER010"
Local cPerg   	:= "QER010 "
Local oReport
Local oSection1 
Local oSection2 
Private cAliasSA5	:="SA5"
Private cAliasQF4	:="QF4"

DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection1 OF oReport TITLE TITSX3("A5_FORNECE")[1] TABLES "SA5","SA2"

DEFINE CELL NAME "A5_FORNECE"  OF oSection1 ALIAS "SA5"
DEFINE CELL NAME "A5_LOJA"     OF oSection1 ALIAS "SA5"
DEFINE CELL NAME "A2_NOME"     OF oSection1 ALIAS "SA2" BLOCK {|| POSICIONE("SA2",1,xFilial("SA2")+(cAliasSA5)->A5_FORNECE+(cAliasSA5)->A5_LOJA,"A2_NOME") }

DEFINE SECTION oSection2 OF oSection1 TITLE TITSX3("A5_PRODUTO")[1] TABLES "SA5","QE6"

DEFINE CELL NAME "A5_PRODUTO"  	OF oSection2 ALIAS "SA5"   BLOCK {|| (cAliasSA5)->A5_PRODUTO+" "+POSICIONE("QE6",1, xFilial("QE6")+(cAliasSA5)->A5_PRODUTO,"QE6_DESCPO") }
DEFINE CELL NAME "A5_SITU"  	OF oSection2 ALIAS "SA5"   BLOCK {|| POSICIONE("QEG",1,xFilial("QEG")+(cAliasSA5)->A5_SITU,"QEG_NIVEL") }
DEFINE CELL NAME "A5_SKPLOT"  	OF oSection2 ALIAS "SA5" SIZE 36 BLOCK {|| POSICIONE("QEF",1,xFilial("QEF")+(cAliasSA5)->A5_SKPLOT,"QEF_DESCRI") }
DEFINE CELL NAME "A5_RIAI"  	OF oSection2 ALIAS "SA5"
DEFINE CELL NAME "A5_VALRIAI"  	OF oSection2 ALIAS "SA5"
DEFINE CELL NAME "A5_CODPRF"  	OF oSection2 ALIAS "SA5"
DEFINE CELL NAME "A5_FABREV"  	OF oSection2 ALIAS "SA5" BLOCK{|| Iif(!Empty((cAliasSA5)->A5_FABREV),Iif((cAliasSA5)->A5_FABREV=='F',STR0010,Iif((cAliasSA5)->A5_FABREV=='R',STR0011,STR0012)),"")} //"FABRIC. "###"REVEND. "###"PERMUTA "
																  

DEFINE CELL NAME "A5_TEMPLIM"  	OF oSection2 ALIAS "SA5"       

DEFINE SECTION oSection3 OF oSection2 TITLE TITSX3("QF4_ENSAIO")[1] TABLES "QF4"

DEFINE CELL NAME "QF4_ENSAIO"  	OF oSection3 ALIAS "QF4"                   
DEFINE CELL NAME "cPlano"  		OF oSection3 ALIAS "QF4" TITLE OemToAnsi(STR0014) BLOCK {|| QA_Plano((cAliasQF4)->QF4_TIPAMO,.T.) } //"DESCR.PL. AMOSTRAGEM"
DEFINE CELL NAME "QF4_PLAMO"  	OF oSection3 ALIAS "QF4" 
DEFINE CELL NAME "QF4_NQA"  	OF oSection3 ALIAS "QF4"
DEFINE CELL NAME "QF4_NIVEL"  	OF oSection3 ALIAS "QF4"
                                                             
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrinบAutor  ณTelso Carneiro      บ Data ณ  19/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Personalizavel                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณU_QIER010()                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                  
Static Function PrintReport(oReport) 
cAliasSA5	:= "SA5"
cAliasQF4	:= "QF4"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFiltragem do relat๓rio                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณTransforma parametros Range em expressao SQL                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MakeSqlExpr(oReport:uParam) 
	
BEGIN REPORT QUERY oReport:Section(1)

cAliasSA5 := GetNextAlias()

BeginSql Alias cAliasSA5

SELECT SA5.A5_FILIAL,SA5.A5_FORNECE,SA5.A5_LOJA,SA5.A5_PRODUTO,SA5.A5_SITU,SA5.A5_SKPLOT,
	SA5.A5_RIAI,SA5.A5_VALRIAI,SA5.A5_CODPRF,SA5.A5_FABREV,SA5.A5_TEMPLIM
 	
 	FROM %table:SA5% SA5 
	WHERE SA5.A5_FILIAL = %xFilial:SA5% AND 
		SA5.A5_FORNECE BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		SA5.%notDel%  		                

ORDER BY A5_FILIAL,A5_FORNECE,A5_LOJA,A5_PRODUTO
		
EndSql 
END REPORT QUERY oReport:Section(1)

oReport:Section(1):Section(1):SetParentQuery()	
oReport:Section(1):Section(1):SetParentFilter( { |cParam| (cAliasSA5)->A5_FILIAL+(cAliasSA5)->A5_FORNECE+(cAliasSA5)->A5_LOJA == cParam },{ || (cAliasSA5)->A5_FILIAL+(cAliasSA5)->A5_FORNECE+(cAliasSA5)->A5_LOJA })

BEGIN REPORT QUERY oReport:Section(1):Section(1):Section(1)

cAliasQF4 := GetNextAlias()

BeginSql Alias cAliasQF4

SELECT QF4.QF4_FILIAL,QF4.QF4_PRODUT,QF4.QF4_ENSAIO,QF4.QF4_TIPAMO,QF4.QF4_PLAMO,QF4.QF4_NQA,QF4.QF4_NIVEL
 	
 	FROM %table:QF4% QF4 	
	WHERE QF4.QF4_FILIAL = %xFilial:QF4% AND 
		QF4.QF4_FORNEC = %Report_Param:(cAliasSA5)->A5_FORNECE% AND
		QF4.QF4_LOJFOR = %Report_Param:(cAliasSA5)->A5_LOJA% AND
		QF4.QF4_PRODUT = %Report_Param:(cAliasSA5)->A5_PRODUTO% AND
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณSubSelect para garantir a ultima revisao do QE6   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู		
		QF4.QF4_REVI = ( SELECT  MAX(QE6.QE6_REVI) FROM  %table:QE6% QE6
								WHERE QE6.QE6_FILIAL = %xFilial:QE6%   AND
								 QE6.QE6_PRODUT =  QF4.QF4_PRODUT  AND  
								 QE6.QE6_SITREV = '0' AND
								 QE6.QE6_DTINI <= %exp:DTOS(dDatabase)% AND
								 QE6.%notDel%)  AND
		QF4.%notDel%  		                
    ORDER BY QF4_FILIAL,QF4_FORNEC,QF4_LOJFOR,QF4_PRODUT,QF4_REVI,QF4_ENSAIO
		
EndSql 
END REPORT QUERY oReport:Section(1):Section(1):Section(1)

oReport:Section(1):Section(1):Section(1):SetParentFilter( { |cParam| (cAliasQF4)->QF4_PRODUT == cParam },{ || (cAliasSA5)->A5_PRODUTO })
TRPosition():New(oReport:Section(1):Section(1),"SA2", 1, {|| xFilial("SA2")+(cAliasSA5)->A5_FORNECE+(cAliasSA5)->A5_LOJA})
TRPosition():New(oReport:Section(1):Section(1):Section(1),"QE6", 1, {|| xFilial("QE6")+(cAliasQF4)->QF4_PRODUT})
                          

oReport:Section(1):Print()

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ A010RVFor  ณ Autor ณ Vera Lucia S. Simoes  ณ Data ณ 22/01/98 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Verifica se o Fornecedor e' valido                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ QIER010 - Chamada no X1_VALID na pergunte QER010.            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function A010RVFor(cPar)
Local lRet := .t.

If !Empty(cPar) .And. cPar <> Repl("Z",Len(cPar))
	SA2->(dbSetOrder(1))
   If ! SA2->(DbSeek(xFilial("SA2") + cPar))
      Help(" ",1,"A010FORINV")
      lRet := .f.
   EndIf
EndIf
Return(lRet)
