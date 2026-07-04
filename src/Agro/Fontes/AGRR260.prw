/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR260  ³ Autor ³ Danyel Bernuci        ³ Data ³ 09/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao de Transferencias Internas			              ³±±
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
User Function AGRR260()
	Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
	Local cDesc2        := "de acordo com os parametros informados pelo usuario."
	Local cDesc3        := "Relacao de Transferencias"
	Local titulo        := "Relacao de Transferencias"
	Local nLin          := 132
	Local Cabec1        := ""
	Local Cabec2        := ""

	Private aOrd        := {'Cliente Origem','Cliente Destino'}
	Private lEnd        := .F.
	Private lAbortPrint := .F.
	Private limite      := 132
	Private tamanho     := "M"
	Private nomeprog    := 'AGRR260'
	Private nTipo       := 18
	Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
	Private nLastKey    := 0
	Private cbtxt       := Space(10)
	Private cbcont      := 00
	Private CONTFL      := 01
	Private m_pag       := 01
	Private cPerg       := "AGR260"
	Private wnrel       := "AGRR260"

	dbSelectArea("NPI")
	dbSetOrder(1)

	Pergunte(cPerg,.f.)

	wnrel := SetPrint('NPI',NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

	If nLastKey == 27
		Return()
	Endif

	SetDefault(aReturn,'NPI')

	If nLastKey == 27
		Return()
	Endif

	nTipo := If(aReturn[4]==1,15,18)

	RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

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
	Local 	aArea   	:= GetArea()
	Local 	cFiltro 	:= ""
	Local 	cCond   	:= ""
	Local	cUM 		:=	""
	Local	nQtdUM 		:=	0	
	Local	nQtdSEGUM	:=	0	
	Local	nTotGUM		:=	0	
	Local	nTotGSEG	:=	0	
	Local	nTotSUM		:=	0	
	Local	nTotSSEG	:=	0	
	Local	cFiltUser	:=	aReturn[7]

	//Variaveis para arquivos temporarios
	Private cArqTMP := ""
	Private cIndTMP := ""
	Private cChvTMP := ""
	Private aArqTMP := {}

	dbSelectArea('NN1')
	dbSetOrder(1)
	dbSeek(xFilial('NN1')+mv_par01)

	dbSelectArea('SB1')
	dbSetOrder(1)
	dbSeek(xFilial('SB1')+NN1->NN1_CODPRO)

	titulo	:= Alltrim(titulo) +"  -  Safra: "+PadR(NN1->NN1_DESCRI,30)

	dbSelectArea('NPI')

	cFiltro := "NPI_SAFRA  =MV_PAR01 .And. "
	cFiltro += "NPI_DATA  >=MV_PAR02 .And. "
	cFiltro += "NPI_DATA  <=MV_PAR03 .And. "
	cFiltro += "NPI_CDCLIO>=MV_PAR04 .And. "
	cFiltro += "NPI_CDCLIO<=MV_PAR05 .And. "
	cFiltro += "NPI_CDCLID>=MV_PAR06 .And. "
	cFiltro += "NPI_CDCLID<=MV_PAR07 .And. "
	cFiltro += "NPI_CODMOT>=MV_PAR08 .And. "
	cFiltro += "NPI_CODMOT<=MV_PAR09"
	If mv_par10==1
		cFiltro += " .And. NPI_TIPO='N'"
	ElseIf mv_par10==2
		cFiltro += " .And. NPI_TIPO='I'"
	Endif

	dbSetFilter( {|| &cFiltro }, cFiltro )

	DbSelectArea("NPI")
	SetRegua(RecCount())
	cIndTMP := SubStr(criatrab("",.f.),1,7)+"A"
	IndRegua("NPI",cIndTMP,"NPI_FILIAL+"+If(aReturn[8]==1,"NPI_DSCLIO+NPI_DSCLID","NPI_DSCLID+NPI_DSCLIO")+"+NPI_CODIGO",,,"Criando Indice...")
	nIndNPI := RetIndex("NPI")+1
	dbSetOrder(nIndNPI)
	#IFNDEF TOP
	npi->(dbSetIndex(cIndTMP+OrdBagExt()))	
	#ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica a Ordem a Indexar³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If aReturn[8]==1
		cCond	:= "npi->npi_dsclio==cCondWhile"
		cCond2	:= "npi->npi_dsclid==cCond2While"			
	Else
		cCond	:= "npi->npi_dsclid==cCondWhile"
		cCond2	:= "npi->npi_dsclio==cCond2While"			
	Endif

	//          0         0         0         0         0         0         0         0         0         1         1         1         1
	//          1         2         3         4         5         6         7         8         9         0         1         2         3
	//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
	Cabec1 := PadC("Produto: "+AllTrim(SB1->B1_COD)+"-"+AllTrim(Substr(SB1->B1_DESC,1,25))+" - Periodo: "+Dtoc(mv_par02)+" a "+Dtoc(mv_par03)+" - Tipo: "+If(mv_par10==1,"Normal",If(mv_par10==2,"Desc. Extra","Ambos")),132)
	Cabec2 := "          Codigo  Motivo                 Data             Qtd "+If(Len(Alltrim(mv_par11))=0,"UM",Alltrim(mv_par11))+"      "+If(Len(Alltrim(mv_par12))=0,"Qtd SEGUM",("   Qtd "+Alltrim(mv_par12)))+"  Observacoes"

	Dbgotop()
	While !Eof()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			dbSkip()
			Loop
		EndIf	

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

		cTransf	:=	npi->npi_codigo		

		If aReturn[8]==1 
			@ nLin,001 PSay "De   : "+PadR(AllTrim(npi_dsclio),40) 
			cCondWhile	:=	npi_dsclio 	
		Else
			@ nLin,001 PSay "Para : "+PadR(AllTrim(npi_dsclid),40) 	
			cCondWhile	:=	npi_dsclid 	
		Endif
		nLin ++

		nTotSUM		:=	0	
		nTotSSEG	:=	0	

		While !Eof() .And. npi_filial==cFilial .And. &cCond 

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Avalia filtro do usuario                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(cFiltUser).And.!(&cFiltUser)
				dbSkip()
				Loop
			EndIf	

			IncRegua(cCondWhile)

			If lAbortPrint
				@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
				Exit
			Endif

			If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 9
			Endif             

			If aReturn[8]==1 
				@ nLin,005 PSay "Para : "+PadR(AllTrim(npi_dsclid),40) 
				cCond2While	:=	npi_dsclid 	
			Else
				@ nLin,005 PSay "De   : "+PadR(AllTrim(npi_dsclio),40) 	
				cCond2While	:=	npi_dsclio 	
			Endif

			nLin ++

			While !Eof() .And. npi_filial==cFilial .And. &cCond .And. &cCond2

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Avalia filtro do usuario                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty(cFiltUser).And.!(&cFiltUser)
					dbSkip()
					Loop
				EndIf	

				If lAbortPrint
					@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
					Exit
				Endif

				If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
					Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin := 9
				Endif             

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Obtem a Unidade padrao do Produto³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cUm	:=	Posicione("SB1",1,xFilial("SB1")+npi_codpro,"B1_UM")

				@ nLin,010 PSay PadR(npi_codigo,06) 
				@ nLin,018 PSay PadR(Posicione("NNE",1,xFilial("NNE")+npi->npi_codmot,"NNE_DESCRI"),20) 
				@ nLin,040 PSay PadR(Dtoc(npi->npi_data),08) 

				If ((Len(Alltrim(mv_par11))=0).Or.(Alltrim(mv_par11)==Alltrim(cUm)))
					nQtdUM		:=	npi->npi_quant
					@ nLin,050 PSay Transform(npi->npi_quant,"@E 999,999,999.99")				
				Else
					nQtdUM 		:=	Agrx001(Alltrim(cUm),Alltrim(mv_par11),npi->npi_quant)	
					@ nLin,050 PSay Transform(nQtdUM,"@E 999,999,999.99")				
				Endif
				If Len(Alltrim(mv_par12))>0
					nQtdSEGUM	:=	Agrx001(Alltrim(cUm),Alltrim(mv_par12),npi->npi_quant)			
					@ nLin,065 PSay Transform(nQtdSEGUM,"@E 999,999,999.99")						
				Endif		
				@ nLin,081 PSay PadR(npi->npi_obs,46) 
				nLin ++						

				nTotGUM		+=	nQtdUM		
				nTotGSEG	+=	nQtdSEGUM	
				nTotSUM		+=	nQtdUM		
				nTotSSEG	+=	nQtdSEGUM	

				dbSkip()

			EndDo

		EndDo	   	
		nLin ++
		@ nLin,010 PSay "Total:  "+Alltrim(PadR(cCondWhile,40))
		If nTotSUM>0
			@ nLin,050 PSay Transform(nTotSUM,"@E 999,999,999.99")				
		Endif
		If nTotSSEG>0
			@ nLin,065 PSay Transform(nTotSSEG,"@E 999,999,999.99")						   
		Endif
		nLin ++
		nLin ++	
	EndDo
	@ nLin,010 PSay "Total Geral:"
	If nTotGUM>0
		@ nLin,050 PSay Transform(nTotGUM,"@E 999,999,999.99")				
	Endif
	If nTotGSEG>0
		@ nLin,065 PSay Transform(nTotGSEG,"@E 999,999,999.99")						   
	Endif
	npi->(dbClearFilter())

	FErase(cIndTMP+OrdBagExt())

	RestArea(aArea)

	Roda()

	SET DEVICE TO SCREEN

	If aReturn[5]==1
		dbCommitAll()
		SET PRINTER TO
		OurSpool(wnrel)
	Endif

	MS_FLUSH()

Return
