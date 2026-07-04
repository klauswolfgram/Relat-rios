/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "GPER562.CH"

#define 	nQTDFUNPAG		33//Numero de linhas por pagina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER562   ºAutor  ³Alexandre Silva	  º Data ³  02/04/03  º±±
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
±±³Alex         ³05/11/2009³00000026596/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER562()

Private NomeProg 	:= "GPER562"
Private WnRel		:=	"GPER562"    //Nome Default do relatorio em Disco
Private cPerg    	:= "GPR562"
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
  ³ mv_par11        //  Situa‡oes                                ³
  ³ mv_par12        //  Categorias                               ³ 
  ³ mv_par13        //  Periodo de Referencia                    ³
  ³ mv_par14        //  Tipo do relatorio/Na impressora/Arquivo  ³
  ³ mv_par15        //  Ordem de impressao de relatorio          ³
  ³ mv_par16        //  Verbas de Imposto de Renda               ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

If Pergunte("GPR562",.T.)
	RptStatus({|lEnd| U_Gper562Imp(@lEnd,wnRel,"SRA")},Titulo)
EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Imp   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Relatorio.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Gper562Imp(lEnd,wnRel,cAlias)

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
Local cPerRef   	:= mv_par13
Local nDestino  	:= mv_par14
Local nOrdem     	:= mv_par15
Local nLin			:= 50
Local nPag			:= 01
Local nContFun		:= 99
Local nArquivo		:= 00
Local nTotReg		:= 00
Local cInicio  	:= ""
Local cFim			:= ""
Local cArqGravar 	:= ""
Local cFuncaoAnt 	:= Space(4)
Local cCcAnt     	:= Space(9)
Local cMatAnt    	:= Space(6)
Local aTitCab		:= Nil
Local lValid		:= .T.   
Local lPerNome 	:= .T.

Private cFilialAnt:= Space(FWGETTAMFILIAL)
Private cPictSal	:= PesqPict("SRC","RC_VALOR",20)
Private nQtdFunc	:= 0 //Numero de Asalariados.
Private nQtdFunIr	:= 0 //Numero de Asalariados com retencao.
Private nTotPag	:= 0
Private aSomTot   := {0,0,0,0,0,0,0,0,0} //Acumula os valores de aDetTot para a impressao no final.
Private aIR			:= Nil //Vetor contento todas as faixas de IR para o Ano.
Private aCodFol	:= {}
Private aInfoFil	:= {}
Private oFont08  	:= TFont():New("Corrier New",,10,,.f.,,,,,.f. )
Private oImp 		:= TMSPrinter():New()
Private cCodigos  := ALLTRIM(mv_par16)

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder( 1 )
ElseIf nOrdem == 2
	dbSetOrder( 2 )
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif

SRA->(dbGoTop())

If nDestino == 1 //Se  for impressora conta o total de paginas.
	Count For;
		(SRA->RA_CHAPA	>= cChapaDe .And. SRA->RA_CHAPA	<= cChapaAte) 	.And.;
	   (SRA->RA_NOME 	>= cNomeDe 	.And. SRA->RA_NOME 	<= cNomeAte ) 	.And.;
   	(SRA->RA_MAT	>= cMatDe 	.And. SRA->RA_MAT 	<= cMatAte  ) 	.And.;
	   (SRA->RA_CC		>= cCcDe	  	.And. SRA->RA_CC    	<= cCcAte	)	.And.;
	   ChecaFun(.F.);
		While ! Eof();
		To nTotReg				
		nTotPag := Int(nTotReg / nQTDFUNPAG)
		If Mod(nTotReg, nQTDFUNPAG) > 0
			nTotPag++					
		EndIf
EndIf			

SRA->(dbGoTop())

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

cFilialAnt := Space(FWGETTAMFILIAL)
cFuncaoAnt := Space(4)
cCcAnt     := Space(9)
cMatAnt    := Space(6)

If Len(Trim(cPerRef)) < 6
	lValid := .F.
	MsgAlert(STR0023)
EndIf

While !SRA->(EOF()) .And. &cInicio <= cFim .And.(SRA->RA_FILIAL+SRA->RA_MAT <> cFilialAnt+cMatAnt) .And. lValid

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
		SRA->(dbSkip())
		Loop
	EndIf
	
	nRetorno :=  ChecaFun(.T.)
	
	If nRetorno == 2 //Verifica as condicoes dos funcionarios 
		SRA->(dbSkip())
		Loop
	ElseIf nRetorno == 3
 		Exit			
	EndIf

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  |        Fim Consistencia da Parametrizacao do Intervalo de Impressao   		     |
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If nContFun > nQTDFUNPAG .And. nDestino == 1 &&Se for impressora.
		nLin 		:= 50
		Gper562Tit(@aTitCab)//Carrega aTitCab com a descricao dos campos de cabecalho.[7]
		Gper562Cab(@nPag,@nLin,aInfoFil,aTitCab)
		nContFun := 1
		nPag++
	EndIf		
	If nDestino == 1 
		Gper562Det(@nLin)
		SRA->(dbSkip())
		If nContFun == nQTDFUNPAG .And. !SRA->(EOF()) 	.And. &cInicio <= cFim ;
			.And.(SRA->RA_FILIAL+SRA->RA_MAT <> cFilialAnt+cMatAnt)	.And. lValid //Verifica o fim do relatorio
			oImp:EndPage()
		EndIf
		nContFun++
		nQtdFunc++ //Numero de Asalariados.
	Else
      If Empty(cArqGravar) .And.	lPerNome 
			cArqGravar := cGetFile(STR0001,OemToAnsi(STR0002),,"C:\",.T.,GETF_LOCALHARD) //"Arquivo Texto|*.TXT"###"Salvar Pesquisa..."
			nArquivo := fOpen(cArqGravar,1)
			If nArquivo == -1 .And. !Empty(cArqGravar)
				nArquivo := fCreate(cArqGravar)
			Else
				lPerNome := .F.
			Endif
		EndIf
		If nArquivo != 0
			Gper562Txt(nArquivo)
		EndIf			
		SRA->(dbSkip())
	EndIf		

Enddo

If nDestino == 1 .And. lValid
	Gper562Rod(,@nLin)
	oImp:Preview()
	MS_FLUSH()
ElseIf nDestino == 2 .And. lValid
	If nArquivo != 0
		fClose(nArquivo)
	EndIf
EndIf	

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Cab   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz  o cabecalho do Relatorio.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Cab(nPag,nLin,aInfoFil,aTitCab)

Local	cCGC 			:= aInfoFil[08] 
Local cRazSocial	:= aInfoFil[03] 
Local nCol			:= 090

oImp:StartPage()
//Formulario

oImp:Say(nLin+=050,nCol:=0050, STR0003 ,oFont08,50)// "         DGII              | SECRETARIA DE ESTADO DE FINANZAS                                                   # PAGINA"
oImp:Say(nLin+=050,nCol:=0050, STR0004 ,oFont08,50)// "         IR-4              | DIRECCION GENERAL DE IMPUESTOS INTERNO                                           ANO FISCAL"
oImp:Say(nLin+=050,nCol:=0050, STR0005 ,oFont08,50)// "FORMATO PARA EL CALCULO DE LAS RETENCIONES MENSUALES DEL ASALARIADO"

nLin += 50

oImp:Box(nLin+60,0040,nLin+220,3000)
oImp:Say(nLin+=100,nCol:=0050, STR0006 + Spac(02) + cRazSocial,oFont08,50)// "Agente de Retencion"
oImp:Say(nLin+=000,nCol+=1500, STR0007 ,oFont08,50)// "Periodo"
oImp:Say(nLin+=000,nCol+=0610, STR0008 ,oFont08,50)// "Hoja"

oImp:Say(nLin+=050,nCol:=0050, aTitCab[2] + Spac(02) + cCGC	,oFont08,50)// "RNC"
oImp:Say(nLin+=000,nCol+=1500, STR0009+Substr(mv_par13,5,2)	,oFont08,50)// "Mes"
oImp:Say(nLin+=000,nCol+=0300, STR0010+Substr(mv_par13,1,4)	,oFont08,50)// "Ano"
oImp:Say(nLin+=000,nCol+=0300, STR0011+lTrim(Str(nPag))			,oFont08,50)// "De"      
oImp:Say(nLin+=000,nCol+=0300, STR0012+lTrim(Str(nTotPag))		,oFont08,50)// "No."

oImp:Box(nLin+120,0040,nLin+400,4850) 
oImp:Line(nLin+170,0041,nLin+170,4850)
oImp:Say(nLin+=130,nCol:=0050, STR0013,oFont08,50)// "          INDENTFICACION DEL ASALARIADO       |                           REMUNERACION PERCIBIDAS                             |                                   LIQUIDACION DEL IMPUESTOS (LEY 11-92)"
oImp:Say(nLin+=050,nCol:=0050, STR0014,oFont08,50)// "                                |             |SUELDOS PAGOS    |REMUNERACIONES       |OTRAS REMUNERACIONES|                  |SUELDOS Y OTROS |              |                 |SALDO A FAVOR DEL ALsARIADOS |SALDO A FAVOR DE LA "
oImp:Say(nLin+=050,nCol:=0050, STR0015,oFont08,50)// "APELLIDOS Y NOMBRES COMPLETOS   | CEDULA O    |POR EL AGENTE DE |PAGADAS POR OTROS    |PAGADAS POR OTRO    |  TOTAL PAGADO EN |PAGOS SUJETOS A | LIQUIDACION  |   SALDO A FAV.  |COMPRESAR FUTURAS RETENCIONES|DIRECION GENERAL    "
oImp:Say(nLin+=050,nCol:=0050, STR0016,oFont08,50)// "                                | PASSAPORTE  |  RETENCION      |  EMPLEADORES        |AGENTE DE RETENCION | EL MES           |  RETENCION     |  PERIDO      |  DEL ASALARIADO | (Si H-1 es negativo)        | (Si H-1 es positivo"
oImp:Line(nLin+050,0041,nLin+050,4850)
oImp:Say(nLin+=060,nCol:=0050, STR0017,oFont08,50)// "         A                      |       B     |        C        |       D             |     E              |       F          |    G           |      H       |       I         |      J                      |          K         "

nLin+=150

Return     
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Det   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do Detalhe do Relatorio.                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Det(nLin)

Local nCol		:= 050
Local aAreaSRA	:= GetArea()
Local aDetTot  := Gper562Cal() //Guarda o valor calculado para cada funcionario colunas[C,D,E,F,G,H,I,J].
Local nX

oImp:Say(nLin,nCol+=000,SRA->RA_NOME			,oFont08,50)
oImp:Say(nLin,nCol+=730,Alltrim(SRA->RA_RG)	,oFont08,50)
nCol := 620
For nX  = 1 To Len(aDetTot)
		oImp:Say(nLin,nCol+=400,Trans(aDetTot[nX],cPictSal),oFont08,50)
Next nX	
nLin += 50

RestArea(aAreaSRA)

Return 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Rod   ³Autor ³  Alexandre Silva     ³Data³ 04/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz  o rodape    do Relatorio.                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Rod(nOpcao,nLin)

Local nCol := 0
Local nX

nLin  	  := 2650

oImp:Say(nLin+=050,nCol:=0800,STR0020 ,oFont08,50)//"TOTALES(RD$)"
nCol := 0630

For nX  = 1 To Len(aSomTot)
	oImp:Say(nLin,nCol+=400,Trans(aSomTot[nX],cPictSal),oFont08,50)
Next Nx	

nLin += 50

oImp:Box(nLin+040,0050,nlin+160 ,0820)//Caixa Esquerda
oImp:Line(nLin+090,0051,nLin+090,0820)
oImp:Line(nLin+040,0620,nLin+160,0620)

oImp:Say(nLin+=050,nCol:=0060, STR0018 + lTrim(Str(nQtdFunc)) 	,oFont08,50)//"(L)Numero asalariados"
oImp:Say(nLin+=000,nCol:=0850, STR0021 			   	           	,oFont08,50)
oImp:Say(nLin+=050,nCol:=0060, STR0019 + lTrim(Str(nQtdFunIr))	,oFont08,50)//"(M)Sujetos a Retencion"
oImp:Say(nLin+=000,nCol:=0850, STR0022 			   	           	,oFont08,50)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Cal   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz o calculo do imposto recolhido durante o periodo       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Cal()

Local aIRatual	:= {0,0,0,0,0,0,0,0,0} //Calculo do imposto para o periodo atual.
Local aIRant	:= {0,0,0,0,0,0,0,0,0} //Calculo do imposto para o periodo anterior.
Local cPerAnt	:= "" //Periodo Anterior
Local nMes		:= 0
Local nAno		:= 0
Local nSalFavor:= 0
Local nY

nMes := Val(Substr(MV_PAR13,5,2))
nAno := Val(Substr(MV_PAR13,1,4))
If nMes == 1
	nMes := 12
	nAno := nAno - 1
Else
	nMes -= 1
Endif
cPerAnt 	:= AllTrim(Str(nAno))+Alltrim(StrTran(Trans(nMes,"99")," ","0"))

aIRant	:= GPR562ImpPer(cPerAnt)
aIRatual	:= GPR562ImpPer(MV_PAR13)

nSalFavor:= aIRant[07]

If nSalFavor > 0 //Existem IR a favor do empregado. Nos meses anteriores

	If FpHist82(xFilial("SRX"),"72",SRA->RA_MAT) 
		cPerAnt	:= Substr(SRX->RX_TXT,3,4)+Substr(SRX->RX_TXT,1,2) //Periodo inicial do saldo a favor
	EndIf
	
	Do While MV_PAR13 > cPerAnt .And. nSalFavor > 0

      nSalFavor-= aIRAnt[06]
		
		nMes := Val(Substr(cPerAnt,5,2))
		nAno := Val(Substr(cPerAnt,1,4))
		
		If nMes == 12
			nMes := 11
			nAno := nAno + 1
		Else
			nMes += 1
		Endif
		
		cPerAnt 	:= AllTrim(Str(nAno))+Alltrim(StrTran(Trans(nMes,"99")," ","0"))
		aIRAnt	:= GPR562ImpPer(cPerAnt)		
      
	EndDo

	If nSalFavor > 0 //Verifica se existe saldo a favor do empregado.
		aIRatual[07] :=	nSalFavor	
	Else
		aIRatual[07] :=	0
	EndIf		
	
EndIf

If aIRatual[05] > 0 //Numero de funcionarios sujeitos a retencao de IR.
	nQtdFunIr++
EndIf                        

//Verifica o saldo a favor del empleado
If aIRatual[06] - aIRatual[07] < 0
	aIRatual[08] := (aIRatual[06]- aIRatual[07]) * -1  
	aIRatual[09] := 0	
Else
	aIRatual[08] := 0
	aIRatual[09] := aIRatual[06]- aIRatual[07]
EndIf	

//Atualiza os totalizadores
For nY = 1 to len(aIRatual)
	aSomTot[nY] += aIRatual[nY]
Next nY

Return aIRatual
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Cal   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz o calculo do imposto recolhido durante o Periodo.      ³±±
±±³Parametro ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GPR562ImpPer(cPeriodo)

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Descricao da matrix aDetTot e aSomTot.                       ³
  ³ aDetTot[1] - Salario pagos pelo agente de retencao           ³
  ³ aDetTot[2] - Salario pagos por outros empregadores           ³
  ³ aDetTot[3] - Outras remuneracao pagas pelo agente retencao   ³
  ³ aDetTot[4] - Total pago no mes.                              ³
  ³ aDetTot[5] - Salarios e outros pag. suj. retencao            ³
  ³ aDetTot[6] - Liquidacao no periodo.                          ³
  ³ aDetTot[7] - Saldo a favor do empregado.                     ³
  ³ aDetTot[8] - Saldo  favor do asalariado comp. futuras.       ³
  ³ aDetTot[9] - Saldo a favor de la direcion general.           ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
  
Local aDetTot 	:= {0,0,0,0,0,0,0,0,0}
Local aIRSel	:= {0,0,0,0,0,0,0,0,0,0}//Vetor com a tabela de IR usado para o calculo.

//Acumalado Total de Salario e outras retenciones
SRD->(dbSetOrder(1))
SRD->(dbSeek(xFilial("SRD")+SRA->RA_MAT+cPeriodo,.T.))

Do While SRA->RA_FILIAL == SRD->RD_FILIAL .And. SRA->RA_MAT == SRD->RD_MAT .And.  SRD->RD_DATARQ == cPeriodo
	If PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_DGII13") == "1"
		If PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "1"
			aDetTot[01] += SRD->RD_VALOR
		ElseIf PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "2"
			aDetTot[01] -= SRD->RD_VALOR
		EndIf
	ElseIf PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_DGII13") == "2"
		If PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "1"
			aDetTot[03] += SRD->RD_VALOR
		ElseIf PosSrv(SRD->RD_PD,SRD->RD_FILIAL,"RV_TIPOCOD") == "2"
			aDetTot[03] -= SRD->RD_VALOR
		EndIf
	EndIf
	
	//Impuesto retido y pagado coluna 6-H
	If Srd->Rd_Pd $ cCodigos     //aCodFol[66,1] .Or. Srd->Rd_Pd == aCodFol[67,1]
		aDetTot[06] += SRD->RD_VALOR
	EndIf
	SRD->(dbSkip())
EndDo

//Otras Remuneraciones pagadas por otros empleadores.
If FpHist82(xFilial("SRX"),"71",SRA->RA_MAT)
	Do While xFilial("SRX") == SRX->RX_FILIAL .And. AllTrim(SRA->RA_MAT) == Alltrim(SRX->RX_COD)
		If Substr(SRX->RX_TXT,3,4)+Substr(SRX->RX_TXT,1,2) == cPeriodo
			aDetTot[02] := Val(Substr(SRX->RX_TXT,7,13))
			Exit
		EndIf
		SRX->(dbSkip())
	EndDo
EndIf

aDetTot[04] := aDetTot[01] + aDetTot[02] + aDetTot[03] //Total de remuneraciones en el periodo 

aIRSel	:= GperLoadIR(cPeriodo,Substr(cPeriodo,1,4))//Valores de impuestos

If (aDetTot[04]*12) > aIrSel[1] 
	aDetTot[05]	:= aDetTot[04] 
EndIf                        

//Verifica se existe saldo a favor del asalariado.
If FpHist82(xFilial("SRX"),"72",SRA->RA_MAT) .And. cPeriodo >= Substr(SRX->RX_TXT,3,4)+Substr(SRX->RX_TXT,1,2)
	aDetTot[07] := Val(Substr(SRX->RX_TXT,7,13))
EndIf

If aDetTot[6]-aDetTot[7] < 0//Verifica o saldo a favor del empleado
	aDetTot[08] := (aDetTot[6] - aDetTot[7]) * -1 
Else
	aDetTot[09] := aDetTot[6] - aDetTot[7]
EndIf	

Return aDetTot
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Tit   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega uma matriz com titulos das coluna de cabecalho.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Tit(aTitCab)

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
±±³Fun‡…o    ³ ChecaFun     ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a situacao atual do funcionario e valida.      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ChecaFun(lTipoVer)

Local xRetorno 	:= Nil
Local cSitFunc		:= ""
Local cSituacao 	:= mv_par11
Local cCategoria	:= mv_par12
Local lChecaFil	:= .T.
Local lChecaFun	:= .T.

If lTipoVer 
	xRetorno := 1
Else
	xRetorno := .T.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Data Demissao         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cSitFunc := SRA->RA_SITFOLH
dDtPesqAf:= CTOD("01/" + Substr(MV_PAR13,3,2) +  "/" + Left(MV_PAR13,4),"DDMMYY")
If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
	cSitFunc := " "
Endif	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consiste situacao e categoria dos funcionarios			     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
	lChecaFun 	:= .F.
ElseIf cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) < MV_PAR13 
	lChecaFun 	:= .F.
ElseIf  Val(Substr(MV_PAR13,1,4)) <= Year(SRA->RA_ADMISSA)
	lChecaFun 	:= .F.
EndIf

If SRA->RA_FILIAL # cFilialAnt
	If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or. ! fInfo(@aInfoFil,Sra->Ra_Filial)
		lChecaFil	:= .F.
	Endif
   cFilialAnt := SRA->RA_FILIAL
Endif

If lTipoVer 
	If ! lChecaFil
		xRetorno := 3
	ElseIf ! lChecaFun 
		xRetorno := 2
	EndIf		
Else
	If	! lChecaFun .or. ! lChecaFil
		xRetorno := .F.
	EndIf		
EndIf

Return xRetorno
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Gper562Txt   ³Autor ³  Alexandre Silva     ³Data³ 03/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a geracao do Arquivo de exportacao no formato TXT.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Gper562Txt(nArquivo)

Local cLinha	:= ""
Local aAreaSRA	:= GetArea()
Local aDetTot  := Gper562Cal() //Guarda o valor calculado para cada funcionario colunas[C,D,E,F,G,H,I].
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

