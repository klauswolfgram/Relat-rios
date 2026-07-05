/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PMSR190.ch"
#INCLUDE "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PMSR190   ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/13/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Lista para Cotacao (Orcamento)                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAPMS                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PMSR190()
Local oReport

If PMSBLKINT()
	Return Nil
EndIf	

	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Carlos A. Gomes Jr. º Data ³  06/13/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport,oSectionT,oSection1,oSection2
Local cDescri := STR0001 + STR0002 //"Este programa tem como objetivo imprimir relatorio " ##"de acordo com os parametros informados pelo usuario." 
Local cReport := "PMSR190"

Pergunte( "PMR190" , .F. )

oReport  := TReport():New( cReport, STR0003, "PMR190" , { |oReport| ATFR250Imp( oReport ) }, cDescri ) //"Lista para Cotacao por Orcamento"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao de Orçamento                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSectionT := TRSection():New( oReport, STR0010, {"AF1", "SA1"} ) //"Orçamento"
TRCell():New( oSectionT, "AF1_ORCAME" , "AF1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSectionT, "AF1_DESCRI" , "AF1" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRPosition():New(oSectionT, "AF2", 1, {|| xFilial("AF2") + AF1->AF1_ORCAME})
TRPosition():New(oSectionT, "SA1", 1, {|| xFilial("SA1") + AF1->AF1_CLIENT})

oSectionT:SetLineStyle()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao de Tarefa                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oSectionT, STR0011, {"AF2"} ) //"Tarefa"
TRCell():New( oSection1, "AF2_TAREFA" , "AF2" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection1, "AF2_DESCRI" , "AF2" ,/*X3Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oSection1:SetLineStyle()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao - detalhes                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New( oSectionT, STR0012, {"SB1"} ) //"Detalhe"
TRCell():New( oSection2, "cCol1" ,/*Alias*/,STR0013   ,/*Picture*/      ,20,/*lPixel*/,/*{|| code-block de impressao }*/) //"Produto"
TRCell():New( oSection2, "B1_DESC" ,"SB1",/*X3Titulo*/,/*Picture*/      ,  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New( oSection2, "cCol3" ,/*Alias*/,STR0014   ,/*Picture*/      , 5,/*lPixel*/,/*{|| code-block de impressao }*/) //"UM"
TRCell():New( oSection2, "cCol4" ,/*Alias*/,STR0015   ,"@E 999,999.9999",19,/*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
TRCell():New( oSection2, "cCol5" ,/*Alias*/,STR0016   ,"@E 9,999,999.99",19,/*lPixel*/,/*{|| code-block de impressao }*/) //"Custo Standard"
TRCell():New( oSection2, "cCol6" ,/*Alias*/,STR0017   ,/*Picture*/      ,10,/*lPixel*/,{|| "" }) //"Anotações"

oSection2:SetLinesBefore(0)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ATFR250ImpºAutor  ³Carlos A. Gomes Jr. º Data ³  06/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ATFR250Imp( oReport )

Local oSectionT := oReport:Section(1)
Local oSection1 := oSectionT:Section(1)
Local oSection2 := oSectionT:Section(2)

Local aProdutos:= {}
Local nX       := 0
Local cTarefa  := ""
Local cTxtBrk  := ""

oSection2:Cell("cCol1"):SetBlock({|| aProdutos[nX,2] })
oSection2:Cell("cCol3"):SetBlock({|| aProdutos[nX,5]  })
oSection2:Cell("cCol4"):SetBlock({|| aProdutos[nX,3]  })
oSection2:Cell("cCol5"):SetBlock({|| aProdutos[nX,4]/aProdutos[nX,3]  })

dbSelectArea("AF1")
dbSetOrder(1)

dbSelectArea("AF2")
dbSetOrder(1)

dbSelectArea("AF3")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("AF1")
oReport:SetMeter(RecCount())
dbGoTop()
dbSeek(xFilial("AF1")+mv_par01,.T.)
While !Eof() .And. AF1->AF1_FILIAL == xFilial("AF1") .and. AF1->AF1_ORCAME <= mv_par02 .And. !oReport:Cancel()
	
	oSectionT:Init()
	oSectionT:PrintLine()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega os produtos do orcamento/tarefa.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PMR190Produtos(@aProdutos)

	If mv_par09 != 2
		oSection2:Init()
	EndIf

	For nX:= 1 To Len(aProdutos)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica se a impressao e por orcamento ou por tarefa.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (mv_par09 == 2) .And. (cTarefa <> aProdutos[nX,1])
			cTarefa:= aProdutos[nX,1]
			AF2->(dbSetOrder(1))
			AF2->(MsSeek(xFilial("AF2") + AF1->AF1_ORCAME + cTarefa))

			oSection1:Finish()			
			oSection1:Init()

			oSection1:PrintLine()
			oSection2:Finish()
			oSection2:Init()
		EndIf
		SB1->(MsSeek(xFilial("SB1")+aProdutos[nX,2]))

		oSection2:PrintLine()

	Next nX
	oSection2:Finish()
	oSection1:Finish()
	oSectionT:Finish()
		
	oReport:IncMeter()	
	aProdutos:= {}
	dbSelectArea("AF1")
	dbSkip() // Avanca o ponteiro do registro no arquivo

EndDo

If oReport:Cancel()
	oReport:Say( oReport:Row()+1 ,10 ,STR0007) //"*** CANCELADO PELO OPERADOR ***"
EndIf

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PMR190Produtos³ Autor ³Fabio Rogerio Pereira  ³ Data ³ 16.10.02³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Selecao dos produtos que serao impressos                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PMR190Produtos(aProdutos)                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PMR190Produtos(aProdutos)
Local nPos	   := 0
Local nQuantAF3:= 0
Local cGrupAF3 := ""
Local cUnidMed := ""

Local aArea    := GetArea()

dbSelectArea("AF2")
dbGoTop()
dbSeek(xFilial("AF2")+AF1->AF1_ORCAME)
While !Eof() .and. AF2->AF2_ORCAME == AF1->AF1_ORCAME
	If !PmrPertence(AF2->AF2_NIVEL,mv_par03)
		dbSelectArea("AF2")
		dbSkip()
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Pesquisa os produtos da tarefa.³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("AF3")
	dbSetOrder(1)
	If dbSeek(xFilial("AF3")+AF2->AF2_ORCAME+AF2->AF2_TAREFA)
		While !Eof() .and. AF3->AF3_ORCAME+AF3->AF3_TAREFA == AF2->AF2_ORCAME+AF2->AF2_TAREFA
			If (mv_par08 == 2 .and. AF3->AF3_CUSTD == 0) .or. (mv_par08 == 3 .and. AF3->AF3_CUSTD <> 0)
				dbSkip()
				Loop
			EndIf
			If !Empty(AF3->AF3_PRODUT)
				cGrupAF3 := Posicione("SB1",1,xFilial("SB1")+AF3->AF3_PRODUT,"B1_GRUPO")
				cUnidMed := Posicione("SB1",1,xFilial("SB1")+AF3->AF3_PRODUT,"B1_UM")
				If (AF3->AF3_PRODUT >= mv_par04 .and. AF3->AF3_PRODUT <= mv_par05 .and. cGrupAF3 >= mv_par06 .and. cGrupAF3 <= mv_par07)
					nQuantAF3:= PmsAF3Quant(AF3->AF3_ORCAME,AF3->AF3_TAREFA,AF3->AF3_PRODUT,AF2->AF2_QUANT,AF3->AF3_QUANT)
					If Mv_Par09 == 2 //Imprime por tarefa
						nPos:= aScan(aProdutos,{|x| x[1]+x[2] == AF3->AF3_TAREFA+AF3->AF3_PRODUT})
						If (nPos > 0)
							aProdutos[nPos,3]+= nQuantAF3
							aProdutos[nPos,4]+= nQuantAF3 * AF3->AF3_CUSTD
						Else
							aAdd(aProdutos,{AF3->AF3_TAREFA,AF3->AF3_PRODUT,nQuantAF3,AF3->AF3_CUSTD*nQuantAF3,cUnidMed})
						EndIf
					Else
						nPos:= aScan(aProdutos,{|x| x[2] == AF3->AF3_PRODUT})
						If (nPos > 0)
							aProdutos[nPos,3]+= nQuantAF3
							aProdutos[nPos,4]+= nQuantAF3 * AF3->AF3_CUSTD
						Else
							aAdd(aProdutos,{"",AF3->AF3_PRODUT,nQuantAF3,AF3->AF3_CUSTD*nQuantAF3,cUnidMed})
						EndIf
						
					EndIf
				EndIf
			EndIf
			dbSelectArea("AF3")
			dbSkip()
		End
	EndIf
	
	dbSelectArea("AF2")
	dbSkip()
End

RestArea(aArea)

Return