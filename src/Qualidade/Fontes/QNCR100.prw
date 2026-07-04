/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "TOTVS.CH"
#INCLUDE "QNCR100.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa  QNCR100, Autor: Leandro Sabino, Data: 23/06/06
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.     Relatorio de Pendencias
±±           (Versao Relatorio Personalizavel)
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Uso       Generico
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QNCR100()
Local oReport := ReportDef()
Private cPerg    := "QNR101    "                                                                  

Pergunte(cPerg,.F.)
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 23/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QNCR100                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local cTitulo	:= STR0007		//"PENDENCIAS POR USUARIO"
Local cDesc1 	:= STR0001		//"Relatorio de Pendencias por Usuario."
Local cDesc2 	:= STR0002		//"Ser  impresso de acordo com os parametros solicitados pelo usuario."
Local cAliasQAA	 := "QAA"
Local cAliasQI2	 := "QI2"
Local cAliasQI3	 := "QI3"
Local cAliasQI5	 := "QI5"
Local aPerSit   := {"  0 %"," 25 %"," 50 %"," 75 %","100 %","REPROV"}
Local aQI2Tipo  := {}
Local aQI3Tipo  := {}
Local aSit      := {}
Local oSection1 
Local oSection2 
Local oSection3 

Private aOrdem  :={}


cAliasQAA := "QAATRB"
cAliasQI2 := "QI2"
cAliasQI3 := "QI3TRB"
cAliasQI5 := "QI5TRB"

QNCCBOX("QI2_TPFIC",@aQI2Tipo)
QNCCBOX("QI3_TIPO",@aQI3Tipo)
QNCCBOX("QI2_STATUS",@aSit)

DEFINE REPORT oReport NAME "QNCR100" TITLE cTitulo PARAMETER "QNR101" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

aOrdem := {	STR0003,; 	// "Matricula"
		    STR0004} 	// "Nome"
		    
//Plano/Etapas
DEFINE SECTION oSection1 OF oReport TABLES "QI5" TITLE OemToAnsi(STR0036) ORDERS aOrdem
DEFINE CELL NAME "cCODIGO"   OF oSection1 ALIAS "   " TITLE OemToAnsi(STR0036)  SIZE 19 BLOCK {||TransForm(QI5_CODIGO,X3PICTURE("QI5_CODIGO"))+"-"+QI5_REV}
DEFINE CELL NAME "cTpAcao"   OF oSection1 ALIAS "   " TITLE TitSX3("QI5_TPACAO")[1]  SIZE 27 BLOCK {||QI5_TPACAO+"-"+FQNCDSX5("QD",QI5_TPACAO)}
DEFINE CELL NAME "cAcao"     OF oSection1 ALIAS "   " TITLE TitSX3("QI5_STATUS")[1]  SIZE 05 BLOCK {||aPerSit[Val(QI5_STATUS)+1]}
DEFINE CELL NAME "QI5_PRAZO" OF oSection1 ALIAS "QI5" BLOCK {|| DTOC(StoD(QI5_PRAZO))}

DEFINE SECTION oSection2 OF oSection1 TABLES "QI3" TITLE OemToAnsi(STR0037) ORDERS aOrdem
DEFINE CELL NAME "cCodigo"    OF oSection2 ALIAS "   " TITLE OemToAnsi(STR0037) SIZE 19 BLOCK {|| TransForm(QI3_CODIGO,X3PICTURE("QI3_CODIGO"))+"-"+QI3_REV}
DEFINE CELL NAME "QI3_ABERTU" OF oSection2 ALIAS "QI3" BLOCK {|| DTOC(StoD(QI3_ABERTU))}
DEFINE CELL NAME "QI3_ENCPRE" OF oSection2 ALIAS "QI3" BLOCK {|| DTOC(StoD(QI3_ENCPRE))}
DEFINE CELL NAME "cStatus"    OF oSection2 ALIAS "   " TITLE TitSX3("QI3_STATUS")[1] SIZE 15 BLOCK {|| aSit[Val(QI3_STATUS)]}
DEFINE CELL NAME "cTipo"      OF oSection2 ALIAS "   " TITLE TitSX3("QI3_TIPO")[1]   SIZE 15 BLOCK {|| aQI3Tipo[Val(QI3_TIPO)]}

DEFINE SECTION oSection3 OF oSection2 TABLES "QI2" TITLE OemToAnsi(STR0038) ORDERS aOrdem
DEFINE CELL NAME "cFNC"       OF oSection3 ALIAS "   " TITLE OemToAnsi(STR0038)   SIZE 19 BLOCK {||TransForm(QI2_FNC,X3PICTURE("QI2_FNC"))+"-"+QI2_REV}
DEFINE CELL NAME "QI2_OCORRE" OF oSection3 ALIAS "QI2" BLOCK {|| DTOC(StoD(QI2_OCORRE))}
DEFINE CELL NAME "QI2_CONPRE" OF oSection3 ALIAS "QI2" BLOCK {|| DTOC(StoD(QI2_CONPRE))}
DEFINE CELL NAME "cStatusFNC" OF oSection3 ALIAS "   " TITLE TitSX3("QI2_STATUS")[1] SIZE 15 BLOCK {||aSit[Val(QI2_STATUS)]}
DEFINE CELL NAME "cTPFIC"     OF oSection3 ALIAS "   " TITLE TitSX3("QI2_TPFIC")[1]  SIZE 15 BLOCK {||aQI2Tipo[Val(QI2_TPFIC)]}

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±± Funcao     PrintReport, Autor: Leandro Sabino, Data: 23/06/06
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±± Descricao  Imprimir os campos do relatorio
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Sintaxe    PrintReport(ExpO1)
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Parametros ExpO1 = Objeto oPrint
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Uso       QNCR100
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local cAliasQAA := "QAA"
Local cAliasQI2 := "QI2"
Local cAliasQI3 := "QI3"
Local cAliasQI5 := "QI5"
Local cQncBale  := GetMv("MV_QNCBALE")
Local cQuery    := ""
Local lPrimeira := .T.
Local nOrdem    := 0
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)

MakeAdvplExpr(oReport:uParam)

cFilDe   	:= mv_par01
cFilAte  	:= mv_par02
cAnoDe   	:= mv_par03 + Iif(Val(mv_par03) > 0,"0101", "")
cAnoAte  	:= mv_par04 + Iif(Val(mv_par04) > 0,"1231", "")
cAcaoDe  	:= mv_par05
cAcaoAte 	:= mv_par06
cRevADe   	:= mv_par07
cRevAAte  	:= mv_par08
cFncDe  	:= mv_par09
cFncAte 	:= mv_par10
cRevFDe   	:= mv_par11
cRevFAte  	:= mv_par12 
cFilDeUsr	:= mv_par13
CFilAteUsr  := mv_par14
cMatDe   	:= mv_par15
cMatAte  	:= mv_par16
nTipoPen 	:= mv_par17
nSalta		:= mv_par18
Do Case
	Case oSection1:GetOrder() == 1
		nOrdem := 1
   	Case oSection1:GetOrder() == 2
		nOrdem := 3
EndCase

cAliasQAA := "QAATRB"

cQuery := ""

// QI5 - Acao Corretiva x Acoes
If nTipoPen == 1 .Or. nTipoPen == 4
	cQuery += "SELECT "
	cQuery += "	QAA.QAA_FILIAL,QAA.QAA_MAT,QAA.QAA_NOME "
	cQuery += "FROM "
	cQuery += RetSqlName("QAA")+ " QAA, "+RetSqlName("QI5")+" QI5 "
	cQuery += "WHERE "
	cQuery += "	QAA.QAA_FILIAL 	= QI5.QI5_FILMAT AND "
	cQuery += "	QAA.QAA_MAT 	= QI5.QI5_MAT	 AND "
	cQuery += "	QI5.QI5_FILIAL	>= '"+cFilDe+"'  AND QI5.QI5_FILIAL	<= '"+cFilAte+"' AND "
	cQuery += "	QI5.QI5_CODIGO	>= '"+cAcaoDe+"' AND QI5.QI5_CODIGO	<= '"+cAcaoAte+"' AND "
	cQuery += "	QI5.QI5_REV		>= '"+cRevADe+"' AND QI5.QI5_REV	<= '"+cRevAAte+"' AND "
	cQuery += "	QI5.QI5_FILMAT  BETWEEN '"+cFilDeUsr+"' AND '"+cFilAteUsr+"' AND "
	cQuery += "	QI5.QI5_MAT  BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' AND "
	cQuery += "	QI5.QI5_PRAZO	>= '"+cAnoDe+"' AND QI5.QI5_PRAZO <= '"+cAnoAte+"' AND "
	If cQncBale == "2"
		cQuery += "	QI5.QI5_PEND	= 'S' AND "
	EndIf
	cQuery += "	QI5.QI5_STATUS	<> '4' AND "
	cQuery += "	QAA.D_E_L_E_T_ = ' ' AND "
	cQuery += "	QI5.D_E_L_E_T_ = ' ' "
EndIf

If nTipoPen == 1
        	cQuery += "UNION "
       	EndIf

// QI3 - Plano de Acoes
If nTipoPen == 1 .Or. nTipoPen == 3
	cQuery += "SELECT "
	cQuery += "	QAA.QAA_FILIAL,QAA.QAA_MAT,QAA.QAA_NOME "
	cQuery += "FROM "
	cQuery += RetSqlName("QAA")+ " QAA, "+RetSqlName("QI3")+" QI3 "
	cQuery += "WHERE "       	
	cQuery += "	QAA.QAA_FILIAL 	= QI3.QI3_FILMAT AND "
	cQuery += "	QAA.QAA_MAT 	= QI3.QI3_MAT	 AND "
	cQuery += "	QI3.QI3_FILIAL	>= '"+cFilDe+"' AND QI3.QI3_FILIAL	<= '"+cFilAte+"' AND "
	cQuery += "	QI3.QI3_CODIGO	>= '"+cAcaoDe+"' AND QI3.QI3_CODIGO	<= '"+cAcaoAte+"' AND "
	cQuery += "	QI3.QI3_REV		>= '"+cRevADe+"' AND QI3.QI3_REV	<= '"+cRevAAte+"' AND " 
	cQuery += " QI3.QI3_FILMAT  BETWEEN '"+cFilDeUsr+"' AND '"+cFilAteUsr+"' AND "
	cQuery += "	QI3.QI3_MAT  BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' AND "
	cQuery += "	QI3.QI3_ENCPRE >= '"+cAnoDe+"' AND QI3.QI3_ENCPRE <= '"+cAnoAte+"' AND "
	cQuery += "	QI3.QI3_ENCREA = '        ' AND "
	cQuery += "	QAA.D_E_L_E_T_ = ' ' AND "
	cQuery += "	QI3.D_E_L_E_T_ = ' ' "
EndIf

If nTipoPen == 1
        	cQuery += "UNION "
       	EndIf

// QI2 - Nao Conformidades
If nTipoPen == 1 .Or. nTipoPen == 2
	cQuery += "SELECT "
	cQuery += "	QAA.QAA_FILIAL,QAA.QAA_MAT,QAA.QAA_NOME "
	cQuery += "FROM "
	cQuery += RetSqlName("QAA")+ " QAA, "+RetSqlName("QI2")+" QI2 "
	cQuery += "WHERE "
	cQuery += "	QAA.QAA_FILIAL 	= QI2.QI2_FILRES AND "
	cQuery += "	QAA.QAA_MAT 	= QI2.QI2_MATRES AND "
	cQuery += "	QI2.QI2_FILIAL	>= '"+cFilDe+"'  AND QI2.QI2_FILIAL	<= '"+cFilAte+"' AND "
	cQuery += "	QI2.QI2_FNC		>= '"+cFncDe+"'  AND QI2.QI2_FNC	<= '"+cFncAte+"' AND "
	cQuery += "	QI2.QI2_REV		>= '"+cRevFDe+"' AND QI2.QI2_REV	<= '"+cRevFAte+"' AND "  
	cQuery += " QI2.QI2_FILRES  BETWEEN '"+cFilDeUsr+"' AND '"+cFilAteUsr+"' AND "
	cQuery += "	QI2.QI2_MATRES  BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' AND "
	cQuery += "	( 	(QI2.QI2_CONREA = '        ' AND QI2.QI2_CONPRE = '      ') OR "
	cQuery += "		(QI2.QI2_CONREA = '        ' AND QI2.QI2_CONPRE <> '      ' AND (QI2.QI2_CONPRE >= '"+cAnoDe+"' AND QI2.QI2_CONPRE <= '"+cAnoAte+"'))	) AND "
	cQuery += "	QAA.D_E_L_E_T_ = ' ' AND "
	cQuery += "	QI2.D_E_L_E_T_ = ' ' "
EndIf
		
cQuery += "GROUP BY QAA.QAA_FILIAL,QAA.QAA_MAT,QAA.QAA_NOME"
cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQAA,.T.,.T.)

(cAliasQAA)->(DbGoTop())


While (cAliasQAA)->(!Eof()) .And. cFilDeUsr <= (cAliasQAA)->QAA_FILIAL .And. cFilAteUsr >= (cAliasQAA)->QAA_FILIAL
	If (cAliasQAA)->QAA_MAT >= cMatDe .And. (cAliasQAA)->QAA_MAT <= cMatAte
        
        lPrimeira := .T.

		// Etapas/Passos do Plano de Acao
		If nTipoPen == 1 .Or. nTipoPen == 4
			oSection1:Init()

				cAliasQI5 := "QI5TRB"
				
				cQuery := "SELECT "
				cQuery += "		QI5.QI5_FILMAT,QI5.QI5_MAT,QI5.QI5_CODIGO,QI5.QI5_REV,QI5.QI5_TPACAO,QI5.QI5_STATUS,QI5.QI5_PRAZO "
				cQuery += "FROM "+RetSqlName("QI5")+" QI5 "
				cQuery += "WHERE "
				cQuery += "	QI5.QI5_FILIAL	>= '"+cFilDe+"'  AND QI5.QI5_FILIAL	<= '"+cFilAte+"' AND "
				cQuery += "	QI5.QI5_CODIGO	>= '"+cAcaoDe+"' AND QI5.QI5_CODIGO	<= '"+cAcaoAte+"' AND "
				cQuery += "	QI5.QI5_REV		>= '"+cRevADe+"' AND QI5.QI5_REV	<= '"+cRevAAte+"' AND "
				cQuery += " QI5.QI5_FILMAT  =  '"+(cAliasQAA)->QAA_FILIAL+"' AND "
				cQuery += "	QI5.QI5_MAT     =  '"+(cAliasQAA)->QAA_MAT+"' AND "
				cQuery += "	QI5.QI5_PRAZO	>= '"+cAnoDe+"' AND QI5.QI5_PRAZO <= '"+cAnoAte+"' AND "
				If cQncBale == "2"
					cQuery += "	QI5.QI5_PEND	= 'S' AND "
				EndIf
				cQuery += "	QI5.QI5_STATUS	<> '4' AND "
				cQuery += "	QI5.D_E_L_E_T_ = ' ' "
				cQuery := ChangeQuery(cQuery)
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQI5,.T.,.T.)
				
				(cAliasQI5)->(DbGoTop())

				If (cAliasQI5)->(!Eof())
					If lPrimeira
						oReport:SkipLine(1) 
						oReport:ThinLine()
						oReport:PrintText(OemToAnsi(STR0009+" "+(cAliasQAA)->QAA_FILIAL+"-"+(cAliasQAA)->QAA_MAT+" "+(cAliasQAA)->QAA_NOME),oReport:Row(),025) // "Usuario:"
						oReport:SkipLine(1)	
						oReport:ThinLine()
						oReport:SkipLine(1)	
						lPrimeira := .F.
					Endif
		
					While (cAliasQI5)->(!Eof()) .And. (cAliasQAA)->QAA_FILIAL+(cAliasQAA)->QAA_MAT == (cAliasQI5)->QI5_FILMAT+(cAliasQI5)->QI5_MAT
						oSection1:PrintLine()
						(cAliasQI5)->(dbSkip())
					Enddo	
				Endif
		
			(cAliasQI5)->(DbCloseArea())
		Endif
			
		// Ficha Ocorrencia/Nao-conformidade
		If nTipoPen == 1 .Or. nTipoPen == 3
			oSection2:Init() 

			cAliasQI3 := "QI3TRB"

			cQuery := "SELECT "
			cQuery += "	QI3.QI3_FILMAT,QI3.QI3_MAT,QI3.QI3_CODIGO,QI3.QI3_REV,QI3.QI3_ABERTU,QI3.QI3_ENCPRE,QI3.QI3_STATUS,QI3.QI3_TIPO "
			cQuery += "FROM "
			cQuery += RetSqlName("QI3")+" QI3 "
			cQuery += "WHERE "       	
			cQuery += "	QI3.QI3_FILIAL	>= '"+cFilDe+"' AND QI3.QI3_FILIAL	<= '"+cFilAte+"' AND "
			cQuery += "	QI3.QI3_CODIGO	>= '"+cAcaoDe+"' AND QI3.QI3_CODIGO	<= '"+cAcaoAte+"' AND "
			cQuery += "	QI3.QI3_REV		>= '"+cRevADe+"' AND QI3.QI3_REV	<= '"+cRevAAte+"' AND "
			cQuery += " QI3.QI3_FILMAT  =  '"+(cAliasQAA)->QAA_FILIAL+"' AND "
			cQuery += "	QI3.QI3_MAT     =  '"+(cAliasQAA)->QAA_MAT+"' AND "				
			cQuery += "	QI3.QI3_ENCPRE >= '"+cAnoDe+"' AND QI3.QI3_ENCPRE <= '"+cAnoAte+"' AND "
			cQuery += "	QI3.QI3_ENCREA = '        ' AND "
			cQuery += "	QI3.D_E_L_E_T_ = ' ' "
			cQuery := ChangeQuery(cQuery)
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQI3,.T.,.T.)
			
			(cAliasQI3)->(DbGoTop())

			If (cAliasQI3)->(!Eof())
				If lPrimeira
					oReport:SkipLine(1) 
					oReport:ThinLine()
					oReport:PrintText(OemToAnsi(STR0009+" "+(cAliasQAA)->QAA_FILIAL+"-"+(cAliasQAA)->QAA_MAT+" "+(cAliasQAA)->QAA_NOME),oReport:Row(),025) // "Usuario:"
					oReport:SkipLine(1)	
					oReport:ThinLine()
					oReport:SkipLine(1)		
					lPrimeira := .F.
				Endif
	
				While (cAliasQI3)->(!Eof()) .And. (cAliasQAA)->QAA_FILIAL+(cAliasQAA)->QAA_MAT == (cAliasQI3)->QI3_FILMAT+(cAliasQI3)->QI3_MAT
					oSection2:PrintLine()
					(cAliasQI3)->(dbSkip())
				Enddo	
			Endif		
			(cAliasQI3)->(DbCloseArea())
		Endif	
		
		// Plano de Acao
		If nTipoPen == 1 .Or. nTipoPen == 2
			
			oSection3:Init()
			cAliasQI2 := "QI2TRB"
			cQuery := "SELECT "
			cQuery += "	QI2.QI2_FILRES,QI2.QI2_MATRES,QI2.QI2_FNC,QI2.QI2_REV,QI2.QI2_OCORRE,QI2.QI2_CONPRE,QI2.QI2_STATUS,QI2.QI2_TPFIC "
			cQuery += "FROM "
			cQuery += RetSqlName("QI2")+" QI2 "
			cQuery += "WHERE "
			cQuery += "	QI2.QI2_FILIAL	>= '"+cFilDe+"'  AND QI2.QI2_FILIAL	<= '"+cFilAte+"' AND "
			cQuery += "	QI2.QI2_FNC		>= '"+cFncDe+"'  AND QI2.QI2_FNC	<= '"+cFncAte+"' AND "
			cQuery += "	QI2.QI2_REV		>= '"+cRevFDe+"' AND QI2.QI2_REV	<= '"+cRevFAte+"' AND " 
			cQuery += " QI2.QI2_FILRES  =  '"+(cAliasQAA)->QAA_FILIAL+"' AND "
			cQuery += "	QI2.QI2_MATRES  =  '"+(cAliasQAA)->QAA_MAT+"' AND "				
			cQuery += "	( 	(QI2.QI2_CONREA = '        ' AND QI2.QI2_CONPRE = '      ') OR "
			cQuery += "		(QI2.QI2_CONREA = '        ' AND QI2.QI2_CONPRE <> '      ' AND (QI2.QI2_CONPRE >= '"+cAnoDe+"' AND QI2.QI2_CONPRE <= '"+cAnoAte+"'))	) AND "
			cQuery += "	QI2.D_E_L_E_T_ = ' ' "
			cQuery := ChangeQuery(cQuery)
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQI2,.T.,.T.)
			(cAliasQI2)->(DbGoTop())

			If (cAliasQI2)->(!Eof())
				If lPrimeira
					oReport:SkipLine(1)
					oReport:ThinLine()
					oReport:PrintText(OemToAnsi(STR0009+" "+(cAliasQAA)->QAA_FILIAL+"-"+(cAliasQAA)->QAA_MAT+" "+(cAliasQAA)->QAA_NOME),oReport:Row(),025) // "Usuario:"
					oReport:SkipLine(1)
					oReport:ThinLine()
					oReport:SkipLine(1)
					lPrimeira := .F.
					lCabFirst := .T.
				Endif
				
				While (cAliasQI2)->(!Eof())
					If (cAliasQAA)->QAA_FILIAL+(cAliasQAA)->QAA_MAT == (cAliasQI2)->QI2_FILRES+(cAliasQI2)->QI2_MATRES
						oSection3:PrintLine()
					Endif
					(cAliasQI2)->(dbSkip())
				End
			Endif
			(cAliasQI2)->(DbCloseArea())
		Endif


	If nSalta == 1	// Salta pagina 
		If nTipoPen == 3
			oSection1:SetPageBreak(.T.) 
		ElseIF 	nTipoPen == 2
				oSection2:SetPageBreak(.T.) 		
			Else	
				oSection1:SetPageBreak(.T.) 				
			Endif
		Endif		
    Endif

	(cAliasQAA)->(dbSkip())
    
	oSection1:Finish()
	oSection2:Finish()
	oSection3:Finish()

Enddo

(cAliasQAA)->(DbCloseArea())

Return NIL
