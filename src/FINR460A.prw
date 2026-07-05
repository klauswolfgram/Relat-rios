/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "REPORT.CH"
#include "FINR460A.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} FINR460A

Relatório de Acordos de Liquidação

@author julio.teixeira
@since 08/10/2015
@version P12
/*/
//-------------------------------------------------------------------
User Function FINR460A()
Local oReport		:= Nil
Local aSM0Fils		:= AdmAbreSM0()
Private cPerg		:= "FINR460A"
Private aSelFil		:= {}

lRet := Pergunte( cPerg , .T. )

If lRet
	oReport:= ReportDef(aSM0Fils)
	oReport:PrintDialog()
EndIf

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ReportDef

Função de definição do layout e formato do relatório

@param aSM0Fils	Array com as informações de todas as filiais do sistema
@return oReport	Objeto criado com o formato do relatório
@author julio.teixeira
@since 08/10/2015
@version P12
/*/
//-------------------------------------------------------------------
Static Function ReportDef(aSM0Fils)

Local oReport		:= nil
Local oCabec		:= nil
Local oTitSel		:= nil
Local oTitGer		:= nil
Local cAlsFO0		:= GetNextAlias()
Local cAlsFO1		:= GetNextAlias()
Local cAlsFO2		:= GetNextAlias()
	
/*
 * Chamada do pergunte com os parâmetros para definir o comportamento e filtros
 * do relatório
 */
	Pergunte(cPerg,.F.)

/*
 * Definição padrão do relatório TReport
 */
	oReport	:= TReport():New('FINR460A',STR0001 , 'FINR460A',{|oReport|PrintReport(oReport,cPerg,cAlsFO0,cAlsFO1,cAlsFO2)},) //"Relatório de acordos de liquidação"
	oReport:SetLandScape()
/*
 * Desabilita o botão de parâmetros de customizações do relatório TReport
 */
	oReport:ParamReadOnly()
	
	//Seção Cabeçalho do Processo
	oCabec := TRSection():New(oReport,STR0002,{"FO0"}) //"Cabeçalho"
	oCabec:SetTitle(UPPER(STR0003))//"Processo de negociação"
	oCabec:SetHeaderSection(.T.)
	TRCell():New( oCabec, "FO0_PROCES"		, "FO0", /*X3Titulo*/RetTitle("FO0_PROCES"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Processo
	TRCell():New( oCabec, "FO0_COND"		, "FO0", /*X3Titulo*/RetTitle("FO0_COND"), /*Picture*/, /*Tamanho*/,/*lPixel*/,)//Condição de Pagamento
	TRCell():New( oCabec, "FO0_DATA"		, "FO0", /*X3Titulo*/RetTitle("FO0_DATA"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Data da Negociação
	TRCell():New( oCabec, "FO0_DTVALI"		, "FO0", /*X3Titulo*/RetTitle("FO0_DTVALI"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Data de Validade
	TRCell():New( oCabec, "FO0_VERSAO"		, "FO0", /*X3Titulo*/RetTitle("FO0_VERSAO"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Versão
	TRCell():New( oCabec, "FO0_NUMLIQ"		, "FO0", /*X3Titulo*/RetTitle("FO0_NUMLIQ"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Número da Liquidação
	TRCell():New( oCabec, "FO0_MOEDA"		, "FO0", /*X3Titulo*/RetTitle("FO0_MOEDA"), "@!"/*Picture*/, 30/*TamSX3("")[1]*/,/*lPixel*/.F.,{ || GetXMoeda( (cAlsFO0)->FO0_MOEDA ) },/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/, .F. /*lAutoSize*/ )//Número da Liquidação
	TRCell():New( oCabec, "CLIENTE"			, "FO0", /*X3Titulo*/STR0010, /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Cliente/Loja
	TRCell():New( oCabec, "A1_NOME"			, "FO0", /*X3Titulo*/RetTitle("A1_NOME"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Razao Social
	TRCell():New( oCabec, "NATUREZA"		, "FO0", /*X3Titulo*/RetTitle("FO0_NATURE"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )//Natureza
	
	//Seção Títulos selecionados
	oTitSel := TRSection():New(oReport,STR0006,{"FO1"})//Títulos Negociados
	oTitSel:SetTitle(STR0006)//Títulos Negociados
	oTitSel:SetHeaderSection(.T.)
	TRCell():New( oTitSel, "FO1_FILIAL"		, "FO1", /*X3Titulo*/RetTitle("FO1_FILIAL"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )	
	TRCell():New( oTitSel, "TIT"			, "FO1", /*X3Titulo*/"Prefixo/Número/Parcela/Tipo", /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "E1_NOMCLI"		, "FO1", /*X3Titulo*/RetTitle("E1_NOMCLI"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "E1_NATUREZ"		, "FO1", /*X3Titulo*/RetTitle("E1_NATUREZ"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "E1_VENCTO"		, "FO1", , /*Picture*/RetTitle("E1_VENCTO"), 12/*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "E1_VENCREA"		, "FO1", , /*Picture*/RetTitle("E1_VENCREA"), 12/*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_SALDO"		, "FO1", /*X3Titulo*/ RetTitle("FO1_SALDO"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_TXMUL"		, "FO1", /*X3Titulo*/ RetTitle("FO1_TXMUL"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_VLMUL"		, "FO1", /*X3Titulo*/ RetTitle("FO1_VLMUL"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_TXJUR"		, "FO1", /*X3Titulo*/ RetTitle("FO1_TXJUR"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_VLJUR"		, "FO1", /*X3Titulo*/ RetTitle("FO1_VLJUR"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_VLDIA"		, "FO1", /*X3Titulo*/ RetTitle("FO1_VLDIA"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_ACRESC"		, "FO1", /*X3Titulo*/ RetTitle("FO1_ACRESC"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_DECRES"		, "FO1", /*X3Titulo*/ RetTitle("FO1_DECRES"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_DESCON"		, "FO1", /*X3Titulo*/ RetTitle("FO1_DESCON"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitSel, "FO1_VLABT"		, "FO1", /*X3Titulo*/ RetTitle("FO1_VLABT"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	If FO1->( ColumnPos( 'FO1_VACESS' ) ) > 0
		TRCell():New( oTitSel, "FO1_VACESS"	, "FO1", /*X3Titulo*/ RetTitle("FO1_VACESS"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	EndIf
	TRCell():New( oTitSel, "FO1_TOTAL"		, "FO1", /*X3Titulo*/ RetTitle("FO1_TOTAL"), /*Picture*/, /*TamSX3("")[1]*/,/*lPixel*/.F.,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	
	//Seção Títulos Gerados
	oTitGer := TRSection():New(oReport,STR0007,{"FO2"})//Títulos gerados
	oTitGer:SetTitle(STR0007)//Títulos gerados
	oTitGer:SetHeaderSection(.T.)
	TRCell():New( oTitGer, "FO2_PREFIX"	, "FO2", /*X3Titulo*/RetTitle("FO2_PREFIX"), /*Picture*/, /*TamSX3("")[1]*/ 10,/*lPixel*/.F.,,/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_NUM"		, "FO2", /*X3Titulo*/RetTitle("FO2_NUM"), /*Picture*/, ,/*lPixel*/,,/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_PARCEL"	, "FO2", /*X3Titulo*/RetTitle("FO2_PARCEL"), /*Picture*/,,/*lPixel*/,,/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO0_TIPO"		, "FO0", /*X3Titulo*/RetTitle("FO0_TIPO"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "LEFT",/*lLineBreak*/,/*cHeaderAlign*/"LEFT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_VENCTO"		, "FO2", /*X3Titulo*/RetTitle("FO2_VENCTO"),, /*Tamanho*/,/*lPixel*/,,/*nALign*/ "CENTER",/*lLineBreak*/,/*cHeaderAlign*/"CENTER",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_VALOR"		, "FO2", /*X3Titulo*/RetTitle("FO2_VALOR"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_TXJUR"		, "FO2", /*X3Titulo*/RetTitle("FO2_TXJUR"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_VLJUR"		, "FO2", /*X3Titulo*/RetTitle("FO2_VLJUR"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_ACRESC"		, "FO2", /*X3Titulo*/RetTitle("FO2_ACRESC"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_DECRES"		, "FO2", /*X3Titulo*/RetTitle("FO2_DECRES"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )
	TRCell():New( oTitGer, "FO2_TOTAL"		, "FO2", /*X3Titulo*/RetTitle("FO2_TOTAL"), , /*Tamanho*/,/*lPixel*/,,/*nALign*/ "RIGHT",/*lLineBreak*/,/*cHeaderAlign*/"RIGHT",/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T. )	
	
Return oReport

//-------------------------------------------------------------------
/*/{Protheus.doc} PrintReport

Função para busca das informações que serão impressas no relatório

@param oReport	Objeto para manipulação das seções, atributos e dados do relatório.
@param cPerg		Identificação do Grupo de Perguntas do relatório
@param cAlsLib	Nome de Identificação do RecordSet das informaões do relatório.
@param aSM0Fils	Array com as informações de todas as filiais do sistema.
@return nil
@author julio.teixeira	
@since 01/09/2015
@version P12
/*/
//-------------------------------------------------------------------

Static Function PrintReport(oReport,cPerg,cAlsFO0,cAlsFO1,cAlsFO2)
Local oCabec		:= oReport:Section(1)
Local oTitSel		:= oReport:Section(2)
Local oTitGer		:= oReport:Section(3)
Local nX			:= 0

Local cDataDe		:= MV_PAR01
Local cDataAte		:= MV_PAR02

Local cDtVldDe		:= MV_PAR03
Local cDtVldAte		:= MV_PAR04
Local cNumSimula	:= MV_PAR11
Local cVerSimula	:= MV_PAR12	

Local lSelFil		:= (MV_PAR10 == 1)
local aSelFil		:= {}
Local cConcat 		:= If( Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX", "||", "+")

Local cCliente	 	:= "FO0.FO0_CLIENT+'/'+FO0.FO0_LOJA"
Local cNatureza		:= "FO0.FO0_NATURE+'/'+SED.ED_DESCRIC"
Local cTit			:= "SE1.E1_PREFIXO+'/'+SE1.E1_NUM+'/'+SE1.E1_PARCELA+'/'+SE1.E1_TIPO"
Local cSE1Chave 	:= "SE1.E1_FILIAL + '|' + SE1.E1_PREFIXO + '|' + SE1.E1_NUM + '|' + SE1.E1_PARCELA + '|' + SE1.E1_TIPO + '|' + SE1.E1_CLIENTE + '|' + SE1.E1_LOJA"
Local cSelec        := "%%"
Local cFiltSimul	:= "%%"

Local nTotSel   := 0
Local nTotGer  	:= 0

Local cNextP     := ""
Local cFilFO0    := ''

Local cProces := ""
Local cVersao := ""
Local lGetParAut	:= ExistFunc("GetParAuto")
Local cAuxFil := "" 
Local lGestao := ( FWSizeFilial() > 2 )
Local lFO0Excl := Iif( lGestao, FWModeAccess("FO0",1) == "E", FWModeAccess("FO0",3) == "E")

//tratamento de concatenação
cCliente   := "%"+strtran(cCliente,"+",cConcat)+"%"
cNatureza  := "%"+strtran(cNatureza,"+",cConcat)+"%"
cTit 	   := "%"+strtran(cTit,"+",cConcat)+"%"
cSE1Chave  := "%"+strtran(cSE1Chave,"+",cConcat)+"%"

//tratamento de filiais
If lSelFil .And. lFO0Excl
	AdmSelecFil("FINR460A",10,.F.,@aSelFil,"FO0",.F.)
	If lGetParAut .And. IsBlind()
		aRetAuto	:= GetParAuto("FINR460ATestCase")
		aSelFil:= Iif(ValType(aRetAuto) == "A", aRetAuto, aSelFil)	
	EndIf
EndIf

//Tratamento se seleciona negociados, liquidados ou ambos
If MV_PAR09 == 1
	cSelec := "% FO0.FO0_STATUS = '1' AND %"
Elseif MV_PAR09 == 2
	cSelec := "% FO0.FO0_STATUS = '4' AND FO0.FO0_NUMLIQ <> '' AND %"
Endif

//Se o Número de Simulação estiver preenchido, faz o filtro, senão considerad todos.
If !Empty(cNumSimula)
	cFiltSimul := " FO0.FO0_PROCES =  '" + cNumSimula + "' AND FO0.FO0_VERSAO = '" + cVerSimula + "' AND "
	cFiltSimul := "%"+cFiltSimul+"%"	
EndIf     

If Empty(aSelFil)
	Aadd(aSelFil,cFilAnt)
	Asort(aSelFil)
	cFilFO0 := " FO0.FO0_FILIAL = '"+ xFilial("FO0") + "' AND "
Else
	Asort(aSelFil)
Endif
cFilFO0 := "%"+cFilFO0+"%"

oReport:SetMeter(Len(aSelFil))

For nX := 1 to Len(aSelFil)    

	If cAuxFil == xFilial("FO0", aSelFil[nX])
		Loop
	Else
		cAuxFil := xFilial("FO0", aSelFil[nX])
	EndIf

    cFili := ''
    cFili += "'" + xFilial("FO0", aSelFil[nX]) + "'"  
    cFili := "%" + cFili + "%"

    cFilSA1 := ''
    cFilSA1 += "'" + xFilial("SA1", aSelFil[nX]) + "'"  
    cFilSA1 := "%" + cFilSA1 + "%"

    cFilSED := ''
    cFilSED += "'" + xFilial("SED", aSelFil[nX]) + "'"  
    cFilSED := "%" + cFilSED + "%"

    If !Empty(cNextP)   
	   oReport:EndPage(.T.)  
	Endif  

   BEGIN REPORT QUERY oCabec//Cabeçalho do processo de acordo de liquidação      

	BeginSql alias cAlsFO0
		 SELECT 
			FO0.FO0_FILIAL			,
			FO0.FO0_PROCES			,
			FO0.FO0_COND			,
			FO0.FO0_DATA			,
			FO0.FO0_DTVALI			,
			FO0.FO0_VERSAO 			,
			FO0.FO0_NUMLIQ			, 
			FO0.FO0_MOEDA			,			
			%exp:cCliente% CLIENTE ,
			SA1.A1_NOME			,
			%exp:cNatureza% NATUREZA
		FROM %table:FO0% FO0 , %table:SA1% SA1, %table:SED% SED
	
		WHERE				
		   FO0.FO0_DATA BETWEEN %exp:cDataDe% AND %exp:cDataAte% AND
		   FO0.FO0_DTVALI BETWEEN %exp:cDtVldDe% AND %exp:cDtVldAte% AND
	       FO0.FO0_CLIENT BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06% AND
	       FO0.FO0_LOJA BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR08% AND
	       FO0.FO0_CLIENT = SA1.A1_COD AND   
	       FO0.FO0_LOJA = SA1.A1_LOJA AND   
	       FO0.FO0_NATURE = SED.ED_CODIGO AND   
	       %exp:cFiltSimul%
	       FO0.FO0_FILIAL = %exp:cFili% AND     
	       SA1.A1_FILIAL = %exp:cFilSA1% AND 
	       SED.ED_FILIAL = %exp:cFilSED% AND 
	       %exp:cSelec%
	       FO0.%NotDel% AND
	       SA1.%NotDel% AND
	       SED.%NotDel%
	   	ORDER BY FO0.FO0_FILIAL, FO0.FO0_PROCES, FO0.FO0_VERSAO		
		
	EndSql
	
	END REPORT QUERY oCabec

    (cAlsFO0)->(DbGoTop())
    If (cAlsFO0)->(!EOF())
	    While (cAlsFO0)->(!EOF()) //Percorre todos os processos         
	    	    	
	    	nTotSel     := 0
			nTotGer  	:= 0

	    	If !Empty(cNextP)
		       oCabec:SetPageBreak(.T.)  
		       oCabec:Finish()		       
		    endif 
	    	
	    	oCabec:Init()    	
	    	oReport:PrintText(' ')
	    	oReport:PrintText(STR0004+ aSelFil[nX]+ " " + FWFilialName(cEmpAnt,aSelFil[nX],2) )//"Filial: "
   			oReport:ThinLine()
	    		    
	    	oCabec:PrintLine(.T.)
	    	
	    	cNextP := "*"
 	    	cProces := (cAlsFO0)->FO0_PROCES
	    	cVersao := (cAlsFO0)->FO0_VERSAO
	    		    	
	    	BEGIN REPORT QUERY oTitSel

	    	If FO1->( FieldPos( 'FO1_VACESS' ) ) > 0		
				BeginSql alias cAlsFO1// Títulos negociados
				   	SELECT 
						FO1.FO1_FILIAL ,
						%exp:cTit% TIT,
						SE1.E1_NOMCLI,
						SE1.E1_NATUREZ,
						SE1.E1_VENCTO,
						SE1.E1_VENCREA,
						(FO1.FO1_SALDO + (FO1.FO1_DECRES + FO1.FO1_DESCON + FO1.FO1_VLABT)) - (FO1.FO1_VLMUL + FO1.FO1_VLJUR + FO1.FO1_ACRESC) FO1_SALDO,
						FO1.FO1_TXMUL,
						FO1.FO1_VLMUL,
						FO1.FO1_TXJUR,
						FO1.FO1_VLJUR,
						FO1.FO1_VLDIA,
						FO1.FO1_ACRESC,
						FO1.FO1_DECRES,
						FO1.FO1_DESCON,
						FO1.FO1_VLABT,
						FO1.FO1_VACESS,
						FO1.FO1_TOTAL
					FROM %table:FO1% FO1 , %table:FK7% FK7, %table:SE1% SE1		
					WHERE		  				        
				       FO1.FO1_FILIAL = %exp:cFili% AND			       			  
				       FO1.FO1_PROCES = %exp:cProces%	AND
					   FO1.FO1_VERSAO = %exp:cVersao%	AND	 
				       FO1.FO1_IDDOC = FK7.FK7_IDDOC AND    
				       %exp:cSE1chave%	= FK7.FK7_CHAVE AND  
				       FO1.%NotDel% AND
				       SE1.%NotDel% AND
				       FK7.%NotDel%
					ORDER BY FO1.FO1_FILIAL	       	
					
				EndSql
			Else
				BeginSql alias cAlsFO1// Títulos negociados				   	
				   	SELECT 
						FO1.FO1_FILIAL ,
						%exp:cTit% TIT,
						SE1.E1_NOMCLI,
						SE1.E1_NATUREZ,
						SE1.E1_VENCTO,
						SE1.E1_VENCREA,
						(FO1.FO1_SALDO + (FO1.FO1_DECRES + FO1.FO1_DESCON + FO1.FO1_VLABT)) - (FO1.FO1_VLMUL + FO1.FO1_VLJUR + FO1.FO1_ACRESC) FO1_SALDO,
						FO1.FO1_TXMUL,
						FO1.FO1_VLMUL,
						FO1.FO1_TXJUR,
						FO1.FO1_VLJUR,
						FO1.FO1_VLDIA,
						FO1.FO1_ACRESC,
						FO1.FO1_DECRES,
						FO1.FO1_DESCON,
						FO1.FO1_VLABT,
						FO1.FO1_TOTAL
					FROM %table:FO1% FO1 , %table:FK7% FK7, %table:SE1% SE1		
					WHERE		  				        
				       FO1.FO1_FILIAL = %exp:cFili% AND			       			  
				       FO1.FO1_PROCES = %exp:cProces%	AND
					   FO1.FO1_VERSAO = %exp:cVersao%	AND	 
				       FO1.FO1_IDDOC = FK7.FK7_IDDOC AND    
				       %exp:cSE1chave%	= FK7.FK7_CHAVE AND  
				       FO1.%NotDel% AND
				       SE1.%NotDel% AND
				       FK7.%NotDel%
					ORDER BY FO1.FO1_FILIAL	       	
					
				EndSql			
			EndIf

			END REPORT QUERY oTitSel//

			nAux := 0
			 oTitSel:Init()
		    (cAlsFO1)->(DbGoTop())
		    If (cAlsFO1)->(!EOF())
		    	oReport:PrintText(' ')
		    	oReport:PrintText(UPPER(STR0006))//Títulos negociados
		    	oReport:FatLine()	    
			    While (cAlsFO1)->(!EOF())        
			            		               						
			            oTitSel:PrintLine(.T.)
			            cNextP := '*' 
						nTotSel := nTotSel + (cAlsFO1)->FO1_TOTAL                
				    (cAlsFO1)->(DBSKIP())        
				EndDo  
				If nTotSel > 0
					oReport:FatLine()
					oReport:PrintText(' ')
					oReport:PrintText(STR0008 + Transform( nTotSel , "@E 9,999,999,999.99") )//Total Negociado
				EndIf
		    	oReport:PrintText(' ')
			endif
		    oTitSel:Finish()		        
		 
		   BEGIN REPORT QUERY oTitGer//Títulos gerados       
		
			BeginSql alias cAlsFO2
			   	SELECT 
					FO2_PREFIX,
					FO2_NUM,
					FO2_PARCEL,
					FO0_TIPO,
					FO2_VENCTO,
					FO2_VALOR,
					FO2_TXJUR,
					FO2_VLJUR,
					FO2_ACRESC,
					FO2_DECRES,
					FO2_TOTAL			
				FROM %table:FO2% FO2
				LEFT JOIN %table:FO0% FO0 ON
					FO0.FO0_FILIAL = FO2.FO2_FILIAL AND
					FO0.FO0_PROCES = FO2.FO2_PROCES AND
					FO0.FO0_VERSAO = FO2.FO2_VERSAO				
				WHERE
					FO2.FO2_FILIAL = %exp:cFili% AND
					FO2.FO2_PROCES = %exp:cProces%	AND
					FO2.FO2_VERSAO = %exp:cVersao%	AND	 					   			       			  
			       FO2.%NotDel%
				ORDER BY FO2.FO2_FILIAL	       
			     	
			EndSql
			
			END REPORT QUERY oTitGer
			 nTotGer := 0 
			 oTitGer:Init()
		    (cAlsFO2)->(DbGoTop())
		    If (cAlsFO2)->(!EOF())
			    oReport:PrintText(' ')
			    oReport:PrintText(UPPER(STR0007))//títulos a gerados
			    oReport:FatLine()
			    While (cAlsFO2)->(!EOF())//       
			            oTitGer:PrintLine(.T.) 
			            cNextP := '*' 
			            nTotGer := nTotGer + (cAlsFO2)->FO2_TOTAL	            
				    (cAlsFO2)->(DBSKIP())        
				ENDDO  
				If nTotGer > 0
					oReport:FatLine()
					oReport:PrintText(' ')
					oReport:PrintText(STR0009 + Transform( nTotGer , "@E 9,999,999,999.99") )//Total Recebido
				Endif
		    	oReport:PrintText(' ')
			Endif
		    oTitGer:Finish()
	    	        
		    (cAlsFO0)->(DBSKIP()) //Vai para o próximo processo.       
		ENDDO  
    	oCabec:Finish()			
	Endif
             
	oReport:IncMeter()  
Next nX

If Select(cAlsFO0) > 0
	(cAlsFO0)->(dbCloseArea())
Endif

If Select(cAlsFO1) > 0
	(cAlsFO1)->(dbCloseArea())
Endif

If Select(cAlsFO2) > 0
	(cAlsFO2)->(dbCloseArea())
Endif

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} GetXMoeda

Função que retorna a descrição da moeda para o relatório.

@param nMoeda Código da Moeda
@return cRet String contendo o código + descrição da moeda
@author Diego Santos
@since 03/12/2015
@version P12
/*/
//-------------------------------------------------------------------

Static Function GetXMoeda ( nMoeda )

Local cRet := ""

If nMoeda == 1
	cRet := CvalToChar(nMoeda) + " - " + GetMv("MV_MOEDA1") 
ElseIf nMoeda == 2
	cRet := CvalToChar(nMoeda) + " - " + GetMv("MV_MOEDA2")
ElseIf nMoeda == 3
	cRet := CvalToChar(nMoeda) + " - " + GetMv("MV_MOEDA3")
ElseIf nMoeda == 4
	cRet := CvalToChar(nMoeda) + " - " + GetMv("MV_MOEDA4")
ElseIf nMoeda == 5
	cRet := CvalToChar(nMoeda) + " - " + GetMv("MV_MOEDA5")
EndIf

Return cRet
