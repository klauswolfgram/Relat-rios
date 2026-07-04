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
±±³Funçào    ³ AGRR295  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao de Romaneio de Saida					              ³±±
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
User Function AGRR295()  

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Relacao de Romaneios de Saida."
	Local titulo         := "Relacao de Romaneios de Saida"
	Local nLin           := 220
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {'Cliente+Armazem+Romaneio','Cliente+Armazem+Ticket','Cliente+Armazem+Nota Fiscal'}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 200
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR295'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR295"
	Private wnrel       := "AGRR295"
	Private cAliasTMP   := ""

	dbSelectArea("NPR")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint('NPR',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.t.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NPR')

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
±±³ Uso      ³ AGRR295                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	aArea   	:= GetArea()
	Local 	nOrdem                          
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]
	Local	__k
	Local	aTpDesp		:=	{}
	Local	cUm			:=	Alltrim(Posicione("SB1",1,xFilial("SB1")+Alltrim(Posicione('NN1',1,xFilial('NN1')+Alltrim(mv_par01),'NN1_CODPRO')),"B1_UM"))
	Local	cDescUm		:=	Posicione('SAH',1,xFilial('SAH')+If(Len(Alltrim(mv_par10))==0,cUm,Alltrim(mv_par10)),"AH_DESCPO")
	Local	cNota		:= 	''
	Local	cCompromisso:=	''
	Local	cArqSD2		:=	''
	Local	nPBruto		:=	0
	Local	nPLiqui		:=	0
	Local	nSPBruto	:=	0
	Local	nSPLiqui	:=	0
	Local	nSRomane	:=	0
	Local	nTPBruto	:=	0
	Local	nTPLiqui	:=	0
	Local	nTRomane	:=	0
	Local	nGPBruto	:=	0
	Local	nGPLiqui	:=	0
	Local	nGRomane	:=	0
	Local	nDescOU		:=	0
	Local	nPDesOU		:=	0
	Local	nSDescOU	:=	0
	Local	nPSDesOU 	:= 	0
	Local	nTDescOU	:=	0
	Local	nPTDesOU 	:= 	0
	Local	nGDescOU	:=	0	
	Local	nGPDesOU	:=	0
	Private	nDesc1		:=	0
	Private	nPDes1		:=	0
	Private	nDesc2		:=	0
	Private	nPDes2		:=	0
	Private	nDesc3		:=	0
	Private	nPDes3		:=	0
	Private	nDesc4		:=	0
	Private	nPDes4		:=	0
	Private	nSDesc1		:=	0
	Private	nPSDes1 	:= 	0
	Private	nSDesc2		:=	0
	Private	nPSDes2 	:= 	0
	Private	nSDesc3		:=	0
	Private	nPSDes3 	:= 	0
	Private	nSDesc4		:=	0
	Private	nPSDes4 	:= 	0
	Private	nTDesc1		:=	0
	Private	nPTDes1 	:= 	0
	Private	nTDesc2		:=	0
	Private	nPTDes2 	:= 	0
	Private	nTDesc3		:=	0
	Private	nPTDes3 	:= 	0
	Private	nTDesc4		:=	0
	Private	nPTDes4 	:= 	0
	Private	nGDesc1		:=	0	
	Private	nGPDes1		:=	0	
	Private	nGDesc2		:=	0	
	Private	nGPDes2		:=	0	
	Private	nGDesc3		:=	0	
	Private	nGPDes3		:=	0	
	Private	nGDesc4		:=	0	
	Private	nGPDes4		:=	0	

	//Variaveis para arquivos temporarios
	Private cIndTMP := ""
	Private cChvTMP := ""
	Private aArqTMP := {}

	titulo	:= 	Alltrim(titulo)+" no Periodo de "+Dtoc(mv_par02)+" a "+Dtoc(mv_par03)

	nOrdem 	:=	aReturn[8]

	cFiltro := "NPR_SAFRA==MV_PAR01 .And. "
	cFiltro += "NPR_DATA >= MV_PAR02 .And. "
	cFiltro += "NPR_DATA <= MV_PAR03 .And. "
	cFiltro += "NPR_CODCLI >= MV_PAR04 .And. "
	cFiltro += "NPR_CODCLI <= MV_PAR05 .And. "
	cFiltro += "NPR_ARM >= MV_PAR06 .And. "
	cFiltro += "NPR_ARM <= MV_PAR07 .And. "
	cFiltro += "NPR_NUMAUT >= MV_PAR08 .And. "
	cFiltro += "NPR_NUMAUT <= MV_PAR09"

	dbSelectArea('NPR')
	dbSetFilter( {|| &cFiltro }, cFiltro )

	aAdd(aArqTMP,{"TMP_CODIGO","C",006,00})
	aAdd(aArqTMP,{"TMP_TIPO  ","C",001,00})			
	aAdd(aArqTMP,{"TMP_NUMAUT","C",006,00})
	aAdd(aArqTMP,{"TMP_DATA	 ","D",008,00})
	aAdd(aArqTMP,{"TMP_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"TMP_ARM   ","C",002,00})
	aAdd(aArqTMP,{"TMP_CODCLI","C",006,00}) 
	aAdd(aArqTMP,{"TMP_LOJCLI","C",002,00})
	aAdd(aArqTMP,{"TMP_CODTRA","C",006,00})
	aAdd(aArqTMP,{"TMP_CODEQU","C",006,00})
	aAdd(aArqTMP,{"TMP_CODMOT","C",006,00})
	aAdd(aArqTMP,{"TMP_CODPRO","C",015,00})
	aAdd(aArqTMP,{"TMP_UM    ","C",002,00})
	aAdd(aArqTMP,{"TMP_TICKET","C",010,00})
	aAdd(aArqTMP,{"TMP_LAUDO ","C",010,00})
	aAdd(aArqTMP,{"TMP_CODTAB","C",006,00})
	aAdd(aArqTMP,{"TMP_PSBRUT","N",014,02})
	aAdd(aArqTMP,{"TMP_PSTARA","N",014,02})
	aAdd(aArqTMP,{"TMP_PSSUBT","N",014,02})
	aAdd(aArqTMP,{"TMP_PSDESC","N",014,02})
	aAdd(aArqTMP,{"TMP_PSLIQU","N",014,02})
	aAdd(aArqTMP,{"TMP_PSEXTR","N",014,02})
	aAdd(aArqTMP,{"TMP_PSREAL","N",014,02})
	aAdd(aArqTMP,{"TMP_SALDO ","N",014,02}) 
	aAdd(aArqTMP,{"TMP_OBS   ","C",080,00})
	aAdd(aArqTMP,{"TMP_NUMCP ","C",006,00})
	aAdd(aArqTMP,{"TMP_DOC   ","C",006,00})
	aAdd(aArqTMP,{"TMP_NOMCLI","C",050,00})
	aAdd(aArqTMP,{"TMP_NOMARM","C",020,00})
	aAdd(aArqTMP,{"TMP_PLACA" ,"C",008,00})

	//Cria tabela temporária
	If nOrdem == 1
		cChvTMP := "TMP_NOMCLI+TMP_NOMARM+TMP_CODIGO"
	ElseIf nOrdem == 2
		cChvTMP := "TMP_NOMCLI+TMP_NOMARM+TMP_TICKET"
	Else
		cChvTMP := "TMP_NOMCLI+TMP_NOMARM+TMP_DOC"
	EndIf

	cAliasTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", cChvTMP }}} )

	DbSelectArea('SD2')
	cArqSD2 := CriaTrab(Nil,.f.)
	IndRegua('SD2',cArqSD2,'D2_FILIAL+D2_CODROM',,,"Criando Indice...")
	#IFNDEF TOP
	dbSetIndex(cArqSD2+OrdBagExT())
	#ENDIF

	DbSelectArea("NPR")
	npr->(DbGoTop())
	While npr->(!Eof()) .And. npr->npr_filial==xFilial("NPR")

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			npr->(dbSkip())
			Loop
		EndIf

		dbSelectArea('SD2')
		If dbSeek(xFilial('SD2')+npr->npr_codigo)
			cNota := sd2->d2_doc
			cCompromisso := sd2->d2_numcp
		EndIf

		DbSelectArea(cAliasTMP)	
		If RecLock(cAliasTMP,.t.)
			Replace (cAliasTMP)->tmp_codigo	With	npr->npr_codigo		
			Replace (cAliasTMP)->tmp_tipo  	With	npr->npr_tipo	
			Replace (cAliasTMP)->tmp_numaut	With	npr->npr_numaut	
			Replace (cAliasTMP)->tmp_data	With	npr->npr_data	
			Replace (cAliasTMP)->tmp_safra 	With	npr->npr_safra	
			Replace (cAliasTMP)->tmp_arm   	With	npr->npr_arm	
			Replace (cAliasTMP)->tmp_codcli With	npr->npr_codcli	
			Replace (cAliasTMP)->tmp_lojcli	With	npr->npr_lojcli	
			Replace (cAliasTMP)->tmp_codtra	With	npr->npr_codtra	
			Replace (cAliasTMP)->tmp_codequ	With	npr->npr_codequ
			Replace (cAliasTMP)->tmp_placa	With	Posicione("NNB",1,xFilial("NNB")+npr->npr_codequ,"NNB_PLACA")
			Replace (cAliasTMP)->tmp_codmot	With	npr->npr_codmot	
			Replace (cAliasTMP)->tmp_codpro	With	npr->npr_codpro	
			Replace (cAliasTMP)->tmp_um    	With	npr->npr_um	
			Replace (cAliasTMP)->tmp_ticket	With	npr->npr_ticket	
			Replace (cAliasTMP)->tmp_laudo 	With	npr->npr_laudo	
			Replace (cAliasTMP)->tmp_codtab	With	npr->npr_codtab	
			Replace (cAliasTMP)->tmp_psbrut	With	npr->npr_psbrut
			Replace (cAliasTMP)->tmp_pstara	With	npr->npr_pstara
			Replace (cAliasTMP)->tmp_pssubt	With	npr->npr_pssubt
			Replace (cAliasTMP)->tmp_psdesc	With	npr->npr_psdesc
			Replace (cAliasTMP)->tmp_psliqu	With	npr->npr_psliqu
			Replace (cAliasTMP)->tmp_psextr	With	npr->npr_psextr
			Replace (cAliasTMP)->tmp_psreal	With	npr->npr_psreal
			Replace (cAliasTMP)->tmp_saldo  With	npr->npr_saldo
			Replace (cAliasTMP)->tmp_obs   	With	npr->npr_obs
			Replace (cAliasTMP)->tmp_doc 	With	cNota
			Replace (cAliasTMP)->tmp_numcp 	With	cCompromisso
			Replace (cAliasTMP)->tmp_nomcli	With	SubStr(Posicione("SA1",1,xFilial("SA1")+npr->npr_codcli+npr->npr_lojcli,"A1_NOME"),1,50)
			Replace (cAliasTMP)->tmp_nomarm	With	SubStr(Posicione("NNR",1,xFilial("NNR")+npr->npr_arm,"NNR_DESCRI"),1,20)
			MsUnLock(cAliasTMP)
		EndIf                                	
		npr->(dbSkip())
	EndDo

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	//     Armazem        NºRoma  NºAuto  NºComp  NºNota Ticket  Placa        Data    |       Bruto
	Cabec1 := "Cliente                                                                         |"+PadC(Alltrim(Upper(cDescUm)),125,"-")+"|"
	Cabec2 := "     Armazem        NºRoma  NºAuto  NºComp  NºNota Ticket  Placa        Data    |       Bruto"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Cria o Cabecalho de acordo com os tipos de descontos escolhidos³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For __k := 1 To Len(mv_par12) Step 6
		DbSelectArea("NNH")
		DbSetOrder(1)
		If DbSeek(xFilial("NNH")+SubStr(mv_par12,__k,6))
			Cabec2 +=	Space(13-Len(Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))))+Alltrim((Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,11))))+Space(03)+"%"+Upper(SubStr(nnh->nnh_descri,1,1))+Lower(SubStr(nnh->nnh_descri,2,2))		
			Aadd(aTpDesp,nnh->nnh_codigo)
		Endif
	Next __k 
	For __k := (Len(aTpDesp)+1) To 4	
		Cabec2	+=	" Xxxxxxxxxxxx   %Xxx" 	
	Next __k
	Cabec2 +="       Outros   %Out Peso Liquido| "+If(Len(Alltrim(mv_par11))==0,"P.Liq./SEGUM","P.Liquido/"+Alltrim(mv_par11))

	DbSelectArea(cAliasTMP)
	SetRegua((cAliasTMP)->(RecCount()))
	(cAliasTMP)->(Dbgotop())
	While (cAliasTMP)->(!Eof())

		If lAbortPrint
			@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		cCliente	:=	(cAliasTMP)->tmp_nomcli		

		@nLin,001 Psay PadR(cCliente,40) 
		nLin++

		nTDesc1		:=	0
		nPTDes1 	:= 	0
		nTDesc2		:=	0
		nPTDes2 	:= 	0
		nTDesc3		:=	0
		nPTDes3 	:= 	0
		nTDesc4		:=	0
		nPTDes4 	:= 	0
		nTDescOU	:=	0
		nPTDesOU 	:= 	0
		nTRomane	:=	0

		nTPBruto	:=	nPBruto
		nTPLiqui	:=	nPLiqui

		While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->tmp_nomcli==cCliente		

			cArmazem	:=	(cAliasTMP)->tmp_nomarm		

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			@nLin,005 Psay PadR(cArmazem,20) 
			nLin++

			nSDesc1		:=	0
			nPSDes1 	:= 	0
			nSDesc2		:=	0
			nPSDes2 	:= 	0
			nSDesc3		:=	0
			nPSDes3 	:= 	0
			nSDesc4		:=	0
			nPSDes4 	:= 	0
			nSDescOU	:=	0
			nPSDesOU 	:= 	0
			nSRomane	:=	0

			nSPBruto	:=	nPBruto
			nSPLiqui	:=	nPLiqui

			While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->tmp_nomcli==cCliente .And. (cAliasTMP)->tmp_nomarm==cArmazem		

				IncRegua(cCliente)

				nSRomane++            
				nTRomane++            
				nGRomane++            

				nPBruto	:=	(cAliasTMP)->tmp_pssubt
				nDesc1	:=	0
				nPDes1	:=	0
				nDesc2	:=	0
				nPDes2	:=	0
				nDesc3	:=	0
				nPDes3	:=	0
				nDesc4	:=	0
				nPDes4	:=	0
				nDescOU	:=	0
				nPDesOU	:=	0
				nPLiqui	:=	(cAliasTMP)->tmp_psliqu	

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				@nLin,020 Psay PadR((cAliasTMP)->tmp_codigo,06) 
				@nLin,028 Psay PadR((cAliasTMP)->tmp_numaut,06) 
				@nLin,037 Psay PadR((cAliasTMP)->tmp_numcp,06) 
				@nLin,044 Psay PadR((cAliasTMP)->tmp_doc,06) 
				@nLin,051 PSay PadR((cAliasTMP)->tmp_ticket,06)
				@nLin,058 Psay PadR((cAliasTMP)->tmp_placa,08) 
				@nLin,070 Psay PadR(Dtoc((cAliasTMP)->tmp_data),08) 

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Procura nos Itens Romaneio Relacionado ao Apontamento³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NPS")
				DbSetOrder(1)
				If DbSeek(xFilial("NPS")+(cAliasTMP)->tmp_codigo) 
					While nps->(!Eof()) .And. nps->nps_filial==xFilial("NPS") .And. nps->nps_codigo==(cAliasTMP)->tmp_codigo
						__k	:=	aScan(aTpDesp,Alltrim(nps->nps_coddes))
						If __k>0
							&("nDesc"+StrZero(__k,1))	+=	nps->nps_pesdes	
							&("nPDes"+StrZero(__k,1))	+=	(nPBruto*nps->nps_perdes)											
							&("nSDesc"+StrZero(__k,1))	+=	nps->nps_pesdes	
							&("nPSDes"+StrZero(__k,1))	+=	(nPBruto*nps->nps_perdes)
							&("nTDesc"+StrZero(__k,1))	+=	nps->nps_pesdes	
							&("nPTDes"+StrZero(__k,1))	+=	(nPBruto*nps->nps_perdes)
							&("nGDesc"+StrZero(__k,1))	+=	nps->nps_pesdes	
							&("nGPDes"+StrZero(__k,1))	+=	(nPBruto*nps->nps_perdes)
						Else
							nDescOU		+=	nps->nps_pesdes	
							nPDesOU		+=	(nPBruto*nps->nps_perdes)											
							nSDescOU	+=	nps->nps_pesdes	
							nPSDesOU	+=	(nPBruto*nps->nps_perdes)
							nTDescOU	+=	nps->nps_pesdes	
							nPTDesOU	+=	(nPBruto*nps->nps_perdes)
							nGDescOU	+=	nps->nps_pesdes	
							nGPDesOU	+=	(nPBruto*nps->nps_perdes)
						Endif					
						nps->(dbSkip())
					EndDo
				Endif

				For __k	:= 1 to 4
					&("nPDes"+StrZero(__k,1))	:=	 ((&("nPDes"+StrZero(__k,1)))/nPBruto)						
				Next __k

				nPDesOU		:=	(nPDesOU/nPBruto)						

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Totalizadores³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
				nSPBruto	+=	nPBruto
				nSPLiqui	+=	nPLiqui
				nTPBruto	+=	nPBruto
				nTPLiqui	+=	nPLiqui
				nGPBruto	+=	nPBruto
				nGPLiqui	+=	nPLiqui

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nPBruto),"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((&("nPDes"+StrZero(__k,1))),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nDescOU),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(nPDesOU,"@E 999.99")									
					@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nPLiqui),"@E 9,999,999.99")					
				Else
					@ nLin,081 PSay Transform(nPBruto,"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform((&("nDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform((&("nPDes"+StrZero(__k,1))),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(nDescOU,"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(nPDesOU,"@E 999.99")									
					@ nLin,194 PSay Transform(nPLiqui,"@E 9,999,999.99")					
				Endif

				If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nPLiqui),"@E 9,999,999.99")														
				ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
					@ nLin,208 PSay Transform(nPLiqui,"@E 9,999,999.99")														    		
				Endif					

				nLin++

				(cAliasTMP)->(dbSkip())
			EndDo 

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			If nSRomane>1	
				nLin++	
				@nLin,043 Psay PadR("Total Armazem ---->"+Space(06-Len(Alltrim(Str(nSRomane))))+Alltrim(Str(nSRomane)),25) 
				If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nSPBruto),"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nSDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nPSDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nSDescOU),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform((nPSDesOU/nSPBruto),"@E 999.99")									
					@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nSPLiqui),"@E 9,999,999.99")					
				Else
					@ nLin,081 PSay Transform(nSPBruto,"@E 9,999,999.99")				
					nCol	:=	94
					For __k := 1 To 4 
						@ nLin,nCol PSay Transform((&("nSDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
						nCol	:=	nCol+13 	
						@ nLin,nCol PSay Transform(((&("nPSDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
						nCol	:=	nCol+7 				
					Next __k
					@ nLin,nCol PSay Transform(nSDescOU,"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform((nPSDesOU/nSPBruto),"@E 999.99")									
					@ nLin,194 PSay Transform(nSPLiqui,"@E 9,999,999.99")					
				Endif

				If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
					@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nSPLiqui),"@E 9,999,999.99")														
				ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
					@ nLin,208 PSay Transform(nSPLiqui,"@E 9,999,999.99")														    		
				Endif					
				nLin++		
			Endif

		EndDo

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		If nTRomane>1	
			nLin++
			@nLin,043 Psay PadR("Total Cliente ---->"+Space(06-Len(Alltrim(Str(nTRomane))))+Alltrim(Str(nTRomane)),25) 
			If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTPBruto),"@E 9,999,999.99")				
				nCol	:=	94
				For __k := 1 To 4 
					@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nTDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("nPTDes"+StrZero(__k,1)))/nSPBruto),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next __k
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTDescOU),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform((nPTDesOU/nTPBruto),"@E 999.99")									
				@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nTPLiqui),"@E 9,999,999.99")					
			Else
				@ nLin,081 PSay Transform(nTPBruto,"@E 9,999,999.99")				
				nCol	:=	94
				For __k := 1 To 4 
					@ nLin,nCol PSay Transform((&("nTDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
					nCol	:=	nCol+13 	
					@ nLin,nCol PSay Transform(((&("nPTDes"+StrZero(__k,1)))/nTPBruto),"@E 999.99")				
					nCol	:=	nCol+7 				
				Next __k
				@ nLin,nCol PSay Transform(nTDescOU,"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform((nPTDesOU/nTPBruto),"@E 999.99")									
				@ nLin,194 PSay Transform(nTPLiqui,"@E 9,999,999.99")					
			Endif

			If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
				@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nTPLiqui),"@E 9,999,999.99")														
			ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
				@ nLin,208 PSay Transform(nTPLiqui,"@E 9,999,999.99")														    		
			Endif					
			nLin++
		Endif	
	EndDo

	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		If nLin < 80
			Roda()
		EndIf
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif             

	If nGRomane>1	
		nLin++
		@nLin,043 Psay PadR("Total Geral   ---->"+Space(06-Len(Alltrim(Str(nGRomane))))+Alltrim(Str(nGRomane)),25) 
		If Len(Alltrim(mv_par10))>0 .And. Alltrim(mv_par10)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,081 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGPBruto),"@E 9,999,999.99")				
			nCol	:=	94
			For __k := 1 To 4 
				@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),(&("nGDesc"+StrZero(__k,1)))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(__k,1)))/nGPBruto),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next __k
			@ nLin,nCol PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGDescOU),"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
			@ nLin,194 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par10),nGPLiqui),"@E 9,999,999.99")					
		Else
			@ nLin,081 PSay Transform(nGPBruto,"@E 9,999,999.99")				
			nCol	:=	94
			For __k := 1 To 4 
				@ nLin,nCol PSay Transform((&("nGDesc"+StrZero(__k,1))),"@E 9,999,999.99")				
				nCol	:=	nCol+13 	
				@ nLin,nCol PSay Transform(((&("nGPDes"+StrZero(__k,1)))/nGPBruto),"@E 999.99")				
				nCol	:=	nCol+7 				
			Next __k
			@ nLin,nCol PSay Transform(nGDescOU,"@E 9,999,999.99")				
			nCol	:=	nCol+13 	
			@ nLin,nCol PSay Transform((nGPDesOU/nGPBruto),"@E 999.99")									
			@ nLin,194 PSay Transform(nGPLiqui,"@E 9,999,999.99")					
		Endif

		If Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)<>Alltrim(cUm)	//Converte se Necessario	
			@ nLin,208 PSay Transform(Agrx001(Alltrim(cUm),Alltrim(mv_par11),nGPLiqui),"@E 9,999,999.99")														
		ElseIf Len(Alltrim(mv_par11))>0 .And. Alltrim(mv_par11)==Alltrim(cUm)
			@ nLin,208 PSay Transform(nGPLiqui,"@E 9,999,999.99")														    		
		Endif					
	Endif

	npr->(dbClearFilter())

	(cAliasTMP)->(dbCloseArea())
	FErase(cArqSD2+OrdBagExt())

	RestArea(aArea)

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()
