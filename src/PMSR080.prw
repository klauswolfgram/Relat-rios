/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "pmsr080.ch"
#include "pmsicons.ch"
#define CHRCOMP If(aReturn[4]==1,15,18)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PMSR080  ³ Autor ³ Edson Maricate        ³ Data ³ 23.04.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do cronograma financeiro previsto do projeto.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
User Function PmsR080()
Local cPerg := "PMR080"
Local oReport := Nil

Pergunte(cPerg,.F.)
/*
01 - Projeto de            C 10 
02 - Projeto ate           C 10 
03 - Data do projeto de    D 08 
04 - Data do projeto ate   D 08 
05 - Versao                C 04 
06 - Filtrar niveis        C 20 
07 - Data inicial          D 08 
08 - Data final            D 08 
09 - Periodo               N 01 (1=Diário / 2=Semanal / 3-Mensal)
10 - Projecao do valor     C 01 (1=Acumulado / 2=Saldo)
11 - Recurso de            C 15 
12 - Recurso Ate           C 15 
13 - Custo Ajustado        N 01 (1=Não / 2=Database / 3-Final)
*/
oReport := ReportDef()

oReport:PrintDialog()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³29/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oProjeto
Local nX     
Local cObfNCli := IIF(FATPDIsObfuscate("A1_NOME",,.T.),FATPDObfuscate("CUSTOMMER","A1_NOME",,.T.),"")        

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
oReport := TReport():New("PMSR080",STR0002,"PMR080",;	//"Cronograma Financeiro Previsto"
			{|oReport| ReportPrint(oReport)},;
			STR0001)	//"Este relatorio ira imprimir uma relacao dos projetos, sua estrutura e o cronograma financeiro previsto para execucao do projeto."

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
oProjeto := TRSection():New(oReport,STR0006,{"AF8", "SA1", "AFE"}, {}, .F., .F.) //"Projeto"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_PROJET})
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_DESCRI})
TRCell():New(oProjeto,	"AF8_CLIENT"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_CLIENT})
TRCell():New(oProjeto,	"AF8_LOJA"		,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_LOJA})
TRCell():New(oProjeto,	"A1_NOME"		,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF(Empty(cObfNCli),SA1->A1_NOME,cObfNCli)})
TRCell():New(oProjeto,	"AFE_REVISA"	,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE->AFE_REVISA})
TRCell():New(oProjeto,	"AFE_DATAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE->AFE_DATAF})
TRCell():New(oProjeto,	"AFE_HORAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE->AFE_HORAF})

TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})
TRPosition():New(oProjeto, "AFE", 1, {|| xFilial("AFE") + AF8->AF8_PROJET + AF8->AF8_REVISA})

oProjeto:SetHeaderPage()

oEdtTarefa := TRSection():New(oReport, STR0017,, {}, .F., .F.) //"Detalhe"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oEdtTarefa, "AF9_TAREFA", "AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| }*/)
TRCell():New(oEdtTarefa, "AF9_DESCRI", "AF9",/*Titulo*/,/*Picture*/,50/*Tamanho*/,/*lPixel*/,/*{|| }*/)

For nX := 1 TO 6   // 6 colunas periodos
	TRCell():New(oEdtTarefa, "AF9_VALOR"+StrZero(nX,2),, STR0015+" "+Str(nX,1)/*Titulo*/, "@E 999,999,999.99"/*Picture*/, 13/*Tamanho*/, /*lPixel*/, /*{|| }*/,,, "RIGHT") //"Valor"
	TRCell():New(oEdtTarefa, "AF9_PERC"+StrZero(nX,2),,  STR0016+" "+Str(nX,1)/*Titulo*/, "@E 999.99"/*Picture*/,         07/*Tamanho*/, /*lPixel*/, /*{|| }*/,,, "RIGHT") //"Perc."
Next
oEdtTarefa:Cell("AF9_DESCRI"):SetLineBreak()

oReport:SetLandScape()
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Carnelossi   º Data ³  29/05/06   º±±
7±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local dAuxFim
Local dAuxIni
Local aAuxImp	:= {}
Local dStart	:= dDatabase
Local dFinish	:= dDatabase
Local lLoop		:= .T.
Local nValPrj	:= 0
Local cFilAF8	:= xFilial("AF8")
Local cFilSA1	:= xFilial("SA1")
Local cFilAFE	:= xFilial("AFE")

oReport:SetMeter(AF8->(RecCount()))

dbSelectArea("AF8")
dbSeek(cFilAF8+mv_par01,.T.)
While AF8->(! Eof()) .AND. lLoop .AND. AF8->AF8_FILIAL == cFilAF8 .And. AF8->AF8_PROJET <= mv_par02
	If  AF8->AF8_DATA > mv_par04 .Or. AF8->AF8_DATA < mv_par03
		AF8->(dbSkip())
		Loop
	EndIf
	
	oReport:IncMeter()
	
	SA1->(dbSetOrder(1))
	SA1->(dbSeek(cFilSA1+AF8->AF8_CLIENT+AF8->AF8_LOJA))
	dbSelectArea("AFE")
	dbSetOrder(1)
	dbSeek(cFilAFE+AF8->AF8_PROJET)
	While AFE->(! Eof()) .AND. lLoop .And. AFE->AFE_FILIAL == cFilAFE .AND. AFE->AFE_PROJET == AF8->AF8_PROJET
		// se a data de início for vazia ou anterior a
		// data de início prevista do projeto,
		// considerar a data de início prevista do
		// projeto
		If Empty(mv_par07) .Or. (!Empty(mv_par07) .And. mv_par07 < AF8->AF8_START)
			dStart := AF8->AF8_START
		Else
			dStart := mv_par07
		EndIf

		// se a data de fim for vazia ou posterior a
		// data de fim prevista do projeto,
		// considerar a data de fim prevista do
		// projeto
		If Empty(mv_par08) .Or. (!Empty(mv_par08) .And. mv_par08 > AF8->AF8_FINISH)
			dFinish := AF8->AF8_FINISH
		Else
			dFinish := mv_par08
		EndIf
		aAuxImp  := {}
		dAuxFim	 := Nil
		Do Case
			Case mv_par09==1
				dAuxIni := dStart
			Case mv_par09==2
				dAuxIni := dStart
				If DOW(dAuxIni)<>1
					dAuxIni -= DOW(dAuxIni)-1
				EndIf
			Case mv_par09==3
				dAuxIni := CTOD("01/"+StrZero(MONTH(dStart),2,0)+"/"+StrZero(YEAR(dStart),4,0))-1
		EndCase

		// verifica as versoes a serem impressas
		// se estiver em branco so imprime a ultima versao. (AF8_REVISA)
		If !PmrPertence(AFE->AFE_REVISA,mv_par05) .Or.;
			(Empty(mv_par05) .And. AFE->AFE_REVISA != AF8->AF8_REVISA)
			AFE->(DbSkip())
			Loop
		EndIf
		aHandle	:= PmsIniCOTP(AF8->AF8_PROJET,AFE->AFE_REVISA, PMS_MAX_DATE)
		nValPrj	:= PmsRetCOTP(aHandle,2,Padr(AF8->AF8_PROJET,Len(AFC->AFC_EDT)))[1]
		Pmr080_AFC(AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET,aAuxImp,4)
		While dAuxFim == Nil .Or. dAuxFim < dFinish
			Do Case 
				Case mv_par09 == 1
					dAuxFim := dAuxIni+5
				Case mv_par09==2
					dAuxFim := dAuxIni+(5*7)
				Case mv_par09==3
					dAuxFim := dAuxIni+(5*31)
					dAuxFim := CTOD("01/"+StrZero(MONTH(dAuxFim),2,0)+"/"+StrZero(YEAR(dAuxFim),4,0))-1
			EndCase
			dx := dAuxIni
			While dx <= dAuxFim
				aHandle	:= PmsIniCOTP(AF8->AF8_PROJET,AFE->AFE_REVISA,dx)
				Pmr080_AFC(AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET,aAuxImp,2)
				Do Case
					Case mv_par09 == 1
						dx++
					Case mv_par09==2
						dx+= 7
					Case mv_par09==3
						dx+= 35
						dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
				EndCase
			EndDo
			dAuxIni := dx
		EndDo
		
		lLoop := U_Pmr080_Imp(@oReport,aAuxImp,dStart,dFinish)

		dbSelectArea("AFE")
		AFE->(DbSkip())
	EndDo

	dbSelectArea("AF8")  
	AF8->(DbSkip())

EndDo
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR080_AFC  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AFC.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR080AFC()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr080_AFC(cProjeto,cRevisa,cEDT,aAuxImp,nPosArray)

Local aArea    := {} 
Local aArea2   := {} 
Local x        := 0
Local aNodes := {}
Local nNode  := 0
Local cQuery := ""
Local cAlias := ""

Aadd( aArea, AFC->( GetArea() ) )
Aadd( aArea, AF9->( GetArea() ) )
Aadd( aArea, GetArea() ) 
aArea2 := GetArea()

dbSelectArea("AFC")
dbSetOrder(1)
dbSeek(xFilial("AFC")+cProjeto+cRevisa+cEDT)
cProjeto	:= AFC->AFC_PROJET
cRevisa		:= AFC->AFC_REVISA
cEDT		:= AFC->AFC_EDT

If PmrPertence(AFC->AFC_NIVEL,mv_par06).And. PmsChkUser(AFC->AFC_PROJET,,AFC->AFC_EDT,AFC->AFC_EDTPAI,1,"ESTRUT",cRevisa)
	nPosAux := aScan(aAuxImp,{|x|x[1]=="AFC" .And. x[2]==AFC->(REcNo()) })
	If nPosAux <= 0
		aAdd(aAuxImp,{"AFC",AFC->(RecNo()),{},Nil,.T.,0})
		nPosAux := Len(aAuxImp)
	EndIf

	nVal	:= PmsRetCOTP(aHandle,2,AFC->AFC_EDT)[1]
	If nPosArray==4
		aAuxImp[nPosAux][4] := nVal	
	Else
		aAdd(aAuxImp[nPosAux][3],{dx,nVal})
	EndIf
EndIf

cAlias := "AF9"
dbSelectArea(cAlias)
dbSetOrder(2)
cAlias := "QRYAF9"
cQuery := "SELECT R_E_C_N_O_, AF9.AF9_ORDEM, AF9.AF9_TAREFA "
cQuery += "FROM " + RetSqlName("AF9") + " AF9 "
cQuery += "WHERE "
cQuery += "AF9.AF9_FILIAL = '" + xFilial("AF9") + "' AND "
cQuery += "AF9.AF9_PROJET = '" + cProjeto + "' AND "
cQuery += "AF9.AF9_REVISA = '" + cRevisa + "' AND "
cQuery += "AF9.AF9_EDTPAI = '" + cEDT + "' AND "
cQuery += "D_E_L_E_T_ = ' '"
cQuery += "ORDER BY "+SqlOrder(AF9->(IndexKey()))
cQuery := ChangeQuery(cQuery)
dBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAlias,.F.,.T.)
dbSelectArea(cAlias)
While (cAlias)->(!Eof())
	aAdd(aNodes, {PMS_TASK, (cAlias)->R_E_C_N_O_,;
	              If(Empty((cAlias)->AF9_ORDEM), "000", (cAlias)->AF9_ORDEM),;
	              (cAlias)->AF9_TAREFA})
	(cAlias)->(dbSkip())
End
dbCloseArea()

cAlias := "AFC"
dbSelectArea(cAlias)
dbSetOrder(2)
cAlias := "QRYAFC"
cQuery := "SELECT R_E_C_N_O_, AFC.AFC_ORDEM, AFC.AFC_EDT "
cQuery += "FROM " + RetSqlName("AFC") + " AFC "
cQuery += "WHERE "
cQuery += "AFC.AFC_FILIAL = '" + xFilial("AFC") + "' AND "
cQuery += "AFC.AFC_PROJET = '" + cProjeto + "' AND "
cQuery += "AFC.AFC_REVISA = '" + cRevisa + "' AND "
cQuery += "AFC.AFC_EDTPAI = '" + cEDT + "' AND "
cQuery += "D_E_L_E_T_ = ' '"
cQuery += "ORDER BY "+SqlOrder(AFC->(IndexKey()))
cQuery := ChangeQuery(cQuery)
dBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),cAlias,.F.,.T.)
dbSelectArea(cAlias)
While (cAlias)->(!Eof())
	aAdd(aNodes, {PMS_WBS, (cAlias)->R_E_C_N_O_,;
	              If(Empty((cAlias)->AFC_ORDEM), "000", (cAlias)->AFC_ORDEM),;
	              (cAlias)->AFC_EDT})
	(cAlias)->(dbSkip())
End
dbCloseArea()

RestArea(aArea2)

aSort(aNodes, , , {|x, y| x[3]+x[4] < y[3]+y[4]})

For nNode := 1 To Len(aNodes)
	If aNodes[nNode][1] == PMS_TASK
		// tarefa
		AF9->(dbGoto(aNodes[nNode][2]))
		Pmr080_AF9(AF9->AF9_PROJET, AF9->AF9_REVISA, AF9->AF9_TAREFA, aAuxImp, nPosArray)
	Else
		// EDT
		AFC->(dbGoto(aNodes[nNode][2]))
		Pmr080_AFC(AFC->AFC_PROJET, AFC->AFC_REVISA, AFC->AFC_EDT, aAuxImp, nPosArray)	
	EndIf
Next

For x := 1 to Len(aArea)
	RestArea(aArea[x])
Next
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR080_AF9   ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF9.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR080_AF9()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr080_AF9(cProjeto,cRevisa,cTarefa,aAuxImp,nPosArray)
Local aArea		:= {}
Local x			:= 0

Aadd( aArea, AF9->( GetArea() ) )
Aadd( aArea, GetArea() )

dbSelectArea("AF9")
If PmrPertence(AF9->AF9_NIVEL,mv_par06).And.PmsChkUser(AF9->AF9_PROJET,AF9->AF9_TAREFA,,AF9->AF9_EDTPAI,1,"ESTRUT",cRevisa)
	If PMR080Rec()
		nPosAux := aScan(aAuxImp,{|x|x[1]=="AF9" .And. x[2]==AF9->(REcNo()) })
		If nPosAux <= 0
			aAdd(aAuxImp,{"AF9",AF9->(RecNo()),{},Nil,.T.,0})
			nPosAux := Len(aAuxImp)
		EndIf
		nVal := PmsRetCOTP(aHandle,1,AF9->AF9_TAREFA)[1]
		If nPosArray==4
			aAuxImp[nPosAux][4] := nVal	
		Else
			aAdd(aAuxImp[nPosAux][3],{dx,nVal})
		EndIf
	Endif	
EndIf

For x := 1 to Len(aArea)
	RestArea(aArea[x])
Next
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMRSR080    ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_Pmr080_Imp()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pmr080_Imp(oReport, aAuxImp, dStart, dFinish)

Local oProjeto := oReport:Section(1)
Local oEdtTarefa := oReport:Section(2)
Local dAuxFim
Local dAuxIni
Local dCabFim
Local nX		:= 0
Local aDtCabec  := {}                       
Local lRet := .T.

oReport:OnPageBreak({||oProjeto:PrintLine(), oReport:ThinLine()})

oProjeto:Init()

Do Case
	Case mv_par09==1
		dAuxIni := dStart
	Case mv_par09==2
		dAuxIni := dStart
		If DOW(dAuxIni)<>1
			dAuxIni -= DOW(dAuxIni)-1
		EndIf
	Case mv_par09==3
		dAuxIni := CTOD("01/"+StrZero(MONTH(dStart),2,0)+"/"+StrZero(YEAR(dStart),4,0))-1
EndCase
dCabIni := dAuxIni

Do Case 
	Case mv_par09 == 1
		dCabFim := dCabIni+5
	Case mv_par09==2
		dCabFim := dCabIni+(5*7)
	Case mv_par09==3
		dCabFim := dCabIni+(5*31)
		dCabFim := CTOD("01/"+StrZero(MONTH(dCabFim),2,0)+"/"+StrZero(YEAR(dCabFim),4,0))-1
EndCase

dx := dCabIni
While dx <= dCabFim
	aAdd(aDtCabec, DTOC(dx))
	Do Case
		Case mv_par09 == 1
			dx++
		Case mv_par09==2
			dx+= 7
		Case mv_par09==3
			dx+= 35
			dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
	EndCase
End

For nX := 1 TO 6 // 6 COLUNAS DE PERIODOS
	If Len(aDtCabec) >= nX
		oEdtTarefa:Cell("AF9_VALOR"+StrZero(nX,2)):SetTitle(aDtCabec[nX]+CRLF+STR0015) //"Valor"
	Else	
		oEdtTarefa:Cell("AF9_VALOR"+StrZero(nX,2)):SetTitle(CRLF+STR0015) //"Valor"
	EndIf
	oEdtTarefa:Cell("AF9_PERC"+StrZero(nX,2)):SetTitle(CRLF+STR0016) //"Perc."
Next

While (dAuxFim==Nil .Or. dAuxFim < dFinish) .AND. !oReport:Cancel()
	Do Case 
		Case mv_par09 == 1
			dAuxFim := dAuxIni+5
		Case mv_par09==2
			dAuxFim := dAuxIni+(5*7)
		Case mv_par09==3
			dAuxFim := dAuxIni+(5*31)
			dAuxFim := CTOD("01/"+StrZero(MONTH(dAuxFim),2,0)+"/"+StrZero(YEAR(dAuxFim),4,0))-1
	EndCase

	oEdtTarefa:Init()

	For nx := 1 to Len(aAuxImp)
	
		If aAuxImp[nx][1]=="AFC"
			AFC->(dbGoto(aAuxImp[nx,2]))
		Else
			AF9->(dbGoto(aAuxImp[nx,2]))  
		EndIf
	
		oEdtTarefa:Cell("AF9_TAREFA"):SetValue(Eval({||If(aAuxImp[nx][1]=="AFC", ;
													AFC->AFC_EDT, AF9->AF9_TAREFA)}))
		oEdtTarefa:Cell("AF9_DESCRI"):SetValue(Eval({||If(aAuxImp[nx][1]=="AFC", ;
														  Repli(".",Val(AFC->AFC_NIVEL)-1)+AFC->AFC_DESCRI, ;
													      Repli(".",Val(AF9->AF9_NIVEL)-1)+AF9->AF9_DESCRI)}))
		nColuna := 0
		dx := dAuxIni
		While dx <= dAuxFim
			If !Empty(aAuxImp[nx,3])
				nPos := aScan(aAuxImp[nx][3],{|x|x[1]==dx})
				If nPos > 0 .And. aAuxImp[nx,5]
					oEdtTarefa:Cell("AF9_VALOR"+StrZero(nColuna+1,2)):SetValue(Eval({||If(mv_par10==1,aAuxImp[nx,3,npos,2],aAuxImp[nx,3,npos,2]-aAuxImp[nx,6])}))
					oEdtTarefa:Cell("AF9_PERC"+StrZero(nColuna+1,2)):SetValue(Eval({||If(mv_par10==1,aAuxImp[nx,3,npos,2],aAuxImp[nx,3,npos,2]-aAuxImp[nx,6])/aAuxImp[nx,4]*100}))
					aAuxImp[nx][6] := aAuxImp[nx,3,npos,2]
					If (aAuxImp[nx,3,npos,2]/aAuxImp[nx,4]*100) >= 100
						aAuxImp[nx,5] := .F.
					EndIf
				Else
					oEdtTarefa:Cell("AF9_VALOR"+StrZero(nColuna+1,2)):SetValue(0)//Block({||0})
					oEdtTarefa:Cell("AF9_PERC"+StrZero(nColuna+1,2)):SetValue(0)//Block({||0})
				EndIf
			EndIf
			Do Case
				Case mv_par09 == 1
					dx++
				Case mv_par09==2
					dx+= 7
				Case mv_par09==3
					dx+= 35
					dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
			EndCase
			nColuna++
		End
		
		oEdtTarefa:PrintLine()
		
	Next
    
    oEdtTarefa:Finish()
    
	dAuxIni := dx
	dCabIni := dx
	Do Case 
		Case mv_par09 == 1
			dCabFim := dCabIni+5
		Case mv_par09==2
			dCabFim := dCabIni+(5*7)
		Case mv_par09==3
			dCabFim := dCabIni+(5*31)
			dCabFim := CTOD("01/"+StrZero(MONTH(dCabFim),2,0)+"/"+StrZero(YEAR(dCabFim),4,0))-1
	EndCase
	dx := dCabIni
	aDtCabec := {}
	While dx <= dCabFim
		aAdd(aDtCabec, DTOC(dx))
		Do Case
			Case mv_par09 == 1
				dx++
			Case mv_par09==2
				dx+= 7
			Case mv_par09==3
				dx+= 35
				dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
		EndCase
	End

	For nX := 1 TO 6 // 6 COLUNAS DE PERIODOS
		If Len(aDtCabec) >= nX
			oEdtTarefa:Cell("AF9_VALOR"+StrZero(nX,2)):SetTitle(aDtCabec[nX]+CRLF+STR0015) //"Valor"
		Else	
			oEdtTarefa:Cell("AF9_VALOR"+StrZero(nX,2)):SetTitle(CRLF+STR0015) //"Valor"
		EndIf
		oEdtTarefa:Cell("AF9_PERC"+StrZero(nX,2)):SetTitle(CRLF+STR0016) //"Perc."
	Next
End

// verifica o cancelamento pelo usuario..
If oReport:Cancel()	
	oReport:SkipLine()
	oReport:PrintText(STR0018) //"*** CANCELADO PELO OPERADOR ***"
	lRet := .F.
EndIf

oProjeto:Finish()

oReport:EndPage()

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMSR080     ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR080Rec()                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PMR080Rec()
Local lRet		:=	.F. 
If !Empty(mv_par11) .Or. mv_par12 <> Replicate('z',TamSx3('AFA_RECURS')[1])
	DbSelectArea('AFA')
  	DbSetOrder(5)
  	DbSeek(xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA+mv_par11,.T.)
  	If AFA_FILIAL+AFA_PROJET+AFA_REVISA+AFA_TAREFA == xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA .And. AFA_RECURS <= mv_par12   
  		lRet	:=	.T.
	Endif
Else
	lRet	:=	.T.   	
Endif
Return lRet

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDIsObfuscate
    @description
    Verifica se um campo deve ser ofuscado, esta função deve utilizada somente após 
    a inicialização das variaveis atravez da função FATPDLoad.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cField, Caractere, Campo que sera validado
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado
    @return lObfuscate, Lógico, Retorna se o campo será ofuscado.
    @example FATPDIsObfuscate("A1_CGC",Nil,.T.)
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDIsObfuscate(cField, cSource, lLoad)
    
	Local lObfuscate := .F.

    If FATPDActive()
		lObfuscate := FTPDIsObfuscate(cField, cSource, lLoad)
    EndIf 

Return lObfuscate

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
