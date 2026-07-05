/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "REPORT.CH"
#INCLUDE "TECR610.CH"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TECR610()

Escala X Cliente ou Contrato

@sample 	U_TECR610()

@return oReport
@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
User Function TECR610()

Local cPerg		:= "TECR610"
Local oReport					//Objeto relatorio TReport

Pergunte(cPerg,.T.)

oReport := Rt610RDef(cPerg)
oReport:PrintDialog()

Return(.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt610RDef()

Escala X Cliente ou Contrato - monta as Section's para impressão do relatorio

@sample 	Rt590RDef(cPerg)
@param cPerg 
@return oReport

@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------
Static Function Rt610RDef(cPerg)
Local oReport						//Objeto relatorio TReport (Release 4)
Local oSection1 					//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1) 
Local oSection2  					//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB") 
Local oSection3  					//Objeto secao 3 do relatorio (detalhes, campos das tabelas "SA1")
Local cTOTREAL		:=	""			//Variavel para Totalizador de Horas Realizadas
Local cTOTPLAN		:=	""			//Variavel para Totalizador de Horas Planejadas 
Local cTMANREAL	:=	""			//Variavel para Totalizador de Horas Realizadas com Manutenção na Agenda
Local cTPLANE		:=	""			//Variavel para Totalizador de Horas Planejadas no inicio do contrato
Local cX			:=	" X "
Local cAlias1		:= GetNextAlias()	//Alias da consulta Embedded SQL

DEFINE REPORT oReport NAME "TECR610";
TITLE STR0002 PARAMETER "TECR610";							//"Escala X Cliente e Contrato GCT"
ACTION {|oReport| Rt610Print( oReport, cAlias1 )};
DESCRIPTION STR0002											//"Escala X Cliente e Contrato GCT"

//Section 1 - SA1 - Clientes
DEFINE SECTION oSection1 OF oReport TITLE FwX2Nome("SA1") TABLES "SA1"

DEFINE CELL NAME "A1_COD"		OF oSection1 
DEFINE CELL NAME "A1_LOJA"		OF oSection1 
DEFINE CELL NAME "A1_PESSOA"	OF oSection1 
DEFINE CELL NAME "A1_NOME"		OF oSection1 
DEFINE CELL NAME "A1_NREDUZ"	OF oSection1
DEFINE CELL NAME "A1_END"		OF oSection1 
DEFINE CELL NAME "A1_EST"		OF oSection1                                                        
DEFINE CELL NAME "A1_BAIRRO"	OF oSection1

//Section 2 - CN9 - Contratos
DEFINE SECTION oSection2 OF oSection1 TITLE FwX2Nome("CN9") TABLES "CN9" LEFT MARGIN 3

DEFINE CELL NAME "CN9_FILIAL"	OF oSection2
DEFINE CELL NAME "CN9_NUMERO"	OF oSection2
DEFINE CELL NAME "CN9_VLATU"	OF oSection2
DEFINE CELL NAME "CN9_DTINIC"	OF oSection2 
DEFINE CELL NAME "CN9_DTFIM"	OF oSection2

//Section 3 - ABS - Local de Atendimento
DEFINE SECTION oSection3 OF oSection2 TITLE FwX2Nome("TFL") TABLES "TFL" LEFT MARGIN 6

DEFINE CELL NAME "TFL_LOCAL"	OF oSection3 Size(15) 
DEFINE CELL NAME STR0003			OF oSection3 Size(Tamsx3("ABS_DESCRI")[1]) Block { ||Posicione("ABS",1,xFilial("ABS")+(cAlias1)->TFL_LOCAL,"ABS->ABS_DESCRI")} //"Descrição"

//Section 4 - AA1 - Atendente
DEFINE SECTION oSection4 OF oSection3 TITLE FwX2Nome("AA1") TABLES "AA1" LEFT MARGIN 9

DEFINE CELL NAME "AA1_CODTEC"	OF oSection4
DEFINE CELL NAME "AA1_NOMTEC"	OF oSection4
DEFINE CELL NAME "AA1_CDFUNC"	OF oSection4 
DEFINE CELL NAME "AA1_FUNFIL"	OF oSection4
DEFINE CELL NAME "AA1_CC"		OF oSection4 Size(Tamsx3("AA1_CC")[1]) BLOCK {|| (cAlias1)->AA1_CC}
DEFINE CELL NAME "AA1_REGIAO"	OF oSection4 //Size(3) 

//Secao 5 - ABB - Agendamento
DEFINE SECTION oSection5 OF oSection4 TITLE FwX2Nome("ABB") TABLES "ABB" LEFT MARGIN 12

DEFINE CELL NAME "ABB_DTINI"	OF oSection5  
DEFINE CELL NAME "ABB_HRINI"	OF oSection5
DEFINE CELL NAME "ABB_DTFIM"	OF oSection5  
DEFINE CELL NAME "ABB_HRFIM"	OF oSection5
DEFINE CELL NAME "ABB_HRTOT"	OF oSection5 Size(Tamsx3("ABB_HRTOT")[1]*4) BLOCK {|| U_AT610TReal(cAlias1)}
DEFINE CELL NAME STR0004		OF oSection5 Size(Tamsx3("ABB_HRTOT")[1]*4) BLOCK {|| SUBSTR((cAlias1)->ABB_HRTOT,6,10) } //"Hrs. Planejadas"

//Secao 6 - ABR - Manutenção da Agenda
DEFINE SECTION oSection6 OF oSection5 TITLE FwX2Nome("ABR") TABLES "ABR" LEFT MARGIN 15

DEFINE CELL NAME "ABR_MOTIVO"	OF oSection6 Size(15) BLOCK {|| Trim((cAlias1)->ABR_MOTIVO)}			   					   		ALIAS cAlias1
DEFINE CELL NAME STR0005			OF oSection6 Size(19) BLOCK {|| Posicione("ABN",1, xFilial("ABN")+PadR(Trim((cAlias1)->ABR_MOTIVO),;			//"Desc. do Motivo"
																	TamSx3("ABN_CODIGO")[1]),"ABN->ABN_DESC")}		  		ALIAS cAlias1 
DEFINE CELL NAME "ABR_DTMAN"	OF oSection6 
DEFINE CELL NAME "ABR_DTINIA"	OF oSection6 
DEFINE CELL NAME "ABR_HRINIA"	OF oSection6
DEFINE CELL NAME "ABR_DTFIMA"	OF oSection6
DEFINE CELL NAME "ABR_HRFIMA"	OF oSection6
DEFINE CELL NAME STR0006			OF oSection6 Size(Tamsx3("ABB_HRTOT")[1]*4) BLOCK{|| U_AT610TManC(cAlias1)} //"Tempo Manutenção"
DEFINE CELL NAME "ABR_DTINI"	OF oSection6
DEFINE CELL NAME "ABR_HRINI"	OF oSection6
DEFINE CELL NAME "ABR_DTFIM"	OF oSection6 
DEFINE CELL NAME "ABR_HRFIM"	OF oSection6
DEFINE CELL NAME "ABR_CODSUB"	OF oSection6
DEFINE CELL NAME "ABR_NOMSUB"	OF oSection6 Size(Tamsx3("AA1_NOMTEC")[1]) BLOCK{|| Posicione("AA1",1,Xfilial("AA1")+ABR->ABR_CODSUB,"AA1_NOMTEC")} //"Atendente Substituto"

oSection6:cell("ABR_DTINI"):Disable()
oSection6:cell("ABR_HRINI"):Disable()
oSection6:cell("ABR_DTFIM"):Disable()
oSection6:cell("ABR_HRFIM"):Disable()

oSection6:cell("ABR_DTINIA"):Disable()
oSection6:cell("ABR_HRINIA"):Disable()
oSection6:cell("ABR_DTFIMA"):Disable()
oSection6:cell("ABR_HRFIMA"):Disable()

oSection1:SetTotalInLine(.T.)
oSection2:SetTotalInLine(.T.)
oSection3:SetTotalInLine(.F.)
oSection4:SetTotalInLine(.F.)
oSection5:SetTotalInLine(.F.)
oSection6:SetTotalInLine(.F.)
oReport:SetTotalInLine(.T.)

// Totais por Clientes

DEFINE FUNCTION NAME "TOTREAL1" FROM oSection5:Cell("ABB_HRTOT");
OF oSection1 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0007 NO END REPORT		//"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "TOTPLAN2" FROM oSection5:Cell(STR0004);
OF oSection1 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0008 NO END REPORT		//"Total de Atendimentos Planejados"

DEFINE FUNCTION NAME "TMANREAL3" FROM oSection6:Cell(STR0006);
OF oSection1 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT //"Total de Manutenção"


DEFINE FUNCTION NAME "TPLANE4" FROM oSection6:Cell(STR0006) OF oSection1 FUNCTION ONPRINT;
FORMULA {||	IIf(oSection1:GetFunction("TOTREAL1"):SectionValue() == NIL, cTOTREAL:= "00:00",cTOTREAL:= oSection1:GetFunction("TOTREAL1"):SectionValue()),;
			IIf(oSection1:GetFunction("TOTPLAN2"):SectionValue() == NIL, cTOTPLAN:= "00:00",cTOTPLAN:= oSection1:GetFunction("TOTPLAN2"):SectionValue()),;
			IIf(oSection1:GetFunction("TMANREAL3"):SectionValue() == NIL, cTMANREAL:= "00:00",cTMANREAL:= oSection1:GetFunction("TMANREAL3"):SectionValue()),;
		cTOTPLAN+cX+cTOTREAL} TITLE STR0010 NO END REPORT		//"Total de Atendimentos Realizados X Planejados"
			
DEFINE FUNCTION NAME "TPLANE5" FROM oSection2:Cell("CN9_VLATU") OF oSection1 FUNCTION SUM TITLE STR0011 NO END REPORT  //"Valor Total dos Contratos"

// Totais por Contratos

DEFINE FUNCTION NAME "TOTREAL6" FROM oSection5:Cell("ABB_HRTOT");
OF oSection2 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0007 NO END REPORT 		//"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "TOTPLAN7" FROM oSection5:Cell(STR0004);
OF oSection2 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0008 NO END REPORT		//"Total de Atendimentos Planejados"

DEFINE FUNCTION NAME "TMANREAL8" FROM oSection6:Cell(STR0006);
OF oSection2 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0012 NO END REPORT	//"Total"

DEFINE FUNCTION NAME "TPLANE9" FROM oSection6:Cell(STR0006) OF oSection2 FUNCTION ONPRINT;
FORMULA {||	IIf(oSection2:GetFunction("TOTREAL6"):SectionValue() == NIL, cTOTREAL:= "00:00",cTOTREAL:= oSection2:GetFunction("TOTREAL6"):SectionValue()),;
			IIf(oSection2:GetFunction("TOTPLAN7"):SectionValue() == NIL, cTOTPLAN:= "00:00",cTOTPLAN:= oSection2:GetFunction("TOTPLAN7"):SectionValue()),;
			IIf(oSection2:GetFunction("TMANREAL8"):SectionValue() == NIL, cTMANREAL:= "00:00",cTMANREAL:= oSection2:GetFunction("TMANREAL8"):SectionValue()),;
			cTOTPLAN+cX+cTOTREAL} TITLE STR0010 NO END REPORT		//"Total de Atendimentos Realizados X Planejados"
			
Return oReport

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt610Print()

Escala X Cliente ou Contrato - monta a Query e imprime o relatorio de acordo com os parametros

@sample 	Rt610Print(oReport, cPerg, cAlias1)
@param	oReport
		cPerg
		cAlias1 
@return oReport

@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt610Print(oReport, cAlias1)
Local oSection1	:= oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1)
Local oSection2	:= oSection1:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB")
Local oSection3	:= oSection2:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABR","ABN")
Local oSection4	:= oSection3:Section(1) 	//
Local oSection5	:= oSection4:Section(1) 	//
Local oSection6	:= oSection5:Section(1) 	//
Local nI			:= 0
Local cIdcfal		:= Space(TamSX3("ABB_IDCFAL")[1])	// ID Configuracao Alocacao
Local oTotS2 
Local nCount		:= 0
Local cFiCN9TFL         := FWJoinFilial("TFL","CN9","TFL","CN9",.T.)
Local cFiABBABQ         := FWJoinFilial("ABB","ABQ","ABB","ABQ",.T.)
Local cFiCNCCN9         := FWJoinFilial("CNC","CN9","CNC","CN9",.T.)
Local cFiSA1CNC         := FWJoinFilial("SA1","CNC","SA1","CNC",.T.)
Local cFiAA1AAB         := FWJoinFilial("AA1","ABB","AA1","ABB",.T.)
Local cFiABQCN9         := FWJoinFilial("ABQ","CN9","ABQ","CN9",.T.)
Local cFiABQABB         := FWJoinFilial("ABQ","ABB","ABQ","ABB",.T.)
Local cXfilTFL := ""
Local cXfilCN9 := ""
Local lMVPAR11 := TecHasPerg("MV_PAR11","TECR610")
Local cValMVPAR11 := ""
Local aFilsPAR11 := {}
Local nX

MakeSqlExp("TECR610")

cFiCN9TFL  := "%"+cFiCN9TFL+"%" 
cFiABBABQ  := "%"+cFiABBABQ+"%" 
cFiCNCCN9  := "%"+cFiCNCCN9+"%" 
cFiSA1CNC  := "%"+cFiSA1CNC+"%" 
cFiAA1AAB  := "%"+cFiAA1AAB+"%" 
cFiABQCN9  := "%"+cFiABQCN9+"%" 
cFiABQABB  := "%"+cFiABQABB+"%" 

If lMVPAR11 .AND. !Empty(MV_PAR11)
	cValMVPAR11 := STRTRAN(MV_PAR11, "TFJ_FILIAL")
	cValMVPAR11 := REPLACE(cValMVPAR11, " IN")
	cValMVPAR11 := REPLACE(cValMVPAR11, "(")
	cValMVPAR11 := REPLACE(cValMVPAR11, ")")
	cValMVPAR11 := REPLACE(cValMVPAR11, "'")
	aFilsPAR11 := StrTokArr(cValMVPAR11,",")
	For nX := 1 To LEN(aFilsPAR11)
		If nX == 1
			cXfilTFL += " IN ("
			cXfilCN9 += " IN ("
		EndIf
		cXfilTFL += "'" + xFilial("TFL", aFilsPAR11[nX] ) 
		cXfilCN9 += "'" + xFilial("CN9", aFilsPAR11[nX] )
		If nX >= 1 .AND. nX < LEN(aFilsPAR11)
			cXfilTFL +=  "',"
			cXfilCN9 +=  "',"
		EndIf
		If nX == LEN(aFilsPAR11)
			cXfilTFL += " ') "	
			cXfilCN9 += " ') "	
		EndIf
	Next nX
	cXfilTFL := "%"+cXfilTFL+"%" 
	cXfilCN9 := "%"+cXfilCN9+"%"  
Else
	cXfilTFL :=  " = '" + xFilial("TFL", cFilAnt) +"'"   
	cXfilTFL := "%"+cXfilTFL+"%" 
			
	cXfilCN9 :=  " = '" + xFilial("CN9", cFilAnt) +"'"   
	cXfilCN9 := "%"+cXfilCN9+"%" 
EndIf		

BEGIN REPORT QUERY oSection1
//Verifica alocações ativas e não atendidas
BeginSQL alias cAlias1
	column ABB_DTINI as Date
	column ABB_DTFIM as Date
	column ABR_DTINI as Date
	column ABR_DTFIM as Date
	column ABR_DTMAN as Date

Select DISTINCT CN9_FILIAL,
 A1_FILIAL,A1_COD,A1_LOJA,A1_PESSOA,A1_NOME,A1_NREDUZ,A1_END,A1_EST,A1_ESTADO,A1_MUN,A1_BAIRRO,/*Tabela de Clientes*/

 CN9_NUMERO,CN9_REVISA,CN9_VLATU,CN9_DTINIC,CN9_DTFIM,TFL_FILIAL,TFL_LOCAL,TFL_CONTRT,TFL_CONREV,

 AA1_FILIAL, AA1_CODTEC,AA1_NOMTEC,AA1_CDFUNC,AA1_FUNFIL,AA1_CC,AA1_REGIAO,/* Atendentes */

 ABB_FILIAL,ABB_CODTEC,ABB_NUMOS,ABB_ENTIDA,ABB_ATIVO,ABB_CHAVE,ABB_DTINI, ABB_HRINI,/* Agendamentos */
 ABB_DTFIM,ABB_HRFIM,ABB_ATENDE,ABB_MANUT,ABB_IDCFAL,ABB_CODIGO,ABB_HRTOT, ABB_LOCAL,

ABR_FILIAL,ABR_MOTIVO,ABR_DTMAN,ABR_DTINI,ABR_HRINI,ABR_CODSUB,ABR_DTFIM, ABR_HRFIM,/* Manutenções da Agenda */
 ABR_MOTIVO,ABR_USASER,ABR_TEMPO,ABR_AGENDA,ABR_MANUT,ABR_DTINIA,ABR_TEMPO,
 ABR_HRINIA,ABR_DTFIMA,ABR_HRFIMA,ABR.R_E_C_N_O_,
 
 ABQ_FILIAL,ABQ_CONTRT,ABQ_ITEM,ABQ_PRODUT,ABQ_TPPROD,ABQ_LOCAL,
 
 CNC_CLIENT,CNC_LOJACL
 
From %table:CN9% CN9

LEFT JOIN 
%table:TFL% TFL ON (TFL.TFL_FILIAL %exp:cXfilTFL% AND TFL.TFL_CONTRT = CN9.CN9_NUMERO AND
 					TFL.TFL_CONREV = CN9.CN9_REVISA AND TFL.%notDel% AND %exp:cFiCN9TFL% )
      
LEFT JOIN 
%table:TFF% TFF ON (TFF.TFF_FILIAL = TFL.TFL_FILIAL AND TFF.TFF_CODPAI = TFL.TFL_CODIGO AND TFF.%notDel%)

LEFT JOIN 
%table:ABQ% ABQ ON (ABQ.ABQ_FILTFF = TFF.TFF_FILIAL AND ABQ.ABQ_CODTFF = TFF.TFF_COD AND ABQ.%notDel%)      

LEFT JOIN 
%table:ABB% ABB ON ( %exp:cFiABBABQ% AND ABB.ABB_IDCFAL = ABQ.ABQ_CONTRT|| ABQ.ABQ_ITEM ||ABQ.ABQ_ORIGEM AND ABB.%notDel%)
   
LEFT JOIN 
%table:ABR% ABR ON (ABR.ABR_FILIAL = ABB.ABB_FILIAL AND ABR.ABR_AGENDA = ABB.ABB_CODIGO AND ABR.%notDel%)

LEFT JOIN 
%table:CNC% CNC ON (%exp:cFiCNCCN9% AND CNC.CNC_NUMERO = CN9.CN9_NUMERO AND CNC.CNC_REVISA = CN9.CN9_REVISA AND CNC.%notDel% )
 
INNER JOIN 
%table:SA1% SA1 ON ( %exp:cFiSA1CNC%  AND SA1.A1_COD = CNC.CNC_CLIENT AND SA1.A1_LOJA = CNC.CNC_LOJACL AND SA1.%notDel%)
   
LEFT JOIN 
%table:AA1% AA1 ON ( %exp:cFiAA1AAB% AND AA1.AA1_CODTEC = ABB.ABB_CODTEC AND AA1.%notDel%)

Where	AA1_CODTEC BETWEEN %exp:mv_Par05% AND %exp:mv_Par06%
	AND ABB_DTINI BETWEEN %exp:mv_Par07% AND %exp:mv_Par08%
	AND A1_COD BETWEEN %exp:mv_Par01% AND %exp:mv_Par02%
	AND CN9_NUMERO BETWEEN %exp:mv_Par03% AND %exp:mv_Par04%
	AND %exp:cFiABQCN9%  
	AND %exp:cFiABQABB% 
	AND ABQ_CONTRT = CN9_NUMERO
	AND ABQ_LOCAL = ABB_LOCAL
	AND ABB_IDCFAL != %exp:cIdcfal%
    AND CN9.CN9_FILIAL %exp:cXfilCN9%
	AND CN9.%notDel%

ORDER BY CN9_FILIAL, A1_COD, 
		  A1_LOJA, 
		  CN9_NUMERO, 
		  CN9_REVISA, 
		  TFL_LOCAL, 
		  AA1_CODTEC,
		  ABB_DTINI, 
		  ABB_HRINI,
		  ABR_DTINI, 
		  ABR_HRINI

EndSql

END REPORT QUERY oSection1

Count To nCount
(cAlias1)->(DbGoTop())

//Section 2 - CN9 - Contratos
oSection2:SetParentQuery()

oSection2:SetParentFilter({|cParam| (cAlias1)->(CNC_CLIENT+CNC_LOJACL) == cParam },{|| (cAlias1)->(A1_COD+A1_LOJA) })

//Section 3 - TFL - 
oSection3:SetParentQuery()
oSection3:SetParentFilter({|cParam| (cAlias1)->(CN9_FILIAL + CN9_NUMERO + CN9_REVISA) == cParam},{|| (cAlias1)->(TFL_FILIAL + TFL_CONTRT + TFL_CONREV)})

//Section 4 - AA1 - Tecnico
oSection4:SetParentQuery()
oSection4:SetParentFilter({|cParam| (cAlias1)->(TFL_FILIAL + TFL_LOCAL + (cAlias1)->CN9_NUMERO) == cParam},{|| (cAlias1)->(ABB_FILIAL + ABB_LOCAL + (cAlias1)->TFL_CONTRT)  })

//Section 5 - ABB - Agendamentos
oSection5:SetParentQuery()
oSection5:SetParentFilter({|cParam| (cAlias1)->(AA1_FILIAL + AA1_CODTEC + (cAlias1)->CN9_NUMERO) == cParam},{|| (cAlias1)->(ABB_FILIAL + ABB_CODTEC + (cAlias1)->TFL_CONTRT)  })

//Section 6 - ABR - Manutenção da Agenda
oSection6:SetParentQuery()
oSection6:SetParentFilter({|cParam| (cAlias1)->(ABR_FILIAL + ABR_AGENDA) == cParam},{|| (cAlias1)->(ABB_FILIAL + ABB_CODIGO) })

//Executa impressão
oSection1:Print()
                                                                                                                                           
Return(.T.)


//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_At610TManC()

Escala X Cliente ou Contrato - Cálcula o tempo de manutenção 

@sample 	U_At610TManC(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function At610TManC(cAlias1)
Local aArea	:= GetArea()
Local cRet		:= "00:00"

DbSelectArea("ABN")
DbSetOrder(1)
If DbSeek(xFilial("ABN")+PadR(Trim((cAlias1)->ABR_MOTIVO),TamSx3("ABN_CODIGO")[1]))
	If ABN->ABN_TIPO $ '01|05|06'
		cRet := IntToHora(SubtHoras( ;
								(cAlias1)->ABB_DTINI,;
								(cAlias1)->ABB_HRINI,;
								(cAlias1)->ABB_DTFIM,;
								(cAlias1)->ABB_HRFIM,.T.))
								
	Else
		cRet := (cAlias1)->ABR_TEMPO
	EndIf
EndIf 

RestArea(aArea)
Return cRet

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_AT610TReal()

Escala X Cliente ou Contrato - Cálcula o planejamento realizado 

@sample 	U_AT610TReal(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function AT610TReal(cAlias1)

local aArea := GetArea()
Local cRet := IntToHora(SubtHoras( ;
					(cAlias1)->ABB_DTINI,;
					(cAlias1)->ABB_HRINI,;
					(cAlias1)->ABB_DTFIM,;
					(cAlias1)->ABB_HRFIM,.T.))

DbSelectArea("ABR")
DbSetOrder(1)
If DbSeek(xFilial("ABR",(cAlias1)->ABR_FILIAL)+(cAlias1)->ABB_CODIGO)

	DbSelectArea("ABN")
	DbSetOrder(1)
	If DbSeek(xFilial("ABN")+PadR(Trim(ABR->ABR_MOTIVO),TamSx3("ABN_CODIGO")[1]))
		If ABN->ABN_TIPO $ '01|05|06'
			cRet := "00:00"
		EndIf
	EndIf
EndIf

RestArea(aArea)

Return cRet