/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER040.CH"
#Include "PROTHEUS.CH" 
#INCLUDE "REPORT.CH"

Static lQLTDispSVR := NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER040   ºAutor  ³Telso Carneiro      º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Resultados                     				  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Qier040()

	Local oReport	

	Private INCLUI	  := .F.

	DbSelectArea("QED") // Para ser usado no Laudo
	DbSelectArea("QEL") // Para pegar o tamanho do campo
	DbSelectArea("QEK") // Para pegar futuramente o tamanho do campo

	lQLTDispSVR := Iif(lQLTDispSVR == Nil, FindFunction("QLTDispSVR"), lQLTDispSVR)

	If !lQLTDispSVR .OR. !QLTDispSVR("manufacturing.sv.qie.inpectionresult")
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Variaveis utilizadas para parametros                         ³
		//³ mv_par01           //  Do  Produto ?             	         ³
		//³ mv_par02           //  At‚ Produto ?                         ³
		//³ mv_par03           //  Da  RevisÆo ?                         ³
		//³ mv_par04           //  At‚ RevisÆo ?                         ³
		//³ mv_par05           //  Do  Fornecedor ?                      ³
		//³ mv_par06           //  At‚ Fornecedor ?                      ³
		//³ mv_par07           //  Da  Data de Entrada ?                 ³
		//³ mv_par08           //  At‚ Data de Entrada ?                 ³
		//³ mv_par09           //  Do  Lote ?                            ³
		//³ mv_par10           //  At‚ Lote ?                            ³
		//³ mv_par11           //  Impr. Observ. Entr.?                  ³
		//³ mv_par12           //  Rastro de 		   ?                 ³
		//³ mv_par13           //  Rastro ate		   ?                 ³
		//³ mv_par14           //  Imprime todas Medicoes ? 1-Sim        ³
		//³ 				   //                           2-Somente uma³
		//³ mv_par15           //  Imprime Rastreabilidade? 1-Sim        ³
		//³ 				   //                           2-Nao        ³
		//³ mv_par16           //  Nota Fiscal ?                         ³
		//³ mv_par17           //  Serie       ?                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			
		Pergunte("QER040",.F.)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf

Return     

Static Function ReportDef()
Local wnrel   := "QIER040"
Local cDesc1  := STR0001	//"Neste relat¢rio ser„o impressos os resultados obtidos na inspe‡„o"
Local cDesc2  := STR0002	//"das Entradas."
Local cTitulo := STR0003	//"Resultados"                    
Local cPerg   := "QER040"
Private cAliasQEK	:= "QEK"
Private cAliasQEL 	:= "QEL"
Private cAliasQEL2	:= "QEL"
Private cAliasQER 	:= "QER"
Private cAliasQF5 	:= "QF5"
Private cAliasQET 	:= "QET"
Private cAliasQEU 	:= "QEU"

DEFINE REPORT oReport NAME wnrel TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetLandscape(.T.)

DEFINE SECTION oSection1 OF oReport TITLE STR0038 TABLES "QEK" LINE STYLE
DEFINE CELL NAME "Periodo"     OF oSection1 			     SIZE   20						CELL BREAK
DEFINE CELL NAME "Produto"     OF oSection1 			     SIZE TamSX3("QEK_PRODUT")[1]+TamSX3("QEK_DESPRO")[1]
DEFINE CELL NAME "QEK_REVI"    OF oSection1 ALIAS "QEK" AUTO SIZE 							CELL BREAK
DEFINE CELL NAME "QEK_FORNEC"  OF oSection1 ALIAS "QEK"      SIZE   55						CELL BREAK
DEFINE CELL NAME "QEK_DTENTR"  OF oSection1 ALIAS "QEK" AUTO SIZE 
DEFINE CELL NAME "QEK_LOTE"    OF oSection1 ALIAS "QEK" AUTO SIZE  							  
DEFINE CELL NAME "QEK_TAMLOT"  OF oSection1 ALIAS "QEK" 	 SIZE TamSX3("QEK_TAMLOT")[1]+3+TamSX3("QEK_UNIMED")[1] TITLE STR0054  //
DEFINE CELL NAME "QTDREJ"	   OF oSection1 				 SIZE TamSX3("QEK_TAMLOT")[1]+3+TamSX3("QEK_UNIMED")[1] TITLE STR0055  //""
DEFINE CELL NAME "QEK_DOCENT"  OF oSection1 ALIAS "QEK" AUTO SIZE
DEFINE CELL NAME "ID"     	   OF oSection1            														BLOCK {|| &(cAliasQEK+"->QEK_PRODUT")+&(cAliasQEK+"->QEK_REVI")+&(cAliasQEK+"->QEK_FORNEC")+DtoS(&(cAliasQEK+"->QEK_DTENTR"))+&(cAliasQEK+"->QEK_NTFISC") } 	 
oSection1:Cell("ID"):Hide()

DEFINE SECTION oSection2 OF oReport TITLE STR0037 TABLES "QEL","QED" LINE STYLE 
DEFINE CELL NAME "LAUDO"  OF oSection2 ALIAS "QEL" 			SIZE TamSX3("QEL_LAUDO")[1]+TamSX3("QED_DESCPO")[1] TITLE STR0017 //"Laudo Entrada"
DEFINE CELL NAME "QEL_DTLAUD" OF oSection2 ALIAS "QEL" AUTO SIZE
DEFINE CELL NAME "QEL_HRLAUD" OF oSection2 ALIAS "QEL" AUTO SIZE
DEFINE CELL NAME "QEL_DTVAL"  OF oSection2 ALIAS "QEL" AUTO SIZE  						  
DEFINE CELL NAME "QEK_NNC"    OF oSection2 ALIAS "QEK" AUTO SIZE 						  	CELL BREAK 
DEFINE CELL NAME "QEL_JUSTLA" OF oSection2 ALIAS "QEL"      SIZE   TamSX3("QEL_JUSTLA")[1]     	CELL BREAK
DEFINE CELL NAME "LIBURG"     OF oSection2                  SIZE   30 TITLE OemToAnsi(STR0030)
DEFINE CELL NAME "OBS"     	  OF oSection2                  SIZE   30 TITLE OemToAnsi(STR0027) LINE BREAK 
oSection2:Cell("LIBURG"):Disable()

DEFINE SECTION oSection3 OF oReport TITLE STR0036 TABLES "QEL","QED" LINE STYLE
DEFINE CELL NAME "LABOR"  	  OF oSection3 ALIAS "QEL" 		 SIZE 32											 TITLE STR0008	  CELL BREAK //"Laboratorio"
DEFINE CELL NAME "QEL_LAUDO"  OF oSection3 ALIAS "QEL" 		 SIZE TamSX3("QEL_LAUDO")[1]+TamSX3("QED_DESCPO")[1]
DEFINE CELL NAME "QEL_DTLAUD" OF oSection3 ALIAS "QEL" 	AUTO SIZE
DEFINE CELL NAME "QEL_HRLAUD" OF oSection3 ALIAS "QEL" 	AUTO SIZE

DEFINE SECTION oSection4 OF oReport TITLE STR0035 TABLES "QE7","QE8"  LINE STYLE
DEFINE CELL NAME "QE7_ENSAIO"  OF oSection4 ALIAS "QE7"      SIZE 70 CELL BREAK
DEFINE CELL NAME "QE7_UNIMED"  OF oSection4 ALIAS "QE7"      SIZE 10
DEFINE CELL NAME "QE7_NOMINA"  OF oSection4 ALIAS "QE7" AUTO SIZE
DEFINE CELL NAME "QE7_LIE"     OF oSection4 ALIAS "QE7" AUTO SIZE
DEFINE CELL NAME "QE7_LSE"     OF oSection4 ALIAS "QE7" AUTO SIZE
DEFINE CELL NAME "QE8_ENSAIO"  OF oSection4 ALIAS "QE8"      SIZE 40 CELL BREAK
DEFINE CELL NAME "QE8_TEXTO"   OF oSection4 ALIAS "QE8" 	 SIZE 80 LINE BREAK

DEFINE SECTION oSection5 OF oReport TITLE STR0010 TABLES "QER","QES","QEQ","QEU","QA2","QET"
DEFINE CELL NAME "QET_INSTR"  OF oSection5 ALIAS "QET"      SIZE   20
DEFINE CELL NAME "QER_ENSRNO" OF oSection5 ALIAS "QER"      SIZE   15	//"Ensaiador"
DEFINE CELL NAME "QER_DTMEDI" OF oSection5 ALIAS "QER" AUTO SIZE
DEFINE CELL NAME "QER_HRMEDI" OF oSection5 ALIAS "QER" AUTO SIZE
DEFINE CELL NAME "QER_AMOSTR" OF oSection5 ALIAS "QER" AUTO SIZE
DEFINE CELL NAME "QES_MEDICA" OF oSection5 ALIAS "QES"      SIZE   50
DEFINE CELL NAME "QEQ_MEDICA" OF oSection5 ALIAS "QEQ"  		      TITLE OemToansi(STR0010) 
DEFINE CELL NAME "QER_RESULT" OF oSection5 ALIAS "QER"      SIZE   10 TITLE OemToansi(STR0056) //"A/R"
DEFINE CELL NAME "QEU_NAOCON" OF oSection5 ALIAS "QEU"      SIZE   10 TITLE OemToansi(STR0057) //"Nao Conf"
DEFINE CELL NAME "QEU_NUMNC"  OF oSection5 ALIAS "QEU"      SIZE   10 TITLE OemToansi(STR0058) //"Nr NCs"
DEFINE CELL NAME "QEU_CLASSE" OF oSection5 ALIAS "QEU"      SIZE   10 TITLE OemToansi(STR0059) //"Classe"
DEFINE CELL NAME "QEU_DEMIQI" OF oSection5 ALIAS "QEU"      SIZE   10 TITLE OemToansi(STR0060) //"Dem.IQI"
DEFINE CELL NAME "QER_RASTRE" OF oSection5 ALIAS "QER"      SIZE   20 TITLE OemToansi(STR0061)  LINE BREAK //"Rastreabilidade"

DEFINE SECTION oSection6 OF oReport TITLE STR0039 TABLES "QEU","QA2","QET","QER","QES" 
DEFINE CELL NAME "QET_INSTR"  OF oSection6 ALIAS "QET"      SIZE   20 TITLE ""
DEFINE CELL NAME "QER_ENSRNO" OF oSection6 ALIAS "QER"      SIZE   15 TITLE ""
DEFINE CELL NAME "QER_DTMEDI" OF oSection6 ALIAS "QER" AUTO SIZE      TITLE ""
DEFINE CELL NAME "QER_HRMEDI" OF oSection6 ALIAS "QER" AUTO SIZE      TITLE ""
DEFINE CELL NAME "QER_AMOSTR" OF oSection6 ALIAS "QER" AUTO SIZE      TITLE ""
DEFINE CELL NAME "QES_MEDICA" OF oSection6 ALIAS "QES"      SIZE   50 TITLE ""
DEFINE CELL NAME "QEQ_MEDICA" OF oSection6 ALIAS "QEQ"  	          TITLE ""
DEFINE CELL NAME "QER_RESULT" OF oSection6 ALIAS "QER"      SIZE   10 TITLE "" 
DEFINE CELL NAME "QA2_TEXTO"  OF oSection6 ALIAS "QA2" 			      TITLE OemToansi(STR0062) //"Cronica"
DEFINE CELL NAME "QEU_NAOCON" OF oSection6 ALIAS "QEU"      SIZE   10 TITLE ""
DEFINE CELL NAME "QEU_NUMNC"  OF oSection6 ALIAS "QEU"      SIZE   10 TITLE ""
DEFINE CELL NAME "QEU_CLASSE" OF oSection6 ALIAS "QEU"      SIZE   10 TITLE ""
DEFINE CELL NAME "QEU_DEMIQI" OF oSection6 ALIAS "QEU"      SIZE   10 TITLE "" LINE BREAK

DEFINE SECTION oSection7 OF oReport TITLE STR0040 TABLES "QET" 
DEFINE CELL NAME "QET_INSTR"  OF oSection7 ALIAS "QET" AUTO SIZE

DEFINE SECTION oSection8 OF oReport TITLE STR0041 TABLES "QF5","QF4","QF6" 
DEFINE CELL NAME "QF4_TIPAMO" OF oSection8 ALIAS "QF4" AUTO SIZE TITLE STR0042 
DEFINE CELL NAME "QF4_PLAMO"  OF oSection8 ALIAS "QF4" AUTO SIZE TITLE STR0043
DEFINE CELL NAME "QF5_TAMA1"  OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0044
DEFINE CELL NAME "QF5_ACEI1"  OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0045
DEFINE CELL NAME "QF5_REJEI1" OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0046
DEFINE CELL NAME "QF5_TAMA2"  OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0047
DEFINE CELL NAME "QF5_ACEI2"  OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0045
DEFINE CELL NAME "QF5_REJEI2" OF oSection8 ALIAS "QF5" AUTO SIZE TITLE STR0046
DEFINE CELL NAME "cQtdMed"    OF oSection8             AUTO SIZE TITLE STR0048        
DEFINE CELL NAME "cMedia"     OF oSection8             AUTO SIZE TITLE STR0049
DEFINE CELL NAME "cDesvPad"   OF oSection8             AUTO SIZE TITLE STR0050
DEFINE CELL NAME "cPI"   	  OF oSection8             AUTO SIZE TITLE STR0051
DEFINE CELL NAME "cPS"   	  OF oSection8             AUTO SIZE TITLE STR0052
DEFINE CELL NAME "cPIPS"   	  OF oSection8             AUTO SIZE TITLE STR0053

DEFINE BREAK oBreak1 OF oSection1 WHEN oSection1:Cell("ID")

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER040   ºAutor  ³Telso Carneiro      º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Resultados                     				  º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local oQEK  	:= oReport:Section(1)
Local oQEL  	:= oReport:Section(2)
Local oQEL2 	:= oReport:Section(3)
Local oQE7		:= oReport:Section(4)
Local oQER		:= oReport:Section(5)
Local oQEU  	:= oReport:Section(6)
Local oQET  	:= oReport:Section(7)
Local oQF5  	:= oReport:Section(8)

Local cEnsaio	:=""     
Local lQERinit	:=.F.
Local aInterno	:= {}
Local cPlaAmo	:=""
Local cNorma	:=""
Local cCarta	:=""
Local nY		:=0
Local aNBR5429  := Array(5)
Local nCont		:=0
Local cMedTitle	:=""
Local cValMed	:=""
Local cQtdMed	:=""
Local cCodMed	:=""
Local aQtdMed	:={}  
Local cFilQEK   
Local cFilQER   := ""
Local cFilQER2  := ""  
Local cCondQEL1 := ""
Local cCondQEL2 := ""
Local lMedicao  := .T.  
Local lPrim 	:= .T.
Local aQA2Texto := {}
Local nI		:= 0
Local nX		:= 0
Local aNC		:= {}
Local aNCTxt	:= {}


If oReport:lXlsTable
	ApMsgAlert(STR0065) //"Formato tabela não disponível"
	oReport:CancelPrint()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

dbSelectArea("QEK")
dbSetOrder(1)
dbSelectArea("QEL")
dbSetOrder(1)
dbSelectArea("QE6")
dbSetOrder(1)
dbSelectArea("QE8")
dbSetOrder(1)
dbSelectArea("QE7")
dbSetOrder(1)
dbSelectArea("QES")
dbSetOrder(1)
dbSelectArea("QEQ")
dbSetOrder(1)
dbSelectArea("QEU")
dbSetOrder(1)
dbSelectArea("QET")
dbSetOrder(1)
dbSelectArea("QF5")
dbSetOrder(1)
dbSelectArea("QF4")
dbSetOrder(1)
dbSelectArea("QF6")
dbSetOrder(1)

cFilQEK:="% QER.QER_FILIAL = '"+xFilial("QER")+"' AND"
   	If !Empty(mv_par16) .AND. !Empty(mv_par17)
    	cFilQEK += " QEK.QEK_NTFISC = '"+mv_par16+"' AND "
    	cFilQEK += " QEK."+SerieNfId("QEK",3,"QEK_SERINF") + " = '"+mv_par17+"' AND"
    	//cFilQEK += " QEK.QEK_SERINF = '"+mv_par17+"' AND"	    	
   	EndIf
   	
    cFilQEK+=" %"  
    	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Begin Report Query oQEK   

cAliasQEK:= GetNextAlias()

BeginSql Alias cAliasQEK
	SELECT DISTINCT QEK.QEK_FILIAL, QEK.QEK_FORNEC, QEK.QEK_LOJFOR, QEK.QEK_PRODUT, QEK.QEK_REVI  , 
					QEK.QEK_LOTE  , QEK.QEK_DTENTR, QEK.QEK_TAMLOT, QEK.QEK_DOCENT, QEK.QEK_NNC   ,
					QEK.QEK_CHAVE , QEK.QEK_CHAVE1, QEK.QEK_TIPONF, QEK.QEK_TAMAMO, QEK.QEK_NTFISC,
					QEK.QEK_SERINF, QEK.QEK_ITEMNF, QEK.QEK_NTFISC||QEK.QEK_SERINF||QEK.QEK_ITEMNF AS TITULO
	FROM %table:QEK% QEK,
	     %table:QER% QER 

	WHERE QEK.QEK_FILIAL = %xFilial:QEK% AND
		QEK.QEK_PRODUT BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
		QEK.QEK_REVI   BETWEEN %Exp:mv_par03% AND %Exp:mv_par04% AND
		QEK.QEK_FORNEC BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND
		QEK.QEK_DTENTR BETWEEN %Exp:DTOS(mv_par07)% AND %Exp:DTOS(mv_par08)% AND
		QEK.QEK_LOTE   BETWEEN %Exp:mv_par09% AND %Exp:mv_par10% AND  
		%Exp:cFilQEK% 
		QER.QER_PRODUT = QEK.QEK_PRODUT AND
		QER.QER_REVI   = QEK.QEK_REVI AND
		QER.QER_FORNEC = QEK.QEK_FORNEC AND
		QER.QER_TIPONF = QEK.QEK_TIPONF AND
		QER.QER_DTENTR = QEK.QEK_DTENTR AND
		QER.QER_LOTE   = QEK.QEK_LOTE AND
		QER.%notDel% AND
		QEK.%notDel%
		
	ORDER BY QEK_FILIAL,QEK_FORNEC,QEK_LOJFOR,QEK_PRODUT,QEK_REVI,QEK_DTENTR,QEK_LOTE,QEK_NNC				
EndSql 
cQuery := GetLastQuery()[2]
End Report Query oQEK

Begin Report Query oQEL
cAliasQEL:= GetNextAlias()
cCamposQEL:='% '   	
cCamposQEL +=' QEL.QEL_NISERI, QEL.QEL_TIPONF, '   		
cCamposQEL+=' %'  	
cCondQEL1:='% '
cCondQEL1+=" (QEL.QEL_NISERI = %report_param:(cAliasQEK)->TITULO% OR QEL.QEL_NISERI = '"+SPACE(TamSX3("QEL_NISERI")[1])+"') AND "
cCondQEL1+=" (QEL.QEL_TIPONF = %report_param:(cAliasQEK)->QEK_TIPONF% OR QEL.QEL_TIPONF = '"+SPACE(TamSX3("QEL_TIPONF")[1])+"') AND "

cCondQEL1+=' %'

BeginSql Alias cAliasQEL

	SELECT %Exp:cCamposQEL% QEL.QEL_FILIAL, QEL.QEL_FORNEC,
 		QEL.QEL_LOJFOR, QEL.QEL_PRODUT, QEL.QEL_REVI, QEL.QEL_LOTE, QEL.QEL_LAUDO, QEL.QEL_DTLAUD, QEL.QEL_HRLAUD, 
		QEL.QEL_DTVAL, QEL.QEL_JUSTLA, QEL.QEL_DTENTR, QEL.QEL_QTREJ
	FROM %table:QEL% QEL 

	WHERE QEL.QEL_FILIAL = %xFilial:QEL% AND 
		QEL.QEL_LABOR = ' ' AND
		QEL.QEL_PRODUT = %report_param:(cAliasQEK)->QEK_PRODUT%  AND
		QEL.QEL_REVI   = %report_param:(cAliasQEK)->QEK_REVI% AND
		QEL.QEL_FORNEC = %report_param:(cAliasQEK)->QEK_FORNEC% AND
		QEL.QEL_DTENTR = %report_param:(cAliasQEK)->QEK_DTENTR% AND
		QEL.QEL_LOTE   = %report_param:(cAliasQEK)->QEK_LOTE% AND 
		%Exp:cCondQEL1%
		QEL.%notDel%			
    ORDER BY QEL_FILIAL,QEL_FORNEC,QEL_LOJFOR,QEL_PRODUT,QEL_DTENTR,QEL_LOTE
    
EndSql

End Report Query oQEL
         
Begin Report Query oQEL2
cAliasQEL2:= GetNextAlias()  

cCondQEL2 :='% '
cCondQEL2 +=' QEL.QEL_NISERI = %report_param:(cAliasQEL)->QEL_NISERI% AND '
cCondQEL2 +=' QEL.QEL_TIPONF = %report_param:(cAliasQEL)->QEL_TIPONF% AND '
cCondQEL2 +=' %'

BeginSql Alias cAliasQEL2

	SELECT %Exp:cCamposQEL% QEL.QEL_FILIAL, QEL.QEL_FORNEC,
 		QEL.QEL_LOJFOR, QEL.QEL_PRODUT, QEL.QEL_REVI, QEL.QEL_LOTE, QEL.QEL_LAUDO, QEL.QEL_DTLAUD, QEL.QEL_HRLAUD, 
		QEL.QEL_DTVAL, QEL.QEL_LABOR, QEL.QEL_DTENTR, QEL.QEL_JUSTLA
	FROM %table:QEL% QEL 

	WHERE QEL.QEL_FILIAL = %xFilial:QEL% AND
		QEL.QEL_LABOR <> ' ' AND
   		QEL.QEL_FORNEC = %report_param:(cAliasQEL)->QEL_FORNEC% AND
		QEL.QEL_LOJFOR = %report_param:(cAliasQEL)->QEL_LOJFOR% AND 
		QEL.QEL_PRODUT = %report_param:(cAliasQEL)->QEL_PRODUT% AND
		QEL.QEL_DTENTR = %report_param:(cAliasQEL)->QEL_DTENTR% AND
		QEL.QEL_LOTE = %report_param:(cAliasQEL)->QEL_LOTE% AND 
		%Exp:cCondQEL2%
		QEL.%notDel%			
    ORDER BY QEL_FILIAL,QEL_FORNEC,QEL_LOJFOR,QEL_PRODUT,QEL_DTENTR,QEL_LOTE,QEL_LABOR
    
EndSql 
End Report Query oQEL2
  
Begin Report Query oQER
cAliasQER:= GetNextAlias()        
 
   	cFilQER2:='% '
    cFilQER2 +=" ( QER.QER_NISERI = %report_param:(cAliasQEK)->TITULO% OR QER.QER_NISERI = '"+SPACE(TamSX3("QEL_NISERI")[1])+"') AND "
    cFilQER2 +=" ( QER.QER_TIPONF = %report_param:(cAliasQEK)->QEK_TIPONF% OR QER.QER_TIPONF = '"+SPACE(TamSX3("QEL_NISERI")[1])+"') AND "
    
	If !Empty(AllTrim(oReport:Section(4):GetSqlExp("QE7")))
		If "OR" $ (oReport:Section(4):GetSqlExp("QE7"))
			cFilQER2+= " (" + (oReport:Section(4):GetSqlExp("QE7")) + ") AND "
		Else
			cFilQER2+= " " + (oReport:Section(4):GetSqlExp("QE7")) + " AND "
		EndIf
	EndIf
	
	cFilQER2+=' %'                            

BeginSql Alias cAliasQER                

	SELECT QER.QER_FILIAL, QER.QER_ENSR  , QER.QER_PRODUT , QER.QER_REVI  , QER.QER_LABOR , QER.QER_DTMEDI, 
		   QER.QER_HRMEDI, QER.QER_AMOSTR, QER.QER_RESULT , QER.QER_RASTRE, QER.QER_ENSAIO, QER.QER_FORNEC,
	       QER.QER_LOJFOR, QER.QER_LOTE  ,   QER.QER_CHAVE, QER.QER_TIPONF, QE7.QE7_PRODUT, QE7.QE7_REVI  , 
	       QE7.QE7_ENSAIO, QE7.QE7_UNIMED,  QE7.QE7_NOMINA, QE7.QE7_MINMAX,    QE7.QE7_LIE, QE7.QE7_LSE   , 
	       QE8.QE8_ENSAIO, QE8.QE8_TEXTO , QAA_APELID
	FROM %table:QAA% QAA, %table:QER% QER
	LEFT JOIN  %table:QE7% QE7 ON %xFilial:QE7%=QE7.QE7_FILIAL AND 
		QER.QER_PRODUT=QE7.QE7_PRODUT AND
		QER.QER_REVI=QE7.QE7_REVI AND
		QER.QER_ENSAIO=QE7.QE7_ENSAIO AND 
		QE7.%notDel% 
	LEFT JOIN  %table:QE8% QE8 ON %xFilial:QE8%=QE8.QE8_FILIAL AND 
		QER.QER_PRODUT=QE8.QE8_PRODUT AND
		QER.QER_REVI=QE8.QE8_REVI AND
		QER.QER_ENSAIO=QE8.QE8_ENSAIO AND 
		QE8.%notDel% 

	WHERE QER.QER_FILIAL = %xFilial:QER% AND 
		QER.QER_PRODUT = %report_param:(cAliasQEK)->QEK_PRODUT%  AND
		QER.QER_REVI   = %report_param:(cAliasQEK)->QEK_REVI% AND
		QER.QER_FORNEC = %report_param:(cAliasQEK)->QEK_FORNEC% AND
		QER.QER_TIPONF = %report_param:(cAliasQEK)->QEK_TIPONF% AND
		QER.QER_LOJFOR = %report_param:(cAliasQEK)->QEK_LOJFOR% AND
		QER.QER_DTENTR = %report_param:(cAliasQEK)->QEK_DTENTR% AND
		QER.QER_LOTE   = %report_param:(cAliasQEK)->QEK_LOTE% AND
		QER.QER_LABOR  = %report_param:(cAliasQEL2)->QEL_LABOR% AND
		QER.QER_RASTRE BETWEEN %Exp:mv_par12% AND %Exp:mv_par13% AND
		QAA.QAA_MAT    = QER.QER_ENSR AND
		QAA.QAA_FILIAL = QER.QER_FILMAT AND 
		%Exp:cFilQER2%
		QER.%notDel% AND QAA.%notDel%
	
		ORDER BY QER_LABOR,QER_ENSAIO,QER_DTMEDI,QER_HRMEDI
EndSql 
cQuery := GetLastQuery()[2]
End Report Query oQER
			
Begin Report Query oQEU
cAliasQEU:= GetNextAlias()

BeginSql Alias cAliasQEU                

	SELECT QEU.QEU_CODMED,QEU.QEU_NAOCON,QEU.QEU_NUMNC,QEU.QEU_CLASSE,QEU.QEU_DEMIQI,QEU.QEU_CHAVE
	FROM %table:QEU% QEU
	WHERE QEU.QEU_FILIAL = %xFilial:QEU% AND  
		QEU.QEU_CODMED = %report_param:(cAliasQER)->QER_CHAVE% AND 
		QEU.%notDel% 
	
    ORDER BY QEU_NAOCON
EndSql 
End Report Query oQEU
    	    
Begin Report Query oQET
cAliasQET:= GetNextAlias()

BeginSql Alias cAliasQET                

	SELECT QET.QET_CODMED,QET.QET_INSTR
	FROM %table:QET% QET
	WHERE QET.QET_FILIAL = %xFilial:QET% AND  
		QET.QET_CODMED = %report_param:(cAliasQER)->QER_CHAVE% AND 
		QET.%notDel% 			

    ORDER BY QET_INSTR
EndSql 
End Report Query oQET
    
Begin Report Query oQF5
cAliasQF5:= GetNextAlias()

BeginSql Alias cAliasQF5

	SELECT QF5.QF5_FILIAL,QF5.QF5_TAMA1,QF5.QF5_ACEI1,QF5.QF5_REJEI1,QF5.QF5_TAMA2,QF5.QF5_ACEI2,
		QF5.QF5_REJEI2, QF4.QF4_TIPAMO, QF4.QF4_PLAMO, QF4.QF4_NIVEL, QF4.QF4_NQA,
		QF6.QF6_TIPAMO, QF6.QF6_PLAMO, 	QF6.QF6_NIVEL, QF6.QF6_NQA					
		FROM %table:QF5% QF5
		LEFT JOIN %table:QF6% QF6
                  ON QF5.QF5_ENSAIO = QF6.QF6_ENSAIO AND
                  QF5.QF5_REVI = QF6.QF6_REVI AND 
                  QF5.QF5_FORNEC = QF6.QF6_CLIENT AND 
                  QF5.QF5_LOJFOR = QF6.QF6_LOJCLI AND
                  QF5.QF5_PRODUT = QF6.QF6_PRODUT
   			LEFT JOIN %table:QF4% QF4
                 ON QF5.QF5_FORNEC = QF4.QF4_FORNEC AND 
                 QF5.QF5_LOJFOR = QF4.QF4_LOJFOR AND 
                 QF5.QF5_PRODUT = QF4.QF4_PRODUT AND 
                 QF5.QF5_REVI = QF4.QF4_REVI AND 
                 QF5.QF5_ENSAIO = QF4.QF4_ENSAIO
	WHERE QF5.QF5_FILIAL = %xFilial:QF5% AND
		QF5.QF5_ENSAIO = %report_param:cEnsaio% AND
		QF5.QF5_CHAVE = %report_param:(cAliasQEK)->QEK_CHAVE% AND
		QF5.%notDel% 
				
EndSql 
	
End Report Query oQF5

If mv_par15 == 2
	oQER:Cell("QER_RASTRE"):Disable()
Endif 

nCont:=0
(cAliasQEK)->( dbGoTop() )
(cAliasQEK)->( dbEval( { || nCont++ } ) )
(cAliasQEK)->( dbGoTop() )
oReport:SetMeter(nCont)
	    
While (cAliasQEK)->(!Eof())
	
	oReport:IncMeter()	 	
	If oReport:Cancel()
		Exit		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime dados da Entrada ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oQEK:Init()
	oQEK:Cell("Periodo"):SetValue(DtoC(mv_par07)+" - "+DtoC(mv_par08)) //"Periodo"
	oQEK:Cell("Produto"):SetValue(&(cAliasQEK+"->QEK_PRODUT")+" - "+A200DePr(&(cAliasQEK+"->QEK_PRODUT"),.F.,&(cAliasQEK+"->QEK_REVI")))
	If (cAliasQEK)->QEK_TIPONF$("DßB")
		oQEK:Cell("QEK_FORNEC"):SetValue((cAliasQEK)->QEK_FORNEC+"/"+(cAliasQEK)->QEK_LOJFOR+" - "+Posicione("SA1",1,xFilial("SA1")+(cAliasQEK)->QEK_FORNEC+(cAliasQEK)->QEK_LOJFOR,"A1_NOME"))
	Else
		oQEK:Cell("QEK_FORNEC"):SetValue((cAliasQEK)->QEK_FORNEC+"/"+(cAliasQEK)->QEK_LOJFOR+" - "+Posicione("SA2",1,xFilial("SA2")+(cAliasQEK)->QEK_FORNEC+(cAliasQEK)->QEK_LOJFOR,"A2_NOME"))
	Endif
	oQEK:Cell("QEK_REVI"):SetValue((cAliasQEK)->QEK_REVI)
	oQEK:Cell("QEK_DTENTR"):SetValue((cAliasQEK)->QEK_DTENTR)
	oQEK:Cell("QEK_LOTE"):SetValue((cAliasQEK)->QEK_LOTE) 
	DbSelectArea("QEL")
	DbSetOrder(1)
	If dbSeek(xFilial("QEL")+(cAliasQEK)->QEK_FORNEC+(cAliasQEK)->QEK_LOJFOR+(cAliasQEK)->QEK_PRODUT+;
		Dtos((cAliasQEK)->QEK_DTENTR)+(cAliasQEK)->QEK_LOTE+Space(TamSX3("QEL_LABOR")[1]))                            
		oQEK:Cell("QTDREJ"):SetValue(AllTrim(QEL->QEL_QTREJ)+" - "+QEK->QEK_UNIMED)
	EndIF
	oQEK:Cell("QEK_TAMLOT"):SetValue(AllTrim((cAliasQEK)->QEK_TAMLOT)+" - "+QEK->QEK_UNIMED)
	oQEK:Cell("QEK_DOCENT"):SetValue((cAliasQEK)->QEK_DOCENT)
	oQEK:PrintLine()
	oQEK:Cell("Periodo"):Disable()
	
	oQEL:ExecSQL()
	
	While (cAliasQEL)->(!Eof())

		oQEL:Init()	        
		oQEL:Cell("LAUDO"):SetValue(&(cAliasQEL+"->QEL_LAUDO")+" - "+POSICIONE("QED",1,xFilial("QED")+&(cAliasQEL+"->QEL_LAUDO"),iif(__Language == "PORTUGUESE", "QED_DESCPO",iif(__Language == "SPANISH", "QED_DESCES", "QED_DESCIN"))))	
		oQEL:Cell("QEL_DTLAUD"):SetValue((cAliasQEL)->QEL_DTLAUD)
		oQEL:Cell("QEL_HRLAUD"):SetValue((cAliasQEL)->QEL_HRLAUD)
		oQEL:Cell("QEL_DTVAL"):SetValue((cAliasQEL)->QEL_DTVAL)

		If !Empty(Alltrim((cAliasQEK)->QEK_NNC))
			oQEL:Cell("QEK_NNC"):SetValue((cAliasQEK)->QEK_NNC)  
			oQEL:Cell("QEK_NNC"):Enable()
		Else 
			oQEL:Cell("QEK_NNC"):Disable()
		EndIf

		oQEL:Cell("QEL_JUSTLA"):SetValue((cAliasQEL)->QEL_JUSTLA)
		oQEL:Cell("LIBURG"):SetValue( R040LibU("R4",cAliasQEK))
		If mv_par11 == 1
			oQEL:Cell("OBS"):Enable()
			oQEL:Cell("OBS"):SetValue(R040ObEn("R4",cAliasQEK))
		Else
			oQEL:Cell("OBS"):Disable()
		Endif
		oQEL:PrintLine()	
		
		oQEL2:ExecSQL()             
		(cAliasQEL2)->(DbGotop())
		While (cAliasQEL2)->(!Eof())

			oQEL2:Init()	                                           
			oQEL2:Cell("LABOR"):SetValue((cAliasQEL2)->QEL_LABOR+" - "+Tabela("Q2",&(cAliasQEL2+"->QEL_LABOR")))	
			oQEL2:Cell("QEL_LAUDO"):SetValue((cAliasQEL2)->QEL_LAUDO+" - "+POSICIONE("QED",1,xFilial("QED")+(cAliasQEL2)->QEL_LAUDO,iif(__Language == "PORTUGUESE", "QED_DESCPO",iif(__Language == "SPANISH", "QED_DESCES", "QED_DESCIN"))))
			oQEL2:Cell("QEL_DTLAUD"):SetValue((cAliasQEL2)->QEL_DTLAUD)
			oQEL2:Cell("QEL_HRLAUD"):SetValue((cAliasQEL2)->QEL_HRLAUD)
			oQEL2:PrintLine()	
		
			oQER:ExecSQL()             
			(cAliasQER)->(DbGotop())			    

			cEnsaio:=""
			cChave:=""
			While (cAliasQER)->(!Eof())							
				IF (cAliasQER)->QER_ENSAIO!=cEnsaio
					cEnsaio:=(cAliasQER)->QER_ENSAIO
					cCarta := Alltrim(QA_CartEns(cEnsaio))

					oQE7:Init()	                  
					QE1->(dbSeek(xFilial("QE1")+(cAliasQER)->QE7_ENSAIO))   
					
					oQE7:Cell("QE7_ENSAIO"):SetValue(&(cAliasQER+"->QE7_ENSAIO")+" - "+POSICIONE("QE1",1,xFilial("QE1")+&(cAliasQER+"->QE7_ENSAIO"),"QE1_DESCPO")) 
					oQE7:Cell("QE8_ENSAIO"):SetValue(&(cAliasQER+"->QE8_ENSAIO")+" - "+POSICIONE("QE1",1,xFilial("QE1")+&(cAliasQER+"->QE8_ENSAIO"),"QE1_DESCPO")) 
					oQE7:Cell("QE8_TEXTO"):SetValue((cAliasQER)->QE8_TEXTO)	
					oQE7:Cell("QE7_UNIMED"):SetValue(Posicione("SAH",1,xFilial("SAH")+(cAliasQER)->QE7_UNIMED,"SAH->AH_UMRES"))
					oQE7:Cell("QE7_NOMINA"):SetValue((cAliasQER)->QE7_NOMINA) 
					oQE7:Cell("QE7_LIE"):SetValue(Iif((cAliasQER)->QE7_MINMAX=="1",(cAliasQER)->QE7_LIE,Iif((cAliasQER)->QE7_MINMAX=="2",(cAliasQER)->QE7_LIE,"   <<"))) 
					oQE7:Cell("QE7_LSE"):SetValue(Iif((cAliasQER)->QE7_MINMAX=="1",(cAliasQER)->QE7_LSE,Iif((cAliasQER)->QE7_MINMAX=="2","  >>",(cAliasQER)->QE7_LSE))) 
					QR40Espec((cAliasQER)->QE8_ENSAIO,oQE7)			
					oQE7:PrintLine()					   							
					
					QR40Medic((cAliasQER)->QE8_ENSAIO,oQER,(cAliasQER)->QER_ENSAIO)                    
					oQER:Init()	                                                        
					aQtdMed:={}
				Endif	     
				cValMed:=""
				cCodMed:=""    
				cChave:=(cAliasQER)->QER_CHAVE   
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Acumula as Medicoes referentes ao Ensaio                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF cCarta<>"TXT"
					QES->(dbSetOrder(1))
					QES->(dbSeek(xFilial("QES")+cChave))
					While QES->(!Eof()) .And. xFilial("QES") == QES->QES_FILIAL .And. ;
						QES->QES_CODMED == cChave
						cValMed+=QES->QES_MEDICA+" "

						If cCarta=="P"
							IF QES->QES_INDMED == "P"
								Aadd(aQtdMed,QES->QES_MEDICA)
							Endif
						ElseIf cCarta=="U"
							IF cCodMed == QES->QES_CODMED
								Aadd(aQtdMed,QES->QES_MEDICA)
							EndIF
							cCodMed := QES->QES_CODMED
						Else
							Aadd(aQtdMed,QES->QES_MEDICA)
						EndIf							
						QES->(dbSkip())									
					EndDo            
					
				Else
					QEQ->(dbSetOrder(1))
				 	QEQ->(dbSeek(xFilial("QEQ")+cChave))
				 	While QEQ->(!Eof()) .And. xFilial("QEQ") == QEQ->QEQ_FILIAL .And. ;
						QEQ->QEQ_CODMED == cChave
						cValMed+=QEQ->QEQ_MEDICA
						Aadd(aQtdMed,QEQ->QEQ_MEDICA)
						QEQ->(dbSkip())
					EndDo  						
				Endif		

		        If lMedicao
		        	If mv_par14 == 2
		        		lMedicao := .F.
		        	EndIf	
					oQER:Cell("QET_INSTR"):SetValue(Posicione("QET",1,xFilial("QET")+(cAliasQER)->QER_CHAVE,"QET_INSTR"))
					oQER:Cell("QER_ENSRNO"):SetValue((cAliasQER)->QAA_APELID)
					oQER:Cell("QER_DTMEDI"):SetValue((cAliasQER)->QER_DTMEDI)
					oQER:Cell("QER_HRMEDI"):SetValue((cAliasQER)->QER_HRMEDI)
					oQER:Cell("QER_AMOSTR"):SetValue((cAliasQER)->QER_AMOSTR)
					oQER:Cell("QES_MEDICA"):SetValue(cValMed)
					oQER:Cell("QEQ_MEDICA"):SetValue(cValMed)
					oQER:Cell("QER_RESULT"):SetValue((cAliasQER)->QER_RESULT)

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se a medicao tem NC                                 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aNC := {}
					QEU->(dbSelectArea("QEU"))
					QEU->(dbSetOrder(1))
					If QEU->(dbSeek(xFilial("QEU")+cChave))
						While QEU->(!Eof()) .And. QEU->QEU_FILIAL == xFilial("QEU") .And. QEU->QEU_CODMED == cChave
							AADD(aNC,{QEU->QEU_NAOCON,QEU->QEU_NUMNC,QEU->QEU_CLASSE,QEU->QEU_DEMIQI,QEU->QEU_CHAVE})
							QEU->(dbSkip())
						EndDo
					Endif

					If Len(aNC) > 0						
						oQER:Cell("QEU_NAOCON"):SetValue(aNC[1,1])
						oQER:Cell("QEU_NUMNC"):SetValue(aNC[1,2])
						oQER:Cell("QEU_CLASSE"):SetValue(aNC[1,3])
						oQER:Cell("QEU_DEMIQI"):SetValue(aNC[1,4])
					Else
						oQER:Cell("QEU_NAOCON"):SetValue("")
						oQER:Cell("QEU_NUMNC"):SetValue("")
						oQER:Cell("QEU_CLASSE"):SetValue("")
						oQER:Cell("QEU_DEMIQI"):SetValue("")
					Endif
					
					oQER:Cell("QER_RASTRE"):SetValue((cAliasQER)->QER_RASTRE)
					oQER:PrintLine()
					
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Faz a ligacao da NC com a Cronica                            ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aNCTxt := {}
					If Len(aNC) > 0
						For nI := 1 To Len(aNC)
							QA2->(dbSelectArea("QA2"))
							QA2->(dbSetOrder(1))
							If QA2->(dbSeek(xFilial("QA2")+"QIEA210C"+aNC[nI,5]))
								While QA2->(!Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE == ;
										xFilial("QA2")+"QIEA210C"+aNC[nI,5]
									AADD(aNCTxt,{StrTran(QA2->QA2_TEXTO, "\13\10", ""),nI})
									QA2->(dbSkip())
								EndDo
							Endif
						Next
					EndIf

                        If Len(aNC) > 0 .And. Len(aNCTxt) > 0
						oQEU:Cell("QA2_TEXTO"):SetValue("")  //"Cronica"
						oQEU:Cell("QET_INSTR"):SetValue("")
						oQEU:Cell("QER_ENSRNO"):SetValue("") 
						oQEU:Cell("QER_DTMEDI"):SetValue("")
						oQEU:Cell("QER_HRMEDI"):SetValue("")
						oQEU:Cell("QER_AMOSTR"):SetValue("")
						oQEU:Cell("QES_MEDICA"):SetValue("") 
						oQEU:Cell("QEQ_MEDICA"):SetValue("")
						oQEU:Cell("QER_RESULT"):SetValue("")
						oQEU:Cell("QEU_NAOCON"):SetValue("")
						oQEU:Cell("QEU_NUMNC"):SetValue("") 
						oQEU:Cell("QEU_CLASSE"):SetValue("")
						oQEU:Cell("QEU_DEMIQI"):SetValue("")
										
						oQEU:Cell("QET_INSTR"):Hide()
						oQEU:Cell("QER_ENSRNO"):Hide()
						oQEU:Cell("QER_DTMEDI"):Hide()
						oQEU:Cell("QER_HRMEDI"):Hide()
						oQEU:Cell("QER_AMOSTR"):Hide()
						oQEU:Cell("QES_MEDICA"):Hide()
						oQEU:Cell("QEQ_MEDICA"):Hide()
						oQEU:Cell("QER_RESULT"):Hide()
						oQEU:Cell("QEU_NAOCON"):Hide()
						oQEU:Cell("QEU_NUMNC"):Hide()
						oQEU:Cell("QEU_CLASSE"):Hide()
						oQEU:Cell("QEU_DEMIQI"):Hide()

						lQERinit:=.T.
   							oQEU:Init()
                        	For nI := 1 To Len(aNC)
                        		If nI == 1
                        		For nX := 1 To Len(aNCTxt)
                        			If aNCTxt[nX][2] == nI
										oQEU:Cell("QA2_TEXTO"):SetValue(aNCTxt[nX][1])  //"Cronica"
										oQEU:PrintLine()
                        			Endif
    	                    		Next
    	                    	Else
								oQEU:Cell("QA2_TEXTO"):Disable()
								oQEU:Cell("QEU_NAOCON"):SetValue(aNC[nI][1])
								oQEU:Cell("QEU_NUMNC"):SetValue(aNC[nI][2]) 
								oQEU:Cell("QEU_CLASSE"):SetValue(aNC[nI][3])
								oQEU:Cell("QEU_DEMIQI"):SetValue(aNC[nI][4])
								oQEU:Cell("QEU_NAOCON"):Show()
								oQEU:Cell("QEU_NUMNC"):Show()
								oQEU:Cell("QEU_CLASSE"):Show()
								oQEU:Cell("QEU_DEMIQI"):Show()
								oQEU:PrintLine()

								oQEU:Cell("QEU_NAOCON"):SetValue("")
								oQEU:Cell("QEU_NUMNC"):SetValue("") 
								oQEU:Cell("QEU_CLASSE"):SetValue("")
								oQEU:Cell("QEU_DEMIQI"):SetValue("")
                        		For nX := 1 To Len(aNCTxt)
                        			If aNCTxt[nX][2] == nI
										oQEU:Cell("QA2_TEXTO"):Enable()
										oQEU:Cell("QA2_TEXTO"):SetValue(aNCTxt[nX][1])  //"Cronica"
										oQEU:PrintLine()
                        			Endif
    	                    		Next
    	                    	Endif
                        	Next
						oQEU:finish()
                        Endif
                    Endif
				
				IF lQERinit					 
					oQER:finish()
					oQER:init()
					lQERinit:=.F.
				Endif
							   							        						
				(cAliasQER)->(dbSkip())	
				
				IF (cAliasQER)->QER_ENSAIO!=cEnsaio
					oQER:Finish()	                       
					oQE7:Finish()								
					
					oQF5:ExecSQL()             
					(cAliasQF5)->(DbGotop())			    
					IF (cAliasQF5)->(!Eof())					
						oQF5:Init()
						While (cAliasQF5)->(!Eof())

							If (cAliasQEK)->QEK_TIPONF $ "N " 
								cNorma  := QA_Plano((cAliasQF5)->QF4_TIPAMO,.T.) 
								cPlaAmo:=(cAliasQF5)->QF4_PLAMO
								If cPlaAmo  == "PI"
									aInterno := QEP_RetAmostra((cAliasQF5)->QF4_TIPAMO,(cAliasQF5)->QF4_PLAMO,(cAliasQF5)->QF4_NIVEL,(cAliasQF5)->QF4_NQA,(cAliasQEK)->QEK_TAMAMO,"QEK_TAMAMO",.f.)
								EndIf
								cTipAmo:=(cAliasQF5)->QF4_TIPAMO			
						    Else     
			   				//Posiciona no Plano de Amostragem por Cliente referente ao Ensaio			
			   					cNorma  := QA_Plano((cAliasQF5)->QF6_TIPAMO,.T.) 
			   					cPlaAmo:=(cAliasQF5)->QF6_PLAMO
								If cPlaAmo == "PI"
									aInterno := QEP_RetAmostra((cAliasQF5)->QF6_TIPAMO,(cAliasQF5)->QF6_PLAMO,(cAliasQF5)->QF6_NIVEL,(cAliasQF5)->QF6_NQA,(cAliasQEK)->QEK_TAMAMO,"QEK_TAMAMO")
								EndIf
								cTipAmo:=(cAliasQF5)->QF6_TIPAMO			
						    EndIf
																				
							If cCarta <> "TXT" .And. cTipAmo == "5"
								aNBR5429 := QA_Def5429(aQtdMed,SuperVal((cAliasQER)->QE7_LIE),SuperVal((cAliasQER)->QE7_LSE),QA_Plano(cTipAmo),(cAliasQF5)->QF5_TAMA1)		
							Else 
								aNBR5429 := Afill(Array(5),0)
							EndIf					
							QR40Plan((cAliasQEK)->QEK_TIPONF,oQF5)
						
							If cPlaAmo <> "PI"
								oQF5:Cell("QF4_TIPAMO"):SetValue(cNorma)
								oQF5:Cell("QF4_PLAMO"):SetValue((cAliasQF5)->QF4_PLAMO)
								oQF5:Cell("QF5_TAMA1"):SetValue((cAliasQF5)->QF5_TAMA1)
								oQF5:Cell("QF5_ACEI1"):SetValue((cAliasQF5)->QF5_ACEI1)
								oQF5:Cell("QF5_REJEI1"):SetValue((cAliasQF5)->QF5_REJEI1)
								oQF5:Cell("QF5_TAMA2"):SetValue((cAliasQF5)->QF5_TAMA2)
								oQF5:Cell("QF5_ACEI2"):SetValue((cAliasQF5)->QF5_ACEI2)
								oQF5:Cell("QF5_REJEI2"):SetValue((cAliasQF5)->QF5_REJEI2)			
								oQF5:Cell("cQtdMed"):SetValue(Transf(Len(aQtdMed),"@E 999999"))        
								oQF5:Cell("cMedia"):SetValue(aNBR5429[1]) 
								oQF5:Cell("cDesvPad"):SetValue(aNBR5429[2])
								oQF5:Cell("cPI"):SetValue(Transf(aNBR5429[3],"@E 999.99"))
								oQF5:Cell("cPS"):SetValue(Transf(aNBR5429[4],"@E 999.99"))
								oQF5:Cell("cPIPS"):SetValue(Transf(aNBR5429[5],"@E 999.99"))									
								oQF5:PrintLine()
							Else
								For nY:=1 to Len(aInterno)							
									oQF5:Cell("QF4_TIPAMO"):SetValue(Substr(cNorma,1,9))
									oQF5:Cell("QF4_PLAMO"):SetValue(aInterno[nY,7])
									oQF5:Cell("QF5_TAMA1"):SetValue(aInterno[nY,3])
									oQF5:Cell("QF5_ACEI1"):SetValue(aInterno[nY,1])
									oQF5:Cell("QF5_REJEI1"):SetValue(aInterno[nY,2])
									oQF5:Cell("QF5_TAMA2"):SetValue(aInterno[nY,6])
							   		oQF5:Cell("QF5_ACEI2"):SetValue(aInterno[nY,4])
									oQF5:Cell("QF5_REJEI2"):SetValue(aInterno[nY,5])											   
									oQF5:Cell("cQtdMed"):SetValue(Transf(Len(aQtdMed),"@E 999999"))        
									oQF5:Cell("cMedia"):SetValue(aNBR5429[1]) 
									oQF5:Cell("cDesvPad"):SetValue(aNBR5429[2])
									oQF5:Cell("cPI"):SetValue(Transf(aNBR5429[3],"@E 999.99"))
									oQF5:Cell("cPS"):SetValue(Transf(aNBR5429[4],"@E 999.99"))
									oQF5:Cell("cPIPS"):SetValue(Transf(aNBR5429[5],"@E 999.99"))			
									oQF5:PrintLine()
								Next nY
							EndIf						
			
						    (cAliasQF5)->(dbSkip())
						EndDo
						oQF5:finish()
					Endif					
				Endif
			Enddo	
			oQEL2:Finish()										    
		    (cAliasQEL2)->(dbSkip())
		EndDo					        
		oQEL:Finish()				
		(cAliasQEL)->(dbSkip())
	EndDo                      
	
	oQEK:Finish()
	oReport:SkipLine()
	oReport:FatLine()
	oReport:FatLine()
   	(cAliasQEK)->(dbSkip())	
EndDo

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R040ObEn()    ³Autor³Vera Lucia S. Simoes³ Data ³08/09/1999³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime as Observacoes da Entrada                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040ObEn(cRelease,cAlias)
Local lImpTit := .T.   
Local cTexto  := ""                     

IF cRelease == "R3"
	Li++
	QA2->(dbSetOrder(1))
	QA2->(dbSeek(xFilial("QA2")+"QIEA200 "+QEK->QEK_CHAVE))
	While !QA2->(Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
		xFilial("QA2")+"QIEA200 "+QEK->QEK_CHAVE
	
		If li > 55
			Cabec(Titulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			lImpTit := .T.
		EndIf
		If lImpTit
			@Li,001 PSAY STR0027+" :"		// "Observacoes da Entrada:"
			Li++
			lImpTit := .F.
		EndIf
		@Li,001 PSAY StrTran(QA2->QA2_TEXTO, "\13\10", "")
		Li++
		QA2->(dbSkip())
	EndDo
ElseIF cRelease == "R4"
	QA2->(dbSetOrder(1))
	QA2->(dbSeek(xFilial("QA2")+"QIEA200 "+(cAlias)->QEK_CHAVE))
	While !QA2->(Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
		xFilial("QA2")+"QIEA200 "+(cAlias)->QEK_CHAVE	
		cTexto+= StrTran(QA2->QA2_TEXTO, "\13\10", "")
		QA2->(dbSkip())
	EndDo
Endif
Return cTexto

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R040LibU()    ³Autor³Cleber Souza        ³ Data ³07/01/04  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime a mensagem da Liberacao Urgente                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R040LibU(cRelease,cAlias)
Local lImpTit := .T.
Local cTexto  := ""

IF cRelease == "R3"
	Li++
	QA2->(dbSetOrder(1))
	QA2->(dbSeek(xFilial("QA2")+"QIEA210U"+QEK->QEK_CHAVE1))
	While !QA2->(Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
		xFilial("QA2")+"QIEA210U"+QEK->QEK_CHAVE1
		
		If li > 55
			Cabec(Titulo,Cabec1,Cabec2,nomeprog,cTamanho,nTipo)
			lImpTit := .T.
		EndIf
		If lImpTit
			@Li,001 PSAY STR0030 //"Observacoes da Liberacao Urgente:"
			Li++
			lImpTit := .F.
		EndIf
		@Li,001 PSAY StrTran(QA2->QA2_TEXTO, "\13\10", "")
		Li++
		QA2->(dbSkip())
	EndDo    
ElseIF cRelease == "R4"
	QA2->(dbSetOrder(1))
	QA2->(dbSeek(xFilial("QA2")+"QIEA210U"+(cAlias)->QEK_CHAVE1))
	While !QA2->(Eof()) .And. QA2->QA2_FILIAL+QA2->QA2_ESPEC+QA2->QA2_CHAVE ==;
		xFilial("QA2")+"QIEA210U"+(cAlias)->QEK_CHAVE1
		cTexto+= StrTran(QA2->QA2_TEXTO, "\13\10", "")
		QA2->(dbSkip())
	EndDo    
Endif
Return cTexto
                   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ QR40Espec     ³Autor³Telso Carneiro      ³ Data ³07/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controla exibicao da Espeficicacao do Ensaio				  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                      

Static Function QR40Espec(cTxtEnsaio,oSection)

IF Empty(Alltrim(cTxtEnsaio))
	oSection:Cell("QE8_ENSAIO"):Disable()
	oSection:Cell("QE8_TEXTO"):Disable()
	oSection:Cell("QE7_ENSAIO"):Enable()
	oSection:Cell("QE7_UNIMED"):Enable()
	oSection:Cell("QE7_NOMINA"):Enable()
	oSection:Cell("QE7_LIE"):Enable()
	oSection:Cell("QE7_LSE"):Enable()
Else			
	oSection:Cell("QE8_ENSAIO"):Enable()
	oSection:Cell("QE8_TEXTO"):Enable()
	oSection:Cell("QE7_ENSAIO"):Disable()
	oSection:Cell("QE7_UNIMED"):Disable()
	oSection:Cell("QE7_NOMINA"):Disable()
	oSection:Cell("QE7_LIE"):Disable()
	oSection:Cell("QE7_LSE"):Disable()
Endif	

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ QR40Medic     ³Autor³Telso Carneiro      ³ Data ³07/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controla exibicao da Medicao do Ensaio				      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                      

Static Function QR40Medic(cTxtEnsaio,oSection,cEnsaio)
Local cCarta	:=""
Local cMedTitle :=""

cCarta:=Alltrim(QA_CartEns(cEnsaio))

Do Case
 Case cCarta$"XBR/XBS/XMR/HIS/IND/TXT"
	cMedTitle:=STR0010	 	//"Medicoes"
 Case cCarta == "U"
    cMedTitle:=STR0011	    //"Amostra / Nao Conformidades p/ Unid"
 Case cCarta == "NP"
 	cMedTitle:=STR0012		//"Nao Conformes"
 Case cCarta == "C"
 	cMedTitle:=STR0013		//"Nao Conformidades"
 Case cCarta == "P"
 	cMedTitle:= STR0014 	//"Amostra/Unid.Nao Conforme/Porc. Nao Corforme"
 Case cCarta == "TMP"
 	cMedTitle:= STR0034 	//"Tempo"
 OtherWise
 	cMedTitle:=STR0010   	//"Medicoes"
EndCase

IF Empty(cTxtEnsaio) .OR. cTxtEnsaio<>"TXT"
	oSection:Cell("QEQ_MEDICA"):Disable()
	oSection:Cell("QES_MEDICA"):Enable() 
	oSection:Cell("QES_MEDICA"):SetTitle(cMedTitle)
Else                    
	oSection:Cell("QEQ_MEDICA"):Enable()
	oSection:Cell("QES_MEDICA"):Disable()	
Endif                   

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ QR40Plan      ³Autor³Telso Carneiro      ³ Data ³13/07/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controla exibicao do Plano de Amostragem				      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                      

Static Function QR40Plan(cTipoNF,oSection)

IF cTipoNF $ "N "
	oSection:Cell("QF4_TIPAMO"):Enable()
	oSection:Cell("QF4_PLAMO"):Enable()
Else
	oSection:Cell("QF4_TIPAMO"):Disable()
	oSection:Cell("QF4_PLAMO"):Disable()
Endif
Return(.T.)
