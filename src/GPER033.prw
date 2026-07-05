/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "GPER033.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER033  ³ Autor ³ Bruno Sobieski        ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pagamento de AFPs CHILE                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER033(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³--------³------³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³16/11/2009³00000028005/2009³Adaptação gestão corporativa               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER033()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString:="SRA"        // alias do arquivo principal (Base)
Local aOrd   := {STR0001,STR0002,STR0003} //"Matricula"###"C.Custo"###"Nome"
Local cDesc1 := STR0006		//"Emiss„o de Recibos de Pagamento."
Local cDesc2 := STR0007		//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3 := STR0008		//"usu rio."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0009, 1,STR0010, 2, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog :="GPER033"
Private nLastKey := 0
Private cPerg    :="GPR033"
Private nPagina  :=	0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Li     := 80
Private Titulo := STR0011		
Private cAFP, dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef,nJuros,nReajus

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("GPR033",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER033"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,"P")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Ordem do Relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variaveis utilizadas para parametros ³
  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
  ³ mv_par01 -> AFP                ?     ³
  ³ mv_par02 -> Data de Referˆncia ?     ³
  ³ mv_par03 -> Filial De          ?     ³
  ³ mv_par04 -> Filial At‚         ?     ³
  ³ mv_par05 -> Centro de Custo De ?     ³
  ³ mv_par06 -> Centro de Custo At‚?     ³
  ³ mv_par07 -> Matricula De       ?     ³
  ³ mv_par08 -> Matricula At‚      ?     ³
  ³ mv_par09 -> Nome De            ?     ³
  ³ mv_par10 -> Nome At‚           ?     ³
  ³ mv_par11 -> Chapa De           ?     ³
  ³ mv_par12 -> Chapa At‚          ?     ³
  ³ mv_par13 -> Situa‡”es a Imp.   ?     ³
  ³ mv_par14 -> Categorias a Imp.  ?     ³
  ³ mv_par15 -> Reajuste                 ³
  ³ mv_par16 -> Intereses                ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cAFP       := mv_par01 //Codigo de la AFP a ser listada    
dDataRef   := mv_par02 //Data de Referencia para a impressao
cFilDe     := mv_par03 //Filial De
cFilAte    := mv_par04 //Filial Ate
cCcDe      := mv_par05 //Centro de Custo De
cCcAte     := mv_par06 //Centro de Custo Ate
cMatDe     := mv_par07 //Matricula Des
cMatAte    := mv_par08 //Matricula Ate
cNomDe     := mv_par09 //Nome De
cNomAte    := mv_par10 //Nome Ate
ChapaDe    := mv_par11 //Chapa De
ChapaAte   := mv_par12 //Chapa Ate
cSituacao  := mv_par13 //Situacoes a Imprimir
cCategoria := mv_par14 //Categorias a Imprimir
nReajus    := mv_par15 //Situacoes a Imprimir
nJuros     := mv_par16 //Categorias a Imprimir

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

If LastKey() = 27 .Or. nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
   Return
Endif

ProcGpe({|lEnd| R033Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio
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
±±³Fun‡…o    ³ R033IMP  ³ Autor ³ Bruno Sobieski        ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao da planilha de pagamento de AFP ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R033Imp(lEnd,WnRel,cString,cMesAnoRef)                	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R033Imp(lEnd,WnRel,cString,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cMesArqRef  := cMesAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER033","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER033","SRC","2") + "}")
Local aInfo	
Local aTotPag     := {0,0,0,0,0}
Local aTotAcum    := {0,0,0,0,0}
Local cInicio,cFim
Local nOrdem := aReturn[8]
Local cFilialAnt
Local	cSitFunc,dDtPesqAf
Local nValBase,nValObrig,nValCot,nValVol             
Local nNumero   := 0

Private cAliasMov := ""
Private cNomeAFP,	nAlqObrig, cCodObrig1, cCodObrig2, cCodVol, cCodCot, cCodBase,	nLimUM
Private	Desc_Fil, Desc_End,	Desc_CGC

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

SendPrtInfo("M",15)
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

If FPHIST82(xFilial("SRX") , "62" , MesAno(dDataRef)+cAFP ).Or. FPHIST82(xFilial("SRX") , "62" , "      "+cAFP  )
	cNomeAFP		:= SubStr( SRX->RX_TXT ,  1 , 22) 
	nAlqObrig 	:= Val( SubStr( SRX->RX_TXT ,  22 , 5 ) )+Val( SubStr( SRX->RX_TXT ,  27 , 5 ) )
	cCodObrig1 	:= SubStr( SRX->RX_TXT ,  32 , 3 ) 
	cCodObrig2	:= SubStr( SRX->RX_TXT ,  35 , 3 ) 
	cCodVol		:= SubStr( SRX->RX_TXT ,  38 , 3 ) 
	cCodCot	 	:= SubStr( SRX->RX_TXT ,  41 , 3 ) 
	cCodBase		:= SubStr( SRX->RX_TXT ,  44 , 3 ) 
	nLimUM		:= Val( SubStr( SRX->RX_TXT ,  47 , 6 ) )
Else
	Help("",1,"NOVALIDO","","Tabla de AFP no encontrada",1)
	Return	.F.
Endif

dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GPProcRegua(RecCount())// Total de elementos da regua

cFilialAnt := Space(FWGETTAMFILIAL)

While SRA->( !Eof() .And. &cInicio <= cFim )
	
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
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Data Demissao         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Left(cMesAnoRef,2) + "/" + Right(cMesAnoRef,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste situacao e categoria dos funcionarios			     |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif
	If cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) # Mesano(dDataRef)
		dbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste controle de acessos e filiais validas				 |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
  	   dbSkip()
      Loop
  	EndIf
    
	If SRA->RA_Filial # cFilialAnt
		If ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		Desc_Fil := aInfo[3]
		Desc_End := aInfo[4]                // Dados da Filial
		Desc_CGC := aInfo[8]
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	
	dbSelectArea("SRC")
	dbSetOrder(3)
	//Pega o valor da base
	nValBase	:=	0
	If dbSeek(SRA->RA_FILIAL + cCodBase	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodBase+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nValBase	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif
	//Pega o valor obrigatorio
	nValObrig	:=	0
	If dbSeek(SRA->RA_FILIAL + cCodObrig1	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodObrig1+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nValObrig	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif

	If dbSeek(SRA->RA_FILIAL + cCodObrig2	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodObrig2+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nValObrig	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif

	//Pega o valor da cotizacion voluntaria
	nValCot	:=	0
	If dbSeek(SRA->RA_FILIAL + cCodCot	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodCot+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nValCot	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif
	//Pega o valor do ahorro voluntario
	nValVol	:=	0
	If dbSeek(SRA->RA_FILIAL + cCodVol	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodVol+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nValVol	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif
	If nValVol+nValCot+nValObrig+nValBase > 0
		If Li > 55
			fCabec(@aTotPag,@aTotAcum,.F.)
		Endif	
		nNumero   := nNumero + 1
		@Li,000 PSAY StrZero(nNumero,4)    //SRA->RA_MAT
		@Li,007 PSAY SRA->RA_CIC picture PesqPict('SRA','RA_CIC')
		@Li,022 PSAY Substr(SRA->RA_NOME,1,25)
		@Li,048 PSAY nValBase 	Picture TM(nValBase,12,MsDecimais(1))
		@Li,061 PSAY nValObrig 	Picture TM(nValObrig,12,MsDecimais(1))
		@Li,074 PSAY nValCot 	Picture TM(nValCot,12,MsDecimais(1))
		@Li,087 PSAY nValVol 	Picture TM(nValVol,12,MsDecimais(1))
		If MesAno(SRA->RA_ADMISSA) == MesAno(dDataRef)
			@Li,100 PSAY SRA->RA_ADMISSA
   	Endif
		If MESANO(SRA->RA_DEMISSA) == MesAno(dDataRef)
			@Li,111 PSAY SRA->RA_DEMISSA
   	Endif
		//Falta uma coluna qu o Don Jaime falou que não seria necessaria
		aTotPag[1]	+=	nValBase
		aTotPag[2]	+=	nValObrig
		aTotPag[3]	+=	nValCot
		aTotPag[4]	+=	nValVol
		aTotPag[5]++
		Li++			
	Endif	
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo
//Impirmir total da ultima pagina e GERAL.
If aTotPag[1]+aTotPag[2]+aTotPag[3]+aTotPag[4] > 0
	fCabec(@aTotPag,@aTotAcum,.T.)
	fPrintCapa(aTotAcum)
Endif	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1


dbSelectArea("SRA")
DbClearFilter()
RetIndex("SRA")

	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec    ³ Autor ³ Bruno Sobieski        ³ Data ³ 22.02.02 ³±±
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
Static Function fCabec(aTotPag,aTotAcum,lLast)   // Cabecalho

nPagina++

If nPagina > 1 .Or. lLast
	//Imprimir total por pagina...
	@ ++Li,00 PSAY __PrtThinLine()
	@ ++Li,000 PSAY STR0019
	@ ++Li,040 PSAY STR0022
	@	Li ,080 PSAY aTotPag[1] PICTURE TM(aTotPag[1],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0023
	@	Li ,080 PSAY aTotPag[2] PICTURE TM(aTotPag[2],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0024
	@	Li ,080 PSAY aTotPag[3] PICTURE TM(aTotPag[3],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0025
	@	Li ,080 PSAY aTotPag[4] PICTURE TM(aTotPag[4],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0026
	@	Li ,080 PSAY aTotPag[2]+aTotPag[3]+aTotPag[4] PICTURE TM(aTotPag[2]+aTotPag[3]+aTotPag[4],16,MsDecimais(1))
	@ ++Li,100 PSAY STR0027
	@	Li ,120 PSAY aTotPag[5] PICTURE "@R 999,999"
	aTotAcum[1]	+=	aTotPag[1]
	aTotAcum[2]	+=	aTotPag[2]
	aTotAcum[3]	+=	aTotPag[3]
	aTotAcum[4]	+=	aTotPag[4]
	aTotAcum[5]	+=	aTotPag[5]		
	aFill(aTotPag,0)
Endif
If !lLast .Or. Li > 60
	Li	:= 0
	@ Li,000 PSAY STR0005 + cNomeAFP
	@ ++Li,030 PSAY STR0014

	@ ++Li,110 PSAY STR0012+StrZero(nPagina,6)

	@ ++Li,000 PSAY STR0015  
	@ Li,Len(STR0015)+1  PSAY Desc_CGC picture PesqPict('SRA','RA_CIC')
	@ Li,035 PSAY STR0016  + Desc_Fil
	@ Li,110 PSAY STR0013+MesExtenso(MONTH(dDataRef))+"/"+STR(YEAR(dDataRef),4)

	@ ++Li,000 PSAY __PrtThinLine()
	@ ++Li,065 PSAY TransForm(nAlqObrig,'99.99') + ' %'

	@ ++Li,048 PSAY STR0017

	@ ++Li,000 PSAY STR0018

	@ ++Li,000 PSAY __PrtThinLine()
	Li++
Endif

If lLast
	@ ++Li,00 PSAY __PrtThinLine()
	@ ++Li,000 PSAY STR0020
	@ ++Li,040 PSAY STR0022
	@	Li ,080 PSAY aTotAcum[1] PICTURE TM(aTotAcum[1],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0023
	@	Li ,080 PSAY aTotAcum[2] PICTURE TM(aTotAcum[2],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0024
	@	Li ,080 PSAY aTotAcum[3] PICTURE TM(aTotAcum[3],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0025
	@	Li ,080 PSAY aTotAcum[4] PICTURE TM(aTotAcum[4],16,MsDecimais(1))
	@ ++Li,040 PSAY STR0026
	@	Li ,080 PSAY aTotAcum[2]+aTotAcum[3]+aTotAcum[4] PICTURE TM(aTotAcum[2]+aTotAcum[3]+aTotAcum[4],16,MsDecimais(1))
	@ ++Li,100 PSAY STR0027
	@	Li ,120 PSAY aTotAcum[5] PICTURE '@R 999,999'
Endif
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fPrintCapaºAutor  ³Bruno Sobieski      ºFecha ³  02/26/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime a capada planilha de AFP                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fPrintCapa(aTotAcum)
Local aTot
Local cJuros	:=	TransForm(nJuros,TM(nJuros,11,MsDecimais(1)))
Local cReajus  :=	TransForm(nReajus,TM(nReajus,11,MsDecimais(1)))
Local cNomRep,cRutRep,dCamRep    
Local aInfo	

If FPHIST82( xFilial("SRX") , "99" )
	cNomRep := SubStr ( SRX->RX_TXT ,  01 , 30 ) 
	cRutRep := SubStr ( SRX->RX_TXT ,  31 , 14 ) 
	dCamRep := SubStr ( SRX->RX_TXT ,  45 , 8 ) 
	cCodAct := SubStr ( SRX->RX_TXT ,  53 , 6 ) 
Else
	Return
Endif

fInfo(@aInfo,cFilAnt)

aTot	:=	{TransForm(aTotAcum[1],TM(aTotAcum[1],11,MsDecimais(1))),;
			 TransForm(aTotAcum[2],TM(aTotAcum[2],09,MsDecimais(1))),;
			 TransForm(aTotAcum[3],TM(aTotAcum[3],09,MsDecimais(1))),;
			 TransForm(aTotAcum[4],TM(aTotAcum[4],09,MsDecimais(1))),;
			 TransForm(aTotAcum[2]+aTotAcum[3]+aTotAcum[4],TM(aTotAcum[2]+aTotAcum[3]+aTotAcum[4],12,MsDecimais(1))),;
			 TransForm(aTotAcum[2]+aTotAcum[3]+aTotAcum[4]+nJuros+nReajus,TM(aTotAcum[2]+aTotAcum[3]+aTotAcum[4]+nJuros+nReajus,12,MsDecimais(1)))}
Li	:= 0
@ Li,000 PSAY STR0005 + cNomeAFP

@ ++Li,110 PSAY STR0012+'000001'

@ ++Li,030 PSAY STR0028
Li++

@ ++Li,045 PSAY STR0029 + aInfo[05]

@ ++Li,110 PSAY STR0013+MesExtenso(MONTH(dDataRef))+"/"+STR(YEAR(dDataRef),4)

@ ++li,000 PSAY 'SECCION I.-IDENTIFICACION DEL EMPLEADOR'

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'RAZON SOCIAL : '+ aInfo[3]
@ Li,070	PSAY 'R.U.T. : '
@ Li,080 PSAY aInfo[8] Picture Pesqpict('SRA','RA_CIC')
@ Li,110 PSAY 'COD. ACTIV.: ' + cCodAct

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'DIRECCION : ' + Substr(Alltrim(aInfo[4]) +' '+ Alltrim(aInfo[14]),1,48)
@ Li,060 PSAY 'COMUNA : ' + Substr(aInfo[13],1,25)
@ Li,100 PSAY 'TELEFONO : ' + aInfo[10]

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY Substr('NOMBRE REPRESENTANTE LEGAL : ' + cNomRep,1,61)
@   Li,062 PSAY 'R.U.T. REP. LEGAL : ' 
@   Li,083 PSAY cRutRep Picture Pesqpict('SRA','RA_CIC')
@   Li,100 PSAY 'CAMBIOS EN REP. LEGAL : ' + dCamRep

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'SECCION II.- DETALLE DE COTIZA. Y DEPOSITOS VOLUNT.| REMUN IMPON |    FONDOS DE PENSIONES       |MOV. EN LOS REGISTROS DEL PERSONAL |' 
@ ++Li,000 PSAY '___________________________________________________|             | CUENTA  DE  CAPITALIZACION   |____________________________________'
@ ++Li,000 PSAY '|1|N.S.|2|R.U.T. |3|APELLIDO PATERNO MATERNO NOMBRE|    $        | COTIZAC. |COTIZAC. |CUENTA DE|COD |FECHA INI |FECHA TER |RUT ENT.|'
@ ++Li,000 PSAY '                                                                 | OBLIGA.|5|VOLUNT.|6|AHORRO |7|    |DD/MM/AA  |DD/MM/AA  |PAGADORA|'
@ ++Li,000 PSAY '_________________________________________________________________|__________|_________|_________|____|__________|__________|________|'
Li++

@ ++Li,025 PSAY 'S E G U N  D E T A L L E '
@	Li ,053 PSAY aTot[1]
@	Li ,066 PSAY aTot[2]
@	Li ,077 PSAY aTot[3]
@	Li ,087 PSAY aTot[4]
Li++

@ ++Li,000 PSAY 'SECCION III.- RESUMEN DE COTIZACIONES                                                 SECCION IV.- ANTECEDENTES GENERALES' 

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY '                                                                                 | TIPO DE INGRESO IMPONIBLE'

@ ++Li,000 PSAY '_________________________________________________________________________________| REMUN.DEL MES |XX||GRATIFICACIONES|  |'
//                         1         2         3         4         5         6         7         8         9        10         11        12
//               012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
@ ++Li,000 PSAY 'SUBSECCION III.- 1 FONDO DE PENSIONES          | SUBSECCION III.- 2 A.F.P.       |                   |'
@ ++Li,000 PSAY '_______________________________________________|_________________________________| PERIODO MES ANO   |  PERIODO DESDE     HASTA'
@ ++Li,000 PSAY 'CONCEPTO                COD.   VALORES $       |   DETALLE               VALOR $ |          '+STRZERO(MONTH(dDataRef),2)+'/'+STR(Year(dDataRef),4)+'  |            /  /      /  /    '       
@ ++Li,000 PSAY '_______________________________________________|_________________________________| TOTAL REMUNERAC.  |  TOTAL GRATIFICA'           
@ ++Li,000 PSAY 'COTIZACION OBLIGATORIA  01'+PADL(aTot[2],14)
@ Li,041   PSAY                                          '      |+ 20% INTERESES      56          |'+PADL(aTot[1],17)+'  |' 
@ ++Li,000 PSAY 'COTIZACION VOLUNTARIA   02'+PADL(aTot[3],14)
@ Li,041   PSAY                                          '      |+COSTAS COBRANZA     57          |___________________|_________________________________'
@ ++Li,000 PSAY 'DEPOS. EN CTA.  AHORRO  03'+PADL(aTot[4],14)
@ Li,041   PSAY                                          '      |                                 |TIPO DE PAGO'                 
@ ++Li,000 PSAY 'SUB TOTAL A PAGAR FONDO 04'+PADL(aTot[5],14)
@ Li,041   PSAY                                          '      |TOTAL A PAGAR A.F.P. 60          |NORMAL     | |        FECHA DE PAGO'
@ ++Li,000 PSAY '+ REAJUSTES FONDO       05'+PADL(cReajus,14)
@ Li,041   PSAY                                          '      |                                 |ATRASADA   | |        DIA MES ANO'
@ ++Li,000 PSAY '+ INTERESES FONDO       06'+PADL(cJuros ,14)
@ Li,041   PSAY                                          '      |                                 |ADELANTADA | |'                                    
@ ++Li,000 PSAY 'TOTAL A PAGAR FONDO     10'+PADL(aTot[6],14)
@ Li,041   PSAY                                          '      |                                 |'
@ ++Li,000 PSAY '_______________________________________________|_________________________________| NRO.AFILIADOS        NRO.HOJAS ANEXAS'
@ ++Li,000 PSAY 'SECCION V.- ANTECEDENTES SOBRE EL PAGO                                           |'+STR(aTotAcum[5],12)+'       '+STR(nPagina-1,12)
@ ++Li,000 PSAY '_________________________________________________________________________________|_____________________________________________________'
@ ++Li,000 PSAY 'FONDO DE PENSIONES             EFECTIVO |  |  CHEQUE |  |       |A.F.P.             EFECTIVO |  |  CHEQUE |  |'
@ ++Li,000 PSAY 'CHEQUE #__________BANCO___________PLAZA                         |CHEQUE #___________BANCO___________PLAZA'
@ ++Li,000 PSAY '________________________________________________________________|______________________________________________________________________'
Li++

@ ++Li,000 PSAY 'DECLARO BAJO JURAMENTO QUE LOS DATOS'
@ ++Li,000 PSAY 'CONSIGNADOS SON EXPRESION FIEL DE LA REALIDAD'
Li+=2

@ ++Li,048 PSAY '______________________________'
@ ++Li,048 PSAY '   FIRMA REPRESENTANTE LEGAL'

Return
