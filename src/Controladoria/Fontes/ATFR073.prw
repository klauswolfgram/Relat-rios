/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "ATFR073.CH"  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATFR073   บAutor  ณAlvaro Camillo Neto บ Data ณ  04/04/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relat๓rio de Posi็ใo Valorizada 12 meses                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR073()
Local oReport
Local lTReport	:= TRepInUse()
Local lDefTop 	:= IfDefTopCTB() // verificar se pode executar query (TOPCONN)
//Inicializa็ใo das variแveis Private do Relat๓rio
Private aSelFil		:= {}
Private aSelClass	:= {}
Private lTodasFil	:= .F.
Private cPerg   	:= "AFR073"
Private aPeriodo 	:= {}

If !lDefTop
	Help("  ",1,"AFR073TOP",,STR0001 ,1,0) //"Fun็ใo disponํvel apenas para ambientes TopConnect"
	Return
EndIf

If !lTReport
	Help("  ",1,"AFR073R4",,STR0002,1,0)//"Fun็ใo disponํvel apenas TREPORT"
	Return
ENdIf

lRet := Pergunte( cPerg , .T. )


If lRet
	If mv_par20 == 1 .And. Len( aSelFil ) <= 0
		aSelFil := AdmGetFil(@lTodasFil)
		If Len( aSelFil ) <= 0
			Return
		EndIf
	EndIf
	
	If MV_PAR22 <=0 .Or. MV_PAR22 > AtfMoedas()
		Help("  ",1,"AFR073MOE",,STR0003,1,0)//"Moeda nใo cadastrada no Sistema"
		Return
	EndIf 
	
	If !VldTpSald( MV_PAR24, .T. )
		Return
	EndIf
	
	If MV_PAR02 != FirstDay(MV_PAR02) .Or. MV_PAR03 != LastDay(MV_PAR03)
		Help("  ",1,"AFR073DT",,STR0005,1,0)//"A data inicial deve ser o primeiro dia de um m๊s e a data final deve ser o ultimo dia de um m๊s"
		Return
	Else
		aPeriodo := AFR073Per(MV_PAR02,MV_PAR03)
		If Len(aPeriodo) < 2 .Or. Len(aPeriodo)  > 12
			Help("  ",1,"AFR073PER",,STR0006,1,0)//"O intervalo mํnimo de datas sใo 2 meses e o perํodo mแximo 12 meses "
			Return
		EndIf
	EndIf 
	
	//Seleciona as classifica็๕es patrimoniais 
	If MV_PAR25 == 1 .And. Len( aSelClass ) <= 0
		aSelClass := AdmGetClas()
		If Len( aSelClass ) <= 0
			Return
		EndIf 
	EndIf
	
	oReport := ReportDef()
	oReport:PrintDialog()
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณAlvaro Camillo Neto บ Data ณ  23/09/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo de layout do relat๓rio analํtico                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()
Local oReport
Local oSecBem
Local oSecValores
Local oSecItem
Local oTotBem
Local oTotFilial
Local oTotRelat
Local cReport  := "ATFR073"
Local cTitulo  :=	OemToAnsi(STR0007)//"Posicao Valorizada dos Bens - 12 Meses"
Local cDescri  :=	OemToAnsi(STR0008) + " " + OemToAnsi(STR0009) + " "   	//"Este programa irแ  emitir a posi็ใo valorizada dos"##"bens em at้ 12 perํodos"
Local aOrd	   := {}
Local bReport  := {|| }
Local cCpoAux  := ""
Local cDescAux := ""
Local cMesAux  := ""
Local nPeriodo := 0
Local cComple  :=  STR0010+ Dtoc(MV_PAR02) + STR0011+ Dtoc(MV_PAR03) +STR0012 + GetMv("MV_MOEDA" + cValtoChar(MV_PAR22))//" Perํodo "##" a "##" na Moeda "
Local nTipoRel		:= MV_PAR01

bReport := { |oReport|	oReport:SetTitle( oReport:Title() + IIF( MV_PAR01 == 1, STR0013,STR0014 ) + cComple ), AF73Print( oReport ) }//" Analํtico."##" Sint้tico."

oReport  := TReport():New( cReport, cTitulo, cPerg, bReport, cDescri )

oSecBem := TRSection():New( oReport,  STR0015 )//"Dados do Bem"
TRCell():New( oSecBem, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_CBASE"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N3_ITEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
TRCell():New( oSecBem, "N1_CHAPA"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecBem, "N1_PATRIM"	, "SN1", /*X3Titulo*/, /*Picture*/, 15 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
TRCell():New( oSecBem, "N1_AQUISIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If nTipoRel == 1
	oSecBem:SetHeaderPage(.T.)
EndIf

oSecItem := TRSection():New( oReport, STR0016) // "Perํodos"
TRCell():New( oSecItem, "N3_TIPO"		, "SN3", /*X3Titulo*/, /*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecItem, "N3_TPDEPR"		, "SN3", /*X3Titulo*/, /*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecItem, "N3_TPSALDO"	, "SN3", /*X3Titulo*/, /*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSecItem, "N3_CCONTAB"	, "SN3", STR0017, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Conta Contแbil"
TRCell():New( oSecItem, "N3_CUSTBEM"	, "SN3", STR0018, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Centro de Custo"
TRCell():New( oSecItem, "N3_SUBCCON"	, "SN3", STR0019, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Item Contแbil"
TRCell():New( oSecItem, "N3_CLVLCON"	, "SN3", STR0045, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)//"Classe de Valor"
If nTipoRel == 1
	oSecItem:SetHeaderPage(.T.)
EndIf
//Se็ใo dos perํodos
oSecValores := TRSection():New( oReport, STR0020) // "Valores"
TRCell():New( oSecValores, "VL"		, "", "-", /*Picture*/, 2 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,0,.T.)
//   New(oParent,cName,cAlias,cTitle,cPicture,nSize,lPixel,bBlock,cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)

//Cria็ใo dos campos de perํodo
For nPeriodo := 1 to Len(aPeriodo)
	cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
	cMesAux  := Alltrim( MesExtenso( Month(aPeriodo[nPeriodo][2]) ) )
	cDescAux := Left(cMesAux,3) + "/"+cValToChar(Year(aPeriodo[nPeriodo][2]))
	TRCell():New( oSecValores, cCpoAux , "", cDescAux, PesqPict("SN3","N3_VORIG1" ,19,1) /*Picture*/, 19 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,0,.T.)
	oSecValores:Cell(cCpoAux):SetHeaderAlign("RIGHT")
Next nX
oSecValores:SetHeaderPage(.T.)

oTotItem  := TRSection():New( oReport, STR0021 ) // "Texto Total Geral"
TRCell():New( oTotItem, "TEXTO"	, "", ""  /*X3Titulo*/, "" /*Picture*/, 30 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotItem, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotItem, "N3_CBASE"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotItem, "N3_ITEM"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If nTipoRel == 1
	oTotItem:SetHeaderSection(.F.) 
Else
	oTotItem:SetHeaderPage(.T.)
EndIf
oTotItem:SetLeftMargin(7)

oTotBem  := TRSection():New( oReport, STR0022 ) // "Texto Total Geral"
TRCell():New( oTotBem, "TEXTO"	, "", ""  /*X3Titulo*/, "" /*Picture*/, 30 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotBem, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotBem, "N3_CBASE"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotBem, "N1_DESCRIC"	, "SN1", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/,,.T.,,,,.T.)
oTotBem:SetHeaderSection(.F.)
oTotBem:SetLeftMargin(7)

oTotFilial  := TRSection():New( oReport, STR0023 ) // "Texto Total Geral"
TRCell():New( oTotFilial, "TEXTO"	, "", ""  /*X3Titulo*/, "" /*Picture*/, 30 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotFilial, "N3_FILIAL"	, "SN3", /*X3Titulo*/, /*Picture*/, /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotFilial, "M0_FILIAL"	, "SM0", /*X3Titulo*/, /*Picture*/, 200/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oTotFilial:SetHeaderSection(.F.)
oTotFilial:SetLeftMargin(7)

oTotRelat  := TRSection():New( oReport, STR0024 ) // "Total Geral Relatorio"
TRCell():New( oTotRelat, "TEXTO"	, "", ""  /*X3Titulo*/, "" /*Picture*/, 30 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
oTotRelat:SetHeaderSection(.F.)
oTotRelat:SetLeftMargin(7)

oSecValores:SetColSpace(0)
oReport:SetLandScape()
oReport:DisableOrientation()
oReport:ParamReadOnly()

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAF73Print บAutor  ณMicrosiga           บ Data ณ  04/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de impressใo do relat๓rio                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AF73Print( oReport )
Local oSecBem		:= oReport:Section(1)
Local oSecItem		:= oReport:Section(2)
Local oSecValores	:= oReport:Section(3)
Local oTotItem		:= oReport:Section(4)
Local oTotBem		:= oReport:Section(5)
Local oTotFilial	:= oReport:Section(6)
Local oTotRelat		:= oReport:Section(7)


Local oMeter
Local oText
Local oDlg
Local lEnd
Local cAliasQry 	:= GetNextAlias()
Local nTipoRel		:= MV_PAR01
Local cGrupoIni		:= MV_PAR04
Local cGrupoFim		:= MV_PAR05
Local cBemIni   	:= MV_PAR06
Local cItemIni  	:= MV_PAR07
Local cBemFim   	:= MV_PAR08
Local cItemFim  	:= MV_PAR09
Local dAquIni		:= MV_PAR10
Local dAquFim   	:= MV_PAR11
Local cContaIni 	:= MV_PAR12
Local cContaFim 	:= MV_PAR13
Local cCCIni   		:= MV_PAR14
Local cCCFim   		:= MV_PAR15
Local cItCtbIni		:= MV_PAR16
Local cItCtbFim		:= MV_PAR17
Local cClvlIni		:= MV_PAR18
Local cClVlFim		:= MV_PAR19
Local nTipoTotal	:= MV_PAR21
Local cMoeda		:= StrZero(MV_PAR22,2)
Local nEntidade		:= MV_PAR23
Local cTipoSLD		:= MV_PAR24
Local aTipo			:= {}
Local cDescTipo		:= ""
Local cDescSld 		:= ""
Local cTipDepr 		:= ""
Local cDescMet		:= ""
Local nPeriodo		:= 0
Local nValor        := 0
Local aValores 	 	:= {}
Local aVlrOriginal 	:= {}
Local aDepMensal 	:= {}
Local aBaixa 		:= {}
Local aAmpliacao 	:= {}
Local aDepAcm		:= {}
Local aResid		:= {}
/* projeto argentina */
Local aCorrMens		:= {}
Local aCorrAcum		:= {}
Local aCorDepAcum	:= {}
Local aCorDepMen	:= {}
Local lCalcCorr		:= .F.
/* projeto argentina */
Local cTipo 		:= ""
Local cTpSaldo		:=""
Local cFilBem		:= ""
Local cCodBase		:= ""
Local cItem 		:= ""
Local cMoedaBem		:= ""
Local aTBemFis		:= Array(Len(aPeriodo))
Local aTBemGer		:= Array(Len(aPeriodo))
Local aTBemInc		:= Array(Len(aPeriodo))
Local aTItemFis		:= Array(Len(aPeriodo))
Local aTItemGer		:= Array(Len(aPeriodo))
Local aTItemInc		:= Array(Len(aPeriodo))
Local aTFilFis		:= Array(Len(aPeriodo))
Local aTFilGer		:= Array(Len(aPeriodo))
Local aTFilInc		:= Array(Len(aPeriodo))
Local aTRelFis		:= Array(Len(aPeriodo))
Local aTRelGer		:= Array(Len(aPeriodo))
Local aTRelInc		:= Array(Len(aPeriodo))
Local cTipoFiscal	:= ATFXTpBem(1)
Local cTipoGerenc   := ATFXTpBem(2)
Local cTipoIncent	:= ATFXTpBem(3)
Local nPerValor		:= 0
Local lRealProv	:= .F.

Local aValorPer		:= {}			//-- JRJ # 20170919-A 
Local cCpoAux		:= ""			//-- JRJ # 20170919-B	

If nTipoTotal == 1 //Fiscal
	aTipo := ATFXTpBem(1,.T.)
ElseIf nTipoTotal == 2 //Gerencial
	aTipo := ATFXTpBem(2,.T.)
ElseIf nTipoTotal == 3 //Incentivada
	aTipo := ATFXTpBem(3,.T.)
EndIf

/*
 * Verifica็ใo do campo para ativos de custo de provisใo
 */
If Select("SN3") == 0
	DbSelectArea("SN3")
EndIf
lRealProv :=  MV_PAR26 == 2

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta Arquivo Temporario para Impressao						 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
ATFGERCOMP(oMeter,oText,oDlg,lEnd,cAliasQry,dAquIni,dAquFim,aPeriodo,cBemIni,cBemFim,cItemIni,cItemFim,cContaIni,cContaFim,;
cCCIni,cCCFim,cItCtbIni,cItCtbFim,cClvlIni,cClVlFim,cGrupoIni,cGrupoFim,cMoeda,aSelFil,lTodasFil,Nil,Nil,aTipo,Nil,Nil,nEntidade,cTipoSLD,aSelClass,lRealProv) },;
OemToAnsi(OemToAnsi(STR0026)),;//"Criando Arquivo Temporแrio..."
OemToAnsi(STR0027))//"Posicao Valorizada dos Bens 12 Meses"

// Orderna de acordo com a Ordem do relatorio
(cAliasQry)->(dbGoTop())
If (cAliasQry)->(EOF())
	Help("  ",1,"AFR073NOD",,STR0028,1,0)//"Nใo hแ dados, verificar parametros do relat๓rio"
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ฟ
//ณEstrutura do Arquivoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ู
/*
FILIAL CBASE ITEM MOEDA CLASSIF TIPO DESC_SINT AQUISIC DTBAIXA DTINIPER DTFIMPER PERIODO CHAPA GRUPO CONTA CCUSTO SUBCTA CLVL SEQ SEQREAV FLAGBAIXA TPSALDO QUANTD
ORIGINAL AMPLIACAO ATUALIZ DEPRECACM DEPRECMES	RESIDUAL CORRECACM CORDEPACM VLBAIXAS
*/

//Impressใo da folha de Legenda
AFR073LEG(oReport)
                  
lCalcCorr := ((GetNewPar( "MV_CORREC", "N" ) == "S") .And. cPaisLoc $ "ARG|CHI")

aFill(aTRelFis,0)
aFill(aTRelGer,0)
aFill(aTRelInc,0)

While (cAliasQry)->(!EOF()) .And. !oReport:Cancel()
	//Dados do Bem
	cFilBem	:= (cAliasQry)->FILIAL
	aFill(aTFilFis,0)
	aFill(aTFilGer,0)
	aFill(aTFilInc,0)
	While (cAliasQry)->(!EOF()) .And. (cAliasQry)->(FILIAL) == cFilBem .And. !oReport:Cancel()
		cCodBase:= (cAliasQry)->CBASE
		cDescr	:= (cAliasQry)->DESC_SINT
		aFill(aTBemFis,0)
		aFill(aTBemGer,0)
		aFill(aTBemInc,0)
		
		While (cAliasQry)->(!EOF()) .And. (cAliasQry)->(FILIAL+CBASE) == cFilBem+cCodBase .And. !oReport:Cancel()
			If nTipoRel == 1 // Analitico
				oSecBem:Init()
				oSecBem:Cell("N3_FILIAL"):SetValue( (cAliasQry)->FILIAL  )
				oSecBem:Cell("N3_CBASE"):SetValue( (cAliasQry)->CBASE  )
				oSecBem:Cell("N3_ITEM"):SetValue( (cAliasQry)->ITEM  )
				oSecBem:Cell("N1_PATRIM"):SetValue( X3COMBO('N1_PATRIM',(cAliasQry)->CLASSIF)    )
				oSecBem:Cell("N1_DESCRIC"):SetValue((cAliasQry)->DESC_SINT  )
				oSecBem:Cell("N1_AQUISIC"):SetValue( (cAliasQry)->AQUISIC  )
				oSecBem:Cell("N1_CHAPA"):SetValue( (cAliasQry)->CHAPA  )
				oSecBem:PrintLine()
				oSecBem:Finish()
			EndIf
			
			cItem 	:= (cAliasQry)->ITEM
			aFill(aTItemFis,0)
			aFill(aTItemGer,0)
			aFill(aTItemInc,0)
			
			While (cAliasQry)->(!EOF()) .And. (cAliasQry)->(FILIAL+CBASE+ITEM) == cFilBem+cCodBase+cItem .And. !oReport:Cancel()
				aValores 	 := {}
				aVlrOriginal := {}
				aDepMensal 	 := {}
				aBaixa 		 := {}
				aAmpliacao 	 := {}
				aDepAcm		 := {}
				aResid		 := {}
				/* projeto argentina */
				aCorrMens	 := {}
				aCorrAcum 	 := {}
				aCorDepAcum	 := {}
				aCorDepMen	 := {}
				/* projeto argentina */
				
				cTipo 	:= (cAliasQry)->TIPO
				cMoedaBem	:= (cAliasQry)->MOEDA
				cTpSaldo:= (cAliasQry)->TPSALDO
				cSeq	:= (cAliasQry)->SEQ
				cSeqReav:= (cAliasQry)->SEQREAV
				If nTipoRel == 1 // Analitico
					SX5->(MsSeek(xFilial("SX5") + "G1"+ (cAliasQry)->TIPO ))
					cDescTipo := Alltrim(SX5->(X5Descri()))
					SX5->(MsSeek(xFilial("SX5") + "SL"+ IIF(Empty(cTpSaldo),'1',cTpSaldo) ))
					cDescSld := Alltrim(SX5->(X5Descri()))
					cTipDepr := IIF(Empty((cAliasQry)->TPDEPR), '1', (cAliasQry)->TPDEPR)
					cDescMet := AllTrim(GetAdvFVal("SN0","N0_DESC01", xFilial("SN0") +'04'+ cTipDepr ,1))
					
					oSecItem:Init()
					oSecItem:Cell("N3_TIPO"):SetValue( AllTrim((cAliasQry)->TIPO) + " - " + cDescTipo )
					oSecItem:Cell("N3_TPDEPR"):SetValue(cTipDepr +" - " + cDescMet  )
					oSecItem:Cell("N3_TPSALDO"):SetValue(cTpSaldo +" - "+ cDescSld )
					oSecItem:Cell("N3_CCONTAB"):SetValue( (cAliasQry)->CONTA  )
					oSecItem:Cell("N3_CUSTBEM"):SetValue((cAliasQry)->CCUSTO  )
					oSecItem:Cell("N3_SUBCCON"):SetValue((cAliasQry)->SUBCTA  )
					oSecItem:Cell("N3_CLVLCON"):SetValue((cAliasQry)->CLVL  )
					oSecItem:PrintLine()
					oSecItem:Finish()
				EndIf

				While (cAliasQry)->(!EOF()) .And. (cAliasQry)->(FILIAL+CBASE+ITEM+TIPO+MOEDA+TPSALDO+SEQ+SEQREAV) == cFilBem+cCodBase+cItem+cTipo+cMoedaBem+cTpSaldo+cSeq+cSeqReav .And. !oReport:Cancel()
					nPerValor 		 := Val((cAliasQry)->PERIODO)
					aAdd(aVlrOriginal,(cAliasQry)->ORIGINAL )
					aAdd(aDepMensal	 ,(cAliasQry)->DEPRECMES )
					aAdd(aBaixa		 ,(cAliasQry)->VLBAIXAS  )
					aAdd(aAmpliacao  ,(cAliasQry)->AMPLIACAO )
					aAdd(aDepAcm	 ,(cAliasQry)->DEPRECACM )
					aAdd(aResid		 ,(cAliasQry)->RESIDUAL  )
					/* projeto argentina */
					If lCalcCorr
						Aadd(aCorrMens	 ,(cAliasQry)->CORREMENS )
						Aadd(aCorrAcum	 ,(cAliasQry)->CORRECACM )
						Aadd(aCorDepMen  ,(cAliasQry)->CORDEPMEN )
						Aadd(aCorDepAcum ,(cAliasQry)->CORDEPACM )
					Endif
					/* projeto argentina */

					If Alltrim((cAliasQry)->TIPO)  $ cTipoFiscal
						If Alltrim( (cAliasQry)->TIPO ) == '05' // Reavalia็ใo Negativa
							aTItemFis[nPerValor]		-= (cAliasQry)->RESIDUAL
							aTBemFis[nPerValor]		-= (cAliasQry)->RESIDUAL
							aTFilFis[nPerValor]		-= (cAliasQry)->RESIDUAL
							aTRelFis[nPerValor]		-= (cAliasQry)->RESIDUAL
						Else
							aTItemFis[nPerValor]		+= (cAliasQry)->RESIDUAL
							aTBemFis[nPerValor]		+= (cAliasQry)->RESIDUAL
							aTFilFis[nPerValor]		+= (cAliasQry)->RESIDUAL
							aTRelFis[nPerValor]		+= (cAliasQry)->RESIDUAL
						EndIf
					ElseIf Alltrim((cAliasQry)->TIPO)  $ cTipoGerenc
						aTItemGer[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTBemGer[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTFilGer[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTRelGer[nPerValor]		+= (cAliasQry)->RESIDUAL
					ElseIf Alltrim((cAliasQry)->TIPO)  $ cTipoIncent
						aTItemInc[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTBemInc[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTFilInc[nPerValor]		+= (cAliasQry)->RESIDUAL
						aTRelInc[nPerValor]		+= (cAliasQry)->RESIDUAL
					EndIf
					
					(cAliasQry)->(dbSkip())
				EndDo
				/* projeto argentina */
				If lCalcCorr
	 				aValores := {aVlrOriginal,aDepMensal,aBaixa,aAmpliacao,aDepAcm,aCorrMens,aCorrAcum,aCorDepMen,aCorDepAcum,aResid}
	 			Else
	 				aValores := {aVlrOriginal,aDepMensal,aBaixa,aAmpliacao,aDepAcm,aResid}
	 			Endif
				/* projeto argentina */
				If nTipoRel == 1 // Analitico
					For nValor:= 1 to Len(aValores)
						oSecValores:Init()
						aValorPer := aValores[nValor]
						oSecValores:Cell("VL"):SetValue( cValtoChar(nValor) )
						For nPeriodo := 1 to Len(aValorPer)
							cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
							oSecValores:Cell(cCpoAux):SetValue(aValorPer[nPeriodo])
						Next nPeriodo
						oSecValores:PrintLine()
						oSecValores:Finish()
					Next nValor
				EndIf
			EndDo
			
			//Totalizador por Item do Bem
			If nTipoRel == 1 // Analitico
				If (cAliasQry)->(FILIAL+CBASE+ITEM) != cFilBem+cCodBase+cItem
					oReport:SkipLine()
					oReport:ThinLine()
					
					oTotItem:Init()
					oTotItem:Cell("TEXTO"):SetValue(STR0029)//"Total Residual do Item do Bem "
					oTotItem:Cell("N3_FILIAL"):SetValue( cFilBem  )
					oTotItem:Cell("N3_CBASE"):SetValue( cCodBase )
					oTotItem:Cell("N3_ITEM"):SetValue( cItem  )
					oTotItem:PrintLine()
					oTotItem:Finish()
					
					For nValor:= 1 to 3
						aValorPer := {}
						
						If nValor == 1 .And.(nTipoTotal == 1 .Or. nTipoTotal == 4) //Fiscal
							aValorPer := aTItemFis
							cTotVL	  := "F"
						ElseIf nValor == 2 .And. (nTipoTotal == 2 .Or. nTipoTotal == 4) //Gerencial
							aValorPer := aTItemGer
							cTotVL	  := "G"
						ElseIf nValor == 3 .And. (nTipoTotal == 3 .Or. nTipoTotal == 4) //Incentivada
							aValorPer := aTItemInc
							cTotVL	  := "I"
						EndIf
						
						If !Empty(aValorPer)
							oSecValores:Init()
							oSecValores:Cell("VL"):SetValue( cTotVL )
							For nPeriodo := 1 to Len(aValorPer)
								cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
								oSecValores:Cell(cCpoAux):SetValue(aValorPer[nPeriodo])
							Next nPeriodo
							oSecValores:PrintLine()
							oSecValores:Finish()
						EndIf
					Next nValor
					oReport:SkipLine()
					oReport:ThinLine()
				EndIf
			EndIf
		EndDo
		//Totalizador por CBASE
		If (cAliasQry)->(FILIAL+CBASE) != cFilBem+cCodBase
			oTotBem:Init()
			oTotBem:Cell("TEXTO"):SetValue(STR0030)//"Total Residual do C๓digo Base"
			oTotBem:Cell("N3_FILIAL"):SetValue( cFilBem  )
			oTotBem:Cell("N3_CBASE"):SetValue( cCodBase )
			oTotBem:Cell("N1_DESCRIC"):SetValue( cDescr )
			oTotBem:PrintLine()
			oTotBem:Finish()
			
			For nValor:= 1 to 3
				aValorPer := {}
				
				If nValor == 1 .And.(nTipoTotal == 1 .Or. nTipoTotal == 4) //Fiscal
					aValorPer := aTBemFis
					cTotVL	  := "F"
				ElseIf nValor == 2 .And. (nTipoTotal == 2 .Or. nTipoTotal == 4) //Gerencial
					aValorPer := aTBemGer
					cTotVL	  := "G"
				ElseIf nValor == 3 .And. (nTipoTotal == 3 .Or. nTipoTotal == 4) //Incentivada
					aValorPer := aTBemInc
					cTotVL	  := "I"
				EndIf
				
				If !Empty(aValorPer)
					oSecValores:Init()
					oSecValores:Cell("VL"):SetValue( cTotVL )
					For nPeriodo := 1 to Len(aValorPer)
						cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
						oSecValores:Cell(cCpoAux):SetValue(aValorPer[nPeriodo])
					Next nPeriodo
					oSecValores:PrintLine()
					oSecValores:Finish()
				EndIf
			Next nValor
			oReport:SkipLine()
			oReport:ThinLine()
		EndIf
	EndDo
	//Totalizador por Filial
	If (cAliasQry)->(FILIAL) != cFilBem
		cDescrFil:= GetAdvFval("SM0","M0_FILIAL",cEmpAnt + cFilBem )
		oTotFilial:Init()
		oTotFilial:Cell("TEXTO"):SetValue(STR0031)//"Total Residual da Filial "
		oTotFilial:Cell("N3_FILIAL"):SetValue( cFilBem  )
		oTotFilial:Cell("M0_FILIAL"):SetValue( cDescrFil )
		oTotFilial:PrintLine()
		oTotFilial:Finish()
		
		For nValor:= 1 to 3
			aValorPer := {}
			
			If nValor == 1 .And.(nTipoTotal == 1 .Or. nTipoTotal == 4) //Fiscal
				aValorPer := aTFilFis
				cTotVL	  := "F"
			ElseIf nValor == 2 .And. (nTipoTotal == 2 .Or. nTipoTotal == 4) //Gerencial
				aValorPer := aTFilGer
				cTotVL	  := "G"
			ElseIf nValor == 3 .And. (nTipoTotal == 3 .Or. nTipoTotal == 4) //Incentivada
				aValorPer := aTFilInc
				cTotVL	  := "I"
			EndIf
			
			If !Empty(aValorPer)
				oSecValores:Init()
				oSecValores:Cell("VL"):SetValue( cTotVL )
				For nPeriodo := 1 to Len(aValorPer)
					cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
					oSecValores:Cell(cCpoAux):SetValue(aValorPer[nPeriodo])
				Next nPeriodo
				oSecValores:PrintLine()
				oSecValores:Finish()
			EndIf
		Next nValor
		oReport:SkipLine()
		oReport:ThinLine()
	EndIf
EndDo

//Totalizador
oTotRelat:Init()
oTotRelat:Cell("TEXTO"):SetValue(STR0032)//"Total Residual do Relat๓rio "
oTotRelat:PrintLine()
oTotRelat:Finish()

For nValor:= 1 to 3
	aValorPer := {}
	
	If nValor == 1 .And.(nTipoTotal == 1 .Or. nTipoTotal == 4) //Fiscal
		aValorPer := aTRelFis
		cTotVL	  := "F"
	ElseIf nValor == 2 .And. (nTipoTotal == 2 .Or. nTipoTotal == 4) //Gerencial
		aValorPer := aTRelGer
		cTotVL	  := "G"
	ElseIf nValor == 3 .And. (nTipoTotal == 3 .Or. nTipoTotal == 4) //Incentivada
		aValorPer := aTRelInc
		cTotVL	  := "I"
	EndIf
	
	If !Empty(aValorPer)
		oSecValores:Init()
		oSecValores:Cell("VL"):SetValue( cTotVL )
		For nPeriodo := 1 to Len(aValorPer)
			cCpoAux  := "VLPER" + STRZERO(nPeriodo,2)
			oSecValores:Cell(cCpoAux):SetValue(aValorPer[nPeriodo])
		Next nPeriodo
		oSecValores:PrintLine()
		oSecValores:Finish()
	EndIf
Next nValor
oReport:SkipLine()
oReport:ThinLine()


(cAliasQry)->(dbCloseArea())
MSErase(cAliasQry)

Return
      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR073LEG บAutor  ณMicrosiga           บ Data ณ  04/11/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime folha de legenda                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AFR073LEG(oReport)

oReport:SkipLine()
oReport:SkipLine()
oReport:SkipLine()

oReport:PrintText( STR0033 )//"Abrevia็๕es do Relat๓rio :"

oReport:SkipLine()
oReport:ThinLine()

If MV_PAR01 == 1
	oReport:PrintText(STR0034 )// "Legenda da se็ใo de valores :"
	
	oReport:PrintText( STR0035 )//"1 - Valor Original "
	oReport:PrintText(STR0036  )//"2 - Deprecia็ใo Mensal "
	oReport:PrintText( STR0037 )//"3 - Baixa "
	oReport:PrintText( STR0038 )//"4 - Amplia็ใo "
	oReport:PrintText( STR0039 )//"5 - Deprecia็ใo Acumulada "
	If (GetNewPar( "MV_CORREC", "N" ) == "S") .And. cPaisLoc $ "ARG|CHI"
		oReport:PrintText( STR0046 )		//"6 - Corre็ใo mensal"
		oReport:PrintText( STR0047 )		//"7 - Corre็ใo acumulada"
		oReport:PrintText( STR0048 )		//"8 - Corre็ใo mensal da deprecia็ใo"
		oReport:PrintText( STR0049 )		//"9 - Corre็ใo acumulada da deprecia็ใo"
		oReport:PrintText( "10- " + AllTrim(STR0040))	//"Valor Residual do Bem"
	Else
		oReport:PrintText( "6 - " + AllTrim(STR0040))	//"Valor Residual do Bem"
	Endif
	oReport:SkipLine()
	oReport:ThinLine()
EndIf

oReport:PrintText( STR0041 )//"Legenda da se็ใo de totais :"
oReport:PrintText( STR0042 )//"F - Valor residual Fiscal "
oReport:PrintText(STR0043  )// "G - Valor residual Gerencial "
oReport:PrintText( STR0044 )//"I - Valor residual Incentivado"

oReport:SkipLine()
oReport:ThinLine()

oReport:EndPage()
oReport:StartPage()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAFR073Per บAutor  ณAlvaro Camillo Neto บ Data ณ  04/04/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AFR073Per(dDataIni,dDataFim)
Local aPeriodo := {}
Local dDataAux := FirstDay(dDataIni)

While dDataAux <= LastDay(dDataFim)
	aAdd(aPeriodo,{FirstDay(dDataAux),LastDay(dDataAux)})
	dDataAux := LastDay(dDataAux)+1
EndDo

Return aPeriodo
