/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR150.CH"
#INCLUDE "PROTHEUS.CH"
                                      
Static nSegundaUnid 
Static lLGPD	 	:= FindFunction("SuprLGPD") .And. SuprLGPD()     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR150  ³ Autor ³ Ricardo Berti		    ³ Data ³31/07/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao das Cotacoes                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR150(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr150(cNumCota)

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef(cNumCota)
oReport:PrintDialog()
                                               
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³ Autor ³ Ricardo Berti		    ³ Data ³31/07/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao das Cotacoes                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nExp01: cNumCota = Cotacao a ser impressa                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef(cNumCota)

Local oReport 
Local oSection1 
Local oSection2 
Local cTitle := STR0001	//"Emissao das cotacoes de compras"
Local cEmail,cEndEnt,cTel
Local cPerg, wNrel
// Verifica conteudo p/ Grupo Fornec. (001) e Loja (002)
Local cDescPro := ""
Local nItem    := 0

PRIVATE nomeprog:="MATR150"
wNrel  := "MATR150"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01	     	  Do Numero                              ³
//³ mv_par02	     	  Ate o Numero 		                     ³
//³ mv_par03	     	  Do Fornecedor                          ³
//³ mv_par04              Ate o Fornecedor            	     	 ³
//³ mv_par05              Ate a data de validade      	   	     ³
//³ mv_par06              Campo Descricao do Produto             ³
//³ mv_par07              Endrre‡o Fiscal                        ³
//³ mv_par08              Cidade - Estado                        ³
//³ mv_par09              Fax                                    ³
//³ mv_par10              Qual Unidade de Medida ?               ³
//³ mv_par11              Telefone                               ³
//³ mv_par12              Endereco de Entrega ?                  ³
//³ mv_par13              Endereco de e-mail  ?                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If cNumCota == Nil
	cPerg := "MTR150"
Else
	cPerg := "MR150A"
EndIf
pergunte(cPerg,.F.)

If !Empty(cNumCota)
    cEmail       := mv_par09
    cEndEnt      := mv_par08
	cTel         := mv_par07
	nSegundaUnid := mv_par06		// Grupo MR150A
	mv_par09     := mv_par05
	mv_par08     := mv_par04
	mv_par07     := mv_par03
	mv_par06     := mv_par02
	mv_par05     := mv_par01
	nomeprog     := "MATA130"
	mv_par03     := "      "
	mv_par04     := "ZZZZZZ"
Else
	nSegundaUnid := mv_par10
	cTel         := mv_par11		// Grupo MTR150
    cEndEnt      := mv_par12
    cEmail       := mv_par13
EndIf

oReport := TReport():New(wNrel,cTitle,cPerg,{|oReport| ReportPrint(oReport,@cDescPro,cEmail,cEndEnt,cTel,@nItem,cNumCota)},STR0001+" "+STR0002) //"Relacao de Cotacoes"
oReport:SetPortrait()
oReport:HideHeader()			// Nao imprime cabecalho padrao do Protheus
oReport:HideFooter()			// Nao imprime rodape padrao do Protheus
oReport:HideParamPage()			// inibe impressao da pagina de parametros
oReport:SetTotalInLine(.F.)

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

oSection1 := TRSection():New(oReport,STR0001,{"SC8","SM0","SA2"}) //"Emissao das cotacoes de compras"

oSection1:SetLineStyle()
oSection1:SetReadOnly()
oSection1:SetHeaderSection(.F.)	// Desabilita Impressao Cabecalho no Topo da Pagina
oSection1:SetNoFilter("SM0")
oSection1:SetNoFilter("SA2")
oSection1:SetCharSeparator("")

oSection2 := TRSection():New(oSection1,STR0002,{"SC8","SB1"})  //"Relacao de Cotacoes"
oSection2:SetNoFilter("SB1")

TRCell():New(oSection2,"ITEM"		,"SC8",STR0037,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| StrZero(++nItem,4) })
TRCell():New(oSection2,"C8_PRODUTO","SC8",STR0036,,,,) //"N/Vosso Codigo"
TRCell():New(oSection2,"DESCPROD"  ,"SB1",RetTitle("B1_DESC"),,40,, {|| cDescPro })
TRCell():New(oSection2,"C8_QUANT",  "SC8",,,,, {|| If(nSegundaUnid==2 .And. !Empty(SC8->C8_QTSEGUM),SC8->C8_QTSEGUM,SC8->C8_QUANT) })
TRCell():New(oSection2,"C8_UM",     "SC8",,,,, {|| If(nSegundaUnid==2 .And. !Empty(SC8->C8_QTSEGUM),SC8->C8_SEGUM,SC8->C8_UM) })
TRCell():New(oSection2,"CDADOS"    ,"   ",Iif(cPaisLoc<>"PER",STR0034,STR0040),,,,) //   {|| Replicate("_",Len(STR0034)) })  //"Val.Unitario    Valor Total    IPI   Valor do IPI  Prz(dias)"
TRCell():New(oSection2,"C8_DATPRF", "SC8",,,,,)

oSection2:Cell("DESCPROD"):SetLineBreak()
oSection2:Cell("CDADOS"):SetLineBreak() 
	
Return(oReport)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Ricardo Berti		    ³ Data ³31/07/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³ExpC1: Var. para montagem da descr. do produto			  ³±±
±±³          ³ExpC2: e-mail digitado na pergunte						  ³±±
±±³          ³ExpC3: end.entrega digitada na pergunte					  ³±±
±±³          ³ExpC4: telefonte digitado na pergunte						  ³±±
±±³          ³ExpN1: var.p/calculo do No.do item na impressao			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cDescPro,cEmail,cEndEnt,cTel,nItem,cNumCota)

Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cCondicao:= ""
Local cCotacao := ""
Local cFornece := ""
Local cLoja    := ""
Local cContato := ""
Local cVar     := ""
Local cObs01   := ""
Local cObs02   := ""
Local cObs03   := ""
Local cObs04   := ""
Local nLinObs  := 0
Local nX       := 0
Local cEnd
Local dEmissao := CtoD("")
Local nPrinted := 0
Local nPagina  := 0
Local nRegistro:= 0  
Local nTamCdPrd:= TamSX3("C7_PRODUTO")[1]
Local cFilEnt  := ""
Local cForNome := ""

If cNumCota == Nil
	cPerg := "MTR150"
Else
	cPerg := "MR150A"
EndIf
pergunte(cPerg,.F.)

If !Empty(cNumCota)
    cEmail       := mv_par09
    cEndEnt      := mv_par08
	cTel         := mv_par07
	nSegundaUnid := mv_par06		// Grupo MR150A
	mv_par09     := mv_par05
	mv_par08     := mv_par04
	mv_par07     := mv_par03
	mv_par06     := mv_par02
	mv_par05     := mv_par01
	nomeprog     := "MATA130"
	mv_par03     := "      "
	mv_par04     := "ZZZZZZ"
Else
	nSegundaUnid := mv_par10
	cTel         := mv_par11		// Grupo MTR150
    cEndEnt      := mv_par12
    cEmail       := mv_par13
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC8")
dbSetOrder(1)
                  
If oReport:nEnvironment == 2    
	oSection2:Cell("ITEM"):nSize 	    := 6
	oSection2:Cell("C8_PRODUTO"):nSize  := IIf(nTamCdPrd==15,22,50)
	oSection2:Cell("DESCPROD"):nSize    := IIf(nTamCdPrd==15,30,10)
	oSection2:Cell("C8_QUANT"):nSize    := 16
	oSection2:Cell("C8_UM"):nSize       := 2
	oSection2:Cell("CDADOS"):nSize      := 55
	oSection2:Cell("C8_DATPRF"):nSize   := 18
EndIf  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao Advpl                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

MakeAdvplExpr(oReport:uParam)

cCondicao := 'C8_FILIAL == "'+xFilial("SC8")+'".And.' 
If !Empty(cNumCota)

	cCondicao += 'C8_NUM >= "'+cNumCota+'".And. C8_NUM <="'+cNumCota+'".And.'
	
	cCondicao += 'C8_FORNECE >= "'+mv_par03+'" .And. C8_FORNECE <="'+mv_par04+'".And.'	
	
	If !Empty(DtoS(mv_par01))
		cCondicao += 'DtoS(C8_VALIDA) <= "'+DtoS(mv_par01)+'".And.'
	EndIf	
	
Else
	
	cCondicao += 'C8_NUM >= "'+mv_par01+'".And. C8_NUM <="'+mv_par02+'".And.'
	
	cCondicao += 'C8_FORNECE >= "'+mv_par03+'" .And. C8_FORNECE <="'+mv_par04+'".And.'	

	If !Empty(DtoS(mv_par05))
		cCondicao += 'DtoS(C8_VALIDA) <= "'+DtoS(mv_par05)+'".And.'
	EndIf 
		
EndIf


cCondicao += 'Empty(C8_NUMPED)'

oReport:Section(1):SetFilter(cCondicao,IndexKey())
	
TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2") + SC8->C8_FORNECE + SC8->C8_LOJA})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa o CodeBlock com o PrintLine da Sessao 1 toda vez que rodar o oSection1:Init()   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:onPageBreak( { || nPagina++ , nPrinted := 0 , CabecCT(oReport,oSection1,nPagina,cNumCota,cEmail,cTel) })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SC8->(LastRec()))

oSection2:Init()

While !oReport:Cancel() .And. !SC8->(Eof())

	If oReport:Cancel()
		Exit
	EndIf
	
	cCotacao := SC8->C8_NUM  
	cFornece := SC8->C8_FORNECE
	cLoja    := SC8->C8_LOJA   
	cForNome := SC8->C8_FORNOME

	cObs01   := " "
	cObs02   := " "
	cObs03   := " "
	cObs04   := " "
	nLinObs  := 0
	nItem    := 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Dispara a cabec especifica do relatorio.                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:EndPage()

	nPagina  := 0
	nPrinted := 0

	If Empty(cFornece)
		dbSelectArea("SC8")
		dbSetOrder(8)
		Dbseek(xFilial("SC8")+cCotacao+cFornece+cLoja+cForNome)
		bFor:={||!SC8->(Eof()) .And. SC8->(C8_FILIAL+C8_NUM+C8_FORNECE+C8_LOJA+C8_FORNOME) == xFilial("SC8")+cCotacao+cFornece+cLoja+cForNome}
	else
		dbSelectArea("SC8")
		dbSetOrder(1)
		Dbseek(xFilial("SC8")+cCotacao+cFornece+cLoja)
		bFor:={||!SC8->(Eof()) .And. SC8->(C8_FILIAL+C8_NUM+C8_FORNECE+C8_LOJA) == xFilial("SC8")+cCotacao+cFornece+cLoja}
	EndIf
		
	While !oReport:Cancel() .And. Eval(bFor)
		
		If oReport:Cancel()
			Exit
		EndIf

		cContato := If(lLGPD,RetTxtLGPD(SC8->C8_CONTATO,"C8_CONTATO"),SC8->C8_CONTATO)
		dEmissao := SC8->C8_EMISSAO

		oReport:IncMeter() 
		If oReport:Row() > oReport:LineHeight() * 100
			oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, 2290 )
			oReport:SkipLine()
			oReport:PrintText(STR0015,, 050 ) // Continua ....
			oReport:EndPage()
		EndIf

		cDescPro := ""
		dbSelectArea("SA5")
		dbSetOrder(1)
		If dbSeek(xFilial("SA5") + SC8->C8_FORNECE + SC8->C8_LOJA + SC8->C8_PRODUTO ) ;
			.And. AllTrim(mv_par06) == "A5_NOMPROD"
			cDescPro := Alltrim(A5_NOMPROD)
		EndIf
		dbSelectArea("SC8")
		If Empty(cDescPro)
			ImpDescr(@cDescPro,.T.)
		EndIf
		cFilEnt := SC8->C8_FILENT
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializacao da Observacao da Cotacao                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !EMPTY(SC8->C8_OBS) .And. nLinObs < 5
			nLinObs++
			cVar:="cObs"+StrZero(nLinObs,2)
			Eval(MemVarBlock(cVar),SC8->C8_OBS)
		Endif

		oSection2:PrintLine()
		nPrinted ++
		If !Empty(SA5->A5_CODPRF)
			oReport:PrintText( Replicate("_",Iif(cPaisLoc<>"PER",Len(STR0034),Len(STR0040))), oReport:Row(), oSection2:Cell("CDADOS"):ColPos() )  //"Val.Unitario    Valor Total    IPI   Valor do IPI  Prz(dias)"
			oReport:PrintText( SA5->A5_CODPRF,oReport:Row(),oSection2:Cell("C8_PRODUTO"):ColPos() )
			oReport:SkipLine()
  		Else
			oReport:PrintText( Replicate("_",Iif(cPaisLoc<>"PER",Len(STR0034),Len(STR0040))),, oSection2:Cell("CDADOS"):ColPos() )  //"Val.Unitario    Valor Total    IPI   Valor do IPI  Prz(dias)"
		EndIf
		nPrinted ++

		dbSelectArea("SC8")
		dbSkip()
	EndDo

	oReport:SkipLine()
	
	If nLinObs > 0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Inicializar campos de Observacoes.                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty(cObs02)
			If Len(cObs01) > 50
				cObs 	:= cObs01
				cObs01:= Substr(cObs,1,50)
				For nX := 2 To 4
					cVar  := "cObs"+StrZero(nX,2)
					&cVar := Substr(cObs,(50*(nX-1))+1,50)
				Next
			EndIf
		Else
			cObs01:= Substr(cObs01,1,IIf(Len(cObs01)<50,Len(cObs01),50))
			cObs02:= Substr(cObs02,1,IIf(Len(cObs02)<50,Len(cObs01),50))
			cObs03:= Substr(cObs03,1,IIf(Len(cObs03)<50,Len(cObs01),50))
			cObs04:= Substr(cObs04,1,IIf(Len(cObs04)<50,Len(cObs01),50))
		EndIf
	EndIf

	If oReport:Row() > oReport:LineHeight() * 70

		dbSelectArea("SC8")
		dbSkip(-1)  // condicao onde ja imprimiu tudo mas o rodape sera' impresso em nova pagina
			
		oReport:Box( oReport:Row(),010,oReport:Row() + oReport:LineHeight() * 3, 2290 )
		oReport:SkipLine()
		oReport:PrintText(STR0015,, 050 ) // Continua ....
			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Dispara a cabec especifica do relatorio.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:EndPage()
			
		oSection2:Cell("ITEM"):Hide()
		oSection2:Cell("C8_PRODUTO"):Hide()
		oSection2:Cell("DESCPROD"):Hide()
		oSection2:Cell("C8_QUANT"):Hide()
		oSection2:Cell("C8_UM"):Hide()
		oSection2:Cell("CDADOS"):Hide()
		oSection2:Cell("C8_DATPRF"):Hide()
		oSection2:PrintLine()
		oSection2:Cell("ITEM"):Show()
		oSection2:Cell("C8_PRODUTO"):Show()
		oSection2:Cell("DESCPROD"):Show()
		oSection2:Cell("C8_QUANT"):Show()
		oSection2:Cell("C8_UM"):Show()
		oSection2:Cell("CDADOS"):Show()
		oSection2:Cell("C8_DATPRF"):Show()
		
		dbSelectArea("SC8")
		dbSkip()
			
	EndIf
	
	if oReport:getorientation() == 1 //retrato
	
		nPaisag:= 0
	
	else
		nPaisag:= 700
	endif

	oReport:Box( 2480-nPaisag ,  010 , 3012-nPaisag , 2290 ) // Box do rodape'

	oReport:Line( 2660-nPaisag,  010 , 2660-nPaisag , 2290 ) // Completa o Box Observacoes
	oReport:Line( 2660-nPaisag,  840 , 3012-nPaisag ,  840 ) // Completa o Box do Local de Entrega
	oReport:Line( 2660-nPaisag, 1600 , 3012-nPaisag , 1600 ) // Completa o Box do Sub Total

	oReport:Line( 2870-nPaisag , 010 , 2870-nPaisag , 2290 ) // Completa o Box da Alcada

    oReport:PrintText(" ",2490-nPaisag,020)	// Necessario para posicionar Row() para a impressao do Rodape
    
    oReport:PrintText(STR0032,,020)  //Observacoes :
	oReport:PrintText(cObs01,,020 )
	oReport:PrintText(cObs02,,020 )
	oReport:PrintText(cObs03,,020 )
	oReport:PrintText(cObs04,,020 )
 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acessar o Endereco para Entrega do Arquivo de Empresa SM0.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SM0")
	dbSetOrder(1)   && forca o indice na ordem certa
	nRegistro := Recno()
	MsSeek(SUBS(cNumEmp,1,2)+CFilEnt)

	oReport:SkipLine()
	oReport:PrintText( + STR0018,oReport:Row(),  020 ) //"Local de Entrega:"
	oReport:PrintText( + STR0019,oReport:Row(),  850 ) //"Sub Total"
	oReport:PrintText( + STR0020,oReport:Row(), 1610 ) //"Condicao de Pagamento"
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Imprime o End de Entrega do SM0 somente quando cEndEnt  == " "     ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(cEndEnt)
		cEnd := If( Empty(SM0->M0_ENDENT), " O mesmo ", SM0->M0_ENDENT)
	Else
		cEnd := cEndEnt // imprime o endereco digitado na pergunte
	Endif
	Go nRegistro

	oReport:SkipLine()
	oReport:PrintText( + cEnd	,oReport:Row(), 020 )
	oReport:PrintText( + STR0021,oReport:Row(), 850 ) //"Descontos "

	oReport:SkipLine()
	oReport:PrintText( + STR0022,oReport:Row(), 020 ) //"Local de Cobranca:"
	oReport:PrintText( + Iif(cPaisLoc<>"PER",STR0023,STR0039),oReport:Row(), 850 ) //"Total do IPI"

	cEnd := If(Empty(SM0->M0_ENDCOB),Iif(Empty(SM0->M0_ENDENT),"O mesmo",SM0->M0_ENDENT),SM0->M0_ENDCOB)
	oReport:SkipLine()
	oReport:PrintText( + cEnd	,oReport:Row(),  020 )
	oReport:PrintText( + STR0024,oReport:Row(),  850 )	 //"Frete"
	oReport:PrintText( + STR0025,oReport:Row(), 1610 )	 //"Condicao de Reajuste"

	oReport:SkipLine()
	oReport:PrintText( + STR0026,oReport:Row(),  020 )	 //"Contato no Fornecedor"

	oReport:SkipLine()
	oReport:PrintText( + cContato ,oReport:Row(),  020 )
	oReport:PrintText( + STR0027+Replicate(".",11)  ,oReport:Row(),  850 )	 //"TOTAL DO PEDIDO"
	oReport:Line( oReport:Row(), 840 , oReport:Row(), 1600 ) // Linha do Total do Pedido

	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText( + STR0028,oReport:Row(),  020 )	 //"Alcada 1"
	oReport:PrintText( + STR0029,oReport:Row(),  850 )	 //"Alcada 2"
	oReport:PrintText( + STR0030 +" "+Dtoc(dEmissao) ,oReport:Row(), 1610)	 //"Emitido em :"

	dbSelectArea("SC8")

Enddo
oSection2:Finish()

dbSelectArea("SC8")
Set Filter To
dbSetOrder(1)

Return NIL           

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImpValores³ Autor ³ Jose Lucas            ³ Data ³ 19.07.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir Valores da Cotacao.	  							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpValores(Void) 		                        		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 					                    					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpValores()

dbSelectArea("SC8")

If nSegundaUnid == 2 .And. !Empty(SC8->C8_QTSEGUM)
	@li, 52 PSAY  SC8->C8_QTSEGUM Picture "99999999.99"
	@li, 64 PSAY  SC8->C8_SEGUM
Else
	@li, 52 PSAY  SC8->C8_QUANT Picture "99999999.99"
	@li, 64 PSAY  SC8->C8_UM
Endif

@li,119 PSAY  STR0031	//"dias"
@li,124 PSAY  SC8->C8_DATPRF
li++

dbSelectArea("SC8")
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpDescr ³ Autor ³ Jose Lucas            ³ Data ³ 19.07.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Montagem e Impressao(R3) da descricao do Produto.	 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpDescr(ExpC1,ExpL1)	                     			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = var. para ser atualizada com a descricao do produto³±±
±±³          ³ ExpL1 = Se .T. = chamado do relatorio Release 4			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR150                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpDescr(cDescri,lTReport)

Local nBegin  := 0
Local nLinha  := 0

DEFAULT cDescri   := ""
DEFAULT lTReport  := .F.

If Empty(mv_par06)
	mv_par06 := "B1_DESC"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao cientifica do Produto.                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim(mv_par06) == "B5_CEME"
	dbSelectArea("SB5")
	dbSetOrder(1)
	If dbSeek(xFilial("SB5")+SC8->C8_PRODUTO)
		cDescri := Alltrim(B5_CEME)
	EndIf
ElseIf AllTrim(mv_par06) == "A5_NOMPROD" .And. !lTReport
	dbSelectArea("SA5")
	dbSetOrder(1)
	If dbSeek(xFilial("SA5")+SC8->C8_FORNECE+SC8->C8_LOJA+SC8->C8_PRODUTO)
		cDescri := Alltrim(A5_NOMPROD)
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao do produto do arquivo de Cotacoes.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If AllTrim(mv_par06) == "C1_DESCRI"
	dbSelectArea("SC1")
	dbSetOrder(1)
	If dbSeek(xFilial("SC1")+SC8->C8_NUMSC+SC8->C8_ITEMSC)
		cDescri := Alltrim(C1_DESCRI)
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao do Produto SB1.		         		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SB1")
dbSeek(xFilial("SB1")+SC8->C8_PRODUTO)
If Empty(cDescri)
	cDescri := Alltrim(B1_DESC)
EndIf

dbSelectArea("SC8")

If !lTReport
	nLinha:= MLCount(cDescri,30)
	@ li,021 PSAY MemoLine(cDescri,30,1)
	ImpValores()
	For nBegin := 2 To nLinha
		@ li,021 PSAY Memoline(cDescri,30,nBegin)
	    If nBegin == 2
	    	@ li,067 PSAY Replicate("-",51)
	    EndIf
	    li++
	Next nBegin

	dbSelectArea("SA5")
	dbSetOrder(2)
	If dbSeek(xFilial("SA5")+SC8->C8_PRODUTO+SC8->C8_FORNECE+SC8->C8_LOJA)
		If !Empty(SA5->A5_CODPRF)
			@li,3 PSAY Alltrim(SA5->A5_CODPRF)
		EndIf
	Endif
	
	If nLinha < 2
	   	@ li,067 PSAY Replicate("-",51)
	EndIf
EndIf
	
Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CabecCT   ³ Autor ³ Ricardo Berti		    ³ Data ³31/07/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao do Cotacao                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ CabecCT(ExpO1,ExpO2,ExpN1,ExpC1)	                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oReport                      	              ³±±
±±³          ³ ExpO2 = Objeto da secao1 com o cabec                       ³±±
±±³          ³ ExpN2 = Numero de Pagina                                   ³±±
±±³          ³ ExpC1 = Numero da Cotacao                                  ³±±
±±³          ³ ExpC2 = email                                              ³±±
±±³          ³ ExpC3 = telefone                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CabecCT(oReport,oSection1,nPagina,cNumCota,cEmail,cTel)
Local aTamSXG  := TamSXG("001")
Local cStrlin  := "" // linha a ser impressa com bairro + municipio+ estado	

Default cNumCota := ""

oSection1:Init()

oReport:Box(  010 , 010 , 380 , 2290 )  // Boxes do cabecalho
oReport:Line( 010 , 840 , 380 , 0840 )

oReport:PrintText( If(nPagina > 1,("- "+STR0017)," "),,020 )	  	//"Continuacao"
oReport:PrintText( + STR0006 + SC8->C8_NUM + Space(20) + ; 	// "COTACAO N. "
	STR0007 + DTOC(SC8->C8_VALIDA) + Space(20) + STR0035 + StrZero(nPagina,4),,940)  //" Vencimento "###"Pagina  "

oSection1:PrintLine()

oReport:PrintText(STR0005,120,020) // "PREZADOS SENHORES."

If Alltrim(SA2->A2_NOME) <> ""
	
	oReport:PrintText(SubStr(;
	If(lLGPD,RetTxtLGPD(SA2->A2_NOME,"A2_NOME"),SA2->A2_NOME),;
	1,If(aTamSXG[1] != aTamSXG[3],25,40))+" ("+SA2->A2_COD+" - "+SA2->A2_LOJA+")",120,020)
	
	oReport:PrintText(STR0008,120,890) //"Por favor queira referenciar este numero para quaisquer troca de"
	
	oReport:PrintText(;
	If(lLGPD,RetTxtLGPD(SA2->A2_END,"A2_END"),SA2->A2_END),;
	150,020)
	
	oReport:PrintText(STR0009,150,890) //"informacoes referentes a esta cotacao."
	
	cStrlin := AllTrim(;
	If(lLGPD,RetTxtLGPD(SA2->A2_BAIRRO,"A2_BAIRRO"),SA2->A2_BAIRRO);
	) + "  " + Alltrim(;
	If(lLGPD,RetTxtLGPD(SA2->A2_MUN,"A2_MUN"),SA2->A2_MUN);
	) + " - " + AllTrim(;
	If(lLGPD,RetTxtLGPD(SA2->A2_EST,"A2_EST"),SA2->A2_EST))
	
	oReport:PrintText(Alltrim(Substr(cStrlin,1,57)),180,020)
	oReport:PrintText(Space(30) + STR0011,180,890) //"Atenciosamente."
	
	oReport:PrintText(Alltrim(Substr(cStrlin,58,57)),210,020)
	oReport:PrintText(SM0->M0_NOMECOM,210,890)
	
	oReport:PrintText(STR0010 + ;
	If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD)+" " + ;
	If(lLGPD,RetTxtLGPD(SA2->A2_TEL,"A2_TEL"),SA2->A2_TEL),;
	240,020) //"Fone: "
	
	oReport:PrintText(If(Empty(MV_PAR07), If(Empty(SM0->M0_ENDENT),SM0->M0_ENDCOB,SM0->M0_ENDENT),MV_PAR07),240,890)
	
	oReport:PrintText(STR0012 + ;
	If(lLGPD,RetTxtLGPD(SA2->A2_DDD,"A2_DDD"),SA2->A2_DDD)+;
	" " + ;
	If(lLGPD,RetTxtLGPD(SA2->A2_FAX,"A2_FAX"),SA2->A2_FAX),;
	270,020) //"Fax : "
	
	oReport:PrintText(If(Empty(MV_PAR08), If(Empty(SM0->M0_CIDENT+SM0->M0_ESTENT), SM0->M0_CIDCOB + " " + SM0->M0_ESTCOB,  SM0->M0_CIDENT + " " + SM0->M0_ESTENT),MV_PAR08),270,890)
Else
	
	oReport:PrintText(SubStr(;
	If(lLGPD,RetTxtLGPD(SC8->C8_FORNOME,"C8_FORNOME"),SC8->C8_FORNOME),;
	1,If(aTamSXG[1] != aTamSXG[3],25,40)),120,020)
	
	oReport:PrintText(STR0008,120,890) //"Por favor queira referenciar este numero para quaisquer troca de"
	
	oReport:PrintText(STR0033 + ;
	If(lLGPD,RetTxtLGPD(SC8->C8_FORMAIL,"C8_FORMAIL"),SC8->C8_FORMAIL),;
	150,020)
		
	oReport:PrintText(STR0009,150,890) //"informacoes referentes a esta cotacao."
	
	oReport:PrintText(Alltrim(Substr(cStrlin,1,57)),180,020)
	oReport:PrintText(Space(30) + STR0011,180,890) //"Atenciosamente."
	
	oReport:PrintText(Alltrim(Substr(cStrlin,58,57)),210,020)
	oReport:PrintText(SM0->M0_NOMECOM,210,890)
		
	oReport:PrintText(If(Empty(MV_PAR07), If(Empty(SM0->M0_ENDENT),SM0->M0_ENDCOB,SM0->M0_ENDENT),MV_PAR07),240,890)
	
	oReport:PrintText(If(Empty(MV_PAR08), If(Empty(SM0->M0_CIDENT+SM0->M0_ESTENT), SM0->M0_CIDCOB + " " + SM0->M0_ESTCOB,  SM0->M0_CIDENT + " " + SM0->M0_ESTENT),MV_PAR08),270,890)

EndIf
oReport:PrintText(STR0013,300,020) //"Solicitamos de V Sas. cotacao de precos para os produtos"
oReport:PrintText(STR0010 + If(Empty(cTel), SM0->M0_TEL, cTel)+ "   " + STR0012 + If(Empty(MV_PAR09), SM0->M0_FAX, MV_PAR09),300,890) //"Fone: "### //"Fax : "

oReport:PrintText(STR0014,330,020) //"discriminados conforme os padroes abaixo estabelecidos:"
oReport:PrintText(STR0033 + " " + cEmail,330,890) //"E-mail :" 

oReport:PrintText(Space(10),360,020)

oSection1:PrintLine()
oReport:SkipLine()

oSection1:Finish()

Return NIL
