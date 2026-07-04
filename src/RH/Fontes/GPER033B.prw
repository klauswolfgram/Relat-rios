/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#include "INKEY.CH"
#include "GPER033B.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcion   ³ GPER033B ³ Autor ³ Francisco Guerrero    ³ Data ³ 31.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip   ³ Planilla de Cotizaciones de AFP                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ INFOAFPb()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Liquidaciones                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ACTUALIZACIONES SUFRIDAS DESDE SU CREACION INICIAL.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Fecha  ³ BOPS ³  Motivo de la modificacion               ³±±
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
±±³R.Berti	    ³16/05/2012³TEYTER		 	³Ajuste tamanho do campo X69_LIMITE p/CHILE.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function GPER033B()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define las variables Locales                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString:="SRA"
Local aOrd   := {STR0001,STR0002,STR0003}  //"Matricula"###"Centro de Costo"###"Nombre"
Local cDesc1 := STR0004 //"Informe de planilla de Cotizaciones AFP"
Local cDesc2 := STR0005 //"Sera impreso de acuerdo a los parametros"
Local cDesc3 := STR0006 //"informados por el usuario"
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define las variabless privadas                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0007, 1,STR0008, 2, 2, 1, "",1 } //"Zebrado"###"Administracion"
Private nomeprog :="GPER033B"
Private nLastKey := 0
Private cPerg    :="GPR33B"
//Private cPerg    :="AFP004"
Private nPagina  :=	0
Private Li     := 1950
Private Titulo := STR0009		 //"Planilla de AFP"
Private cAFP, dDataRef, cFilDe, cFilAte, cCcDe, cCcAte, cMatDe,cMatAte    
Private cNomDe, cNomAte, ChapaDe, ChapaAte,cSituacao,cCategoria,cMesAnoRef,nJuros,nReajus

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica las preguntas seleccionadas                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("GPR33B",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia control para la funcion SETPRINT                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//wnrel:="GPER033" 
//wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,"P")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define el Orden del Informe                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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


RptStatus({|lEnd| ImpAFP(@lEnd,cMesAnoRef)},Titulo)

Set Device To Screen
MS_FLUSH()

Return( NIL )
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcion   ³ IMPAFP   ³ Autor ³ Francisco Guerrero    ³ Data ³ 31.10.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip   ³ Procesamiento para emision de la planilla de aFP           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ IMPAFP(lEnd,WnRel,cString,cMesAnoRef)                  	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function IMPAFP(lEnd,cMesAnoRef)
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
Local nNumero   := 0
 
Private cAliasMov := ""
Private cNomeAFP,	nAlqObrig, cCodObrig1, cCodObrig2, cCodVol, cCodCot, cCodBase,	cSegBase, cSegAfil, cSegEmpre, nLimUM
Private 	nContPag01:=0
Private  nContAcum01:=0

aTotPag     := {0,0,0,0,0,0,0}
aTotAcum    := {0,0,0,0,0,0,0}
meses2:={STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,STR0017,STR0019,STR0019,STR0020,STR0021} //'ENE'###'FEB'###'MAR'###'ABR'###'MAY'###'JUN'###'JUL'###'AGO'###'OCT'###'NOV'###'DIC'
 

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

//******************************************
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
	Help("",1,"NOVALIDO","","Tabla de AFP no encontrada",1)
	Return	.F.
Endif

If FPHIST82(xFilial("SRX") , "62" , MesAno(dDataBase)+cAFP+"2" ).Or. FPHIST82(xFilial("SRX") , "62" , "      "+cAFP+"2"  )
	cRutAFP		:= SubStr( SRX->RX_TXT ,  1 , 9) 
Else
	Help("",1,"NOVALIDO","","Tabla de AFP no encontrada",1)
	Return	.F.
Endif

If FPHIST82(xFilial("SRX") , "69" , MesAno(dDataBase)) .Or. FPHIST82(xFilial("SRX") , "69" , "      ")
	cSegEmpre:= SubStr( SRX->RX_TXT ,   5 , 3 )        //Concepto empresa
	cSegAfil := SubStr( SRX->RX_TXT ,   12 , 3 )       //Concepto afiliado
	cSegBase := SubStr( SRX->RX_TXT ,   19 , 3 )       //Concepto base
	nLimSC   := Val( SubStr( SRX->RX_TXT ,   22 , 5 ) )//Limite en UF para base
Else
	Help("",1,"NOVALIDO","","Tabla de Seguro cesantia no encontrada",1)
	Return	.F.
Endif

//******************************************
dbSelectArea("SRA")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carga Regua de Procesamiento                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
 
aLetras:={"Arial","Courier New","Times New Roman"}
Letra:=2

oFont04  := TFont():New( aLetras[Letra] ,,04,,.f.,,,,,.f. )  
oFont05  := TFont():New( aLetras[Letra] ,,05,,.f.,,,,,.f. )  
oFont06  := TFont():New( aLetras[Letra] ,,06,,.f.,,,,,.f. )  
oFont07  := TFont():New( aLetras[Letra] ,,07,,.f.,,,,,.f. )  
oFont08  := TFont():New( aLetras[Letra] ,,08,,.f.,,,,,.f. )  
oFont09  := TFont():New( aLetras[Letra] ,,09,,.f.,,,,,.f. )  
oFont10  := TFont():New( aLetras[Letra] ,,10,,.f.,,,,,.f. )
oFont11  := TFont():New( aLetras[Letra] ,,11,,.f.,,,,,.f. )
oFont12  := TFont():New( aLetras[Letra] ,,12,,.f.,,,,,.f. )
oFont14  := TFont():New( aLetras[Letra] ,,14,,.f.,,,,,.f. )
oFont16  := TFont():New( aLetras[Letra] ,,16,,.f.,,,,,.f. )
oFont04b := TFont():New( aLetras[Letra] ,,04,,.t.,,,,,.f. )  
oFont05b := TFont():New( aLetras[Letra] ,,05,,.t.,,,,,.f. )  
oFont06b := TFont():New( aLetras[Letra] ,,06,,.t.,,,,,.f. )  
oFont07b := TFont():New( aLetras[Letra] ,,07,,.t.,,,,,.f. )  
oFont08b := TFont():New( aLetras[Letra] ,,08,,.t.,,,,,.f. )// negrita.
oFont09b := TFont():New( aLetras[Letra] ,,09,,.t.,,,,,.f. )// negrita
oFont10b := TFont():New( aLetras[Letra] ,,10,,.t.,,,,,.f. )// negrita.
oFont11b := TFont():New( aLetras[Letra] ,,11,,.t.,,,,,.f. )// negrita.
oFont12b := TFont():New( aLetras[Letra] ,,12,,.t.,,,,,.f. )// negrita.
oFont14b := TFont():New( aLetras[Letra] ,,14,,.t.,,,,,.f. )
oFont16b := TFont():New( aLetras[Letra] ,,16,,.t.,,,,,.f. )// negrita.

oIsapre := TFont():New( "Arial",,16,,.t.,,,,,.f. )// negrita.

oPrn:= TMSPrinter():New() ///?????????
oPrn:Setlandscape()
oPrn:Setup()


cFilialAnt := Space(FWGETTAMFILIAL)
nPagina:=0
If SRA->( EOF() )
   Return
Else
  oPrn:StartPage()   
EndIF
nImpresos:=0

While SRA->( !Eof() .And. &cInicio <= cFim )
 	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mueve Regua de Procesamiento                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Incregua(SRA->RA_FILIAL+" - "+SRA->RA_MAT+" - "+SRA->RA_NOME)
	  
	If lEnd
		@Prow()+1,0 PSAY "Abortado por el operador"
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
	//³ Revisa situacio y categoria de los funcionarios			     ³
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
		nImpresos++
		If Li > 1940 
			fCabec(@aTotPag,@aTotAcum,.F.)
			Li:=410	
		Endif	
		oPrn:say(LI,0103,StrZero(nNumero,3)									,oFont07	,100)
		oPrn:say(LI,0160,TRANSFORM(SRA->RA_CIC,PesqPict('SRA','RA_CIC')),oFont07	,100)
		oPrn:say(LI,0410,Substr(SRA->RA_NOME,1,26)								,oFont06	,100)
		oPrn:say(LI,1010,Transform(nValBase		,"@e 99,999,999")	,oFont08	,100)
		oPrn:say(LI,1260,Transform(nValCot		,"@e 99,999,999")	,oFont08	,100)
		aTotPag[1]	+=	nValBase  // Remu Imp
		aTotPag[2]	+=	nValCot//nValObrig // Obligat
		aTotPag[3]	+=	0//nValVol   // Cta Ahorro
		aTotPag[4]	+=	0//nSegBase  // Impo seguro
		aTotPag[5]	+=	0//nSegAfil  // Seguro Empleado
		aTotPag[6]	+=	0//nSegEmpre // Seguro Empresa
		aTotPag[7]++
		Li+=50			
		aTotAcum[1]	+=	nValBase  // Remu Imp
	   aTotAcum[2]	+=	nValCot//nValObrig // Obligat
	   aTotAcum[3]	+=	0//nValVol   // Cta Ahorro
	   aTotAcum[4]	+=	0//nSegBase  // Impo seguro
	   aTotAcum[5]	+=	0//nSegAfil  // Seguro Empleado
	   aTotAcum[6]	+=	0//nSegEmpre // Seguro Empresa  
	   nContPag01++
      nContAcum01++
	Endif	
	dbSelectArea("SRA")
	SRA->( dbSkip() )
EndDo
lin:=li-350
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impirmir total de la ultima pagina y GRAL.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aTotPag[1]+aTotPag[2]+aTotPag[3]+aTotPag[4]+aTotPag[5]+aTotPag[6] > 0

   oPrn:say(0180,0420,transform(aInfo[8],Pesqpict('SRA','RA_CIC')),oFont07b,100)//rut empresa
   oPrn:say(0180,1120,aInfo[3]												,oFont07b,100)//nombre empresa

	oPrn:say(1960,1010,Transform(aTotPag[1],"@e 999,999,999")	,oFont07	,100)
	oPrn:say(1960,1260,Transform(aTotPag[2],"@e 999,999,999")	,oFont07	,100)
	oPrn:say(2060,1010,Transform(aTotAcum[1],"@e 999,999,999")	,oFont07	,100)
	oPrn:say(2060,1260,Transform(aTotAcum[2],"@e 999,999,999")	,oFont07	,100)

	oPrn:say(2260,1020,Transform(nContPag01,"@e 9,999")	,oFont07	,100)
	oPrn:say(2260,1260,Transform(nContAcum01,"@e 9,999")	,oFont07	,100)

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
	Alert(STR0022) //"No se hallaron datos con esa AFP"
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
Local i := 0

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

If nPagina > 1  .or. lLast
	oPrn:say(1960,1010,Transform(aTotPag[1],"@e 99,999,999")	,oFont07	,100)
	oPrn:say(1960,1260,Transform(aTotPag[2],"@e 99,999,999")	,oFont07	,100)
	oPrn:say(2060,1010,Transform(aTotAcum[1],"@e 99,999,999")	,oFont07	,100)
	oPrn:say(2060,1260,Transform(aTotAcum[2],"@e 99,999,999")	,oFont07	,100)
	
	oPrn:say(2260,1020,Transform(nContPag01,"@e 9,999")	,oFont07	,100)
	oPrn:say(2260,1260,Transform(nContAcum01,"@e 9,999")	,oFont07	,100)

	
	oPrn:EndPage()         
Endif	
	
If !lLast .Or. Li > 1940
	
	oPrn:StartPage()
	
	//*****************************************************************
	//05/11/2002 Francisco Guerrero
	
	//**************************************************
	/////////////////////seccion II ////////////////
	
	oPrn:say(0030,0880,"HOJA DE DETALLE PARA EL PAGO DE COTIZACIONES VOLUNTARIAS,"  ,oFont11b,100)
	oPrn:say(0070,0950,"DEPOSITOS CONVENIDOS Y APORTES DE INDEMNIZACION",oFont11b,100)
	oPrn:say(0110,1250,"FONDOS DE PENSIONES"                            ,oFont11b,100)
	oPrn:say(0120,0100,cNomeAFP												     ,oFont14b,100)
	
	/////////////////
	
	oPrn:Box(0170,0400,0220,0750)  
	oPrn:say(0180,0160,'R.U.T. Empleador'									,oFont05b	,100)
	oPrn:say(0180,0420,transform(aInfo[8],Pesqpict('SRA','RA_CIC')),oFont07b,100)//rut empresa
	oPrn:Box(0170,1100,0220,2200)  
	oPrn:say(0180,0860,'Nombre o Razon Social'							,oFont05b	,100)
	oPrn:say(0180,1120,aInfo[3]												,oFont07b,100)//nombre empresa
	oPrn:Box(0170,2400,0220,2600)  
	oPrn:say(0130,2400,'REMUNERACIONES DEL MES'							,oFont05b	,100)    
	oPrn:say(0145,2400,'MES    AÑO'		,oFont04b	,100)
	oPrn:say(0180,2420,MESES2[MONTH(MV_PAR02)]+'/'+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont07	,100)
	
	oPrn:Box(0170,2700,0220,3000)  
	oPrn:say(0190,2730,'Pagina______'							,oFont05b	,100)
	oPrn:say(0187,2790,STRZERO(nPagina,3)   ,oFont07, 100)
	
	
	oPrn:Box(0270,0100,0300,3000)
	oPrn:Box(0300,0100,0400,3000)
	oPrn:Box(0300,0100,1950,0150)
	oPrn:Box(0300,0150,0350,1000)
	oPrn:Box(0350,0150,1950,0400)
	oPrn:Box(0350,0400,1950,1000)
	
	//fondos de pensiones
	oPrn:Box(0300,1000,2000,1250)
	oPrn:Box(0300,1250,2000,1500)
	oPrn:Box(0300,1500,2000,1750)
	
	//cuentas de indemnizacion
	oPrn:Box(0300,1750,0330,3000)
	oPrn:Box(0330,1750,2000,1950)
	oPrn:Box(0330,1950,1950,2150)
	oPrn:Box(0330,2150,1950,2300)
	oPrn:Box(0330,2300,2000,2550)
	
	//periodos anteriores a la fecha del pacto
	oPrn:Box(0330,2550,0360,3000)
	oPrn:Box(0360,2550,1950,2700)
	oPrn:Box(0360,2700,1950,2850)
	oPrn:Box(0360,2850,1950,3000)
	
	For i:= 400 to 1950 step 50
	     oPrn:Line(i,0100,i,3000)
	next
	
	oPrn:say(0275,0150,'SECCION II.-DETALLE DE COTIZACIONES, DEPOSITOS Y APORTES'	,oFont06b	,100)   //Titulo
	oPrn:say(0275,2100,'FONDOS DE PENSIONES'						   	     ,oFont06b	,100)//titulo
	
	oPrn:say(0320,0160,'IDENTIFICACION DEL AFILIADO'						  ,oFont06b	,100)//titulo
	
	oPrn:say(0355,0160,'R.U.T. o C.I. '			                          ,oFont04b	,100)
	oPrn:say(0370,0155,'(con digito verificador)'			              ,oFont04b	,100)
	oPrn:say(0360,0410,'APELLIDO PATERNO, APELLIDO MATERNO y NOMBRES'	  ,oFont05b	,100)
	
	oPrn:say(0340,1020,'REMUNERACION'											  ,oFont05b	,100)
	oPrn:say(0360,1020,'IMPONIBLE'												  ,oFont05b	,100)
	oPrn:say(0340,1270,'COTIZACION'												  ,oFont05b	,100)
	oPrn:say(0360,1270,'VOLUNTARIA'										        ,oFont05b	,100)
	oPrn:say(0340,1520,'DEPOSITO'						                       ,oFont05b	,100)
	oPrn:say(0360,1520,'CONVENIO $'												  ,oFont05b	,100)
	     
	oPrn:say(0305,2350,'CUENTA DE INDEMNIZACION'							,oFont06b	,100)//titulo
	oPrn:say(0350,1760,'REMUNERACION'							         ,oFont05b	,100)
	oPrn:say(0375,1760,'IMPONIBLE'							            ,oFont05b	,100)
	oPrn:say(0350,1960,'REGIMEN'							               ,oFont05b	,100)
	oPrn:say(0375,1960,'PREVISIONAL'							            ,oFont05b	,100)
	oPrn:say(0350,2160,'TASA'							                  ,oFont05b	,100)
	oPrn:say(0375,2160,'PACTADA'							               ,oFont05b	,100)
	oPrn:say(0350,2310,'APORTE'							               ,oFont05b	,100)
	oPrn:say(0375,2310,'INDEMNIZACION $'							      ,oFont05b	,100)
	     
	oPrn:say(0335,2560,'PERIODOS ANTERIORES A LA FECHA DEL PACTO'	,oFont05b	,100)//titulo
	oPrn:say(0365,2555,'N° PERIODOS'							            ,oFont05b	,100)
	oPrn:say(0362,2710,'DESDE'							                  ,oFont05b	,100)
	oPrn:say(0380,2710,'Dia/Mes/Año'							            ,oFont04b	,100)
	oPrn:say(0362,2860,'HASTA'							                  ,oFont05b	,100)
	oPrn:say(0380,2860,'Dia/Mes/Año'							            ,oFont04b	,100)
	oPrn:say(1960,0780,'TOTAL PAGINA'							      ,oFont06b	,100)
	oPrn:say(1960,2100,'01: Antiguo Regimen'							,oFont04b	,100)
	oPrn:say(1980,2100,'02: Nuevo Regimen'							   ,oFont04b	,100)
	oPrn:Line(1950,2030,1980,2030)
	oPrn:Line(1980,2030,1980,2070)
	
	oPrn:Box(2050,1000,2100,1950)
	oPrn:Line(2050,1250,2100,1250)
	oPrn:Line(2050,1500,2100,1500)
	oPrn:Line(2050,1750,2100,1750)
	oPrn:say(2060,0780,'TOTAL ACUMULADO'							      ,oFont06b	,100)
	
	oPrn:Box(2050,2300,2100,2550)
	
	oPrn:Box(2050,0100,2300,0700)
	oPrn:say(2060,0170,'DECLARO BAJO JURAMENTO QUE LOS ANTECEDENTES'		     ,oFont05b	,100)
	oPrn:say(2085,0170,'CONSIGNADOS SON EXPRESION FIEL DE LA REALIDAD'	     ,oFont05b	,100)
	oPrn:Line(2230,0180,2230,600)
	oPrn:say(2240,0200,'Firma del Empleador o Representante Legal'	     ,oFont05	,100)
	
	oPrn:Box(2250,1000,2300,1150)
	oPrn:Box(2250,1250,2300,1400)
	oPrn:say(2200,1000,'N° AFILIADOS'	 ,oFont05b	,100)
	oPrn:say(2225,1000,'PAGINA'	       ,oFont05b	,100)
	oPrn:say(2200,1250,'TOTAL AFILIADOS' ,oFont05b	,100)
	oPrn:say(2225,1250,'ACUMULADOS'	    ,oFont05b  ,100)
	
	//*************************************************
	//05/11/2002 francisco Guerrero
	//*****************************************************************
	
	aFill(aTotPag,0)    
	nContPag01:=0
	Li:=410
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
Local i := 0

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

oPrn:EndPage()

oPrn:StartPage()

///////////////////////////////
  //05/11/2002 Francisco Guerrero
  
//***************************************************
/////////////////////seccion I///////////////      

oPrn:say(0030,0950,"PLANILLA DE PAGO DE COTIZACIONES VOLUNTARIAS,"  ,oFont11b,100)
oPrn:say(0070,0950,"DEPOSITOS CONVENIDOS Y APORTES DE INDEMNIZACION",oFont11b,100)
oPrn:say(0110,1250,"FONDOS DE PENSIONES"                            ,oFont11b,100)
oPrn:say(0120,0100,cNomeAFP												     ,oFont14b,100)
//oPrn:say(0001,2700,"Página : "+StrZero(nPagina,6)					    ,oFont08	,100)

oPrn:say(0080,2400,'N° SERIE DECLARACION'					,oFont05b	,100)
oPrn:say(0080,2660,'FOLIO CAJERO'							,oFont05b	,100)
oPrn:Box(0100,2400,0150,2580)
oPrn:Box(0100,2660,0150,2800)

////////////////////////////////////

oPrn:Box(0170,0100,0380,3000)
oPrn:Box(0170,0100,0200,3000)
oPrn:Box(0200,0100,0260,3000)
oPrn:Box(0260,0100,0320,3000)
oPrn:Box(0320,0100,0380,3000)     

oPrn:Box(0200,0100,0260,0150)     
oPrn:Box(0200,2100,0260,2150)     
oPrn:Box(0200,2650,0260,2700)     

oPrn:Box(0260,0100,0320,0150)     
oPrn:Box(0260,1400,0320,1850)     
oPrn:Box(0260,2300,0320,2650)     
oPrn:Box(0260,2650,0320,2700)  

oPrn:Box(0320,0100,0380,0150)     
oPrn:Box(0320,2100,0380,2150)     
oPrn:Box(0320,2550,0380,2600)     
   
oPrn:say(0175,0150,'SECCION I.-IDENTIFICACION DEL EMPLEADOR'	,oFont06b,100)
oPrn:say(0235,0160,'Razón Social o Nombre'							,oFont05	,100)
oPrn:say(0295,0160,'Dirección'											,oFont05	,100)
oPrn:say(0355,0160,'Nombre representante legal'						,oFont05	,100)
oPrn:say(0235,2160,'R.U.T. Empleador'									,oFont05	,100)
oPrn:say(0235,2710,'Cod. act. económica'					      	,oFont05	,100)
oPrn:say(0295,1410,'Comuna'												,oFont05	,100)
oPrn:say(0295,1860,'Ciudad'												,oFont05	,100)
oPrn:say(0295,2310,'Region'												,oFont05	,100)
oPrn:say(0295,2710,'Telefono'												,oFont05	,100)
oPrn:say(0355,2160,'Rut Rep. Legal'										,oFont05	,100)
oPrn:say(0355,2610,'Cambios en Rep. Legal'							,oFont05	,100)

oPrn:say(0220,0110,'1'							,oFont06	,100)
oPrn:say(0220,2110,'2'							,oFont06	,100)
oPrn:say(0220,2660,'3'							,oFont06	,100)
oPrn:say(0280,0110,'4'							,oFont06	,100)
oPrn:say(0280,2660,'5'							,oFont06	,100)
oPrn:say(0340,0110,'6'							,oFont06	,100)
oPrn:say(0340,2110,'7'							,oFont06	,100)
oPrn:say(0340,2560,'8'							,oFont06	,100)

oPrn:say(0205,0160,aInfo[3]												,oFont07b,100)//nombre empresa
oPrn:say(0265,0160,Substr(Alltrim(aInfo[4])+' '+;
									Alltrim(aInfo[14]),1,48)				,oFont07b,100)//direcccion
oPrn:say(0325,0160,cNomRep													,oFont07b,100)  //nombre representante
oPrn:say(0205,2160,transform(aInfo[8],Pesqpict('SRA','RA_CIC')),oFont07b,100)//rut empresa
oPrn:say(0265,1410,Substr(aInfo[13],1,25)								,oFont07b,100)//comuna
oPrn:say(0205,2710,cCodAct													,oFont07b,100)//cod act. economi.
oPrn:say(0325,2160,transform(cRutRep,Pesqpict('SRA','RA_CIC'))	,oFont07b,100)//rut representante
oPrn:say(0265,2710,substr(aInfo[10],(len(alltrim(aInfo[10])) - 6),7)			,oFont07b,100)//telefono


//**************************************************
/////////////////////seccion II ////////////////
oPrn:Box(0420,0100,0450,3000)
oPrn:Box(0450,0100,0550,3000)
oPrn:Box(0450,0100,1050,0150)
oPrn:Box(0450,0150,0500,1000)
oPrn:Box(0500,0150,1050,0400)
oPrn:Box(0500,0400,1050,1000)

//fondos de pensiones
oPrn:Box(0450,1000,1100,1250)
oPrn:Box(0450,1250,1100,1500)
oPrn:Box(0450,1500,1100,1750)

//cuentas de indemnizacion
oPrn:Box(0450,1750,0480,3000)
//oPrn:Box(0480,1100,0550,1300)
oPrn:Box(0480,1750,1100,1950)
oPrn:Box(0480,1950,1050,2150)
oPrn:Box(0480,2150,1050,2300)
oPrn:Box(0480,2300,1100,2550)
//periodos anteriores a la fecha del pacto
oPrn:Box(0480,2550,0510,3000)
oPrn:Box(0510,2550,1050,2700)
oPrn:Box(0510,2700,1050,2850)
oPrn:Box(0510,2850,1050,3000)

For i:= 550 to 1050 step 50
     oPrn:Line(i,0100,i,3000)
next

oPrn:say(0425,0150,'SECCION II.-DETALLE DE COTIZACIONES, DEPOSITOS Y APORTES'	,oFont06b	,100)   //Titulo
oPrn:say(0425,2100,'FONDOS DE PENSIONES'						   	     ,oFont06b	,100)//titulo

oPrn:say(0460,0160,'IDENTIFICACION DEL AFILIADO'						  ,oFont06b	,100)//titulo

oPrn:say(0505,0160,'R.U.T. o C.I. '			                          ,oFont04	,100)
oPrn:say(0520,0155,'(con digito verificador)'			              ,oFont04	,100)
oPrn:say(0510,0410,'APELLIDO PATERNO, APELLIDO MATERNO y NOMBRES'	  ,oFont05	,100)

oPrn:say(0490,1020,'REMUNERACION'											  ,oFont05	,100)
oPrn:say(0510,1020,'IMPONIBLE'												  ,oFont05	,100)
oPrn:say(0490,1270,'COTIZACION'												  ,oFont05	,100)
oPrn:say(0510,1270,'VOLUNTARIA'										        ,oFont05	,100)
oPrn:say(0490,1520,'DEPOSITO'						                       ,oFont05	,100)
oPrn:say(0510,1520,'CONVENIO $'												  ,oFont05	,100)
     
oPrn:say(0455,2350,'CUENTA DE INDEMNIZACION'							,oFont06b	,100)//titulo
oPrn:say(0500,1760,'REMUNERACION'							         ,oFont05	,100)
oPrn:say(0525,1760,'IMPONIBLE'							            ,oFont05	,100)
oPrn:say(0500,1960,'REGIMEN'							               ,oFont05	,100)
oPrn:say(0525,1960,'PREVISIONAL'							            ,oFont05	,100)
oPrn:say(0500,2160,'TASA'							                  ,oFont05	,100)
oPrn:say(0525,2160,'PACTADA'							               ,oFont05	,100)
oPrn:say(0500,2310,'APORTE'							               ,oFont05	,100)
oPrn:say(0525,2310,'INDEMNIZACION $'							      ,oFont05	,100)
     
oPrn:say(0485,2560,'PERIODOS ANTERIORES A LA FECHA DEL PACTO'	,oFont05b	,100)//titulo
oPrn:say(0515,2555,'N° PERIODOS'							            ,oFont05	,100)
oPrn:say(0512,2710,'DESDE'							                  ,oFont05	,100)
oPrn:say(0530,2710,'Dia/Mes/Año'							            ,oFont04	,100)
oPrn:say(0512,2860,'HASTA'							                  ,oFont05	,100)
oPrn:say(0530,2860,'Dia/Mes/Año'							            ,oFont04	,100)
oPrn:say(1110,0160,'NOTA : Si el número de trabajadores es mayor de 10 adjunte las hojas de detalle necesarias.'	,oFont05	,100)
oPrn:say(1060,0800,'TOTAL PAGINA'							      ,oFont06b	,100)
oPrn:say(1060,2100,'01: Antiguo Regimen'							,oFont04b	,100)
oPrn:say(1080,2100,'02: Nuevo Regimen'							   ,oFont04b	,100)
oPrn:Line(1050,2030,1080,2030)
oPrn:Line(1080,2030,1080,2070)

nContI:=1
for i:=560 to 1010 step 50
    oPrn:say(i,0110,str(nContI,2) ,oFont06	,100)
    nContI++
next

//*************************************************
///////////////////////Seccion III //////////////////
oPrn:Box(1150,0100,1700,1400)
//subseccion de fondos de pensiones
oPrn:Box(1200,0130,1250,0750)
oPrn:Box(1250,0130,1650,0410)
oPrn:Box(1250,0410,1650,0500)
oPrn:Box(1250,0500,1650,0750)
For i:=1300 to 1600 step 50
   oPrn:Line(i,0130,i,0750)
next   
//subseccion afp
oPrn:Box(1400,0800,1450,1370)
oPrn:Box(1450,0800,1650,1020)
oPrn:Box(1450,1020,1650,1120)
oPrn:Box(1450,1120,1650,1370)
oPrn:Line(1500,0800,1500,1370)
oPrn:Line(1550,0800,1550,1370)
oPrn:Line(1600,0800,1600,1370)

oPrn:say(1160,0160,'SECCION III-RESUMEN DE COTIZACIONES; DEPOSITOS Y APORTES'	,oFont06b	,100)//Titulo

oPrn:say(1210,0140,'SUBSECCION III.1. FONDOS DE PENSIONES'	,oFont05b	,100)
oPrn:say(1278,0140,'DETALLE'							            ,oFont05b	,100)
oPrn:say(1278,0420,'Código'							            ,oFont05b	,100)
oPrn:say(1255,0510,'Valores $'							         ,oFont05b	,100)
oPrn:say(1278,0510,'(sin decimales)'							   ,oFont05b	,100)
     
oPrn:say(1320,0140,'COTIZACION VOLUNTARIA'						,oFont04	,100)
oPrn:say(1315,0560,Transform(aTotAcum[2],'@E 999,999,999')	,oFont07	,100)
oPrn:say(1370,0140,'DEPOSITO CONVENIDO'							,oFont04	,100)
oPrn:say(1420,0140,'APORTE INDEMNIZACION'							,oFont04	,100)
oPrn:say(1470,0140,'SUBTOTAL A PAGAR FONDOS'						,oFont04	,100)
oPrn:say(1465,0560,Transform(aTotAcum[2],'@E 999,999,999')	,oFont07	,100)
oPrn:say(1520,0140,'+ REAJUSTE FONDOS DE PENSIONES'			,oFont04	,100)
oPrn:say(1570,0140,'+ INTERESES FONDOS DE PENSIONES'			,oFont04	,100)
oPrn:say(1610,0140,'TOTAL A PAGAR FONDOS DE PENSIONES'		,oFont04	,100)
oPrn:say(1605,0560,Transform(aTotAcum[2],'@E 999,999,999')	,oFont07	,100)

oPrn:say(1320,0430,'01'							,oFont06	,100)
oPrn:say(1370,0430,'02'							,oFont06	,100)
oPrn:say(1420,0430,'03'							,oFont06	,100)
oPrn:say(1470,0430,'04'							,oFont06	,100)
oPrn:say(1520,0430,'05'							,oFont06	,100)
oPrn:say(1570,0430,'06'							,oFont06	,100)
oPrn:say(1610,0430,'10'							,oFont06	,100)  


oPrn:say(1410,0810,'SUBSECCION III.2. A.F.P.'	,oFont05b	,100)
oPrn:say(1480,0810,'DETALLE'							,oFont05b	,100)
oPrn:say(1480,1030,'Código'							,oFont05b	,100)
oPrn:say(1460,1125,'Valores $'	               ,oFont05b	,100)
oPrn:say(1480,1125,'(sin decimales)'	         ,oFont05b	,100)

oPrn:say(1520,0810,'+ RECARGO 20% INTERESES'		,oFont04	,100)
oPrn:say(1570,0810,'+ COSTOS DE COBRANZAS'		,oFont04	,100)
oPrn:say(1620,0810,'TOTAL A PAGAR A.F.P.'			,oFont04	,100)

oPrn:say(1520,1030,'56'							      ,oFont06	,100)
oPrn:say(1570,1030,'57'							      ,oFont06	,100)
oPrn:say(1620,1030,'60'							      ,oFont06	,100)


//****************************************************
/////////////////////Seccion IV////////////////////
oPrn:Box(1150,1600,1700,3000)
oPrn:Box(1300,1700,1350,1750)
oPrn:Box(1300,1900,1350,1950)
oPrn:Box(1300,2100,1350,2400)
oPrn:Box(1300,2600,1350,2900)

oPrn:Box(1400,1750,1450,1900)
oPrn:Box(1400,2100,1450,2400)
oPrn:Box(1400,2600,1450,2700)

oPrn:Box(1500,1800,1530,1850)
oPrn:Box(1530,1800,1560,1850)
oPrn:Box(1560,1800,1590,1850)
oPrn:Box(1500,2100,1550,2400)
oPrn:Box(1500,2600,1550,2700)    


oPrn:say(1160,1660,'SUBSECCION IV - ANTECEDENTES GENERALES'		,oFont06b	,100)

oPrn:say(1240,1620,'TIPO DE INGRESO IMPONIBLE'						,oFont05b	,100)
oPrn:say(1280,1620,'REMUNERACIONES '							      ,oFont05b	,100)
oPrn:say(1310,1620,'DEL MES'							               ,oFont05b	,100)
oPrn:say(1310,1710,'X'							                     ,oFont08b	,100)
oPrn:say(1280,1820,'GRATIFICACIONES'							      ,oFont05b	,100)
oPrn:say(1420,1620,'PERIODO'							,oFont05b	,100)
oPrn:say(1380,1760,'MES    AÑO'		,oFont05b	,100)
meses2:={'ENE','FEB','MAR','ABR','MAY','JUN','JUL','AGO','SEP','OCT','NOV','DIC'}
oPrn:say(1410,1760,MESES2[MONTH(MV_PAR02)]+'/'+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont07	,100)

oPrn:say(1510,1620,'1.NORMAL'							,oFont05b	,100)
oPrn:say(1505,1810,'X'							      ,oFont07b	,100)
oPrn:say(1540,1620,'2.ATRASADA'						,oFont05b	,100)
oPrn:say(1570,1620,'3.ADELENTADA'					,oFont05b	,100)

oPrn:say(1320,2000,'DESDE'							,oFont05b	,100)
oPrn:say(1280,2120,'DIA   MES    AÑO'		,oFont05b	,100)
oPrn:say(1310,2120,'01'+" / "+STRZERO(MONTH(MV_PAR02),2)+' / '+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont07	,100)

oPrn:say(1420,2000,'HASTA'							,oFont05b	,100)
oPrn:say(1380,2120,'DIA   MES    AÑO'		,oFont05b	,100)
oPrn:say(1410,2120,ALLTRIM(STR(F_ULTDIA(MV_PAR02),2))+" / "+STRZERO(MONTH(MV_PAR02),2)+' / '+ALLTRIM(STR(YEAR(MV_PAR02)))	,oFont07	,100)

oPrn:say(1510,2000,'FECHA'							,oFont05b	,100)
oPrn:say(1540,2000,'PAGO'							,oFont05b	,100)

oPrn:say(1260,2410,'TOTAL'							,oFont05b	,100)
oPrn:say(1290,2410,'REMUNERACIONES'				,oFont05b	,100)
oPrn:say(1320,2410,'O GRATIFICACIONES'			,oFont05b	,100)
oPrn:say(1310,2695,Transform(aTotAcum[1],'@E 999,999,999')	,oFont07	,100)

oPrn:say(1410,2410,'N° AFILIADOS'				,oFont05b	,100)
oPrn:say(1440,2410,'INFORMADOS'					,oFont05b	,100)
oPrn:say(1410,2610,Transform(nContAcum01,"@e 9,999")	,oFont07	,100)
oPrn:say(1510,2410,'N° HOJAS'						,oFont05b	,100)
oPrn:say(1540,2410,'ANEXAS'						,oFont05b	,100)      
oPrn:say(1510,2610,Transform(nPagina,"@e 9,999")	,oFont07	,100)




//*************************************************************************
///////////////////////////////Seccion V//////////////////////////////////

oPrn:Box(1750,0100,1950,3000)    
oPrn:Box(1790,0130,1910,1400)    
oPrn:Box(1790,1600,1910,2970)    

oPrn:say(1755,0160,'SECCION V - ANTECEDENTES SOBRE EL PAGO'		,oFont06b	,100)
oPrn:say(1795,0160,'FONDOS DE PENSIONES'	  ,oFont06b	,100)
oPrn:say(1830,0160,'EFECTIVO'		           ,oFont05	,100)
oPrn:Box(1830,0270,1860,0300)
oPrn:say(1830,0350,'CHEQUE'		           ,oFont05	,100)
oPrn:Box(1830,0450,1860,0480)
oPrn:say(1830,0570,'CHEQUE N°'		        ,oFont05	,100)
oPrn:Line(1840,0680,1840,0850)
oPrn:say(1830,0870,'BANCO'		              ,oFont05	,100)
oPrn:Line(1840,0960,1840,1150)
oPrn:say(1830,1170,'PLAZA'		              ,oFont05	,100)
oPrn:Line(1840,1260,1840,1380)
oPrn:say(1890,0160,'GIRAR CHEQUE   NOMINATIVO A: FONDO DE PENSIONES '+cNomeAFP		,oFont05	,100)

oPrn:say(1795,1620,'A.F.P.'		    ,oFont06b	,100)
oPrn:say(1830,1630,'EFECTIVO'		    ,oFont05	,100)
oPrn:Box(1830,1740,1860,1770)
oPrn:say(1830,1850,'CHEQUE'		    ,oFont05	,100)
oPrn:Box(1830,1950,1860,1980)
oPrn:say(1830,2070,'CHEQUE N°'		 ,oFont05	,100)
oPrn:Line(1840,2200,1840,2300)
oPrn:say(1830,2320,'BANCO'		       ,oFont05	,100)
oPrn:Line(1840,2400,1840,2680)
oPrn:say(1830,2700,'PLAZA'	 	       ,oFont05	,100)
oPrn:Line(1840,2800,1840,2950)
oPrn:say(1890,1620,'GIRAR CHEQUE   NOMINATIVO A: '+cNomeAFP		,oFont05	,100)

//////////////////
oPrn:Box(2000,0100,2200,1550)    
oPrn:Box(2000,1600,2200,2500)    
oPrn:Box(2000,2550,2200,3000)        

oPrn:say(2010,0170,'DECLARO BAJO JURAMENTO QUE LOS ANTECEDENTES'		     ,oFont05b	,100)
oPrn:say(2035,0170,'CONSIGNADOS SON EXPRESION FIEL DE LA REALIDAD'	     ,oFont05b	,100)
oPrn:Line(2160,0900,2160,1450)
oPrn:say(2165,0950,'Firma del Empleador o Representante Legal'	     ,oFont05	,100)
//oPrn:Line(2160,1750,2160,2250)
oPrn:say(2170,1800,'V°B° Recepcion y Calculo'	     ,oFont05	,100)
//oPrn:Line(2160,2650,2160,2920)
oPrn:say(2170,2700,'V°B° Y TIMBRE CAJERO'	     ,oFont05	,100)

///////////////////////////////

oPrn:EndPage()

  //05/11/2002 Francisco Guerrero
////////////////////////////////********************************

Return