/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER110.CH"
#Include "PROTHEUS.CH"
#Include "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ QIER110	³ Autor ³ Marcelo Pimentel   	³ Data ³ 27.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem das Tabelas Gerais				     			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_QIER110(void)								    		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAQIE													  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo     ³31/07/00³  4677³ Acerto da Picture nas colunas onde contem³±±
±±³Marcelo     ³        ³      ³ fator inferior e superior                ³±±
±±³Robson Ramir³25/04/01³   FNC³ Altercao de Cabecalho para grafico       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QIER110()
Local oReport	
Private cAliasQEK  :="QEK"

oReport := ReportDef()
oReport:PrintDialog()

Return    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ReportDef  ºAutor  ³Cleber Souza        º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicoes do relatorio de Formulas R4.		              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER110                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cPrograma  :="QIER110"
Local cDesc1     :=STR0001	//"Neste relat¢rio ser„o impressos os lead-times referentes …s Entradas"
Local cDesc2     :=STR0002	//"dos Produtos/Fornecedores."
Local cTitulo    :=STR0003  //Formula   

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER NIL ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1+cDesc2)

DEFINE SECTION oSection OF oReport TABLES "QEG"  TITLE STR0006
DEFINE CELL NAME "cClasse"     OF oSection  ALIAS NIL  TITLE STR0006 SIZE 30 //"CLASSES :"

DEFINE SECTION oSection1 OF oReport TABLES "QEG" TITLE TITSX3("QEG_SITU")[1]
DEFINE CELL NAME "QEG_SITU"       OF oSection1 ALIAS "QEG"  
DEFINE CELL NAME "QEG_IQI_I"      OF oSection1 ALIAS "QEG" 
DEFINE CELL NAME "QEG_IQI_S"      OF oSection1 ALIAS "QEG" 
DEFINE CELL NAME "QEG_CATEG"      OF oSection1 ALIAS "QEG" 
DEFINE CELL NAME "QEG_NIVEL"      OF oSection1 ALIAS "QEG" 
DEFINE CELL NAME "QEG_NIVING"     OF oSection1 ALIAS "QEG" 
DEFINE CELL NAME "QEG_OBS"        OF oSection1 ALIAS "QEG" 

DEFINE SECTION oSection2 OF oReport TABLES "QA8" TITLE STR0030//"Fatores do IQS"
DEFINE CELL NAME "QA8_AVALIA"     OF oSection2 ALIAS "QA8"  
DEFINE CELL NAME "QA8_DESCPO"     OF oSection2 ALIAS "QA8"  
DEFINE CELL NAME "QA8_DESCIN"     OF oSection2 ALIAS "QA8"  
DEFINE CELL NAME "QA8_DESCES"     OF oSection2 ALIAS "QA8"  
DEFINE CELL NAME "QA8_FATINF"     OF oSection2 ALIAS "QA8"  
DEFINE CELL NAME "QA8_FATSUP"     OF oSection2 ALIAS "QA8"  
                   
DEFINE SECTION oSection3 OF oReport TABLES "QED"  TITLE STR0031//"Fatores do IQP"
DEFINE CELL NAME "QED_CODFAT"     OF oSection3 ALIAS "QED"  
DEFINE CELL NAME "QED_CATEG"      OF oSection3 ALIAS "QED"  
DEFINE CELL NAME "QED_DESCPO"     OF oSection3 ALIAS "QED"  
DEFINE CELL NAME "QED_DESCIN"     OF oSection3 ALIAS "QED"  
DEFINE CELL NAME "QED_DESCES"     OF oSection3 ALIAS "QED"  
DEFINE CELL NAME "QED_FATOR"      OF oSection3 ALIAS "QED"   

DEFINE SECTION oSection4 OF oReport TABLES "QEX" TITLE STR0032//"Criterios do Skip-Lote"
DEFINE CELL NAME "QEX_VLINF"     OF oSection4 ALIAS "QEX"  
DEFINE CELL NAME "QEX_VLSUP"     OF oSection4 ALIAS "QEX"  
DEFINE CELL NAME "cSKPLOT"       OF oSection4 ALIAS "" SIZE 120

DEFINE SECTION oSection5 OF oReport TABLES "QEE" TITLE STR0033//"CLASSES DE NAO CONFORMIDADES "
DEFINE CELL NAME "QEE_CLASSE"     OF oSection5 ALIAS "QEE"  
DEFINE CELL NAME "QEE_DESCPO"     OF oSection5 ALIAS "QEE"  
DEFINE CELL NAME "QEE_DESCIN"     OF oSection5 ALIAS "QEE"  
DEFINE CELL NAME "QEE_DESCES"     OF oSection5 ALIAS "QEE"  
DEFINE CELL NAME "QEE_PONTOS"     OF oSection5 ALIAS "QEE"  TITLE STR0025//"Fator de Criticidade" 
		                                                                                          
DEFINE SECTION oSection6 OF oReport TABLES "QEJ" TITLE STR0034//"FATOR K" 
DEFINE CELL NAME "QEJ_VLINF"      OF oSection6 ALIAS "QEJ"  
DEFINE CELL NAME "QEJ_VLSUP"      OF oSection6 ALIAS "QEJ"  
DEFINE CELL NAME "cFATORK6"        OF oSection6 ALIAS ""  TITLE AllTrim(TitSX3("QEJ_FATOR")[1])+" K"  SIZE TamSX3("QEJ_FATOR")[1]
DEFINE CELL NAME "cFATORFC6"       OF oSection6 ALIAS ""  TITLE AllTrim(TitSX3("QEJ_FATOR")[1])+" FC" SIZE TamSX3("QEJ_FATOR")[1]

DEFINE SECTION oSection7 OF oReport TABLES "QEJ" TITLE STR0035//"Fatores de Corre‡ao"
DEFINE CELL NAME "QEJ_VLINF"      OF oSection7 ALIAS "QEJ"  
DEFINE CELL NAME "QEJ_VLSUP"      OF oSection7 ALIAS "QEJ"  
DEFINE CELL NAME "cFATORK7"       OF oSection7 ALIAS ""  TITLE AllTrim(TitSX3("QEJ_FATOR")[1])+" K"  SIZE TamSX3("QEJ_FATOR")[1]
DEFINE CELL NAME "cFATORFC7"      OF oSection7 ALIAS ""  TITLE AllTrim(TitSX3("QEJ_FATOR")[1])+" FC" SIZE TamSX3("QEJ_FATOR")[1]

Return oReport   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza		 º Data ³  07/17/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao relatorio R4.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER110                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local cFatIQF      :=""
Local nC           :=0
Local aFatIQF      :={}
Local oSection     := oReport:Section(1)
Local oSection1    := oReport:Section(2)
Local oSection2    := oReport:Section(3)
Local oSection3    := oReport:Section(4)
Local oSection4    := oReport:Section(5)
Local oSection5    := oReport:Section(6)
Local oSection6    := oReport:Section(7)
Local oSection7    := oReport:Section(8)
PRIVATE nTipo      := GetMv("MV_COMP")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Classes da Situa‡Æo 										 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection:Init()
oSection:Cell("cClasse"):SetValue("")
oSection:PrintLine()
oSection:Finish()

dbSelectArea("QEG")
dbSetOrder(1)
If dbSeek(xFilial("QEG"))
	oSection1:Init()
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QEG") == QEG_FILIAL
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
	    oSection1:PrintLine()
		QEG->(dbSkip())
	EndDo
	oSection1:Finish()
EndIf	
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fatores do IQS												 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QA8")
dbSetOrder(1)
If dbSeek(xFilial("QA8"))
	oSection2:Init()
	oReport:SkipLine(1)
	oReport:PrintText(STR0007) //"FATORES DO IQS :"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QA8") == QA8_FILIAL
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
	    oSection2:PrintLine()
		QA8->(dbSkip())
	EndDo
	oSection2:Finish()
EndIF
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fatores do IQP												 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QED")
dbSetOrder(1)
If dbSeek(xFilial("QED"))
	oSection3:Init()
	oReport:SkipLine(1)
	oReport:PrintText(STR0008)  //"FATORES DO IQP :"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QED") == QED_FILIAL
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
	    oSection3:PrintLine()
		QED->(dbSkip())
	EndDo    
	oSection3:Finish()
EndIf
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criterios do Skip-Lote 									     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEF")
dbSetOrder(1)

dbSelectArea("QEX")
dbSetOrder(1)

If dbSeek(xFilial("QEX"))
	oSection4:Init()
	oReport:SkipLine(1)
	oReport:PrintText(STR0009)  //"CRITERIOS DO SKIP-LOTE :"
	oReport:SetMeter(RecCount())

	While !Eof() .And. xFilial("QEX") == QEX_FILIAL
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
		If QEF->(dbSeek(xFilial("QEF")+QEX->QEX_SKPLOT))
			oSection4:Cell("cSKPLOT"):SetValue(QEF->QEF_DESCRI)
		Else
			oSection4:Cell("cSKPLOT"):SetValue("")		
		EndIf 
   	    oSection4:PrintLine()
		QEX->(dbSkip())
	EndDo
	oSection4:Finish()
EndIf
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fatores do IQF												 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine(1)
oReport:PrintText(STR0010) //"FATORES DO IQF :"
oReport:SkipLine(1)

dbSelectArea("QF1")
dbSetOrder(1)
If dbSeek(xFilial("QF1"))
	While !Eof() .And. xFilial("QF1") == QF1_FILIAL
		cFatIQF := cFatIQF + Iif(!Empty(cFatIQF),"+ ","") + Str(QF1_FATIQF,4,2) +" * "+QF1_INDICE +" "
		Aadd(aFatIQF,QF1_INDICE)
		dbSkip()
	EndDo
	
	oReport:PrintText("IQF = "+ Iif(Empty(cFatIQF),STR0011,cFatIQF)) ////"Nao foi cadastrado nenhum Indice para compor o IQF."
	oReport:SkipLine(1)
	
	oReport:PrintText(STR0012) //"Sendo IQF..: Indice de Qualidade do Fornecedor"
	oReport:SkipLine(1)
	For nC := 1 To Len(aFatIQF)
		dbSeek(xFilial("QF1")+aFatIQF[nC])
		oReport:PrintText(AllTrim(aFatIQF[nC])+"..: "+QF1_DESCRI)
		oReport:SkipLine(1)
	Next
	oReport:SkipLine(1)
EndIf

oReport:PrintText(STR0028) //"FORMULAS DO IQF :"
oReport:SkipLine(1)
oReport:PrintText("IQI = IQP * FC")
oReport:SkipLine(1)
oReport:PrintText(STR0013)
oReport:SkipLine(1)
oReport:PrintText("IA  = ((Fator1 * q1 + Fator2 * q2 + Fator3 * q3) / (q1 + q2 + q3)) * 100")
oReport:SkipLine(1)
oReport:PrintText(STR0014)
oReport:SkipLine(1)
oReport:PrintText(STR0015)
oReport:SkipLine(1)
oReport:PrintText(STR0016)
oReport:SkipLine(1)

oReport:PrintText("IES = IPO")
oReport:SkipLine(1)
oReport:PrintText(STR0017+Str(GetMv("MV_QDIAIPO"))+STR0018)//"IPO = ( 1 - (Somatoria Ni * Di / ("###" * Nt)) ) * 100"
oReport:SkipLine(1)
oReport:PrintText(STR0019)//"      Sendo Ni: Quantidade entregue em atraso (lote a lote)"
oReport:SkipLine(1)
oReport:PrintText(STR0020)//"            Di: Numero de dias em atraso (lote a lote)"
oReport:SkipLine(1)
oReport:PrintText(STR0021)//"            Nt: Quantidade total entregue no mes"
oReport:SkipLine(1)
oReport:PrintText(STR0022)//"           Obs: No Calculo do IPO, se o nr. de dias em atraso real for maior que o nr. "
oReport:SkipLine(1)
oReport:PrintText(STR0023)//"                dias definido no parametro MV_QDIAIPO, sera utilizado este ultimo."
oReport:SkipLine(2)


dbSelectArea("QEE")
dbSetOrder(1)
If dbSeek(xFilial("QEE"))
	oSection5:Init()
	oReport:PrintText (STR0024)//"CLASSES DE NAO CONFORMIDADES :"
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QEE") == QEE_FILIAL
		If oReport:Cancel()
			Exit
		EndIf
		oReport:IncMeter()
	    oSection5:PrintLine()
		QEE->(dbSkip())
	EndDo
	oSection5:Finish()
EndIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fator K 																	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEJ")
dbSetOrder(1)
If dbSeek(xFilial("QEJ")+"1")
	oReport:SkipLine(1)
	oReport:PrintText(STR0026)//"FATOR K:" 
	oSection6:Cell("cFATORFC6"):Disable()
	oSection6:Cell("cFATORK6"):Enable()
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QEJ") == QEJ_FILIAL
		If QEJ_CODTAB == "1"
			If oReport:Cancel()
				Exit
			EndIf
			oReport:IncMeter()
		   	oSection6:Init()  
		   	oSection6:Cell("QEJ_VLINF"):Show()
		   	oSection6:Cell("QEJ_VLSUP"):Show()
			oSection6:Cell("cFATORK6"):SetValue(QEJ->QEJ_FATOR)  
		   	oSection6:Cell("cFATORFC6"):SetValue("")
		   	oSection6:PrintLine()
		EndIf 
		QEJ->(dbSkip())
	EndDo
	oSection6:Finish()
EndIF

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fatores de Corre‡Æo (FC)									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEJ")
dbSetOrder(1)
If dbSeek(xFilial("QEJ")+"2")
	oReport:SkipLine(1)
	oReport:PrintText(STR0027)//"FATOR DE CORRECAO (FC) :"
	oSection7:Cell("cFATORK7"):Disable()
	oSection7:Cell("cFATORFC7"):Enable()
	oReport:SetMeter(RecCount())
	While !Eof() .And. xFilial("QEJ") == QEJ_FILIAL
		If QEJ_CODTAB == "2"
			If oReport:Cancel()
				Exit
			EndIf
			oReport:IncMeter()
			oSection7:Init()
            oSection7:Cell("QEJ_VLINF"):Show()	 
		   	oSection7:Cell("QEJ_VLSUP"):Show()
		   	oSection7:Cell("cFATORFC7"):SetValue(QEJ->QEJ_FATOR)
			oSection7:Cell("cFATORK7"):SetValue("")  
		   	oSection7:PrintLine()
		EndIf 
		QEJ->(dbSkip())
	EndDo
	oSection7:Finish()
EndIf
	
Return