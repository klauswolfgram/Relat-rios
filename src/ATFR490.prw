/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR490.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

Static aStatus	 		:= {}	//Descricao de Status possiveis para um controle de provisão

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ATFR490  ³ Autor ³Mauricio Pequim Jr.    ³ Data ³ 16/12/11 ³±±
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
User Function ATFR490()

Local oReport
Local lTReport	:= TRepInUse()
Local lDefTop	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
Local lRet		:= .T.
//Verifica implementacao da Controle de Provisao
Local lProvis	:= AFPrvAtf()


Private cPerg   := "ATFR490"
Private aSelFil	:= {}
Private cOcorSel:= {}

If !lDefTop
	Help("  ",1,"AFR490TOP",,STR0012 ,1,0)  //"Função disponível apenas para ambientes TopConnect"
	lRet := .F.
EndIf

If !lTReport
	Help("  ",1,"AFR490R4",,STR0013,1,0) //"Função disponível apenas para TReport, por favor atualizar ambiente e verificar parametro MV_TREPORT"
	lRet := .F.
ENdIf

If !lProvis
	Help("  ",1,"AFR490NPRV",,STR0018,1,0) //'Para utilizar este relatório, é necessário que esteja implementado o processo de Controle de Provisão. Por favor, atualize o ambiente'
	lRet := .F.
ENdIf

If lRet
	If Pergunte( cPerg , .T. )
		If mv_par08 == 1 .And. Len( aSelFil ) <= 0
			aSelFil := AdmGetFil()
			If Len( aSelFil ) <= 0
				Return
			EndIf
		EndIf

		//Seleciona Ocorrencias
		If mv_par12 == 1 .And. !IsBlind()
			cOcorSel := AFSelTpPrv()
			If Empty( cOcorSel )
				Help(" ",1,"AF490GETOC",,STR0027,1,0) //"Favor selecionar ao menos uma Ocorência"
				Return
			EndIf
		EndIf

		oReport:= ReportDef()
		oReport:PrintDialog()
	Endif
EndIf

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³Mauricio Pequim Jr.    ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR490                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport		:= nil
Local oFNU   		:= nil
Local oFNW			:= nil
Local cDesc			:= STR0014 //"Este relatório tem o objetivo de demonstrar os movimentos do Controle de Provisão."
Local cTitulo		:= STR0015 //"Demonstrativo Planejamento de Provisão"
Local cAliasPrv 	:= GetNextAlias()
Local lTotalPer		:= .F.
Local lTotalPrv		:= .F.
Local lTotalFil		:= .F.

Pergunte(cPerg,.F.)

lTotalPer	:= MV_PAR09 == 1
lTotalPrv	:= MV_PAR10 == 1
lTotalFil	:= MV_PAR11 == 1
lTotalRev	:= (MV_PAR03 > 1 .and. MV_PAR05 > MV_PAR04)


DEFINE REPORT oReport NAME "ATFR490" TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport,cPerg,cAliasPrv)} DESCRIPTION cDesc TOTAL IN COLUMN

oReport:ParamReadOnly()
oReport:SetUseGc(.F.)   //DESABILITA OPCAO GESTAO CORPORATIVA

DEFINE SECTION oFNU OF oReport TITLE STR0016 TABLES "FNU" //"Controle de Provisão"
	DEFINE CELL NAME "FNU_FILIAL" OF oFNU ALIAS "FNU"
	DEFINE CELL NAME "FNU_COD"    OF oFNU ALIAS "FNU" TITLE STR0001 //"Provisao Cod.:"
	DEFINE CELL NAME "FNU_REV"    OF oFNU ALIAS "FNU"
	DEFINE CELL NAME "FNU_DTINI"  OF oFNU ALIAS "FNU"
	DEFINE CELL NAME "FNU_DESCR"  OF oFNU ALIAS "FNU"
	DEFINE CELL NAME "FNUSTATUS"  OF oFNU TITLE STR0026 SIZE 30 ALIGN LEFT AUTO SIZE HEADER ALIGN LEFT BLOCK {|| U_Afr490Stat((cAliasPrv)->FNU_STATUS) }  //"Status"

DEFINE SECTION oFNW OF oFNU TITLE STR0017 TABLES ""  //"Movimentos de Provisão"

	DEFINE CELL NAME "CPERIODO"   OF oFNW TITLE STR0002 SIZE TamSX3('FNW_PERIOD')[1]+1 PICTURE "@R 99/9999" ALIGN LEFT AUTO SIZE HEADER ALIGN LEFT BLOCK {|| U_Afr490Per((cAliasPrv)->FNW_PERIOD) }  //"Periodo"
	DEFINE CELL NAME "FNW_OCOR"   OF oFNW ALIAS "FNW"
	DEFINE CELL NAME "SLDCURTO"   OF oFNW TITLE STR0004 SIZE 18 PICTURE '@E 999,999,999,999,999.99' ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| IIF((cAliasPrv)->FNW_PRAZO == '2',(cAliasPrv)->FNW_VALOR,0) }  //"Curto Prazo"
  	DEFINE CELL NAME "SLDLONGO"   OF oFNW TITLE STR0005 SIZE 18 PICTURE '@E 999,999,999,999,999.99' ALIGN RIGHT AUTO SIZE HEADER ALIGN RIGHT BLOCK {|| IIF((cAliasPrv)->FNW_PRAZO == '1',(cAliasPrv)->FNW_VALOR,0) }  //"Longo Prazo"
	DEFINE CELL NAME "CONTABIL"   OF oFNW ALIAS "FNW" TITLE STR0003 SIZE 20 ALIGN CENTER HEADER ALIGN CENTER BLOCK {|| U_Afr490DSC( (cAliasPrv)->FNW_LA ) }

DEFINE BREAK oBreakFil OF oReport WHEN oFNU:Cell("FNU_FILIAL") TITLE STR0006 //"Total Filial"

If lTotalPer
	DEFINE BREAK oBreakPer OF oFNW WHEN oFNW:Cell("CPERIODO") TITLE STR0007 //"Total Periodo"
	DEFINE FUNCTION oTPerSlCP FROM oFNW:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakPer NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPerSlLP FROM oFNW:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakPer NO END REPORT NO END SECTION
EndIf

If lTotalPrv
	DEFINE BREAK oBreakPrv OF oFNU WHEN oFNU:Cell("FNU_COD") TITLE STR0009 //"Total Provisão"
	DEFINE FUNCTION oTPrvSlCP FROM oFNW:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakPrv NO END REPORT NO END SECTION
	DEFINE FUNCTION oTPrvSlLP FROM oFNW:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakPrv NO END REPORT NO END SECTION
	oBreakPrv:OnPrintTotal({||oReport:SkipLine(),oReport:SkipLine(),oReport:SkipLine()})
EndIf

If lTotalFil
	DEFINE FUNCTION oTFilSlCP FROM oFNW:Cell("SLDCURTO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
	DEFINE FUNCTION oTFilSlLP FROM oFNW:Cell("SLDLONGO")  FUNCTION SUM BREAK oBreakFil NO END SECTION
EndIf

oFNU:SetHeaderPage(.T.)
oFNW:SetHeaderPage(.T.)
oFNU:SetAutoSize()
oFNW:SetAutoSize()

Return oReport


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³Mauricio Pequim Jr.   ³ Data ³ 16/12/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Definicao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR490                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport(oReport,cPerg,cAliasPrv)

Local oFNU := oReport:Section(1)
Local oFNW := oReport:Section(1):Section(1)
Local cProvDe  := ""
Local cProvAte := ""
Local lRevAtv  := .F.
Local cRevDe   := ""
Local cRevAte  := ""
Local cCondRev := ""
Local cCondFil := ""
Local cCondOcor:= ""
Local cTmpFil

Pergunte( cPerg , .F. )

cProvDe  := MV_PAR01
cProvAte := MV_PAR02
lRevAtv  := MV_PAR03 == 1
cRevDe   := MV_PAR04
cRevAte  := MV_PAR05
cDataDe	 := DTOS(MV_PAR06)
cDataAte := DTOS(MV_PAR07)
nContab	 := MV_PAR13		//1=Todos 2=Contabilizados 3=Nao Contabilizados

//Provisao ativa ou selecionada
If lRevAtv
	//Condicao de revisao ativa
	cCondRev := " (FNU_STATUS <> '3') AND (FNU_MSBLQL = '2') "
Else
	//Condicao de revisao especifica
	cCondRev := " FNU_REV BETWEEN '" + cRevDe + "' AND '" + cRevAte + "' "
EndIf

//Controle de contabilizacao
If nContab == 1 //Todos
	cCondCtb := " "
ElseIf nContab == 2	//Contabilizados
	cCondCtb := " AND FNW_LA <> ' ' "
Else					//Nao Contabilizados
	cCondCtb := " AND FNW_LA = ' ' "
Endif

//Somo a condicao de contabilizacao na condicao de revisao
//para que nao necessite disponibilizar uma condicao para nContab = 1 (Todos)
cCondRev += cCondCTB

//Condicao de Filial
cCondFil  := "FNW_FILIAL " + GetRngFil( aSelfil , "FNW", .T., @cTmpFil ) + " "
cCondData := "FNW_DTMOV BETWEEN '" + cDataDe + "' AND '" + cDataAte + "' "
If !Empty(cOcorSel)
	cCondOcor := "AND FNW_OCOR IN " + FormatIn(cOcorSel,"/") + " "
EndIf

cCondRev  := "%" + cCondRev  + "%"
cCondData := "%" + cCondData + "%"
cCondFil  := "%" + cCondFil  + "%"
cCondOcor := "%" + cCondOcor + "%"


BEGIN REPORT QUERY oFNU

BeginSql alias cAliasPrv

	SELECT FNU_FILIAL  ,
            FNU_COD     ,
    	       FNU_REV     ,
    	       FNU_DTINI   ,
           FNU_DESCR   ,
           FNU_STATUS  ,
           FNU_MSBLQL  ,
           FNW_FILIAL  ,
	       FNW_COD     ,
	       FNW_REV     ,
	       FNW_PERIOD  ,
	       FNW_OCOR    ,
	       FNW_VALOR   ,
	       FNW_PRAZO   ,
	       FNW_LA      ,
           FNW_DTMOV

	FROM %table:FNU% FNU INNER JOIN %table:FNW% FNW  ON
	    FNU.FNU_FILIAL = FNW.FNW_FILIAL AND
	    FNU.FNU_COD = FNW.FNW_COD AND
	    FNU.FNU_REV = FNW.FNW_REV

	WHERE
	       FNW.FNW_COD >= %exp:cProvDe% AND
	       FNW.FNW_COD <= %exp:cProvAte% AND
	       %exp:cCondFil% AND
	       %exp:cCondRev% AND
	       %exp:cCondData% AND
	       FNU.%notDel% AND
	       FNW.%notDel%
	       %exp:cCondOcor%

	ORDER BY FNW_FILIAL,FNW_COD,FNW_REV,FNW_DTMOV,FNW_OCOR

EndSql

END REPORT QUERY oFNU

oFNW:SetParentQuery()
oFNW:SetParentFilter({|cParam| (cAliasPrv)->(FNW_FILIAL+FNW_COD+FNW_REV) == cParam},{|| (cAliasPrv)->(FNU_FILIAL+FNU_COD+FNU_REV) })
CtbTmpErase(cTmpFil)
oFNU:Print()

Return


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Afr490Per  ³ Autor ³Mauricio Pequim Jr.  ³ Data ³ 09/11/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Transforma o periodo de AnoMes em MesAno                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Afr490Per(cPeriod)

Local cMesAno := ""

//cPeriod = AnoMes (AAAAMM)
//Transformo em MesAno(MMAAAA)
cMesAno := Substr(cPeriod,5,2)+Substr(cPeriod,1,4)

Return cMesAno


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Afr490DSC  ³ Autor ³Mauricio Pequim Jr.  ³ Data ³ 09/11/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Retorna a descricao da ocorrencia                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ATFR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Afr490DSC( cOcor )

Local cDescOcor := ""

DEFAULT cOcor = ""

If cOcor == '1'
	cDescOcor := STR0019		//Sim
ElseIf cOcor == '2'
	cDescOcor := STR0021		//Revisado
Else
	cDescOcor := STR0020		//Nao
Endif

Return cDescOcor




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFR490STAT  ºAutor ³Mauricio Pequim Jr. º Data ³ 31/07/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Combo box dos campos de Status do controle de provisao     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AFR490STAT(cCodStatus)

Local cStatus := ""

DEFAULT cCodStatus := ""

cStatus := "0="+STR0022 +";" //"Gerado"
cStatus += "1="+STR0023 +";" //"Atualizado"
cStatus += "2="+STR0024 +";" //"Efetivado"
cStatus += "3="+STR0021 +";" //"Revisado"
cStatus += "A="+STR0025      //"Realização Pendente"

//Utilizado apenas para o retorno da descricao do Status
If !Empty(cCodStatus)

	If Len(aStatus) == 0
		aStatus := STRTOKARR(cStatus,";")
	Endif

	If (nPos := Ascan(aStatus,{|aCod| Substr(aCod,1,1) == Alltrim(cCodStatus)}) ) > 0
		cStatus := Alltrim(Substr(aStatus[nPos],3))
	Endif
Endif

Return cStatus

