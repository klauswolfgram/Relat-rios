/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#include "INKEY.CH"
#INCLUDE "GPER035.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER035  ³ Autor ³ Silvia Taguti         ³ Data ³ 04.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pagamento de SALUD CHILE                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER035(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Luiz Gustavo|19/01/07³      ³Retiradas funcoes de ajuste de dicionario ³±±
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
User Function GPER035()
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
Private nomeprog :="GPER035"
Private nLastKey := 0
Private cPerg    :="GPR035"
Private nPagina  :=	0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Li     := 80
Private Titulo := STR0011		
Private cSalud,dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef,nJuros,nReajus

Pergunte("GPR035",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER035"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,"P")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Ordem do Relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variaveis utilizadas para parametros ³
  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
  ³ mv_par01 -> Inst. Salud de     ?     ³
  ³ mv_par02 -> Inst. Salud hasta  ?     ³
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
  ³ mv_par17 -> Data de Referˆncia ?     ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cSaludDe   := mv_par01 //Codigo de la Inst.Salud a ser listada desde
cSaludAte  := mv_par02 //Codigo de la Inst.Salud a ser listada hasta   
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
dDataRef   := mv_par17 //Data de Referencia para a impressao
cSalud	  := cSaludDe
cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

If LastKey() = 27 .Or. nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
   Return
Endif

ProcGpe({|lEnd| R035Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio
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
±±³Fun‡…o    ³ R035IMP  ³ Autor ³ Silvia Taguti         ³ Data ³ 06.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao da planilha de pagamento de AFP ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R035Imp(lEnd,WnRel,cString,cMesAnoRef)                	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R035Imp(lEnd,WnRel,cString,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cMesArqRef  := cMesAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER035","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER035","SRC","2") + "}")
Local aInfo	
Local aTotPag     := {0,0,0,0,0,0,0}
Local aTotAcum    := {0,0,0,0,0,0,0}
Local cInicio,cFim
Local nOrdem := aReturn[8]
Local cFilialAnt
Local cSitFunc,dDtPesqAf
Local nValBase,nValFix,nValExc,nValAdi,nFonasa,nValServ
Local nNumero   := 0
Local nValUF	:=	0
Local nValUtm	:=	Nil //Tem que ser NIL MESMO
Local nValISA	:=	0
Local aAreaSRX	
Local nX		:=	0	
Private cAliasMov := ""
Private cNomeSAL,cAlqFix, cAlqExc, cAlqAdi,cCodeBase,nCotPag
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
xDriver	:=	&(ReadDriver()[4])
If !FPHIST82(xFilial("SRX") , "66" , cSaludDe)
	Help("",1,"NOVALIDO","","Tabla de SALUD no encontrada",1)
	Return	.F.
Endif
While !SRX->(EOF()) .And. SRX->RX_TIP == "66" .And. Substr(SRX->RX_COD,1,3) <= cSaludAte
	cNomeSAL		:= SubStr( SRX->RX_TXT ,  1 , 25) 
	cAlqfix     := SubStr( SRX->RX_TXT ,  26 , 3 ) 
	cAlqExc     := SubStr( SRX->RX_TXT ,  29 , 3 )
	cAlqAdi     := SubStr( SRX->RX_TXT ,  32 , 3 )
	nFonasa     := SubStr( SRX->RX_TXT ,  35 , 1 ) 
	cCodeBase   := SubStr( SRX->RX_TXT ,  36 , 3 ) 
	cSalud		:=	Substr(SRX->RX_COD,1,3)
	Li				:=	80
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
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste se o funcionario e da OBRASOC selecionada           ³
		//³ Isto nao deveria ser assim, deveria ser informada um conceito³
		//³ diferente para cada OBRASOC, mais no CHILE nao fizeram assim ³
		//³ e por isto eh necessario modificar a rotina.Bruno.           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRA->RA_OBRASOC <> cSalud
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
			Desc_Fil := aInfo[3]    // Nome Completo
			Desc_End := aInfo[4]    // Endereco Cobranca
			Desc_CGC := aInfo[8]    // CGC
			dbSelectArea("SRA")
			cFilialAnt := SRA->RA_FILIAL
		Endif
		
		dbSelectArea("SRC")
		dbSetOrder(3)
		//Pega o valor Fix        
		nValFix	:=	0
		If dbSeek(SRA->RA_FILIAL + cAlqFix + SRA->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cAlqFix+SRA->RA_MAT
			  	If !Eval(cAcessaSRC)
			      dbSkip()
			      Loop
			   EndIf
				nValFix	+= SRC->RC_VALOR			
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
	    // Pega o Valor Excedente
		nValExc :=  0
		If dbSeek(SRA->RA_FILIAL + cAlqExc	+ SRA->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cAlqExc+SRA->RA_MAT
			  	If !Eval(cAcessaSRC)
			      dbSkip()
			      Loop
			   EndIf
				nValExc	+= SRC->RC_VALOR			
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
		//Pega o valor da base
		nValBase	:=	0
	   If dbSeek(SRA->RA_FILIAL+cCodeBase+SRA->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cCodeBase+SRA->RA_MAT
			  	If !Eval(cAcessaSRC)
			      dbSkip()
			      Loop
			   EndIf
				nValBase	+= SRC->RC_VALOR			
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
		//Pega o valor Adicional
		nValAdi :=  0
	    If dbSeek(SRA->RA_FILIAL + cAlqAdi	+ SRA->RA_MAT)
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cAlqAdi+SRA->RA_MAT
			  	If !Eval(cAcessaSRC)
			      dbSkip()
			      Loop
			   EndIf
				nValAdi	+= SRC->RC_VALOR			
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
		//Pega o valor dos servicos
		nValServ :=	0
		For nX:= 1 To Len(Alltrim(mv_par18)) STEP 3
		   If dbSeek(SRA->RA_FILIAL+SubStr(mv_par18,nX,3)+SRA->RA_MAT)
				While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+SubStr(mv_par18,nX,3)+SRA->RA_MAT
				  	If !Eval(cAcessaSRC)
				      dbSkip()
				      Loop
				   EndIf
					nValServ	+= SRC->RC_VALOR			
					dbSelectArea("SRC")
					dbSkip()
				Enddo
			Endif
		Next
      nCotPag := nValFix + nValExc + nValAdi
		If nValFix + nValExc + nValAdi > 0
			If Li > 55
				fCabec(@aTotPag,@aTotAcum,.F.,xDriver)
			Endif	
  
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se aidna nao pegou o valor da UF, pegar agora³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SRA->RA_ISATIPO == '2' .And. nValUF==0
				aAreaSRX	:=	SRX->(GetArea())
				SetValUns(@nValUF,nValUtm,dDataRef)
				RestArea(aAreaSRX)
			Endif
			nNumero   := nNumero + 1
			@ Li,000 PSAY StrZero(nNumero,3)    
			@ Li,004 PSAY SRA->RA_CIC 	Picture PesqPict('SRA','RA_CIC')
	        @ Li,017 PSAY RIGHT(SRA->RA_MAT,5) Picture PesqPict('SRA','RA_MAT')//SRA->RA_MAT
			@ Li,023 PSAY Substr(SRA->RA_NOME,1,24)
			@ Li,048 PSAY nValBase 		Picture TM(nValBase,10,MsDecimais(1))
			@ Li,059 PSAY nValFix 		Picture TM(nValFix,09,MsDecimais(1))
			@ Li,068 PSAY nValAdi 		Picture TM(nValAdi,09,MsDecimais(1))
			@ Li,077 PSAY nValExc 		Picture TM(nValExc,09,MsDecimais(1))
			@ Li,086 PSAY nCotPag 		Picture TM(nCotPag,09,MsDecimais(1))
	 
			If SRA->RA_ISATIPO=='3'
	         nValISA	:=	Round(SRA->RA_ISAVAL*nValBase/100,MsDecimais(1)) 
			ElseIf SRA->RA_ISATIPO=='2'
	         nValISA	:=	Round(SRA->RA_ISAVAL*nValUF,MsDecimais(1))
			Else
				nValISA	:=	SRA->RA_ISAVAL
			Endif			
         @ Li,095 PSAY nValISA Picture TM(nValISA,09,MsDecimais(1))
			If MesAno(SRA->RA_ADMISSA) == MesAno(dDataRef)
				@Li,104 PSAY SRA->RA_ADMISSA
   		Endif
			If MESANO(SRA->RA_DEMISSA) == MesAno(dDataRef)
				@Li,115 PSAY SRA->RA_DEMISSA
	   	Endif
			aTotPag[1]	+=	nValBase
			aTotPag[2]	+=	nValFix
			aTotPag[3]	+=	nValAdi
			aTotPag[4]	+=	nValExc
			aTotPag[6] 	+=	nValISA
			aTotPag[7] 	+=	nValServ
			aTotPag[5]  ++           
			Li++			
		Endif	
		dbSelectArea("SRA")
		SRA->( dbSkip() )
	EndDo
	//Impirmir total da ultima pagina e GERAL.
	If aTotPag[5]  > 0
		fCabec(@aTotPag,@aTotAcum,.T.)
		fPrintCapa(aTotAcum)
	Endif
	aTotPag     := {0,0,0,0,0,0,0}
	aTotAcum    := {0,0,0,0,0,0,0}
	SRX->(DbSkip())
Enddo	
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
±±³Fun‡…o    ³fCabec    ³ Autor ³ Silvia Taguti         ³ Data ³ 06.03.02 ³±±
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
Static Function fCabec(aTotPag,aTotAcum,lLast,xDriver)   // Cabecalho

nPagina++

If nPagina > 1 .Or. lLast
	//Imprimir total por pagina...
	@ ++Li,000 PSAY REPLICATE('_',132)
	@ ++Li,000 PSAY STR0019
	@ ++Li,040 PSAY STR0022
	@	Li ,080 PSAY aTotPag[1] PICTURE TM(aTotPag[2],16,MsDecimais(1))  //Base
	@ ++Li,040 PSAY STR0023
	@	Li ,080 PSAY aTotPag[2] PICTURE TM(aTotPag[2],16,MsDecimais(1))  //Fixo
	@ ++Li,040 PSAY STR0024
	@	Li ,080 PSAY aTotPag[3] PICTURE TM(aTotPag[3],16,MsDecimais(1))  //Adicional
	@ ++Li,040 PSAY STR0025
	@	Li ,080 PSAY aTotPag[4] PICTURE TM(aTotPag[4],16,MsDecimais(1))  //Excedente
	@ ++Li,040 PSAY STR0026
	@	Li ,080 PSAY aTotPag[2]+aTotPag[3]+aTotPag[4] PICTURE TM(aTotPag[2]+aTotPag[3]+aTotPag[4],16,MsDecimais(1)) // A PAGAR
	@ ++Li,040 PSAY STR0027
	@	Li ,080 PSAY aTotPag[6] PICTURE TM(aTotPag[6],16,MsDecimais(1)) //Pactada
	aTotAcum[1]	+=	aTotPag[1]
	aTotAcum[2]	+=	aTotPag[2]
	aTotAcum[3]	+=	aTotPag[3]
	aTotAcum[4]	+=	aTotPag[4]
	aTotAcum[6]	+=	aTotPag[6]		
	aTotAcum[5]	+=	aTotPag[5]		
	aTotAcum[7]	+=	aTotPag[7]		
	aFill(aTotPag,0)
Endif
If !lLast .Or. Li > 60
	Li	:= 0
	If nPagina == 1
		@ Li,000 PSAY xDriver
	Endif
	@ Li,002 PSAY STR0005 + cNomeSAL
	@ ++Li,030 PSAY STR0014

	@ ++Li,110 PSAY STR0012+StrZero(nPagina,6)
    @ ++Li,000 PSAY STR0015  
	@ Li,Len(STR0015)+1  PSAY Desc_CGC picture PesqPict('SRA','RA_CIC')
	@ Li,035 PSAY STR0016  + Desc_Fil
	@ Li,110 PSAY STR0013+MesExtenso(MONTH(dDataRef))+"/"+STR(YEAR(dDataRef),4)

	@ ++Li,000 PSAY REPLICATE('_',132)
	@ ++Li,048 PSAY STR0017
	@ ++Li,000 PSAY STR0018
	@ ++Li,000 PSAY REPLICATE('_',132)
	Li++
Endif

If lLast
	@ ++Li,000 PSAY REPLICATE('_',132)
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
	@ ++Li,40 PSAY STR0027
	@	Li ,080 PSAY aTotAcum[6] PICTURE TM(aTotAcum[6],16,MsDecimais(1))
Endif
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fPrintCapaºAutor  ³Silvia Taguti       ºFecha ³  06/03/02   º±±
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
Local aArea		:= GetArea()
Local aAreaSRX	:=	SRX->(GetArea())
If FPHIST82( xFilial("SRX") , "99" )
	cNomRep := SubStr ( SRX->RX_TXT ,  01 , 30 ) 
	cRutRep := SubStr ( SRX->RX_TXT ,  31 , 14 ) 
	dCamRep := SubStr ( SRX->RX_TXT ,  45 , 8 ) 
	cCodAct := SubStr ( SRX->RX_TXT ,  53 , 6 ) 
Else
	RestArea(aAreaSRX)
	RestArea(aArea)
	Return
Endif

fInfo(@aInfo,cFilAnt)

aTot	:=	{TransForm(aTotAcum[1],TM(aTotAcum[1],10,MsDecimais(1))),;
			 TransForm(aTotAcum[2],TM(aTotAcum[2],09,MsDecimais(1))),;
			 TransForm(aTotAcum[3],TM(aTotAcum[3],09,MsDecimais(1))),;
			 TransForm(aTotAcum[4],TM(aTotAcum[4],09,MsDecimais(1))),;
			 TransForm(aTotAcum[2]+aTotAcum[3]+aTotAcum[4],TM(aTotAcum[2]+aTotAcum[3]+aTotAcum[4],10,MsDecimais(1))),;
			 TransForm(aTotAcum[2]+aTotAcum[3]+aTotAcum[4]+aTotAcum[7]+nJuros+nReajus,TM(aTotAcum[2]+aTotAcum[3]+aTotAcum[4]+aTotAcum[7]+nJuros+nReajus,11,MsDecimais(1))),;
			 TransForm(aTotAcum[7],TM(aTotAcum[7],09,MsDecimais(1))),;
			 }
Li	:= 0
@ Li,000 PSAY STR0005 + cNomeSAL

@ ++Li,110 PSAY STR0012+'000001'

@ ++Li,040 PSAY STR0028
Li++
@ ++Li,000 PSAY STR0029 

@ ++li,000 PSAY STR0030

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'RAZON SOCIAL O NOMBRE : '+aInfo[03]
@ Li,070	PSAY 'R.U.T. : '
@ Li,080 PSAY aInfo[8] Picture Pesqpict('SRA','RA_CIC')
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'DIRECCION : ' + Substr(Alltrim(aInfo[4]) +' '+ Alltrim(aInfo[14]),1,48)
@ Li,050 PSAY 'COMUNA : ' + Substr(aInfo[13],1,15)
@ Li,074 PSAY 'CIUDAD : ' + Substr(aInfo[05],1,15)
@ Li,100 PSAY 'REGION : ' 
@ Li,110 PSAY 'TELEFONO : ' + aInfo[10]
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY Substr('NOMBRE REPRESENTANTE LEGAL : ' + cNomRep,1,61)
@   Li,062 PSAY 'R.U.T. REP. LEGAL : ' 
@   Li,083 PSAY cRutRep Picture Pesqpict('SRA','RA_CIC')
@   Li,100 PSAY 'CAMBIOS EN REP. LEGAL : ' + dCamRep
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'

@ ++Li,000 PSAY 'SECCION B:- DETALLE DE LA COTIZACIONES' 
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'
@ ++Li,000 PSAY 'IDENTIFICACION DEL AFILIADO                                                                                         MOV. DEL PERSONAL  |'
@ ++Li,000 PSAY '|NUM | R.U.T  |N FUN|APEL. PATERNO MAT.NOMBRE| REMUNE.   |COTIZAC.|  LEY   |COT.ADI.| COTIZ.A |COTIZA  |SERVI.|COD | FECHA    | FECHA  |'
@ ++Li,000 PSAY '|  |1|      |2|   |3|                      |4|IMPONIBLE|5|  7%  |6|18.566|7|VOLUN.|8| PAGAR |9|PAC. |10|   |11|    | INICIO   |TERMINO |'
@ ++Li,000 PSAY '|____|________|_____|________________________|___________|________||_______|________|_________|________|______|____|__________|________|'
Li++

@ ++Li ,018 PSAY 'S E G U N  D E T A L L E '
@	Li ,046 PSAY aTot[1]
@	Li ,056 PSAY aTot[2]
@	Li ,065 PSAY aTot[3]
@	Li ,074 PSAY aTot[4]
@   Li ,083 PSAY aTot[5]
@   Li ,093 PSAY aTot[6]
Li++

@ ++Li,000 PSAY 'SECCION C: ANTECEDENTES DE LA COTIZACION                                                  SECCION D: ANTECEDENTES  GENERALES' 
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'
//                         1         2         3         4         5         6         7         8         9        10         11        12
//               012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
@ ++Li,000 PSAY 'CONCEPTO                       VALORES $'                                           
@ ++Li,000 PSAY 'COTIZACION LEGAL (7%)      '+PADL(aTot[2],14)
@ Li,080   PSAY                                                                                     'PERIODO MES ANO   |PERIODO    DESTE        HASTA' 
@ ++Li,000 PSAY 'COTIZ. ART. 8 LEY 18.566   '+PADL(aTot[3],14)                                    
@ Li,089   PSAY                                                                                     STRZERO(MONTH(dDataRef),2)+'/'+STR(Year(dDataRef),4)+'  |             /  /      /  /    '       
@ ++Li,000 PSAY 'COTIZ. ADICIONAL VOLUNTARIA'+PADL(aTot[4],14)
@ Li,080   PSAY                                                                             	 	'TIPO DE PAGO'                 
@ ++Li,000 PSAY 'TOTAL COTIZACION A PAGAR   '+PADL(aTot[5],14)
@ Li,080   PSAY                                                            						    'NORMAL     | |        FECHA DE PAGO'
@ ++Li,000 PSAY 'REAJUSTES                  '+PADL(cReajus,14)
@ Li,080   PSAY                                                                           			'ATRASADA   | |        DIA MES ANO'
@ ++Li,000 PSAY 'INTERESES                  '+PADL(cJuros ,14)
@ Li,080   PSAY                                                                                    	'ADELANTADA | |'                                    
Li++
@ ++Li,000 PSAY 'SUB-TOTAL                  '
@ Li,080   PSAY                                                                                     'NRO.AFILIADOS        NRO.HOJAS ANEXAS'
@ ++Li,000 PSAY 'SERVICIOS                  '+PADL(aTot[7],14)
@ Li,078   PSAY                                                                                    +STR(aTotAcum[5],12)+'         '+STR(nPagina-1,12)                   
@ ++Li,000 PSAY 'TOTAL A PAGAR FONDO        '+PADL(aTot[6],14)

@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________' 
@ ++Li,000 PSAY '                                                                                   EFECTIVO| |     CHEQUE| |'                  
@ ++Li,000 PSAY '                                                                                    CHEQUE #              BANCO           PLAZA   
@ ++Li,000 PSAY '_______________________________________________________________________________________________________________________________________'
Li++
@ ++Li,000 PSAY 'DECLARO QUE LOS DATOS CONSIGNADOS SON'
@ ++Li,000 PSAY 'EXPRESION FIEL A LA REALIDAD'
Li+=2

@ ++Li,048 PSAY '______________________________'
@ ++Li,048 PSAY '   FIRMA REPRESENTANTE LEGAL'

RestArea(aAreaSRX)
RestArea(aArea)
Return