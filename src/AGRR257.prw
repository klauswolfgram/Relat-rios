/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp := Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGRR257  º Autor ³ Ricardo Tomasi     º Data ³  07/01/2006 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Resumo de Produção por Talhão.                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR257()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Resumo Prod. por Talhão."
	Local titulo         := "Resumo de Produção por Talhão"
	Local nLin           := 132
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 80
	Private tamanho     := "P"
	Private nomeprog    := 'AGRR257'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR257"
	Private wnrel       := "AGRR257"
	Private cAliasTMP     := ""

	dbSelectArea("NN3")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint('NN3',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NN3')

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
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  07/01/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]

	Local	nTotUM		:= 	0
	Local 	nFilTUM		:=	0
	Local   nFilTHa		:=	0
	Local 	nFazTUM		:=	0
	Local   nFazTHa		:=	0
	Local 	nGerTUM		:=	0
	Local 	nGerTHa		:=	0
	Local 	nFilSUM		:=	0
	Local   nFilSHa		:=	0
	Local 	nFazSUM		:=	0
	Local   nFazSHa		:=	0
	Local 	nGerSUM		:=	0
	Local   nGerSHa		:=	0
	Local	nTraUM      :=	0
	Local	nFilTraUM  	:=	0
	Local	nFazTraUM  	:=	0
	Local	nGerTraUM  	:=	0
	Local	nFilCarga   :=	0
	Local	nFazCarga 	:=	0
	Local	nGerCarga 	:=	0
	Local 	lImpFaz		:=	.f.
	Local 	lImpFil		:=	.f.
	Local 	lImpGer		:=	.f.

	Private aArqTMP	:=	{}
	Private cIndTMP

	cFiltro := "NN3_SAFRA  == '"+MV_PAR01+"' .And. "
	cFiltro += "NN3_FAZ    >= '"+MV_PAR02+"' .And. "
	cFiltro += "NN3_FAZ    <= '"+MV_PAR03+"' .And. "
	//Considera Status do Parametro
	If mv_par08<>3
		cFiltro += "NN3_FECHAD='"+If(mv_par08==1,"N","S")+"' .And. "
	Endif
	//Considera Filiais
	If mv_par13==1
		cFiltro += "NN3_FILIAL >= '"+MV_PAR14+"' .And. "
		cFiltro += "NN3_FILIAL <= '"+MV_PAR15+"' .And. "	
	Else
		cFiltro += "NN3_FILIAL = '"+xFilial("NN3")+"' .And. "	
	Endif
	cFiltro += "NN3_TALHAO >= '"+MV_PAR04+"' .And. "
	cFiltro += "NN3_TALHAO <= '"+MV_PAR05+"'" 

	//DbSelectArea('NN3')
	//IndRegua("NN3",CriaTrab(Nil,.f.),IndexKey(),,cFiltro,"Criando Indice...")

	aAdd(aArqTMP,{"NN3_FILIAL","C",012,00})
	aAdd(aArqTMP,{"NN3_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"NN3_FAZ   ","C",002,00})
	aAdd(aArqTMP,{"NN2_NOME  ","C",030,00})
	aAdd(aArqTMP,{"NN2_NOMFIL","C",015,00})
	aAdd(aArqTMP,{"NN3_TALHAO","C",010,00})
	aAdd(aArqTMP,{"NN3_DESCRI","C",040,00})
	aAdd(aArqTMP,{"NN3_HECTAR","N",014,02})
	aAdd(aArqTMP,{"NN3_PLANT ","C",001,00})
	aAdd(aArqTMP,{"NN3_CODPRO","C",015,00})
	aAdd(aArqTMP,{"NN3_CONTA ","C",020,00})
	aAdd(aArqTMP,{"NN3_CC    ","C",009,00})
	aAdd(aArqTMP,{"NN3_CLVL  ","C",009,00})
	aAdd(aArqTMP,{"NN3_ITEMCT","C",009,00}) 
	aAdd(aArqTMP,{"NN3_FECHAD","C",001,00})
	aAdd(aArqTMP,{"NN3_UM1PRO","C",002,00})

	//Cria tabela temporária
	cAliasTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", "NN3_FILIAL+NN3_FAZ+NN3_TALHAO" }} })  

	DbSelectArea("NN3")
	nn3->(DbGoTop())
	While nn3->(!Eof()) 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			nn3->(dbSkip())
			Loop
		EndIf		

		DbSelectArea(cAliasTMP)	
		If RecLock(cAliasTMP,.t.)
			Replace (cAliasTMP)->nn3_filial	With nn3->nn3_filial	
			Replace (cAliasTMP)->nn3_safra 	With nn3->nn3_safra
			Replace (cAliasTMP)->nn3_faz   	With nn3->nn3_faz				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Procura a Fazenda Relacionada³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("NN2")
			DbSetOrder(2)
			If DbSeek(xFilial("NN2")+nn3->nn3_faz)
				Replace (cAliasTMP)->nn2_nome	With nn2->nn2_nome
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Procura a Filial da Fazenda Relacionada³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("NN2")
			DbSetOrder(1)
			If DbSeek(xFilial("NN2")+nn3->nn3_filial)
				Replace (cAliasTMP)->nn2_nomfil	With nn2->nn2_nomfil
			Endif		 		
			Replace (cAliasTMP)->nn3_talhao	With nn3->nn3_talhao
			Replace (cAliasTMP)->nn3_descri	With nn3->nn3_descri
			Replace (cAliasTMP)->nn3_hectar	With IIf(Empty(nn3->nn3_utilha),nn3->nn3_hectar,nn3->nn3_utilha)
			Replace (cAliasTMP)->nn3_plant 	With nn3->nn3_plant
			Replace (cAliasTMP)->nn3_codpro	With nn3->nn3_codpro
			Replace (cAliasTMP)->nn3_conta 	With nn3->nn3_conta
			Replace (cAliasTMP)->nn3_cc    	With nn3->nn3_cc
			Replace (cAliasTMP)->nn3_clvl  	With nn3->nn3_clvl
			Replace (cAliasTMP)->nn3_itemct	With nn3->nn3_itemct
			Replace (cAliasTMP)->nn3_fechad	With nn3->nn3_fechad
			Replace (cAliasTMP)->nn3_um1pro	With nn3->nn3_um1pro		
			MsUnLock(cAliasTMP)
		EndIf       				
		DbSelectArea("NN3")
		nn3->(dbSkip())
	EndDo

	DbSelectArea("NN1")
	DbSetOrder(1)
	DbSeek(xFilial("NN1")+mv_par01)
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+nn1->nn1_codpro)

	Cabec1	:= PadC("Safra: "+PadR(AllTrim(nn1->nn1_descri),20)+" - Periodo de: "+DToC(mv_par06)+" a "+DToC(mv_par07),80)
	Cabec2  := '   Fazenda               Total '+PadR(If(Len(Alltrim(mv_par11))>0,mv_par11,sb1->b1_um),2)+'       Total '+PadR(If(Len(Alltrim(mv_par12))>0,mv_par12,sb1->b1_um),2)+'   Total HA  Media '+PadR(If(Len(Alltrim(mv_par12))>0,mv_par12,sb1->b1_um),2)+'/HA  Status'

	DbSelectArea(cAliasTMP)
	SetRegua((cAliasTMP)->(RecCount()))
	(cAliasTMP)->(Dbgotop())
	While (cAliasTMP)->(!Eof())

		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             

		cFil		:=	(cAliasTMP)->nn3_filial
		lFirstFil	:=	.t.
		nFilTUM		:=	0
		nFilTHa		:=	0
		nFilSUM		:=	0
		nFilSHa		:=	0    	
		nFilTraUM  	:=	0
		nFilCarga	:=	0
		lImpFil		:=	.f.

		While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->nn3_filial==cFil

			cFaz		:=	(cAliasTMP)->nn3_faz			
			lFirstFaz	:=	.t.
			nFazTUM		:=	0
			nFazTHa		:=	0
			nFazSUM		:=	0
			nFazSHa		:=	0
			nFazTraUM  	:= 	0
			nFazCarga	:=	0
			lImpFaz		:=	.f.

			While (cAliasTMP)->(!Eof()) .And. (cAliasTMP)->nn3_filial==cFil .And. (cAliasTMP)->nn3_faz==cFaz

				If lAbortPrint
					@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif

				nTotUM		:= 	0

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Regua de Processamento³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IncRegua("Talhao.:"+PadR((cAliasTMP)->nn3_descri,20))	                    
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Procura os Apontamentos de Producao do Talhao³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NPA")
				DbSetOrder(2)
				If DbSeek(xFilial("NPA")+(cAliasTMP)->nn3_safra+(cAliasTMP)->nn3_faz+AllTrim((cAliasTMP)->nn3_talhao))
					While npa->(!Eof()) .And.  npa->npa_safra==(cAliasTMP)->nn3_safra .And. npa->npa_faz==(cAliasTMP)->nn3_faz .And. npa->npa_talhao==AllTrim((cAliasTMP)->nn3_talhao)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Valida a Data³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If !(npa->npa_data >= MV_PAR06 .And. npa->npa_data <= MV_PAR07)
							npa->(dbSkip())
							Loop
						Endif
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica se o Talhao esta fechado ou aberto³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Upper(Alltrim(npa->npa_fechad))=='S'
							nTotUM  	+= 	npa->npa_qtdrea	
							nFilSUM		+=	npa->npa_qtdrea	
							nFazSUM		+=	npa->npa_qtdrea					
							nGerSUM		+=	npa->npa_qtdrea	
							nFilTUM		+=	npa->npa_qtdrea	
							nFazTUM		+=	npa->npa_qtdrea	
							nGerTUM		+=	npa->npa_qtdrea	
						Else
							nTraUM  	+= 	npa->npa_qtdest	
							nFilTraUM  	+= 	npa->npa_qtdest	
							nFazTraUM  	+= 	npa->npa_qtdest	
							nGerTraUM  	+= 	npa->npa_qtdest	
							nFilTUM		+=	npa->npa_qtdest	
							nFazTUM		+=	npa->npa_qtdest	
							nGerTUM		+=	npa->npa_qtdest	
							nFilCarga++
							nFazCarga++
							nGerCarga++
						EndIf
						npa->(dbSkip())
					EndDo
				Endif                     	

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Lista Talhoes Zerados³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ((mv_par09==1).Or.(mv_par09==2 .And. nTotUM>0))					

					lImpFaz	:=	.t.
					lImpFil	:=	.t.
					lImpGer	:=	.t.

					If lFirstFil .And. !((mv_par13==2) .Or. (mv_par13==1 .And. mv_par14==mv_par15)) 
						lFirstFil	:=	.f.
						@ nLin,000 PSay (cAliasTMP)->nn3_filial+'-'+(cAliasTMP)->nn2_nomfil
						nLin++
						nLin++						
					Endif

					If lFirstFaz
						lFirstFaz	:=	.f.
						@ nLin,001 PSay (cAliasTMP)->nn3_faz+'-'+(cAliasTMP)->nn2_nome
						nLin++
					Endif

					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Relatorio Analitico³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If mv_par10==1

						If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						Endif             

						@ nLin,006 PSay "Talhão: "+(cAliasTMP)->nn3_talhao
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Primeira Unidade de Medida³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
							@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nTotUM),"@E 999,999,999.99")					
						Else
							@ nLin,019 PSay Transform(nTotUM,"@E 999,999,999.99")					
						Endif
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Segunda Unidade de Medida³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
							@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nTotUM),"@E 999,999,999.99")					
							@ nLin,049 PSay Transform((cAliasTMP)->nn3_hectar,"@E 999,999.99")
							@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nTotUM/(cAliasTMP)->nn3_hectar))), "@E 9,999,999.99")
						Else
							@ nLin,034 PSay Transform(nTotUM,"@E 999,999,999.99")					
							@ nLin,049 PSay Transform((cAliasTMP)->nn3_hectar,"@E 999,999.99")
							@ nLin,060 PSay Transform((nTotUM/(cAliasTMP)->nn3_hectar), "@E 9,999,999.99")
						Endif
						@ nLin, 073 PSay PadL(If((cAliasTMP)->nn3_fechad=='S',"Fechado","Aberto"),7)
						nLin++				
					EndIf				
					nFazSHa		+=	(cAliasTMP)->nn3_hectar			
					nFilSHa		+=	(cAliasTMP)->nn3_hectar			
					nGerSHa		+=	(cAliasTMP)->nn3_hectar			
					nFazTHa		+=	(cAliasTMP)->nn3_hectar
					nFilTHa		+=	(cAliasTMP)->nn3_hectar
					nGerTHa		+=	(cAliasTMP)->nn3_hectar					
				Endif			    		    
				(cAliasTMP)->(Dbskip())
			EndDo
			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se imprime o total da Fazenda³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lImpFaz
				nLin++	
				If nFazTraUM>0 
					@ nLin,001 PSay "SubTotal Fazenda:"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Primeira Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFazSUM),"@E 999,999,999.99")					
					Else
						@ nLin,019 PSay Transform(nFazSUM, "@E 999,999,999.99")
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFazSUM),"@E 999,999,999.99")					
						@ nLin,049 PSay Transform(nFazSHa,"@E 999,999.99")
						@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nFazSUM/nFazSHa))), "@E 9,999,999.99")
					Else
						@ nLin,034 PSay Transform(nFazSUM,"@E 999,999,999.99")
						@ nLin,049 PSay Transform(nFazSHa,"@E 999,999.99")
						@ nLin,060 PSay Transform((nFazSUM/nFazSHa),"@E 9,999,999.99")
					Endif
					nLin++						
					If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
						If nLin < 80
							Roda()
						EndIf
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif             	
					@ nLin,001 PSay "Transito: "+Transform(nFazCarga,'@E 9999')
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Primeira Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFazTraUM),"@E 999,999,999.99")					
					Else
						@ nLin,019 PSay Transform(nFazTraUM, "@E 999,999,999.99")
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFazTraUM),"@E 999,999,999.99")					
					Else
						@ nLin,034 PSay Transform(nFazTraUM,"@E 999,999,999.99")
					Endif
					nLin++				
				Endif

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				@ nLin,001 PSay "Total Fazenda:"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Primeira Unidade de Medida³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
					@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFazTUM),"@E 999,999,999.99")					
				Else
					@ nLin,019 PSay Transform(nFazTUM, "@E 999,999,999.99")
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Segunda Unidade de Medida³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
					@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFazTUM),"@E 999,999,999.99")					
					@ nLin,049 PSay Transform(nFazTHa,"@E 999,999.99")
					@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nFazTUM/nFazTHa))), "@E 9,999,999.99")
				Else
					@ nLin,034 PSay Transform(nFazTUM,"@E 999,999,999.99")
					@ nLin,049 PSay Transform(nFazTHa,"@E 999,999.99")
					@ nLin,060 PSay Transform((nFazTUM/nFazTHa),"@E 9,999,999.99")
				Endif
				nLin++				
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
		If !((mv_par13==2) .Or. (mv_par13==1 .And. mv_par14==mv_par15)) 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se imprime o total da Fazenda³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lImpFil
				If nFilTraUM>0 
					@ nLin,000 PSay "SubTotal Filial:"
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Primeira Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFilSUM),"@E 999,999,999.99")					
					Else
						@ nLin,019 PSay Transform(nFilSUM, "@E 999,999,999.99")
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFilSUM),"@E 999,999,999.99")					
						@ nLin,049 PSay Transform(nFilSHa,"@E 999,999.99")
						@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nFilSUM/nFilSHa))), "@E 9,999,999.99")
					Else
						@ nLin,034 PSay Transform(nFilSUM,"@E 999,999,999.99")
						@ nLin,049 PSay Transform(nFilSHa,"@E 999,999.99")
						@ nLin,060 PSay Transform((nFilSUM/nFilSHa),"@E 9,999,999.99")
					Endif
					nLin++						
					If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
						If nLin < 80
							Roda()
						EndIf
						Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
						nLin := 9
					Endif             		
					@ nLin,000 PSay "Transito: "+Transform(nFilCarga,'@E 9999')
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Primeira Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFilTraUM),"@E 999,999,999.99")					
					Else
						@ nLin,019 PSay Transform(nFilTraUM, "@E 999,999,999.99")
					Endif
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Segunda Unidade de Medida³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
						@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFilTraUM),"@E 999,999,999.99")					
					Else
						@ nLin,034 PSay Transform(nFilTraUM,"@E 999,999,999.99")
					Endif
					nLin++					
				Endif
				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             	
				@ nLin,000 PSay "Total Filial:"
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Primeira Unidade de Medida³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
					@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nFilTUM),"@E 999,999,999.99")					
				Else
					@ nLin,019 PSay Transform(nFilTUM, "@E 999,999,999.99")
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Segunda Unidade de Medida³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
					@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nFilTUM),"@E 999,999,999.99")					
					@ nLin,049 PSay Transform(nFilTHa,"@E 999,999.99")
					@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nFilTUM/nFilTHa))), "@E 9,999,999.99")
				Else
					@ nLin,034 PSay Transform(nFilTUM,"@E 999,999,999.99")
					@ nLin,049 PSay Transform(nFilTHa,"@E 999,999.99")
					@ nLin,060 PSay Transform((nFilTUM/nFilTHa),"@E 9,999,999.99")
				Endif
				nLin ++
				@ nLin,000 PSay	Replicate("-",80)
				nLin ++
			Endif	
		Endif	
	EndDo  
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
		If nLin < 80
			Roda()
		EndIf
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif             
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se imprime o total da Fazenda³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpGer
		nLin++				
		If nGerTraUM>0 
			@ nLin,000 PSay "SubTotal Geral:"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Primeira Unidade de Medida³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
				@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nGerSUM),"@E 999,999,999.99")					
			Else
				@ nLin,019 PSay Transform(nGerSUM, "@E 999,999,999.99")
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Segunda Unidade de Medida³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
				@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nGerSUM),"@E 999,999,999.99")					
				@ nLin,049 PSay Transform(nGerSHa,"@E 999,999.99")
				@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nGerSUM/nGerSHa))), "@E 9,999,999.99")
			Else
				@ nLin,034 PSay Transform(nGerSUM,"@E 999,999,999.99")
				@ nLin,049 PSay Transform(nGerSHa,"@E 999,999.99")
				@ nLin,060 PSay Transform((nGerSUM/nGerSHa),"@E 9,999,999.99")
			Endif
			nLin++				
			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             	
			@ nLin,000 PSay "Transito: "+Transform(nGerCarga,'@E 9999')
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Primeira Unidade de Medida³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
				@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nGerTraUM),"@E 999,999,999.99")					
			Else
				@ nLin,019 PSay Transform(nGerTraUM, "@E 999,999,999.99")
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Segunda Unidade de Medida³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
				@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nGerTraUM),"@E 999,999,999.99")					
			Else
				@ nLin,034 PSay Transform(nGerTraUM,"@E 999,999,999.99")
			Endif
			nLin++				
		Endif
		If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             
		@ nLin,000 PSay "Total Geral:"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Primeira Unidade de Medida³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(Alltrim(mv_par11))>0 .And. Upper(Alltrim(mv_par11))<>Upper(Alltrim(sb1->b1_um))
			@ nLin,019 PSay Transform(AGRX001(sb1->b1_um,mv_par11,nGerTUM),"@E 999,999,999.99")					
		Else
			@ nLin,019 PSay Transform(nGerTUM, "@E 999,999,999.99")
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Segunda Unidade de Medida³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(Alltrim(mv_par12))>0 .And. Upper(Alltrim(mv_par12))<>Upper(Alltrim(sb1->b1_um))
			@ nLin,034 PSay Transform(AGRX001(sb1->b1_um,mv_par12,nGerTUM),"@E 999,999,999.99")					
			@ nLin,049 PSay Transform(nGerTHa,"@E 999,999.99")
			@ nLin,060 PSay Transform((AGRX001(sb1->b1_um,mv_par12,(nGerTUM/nGerTHa))), "@E 9,999,999.99")
		Else
			@ nLin,034 PSay Transform(nGerTUM,"@E 999,999,999.99")
			@ nLin,049 PSay Transform(nGerTHa,"@E 999,999.99")
			@ nLin,060 PSay Transform((nGerTUM/nGerTHa),"@E 9,999,999.99")
		Endif
	Endif
	(cAliasTMP)->(dbCloseArea())

	//Set Filter To
	dbClearFilter()

	Roda()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza a execucao do relatorio...                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	SET DEVICE TO SCREEN

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se impressao em disco, chama o gerenciador de impressao...          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()
