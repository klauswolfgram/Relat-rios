/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR025.CH"
#INCLUDE "PROTHEUS.CH"

//-------------------------------------------------------------------
/*{Protheus.doc} CTBR025
 Relatório do Plano Referencial
@author Simone Mie Sato Kakinoana
   
@version P12
@since   19/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
User Function CTBR025()

Local oReport
Local lTReport	:= TRepInUse()

Local aCtbMoeddesc	:= {}

Private cPerg1		:= "CTBR025"
Private cPerg2		:= "CTBPLREF"
Private cPlanoRef	:= ""							//Cod. Plano Referencial
Private cVersao		:= ""							//Versão
Private cCtaRef		:= ""							//Contas a serem impressas
Private nTpRel		:= 1							//Tipo do relatório: 1= Cadastro 2=Relacionamento
Private nImpCta		:= 1							//Imprime: 1=Analíticas; 2-Sintéticas;3=Ambas 
Private lPulaSint	:= .T.							//1=Pula linha sintetica; 2=Não pula linha sintetica
Private lSoCtaRel 	:= .T.							//1=Mostra só conta com relacionamento;2=Mostra todas as contas
Private cMoeda		:= ""							//Descrição em qual moeda?

Private cAliasCVN	:= GetNextAlias()

If !lTReport
	Help("  ",1,"CTR025R4",,STR0006,1,0) //"Função disponível apenas TReport, verificar parametro MV_TREPORT"
	Return
EndIf

If Pergunte(cPerg1, .T.)

	If Empty( mv_par07 )
		Help(" ",1,"NOMOEDA")
		Return
	EndIf
	
	aCtbMoeddesc := CtbMoeda(mv_par07) // Moeda?

	 If Empty( aCtbMoeddesc[1] )
		Help(" ",1,"NOMOEDA")
		aCtbMoeddesc := nil
	    Return
	Endif	

	cPlanoRef	:= mv_par01						//Cod. Plano Referencial
	cVersao		:= mv_par02						//Versão
	nTpRel		:= mv_par03						//Tipo do relatório: 1= Cadastro 2=Relacionamento
	nImpCta		:= mv_par04						//Imprime: 1=Analíticas; 2-Sintéticas;3=Ambas 
	lPulaSint	:= Iif(mv_par05 == 1,.T.,.F.)	//1=Pula linha sintetica; 2=Não pula linha sintetica
	lSoCtaRel 	:= Iif(mv_par06 == 1,.T.,.F.)	//1=Mostra só conta com relacionamento;2=Mostra todas as contas
	cMoeda		:= mv_par07						//Descrição em qual moeda?
    
	Pergunte(cPerg2,.T.)	//Exibe a pergunta de Intervalo de Contas
	
	oReport := ReportDef()
	
	If ValType( oReport ) == "O"
	
		If ! Empty( oReport:uParam )
			Pergunte( oReport:uParam, .F. )
		EndIf	
		
		oReport :PrintDialog()
	Endif	
	
	oReport := Nil
EndIf

If Select(cAliasCVN) > 0
	dbSelectArea(cAliasCVN)
	DbCloseArea()
EndIf


Return                                

//-------------------------------------------------------------------
/*{Protheus.doc} ReportDef
Esta funcao tem como objetivo definir as secoes, celulas,   
totalizadores do relatorio que poderao ser configurados    
pelo relatorio.                                   

@author Simone Mie Sato Kakinoana
   
@version P12
@since   19/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportDef()

Local aArea	   		:= GetArea()   
Local cReport		:= "CTBR025"
Local cTitulo		:= STR0001				   			// "Plano Rerefencial"
Local cDesc			:= STR0002							//"Este programa ira  imprimir o cadastro de plano de contas referencial e as contas do plano padrão associadas a ela.

Local oSection1
Local oSection2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= TReport():New( cReport,cTitulo,cPerg1, { |oReport| ReportPrint( oReport ) }, cDesc ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:ParamReadOnly()

oReport:SetUseGC(.F.) // Remove botão da gestão de empresas pois conflita com a pergunta "Seleciona Filiais"

oSection1  := TRSection():New( oReport, STR0001, {"CVN"}, , .F., .F. ) //"Plano Referencial"

TRCell():New( oSection1, "CVN_CODPLA"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
TRCell():New( oSection1, "CVN_VERSAO"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
TRCell():New( oSection1, "CVN_DSCPLA"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
TRCell():New( oSection1, "CVN_DTVIGI"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
TRCell():New( oSection1, "CVN_DTVIGF"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)

If nTpRel == 1
	oSection2 := TRSection():New(oReport,STR0003,{"CVN"})	//Contas
Else
	oSection2 := TRSection():New(oReport,STR0003,{"CVD","CT1"})	//Contas
Endif
oSection2:SetTotalInLine(.F.)

If nTpRel == 1 //Se for só cadastro, inibe as celulas de conta e descrição
	TRCell():New( oSection2, "CVN_CTAREF"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_DSCCTA"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_CLASSE"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_CTASUP"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
Else
	TRCell():New( oSection2, "CVN_CTAREF"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_DSCCTA"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_CLASSE"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CVN_CTASUP"	,"CVN" , /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)	
	TRCell():New( oSection2, "CVD_CONTA"	,"CVD" ,  /*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	TRCell():New( oSection2, "CT1_DESC"		,"CT1" , STR0007/*X3Titulo*/, /*cPicture*/, /*Tamanho*/,/*lPixel*/,/*bBlock*/,/*cAlign*/,/*lLineBreak*/.T.,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/.T.)
	   
	TRPosition():New( oSection2, "CT1", 1, {|| xFilial( "CT1" ) + (cAliasCVN)->CVD_CONTA })
	TRPosition():New( oSection2, "CVD", 2, {|| xFilial( "CVD" ) + (cAliasCVN)->CVN_CODPLA + (cAliasCVN)->CVN_CTAREF+(cAliasCVN)->CVD_CONTA+(cAliasCVN)->CVN_VERSAO })
	
Endif

oSection2:Cell("CVN_CLASSE"):SetSize(TamSX3("CVN_CLASSE")[1]+30)
oSection2:Cell("CVN_CTAREF"):SetHeaderAlign("LEFT")
oSection2:Cell("CVN_DSCCTA"):SetHeaderAlign("LEFT")                                                                
oSection2:Cell("CVN_CLASSE"):SetHeaderAlign("LEFT")
oSection2:Cell("CVN_CTASUP"):SetHeaderAlign("LEFT")

If nTpRel == 2 //Se imprime relacionamento
	oSection2:Cell("CVD_CONTA"):SetHeaderAlign("LEFT")
	oSection2:Cell("CT1_DESC"):SetHeaderAlign("LEFT")
Endif

oSection2:SetAutoSize()

Return(oReport)
//-------------------------------------------------------------------
/*{Protheus.doc} ReportPrint
Imprime o relatorio definido pelo usuario de acordo com as  
secoes/celulas criadas na funcao ReportDef definida acima. 
Nesta funcao deve ser criada a query das secoes se SQL ou  
definido o relacionamento e filtros das tabelas em CodeBase.

@author Simone Mie Sato Kakinoana
   
@version P12
@since   19/03/2015
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(2)

Local lFirst	:= .T.

Local cSelect	:= ""
Local cDesc		:= ""

cDesc := 'CT1_DESC' + cMoeda

cSelect	:= "%, ISNULL("+cDesc+",'') CT1_DESC%"

Pergunte(cPerg2,.F.)

MakeSqlExpr(cPerg2)

BEGIN REPORT QUERY oSection1
If nTpRel == 1	//Se imprime somente cadastro do plano referencial 
	BeginSql Alias cAliasCVN
		COLUMN CVN_DTVIGI AS DATE
		COLUMN CVN_DTVIGF AS DATE
		SELECT DISTINCT CVN_CODPLA, CVN_VERSAO, CVN_DSCPLA, CVN_CTAREF, CVN_CLASSE, CVN_DTVIGI, CVN_DTVIGF, CVN_DSCCTA, CVN_CTASUP
		FROM %table:CVN% CVN
		WHERE CVN.CVN_FILIAL = %xFilial:CVN% 
		AND CVN.CVN_CODPLA = %Exp:cPlanoRef%
		AND CVN.CVN_VERSAO = %Exp:cVersao%		
		AND CVN.%NotDel%
		ORDER BY CVN_CODPLA,CVN_VERSAO, CVN_CTAREF
	EndSql
Else	//Se imprime o cadastro e as contas do plano de contas relacionadas a elas
	If lSoCtaRel	//Se imprime somente conta com relacionamen
		BeginSql Alias cAliasCVN
			COLUMN CVN_DTVIGI AS DATE
			COLUMN CVN_DTVIGF AS DATE
			SELECT CVN_CODPLA, CVN_VERSAO, CVN_DSCPLA, CVN_CTAREF, CVN_CLASSE, CVN_DTVIGI, CVN_DTVIGF, CVN_DSCCTA, CVN_CTASUP,ISNULL(CVD_CONTA, '') CVD_CONTA
			%Exp:cSelect%
			FROM %table:CVN% CVN
			JOIN %table:CVD% CVD ON (CVD_FILIAL = %xFilial:CVD%  AND CVD_CODPLA = CVN_CODPLA AND CVN_VERSAO = CVD_VERSAO AND CVD_CTAREF = CVN_CTAREF AND  CVD.%NotDel% )
			JOIN %table:CT1% CT1 ON (CT1_FILIAL = %xFilial:CT1%  AND CVD_CONTA = CT1_CONTA  AND  CT1.%NotDel% ) 
			WHERE CVN.CVN_FILIAL = %xFilial:CVN% 
			AND CVN.CVN_CODPLA = %Exp:cPlanoRef%
			AND CVN.CVN_VERSAO = %Exp:cVersao%		
			AND CVN.%NotDel%
			ORDER BY CVN_CODPLA,CVN_VERSAO, CVN_CTAREF
		EndSql
	Else
		BeginSql Alias cAliasCVN
			COLUMN CVN_DTVIGI AS DATE
			COLUMN CVN_DTVIGF AS DATE
			SELECT CVN_CODPLA, CVN_VERSAO, CVN_DSCPLA, CVN_CTAREF, CVN_CLASSE, CVN_DTVIGI, CVN_DTVIGF, CVN_DSCCTA, CVN_CTASUP, ISNULL(CVD_CONTA, '') CVD_CONTA
			%Exp:cSelect%
			FROM %table:CVN% CVN
			LEFT JOIN %table:CVD% CVD ON (CVD_FILIAL = %xFilial:CVD%  AND CVD_CODPLA = CVN_CODPLA AND CVN_VERSAO = CVD_VERSAO AND CVD_CTAREF = CVN_CTAREF AND  CVD.%NotDel% )
			LEFT JOIN %table:CT1% CT1 ON (CT1_FILIAL = %xFilial:CT1%  AND CVD_CONTA = CT1_CONTA  AND  CT1.%NotDel% ) 
			WHERE CVN.CVN_FILIAL = %xFilial:CVN% 
			AND CVN.CVN_CODPLA = %Exp:cPlanoRef%
			AND CVN.CVN_VERSAO = %Exp:cVersao%		
			AND CVN.%NotDel%
			ORDER BY CVN_CODPLA,CVN_VERSAO, CVN_CTAREF
		EndSql
	EndIf
EndIf
END REPORT QUERY oSection1 PARAM MV_PAR01

Pergunte(cPerg1,.F.) 

DbSelectArea(cAliasCVN)
DbGotop()
While !Eof()

	If oReport:Cancel()
		Exit
	EndIf
	
	If ( nImpCta == 2 .And. (cAliasCVN)->CVN_CLASSE <> "1") .Or. ( nImpCta == 1 .And. (cAliasCVN)->CVN_CLASSE <> "2")
		DbSelectArea(cAliasCVN)
		DbSkip()
		Loop
	Endif
	
	oReport:IncMeter()
	oSection1:Init()
	
	If lFirst
		oSection1:Cell("CVN_CODPLA"):SetValue((cAliasCVN)->CVN_CODPLA)
		oSection1:Cell("CVN_VERSAO"):SetValue((cAliasCVN)->CVN_VERSAO)
		oSection1:Cell("CVN_DSCPLA"):SetValue((cAliasCVN)->CVN_DSCPLA)
		oSection1:Cell("CVN_DTVIGI"):SetValue((cAliasCVN)->CVN_DTVIGI)
		oSection1:Cell("CVN_DTVIGF"):SetValue((cAliasCVN)->CVN_DTVIGF)
		lFirst	:= .F.
		oSection1:PrintLine()
		oReport:SkipLine()
	    oSection1:Finish()
	    oSection2:Init()     	                   
		oSection2:Enable()
	
		
	Endif
		
	oSection2:Cell("CVN_CTAREF"):SetValue((cAliasCVN)->CVN_CTAREF)  
	oSection2:Cell("CVN_DSCCTA"):SetValue((cAliasCVN)->CVN_DSCCTA)
	If (cAliasCVN)->CVN_CLASSE == "1"						  	    		
		oSection2:Cell("CVN_CLASSE"):SetValue(STR0004)	//Sintética
	Else
		oSection2:Cell("CVN_CLASSE"):SetValue(STR0005)	//Analítica
	Endif
	oSection2:Cell("CVN_CTASUP"):SetValue((cAliasCVN)->CVN_CTASUP)
	If nTpRel == 2	//Se imprime relacionamento
		oSection2:Cell("CVD_CONTA"):SetValue((cAliasCVN)->CVD_CONTA)
		oSection2:Cell("CT1_DESC"):SetValue((cAliasCVN)->CT1_DESC)
	EndIf  		
	oSection2:PrintLine()
	
	DbSelectArea(cAliasCVN)
	DbSkip()
	If lPulaSint
		If  nImpCta == 3	//Tratamento para pular sintetica quando imprimir ambas		
			If (cAliasCVN)->CVN_CLASSE = "1"
				oReport:SkipLine()    	
			Endif
		ElseIf nImpCta == 2	//Se imprimir somente as sinteticas
			oReport:SkipLine()			 
		Endif
	Endif
	
End

oSection2:Finish()

Return