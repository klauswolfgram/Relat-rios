/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "pmsr060.ch"
#include "pmsicons.ch"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

//-------------------------RELEASE 4--------------------------------------------//
User Function PMSR060()
Local oReport

Pergunte("PMR060", .F.)

oReport := ReportDef()
oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Construcao Release 4                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()
Local cPerg		:= "PMR060"
Local cDesc1     := STR0001 //"Este relatorio ira imprimir uma relacao dos projetos, sua estrutura e detalhes como data inicial, data final, duracao, etc . conforme os parametros solicitados."
Local cDesc2     := ""
Local cDesc3     := ""
Local oReport
Local oProjeto
Local oEdt
Local oTarefa
Local cTitleDurac
Local nX
Local nTamDura := TamSX3("AF9_HDURAC")[1]
Local nTamQtde := TamSX3("AFC_QUANT")[1]
Local cPict    := PesqPict("AFC","AFC_QUANT")

Local aOrdem  := {}

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

oReport := TReport():New("PMSR060",STR0002, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1)
oReport:SetLandScape()

oProjeto := TRSection():New(oReport, STR0027, { "AF8", "SA1", "AFE"}, aOrdem /*{}*/, .F., .F.)
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
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_CLIENT"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_LOJA"		,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"A1_NOME"		,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_REVISA"	,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_DATAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_HORAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})

oProjeto:SetLeftMargin(5)

//-------------------------------------------------------------
oEdt := TRSection():New(oReport, STR0029, {"AFC"}, aOrdem /*{}*/, .F., .F.)
TRCell():New(oEdt, "AFC_TPEDT"  ,""   ,CRLF+STR0019,/*Picture*/,04/*Tamanho*/,/*lPixel*/,{|| STR0018 }) // "TP."
TRCell():New(oEdt, "AFC_EDT"    ,"AFC",CRLF+STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "Código"
TRCell():New(oEdt, "AFC_DESCRI" ,"AFC",CRLF+STR0021,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "Descrição"
TRCell():New(oEdt, "AFC_UM"     ,"AFC",CRLF+STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") // "UM"
//PREVISTO
TRCell():New(oEdt, "AFC_QUANT"  ,"AFC",STR0017+CRLF+STR0013,cPict,nTamQtde,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") // "Quantidade" "Previsto"
TRCell():New(oEdt, "AFC_HDURAC" ,"AFC",STR0023+CRLF+STR0013,""/*Picture*/,nTamDura/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Duração" "Previsto"
TRCell():New(oEdt, "AFC_START"  ,"AFC",STR0024+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Inic." "Previsto"
TRCell():New(oEdt, "AFC_FINISH" ,"AFC",STR0025+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Final" "Previsto"
TRCell():New(oEdt, "AFC_QUANT1" ,""	   ,"%"+STR0015+CRLF+STR0013,""/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Prog." "Previsto"
//REALIZADO
TRCell():New(oEdt, "AFC_QUANT2"	,""   ,STR0017+CRLF+STR0014,cPict,nTamQtde,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Quantidade" "Realizado"
TRCell():New(oEdt, "AFC_HDURAC1",""   ,STR0023+CRLF+STR0014,""/*Picture*/,nTamDura/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Duração" "Realizado"
TRCell():New(oEdt, "AFC_DTATUI"	,"AFC",STR0024+CRLF+STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Inic." "Realizado"
TRCell():New(oEdt, "AFC_DTATUF"	,"AFC",STR0025+CRLF+STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Final" "Realizado"
TRCell():New(oEdt, "AFC_QUANT3"	,""   ,"%"+STR0016+CRLF+STR0014,""/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Real." "Realizado"

//-------------------------------------------------------------
oTarefa := TRSection():New(oReport, STR0028, { "AF9"}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oTarefa, "AF9_TPTRF"  ,""   ,CRLF+STR0019,/*Picture*/,04/*Tamanho*/,/*lPixel*/,{|| STR0010 }) // "TP."
TRCell():New(oTarefa, "AF9_TAREFA" ,"AF9",CRLF+STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "Código"
TRCell():New(oTarefa, "AF9_DESCRI" ,"AF9",CRLF+STR0021,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) // "Descrição"
TRCell():New(oTarefa, "AF9_UM"     ,"AF9",CRLF+STR0022,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") // "UM"
//PREVISTO
TRCell():New(oTarefa, "AF9_QUANT"	,"AF9",STR0017+CRLF+STR0013,cPict,nTamQtde,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") // "Quantidade"  "Previsto"
TRCell():New(oTarefa, "AF9_HDURAC"	,"AF9",STR0023+CRLF+STR0013,""/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Duração" "Previsto"
TRCell():New(oTarefa, "AF9_START"	,"AF9",STR0024+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Inic." "Previsto"
TRCell():New(oTarefa, "AF9_FINISH"	,"AF9",STR0025+CRLF+STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Final" "Previsto"
TRCell():New(oTarefa, "AF9_QUANT1"	,""   ,"%"+STR0015+CRLF+STR0013,""/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Prog." "Previsto"
//REALIZADO
TRCell():New(oTarefa, "AF9_QUANT2"	,""   ,STR0017+CRLF+STR0014,cPict,nTamQtde,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Quantidade" "Realizado"
TRCell():New(oTarefa, "AF9_HDURAC1"	,""   ,STR0023+CRLF+STR0014,""/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Duração" "Realizado"
TRCell():New(oTarefa, "AF9_DTATUI"	,"AF9",STR0024+CRLF+STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Inic." "Realizado"
TRCell():New(oTarefa, "AF9_DTATUF"	,"AF9",STR0025+CRLF+STR0014,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Dt.Final" "Realizado"
TRCell():New(oTarefa, "AF9_QUANT3"	,""   ,"%"+STR0016+CRLF+STR0014,""/*Picture*/,8/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Real." "Realizado"

oEDT:SetLineBreak( .F. )
oTarefa:SetLineBreak( .F. )

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Carnelossi   º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Construcao Release 4                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport)
Local oProjeto	:= oReport:Section(1)
Local oEdt		:= oReport:Section(2)
Local oTarefa	:= oReport:Section(3)
Local lImpCols := .T.

oReport:SetMeter(AF8->(RecCount()))

oTarefa:SetLinesBefore(0)

MV_PAR07 := If(Empty(MV_PAR07), dDataBase, MV_PAR07)

dbSelectArea("AF8")
dbSeek(xFilial()+MV_PAR01,.T.)
While !Eof() .And. AF8->AF8_PROJET <= MV_PAR02 .AND. !oReport:Cancel()

	If AF8->AF8_DATA > MV_PAR04 .Or. AF8->AF8_DATA < MV_PAR03
		dbSkip()
		Loop
	EndIf

	If !Empty(oProjeto:GetAdvplExp()) .And. !&(oProjeto:GetAdvplExp())
		dbSelectArea("AF8")
		dbSkip()
		Loop
	EndIf

	SA1->(dbSetOrder(1))
	SA1->(dbSeek(xFilial()+AF8->AF8_CLIENT+AF8->AF8_LOJA))
	dbSelectArea("AFE")
	dbSetOrder(1)
	dbSeek(xFilial()+AF8->AF8_PROJET)
	
	oProjeto:Init()
	While !Eof() .And. AFE->AFE_FILIAL+AFE->AFE_PROJET==xFilial()+AF8->AF8_PROJET .AND. !oReport:Cancel()
		
		oReport:IncMeter()

		// verifica as versoes a serem impressas
		// se estiver em branco so imprime a ultima versao. (AF8_REVISA)
		If !PmrPertence(AFE->AFE_REVISA,MV_PAR05).Or.;
			(Empty(MV_PAR05).And.AFE->AFE_REVISA!=AF8->AF8_REVISA)
			dbSkip()
			Loop
		EndIf
		
		oProjeto:PrintLine()
		
		lImpCols := .T.

		oEdt:Init()
		oTarefa:Init()
		
		Pmr060_AFC(oReport, AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET,@lImpCols)

		oTarefa:Finish()
		oEdt:Finish()
		
		dbSelectArea("AFE")
		dbSkip()
	End
	
	// verifica o cancelamento pelo usuario..
	If oReport:Cancel()
		oReport:Say(oReport:Row()+1 ,10 ,STR0030) //"*** CANCELADO PELO OPERADOR ***"
	EndIf
	
	oProjeto:Finish()
	oReport:EndPage()   
	
	dbSelectArea("AF8")
	dbSkip()
	
End

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR060_AFC  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AFC.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR060_AFC()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr060_AFC( oReport, cProjeto, cRevisa, cEDT ,lImpCols)
Local aArea		:= GetArea()
Local aAreaAFC	:= AFC->(GetArea())
Local aAreaAF9	:= AF9->(GetArea())
Local nPercAtu

Local aNodes := {}
Local nNode  := 0
Local oEdt   := oReport:Section(2)

DEFAULT  lImpCols := .T. 

oEDT:SetHeaderSection( lImpCols )

oEdt:Cell("AFC_DESCRI"):SetBlock( {|| Repli(".",Val(AFC->AFC_NIVEL)-1)+Substr(AFC->AFC_DESCRI,1,TamSX3("AFC_DESCRI")[1]-Val(AFC->AFC_NIVEL)-1)} )
oEdt:Cell("AFC_QUANT1"):SetBlock( {|| Transform(PmsPrvAFC(AFC->AFC_PROJET,cRevisa,AFC->AFC_EDT,MV_PAR07)/AFC->AFC_HUTEIS*100,"999.99%") })
oEdt:Cell("AFC_QUANT2"):SetBlock( {|| AFC->AFC_QUANT*nPercAtu/100 } )

oEdt:Cell("AFC_HDURAC"):SetBlock( {|| Transform(AFC->AFC_HDURAC ,"99999.99h") })
oEdt:Cell("AFC_HDURAC1"):SetBlock( {|| Transform(If(!Empty(AFC->AFC_DTATUI) .And. !Empty(AFC->AFC_DTATUF),PmsHrsItvl(AFC->AFC_DTATUI,AFC->AFC_HRATUI,AFC->AFC_DTATUF,AFC->AFC_HRATUF,AFC->AFC_CALEND,AFC->AFC_PROJET),0.00),"99999.99h") })

oEdt:Cell("AFC_QUANT3"):SetBlock( {|| Transform(nPercAtu,"999.99%") } )

oEdt:Cell("AFC_DESCRI"):SetLineBreak( .T. )

dbSelectArea("AFC")
dbSetOrder(1)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)
cProjeto := AFC->AFC_PROJET
cRevisa  := AFC->AFC_REVISA
cEDT     := AFC->AFC_EDT

If PmrPertence(AFC->AFC_NIVEL,MV_PAR06) .And. PmsChkUser(AFC->AFC_PROJET,,AFC->AFC_EDT,AFC->AFC_EDTPAI,1,"ESTRUT",cRevisa)

	nPercAtu := PmsPOCAFC(AFC->AFC_PROJET,cRevisa,AFC->AFC_EDT,MV_PAR07)
	oEdt:PrintLine()
EndIf

If lImpCols
	oEDT:SetHeaderSection( .F. )
	lImpCols := .F.
EndIf

dbSelectArea("AF9")
dbSetOrder(2)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)
While !Eof() .And. xFilial()+cProjeto+cRevisa+cEDT==;
					AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_EDTPAI
	aAdd(aNodes, {PMS_TASK,;
	              AF9->(Recno()),;
	              If(Empty(AF9->AF9_ORDEM), "000", AF9->AF9_ORDEM),;
	              AF9->AF9_TAREFA})
	dbSkip()
End

dbSelectArea("AFC")
dbSetOrder(2)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)
While !Eof() .And. xFilial()+cProjeto+cRevisa+cEDT==;
					AFC->AFC_FILIAL+AFC->AFC_PROJET+AFC->AFC_REVISA+AFC->AFC_EDTPAI
	aAdd(aNodes, {PMS_WBS,;
	              AFC->(Recno()),;
	              If(Empty(AFC->AFC_ORDEM), "000", AFC->AFC_ORDEM),;
	              AFC->AFC_EDT})
	dbSelectArea("AFC")
	dbSkip()
End

aSort(aNodes, , , {|x,y| x[3]+x[4] < y[3]+y[4]})

For nNode := 1 To Len(aNodes)
	If aNodes[nNode][1] == PMS_TASK
		// tarefa
		AF9->(dbGoto(aNodes[nNode][2]))
		
		oReport:IncMeter()
		Pmr060_AF9( oReport, AF9->AF9_PROJET, AF9->AF9_REVISA, AF9->AF9_TAREFA ,@lImpCols)	
	Else
		// EDT
		AFC->(dbGoto(aNodes[nNode][2]))
		
		oReport:IncMeter()
		Pmr060_AFC( oReport, AFC->AFC_PROJET, AFC->AFC_REVISA, AFC->AFC_EDT ,@lImpCols)	
	EndIf
Next

RestArea(aAreaAF9)
RestArea(aAreaAFC)
RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR060_AF9  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF9.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR060_AF9()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr060_AF9( oReport, cProjeto, cRevisa, cTarefa,lImpCols )
Local aArea		:= GetArea()
Local aAreaAF9	:= AF9->(GetArea())
Local nPercAtu
Local oTarefa   := oReport:Section(3)
Local lUsaAJT	:= AF8ComAJT( cProjeto )

DEFAULT lImpCols := .F.

oTarefa:SetHeaderSection( lImpCols )

oTarefa:Cell("AF9_DESCRI"):SetBlock( {|| Repli(".",Val(AF9->AF9_NIVEL)-1)+Substr(AF9->AF9_DESCRI,1,TamSX3("AF9_DESCRI")[1]-Val(AF9->AF9_NIVEL)-1)} )

oTarefa:Cell("AF9_QUANT1"):SetBlock( {|| Transform(PmsPrvAF9(AF9->AF9_PROJET,cRevisa,AF9->AF9_TAREFA,MV_PAR07)/AF9->AF9_HUTEIS*100,"999.99%") })

oTarefa:Cell("AF9_HDURAC"):SetBlock( {|| Transform(AF9->AF9_HDURAC,"99999.99h") })
oTarefa:Cell("AF9_HDURAC1"):SetBlock( {|| Transform(If(!Empty(AF9->AF9_DTATUI) .And. !Empty(AF9->AF9_DTATUF), If(AF9->(FieldPos("AF9_HRATUI"))>0, PmsHrsItvl(AF9->AF9_DTATUI,AF9->AF9_HRATUI,AF9->AF9_DTATUF,AF9->AF9_HRATUF,AF9->AF9_CALEND,AF9->AF9_PROJET), PmsHrsItvl(AF9->AF9_DTATUI,"00:00",AF9->AF9_DTATUF,"24:00",AF9->AF9_CALEND,AF9->AF9_PROJET)) ,0.00),"99999.99h") })

oTarefa:Cell("AF9_QUANT2"):SetBlock( {|| AF9->AF9_QUANT*nPercAtu/100 } )
oTarefa:Cell("AF9_QUANT3"):SetBlock( {|| Transform(nPercAtu,"999.99%") } )

oTarefa:Cell("AF9_DESCRI"):SetLineBreak( .T. )

If PmrPertence(AF9->AF9_NIVEL,MV_PAR06).And.PmsChkUser(AF9->AF9_PROJET,AF9->AF9_TAREFA,,AF9->AF9_EDTPAI,1,"ESTRUT",cRevisa)
	If Pmr060Rec( lUsaAJT )
		
		nPercAtu := PmsPOCAF9(AF9->AF9_PROJET,cRevisa,AF9->AF9_TAREFA,MV_PAR07)
		oTarefa:PrintLine()
		
		If lImpCols
			oTarefa:SetHeaderSection( .F. )
			lImpCols := .F.
		EndIf
		
	Endif
EndIf
	
RestArea(aAreaAF9)
RestArea(aArea)

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR060Rec   ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica o recurso alocado no projeto                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR060Rec()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PMR060Rec( lUsaAJT )
	Local lRet	:= .F.
	Local nLen	:= Len( AllTrim( MV_PAR09 ) )

	If !Empty( MV_PAR08 ) .Or. Upper( AllTrim( MV_PAR09 ) ) <> Replicate( "Z", nLen )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se o projeto usa composicao aux  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lUsaAJT
			DbSelectArea('AFA')
		  	DbSetOrder(5)
		  	DbSeek(xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA+MV_PAR08,.T.)
		  	If AFA_FILIAL+AFA_PROJET+AFA_REVISA+AFA_TAREFA == xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA
				If AFA->AFA_RECURS >= MV_PAR08 .AND. AFA->AFA_RECURS <= MV_PAR09
			  		lRet	:=	.T.
				EndIf
			Endif
		Else
			DbSelecTArea( "AEL" )
			AEL->( DbSetOrder( 1 ) )
			AEL->( DbSeek( xFilial( "AEL" ) + AF9->( AF9_PROJET + AF9_REVISA + AF9_TAREFA ) ) )
			While AEL->( !Eof() ) .AND. AEL->( AEL_FILIAL + AEL_PROJET + AEL_REVISA + AEL_TAREFA ) == xFilial( "AEL" ) + AF9->( AF9_PROJET + AF9_REVISA + AF9_TAREFA )
				DbSelectArea( "AJY" )
				AJY->( DbSetOrder( 1 ) )
				If AJY->( DbSeek( xFilial( "AJY" ) + AEL->( AEL_PROJET + AEL_REVISA + AEL_INSUMO ) ) )
					lRet := AJY->AJY_RECURS >= MV_PAR08 .AND. AJY->AJY_RECURS <= MV_PAR09
					If !lRet
						Exit
					EndIf
				EndIf

				AEL->( DbSkip() )
			End
		EndIf
	Else
		lRet	:=	.T.   	
	Endif
Return lRet