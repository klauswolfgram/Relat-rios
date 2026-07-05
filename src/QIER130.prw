/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FILEIO.CH"
#INCLUDE "QIER130.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "TOTVS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER130  ³ Autor ³ Leandro S. Sabino     ³ Data ³ 24/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Indice de Qualidade - PRODUTO X FORNECEDOR (ACUM/MENSAL)   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs:      ³ (Versao Relatorio Personalizavel) 		                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130	                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
*/
User Function QIER130()
Local oReport
Private cTituloImp   := ""
Private lExistChart := FindFunction("QIEMGRAFIC") .AND. GetBuild() >= "7.00.170117A" //controle se executa o grafico modelo novo ou por DLL

Pergunte("QER130",.F.)
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 24/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oSection1 
Local cDesc1  := STR0001	//"Serao impressos os Indices de Qualidade dos Produtos"
Local cDesc2  := STR0002  //"amarrados ao Fornecedor."
Private oReport                                             

DEFINE REPORT oReport NAME "QIER130" TITLE STR0007 PARAMETER "QER130" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
DEFINE SECTION oSection1 OF oReport TABLES "QEV" TITLE STR0031 // "Indices de Qualidade"
DEFINE CELL NAME "cIQF"  OF oSection1 ALIAS "QEV" TITLE AllTrim(TitSX3("QEV_IQF")[1]) SIZE 120

Return oReport


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R130IMPR3³ Autor ³ Marcelo Pimentel      ³ Data ³ 01.06.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R130ImpR3(oReport)
Local cKey      := ""
Local cCond     := ""
Local cArq1     := ""
Local cMesIni
Local cMesFim
Local cAnoIni
Local cAnoFim
Local nCtAM     := 1
Local cAlias    := ""
Local nOrd      := 0
Local nQtMesAcu := IIf(GetNewPar("MV_QMESACU",6)>0,GetNewPar("MV_QMESACU",6),6)
Local nJ        := 0
Local aAnoMes[nQtMesAcu]
Local aOrd      := {"QEV","QEW","QF1","QE0","QE6","QEG","QED","QA8","SA2"}  // Salvo a Ordem aqui
Local aFatIQP   := {}
Local aIndIQF   := {}
Local lContinua := .T., cAliasQry

Local cDbms     := ""
 
Local oSection1  := oReport:Section(1)

Local cFiltroUser 

Default mv_par01 := Year(dDatabase)
Default mv_par02 := Month(dDatabbase)
Default mv_par03 := ""
Default mv_par04 := ""

cAlias := Alias()
nOrd   := IndexOrd()

For nJ := 1 To Len(aOrd)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Redefino toda a matriz com base nos indices   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea(aOrd[nJ])
	aOrd[nJ] := { aOrd[nJ], IndexOrd() }
Next nJ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria a estrutura do arquivo temporario                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
r130ArqTmp()

lAbortPrint := .F. // Vari vel P£blica utilizada na IncRegua()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Preenche os Fatores do IQP no Array aFatIQP          		 ³
//³ [x,1] - Codigo do Fator                             		 ³
//³ [x,2] - Descricao do Fator (PORT/ING/ESP)            		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QED->(dbSetOrder(1))
QED->(dbSeek(xFilial("QED")))
While QED->(!Eof()) .And. xFilial("QED") == QED->QED_FILIAL
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao considera laudo com categoria Liberado Urgente no  ³
	//³  relatorio porque na geracao, ja considerou como       ³
	//³  Aprovado Total.                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If QED->QED_CATEG # "4"
		Aadd(aFatIQP,{QED->QED_CODFAT,If(mv_par06==1,QED->QED_DESCPO,;
		If(mv_par06==2,QED->QED_DESCIN,QED->QED_DESCES)),0})
	EndIf
	QED->(dbSkip())
EndDo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Preenche os Indices do IQF no Array aIndIQF          		 ³
//³ [x,1] - Codigo do Indice                           		     ³
//³ [x,2] - Descricao do Indice (PORT/ING/ESP)            		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QF1->(dbSetOrder(1))
QF1->(dbSeek(xFilial("QF1")))
While QF1->(!Eof()) .And. xFilial("QF1") == QF1->QF1_FILIAL
	If QF1->QF1_CALC == "I"
		Aadd(aIndIQF,{QF1->QF1_INDICE,If(mv_par06==1,QF1->QF1_DESCRI,;
						  If(mv_par06==2,QF1->QF1_DESCIN,QF1->QF1_DESCES))})
	EndIf
	QF1->(dbSkip())
EndDo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria a regua de leitura no QEV			                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QEV->(dbSetOrder(3)) // Ano+Mes+Produto+Fornecedor
cKey := QEV->(IndexKey())

If mv_par05 == 1

	MakeSqlExpr(oReport:uParam)
			
	oSection1:BeginQuery()
				
	BeginSQL alias "TRB"
	
		SELECT QEV.*
		FROM %table:QEV% QEV
		WHERE
		QEV_ANO = %Exp:Str(mv_par01,4)% AND
		QEV_MES = %Exp:StrZero(mv_par02,2)% AND
		QEV_PRODUT >= %Exp:mv_par03% AND
		QEV_PRODUT <= %Exp:mv_par04% AND
		(QEV_LOTENT>0 OR QEV_LOTDEM>0 OR QEV_LOTINS>0 OR
		QEV_LOTSKP>0 OR QEV_QTDREJ>0 OR QEV_QTDINS>0 OR
		QEV_QTDSKP>0) AND QEV.%notDel%
		ORDER BY QEV_FILIAL,QEV_ANO,QEV_MES,QEV_PRODUT,QEV_FORNEC
	
	EndSql

	oSection1:EndQuery()
	cAliasQry := "TRB"
	
Else

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Calculo de acumulo de meses de acordo com o Parametro MV_QMESACU       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aFill(aAnoMes,"")
	cAnoIni    := Str(mv_par01,4)
	cAnoFim	   := Str(mv_par01,4)
	cMesIni    := StrZero(mv_par02,2)
	cMesFim	   := StrZero(mv_par02,2)
	aAnoMes[1] := cAnoFim+StrZero(Val(cMesFim),2)

	// conta os £ltimos n(MV_QMESACU) meses em aAnoMes
	If nQtMesAcu > 1	
		While .T.
			cMesIni := StrZero(Val(cMesIni)-1,2)
			If cMesIni == "00"
				cAnoIni := StrZero(Val(cAnoIni)-1,4)
				cMesIni := "12"
			EndIf
			nCtAM++
			aAnoMes[nCtAM] := cAnoIni + cMesIni
			If nCtAM == nQtMesAcu
				Exit
			EndIf
		EndDo
	Endif

	aSort(aAnoMes)
	cMesIni := Right(aAnoMes[1],2)
	cAnoIni := Left(aAnoMes[1],4)
	cMesFim := Right(aAnoMes[nQtMesAcu],2)
	cAnoFim := Left(aAnoMes[nQtMesAcu],4)
	
	
	MakeSqlExpr(oReport:uParam)
		    
	oSection1:BeginQuery()
	
	cDbMs := Alltrim(TcGetDb())
	cCond := "SELECT * FROM "
	cCond += RetSqlName("QEV")
	cCond += " WHERE "
	cCond += " QEV_FILIAL = '"+xFilial("QEV")+"' AND "
	cCond += " QEV_PRODUT >= '"+mv_par03+"' AND "
	cCond += " QEV_PRODUT <= '"+mv_par04+"' AND "
	IF cDbMs$("MSSQL7,MSSQL")
		cCond += " (QEV_ANO + QEV_MES) >= '"+(cAnoIni+cMesIni)+"' AND "
		cCond += " (QEV_ANO + QEV_MES) <= '"+(cAnoFim+cMesFim)+"' AND "
	Else
		cCond += " (QEV_ANO || QEV_MES) >= '"+(cAnoIni+cMesIni)+"' AND "
		cCond += " (QEV_ANO || QEV_MES) <= '"+(cAnoFim+cMesFim)+"' AND "
	EndIF
	cCond += " (QEV_LOTENT>0 OR QEV_LOTDEM>0 OR QEV_LOTINS>0 OR "
	cCond += " QEV_LOTSKP>0 OR QEV_QTDREJ>0 OR QEV_QTDINS>0 OR "
	cCond += " QEV_QTDSKP>0) AND"
	cCond += " D_E_L_E_T_ = ''"
	cCond += " ORDER BY " + SqlOrder(cKey)
	
	cCond := ChangeQuery(cCond)
	
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cCond),"TRB", .F., .T.)
		
	oSection1:EndQuery()
	cAliasQry := "TRB"
EndIf

If (cAliasQry)->(Bof()) .And. (cAliasQry)->(Eof())
	Set Device to Screen
	Help(" ",1,"QE_NAOIQ")	// "Nao ha Indice de Qualidade com os dados especificados."
	lContinua := .F.
EndIf

If Len(aFatIQP) == 0 
	Help(" ",1,"QENAOIQP")	// "Nao existem Fatores do IQP cadastrados
	lContinua := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a Leitura no QEV                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While (cAliasQry)->(!Eof()) .And. lContinua 

	If lAbortPrint
		lContinua := .F.
		Loop
	EndIf
    
	//Verifica pasta filtro da SetPrint
	If !Empty(cFiltroUser) .and. !(cAliasQry)->(&cFiltroUser)
		(cAliasQry)->(dbSkip())
		Loop		      
    Endif
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se existe laudos (QEW) para este relat¢rio (QEV)             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r130GrvLau(	(cAliasQry)->QEV_FORNEC,(cAliasQry)->QEV_PRODUT,(cAliasQry)->QEV_ANO,;
				(cAliasQry)->QEV_MES,aFatIQP)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava os Indices(QEV), e verifica a existencia no TMP				  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r130GrvInd(	(cAliasQry)->QEV_FORNEC,(cAliasQry)->QEV_PRODUT,cAliasQry)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Grava o  QE0, somente com o QF1_CALC == "I".             	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	r130GrvQE0(	(cAliasQry)->QEV_FORNEC,(cAliasQry)->QEV_PRODUT,(cAliasQry)->QEV_ANO,;
				(cAliasQry)->QEV_MES,aIndIQF)

	(cAliasQry)->(dbSkip())

EndDo

TRB->(dbCloseArea())

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 24/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Imprimir os campos do relatorio                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport(oReport)
Local aArea      := GetArea()
Local aAvlFor    := {}
Local aCabec     := {}
Local aForIQF    := Nil
Local aForPPM    := Nil
Local aForQE0    := Nil
Local aForQEV    := Nil
Local aForQEW    := Nil
Local aLegPrd    := Nil
Local aLinDet1   := Nil
Local aLinDet2   := Nil
Local aMscPad    := {}
Local cArqSPC    := ""
Local cCab1      := Nil
Local cCab2      := Nil
Local cCabec1    := Nil
Local cCabec2    := Nil
Local cCateg     := ""
Local cDir       := GetMv("MV_QDIRGRA")
Local cForPrd    := ""
Local cIndQE0    := 0
Local cIQF       := ""
Local cLaudo     := ""
Local cTit       := ""
Local cTituloImp := ""
Local lFirst     := Nil
Local lImpGraf   := Nil
Local lImprime   := .F.
Local nForIQS    := 0
Local nIQF       := 0
Local nIteMed    := 0
Local nLin       := 0
Local nMedPrd    := 0
Local nPos       := 0
Local nQtdIns    := 0
Local nQtdSkp    := 0
Local nT         := 0
Local nVlrInd    := 0
Local nVlrIQF    := 0
Local nVlrPPM    := 0
Local nVlrRej    := 0
Local nW         := 0
Local nX         := 0
Local nY         := 0
Local nZ         := 0
Local oQIEXFunAx := NIL
Local oQLGrafico := GraficosQualidadeX():New()
Local oSection1  := oReport:Section(1)

R130ImpR3(oReport)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o diretorio do grafico e um  diretorio Local ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par07 == 1
	If !QA_VerQDir(cDir)  
		Return
	Endif
EndIf 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTit        := If(mv_par05 == 1,If(mv_par06 == 1," - MENSAL",If(mv_par06 == 2," - MONTHLY","")),If(mv_par06 == 1," - ACUMULADO",If(mv_par06 == 2," - ACUMULATED"," - ACUMULADO")))
cTituloImp  := If(mv_par06==1,"Produto x Fornecedor",Iif(mv_par06==2,"Product x Supplier","Producto x Proveedor"))+cTit

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Preenche o Vetor com as linhas padronizadas                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aMscPad,"|----------------------------------------------------------------------------------------------------------------------------------|")
Aadd(aMscPad,"|##################################|###########|###########|###########|###########|###########|###########|###########|###########|")
Aadd(aMscPad,"|==================================================================================================================================|")
Aadd(aMscPad, If(mv_par06==1, "Legenda      Codigo      Fornecedor",;
				  If(mv_par06==2,"Legend       Code        Supplier",;
					 	  		  "Leyenda      C¢digo      Proveedor")))
Aadd(aMscPad,"-------      ------      ----------------------------------------")
Aadd(aMscPad," #####       ######      ##############################################################################################    ")
Aadd(aMscPad,"|##################################|                                                ###########                                    |")
Aadd(aMscPad,"------------------------------------------------------------------------------------------------------------------------------------")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta o Array com a Descricao das Avaliacoes dos Fornecedores³
//³ [x] - Descricao em PORT/ING/ESP                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd(aAvlFor,If(mv_par06==1,"Entradas no periodo",; 
				 If(mv_par06==2,"Period Deliveries",;
		        				 "Entradas en el Per¡odo")))
Aadd(aAvlFor,If(mv_par06==1,"Entradas demeritadas no periodo",;
	             If(mv_par06==2,"Period Demerited Deliveries",;
	                		     "Entradas sim meritos en el periodo")))
Aadd(aAvlFor,If(mv_par06==1,"Resultado das Entradas (IQP)",;
	             If(mv_par06==2,"Delivery Results (IQP)",;
	                			 "Resultado de las Entradas (ICP)")))
Aadd(aAvlFor,If(mv_par06==1,"Fator de criticidade",;
	             If(mv_par06==2,"Criticism Factor",;
	                			 "Factor de Criticidad")))
Aadd(aAvlFor,If(mv_par06==1,"Sistema da Qualidade (IQS)",;
	             If(mv_par06==2,"Quality System (IQS)",;
	                			 "Sistema de Calidad (ICS)")))
Aadd(aAvlFor,If(mv_par06==1,"Indice Qualidade do Produto (IQI)",;
	             If(mv_par06==2,"Product Quality Index (IQI)",;
	                			 "Indice Calidad del Producto (ICI)")))
Aadd(aAvlFor,If(mv_par06==1,"Pontualidade (IPO)",;
	             If(mv_par06==2,"Punctuality (IPO)",;
	             			     "Puntualidad (IPU)")))
Aadd(aAvlFor,If(mv_par06==1,"Indice mensal (IQF)",;
	             If(mv_par06==2,"Month Index (IQF)",;
	                 			 "Indice Mensual (ICPv)")))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio da Impressao do Relatorio                  		     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TMP->(dbGoTop())

While TMP->(!Eof())
	m_pag    := 1 //Inicia uma nova pagina por produto
	cForPrd  := TMP->PRODUT
	aForQEW  := {}
	aForQEV  := {}
	aForQE0  := {}
	aForIQF  := {}
	aForPPM  := {}
	
	For nX := 1 to (Len(aAvlFor)-1) //nao considera o IQF
		Aadd(aForQEV,{})
	Next
	
	cLaudo   := ""
	cIndQE0  := ""
	nIQF     := 0
	aLegPrd  := {}
	nVlrPPM  := 0
    nVlrRej  := 0
	nQtdIns  := 0
	nQtdSkp  := 0
	lImpGraf := .F.
			
	While TMP->(!Eof()) .And. cForPrd == TMP->PRODUT

		If !Empty(TMP->LAUDO) .And. Empty(TMP->INDICE) //laudos
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Preenche o Vetor aForQEW com a primeira parte do relatorio   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If cLaudo # TMP->LAUDO
				cLaudo := TMP->LAUDO
				Aadd(aForQEW,{})
			EndIf
			
			Aadd(aForQEW[Len(aForQEW)],{TMP->DESCFIQP,TMP->FORNEC,TMP->QTDLAUD,TMP->NOMEFOR})
			
			//Preenche o Vetor com as legendas
			nPos := Ascan(aLegPrd,{|x|x[2]==TMP->FORNEC})
				
			If nPos == 0
				Aadd(aLegPrd,{"("+StrZero(Len(aLegPrd)+1,3)+")",TMP->FORNEC,TMP->NOMEFOR}) 
			EndIf
				
		ElseIf Empty(TMP->LAUDO) .And. Empty(TMP->INDICE) //indices
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Preenche o Vetor aForQEV com a segunda parte do relatorio    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			For nX := 1 to (Len(aAvlFor)-1)

				If 	 nX == 1 //Entradas no periodo
					nVlrInd := TMP->LOTENT
						
				ElseIf nX == 2 //Entradas demeritadas no periodo
					nVlrInd :=  TMP->LOTDEM
						
				ElseIf nX == 3 //Resultados das Entradas (IQP)
					nVlrInd := If(mv_par05==1,TMP->IQP,TMP->IQPA)
					
				ElseIf nX == 4 //Fator de criticidade
					nVlrInd :=  If(mv_par05==1,TMP->IQD,TMP->IQDA)
						
				ElseIf nX == 5 //Sistema de Qualidade (IQS)
					nVlrInd :=  TMP->IQS
					
				ElseIf nX == 6 //Indice de Qualidade do Produto (IQI)
					nVlrInd :=  If(mv_par05==1,TMP->IQI,TMP->IQIA)
						
				ElseIf nX == 7 //Pontualidade (IPO)
					nVlrInd :=  If(mv_par05==1,TMP->IPO,TMP->IPOA)
												
				EndIf

				Aadd(aForQEV[nX],{aAvlFor[nX],TMP->FORNEC,nVlrInd})
			Next

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ preenche o IQF no aForIQF								   	 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Aadd(aForIQF,{aAvlFor[8],TMP->FORNEC,TMP->IQF,TMP->IQFA})

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ preenche o PPM no aForPPM							         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Aadd(aForPPM,{STR0006,TMP->FORNEC,TMP->PPM}) //PPM
	        nVlrRej+=TMP->QTDREJ
            nQtdIns+=TMP->QTDINS
            nQtdSkp+=TMP->QTDSKP
			
		ElseIf Empty(TMP->LAUDO) .And. !Empty(TMP->INDICE) //indices informados
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Preenche o Vetor aForQE0 com a terceira parte do relatorio   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If cIndQE0 # TMP->INDICE
				cIndQE0 := TMP->INDICE
				Aadd(aForQE0,{})
			EndIf
			
			Aadd(aForQE0[Len(aForQE0)],{TMP->DESCCPM,TMP->FORNEC,TMP->VALOR})
						
		EndIf
			
		TMP->(dbSkip())
		lImprime := If(lImprime,lImprime,.T.)
		lImpGraf :=	If(mv_par07==1,.T.,lImpGraf)

	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calculo da Media                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nX := 1 To Len(aForQEW)
		nMedPrd := 0
		Aadd(aForQEW[nX],{"","",0, ""})
		For nW := 1 To Len(aForQEW[nX])
			nMedPrd += aForQEW[nX,nW,3]
		Next nW	
		aForQEW[nX,Len(aForQEW[nX]),3] := nMedPrd
		aForQEW[nX,Len(aForQEW[nX]),1] := aForQEW[nX,1,1] //pega a descricao do primeiro item
	Next
	
	For nX := 1 To Len(aForQEV)
		nMedPrd := 0
		nIteMed := Len(aForQEV[nX])
		Aadd(aForQEV[nX],{"","",0, ""})
	   For nW := 1 To Len(aForQEV[nX])
			nMedPrd += If(aForQEV[nX,nW,3]#999.99,aForQEV[nX,nW,3],0)
		Next nW	
		
		//Nao realiza o calculo da Media se igual Entradas no Periodo/Entradas Demeritadas
		If nX <= 2 
		  aForQEV[nX,Len(aForQEV[nX]),3] := nMedPrd
		Else
			aForQEV[nX,Len(aForQEV[nX]),3] := nMedPrd/nIteMed
		    If nX == 5 //guarda o IQS
		    	nForIQS := nMedPrd/nIteMed
		    EndIf
		EndIf
		aForQEV[nX,Len(aForQEV[nX]),1] := aForQEV[nX,1,1] //pega a descricao do primeiro item
	Next

	For nX := 1 To Len(aForQE0)
		nMedPrd := 0
		Aadd(aForQE0[nX],{"","",0, ""})
	   For nW := 1 To Len(aForQE0[nX])
			nMedPrd += aForQE0[nX,nW,3]
		Next nW	
		aForQE0[nX,Len(aForQE0[nX]),3] := nMedPrd/(Len(aForQE0[nX])-1)
		aForQE0[nX,Len(aForQE0[nX]),1] := aForQE0[nX,1,1] //pega a descricao do primeiro item
	Next

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a media do IQF  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nVlrIQF := 0
	Aeval(aForIQF,{|x,y|nVlrIQF+=If(aForIQF[y,3]#999.99,aForIQF[y,3],0)})
	Aadd(aForIQF,{"","",0,0})
	aForIQF[Len(aForIQF),3] := (nVlrIQF/(Len(aForIQF)-1))
	aForIQF[Len(aForIQF),1] := aForIQF[1,1] //pega a descricao do primeiro item

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 
	//³ Calcula a media do IQF Acumulado  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nVlrIQFa := 0
	Aeval(aForIQF,{|x,y|nVlrIQFa+=If(aForIQF[y,4]#999.99,aForIQF[y,4],0)})
	aForIQF[Len(aForIQF),4] := (nVlrIQFa/(Len(aForIQF)-1))
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula a media do PPM  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ       
	nVlrPPM := (nVlrRej/(nQtdIns+nQtdSkp))*1000000
	Aadd(aForPPM,{ "","",0})
	aForPPM[Len(aForPPM),3] := nVlrPPM
	aForPPM[Len(aForPPM),1] := aForPPM[1,1] //pega a descricao do primeiro item

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Relatorio                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nZ := 1
	
	While lImprime
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pesquisa o Produto no QE6                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		QE6->(dbSetOrder(1))
		QE6->(MsSeek(xFilial("QE6")+cForPrd))
	
		cCabec1	:=	If(mv_par06 == 1,"Produto    :",If(mv_par06 == 2,"Product    :","Producto   :"))+;
		               AllTrim(cForPrd)+" - "+If(mv_par06 == 1,QE6->QE6_DESCPO,If(mv_par06==2,QE6->QE6_DESCIN,QE6->QE6_DESCES))
		cCabec2	:= If(mv_par06 == 1,"Mes / Ano  : ",If(mv_par06 == 2,"Month/Year :","Mes / A¤o  : "))+StrZero(mv_par02,2)+" / " +Str(mv_par01,4)

		oSection1:Init()
		oReport:SkipLine(1) 
		oReport:ThinLine()
		oReport:PrintText(cCabec1,oReport:Row(),025) 
		oReport:SkipLine(1)	                         
		oReport:PrintText(cCabec2,oReport:Row(),025) 
		oReport:SkipLine(1)	                         		
		oReport:ThinLine()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Realiza o Calculo da Media do IQF Acumulado					 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nIQF := NoRound(q130MediaIQF(aForIQF))

		//Posiciona QEG (Sit. Produto X Fornecedor) no valor mais próximo do IQF encontrado e retorna a classificao atual.
		If FINDCLASS( "QIEXFunAuxClass" )
			oQIEXFunAx := QIEXFunAuxClass():New()
			cCateg := oQIEXFunAx:PosicionaNaQEGeRetornaCategoriaMaisProximaDoIQFEncontrado(nIQF, nForIQS, mv_par06)
		EndIf

		If mv_par05 == 1
			cIQF := "-M"
		Else
			cIQF := "-A"
		Endif

		oSection1:Cell("cIQF"):SetValue(cIQF+"    : "+AllTrim(Str(nIQF)) + " - " + cCateg) 
		oSection1:PrintLine()
		oSection1:Finish()

		lFirst  := .T.

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do QEW                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len(aForQEW)
		    aLinDet1 := Afill(Array(9),"")
			aLinDet2 := Afill(Array(9),"")
			nT 	   := 0	
			For nY := nZ To Len(aForQEW[nX])
				nT++
				If nY == Len(aForQEW[nX])
					nT := If(nT#8,8,nT) 
				EndIf
				
				//Cabecalho da Linha detalhe
				If lFirst
					aLinDet1[1]    := If(mv_par06 == 1,"Fornecedores",If(mv_par06 == 2,"Suppliers","Proveedores"))
					aLinDet1[nT+1] := If(nY==Len(aForQEW[nX]),;
					                       If(mv_par06==1,"Total/Media",If(mv_par06==2,;
					                          "Total/Avg","Total/Promd")),PadC("("+StrZero(nY,3)+")",11))
				EndIf	
			
				//Linha Detalhe
				aLinDet2[1]    := aForQEW[nX,nY,1]
				alinDet2[nT+1] := If(aForQEW[nX,nY,3]==0,"",Right(Str(NoRound(aForQEW[nX,nY,3],4)),11))

				If nT >= 8
					Exit
				EndIf

			Next nY
			
			If lFirst
		
				lFirst := .F.
				U_FmtLi(,aMscPad[8],,,@nLin,,,,oReport)
				U_FmtLi(aLinDet1,aMscPad[2],,,@nLin,,,,oReport)
				U_FmtLi(,aMscPad[3],,,@nLin,,,,oReport)
				
			EndIf

			U_FmtLi(aLinDet2,aMscPad[2],"999999999",,@nLin,,,,oReport)
			U_FmtLi(,aMscPad[1],,,@nLin,,,,oReport)
		
		Next nX
		//Final da Impressao do QEW

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do QEV                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len(aForQEV)
			aLinDet2 := Afill(Array(9),"")
			nT       := 0	
			For nY := nZ To Len(aForQEV[nX])
				nT++
				If nY == Len(aForQEV[nX])
					nT := If(nT#8,8,nT)
				EndIf
				
				//Linha Detalhe
				aLinDet2[1]    :=	aForQEV[nX,nY,1]
				
				If  nX == 1 .Or. nX == 2 //Entradas no Periodo e Demeritadas
					alinDet2[nT+1] := If(aForQEV[nX,nY,3]==0,"",;
										   If(aForQEV[nX,nY,3]==999.99,;
										      If(Len(aForQEV[nX])==nY,"",;
										      PadC(If(mv_par06==3,"No Ap.","N/A"),11)),;
										      NoRound(aForQEV[nX,nY,3],4)))
				ElseIf nX == 5 //Caso seja o IQS, adiciona somente o segundo elemento
					alinDet2[2] := NoRound(aForQEV[nX,nY,3],4)

				Else
					alinDet2[nT+1] := If(aForQEV[nX,nY,3]==999.99,;
					                       If(Len(aForQEV[nX])==nY,"",;
										      PadC(If(mv_par06==3,"No Ap.","N/A"),11)),;
										      NoRound(aForQEV[nX,nY,3],4))
				EndIf
				
				If nT >= 8
					Exit
				EndIf

			Next nY

			If nX <= 2 // Imprime Entradas no Periodo e Demeritadas
				U_FmtLi(aLinDet2,aMscPad[2],"@ 999999999",,@nLin,,,,oReport)
			Else
				U_FmtLi(aLinDet2,aMscPad[2],"@R 999999.99",,@nLin,,,,oReport)
			EndIf	
			U_FmtLi(,aMscPad[If(nX>1,3,1)],,,@nLin,,,,oReport)
		
		Next nX
		//Final da Impressao do QEV
				
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do QE0                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 To Len(aForQE0)
		   aLinDet2 := Afill(Array(9),"")
			nT       := 0	
			For nY := nZ To Len(aForQE0[nX])
				nT++
				If nY == Len(aForQE0[nX])
					nT := If(nT#8,8,nT)
				EndIf
				
				//Linha Detalhe
				aLinDet2[1]    := aForQE0[nX,nY,1]
			    alinDet2[nT+1] := If(aForQE0[nX,nY,3]==0,;
				  					   If(Len(aForQE0[nX])==nY,"",;
									  	   PadC(If(mv_par06==3,"No Ap.","N/A"),11)),;
										   NoRound(aForQE0[nX,nY,3],4))
				If nT >= 8
					Exit
				EndIf

			Next nY
			U_FmtLi(aLinDet2,aMscPad[2],"@R 999999.99",,@nLin,,,,oReport)
			U_FmtLi(,aMscPad[3],,,@nLin,,,,oReport)
		
		Next nX
		//Final da Impressao do QE0

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do IQF                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aLinDet2 := Afill(Array(9),"")
		nT       := 0	
		For nX := nZ To Len(aForIQF)
			nT++

			If nX == Len(aForIQF)
				nT := If(nT#8,8,nT)
			EndIf
				
			//Linha Detalhe
			aLinDet2[1]    :=	aForIQF[nX,1]
			if mv_par05 ==1	.Or. mv_par09 = 2  // Mensal ou nao faz media acumulada
				 alinDet2[nT+1] := If(aForIQF[nX,3]==999.99,PadC("N/A",11),NoRound(aForIQF[nX,3],4))
			else           // Acumulado
    			 alinDet2[nT+1] := If(aForIQF[nX,4]==999.99,PadC("N/A",11),NoRound(aForIQF[nX,4],4))
    		Endif	 
				
			If nT >= 8
				Exit
			EndIf

		Next nX
			
		U_FmtLi(aLinDet2,aMscPad[2],"@R 999999.99",,@nLin,,,,oReport)
		U_FmtLi(,aMscPad[3],,,@nLin,,,,oReport)
        //Final da Impressao do IQF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do PPM                                             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aLinDet2 := Afill(Array(9),"")
		nT 		:= 0	
		For nX := nZ To Len(aForPPM)
			nT++

			If nX == Len(aForPPM)
				nT := If(nT#8,8,nT)
			EndIf
				
			//Linha Detalhe
			aLinDet2[1]    :=	aForPPM[nX,1]
			alinDet2[nT+1] := If(aForPPM[nX,3]==0,"",NoRound(aForPPM[nX,3],4))
				
			If nT >= 8
				Exit
			EndIf

		Next nX
			
		U_FmtLi(aLinDet2,aMscPad[2],"@R 999999999",,@nLin,,,,oReport)
		U_FmtLi(,aMscPad[3],,,@nLin,,,,oReport)
		@ nLin,00 PSAY ""		
		nLin++
      	//Final da Impressao do PPM
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao da Legenda dos Fornecedores	                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		U_FmtLi(,aMscPad[4],,,@nLin,,,,oReport)
		U_FmtLi(,aMscPad[5],,,@nLin,,,,oReport)
		
		nT := 0
		For nX := nZ to Len(aLegPrd)
			nT++
				
			U_FmtLi(aLegPrd[nX],aMscPad[6],,,@nLin,,,,oReport)
			If nT >= 8
				Exit
			EndIf

		Next nX
		//Final da Impressao da legenda

		nZ := (nY+1)
		If nZ > Len(aForQEW[Len(aForQEW)])
			lImprime := .F.
		EndIf	
		
	EndDo	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Final da Impressao do Relatorio                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Realiza a impressao do Grafico                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpGraf .And. mv_par07 == 1 //Imprime Grafico
		lImpGraf := .F.
               
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Encerra o Spool de Impressao    							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	    Set Device to Screen
   		Set Print to
	   	MS_FLUSH()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Gera o Nome do arquivo do Grafico							 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For nX := 1 to 99999
			cArqSPC := "QIE" + StrZero(nX,4) + ".SPC"
			If !File(Alltrim(cDir)+cArqSPC)
				Exit
			EndIf
		Next nI

		IF lExistChart //controle se executa o grafico modelo novo ou por DLL
			For nX := 1 to 99999
				cArqPNG := "QIE" + StrZero(nX,4) + ".PNG"
				If !File(oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG)
					Exit
				EndIf
			Next nX
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Monta o Cabecalho a ser enviado para a QACHART.DLL			 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    Aadd(aCabec,Repl("_",132))
    	cCab1 := AllTrim(SM0->M0_NOME)
	    cCab2 := RptFolha+" "+TRANSFORM(m_pag++,'999999')+Space(2)
    	nPos  := 132 - (Len(cCab1)+Len(cCab2))
	    Aadd(aCabec,cCab1+Space(nPos)+cCab2)
	    cCab1 := "SIGA /"+"QIER130"+"/v."+cVersao
	    cCab2 := RptDtRef+" "+DtoC(dDataBase)
	    nPos  := 132 -(Len(cCab1)+Len(cCab2))
	    Aadd(aCabec,(cCab1 + PadC(AllTrim(STR0007),nPos) + cCab2))
	    cCab1 := RptHora+" "+Time()
	    cCab2 := RptEmiss+" "+Dtoc(MsDate())
	    nPos  := 132 -(Len(cCab1)+Len(cCab2))
	    Aadd(aCabec,cCab1+Space(nPos)+cCab2)
	    Aadd(aCabec,Repl("_",132))
	    Aadd(aCabec,cCabec1)
	    Aadd(aCabec,cCabec2)
	    Aadd(aCabec,Repl("_",132))

		Qer130MSPC(aForIQF,cArqSPC,cDir,aCabec,cArqPNG,oReport)

		If lExistChart //controle se executa o grafico modelo novo ou por DLL
			cImgGraf := oQLGrafico:retorna_Local_Imagens_Graficos()+cArqPNG
			//Imprime o grafico no relatorio
				  //SayBitmap( < nLinha>, < nCol>, < cBitmap>, [ nWidth], [ nHeight] )
			oReport:SayBitmap(1800, 100, cImgGraf, 667 * 3, (550 * 3) - 30) //667 * 3, (550 * 3) - 30
			oSection1:SetPageBreak(.T.) 
		EndIf 

		oReport:EndPage()
		
   	EndIf	
	oSection1:SetPageBreak(.T.) 
EndDo

TMP->(DbCloseArea())


RestArea(aArea)
   
Return(NIL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³FmtLi     ³ Autor ³ Juan Jose Pereira     ³ Data ³ 04.01.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Formata linha para impressao                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FmtLi(aValores,cFundo,cPictN,cPictC,nLin,lImprime,bCabec,nTamLin,oReport)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis da funcao                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cConteudo:='', cLetra:=''
Local nPos:=0, i:=0, j:=0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sets para a Funcao, mudar se necessario			             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cPictNPad:='@E 999,999,999.99'
Local cPictCPad:='@!'
Local cCharOld  :='#'
Local cCharBusca:='±'
Local cTipoFundo:=ValType(cFundo)
Local nFor:=1
Local cAlias := Alias()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Troca # por cCharBusca pois existem dados com # que devem    ³
//³ ser impressos corretamente.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cTipoFundo == "C"
	cFundo:=StrTran(cFundo,cCharOld,cCharBusca)
ElseIf cTipoFundo == "A"
	For i:=1 to Len(cFundo)
		cFundo[i]:=StrTran(cFundo[i],cCharOld,cCharBusca)
	Next i
EndIf

aValores:=Iif(Empty(aValores),{},aValores)
aValores:=Iif(cTipoFundo=="C",aValores,{})
lImprime:=Iif(lImprime==NIL,.t.,lImprime)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Substitue o caracter cCharBusca por "_" nas strings          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nFor:=1 To Len(aValores)
	If ValType(aValores[nFor])=="C"
		If At(cCharBusca,aValores[nFor]) > 0
			aValores[nFor]:=StrTran(aValores[nFor],cCharBusca,"_")
		EndIf
	EndIf
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Rotina de substituicao                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For i:=1 to Len(aValores)
	If ValType(aValores[i])=='A'
		If !Empty(aValores[i,2])
			cConteudo:=Transform(aValores[i,1],aValores[i,2])
		Else
			If ValType(aValores[i,1])=='N'
				cConteudo:=Str(aValores[i,1])
			Else
				cConteudo:=aValores[i,1]
			EndIf
		EndIf
	Else
		cPictN:=Iif(Empty(cPictN),cPictNPad,cPictN)
		cPictC:=Iif(Empty(cPictC),cPictCPad,cPictC)
		aValores[i]:=Iif(aValores[i]==NIL,"",aValores[i])
		If ValType(aValores[i])=='N'
			cConteudo:=Transform(aValores[i],cPictN)
		Else
			cConteudo:=Transform(aValores[i],cPictC)
		EndIf
	EndIf
	nPos:=0
	cFormato:=""
	nPos:=At(cCharBusca,cFundo)
	If nPos>0
		cLetra:=cCharBusca
		j:=nPos
		While cLetra==cCharBusca
			cLetra:=Substr(cFundo,j,1)
			If cLetra==cCharBusca
				cFormato+=cLetra
			EndIf
			j++
		End
		If Len(cFormato)>Len(cConteudo)
			If ValType(aValores[i]) <> 'N'
				cConteudo+=Space(Len(cFormato)-Len(cConteudo))
			Else
				cConteudo := Space(Len(cFormato)-Len(cConteudo))+ cConteudo	
			EndIf
		Endif
		cFundo:=Stuff(cFundo,nPos,Len(cConteudo),cConteudo)
	EndIf
Next
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime linha formatada                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lImprime
	If cTipoFundo=="C"
		oReport:SkipLine(1) 
		oReport:PrintText(cFundo,oReport:Row(),025) 
	Else
		For i:=1 to Len(cFundo)
			oReport:SkipLine(1) 
			oReport:PrintText(cFundo[i],oReport:Row(),025) 
		Next
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve array de dados com mesmo tamanho mas vazio        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aValores)>0
	aValores:=Array(Len(aValores))
EndIf

DbSelectArea(cAlias)

RETURN (cFundo)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r130ArqTmp³ Autor ³ Paulo Emidio de Barros³ Data ³ 07/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria a estrutura temporaria do arquivo de trabalho         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r130ArqTmp()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r130ArqTmp()
Local aTam    := {}
Local aCampos := {}
Local cDesc   := ""

aTam := TamSX3("QEV_PRODUT")
Aadd(aCampos,{"PRODUT","C",aTam[1],aTam[2]})
aTam := TamSX3("QEV_LOTENT")
Aadd(aCampos,{"LOTENT","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_LOTDEM")
Aadd(aCampos,{"LOTDEM","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQP")
Aadd(aCampos,{"IQP","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQPA")
Aadd(aCampos,{"IQPA","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQD")
Aadd(aCampos,{"IQD","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQDA")
Aadd(aCampos,{"IQDA","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQS")
Aadd(aCampos,{"IQS","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQI")
Aadd(aCampos,{"IQI","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQIA")
Aadd(aCampos,{"IQIA","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IPO")
Aadd(aCampos,{"IPO","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IPOA")
Aadd(aCampos,{"IPOA","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQF")
Aadd(aCampos,{"IQF","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQFA")
Aadd(aCampos,{"IQFA","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_QTDREJ")
Aadd(aCampos,{"QTDREJ","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_QTDINS")
Aadd(aCampos,{"QTDINS","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_QTDSKP")
Aadd(aCampos,{"QTDSKP","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_FORNEC")
Aadd(aCampos,{"FORNEC","C",aTam[1],aTam[2]})
aTam := TamSX3("QEW_LAUDO")
Aadd(aCampos,{"LAUDO","C",aTam[1],aTam[2]})
aTam := TamSX3("QEW_QTDLAUD")
Aadd(aCampos,{"QTDLAUD","N",aTam[1],aTam[2]})
aTam := TamSX3("QE0_INDICE")
Aadd(aCampos,{"INDICE","C",aTam[1],aTam[2]})
cDesc := If(mv_par06==1,"QF1_DESCRI",If(mv_par06==2,"QF1_DESCIN","QF1_DESCES"))
aTam := TamSX3(cDesc)
Aadd(aCampos,{"DESCCPM","C",aTam[1],aTam[2]})
aTam := TamSX3("QE0_VALOR")
Aadd(aCampos,{"VALOR","N",aTam[1],aTam[2]})
cDesc := If(mv_par06==1,"QED_DESCPO",If(mv_par06==2,"QED_DESCIN","QED_DESCES"))
aTam  := TamSX3(cDesc)
Aadd(aCampos,{"DESCFIQP","C",aTam[1],aTam[2]})
aTam := TamSX3("A2_NOME")
Aadd(aCampos,{"NOMEFOR","C",aTam[1],aTam[2]})
Aadd(aCampos,{"PPM",   "N", 17, 2})

oTempTable := FWTemporaryTable():New( "TMP" )
oTempTable:SetFields( aCampos )
oTempTable:AddIndex("indice1", {"PRODUT","LAUDO","INDICE","FORNEC"} )
oTempTable:Create()

TMP->(dbSetOrder(1))

Return(NIL)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r130GvrLau³ Autor ³ Paulo Emidio de Barros³ Data ³ 07/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os Laudos relacionados no TMP					      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r130GrvLau(Fornecedor,Produto,Ano,Mes,FatorIQP)            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r130GrvLau(pFornec,pProdut,pAno,pMes,pFatIQP)
Local nX 	  := 0
Local cNomFor := ""
Local lFound, cAliasQry := "QEW"
Local cCond   := ""
Local bCondicao := { ||	(cAliasQry)->(!Eof()) .And.;
						xFilial("QEW") == (cAliasQry)->QEW_FILIAL 	.And.;
			      		(cAliasQry)->QEW_FORNEC == pFornec 		 	.And.;
		    	  		(cAliasQry)->QEW_PRODUT == pProdut 		 	.And.;
			      		(cAliasQry)->QEW_ANO    == pAno    		 	.And.;
				   		(cAliasQry)->QEW_MES	 == pMes }
Local cDbms     :=  Alltrim(TcGetDb())


SA2->(dbSetOrder(1))
If SA2->(MsSeek(xFilial("SA2")+pFornec))
	cNomFor := SA2->A2_NOME
EndIf	

QEW->(dbSetOrder(1))
	
cCond := "SELECT * FROM "
cCond += RetSqlName("QEW")
cCond += " WHERE "
cCond += "QEW_FILIAL = '" + xFilial("QEW") + "' AND "
cCond += "QEW_FORNEC = '" + pFornec + "' AND "
cCond += "QEW_PRODUT = '" + pProdut + "' AND "
cCond += "QEW_ANO = '" + pAno + "' AND "
cCond += "QEW_MES = '" + pMes + "' AND "
cCond += "D_E_L_E_T_ = ''"

cCond := msparse(cCond,cDbMs,.t.)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,cCond),"TRW", .F., .T.)
   
cAliasQry := "TRW"

For nX := 1 To Len(pFatIQP)
    pFatIQP[nX,3] := 0
Next
    
If 	Eval(bCondicao) .Or.	QEW->(MsSeek(xFilial("QEW")+pFornec+pProdut+pAno+pMes))

	While 	Eval(bCondicao)
		nX := Ascan(pFatIqp, { |x| x[1] = (cAliasQry)->QEW_LAUDO })
		If TMP->(dbSeek(	(cAliasQry)->QEW_PRODUT+(cAliasQry)->QEW_LAUDO+"    "+;
							(cAliasQry)->QEW_FORNEC))
			RecLock("TMP",.F.)
			TMP->QTDLAUD := TMP->QTDLAUD + (cAliasQry)->QEW_QTDLAUD
		Else
			RecLock("TMP",.T.)	
			TMP->FORNEC   := (cAliasQry)->QEW_FORNEC
			TMP->PRODUT   := (cAliasQry)->QEW_PRODUT
			TMP->LAUDO    := (cAliasQry)->QEW_LAUDO
			TMP->DESCFIQP := pFatIQP[nX,2]
		   	TMP->QTDLAUD  := (cAliasQry)->QEW_QTDLAUD
			TMP->NOMEFOR  := cNomFor
		EndIf
		pFatIQP[nX,3] ++
		TMP->(MsUnLock())
		(cAliasQry)->(dbSkip())
	EndDo
Endif

TRW->(dbCloseArea())
	
For nX := 1 To Len(pFatIQP)
    If pFatIQP[nX,3] = 0
		If mv_par05 == 2 //Acumulado
			lFound := TMP->(dbSeek(pProdut+pFatIQP[nX,1]+"    "+pFornec))
		Else	
			lFound := .F.
		EndIf

		If (!lFound)
			RecLock("TMP",.T.)	
			TMP->FORNEC   := pFornec
			TMP->PRODUT   := pProdut
			TMP->LAUDO    := pFatIQP[nX,1]
			TMP->DESCFIQP := pFatIQP[nX,2]
			TMP->QTDLAUD  := 0
			TMP->NOMEFOR  := cNomFor
			TMP->(MsUnLock())
		EndIf
	EndIf
Next

Return(NIL)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r130GvrInd³ Autor ³ Paulo Emidio de Barros³ Data ³ 07/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava os Indices relacionados no TMP						  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r130GrvInd(Fornecedor,Produto)                     		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r130GrvInd(pFornec,pProdut,cAliasQry)
Local nPPM := 0
Local nIQS := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Entradas no Periodo                                           ³
//³Entradas Demeritadas no Periodo                               ³
//³Resultado das Entradas ( IQP )                                ³
//³Fator de Criticidade                                          ³
//³Sistema da qualidade (IQS)                                    ³
//³Indice Qualidade do Produto ( IQI )                           ³
//³Pontualidade ( IPO )                                          ³
//³Indice Mensal ( IQF )                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If (cAliasQry)->QEV_IQS == 999.99	// IQS
	If SuperGetMv("MV_QEIQSNA") == "S"	// Utiliza menor fator como IQS
		QA8->(dbSetOrder(2))
		QA8->(MsSeek(xFilial("QA8")+Str(0.00,6,2),.T.))
		nIQS := QA8->QA8_FATSUP
	EndIf
Else
	nIQS := (cAliasQry)->QEV_IQS
EndIf

If TMP->(!dbSeek(pProdut+" "+"    "+pFornec))
	RecLock("TMP",.T.)
	TMP->PRODUT := (cAliasQry)->QEV_PRODUT
	TMP->LOTENT := (cAliasQry)->QEV_LOTENT
	TMP->LOTDEM := (cAliasQry)->QEV_LOTDEM
	TMP->QTDREJ := (cAliasQry)->QEV_QTDREJ
	TMP->QTDINS := (cAliasQry)->QEV_QTDINS
	TMP->QTDSKP := (cAliasQry)->QEV_QTDSKP
	TMP->FORNEC := (cAliasQry)->QEV_FORNEC

	If mv_par05 == 1 
		TMP->IQP 	:= (cAliasQry)->QEV_IQP
		TMP->IQD 	:= (cAliasQry)->QEV_IQD
		TMP->IQI 	:= (cAliasQry)->QEV_IQI
		TMP->IPO 	:= (cAliasQry)->QEV_IPO
	Else
		TMP->IQPA   := (cAliasQry)->QEV_IQPA
		TMP->IQDA   := (cAliasQry)->QEV_IQDA
		TMP->IQIA   := (cAliasQry)->QEV_IQIA
		TMP->IPOA   := (cAliasQry)->QEV_IPOA
	EndIf   
	TMP->IQS  := nIQS
	TMP->IQF  := (cAliasQry)->QEV_IQF
	TMP->IQFA := (cAliasQry)->QEV_IQFA
	
Else
	RecLock("TMP",.F.)
	If mv_par05 == 2  
		TMP->LOTENT := TMP->LOTENT + (cAliasQry)->QEV_LOTENT  // Lotes Entregues
		TMP->LOTDEM := TMP->LOTDEM + (cAliasQry)->QEV_LOTDEM  // Lotes 'demeritados'
		TMP->IQPA   := (cAliasQry)->QEV_IQPA    				// Acumulado
		TMP->IQDA   := (cAliasQry)->QEV_IQDA    
		TMP->IQIA   := (cAliasQry)->QEV_IQIA
		TMP->IPOA   := (cAliasQry)->QEV_IPOA
	Endif                                         
	TMP->IQS  := nIQS
	TMP->IQF  := (cAliasQry)->QEV_IQF
	TMP->IQFA := (cAliasQry)->QEV_IQFA
	
	TMP->QTDREJ := TMP->QTDREJ + (cAliasQry)->QEV_QTDREJ
	TMP->QTDINS := TMP->QTDINS + (cAliasQry)->QEV_QTDINS
	TMP->QTDSKP := TMP->QTDSKP + (cAliasQry)->QEV_QTDSKP
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Calculo do PPM = (QtdRej / (QtdInspec + QtdSkpLot)) * 1000000³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPPM     := ((cAliasQry)->QEV_QTDREJ/((cAliasQry)->QEV_QTDINS+(cAliasQry)->QEV_QTDSKP))*1000000
TMP->PPM := nPPM
TMP->(MsUnLock())

Return(NIL)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³r130GvrQE0³ Autor ³ Paulo Emidio de Barros³ Data ³ 08/06/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava os registro do QE0 no TMP,somente com o QF1_CALC=="I".³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ r130GrvQE0(Fornecedor,Produto,Ano,Mes,IndiceIQF)			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER130                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function r130GrvQE0(pFornec,pProdut,pAno,pMes,pIndIQF)
Local nX    := 0

For nX := 1 To Len(pIndIQF)
	If TMP->(dbSeek(pProdut+" "+pIndIQF[nX,1]+pFornec))
		QE0->(dbSetOrder(1))
		If QE0->(MsSeek(xFilial("QE0")+pAno+pMes+pFornec+pProdut+pIndIQF[nX,1]))
		   RecLock("TMP",.F.)
			TMP->VALOR  := TMP->VALOR + QE0->QE0_VALOR
			TMP->(MsUnLock())
		EndIf	
	Else
		RecLock("TMP",.T.)
		
		QE0->(dbSetOrder(1))
		If QE0->(MsSeek(xFilial("QE0")+pAno+pMes+pFornec+pProdut+pIndIQF[nX,1]))
			TMP->VALOR  := QE0->QE0_VALOR
		EndIf
		TMP->INDICE := pIndIqf[nX,1]
		TMP->DESCCPM:= pIndIQF[nX,2]
		TMP->PRODUT := pProdut
		TMP->FORNEC := pFornec
		TMP->(MsUnLock())
	EndIf	
Next

Return(NIL)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³QER130MSPC³ Autor ³ Marcelo Pimentel      ³ Data ³29/05/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera arquivo (SPC) para gerar o grafico					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ QER130MSPC()          									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QIER130   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function QER130MSPC(aForIQF,cArqSPC,cDir,aCabec,cArqPNG,oReport)
Local aValores	:= {}
Local cValor	:= {}
Local cTipo		:= Iif(MV_PAR05 == 1 , STR0023 , STR0024)	//'Mensal'###'Acumulado'
Local nC		:= 0
Local nVlrTot	:= 0
Local lRetGraf
Local nAcumulo := If(mv_par05==1,3,4)
Local cSenhas	:= "1"
Local aDad64	:= {}

Aadd(aValores,"QACHART.DLL - BARRA")
Aadd(aValores,"[TITULO]")
Aadd(aValores,STR0007+cTipo)	//"Produto x Fornecedor"
Aadd(aValores,"[TITULOX]")
Aadd(aValores,STR0026)			//"Produto"
Aadd(aValores,"[TITULOY]")
Aadd(aValores,"IQF")
Aadd(aValores,"[INICIO DE DADOS]")
For nC := 1 To (Len(aForIQF)-1)//nao adiciona a Media
	nVlrTot+=aForIQF[nC,nAcumulo]
	cValor :=StrTran(Alltrim(Str(aForIQF[nc,nAcumulo])),".",",")
	Aadd(aValores,StrZero(nC,2)+";"+cValor)
	Aadd(aDad64,{nVlrTot,StrZero(nC,2)})
Next nC                        
Aadd(aValores,"IQF;"+StrTran(Alltrim(Str(nVlrTot/(Len(aForIQF)-1))),".",","))
Aadd(aDad64,{SuperVal(AllTrim(Str(nVlrTot/(Len(aForIQF)-1)))),"IQF"})
Aadd(aValores,"[FIM DE DADOS]")
Aadd(aValores,"[INICIO DO CABECALHO]")
For nC := 1 To Len(aCabec)
	Aadd(aValores,aCabec[nC])
Next nC
Aadd(aValores,"[FIM DO CABECALHO]")

Aadd(aValores,"[LANGUAGE]")
Aadd(aValores,Upper(__Language) )

IF lExistChart //controle se executa o grafico modelo novo ou por DLL
	QIEMGRAFIC(aDad64, 6,/* aMedicoes */, {"Produto x Fornecedor - MENSAL"}, ,cDir, cArqPNG)
ELSE
	lRetGraf := GeraTxt32(aValores,cArqSPC, cDir)

	If lRetGraf             

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Carrega a DLL para Impressao do Grafico					     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		CallDll32("ShowChart",cArqSPC,"7",cDir,"7",If(!Empty(cSenhas),Encript(Alltrim(cSenhas),0),"PADRAO"))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Deleta o Arquivo SPC                                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fErase(Alltrim(cDir)+cArqSPC)
		
	EndIf
ENDIF

Return(NIL)            

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Q130MediaIQF³ Autor ³ Marcelo Pimentel    ³ Data ³11/07/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Realiza o calculo da Media do IQF					      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ Q130MediaIQF(EXPA1)  								 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ QIER130   												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Q130MediaIQF(aIQF)
Local nForIQF := 0
Local nIQF    := 0                 
Local nMedia  := 0          
Local nPosIQF 

If mv_par05 == 1 //Indice: 1=Mensal/2=Acumulado           
	If mv_par08 == 1
		nPosIQF := 4
	Else		
		nPosIQF := 3
	EndIf	
Else            
	nPosIQF := 4
EndIf

For nForIQF := 1 to (Len(aIQF)-1)
	If aIQF[nForIQF,nPosIQF] # 999.99 
		nIQF += aIQF[nForIQF,nPosIQF]
		nMedia ++
	EndIf
Next nForIQF 
                           
nIQF := nIQF/nMedia

Return(nIQF)
