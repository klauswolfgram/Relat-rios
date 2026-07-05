/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "PMSR220.ch"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

//-----------------------------------RELEASE 4--------------------------------//
User Function PMSR220()

If PMSBLKINT()
	Return Nil
EndIf
	U_PMSR220R4()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPMSR220R4 บAutor  ณPaulo Carnelossi    บ Data ณ  16/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescri…o ณImpressao das Receitas do fluxo de caixa do projeto.        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PMSR220R4()
Local aArea := GetArea()

// interface de impressao
oReport := ReportDef()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica as Perguntas Seleciondas                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ PARAMETROS                                                             ณ
//ณ MV_PAR01 : Projeto de ?                                                ณ
//ณ MV_PAR02 : Ate ?                                                       ณ
//ณ MV_PAR03 : Numero de dias                                              ณ
//ณ MV_PAR04 : Data de referencia ?                                        ณ
//ณ MV_PAR05 : Acumular Antecipados ?                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If !Empty(oReport:uParam)
	Pergunte(oReport:uParam,.F.)
EndIf	

oReport:PrintDialog()

RestArea(aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณPaulo Carnelossi    บ Data ณ  16/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ReportDef()
Local cPerg		:= "PMR220"
Local cDesc1   := STR0001 //"Este programa tem como objetivo imprimir o relatorio de receitas do projeto de acordo com os parametros informados pelo usuario."
Local cDesc2   := "" 
Local cDesc3   := ""
Local oReport
Local oProjeto
Local oFluxo
Local aOrdem   := {}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao do componente de impressao                                      ณ
//ณ                                                                        ณ
//ณTReport():New                                                           ณ
//ณExpC1 : Nome do relatorio                                               ณ
//ณExpC2 : Titulo                                                          ณ
//ณExpC3 : Pergunte                                                        ณ
//ณExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ณ
//ณExpC5 : Descricao                                                       ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

oReport := TReport():New("PMSR220",STR0002, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1 )
//STR0002 "Relacao de Receitas do Projeto"
oReport:SetPortrait()

oProjeto := TRSection():New(oReport, STR0012, { "AF8", "SA1" }, aOrdem /*{}*/, .F., .F.)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCriacao da secao utilizada pelo relatorio                               ณ
//ณ                                                                        ณ
//ณTRSection():New                                                         ณ
//ณExpO1 : Objeto TReport que a secao pertence                             ณ
//ณExpC2 : Descricao da se็ao                                              ณ
//ณExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ณ
//ณ        sera considerada como principal para a se็ใo.                   ณ
//ณExpA4 : Array com as Ordens do relat๓rio                                ณ
//ณExpL5 : Carrega campos do SX3 como celulas                              ณ
//ณ        Default : False                                                 ณ
//ณExpL6 : Carrega ordens do Sindex                                        ณ
//ณ        Default : False                                                 ณ
//ณ                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})

oProjeto:SetLineStyle()

//-------------------------------------------------------------
oFluxo := TRSection():New(oReport, STR0013,, /*{aOrdem}*/, .F., .F.)
TRCell():New(oFluxo, "DATA"				,""	,STR0007/*Titulo*/,/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)  //"DATA"
TRCell():New(oFluxo, "VALOR_PREV_PV"	,""	,STR0008/*Titulo*/,"@E 99,999,999,999.99"/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //"Vlr. Prev PV"
TRCell():New(oFluxo, "VALOR_RECEITAS"	,""	,STR0009/*Titulo*/,"@E 99,999,999,999.99"/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //"Vlr. Receitas"
TRCell():New(oFluxo, "RECEITA_DIA"		,""	,STR0010/*Titulo*/,"@E 99,999,999,999.99"/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //"Receitas do Dia"
TRCell():New(oFluxo, "RECEITA_ACUM"		,""	,STR0011/*Titulo*/,"@E 99,999,999,999.99"/*Picture*/,17/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")  //"Receitas Acumuladas"
oFluxo:SetHeaderPage()
oFluxo:SetColSpace(0) 

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor  ณPaulo Carnelossi    บ Data ณ 16/08/06  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)
Local oProjeto  := oReport:Section(1)
Local aArea     := GetArea()
Local aArrayFlx := {}
Local aHandle   := {}
Local aFluxo    := {}
Local nSaldo    := 0
Local nSaldoAcm := 0
Local nSaldoDia := 0
Local dIni      := CTOD("31/12/2050")
Local dFim      := CTOD("01/01/1900")
Local dX
Local nPos      := 0
Local nValAux   := 0
Local aTitAntec := {}
Local nI        := 0
Local nPosDt    := 0
Local nAntecip  := 0
Local lLoop := .T.

If Empty(MV_PAR04) .Or. MV_PAR03 = 0 //Data de referencia // numero de dias
	Aviso(STR0015,STR0016,{"ok"},1 )   //"Aviso!",'As perguntas "Data de Referencia ?" ou o "N๚mero de dias" nใo estใo preenchidas corretamente!'
	Return
EndIf

oReport:SetMeter(AF8->(LastRec()))

dbSelectArea("AF8")
dbSetOrder(1)
dbSeek(xFilial("AF8") + mv_par01,.T.)

While !Eof() .And. xFilial("AF8") == AF8->AF8_FILIAL ;
			 .And. AF8->AF8_PROJET <= mv_par02 .AND. lLoop

	// executa o filtro do usuario
	If !Empty(oProjeto:GetAdvplExp()) .And. !&(oProjeto:GetAdvplExp())
		dbSelectArea("AF8")
		dbSkip()
		Loop
	EndIf                          

	nSaldo    := 0
	nSaldoAcm := 0
	nSaldoDia := 0
	aArrayFlx := {}
	dIni      := MV_PAR04             //Data de referencia
	dFim      := MV_PAR04 + MV_PAR03  //Data de referencia + numero de dias
	nAntecip  := 0

	oReport:IncMeter()

	aHandle := PmsIniFin(AF8->AF8_PROJET,AF8->AF8_REVISA,Padr(AF8->AF8_PROJET,Len(AFC->AFC_EDT)),.T.)
	aFluxo  := PmsRetFinVal(aHandle,4,Padr(AF8->AF8_PROJET,Len(AFC->AFC_EDT)))

	// calcula o saldo da receita antecipada
	For nI := 1 To Len(aFluxo[5])
		If aFluxo[5,nI,3] > 0
			nAntecip += aFluxo[5,nI,3]
			If Mv_par05==2 //Acumular Antecipados
				aAdd(aTitAntec,{aFluxo[5,nI,1], 'RA', aFluxo[5,nI,3] })
			EndIf
		EndIf
	Next nI

	aSort(aFluxo[5],,,{|x,y| x[1]<y[1]} )
	aSort(aTitAntec,,,{|x,y| x[1]<y[1]} )

	nSaldo    := aFluxo[6] - aFluxo[3] // Receita - Despesa
	nSaldoAcm := nSaldo

	For dx := dIni to dFim
		oReport:IncMeter()
		nSaldoDia   := 0
		aAdd(aArrayFlx,{dx,0,0,0,0})

		//titulos a receber
		nPosDt := aScan(aFluxo[5],{|x| x[1]==dx})
		If nPosDt > 0
			aArrayFlx[Len(aArrayFlx)][3] := aFluxo[5][nPosDt][2]

			//Se Acumular Antecipados e o registro do fluxo nao eh antecipado entao
			//a variavel nValAux pega o valor do titulo, abate os valores antecipados e depois totaliza no saldo do dia,saldo acumulado,etc
			If (Mv_par05==2) .And. (aFluxo[5,nPosDt,3]==0)
				nValAux := aFluxo[5,nPosDt,2]
				nPos := aScan(aTitAntec,{|x| x[1]<=aFluxo[5,nPosDt,1] .And. x[2]=='RA' .And. x[3]>0 })

				While (nPos > 0) .And. (nValAux > 0)
					If aTitAntec[nPos,3] >= nValAux
						aTitAntec[nPos,3] -= nValAux
						nValAux := 0
						Loop
					Else
						nValAux -= aTitAntec[nPos,3]
						aTitAntec[nPos,3] := 0
					EndIf
					nPos := aScan(aTitAntec,{|x| x[1]<=aFluxo[5,nPosDt,1] .And. x[2]=='RA' .And. x[3]>0 })
				EndDo
		
				nSaldoDia += nValAux
				nSaldoAcm += nValAux
			Else
				nSaldoDia += aFluxo[5,nPosDt,2]
				nSaldoAcm += aFluxo[5,nPosDt,2]
			EndIf
		EndIf

		//pedidos de venda
		nPosDt := aScan(aFluxo[4],{|x| x[1]==dx})
		If nPosDt > 0
			aArrayFlx[Len(aArrayFlx)][2] := aFluxo[4][nPosDt][2]

			//Se Acumular Antecipados
			//a variavel nValAux pega o valor do titulo, abate os valores antecipados e depois totaliza no saldo do dia,saldo acumulado,etc
			If (Mv_par05==2)
				nValAux := aFluxo[4,nPosDt,2]
				nPos    := aScan(aTitAntec,{|x| x[1]<=aFluxo[4,nPosDt,1] .And. x[2]=='RA' .And. x[3]>0 })
				While (nPos > 0) .And. (nValAux > 0)
					If aTitAntec[nPos,3] >= nValAux
						aTitAntec[nPos,3] -= nValAux
						nValAux := 0
						Loop
					Else
						nValAux -= aTitAntec[nPos,3]
						aTitAntec[nPos,3] := 0
					EndIf
					nPos := aScan(aTitAntec,{|x| x[1]<=aFluxo[4,nPosDt,1] .And. x[2]=='RA' .And. x[3]>0 })
				EndDo

				nSaldoDia += nValAux
				nSaldoAcm += nValAux
			Else
				nSaldoDia += aFluxo[4,nPosDt,2]
				nSaldoAcm += aFluxo[4,nPosDt,2]
			EndIf
		EndIf

		aArrayFlx[Len(aArrayFlx)][4] := nSaldoDia
		aArrayFlx[Len(aArrayFlx)][5] := nSaldoAcm
	
	Next
	
	lLoop := U_Pmr220_Imp(oReport, aArrayFlx , nAntecip)

	dbSelectArea("AF8")
	dbSkip()
	
	oReport:EndPage()

EndDo

RestArea(aArea)

dbSelectArea("AF8")
dbSetOrder(1)
dbClearFilter() //Set Filter to

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPMR220_Imp บAutor  ณPaulo Carnelossi   บ Data ณ  16/08/06   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelease 4                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณnAntecip : total dos titulos a pagar antecipados            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PMR220_Imp( oReport, aArrayFlx , nAntecip )
Local nX       := 0
Local lRet     := .T.
Local oProjeto := oReport:Section(1)
Local oFluxo   := oReport:Section(2)

oFluxo:Cell("DATA")          :SetBlock( {|| aArrayFlx[nx][1] } )
oFluxo:Cell("VALOR_PREV_PV") :SetBlock( {|| aArrayFlx[nx][2] } )
oFluxo:Cell("VALOR_RECEITAS"):SetBlock( {|| aArrayFlx[nx][3] } )
oFluxo:Cell("RECEITA_DIA")   :SetBlock( {|| aArrayFlx[nx][4] } )
oFluxo:Cell("RECEITA_ACUM")  :SetBlock( {|| aArrayFlx[nx][5] } )

oProjeto:Init()
oProjeto:PrintLine()
oProjeto:Finish()

If !(nAntecip==0)
	oReport:PrintText(STR0014+" : "+Transform(nAntecip, "@E 99,999,999,999.99"), oReport:Row(), 10) //"Receitas Antecipadas"
	oReport:SkipLine()
EndIf

oReport:SetMeter(len(aArrayFlx))
oFluxo:Init()
For nx := 1 to Len(aArrayFlx)
	oReport:IncMeter()
	oFluxo:PrintLine()
	
	If oReport:Cancel()
		oReport:SkipLine()
		oReport:PrintText(STR0017) //"*** CANCELADO PELO OPERADOR ***"
		lRet := .F.
		Exit
	EndIf
Next
oFluxo:Finish()

Return lRet