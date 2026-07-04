/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "GPER036.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER036  ³ Autor ³ Silvia Taguti         ³ Data ³ 04.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pagamento de SEGURIDAD CHILE                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_GPER036(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Luiz Gustavo|22/01/07³      ³Retiradas funcoes de ajuste de dicionario ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programador  ³ Data     ³ FNC            ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ³±±
±±³Rogerio R.   ³29/07/2009³00000018278/2009³Compatibilizacao dos fontes para aumento do³±±
±±³             ³          ³                ³campo filial e gestão corporativa.         ³±±
±±³Alex         ³09/02/2010³00000002530/2010³Existia espaços fixos para a filial, no    ³±±
±±³             ³          ³                ³carregamento do cFilialAnt.                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER036()
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
Private aReturn  := {STR0009, 1,STR0010, 1, 2, 1, "",1 }	//"Zebrado"###"Administra‡„o"
Private nomeprog :="GPER036"
Private nLastKey := 0
Private cPerg    :="GPR036"
Private nPagina  :=	0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo := STR0011		
Private dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef,cDataRef
Private aAliqAFP := {}, aAliqApo := {}       
Private Li     := 80      
Private nReajuste := 0
Private nJuros    := 0
Private nMontDeb  := 0
Private nMulta    := 0
Private nCredito  := 0
Private nNtCrDeb  := 0
Private nOutros   := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("GPR036",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER036"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a Ordem do Relatorio                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variaveis utilizadas para parametros ³
  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
  ³ mv_par01 -> Data de Referˆncia ?     ³
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
  ³ mv_par14 -> Reajuste           ?     ³
  ³ mv_par15 -> Intereses          ?     ³
  ³ mv_par16 -> Multa              ?     ³
  ³ mv_par17 -> Credito            ?     ³
  ³ mv_par18 -> Nota de Cred/Deb.  ?     ³
  ³ mv_par19 -> Outros             ?     ³
  ³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dDataRef   := mv_par01 //Data de Referencia para a impressao
cFilDe     := mv_par02 //Filial De
cFilAte    := mv_par03 //Filial Ate
cCcDe      := mv_par04 //Centro de Custo De
cCcAte     := mv_par05 //Centro de Custo Ate
cMatDe     := mv_par06 //Matricula Des
cMatAte    := mv_par07 //Matricula Ate
cNomDe     := mv_par08 //Nome De
cNomAte    := mv_par09 //Nome Ate
ChapaDe    := mv_par10 //Chapa De
ChapaAte   := mv_par11 //Chapa Ate
cSituacao  := mv_par12 //Situacoes a Imprimir
cCategoria := mv_par13 //Categorias a Imprimir
nReajuste  := mv_par14 // Reajuste
nJuros     := mv_par15 // Juros-Intereses
nMulta     := mv_par16  //Multa
nCredito   := mv_par17  //Credito
nNtCrDeb   := mv_par18  //Nota de Credito/Debito
nOutros    := mv_par19  // Outros

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

If LastKey() = 27 .Or. nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
   Return
Endif

ProcGpe({|lEnd| R036Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio
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
±±³Fun‡…o    ³ R036IMP  ³ Autor ³ Silvia Taguti         ³ Data ³ 06.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao da planilha de pagamento de AFP ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R036Imp(lEnd,WnRel,cString,cMesAnoRef)                	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso  Generico                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function R036Imp(lEnd,WnRel,cString,cMesAnoRef)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cMesArqRef  := cMesAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER036","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER036","SRC","2") + "}")
Local aInfo	
Local cInicio,cFim,nX ,nY
Local nOrdem := aReturn[8]
Local cFilialAnt,cMatAnt
Local cSitFunc,dDtPesqAf
Local aQtdAfp := {} 
Local aNomAnt := {} 
Local nNomAnt , cApoFij, cApoVar, nNumero := 0, nValBase := 0
Local nVlrSeg := 0, nTotBas := 0, nTotSeg:= 0, nTotAcBa:=0, nTotAcSe := 0
Local nPosAFP := 0
Private cAliasMov := ""
Private nValAfp := 0; nQtdAfp := 0 
Private	Desc_Fil, Desc_End,	Desc_CGC
Private cTitulo
Private aQtdAnt := {} 	

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

SRX->(dbsetorder(1))
If FPHIST82(xFilial("SRX") , "62" , MesAno(dDataRef)).Or. FPHIST82(xFilial("SRX") , "62" , "      ")
   SRX->(dbsetorder(1))
   While SRX->RX_TIP == "62" 
   	If Substr(SRX->RX_COD,10,1) == "1"
	      Aadd(aAliqAFP,{Substr(SRX->RX_COD,7,3),SubStr(SRX->RX_TXT,1,21),SubStr( SRX->RX_TXT,53,1),Substr(SRX->RX_TXT, 44,3)})
      	AaDD(aQtdAfp,0)
      	AaDD(aQtdAnt,0)
      	If SubStr( SRX->RX_TXT,53,1) == "S"
	      	Aadd(aNomAnt,{Substr(SRX->RX_COD,7,3),SubStr(SRX->RX_TXT,1,21),0,0}) 
	      Endif	
      Endif
	  SRX->(DbSkip())
   Enddo
Endif 

SRX->(dbsetorder(1))
If FPHIST82(xFilial("SRX") , "65" , MesAno(dDataRef)).Or. FPHIST82(xFilial("SRX") , "65" , "      ")
   SRX->(dbsetorder(1))
   While SRX->RX_TIP == "65" 
      Aadd(aAliqApo,{SubStr(SRX->RX_TXT,1,6),Substr(SRX->RX_TXT,7,6),Substr(SRX->RX_TXT,13,3),Substr(SRX->RX_TXT,16,3),Substr(SRX->RX_TXT,19,3)})
	  SRX->(DbSkip())
   Enddo
Endif 

If FPHIST82( xFilial("SRX") , "99","3") 
   cTitulo := SubStr ( SRX->RX_TXT ,  1 , 60 ) 
Endif
dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua Processamento                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GPProcRegua(RecCount())// Total de elementos da regua

cFilialAnt := Space(FwGetTamFilial)
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
		Desc_Fil := aInfo[3]    // Nome Completo
		Desc_End := aInfo[4]    // Endereco Cobranca
		Desc_CGC := aInfo[8]    // CGC
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
   cMatAnt := "      "
   nValBase := 0
   nVlrSeg := 0
	dbSelectArea("SRC")
	dbSetOrder(1) 
   MsSeek(SRA->RA_FILIAL + SRA->RA_MAT +aAliqApo[1,3] )
  	While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT == SRC->RC_FILIAL+SRC->RC_MAT) .And. 	SRC->RC_PD == aAliqApo[1,3]
   	nVlrSeg += SRC->RC_VALOR
   	dBSkip()
	Enddo
	If aAliqApo[1,3] <> aAliqApo[1,4] 
	   dbSeek(SRA->RA_FILIAL + SRA->RA_MAT +aAliqApo[1,4] )
	  	While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT == SRC->RC_FILIAL+SRC->RC_MAT) .And. 	SRC->RC_PD == aAliqApo[1,3]
	   	nVlrSeg += SRC->RC_VALOR
	   	dBSkip()
		Enddo
	Endif
	nPosAFP	:=	Ascan(aAliqAfp,{|x| x[1] == SRA->RA_AFP})
   If nPosAFP > 0
   	MsSeek(SRA->RA_FILIAL + SRA->RA_MAT + aAliqAfp[nPosAFP,4] )
	  	While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT == SRC->RC_FILIAL+SRC->RC_MAT) .And. 	SRC->RC_PD == aAliqAfp[nPosAFP,4]
   		nValBase += SRC->RC_VALOR
			If aAliqAfp[nPosAFP,3] == "N"                          //novo
				nValAfp += SRC->RC_VALOR
				If SRA->RA_MAT <> cMatAnt
	 				aQtdAfp[nPosAFP] += 1 
	  				cMatAnt := SRA->RA_MAT 
				Endif
  			Else
				If SRA->RA_MAT <> cMatAnt
	 				aQtdAnt[nPosAFP] += 1 
	  				cMatAnt := SRA->RA_MAT 
				Endif
				ny := Ascan(aNomAnt, {|x| x[1] == aAliqAfp[nPosAFP,1]})
				If ny > 0
					aNomAnt[ny,1] := aAliqAfp[nPosAFP,1]	//Codigo	
					aNomAnt[ny,2] := aAliqAfp[nPosAFP,2]  //Descricao
					aNomAnt[ny,3] += SRC->RC_VALOR  			//Valor
					aNomAnt[ny,4] := aQtdAnt[nPosAFP]     //Quantidade
				Endif	
			Endif
			SRC->(DbSkip())
		Enddo
	Endif	
	If nVlrSeg > 0 .or. nValBase > 0
		If Li > 60
		   If nPagina > 0
				@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"
			   @ ++Li,046 PSAY "TOTAL HOJA" 
				@Li,072 PSAY nTotBas Picture TM(nTotBas,12,MsDecimais(1))
				@Li,097 PSAY nTotSeg Picture TM(nTotSeg,12,MsDecimais(1))	    	
				@ ++Li,046 PSAY "TOTAL ACUMULADO" 
				@Li,072 PSAY nTotAcBa Picture TM(nTotAcBa,12,MsDecimais(1))
				@Li,097 PSAY nTotAcSe Picture TM(nTotAcSe,12,MsDecimais(1))	    	
				@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"
			Endif
			U_fCabec()
			nTotBas := 0
			nTotSeg 	:= 0
		Endif
		++Li	
		nNumero   := nNumero + 1
		@Li,002 PSAY StrZero(nNumero,6)   
		@Li,009 PSAY Substr(SRA->RA_NOME,1,35)
		@Li,046 PSAY SRA->RA_CIC Picture PesqPict('SRA','RA_CIC')
		@Li,072 PSAY nValBase Picture TM(nValBase,12,MsDecimais(1))
		@Li,097 PSAY nVlrSeg Picture TM(nVlrSeg,12,MsDecimais(1))	    	
		nTotBas  += nValBase
		nTotSeg  += nVlrSeg
		nTotAcBa += nValBase
		nTotAcSe += nVlrSeg 
	Endif	
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo 
If nTotBas > 0 .OR. nTotSeg > 0
	@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"
	@ ++Li,046 PSAY "TOTAL HOJA" 
	@Li,072 PSAY nTotBas Picture TM(nTotBas,12,MsDecimais(1))
	@Li,097 PSAY nTotSeg Picture TM(nTotSeg,12,MsDecimais(1))	    	
	@ ++Li,046 PSAY "TOTAL ACUMULADO" 
	@Li,072 PSAY nTotAcBa Picture TM(nTotAcBa,12,MsDecimais(1))
	@Li,097 PSAY nTotAcSe Picture TM(nTotAcSe,12,MsDecimais(1))	    	
	@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"

	U_fCabec2(aInfo,aAliqAfp,aQtdAfp,aNomAnt)
Endif	

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
±±³Sintaxe   ³ U_fCabec()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fCabec()
nPagina++
Li := 1

@ ++Li,038 PSAY cTitulo   		//ASOCIACION CHILENA DE SEGURIDAD                         
@ Li,122 PSAY STR0016 + StrZero(nPagina,3)            				//pagina: "
@ ++Li,048 PSAY STR0017         //DECLARACION Y PAGO SIMULTANEO
@ Li,122 PSAY UPPER(MesExtenso(Month(dDataRef)))+" "+Alltrim(Str(Year(dDataRef)))
Li +=2
@ ++Li,002 PSAY Desc_fil
@ ++Li,002 PSAY Transform(DESC_CGC,"@R XX.999.999-X")
@ ++Li,002 PSAY alltrim(SM0->M0_ENDENT)+ " "+SM0->M0_COMPENT
@ ++Li,002 PSAY SM0->M0_CIDENT
@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"
@ ++Li,009 PSAY "NOMBRE"                         									         
@ Li,051   PSAY "RUT"                  												  																				
@ Li,080   PSAY "MONTO REMUNERACIONES"
@ ++Li,072 PSAY "Base Imponible              %Seguridad"
@ ++Li,002 PSAY "-------------------------------------------------------------------------------------------------------------------------------------"

Return nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec2   ³ Autor ³ Silvia Taguti         ³ Data ³ 06.03.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMRESSAO Cabe‡alho                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_fCabec2()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function fCabec2(aInfo,aAliqAfp,aQtdAfp,aNomAnt)

Local aSubTot  :={}, aCotiza := {},aOutros := {'','',''}
Local aAntigo1 := {}, aAntigo2 := {}, aAntigo3 := {} 
Local nCotiza, nX, cNumAso
Local nQtdTotal:= 0, nTotal := 0 ,nTotCot := 0
Local cReajus  :=	TransForm(nReajuste,TM(nReajuste,12,MsDecimais(1)))
Local cJuros	:=	TransForm(nJuros,TM(nJuros,12,MsDecimais(1)))
Local cMonto	
Local cMulta	:=	TransForm(nMulta,TM(nMulta,12,MsDecimais(1)))
Local cCredito :=	TransForm(nCredito,TM(nCredito,12,MsDecimais(1)))
Local cNtCrDeb :=	TransForm(nNtCrDeb,TM(nNtCrDeb,12,MsDecimais(1)))
Local cOtros   :=	TransForm(nOutros  ,TM(nOutros  ,12,MsDecimais(1)))
Local nTotPag  := 0
Local cTotPag
Local nLiqPag  := 0
Local cLiqPag  
Local cTotCot

Li := 0

If FPHIST82( xFilial("SRX") , "99","2") 
   cNumAso := SubStr ( SRX->RX_TXT ,  1 , 06 ) 
Else     
   Help(" ",1,"PARAM99")
	Return(.F.)
Endif

If Len(aNomAnt) == 2			
	 AAdd(aNomAnt,{" "," ",0,0 })
ElseIf Len(aNomAnt) == 1
	 AAdd(aNomAnt,{" "," ",0,0 })
	 AAdd(aNomAnt,{" "," ",0,0 })
Else
	 AAdd(aNomAnt,{" "," ",0,0 })
	 AAdd(aNomAnt,{" "," ",0,0 })
	 AAdd(aNomAnt,{" "," ",0,0 })
Endif	

For nX := 1 to Len(aNomAnt)
    aAdd(aCotiza,{TransForm(aNomAnt[nX,3]*((Val(aAliqApo[1,1])+Val(aAliqApo[1,2]))/100),TM(aNomAnt[nX,3],11,MsDecimais(1)))})
    If aNomAnt[nX,3] > 0
       aAdd(aSubTot,{TransForm(aNomAnt[nX,3],TM(aNomAnt[nX,3],11,MsDecimais(1)))}) 
       nTotal += aNomAnt[nX,3]
    Endif
Next

nTotCot := (nTotal+nValAfp)*((Val(aAliqApo[1,1])+Val(aAliqApo[1,2]))/100)
cTotCot := Transform(nTotCot,TM(nTotCot,11,MsDecimais(1)))                     
nTotal  := Transform(nTotal+nValAfp,TM(nTotal+nValAfp,11,MsDecimais(1)))     
nCotiza := TransForm(nValAfp*((Val(aAliqApo[1,1])+Val(aAliqApo[1,2]))/100),TM(nValAfp,11,MsDecimais(1)))
nValAfp := Transform(nValAfp,TM(nValAfp,14,Msdecimais(1))) 

nMontDeb :=nTotCot+nReajuste+nJuros 
cMonto	:=	TransForm(nMontDeb,TM(nMontDeb,12,MsDecimais(1)))
nTotPag  := nMontDeb + nMulta
cTotPag	:= TransForm(nTotPag,TM(nTotPag,12,MsDecimais(1)))
nLiqPag  := nTotPag+nCredito+nNtCrDeb+nOutros
cLiqPag  := TransForm(nLiqPag,TM(nLiqPag,12,MsDecimais(1)))

For nX := 1 to Len(aQtdAfp)
    nQtdAfp += aQtdAfp[nX]
Next

nQtdTotal += nQtdAfp  

For nX := 1 to Len(aQtdAnt)
    nQtdTotal += aQtdAnt[nX]
Next

aAntigo1 := {TransForm(aNomAnt[1,3],TM(aNomAnt[1,3],11,MsDecimais(1))),;
TransForm(aNomAnt[1,4],TM(aNomAnt[1,4],11,Msdecimais(1))),aCotiza[1,1],aNomAnt[1,2]}
aAntigo2 := {TransForm(aNomAnt[2,3],TM(aNomAnt[2,3],11,MsDecimais(1))),;
TransForm(aNomAnt[2,4],TM(aNomAnt[2,4],11,Msdecimais(1))),aCotiza[2,1],aNomAnt[2,2]}
aAntigo3 := {TransForm(aNomAnt[3,3],TM(aNomAnt[3,3],11,MsDecimais(1))),;
TransForm(aNomAnt[3,4],TM(aNomAnt[3,4],11,Msdecimais(1))),aCotiza[3,1],aNomAnt[3,2]}

nPagina++                                                           
Li +=2
@ Li,002  PSAY REPLICATE("-",132)
Li ++
@ Li,038  PSAY cTitulo  			 //ASOCIACION CHILENA DE SEGURIDAD
LI +=2
@ Li,048 PSAY STR0013                //DECLARACION Y PAGO DE COTIZACIONES
@ Li,115 PSAY STR0014                //No
Li ++
@ Li,048 PSAY STR0015 + MesExtenso(Month(dDataRef))+" de "+ Alltrim(Str(Year(dDataRef)))
@ Li,115 PSAY STR0016 + StrZero(nPagina,3)            //pagina: "
Li ++
//           1         2         3         4         5         6         7         8         9        10         11        12        13
// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
@ ++Li,016 PSAY   "+-------------------------------------+   +--------------------------------------------------------------------+"
@ ++Li,016 PSAY   "|       USO EXCLUSIVO A.CH.S.         |   |               IDENTIFICACION DE ASOCIADO                           |" 
@ ++Li,016 PSAY   "|       ---------------------         |   |               --------------------------                           |"
@ ++Li,016 PSAY   "|       FECHA DE DECLARACION          |   |  % COTIZACION: "+PADR(Val(aAliqApo[1,1])+Val(aAliqApo[1,2]),13)+"No DE ASOCIADO : "+PADR(cNumAso,22)+  "|"
@ ++Li,016 PSAY   "|     +--+--+--+--+--+--+--+--+       |   |                                                                    |"
@ ++Li,016 PSAY   "|     |  |  |  |  |  |  |  |  |       |   |  NOMBRE EMPRESA: "+PADR(Desc_fil,50)+                            "|"   
@ ++Li,016 PSAY   "|     +--+--+--+--+--+--+--+--+       |   |                                                                    |"
@ ++Li,016 PSAY   "|                                     |   |  R.U.T.: "+PADR(Transform(SM0->M0_CGC,"@R XX.999.999-X"),58)+   "|"   
@ ++Li,016 PSAY   "|       FECHA DE CANCELACION          |   |                                                                    |"   
@ ++Li,016 PSAY   "|     +--+--+--+--+--+--+--+--+       |   |  DIRECCION: "+PADR(Desc_End,55)+                                 "|"
@ ++Li,016 PSAY   "|     |  |  |  |  |  |  |  |  |       |   |                                                                    |"
@ ++Li,016 PSAY   "|     +--+--+--+--+--+--+--+--+       |   |  CIUDAD: "+PADR(aInfo[05],21)+"COMUNA: "+PADR(aInfo[13],29)+   "|"
@ ++Li,016 PSAY   "+-------------------------------------+   |  TELEFONO: "+PADR(aInfo[10],56)+                                 "|"   
@ ++Li,016 PSAY   "                                          +--------------------------------------------------------------------+" 
@ ++Li,011 PSAY "--------------------------------------------------------- COTIZACION ------------------------------------------------------"
@ ++Li,011 PSAY "+-------------------------------------+---------------------+--+-----------------------+------+---------------------------+" 
@ ++Li,011 PSAY "|   AFILIADO A CAJA DE COMPENSACION   |   No TRABAJADORES   |  |     REMUNERACIONES    |      |       COTIZACION          |"
@ ++Li,011 PSAY "|      SI:        NO:                 |                     |  |       IMPONIBLES      |      |                           |"
@ ++Li,011 PSAY "+-------------------------------------+---------------------+--+-----------------------+------+---------------------------+" 
@ ++Li,011 PSAY "| 1."+PADR(aNomAnt[1,2],34)+             "|" +PADL(aAntigo1[2],12)                   
@ Li,071 PSAY "|  $"+PADL(aAntigo1[1],16)
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(aAntigo1[3],18)    
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 2."+PADR(aNomAnt[2,2],34)+             "|" +PADL(aAntigo2[2],12)
@ Li,071 PSAY "|  $"+PADL(aAntigo2[1],16)     
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(aAntigo2[3],18)       
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 3."+PADR(aNomAnt[3,2],34)+             "|"+PADL(aAntigo3[2],12)            
@ Li,071 PSAY "|  $"+PADL(aAntigo3[1],16)  
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(aAntigo3[3],18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 4.A.F.P.                            |"+PADL(nQtdAfp,12)
@ Li,071 PSAY "|  $"+PADL(nValAfP,16)         
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(nCotiza,18)    
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 5.OTRAS.                            |"+PADL(aOutros[2],12)            
@ Li,071 PSAY "|  $"+PADL(aOutros[1],16)  
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(aOutros[3],18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 6.TOTALES                           |"+PADL(nQtdTotal,12)
@ Li,071 PSAY "|  $"+PADL(nTotal,16)                       
@ Li,098 PSAY "|      "
@ Li,105 PSAY "$"+PADL(cTotCot,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                     +"
@ Li,050 PSAY "---------------------+   -----------------------+       ---------------------------+" 
@ ++Li,011 PSAY "| 7.REAJUSTE"
@ Li,105 PSAY "$" +PADL(cReajus,18)                    
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 8.INTERESES"
@ Li,105 PSAY "$"+PADL(cJuros ,18)
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 9.MONTO ADEUDADO"
@ Li,105 PSAY "$"+PADL(cMonto ,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 10.MULTA"
@ Li,105 PSAY "$"+PADL(cMulta ,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 11.TOTAL A PAGAR                                                                            "
@ Li,105 PSAY "$" +PADL(cTotPag ,18)                                                   
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 12.CREDITO                                                    ______________________        "
@ Li,105 PSAY "$"+PADL(cCredito,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 13.NOTA DE CREDITO / DEBITO                                   ______________________        "
@ Li,105 PSAY "$"+PADL(cNtCrDeb,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 14.OTROS   _________________________________________________________________________        "
@ Li,105 PSAY "$"+PADL(cOtros,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "|                                                                                              ---------------------------+" 
@ ++Li,011 PSAY "| 15.L I Q U I D O  A  P A G A R                                                              "
@ Li,105 PSAY "$"+PADL(cLiqPag,18)                          
@ Li,133 PSAY "|"
@ ++Li,011 PSAY "+-------------------------------------------------------------------------------------------------------------------------+" 
@ ++Li,011 PSAY "+-----------------------------------------------------------+  +----------------------------------------------------------+" 
@ ++Li,011 PSAY "|                                                           |  |                   FIRMA Y TIMBRE AUTORIZADOS             |" 
@ ++Li,011 PSAY "|             ________________________________              |  |                ASOCIACION CHILENA DE SEGURIDAD           |" 
@ ++Li,011 PSAY "|               FIRMA DEL REPRESENTANTE LEGAL               |  |                           Y BANCOS                       |" 
@ ++Li,011 PSAY "|                                                           |  |                                                          |" 
@ ++Li,011 PSAY "+-----------------------------------------------------------+  +----------------------------------------------------------+" 
Li ++

Return Nil
