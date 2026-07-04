/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "CTBR430.Ch"
#Include "PROTHEUS.Ch"

STATIC lFWCodFil := .T.

STATIC lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//Tradução PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres



STATIC __lCusto	:= CtbMovSaldo("CTT")//Define se utiliza C.Custo
STATIC __lItem 	:= CtbMovSaldo("CTD")//Define se utiliza Item
STATIC __lClVl		:= CtbMovSaldo("CTH")//Define se utiliza Cl.Valor 
STATIC _oCTBR430
STATIC __lMovEnt05    := CtbIsCube()

#DEFINE 	QTD_COL		12
#DEFINE  	TAM_VALOR		18                      
#DEFINE  	TAM_DOC  		22
#DEFINE  	TAM_DATA  		10

#DEFINE 	R4_COL_DATA   		1
#DEFINE 	R4_COL_NUMERO 		2
#DEFINE 	R4_COL_HISTORICO		3
#DEFINE 	R4_COL_CENTRO_CUSTO 	4
#DEFINE 	R4_COL_ITEM_CONTABIL 5
#DEFINE 	R4_COL_CLASSE_VALOR  6 
#DEFINE 	R4_COL_VLR_DEBITO		7
#DEFINE 	R4_COL_VLR_CREDITO	8
#DEFINE 	R4_COL_VLR_SALDO  	9
#DEFINE 	R4_COL_TIPO       	10
#DEFINE 	R4_COL_VLR_ATRANS 	11
#DEFINE 	R4_COL_VLR_DTRANS 	12

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR430  ³ Autor ³ Simone Mie Sato       ³ Data ³ 28.05.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Raz„o Gerencial de  Conta                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR430()                                                  ³±±
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
User Function CTBR430()

U_CTBR430R4()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CTBR430R4³ Autor ³ Gustavo Henrique      ³ Data ³ 15/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emiss„o do Raz„o Gerencial de Conta                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CTBR430R4()                                                ³±±
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
User Function CTBR430R4()

Local oReport	

Local lRet			:= .T.
Private aCtbMoeda	:= {}
Private nTamLinha	:= 220
Private nTamCta		:= Len(CriaVar ("CT1_CONTA"))
Private titulo		:= STR0006 	//"Emissao do Razao Gerencial de Conta"
Private lAnalitico 	:= .T.
Private WnRel 		:= "CTBR430"
Private aReturn	:= { STR0004, 1,STR0005, 2, 2, 1, "", 1 }  //"Zebrado"###"Administracao"
Private aLinha		:= {}
Private cPerg		:= "CTR430"
Private nomeprog	:= "CTBR430"
Private nLastKey	:= 0
Private Tamanho 	:= "G"
Private lCodImp	:= .F.
Private cTipoRel	:= "1"	//Paisagem
Private cString		:= "CT2"
Private aSetOfBook	:= {}
Private lCusto
Private lItem
Private lCLVL

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

lRet := Pergunte("CTR430", .T.)

If nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // Set Of Books                          ³
//³ mv_par02            // Da Entidade Gerencial                 ³
//³ mv_par03            // Ate a Entidade Gerencial              ³
//³ mv_par04            // Da data                               ³
//³ mv_par05            // Ate a data                            ³
//³ mv_par06            // Moeda			                     ³   
//³ mv_par07            // Tipo de Saldo	                     ³   
//³ mv_par08            // Analitico ou Resumido dia (resumo)    ³
//³ mv_par09            // Imprime Entid. Gerenc. sem Movimento  ³
//³ mv_par10            // Imprime C.Custo?                      ³
//³ mv_par11            // Imprime Item?	                     ³	
//³ mv_par12            // Imprime Classe de Valor?              ³	
//³ mv_par13            // Salto de pagina                       ³
//³ mv_par14            // Pagina Inicial                        ³
//³ mv_par15            // Pagina Final                          ³
//³ mv_par16            // Numero da Pag p/ Reiniciar            ³	   
//³ mv_par17            // Imprime Cod C.Custo(Normal / Reduzido)³
//³ mv_par18            // Imprime Cod Item (Normal / Reduzido)  ³
//³ mv_par19            // Imprime Cod Cl.Valor(Normal /Reduzida)³
//³ mv_par20            // Imprime Total Geral (Sim/Nao)         ³
//³ mv_par21            // So Livro/Livro e Termos/So Termos     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lAnalitico	:= Iif(mv_par08 == 1,.T.,.F.)
lCusto 		:= Iif(mv_par10 == 1,.T.,.F.)
lItem		:= Iif(mv_par11 == 1,.T.,.F.)
lCLVL		:= Iif(mv_par12 == 1,.T.,.F.)  

//Verifica se a configuracao de livros esta preenchida. Por se tratar de Razao Gerencial de Conta, eh obrigatorio o 
//preenchimento da configuracao de livros amarrada com plano gerencial.
If lRet
	If Empty(mv_par01) 
		lRet := .F.   
		MsgAlert(STR0043)//"Favor preencher a pergunta com o Codigo do Set Of Books (Configuracao de Livros) do plano gerencial desejado."
	Else        
		dbSelectArea("CTN")
		dbSetOrder(1)
		If !MsSeek(xFilial()+mv_par01)
			lRet	:= .F.
			MsgAlert(STR0045) 	//"Verificar se o Set of Books (configuracao de livros) esta cadastrado."
		Else
			aSetOfBook := CTBSetOf(mv_par01)
		EndIf
	EndIf
EndIf

If lRet
	//Verificar se a configuracao de livros possui plano gerencial associado. 
	If Empty(aSetOfBook[5])
		lRet	:= .F.
		MsgAlert(STR0044)//"O set of books (configuracao de livros) devera ter um plano gerencial associado."
	EndIf
EndIf

If lRet
   aCtbMoeda  	:= CtbMoeda(mv_par06)
   If Empty(aCtbMoeda[1])
      Help(" ",1,"NOMOEDA")
      lRet := .F.
   Endif
Endif

If !lRet	
	Set Filter To
	Return
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	oReport := ReportDef()
							
	oReport:PrintDialog()
EndIf

Return 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Gustavo Henrique      ³ Data ³15/09/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local aRelat		:= {}
Local cDesc1		:= OemToAnsi(STR0001)	// "Este programa ir  imprimir o Raz„o Contabil,"
Local cDesc2		:= OemToAnsi(STR0002)	// "os parametros solicitados pelo usuario. O Relatorio sera"
Local cDesc3		:= OemToAnsi(STR0003)	// "impresso em Real e outra Moeda escolhida pelo Usuario."
Local cSayCusto		:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local nTamCusto		:= Len(CriaVar("CT3_CUSTO"))
Local nTamItem 		:= Len(CriaVar("CTD_DESC"+mv_par06))
Local nTamCLVL		:= Len(CriaVar("CTH_CLVL"))
Local nTamHist		:= TamSX3("CT2_HIST")[1]
Local nAlignTot		:= 0                       
Local cTpValor		:= GetMV("MV_TPVALOR")
Local nTaVal              

oReport :=	TReport():New( "CTBR430", OemToAnsi(STR0006), cPerg,;	//"Emissao do Razao Contabil"
			{ |oReport|	Pergunte( cPerg, .F. ),;
				aRelat := U_C430R4Proc(wnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,lAnalitico,Titulo,nTamlinha,aCtbMoeda,nTamCta),;
				If(!Empty(aRelat),ReportPrint(WnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,lAnalitico,Titulo,nTamlinha,aCtbMoeda,nTamCta,oReport,aRelat),.F.) },;
				cDesc1+cDesc2+cDesc3)

If lAnalitico                  
	oReport:SetLandScape(.T.)
Else
	oReport:SetPortrait(.T.)
EndIf

// Lancamentos
oLancto := TRSection():New( oReport, STR0051,,, .F., .F. )	// "Lançamento"
oLancto:SetTotalInLine(.F.)
oLancto:SetHeaderPage(.T.)
oLancto:SetLineBreak(.T.)

TRCell():New(oLancto, "DATAL"			, "", STR0019			,/*Picture*/,TAM_DATA	+ 2, , , "LEFT",,"LEFT",,,.F.)
TRCell():New(oLancto, "DOCUMENTO" 		, "", STR0046			,/*Picture*/,TAM_DOC	+ 2,/*lPixel*/,/*{|| }*/)// "LOTE/SUB/DOC/LINHA"
TRCell():New(oLancto, "HISTORICO"		, "", STR0047			,/*Picture*/,nTamHist   + 5,/*lPixel*/,/*{|| }*/, /*"RIGHT"*/,/*lLineBreak*/,/*"RIGHT"*/,,,.F.)
TRCell():New(oLancto, "CUSTO"	  		, "", Upper(cSayCusto)	,/*Picture*/,nTamCusto	+ 2,/*lPixel*/,/*{|| }*/)// Centro de Custo
TRCell():New(oLancto, "CLVL"			, "", Upper(cSayClVl) 	,/*Picture*/,nTamCLVL	+ 2,/*lPixel*/,/*{|| }*/)// Classe de Valor
TRCell():New(oLancto, "ITEM"			, "", Upper(cSayItem) 	,/*Picture*/,nTamItem	+ 2,/*lPixel*/,/*{|| }*/)// Item Contabil

If (cTpValor == "P" .or. cTpValor == "D") .or. lIsRedStor
	 nTaVal = TAM_VALOR+2
Else
	 nTaVal = TAM_VALOR
Endif 	 
TRCell():New(oLancto, "LANCDEB"		, "", STR0048  	,/*Picture*/,nTaVal+5,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// Debito
TRCell():New(oLancto, "LANCCRD"		, "", STR0049  	,/*Picture*/,nTaVal+5,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// Credito
TRCell():New(oLancto, "SLDATU"		, "", STR0050	,/*Picture*/,nTaVal+5,/*lPixel*/,/*{|| }*/,"RIGHT",,"RIGHT")// Sinal do Saldo Atual => Consulta Razao

// Complemento
oCompl := TRSection():New( oReport,STR0053,,, .F., .F. )	//"Complemento"

TRCell():New(oCompl,"COMP_NUMERO"	 ,"",Upper(STR0053),/*Picture*/,TAM_DATA+TAM_DOC,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCompl,"COMP_HISTORICO","",STR0047,/*Picture*/,nTamHist,/*lPixel*/,/*{|| code-block de impressao }*/)

oCompl:Cell("COMP_NUMERO"   ):HideHeader()
oCompl:Cell("COMP_HISTORICO"):HideHeader()
              
// Totais da Conta
oTotConta := TRSection():New( oReport,STR0052,,, .F., .F. )	// "Totais da Conta"

TRCell():New(oTotConta, "R4_COL_DATA"	, "", STR0019			 ,/*Picture*/, TAM_DATA + 2,/*lPixel*/,/*{|| }*/)// Data do Lancamento
TRCell():New(oTotConta, "COL_DOC" 		, "", STR0046			 ,/*Picture*/, TAM_DOC  + 2,/*lPixel*/,/*{|| }*/)// "LOTE/SUB/DOC/LINHA"
TRCell():New(oTotConta, "COL_HIST"		, "", STR0047			 ,/*Picture*/, nTamHist + 5,/*lPixel*/,/*{|| }*/)// Historico
TRCell():New(oTotConta, "COL_CUSTO"		, "", Upper(cSayCusto)	 ,/*Picture*/, nTamCusto+ 2,/*lPixel*/,/*{|| }*/)// Centro de Custo
TRCell():New(oTotConta, "COL_CLVL"		, "", Upper(cSayClVl)	 ,/*Picture*/, nTamCLVL + 2,/*lPixel*/,/*{|| }*/)// Classe de Valor
TRCell():New(oTotConta, "COL_ITEM"		, "", Upper(cSayItem)	 ,/*Picture*/, nTamItem + 2,/*lPixel*/,/*{|| }*/)// Item Contabil
TRCell():New(oTotConta, "TOT_DEB"  		, "", STR0048            ,/*Picture*/, nTaVal+5    ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oTotConta, "TOT_CRD"		, "", STR0049            ,/*Picture*/, nTaVal+5    ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oTotConta, "TOT_SLD"		, "", STR0050            ,/*Picture*/, nTaVal+5    ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")

oTotConta:Cell("R4_COL_DATA"  ):HideHeader()
If lAnalitico
	oTotConta:Cell("R4_COL_DATA" ):Hide()
EndIf	

oTotConta:Cell("COL_DOC"   ):HideHeader()
oTotConta:Cell("COL_DOC"   ):Hide()
oTotConta:Cell("COL_HIST"  ):HideHeader()
oTotConta:Cell("TOT_DEB"   ):HideHeader()
oTotConta:Cell("TOT_CRD"   ):HideHeader()
oTotConta:Cell("TOT_SLD"   ):HideHeader()

oTotGeral := TRSection():New( oReport,STR0054,,, .F., .F. )	//"Total Geral"

// Total Geral
TRCell():New(oTotGeral, "R4_COL_DATA"	, "", STR0019		  ,/*Picture*/, TAM_DATA +2,/*lPixel*/,/*{|| }*/)// Data do Lancamento
TRCell():New(oTotGeral, "COL_DOC" 		, "", STR0046		  ,/*Picture*/, TAM_DOC  +2,/*lPixel*/,/*{|| }*/)// "LOTE/SUB/DOC/LINHA"
TRCell():New(oTotGeral, "COL_HIST"		, "", STR0047		  ,/*Picture*/, nTamHist +5,/*lPixel*/,/*{|| }*/)// Historico
TRCell():New(oTotGeral, "COL_CUSTO"		, "", Upper(cSayCusto),/*Picture*/, nTamCusto+ 2,/*lPixel*/,/*{|| }*/)// Centro de Custo
TRCell():New(oTotGeral, "COL_CLVL"		, "", Upper(cSayClVl) ,/*Picture*/,nTamCLVL + 2,/*lPixel*/,/*{|| }*/)// Classe de Valor
TRCell():New(oTotGeral, "COL_ITEM"		, "", Upper(cSayItem) ,/*Picture*/,nTamItem + 2,/*lPixel*/,/*{|| }*/)// Item Contabil
TRCell():New(oTotGeral, "TOT_DEB"  		, "", STR0048         ,/*Picture*/, nTaVal   +2,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
TRCell():New(oTotGeral, "TOT_CRD"		, "", STR0049         ,/*Picture*/, nTaVal   +2,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")
//Criado esta coluna somente para poder acompanhar a linha de oTotConta
TRCell():New(oTotGeral, "TOT_SLD"		, "", STR0050         ,/*Picture*/, nTaVal   ,/*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",,"RIGHT")

oTotGeral:Cell("R4_COL_DATA"  ):HideHeader()
If lAnalitico
	oTotGeral:Cell("R4_COL_DATA" ):Hide()
EndIf	
oTotGeral:Cell("COL_DOC"   ):HideHeader()
oTotGeral:Cell("COL_DOC"   ):Hide()
oTotGeral:Cell("COL_HIST"  ):HideHeader()
oTotGeral:Cell("TOT_DEB"   ):HideHeader()
oTotGeral:Cell("TOT_CRD"   ):HideHeader()
oTotGeral:Cell("TOT_SLD"   ):HideHeader()

If !lAnalitico
	
	oLancto:Cell("DATAL"):SetSize(40)
	oTotConta:Cell("R4_COL_DATA"):SetSize(40)
	oTotGeral:Cell("R4_COL_DATA"):SetSize(40)
	
	oLancto:Cell("DOCUMENTO"):Disable()
	oLancto:Cell("HISTORICO"):Disable()
	oLancto:Cell("CUSTO"):Disable()
	oLancto:Cell("CLVL"):Disable()
	oLancto:Cell("ITEM"):Disable()
	
	oTotConta:Cell("COL_DOC"):Disable()
	oTotConta:Cell("COL_HIST"):Disable()
	oTotConta:Cell("COL_CUSTO"):Disable()
	oTotConta:Cell("COL_CLVL"):Disable()
	oTotConta:Cell("COL_ITEM"):Disable()

	oTotGeral:Cell("COL_DOC"):Disable()
	oTotGeral:Cell("COL_HIST"):Disable()
	oTotGeral:Cell("COL_CUSTO"):Disable()
	oTotGeral:Cell("COL_CLVL"):Disable()
	oTotGeral:Cell("COL_ITEM"):Disable()

EndIf

// Ajusta impressao das colunas de totais para centro de custo conforme parametros
If !lCusto
	oLancto:Cell("CUSTO"):Disable()
	oTotConta:Cell("COL_CUSTO"):Disable()
	oTotGeral:Cell("COL_CUSTO"):Disable()
Else
	oTotConta:Cell("COL_CUSTO" ):HideHeader()
	oTotConta:Cell("COL_CUSTO" ):Hide()
	oTotGeral:Cell("COL_CUSTO" ):HideHeader()
	oTotGeral:Cell("COL_CUSTO" ):Hide()
EndIf

// Ajusta impressao das colunas de totais para classe de valor conforme parametros
If !lClVl	
	oLancto:Cell("CLVL"):Disable()
	oTotConta:Cell("COL_CLVL"):Disable()
	oTotGeral:Cell("COL_CLVL"):Disable()
Else
	oTotConta:Cell("COL_CLVL"  ):HideHeader()
	oTotConta:Cell("COL_CLVL"  ):Hide()
	oTotGeral:Cell("COL_CLVL"  ):HideHeader()
	oTotGeral:Cell("COL_CLVL"  ):Hide()
EndIf

// Ajusta impressao das colunas de totais para item contabil conforme parametros
If !lItem	
	oLancto:Cell("ITEM"):Disable()
	oTotConta:Cell("COL_ITEM"):Disable()
	oTotGeral:Cell("COL_ITEM"):Disable()
Else
	oTotConta:Cell("COL_ITEM"  ):HideHeader()
	oTotConta:Cell("COL_ITEM"  ):Hide()
	oTotGeral:Cell("COL_ITEM"  ):HideHeader()
	oTotGeral:Cell("COL_ITEM"  ):Hide()
EndIf	
                           
// Ajusta alinhamento das colunas
If lAnalitico .And. (lClVl .Or. lCusto .Or. lItem)
	oTotConta:Cell("COL_HIST"):SetSize(nTamHist+1)
	oTotGeral:Cell("COL_HIST"):SetSize(nTamHist+1)
EndIf

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportPrint³ Autor³ Gustavo Henrique     ³ Data ³ 15/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio de razao gerencial por conta,       ³±±
±±³          ³ utilizando o objeto de relatorio personalizavel - TReport  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportPrint()                                              ³±±
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
Static Function ReportPrint(WnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,lAnalitico,Titulo,nTamlinha,;
					aCtbMoeda,nTamCta,oReport,aRelat)

Local oLancto		:= oReport:Section(1)
Local oCompl		:= oReport:Section(2)
Local oTotConta	:= oReport:Section(3)
Local oTotGeral	:= oReport:Section(4)
Local cFilterUser := oLancto:GetAdvplExp()    

Local cArqAbert  	:= ""
Local cArqEncer	:= ""
Local cTipo			:= ""
Local cTipoAnt		:= ""
Local cPicture 	:= aSetOfBook[4]
Local cMoeda		:= mv_par06      
Local nLin			:= 0
Local nDecimais 	:= DecimalCTB(aSetOfBook,cMoeda)
Local i				:= 0
Local lImpLivro 	:= .F.
Local lImpTermos 	:= .F.
Local lSaltaPg		:= (mv_par13 == 1)
Local lTotGer		:= (mv_par20 == 1)
Local aVariaveis	:= {}
Local aSavSet   	:= {}

oLancto:SetLeftMargin(0) 
oTotConta:SetLeftMargin(0)
oTotGeral:SetLeftMargin(0)
oCompl:SetLeftMargin(0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par21==1 ; lImpLivro:=.T. ; lImpTermos:=.F.
	Case mv_par21==2 ; lImpLivro:=.T. ; lImpTermos:=.T.
	Case mv_par21==3 ; lImpLivro:=.T. ; lImpTermos:=.T.
EndCase		

If lImpLivro

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Titulo do Relatorio                                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Type("NewHead")== "U"
		IF lAnalitico
			Titulo	:=	STR0007	//"RAZAO ANALITICO EM "
		Else
			Titulo	:=	STR0008	//"RAZAO SINTETICO EM "
		EndIf
		Titulo += 	Alltrim(aCtbMoeda[2]) + STR0009 + DTOC(mv_par04) +;	// "DE"
					STR0010 + DTOC(mv_par05) + CtbTitSaldo(mv_par07)	// "ATE"
	Else
		Titulo := NewHead
	EndIf

	oReport:SetTitle(Titulo)
	oReport:SetPageNumber(mv_par14) //mv_par21	-	Pagina Inicial
	oReport:SetCustomText( {|| CtCGCCabTR(,,,,,mv_par05,oReport:Title(),,,,,oReport) } )

	oLancto:Cell( "DATAL"   	):SetBlock( { || aRelat[nLin,R4_COL_DATA] 		} )
	oLancto:Cell( "DOCUMENTO"	):SetBlock( { || aRelat[nLin,R4_COL_NUMERO]		} )
	oLancto:Cell( "HISTORICO"	):SetBlock( { || aRelat[nLin,R4_COL_HISTORICO ] 	} )
		
	If lCusto
		oLancto:Cell( "CUSTO" ):SetBlock( { || aRelat[nLin,R4_COL_CENTRO_CUSTO]	} )
	EndIf
	
	If lClVl	
		oLancto:Cell( "CLVL" ):SetBlock( { || aRelat[nLin,R4_COL_CLASSE_VALOR]	} )
	EndIf	                                                                    
	
	If lItem
		oLancto:Cell( "ITEM" ):SetBlock( { || aRelat[nLin,R4_COL_ITEM_CONTABIL] 	} )
	EndIf	
	
	oLancto:Cell( "LANCDEB"	):SetBlock( { || aRelat[nLin,R4_COL_VLR_DEBITO] 		} )
	oLancto:Cell( "LANCCRD"	):SetBlock( { || aRelat[nLin,R4_COL_VLR_CREDITO] 		} )
	oLancto:Cell( "SLDATU"	):SetBlock( { || aRelat[nLin,R4_COL_VLR_SALDO] 		} )
	
	oCompl:Cell( "COMP_NUMERO"):SetBlock( { || aRelat[nLin,R4_COL_NUMERO] } )
	oCompl:Cell( "COMP_HISTORICO"):SetBlock( { || aRelat[nLin,R4_COL_HISTORICO] } )
	
	If lAnalitico
		oTotConta:Cell( "COL_HIST" ):SetBlock( { || aRelat[nLin,R4_COL_HISTORICO] } )	
	Else
		oTotConta:Cell( "R4_COL_DATA" ):SetBlock( { || aRelat[nLin,R4_COL_DATA] } )		
	EndIf	
	
	oTotConta:Cell( "TOT_DEB" ):SetBlock( { || aRelat[nLin,R4_COL_VLR_DEBITO] 	} )
	oTotConta:Cell( "TOT_CRD" ):SetBlock( { || aRelat[nLin,R4_COL_VLR_CREDITO] 	} )
	oTotConta:Cell( "TOT_SLD" ):SetBlock( { || aRelat[nLin,R4_COL_VLR_SALDO] 		} )
	
	If lAnalitico
		oTotGeral:Cell( "COL_HIST" ):SetBlock( { || aRelat[nLin,R4_COL_HISTORICO] } )	
	Else
		oTotGeral:Cell( "R4_COL_DATA" ):SetBlock( { || aRelat[nLin,R4_COL_DATA] } )		
	EndIf	
	
	oTotGeral:Cell( "TOT_DEB" ):SetBlock( { || aRelat[nLin,R4_COL_VLR_DEBITO] 	} )
	oTotGeral:Cell( "TOT_CRD" ):SetBlock( { || aRelat[nLin,R4_COL_VLR_CREDITO] 	} )

	// A TRANSPORTAR :		
	oReport:SetPageFooter( 2, {|| Iif(oLancto:Printing(),;
		(oReport:PrintText(OemToAnsi(STR0022)),; 
		oReport:PrintText(ValorCTB(If(aRelat[nLin,R4_COL_VLR_ATRANS]==Nil,0,aRelat[nLin,R4_COL_VLR_ATRANS]),,,;
		TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,.T.,.F.) )),nil)})
	
	//"DE TRANSPORTE : "
	oReport:OnPageBreak( {|| Iif(oLancto:Printing(),;
				( oReport:PrintText(OemToAnsi(STR0023)),;
			 	oReport:PrintText(ValorCTB(If(aRelat[nLin,R4_COL_VLR_DTRANS]==Nil,0,aRelat[nLin,R4_COL_VLR_DTRANS]),,,;
			 	TAM_VALOR,nDecimais,.T.,cPicture,,,,,,,.T.,.F.)), 	oReport:Skipline()),nil)})
	
	oReport:SetMeter(Len(aRelat))  
	
	oLancto:Init()                  	
	                         
	
	nLin := 1
	
	For nLin := 1 To Len(aRelat)

		If oReport:Cancel()
			Exit
		EndIf

		oReport:IncMeter()
		            
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ 1 - Impressao da conta sintetica          ³
		//³ 2 - Impressao da conta                    ³
		//³ 3 - Impressao do lancamento               ³
		//³ 4 - Impressao do total da conta           ³
		//³ 5 - Impressao do total geral              ³
		//³ 6 - Impressao do complemento de historico ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cTipo := aRelat[nLin,R4_COL_TIPO]
		
		If cTipo $ "12"       
			oReport:SkipLine()
			oReport:PrintText(aRelat[nLin,R4_COL_DATA])
			Loop
		ElseIf cTipo == "3"
			//Somente posiciona se data e numero estiver preenchido
			If aRelat[nLin,R4_COL_DATA] != NIL .And. !Empty(aRelat[nLin,R4_COL_DATA]) .And. ;
			   aRelat[nLin,R4_COL_NUMERO] != NIL .And. !Empty(aRelat[nLin,R4_COL_NUMERO])
				CT2->( dbSeek( xFilial("CT2")+DTOS(aRelat[nLin,R4_COL_DATA])+aRelat[nLin,R4_COL_NUMERO] ) )
			Else
				//se nao posicionar em eof()
				CT2->( DBGoBottom() )
				CT2->( DBSkip() )
			EndIf
			oLancto:PrintLine()
		ElseIf cTipo $ "45"		// Total Conta / Total Geral
			If cTipo == "4"		// Total Conta
				oTotConta:Init()
				oTotConta:PrintLine()
				oTotConta:Finish()
				//Se o proximo registro for o ultimo e do tipo 5 não realiza a quebra
				If lSaltaPg .and. (Len(aRelat) >= nLin+1 .and. aRelat[nLin+1,R4_COL_TIPO] <>"5" ) 	
					oReport:EndPage()
				EndIf
				 
			ElseIf cTipo == "5" .And. lTotGer	// Total Geral
				oTotGeral:Init()
				oTotGeral:PrintLine()
				oTotGeral:Finish()
			EndIf			    
		ElseIf cTipo == "6"		// Complemento de Historico
			oCompl:Init()
			oCompl:PrintLine()
			oCompl:Finish()
		EndIf	
		
		cTipoAnt := cTipo
		
	Next nLin

	oLancto:Finish()

EndIf

// Inicializa PageFooter e OnPageBreak para evitar quebra de pagina desnecessaria
oReport:SetPageFooter(0,{||.T.})
oReport:OnPageBreak({||.T.})

If lImpTermos 							// Impressao dos Termos

	cArqAbert:=GetNewPar("MV_LRAZABE","")
	cArqEncer:=GetNewPar("MV_LRAZENC","")
	
    If Empty(cArqAbert)
		ApMsgAlert(	STR0027 +; //"Devem ser criados os parametros MV_LRAZABE e MV_LRAZENC. "
						STR0028) //"Utilize como base o parametro MV_LDIARAB."
	Endif
Endif

If lImpTermos .And. ! Empty(cArqAbert)	// Impressao dos Termos

	dbSelectArea("SM0")
	aVariaveis:={}

	For i:=1 to FCount()	
		If FieldName(i)=="M0_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R! NN.NNN.NNN/NNNN-99")})
		Else
            If FieldName(i)=="M0_NOME"
                Loop
            EndIf
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next i

	dbSelectArea("SX1")
	dbSeek(Padr( "CTR430", Len( X1_GRUPO ) , ' ' ) + "01")

	Do While SX1->X1_GRUPO == Padr( "CTR430", Len( X1_GRUPO ) , ' ' )
		AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),&(X1_VAR01)})
		dbSkip()
	EndDo

	If !File(cArqAbert)
		aSavSet:=__SetSets()
		cArqAbert:=CFGX024(,"Razão") // Editor de Termos de Livros
		__SetSets(aSavSet)
		Set(24,Set(24),.t.)
	Endif

	If !File(cArqEncer)
		aSavSet:=__SetSets()
		cArqEncer:=CFGX024(,"Razão") // Editor de Termos de Livros
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

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³C430R4Proc³ Autor ³ Gustavo Henrique      ³ Data ³ 15/09/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³ Impressao do Razao                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_C430R4Proc(lEnd,wnRel,cString,aSetOfBook,lCusto,lItem,;     ³±±
±±³           ³          lCLVL,Titulo,nTamLinha,aCtbMoeda)                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ lEnd       - A‡ao do Codeblock                             ³±±
±±³           ³ wnRel      - Nome do Relatorio                             ³±±
±±³           ³ cString    - Mensagem                                      ³±±
±±³           ³ aSetOfBook - Array de configuracao set of book             ³±±
±±³           ³ lCusto     - Imprime Centro de Custo?                      ³±±
±±³           ³ lItem      - Imprime Item Contabil?                        ³±±
±±³           ³ lCLVL      - Imprime Classe de Valor?                      ³±± 
±±³           ³ Titulo     - Titulo do Relatorio                           ³±±
±±³           ³ nTamLinha  - Tamanho da linha a ser impressa               ³±± 
±±³           ³ aCtbMoeda  - Moeda                                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function C430R4Proc(WnRel,cString,aSetOfBook,lCusto,lItem,lCLVL,lAnalitico,Titulo,nTamlinha,;
						aCtbMoeda,nTamCta)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aSaldo		:= {}
Local aSaldoAnt	:= {}
Local aRet			:= {}
Local CbTxt
Local cbcont
Local Cabec1		:= ""
Local Cabec2		:= ""
Local cDescMoeda
Local cMascara1
Local cMascara2
Local cMascara3
Local cMascara4
Local cPicture
Local cSepara1		:= ""
Local cSepara2		:= ""
Local cSepara3		:= ""
Local cSepara4		:= ""
Local cSaldo		:= mv_par07
Local cEntGerIni	:= mv_par02
Local cEntGerFim	:= mv_par03
Local cEmtGerAnt	:= ""
Local dDataAnt		:= CTOD("  /  /  ")
Local cDescConta	:= ""
Local cResCC		:= ""
Local cResItem		:= ""
Local cResCLVL		:= ""
Local cDescSint	:= ""
Local cMoeda		:= mv_par06
Local cContaSint	:= ""
Local cArqTmp
Local cSayCusto	:= CtbSayApro("CTT")
Local cSayItem		:= CtbSayApro("CTD")
Local cSayClVl		:= CtbSayApro("CTH")
Local cNormal 		:= ""
Local cCodPlGer		:= aSetOfBook[5]
Local dDataIni		:= mv_par04
Local dDataFim		:= mv_par05
Local lNoMov		:= Iif(mv_par09==1,.T.,.F.)
Local lSalto		:= Iif(mv_par13==1,.T.,.F.)
Local lFirst		:= .T.
Local lImpLivro		:=.t.
Local lImpTermos	:=.f.
Local nDecimais
Local nTotDeb		:= 0
Local nTotCrd		:= 0
Local nTotGerDeb	:= 0
Local nTotGerCrd	:= 0
Local nPagIni		:= mv_par14
Local nReinicia 	:= mv_par16
Local nPagFim		:= mv_par15
Local nTamConta		:= Len(CriaVar("CT1_CONTA"))
Local nTamItem		:= Len(CriaVar("CTD_ITEM"))
Local nTamCLVL		:= Len(CriaVar("CTH_CLVL"))
Local nTamCC		:= Len(CriaVar("CTT_CUSTO"))
Local nVlrDeb		:= 0
Local nVlrCrd		:= 0
Local nSaldoAnt		:= 0
Local nSaldoAtu		:= 0
Local l1StQb	 	:= .T.
Local lQbPg			:= .F.
Local nBloco		:= 0
Local nBlCount		:= 0
Local i				:= 0
Local lColDbCr 		:= .T. // Disconsider cTipo in ValorCTB function, setting cTipo to empty
Local nTamHist		:= Len(CriaVar("CT2_HIST"))

m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao de Termo / Livro                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case mv_par21==1 ; lImpLivro:=.t. ; lImpTermos:=.f.
	Case mv_par21==2 ; lImpLivro:=.t. ; lImpTermos:=.t.
	Case mv_par21==3 ; lImpLivro:=.f. ; lImpTermos:=.t.
EndCase		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    	:= SPACE(10)
cbcont   	:= 0
li       	:= 1
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
		cMascara2 := RetMasCtb(aSetOfBook[6],@cSepara2)
	EndIf                                                
	// Mascara do Item Contabil
	If Empty(aSetOfBook[7])
		cMascara3 := GetMv("MV_MASCCTD")
	Else
		cMascara3 := RetMasCtb(aSetOfBook[7],@cSepara3)
	EndIf
	// Mascara da Classe de Valor
	If Empty(aSetOfBook[8])
		cMascara4 := GetMv("MV_MASCCTH")
	Else
		cMascara4 := RetMasCtb(aSetOfBook[8],@cSepara4)
	EndIf
EndIf	

cPicture 	:= aSetOfBook[4]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Titulo do Relatorio                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("NewHead")== "U"
	IF lAnalitico
		Titulo	:=	STR0007	//"RAZAO ANALITICO EM "
	Else
		Titulo	:=	STR0008	//"RAZAO SINTETICO EM "
	EndIf
	Titulo += 	cDescMoeda + STR0009 + DTOC(dDataIni) +;	// "DE"
				STR0010 + DTOC(dDataFim) + CtbTitSaldo(mv_par07)	// "ATE"
Else
	Titulo := NewHead
EndIf

If lAnalitico							   	// Relatorio Analitico
	Cabec1 := STR0019					   	// "DATA"
	
	If (!lCusto .And. !lItem .And. !lCLVL)
		If nTamCta <= 20
			If cPaisLoc == "CHI"
				Cabec2:= STR0041
			ElseIf cPaisLoc == "MEX"
				Cabec2:= STR0037
			Else
				Cabec2:= STR0031
			EndIf
		Else 
			If cPaisLoc == "CHI"
				Cabec2:= STR0042
			ElseIf cPaisLoc == "MEX"
				Cabec2:= STR0038
			Else
				Cabec2:= STR0032
			EndIf
	    EndIf
	Else
		If cPaisLoc == "CHI"
			Cabec2:= STR0040
		ElseIf cPaisLoc == "MEX"
			Cabec2:= STR0039
		Else
			Cabec2:= STR0013
		EndIf
		Cabec2 += Upper(cSayCusto) +Space(11)+Upper(cSayItem)+Space(11)+Upper(cSayClVl)+Space(26)
		Cabec2 += Iif (cPaisLoc<>"MEX" ,STR0029,STR0036)
   EndIf
Else                
	lCusto := .F.
	lItem  := .F.
	lCLVL  := .F.
	Cabec1 := Iif (cPaisLoc<>"MEX" ,STR0024,STR0035)						// "DATA					                              					              	 DEBITO               CREDITO          	SALDO ATUAL"
EndIf	

m_pag := mv_par14

If lImpLivro
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta Arquivo Temporario para Impressao   					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsgMeter({|	oMeter, oText, oDlg, lEnd | ;
				U_CTBGerRazG(oMeter,oText,oDlg,lEnd,@cArqTmp,cEntGerIni,cEntGerFim,cMoeda,dDataIni,dDataFim,;
				aSetOfBook,lNoMov,cSaldo,lAnalitico,cCodPlGer,lCusto,lItem,lClVl,.T.)},;
				STR0018,;		// "Criando Arquivo Tempor rio..."
				STR0006)		// "Emissao do Razao"

	dbSelectArea("cArqTmp")
	dbGoTop()
Endif

//Se tiver parametrizado com Plano Gerencial, exibe a mensagem que o Plano Gerencial 
//nao esta disponivel e sai da rotina.
If Select("cArqTmp") > 0 .And. cArqTmp->(RecCount()) == 0
	// Atencao ### "Nao existem dados para os parâmetros especificados."
	Aviso(STR0055,STR0056,{"Ok"})
	dbCloseArea()
	If _oCTBR430 <> Nil
		_oCTBR430:Delete()
		_oCTBR430 := Nil
	Endif
	Return aRet
Endif

Do While lImpLivro .And. !cArqTmp->( Eof() )
	
	// Impressao do Saldo Anterior da Conta
	dbSelectArea("CTS")    
	CTS->(dbSetOrder(2))
	If CTS->(MsSeek(xFilial()+cCodPlGer+cArqTmp->CONTA))
		nSaldoAnt	:= 0 
		
		Do While CTS->(!Eof() .And. xFilial() == CTS->CTS_FILIAL .And. CTS->CTS_CODPLA == cCodPlGer .And. ;
				CTS->CTS_CONTAG == cArqTmp->CONTA)  
				
		    If !Empty(CTS->CTS_CTHINI)
		    	aSaldoAnt := SaldTotCTI(CTS->CTS_CTHINI,CTS->CTS_CTHFIM,CTS->CTS_CTDINI,CTS->CTS_CTDFIM,;
		    							CTS->CTS_CTTINI,CTS->CTS_CTTFIM,CTS->CTS_CT1INI,CTS->CTS_CT1FIM,dDataIni, cMoeda,cSaldo)
				   							
		    ElseIf !Empty(CTS->CTS_CTDINI) 
		       	aSaldoAnt := SaldTotCT4(CTS->CTS_CTDINI,CTS->CTS_CTDFIM, CTS->CTS_CTTINI,CTS->CTS_CTTFIM,;
		       							CTS->CTS_CT1INI,CTS->CTS_CT1FIM,dDataIni, cMoeda,cSaldo)
            
			ElseIf !Empty(CTS->CTS_CTTINI)
				aSaldoAnt	:= SaldtotCT3(CTS->CTS_CTTINI,CTS->CTS_CTTFIM,CTS->CTS_CT1INI,CTS->CTS_CT1FIM,dDataIni, cMoeda,cSaldo)	
		    Else
		    	aSaldoAnt	:= SaldTotCT7(CTS->CTS_CT1INI,CTS->CTS_CT1FIM,dDataIni,cMoeda,cSaldo,.F.)	
 		
	   		Endif
				
			nSaldoAnt	+= aSaldoAnt[6]
			CTS->(dbSkip())
		EndDo
	Endif

	If !lNoMov //Se imprime conta sem movimento
		If nSaldoAnt  == 0 .And. cArqTmp->LANCDEB ==0 .And. cArqTmp->LANCCRD == 0 
			cArqTmp->(dbSkip())
			Loop
		Endif	
	Endif             

	AAdd( aRet, Array(QTD_COL) )

	nSaldoAtu:= 0
	nTotDeb	:= 0
	nTotCrd	:= 0
                              
	// IMPRIME A CONTA
	
	// Conta Sintetica	
	cContaSint := U_Ctr430Sint(cArqTmp->CONTA,@cDescSint,cMoeda,@cDescConta,cCodPlGer)
	
	cNormal := cArqTmp->NORMAL
	
	aRet[li,R4_COL_DATA] := EntidadeCTB(cContaSint,0,0,Len(cContaSint)+Len(cMascara1),.F.,cMascara1,cSepara1,,,,,.F.) +" - " + cDescSint
    aRet[li,R4_COL_TIPO] := "1"	// Conta Sintetica
	aRet[li,R4_COL_VLR_ATRANS	] := nSaldoAtu
	aRet[li,R4_COL_VLR_DTRANS	] := nSaldoAtu
    
    li++
	AAdd( aRet, Array(QTD_COL) )	
	
	//"CONTA - "	          
	aRet[li,R4_COL_DATA] := STR0016 + EntidadeCTB(cArqTmp->CONTA,0,0,nTamConta+len(cMascara1),.F.,cMascara1,cSepara1,,,,,.F.) +"- " + Left(cDescConta,38)
    aRet[li,R4_COL_TIPO] := "2"	// Conta
    
    aRet[li,R4_COL_VLR_SALDO] := ValorCTB(nSaldoAnt,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,.T.,.F.)
	aRet[li,R4_COL_VLR_ATRANS	] := nSaldoAtu
	aRet[li,R4_COL_VLR_DTRANS	] := nSaldoAtu

    li++
		
	nSaldoAtu := nSaldoAnt

	cContaAnt:= cArqTmp->CONTA
	dDataAnt	:= CTOD("  /  /  ")
	
	Do While cArqTmp->(!Eof()) .And. cArqTmp->CONTA == cContaAnt
	
		AAdd( aRet, Array(QTD_COL) )                         
		
		aRet[li,R4_COL_TIPO] := "3"		// Lancamento
		
		// Imprime os lancamentos para a conta                          
		If dDataAnt != cArqTmp->DATAL 
			If (cArqTmp->LANCDEB <> 0 .Or. cArqTmp->LANCCRD <> 0)
				aRet[li,R4_COL_DATA] := cArqTmp->DATAL
			Endif	
			dDataAnt := cArqTmp->DATAL
		Else
			aRet[li,R4_COL_DATA] := dDataAnt
		EndIf
				
		If lAnalitico		//Se for relatorio analitico
			nSaldoAtu 	:= nSaldoAtu - cArqTmp->LANCDEB + cArqTmp->LANCCRD
			nTotDeb		+= cArqTmp->LANCDEB
			nTotCrd		+= cArqTmp->LANCCRD
			nTotGerDeb	+= cArqTmp->LANCDEB
			nTotGerCrd	+= cArqTmp->LANCCRD						
			
			aRet[li,R4_COL_NUMERO]		:= cArqTmp->(LOTE+SUBLOTE+DOC+LINHA)
			aRet[li,R4_COL_HISTORICO]	:= Subs(cArqTmp->HISTORICO,1,nTamHist)
			
			If lCusto
				If mv_par17 == 1 //Imprime Cod. Centro de Custo Normal 
					aRet[li,R4_COL_CENTRO_CUSTO] :=  EntidadeCTB(cArqTmp->CUSTO,0,0,nTamCC+len(cMascara2),.F.,cMascara2,cSepara2,,,,,.F.)
				Else
					CTT->(dbSetOrder(1))
					CTT->(MsSeek(xFilial()+cArqTmp->CUSTO))
					cResCC := CTT->CTT_RES
					aRet[li,R4_COL_CENTRO_CUSTO] :=  EntidadeCTB(cResCC,0,0,nTamCC+len(cMascara2),.F.,cMascara2,cSepara2,,,,,.F.)
				Endif                                                       
			Endif

			If lItem 						//Se imprime item 
				If mv_par18 == 1 //Imprime Codigo Normal Item Contabl
					aRet[li,R4_COL_ITEM_CONTABIL] := EntidadeCTB(cArqTmp->ITEM,0,0,nTamItem+len(cMascara3),.F.,cMascara3,cSepara3,,,,,.F.)
				Else
					CTD->(dbSetOrder(1))
					CTD->(MsSeek(xFilial()+cArqTmp->ITEM))
					cResItem := CTD->CTD_RES
					aRet[li,R4_COL_ITEM_CONTABIL] := EntidadeCTB(cResItem,0,0,nTamItem+len(cMascara3),.F.,cMascara3,cSepara3,,,,,.F.)	
				Endif
			Endif
				
			If lCLVL						//Se imprime classe de valor
				If mv_par19 == 1 //Imprime Cod. Normal Classe de Valor
					aRet[li,R4_COL_CLASSE_VALOR] := EntidadeCTB(cArqTmp->CLVL,0,0,nTamClVl+len(cMascara4),.F.,cMascara4,cSepara4,,,,,.F.)
				Else
					CTH->(dbSetOrder(1))
					CTH->(dbSeek(xFilial()+cArqTmp->CLVL))
					cResClVl := CTH->CTH_RES						
					aRet[li,R4_COL_CLASSE_VALOR] := EntidadeCTB(cResClVl,0,0,nTamClVl+len(cMascara4),.F.,cMascara4,cSepara4,,,,,.F.)
				Endif			
			Endif
			
			aRet[li,R4_COL_VLR_DEBITO	] := ValorCTB(cArqTmp->LANCDEB,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,.T.,.F.,lColDbCr)
			aRet[li,R4_COL_VLR_CREDITO	] := ValorCTB(cArqTmp->LANCCRD,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,.T.,.F.,lColDbCr)
			aRet[li,R4_COL_VLR_SALDO	] := ValorCTB(nSaldoAtu,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,.T.,.F.)
		                   			
			aRet[li,R4_COL_VLR_ATRANS	] := nSaldoAtu
			aRet[li,R4_COL_VLR_DTRANS	] := nSaldoAtu
		
			// Procura pelo complemento de historico
			CT2->(dbSetOrder(10))
			If CT2->(MsSeek(xFilial("CT2")+cArqTMP->(DTOS(DATAL)+LOTE+SUBLOTE+DOC+SEQLAN+EMPORI+FILORI),.F.))
				CT2->(dbSkip())
				If CT2->CT2_DC == "4"
					Do While CT2->(!Eof() .And. CT2->CT2_FILIAL == xFilial() 	.And.;
										CT2->CT2_LOTE == cArqTMP->LOTE 			.And.;
										CT2->CT2_SBLOTE == cArqTMP->SUBLOTE 	.And.;
										CT2->CT2_DOC == cArqTmp->DOC 			.And.;
										CT2->CT2_SEQLAN == cArqTmp->SEQLAN 		.And.;
										CT2->CT2_EMPORI == cArqTmp->EMPORI		.And.;
										CT2->CT2_FILORI == cArqTmp->FILORI		.And.;
										CT2->CT2_DC == "4" 						.And.;
								   		DTOS(CT2->CT2_DATA) == DTOS(cArqTmp->DATAL) )
						li++
						AAdd( aRet, Array(QTD_COL) )
						aRet[li,R4_COL_TIPO]	:= "6"	// Complemento de Historico
						aRet[li,R4_COL_NUMERO]	:= CT2->CT2_LINHA
						aRet[li,R4_COL_HISTORICO]	:= Subs(CT2->CT2_HIST,1,nTamHist)
						aRet[li,R4_COL_VLR_ATRANS	] := nSaldoAtu
						aRet[li,R4_COL_VLR_DTRANS	] := nSaldoAtu
						
						CT2->(dbSkip())
					EndDo	
				EndIf	
			EndIf	
			cArqTmp->(dbSkip())
		Else		// Se for resumido.                               			
			Do While dDataAnt == cArqTmp->DATAL .And. cContaAnt == cArqTmp->CONTA
				nVlrDeb	+= cArqTmp->LANCDEB		                                         
				nVlrCrd	+= cArqTmp->LANCCRD		                                         
				nTotGerDeb	+= cArqTmp->LANCDEB
				nTotGerCrd	+= cArqTmp->LANCCRD			
				cArqTmp->(dbSkip())
			EndDo
			nSaldoAtu	:= nSaldoAtu - nVlrDeb + nVlrCrd
			aRet[li,R4_COL_VLR_DEBITO]		:= ValorCTB(nVlrDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,.T.,.F.,lColDbCr)
			aRet[li,R4_COL_VLR_CREDITO]	:= ValorCTB(nVlrCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,.T.,.F.,lColDbCr)
			aRet[li,R4_COL_VLR_SALDO]		:= ValorCTB(nSaldoAtu,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,.T.,.F.)
			aRet[li,R4_COL_VLR_ATRANS	] 	:= nSaldoAtu
			aRet[li,R4_COL_VLR_DTRANS	] 	:= nSaldoAtu
			
			nTotDeb	+= nVlrDeb
			nTotCrd	+= nVlrCrd         
			nVlrDeb	:= 0
			nVlrCrd	:= 0
		Endif
		li++
	EndDo

	AAdd( aRet, Array(QTD_COL))
	aRet[li,R4_COL_TIPO] := "4"		// Total da Conta
	aRet[li,If(lAnalitico,R4_COL_HISTORICO,R4_COL_DATA)] := STR0020	//"T o t a i s  d a  C o n t a  ==> "

	aRet[li,R4_COL_VLR_DEBITO]		:= ValorCTB(nTotDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,.T.,.F.,lColDbCr)
	aRet[li,R4_COL_VLR_CREDITO]	:= ValorCTB(nTotCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,.T.,.F.,lColDbCr)
	aRet[li,R4_COL_VLR_SALDO]		:= ValorCTB(nSaldoAtu,0,0,TAM_VALOR,nDecimais,.T.,cPicture,cNormal,,,,,,.T.,.F.)
	aRet[li,R4_COL_VLR_ATRANS	] := nSaldoAtu
	aRet[li,R4_COL_VLR_DTRANS	] := nSaldoAtu
	
	li++    
EndDo	 
          
If li != 80 .And. lImpLivro .And. mv_par20 == 1	//Imprime total Geral

	AAdd(aRet,Array(QTD_COL))
	aRet[li,R4_COL_TIPO]	:= "5"	// Total geral
	//"T O T A L  G E R A L  ==> "
	aRet[li,If(lAnalitico,R4_COL_HISTORICO,R4_COL_DATA)] := STR0025

	If lAnalitico .And. (lCusto .Or. lItem .Or. lClVl)
		aRet[li,R4_COL_VLR_DEBITO]  := ValorCTB(nTotGerDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,.T.,.F.,lColDbCr)
		aRet[li,R4_COL_VLR_CREDITO] := ValorCTB(nTotGerCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,.T.,.F.,lColDbCr)
	Else
		aRet[li,R4_COL_VLR_DEBITO]  := ValorCTB(nTotGerDeb,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"1",,,,,,.T.,.F.,lColDbCr)
		aRet[li,R4_COL_VLR_CREDITO] := ValorCTB(nTotGerCrd,0,0,TAM_VALOR,nDecimais,.F.,cPicture,"2",,,,,,.T.,.F.,lColDbCr)
	Endif

Endif

If lImpLivro
	dbSelectArea("cArqTmp")
	Set Filter To
	dbCloseArea()
	If Select("cArqTmp") == 0
		If _oCTBR430 <> Nil
			_oCTBR430:Delete()
			_oCTBR430 := Nil
		Endif
	EndIf	
Endif

dbSelectArea("CTS")
dbSetOrder(1)

dbselectArea("CT2")
dbSetOrder(1)

Return aRet
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbGerRazG³ Autor ³ Simone Mie Sato       ³ Data ³ 28/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Cria Arquivo Temporario para imprimir o Razao Gerenc. Conta ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe   ³U_CtbGerRazG(oMeter,oText,oDlg,lEnd,cArqTmp,cEntGerIni,	   ³±±
±±³			  ³cEntGerFim,cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,	   ³±±
±±³			  ³cSaldo)	       											   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nome do arquivo temporario                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Codigo da Entidade Gerencial Inicial               ³±±
±±³           ³ ExpC3 = Codigo da Entidade Gerencial Final                 ³±±
±±³           ³ ExpC4 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpL2 = Indica se imprime movimento zerado ou nao.         ³±±
±±³           ³ ExpC5 = Tipo de Saldo                                      ³±±
±±³           ³ ExpL3 = Indica se imprime rel. analitico ou resumido       ³±±
±±³           ³ ExpL4 = Indica se imprime c.custo                          ³±±
±±³           ³ ExpL5 = Indica se imprime item                             ³±±
±±³           ³ ExpL6 = Indica se imprime cl.valor                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbGerRazG(oMeter,oText,oDlg,lEnd,cArqTmp,cEntGerIni,cEntGerFim,cMoeda,dDataIni,dDataFim,;
						aSetOfBook,lNoMov,cSaldo,lAnalitico,cCodPlGer,lCusto,lItem,lClVl,lR4)

Local aSaveArea	:= GetArea()
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local aTamCusto	:= TAMSX3("CT3_CUSTO")
Local aTamVal	:= TAMSX3("CT2_VALOR")
Local aCtbMoeda	:= {}
Local aCampos

Local nTamHist	:= Len(CriaVar("CT2_HIST"))
Local nTamItem	:= Len(CriaVar("CTD_ITEM"))
Local nTamCLVL	:= Len(CriaVar("CTH_CLVL"))
Local nDecimais	:= 0               

Local nTamFilial 	:= IIf( lFWCodFil, FWGETTAMFILIAL, TamSx3( "CT2_FILIAL" )[1] )

Default lR4		:= .F.

// Retorna Decimais
aCtbMoeda := CTbMoeda(cMoeda)
nDecimais := aCtbMoeda[5]

aCampos :={	{ "CONTA" 		, "C", aTamConta[1], 0 },;  		// Codigo da Conta
			{ "NORMAL"		, "C", 1            , 0 },;  		// Devedor/Credora
			{ "TIPO"       	, "C", 01			, 0 },;			// Tipo do Registro (Debito/Credito/Continuacao)			
			{ "LANCDEB"		, "N", aTamVal[1]+5, nDecimais },; // Debito
			{ "LANCCRD"		, "N", aTamVal[1]+5	, nDecimais },; // Credito
			{ "SALDOSCR"	, "N", aTamVal[1]+5, nDecimais },; 			// Saldo
			{ "TPSLD"   	, "C", 01, 0 },; 					// Sinal do Saldo Atual => Consulta Razao
			{ "HISTORICO"	, "C", nTamHist   	, 0 },;			// Historico
			{ "CUSTO" 		, "C", aTamCusto[1], 0 },;			// Centro de Custo
			{ "ITEM"		, "C", nTamItem		, 0 },;			// Item Contabil
			{ "CLVL"		, "C", nTamCLVL		, 0 },;			// Classe de Valor
			{ "DATAL"		, "D", 08			, 0 },;			// Data do Lancamento
			{ "LOTE" 		, "C", 06			, 0 },;			// Lote
			{ "SUBLOTE" 	, "C", 03			, 0 },;			// Sub-Lote
			{ "DOC" 		, "C", 06			, 0 },;			// Documento
			{ "LINHA"		, "C", LEN(CT2->CT2_LINHA), 0 },;	// Linha  03
			{ "SEQLAN"		, "C", LEN(CT2->CT2_SEQLAN), 0 },;			// Sequencia do Lancamento  03
			{ "SEQHIST"		, "C", 03			, 0 },;			// Seq do Historico
			{ "EMPORI"		, "C", 02			, 0 },;			// Empresa Original
			{ "FILORI"		, "C", nTamFilial	, 0 },;			// Filial Original
			{ "NOMOV"		, "L", 01			, 0 },;			// Conta Sem Movimento
			{ "FILIAL"		, "C", nTamFilial	, 0 }} 			// Filial do sistema

If _oCTBR430 <> Nil
	_oCTBR430:Delete()
	_oCTBR430 := Nil
Endif

_oCTBR430 := FWTemporaryTable():New( "cArqTmp" )  
_oCTBR430:SetFields(aCampos) 
_oCTBR430:AddIndex("1", {"CONTA","DATAL","LOTE","SUBLOTE","DOC","LINHA","EMPORI","FILORI"})

//------------------
//Criação da tabela temporaria
//------------------
_oCTBR430:Create()

dbSelectArea("cArqTmp")
dbSetOrder(1)

// Monta Arquivo para gerar o Razao
U_CtbRazGer(oMeter,oText,oDlg,lEnd,cEntGerIni,cEntGerFim,cMoeda,dDataIni,dDataFim,;  
		aSetOfBook,lNoMov,cSaldo,lAnalitico,cCodPlGer,lR4)        

RestArea(aSaveArea)

Return cArqTmp
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbRazGer ³ Autor ³ Simone Mie Sato       ³ Data ³ 28/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Realiza a "filtragem" dos registros do Razao                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_CtbRazGer(oMeter,oText,oDlg,lEnd,cEntGerIni,cEntGerFim,	   ³±±
±±³			  ³	cMoeda,dDataIni,dDataFim,aSetOfBook,lNoMov,cSaldo)         ³±±
±±³			  ³	lAnalitico,cCodPlGer)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpO1 = Objeto oMeter                                      ³±±
±±³           ³ ExpO2 = Objeto oText                                       ³±±
±±³           ³ ExpO3 = Objeto oDlg                                        ³±±
±±³           ³ ExpL1 = Acao do Codeblock                                  ³±±
±±³           ³ ExpC1 = Arquivo temporario                                 ³±±
±±³           ³ ExpC2 = Codigo da Entidade Gerencial Inicial               ³±±
±±³           ³ ExpC3 = Codigo da Entidade Gerencial Final                 ³±±
±±³           ³ ExpC4 = Moeda                                              ³±±
±±³           ³ ExpD1 = Data Inicial                                       ³±±
±±³           ³ ExpD2 = Data Final                                         ³±±
±±³           ³ ExpA1 = Matriz aSetOfBook                                  ³±±
±±³           ³ ExpL2 = Indica se imprime movimento zerado ou nao.         ³±±
±±³           ³ ExpC5 = Tipo de Saldo                                      ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbRazGer(oMeter,oText,oDlg,lEnd,cEntGerIni,cEntGerFim,cMoeda,dDataIni,dDataFim,;
				  aSetOfBook,lNoMov,cSaldo,lAnalitico,cCodPlGer,lR4)

Local lNoMovDeb, lNoMovCrd
Local lJaGravou	:= .F.
Local cContaIni	:= "" 
Local cContaFim	:= ""   
Local cContaG	:= ""
Local cOrdemAnt	:= ""
Local cContaAnt	:= ""
Local cNormal	:= ""   
Local tpSaldo   := ""	
Local cFilCT2   := xFilial("CT2")
Local cQuery := ""
Local nCpoCT2 := CT2->(FCount())
Local nX
Local ni
Local aStruCT2
Local cEntid05Ini	:= ""
Local cEntid05Fim	:= Repl("Z",20)
           
Default lR4		:= .F.

If !IsBlind()
	oMeter:nTotal := CT1->(RecCount())
EndIf

dbSelectArea("CTS")
dbSetOrder(2)
MsSeek(xFilial()+cCodPlGer+cEntGerIni,.T.)

While !Eof() .And.  xFilial() == CTS->CTS_FILIAL .And. cCodPlGer == CTS->CTS_CODPLA ;
		     .And. CTS->CTS_CONTAG >= cEntGerIni .And. CTS->CTS_CONTAG <= cEntGerFim
	
	If CTS->CTS_CLASSE == '1'
		dbSkip()
		Loop
	EndIf    
	
   	If cSaldo == '*'
		tpSaldo := CTS->CTS_TPSALD
	Else
		tpSaldo := cSaldo
	Endif
	
	If CTS->CTS_TPSALD == '*'
		tpSaldo := cSaldo
	Endif
	
 	If tpSaldo <> Nil .And. Alltrim( tpSaldo ) <> '*' .And. Alltrim(tpSaldo) <> ''
		If CTS->CTS_TPSALD <> tpSaldo  .and. CTS->CTS_TPSALD <> '*'
			dbSkip()
			Loop
	 	EndIf
	Endif
	
	
	lNoMovDeb := .T.
	lNoMovCrd := .T.
	
	cContaIni := CTS->CTS_CT1INI
	cContaFim := CTS->CTS_CT1FIM
	cContaG	 := CTS->CTS_CONTAG
	cNormal	 := CTS->CTS_NORMAL
	If lIsRedStor
		If ( CTS->( FieldPos( "CTS_E05INI" ) ) > 0  .And. !Empty(CTS->CTS_E05INI) ) .Or. ;
			( CTS->( FieldPos( "CTS_E05FIM" ) ) > 0  .And. !Empty(CTS->CTS_E05FIM)	)
			cEntid05Ini	:= CTS->CTS_E05INI
			cEntid05Fim	:= CTS->CTS_E05FIM
		Else
			cEntid05Ini	:= ""
			cEntid05Fim	:= Repl("Z",20)
		EndIf
	EndIF
	
	If cContaAnt <> cContaG
		lJaGravou := .F.
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Obt‚m os d‚bitos ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("CT2")
	If !lR4
		SetRegua(RecCount())
	EndIf
	
	If ! IfDefTopCTB()  //caso nao TOP continua da mesma forma
		dbSetOrder(2)
		MsSeek(cFilCT2+cContaIni+DTOS(dDataIni),.t.)
		
		While !Eof() .and. CT2->CT2_FILIAL == cFilCT2 .And. ;
			CT2->CT2_DEBITO >= cContaIni .And. CT2->CT2_DEBITO <= cContaFim
			
			If CT2->CT2_MOEDLC <> cMoeda .Or. !(CT2->CT2_DC $ "13").Or. CT2->CT2_TPSALD <> tpSaldo .Or. ;
				(CT2->CT2_DC $ "13" .And. CT2->CT2_VALOR == 0 )
				dbSkip()
				Loop
			EndIf     
			
			If CT2->CT2_DATA < dDataIni .Or. CT2->CT2_DATA > dDataFim
				dbSkip()
				Loop
			EndIf
			
			If __lCusto
				If lIsRedStor
					If (CT2->CT2_CCD < CTS->CTS_CTTINI .or. CT2->CT2_CCD > CTS->CTS_CTTFIM) .and. !(empty(CTS->CTS_CTTINI) .and. empty(CTS->CTS_CTTFIM))
						dbSkip()
						Loop
					EndIf
				Else
					If CT2->CT2_CCD < CTS->CTS_CTTINI .or. CT2->CT2_CCD > CTS->CTS_CTTFIM
						dbSkip()
						Loop
					EndIf
				Endif
			EndIf
			
			If __lItem
				If lIsRedStor
					If (CT2->CT2_ITEMD < CTS->CTS_CTDINI .or. CT2->CT2_ITEMD > CTS->CTS_CTDFIM) .and. !(empty(CTS->CTS_CTDINI) .and. empty(CTS->CTS_CTDFIM))
						dbSkip()
						Loop
					EndIf
				Else
					If CT2->CT2_ITEMD < CTS->CTS_CTDINI .or. CT2->CT2_ITEMD > CTS->CTS_CTDFIM
						dbSkip()
						Loop
					EndIf
				EndIF
			EndIf
			
			If __lClVl
				If lIsRedStor
					If (CT2->CT2_CLVLDB < CTS->CTS_CTHINI .or. CT2->CT2_CLVLDB > CTS->CTS_CTHFIM) .and. !(empty(CTS->CTS_CTHINI) .and. empty(CTS->CTS_CTHFIM))
						dbSkip()
						Loop
					EndIf
				Else
					If CT2->CT2_CLVLDB < CTS->CTS_CTHINI .or. CT2->CT2_CLVLDB > CTS->CTS_CTHFIM
						dbSkip()
						Loop
					EndIf
				EndIF
			EndIf
			If lIsRedStor
				If __lMovEnt05
					If CT2->CT2_EC05DB < cEntid05Ini .or. CT2->CT2_EC05DB > cEntid05Fim
						dbSkip()
						Loop
					EndIf
				Endif
				U_CtbGrvRAZG(cMoeda,tpSaldo,"1",cContaG,cNormal,CTS->CTS_IDENT)
			Else		
				U_CtbGrvRAZG(cMoeda,tpSaldo,"1",cContaG,cNormal)
			EndIF
			lNoMovDeb := .F.
			
			dbSelectArea("CT2")
			dbSetOrder(2)
			If !lR4
				IncRegua()
			EndIf
			dbSkip()
		End
		
	Else
		
		//Query com alias do proprio CT2 para melhoria de performance
		aStruCT2 := CT2->(dbStruct())
		
		cQuery := " SELECT "
		For nX := 1 TO nCpoCT2
			cQuery += CT2->( FieldName(nX) ) + If( nX < nCpoCT2, ", ", " ")	
		Next
		cQuery += " FROM " + RetSqlName("CT2")
		
		cQuery += "       WHERE "
		cQuery += "     CT2_FILIAL = '"+cFilCT2+"' "
		cQuery += " AND CT2_DEBITO >= '"+cContaIni+"' "
		cQuery += " AND CT2_DEBITO <= '"+cContaFim+"' "
		cQuery += " AND CT2_MOEDLC = '"+cMoeda+"' "
		cQuery += " AND CT2_DC IN ('1','3') "
		cQuery += " AND CT2_TPSALD = '"+tpSaldo+"' "
		cQuery += " AND CT2_VALOR != 0 "
		cQuery += " AND CT2_DATA >=   '"+DTOS(dDataIni)+"' "
		cQuery += " AND CT2_DATA <=   '"+DTOS(dDataFim)+"' "
		
		If __lCusto .And. lCusto
			cQuery += " AND CT2_CCD  >=   '"+CTS->CTS_CTTINI+"' "
			cQuery += " AND CT2_CCD  <=   '"+CTS->CTS_CTTFIM+"' "
		EndIf
					
		If __lItem .And. lItem
			cQuery += " AND CT2_ITEMD  >=   '"+CTS->CTS_CTDINI+"' "
			cQuery += " AND CT2_ITEMD  <=   '"+CTS->CTS_CTDFIM+"' "
		EndIf
					
		If __lClVl .and. lCLVL
			cQuery += " AND CT2_CLVLDB  >=   '"+CTS->CTS_CTHINI+"' "
			cQuery += " AND CT2_CLVLDB  <=   '"+CTS->CTS_CTHFIM+"' "
		EndIf
		If lIsRedStor 
			IF __lMovEnt05
				cQuery += " AND CT2_EC05DB  >=   '"+cEntid05Ini+"' "
				cQuery += " AND CT2_EC05DB  <=   '"+cEntid05Fim+"' "
			EndIF
		Endif		
		
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY CT2_FILIAL, CT2_DEBITO, CT2_DATA "
		
		cQuery := ChangeQuery(cQuery)
		
		//fecha CT2 para abrir query com mesmo alias CT2
		dbSelectArea("CT2")
		dbCloseArea() 
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"CT2",.T.,.F.)
		
		For ni := 1 to Len(aStruCT2)
			If aStruCT2[ni,2] != 'C'
				TCSetField("CT2", aStruCT2[ni,1], aStruCT2[ni,2],aStruCT2[ni,3],aStruCT2[ni,4])
			Endif
		Next ni		
		
		dbSelectArea("CT2")
		dbGoTop()
			
		While CT2->( !Eof() )   //laco da query renomeado alias como CT2			
			
			If lIsRedStor
				U_CtbGrvRAZG(cMoeda,tpSaldo,"1",cContaG,cNormal,CTS->CTS_IDENT)
			Else
				U_CtbGrvRAZG(cMoeda,tpSaldo,"1",cContaG,cNormal)
			EndIF
			lNoMovDeb := .F.
					
			If !lR4
				IncRegua()
			EndIf
			
			dbSelectArea("CT2")
			dbSkip()
			
		EndDo
		
		dbSelectArea("CT2")
		dbCloseArea()  //fecha a query com alias CT2
	
		dbSelectArea("CT2") //abre CT2 novamente 
	
	EndIf
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Obt‚m os creditos³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("CT2")
	If !lR4
		SetRegua(RecCount())
	EndIf

	If ! IfDefTopCTB()  //caso nao TOP continua da mesma forma
		dbSetOrder(3)
		dbSeek(cFilCT2+cContaIni+DTOS(dDataIni),.t.)
		
		While !Eof() .and. CT2->CT2_FILIAL == cFilCT2 .And. ;
			CT2->CT2_CREDIT >= cContaIni .And. CT2->CT2_CREDIT <= cContaFim
			
			If CT2->CT2_MOEDLC <> cMoeda .Or. !(CT2->CT2_DC $ "23") .Or. CT2->CT2_TPSALD <> tpSaldo .Or. ;
				(CT2->CT2_DC $ "23" .And. CT2->CT2_VALOR == 0 )
				dbSkip()
				Loop
			EndIf 
			
			If CT2->CT2_DATA < dDataIni .Or. CT2->CT2_DATA > dDataFim
				dbSkip()
				Loop
			EndIf
			
			If __lCusto
				If lIsRedStor
					If (CT2->CT2_CCC < CTS->CTS_CTTINI .or. CT2->CT2_CCC > CTS->CTS_CTTFIM) .and. !(empty(CTS->CTS_CTTINI) .and. empty(CTS->CTS_CTTFIM))
						dbSkip()
						Loop
					EndIf
				Else			
					If CT2->CT2_CCC < CTS->CTS_CTTINI .or. CT2->CT2_CCC > CTS->CTS_CTTFIM
						dbSkip()
						Loop
					EndIf
				EndIF
			EndIf
			
			If __lItem
				If lIsRedStor
					If (CT2->CT2_ITEMC < CTS->CTS_CTDINI .or. CT2->CT2_ITEMC > CTS->CTS_CTDFIM) .and. !(empty(CTS->CTS_CTDINI) .and. empty(CTS->CTS_CTDFIM))
						dbSkip()
						Loop
					EndIf
				Else
					If CT2->CT2_ITEMC < CTS->CTS_CTDINI .or. CT2->CT2_ITEMC > CTS->CTS_CTDFIM
						dbSkip()
						Loop
					EndIf
				EndIF
			EndIf
			
			If __lClVl
				If lIsRedStor
					If (CT2->CT2_CLVLCR < CTS->CTS_CTHINI .or. CT2->CT2_CLVLCR > CTS->CTS_CTHFIM) .and. !(empty(CTS->CTS_CTHINI) .and. empty(CTS->CTS_CTHFIM))
						dbSkip()
						Loop
					EndIf
				Else
					If CT2->CT2_CLVLCR < CTS->CTS_CTHINI .or. CT2->CT2_CLVLCR > CTS->CTS_CTHFIM
						dbSkip()
						Loop
					EndIf
				Endif
			EndIf
			If lIsRedStor
				If __lMovEnt05
					If CT2->CT2_EC05CR < cEntid05Ini .or. CT2->CT2_EC05CR > cEntid05Fim
						dbSkip()
						Loop
					EndIf
				EndIf			
				U_CtbGrvRAZG(cMoeda,tpSaldo,"2",cContaG,cNormal,CTS->CTS_IDENT)
			Else	
				U_CtbGrvRAZG(cMoeda,tpSaldo,"2",cContaG,cNormal)
			EndIF
			
			lNoMovCrd := .F.
			
			dbSelectArea("CT2")
			dbSetOrder(3)
			If !lR4
				IncRegua()
			EndIf
			dbSkip()
		End

	Else
		
		//Query com alias do proprio CT2 para melhoria de performance
		aStruCT2 := CT2->(dbStruct())		
		
		cQuery := " SELECT "
		For nX := 1 TO nCpoCT2
			cQuery += CT2->( FieldName(nX) ) + If( nX < nCpoCT2, ", ", " ")	
		Next
		cQuery += " FROM " + RetSqlName("CT2")
		
		cQuery += "       WHERE "
		cQuery += "     CT2_FILIAL = '"+cFilCT2+"' "
		cQuery += " AND CT2_CREDIT >= '"+cContaIni+"' "
		cQuery += " AND CT2_CREDIT <= '"+cContaFim+"' "
		cQuery += " AND CT2_MOEDLC = '"+cMoeda+"' "
		cQuery += " AND CT2_DC IN ('2','3') "
		cQuery += " AND CT2_TPSALD = '"+tpSaldo+"' "
		cQuery += " AND CT2_VALOR != 0 "
		cQuery += " AND CT2_DATA >=   '"+DTOS(dDataIni)+"' "
		cQuery += " AND CT2_DATA <=   '"+DTOS(dDataFim)+"' "
		
		If __lCusto .And. lCusto
			cQuery += " AND CT2_CCC  >=   '"+CTS->CTS_CTTINI+"' "
			cQuery += " AND CT2_CCC  <=   '"+CTS->CTS_CTTFIM+"' "
		EndIf
					
		If __lItem .And. lItem 
			cQuery += " AND CT2_ITEMC  >=   '"+CTS->CTS_CTDINI+"' "
			cQuery += " AND CT2_ITEMC  <=   '"+CTS->CTS_CTDFIM+"' "
		EndIf
					
		If __lClVl .and. lCLVL
			cQuery += " AND CT2_CLVLCR  >=   '"+CTS->CTS_CTHINI+"' "
			cQuery += " AND CT2_CLVLCR  <=   '"+CTS->CTS_CTHFIM+"' "
		EndIf

		If lIsRedStor 
			If __lMovEnt05
				cQuery += " AND CT2_EC05CR  >=   '"+cEntid05Ini+"' "
				cQuery += " AND CT2_EC05CR  <=   '"+cEntid05Fim+"' "
			Endif
		EndIf
	
		cQuery += " AND D_E_L_E_T_ = ' ' "
		cQuery += " ORDER BY CT2_FILIAL, CT2_CREDIT, CT2_DATA "
		
		cQuery := ChangeQuery(cQuery)
		
		//fecha CT2 para abrir query com mesmo alias CT2
		dbSelectArea("CT2")
		dbCloseArea() 
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"CT2",.T.,.F.)
				
		For ni := 1 to Len(aStruCT2)
			If aStruCT2[ni,2] != 'C'
				TCSetField("CT2", aStruCT2[ni,1], aStruCT2[ni,2],aStruCT2[ni,3],aStruCT2[ni,4])
			Endif
		Next ni		
		
		dbSelectArea("CT2")
		dbGoTop()
			
		While CT2->( !Eof() )   //laco da query renomeado alias como CT2			
			
			If lIsRedStor
				U_CtbGrvRAZG(cMoeda,tpSaldo,"2",cContaG,cNormal,CTS->CTS_IDENT)
			Else
				U_CtbGrvRAZG(cMoeda,tpSaldo,"2",cContaG,cNormal)
			EndIF
			
			lNoMovCrd := .F.
			
			If !lR4
				IncRegua()
			EndIf
			dbSelectArea("CT2")
			dbSkip()

		EndDo
		
		dbSelectArea("CT2")
		dbCloseArea()  //fecha a query com alias CT2
	
		dbSelectArea("CT2") //abre CT2 novamente 
	
	EndIf
		
	// Conta sem movimento
	If lNoMov
		If lNoMovCrd .And. lNoMovDeb .And. !lJaGravou
			lJaGravou	:= .T.
			CtbGrvNoMov(cContaG,dDataIni,"CONTA")
		EndIf
	EndIf
	
	dbSelectArea("CTS")
	cOrdemAnt	:= CTS->CTS_ORDEM
	cContaAnt	:= CTS->CTS_CONTAG
	dbSkip()
End

Return  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³CtbGrvRazG³ Autor ³ Simone Mie Sato       ³ Data ³ 28/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Grava registros no arq temporario - Razao                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_CtbGrvRazG(cMoeda,tpSaldo,cTipo,cNormal) 	               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpC1 = Moeda                                              ³±±
±±³           ³ ExpC2 = Tipo de saldo                                      ³±±
±±³           ³ ExpC3 = Tipo do lancamento                                 ³±±
±±³           ³ ExpC4 = Codigo da Entidade Gerencial                       ³±±
±±³           ³ ExpC5 = Condicao Normal da Entidade Gerencial              ³±±
±±³           ³ ExpC6 = Oper type to be exec in this line: 1 Add, 2 Subt   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CtbGrvRAZG(cMoeda,cSaldo,cTipo,cContaG,cNormal,cIdent)

Local cConta
Local cCusto
Local cItem
Local cCLVL
Local nValor

Default cIdent := "1"

cConta 	:= cContaG

If cTipo == "1"
	cCusto	:= CT2->CT2_CCD
	cItem	:= CT2->CT2_ITEMD
	cCLVL	:= CT2->CT2_CLVLDB
EndIf	
If cTipo == "2"
	cCusto	:= CT2->CT2_CCC
	cItem	:= CT2->CT2_ITEMC
	cCLVL	:= CT2->CT2_CLVLCR
EndIf		           

dbSelectArea("cArqTmp")
dbSetOrder(1)	
RecLock("cArqTmp",.T.)

Replace DATAL		With CT2->CT2_DATA
Replace TIPO		With cTipo
Replace LOTE		With CT2->CT2_LOTE
Replace SUBLOTE		With CT2->CT2_SBLOTE
Replace DOC			With CT2->CT2_DOC
Replace LINHA		With CT2->CT2_LINHA
Replace CONTA		With cConta
Replace CUSTO		With cCusto
Replace ITEM		With cItem
Replace CLVL		With cCLVL
Replace HISTORICO	With CT2->CT2_HIST
Replace EMPORI		With CT2->CT2_EMPORI
Replace FILORI		With CT2->CT2_FILORI
Replace SEQHIST		With CT2->CT2_SEQHIST
Replace SEQLAN		With CT2->CT2_SEQLAN
Replace NORMAL		With cNormal
Replace NOMOV		With .F.							// Conta com movimento
nValor := CT2->CT2_VALOR

If lIsRedStor .and. cIdent == "2"
	nValor := nValor * (-1)
Endif

If cTipo == "1"
	Replace LANCDEB	With LANCDEB + nValor
EndIf	
If cTipo == "2"
	Replace LANCCRD	With LANCCRD + nValor
EndIf	    
If CT2->CT2_DC == "3"
	Replace TIPO	With cTipo
Else
	Replace TIPO 	With CT2->CT2_DC
EndIf		
MsUnlock()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o    ³Ctr430Sint³ Autor ³ Simone Mie Sato	     ³ Data ³ 28/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o ³Imprime entidade gerencial sinettica .                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe    ³U_Ctr430Sint(cConta,cDescSint,cMoeda,cDescConta,cCodRes)      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno    ³Conta Sintetic		                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros ³ ExpC1 = Conta                                              ³±±
±±³           ³ ExpC2 = Descricao da Conta Sintetica                       ³±±
±±³           ³ ExpC3 = Moeda                                              ³±±
±±³           ³ ExpC4 = Descricao da Conta                                 ³±±
±±³           ³ ExpC5 = Codigo do Plano Gerencial                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ctr430Sint(cConta,cDescSint,cMoeda,cDescConta,cCodPlGer)
      
Local aSaveArea := GetArea()
Local nPosCTS					//Guarda a posicao no CT1
Local cContaPai	:= ""
Local cContaSint	:= ""

dbSelectArea("CTS")
dbSetOrder(2)
If MsSeek(xFilial()+cCodPlGer+cConta)
	nPosCTS 	:= Recno()
	cDescConta  := CTS->CTS_DESCCG
	cContaPai	:= CTS->CTS_CTASUP
	If MsSeek(xFilial()+cCodPlGer+cContaPai)
		cContaSint 	:= CTS->CTS_CONTAG
		cDescSint	:= CTS->CTS_DESCCG 
	EndIf	
	dbGoto(nPosCTS)
EndIf	

RestArea(aSaveArea)

Return cContaSint
