/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"  
#INCLUDE "REPORT.CH"
#INCLUDE "TECR580.CH"

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_TECR580()

Relatório Escala X Efetivo Por Atendente

@sample 	U_TECR580()
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@return 	oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function TECR580()                                                        

Local cPerg		:= ""
Local oReport					//Objeto relatorio TReport
Local oOpcao
Local oDlg
Local oBtn
Local nOpcao		:= 1

DbSelectArea("SX1")
DbSetOrder(1)

If DbSeek("TECR580A")

	DEFINE DIALOG oDlg TITLE STR0015 FROM 00,00 TO 100,170 PIXEL		//"Tipo de Contrato"
	
		oDlg:LEscClose := .F.
		
		oOpcao := TRadMenu():New(05,05,{STR0016,STR0017},,oDlg,,,,,,,,60,80,,,,.T.)	//"Gestão de Serviços","Gestão de Contratos"
		
		oOpcao:bSetGet := {|x|IIf(PCount()==0,nOpcao,nOpcao:=x)}
		
		oBtn := TButton():New(30,15,STR0018,oDlg,{||nOpcao,oDlg:End()},55,15,,,.F.,.T.,.F.,,.F.,,,.F. ) //'Confirmar'
	
	ACTIVATE DIALOG oDlg CENTERED
	
EndIf	

If nOpcao == 1
	cPerg		:= "TECR580"
Else	
	cPerg		:= "TECR580A"
EndIf

Pergunte(cPerg,.F.)

#IFDEF TOP
	oReport := Rt580RDef(cPerg)
	oReport:PrintDialog()
#ELSE
	Alert(STR0014) //"Este Relatório está disponível apenas para Topconnect."
#ENDIF

Return(.T.)

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} Rt580RDef()

Escala X Efetivo Por Atendente - monta as Section's para impressão do relatorio

@sample 	Rt580RDef(cPerg)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@param 		cPerg, Pergunte 
@return 	oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt580RDef(cPerg)

Local oReport						//Objeto relatorio TReport (Release 4)
Local oSection1 					//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1) 
Local oSection2  					//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB") 
Local oSection3  					//Objeto secao 3 do relatorio (detalhes, campos das tabelas "SA1")
Local cTMANREAL	:=	""			//
Local cAlias1		:= "QRYRP580"	//Alias da consulta Embedded SQL

#IFDEF TOP
	cAlias1 := GetNextAlias()	// Pega o proximo Alias Disponivel
#ENDIF

DEFINE REPORT oReport NAME "TECR580" TITLE STR0001 PARAMETER cPerg;		//"Escala X Efetivo Por Atendente"
ACTION {|oReport| Rt580Print( oReport, cPerg, cAlias1 )} DESCRIPTION STR0001		//"Escala X Efetivo Por Atendente"

//Section 1 - AA1 - Tecnico
DEFINE SECTION oSection1 OF oReport TITLE FwX2Nome("AA1") TABLES "AA1"

DEFINE CELL NAME "AA1_CODTEC" 	OF oSection1 ALIAS "AA1"
DEFINE CELL NAME "AA1_NOMTEC" 	OF oSection1 ALIAS "AA1"
DEFINE CELL NAME "AA1_CDFUNC" 	OF oSection1 ALIAS "AA1"
DEFINE CELL NAME "AA1_FUNFIL" 	OF oSection1 ALIAS "AA1"
DEFINE CELL NAME "AA1_CC"	  	OF oSection1 BLOCK {|| (cAlias1)->AA1_CC}

//Secao 2 - ABB - Agendamentos
DEFINE SECTION oSection2 OF oSection1 TITLE FwX2Nome("ABB") TABLES "ABB" LEFT MARGIN 5

DEFINE CELL NAME "ABB_NUMOS"	OF oSection2 BLOCK {|| (cAlias1)->ABB_NUMOS} 
DEFINE CELL NAME "ABQ_CONTRT" 	OF oSection2 BLOCK {|| Trim((cAlias1)->ABQ_CONTRT)}
DEFINE CELL NAME STR0004 	 	OF oSection2 BLOCK {|| Trim((cAlias1)->A1_COD)}		//"Cód. do Cliente"
DEFINE CELL NAME STR0005  	 	OF oSection2 BLOCK {|| Trim((cAlias1)->A1_NOME)}	//"Nome do Cliente"
DEFINE CELL NAME "ABB_DTINI"	OF oSection2 ALIAS "ABB" 
DEFINE CELL NAME "ABB_HRINI"	OF oSection2 ALIAS "ABB" 
DEFINE CELL NAME "ABB_DTFIM"	OF oSection2 ALIAS "ABB" 
DEFINE CELL NAME "ABB_HRFIM"	OF oSection2 ALIAS "ABB" 
DEFINE CELL NAME "ABB_HRTOT"	OF oSection2 BLOCK {|| U_AT580TReal(cAlias1)}	
DEFINE CELL NAME STR0007      	OF oSection2 Size(8) BLOCK {|| SUBSTR((cAlias1)->ABB_HRTOT,6,10) }		//"Hrs. Planejadas"
DEFINE CELL NAME "ABB_ATENDE"	OF oSection2 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATENDE)== "1", STR0002,STR0003)}		//"Sim"; "Não"
DEFINE CELL NAME "ABB_ATIVO"	OF oSection2 BLOCK {|| IIf (Trim((cAlias1)->ABB_ATIVO)== "1", STR0002,STR0003)}		//"Sim"; "Não"
DEFINE CELL NAME "ABB_MANUT"	OF oSection2 BLOCK {|| IIf (Trim((cAlias1)->ABB_MANUT)== "1", STR0002,STR0003)}		//"Sim"; "Não"

//Secao 3 - ABR - Manutenção da Agenda
DEFINE SECTION oSection3 OF oSection2 TITLE FwX2Nome("ABR") TABLES "ABR" LEFT MARGIN 8

DEFINE CELL NAME "ABR_MOTIVO"	OF oSection3 BLOCK {|| Trim((cAlias1)->ABR_MOTIVO)}
DEFINE CELL NAME STR0013			OF oSection3 BLOCK {|| Posicione("ABN",1, xFilial("ABN")+PadR(Trim((cAlias1)->ABR_MOTIVO),;			//"Desc. do Motivo"
																	TamSx3("ABN_CODIGO")[1]),"ABN->ABN_DESC")} 
DEFINE CELL NAME "ABR_DTMAN"	OF oSection3 ALIAS "ABR"
DEFINE CELL NAME "ABR_DTINIA"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_HRINIA"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_DTFIMA"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_HRFIMA"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME STR0019 		OF oSection3 SIZE(18) BLOCK{||U_AT580TManC(cAlias1)}
DEFINE CELL NAME "ABR_DTINI"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_HRINI"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_DTFIM"	OF oSection3 ALIAS "ABR" 
DEFINE CELL NAME "ABR_HRFIM"	OF oSection3 ALIAS "ABR" 


oSection3:cell("ABR_DTINI"):Disable()
oSection3:cell("ABR_HRINI"):Disable()
oSection3:cell("ABR_DTFIM"):Disable()
oSection3:cell("ABR_HRFIM"):Disable()

oSection3:cell("ABR_DTINIA"):Disable()
oSection3:cell("ABR_HRINIA"):Disable()
oSection3:cell("ABR_DTFIMA"):Disable()
oSection3:cell("ABR_HRFIMA"):Disable()


oSection1:SetTotalInLine(.T.)
oSection2:SetTotalInLine(.F.)
oSection3:SetTotalInLine(.F.)
oReport:SetTotalInLine(.T.)    

DEFINE FUNCTION NAME "TOTREAL" FROM oSection2:Cell("ABB_HRTOT");
OF oSection1 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0009 NO END REPORT //"Total de Atendimentos Realizados"

DEFINE FUNCTION NAME "TOTPLAN" FROM oSection2:Cell(STR0007);
OF oSection1 FUNCTION TIMESUM PICTURE "@ 999999999:99" TITLE STR0010 NO END REPORT //"Total de Atendimentos Planejado"

DEFINE FUNCTION NAME "TMANREAL" FROM oSection3:Cell(STR0019) OF oSection1 PRINT WHEN {||.F.} FUNCTION ONPRINT;
FORMULA {|| IntToHora(HoraToInt(oSection1:GetFunction("TOTPLAN"):SectionValue(),At(":",oSection1:GetFunction("TOTPLAN"):SectionValue())-1)-HoraToInt(oSection1:GetFunction("TOTREAL"):SectionValue(),At(":",oSection1:GetFunction("TOTREAL"):SectionValue())-1))};
 PICTURE "@ 999999999:99" TITLE STR0011 NO END REPORT	//"Total de Atendimentos Planejados X Realizados"

DEFINE FUNCTION NAME "TPLANE" FROM oSection3:Cell(STR0019) OF oSection1 FUNCTION ONPRINT;
FORMULA {||IIf(oSection1:GetFunction("TMANREAL"):SectionValue() == NIL,"00:00",oSection1:GetFunction("TMANREAL"):SectionValue())};
			TITLE STR0012 NO END REPORT 		//"Total de Atendimentos Realizados X Planejados"

Return oReport

//--------------------------------------------------------------------------------------------------------------------
/*/{Protheus.doc} U_AT580TReal()

Escala X Efetivo Por Atendente - Cálcula o planejamento realizado 

@sample 	U_AT580TReal(cAlias1)
@param		cAlias1, Alias tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function AT580TReal(cAlias1)

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
/*/{Protheus.doc} U_At580TManC()

Escala X Efetivo Por Atendente - Cálcula o tempo de manutenção 

@sample 	U_At580TManC(cAlias1)
@param		cAlias1, Alias da tabela temporaria 
@return 	cRet
/*/
//--------------------------------------------------------------------------------------------------------------------

User Function At580TManC(cAlias1)
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
/*/{Protheus.doc} Rt580Print()

Escala X Efetivo Por Atendente - monta a Query e imprime o relatorio de acordo com os parametros

@sample 	Rt580Print(oReport, cPerg, cAlias1)
@author	Rodrigo A. Pirolo
@since		17/05/2013
@version	P12
@param		oReport
			cPerg
			cAlias1 
@return oReport
/*/
//--------------------------------------------------------------------------------------------------------------------

Static Function Rt580Print(oReport, cPerg, cAlias1)

Local oSection1	:= oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos da tabela AA1)
Local oSection2	:= oSection1:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABB")
Local oSection3	:= oSection2:Section(1) 	//Objeto secao 2 do relatorio (detalhes, campos das tabelas "ABR","ABN")
Local cSinalCon	:= If(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") //Sinal de concatenação (Igual ao ADMXFUN)
Local cExpCon	:= ""
Local cIdcfal	:= Space(TamSX3("ABB_IDCFAL")[1])	// ID Configuracao Alocacao
Local cFiliABR	:= xFilial('ABR')
Local cFiliABQ	:= xFilial('ABQ')
Local cFiliAA1	:= xFilial('AA1')
Local cFiliABB	:= xFilial('ABB')
Local cFiliSA1	:= xFilial('SA1')
Local cMvpar3	:= mv_Par03
Local cMvpar4	:= mv_Par04
Local cMvpar5	:= mv_Par05
Local cMvpar6	:= mv_Par06
Local cMvpar7	:= mv_Par07
Local cMvpar8	:= mv_Par08
Local cCodCli	:= ""
Local cContra	:= ""
Local cTab	:= ""

DEFAULT cAlias1		:= GetNextAlias()

If ABQ->(FieldPos("ABQ_ORIGEM")) > 0
	cExpCon	:= "%ABQ.ABQ_CONTRT"+cSinalCon+"ABQ.ABQ_ITEM"+cSinalCon+"ABQ.ABQ_ORIGEM%"
Else
	cExpCon	:= "%ABQ.ABQ_CONTRT"+cSinalCon+"ABQ.ABQ_ITEM%"
EndIf

If cPerg == "TECR580"
	cCodCli		:= "%AAH_CODCLI%"
	cContra		:= "%AAH_CONTRT%"
	cLoja			:= "%AAH_LOJA%"
	cCondicao		:= "%%"
	cTab			:= RetSqlName("AAH")
	cTab			:= "%"+cTab+"%"
	cCond1			:= "% ABQ.ABQ_ORIGEM <> 'CN9' AND %"
	cLfJCNC		:= "%%"
Else
	cCodCli		:= "%CNC_CLIENT%"
	cContra		:= "%CN9_NUMERO%"
	cLoja			:= "%CNC_LOJACL%"
	cCondicao      := "%CONTR.CN9_SITUAC = '05' AND%"
	cTab			:= RetSqlName("CN9")
	cTab			:= "%"+cTab+"%"
	cCond1			:= "% ABQ.ABQ_ORIGEM = 'CN9' AND %"
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

Select 	AA1_FILIAL,				/* Atendentes */
		AA1_CODTEC,
		AA1_NOMTEC,
		AA1_CDFUNC,
		AA1_FUNFIL,
		AA1_CC,
		AA1_REGIAO,
			ABB_FILIAL,				/* Agendamentos */
			ABB_CODTEC,
			ABB_NUMOS,
			ABB_ENTIDA,
			ABB_ATIVO,
			ABB_CHAVE,
			ABB_DTINI,
			ABB_HRINI,
			ABB_DTFIM,
			ABB_HRFIM,
			ABB_ATENDE,
			ABB_MANUT,
			ABB_IDCFAL,
			ABB_CODIGO,
			ABB_HRTOT,
				ABR_FILIAL,			/* Manutenções da Agenda */
				ABR_MOTIVO,
				ABR_DTMAN,
				ABR_DTINI,
				ABR_HRINI,
				ABR_CODSUB,
				ABR_DTFIM,
				ABR_HRFIM,
				ABR_MOTIVO,
				ABR_USASER,
				ABR_TEMPO,
				ABR_AGENDA,
				ABR_MANUT,
				ABR_DTINIA,
				ABR_HRINIA,
				ABR_DTFIMA,
				ABR_HRFIMA,
				ABR.R_E_C_N_O_,
					ABQ_FILIAL,
					ABQ_CONTRT,
					ABQ_PRODUT,
					ABQ_TPPROD,
						A1_COD,
						A1_LOJA,
						A1_NOME,
							%exp:cCodCli% CLI,
							%exp:cContra% CONTRT

From	%exp:cTab% CONTR

LEFT JOIN
 %table:ABQ% ABQ ON (ABQ.ABQ_FILIAL = %exp:cFiliABQ% AND ABQ.ABQ_CONTRT = %exp:cContra% AND %exp:cCond1% ABQ.%notDel%)

LEFT JOIN
 %table:ABB% ABB ON (ABB.ABB_FILIAL = %exp:cFiliABB% AND ABB.ABB_IDCFAL = %exp:cExpCon% AND ABB.%notDel%)

LEFT JOIN
 %table:ABR% ABR ON (ABR.ABR_FILIAL = %exp:cFiliABR% AND ABR.ABR_AGENDA = ABB.ABB_CODIGO AND ABR.%notDel%)

%exp:cLfJCNC%

LEFT JOIN
 %table:SA1% SA1 ON (SA1.A1_FILIAL = %exp:cFiliSA1% AND SA1.A1_COD = %exp:cCodCli% AND SA1.A1_LOJA = %exp:cLoja% AND SA1.%notDel%)

LEFT JOIN
 %table:AA1% AA1 ON (AA1.AA1_FILIAL = %exp:cFiliAA1% AND AA1.AA1_CODTEC = ABB.ABB_CODTEC AND AA1.%notDel%)

Where	AA1_CODTEC BETWEEN %exp:AllTrim(mv_Par01)% AND %exp:AllTrim(mv_Par02)% AND
		ABB_DTINI BETWEEN %exp:cMvpar3% AND %exp:cMvpar4% AND
		A1_COD BETWEEN %exp:cMvpar5% AND %exp:cMvpar6% AND
		%exp:cContra% BETWEEN %exp:cMvpar7% AND %exp:cMvpar8% AND
		ABQ_CONTRT = %exp:cContra% AND
		%exp:cCondicao%
		ABB_IDCFAL != %exp:cIdcfal% AND
		CONTR.%notDel%

Order By AA1_CODTEC, ABB_CODIGO, ABR_AGENDA, ABR_MANUT

EndSql

END REPORT QUERY oSection1

oSection2:SetParentQuery()
oSection2:SetParentFilter({|cParam| (cAlias1)->ABB_CODTEC == cParam },{|| (cAlias1)->AA1_CODTEC })

oSection3:SetParentQuery()
oSection3:SetParentFilter({|cParam| (cAlias1)->ABR_AGENDA == cParam},{|| (cAlias1)->ABB_CODIGO })

//Quebra Linha
oSection2:SetLineBreak()

//Executa impressão
oSection1:Print()
                                                                                                                                           
Return(.T.)