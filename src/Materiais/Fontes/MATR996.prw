/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"
#include "MATR996.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MATR996   ºAutor  ³Leandro M Santos    º Data ³  23/01/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retenciones Analitica y Sintetica                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 - Colombia                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÏÍÑÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Jonathan Glz³02/06/16³TVAOI0 ³Se agrega el reporte en formato TReport. ³±±
±±³            ³        ³-------³                                         ³±±
±±³Jonathan Glz³06/07/16³TVJBFO ³Se implementa el uso de CriaTrab en lugar³±± 
±±³            ³        ³-------³de usar QRYREL, se cambia condicion para ³±±
±±³            ³        ³-------³el filtro de documentos cancelados       ³±±
±±³Oscar Garcia³21/05/18³DMINA2802³ Se elimina funcion Matr996,se sutituye³±± 
±±³            ³        ³---------³ CriaTrab por FWTemporaryTable         ³±±
±±³Oscar Garcia³20/09/18³DMINA4368³ Se retorna funcion Matr996 la cual    ³±± 
±±³            ³        ³---------³ llama a al funcion Matr996A para la   ³±±
±±³            ³        ³---------³ generación de Informe Auxiliar de Imp.³±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Matr996()

	U_Matr996A() //llamada del reporte en TREPORT

Return

User Function Matr996B()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identIficando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aOrd :={OemToAnsi(STR0037),;   // Concepto + Cliente/Proveedor + Fecha
OemToAnsi(STR0038),;   // Cliente/Proveedor + Concepto + Fecha
OemToAnsi(STR0039),;   // Fecha + Concepto + Cliente/Proveedor
OemToAnsi(STR0040) }   // Fecha + Cliente/Proveedor + Concepto

SetPrvt("Z,M")
SetPrvt("CNATUREZA,ARETURN,NLASTKEY,LCONTINUA")
SetPrvt("WNREL,NTAMNF,CSTRING,CPEDANT,LiINI")
SetPrvt("CEXTENSO,CNO_IDENT,NPG,CNIT,NIND,NTAM")
SetPrvt("NANO_FISCAL, NMES_DE, NMES_ATE, CPERI_DE, CPERI_ATE")
SetPrvt("APERIODO,NTOT_RETIVA")

Private cPerg   	:="MTR996"
PRIVATE tamanho 	:="M"
Private limite  	:= 132
Private titulo  	:= OemToAnsi(STR0001)  // "Informe Auxiliar "
Private cDesc1  	:= OemToAnsi(STR0002)  // "Emision de Retenciones"
Private cDesc2  	:=""
Private cDesc3  	:=""
Private nomeprog	:="MATR996"
Private lAnual, lEntrada, dDataDe, dDataAte, cNitCCde, cNitCCAte, cDocDe, cDocAte
Private nDecs 		:= MsDecimais(1)
Private	M_PAG		:=	1
Private wcbcont		:=	1
Private cbTxt		:=	""
Private oTmpTable	:= Nil
cNatureza       	:=""
aReturn         	:= {OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 1, 2, 1,"",1 }
nLastKey        	:= 0
lContinua       	:= .T.
wnrel           	:= "MATR996"
cString         	:="SF3"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                       ³
//³ mv_par01  // Imposto                                       ³
//³ mv_par02  // Tipo de Operacion - Entradas/Salidas          ³
//³ mv_par03  // Tipo de Listado - Sintetico/Analitico         ³
//³ mv_par04  // Do  Periodo Fiscal                            ³
//³ mv_par05  // Ate Periodo Fiscal                            ³
//³ mv_par06  // Tipo de IdentIficacao Fiscal - NIT/CC         ³
//³ mv_par07  // Da  IdentIficacao Fiscal                      ³
//³ mv_par08  // Ate IdentIficacao Fiscal                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)               // Pergunta no SX1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta la interfase estandar con el usuario...                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If ! nLastKey == 27
	SetDefault(aReturn,cString)
	If ! nLastKey == 27
		SFB->(DbSetOrder(1))
		SFB->(DbSeek(xFilial()+mv_par01))
		Titulo 	:=	AllTrim(Titulo) + " " + STR0041+ Alltrim(SFB->FB_DESCR) +  STR0042 +aOrd[aReturn[8]] //"de "###" - Ordenado Por : "
		nTipo       := If(aReturn[4]==1,15,18)
		nImposto    := Iif(Val(SFB->FB_CPOLVRO)==0, 1, Val(SFB->FB_CPOLVRO))
		lEntrada    := mv_par02 == 1  // Retorna .t. se Entrada
		lSintetico  := mv_par03 == 1  // Retorna .t. se Sintetico
		dDataDe     := mv_par04
		dDataAte    := mv_par05
		lNitCC      := mv_par06 == 1  // Retorna .t. se NIT
		cNitCCDe    := mv_par07
		cNitCCAte   := mv_par08
		RptStatus({|lEnd| Seleciona(@lEnd, wnrel, cString)},Titulo)
	Endif
Endif

If oTmpTable <> Nil
	oTmpTable:Delete()
	oTmpTable := Nil
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Seleicona ºAutor  ³Leandro Santos      ºFecha ³  01/29/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera arquivo de trabalho.                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Seleciona()
Local aCampos, cArqTmp, nPosNitCC, nPosPFisica, nPosNome, cCompraVenda
Local bSeek
Local cFilterUsr	:=	aReturn[7]
Local aOrdem := {}
Private cNitCC, cBim, nOrdem:=aReturn[8]

If nOrdem==1
	bSeek	:=	{||	DBSeek(SF3->F3_CFO+SF3->F3_CLIEFOR) }
ElseIf nOrdem==2
	bSeek	:=	{||	DbSeek(SF3->F3_CLIEFOR+SF3->F3_CFO)	}
ElseIf nOrdem==3
	bSeek	:=	{||	DBSeek(DTOS(SF3->F3_ENTRADA)+SF3->F3_CLIEFOR) }
Else
	bSeek	:=	{||	DBSeek(DTOS(SF3->F3_ENTRADA)+SF3->F3_CFO)	}
Endif

aCampos:={{"DTENTRADA"        ,"D",08,0},;
{"NRFISCAL"    ,"C",13,0},;
{"SERIE"       ,"C",13,0},;
{"ESPECIE"     ,"C",TamSx3("F3_ESPECIE")[1],0},;
{"CLIEFOR"     ,"C",TamSx3("F3_CLIEFOR")[1],0},;
{"NOME"        ,"C",40,0},;
{"NITCC"       ,"C",TamSx3(If(lNitCC, "A2_CGC", "A2_PFISICA"))[1],0},;
{"CFO"         ,"C",TamSx3("F3_CFO")[1],0},;
{"BASE"        ,"N",14,2},;
{"ALIQUOTA"    ,"N",06,2},;
{"VALOR"       ,"N",14,2}}

If nOrdem==1
	aOrdem := {"CFO", "CLIEFOR", "DTENTRADA"}
ElseIf nOrdem==2
	aOrdem := {"CLIEFOR", "CFO", "DTENTRADA"}
ElseIf nOrdem==3
	aOrdem := {"DTENTRADA", "CLIEFOR", "CFO"}
Else
	aOrdem := {"DTENTRADA", "CFO", "CLIEFOR"}
Endif

oTmpTable := FWTemporaryTable():New("TMP")
oTmpTable:SetFields(aCampos)
oTmpTable:AddIndex("I1", aOrdem)
oTmpTable:Create()

nPosBase := SF3->(FieldPos("F3_BASIMP"+STR(nImposto,1)))
nPosAliq := SF3->(FieldPos("F3_ALQIMP"+STR(nImposto,1)))
nPosValor:= SF3->(FieldPos("F3_VALIMP"+STR(nImposto,1)))

If lEntrada   // NF de Compra
	DbSelectArea("SA2")
	nPosNitCC   := FieldPos(If(lNitCC, "A2_CGC", "A2_PFISICA"))
	nPosNome    := FieldPos("A2_NOME")
	cCompraVenda:= "C"
Else          // NF de Venta
	DbSelectArea("SA1")
	nPosNitCC   := FieldPos(If(lNitCC, "A1_CGC", "A1_PFISICA"))
	nPosNome    := FieldPos("A1_NOME")
	cCompraVenda:= "V"
Endif
DbSetOrder(1)

// Nao pode dar DbSelectArea("SF3") ou nao achara o clIfor no SA1/2
SF3->(DbSetOrder(1))
SF3->(DbSeek(xFilial()+ DTOS(dDataDe),.t.))
While ! SF3->(Eof()) .and. SF3->F3_ENTRADA <= dDataAte .and. lContinua
	If lAbortPrint
		@ 00,01 PSAY OemToAnsi(STR0036)
		lContinua := .F.
	Else
		
		If !Empty(cFilterUsr).And. ! SF3->((&(cFilterUsr)))
			SF3->(DbSkip())
			Loop
		Endif
			
		If SF3->F3_TIPOMOV = cCompraVenda .And. SF3->(FieldGet(nPosBase)) > 0
			// Aqui estara selecionado o SA1 ou o SA2 dependendo de lEntrada
			DbSeek(xFilial() + SF3->F3_CLIEFOR + SF3->F3_LOJA)
			cNitCC := FieldGet(nPosNitCC)
			If Found() .And. cNitCC >= cNitCCDe .And. cNitCC <= cNitCCAte
				If lSintetico
					TMP->(Eval(bSeek))
					If TMP->(EOF())
						TMP->(dbAppend())
					Endif
				Else
					TMP->(dbAppend())
				Endif
				TMP->DTENTRADA:=SF3->F3_ENTRADA
				TMP->NRFISCAL :=SF3->F3_NFISCAL
				TMP->SERIE    :=SF3->F3_SERIE
				TMP->ESPECIE  :=SF3->F3_ESPECIE
				TMP->CLIEFOR  :=SF3->F3_CLIEFOR
				TMP->NOME     :=FieldGet(nPosNome)
				TMP->NITCC    :=FieldGet(nPosNitCC)
				TMP->CFO      :=SF3->F3_CFO
				TMP->BASE     +=SF3->(FieldGet(nPosBase))
				TMP->ALIQUOTA :=SF3->(FieldGet(nPosAliq))
				TMP->VALOR    +=SF3->(FieldGet(nPosValor))
			Endif
		Endif
	Endif
	SF3->(DbSkip())
Enddo

Imprime()
If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()

TMP->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Imprime   ºAutor  ³Humberto K. Masai   º Data ³  15/05/00   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impresion de la matriz con los datos del CertIficado       º±±
±±º          ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Imprime()
Local nAnoFiscal, cMesDe, cMesAte, nI, nTotImposto
Local aBimestre := {}
Local cCFO		:=	"999999",cClIfor:="999999999",nTotBas:=nTotRet:=nTotBasCF:=nTotRetCF:=0
Local Li  		:= 999
Local cCabec1	:=	IIf(lSintetico,OemToAnsi(STR0007),OemToAnsi(STR0015))  // Proveedor  Razon Social del Contribuyente...
Local cCabec2	:=""
Local nTotGralBas	:=	0
Local nTotGralRet	:=	0
Local lImprime		:= .F.

Local bCond1	:=	{|x| x != TMP->CFO 		}
Local bCond2	:=	{|x| x != TMP->CLIEFOR  }
Local cControle1:=  "9999" //cCFO
Local cControle2:=  "999999999" //cCCliefor
Local nPos1		:=	TMP->(FieldPos("CFO"))
Local nPos2		:=	TMP->(FieldPos("CLIEFOR"))
Local cTipo1	:=	"C"
Local cTipo2	:=	"F"
Local cTxtTot1	:=	"CFO"
Local cTxtTot2	:=	Iif(lEntrada,STR0009,STR0010) //"Proveedor"###"Cliente"
Local xTmp		:=	"9999999999"
Local xDadAnt1
Local xDadAnt2
Local bDadAnt1	:=	{| | STRZERO(Val(TMP->CFO),4)}
Local bDadAnt2  :=	{| | TMP->CLIEFOR 	}

Private nPg, cNIT

nAnoFiscal := GetMv("MV_EXERC1")
cMesDe     := MesExtenso(Month(dDataDe))
cMesAte    := MesExtenso(Month(dDataAte))
nPg     := 0
nTotBase:=nTotRet:=0

If nOrdem	==	2
	bCond1	:=	{|x| x != TMP->CLIEFOR  }
	bCond2	:=	{|x| x != TMP->CFO 		}
	cControle1:=  "999999999" //cCCliefor
	cControle2:=  "9999" //cCFO
	nPos1		:=	TMP->(FieldPos("CLIEFOR"))
	nPos2		:=	TMP->(FieldPos("CFO"))
	cTipo1		:=	"F"
	cTipo2		:=	"C"
	cTxtTot1	:=	Iif(lEntrada,STR0009,STR0010) //"Proveedor"###"Cliente"
	cTxtTot2	:=	"CFO"
	cCabec1		:=	IIf(lSintetico,OemToAnsi(STR0016),OemToAnsi(STR0017))
	xTmp		:=	"9999"
	bDadAnt1	:=	{| | TMP->CLIEFOR }
	bDadAnt2  	:=	{| | STRZERO(Val(TMP->CFO),4)}
ElseIf nOrdem == 3
	bCond1		:=	{|x| x != TMP->DTENTRADA}
	bCond2		:=	{|x| x != TMP->CFO  }
	cControle1	:=  CTOD("")
	cControle2	:=  "9999"
	nPos1		:=	TMP->(FieldPos("DTENTRADA"))
	nPos2		:=	TMP->(FieldPos("CFO"))
	cTipo1		:=	"D"
	cTipo2		:=	"C"
	cTxtTot1	:=	STR0044 //"Fecha "
	cTxtTot2	:=	STR0045 //"CFO"
	cCabec1		:=	IIf(lSintetico,OemToAnsi(STR0018),OemToAnsi(STR0019))
	xTmp		:=	"9999"
	bDadAnt1	:=	{| | DTOC(TMP->DTENTRADA) }
	bDadAnt2  	:=	{| | STRZERO(Val(TMP->CFO),4)}
ElseIf nOrdem == 4
	bCond1		:=	{|x| x != TMP->DTENTRADA}
	bCond2  	:=  {|x| x != TMP->CLIEFOR  }
	cControle1	:=  CTOD("")
	cControle2	:=  "999999999"
	nPos1		:=	TMP->(FieldPos("DTENTRADA"))
	nPos2       :=  TMP->(FieldPos("CLIEFOR"))
	cTipo1		:=	"D"
	cTipo2		:=	"F"
	cTxtTot1	:=	STR0046 //" Fecha "
	cTxtTot2    :=  Iif(lEntrada,STR0009,STR0010) //"Proveedor"###"Cliente"
	cCabec1		:=	IIf(lSintetico,OemToAnsi(STR0020),OemToAnsi(STR0021))
	xTmp        :=  "999999"
	bDadAnt1	:=	{| | DTOC(TMP->DTENTRADA) 	}
	bDadAnt2  	:=	{| | TMP->CLIEFOR			}
Endif

SetRegua(TMP->(RECCOUNT()))
TMP->(dbGotop())
While ! TMP->(EOF()) .And. ! lAbortPrint
	IncRegua()
	
	lImprime := .T.
	If Li  >  54
		If li	<>	999
			Roda( wcbCont, STR0047, Tamanho )
		Endif
		Li	:=	Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,15)
	Endif
	
	If lSintetico
		//Controlar quebra principal
		If Eval(bCond1,cControle1)
			cControle1 := TMP->(FieldGet(nPos1))
			If nTotBas != 0
				@ ++Li,001 PSAY Replicate("-",131)
				@ ++Li,045 PSAY STR0008 + cTxtTot1 + " " + xDadAnt1
				@ Li  ,087 PSAY nTotBas  Picture Tm(nTotBas,16,nDecs)
				@ Li  ,116 PSAY nTotRet  Picture Tm(nTotRet,14,nDecs)
				nTotBas:=nTotRet:=0
			Endif
			If Li  >  50
				If li	<>	999
					Roda( wcbCont, STR0047, Tamanho ) //" Continua..."
				Endif
				Li	:=	Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,15)
			Endif
			@ ++Li,001 PSAY Replicate("-",131)
			PrintCab(cTipo1,@li)
		Endif
		
		PrintItem(lSintetico,@li)
		
		nTotBas+=TMP->BASE
		nTotRet+=TMP->VALOR
	Else
		If Eval(bCond1,cControle1)
			cControle2 := xTmp
		Endif
		//Controlar quebra Secundaria
		If Eval(bCond2,cControle2)
			cControle2 := TMP->(Fieldget(nPos2))
			If nTotBasCF != 0
				@ ++Li,001 PSAY Replicate("-",131)
				@ ++Li,045 PSAY STR0008 + cTxtTot2+" "+ xDadAnt2
				@ Li  ,087 PSAY nTotBasCF  Picture Tm(nTotBasCF,16,nDecs)
				@ Li  ,116 PSAY nTotRetCF  Picture Tm(nTotRetCF,14,nDecs)
				@ ++Li,001 PSAY Replicate("-",131)
				nTotBasCF:=nTotRetCF:=0
			Endif
			//Controlar quebra principal
			If Eval(bCond1,cControle1)
				cControle1 := TMP->(FieldGet(nPos1))
				If nTotBas != 0
					@ ++Li,045 PSAY STR0008 + cTxtTot1+" "+ xDadAnt1
					@ Li  ,087 PSAY nTotBas  Picture Tm(nTotBas,16,nDecs)
					@ Li  ,116 PSAY nTotRet  Picture Tm(nTotRet,14,nDecs)
					@ ++Li,001 PSAY Replicate("-",131)
					nTotBas:=nTotRet:=0
				Endif
				
				If Li  >  50
					If li	<>	999
						Roda( wcbCont,  STR0047, Tamanho ) //" Continua..."
					Endif
					Li	:=	Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,15)
				Endif
				
				@ ++Li,001 PSAY Replicate("-",131)
				PrintCab(cTipo1,@li)
				PrintCab(cTipo2,@li)
			Else
				
				If Li  >  50
					If li	<>	999
						Roda( wcbCont,  STR0047, Tamanho ) //" Continua..."
					Endif
					Li	:=	Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,15)
				Endif
				
				PrintCab(cTipo2,@li)
			Endif
		Endif
		
		PrintItem(lSintetico,@li)
		
		nTotBas		+=TMP->BASE
		nTotRet		+=TMP->VALOR
		nTotBasCF	+=TMP->BASE
		nTotRetCF	+=TMP->VALOR
	Endif
	nTotGralBas	+=	TMP->BASE
	nTotGralRet	+=	TMP->VALOR
	xDadAnt1	:=	Eval(bDadAnt1)
	xDadAnt2	:=	Eval(bDadAnt2)
	TMP->(dbSkip())
Enddo
If lImprime
	If lSintetico
		If nTotBas != 0
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,045 PSAY STR0008 + cTxtTot1 +" "+ xDadAnt1
			@ Li  ,087 PSAY nTotBas  Picture Tm(nTotBas,16,nDecs)
			@ Li  ,116 PSAY nTotRet  Picture Tm(nTotRet,14,nDecs)
			nTotBas:=nTotRet:=0
			
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,045 PSAY OemToAnsi(STR0048) //"Total General :"
			@ Li  ,087 PSAY nTotGralBas  Picture Tm(nTotGralBas,16,nDecs)
			@ Li  ,114 PSAY nTotGralRet  Picture Tm(nTotGralRet,16,nDecs)
			@ ++Li,001 PSAY Replicate("-",131)
		Endif
	Else
		If nTotBasCF != 0
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,045 PSAY STR0008 + cTxtTot2 +" "+ xDadAnt2
			@ Li  ,087 PSAY nTotBasCF  Picture Tm(nTotBasCF,16,nDecs)
			@ Li  ,116 PSAY nTotRetCF  Picture Tm(nTotRetCF,14,nDecs)
			@ ++Li,001 PSAY Replicate("-",131)
			nTotBasCF:=nTotRetCF:=0
			@ ++Li,045 PSAY STR0008 + cTxtTot1 +" "+ xDadAnt1
			@ Li  ,087 PSAY nTotBas  Picture Tm(nTotBas,16,nDecs)
			@ Li  ,116 PSAY nTotRet  Picture Tm(nTotRet,14,nDecs)
			nTotBas:=nTotRet:=0
			
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,001 PSAY Replicate("-",131)
			@ ++Li,045 PSAY OemToAnsi(STR0048) //"Total General :"
			@ Li  ,087 PSAY nTotGralBas  Picture Tm(nTotGralBas,16,nDecs)
			@ Li  ,114 PSAY nTotGralRet  Picture Tm(nTotGralRet,16,nDecs)
			@ ++Li,001 PSAY Replicate("-",131)
		Endif
	Endif

	Roda( wcbCont, cbTxt, Tamanho )
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintItem ºAutor  ³Microsiga           ºFecha ³  01/26/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime iten                                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametro ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintItem(lSintetico,li)

If lSintetico
	Do Case
		Case  nOrdem == 1
			@ ++Li,002 PSAY TMP->CLIEFOR
			@ Li  ,010 PSAY TMP->NOME
			@ Li  ,051 PSAY TMP->NITCC
		Case nOrdem == 2
			@ ++Li,002 PSAY STRZERO(Val(TMP->CFO),4)+" - "+Tabela("13",TMP->CFO,.f.)
		Case  nOrdem == 3
			@ ++Li,002 PSAY STRZERO(Val(TMP->CFO),4)+" - "+Tabela("13",TMP->CFO,.f.)
		Case  nOrdem == 4
			@ ++Li,002 PSAY TMP->CLIEFOR
			@ Li  ,012 PSAY TMP->NOME
			@ Li  ,058 PSAY TMP->NITCC
	EndCase
	@ Li  ,087 PSAY TMP->BASE      Picture Tm(TMP->BASE,16,nDecs)
	@ Li  ,106 PSAY TMP->ALIQUOTA  Picture "99.99"
	@ Li  ,116 PSAY TMP->VALOR     Picture Tm(TMP->VALOR,14,nDecs)
Else
	Do Case
		Case  nOrdem == 1
			@ ++Li,002 PSAY TMP->DTENTRADA
		Case  nOrdem == 2
			@ ++Li,002 PSAY TMP->DTENTRADA
		Case  nOrdem == 3
			@ ++Li,002 PSAY TMP->CLIEFOR
			@ Li  ,010 PSAY TMP->NOME
			@ Li  ,051 PSAY TMP->NITCC
		Case  nOrdem == 4
			@ ++Li,002 PSAY STRZERO(Val(TMP->CFO),4)+" - "+Tabela("13",TMP->CFO,.f.)
	EndCase
	@ Li  ,070 PSAY TMP->NRFISCAL
	@ Li  ,087 PSAY TMP->BASE      Picture Tm(TMP->BASE,16,nDecs)
	@ Li  ,106 PSAY TMP->ALIQUOTA  Picture "99.99"
	@ Li  ,116 PSAY TMP->VALOR     Picture Tm(TMP->VALOR,14,nDecs)
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintCab  ºAutor  ³Microsiga           ºFecha ³  01/26/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Imprime iten                                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametro ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintCab(cCodigo,li)
Do Case
	Case cCodigo == "C"
		@ ++Li,001 PSAY STR0006  // Concepto de Retencion :
		@ Li  ,027 PSAY STRZERO(Val(TMP->CFO),4)+" - "+Tabela("13",TMP->CFO,.f.)
	Case cCodigo == "F"
		@ ++Li,001 PSAY If(lEntrada,STR0013,STR0014)  // Proveedor - Cliente
		@ Li  ,025 PSAY TMP->CLIEFOR+" - "+TMP->NOME + " - NIT/CC : " + TMP->NITCC
	Case cCodigo = "D"
		@ ++Li,001 PSAY STR0049 //"Fecha  "
		@ Li  ,025 PSAY TMP->DTENTRADA
EndCase
@ ++Li,001 PSAY Replicate("-",131)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR996  ³ Autor ³  Alex Hdez.           ³ Data ³   08/04/2016   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Informe Auxiliar de Impuestos                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR996()                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MATR996A()
	Local oReport
	Local aArea := GetArea()
	
		oReport := ReportDef()
		oReport:PrintDialog()
		
	RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportDef   Autor ³  Alex Hdez.           ³ Data ³08/04/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³  Def. Reporte Auxiliar de Impuestos                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³  MATR996                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
	Local oReport
	Local oSection1, oSection2, oSection3, oSection4, oSection5, oSection6, oSection7
	Local cTitulo := OEMTOANSI(Trim(STR0002)) //"Emision de Retenciones"
	
	//Define array de Orden.
	//Concepto + Cliente/Proveedor + Fecha
	//Cliente/Proveedor + Concepto + Fecha
	//Fecha + Concepto + Cliente/Proveedor
	//Fecha + Cliente/Proveedor + Concepto
	Local aOrd := {STR0037, STR0038, STR0039, STR0040}
		
	Private nomeprog:="MTR996"
	Private nImposto, lEntrada, lSintetico, dDataDe, dDataAte, nNitCC, cNitCCDe, cNitCCAte

	cursorwait()
		//Definicion general del reporte
		oReport:=TReport():New(NomeProg,OemToAnsi(cTitulo), NomeProg ,{|oReport| PrintReport(oReport)})
		oReport:SetPortrait(.T.)
		oReport:nColSpace   := 1
		oReport:nFontBody   := 7 
		oReport:cFontBody   := "COURIER NEW"
		oReport:EndPage(.T.)
		
		// Seccion de "Encabezado" 
		oSection1:= TRSection():New(oReport,oemtoansi(STR0057),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/)
		oSection1:SetHeaderSection(.F.)	//Exibe Cabecalho da Secao
		oSection1:SetHeaderPage(.F.)	//Exibe Cabecalho da Secao
		oSection1:SetLineStyle(.T.)   //Pone titulo del campo y aun lado el y valor
		OSection1:SetCharSeparator(" ")
		oSection1:SetHeaderBreak(.T.)

		//Definicion de celdas Encabezado 
		//"Concepto: "
		//"Cliente: "
		//"Fecha: "
		TRCell():New( oSection1 , "CONCEPTO" , /*alias*/ , STR0058 , /*Picture*/ ,  85 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection1 , "CLIENTE"  , /*alias*/ , STR0059 , /*Picture*/ , 150 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection1 , "FECHA"	 , /*alias*/ , STR0060 , /*Picture*/ ,  12 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

		//Seccion "Detalle" 
		oSection2:= TRSection():New(oReport,oemtoansi(STR0062),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/)
		oSection2:SetLineStyle(.F.)     //Pone titulo del campo y aun lado el y valor
		oSection2:SetHeaderPage(.F.)    //Exibe Cabecalho da Secao
		oSection2:SetHeaderSection(.T.) //Exibe Cabecalho da Secao

		//Definicion de celdas Detalle 
		//Concepto
		//Codigo
		//Razon Social
		//NIT/CC
		//Monto Base
		//Tasa
		//Monto Retenido
		TRCell():New( oSection2 , "CONCEPTO" , /*alias*/ , STR0063 , /*Picture*/                  , 97                         , /*lPixel*/    , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "CLIENTE"  , /*alias*/ , STR0064 , /*Picture*/                  , 25                         , /*lPixel*/    , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "RAZONSOC" , /*alias*/ , STR0065 , /*Picture*/                  , 50                         , /*lPixel*/    , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "NITCC"    , /*alias*/ , STR0066 , /*Picture*/                  , 25                         , /*lPixel*/    , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "MONTOBAS" , /*alias*/ , STR0067 , PesqPict("SF3","F3_BASIMP1") , TamSx3("F3_BASIMP1")[1]+10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "TASA"     , /*alias*/ , STR0068 , PesqPict("SF3","F3_ALQIMP1") , TamSx3("F3_ALQIMP1")[1]    , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection2 , "MONTORET" , /*alias*/ , STR0069 , PesqPict("SF3","F3_VALIMP1") , TamSx3("F3_VALIMP1")[1]+10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

			// Seccion de "Encabezado (Analitico)"
			oSection3:= TRSection():New(oSection1,oemtoansi(STR0061),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/)
			oSection3:SetHeaderSection(.F.)	//Exibe Cabecalho da Secao
			oSection3:SetHeaderPage(.F.)	//Exibe Cabecalho da Secao
			oSection3:SetLineStyle(.T.)   //Pone titulo del campo y aun lado el y valor
			OSection3:SetCharSeparator(" ")
			oSection3:SetHeaderBreak(.T.)

			//Definicion de celdas Encabezado (Analitico)
			//Concepto
			//Cliente
			//Fecha
			TRCell():New( oSection3 , "CONCEPTO_AN" , /*alias*/ , STR0058 , /*Picture*/ ,  85 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection3 , "CLIENTE_AN"  , /*alias*/ , STR0059 , /*Picture*/ , 150 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection3 , "FECHA_AN"    , /*alias*/ , STR0060 , /*Picture*/ ,  12 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

			//Seccion "Detalle (Analitico)"
			oSection4:= TRSection():New(oSection3,oemtoansi(STR0070),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/)
			oSection4:SetLineStyle(.F.) //Pone titulo del campo y aun lado el y valor
			oSection4:SetHeaderPage(.F.) //Exibe Cabecalho da Secao
			oSection4:SetHeaderSection(.T.) //Exibe Cabecalho da Secao

			//Definicion de celdas sub Detalle Analitico
			//Fecha
			//Concepto
			//Cliente (Cod + Loja)
			//Razon Social
			//NIT/CC
			//Documento
			//Monto Base
			//Tasa
			//Monto Retenido
			TRCell():New( oSection4 , "FECHA_AN"    , /*alias*/ , STR0071 , /*Picture*/                  , 25                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "CONCEPTO_AN" , /*alias*/ , STR0063 , /*Picture*/                  , 60                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "CLIENTE_AN"  , /*alias*/ , STR0064 , /*Picture*/                  , 15                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "RAZONSOC_AN" , /*alias*/ , STR0065 , /*Picture*/                  , 40                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "NITCC_AN"    , /*alias*/ , STR0066 , /*Picture*/                  , 15                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "DOCMENTO_AN" , /*alias*/ , STR0072 , PesqPict("SF3","F3_NFISCAL") , 25                      , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "MONTOBAS_AN" , /*alias*/ , STR0067 , PesqPict("SF3","F3_BASIMP1") , TamSx3("F3_BASIMP1")[1] , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "TASA_AN"     , /*alias*/ , STR0068 , PesqPict("SF3","F3_ALQIMP1") , TamSx3("F3_ALQIMP1")[1] , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection4 , "MONTORET_AN" , /*alias*/ , STR0069 , PesqPict("SF3","F3_VALIMP1") , TamSx3("F3_VALIMP1")[1] , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

			//Seccion totales sub detalle
			oSection5:= TRSection():New(oSection3,oemtoansi(STR0076),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/) //"Detalle total"
			oSection5:SetLineStyle(.F.)   //Pone titulo del campo y aun lado el valor
			oSection5:SetHeaderPage(.F.)	//Exibe Cabecalho da Secao
			oSection5:SetHeaderSection(.T.)	//Exibe Cabecalho da Secao
	
			//Definicion de celdas totales sub detalle
			//Total Base
			//Total Retencion
			TRCell():New( oSection5 , "CLAVE_AN"    , /*alias*/ , ""      , /*Picture*/                  , 88                           , /*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection5 , "TOT_BASE_AN" , /*alias*/ , STR0077 , PesqPict("SF3","F3_BASIMP1") , TamSx3("F3_BASIMP1")[1] + 10 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection5 , "SPACE1_AN"   , /*alias*/ , ""      , /*Picture*/                  , TamSx3("F3_ALQIMP1")[1] + 5  , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
			TRCell():New( oSection5 , "TOT_RETE_AN" , /*alias*/ , STR0078 , PesqPict("SF3","F3_VALIMP1") , TamSx3("F3_VALIMP1")[1] + 10 , /*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

		//Seccion totales Cuerpo
		oSection6:= TRSection():New(oReport,oemtoansi(STR0073),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/) //"Detalle total"
		oSection6:SetLineStyle(.F.)   //Pone titulo del campo y aun lado el valor
		oSection6:SetHeaderPage(.F.)	//Exibe Cabecalho da Secao
		oSection6:SetHeaderSection(.T.)	//Exibe Cabecalho da Secao

		//Definicion de celdas totales Cuerpo
		//Total Base
		//Total Retencion
		TRCell():New( oSection6 , "CLAVE"    , /*alias*/ , ""      , /*Picture*/                  , 97                           , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection6 , "TOT_BASE" , /*alias*/ , STR0074 , PesqPict("SF3","F3_BASIMP1") , TamSx3("F3_BASIMP1")[1] + 10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection6 , "SPACE1"   , /*alias*/ , ""      , /*Picture*/                  , TamSx3("F3_ALQIMP1")[1]      , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection6 , "TOT_RETE" , /*alias*/ , STR0075 , PesqPict("SF3","F3_VALIMP1") , TamSx3("F3_VALIMP1")[1] + 10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

		//Seccion totales general
		oSection7:= TRSection():New(oReport,oemtoansi(STR0079),,aOrd,/*Campos do SX3*/,/*Campos do SIX*/) //" total"
		oSection7:SetLineStyle(.F.)   //Pone titulo del campo y aun lado el valor
		oSection7:SetHeaderPage(.F.)	//Exibe Cabecalho da Secao
		oSection7:SetHeaderSection(.T.)	//Exibe Cabecalho da Secao

		//Definicion de celdas totales Cuerpo
		//Total Base
		//Total Retencion
		TRCell():New( oSection7 , "CLAVE1"        , /*alias*/ , ""      , /*Picture*/                  , 97                           , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "LEFT"  , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection7 , "TOT_BASE_GRAL" , /*alias*/ , STR0080 , PesqPict("SF3","F3_BASIMP1") , TamSx3("F3_BASIMP1")[1] + 10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection7 , "SPACE2"        , /*alias*/ , ""      , /*Picture*/                  , TamSx3("F3_ALQIMP1")[1]      , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )
		TRCell():New( oSection7 , "TOT_RETE_GRAL" , /*alias*/ , STR0081 , PesqPict("SF3","F3_VALIMP1") , TamSx3("F3_VALIMP1")[1] + 10 , .T./*lPixel*/ , /*{|| code-block de impressao }*/ , "RIGHT" , /*lLineBreak*/ , "LEFT" , /*lCellBreak*/ , /*nColSpace*/ , /*lAutoSize*/ , /*nClrBack*/ , /*nClrFore*/ )

		OSECTION1:NLINESBEFORE:=0
		OSECTION2:NLINESBEFORE:=0
		OSECTION3:NLINESBEFORE:=0
		OSECTION4:NLINESBEFORE:=0
		OSECTION5:NLINESBEFORE:=0
		OSECTION6:NLINESBEFORE:=0
		OSECTION7:NLINESBEFORE:=0
	cursorarrow()
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³PrintReport Autor ³ Alex Hdez.            ³ Data ³08/04/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³   Impresión del Informe                                    ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³    PrintReport(oExp)                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³  MATR996                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PrintReport(oReport)
	Local aArea     := GetArea() 
	Local oSection1 := oReport:Section(1)            //encabezado
	Local oSection2 := oReport:Section(2)            //detalle
	Local oSection3 := oReport:Section(1):Section(1) //Encabezado sub detalle (Analitico)
	Local oSection4 := oReport:Section(1):Section(1):Section(1) //Detalle sub detalle (Analitico)
	Local oSection5 := oReport:Section(1):Section(1):Section(2) //Total sub detalle (Analitico)
	Local oSection6 := oReport:Section(3)            //Total
	Local oSection7 := oReport:Section(4)            //Total General
	Local cTitulo   := OEMTOANSI(Trim(STR0002))     //"Emision de Retenciones"
	Local cPerg     := "MTR996"
	Local nTBaseGrl := 0, nTReteGrl := 0, nTotBase  := 0, nTotRete  := 0, nTBaseSub := 0, nTReteSub := 0
	Local cTCliente := "", cTConcpto := ""
	
	Private cQryRET := CriaTrab(Nil, .F.) //'QRYREL'
	Private nOrd    := oReport:nOrder
	Private cOrdem  := "", cOrden  := "", cSelect := "", cFiltro := "", cTotal  := ""
	Private cClave , cCampo, cClave2, cCampo2

		Pergunte(cPerg,.F.)  //Actualiza grupo de preguntas
		
		SFB->(DbSetOrder(1))
		SFB->(DbSeek(xFilial("SFB")+mv_par01))
		nImposto    := Val(SFB->FB_CPOLVRO) //Tipo impuesto
		lEntrada    := mv_par02 == 1  // Retorna .t. se Entrada
		lSintetico  := mv_par03 == 1  // Retorna .t. se Sintetico
		dDataDe     := mv_par04 // Fecha de
		dDataAte    := mv_par05 // Fecha haste
		nNitCC      := mv_par06 // Ident Fiscal (NIT, Cedula o Ambos)
		cNitCCDe    := mv_par07 // Documento de
		cNitCCAte   := mv_par08 // Documento hasta

		CreaQuery( @cTitulo, @cOrdem , @cSelect , @cFiltro , SFB->FB_DESCR ) //Funcion para crear el query.

		oReport:SetTitle(UPPER(cTitulo)) //actualiza titulo del informe

		if lEntrada //Consulta para Proveedores
			BeginSql alias cQryRET
				SELECT  %exp:cSelect%
				FROM %table:SF3% SF3, %table:SA2% SA2
				WHERE  %exp:cFiltro%
				ORDER BY %Exp:cOrdem%
			EndSql
		Else // Consulta para Clientes
			BeginSql alias cQryRET
				SELECT  %exp:cSelect%
				FROM %table:SF3% SF3, %table:SA1% SA1
				WHERE  %exp:cFiltro%
				ORDER BY %Exp:cOrdem%
			EndSql
		EndIF

		If (cQryRET)->(Eof())
			MsgInfo(OemToAnsi(STR0055)) //"No hay registros para los parámetros"
			Return .F.
		EndIf

		dbSelectArea( cQryRET )
		count to nTotal
		oReport:SetMeter(nTotal)
		(cQryRET)->(DbGoTop())

		While !oReport:Cancel() .And. !(cQryRET)->(Eof())
			nTotBase := 0
			nTotRete := 0
			
			oSection1:Init()
			If nOrd == 1 //Concepto Retencion, Cliente/Proveedor y Fecha
				cClave := (cQryRET)->F3_CFO
				cCampo := "(cQryRET)->F3_CFO"
				oSection1:Cell("CONCEPTO"):SetValue( ALLTRIM(cClave) + " - " + Tabela( "13" , cClave , .f. ) )
				oSection1:Cell("CLIENTE"):Disable()
				oSection1:Cell("FECHA"):Disable()
			ElseIF nOrd == 2 //Cliente/Proveedor, Concepto Retencion y Fecha
				cClave   := (cQryRET)->F3_CLIEFOR
				cCampo   := "(cQryRET)->F3_CLIEFOR"
				If lEntrada
					oSection1:Cell("CLIENTE"):SetTitle(STR0050) //"Proveedor :  "
				Else
					oSection1:Cell("CLIENTE"):SetTitle(STR0051)  //"Cliente:  "
				Endif
				oSection1:Cell("CONCEPTO"):Disable()
				oSection1:Cell("CLIENTE"):SetValue( RTRIM((cQryRET)->F3_CLIEFOR) + " - " + RTRIM((cQryRET)->LOJA) + " - " + ;
				                                    RTRIM((cQryRET)->Nome) + " - " + if (nNitCC == 1, STR0056 + (cQryRET)->NIT , ;
				                                    If (nNitCC == 2, STR0054 + (cQryRET)->Cedula , ;
				                                    STR0052 + ALLTRIM((cQryRET)->NIT)  + "/" + ALLTRIM((cQryRET)->Cedula) ) ) )
				oSection1:Cell("FECHA"):Disable()
			//3.- Fecha, Concepto Retencion y Cliente / Proveedor
			//4.- Fecha, Cliente/Proveedor y Concepto Retencion
			ElseIF nOrd == 3 .OR. nOrd == 4 
				cClave := (cQryRET)->F3_ENTRADA
				cCampo := "(cQryRET)->F3_ENTRADA"
				oSection1:Cell("CONCEPTO"):Disable()
				oSection1:Cell("CLIENTE"):Disable()
				oSection1:Cell("FECHA"):SetValue( DTOC ( STOD( (cQryRET)->F3_ENTRADA ) ) )
			EndIf
			oSection1:printline()
			oSection1:Finish()
			
			If lSintetico
				oSection2:Init()
			EndIf
			
			While !oReport:Cancel() .And. !(cQryRET)->(Eof()) .AND. cClave == &cCampo
				If lSintetico
					If nOrd == 1 .OR. nOrd == 4
						oSection2:Cell("CONCEPTO"):Disable()
						oSection2:Cell("CLIENTE" ):SetValue( ALLTRIM( (cQryRET)->F3_CLIEFOR ) + " - " +ALLTRIM( (cQryRET)->LOJA ) )
						oSection2:Cell("RAZONSOC"):SetValue( (cQryRET)->Nome )
						oSection2:Cell("NITCC"   ):SetValue( ALLTRIM( (cQryRET)->NIT ) + " / "  + ALLTRIM( (cQryRET)->Cedula ) )
						oSection2:Cell("MONTOBAS"):SetValue( (cQryRET)->SUMBase )
						oSection2:Cell("TASA"    ):SetValue( (cQryRET)->Aliquota )
						oSection2:Cell("MONTORET"):SetValue( (cQryRET)->SUMValor )
					ElseIf nOrd == 2 .OR. nOrd == 3
						oSection2:Cell("CONCEPTO"):SetValue( (cQryRET)->F3_CFO + " - " + Tabela( "13" , (cQryRET)->F3_CFO , .f. ) )
						oSection2:Cell("CLIENTE" ):Disable()
						oSection2:Cell("RAZONSOC"):Disable()
						oSection2:Cell("NITCC"   ):Disable()
						oSection2:Cell("MONTOBAS"):SetValue( (cQryRET)->SUMBase )
						oSection2:Cell("TASA"    ):SetValue( (cQryRET)->Aliquota )
						oSection2:Cell("MONTORET"):SetValue( (cQryRET)->SUMValor )
					EndIF
					oSection2:Printline()

					nTotBase += (cQryRET)->SUMBase
					nTotRete += (cQryRET)->SUMValor
					
					dbSkip()
					oReport:IncMeter()
					If oReport:Cancel()
						Exit
					EndIf
					
				Else //analitico
					oSection3:Init()
					//1.- Concepto Retencion, Cliente/Proveedor y Fecha
					//4.- Fecha, Cliente/Proveedor y Concepto Retencion
					If nOrd == 1 .OR. nOrd == 4 
						cClave2 := (cQryRET)->F3_CLIEFOR
						cCampo2 := "(cQryRET)->F3_CLIEFOR"
						oSection3:Cell("CONCEPTO_AN"):Disable()
						oSection3:Cell("CLIENTE_AN"):SetValue( RTRIM((cQryRET)->F3_CLIEFOR) + " - " + RTRIM((cQryRET)->LOJA) + " - " + ;
						                                    RTRIM((cQryRET)->Nome) + " - " + if (nNitCC == 1, STR0056 + (cQryRET)->NIT , ;
						                                    If (nNitCC == 2, STR0054 + (cQryRET)->Cedula , ;
						                                    STR0052 + ALLTRIM((cQryRET)->NIT)  + "/" + ALLTRIM((cQryRET)->Cedula) ) ) )
						oSection3:Cell("FECHA_AN"):Disable()
						cTCliente := RTRIM((cQryRET)->F3_CLIEFOR) + " - " + RTRIM((cQryRET)->LOJA) + " - " + RTRIM((cQryRET)->Nome)
					//2.- Cliente/Proveedor, Concepto Retencion y Fecha 
					//3.- Fecha, Concepto Retencion y Cliente / Proveedor
					ElseIF nOrd == 2 .OR. nOrd == 3 
						cClave2 := (cQryRET)->F3_CFO
						cCampo2 := "(cQryRET)->F3_CFO"
						oSection3:Cell("CONCEPTO_AN"):SetValue( ALLTRIM(cClave2) + " - " + Tabela( "13" , cClave2 , .f. ) )
						oSection3:Cell("CLIENTE_AN"):Disable()
						oSection3:Cell("FECHA_AN"):Disable()
						cTConcpto := ALLTRIM(cClave2) + " - " + Tabela( "13" , cClave2 , .f. ) 
					EndIf
					oSection3:printline()
					oSection3:Finish()

					nTBaseSub := 0
					nTReteSub := 0				
					oSection4:Init()
					While !oReport:Cancel() .And. !(cQryRET)->(Eof()) .AND. cClave == &cCampo  .AND. cClave2 == &cCampo2 
						If nOrd == 1 .OR. nOrd == 2
							oSection4:Cell("FECHA_AN"   ):SetValue( DTOC ( STOD( (cQryRET)->F3_ENTRADA ) ) ) 
							oSection4:Cell("CONCEPTO_AN"):Disable()
							oSection4:Cell("CLIENTE_AN" ):Disable()
							oSection4:Cell("RAZONSOC_AN"):Disable()
							oSection4:Cell("NITCC_AN"   ):Disable()
							oSection4:Cell("DOCMENTO_AN"):SetValue( ALLTRIM((cQryRET)->F3_NFISCAL) )
							oSection4:Cell("MONTOBAS_AN"):SetValue( (cQryRET)->Base )
							oSection4:Cell("TASA_AN"    ):SetValue( (cQryRET)->Aliquota )
							oSection4:Cell("MONTORET_AN"):SetValue( (cQryRET)->Valor )
						Elseif nOrd == 3
							oSection4:Cell("DOCMENTO_AN"):SetSize(15,.F.)
							oSection4:Cell("FECHA_AN"   ):Disable()
							oSection4:Cell("CONCEPTO_AN"):Disable()
							oSection4:Cell("CLIENTE_AN" ):SetValue( ALLTRIM( (cQryRET)->F3_CLIEFOR ) + " - " + ALLTRIM( (cQryRET)->LOJA ) )
							oSection4:Cell("RAZONSOC_AN"):SetValue( (cQryRET)->Nome )
							oSection4:Cell("NITCC_AN"   ):SetValue( ALLTRIM( (cQryRET)->NIT ) + " / "  + ALLTRIM( (cQryRET)->Cedula ) )
							oSection4:Cell("DOCMENTO_AN"):SetValue( ALLTRIM((cQryRET)->F3_NFISCAL) )
							oSection4:Cell("MONTOBAS_AN"):SetValue( (cQryRET)->Base )
							oSection4:Cell("TASA_AN"    ):SetValue( (cQryRET)->Aliquota )
							oSection4:Cell("MONTORET_AN"):SetValue( (cQryRET)->Valor )
						Elseif nOrd == 4
							oSection4:Cell("DOCMENTO_AN"):SetSize(20,.F.)
							oSection4:Cell("FECHA_AN"   ):Disable()
							oSection4:Cell("CONCEPTO_AN"):SetValue( (cQryRET)->F3_CFO + " - " + Tabela( "13" , (cQryRET)->F3_CFO , .f. ) )
							oSection4:Cell("CLIENTE_AN" ):Disable()
							oSection4:Cell("RAZONSOC_AN"):Disable()
							oSection4:Cell("NITCC_AN"   ):Disable()
							oSection4:Cell("DOCMENTO_AN"):SetValue( ALLTRIM((cQryRET)->F3_NFISCAL) )
							oSection4:Cell("MONTOBAS_AN"):SetValue( (cQryRET)->Base )
							oSection4:Cell("TASA_AN"    ):SetValue( (cQryRET)->Aliquota )
							oSection4:Cell("MONTORET_AN"):SetValue( (cQryRET)->Valor )
						EndIF
						oSection4:Printline()
						
						nTBaseSub += (cQryRET)->Base
						nTReteSub += (cQryRET)->Valor
						
						dbSkip()
						oReport:IncMeter()
						If oReport:Cancel()
							Exit
						EndIf
					ENDDO
					oSection4:Finish()
					
					oSection5:Init()
						If nOrd == 1 .OR. nOrd == 4 
							cTotal := STR0008 + If (lEntrada ,STR0050 ,STR0051 ) + cTCliente //"Total " ##//"Proveedor :  " ##//"Cliente:  "
						ElseIF nOrd == 2 .OR. nOrd == 3 
							cTotal := STR0008 + STR0006 + cTConcpto //"Total " ##//"Concepto de Retencion :"
						EndIf							
						IF nOrd == 3 
							oSection5:Cell("CLAVE_AN"  ):SetSize(100,.F.)
							oSection5:Cell("SPACE1_AN" ):SetSize(1,.F.)
						ELSEIF nOrd == 4 
							oSection5:Cell("CLAVE_AN"  ):SetSize(100,.F.)
							oSection5:Cell("SPACE1_AN" ):SetSize(2,.F.)
						EndIf
						
						oSection5:Cell("CLAVE_AN"   ):SetValue(cTotal)
						oSection5:Cell("TOT_BASE_AN"):SetTitle(" ")
						oSection5:Cell("TOT_BASE_AN"):SetValue(nTBaseSub)
						oSection5:Cell("SPACE1_AN"  ):SetValue("")
						oSection5:Cell("TOT_RETE_AN"):SetTitle(" ")
						oSection5:Cell("TOT_RETE_AN"):SetValue(nTReteSub)
					oSection5:printline()
					oSection5:Finish()
					oReport:SkipLine(2)	
					
					nTotBase += nTBaseSub
					nTotRete += nTReteSub
				EndIf
			ENDDO

			If lSintetico
				oSection2:Finish()
			EndIf
			
			oReport:SkipLine(1)
			oSection6:Init()
				If nOrd == 1 
					cTotal := STR0008 + STR0006 + oSection1:Cell("CONCEPTO"):GetValue() //"Total " ##//"Concepto de Retencion :"
				ElseIF nOrd == 2 
					cTotal := STR0008 + If (lEntrada ,STR0050 ,STR0051 ) + oSection1:Cell("CLIENTE"):GetValue() //"Total " ##//"Proveedor :  " ##//"Cliente:  "
				ElseIF nOrd == 3 .OR. nOrd == 4 
					cTotal := STR0008 + STR0053 + oSection1:Cell("FECHA"):GetValue() //"Total " ##//STR0053
				EndIf
				
				If !lSintetico
					If nOrd == 1 .OR. nOrd == 2 
						oSection6:Cell( "CLAVE"  ):SetSize(88,.F.)
						oSection6:Cell( "SPACE1" ):SetSize(TamSx3("F3_ALQIMP1")[1] + 5  ,.T.)
					ElseIF nOrd == 3
						oSection6:Cell( "CLAVE"  ):SetSize(100,.F.)
						oSection6:Cell( "SPACE1" ):SetSize(1,.F.)
					ElseIF nOrd == 4 
						oSection6:Cell( "CLAVE"  ):SetSize(100,.F.)
						oSection6:Cell( "SPACE1" ):SetSize(2,.F.)
					EndIf
				EndIf
				oSection6:Cell("CLAVE"   ):SetValue(cTotal)
				oSection6:Cell("TOT_BASE"):SetTitle(" ")
				oSection6:Cell("TOT_BASE"):SetValue(nTotBase)
				oSection6:Cell("SPACE1"  ):SetValue("")
				oSection6:Cell("TOT_RETE"):SetTitle(" ")
				oSection6:Cell("TOT_RETE"):SetValue(nTotRete)
			oSection6:printline()
			oSection6:Finish()
			oReport:SkipLine(2)	

			nTBaseGrl += nTotBase
			nTReteGrl += nTotRete
		EndDo
		
		oReport:SkipLine(2)
		oSection7:Init()
			If !lSintetico
				If nOrd == 1 .OR. nOrd == 2 
					oSection7:Cell( "CLAVE1" ):SetSize(88,.F.)
					oSection7:Cell( "SPACE2" ):SetSize(TamSx3("F3_ALQIMP1")[1] + 5  ,.T.)
				ElseIF nOrd == 3 
					oSection7:Cell( "CLAVE1" ):SetSize(100,.F.)
					oSection7:Cell( "SPACE2" ):SetSize(1,.F.)
				ElseIF nOrd == 4 
					oSection7:Cell( "CLAVE1" ):SetSize(100,.F.)
					oSection7:Cell( "SPACE2" ):SetSize(2,.F.)
				EndIf
			EndIf
			oSection7:Cell("CLAVE1"       ):SetValue("")
			oSection7:Cell("TOT_BASE_GRAL"):SetValue(nTBaseGrl)
			oSection7:Cell("SPACE2"       ):SetValue("")
			oSection7:Cell("TOT_RETE_GRAL"):SetValue(nTReteGrl)
		oSection7:printline()
		oSection7:Finish()
		
		oReport:EndReport()

	(cQryRET)->(dbCloseArea())
	RestArea(aArea)
Return 

/*/
ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿
³Fun‡„o    ³CreaQuery ³Autor  ³ Jonathan Glez         ³ Data ³24/05/2016³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´
³Descri‡„o ³Ceea el query que sera usado en el reporte para la sacar los³
³          ³datos a imprimir.                                           ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Sintaxe   ³CreaQuery(ExpC1,ExpC2,ExpC3,ExpC4,ExpC5)                    ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³Parametros³ExpC1 - titulo que se usara en el reporte.                  ³
³          ³ExpC2 - cadena que se usara en el Query para el orden.      ³
³          ³ExpC3 - cadena que se usara en el Query para el select.     ³
³          ³ExpC4 - cadena que se usara en el Query para el filtro.     ³
³          ³ExpC5 - Descripcion que se usara para el titulo.            ³
ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
³ Uso      ³  PrintReport                                               ³
ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/
static function CreaQuery( cTitulo , cOrdem , cSelect , cFiltro , cDESCR)
	Local aArea     := GetArea()
	Local cBase     := ""
	Local cAliquota := ""
	Local cValor    := ""
	Local cGroupo   := ""

		If nOrd == 1
			cOrden := STR0037  //"Concepto + Cliente/Proveedor + Fecha"
			cOrdem := IIF( lSintetico , "% F3_CFO, F3_CLIEFOR %"  , "% F3_CFO, F3_CLIEFOR, F3_ENTRADA %" )
		ElseIf nOrd == 2
			cOrden := STR0038  //"Cliente/Proveedor + Concepto + Fecha"
			cOrdem := IIF( lSintetico , "% F3_CLIEFOR, F3_CFO %" , "% F3_CLIEFOR, F3_CFO, F3_ENTRADA %" )
		ElseIf nOrd == 3
			cOrden := STR0039 //"Fecha + Concepto + Cliente/Proveedor"
			cOrdem := "% F3_ENTRADA, F3_CFO, F3_CLIEFOR %"
		Elseif nOrd == 4
			cOrden := STR0040 //"Fecha + Cliente/Proveedor + Concepto"
			cOrdem := "% F3_ENTRADA, F3_CLIEFOR, F3_CFO %"
		Endif
		                  //"Informe Auxiliar         "###"de"##"                     - Ordenado por : "
		cTitulo   := ALLTRIM(OemToAnsi(STR0001)) + " " + STR0041 + ALLTRIM(cDESCR) +  STR0042 + OemToAnsi(cOrden) 
		cBase     := "F3_BASIMP"+STR(nImposto,1)
		cAliquota := "F3_ALQIMP"+STR(nImposto,1)
		cValor    := "F3_VALIMP"+STR(nImposto,1)
	
		IF lSintetico
			If nOrd == 1 .OR.  nOrd == 2
				cSelect := "%  F3_CLIEFOR, F3_CFO, "
				IF lEntrada
					cGroupo := " SF3.F3_CFO, SF3.F3_CLIEFOR, SA2.A2_NOME, SA2.A2_CGC, SA2.A2_PFISICA, SA2.A2_LOJA , " + cAliquota +" "
				Else
					cGroupo := " SF3.F3_CFO, SF3.F3_CLIEFOR, SA1.A1_NOME, SA1.A1_CGC, SA1.A1_PFISICA, SA1.A1_LOJA , " + cAliquota +" "
				ENDIf
			ELSEIF nOrd == 3 .OR.  nOrd == 4
				cSelect := "%  F3_CLIEFOR, F3_CFO, F3_ENTRADA, "
				IF lEntrada
					cGroupo := " F3_ENTRADA, SF3.F3_CFO, SF3.F3_CLIEFOR, SA2.A2_NOME, SA2.A2_CGC, SA2.A2_PFISICA, SA2.A2_LOJA , " + cAliquota +" "
				ELSE
					cGroupo := " F3_ENTRADA, SF3.F3_CFO, SF3.F3_CLIEFOR, SA1.A1_NOME, SA1.A1_CGC, SA1.A1_PFISICA, SA1.A1_LOJA , " + cAliquota +" "
				ENDIf
			ENDIF
			cSelect +=" SUM(" + cBase + ") SUMBase, " + cAliquota +  " Aliquota, SUM(" + cValor + ") SUMValor, "
		Else
			cSelect := "% F3_ENTRADA, F3_NFISCAL, F3_CLIEFOR, F3_CFO, "
			cSelect += cBase + " Base, " + cAliquota + " Aliquota, " + cValor + " Valor, "
		EndIF
		cFiltro := "% F3_ENTRADA >= '" + Dtos(dDataDe) + "' AND F3_ENTRADA  <=  '" + Dtos(dDataAte) + "' AND " + cBase + " > 0 AND "
		IF lEntrada  // NF de Compra
			cSelect += "A2_NOME Nome, A2_CGC NIT, A2_PFISICA Cedula, A2_LOJA LOJA %"
		ELSE
			cSelect += "A1_NOME Nome, A1_CGC NIT, A1_PFISICA Cedula, A1_LOJA LOJA %"
		ENDIF
		cFiltro += IIF( lEntrada , " F3_TIPOMOV = 'C'  " , " F3_TIPOMOV = 'V'  " )
		IF nNitCC == 1 //NIT
			IF lEntrada
				cFiltro += " AND A2_CGC >= '" + cNitCCDe + "' AND A2_CGC <= '" + cNitCCAte + "' "
			ELSE
				cFiltro += " AND A1_CGC >= '" + cNitCCDe + "' AND A1_CGC <= '" + cNitCCAte + "' "
			ENDIF
		ElseIf nNitCC == 2 //CEDULA
			IF lEntrada
				cFiltro += " AND A2_PFISICA >= '" + cNitCCDe + "' AND A2_PFISICA <= '" + cNitCCAte + "' "
			ELSE
				cFiltro += " AND A1_PFISICA >= '" + cNitCCDe + "' AND A1_PFISICA <= '" + cNitCCAte + "' "
			ENDIF
		ElseIf nNitCC == 3 //NIT Y CEDULA
			IF lEntrada
				cFiltro += " AND ((A2_CGC >= '" + cNitCCDe + "' AND A2_CGC <= '" + cNitCCAte + "')"
				cFiltro += " OR (A2_PFISICA >= '" + cNitCCDe + "' AND A2_PFISICA <= '" + cNitCCAte + "')) "
			ELSE
				cFiltro += " AND ((A1_CGC >= '" + cNitCCDe + "' AND A1_CGC <= '" + cNitCCAte + "') "
				cFiltro += " OR (A1_PFISICA >= '" + cNitCCDe + "' AND A1_PFISICA <= '" + cNitCCAte + "')) "
			ENDIF
		Endif
		cFiltro += "  AND SF3.F3_FILIAL = '"+ xfilial("SF3") +"' "
		IF lEntrada
			cFiltro += "  AND SA2.A2_FILIAL = '"+ xfilial("SA2") +"' "
			cFiltro += "  AND SF3.F3_CLIEFOR = SA2.A2_COD "
			cFiltro += "  AND SF3.F3_LOJA = SA2.A2_LOJA "
		ELSE
			cFiltro += "  AND SA1.A1_FILIAL = '"+ xfilial("SA1") +"' "
			cFiltro += "  AND SF3.F3_CLIEFOR = SA1.A1_COD "
			cFiltro += "  AND SF3.F3_LOJA = SA1.A1_LOJA "
		ENDIF
		cFiltro += "	AND F3_DTCANC = '' "
		If ( TcSrvType()=="AS/400" )
			cFiltro	+= "  AND SF3.@DELETED@ = ' ' " 
			IF lEntrada
				cFiltro	+= "  AND SA2.@DELETED@ = ' ' "  
			ELSE
				cFiltro	+= "  AND SA1.@DELETED@ = ' ' "
			ENDIF
		ELSE
			cFiltro	+= "  AND SF3.D_E_L_E_T_ = ' ' "
			IF lEntrada
				cFiltro	+= "  AND SA2.D_E_L_E_T_ = ' ' "
			ELSE
				cFiltro	+= "  AND SA1.D_E_L_E_T_ = ' ' "
			ENDIF
		ENDIF
		IF lSintetico
			cFiltro	+= "  GROUP BY "+ cGroupo + " %"
		ELSE
			cFiltro += " %"
		ENDIF
	RestArea(aArea)
return
