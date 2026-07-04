/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "GPER037.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER037  ³ Autor ³ Silvia Taguti         ³ Data ³ 15.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ RELATORIO CERTIFICADO DE RENTA                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER037(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³MarcosKato  ³04/11/08³------³Criado a impressao do certificado 2 e 3   ³±±
±±³            ³        ³------³para ser impresso no Chile				    ³±±
±±³Luciana     ³14/08/09³ 17074³Correcao da pesquisa do parametro         |±±
±±³            ³        ³ /2009³cSituacao que estava buscando do mv_par12 ³±±
±±³            ³        ³      ³ao inves do mv_par10 devido a sigla do    |±±
±±³            ³        ³      ³pais pesquisado estar em minusculo.       |±±
±±³Rogerio R.  ³29/07/09³18278/³Compatibilizacao dos fontes para aumento  ³±±
±±³            ³        ³ 2009 ³do campo filial e gestão corporativa.     ³±±
±±³Luciana     ³18/02/10³ 01523³Ajustes na formatacao dos modelos 6 e     |±±
±±³            ³        ³ /2010³Declaracao Juranda do Relatorio de Renta  ³±±
±±³            ³        ³      ³Anual.                                    |±±
±±³Jonatas     ³24/03/10³00775/³Inclusao de tratamentos p/ reliquidacao e ³±±
±±³            ³        ³  2009³e Renta Anual.                            ³±±
±±³Jonatas     ³24/03/10³00775/³Alteracao p/ correta informacao dos       ³±±
±±³            ³        ³  2009³códigos "P", "C" e " " nos meses de       ³±±
±±³            ³        ³      ³admissão/demissão dos funcionários.       ³±±
±±³            ³		   ³	   ³                                          ³±±
±±³Jonathan glz³05/05/15³PCREQ-4256³Se elimina la funcion AjustaSX1, la cual  ³±±
±±³            ³		   ³	       ³realiza la modificacion aldiccio nario de ³±±
±±³            ³		   ³	       ³datos(SX1) por motivo de adecuacion de    ³±±
±±³            ³		   ³	       ³nueva estructura de SXs para version 12   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPER037()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cString   :="SRA"        // alias do arquivo principal (Base)
Local aOrd    	:= {STR0001,STR0002,STR0003} //"Matricula"###"C.Custo"###"Nome"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nModelo  := Iif(cPaisLoc=="CHI",1, 0)
Private cDesc1   := Iif(cPaisLoc=="CHI",STR0016,STR0006)//"Emiss„o de Recibos de Pagamento."
Private cDesc2   := STR0007		//"Ser  impresso de acordo com os parametros solicitados pelo"
Private cDesc3   := STR0008		//"usu rio."
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0009,1,STR0010, 1, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog := "GPER037"
Private nLastKey := 0
Private cPerg    :=Iif(cPaisLoc=="CHI","GPM037","GPR037")
Private nPagina  :=	0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Li       := 5
Private nlimite  := 132
Private Tamanho:=Iif(cPaisLoc=="CHI",Iif(nModelo==1.or.nModelo==6,"G","M"),"P")
Private lTipo  :=Iif(cPaisLoc=="CHI",.T.,.F.)
Private CONTFL:=1
Private Titulo := Iif(cPaisLoc=="CHI",STR0017,STR0011)
Private cAnoRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe, cMatAte, cNomDe, cNomAte, cLocArq, cNomArq, cEmail
Private cGirAtv,cNomRep,cRutRep,cSituacao, cCategoria,ChapaDe,ChapaAte
Private nMes1, nMes2, nMes3, nMes4, nMes5,nMes6, nMes7, nMes8, nMes9, nMes10, nMes11, nMes12,nTipAtv,nHdl
Private aCodFol:= {} , aMeses := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=nomeprog            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho,,iif(cPaisLoc=="CHI",.F.,.T.))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Ordem do Relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros ³
ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ mv_par01 -> Ano Referencia                    ³
³ mv_par02 -> Filial De          ?     ³
³ mv_par03 -> Filial At‚         ?     ³
³ mv_par04 -> Centro de Custo De ?     ³
³ mv_par05 -> Centro de Custo At‚?     ³
³ mv_par06 -> Matricula De       ?     ³
³ mv_par07 -> Matricula At‚      ?     ³
³ mv_par08 -> Nome De            ?     ³
³ mv_par09 -> Nome At‚           ?     ³
³ mv_par10 -> Chapa De           ?     ³
³ mv_par11 -> Chapa At‚          ?     ³
³ mv_par12 -> Situa‡”es a Imp.   ?     ³
³ mv_par13 -> Categorias a Imp.  ?     ³
³ mv_par14 -> Aliq. Mes 01       ?     ³
³ mv_par15 -> Aliq. Mes 02       ?     ³
³ mv_par16 -> Aliq. Mes 03       ?     ³
³ mv_par17 -> Aliq. Mes 04       ?     ³
³ mv_par18 -> Aliq. Mes 05       ?     ³
³ mv_par19 -> Aliq. Mes 06       ?     ³
³ mv_par20 -> Aliq. Mes 07       ?     ³
³ mv_par21 -> Aliq. Mes 08       ?     ³
³ mv_par22 -> Aliq. Mes 09       ?     ³
³ mv_par23 -> Aliq. Mes 10       ?     ³
³ mv_par24 -> Aliq. Mes 11       ?     ³
³ mv_par25 -> Aliq. Mes 12       ?     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cAnoRef    := mv_par01 //Ano de Referencia
cFilDe     := mv_par02 //Filial De
cFilAte    := mv_par03 //Filial Ate
cCcDe      := mv_par04 //Centro de Custo De
cCcAte     := mv_par05 //Centro de Custo Ate
cMatDe     := mv_par06 //Matricula Des
cMatAte    := mv_par07 //Matricula Ate
cNomDe     := mv_par08 //Nome De
cNomAte    := mv_par09 //Nome Ate
If cPaisLoc=="CHI"
	cSituacao  := mv_par10 //Situacoes a Imprimir
	cCategoria := mv_par11 //Categorias a Imprimir
	If MV_PAR12==1
		nModelo:=1
		nlimite:=220
	ElseIf MV_PAR12==2
		nModelo:=2
		nlimite:=132
	ElseIf MV_PAR12==3
		nModelo:=3
		nlimite:=132
	ElseIf MV_PAR12==4
		nModelo:=6
		nlimite:=220
	Endif
	nMes01     := mv_par13 //Mes01
	nMes02     := mv_par14 //Mes02
	nMes03     := mv_par15 //Mes03
	nMes04     := mv_par16 //Mes04
	nMes05     := mv_par17 //Mes05
	nMes06     := mv_par18 //Mes06
	nMes07     := mv_par19 //Mes07
	nMes08     := mv_par20 //Mes08
	nMes09     := mv_par21 //Mes09
	nMes10     := mv_par22 //Mes10
	nMes11     := mv_par23 //Mes11
	nMes12     := mv_par24 //Mes12
	cLocArq    := mv_par25 //Local do arquivo texto(certificado)
	cNomArq    := mv_par26 //Nome do Arquivo
	cEmail     := mv_par27 //Email
	cGirAtv	 := mv_par28 //Atividade da Empresa
	nTipAtv	 := mv_par29 //Tipo de Atividade(Aberta/Fechada)
	cNomRep	 := Alltrim(mv_par30) //Nome do representante
	cRutRep	 := Alltrim(mv_par31) //Rut do Representante
	cFolio     := mv_par32 //Folio
	cTipDec    := mv_par33 //Tipo de Declaracao (1-Original / 2-Retificatoria)
	cRutAnt    := mv_par34 //RUT Anterior
	cFolAnt    := mv_par35 //Folio Anterior

	If !Empty(cNomArq)
		cNomArq:= IIF(!".TXT" $ Upper(Alltrim(cNomArq)),Alltrim(cNomArq)+".txt",Alltrim(cNomArq))
		nHdl    := fCreate(Alltrim(cLocArq)+Alltrim(cNomArq))
	Endif
Else
	ChapaDe    := mv_par10 //Chapa De
	ChapaAte   := mv_par11 //Chapa Ate
	cSituacao  := mv_par12 //Situacoes a Imprimir
  	cCategoria := mv_par13 //Categorias a Imprimir
	nMes01     := mv_par14 //Mes01
	nMes02     := mv_par15 //Mes02
	nMes03     := mv_par16 //Mes01
	nMes04     := mv_par17 //Mes02
	nMes05     := mv_par18 //Mes01
	nMes06     := mv_par19 //Mes02
	nMes07     := mv_par20 //Mes01
	nMes08     := mv_par21 //Mes02
	nMes09     := mv_par22 //Mes01
	nMes10     := mv_par23 //Mes02
	nMes11     := mv_par24 //Mes01
	nMes12     := mv_par25 //Mes02
Endif
If LastKey() = 27 .Or. nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
	Return
Endif
If cPaisLoc<>"CHI"
	AAdd(aMeses,{"01",Alltrim(Str((nMes01 / 100) +1 ))})
	AADD(aMeses,{"02",Alltrim(Str((nMes02 / 100) +1 ))})
	AADD(aMeses,{"03",Alltrim(Str((nMes03 / 100) +1 ))})
	AADD(aMeses,{"04",Alltrim(Str((nMes04 / 100) +1 ))})
	AADD(aMeses,{"05",Alltrim(Str((nMes05 / 100) +1 ))})
	AADD(aMeses,{"06",Alltrim(Str((nMes06 / 100) +1 ))})
	AADD(aMeses,{"07",Alltrim(Str((nMes07 / 100) +1 ))})
	AADD(aMeses,{"08",Alltrim(Str((nMes08 / 100) +1 ))})
	AADD(aMeses,{"09",Alltrim(Str((nMes09 / 100) +1 ))})
	AADD(aMeses,{"10",Alltrim(Str((nMes10 / 100) +1 ))})
	AADD(aMeses,{"11",Alltrim(Str((nMes11 / 100) +1 ))})
	AADD(aMeses,{"12",Alltrim(Str((nMes12 / 100) +1 ))})
Endif
ProcGpe({|lEnd| R037Imp(@lEnd,wnRel,cString,cAnoRef,nModelo)},Titulo)  // Chamada do Relatorio

Set Device To Screen
If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R037IMP  ³ Autor ³ Silvia Taguti         ³ Data ³ 18.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao de Certificado de Renta         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R037Imp(lEnd,WnRel,cString,cAnoRef)                   	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R037Imp(lEnd,WnRel,cString,cAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cArqRef     := cAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER037","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER037","SRC","2") + "}")
Local aInfo
Local aVlMes      := array(13,14)
Local cInicio,cFim
Local nOrdem := aReturn[8]
Local cFilialAnt
Local cSitFunc,dDtPesqAf,cTipAfas
Local nValBase,nValFix,nValExc,nValAdi,nFonasa
Local nNumero   := 0 ,nTotMes := 0
Local nX := 0
Local aAfast	:= {}
Local nMeses	:= 0
Local nMesArq	:= 0
Local cAnoMesAf	:= ""
Local cMesAf	:= ""
Local nTamCod	:= TamSX3('RL_CPFCGC')[1]

Private cAliasMov := ""
Private cNomeSAL,cAlqFix, cAlqExc, cAlqAdi,cCodeBase,nCotPag
Private	Desc_Fil, Desc_End,	Desc_CGC
Private cEmpreg:=Space(60),cEmpres:=Space(60),cCNPJ:=Space(14),cEndEmp:=Space(60),cCidEmp:=Space(40),cRut:=Space(14), cCert:=Space(8)
Private	nHonor  := 0,nImpRet := 0,nPart   := 0,nSueldo := 0,nCotiz  := 0,nRenNet := 0,nMayor  := 0,nRenta  := 0,nRebaja := 0, nImpRlq := 0
Private lJan:=lFev:=lMar:=lAbr:=lMai:=lJun:=lJul:=lAgo:=lSet:=lOut:=lNov:=lDez:=.F.
Private aF1887:={}//array da Declaracao de Renda Anual Chile

Private nARenNet	:= 0, nAImpRet	:= 0, nAMayor	:= 0, nARenta	:= 0, nARebaja	:= 0, nImpARlq	:= 0

If cPaisLoc=="CHI"
	AAdd(aMeses,{"01",nMes01,"ENERO"})
	AADD(aMeses,{"02",nMes02,"FEBRERO"})
	AADD(aMeses,{"03",nMes03,"MARZO"})
	AADD(aMeses,{"04",nMes04,"ABRIL"})
	AADD(aMeses,{"05",nMes05,"MAYO"})
	AADD(aMeses,{"06",nMes06,"JUNIO"})
	AADD(aMeses,{"07",nMes07,"JULIO"})
	AADD(aMeses,{"08",nMes08,"AGOSTO"})
	AADD(aMeses,{"09",nMes09,"SEPTIEMBRE"})
	AADD(aMeses,{"10",nMes10,"OCTUBRE"})
	AADD(aMeses,{"11",nMes11,"NOVEMBRE"})
	AADD(aMeses,{"12",nMes12,"DICIEMBRE"})
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando a Ordem de impressao escolhida no parametro.    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea( "SRA")
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif
xDriver	:=	&(ReadDriver()[4])
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Selecionando o Primeiro Registro e montando Filtro.          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOrdem == 1
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	dbSeek(cFilDe + cMatDe,.T.)
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + cNomDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomAte + cMatAte
Endif

dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GPProcRegua(RecCount())// Total de elementos da regua

cFilialAnt := "  "

While SRA->( !Eof() .And. &cInicio <= cFim )

	For nx := 1 to 13
		aFill(aVlMes[nx],0)
	Next

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua Processamento                                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GPIncProc(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)

	If lEnd
		@Prow()+1,0 PSAY "Abortado por el operador"
		Exit
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cPaisLoc=="CHI"
		If 	(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
			(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
			(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
			SRA->(dbSkip(1))
			Loop
		EndIf
	Else
		If 	(SRA->RA_CHAPA < ChapaDe)  .Or. (SRA->RA_CHAPA > ChapaAte)  .Or. ;
			(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
			(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
			(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
			SRA->(dbSkip(1))
			Loop
		EndIf
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o tipo de Afastamento ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTipAfas := " "
	dDtAfas  := dDtRet := ctod("")
	fChkAfas(SRA->RA_FILIAL,SRA->RA_MAT,ctod("31/12/"+cAnoRef),@dDtAfas,@dDtRet,@cTipAfas)
	If cTipAfas $"OPQRXY"
		cTipAfas := "A"
	ElseiF cTipAfas $"HIJKLMNSUV" .Or.;
		(!Empty(SRA->RA_DEMISSA) .And. cAnoRef >= Alltrim(str(year(SRA->RA_DEMISSA))))
		cTipAfas := "D"
	ElseIf cTipAfas == "F"
		cTipAfas := "F"
	Else
		cTipAfas := " "
	EndIf
	If Alltrim(str(year(dDtAfas))) > cAnoRef
		cTipAfas := " "
	EndIf
	If !Empty(SRA->RA_DEMISSA) .And. Alltrim(str(year(SRA->RA_DEMISSA))) < cAnoRef
		SRA->(DbSkip())
		Loop
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios			     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( SRA->RA_SITFOLH $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif

	If cPaisLoc=="CHI"
		If nModelo==1
			If Alltrim(str(year(SRA->RA_ADMISSA))) > cAnoRef
				dbSkip()
				Loop
			Endif
			If !Empty(SRA->RA_DEMISSA).And.Alltrim(str(year(SRA->RA_DEMISSA))) < cAnoRef
				dbSkip()
				Loop
			Endif
		ElseIf nModelo==2 .And. SRA->RA_CATFUNC<>"P"//Certificado Modelo 2 deve possuir categoria P=Prolabore
			dbSkip()
			Loop
		ElseIf (nModelo==3 .Or. nModelo==6) .And. SRA->RA_CATFUNC=="P"//Certificado Modelo 3 ou 6 deve possuir categoria diferente de P=Prolabore
			dbSkip()
			Loop
		Endif
	Endif
	If SRA->RA_FILIAL # cFilialAnt
		If cPaisLoc<>"CHI"
			If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial)
				Exit
			Endif
		Endif
		If ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif

		Desc_Fil := aInfo[3]    // Nome Completo
		Desc_End := aInfo[4]    // Endereco Cobranca
		Desc_CGC := aInfo[8]    // CGC

		dbSelectArea( "SRA" )
		cFilialAnt := SRA->RA_FILIAL
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
		dbSkip()
		Loop
	EndIf

	If cPaisLoc=="CHI"
		DbSelectArea("SR4")
		SR4->(DbSetOrder(1))
		If DbSeek(SRA->(RA_FILIAL + RA_MAT + PADR(RA_CIC,nTamCod) + cAnoRef))

			cEmpreg := SRA->RA_NOME
			cEmpres := SM0->M0_NOMECOM
			cCNPJ   := SM0->M0_CGC
			cEndEmp := Iif(EMPTY(SM0->M0_ENDCOB),SM0->M0_ENDENT,SM0->M0_ENDCOB)
			cCidEmp := Iif(EMPTY(SM0->M0_CIDCOB),SM0->M0_CIDENT,SM0->M0_CIDCOB)
			//======================================================
			//Utilizado apenas na Declaracao de Renda Anual Chile
			//======================================================
			cRut    := Alltrim(SRA->RA_CIC)
			cCert	 := SR4->R4_NUM
			nHonor  := 0//Honorarios
			nImpRet := 0//Imposto retido
			nPart   := 0//Participacao
			nSueldo := 0//Sueldos,Jubilacion,Pension Bruta
			nCotiz  := 0//Cotizacion Previsional de cargo del Trabajador o Pensionado
			nRenNet := 0//Renda Neta
			nMayor  := 0//Mayor Retencion Solicitada
			nRenta  := 0//Rennta Total y/o no Gravada
			nRebaja := 0//Rebaja por Zonas Extremas
			nImpRlq := 0//Imposto retido reliquidacion

			nARenNet	:= 0
			nAImpRet	:= 0
			nAMayor	:= 0
			nARenta	:= 0
			nARebaja	:= 0
			nImpARlq	:= 0

			lJan    := .F.
			lFev    := .F.
			lMar    := .F.
			lAbr    := .F.
			lMai    := .F.
			lJun    := .F.
			lJul    := .F.
			lAgo    := .F.
			lSet    := .F.
			lOut    := .F.
			lNov    := .F.
			lDez    := .F.
			//======================================================
			While SR4->(!Eof()) .And. (SR4->R4_FILIAL+SR4->R4_MAT==SRA->RA_FILIAL+SRA->RA_MAT) .and. (Alltrim(SR4->R4_ANO) == cAnoRef)
				If SR4->R4_FILIAL+SR4->R4_MAT == SRA->RA_FILIAL+SRA->RA_MAT
					If Alltrim(SR4->R4_TIPOREN)=="A"//Honorario Bruto
						aVlMes[Val(SR4->R4_MES)][1] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="B"//Impuesto Unico Retenido por Renta Total Neta pagada durante el ano
						aVlMes[Val(SR4->R4_MES)][2] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="C"//Participacao o Asignacion
						aVlMes[Val(SR4->R4_MES)][3] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="D"//Sueldos,Jubilacion,Pension Bruta
						aVlMes[Val(SR4->R4_MES)][4] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="E"//Cotizacion Previsional de cargo del Trabajador o Pensionado
						aVlMes[Val(SR4->R4_MES)][5] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="F"//Mayor Retencion Solicitada
						aVlMes[Val(SR4->R4_MES)][6] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="G"//Renta Total y/o no gravada
						aVlMes[Val(SR4->R4_MES)][7] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="H"//Rebajas por Zonas Extremas
						aVlMes[Val(SR4->R4_MES)][8] += SR4->R4_VALOR
					ElseIf Alltrim(SR4->R4_TIPOREN)=="I"//Impuesto Unico Retenido por rentas acesorias/complementaria pagada entre enero/abril año sgte.
						aVlMes[Val(SR4->R4_MES)][14] += SR4->R4_VALOR
					Endif
				Endif
				SR4->(DbSkip())
			Enddo
		Else
			dbSelectArea("SRA")
			SRA->( dbSkip() )
			Loop
		Endif
	Else
		DbSelectArea("SRD")
		SRD->(DbSetOrder(1))
		If DbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
			While !Eof() .And. (SRD->RD_FILIAL+SRD->RD_MAT==SRA->RA_FILIAL+SRA->RA_MAT) .and. (Substr(SRD->RD_DATARQ,1,4) == cAnoRef)
				If SRD->RD_FILIAL+SRD->RD_MAT == SRA->RA_FILIAL+SRA->RA_MAT .AND. SRD->RD_PD == aCodFol[015,1];
					.and. (Substr(SRD->RD_DATARQ,1,4) == cAnoRef)
					aVlMes[Val(Substr(SRD->RD_DATARQ,5,2))][1] += SRD->RD_VALOR
				Endif
				If SRD->RD_FILIAL+SRD->RD_MAT == SRA->RA_FILIAL+SRA->RA_MAT .AND. SRD->RD_PD == aCodFol[066,1];
					.and. (Substr(SRD->RD_DATARQ,1,4) == cAnoRef)
					aVlMes[Val(Substr(SRD->RD_DATARQ,5,2))][2] += SRD->RD_VALOR
				Endif
				dbSelectArea("SRD")
				dbSkip()
			Enddo
		Endif
	Endif

	fRetAfas(Stod(cAnoRef+"0101"), Stod(cAnoRef+"1231") , , , , @aAfast )
	For nX := 1 to (Len(aVlMes)-1)
		If aMeses[nX][1] == Strzero(nX,2)
			If cPaisLoc=="CHI"
				If nModelo==1
					nHonor	+= aVlMes[nX][1]//Honorarios
					nImpRet	+= aVlMes[nX][2]//Imposto retido
					nPart  	+= aVlMes[nX][3]//Participacao
					nSueldo	+= aVlMes[nX][4]//Sueldos,Jubilacion,Pension Bruta
					nCotiz 	+= aVlMes[nX][5]//Cotizacion Previsional de cargo del Trabajador o Pensionado
					nRenNet	+= aVlMes[nX][4] - aVlMes[nX][5]//Renda Neta
					nMayor 	+= aVlMes[nX][6]//Mayor Retencion Solicitada
					nRenta 	+= aVlMes[nX][7]//Rennta Total y/o no Gravada
					nRebaja	+= aVlMes[nX][8]//Rebaja por Zonas Extremas
					nImpRlq	+= aVlMes[nX][14]//Imposto retido reliquidacion

					// Montos actualizados
					nARenNet	+= ( aVlMes[nX][4] - aVlMes[nX][5] ) * aMeses[nX][2]
					nAImpRet	+= aVlMes[nX][2] * aMeses[nX][2]
					nAMayor		+= aVlMes[nX][6] * aMeses[nX][2]
					nARenta		+= aVlMes[nX][7] * aMeses[nX][2]
					nARebaja	+= aVlMes[nX][8] * aMeses[nX][2]
					nImpARlq	+= aVlMes[nX][14] * aMeses[nX][2]//Imposto retido reliquidacion

					If (aVlMes[nX][1]+aVlMes[nX][2]+aVlMes[nX][3]+aVlMes[nX][4]+aVlMes[nX][5]+aVlMes[nX][6]+aVlMes[nX][7]+aVlMes[nX][8])>0
						If nX==1//Janeiro
							lJan:= .T.
						ElseIF nX==2//Fevereiro
							lFev:= .T.
						ElseIF nX==3//Marco
							lMar:= .T.
						ElseIF nX==4//Abril
							lAbr:= .T.
						ElseIF nX==5//Maio
							lMai:= .T.
						ElseIF nX==6//Junho
							lJun:= .T.
						ElseIF nX==7//Julho
							lJul:= .T.
						ElseIF nX==8//Agosto
							lAgo:= .T.
						ElseIF nX==9//setembro
							lSet:= .T.
						ElseIF nX==10//Outubro
							lOut:= .T.
						ElseIF nX==11//Novembro
							lNov:= .T.
						ElseIF nX==12//Dezembro
							lDez:= .T.
						Endif
					Endif
				ElseIf nModelo==2
					//=======================
					//Modelo de Certificado 2
					//=======================
					aVlMes[nX][4] := aMeses[nX][2]         //Fator de atualizacao
					If aVlMes[nX][1]+aVlMes[nX][2]+aVlMes[nX][3] > 0//Honorarios#Imposto#Participacao
						nTotMes += aVlMes[nX][1]+aVlMes[nX][2]+aVlMes[nX][3]
						aVlMes[nX][5] := aVlMes[nX][1]*aVlMes[nX][4]//Honorarios Atualizados
						aVlMes[nX][6] := aVlMes[nX][3]*aVlMes[nX][4]//Participacao Atualizados
						aVlMes[nX][7] := aVlMes[nX][2]*aVlMes[nX][4]//Impostos Atualizados
					Endif
					aVlMes[13][1] += aVlMes[nX][1]
					aVlMes[13][2] += aVlMes[nX][2]
					aVlMes[13][3] += aVlMes[nX][3]
					aVlMes[13][4] += aVlMes[nX][4]
					aVlMes[13][5] += aVlMes[nX][5]
					aVlMes[13][6] += aVlMes[nX][6]
					aVlMes[13][7] += aVlMes[nX][7]
					//=====================================
					//Convertendo para o formato Caractere
					//=====================================
					aVlMes[nX][1] := Transform(aVlMes[nX][1],TM(aVlMes[nX][1],11,MsDecimais(2)))//Honorarios
					aVlMes[nX][2] := Transform(aVlMes[nX][2],TM(aVlMes[nX][2],11,MsDecimais(2)))//Imposto retido
					aVlMes[nX][3] := Transform(aVlMes[nX][3],TM(aVlMes[nX][3],11,MsDecimais(2)))//Participacao
					aVlMes[nX][4] := Transform(aVlMes[nX][4],TM(aVlMes[nX][4], 6,MsDecimais(2)))//Fator de Actualizacao
					aVlMes[nX][5] := Transform(aVlMes[nX][5],TM(aVlMes[nX][5],14,MsDecimais(2)))//Honorarios Atualizados
					aVlMes[nX][6] := Transform(aVlMes[nX][6],TM(aVlMes[nX][6],14,MsDecimais(2)))//Participacao Atualizados
					aVlMes[nX][7] := Transform(aVlMes[nX][7],TM(aVlMes[nX][7],14,MsDecimais(2)))//Impostos Atualizadps
				ElseIf nModelo==3
					//=======================
					//Modelo de Certificado 3
					//=======================
					aVlMes[nX][3] := aMeses[nX][2]
					If aVlMes[nX][2]+aVlMes[nX][4]+aVlMes[nX][5] > 0//Imposto#Sueldo#Cotizacion
						nTotMes += aVlMes[nX][2]+aVlMes[nX][4]+aVlMes[nX][5]
						aVlMes[nX][1] := aVlMes[nX][4] - aVlMes[nX][5]
						aVlMes[nX][6] := aVlMes[nX][1]*aVlMes[nX][3]
						aVlMes[nX][7] := aVlMes[nX][2]*aVlMes[nX][3]
					Endif
					aVlMes[13][1] += aVlMes[nX][1]
					aVlMes[13][2] += aVlMes[nX][2]
					aVlMes[13][3] += aVlMes[nX][3]
					aVlMes[13][4] += aVlMes[nX][4]
					aVlMes[13][5] += aVlMes[nX][5]
					aVlMes[13][6] += aVlMes[nX][6]
					aVlMes[13][7] += aVlMes[nX][7]
					//=====================================
					//Convertendo para o formato Caractere
					//=====================================
					aVlMes[nX][1] := Transform(aVlMes[nX][1],TM(aVlMes[nX][1],11,MsDecimais(2)))//Renta Imponible afecta al impuesto unico de segunda categoria
					aVlMes[nX][3] := Transform(aVlMes[nX][3],TM(aVlMes[nX][3], 6,MsDecimais(2)))//Fator de Atualizacao
					aVlMes[nX][6] := Transform(aVlMes[nX][6],TM(aVlMes[nX][6],14,MsDecimais(2)))//Renda afetada com imposto unico 2 Cat.
					aVlMes[nX][7] := Transform(aVlMes[nX][7],TM(aVlMes[nX][7],14,MsDecimais(2)))//Imposto unico retido
					aVlMes[nX][2] := Transform(aVlMes[nX][2],TM(aVlMes[nX][2],11,MsDecimais(2)))//Imposto
					aVlMes[nX][4] := Transform(aVlMes[nX][4],TM(aVlMes[nX][4],11,MsDecimais(2)))//Sueldo
					aVlMes[nX][5] := Transform(aVlMes[nX][5],TM(aVlMes[nX][5],11,MsDecimais(2)))//Cotizacion
				Else
					//=======================
					//Modelo de Certificado 6
					//=======================
					aVlMes[nX][3] := aMeses[nX][2]
					If aVlMes[nX][2]+aVlMes[nX][4]+aVlMes[nX][5]+aVlMes[nX][14] > 0//Imposto#Sueldo#Cotizacion#mayor retencion#renta total#rebaja por zonas
						nTotMes += aVlMes[nX][2]+aVlMes[nX][4]+aVlMes[nX][5]+aVlMes[nX][6]+aVlMes[nX][7]+aVlMes[nX][8]+aVlMes[nX][14]

						aVlMes[nX][1] := aVlMes[nX][4] - aVlMes[nX][5]
						aVlMes[nX][9] := aVlMes[nX][1]*aVlMes[nX][3]
						aVlMes[nX][10] := (aVlMes[nX][2]+aVlMes[nX][14])*aVlMes[nX][3]
						aVlMes[nX][11] := aVlMes[nX][6]*aVlMes[nX][3]
						aVlMes[nX][12] := aVlMes[nX][7]*aVlMes[nX][3]
						aVlMes[nX][13] := aVlMes[nX][8]*aVlMes[nX][3]
					Endif
					aVlMes[13][1] += aVlMes[nX][1]
					aVlMes[13][2] += aVlMes[nX][2]+aVlMes[nX][14]
					aVlMes[13][3] += aVlMes[nX][3]
					aVlMes[13][4] += aVlMes[nX][4]
					aVlMes[13][5] += aVlMes[nX][5]
					aVlMes[13][6] += aVlMes[nX][6]
					aVlMes[13][7] += aVlMes[nX][7]
					aVlMes[13][8] += aVlMes[nX][8]
					aVlMes[13][9] += aVlMes[nX][9]
					aVlMes[13][10] += aVlMes[nX][10]
					aVlMes[13][11] += aVlMes[nX][11]
					aVlMes[13][12] += aVlMes[nX][12]
					aVlMes[13][13] += aVlMes[nX][13]
					aVlMes[13][14] += aVlMes[nX][14]
					//=====================================
					//Convertendo para o formato Caractere
					//=====================================
					aVlMes[nX][1] := Transform(aVlMes[nX][1] ,TM(aVlMes[nX][1] ,11,MsDecimais(0)))//Renta Imponible afecta al impuesto unico de segunda categoria
					aVlMes[nX][3] := Transform(aVlMes[nX][3] ,TM(aVlMes[nX][3] , 6,3))//Fator de Atualizacao
					aVlMes[nX][2] := Transform(aVlMes[nX][2]+aVlMes[nX][14] ,TM(aVlMes[nX][2]+aVlMes[nX][14] ,11,MsDecimais(0)))//Imposto
					aVlMes[nX][4] := Transform(aVlMes[nX][4] ,TM(aVlMes[nX][4] ,11,MsDecimais(0)))//Sueldo
					aVlMes[nX][5] := Transform(aVlMes[nX][5] ,TM(aVlMes[nX][5] ,11,MsDecimais(0)))//Cotizacion
					aVlMes[nX][6] := Transform(aVlMes[nX][6] ,TM(aVlMes[nX][6] ,11,MsDecimais(0)))//Mayor Retencion Solicitada
					aVlMes[nX][7] := Transform(aVlMes[nX][7] ,TM(aVlMes[nX][7] ,11,MsDecimais(0)))//Renta Total y/o no Gravada
					aVlMes[nX][8] := Transform(aVlMes[nX][8] ,TM(aVlMes[nX][8] ,11,MsDecimais(0)))//Rebaja por Zonas Extremas
					aVlMes[nX][14]:= Transform(aVlMes[nX][14],TM(aVlMes[nX][14],11,MsDecimais(0)))//Imposto reliquidado ano seguinte
					//Montes Atualizados
					aVlMes[nX][9] := Transform(aVlMes[nX][9] ,TM(aVlMes[nX][9] ,14,MsDecimais(0)))//Renda afetada com imposto unico 2 Cat.
					aVlMes[nX][10]:= Transform(aVlMes[nX][10],TM(aVlMes[nX][10],14,MsDecimais(0)))//Imposto unico retido
					aVlMes[nX][11]:= Transform(aVlMes[nX][11],TM(aVlMes[nX][11],14,MsDecimais(0)))//Mayor retencion de impto solicitada
					aVlMes[nX][12]:= Transform(aVlMes[nX][12],TM(aVlMes[nX][12],14,MsDecimais(0)))//Renta Total y/o no Gravada
					aVlMes[nX][13]:= Transform(aVlMes[nX][13],TM(aVlMes[nX][13],14,MsDecimais(0)))//Renda afetada com imposto unico 2 Cat.
				Endif
			Else
				If aVlMes[nX][1] + aVlMes[nX][2] > 0
					nTotMes += aVlMes[nX][1] + aVlMes[nX][2]
					aVlMes[nX][3] := Transform(Val(aMeses[nX][2]),TM(Val(aMeses[nX][2]),10,4))
					aVlMes[nX][4] := Transform(aVlMes[nX][1] * Val(aMeses[nX][2]),TM(aVlMes[nX][1],14,MsDecimais(1)))
					aVlMes[nX][5] := Transform(aVlMes[nX][2] * Val(aMeses[nX][2]),TM(aVlMes[nX][2],14,MsDecimais(1)))
					aVlMes[nX][1] := Transform(aVlMes[nX][1],TM(aVlMes[nX][1],14,MsDecimais(1)))
					aVlMes[nX][2] := Transform(aVlMes[nX][2],TM(aVlMes[nX][2],14,MsDecimais(1)))
				Endif
			Endif
		Endif
	Next
	If nModelo==1
		If(nRenNet+nImpRet+nMayor+nRenta+nRebaja)>0
			Aadd(aF1887,{cRut,nRenNet,nImpRet,nMayor,nRenta,nRebaja,lJan,lFev,lMar,lAbr,lMai,lJun,lJul,lAgo,lSet,lOut,lNov,lDez,cCert,nARenNet,nAImpRet,nAMayor,nARenta,nARebaja,nImpRlq,nImpARlq})
			cLinha	:= PADL(cRut,9) + ";" + StrZero(nARenNet,12) + ";" + StrZero(nAImpRet+nImpARlq,12) + ";"
			cLinha	+= StrZero(nAMayor,12) + ";" + StrZero(nARenta,12) + ";" + StrZero(nARebaja,12) + ";"

			Aadd(aF1887[Len(aF1887)],{"","","","","","","","","","","",""})

			For nMeses := 7 To 18
				nMesArq := nMeses - 6
				cAnoMesAf := cAnoRef + Alltrim( StrZero( nMesArq, 2 ) )

				If MesAno(SRA->RA_ADMISSA) == cAnoMesAf
					If Day(SRA->RA_ADMISSA) == 1
						cLinha	+= "C"
					Else
						cLinha	+= "P"
					EndIf
				ElseIf MesAno(SRA->RA_DEMISSA) == cAnoMesAf
					If Day(SRA->RA_DEMISSA) == f_UltDia(SRA->RA_DEMISSA)
						cLinha	+= "C"
					Else
						cLinha	+= "P"
					EndIf
				Else
				  	If aF1887[1,nMeses]
						cLinha	+= If( aScan( aAfast, { |x| ( MesAno(x[3]) == cAnoMesAf ) .Or. ( MesAno(X[3]) < MesAno(cAnoMesAf) .And. ( Empty(x[4]) .Or. ( MesAno(x[4]) >= MesAno(cAnoMesAf) ) ) ) } ) > 0, "P", "C" )
					Else
						cLinha	+= " "
					EndIf
				EndIf

				aF1887[Len(aF1887)][27][nMesArq] := Right( cLinha, 1 )

				cLinha	+= ";"
			Next

			If cAnoRef < "2009"
				cLinha	+= StrZero(Val(Substr(cCert,2,7)),7)
			Else
				cLinha	+= cCert
			EndIf

			fWrite(nHdl,cLinha,Len(cLinha))                  // Grava TXT
			fWrite(nHdl,CHR(13)+CHR(10))
		Endif
	Else
		If nTotMes > 0
			fCabec(aInfo,aVlMes,nModelo)
		Endif
	Endif
	nTotMes := 0
	dbSelectArea("SRA")
	SRA->( dbSkip() )
Enddo
If nModelo==1 .And. Len(aF1887)>0
	fClose(nHdl)
	Darenda(aF1887)//Declaracao Anual de Renda
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRD")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRA")
dbClearFilter()
RetIndex("SRA")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec    ³ Autor ³ Silvia Taguti         ³ Data ³ 18.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabec()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCabec(aInfo,aVlMes,nModelo)   // Cabecalho

Local nQbra		:= 0
Local nAnoTrib	:= 0
Local cDescr   	:= ""
Local cDescr2	:= ""
Local cAnoTrib	:= ""
Local cPictCIC	:= PesqPict('SRA','RA_CIC')
Local cCGC		:= Transform( cCNPJ, "@R ##.###.###-#" )

nAnoTrib		:= Val(cAnoRef) + 1
cAnoTrib		:= Str(nAnoTrib)

Li := 1
If cPaisLoc=="CHI"
	SET DEVICE TO PRINT
	@ Li,001 PSAY AVALIMP(nLimite)
	Li:=2
	If nModelo==2
		cDescr:="La Sociedad Anonima "+Alltrim(cEmpres)+" certifica que al Sr."+Alltrim(cEmpreg)+" "
		cDescr+="Rut. N°"+Transform(cRut,cPictCIC)+" durante el ano "+cAnoRef+", se le han pagado las siguientes rentas por concepto de "
		cDescr+="Honorarios, y sobre las cuales se le practicaron las retenciones de impuestos que se senalan:"
		@ Li,001 PSAY PADC("MODELO DE CERTIFICADO N°2",132)
		Li +=2
		@ Li,001 PSAY "Razon Social Sociedad Anonima "+Alltrim(cEmpres)
		Li++
		@ Li,001 PSAY "Rut. N° "+Alltrim(cCGC)
		Li++
		@ Li,001 PSAY "Direccion : "+Alltrim(cEndEmp)
		Li++
		@ Li,001 PSAY "Giro o Actividad : "+cGirAtv
		Li++
		@ Li,001 PSAY "Tipo de Sociedad : "+Iif(nTipAtv==1,"Abierta","Cerrada")
		Li +=2
		@ ++Li,001 PSAY PADC("CERTIFICADO SOBRE HONORARIOS Y PARTICIPACIONES O ASIGNACIONES A DIRECTORES PAGADOS POR SOCIEDADES ANONIMAS",132)
		Li +=1
		@ ++Li,001 PSAY PADL("Certificado N° "+cCert,132)
		Li++
		@ Li,001 PSAY PADL(Alltrim(cCidEmp)+","+Alltrim(Str(Day(Date())))+" de "+aMeses[month(date()),3]+" de "+cAnoRef,132)
		Li +=1
		For nQbra:=1 To Round(Len(cDescr)/132,0)+1
			@ ++Li,001 PSAY MemoLine( cDescr,132, nQbra )
		Next
		Li +=2
		@ Li,003 PSAY REPLICATE("-",119)
		@ ++Li,003 PSAY "|                |        RENTA BRUTA        |             |             |            MONTOS ACTUALIZADOS             |"
		@ ++Li,003 PSAY "|                |---------------------------|             |   FACTOR    |--------------------------------------------|"
		@ ++Li,003 PSAY "| PERIODOS       | HONORARIOS  | PARTIC. O   |  IMPUESTO   |     DE      |  HONORARIOS  |  PARTIC. O   |   IMPUESTO   |"
		@ ++Li,003 PSAY "|                |             |   ASIG.     |  RETENIDO   |  ACTUALIZ.  |  ACTUALIZ.   |    ASIG.     |   RETENIDO   |"
		@ ++Li,003 PSAY "|                |             |             |             |             |              |              |              |"
		@ ++Li,003 PSAY "|"+REPLICATE("-",16)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"
		@ ++Li,003 PSAY "|    ENERO       |"+PADL(aVlMes[01][1],13)+"|" +PADL(aVlMes[01][3],13)+"|"+PADL(aVlMes[01][2],13)+"|"+PADL(aVlMes[01][4],13)+"|"+PADL(aVlMes[01][5],14)+"|"+PADL(aVlMes[01][6],14)+"|"+PADL(aVlMes[01][7],14)+"|"
		@ ++Li,003 PSAY "|    FEBRERO     |"+PADL(aVlMes[02][1],13)+"|" +PADL(aVlMes[02][3],13)+"|"+PADL(aVlMes[02][2],13)+"|"+PADL(aVlMes[02][4],13)+"|"+PADL(aVlMes[02][5],14)+"|"+PADL(aVlMes[02][6],14)+"|"+PADL(aVlMes[02][7],14)+"|"
		@ ++Li,003 PSAY "|    MARZO       |"+PADL(aVlMes[03][1],13)+"|" +PADL(aVlMes[03][3],13)+"|"+PADL(aVlMes[03][2],13)+"|"+PADL(aVlMes[03][4],13)+"|"+PADL(aVlMes[03][5],14)+"|"+PADL(aVlMes[03][6],14)+"|"+PADL(aVlMes[03][7],14)+"|"
		@ ++Li,003 PSAY "|    ABRIL       |"+PADL(aVlMes[04][1],13)+"|" +PADL(aVlMes[04][3],13)+"|"+PADL(aVlMes[04][2],13)+"|"+PADL(aVlMes[04][4],13)+"|"+PADL(aVlMes[04][5],14)+"|"+PADL(aVlMes[04][6],14)+"|"+PADL(aVlMes[04][7],14)+"|"
		@ ++Li,003 PSAY "|    MAYO        |"+PADL(aVlMes[05][1],13)+"|" +PADL(aVlMes[05][3],13)+"|"+PADL(aVlMes[05][2],13)+"|"+PADL(aVlMes[05][4],13)+"|"+PADL(aVlMes[05][5],14)+"|"+PADL(aVlMes[05][6],14)+"|"+PADL(aVlMes[05][7],14)+"|"
		@ ++Li,003 PSAY "|    JUNIO       |"+PADL(aVlMes[06][1],13)+"|" +PADL(aVlMes[06][3],13)+"|"+PADL(aVlMes[06][2],13)+"|"+PADL(aVlMes[06][4],13)+"|"+PADL(aVlMes[06][5],14)+"|"+PADL(aVlMes[06][6],14)+"|"+PADL(aVlMes[06][7],14)+"|"
		@ ++Li,003 PSAY "|    JULIO       |"+PADL(aVlMes[07][1],13)+"|" +PADL(aVlMes[07][3],13)+"|"+PADL(aVlMes[07][2],13)+"|"+PADL(aVlMes[07][4],13)+"|"+PADL(aVlMes[07][5],14)+"|"+PADL(aVlMes[07][6],14)+"|"+PADL(aVlMes[07][7],14)+"|"
		@ ++Li,003 PSAY "|    AGOSTO      |"+PADL(aVlMes[08][1],13)+"|" +PADL(aVlMes[08][3],13)+"|"+PADL(aVlMes[08][2],13)+"|"+PADL(aVlMes[08][4],13)+"|"+PADL(aVlMes[08][5],14)+"|"+PADL(aVlMes[08][6],14)+"|"+PADL(aVlMes[08][7],14)+"|"
		@ ++Li,003 PSAY "|    FEBRERO     |"+PADL(aVlMes[09][1],13)+"|" +PADL(aVlMes[09][3],13)+"|"+PADL(aVlMes[09][2],13)+"|"+PADL(aVlMes[09][4],13)+"|"+PADL(aVlMes[09][5],14)+"|"+PADL(aVlMes[09][6],14)+"|"+PADL(aVlMes[09][7],14)+"|"
		@ ++Li,003 PSAY "|    SEPTIEMBRE  |"+PADL(aVlMes[10][1],13)+"|" +PADL(aVlMes[10][3],13)+"|"+PADL(aVlMes[10][2],13)+"|"+PADL(aVlMes[10][4],13)+"|"+PADL(aVlMes[10][5],14)+"|"+PADL(aVlMes[10][6],14)+"|"+PADL(aVlMes[10][7],14)+"|"
		@ ++Li,003 PSAY "|    OCTUBRE     |"+PADL(aVlMes[11][1],13)+"|" +PADL(aVlMes[11][3],13)+"|"+PADL(aVlMes[11][2],13)+"|"+PADL(aVlMes[11][4],13)+"|"+PADL(aVlMes[11][5],14)+"|"+PADL(aVlMes[11][6],14)+"|"+PADL(aVlMes[11][7],14)+"|"
		@ ++Li,003 PSAY "|    DICIEMBRE   |"+PADL(aVlMes[12][1],13)+"|" +PADL(aVlMes[12][3],13)+"|"+PADL(aVlMes[12][2],13)+"|"+PADL(aVlMes[12][4],13)+"|"+PADL(aVlMes[12][5],14)+"|"+PADL(aVlMes[12][6],14)+"|"+PADL(aVlMes[12][7],14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",119)
		@ ++Li,003 PSAY "|    TOTAL       |"+PADL(Transform(aVlMes[13][1],TM(aVlMes[13][1],13,MsDecimais(2))),13)+"|";
		+PADL(Transform(aVlMes[13][3],TM(aVlMes[13][3],13,MsDecimais(2))),13)+"|" +PADL(Transform(aVlMes[13][2],TM(aVlMes[13][2],13,MsDecimais(2))),13);
		+Replicate(" ",14)+"|" +PADL(Transform(aVlMes[13][5],TM(aVlMes[13][5],14,MsDecimais(2))),14)+"|";
		+PADL(Transform(aVlMes[13][6],TM(aVlMes[13][6],14,MsDecimais(2))),14)+"|" +PADL(Transform(aVlMes[13][7],TM(aVlMes[13][7],14,MsDecimais(2))),14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",119)
	ElseIf nModelo==3
		cDescr:= "El Empleador, Habilitado o Pagador,"+Alltrim(cEmpres)+" certifica que al Sr. "+Alltrim(cEmpreg)+" "
		cDescr+= "Rut. N° "+Transform(cRut,cPictCIC)+" en su calidad de empleado depediente,jubilado,pensionado o montepiado, segun corresponda,"
		cDescr+= "durante el ano "+cAnoRef+", se le han pagado las rentas que se indican y sobre las cuales se le practicaron las "
		cDescr+= "retenciones de impuestos que se senalan:"
		@ Li,001 PSAY PADC("MODELO DE CERTIFICADO N°3",132)
		Li +=2
		@ Li,001 PSAY "Empleador        : "+Alltrim(cEmpres)
		Li++
		@ Li,001 PSAY "Rut. N           : "+Alltrim(cCGC)
		Li++
		@ Li,001 PSAY "Direccion        : "+Alltrim(cEndEmp)
		Li++
		@ Li,001 PSAY "Giro o Actividad : "+cGirAtv
		Li +=2
		@ ++Li,001 PSAY PADC("CERTIFICADO SOBRE SUELDOS, PENSIONES O JUBILACIONES Y OTRAS RENTAS SIMILARES",132)
		Li +=1
		@ ++Li,001 PSAY PADL("Certificado N° "+cCert,132)
		Li++
		@ Li,001 PSAY PADL(Alltrim(cCidEmp)+","+Alltrim(Str(Day(Date())))+" de "+aMeses[month(date()),3]+" de "+cAnoRef,132)
		Li +=1
		For nQbra:=1 To Round(Len(cDescr)/132,0)+1
			@ ++Li,001 PSAY MemoLine( cDescr,132, nQbra )
		Next
		Li +=2
		@ Li,003 PSAY REPLICATE("-",118)
		@ ++Li,003 PSAY "|                |             | COTIZACION  |   RENTA     |             |             |    MONTOS ACTUALIZADOS      |"
		@ ++Li,003 PSAY "|                |    SUELDO   |  PREV. DE   | IMPONIBLE   |   IMPUESTO  |   FACTOR    |-----------------------------|"
		@ ++Li,003 PSAY "| PERIODOS       |  JUBILACION | CARGO DEL   | AFECTA AL   |    UNICO    |     DE      |    RENTA     |    IMPUESTO  |"
		@ ++Li,003 PSAY "|                |  O PENSION  | TRABAJADOR  | IMPUESTO    |   RETENIDO  |  ACTUALIZ.  |  AFECTA AL   |     UNICO    |"
		@ ++Li,003 PSAY "|                |    BRUTA    | PENSIONADO  | UNICO DE    |             |             |  IMPTO. UNI  |    RETENIDO  |"
		@ ++Li,003 PSAY "|                |             |             | 2° CATEG.   |             |             |  2° CATEG.   |              |"
		@ ++Li,003 PSAY "|"+REPLICATE("-",16)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"
		@ ++Li,003 PSAY "|    ENERO       |"+PADL(aVlMes[01][4],13)+"|" +PADL(aVlMes[01][5],13)+"|"+PADL(aVlMes[01][1],13)+"|"+PADL(aVlMes[01][2],13)+"|"+PADL(aVlMes[01][3],13)+"|"+PADL(aVlMes[01][6],14)+"|"+PADL(aVlMes[01][7],14)+"|"
		@ ++Li,003 PSAY "|    FEBRERO     |"+PADL(aVlMes[02][4],13)+"|" +PADL(aVlMes[02][5],13)+"|"+PADL(aVlMes[02][1],13)+"|"+PADL(aVlMes[02][2],13)+"|"+PADL(aVlMes[02][3],13)+"|"+PADL(aVlMes[02][6],14)+"|"+PADL(aVlMes[02][7],14)+"|"
		@ ++Li,003 PSAY "|    MARZO       |"+PADL(aVlMes[03][4],13)+"|" +PADL(aVlMes[03][5],13)+"|"+PADL(aVlMes[03][1],13)+"|"+PADL(aVlMes[03][2],13)+"|"+PADL(aVlMes[03][3],13)+"|"+PADL(aVlMes[03][6],14)+"|"+PADL(aVlMes[03][7],14)+"|"
		@ ++Li,003 PSAY "|    ABRIL       |"+PADL(aVlMes[04][4],13)+"|" +PADL(aVlMes[04][5],13)+"|"+PADL(aVlMes[04][1],13)+"|"+PADL(aVlMes[04][2],13)+"|"+PADL(aVlMes[04][3],13)+"|"+PADL(aVlMes[04][6],14)+"|"+PADL(aVlMes[04][7],14)+"|"
		@ ++Li,003 PSAY "|    MAYO        |"+PADL(aVlMes[05][4],13)+"|" +PADL(aVlMes[05][5],13)+"|"+PADL(aVlMes[05][1],13)+"|"+PADL(aVlMes[05][2],13)+"|"+PADL(aVlMes[05][3],13)+"|"+PADL(aVlMes[05][6],14)+"|"+PADL(aVlMes[05][7],14)+"|"
		@ ++Li,003 PSAY "|    JUNIO       |"+PADL(aVlMes[06][4],13)+"|" +PADL(aVlMes[06][5],13)+"|"+PADL(aVlMes[06][1],13)+"|"+PADL(aVlMes[06][2],13)+"|"+PADL(aVlMes[06][3],13)+"|"+PADL(aVlMes[06][6],14)+"|"+PADL(aVlMes[06][7],14)+"|"
		@ ++Li,003 PSAY "|    JULIO       |"+PADL(aVlMes[07][4],13)+"|" +PADL(aVlMes[07][5],13)+"|"+PADL(aVlMes[07][1],13)+"|"+PADL(aVlMes[07][2],13)+"|"+PADL(aVlMes[07][3],13)+"|"+PADL(aVlMes[07][6],14)+"|"+PADL(aVlMes[07][7],14)+"|"
		@ ++Li,003 PSAY "|    AGOSTO      |"+PADL(aVlMes[08][4],13)+"|" +PADL(aVlMes[08][5],13)+"|"+PADL(aVlMes[08][1],13)+"|"+PADL(aVlMes[08][2],13)+"|"+PADL(aVlMes[08][3],13)+"|"+PADL(aVlMes[08][6],14)+"|"+PADL(aVlMes[08][7],14)+"|"
		@ ++Li,003 PSAY "|    SEPTIEMBRE  |"+PADL(aVlMes[09][4],13)+"|" +PADL(aVlMes[09][5],13)+"|"+PADL(aVlMes[09][1],13)+"|"+PADL(aVlMes[09][2],13)+"|"+PADL(aVlMes[09][3],13)+"|"+PADL(aVlMes[09][6],14)+"|"+PADL(aVlMes[09][7],14)+"|"
		@ ++Li,003 PSAY "|    OCTUBRE     |"+PADL(aVlMes[10][4],13)+"|" +PADL(aVlMes[10][5],13)+"|"+PADL(aVlMes[10][1],13)+"|"+PADL(aVlMes[10][2],13)+"|"+PADL(aVlMes[10][3],13)+"|"+PADL(aVlMes[10][6],14)+"|"+PADL(aVlMes[10][7],14)+"|"
		@ ++Li,003 PSAY "|    NOVEMBRE    |"+PADL(aVlMes[11][4],13)+"|" +PADL(aVlMes[11][5],13)+"|"+PADL(aVlMes[11][1],13)+"|"+PADL(aVlMes[11][2],13)+"|"+PADL(aVlMes[11][3],13)+"|"+PADL(aVlMes[11][6],14)+"|"+PADL(aVlMes[11][7],14)+"|"
		@ ++Li,003 PSAY "|    DICIEMBRE   |"+PADL(aVlMes[12][4],13)+"|" +PADL(aVlMes[12][5],13)+"|"+PADL(aVlMes[12][1],13)+"|"+PADL(aVlMes[12][2],13)+"|"+PADL(aVlMes[12][3],13)+"|"+PADL(aVlMes[12][6],14)+"|"+PADL(aVlMes[12][7],14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",118)
		@ ++Li,003 PSAY "|    TOTAL       |"+PADL(Transform(aVlMes[13][4],TM(aVlMes[13][4],13,MsDecimais(2))),13)+"|";
		+PADL(Transform(aVlMes[13][5],TM(aVlMes[13][5],13,MsDecimais(2))),13)+"|" +PADL(Transform(aVlMes[13][1],TM(aVlMes[13][1],13,MsDecimais(2))),13)+"|";
		+PADL(Transform(aVlMes[13][2],TM(aVlMes[13][2],13,MsDecimais(2))),13)+Replicate(" ",14)+"|";
		+PADL(Transform(aVlMes[13][6],TM(aVlMes[13][6],14,MsDecimais(2))),14)+"|" +PADL(Transform(aVlMes[13][7],TM(aVlMes[13][7],14,MsDecimais(2))),14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",118)
	Else
		cDescr:= "El Empleador, Habilitado o Pagador,"+Alltrim(cEmpres)+" certifica que al Sr. "+Alltrim(cEmpreg)+" "
		cDescr+= "Rut. N° "+Transform(cRut,cPictCIC)+" en su calidad de empleado depediente,jubilado,pensionado o montepiado, segun corresponda,"
		cDescr+= "durante el ano "+cAnoRef+", se le han pagado las rentas que se indican y sobre las cuales se le practicaron las "
		cDescr+= "retenciones de impuestos que se senalan:"
		@ Li,001 PSAY PADC("CERTIFICADO N°6",205)
		Li +=2
		@ Li,001 PSAY "Empleador        : "+Alltrim(cEmpres)
		Li++
		@ Li,001 PSAY "Rut. N           : "+Alltrim(cCGC)
		Li++
		@ Li,001 PSAY "Direccion        : "+Alltrim(cEndEmp)
		Li++
		//@ Li,001 PSAY "Giro o Actividad : "+cGirAtv
		Li +=2
		@ ++Li,001 PSAY PADC("CERTIFICADO N° 6 SOBRE SUELDOS Y OTRAS RENTAS SIMILARES",205)
		Li +=1
		@ ++Li,001 PSAY PADL("Certificado N° "+cCert,205)
		Li++
		@ Li,001 PSAY PADL(Alltrim(cCidEmp)+","+Alltrim(Str(Day(Date())))+" de "+aMeses[month(date()),3]+" de "+AllTrim(cAnoTrib),205)
		Li +=1
		For nQbra:=1 To Round(Len(cDescr)/205,0)+1
			@ ++Li,001 PSAY MemoLine( cDescr,205, nQbra )
		Next
		Li +=2
		@ Li,003 PSAY REPLICATE("-",205)
		@ ++Li,003 PSAY "|                |             | COTIZACION  |   RENTA     |             |    MAYOR    |             |             |             |                           MONTOS ACTUALIZADOS                            |"
		@ ++Li,003 PSAY "|                |    SUELDO   |  PREV. DE   | IMPONIBLE   |   IMPUESTO  |RETENCION DE | RENTA TOTAL | REBAJA POR  |   FACTOR    |--------------------------------------------------------------------------|"
		@ ++Li,003 PSAY "| PERIODOS       |  JUBILACION | CARGO DEL   | AFECTA AL   |    UNICO    |    IMPTO.   |EXENTA Y/O NO|   ZONAS     |     DE      |    RENTA     |    IMPUESTO  |  MAYOR       | RENTA TOTAL  | REBAJA POR   |"
		@ ++Li,003 PSAY "|                |  O PENSION  | TRABAJADOR  | IMPUESTO    |   RETENIDO  | SOLICITADA  |   GRAVADA   |  EXTREMAS   |  ACTUALIZ.  |  AFECTA AL   |     UNICO    |RETENCION DE  |EXENTA Y/O NO |   ZONAS      |"
		@ ++Li,003 PSAY "|                |    BRUTA    | PENSIONADO  | UNICO DE    |             |ART.38 L.I.R.|             | (FRANQUICIA |             |  IMPTO. UNI  |    RETENIDO  |IMPTO. SOLIC. |   GRAVADA    |  EXTREMAS    |"
		@ ++Li,003 PSAY "|                |             |             | 2° CATEG.   |             |             |             |   D.L.889)  |             |  2° CATEG.   |              |ART.88 L.I.R. |              |(FRANQUICIA   |"
		@ ++Li,003 PSAY "|                |             |             |             |             |             |             |             |             |              |              |              |              |   D.L.889)   |"
		@ ++Li,003 PSAY "|"+REPLICATE("-",16)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",13)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"+REPLICATE("-",14)+"+"
		@ ++Li,003 PSAY "|    ENERO       |"+PADL(aVlMes[01][4],13)+"|" +PADL(aVlMes[01][5],13)+"|"+PADL(aVlMes[01][1],13)+"|"+PADL(aVlMes[01][2],13)+"|"+PADL(aVlMes[01][6],13)+"|"+PADL(aVlMes[01][7],13)+"|"+PADL(aVlMes[01][8],13)+"|"+PADL(aVlMes[01][3],13)+"|"+PADL(aVlMes[01][9],14)+"|"+PADL(aVlMes[01][10],14)+"|"+PADL(aVlMes[01][11],14)+"|"+PADL(aVlMes[01][12],14)+"|"+PADL(aVlMes[01][13],14)+"|"
		@ ++Li,003 PSAY "|    FEBRERO     |"+PADL(aVlMes[02][4],13)+"|" +PADL(aVlMes[02][5],13)+"|"+PADL(aVlMes[02][1],13)+"|"+PADL(aVlMes[02][2],13)+"|"+PADL(aVlMes[02][6],13)+"|"+PADL(aVlMes[02][7],13)+"|"+PADL(aVlMes[02][8],13)+"|"+PADL(aVlMes[02][3],13)+"|"+PADL(aVlMes[02][9],14)+"|"+PADL(aVlMes[02][10],14)+"|"+PADL(aVlMes[02][11],14)+"|"+PADL(aVlMes[02][12],14)+"|"+PADL(aVlMes[02][13],14)+"|"
		@ ++Li,003 PSAY "|    MARZO       |"+PADL(aVlMes[03][4],13)+"|" +PADL(aVlMes[03][5],13)+"|"+PADL(aVlMes[03][1],13)+"|"+PADL(aVlMes[03][2],13)+"|"+PADL(aVlMes[03][6],13)+"|"+PADL(aVlMes[03][7],13)+"|"+PADL(aVlMes[03][8],13)+"|"+PADL(aVlMes[03][3],13)+"|"+PADL(aVlMes[03][9],14)+"|"+PADL(aVlMes[03][10],14)+"|"+PADL(aVlMes[03][11],14)+"|"+PADL(aVlMes[03][12],14)+"|"+PADL(aVlMes[03][13],14)+"|"
		@ ++Li,003 PSAY "|    ABRIL       |"+PADL(aVlMes[04][4],13)+"|" +PADL(aVlMes[04][5],13)+"|"+PADL(aVlMes[04][1],13)+"|"+PADL(aVlMes[04][2],13)+"|"+PADL(aVlMes[04][6],13)+"|"+PADL(aVlMes[04][7],13)+"|"+PADL(aVlMes[04][8],13)+"|"+PADL(aVlMes[04][3],13)+"|"+PADL(aVlMes[04][9],14)+"|"+PADL(aVlMes[04][10],14)+"|"+PADL(aVlMes[04][11],14)+"|"+PADL(aVlMes[04][12],14)+"|"+PADL(aVlMes[04][13],14)+"|"
		@ ++Li,003 PSAY "|    MAYO        |"+PADL(aVlMes[05][4],13)+"|" +PADL(aVlMes[05][5],13)+"|"+PADL(aVlMes[05][1],13)+"|"+PADL(aVlMes[05][2],13)+"|"+PADL(aVlMes[05][6],13)+"|"+PADL(aVlMes[05][7],13)+"|"+PADL(aVlMes[05][8],13)+"|"+PADL(aVlMes[05][3],13)+"|"+PADL(aVlMes[05][9],14)+"|"+PADL(aVlMes[05][10],14)+"|"+PADL(aVlMes[05][11],14)+"|"+PADL(aVlMes[05][12],14)+"|"+PADL(aVlMes[05][13],14)+"|"
		@ ++Li,003 PSAY "|    JUNIO       |"+PADL(aVlMes[06][4],13)+"|" +PADL(aVlMes[06][5],13)+"|"+PADL(aVlMes[06][1],13)+"|"+PADL(aVlMes[06][2],13)+"|"+PADL(aVlMes[06][6],13)+"|"+PADL(aVlMes[06][7],13)+"|"+PADL(aVlMes[06][8],13)+"|"+PADL(aVlMes[06][3],13)+"|"+PADL(aVlMes[06][9],14)+"|"+PADL(aVlMes[06][10],14)+"|"+PADL(aVlMes[06][11],14)+"|"+PADL(aVlMes[06][12],14)+"|"+PADL(aVlMes[06][13],14)+"|"
		@ ++Li,003 PSAY "|    JULIO       |"+PADL(aVlMes[07][4],13)+"|" +PADL(aVlMes[07][5],13)+"|"+PADL(aVlMes[07][1],13)+"|"+PADL(aVlMes[07][2],13)+"|"+PADL(aVlMes[07][6],13)+"|"+PADL(aVlMes[07][7],13)+"|"+PADL(aVlMes[07][8],13)+"|"+PADL(aVlMes[07][3],13)+"|"+PADL(aVlMes[07][9],14)+"|"+PADL(aVlMes[07][10],14)+"|"+PADL(aVlMes[07][11],14)+"|"+PADL(aVlMes[07][12],14)+"|"+PADL(aVlMes[07][13],14)+"|"
		@ ++Li,003 PSAY "|    AGOSTO      |"+PADL(aVlMes[08][4],13)+"|" +PADL(aVlMes[08][5],13)+"|"+PADL(aVlMes[08][1],13)+"|"+PADL(aVlMes[08][2],13)+"|"+PADL(aVlMes[08][6],13)+"|"+PADL(aVlMes[08][7],13)+"|"+PADL(aVlMes[08][8],13)+"|"+PADL(aVlMes[08][3],13)+"|"+PADL(aVlMes[08][9],14)+"|"+PADL(aVlMes[08][10],14)+"|"+PADL(aVlMes[08][11],14)+"|"+PADL(aVlMes[08][12],14)+"|"+PADL(aVlMes[08][13],14)+"|"
		@ ++Li,003 PSAY "|    SEPTIEMBRE  |"+PADL(aVlMes[09][4],13)+"|" +PADL(aVlMes[09][5],13)+"|"+PADL(aVlMes[09][1],13)+"|"+PADL(aVlMes[09][2],13)+"|"+PADL(aVlMes[09][6],13)+"|"+PADL(aVlMes[09][7],13)+"|"+PADL(aVlMes[09][8],13)+"|"+PADL(aVlMes[09][3],13)+"|"+PADL(aVlMes[09][9],14)+"|"+PADL(aVlMes[09][10],14)+"|"+PADL(aVlMes[09][11],14)+"|"+PADL(aVlMes[09][12],14)+"|"+PADL(aVlMes[09][13],14)+"|"
		@ ++Li,003 PSAY "|    OCTUBRE     |"+PADL(aVlMes[10][4],13)+"|" +PADL(aVlMes[10][5],13)+"|"+PADL(aVlMes[10][1],13)+"|"+PADL(aVlMes[10][2],13)+"|"+PADL(aVlMes[10][6],13)+"|"+PADL(aVlMes[10][7],13)+"|"+PADL(aVlMes[10][8],13)+"|"+PADL(aVlMes[10][3],13)+"|"+PADL(aVlMes[10][9],14)+"|"+PADL(aVlMes[10][10],14)+"|"+PADL(aVlMes[10][11],14)+"|"+PADL(aVlMes[10][12],14)+"|"+PADL(aVlMes[10][13],14)+"|"
		@ ++Li,003 PSAY "|    NOVEMBRE    |"+PADL(aVlMes[11][4],13)+"|" +PADL(aVlMes[11][5],13)+"|"+PADL(aVlMes[11][1],13)+"|"+PADL(aVlMes[11][2],13)+"|"+PADL(aVlMes[11][6],13)+"|"+PADL(aVlMes[11][7],13)+"|"+PADL(aVlMes[11][8],13)+"|"+PADL(aVlMes[11][3],13)+"|"+PADL(aVlMes[11][9],14)+"|"+PADL(aVlMes[11][10],14)+"|"+PADL(aVlMes[11][11],14)+"|"+PADL(aVlMes[11][12],14)+"|"+PADL(aVlMes[11][13],14)+"|"
		@ ++Li,003 PSAY "|    DICIEMBRE   |"+PADL(aVlMes[12][4],13)+"|" +PADL(aVlMes[12][5],13)+"|"+PADL(aVlMes[12][1],13)+"|"+PADL(aVlMes[12][2],13)+"|"+PADL(aVlMes[12][6],13)+"|"+PADL(aVlMes[12][7],13)+"|"+PADL(aVlMes[12][8],13)+"|"+PADL(aVlMes[12][3],13)+"|"+PADL(aVlMes[12][9],14)+"|"+PADL(aVlMes[12][10],14)+"|"+PADL(aVlMes[12][11],14)+"|"+PADL(aVlMes[12][12],14)+"|"+PADL(aVlMes[12][13],14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",205)
		@ ++Li,003 PSAY "|    TOTAL       |"+PADL(Transform(aVlMes[13][4],TM(aVlMes[13][4],13,MsDecimais(0))),13)+"|";
		+PADL(Transform(aVlMes[13][5],TM(aVlMes[13][5],13,MsDecimais(0))),13)+"|" +PADL(Transform(aVlMes[13][1],TM(aVlMes[13][1],13,MsDecimais(0))),13)+"|";
		+PADL(Transform(aVlMes[13][2],TM(aVlMes[13][2],13,MsDecimais(0))),13)+"|" +PADL(Transform(aVlMes[13][6],TM(aVlMes[13][6],13,MsDecimais(0))),13)+"|";
		+PADL(Transform(aVlMes[13][7],TM(aVlMes[13][7],14,MsDecimais(0))),13)+"|" +PADL(Transform(aVlMes[13][8],TM(aVlMes[13][8],13,MsDecimais(0))),13);
		+Replicate(" ",14)+"|" +PADL(Transform(aVlMes[13][9],TM(aVlMes[13][9],14,MsDecimais(0))),14)+"|";
		+PADL(Transform(aVlMes[13][10],TM(aVlMes[13][10],14,MsDecimais(0))),14)+"|" +PADL(Transform(aVlMes[13][11],TM(aVlMes[13][11],14,MsDecimais(0))),14)+"|";
		+PADL(Transform(aVlMes[13][12],TM(aVlMes[13][12],14,MsDecimais(0))),14)+"|" +PADL(Transform(aVlMes[13][13],TM(aVlMes[13][13],14,MsDecimais(0))),14)+"|"
		@ ++Li,003 PSAY REPLICATE("-",205)

	Endif
	Li ++

	cDescr2:= "Se extiende el presente Certificado en cumplimiento de los dispuesto en la resolucion Ex. N°6509 del Servicio de Impuestos "
	cDescr2+= " Internos, publicada en el Diario Oficial de fecha 20 de Diciembre de 1993, y sus modificaciones posteriores."

	For nQbra:=1 To Round(Len(cDescr2)/Iif(nModelo==6,205,110),0)+1
		@ ++Li,001 PSAY MemoLine( cDescr2,Iif(nModelo==6,205,110), nQbra )
	Next
	Li ++
	@ ++Li,If( nModelo == 6, 155, 068 ) PSAY PADC( Replicate( "_", 50 ), 50 )
	@ ++Li,If( nModelo == 6, 155, 068 ) PSAY PADC( AllTrim(aInfo[3]), 50 )
	@ ++Li,If( nModelo == 6, 155, 068 ) PSAY PADC( cNomRep, 50 )
	@ ++Li,If( nModelo == 6, 155, 068 ) PSAY PADC( cRutRep, 50 )

	//	@ ++Li,001 PSAY PADL(IIF(Empty(USRFULLNAME(__CUSERID)),USRRETNAME(__CUSERID),USRFULLNAME(__CUSERID)),Iif(nModelo==6,205,110))
Else
	@ Li,058 PSAY STR0004
	@ ++Li,058 PSAY REPLICATE("=",20)
	Li +=3
	@ ++Li,003 PSAY Desc_Fil + STR0005 + SUBSTR(SRA->RA_NOME,1,43)
	@ Li,093 PSAY  STR0012
	@ Li,098 PSAY  Desc_CGC Picture cPictCIC
	@ ++Li,003 PSAY STR0013 + cAnoRef + STR0014
	@ ++Li,003 PSAY STR0015
	Li +=2
	@ Li,003 PSAY REPLICATE("-",126)
	@ ++Li,003 PSAY "| PERIODOS          |       MONTO BRUTO         |    RETENCIONES     |   FACTOR   |   BRUTO REAJUSTADO   |  RET. REAJUSTADO  | "
	@ ++Li,003 PSAY "|"+REPLICATE("-",19)+"+"+REPLICATE("-",27)+"+"+REPLICATE("-",20)+"+"
	@ Li,073 PSAY REPLICATE("-",12)+"+"+REPLICATE("-",22)+"+"+REPLICATE("-",19)+"|"
	@ ++Li,003 PSAY "|  1 ENERO"
	@ Li,023 PSAY "|" +PADL(aVlMes[1][1],27)+"|" +PADL(aVlMes[1][2],20)+"|"+PADL(aVlMes[1][3],12)+"|"+PADL(aVlMes[1][4],22)+"|"+PADL(aVlMes[1][5],19)+"|"
	@ ++Li,003 PSAY "|  2 FEBRERO"
	@ Li,023 PSAY "|" +PADL(aVlMes[2][1],27)+"|" +PADL(aVlMes[2][2],20)+"|"+PADL(aVlMes[2][3],12)+"|"+PADL(aVlMes[2][4],22)+"|"+PADL(aVlMes[2][5],19)+"|"
	@ ++Li,003 PSAY "|  3 MARZO"
	@ Li,023 PSAY "|" +PADL(aVlMes[3][1],27)+"|" +PADL(aVlMes[3][2],20)+"|"+PADL(aVlMes[3][3],12)+"|"+PADL(aVlMes[3][4],22)+"|"+PADL(aVlMes[3][5],19)+"|"
	@ ++Li,003 PSAY "|  4 ABRIL"
	@ Li,023 PSAY "|" +PADL(aVlMes[4][1],27)+"|" +PADL(aVlMes[4][2],20)+"|"+PADL(aVlMes[4][3],12)+"|"+PADL(aVlMes[4][4],22)+"|"+PADL(aVlMes[4][5],19)+"|"
	@ ++Li,003 PSAY "|  5 MAYO"
	@ Li,023 PSAY "|" +PADL(aVlMes[5][1],27)+"|" +PADL(aVlMes[5][2],20)+"|"+PADL(aVlMes[5][3],12)+"|"+PADL(aVlMes[5][4],22)+"|"+PADL(aVlMes[5][5],19)+"|"
	@ ++Li,003 PSAY "|  6 JUNIO"
	@ Li,023 PSAY "|" +PADL(aVlMes[6][1],27)+"|" +PADL(aVlMes[6][2],20)+"|"+PADL(aVlMes[6][3],12)+"|"+PADL(aVlMes[6][4],22)+"|"+PADL(aVlMes[6][5],19)+"|"
	@ ++Li,003 PSAY "|  7 JULIO"
	@ Li,023 PSAY "|" +PADL(aVlMes[7][1],27)+"|" +PADL(aVlMes[7][2],20)+"|"+PADL(aVlMes[7][3],12)+"|"+PADL(aVlMes[7][4],22)+"|"+PADL(aVlMes[7][5],19)+"|"
	@ ++Li,003 PSAY "|  8 AGOSTO"
	@ Li,023 PSAY "|" +PADL(aVlMes[8][1],27)+"|" +PADL(aVlMes[8][2],20)+"|"+PADL(aVlMes[8][3],12)+"|"+PADL(aVlMes[8][4],22)+"|"+PADL(aVlMes[8][5],19)+"|"
	@ ++Li,003 PSAY "|  9 FEBRERO"
	@ Li,023 PSAY "|" +PADL(aVlMes[9][1],27)+"|" +PADL(aVlMes[9][2],20)+"|"+PADL(aVlMes[9][3],12)+"|"+PADL(aVlMes[9][4],22)+"|"+PADL(aVlMes[9][5],19)+"|"
	@ ++Li,003 PSAY "| 10 SEPTIEMBRE"
	@ Li,023 PSAY "|" +PADL(aVlMes[10][1],27)+"|" +PADL(aVlMes[10][2],20)+"|"+PADL(aVlMes[10][3],12)+"|"+PADL(aVlMes[10][4],22)+"|"+PADL(aVlMes[10][5],19)+"|"
	@ ++Li,003 PSAY "| 11 OCTUBRE"
	@ Li,023 PSAY "|" +PADL(aVlMes[11][1],27)+"|" +PADL(aVlMes[11][2],20)+"|"+PADL(aVlMes[11][3],12)+"|"+PADL(aVlMes[11][4],22)+"|"+PADL(aVlMes[11][5],19)+"|"
	@ ++Li,003 PSAY "| 12 DICIEMBRE"
	@ Li,023 PSAY "|" +PADL(aVlMes[12][1],27)+"|" +PADL(aVlMes[12][2],20)+"|"+PADL(aVlMes[12][3],12)+"|"+PADL(aVlMes[12][4],22)+"|"+PADL(aVlMes[12][5],19)+"|"
	@ ++Li,003 PSAY REPLICATE("-",126)

Endif
Impr("","P")
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GPM037GetFile ºAutor  ³Marcos Kato       º Data ³  05/11/08  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Caminho da Geracao do Arquivo TXT                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Chile                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GPM037GetFile()
Local cArq
mvRet := Alltrim(ReadVar())
cArq := Space(60)

cTipo := STR0015+".txt"+")   | *."+"txt"+"  " // "Arquivos Ficheiro Certificado de Renda (*.txt)   | *.txt  "
cGetFile := cGetFile("","Selecione o Diretorio",0,,.F.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_RETDIRECTORY) //"Selecione o Diretorio"
If Empty(cGetFile)
	Return(.F.)
Endif
&mvRet := cGetFile
Return(.T.)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³GPM037GetFile ºAutor  ³Marcos Kato       º Data ³  05/11/08  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio Informativo da Declaracao de Renda Anual           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Chile                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DARenda(aDeclar)

Local cAnoMesAf := ""
Local cLinha 	:= ""
Local cCGC		:= Transform( SM0->M0_CGC, "@R ##.###.###-#" )
Local cPictCIC	:= PesqPict('SRA','RA_CIC')
Local aAfast	:= {}
Local nSecB		:= 1
Local nMeses	:= 0
Local nAnoRef	:= 0
Local nTotNeta	:= nTotImp := nTotMayor := nTotExen := nTotReba := nTotImpRlq := nTotGer := 0
Local nTotANeta	:= nTotAImp := nTotAMayor := nTotAExen := nTotAReba := nTotAGer := 0
Local nMesArq	:= 0
Local aLinMes	:= { "cLinJan", "cLinFev", "cLinMar", "cLinAbr", "cLinMai", "cLinJun", "cLinJul", "cLinAgo", "cLinSet", "cLinOut", "cLinNov", "cLinDez" }

nAnoRef:= Val(cAnoRef) + 1
cAnoRef:= Str(nAnoRef)
Li := 1
cTitRen:="DECLARACION JURADA ANUAL SOBRE RENTA DEL ART. 42 N° 1 (SUELDOS), OTROS COMPONENTES DE LA "
cTitRen+="REMUNERACION Y RETENCIONES DEL IMPUESTO UNICO DA SEGUNDA CATEGORIA DE LA LEY DE LA RENTA"
SET DEVICE TO PRINT
@ Li,001 PSAY AVALIMP(nLimite)
Li++
@ Li,001 PSAY PADC(cTitRen,220)
Li +=2
@ Li,005 PSAY "ANO TRIBUTARIO "+Alltrim(cAnoRef)
Li +=2
@   Li,005 PSAY REPLICATE("-",89)
@ ++Li,005 PSAY "| ROL UNICO TRIBUTARIO     |                    NOMBRE O RAZON SOCIAL                   |"+ Space(60) +"--------------------
@ ++Li,005 PSAY "|--------------------------|------------------------------------------------------------|"+ Space(53) +"Folio: |"+PADC(Left(Alltrim(cFolio),14),18)+"|
@ ++Li,005 PSAY "|"+PADR(cCGC,26)+"|"+PADR(SM0->M0_NOMECOM,60)+"|"+Space(60)+"--------------------
@ ++Li,005 PSAY "|--------------------------------------------------|------------------------------------|
@ ++Li,005 PSAY "|          DOMICILIO POSTAL                        |             COMUNA                 |
@ ++Li,005 PSAY "|--------------------------------------------------|------------------------------------|
@ ++Li,005 PSAY "|"+PADR(IIF(EMPTY(SM0->M0_ENDCOB),SM0->M0_ENDENT,SM0->M0_ENDCOB),50)+"|"+PADR(IIF(EMPTY(SM0->M0_CIDCOB),SM0->M0_CIDENT,SM0->M0_CIDCOB),36)+"|
@ ++Li,005 PSAY "|--------------------------------------------------|------------------------------------|
@ ++Li,005 PSAY "|    CORREIO ELECTRONICO                 |        TELEFONO         |        FAX         |
@ ++Li,005 PSAY "|----------------------------------------|-------------------------|--------------------|
@ ++Li,005 PSAY "|"+PADR(cEmail,40)+"|"+PADC(SM0->M0_TEL,25)+"|"+PADC(SM0->M0_FAX,20)+"|


@ ++Li,005 PSAY REPLICATE("-",89)
Li++
@ ++Li,005 PSAY REPLICATE("-",198)
@ ++Li,005 PSAY "|  N°  | RUT DE LA PERSONA  |                                      MONTOS ANUALES ACTUALIZADOS                                       |            PERIODO AL CUAL CORRESPONDEN LAS RENTAS            |
@ ++Li,005 PSAY "|      |      RENTA         |--------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
@ ++Li,005 PSAY "|      |   A QUIEN SE LA    | RENDA TOTAL NETA   |   IMPUESTO UNICO   |   MAYOR RETENCION  | RENTA TOTAL EXENTA | REBAJA POR ZONAS   |ENE|FEB|MAR|ABR|MAY|JUN|JUL|AGO|SEP|OCT|NOV|DIC|N° CERTIFICADO |
@ ++Li,005 PSAY "|      |                    |      PAGADA        |      RETENIDO      |      SOLICITADA    |   Y/O NO GRAVADA   |       EXTREMAS     |   |   |   |   |   |   |   |   |   |   |   |   |               |
@ ++Li,005 PSAY "|" + REPLICATE("-",196) + "|

For nSecB:=1 To Len(aDeclar)
	If li>=60
		@ ++Li,005 PSAY REPLICATE("-",198)
		Li:=3
		@ ++Li,005 PSAY REPLICATE("-",198)
		@ ++Li,005 PSAY "|  N°  | RUT DE LA PERSONA  |                                      MONTOS ANUALES ACTUALIZADOS                                       |            PERIODO AL CUAL CORRESPONDEN LAS RENTAS            |
		@ ++Li,005 PSAY "|      |      RENTA         |--------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
		@ ++Li,005 PSAY "|      |   A QUIEN SE LA    | RENDA TOTAL NETA   |   IMPUESTO UNICO   |   MAYOR RETENCION  | RENTA TOTAL EXENTA | REBAJA POR ZONAS   |ENE|FEB|MAR|ABR|MAY|JUN|JUL|AGO|SEP|OCT|NOV|DIC|N° CERTIFICADO |
		@ ++Li,005 PSAY "|      |                    |      PAGADA        |      RETENIDO      |      SOLICITADA    |   Y/O NO GRAVADA   |       EXTREMAS     |   |   |   |   |   |   |   |   |   |   |   |   |               |
		@ ++Li,005 PSAY "|" + REPLICATE("-",196) + "|
	Endif

	For nMeses := 7 To 18
	Col:= 005

		nMesArq		:= nMeses - 6
		cAnoMesAf	:= cAnoRef + Alltrim( StrZero( nMeses - 6, 2 ) )

	 	If aDeclar[nSecB][nMeses]
			&( aLinMes[nMesArq] ) := aDeclar[nSecB][27][nMesArq]
		Endif
	Next

	// MONTOS ANUALES ACTUALIZADOS
   	@ ++Li,005 PSAY "|"+PADL(Alltrim(Str(nSecB,6)),6)+"|"+PADC(Transform(aDeclar[nSecB][1],cPictCIC),20)+"|"+PADL(Transform(aDeclar[nSecB][20],"@E 999,999,999"),20)+"|"+;
	PADL(Transform(aDeclar[nSecB][21]+aDeclar[nSecB][26],"@E 999,999,999"),20)+"|"+PADL(Transform(aDeclar[nSecB][22],"@E 999,999,999"),20)+"|"+;
	PADL(Transform(aDeclar[nSecB][23],"@E 999,999,999"),20)+"|"+PADL(Transform(aDeclar[nSecB][24],"@E 999,999,999"),20)+"|"+;
	PADC(Iif(aDeclar[nSecB][7] ,cLinJan,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][8] ,cLinFev,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][9] ,cLinMar,"-"),3)+"|"+;
	PADC(Iif(aDeclar[nSecB][10],cLinAbr,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][11],cLinMai,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][12],cLinJun,"-"),3)+"|"+;
	PADC(Iif(aDeclar[nSecB][13],cLinJul,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][14],cLinAgo,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][15],cLinSet,"-"),3)+"|"+;
	PADC(Iif(aDeclar[nSecB][16],cLinOut,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][17],cLinNov,"-"),3)+"|"+PADC(Iif(aDeclar[nSecB][18],cLinDez,"-"),3)+"|"+;
	PADC(aDeclar[nSecB][19],15)+"|"

	nTotNeta	+= aDeclar[nSecB][2]
	nTotImp		+= aDeclar[nSecB][3]
	nTotMayor	+= aDeclar[nSecB][4]
	nTotExen	+= aDeclar[nSecB][5]
	nTotReba	+= aDeclar[nSecB][6]
	nTotImpRlq	+= aDeclar[nSecB][25]
	nTotGer		+= aDeclar[nSecB][2] + aDeclar[nSecB][3] + aDeclar[nSecB][4] + aDeclar[nSecB][5] + aDeclar[nSecB][6] + aDeclar[nSecB][25]

	nTotANeta	+= aDeclar[nSecB][20]
	nTotAImp	+= aDeclar[nSecB][21] + aDeclar[nSecB][26]
	nTotAMayor	+= aDeclar[nSecB][22]
	nTotAExen	+= aDeclar[nSecB][23]
	nTotAReba	+= aDeclar[nSecB][24]
	nTotAGer	+= aDeclar[nSecB][20] + aDeclar[nSecB][21] + aDeclar[nSecB][22] + aDeclar[nSecB][23] + aDeclar[nSecB][24]
Next

@ ++Li,005 PSAY REPLICATE("-",198)
Li++

// TOTAL MONTOS ANUALES SIN ACTUALIZAR
@ ++Li,005 PSAY REPLICATE("-",141)
@ ++Li,005 PSAY "|                                      TOTAL MONTOS ANUALES SIN ACTUALIZAR                                           |                      |
@ ++Li,005 PSAY "|--------------------------------------------------------------------------------------------------------------------|  TOTAL REMUNERACIÓN  |
@ ++Li,005 PSAY "|                         |             IMPUESTO UNICO RETENIDO                |                    |                |    IMPONIBLE PARA    |
@ ++Li,005 PSAY "| RENTA TOTAL NETA PAGADA |----------------------------------------------------|                    |   REBAJA POR   |        EFECTOS       |
@ ++Li,005 PSAY "|  (Art.42 Nº1,Ley de la  | POR RENTA TOTAL NETA |  POR RENTAS ACCESORIAS Y/O  | RENTA TOTAL EXENTA | ZONAS EXTREMAS |    PREVISIONALES     |
@ ++Li,005 PSAY "|          Renta)         |PAGADA DURANTE EL AÑO | COMPLEMENTARIA PAGADA ENTRE |   Y/O NO GRAVADA   |  (FRANQUICIA   | ACTUALIZADA A TODOS  |
@ ++Li,005 PSAY "|                         |                      |      ENE-ABR.AÑO SGTE.      |                    |    D.L.889)    |   LOS TRABAJADORES   |
@ ++Li,005 PSAY "|" + REPLICATE("-",139) + "|
@ ++Li,005 PSAY "|"+PADL(Transform(nTotNeta,"@E 99,999,999,999"),25)+"|"+PADL(Transform(nTotImp,"@E 99,999,999,999"),22)+"|"+PADL(Transform(nTotImpRlq,"@E 99,999,999,999"),29)+"|"+;
PADL(Transform(nTotExen,"@E 99,999,999,999"),20)+"|"+PADL(Transform(nTotReba,"@E 99,999,999,999"),16)+"|"+PADL(Transform(nTotGer,"@E 99,999,999,999"),22)+"|"

@ ++Li,005 PSAY REPLICATE("-",141)

// CUADRO RESUMEN FINAL DE LA DECLARACION
Li++
@ ++Li,010 PSAY REPLICATE("-",125)
@ ++Li,010 PSAY "|                                            CUADRO RESUMEN FINAL DE LA DECLARACION                                         |
@ ++Li,010 PSAY "|" + REPLICATE("-",123) + "|
@ ++Li,010 PSAY "|                                  TOTAL MONTOS ANUALES ACTUALIZADOS                                     |                  |
@ ++Li,010 PSAY "|--------------------------------------------------------------------------------------------------------|  TOTAL DE CASOS  |
@ ++Li,010 PSAY "|  RENDA TOTAL NETA  |      IMPUESTO      |  MAYOR RETENCIÓN   |    RENTA TOTAL     |  REBAJA POR ZONAS  |     INFORMADOS   |
@ ++Li,010 PSAY "| PAGADA(Art.42 Nº1, |        UNICO       |     SOLICITADA     |   EXENTA Y/O NO    |      EXTREMAS      |                  |
@ ++Li,010 PSAY "|  Ley de la Renta)  |      RETENIDO      |   (Art.88 L.I.R)   |      GRAVADA       |(FRANQUICIA D.L.889)|                  |
@ ++Li,010 PSAY "|" + REPLICATE("-",123) + "|
@ ++Li,010 PSAY "|"+PADC(Transform(nTotANeta,"@E 99,999,999,999"),20)+"|"+PADL(Transform(nTotAImp,"@E 99,999,999,999"),20)+"|"+;
PADL(Transform(nTotAMayor,"@E 99,999,999,999"),20)+"|"+PADL(Transform(nTotAExen,"@E 99,999,999,999"),20)+"|"+;
PADL(Transform(nTotAReba,"@E 99,999,999,999"),20)+"|"+PADL(Transform((nSecB-1),"@! 99,999,999,999"),18)+"|"
@ ++Li,010 PSAY REPLICATE("-",125)
@ ++Li,005 PSAY "DECLARO BAJO JURAMENTO QUE LOS DATOS CONTENIDOS EN EL PRESENTE DOCUMENTO SON LA EXPRESION FIEL DE LA VERDAD, POR LO QUE ASUMO LA RESPONSABILIDAD CORRESPONDIENTE

Li++
@ ++Li,005 PSAY REPLICATE("-",31)
@ ++Li,005 PSAY "|" + PADC( "RUT REPRESENTANTE LEGAL", 29 ) + "|"
@ ++Li,005 PSAY "|" + REPLICATE("-",29) + "|
@ ++Li,005 PSAY "|" + PADC( cRutRep, 29 ) + "|"
@ ++Li,005 PSAY REPLICATE("-",31)

Return
