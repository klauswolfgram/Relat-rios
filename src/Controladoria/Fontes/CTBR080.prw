/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr080.Ch"
#Include "PROTHEUS.Ch"

#DEFINE TAM_VALOR 26
#DEFINE TAM_HIST  40

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema
Static __oPrepCT2 := Nil

// 17/08/2009 -- Filial com mais de 2 caracteres
// 09/09/2011 - Alterado tradução das colunas de Debito e Credito para Pais Mexico

//-------------------------------------------------------------------
/*{Protheus.doc} CTBR080
Relacao Lancamentos Classificados por Sublote  

@author Alvaro Camillo Neto
   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
User Function CTBR080()

Local aArea 	:= GetArea()
Local oReport

Private cPerg		:= "CTR080"
Private nomeProg	:= "CTBR080"

Private oFncTxt01D
Private oFncTxt01C
Private oFncTxt02D
Private oFncTxt02C
Private oFncTxt03D
Private oFncTxt03C
Private oFncTxt04D

Private dData		:= CtoD(" / / ")
Private cLote		:= ""
Private cSubLote	:= ""
Private cDoc		:= ""
Private lQuebra	:= .T.
Private cPicture    := PesqPict("CT2","CT2_VALOR")

// carrega as perguntas antes da impressão
Pergunte( "CTR080" , .F. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros       							³
//³ mv_par01    Orcamento De           									³
//³ mv_par02    Orcamento Ate          									³
//³ mv_par03    Calendario De          									³
//³ mv_par04    Calendario Ate         									³
//³ mv_par05    Moeda De               									³
//³ mv_par06    Moeda Ate              									³
//³ mv_par07    Revisao De               								³
//³ mv_par08    Revisao Ate              								³
//³ mv_par09 	Status Listados = Aberto/Gerado Saldo/Revisado/Todos	³
//³ mv_par10 	Filtra Por = Periodo/Data/Ambas/Nenhum               	³
//³ mv_par11    Periodo De             									³
//³ mv_par12    Periodo Ate            									³
//³ mv_par13    Data Inicial           									³
//³ mv_par14    Data Final             									³
//³ mv_par15    Valores Zerados        									³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()

If valtype( oReport ) == 'O'
	oReport:PrintDialog()
Endif

If __oPrepCT2 <> nil
	__oPrepCT2:Destroy()
EndIf

oReport := nil

	
RestArea(aArea)

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  27/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Indica se esta sendo chamado da rotina de consulta º±±
±±º          ³         da visao gerencial                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1 
Local oSection2
Local oTotais
Local cDesc1 	:= OemToAnsi(STR0001)	//"Este programa ira imprimir o Relatorio de Lancamentos"
Local cDesc2 	:= OemToansi(STR0002) //"por SubLote."
Local cDesc3	:= OemToansi(STR0003) //"    "
Local titulo 	:= OemToAnsi(STR0004) 	//"Lancamentos Classificados por SubLote"
Local lUseDocHis:= X3USADO("CTC_DOCHIS")
Local lColDbCr	:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty


oReport:= TReport():New(nomeProg,titulo,cPerg, {|oReport| Pergunte(cPerg,.F.), Iif(ReportPrint(oReport),.T.,oReport:CancelPrint())},cDesc1+" "+cDesc2+" "+cDesc3)
oReport:SetTotalInLine(.F.)

oSection1 := TRSection():New(oReport,STR0049,{"CT2"},/*aOrdem*/)	//"Lancamentos Contabeis-Lote"
TRCell():New(oSection1,"CT2_SBLOTE"	,"CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"CT2_DATA"	,"CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"CT2_LOTE"	,"CT2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
If cPaisLoc == "ARG" .And. lUseDocHis
	TRCell():New(oSection1,"CTC_DOCHIS"	,"CTC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| U_CTBR080HCL()})
EndIf

oSection2 := TRSection():New(oReport,STR0050,{"CT2"},/*aOrdem*/)	//"Lancamentos Contabeis-Detalhes"
oSection2:SetHeaderPage()
oSection2:SetNoFilter("CT2")


TRCell():New(oSection2,"CT2_DOC"	,"CT2",STR0031,/*Picture*/,TAMSX3("CT2_DOC")[1]+1/*Tamanho*/,/*lPixel*/,/*{|| }*/)	//"DOC"
TRCell():New(oSection2,"CT2_LINHA"	,"CT2",STR0032,/*Picture*/,TAMSX3("CT2_LINHA")[1]/*Tamanho*/,/*lPixel*/,/*{|| }*/)	//"LI"
TRCell():New(oSection2,"CT2DC"		,""   ,STR0033,/*Picture*/,6/*Tamanho*/,/*lPixel*/,{|| U_C080RetDC(CT2->CT2_DC)})    //"TP"
TRCell():New(oSection2,"CT2_DEB"	,""   ,STR0034,/*Picture*/,TAMSX3("CT2_DEBITO")[1]+5/*Tamanho*/,/*lPixel*/,{|| IIF (MV_PAR10 == 2,U_CodRed(CT2->CT2_DEBITO,"D"),CT2->CT2_DEBITO) })	//"CONTA DEBITO"
TRCell():New(oSection2,"CT2_CRED"	,""   ,STR0035,/*Picture*/,TAMSX3("CT2_CREDIT")[1]+5/*Tamanho*/,/*lPixel*/,{|| IIF (MV_PAR10 == 2,U_CodRed(CT2->CT2_CREDIT,"C"),CT2->CT2_CREDIT) })	//"CONTA CREDITO"
TRCell():New(oSection2,"CT2_HP"		,"CT2",STR0036,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)	//"HP"
TRCell():New(oSection2,"CT2HIST"	,""   ,STR0037,/*Picture*/,TAM_HIST/*Tamanho*/,/*lPixel*/,{|| CT2->CT2_HIST},"",.T.,"")    //"HISTORICO"
TRCell():New(oSection2,"CT2DEB"		,""   ,STR0038,/*Picture*/,TAM_VALOR,/*lPixel*/,{|| IIF( CT2->CT2_DC $ "1/3",ValorCTB( CT2->CT2_VALOR,,,TAM_VALOR,2,.F.,cPicture,"1",,,,,,,.F.,lColDbCr),"" ) },"RIGHT",,"RIGHT" )	//"VALOR DEB"
TRCell():New(oSection2,"CT2CRD"		,""   ,STR0039,/*Picture*/,TAM_VALOR,/*lPixel*/,{|| IIF( CT2->CT2_DC $ "2/3",ValorCTB( CT2->CT2_VALOR,,,TAM_VALOR,2,.F.,cPicture,"2",,,,,,,.F.,lColDbCr),"" ) },"RIGHT",,"RIGHT" )	//"VALOR CRED"
          
TRCell():New(oSection2,"CT2_CCD"  ,"CT2",STR0040,/*Picture*/,TAMSX3("CT2_CCD")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"C.CUSTO DB"
TRCell():New(oSection2,"CT2_CCC"  ,"CT2",STR0041,/*Picture*/,TAMSX3("CT2_CCC")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"C.CUSTO CR"
TRCell():New(oSection2,"CT2_ITEMD","CT2",STR0042,/*Picture*/,TAMSX3("CT2_ITEMD")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"ITEM CONT. DB"
TRCell():New(oSection2,"CT2_ITEMC","CT2",STR0043,/*Picture*/,TAMSX3("CT2_ITEMC")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"ITEM CONT. CR"
TRCell():New(oSection2,"CT2_CLVLDB","CT2",STR0044,/*Picture*/,TAMSX3("CT2_CLVLDB")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"CL.VAL. DB"
TRCell():New(oSection2,"CT2_CLVLCR","CT2",STR0045,/*Picture*/,TAMSX3("CT2_CLVLCR")[1]/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)	//"CL.VAL. CR"

oSection2:Cell("CT2_CCD"):Disable()
oSection2:Cell("CT2_CCC"):Disable()
oSection2:Cell("CT2_ITEMD"):Disable()
oSection2:Cell("CT2_ITEMC"):Disable()
oSection2:Cell("CT2_CLVLDB"):Disable()
oSection2:Cell("CT2_CLVLCR"):Disable()

oTotais := TRSection():New( oReport,STR0048,,, .F., .F. )	//"TOTAL"
TRCell():New( oTotais,"TOT"			,,""	 ,/*Picture*/,123		,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oTotais,"TOT_CT2DEB"	,,STR0046,/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")		//"TOTAL DEBITO"
TRCell():New( oTotais,"TOT_CT2CRD"	,,STR0047,/*Picture*/,TAM_VALOR	,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")		//"TOTAL CREDITO"

Return oReport

//-------------------------------------------------------------------
/*{Protheus.doc} CTBC020
Definicao do objeto do relatorio personalizavel e das secoes que serao utilizadas 
Imprime o relatorio do cadastro de plano gerencial 

@author Alvaro Camillo Neto
   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function ReportPrint(oReport)

Local oSection1		:= oReport:Section(1)
Local oSection2		:= oReport:Section(2)
Local oTotais		:= oReport:Section(3)
                          
Local aCtbMoeda		:= CtbMoeda(mv_par09)

Local bCond			:= {||.T.}
Local cFiltro 		:= ""

Local cMoeda		:= mv_par09
Local lCusto		:= (mv_par18==1)
Local lItem			:= (mv_par19==1)
Local lCLVL			:= (mv_par20==1)

Local lTotDoc		:= (mv_par13==1)
Local lTotLote		:= (mv_par14==1)
Local lTotSbLt		:= (mv_par15==1)
Local lTotSbLtGrl	:= (mv_par21==1)

Local nTotDeb		:= 0
Local nTotGerDeb	:= 0
Local nTotDocDeb	:= 0
Local nTotLotDeb	:= 0
Local nTotSbLtDb	:= 0
Local nTotGrlSbD	:= 0
Local nTotCrd		:= 0
Local nTotGerCrd	:= 0
Local nTotDocCrd	:= 0
Local nTotLotCrd	:= 0
Local nTotSbLtCr	:= 0
Local nTotGrlSbC	:= 0
Local lAllSL		:= If(Empty(mv_par11) .or. mv_par11=="*",.T.,.F.)
Local lColDbCr 		:= lIsRedStor // Disconsider cTipo in ValorCTB function, setting cTipo to empty only used in russia
Local lImpCompl		:= .F.

If Empty(aCtbMoeda[1])                       
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif

If lCusto .Or. lItem .Or. lCLVL
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf       

If lCusto// Imprimir Centro de Custo
	oSection2:Cell("CT2_CCD"):Enable()
	oSection2:Cell("CT2_CCC"):Enable()
EndIf
If lItem// Imprimir Item Contabil
	oSection2:Cell("CT2_ITEMD"):Enable()
	oSection2:Cell("CT2_ITEMC"):Enable()
EndIf
If lCLVL// Imprimir Classe de Valor
	oSection2:Cell("CT2_CLVLDB"):Enable()
	oSection2:Cell("CT2_CLVLCR"):Enable()
EndIf                                

dbSelectArea("CT2")
dbSetOrder(10) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Filtra dados somente para top connect, porque em codebase quando muda de ordem, perde o filtro. Eh necessario
// mudar de ordem para a impressao do historico complementar.
cFiltro := U_CTR080Fil(lAllSL)

oSection1:SetFilter(cFiltro,IndexKey()) //Seta o filtro padrão no objeto Section1 para que os layouts personalizados contenham esse filtro + filtro do usuário


oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataBase,oReport:Title(),,,,,oReport) } )

//ordena antes de imprimir
CT2->(dbSetOrder(1))
   
Do While !Eof() .And. !oReport:Cancel() .And. Eval(bCond)

	If oReport:Cancel()
		Exit
	EndIf	
		
	oSection1:Init()
	oSection1:Printline()
	oSection1:Finish()

	dData		:= CT2->CT2_DATA
	cLote		:= CT2->CT2_LOTE
	cSubLote	:= CT2->CT2_SBLOTE
	cDoc 		:= CT2->CT2_DOC

	Do While !Eof() .And. !oReport:Cancel() .And. CT2->( ( DtoS(CT2_DATA) + CT2_LOTE + CT2_SBLOTE ) == ( DTOS(dData) + cLote + cSubLote ))

		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		If ( CT2->CT2_DC <> "4" )       // Complemento de historico nao imprime valores

			oSection2:Init()
			oSection2:Printline()
			oSection2:Finish()

			
			If CT2->CT2_DC == "1" .Or. CT2->CT2_DC == "3"	
				nTotDeb 	+= CT2->CT2_VALOR
				nTotGerDeb	+= CT2->CT2_VALOR
				nTotDocDeb  += CT2->CT2_VALOR
				nTotLotDeb  += CT2->CT2_VALOR
				nTotSbLtDb  += CT2->CT2_VALOR
            	nTotGrlSbD	+= CT2->CT2_VALOR
			EndIf
			If CT2->CT2_DC == "2" .Or. CT2->CT2_DC == "3"
				nTotCrd    += CT2->CT2_VALOR
				nTotGerCrd	+= CT2->CT2_VALOR
				nTotDocCrd  += CT2->CT2_VALOR
				nTotLotCrd  += CT2->CT2_VALOR
				nTotSbLtCr  += CT2->CT2_VALOR
    			nTotGrlSbC	+= CT2->CT2_VALOR
			EndIf			
		Else
			lImpCompl := .T.

			If cPaisLoc == "BRA" .And. cMoeda <> "01" 			
				lImpCompl := CtbImpAd(	CT2->CT2_DATA,;
										CT2->CT2_LOTE,;
										CT2->CT2_SBLOTE,;
										CT2->CT2_DOC,;
										CT2->CT2_SEQLAN,;
										cMoeda)				
			EndIf

			If cPaisLoc == "CHI"
				cSegOfi := CT2->CT2_SEGOFI
			EndIf		

			// Procura complemento de historico e imprime
			If lImpCompl
				ImpCompl( oSection2 )
			EndIf
     	EndIf
		CT2->( dbskip()  )  
		
		If lTotDoc    
			If (cLote <> CT2->CT2_LOTE .Or.;
			 	 cSubLote <> CT2->CT2_SBLOTE .Or. ;
			  	  cDoc <> CT2->CT2_DOC .Or.;
			   	   Dtos(dData) <> Dtos(CT2->CT2_DATA) )
				
				oTotais:Cell("TOT"):SetTitle(STR0017 + cDoc)//TOTAL DOCUMENTO :

				If cPaisLoc == "CHI"
					oTotais:Cell("TOT"):SetTitle(STR0023 + cSegOfi)
				EndIf				

				oTotais:Cell("TOT_CT2DEB"	):SetBlock( { || ValorCTB(nTotDocDeb,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )
				oTotais:Cell("TOT_CT2CRD"	):SetBlock( { || ValorCTB(nTotDocCrd,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )

				oTotais:init()
				oTotais:Printline()
				oTotais:finish()

				fTxtTotal("CTC",dData,cLote,cSubLote,cDoc,cMoeda,oReport)
				
				nTotDocDeb 	:= 0	
				nTotDocCrd 	:= 0
				cDoc 		:= CT2->CT2_DOC
				
			EndIf    
		EndIf          
  		
  		// TOTALIZA O LOTE	
		If lTotLote			   
			If ( cLote <> CT2->CT2_LOTE 	 .Or.;
			     cSubLote <> CT2->CT2_SBLOTE .Or.;
			      Dtos(dData) <> Dtos(CT2->CT2_DATA) )
				
				oTotais:Cell("TOT"):SetTitle(STR0018 + cLote)//TOTAL LOTE

				oTotais:Cell("TOT_CT2DEB"	):SetBlock( { || ValorCTB(nTotLotDeb,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )
				oTotais:Cell("TOT_CT2CRD"	):SetBlock( { || ValorCTB(nTotLotCrd,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )

				oTotais:Init()
				oTotais:Printline()
				oTotais:Finish()

				fTxtTotal("CT6",dData,cLote,cSubLote,cDoc,cMoeda,oReport)
								
				nTotLotDeb := 0	
				nTotLotCrd := 0		
	   		EndIf		
	   EndIf
	   
		//TOTALIZA O SUBLOTE DENTRO DA DATA
		If lTotSbLt			   
			If (cLote <> CT2->CT2_LOTE .Or.;
			 	 cSubLote <> CT2->CT2_SBLOTE .Or. ;
			      Dtos(dData) <> Dtos(CT2->CT2_DATA) )

				oTotais:Cell("TOT"):SetTitle(STR0022 + cSubLote)//TOTAL SUBLOTE :

				oTotais:Cell("TOT_CT2DEB"	):SetBlock( { || ValorCTB(nTotSbLtDb,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )
				oTotais:Cell("TOT_CT2CRD"	):SetBlock( { || ValorCTB(nTotSbLtCr,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )

				oTotais:Init()
				oTotais:Printline()
				oTotais:Finish()
				
				nTotSbLtDb := 0	
				nTotSbLtCr := 0	 
				
		  		If mv_par12 == 1 .And. ! lTotSbLtGrl   // Se quebra Pagina igual a Sim e nao  exibe total geral por sublote 
					oReport:EndPage()
			 	Endif
					
			EndIf
		Endif
		   
		//TOTALIZA O SUBLOTE
		If lTotSbLtGrl
			If	cSubLote <> CT2->CT2_SBLOTE

				oTotais:Cell("TOT"):SetTitle(STR0028 + cSubLote)

				oTotais:Cell("TOT_CT2DEB"	):SetBlock( { || ValorCTB(nTotGrlSbD,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )
				oTotais:Cell("TOT_CT2CRD"	):SetBlock( { || ValorCTB(nTotGrlSbC,,,TAM_VALOR,2,.F.,cPicture,,,,,,,,.F.,lColDbCr) } )

				oTotais:Init()
				oTotais:Printline()
				oTotais:Finish()

				nTotGrlSbD := 0
				nTotGrlSbc := 0  
				
				If mv_par12 == 1   // Se quebra Pagina igual a Sim e exibe total geral por sublote
					oReport:EndPage()
				Endif
				
			Endif
		EndIf

	EndDo
	
EndDo

Return .T.

//-------------------------------------------------------------------
/*{Protheus.doc} fTxtTotal
Total do Lote / SubLote

@author Alvaro Camillo Neto
   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function fTxtTotal(cAlias,dData,cLote,cSubLote,cDoc,cMoeda,oReport)

Local aArea 	:= GetArea()
Local aRetCT6 := {}
Local nInf		:= 0 
Local nDig		:= 0 

Do Case
Case calias == "CTC"
	If CTC->(MsSeek(xFilial(cAlias)+DtoS(dData)+cLote+cSubLote+cDoc+cMoeda))
		nInf := CTC->CTC_INF
		nDig := CTC->CTC_DIG
	EndIf
Case calias == "CT6"
	aRetCT6 := CtbSaldoLote(cLote,cSubLote,dData,cMoeda)
	nInf := aRetCT6[3]
	nDig := aRetCT6[4]
End Case

oReport:SkipLine()
oReport:PrintText(STR0019 + Trans(nInf,cPicture) +" "+	STR0020 + Trans(nDig,cPicture)+" "+STR0021 + Trans(Abs(nDig-nInf),cPicture) ) //"INFORMADO "//"DIGITADO " //"DIFERENCA"

RestArea(aArea)
		
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpCompl  ºAutor  ³Cicero J. Silva     º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a descricao, da conta contabil, item, centro de     º±±
±±º          ³custo ou classe valor                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function ImpCompl(oSection2)
Local cChave    := CT2->CT2_FILIAL + DTOS(CT2->CT2_DATA) + CT2->CT2_LOTE + CT2->CT2_SBLOTE +  CT2->CT2_DOC  + CT2->CT2_SEQLAN
Local lCusto	:= mv_par18==1
Local lItem		:= mv_par19==1
Local lCLVL		:= mv_par20==1 
Local nRecOld	:= 0

//// TRATAMENTO PARA IMPRESSAO DAS CONTINUACOES DE HISTORICO
While !CT2->(Eof()) .And.;
	   CT2->(CT2_FILIAL + DTOS(CT2_DATA) + CT2_LOTE + CT2_SBLOTE + CT2_DOC + CT2_SEQLAN) == cChave .And.;
	   CT2->CT2_DC == "4"


	nRecOld := CT2->(Recno())
	
	oSection2:Cell("CT2_HP"):hide()
	oSection2:Cell("CT2DEB"):hide()
	oSection2:Cell("CT2CRD"):hide()

	If lCusto// Imprimir Centro de Custo
		oSection2:Cell("CT2_CCD"):hide()
		oSection2:Cell("CT2_CCC"):hide()
	EndIf
	
	If lItem// Imprimir Item Contabil
		oSection2:Cell("CT2_ITEMD"):hide()
		oSection2:Cell("CT2_ITEMC"):hide()
	EndIf
	
	If lCLVL// Imprimir Classe de Valor
		oSection2:Cell("CT2_CLVLDB"):hide()
		oSection2:Cell("CT2_CLVLCR"):hide()
	EndIf
	
	oSection2:init()
	oSection2:Printline()
	oSection2:finish()
	
	oSection2:Cell("CT2_HP"):show()
	oSection2:Cell("CT2DEB"):show()
	oSection2:Cell("CT2CRD"):show()
	
	If lCusto// Imprimir Centro de Custo
		oSection2:Cell("CT2_CCD"):show()
		oSection2:Cell("CT2_CCC"):show()
	EndIf
	If lItem// Imprimir Item Contabil
		oSection2:Cell("CT2_ITEMD"):show()
		oSection2:Cell("CT2_ITEMC"):show()
	EndIf
	If lCLVL // Imprimir Classe de Valor
		oSection2:Cell("CT2_CLVLDB"):show()
		oSection2:Cell("CT2_CLVLCR"):show()
	EndIf

	CT2->(dbSkip())
EndDo

If nRecOld > 0 
	CT2->(dbGoto(nRecOld))
EndIf

Return

//-------------------------------------------------------------------
/*{Protheus.doc} CTR080Fil
Filtro da rotina

@author Alvaro Camillo Neto
   
@version P12
@since   20/02/2014
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
User Function Ctr080Fil(lAllSL)

Local cIndex
Local cChave
Local cFiltro

DEFAULT lAllSL := .F.

cIndex	:= CriaTrab(nil,.f.)

cChave	:= "CT2_FILIAL + CT2_SBLOTE + DTOS(CT2_DATA) + CT2_LOTE + CT2_DOC "//+ CT2_MOEDLC + CT2->CT2_SEQLAN"

cFiltro :=  'CT2_FILIAL = "'  + xFilial("CT2") + '".And. '
cFiltro += 	'DTOS(CT2_DATA) >= "' + DTOS(mv_par01)+'" .And. '
cFiltro +=  'DTOS(CT2_DATA) <= "' + DTOS(mv_par02)+'" .And. '
cFiltro += 	'CT2_LOTE >= "'	+ mv_par03+'" .And. '
cFiltro += 	'CT2_LOTE <= "'	+ mv_par04+'" .And. '
cFiltro += 	'CT2_SBLOTE >= "' + mv_par05+'" .And. '
cFiltro += 	'CT2_SBLOTE <= "' + mv_par06+'" .And. '
cFiltro +=  'CT2_DOC >= "' + mv_par07+'" .And. '
cFiltro += 	'CT2_DOC <= "' + mv_par08+'" .And. '

If mv_par09 == '01'
	cFiltro +=  'CT2_MOEDLC = "01" ' 
Else
	cFiltro +=  '((CT2_DC <> "4" .And. CT2_MOEDLC = "' + mv_par09 +'") .Or. ' 
	cFiltro +=  '(CT2_DC = "4" .And. CT2_MOEDLC = "01"))'
EndIf

If !lAllSL					// mv_par11 = * -> Todos os tipos de lancamento
	cFiltro += ' .And. CT2_TPSALD = '		+'"'+mv_par11+'"'  
Else
	cFiltro += ' '								
EndIf

If cPaisLoc == "CHI"
	cFiltro += 	'.And. CT2_SEGOFI >= "'+ mv_par16+'"'
	cFiltro += 	'.And. CT2_SEGOFI <= "'+ mv_par17+'"'
EndIf
				
IndRegua( "CT2", cIndex, cChave,, cFiltro, OemToAnsi(STR0016))		// "Seleccionando Registros..."

nIndex := RetIndex("CT2")

dbSelectArea("CT2")

dbSetOrder(nIndex+1)
dbGoTop()

Return cFiltro

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³CODRED    ³ Autor ³ MICROSIGA             ³ Data ³ 17.07.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Header do sublote                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_CodRed(cConta,cTipo)										  ³±±
±±³          ³          											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = CONTA                                              ³±±
±±³          ³ ExpC2 = TIPOCabec1                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CodRed(cConta,cTipo)

Default cConta := ""
Default cTipo  := ""

dbSelectArea("CT1")
IF cTipo == "D"
	dbSeek(xFilial()+CT2->CT2_DEBITO)
	cConta := CT1->CT1_RES
Else 	
	dbSeek(xFilial()+CT2->CT2_CREDIT)
	cConta := CT1->CT1_RES	
Endif	

dbCloseArea()

Return (cConta)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR080HCL ºAutor  ³Leandro F. Dourado    º Data ³  07/02/12º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Posiciona na tabela CTC para trazer o Histórico            º±±
±±º          ³ da Capa de Lote Correto                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR080                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CTBR080HCL()
Local aSaveArea := GetArea()
Local lUseDocHis := X3USADO("CTC_DOCHIS")
Local aSaveCTC	  := CTC->(GetArea())
Local cRet		  := ""

If "ARG" $ cPaisLoc .AND. lUseDocHis
	DbSelectArea("CTC")
	CTC->(DbSetOrder(1)) //CTC_FILIAL+DTOS(CTC_DATA)+CTC_LOTE+CTC_SBLOTE+CTC_DOC+CTC_MOEDA
	
	CTC->(DbSeek(xFilial("CT2")+CT2->(DTOS(CT2_DATA)+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_MOEDLC)))
	cRet := CTC->CTC_DOCHIS
EndIf

RestArea(aSaveCTC)
RestArea(aSaveArea)

Return cRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR080HCL ºAutor  ³Leandro F. Dourado    º Data ³  07/02/12º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Posiciona na tabela CTC para trazer o Histórico            º±±
±±º          ³ da Capa de Lote Correto                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR080                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function C080RetDC(cRet)
Default cRet := ""

Do Case
	Case cRet =="1"
		cRet := "Deb."
	Case cRet == "2"
		cRet := "Cred."
	Case cRet == "3"
		cRet := "P.Dob."
	Case cRet == "4"
		cRet := "C.Hist"
	Case cRet == "5"
		cRet := "Rateio"
	Case cRet == "6"
		cRet := "L.Pad."
EndCase
	
Return cRet
//-------------------------------------------------------------------
/*{Protheus.doc} CtbImpAd
Verifico se tenho lançamento com valor na moeda específica para 
imprimir o complemento de histórico (CT2_DC = 4)

@author totvs
   
@version P12
@since   29/05/2020
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function CtbImpAd(dData,cLote,cSubLote,cDocum,cSeqLan,cMoeda)
Local aAreaCT2  := CT2->(GetArea())
Local lRet 		:= .F.
Local cAliasCT2 := GetNextAlias()
Local cQuery    := ""

DEFAULT dData 	 := StoD("")
DEFAULT cLote	 := ""
DEFAULT cSubLote := ""
DEFAULT cDocum	 := ""
DEFAULT cSeqLan  := ""
DEFAULT cMoeda   := ""

If __oPrepCT2 == Nil
	CTBObjStat() 
EndIf

__oPrepCT2:SetString(1,DtoS(dData))
__oPrepCT2:SetString(2,cLote)
__oPrepCT2:SetString(3,cSubLote)
__oPrepCT2:SetString(4,cDocum)
__oPrepCT2:SetString(5,cSeqLan)
__oPrepCT2:SetString(6,cMoeda)

cQuery := __oPrepCT2:GetFixQuery()

dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasCT2,.T.,.T.)

lRet := !(cAliasCT2)->(Eof())
(cAliasCT2)->(dbCloseArea())

RestArea(aAreaCT2)

Return lRet
//-------------------------------------------------------------------
/*{Protheus.doc} CTBObjStat
Cria o objeto da classe FWPreparedStatement()

@author totvs
   
@version P12
@since   29/05/2020
@return  Nil
@obs	 
*/
//-------------------------------------------------------------------
Static Function CTBObjStat()
Local cQuery := ""

cQuery := " SELECT R_E_C_N_O_ "
cQuery += " FROM "+RetSqlName("CT2")+" "
cQuery += " WHERE CT2_FILIAL = '"+xFilial("CT2")+"' AND "
cQuery += " CT2_DATA = ? AND "
cQuery += " CT2_LOTE = ? AND "
cQuery += " CT2_SBLOTE = ? AND "
cQuery += " CT2_DOC = ? AND "
cQuery += " CT2_SEQLAN = ? AND "
cQuery += " CT2_DC <> '4' AND "
cQuery += " CT2_MOEDLC = ? AND "
cQuery += " D_E_L_E_T_ = ' ' "

cQuery := ChangeQuery(cQuery)

__oPrepCT2:=FWPreparedStatement():New(cQuery)

Return 