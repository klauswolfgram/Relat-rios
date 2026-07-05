/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp := Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ AGRR102  บ Autor ณ Danyel Bernuci     บ Data ณ  15/01/2006 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Resumo de Compromissos - Financeiro    		              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Clientes Microsiga                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function AGRR102()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Resumo de Compromissos - Financeiro"
	Local titulo         := "Resumo de Compromissos - Financeiro"
	Local nLin           := 132
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR102'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR102"
	Private wnrel       := "AGRR102"
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ Danyel Bernuci     บ Data ณ  15/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]

	Local	nProvis	:=  0
	Local	nAdiant	:=	0
	Local	nJuros	:=	0
	Local	nFunru	:=	0 
	Local	nFetab	:=	0 
	Local	nLiquid	:=	0
	Local	nAReceb	:=	0
	Local	lAReceb :=	.F.

	Local	nProCli	:=  0
	Local	nAdiCli	:=	0
	Local	nFunCli	:=	0 
	Local	nFetCli	:=	0 
	Local	nJurCli	:=	0 
	Local	nLiqCli	:=	0
	Local	nAReCli	:=	0

	Local	nProFil	:=  0
	Local	nAdiFil	:=	0
	Local	nFunFil	:=	0 
	Local	nFetFil	:=	0 
	Local	nJurFil	:=	0 
	Local	nLiqFil	:=	0
	Local	nAReFil	:=	0

	Local	nProGer	:=  0
	Local	nAdiGer	:=	0
	Local	nFunGer	:=	0 
	Local	nFetGer	:=	0 
	Local	nJurGer	:=	0 
	Local	nLiqGer	:=	0
	Local	nAReGer	:=	0

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

	//Cria tabela temporแria
	cArqTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cArqTMP, {aArqTMP, {{"", "NO1_FILIAL+NO1_CODCLI+NO1_NUMERO" }}} ) 

	DbSelectArea("NO1")
	no1->(DbGoTop())
	While no1->(!Eof()) 	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Avalia filtro do usuario                        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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

	Cabec1	:= 'Cliente               |'+PadC(Alltrim(GetMv('MV_MOEDAP'+Alltrim(Str(mv_par08)))),109,'-')+'|'
	Cabec2	:= 'Contrato              |    Provisorio    Adiantamento           Juros         FunRual          Fethab         Liquido      A Receber|'
	// 'XXXXXXXXXXXXXXXXXXXX   999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99  999,999,999.99

	DbSelectArea(cArqTMP)
	SetRegua((cArqTMP)->(RecCount()))
	(cArqTMP)->(Dbgotop())
	While (cArqTMP)->(!Eof())
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณArmazena a Filialณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		cFil	:=	(cArqTMP)->no1_filial	

		nProFil	:=  0
		nAdiFil	:=	0
		nFunFil	:=	0 
		nFetFil	:=	0 
		nJurFil	:=	0 
		nLiqFil	:=	0
		nAReFil	:=	0

		While (cArqTMP)->(!Eof()) .And. (cArqTMP)->no1_filial==cFil
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณArmazena o Clienteณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			cCli	:=	(cArqTMP)->no1_codcli	 	   	

			nProCli	:=  0
			nAdiCli	:=	0
			nFunCli	:=	0 
			nFetCli	:=	0 
			nJurCli	:=	0 
			nLiqCli	:=	0
			nAReCli	:=	0

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณSalto de Pแgina. Neste caso o formulario tem 55 linhas...ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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

				nProvis	:=  0
				nAdiant	:=	0
				nFunru	:=	0 
				nFetab	:=	0 
				nJuros	:=	0 
				nLiquid	:=	0

				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ao<ฟ
				//ณPosiciona no titulo a receber relacionado ao ณ
				//ณcompromisso e obtem o saldo a receber        ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ ao<ู

				DbSelectArea("SE1")
				DbSetOrder(1)
				If DbSeek(xFilial("SE1")+"CP "+(cArqTMP)->no1_numero+" "+"DP")
					//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
					//ณVerifica a Moedaณ
					//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
					If se1->e1_moeda<>mv_par08
						If se1->e1_moeda<>1 .And. mv_par08<>1   
							nAReceb		:=	xMoeda(se1->e1_saldo,se1->e1_moeda,1,dDataBase,(Msdecimais(1)+1))
							nAReceb		:=	xMoeda(nAReceb,1,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))
						Else
							nAReceb		:=	xMoeda(se1->e1_saldo,se1->e1_moeda,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))						
						Endif
					Else                                                
						nAReceb		:=	se1->e1_saldo
					Endif
					lAReceb :=	.T.
				Else
					nAReceb	:=	0
					lAReceb :=	.F.
				Endif

				IncRegua((cArqTMP)->no1_nomcli)

				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
				//ณSalto de Pแgina. Neste caso o formulario tem 55 linhas...ณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
				If nLin > 55  
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             
				@ nLin,000 Psay PadR((cArqTMP)->no1_numcmp,20)   

				DbSelectArea('NO3')
				DbSetOrder(1)
				If DbSeek((cArqTMP)->no1_filial+(cArqTMP)->no1_numero)
					While no3->(!Eof()) .And. no3->no3_filial==(cArqTMP)->no1_filial .And. no3->no3_numcp==(cArqTMP)->no1_numero
						//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
						//ณVerifica a Moedaณ
						//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
						If no3->no3_moeda<>mv_par08
							If no3->no3_moeda<>1 .And. mv_par08<>1   
								nTotal		:=	xMoeda(no3->no3_valor,no3->no3_moeda,1,dDataBase,(Msdecimais(1)+1))
								nTotal		:=	xMoeda(nTotal,1,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))
							Else
								nTotal		:=	xMoeda(no3->no3_valor,no3->no3_moeda,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))						
							Endif
						Else                                                
							nTotal		:=	no3->no3_valor					
						Endif
						//Provisorio
						If  Alltrim(Upper(no3->no3_tipo))=="PR"
							nProvis	+=	nTotal
							nProCli	+=	nTotal
							nProFil	+=	nTotal
							nProGer	+=	nTotal
						Endif
						//Adiantamento
						If  Alltrim(Upper(no3->no3_tipo))=="RA"
							nAdiant	+=	nTotal
							nAdiCli	+=	nTotal
							nAdiFil	+=	nTotal
							nAdiGer	+=	nTotal
						Endif
						//Juros
						If  Alltrim(Upper(no3->no3_tipo))=="JR-"
							nJuros	+=	nTotal
							nJurCli	+=	nTotal
							nJurFil	+=	nTotal
							nJurGer	+=	nTotal
						Endif
						//FunRual
						If  Alltrim(Upper(no3->no3_tipo)) $ "FU-"
							nFunru	+=	nTotal
							nFunCli	+=	nTotal
							nFunFil	+=	nTotal
							nFunGer	+=	nTotal
						Endif					
						//Fethab
						If  Alltrim(Upper(no3->no3_tipo)) $ "FE-"
							nFetab	+=	nTotal
							nFetCli	+=	nTotal
							nFetFil	+=	nTotal
							nFetGer	+=	nTotal
						Endif					
						no3->(DbSkip())
					EndDo
				End			       
				nLiquid	:= nProvis-(nAdiant+nFetab+nFunru+nJuros)					 
				If .Not. lAReceb
					nAReceb	+=	nLiquid
				Endif 
				nLiqCli	+= nProvis-(nAdiant+nFetab+nFunru+nJuros)					 
				nAReCli	+=	nAReceb
				nLiqFil	+= nProvis-(nAdiant+nFetab+nFunru+nJuros)					 
				nAReFil	+=	nAReceb
				nLiqGer	+= nProvis-(nAdiant+nFetab+nFunru+nJuros)					 
				nAReGer	+=	nAReceb

				@ nLin,023 Psay Transform(nProvis,'@e 999,999,999.99')
				@ nLin,039 Psay Transform(nAdiant,'@e 999,999,999.99')
				@ nLin,055 Psay Transform(nJuros ,'@e 999,999,999.99')
				@ nLin,071 Psay Transform(nFunru ,'@e 999,999,999.99')
				@ nLin,087 Psay Transform(nFetab ,'@e 999,999,999.99')
				@ nLin,103 Psay Transform(nLiquid,'@e 999,999,999.99')
				@ nLin,118 Psay Transform(nAReceb,'@e 999,999,999.99')
				nLin++

				(cArqTMP)->(DbSkip())
			EndDo  
			nLin++			  
			@ nLin,000 Psay PadR("Total Cliente",20)
			@ nLin,023 Psay Transform(nProCli,'@e 999,999,999.99')
			@ nLin,039 Psay Transform(nAdiCli,'@e 999,999,999.99')
			@ nLin,055 Psay Transform(nJurCli,'@e 999,999,999.99')
			@ nLin,071 Psay Transform(nFunCli,'@e 999,999,999.99')
			@ nLin,087 Psay Transform(nFetCli,'@e 999,999,999.99')
			@ nLin,103 Psay Transform(nLiqCli,'@e 999,999,999.99')
			@ nLin,118 Psay Transform(nAReCli,'@e 999,999,999.99')
			nLin++			  
			nLin++			  
		EndDo    
		If !((mv_par09==2) .Or. (mv_par09==1 .And. mv_par10==mv_par11)) 	
			nLin++			  
			@ nLin,000 Psay PadR("Total Filial",20)
			@ nLin,023 Psay Transform(nProFil,'@e 999,999,999.99')
			@ nLin,039 Psay Transform(nAdiFil,'@e 999,999,999.99')
			@ nLin,055 Psay Transform(nJurFil,'@e 999,999,999.99')
			@ nLin,071 Psay Transform(nFunFil,'@e 999,999,999.99')
			@ nLin,087 Psay Transform(nFetFil,'@e 999,999,999.99')
			@ nLin,103 Psay Transform(nLiqFil,'@e 999,999,999.99')
			@ nLin,118 Psay Transform(nAReFil,'@e 999,999,999.99')
			nLin++			  
		Endif
	EndDo  
	nLin++			  
	@ nLin,000 Psay PadR("Total Geral",20)
	@ nLin,023 Psay Transform(nProGer,'@e 999,999,999.99')
	@ nLin,039 Psay Transform(nAdiGer,'@e 999,999,999.99')
	@ nLin,055 Psay Transform(nJurGer,'@e 999,999,999.99')
	@ nLin,071 Psay Transform(nFunGer,'@e 999,999,999.99')
	@ nLin,087 Psay Transform(nFetGer,'@e 999,999,999.99')
	@ nLin,103 Psay Transform(nLiqGer,'@e 999,999,999.99')
	@ nLin,118 Psay Transform(nAReGer,'@e 999,999,999.99')
	nLin++			  

	(cArqTMP)->(dbCloseArea())

	Set Filter To

	Roda()

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Finaliza a execucao do relatorio...                                 ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	SET DEVICE TO SCREEN

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return()
