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
±±ºPrograma  ³ AGRR103  º Autor ³ Danyel Bernuci     º Data ³  15/01/2006 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Resumo de Compromissos - Faturamento    		              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR103()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Resumo de Compromissos - Faturamento"
	Local titulo         := "Resumo de Compromissos - Faturamento"
	Local nLin           := 132
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR103'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR103"
	Private wnrel       := "AGRR103"
	Private cArqTMP     := ""

	DbSelectArea("NO1")
	DbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint('NO1',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NO1')

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
±±ºFun‡„o    ³RUNREPORT º Autor ³ Danyel Bernuci     º Data ³  15/01/06   º±±
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

	Local	nQuant		:=	0
	Local	nEntreg		:=	0
	Local	nSldEnt		:=	0
	Local	nSldCli		:=	0

	Local	nSQtCliF 	:=	0	
	Local	nSQtCliA 	:=	0	
	Local	nTQtCli 	:=	0	
	Local	nSQtFilF 	:=	0	
	Local	nSQtFilA 	:=	0	
	Local	nTQtFil 	:=	0	
	Local	nSQtGerF 	:=	0	
	Local	nSQtGerA 	:=	0	
	Local	nTQtGer 	:=	0	
	Local	nSEnCliF 	:=	0	
	Local	nSEnCliA 	:=	0	
	Local	nTEnCli 	:=	0	
	Local	nSEnFilF 	:=	0	
	Local	nSEnFilA 	:=	0	
	Local	nTEnFil 	:=	0	
	Local	nSEnGerF 	:=	0	
	Local	nSEnGerA 	:=	0	
	Local	nTEnGer 	:=	0	

	Private aArqTMP	:=	{}
	Private cIndTMP

	cFiltro := "NO1_SAFRA  == '"+MV_PAR01+"' .And. "
	cFiltro += "NO1_CODCLI >= '"+MV_PAR02+"' .And. "
	cFiltro += "NO1_CODCLI <= '"+MV_PAR03+"' .And. "
	cFiltro += "NO1_NUMERO >= '"+MV_PAR04+"' .And. "
	cFiltro += "NO1_NUMERO <= '"+MV_PAR05+"' .And. "
	//Considera Filiais
	If mv_par09==1
		cFiltro += "NO1_FILIAL >= '"+mv_par10+"' .And. "
		cFiltro += "NO1_FILIAL <= '"+mv_par11+"' .And. "	
	Else
		cFiltro += "NO1_FILIAL = '"+xFilial("NO1")+"' .And. "	
	Endif
	cFiltro += "DToS(NO1_DATEMI) >= '"+DToS(MV_PAR06)+"' .And. "
	cFiltro += "DToS(NO1_DATEMI) <= '"+DToS(MV_PAR07)+"'"

	DbSelectArea('NO1')
	IndRegua("NO1",CriaTrab(Nil,.f.),IndexKey(),,cFiltro,"Criando Indice...")

	aAdd(aArqTMP,{"NO1_FILIAL","C",002,00})	
	aAdd(aArqTMP,{"NO1_NUMERO","C",006,00})
	aAdd(aArqTMP,{"NO1_NUMCMP","C",020,00})
	aAdd(aArqTMP,{"NO1_CODCLI","C",006,00})
	aAdd(aArqTMP,{"NO1_LOJCLI","C",002,00})
	aAdd(aArqTMP,{"NO1_NOMCLI","C",040,00})
	aAdd(aArqTMP,{"NO1_DATEMI","D",008,00})
	aAdd(aArqTMP,{"NO1_DATVEN","D",008,00})
	aAdd(aArqTMP,{"NO1_MOEDA ","N",002,00})
	aAdd(aArqTMP,{"NO1_NATURE","C",010,00})
	aAdd(aArqTMP,{"NO1_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"NO1_CODPRO","C",015,00})
	aAdd(aArqTMP,{"NO1_DESPRO","C",040,00})
	aAdd(aArqTMP,{"NO1_UM1PRO","C",002,00})
	aAdd(aArqTMP,{"NO1_QTDPRO","N",014,02})
	aAdd(aArqTMP,{"NO1_CONTAC","C",020,00})
	aAdd(aArqTMP,{"NO1_CCC   ","C",009,00})
	aAdd(aArqTMP,{"NO1_CLVLC ","C",009,00})
	aAdd(aArqTMP,{"NO1_ITEMC ","C",009,00})
	aAdd(aArqTMP,{"NO1_HISTOR","C",080,00})
	aAdd(aArqTMP,{"NO1_CONTSO","N",014,02})
	aAdd(aArqTMP,{"NO1_FETHAB","N",014,02})
	aAdd(aArqTMP,{"NO1_SALDO ","N",014,02})
	aAdd(aArqTMP,{"NO1_FCHFAT","C",001,00})
	aAdd(aArqTMP,{"NO1_FCHFIN","C",001,00})
	aAdd(aArqTMP,{"NO1_FECHAD","C",001,00})

	//Cria tabela temporária
	cArqTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cArqTMP, {aArqTMP, { {"", "NO1_FILIAL+NO1_CODCLI+NO1_DATVEN+NO1_NUMERO" }} } ) 	

	DbSelectArea("NO1")
	no1->(DbGoTop())
	While no1->(!Eof()) 	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			no1->(dbSkip())
			Loop
		EndIf
		DbSelectArea(cArqTMP)	
		If RecLock(cArqTMP,.t.)
			Replace (cArqTMP)->no1_filial With no1->no1_filial
			Replace (cArqTMP)->no1_numero With no1->no1_numero
			Replace (cArqTMP)->no1_numcmp With no1->no1_numcmp
			Replace (cArqTMP)->no1_codcli With no1->no1_codcli
			Replace (cArqTMP)->no1_lojcli With no1->no1_lojcli
			Replace (cArqTMP)->no1_nomcli With no1->no1_nomcli
			Replace (cArqTMP)->no1_datemi With no1->no1_datemi
			Replace (cArqTMP)->no1_datven With no1->no1_datven
			Replace (cArqTMP)->no1_moeda  With no1->no1_moeda
			Replace (cArqTMP)->no1_nature With no1->no1_nature
			Replace (cArqTMP)->no1_safra  With no1->no1_safra
			Replace (cArqTMP)->no1_codpro With no1->no1_codpro
			Replace (cArqTMP)->no1_despro With no1->no1_despro
			Replace (cArqTMP)->no1_um1pro With no1->no1_um1pro
			Replace (cArqTMP)->no1_qtdpro With no1->no1_qtdpro
			Replace (cArqTMP)->no1_contac With no1->no1_contac
			Replace (cArqTMP)->no1_ccc    With no1->no1_ccc
			Replace (cArqTMP)->no1_clvlc  With no1->no1_clvlc
			Replace (cArqTMP)->no1_itemc  With no1->no1_itemc
			Replace (cArqTMP)->no1_histor With no1->no1_histor
			Replace (cArqTMP)->no1_contso With no1->no1_contso
			Replace (cArqTMP)->no1_fethab With no1->no1_fethab
			Replace (cArqTMP)->no1_saldo  With no1->no1_saldo
			Replace (cArqTMP)->no1_fchfat With no1->no1_fchfat
			Replace (cArqTMP)->no1_fchfin With no1->no1_fchfin
			Replace (cArqTMP)->no1_fechad With no1->no1_fechad		
			MsUnLock(cArqTMP)
		EndIf       				
		DbSelectArea("NO1")
		no1->(dbSkip())
	EndDo

	cFiltro := "D2_NUMCP >= '"+MV_PAR04+"' .And. "
	cFiltro += "D2_NUMCP <= '"+MV_PAR05+"' .And. "
	//Considera Filiais
	If mv_par09==1
		cFiltro += "D2_FILIAL >= '"+mv_par10+"' .And. "
		cFiltro += "D2_FILIAL <= '"+mv_par11+"'"	
	Else
		cFiltro += "D2_FILIAL = '"+xFilial("SD2")+"'"	
	Endif

	DbSelectArea('SD2')
	cArqSD2 := CriaTrab(Nil,.f.)
	IndRegua('SD2',cArqSD2,'D2_NUMCP+DTOS(D2_EMISSAO)',,cFiltro,"Criando Indice...")
	//IndRegua('SD2',cArqSD2,'D2_FILIAL+D2_NUMCP+DTOS(D2_EMISSAO)',,cFiltro,"Criando Indice...")
	#IFNDEF TOP
	dbSetIndex(cArqSD2+OrdBagExT())
	#ENDIF

	Cabec1	:= 'Cliente                              |'+PadC(AllTrim(Posicione('SAH',1,xFilial('SAH')+Alltrim(mv_par08),"AH_DESCPO")),62,'-')+'|'
	Cabec2	:= 'Contrato              Item  Entrega  |       Inicial        Entregue      A Entregar           Saldo| Status   Historico           '
	// 'XXXXXXXXXXXXXXXXXXXX   999  99/99/99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  A Fixar  XXXXXXXXXXXXXXXXXXXX

	DbSelectArea(cArqTMP)
	SetRegua((cArqTMP)->(RecCount()))
	(cArqTMP)->(Dbgotop())
	While (cArqTMP)->(!Eof())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Armazena a Filial³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFil	:=	(cArqTMP)->no1_filial	

		nSQtFilF 	:=	0	
		nSQtFilA 	:=	0	
		nTQtFil 	:=	0	
		nSEnFilF 	:=	0	
		nSEnFilA 	:=	0	
		nTEnFil 	:=	0	

		While (cArqTMP)->(!Eof()) .And. (cArqTMP)->no1_filial==cFil
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Armazena o Cliente³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCli	:=	(cArqTMP)->no1_codcli

			nSQtCliF 	:=	0	
			nSQtCliA 	:=	0	
			nTQtCli 	:=	0	
			nSEnCliF 	:=	0	
			nSEnCliA 	:=	0	
			nTEnCli 	:=	0	
			nSldCli		:=	0

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Salto de Página. Neste caso o formulario tem 55 linhas...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 55  
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
			@ nLin,000 Psay PadR((cArqTMP)->no1_nomcli,40)
			nLin++	    	
			While (cArqTMP)->(!Eof()) .And. (cArqTMP)->no1_filial==cFil .And. (cArqTMP)->no1_codcli==cCli 	 		

				dUltDta	:= 	Ctod('01/01/1980')

				IncRegua((cArqTMP)->no1_nomcli)

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             
				@ nLin,000 Psay PadR((cArqTMP)->no1_numcmp,20)   
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Itens do Compromisso³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NO2")
				DbSetOrder(2)
				If DbSeek((cArqTMP)->no1_filial+(cArqTMP)->no1_numero)
					While no2->(!Eof()) .And. no2->no2_filial==(cArqTMP)->no1_filial .And. no2->no2_numcp==(cArqTMP)->no1_numero 	   	 			

						nQuant		:=	0
						nEntreg		:=	IIf(Empty(nSldEnt),0,nSldEnt)
						nSldEnt		:=	0
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica a Quantidade Entregue³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						DbSelectArea("SD2")					
						If DbSeek((cArqTMP)->no1_numero) //If DbSeek((cArqTMP)->no1_filial+(cArqTMP)->no1_numero) 
							While sd2->(!Eof()) .And. sd2->d2_numcp==(cArqTMP)->no1_numero .And. sd2->d2_emissao<=no2->no2_datent
								If sd2->d2_emissao>dUltDta	
									//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
									//³Verifica a Unidade de Medida³
									//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
									If Upper(Alltrim(sd2->d2_um))<>Upper(Alltrim(mv_par08)) 
										nEntreg		+=	Agrx001(sd2->d2_um,mv_par08,sd2->d2_quant)			
										//			                    	nSldCli		-=	Agrx001(sd2->d2_um,mv_par08,sd2->d2_quant)			
									Else
										nEntreg		+=	sd2->d2_quant
										//			                    	nSldCli		-=	sd2->d2_quant
									Endif
								Endif	
								sd2->(DbSkip()) 
							EndDo
						Endif

						dUltDta	:=	no2->no2_datent

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica a Unidade de Medida³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Upper(Alltrim((cArqTMP)->no1_um1pro))<>Upper(Alltrim(mv_par08))
							nQuant		+=	Agrx001((cArqTMP)->no1_um1pro,mv_par08,no2->no2_quant)
							nSldCli		+=	Agrx001((cArqTMP)->no1_um1pro,mv_par08,no2->no2_quant)
						Else
							nQuant		+=	no2->no2_quant
							nSldCli		+=	no2->no2_quant
						Endif

						If nEntreg > nQuant
							nSldEnt	:=	nEntreg - nQuant
							nEntreg := nQuant
							nSldCli	-= nEntreg
						Else
							nSldCli	-= nEntreg
						EndIf


						@ nLin,023 Psay Transform(no2->no2_seq,'@e 999')
						@ nLin,028 Psay Dtoc(no2->no2_datent)
						@ nLin,038 Psay Transform(nQuant,'@e 999,999,999.99')
						@ nLin,054 Psay Transform(nEntreg,'@e 999,999,999.99')
						@ nLin,070 Psay Transform((nQuant-nEntreg),'@e 999,999,999.99')
						@ nLin,086 Psay Transform(nSldCli,'@e 999,999,999.99')

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Verifica se eh Fixado³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						If Empty(no2->no2_datprc) .Or. Empty(no2->no2_datprm) .Or. Empty(no2->no2_datdes) .Or. Empty(no2->no2_dataro)      
							@ nLin,102 Psay 'A Fixar'	   	 			   
							nSQtGerA  	+=	nQuant	
							nSQtFilA  	+=	nQuant	
							nSQtCliA  	+=	nQuant	
							nSEnGerA  	+=	nEntreg
							nSEnFilA  	+=	nEntreg
							nSEnCliA  	+=	nEntreg
						Else
							@ nLin,102 Psay 'Fixado'	   	 			   	   	 			
							nSQtGerF  	+=	nQuant	
							nSQtFilF  	+=	nQuant	
							nSQtCliF  	+=	nQuant
							nSEnGerF  	+=	nEntreg
							nSEnFilF  	+=	nEntreg
							nSEnCliF  	+=	nEntreg
						Endif	   	 			
						nTQtGer  	+=	nQuant	
						nTQtFil  	+=	nQuant	
						nTQtCli  	+=	nQuant	
						nTEnGer  	+=	nEntreg
						nTEnFil  	+=	nEntreg
						nTEnCli  	+=	nEntreg
						@ nLin,111 Psay PadR(no2->no2_histor,21) 
						nLin++	    							                    		

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Salto de Página. Neste caso o formulario tem 55 linhas...³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If nLin > 55  
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						Endif             			
						no2->(DbSkip())
					EndDo
				Endif
				(cArqTMP)->(DbSkip())
			EndDo    
			nLin++
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Salto de Página. Neste caso o formulario tem 55 linhas...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 55  
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
			If nSQtCliF>0
				@nLin,000 Psay "Total Fixado Cliente -->"
				@nLin,038 Psay Transform(nSQtCliF,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nSEnCliF,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nSQtCliF-nSEnCliF),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif	
			If nSQtCliA>0
				@nLin,000 Psay "Total A Fixar Cliente ->"
				@nLin,038 Psay Transform(nSQtCliA,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nSEnCliA,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nSQtCliA-nSEnCliA),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif	
			If nSQtCliF>0 .And. nSQtCliA>0
				@nLin,000 Psay "        Total Cliente ->"
				@nLin,038 Psay Transform(nTQtCli,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nTEnCli,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nTQtCli-nTEnCli),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif		
			nLin++
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Salto de Página. Neste caso o formulario tem 55 linhas...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 55  
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
		EndDo    
		If !((mv_par09==2) .Or. (mv_par09==1 .And. mv_par10==mv_par11)) 	
			nLin++
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Salto de Página. Neste caso o formulario tem 55 linhas...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 55  
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
			If nSQtFilF>0
				@nLin,000 Psay "Total Fixado Filial -->"
				@nLin,038 Psay Transform(nSQtFilF,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nSEnFilF,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nSQtFilF-nSEnFilF),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif	
			If nSQtFilA>0
				@nLin,000 Psay "Total A Fixar Filial ->"
				@nLin,038 Psay Transform(nSQtFilA,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nSEnFilA,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nSQtFilA-nSEnFilA),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif	
			If nSQtFilF>0 .And. nSQtFilA>0
				@nLin,000 Psay "        Total Filial ->"
				@nLin,038 Psay Transform(nTQtFil,'@e 999,999,999.99')
				@nLin,054 Psay Transform(nTEnFil,'@e 999,999,999.99')
				@nLin,070 Psay Transform((nTQtFil-nTEnFil),'@e 999,999,999.99')
				nLin++
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Salto de Página. Neste caso o formulario tem 55 linhas...³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             		
			Endif		
			nLin++	    							                    			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Salto de Página. Neste caso o formulario tem 55 linhas...³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nLin > 55  
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             
		Endif
	EndDo  
	If nSQtGerF>0
		@nLin,000 Psay "Total Fixado Geral -->"
		@nLin,038 Psay Transform(nSQtGerF,'@e 999,999,999.99')
		@nLin,054 Psay Transform(nSEnGerF,'@e 999,999,999.99')
		@nLin,070 Psay Transform((nSQtGerF-nSEnGerF),'@e 999,999,999.99')
		nLin++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salto de Página. Neste caso o formulario tem 55 linhas...³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55  
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             
	Endif	
	If nSQtGerA>0
		@nLin,000 Psay "Total A Fixar Geral ->"
		@nLin,038 Psay Transform(nSQtGerA,'@e 999,999,999.99')
		@nLin,054 Psay Transform(nSEnGerA,'@e 999,999,999.99')
		@nLin,070 Psay Transform((nSQtGerA-nSEnGerA),'@e 999,999,999.99')
		nLin++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salto de Página. Neste caso o formulario tem 55 linhas...³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55  
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             
	Endif	
	If nSQtGerF>0 .And. nSQtGerA>0
		@nLin,000 Psay "        Total Geral ->"
		@nLin,038 Psay Transform(nTQtGer,'@e 999,999,999.99')
		@nLin,054 Psay Transform(nTEnGer,'@e 999,999,999.99')
		@nLin,070 Psay Transform((nTQtGer-nTEnGer),'@e 999,999,999.99')
		nLin++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salto de Página. Neste caso o formulario tem 55 linhas...³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin > 55  
			If nLin < 80
				Roda()
			EndIf
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 9
		Endif             
	Endif
	(cArqTMP)->(dbCloseArea())
	FErase(cArqSD2+OrdBagExt())

	Set Filter To

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
