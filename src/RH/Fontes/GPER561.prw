/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "GPER561.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER561   ºAutor  ³Alexandre Silva	  º Data ³  02/04/03  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Hace la impresion de la planilla de direccion general de    º±±
±±º          ³impuestos internos.                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Liquidacion - Republica Dominicana                         º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Luiz Gustavo|29/01/07³116748³Retiradas funcoes de ajuste de dicionario.|±±  
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³04/11/2009³00000026596/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Gustavo M    ³30/07/2012³14913/2012      ³Inclusao da filial no parametro 11 (Sal.   ³±±
±±³             ³          ³    TFDLHF      ³Minimo).					                ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER561()

Private NomeProg 	:= "GPER561"
Private WnRel		:=	"GPER561"    //Nome Default do relatorio em Disco
Private cPerg    	:= "GPR561"
Private Titulo		:= FunDesc()


/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variaveis utilizadas para parametros                         ³
  ³ mv_par01        //  Filial De                                ³
  ³ mv_par02        //  Filial Ate                               ³
  ³ mv_par03        //  Centro de Custo De                       ³
  ³ mv_par04        //  Centro de Custo Ate                      ³
  ³ mv_par05        //  Matricula De                             ³
  ³ mv_par06        //  Matricula Ate                            ³
  ³ mv_par07        //  Nome De                                  ³
  ³ mv_par08        //  Nome Ate                                 ³
  ³ mv_par09        //  Chapa De                                 ³
  ³ mv_par10        //  Chapa Ate                                ³
  ³ mv_par11        //  Situa‡äes                                ³
  ³ mv_par12        //  Categorias                               ³ 
  ³ mv_par13        //  Ano Referencia                           ³
  ³ mv_par14        //  Tipo do relatorio/Na impressora/Arquivo  ³
  ³ mv_par15        //  Ordem                                    ³
  ³ mv_par16        //  Encargos                                 ³
  ³ mv_par17        //  Valor do Juros                           ³
  ³ mv_par18        //  % do Juros                               ³
  ³ mv_par19        //  Verbas ISR                               ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If Pergunte("GPR561",.T.)
	RptStatus({|lEnd| U_Gper561Imp(@lEnd,wnRel,"SRA")},Titulo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Imp   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Relatorio.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gper561Imp(lEnd,wnRel,cAlias)

Local	cFilDe    	:= mv_par01
Local cFilAte   	:= mv_par02
Local cCcDe     	:= mv_par03
Local cCcAte    	:= mv_par04
Local cMatDe    	:= mv_par05
Local cMatAte   	:= mv_par06
Local cNomeDe   	:= mv_par07
Local cNomeAte  	:= mv_par08
Local cChapaDe  	:= mv_par09
Local cChapaAte 	:= mv_par10
Local cSituacao 	:= mv_par11
Local cCategoria	:= mv_par12
Local cAnoRef   	:= mv_par13
Local nDestino  	:= mv_par14
Local nOrdem     	:= mv_par15
Local nLin			:= 50
Local nPag			:= 01
Local nContFun		:= 34
Local nArquivo		:= 00
Local cInicio  	:= ""
Local cFim			:= ""
Local cSitFunc		:= ""
Local cArqGravar 	:= ""
Local cFilialAnt 	:= Space(FWGETTAMFILIAL)
Local cFuncaoAnt 	:= Space(4)
Local cCcAnt     	:= Space(9)
Local cMatAnt    	:= Space(6)
Local aInfoFil		:= {}
Local aTitCab		:= Nil
Local	lPerNome 	:= .T.

Private cPictSal	:= PesqPict("SRC","RC_VALOR",20)
Private nQtdFunc	:= 0 //Numero de Asalariados.
Private nQtdFunIr	:= 0 //Numero de Asalariados com retencao.
Private aSomTot   := {0,0,0,0,0,0,0,0} //Acumula os valores de aDetTot para a impressao no final.
Private aIR			:= Nil //Vetor contento todas as faixas de IR para o Ano.
Private aCodFol	:= {}
Private oFont08  	:= TFont():New( "Corrier New",,10,,.f.,,,,,.f. )
Private oImp 		:= TMSPrinter():New()
Private cCodigos  := ALLTRIM(mv_par19)
Private Val_SalMin	:= 0.00    // Valor Salario Minimo

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder( 1 )
ElseIf nOrdem == 2
	dbSetOrder( 2 )
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif

dbGoTop()

If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	DbSeek(cFilDe + cNomeDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomeAte + cMatAte
Endif

SetRegua(SRA->(RecCount()))

cFilialAnt 	:= Space(FWGETTAMFILIAL)
cFuncaoAnt 	:= Space(4)
cCcAnt     	:= Space(9)
cMatAnt    	:= Space(6)

While !SRA->(EOF()) .And. &cInicio <= cFim .And.(SRA->RA_FILIAL+SRA->RA_MAT <> cFilialAnt+cMatAnt)

  	IncRegua()  // Incrementa a regua

   If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  |        Incio Consistencia da Parametrizacao do Intervalo de Impressao          |
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If (SRA->RA_CHAPA < cChapaDe).Or. (SRA->Ra_CHAPa > cChapaAte).Or. ;
	   (SRA->RA_NOME < cNomeDe)  .Or. (SRA->Ra_NOME > cNomeAte)  .Or. ;
	   (SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
	   (SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Substr(MV_PAR13,3,2) +  "/" + Left(MV_PAR13,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	
	/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	  ³ Consiste situacao e categoria dos funcionarios			        |
	  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If !( cSitFunc $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
	   SRA->(dbSkip())
	   Loop
	Endif
  
	If SRA->RA_FILIAL # cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or.  ! fInfo(@aInfoFil,Sra->Ra_Filial)
			Exit
		Endif
	   cFilialAnt := SRA->RA_FILIAL
	Endif

	If SRA->RA_CODFUNC # cFuncaoAnt           // Descricao da Funcao
		DescFun(Sra->Ra_Codfunc,Sra->Ra_Filial)
		cFuncaoAnt:= Sra->Ra_CodFunc
	Endif

	If SRA->RA_CC # cCcAnt                   // Centro de Custo
		DescCC(Sra->Ra_Cc,Sra->Ra_Filial)
		cCcAnt:=SRA->RA_CC
	Endif
	If !Sal_Min(@Val_SalMin,MesAno(dDataBase),SRA->RA_FILIAL)
		Exit
	EndIf
	
	If Val(cAnoRef) <= Year(SRA->RA_ADMISSA)
		SRA->(dbSkip())		
		Loop		
	EndIf

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  |        Fim Consistencia da Parametrizacao do Intervalo de Impressao   		     |
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If nContFun > 33 .And. nDestino == 1 &&Se for impressora.
		nLin 		:= 50
		Gper561Tit(@aTitCab)//Carrega aTitCab com a descricao dos campos de cabecalho.[7]
		Gper561Cab(@nPag,@nLin,aInfoFil,aTitCab)
		nContFun := 1
		nPag++
	EndIf		
	If nDestino == 1 
		Gper561Det(@nLin)
		If nContFun == 33
			oImp:EndPage()
		EndIf
		nContFun++
		nQtdFunc++ //Numero de Asalariados.
	Else
      If Empty(cArqGravar) .And. lPerNome
			cArqGravar := cGetFile(STR0001,OemToAnsi(STR0002),,"C:\",.T.,GETF_LOCALHARD) //"Arquivo Texto|*.TXT"###"Salvar Pesquisa..."
			nArquivo := fOpen(cArqGravar,1)
			If nArquivo == -1 .And. !Empty(cArqGravar)
				nArquivo := fCreate(cArqGravar)
			Else
				lPerNome := .F.
			Endif
		EndIf
		If nArquivo != 0
			Gper561Txt(nArquivo)
		EndIf			
	EndIf		
	SRA->(dbSkip())
Enddo

If nDestino == 1
	Gper561Rod(2,@nLin)
	oImp:Preview()
	MS_FLUSH()
Else
	If nArquivo != 0
		fClose(nArquivo)
	EndIf
EndIf	

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Cab   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz do cabecalho do Relatorio.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Cab(nPag,nLin,aInfoFil,aTitCab)

Local	cCGC 			:= aInfoFil[08] 
Local cRazSocial	:= aInfoFil[03] 
Local	cRua      	:= aInfoFil[04] 
Local	cMunicipio	:= aInfoFil[05] 
Local cTelefone	:= aInfoFil[10]
Local cFax        := aInfoFil[11]
Local	cEstado   	:= Substr(fDesc("SX5","12"+aInfoFil[6],"X5DESCRI()"),1,20)
Local nCol			:= 090

oImp:StartPage()
//Formulario

oImp:Say(nLin+=050,nCol:=090,STR0003+Spac(2)+lTrim(Str(nPag)),oFont08,50) //"         DGII         		| SECRETARIA DE ESTADO DE FINANZAS                                                   # PAGINA"
oImp:Say(nLin+=050,nCol:=090,STR0004+Spac(2)+mv_par13 ,oFont08,50) //"         IR-13        		| DIRECCION GENERAL DE IMPUESTOS INTERNO                                  ANO FISCAL"
oImp:Say(nLin+=050,nCol:=090,STR0005,oFont08,50) //"Aprobado por el Contralor   | DELCARACION JURADA ANUAL DEL AGENTE DE RETENCION"
oImp:Say(nLin+=050,nCol:=090,STR0006,oFont08,50) //" General de la Republica		| DE ASALARIADOS"
oImp:Say(nLin+=100,nCol:=090,STR0007,oFont08,50) //"DATOS GENERALES DEL AGENTE DE RETENCION"

//Variaveis
oImp:Box(nLin+90,0050,nLin+240,4600)
oImp:Say(nLin+=100,nCol:=0090,aTitCab[1] + cRazSocial	,oFont08,50)
oImp:Say(nLin+=000,nCol+=1900,aTitCab[2] + cCGC 			,oFont08,50)
oImp:Say(nLin+=050,nCol:=0090,aTitCab[3] + cRua       	,oFont08,50)
oImp:Say(nLin+=000,nCol+=1900,aTitCab[4] + cMunicipio 	,oFont08,50)
oImp:Say(nLin+=050,nCol:=0090,aTitCab[5] + cEstado    	,oFont08,50)
oImp:Say(nLin+=000,nCol+=1000,aTitCab[6] + cTelefone  	,oFont08,50)
oImp:Say(nLin+=000,nCol+=0900,aTitCab[7] + cFax       	,oFont08,50)

oImp:Box(nLin+060,0050,nlin+300,4600)
oImp:Say(nLin+=070,nCol:=090,	STR0024,oFont08,50) //"                       |             |                 |                |            |    SUELDOS Y     |             |              |               |            "
oImp:Say(nLin+=060,nCol:=090,	STR0008,oFont08,50) //"APELLIDOS Y NOMBRES    | CEDULA O    |TOTAL DE SALARIOS|     OTRAS      |TOTAL PAGADO|  OTROS PAGOS     | IMPUESTO    |   IMPUESTO   |   SALDO A FAV.| DIFERENCIA "
oImp:Say(nLin+=060,nCol:=090,	STR0009,oFont08,50) //"                       | PASSAPORTE  |PAGADOS EN EL ANO| REMUNERACIONES | EN EL ANO  | SUJ. A RETENCION |LIQUIDADO    |RET. Y PAGADO |  DEL EMPLEADO |  A PAGAR   "

oImp:Line(nLin+55,0051,nLin+55,4600)
oImp:Say(nLin+=060,nCol:=090,	STR0010,oFont08,50) //"         A             |       B     |        C        |       D        |     E      |       F          |    G        |      H       |       I       |            "

nLin+=170

Return     

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Det   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Detalhe do Relatorio.                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Det(nLin)

Local aAreaSRA	:= GetArea()
Local aDetTot  := Gper561Cal() //Guarda o valor calculado para cada funcionario colunas[C,D,E,F,G,H,I].
Local nCol		:= 000
Local nX

oImp:Say(nLin,nCol+=050,Substr(SRA->RA_NOME,1,28)	,oFont08,50)
oImp:Say(nLin,nCol+=730,Alltrim(SRA->RA_RG),oFont08,50)
nCol := 675
For nX  = 1 To Len(aDetTot)
	oImp:Say(nLin,nCol+=425,Trans(aDetTot[nX],cPictSal),oFont08,50)
Next nX	
nLin += 50

RestArea(aAreaSRA)

Return 
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Rod   ³Autor ³  Alexandre Silva     ³Data³ 04/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz do rodape    do Relatorio.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Rod(nOpcao,nLin)

Local cEmpregador	:= ""
Local cRG			:= ""
Local nReCargos	:= MV_PAR16
Local nInteres		:= MV_PAR17
Local nPorSobInt	:= MV_PAR18
Local nValRec		:= 0//Valor dos recargos Art. 252()%
Local nValInt		:= 0//Valor dos interes Art. 27()%
Local nValTot		:= 0//Valor total a recolher.
Local nCol			:= 0
nLin 					:= 2650
           
nValRec	:= (aSomTot[08] * nReCargos)/100
nValInt	:= nInteres	* ((nPorSobInt/100)+1)
nValTot	:= nValRec + nValInt +  aSomTot[08]

If FpHist82(xFilial("SRX"),"99") 
	cEmpregador	:= SubStr(SRX->RX_TXT ,022	,30) // Nombre del Empleador o Representante
	If	FpHist82(xFilial("SRX"),"99","3") 
		cRG	:= SubStr(SRX->RX_TXT ,31	,15)
   EndIf
EndIf	

oImp:Say(nLin+=060,nCol:=3900, STR0025 ,oFont08,50)//"Resumem para el pago

oImp:Box(nLin+050,0050,nlin+290,0680)//Caixa Esquerda
oImp:Line(nLin+140,0051,nLin+140,0679)

oImp:Box(nLin+080 ,3330,nlin+370,4600)//Caixa Direita
oImp:Line(nLin+280,3331,nLin+280,4600)

oImp:Say(nLin+=070,nCol:=0060, STR0011 ,oFont08,50)//"Numero asalariados"
oImp:Say(nLin+=000,nCol+=0500, lTrim(Str(nQtdFunc)) ,oFont08,50)//"Numero asalariados"
oImp:Say(nLin+=000,nCol+=0200, STR0013 ,oFont08,50)//"Yo"
oImp:Line(nLin+030,nCol+ 0080, nLin+030,nCol+2150)

oImp:Say(nLin+=050,nCol:=0760, STR0014 ,oFont08,50)//"EN LA CALIDAD DE AGENTE DE RETENCION, POR LA PRESENTE DECLARO BAJO JURAMENTO QUE LOS DATOS"
oImp:Say(nLin+=000,nCol+=2600, STR0020)//"IMPUESTO A PAGAR"
oImp:Say(nLin+=000,nCol+=0600, Trans(aSomTot[08],cPictSal) ,oFont08,50)//Valor do Impuesto

oImp:Say(nLin+=050,nCol:=0060, STR0011 ,oFont08,50)//"Numero asalariados"
oImp:Say(nLin+=000,nCol+=0500, lTrim(Str(nQtdFunIr)) ,oFont08,50)//"Numero asalariados"
oImp:Say(nLin+=000,nCol+=0200, STR0015 ,oFont08,50)//"CONSIGNADOS EN LA PRESENTE DECLARACION DON CORRECTOS Y COMPLETOS Y QUE NO HE OMITIDO  DATO"
oImp:Say(nLin+=000,nCol+=2600, STR0021)//"REGARGOS ART. 252 (   )%"
oImp:Say(nLin+=000,nCol+=0600, Trans(nValRec,cPictSal) ,oFont08,50)

oImp:Say(nLin+=050,nCol:=0060, STR0012 ,oFont08,50)//"Sujetos a Retencion"
oImp:Say(nLin+=000,nCol+=0700, STR0016 ,oFont08,50)//"ALGUNO QUE LA MISMA DEBA CONTENER,  SIENDO  EN  CONSECUENCIA  TODO SU  CONTENIDO  LA  FIEL"
oImp:Say(nLin+=000,nCol+=2600, STR0022)//"INTERES INDEMNIZATORIO ART. 27 (   )%" 
oImp:Say(nLin+=000,nCol+=0600, Trans(nValInt,cPictSal),oFont08,50)//"INTERES INDEMNIZATORIO ART. 27 (   )%" 

oImp:Say(nLin+=050,nCol:=0760, STR0017 ,oFont08,50)//"EXPRESION DE LA VERDAD."

oImp:Say(nLin+=050,nCol:=3360, STR0023)//"TOTAL A PAGAR RD$"
oImp:Say(nLin+=000,nCol+=0600, Trans(nValTot,cPictSal) ,oFont08,50)

oImp:Say(nLin+=050,nCol:=1200, cEmpregador	,oFont08,50)//"FIRMA DEL DECLARANTE"
oImp:Say(nLin+=000,nCol+=1000, cRG				,oFont08,50)//"CEDULA-SERIE"

oImp:Line(nLin+045,1100,nLin+045,1700) //Lineas para firma
oImp:Line(nLin+045,2100,nLin+045,2600)

oImp:Say(nLin+=050,nCol:=1200, STR0018,oFont08,50)//"FIRMA DEL DECLARANTE"
oImp:Say(nLin+=000,nCol+=1000, STR0019,oFont08,50)//"CEDULA-SERIE"

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Cal   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz o calculo do imposto recolhido durante o Ano.          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Cal()
/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Descricao da matrix aDetTot e aSomTot.                       ³
  ³ aDetTot[1] - Total sal pagos no ano.                         ³
  ³ aDetTot[2] - Outros recebimentos.                            ³
  ³ aDetTot[3] - Soma aDetTot[1] + aDetTot[2].                   ³
  ³ aDetTot[4] - Sal. e outros receb. suj. a retencao.           ³
  ³ aDetTot[5] - Imp. Liquidado.                                 ³
  ³ aDetTot[6] - Imp. ret. e pago.                               ³
  ³ aDetTot[7] - Saldo a favor do empregado.                     ³
  ³ aDetTot[8] - Diferenca a pagar                               ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local nSoma13	:= 0
Local aDetTot 	:= {0,0,0,0,0,0,0,0}
Local aIRSel	:= {0,0,0,0,0,0,0,0,0,0}//Vetor com a tabela de IR usado para o calculo.
Local nY

//Acumalado Total de Salario e outras retenciones
SRD->(dbSetOrder(1))
SRD->(dbSeek(xFilial("SRD")+SRA->RA_MAT+MV_PAR13+"01",.T.))//Ano+01

//Valores de impuestos
aIRSel	:= U_GperLoadIR(SRD->RD_DATARQ,MV_PAR13)

Do While SRA->RA_FILIAL == SRD->RD_FILIAL .And. SRA->RA_MAT == SRD->RD_MAT .And. SubStr(SRD->RD_DATARQ,1,4) == MV_PAR13
	If PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_DGII13") == "1"
		aDetTot[01] += SRD->RD_VALOR
	ElseIf PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_DGII13") == "2"
		aDetTot[02] += SRD->RD_VALOR
	EndIf
	
	//Impueto retido y pagado coluna 6-H
	If Srd->Rd_Pd $ cCodigos     //aCodFol[66,1] .Or. Srd->Rd_Pd == aCodFol[67,1]
		aDetTot[06] += SRD->RD_VALOR
	EndIf
	
	//Acumula o valor do 13
	If Srd->Rd_Pd == aCodFol[24,1]
		nSoma13 += SRD->RD_VALOR
	EndIf

	SRD->(dbSkip())
EndDo

//Total de remuneraciones en le ano
aDetTot[03] := aDetTot[01] + aDetTot[02]
//Isencao do 13 salario somente ate 5 salarios minimos
If nSoma13 > (Val_SalMin * 5)
	nSoma13:= (Val_SalMin * 5)
Endif

/*Verificacao de Sueldos y o otros pagos sujetos a retencion [Coluna F e G]
Se for maio que o valor para isencao*/
If aDetTot[03] > aIRSel[01]
	nQtdFunIr	++ //Numero de Asalariados com retencao.
	aDetTot[04] += aDetTot[03] - nSoma13
	//Vericar a faixa de retencao de impostos
	If aDetTot[04] > aIRSel[01] .And. aDetTot[04] <= aIRSel[02]
		aDetTot[05]	:= aIRSel[03]+ ((aDetTot[04] - aIRSel[01])*aIRSel[04])/100
	ElseIf aDetTot[04] > aIRSel[02] .And. aDetTot[04]<= aIRSel[05]
		aDetTot[05]	:= aIRSel[06] + ((aDetTot[04] - aIRSel[02]) * aIRSel[07])/100
	ElseIf aDetTot[04] > aIRSel[05] .And. aDetTot[04] <= aIRSel[08]
		aDetTot[05]	:= aIRSel[09]+ ((aDetTot[04] - aIRSel[05])*aIRSel[10])/100
	EndIf
EndIf

//Saldo a favor del empleado
If aDetTot[05] < aDetTot[06]
	aDetTot[07] := (aDetTot[05] - aDetTot[06]) * -1
EndIf
If aDetTot[05] > aDetTot[06]
	aDetTot[08] := (aDetTot[05] - aDetTot[06]) 
EndIf	

//Atualiza os totalizadores
For nY = 1 to len(aDetTot)
	aSomTot[nY] += aDetTot[nY]
Next nY

Return aDetTot
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Tit   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega uma matriz com titulos das coluna de cabecalho.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Tit(aTitCab)

If aTitCab == Nil
	aTitCab 		:= Array(7)
	aTitCab[1] 	:= Rtrim(RetTitle("A2_NOME"))	+ "  "
	aTitCab[2] 	:= Rtrim(RetTitle("A2_CGC")) 	+ "  "
	aTitCab[3] 	:= Rtrim(RetTitle("A2_END"))	+ "  "
	aTitCab[4] 	:= Rtrim(RetTitle("A2_MUN"))	+ "  "
	aTitCab[5] 	:= Rtrim(RetTitle("A2_EST"))	+ "  "
	aTitCab[6] 	:= Rtrim(RetTitle("A2_TEL"))	+ "  "
	aTitCab[7] 	:= Rtrim(RetTitle("A2_FAX"))	+ "  "
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GperLoadIr    ³Autor ³  Alexandre Silva     ³Data³ 06/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega a faixa de imposto valida para um periodo.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function GperLoadIR(cDataLan, cAno)

Local cChaveIR 	:= "60"
Local nIndice		:= 0
Local nPosRet		:= 1
Local lTabAnt		:= .F.
Local aArea 		:= GetArea()
Local aIrRet		:= {0,0,0,0,0,0,0,0,0,0}

If aIR == Nil
	dbSelectArea("SRX")
	dbSetOrder(1)
	aIR   := {}
	If dbSeek(xFilial("SRX") + cChaveIR + cAno)//Seleciona a tab. de impostos para o ano pedido.
		lTabAnt := .T.
		Do While cChaveIR+cAno == RX_TIP+Substr(RX_COD,01,04)
			nIndice ++
			aAdd(aIR,Array(11))
			If nIndice == 1
				aIR[nIndice][01]	:= cAno+"01"+Substr(RX_COD,01,06)//Intervalo de validade da faixa
			Else
				aIR[nIndice][01]	:= cAno+Soma1(Substr(aIR[nIndice-1][01],11,02))+Substr(RX_COD,01,06)//Intervalo de validade da faixa
			EndIf				
			aIR[nIndice][02]	:= Val( SubStr( SRX->RX_TXT ,01,12 ) )//Isento	
			aIR[nIndice][03]	:= Val( SubStr( SRX->RX_TXT ,13,12 ) )//Rendimento 1
			aIR[nIndice][04]	:= Val( SubStr( SRX->RX_TXT ,25,10 ) )//Valor desconto fixo
			aIR[nIndice][05]	:= Val( SubStr( SRX->RX_TXT ,35,06 ) )// % sobre o excedente
			aIR[nIndice][06]	:= Val( SubStr( SRX->RX_TXT ,41,12 ) )//Rendimento 2
			If dbSeek(xFilial("SRX") +cChaveIR+Substr(RX_COD,01,06)+"2")
				aIR[nIndice][07]	:= Val( SubStr( SRX->RX_TXT ,01,10 ) ) //Valor desconto fixo 2
				aIR[nIndice][08]	:= Val( SubStr( SRX->RX_TXT ,11,06 ) ) // % sobre o excedente 2
				aIR[nIndice][09]	:= Val( SubStr( SRX->RX_TXT ,17,12 ) ) //Rendimento 3
				aIR[nIndice][10]	:= Val( SubStr( SRX->RX_TXT ,29,10 ) ) //valor desconto fixo 3
				aIR[nIndice][11]	:= Val( SubStr( SRX->RX_TXT ,39,06 ) ) // % sobre o excedente 3
			Endif	
			dbSkip()
		EndDo
	EndIf		
	If  dbSeek(xFilial("SRX")  + cChaveIR + "      " ) .And. ! lTabAnt//Carrega a tab. atual que pode ser em branco.
		nIndice ++
		aAdd(aIR,Array(11))
		If nIndice == 1
			aIR[nIndice][01]	:= cAno+"01"+cAno+"13"////Intervalo de validade da faixa
		Else
			aIR[nIndice][01]	:= cAno+Soma1(Substr(aIR[nIndice-1][01],11,02))+cAno+"13"//Intervalo de validade da faixa
		EndIf				
		aIR[nIndice][02]	:= Val( SubStr( SRX->RX_TXT ,01,12 ) )		//Isento	
		aIR[nIndice][03]	:= Val( SubStr( SRX->RX_TXT ,13,12 ) )    //Rendimento 1
		aIR[nIndice][04]	:= Val( SubStr( SRX->RX_TXT ,25,10 ) )    //Valor desconto fixo
		aIR[nIndice][05]	:= Val( SubStr( SRX->RX_TXT ,35,06 ) )    // % sobre o excedente
		aIR[nIndice][06]	:= Val( SubStr( SRX->RX_TXT ,41,12 ) )    //Rendimento 2
		If dbSeek(xFilial("SRX") +cChaveIR+"      "+"2")
			aIR[nIndice][07]	:= Val( SubStr( SRX->RX_TXT ,1 ,10 ) ) //Valor desconto fixo 2
			aIR[nIndice][08]	:= Val( SubStr( SRX->RX_TXT ,11,06 ) ) // % sobre o excedente 2
			aIR[nIndice][09]	:= Val( SubStr( SRX->RX_TXT ,17,12 ) ) //Rendimento 3
			aIR[nIndice][10]	:= Val( SubStr( SRX->RX_TXT ,29,10 ) ) //valor desconto fixo 3
			aIR[nIndice][11]	:= Val( SubStr( SRX->RX_TXT ,39,06 ) ) // % sobre o excedente 3
		Endif
	Else
		Help(" ",1,"GPETABIRDO")	
	EndIf
EndIf

nPosRet := aScan(aIr,{|aValor| cDataLan >= Substr(aValor[1],1,6)  .And. cDataLan <= Substr(aValor[1],7,6)  })//Verifica se a tabela esta no  intervalo pedido.
If nPosRet # 0
	aEval(aIrRet,{|cValor,nIndex|	aIrRet[nIndex] := aIR[nPosRet][nIndex+1]})//Retira o primeiro item do vetor.
EndIf

RestArea(aArea)

Return aIrRet
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper561Txt   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a geracao do Arquivo de exportacao no formato TXT.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper561Txt(nArquivo)

Local cLinha	:= ""
Local aAreaSRA	:= GetArea()
Local aDetTot  := Gper561Cal() //Guarda o valor calculado para cada funcionario colunas[C,D,E,F,G,H,I].
Local nX

RestArea(aAreaSRA)

cLinha 	:= SRA->RA_NOME + "|"
cLinha 	+= Alltrim(SRA->RA_RG) + "|"

For nX  = 1 To Len(aDetTot)
	cLinha += Trans(aDetTot[nX],cPictSal) + "|"
Next Nx	

If nArquivo != -1
	fSeek(nArquivo,0,2)
	fWrite(nArquivo,cLinha+chr(13)+chr(10)) 
EndIf

Return 
