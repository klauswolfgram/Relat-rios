/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "ATFR411.CH"

STATIC lDtAval  := .F.
STATIC lVlrImp  := .F.
STATIC lCRecDes := .F.
STATIC lCPerRev := .F.
STATIC lTpAjust := .F.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR411   ºAutor  ³Fernando Radu Muscaluº Data ³  10/03/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Simulacao do valor recuperavel de ativos		   º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function ATFR411()

Local oReport	:= nil
Local lTReport	:= FindFunction("TRepInUse") .And. TRepInUse()
Local lContinua := .T.
Local oSx1      := FWSX1Util():New()
Local aPergRel  := {}

Private cPerg  := "AFR411"
Private aSelFil := {}
Private lTodasFil := .F.
Private cArqTmp	:= GetNextAlias()
Private oObjPerg

If !lTReport
	Help("  ",1,"AFR095R4",,STR0001,1,0)//"Função disponível apenas em TReport"
	Return
ENdIf

If Pergunte(cPerg,.T.)

	oSx1:AddGroup(cPerg)
	oSx1:SearchGroup()
	aPergRel := oSx1:GetGroup(cPerg)
    oObjPerg:=aPergRel[2][8]
	
	If lContinua .and. mv_par07 == 1 							//Seleciona Filiais
		aSelFil	:=	AdmGetFil(@lTodasFil)
		lContinua	:= Len(aSelFil) > 0
	Else
		aSelFil := {cFilAnt}
	EndIf
	
	If lContinua
		lContinua:= U_VldMoeda(MV_PAR09)
	Endif
	
	If lContinua
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	If Select(cArqTmp) > 0
		(cArqTmp)->(DbCloseArea())
	Endif
	
EndIf



Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Fernando Radu Muscaluº Data ³  10/03/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria objeto a partir da classe TReport()					   º±±
±±º          ³                                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³oRetRpt	- objeto TReport                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oRetRpt		:= nil
Local oSecCab		:= nil
Local oSecIt		:= nil
Local oSecPar		:= nil

Local cFilial		:= ""
Local cProc			:= ""
Local cItem			:= ""
Local cBem			:= ""
Local cItBem		:= ""
Local cTmpFil  
Local cVar   		:= Substr(MV_PAR09,2,1) 

Pergunte(cPerg,.f.)

lDtAval  := SNJ->(FieldPos("NJ_DTAVALI")) > 0
lVlrImp  := SNJ->(FieldPos("NJ_VLRIMPT")) > 0
lCRecDes := SNJ->(FieldPos("NJ_CRECDES")) > 0
lCPerRev := SNJ->(FieldPos("NJ_CPERREV")) > 0
lTpAjust := SNJ->(FieldPos("NJ_TPAJUST")) > 0

oRetRpt :=	TReport():New("ATFR411",STR0002,cPerg, {|| GetQry(@cTmpFil), AF411Top(oRetRpt), CtbTmpErase(cTmpFil) },STR0002)//"Simulação do valor recuperável de ativos"

//****************************************************************************************************************************

//Secao do Cabecalho

// Desabilita o botão de parâmetros de customizações do relatório TReport
oRetRpt:ParamReadOnly()

// Configura o formato do relatório para 'Paisagem'
oRetRpt:SetLandScape()
oRetRpt:DisableOrientation()

oSecCab := TRSection():New(oRetRpt,STR0003)//"Cabeçalho"

oSecCab:SetLeftMargin(3)

TRCell():New(oSecCab,"NI_FILIAL")
TRCell():New(oSecCab,"NI_PROC")
TRCell():New(oSecCab,"NI_ROTINA",,,,30)
TRCell():New(oSecCab,"NI_STATUS",,,,30)
TRCell():New(oSecCab,"NI_DTEMIS")
TRCell():New(oSecCab,"NI_DTIOA")
TRCell():New(oSecCab,"NI_LA",,STR0022)  //"Contabilizado"

//Fim Secao Cabecalho

//****************************************************************************************************************************

//Secao dos Itens

oSecIt	:= TRSection():New(oSecCab,STR0004,{"SNJ","NAOUSADO"}) //"Itens"

oSecIt:SetLeftMargin(5)

TRCell():New(oSecIt,"NJ_ITEM")
TRCell():New(oSecIt,"NJ_BEM")
TRCell():New(oSecIt,"NJ_ITBEM")
TRCell():New(oSecIt,"NJ_TIPO")

If MV_PAR10 == 1
	TRCell():New(oSecIt,"NJ_VLREC01",,,PesqPict("SNJ","NJ_VLREC01"),TamSx3("NJ_VLREC01")[1])
	if SNJ->(FieldPos("NJ_TPDEPR")) > 0
		TRCell():New(oSecIt,"NJ_TPDEPR",,,PesqPict("SNJ","NJ_TPDEPR"),TamSx3("NJ_TPDEPR")[1])
	endif
	if SNJ->(FieldPos("NJ_PERDEPR")) > 0
		TRCell():New(oSecIt,"NJ_PERDEPR",,,PesqPict("SNJ","NJ_PERDEPR"),TamSx3("NJ_PERDEPR")[1]) 
	endif
	if SNJ->(FieldPos("NJ_VMXDEPR")) > 0
		TRCell():New(oSecIt,"NJ_VMXDEPR",,,PesqPict("SNJ","NJ_VMXDEPR"),TamSx3("NJ_VMXDEPR")[1])
	endif
	if SNJ->(FieldPos("NJ_VLSALV1")) > 0	
		TRCell():New(oSecIt,"NJ_VLSALV1",,,PesqPict("SNJ","NJ_VLSALV1"),TamSx3("NJ_VLSALV1")[1])
	endif
	if SNJ->(FieldPos("NJ_PRODANO")) > 0
		TRCell():New(oSecIt,"NJ_PRODANO",,,PesqPict("SNJ","NJ_PRODANO"),TamSx3("NJ_PRODANO")[1])
	endif
	if SNJ->(FieldPos("NJ_PRODMES")) > 0
		TRCell():New(oSecIt,"NJ_PRODMES",,,PesqPict("SNJ","NJ_PRODMES"),TamSx3("NJ_PRODMES")[1])
	endif
	if SNJ->(FieldPos("NJ_PRODACM")) > 0
			TRCell():New(oSecIt,"NJ_PRODACM",,,PesqPict("SNJ","NJ_PRODACM"),TamSx3("NJ_PRODACM")[1]) 
	endif
	if	SNJ->(FieldPos("NJ_CODIND")) > 0	
		TRCell():New(oSecIt,"NJ_CODIND",,,PesqPict("SNJ","NJ_CODIND"),TamSx3("NJ_CODIND")[1]) 
	endif
Else
	If lDtAval
		TRCell():New(oSecIt,"NJ_DTAVALI") 	
	EndIf
	If MV_PAR09 == "01"
		If lVlrImp
			TRCell():New(oSecIt,"NJ_VLRIMPT",,,PesqPict("SNJ","NJ_VLRIMPT"),TamSx3("NJ_VLRIMPT")[1]) 	
			oSecIt:Cell("NJ_VLRIMPT"):SetHeaderAlign("RIGHT")	  
		EndIf
		TRCell():New(oSecIt,"NJ_VLORI01",,,PesqPict("SNJ","NJ_VLORI01"),TamSx3("NJ_VLORI01")[1]) 	
		oSecIt:Cell("NJ_VLORI01"):SetHeaderAlign("RIGHT")
		TRCell():New(oSecIt,"NJ_VLACM01",,,PesqPict("SNJ","NJ_VLACM01"),TamSx3("NJ_VLACM01")[1]) 
		oSecIt:Cell("NJ_VLACM01"):SetHeaderAlign("RIGHT")		
		TRCell():New(oSecIt,"NJ_VLVEN01",,,PesqPict("SNJ","NJ_VLVEN01"),TamSx3("NJ_VLVEN01")[1])	
		oSecIt:Cell("NJ_VLVEN01"):SetHeaderAlign("RIGHT")
		TRCell():New(oSecIt,"NJ_VLREC01",,,PesqPict("SNJ","NJ_VLREC01"),TamSx3("NJ_VLREC01")[1])
		oSecIt:Cell("NJ_VLREC01"):SetHeaderAlign("RIGHT")
		TRCell():New(oSecIt,"NJ_VLTAX01",,,PesqPict("SNJ","NJ_VLTAX01"),TamSx3("NJ_VLTAX01")[1])
		oSecIt:Cell("NJ_VLTAX01"):SetHeaderAlign("RIGHT")
	Else 
		if	SNJ->(FieldPos("NJ_VORIG"+cVar)) > 0	
			TRCell():New(oSecIt,"NJ_VORIG"+cVar,,,PesqPict("SNJ","NJ_VORIG"+cVar),TamSx3("NJ_VORIG"+cVar)[1]) 	
			oSecIt:Cell("NJ_VORIG"+cVar):SetHeaderAlign("RIGHT")
		endif
		if	SNJ->(FieldPos("NJ_VRDACM"+cVar)) > 0	
			TRCell():New(oSecIt,"NJ_VRDACM"+cVar,,,PesqPict("SNJ","NJ_VRDACM"+cVar),TamSx3("NJ_VRDACM"+cVar)[1]) 
			oSecIt:Cell("NJ_VRDACM"+cVar):SetHeaderAlign("RIGHT")   
		endif		
		if	SNJ->(FieldPos("NJ_VLVEN0"+cVar)) > 0	
			TRCell():New(oSecIt,"NJ_VLVEN0"+cVar,,,PesqPict("SNJ","NJ_VLVEN0"+cVar),TamSx3("NJ_VLVEN0"+cVar)[1])	
			oSecIt:Cell("NJ_VLVEN0"+cVar):SetHeaderAlign("RIGHT")
		endif
		if	SNJ->(FieldPos("NJ_VLREC0"+cVAr)) > 0	
			TRCell():New(oSecIt,"NJ_VLREC0"+cVAr,,,PesqPict("SNJ","NJ_VLREC0"+cVar),TamSx3("NJ_VLREC0"+cVar)[1])
			oSecIt:Cell("NJ_VLREC0"+cVar):SetHeaderAlign("RIGHT")
		endif
		if	SNJ->(FieldPos("NJ_TXDEPR"+cVar)) > 0	
			TRCell():New(oSecIt,"NJ_TXDEPR"+cVar,,,PesqPict("SNJ","NJ_TXDEPR"+cVar),TamSx3("NJ_TXDEPR"+cVar)[1])
			oSecIt:Cell("NJ_TXDEPR"+cVar):SetHeaderAlign("RIGHT")
		endif
	Endif
	If lCPerRev
		TRCell():New(oSecIt,"NJ_CPERREV",,,PesqPict("SNJ","NJ_CPERREV"),TamSx3("NJ_CPERREV")[1]) 	
		oSecIt:Cell("NJ_CPERREV"):SetHeaderAlign("RIGHT")
	EndIf
	If lCRecDes
		TRCell():New(oSecIt,"NJ_CRECDES",,,PesqPict("SNJ","NJ_CRECDES"),TamSx3("NJ_CRECDES")[1]) 	
		oSecIt:Cell("NJ_CRECDES"):SetHeaderAlign("RIGHT")	
	EndIf 
	If lTpAjust
		TRCell():New(oSecIt,"NJ_TPAJUST",,,,15)
		oSecIt:Cell("NJ_TPAJUST"):SetHeaderAlign("RIGHT")
	EndIf
Endif
TRCell():New(oSecIt,"N3_HISTOR",,,PesqPict("SN3","N3_HISTOR"),50,,,,.T.,,,,.T.)

//Fim Secao Itens

//****************************************************************************************************************************

//Secao dos Parametros

oSecPar := TRSection():New(oRetRpt,STR0005)//"Parametros"

TRCell():New(oSecPar,"NI_PARAM",,STR0005,,120,,,,.T.,,,,.T.)//"Parametros"

//Fim Secao Parametros


Return(oRetRpt)                                                             




/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetQry    ºAutor  ³Fernando Radu Muscaluº Data ³  10/03/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e roda query que resulta um recordset para ser utilizadoº±±
±±º          ³no ato da impressao dos dados da simulacao do vlr. recuperar º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nil                                              			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GetQry(cTmpFil)

Local cQry		:= ""
Local cVar 		:= Substr(MV_PAR09,2,1)

cQry := "SELECT " + CRLF
cQry += "	NI_FILIAL, " + CRLF
cQry += "	NI_PROC, " + CRLF
cQry += "	NI_ROTINA, " + CRLF
cQry += "	NI_DTEMIS, " + CRLF
cQry += "	NI_DTIOA, " + CRLF
cQry += "	NI_LA, " + CRLF
cQry += "	NI_STATUS, " + CRLF
cQry += "	NJ_ITEM, " + CRLF
cQry += "	NJ_BEM, " + CRLF
cQry += "	NJ_ITBEM, " + CRLF
cQry += "	NJ_TIPO " + CRLF

If MV_PAR10 == 1
	cQry += "	,NJ_VLREC01 " + CRLF  
	if SNJ->(FieldPos("NJ_TPDEPR")) > 0
		cQry += "	,NJ_TPDEPR " + CRLF
	endif
	if SNJ->(FieldPos("NJ_PERDEPR")) > 0
		cQry += "	,NJ_PERDEPR " + CRLF
	endif
	if SNJ->(FieldPos("NJ_VMXDEPR")) > 0
		cQry += "	,NJ_VMXDEPR " + CRLF
	endif
	if SNJ->(FieldPos("NJ_VLSALV1")) > 0
		cQry += "	,NJ_VLSALV1 " + CRLF
	endif
	if SNJ->(FieldPos("NJ_PRODANO")) > 0
		cQry += "	,NJ_PRODANO " + CRLF
	endif
	if SNJ->(FieldPos("NJ_PRODMES")) > 0
		cQry += "	,NJ_PRODMES " + CRLF
	endif
	if SNJ->(FieldPos("NJ_PRODACM")) > 0
		cQry += "	,NJ_PRODACM " + CRLF
	endif
	if SNJ->(FieldPos("NJ_CODIND")) > 0
		cQry += "	,NJ_CODIND  " + CRLF         
	endif
Else
	If lDtAval
		cQry += "	,NJ_DTAVALI " + CRLF
	EndIf
	If lVlrImp
		cQry += "	,NJ_VLRIMPT " + CRLF
	EndIf
	If MV_PAR09 == "01"   
		cQry += "	,NJ_VLORI01 " + CRLF
		cQry += "	,NJ_VLVEN01 " + CRLF  
		cQry += "	,NJ_VLREC01 " + CRLF
		cQry += "	,NJ_VLTAX01 " + CRLF
		cQry += "	,NJ_VLACM01 " + CRLF    
	Else 
		if SNJ->(FieldPos("NJ_VORIG"+cVar)) > 0
			cQry += "	,NJ_VORIG"+cVar+" " + CRLF
		endif
		if SNJ->(FieldPos("NJ_VLVEN0"+cVar)) > 0
			cQry += "	,NJ_VLVEN0"+cVar+" " + CRLF  
		endif
		if SNJ->(FieldPos("NJ_VLREC0"+cVar)) > 0
			cQry += "	,NJ_VLREC0"+cVar+" " + CRLF
		endif	
		if SNJ->(FieldPos("NJ_TXDEPR"+cVar)) > 0
			cQry += "	,NJ_TXDEPR"+cVar+" " + CRLF
		endif	
		if SNJ->(FieldPos("NJ_VRDACM"+cVar)) > 0
			cQry += "	,NJ_VRDACM"+cVar+" " + CRLF
		Endif
	endif
	If lCPerRev
		cQry += "	,NJ_CPERREV " + CRLF
	EndIf
	If lCRecDes
		cQry += "	,NJ_CRECDES " + CRLF
	EndIf	
	If lTpAjust
		cQry += "	,NJ_TPAJUST " + CRLF
	EndIf	
Endif	


cQry += "FROM " + CRLF
cQry += "	" + RETSQLNAME("SNI") + " SNI " + CRLF
cQry += "INNER JOIN  " + CRLF
cQry += "	" + RETSQLNAME("SNJ") + " SNJ " + CRLF
cQry += "ON " + CRLF
cQry += "	SNI.NI_FILIAL = SNJ.NJ_FILIAL " + CRLF
cQry += "	AND SNI.NI_PROC = SNJ.NJ_PROC " + CRLF
cQry += "	AND SNI.D_E_L_E_T_ = ' ' " + CRLF
cQry += "WHERE " + CRLF

cQry += "	SNI.NI_PROC BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' " + CRLF
cQry += "   AND	SNI.NI_DTEMIS BETWEEN  '" + dtos(mv_par03) + "' AND '" + dtos(mv_par04) + "' " + CRLF

If len(aSelFil) > 0 .And. !lTodasFil
	cQry += "	AND SNI.NI_FILIAL " + GetRngFil( aSelFil, 'SNI', .T., @cTmpFil ) + CRLF
Endif

If Alltrim(UPPER(oObjPerg:CX1_DEF03))  == "ESTORNADO"
	If MV_PAR08 == 1
		cQry += "   AND SNI.NI_DTIOA = ' ' "
		cQry += "   AND SNI.NI_STATUS = '1' "
	ElseIf MV_PAR08 == 2
		cQry += "   AND SNI.NI_STATUS = '2' "
		cQry += "	AND SNI.NI_DTIOA  BETWEEN   '" + dtos(mv_par05) + "' AND '" + dtos(mv_par06) + "'  " + CRLF
	ElseIf MV_PAR08 == 3
		cQry += "   AND SNI.NI_STATUS = '3' "
		cQry += "	AND SNI.NI_DTIOA  BETWEEN   '" + dtos(mv_par05) + "' AND '" + dtos(mv_par06) + "'  " + CRLF
	EndIf
Else
	If MV_PAR08 == 1
		cQry += "   AND SNI.NI_DTIOA = ' ' "
		cQry += "   AND SNI.NI_STATUS = '1' "
	ElseIf MV_PAR08 == 2
		cQry += "   AND SNI.NI_STATUS = '2' "
		cQry += "	AND SNI.NI_DTIOA  BETWEEN   '" + dtos(mv_par05) + "' AND '" + dtos(mv_par06) + "'  " + CRLF
	EndIf
EndIf

cQry += "	AND SNI.D_E_L_E_T_ = ' ' " + CRLF
cQry += "ORDER BY " + CRLF
cQry += "	NI_FILIAL, " + CRLF
cQry += "	NI_PROC, " + CRLF
cQry += "	NJ_ITEM, " + CRLF
cQry += "	NJ_BEM, " + CRLF
cQry += "	NJ_ITBEM "

If Select(cArqTmp) > 0
	(cArqTmp)->(DbCloseArea())
Endif

cQry := ChangeQuery(cQry)

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQry) , cArqTmp , .T. , .F.)

(cArqTmp)->(DbGotop())

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AF411TopºAutor  ³Fernando Radu Muscaluº Data ³  10/03/2011     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime relatorio a partir do recordset gerado da query        º±±
±±º          ³valido somente para ambientes com Topconnect	                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport	- Objeto TReport                      			     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nil                                              			     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function AF411Top(oReport)

Local oSecCab 	:= oReport:Section(1)
Local oSecIt	:= oReport:Section(1):Section(1)
Local oSecPar	:= oReport:Section(2)

Local cAFR411Fil	:= ""
Local cProc			:= ""
Local cItem			:= ""
Local cBem			:= ""
Local cItBem		:= ""
Local cParam		:= ""
Local cSeek			:= ""
Local cVar			:= Substr(MV_PAR09,2,1)
Local nX			:= 0   
Local oSx1          := FWSX1Util():New()  
Local aPergRel  	:= {}
Local lImpPar		:= .T.
Local lQbrPage		:= .T.

Local lPrintCab		:= .F.

oSx1:AddGroup("AFR411")
oSx1:SearchGroup()
aPergRel := oSx1:GetGroup("AFR411")


If Len(aPergRel) > 0 .And. Len(aPergRel[2]) >= 12
	lImpPar  := MV_PAR11 == 1
	lQbrPage := MV_PAR12 == 1 .or. MV_PAR11 == 1
EndIf

(cArqTmp)->(DbGotop())

While (cArqTmp)->(!eof())
	
	If Padr((cArqTmp)->NI_FILIAL,TamSx3("NI_FILIAL")[1])+Padr((cArqTmp)->NI_PROC,TamSx3("NI_PROC")[1]) <> Padr(cAFR411Fil,TamSx3("NI_FILIAL")[1])+Padr(cProc,TamSx3("NI_PROC")[1])
		If lImpPar 
			oSecPar:Init()
		
			cParam := GetAdvFVal("SNI","NI_PARAM",Padr((cArqTmp)->NI_FILIAL,TamSx3("NI_FILIAL")[1])+Padr((cArqTmp)->NI_PROC,TamSx3("NI_PROC")[1]) ,1,"")
			
			oSecPar:Cell("NI_PARAM"):SetTitle(STR0006 + Alltrim((cArqTmp)->NI_PROC))//"Parametros - Processo: "
			
			If !Empty(cParam)
				oSecPar:Cell("NI_PARAM"):SetValue(  AF411PrPar(cParam)  )
			Else
				oSecPar:Cell("NI_PARAM"):SetValue(  "" )
			Endif
			
			oSecPar:PrintLine()
			
			oSecPar:Finish()
			
			oReport:EndPage()
		EndIf
		
		oSecCab:Init()
		
		oSecCab:Cell("NI_FILIAL"):SetValue( (cArqTmp)->NI_FILIAL )
		oSecCab:Cell("NI_PROC"):SetValue( (cArqTmp)->NI_PROC )
		oSecCab:Cell("NI_ROTINA"):SetValue( IIF(!Empty( (cArqTmp)->NI_ROTINA ), X3COMBO("NI_ROTINA",(cArqTmp)->NI_ROTINA),STR0019 ) ) // "Manual"
		oSecCab:Cell("NI_STATUS"):SetValue( X3COMBO("NI_STATUS",(cArqTmp)->NI_STATUS) )
		oSecCab:Cell("NI_DTEMIS"):SetValue( stod((cArqTmp)->NI_DTEMIS) )
		oSecCab:Cell("NI_DTIOA"):SetValue( stod((cArqTmp)->NI_DTIOA) )
		oSecCab:Cell("NI_LA"):SetValue( IIF( Alltrim( (cArqTmp)->NI_LA ) == 'S', STR0020, STR0021 )  )//"Sim"##"Não"
		
		oSecCab:PrintLine()
		
		oSecCab:Finish()
		
		oReport:SkipLine()
		lPrintCab:=.T.
		oSecIt:Finish()
		
	Endif
	
	If Padr((cArqTmp)->NI_FILIAL,TamSx3("NI_FILIAL")[1])+;
		Padr((cArqTmp)->NI_PROC,TamSx3("NI_PROC")[1])+;
		Padr((cArqTmp)->NJ_ITEM,TamSx3("NJ_ITEM")[1])+;
		Padr((cArqTmp)->NJ_BEM,TamSx3("NJ_BEM")[1])+;
		Padr((cArqTmp)->NJ_ITBEM,TamSx3("NJ_ITBEM")[1]) <>;
		Padr(cAFR411Fil,TamSx3("NI_FILIAL")[1])+;
		Padr(cProc,TamSx3("NI_PROC")[1])+;
		Padr(cItem,TamSx3("NJ_ITEM")[1])+;
		Padr(cBem,TamSx3("NJ_BEM")[1])+;
		Padr(cItBem,TamSx3("NJ_ITBEM")[1])
		
		If lPrintCab
			oSecIt:Init()
			lPrintCab:=.F.
		Endif
		
		cSeek := 	Padr((cArqTmp)->NI_FILIAL,TamSx3("N3_FILIAL")[1])+;
		Padr((cArqTmp)->NJ_BEM,TamSx3("N3_CBASE")[1])+;
		Padr((cArqTmp)->NJ_ITBEM,TamSx3("N3_ITEM")[1])+;
		Padr((cArqTmp)->NJ_TIPO,TamSx3("N3_TIPO")[1])
		
		TRPosition():New(oSecIt,"SNJ",1,{|| xFilial("SNJ",(cArqTmp)->(NI_FILIAL)) + (cArqTmp)->(NI_PROC+NJ_ITEM) })
		oSecIt:Cell("NJ_ITEM"):SetValue( (cArqTmp)->NJ_ITEM )
		oSecIt:Cell("NJ_BEM"):SetValue( (cArqTmp)->NJ_BEM )
		oSecIt:Cell("NJ_ITBEM"):SetValue( (cArqTmp)->NJ_ITBEM )
		oSecIt:Cell("NJ_TIPO"):SetValue( (cArqTmp)->NJ_TIPO )
				
		If MV_PAR10 == 1
			oSecIt:Cell("NJ_VLREC01"):SetValue( (cArqTmp)->NJ_VLREC01 )
			if SNJ->(FieldPos("NJ_TPDEPR")) > 0
				oSecIt:Cell("NJ_TPDEPR"):SetValue( (cArqTmp)->NJ_TPDEPR )
			endif
			if SNJ->(FieldPos("NJ_PERDEPR")) > 0
				oSecIt:Cell("NJ_PERDEPR"):SetValue( (cArqTmp)->NJ_PERDEPR ) 
			endif
			if SNJ->(FieldPos("NJ_VMXDEPR")) > 0
				oSecIt:Cell("NJ_VMXDEPR"):SetValue( (cArqTmp)->NJ_VMXDEPR )
			endif
			if SNJ->(FieldPos("NJ_VLSALV1")) > 0
				oSecIt:Cell("NJ_VLSALV1"):SetValue( (cArqTmp)->NJ_VLSALV1 )
			endif
			if SNJ->(FieldPos("NJ_PRODANO")) > 0
				oSecIt:Cell("NJ_PRODANO"):SetValue( (cArqTmp)->NJ_PRODANO )
			endif
			if SNJ->(FieldPos("NJ_PRODMES")) > 0
				oSecIt:Cell("NJ_PRODMES"):SetValue( (cArqTmp)->NJ_PRODMES )										
			endif
			if SNJ->(FieldPos("NJ_PRODACM")) > 0
				oSecIt:Cell("NJ_PRODACM"):SetValue( (cArqTmp)->NJ_PRODACM )
			endif
			if SNJ->(FieldPos("NJ_CODIND")) > 0
				oSecIt:Cell("NJ_CODIND"):SetValue( (cArqTmp)->NJ_CODIND )
			endif	
		Else		
			If lDtAval
				oSecIt:Cell("NJ_DTAVALI"):SetValue( Stod((cArqTmp)->NJ_DTAVALI) )	
			EndIf
			If MV_PAR09 == "01"	
				If lVlrImp
					oSecIt:Cell("NJ_VLRIMPT"):SetValue( (cArqTmp)->NJ_VLRIMPT )			
				EndIf
				oSecIt:Cell("NJ_VLORI01"):SetValue( (cArqTmp)->NJ_VLORI01 )
				oSecIt:Cell("NJ_VLACM01"):SetValue( (cArqTmp)->NJ_VLACM01 )
				oSecIt:Cell("NJ_VLVEN01"):SetValue( (cArqTmp)->NJ_VLVEN01 )				
				oSecIt:Cell("NJ_VLREC01"):SetValue( (cArqTmp)->NJ_VLREC01 )
				oSecIt:Cell("NJ_VLTAX01"):SetValue( (cArqTmp)->NJ_VLTAX01 )				
			Else  
   				if SNJ->(FieldPos("NJ_VORIG"+cVar)) > 0
					oSecIt:Cell("NJ_VORIG"+cVar):SetValue( (cArqTmp)->&("NJ_VORIG"+cVar))
				endif
				if SNJ->(FieldPos("NJ_VRDACM"+cVar)) > 0
					oSecIt:Cell("NJ_VRDACM"+cVar):SetValue( (cArqTmp)->&("NJ_VRDACM"+cVar))
				endif	
				if SNJ->(FieldPos("NJ_VLVEN0"+cVar)) > 0
					oSecIt:Cell("NJ_VLVEN0"+cVar):SetValue( (cArqTmp)->&("NJ_VLVEN0"+cVar))
				endif
				if SNJ->(FieldPos("NJ_VLREC0"+cVar)) > 0
					oSecIt:Cell("NJ_VLREC0"+cVar):SetValue( (cArqTmp)->&("NJ_VLREC0"+cVar))
				endif	                                                                   
				if SNJ->(FieldPos("NJ_TXDEPR"+cVar)) > 0
					oSecIt:Cell("NJ_TXDEPR"+cVar):SetValue( (cArqTmp)->&("NJ_TXDEPR"+cVar))
				endif
		    Endif
			If lCPerRev
				oSecIt:Cell("NJ_CPERREV"):SetValue( (cArqTmp)->NJ_CPERREV )	
			EndIf
			If lCRecDes
				oSecIt:Cell("NJ_CRECDES"):SetValue( (cArqTmp)->NJ_CRECDES )	
			EndIf
			If lTpAjust
				oSecIt:Cell("NJ_TPAJUST"):SetValue( X3COMBO("NJ_TPAJUST",(cArqTmp)->NJ_TPAJUST) )	
			EndIf
		Endif
		oSecIt:Cell("N3_HISTOR"):SetValue( GetAdvFVal("SN3","N3_HISTOR",cSeek ,1,"") ) 
		oSecIt:PrintLine()
		
	Endif
	
	cAFR411Fil 	:= (cArqTmp)->NI_FILIAL
	cProc		:= (cArqTmp)->NI_PROC
	cItem		:= (cArqTmp)->NJ_ITEM
	cBem		:= (cArqTmp)->NJ_BEM
	cItBem		:= (cArqTmp)->NJ_ITBEM
	
	(cArqTmp)->(DbSkip())
	
	If Padr((cArqTmp)->NI_FILIAL,TamSx3("NI_FILIAL")[1])+Padr((cArqTmp)->NI_PROC,TamSx3("NI_PROC")[1]) <> Padr(cAFR411Fil,TamSx3("NI_FILIAL")[1])+Padr(cProc,TamSx3("NI_PROC")[1])
		If !Empty((cArqTmp)->NI_FILIAL)
			If lQbrPage
				oReport:EndPage()
			Else
				oReport:SkipLine(3)
			EndIf
		Endif
	Endif
EndDo

If !lQbrPage
	oReport:EndPage()
EndIf

Return()


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AF411PrPar   ºAutor  ³Fernando Radu Muscaluº Data ³  10/03/2011   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta a string para a impressao da parametrizacao do processo     º±±
±±º          ³da simulacao do vlr. recuperavel do ativo   	                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cString	- String com os parametros do processo			        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³cRetorno	- String com o tratamento dos parametros do processo    º±±
±±º          ³da simulacao do valor recuperavel do ativo       			        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function AF411PrPar(cString)

Local cRetorno	:= ""
Local aStrPar	:= {}

Local aPar		:= {}

Local nI		:= 0

aStrPar := Separa(cString,"#")
aDel(aStrPar,(len(aStrPar)))
aSize(aStrPar,len(aStrPar)-1)

//C%0000000001#C%0000000002#C%    #C%    #C%         #C%ZZZZZZZZZ#C%                    #C%ZZZZZZZZZZZZZZZZZZZZ#D%20110101#D%20111231#C%    #C%ZZZZ#

If len(aStrPar) > 1  //registros do tipo manual
	aAdd(aPar,{STR0007		,Substr(aStrPar[1],3)})//"Bem de"
	aAdd(aPar,{STR0008		,Substr(aStrPar[2],3)})//"Bem ate"
	aAdd(aPar,{STR0009		,Substr(aStrPar[3],3)})//"Grupo de"
	aAdd(aPar,{STR0010		,Substr(aStrPar[4],3)})//"Grupo ate"
	aAdd(aPar,{STR0011	    ,Substr(aStrPar[5],3)})//"C. Custo de"
	aAdd(aPar,{STR0012	    ,Substr(aStrPar[6],3)})//"C. Custo ate"
	aAdd(aPar,{STR0013		,Substr(aStrPar[7],3)})//"Conta de"
	aAdd(aPar,{STR0014		,Substr(aStrPar[8],3)})//"Conta ate"
	If Len(aStrPar) > 9
		aAdd(aPar,{STR0015	,dtoc(stod(substr(aStrPar[9],3)))})//"Data de"
		aAdd(aPar,{STR0016	,dtoc(stod(substr(aStrPar[10],3)))})//"Data ate"
		aAdd(aPar,{STR0017	,Substr(aStrPar[11],3)})//"Item de"
		aAdd(aPar,{STR0018	,Substr(aStrPar[12],3)})//"Item ate"
	EndIf
Else //registros do tipo importação
	aAdd(aPar,{STR0023		,Substr(aStrPar[1],3)})		
EndIf


For nI := 1 to len(aPar)
	cRetorno += strzero(nI,2) + " " + aPar[nI,1] + ": " + aPar[nI,2] + CRLF
Next nI

Return(cRetorno)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AF411PrPar   ºAutor  ³ernando Radu Muscaluº Data ³  10/03/2011   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se a Moeda existe										    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cString	- String com os parametros do processo			        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³cRetorno	- String com o tratamento dos parametros do processo    º±±
±±º          ³da simulacao do valor recuperavel do ativo       			        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAATF                                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function VldMoeda(MV_PAR09)
Local cSeek:= ""
Local lRet:=.T.

cSeek :=xFilial("CTO")+MV_PAR09
	
If !CTO->(DbSeek(cSeek,.t.))
	MSGINFO(STR0024)
	lRet:= .F.
Endif

Return (lRet)

