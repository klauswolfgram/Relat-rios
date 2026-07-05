/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "ctbr280.Ch"
#Include "PROTHEUS.Ch"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

//Tradução PTG 20080721

// 17/08/2009 -- Filial com mais de 2 caracteres

//-------------------------------------------------------------------
/*{Protheus.doc} Ctbr280
Rela‡ao de Movimentos Acumulados p/ CC Extra

@author Alvaro Camillo Neto

@version P12
@since   20/02/2014
@return  Nil
@obs
*/
//-------------------------------------------------------------------
User Function CTBR280()

Private cAliasCT1, cAliasCTT
Private Li := 0

If ( !AMIIn(34) )		// Acesso somente pelo SIGACTB
	Return
EndIf

U_CTBR280R4()

//Limpa os arquivos temporários
CTBGerClean()

Return

//-------------------------------------------------------------------
/*{Protheus.doc} CTBR280R4
Funcao do Relatorio para release 4 utilizando obj tReport
Relatorio de alocacao de recursos

@author Alvaro Camillo Neto

@version P12
@since   20/02/2014
@return  Nil
@obs
*/
//-------------------------------------------------------------------
User Function CTBR280R4()

Local aArea		:= GetArea()
Local cPerg  := "CTR280"
Local cMensagem
Local aMeses := {}
Local nMeses := 0
Local aPeriodos
Local nCont

Private bNormal 	:= {|| "" }

If lIsRedStor
	bNormal 	:= {|| (cAliasCT1)->CT1_NORMAL }
Endif


Private aoTotal := {}
Private aoTotal1 := {}
Private nDecim_ := 2
Private cPict_ := ""
Private cNorm_ := ""

Pergunte(cPerg, .T.)

// Localiza o periodo contabil para os calendarios da moeda
aPeriodos := ctbPeriodos(mv_par07, mv_par01, mv_par02, .T., .F.)
If Empty(aPeriodos[1][1])
	cMensagem	:= STR0017
	cMensagem	+= STR0018
    MsgInfo(cMensagem)
	Return
EndIf

For nCont := 1 to len(aPeriodos)
	//Se a Data do periodo eh maior ou igual a data inicial solicitada no relatorio.
	If aPeriodos[nCont][1] >= mv_par01 .And. aPeriodos[nCont][2] <= mv_par02
		AADD(aMeses,{StrZero(nMeses,2),aPeriodos[nCont][1],aPeriodos[nCont][2]})
		nMeses += 1
	Else
		AADD(aMeses,{"  ",ctod("  /  /  "),ctod("  /  /  ")})
	EndIf
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef(aPeriodos, aMeses, nMeses)

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf

oReport:PrintDialog()

RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³04/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(aPeriodos, aMeses, nMeses)

Local oReport
Local oCentroCusto
Local oSaldos
Local nX
Local cPerg := "CTR280"
Local aOrdem := {}
Local oBreak, oTotal
Local aTamConta	:= TAMSX3("CT1_CONTA")
Local cMascara
Local nTamConta		:= 0
Local cSeparador 	:= ""

aSetOfBook := CTBSetOf(mv_par10)

dbSelectArea("CT1")
dbSetOrder(1)

If Empty(aSetOfBook[2])
	cMascara	:= GetMv("MV_MASCARA")	
Else
	cMascara	:= RetMasCtb(aSetOfBook[2],@cSeparador)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascara)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New("CTBR280",OemToAnsi(STR0006), cPerg, ;
			{|oReport| If(!ct040Valid(mv_par10), oReport:CancelPrint(), ReportPrint(aPeriodos, aMeses, nMeses))},;
			STR0001+CRLF+RetTitle("CT3_CUSTO",15)+OemToAnsi(STR0010)+CRLF+OemToAnsi(STR0003) )

oReport:SetLandScape()
oReport:ParamReadOnly()

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
oCentroCusto := TRSection():New(oReport, AllTrim(RetTitle("CTT_CUSTO"))+" x "+AllTrim(RetTitle("CT1_CONTA")), {"CT1"}, aOrdem, .F., .F.)

TRCell():New(oCentroCusto,	"CTT_CUSTO"	,"CTT",/*Titulo*/,/*Picture*/,22,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCentroCusto,	"CTT_DESC01","CTT",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCentroCusto,	"CT1_CONTA"	,"CT1",/*Titulo*/,/*Picture*/,nTamConta/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCentroCusto,	"CT1_DESC01","CT1",/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

oCentroCusto:Cell("CTT_DESC01"):SetCellBreak()
oCentroCusto:Cell("CT1_DESC01"):SetCellBreak()
oCentroCusto:Cell("CTT_DESC01"):SetTitle(STR0020)		//"Desc"
oCentroCusto:Cell("CT1_DESC01"):SetTitle(STR0020)

oCentroCusto:SetLineStyle()

oCentroCusto:SetHeaderSection(.F.)	//Nao imprime o cabeçalho da secao

oBreak:= TRBreak():New(oCentroCusto,{||.T.},"")

oSaldos := TRSection():New(oCentroCusto, STR0021, {"CT1"}, /*aOrdem*/, .F., .F.) //"Valores"

For nX := 1 To Len(aPeriodos)
	TRCell():New(oSaldos,	"VALOR_PER"+StrZero(nX,2),"",STR0022 + Dtoc(aPeriodos[nX][2])/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Ate "
	aAdd(aoTotal, TRFunction():New(oSaldos:Cell("VALOR_PER"+StrZero(nX,2)),"Valor_Periodo_"+StrZero(nX,2) ,"SUM",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{||aSaldos["+StrZero(nX,2)+"][1]}")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))
	aoTotal[Len(aoTotal)]:Disable()
	If lIsRedStor
		aAdd(aoTotal1,TRFunction():New(oSaldos:Cell("VALOR_PER"+StrZero(nX,2)),"Valor_Periodo_"+StrZero(nX,2) ,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| STRTRAN(ValorCTB(aoTotal["+StrZero(nX,2)+"]:GetValue(),,,17,nDecim_,.T.,cPict_,'1',,,,,,,.F.,.F.),'D','') }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))
	Else
		aAdd(aoTotal1,TRFunction():New(oSaldos:Cell("VALOR_PER"+StrZero(nX,2)),"Valor_Periodo_"+StrZero(nX,2) ,"ONPRINT",oBreak,/*cTitle*/,/*cPicture*/,MontaBlock("{|| ValorCTB(aoTotal["+StrZero(nX,2)+"]:GetValue(),,,17,nDecim_,.T.,cPict_,,,,,,,,.F.) }")/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/))
	EndIf
Next

oSaldos:SetLeftMargin(40)
oSaldos:SetLineBreak()
oSaldos:SetHeaderPage()	//Define o cabecalho da secao como padrao

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Paulo Carnelossi      ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³que faz a chamada desta funcao ReportPrint()                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³ExpO1: Objeto TReport                                       ³±±
±±³          ³ExpC2: Alias da tabela de Planilha Orcamentaria (AK1)       ³±±
±±³          ³ExpC3: Alias da tabela de Contas da Planilha (Ak3)          ³±±
±±³          ³ExpC4: Alias da tabela de Revisoes da Planilha (AKE)        ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(aPeriodos, aMeses, nMeses)

Local oCentroCusto:= oReport:Section(1)
Local oSaldos		:= oReport:Section(1):Section(1)
Local cPerg  		:= "CTR280"
Local lImpCC 		:= .T., lImpConta := .T.
Local nDecimais 	:= 2
Local cCtt_Custo
Local aCtbMoeda 	:= {}
Local cMascConta
Local cMascCus
Local cSepConta 	:= ""
Local cSepCus   	:= ""
Local cPicture
Local nX
Local aTotalCC
Local nCol
Local nTotais
Local cCodRes
Local cCodResCC
Local nDigitAte 	:= 0
Local lFirst		:= .T.
Local cMensagem	:= ""
Local nPos			:= 0
Local lComSaldo	:= .F.
Local cString   	:= "CT1"
Local lImprime 	:= .T.
Local nTamConta	:= 0
Local aTamConta	:= TAMSX3("CT1_CONTA")
Private aSaldos
Private cPlanoRef	:= ""
Private cVersao		:= ""

aSetOfBook := CTBSetOf(mv_par10)

cPlanoRef	:= aSetOfBook[11]
cVersao		:= aSetOfBook[12]

//Se utiliza o plano referencial, desconsidera os filtros das entidades dos relatórios.
If !Empty(cPlanoRef) .And. !Empty(cVersao)
	//Se o relatório não possuir conta, o plano referencial e a versão serão desconsiderados.
	//Será considerado cód. config. livros em branco.
	Help("  ",1,"CTBNOPLREF",,STR0028,1,0) //"Plano referencial não disponível nesse relatório. O relatório será processado desconsiderando a configuração de livros."
	cPlanoRef		:= ""
	cVersao			:= ""
	aSetOfBook		:= CTBSetOf("")
Endif

nDecimais 	:= DecimalCTB(aSetOfBook,mv_par07)
nDecim_     := nDecimais

If Empty(aSetOfBook[2])
	cMascConta := GetMv("MV_MASCARA")
	cMascCus	  := GetMv("MV_MASCCUS")
Else
	cMascConta := RetMasCtb(aSetOfBook[2],@cSepConta)
	cMascCus   := RetMasCtb(aSetofBook[6],@cSepCus)
EndIf

//Tratamento para tamnaho da conta + Mascara
nTamConta	:= aTamConta[1] + Len(cMascConta)

cPicture 	:= aSetOfBook[4]
cPict_      := cPicture


//Seta numero de pagina inicial
oReport:SetPageNumber(MV_PAR08)
oReport:SetParam(cPerg)

//	Se nenhuma moeda foi escolhida, sai do programa
aCtbMoeda  	:= CtbMoeda(mv_par07)
If Empty(aCtbMoeda[1])
	Help(" ",1,"NOMOEDA")
	Set Filter To
	oReport:CancelPrint()
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza centro de custo inicial                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("CTT")
dbSetOrder(1)
dbSeek( xFilial("CTT")+mv_par03,.T. )

TRPosition():New(oCentroCusto,"CTT",1,{|| xFilial("CTT") + (cAliasCTT)->CTT_CUSTO})
TRPosition():New(oCentroCusto,"CT1",1,{|| xFilial("CT1") + (cAliasCT1)->CT1_CONTA})

oReport:SetMeter(RecCount())

aTotalCC  := Array(Len(aPeriodos))
oReport:SetTitle(oReport:Title() + " " + aPeriodos[1][3]) // Adiciona o exercicio ao titulo

oReport:SetTitle(oReport:Title() + " ("+ DTOC(mv_par01)+" - "+DTOC(mv_par02) +") ")
If mv_par19 == 2
	oReport:SetTitle(oReport:Title() + " - "+STR0019)
Endif

// Verifica Se existe filtragem Ate o Segmento
If !Empty(mv_par12)
	nDigitAte := CtbRelDig(mv_par12,cMascCus)
EndIf

If !Empty(mv_par13)			//// FILTRA O SEGMENTO Nº
	If Empty(mv_par10)		//// VALIDA SE O CÓDIGO DE CONFIGURAÇÃO DE LIVROS ESTÁ CONFIGURADO
		help("",1,"CTN_CODIGO")
		oReport:CancelPrint()
	Else
		If !Empty(aSetOfBook[5])
			MsgInfo(STR0023+CHR(10)+STR0024,STR0025) //"O plano gerencial ainda não está disponível para este relatório."###"Altere a configuração de livros..."###"Config. de Livros..."
			oReport:CancelPrint()
		Endif
	Endif

	dbSelectArea("CTM")
	dbSetOrder(1)
	If MsSeek(xFilial()+aSetOfBook[7])
		While !Eof() .And. CTM->CTM_FILIAL == xFilial() .And. CTM->CTM_CODIGO == aSetOfBook[7]
			nPos += Val(CTM->CTM_DIGITO)
			If CTM->CTM_SEGMEN == STRZERO(val(mv_par13),2)
				nPos -= Val(CTM->CTM_DIGITO)
				nPos ++
				nDigitos := Val(CTM->CTM_DIGITO)
				Exit
			EndIf
			dbSkip()
		EndDo
	Else
		help("",1,"CTM_CODIGO")
		oReport:CancelPrint()
	EndIf
EndIf


If oReport:lXlsTable
	Alert('Formato de impressão Relatório em Formato de Tabela não suportado neste relatório')
	oReport:CancelPrint()
Return
Endif


oCentroCusto:Cell("CTT_CUSTO"):SetBlock({||		If(mv_par18 == 1 /*Imprime Cod. CC Normal*/, ;
	EntidadeCtb(cCtt_Custo,li,00,15,.f.,cMascCus,cSepCus,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/);
	,;
	/* Imprime codigo reduzido*/;
	EntidadeCtb(cCodResCC,li,00,15,.f.,cMascCus,cSepCus,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/);
	) })

oCentroCusto:Cell("CTT_DESC01"):SetBlock({|| CtbDescMoeda("(cAliasCTT)->CTT_DESC"+MV_PAR07)})

oCentroCusto:Cell("CT1_CONTA"):SetBlock({||		If(mv_par17==1/*Imprime Cod. Conta Normal*/,;
	EntidadeCTB(&("(cAliasCT1)->CT1_CONTA"),++li,00,nTamConta,.F.,cMascConta,cSepConta,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/);
	,;
	EntidadeCTB(cCodRes,++li,00,nTamConta,.F.,cMascConta,cSepConta,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/);
	) })
oCentroCusto:Cell("CT1_DESC01"):SetBlock({|| CtbDescMoeda("(cAliasCT1)->CT1_DESC" + MV_PAR07)})

For nX := 1 TO Len(aPeriodos)
	oSaldos:Cell("VALOR_PER"+StrZero(nX,2)):SetPicture(cPicture)
Next //nX

cAliasCT1 := "CT1"
cAliasCTT := "CTT"

MsAguarde({|| U_CTR280Qry(aMeses,mv_par07,mv_par09,mv_par05,mv_par06,mv_par03,mv_par04,aSetOfBook,mv_par11 == 1,cString,oCentroCusto:GetAdvplExp()/*aReturn[7]*/,.F./*lImpAntLP*/,/*dDataLP*/) }, STR0006 )
cAliasCT1 := "TRBTMP"
cAliasCTT := "TRBTMP"

While (cAliasCTT)->(!Eof()) .And. (cAliasCTT)->CTT_FILIAL==xFilial("CTT") .And. (cAliasCTT)->CTT_CUSTO <= mv_par04

	oReport:IncMeter()
	lImprime := .T.

	// Guarda o centro de custo para ser utilizado na quebra
	cCtt_Custo 	:= (cAliasCTT)->CTT_CUSTO
	cCodResCC	:= (cAliasCTT)->CTT_RES
	lImpCC     	:= .T.
	aFill(aTotalCC,0) 			// Zera o totalizador por periodo

	// ******************** "FILTRAGEM PARA IMPRESSAO" *************************
	//Filtragem ate o Segmento ( antigo nivel do SIGACON)
	If !Empty(mv_par12)
		If Len(Alltrim((cAliasCTT)->CTT_CUSTO)) > nDigitAte
			(cAliasCTT)->(dbSkip())
			Loop
		Endif
	EndIf

	//Caso faca filtragem por segmento de item,verifico se esta dentro
	//da solicitacao feita pelo usuario.
	If !Empty(mv_par13)
		If Empty(mv_par14) .And. Empty(mv_par15) .And. !Empty(mv_par16)
			If  !(Substr((cAliasCTT)->CTT_CUSTO,nPos,nDigitos) $ (mv_par16) )
				(cAliasCTT)->(dbSkip())
				Loop
			EndIf
		Else
			If Substr((cAliasCTT)->CTT_CUSTO,nPos,nDigitos) < Alltrim(mv_par14) .Or. Substr((cAliasCTT)->CTT_CUSTO,nPos,nDigitos) > Alltrim(mv_par15)
				(cAliasCTT)->(dbSkip())
				Loop
			EndIf
		Endif
	EndIf

	//************************* ROTINA DE IMPRESSAO *************************

	oCentroCusto:Init()
	oSaldos:Init()
	// Obtem os saldos do centro de custo
	While !Eof() .And. (cAliasCT1)->CT1_FILIAL == xFilial("CT1") .And. (cAliasCTT)->CTT_CUSTO == cCtt_Custo .And. (cAliasCT1)->CT1_CONTA <= mv_par06
		IF oReport:Cancel()
			Exit
		EndIf

		lImpConta 	:= .T.
		lImprime := lImpCC .OR. lImpConta

		cCt3_Conta  := (cAliasCT1)->CT1_CONTA //CT3->CT3_CONTA
		nCol 	  	:= 1
		aSaldos 	:= {}
		For nX := 1 TO Len(aPeriodos)
			oSaldos:Cell("VALOR_PER"+StrZero(nX,2)):SetValue({|| 0 })
		Next //nX
		nTotais 	:= 0

		//*************************************
		// Força Filtro do relatorio          *
		//           Acacio Egas              *
		//*************************************
		cFilExp := oCentroCusto:GetAdvplExp()
		If !Empty(cFilExp) .and. !(cAliasCT1)->(&(cFilExp))

			(cAliasCT1)->(DbSkip())
			loop
		EndIf

		For nX := 1 To Len(aPeriodos)
			If aPeriodos[nX][1] >= mv_par01 .And. aPeriodos[nX][2] <= mv_par02
				If mv_par19 == 2
					aAdd(aSaldos,{ &("(cAliasCT1)->COLUNA"+alltrim(str(nX)))+nTotais,0,0,0,0,0} )/// ACUMULA MOVIMENTO
				Else
					aAdd(aSaldos,{ &("(cAliasCT1)->COLUNA"+alltrim(str(nX)))        ,0,0,0,0,0} )/// POR PERIODO (SEM ACUMULAR)
				EndIf
				nTotais += &("(cAliasCT1)->COLUNA"+alltrim(str(nX)))
			Else
				Aadd(	aSaldos, {0,0,0,0,0,0})
			Endif
		Next

		lComSaldo	:= .F.
		For nX := 1 To Len(aPeriodos)
			If aSaldos[nX][1]  <> 0
				lComSaldo	:= .T.
				Exit
			EndIf
		Next

		If mv_par11 == 1  .And. !lComSaldo


			If CtbExDtFim("CTT")
				//Se a data de existencia final  da entidade estiver preenchida e a data inicial do
				//relatorio for maior, nao ira imprimir a entidade.
				If !Empty((cAliasCTT)->CTTDTEXSF) .And. (dtos(mv_par01) > DTOS((cAliasCTT)->CTTDTEXSF))
					dbSelectArea(cAliasCT1)
					dbSkip()
					Loop
				EndIf
			EndIf

			If CtbExDtFim("CT1")
				//Se a data de existencia final  da entidade estiver preenchida e a data inicial do
				//relatorio for maior, nao ira imprimir a entidade.
				If !Empty((cAliasCT1)->CT1DTEXSF) .And. (dtos(mv_par01) > DTOS((cAliasCT1)->CT1DTEXSF))
					dbSelectArea(cAliasCT1)
					dbSkip()
					Loop
				EndIf
			EndIf

		EndIf

		// Se imprime saldos zerados ou
		// se nao imprime saldos zerados e houver valor,
		// imprime os saldos
		If mv_par11 == 1 .OR. (mv_par11 == 2 .AND. nTotais != 0)
			For nX := 1 To Len(aSaldos)
				IF oReport:Cancel()
					Exit
				EndIf

				// Imprime o Centro de Custo
				If lImpCC
					oCentroCusto:Cell("CTT_CUSTO"):Show()
					oCentroCusto:Cell("CTT_DESC01"):Show()
					lImpCC := .F.
					lFirst := .F.
				Endif

				// Imprime a Conta
				If lImpConta
					cCodRes := (cAliasCT1)->CT1_RES
					lImpConta := .F.
					oCentroCusto:Cell("CTT_CUSTO"):Show()
					oCentroCusto:Cell("CTT_DESC01"):Show()
					oCentroCusto:Cell("CT1_CONTA"):Show()
					oCentroCusto:Cell("CT1_DESC01"):Show()
				EndIf

				If lImprime
					oCentroCusto:PrintLine()
					//oReport:ThinLine()
				EndIf

				If ! lImpCC
					oCentroCusto:Cell("CTT_CUSTO"):Hide()
					oCentroCusto:Cell("CTT_DESC01"):Hide()
				EndIf

				If ! lImpConta
					oCentroCusto:Cell("CTT_CUSTO"):Hide()
					oCentroCusto:Cell("CTT_DESC01"):Hide()
					oCentroCusto:Cell("CT1_CONTA"):Hide()
					oCentroCusto:Cell("CT1_DESC01"):Hide()
				EndIf

				lImprime := lImpCC .OR. lImpConta
				// Imprime o valor
				//ValorCTB(aSaldos[nX][1],li,48+(nCol++*19),17,nDecimais,.T.,cPicture)
				//aTotalCC[nX] += aSaldos[nX][1]
				If lIsRedStor
					oSaldos:Cell("VALOR_PER"+StrZero(nX,2)):SetValue(ValorCTB(aSaldos[nX][1],li,48+(nCol++*19),17,nDecimais,.T.,cPicture,Eval(bNormal)/*cTipo*/,/*cConta*/,/*lGraf*/,/*oPrint*/,/*cTipoSinal*/,/*cIdentifi*/,/*lPrintZero*/,.F./*lSay*/))
				Else
					oSaldos:Cell("VALOR_PER"+StrZero(nX,2)):SetValue(ValorCTB(aSaldos[nX][1],li,48+(nCol++*19),17,nDecimais,.T.,cPicture,/*cTipo*/,/*cConta*/,/*lGraf*/,/*oPrint*/,/*cTipoSinal*/,/*cIdentifi*/,/*lPrintZero*/,.F./*lSay*/))
				EndIf
			Next
			oSaldos:PrintLine()
		Endif

		// Vai para a proxima conta
		dbSelectArea(cAliasCT1)
		(cAliasCT1)->(DbSkip())
	EndDo

	If !lFirst
		// Quebrou o Centro de Custo
		If !lImpCC
			//oReport:ThinLine()
			oReport:Say(oReport:Row()+10, 10, ;
				OemToAnsi(STR0012)+RetTitle("CTT_CUSTO",7)+": "+;
				If(mv_par18 == 1/*Imprime Cod. CC Normal*/, ;
				EntidadeCtb(cCtt_Custo,li,PCOL(),15,.F.,cMascCus,cSepCus,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/), ;
				EntidadeCtb(cCodResCC,li,PCOL(),15,.F.,cMascCus,cSepCus,/*cAlias*/,/*nOrder*/,/*lGraf*/,/*oPrint*/,.F./*lSay*/)))
		EndIf
	EndIf
	oSaldos:Finish()
	oCentroCusto:Finish()

	//oReport:ThinLine()
Enddo


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CTBR280   ºAutor  ³Marcos S. Lobo      º Data ³  02/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta a query para o relatorio Mov.Acum. CCxContaxMeses     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CTR280Qry(aPeriodos,cMoeda,cTpSaldo,cContaIni,cContaFim,cCustoIni,cCustoFim,aSetOfBook,lVlrZerado,cString,cFILUSU,lImpAntLP,dDataLP)
Local aSaveArea	:= GetArea()
Local cQuery	:= ""
Local nColunas	:= 0
Local aTamVlr	:= TAMSX3("CT2_VALOR")
Local nStr		:= 1
Local l1St 		:= .T.
Local lAbriu	:= .F.

DEFAULT lVlrZerado	:= .F.
DEFAULT lImpAntLP   := .F.
DEFAULT cFilUSU		:= ""
DEFAULT cString		:= "CTT"
DEFAULT aSetOfBook  := {""}

MsProcTxt(STR0026) //"Montando consulta..."

cQuery := " SELECT CT1_FILIAL CT1_FILIAL, CT1_CONTA CT1_CONTA,CT1_NORMAL CT1_NORMAL, CT1_RES CT1_RES, CT1_DESC01 CT1_DESC01, CT1_DESC"+cMoeda+" CT1_DESC"+cMoeda+", "

If CtbExDtFim("CT1")
	cQuery += "CT1_DTEXSF CT1DTEXSF, "
EndIf
cQuery += " 	CT1_CLASSE CT1_CLASSE, CT1_GRUPO CT1_GRUPO, CT1_CTASUP CT1_CTASUP, "
cQuery += " 	CTT_FILIAL CTT_FILIAL, CTT_CUSTO CTT_CUSTO, CTT_DESC01 CTT_DESC01, CTT_DESC"+cMoeda+" CTT_DESC"+cMoeda+", CTT_CLASSE CTT_CLASSE, CTT_RES CTT_RES, CTT_CCSUP CTT_CCSUP, "

If CtbExDtFim("CTT")
	cQuery += "CTT_DTEXSF CTTDTEXSF, "
EndIf

////////////////////////////////////////////////////////////
//// TRATAMENTO PARA O FILTRO DE USUÁRIO NO RELATORIO
////////////////////////////////////////////////////////////
cCampUSU  := ""										//// DECLARA VARIAVEL COM OS CAMPOS DO FILTRO DE USUÁRIO
If !Empty(cFILUSU)									//// SE O FILTRO DE USUÁRIO NAO ESTIVER VAZIO
	aStrSTRU := (cString)->(dbStruct())				//// OBTEM A ESTRUTURA DA TABELA USADA NA FILTRAGEM
	nStruLen := Len(aStrSTRU)
	For nStr := 1 to nStruLen                       //// LE A ESTRUTURA DA TABELA
		cCampUSU += aStrSTRU[nStr][1]+","			//// ADICIONANDO OS CAMPOS PARA FILTRAGEM POSTERIOR
	Next
Endif
cQuery += cCampUSU									//// ADICIONA OS CAMPOS NA QUERY
////////////////////////////////////////////////////////////

For nColunas := 1 to Len(aPeriodos)
	If !Empty(aPeriodos[nColunas][1])
		cQuery += " 	(SELECT SUM(CQ3_CREDIT) - SUM(CQ3_DEBITO) "
		cQuery += "			 	FROM "+RetSqlName("CQ3")+" CQ3 "
		cQuery += " 			WHERE CQ3.CQ3_FILIAL = '"+xFilial("CQ3")+"' "
		cQuery += " 			AND CQ3_MOEDA = '"+cMoeda+"' "
		cQuery += " 			AND CQ3_TPSALD = '"+cTpSaldo+"' "
		cQuery += " 			AND CQ3_CONTA	= ARQ.CT1_CONTA "
		cQuery += " 			AND CQ3_CCUSTO	= ARQ2.CTT_CUSTO "
		If l1St .And. mv_par19 == 2	//	Se for o primeiro periodo e Saldo Acumulado
			cQuery += " 			AND CQ3_DATA <= '"+DTOS(aPeriodos[nColunas][3])+"' "
			l1St := .F.
		Else
			cQuery += " 			AND CQ3_DATA BETWEEN '"+DTOS(aPeriodos[nColunas][2])+"' AND '"+DTOS(aPeriodos[nColunas][3])+"' "
		Endif
		If lImpAntLP .and. dDataLP >= aPeriodos[nColunas][2]
			cQuery += " AND CQ3_LP <> 'Z' "
		Endif
		cQuery += " 			AND CQ3.D_E_L_E_T_ <> '*') COLUNA"+Str(nColunas,Iif(nColunas>9,2,1))+" "
	Else
		cQuery += " 0 COLUNA"+Str(nColunas,Iif(nColunas>9,2,1))+" "
	Endif

	If nColunas <> Len(aPeriodos)
		cQuery += ", "
	EndIf
Next

cQuery += " 	FROM "+RetSqlName("CT1")+" ARQ, "+RetSqlName("CTT")+" ARQ2 "
cQuery += " 	WHERE ARQ.CT1_FILIAL = '"+xFilial("CT1")+"' "
cQuery += " 	AND ARQ.CT1_CONTA BETWEEN '"+cContaIni+"' AND '"+cContaFim+"' "
cQuery += " 	AND ARQ.CT1_CLASSE = '2' "
If !Empty(aSetOfBook[1])										//// SE HOUVER CODIGO DE CONFIGURAÇÃO DE LIVROS
	cQuery += " 	AND ARQ.CT1_BOOK LIKE '%"+aSetOfBook[1]+"%' "    //// FILTRA SOMENTE CONTAS DO MESMO SETOFBOOKS
Endif
cQuery += " 	AND ARQ.D_E_L_E_T_ <> '*' "

cQuery += " 	AND ARQ2.CTT_FILIAL = '"+xFilial("CTT")+"' "
cQuery += " 	AND ARQ2.CTT_CUSTO BETWEEN '"+cCustoIni+"' AND '"+cCustoFim+"' "
cQuery += " 	AND ARQ2.CTT_CLASSE = '2' "
If !Empty(aSetOfBook[1])										//// SE HOUVER CODIGO DE CONFIGURAÇÃO DE LIVROS
	cQuery += " 	AND ARQ2.CTT_BOOK LIKE '%"+aSetOfBook[1]+"%' "    //// FILTRA SOMENTE CONTAS DO MESMO SETOFBOOKS
Endif
cQuery += " 	AND ARQ2.D_E_L_E_T_ <> '*' "

l1St := .T.

If !lVlrZerado
	For nColunas := 1 to Len(aPeriodos)
		If !Empty(aPeriodos[nColunas][1])
			If ! lAbriu
				cQuery += " 	AND ( "
				lAbriu := .T.
			EndIf
			If !l1St
				cQuery += " 	OR "
			EndIf
			cQuery += "	(SELECT SUM(CQ3_CREDIT) - SUM(CQ3_DEBITO) "
			cQuery += " FROM "+RetSqlName("CQ3")+" CQ3 "
			cQuery += " WHERE CQ3.CQ3_FILIAL	= '"+xFilial("CQ3")+"' "
			cQuery += " AND CQ3_MOEDA = '"+cMoeda+"' "
			cQuery += " AND CQ3_TPSALD = '"+cTpSaldo+"' "
			cQuery += " AND CQ3_CONTA	= ARQ.CT1_CONTA "
			cQuery += " AND CQ3_CCUSTO	= ARQ2.CTT_CUSTO "
			If l1St .And. mv_par19 == 2	//	Se for o primeiro periodo e Saldo Acumulado
				cQuery += " AND CQ3_DATA <= '"+DTOS(aPeriodos[nColunas][3])+"' "
			Else
				cQuery += " AND CQ3_DATA BETWEEN '"+DTOS(aPeriodos[nColunas][2])+"' AND '"+DTOS(aPeriodos[nColunas][3])+"' "
			Endif
			l1St := .F.
			If lImpAntLP .and. dDataLP >= aPeriodos[nColunas][2]
				cQuery += " AND CQ3_LP <> 'Z' "
			Endif
			cQuery += " 	AND CQ3.D_E_L_E_T_ <> '*') <> 0 "
		Endif
		If lAbriu .And. nColunas == Len(aPeriodos)
			cQuery += " ) "
		EndIf
	Next
Endif
cQuery += " ORDER BY CTT_CUSTO,CT1_CONTA "

cQuery := ChangeQuery(cQuery)

If Select("TRBTMP") > 0
	dbSelectArea("TRBTMP")
	dbCloseArea()
Endif

MsProcTxt(STR0027) //"Executando consulta..."
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRBTMP",.T.,.F.)
For nColunas := 1 to Len(aPeriodos)
	TcSetField("TRBTMP","COLUNA"+Str(nColunas,Iif(nColunas>9,2,1)),"N",aTamVlr[1],aTamVlr[2])
Next

If CtbExDtFim("CTT")
	TCSetField("TRBTMP","CTTDTEXSF","D",8,0)
EndIf

If CtbExDtFim("CT1")
	TCSetField("TRBTMP","CT1DTEXSF","D",8,0)
EndIf

RestArea(aSaveArea)

Return
