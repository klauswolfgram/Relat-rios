/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp := Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR270  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Totalizador de Cliente						              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAAGR                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AGRR270()
	Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2        := "de acordo com os parametros informados pelo usuario."
	Local cDesc3        := "Totalizador por Cliente"
	Local titulo        := "Totalizador por Cliente"
	Local nLin          := 220
	Local Cabec1        := ""
	Local Cabec2        := ""

	Private aOrd        := {'Cliente+Produto+Safra','Cliente+Armazem+Safra'}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 220
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR270'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR270"
	Private wnrel       := "AGRR270"
	Private cAliasTMP   := ""

	dbSelectArea("NPL")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint('NPL',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NPL')

	If nLastKey == 27
		Return
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

	AGRDLTPTB(oArqTemp)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³RunReport ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ³±±
±±³			 ³ monta a janela com a regua de processamento.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	nOrdem                          
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]
	Local	cDescItem	:=	""
	Local	n0Enbrut	:=	0
	Local	n0Endesc	:=	0
	Local	n0Enextr	:=	0
	Local	n0Entrfs	:=	0
	Local	n0Enliqu	:=	0
	Local	n0Sdbrut	:=	0
	Local	n0Sddesc	:=	0
	Local	n0Sdextr	:=	0
	Local	n0Sdtrfs	:=	0
	Local	n0Sdliqu	:=	0
	Local	n0Saldo		:=	0
	Local	n0Saldo2	:=	0
	Local   nQtdCond0	:=	0

	Local	n1Enbrut	:=	0
	Local	n1Endesc	:=	0
	Local	n1Enextr	:=	0
	Local	n1Entrfs	:=	0
	Local	n1Enliqu	:=	0
	Local	n1Sdbrut	:=	0
	Local	n1Sddesc	:=	0
	Local	n1Sdextr	:=	0
	Local	n1Sdtrfs	:=	0
	Local	n1Sdliqu	:=	0
	Local	n1Saldo		:=	0
	Local	n1Saldo2	:=	0
	Local   nQtdCond1	:=	0

	Local	n2Enbrut	:=	0
	Local	n2Endesc	:=	0
	Local	n2Enextr	:=	0
	Local	n2Entrfs	:=	0
	Local	n2Enliqu	:=	0
	Local	n2Sdbrut	:=	0
	Local	n2Sddesc	:=	0
	Local	n2Sdextr	:=	0
	Local	n2Sdtrfs	:=	0
	Local	n2Sdliqu	:=	0
	Local	n2Saldo		:=	0
	Local	n2Saldo2	:=	0
	Local	nQtdCond2	:=	0

	Local	n3Enbrut	:=	0
	Local	n3Endesc	:=	0
	Local	n3Enextr	:=	0
	Local	n3Entrfs	:=	0
	Local	n3Enliqu	:=	0
	Local	n3Sdbrut	:=	0
	Local	n3Sddesc	:=	0
	Local	n3Sdextr	:=	0
	Local	n3Sdtrfs	:=	0
	Local	n3Sdliqu	:=	0
	Local	n3Saldo		:=	0
	Local	n3Saldo2	:=	0

	//Variaveis para arquivos temporarios
	Local	cChvTMP 	:= ""
	Local	aArqTMP 	:= {}
	Private	cCondWhile	:= ""
	Private	cCondW1		:= ""
	Private	cCond		:=	""
	Private	cCond1		:=	""

	dbSelectArea('NPL')

	titulo	:= 	Alltrim(titulo)

	nOrdem := aReturn[8]

	cFiltro := "NPL_SAFRA  >= '"+MV_PAR01+"' .And. "
	cFiltro += "NPL_SAFRA  <= '"+MV_PAR02+"' .And. "
	cFiltro += "NPL_ARM    >= '"+MV_PAR05+"' .And. "
	cFiltro += "NPL_ARM    <= '"+MV_PAR06+"' .And. "
	//Considera Filiais
	If mv_par11==1
		cFiltro += "NPL_FILIAL    >= '"+MV_PAR12+"' .And. "
		cFiltro += "NPL_FILIAL    <= '"+MV_PAR13+"' .And. "
	Endif
	cFiltro += "NPL_CODCLI >= '"+MV_PAR07+"' .And. "
	cFiltro += "NPL_CODCLI <= '"+MV_PAR08+"'"

	//dbSetFilter( {|| &cFiltro }, cFiltro )

	IndRegua("NPL",CriaTrab(Nil,.F.),IndexKey(),,cFiltro,"Criando Indice...")

	aAdd(aArqTMP,{"TMP_FILIAL","C",002,00})
	aAdd(aArqTMP,{"TMP_CODCLI","C",006,00})
	aAdd(aArqTMP,{"TMP_LOJCLI","C",002,00})
	aAdd(aArqTMP,{"TMP_NOMCLI","C",050,00})
	aAdd(aArqTMP,{"TMP_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"TMP_SAFDES","C",040,00})
	aAdd(aArqTMP,{"TMP_NOMPRO","C",050,00})
	aAdd(aArqTMP,{"TMP_UM    ","C",002,00})
	aAdd(aArqTMP,{"TMP_ARM 	 ","C",002,00})
	aAdd(aArqTMP,{"TMP_NOMARM","C",020,00})
	aAdd(aArqTMP,{"TMP_ENBRUT","N",014,02})
	aAdd(aArqTMP,{"TMP_ENDESC","N",014,02})
	aAdd(aArqTMP,{"TMP_ENEXTR","N",014,02})
	aAdd(aArqTMP,{"TMP_ENLIQU","N",014,02})
	aAdd(aArqTMP,{"TMP_ENTRFS","N",014,02})
	aAdd(aArqTMP,{"TMP_SDBRUT","N",014,02})
	aAdd(aArqTMP,{"TMP_SDDESC","N",014,02})
	aAdd(aArqTMP,{"TMP_SDEXTR","N",014,02})
	aAdd(aArqTMP,{"TMP_SDLIQU","N",014,02})
	aAdd(aArqTMP,{"TMP_SDTRFS","N",014,02})
	aAdd(aArqTMP,{"TMP_SALDO ","N",014,02})

	//Cria tabela temporária
	If nOrdem==1
		cChvTMP := "TMP_CODCLI+TMP_NOMPRO+TMP_SAFRA"
		cCond 	:=	"(cAliasTMP)->tmp_nompro==cCondWhile"
		cCond1 	:=	"(cAliasTMP)->tmp_safra==cCondW1"
	Else
		cChvTMP := "TMP_CODCLI+TMP_NOMARM+TMP_SAFRA"
		cCond 	:=	"(cAliasTMP)->tmp_nomarm==cCondWhile"
		cCond1 	:=	"(cAliasTMP)->tmp_safra==cCondW1"
	EndIf

	cAliasTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", cChvTMP } }} ) 

	DbSelectArea("NPL")
	npl->(DbGoTop())
	While npl->(!Eof())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(Len(Alltrim(cFiltUser))==0).And.!(&cFiltUser)
			npo->(dbSkip())
			Loop
		EndIf		

		cCodPrd	:= Posicione("NN1",1,If(Len(Alltrim(xFilial("NN1")))==0,xFilial("NN1"),npl->npl_filial)+npl->npl_safra,"NN1_CODPRO")
		If  (cCodPrd >= mv_par03 .And. cCodPrd <= mv_par04)	
			DbSelectArea(cAliasTMP)	
			If RecLock(cAliasTMP,.t.)
				Replace (cAliasTMP)->tmp_filial	With	npl->npl_filial
				Replace (cAliasTMP)->tmp_codcli	With	npl->npl_codcli
				Replace (cAliasTMP)->tmp_lojcli	With	npl->npl_lojcli
				Replace (cAliasTMP)->tmp_safra 	With	npl->npl_safra
				Replace (cAliasTMP)->tmp_safdes	With	SubStr(Posicione("NN1",1,If(Len(Alltrim(xFilial("NN1")))==0,xFilial("NN1"),npl->npl_filial)+npl->npl_safra,"NN1_DESCRI"),1,40)
				Replace (cAliasTMP)->tmp_arm 	With	npl->npl_arm
				Replace (cAliasTMP)->tmp_enbrut	With	npl->npl_enbrut
				Replace (cAliasTMP)->tmp_endesc	With	npl->npl_endesc
				Replace (cAliasTMP)->tmp_enextr	With	npl->npl_enextr
				Replace (cAliasTMP)->tmp_enliqu	With	npl->npl_enliqu
				Replace (cAliasTMP)->tmp_entrfs	With	npl->npl_entrfs
				Replace (cAliasTMP)->tmp_sdbrut	With	npl->npl_sdbrut
				Replace (cAliasTMP)->tmp_sddesc	With	npl->npl_sddesc
				Replace	(cAliasTMP)->tmp_sdextr	With	npl->npl_sdextr
				Replace (cAliasTMP)->tmp_sdliqu	With	npl->npl_sdliqu
				Replace (cAliasTMP)->tmp_sdtrfs	With	npl->npl_sdtrfs
				Replace (cAliasTMP)->tmp_saldo	With 	npl->npl_saldo
				Replace (cAliasTMP)->tmp_nomcli	With	SubStr(Posicione("SA1",1,If(Len(Alltrim(xFilial("SA1")))==0,xFilial("SA1"),npl->npl_filial)+npl->npl_codcli+npl->npl_lojcli,"A1_NOME"),1,50)
				Replace (cAliasTMP)->tmp_nompro	With	SubStr(Posicione("SB1",1,If(Len(Alltrim(xFilial("SB1")))==0,xFilial("SB1"),npl->npl_filial)+cCodPrd,"B1_DESC"),1,50)
				Replace (cAliasTMP)->tmp_um		With	Posicione("SB1",1,If(Len(Alltrim(xFilial("SB1")))==0,xFilial("SB1"),npl->npl_filial)+cCodPrd,"B1_UM")
				Replace (cAliasTMP)->tmp_nomarm	With	SubStr(Posicione("NNR",1,If(Len(Alltrim(xFilial("NNR")))==0,xFilial("NNR"),npl->npl_filial)+npl->npl_arm,"NNR_DESCRI"),1,20)
				MsUnLock(cAliasTMP)
			EndIf                                	
		Endif
		dbSelectArea("NPL")
		npl->(dbSkip())
	EndDo

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//Cabec1 := PadL(OemToAnsi("Periodo de "+Dtoc(mv_par02)+" a "+Dtoc(mv_par03)+" - Tipo : "+If(mv_par10==1,"Normal",If(mv_par10==2,"Desc. Extra","Ambos"))),90)
	//Cabec2 	:= 	"          Transf. Produto                          Motivo Transf.         Data             Qtd "+If(Len(Alltrim(mv_par13))=0,"UM",Alltrim(mv_par13))+"      "+If(Len(Alltrim(mv_par14))=0,"Qtd SEGUM",("   Qtd "+Alltrim(mv_par14)))+"  Observacoes"
	Cabec1	:=	"Cliente                                |"+PadC("ENTRADAS",73,"-")+"|"+PadC("SAIDAS",74,"-")+"|"
	Cabec2	:=	"                                       |        Bruto      Descontos    Desp.Extras        Transf.        Liquido|         Bruto      Descontos    Desp.Extras        Transf.        Liquido|       Saldo "+If(Len(Alltrim(mv_par09))>0,Upper(Alltrim(mv_par09)),"UM")+"     "+If(Len(Alltrim(mv_par10))>0,"   Saldo "+Upper(Alltrim(mv_par10)),"Saldo SEGUM")

	DbSelectArea(cAliasTMP)

	SetRegua(RecCount())
	(cAliasTMP)->(Dbgotop())
	While (cAliasTMP)->(!Eof())

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			(cAliasTMP)->(dbSkip())
			Loop
		EndIf	

		If lAbortPrint
			@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		cCodCli		:= (cAliasTMP)->tmp_codcli
		cCliente	:=	(cAliasTMP)->tmp_nomcli

		n1Enbrut	:=	0
		n1Endesc	:=	0
		n1Enextr	:=	0
		n1Entrfs	:=	0
		n1Enliqu	:=	0
		n1Sdbrut	:=	0
		n1Sddesc	:=	0
		n1Sdextr	:=	0
		n1Sdtrfs	:=	0
		n1Sdliqu	:=	0
		n1Saldo		:=	0
		n1Saldo2	:=	0

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		@ nLin,000 PSay Padr(cCodCli,6) + "-" + PadR(cCliente,50)
		nLin++

		While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->tmp_codcli==cCodCli  


			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Armazena a Quantidade de informacoes no totalizador ³
			//³com objetivo de sub-totalizar ou nao a condicao     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nQtdCond1++

			If lAbortPrint
				@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif

			If nOrdem==1
				cCondWhile	:=	(cAliasTMP)->tmp_nompro
				cDescItem	:=	PadR(AllTrim((cAliasTMP)->tmp_nompro),25) 	
			Else
				cCondWhile	:= 	(cAliasTMP)->tmp_nomarm
				cDescItem	:=	PadR(AllTrim((cAliasTMP)->tmp_nomarm),25) 			
			Endif

			n2Enbrut	:=	0
			n2Endesc	:=	0
			n2Enextr	:=	0
			n2Entrfs	:=	0
			n2Enliqu	:=	0
			n2Sdbrut	:=	0
			n2Sddesc	:=	0
			n2Sdextr	:=	0
			n2Sdtrfs	:=	0
			n2Sdliqu	:=	0
			n2Saldo		:=	0
			n2Saldo2	:=	0

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			@ nLin,002 PSay PadR(cDescItem,25)
			nLin++ 		

			While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->tmp_codcli==cCodCli .And. &cCond  			

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Armazena a Quantidade de informacoes no totalizador ³
				//³com objetivo de sub-totalizar ou nao a condicao     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nQtdCond2++

				cCondW1	:= 	(cAliasTMP)->tmp_safra
				@ nLin,004 PSay PadR(AllTrim((cAliasTMP)->tmp_safra)+"-"+AllTrim((cAliasTMP)->tmp_safdes),33)

				n3Enbrut	:=	0
				n3Endesc	:=	0
				n3Enextr	:=	0
				n3Entrfs	:=	0
				n3Enliqu	:=	0
				n3Sdbrut	:=	0
				n3Sddesc	:=	0
				n3Sdextr	:=	0
				n3nSdtrfs	:=	0
				n3Sdliqu	:=	0
				n3Saldo		:=	0
				n3Saldo2	:=	0

				While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->tmp_codcli==cCodCli .And. &cCond .And. &cCond1    			

					If lAbortPrint
						@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
						Exit
					Endif

					IncRegua((cAliasTMP)->tmp_nomcli)

					n3Enbrut	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_enbrut)),(cAliasTMP)->tmp_enbrut)	 
					n3Endesc	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_endesc)),(cAliasTMP)->tmp_endesc)						   
					n3Enextr	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_enextr)),(cAliasTMP)->tmp_enextr)
					n3Entrfs	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_entrfs)),(cAliasTMP)->tmp_entrfs)
					n3Enliqu	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_enliqu)),(cAliasTMP)->tmp_enliqu)
					n3Sdbrut	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_sdbrut)),(cAliasTMP)->tmp_sdbrut)
					n3Sddesc	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_sddesc)),(cAliasTMP)->tmp_sddesc)
					n3Sdextr	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_sdextr)),(cAliasTMP)->tmp_sdextr)
					n3Sdtrfs	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_sdtrfs)),(cAliasTMP)->tmp_sdtrfs)
					n3Sdliqu	+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_sdliqu)),(cAliasTMP)->tmp_sdliqu)						

					n3Saldo		+=	If(Len(Alltrim(mv_par09))>0 .And. Upper(Alltrim(mv_par09))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par09)),(cAliasTMP)->tmp_saldo)),(cAliasTMP)->tmp_saldo)				
					n3Saldo2	+=	If(Len(Alltrim(mv_par10))>0 .And. Upper(Alltrim(mv_par10))<>(cAliasTMP)->tmp_um,(Agrx001((cAliasTMP)->tmp_um,Upper(Alltrim(mv_par10)),(cAliasTMP)->tmp_saldo)),If(Len(Alltrim(mv_par10))>0 .And. Upper(Alltrim(mv_par10))==(cAliasTMP)->tmp_um,(cAliasTMP)->tmp_saldo,0))				

					(cAliasTMP)->(dbSkip())			   	
				EndDo

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				@ nLin,039 PSay Transform(n3Enbrut,"@E 999,999,999.99")				
				@ nLin,054 PSay Transform(n3Endesc,"@E 999,999,999.99")				
				@ nLin,069 PSay Transform(n3Enextr,"@E 999,999,999.99")				
				@ nLin,084 PSay Transform(n3Entrfs,"@E 999,999,999.99")				
				@ nLin,099 PSay Transform(n3Enliqu,"@E 999,999,999.99")				
				@ nLin,114 PSay Transform(n3Sdbrut,"@E 999,999,999.99")				
				@ nLin,129 PSay Transform(n3Sddesc,"@E 999,999,999.99")				
				@ nLin,144 PSay Transform(n3Sdextr,"@E 999,999,999.99")				
				@ nLin,159 PSay Transform(n3Sdtrfs,"@E 999,999,999.99")				
				@ nLin,174 PSay Transform(n3Sdliqu,"@E 999,999,999.99")								
				@ nLin,190 PSay Transform(n3Saldo ,"@E 999,999,999.99")						
				@ nLin,206 PSay Transform(n3Saldo2,"@E 999,999,999.99")												
				nLin++	

				n2Enbrut	+=	n3Enbrut 	 
				n2Endesc	+=	n3Endesc
				n2Enextr	+=	n3Enextr			
				n2Entrfs	+=	n3Entrfs
				n2Enliqu	+=	n3Enliqu	
				n2Sdbrut	+=	n3Sdbrut
				n2Sddesc	+=	n3Sddesc
				n2Sdextr	+=	n3Sdextr
				n2Sdtrfs	+=	n3Sdtrfs
				n2Sdliqu	+=	n3Sdliqu	
				n2Saldo		+=	n3Saldo
				n2Saldo2	+=	n3Saldo2

			EndDo

			n1Enbrut	+=	n2Enbrut 	 
			n1Endesc	+=	n2Endesc
			n1Enextr	+=	n2Enextr			
			n1Entrfs	+=	n2Entrfs
			n1Enliqu	+=	n2Enliqu	
			n1Sdbrut	+=	n2Sdbrut
			n1Sddesc	+=	n2Sddesc
			n1Sdextr	+=	n2Sdextr
			n1Sdtrfs	+=	n2Sdtrfs
			n1Sdliqu	+=	n2Sdliqu
			n1Saldo		+=	n2Saldo
			n1Saldo2	+=	n2Saldo2

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			If nQtdCond2>1
				nLin++
				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             	
				@ nLin,015 PSay PadR("Total do "+If(nOrdem==1,"Produto -->","Armazem -->"),20)
				@ nLin,039 PSay Transform(n2Enbrut,"@E 999,999,999.99")				
				@ nLin,054 PSay Transform(n2Endesc,"@E 999,999,999.99")				
				@ nLin,069 PSay Transform(n2Enextr,"@E 999,999,999.99")				
				@ nLin,084 PSay Transform(n2Entrfs,"@E 999,999,999.99")				
				@ nLin,099 PSay Transform(n2Enliqu,"@E 999,999,999.99")				
				@ nLin,114 PSay Transform(n2Sdbrut,"@E 999,999,999.99")				
				@ nLin,129 PSay Transform(n2Sddesc,"@E 999,999,999.99")				
				@ nLin,144 PSay Transform(n2Sdextr,"@E 999,999,999.99")				
				@ nLin,159 PSay Transform(n2Sdtrfs,"@E 999,999,999.99")				
				@ nLin,174 PSay Transform(n2Sdliqu,"@E 999,999,999.99")						
				@ nLin,190 PSay Transform(n2Saldo ,"@E 999,999,999.99")						
				@ nLin,206 PSay Transform(n2Saldo2,"@E 999,999,999.99")										
				nLin++	   		   	
			Endif
			nQtdCond2 := 0		

		EndDo

		n0Enbrut	+=	n1Enbrut 	 
		n0Endesc	+=	n1Endesc
		n0Enextr	+=	n1Enextr			
		n0Entrfs	+=	n1Entrfs
		n0Enliqu	+=	n1Enliqu	
		n0Sdbrut	+=	n1Sdbrut
		n0Sddesc	+=	n1Sddesc
		n0Sdextr	+=	n1Sdextr
		n0Sdtrfs	+=	n1Sdtrfs
		n0Sdliqu	+=	n1Sdliqu
		n0Saldo		+=	n1Saldo
		n0Saldo2	+=	n1Saldo2

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		If nQtdCond1>1
			nLin++
			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             	
			@ nLin,015 PSay PadR("Total do Cliente -->",20)
			@ nLin,039 PSay Transform(n1Enbrut,"@E 999,999,999.99")				
			@ nLin,054 PSay Transform(n1Endesc,"@E 999,999,999.99")				
			@ nLin,069 PSay Transform(n1Enextr,"@E 999,999,999.99")				
			@ nLin,084 PSay Transform(n1Entrfs,"@E 999,999,999.99")				
			@ nLin,099 PSay Transform(n1Enliqu,"@E 999,999,999.99")				
			@ nLin,114 PSay Transform(n1Sdbrut,"@E 999,999,999.99")				
			@ nLin,129 PSay Transform(n1Sddesc,"@E 999,999,999.99")				
			@ nLin,144 PSay Transform(n1Sdextr,"@E 999,999,999.99")				
			@ nLin,159 PSay Transform(n1Sdtrfs,"@E 999,999,999.99")				
			@ nLin,174 PSay Transform(n1Sdliqu,"@E 999,999,999.99")						
			@ nLin,190 PSay Transform(n1Saldo ,"@E 999,999,999.99")						
			@ nLin,206 PSay Transform(n1Saldo2,"@E 999,999,999.99")										
			nLin++	   		   	
		Endif
		nQtdCond0 += nQtdCond1	
		nQtdCond1 := 0

	EndDo

	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		If nLin < 80
			Roda()
		EndIf
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif             

	If nQtdCond0>1
		nLin++	   		   		
		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             	
		@ nLin,015 PSay PadR("Total Geral   ----->",20)
		@ nLin,039 PSay Transform(n0Enbrut,"@E 999,999,999.99")				
		@ nLin,054 PSay Transform(n0Endesc,"@E 999,999,999.99")				
		@ nLin,069 PSay Transform(n0Enextr,"@E 999,999,999.99")				
		@ nLin,084 PSay Transform(n0Entrfs,"@E 999,999,999.99")				
		@ nLin,099 PSay Transform(n0Enliqu,"@E 999,999,999.99")				
		@ nLin,114 PSay Transform(n0Sdbrut,"@E 999,999,999.99")				
		@ nLin,129 PSay Transform(n0Sddesc,"@E 999,999,999.99")				
		@ nLin,144 PSay Transform(n0Sdextr,"@E 999,999,999.99")				
		@ nLin,159 PSay Transform(n0Sdtrfs,"@E 999,999,999.99")				
		@ nLin,174 PSay Transform(n0Sdliqu,"@E 999,999,999.99")						
		@ nLin,190 PSay Transform(n0Saldo ,"@E 999,999,999.99")						
		@ nLin,206 PSay Transform(n0Saldo2,"@E 999,999,999.99")										
		nLin++
		nQtdCond1 := 0
	Endif

	(cAliasTMP)->(dbCloseArea())

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()

