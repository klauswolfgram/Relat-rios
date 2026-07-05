/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "REPORT.CH"
#INCLUDE "TECR600.CH"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TECR600()

Escala X Região

@sample 	U_TECR600()
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@return 	oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function TECR600(nSel)                                                        

Local cPerg		:= ""
Local oReport					//Objeto relatorio TReport
Local oOpcao
Local oDlg
Local oBtn
Local nOpcao		:= 1

Default nSel      := 0

DbSelectArea("SX1")
DbSetOrder(1)

If DbSeek("TECR600A")

    If !Isblind()

	    DEFINE DIALOG oDlg TITLE STR0015 FROM 00,00 TO 100,170 PIXEL // Tipo de Contrato
	
		oDlg:LEscClose := .F.
		
		oOpcao := TRadMenu():New(05,05,{STR0016,STR0017},,oDlg,,,,,,,,60,80,,,,.T.) //"Gestão de Serviços","Gestão de Contratos"
		
		oOpcao:bSetGet := {|x|IIf(PCount()==0,nOpcao,nOpcao:=x)}
		
		oBtn := TButton():New(30,15,STR0018,oDlg,{||nOpcao,oDlg:End()},55,15,,,.F.,.T.,.F.,,.F.,,,.F. ) //'Confirmar'
	
	    ACTIVATE DIALOG oDlg CENTERED
    else
        nOpcao := nSel
    Endif        
	
EndIf

If nOpcao == 1
	cPerg		:= "TECR600"
Else	
	cPerg		:= "TECR600A"
EndIf

Pergunte(cPerg,.F.)

#IFDEF TOP
	oReport := Rt600RDef(cPerg)
	oReport:PrintDialog()
#ELSE
	Alert(STR0013) //"Este Relatório está disponível apenas para Topconnect."
#ENDIF

Return (.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt600RDef()

Escala X Região - monta as Section's para impressão do relatorio

@sample 	Rt600RDef(cPerg)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@return	oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function  Rt600RDef(cPerg)

Local oReport					//Objeto relatorio TReport (Release 4)
Local oSection1 				//Objeto secao 1 do relatorio (Cabecalho, campos da tabela ABU) 
Local oSection2  				//Objeto secao 2 do relatorio (detalhes, campos das tabelas "AA1") 
Local oSection3  				//Objeto secao 3 do relatorio (detalhes, campos das tabelas "ABB")
Local oSection4  				//Objeto secao 4 do relatorio (detalhes, campos das tabelas "ABR")
Local cAlias1	:= "QRYRP600"	//Alias da consulta Embedded SQL

#IFDEF TOP
	cAlias1 := GetNextAlias()	// Pega o proximo Alias Disponivel
#ENDIF

DEFINE REPORT oReport NAME "TECR600" TITLE STR0001 PARAMETER cPerg;
ACTION {|oReport| Rt600Print( oReport, cPerg, cAlias1 )} DESCRIPTION STR0001 	//"Escala X Região"

//Section 1 - AA1 - Tecnico
DEFINE SECTION oSection1 OF oReport TITLE FwX2Nome("AA1") TABLES cAlias1

DEFINE CELL NAME "ABU_REGIAO"	OF oSection1 ALIAS cAlias1
DEFINE CELL NAME STR0014			OF oSection1 BLOCK {|| U_Rt600DReg((cAlias1)->ABU_REGIAO)} ALIAS cAlias1 	//"Desc. da Região"

//Section 2 - AA1 - Tecnico
DEFINE SECTION oSection2 OF oSection1 TITLE FwX2Nome("AA1") TABLES cAlias1 LEFT MARGIN 3

DEFINE CELL NAME "AA1_CODTEC"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AA1_NOMTEC"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AA1_CDFUNC"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AA1_FUNFIL"	OF oSection2 ALIAS cAlias1
DEFINE CELL NAME "AA1_CC"		OF oSection2 BLOCK {|| (cAlias1)->AA1_CC}

//Secao 3 - ABB - Agendamentos
DEFINE SECTION oSection3 OF oSection2 TITLE FwX2Nome("ABB") TABLES cAlias1 LEFT MARGIN 6

DEFINE CELL NAME "ABB_NUMOS"	OF oSection3 BLOCK {|| (cAlias1)->ABB_NUMOS} 
DEFINE CELL NAME "ABQ_CONTRT"	OF oSection3 BLOCK {|| Trim((cAlias1)->ABQ_CONTRT)}
DEFINE CELL NAME STR0004 	OF oSection3 BLOCK {|| Trim((cAlias1)->A1_COD)}		//"Cód. do Cliente"
DEFINE CELL NAME STR0005  	OF oSection3 BLOCK {|| Trim((cAlias1)->A1_NOME)}		//"Nome do Cliente"
DEFINE CELL NAME "ABB_DTINI"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "ABB_HRINI"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "ABB_DTFIM"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "ABB_HRFIM"	OF oSection3 ALIAS cAlias1
DEFINE CELL NAME "ABB_HRTOT"	OF oSection3 BLOCK {|| U_AT600TReal(cAlias1) }	
DEFINE CELL NAME STR0007      	OF oSection3 Size(8) BLOCK {|| SUBSTR((cAlias1)->ABB_HRTOT,6,10) }		//"Hrs. Planejadas"
DEFINE CELL NAME "ABB_ATENDE"	OF oSection3 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATENDE)== "1", STR0002,STR0003)}		//"Sim"; "Não"
DEFINE CELL NAME "ABB_ATIVO"	OF oSection3 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATIVO)== "1", STR0002,STR0003)}		//"Sim"; "Não"
DEFINE CELL NAME "ABB_MANUT"	OF oSection3 BLOCK {|| IIf (Trim((cAlias1)->ABB_MANUT)== "1", STR0002,STR0003)}		//"Sim"; "Não"

//Secao 4 - ABR - Manutenção da Agenda
DEFINE SECTION oSection4 OF oSection3 TITLE FwX2Nome("ABR") TABLES "ABR" LEFT MARGIN 9

DEFINE CELL NAME "ABR_MOTIVO"	OF oSection4 BLOCK {|| Trim((cAlias1)->ABR_MOTIVO)}
DEFINE CELL NAME STR0006	OF oSection4 BLOCK {|| Posicione("ABN",1, xFilial("ABN")+PadR(Trim((cAlias1)->ABR_MOTIVO),;			//"Desc. do Motivo"
																	TamSx3("ABN_CODIGO")[1]),"ABN->ABN_DESC")}
DEFINE CELL NAME "ABR_DTMAN"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_DTINIA"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_HRINIA"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_DTFIMA"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_HRFIMA"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME STR0019	OF oSection4 SIZE(18) BLOCK{||U_At600TManC(cAlias1)} //"Tempo Manutenção"
DEFINE CELL NAME "ABR_DTINI"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_HRINI"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_DTFIM"	OF oSection4 ALIAS cAlias1
DEFINE CELL NAME "ABR_HRFIM"	OF oSection4 ALIAS cAlias1

oSection4:cell("ABR_DTINI"):Disable()
oSection4:cell("ABR_HRINI"):Disable()
oSection4:cell("ABR_DTFIM"):Disable()
oSection4:cell("ABR_HRFIM"):Disable()

oSection4:cell("ABR_DTINIA"):Disable()
oSection4:cell("ABR_HRINIA"):Disable()
oSection4:cell("ABR_DTFIMA"):Disable()
oSection4:cell("ABR_HRFIMA"):Disable()

oSection1:SetTotalInLine(.T.)
oSection2:SetTotalInLine(.F.)
oSection3:SetTotalInLine(.F.)
oSection4:SetTotalInLine(.F.)
oReport:SetTotalInLine(.T.)    

DEFINE FUNCTION NAME "TOTREAL" FROM oSection3:Cell("ABB_HRTOT");
OF oSection1 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT 				//"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "TOTPLAN" FROM oSection3:Cell(STR0007);
OF oSection1 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0010 NO END REPORT 				//"Total de Atendimentos Planejado"

DEFINE FUNCTION NAME "TMANREAL" FROM oSection4:Cell(STR0019) OF oSection1 PRINT WHEN {||.F.} FUNCTION ONPRINT;								//"Tempo Manutenção"
FORMULA {|| IntToHora(HoraToInt(oSection1:GetFunction("TOTPLAN"):SectionValue(),At(":",oSection1:GetFunction("TOTPLAN"):SectionValue())-1)-HoraToInt(oSection1:GetFunction("TOTREAL"):SectionValue(),At(":",oSection1:GetFunction("TOTREAL"):SectionValue())-1))};
 PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT

DEFINE FUNCTION NAME "TPLANE" FROM oSection4:Cell(STR0019) OF oSection1 FUNCTION ONPRINT;		//"Tempo Manutenção"
FORMULA {||IIf(oSection1:GetFunction("TMANREAL"):SectionValue() == NIL,"00:00",oSection1:GetFunction("TMANREAL"):SectionValue())};
			TITLE STR0012 NO END REPORT 																	//"Total de Atendimentos Realizados X Planejados"

Return (oReport)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_Rt600DReg()

Escala X Região - retorna a descrição da região

@sample	U_Rt600DReg(cRegiao)
@author	Rodrigo A. Pirolo
@since		22/05/2013
@version	P12
@param		cRegiao, Codigo da região
@return 	cDescReg
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function Rt600DReg(cRegiao)

cDescReg := ""

DbSelectArea("SX5")
DbSetOrder(1)

If DbSeek(xFilial("SX5")+"A2"+cRegiao)
	cDescReg := X5Descri()
EndIf

Return (cDescReg)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_AT600TReal()

Escala X Região - Cálcula o planejamento realizado 

@sample 	U_AT600TReal(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function AT600TReal(cAlias1)

local aArea 	:= GetArea()
Local cRet		:= IntToHora(SubtHoras( ;
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
/*/{Protheus.doc} U_At600TManC()

Escala X Região - Cálcula o tempo de manutenção 

@sample 	U_At600TManC(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function At600TManC(cAlias1)
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
/*/{Protheus.doc} Rt600Print()

Escala X Região - monta a Query e imprime o relatorio de acordo com os parametros

@sample 	Rt600Print(oReport, cPerg, cAlias1)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@return 	oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt600Print(oReport, cPerg, cAlias1)

Local oSection1	:= oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos da tabela ABU)
Local oSection2	:= oSection1:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "AA1")
Local oSection3	:= oSection2:Section(1) 	//Objeto secao 3 do relatorio (detalhes, campos das tabelas "ABB")
Local oSection4	:= oSection3:Section(1) 	//Objeto secao 4 do relatorio (detalhes, campos das tabelas "ABR")
Local cSinalCon	:= If(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") //Sinal de concatenação (Igual ao ADMXFUN)
Local cExpCon	:= ""
Local cIdcfal	:= Space(TamSX3("ABB_IDCFAL")[1])	// ID Configuracao Alocacao
Local cFiliABR	:= xFilial('ABR')
Local cFiliABQ	:= xFilial('ABQ')
Local cFiliAA1	:= xFilial('AA1')
Local cFiliABB	:= xFilial('ABB')
Local cFiliSA1	:= xFilial('SA1')
Local cFiliABU	:= xFilial('ABU')
Local cFiliABS	:= xFilial('ABS')
Local cFiliAB6	:= xFilial('AB6')
Local cMvpar3	:= mv_Par03
Local cMvpar4	:= mv_Par04
Local cMvpar5	:= mv_Par05
Local cMvpar6	:= mv_Par06
Local cMvpar7	:= mv_Par07
Local cMvpar8	:= mv_Par08
Local cMvpar9	:= mv_Par09
Local cMvpar10	:= mv_Par10
Local cClient	:= ""
Local cContra	:= ""
Local cTab			:= ""

DEFAULT cAlias1		:= GetNextAlias()

If ABQ->(FieldPos("ABQ_ORIGEM")) > 0
	cExpCon	:= "%ABQ.ABQ_CONTRT"+cSinalCon+"ABQ.ABQ_ITEM"+cSinalCon+"ABQ.ABQ_ORIGEM%"
Else
	cExpCon	:= "%ABQ.ABQ_CONTRT"+cSinalCon+"ABQ.ABQ_ITEM%"
EndIf

If cPerg == "TECR600"
	cClient		:= "%AAH_CODCLI%"
	cContra		:= "%AAH_CONTRT%"
	cLoja			:= "%AAH_LOJA%"
	cCondicao		:= "%%"
	cTab			:= RetSqlName("AAH")
	cTab			:= "%"+cTab+"%"
	cCond1			:= "% ABQ.ABQ_ORIGEM <> 'CN9' AND%"
	cRegiao		:= "%AB6.AB6_REGIAO%"
	cLeftJ			:= "%LEFT JOIN "+RetSqlName("AB6")+" AB6 ON (AB6.AB6_FILIAL = '"+xFilial("AB6")+"' AND AB6_NUMOS = ABB_NUMOS AND AB6.D_E_L_E_T_= ' ')%"
	cLfJCNC		:= "%%"
Else
	cClient		:= "%CNC_CLIENT%"
	cContra		:= "%CN9_NUMERO%"
	cLoja			:= "%CNC_LOJACL%"
	cCondicao      := "%CONTR.CN9_SITUAC = '05' AND%"
	cTab			:= RetSqlName("CN9")
	cTab			:= "%"+cTab+"%"
	cCond1			:= "% ABQ.ABQ_ORIGEM = 'CN9' AND %"
	cRegiao		:= "%LOC.ABS_REGIAO%"
	cLeftJ			:= "%LEFT JOIN "+RetSqlName("ABS")+" LOC ON (LOC.ABS_FILIAL = '"+xFilial("ABS")+"' AND LOC.ABS_LOCAL = ABB.ABB_LOCAL AND LOC.D_E_L_E_T_= ' ')%"
	cLfJCNC		:= "%LEFT JOIN "+RetSqlName("CNC")+" CNC ON (CNC.CNC_FILIAL = '"+xFilial('CNC')+"' AND CNC.CNC_NUMERO = CN9_NUMERO AND CNC.CNC_REVISA = CN9_REVATU AND CNC.D_E_L_E_T_= ' ')%"
EndIf

BEGIN REPORT QUERY oSection1 
//Verifica alocações ativas e não atendidas
BeginSQL alias cAlias1
	column ABB_DTINI as Date
	column ABB_DTFIM as Date
	column ABR_DTINI as Date
	column ABR_DTFIM as Date
	column ABR_DTMAN as Date

Select	ABU_FILIAL,ABU_CODTEC,ABU_ITEM,ABU_REGIAO,				/* Atendentes X Região */

		AA1_FILIAL,AA1_CODTEC,AA1_FUNFIL,						/* Atendentes */
		AA1_NOMTEC,AA1_CDFUNC,AA1_CC,AA1_REGIAO,

		ABB_FILIAL,ABB_CODTEC,ABB_DTINI,ABB_MANUT,				/* Agendamentos */
		ABB_NUMOS,ABB_ENTIDA,ABB_ATIVO,ABB_CHAVE,
		ABB_HRINI,ABB_DTFIM,ABB_HRFIM,ABB_ATENDE,
		ABB_IDCFAL,ABB_CODIGO,ABB_HRTOT,
		
		ABR_FILIAL,ABR_MOTIVO,ABR_DTMAN,ABR_DTINI,ABR_HRINI,	/* Manutenções da Agenda */
		ABR_DTFIM,ABR_HRFIM,ABR_MOTIVO,ABR_USASER,ABR_TEMPO,
		ABR_AGENDA,ABR_MANUT,ABR_DTINIA,ABR_HRINIA,ABR_DTFIMA,
		ABR_HRFIMA,ABR.R_E_C_N_O_,ABR_CODSUB,
		
		ABQ_FILIAL,ABQ_CONTRT,ABQ_PRODUT,ABQ_TPPROD,			/*Tabela de config de Alocaçoes*/
		
		A1_COD,A1_NOME,											/*Tabela de Clientes*/

		%exp:cClient%,%exp:cContra%							/*Tabela de Contratos*/

From %exp:cTab% CONTR

LEFT JOIN
 %table:ABQ% ABQ ON (ABQ.ABQ_FILIAL = %exp:cFiliABQ% AND ABQ.ABQ_CONTRT = %exp:cContra% AND %exp:cCond1% ABQ.%notDel%)

LEFT JOIN
 %table:ABB% ABB ON (ABB.ABB_FILIAL = %exp:cFiliABB% AND ABB.ABB_IDCFAL = %exp:cExpCon% AND ABB.%notDel%)
 
LEFT JOIN
 %table:ABR% ABR ON (ABR.ABR_FILIAL = %exp:cFiliABR% AND ABR.ABR_AGENDA = ABB.ABB_CODIGO AND ABR.%notDel%)
 
%exp:cLfJCNC%

LEFT JOIN
 %table:SA1% SA1 ON (SA1.A1_FILIAL = %exp:cFiliSA1% AND SA1.A1_COD = %exp:cClient% AND SA1.A1_LOJA = %exp:cLoja% AND SA1.%notDel%)

LEFT JOIN
 %table:AA1% AA1 ON (AA1.AA1_FILIAL = %exp:cFiliAA1% AND AA1_CODTEC = ABB_CODTEC AND AA1.%notDel%)

%exp:cLeftJ%
 
LEFT JOIN
 %table:ABU% ABU ON (ABU.ABU_FILIAL = %exp:cFiliABU% AND ABU_CODTEC = AA1_CODTEC AND ABU_REGIAO = %exp:cRegiao% AND ABU.%notDel%)

Where	ABU_REGIAO BETWEEN %exp:AllTrim(mv_Par01)% AND %exp:AllTrim(mv_Par02)% 
		AND AA1_CODTEC BETWEEN %exp:cMvpar3% AND %exp:cMvpar4% 
		AND ABB_DTINI BETWEEN %exp:cMvpar5% AND %exp:cMvpar6% 
		AND A1_COD BETWEEN %exp:cMvpar7% AND %exp:cMvpar8% 
		AND %exp:cContra% BETWEEN %exp:cMvpar9% AND %exp:cMvpar10% 
		AND ABQ_CONTRT = %exp:cContra% AND
		%exp:cCondicao%
		ABB_IDCFAL != %exp:cIdcfal% AND
		CONTR.%notDel% 

Order By AA1_CODTEC, ABB_CODIGO, ABR_AGENDA, ABR_MANUT

EndSql

END REPORT QUERY oSection1

oSection2:SetParentQuery()
oSection2:SetParentFilter({|cParam| (cAlias1)->AA1_CODTEC == cParam },{|| (cAlias1)->ABU_CODTEC })

oSection3:SetParentQuery()
oSection3:SetParentFilter({|cParam| (cAlias1)->ABB_CODTEC == cParam },{|| (cAlias1)->AA1_CODTEC })

oSection4:SetParentQuery()
oSection4:SetParentFilter({|cParam| (cAlias1)->ABR_AGENDA == cParam},{|| (cAlias1)->ABB_CODIGO })

//Quebra Linha
oSection2:SetLineBreak()

//Executa impressão
oSection1:Print()

Return (.T.)
