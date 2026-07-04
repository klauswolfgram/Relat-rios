/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Rwmake.ch"
#Include "Protheus.ch"      
#Include "TOPCONN.CH" 
#Include "TECR050.CH"
Static cAutoPerg := "TECR050"
//-------------------------------------------------------------------
/*/{Protheus.doc} TECR050
Relatorio de Alocacoes de Atendentes, por Local e por Recurso

@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
/*/
//-------------------------------------------------------------------

User Function TECR050( dDataini, dDataFim, cCodTec, cFil)

Local oReport     
Private cPerg := "TECR050"

Default dDataini	:= dDataBase
Default dDataFim	:= dDataBase
Default cCodTec		:= ""
Default cFil		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//?PARAMETROS                                                             ?
//?MV_PAR01 : Data de ?                                                   ?
//?MV_PAR02 : Data ate?                                                   ?
//?MV_PAR03 : Atendente de ?                                              ?
//?MV_PAR04 : Atendente ate ?                                             ?
//?MV_PAR05 : Local de ?                                                  ?
//?MV_PAR06 : Local ate ?                                                 ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

If IsInCallStack("AT020RAAte")
	Pergunte(cPerg,.F.)
	MV_PAR01 := dDataini
	MV_PAR02 := dDataFim
	MV_PAR03 := cCodTec
	MV_PAR04 := cCodTec
	MV_PAR05 := ""
	MV_PAR06 := Replicate( "Z", TamSX3("ABS_LOCAL")[1])
Else
	If !Pergunte(cPerg,.T.)
		Return
	EndIf
EndIf

oReport := ReportDef(cFil)
oReport:PrintDialog()

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definições do relatorio de Atendentes Alocados (Agenda)

@author  filipe.goncalves
@version P12.1.11
@since 	 21/01/2016
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef(cCustom)

Local cTitulo 	:= STR0031	
Local oReport
Local oSection1

If TYPE("cPerg") == "U"
	cPerg := "TECR050"
EndIf

oReport	:= TReport():New(cPerg, cTitulo, cPerg , {|oReport| PrintReport(oReport,cCustom)},STR0030)
oSection1 := TRSection():New(oReport,"Locais de Atendimento",{"ABS","ABB","SRA"})

oReport:SetPortrait()
oReport:ShowHeader()
oReport:SetTotalInLine(.F.)
oSection1:SetTotalInLine(.F.)


TRCell():New(oSection1, STR0007	, "AA1", STR0015 ,PesqPict('AA1',"AA1_NOMTEC")		,TamSX3("AA1_NOMTEC")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	 
TRCell():New(oSection1, STR0008	, "ABS", STR0016 ,"@!"							,20						,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, "ABB_FILIAL"	, "ABB", STR0034 ,PesqPict('ABB',"ABB_FILIAL")	,TamSX3("ABB_FILIAL")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0009	, "ABB", STR0017 ,PesqPict('ABB',"ABB_DTINI")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1, STR0010	, "ABB", STR0018 ,PesqPict('ABB',"ABB_HRINI")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():new(oSection1, STR0011	, "ABB", STR0019 ,PesqPict('ABB',"ABB_DTFIM")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():new(oSection1, STR0012	, "ABB", STR0020 ,PesqPict('ABB',"ABB_DTFIM")	,13					 	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():new(oSection1, STR0013	, "ABS", STR0021 ,PesqPict('ABS',"ABS_LOCAL")	,TamSX3("ABS_LOCAL")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():new(oSection1, STR0014	, "ABS", STR0022 ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:Cell(STR0007):SetAlign("LEFT")
oSection1:Cell(STR0008):SetAlign("LEFT")
oSection1:Cell(STR0009):SetAlign("LEFT")
oSection1:Cell(STR0010):SetAlign("LEFT")
oSection1:Cell(STR0011):SetAlign("LEFT")
oSection1:Cell(STR0012):SetAlign("LEFT")
oSection1:Cell(STR0013):SetAlign("LEFT")
oSection1:Cell(STR0014):SetAlign("LEFT")

//Totalizadores
oBreak := TRBreak():New(oSection1,oSection1:Cell(STR0007),,.F.)
TRFunction():New(oSection1:Cell(STR0007),STR0015,"COUNT",oBreak,,"",,.F.,.F.)
TRFunction():New(oSection1:Cell(STR0007),STR0015,"COUNT",,,"",,.F.,.T.)	

Return (oReport)


//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Gera o Relatorio de Alocacoes de Atendentes, por Local e por Recurso	

@author  filipe.goncalves
@version P12.1.11
@since 	 21/01/2016
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport,cCustom)

Local oSection1	:= oReport:Section(1)
Local cDia		:= ""
Local nDia		:= 0
Local cSql		:= ""
Local lMVPAR07 := TecHasPerg("MV_PAR07","TECR050") 
Local aFilsPAR07 := {}
Local cXfilAA1 := ""
Local cXfilSRA := ""
Local cXfilABB := ""
Local cXfilABS := ""
Local cValMVPAR07 := ""
Local nX

MakeSqlExp("TECR050")

cSql += "AND ABB.ABB_DTINI BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"'"
cSql += "AND ABB.ABB_CODTEC BETWEEN '"+mv_par03+"' AND '"+mv_par04+"'"
cSql += "AND ABS.ABS_LOCAL BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
cSql := "%"+cSql+"%" // Tem que passar o % para utilizar na query
	
If (lMVPAR07 .AND. (!Empty(MV_PAR07) .OR. !Empty(cCustom)))
	If Empty(MV_PAR07)
		MV_PAR07 := cCustom
	EndIf
	cValMVPAR07 := STRTRAN(MV_PAR07, "AA1_FILIAL")
	cValMVPAR07 := REPLACE(cValMVPAR07, " IN")
	cValMVPAR07 := REPLACE(cValMVPAR07, "(")
	cValMVPAR07 := REPLACE(cValMVPAR07, ")")
	cValMVPAR07 := REPLACE(cValMVPAR07, "'")
	aFilsPAR07 := StrTokArr(cValMVPAR07,",")
	For nX := 1 To LEN(aFilsPAR07)
		If nX == 1
			cXfilAA1 += " IN ("
			cXfilSRA += " IN ("
			cXfilABB += " IN ("
			cXfilABS += " IN ("
		EndIf
		cXfilAA1 += "'" + xFilial("AA1", aFilsPAR07[nX] ) 
		cXfilSRA += "'" + xFilial("SRA", aFilsPAR07[nX] )
		cXfilABB += "'" + xFilial("ABB", aFilsPAR07[nX] )
		cXfilABS += "'" + xFilial("ABS", aFilsPAR07[nX] )
		If nX >= 1 .AND. nX < LEN(aFilsPAR07)
			cXfilAA1 +=  "',"
			cXfilSRA +=  "',"
			cXfilABB +=  "',"
			cXfilABS +=  "',"
		EndIf
		If nX == LEN(aFilsPAR07)
			cXfilAA1 += " ') "	
			cXfilSRA += " ') "	
			cXfilABB += " ') "
			cXfilABS += " ') "
		EndIf
	Next nX
			
	cXfilAA1 := "%"+cXfilAA1+"%" 
	cXfilSRA := "%"+cXfilSRA+"%"  
	cXfilABB := "%"+cXfilABB+"%"  
	cXfilABS := "%"+cXfilABS+"%" 
Else
	cXfilAA1 :=  " = '" + xFilial("AA1", cFilAnt) +"'"   
	cXfilAA1 := "%"+cXfilAA1+"%" 
			
	cXfilSRA :=  " = '" + xFilial("SRA", cFilAnt) +"'"   
	cXfilSRA := "%"+cXfilSRA+"%" 
			
	cXfilABB :=  " = '" + xFilial("ABB", cFilAnt) +"'"   
	cXfilABB := "%"+cXfilABB+"%" 
	
	cXfilABS :=  " = '" + xFilial("ABS", cFilAnt) +"'"   
	cXfilABS := "%"+cXfilABS+"%"
EndIf	

BEGIN REPORT QUERY oReport:Section(1)

	BeginSql alias "QRY"

		SELECT ABB.ABB_FILIAL, ABS.ABS_DESCRI, ABS.ABS_LOCAL, ABS.ABS_DESCRI, ABB.ABB_DTINI, ABB.ABB_HRINI, ABB.ABB_DTFIM, ABB.ABB_HRFIM, AA1.AA1_NOMTEC

		   FROM %table:ABS% ABS
		    INNER JOIN %table:ABB% ABB ON ABB_LOCAL = ABS.ABS_LOCAL
		    INNER JOIN %table:AA1% AA1 ON AA1_CODTEC = ABB.ABB_CODTEC
		    LEFT JOIN %table:SRA% SRA ON SRA.RA_MAT = AA1.AA1_CDFUNC 
		     AND SRA.RA_FILIAL = AA1.AA1_FUNFIL	     
			 AND SRA.RA_FILIAL %exp:cXfilSRA%
			 AND SRA.%notDel%
		   WHERE ABS_FILIAL %exp:cXfilABS%
		      AND ABB_FILIAL  %exp:cXfilABB%
		      AND AA1_FILIAL %exp:cXfilAA1%
		      AND ABS.%notDel%
		      AND ABB.%notDel%
		      AND AA1.%notDel%
		      %exp:cSql%

		    ORDER BY ABB_CODTEC, ABB_DTINI

	EndSql

END REPORT QUERY oReport:Section(1)

//Define tamanho da regua
oReport:SetMeter(QRY->(RecCount()))

oSection1:Init()
oSection1:SetHeaderSection(.T.)

dbSelectArea('QRY')

	//Para cara registro de alocacao, pinta uma linha no relatorio
While QRY->(!Eof())

	//Obtem o dia da semana
	nDia := DOW(QRY->ABB_DTINI)
	If nDia == 1
		cDia := STR0023 //Domingo
	ElseIf nDia == 2 
		cDia := STR0024 //Segunda
	ElseIf nDia == 3
		cDia := STR0025 //Terça
	ElseIf nDia == 4
		cDia := STR0026 //Quarta	
	ElseIf nDia == 5
		cDia := STR0027 //Quinta
	ElseIf nDia == 6
		cDia := STR0028 //Sexta
	ElseIf nDia == 7
		cDia := STR0029 //Sabado
	EndIf
																																										
	oSection1:Cell(STR0007):SetValue(QRY->AA1_NOMTEC)
	oSection1:Cell(STR0008):SetValue(cDia)
	oSection1:Cell(STR0009):SetValue(QRY->ABB_DTINI)
	oSection1:Cell(STR0010):SetValue(QRY->ABB_HRINI)
	oSection1:Cell(STR0011):SetValue(QRY->ABB_DTFIM)
	oSection1:Cell(STR0012):SetValue(QRY->ABB_HRFIM)
	oSection1:Cell(STR0013):SetValue(QRY->ABS_LOCAL)
	oSection1:Cell(STR0014):SetValue(AllTrim(QRY->ABS_DESCRI))
	If !isBlind()
		oSection1:PrintLine()
	EndIf
	//Botao Cancelar
	If oReport:Cancel()
		Exit
	EndIf

	//Incrementa a regua de processamento
	oReport:IncMeter()

	//Proximo Registro
	QRY->(dbSkip())                                                          
EndDo

QRY->(dbCloseArea())
oSection1:Finish()

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg

