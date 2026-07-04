/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#DEFINE BOTTOMPAGE 60
#INCLUDE "FINR13X.CH"     
#INCLUDE "RPTDEF.CH"
#INCLUDE "PROTHEUS.CH"
/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ FINR13X  ณ Autor ณ Bruno Sobieski        ณ Data ณ 01.03.00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Cuenta corriente de Cliente                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ             ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Programadorณ DATA    ณ BOPS      ณ                  ALTERACAO         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   Bruno    ณ09.05.00 ณ  Melhor   ณConsiderar data de digitacao no     ณฑฑ
ฑฑณ            ณ         ณ           ณparametros.                         ณฑฑ
ฑฑณ   Rubens   ณ07.03.01 ณ  Melhor   ณAumento dos campos numericos do     ณฑฑ
ฑฑณ            ณ         ณ           ณarquivo temp. e da mascara na s     ณฑฑ
ฑฑณ            ณ         ณ           ณimpressao dos valore                ณฑฑ
ฑฑณ   Rubens   ณ20/04/01 ณ  Melhor   ณConsidera tambem as baixas manuais, ณฑฑ
ฑฑณ            ณ         ณ           ณjuros, multas e descontos.          ณฑฑ
ฑฑณ            ณ06.02.02 ณ  013163   ณAjuste no Saldo Inicial por Cliente.ณฑฑ
ฑฑณ  Marco A.  ณ07/12/16 ณ SERINN001-ณSe aplica CTREE para evitar la      ณฑฑ
ฑฑณ            ณ         ณ 131       ณcreacion de tablas temporales de    ณฑฑ
ฑฑณ            ณ         ณ           ณmanera fisica en system.            ณฑฑ
ฑฑณ Alf Medrano ณ24/01/19 ณDMINA-5664ณSe crea fun fCxCDifClt obtiene doctsณฑฑ
ฑฑณ            ณ         ณ           ณde tipo “CC”. Se crea func fSeparaMVณฑฑ
ฑฑณ            ณ         ณ           ณsepara y agrega a array tipos docts ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Finr13X() // incluido pelo assistente de conversao do AP5 IDE em 09/09/99
	
	Local oReport
		oReport	:= ReportDef()
		oReport:PrintDialog()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณPaulo Augusto       บ Data ณ  21/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tratamanto release 04                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

	Local oReport	:= Nil
	Local oSection1	:= Nil
	Local oSection2	:= Nil
	
	Local cReport	:= "FINR13X"
	Local cTitulo	:= OemToAnsi(STR0003) 	// "Informe de Pagos"
	Local cDescri	:= OemToAnsi(STR0003)

	Pergunte("FIR13X",.F.)

	oReport  := TReport():New( cReport, cTitulo, "FIR13X" , { |oReport| ReportPrint( oReport, "SE1" ) }, cDescri )

	oSection1 := TRSection():New( oReport,STR0039, {"SA1"}, )

	TRCell():New( oSection1, "A1_COD" 	,"SA1",/*X3Titulo*/	,/*Picture*/,TamSX3("A1_COD")[1]+TamSx3("A1_LOJA")[1]+2,/*lPixel*/,)
	TRCell():New( oSection1, "A1_NOME"	,"SA1",/*X3Titulo*/	,/*Picture*/,TamSX3("A1_NOME")[1]/*Tamanho*/,/*lPixel*/,)

	TrPosition():New(oSection1,'SA1',1,{|| xFilial('SA1')+TRB->CODCLI+TRB->LOJA} )

	oSection2 := TRSection():New( oSection1,STR0040 ,  )
	TRCell():New( oSection2,"E1_TIPO"		,"SE1",/*X3Titulo*/	,/*Picture*/,TamSX3("E1_TIPO")[1]+5/*Tamanho*/,/*lPixel*/)
	TRCell():New( oSection2,"E1_NUM"		,"SE1",/*X3Titulo*/	,/*Picture*/,TamSX3("E1_NUM")[1]+TamSx3("E1_PREFIXO")[1]+4/*Tamanho*/,/*lPixel*/)
	If cPaisLoc == "PTG"
		TRCell():New( oSection2,"NODIA","TRB",STR0042	,/*Picture*/,10/*Tamanho*/,/*lPixel*/,)//"Diario CTB"
	EndIf
	TRCell():New( oSection2,"E1_EMISSAO"	,"SE1",/*X3Titulo*/	,/*Picture*/,20/*Tamanho*/,/*lPixel*/)
	TRCell():New( oSection2,"E1_VENCREA"	,"SE1",STR0033+CHR(13)+CHR(10) +STR0034/*X3Titulo*/	,/*Picture*/,/*Tamanho*/20,/*lPixel*/)
	//TRCell():New( oSection2,"DEBITO"		,"   ",STR0035/*X3Titulo*/	,PesqPict("SE1","E1_VALOR")/*Picture*/,TamSX3("E1_VALOR")[1])
	TRCell():New( oSection2,"DEBITO"		,"   ",STR0035/*X3Titulo*/,,TamSX3("E1_VALOR")[1]+10,,,,,"CENTER")// ,,,"RIGHT",,"RIGHT")
	//TRCell():New( oSection2,"CREDITO"		,"   ",STR0036/*X3Titulo*/		,PesqPict("SE1","E1_VALOR")/*Picture*/,TamSX3("E1_VALOR")[1])
	TRCell():New( oSection2,"CREDITO"		,"   ",STR0036/*X3Titulo*/,,TamSX3("E1_VALOR")[1]+13,,,,,"CENTER")//,,,"RIGHT",,"RIGHT")
	//TRCell():New( oSection2,"SALDO"		,"   ",STR0038+CHR(13)+CHR(10) + STR0037	,/*Picture*/,TAMSX3("E1_VALOR")[1]  ,.F.,		,,,"RIGHT")
	//TRCell():New( oSection2,"SALDO" 		,"   ",STR0038+CHR(13)+CHR(10) + STR0037,PesqPict("SE1","E1_VALOR")	,TamSx3("E2_VALOR")[1] )
	TRCell():New( oSection2,"SALDO" 		,"   ",STR0038+CHR(13)+CHR(10) + STR0037,,TamSX3("E1_VALOR")[1]+10,,,,,"CENTER")//,,,"RIGHT",,"RIGHT")
	//TRCell():New( oSection2,"SALDO" 		,"   ",Alltrim(STR0064)							,				,TamSx3("E2_VLCRUZ")[1]	,.F.,		,,,"RIGHT") //"SALDO ATUAL"

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrintบAutor  ณPaulo Augusto       บ Data ณ  21/07/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina de impressao                                          บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAFIN                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportPrint( oReport )
	
	Local oSection1	:= oReport:Section(1)
	Local oSection2	:= oSection1:Section(1)
	Local lAgregSEK	:= .F., cLoja
	Local _aOrdem	:= {}	// Ordem do Relatorio
	Local _nOrden	:= 1	// [8] Ordem a ser selecionada


	Local aTipDoc	:= {	{ "FT ", "FT" }, { "NF ", "FT" }, { "NCC", "NC" }, { "NDC", "ND" } }
	Local nDebCli	:= 0
	Local nCredCli	:= 0
	Local nSalAC	:= 0
	Local nTotDeb	:= 0
	Local nTotCred	:= 0
	Local nTotMO	:= 0
	Local nRecno	:= 0
	Local aFields	:= Array( 0 )
	Local cDbfTmp	:= ""
	Local cNtxTmp
	Local cSerie
	Local cRecibo
	Local nOrdSe1
	Local nRecSe1
	Local cTipo
	Local nPosTp
	Local cFiltro	:=	oSection1:GetAdvPlExp('SA1')
	Local nMoeda	:= mv_par13
	Local nElMoeda	:= 0 
	Local nTx		:= 0
	Local lShow		:= .F.  
	Local aRecOri	:= {,,,,,,,,,}
	Local lNewRec	:= .F.
	Local bBlock
	Local aOrdem1	:= {}
	Local aOrdem2	:= {}
	Local aOrdem3	:= {}
	Local lTipoIn 	:= .T.
	Local lTipoNg 	:= .T.
	Local lTipoCp	:= .T.
	Local aCRNEGTW	:= {}
	Local aCRNEG 	:= {}
	Local aRCANT	:= {}
	Local aSepara	:= {'|', ',','-'}
	Local nX		:= 0
	Local nValMd	:= 0
	Local nDcTxMd	:= GetSX3Cache("EL_TXMOEDA","X3_DECIMAL")
	Local lExVlTot  := FindFunction("FINXVLTOTL")
	
	Private nDecs		:= MsDecimais(1)
	Private cCodCli		:= Space( 0 )
	Private cCliente	:= Space( 0 )
	Private cTelef		:= Space( 0 )
	Private cContact	:= Space( 0 ) 
	Private nQtMoedas	:= Moedfin()
	Private aTaxa		:= Array(nQtMoedas)
	Private oTmpTable	:= Nil

	If MV_PAR14 == 1
		bBlock := {|| !Empty(E1_RECIBO)}
	ElseIf MV_PAR14 == 2
		bBlock := {|| Empty(E1_RECIBO)}	
	Else
		bBlock := {|| .T.}		
	EndIf

	Pergunte("FIR13X",.F.)
	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf
	oReport:SetTitle(OemToAnsi(STR0003) + OemToAnsi(STR0041)  + GetMv("MV_MOEDA"+LTrim(Str(MV_PAR13))))

	AAdd( aFields, { "CODCLI"		, "C", TamSX3('A1_COD')[1], 0 } )
	AAdd( aFields, { "LOJA"			, "C", TamSX3('A1_LOJA')[1], 0 } )
	AAdd( aFields, { "CLIENTE"		, "C", 35, 0 } )
	AAdd( aFields, { "TIPODOC"		, "C",  2, 0 } )
	AAdd( aFields, { "SERIE"		, "C",  3, 0 } )
	AAdd( aFields, { "NRODOC"		, "C", 13, 0 } )
	AAdd( aFields, { "NUMLIQ"		, "C", 13, 0 } )
	AAdd( aFields, { "FECHA"		, "D",  8, 0 } )
	AAdd( aFields, { "FECVTO"		, "D",  8, 0 } )
	AAdd( aFields, { "CREDITO"		, "N", 15, 2 } )
	AAdd( aFields, { "DEBITO"		, "N", 15, 2 } )
	AAdd( aFields, { "SALDO"		, "N", 15, 2 } )
	AAdd( aFields, { "TIPSAL"		, "C",  1, 2 } )
	AAdd( aFields, { "TELEFONOS"	, "C", 40, 0 } )
	AAdd( aFields, { "CONTACTO"		, "C", 40, 0 } )
	AAdd( aFields, { "NODIA"		, "C", 10, 0 } )
	
	aOrdem1 := {"CODCLI", "TIPODOC"	, "SERIE"	, "NRODOC"}
	aOrdem2 := {"CODCLI", "FECHA"	, "TIPODOC"	, "SERIE", "NRODOC"}
	aOrdem3 := {"CODCLI", "FECVTO"	, "TIPODOC"	, "SERIE", "NRODOC"}
	
	If !Empty( Select("TRB"))
		DbSelectArea("TRB")
		DbCloseArea()
	EndIf
	
	oTmpTable := FWTemporaryTable():New("TRB")
	oTmpTable:SetFields(aFields)
	oTmpTable:AddIndex("IN1", aOrdem1)
	oTmpTable:AddIndex("IN2", aOrdem2)
	oTmpTable:AddIndex("IN3", aOrdem3)
	
	oTmpTable:Create()
	
	SE5->(DbSetOrder(7))
	
	DbSelectArea( "SA1" )
	DbSetOrder( 1 )

	DbSelectArea( "SE1" )
	DbSetOrder( 2 )
	

	If mv_par08 == 2
		oSection1:SetPageBreak()
	EndIf	
	If !Empty( mv_par01 )
		DbSeek( xFilial( "SE1" ) + mv_par01, .T. )
	Else
		DbSeek(xFilial())
	EndIf
	
	aCRNEG 	:= fSeparaMV(MV_CRNEG +"|"+MVRECANT, aSepara)
	aCRNEGTW:= fSeparaMV(MV_CRNEG +"," + SuperGetMv("MV_CRNEG",.F.,"NCC,NDE,RA"), aSepara)
	aRCANT	:= fSeparaMV(MV_CRNEG +"|"+MV_CPNEG, aSepara)
	

	While !EoF() .AND. E1_FILIAL == xFilial() .AND. E1_CLIENTE <= mv_par02
		
			If Alltrim(E1_TIPO) != "CC"
				DbSelectArea( "SA1" )
				DbSeek( xFilial( "SA1" ) + SE1->E1_CLIENTE + SE1->E1_LOJA )
				If !Empty(cFiltro) .And. !(&(cFiltro))
					DbSelectArea( "SE1" )
					DbSkip()
					Loop
				EndIf
				DbSelectArea( "SE1" )
		
				If  cPaisLoc<>"BRA" .And. MV_PAR13 == SE1->E1_MOEDA  .And.  SE1->E1_CONVERT=='N' .And. MV_PAR12 == 1
					dbSkip()
					Loop
				EndIf
		
				//Ao extrair o relat๓rio em moeda 2 nใo deve exibir os tํtulos oriundos de varia็ใo cambial (FINA074)
				If nMoeda <> 1 .And. Upper(AllTrim(E1_ORIGEM)) $ 'FINA074'
					dbSkip()
					Loop
				EndIf
					
				If !SubStr(Alltrim(E1_TIPO), 1, 2 ) $ "TF-CH-EF" .And. E1_EMISSAO <= dDataBase .AND.  Eval(bBlock) .And. IIf(mv_par06 != 1,E1_SALDO > 0,.T.)	
					
					For nX := 1 To Len(aCRNEG)
						If Alltrim(E1_TIPO) == Alltrim(aCRNEG[nX])
							lTipoIn := .T.
							Exit
						Else
							lTipoIn := .F.
						EndIf
					Next
					
					For nX := 1 To Len(aCRNEGTW)
						If Alltrim(E1_TIPO) == Alltrim(aCRNEGTW[nX])
							lTipoNg := .T.
							Exit
						Else
							lTipoNg := .F.
						EndIf
					Next
					
		
					If (lTipoIn .And. !(Alltrim(E1_ORIGEM)$"FINA087A|FINA840|"+Iif(FindFunction('OriCobrDiv'),OriCobrDiv(),""))) .or. !(lTipoIn)
						cCodCli  := SA1->A1_COD
						cCliente := SA1->A1_NOME
						cTelef   := SA1->A1_TEL
						cContact := SA1->A1_CONTATO
		
						If ( mv_par10 < 2 .AND. E1_EMISSAO < Min(mv_par03,dDatabase) ) .OR.;
						( mv_par10 > 1 .AND. E1_VENCREA < mv_par03 )
		
							DbSelectArea( "TRB" )
							DbSetOrder(1)
		
							If !DbSeek( SE1->E1_CLIENTE+"SA")
		
								TRB->( DbAppend() )
								TRB->CODCLI    := cCodCli
								TRB->LOJA      := SA1->A1_LOJA
								TRB->CLIENTE   := cCliente
								TRB->TELEFONOS := cTelef
								TRB->CONTACTO  := cContact
								TRB->TIPODOC   := "SA"
								TRB->FECHA     := mv_par03 - 1
		
							EndIf
		
							DbSelectArea( "SE1" )
		
							IF lTipoNg .OR. SubStr( E1_TIPO, 3, 1 ) == "-"
								TRB->CREDITO := TRB->CREDITO + xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
								TRB->SALDO   := TRB->SALDO - xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,  IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
							ElseIf (Alltrim(E1_TIPO) <> Alltrim(GetMV("MV_SIMB1") )) .and. Empty(E1_NUMLIQ)
								TRB->DEBITO  := TRB->DEBITO + xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
								TRB->SALDO   := TRB->SALDO + xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2 ,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
							ElseIf !Empty(E1_NUMLIQ)
								TRB->NUMLIQ	 := E1_NUMLIQ
								TRB->DEBITO  := TRB->DEBITO + xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
								TRB->SALDO   := TRB->SALDO + xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2 ,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))				
							EndIf
							LeBaixaMfatur(SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA))
							DbSelectArea( "SE1" )
						ElseIf (Alltrim(E1_TIPO) <> Alltrim(GetMV("MV_SIMB1") ))
		
							If ( mv_par10 < 2 .AND. E1_EMISSAO <= mv_par04 ) .OR.;
							( mv_par10 > 1 .AND. E1_VENCREA <= mv_par04 )
		
								TRB->( DbAppend() )
								TRB->CODCLI    := cCodCli
								TRB->LOJA      := SA1->A1_LOJA
								TRB->CLIENTE   := cCliente
								TRB->TELEFONOS := cTelef
								TRB->CONTACTO  := cContact
		
								DbSelectArea( "SE1" )
								cTipo 	:= SE1->E1_TIPO
								nPosTp	:=	AScan( aTipDoc, { |a| a[1] == E1_TIPO })
								//            		AScan( aTipDoc, { |a| If( a[1] == E1_TIPO, cTipo := a[2], ) } )
								cTipo	:=	IIf(nPosTp	>	0	, aTipDoc[nPosTp][2],cTipo)
								TRB->SERIE   := AllTrim( E1_PREFIXO )
								TRB->NRODOC  := E1_NUM
								TRB->FECHA   := E1_EMISSAO
								TRB->FECVTO  := E1_VENCREA
								TRB->TIPODOC := cTipo   
		            			TRB->TIPSAL  := Iif (lTipoIn .Or. Substr(Alltrim(E1_TIPO), 3, 1 ) == "-", "A", "D")
								If cPaisLoc =="PTG"
									TRB->NODIA  := E1_NODIA
								EndIf
		
								If TRB->TIPSAL == "A" .Or. lTipoNg     
									TRB->SALDO     := xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0) )  * -1
									TRB->CREDITO   := xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0) )
								ElseIf Empty(E1_NUMLIQ)
									TRB->SALDO     := xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0) )
									TRB->DEBITO    := xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0) )
								ElseIf !Empty(E1_NUMLIQ)
									TRB->NUMLIQ		:= E1_NUMLIQ
									TRB->SALDO     := xMoeda(E1_SALDO,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0) )
									TRB->DEBITO    := xMoeda(E1_VALOR,E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(E1_EMISSAO,E1_MOEDA)),0))
								EndIf
								LeBaixaMfatur(SE1->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA))
								DbSelectArea( "SE1" )
							EndIf
						EndIf
					EndIf
				EndIf	
			EndIf
		DbSkip()
		
	EndDo

	DbSelectArea( "SEL" )
	DbSetOrder( 3 )

	If !Empty( mv_par01 )
		DbSeek( xFilial( "SEL") +  mv_par01, .T. )
	Else
		DbSeek(xFilial())
	EndIf
 
	While !EoF() .AND. EL_FILIAL == xFilial("SEL") .AND.  EL_CLIORIG  <=  mv_par02
		DbSelectArea( "SA1" )
		DbSeek( xFilial( "SA1" ) + SEL->EL_CLIORIG + SEL->EL_LOJORIG )
		If !Empty(cFiltro) .And. !(&(cFiltro))
		
			DbSelectArea( "SEL" )
			DbSkip()
			Loop
		EndIf

		DbSelectArea( "SEL" )

		cCodCli  := SA1->A1_COD
		cCliente := SA1->A1_NOME

		If EL_DTDIGIT > dDataBase
			DbSkip()
			Loop
		EndIf

		If !VerAtu()
			DbSkip()
			Loop
		EndIf

		If EL_DTDIGIT < mv_par03

			If !EL_CANCEL 

				DbSelectArea( "TRB" )
				DbSetOrder(1)

				If !DbSeek( SEL->EL_CLIORIG+"SA", .F. )

					TRB->( DbAppend() )
					TRB->CODCLI    := cCodCli
					TRB->LOJA      := SA1->A1_LOJA
					TRB->CLIENTE   := cCliente
					TRB->TIPODOC   := "SA"
					TRB->FECHA     := mv_par03 - 1
					TRB->TELEFONOS := SA1->A1_TEL
					TRB->CONTACTO  := SA1->A1_ENDREC

				EndIf

				DbSelectArea( "SEL" )

				cRecibo := EL_RECIBO
				cSerRec := EL_SERIE

				While !EoF() .AND. xFilial( "SEL" ) == EL_FILIAL .AND. EL_RECIBO == cRecibo .AND. EL_SERIE == cSerRec

					nElMoeda := SEL->EL_TXMOEDA
					For nTx := 2 To Len(aTaxa)
						If Val( SEL->EL_MOEDA ) == nTx
							nElMoeda := SEL->&("EL_TXMOE"+StrZero(nTx,2))
						EndIf
					Next
					
					For nX := 1 To Len(aRCANT)
						If Alltrim(EL_TIPO) == Alltrim(aRCANT[nX])
							lTipoCp := .T.
							Exit
						Else
							lTipoCp := .F.
						EndIf
					Next	

					If EL_TIPODOC $ "TB/RA" .AND. !EL_CANCEL
						
						If (lTipoCp .And.EL_TIPODOC <> "RA")
							TRB->CREDITO := TRB->CREDITO - xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO,Val(SEL->EL_MOEDA))),0)  )
						ElseIf (Alltrim(EL_TIPO) == "NCC")
							TRB->DEBITO := TRB->DEBITO + xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO,Val(SEL->EL_MOEDA))),0)  )
						Else
							If cPaisLoc <> "BRA" .and. lExVlTot
								nValMd := FINXVLTOTL(SEL->EL_VLMOED1, nElMoeda, SEL->EL_VALOR, nMoeda, Val(SEL->EL_MOEDA))	
								TRB->CREDITO := TRB->CREDITO + Round(xMoeda(nvalMd,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil),nDcTxMd,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO ,Val(SEL->EL_MOEDA))),0)  ),nDecs)
							Else
								TRB->CREDITO := TRB->CREDITO + xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO,Val(SEL->EL_MOEDA))),0)  )
							EndIf
						EndIf

						If EL_TIPODOC == "RA"
							nOrdSE1  := SE1->(IndexOrd())
							nRecSE1  := SE1->(Recno())
							SE1->(DbSetOrder(2))
							If SE1->(DbSeek(xFilial()+SEL->(EL_CLIORIG + EL_LOJORIG+EL_PREFIXO+EL_NUMERO+EL_PARCELA+EL_TIPO)))
								TRB->SALDO := TRB->SALDO -  xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, SE1->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0)  )
							EndIf
							SE1->(DbSetOrder(nOrdSE1))
							SE1->(DbGoTo(nRecSE1))
						EndIf
					EndIf

					DbSkip()

				EndDo
				If TRB->CREDITO > TRB->DEBITO
					TRB->TIPSAL := "A"
				Else
					TRB->TIPSAL := "D"
				EndIf                   

			Else

				DbSkip()

			EndIf

		Else

			If EL_DTDIGIT <= mv_par04 .AND. !EL_CANCEL 

				aRecOri[01]	:= cCodCli
				aRecOri[02]	:= cCliente
				aRecOri[03]	:= SEL->EL_SERIE
				aRecOri[04]	:= If(!Empty(Val(SEL->EL_RECIBO)),StrZero(Val(SEL->EL_RECIBO),12),SEL->EL_RECIBO)
				aRecOri[05]	:= SEL->EL_DTDIGIT
				aRecOri[06]	:= SEL->EL_DTDIGIT
				aRecOri[07]	:= "RC"
				aRecOri[08]	:= "A"
				aRecOri[09]	:=	SA1->A1_TEL
				aRecOri[10]	:= SA1->A1_ENDREC
				DbSelectArea( "TRB" )

				DbSelectArea( "SEL" )
				cRecibo := EL_RECIBO
				cSerrec := EL_SERIE
				While !EoF() .AND. xFilial( "SEL" ) == EL_FILIAL .AND. EL_RECIBO == cRecibo.AND. EL_SERIE == cSerRec

					nElMoeda := SEL->EL_TXMOEDA
					For nTx := 2 To Len(aTaxa)
						If Val( SEL->EL_MOEDA ) == nTx
							nElMoeda := SEL->&("EL_TXMOE"+StrZero(nTx,2))
						EndIf
					Next	

					If EL_TIPODOC $ "TB/RA" .AND. !EL_CANCEL
						If	mv_par06 != 1 //Imprime saldo zero 'Nใo'
							If SE1->(DbSeek(xFilial("SE1")+SEL->(EL_CLIORIG+EL_LOJORIG+EL_PREFIXO+EL_NUMERO+EL_PARCELA+EL_TIPO)))
								If SE1->E1_SALDO > 0
									lNewRec := .T.
								Else           
									lNewRec := .F.
								EndIf
							Else
								lNewRec := .T.
							EndIf
						Else										
							lNewRec := .T.
						EndIf

						If lNewRec
							DbSelectArea( "TRB" )
							DBSetOrder(1)

							TRB->( DbAppend() )
							TRB->CODCLI    := aRecOri[01]
							TRB->CLIENTE   := aRecOri[02]
							TRB->SERIE     := aRecOri[03]
							TRB->NRODOC    := aRecOri[04]
							TRB->FECHA     := aRecOri[05]
							TRB->FECVTO    := aRecOri[06]
							TRB->TIPODOC   := aRecOri[07]
							TRB->TIPSAL    := aRecOri[08]
							TRB->TELEFONOS := aRecOri[09]
							TRB->CONTACTO  :=	aRecOri[10]	

							DbSelectArea("SEL")			
						Else
							DbSkip()
							Loop					
						EndIf
						For nX := 1 To Len(aRCANT)
							If Alltrim(EL_TIPO) == Alltrim(aRCANT[nX])
								lTipoCp := .T.
								Exit
							Else
								lTipoCp := .F.
							EndIf
						Next	
						
						If (lTipoCp .And.EL_TIPODOC <> "RA")
							TRB->CREDITO := TRB->CREDITO - xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO,Val(SEL->EL_MOEDA))),0)  )
						ElseIf (Alltrim(EL_TIPO) $ "NCC ")
							TRB->DEBITO := TRB->DEBITO + xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO,Val(SEL->EL_MOEDA))),0)  )
						Else
							If cPaisLoc <> "BRA" .and. lExVlTot
								nValMd := FINXVLTOTL(SEL->EL_VLMOED1, nElMoeda, SEL->EL_VALOR, nMoeda, Val(SEL->EL_MOEDA))	
								TRB->CREDITO := TRB->CREDITO + Round(xMoeda(nvalMd,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil),nDcTxMd,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO ,Val(SEL->EL_MOEDA))),0)  ),nDecs)
							Else
								TRB->CREDITO := TRB->CREDITO + xMoeda(EL_VALOR,Val(SEL->EL_MOEDA),nMoeda,IIf(MV_PAR12 == 2, SEL->EL_EMISSAO, Nil),,IIf(MV_PAR12 == 2,IIf(nElMoeda>0,nElMoeda,RecMoeda(SEL->EL_EMISSAO ,Val(SEL->EL_MOEDA))),0)  )
							EndIf
						EndIf

						If EL_TIPODOC == "RA"
							nOrdSE1   := SE1->(IndexOrd())
							nRecSE1  := SE1->(Recno())
							SE1->(DbSetOrder(2))
							If SE1->(DbSeek(xFilial()+SEL->(EL_CLIORIG + EL_LOJORIG+EL_PREFIXO+EL_NUMERO+EL_PARCELA+EL_TIPO)))
								TRB->SALDO := TRB->SALDO - xMoeda(SE1->E1_SALDO,SE1->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, SE1->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0)  )
							EndIf
							SE1->(DbSetOrder(nOrdSE1))
							SE1->(DbGoTo(nRecSE1))
						EndIf
					EndIf

					DbSkip()

				EndDo

			Else

				DbSkip()

			EndIf

		EndIf

	EndDo
	
	fCxCDifClt(aTipDoc,nMoeda)
	DbSelectArea( "TRB" )

	If mv_par07 < 2
		If mv_par10 < 2
			DbSetOrder(2)
		Else
			DbSetOrder(3)
		EndIf
	Else
		If mv_par10 < 2
			DbSetOrder(2)
		Else
			DbSetOrder(3)
		EndIf
	EndIf

	DbSelectArea("TRB")
	DbGoTop()

	oReport:SetMeter(TRB->( RecCount() ) + 1)
	If MV_PAR05 == 2
		oSection2:Cell("E1_TIPO"):Disable()
		oSection2:Cell("E1_EMISSAO"):Disable()
		oSection2:Cell("E1_VENCREA"):Disable()
		oSection2:Cell("E1_EMISSAO"):Disable()
		oSection2:Cell("E1_NUM"):SetTitle(" ")
	EndIf
	oSection1:SetHeaderPage(.F.)
	oSection2:SetHeaderPage(.F.)
	While !EoF()

		cCodCli  := CODCLI
		cCliente := AllTrim( CLIENTE )
		cTelef   := AllTrim( TELEFONOS )
		cContact := AllTrim( CONTACTO )	

		oSection1:Init()
		oSection1:Cell("A1_COD"):SetBlock({||TRB->CODCLI  })
		oSection1:Cell("A1_NOME"):SetBlock({||TRB->CLIENTE})
		oSection1:PrintLine()
		oReport:SkipLine()
		oSection1 :Finish()
		oSection2:Init()

		While !EoF() .AND. CODCLI ==  cCodCli

			If MV_PAR05 == 2 .And. MV_PAR11 == 1 .AND. Empty(TRB->NUMLIQ)	// Resumido e Com Saldo Inicial

				If TIPODOC <> "SA"
					nCredCli := nCredCli + CREDITO
					nDebCli  := nDebCli  + DEBITO
				EndIf
				nTotCred := nTotCred + CREDITO
				nTotDeb  := nTotDeb  + DEBITO

			ElseIf Empty(TRB->NUMLIQ)

				nCredCli := nCredCli + CREDITO
				nDebCli  := nDebCli  + DEBITO
				nTotCred := nTotCred + CREDITO
				nTotDeb  := nTotDeb  + DEBITO

			EndIf

			If Empty(TRB->NUMLIQ)
				nSalAC   := nSalAC   + (DEBITO - CREDITO)
				nTotMO   := nTotMO   + SALDO
			EndIf

			If mv_par05 == 1 // .AND. !Empty( VALOR )
				DbSelectArea("TRB")
				If TIPODOC == "SA"
					oSection2:Cell("E1_NUM"):SetBlock({||OemToAnsi(STR0012) })
					oSection2:Cell("E1_EMISSAO"):SetBlock({||TRB->FECHA })
				Else
					oSection2:Cell("E1_TIPO"):SetBlock({||TRB->TIPODOC })
					If !Empty(TRB->NUMLIQ)
						oSection2:Cell("E1_NUM"):SetBlock({||transform(TRB->NRODOC+"/LIQ", IIf(TRB->TIPODOC == 'RC',PesqPict('SEL','EL_RECIBO'),PesqPict('SE1','E1_NUM')))})
					Else
						oSection2:Cell("E1_NUM"):SetBlock({||transform(TRB->NRODOC, IIf(TRB->TIPODOC=='RC',PesqPict('SEL','EL_RECIBO'),PesqPict('SE1','E1_NUM')))})				
					EndIf
					oSection2:Cell("E1_EMISSAO"):SetBlock({||OemToAnsi(STR0012) })
					oSection2:Cell("E1_VENCREA"):SetBlock({||TRB->FECVTO })
					oSection2:Cell("E1_EMISSAO"):SetBlock({||TRB->FECHA })
					If cPaisLoc == "PTG"
						oSection2:Cell("NODIA"):SetBlock({||TRB->NODIA })
					EndIf
				EndIf


				If TIPODOC == "RC" .And. CREDITO > 0 .And. DEBITO > 0 
					If oReport:nDevice == IMP_EXCEL 
						oSection2:Cell("DEBITO"):SetBlock({||TRB->DEBITO })
						oSection2:Cell("CREDITO"):SetBlock({||TRB->CREDITO})
					Else
						oSection2:Cell("DEBITO"):SetBlock({|| Transform( TRB->DEBITO, PesqPict("SE1","E1_VALOR")) })
						oSection2:Cell("CREDITO"):SetBlock({||Transform( CREDITO, PesqPict("SE1","E1_VALOR"))})
					EndIf				
				Else

					If DEBITO > 0
						If oReport:nDevice == IMP_EXCEL 
							oSection2:Cell("DEBITO"):SetBlock({||TRB->DEBITO })
						else
							oSection2:Cell("DEBITO"):SetBlock({||Transform( TRB->DEBITO, PesqPict("SE1","E1_VALOR"))  })
						EndIf				
						oSection2:Cell("CREDITO"):Hide()
					EndIf

					If CREDITO > 0                      
						If oReport:nDevice == IMP_EXCEL 				
							oSection2:Cell("CREDITO"):SetBlock({||TRB->CREDITO})				
						else
							oSection2:Cell("CREDITO"):SetBlock({||Transform( CREDITO, PesqPict("SE1","E1_VALOR"))})					
						EndIf									
						oSection2:Cell("DEBITO"):Hide()

					EndIf
				EndIf	
				If oReport:nDevice == IMP_EXCEL 				
					oSection2:Cell("SALDO"):SetBlock({||nSalAC})                								
				Else    
					oSection2:Cell("SALDO"):SetBlock({|| transform(nSalAC,PesqPict('SE1','E1_VALOR')) })				
				EndIf	

				oSection2:PrintLine()

				oSection2:Cell("CREDITO"):Show()
				oSection2:Cell("DEBITO"):Show()
			EndIf

			DbSkip()
			oReport:IncMeter()

		EndDo

		If ( mv_par06 < 2 .OR. IIf(MV_PAR01 == MV_PAR02,.F.,cCodCli <> CODCLI) ) .AND. mv_par09 == 1	

			cDisp := cTelef + " - " + cContact

			If nSalAc != 0 .Or. mv_par06 == 1	
				If mv_par05 < 2
					oReport:ThinLine()
					oReport:SkipLine()
					oReport:PrintText(OemToAnsi(STR0010) + cCodCli + " (" + Left( cDisp, 40 ) + ")" )
				Else
					oReport:PrintText( cCodCli  +  "  " + cCliente + " (" +  Left( cDisp, 40 ) + ")"  )
				EndIf
			EndIf                           

			oSection2:Cell("E1_TIPO"):Hide()
			oSection2:Cell("E1_NUM"):Hide()
			oSection2:Cell("E1_EMISSAO"):Hide()
			oSection2:Cell("E1_VENCREA"):Hide()
			oSection2:Cell("E1_EMISSAO"):Hide()
			If oReport:nDevice == IMP_EXCEL
				oSection2:Cell("DEBITO"):SetBlock({||nDebCLi})                											
				oSection2:Cell("CREDITO"):SetBlock({||nCredCli})                											
				oSection2:Cell("SALDO"):SetBlock({||nSalAC})                								
			Else
				oSection2:Cell("DEBITO"):SetBlock({|| Transform(nDebCLi, PesqPict("SE1","E1_VALOR")) })
				oSection2:Cell("CREDITO"):SetBlock({|| Transform(nCredCli, PesqPict("SE1","E1_VALOR")) })
				oSection2:Cell("SALDO"):SetBlock({||transform(nSalAC,PesqPict('SE1','E1_VALOR')) })
			EndIf                           
			If nSalAc == 0 .And. mv_par06 == 2
				oSection2:Cell("DEBITO"):Hide()
				oSection2:Cell("CREDITO"):Hide()
				oSection2:Cell("SALDO"):Hide()	
				lShow := .T.				
			EndIf			

			oSection2:PrintLine()
			oSection2:Cell("E1_TIPO"):Show()
			oSection2:Cell("E1_NUM"):Show()
			oSection2:Cell("E1_EMISSAO"):Show()
			oSection2:Cell("E1_VENCREA"):Show()
			oSection2:Cell("E1_EMISSAO"):Show()
			If cPaisLoc == "PTG"
				oSection2:Cell("NODIA"):Show()
			EndIf	

			If mv_par05 < 2
				oReport:ThinLine()
				oReport:SkipLine()
			EndIf
			If lShow
				oSection2:Cell("DEBITO"):Hide()
				oSection2:Cell("CREDITO"):Hide()
				oSection2:Cell("SALDO"):Show()
				lShow := .F.		
			EndIf	

			nDebCli  := 0
			nCredCli := 0
			nSalAC   := 0

		EndIf
		oSection2 :Finish()
	EndDo


	If  mv_par09 == 1
		oReport:PrintText(OemToAnsi(STR0011) )
		oSection2:Init()
		If cPaisLoc == "PTG"
			oSection2:Cell("NODIA"):Hide()
		EndIf	
		oSection2:Cell("E1_TIPO"):Hide()
		oSection2:Cell("E1_EMISSAO"):Hide()
		oSection2:Cell("E1_VENCREA"):Hide()
		oSection2:Cell("E1_EMISSAO"):Hide()
		oSection2:Cell("E1_NUM"):Hide()    
		If oReport:nDevice == IMP_EXCEL
			oSection2:Cell("DEBITO"):SetBlock({||nTotDeb})                											
			oSection2:Cell("CREDITO"):SetBlock({||nTotCred})                											
			oSection2:Cell("SALDO"):SetBlock({||nTotDeb-nTotCred})                								
		Else
			oSection2:Cell("DEBITO"):SetBlock({|| Transform(nTotDeb,PesqPict('SE1','E1_VALOR'))})
			oSection2:Cell("CREDITO"):SetBlock({|| Transform(nTotCred,PesqPict('SE1','E1_VALOR')) })
			oSection2:Cell("SALDO"):SetBlock({|| transform(nTotDeb-nTotCred,PesqPict('SE1','E1_VALOR')) })
		EndIf
		oSection2:PrintLine()
		oReport:SkipLine()
		oReport:FatLine()
	EndIf
	
	If oTmpTable <> Nil
		oTmpTable:Delete()
		oTmpTable := Nil
	EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณPRINTHEAD ณ Autor ณ   Alberto Badaui      ณ Data ณ 11/01/00 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณImpresiขn de datos del encabezado                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function PrintHead(lProc,nLine)
	Local _cCabec1,_cCabec2

	If !lProc
		lProc := .t.
	EndIf

	If nLine >= BOTTOMPAGE .AND. mv_par09 < 2

		If mv_par05 < 2
			_cCabec1 := STR0005 //"Cod.   Nombre / Razon Social                    Tipo  Comprobante   Fecha    Fecha          Debitos         Creditos           Saldo"
			_cCabec2 := STR0006 //"                                                Cpte.               Emision  Vto.                                          Acumulado"

			//                    0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
			//                           1         2         3         4         5         6         7         8         9         10        11        12        13        14
			//                    123456 1234567890123456789012345678901234567890   1   1234-12345678 12345678 12345678 1234567890123 1234567890123 1234567890123 1234567890123

		Else
			_cCabec1 := STR0007 //"Cod.   Nombre / Razon Social                                                                Debitos         Creditos           Saldo"
			_cCabec2 := STR0008 //"                                                                                                                           Acumulado"
		EndIf

		Cabec( _cTitulo, _cCabec1, _Ccabec2, _cNomeProg, _cTamanho, 18 )

		nLine := 09 // Ajustado linha para visualizacao na tela - Camurca

	EndIf

Return Nil


Static Function PrintItem(nLine,nSalAc)

	If TIPODOC == "SA"
		@ nLine,  49 PSAY STR0009 // "Saldos al: "
		@ nLine,  67 PSAY FECHA
	Else
		@ nLine,  00 PSAY CODCLI
		@ nLine,  11 PSAY CLIENTE
		@ nLine,  46 PSAY TIPODOC
		If !Empty(TRB->NUMLIQ)
			@ nLine,  50 PSAY NRODOC+"/LIQ" Picture If(TIPODOC='RC',PesqPict('SEL','EL_RECIBO'),PesqPict('SE1','E1_NUM'))
		Else
			@ nLine,  50 PSAY NRODOC Picture If(TIPODOC='RC',PesqPict('SEL','EL_RECIBO'),PesqPict('SE1','E1_NUM'))
		EndIf
		@ nLine,  68 PSAY FECHA
		@ nLine,  80 PSAY FECVTO
	EndIf

	If TIPODOC =="RC" .AND. DEBITO > 0 .AND. CREDITO > 0 
		@ nLine,  92 PSAY DEBITO       PICTURE TM(DEBITO,14,nDecs) //"99,999,999.99" 
		@ nLine, 107 PSAY CREDITO      PICTURE TM(CREDITO,14,nDecs) //"99,999,999.99"
	Else
		If DEBITO > 0
			@ nLine,  92 PSAY DEBITO       PICTURE TM(DEBITO,14,nDecs) //"99,999,999.99"
		EndIf

		If CREDITO > 0
			@ nLine, 107 PSAY CREDITO      PICTURE TM(CREDITO,14,nDecs) //"99,999,999.99"
		EndIf
	EndIf	
	@ nLine, 122 PSAY nSalAC       PICTURE TM(nSalAC,14,nDecs) //"99,999,999.99"

	nLine := nLine + 1

Return Nil


Static Function PrintTotC(nLine,cCodCli,cCliente,cTelef,cContact,nDebCli,nCredCli,nSalAc)
	
	Local cDisp	:=	cTelef + " - " + cContact

	If nSalAc != 0 .Or. mv_par06 == 1
		If mv_par05 < 2
			@ nLine,  00 PSAY Replicate( ".", 132 )
			nLine := nLine + 1
			@ nLine,  00 PSAY STR0010 + cCodCli + " (" + ; //"SUB-TOTALES DEL CLIENTE "
			Left( cDisp, 40 ) + ")"
		Else
			@ nLine,  00 PSAY cCodCli
			@ nLine,  14 PSAY cCliente + " (" +  Left( cDisp, 40 ) + ")"
		EndIf
		@ nLine,  92 PSAY nDebCli  PICTURE TM(nDebCli,14,nDecs) //"99,999,999.99"
		@ nLine, 107 PSAY nCredCli PICTURE TM(nCredCli,14,nDecs) //"99,999,999.99"
		@ nLine, 122 PSAY nSalAC   PICTURE TM(nSalAC,14,nDecs) //"99,999,999.99"
		nLine := nLine + 1
	EndIf

	If mv_par05 < 2
		@ nLine,  00 PSAY Replicate( ".", 132 )
		nLine := nLine + 2
	EndIf

	nDebCli  := 0
	nCredCli := 0
	nSalAC   := 0

Return Nil


Static Function PrintTotG(nLine,nTotDeb,nTotCred)

	@ nLine,  00 PSAY Replicate( ".", 132 )
	nLine := nLine + 1

	@ nLine,  00 PSAY STR0011 // "TOTALES GENERALES:"
	@ nLine,  91 PSAY nTotDeb            PICTURE TM(nTotDeb,15,nDecs) //"99,999,999.99"
	@ nLine, 106 PSAY nTotCred           PICTURE TM(nTotCred,15,nDecs) //"99,999,999.99"
	//   @ nLine, 112 PSAY nTotMO             PICTURE "99,999,999.99"
	@ nLine, 121 PSAY nTotDeb-nTotCred   PICTURE TM(nTotDeb-nTotCred,15,nDecs) //"99,999,999.99"
	nLine := nLine + 1

	@ nLine,  00 PSAY Replicate( ".", 132 ) + Chr( 12 )
	nLine := nLine + 2

Return Nil

// Grava as baixas manuais que houverem do titulo corrente no arquivo de trabalho
Static Function LeBaixaMFatur(cChave)
	
	Local nMoeda	:= mv_par13
	Local cSeq		:= ""
	Local nReg		:= 0
	Local dDatade	:= mv_par03
	Local dDataAte	:= mv_par04
	
	SE5->(DbSeek(xFilial("SE5") + cChave))
	While cChave== SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) ;
	.AND.  SE5->E5_MOTBX <> 'CMP' .AND. ! SE5->(EOF()) .AND. SE5->E5_DATA >= dDatade .and. SE5->E5_DATA <= dDataAte
		cSeq := SE5->E5_SEQ
		nReg := SE5->(Recno())
		If SE5->E5_TIPODOC $ "VL|CP" .Or. (SE5->E5_TIPODOC == "BA" .And. SE5->E5_MOTBX $ 'CEC|DAC')  // Baixa manual e baixa por compensacao entre carteiras
			SE5->(DbSkip())
			If ! (cChave+cSeq = SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ) ;
			.And. SE5->E5_TIPODOC = "ES" .Or. SE5->E5_MOTBX== 'CMP') // Nao faz nada se Houver Estorno da baixa
				SE5->(DbGoto(nReg))
				TRB->( DbAppend() )
				TRB->CODCLI    := cCodCli
				TRB->CLIENTE   := cCliente
				TRB->TELEFONOS := cTelef
				TRB->CONTACTO  := cContact
				If nMoeda == 1 .and. cPaisLoc == "ARG"
					TRB->Credito	:= Round(xMoeda(SE5->E5_VALOR,SE1->E1_MOEDA,SE1->E1_MOEDA,,nDecs+1,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0 ) ),nDecs)
				ElseIf nMoeda <> 1 .and. cPaisLoc == "ARG" 				  
					TRB->Credito	:= Round(xMoeda(SE5->E5_VLMOED2,SE1->E1_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0 ) ),nDecs)
				Else	
					TRB->Credito	:= Round(xMoeda(SE5->E5_VALOR,SE1->E1_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0 ) ),nDecs)
				EndIf	
				TRB->TIPSAL		:= "A"
				TRB->Saldo 		:= - TRB->Credito
				TRB->NRODOC		:= SE5->E5_NUMERO
				TRB->TIPODOC	:= SE5->E5_TIPODOC
				TRB->SERIE		:= SE5->E5_PREFIXO
				TRB->FECHA		:= SE5->E5_DATA
			EndIf
		ElseIf SE5->E5_TIPODOC $ "JR/MT/DC/IS" .And. SE5->E5_SITUACA != "C" // Juros, Multa, Desconto, Impsubst(localiz"CHI")
			TRB->( DbAppend() )
			TRB->CODCLI    := cCodCli
			TRB->CLIENTE   := cCliente
			TRB->TELEFONOS := cTelef
			TRB->CONTACTO  := cContact
			If SE5->E5_TIPODOC = "DC"
				TRB->TIPSAL	:= "A"
				TRB->Credito	:= Round(xMoeda(SE5->E5_VALOR,SE1->E1_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0) ),nDecs)
				TRB->Saldo	:= - TRB->Credito
			Else
				TRB->TIPSAL	:= "D"
				TRB->Debito	:= Round(xMoeda(SE5->E5_VALOR,SE1->E1_MOEDA,nMoeda,,nDecs+1,IIf(MV_PAR12 == 2,IIf(SE1->E1_TXMOEDA>0,SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0)  ),nDecs)
				TRB->Saldo	:= TRB->Debito
			EndIf
			TRB->NRODOC		:= SE5->E5_NUMERO
			TRB->TIPODOC	:= SE5->E5_TIPODOC
			TRB->SERIE		:= SE5->E5_PREFIXO
			TRB->FECHA		:= SE5->E5_DATA
		EndIf
		SE5->(DbSkip())
	EndDo
	
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerAtu     บAutor  ณTotvs               บ Data ณ  13/01/16   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o recibo estแ ativo                              บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAFIN                                                     บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VerAtu()

	Local lRet  := .T. 
	Local aArea := GetArea()

	DbSelectArea('FJT')
	DbSetorder(1)

	If DbSeek(xFilial()+SEL->EL_SERIE+SEL->EL_RECIBO+SEL->EL_VERSAO)
		If FJT->FJT_VERATU <> '1'
			lRet := .F.
		EndIf
	EndIf

	RestArea(aArea)

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCxCDifClt     บAutor  ณAlf. Medrano    บ Data ณ  24/01/19   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAgrega los documentos de tipo CC                             บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบParametrosณaTipDoc .- Tipos de Documentos                               บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบUso       ณ SIGAFIN                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCxCDifClt(aTipDoc)

	Local cQryCxC 	:= ''
	Local bBlock 
	Local cTipo 	:= ''
	Local nPosTp 	:= 0
	Local nX 		:= 0
	Local lTipoIn 	:= .T.
	Local lTipoNg 	:= .T.
	Local cAliastmp	:= criatrab( nil, .f. )
	Local aCRNEG 	:= {}
	Local aCRNEGTW 	:= {}
	Local aRCANT	:= {}
	Local nMoeda:= mv_par13
	Local aSepara := {'|', ',', '-'}

	aCRNEG := fSeparaMV(MV_CRNEG +"|"+MVRECANT,aSepara)
	aCRNEGTW := fSeparaMV(MV_CRNEG +"," + SuperGetMv("MV_CRNEG",.F.,"NCC,NDE,RA"),aSepara)
	
	If MV_PAR14 == 1
			bBlock := {|| !Empty( (cAliastmp)-> E1_RECIBO)}
	ElseIf MV_PAR14 == 2
			bBlock := {|| Empty( (cAliastmp)-> E1_RECIBO)}	
	Else
		bBlock := {|| .T.}
	EndIf
	
	cQryCxC := " SELECT FJT_CLIENT, FJT_LOJA, "
	cQryCxC += " A1_COD,A1_NOME,A1_TEL,A1_CONTATO,A1_LOJA, "
	cQryCxC += " E1_RECIBO, E1_PREFIXO, E1_NUM,E1_PARCELA, E1_NUMLIQ, E1_MOEDA,E1_TIPO, E1_CONVERT, E1_EMISSAO,E1_ORIGEM,E1_SALDO,E1_TIPO,E1_VENCREA,E1_CLIENTE,E1_TXMOEDA,E1_VALOR, "
	cQryCxC += " EL_PREFIXO, EL_NUMERO,EL_PARCELA, EL_TIPO "
	If cPaisLoc =="PTG"
		cQryCxC += " ,E1_NODIA "
	EndIf
	cQryCxC += " FROM " + RetSqlName('FJT') + " FJT "
	cQryCxC += " INNER JOIN " + RetSqlName('SEL') + " SEL ON EL_SERIE=FJT_SERIE AND EL_RECIBO = FJT_RECIBO "
	cQryCxC += " INNER JOIN " + RetSqlName('SE1') + " SE1 ON E1_PREFIXO = EL_PREFIXO AND E1_NUM = EL_NUMERO AND E1_PARCELA = EL_PARCELA AND E1_TIPO = EL_TIPO "
	cQryCxC += " INNER JOIN " + RetSqlName('SA1') + " SA1 ON A1_COD = "+ Iif(cPaisLoc <> "ARG","FJT_CLIENT ","EL_CLIENTE " ) +"AND "+ Iif(cPaisLoc <> "ARG","FJT_LOJA ","EL_LOJA " ) +" = A1_LOJA "                                                                                                                                                                                                                                                        
	cQryCxC += " WHERE EL_EMISSAO BETWEEN '" + DTOS(mv_par03) + "' AND  '" + DTOS(mv_par04) + "' "
	cQryCxC += " AND EL_CLIENTE <> EL_CLIORIG " // AND EL_RECIBO = '22012019_01 ' "
	cQryCxC += " AND " + Iif(cPaisLoc <> "ARG","FJT_CLIENT ","EL_CLIENTE " ) + "BETWEEN '" + mv_par01 + "' AND '" + mv_par02 + "' " // AND EL_SERIE = ' ' "
	cQryCxC += " AND FJT_FILIAL= '" + xFilial('FJT') +" ' "
	cQryCxC += " AND E1_FILIAL = '" + xFilial('SE1') +" ' "
	cQryCxC += " AND EL_FILIAL = '" + xFilial('SEL') +" ' "
	cQryCxC += " AND A1_FILIAL = '" + xFilial('SA1') +" ' "
	cQryCxC += " AND A1_FILIAL = '" + xFilial('SA1') +" ' "
	cQryCxC += " AND FJT.D_E_L_E_T_ = ' ' "
	cQryCxC += " AND SEL.D_E_L_E_T_ = ' ' "
	cQryCxC += " AND SE1.D_E_L_E_T_ = ' ' "
	cQryCxC += " AND SA1.D_E_L_E_T_ = ' ' "
	
	cQryCxC := ChangeQuery(cQryCxC)   	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryCxC),cAliastmp,.T.,.T.)
	TCSetField(cAliastmp,"E1_EMISSAO",	"D",8,0) // Formato de fecha 
	TCSetField(cAliastmp,"E1_VENCREA",	"D",8,0) // Formato de fecha 

	While !(cAliastmp)->(Eof())

		If  cPaisLoc<>"BRA" .And. MV_PAR13 == (cAliastmp)->E1_MOEDA  .And.  (cAliastmp)->E1_CONVERT=='N' .And. MV_PAR12 == 1
			dbSkip()
			Loop
		EndIf
		//Ao extrair o relat๓rio em moeda 2 nใo deve exibir os tํtulos oriundos de varia็ใo cambial (FINA074)
		If nMoeda <> 1 .And. Upper(AllTrim((cAliastmp)->E1_ORIGEM)) $ 'FINA074'
			dbSkip()
			Loop
		EndIf
		If cPaisLoc == "ARG" .AND. Alltrim((cAliastmp)->E1_TIPO) != "CC"
			dbSkip()
			Loop
		EndIf	
		If !SubStr(Alltrim((cAliastmp)->E1_TIPO), 1, 2 ) $ "TF-CH-EF" .And. (cAliastmp)->E1_EMISSAO <= dDataBase .AND.  Eval(bBlock) .And. IIf(mv_par06 != 1,(cAliastmp)->E1_SALDO > 0,.T.)	
			
			For nX := 1 To Len(aCRNEG)
				If Alltrim((cAliastmp)->E1_TIPO) == Alltrim(aCRNEG[nX])
					lTipoIn := .T.
					Exit
				Else
					lTipoIn := .F.
				EndIf
			Next
			
			For nX := 1 To Len(aCRNEGTW)
				If Alltrim((cAliastmp)->E1_TIPO) == Alltrim(aCRNEGTW[nX])
					lTipoNg := .T.
					Exit
				Else
					lTipoNg := .F.
				EndIf
			Next
			
			If (lTipoIn .And. !(Alltrim(E1_ORIGEM)$"FINA087A|FINA840|"+Iif(FindFunction('OriCobrDiv'),OriCobrDiv(),""))) .or. !(lTipoIn)
			
				If ( mv_par10 < 2 .AND. (cAliastmp)->E1_EMISSAO < Min(mv_par03,dDatabase) ) .OR.;
				( mv_par10 > 1 .AND. (cAliastmp)->E1_VENCREA < mv_par03 )

					DbSelectArea( "TRB" )
					DbSetOrder(1)

					If !DbSeek( (cAliastmp)->E1_CLIENTE+"SA")

						TRB->( DbAppend() )
						TRB->CODCLI    := (cAliastmp)->A1_COD
						TRB->LOJA      := (cAliastmp)->A1_LOJA
						TRB->CLIENTE   := (cAliastmp)->A1_NOME
						TRB->TELEFONOS := (cAliastmp)->A1_TEL
						TRB->CONTACTO  := (cAliastmp)->A1_CONTATO
						TRB->TIPODOC   := "SA"
						TRB->FECHA     := mv_par03 - 1

					EndIf
					
					IF lTipoNg .OR. SubStr( (cAliastmp)->E1_TIPO, 3, 1 ) == "-"
						TRB->CREDITO := TRB->CREDITO + xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))
						TRB->SALDO   := TRB->SALDO - xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,  IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))
					ElseIf (Alltrim((cAliastmp)->E1_TIPO) <> Alltrim(GetMV("MV_SIMB1") )) .and. Empty((cAliastmp)->E1_NUMLIQ)
						TRB->DEBITO  := TRB->DEBITO + xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))
						TRB->SALDO   := TRB->SALDO + xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2 ,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))
					ElseIf !Empty((cAliastmp)->E1_NUMLIQ)
						TRB->NUMLIQ	 := (cAliastmp)->E1_NUMLIQ
						TRB->DEBITO  := TRB->DEBITO + xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))
						TRB->SALDO   := TRB->SALDO + xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2 ,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0))				
					EndIf
					LeBaixaMfatur((cAliastmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+FJT_CLIENT+FJT_LOJA))
					
				ElseIf (Alltrim((cAliastmp)->E1_TIPO) <> Alltrim(GetMV("MV_SIMB1") ))

					If ( mv_par10 < 2 .AND. (cAliastmp)->E1_EMISSAO <= mv_par04 ) .OR.;
					( mv_par10 > 1 .AND. (cAliastmp)->E1_VENCREA <= mv_par04 )

						TRB->( DbAppend() )
						TRB->CODCLI    := (cAliastmp)->A1_COD
						TRB->LOJA      := (cAliastmp)->A1_LOJA
						TRB->CLIENTE   := (cAliastmp)->A1_NOME
						TRB->TELEFONOS := (cAliastmp)->A1_TEL
						TRB->CONTACTO  := (cAliastmp)->A1_CONTATO
						cTipo 	:= (cAliastmp)->E1_TIPO
						nPosTp	:=	AScan( aTipDoc, { |a| a[1] == (cAliastmp)->E1_TIPO })
						cTipo	:=	IIf(nPosTp	>	0	, aTipDoc[nPosTp][2],cTipo)
						TRB->SERIE   := AllTrim( (cAliastmp)->E1_PREFIXO )
						TRB->NRODOC  := (cAliastmp)->E1_NUM
						TRB->FECHA   := (cAliastmp)->E1_EMISSAO
						TRB->FECVTO  := (cAliastmp)->E1_VENCREA
						TRB->TIPODOC := cTipo
            			TRB->TIPSAL  := Iif (lTipoIn .Or. Substr(Alltrim((cAliastmp)->E1_TIPO), 3, 1 ) == "-", "A", "D")
						If cPaisLoc =="PTG"
							TRB->NODIA  := (cAliastmp)->E1_NODIA
						EndIf

						If TRB->TIPSAL == "A" .Or. lTipoNg     
							TRB->SALDO     := xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )  * -1
							TRB->CREDITO   := xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )
						ElseIf Empty((cAliastmp)->E1_NUMLIQ)
							TRB->SALDO     := xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )
							TRB->DEBITO    := xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )
						ElseIf !Empty((cAliastmp)->E1_NUMLIQ)
							TRB->NUMLIQ		:= (cAliastmp)->E1_NUMLIQ
							TRB->SALDO     := xMoeda((cAliastmp)->E1_SALDO,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )
							TRB->DEBITO    := xMoeda((cAliastmp)->E1_VALOR,(cAliastmp)->E1_MOEDA,nMoeda,IIf(MV_PAR12 == 2, (cAliastmp)->E1_EMISSAO, Nil ),,IIf(MV_PAR12 == 2,IIf((cAliastmp)->E1_TXMOEDA>0,(cAliastmp)->E1_TXMOEDA,RecMoeda((cAliastmp)->E1_EMISSAO,(cAliastmp)->E1_MOEDA)),0) )
						EndIf
						LeBaixaMfatur((cAliastmp)->(E1_PREFIXO+E1_NUM+E1_PARCELA+ E1_TIPO + FJT_CLIENT + FJT_LOJA))
					EndIf
				EndIf
			EndIf
		EndIf
		DbSkip()
	EndDo	
	
return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfSeparaMV     บAutor  ณAlf. Medrano    บ Data ณ  24/01/19    บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณSepara y agrega a array los tipos de documentos              บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบParametrosณcParaMV .-Cadena con los tipos de documentos ejemplo 'NCC|RA'บฑฑ
ฑฑบ          ณaSepara .-array con los separadores ejemplo {'|','-',','}    บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบUso       ณ SIGAFIN                                                     บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
static Function fSeparaMV(cParaMV, aSepara)

	Local nX 		:= 0
	Local nY		:= 0
	Local nJ		:= 0
	Local lSepara	:= .F.
	Local aCRNEG 	:= {}
	
	Default cParaMV	:= ''
	Default aSepara := {'|', ',', '-'}
	
	For nX = 1 to Len(aSepara)
		If lSepara
			For nY := 1 to Len(aCRNEG)
				If AT(aSepara[nX], aCRNEG[nY])
					aRCANT := STRTOKARR(aCRNEG[nY], aSepara[nX])
					ADEL(aCRNEG, nY) 
					For nJ := 1 To Len(aRCANT)
						IIF(nJ == 1,aCRNEG[Len(aCRNEG)] := aRCANT[nJ], AADD(aCRNEG, aRCANT[nJ]))
					Next
				EndIf
			Next 
		Else
			If AT(aSepara[nX], cParaMV)
				aCRNEG := STRTOKARR(cParaMV, aSepara[nX])
				lSepara:= .T.
			EndIf
		EndIf
	Next
return aCRNEG
