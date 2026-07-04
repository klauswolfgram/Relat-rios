/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QNCR170.CH"
#INCLUDE "Protheus.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQNCR170   บAutor  ณLeandro             บ Data ณ  29/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de Etapas x FNC Analitico                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ                                                                ^
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QNCR170()
Local oReport
Local cPerg    := "QNC170    "

If !QNCHECK()
	Return .F.
Endif	

Pergunte(cPerg,.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return

Static Function ReportDef()
Local oReport
Local oSection1 
Local oSection2
Local oSection3
Local oTotal 
Local oBreak
Local cTitulo:= OemToAnsi(STR0001)//"Relatorio de Etapas x FNC Analitico"
Local cDesc1 := OemToAnsi(STR0002)//"Este relatorio imprime uma relaoSIG das etapas por produto"
Local wnrel  := "QNCR170"
Local cPerg  := "QNC170"         


DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)
oReport:SetLandscape(.T.)

DEFINE SECTION oSection1 OF oReport TITLE STR0012 /*LINE STYLE*/ TABLES "QI2","ADE" //"Modulo" - PAGE BREAK
DEFINE CELL NAME "QI2_CODPRO" OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_CODPRO")[1]+21
DEFINE CELL NAME "QI2_NCHAMA" OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_NCHAMA")[1]+15 CELL BREAK                                      
DEFINE CELL NAME "QI2_FNC"    OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_FNC")[1]+18                                   
DEFINE CELL NAME "QI2_REV"    OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_REV")[1]+14
DEFINE CELL NAME "QI3_CODIGO" OF oSection1 ALIAS "QI3"  SIZE TamSx3("QI3_CODIGO")[1]+15                                  
DEFINE CELL NAME "QI3_REV"    OF oSection1 ALIAS "QI3"  SIZE TamSx3("QI3_REV")[1]+10 CELL BREAK
DEFINE CELL NAME "QI2_TPFIC"  OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_TPFIC")[1]+30
DEFINE CELL NAME "ADE_SEVCOD" OF oSection1 ALIAS "ADE"  SIZE TamSx3("ADE_SEVCOD")[1]+15 BLOCK {||U_Q170DOcor(ADE_SEVCOD)}	
DEFINE CELL NAME "QI2_CODCAT" OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_CODCAT")[1]+40 BLOCK {||QI2_CODCAT +" - "+A120DEtapa(QI2_CODCAT)}CELL BREAK 
DEFINE CELL NAME "ADE_DATA"   OF oSection1 ALIAS "ADE"  SIZE TamSx3("ADE_DATA")[1]+2   	                                  
DEFINE CELL NAME "QI2_OCORRE" OF oSection1 ALIAS "QI2"  SIZE TamSx3("QI2_OCORRE")[1]+1
DEFINE CELL NAME "ADE_DTEXPI" OF oSection1 ALIAS "QI5"  SIZE TamSx3("ADE_DTEXPI")[1]+1 CELL BREAK
DEFINE CELL NAME "cNOME"      OF oSection1 ALIAS "QI2"  SIZE 45 TITLE STR0003 BLOCK {||TKENTIDADE(ADE_ENTIDA,ADE_CHAVE,1)}

DEFINE SECTION oSection2 OF oSection1 TITLE STR0013 TABLES "QI2", "QI3"  
DEFINE CELL NAME "QI2_DDETA"  OF oSection2 ALIAS "QI2"  SIZE 80 TITLE STR0006 BLOCK {||U_Q170GPRO(QI2_DDETA)} 
oSection2:Cell("QI2_DDETA"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QI3_RESESP" OF oSection2 ALIAS "QI3"  SIZE 80 TITLE "Res. Esperado "      BLOCK {||U_Q170GESP(QI3_RESESP)}
oSection2:Cell("QI3_RESESP"):SeTLineBREAK(.T.)
DEFINE CELL NAME "QI3_METODO" OF oSection2 ALIAS "QI3"  SIZE 80 TITLE "Met. Utilizado" BLOCK {||U_Q170GMET(QI3_METODO)}
oSection2:Cell("QI3_METODO"):SeTLineBREAK(.T.)

DEFINE SECTION oSection3 OF oSection2 TITLE STR0013 TABLES "QI2", "QI5", "QID" //"Ocorrencia"
DEFINE CELL NAME "QI5_REALIZ" OF oSection3 ALIAS "QI5"  SIZE TamSx3("QI5_REALIZ")[1]+1
DEFINE CELL NAME "QI5_MAT"    OF oSection3 ALIAS "QI5"  SIZE TamSx3("QI5_MAT")[1]+40  BLOCK {|| QI5_MAT +" - "+ QA_NUSR(QI5_FILMAT,QI5_MAT,.F.,"A")}//"Responsavel"
DEFINE CELL NAME "QI5_TPACAO" OF oSection3 ALIAS "QI5"  SIZE TamSx3("QI5_TPACAO")[1]+1 TITLE STR0004 //"Etapa"
DEFINE CELL NAME "cDESCTP"    OF oSection3 ALIAS "QI5"  SIZE TamSx3("QID_DESCTP")[1]+1 TITLE STR0005 BLOCK {||U_QNCDAcaa(QI5_TPACAO)}
DEFINE CELL NAME "QI5_STATUS" OF oSection3 ALIAS "QI5"  SIZE TamSx3("QI5_STATUS")[1]+1 BLOCK {||U_QNCDExx(QI5_STATUS)}
DEFINE CELL NAME "QI5_TAREFA" OF oSection3 ALIAS "QI5"  SIZE TamSx3("QI5_TAREFA")[1]+1 	CELL BREAK 
oTotal := oReport:Section(1)
TRFunction():New(oSection1:Cell("ADE_SEVCOD"),Nil,"COUNT", oBreak ,,"@E 999.99",,.F.,.T.,.F.)

oSection1:SetLeftMargin(7)	//Identacao da Secao      
oSection1:SetLineStyle()	//Imprime Celula em Linha

Return oReport

                                         
/*                                                       
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ           
ฑฑบPrograma  ณReportPrinบAutor  ณLeandro             บ Data ณ  29/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Personalizavel                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณU_QNCR170()                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                  
Static Function PrintReport(oReport) 
Local cOcorI	:= 0
Local cOcorF 	:= 0
Local cServI    := 0
Local cServF    := 0
Local cQueryFNC	:= ""
Local cQueryADE	:= ""
Local cQuerySLA	:= ""
Local cQueryVer := ""
Local cReal     := ""
Local cQueryDt  := ""
Local cQueryETP := ""

Private cAlias  := "QI2"

//"Ocorrencia"
If mv_par09 = 1 //"N Conf. Existente"
	cOcorI := "2"
	cOcorF := "2"
Else
	If mv_par09 == 2 //"N Conf. Potencial"
		cOcorI:= "1"
		cOcorF:= "1"
	Else
		If mv_par09 == 3//"Melhoria"
			cOcorI := "3" 
			cOcorF := "3"
		Else
			cOcorI:= "0"//"Todos"
			cOcorF:= "3" 
		Endif						
	Endif
Endif			

//"Severidade"	 
Do Case
	Case mv_par11 == 1 //"Baixa"
		cServI:= "2"
		cServF:= "2"
	Case mv_par11 == 2 //"Media"
		cServI := "3" 
		cServF := "3"
	Case mv_par11 == 3 //"Alta"
		cServI:= "4" 
		cServF:= "4" 
	Case  mv_par11 == 4 //"Critica"
		cServI:= "5" 
		cServF:= "5" 
	Case mv_par11 == 5	//"Todos"
		cServI:= "1" 
		cServF:= "5" 
EndCase

	                     
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ                             Abaixo segue a classificacao da nao conformidade usada pelo TMK															  ณ
//ณSeveridade do chamado	                        QI2_PRIORI	     QI2_TPFIC	                      QI2_STATUS              ณ
//-----------------------------------------------------------------------------------------------------------------           ณ
//ณRequisi็ใo de altera็ใo de especifica็ใo (1)	     Baixa (1)	     Melhoria (3)	                  Procede (3)             ณ
//ณBaixa (2)	                                     Baixa (1)	   Nใo-Conformidade Existente (2)     Procede (3)             ณ
//ณM้dia (3)	                                     M้dia (2)	   Nใo-Conformidade Existente (2)	  Procede (3)             ณ
//ณAlta (4)	                                         Alta (3)	   Nใo-Conformidade Existente (2)	  Procede (3)             ณ     
//ณCritica (5)	                                     Alta (3)	   Nใo-Conformidade Existente (2)	  Procede (3)             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู



MakeSqlExpr(oReport:GetParam())
		
oReport:Section(1):BeginQuery()
    
cAlias := GetNextAlias()+"QI2"
//----------------------------------------------------------------------------------------------//
cQueryFNC:="% "
If !Empty(mv_par03) .And. !Empty(mv_par04)
	cQueryFNC+= "QI2.QI2_OCORRE BETWEEN '"+DTOS(mv_par03)+"' and '"+DTOS(mv_par04)+"' and "
EndIf
cQueryFNC+=" %"
//----------------------------------------------------------------------------------------------//
cQueryDt:="% "
If !Empty(mv_par05) .And. !Empty(mv_par06)
	cQueryDt+= "QI2.QI2_CONREA BETWEEN '"+DTOS(mv_par05)+"' and '"+DTOS(mv_par06)+"' and "
EndIf
cQueryDt+=" %"
//----------------------------------------------------------------------------------------------//
cReal := "% "
If mv_par10 = 1 //Aberto
	cReal += "QI2.QI2_CONREA = ' ' and QI2.QI2_OBSOL <> 'S'  and "
Else
	If mv_par10 == 2 //Encerrado
		cReal += "QI2.QI2_CONREA <> ' ' and "
	Else
		If mv_par10 == 3 //Rejeitado
			cReal += "QI2.QI2_CONREA <> ' '  and QI2.QI2_OBSOL <> 'S'  AND "
		Endif
	Endif
Endif
cReal += " %"
//----------------------------------------------------------------------------------------------//
//"Tipo de impressao da etapa"	 
cQueryETP:="% "
Do Case
Case mv_par24 == 1 //"Somente c/ tarefas pendentes"
	cQueryETP += "QI5.QI5_STATUS < '4' and QI5.QI5_TAREFA <> ' ' AND "
Case mv_par24 == 2 //"Somente c/ tarefas encerradas"
	cQueryETP += "QI5.QI5_STATUS = '4' and QI5.QI5_TAREFA <> ' ' AND"
Case mv_par24 == 3 //"Sem tarefas"
	cQueryETP += "QI5.QI5_STATUS <> '4' and QI5.QI5_TAREFA = ' ' AND"
EndCase
cQueryETP+=" %"
//----------------------------------------------------------------------------------------------//	
cQueryADE:="% "
If !Empty(mv_par29) .And. !Empty(mv_par30)
	cQueryADE+= "ADE.ADE_DATA BETWEEN '"+DTOS(mv_par29)+"' and '"+DTOS(mv_par30)+"' and "
EndIf
cQueryADE+=" %"
//----------------------------------------------------------------------------------------------//
cQuerySLA:="% "
If !Empty(mv_par33) .And. !Empty(mv_par34)
	cQuerySLA+= "ADE.ADE_DTEXPI BETWEEN '"+DTOS(mv_par33)+"' and '"+DTOS(mv_par34)+"' and "
EndIf
cQuerySLA+=" %"
//----------------------------------------------------------------------------------------------//    

BeginSql Alias cAlias
	SELECT DISTINCT
	QI2.QI2_CODPRO, QI2.QI2_NCHAMA,QI2.QI2_CODORI,  QI2.QI2_CODEFE, QI2.QI2_CODCAT, QI2.QI2_CODCAU, QI2.QI2_FNC,
	QI2.QI2_REV   , QI2.QI2_TPFIC , QI2.QI2_REGIST, QI2.QI2_OCORRE, QI2.QI2_CODCLI, QI2.QI2_DESCR,
	QI5.QI5_CODIGO, QI5.QI5_REV   , QI5.QI5_MAT   , QI5.QI5_REALIZ, QI5.QI5_TPACAO, QI5.QI5_STATUS, QI5.QI5_SEQ,
	ADE.ADE_CHAVE , QI2.QI2_DDETA , ADE.ADE_SEVCOD, ADE.ADE_DATA  , ADE.ADE_GRUPO,  ADE.ADE_ENTIDA,
	ADE.ADE_DTEXPI, QI3.QI3_RESESP, QI3.QI3_METODO, QI5.QI5_FILMAT, QI2.QI2_CONPRE , QI5.QI5_PRAZO,
	QI5.QI5_STATUS, QI5.QI5_TAREFA, QI3.QI3_CODIGO, QI3.QI3_REV
	FROM %table:QI2% QI2, %table:QI5% QI5, %table:QI9% QI9,%table:QI3% QI3, %table:ADE% ADE, %table:SA1% SA1
	WHERE QI2.QI2_FILIAL = %xFilial:QI2%  AND
	QI2.QI2_CODACA = QI3.QI3_CODIGO AND
	QI2.QI2_REVACA = QI3.QI3_REV    AND
	QI3.QI3_FILIAL = QI5.QI5_FILIAL AND
	QI3.QI3_CODIGO = QI5.QI5_CODIGO AND
	QI3.QI3_REV    = QI5.QI5_REV    AND
	QI2.QI2_FILIAL = ADE.ADE_FNCFIL AND
	QI2.QI2_FNC    = ADE.ADE_FNC    AND
	QI2.QI2_REV    = ADE.ADE_FNCREV AND
	QI2.QI2_CODPRO BETWEEN %Exp:mv_par01%  AND %Exp:mv_par02% AND
	%Exp:cQueryFNC%
	QI2.QI2_FNC    BETWEEN %Exp:mv_par07%  AND %Exp:mv_par08% AND
	%Exp:cQueryDt%
	QI2.QI2_TPFIC  BETWEEN %Exp:cOcorI%    AND %Exp:cOcorF%   AND
	QI2.QI2_CODORI BETWEEN %Exp:mv_par12%  AND %Exp:mv_par13% AND
	QI2.QI2_CODEFE BETWEEN %Exp:mv_par14%  AND %Exp:mv_par15% AND
	QI2.QI2_CODCAT BETWEEN %Exp:mv_par16%  AND %Exp:mv_par17% AND
	QI2.QI2_CODCAU BETWEEN %Exp:mv_par18%  AND %Exp:mv_par19% AND
	QI2.QI2_DESDEP BETWEEN %Exp:mv_par31%  AND %Exp:mv_par32% AND
	%Exp:cReal%
	QI5.QI5_MAT    BETWEEN %Exp:mv_par20%  AND %Exp:mv_par21% AND
	QI5.QI5_TPACAO BETWEEN %Exp:mv_par22%  AND %Exp:mv_par23% AND
	%Exp:cQueryETP%
	ADE.ADE_CHAVE  BETWEEN %Exp:(AllTrim(mv_par25)+AllTrim(mv_par26))% AND %Exp:(AllTrim(mv_par27)+AllTrim(mv_par28))% AND
	ADE.ADE_SEVCOD BETWEEN %Exp:cServI%    AND %Exp:cServF%   AND
	%Exp:cQueryADE%
	ADE.ADE_ENTIDA = 'SA1' AND ADE.ADE_CODIGO = QI2.QI2_NCHAMA AND
	%Exp:cQuerySLA%
	ADE.ADE_FNCFIL = QI2.QI2_FILIAL AND ADE.ADE_FNC = QI2.QI2_FNC AND ADE.ADE_FNCREV = QI2.QI2_REV AND
	(SA1.A1_COD||SA1.A1_LOJA) = ADE.ADE_CHAVE AND
	QI2.%notDel% AND QI5.%notDel%
	Order By ADE.ADE_CHAVE,QI2.QI2_CODPRO, QI2.QI2_NCHAMA,QI2.QI2_FNC, QI2.QI2_REV, QI5.QI5_SEQ, QI5.QI5_TPACAO
EndSql
oReport:Section(1):EndQuery( /*Array com os parametros do tipo Range*/)
CTESTE:= oReport:Section(1):CQuery
oReport:Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):SetParentFilter({|cParam| (cAlias)->ADE_CHAVE+(cAlias)->QI2_CODPRO+(cAlias)->QI2_NCHAMA+(cAlias)->QI2_FNC+(cAlias)->QI2_REV == cParam },;
	{|| (cAlias)->ADE_CHAVE+(cAlias)->QI2_CODPRO+(cAlias)->QI2_NCHAMA +(cAlias)->QI2_FNC+(cAlias)->QI2_REV})
oReport:Section(1):Section(1):Section(1):SetParentQuery()
oReport:Section(1):Section(1):Section(1):SetParentFilter({|cParam| (cAlias)->ADE_CHAVE+(cAlias)->QI2_CODPRO+(cAlias)->QI2_NCHAMA+(cAlias)->QI2_FNC+(cAlias)->QI2_REV == cParam },;
	{|| (cAlias)->ADE_CHAVE+(cAlias)->QI2_CODPRO+(cAlias)->QI2_NCHAMA +(cAlias)->QI2_FNC+(cAlias)->QI2_REV})
                          
oReport:Section(1):Print()

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170DAcao บAutor  ณLeandro Sabino      บ Data ณ  29/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da acao      						  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170DAcao(cAcao)                     
Local cDesc := ""
cDesc := Posicione('QID',1,xFilial('QID')+cAcao,'QID_DESCTP')
Return cDesc

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170DOcor บAutor  ณLeandro Sabino      บ Data ณ  02/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da ocorrencia   						  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170DOcor(cOcorrencia)                     
Local cDesc := ""

DO CASE
CASE cOcorrencia == "1" 
	cDesc := STR0007 //"Requisicao de alteracao de especificacao"
CASE cOcorrencia == "2" 
	cDesc := STR0008 //"Baixa"
CASE cOcorrencia == "3" 
	cDesc := STR0009 //"Media"
CASE cOcorrencia == "4" 
	cDesc := STR0010 //"Alta"
CASE cOcorrencia == "5" 
	cDesc := STR0011 //"Critica"
EndCASE

Return cDesc

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170DExe  บAutor  ณLeandro Sabino      บ Data ณ  09/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da porcentagem de execucao da tarefa   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170DExe(cStatus)                     
Local cPercExec
    Do case 
       case cStatus = "1"
           cPercExec := " 0% a 25%"       	   
       case cStatus = "2"
        	cPercExec := " 25% a 50%"       	    
       case cStatus = "3"
   		    cPercExec := "50% a 100%"       	    
       case cStatus = "4"
		    cPercExec := "100%"
	   case cStatus = "5"	    
		    cPercExec := "Rejeitado"       	    
    EndCase
Return cPercExec


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170GESP  บAutor  ณLeandro Sabino      บ Data ณ  09/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da analise    						  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170GESP(cCodigo)
Local ctexto := ""
If mv_par35 = 1
	ctexto := MSMM(cCodigo)
Endif	
Return  ctexto


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170GMET  บAutor  ณLeandro Sabino      บ Data ณ  09/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao do resultado do CQ   				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170GMET(cCodigo)
Local ctexto := ""
If mv_par36 = 1
	cTexto := MSMM(cCodigo)
Endif
Return  ctexto
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQ170GPRO  บAutor  ณLeandro Sabino      บ Data ณ  16/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao do problema          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Q170GPRO(cCodigo)
Local ctexto := ""
If mv_par37 = 1
	cTexto := MSMM(cCodigo)
Endif
Return  ctexto

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValProd  บAutor  ณLeandro Sabino      บ Data ณ  16/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida o produto					          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValProd(cCodigo)
Local lRet  := .T.    
Local cTam  := TamSx3("QI2_CODPRO")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodigo) .and. ((SubStr(cCodigo,1,6) <> SubStr(cVal1,1,6)) .and. (SubStr(cCodigo,1,6) <> SubStr(cVal2,1,6)))
	If (cCodigo <> cVal1) 
		IF cCodigo <> cVal2
			If !ExistCpo("SB1",cCodigo)
				lRet := .F.
			Endif	
		Endif
	Endif
Endif		

Return  lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValQI0  บAutor  ณLeandro Sabino      บ Data ณ  16/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida registro na QI0			          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValQI0(cTipo,cCodigo)
Local lRet  := .T.    
Local cTam  := TamSx3("QI0_CODIGO")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodigo) 
	If (cCodigo <> cVal1) 
		IF cCodigo <> cVal2
			If !FQNCNTAB(cTipo,cCodigo,.T.)
				lRet := .F.
			Endif	
		Endif
	Endif
Endif		

Return  lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValQI0  บAutor  ณLeandro Sabino      บ Data ณ  16/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida registro na QI0			          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValQID(cCodigo)
Local lRet  := .T.    
Local cTam  := TamSx3("QID_TPACAO")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodigo) 
	If (cCodigo <> cVal1) 
		IF cCodigo <> cVal2
			If !ExistCpo("QID",cCodigo)
				lRet := .F.
			Endif	
		Endif
	Endif
Endif		

Return  lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValQI2  บAutor  ณLeandro Sabino      บ Data ณ  16/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida registro na QI0			          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValQI2(cCodigo)
Local lRet  := .T.    
Local cTam  := TamSx3("QI2_FNC")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodigo) 
	If (cCodigo <> cVal1) 
		IF cCodigo <> cVal2
			If !ExistCpo("QI2",cCodigo,2)
				lRet := .F.
			Endif	
		Endif
	Endif
Endif		

Return  lRet 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValQI0   บAutor  ณLeandro Sabino      บ Data ณ  30/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida registro na QI0			          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValQAD(cCodigo)
Local lRet  := .T.    
Local cTam  := TamSx3("QAD_CUSTO")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodigo) 
	If (cCodigo <> cVal1) .and. ((SubStr(cCodigo,1,6) <> SubStr(cVal1,1,6)) .and. (SubStr(cCodigo,1,6) <> SubStr(cVal2,1,6)))
		IF cCodigo <> cVal2
			If !ExistCpo("QAD",cCodigo)
				lRet := .F.
			Endif	
		Endif
	Endif
Endif		

Return  lRet 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQValQAA   บAutor  ณLeandro Sabino      บ Data ณ  30/12/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida registro na QI0			          				  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QValQAA(cCodDe,nPos)

Local lRet   := .T.
Local nOrdQAA:= QAA->(IndexOrd())
Local cTam  := TamSx3("QAA_MAT")[1]  
Local cVal1 := "" 
Local cVal2 := ""

cVal1 := AllTrim(repl("z",cTam))
cVal2 := AllTrim(repl("Z",cTam))

If !Empty(cCodDe) 
	If (cCodDe <> cVal1) 
		IF cCodDe <> cVal2
			If !Empty(cCodDe)
				QAA->(DbSetOrder(1))
				If QAA->(DbSeek(xFilial("QAA") + cCodDe))
					If !QA_SitFolh()
						Help(" ",1,"QAUSRINAT") // Usuario esta com a situacao de Inativo no Cadastro.
						lRet:=.F.
					Endif
				Else
					Help(" ",1,"QAUSRNEXI") // Usuario Nao Cadastrado
					lRet:= .F.
				Endif
			Endif
		Endif
	Endif
Endif
				
QAA->(DbSetOrder(nOrdQAA))

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQNCDAcaa  บAutor  ณLeandro Sabino      บ Data ณ  29/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da acao      						  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QNCDAcaa(cAcao)                     
Local cDesc := ""
cDesc := Posicione('QID',1,xFilial('QID')+cAcao,'QID_DESCTP')
Return cDesc
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQNCDExx   บAutor  ณLeandro Sabino      บ Data ณ  09/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a descricao da porcentagem de execucao da tarefa   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function QNCDExx(cStatus)                     
Local cPercExec
    Do case 
       case cStatus = "1"
           cPercExec := " 0% a 25%"       	   
       case cStatus = "2"
        	cPercExec := " 25% a 50%"       	    
       case cStatus = "3"
   		    cPercExec := "50% a 100%"       	    
       case cStatus = "4"
		    cPercExec := "100%"
	   case cStatus = "5"	    
		    cPercExec := "Rejeitado"       	    
    EndCase
Return cPercExec