/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr575.ch"
#Include "Protheus.ch"
#include "ap5mail.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR575

Relatorio de Convocacao dos funcionarios participantes do Programa de Saude

@author  Denis Hyroshi de Souza
@since   02/04/2003

@return  NIL, Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR575()

	Local aNGBEGINPRM := NGBEGINPRM() // Armazena variaveis p/ devolucao (NGRIGHTCLICK)

	Private cCliMdtPs

	cPerg := "MDT575    "
	nSizeSA2 := If((TAMSX3("A2_COD")[1]) < 1,6,(TAMSX3("A2_COD")[1]))

	lFirst   := .t.

	lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

	cAlias   := "CTT"
	cDescr   := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cF3CC    := "CTT002"  // CTT apenas do cliente
	cCodCC   := "CTT_CUSTO"

	If !MDTRESTRI(cPrograma)
		NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)
		Return .F.
	Endif

	If lSigaMdtps
		/* Perguntas
		+--------------------------------------------+
		|           01      ¦Cliente ?               |
		|           02      ¦Loja                    |
		|MDT575    ¦03      ¦Tipo Impressao ?        |
		|MDT575    ¦04      ¦Programa de Saude ?     |
		|MDT575    ¦05      ¦Fornecedor ?            |
		|MDT575    ¦06      ¦Local ?                 |
		|MDT575    ¦07      ¦Motivo ?                |
		|MDT575    ¦08      ¦Medico ?                |
		|MDT575    ¦09      ¦Periodo De ?            |
		|MDT575    ¦10      ¦Periodo Ate ?           |
		|MDT575    ¦11      ¦Relatorio ?             |
		|MDT575    ¦12      ¦Termo de Respons. ?     |
		|MDT575    ¦13      ¦De Centro de Custo ?    |
		|MDT575    ¦14      ¦Ate Centro de Custo ?   |
		|MDT575    ¦15      ¦Calendario ?            |
		|MDT575    ¦16      ¦Dt. Inicio ?            |
		|MDT575    ¦17      ¦Hr. Inicio ?            |
		|MDT575    ¦18      ¦Incremento(min) ?       |
		+--------------------------------------------+ */

		cPerg    :=  "MDT575PS  "

		If pergunte(cPerg,.t.)
			If Empty(mv_par16) .or. Empty(mv_par17) .or. Empty(mv_par18)
				msgstop(STR0023) //"Os parâmetros Data, Hora e Incremento são obrigatórios"
				U_mdtr575()
				Return
			EndIf
			If mv_par03 == 3
				If !U_MDT575MAIL()
					Return
				EndIf
			Else
				U_MDT575IMP()
			EndIf
		Endif

	Else
		/* Perguntas
		+--------------------------------------------+
		|MDT575    ¦01      ¦Tipo Impressao ?        |
		|MDT575    ¦02      ¦Programa de Saude ?     |
		|MDT575    ¦03      ¦Fornecedor ?            |
		|MDT575    ¦04      ¦Local ?                 |
		|MDT575    ¦05      ¦Motivo ?                |
		|MDT575    ¦06      ¦Medico ?                |
		|MDT575    ¦07      ¦Periodo De ?            |
		|MDT575    ¦08      ¦Periodo Ate ?           |
		|MDT575    ¦09      ¦Relatorio ?             |
		|MDT575    ¦10      ¦Termo de Respons. ?     |
		|MDT575    ¦11      ¦De Centro de Custo ?    |
		|MDT575    ¦12      ¦Ate Centro de Custo ?   |
		|MDT575    ¦13      ¦Calendario ?            |
		|MDT575    ¦14      ¦Dt. Inicio ?            |
		|MDT575    ¦15      ¦Hr. Inicio ?            |
		|MDT575    ¦16      ¦Incremento(min) ?       |
		+--------------------------------------------+ */

		If pergunte(cPerg,.t.)
			If Empty(mv_par14) .or. Empty(mv_par15) .or. Empty(mv_par16)
				msgstop(STR0023) //"Os parâmetros Data, Hora e Incremento são obrigatórios"
				U_mdtr575()
				Return
			EndIf
			If mv_par01 == 3
				If !U_MDT575MAIL()
					Return
				EndIf
			Else
				U_MDT575IMP()
			EndIf
		Endif

	Endif

	NGRETURNPRM(aNGBEGINPRM) // Devolve variaveis armazenadas (NGRIGHTCLICK)

Return NIL

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT575IMP

Chamada do Relatorio

@author  Denis Hyroshi de Souza
@since   02/04/2003

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function MDT575IMP()
	Private lin := 0

	Private oFont09p := TFont():New("Arial",,12,,.T.,,,,.F.,.F.)
	Private oFont10r := TFont():New("Arial",,12,,.F.,,,,.F.,.F.)
	Private oFont10p := TFont():New("Arial",,14,,.T.,,,,.F.,.F.)
	Private oFont11t := TFont():New("Arial",,14,,.F.,,,,.F.,.F.)
	Private oFont11	 := TFont():New("Arial",,14,,.T.,,,,.T.,.T.)
	Private oFont13	 := TFont():New("Arial",,16,,.F.,,,,.F.,.F.)
	Private oFont14	 := TFont():New("Arial",,16,,.T.,,,,.F.,.F.)

	oPrint:= FWMsPrinter():New(OemToAnsi(STR0001)) // "Convocação dos Funcionários do Programa de Saúde"

	// Caso a geracao do relatorio tenha sido cancelado, encerra a funcao
	If oPrint:Canceled() .Or. oPrint:lCanceled
		Return .F.
	EndIf

	oPrint:SetPaperSize ( DMPAPER_ENV_C6 ) // Novo tamanho de folha
	dbSelectArea("TMO")

	If lSigaMdtps

		If mv_par11 == 1  //Modelo individual
			oPrint:SetPortrait() //retrato
		Else  //Coletivo
			oPrint:SetLandScape() //paisagem
		Endif

		oPrint:Setup()

		dUldata := mv_par16
		cUlhora := mv_par17

		aDia := NGMDT_H7(mv_par15)

		If Len(aDia) == 0 .or. Type("aDia") != "A"
			MsgStop(STR0024 + Chr(13) + Chr(13) + ; //"Problema: O calendário selecionado não foi encontrado."
					STR0025 + " '" + mv_par15 + "' " + ; //"Solução: Verificar no cadastro de Calendários se o código"
					STR0026,STR0027) //"existe na tabela. Caso não exista, cadastrá-lo."###"ATENÇÃO"
			Return .f.
		Endif

		If Mv_par11 == 1
			U_INDMDT575(oPrint)
		Else
			U_COLMDT575(oPrint)
		Endif

		If Mv_par03 = 1
			oPrint:Preview()
		ElseIf Mv_par03 == 2
			oPrint:Print()
		Else
			Return
		Endif

	Else

		If mv_par09 == 1  // Modelo individual
			oPrint:SetPortrait() // Retrato
		Else  // Coletivo
			oPrint:SetLandScape() // Paisagem
		EndIf

		dUldata := mv_par14
		cUlhora := mv_par15

		aDia := NGMDT_H7(mv_par13)

		If Len(aDia) == 0 .or. Type("aDia") != "A"
			MsgStop(STR0024 + Chr(13) + Chr(13) + ; //"Problema: O calendário selecionado não foi encontrado."
					STR0025 + " '" + mv_par13 + "' " + ; //"Solução: Verificar no cadastro de Calendários se o código"
					STR0026,STR0027) //"existe na tabela. Caso não exista, cadastrá-lo."###"ATENÇÃO"
			Return .F.
		Endif

		If Mv_par09 == 1
			U_INDMDT575(oPrint)
		Else
			U_COLMDT575(oPrint)
		Endif

		If Mv_par01 = 1
			oPrint:Preview()
		ElseIf Mv_par01 == 2
			oPrint:Print()
		Else
			Return
		Endif

	Endif

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} INDMDT575

Modelo Individual

@author  Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_INDMDT575(oPrint)

@param   oPrint, Objeto, Objeto para visualizacao e impressao do relatorio

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function INDMDT575(oPrint)
	Local _Crm,nCGC,cCGCCOM,cCGCSEM,cEndUsu := space(5),cTelUsu := space(5)
	Local aAreaTM5
	Local nY

	lin := 250

	oPrint:SetMargin(20, 20, 20, 20)

	Dbselectarea("TMN")
	Dbsetorder(01)
	Dbseek(xFilial("TMN")+Mv_par02,.t.)

	While !Eof() .And. xFilial("TMN") == TMN->TMN_FILIAL .And. TMN->TMN_CODPRO == Mv_par02
		oPrint:StartPage()

		dbSelectArea("TMS")
		dbSetOrder(1)
		dbSeek(xFilial("TMS")+Mv_par05)
		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek(xFilial("TM0")+TMN->TMN_NUMFIC)
		dbSelectArea("TMO")
		dbSetOrder(1)
		dbSeek(xFilial("TMO")+Mv_par02)
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA")+TM0->TM0_MAT)
		dbSelectArea(cAlias)
		dbSetOrder(1)
		dbSeek(xFilial(cAlias)+SRA->RA_CC)
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+Mv_par03)
		dbSelectArea("TMZ")
		dbSetOrder(1)
		dbSeek(xFilial("TMZ")+mv_par10)
		dbSelectArea("TMK")
		dbSetOrder(1)
		dbSeek(xFilial("TMK")+Mv_par06)

		If SRA->RA_CC < mv_par11 .Or. SRA->RA_CC > mv_par12
			dbSelectArea("TMN")
			dbSkip()
			Loop
		EndIf

		_Crm := If(Empty(TMK->TMK_ENTCLA),"CRM:",Alltrim(TMK->TMK_ENTCLA)+":")
		cTelUsu := TMK->TMK_TELUSU
		cEndUsu := TMK->TMK_ENDUSU

		nCGC    := SM0->M0_TPINSC
		cCGCCOM := alltrim(Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))
		cCGCSEM := SM0->M0_CGC

		oPrint:Box(560, 50, 2750, 2150)

		lin := 250

		oPrint:Say(lin,60,STR0028,oFont14) //"CONVOCAMOS FUNCIONÁRIO"
		oPrint:Say(lin+70,60,STR0029+AllTrim(TMO->TMO_NOMPRO),oFont14) //"DO PROGRAMA DE SAÚDE - "

		oPrint:Say(lin+140,60,STR0030,oFont14) //"REFERENTE:"
		oPrint:Say(lin+140,400,Alltrim(TMS->TMS_NOMOTI),oFont13)
		oPrint:Say(lin+140,1060,STR0031,oFont14) //"TIPO:"
		If TMO->TMO_TIPO != "2"
			oPrint:Say(lin+140,1300,STR0032,oFont13) //"OCUPACIONAL"
		Else
			oPrint:Say(lin+140,1300,STR0033,oFont13) //"QUALIDADE DE VIDA"
		Endif
		oPrint:Say(lin+210,60,STR0034,oFont14)            //"PERÍODO:"
		oPrint:Say(lin+210,380,STR0035+Dtoc(Mv_par07)+STR0036+Dtoc(Mv_par08),oFont13)	 //"DE "###" ATÉ "

		lin := 560

		oPrint:Say(lin+30,60,STR0038,oFont11) //"EMPRESA"
		oPrint:Line(lin+45,50,lin+45,2150)
		oPrint:Say(lin+80,60,STR0039,oFont10p) //"Nome:"
		oPrint:Say(lin+80,350,Alltrim(SM0->M0_NOMECOM),oFont10r)
		oPrint:Say(lin+120,60,STR0040,oFont10p) //"Endereço:"
		oPrint:Say(lin+120,350,Alltrim(SM0->M0_ENDCOB),oFont10r)
		oPrint:Line(lin+45,1350,lin+180,1350) //Divide em 2 colunas
		oPrint:Say(lin+80,1360,If(nCGC == 1,STR0062,If(nCGC == 4,STR0063,If(nCGC == 3,STR0041,STR0042)))+":",oFont10p) //"CEI"###"NT"###"CPF"###"CNPJ"
		oPrint:Say(lin+80,1675,If(nCGC == 2,cCGCCOM,cCGCSEM),oFont10r)
		oPrint:Say(lin+120,1360,STR0043,oFont10p) //"Emissão:"
		oPrint:Say(lin+120,1675,dToc(Date())+"   "+Time(),oFont10r)
		oPrint:Line(lin+180,50,lin+180,2150)

		oPrint:Say(lin+210,60,STR0044,oFont11) //"FUNCIONÁRIO"
		oPrint:Line(lin+225,50,lin+225,2150)
		oPrint:Say(lin+260,60,STR0045,oFont10p) //"Data:"
		oPrint:Say(lin+260,1360,STR0046,oFont10p) //"Hora:"

		If !U_INCDTHORA()
			Return
		EndIf

		oPrint:Say(lin+260,350,DTOC(dUldata) ,oFont10r)
		oPrint:Say(lin+260,1675,cUlhora ,oFont10r)

		lin+=40
		oPrint:Say(lin+260,60,STR0039,oFont10p)      //"Nome:"
		oPrint:Say(lin+260,350,Alltrim(TM0->TM0_NOMFIC),oFont10r)
		oPrint:Say(lin+300,60,STR0047,oFont10p)      //"Matrícula:"
		oPrint:Say(lin+300,350,TM0->TM0_MAT,oFont10r)
		oPrint:Say(lin+300,600,STR0048,oFont10p)     //"Ficha Médica:"
		oPrint:Say(lin+300,850,TMN->TMN_NUMFIC,oFont10r)
		oPrint:Say(lin+340,60,STR0049,oFont10p)      //"Iníc Prog. Saúde:"
		oPrint:Say(lin+340,350,Dtoc(TMN->TMN_DTINIC),oFont10r)
		oPrint:Say(lin+380,60,STR0050,oFont10p)      //"R.G.:"
		oPrint:Say(lin+380,350,TM0->TM0_RG,oFont10r)

		oPrint:Line(lin+185,1350,lin+440,1350)       //Divide em 2 colunas
		oPrint:Say(lin+260,1360,STR0051,oFont10p)    //"Função:"
		oPrint:Say(lin+260,1675,Alltrim(SRJ->RJ_DESC),oFont10r)
		oPrint:Say(lin+300,1360,STR0052,oFont10p)	 //"Centro de Custo:"
		oPrint:Say(lin+300,1675,SubStr(&cDescr,1,30),oFont10r)
		oPrint:Say(lin+340,1360,STR0053,oFont10p)    //"Data de Admissão:"
		oPrint:Say(lin+340,1675,Dtoc(SRA->RA_ADMISSA),oFont10r)
		oPrint:Say(lin+380,1360,STR0054,oFont10p)     //"Data de Nascimento:"
		oPrint:Say(lin+380,1675,DtoC(TM0->TM0_DTNASC)+"    "+U_R575ID(TM0->TM0_DTNASC)+STR0055,oFont10r) //" anos"
		oPrint:Line(lin+440,50,lin+440,2150)

		oPrint:Say(lin+470,60,STR0056,oFont11)       //"FORNECEDOR"
		oPrint:Line(lin+485,50,lin+485,2150)
		oPrint:Say(lin+520,60,STR0039,oFont10p) 	 //"Nome:"
		oPrint:Say(lin+520,350,Alltrim(SA2->A2_NOME),oFont10r)
		oPrint:Say(lin+560,60,STR0040,oFont10p)      //"Endereço:"
		oPrint:Say(lin+560,350,ALLTRIM(SA2->A2_END),oFont10r)
		oPrint:Say(lin+600,60,STR0057,oFont10p)      //"Local:"
		oPrint:Say(lin+600,350,Transform(Mv_par04,"@!"),oFont10r)
		oPrint:Line(lin+485,1350,lin+660,1350)       //Divide em 2 colunas
		oPrint:Say(lin+520,1360,STR0058,oFont10p)    //"Bairro:"
		oPrint:Say(lin+520,1675,ALLTRIM(SA2->A2_BAIRRO),oFont10r)
		oPrint:Say(lin+560,1360,STR0059,oFont10p)	 //"Cidade:"
		oPrint:Say(lin+560,1675,Alltrim(SA2->A2_MUN)+If(!Empty(SA2->A2_EST),"-"+SA2->A2_EST,""),oFont10r)
		oPrint:Say(lin+600,1360,STR0060,oFont10p)    //"Telefone:"
		oPrint:Say(lin+600,1675,SA2->A2_TEL,oFont10r)
		oPrint:Line(lin+660,50,lin+660,2150)

		oPrint:Say(lin+690,60,STR0061,oFont11)       //"MÉDICO RESPONSÁVEL"
		oPrint:Line(lin+705,50,lin+705,2150)
		oPrint:Say(lin+740,60,STR0039,oFont10p) 	 //"Nome:"
		oPrint:Say(lin+740,350,Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)),oFont10r)
		oPrint:Say(lin+780,60,_Crm,oFont10p)
		oPrint:Say(lin+780,350,ALLTRIM(TMK->TMK_NUMENT),oFont10r)
		oPrint:Line(lin+705,1350,lin+840,1350)       //Divide em 2 colunas
		oPrint:Say(lin+740,1360,STR0040,oFont10p)    //"Endereço:"
		oPrint:Say(lin+740,1675,cEndUsu,oFont10r)
		oPrint:Say(lin+780,1360,STR0060,oFont10p)	 //"Telefone:"
		oPrint:Say(lin+780,1675,cTelUsu,oFont10r)
		oPrint:Line(lin+840,50,lin+840,2150)

		// Imprime ultimo exame
		aAreaTM5 := TM5->( GetArea() )
		dbSelectArea( "TM5" )
		dbSetOrder( 01 )
		dbSeek( xFilial( "TM5" ) )
		Set Filter To TM5->TM5_FILIAL == xFilial( "TM5" )	.And.;
						TM5->TM5_NUMFIC == TMN->TMN_NUMFIC	.And.;
						!Empty( TM5->TM5_DTRESU )

		dbGoBottom()
		oPrint:Say(lin+880,60,STR0002,oFont10p) //"Último exame: "
		oPrint:Say(lin+880,325, STR0003 + Space(01) + DtoC(TM5->TM5_DTPROG) + Space(10) +; //"Data de programação: xx/xx/xxxx
				STR0004 + Space(01) + DtoC(TM5->TM5_DTRESU), oFont10r) //Data da última realização: xx/xx/xxxx"
		oPrint:Line(lin+910,50,lin+910,2150)

		Set Filter To
		RestArea( aAreaTM5 )

		lin := 1550

		If !Empty(TMZ->TMZ_DESCRI)

			For nY := 1 to mlCount(TMZ->TMZ_DESCRI, 140)
				somalinha(oPrint, 50)
				oPrint:Say(lin+20, 115, MemoLine( TMZ->TMZ_DESCRI, 140 , nY ) , oFont11t, 2000) //Imprime string parcial
			Next nY

		EndIf

		oPrint:EndPage()
		lin := 100
		dbSelectArea("TMN")
		dbSkip()
	EndDo

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} somaLinha

Incrementa a linha e quebra a pagina quando necessario

@author  Jorge Luis Siementkowski
@since   18/06/2018

@sample  somalinha(oPrint, 50)

@param   oPrint, Objeto, Objeto para visualizacao e impressao do relatorio
@param   nLinha, Numerico, Espaco a ser incrementado entre as linhas

@return  .T., Logico
/*/
//-------------------------------------------------------------------
Static Function somaLinha(oPrint, nLinha)

	Default nLinha := 50

	lin += nLinha

	If lin >= 2700
		oPrint:EndPage()
		oPrint:StartPage()

		oPrint:Box(560, 50, 2750, 2150)

		lin := 250
		oPrint:Say(lin,60,STR0065+AllTrim(TMO->TMO_NOMPRO),oFont14) //"CONVOCAMOS OS FUNCIONÁRIOS DO PROGRAMA DE SAÚDE - "

		oPrint:Say(lin+140,60,STR0030,oFont14) //"REFERENTE:"
		oPrint:Say(lin+140,400,Alltrim(TMS->TMS_NOMOTI),oFont13)
		oPrint:Say(lin+140,1060,STR0031,oFont14) //"TIPO:"

		If TMO->TMO_TIPO != "2"
			oPrint:Say(lin+140,1300,STR0032,oFont13) //"OCUPACIONAL"
		Else
			oPrint:Say(lin+140,1300,STR0033,oFont13) //"QUALIDADE DE VIDA"
		EndIf

		oPrint:Say(lin+210,60,STR0034,oFont14)            //"PERÍODO:"
		oPrint:Say(lin+210,380,STR0035+Dtoc(Mv_par07)+STR0036+Dtoc(Mv_par08),oFont13)	 //"DE "###" ATÉ "
		lin := 580
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} COLMDT575

Modelo Coletivo

@author  Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_COLMDT575(oPrint)

@param   oPrint, Objeto, Objeto para visualizacao e impressao do relatorio

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function COLMDT575(oPrint)
	Local _Crm,nCGC,cCGCCOM,cCGCSEM,cEndUsu := space(5),cTelUsu := space(5)
	Local cLinha1 := " ",cLinha2 := " ",cLinha3 := " ",cLinha4 := " "
	Local cLinha5 := " ",cLinha6 := " ",cLinha7 := " ",cLinha8 := " "
	Local lPrint := .t.
	Local aAreaTM5
	lin := 250

	Dbselectarea("TMN")
	Dbsetorder(01)
	Dbseek(xFilial("TMN")+Mv_par02,.t.)
	While !eof() .And. xFilial("TMN") == TMN->TMN_FILIAL .And. TMN->TMN_CODPRO == Mv_par02

		dbSelectArea("TMS")
		dbSetOrder(1)
		dbSeek(xFilial("TMS")+Mv_par05)
		dbSelectArea("TM0")
		dbSetOrder(1)
		dbSeek(xFilial("TM0")+TMN->TMN_NUMFIC)
		dbSelectArea("TMO")
		dbSetOrder(1)
		dbSeek(xFilial("TMO")+Mv_par02)
		dbSelectArea("SRA")
		dbSetOrder(1)
		dbSeek(xFilial("SRA")+TM0->TM0_MAT)
		dbSelectArea(cAlias)
		dbSetOrder(1)
		dbSeek(xFilial(cAlias)+SRA->RA_CC)
		dbSelectArea("SRJ")
		dbSetOrder(1)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+Mv_par03)
		dbSelectArea("TMZ")
		dbSetOrder(1)
		dbSeek(xFilial("TMZ")+mv_par10)
		dbSelectArea("TMK")
		dbSetOrder(1)
		dbSeek(xFilial("TMK")+Mv_par06)

		If SRA->RA_CC < mv_par11 .OR. SRA->RA_CC > mv_par12
			dbSelectArea("TMN")
			dbSkip()
			Loop
		EndIf

		_Crm := If(Empty(TMK->TMK_ENTCLA),"CRM:",Alltrim(TMK->TMK_ENTCLA)+":")
		cTelUsu := TMK->TMK_TELUSU
		cEndUsu := TMK->TMK_ENDUSU

		nCGC    := SM0->M0_TPINSC
		cCGCCOM := alltrim(Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))
		cCGCSEM := SM0->M0_CGC

		If lPrint
			lPrint := .f.
			lin := 250
			oPrint:StartPage()
			oPrint:Say(lin,60,STR0065+AllTrim(TMO->TMO_NOMPRO),oFont14) //"CONVOCAMOS OS FUNCIONÁRIOS DO PROGRAMA DE SAÚDE - "

			oPrint:Say(lin+70,60,STR0030,oFont14) //"REFERENTE:"
			oPrint:Say(lin+70,400,Alltrim(TMS->TMS_NOMOTI),oFont13)
			oPrint:Say(lin+70,1060,STR0031,oFont14) //"TIPO:"
			If TMO->TMO_TIPO != "2"
				oPrint:Say(lin+70,1300,STR0032,oFont13) //"OCUPACIONAL"
			Else
				oPrint:Say(lin+70,1300,STR0033,oFont13) //"QUALIDADE DE VIDA"
			Endif
			oPrint:Say(lin+140,60,STR0034,oFont14)            //"PERÍODO:"
			oPrint:Say(lin+140,380,STR0035+Dtoc(Mv_par07)+STR0036+Dtoc(Mv_par08),oFont13)	 //"DE "###" ATÉ "

			lin := 490
			oPrint:Box(lin,50,1070,2900)

			oPrint:Say(lin+30,60,STR0038,oFont11) //"EMPRESA"
			oPrint:Line(lin+45,50,lin+45,2900)
			oPrint:Say(lin+110,60,STR0039,oFont10p) //"Nome:"
			oPrint:Say(lin+110,325,Alltrim(SM0->M0_NOMECOM),oFont10r)
			oPrint:Say(lin+140,60,STR0040,oFont10p) //"Endereço:"
			oPrint:Say(lin+140,325,Alltrim(SM0->M0_ENDCOB),oFont10r)
			oPrint:Line(lin+45,1605,lin+180,1605) //Divide em 2 colunas
			oPrint:Say(lin+110,1615,If(nCGC == 1,STR0062,If(nCGC == 4,STR0063,If(nCGC == 3,STR0041,STR0042)))+":",oFont10p) //"CEI"###"NT"###"CPF"###"CNPJ"
			oPrint:Say(lin+110,1800,If(nCGC == 2,cCGCCOM,cCGCSEM),oFont10r)
			oPrint:Say(lin+140,1615,STR0043,oFont10p) //"Emissão:"
			oPrint:Say(lin+140,1800,dToc(Date())+"   "+Time(),oFont10r)
			oPrint:Line(lin+180,50,lin+180,2900)

			oPrint:Say(lin+210,60,STR0056,oFont11) //"FORNECEDOR"
			oPrint:Line(lin+225,50,lin+225,2900)
			oPrint:Say(lin+280,60,STR0039,oFont10p) 	 //"Nome:"
			oPrint:Say(lin+280,325,Alltrim(SA2->A2_NOME),oFont10r)
			oPrint:Say(lin+320,60,STR0040,oFont10p)            //"Endereço:"
			oPrint:Say(lin+320,325,ALLTRIM(SA2->A2_END),oFont10r)
			oPrint:Say(lin+360,60,STR0057,oFont10p) //"Local:"
			oPrint:Say(lin+360,325,Transform(Mv_par04,"@!"),oFont10r)
			oPrint:Line(lin+225,1605,lin+400,1605) //Divide em 2 colunas
			oPrint:Say(lin+280,1615,STR0058,oFont10p)                //"Bairro:"
			oPrint:Say(lin+280,1800,ALLTRIM(SA2->A2_BAIRRO),oFont10r)
			oPrint:Say(lin+320,1615,STR0059,oFont10p)	 //"Cidade:"
			oPrint:Say(lin+320,1800,Alltrim(SA2->A2_MUN)+If(!Empty(SA2->A2_EST),"-"+SA2->A2_EST,""),oFont10r)
			oPrint:Say(lin+360,1615,STR0060,oFont10p)    //"Telefone:"
			oPrint:Say(lin+360,1800,SA2->A2_TEL,oFont10r)
			oPrint:Line(lin+400,50,lin+400,2900)

			oPrint:Say(lin+430,60,STR0061,oFont11)      //"MÉDICO RESPONSÁVEL"
			oPrint:Line(lin+445,50,lin+445,2900)
			oPrint:Say(lin+500,60,STR0039,oFont10p) 	//"Nome:"
			oPrint:Say(lin+500,325,Alltrim(SubStr(TMK->TMK_NOMUSU,1,40)),oFont10r)
			oPrint:Say(lin+540,60,_Crm,oFont10p)
			oPrint:Say(lin+540,325,ALLTRIM(TMK->TMK_NUMENT),oFont10r)
			oPrint:Line(lin+445,1605,lin+580,1605)     //Divide em 2 colunas
			oPrint:Say(lin+500,1615,STR0040,oFont10p)  //"Endereço:"
			oPrint:Say(lin+500,1800,cEndUsu,oFont10r)
			oPrint:Say(lin+540,1615,STR0060,oFont10p)  //"Telefone:"
			oPrint:Say(lin+540,1800,cTelUsu,oFont10r)
			lin := 1070

			oPrint:Line(lin,50,lin+170,50)
			oPrint:Line(lin,2900,lin+170,2900)
			cLinha1 := MemoLine(TMZ->TMZ_DESCRI,185,1)
			cLinha2 := MemoLine(TMZ->TMZ_DESCRI,185,2)
			cLinha3 := MemoLine(TMZ->TMZ_DESCRI,185,3)
			cLinha4 := MemoLine(TMZ->TMZ_DESCRI,185,4)
			cLinha5 := MemoLine(TMZ->TMZ_DESCRI,185,5)
			cLinha6 := MemoLine(TMZ->TMZ_DESCRI,185,6)
			cLinha7 := MemoLine(TMZ->TMZ_DESCRI,185,7)
			cLinha8 := MemoLine(TMZ->TMZ_DESCRI,185,8)
			oPrint:Say(lin+40,150,cLinha1,oFont11t)
			oPrint:Say(lin+90,90,cLinha2,oFont11t)
			oPrint:Say(lin+140,90,cLinha3,oFont11t)
			lin += 170
			If !Empty(cLinha4)
				oPrint:Say(lin+20,90,cLinha4,oFont11t)
				oPrint:Line(lin,50,lin+50,50)
				oPrint:Line(lin,2900,lin+50,2900)
				lin += 50
			Endif
			If !Empty(cLinha5)
				oPrint:Say(lin+20,90,cLinha5,oFont11t)
				oPrint:Line(lin,50,lin+50,50)
				oPrint:Line(lin,2900,lin+50,2900)
				lin += 50
			Endif
			If !Empty(cLinha6)
				oPrint:Say(lin+20,90,cLinha6,oFont11t)
				oPrint:Line(lin,50,lin+50,50)
				oPrint:Line(lin,2900,lin+50,2900)
				lin += 50
			Endif
			If !Empty(cLinha7)
				oPrint:Say(lin+20,90,cLinha7,oFont11t)
				oPrint:Line(lin,50,lin+50,50)
				oPrint:Line(lin,2900,lin+50,2900)
				lin += 50
			Endif
			If !Empty(cLinha8)
				oPrint:Say(lin+20,90,cLinha8,oFont11t)
				oPrint:Line(lin,50,lin+50,50)
				oPrint:Line(lin,2900,lin+50,2900)
				lin += 50
			Endif
			oPrint:Line(lin,50,lin,2900)
			lin += 30
			U_F575HEA(oPrint)
		Endif

		U_HEADER575(oPrint)

		If !U_INCDTHORA()
			Return
		EndIf

		oPrint:Line(lin,50,lin+50,50)
		oPrint:Say(lin+30,60,DTOC(dUldata) + " - "  + cUlhora,oFont10r)
		oPrint:Line(lin,330,lin+50,330)
		oPrint:Say(lin+30,340,Alltrim(TMN->TMN_NUMFIC),oFont10r)
		oPrint:Line(lin,590,lin+50,590)
		oPrint:Say(lin+30,600,Substr(Alltrim(TM0->TM0_NOMFIC),1,23),oFont10r)
		oPrint:Line(lin,1110,lin+50,1110)
		oPrint:Say(lin+30,1120,Substr(Alltrim(SRJ->RJ_DESC),1,16),oFont10r)
		oPrint:Line(lin,1590,lin+50,1590)
		oPrint:Say(lin+30,1600,Substr(Alltrim(&cDescr),1,18),oFont10r)
		oPrint:Line(lin,2020,lin+50,2020)
		oPrint:Say(lin+30,2030,Dtoc(TMN->TMN_DTINIC),oFont10r)
		oPrint:Line(lin,2210,lin+50,2210)

		// Imprime ultimo exame
		aAreaTM5 := TM5->( GetArea() )
		dbSelectArea( "TM5" )
		dbSetOrder( 01 )
		dbSeek( xFilial( "TM5" ) )
		Set Filter To TM5->TM5_FILIAL == xFilial( "TM5" )	.And.;
						TM5->TM5_NUMFIC == TMN->TMN_NUMFIC	.And.;
						!Empty( TM5->TM5_DTRESU )

		dbGoBottom()

		oPrint:Say(lin+30,2220,DtoC(TM5->TM5_DTPROG),oFont10r)
		oPrint:Line(lin,2525,lin+50,2525)
		oPrint:Say(lin+30,2535,DtoC(TM5->TM5_DTRESU),oFont10r)
		oPrint:Line(lin,2900,lin+50,2900)

		Set Filter To
		RestArea( aAreaTM5 )

		dbSelectArea("TMN")
		dbSkip()
	End

	If !lPrint
		oPrint:Line(lin+50,50,lin+50,2900)
		oPrint:EndPage()
	Endif

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} R575ID

Calcula a idade do funcionario

@author  Autor Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_R575ID(TM0->TM0_DTNASC)

@param   dNasc, Date, Data de nascimento do funcionario
@param   dFim, Date, Data referencia para calcular a idade, se for nula
                     considera a data atual

@return  Alltrim(Str(nIdade,3)), String, Data do funcionario em formato de string
/*/
//-------------------------------------------------------------------
User Function R575ID(dNasc, dFim)
	Local nIdade := 0

	If dFim == nil
		dFim := Date()
	Endif

	nIdade := Year(dFim) - Year(dNasc)

	If Month(dFim) < Month(dNasc)
		nIdade := nIdade - 1
	Elseif Month(dFim) == Month(dNasc)

		If Day(dFim) < Day(dNasc)
			nIdade := nIdade - 1
		Endif

	Endif

Return Alltrim(Str(nIdade,3))

//-------------------------------------------------------------------
/*/{Protheus.doc} HEADER575

Inicia uma nova pagina com o cabecalho da secao de
exames do Modelo Coletivo

@author  Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_HEADER575(oPrint)

@param   oPrint, Objeto, Objeto para visualizacao e impressao do relatorio

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function HEADER575(oPrint)
	lin += 50

	If lin >= 2400
		oPrint:Line(lin,50,lin,2900)
		lin := 250
		oPrint:EndPage()
		oPrint:StartPage()
		U_F575HEA(oPrint)
		lin += 50
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} F575HEA

Cria o cabecalho da secao de exames do Modelo Coletivo

@author  Denis Hyroshi de Souza
@since   02/04/2003

@sample  U_F575HEA(oPrint)

@param   oPrint, Objeto, Objeto para visualizacao e impressao do relatorio

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function F575HEA(oPrint)
	oPrint:Line(lin,50,lin,2900)
	oPrint:Line(lin,50,lin+80,50)
	oPrint:Say(lin+40,1400,STR0067,oFont11) //"FUNCIONÁRIOS"
	oPrint:Line(lin,2900,lin+80,2900)
	oPrint:Line(lin+80,50,lin+80,2900)
	lin += 80

	oPrint:Line(lin,50,lin,2900)
	oPrint:Line(lin,50,lin+80,50)
	oPrint:Say(lin+30,60,STR0068,oFont09p)  //"DATA - HORA"
	oPrint:Line(lin,330,lin+80,330)
	oPrint:Say(lin+30,340,STR0069,oFont09p)  //"FICHA MÉDICA"
	oPrint:Line(lin,590,lin+80,590)
	oPrint:Say(lin+30,600,STR0070,oFont09p)  //"NOME"
	oPrint:Line(lin,1110,lin+80,1110)
	oPrint:Say(lin+30,1120,STR0071,oFont09p)  //"FUNÇÃO"
	oPrint:Line(lin,1590,lin+80,1590)
	oPrint:Say(lin+30,1600,STR0072,oFont09p)  //"CENTRO DE CUSTO"
	oPrint:Line(lin,2020,lin+80,2020)
	oPrint:Say(lin+25,2030,STR0073,oFont09p)  //"INÍCIO PROG."
	oPrint:Say(lin+65,2030,STR0074,oFont09p) //"   SAÚDE"


	oPrint:Line(lin,2210,lin+80,2210)
	oPrint:Line(lin+42,2210,lin+42,2900)
	oPrint:Say(lin+30,2400,STR0075,oFont09p)  //"ÚLTIMO EXAME"
	oPrint:Say(lin+70,2220,STR0076,oFont09p) //"DATA PROGRAMAÇÃO"
	oPrint:Line(lin+42,2525,lin+80,2525)
	oPrint:Say(lin+70,2535,STR0077,oFont09p)   //"DATA ÚLTIMA REALIZAÇÃO"
	oPrint:Line(lin,2900,lin+80,2900)


	oPrint:Line(lin+80,50,lin+80,2900)
	lin += 30
Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} INC_HORA

Incrementa a data/hora da consulta e verifica se esta dentro do calendario.

@author  Liber De Esteban
@since   20/08/04

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function INCDTHORA()
	Local nConsulta, xyz
	Local lMarca := .t.
	dDttemp := dUldata

	If lSigaMdtps

		Do while lMarca
			lMarca := .f.
			If !lFirst
				cUlhora := MTOH(HTOM(cUlhora) + mv_par18)
			EndIf
			lFirst := .f.
			nConsulta := HTOM(cUlhora) + mv_par18
			If nConsulta >= 1440
				dUldata++
				nDia := If(DOW(dUldata)==1,7,DOW(dUldata)-1) //Dia da Semana 1=Segunda,2=Terca,...,7=Domingo
				cUlhora := aDia[nDia][1]
				nConsulta := HTOM(cUlhora) + mv_par18
			EndIf

			nDia := If(DOW(dUldata)==1,7,DOW(dUldata)-1) //Dia da Semana 1=Segunda,2=Terca,...,7=Domingo

			For xyz := 1 to Len(aDia[nDia][4])
				nOutIni := aDia[nDia][4][xyz][1]
				nOutFim := aDia[nDia][4][xyz][2]
				If (nConsulta > nOutIni .and. (nConsulta - mv_par18) < nOutFim) .or. (nConsulta == 0 .and. nOutIni == 0)
					lMarca := .t.
					Exit
				Endif
			Next xyz
			If ((dUldata - dDttemp) > 7)
				MsgStop(STR0078 + Chr(13) + Chr(13) + ; //"Problema: O calendário selecionado não é válido."
					STR0025 + " '" + mv_par15 + "' " + ; //"Solução: Verificar no cadastro de Calendários se o código"
					STR0079 +; //"existe na tabela. Caso não exista, cadastrá-lo. Caso exista, verificar se "
					STR0080,STR0027) //"os dados do calendário estão corretos"###"ATENÇÃO"
				return .f.
			EndIf
		END

	Else

		Do while lMarca
			lMarca := .f.
			If !lFirst
				cUlhora := MTOH(HTOM(cUlhora) + mv_par16)
			EndIf
			lFirst := .f.
			nConsulta := HTOM(cUlhora) + mv_par16
			If nConsulta >= 1440
				dUldata++
				nDia := If(DOW(dUldata)==1,7,DOW(dUldata)-1) //Dia da Semana 1=Segunda,2=Terca,...,7=Domingo
				cUlhora := aDia[nDia][1]
				nConsulta := HTOM(cUlhora) + mv_par16
			EndIf

			nDia := If(DOW(dUldata)==1,7,DOW(dUldata)-1) //Dia da Semana 1=Segunda,2=Terca,...,7=Domingo

			For xyz := 1 to Len(aDia[nDia][4])
				nOutIni := aDia[nDia][4][xyz][1]
				nOutFim := aDia[nDia][4][xyz][2]
				If (nConsulta > nOutIni .and. (nConsulta - mv_par16) < nOutFim) .or. (nConsulta == 0 .and. nOutIni == 0)
					lMarca := .t.
					Exit
				Endif
			Next xyz
			If ((dUldata - dDttemp) > 7)
				MsgStop(STR0078 + Chr(13) + Chr(13) + ; //"Problema: O calendário selecionado não é válido."
					STR0025 + " '" + mv_par13 + "' " + ; //"Solução: Verificar no cadastro de Calendários se o código"
					STR0079 +; //"existe na tabela. Caso não exista, cadastrá-lo. Caso exista, verificar se "
					STR0080,STR0027) //"os dados do calendário estão corretos"###"ATENÇÃO"
				return .f.
			EndIf
		END

	Endif

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} MDT575MAIL

Envia email do relatorio, conforme parametros definidos no
SX6 e informacoes entradas pelo usuario

@author  Liber De Esteban
@since   30/08/04

@return  .T., Logico
/*/
//-------------------------------------------------------------------
User Function MDT575MAIL()
	Local nI
	Local aUsuario  := "", cTitulo, oDlgMail, cDiretorio:="", nOp:=0, x:=1, cBody:=""
	Local cServer   := AllTrim( GetMV( "MV_RELSERV" , , " " ) )
	Local cAccount  := AllTrim( GetMV( "MV_RELACNT" , , " " ) )
	Local cPassword := AllTrim( GetMV( "MV_RELPSW"  , , " " ) )
	Local cUserAut  := AllTrim( GetMV( "MV_RELAUSR" , , cAccount ) )//Usuário para Autenticação no Servidor de Email
	Local cPassAut  := AllTrim( GetMV( "MV_RELAPSW" , , cPassword ) )//Senha para Autenticação no Servidor de Email
	Local lSmtpAuth := GetMv( "MV_RELAUTH" , , .F. )
	Local cFrom     := cAccount
	Local cAnexos   := ""
	Local cTo       := space(200)
	Local cCC       := space(200)
	Local cSubject  := space(250)
	Local lOk       := .T.
	Local lAutOk    := .F.
	Local aFiles    := {} // Array que irá conter todas as páginas geradas

	//Verifica se existe o SMTP Server
	If 	Empty(cServer)
		MsgStop(STR0081 ,STR0027) //"O Servidor de SMTP não foi configurado !!!"###"Atenção"
		Return .f.
	EndIf

	If lSmtpAuth

		//Verifica se existe a CONTA
		If 	Empty(cAccount)
			Msgstop(STR0082 ,STR0027) //"A Conta do email não foi configurada !!!"###"Atenção"
			Return .f.
		EndIf

		//Verifica se existe a Senha
		If 	Empty(cPassword)
			Msgstop(STR0083 ,STR0027) //"A Senha do email não foi configurada !!!"###"Atenção"
			Return .f.
		EndIf

	EndIf

	PswOrder(1)
	PswSeek(__CUSERID,.T.)
	aUsuario := PswRet(1)
	cTitulo := STR0084 //"Dados do E-mail"

	DEFINE MSDIALOG oDlgMail OF oMainWnd FROM 0,0 TO 200,544 PIXEL TITLE cTitulo

		@ 05,04 To 079,268 OF oDlgMail PIXEL
		@ 18,08 Say STR0085     Size 012,08          OF oDlgMail PIXEL //"De: "
		@ 33,08 Say STR0086    Size 016,08          OF oDlgMail PIXEL //"Para:"
		@ 48,08 Say STR0087      Size 016,08          OF oDlgMail PIXEL //"CC:"
		@ 63,08 Say STR0088 Size 021,08          OF oDlgMail PIXEL //"Assunto:"

		@ 18,33 MSGet cFrom    Size 233,10 When .F. OF oDlgMail PIXEL
		@ 33,33 MSGet cTo      Size 233,10          OF oDlgMail PIXEL
		@ 48,33 MSGet cCC      Size 233,10          OF oDlgMail PIXEL
		@ 63,33 MSGet cSubject Size 233,10          OF oDlgMail PIXEL

		DEFINE SBUTTON FROM 85,100 TYPE 1 ACTION (If(!Empty(cTo),If(oDlgMail:End(),nOp:=1,),Help("",1,"AVG0001054"))) ENABLE OF oDlgMail PIXEL
		DEFINE SBUTTON FROM 85,140 TYPE 2 ACTION (oDlgMail:End()) ENABLE OF oDlgMail PIXEL

	ACTIVATE MSDIALOG oDlgMail CENTERED

	If nOp == 1

	U_MDT575IMP()
	cDiretorio := AllTrim(GetMV("MV_RELT",," "))

	If EMPTY(cDiretorio)
		cDiretorio := "\"
	EndIf

	cPrefixo := cDiretorio+"MDT575_"+DTOS(dDatabase)+"_"+STRZERO(HTOM(time()),4)

	If ! oPrint:SaveAllAsJPEG( cPrefixo,700,1000,110 )  // Irá gravar algo semelhante a: \RELATO\MDT575_20040505_161040_PAG1.JPEG
		MsgStop(STR0089,STR0093) //"Não foi possível gravar o relatório" //"AVISO"
		Return .F.
	EndIf

	cBody  := STR0090 + oPrint:cDocument //"Segue em anexo relatório de "

		// Varre o diretório e procura pelas páginas gravadas.
		aFiles := Directory( cPrefixo+"*.jpg" )

		// Monta um Vetor com o path e nome do arquivo em cada linha para passar via email
		For nI:= 1 to Len(aFiles)
			cAnexos += cDiretorio+aFiles[nI,1] + "; "
		Next nI

		CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword RESULT lOk

			If !lAutOk

				If ( lSmtpAuth )
					lAutOk := MailAuth(cUserAut,cPassAut)
				Else
					lAutOk := .T.
				EndIf

			EndIf

			If lOk .and. lAutOk

				If !Empty(cCC)
					SEND MAIL FROM cFrom TO cTo CC cCC SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
				Else
					SEND MAIL FROM cFrom TO cTo SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
				EndIf

				If lOk
					MsgInfo(STR0091) //"Email enviado com sucesso"
				Else
					GET MAIL ERROR cErro
					MsgStop(STR0092 +Chr(13)+Chr(10)+ cErro,STR0093) //"Não foi possível enviar o Email."###"AVISO"
					Return .f.
				EndIf

			Else
				GET MAIL ERROR cErro
				MsgStop(STR0064 +Chr(13)+Chr(10)+ cErro,STR0093) //"Erro na conexão com o SMTP Server."###"AVISO"
				Return .f.
			EndIf

		DISCONNECT SMTP SERVER

		oPrint:Preview()

	EndIf

Return .T.
