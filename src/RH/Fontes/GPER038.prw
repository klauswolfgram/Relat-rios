/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "GPER038.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER038   ³ Autor ³ Silvia Taguti         ³ Data ³ 04.02.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ley 20744 T.O.                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER038                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
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
±±³Alex         ³09/02/2010³00000002530/2010³Existia espaços fixos para a filial, no    ³±±
±±³             ³          ³                ³carregamento do cFilialAnt.                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER038()
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
Private nomeprog :="GPER038 "
Private nLastKey := 0
Private cPerg    :="GPR038"
Private nPagina  :=	0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Li     := 80
Private Titulo := STR0011		
Private cRegPrev, dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef
Private aCodFol:= {}

Pergunte("GPR038",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER038"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,"G")

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
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/

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

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

If LastKey() = 27 .Or. nLastKey = 27
   Return
Endif

SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
   Return
Endif

ProcGpe({|lEnd| RelImp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio
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
±±³Fun‡…o    ³ RelIMP  ³ Autor ³ Silvia Taguti          ³ Data ³ 04.02.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento Para emissao Ley 20744                        ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ RelImp(lEnd,WnRel,cString,cMesAnoRef)                 	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RelImp(lEnd,WnRel,cString,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cMesArqRef  := cMesAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER038","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER038","SRC","2") + "}")
Local cInicio,cFim
Local nOrdem := aReturn[8]
Local cFilialAnt
Local	cSitFunc,dDtPesqAf
Local nNumero   := 0
Local aInfo	
Local	cMat
Local	cNome	
Local	cSecao
Local	cFuncao
Local	cDtAdmiss
Local	cDtDemiss
Local cCateg
Local cRemun
Local cLugTrab
Local cContrat
Local cRegPrev
Local	cNomRgPrev
Local cCatFunc
Local	cDtNasc
Local	cEstCivil
Local cDomicilio
Local cEstado
Local cCic
Local cDocum
Local aVlrLiq := {}
Local aVlrLanca:= {}
Local cGrauPar, cNomeDep, cSexo, cDtNacDep,cIdade,cDocDep,cDtAlt,cEscol
Local aDadosDep := {}
Local cCargo	:= ""
    
Private cAliasMov := ""
Private	Desc_Fil, Desc_End,	Desc_CGC, Desc_Est, Desc_Comp
Private nTotRem :=0
Private nTotNRem := 0
Private nTotDesc := 0
Private lFamilia := .F.
Private aDados    := {}   

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
		If ! Fp_CodFol(@aCodFol,SRA->RA_FILIAL) .Or. ! fInfo(@aInfo,SRA->RA_FILIAL)
			Exit
		Endif

		Desc_Fil := aInfo[3]                //Nome da Filial
		Desc_End := aInfo[4]                // Dados da Filial
		Desc_CGC := aInfo[8]        			// cgc Cobranca
		Desc_Est := Substr(fDesc("SX5","12"+aInfo[6],"X5DESCRI()"),1,12)
		Desc_Comp:= aInfo[14]        			// Complemento Cobranca
		dbSelectArea("SRA")                       
		cFilialAnt := SRA->RA_FILIAL
	Endif
	cMat 	:= SRA->RA_MAT
	cNome	:= Substr(SRA->RA_NOME,1,24)                                  
	cCargo 	:= fGetCargo(SRA->RA_MAT)	
	
	If !Empty(cCargo)
		//Descricao da categoria
	 	cCateg	:= 	fDesc("SQ3",cCargo,"SQ3->Q3_DESCSUM", 9, ,1)
		//Descricao da secao
		cSecao	:=  	fDesc('SQB',SQ3->Q3_DEPTO,'SQB->QB_DESCRIC',13, ,1)
	Endif
	// Descricao da Funcao
	cFuncao	:= Substr(DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL),1,15)
	
	cDtAdmiss := dtoc(SRA->RA_ADMISSA)
	cDtDemiss := dtoc(SRA->RA_DEMISSA)
   cRemun	 := TRANSFORM(SRA->RA_SALARIO,"@R 99,999.99")
 	cLugTrab	 := Substr(Desc_Est,1,15)
 	If SRA->RA_TPCONTR == "1"
	   cContrat:= STR0005
	Else   
		cContrat:= STR0014
	Endif	
   cRegPrev	 := SRA->RA_REGPREV
   If FPHIST82(xFilial("SRX") , "69" , cRegPrev)
		cNomRgPrev := SubStr( SRX->RX_TXT ,  1 , 15) 
	Else            
		cNomRgPrev := Space(15)
		Help("",1,"NOVALIDO","","Tabla de Registro Previsional no encontrada",1)
		Return	.F.
	Endif
   
   cCatFunc	 := Substr(fDesc("SX5","28"+SRA->RA_CATFUNC,"X5DESCRI()"),1,12)
  	cDtNasc   := dtoc(SRA->RA_NASC)
  	cEstCivil := Substr(fDesc("SX5","33"+SRA->RA_ESTCIVI,"X5DESCRI()"),1,10)
   cDomicilio:= Substr(Alltrim(SRA->RA_ENDEREC)+" "+Alltrim(SRA->RA_COMPLEM)+" "+Alltrim(SRA->RA_MUNICIP),1,32)
   cEstado   := Substr(fDesc("SX5","12"+SRA->RA_ESTADO,"X5DESCRI()"),1,12)
   cCic		 := SRA->RA_CIC
   cDocum	 := SRA->RA_RG
   
   Aadd(aDados,{cMat, cNome, cSecao, cFuncao, cDtAdmiss, cDtDemiss, cCateg,cRemun,;
   	  cLugTrab,cContrat,cNomRgPrev,cCatFunc,cDtNasc,cEstCivil,cDomicilio,cEstado,cCic,cDocum})
   	  
   dbSelectArea("SRC")
	dbSetOrder(1)
	If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
		While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SRC->RC_FILIAL + SRC->RC_MAT
			If !Eval(cAcessaSRC)
		 		dbSkip()
		   	Loop
		   EndIf
			If (SRC->RC_PD == aCodFol[47,1])
				fSoma(@aVlrLiq,"C",aCodFol[47,1])
			ElseIf PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "1"
				If PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_REMUNE") == "S"
					fSoma(@aVlrLanca,"C")
					nTotRem += SRC->RC_VALOR
				Else
					fSoma(@aVlrLanca,"C")
					nTotNRem += SRC->RC_VALOR
				Endif
				If (SRC->RC_PD == aCodFol[34,1])
				   lFamilia := .T.
				Endif				
			ElseIf PosSrv(SRC->RC_PD,SRA->RA_FILIAL,"RV_TIPOCOD") == "2"
				fSoma(@aVlrLanca,"C",,,"-" )
				nTotDesc += SRC->RC_VALOR
			Endif	
			dbSelectArea("SRC")
			dbSkip()
		Enddo
	Endif
	If lFamilia
		dbSelectArea("SRB")
		dbSetOrder(1)
		dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
		While !Eof() .And. SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT
  			If SRB->RB_FILIAL + SRB->RB_MAT == SRA->RA_FILIAL + SRA->RA_MAT
	  			If SRB->RB_TIPSF $ "1|2"
  					If SRB->RB_GRAUPAR == "C"
						cGrauPar := STR0019
  					ElseIf SRB->RB_GRAUPAR == "F"
						cGrauPar := STR0020
  					Else
						cGrauPar := STR0021
  					Endif
  					cNomeDep := Substr(SRB->RB_NOME,1,26)
	  				If SRB->RB_SEXO == "M"
						cSexo := STR0022
					Else 
						cSexo := STR0023
					Endif
					cDtNacDep:= dtoc(SRB->RB_DTNASC)
					cIdade    := Str(Calc_Idade(dDataRef,SRB->RB_DTNASC),3)
					cDocDep 	 := SRB->RB_NREGCAR
					cDtAlt	 := dtoc(SRA->RA_ADMISSA)
					Aadd(aDadosDep,{cGrauPar, cNomeDep, cSexo, cDtNacDep,cIdade,cDocDep,cDtAlt,cEscol})
				Endif
			Endif
			dbSkip()
		Enddo
   Endif
	If Len(aVlrLiq) > 0 
   	If Li >= 57
			fCabec()
		Endif	
		fImprime(aDados)
		fLanca(aVlrLanca,aVlrLiq)
		If Len(aDadosDep) > 0
			fImpDep(aDadosDep)
		Endif
	Endif		
	aDados   := {} 
	aVlrRem 	:= {} 
	aVlrNRem := {} 
	aVlrDesc := {} 
	aVlrLiq 	:= {} 

	aDadosDep:= {}
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo
@ 60,119 PSAY STR0030 +Padl(nPagina,5)
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
dbClearFilter()
RetIndex("SRA")

	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCabec    ºAutor  ³Silvia Taguti       ºFecha ³  04/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime cabecalho                                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCabec()

nPagina++
Li	:= 0
@ Li,000   PSAY Desc_Fil
@ Li,105 PSAY STR0025 + Desc_CGC
@ ++Li,000 PSAY Alltrim(Desc_End)+" "+Alltrim(Desc_Comp)+"-"+Desc_Est
@ ++Li,000 PSAY __PrtThinLine()
@ ++Li,024 PSAY STR0004
Li++
@ ++Li,000 PSAY STR0013+MesExtenso(MONTH(dDataRef))+" "+STR(YEAR(dDataRef),4)
@ ++Li,000 PSAY __PrtFatLine()
@ ++li,000 PSAY STR0026
@ ++li,000 PSAY STR0027
@ ++Li,000 PSAY __PrtFatLine()
@ ++Li,000 PSAY STR0028
@ ++Li,000 PSAY __PrtFatLine()

Return  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImprime  ºAutor  ³Silvia Taguti	     º Data ³  02/05/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime Relatorio                                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImprime(aDados)
Local nX := 0                                                    
Li++
For nX := 1 to Len(aDados)
	@Li,000	PSAY aDados[nX][1]     				//Legado
	@Li,007	PSAY aDados[nX][2]               //Apellido y Nombre
	@Li,032	PSAY aDados[nX][3]               //Seccion
	@Li,046	PSAY aDados[nX][4]               //Calif.Profe.
	@Li,062	PSAY aDados[nX][5]               //Ingreso
	@Li,071	PSAY aDados[nX][6]               //Egreso
	@Li,082	PSAY aDados[nX][7]               //Categoria
	@Li,092	PSAY aDados[nX][8]               //Remuneracion
	@Li,104	PSAY aDados[nX][9]               //Lugar de Trabajo
	@Li,120	PSAY aDados[nX][10]              //Contratacion
	Li++ 
	@Li,000	PSAY aDados[nX][11]              //Reg.Provisional
	@Li,017	PSAY aDados[nX][12]              //Mensual/Jornal
	@Li,033	PSAY aDados[nX][13]              //Fecha Nac.
	@Li,047	PSAY aDados[nX][14]              //Estado Civil
   @Li,058	PSAY aDados[nX][15]              //Domicilio
   @Li,092	PSAY aDados[nX][16]              //Provincia
   @Li,105	PSAY aDados[nX][17]              //CUIL        
   @Li,119	PSAY aDados[nX][18]              //Documento   
   LI++               
Next                          
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fLanca    ºAutor  ³Microsiga           º Data ³  02/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao das Verbas                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                   
Static Function fLanca(aVlrLanca,aVlrLiq)

Local nMaximo	:= 0
Local nCont    := 0
Local nColuna  := 0 
Local nValor	:= 0
    
aVlrLanca:= ASort (aVlrLanca,,,{|x,y| x[1] < y[1] }) // Sorteando Arrays

nMaximo:= Len(aVlrLanca)

Li++  
If Li >= 57
	@ 59,000 PSAY __PrtThinLine()
	@ 60,119 PSAY STR0030 +Padl(nPagina,5)
	li := 0
	fCabec()
	fImprime(aDados)
	Li++
Endif   

For nCont := 1 To nMaximo Step 2
	If nCont <= Len(aVlrLanca)
		@ LI,000 PSAY aVlrLanca[nCont,1]+SPACE(5)+aVlrLanca[nCont,2]+SPACE(5)+TRANSFORM(aVlrLanca[nCont,3],"@R 999.99")+SPACE(9)+TransForm(aVlrLanca[nCont,4],'@( 999,999.99')
		If nCont+1 <= nMaximo
			@ LI,070 PSAY aVlrLanca[nCont+1,1]+SPACE(5)+aVlrLanca[nCont+1,2]+SPACE(5)+TRANSFORM(aVlrLanca[nCont+1,3],"@R 999.99")+SPACE(9)+TransForm(aVlrLanca[nCont+1,4],'@( 999,999.99')
		Endif
   Endif
   Li++
	If Li >= 57
		@ 59,000 PSAY __PrtThinLine()
		@ 60,119 PSAY STR0030 +Padl(nPagina,5)
		li := 0
		fCabec()
		fImprime(aDados)
	Endif
Next

Li +=2

If Li >= 57
	@ 59,000 PSAY __PrtThinLine()
	@ 60,119 PSAY STR0030 +Padl(nPagina,5)
	li := 0
	fCabec()
	fImprime(aDados)
	Li++
Endif
@ Li,000 PSAY STR0016 + Transform(nTotRem,'@R 999,999.99')
@ Li,035 PSAY STR0017 + Transform(nTotNRem,'@R 99,999.99')
@ Li,073 PSAY STR0018 + Transform(nTotDesc,'@R 999,999.99')
@ Li,111 PSAY STR0024 + Transform(aVlrLiq[1][4],'@R 999,999.99')
Li ++
If lFamilia
	@ Li,007 PSAY '________________________________________________________________________________________________________________________________'
Else
	@ Li,000 PSAY __PrtThinLine()
Endif

aVlrLiq := {}
aVlrLanca := {}
nTotRem 	:= nTotNRem := nTotDesc := 0   
   
Return                                                  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FImpDet   ºAutor  ³Microsiga           º Data ³  02/07/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime Dependentes                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                

Static Function fImpDep(aDadosDep)
Local nX := 0

@ ++Li,007 PSAY STR0029
@ ++Li,007 PSAY '________________________________________________________________________________________________________________________________'
Li++
For nX := 1 to Len(aDadosDep)
	@Li,032	PSAY aDadosDep[nX][1]     				//Parentesco
	@Li,043  PSAY aDadosDep[nX][2]               //Apellido y Nombre
	@Li,071	PSAY aDadosDep[nX][3]             	//Sexo   
	@Li,082	PSAY aDadosDep[nX][4]               //Nacimiento     
	@Li,091	PSAY aDadosDep[nX][5]               //Edad
	@Li,095	PSAY aDadosDep[nX][6]               //Documento
	@Li,110	PSAY aDadosDep[nX][7]               //Fecha alta
Next                                         //Escol

@ ++Li,000 PSAY __PrtThinLine()

If Li >= 57
	@ ++Li,119 PSAY STR0030 +Padl(nPagina,5)
Endif		

lFamilia := .F.
Li++ 
 
Return

*------------------------------------------------------*
Static Function fSoma(aMatriz,cArq,cCod,nValor,cSinal)
*------------------------------------------------------*
// 1- Matriz onde os dados estao sendo armazenados
// 2- Tipo de Arquivo "C" ou "I"
// 3- Prov/Desc/Base a ser gravado
                                       
Local cDescPd
Local nRet
Local nVal1 := nVal2 := nVal3 := 0
Local cSeq	:=	' '
If	cCod == Nil                  // Caso o Codigo nao seja passado
	If	cArq == "C"               // o tratamento e feito de acordo
		cCod 	:= SRC->RC_PD        // com o cArq (Arquivo usado).
		cSeq	:=	SRC->RC_SEQ	
	Endif
Endif

cDescpd := DescPd(cCod,Sra->Ra_Filial)

If nValor == Nil
	If	cArq == "C"               // o tratamento e feito de acordo
		nValor := SRC->RC_VALOR        // com o cArq (Arquivo usado).
	Endif
Endif
                                                              
If cSinal <> Nil
	nValor := nValor * (-1)
Endif
	
If	cArq == "C"
	nVal1 := SRC->RC_HORAS
	nVal2 := nValor
	nVal3 := SRC->RC_PARCELA
Endif

nRet := Ascan( aMatriz,{|X| x[1] == cCod} )   // Testa se ja existe
If	nRet == 0
	Aadd (aMatriz,{cCod,Substr(cDescPd,1,22),nVal1,nVal2,nVal3,1})  // se nao cria elemento
Else
	aMatriz[nRet,3] += nVal1  
	aMatriz[nRet,4] += nVal2
	aMatriz[nRet,5] += nVal3
	aMatriz[nRet,6] ++
Endif
Return Nil

