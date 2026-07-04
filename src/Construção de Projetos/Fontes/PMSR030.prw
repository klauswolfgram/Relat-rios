/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch"
#include "PMSR030.ch"
#include "pmsicons.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PMSR030R4 ºAutor  ³Paulo Carnelossi    º Data ³  14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³Impressao dos orcamentos  e itens do orcamento              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PMSR030()

Local oReport	:= Nil

If !PMSBLKINT()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica as Perguntas Seleciondas                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("PMR030",.F.)  
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                       
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf  

Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Paulo Carnelossi    º Data ³  14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()
Local cPerg		:= "PMR030"
Local cDesc1	:= STR0001 //"Este relatorio ira imprimir o orcamentos "
Local cDesc2	:= STR0002 //"conforme os parametros solicitados"
Local oReport	:= Nil
Local oTarefa	:= Nil

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

oReport := TReport():New("PMSR030",STR0005, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1+CRLF+cDesc2 )
oReport:SetPortrait()

oOrcamento := TRSection():New(oReport, STR0039, {"AF1", "SA1"}, aOrdem /*{}*/, .F., .F.)
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
TRCell():New(oOrcamento,	"AF1_ORCAME"	,"AF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oOrcamento,	"AF1_DESCRI"	,"AF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oOrcamento, "SA1", 1, {|| xFilial("SA1") + AF1->AF1_CLIENT})

//-------------------------------------------------------------
oCliente := TRSection():New(oReport, STR0040, { "SA1"}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oCliente, "A1_COD"		,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCliente, "A1_LOJA"	,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oCliente, "A1_NOME" 	,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

//-------------------------------------------------------------
oEdtOrc := TRSection():New(oReport, STR0038, {"AF5" /*, "AF1"*/}, aOrdem /*{}*/, .F., .F.)

TRCell():New(oEdtOrc, "AF5_EDT"		,"AF5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oEdtOrc, "AF5_DESCRI"	,"AF5",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oEdtOrc, "AF5_UM"		,"AF5",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oEdtOrc, "AF5_QUANT"	,"AF5",STR0031+CRLF+STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Quantidade"
TRCell():New(oEdtOrc, "AF5_CUSTO"	,"AF5",STR0031+CRLF+STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Custo"     

//TRPosition():New(oEdtOrc, "AF1", 1, {|| xFilial("AF1") + AF5->AF5_ORCAME})

//-------------------------------------------------------------
oTarefa := TRSection():New(oReport, STR0041, { "AF2"}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oTarefa, "AF2_TAREFA"	,"AF2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa, "AF2_DESCRI"	,"AF2",/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa, "AF2_UM"		,"AF2",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa, "AF2_QUANT"	,"AF2",STR0031+CRLF+STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Quantidade"
TRCell():New(oTarefa, "AF2_HDURAC"	,"AF2",STR0031+CRLF+STR0033,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Duracao"
TRCell():New(oTarefa, "AF2_CUSTO"	,"AF2",STR0031+CRLF+STR0032,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Custo"

//-------------------------------------------------------------
oTarefaAF3 := TRSection():New(oReport, STR0037, {"AF3", "SB1", "AE8"}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oTarefaAF3, "AF3_PRODUT"	,"AF3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefaAF3, "B1_DESC"		,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefaAF3, "B1_UM"		,"SB1",STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefaAF3, "AF3_QUANT"	,"AF3",STR0031+CRLF+STR0034,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Previsto" "Quantidade"
TRCell():New(oTarefaAF3, "AF3_CUSTD"	,"AF3",STR0035+CRLF+STR0036,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Unitário" "Médio"
TRCell():New(oTarefaAF3, "AF3_CUSTD1"	,""   ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")
oTarefaAF3:Cell("AF3_CUSTD1"):GetFieldInfo("AF3_CUSTD")

TRPosition():New(oTarefaAF3, "SB1", 1, {|| xFilial("SB1") + AF3->AF3_PRODUT})
TRPosition():New(oTarefaAF3, "AE8", 1, {|| xFilial("AE8") + AF3->AF3_RECURS})

//-------------------------------------------------------------
oTarefaAF4 := TRSection():New(oReport, STR0019, { "AF4", "SX5"}, /*{aOrdem}*/, .F., .F.) ////"Despesa"
TRCell():New(oTarefaAF4, "AF4_ITEM"		,"AF4"	,STR0019/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Despesa"
TRCell():New(oTarefaAF4, "AF4_DESCRI"	,"AF4"	,STR0014/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Descrição"
TRCell():New(oTarefaAF4, "AF4_TIPOD"	,"AF4"	,STR0020/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Tipo Despesa"
TRCell():New(oTarefaAF4, "AF4_TIPOD1"	,""		,STR0014/*Titulo*/,/*Picture*/,30/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Descrição"
TRCell():New(oTarefaAF4, "AF4_VALOR"	,"AF4"	,STR0021/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Valor Previsto"

TRPosition():New(oTarefaAF4, "SX5", 1, {|| xFilial("SX5") + 'FD' + AF4->AF4_TIPOD})

//-------------------------------------------------------------
oTarefaAF7 := TRSection():New(oReport, STR0022, { "AF7"/*,"SB1"*/}, /*{aOrdem}*/, .F., .F.)
TRCell():New(oTarefaAF7, "AF7_PREDEC"	,"AF7"	,STR0022/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Predescessora"
TRCell():New(oTarefaAF7, "AF7_DESCRI"	,""		,STR0014/*Titulo*/,/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Descrição"
TRCell():New(oTarefaAF7, "AF7_TIPO"		,""		,STR0023/*Titulo*/,/*Picture*/,20/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/) //"Tipo Relacionamento"
TRCell():New(oTarefaAF7, "AF7_HRETAR"	,"AF7"	,STR0024/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT") //"Retardo (Horas)"

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor  ³Paulo Carnelossi   º Data ³ 14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport)
Local oOrcamento	:= oReport:Section(1)
Local oCliente      := oReport:Section(2)
Local cTrunca := "1"
Local aArea		:= GetArea()
Private oEdtOrc    := oReport:Section(3)

	dbSelectArea("AF1")
	dbSetOrder(1)
	
	dbSelectArea("AF2")
	dbSetOrder(1)
	
	oReport:SetMeter(AF1->(LastRec()))
	
	dbSelectArea("AF1")
	dbGoTop()
	
	oOrcamento:Init() // INICIALIZA FILTRO DO AF1 (ORCAMENTOS)
	
	dbSeek(xFilial("AF1")+mv_par01,.T.)
	While !Eof() .And. (AF1->AF1_FILIAL == xFilial("AF1")) .And. (AF1->AF1_ORCAME >= mv_par01) .And. (AF1->AF1_ORCAME <= mv_par02) 
	
		If  (AF1->AF1_DATA >= Mv_Par03) .And. (AF1->AF1_DATA <= Mv_Par04) .And. PmrPertence(AF1->AF1_FASE,mv_par06) .And. ;
		    (AF1->AF1_CLIENT+AF1->AF1_LOJA >= Mv_Par12 + Mv_Par13) .And. (AF1->AF1_CLIENT+AF1->AF1_LOJA <= Mv_Par14 + Mv_Par15)
	
			// verifica o cancelamento pelo usuario..
			If oReport:Cancel()
				Exit
			Endif
		    
		  	oReport:IncMeter()
		  	
			// imprime os dados do orcamento 
			oOrcamento:PrintLine()
		
			SA1->(dbSetOrder(1))
			If SA1->(dbSeek(xFilial()+AF1->AF1_CLIENT+AF1->AF1_LOJA))
			    oCliente:Init()
			    oCliente:PrintLine()
			    oCliente:Finish()
			EndIf
			
			oReport:ThinLine()
		
			cTrunca := AF1->AF1_TRUNCA
			
			oEdtOrc:Init() // REALIZA O FILTRO PERSONALIZADO DO RELATORIO (FILTRO DO AF5)
			// imprime as EDT's do projeto
			Pmr030_AF5( oReport, AF1->AF1_ORCAME ,AF1->AF1_ORCAME ,cTrunca )
	
			oEdtOrc:Finish()	
			
			oReport:ThinLine()
		
			If oReport:Cancel()
				oReport:Say( oReport:Row()+1 ,10 ,STR0008 ) //"*** CANCELADO PELO OPERADOR ***"
			EndIf
			
			oReport:EndPage()
	    EndIF
		dbSelectArea("AF1")
		dbSkip() // Avanca o ponteiro do registro no arquivo
	EndDo
	
	// finaliza a execucao do relatorio
	oOrcamento:Finish()
RestArea(aArea)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR030_AF5  ³ Autor ³Fabio Rogerio Pereira³ Data ³25.03.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF5.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR030_AF5()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr030_AF5( oReport, cOrcame ,cEDT ,cTrunca )

Local aNodes := {}
Local nNode  := 0
Local nAF5EDT := TamSx3("AF5_EDT")[1]

DEFAULT cTrunca := "1"
                                                                           		
cEDT := Padr(cEDT,nAF5EDT)
	
dbSelectArea("AF5")
dbSetOrder(1) //AF5_FILIAL+AF5_ORCAME+AF5_EDT+AF5_ORDEM
MsSeek(xFilial("AF5") + cOrcame + cEDT)
While AF5->(!EOF()) .AND. AF5->(AF5_FILIAL+AF5_ORCAMEN+AF5_EDT)==xFilial("AF1")+cOrcame+cEDT
	
	aNodes := {}
	
	If PmrPertence(AF5->AF5_NIVEL,Mv_Par05) .and. !oReport:Cancel()
		
		oReport:ThinLine()
			
		dbSelectArea("AF5")
		
		oEdtOrc:PrintLine()
			
		oReport:ThinLine()
	
	EndIf
	
	// imprime as tarefas da EDT
	dbSelectArea("AF2")
	dbSetOrder(2)
	dbSeek(xFilial("AF2") + cOrcame + cEDT)
	While !Eof() .And. (xFilial("AF2") + cOrcame + cEDT ==;
						AF2->AF2_FILIAL + AF2->AF2_ORCAME + AF2->AF2_EDTPAI)
		aAdd(aNodes, {PMS_TASK,;
		              AF2->(Recno()),;
		              If(Empty(AF2->AF2_ORDEM), "000", AF2->AF2_ORDEM),;
		              AF2->AF2_TAREFA})
		dbSkip()
	End
	nRecnoAF5 := AF5->(Recno())
	// imprime as EDT`s filhas se existir
	dbSelectArea("AF5")
	dbSetOrder(2)
	dbSeek(xFilial("AF5") + cOrcame + cEDT)
	While !Eof() .And. (xFilial("AF5") + cOrcame + cEDT ==;
						AF5->AF5_FILIAL+AF5->AF5_ORCAME+AF5->AF5_EDTPAI)
		aAdd(aNodes, {PMS_WBS,;
		              AF5->(Recno()),;
		              If(Empty(AF5->AF5_ORDEM), "000", AF5->AF5_ORDEM),;
		              AF5->AF5_EDT})
		dbSelectArea("AF5")
		dbSkip()
	EndDo
	
	aSort(aNodes, , , {|x, y| x[3]+x[4] < y[3]+y[4]})
	
	For nNode := 1 To Len(aNodes)
		If aNodes[nNode][1] == PMS_TASK
			AF2->(dbGoto(aNodes[nNode][2]))
			Pmr030_AF2( oReport, AF2->AF2_ORCAME, AF2->AF2_TAREFA, cTrunca)
			
		Else
			AF5->(dbGoto(aNodes[nNode][2]))
			Pmr030_AF5( oReport, AF5->AF5_ORCAME, AF5->AF5_EDT, cTrunca)
			
		EndIf
		If oReport:Cancel()
			Exit
		EndIf
	Next nNode
	
	dbSelectArea("AF5")
	dbSkip()

EndDo	

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PMR030_AF2  ³ Autor ³Fabio Rogerio Pereira³ Data ³25.03.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF2.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR030_AF2()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Pmr030_AF2( oReport, cOrcame ,cTarefa ,cTrunca )
Local aArea		:= GetArea()
Local aAreaAF2	:= AF2->(GetArea())
Local cTipo		:= ""
Local nQuantAF3 := 0
Local nValorAF4 := 0

Local nDecCst  	 := TamSX3("AF2_CUSTO")[2]
Local oTarefa    := oReport:Section(4)
Local oTarefaAF3 := oReport:Section(5)
Local oTarefaAF4 := oReport:Section(6)
Local oTarefaAF7 := oReport:Section(7)
Local aProduto
DEFAULT cTrunca	:= "1"

oTarefaAF3:Cell("AF3_PRODUT")	:SetBlock({|| aProduto[1] })
oTarefaAF3:Cell("B1_DESC")		:SetBlock({|| aProduto[2] })
oTarefaAF3:Cell("B1_UM")		:SetBlock({|| aProduto[3] })
oTarefaAF3:Cell("AF3_QUANT")	:SetBlock({|| nQuantAF3   })
oTarefaAF3:Cell("AF3_CUSTD1")	:SetBlock({|| PmsTrunca(cTrunca,(nQuantAF3 * AF3->AF3_CUSTD),nDecCst,AF2->AF2_QUANT) })

oTarefaAF4:Cell("AF4_TIPOD1"):SetBlock({|| Left(Posicione("SX5",1,xFilial("SX5") + "FD" + AF4->AF4_TIPOD,"X5DESCRI()"),30) })
oTarefaAF4:Cell("AF4_VALOR"):SetBlock({|| nValorAF4 })

oTarefaAF7:Cell("AF7_TIPO"):SetBlock({|| cTipo } )
oTarefaAF7:Cell("AF7_DESCRI"):SetBlock({|| Padr( Alltrim(SubStr(Posicione("AF2",1,xFilial("AF2") + AF7->AF7_ORCAME + AF7->AF7_PREDEC,"AF2_DESCRI"),1,20)) ,25)  } )

dbSelectArea("AF2")

// imprime as tarefas de uma EDT selecionada
If !PmrPertence(AF2->AF2_NIVEL,mv_par05)
	Return(.F.)
EndIf

oTarefa:Init()

oTarefa:PrintLine()

// verifica se existem produtos na tarefa
dbSelectArea("AF3")
dbSetOrder(1)   
If dbSeek(xFilial("AF3") + cOrcame + cTarefa)
	
	oTarefaAF3:Init()
	// imprime os produtos da tarefa
	While !Eof() .And. (xFilial("AF3") == AF3->AF3_FILIAL) .And. ;
								(cOrcame == AF3->AF3_ORCAME) .And. ;
								(cTarefa == AF3->AF3_TAREFA) .and. !oReport:Cancel()

		// valida os produtos
		cTipo    := Posicione("SB1",1,xFilial("SB1") + AF3->AF3_PRODUT,"B1_TIPO")
		nQuantAF3:= PmsAF3Quant(AF2->AF2_ORCAME,AF2->AF2_TAREFA,AF3->AF3_PRODUT,AF2->AF2_QUANT,AF3->AF3_QUANT)
		
		
		  	If (AF3->AF3_PRODUT >= Mv_Par07) .And. (AF3->AF3_PRODUT <= Mv_Par08) .And. (Empty(Mv_Par09) .Or. cTipo == Mv_Par09)

	  			aProduto := R030Produto()		
				oTarefaAF3:PrintLine()
				
			EndIf	
		
		dbSelectArea("AF3")
		dbSkip()
		
	End
	
	oTarefaAF3:Finish()


EndIf

// imprime as despesas
dbSelectArea("AF4")
dbSetOrder(1)
If dbSeek(xFilial("AF4") + cOrcame + cTarefa)
	oTarefaAF4:Init()
	
	// imprime as despesas da tarefa
	While !Eof() .And. (xFilial("AF4") == AF4->AF4_FILIAL) .And. (cOrcame == AF4->AF4_ORCAME) .And. (cTarefa == AF4->AF4_TAREFA) ;
	     .and. !oReport:Cancel()
		
		// valida as despesas
		If (AF4->AF4_TIPOD >= Mv_Par10) .And. (AF4->AF4_TIPOD <= Mv_Par11)
			nValorAF4:= PmsTrunca(cTrunca,PmsAF4Valor(AF2->AF2_QUANT,AF4->AF4_VALOR),nDecCst,AF2->AF2_QUANT)
			
			oTarefaAF4:PrintLine()
			
		EndIf
		
		dbSelectArea("AF4")
		dbSkip()
	End
	
	oTarefaAF4:Finish()
	
EndIf
	
// imprime os relacionamentos
dbSelectArea("AF7")
dbSetOrder(1)
If dbSeek(xFilial("AF7") + cOrcame + cTarefa)

	oTarefaAF7:Init()

	// imprime os relacionamentos da tarefa
	While !Eof() .And. (xFilial("AF7") == AF7->AF7_FILIAL)	 .And. (cOrcame == AF7->AF7_ORCAME) .And. (cTarefa == AF7->AF7_TAREFA);
		 .and. !oReport:Cancel()		
		cTipo := R030Tipo()
		
		oTarefaAF7:PrintLine()
		
		dbSelectArea("AF7")
		dbSkip()
		
	End
	
	oTarefaAF7:Finish()
	
EndIf
	
oTarefa:Finish()

oReport:SkipLine()
	
RestArea(aAreaAF2)
RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R030Tipo  ºAutor  ³Paulo Carnelossi    º Data ³  14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R030Tipo()
Local cTipo := ""

Do Case
	Case (AF7->AF7_TIPO == "1") 
		cTipo:= STR0025 //"Fim-no-Inicio"

	Case (AF7->AF7_TIPO == "2") 
		cTipo:= STR0026 //"Inicio-no-Inicio"

	Case (AF7->AF7_TIPO == "3") 
		cTipo:= STR0027 //"Fim-no-Fim"

	Case (AF7->AF7_TIPO == "4") 
		cTipo:= STR0028 //"Inicio-no-Fim"
EndCase

Return(cTipo)			


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R030Produto ºAutor  ³Paulo Carnelossi  º Data ³  14/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Release 4                                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R030Produto()		
Local aProduto := {"","",""}

If (Empty(AF3->AF3_RECURS)) 
	aProduto[1] := AF3->AF3_PRODUT
	aProduto[2] := AllTrim(SUBSTR(Posicione("SB1",1,xFilial("SB1") + AF3->AF3_PRODUT,"B1_DESC"),1,24))
	aProduto[3] := Posicione("SB1",1,xFilial("SB1") + AF3->AF3_PRODUT,"B1_UM")
Else
	aProduto[1] := AF3->AF3_RECURS
	aProduto[2] := AllTrim(SUBSTR(Posicione("AE8",1,xFilial("AE8") + AF3->AF3_RECURS,"AE8_DESCRI"), 1, 24))
	aProduto[3] := "HR"
EndIf

Return(aProduto)