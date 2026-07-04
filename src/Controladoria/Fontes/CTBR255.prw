/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Ctbr255.Ch"
#Include "PROTHEUS.Ch"

#DEFINE 	TAM_COLVAL	19
#DEFINE 	TAM_VALOR	17

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Ctbr255	³ Autor ³ Cicero J. Silva   	³ Data ³ 03.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Balancete Comparativo de Saldos de C.Custo c/ Filiais	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³ U_Ctbr255()    											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso 	     ³ Generico     											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Ctbr255()

Local aArea := GetArea()
Local oReport          
Local lOk := .T.
Local lAtSlComp		:= Iif(GETMV("MV_SLDCOMP") == "S",.T.,.F.)
Local cCompEmp	:= ''

PRIVATE cTipoAnt	:= ""
PRIVATE cPerg	 	:= "CTR255"
PRIVATE nomeProg  	:= "CTBR255"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE oTRF3
PRIVATE oTRF4
PRIVATE oTRF5
PRIVATE oTRF6
PRIVATE nTotal		:= 0


	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra tela de aviso - atualizacao de saldos				 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cMensagem := STR0017+chr(13)  		//"Caso nao atualize os saldos compostos na"
cMensagem += STR0018+chr(13)  		//"emissao dos relatorios(MV_SLDCOMP ='N'),"
cMensagem += STR0019+chr(13)  		//"rodar a rotina de atualizacao de saldos "
cMensagem += STR0020+chr(13)  		//"para todas as filiais solicitadas nesse "
cMensagem += STR0021+chr(13)  		//"relatorio."

IF !lAtSlComp
	If !MsgYesNo(cMensagem,STR0009)	//"ATEN€ŽO"
		Return
	EndIf
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o cad. c.custo eh compartilhado.POR DEFINICAO,   ³
//³ nao sera possivel emitir o relatorio com C.CUSTO             ³
//³ EXCLUSIVO !!!!                                   			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Verificar através das funções de Frame o compartilhamento das tabelas
cCompEmp := FWModeAccess("CTT",3)

If cCompEmp == "E"
		lOk := .F.
		MSGALERT(STR0033)
EndIf

If lOk
	oReport := ReportDef(cPerg)
	oReport:PrintDialog()
EndIf


//Limpa os arquivos temporários 
CTBGerClean()
	
RestArea(aArea)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  01/08/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ cPerg      - Grupo de Perguntas							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGACTB                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef(cPerg)

Local oReport
Local oPlcontas                        

Local cSayCusto		:= CtbSayApro("CTT")
Local cDesc1 		:= STR0001	+ " " +  cSayCusto //"Este programa ira imprimir o Comparativo de " 
Local cDesc2 		:= STR0002  //" de 2 ate 6 filiais. Os valores sao ref. a movimentacao do periodo solicitado. "
Local cDesc3		:= ""
Local titulo 		:= STR0003 + cSayCusto + STR0022 	//"Comparativo  de C.Custo com Filiais"

Local aTamCC        := TamSX3("CTT_CUSTO")
Local aTamCCRes 	:= TamSX3("CTT_RES")

oReport := TReport():New(nomeProg,titulo,cPerg,{|oReport| Pergunte(cPerg,.F.),;
	Iif( ReportPrint(oReport), .T., oReport:CancelPrint() ) },cDesc1+cDesc2)
	
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oReport:SetLandScape(.T.)

// Sessao 1
oPlcontas := TRSection():New(oReport,STR0032,{"cArqTmp","CTT"},/*aOrder*/,/*lLoadCells*/,/*lLoadOrder*/)	//"Período"
oPlcontas:SetTotalInLine(.F.)
oPlcontas:SetHeaderPage()

TRCell():New(oPlcontas,"CUSTO"	,"cArqTmp"	, STR0023,/*Picture*/,aTamCC[1]	,/*lPixel*/,/*{|| }*/)// "CODIGO"
TRCell():New(oPlcontas,"DESCCC","cArqTmp" 	, STR0024,/*Picture*/,			,/*lPixel*/,/*{|| }*/)// "D E S C R I C A O"
TRCell():New(oPlcontas,"COLUNA1","cArqTmp"	, STR0025,/*Picture*/,TAM_COLVAL	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 01"
TRCell():New(oPlcontas,"COLUNA2","cArqTmp"	, STR0026,/*Picture*/,TAM_COLVAL	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 02"
TRCell():New(oPlcontas,"COLUNA3","cArqTmp"	, STR0027,/*Picture*/,TAM_COLVAL ,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 03"
TRCell():New(oPlcontas,"COLUNA4","cArqTmp"	, STR0028,/*Picture*/,TAM_COLVAL	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 04"
TRCell():New(oPlcontas,"COLUNA5","cArqTmp"	, STR0029,/*Picture*/,TAM_COLVAL	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 05"
TRCell():New(oPlcontas,"COLUNA6","cArqTmp"	, STR0030,/*Picture*/,TAM_COLVAL ,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "MOV FIL 06"
TRCell():New(oPlcontas,"TOT_GER"," "      	, STR0031,/*Picture*/,TAM_COLVAL	,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// "TOTAL GERAL"

oPlContas:SetTotalText(STR0011)	//"T O T A I S  D O  P E R I O D O: "

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  14/07/06  º±±
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
Static Function ReportPrint(oReport)

Local oPlcontas 	:= oReport:Section(1)

Local cSayCusto		:= CtbSayApro("CTT")
Local cArqTmp		:= ""
Local cFiltro		:= oPlContas:GetAdvplExpr()
Local dDataFim 		:= mv_par02
Local lImpAntLP		:= Iif(mv_par26==1,.T.,.F.)
Local lPrintZero	:= Iif(mv_par22==1,.T.,.F.)
Local dDataLP  		:= mv_par27
Local nDivide		:= 1
Local nTamCC  		:= Len(CriaVar("CTT->CTT_DESC"+mv_par14))
Local cSeparador	:= ""
Local cMascara		:= ""
Local cPicture 		:= ""
Local nDecimais 	:= 0
Local cDescMoeda 	:= ""
Local lPula			:= (mv_par21==1) 
Local lNormal		:= (mv_par23==1)
Local cSegAte 	   	:= mv_par25 // Imprimir ate o Segmento?
Local cDescFil		:= "" 
Local aAreaSM0		:= SM0->(GetArea())

Local nDigitAte		:= 0

Local nCont			:= 0
Local aFiliais		:= {}
Local aDescFil		:= {}
Local nPergFil		:= 4 //Definido com 4, porque a primeira perg. de filial eh o mv_par05
Local cPergFil		:= ""
Local nTamCUS		:= (TamSX3("CTT_CUSTO")[1])
Local bNormal		:= { || cArqTmp->NORMAL }

Private cSegAte 	:= mv_par25 // Imprimir ate o Segmento?
Private nDigitAte	:= 0
Private cMascara	:= ""

If lIsRedStor
	bNormal := {|| Posicione("CTT",1,xFilial("CTT")+padr(cArqTmp->CUSTO,nTamCUS),"CTT_NORMAL") }
Endif	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se usa Set Of Books + Plano Gerencial (Se usar Plano³
//³ Gerencial -> montagem especifica para impressao)			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !ct040Valid(mv_par12) // Set Of Books
	Return .F.
Else
   aSetOfBook := CTBSetOf(mv_par12)		
EndIf 

If mv_par24 == 2			// Divide por cem
	nDivide := 100
ElseIf mv_par24 == 3		// Divide por mil
	nDivide := 1000
ElseIf mv_par24 == 4		// Divide por milhao
	nDivide := 1000000
EndIf	

aCtbMoeda  	:= CtbMoeda(mv_par14,nDivide) // Moeda?
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Return .F.
Endif
                         
cMascara   := IIF (Empty(aSetOfBook[2]),GetMv("MV_MASCCUS"),RetMasCtb(aSetOfBook[6],@cSeparador))// Mascara Contabil
cPicture   := aSetOfBook[4]                         
nDecimais  := DecimalCTB(aSetOfBook,mv_par14)
cDescMoeda := aCtbMoeda[2]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o titulo das colunas com base no cadastro de empresas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nCont := 1 to 6       	
	cPergFil	:= &("mv_par"+Strzero(nPergFil+nCont,2))		
	If Empty(cPergFil)            
		AADD(aFiliais,"")
	Else
		AADD(aFiliais,cPergFil)
	EndIf                 	
Next                      

For nCont := 1 to Len(aFiliais)
	If (!Empty(aFiliais[nCont]))
		cDescFil := FWFilialName(cEmpAnt,Subs(aFiliais[nCont],1,2),1)
		If !Empty(cDescFil) 	  
			AADD(aDescFil,cDescFil)
		Else
			AADD(aDescFil,Space(15))
		EndIf
	Else     
		AADD(aDescFil,Space(15))					
	EndIf	
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera os titulos das colunas dos valores por filial      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oPlcontas:Cell("COLUNA1"):SetTitle("MOV FIL 01"+Iif(!Empty(aDescFil[1]),CRLF+aDescFil[1],""))
oPlcontas:Cell("COLUNA2"):SetTitle("MOV FIL 02"+Iif(!Empty(aDescFil[2]),CRLF+aDescFil[2],""))
oPlcontas:Cell("COLUNA3"):SetTitle("MOV FIL 03"+Iif(!Empty(aDescFil[3]),CRLF+aDescFil[3],""))
oPlcontas:Cell("COLUNA4"):SetTitle("MOV FIL 04"+Iif(!Empty(aDescFil[4]),CRLF+aDescFil[4],""))
oPlcontas:Cell("COLUNA5"):SetTitle("MOV FIL 05"+Iif(!Empty(aDescFil[5]),CRLF+aDescFil[5],""))
oPlcontas:Cell("COLUNA6"):SetTitle("MOV FIL 06"+Iif(!Empty(aDescFil[6]),CRLF+aDescFil[6],""))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui conteudo para impressao dos valores por filial    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lIsRedStor
	oPlcontas:Cell("COLUNA1"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA2"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA3"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA4"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA5"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA6"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("TOT_GER"):SetBlock({|| ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,TAM_VALOR+2,nDecimais,CtbSinalMov(),cPicture,Eval(bNormal),,,,,,lPrintZero,.F.) })
Else
	oPlcontas:Cell("COLUNA1"):SetBlock({|| ValorCTB(cArqTmp->COLUNA1,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA2"):SetBlock({|| ValorCTB(cArqTmp->COLUNA2,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA3"):SetBlock({|| ValorCTB(cArqTmp->COLUNA3,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA4"):SetBlock({|| ValorCTB(cArqTmp->COLUNA4,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA5"):SetBlock({|| ValorCTB(cArqTmp->COLUNA5,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("COLUNA6"):SetBlock({|| ValorCTB(cArqTmp->COLUNA6,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.)})
	oPlcontas:Cell("TOT_GER"):SetBlock({|| ValorCTB(cArqTmp->(COLUNA1+COLUNA2+COLUNA3+COLUNA4+COLUNA5+COLUNA6),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,cArqTmp->NORMAL,,,,,,lPrintZero,.F.) })
EndIf

oPlContas:Cell("DESCCC"):SetSize(nTamCC)

If lNormal
	oPlContas:Cell("CUSTO"):SetBlock({|| IIF(cArqTmp->TIPOCC=="2","  ","")+EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) })
Else
	oPlContas:Cell("CUSTO"):SetBlock({|| IIF(cArqTmp->TIPOCC=="2",EntidadeCTB(cArqTmp->CCRES,0,0,20,.F.,cMascara,cSeparador,,,,,.F.),;
	  											"  " + EntidadeCTB(cArqTmp->CUSTO,0,0,20,.F.,cMascara,cSeparador,,,,,.F.) ) })
EndIf	

oPlcontas:OnPrintLine( {|| ( IIf( lPula .And. (cTipoAnt == "1" .Or. (cArqTmp->TIPOITEM == "1" .And. cTipoAnt == "2")), oReport:SkipLine(),NIL),;
								 cTipoAnt := cArqTmp->TIPOITEM	)  })

oPlcontas:SetLineCondition({|| f255Fil(cSegAte, nDigitAte,cMascara) })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define os totalizadores do relatorio                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lIsRedStor
	TRFunction():New(oPlcontas:Cell("DESCCC"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || ""},.T.,.F.,.F.,oPlcontas)
EndIF
oTRF1 := TRFunction():New(oPlcontas:Cell("COLUNA1"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	{ || IIF(Empty(aFiliais[1]),0,f255Soma("1",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF1:Disable()
If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA1"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF1:GetValue(),StrTran(ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA1"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF1:GetValue(),ValorCTB(oTRF1:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIf

oTRF2 := TRFunction():New(oPlcontas:Cell("COLUNA2"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	{ || IIF(Empty(aFiliais[2]),0,f255Soma("2",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF2:Disable()
If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA2"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF2:GetValue(),StrTran(ValorCTB(oTRF2:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA2"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF2:GetValue(),ValorCTB(oTRF2:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIf

oTRF3 := TRFunction():New(oPlcontas:Cell("COLUNA3"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	{ || IIF(Empty(aFiliais[3]),0,f255Soma("3",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF3:Disable()
If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA3"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF3:GetValue(),StrTran(ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA3"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF3:GetValue(),ValorCTB(oTRF3:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIf

oTRF4 := TRFunction():New(oPlcontas:Cell("COLUNA4"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
	{ || IIF(Empty(aFiliais[4]),0,f255Soma("4",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF4:Disable()

If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA4"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF4:GetValue(),StrTran(ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA4"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF4:GetValue(),ValorCTB(oTRF4:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIf

oTRF5 := TRFunction():New(oPlcontas:Cell("COLUNA5"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || IIF(Empty(aFiliais[5]),0,f255Soma("5",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF5:Disable()
If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA5"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF5:GetValue(),StrTran(ValorCTB(oTRF5:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA5"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF5:GetValue(),ValorCTB(oTRF5:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIf

oTRF6 := TRFunction():New(oPlcontas:Cell("COLUNA6"),nil,"SUM",/*oBreak*/,/*Titulo*/,/*cPicture*/,{ || IIF(Empty(aFiliais[6]),0,f255Soma("6",cSegAte)) },.F.,.F.,.F.,oPlcontas)
oTRF6:Disable()

If lIsRedStor
	TRFunction():New(oPlcontas:Cell("COLUNA6"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF6:GetValue(),StrTran(ValorCTB(oTRF6:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","")) },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("COLUNA6"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || (nTotal += oTRF6:GetValue(),ValorCTB(oTRF6:GetValue(),,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.)) },.T.,.F.,.F.,oPlcontas)
EndIF

If lIsRedStor
	TRFunction():New(oPlcontas:Cell("TOT_GER"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || StrTran(ValorCTB(nTotal,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,"1",,,,,,lPrintZero,.F.),"D","") },.T.,.F.,.F.,oPlcontas)
Else
	TRFunction():New(oPlcontas:Cell("TOT_GER"),nil,"ONPRINT",/*oBreak*/,/*Titulo*/,/*cPicture*/,;
		{ || ValorCTB(nTotal,,,TAM_VALOR,nDecimais,CtbSinalMov(),cPicture,,,,,,,lPrintZero,.F.) },.T.,.F.,.F.,oPlcontas)
EndIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega titulo do relatorio: Analitico / Sintetico			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF mv_par11 == 1
	Titulo:=	STR0008	//"COMPARATIVO DE FILIAIS SINTETICO DE "
ElseIf mv_par11 == 2
	Titulo:=	STR0005	//"COMPARATIVO DE FILIAIS ANALITICO DE "
ElseIf mv_par11 == 3
	Titulo:=	STR0012	//"COMPARATIVO DE "
EndIf

Titulo += 	DTOC(mv_par01) + STR0006 + Dtoc(mv_par02) + STR0007 + cDescMoeda

If mv_par16 > "1"			
	Titulo += " (" + Tabela("SL", mv_par16, .F.) + ")"
Endif                     

oReport:SetTitle(Titulo)
oReport:SetPageNumber(mv_par15) //mv_par09	-	Pagina Inicial
oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,oReport:Title(),,,,,oReport) } )

#IFNDEF TOP
	If !Empty(cFiltro)
		CTT->( dbSetFilter( { || &cFiltro }, cFiltro ) )
	EndIf
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta Arquivo Temporario para Impressao					     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
		CTGerComp(oMeter, oText, oDlg, @lEnd,@cArqTmp,;
		 mv_par01,mv_par02,"CTU","CTT",,,mv_par03,mv_par04,,,,,mv_par14,;
		  mv_par16,aSetOfBook,mv_par17,mv_par18,mv_par19,mv_par20,;
		   .F.,.F.,mv_par11,,lImpAntLP,dDataLP,nDivide,"M",.T.,aFiliais,,,,,,,,cFiltro /*aReturn[7]*/)},;
			STR0015,STR0003) //"Criando Arquivo Tempor rio..." "Comparativo de Contas Contabeis com Filiais"

oReport:NoUserFilter()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia a impressao do relatorio                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Trata cArqTmp quando GerComp não encontra dados
If Select("cArqTmp") == 0
	Return .F.
EndIf

dbSelectArea("cArqTmp")
dbGotop()

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If RecCount() == 0 .And. !Empty(aSetOfBook[5])
	MSGALERT(STR0034) //Plano Gerencial não esta disponível
Else
	oReport:SetMeter(cArqTmp->(RecCount()))
	oPlcontas:Print()	
Endif

dbSelectArea("cArqTmp")
Set Filter To
dbCloseArea()
If Select("cArqTmp") == 0
	FErase(cArqTmp+GetDBExtension())
	FErase("cArqInd"+OrdBagExt())
EndIf
dbselectArea("CT2")

RestArea(aAreaSM0)
Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f255Soma  ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function f255Soma(cCOL,cSegAte)

Local nRetValor		:= 0

	If cArqTmp->TIPOCC == "2"
		nRetValor := &("cArqTmp->COLUNA"+cCOL)
	EndIf

Return nRetValor                                                                         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f255Fil   ºAutor  ³Cicero J. Silva     º Data ³  24/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR230                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function f255Fil(cSegAte, nDigitAte,cMascara)

Local lDeixa	:= .T.


	If mv_par11 == 1					// So imprime Sinteticas
		If cArqTmp->TIPOCC == "2"
			// Totalizadores
			oTRF1:EvalFunction()
			oTRF2:EvalFunction()
			oTRF3:EvalFunction()
			oTRF4:EvalFunction()
			oTRF5:EvalFunction()
			oTRF6:EvalFunction()
			lDeixa := .F.
		EndIf
	ElseIf mv_par11 == 2				// So imprime Analiticas
		If cArqTmp->TIPOCC == "1"
			lDeixa := .F.
		EndIf
	EndIf                
	If mv_par13 == 2						// Saldos Zerados nao serao impressos
		If (Abs(cArqTmp->COLUNA1)+Abs(cArqTmp->COLUNA2)+Abs(cArqTmp->COLUNA3)+Abs(cArqTmp->COLUNA4)+Abs(cArqTmp->COLUNA5)+Abs(cArqTmp->COLUNA6)) == 0
			lDeixa := .F.
		EndIf
	EndIf

	// Verifica Se existe filtragem Ate o Segmento
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)		
	If !Empty(cSegAte)

		nDigitAte := CtbRelDig(cSegAte,cMascara) 	

		If Len(Alltrim(cArqTmp->CUSTO)) > nDigitAte
			lDeixa := .F.
		Endif
	EndIf

dbSelectArea("cArqTmp")

Return (lDeixa)