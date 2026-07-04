/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

Static oArqTemp 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ AGRR101  º Autor ³ Danyel Bernuci     º Data ³  14/01/2006 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Resumo de Compromissos - Fixacoes.    		              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Clientes Microsiga                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR101()
	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Resumo de Compromissos - Fixacoes"
	Local titulo         := "Resumo de Compromissos - Fixacoes"
	Local nLin           := 220
	Local Cabec1         := ""
	Local Cabec2         := ""
	

	Private aOrd        := {}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 220
	Private tamanho     := "G"
	Private nomeprog    := 'AGRR101'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR101"
	Private wnrel       := "AGRR101"
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
±±ºFun‡„o    ³RUNREPORT º Autor ³ Danyel Bernuci     º Data ³  14/01/06   º±±
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
	Local	__k

	Local	cUnPad		:=	"SC"
	Local	nQuant		:=	0
	Local	nTotal		:=	0

	Local	nSVlCliF 	:=	0	
	Local	nSVlCliA 	:=	0	
	Local	nTVlCli 	:=	0	
	Local	nSVlFilF 	:=	0	
	Local	nSVlFilA 	:=	0	
	Local	nTVlFil 	:=	0	
	Local	nSVlGerF 	:=	0	
	Local	nSVlGerA 	:=	0	
	Local	nTVlGer 	:=	0	

	Local	nSQtCliF 	:=	0	
	Local	nSQtCliA 	:=	0	
	Local	nTQtCli 	:=	0	
	Local	nSQtFilF 	:=	0	
	Local	nSQtFilA 	:=	0	
	Local	nTQtFil 	:=	0	
	Local	nSQtGerF 	:=	0	
	Local	nSQtGerA 	:=	0	
	Local	nTQtGer 	:=	0	

	Local	aResCli		:=	{}
	Local	aResFil		:=	{}
	Local	aResGer		:=	{}
	Local	aResFch		:=	{}
	Local	aRParFix	:=	{}
	Local	aRParAFi	:=	{}
	Local	aRParPre	:=	{}
	Local   cSimbolo    := SuperGetMv('MV_SIMB1',.F. , "R$")

	Private aArqTMP	:=	{}
	Private cIndTMP

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Array de Resumo da Unidade de Medida Media do Parametro e Moeda Media do Parametro Fixado³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd(aRParFix,{	mv_par15,;	//[01]-Unidade de Medida Media do Parametro
	mv_par14,;	//[02]-Moeda da Media do Parametro
	0,;			//[03]-Principal
	0,;			//[04]-Premio
	0,;			//[05]-Despesa
	0,;			//[06]-Arrolagem
	0,;			//[07]-Total
	0,;			//[08]-Quantidade Principal
	0,;			//[09]-Quantidade Premio
	0,;			//[10]-Quantidade Despesa
	0,;			//[11]-Quantidade Arrolagem
	0,;			//[12]-Quantidade Total
	0,;			//[13]-Quantidade Total Fixado
	0})			//[14]-Total Liquido Fixado

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Array de Resumo da Unidade de Medida Media do Parametro e Moeda Media do Parametro a Fixar³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd(aRParAFi,{	mv_par15,;	//[01]-Unidade de Medida Media do Parametro
	mv_par14,;	//[02]-Moeda da Media do Parametro
	0,;			//[03]-Principal
	0,;			//[04]-Premio
	0,;			//[05]-Despesa
	0,;			//[06]-Arrolagem
	0,;			//[07]-Total
	0,;			//[08]-Quantidade Principal
	0,;			//[09]-Quantidade Premio
	0,;			//[10]-Quantidade Despesa
	0,;			//[11]-Quantidade Arrolagem
	0,;			//[12]-Quantidade Total
	0,;			//[13]-Quantidade Total a Fixar
	0})			//[14]-Total Liquido a Fixar

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Array de Resumo da Unidade de Medida Media do Parametro e Moeda Media do Parametro Previsto³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd(aRParPre,{	mv_par15,;	//[01]-Unidade de Medida Media do Parametro
	mv_par14,;	//[02]-Moeda da Media do Parametro
	0,;			//[03]-Principal
	0,;			//[04]-Premio
	0,;			//[05]-Despesa
	0,;			//[06]-Arrolagem
	0,;			//[07]-Total
	0,;			//[08]-Quantidade Principal
	0,;			//[09]-Quantidade Premio
	0,;			//[10]-Quantidade Despesa
	0,;			//[11]-Quantidade Arrolagem
	0,;			//[12]-Quantidade Total
	0,;			//[13]-Quantidade Total a Fixar
	0})			//[14]-Total Liquido a Fixar

	cFiltro := "NO1_SAFRA  == '"+MV_PAR01+"' .And. "
	cFiltro += "NO1_CODCLI >= '"+MV_PAR02+"' .And. "
	cFiltro += "NO1_CODCLI <= '"+MV_PAR03+"' .And. "
	cFiltro += "NO1_NUMERO >= '"+MV_PAR04+"' .And. "
	cFiltro += "NO1_NUMERO <= '"+MV_PAR05+"' .And. "
	//Considera Filiais
	If mv_par10==1
		cFiltro += "NO1_FILIAL >= '"+MV_PAR11+"' .And. "
		cFiltro += "NO1_FILIAL <= '"+MV_PAR12+"' .And. "	
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
	oArqTemp := AGRCRTPTB(cArqTMP, {aArqTMP, {{"", "NO1_FILIAL+NO1_CODCLI+NO1_NUMERO" }}} )

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

	Cabec1	:= 'Cliente'
	Cabec2	:= If(mv_par13==2,'Contrato',Space(08))+'              '+If(mv_par13==2,'Item',Space(04))+'        Quant.'+If(Len(Alltrim(mv_par09))>0,mv_par09,"UM")+'  '+If(mv_par13==2,'Entrega',Space(07))+'   '+If(mv_par13==2,'UM',Space(02))+'  '+If(mv_par13==2,'Moed',Space(04))+'    '+If(mv_par13==2,'Taxa',Space(04))+' '+If(mv_par13==2,' Principal','Med.Princ.')+'    '+If(mv_par13==2,'Data',Space(04))+'    '+If(mv_par13==2,'    Premio','Med.Premio')+'    '+If(mv_par13==2,'Data',Space(04))+'     '+If(mv_par13==2,' Despesas','Med.Desp.')+'    '+If(mv_par13==2,'Data',Space(04))+'   '+If(mv_par13==2,'  Arrolagem','Med.Arrolag')+'    '+If(mv_par13==2,'Data',Space(04))+'         '+If(mv_par13==2,'    Total','Med.Total')+' '+PadL('Total '+Alltrim(GetMv('MV_SIMB'+Alltrim(Str(mv_par08)))),15)+'  '+If(mv_par13==2,'Status   Historico','')


	DbSelectArea(cArqTMP)
	SetRegua( (cArqTMP)->(RecCount()))
	(cArqTMP)->(Dbgotop())
	While (cArqTMP)->(!Eof())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Armazena a Filial³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cFil	:=	(cArqTMP)->no1_filial	

		nSVlFilF 	:=	0	
		nSVlFilA 	:=	0	
		nTVlFil 	:=	0	
		nSQtFilF 	:=	0	
		nSQtFilA 	:=	0	
		nTQtFil 	:=	0	

		aResFil		:=	{}

		While (cArqTMP)->(!Eof()) .And. (cArqTMP)->no1_filial==cFil
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Armazena o Cliente³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCli	:=	(cArqTMP)->no1_codcli	 	   	

			nSVlCliF 	:=	0	
			nSVlCliA 	:=	0	
			nTVlCli 	:=	0	
			nSQtCliF 	:=	0	
			nSQtCliA 	:=	0	
			nTQtCli 	:=	0	

			aResCli		:=	{}

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

				nQuant		:=	0
				nTotal		:=	0

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
				If mv_par13==2	//Analitico
					@ nLin,000 Psay PadR((cArqTMP)->no1_numcmp,20)   
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Itens do Compromisso³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				DbSelectArea("NO2")
				DbSetOrder(1)
				If DbSeek((cArqTMP)->no1_filial+(cArqTMP)->no1_numero)
					While no2->(!Eof()) .And. no2->no2_filial==(cArqTMP)->no1_filial .And. no2->no2_numcp==(cArqTMP)->no1_numero 	   	 			
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica a Unidade de Medida³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Len(Alltrim(mv_par09))>0
							If Upper(Alltrim((cArqTMP)->no1_um1pro))<>Upper(Alltrim(mv_par09)) 
								nQuant		:=	Agrx001((cArqTMP)->no1_um1pro,mv_par09,no2->no2_quant)
							Else
								nQuant		:=	no2->no2_quant
							Endif						
						Else
							If Upper(Alltrim((cArqTMP)->no1_um1pro))<>cUnPad
								nQuant		:=	Agrx001((cArqTMP)->no1_um1pro,cUnPad,no2->no2_quant)
							Else
								nQuant		:=	no2->no2_quant
							Endif											
						Endif  					
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Verifica a Moeda³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
						If mv_par08>0
							If no2->no2_moeda<>mv_par08
								If no2->no2_moeda<>1 .And. mv_par08<>1   
									nTotal		:=	xMoeda(no2->no2_total,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nTotal		:=	xMoeda(nTotal,1,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))
								Else
									nTotal		:=	xMoeda(no2->no2_total,no2->no2_moeda,mv_par08,dDataBase,(Msdecimais(mv_par08)+1))						
								Endif
							Else
								nTotal	:=	no2->no2_total
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nTotal		:=	xMoeda(no2->no2_total,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nTotal		:=	xMoeda(nTotal,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nTotal		:=	xMoeda(no2->no2_total,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nTotal	:=	no2->no2_total
							Endif											
						Endif

						If mv_par13==2	//Analitico
							@ nLin,023 Psay no2->no2_seq
							@ nLin,028 Psay Transform(nQuant,'@e 999,999,999.99')
							@ nLin,044 Psay Dtoc(no2->no2_datent)
							@ nLin,054 Psay PadR(no2->no2_um,2)
							@ nLin,058 Psay StrZero(no2->no2_moeda,2)
							@ nLin,063 Psay Transform (no2->no2_txmoed,'@e 99,999')
							@ nLin,071 Psay Transform(no2->no2_vlrprc,'@e 9,999.9999')
							@ nLin,083 Psay Dtoc(no2->no2_datprc)
							@ nLin,093 Psay Transform(no2->no2_premio,'@e 9,999.9999')
							@ nLin,105 Psay Dtoc(no2->no2_datprm)
							@ nLin,115 Psay Transform(no2->no2_despsa,'@e 9,999.9999')
							@ nLin,127 Psay Dtoc(no2->no2_datdes)
							@ nLin,137 Psay Transform(no2->no2_arolag,'@e 9,999.9999')
							@ nLin,149 Psay Dtoc(no2->no2_dataro)
							@ nLin,159 Psay Transform(no2->no2_total,'@e 999,999,999.99')
							@ nLin,175 Psay Transform(nTotal,'@e 999,999,999.99')	   	 				   	 			
						Endif
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Verifica se eh Fixado³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						If Empty(no2->no2_datprc) .Or. Empty(no2->no2_datprm) .Or. Empty(no2->no2_datdes) .Or. Empty(no2->no2_dataro)      
							_lFixado	:=	.f.                    	
							If mv_par13==2	//Analitico
								@ nLin,191 Psay 'A Fixar'	   	 			   
							Endif
							nSQtGerA  	+=	nQuant	
							nSQtFilA  	+=	nQuant	
							nSQtCliA  	+=	nQuant	
							nSVlGerA  	+=	nTotal
							nSVlFilA  	+=	nTotal	
							nSVlCliA  	+=	nTotal	
						Else
							_lFixado	:=	.t.                    	
							If mv_par13==2	//Analitico
								@ nLin,191 Psay 'Fixado'	   	 			   	   	 			
							Endif
							nSQtGerF  	+=	nQuant	
							nSQtFilF  	+=	nQuant	
							nSQtCliF  	+=	nQuant	
							nSVlGerF  	+=	nTotal	
							nSVlFilF  	+=	nTotal	
							nSVlCliF  	+=	nTotal	
						Endif	   	 			
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Resumo por Cliente ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						__K	:=	Ascan(aResCli,{|x| Upper(Alltrim(x[1]))+StrZero(x[2],2)==Upper(Alltrim(no2->no2_um))+StrZero(no2->no2_moeda,2)})

						If Upper(Alltrim(no2->no2_um))<>Upper(Alltrim((cArqTMP)->no1_um1pro)) 
							nQtdRes		:=	Agrx001((cArqTMP)->no1_um1pro,no2->no2_um,no2->no2_quant)
						Else
							nQtdRes		:=	no2->no2_quant
						Endif						

						If __k>0
							If !Empty(no2->no2_datprc)
								aResCli[__k,03]	+= 	(nQtdRes*no2->no2_vlrprc)	
								aResCli[__k,08]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_datprm)
								aResCli[__k,04]	+= 	(nQtdRes*no2->no2_premio)	
								aResCli[__k,09]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_datdes)
								aResCli[__k,05]	+= 	(nQtdRes*no2->no2_despsa)						 
								aResCli[__k,10]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_dataro)
								aResCli[__k,06]	+= 	(nQtdRes*no2->no2_arolag)						 
								aResCli[__k,11]	+=	nQtdRes
							Endif
							aResCli[__k,07]	+= (nQtdRes*no2->no2_total)
							aResCli[__k,12]	+= nQtdRes
							If _lFixado
								aResCli[__k,13]	+= nQtdRes
								aResCli[__k,14]	+= no2->no2_total					 		
							Else
								aResCli[__k,15]	+= nQtdRes
								aResCli[__k,16]	+= no2->no2_total					 								
							Endif
						Else					 
							Aadd(aResCli,{	no2->no2_um,;													//[01]-Unidade de Medida
							no2->no2_moeda,;												//[02]-Moeda
							If(!Empty(no2->no2_datprc),(nQtdRes*no2->no2_vlrprc),0),;//[03]-Principal
							If(!Empty(no2->no2_datprm),(nQtdRes*no2->no2_premio),0),;//[04]-Premio
							If(!Empty(no2->no2_datdes),(nQtdRes*no2->no2_despsa),0),;//[05]-Despesa
							If(!Empty(no2->no2_dataro),(nQtdRes*no2->no2_arolag),0),;//[06]-Arrolagem
							(nQtdRes*no2->no2_total),;								//[07]-Total
							If(!Empty(no2->no2_datprc),nQtdRes,0),;					//[08]-Quantidade Principal
							If(!Empty(no2->no2_datprm),nQtdRes,0),;					//[09]-Quantidade Premio
							If(!Empty(no2->no2_datdes),nQtdRes,0),;					//[10]-Quantidade Despesa
							If(!Empty(no2->no2_dataro),nQtdRes,0),;					//[11]-Quantidade Arrolagem
							nQtdRes,;												//[12]-Quantidade Total
							If(_lFixado,nQtdRes,0),;									//[13]-Quantidade Total Fixado
							If(_lFixado,no2->no2_total,0),;									//[14]-Valor Total Liquido Fixado
							If(!_lFixado,nQtdRes,0),;								//[15]-Quantidade Total A Fixado
							If(!_lFixado,no2->no2_total,0)})								//[16]-Valor Total Liquido A Fixar
						Endif						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Resumo por Filial ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						__K	:=	Ascan(aResFil,{|x| Upper(Alltrim(x[1]))+StrZero(x[2],2)==Upper(Alltrim(no2->no2_um))+StrZero(no2->no2_moeda,2)})
						If __k>0
							If !Empty(no2->no2_datprc)
								aResFil[__k,03]	+= 	(nQtdRes*no2->no2_vlrprc)	
								aResFil[__k,08]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_datprm)
								aResFil[__k,04]	+= 	(nQtdRes*no2->no2_premio)	
								aResFil[__k,09]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_datdes)
								aResFil[__k,05]	+= 	(nQtdRes*no2->no2_despsa)						 
								aResFil[__k,10]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_dataro)
								aResFil[__k,06]	+= 	(nQtdRes*no2->no2_arolag)						 
								aResFil[__k,11]	+=	nQtdRes
							Endif
							aResFil[__k,07]	+= (nQtdRes*no2->no2_total)
							aResFil[__k,12]	+= nQtdRes					 		
							If _lFixado
								aResFil[__k,13]	+= nQtdRes					 		
								aResFil[__k,14]	+= no2->no2_total					 		
							Else
								aResFil[__k,15]	+= nQtdRes					 		
								aResFil[__k,16]	+= no2->no2_total					 								
							Endif
						Else					 
							Aadd(aResFil,{	no2->no2_um,;													//[01]-Unidade de Medida
							no2->no2_moeda,;												//[02]-Moeda
							If(!Empty(no2->no2_datprc),(nQtdRes*no2->no2_vlrprc),0),;//[03]-Principal
							If(!Empty(no2->no2_datprm),(nQtdRes*no2->no2_premio),0),;//[04]-Premio
							If(!Empty(no2->no2_datdes),(nQtdRes*no2->no2_despsa),0),;//[05]-Despesa
							If(!Empty(no2->no2_dataro),(nQtdRes*no2->no2_arolag),0),;//[06]-Arrolagem
							(nQtdRes*no2->no2_total),;								//[07]-Total
							If(!Empty(no2->no2_datprc),nQtdRes,0),;					//[08]-Quantidade Principal
							If(!Empty(no2->no2_datprm),nQtdRes,0),;					//[09]-Quantidade Premio
							If(!Empty(no2->no2_datdes),nQtdRes,0),;					//[10]-Quantidade Despesa
							If(!Empty(no2->no2_dataro),nQtdRes,0),;					//[11]-Quantidade Arrolagem
							nQtdRes,;												//[12]-Quantidade Total
							If(_lFixado,nQtdRes,0),;									//[13]-Quantidade Total Fixado
							If(_lFixado,no2->no2_total,0),;									//[14]-Valor Total Liquido Fixado
							If(!_lFixado,nQtdRes,0),;								//[15]-Quantidade Total A Fixado
							If(!_lFixado,no2->no2_total,0)})								//[16]-Valor Total Liquido A Fixar
						Endif						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Resumo Geral ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						__K	:=	Ascan(aResGer,{|x| Upper(Alltrim(x[1]))+StrZero(x[2],2)==Upper(Alltrim(no2->no2_um))+StrZero(no2->no2_moeda,2)})
						If __k>0
							If !Empty(no2->no2_datprc)
								aResGer[__k,03]	+= 	(nQtdRes*no2->no2_vlrprc)	
								aResGer[__k,08]	+=	nQtdRes					 		
							Endif
							If !Empty(no2->no2_datprm)
								aResGer[__k,04]	+= 	(nQtdRes*no2->no2_premio)	
								aResGer[__k,09]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_datdes)
								aResGer[__k,05]	+= 	(nQtdRes*no2->no2_despsa)						 
								aResGer[__k,10]	+=	nQtdRes
							Endif
							If !Empty(no2->no2_dataro)
								aResGer[__k,06]	+= 	(nQtdRes*no2->no2_arolag)						 
								aResGer[__k,11]	+=	nQtdRes
							Endif
							aResGer[__k,07]	+= (nQtdRes*no2->no2_total)
							aResGer[__k,12]	+= nQtdRes					 		
							If _lFixado
								aResGer[__k,13]	+= nQtdRes					 		
								aResGer[__k,14]	+= no2->no2_total					 		
							Else
								aResGer[__k,15]	+= nQtdRes					 		
								aResGer[__k,16]	+= no2->no2_total					 								
							Endif
						Else					 
							Aadd(aResGer,{	no2->no2_um,;													//[01]-Unidade de Medida
							no2->no2_moeda,;												//[02]-Moeda
							If(!Empty(no2->no2_datprc),(nQtdRes*no2->no2_vlrprc),0),;//[03]-Principal
							If(!Empty(no2->no2_datprm),(nQtdRes*no2->no2_premio),0),;//[04]-Premio
							If(!Empty(no2->no2_datdes),(nQtdRes*no2->no2_despsa),0),;//[05]-Despesa
							If(!Empty(no2->no2_dataro),(nQtdRes*no2->no2_arolag),0),;//[06]-Arrolagem
							(nQtdRes*no2->no2_total),;								//[07]-Total
							If(!Empty(no2->no2_datprc),nQtdRes,0),;					//[08]-Quantidade Principal
							If(!Empty(no2->no2_datprm),nQtdRes,0),;					//[09]-Quantidade Premio
							If(!Empty(no2->no2_datdes),nQtdRes,0),;					//[10]-Quantidade Despesa
							If(!Empty(no2->no2_dataro),nQtdRes,0),;					//[11]-Quantidade Arrolagem
							nQtdRes,;												//[12]-Quantidade Total
							If(_lFixado,nQtdRes,0),;									//[13]-Quantidade Total Fixado
							If(_lFixado,no2->no2_total,0),;									//[14]-Valor Total Liquido Fixado
							If(!_lFixado,nQtdRes,0),;								//[15]-Quantidade Total A Fixado
							If(!_lFixado,no2->no2_total,0)})								//[16]-Valor Total Liquido A Fixar
						Endif
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Resumo da Media da Unidade e Moeda do Parametro ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes de Unidades de Medidas    ³
						//³da Media do Parametro					   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Len(Alltrim(aRParFix[01,01]))>0
							If Upper(Alltrim((cArqTMP)->no1_um1pro))<>Upper(Alltrim(aRParFix[01,01])) 
								nQtdPar		:=	Agrx001((cArqTMP)->no1_um1pro,aRParFix[01,01],no2->no2_quant)
							Else
								nQtdPar		:=	no2->no2_quant
							Endif						
						Else
							If Upper(Alltrim((cArqTMP)->no1_um1pro))<>cUnPad
								nQtdPar		:=	Agrx001((cArqTMP)->no1_um1pro,cUnPad,no2->no2_quant)
							Else
								nQtdPar		:=	no2->no2_quant
							Endif											
						Endif  					

						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes da Moeda da Media do Para ³
						//³metro - Principal						   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If aRParFix[01,02]>0
							If no2->no2_moeda<>aRParFix[01,02]
								If no2->no2_moeda<>1 .And. aRParFix[01,02]<>1   
									nVlrPar		:=	xMoeda(no2->no2_vlrprc,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_vlrprc,no2->no2_moeda,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_vlrprc
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nVlrPar		:=	xMoeda(no2->no2_vlrprc,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_vlrprc,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_vlrprc
							Endif											
						Endif					
						If !Empty(no2->no2_datprc)
							aRParFix[01,03]	+= 	(nQtdPar*nVlrPar)
							aRParFix[01,08]	+=	nQtdPar 				
						Else
							aRParAFi[01,03]	+= 	(nQtdPar*nVlrPar)
							aRParAFi[01,08]	+=	nQtdPar 								 				 	
						Endif
						aRParPre[01,03] += 	(nQtdPar*nVlrPar)
						aRParPre[01,08]	+=	nQtdPar 								 				 	
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes da Moeda da Media do Para ³
						//³metro - Premio							   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If aRParFix[01,02]>0
							If no2->no2_moeda<>aRParFix[01,02]
								If no2->no2_moeda<>1 .And. aRParFix[01,02]<>1   
									nVlrPar		:=	xMoeda(no2->no2_premio,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_premio,no2->no2_moeda,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_premio
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nVlrPar		:=	xMoeda(no2->no2_premio,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_premio,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_premio
							Endif											
						Endif					
						If !Empty(no2->no2_datprm)
							aRParFix[01,04]	+= 	(nQtdPar*nVlrPar)	
							aRParFix[01,09]	+=	nQtdPar												 	
						Else
							aRParAFi[01,04]	+= 	(nQtdPar*nVlrPar)	
							aRParAFi[01,09]	+=	nQtdPar												 					 	
						Endif
						aRParPre[01,04]	+= 	(nQtdPar*nVlrPar)	
						aRParPre[01,09]	+=	nQtdPar												 					 	
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes da Moeda da Media do Para ³
						//³metro - Despesas							   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If aRParFix[01,02]>0
							If no2->no2_moeda<>aRParFix[01,02]
								If no2->no2_moeda<>1 .And. aRParFix[01,02]<>1   
									nVlrPar		:=	xMoeda(no2->no2_despsa,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_despsa,no2->no2_moeda,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_despsa
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nVlrPar		:=	xMoeda(no2->no2_despsa,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_despsa,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_despsa
							Endif											
						Endif					
						If !Empty(no2->no2_datdes)
							aRParFix[01,05]	+= 	(nQtdPar*nVlrPar)	
							aRParFix[01,10]	+=	nQtdPar												 	
						Else
							aRParAFi[01,05]	+= 	(nQtdPar*nVlrPar)	
							aRParAFi[01,10]	+=	nQtdPar												 					 	
						Endif
						aRParPre[01,05]	+= 	(nQtdPar*nVlrPar)	
						aRParPre[01,10]	+=	nQtdPar												 					 	
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes da Moeda da Media do Para ³
						//³metro - Arrolagem						   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If aRParFix[01,02]>0
							If no2->no2_moeda<>aRParFix[01,02]
								If no2->no2_moeda<>1 .And. aRParFix[01,02]<>1   
									nVlrPar		:=	xMoeda(no2->no2_arolag,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_arolag,no2->no2_moeda,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_arolag
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nVlrPar		:=	xMoeda(no2->no2_arolag,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_arolag,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_arolag
							Endif											
						Endif					
						If !Empty(no2->no2_dataro)
							aRParFix[01,06]	+= 	(nQtdPar*nVlrPar)	
							aRParFix[01,11]	+=	nQtdPar												 	
						Else
							aRParAFi[01,06]	+= 	(nQtdPar*nVlrPar)	
							aRParAFi[01,11]	+=	nQtdPar												 					 	
						Endif              
						aRParPre[01,06]	+= 	(nQtdPar*nVlrPar)	
						aRParPre[01,11]	+=	nQtdPar												 					 	
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Faz as Conversoes da Moeda da Media do Para ³
						//³metro - Total							   ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If aRParFix[01,02]>0
							If no2->no2_moeda<>aRParFix[01,02]
								If no2->no2_moeda<>1 .And. aRParFix[01,02]<>1   
									nVlrPar		:=	xMoeda(no2->no2_total,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_total,no2->no2_moeda,aRParFix[01,02],dDataBase,(Msdecimais(aRParFix[01,02])+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_total
							Endif						
						Else
							If no2->no2_moeda<>nMdPad
								If no2->no2_moeda<>1 .And. nMdPad<>1   
									nVlrPar		:=	xMoeda(no2->no2_total,no2->no2_moeda,1,dDataBase,(Msdecimais(1)+1))
									nVlrPar		:=	xMoeda(nVlrPar,1,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))
								Else
									nVlrPar		:=	xMoeda(no2->no2_total,no2->no2_moeda,nMdPad,dDataBase,(Msdecimais(nMdPad)+1))						
								Endif
							Else
								nVlrPar	:=	no2->no2_total
							Endif											
						Endif					
						If _lFixado
							aRParFix[01,07]	+= 	(nQtdPar*nVlrPar)	
							aRParFix[01,12]	+=	nQtdPar												 				 	
							aRParFix[01,13]	+= 	nQtdPar												 				 	
							aRParFix[01,14]	+= 	nVlrPar
						Else
							aRParAFi[01,07]	+= 	(nQtdPar*nVlrPar)	
							aRParAFi[01,12]	+=	nQtdPar												 				 	
							aRParAFi[01,13]	+= 	nQtdPar												 				 	
							aRParAFi[01,14]	+= 	nVlrPar					
						Endif					
						aRParPre[01,07]	+= 	(nQtdPar*nVlrPar)	
						aRParPre[01,12]	+=	nQtdPar												 					 	
						aRParPre[01,13]	+= 	nQtdPar												 				 	
						aRParPre[01,14]	+= 	nVlrPar					
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZ¿
						//³Resumo de Fechamento ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄZÙ
						__K	:=	Ascan(aResFch,{|y| Upper(Alltrim(y[1]))+Upper(Alltrim(y[2]))+StrZero(y[3],2)==Upper(Alltrim((cArqTMP)->no1_codcli))+Upper(Alltrim(no2->no2_um))+StrZero(no2->no2_moeda,2)})

						If Upper(Alltrim(no2->no2_um))<>Upper(Alltrim((cArqTMP)->no1_um1pro)) 
							nQtdFec		:=	Agrx001((cArqTMP)->no1_um1pro,no2->no2_um,no2->no2_quant)
						Else
							nQtdFec		:=	no2->no2_quant
						Endif						

						If __k>0
							If !Empty(no2->no2_datprc)
								aResFch[__k,05]	+= (nQtdFec*no2->no2_vlrprc)	
								aResFch[__k,10]	+= nQtdFec
							Endif
							If !Empty(no2->no2_datprm)
								aResFch[__k,06]	+= (nQtdFec*no2->no2_premio)	
								aResFch[__k,11]	+= nQtdFec	
							Endif
							If !Empty(no2->no2_datdes)
								aResFch[__k,07]	+= (nQtdFec*no2->no2_despsa)						 
								aResFch[__k,12]	+= nQtdFec						 
							Endif
							If !Empty(no2->no2_dataro)
								aResFch[__k,08]	+= (nQtdFec*no2->no2_arolag)						 
								aResFch[__k,13]	+= nQtdFec						 
							Endif
							aResFch[__k,09]	+= 	(nQtdFec*no2->no2_total)
							aResFch[__k,14]	+=	nQtdFec					 		
							If _lFixado
								aResFch[__k,15]	+= nQtdFec					 		
								aResFch[__k,16]	+= no2->no2_total
							Else
								aResFch[__k,17]	+= nQtdFec					 		
								aResFch[__k,18]	+= no2->no2_total
							Endif	
						Else					 
							Aadd(aResFch,{	(cArqTMP)->no1_codcli,;												//[01]-Codigo do Cliente
							no2->no2_um,;													//[02]-Unidade de Medida
							no2->no2_moeda,;												//[03]-Moeda
							(cArqTMP)->no1_nomcli,;												//[04]-Nome do Cliente
							If(!Empty(no2->no2_datprc),(nQtdFec*no2->no2_vlrprc),0),;//[05]-Principal
							If(!Empty(no2->no2_datprm),(nQtdFec*no2->no2_premio),0),;//[06]-Premio
							If(!Empty(no2->no2_datdes),(nQtdFec*no2->no2_despsa),0),;//[07]-Despesa
							If(!Empty(no2->no2_dataro),(nQtdFec*no2->no2_arolag),0),;//[08]-Arrolagem
							(nQtdFec*no2->no2_total),;								//[09]-Total
							If(!Empty(no2->no2_datprc),nQtdFec,0),;					//[10]-Quantidade Principal
							If(!Empty(no2->no2_datprm),nQtdFec,0),;					//[11]-Quantidade Premio
							If(!Empty(no2->no2_datdes),nQtdFec,0),;					//[12]-Quantidade Despesa
							If(!Empty(no2->no2_dataro),nQtdFec,0),;					//[13]-Quantidade Arrolagem
							nQtdFec,;												//[14]-Quantidade Total
							If(_lFixado,nQtdFec,0),;								//[15]-Quantidade Total Fixado
							If(_lFixado,no2->no2_total,0),;							//[16]-Valor Total Liquido Fixado
							If(!_lFixado,nQtdFec,0),;								//[17]-Quantidade Total A Fixado
							If(!_lFixado,no2->no2_total,0)})						//[18]-Valor Total Liquido A Fixar
						Endif																							 																			 	
						nTQtGer  	+=	nQuant	
						nTQtFil  	+=	nQuant	
						nTQtCli  	+=	nQuant	
						nTVlGer  	+=	nTotal
						nTVlFil  	+=	nTotal	
						nTVlCli  	+=	nTotal								   	 			
						If mv_par13==2	//Analitico
							@ nLin,200 Psay PadR(no2->no2_histor,19) 
							nLin++	    							                    		
						Endif
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
			nLin++
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞ¿
			//³Lista o Total Cliente³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞÙ
			If nSQtCliF>0
				@nLin,000 Psay "Total Fixado Cliente -->"
				@nLin,028 Psay Transform(nSQtCliF,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nSVlCliF,'@e 999,999,999.99')	   	 			
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
				@nLin,028 Psay Transform(nSQtCliA,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nSVlCliA,'@e 999,999,999.99')	   	 			
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
				@nLin,028 Psay Transform(nTQtCli,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nTVlCli,'@e 999,999,999.99')	   	 			
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
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Lista o Resumo do Cliente³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
			For __k := 1 to Len(aResCli)
				@ nLin,028 Psay PadR('Unidade..: '+aResCli[__k,1]+' | Moeda....: '+Alltrim(cSimbolo + Alltrim(Str(aResCli[__k,2]))),41)		
				@ nLin,071 Psay Transform((aResCli[__k,03]/aResCli[__k,08]),'@e 9,999.9999')
				@ nLin,093 Psay Transform((aResCli[__k,04]/aResCli[__k,09]),'@e 9,999.9999')
				@ nLin,115 Psay Transform((aResCli[__k,05]/aResCli[__k,10]),'@e 9,999.9999')
				@ nLin,137 Psay Transform((aResCli[__k,06]/aResCli[__k,11]),'@e 9,999.9999')
				@ nLin,159 Psay Transform((aResCli[__k,07]/aResCli[__k,12]),'@e 999,999,999.99')
				@ nLin,175 Psay "Md.Fix"+Transform((aResCli[__k,14]/aResCli[__k,13]),'@e 999,999,999.99')
				@ nLin,196 Psay "Md.AFi"+Transform((aResCli[__k,16]/aResCli[__k,15]),'@e 999,999,999.99')
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
			Next __k
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
		If !((mv_par10==2) .Or. (mv_par10==1 .And. mv_par11==mv_par12)) 	
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
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞ¿
			//³Lista o Total Filial³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞÙ
			If nSQtFilF>0
				@nLin,000 Psay "Total Fixado Filial -->"
				@nLin,028 Psay Transform(nSQtFilF,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nSVlFilF,'@e 999,999,999.99')	   	 			
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
				@nLin,028 Psay Transform(nSQtFilA,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nSVlFilA,'@e 999,999,999.99')	   	 			
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
				@nLin,028 Psay Transform(nTQtFil,'@e 999,999,999.99')
				@nLin,175 Psay Transform(nTVlFil,'@e 999,999,999.99')	   	 			
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
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Lista o Resumo da Filial³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
			For __k := 1 to Len(aResFil)
				@ nLin,028 Psay PadR('Unidade..: '+aResFil[__k,1]+' | Moeda....: '+Alltrim(cSimbolo + Alltrim(Str(aResFil[__k,2]))),41)		
				@ nLin,071 Psay Transform((aResFil[__k,03]/aResFil[__k,08]),'@e 9,999.9999')
				@ nLin,093 Psay Transform((aResFil[__k,04]/aResFil[__k,09]),'@e 9,999.9999')
				@ nLin,115 Psay Transform((aResFil[__k,05]/aResFil[__k,10]),'@e 9,999.9999')
				@ nLin,137 Psay Transform((aResFil[__k,06]/aResFil[__k,11]),'@e 9,999.9999')
				@ nLin,159 Psay Transform((aResFil[__k,07]/aResFil[__k,12]),'@e 999,999,999.99')
				@ nLin,175 Psay "Md.Fixa"+Transform((aResFil[__k,14]/aResFil[__k,13]),'@e 999,999,999.99')
				@ nLin,196 Psay "Md.AFix"+Transform((aResFil[__k,16]/aResFil[__k,15]),'@e 999,999,999.99')
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
			Next __k
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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Resumo de Fechamento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aResFch)>0
		aResFch	:= 	aSort(aResFch,,,{|x,y| (Upper(Alltrim(x[1]))+Upper(Alltrim(x[2]))+StrZero(x[3],2))<(Upper(Alltrim(y[1]))+Upper(Alltrim(y[2]))+StrZero(y[3],2))})
		@ nLin,000 PSay Replicate("_",limite)
		nLin++
		@ nLin,000 PSay PadC("RESUMO DE FECHAMENTOS",limite,'-')
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
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞ¿
		//³Lista o Total Geral³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄŒĞÙ
		If nSQtGerF>0
			@nLin,000 Psay "Total Fixado Geral -->"
			@nLin,028 Psay Transform(nSQtGerF,'@e 999,999,999.99')
			@nLin,175 Psay Transform(nSVlGerF,'@e 999,999,999.99')	   	 			
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
			@nLin,028 Psay Transform(nSQtGerA,'@e 999,999,999.99')
			@nLin,175 Psay Transform(nSVlGerA,'@e 999,999,999.99')	   	 			
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
			@nLin,028 Psay Transform(nTQtGer,'@e 999,999,999.99')
			@nLin,175 Psay Transform(nTVlGer,'@e 999,999,999.99')	   	 			
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
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Lista o Resumo Geral³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		For __k := 1 to Len(aResGer)
			@ nLin,028 Psay PadR('Unidade..: '+aResGer[__k,1]+' | Moeda....: '+Alltrim(cSimbolo + Alltrim(Str(aResGer[__k,2]))),41)		
			@ nLin,071 Psay Transform((aResGer[__k,03]/aResGer[__k,08]),'@e 9,999.9999')
			@ nLin,093 Psay Transform((aResGer[__k,04]/aResGer[__k,09]),'@e 9,999.9999')
			@ nLin,115 Psay Transform((aResGer[__k,05]/aResGer[__k,10]),'@e 9,999.9999')
			@ nLin,137 Psay Transform((aResGer[__k,06]/aResGer[__k,11]),'@e 9,999.9999')
			@ nLin,159 Psay Transform((aResGer[__k,07]/aResGer[__k,12]),'@e 999,999,999.99')
			@ nLin,175 Psay "Md.Fixa"+Transform((aResGer[__k,14]/aResGer[__k,13]),'@e 999,999,999.99')
			@ nLin,196 Psay "Md.AFix"+Transform((aResGer[__k,16]/aResGer[__k,15]),'@e 999,999,999.99')
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
		Next __k
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Lista o Resumo da Media da Unidade de Medida e Moeda do Parametro³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLin++
		@ nLin,020 Psay PadR('FIXADO   Un.Padrao: '+aRParFix[01,01]+' | Md.Padrao: '+Alltrim(GetMv('MV_SIMB'+Alltrim(Str(aRParFix[01,02])))),41)		
		@ nLin,071 Psay Transform((aRParFix[01,03]/aRParFix[01,08]),'@e 9,999.9999')
		@ nLin,093 Psay Transform((aRParFix[01,04]/aRParFix[01,09]),'@e 9,999.9999')
		@ nLin,115 Psay Transform((aRParFix[01,05]/aRParFix[01,10]),'@e 9,999.9999')
		@ nLin,137 Psay Transform((aRParFix[01,06]/aRParFix[01,11]),'@e 9,999.9999')
		@ nLin,159 Psay Transform((aRParFix[01,07]/aRParFix[01,12]),'@e 999,999,999.99')
		@ nLin,175 Psay Transform((aRParFix[01,14]/aRParFix[01,13]),'@e 999,999,999.99')
		nLin++
		@ nLin,020 Psay PadR('A FIXAR  Un.Padrao: '+aRParAFi[01,01]+' | Md.Padrao: '+Alltrim(GetMv('MV_SIMB'+Alltrim(Str(aRParAFi[01,02])))),41)		
		@ nLin,071 Psay Transform((aRParAFi[01,03]/aRParAFi[01,08]),'@e 9,999.9999')
		@ nLin,093 Psay Transform((aRParAFi[01,04]/aRParAFi[01,09]),'@e 9,999.9999')
		@ nLin,115 Psay Transform((aRParAFi[01,05]/aRParAFi[01,10]),'@e 9,999.9999')
		@ nLin,137 Psay Transform((aRParAFi[01,06]/aRParAFi[01,11]),'@e 9,999.9999')
		@ nLin,159 Psay Transform((aRParAFi[01,07]/aRParAFi[01,12]),'@e 999,999,999.99')
		@ nLin,175 Psay Transform((aRParAFi[01,14]/aRParAFi[01,13]),'@e 999,999,999.99')
		nLin++
		@ nLin,020 Psay PadR('PREVISTO Un.Padrao: '+aRParPre[01,01]+' | Md.Padrao: '+Alltrim(GetMv('MV_SIMB'+Alltrim(Str(aRParPre[01,02])))),41)		
		@ nLin,071 Psay Transform((aRParPre[01,03]/aRParPre[01,08]),'@e 9,999.9999')
		@ nLin,093 Psay Transform((aRParPre[01,04]/aRParPre[01,09]),'@e 9,999.9999')
		@ nLin,115 Psay Transform((aRParPre[01,05]/aRParPre[01,10]),'@e 9,999.9999')
		@ nLin,137 Psay Transform((aRParPre[01,06]/aRParPre[01,11]),'@e 9,999.9999')
		@ nLin,159 Psay Transform((aRParPre[01,07]/aRParPre[01,12]),'@e 999,999,999.99')
		@ nLin,175 Psay Transform((aRParPre[01,14]/aRParPre[01,13]),'@e 999,999,999.99')
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
		/*
		nLin++                       
		@ nLin,000 PSay Replicate("_",limite)
		nLin++                       
		cCliFch	:= ''
		For __k := 1 to Len(aResFch)
		If cCliFch<>aResFch[__k,1]	
		@ nLin,000 Psay PadR(Alltrim(SubStr(aResFch[__k,4],1,26)),26) 
		cCliFch	:= aResFch[__k,1]	
		Else
		@ nLin,000 Psay PadR(Space(Int((Len(Alltrim(aResFch[__k,4]))-2)/2))+"''",26) 	 	
		Endif
		@ nLin,028 Psay PadR('Unidade..: '+aResFch[__k,2]+' | Moeda..: '+Alltrim(GetMv('MV_SIMB'+Alltrim(Str(aResFch[__k,3])))),41)		
		@ nLin,071 Psay Transform((aResFch[__k,05]/aResFch[__k,10]),'@e 9,999.9999')
		@ nLin,093 Psay Transform((aResFch[__k,06]/aResFch[__k,11]),'@e 9,999.9999')
		@ nLin,115 Psay Transform((aResFch[__k,07]/aResFch[__k,12]),'@e 9,999.9999')
		@ nLin,137 Psay Transform((aResFch[__k,08]/aResFch[__k,13]),'@e 9,999.9999')
		@ nLin,159 Psay Transform((aResFch[__k,09]/aResFch[__k,14]),'@e 999,999,999.99')
		@ nLin,175 Psay Transform((aResFch[__k,15]/aResFch[__k,16]),'@e 999,999,999.99')
		nLin++	
		Next __k
		*/
	Endif	
	@ nLin,000 PSay Replicate("_",limite)

	(cArqTMP)->(dbCloseArea())

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
