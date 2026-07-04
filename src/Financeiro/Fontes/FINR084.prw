/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr084.ch"
#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³finr084   º Autor ³ Bruno Sobieski     º Fecha³  17-10-04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescripcio³ Relatorio de diferencia de cambio contas a pagar           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7 IDE                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºL. Samaniego³26/02/18|DMICNS-1862|Limitar a un tamanho de caracteres laº±±
±±º            ³        |           |de busqueda en SFR. Argentina        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FINR084()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracion de Variables                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1		:= STR0001 //"Este programa tiene como objetivo imprimir informe "
Local cDesc2      := STR0002 //"de acuerdo con los parámetros informados por el usuario."
Local cDesc3      := STR0003 //"Informe de diferencias de cambio"
Local cPict       := ""
Local titulo     	:= STR0004 //"Informe de diferencias de cambio de cuentas a pagar"
Local nLin       	:= 80

//                              1         2         3         4         5         6         7         8         9        10
//                    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1      := STR0005+Substr(GetMv("MV_SIMB1"),1,3) //"Proveedor    Suc. Venc.      Emision    Registro   Modalidad  Prefijo/Numero/Cuota Tipo       Valor "
Local Cabec2      := ""
Local imprime     := .T.
Private aOrd      := {STR0006,STR0007,STR0008,STR0009,STR0010,STR0011} //"Proveedor"###"Prefijo+Numero"###"Modalidad"###"Emision"###"Vencimiento"###"Registro"
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "FINR084" // Coloque aquí el nombre del programa para impresión en el encabezamiento
Private nTipo        := 15
Private aReturn      := { STR0012, 1, STR0013, 2, 2, 1, "", 1} //"A Rayas"###"Administración"
Private nLastKey     := 0
Private cPerg      	:= "FIR084"
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "FINR084"// Coloque aquí el nombre del archivo usado para impresión en disco

Private cString := "SE2"

dbSelectArea("SE2")
dbSetOrder(1)

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta la interface estandar con el usuario...                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Procesamiento. RPTSTATUS monta ventana con la regla de procesamiento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Si imprime en disco, llama al gerente de impresion...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncion   ³RUNREPORT º Autor ³ Bruno Sobieski     º Fecha³  17-10-04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Funcion auxiliar llamada por la RPTSTATUS. La funcion      º±±
±±º          ³ monta la ventana con la regla de procesamiento.            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
Local lQuery	:=	.F.
Local nRegua	:=	0
Local bCampo
Local cAliasSE2:=	"SE2
Local nCol	:=	0
Local aCampos	:=	{}
Local nTamChav  := TamSx3('FR_CHAVOR')[1]
Local cChaveSFR := ""

If mv_par15==1           
	bCampo	:=	{|| SFR->FR_CHAVDE}
	Cabec1	+=+STR0014 //"     Valor Orig Mon.      Tasa"
Else
	bCampo	:=	{|| SFR->FR_CHAVOR}
	Cabec1	+=+STR0015 //"   Aj. Anterior         Ajuste"
Endif									

#IFDEF TOP
	If TCSrvType()<>"AS400"
		lQuery	:=	.T.
	Endif
#ENDIF		


dbSelectArea(cString)

nOrdem := aReturn[8]

If lQuery          
	DbSelectArea('SE2')
	Do Case
	Case nOrdem == 1
		dbSetOrder(6)
	Case nOrdem == 2
		dbSetOrder(1)
	Case nOrdem == 3
		dbSetOrder(2)
	Case nOrdem == 4
		dbSetOrder(5)
	Case nOrdem == 5
		dbSetOrder(3)
	Case nOrdem == 6
		dbSetOrder(7)
	EndCase                            
	aCampos	:=	DbStruct()
	cQuery	:=	" SELECT * FROM "+RetSqlName('SE2') + " SE2 "
	cQuery	+=	" WHERE E2_FILIAL = '"+ xFilial('SE2') +"' "
	cQuery	+=	" AND   E2_FORNECE BETWEEN '"+ MV_PAR01 +"' AND '"+mv_par02+"'"
	cQuery	+=	" AND   E2_PREFIXO BETWEEN '"+ MV_PAR03 +"' AND '"+mv_par04+"'"
	cQuery	+=	" AND   E2_NUM     BETWEEN '"+ MV_PAR05 +"' AND '"+mv_par06+"'"
	cQuery	+=	" AND   E2_NATUREZ BETWEEN '"+ MV_PAR07 +"' AND '"+mv_par08+"'"
	cQuery	+=	" AND   E2_EMISSAO BETWEEN '"+ dTOS(MV_PAR09) +"' AND '"+dTOS(mv_par10)+"'"
	cQuery	+=	" AND   E2_VENCREA BETWEEN '"+ dTOS(MV_PAR11) +"' AND '"+dTOS(mv_par12)+"'"
	cQuery	+=	" AND   E2_EMIS1   BETWEEN '"+ dTOS(MV_PAR13) +"' AND '"+dTOS(mv_par14)+"'"
	If MV_PAR15==1
		cQuery	+=	" AND   E2_MOEDA > 1  "
	Else
		cQuery	+=	" AND   E2_MOEDA <= 1  "
		cQuery	+=	" AND   E2_CONVERT='N' "   
	Endif				
	cQuery	+=	" AND   D_E_L_E_T_ =' ' "        
	cQuery	+=	" ORDER BY "+SqlOrder(SE2->(IndexKey()))

   cQuery:= ChangeQuery(cQuery)

   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"SE2QRY",.T.,.T.)
   aEval(aCampos, {|e| If(e[2]!= "C", TCSetField("SE2QRY", e[1], e[2],e[3],e[4]),Nil)})
	DbSelectArea('SE2QRY')
	cAliasSE2:=	'SE2QRY'
	cCond		:=	".T."
Else
	Do Case
	Case nOrdem == 1
		dbSetOrder(6)
	   cCond := "E2_FORNECE <= mv_par02"
		DbSeek(xFilial('SE2')+mv_par01,.T.)
	Case nOrdem == 2
		dbSetOrder(1)
	   cCond := "E2_PREFIXO+E2_NUM <= mv_par04+mv_par06"
		DbSeek(xFilial('SE2')+mv_par03+mv_par05,.T.)
	Case nOrdem == 3
		dbSetOrder(2)
	   cCond := "E2_NATUREZA<= mv_par08"
		DbSeek(xFilial('SE2')+mv_par07,.T.)
	Case nOrdem == 4
		dbSetOrder(5)
	   cCond := "E2_EMISSAO <= mv_par10"
		DbSeek(xFilial('SE2')+Dtos(mv_par09),.T.)
	Case nOrdem == 5
		dbSetOrder(3)
	   cCond := "E2_VENCREA <= mv_par12"
		DbSeek(xFilial('SE2')+Dtos(mv_par11),.T.)
	Case nOrdem == 6
		dbSetOrder(7)
	   cCond := "E2_EMIS1 <= mv_par14"
		DbSeek(xFilial('SE2')+Dtos(mv_par13),.T.)
	EndCase                            
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica cuantos registros seran procesados para la regla ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(1000)
While !EOF() .And. xFilial('SE2')==E2_FILIAL .And. &cCond.
	Incregua()
	nRegua++
	If nRegua==1000
		SetRegua(1000)
		nRegua	:=	0
	Endif	
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Comprobar la anulacion por el usuario...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If lAbortPrint
      @nLin,00 PSAY STR0016 //"*** CANCELADO POR EL OPERADOR ***"
      Exit
   Endif                    
   If !lQuery
		If E2_PREFIXO+E2_NUM < mv_par03+mv_par05 .Or. E2_PREFIXO+E2_NUM > mv_par04+mv_par06 .Or.;
			E2_FORNECE < MV_PAR01 .or. E2_FORNECE>MV_PAR02 .Or.;
			E2_NATUREZ < MV_PAR07 .or. E2_NATUREZ>MV_PAR08 .Or.;
			E2_EMISSAO < MV_PAR09 .or. E2_EMISSAO>MV_PAR10 .Or.;
			E2_VENCREA < MV_PAR11 .or. E2_VENCREA>MV_PAR12 .Or.;
			E2_EMIS1   < MV_PAR13 .or. E2_EMIS1  > Max(dDataBase,MV_PAR14)
			dBsKIP()
			Loop
		Endif
	
		If (E2_MOEDA <=1 .And. mv_par15==1) .Or.(E2_MOEDA >1 .And. mv_par15==2)
			dBsKIP()
			Loop
		Endif				
	
		If (E2_CONVERT<>"N" .And. mv_par15==2)
			dBsKIP()
			Loop
		Endif				                                   
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Considera filtro do usuario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (!Empty(aReturn[7])) .And. (!&(aReturn[7]))
		dbSkip()
		Loop
	Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impresion del encabezamiento del informe. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If nLin > 55 // Salto de Página. En este caso el impreso tiene 55 líneas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
   	cChaveSFR := Substr((cAliasSE2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA), 1, nTamChav)
	DbSelectArea('SFR')
	DbSetOrder(mv_par15)
	If SFR->(DbSeek(xFilial('SFR')+"2"+cChaveSFR))
		@nLin,000 PSAY Alltrim((cAliasSE2)->E2_FORNECE)+"/"+Alltrim((cAliasSE2)->E2_LOJA)
//		@nLin,010 PSAY (cAliasSE2)->E2_LOJA
		@nLin,012 PSAY Dtoc((cAliasSE2)->E2_VENCREA)
		@nLin,023 PSAY Dtoc((cAliasSE2)->E2_EMISSAO)
		@nLin,035 PSAY Dtoc((cAliasSE2)->E2_EMIS1)
		@nLin,046 PSAY (cAliasSE2)->E2_NATUREZA
		@nLin,058 PSAY (cAliasSE2)->E2_PREFIXO+" "+(cAliasSE2)->E2_NUM+" "+(cAliasSE2)->E2_PARCELA
		@nLin,085 PSAY (cAliasSE2)->E2_TIPO
		@nLin,089 PSAY (cAliasSE2)->E2_VLCRUZ	PICTURE PesqPict('SE2','E2_VLCRUZ',14,MsDecimais((cAliasSE2)->E2_MOEDA))
		If MV_par15==1
			@nLin,105 PSAY (cAliasSE2)->E2_VALOR 	PICTURE PesqPict('SE2','E2_VLCRUZ',14,MsDecimais((cAliasSE2)->E2_MOEDA))
			@nLin,120 PSAY (cAliasSE2)->E2_MOEDA 
			@nLin,122 PSAY ((cAliasSE2)->E2_VLCRUZ/(cAliasSE2)->E2_VALOR) PICTURE PesqPict('SE2','E2_TXMOEDA')
		Endif
		nTotal	:=	(cAliasSE2)->E2_VLCRUZ
		nLin++
		cChave	:=	(cAliasSE2)->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)	
		WHILE !EOF() .AND. Trim( xFilial('SFR')+"2"+cChave ) == Trim( FR_FILIAL+FR_CARTEI+IIf(mv_par15==1,FR_CHAVOR,FR_CHAVDE) )
			If mv_par15 == 1	
				@nLin,001 PSAY STR0017 //"Diferencia de cambio -> "
			Else
				@nLin,001 PSAY STR0018 //"Documento ajustado   ->"
			Endif
			@nLin,024 PSAY Dtoc(SFR->FR_DATADI)
			@nLin,058 PSAY Substr(Eval(bCampo),1,3)
			nCol	:=	4
			@nLin,061 PSAY Substr(Eval(bCampo),nCol,TamSX3('E2_NUM')[1])
			nCol	+=	TamSX3('E2_NUM')[1]
			@nLin,081 PSAY Substr(Eval(bCampo),nCol,TamSX3('E2_PARCELA')[1])
			nCol	+=	TamSX3('E2_PARCELA')[1]
			@nLin,085 PSAY Substr(Eval(bCampo),nCol,TamSX3('E2_TIPO')[1])
			@nLin,090 PSAY xMoeda(SFR->FR_VALOR, SFR->FR_MOEDA, 1, , , SFR->FR_TXORI, 1)	PICTURE PesqPict('SE2','E2_VLCRUZ',14,MsDecimais(1))
			If mv_par15==1                                       
				@nLin,105 PSAY SFR->FR_VALOR PICTURE PesqPict('SE2','E2_VALOR',14,MsDecimais(SFR->FR_MOEDA))
				@nLin,120 PSAY SFR->FR_MOEDA
				If SFR->FR_TIPODI=="I"
					@nLin,123 PSAY STR0019 //"No Disp."
				Else
					@nLin,122 PSAY (SFR->FR_TXORI) PICTURE PesqPict('SE2','E2_TXMOEDA')
				Endif
			Else
				If SFR->FR_TIPODI=="I"
					@nLin,103 PSAY SFR->FR_CORANT PICTURE PesqPict('SE2','E2_VLCRUZ',14,MsDecimais(1))
				Endif
				@nLin,120 PSAY (SFR->FR_TXATU-SFR->FR_TXORI) PICTURE PesqPict('SE2','E2_TXMOEDA')
			Endif
			nTotal	+=	xMoeda(SFR->FR_VALOR, SFR->FR_MOEDA, 1, , , SFR->FR_TXORI, 1)
		   nLin++
		   DbSkip()
		Enddo	                                                
		If MV_par15==1
			@nLin,090 PSAY "_____________"
			nLin++
			@nLin,010 PSAY STR0020 //"Valor ajustado : "
			@nLin,090 PSAY nTotal	PICTURE PesqPict('SE2','E2_VLCRUZ',14,MsDecimais(1))
			nLin++
		Endif
		@nLin,000 PSAY __PrtThinLine()
		nLin++
	Endif	
	DbSelectArea(cAliasSE2)
   dbSkip() // Avanza el puntero del registro en el archivo
EndDo                                    
If nLin <> 80
	Roda(cbCont,CbTxt)
Endif	
If lQuery
	DbSelectArea('SE2QRY')
	DbCloseArea()
	DbSelectArea('SE2')
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza la ejecucion del informe...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

Return
