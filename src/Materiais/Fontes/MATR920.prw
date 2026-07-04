/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "matr920.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "Matr930Def.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR920  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Listagem das Entradas/Saidas para transcricao manual       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³ Vogas Junior ³30/05/18³DSERFIS2-3691 (MATR920) Criado pergunte para   ³±±
±±³              ³        ³    selecionar coluna para apresentar ICMS-ST. ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR920
Local 	lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)
Local cRelease as character

Local cEndWeb		:= "https://tdn.totvs.com/pages/viewpage.action?pageId=792425840"

cRelease 	:=  GetRPORelease()     

If !IsBlind() 
	If FindFunction("DlgRelVer")
		DlgRelVer("MATR920","Relatorio Lancamentos fiscais",cEndWeb )  
	EndIf 
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel:="MATR920"
Titulo:=STR0001 //"Listagem para escrituracao manual"
cDesc1:=STR0002 //"Emiss„o de listagem de movimenta‡oes de notas fiscais de entradas e"
cDesc2:=STR0003 //"sa¡das para transcricao em livros fiscais de escrituracao manual."
cDesc3:=STR0004 //"Ir  imprimir os lancamentos fiscais conforme os parƒmetros informados."
aReturn:= { STR0005, 1,STR0006, 2, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
nomeprog:="MATR920"
cPerg:= "MTR920"
cString:="SF3"
nPagina:=0
nLin:=80
nLargMax:=220
Tamanho:="G"
cArqTemp:=""
aSvArea:={Alias(),IndexOrd(),Recno()}
nPosObs:=0
lConsUF:=.F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas no cabecalho     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aMeses	:={STR0007,STR0008,STR0009,STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,STR0017,STR0018} //"JANEIRO"###"FEVEREIRO"###"MARCO"###"ABRIL"###"MAIO"###"JUNHO"###"JULHO"###"AGOSTO"###"SETEMBRO"###"OUTUBRO"###"NOVEMBRO"###"DEZEMBRO"
cNomEmp	:=Trim(SM0->M0_NOMECOM)
cNomFil :=Trim(SM0->M0_FILIAL)
If lVerpesssen
	AjustaSX1()
	Pergunte(cPerg,.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia controle para a funcao SETPRINT ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLastKey:=0
	wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,Tamanho,,.T.)
	If nLastKey==27
		dbClearFilter()
		Return
	Endif
	SetDefault(aReturn,cString)
	If nLastKey==27
		dbClearFilter()
		Return
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa relatorio                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RptStatus({|lEnd| R920Imp(@lEnd,wnRel,cString,Tamanho)},titulo)

	If aReturn[5]==1
		Set Printer To
		ourspool(wnrel)
	Endif
	MS_FLUSH()
EndIf 

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R920Imp  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Relatorio                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R920Imp(lEnd,wnRel,cString,Tamanho)
LOCAL 	lMatr921:=(existblock("MATR921"))
Local	cIndxSF3	:=""
Local	cChave		:=""
Local	aRegSF3     :={}  
Local 	nFilchave	:= FWSizeFilial() 
Local	cNew       	:=	"HMNew()"

PRIVATE aSX6		:= R930LoadX6()
PRIVATE aSX3		:= R930LoadX3()
PRIVATE aPict		:= R930Pict()
PRIVATE	lTop		:= TcSrvType() <> "AS/400"
PRIVATE lBuild   	:= GetBuild() >= "7.00.131227A"
PRIVATE lBuildjS 	:= GetBuild() >="7.00.170117A"

PRIVATE	oHashColF3	:= Nil
PRIVATE	oNotasjS	:= Nil
PRIVATE	oFiliais	:= Nil
PRIVATE	oHashPar	:= Nil

PRIVATE lF3MsFil	:= aSX3[FP_F3_MSFIL]
PRIVATE lF3Difal	:= aSX3[FP_F3_DIFAL]
PRIVATE lF3FCDifal 	:= aSX3[FP_F3_VFCPDIF]
PRIVATE lF3BASNDES 	:= aSX3[FP_F3_BASNDES]
PRIVATE lICMSNDES	:= aSX3[FP_F3_ICMNDES]
PRIVATE lF3_VL43080 := aSX3[FP_F3_VL43080]
PRIVATE lF3_VLINCMG := aSX3[FP_F3_VLINCMG]
PRIVATE lCredST		:= aSX3[FP_F3_CREDST]
PRIVATE lF3_NUMINI	:= aSX3[FP_F3_NUMINI]
PRIVATE lF3_NUMFIM	:= aSX3[FP_F3_NUMFIM]
PRIVATE lF3_VALANTI	:= aSX3[FP_F3_VALANTI]
PRIVATE lF3_CLIDVMC	:= aSX3[FP_F3_CLIDVMC]
PRIVATE lF3_DS43080	:= aSX3[FP_F3_DS43080]
PRIVATE lF3_SERSAT	:= aSX3[FP_F3_SERSAT]

If lBuild
	oHashColF3	:= &cNew	
	oHashFil	:= &cNew
	oHashPar	:= &cNew
	//conout(Alltrim(Str(ThreadID())) + " Inicio do processamento:  " + Time())
EndIf

Private cArqSF3		:=""
PRIVATE lAbortPrint:=.F.
PRIVATE cTitLivro:=NIL
PRIVATE nReg115	:= 0
PRIVATE nRegPerm:= 1000000
PRIVATE nVolume	:= 1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe valores dos Parametros ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE dDtIni	:=mv_par01,;
dDtFim		:= mv_par02,;
nTipoMov	:= mv_par03,;
lLacuna 	:= (mv_par04==1 .Or. mv_par04==3),;
nApurICM	:= mv_par05,;
nApurIPI	:= mv_par06,;
cNrLivro	:= mv_par07,;
lServico	:= (mv_par08==1),;
lDesconto	:= (mv_par09==1),;
lImpZer		:= (mv_par10==1),;
nCodigo		:= mv_par11,;
lListaNFO 	:= (mv_par12==1),;
nModelo 	:= Iif (mv_par03==1, 1, 3),;
lEntrada 	:= (mv_par15==1)   

PRIVATE	nPagina:=1,cFilterUser:=aReturn[7]
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cMV_ESTADO:=SuperGetMv("MV_ESTADO"),;
cContaContab:=NIL
mv_par27 :=2
If nTipoMov==1
	cContaContab:=Alltrim(SuperGetMV("MV_CTALFE"))	
	// Retira ref. ao Alias SF3 //
	cContaContab:=StrTran(cContaContab,"SF3->",)
Else
	cContaContab:=Alltrim(SuperGetMV("MV_CTALFS"))	
	// Retira ref. ao Alias SF3 //
	cContaContab:=StrTran(cContaContab,"SF3->",)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limite da pagina em linhas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nLimPag:=60,nLinNec:=0
PRIVATE lAglutina:=.F.
PRIVATE lNFInutil:= (mv_par17==1)
PRIVATE lEmiteCiap :=.T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena maior tamanho das notas (em linhas)³
//³ [1]=Maior Nota da Pagina                    ³
//³ [2]=Maior Totalizacao de Transporte         ³
//³ [3]=Maior Totalizacao do Dia                ³
//³ [4]=Maior Totalizacao de Periodo ICM        ³
//³ [5]=Maior Totalizacao de Periodo IPI        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTamNota	:=0,;
nTamTransp	:=0,;
nTamPerICM	:=0,;
nTamPerIPI	:=0,;
aTamNotas	:={0,0,0,0,0}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Totalizadores ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE	aTotDia:=NIL,;		// Totalizador diario
aTotPerICM:=NIL,;	// Totalizador de periodos de apuracao de ICMS
aTotPerIPI:=NIL,;	// Totalizador de periodos de apuracao de IPI
aTransp:=NIL,;		// Totalizador de transporte de pagina
aTotMes:=NIL,;		// Totalizador Mensal
aTotObs:=NIL,;	// Totalizador Observação
aResumo:=NIL,;		// Totalizador para resumo final
aResCFO:=NIL		// Totalizador para resumo por CFO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo Temporario para Controle de Contribuintes e Nao Contribuintes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE oArqSF3
PRIVATE coArqSF3Na	:= "" //Nome fisico da tabela

AADD(aRegSF3,{"CHAVE"	,"C",100,0})
AADD(aRegSF3,{"CONTR"	,"C",01,0})
AADD(aRegSF3,{"FILIAL"	,"C",nFilchave,0})
AADD(aRegSF3,{"MES"		,"C",02,0})
AADD(aRegSF3,{"ANO"		,"C",04,0})
AADD(aRegSF3,{"RECNOF3"	,"N",10,0})

cArqSF3     := GetNextAlias()
oArqSF3 	:= FwTemporaryTable():New(cArqSF3)

oArqSF3:SetFields(aRegSF3)
oArqSF3:AddIndex("01", {"CONTR", "CHAVE"} )
oArqSF3:AddIndex("02", {"CONTR", "MES", "ANO"} )

oArqSF3:Create()

coArqSF3Na := oArqSF3:GetRealName() //Nome fisico da tabela

If lMatr921
	ExecBlock("MATR921",.F.,.F.)
Else
	Matr921()
Endif

oArqSF3:Delete()
oArqSF3 := Nil

If lBuild
	FreeObj(oHashColF3)
	oHashColF3 := NIL

	FreeObj(oHashFil)

	FreeObj(oHashPar)
Endif

If lBuildjS
	FreeObj(oNotasjS)
Endif

Return
/*/{Protheus.doc} AjustaSX1
	(Cria grupo de perguntas)

	@type Static Function
	@author Vogas Júnior
	@since 25/05/2018

	@Return Nil, nulo, não tem retorno.
	/*/
Static Function AjustaSX1()

	Local aPergunte := {}

	/*
		|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
		|   		cGrupo		, cOrdem, cPergunt							, cPerSpa							, cPerEng							, cVar		, cTipo	, nTamanho	, nDecimal	, nPresel	, cGSC	, cValid						, cF3	, cGrpSxg	, cPyme	, cVar01		, cDef01		, cDefSpa1			, cDefEng1	, cCnt01	, cDef02		, cDefSpa2	, cDefEng2	, cDef03	, cDefSpa3	, cDefEng3	, cDef04			, cDefSpa4			, cDefEng4			, cDef05			, cDefSpa5			, cDefEng5			, aHelpPor	, aHelpEng	, aHelpSpa	, cHelp              |
		|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	*/
	Aadd(aPergunte,{'MTR920'	, '01'	, 'A partir da Data ?            '	, '¿A  partir de fecha ?         '	, 'From Date ?                   '	, 'MV_CH1'	, 'D'	, 08		, 0			, 0			, 'G'	, ''							, ''	, ''		, ''	, 'MV_PAR01'	, ''			, ''				, ''		, ''		, ''			, ''		, ''		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92001.'})
	Aadd(aPergunte,{'MTR920'	, '02'	, 'Até a Data ?                  '	, '¿A  fecha ?                   '	, 'To Date ?                     '	, 'MV_CH2'	, 'D'	, 08		, 0			, 0			, 'G'	, ''							, ''	, ''		, ''	, 'MV_PAR02'	, ''			, ''				, ''		, ''		, ''			, ''		, ''		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92002.'})
	Aadd(aPergunte,{'MTR920'	, '03'	, 'Imprime Modelo ?              '	, '¿Imprime Modelo ?             '	, 'Print Model ?                 '	, 'MV_CH3'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR03'	, 'Entradas'	, 'Entradas'		, 'inflows'	, ''		, 'Saídas'		, 'Salidas'	, 'Outflows', ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92003.'})
	Aadd(aPergunte,{'MTR920'	, '04'	, 'Considera Lacuna ?            '	, '¿Considera vacío ?            '	, 'Consider Gap ?                '	, 'MV_CH4'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR04'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92004.'})
	Aadd(aPergunte,{'MTR920'	, '05'	, 'Apuração de ICMS ?            '	, '¿Cálculo de ICMS ?            '	, 'ICMS Calculation ?            '	, 'MV_CH5'	, 'N'	, 01		, 0			, 3			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR05'	, 'Decendial'	, '10 días'			, 'ten Day period', ''	, ''			, ''		, ''		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92005.'})
	Aadd(aPergunte,{'MTR920'	, '06'	, 'Apuração de IPI ?             '	, '¿Cálculo de IPI ?             '	, 'IPI Calculation ?             '	, 'MV_CH6'	, 'N'	, 01		, 0			, 3			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR06'	, 'Decendial'	, '10 días'			, 'ten Day period', ''	, ''			, ''		, ''		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92006.'})
	Aadd(aPergunte,{'MTR920'	, '07'	, 'Livro Selecionado ?           '	, '¿Libro Seleccionado ?         '	, 'Book Selected ?               '	, 'MV_CH7'	, 'C'	, 01		, 0			, 0			, 'G'	, ''							, ''	, ''		, ''	, 'MV_PAR07'	, ''			, ''				, ''		, ''		, ''			, ''		, ''		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92007.'})
	Aadd(aPergunte,{'MTR920'	, '08'	, 'Destaca Nts.Serviço ?         '	, '¿Destaca Fact.Servicio ?      '	, 'Highlight Service Invcs. ?    '	, 'MV_CH8'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR08'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92008.'})
	Aadd(aPergunte,{'MTR920'	, '09'	, 'Destaca Descontos ?           '	, '¿Destaca descuentos ?         '	, 'Highlight Deductions ?        '	, 'MV_CH9'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR09'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92009.'})
	Aadd(aPergunte,{'MTR920'	, '10'	, 'Impr.Linhas s/Valor ?         '	, '¿Impr.Línas s/Valor ?         '	, 'Print Rows w/out Value ?      '	, 'MV_CHA'	, 'N'	, 01		, 0			, 2			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR10'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92010.'})
	Aadd(aPergunte,{'MTR920'	, '11'	, 'Cód.Cliente/Fornec. ?         '	, '¿Cód.Cliente/Proveed. ?       '	, 'Customer/Supplier Code ?      '	, 'MV_CHB'	, 'N'	, 01		, 0			, 2			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR11'	, 'Codigo'		, 'Código'			, 'Code'	, ''		, 'CNPJ'		, 'RCPJ'	, 'CNPJ'	, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92011.'})
	Aadd(aPergunte,{'MTR920'	, '12'	, 'Lista NF Origem ?             '	, '¿Lista Fact Origen ?          '	, 'List Source Invoice ?         '	, 'MV_CHC'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR12'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92012.'})
	Aadd(aPergunte,{'MTR920'	, '13'	, 'Seleciona Filial ?            '	, '¿Selecciona Sucursal ?        '	, 'Select Branch ?               '	, 'MV_CHD'	, 'N'	, 01		, 0			, 2			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR13'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92013.'})
	Aadd(aPergunte,{'MTR920'	, '14'	, 'Imprime Mapa Resumo ?         '	, '¿Imprime mapa resumen ?       '	, 'Print Summary Map ?           '	, 'MV_CHE'	, 'N'	, 01		, 0			, 1			, 'C'	, 'MatxRValPer(mv_par14)  '		, ''	, ''		, ''	, 'MV_PAR14'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92014.'})
	Aadd(aPergunte,{'MTR920'	, '15'	, 'Impr. NF de Entrada ?         '	, '¿Impr. Fact de Entrada ?      '	, 'Print Inbound Invoice ?       '	, 'MV_CHF'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR15'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92015.'})
	Aadd(aPergunte,{'MTR920'	, '16'	, 'Impr. Operações Isentas ?     '	, '¿Impr. Operac. Exentas ?      '	, 'Print Exempt Operations ?     '	, 'MV_CHG'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR16'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92016.'})
	Aadd(aPergunte,{'MTR920'	, '17'	, 'Impr. NF Inutil. ?            '	, '¿Impr. Fact. Inutil. ?        '	, 'Print Voided Invoice ?        '	, 'MV_CHH'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR17'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92017.'})
	Aadd(aPergunte,{'MTR920'	, '18'	, 'Aglutina Por Cnpj + IE ?      '	, '¿Agrupa por RCPJ + IE ?       '	, 'Group by CNPJ+IE ?            '	, 'MV_CHI'	, 'N'	, 01		, 0			, 1			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR18'	, 'Sim'			, 'Sí'				, 'Yes'		, ''		, 'Nao'			, 'No'		, 'No'		, ''		, ''		, ''		, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92018.'})
	Aadd(aPergunte,{'MTR920'	, '19'	, 'Imp. Retido Coluna: ?         '	, '¿Imp. Reteniido Columna ?     '	, 'Withheld Tax Column ?         '	, 'MV_CHJ'	, 'N'	, 01		, 0			, 2			, 'C'	, ''							, ''	, ''		, ''	, 'MV_PAR19'	, 'Observacoes'	, 'Observaciones'	, 'Notes'	, ''		, 'Tributado'	,'Tributado', 'Taxed '	, 'Ambos'	, 'Ambos'	, 'Both'	, ''				, ''				, ''				, ''				, ''				, ''				, 			, 			, 			,'.MTR92019.'})	

Return
