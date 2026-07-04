/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr085.Ch"
#Include "PROTHEUS.Ch"

#define TAM_SUBLOTE 03
#define TAM_DATAL   10
#define TAM_LOTE    06
#define TAM_DOC     06
#define TAM_CT2KEY  70
#define TAM_LANCDEB 17
#define TAM_LANCCRD 17
#define TAM_HP      03
#define TAM_TOTAIS  17
#define TAM_DOCHIS  80
//amarracao
Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//Tradução PTG

// 17/08/2009 -- Filial com mais de 2 caracteres

//-------------------------------------------------------------------
/*{Protheus.doc} CTBR085
Relacao Lancamentos Classificados por Sublote/Doc.Fiscal 

@author Alvaro Camillo Neto
   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
User Function CTBR085()

Local aCtbMoeda	:= {}
Local lOk 		:= .T.
Local oReport

Private cPerg  := "CTR085"

Pergunte( cPerg, .T. )

If lOk
	aCtbMoeda  	:= CtbMoeda(mv_par09)
	If Empty(aCtbMoeda[1])
		Help(" ",1,"NOMOEDA")
		lOk := .F.
	Endif
Endif

If lOk
	oReport := ReportDef(aCtbMoeda)
	oReport:PrintDialog()
EndIf	

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Indica se esta sendo chamado da rotina de consulta º±±
±±º          ³         da visao gerencial                                 º±±
±±º          ³ EXPC1 - Grupo de perguntas do relatorio                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ReportDef(aCtbMoeda)

Local cReport	 := "CTBR085"

Local cAliasQry1 := GetNextAlias()
Local aTamConta	 := TAMSX3("CT1_CONTA")
Local nTamHist	 := Len(CriaVar("CT2_HIST"))
Local cArqTmp	 :=""	
Local lUseDocHis	:= X3USADO("CTC_DOCHIS")

Local oReport
Local oSubLote        
Local oLanc
Local oTotais
Local lColDbCr 		:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty

Pergunte(cPerg, .F.)                   

oReport:= TReport():New(cReport,STR0003,cPerg,{|oReport| ReportPrint(oReport,aCtbMoeda)},STR0001 +" "+ STR0002)//"Este programa ira imprimir o Relatorio de Lancamentos"###"por SubLote / Doc. Fiscal."###"Lancamentos Classificados por SubLote/Doc.Fiscal"
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.F.)

oSubLote := TRSection():New(oReport,STR0025,{"cArqTmp"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/) //"Lote"
oSubLote :SetTotalInLine(.F.)

TRCell():New(oSubLote,"SUBLOTE"  ,"cArqTmp",STR0028,/*Picture*/,TAM_SUBLOTE,/*lPixel*/,/*{|| code-block de impressao }*/) //"Sub-lote"
TRCell():New(oSubLote,"DATAL"    ,"cArqTmp",STR0027    ,/*Picture*/,TAM_DATAL,/*lPixel*/,/*{|| code-block de impressao }*/) //"Data"
TRCell():New(oSubLote,"LOTE"     ,"cArqTmp",STR0025  ,/*Picture*/,TAM_LOTE,/*lPixel*/,/*{|| code-block de impressao }*/) //"Lote"  
If cPaisLoc == "ARG" .And. lUseDocHis
	TRCell():New(oSubLote,"DOCHIS"	,"cArqTmp",STR0043,/*Picture*/,TAM_DOCHIS	,/*lPixel*/,/*{|| code-block de impressao }*/) //"Historial Doc."
EndIf

oLanc := TRSection():New(oReport,STR0026     ,{"cArqTmp","CT1"},, .F., .F. )//"Lancamento"

TRCell():New(oLanc,"DOC"      ,"cArqTmp",STR0029	,/*Picture*/,TAM_DOC,/*lPixel*/,/*{|| code-block de impressao }*/)// Documento
TRCell():New(oLanc,"CONTA"    ,"cArqTmp",STR0030 	,/*Picture*/,aTamConta[1] ,/*lPixel*/,/*{|| code-block de impressao }*/)// Codigo da Conta
TRCell():New(oLanc,"CT2KEY"	,"cArqTmp",STR0031 	,/*Picture*/,TAM_CT2KEY,/*lPixel*/,/*{|| code-block de impressao }*/)// CHAVE DE AGLUTINACAO DOC.FISCAL.
TRCell():New(oLanc,"LANCDEB"  ,"cArqTmp",STR0032 	,/*Picture*/,TAM_LANCDEB,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCDEB,,,17,2,.F.,,,,,,,,,.F.,lColDbCr ) })// Debito
TRCell():New(oLanc,"LANCCRD"  ,"cArqTmp",STR0033 	,/*Picture*/,TAM_LANCCRD,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCCRD,,,17,2,.F.,,,,,,,,,.F.,lColDbCr ) })// Credito
TRCell():New(oLanc,"HP"       ,"cArqTmp",STR0034   ,/*Picture*/,TAM_HP,/*lPixel*/,/*{|| code-block de impressao }*/)// Codigo do Historico padrao
TRCell():New(oLanc,"HISTORICO","cArqTmp",STR0035   ,/*Picture*/,nTamHist,/*lPixel*/,/*{|| code-block de impressao }*/)// Historico		

TRPosition():New( oLanc, "CT1", 1, {|| xFilial("CT1") + cArqTMP->CONTA })

oLanc:SetHeaderPage()

oTotais := TRSection():New( oReport,STR0036,,, .F., .F. ) //"Total"
TRCell():New( oTotais, "TOT",,OemToAnsi(""),/*Picture*/,TAM_DOC+aTamConta[1]+TAM_CT2KEY,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais, "TOT_LANCDEB",,STR0037 	,Tm(0,17),TAM_TOTAIS,/*lPixel*/,{|| ValorCTB(oTotais:Cell("TOT_LANCDEB"),,,18,2,.F.,,,,,,,,,.F.,lColDbCr)})
TRCell():New( oTotais, "TOT_LANCCRD",,STR0038	,Tm(0,17),TAM_TOTAIS,/*lPixel*/,{|| ValorCTB(oTotais:Cell("TOT_LANCCRD"),,,18,2,.F.,,,,,,,,,.F.,lColDbCr)})
TRCell():New( oTotais, "TOT_INF"    ,,STR0012	,Tm(0,17),TAM_TOTAIS,/*lPixel*/,{|| ValorCTB(oTotais:Cell("TOT_INF")    ,,,18,2,.F.,,,,,,,,,.F.,lColDbCr)})//"INFORMADO"
TRCell():New( oTotais, "TOT_DIG"    ,,STR0013	,Tm(0,17),TAM_TOTAIS,/*lPixel*/,{|| ValorCTB(oTotais:Cell("TOT_DIG")    ,,,18,2,.F.,,,,,,,,,.F.,lColDbCr)})//"DIGITADO"
TRCell():New( oTotais, "TOT_DIFER"  ,,STR0010	,Tm(0,17),TAM_TOTAIS,/*lPixel*/,{|| ValorCTB(oTotais:Cell("TOT_DIFER")  ,,,18,2,.F.,,,,,,,,,.F.,lColDbCr)})//"DIFERENCA"

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  07/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,aCtbMoeda)

Local oSubLote := oReport:Section(1)
Local oLanc    := oReport:Section(2)
Local oTotais  := oReport:Section(3)

/*Verificar a necessidade*/
Local aTamConta	:= TamSX3("CT1_CONTA")
Local nTamConta := aTamConta[1]
Local cDescMoeda	:= Alltrim(aCtbMoeda[2])
Local cSbLoteAnt	:= ""
Local cLoteAnt		:= ""
Local cDocAnt		:= ""
Local dDataAnt      := ""

Local nInf		:= 0	// Valor informado no lote/documento
Local nDig		:= 0	// Valor (Soma) dos valores do lancamento.
Local nDif 		:= 0
Local nDeb 		:= 0
Local nCrd 		:= 0
Local nDebSbLote:= 0
Local nCrdSbLote:= 0
Local nDebDoc	:= 0
Local nCrdDoc	:= 0
Local nTotCrdG	:= 0
Local nTotDebG	:= 0

Local cArqTmp		:= ""
Local cContaIni		:= ""
Local cContaFim		:= Repl("Z",nTamConta)
Local aSetOfBook	:= {"","",0,"","","","","",1,""}

Local dDataIni		:= mv_par01
Local dDataFim		:= mv_par02
Local cLoteIni		:= mv_par03
Local cLoteFim		:= mv_par04
Local cSbLoteIni	:= mv_par05
Local cSbLoteFim	:= mv_par06
Local cDocIni		:= mv_par07
Local cDocFim		:= mv_par08
Local cMoeda		:= mv_par09
Local cSaldo		:= mv_par11
Local lQuebra		:= Iif(mv_par12 == 1,.T.,.F.)
Local lImpDoc0		:= Iif(mv_par13 == 1,.T.,.F.)
Local lTotLote		:= Iif(mv_par14 == 1,.T.,.F.)
Local lTotDoc		:= Iif(mv_par15 == 1,.T.,.F.)

Local lImpAlg       := .F.
Local lUseDocHis	:= X3USADO("CTC_DOCHIS")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao   					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter( {|	oMeter, oText, oDlg, lEnd | ;
			CTBR420Raz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,;
					    cMoeda,dDataIni,dDataFim,aSetOfBook,.F.,cSaldo,"3",.T.,cLoteIni,cLoteFim,;
						 cSbLoteIni,cSbLoteFim,cDocIni,cDocFim,oLanc:GetAdvPlExp('CT1'))},;
						  STR0008,;//"Criando Arquivo Tempor rio..."
						   STR0007)//"Emissao do Relat. SubLote/Doc.Fiscal"

oReport:SetTitle( oReport:Title()+" - "+STR0021+cDescMoeda+STR0022+DTOC(dDataIni)+STR0023+DTOC(dDataFim)+CtbTitSaldo(mv_par11) )//"EM"##"DE"##"ATE"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a impressao do relatorio                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("cArqTmp")
dbGotop()
oLanc:SetMeter( RecCount() )
oLanc:NoUserFilter()
oLanc:Init()
Do While !EoF() .And. !oLanc:Cancel()

    oLanc:IncMeter()

    If oLanc:Cancel()
    	Exit
    EndIf        

	If !lImpDoc0 .And. Empty(cArqTmp->CT2KEY) 
		dbSkip()
		Loop
	Endif	

	If 	cArqTmp->SUBLOTE <> cSbLoteAnt

		oSubLote:Cell("SUBLOTE"):Enable()
		oSubLote:Cell("LOTE"):Disable()
		oSubLote:Cell("DATAL"):Disable()
		If cPaisLoc == "ARG" .And. lUseDocHis
			oSubLote:Cell("DOCHIS"):Disable()
		EndIf

    EndIf

	IF (cLoteAnt <> cArqTmp->LOTE .Or. Dtos(dDataAnt) <> Dtos(cArqTmp->DATAL))

		oSubLote:Cell("SUBLOTE"):Disable()
		oSubLote:Cell("LOTE"):Enable()
		oSubLote:Cell("DATAL"):Enable()
		If cPaisLoc == "ARG" .And. lUseDocHis
			oSubLote:Cell("DOCHIS"):Enable()
		EndIf

		lImpAlg := .T.
	EndIf
	
	oSubLote:Init()
	oSubLote:PrintLine()
	oSubLote:Finish()
	
	oReport:SkipLine()
	
	If mv_par10 == 2
		dbSelectArea("CT1")
		dbSetOrder(1)
		If MsSeek(xFilial()+cArqTmp->CONTA)
			oLanc:Cell("CONTA"):SetBlock( { || CT1->CT1_RES } )
		EndIf
    	dbSelectArea("cArqTmp")
	Else
		oLanc:Cell("CONTA"):SetBlock( { || cArqTmp->CONTA } )
	Endif			
	
	oLanc:PrintLine()    
	
	//Totaliza lancamentos
	//Por lote
	nCrd += cArqTmp->LANCCRD
	nDeb += cArqTmp->LANCDEB
	//Por sub lote
	nDebSbLote += cArqTmp->LANCDEB
	nCrdSbLote += cArqTmp->LANCCRD
	//Por Documento
	nCrdDoc += cArqTmp->LANCCRD
	nDebDoc += cArqTmp->LANCDEB
  	//Total Geral
  	nTotCrdG += cArqTmp->LANCCRD
    nTotDebG += cArqTmp->LANCDEB

    //Guarda valores anterior
	cSbLoteAnt  := cArqTmp->SUBLOTE
	cLoteAnt	:= cArqTmp->LOTE
	cDocAnt		:= cArqtmp->DOC
	dDataAnt	:= cArqTmp->DATAL
  	dbSelectArea("cArqTmp")
	dbSkip()
    
    //Se for para totalizar por documento
	If lTotDoc .And.;
		(cLoteAnt <> cArqTmp->LOTE	.Or.;
		  cSbLoteAnt <> cArqTmp->SUBLOTE .Or.;
    	   cDocAnt <> cArqTmp->DOC	.Or.;
            Dtos(dDataAnt) <> Dtos(cArqTmp->DATAL) )

		oTotais:Cell( "TOT_LANCDEB"):SetBlock( { || nDebDoc } )
		oTotais:Cell( "TOT_LANCCRD"):SetBlock( { || nCrdDoc } )
			
		CTC->(MsSeek(xFilial()+dtos(dDataAnt)+cLoteAnt+cSbLoteAnt+cDocAnt+cMoeda))
		oTotais:Cell( "TOT_INF"):SetBlock( { || CTC->CTC_INF } )//STR0012##"INFORMADO"
		oTotais:Cell( "TOT_DIG"):SetBlock( { || CTC->CTC_DIG } )//STR0013##"DIGITADO"
		oTotais:Cell( "TOT_DIFER"):SetBlock( { || Abs(CTC->CTC_DIG-CTC->CTC_INF) } )//STR0010##"DIFERENCA"
		
		oTotais:Cell("TOT"):SetTitle(STR0039+cDocAnt)//"Total documento: "
		
		oTotais:Init()
		oTotais:PrintLine()
		oTotais:Finish()

        // Zera os totalizador do documento
		nDebDoc := 0
		nCrdDoc := 0
	Else
		oTotais:Cell( "TOT_LANCDEB"):SetBlock( { || 0 } )
		oTotais:Cell( "TOT_LANCCRD"):SetBlock( { || 0 } )
		oTotais:Cell( "TOT_INF"):SetBlock( { || 0 } )
		oTotais:Cell( "TOT_DIG"):SetBlock( { || 0 } )
		oTotais:Cell( "TOT_DIFER"):SetBlock( { || 0 } )
	EndIF
    //Se for para totalizar por lote...
	If lTotLote .And.;
		(cLoteAnt <> cArqTmp->LOTE .Or.;
	     cSbLoteAnt <> cArqTmp->SUBLOTE .Or.;
           Dtos(dDataAnt) <> Dtos(cArqTmp->DATAL) )
            
		oTotais:Cell("TOT_LANCDEB"):SetBlock( { || nDeb } )
		oTotais:Cell("TOT_LANCCRD"):SetBlock( { || nCrd } )

		aRetCT6 := CtbSaldoLote(cLoteAnt,cSbLoteAnt,dDataAnt,cMoeda)
		nInf := aRetCT6[3]
		nDig := aRetCT6[4]
		
		oTotais:Cell("TOT_INF"):SetBlock( { || nInf} )//STR0012##"INFORMADO"
		oTotais:Cell("TOT_DIG"):SetBlock( { || nDig } )//STR0013##"DIGITADO"
		oTotais:Cell("TOT_DIFER"):SetBlock( { || Abs(nDig-nInf) } )//STR0010##"DIFERENCA"

		oTotais:Cell("TOT"):SetTitle(STR0040+cLoteAnt)

		oTotais:Init()
		oTotais:PrintLine()
		oTotais:Finish()

        // Zera os totalizador do lote
		nCrd := 0
		nDeb := 0
	EndIf                           

    //Se for mudou o sub-lote.
	If cSbLoteAnt <> cArqTmp->SUBLOTE
		oTotais:Cell("TOT_INF"):Disable()
		oTotais:Cell("TOT_DIG"):Disable()
		oTotais:Cell("TOT_DIFER"):Disable()

		oTotais:Cell("TOT_LANCDEB"):SetBlock( { || nDebSbLote } )
		oTotais:Cell("TOT_LANCCRD"):SetBlock( { || nCrdSbLote } )

		oTotais:Cell("TOT"):SetTitle(STR0041+cSbLoteAnt) //"Total sub-lote: "

		oTotais:Init()
		oTotais:PrintLine()
		oTotais:Finish()
        // Zera os totalizador do lote
		nDebSbLote := 0
		nCrdSbLote := 0

		oTotais:Cell("TOT_INF"):Enable()
		oTotais:Cell("TOT_DIG"):Enable()
		oTotais:Cell("TOT_DIFER"):Enable()

		If lQuebra
	       oReport:EndPage(.T.) // Quebra direto
		EndIf           
	EndIF
EndDo

oReport:SkipLine()

If lImpAlg
	oTotais:Cell("TOT_INF"):Disable()
	oTotais:Cell("TOT_DIG"):Disable()
	oTotais:Cell("TOT_DIFER"):Disable()

	oTotais:Cell("TOT_LANCDEB"):SetBlock( { || nTotDebG } )
	oTotais:Cell("TOT_LANCCRD"):SetBlock( { || nTotCrdG } )

	oTotais:Cell("TOT"):SetTitle(STR0042) //"Total geral =>"

	oTotais:Init()
	oTotais:PrintLine()
	oTotais:Finish()
EndIf	
oLanc:Finish()


dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
   FErase(cArqTmp+GetDBExtension())
   FErase(cArqTmp+OrdBagExt())
EndIf	

Return                                                                          
