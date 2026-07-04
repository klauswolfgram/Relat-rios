/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "INKEY.CH"
#INCLUDE "GPER033A.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcion   ³ InfoAFP  ³ Autor ³ Mauricio Contreras    ³ Data ³ 29.06.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip   ³ Planilla de Cotizaciones de AFP                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ INFOAFPa()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Liquidaciones                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ACTUALIZACIONES SUFRIDAS DESDE SU CREACION INICIAL.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Fecha  ³ BOPS ³  Motivo de la modificacion               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Luiz Gustavo³29/01/07³116748³Retiradas funcoes de ajuste de dicionario.³±±  
±±³Ricardo D.  ³20/04/07³124762³Retiradas a funcao ajustBSx1().           ³±±  
±±³Rogerio R   ³29/07/09³018278³Compatibilizacao dos fontes para aumento  ³±±
±±³            ³        ³ /2009³do campo filial e gestão corporativa.     ³±±
±±³Alex        ³16/11/09³028005³/2009 - Adaptação gestão corporativa      ³±±
±±³R.Berti	   ³16/05/12³TEYTER³Ajuste tamanho do cpo X69_LIMITE p/CHILE. ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER033A()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define las variables Locales                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString:="SRA"
Local aOrd   := {STR0001,STR0002,STR0003}  //"Matricula"###"Centro de Costo"###"Nombre"
Local cDesc1 := STR0004 //"Informe de planilla de Cotizaciones AFP"
Local cDesc2 := STR0005 //"Sera impreso de acuerdo a los parametros"
Local cDesc3 := STR0006 //"informados por el usuario"
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define las variables privadas                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0007, 1,STR0008, 2, 2, 1, "",1 } //"Zebrado"###"Administracion"
Private nomeprog :="GPER033"
Private nLastKey := 0
Private cPerg    :="GPR033"
Private nPagina  :=	0
Private Li     := 80
Private Titulo := STR0009		 //"Planilla de AFP"
Private cAFP, dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef,nJuros,nReajus


Pergunte("GPR033",.T.)


/*ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
  ³ Variables usadas para parametros     ³
  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
  ³ mv_par01 -> AFP                ?     ³
  ³ mv_par02 -> Fecha de Referencia ?    ³
  ³ mv_par03 -> Filial De          ?     ³
  ³ mv_par04 -> Filial Hasta       ?     ³
  ³ mv_par05 -> Centro de Costo De ?     ³
  ³ mv_par06 -> Centro de Costo A  ?     ³
  ³ mv_par07 -> Matricula De       ?     ³
  ³ mv_par08 -> Matricula A        ?     ³
  ³ mv_par09 -> Nombre De          ?     ³
  ³ mv_par10 -> Nombre A           ?     ³
  ³ mv_par11 -> Chapa De           ?     ³
  ³ mv_par12 -> Chapa A            ?     ³
  ³ mv_par13 -> Situaciones a Imp. ?     ³
  ³ mv_par14 -> Categorias a Imp.  ?     ³
  ³ mv_par15 -> Reajuste                 ³
  ³ mv_par16 -> Intereses                ³
  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cargando variables mv_par?? en Variables del Sistema.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 
cAFP       := mv_par01 //Codigo de la AFP a ser listada    
dDataRef   := mv_par02 //Fecha de Referencia para impresion
cFilDe     := mv_par03 //Filial De
cFilAte    := mv_par04 //Filial A
cCcDe      := mv_par05 //Centro de Costo De
cCcAte     := mv_par06 //Centro de Costo A
cMatDe     := mv_par07 //Matricula De
cMatAte    := mv_par08 //Matricula A
cNomDe     := mv_par09 //Nombre De
cNomAte    := mv_par10 //Nombre A
ChapaDe    := mv_par11 //Chapa De
ChapaAte   := mv_par12 //Chapa A
cSituacao  := mv_par13 //Situacioness a Imprimir
cCategoria := mv_par14 //Categorias a Imprimir
nReajus    := mv_par15 
nJuros     := mv_par16 
 
cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)
 
If LastKey() = 27 .Or. nLastKey = 27
   Return
Endif

//SetDefault(aReturn,cString)

If LastKey() = 27 .OR. nLastKey = 27
   Return
Endif

RptStatus({|lEnd| ImpAFP(@lEnd,cMesAnoRef)},Titulo)

Set Device To Screen
/*/
If aReturn[5] = 1 
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
/*/
MS_FLUSH()

Return( NIL )
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcion   ³ AFPIMP   ³ Autor ³ Mauricio Contreras    ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip   ³ Procesamiento para emision de la planilla de aFP           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ AFPImp(lEnd,WnRel,cString,cMesAnoRef)                  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ImpAFP(lEnd,cMesAnoRef)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variables Locales (Basicas)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aOrdBag     := {}
Local cMesArqRef  := cMesAnoRef
Local cArqMov     := ""
Local cAcessaSRA  := &("{ || " + ChkRH("GPER033","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER033","SRC","2") + "}")
Local aInfo	
Local cInicio,cFim
Local nOrdem := aReturn[8]
Local cFilialAnt
Local	cSitFunc,dDtPesqAf
Local nValBase,nValObrig,nValCot,nValVol        
Local lValPrintCapa1	:=.F.

 
Private cAliasMov := ""
Private cNomeAFP,	nAlqObrig, cCodObrig1, cCodObrig2, cCodVol, cCodCot, cCodBase,	cSegBase, cSegAfil, cSegEmpre, nLimUM
Private	Desc_Fil, Desc_End,	Desc_CGC
aTotPag     := {0,0,0,0,0,0,0}
aTotAcum    := {0,0,0,0,0,0,0}
nNumero:=nNumeCes:=0
nNumerop:=nNumeCesp:=0
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleccionando el orden de impresion del parametro            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA")
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Endif

//SendPrtInfo("M",15)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleccionando el Primer Registro y montando el filtro.       ³
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

If FPHIST82(xFilial("SRX") , "62" , MesAno(dDataBase)+cAFP+"1" ).Or. FPHIST82(xFilial("SRX") , "62" , "      "+cAFP+"1"  )
 
	cNomeAFP		:= SubStr( SRX->RX_TXT ,  1 , 21) 
	nAlqObrig 	:= Val( SubStr( SRX->RX_TXT ,  22 , 5 ) )+Val( SubStr( SRX->RX_TXT ,  27 , 5 ) )
	cCodObrig1 	:= SubStr( SRX->RX_TXT ,  32 , 3 ) 
	cCodObrig2	:= SubStr( SRX->RX_TXT ,  35 , 3 ) 
	cCodVol		:= SubStr( SRX->RX_TXT ,  38 , 3 ) 
	cCodCot	 	:= SubStr( SRX->RX_TXT ,  41 , 3 ) 
	cCodBase	:= SubStr( SRX->RX_TXT ,  44 , 3 ) 
	nLimUM		:= Val( SubStr( SRX->RX_TXT  ,  47 , 6 ) )
	cCodVolNaf	:= SubStr( SRX->RX_TXT ,  54 , 3 ) 
Else
	Help("",1,"NOVALIDO","",STR0010,1) //"Tabla de AFP no encontrada"
	Return	.F.
Endif
If FPHIST82(xFilial("SRX") , "62" , MesAno(dDataBase)+cAFP+"2" ).Or. FPHIST82(xFilial("SRX") , "62" , "      "+cAFP+"2"  )
 
	cRutAFP		:= SubStr( SRX->RX_TXT ,  1 , 9) 
Else
	Help("",1,"NOVALIDO","",STR0010,1) //"Tabla de AFP no encontrada"
	Return	.F.
Endif
If FPHIST82(xFilial("SRX") , "69" , MesAno(dDataBase)) .Or. FPHIST82(xFilial("SRX") , "69" , "      ")
	cSegEmpre:= SubStr( SRX->RX_TXT ,   5 , 3 )        //Concepto empresa
	cSegAfil := SubStr( SRX->RX_TXT ,   12 , 3 )       //Concepto afiliado
	cSegBase := SubStr( SRX->RX_TXT ,   19 , 3 )       //Concepto base
	nLimSC   := Val( SubStr( SRX->RX_TXT ,   22 , 5 ) )//Limite en UF para base
Else
	Help("",1,"NOVALIDO","",STR0011,1) //"Tabla de Seguro cesantia no encontrada"
	Return	.F.
Endif


dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carga Regua de Procesamiento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
 

aLetras:={"Arial","Courier New","Times New Roman"}
Letra:=2

oFont05  := TFont():New( aLetras[Letra] ,,05,,.f.,,,,,.f. )  
oFont06  := TFont():New( aLetras[Letra] ,,06,,.f.,,,,,.f. )  
oFont08  := TFont():New( aLetras[Letra] ,,08,,.f.,,,,,.f. )  
oFont09  := TFont():New( aLetras[Letra] ,,09,,.f.,,,,,.f. )  
oFont10  := TFont():New( aLetras[Letra] ,,10,,.f.,,,,,.f. )
oFont12  := TFont():New( aLetras[Letra] ,,12,,.f.,,,,,.f. )
oFont08b := TFont():New( aLetras[Letra] ,,08,,.t.,,,,,.f. )// negrita.
oFont09b := TFont():New( aLetras[Letra] ,,09,,.t.,,,,,.f. )// negrita
oFont10b := TFont():New( aLetras[Letra] ,,10,,.t.,,,,,.f. )// negrita.
oFont11b := TFont():New( aLetras[Letra] ,,11,,.t.,,,,,.f. )// negrita.
oFont12b := TFont():New( aLetras[Letra] ,,12,,.t.,,,,,.f. )// negrita.
oFont16b := TFont():New( aLetras[Letra] ,,16,,.t.,,,,,.f. )// negrita.

oIsapre := TFont():New( "Arial",,16,,.t.,,,,,.f. )// negrita.

oPrn:= TMSPrinter():New() ///?????????
oPrn:Setlandscape()
oPrn:Setup()


cFilialAnt := Space(FWGETTAMFILIAL)
Li:=560
oPrn:StartPage()
nImpresos:=0
While SRA->( !Eof() .And. &cInicio <= cFim )
 	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mueve Regua de Procesamiento                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Incregua(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)
	  
	If lEnd
		@Prow()+1,0 PSAY STR0012 //"Abortado por el operador"
		Exit
	Endif	 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Revisa parametros de intervalo del informe                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)   .Or. (SRA->Ra_NOME > cNomAte)   .Or. ;
		(SRA->RA_AFP < cAFP)      .Or. (SRA->Ra_AFP > cAFP)       .Or. ;
		(SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
		(SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	//³ Verifica fecha despido         ³
  	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Left(cMesAnoRef,2) + "/" + Right(cMesAnoRef,4))
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Revisa situacion y categoria de los funcionarios			     ³
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
	//³ Revisa el control de acceso y filiales validas               ³
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

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Datos de la filial³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		Desc_End := aInfo[4] 
		Desc_CGC := aInfo[8]
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	
	dbSelectArea("SRC")
	dbSetOrder(3)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Limpia el valor del base³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Limpia el valor obligatorio³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Limpia el valor de la cotizacion voluntaria³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
	//Pega el valor del ahorro voluntario
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
	//Pega el valor del Base para el seguro
	nSegBase	:=	0
	If dbSeek(SRA->RA_FILIAL + cSegBase	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cSegBase+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nSegBase	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
 		Enddo
	Endif
	//Pega el valor a cancelar por el afiliado
	nSegAfil	:=	0
	If dbSeek(SRA->RA_FILIAL + cSegAfil	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cSegAfil+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nSegAfil	+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
 		Enddo
	Endif
	//Pega el valor del Base para el seguro
	nSegEmpre:=	0
	If dbSeek(SRA->RA_FILIAL + cSegEmpre	+ SRA->RA_MAT)
		While !Eof() .And. SRC->RC_FILIAL+SRC->RC_PD+SRC->RC_MAT == SRA->RA_FILIAL+cSegEmpre+SRA->RA_MAT
		  	If !Eval(cAcessaSRC)
		      dbSkip()
		      Loop
		   EndIf
			nSegEmpre+= SRC->RC_VALOR			
			dbSelectArea("SRC")
			dbSkip()
 		Enddo
	Endif
 	If nValVol+nValCot+nValObrig+nValBase+nSegBase+nSegAfil+nSegEmpre > 0
		nNumero   := nNumero + 1
		nNumerop++
		nImpresos++
		oPrn:say(LI,0170,StrZero(nNumero,3)											,oFont09	,100)
		oPrn:say(LI,0281,TRANSFORM(SRA->RA_CIC,PesqPict('SRA','RA_CIC'))	,oFont09	,100)
		oPrn:say(LI,0562,Substr(SRA->RA_NOME,1,26)								,oFont09	,100)
		oPrn:say(LI,1156,Transform(nValBase		,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,1356,Transform(nValobrig	,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,1556,Transform(nValvol		,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,1756,Transform(nSegBase		,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,1956,Transform(nSegAfil		,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,2156,Transform(nSegEmpre	,"@e 99,999,999")	,oFont08	,100)
		If MesAno(SRA->RA_ADMISSA) == MesAno(dDataRef)
			oPrn:say(LI,2410,transform(SRA->RA_ADMISSA,"@d")	,oFont10	,100)
   	Endif
		If MESANO(SRA->RA_DEMISSA) == MesAno(dDataRef)
			oPrn:say(LI,2610,transform(SRA->RA_DEMISSA,"@d"),oFont10	,100)
   	Endif
	 	If nSegBase+nSegAfil+nSegEmpre > 0
	      nNumeces++
	      nNumecesp++
		Endif
		aTotPag[1]	+=	nValBase  // Remu Imp
		aTotPag[2]	+=	nValObrig // Obligat
		aTotPag[3]	+=	nValVol   // Cta Ahorro
		aTotPag[4]	+=	nSegBase  // Impo seguro
		aTotPag[5]	+=	nSegAfil  // Seguro Empleado
		aTotPag[6]	+=	nSegEmpre // Seguro Empresa
		aTotPag[7]++
		Li+=50	
		lValPrintCapa1:=.F.		
		If nNumeroP=25
			lin:=Li-350
			fCabec(@aTotPag,@aTotAcum,.F.)
			SECCION2(350,LIn-10)
         oPrn:line(350+lin-10+100,0900,350+lin-10+100,2350)
         oPrn:line(350+lin-10+150,0900,350+lin-10+150,2350)
         oPrn:line(350+lin-10+100,0900,350+lin-10+150,0900)
			oPrn:line(350+lin-10+100,1150,350+lin-10+150,1150)
			oPrn:line(350+lin-10+100,1350,350+lin-10+150,1350)
			oPrn:line(350+lin-10+100,1550,350+lin-10+150,1550)
			oPrn:line(350+lin-10+100,1750,350+lin-10+150,1750)
			oPrn:line(350+lin-10+100,1950,350+lin-10+150,1950)
			oPrn:line(350+lin-10+100,2150,350+lin-10+150,2150)
			oPrn:line(350+lin-10+100,2350,350+lin-10+150,2350)
			oPrn:say(350+lin-10+110,1156,Transform(aTotAcum[1],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1356,Transform(aTotAcum[2],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1556,Transform(aTotAcum[3],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1756,Transform(aTotAcum[4],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1956,Transform(aTotAcum[5],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,2156,Transform(aTotAcum[6],"@e 99,999,999")	,oFont08	,100)
			oPrn:Say(350+lin-10+110,905,"Total Acumulado",oFont06,100)
			
			oPrn:Box(2050,0150,2300,0800)
			oPrn:say(2060,0195,' DECLARO BAJO JURAMENTO QUE LOS ANTECEDENTES'		     ,oFont06	,100)
			oPrn:say(2085,0195,'CONSIGNADOS SON EXPRESION FIEL DE LA REALIDAD'	     ,oFont06	,100)
			oPrn:Line(2230,0200,2230,750)
			oPrn:say(2240,0210,'Firma del Empleador o Representante Legal'	     			,oFont06	,100)

			oPrn:Box(2050,0850,2300,1550)
			oPrn:say(2060,1100,'N° Afiliados          Total Afiliados'		,oFont05	,100)
			oPrn:say(2080,1100,' por página              acumulados'			,oFont05	,100)
			oPrn:say(2160,0860,'Fondo de Cesantia'		,oFont06	,100)
			oPrn:say(2260,0860,'Fondo de Pensiones'	,oFont06	,100)
			oPrn:Say(2160,1150,Transform(nNumeCesp,"@e 999"),oFont06,100)
			oPrn:Say(2160,1450,Transform(nNumeCes,"@e 999"),oFont06,100)
			oPrn:Say(2260,1150,Transform(nNumerop,"@e 999"),oFont06,100)
			oPrn:Say(2260,1450,Transform(nNumero,"@e 999"),oFont06,100)
	
			oPrn:Box(1900,2700,2300,3100)
			oPrn:say(1920,2710,'1 Iniciación de servicios de       ',oFont05	,100)
			oPrn:say(1940,2710,'  trabaj. contratados a plazo fijo ',oFont05	,100)
		
			oPrn:say(1970,2710,'2 Cesación de los servicios        ',oFont05	,100)
			oPrn:say(1990,2710,'  prestados por el trabajador      ',oFont05	,100)
	
			oPrn:say(2020,2710,'3 Trabajadores afectos a subsidios ',oFont05	,100)
			oPrn:say(2040,2710,'  por incapacidad laboral          ',oFont05	,100)
		
			oPrn:say(2070,2710,'4 Trabajadores que estén afectos a ',oFont05	,100)
			oPrn:say(2090,2710,'  permiso sin goce de sueldo       ',oFont05	,100)
	
			oPrn:say(2120,2710,'5 Incorporación en el lugar de     ',oFont05	,100)
			oPrn:say(2140,2710,'  trabajo                          ',oFont05	,100)
	
			oPrn:say(2170,2710,'6 Iniciación de servicios de       ',oFont05	,100)
			oPrn:say(2190,2710,'  trabajadores contratados a plazo ',oFont05	,100)
			oPrn:say(2210,2710,'  o para una obra, trabajo o       ',oFont05	,100)
			oPrn:say(2230,2710,'  servicio determinado.            ',oFont05	,100)

			oPrn:say(2260,2710,'7 Transformación del contrato de   ',oFont05	,100)
			oPrn:say(2280,2710,'  plazo fijo a plazo indefinido    ',oFont05	,100)
			nNumerop:=nNumeCesp:=0
			oPrn:EndPage()  
			lValPrintCapa1:=.T.
			Li:=560
		Endif	
	Endif	
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo
lin:=li-350
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impirmir total de la ultima pagina y GRAL.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aTotPag[1]+aTotPag[2]+aTotPag[3]+aTotPag[4]+aTotPag[5]+aTotPag[6] > 0 .and. !lValPrintCapa1
	fCabec(@aTotPag,@aTotAcum,.F.) 
	SECCION2(350,LIn-10)
         oPrn:line(350+lin-10+100,0900,350+lin-10+100,2350)
         oPrn:line(350+lin-10+150,0900,350+lin-10+150,2350)
         oPrn:line(350+lin-10+100,0900,350+lin-10+150,0900)
			oPrn:line(350+lin-10+100,1150,350+lin-10+150,1150)
			oPrn:line(350+lin-10+100,1350,350+lin-10+150,1350)
			oPrn:line(350+lin-10+100,1550,350+lin-10+150,1550)
			oPrn:line(350+lin-10+100,1750,350+lin-10+150,1750)
			oPrn:line(350+lin-10+100,1950,350+lin-10+150,1950)
			oPrn:line(350+lin-10+100,2150,350+lin-10+150,2150)
			oPrn:line(350+lin-10+100,2350,350+lin-10+150,2350)
			oPrn:say(350+lin-10+110,1156,Transform(aTotAcum[1],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1356,Transform(aTotAcum[2],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1556,Transform(aTotAcum[3],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1756,Transform(aTotAcum[4],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,1956,Transform(aTotAcum[5],"@e 99,999,999")	,oFont08	,100)
			oPrn:say(350+lin-10+110,2156,Transform(aTotAcum[6],"@e 99,999,999")	,oFont08	,100)
			oPrn:Say(350+lin-10+110,905,"Total Acumulado",oFont06,100)
			
			oPrn:Box(2050,0150,2300,0800)
			oPrn:say(2060,0195,' DECLARO BAJO JURAMENTO QUE LOS ANTECEDENTES'		     ,oFont06	,100)
			oPrn:say(2085,0195,'CONSIGNADOS SON EXPRESION FIEL DE LA REALIDAD'	     ,oFont06	,100)
			oPrn:Line(2230,0200,2230,750)
			oPrn:say(2240,0210,'Firma del Empleador o Representante Legal'	     			,oFont06	,100)

			oPrn:Box(2050,0850,2300,1550)
			oPrn:say(2060,1100,'N° Afiliados          Total Afiliados'		,oFont05	,100)
			oPrn:say(2080,1100,' por página              acumulados'			,oFont05	,100)
			oPrn:say(2160,0860,'Fondo de Cesantia'		,oFont06	,100)
			oPrn:say(2260,0860,'Fondo de Pensiones'	,oFont06	,100)
			oPrn:Say(2160,1150,Transform(nNumeCesp,"@e 999"),oFont06,100)
			oPrn:Say(2160,1450,Transform(nNumeCes,"@e 999"),oFont06,100)
			oPrn:Say(2260,1150,Transform(nNumerop,"@e 999"),oFont06,100)
			oPrn:Say(2260,1450,Transform(nNumero,"@e 999"),oFont06,100)
	
	oPrn:Box(1900,2700,2300,3100)
	oPrn:say(1920,2710,'1 Iniciación de servicios de       ',oFont05	,100)
	oPrn:say(1940,2710,'  trabaj. contratados a plazo fijo ',oFont05	,100)
	
	oPrn:say(1970,2710,'2 Cesación de los servicios        ',oFont05	,100)
	oPrn:say(1990,2710,'  prestados por el trabajador      ',oFont05	,100)
	
	oPrn:say(2020,2710,'3 Trabajadores afectos a subsidios ',oFont05	,100)
	oPrn:say(2040,2710,'  por incapacidad laboral          ',oFont05	,100)
	
	oPrn:say(2070,2710,'4 Trabajadores que estén afectos a ',oFont05	,100)
	oPrn:say(2090,2710,'  permiso sin goce de sueldo       ',oFont05	,100)
	
	oPrn:say(2120,2710,'5 Incorporación en el lugar de     ',oFont05	,100)
	oPrn:say(2140,2710,'  trabajo                          ',oFont05	,100)
	
	oPrn:say(2170,2710,'6 Iniciación de servicios de       ',oFont05	,100)
	oPrn:say(2190,2710,'  trabajadores contratados a plazo ',oFont05	,100)
	oPrn:say(2210,2710,'  o para una obra, trabajo o       ',oFont05	,100)
	oPrn:say(2230,2710,'  servicio determinado.            ',oFont05	,100)

	oPrn:say(2260,2710,'7 Transformación del contrato de   ',oFont05	,100)
	oPrn:say(2280,2710,'  plazo fijo a plazo indefinido    ',oFont05	,100)
	nNumerop:=nNumeCesp:=0


	oPrn:EndPage()     
	fPrintCapa(aTotAcum)
ElSEIF lValPrintCapa1	
	fPrintCapa(aTotAcum)
Endif	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona arq. por defecto en caso de que imprima meses anteriores ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ FIN DEL INFORME                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if nImpresos>0
	oPrn:Preview()
else
	Alert(STR0013) //"No se hallaron datos con esa AFP"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Normaliza Tablas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SRC")
dbSetOrder(1)


dbSelectArea("SRA")
dbClearFilter()
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
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCabec(aTotPag,aTotAcum,lLast)   // Cabecalho
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
nPagina++

If !lLast .Or. nNumerop=0
	oPrn:box(0150,0150,0200,0850)
	oPrn:box(0200,0150,0300,3100)
	oPrn:Line(0200,0550,0300,0550)
	oPrn:Line(0200,1550,0300,1550)
	oPrn:Line(0200,2100,0300,2100)
	
	oPrn:say(0050,0050,cNomeAFP												,oFont16b,100)
	oPrn:say(0050,0700,"DETALLE DE PAGO DE COTIZACIONES PREVISIONALES Y DEPOSITOS DE AHORRO VOLUNTARIO",oFont12b,100)
	oPrn:say(0100,0700,"                   FONDOS DE PENSIONES Y SEGURO DE CESANTIA                   ",oFont12b,100)
	oPrn:say(0150,0700,"                    (SOLO PARA TRABAJADORES DEPENDIENTES)                     ",oFont12 ,100)
	oPrn:say(0162,0160,'SECCION I.-IDENTIFICACION DEL EMPLEADOR'	,oFont08b,100)
	oPrn:say(0212,0160,'R.U.T.'												,oFont08	,100)
	oPrn:say(0212,0560,'Razón Social o Nombre'							,oFont08	,100)
	oPrn:say(0240,1560,'TIPO INGRESO'										,oFont06	,100)
	oPrn:say(0260,1560,'IMPONIBLE'											,oFont06	,100)
	oPrn:say(0212,1750,'REMUNERACION'										,oFont05	,100)
	oPrn:say(0212,1900,'GRATIFICACION'										,oFont05	,100)
	oPrn:box(0240,1790,0280,1840)
	oPrn:box(0240,1950,0280,1990)
	oPrn:say(0245,1795,'X'														,oFont08	,100)
	oPrn:say(0205,2150,'REMUNERACION DEL MES'								,oFont06	,100)
	oPrn:say(0230,2200,'Mes    Año'								,oFont05	,100)
	meses:={STR0014,STR0015,STR0016,STR0017,STR0018,STR0019,STR0020,STR0021,STR0022,STR0023,STR0024,STR0025} //'ENE'###'FEB'###'MAR'###'ABR'###'MAY'###'JUN'###'JUL'###'AGO'###'SEP'###'OCT'###'NOV'###'DIC'
	oPrn:say(0255,2200,MESES[MONTH(MV_PAR02)]+'/'+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont08	,100)
	oPrn:say(00240,2750,"Página : "+StrZero(nPagina,6)					,oFont08	,100)
	
	oPrn:say(0252,0160,transform(aInfo[8],Pesqpict('SRA','RA_CIC')),oFont10b,100)
	oPrn:say(0252,0560,aInfo[3]												,oFont10b,100)

	oPrn:say(LI,1156,Transform(aTotPag[1],"@e 99,999,999")	,oFont08	,100)
	oPrn:say(LI,1356,Transform(aTotPag[2],"@e 99,999,999")	,oFont08	,100)
	oPrn:say(LI,1556,Transform(aTotPag[3],"@e 99,999,999")	,oFont08	,100)
	oPrn:say(LI,1756,Transform(aTotPag[4],"@e 99,999,999")	,oFont08	,100)
	oPrn:say(LI,1956,Transform(aTotPag[5],"@e 99,999,999")	,oFont08	,100)
	oPrn:say(LI,2156,Transform(aTotPag[6],"@e 99,999,999")	,oFont08	,100)
	aTotAcum[1]	+=	aTotPag[1]
	aTotAcum[2]	+=	aTotPag[2]
	aTotAcum[3]	+=	aTotPag[3]
	aTotAcum[4]	+=	aTotPag[4]
	aTotAcum[5]	+=	aTotPag[5]		
	aTotAcum[6]	+=	aTotPag[6]		
	aFill(aTotPag,0)
	Li:=350
Endif
Return Nil


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³fPrintcapa³ Autor ³ Mauricio Contreras    ³ Data ³ 22.02.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imoresion de Hoja Resumen                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fPrintCapa(aTotAcum)
Local aTot
Local cNomRep,cRutRep,dCamRep    
Local aInfo	
Local Linea := 0

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
oPrn:StartPage()
/*/
for nCol:=1 to 3500 step 50
	oPrn:Line(  1600 ,nCol ,     2400,  nCol )
next
for Linea:=1600 to 2400 step 50
	oPrn:Line(Linea ,1    ,   Linea ,  3500 )
next
/*/
//Pergunte("INFAFP",.t.)


oPrn:Line(0150,0150,0150,0850)
oPrn:Line(0200,0150,0200,3100)
oPrn:Line(0300,0150,0300,3100)
oPrn:Line(0400,0150,0400,3100)
oPrn:Line(0500,0150,0500,3100)

oPrn:Line(0150,0150,0500,0150)
oPrn:Line(0150,0850,0200,0850)
oPrn:Line(0200,2150,0500,2150)
oPrn:Line(0200,2650,0500,2650)
oPrn:Line(0200,3100,0500,3100)

oPrn:say(0050,0050,cNomeAFP												,oFont16b,100)
oPrn:say(0050,0700,"DETALLE DE PAGO DE COTIZACIONES PREVISIONALES Y DEPOSITOS DE AHORRO VOLUNTARIO",oFont12b,100)
oPrn:say(0100,0700,"                   FONDOS DE PENSIONES Y SEGURO DE CESANTIA                   ",oFont12b,100)
oPrn:say(0150,0700,"                    (SOLO PARA TRABAJADORES DEPENDIENTES)                     ",oFont12 ,100)
oPrn:say(0162,0160,'SECCION I.-IDENTIFICACION DEL EMPLEADOR'	,oFont08b,100)
oPrn:say(0212,0160,'Razón Social o Nombre'							,oFont08	,100)
oPrn:say(0312,0160,'Dirección'											,oFont08	,100)
oPrn:say(0412,0160,'Nombre representante legal'						,oFont08	,100)
oPrn:say(0212,2160,'R.U.T.'												,oFont08	,100)
oPrn:say(0312,2160,'Comúna'												,oFont08	,100)
oPrn:say(0412,2160,'Rut Rep. Legal'										,oFont08	,100)
oPrn:say(0212,2660,'Cod. actividad económica'						,oFont08	,100)
oPrn:say(0312,2660,'Teléfono'												,oFont08	,100)
oPrn:say(0412,2660,'Cambios en Rep. Legal'							,oFont08	,100)

oPrn:say(0252,0160,aInfo[3]												,oFont10b,100)
oPrn:say(0352,0160,Substr(Alltrim(aInfo[4])+' '+;
									Alltrim(aInfo[14]),1,48)				,oFont10b,100)
oPrn:say(0452,0160,cNomRep													,oFont10b,100)
oPrn:say(0252,2160,transform(aInfo[8],Pesqpict('SRA','RA_CIC')),oFont10b,100)
oPrn:say(0352,2160,Substr(aInfo[13],1,25)								,oFont10b,100)
oPrn:say(0452,2160,transform(cRutRep,Pesqpict('SRA','RA_CIC'))	,oFont10b,100)
oPrn:say(0252,2660,cCodAct													,oFont10b,100)
oPrn:say(0352,2660,aInfo[10]												,oFont10b,100)
oPrn:say(0452,2660,dCamRep													,oFont10b,100)

/////////////////////////////////////////////////////////////////////////////////////////////////////////

oPrn:say(1010,0160,'NOTA: Si el número de trabajadores es mayor a 5 adjunte'	,oFont06,100)
oPrn:say(1030,0160,'      las hojas de detalle necesarias'							,oFont06,100)

/////////////////////////////////////////////////////////////////////////////////////////////////////////

oPrn:say(1060,0160,'SECCION III - RESUMEN DE COTIZACIONES Y DEPOSITOS DE AHORRO VOLUNTARIO'	,oFont08b,100)
oPrn:say(1110,0160,'SUBSECCION III.1 - FONDOS DE PENSIONES'	,oFont08b,100)
oPrn:say(1210,0160,'Cotización Obligatoria'					,oFont06	,100)
oPrn:say(1260,0160,'Depósitos en cuenta de Ahorro'			,oFont06	,100)
oPrn:say(1310,0160,'Sub total a Pagar fondos'				,oFont06	,100)
oPrn:say(1360,0160,'+ Reajuste fondos de pensiones'		,oFont06	,100)
oPrn:say(1410,0160,'+ Intereses fondos de pensiones'		,oFont06	,100)
oPrn:say(1460,0160,'Total a pagar fondos de pensiones'	,oFont06	,100)

oPrn:say(1160,0235,'DETALLE'										,oFont08,100)
oPrn:say(1160,0605,'COD',oFont06	,100)
oPrn:say(1155,0675,' VALORES  $'		,oFont06	,100)
oPrn:say(1175,0675,'(sin decimal)'	,oFont06	,100)
oPrn:say(1210,0610,'01'	,oFont08	,100)
oPrn:say(1260,0610,'02'	,oFont08	,100)
oPrn:say(1310,0610,'03'	,oFont08	,100)
oPrn:say(1360,0610,'04'	,oFont08	,100)
oPrn:say(1410,0610,'05'	,oFont08	,100)
oPrn:say(1460,0610,'10'	,oFont08	,100)

oPrn:say(1210,0660,Transform(aTotAcum[2],"@e 99,999,999"),oFont08	,100)
oPrn:say(1260,0660,Transform(aTotAcum[3],"@e 99,999,999"),oFont08	,100)
oPrn:say(1310,0660,Transform(aTotAcum[2]+aTotAcum[3],"@e 99,999,999"),oFont08	,100)
oPrn:say(1460,0660,Transform(aTotAcum[2]+aTotAcum[3],"@e 99,999,999"),oFont08	,100)

for Linea:=1100 to 1500 step 50
	oPrn:Line(Linea,0150,Linea,0850)
next
oPrn:Line(1100,0150,1500,0150)
oPrn:Line(1150,0600,1500,0600)
oPrn:Line(1150,0650,1500,0650)
oPrn:Line(1100,0850,1500,0850)



oPrn:say(1260,0860,'SUBSECCION III.2 - A.F.P.'	,oFont08b,100)
oPrn:say(1360,0860,'+ Recargo 20% Interes'					,oFont06	,100)
oPrn:say(1410,0860,'+ Costas de Cobranzas'					,oFont06	,100)
oPrn:say(1460,0860,'Total a pagar A.F.P.'						,oFont06	,100)

oPrn:say(1310,0935,'DETALLE'										,oFont08,100)
oPrn:say(1310,1155,'COD',oFont06	,100)
oPrn:say(1305,1225,' VALORES  $'		,oFont06	,100)
oPrn:say(1325,1225,'(sin decimal)'	,oFont06	,100)
oPrn:say(1360,1160,'56'	,oFont08	,100)
oPrn:say(1410,1160,'57'	,oFont08	,100)
oPrn:say(1460,1160,'60'	,oFont08	,100)

for Linea:=1250 to 1500 step 50
	oPrn:Line(Linea,0850,Linea,1400)
next
oPrn:Line(1250,0850,1500,0850)
oPrn:Line(1300,1150,1500,1150)
oPrn:Line(1300,1200,1500,1200)
oPrn:Line(1150,1400,1500,1400)


oPrn:say(1110,1410,'SUBSECCION III.3 - FONDOS DE CESANTIA'	,oFont08b,100)
oPrn:say(1210,1410,'Cotización Afiliado'						,oFont06	,100)
oPrn:say(1260,1410,'Cotización empleador'						,oFont06	,100)
oPrn:say(1310,1410,'Sub total a Pagar fondo'					,oFont06	,100)
oPrn:say(1360,1410,'+ Reajuste fondos de Cesantia'			,oFont06	,100)
oPrn:say(1410,1410,'+ Intereses fondos de Cesantia'		,oFont06	,100)
oPrn:say(1460,1410,'Total a pagar fondos Cesantia'			,oFont06	,100)

oPrn:say(1160,1485,'DETALLE'										,oFont08,100)
oPrn:say(1160,1855,'COD.',oFont06	,100)
oPrn:say(1155,1925,' VALORES  $'		,oFont06	,100)
oPrn:say(1175,1925,'(sin decimal)'	,oFont06	,100)
oPrn:say(1210,1860,'11'	,oFont08	,100)
oPrn:say(1260,1860,'12'	,oFont08	,100)
oPrn:say(1310,1860,'13'	,oFont08	,100)
oPrn:say(1360,1860,'14'	,oFont08	,100)
oPrn:say(1410,1860,'15'	,oFont08	,100)
oPrn:say(1460,1860,'20'	,oFont08	,100)

oPrn:say(1210,1905,Transform(aTotAcum[5],"@e 99,999,999"),oFont08	,100)
oPrn:say(1260,1905,Transform(aTotAcum[6],"@e 99,999,999"),oFont08	,100)
oPrn:say(1310,1905,Transform(aTotAcum[5]+aTotAcum[6],"@e 99,999,999"),oFont08	,100)
oPrn:say(1460,1905,Transform(aTotAcum[5]+aTotAcum[6],"@e 99,999,999"),oFont08	,100)

for Linea:=1100 to 1500 step 50
	oPrn:Line(Linea,1400,Linea,2100)
next
oPrn:Line(1100,1400,1500,1400)
oPrn:Line(1150,1850,1500,1850)
oPrn:Line(1150,1900,1500,1900)
oPrn:Line(1100,2100,1500,2100)



oPrn:say(1310,2110,'SUBSECCION III.4 - A.F.C.'	,oFont08b,100)
oPrn:say(1410,2110,'Costas de cobranza'		,oFont06	,100)
oPrn:say(1460,2110,'Total a pagar A.F.C.'			,oFont06	,100)

oPrn:say(1360,2185,'DETALLE'										,oFont08,100)
oPrn:say(1360,2405,'COD.',oFont06	,100)
oPrn:say(1355,2475,' VALORES  $'		,oFont06	,100)
oPrn:say(1375,2475,'(sin decimal)'	,oFont06	,100)
oPrn:say(1410,2410,'67'	,oFont08	,100)
oPrn:say(1460,2410,'70'	,oFont08	,100)

for Linea:=1300 to 1500 step 50
	oPrn:Line(Linea,2100,Linea,2650)
next
oPrn:Line(1300,2100,1500,2100)
oPrn:Line(1350,2400,1500,2400)
oPrn:Line(1350,2450,1500,2450)
oPrn:Line(1300,2650,1500,2650)


oPrn:Box(1100,2700,1500,3100)
oPrn:say(1120,2710,'1 Iniciación de servicios de       ',oFont05	,100)
oPrn:say(1140,2710,'  trabaj. contratados a plazo fijo ',oFont05	,100)

oPrn:say(1170,2710,'2 Cesación de los servicios        ',oFont05	,100)
oPrn:say(1190,2710,'  prestados por el trabajador      ',oFont05	,100)

oPrn:say(1220,2710,'3 Trabajadores afectos a subsidios ',oFont05	,100)
oPrn:say(1240,2710,'  por incapacidad laboral          ',oFont05	,100)

oPrn:say(1270,2710,'4 Trabajadores que estén afectos a ',oFont05	,100)
oPrn:say(1290,2710,'  permiso sin goce de sueldo       ',oFont05	,100)

oPrn:say(1320,2710,'5 Incorporación en el lugar de     ',oFont05	,100)
oPrn:say(1340,2710,'  trabajo                          ',oFont05	,100)

oPrn:say(1370,2710,'6 Iniciación de servicios de       ',oFont05	,100)
oPrn:say(1390,2710,'  trabajadores contratados a plazo ',oFont05	,100)
oPrn:say(1410,2710,'  o para una obra, trabajo o       ',oFont05	,100)
oPrn:say(1430,2710,'  servicio determinado.            ',oFont05	,100)

oPrn:say(1460,2710,'7 Transformación del contrato de   ',oFont05	,100)
oPrn:say(1480,2710,'  plazo fijo a plazo indefinido    ',oFont05	,100)

/////////////////////////////////////////////////////////////////////////////////////////////////////////



oPrn:Box(1550,0150,2150,1600)
oPrn:Box(1600,0200,2100,1550)

oPrn:say(1660,0210,'REMUNERACION'	,oFont08	,100)
oPrn:say(1710,0210,'DEL MES'			,oFont08	,100)
oPrn:Box(1700,0350,1750,0450)
oPrn:say(1710,0390,'X'			,oFont08	,100)


oPrn:say(1810,0210,'PERIODO'			,oFont08	,100)
oPrn:say(1760,0360,'MES    AÑO'		,oFont08	,100)
oPrn:Box(1800,0350,1850,0600)
meses:={'ENE','FEB','MAR','ABR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DIC'}
oPrn:say(1810,0360,MESES[MONTH(MV_PAR02)]+'/'+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont08	,100)



oPrn:say(1910,0210,'1.-NORMAL'		,oFont06	,100)
oPrn:say(1960,0210,'2.-ATRASADA'		,oFont06	,100)
oPrn:say(2010,0210,'3.-ADELANTADA'	,oFont06	,100)
oPrn:Box(1900,0400,2050,0450)
oPrn:Box(1950,0400,2000,0450)
oPrn:say(1910,0410,'X'	,oFont08	,100)

oPrn:say(1660,0500,'GRATIFICACIONES',oFont08	,100)
oPrn:Box(1700,0550,1750,0650)

oPrn:say(1930,0510,'N° Hojas'			,oFont08	,100)
oPrn:say(1960,0510,' Anexas'			,oFont08	,100)
oPrn:Box(2000,0500,2050,0600)
oPrn:say(2010,0510,strZero(nPagina,2),oFont08	,100)


oPrn:say(1710,0710,'DESDE'				,oFont08	,100)
oPrn:say(1660,0805,'Dia Mes Año'		,oFont08	,100)
oPrn:Box(1700,0800,1750,1000)
oPrn:say(1710,0805,'01'+SUBSTR(DTOC(MV_PAR02),3,6)	,oFont08	,100)

oPrn:say(1810,0710,'HASTA'				,oFont08	,100)
oPrn:say(1760,0805,'Dia Mes Año'		,oFont08	,100)
oPrn:Box(1800,0800,1850,1000)
oPrn:say(1810,0805,ALLTRIM(STR(F_ULTDIA(MV_PAR02)))+SUBSTR(DTOC(MV_PAR02),3,6)	,oFont08	,100)

oPrn:say(1910,0710,'F.Pago'			,oFont06	,100)
oPrn:say(1860,0805,'Dia Mes Año'		,oFont08	,100)
oPrn:Box(1900,0800,1950,1000)

oPrn:say(1680,1055,'Total remuneraciones'	,oFont06	,100)
oPrn:say(1705,1055,' o gratificaciones'	,oFont06	,100)
oPrn:say(1730,1055,'Fondos de Pensiones'	,oFont06	,100)
oPrn:Box(1750,1050,1800,1300)
oPrn:say(1760,1060,Transform(aTotAcum[1],"@e 99,999,999"),oFont08	,100)

oPrn:say(1880,1055,'Total remuneraciones'	,oFont06	,100)
oPrn:say(1905,1055,' o gratificaciones'	,oFont06	,100)
oPrn:say(1930,1055,' Fondos de Cesantia'	,oFont06	,100)
oPrn:Box(1950,1050,2000,1300)
oPrn:say(1960,1060,Transform(aTotAcum[4],"@e 99,999,999"),oFont08	,100)


oPrn:say(1680,1355,' N° afiliados'	,oFont06	,100)
oPrn:say(1705,1355,'  Informados'	,oFont06	,100)
oPrn:say(1730,1355,'Fdo. Pensiones'	,oFont06	,100)
oPrn:Box(1750,1400,1800,1500)
oPrn:say(1760,1410,Transform(nNumero,"@e 999"),oFont08	,100)


oPrn:say(1880,1355,' N° afiliados'	,oFont06	,100)
oPrn:say(1905,1355,'  Informados'	,oFont06	,100)
oPrn:say(1930,1355,'Fdo. Cesantia'	,oFont06	,100)
oPrn:Box(1950,1400,2000,1500)
oPrn:say(1960,1410,Transform(nNumeces,"@e 999"),oFont08	,100)

oPrn:say(1560,0160,'SECCION IV - ANTECEDENTES GENERALES '	,oFont08b	,100)
oPrn:say(1610,0210,'TIPO DE INGRESO IMPONIBLE'	,oFont08b	,100)


/////////////////////////////////////////////////////////////////////////////////////////////////////////
oPrn:say(1560,1710,'SECCION V - ANTECEDENTES SOBRE EL PAGO '	,oFont08b	,100)
oPrn:Line(1550,1650,1550,3100)
oPrn:Line(2200,1650,2200,3100)
oPrn:Line(1550,1650,2200,1650)
oPrn:Line(1550,3100,2200,3100)



oPrn:say(1610,1710,'SUBSECCION V.1 - ANTECEDENTES SOBRE EL PAGO A LOS FONDOS DE PENSIONES'	,oFont08	,100)
oPrn:Line(1600,1675,1600,3075)
oPrn:Line(1875,1675,1875,3075)
oPrn:Line(1600,1675,1875,1675)
oPrn:Line(1600,3075,1875,3075)


// Fondos de Pensiones

oPrn:say(1660,1710,'Fondos de Pensiones'  ,oFont08b	,100)
oPrn:say(1710,1710,'Efectivo'					,oFont06 	,100)
oPrn:say(1710,1950,'Cheque'					,oFont06 	,100)
oPrn:say(1710,2150,'N°'    					,oFont06 	,100)
oPrn:say(1760,1710,'Banco'						,oFont06 	,100)
oPrn:say(1760,2100,'Plaza'						,oFont06 	,100)
oPrn:say(1810,1710,'Girar cheque nominativo a: Fondos de Pensiones'	,oFont06 	,100)
oPrn:say(1830,1710,'                           '+cnomeAfp	,oFont06 	,100)

oPrn:Line(1650,1700,1650,2350)
oPrn:Line(1850,1700,1850,2350)
oPrn:Line(1650,1700,1850,1700)
oPrn:Line(1650,2350,1850,2350)

oPrn:Line(1700,1850,1700,1900)
oPrn:Line(1750,1850,1750,1900)
oPrn:Line(1700,1850,1750,1850)
oPrn:Line(1700,1900,1750,1900)

oPrn:Line(1700,2050,1700,2100)
oPrn:Line(1750,2050,1750,2100)
oPrn:Line(1700,2050,1750,2050)
oPrn:Line(1700,2100,1750,2100)

oPrn:Line(1750,2200,1750,2345)
oPrn:Line(1800,1800,1800,2100)
oPrn:Line(1800,2200,1800,2345)

// A.F.P.

oPrn:say(1660,2410,'A.F.P.'	,oFont08b	,100)
oPrn:say(1710,2410,'Efectivo'	,oFont06 	,100)
oPrn:say(1710,2650,'Cheque'	,oFont06 	,100)
oPrn:say(1710,2850,'N°'    	,oFont06 	,100)
oPrn:say(1760,2410,'Banco'		,oFont06 	,100)
oPrn:say(1760,2800,'Plaza'		,oFont06 	,100)
oPrn:say(1810,2410,'Girar cheque nominativo a: AFP '+cnomeAfp	,oFont06 	,100)

oPrn:Line(1650,2400,1650,3050)
oPrn:Line(1850,2400,1850,3050)
oPrn:Line(1650,2400,1850,2400)
oPrn:Line(1650,3050,1850,3050)



oPrn:Line(1700,2550,1700,2600)
oPrn:Line(1750,2550,1750,2600)
oPrn:Line(1700,2550,1750,2550)
oPrn:Line(1700,2600,1750,2600)

oPrn:Line(1700,2750,1700,2800)
oPrn:Line(1750,2750,1750,2800)
oPrn:Line(1700,2750,1750,2750)
oPrn:Line(1700,2800,1750,2800)

oPrn:Line(1750,2900,1750,3045)
oPrn:Line(1800,2500,1800,2800)
oPrn:Line(1800,2900,1800,3045)



oPrn:say(1910,1710,'SUBSECCION V.2 - ANTECEDENTES SOBRE EL PAGO A LOS FONDOS DE CESANTIA'	,oFont08	,100)
oPrn:Line(1900,1675,1900,3075)
oPrn:Line(2175,1675,2175,3075)
oPrn:Line(1900,1675,2175,1675)
oPrn:Line(1900,3075,2175,3075)

// Fondos de Cesantia

oPrn:say(1960,1710,'Fondos de Cesantia'	,oFont08b	,100)
oPrn:say(2010,1710,'Efectivo'					,oFont06 	,100)
oPrn:say(2010,1950,'Cheque'					,oFont06 	,100)
oPrn:say(2010,2150,'N°'    					,oFont06 	,100)
oPrn:say(2060,1710,'Banco'						,oFont06 	,100)
oPrn:say(2060,2100,'Plaza'						,oFont06 	,100)
oPrn:say(2110,1710,'Girar cheque nominativo a: Fondos de Cesantia'	,oFont06 	,100)

oPrn:Line(1950,1700,1950,2350)
oPrn:Line(2150,1700,2150,2350)
oPrn:Line(1950,1700,2150,1700)
oPrn:Line(1950,2350,2150,2350)

oPrn:Line(2000,1850,2000,1900)
oPrn:Line(2050,1850,2050,1900)
oPrn:Line(2000,1850,2050,1850)
oPrn:Line(2000,1900,2050,1900)

oPrn:Line(2000,2050,2000,2100)
oPrn:Line(2050,2050,2050,2100)
oPrn:Line(2000,2050,2050,2050)
oPrn:Line(2000,2100,2050,2100)

oPrn:Line(2050,2200,2050,2345)
oPrn:Line(2100,1800,2100,2100)
oPrn:Line(2100,2200,2100,2345)

// A.F.C.

oPrn:say(1960,2410,'A.F.C.'	,oFont08b	,100)
oPrn:say(2010,2410,'Efectivo'	,oFont06 	,100)
oPrn:say(2010,2650,'Cheque'	,oFont06 	,100)
oPrn:say(2010,2850,'N°'    	,oFont06 	,100)
oPrn:say(2060,2410,'Banco'		,oFont06 	,100)
oPrn:say(2060,2800,'Plaza'		,oFont06 	,100)
oPrn:say(2110,2410,'Girar cheque nominativo a: AFC CHILE S.A.'	,oFont06 	,100)

oPrn:Line(1950,2400,1950,3050)
oPrn:Line(2150,2400,2150,3050)
oPrn:Line(1950,2400,2150,2400)
oPrn:Line(1950,3050,2150,3050)



oPrn:Line(2000,2550,2000,2600)
oPrn:Line(2050,2550,2050,2600)
oPrn:Line(2000,2550,2050,2550)
oPrn:Line(2000,2600,2050,2600)

oPrn:Line(2000,2750,2000,2800)
oPrn:Line(2050,2750,2050,2800)
oPrn:Line(2000,2750,2050,2750)
oPrn:Line(2000,2800,2050,2800)

oPrn:Line(2050,2900,2050,3045)
oPrn:Line(2100,2500,2100,2800)
oPrn:Line(2100,2900,2100,3045)


///////////////////////////////////////////////////////////////////////////////////
oPrn:Line(2250,0150,2250,1600)
oPrn:Line(2390,0150,2390,1600)
oPrn:Line(2250,0150,2390,0150)
oPrn:Line(2250,1600,2390,1600)
oPrn:say(2260,0160,'Declaro bajo juramento que los datos consignados son'	,oFont06 	,100)
oPrn:say(2290,0160,'expresión fiel de la realidad'									,oFont06 	,100)
oPrn:Line(2350,1050,2350,1600)
oPrn:say(2370,1050,'Firma del empleador o Representante Legal'					,oFont06 	,100)

oPrn:Line(2250,1650,2250,2350)
oPrn:Line(2390,1650,2390,2350)
oPrn:Line(2250,1650,2390,1650)
oPrn:Line(2250,2350,2390,2350)
oPrn:say(2370,1850,'V°B° Recepción y Cálculo'	,oFont06 	,100)

oPrn:Line(2250,2400,2250,3100)
oPrn:Line(2390,2400,2390,3100)
oPrn:Line(2250,2400,2390,2400)
oPrn:Line(2250,3100,2390,3100)
oPrn:say(2370,2600,'V°B° y Timbre Cajero'	,oFont06 	,100)


seccion2(550,450)
oPrn:EndPage()
Return





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Seccion2  ³ Autor ³ Mauricio Contreras    ³ Data ³ 04.07.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Desc.     ³ Imprime el encabezado de la seccion 2                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxis  ³ Seccion2(Largo)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Largo: Largo de las lineas verticales                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ INFAFP                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Seccion2(linea,Largo)

oPrn:line(linea    ,0150,linea    ,3100)
oPrn:line(linea+050,0150,linea+050,3100)
oPrn:line(linea+100,0250,linea+100,1150)

oPrn:line(linea+150,0200,linea+150,0250)
oPrn:line(linea+150,0500,linea+150,0550)
oPrn:line(linea+150,1100,linea+150,1150)
oPrn:line(linea+150,1300,linea+150,1350)
oPrn:line(linea+150,1500,linea+150,1550)
oPrn:line(linea+150,1700,linea+150,1750)
oPrn:line(linea+150,1900,linea+150,1950)
oPrn:line(linea+150,2100,linea+150,2150)
oPrn:line(linea+150,2300,linea+150,2350)
oPrn:line(linea+200,0150,linea+200,3100)

oPrn:Line(linea	 ,0150,linea+largo,0150)
oPrn:Line(linea+050,0250,linea+largo,0250)
oPrn:Line(linea+100,0550,linea+largo,0550)
oPrn:Line(linea    ,1150,linea+largo,1150)
oPrn:Line(linea+050,1350,linea+largo,1350)
oPrn:Line(linea+050,1550,linea+largo,1550)
oPrn:Line(linea    ,1750,linea+largo,1750)
oPrn:Line(linea+050,1950,linea+largo,1950)
oPrn:Line(linea+050,2150,linea+largo,2150)
oPrn:Line(linea    ,2350,linea+largo,2350)
oPrn:Line(linea+050,2400,linea+largo,2400)
oPrn:Line(linea+050,2600,linea+largo,2600)
oPrn:Line(linea+050,2800,linea+largo,2800)
oPrn:Line(linea    ,3100,linea+largo,3100)

oPrn:line(linea+150,0200,linea+200,0200)
oPrn:line(linea+150,0500,linea+200,0500)
oPrn:line(linea+150,1100,linea+200,1100)
oPrn:line(linea+150,1300,linea+200,1300)
oPrn:line(linea+150,1500,linea+200,1500)
oPrn:line(linea+150,1700,linea+200,1700)
oPrn:line(linea+150,1900,linea+200,1900)
oPrn:line(linea+150,2100,linea+200,2100)
oPrn:line(linea+150,2300,linea+200,2300)

oPrn:line(linea+largo,0150,linea+largo,3100)

oPrn:line(linea+largo+50,0900,linea+largo+50,2350)
oPrn:line(linea+largo   ,0900,linea+largo+50,0900)
oPrn:line(linea+largo   ,1150,linea+largo+50,1150)
oPrn:line(linea+largo   ,1350,linea+largo+50,1350)
oPrn:line(linea+largo   ,1550,linea+largo+50,1550)
oPrn:line(linea+largo   ,1750,linea+largo+50,1750)
oPrn:line(linea+largo   ,1950,linea+largo+50,1950)
oPrn:line(linea+largo   ,2150,linea+largo+50,2150)
oPrn:line(linea+largo   ,2350,linea+largo+50,2350)


oPrn:Say(linea+largo+10,915,"Total Página",oFont08,100)

oPrn:Say(linea+12,162,"SECCION II-DETALLE DE COTIZACIONES Y DEPOSITOS VOLUNTARIOS",oFont08b,100)
oPrn:Say(linea+12,1300,"FONDO DE PENSIONES",oFont09,100)
oPrn:Say(linea+12,1900,"SEGURO DE CESANTIA",oFont09,100)
oPrn:Say(linea+12,2450,"MOV. EN LOS REGISTROS DEL PERSONAL",oFont08,100)

oPrn:Say(linea+050+12,0160,"Nro."								,oFont09,100)
oPrn:Say(linea+050+12,0375,"IDENTIFICACION DEL AFILIADO"	,oFont09,100)
oPrn:Say(linea+050+12,1151,"REMUNERACION"						,oFont06,100)
oPrn:Say(linea+050+12,1359,"Cotización"						,oFont08,100)
oPrn:Say(linea+050+12,1559,"Dep.Cuenta"						,oFont08,100)
oPrn:Say(linea+050+12,1751,"REMUNERACION"						,oFont06,100)
oPrn:Say(linea+050+12,1959,"Cotización"						,oFont08,100)
oPrn:Say(linea+050+12,2159,"Cotización"						,oFont08,100)
oPrn:Say(linea+050+12,2355,"C"									,oFont10,100)
oPrn:Say(linea+050+12,2455,"Fecha"								,oFont09,100)
oPrn:Say(linea+050+12,2655,"Fecha"								,oFont09,100)
oPrn:Say(linea+050+12,2815,"R.U.T. Entidad"					,oFont09,100)

oPrn:Say(linea+100+12,0160,"SEC."								,oFont09,100)
oPrn:Say(linea+100+12,0275,"R.U.T. o C.I."					,oFont09,100)
oPrn:Say(linea+100+12,0700,"NOMBRE AFILIADO"					,oFont09,100)
oPrn:Say(linea+100+12,1150," IMPONIBLE"						,oFont08,100)
oPrn:Say(linea+100+12,1355,"Obligatoria"						,oFont08,100)
oPrn:Say(linea+100+12,1555,"de Ahorro "						,oFont08,100)
oPrn:Say(linea+100+12,1750," IMPONIBLE"						,oFont08,100)
oPrn:Say(linea+100+12,1955," Afiliado" 						,oFont08,100)
oPrn:Say(linea+100+12,2155," Empleador" 						,oFont08,100)
oPrn:Say(linea+100+12,2355,"O"									,oFont10,100)
oPrn:Say(linea+100+12,2455,"Inicio"								,oFont09,100)
oPrn:Say(linea+100+12,2645,"Termino"							,oFont09,100)
oPrn:Say(linea+100+12,2815,"  Pagadora"						,oFont09,100)



oPrn:Say(linea+150+12,0220,"1"									,oFont08,100)
oPrn:Say(linea+150+12,0255,"(C/dig. verif.)"					,oFont06,100)
oPrn:Say(linea+150+12,0520,"2"									,oFont08,100)
oPrn:Say(linea+150+12,1120,"3"									,oFont08,100)
oPrn:Say(linea+150+12,1225,"$"									,oFont08,100)
oPrn:Say(linea+150+12,1320,"4"									,oFont08,100)
oPrn:Say(linea+150+12,1425,"$"									,oFont08,100)
oPrn:Say(linea+150+12,1520,"5"									,oFont08,100)
oPrn:Say(linea+150+12,1625,"$"									,oFont08,100)
oPrn:Say(linea+150+12,1720,"6"									,oFont08,100)
oPrn:Say(linea+150+12,1825,"$"									,oFont08,100)
oPrn:Say(linea+150+12,1920,"7"									,oFont08,100)
oPrn:Say(linea+150+12,2025,"$"									,oFont08,100)
oPrn:Say(linea+150+12,2120,"8"									,oFont08,100)
oPrn:Say(linea+150+12,2225,"$"									,oFont08,100)
oPrn:Say(linea+150+12,2320,"9"									,oFont08,100)
oPrn:Say(linea+150+12,2355,"D"									,oFont10,100)
oPrn:Say(linea+150+12,2410,"Día/Mes/Año"						,oFont08,100)
oPrn:Say(linea+150+12,2610,"Día/Mes/Año"						,oFont08,100)
oPrn:Say(linea+150+12,2815,"  Subsidios"						,oFont09,100)





Return


  
  
