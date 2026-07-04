/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "pmsr100.ch"
#include "pmsicons.ch"

//--------------------------RELEASE 4-------------------------------------------//
User Function PMSR100()
Local oReport := Nil

If !PMSBLKINT()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica as Perguntas Seleciondas                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("PMR100",.F.)  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                       
	oReport := ReportDef()  
	oReport:PrintDialog()
EndIf  

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Carnelossi       ³ Data ³21/06/2006³±±
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
Static Function ReportDef()

Local oReport
Local oProjeto
Local oEdt
Local oTarefa

Local aOrdem := {}

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
oReport := TReport():New("PMSR100",STR0012,"PMR100", ;
			{|oReport| ReportPrint(oReport)},;
			STR0011 )

//STR0011 //"Este relatorio ira imprimir uma relacao dos projetos, sua estrutura e detalhes das tarefas que se encontram em atraso conforme os parametros solicitados."
//STR0012 //"Tarefas em Atraso"

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
//adiciona ordens do relatorio

oProjeto := TRSection():New(oReport,STR0024,{"AF8", "SA1", "AFE"}, aOrdem /*{}*/, .F., .F.)

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
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_PROJET })
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_DESCRI })
TRCell():New(oProjeto,	"AF8_CLIENT"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_CLIENT })
TRCell():New(oProjeto,	"AF8_LOJA"		,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF8->AF8_LOJA })
TRCell():New(oProjeto,	"A1_NOME"		,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| FATPDObfuscate(SA1->A1_NOME,"A1_NOME",Nil,.T.)})
TRCell():New(oProjeto,	"AFE_REVISA"	,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE_REVISA })
TRCell():New(oProjeto,	"AFE_DATAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE->AFE_DATAF })
TRCell():New(oProjeto,	"AFE_HORAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFE->AFE_HORAF })

TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})
TRPosition():New(oProjeto, "AFE", 1, {|| xFilial("AFE") + AF8->AF8_PROJET + AF8->AF8_REVISA})

oProjeto:Cell("AF8_DESCRI"):SetLineBreak()

oEdt := TRSection():New(oProjeto, STR0022, {"AFC" },/*aOrdem*/,.F.,.F.)
TRCell():New(oEdt,	"AFC_EDT"		,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_EDT })
TRCell():New(oEdt,	"AFC_DESCRI"	,"AFC",/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,{|| Repli(".",Val(AFC->AFC_NIVEL)-1)+Substr(AFC->AFC_DESCRI,1,70-Val(AFC->AFC_NIVEL)-1) })
TRCell():New(oEdt,	"AFC_UM"		,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_UM })
TRCell():New(oEdt,	"AFC_QUANT"		,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_QUANT })
TRCell():New(oEdt,	"AFC_HDURAC"	,"AFC",/*Titulo*/,"99999.99h"/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_HDURAC })
TRCell():New(oEdt,	"AFC_START"		,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_START })
TRCell():New(oEdt,	"AFC_FINISH"	,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_FINISH })
TRCell():New(oEdt,	"AFC_PERCPRV"	,"AFC",STR0016/*Titulo*/,"999999.99%"/*Picture*/,9/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"%Prog"
TRCell():New(oEdt,	"AFC_QTDREAL"	,"AFC",STR0017/*Titulo*/,PesqPict("AFC","AFC_QUANT")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"Quant.Real"
TRCell():New(oEdt,	"AFC_RDURAC"	,"AFC",STR0018/*Titulo*/,"99999.99h"/*Picture*/,10/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Duracao"
TRCell():New(oEdt,	"AFC_DTATUI"	,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_DTATUI })
TRCell():New(oEdt,	"AFC_DTATUF"	,"AFC",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AFC->AFC_DTATUF })
TRCell():New(oEdt,	"AFC_PERCATU"	,"AFC",STR0019/*Titulo*/,"999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"%Real"

oEdt:Cell("AFC_DESCRI"):SetLineBreak()
oEdt:Cell("AFC_QUANT"	):SetTitle(STR0020+CRLF+oEdt:Cell("AFC_QUANT"	):Title())  //"Previsto"
oEdt:Cell("AFC_HDURAC"	):SetTitle(STR0020+CRLF+oEdt:Cell("AFC_HDURAC"	):Title())  //"Previsto"
oEdt:Cell("AFC_START"	):SetTitle(STR0020+CRLF+oEdt:Cell("AFC_START"	):Title())  //"Previsto"
oEdt:Cell("AFC_FINISH"	):SetTitle(STR0020+CRLF+oEdt:Cell("AFC_FINISH"	):Title())  //"Previsto"
oEdt:Cell("AFC_PERCPRV"	):SetTitle(STR0020+CRLF+oEdt:Cell("AFC_PERCPRV"	):Title())  //"Previsto"
oEdt:Cell("AFC_QTDREAL"	):SetTitle(STR0021+CRLF+oEdt:Cell("AFC_QTDREAL"	):Title())  //"Realizado"
oEdt:Cell("AFC_RDURAC"	):SetTitle(STR0021+CRLF+oEdt:Cell("AFC_RDURAC"	):Title())  //"Realizado"
oEdt:Cell("AFC_DTATUI"	):SetTitle(STR0021+CRLF+oEdt:Cell("AFC_DTATUI"	):Title())  //"Realizado"
oEdt:Cell("AFC_DTATUF"	):SetTitle(STR0021+CRLF+oEdt:Cell("AFC_DTATUF"	):Title())  //"Realizado"
oEdt:Cell("AFC_PERCATU"	):SetTitle(STR0021+CRLF+oEdt:Cell("AFC_PERCATU"	):Title())  //"Realizado"


oTarefa := TRSection():New(oEdt, STR0023, {"AF9"},/*aOrdem*/,.F.,.F.)
TRCell():New(oTarefa,	"AF9_TAREFA"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_TAREFA })
TRCell():New(oTarefa,	"AF9_DESCRI"	,"AF9",/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,{|| Repli(".",Val(AF9->AF9_NIVEL)-1)+Substr(AF9->AF9_DESCRI,1,70-Val(AF9->AF9_NIVEL)-1) })
TRCell():New(oTarefa,	"AF9_UM"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_UM })
TRCell():New(oTarefa,	"AF9_QUANT"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_QUANT })
TRCell():New(oTarefa,	"AF9_HDURAC"	,"AF9",/*Titulo*/,"99999.99h"/*Picture*/,7/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_HDURAC })
TRCell():New(oTarefa,	"AF9_START"		,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_START })
TRCell():New(oTarefa,	"AF9_FINISH"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_FINISH })
TRCell():New(oTarefa,	"AF9_PERCPRV"	,"AF9",STR0016/*Titulo*/,"999999.99%"/*Picture*/,9/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"%Prog"
TRCell():New(oTarefa,	"AF9_QTDREAL"	,"AF9",STR0017/*Titulo*/,PesqPict("AF9","AF9_QUANT")/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"Quant.Real"
TRCell():New(oTarefa,	"AF9_RDURAC"	,"AF9",STR0018/*Titulo*/,"99999.99h"/*Picture*/,10/*Tamanho*/,/*lPixel*/,/*{|| }*/)  //"Duracao"
TRCell():New(oTarefa,	"AF9_DTATUI"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DTATUI })
TRCell():New(oTarefa,	"AF9_DTATUF"	,"AF9",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| AF9->AF9_DTATUF })
TRCell():New(oTarefa,	"AF9_PERCATU"	,"AF9",STR0019/*Titulo*/,"999.99%"/*Picture*/,7/*Tamanho*/,/*lPixel*/,/*{||}*/)  //"%Real"
oTarefa:Cell("AF9_DESCRI"):SetLineBreak()
oTarefa:Cell("AF9_QUANT"	):SetTitle(STR0020+CRLF+oTarefa:Cell("AF9_QUANT"	):Title())  //"Previsto"
oTarefa:Cell("AF9_HDURAC"	):SetTitle(STR0020+CRLF+oTarefa:Cell("AF9_HDURAC"):Title())  //"Previsto"
oTarefa:Cell("AF9_START"	):SetTitle(STR0020+CRLF+oTarefa:Cell("AF9_START"	):Title())  //"Previsto"
oTarefa:Cell("AF9_FINISH"	):SetTitle(STR0020+CRLF+oTarefa:Cell("AF9_FINISH"):Title())  //"Previsto"
oTarefa:Cell("AF9_PERCPRV"	):SetTitle(STR0020+CRLF+oTarefa:Cell("AF9_PERCPRV"):Title())  //"Previsto"
oTarefa:Cell("AF9_QTDREAL"	):SetTitle(STR0021+CRLF+oTarefa:Cell("AF9_QTDREAL"):Title())  //"Realizado"
oTarefa:Cell("AF9_RDURAC"	):SetTitle(STR0021+CRLF+oTarefa:Cell("AF9_RDURAC"):Title())  //"Realizado"
oTarefa:Cell("AF9_DTATUI"	):SetTitle(STR0021+CRLF+oTarefa:Cell("AF9_DTATUI"):Title())  //"Realizado"
oTarefa:Cell("AF9_DTATUF"	):SetTitle(STR0021+CRLF+oTarefa:Cell("AF9_DTATUF"):Title())  //"Realizado"
oTarefa:Cell("AF9_PERCATU"	):SetTitle(STR0021+CRLF+oTarefa:Cell("AF9_PERCATU"):Title())  //"Realizado"

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
Static Function ReportPrint( oReport )
Local oProjeto  	:= oReport:Section(1)
Local lImprPrj

oReport:SetMeter(AF8->(LastRec()))

oProjeto:Init()

dbSelectArea("AF8")
dbSeek(xFilial()+mv_par01,.T.)
While !Eof() .And. AF8->AF8_PROJET <= mv_par02 .AND. !oReport:Cancel()

	oReport:IncMeter()

	If AF8->AF8_DATA > mv_par04 .Or. AF8->AF8_DATA < mv_par03 
		dbSkip()
		Loop
	EndIf

	If !Empty(oProjeto:GetAdvplExp('AF8')) .And. !&(oProjeto:GetAdvplExp('AF8'))
		dbSelectArea("AF8")
		dbSkip()
		Loop
	EndIf

	SA1->(dbSetOrder(1))
	SA1->(dbSeek(xFilial()+AF8->AF8_CLIENT+AF8->AF8_LOJA))
	If !Empty(oProjeto:GetAdvplExp('SA1')) .And. !SA1->(&(oProjeto:GetAdvplExp('SA1')))
		dbSelectArea("AF8")
		dbSkip()
		Loop
	EndIf

	dbSelectArea("AFE")
	dbSetOrder(1)
	dbSeek(xFilial()+AF8->AF8_PROJET)
	lImprPrj := .F.

	While !Eof() .And. AFE->AFE_FILIAL+AFE->AFE_PROJET==xFilial()+AF8->AF8_PROJET .AND. !oReport:Cancel()

		// verifica as versoes a serem impressas
		// se estiver em branco so imprime a ultima versao (AF8_REVISA)
		If !PmrPertence(AFE->AFE_REVISA,mv_par05).Or.;
			(Empty(mv_par05).And.AFE->AFE_REVISA!=AF8->AF8_REVISA)
			dbSkip()
			Loop
		EndIf

		If !Empty(oProjeto:GetAdvplExp('AFE')) .And. !AFE->(&(oProjeto:GetAdvplExp('AFE')))
			dbSelectArea("AFE")
			dbSkip()
			Loop
		EndIf
		
		// verifica se existem tarefas/edts para serem impressas
		if !Pmr_100AFC(nil, AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET)
			dbSkip()
			Loop
		endif
		
		oProjeto:lPrintHeader := .T.
		oProjeto:PrintLine()
		lImprPrj := .T.
        
		Pmr_100AFC(oReport, AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET)

		dbSelectArea("AFE")
		dbSkip()
		
	EndDo
    
	If lImprPrj
		oReport:ThinLine()
		oReport:EndPage()
	EndIf	

	dbSelectArea("AF8")
	dbSkip()

EndDo

	// verifica o cancelamento pelo usuario..
	If oReport:Cancel()	
		oReport:SkipLine()
		oReport:PrintText(STR0025) //"*** CANCELADO PELO OPERADOR ***"
	EndIf
	
oProjeto:Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR_100AFC  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±³          ³             ³ Autor ³ Paulo Carnelossi    ³ Data ³30.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AFC.                             ³±±
±±³          ³ Conversao do Relatorio para Release 4 do Protheus8          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR_100AFC()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr_100AFC(oReport, cProjeto, cRevisa, cEDT)
Local aArea		:= GetArea()
Local aAreaAFC	:= AFC->(GetArea())
Local aAreaAF9	:= AF9->(GetArea())
Local nPercAtu
Local nPercPrv
Local lRet		:= .F.

Local aNodes := {}
Local nNode  := 0
Local oProjeto  := {}
Local oEdt		:= {}
Local oTarefa  	:= {}

if oReport<>nil
	oProjeto := oReport:Section(1)
	oEdt := oProjeto:Section(1)
	oTarefa := oEdt:Section(1)

	oEdt:Cell("AFC_PERCPRV"):SetBlock({|| nPercPrv })
	oEdt:Cell("AFC_QTDREAL"):SetBlock({|| AFC->AFC_QUANT*nPercAtu/100 })
	oEdt:Cell("AFC_RDURAC"):SetBlock({|| If(!Empty(AFC->AFC_DTATUI) .And. !Empty(AFC->AFC_DTATUF), PmsHrsItvl(AFC->AFC_DTATUI,"00:00",AFC->AFC_DTATUF,"24:00",AFC->AFC_CALEND,AFC->AFC_PROJET), "") })
	oEdt:Cell("AFC_PERCATU"):SetBlock({|| nPercAtu })

	oEdt:Init()
endif

dbSelectArea("AFC")
dbSetOrder(1)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)
cProjeto	:= AFC->AFC_PROJET
cRevisa		:= AFC->AFC_REVISA
cEDT		:= AFC->AFC_EDT

If PmrPertence(AFC->AFC_NIVEL,mv_par06) .And. ;
	PmsChkUser(AFC->AFC_PROJET,,AFC->AFC_EDT,AFC->AFC_EDTPAI,1,"ESTRUT",cRevisa)

	If if(oReport=nil, .T., Empty(oProjeto:GetAdvplExp('AFC')) .Or. AFC->(&(oProjeto:GetAdvplExp('AFC'))))
	
		nPercAtu := PmsPOCAFC(AFC->AFC_PROJET,cRevisa,AFC->AFC_EDT,mv_par07)
		nPercPrv := PmsPrvAFC(AFC->AFC_PROJET,cRevisa,AFC->AFC_EDT,mv_par07)/AFC->AFC_HUTEIS*100
		
		If nPercAtu < nPercPrv
			
			if oReport<>nil
				oEdt:PrintLine()
			endif
			lRet := .T.
			
		EndIf
	EndIf
	
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

	dbSelectArea("AF9")
	dbSkip()

EndDo

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

EndDo

aSort(aNodes, , , {|x, y| x[3]+x[4] < y[3]+y[4]})

For nNode := 1 To Len(aNodes)

	If aNodes[nNode][1] == PMS_TASK
		// Tarefa
	  	AF9->(dbGoto(aNodes[nNode][2]))
		if oReport<>nil
			oReport:IncMeter()		
		endif
		if Pmr_100AF9(oReport, AF9->AF9_PROJET, AF9->AF9_REVISA, AF9->AF9_TAREFA)	
			lRet := .T.
		endif
	
	Else
		// EDT
	  	AFC->(dbGoto(aNodes[nNode][2]))
		if oReport<>nil
			oReport:IncMeter()		
		endif
		if Pmr_100AFC(oReport, AFC->AFC_PROJET, AFC->AFC_REVISA, AFC->AFC_EDT)
			lRet := .t.
		endif
	EndIf	

Next  //nNode

if oReport<>nil
	oEdt:Finish()
endif

RestArea(aAreaAF9)
RestArea(aAreaAFC)
RestArea(aArea)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR_100AF9  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±³          ³             ³ Autor ³ Paulo Carnelossi    ³ Data ³30.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF9.                             ³±±
±±³          ³ Conversao do Relatorio para Release 4 do Protheus8          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR_100AF9()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr_100AF9(oReport, cProjeto, cRevisa, cTarefa)
Local aArea		:= GetArea()
Local aAreaAF9	:= AF9->(GetArea())
Local nPercAtu
Local nPercPrv
Local oProjeto  := nil
Local oEdt		:= nil
Local oTarefa  	:= nil
Local lRet		:= .F.

if oReport<>nil
	oProjeto := oReport:Section(1)
	oEdt := oProjeto:Section(1)
	oTarefa := oEdt:Section(1)

	oTarefa:Cell("AF9_PERCPRV"):SetBlock({|| nPercPrv })
	oTarefa:Cell("AF9_QTDREAL"):SetBlock({|| AF9->AF9_QUANT*nPercAtu/100 })
	oTarefa:Cell("AF9_RDURAC"):SetBlock({|| If(!Empty(AF9->AF9_DTATUI) .And. !Empty(AF9->AF9_DTATUF), PmsHrsItvl(AF9->AF9_DTATUI,"00:00",AF9->AF9_DTATUF,"24:00",AF9->AF9_CALEND,AF9->AF9_PROJET), "") })
	oTarefa:Cell("AF9_PERCATU"):SetBlock({|| nPercAtu })
endif


If PmrPertence(AF9->AF9_NIVEL,mv_par06) .And. ;
	PmsChkUser(AF9->AF9_PROJET,AF9->AF9_TAREFA,,AF9->AF9_EDTPAI,1,"ESTRUT",cRevisa)
	
	If Pmr100Rec()

		If oReport=nil .or. Empty(oProjeto:GetAdvplExp('AF9')) .Or. AF9->(&(oProjeto:GetAdvplExp('AF9')))
			nPercAtu := PmsPOCAF9(AF9->AF9_PROJET,cRevisa,AF9->AF9_TAREFA,mv_par07)
			nPercPrv := PmsPrvAF9(AF9->AF9_PROJET,cRevisa,AF9->AF9_TAREFA,mv_par07)/AF9->AF9_HUTEIS*100
	
			If nPercAtu < nPercPrv
				
				if oReport<>nil
					If ! oTarefa:lPrinting
						oTarefa:Init()
					EndIf	
					oTarefa:PrintLine()
				endif
				lRet := .T.
				
			EndIf
	   Endif
	EndIf

Endif	

if oReport<>nil
	If oTarefa:lPrinting
		oTarefa:Finish()
	EndIf	
endif

RestArea(aAreaAF9)
RestArea(aArea)

Return lRet


Static Function PMR100Rec()
Local lRet		:=	.F. 
If !Empty(mv_par08) .Or. UPPER(mv_par09) <> Replicate('Z',TamSx3('AFA_RECURS')[1])
	DbSelectArea('AFA')
  	DbSetOrder(5)
  	DbSeek(xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA+MV_PAR08,.T.)
  	If AFA_FILIAL+AFA_PROJET+AFA_REVISA+AFA_TAREFA == xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA .And.;
  		AFA_RECURS <= MV_PAR09   
  		lRet	:=	.T.
	Endif
Else
	lRet	:=	.T.   	
Endif
Return lRet

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

