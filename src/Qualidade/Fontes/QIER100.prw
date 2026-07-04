/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER100.CH"
#Include "PROTHEUS.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QIER100   ºAutor  ³Leandro Sabino      º Data ³  30/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Indice de Qualidade do Produto                             º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QIER100()
Local oReport

Pergunte("QER100",.F.) 
oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER100                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local ctitulo   := STR0003 //"Indice de Qualidade do Produto"
Local cDesc1	:= OemToAnsi(STR0001) // "Este programa ir  emitir o relat¢rio de padr”es a calibrar."
Local cDesc2	:= OemToAnsi(STR0002) // "Este programa ir  emitir o relat¢rio de padr”es a calibrar."

Local oSection1 

DEFINE REPORT oReport NAME "QIER100" TITLE cTitulo PARAMETER "QER100" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)
oReport:SetLandscape(.T.)

DEFINE SECTION oSection1 OF oReport TABLES "QEV","QE6" TITLE OemToAnsi(STR0028)
DEFINE CELL NAME "QEV_FORNEC"  OF oSection1 ALIAS "QEV" TITLE TITSX3("QEV_FORNEC")[1] SIZE 50 BLOCK {||AllTrim(QEV->QEV_FORNEC)+" - "+SA2->A2_NOME }
DEFINE CELL NAME "QEV_PRODUT"  OF oSection1 ALIAS "QEV" 
DEFINE CELL NAME "cPRODUT"     OF oSection1 ALIAS "QE6" TITLE TITSX3("QE6_DESCPO")[1]SIZE TamSx3("QE6_DESCPO")[1] BLOCK {||QE6->QE6_DESCPO + " - " + SA5->A5_CODPRF }

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 30/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Indice de Qualidade do Produto 							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER100                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport)
Local oTempTb1  := NIL
Local oTempTb2  := NIL 
Local oSection1 := oReport:Section(1)
Local CbTxt
Local cbCont    := 00
Local Cabec1    := ""
Local Cabec2    := ""
Local cCateg    := ""
Local cSit      := ""
Local nQtAcum   := 0
Local cMesIni
Local cMesFim
Local cAnoIni
Local cAnoFim
Local nQuant    := 0
Local nQtTot    := 0
Local aMeses    := { STR0006,STR0007,STR0008,STR0009,STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,STR0017 }	//"JAN"###"FEV"###"MAR"###"ABR"###"MAI"###"JUN"###"JUL"###"AGO"###"SET"###"OUT"###"NOV"###"DEZ"
Local nCtAM     := 1
Local nCol      := 141
Local nCol2     := 600
Local nV
Local cFat      := ""
Local nP1
Local n1        := 1
local n2        := 1
Local n3        := 1
Local n4        := 1
Local nPag
Local nPosi     := 0
Local aTotFat   := {}
Local aQE0      := {}
Local nQtMesAcu := GETNEWPAR("MV_QMESACU",6)
Local nQt1		:= 0
Local nQt2		:= 0
Local cComp		:= GetMV("MV_COMP")
Local cIndice	:= ""
Local nPosic	:= 0
Local aTotQE0	:= {}
Local aAnoMes[nQtMesAcu]
Local nOrdQA8   := QA8->(IndexOrd())
Local nOrdQEV   := QEV->(IndexOrd())
Local nOrdQEW   := QEW->(IndexOrd())

Local aCamQEV   := {}
Local aCamFator := {} 
Local nC        := 0
Local cMVQEIQSNA := GetMv("MV_QEIQSNA")

nQtMesAcu := IIf(nQtMesAcu>0,nQtMesAcu,6)

aFill(aAnoMes,"")

dbSelectArea("QEV")
dbSetOrder(1)
If !dbSeek(xFilial("QEV")+Str(mv_par01,4)+StrZero(mv_par02,2)+mv_par03+mv_par04)
	Help(" ",1,"QE_NAOIQ")	// Nao h  Indice de Qualidade com os dados especificados
	dbSelectArea("QEV")
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arquivo de trabalho do QEV									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aCamQEV,{"TMP_ANOM","C",6,0})
aTam := TamSX3("QEV_LOTENT")
aAdd(aCamQEV,{"TMP_LOTENT","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_LOTDEM")
aAdd(aCamQEV,{"TMP_LOTDEM","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQP")
aAdd(aCamQEV,{"TMP_IQP","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQD")
aAdd(aCamQEV,{"TMP_IQD","N",aTam[1],aTam[2]})
aAdd(aCamQEV,{"TMP_IQS","N",6,0})
aTam := TamSX3("QEV_IQI")
aAdd(aCamQEV,{"TMP_IQI","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IPO")
aAdd(aCamQEV,{"TMP_IPO","N",aTam[1],aTam[2]})
aTam := TamSX3("QEV_IQF")
aAdd(aCamQEV,{"TMP_IQF","N",aTam[1],aTam[2]})
oTempTb1 := FWTemporaryTable():New( "TMP" )
oTempTb1:SetFields( aCamQEV )
oTempTb1:AddIndex("indice1", {"TMP_ANOM"} )
oTempTb1:Create()

DbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arquivo de Trabalho do QEW									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam := TamSX3("QEW_LAUDO")
aAdd(aCamFator,{"TRB_LAUDO","C",aTam[1],aTam[2]})
aAdd(aCamFator,{"TRB_ANOM","C", 6, 0})
aTam := TamSX3("QEW_QTDLAU")
aAdd(aCamFator,{"TRB_QTDLAU","N",aTam[1],aTam[2]})
oTempTb2 := FWTemporaryTable():New( "TRB" )
oTempTb2:SetFields( aCamFator )
oTempTb2:AddIndex("indice1", {"TRB_LAUDO","TRB_ANOM"} )
oTempTb2:Create()

DbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona em registros de outros Arquivos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial("SA2")+mv_par03)

dbSelectArea("SA5")
dbSetOrder(2)
dbSeek(xFilial("SA5")+mv_par04+mv_par03)

dbSelectArea("QE6")
dbSetOrder(1)
dbSeek(xFilial("QE6")+mv_par04)

dbSelectArea("QE0")
dbSetOrder(2)

dbSelectArea("QEG")
If !Empty(QEV->QEV_IQFA)
	dbSetOrder(2)
	dbSeek(xFilial("QEG")+Str(QEV->QEV_IQFA,6,2),.T.)
	cCateg := QEG_NIVEL
Else
	cSit:= Iif(GetMv("MV_QASSIQS") == "S","1","2")
	dbSetOrder(1)
	dbSeek(xFilial("QEG")+cSit)
	cCateg := QEG_NIVEL
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calculo dos meses de acumulado de acordo com o Parametro MV_QMESACU    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAnoIni   := cAnoFim	:= Str(mv_par01,4)
cMesIni	  := cMesFim	:= Str(mv_par02,2)
aAnoMes[1]:= cAnoFim+StrZero(Val(cMesFim),2)

If nQtMesAcu > 1
	While .T.
		cMesIni:= StrZero(Val(cMesIni)-1,2)
		If cMesIni == "00"
			cAnoIni := StrZero(Val(cAnoIni)-1,4)
			cMesIni := "12"
		EndIf
		nCtAM := nCtAM + 1
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumulador para todos os fatores                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEW")
dbSetOrder(1)
dbSeek(xFilial("QEW")+mv_par03+mv_par04+cAnoIni+cMesIni,.T.)

While !Eof() .And. xFilial("QEW") == QEW_FILIAL .And. ;
	QEW_ANO+QEW_MES >= cAnoIni+cMesIni .And.;
	QEW_ANO+QEW_MES <= cAnoFim+cMesFim .And.;
	QEW_FORNEC+QEW_PRODUT == mv_par03+mv_par04
	
    DbSelectArea("TRB")
    
 	RecLock("TRB",.T.)
		TRB->TRB_LAUDO	:= QEW->QEW_LAUDO 
 		TRB->TRB_ANOM	:= QEW->QEW_ANO + QEW->QEW_MES
 		TRB->TRB_QTDLAU	:= QEW->QEW_QTDLAU
	MsUnLock()	

	DbSelectArea("QEW")	
	
	dbSkip()
	
EndDo
QEW->(dbSetOrder(nOrdQEW))

dbSelectArea("QEV")
dbSetOrder(2)
dbSeek(xFilial("QEV")+mv_par03+mv_par04+cAnoIni+cMesIni,.T.)

While !Eof() .And. xFilial("QEV") == QEV_FILIAL .And. ;
	QEV_ANO+QEV_MES >= cAnoIni+cMesIni .And.;
	QEV_ANO+QEV_MES <= cAnoFim+cMesFim .And.;
	QEV_FORNEC+QEV_PRODUT == mv_par03+mv_par04
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Ano + Mes                                                     ³
	//³Entradas no Periodo                                           ³
	//³Entradas Demeritadas no Periodo                               ³
	//³Resultado das Entradas ( IQP )                                ³
	//³Fator de Criticidade                                          ³
	//³Sistema da qualidade (IQS)                                    ³
	//³Indice Qualidade do Produto ( IQI )                           ³
	//³Pontualidade ( IPO )                                          ³
	//³Indice Mensal ( IQF )                                         ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    DbSelectArea("TMP")
    
    RecLock("TMP",.T.)
   	TMP->TMP_ANOM	:= QEV->QEV_ANO + QEV->QEV_MES
   	TMP->TMP_LOTENT	:= QEV->QEV_LOTENT
   	TMP->TMP_LOTDEM	:= QEV->QEV_LOTDEM
   	TMP->TMP_IQP   	:= QEV->QEV_IQP
   	TMP->TMP_IQD 	:= QEV->QEV_IQD
   	TMP->TMP_IQS	:= 0
  	TMP->TMP_IQI   	:= QEV->QEV_IQI
   	TMP->TMP_IPO  	:= QEV->QEV_IPO
   	TMP->TMP_IQF 	:= QEV->QEV_IQF
    MsUnLock()
    
    DbSelectArea("QEV")
    
	dbSkip()
EndDo
QEV->(dbSetOrder(1))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta Array aQE0, somente com o QF1_CALC == "I".              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QF1")
dbGoTop()
While !Eof() .And. xFilial("QF1") == QF1_FILIAL
	If QF1_CALC == "I"
		dbSelectArea("QE0")
		dbSeek(xFilial("QE0")+QF1->QF1_INDICE)
		While !Eof() .And. xFilial("QE0") == QE0_FILIAL .And.	;
			QE0_INDICE == QF1->QF1_INDICE
			
			If	QE0_ANO+QE0_MES < cAnoIni+cMesIni .Or.;
				QE0_ANO+QE0_MES > cAnoFim+cMesFim .Or.;
				QE0_FORNEC+QE0_PRODUT != mv_par03+mv_par04
				dbSkip()
				Loop
			EndIf
			
			Aadd( aQE0,{ QE0_ANO+QE0_MES,QE0_INDICE,QF1->QF1_DESCRI,QE0_VALOR } )
			
			dbSkip()
		EndDo
	EndIf
	dbSelectArea("QF1")	
	dbSkip()
EndDo

aQE0 := aSort( aQE0,,,{|x,y| x[2]+x[1]<y[2]+y[1] } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica a quantidade de paginas que serÆo impressas.         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPag := Iif( Len(aAnoMes) > 7 , Int( Len( aAnoMes ) / 7 ) + 1 , 1)

dbSelectArea("QEV")
dbSetOrder(1)
dbSeek(xFilial("QEV")+Str(mv_par01,4)+StrZero(mv_par02,2)+mv_par03+mv_par04)

For nP1 := 1 To nPag
	oSection1:Init()
	oSection1:PrintLine()

	oReport:SkipLine(1)	
	oReport:PrintText(AllTrim(TitSX3("QEV_IQFA")[1])+": "+	Str(QEV->QEV_IQFA) + " - " + cCateg,oReport:Row(),025) 
	oReport:SkipLine(1)	
		
	oReport:PrintText(Replicate("-",130),oReport:Row(),025) 
	oReport:SkipLine(1)	

	oReport:PrintText(STR0027+Iif(cAnoIni<>cAnoFim,cAnoIni+"/"+cAnoFim,cAnoIni),oReport:Row(),025) //"  Ano:"
	oReport:PrintText("|",oReport:Row(),600) 

	nCol:= 640
	For n1:=n1 To 8 * nP1
		If n1 == 8 * nP1 .And. nP1 == nPag
			oReport:PrintText(STR0026+"|",oReport:Row(),nCol) //" ACUMULADO  "
		Else
			oReport:PrintText(Iif(Len(aAnoMes)>=n1,aMeses[Val(Subs(aAnoMes[n1],5,2))],"   ")+ "    |",oReport:Row(),nCol) 
		EndIf
		nCol+=140
	Next n1++

    oReport:SkipLine(1)	
	oReport:PrintText(Replicate("=",130),oReport:Row(),025) 
	oReport:SkipLine(1)	

	dbSelectArea("QED")
	dbSetOrder(1)
	dbSeek(xFilial("QED"))
	While !Eof() .And. xFilial("QED") == QED_FILIAL
		// Nao mostra laudo com categoria Liberado Urgente porque no calculo,
		// foi considerado como Aprovado
		If QED_CATEG <> "4"
			cFator:= QED_CODFAT
			oReport:PrintText(QED_DESCPO,oReport:Row(),025) 
			
			If nP1 > 1
				n2 := 8 * ( nP1-1 ) + 1
			EndIf
		
			For n2 := n2 To 8 * nP1
				If n2 == 8 * nP1 .And. nP1 == nPag
					nPosi:= AsCan(aTotFat,{|x| x[1] == QED_CODFAT})
					If nPosi <> 0
						nQtTot := aTotFat[nPosi,2]
					Else
						nQtTot := 0
					EndIf
					oReport:PrintText(Iif(nQtTot==0,space(10),Str(nQtTot,10))+"|",oReport:Row(),1600) 
					nQtTot:=0
					Exit
				EndIf
				If Len(aAnoMes) >= n2

					DbSelectArea("TRB")
					If DbSeek(QED->QED_CODFAT+aAnoMes[n2])
					
						nPosi := AsCan(aTotFat,{|x| x[1] == QED->QED_CODFAT})
						If nPosi <> 0
							aTotFat[nPosi,2] += TRB->TRB_QTDLAUD
						Else
							Aadd(aTotFat,{QED->QED_CODFAT,TRB->TRB_QTDLAUD})
						EndIf
						nQuant := TRB->TRB_QTDLAUD
						nQtTot += nQuant
						
					EndIf
					oReport:PrintText(Iif(nQuant == 0,Space(10),Str(nQuant,10))+"|",oReport:Row(),nCol2) 
					nQuant :=0
					DbSelectArea("QED")
				Else
					oReport:PrintText(Space(10)+"|",oReport:Row(),nCol2) 
				EndIf
				nCol2 +=140
			Next n2++
		    
			n2:=1
			nQuant:=0
			nQtTot:=0
			nCol2:=600
			oReport:PrintText("|",oReport:Row(),600) 
			oReport:SkipLine(1)	 
			
			oReport:PrintText( Replicate("_",130),oReport:Row(),025) 
			oReport:SkipLine(1)	

		EndIf
		dbSkip()
	EndDo 
	
	nCol2:=600
	
	QA8->(dbSetOrder(2))
		
	For nV := 1 To 8
	
		If nV == 1
			cFat:= STR0018	//"Entradas no periodo"
		ElseIf nV == 2
			cFat:= STR0019	//"Entradas demeritadas no periodo"
		ElseIf nV == 3
			cFat:= STR0020	//"Resultado das Entradas (IQP)"
			nQtAcum:=QEV->QEV_IQPA
		Elseif nV == 4
			cFat:= STR0021	//"Fator de criticidade"
			nQtAcum:=QEV->QEV_IQDA
		Elseif nV == 5
			cFat:= STR0022	//"Sistema da Qualidade (IQS)"
			nQtAcum:=QEV->QEV_IQS
		ElseIf nV == 6
			cFat:= STR0023	//"Indice Qualidade do Produto (IQI)"
			nQtAcum:=QEV->QEV_IQIA
		ElseIf nV == 7
			cFat:= STR0024	//"Pontualidade (IPO)"
			nQtAcum:=QEV->QEV_IPOA
		ElseIf nV == 8
			cFat:= STR0025	//"Indice mensal (IQF)"
			nQtAcum:=QEV->QEV_IQFA
		EndIf
	
		oReport:PrintText(cFat,oReport:Row(),025) 
		If nV<>5
		
			If nP1 > 1
				n3 := 8 * ( nP1-1 ) + 1
			EndIf
			
			For n3 := n3 To 8 * nP1
			
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprime Acumulados                                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If n3 == 8 * nP1 .And. nP1 == nPag
					If AllTrim(Str(nV)) $ "1/2"
						oReport:PrintText(Iif(AllTrim(Str(nV)) == "1",Str(nQt1,09),Str(nQt2,09))+" |",oReport:Row(),1600) 
					Else
						oReport:PrintText(Str(nQtAcum,09,2)+" |",oReport:Row(),1600) 
					EndIf
					Exit
				EndIf
				If Len(aAnoMes) >= n3

					DbSelectArea("TMP")

					If DbSeek(aAnoMes[n3])
						nQuant := FieldGet(nV+1)
						
						If AllTrim(Str(nV)) == "1"
							nQt1+=nQuant
						ElseIf AllTrim(Str(nV)) == "2"
							nQt2+=nQuant
						EndIf
					EndIf

					If AllTrim(Str(nV)) $ "1/2"
						oReport:SkipLine(-1)	
						oReport:PrintText(Iif(nQuant==0,Space(10),Str(nQuant,10))+"|",oReport:Row(),nCol2) 
					Else
						oReport:SkipLine(-1)	
						oReport:PrintText(Iif(nQuant == 999.99.Or.!Found(),"    N/A   ",Str(nQuant,10,2))+"|",oReport:Row(),nCol2) 
					EndIf
					nQuant:=0
				Else
					oReport:PrintText(Space(9)+" |",oReport:Row(),nCol2) 
				EndIf
				nCol2+=140
				oReport:PrintText("|",oReport:Row(),600) 
			Next
			n3:=1
			nQtAcum:=0
			nCol2:=600
		Else
			If QEV->QEV_IQS == 999.99	// IQS
				If cMVQEIQSNA == "S"	// Utiliza menor fator como IQS
					QA8->(dbSeek(xFilial("QA8")+Str(0.00,6,2),.T.))
					oReport:PrintText("|"+Space(36)+Str(QA8->QA8_FATSUP,9,2)+Space(28)+"|",oReport:Row(),600) 
				Else		
					oReport:PrintText("|"+Space(36)+"N/A"+Space(34)+"|",oReport:Row(),600) 
				EndIf
			Else	
				oReport:PrintText("|"+Space(36)+Str(QEV->QEV_IQS,9,2)+Space(28)+"|",oReport:Row(),600) 
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime os Indices Informados (QE0)                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nV == 7
			For nC := 1 To Len(aQE0)
				If cIndice <> aQE0[nC,2]
					oReport:SkipLine(1)	
					nCol2 := 600
					oReport:PrintText(Replicate("=",130),oReport:Row(),025) 
					oReport:SkipLine(1)	
					oReport:PrintText(Subs(aQE0[nC,3],1,27) + "("+aQE0[nC,2]+")",oReport:Row(),025) 
					cIndice := aQE0[nC,2]
					If nP1 > 1
						n4 := 8 * ( nP1-1 ) + 1
					EndIf
					
					For n4 := n4 To 8 * nP1
					
						If n4 == 8 * nP1 .And. nP1 == nPag
							nPos := Ascan(aTotQE0,{ |x| x[1] == cIndice } )
							If nPos <> 0

								oReport:PrintText(Str(aTotQE0[nPos,2]/aTotQE0[nPos,3],9,2 )+" |",oReport:Row(),1600) 

								Exit
							EndIf
						EndIf
						
						If Len(aAnoMes) >= n4
							nPos := AsCan(aQE0,{ |x| x[1] == aAnoMes[n4] .And. x[2] == cIndice } )
							If nPos <> 0

								oReport:PrintText(Str(aQE0[nPos,4],9,2)+" |",oReport:Row(),nCol2) 

								nPosic := AsCan(aTotQE0,{ |x| x[1] == cIndice } )
								If nPosic <> 0
									aTotQE0[nPosic,2] += aQE0[nPos,4]
									aTotQE0[nPosic,3] := aTotQE0[nPosic,3]+1
								Else
									Aadd(aTotQE0,{cIndice,aQE0[nPos,4],1})
								EndIf
							Else

								oReport:PrintText("    N/A   |",oReport:Row(),nCol2) 
							EndIf
						Else

							oReport:PrintText(Space(9)+"|",oReport:Row(),nCol2) 

						EndIf
						nCol2+=140
					Next
					nCol2:=600
					n4:=1	  
					oReport:PrintText("|",oReport:Row(),600) 
				EndIf
			Next
		EndIf
		
		cIndice :=""
		
		If nV != 8
			oReport:SkipLine(1)
			oReport:PrintText(Iif(AllTrim(Str(nV))$"1",Replicate("_",130),Replicate("=",130)),oReport:Row(),025) 
			oReport:SkipLine(1)	
		Else
			oReport:SkipLine(1)
			oReport:PrintText(Replicate("-",130),oReport:Row(),025) 
			oReport:SkipLine(1)	
		EndIf
	Next 
	QA8->(dbSetOrder(nOrdQA8))
	oSection1:SetPageBreak(.T.) 
	oSection1:Finish()
Next nP1

aTotFat:={}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEV")
RetIndex("QEV")
Set Filter To
dbSetOrder(nOrdQEV)

dbSelectArea("SA5")
RetIndex("SA5")
Set Filter To
dbSetOrder(1)

dbSelectArea("QE0")
RetIndex("QE0")
Set Filter To
dbSetOrder(1)

dbSelectArea("QEG")
RetIndex("QEG")
Set Filter To
dbSetOrder(1)

// Apaga arquivos de trabalho

oTempTb1:Delete()

oTempTb2:Delete()

dbSelectArea("QA8")
RetIndex("QA8")
Set Filter To
dbSetOrder(1)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R100CkMes  ³ Autor ³ Marcelo Pimentel      ³ Data ³ 27/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Verifica o mes                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso                               ³ X1_VALID                                                                                                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R100CkMes()
Local lRet := .F.

If naovazio()
	If mv_par02 > 0 .And. mv_par02 <=12
		lRet := .T.
	EndIf
EndIf

Return(lRet)
