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
±±³Funçào    ³ AGRR250  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relação de Apontamentos de Produção			              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAAGR                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BO
PS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR250()

	Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2         := "de acordo com os parametros informados pelo usuario."
	Local cDesc3         := "Relacao de Apontamentos de Produção."
	Local titulo         := "Relação de Apontamentos"
	Local nLin           := 132
	Local Cabec1         := ""
	Local Cabec2         := ""

	Private aOrd        := {"Codigo do Apontamento","Data + Apontamento + Fazenda + Talhao","Fazenda + Talhao + Data"}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR250'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR250"
	Private wnrel       := "AGRR250"
	Private cAliasTMP := ""

	dbSelectArea("NPA")
	dbSetOrder(1)

	Pergunte(cPerg,.F.)

	wnrel := SetPrint('NPA',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,'NPA')

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
±±³ Uso      ³ AGRR250                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
	Local 	nOrdem      :=	aReturn[8]                    	
	Local 	cFiltro 	:= ""
	Local	cFiltUser	:=	aReturn[7]
	Local	__k           
	Local	aVarieds	:=	{}
	Local	cProduto	:=	Posicione("NN1",1,xFilial("NN1")+(Alltrim(mv_par01)),"NN1_DESPRO")

	Local	nPerc		:=	0
	Local	nPBruto		:=	0
	Local	nPLiqui		:=	0
	Local	nQtdVar		:=	0
	Local	n1PBruto	:=	0
	Local	n1PLiqui	:=	0
	Local	n1QtdVar	:=	0
	Local	n2PBruto	:=	0
	Local	n2PLiqui	:=	0
	Local	n2QtdVar	:=	0
	Local	n3PBruto	:=	0
	Local	n3PLiqui	:=	0
	Local	n3QtdVar	:=	0

	Local	n0QtdApo	:=	0
	Local	n1QtdApo	:=	0

	//Variaveis para arquivos temporarios
	Private cIndTMP := ""
	Private cChvTMP := ""
	Private aArqTMP := {}

	titulo := Alltrim(titulo)+" no Periodo de "+DtoC(mv_par06)+" a "+DtoC(mv_par07)

	cFiltro := "NPA_SAFRA  == '"+MV_PAR01+"' .And. "
	cFiltro += "NPA_FAZ    >= '"+MV_PAR02+"' .And. "
	cFiltro += "NPA_FAZ    <= '"+MV_PAR03+"' .And. "
	cFiltro += "NPA_TALHAO >= '"+MV_PAR04+"' .And. "
	cFiltro += "NPA_TALHAO <= '"+MV_PAR05+"' .And. "
	//Considera Filiais
	If mv_par10==1
		cFiltro += "NPA_FILIAL >= '"+MV_PAR11+"' .And. "
		cFiltro += "NPA_FILIAL <= '"+MV_PAR12+"' .And. "	
	Endif
	cFiltro += "DToS(NPA_DATA)   >= '"+DToS(MV_PAR06)+"' .And. "
	cFiltro += "DToS(NPA_DATA)   <= '"+DToS(MV_PAR07)+"'"
	If mv_par08<>3
		If mv_par08==1
			cFiltro += " .And. NPA_FECHAD='N'"
		Else
			cFiltro += " .And. NPA_FECHAD='S'"
		EndIf
	EndIf

	dbSelectArea('NPA')
	IndRegua("NPA",CriaTrab(Nil,.F.),IndexKey(),,cFiltro,"Criando Indice...")

	aAdd(aArqTMP,{"NPA_FILIAL","C",002,00})
	aAdd(aArqTMP,{"NPA_CODIGO","C",006,00})
	aAdd(aArqTMP,{"NPA_DATA	 ","D",008,00})
	aAdd(aArqTMP,{"NPA_SAFRA ","C",006,00})
	aAdd(aArqTMP,{"NN2_NOME  ","C",030,00})
	aAdd(aArqTMP,{"NPA_FAZ   ","C",002,00})
	aAdd(aArqTMP,{"NPA_TALHAO","C",003,00}) 
	aAdd(aArqTMP,{"NPA_LOCAL ","C",002,00}) 
	aAdd(aArqTMP,{"NPA_CODTRA","C",006,00}) 
	aAdd(aArqTMP,{"NPA_DESTRA","C",040,00})
	aAdd(aArqTMP,{"NPA_CODEQU","C",006,00})
	aAdd(aArqTMP,{"NPA_DESEQU","C",040,00})
	aAdd(aArqTMP,{"NPA_CODMOT","C",006,00})
	aAdd(aArqTMP,{"NPA_NOMMOT","C",040,00})
	aAdd(aArqTMP,{"NPA_CODPRO","C",015,00})
	aAdd(aArqTMP,{"NPA_DESPRO","C",040,00})
	aAdd(aArqTMP,{"NPA_UM 	 ","C",002,00}) 	
	aAdd(aArqTMP,{"NPA_QTDEST","N",014,02})
	aAdd(aArqTMP,{"NPA_VLRUNI","N",014,02})
	aAdd(aArqTMP,{"NPA_VLRTOT","N",014,02})
	aAdd(aArqTMP,{"NPA_NFSSER","C",003,00})
	aAdd(aArqTMP,{"NPA_NFSNUM","C",006,00})
	aAdd(aArqTMP,{"NPA_QTDREA","N",014,02})
	aAdd(aArqTMP,{"NPA_FECHAD","C",001,00})
	aAdd(aArqTMP,{"NPO_CODIGO","C",006,00})
	aAdd(aArqTMP,{"NPO_DATA	 ","D",008,00}) 
	aAdd(aArqTMP,{"NNB_PLACA ","C",008,00})
	aAdd(aArqTMP,{"NNA_NOME  ","C",040,00})

	//Cria tabela temporária
	If nOrdem==1 //Apontamento	
		cChvTMP := 	"NPA_CODIGO"
		cCond1	:=	"npa_codigo==cCondWh1"		
		cCond2	:=	".t."               
		cNome1	:=	"Apontamento"
	ElseIf nOrdem==2 
		cChvTMP := "DTOS(NPA_DATA)+NPA_CODIGO+NPA_SAFRA+NPA_FAZ+NPA_TALHAO"	
		cCond1	:=	"DTOS(npa_data)==cCondWh1"
		cCond2	:=	".t."
		cNome1	:=	"Data"
	Else 
		cChvTMP := "NPA_SAFRA+NN2_NOME+NPA_TALHAO+Dtos(NPA_DATA)"		
		cCond1	:=	"nn2_nome==cCondWh1"
		cCond2	:=	"npa_talhao==cCondWh2"
		cNome1	:=	"Fazenda"
	Endif	

	cAliasTMP  := GetNextAlias()
	oArqTemp := AGRCRTPTB(cAliasTMP, {aArqTMP, {{"", cChvTMP }}} )    

	DbSelectArea("NPA")
	npa->(DbGoTop())
	While npa->(!Eof()) 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			npa->(dbSkip())
			Loop
		EndIf		

		DbSelectArea(cAliasTMP)	
		If RecLock(cAliasTMP,.t.)
			Replace (cAliasTMP)->npa_filial	With	npa->npa_filial				
			Replace (cAliasTMP)->npa_codigo	With	npa->npa_codigo				
			Replace (cAliasTMP)->npa_data	With	npa->npa_data			
			Replace (cAliasTMP)->npa_safra 	With	npa->npa_safra		
			Replace (cAliasTMP)->npa_faz   	With	npa->npa_faz		
			DbSelectarea("NN2")
			DbSetOrder(2)
			If DbSeek(xFilial("NN2")+npa->npa_faz)		
				Replace (cAliasTMP)->nn2_nome	With	nn2->nn2_nome
			Endif
			Replace (cAliasTMP)->npa_talhao	With	npa->npa_talhao		
			Replace (cAliasTMP)->npa_local 	With	npa->npa_local		
			Replace (cAliasTMP)->npa_codtra	With	npa->npa_codtra		
			Replace (cAliasTMP)->npa_destra	With	npa->npa_destra		
			Replace (cAliasTMP)->npa_codequ	With	npa->npa_codequ		
			Replace (cAliasTMP)->npa_desequ	With	npa->npa_desequ		
			Replace (cAliasTMP)->npa_codmot	With	npa->npa_codmot			
			Replace (cAliasTMP)->npa_nommot	With	npa->npa_nommot		
			Replace (cAliasTMP)->npa_codpro	With	npa->npa_codpro		
			Replace (cAliasTMP)->npa_despro	With	npa->npa_despro		
			Replace (cAliasTMP)->npa_um 	With	npa->npa_um		 		
			Replace (cAliasTMP)->npa_qtdest	With	npa->npa_qtdest		
			Replace (cAliasTMP)->npa_vlruni With	npa->npa_vlruni		
			Replace (cAliasTMP)->npa_vlrtot	With	npa->npa_vlrtot		
			Replace (cAliasTMP)->npa_nfsser	With	npa->npa_nfsser			
			Replace (cAliasTMP)->npa_nfsnum	With	npa->npa_nfsnum		
			Replace (cAliasTMP)->npa_qtdrea	With	npa->npa_qtdrea		
			Replace (cAliasTMP)->npa_fechad	With	npa->npa_fechad					
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Procura o Romaneio Relacionado³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
			DbSelectArea("NPO")
			DbSetOrder(2) 									
			If DbSeek(If(Len(Alltrim(xFilial("NPO")))==0,xFilial("NPO"),npa->npa_filial)+npa->npa_codigo)
				Replace (cAliasTMP)->npo_codigo	With	npo->npo_codigo		
				Replace (cAliasTMP)->npo_data	With	npo->npo_data
			Endif	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Procura o Equipamento ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("NNB")
			DbSetOrder(1) 
			If DbSeek(If(Len(Alltrim(xFilial("NNB")))==0,xFilial("NNB"),npa->npa_filial)+npa->npa_codequ)			
				Replace (cAliasTMP)->nnb_placa 	With	nnb->nnb_placa	
			Endif	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Procura o Equipamento ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("NNA")
			DbSetOrder(1) 
			If DbSeek(If(Len(Alltrim(xFilial("NNA")))==0,xFilial("NNA"),npa->npa_filial)+npa->npa_codmot)			
				Replace (cAliasTMP)->nna_nome  	With	SubStr(nna->nna_nome,1,40)										
			Endif                                   			
			MsUnLock(cAliasTMP)
		EndIf       			

		DbSelectArea("NPA")
		npa->(dbSkip())
	EndDo

	Cabec1	:=	PadC(Alltrim("Safra: "+Alltrim(mv_par01)+"- Produto :"+SubStr(cProduto,1,20)),limite,"-")
	Cabec2 	:= 	"Apto    Dt.Prod  NºRoma  Dt.Roma  Faz  Tal  Placa     Motorista     Variedade                  %        P.Previsto          P.Liqui"

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

		If nOrdem==1 //Apontamento	
			cCondWh1:=	(cAliasTMP)->npa_codigo
		ElseIf nOrdem==2	//Data 
			cCondWh1:=	Dtos((cAliasTMP)->npa_data)
		Else 
			cCondWh1:=	(cAliasTMP)->nn2_nome
		Endif	

		n2Perc		:=	0
		n2PBruto	:=	0
		n2PLiqui	:=	0
		n2QtdVar	:=	0

		If nOrdem==1
			If Upper(Alltrim((cAliasTMP)->npa_fechad))=='N'
				n0QtdApo++
			Else
				n1QtdApo++	
			Endif	
		Endif

		While (cAliasTMP)->(!Eof()) .And. &cCond1 

			If nOrdem==3 //Talhao
				cCondWh2:=	npa_talhao				
			Endif	                  

			n3Perc		:=	0
			n3PBruto	:=	0
			n3PLiqui	:=	0
			n3QtdVar	:=	0

			While (cAliasTMP)->(!Eof()) .And. &cCond1 .And. &cCond2 

				If nOrdem<>1
					If Upper(Alltrim((cAliasTMP)->npa_fechad))=='N'
						n0QtdApo++
					Else
						n1QtdApo++	
					Endif	
				Endif

				IncRegua(cCondWh1)

				nPerc	:=	0		
				nPBruto	:=	0		
				nPLiqui	:=	0		
				nQtdVar	:=	0
				aVarieds:=	{}

				DbSelectArea("NPB")
				DbSetOrder(1)
				If DbSeek(If(Len(Alltrim(xFilial("NPB")))==0,xFilial("NPB"),(cAliasTMP)->npa_filial)+(cAliasTMP)->npa_codigo)
					While npb->(!Eof()) .And. npb->npb_filial==If(Len(Alltrim(xFilial("NPB")))==0,xFilial("NPB"),(cAliasTMP)->npa_filial) .And. npb->npb_codigo==(cAliasTMP)->npa_codigo	
						nPerc		+=	npb->npb_pervar
						nPBruto		+= 	npb->npb_psapto	
						n1PBruto	+= 	npb->npb_psapto	
						n2PBruto	+= 	npb->npb_psapto	
						n3PBruto	+= 	npb->npb_psapto	
						nPLiqui		+= 	npb->npb_psreal				     	
						n1PLiqui	+= 	npb->npb_psreal				     	
						n2PLiqui	+= 	npb->npb_psreal				     	
						n3PLiqui	+= 	npb->npb_psreal				     	
						nQtdVar++
						n1QtdVar++
						n2QtdVar++
						n3QtdVar++
						__k	:=	aScan(aVarieds,{|d| d[1]==npb->npb_codvar })
						If __k>0
							aVarieds[__k,3]	+= npb->npb_pervar	
							aVarieds[__k,4]	+= npb->npb_psapto	
							aVarieds[__k,5]	+= npb->npb_psreal	
							aVarieds[__k,6]	++				     	 	               	
						Else				     	
							Aadd(aVarieds,{npb->npb_codvar,npb->npb_desvar,npb->npb_pervar,npb->npb_psapto,npb->npb_psreal,1})		
						Endif	
						npb->(DbSkip())
					EndDo
				Endif

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				@nLin,000 Psay PadR((cAliasTMP)->npa_codigo,25)  
				@nLin,009 Psay PadR(Dtoc((cAliasTMP)->npa_data),08)  
				@nLin,018 Psay PadR((cAliasTMP)->npo_codigo,06)  
				@nLin,026 Psay PadR(Dtoc((cAliasTMP)->npo_data),08)  
				@nLin,036 Psay PadR((cAliasTMP)->npa_faz,02)  
				@nLin,040 Psay PadR((cAliasTMP)->npa_talhao,03)  
				@nLin,045 Psay PadR((cAliasTMP)->nnb_placa,08)  
				@nLin,055 Psay PadR((cAliasTMP)->nna_nome,20)  
				@nLin,099 PSay Transform(nPBruto,"@E 9,999,999,999.99")					
				@nLin,116 PSay Transform(nPLiqui,"@E 9,999,999,999.99")					
				nLin++                 

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					If nLin < 80
						Roda()
					EndIf
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				If mv_par09==1 //Lista Variedades
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Ordena por Descricao da Variedade³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aSort(aVarieds,,,{|x,y| x[2] < y[2]} )							
					For __k	:= 1 to Len(aVarieds)

						If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
							If nLin < 80
								Roda()
							EndIf
							Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
							nLin := 9
						Endif             

						@nLin,068 Psay PadR(aVarieds[__k,2],20)  
						@nLin,090 PSay Transform(aVarieds[__k,3],"@E 999.99")					
						@nLin,098 PSay Transform(aVarieds[__k,4],"@E 9,999,999,999.99")					
						@nLin,115 PSay Transform(aVarieds[__k,5],"@E 9,999,999,999.99")															
						nLin++                 
					Next __k
				Endif

				DbSelectArea(cAliasTMP)								
				(cAliasTMP)->(DbSkip())

			EndDo			

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				If nLin < 80
					Roda()
				EndIf
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Sub-Total Condicao 2³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nOrdem==3 //Talhao
				nLin++
				@nLin,030 PSay PadR("Total Talhao "+Alltrim(cCondWh2)+"--->",25)  
				@nLin,098 PSay Transform(n3PBruto,"@E 9,999,999,999.99")					
				@nLin,115 PSay Transform(n3PLiqui,"@E 9,999,999,999.99")					
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

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Sub-Total Condicao 1³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nOrdem<>1
			nLin++
			If nOrdem==2
				@nLin,030 PSay PadR("Total "+Alltrim(cNome1)+"  "+Dtoc(Stod(Alltrim(cCondWh1)))+" --->",25)  
			Else
				@nLin,030 PSay PadR("Total "+Alltrim(cNome1)+"  "+Alltrim(SubStr(cCondWh1,1,30))+" --->",50)  		
			Endif
			@nLin,098 PSay Transform(n2PBruto,"@E 9,999,999,999.99")					
			@nLin,115 PSay Transform(n2PLiqui,"@E 9,999,999,999.99")					
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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Sub-Total Condicao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin++
	@nLin,030 PSay PadR("Total Geral ---> Aberto(s) "+Alltrim(Str(n0QtdApo))+" | Fechado(s) "+Alltrim(Str(n1QtdApo)),50)  
	@nLin,098 PSay Transform(n1PBruto,"@E 9,999,999,999.99")					
	@nLin,115 PSay Transform(n1PLiqui,"@E 9,999,999,999.99")					
	nLin++		    				

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
