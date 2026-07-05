/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr074.ch"
#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³finr074   º Autor ³ Bruno Sobieski     º Fecha³  17-10-04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescripcio³ Relatorio de diferencia de cambio contas a receber         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FINR074()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracion de Variables                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1		:= STR0001 //"Este programa tiene como objetivo imprimir informe "
Local cDesc2      := STR0002 //"de acuerdo con los parámetros informados por el usuario."
Local cDesc3      := STR0003 //"Informe de diferencias de cambio de cuentas a recibir"
Local cPict       := ""
Local titulo     	:= STR0003 //"Informe de diferencias de cambio de cuentas a recibir"
Local nLin       	:= 80

//                              1         2         3         4         5         6         7         8         9        10
//                    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local Cabec1      := STR0004+Substr(GetMv("MV_SIMB1"),1,3) //"Cliente      Suc. Venc.      Emision               Modalidad  Prefijo/Numero/Cuota Tipo       Valor "
Local Cabec2      := ""
Local imprime     := .T.
Private aOrd      := {STR0005,STR0006,STR0007,STR0008,STR0009} //"Cliente"###"Prefijo+Numero"###"Modalidad"###"Emision"###"Vencimiento"
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "FINR074" // Coloque aquí el nombre del programa para impresión en el encabezamiento
Private nTipo        := 18
Private aReturn      := { STR0010, 1, STR0011, 2, 2, 1, "", 1} //"A Rayas"###"Administración"
Private nLastKey     := 0
Private cPerg      	:= "FIR074"
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "FINR074"// Coloque aquí el nombre del archivo usado para impresión en disco

Private cString := "SE1"

dbSelectArea("SE1")
dbSetOrder(1)

pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta la interfase estandar con el usuario...                           ³
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
Local cAliasSE1:="SE1"
Local nCol	:=	0
Local aCampos	:=	{}
Local nMoedaOri	,	nVlrMoeda	:= 0

If MV_PAR13==1           
	bCampo	:=	{|| SFR->FR_CHAVDE}
	Cabec1	+=+STR0012 //"     Valor Orig Mon.      Tasa"
Else
	bCampo	:=	{|| SFR->FR_CHAVOR}
	Cabec1	+=+ STR0013 //"                        Ajuste"
Endif									

#IFDEF TOP
	If TCSrvType()<>"AS400"
		lQuery	:=	.T.
	Endif
#ENDIF		


dbSelectArea(cString)

nOrdem := aReturn[8]


If lQuery
	Do Case
	Case nOrdem == 1
		dbSetOrder(2)
	Case nOrdem == 2
		dbSetOrder(1)
	Case nOrdem == 3
		dbSetOrder(3)
	Case nOrdem == 4
		dbSetOrder(6)
	Case nOrdem == 5
		dbSetOrder(7)
	EndCase
	
	DbSelectArea('SE1')
	aCampos	:=	DbStruct()
	cQuery	:=	" SELECT * FROM "+RetSqlName('SE1') + " SE1 "
	cQuery	+=	" WHERE E1_FILIAL = '"+ xFilial('SE1') +"' "
	cQuery	+=	" AND   E1_PREFIXO BETWEEN '"+ MV_PAR03 +"' AND '"+mv_par04+"'"
	cQuery	+=	" AND   E1_NUM     BETWEEN '"+ MV_PAR05 +"' AND '"+mv_par06+"'"
	cQuery	+=	" AND   E1_NATUREZ BETWEEN '"+ MV_PAR07 +"' AND '"+mv_par08+"'"
	cQuery	+=	" AND   E1_EMISSAO BETWEEN '"+ dTOS(MV_PAR09) +"' AND '"+dTOS(mv_par10)+"'"
	cQuery	+=	" AND   E1_VENCREA BETWEEN '"+ dTOS(MV_PAR11) +"' AND '"+dTOS(mv_par12)+"'"
	cQuery	+=	" AND   E1_CLIENTE BETWEEN '"+ MV_PAR01 +"' AND '"+mv_par02+"'"

	cQuery	+=	" AND   D_E_L_E_T_ =' ' "
	cQuery	+=	" ORDER BY "+SqlOrder(SE1->(IndexKey()))

	cQuery	:=	ChangeQuery(cQuery)	

   dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"SE1QRY",.T.,.T.)
   aEval(aCampos, {|e| If(e[2]!= "C", TCSetField("SE1QRY", e[1], e[2],e[3],e[4]),Nil)})
	DbSelectArea('SE1QRY')
	cAliasSE1:=	'SE1QRY'
	cCond		:=	".T."

Else
	Do Case
	Case nOrdem == 1
		dbSetOrder(2)
	   cCond := "E1_CLIENTE <= mv_par02"
		DbSeek(xFilial('SE1')+mv_par01,.T.)
	Case nOrdem == 2
		dbSetOrder(1)
	   cCond := "E1_PREFIXO+E1_NUM <= mv_par04+mv_par06"
		DbSeek(xFilial('SE1')+mv_par03+mv_par05,.T.)
	Case nOrdem == 3
		dbSetOrder(3)
	   cCond := "E1_NATUREZ <= mv_par08"
		DbSeek(xFilial('SE1')+mv_par07,.T.)
	Case nOrdem == 4
		dbSetOrder(6)
	   cCond := "E1_EMISSAO <= mv_par10"
		DbSeek(xFilial('SE1')+Dtos(mv_par09),.T.)
	Case nOrdem == 5
		dbSetOrder(7)
	   cCond := "E1_VENCREA <= mv_par12"
		DbSeek(xFilial('SE1')+Dtos(mv_par11),.T.)
	EndCase                            
Endif

//No caso de relatorio DE AJUSTE precisa do valor da taxa do titulo origem e da moeda origem.
If MV_PAR13==2 
	nMoedaOri	:= 0
	While !EOF()
   	If E1_MOEDA > 1 .and. E1_CONVERTE <> 'N'
   		nMoedaOri	:=  E1_MOEDA	
   		nVlrMoeda	:=  (E1_VLCRUZ/E1_VALOR)			
   	Endif
   	Dbskip()
	Enddo
	Dbgotop()	
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica cuantos registros seran procesados para la regla ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(1000)
While !EOF() .And. xFilial('SE1')==E1_FILIAL .And. &cCond.
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
      @nLin,00 PSAY STR0017 //"*** CANCELADO POR EL OPERADOR ***"
      Exit
   Endif              
   If !lQuery
		If E1_PREFIXO+E1_NUM < mv_par03+mv_par05 .Or. E1_PREFIXO+E1_NUM > mv_par04+mv_par06 .Or.;
			E1_CLIENTE < MV_PAR01 .or. E1_CLIENTE>MV_PAR02 .Or.;
			E1_NATUREZ < MV_PAR07 .or. E1_NATUREZ>MV_PAR08 .Or.;
			E1_EMISSAO < MV_PAR09 .or. E1_EMISSAO> Max(dDataBase,MV_PAR10) .Or.;
			E1_VENCREA < MV_PAR11 .or. E1_VENCREA>MV_PAR12      
			dBsKIP()
			Loop
		Endif
	
		If (E1_MOEDA <=1 .And. MV_PAR13==1) .Or.(E1_MOEDA >1 .And. MV_PAR13==2)
			dBsKIP()
			Loop
		Endif				
	
		If (E1_CONVERT<>"N" .And. MV_PAR13==2)
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

   If MV_PAR13==1 .AND. E1_MOEDA <= 1
		Dbskip()
		Loop
	ElseIf MV_PAR13==2 .AND. E1_MOEDA > 1 .AND. E1_CONVERTE <> 'N'
		Dbskip()
		Loop
	Endif				

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impresion del encabezamiento del informe. . .                            ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If nLin > 55 // Salto de Página. En este caso el impreso tiene 55 líneas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
	DbSelectArea('SFR')
	DbSetOrder(MV_PAR13)
	If DbSeek(xFilial()+"1"+(cAliasSE1)->(E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO))
		@nLin,000 PSAY (cAliasSE1)->E1_CLIENTE
		@nLin,013 PSAY (cAliasSE1)->E1_LOJA
		@nLin,018 PSAY Dtoc((cAliasSE1)->E1_VENCREA)
		@nLin,029 PSAY Dtoc((cAliasSE1)->E1_EMISSAO)
		@nLin,044 PSAY (cAliasSE1)->E1_NATUREZ
		@nLin,055 PSAY (cAliasSE1)->E1_PREFIXO+" "+(cAliasSE1)->E1_NUM+" "+(cAliasSE1)->E1_PARCELA
		@nLin,085 PSAY (cAliasSE1)->E1_TIPO
		@nLin,089 PSAY (cAliasSE1)->E1_VLCRUZ	PICTURE PesqPict('SE1','E1_VLCRUZ',14,MsDecimais((cAliasSE1)->E1_MOEDA))
		If MV_PAR13==1
			@nLin,103 PSAY (cAliasSE1)->E1_VALOR 	PICTURE PesqPict('SE1','E1_VLCRUZ',14,MsDecimais((cAliasSE1)->E1_MOEDA))
			@nLin,119 PSAY (cAliasSE1)->E1_MOEDA 
			@nLin,120 PSAY ((cAliasSE1)->E1_VLCRUZ/(cAliasSE1)->E1_VALOR) PICTURE PesqPict('SE1','E1_TXMOEDA')
		Endif
		nTotal	:=	(cAliasSE1)->E1_VLCRUZ
		nLin++
		cChave	:=	(cAliasSE1)->(E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO)	
		WHILE !EOF() .AND. Trim( xFilial()+"1"+cChave ) == Trim( FR_FILIAL+FR_CARTEI+IIf(MV_PAR13==1,FR_CHAVOR,FR_CHAVDE) )
			If MV_PAR13 == 1	
				@nLin,001 PSAY STR0014 //"Diferencia de cambio -> "
			Else
				@nLin,001 PSAY STR0015 //"Documento ajustado   ->"
			Endif
				@nLin,025 PSAY Dtoc(SFR->FR_DATADI)
				nCol	:=	TamSX3('E1_CLIENTE')[1]+TamSX3('E1_LOJA')[1]+1
		  		@nLin,055 PSAY Substr(Eval(bCampo),nCol,TamSX3('E1_PREFIXO')[1])
				nCol	+=	TamSX3('E1_PREFIXO')[1]
				@nLin,059 PSAY Substr(Eval(bCampo),nCol,TamSX3('E1_NUM')[1])
				nCol	+=	TamSX3('E1_NUM')[1]
		   		@nLin,081 PSAY Substr(Eval(bCampo),nCol,TamSX3('E1_PARCELA')[1])
				nCol	+=	TamSX3('E1_PARCELA')[1]
				@nLin,085 PSAY Substr(Eval(bCampo),nCol,TamSX3('E1_TIPO')[1])
		  		@nLin,089 PSAY SFR->FR_VALOR	PICTURE PesqPict('SE1','E1_VLCRUZ',14,MsDecimais(1))
			If MV_PAR13==1                                       
				//@nLin,102 PSAY SFR->FR_VALORI PICTURE PesqPict('SE1','E1_VALOR',14,MsDecimais(SE1->E1_MOEDA))
				@nLin,120 PSAY (SFR->FR_TXATU) PICTURE PesqPict('SE1','E1_TXMOEDA')
			Else
				//@nLin,120 PSAY (SFR->FR_TXATU-SFR->FR_TXORI) PICTURE PesqPict('SE1','E1_TXMOEDA')
			   	@nLin,120 PSAY (SFR->FR_TXATU-nVlrMoeda) PICTURE PesqPict('SE1','E1_TXMOEDA')				
			Endif
			nTotal	+=	SFR->FR_VALOR
		   nLin++
		   DbSkip()
		Enddo	                                                
		If MV_PAR13==1
			@nLin,089 PSAY "_____________"
			nLin++
			@nLin,001 PSAY STR0016 //"Valor ajustado : "
			@nLin,089 PSAY nTotal	PICTURE PesqPict('SE1','E1_VLCRUZ',14,MsDecimais(1))
			nLin++
		Endif
		@nLin,000 PSAY __PrtThinLine()
		nLin++
	Endif	
	DbSelectArea(cAliasSE1)
   dbSkip() // Avanza el puntero del registro en el archivo
EndDo                                    
If nLin <> 80
	Roda(cbCont,CbTxt)
Endif	                            
If lQuery
	DbSelectArea('SE1QRY')
	DbCloseArea()
	DbSelectArea('SE1')
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza la ejecucion del informe...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

Return
