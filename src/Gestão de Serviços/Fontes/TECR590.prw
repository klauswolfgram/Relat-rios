/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "REPORT.CH"
#INCLUDE "TECR590.CH"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TECR590()

Escala X Cliente ou Contrato

@sample 	U_TECR590()
@return oReport
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function TECR590()

Local cPerg		:= "TECR590"
Local oReport					//Objeto relatorio TReport

Pergunte(cPerg,.F.)

#IFDEF TOP
	oReport := Rt590RDef(cPerg)
	oReport:PrintDialog()
#ELSE
	Alert(STR0013)   // STR0013 - "Este Relatório está disponível apenas para Topconnect."
#ENDIF

Return(.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt590RDef()

Escala X Cliente ou Contrato - monta as Section's para impressão do relatorio

@sample 	Rt590RDef(cPerg)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@Param 		cPerg, Perguntas
@return 	oReport 


/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt590RDef(cPerg)

Local oReport						//Objeto relatorio TReport (Release 4)
Local oSection1 					//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1) 
Local oSection2  					//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB") 
Local oSection3  					//Objeto secao 3 do relatorio (detalhes, campos das tabelas "SA1")
Local cAlias1		:= "QRYRP590"	//Alias da consulta Embedded SQL
Local lFunc5 		:= .F.
Local lFunc6 		:= .F.

#IFDEF TOP
	cAlias1 := GetNextAlias()	// Pega o proximo Alias Disponivel
#ENDIF

DEFINE REPORT oReport NAME "TECR590";
TITLE STR0001 PARAMETER "TECR590";							// STR0001 - "Escala X Cliente ou Contrato"
ACTION {|oReport| Rt590Print( oReport, cPerg, cAlias1 )};
DESCRIPTION STR0001											// STR0001 - "Escala X Cliente ou Contrato"

//Section 1 - SA1 - Clientes
DEFINE SECTION oSection1 OF oReport TITLE FwX2Nome("SA1") TABLES "SA1"

DEFINE CELL NAME "A1_COD"	OF oSection1 BLOCK {|| (cAlias1)->A1_COD} ALIAS cAlias1
DEFINE CELL NAME "A1_LOJA"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME "A1_PESSOA"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME "A1_NOME"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME "A1_NREDUZ"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME "A1_END"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME "A1_EST"	OF oSection1 ALIAS cAlias1                                                        
DEFINE CELL NAME "A1_BAIRRO"	OF oSection1 ALIAS cAlias1

//Section 2 - AA1 - Contratos de Manutenção
DEFINE SECTION oSection2 OF oSection1 TITLE FwX2Nome("AAH") TABLES "AAH" LEFT MARGIN 3

DEFINE CELL NAME "AAH_CONTRT"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AAH_CODPRO"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AAH_VALOR"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AAH_INIVLD"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AAH_FIMVLD"	OF oSection2 ALIAS cAlias1

//Section 3 - AA1 - Tecnico
DEFINE SECTION oSection3 OF oSection2 TITLE FwX2Nome("AA1") TABLES "AA1" LEFT MARGIN 6

DEFINE CELL NAME "AA1_CODTEC"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "AA1_NOMTEC"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "AA1_CDFUNC"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "AA1_FUNFIL"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "AA1_CC"	OF oSection3 BLOCK {|| (cAlias1)->AA1_CC}

//Section 4 - ABB - Agendamentos
DEFINE SECTION oSection4 OF oSection3 TITLE FwX2Nome("ABB") TABLES "ABB" LEFT MARGIN 9

DEFINE CELL NAME "ABB_NUMOS"	OF oSection4 BLOCK {|| (cAlias1)->ABB_NUMOS} 
DEFINE CELL NAME "ABB_DTINI"	OF oSection4 ALIAS cAlias1 
DEFINE CELL NAME "ABB_HRINI"	OF oSection4 ALIAS cAlias1 
DEFINE CELL NAME "ABB_DTFIM"	OF oSection4 ALIAS cAlias1 
DEFINE CELL NAME "ABB_HRFIM"	OF oSection4 ALIAS cAlias1 
DEFINE CELL NAME "ABB_HRTOT"	OF oSection4 BLOCK {|| U_AT590TReal(cAlias1)}																			
DEFINE CELL NAME "ABBHRTOT"		OF oSection4 TITLE STR0007 Size(8) BLOCK {|| SUBSTR((cAlias1)->ABB_HRTOT,6,10) }
DEFINE CELL NAME "ABB_ATENDE"	OF oSection4 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATENDE)== "1", STR0002,STR0003)}		// STR0002 - "Sim"; STR0003 - "Não"
DEFINE CELL NAME "ABB_ATIVO"	OF oSection4 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATIVO)== "1", STR0002,STR0003)}		// STR0002 - "Sim"; STR0003 - "Não"
DEFINE CELL NAME "ABB_MANUT"	OF oSection4 BLOCK {|| IIf (Trim((cAlias1)->ABB_MANUT)== "1", STR0002,STR0003)}		// STR0002 - "Sim"; STR0003 - "Não"

//Section 5 - ABR - Manutenção da Agenda
DEFINE SECTION oSection5 OF oSection4 TITLE FwX2Nome("ABR") TABLES "ABR" LEFT MARGIN 12

DEFINE CELL NAME "ABR_MOTIVO"	OF oSection5 BLOCK {|| Trim((cAlias1)->ABR_MOTIVO)}
DEFINE CELL NAME STR0006			OF oSection5 BLOCK {|| Posicione("ABN",1, xFilial("ABN")+PadR(Trim((cAlias1)->ABR_MOTIVO),;			// STR0006 - "Desc. do Motivo"
																	TamSx3("ABN_CODIGO")[1]),"ABN->ABN_DESC")}		 
DEFINE CELL NAME "ABR_DTMAN"	OF oSection5 ALIAS cAlias1
DEFINE CELL NAME "ABR_DTINIA"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_HRINIA"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_DTFIMA"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_HRFIMA"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_DTINI"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_HRINI"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_DTFIM"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABR_HRFIM"	OF oSection5 ALIAS cAlias1 
DEFINE CELL NAME "ABRTEMPO"	 	OF oSection5 TITLE STR0016 SIZE(18) BLOCK{|| U_AT590TManC(cAlias1)}		//"Tempo Manutenção"

oSection5:cell("ABR_DTINI"):Disable()
oSection5:cell("ABR_HRINI"):Disable()
oSection5:cell("ABR_DTFIM"):Disable()
oSection5:cell("ABR_HRFIM"):Disable()

oSection5:cell("ABR_DTINIA"):Disable()
oSection5:cell("ABR_HRINIA"):Disable()
oSection5:cell("ABR_DTFIMA"):Disable()
oSection5:cell("ABR_HRFIMA"):Disable()

oSection1:SetTotalInLine(.T.)
oSection2:SetTotalInLine(.T.)
oSection3:SetTotalInLine(.F.)
oSection4:SetTotalInLine(.F.)
oSection5:SetTotalInLine(.F.)
oReport:SetTotalInLine(.T.)

// Totais por Contratos

DEFINE FUNCTION NAME "T1OTREAL" FROM oSection4:Cell("ABB_HRTOT");
OF oSection2 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT	//"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "T2OTPLAN" FROM oSection4:Cell("ABBHRTOT");
OF oSection2 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0010 NO END REPORT	//"Total de Atendimentos Planejados"

DEFINE FUNCTION NAME "T3MANREAL" FROM oSection5:Cell("ABRTEMPO");				//"Tempo Manutenção"
OF oSection2 PRINT WHEN {||.F.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0011 NO END REPORT
	
DEFINE FUNCTION NAME "T4PLANE" FROM oSection5:Cell("ABRTEMPO") OF oSection2 FUNCTION ONPRINT;
FORMULA {|| IIf((Len(oReport:aFunction) > 2 .AND. oReport:aFunction[3]:uSection == NIL),"00:00",oReport:aFunction[3]:uSection)} TITLE STR0012 NO END REPORT		////"Total de Atendimentos Planejados X Realizados"

// Totais por Clientes

DEFINE FUNCTION NAME "T5OTREAL" FROM oSection4:Cell("ABB_HRTOT");
OF oSection1 PRINT WHEN {|| lFunc5 := .T. } FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT	//"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "T6OTPLAN" FROM oSection4:Cell(STR0007);
OF oSection1 PRINT WHEN {|| lFunc6 := .T.} FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0010 NO END REPORT	//"Total de Atendimentos Planejados"

DEFINE FUNCTION NAME "T7MANREAL" FROM oSection5:Cell("ABRTEMPO");				//"Tempo Manutenção"
OF oSection1 PRINT WHEN {||.F.} FUNCTION ONPRINT;
FORMULA {||IIf(lFunc5 .AND. lFunc6,IntToHora(HoraToInt(oReport:aFunction[6]:uSection,At(":",oReport:aFunction[6]:uSection)-1)-;
			HoraToInt(oReport:aFunction[5]:uSection,At(":",oReport:aFunction[5]:uSection)-1)),"00:00")};
		   PICTURE "@ 999999999:99" TITLE STR0012 NO END REPORT				//"Total de Atendimentos Planejados X Realizados"

DEFINE FUNCTION NAME "T8PLANE" FROM oSection5:Cell("ABRTEMPO") OF oSection1 FUNCTION ONPRINT;
FORMULA {||IIf((Len(oReport:aFunction) > 6 .AND. oReport:aFunction[7]:uSection == NIL),"00:00",oReport:aFunction[7]:uSection)} TITLE STR0012 NO END REPORT		////"Total de Atendimentos Planejados X Realizados"

DEFINE FUNCTION NAME "T9PLANE" FROM oSection2:Cell("AAH_VALOR");
 OF oSection1 FUNCTION SUM TITLE STR0015 NO END REPORT									//"Valor Total dos Contratos"

Return oReport

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_AT590TReal()

Escala X Cliente ou Contrato - Cálcula o planejamento realizado 

@sample 	U_AT590TReal(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function AT590TReal(cAlias1)

local aArea := GetArea()
Local cRet := IntToHora(SubtHoras( ;
					(cAlias1)->ABB_DTINI,;
					(cAlias1)->ABB_HRINI,;
					(cAlias1)->ABB_DTFIM,;
					(cAlias1)->ABB_HRFIM,.T.))

DbSelectArea("ABR")
DbSetOrder(1)
If DbSeek(xFilial("ABR")+(cAlias1)->ABB_CODIGO)

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

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_At590TManC()

Escala X Cliente ou Contrato - Cálcula o tempo de manutenção 

@sample 	U_At590TManC(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function At590TManC(cAlias1)
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
/*/{Protheus.doc} Rt590Print()

Escala X Cliente ou Contrato - monta a Query e imprime o relatorio de acordo com os parametros

@sample 	Rt590Print(oReport, cPerg, cAlias1)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@param		oReport, Objeto
@param		cPerg, Caracter, Perguntas do relatorio
@param		cAlias1, Caracter, Alias da Query
@return oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt590Print(oReport, cPerg, cAlias1)

Local oSection1	:= oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1)
Local oSection2	:= oSection1:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB")
Local oSection3	:= oSection2:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABR","ABN")
Local oSection4	:= oSection3:Section(1) 	//
Local oSection5	:= oSection4:Section(1) 	//
Local cSinalCon	:= If(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") //Sinal de concatenação (Igual ao ADMXFUN)
Local cExpCon	:= "%ABQ.ABQ_CONTRT"+cSinalCon+"ABQ.ABQ_ITEM%"
Local cNumOsAB7	:= "%AB7.AB7_NUMOS"+cSinalCon+"AB7.AB7_ITEM%"
Local cIdcfal	:= Space(TamSX3("ABB_IDCFAL")[1])	// ID Configuracao Alocacao
Local cFiliABR	:= xFilial('ABR')
Local cFiliABQ	:= xFilial('ABQ')
Local cFiliAA1	:= xFilial('AA1')
Local cFiliABB	:= xFilial('ABB')
Local cFiliSA1	:= xFilial('SA1')
Local cFiliAB7	:= xFilial('AB7')
Local cMvpar3	:= mv_Par03
Local cMvpar4	:= mv_Par04
Local cMvpar5	:= ALLTRIM(mv_Par05)
Local cMvpar6	:= ALLTRIM(mv_Par06)
Local cMvpar7	:= ALLTRIM(mv_Par07)
Local cMvpar8	:= ALLTRIM(mv_Par08)
Local nCount	:= 0
DEFAULT cAlias1	:= GetNextAlias()

BEGIN REPORT QUERY oSection1
//Verifica alocações ativas e não atendidas
BeginSQL alias cAlias1
	column ABB_DTINI as Date
	column ABB_DTFIM as Date
	column ABR_DTINI as Date
	column ABR_DTFIM as Date
	column ABR_DTMAN as Date

Select 	
 A1_FILIAL,A1_COD,A1_LOJA,A1_PESSOA,A1_NOME,A1_NREDUZ,A1_END,A1_EST,A1_ESTADO,A1_MUN,A1_BAIRRO,/*Tabela de Clientes*/

 AAH_FILIAL,AAH_CONTRT,AAH_CODCLI,AAH_LOJA,AAH_CODPRO,AAH_VALOR,AAH_CONPAG,AAH_INIVLD,AAH_FIMVLD,

 AA1_FILIAL,AA1_CODTEC,AA1_NOMTEC,AA1_CDFUNC,AA1_FUNFIL,AA1_CC,AA1_REGIAO,/* Atendentes */

 ABB_FILIAL,ABB_CODTEC,ABB_NUMOS,ABB_ENTIDA,ABB_ATIVO,ABB_CHAVE,ABB_DTINI, ABB_HRINI,/* Agendamentos */
 ABB_DTFIM,ABB_HRFIM,ABB_ATENDE,ABB_MANUT,ABB_IDCFAL,ABB_CODIGO,ABB_HRTOT,

 ABR_FILIAL,ABR_MOTIVO,ABR_DTMAN,ABR_DTINI,ABR_HRINI,ABR_CODSUB,ABR_DTFIM, ABR_HRFIM,/* Manutenções da Agenda */
 ABR_MOTIVO,ABR_USASER,ABR_TEMPO,ABR_AGENDA,ABR_MANUT,ABR_DTINIA,
 ABR_HRINIA,ABR_DTFIMA,ABR_HRFIMA,ABR.R_E_C_N_O_,

 ABQ_FILIAL,ABQ_CONTRT,ABQ_ITEM,		/* Tabela de config de Alocaçoes */

 AB7_NUMOS,AB7_ITEM,AB7_CODPRO,AB7_NUMSER		/* Itens da Ordem de Serviço */

From %table:AAH% AAH

LEFT JOIN
 %table:ABQ% ABQ ON (ABQ.ABQ_FILIAL = %exp:cFiliABQ% AND ABQ.ABQ_CONTRT = AAH.AAH_CONTRT AND ABQ.%notDel%)

LEFT JOIN 
 %table:ABB% ABB ON (ABB.ABB_FILIAL = %exp:cFiliABB% AND ABB.ABB_IDCFAL = %exp:cExpCon% AND ABB.%notDel%)

LEFT JOIN 
 %table:ABR% ABR ON (ABR.ABR_FILIAL = %exp:cFiliABR% AND ABR.ABR_AGENDA = ABB.ABB_CODIGO AND ABR.%notDel%)

INNER JOIN 
 %table:SA1% SA1 ON (SA1.A1_FILIAL = %exp:cFiliSA1% AND SA1.A1_COD = AAH.AAH_CLIENT AND SA1.A1_LOJA = AAH.AAH_LOJA AND SA1.%notDel%)

LEFT JOIN 
 %table:AA1% AA1 ON (AA1.AA1_FILIAL = %exp:cFiliAA1% AND AA1.AA1_CODTEC = ABB.ABB_CODTEC AND AA1.%notDel%)
 
LEFT JOIN 
 %table:AB7% AB7 ON (AB7.AB7_FILIAL = %exp:cFiliAB7% AND %exp:cNumOsAB7% = ABB_CHAVE AND AB7.%notDel%)

Where	
	AA1_CODTEC BETWEEN %exp:AllTrim(mv_Par05)% AND %exp:AllTrim(mv_Par06)%
	AND ABB_DTINI BETWEEN %exp:mv_Par07% AND %exp:mv_Par08%
	AND A1_COD BETWEEN %exp:mv_Par01% AND %exp:mv_Par02%
	AND AAH_CONTRT BETWEEN %exp:mv_Par03% AND %exp:mv_Par04%
	AND ABQ_CONTRT = AAH_CONTRT
	AND ABB_IDCFAL != %exp:cIdcfal%
	AND AAH.%notDel%

Order By SA1.A1_COD ,
        SA1.A1_LOJA ,
        AAH.AAH_CONTRT ,
        AA1.AA1_CODTEC ,
        ABB.ABB_DTINI ,
        ABB.ABB_HRINI ,
        ABR.ABR_DTINI ,
        ABR.ABR_HRINI

EndSql

END REPORT QUERY oSection1

Count To nCount
(cAlias1)->(DbGoTop())

//Section 1 - SA1 - Clientes
//Section 2 - AAH - Contratos de Manutenção
//Section 3 - AA1 - Tecnico
//Section 4 - ABB - Agendamentos
//Section 5 - ABR - Manutenção da Agenda

//Section 2 - AAH - Contratos de Manutenção
oSection2:SetParentQuery()
oSection2:SetParentFilter({|cParam| (cAlias1)->AAH_CODCLI == cParam },{|| (cAlias1)->A1_COD })

//Section 3 - AA1 - Tecnico
oSection3:SetParentQuery()
oSection3:SetParentFilter({|cParam| (cAlias1)->AAH_CONTRT == cParam },{|| (cAlias1)->ABQ_CONTRT })

//Section 4 - ABB - Agendamentos
oSection4:SetParentQuery()
oSection4:SetParentFilter({|cParam| (cAlias1)->AAH_CONTRT+(cAlias1)->AA1_CODTEC == cParam},{|| (cAlias1)->ABQ_CONTRT+(cAlias1)->ABB_CODTEC })

//Section 5 - ABR - Manutenção da Agenda
oSection5:SetParentQuery()
oSection5:SetParentFilter({|cParam| (cAlias1)->ABR_AGENDA+(cAlias1)->AAH_CONTRT == cParam},{|| (cAlias1)->ABB_CODIGO+(cAlias1)->ABQ_CONTRT })

//Executa impressão
oSection1:Print()
                                                                                                                                           
Return(.T.)