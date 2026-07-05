/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR410.CH"
#Include "PROTHEUS.CH"

#DEFINE TAM_VALOR	19
#DEFINE TAM_CONTA	17
#DEFINE TAM_TX		12

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema
Static lAutomato  := IsBlind()
// 17/08/2009 -- Filial com mais de 2 caracteres

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR410  ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 11.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Raz„o em Duas Moedas                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR410()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR410()

U_CTBR410R4()

//Limpa os arquivos temporários 
CtbRazClean()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR410R4³ Autor ³ Gustavo Henrique      ³ Data ³ 13/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Raz„o em Duas Moedas                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR410R4()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CTBR410R4()

Local aSetOfBook	:= {}

Local lRet			:= .T.
Local cPerg			:= "CTR410"

Private nomeprog	:= "CTBR410"

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                            ³
//³ mv_par01            // da conta                                 ³
//³ mv_par02            // ate a conta                              ³
//³ mv_par03            // da data                                  ³
//³ mv_par04            // Ate a data                               ³
//³ mv_par05            // Moeda corrente 	                        ³   
//³ mv_par06            // Moeda   			                     	³   
//³ mv_par07            // Saldos		                          	³  	 
//³ mv_par08            // Set Of Books                          	³
//³ mv_par09            // Analitico ou Resumido dia (resumo)    	³
//³ mv_par10            // Imprime conta sem movimento?          	³
//³ mv_par11            // Junta Contas com mesmo C.Custo?       	³
//³ mv_par12            // Imprime Conta (Normal / Reduzida)     	³
//³ mv_par13            // Imprime ?                             	³
//³ mv_par14            // Imprime Codigo (Normal / Reduzido)    	³
//³ mv_par15            // Do Centro de Custo                    	³
//³ mv_par16            // At‚ o Centro de Custo                 	³
//³ mv_par17            // Do Item                                  ³
//³ mv_par18            // Ate Item                                 ³
//³ mv_par19            // Da Classe de Valor                       ³
//³ mv_par20            // Ate a Classe de Valor                 	³
//³ mv_par21            // Salto de pagina                       	³
//³ mv_par22            // Pagina Inicial                        	³
//³ mv_par23            // Pagina Final                          	³
//³ mv_par24            // Numero da Pag p/ Reiniciar            	³
//³ mv_par25            // Imprime Total Geral (Sim/Nao)         	³
//³ mv_par26            // So Livro/Livro e Termos/So Termos     	³
//³ mv_par27            // Com Saldo Moeda/Com Saldo Corrente/Todos ³ 
//³ mv_par28            // Imprime Valor 0.00						³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Pergunte(cPerg, .T. )
	Return
EndIf

If !Ct040Valid(mv_par08)
	lRet := .F.
Else
	aSetOfBook := CTBSetOf(mv_par08)
EndIf

If lRet
	aCtbMoeda := CtbMoeda(mv_par06)
   	If Empty(aCtbMoeda[1])
      	Help(" ",1,"NOMOEDA")
      	lRet := .F.
   	Endif
Endif

If lRet       
	oReport:= ReportDef( cPerg, aCtbMoeda, aSetOfBook )
	oReport:PrintDialog()
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Gustavo Henrique      ³ Data ³12/09/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Esta funcao tem como objetivo definir as secoes, celulas,   ³±±
±±³          ³totalizadores do relatorio que poderao ser configurados     ³±±
±±³          ³pelo usuario.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³EXPC1 - Nome do grupo de perguntas                          ³±±
±±³          ³EXPA2 - Array de moedas                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef( cPerg, aCtbMoeda, aSetOfBook )

Local oContaSint	
Local oConta
Local oLancto
Local oCompl
Local cDesc1		:= OemToAnsi(STR0001)	// "Este programa ir  imprimir o Raz„o Contabil,"
Local cDesc2		:= OemToAnsi(STR0002)	// "os parametros solicitados pelo usuario. O Relatorio sera"
Local cDesc3		:= OemToAnsi(STR0003)	// "impresso em Real e outra Moeda escolhida pelo Usuario."
Local lSalto		:= (mv_par21 == 1)
Local lAnalitico	:= (mv_par09 == 1)
Local lCusto 		:= (mv_par13 == 1)
Local lItem			:= (mv_par13 == 2)
Local lCLVL			:= (mv_par13 == 3)
Local lPrintZero	:= (mv_par28 == 1)                                                  
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local cPicture		:= aSetOfBook[4]
Local aTamConta		:= TamSX3("CT1_CONTA")
Local nTamCusto		:= Len(CriaVar("CT3_CUSTO"))
Local nTamItem 		:= Len(CriaVar("CTD->CTD_DESC"+mv_par05))
Local nTamCLVL		:= Len(CriaVar("CTH_CLVL"))
Local nAlignTot 	:= 0
Local nDecimais 	:= DecimalCTB(aSetOfBook,mv_par06)
Local aCtbMd01		:= CtbMoeda(mv_par05)     
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty

oReport :=	TReport():New( "CTBR410", OemToAnsi(STR0006), cPerg,;	//"Emissao do Razao Contabil"
			{ |oReport|	Pergunte( cPerg, .F. ), ReportPrint(oReport,aSetOfBook,aCtbMoeda,cPerg) },cDesc1+cDesc2+cDesc3)

oReport:ParamReadOnly()

If lAnalitico
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Conta Sintetica                
oContaSint := TRSection():New( oReport, STR0034, {"cArqTmp","CT2"},, .F., .F. ) 	// "Conta Sintética"
oContaSint:SetHeaderSection(.F.)        

If lSalto
	oContaSint:SetPageBreak(.T.)
EndIf

TRCell():New( oContaSint, "CONTSINT", "", STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)		//"Conta"
TRCell():New( oContaSint, "DESCSINT", "", STR0040,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)		//"Descrição"	
                  
// Conta 
oConta := TRSection():New( oReport, STR0035, {"cArqTmp"},, .F., .F. )		// "Conta"
oConta:SetHeaderSection(.F.)        

If lSalto
	oConta:SetPageBreak(.T.)
EndIf
        

TRCell():New( oConta, "CONTA"		 , "cArqTmp", STR0035,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/)				//"Conta"
TRCell():New( oConta, "DESCONTA"	 , ""       , STR0040,/*Picture*/,If(lAnalitico,161,93),/*lPixel*/,/*CodeBlock*/)	//"Descrição"
TRCell():New( oConta, "SLDMOEDA2", ""       , STR0030+Space(1)+aCtbMoeda[3],/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"SALDO ATUAL US$"
TRCell():New( oConta, "SLDMOEDA1", ""       , STR0030+Space(1)+aCtbMd01[3] ,/*Picture*/,TAM_VALOR,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")		//"SALDO ATUAL R$"

// Lancamentos
oLancto := TRSection():New( oReport, STR0036,{"cArqTmp"},, .F., .F. )	// "Lançamento"
oLancto:SetTotalInLine(.F.)
oLancto:SetHeaderPage(.T.)

TRCell():New(oLancto, "DATAL"			,"cArqTmp", STR0019 ,/*Picture*/, 10,/*lPixel*/,/*CodeBlock*/)// Data do Lancamento
TRCell():New(oLancto, "DOCUMENTO"	,""       , STR0031 ,/*Picture*/,25,/*lPixel*/,{|| cArqTmp->(LOTE+SUBLOTE+DOC+LINHA) })// "LOTE/SUB/DOC/LINHA"
If lAnalitico
	TRCell():New(oLancto, "HISTORICO"	,"cArqTmp", STR0032 ,/*Picture*/,40	,/*lPixel*/,{|| SubStr(cArqTmp->HISTORICO,1,40) },,.F.)// Historico
	TRCell():New(oLancto, "XPARTIDA"		,"cArqTmp", STR0033 ,/*Picture*/,aTamConta[1],/*lPixel*/,/*CodeBlock*/)// "XPARTIDA"	
	oLancto:Cell("HISTORICO"):lHeaderSize 	:= .F.
	oLancto:Cell("XPARTIDA"):lHeaderSize	:= .F.
EndIf
If lCusto .And. lAnalitico
	TRCell():New(oLancto, "CUSTO"	  		,"cArqTmp", STR0041 ,/*Picture*/,15,/*lPixel*/,/*CodeBlock*/)		//"C.CUSTO"
ElseIf lClVl .And. lAnalitico
	TRCell():New(oLancto, "CLVL"			,"cArqTmp", STR0042 ,/*Picture*/,15,/*lPixel*/,/*CodeBlock*/)		//"CL.VALOR"
ElseIf lItem .And. lAnalitico
	TRCell():New(oLancto, "ITEM"			,"cArqTmp", STR0043 ,/*Picture*/,15,/*lPixel*/,/*CodeBlock*/)		//"ITEM CONTAB"
EndIf
TRCell():New(oLancto, "LANCDEB"		,"cArqTmp", STR0028,/*Picture*/,TAM_VALOR,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCDEB  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },/*"RIGHT"*/,,"RIGHT")// Debito
TRCell():New(oLancto, "LANCDEBTX"	,"cArqTmp", Space(1)+aCtbMoeda[3],/*Picture*/,TAM_TX,/*lPixel*/,{|| Trans(cArqTmp->TXDEBITO, "@Z 9999.9999") },/*"RIGHT"*/,,"RIGHT")// DebitoTX
TRCell():New(oLancto, "LANCDEB_1"	,"cArqTmp", STR0028+Space(1)+aCtbMd01[3] ,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCDEB_1,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr) },/*"RIGHT"*/,,"RIGHT")// Debito moeda 1
TRCell():New(oLancto, "LANCCRD"		,"cArqTmp", STR0029,/*Picture*/,TAM_VALOR,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCCRD  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)},/*"RIGHT"*/,,"RIGHT")// Credito
TRCell():New(oLancto, "LANCCRDTX"	,"cArqTmp", Space(1)+aCtbMoeda[3],/*Picture*/,TAM_TX,/*lPixel*/,{|| Trans(cArqTmp->TXCREDITO, "@Z 9999.9999") },/*"RIGHT"*/,,"RIGHT")// CreditoTX
TRCell():New(oLancto, "LANCCRD_1"	,"cArqTmp", STR0029+Space(1)+aCtbMd01[3] ,/*Picture*/,TAM_VALOR	,/*lPixel*/,{|| ValorCTB(cArqTmp->LANCCRD_1,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr) },/*"RIGHT"*/,,"RIGHT")// Credito moeda 1
If lIsRedStor 
	TRCell():New(oLancto, "SLDATU"		,"cArqTmp", STR0030+Space(1)+aCtbMoeda[3],/*Picture*/,TAM_VALOR+2	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")// Sinal do Saldo Atual => Consulta Razao
	TRCell():New(oLancto, "SLDATU_1"	,"cArqTmp", STR0030+Space(1)+aCtbMd01[3] ,/*Picture*/,TAM_VALOR+2	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT",,,,,,)// Sinal do Saldo Atual => Consulta Razao
Else
	TRCell():New(oLancto, "SLDATU"		,"cArqTmp", STR0030+Space(1)+aCtbMoeda[3],/*Picture*/,TAM_VALOR	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT")// Sinal do Saldo Atual => Consulta Razao
	TRCell():New(oLancto, "SLDATU_1"	,"cArqTmp", STR0030+Space(1)+aCtbMd01[3] ,/*Picture*/,TAM_VALOR	,/*lPixel*/,/*CodeBlock*/,/*"RIGHT"*/,,"RIGHT",,,,,,)// Sinal do Saldo Atual => Consulta Razao
Endif        
          		
oConta:Cell("CONTA"):lHeaderSize        := .F.
oConta:Cell("DESCONTA"):lHeaderSize     := .F.
oConta:Cell("SLDMOEDA2"):lHeaderSize    := .F.
oConta:Cell("SLDMOEDA1"):lHeaderSize    := .F.
oLancto:Cell("LANCDEB"):lHeaderSize 	:= .F.
oLancto:Cell("LANCDEBTX"):lHeaderSize	:= .F.
oLancto:Cell("LANCDEB_1"):lHeaderSize	:= .F.
oLancto:Cell("LANCCRD"):lHeaderSize 	:= .F.
oLancto:Cell("LANCCRDTX"):lHeaderSize 	:= .F.
oLancto:Cell("LANCCRD_1"):lHeaderSize	:= .F.
oLancto:Cell("SLDATU"):lHeaderSize 		:= .F.
oLancto:Cell("SLDATU_1"):lHeaderSize 	:= .F.    

If !lAnalitico
	oLancto:Cell("DOCUMENTO"):Hide()
	oLancto:Cell("DOCUMENTO"):HideHeader() 
EndIf

If lAnalitico
	// Complemento
	oCompl := TRSection():New( oReport,STR0038,,, .F., .F. )	//"Complemento"
	TRCell():New(oCompl,"COMP","",STR0038,/*Picture*/,Iif(lAnalitico,60,28)+aTamConta[1]+nTamCusto+nTamItem+nTamCLVL,/*lPixel*/,/*{|| code-block de impressao }*/)
	oCompl:Cell("COMP"):HideHeader()
	oCompl:SetHeaderSection(.F.)
	oCompl:SetLinesBefore(0)
EndIf

oLancto:SetEdit(.F.)
oConta:SetEdit(.F.)
oContaSint:SetEdit(.F.)
If lAnalitico
	oCompl:SetEdit(.F.)
EndIf

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Gustavo Henrique      ³ Data ³12/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime o relatorio definido pelo usuario de acordo com as  ³±±
±±³          ³secoes/celulas criadas na funcao ReportDef definida acima.  ³±±
±±³          ³Nesta funcao deve ser criada a query das secoes se SQL ou   ³±±
±±³          ³definido o relacionamento e filtros das tabelas em CodeBase.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³EXPO1: Objeto do relatório                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport, aSetOfBook, aCtbMoeda, cPerg )
        
Local oContaSint  	:= oReport:Section(1)
Local oConta		:= oReport:Section(2)
Local oLancto		:= oReport:Section(3)
Local oCompl		:= oReport:Section(4)
Local aSaldo		:= {}
Local aSaldAnt		:= {}
Local aCtbMd01   	:= {}
Local aTamConta		:= TamSX3("CT1_CONTA")
Local lImpLivro		:= .T.     
Local lCusto 		:= .F.
Local lItem			:= .F.
Local lCLVL			:= .F.
Local lAnalitico	:= .F.
Local lSalto		:= .F.
Local lTotalGeral	:= .F.
Local lNormal		:= .F.
Local lReduz		:= .F.
Local lNoMov		:= .F.
Local lJunta		:= .F.
Local lPrintZero	:= .F.
Local cCodRes		:= ""
Local cDescMoeda	:= ""
Local cDescSint		:= ""
Local cDescConta	:= ""
Local cMascara1		:= ""
Local cMascara2		:= ""
Local cMascara3		:= ""
Local cMascara4		:= ""
Local cPicture		:= ""
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
Local cArqTmp		:= ""
Local cTitulo		:= ""
Local cSaldo		:= ""
Local cContaIni		:= ""
Local cContaFIm		:= ""
Local cCustoIni		:= ""
Local cCustoFim		:= ""
Local cItemIni		:= ""
Local cItemFim		:= ""
Local cCLVLIni		:= ""
Local cCLVLFim		:= ""
Local cMoeda		:= ""
Local cArqAbert		:= ""
Local cArqEncer		:= ""
Local dDataAnt		:= CtoD("  /  /  ")
Local dDataIni		:= CtoD("  /  /  ")
Local dDataFim		:= CtoD("  /  /  ")
Local nDecimais		:= 0
Local nSldATran1	:= 0
Local nSldATran2	:= 0
Local nSldDTran1	:= 0
Local nSldDTran2	:= 0
Local nSal01Atu		:= 0
Local nSaldoAtu		:= 0
Local nVlrDeb		:= 0
Local nV01Deb		:= 0
Local nVlrCrd		:= 0
Local nV01Crd		:= 0
Local nTotDeb		:= 0
Local nT01Deb		:= 0
Local nTotCrd		:= 0
Local nT01Crd		:= 0
Local nTotGerDeb	:= 0
Local nT01GerDeb	:= 0
Local nTotGerCrd	:= 0
Local nT01GerCrd	:= 0
Local nInutLin		:= 0
Local nLinAst		:= 0
Local nCont			:= 0
Local cFilterUser 	:= oContaSint:GetAdvplExp()    
Local lTemDados		:= .T.
Local lResetPag		:= .T.
Local m_pag			:= 1 // controle de numeração de pagina
Local l1StQb		:= .T.  
Local nPagIni		:= mv_par22
Local nPagFim		:= mv_par23
Local nReinicia		:= mv_par24
Local nBloco		:= 0
Local nBlCount		:= 1   
Local lRetrato		:= (oReport:GetOrientation()==1)          
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local cNormal 		:= ""
Local cContaSint	:= ""
Local cContaAnt		:= ""
Local bNorSint 		:= {|| GetAdvFVal("CT1","CT1_NORMAL",xFilial("CT1")+cContaAnt,1,"1") }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Garante alteracoes nas perguntas realizadas no dialogo de configuracao do TReport³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( cPerg, .F. )

lCusto 		:= (mv_par13 == 1)
lItem		:= (mv_par13 == 2)
lCLVL		:= (mv_par13 == 3)
lAnalitico	:= (mv_par09 == 1)
lSalto		:= (mv_par21 == 1)
lTotalGeral	:= (mv_par25 == 1)                          

lNormal		:= (mv_par14 == 1)
lReduz		:= (mv_par12 == 1)
lNoMov		:= (mv_par10 == 1)
lJunta		:= (mv_par11 == 1)                           
lPrintZero	:= (mv_par28 == 1)

dDataIni	:= mv_par03
dDataFim	:= mv_par04

cSaldo		:= mv_par07
cContaIni	:= mv_par01
cContaFIm	:= mv_par02
cCustoIni	:= mv_par15
cCustoFim	:= mv_par16
cItemIni	:= mv_par17
cItemFim	:= mv_par18
cCLVLIni	:= mv_par19
cCLVLFim	:= mv_par20
cMoeda		:= mv_par06

aCtbMd01	:= CtbMoeda(mv_par05)

//********************************
// Totalizadores do Relatorio    *
//********************************

// Totais da Conta
oTotConta := TRBreak():New(oContaSint, { || cArqTmp->CONTA }, OemToAnsi(STR0019),) //"Totais da Conta"
If lIsRedStor
	oTotCDeb  := TRFunction():New(oLancto:Cell("LANCDEB")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nTotDeb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .T. , .F. )
	oTotCDeb1 := TRFunction():New(oLancto:Cell("LANCDEB_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nT01Deb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .T. , .F. )
	oTotCCrd  := TRFunction():New(oLancto:Cell("LANCCRD")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nTotCrd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .T. , .F. )
	oTotCCrd1 := TRFunction():New(oLancto:Cell("LANCCRD_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nT01Crd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .T. , .F. )
	oTotCSld  := TRFunction():New(oLancto:Cell("SLDATU")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,Eval(bNorSint),,,,,,lPrintZero,.F.,/*lColDbCr*/)}, .T. , .F. )
	oTotCSld1 := TRFunction():New(oLancto:Cell("SLDATU_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nSal01Atu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,Eval(bNorSint),,,,,,lPrintZero,.F.,/*lColDbCr*/)}, .T. , .F. )
Else
	oTotCDeb  := TRFunction():New(oLancto:Cell("LANCDEB")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nTotDeb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. )}, .T. , .F. )
	oTotCDeb1 := TRFunction():New(oLancto:Cell("LANCDEB_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nT01Deb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. )}, .T. , .F. )
	oTotCCrd  := TRFunction():New(oLancto:Cell("LANCCRD")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nTotCrd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. )}, .T. , .F. )
	oTotCCrd1 := TRFunction():New(oLancto:Cell("LANCCRD_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nT01Crd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. )}, .T. , .F. )
	oTotCSld  := TRFunction():New(oLancto:Cell("SLDATU")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.)}, .T. , .F. )
	oTotCSld1 := TRFunction():New(oLancto:Cell("SLDATU_1")	,,"ONPRINT",oTotConta,,, { || ValorCTB(nSal01Atu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.)}, .T. , .F. )
Endif

// Total Geral
If lImpLivro .And. lTotalGeral	//Imprime total Geral

	oTotGeral := TRBreak():New(oContaSint, { || cArqTmp->(Eof())}, OemToAnsi(STR0039),) //"Total Geral"
	
	oTotGDeb  := TRFunction():New(oLancto:Cell("LANCDEB")	,,"ONPRINT",oTotGeral,,, { || ValorCTB(nTotGerDeb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .F. , .F. )
	oTotGDeb1 := TRFunction():New(oLancto:Cell("LANCDEB_1")	,,"ONPRINT",oTotGeral,,, { || ValorCTB(nT01GerDeb,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .F. , .F. )
	oTotGCrd  := TRFunction():New(oLancto:Cell("LANCCRD")	,,"ONPRINT",oTotGeral,,, { || ValorCTB(nTotGerCrd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .F. , .F. )
	oTotGCrd1 := TRFunction():New(oLancto:Cell("LANCCRD_1")	,,"ONPRINT",oTotGeral,,, { || ValorCTB(nT01GerCrd,0,0,TAM_VALOR-2,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F.,lColDbCr )}, .F. , .F. )	

EndIf

//****************************************
// Fim dos Totalizadores do Relatorio    *
//****************************************

If lRetrato .and. lAnalitico

	oLancto:Cell("HISTORICO"  ):SetSize(0)
	oLancto:Cell("HISTORICO"  ):Disable()
	oLancto:Cell("XPARTIDA"	  ):SetSize(0)
	oLancto:Cell("XPARTIDA"	  ):Disable()
	
	If lCusto
		oLancto:Cell("CUSTO"	  ):SetSize(0)
		oLancto:Cell("CUSTO"	  ):Disable()
	EndIf
	If lCLVL
		oLancto:Cell("CLVL"		  ):SetSize(0)
		oLancto:Cell("CLVL"		  ):Disable()
	EndIf
	If lItem
		oLancto:Cell("ITEM"		  ):SetSize(0)
		oLancto:Cell("ITEM"		  ):Disable()
	EndIf

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("NewHead")== "U"
	IF lAnalitico
		cTitulo	:=	OemToAnsi(STR0007)	//"RAZAO ANALITICO EM MOEDA CORRENTE E "
	Else
		cTitulo	:=	OemToAnsi(STR0008)	//"RAZAO SINTETICO EM MOEDA CORRENTE E "
	EndIf
	cTitulo += 	Alltrim(aCtbMoeda[2]) + OemToAnsi(STR0009) + DTOC(dDataIni) +;	// "DE"
				OemToAnsi(STR0010) + DTOC(dDataFim) + CtbTitSaldo(mv_par07)	// "ATE"
Else
	cTitulo := NewHead
EndIf

oReport:SetTitle(cTitulo)

oReport:SetCustomText( {|| CtCGCCabTR(,,,,,dDataFim,cTitulo,,,,,oReport,.T.,@lResetPag,@nPagIni,@nPagFim,@nReinicia,@m_pag,@nBloco,@nBlCount,@l1StQb) } )

If lAnalitico		// Relatorio Analitico

	oLancto:Cell("LANCDEB"  ):SetTitle(STR0028 + Space(1) + AllTrim(aCtbMoeda[3]))	// DEBITO
	oLancto:Cell("LANCDEBTX"  ):SetTitle( " TX " + aCtbMoeda[3])					// DEBITOTX
	oLancto:Cell("LANCDEB_1"):SetTitle(	STR0028 + Space(1) + aCtbMd01[3])			// DEBITO
	
	oLancto:Cell("LANCCRD"  ):SetTitle(	STR0029 + Space(1) + AllTrim(aCtbMoeda[3]))// CREDITO
	oLancto:Cell("LANCCRDTX"  ):SetTitle(" TX " + aCtbMoeda[3])					// CREDITOTX
	oLancto:Cell("LANCCRD_1"):SetTitle(	STR0029 + Space(1) + aCtbMd01[3])			// CREDITO
	       	
	oLancto:Cell("SLDATU"  	):SetTitle(STR0030 + Space(1) + aCtbMoeda[3])			// SALDO ATUAL
	oLancto:Cell("SLDATU_1"	):SetTitle(STR0030 + Space(1) + aCtbMd01[3])			// SALDO ATUAL
                                            
	oLancto:Cell("LANCDEB"):SetSize(TAM_VALOR)
	oLancto:Cell("LANCDEBTX"):SetSize(TAM_TX)
	oLancto:Cell("LANCCRD"):SetSize(TAM_VALOR)
	oLancto:Cell("LANCCRDTX"):SetSize(TAM_TX)

	oLancto:Cell("LANCDEB"):SetBlock({ || ValorCTB(cArqTmp->LANCDEB  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")// Debito
	If lIsRedStor
		oLancto:Cell("LANCDEBTX"):SetBlock({ || Transform(cArqTmp->TXDEBITO, "@Z 99.9999")},"RIGHT",,"RIGHT")// DebitoTX
	Else
		oLancto:Cell("LANCDEBTX"):SetBlock({ || Transform(cArqTmp->TXDEBITO, "@Z 9999.9999")},"RIGHT",,"RIGHT")// DebitoTX
	EndIF	

	oLancto:Cell("LANCCRD"):SetBlock({ || ValorCTB(cArqTmp->LANCCRD  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")// Credito
	IF lIsRedStor
		oLancto:Cell("LANCCRDTX"):SetBlock({ || Transform(cArqTmp->TXCREDITO, "@Z 99.9999") },"RIGHT",,"RIGHT")// CreditoTX
	Else
		oLancto:Cell("LANCCRDTX"):SetBlock({ || Transform(cArqTmp->TXCREDITO, "@Z 9999.9999") },"RIGHT",,"RIGHT")// CreditoTX
	EndIF
	

Else                // Relatorio Resumido
	
	lCusto 	:= .F.
	lItem  	:= .F.
	lCLVL  	:= .F.

	oLancto:Cell("LANCDEB"  ):SetTitle(STR0028 + Space(1) + aCtbMoeda[3])
	oLancto:Cell("LANCDEB_1"):SetTitle(STR0028 + Space(1) + aCtbMd01[3])
	
	oLancto:Cell("LANCCRD"  ):SetTitle(STR0029 + Space(1) + aCtbMoeda[3])
	oLancto:Cell("LANCCRD_1"):SetTitle(STR0029 + Space(1) + aCtbMd01[3])
	
	oLancto:Cell("SLDATU"  	):SetTitle(STR0030 + Space(1) + aCtbMoeda[3])
	oLancto:Cell("SLDATU_1"	):SetTitle(STR0030 + Space(1) + aCtbMd01[3])

	oLancto:Cell("LANCDEB"):SetSize(TAM_VALOR)
	oLancto:Cell("LANCCRD"):SetSize(TAM_VALOR)

	oLancto:Cell("LANCDEB"):SetBlock(;
		{ || ValorCTB(nVlrDeb  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")
	oLancto:Cell("LANCDEB_1"):SetBlock(;
		{ || ValorCTB(nV01Deb  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")

	oLancto:Cell("LANCCRD"):SetBlock(;
		{ || ValorCTB(nVlrCrd  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"1",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")
	oLancto:Cell("LANCCRD_1"):SetBlock(;
		{ || ValorCTB(nV01Crd  ,,,TAM_VALOR-2,nDecimais,.F.,cPicture,"2",,,,,,lPrintZero,.F.,lColDbCr)},"RIGHT",,"RIGHT")

EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par26==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
	Case mv_par26==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
	Case mv_par26==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase		

If ! lCusto
	If lItem
		lClVl := .F.
	Endif
Else
	lItem := .F.
	lClVl := .F.
Endif

cDescMoeda 	:= Alltrim(aCtbMoeda[2])
nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)

// Mascara da Conta
If Empty(aSetOfBook[2])
	cMascara1 := GetMv("MV_MASCARA")
Else
	cMascara1	:= RetMasCtb(aSetOfBook[2],@cSepara1)
EndIf               

If lCusto .Or. lItem .Or. lCLVL
	// Mascara do Centro de Custo
	If Empty(aSetOfBook[6])
		cMascara2 := GetMv("MV_MASCCUS")
	Else
		cMascara2	:= RetMasCtb(aSetOfBook[6],@cSepara2)
	EndIf                                                
	// Mascara do Item Contabil
	If Empty(aSetOfBook[7])
		cMascara3 := ""
	Else
		cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
	EndIf
	// Mascara da Classe de Valor
	If Empty(aSetOfBook[8])
		cMascara4 := ""
	Else
		cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
	EndIf
EndIf	

cPicture := aSetOfBook[4]

If lImpLivro
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao   					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lAutomato
		MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
					CTBGerRaz(oMeter,oText,oDlg,lEnd,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
					cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
					aSetOfBook,lNoMov,cSaldo,lJunta,"1",lAnalitico,mv_par05,mv_par27,cFilterUser)},;
					OemToAnsi(OemToAnsi(STR0018)),;		// "Criando Arquivo Tempor rio..."
					OemToAnsi(STR0006))						// "Emissao do Razao"

		oReport:NoUserFilter()

		dbSelectArea("cArqTmp")
		dbGoTop()
		lTemDados := (RecCount() > 0)
		oReport:SetMeter(RecCount())
	Else
		CTBGerRaz(,,,,@cArqTmp,cContaIni,cContaFim,cCustoIni,cCustoFim,;
				cItemIni,cItemFim,cCLVLIni,cCLVLFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,lJunta,"1",lAnalitico,mv_par05,mv_par27,cFilterUser)

		dbSelectArea("cArqTmp")
		dbGoTop()
		lTemDados := (RecCount() > 0)
	Endif
Endif

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If lImpLivro .And. ! (lTemDados .And. !Empty(aSetOfBook[5]))

	// Seta ordem das tabelas
	CT1->(dbSetOrder(1) )

	If ! lNormal 
		CTT->(dbSetOrder(1))
		CTD->(dbSetOrder(1))
		CTH->(dbSetOrder(1))
	EndIf	

	oConta:Cell("CONTA"):SetSize(Len(cArqTmp->CONTA))

	// "T o t a i s  d a  C o n t a  ==> " ### "Tot.Conta"
	oTotConta:SetTitle( Iif(lAnalitico,OemToAnsi(STR0020),OemToAnsi(STR0026)))
         
	If lTotalGeral                                                     
		// "T O T A L  G E R A L ==> " ### "TOT.GERAL"
		oTotGeral:SetTitle( Iif(lAnalitico,OemToAnsi(STR0025),OemToAnsi(STR0027)) )
	EndIf	
        
	oContaSint:Init()
	oConta:Init()

	Do While cArqTmp->( ! EoF() .And. !oReport:Cancel() )

	    If oReport:Cancel()
	    	Exit
	    EndIf        

		// Saldo na moeda 02
		If lCusto
			aSaldoAnt := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo)
			aSaldo	  := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo)
		ElseIf lItem
			aSaldoAnt := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo)
			aSaldo	  := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo)			
		ElseIf lClVl
			aSaldoAnt := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,cMoeda,cSaldo)
			aSaldo	  := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo)
		Else	
			aSaldoAnt	:= SaldoCT7(cArqTmp->CONTA,dDataIni,cMoeda,cSaldo,"CTBR400")
			aSaldo 		:= SaldoCT7(cArqTmp->CONTA,cArqTmp->DATAL,cMoeda,cSaldo)
		EndIf
		
		If lIsRedStor
			cNormal 	:= Posicione("CT1",1,xFilial("CT1")+cArqTmp->CONTA,"CT1_NORMAL")
		EndIF
		
		If Ctbr410Fil(lNoMov,aSaldo[6],dDataIni)
			oReport:IncMeter()
			cArqTmp->(dbSkip())
			Loop
		EndIf
	
		cContaSint	:= Ctr400Sint(cArqTmp->CONTA,@cDescSint,cMoeda,@cDescConta,@cCodRes)
		cNormal 	:= CT1->CT1_NORMAL
	    
	    oContaSint:Cell("CONTSINT"):SetSize(Len(cContaSint))
   	    oContaSint:Cell("DESCSINT"):SetSize(Len(cDescSint))
   	    
	  	oContaSint:Cell("CONTSINT"):SetBlock( { || 	EntidadeCTB(cContaSint,0,0,Len(cContaSint),.F.,cMascara1,cSepara1,,,,,.F.)})
	  	oContaSint:Cell("DESCSINT"):SetBlock( { || " - " + cDescSint } )

		oContaSint:PrintLine()
	   
		nT01Deb		:= 0
		nTotDeb		:= 0
		nT01Crd		:= 0
		nTotCrd		:= 0
		nSaldoAtu	:= 0
		nSal01Atu	:= 0
	   
		oReport:SkipLine()
	                                                           
		If mv_par12 == 1							// Imprime Cod Normal
		  	oConta:Cell("CONTA"):SetBlock( { || OemToAnsi(STR0016)+EntidadeCTB(cArqTmp->CONTA,0,0,,.F.,cMascara1,cSepara1,,,,,.F.) } )	//"CONTA - "
        Else
		  	oConta:Cell("CONTA"):SetBlock( { || OemToAnsi(STR0016)+EntidadeCTB(cCodRes,0,0,20,.F.,cMascara1,cSepara1,,,,,.F.) } )	//"CONTA - "
		EndIf

	  	oConta:Cell("DESCONTA"):SetBlock( { || "- " + cDescConta } )
		If lIsRedStor
			cContaAnt := cArqTmp->CONTA                                                
		EndIF
			
		nSaldoAtu := aSaldoAnt[6]
			  	                                         
		// Impressao do Saldo Anterior - moeda 02
	  	oConta:Cell("SLDMOEDA2"):SetBlock( { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.) } )
	  	
		// Saldo na moeda 01
		If lCusto
			aSaldoAnt := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,mv_par05,cSaldo)
			aSaldo	  := SaldTotCT3(cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,mv_par05,cSaldo)		
		ElseIf lItem
			aSaldoAnt := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,mv_par05,cSaldo)
			aSaldo	  := SaldTotCT4(cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,mv_par05,cSaldo)			
		ElseIf lClVl
			aSaldoAnt := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,dDataIni,mv_par05,cSaldo)
			aSaldo	  := SaldTotCTI(cClVlIni,cClVlFim,cItemIni,cItemFim,cCustoIni,cCustoFim,cArqTmp->CONTA,cArqTmp->CONTA,cArqTmp->DATAL,mv_par05,cSaldo)
		Else		
			aSaldoAnt:= SaldoCT7(cArqTmp->CONTA,dDataIni,mv_par05,cSaldo,"CTBR400")
			aSaldo 	 := SaldoCT7(cArqTmp->CONTA,cArqTmp->DATAL,mv_par05,cSaldo)
		EndIf
                                                
		nSal01Atu := aSaldoAnt[6]

	  	oConta:Cell("SLDMOEDA1"):SetBlock( { || ValorCTB(nSal01Atu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F.)})

		oConta:PrintLine()
		
		cContaAnt	:= cArqTmp->CONTA
		dDataAnt	:= CTOD("  /  /  ")

		// A TRANSPORTAR :		
		oReport:SetPageFooter( 5, {|| Iif(oLancto:Printing() /*.Or. oTotConta:Printing()*/,;
			(oReport:PrintText(OemToAnsi(STR0022)),; 
			oReport:PrintText(ValorCTB(nSldATran2,,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) ),;
			oReport:PrintText(ValorCTB(nSldATran1,,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.) )),nil)})

		//"DE TRANSPORTE : "
		oReport:OnPageBreak( {|| Iif(oLancto:Printing() /*.Or. oTotConta:Printing()*/,;
				( oReport:PrintText(OemToAnsi(STR0023)),;
				oReport:PrintText(ValorCTB(nSldDTran2,,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.)),;
			 	oReport:PrintText(ValorCTB(nSldDTran1,,,TAM_VALOR-2,nDecimais,.T.,cPicture,,,,,,,lPrintZero,.F.)),;
			 	oReport:Skipline()),nil)})
		        
		oLancto:Init()
		   
		Do While cArqTmp->( !Eof() .And. CONTA == cContaAnt .And. !oReport:Cancel() )
		                                                                             
			If oReport:Cancel()
				Exit
			EndIf	

			oReport:IncMeter()
		
			// Imprime os lancamentos para a conta
			If dDataAnt != cArqTmp->DATAL
				oLancto:Cell("DATAL"):SetBlock( { || cArqTmp->DATAL } )
				dDataAnt := cArqTmp->DATAL
			Else
				oLancto:Cell("DATAL"):SetBlock( { || dDataAnt } )
			EndIf
						
			If lAnalitico		//Se for relatorio analitico
				IF lIsRedStor
					cContaAnt 	:= cArqTmp->CONTA
				EndiF	
				nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD      
	
				// Valor da Moeda 01
				nSal01Atu 	:= nSal01Atu - cArqTmp->LANCDEB_1 + cArqTmp->LANCCRD_1

				nTotDeb		+= cArqTmp->LANCDEB
				nT01Deb		+= cArqTmp->LANCDEB_1
				nTotCrd		+= cArqTmp->LANCCRD
				nT01Crd		+= cArqTmp->LANCCRD_1
	
				nTotGerDeb	+= cArqTmp->LANCDEB
				nT01GerDeb	+= cArqTmp->LANCDEB_1
				nTotGerCrd	+= cArqTmp->LANCCRD
				nT01GerCrd	+= cArqTmp->LANCCRD_1
				
				CT1->(dbSetOrder(1))
				CT1->(MsSeek(xFilial()+cArqTmp->XPARTIDA))

				cCodRes := CT1->CT1_RES
	                                                                      
				If lReduz // Impr Cod (Normal/Reduzida/Cod.Impress)
					oLancto:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cArqTmp->XPARTIDA,0,0,aTamConta[1],.F.,cMascara1,cSepara1,,,,,.F.) } )
				Else
					oLancto:Cell("XPARTIDA"):SetBlock( { || EntidadeCTB(cCodRes,0,0,TAM_CONTA,.F.,cMascara1,cSepara1,,,,,.F.) } )
				Endif                              
	
				If lCusto
					If lNormal //Imprime Cod. Centro de Custo Normal 
						oLancto:Cell("CUSTO"):SetBlock( { || EntidadeCTB(cArqTmp->CCUSTO,0,0,TAM_CONTA,.F.,cMascara2,cSepara2,,,,,.F.) } )
					Else 
						CTT->(MsSeek(xFilial()+cArqTmp->CCUSTO))
						oLancto:Cell("CUSTO"):SetBlock( { || EntidadeCTB(CTT->CTT_RES,0,0,TAM_CONTA,.F.,cMascara2,cSepara2,,,,,.F.) } )
					Endif                                                       
				Endif
	
				If lItem 	// Se imprime item 
					If lNormal // Imprime Cod. Normal Classe de Valor
						oLancto:Cell("ITEM"):SetBlock( { || EntidadeCTB(cArqTmp->ITEM,0,0,TAM_CONTA,.F.,cMascara3,cSepara3,,,,,.F.) } )
					Else
						CTD->(MsSeek(xFilial("CTD")+cArqTmp->ITEM))
						oLancto:Cell("ITEM"):SetBlock( { || EntidadeCTB(CTD->CTD_RES,0,0,TAM_CONTA,.F.,cMascara3,cSepara3,,,,,.F.) } )
					EndIf
				Endif
					
				If lCLVL	// Se imprime classe de valor
					If lNormal // Imprime Cod. Normal Classe de Valor
						oLancto:Cell("CLVL"):SetBlock( { || EntidadeCTB(cArqTmp->CLVL,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
					Else
						CTH->(MsSeek(xFilial("CTH")+cArqTmp->CLVL))
						oLancto:Cell("CLVL"):SetBlock( { || EntidadeCTB(CTH->CTH_RES,0,0,TAM_CONTA,.F.,cMascara4,cSepara4,,,,,.F.) } )
					Endif			
				Endif
				
				// Saldo na moeda 02   
				
	 			oLancto:Cell("SLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )

				// Saldo na Moeda 01
				oLancto:Cell("SLDATU_1"):SetBlock( { || ValorCTB(nSal01Atu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )

				oLancto:PrintLine()

				nSldATran2 := nSaldoAtu // Valor a Transportar - Moeda 2
				nSldATran1 := nSal01Atu // Valor a Transportar - Moeda 1
					
				nSldDTran2 := nSaldoAtu // Valor de Transporte - 2
				nSldDTran1 := nSal01Atu // Valor de Transporte - 1
	                             
				If lAnalitico
					// Procura pelo complemento de historico e imprime se encontrar
					ImpCompl(oReport)
        		EndIf
        		
				cArqTmp->(dbSkip())
				
			Else		// Se for resumido.                               			

				Do While cArqTmp->( !EoF() .And. dDataAnt == DATAL .And. cContaAnt == CONTA .And. !oReport:Cancel() )
					
					If oReport:Cancel()
						Exit
					EndIf	

					oReport:IncMeter()			        	
					nVlrDeb	+= cArqTmp->LANCDEB
					nV01Deb	+= cArqTmp->LANCDEB_1
					nVlrCrd	+= cArqTmp->LANCCRD
					nV01Crd	+= cArqTmp->LANCCRD_1
	
					nTotGerDeb	+= cArqTmp->LANCDEB
					nTotGerCrd	+= cArqTmp->LANCCRD
					nT01GerDeb	+= cArqTmp->LANCDEB_1
					nT01GerCrd	+= cArqTmp->LANCCRD_1
					cArqTmp->(dbSkip())
				EndDo			                                                                    
				
				If !oReport:Cancel()
					If lIsRedStor
						cContaAnt := cArqTmp->CONTA                                                
					EndIF					
					nSaldoAtu := nSaldoAtu - nVlrDeb + nVlrCrd
					nSal01Atu := nSal01Atu - nV01Deb + nV01Crd

					oLancto:Cell("DATAL"):SetBlock( { || dDataAnt } )
		
					// Saldo na moeda 02 
					oLancto:Cell("SLDATU"):SetBlock( { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
	
					// Saldo na Moeda 01
					oLancto:Cell("SLDATU_1"):SetBlock( { || ValorCTB(nSal01Atu,0,0,TAM_VALOR-2,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
	                    
					oLancto:PrintLine()
	
					nTotDeb		+= nVlrDeb
					nTotCrd		+= nVlrCrd         
					nT01Deb		+= nV01Deb
					nT01Crd		+= nV01Crd         
					nVlrDeb		:= nV01Deb := 0
					nVlrCrd		:= nV01Crd := 0
				EndIf	
				
			EndIf

		EndDo  
		
		oLancto:Finish()
/*
		If !oReport:Cancel() 
		    oLancto:Finish()     
	    
		    oTotConta:Init()
		    
			oTotConta:Cell("TOT_DEB"  ):SetBlock( { || ValorCTB(nTotDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			oTotConta:Cell("TOT_DEB_1"):SetBlock( { || ValorCTB(nT01Deb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
				
			oTotConta:Cell("TOT_CRD"  ):SetBlock( { || ValorCTB(nTotCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			oTotConta:Cell("TOT_CRD_1"):SetBlock( { || ValorCTB(nT01Crd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			
			oTotConta:Cell("TOT_SLD"  ):SetBlock( { || ValorCTB(nSaldoAtu,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			oTotConta:Cell("TOT_SLD_1"):SetBlock( { || ValorCTB(nSal01Atu,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
		            
			oTotConta:PrintLine()    
			
			oTotConta:Finish()   
			
			oReport:SkipLine()
			
			If lSalto .And. cArqTmp->(!EoF())
				oReport:EndPage()
			EndIf
				
		EndIf	
*/

		nSldATran2 := 0 // Valor a Transportar - Moeda 2
		nSldATran1 := 0 // Valor a Transportar - Moeda 1
			
		nSldDTran2 := 0 // Valor de Transporte - 2
		nSldDTran1 := 0 // Valor de Transporte - 1

	EndDo

	oConta:Finish()
	oContaSint:Finish()
/*		
	If !oReport:Cancel() .And. lTemDados

		If lImpLivro .And. lTotalGeral	//Imprime total Geral

			oTotGeral:Init()
	
			oTotGeral:Cell("TOT_DEB"  ):SetBlock( { || ValorCTB(nTotGerDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			oTotGeral:Cell("TOT_DEB_1"):SetBlock( { || ValorCTB(nT01GerDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
	
			oTotGeral:Cell("TOT_CRD"  ):SetBlock( { || ValorCTB(nTotGerCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
			oTotGeral:Cell("TOT_CRD_1"):SetBlock( { || ValorCTB(nT01GerCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,cNormal,,,,,,lPrintZero,.F. ) } )
		                      
			oReport:ThinLine()
			
		 	oTotGeral:PrintLine()
			oTotGeral:Finish()	
		
		Endif
	
	EndIf
*/
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	
Endif

nLinAst := GetNewPar("MV_INUTLIN",0)
If !oReport:Cancel() .And. lTemDados .And. nLinAst # 0
	For nInutLin := 1 to nLinAst
		oReport:SkipLine()
		oReport:PrintText(Replicate("*",oReport:PageWidth()))
	Next
EndIf

If !oReport:Cancel() .And. lImpTermos 							// Impressao dos Termos

	cArqAbert:=GetNewPar("MV_LRAZABE","")
	cArqEncer:=GetNewPar("MV_LRAZENC","")
	
    If Empty(cArqAbert)
		ApMsgAlert(	"Devem ser criados os parametros MV_LRAZABE e MV_LRAZENC. " +;
					"Utilize como base MV_LDIARAB.")
	Endif
Endif

If !oReport:Cancel() .And. lImpTermos .And. !Empty(cArqAbert)	// Impressao dos Termos

	dbSelectArea("SM0")
	aVariaveis:={}

	For nCont:=1 to FCount()	
		If FieldName(nCont)=="M0_CGC"
			AADD(aVariaveis,{FieldName(nCont),Transform(FieldGet(nCont),"@R! NN.NNN.NNN/NNNN-99")})
		Else
            If FieldName(nCont)=="M0_NOME"
                Loop
            EndIf
			AADD(aVariaveis,{FieldName(nCont),FieldGet(nCont)})
		Endif
	Next

	dbSelectArea("SX1")
	dbSeek( Padr( "CTR410", Len( X1_GRUPO ) , ' ' ) + "01")

	While SX1->X1_GRUPO == Padr( "CTR410", Len( X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
		dbSkip()
	End

	If !File(cArqAbert)
		aSavSet:=__SetSets()
		If !lAutomato
			cArqAbert:=CFGX024(,"Razão") // Editor de Termos de Livros
		Endif
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If !File(cArqEncer)
		aSavSet:=__SetSets()
		If !lAutomato
			cArqEncer:=CFGX024(,"Razão") // Editor de Termos de Livros
		Endif
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If cArqAbert#NIL
		oReport:EndPage()
		ImpTerm2(cArqAbert,aVariaveis,,,, oReport)
	Endif

	If cArqEncer#NIL     
		oReport:EndPage()	
		ImpTerm2(cArqEncer,aVariaveis,,,, oReport)
	Endif

Endif

dbselectArea("CT2")

Return
                
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpCompl  ºAutor  ³Gustavo Henrique    º Data ³  12/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Retorna a descricao, da conta contabil, item, centro de     º±±
±±º          ³custo ou classe valor                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³EXPO1 - Objeto do relatorio TReport.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpCompl(oReport)
	
Local oCompl := oReport:Section(4)

oCompl:SetHeaderSection(.F.)
oCompl:SetLinesBefore(0)

oCompl:Cell("COMP"):SetBlock({|| Space(LEN(DTOS(CT2->CT2_DATA))+4+LEN(CT2->CT2_LOTE)+LEN(CT2->CT2_SBLOTE)+LEN(CT2->CT2_DOC))+CT2->CT2_LINHA+Space(1)+Subs(CT2->CT2_HIST,1,40) } )
oCompl:Init()
// Procura pelo complemento de historico
dbSelectArea("CT2")
dbSetOrder(10)
If MsSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.)
	dbSkip()
	If CT2->CT2_DC == "4"			//// TRATAMENTO PARA IMPRESSAO DAS CONTINUACOES DE HISTORICO
		Do While !	CT2->(Eof()) .And.;
					CT2->CT2_FILIAL == xFilial("CT2") 		.And.;
					CT2->CT2_LOTE   == cArqTMP->LOTE		.And.;
					CT2->CT2_SBLOTE == cArqTMP->SUBLOTE		.And.;
					CT2->CT2_DOC    == cArqTmp->DOC 		.And.;
					CT2->CT2_SEQLAN == cArqTmp->SEQLAN	 	.And.;
					CT2->CT2_EMPORI == cArqTmp->EMPORI		.And.;
					CT2->CT2_FILORI == cArqTmp->FILORI 		.And.;
					CT2->CT2_DC     == "4" 					.And.;
				 	DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL)
			oCompl:Printline()
			CT2->(dbSkip())
		EndDo
	EndIf
EndIf

oCompl:Finish()

dbSelectArea("cArqTmp")
    
Return
                
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ Ctbr410Fil ºAutor  ³ Gustavo Henrique   º Data ³  14/09/06 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Filtra contas sem movimento                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR440                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ctbr410Fil(lNoMov,nSaldo,dDataIni)

Local lOk := .F.

If !lNoMov //Se imprime conta sem movimento
	lOk := (nSaldo == 0 .And. cArqTmp->LANCDEB + cArqTmp->LANCDEB_1 ==0 .And.;
			cArqTmp->LANCCRD + cArqTmp->LANCCRD_1 == 0)
Endif             

If lNomov .And. (nSaldo == 0 .And.	cArqTmp->LANCDEB + cArqTmp->LANCDEB_1 ==0 .And.;
							cArqTmp->LANCCRD + cArqTmp->LANCCRD_1 == 0) 
	If CtbExDtFim("CT1") .And. CT1->(MsSeek(xFilial()+cArqTmp->CONTA))
		lOk := !CtbVlDtFim("CT1",dDataIni) 		
	EndIf
EndIf

Return lOk
