/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR433.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

STATIC aValAVP		:= {}
STATIC cCBaseOld	:= ""
STATIC cItemOld		:= ""

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR433  ³ Autor ³Mauricio Pequim Jr.    ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Demonstrativo: Provisao e realizado de AVP de projeto de   ³±±
±±³          ³ imobilizado                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAATF                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ATFR433()

Local oReport
Local lTReport		:= FindFunction("TRepInUse") .And. TRepInUse()
Local lDefTop		:= IIF( FindFunction("IfDefTopCTB"), IfDefTopCTB(), .F.) // verificar se pode executar query (TOPCONN)
Local lAvpAtf		:= If(FindFunction("AFAvpAtf"),AFAvpAtf(),.f.) //Verifica de o AVP esta implantado na base

Private cPerg		:= "AFR433"
Private aSelFil		:= {}
Private aSelClass	:= {}

If !lDefTop
	Help("  ",1,"AFR433TOP",,STR0001 ,1,0) //"Função disponível apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR433R4",,STR0002,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	Return
ENdIf

If !AliasInDic("FNB") .or. !AliasInDic("FNC") .or. !AliasInDic("FND") .or.;
	!AliasInDic("FNE") .or. !AliasInDic("FNF") .or. !AliasInDic("FNP") .and.;
	!AliasInDic("FIT") .or. !FindFunction("ATFA430") .or.	!lAvpAtf

	Help("  ",1,"AFR433PJAVP",,STR0019,1,0)  //'Para utilizar este relatório, é necessário que estejam implementados os processos de Projetos de Imobilizado e Controle de AVP de Imobilizados. Por favor, atualize o ambiente'
	Return
ENdIf

lRet := Pergunte( cPerg , .T. )


If lRet
	If mv_par06 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil()
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	
	If mv_par12 == 1 .And. FindFunction("AdmGetClass")
		aSelClass := AdmGetClass()	
		If Len( aSelClass ) <= 0
			Return
		EndIf 		
	EndIf
	oReport:= ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³Mauricio Pequim Jr.    ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR433                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport		:= nil
Local oFNB			:= nil
Local oAVP			:= nil
Local cDesc			:= STR0003 //"Este relatório tem o objetivo de demonstrar comparativo Provisão x Realizado x AVP de curto e longo prazo dos ativos relacionados aos projetos do imobilizado "
Local cTitulo		:= STR0004 //"Demonstrativo Provisão x Realizado x AVP de curto e longo prazo de Projeto de Imobilizado"
Local cAliasPrj 	:= GetNextAlias()
Local lTotalPrj		:= .F.
Local lTotalFil		:= .F.
Local dDataRef		:= MV_PAR01 //DATA DE REFERENCIA  
Local nDiasCP		:= MV_PAR10 //CRITERIO DE CURTO PRAZO (DIAS)
Local lTotalEtp		:= .F.

Pergunte(cPerg,.F.)

lTotalPrj	:= MV_PAR08 == 1
lTotalFil	:= MV_PAR09 == 1
lTotalEtp	:= MV_PAR11 == 1

DEFINE REPORT oReport NAME "ATFR433" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAliasPrj)} DESCRIPTION cDesc TOTAL IN COLUMN

oReport:SetLandScape()
oReport:ParamReadOnly()
oReport:DisableOrientation()

DEFINE SECTION oFNB OF oReport TITLE STR0005 TABLES "FNB"  //"Projeto do Imobilizado"
	DEFINE CELL NAME "FNB_FILIAL" OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_CODPRJ" OF oFNB ALIAS "FNB" TITLE STR0020	//"Projeto Cod.:"
	DEFINE CELL NAME "FNB_REVIS"  OF oFNB ALIAS "FNB"
	DEFINE CELL NAME "FNB_DESC"   OF oFNB ALIAS "FNB"

DEFINE SECTION oAVP OF oFNB TITLE STR0006 TABLES "SN1","SN3" //"AVP de imobilizados do Projeto"

	DEFINE CELL NAME "N1_PROJETP" OF oAVP ALIAS "SN1" //Etapa Prj
	DEFINE CELL NAME "N1_INIAVP"  OF oAVP ALIAS "SN1" //Dt Ini AVP
	DEFINE CELL NAME "N1_DTAVP"   OF oAVP ALIAS "SN1" //Dt. Execucao
	DEFINE CELL NAME "FNF_BASE"   OF oAVP TITLE STR0007 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| U_Afr433PRV(dDataRef,nDiasCP,cAliasPrj), aValAvp[2]	} //"Provisão"
	DEFINE CELL NAME "BAIXAS"     OF oAVP TITLE STR0008 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[3]	 										} //"Baixas"
	DEFINE CELL NAME "SLDPROVIS"  OF oAVP TITLE STR0009 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[4]											} //"Saldo Provisão"
	DEFINE CELL NAME "CONSTITUI"  OF oAVP TITLE STR0010 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[5]											} //"Constituido"
	DEFINE CELL NAME "PRVCURTO"   OF oAVP TITLE STR0011 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[6]											} //"Curto Prazo (PRV)"
	DEFINE CELL NAME "PRVLONGO"   OF oAVP TITLE STR0012 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[7]											} //"Longo Prazo (PRV)"
	DEFINE CELL NAME "RLZCURTO"   OF oAVP TITLE STR0013 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[8]											} //"Curto Prazo (RLZ)"
	DEFINE CELL NAME "RLZLONGO"   OF oAVP TITLE STR0014 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[9]											} //"Longo Prazo (RLZ)"
	DEFINE CELL NAME "SLDCURTO"   OF oAVP TITLE STR0015 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[10]											} //"Curto Prazo (SLD)"
	DEFINE CELL NAME "SLDLONGO"   OF oAVP TITLE STR0016 SIZE TamSX3('N3_VORIG1')[1] PICTURE PesqPict("SN3",'N3_VORIG1', TamSX3('N3_VORIG1')[1] ) ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| aValAvp[11]											} //"Longo Prazo (SLD)"

DEFINE BREAK oBreakFil OF oReport WHEN oFNB:Cell("FNB_FILIAL") TITLE STR0017 //"Total Filial"


If lTotalEtp
	DEFINE BREAK oBreakEtp OF oAVP WHEN oAVP:Cell("N1_PROJETP") TITLE STR0022	//"Total Etapa"
	DEFINE FUNCTION oTEtpProv FROM oAVP:Cell("FNF_BASE")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpBaix FROM oAVP:Cell("BAIXAS")    FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpSPrv FROM oAVP:Cell("SLDPROVIS") FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpCons FROM oAVP:Cell("CONSTITUI") FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpPrCP FROM oAVP:Cell("PRVCURTO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpPrLP FROM oAVP:Cell("PRVLONGO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpRlCP FROM oAVP:Cell("RLZCURTO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpRlLP FROM oAVP:Cell("RLZLONGO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpSlCP FROM oAVP:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
	DEFINE FUNCTION oTEtpSlLP FROM oAVP:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakEtp NO END REPORT NO END SECTION
EndIf

If lTotalPrj
	DEFINE BREAK oBreakPrj OF oFNB WHEN oFNB:Cell("FNB_CODPRJ") TITLE STR0018  //"Total Projeto"
	DEFINE FUNCTION oTPrjProv FROM oAVP:Cell("FNF_BASE")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjBaix FROM oAVP:Cell("BAIXAS") 	FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjSPrv FROM oAVP:Cell("SLDPROVIS") FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjCons FROM oAVP:Cell("CONSTITUI") FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjPrCP FROM oAVP:Cell("PRVCURTO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjPrLP FROM oAVP:Cell("PRVLONGO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjRlCP FROM oAVP:Cell("RLZCURTO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjRlLP FROM oAVP:Cell("RLZLONGO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjSlCP FROM oAVP:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrjSlLP FROM oAVP:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakPrj NO END REPORT NO END SECTION
EndIf

If lTotalFil
	DEFINE FUNCTION oTFilProv FROM oAVP:Cell("FNF_BASE")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilBaix FROM oAVP:Cell("BAIXAS") 	FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilSPrv FROM oAVP:Cell("SLDPROVIS") FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilCons FROM oAVP:Cell("CONSTITUI") FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilPrCP FROM oAVP:Cell("PRVCURTO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilPrLP FROM oAVP:Cell("PRVLONGO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilRlCP FROM oAVP:Cell("RLZCURTO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilRlLP FROM oAVP:Cell("RLZLONGO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilSlCP FROM oAVP:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilSlLP FROM oAVP:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakFil NO END SECTION

EndIf

oFNB:SetHeaderPage(.T.)
oAVP:SetHeaderPage(.T.)
oFNB:SetAutoSize()
oAVP:SetAutoSize()

Return oReport

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³Mauricio Pequim Jr.   ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR433                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport(oReport,cPerg,cAliasPrj)

Local oFNB		:= oReport:Section(1)
Local oAVP		:= oReport:Section(1):Section(1)
Local cProjDe	:= ""
Local cProjAte	:= ""
Local lRevAtv	:= .F.
Local cRevis	:= ""
Local cTipo		:= ""
Local cTpSLD	:= ""
Local cCondRev	:= ""
Local cCondFil	:= ""
Local lFilClass	:= (MV_PAR12 == 1 .And. Len(aSelClass) > 0 .And. FindFunction("FormatClass"))
Local cTmpFil

Pergunte( cPerg , .F. )

cDtRef		:= DTOS(MV_PAR01)
cProjDe		:= MV_PAR02
cProjAte	:= MV_PAR03
lRevAtv		:= MV_PAR04 == 1
cRevis		:= MV_PAR05
cTipo		:= '14'
cTpSLD		:= MV_PAR07

If lRevAtv
	//Condicao de revisao ativa
	cCondRev := " ((FNB_STATUS = '1') OR (FNB_STATUS = '2' AND FNB_DTENCR > '"+DTOS(MV_PAR01)+"')) "
Else 
	//Condicao de revisao especifica
	cCondRev := " FNB_REVIS = '"+cRevis+"' "
EndIf 

//Filtra Classificações patrimoniais
If lFilClass 
	cCondRev += "AND  N1_PATRIM IN " + FormatClass(aSelClass, .T.)
EndIf

//Condicao de Filial
cCondFil := "FNB_FILIAL " + GetRngFil( aSelfil , "FNB", .T., @cTmpFil )

cCondRev := "%" + cCondRev + "%" 
cCondFil := "%" + cCondFil + "%" 

BEGIN REPORT QUERY oFNB

BeginSql alias cAliasPrj

	SELECT FNB_FILIAL	,
			FNB_CODPRJ	,
			FNB_REVIS	,
			FNB_DESC	,
			FNB_DTENCR	,
			N1_FILIAL	,
			N1_PROJETO	,
			N1_PROJREV	,
			N1_PROJETP	,
			N1_PROJITE	,
			N1_CBASE	,
			N1_ITEM		,
			N1_DTAVP	,
			N1_INIAVP	,
			N1_AQUISIC	,
			N1_PATRIM	,
			N3_FILIAL	,
			N3_CBASE	,
			N3_ITEM		,
			N3_TIPO		,
			N3_TPSALDO	,
			N3_SEQ		,
			N3_SEQREAV

	FROM %table:FNB% FNB INNER JOIN %table:SN1% SN1  ON
		FNB.FNB_FILIAL = SN1.N1_FILIAL AND
		FNB.FNB_CODPRJ = SN1.N1_PROJETO AND
		FNB.FNB_REVIS  = SN1.N1_PROJREV

		INNER JOIN %table:SN3% SN3  ON
			SN1.N1_FILIAL = SN3.N3_FILIAL AND
			SN1.N1_CBASE  = SN3.N3_CBASE AND
			SN1.N1_ITEM   = SN3.N3_ITEM

	WHERE
			%exp:cCondFil% 						AND
			FNB.%notDel%						AND
			SN1.%notDel%						AND
			SN3.%notDel%						AND
			SN1.N1_PROJETO	>= %exp:cProjDe%	AND
			SN1.N1_PROJETO	<= %exp:cProjAte%	AND
			SN1.N1_PROJETO	<> ' '				AND
			SN1.N1_DTAVP	<> ' '				AND
			SN1.N1_AQUISIC	<= %exp:cDtRef%		AND
			SN1.N1_INIAVP	<= %exp:cDtRef%		AND
			SN3.N3_TIPO		= %exp:cTipo%		AND
			SN3.N3_TPSALDO	= %exp:cTpSLD%		AND
			%exp:cCondRev%

	ORDER BY FNB_FILIAL,N1_PROJETO,N1_PROJREV,N1_PROJETP,N1_PROJITE

EndSql

END REPORT QUERY oFNB 

oAVP:SetParentQuery()
oAVP:SetParentFilter({|cParam| (cAliasPrj)->(N1_FILIAL+N1_PROJETO+N1_PROJREV) == cParam},{|| (cAliasPrj)->(FNB_FILIAL+FNB_CODPRJ+FNB_REVIS) })
CtbTmpErase(cTmpFil)
oFNB:Print()

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Afr433PRV ³ Autor ³Mauricio Pequim Jr.   ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Rotina chamada na celula do relatorio para obter o valor   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR433                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nItem     = Item a ser processado                          ³±±
±±³          ³ dDataRef  = Codigo do Projeto                              ³±±
±±³          ³ nCurtoPrz = Criterio de Curto Prazo (em dias)              ³±±
±±³          ³ cAliasPrj = Alias da Query                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Afr433PRV(dDataRef,nCurtoPrz,cAliasPrj)
Local aArea		:= GetArea()
Local cCbase	:= (cAliasPrj)->N1_CBASE
Local cItem		:= (cAliasPrj)->N1_ITEM

//Se for outro bem ou o primeiro
If cCBaseOld+cItemOld != cCBase+cItem
	aValAVP		:= Array(11)
	cCBaseOld	:= cCBase
	cItemOld	:= cItem
Endif
  
//Estrutura de aValAVP
//[01] - Base (tipo 10 + Tipo 14)
//[02] - Baixas do bem (tipo 10 + Tipo 14)
//[03] - Saldo do bem (tipo 10 + Tipo 14)
//[04] - AVP Constituido
//[05] - AVP Curto Prazo PRV
//[06] - AVP Longo Prazo PRV
//[07] - AVP Curto Prazo RLZ
//[08] - AVP Longo Prazo RLZ
//[09] - AVP Curto Prazo SLD
//[10] - AVP Longo Prazo SLD
//[11] - Data da constituicao valida

//Calcula os valores de AVP para o tipo de saldo selecionado
AFAvpCLP(aValAvp,dDataRef,nCurtoPrz,cAliasPrj,;
			(cAliasPrj)->N3_FILIAL,;
			(cAliasPrj)->N3_CBASE,;
			(cAliasPrj)->N3_ITEM,;
			(cAliasPrj)->N3_TPSALDO,;
			(cAliasPrj)->N3_SEQ,;
			(cAliasPrj)->N3_SEQREAV,;
			(cAliasPrj)->N1_DTAVP )

RestArea(aArea)

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AFAvpCLP  ³ Autor ³Mauricio Pequim Jr.   ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calculo do AVP de curto e longo prazo                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR433                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ aValAvp   = Array contendo os valores para o relatorio     ³±±
±±³          ³ dDataRef  = data de referencia do relatorio                ³±±
±±³          ³ nCurtoPrz = Criterio de Curto Prazo (em dias)              ³±±
±±³          ³ cAliasPrj = Alias da Query                                 ³±±
±±³          ³ cFilBem   = Filial do bem (SN1)                            ³±±
±±³          ³ cCbase    = Codigo base do imobilizado (SN1)               ³±±
±±³          ³ cItem     = Item do imobilizado (SN1)                      ³±±
±±³          ³ cTpSaldo  = Tipo de saldo do Tipo 14 (SN3)                 ³±±
±±³          ³ cSeq      = Sequencia do tipo 14 (SN3)                     ³±±
±±³          ³ cSeqReav  = Sequencia de reavaliacao do imobilizado (SN3)  ³±±
±±³          ³ dDtAvp    = Data de previsao de realizacao do bem (SN1)    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function  AFAvpCLP(aValAvp,dDataRef,nCurtoPrz,cAliasPrj,cFilBem,cCBase,cItem,cTpSaldo,cSeq,cSeqReav,dDtAvp)

Local aArea			:= GetArea()
Local cChaveBem		:= "" 
Local dDataCP		:= dDtAvp - nCurtoPrz
Local nVlBaixas		:= 0
Local nAvpCp		:= 0
Local nAvpLp		:= 0
Local lFirstConst	:= .T.
Local nDifAvpLP		:= 0
Local nValorMov		:= 0
Local cFilProj		:= (cAliasPrj)->FNB_FILIAL
Local cPrjImo		:= (cAliasPrj)->FNB_CODPRJ
Local cRevProj		:= (cAliasPrj)->FNB_REVIS
Local cTpSld		:= (cAliasPrj)->N3_TPSALDO
Local cEtapa		:= (cAliasPrj)->N1_PROJETP
Local cEtpItem		:= (cAliasPrj)->N1_PROJITE

Afill(aValAvp,0)

/*
 * Saldo acumulado de bens de execução do projeto imobilizado vinculados e atualizado junto ao projeto
 */
nVlBaixas := U_AFVlrExe(cFilProj,cPrjImo,cRevProj,cEtapa,cEtpItem,cTpSld)


//Baixas do tipo 14
aSaldoSN4 := SaldoSN4( cFilBem,cCBase,cItem,'14',cSeq,cSeqReav,/*aMoedas*/,dDataRef,.T.,/*dDataIni*/,cTpSaldo)
If Len(aSaldoSN4) > 0
	nVlBaixas += aSaldoSN4[1,2,8]
EndIf

//posiciono FNF na primeira constituicao
dbSelectArea("FNF")
FNF->(dbSetOrder(1)) //FNF_FILIAL + FNF_CBASE + FNF_ITEM + FNF_TIPO + FNF_SEQ + FNF_TPSALD + FNF_REVIS + FNF_SEQAVP + FNF_MOEDA + DTOS(FNF_DTAVP)
cChaveBem := xFilial("FNF",cFilBem)+cCBase+cItem+"14"+cSeq+cTpSaldo

If MsSeek(cChaveBem)
	While !Eof() .and. cChaveBem == FNF->(FNF_FILIAL+FNF_CBASE+FNF_ITEM+FNF_TIPO+FNF_SEQ+FNF_TPSALD)

		//Se o movimento for posterior a data de referencia
		//desconsidero este movimento
		If FNF->FNF_DTAVP > dDataRef
			FNF->(DBSKIP())
			Loop
		Endif

		//Constituição - apenas a primeira
		If FNF->FNF_TPMOV == '1' .and. lFirstConst
			//Calcula o AVP de Longo e Curto Prazo
			U_AFCalcCLP(dDtAvp,dDataCP,FNF->FNF_BASE,FNF->FNF_VALOR,FNF->FNF_INDAVP,FNF->FNF_PERIND,FNF->FNF_TAXA,@nAvpCP,@nAvpLP)

			//Flag de sinalizacao de calculo
			lFirstConst := .F.

			//Data inicio AVP
			aValAvp[1] := FNF->FNF_DTAVP

			//Provisao
			aValAvp[2] := FNF->FNF_BASE

			//Baixas
			aValAvp[3] := nVlBaixas

			//Saldo Provisao
			aValAvp[4] := FNF->FNF_BASE - nVlBaixas

			//Constituicao
			aValAvp[5] := FNF->FNF_VALOR

			//AVP Curto Prazo PRV
			aValAvp[6] := nAvpCp

			//AVP Longo Prazo PRV
			aValAvp[7] := nAvpLp

		Endif


		//Registros de realizacao de AVP
		//2 - Apuracao de AVP
		//3 - Apropriação por baixa
		//4 - Baixa
		//9 - Ajuste de AVP por revisão (+)
		//A - Ajuste de AVP por revisão (-)
		If FNF->FNF_TPMOV $ '2/3/4/9/A'

			nValorMov := (FNF->FNF_VALOR * IIF(FNF->FNF_TPMOV == 'A', -1, 1))
			 
			If FNF->FNF_DTAVP >= dDataCP
				//Valor de diferenca a apurar do AVP de Longo Prazo
				//Sabemos que o AVP de curto prazo soh eh processado apos os registros
				//de realizacoes de Longo Prazo
				//Verifico a diferenca a realizar do AVP Longo Prazo
				//Transfiro esse valor para a coluna de Longo Prazo (RLZ)
				nDifAvpLP := 0

				//Verifico se o AVP de longo prazo NAO foi totalmente realizado
				If nAvpLp - aValAvp[9] > 0
					//Verifico a diferenca a realizar do AVP Longo Prazo
					//Transfiro esse valor para a coluna de Longo Prazo (RLZ)
					nDifAvpLP := nAvpLp - aValAvp[9]
					aValAvp[9] += nDifAvpLP
				Endif

				//AVP Curto Prazo RLZ
				aValAvp[8] += nValorMov - nDifAvpLp
			Else
				//AVP Longo Prazo RLZ
				aValAvp[9] += nValorMov
			Endif
		Endif
		//Se processo de Realizacao (baixa ou calculo) ocorreu no periodo do relatorio
		//Realizado de Curto e Longo sao igualados ao valor curto e longo prazo previstos
		//Bens de projeto nao sofrem baixas parciais.
		IF FNF->FNF_TPMOV $ '5/6' .and. FNF->FNF_DTAVP <= dDataRef
			//AVP Curto Prazo RLZ
			aValAvp[8] := nAvpCP
			//AVP Longo Prazo RLZ
			aValAvp[9] := nAvpLp
		Endif	

		FNF->(DBSKIP())

	Enddo
Endif

//Se houve valor de AVP
If aValAvp[5] > 0

	//Em caso de AVP de curto prazo negatico, zero o valor
	If aValAvp[8] < 0
		aValAvp[9] += aValAvp[8]
		aValAvp[8] := 0
	Endif

	//AVP Curto Prazo SLD
	aValAvp[10] := aValAvp[6] - aValAvp[8]

	//AVP Longo Prazo SLD
	aValAvp[11] := aValAvp[7] - aValAvp[9]

Endif

RestArea(aArea)

Return aValAvp

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AFAvpCLP  ³ Autor ³Mauricio Pequim Jr.   ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calculo do AVP de curto e longo prazo Previsto             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR433                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ dDtAvp    = Data de previsao de realizacao do bem (SN1)    ³±±
±±³          ³ dDataCP   = Data de inicio do periodo de Curto Prazo       ³±±
±±³          ³ nVlBase   = Valor base do bem (tipo 10 + 14)               ³±±
±±³          ³ nVlConst  = Valor da constituicao inicial (FNF)            ³±±
±±³          ³ cIndAvp   = Codigo do indice de AVP do imobilizado (SN1)   ³±±
±±³          ³ cPerind   = Periodicidade do Indice (FIT)                  ³±±
±±³          ³ nTaxa     = Taxa do indice utilizado para AVP (SN1)        ³±±
±±³          ³ nAvpCP    = AVP Previsto de Curto Prazo (referencia)       ³±±
±±³          ³ nAvpLP    = AVP Previsto de Longo Prazo (referencia)       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AFCalcCLP(dDtAvp,dDataCP,nVlBase,nVlConst,cIndAvp,cPerind,nTaxa,nAvpCP,nAvpLP)

Local nValVp		:= 0
Local nValAvp		:= 0

DEFAULT dDtAvp		:= dDataBase
DEFAULT dDataCP		:= dDataBase
DEFAULT nVlBase		:= 0
DEFAULT nVlConst	:= 0
DEFAULT cIndAVP		:= ""
DEFAULT cPerind		:= ""
DEFAULT nTaxa		:= 0
DEFAULT nAvpCP		:= 0
DEFAULT nAvpLp		:= 0

//Calculo do Valor Presente para Curto prazo
AFCalcAVP("C",nTaxa,cIndAvp,nVlBase,cPerind,dDataCP,@nValVP,@nValAVP,dDtAvp)

//Avp de Curto Prazo
nAvpCP := nValAVP

//Avp de Longo Prazo
nAvpLP := nVlConst - nValAVP

Return


/*/{Protheus.doc} ATFR433
Função do Demonstrativo: Provisao e realizado de AVP de projeto de imobilizado 
Implementação feita de acordo com a norma contábil CPC 20.
Esta função retorna o valor acumulado de executado no projeto imobilizado.

@param cFilProj Parâmetro que determina a filial dos bens de execução vinculados ao projeto imobilizado
@param cPrjImo Parâmetro que determina o código do projeto imobilizado dos bens de execução
@param cRevProj Parâmetro que determina o codigo da revisão do projeto imobilizado dos bens de execução
@param cEtapa Parâmetro que determina a identificação da etapa do projeto imobilizado que está sendo verificado
@param cEtpItem Parâmetro que determina a identificação do item da etapa do projeto imobilizado que está sendo verificado
@param cTpSld Parâmetro que determina o tipo de saldo dos bens de execução vinculados ao projeto imobilizado 
@return nVlrExec Valor acumulado de executado para o projeto imobilizado informado por parâmetro para a função
@author marylly.araujo
@since 02/01/2013
@version MP912
/*/
//-------------------------------------------------------------------
User Function AFVlrExe(cFilProj,cPrjImo,cRevProj,cEtapa,cEtpItem,cTpSld)
Local nVlrExec	:= 0
Local aArea		:= GetArea()
Local aAreaFNJ	:= {}
Local cExecFNJ	:= ""
Local cAlsFNJ	:= GetNextAlias()

DbSelectArea("FNJ") // Item de Etapa x Ativo de Execução
aAreaFNJ := FNJ->(GetArea())

cExecFNJ += "SELECT "
cExecFNJ += "	SUM(FNJ.FNJ_VLREXE) FNJ_VLREXE "
cExecFNJ += "FROM " + RetSqlName("FNJ") + " FNJ "
cExecFNJ += "WHERE "
cExecFNJ += "	FNJ.D_E_L_E_T_ = ' ' 					AND "
cExecFNJ += " FNJ.FNJ_FILIAL	= '" + cFilProj	+ "' 	AND "
cExecFNJ += " FNJ.FNJ_CODPRJ	= '" + cPrjImo	+ "'	AND "
cExecFNJ += " FNJ.FNJ_REVIS		= '" + cRevProj	+ "'	AND "
cExecFNJ += " FNJ.FNJ_ETAPA		= '" + cEtapa		+ "'	AND "
cExecFNJ += " FNJ.FNJ_ITEM		= '" + cEtpItem	+ "'	AND "
cExecFNJ += " FNJ.FNJ_TAFPRJ    = '10' AND "  // So os ativos com tipo 10 apresentam AVP
cExecFNJ += " FNJ.FNJ_SLDEXE	= '" + cTpSld		+ "' 	"

cExecFNJ := ChangeQuery(cExecFNJ)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cExecFNJ) , cAlsFNJ , .T. , .F.)

While (cAlsFNJ)->(!Eof())
	nVlrExec += (cAlsFNJ)->FNJ_VLREXE
	(cAlsFNJ)->(DbSkip())
EndDo
(cAlsFNJ)->(DbCloseArea())

RestArea(aAreaFNJ)
RestArea(aArea)

Return nVlrExec