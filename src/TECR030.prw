/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Rwmake.ch"
#include "Protheus.ch"
#Include 'TOPCONN.ch'
#Include 'TECR030.ch'

Static cAutoPerg := "TECR030"
//-------------------------------------------------------------------
/*/{Protheus.doc} TECR030
Imprime o relatorio de Manutencao de Agendas

@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
/*/
//-------------------------------------------------------------------
User Function TECR030()
	local oReport          
	Private cPerg	:= "TECR030"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ PARAMETROS                                                             ³
 	//³ MV_PAR01 : Data de ?                                                   ³
 	//³ MV_PAR02 : Data ate?                                                   ³
 	//³ MV_PAR03 : Atendente de ?                                              ³
 	//³ MV_PAR04 : Atendente ate ?                                             ³
 	//³ MV_PAR05 : Local de ?                                       		   ³
 	//³ MV_PAR06 : Local ate ?                                                 ³
 	//³ MV_PAR07 : Motivo de ?                                                 ³
 	//³ MV_PAR08 : Motivo ate ?                                                ³
 	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
 	
 	If !Pergunte(cPerg,.T.)
		Return
	EndIf   
	
	oReport := ReportDef()
	oReport:PrintDialog()
Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} reportDef
Monta as definiçoes do relatorio de Recursos (Atendentes) Não-Alocados.
@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()
	Local cTitulo 	:= STR0001
	Local oReport
	Local oSection1
	
	If TYPE("cPerg") == "U"
		cPerg	:= "TECR030"
	EndIf
	
	oReport 	:= TReport():New(cPerg, cTitulo, cPerg , {|oReport| PrintReport(oReport)},STR0002)
	oSection1 := TRSection():New(oReport,"Agenda de Atendentes",{"ABB","ABS","SRA"})
	
	oReport:ShowHeader()
	oReport:SetPortrait()                              
	oReport:SetTotalInLine(.F.)
	oSection1:SetTotalInLine(.F.)

	TRCell():New(oSection1, STR0011 , "ABS", STR0026 ,PesqPict('SRA',"RA_NOME")		,TamSX3("RA_NOME")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0012	, "SRA", STR0012 ,PesqPict('SRA',"RA_CIC")		,TamSX3("RA_CIC")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0013	, "ABS", STR0027 ,PesqPict('SRA',"RA_NOME")		,TamSX3("RA_NOME")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0014	, "SRA", STR0028 ,PesqPict('SRA',"RA_CIC")		,TamSX3("RA_CIC")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0015	, "ABS", STR0029 ,"@!"							,30						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0016	, "ABB", STR0030 ,PesqPict('ABB',"ABB_DTINI")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection1, STR0017	, "ABB", STR0031 ,PesqPict('ABB',"ABB_HRINI")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0018	, "ABB", STR0032 ,PesqPict('ABB',"ABB_DTFIM")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0019	, "ABB", STR0033 ,PesqPict('ABB',"ABB_DTFIM")	,13						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0020	, "ABS", STR0034 ,PesqPict('ABS',"ABS_LOCAL")	,TamSX3("ABS_LOCAL")[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0021	, "ABS", STR0035 ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0022	, "ABS", STR0036 ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0023	, "ABS", STR0037 ,PesqPict('ABS',"ABS_DESCRI")	,15						,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0024	, "ABS", STR0038 ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():new(oSection1, STR0025	, "ABS", STR0025 ,PesqPict('ABS',"ABS_DESCRI")	,TamSX3("ABS_DESCRI")[1],/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection1:Cell(STR0011):SetAlign("LEFT")
	oSection1:Cell(STR0012):SetAlign("LEFT")
	oSection1:Cell(STR0015):SetAlign("LEFT")
	oSection1:Cell(STR0016):SetAlign("LEFT")
	oSection1:Cell(STR0017):SetAlign("LEFT")
	oSection1:Cell(STR0018):SetAlign("LEFT")
	oSection1:Cell(STR0019):SetAlign("LEFT")
	oSection1:Cell(STR0020):SetAlign("LEFT")
	oSection1:Cell(STR0021):SetAlign("LEFT")
	oSection1:Cell(STR0022):SetAlign("LEFT")
	oSection1:Cell(STR0023):SetAlign("LEFT")
	oSection1:Cell(STR0013):SetAlign("LEFT")
	oSection1:Cell(STR0014):SetAlign("LEFT")


Return (oReport)

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Pinta o Relatorio de Manutenção de Agendas

@author filipe.goncalves
@since 21/01/2016
@version P12.1.11
@return  Nil
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport(oReport)
	Local oSection1 := oReport:Section(1)
	Local nDia		:= 0
	Local cDia		:= ""
	Local cSubNom	:= ""
	Local cSubCpf	:= ""
	Local cSubMat	:= ""
	Local cSql		:= ""
	Local cOBSERV	:= ""
	Local cQtdHora	:= ""
	
	If Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES"
		cOBSERV := "%CAST(SUBSTR(ABR_OBSERV,2047,1) as varchar(2047)) ABR_OBSERV%"
	Else
		cOBSERV := "%COALESCE(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047),ABR_OBSERV)),' ') AS ABR_OBSERV%"
	EndIf
	
	#IFDEF TOP
	MakeSqlExp("TECR030")
	
	cSql += "AND ABS_LOCAL BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "'"
	cSql += "AND ABB_CODTEC BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "'"
	cSql += "AND ABB_DTINI BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
	cSql += "AND ABR_MOTIVO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "'"
	cSql := "%"+cSql+"%"

	BEGIN REPORT QUERY oReport:Section(1)

		BeginSql alias "QRY"
		
		SELECT ABS_DESCRI, ABS_LOCAL, ABS_DESCRI, ABS_CCUSTO, ABB_DTINI, ABB_HRINI, ABB_DTFIM, ABB_HRFIM, 
		AA1_NOMTEC, ABR_MOTIVO, ABR_CODSUB, %Exp:cOBSERV%, RA_CIC
		
		FROM %table:ABS% ABS
		INNER JOIN %table:ABB% ABB ON ABB_LOCAL = ABS_LOCAL
		INNER JOIN %table:AA1% AA1 ON AA1_CODTEC = ABB_CODTEC
		INNER JOIN %table:ABR% ABR ON ABR_AGENDA = ABB_CODIGO
		INNER JOIN %table:SRA% SRA ON RA_MAT = AA1_CDFUNC

		WHERE ABS_FILIAL =  %xfilial:ABS% 
		AND	ABB_FILIAL =  %xfilial:ABB% 
		AND AA1_FILIAL =  %xfilial:AA1% 
		AND ABR_FILIAL =  %xfilial:ABR%
		AND RA_FILIAL =  %xfilial:SRA%
		AND ABS.%notDel% 
		AND ABB.%notDel% 
		AND AA1.%notDel%  
		AND ABR.%notDel% 
		AND SRA.%notDel% 
		%exp:cSql%
				
		ORDER BY ABB_CODTEC, ABB_DTINI

		EndSql

	END REPORT QUERY oReport:Section(1)

	//Define tamanho da Regua
	oReport:SetMeter(QRY->(RecCount()))
	
	//Monta a primeira secao do relatorio
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)

	dbSelectArea('QRY')
	
	//Para cada registro de manutenção, pinta uma linha no relatorio
	While QRY->(!Eof())

		//Define o dia da semana
		nDia := DOW(QRY->ABB_DTINI)
		If nDia == 1
			cDia := STR0039 //Domingo
		ElseIf nDia == 2
			cDia := STR0040 //Segunda
		ElseIf nDia == 3
			cDia := STR0041 //Terça
		ElseIf nDia == 4
			cDia := STR0042 //Quarta
		ElseIf nDia == 5
			cDia := STR0043 //Quinta
		ElseIf nDia == 6
			cDia := STR0044 //Sexta
		ElseIf nDia == 7
			cDia := STR0045 //Sábado
		EndIf

		//Calcula a quantidade de horas trabalhadas
		If TecConvHr(QRY->ABB_HRINI) < TecConvHr(QRY->ABB_HRFIM)
			cQtdHora := Left(ElapTime(QRY->ABB_HRINI+":00", QRY->ABB_HRFIM+":00"), 5)
		ElseIf TecConvHr(QRY->ABB_HRINI) > TecConvHr(QRY->ABB_HRFIM)
			cQtdHora := Left(ElapTime(QRY->ABB_HRFIM+":00", QRY->ABB_HRINI+":00"), 5)
		Else
			cQtdHora := "00:00"
		EndIf

		//Informacoes do Substituto
		cSubNom := ""
		cSubCpf := ""
		cSubMat := ""
		If !(Empty(QRY->ABR_CODSUB))
			dbSelectArea('AA1')
			AA1->(dbSetOrder(1))
			If AA1->(dbSeek(xFilial('AA1') + QRY->ABR_CODSUB ))
				cSubMat := AA1->AA1_CDFUNC
				dbSelectArea('SRA')
				SRA->(dbSetOrder(1))
				If SRA->(dbSeek(xFilial('SRA') + cSubMat ))
					cSubNom := alltrim(SRA->RA_NOME)
					cSubCpf := alltrim(SRA->RA_CIC)
				EndIf
			EndIf
		EndIf

		//Imprime os dados
		oSection1:Cell(STR0011):SetValue(QRY->AA1_NOMTEC)
		oSection1:Cell(STR0012):SetValue(QRY->RA_CIC)
		oSection1:Cell(STR0015):SetValue(cDia)
		oSection1:Cell(STR0016):SetValue(QRY->ABB_DTINI)
		oSection1:Cell(STR0017):SetValue(QRY->ABB_HRINI)
		oSection1:Cell(STR0018):SetValue(QRY->ABB_DTFIM)
		oSection1:Cell(STR0019):SetValue(QRY->ABB_HRFIM)
		oSection1:Cell(STR0020):SetValue(QRY->ABS_LOCAL)
		oSection1:Cell(STR0021):SetValue(AllTrim(QRY->ABS_DESCRI))
		oSection1:Cell(STR0022):SetValue(AllTrim(QRY->ABS_CCUSTO))
		oSection1:Cell(STR0023):SetValue(AllTrim(cQtdHora))
		oSection1:Cell(STR0024):SetValue(AllTrim(POSICIONE("ABN",1,xFilial("ABN")+QRY->ABR_MOTIVO,"ABN_DESC")))
		oSection1:Cell(STR0025):SetValue(AllTrim(QRY->ABR_OBSERV))
		oSection1:Cell(STR0013):SetValue(cSubNom)
		oSection1:Cell(STR0014):SetValue(cSubCpf)
		oSection1:PrintLine()

		//Botao Cancelar	
		If oReport:Cancel()
			Exit
		EndIf

		//Incrementa Regua de Processamento
		oReport:IncMeter()

		//Proximo Registro
		QRY->(dbSkip())
	EndDo

	QRY->(dbCloseArea())
	oSection1:Finish()
	#ENDIF
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
