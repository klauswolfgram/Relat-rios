/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "MATRCH2.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณMATRCH2   ณ Autor ณSergio S. Fuzinaka     ณ Data ณ 17.05.06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณLivros Fiscais - Vendas                                     ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณNenhum                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณNenhum                                                      ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณCHILE                                                       ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao Efetuada                         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MATRCH2()

Local nQ
Local cPerg       	:= "MTRCH2"
Local cString     	:= "SF3"

Private CbTxt		:=""
Private CbCont		:=""
Private aTipos   	:= {}
Private lTipos      := SX5->(DBSEEK(xFilial("SX5")+"SF"))
Private aTotCFis    := {}
Private aProvincia  := {}
Private lProvincia  := SX5->(DBSEEK(xFilial("SX5")+"12"))
Private aTotProv  	:= {}
Private aProduto    := {}
Private lProduto    := SX5->(DBSEEK(xFilial("SX5")+"02"))
Private aTotTpProd	:= {}
Private tamanho   	:= "G"
Private limite    	:= 220
Private titulo    	:= PADC(OemToAnsi(STR0001),74) //"Emisi๓n del Subdiario de IVA"
Private cDesc1    	:= PADC(OemToAnsi(STR0002),74) //"Se solicitaran la fecha inicial y la fecha final para la emisi๓n"
Private cDesc2    	:= PADC(OemToAnsi(STR0003),74) //"de los libros de IVA Vendas"
Private cDesc3    	:= ""
Private aReturn   	:= { OemToAnsi(STR0004), 1,OemToAnsi(STR0005), 1, 2, 1,"",1 } //"Especial"###"Administracion"
Private lContinua 	:= .T.
Private wnrel     	:= "MATRCH2"
Private cPictVals 	:= "@E 999,999,999,999,999.99"
Private cPictImp  	:= "@E 999,999,999,999,999.99"
Private nLastKey	:=	0
Private dDtIni, dDtFim
Private nImpGravados,nNoGravados,nIvaNoInscri
Private nPagina,cRazaoSoc,cCGC,nLin
Private nSigno,nTipo,aMeses
PRIVATE cEmpresa,cInscr,cCuit,cTitulo,_nMes,nCnt1
PRIVATE nd,nLinRoda1,nLinRoda2,nLinRoda3,nLinRoda4,nLinRoda5
PRIVATE nLinRoda1b,nLinRoda2b,nLinRoda3b,nLinIni,aDriver,nOpc, CFILTERUSER
Private cIndexSf3 , dDataEnt

If lTipos // Verifica se existe a Tabela SF(Tabela de Agentes Fiscais) no SX5 e monta o array com todas as chaves desse grupo.
	SX5->(DBSEEK(xFilial("SX5")+"SF"))
	While !SX5->(EOF()).And.SX5->X5_TABELA=="SF"
		Aadd(aTipos,{SX5->X5_CHAVE,Alltrim(x5DESCri())})
		SX5->(DbSkip())
	Enddo
	Aadd(aTipos,{"  ",OemToAnsi(STR0006)}) //"Tipo no Reg."
	For nQ	:=	1 To len(aTipos)
		Aadd(aTotCFis,{0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00})
	Next
Endif

If lProvincia  // Verifica se existe a Tabela 12(Tabela de Zonas Fiscais) no SX5 e monta o array com todas as chaves desse grupo.
	SX5->(DBSEEK(xFilial("SX5")+"12"))
	While !SX5->(EOF()).And.SX5->X5_TABELA=="12"
		Aadd(aProvincia,{SX5->X5_CHAVE,Alltrim(x5DESCri())})
		SX5->(DbSkip())
	Enddo
	For nQ	:=	1 To Len(aProvincia)
		Aadd(aTotProv,{0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00})
	Next
Endif

If lProduto // Verifica se existe a Tabela 02(Tabela de Tipos de Materiais) no SX5 e monta o array com todas as chaves desse grupo.
	SX5->(DBSEEK(xFilial("SX5")+"02"))
	While !SX5->(EOF()).And.SX5->X5_TABELA=="02"
		Aadd(aProduto,{SX5->X5_CHAVE,Alltrim(x5DESCri())})
		SX5->(DbSkip())
	Enddo
	For nQ	:=	1 To len(aProduto)
		Aadd(aTotTPProd,{0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00})
	Next
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica as perguntas selecionadas   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariaveis utilizadas para parametros    ณ
//ณmv_par01             // Fecha desde     ณ
//ณmv_par02             // Fecha hasta     ณ
//ณmv_par03             // Incluir         ณ
//ณmv_par04             // Estilo          ณ
//ณmv_par05             // Sucursales      ณ
//ณmv_par06             // Resumen         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู       
Pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Envia controle para a funcao SETPRINTณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,Tamanho)

dDtIni := Dtos(mv_par01)
dDtFim := Dtos(mv_par02)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

cFilterUser:=aReturn[7]

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica Posicao do Formulario na Impressoraณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//VerImp()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicio do Processamento do Relatorio. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
#IFDEF WINDOWS
	RptStatus({|| RptDetail()})
#ENDIF

dbSelectArea("SF3")
dbClearFil()
RetIndex( "SF3" )
#IFNDEF TOP
	FErase(cIndexSf3+OrdBagExt())
#ENDIF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRptDetail บAutor  ณGilson da Silva     บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao da linha detalhe do relatorio			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RptDetail()

Local nIndex
Local nQ
Local cNotaAnt  := ""
Local cChave
Local cFiltro
Local cTipoCli := ""
Local cCliePad := AllTrim(GetMV("MV_CLIPAD")+GetMV("MV_LOJAPAD"))
Local nValImp  := 0
Local nValMerc := 0
Local nValBrut := 0
Local nQtLinCab:= 0
Local nQtLinRes:= 0
Local nRetIVA  := 0
Local nRetSUS  := 0
Local nRetSLI  := 0
Local nCont    := 1  
Local nLimCFis := GetMV("MV_LIMCFIS",,1000)       
Local lCliPad  := .F.
Local lPrcDec   := SuperGetMV("MV_PRCDEC",,.F.)

// VARIAVEIS COM OS SUB TOTAIS DOS CAMPOS DE IMPOSTOS, SEPARADOS POR TIPO DE DOCUMENTO
// NF=FATURA  ND=NOTA DE DEBITO   NC=NOTA DE CREDITO
Private nFVALMERC :=0, nDVALMERC :=0, nCVALMERC:=0
Private nFValImp1 :=0, nDValImp1 :=0, nCValImp1:=0
Private nFValImp2 :=0, nDValImp2 :=0, nCValImp2:=0
Private nFValImp3 :=0, nDValImp3 :=0, nCValImp3:=0
Private nFValImp4 :=0, nDValImp4 :=0, nCValImp4:=0
Private nFValImp5 :=0, nDValImp5 :=0, nCValImp5:=0
Private nFRetIVA  :=0,  nDRetIVA :=0,  nCRetIVA:=0
Private nFRetIBB  :=0,  nDRetIBB :=0,  nCRetIBB:=0
Private nFRetSUS  :=0,  nDRetSUS :=0,  nCRetSUS:=0
Private nFRetSLI  :=0,  nDRetSLI :=0,  nCRetSLI:=0
Private nFExento  :=0,  nDExento :=0,  nCExento:=0
Private nFImpTotal:=0, nDImpTotal:=0, nCImpTotal:=0

// VARIAVEIS COM OS TOTAIS DOS CAMPOS DE IMPOSTOS, SEPARADOS POR TIPO DE DOCUMENTO
// NTF=FATURA  NTD=NOTA DE DEBITO   NTC=NOTA DE CREDITO
Private nTFVALMERC :=0, nTDVALMERC :=0, nTCVALMERC:=0
Private nTFValImp1 :=0, nTDValImp1 :=0, nTCValImp1:=0
Private nTFValImp2 :=0, nTDValImp2 :=0, nTCValImp2:=0
Private nTFValImp3 :=0, nTDValImp3 :=0, nTCValImp3:=0
Private nTFValImp4 :=0, nTDValImp4 :=0, nTCValImp4:=0
Private nTFValImp5 :=0, nTDValImp5 :=0, nTCValImp5:=0
Private nTFRetIVA  :=0, nTDRetIVA  :=0, nTCRetIVA:=0
Private nTFRetIBB  :=0, nTDRetIBB  :=0, nTCRetIBB:=0
Private nTFRetSUS  :=0, nTDRetSUS  :=0, nTCRetSUS:=0
Private nTFRetSLI  :=0, nTDRetSLI  :=0, nTCRetSLI:=0
Private nTFExento  :=0, nTDExento  :=0, nTCExento:=0
Private nTFImpTotal:=0, nTDImpTotal:=0, nTCImpTotal:=0
Private dEntAnt       , cAliasSF3     , lImpTDia := .F.       
Private cDocIni:= " " , cDocFim  :=" ", cSerAnt  := " ", cEspAnt := " "

//Variaveis que acumularam os valores dos titulos serie B(Consumidores Finais) com vlr menor que MV_LIMCFIS
Private nRetIBB := 0  , nVlMercB := 0 , nVlImp1B := 0
Private nVlImp2B:= 0  , nVlImp3B := 0 
Private nVlImp4B:= 0 , nVlImp5B := 0
Private nExentoB := 0 , nImpTotB := 0
Private nRetIVAB := 0 , nRetIBBB := 0 , nRetSUSB := 0  , nRetSLIB := 0
Private lImpB    := .F.

Private nMoeda := 0, nTaxa := 0, nDecs := 0, dDigita := Ctod("//")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPrepara o SF3 para extracao dos dados  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF3")
#IFNDEF TOP
	cAliasSF3:="SF3"
	cFiltro:="F3_FILIAL=='"+mv_par05+"'.AND.DTOS(F3_ENTRADA)>='"+dDtIni+"'.AND.DTOS(F3_ENTRADA)<='"+dDtFim+"'"
	If mv_par03 == 1
		cFiltro :=cFiltro + ".AND. EMPTY(F3_DTCANC)"
	ElseIf mv_par03 == 2
		cFiltro := cFiltro+ ".AND. !EMPTY(F3_DTCANC)"
	EndIf
	cFiltro := cFiltro + ".And. F3_TIPOMOV == 'V' .And. Alltrim(F3_ESPECIE) $ 'NF|NDC|NCC'" //Movimenta็๖es de Vendas
	cChave:="F3_FILIAL+DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO"
	cIndexSf3 := CriaTrab(NIL,.F.)
	IndRegua("SF3",cIndexSf3,cChave,,cFiltro,OemToAnsi(STR0007)) //"Filtrando registros..."
	nIndex	:=	Retindex("SF3")
	dbSelectArea("SF3")
	dbSetIndex(cIndexSf3+OrdBagExt())
	DbSetOrder(nIndex+1)
#ELSE
	cAliasSF3:="SF3TMP"
	If Select((cAliasSF3))<>0
		DbSelectArea((cAliasSF3))
		DbCloseArea()
	Endif
	cQuery:="SELECT * FROM "+RetSqlName("SF3")+" "+(cAliasSF3)+" "
	cQuery+="WHERE F3_FILIAL='"+mv_par05+"'  AND D_E_L_E_T_<>'*'"
	cQuery+= " AND F3_ENTRADA >='"+dDtIni+"'"
	cQuery+= " AND F3_ENTRADA<='"+dDtFim+"'"
	If mv_par03 == 1
		cQuery+= "AND F3_DTCANC = ' '"
	ElseIf mv_par03 == 2
		cQuery+= "AND F3_DTCANC <> ' '"
	EndIf
	cQuery += "AND F3_TIPOMOV='V' AND F3_ESPECIE IN('NF','NDC','NCC')" //Movimenta็๖es de Vendas
	cQuery += " ORDER BY F3_ENTRADA,F3_SERIE,F3_NFISCAL,F3_CFO"
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),(cAliasSF3),.F.,.T.)
#ENDIF

DbSelectArea(cAliasSF3)
DbGoTop()
nLin    := 60
nPagina := 0

If mv_par06 == 1  
	nQtLinRes := 9 // Qtde Linhas usadas qdo Imprime o resumo. 
EndIf

SetRegua(LastRec())
#IFNDEF TOP
	dEntAnt:= CTOD("")
#ELSE
	dEntAnt:= ""
#ENDIF
While !Eof()
	IncRegua()
	IF lAbortPrint
		@ 00,01 PSAY OemToAnsi(STR0008) //"** CANCELADO PELO OPERADOR **"
		lContinua := .F.
		Exit
	Endif
	   
	If (cAliasSF3)->F3_ENTRADA<>dEntAnt
		nQtLinCab := nQtLinRes + 4   // Qtde Linhas usadas qdo Imprimir o cabe็alho. 
	EndIf
	
	If nLin + nQtLinCab > 55
		If nPagina >= 1        
			If (cAliasSF3)->F3_ENTRADA<>dEntAnt
				RaR2TotDia()   // Imprime o sub total por dia
			EndIf
			RaR2TotPg()  // Imprime o Sub total Impresso
			RAR2Cab()   //Imprime o Cabecalho do relatorio
			RaR2TotPg()  // Imprime o Sub Total Impresso
			#IFNDEF TOP
				@ nLin, 001 PSAY (cAliasSF3)->F3_ENTRADA
			#ELSE
				@ nLin, 001 PSAY CTOD((cAliasSF3)->(SUBSTR(F3_ENTRADA,7,2)+"/"+SUBSTR(F3_ENTRADA,5,2)+"/"+SUBSTR(F3_ENTRADA,3,2)))
			#ENDIF
			nLin	:= nLin+1
		Else
			RAR2Cab()   //Imprime o Cabecalho do relatorio
			#IFNDEF TOP
				@ nLin, 001 PSAY (cAliasSF3)->F3_ENTRADA
			#ELSE
				@ nLin, 001 PSAY CTOD((cAliasSF3)->(SUBSTR(F3_ENTRADA,7,2)+"/"+SUBSTR(F3_ENTRADA,5,2)+"/"+SUBSTR(F3_ENTRADA,3,2)))
			#ENDIF 
			dEntAnt	:= (cAliasSF3)->F3_ENTRADA
			nLin	:= nLin+1
		EndIf
	EndIf
	
	//+--------------------------------------------------------------+
	//ฆ Considera filtro do usuario                                  ฆ
	//+--------------------------------------------------------------+
	If !Empty(cFilterUser).and.!(&cFilterUser)
		(cAliasSF3)->(dbSkip())
		Loop
	Endif
	
	SA1->( dbSetOrder(1) )
	SA1->( dbSeek( xFilial("SA1")+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA ) )
	cRazaoSoc := SA1->A1_NOME
	cCgc	  := SA1->A1_CGC
	cTipoCli  := SA1->A1_TIPO
	lCliPad   := cCliePad == SA1->A1_COD+SA1->A1_LOJA
	// Verifica IVA e IIBB
	
	nRetIVA := 0
	nRetIBB	:= 0
	nRetSUS := 0
	nRetSLI	:= 0
	SFE->( DbSetOrder(8) )
	SFE->( DbSeek(xFilial('SFE')+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE))
	While SFE->(!Eof()) .And. SFE->(FE_FILIAL+FE_CLIENTE+FE_LOJCLI+FE_NFISCAL+FE_SERIE) = xFilial('SFE')+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE
		If ( SFE->FE_TIPO == 'I' )
			nRetIVA += SFE->FE_RETENC	// acumula valores das retencoes tipo IVA
		Elseif ( SFE->FE_TIPO == 'B' )
			nRetIBB += SFE->FE_RETENC  // acumula valores das retencoes tipo IIBB
		Elseif ( SFE->FE_TIPO == 'S' )
			nRetSUS += SFE->FE_RETENC  // acumula valores das retencoes tipo SUS
		Elseif ( SFE->FE_TIPO == 'L' )
			nRetSLI += SFE->FE_RETENC  // acumula valores das retencoes tipo SLI
		EndIf
		SFE->(DbSkip())
	Enddo
	
	If Alltrim((cAliasSF3)->F3_ESPECIE)=="NCC"
		nSigno	:=-1
	Else
		nSigno	:= 1
	Endif

	If nCont > 1  //Verifica  se nao eh o primeiro registro que esta sendo processado
		If  ( (cAliasSF3)->F3_ENTRADA<>dEntAnt )
			If mv_par04 == 1         // Analitico
				If cSerAnt == "B"
					Rar2ImpB()       // Imprime os valores dos documentos serie B(Consumidores finais)
				EndIf	
				RaR2TotDia()  //Imprime o sub total do dia
	  			#IFNDEF TOP
					@ nLin, 001 PSAY (cAliasSF3)->F3_ENTRADA
				#ELSE
					@ nLin, 001 PSAY CTOD((cAliasSF3)->(SUBSTR(F3_ENTRADA,7,2)+"/"+SUBSTR(F3_ENTRADA,5,2)+"/"+SUBSTR(F3_ENTRADA,3,2)))
				#ENDIF     
				nLin	:= nLin+1
			ElseIf Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))) != "B" .Or. (cAliasSF3)->F3_VALMERC >= nLimCFis // Resumido
				If cSerAnt == "B"
					Rar2ImpB()       // Imprime os valores dos documentos serie B(Consumidores finais)
				EndIf	  
				nLin	:= nLin+1
				#IFNDEF TOP
					@ nLin, 001 PSAY (cAliasSF3)->F3_ENTRADA
				#ELSE
					@ nLin, 001 PSAY CTOD((cAliasSF3)->(SUBSTR(F3_ENTRADA,7,2)+"/"+SUBSTR(F3_ENTRADA,5,2)+"/"+SUBSTR(F3_ENTRADA,3,2)))
				#ENDIF     
				dEntAnt	:= (cAliasSF3)->F3_ENTRADA
				nLin	:= nLin+1
			EndIf
		EndIf
	EndIf
	nCont++
	
	If cSerAnt == "B" .And. Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))) <> "B" .And. lImpB // Vai Imprimir os Documentos S้rie B(Consumidores finais) com valor menor que MV_LIMCFIS
		Rar2ImpB()       // Imprime os valores dos documentos serie B(Consumidores finais)
	EndIf
	
	
	If Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))) <> "B"  .Or. (cAliasSF3)->F3_VALMERC >= nLimCFis
		If (cAliasSF3)->F3_TIPO+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA # cNotaAnt
			@ nLin,000 PSAY (cAliasSF3)->F3_ESPECIE
			@ nLin,006 PSAY (cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))
			@ nLin,012 PSAY (cAliasSF3)->F3_NFISCAL	 Picture PesqPict("SF3","F3_NFISCAL")
		EndIf
	EndIf
	
	//Verifica se a NF foi Anulada/Cancelada
	If !Empty((cAliasSF3)->F3_DTCANC)
		@ nLin,023 PSAY OemToAnsi(STR0032)   //"A N U L A D A"
		nLin := nLin + 1
	Else
		If Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))) == "B" .And. (cAliasSF3)->F3_VALMERC < nLimCFis  //Se Serie B(Consumidor Final) e Vlr menor que MV_LIMCFIS acumula e imprime depois
			If !lImpB
				cDocIni := (cAliasSF3)->F3_NFISCAL
				cEspAnt := (cAliasSF3)->F3_ESPECIE
				lImpB   := .T.
			EndIf	  
			cDocFim  := (cAliasSF3)->F3_NFISCAL
			nValmerc := (cAliasSF3)->F3_VALMERC - (cAliasSF3)->F3_EXENTAS
			nValBrut := (cAliasSF3)->F3_VALCONT
			SF2->( dbSetOrder(1) )
			SF2->( dbSeek( xFilial("SF2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA ) )
			nMoeda:= SF2->F2_MOEDA
			nTaxa := SF2->F2_TXMOEDA
			If cPaisLoc == "CHI" .And. lPrcDec
				nDecs := MsDecimais(nMoeda) - 1
			Else
				nDecs := MsDecimais(nMoeda) + 1
			EndIf
			dDigita := SF2->F2_EMISSAO
			
			nVlMercB += (nValMerc    * nSigno)
			nVlImp1B += ((cAliasSF3)->F3_VALImp1    * nSigno)
			nVlImp2B += ((cAliasSF3)->F3_VALImp2    * nSigno)
			nVlImp3B += ((cAliasSF3)->F3_VALImp3    * nSigno)
			nVlImp4B += ((cAliasSF3)->F3_VALImp4    * nSigno)
			nVlImp5B += (((cAliasSF3)->F3_VALImp5+(cAliasSF3)->F3_VALImp6)    * nSigno)
			nExentoB += ((cAliasSF3)->F3_EXENTAS	* nSigno)
			nImpTotB += (nValBrut    * nSigno)
		Else
			If Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE"))) == "B"
				cSerAnt := Alltrim((cAliasSF3)->&(SerieNfId("SF3",3,"F3_SERIE")))				
			EndIf				
            //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ                                                                                                                                ++
            //ณMostrar o nome, tipo e numero do documento  ณ
            //ณpara CF quando a venda for superior ao valorณ
            //ณem MV_LIMCFIS                               ณ            
            //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู			
			If cTipoCli == "F" .And. (cAliasSF3)->F3_VALMERC > nLimCFis .And. lCliPad
			   SLS->(DbSetOrder(1))
			   If SLS->(DbSeek(xFilial("SLS")+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_NFISCAL+"N"))
				@ nLin,023 PSAY Subs(SLS->LS_CLIECF,1,12)  Picture "@!"
				@ nLin,036 PSAY SLS->LS_DOCCF
			   EndIf
			Else 
			   @ nLin,026 PSAY Subs(cRazaoSoc,1,20)        	Picture "@!"
			   @ nLin,047 PSAY cCgc					    	Picture PesqPict("SA1","A1_CGC")
			EndIf

			If ( Alltrim((cAliasSF3)->F3_ESPECIE)=="NCC" )
				SF1->( dbSetOrder(1) )
				SF1->( dbSeek( xFilial("SF1")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA ) )
				nMoeda:= SF1->F1_MOEDA
				nTaxa := SF1->F1_TXMOEDA
				If cPaisLoc == "CHI" .And. lPrcDec
					nDecs := MsDecimais(nMoeda) - 1
				Else
					nDecs := MsDecimais(nMoeda) + 1
				EndIf
				dDigita := SF1->F1_DTDIGIT
			Else
				SF2->( dbSetOrder(1) )
				SF2->( dbSeek( xFilial("SF2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA ) )
				nMoeda:= SF2->F2_MOEDA
				nTaxa := SF2->F2_TXMOEDA
				If cPaisLoc == "CHI" .And. lPrcDec
					nDecs := MsDecimais(nMoeda) - 1
				Else
					nDecs := MsDecimais(nMoeda) + 1
				EndIf
				dDigita := SF2->F2_EMISSAO
			EndIf

			nValMerc := (cAliasSF3)->F3_VALMERC - (cAliasSF3)->F3_EXENTAS
			nValBrut := (cAliasSF3)->F3_VALCONT
			
/*
Tipo  Serie Comprobante   Razon Social         R.U.T.                   Neto Gravado                IVA R.G.               IVA INCL.              IVA C/RET.                  EXENTO                   TOTAL
                                                             999,999,999,999,999.99  999,999,999,999,999.99  999,999,999,999,999.99  999,999,999,999,999.99  999,999,999,999,999.99  999,999,999,999,999.99
*/	                                                                                
			
			@ nLin,062 PSAY (nValMerc  * nSigno)  				         	Picture cPictVals
			@ nLin,086 PSAY ((cAliasSF3)->F3_VALIMP1  * nSigno)			Picture cPictImp
			@ nLin,110 PSAY ((cAliasSF3)->F3_VALIMP2  * nSigno)			Picture cPictImp
			@ nLin,134 PSAY ((cAliasSF3)->F3_VALIMP3  * nSigno)			Picture cPictImp
			@ nLin,158 PSAY ((cAliasSF3)->F3_EXENTAS  * nSigno)      	    Picture cPictImp
			@ nLin,182 PSAY (nValBrut  * nSigno)					  		Picture cPictVals
			
			nLin := nLin + 1
			
			If ( Alltrim((cAliasSF3)->F3_ESPECIE)=="NCC" ) //Acumula valores referente a Notas de Credito
				nCValMerc		+= (nValMerc				 * nSigno)
				nTCVALMERC      += (nValMerc				 * nSigno)
				nCValImp1       += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nTCValImp1      += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nCValImp2       += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nTCValImp2      += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nCValImp3       += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nTCValImp3      += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nCValImp4       += ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nTCValImp4    	+= ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nCValImp5       += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nTCValImp5      += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nCRetIva        += nRetIVA
				nTCRetIVA	    += nRetIVA
				nCRetIBB        += nRetIBB
				nTCRetIBB       += nRetIBB
				nCRetSUS        += nRetSUS
				nTCRetSUS	    += nRetSUS
				nCRetSLI        += nRetSLI
				nTCRetSLI       += nRetSLI
				nCExento  		+= ((cAliasSF3)->F3_EXENTAS  * nSigno)
				nTCExento  		+= ((cAliasSF3)->F3_EXENTAS  * nSigno)
				nCImpTotal      += (nValBrut                 * nSigno)
				nTCImpTotal     += (nValBrut				 * nSigno)
			ElseIf ( Alltrim((cAliasSF3)->F3_ESPECIE) == "NDC" ) //Acumula  valores referente a Notas de Debito
				nDValMerc		+= (nValMerc				 * nSigno)
				nTDVALMERC      += (nValMerc				 * nSigno)
				nDValImp1       += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nTDValImp1      += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nDValImp2       += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nTDValImp2      += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nDValImp3       += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nTDValImp3      += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nDValImp4       += ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nTDValImp4    	+= ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nDValImp5       += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nTDValImp5      += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nDRetIVA        += nRetIVA
				nTDRetIVA	    += nRetIVA
				nDRetIBB        += nRetIBB
				nTDRetIBB       += nRetIBB
				nDRetSUS        += nRetSUS
				nTDRetSUS       += nRetSUS
				nDRetSLI        += nRetSLI
				nTDRetSLI       += nRetSLI
				nDExento        += ((cAliasSF3)->F3_EXENTAS  * nSigno)
				nTDExento       += ((cAliasSF3)->F3_EXENTAS  * nSigno)
				nDImpTotal      += (nValBrut				 * nSigno)
				nTDImpTotal     += (nValBrut				 * nSigno)
			Else //Acumula valores referente a Notas Fiscais/Fatura
				nFValMerc    	+= (nValMerc				 * nSigno)
				nTFVALMERC 		+= (nValMerc				 * nSigno)
				nFValImp1       += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nTFValImp1      += ((cAliasSF3)->F3_VALIMP1  * nSigno)
				nFValImp2       += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nTFValImp2      += ((cAliasSF3)->F3_VALIMP2  * nSigno)
				nFValImp3       += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nTFValImp3      += ((cAliasSF3)->F3_VALIMP3  * nSigno)
				nFValImp4       += ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nTFValImp4    	+= ((cAliasSF3)->F3_VALIMP4  * nSigno)
				nFValImp5       += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nTFValImp5      += (((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6)*nSigno)
				nFRetIVA        += nRetIVA
				nTFRetIVA	    += nRetIVA
				nFRetIBB        += nRetIBB
				nTFRetIBB       += nRetIBB
				nFRetSUS        += nRetSUS
				nTFRetSUS	    += nRetSUS
				nFRetSLI        += nRetSLI
				nTFRetSLI       += nRetSLI
				nFExento  		+= ((cAliasSF3)->F3_EXENTAS	* nSigno)
				nTFExento  		+= ((cAliasSF3)->F3_EXENTAS	* nSigno)
				nFImpTotal      += (nValBrut			    * nSigno)
				nTFImpTotal     += (nValBrut			    * nSigno)
			EndIf
		EndIf
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		//ณBusca y discrimina por tipo de cliente (Si esta cargada la tabla de tipos en el SX5).ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		If lTipos       // Monta o resumo por Condicao Fiscal(Tipo de Proveedor)
			nTipo := AScan( aTipos,{|X| alltrim(x[1])==Alltrim(SA1->A1_TIPO) })
			If nTipo == 0
				aTotCFis[Len(aTotCFis)][1]:=	aTotCFis[Len(aTotCFis)][1] + (nSigno *nValMerc)
				aTotCFis[Len(aTotCFis)][2]:=	aTotCFis[Len(aTotCFis)][2] + (nSigno *(cAliasSF3)->F3_VALIMP1)
				aTotCFis[Len(aTotCFis)][3]:=	aTotCFis[Len(aTotCFis)][3] + (nSigno *(cAliasSF3)->F3_VALIMP2)
				aTotCFis[Len(aTotCFis)][4]:=	aTotCFis[Len(aTotCFis)][4] + (nSigno *(cAliasSF3)->F3_VALIMP3)
				aTotCFis[Len(aTotCFis)][7]:=	aTotCFis[Len(aTotCFis)][7] + (nSigno *(cAliasSF3)->F3_VALIMP4)
				aTotCFis[Len(aTotCFis)][8]:=	aTotCFis[Len(aTotCFis)][8] + (nSigno *((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6))
				aTotCFis[Len(aTotCFis)][10]:=	aTotCFis[Len(aTotCFis)][10]+ (nSigno *nRetIVA)
				aTotCFis[Len(aTotCFis)][11]:=	aTotCFis[Len(aTotCFis)][11]+ (nSigno *nRetIBB)
				aTotCFis[Len(aTotCFis)][12]:=	aTotCFis[Len(aTotCFis)][12]+ (nSigno *nRetSUS)
				aTotCFis[Len(aTotCFis)][13]:=	aTotCFis[Len(aTotCFis)][13]+ (nSigno *nRetSLI)
				aTotCFis[Len(aTotCFis)][14]:=	aTotCFis[Len(aTotCFis)][14]+ (nSigno *(cAliasSF3)->F3_EXENTAS)
				aTotCFis[Len(aTotCFis)][15]:=	aTotCFis[Len(aTotCFis)][15]+ (nSigno *nValBrut)
			Else
				aTotCFis[nTipo][1]:=	aTotCFis[nTipo][1] + (nSigno *nValMerc)
				aTotCFis[nTipo][2]:=	aTotCFis[nTipo][2] + (nSigno *(cAliasSF3)->F3_VALIMP1)
				aTotCFis[nTipo][3]:=	aTotCFis[nTipo][3] + (nSigno *(cAliasSF3)->F3_VALIMP2)
				aTotCFis[nTipo][4]:=	aTotCFis[nTipo][4] + (nSigno *(cAliasSF3)->F3_VALIMP3)
				aTotCFis[nTipo][7]:=	aTotCFis[nTipo][7] + (nSigno *(cAliasSF3)->F3_VALIMP4)
				aTotCFis[nTipo][8]:=	aTotCFis[nTipo][8] + (nSigno *((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6))
				aTotCFis[nTipo][10]:=	aTotCFis[nTipo][10]+ (nSigno *nRetIVA)
				aTotCFis[nTipo][11]:=	aTotCFis[nTipo][11]+ (nSigno *nRetIBB)
				aTotCFis[nTipo][12]:=	aTotCFis[nTipo][12]+ (nSigno *nRetSUS)
				aTotCFis[nTipo][13]:=	aTotCFis[nTipo][13]+ (nSigno *nRetSLI)
				aTotCFis[nTipo][14]:=	aTotCFis[nTipo][14] +(nSigno *(cAliasSF3)->F3_EXENTAS)
				aTotCFis[nTipo][15]:=	aTotCFis[nTipo][15]+ (nSigno *nValBrut)
			Endif
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		//ณBusca y discrimina por Provincia (Si esta cargada la tabla de Provincia en el SX5).  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		If lProvincia       // Monta o resumo por Provincia (UF do Proveedor )
			nTipo := AScan( aProvincia,{|X| alltrim(x[1])==Alltrim(SA1->A1_EST) })
			If nTipo == 0
				aTotProv[Len(aTotProv)][1]:=	aTotProv[Len(aTotProv)][1] + (nSigno *nValMerc)
				aTotProv[Len(aTotProv)][2]:=	aTotProv[Len(aTotProv)][2] + (nSigno *(cAliasSF3)->F3_VALIMP1)
				aTotProv[Len(aTotProv)][3]:=	aTotProv[Len(aTotProv)][3] + (nSigno *(cAliasSF3)->F3_VALIMP2)
				aTotProv[Len(aTotProv)][4]:=	aTotProv[Len(aTotProv)][4] + (nSigno *(cAliasSF3)->F3_VALIMP3)
				aTotProv[Len(aTotProv)][7]:=	aTotProv[Len(aTotProv)][7] + (nSigno *(cAliasSF3)->F3_VALIMP4)
				aTotProv[Len(aTotProv)][8]:=	aTotProv[Len(aTotProv)][8] + (nSigno *((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6))
				aTotProv[Len(aTotProv)][10]:=	aTotProv[Len(aTotProv)][10]+ (nSigno *nRetIVA)
				aTotProv[Len(aTotProv)][11]:=	aTotProv[Len(aTotProv)][11]+ (nSigno *nRetIBB)
				aTotProv[Len(aTotProv)][12]:=	aTotProv[Len(aTotProv)][12]+ (nSigno *nRetSUS)
				aTotProv[Len(aTotProv)][13]:=	aTotProv[Len(aTotProv)][13]+ (nSigno *nRetSLI)
				aTotProv[Len(aTotProv)][14]:=	aTotProv[Len(aTotProv)][14]+ (nSigno*(cAliasSF3)->F3_EXENTAS)
				aTotProv[Len(aTotProv)][15]:=	aTotProv[Len(aTotProv)][15]+ (nSigno *nValBrut)
			Else
				aTotProv[nTipo][1]:=	aTotProv[nTipo][1] + (nSigno *nValMerc)
				aTotProv[nTipo][2]:=	aTotProv[nTipo][2] + (nSigno *(cAliasSF3)->F3_VALIMP1)
				aTotProv[nTipo][3]:=	aTotProv[nTipo][3] + (nSigno *(cAliasSF3)->F3_VALIMP2)
				aTotProv[nTipo][4]:=	aTotProv[nTipo][4] + (nSigno *(cAliasSF3)->F3_VALIMP3)
				aTotProv[nTipo][7]:=	aTotProv[nTipo][7] + (nSigno *(cAliasSF3)->F3_VALIMP4)
				aTotProv[nTipo][8]:=	aTotProv[nTipo][8] + (nSigno *((cAliasSF3)->F3_VALIMP5+(cAliasSF3)->F3_VALIMP6))
				aTotProv[nTipo][10]:=	aTotProv[nTipo][10]+ (nSigno *nRetIVA)
				aTotProv[nTipo][11]:=	aTotProv[nTipo][11]+ (nSigno *nRetIBB)
				aTotProv[nTipo][12]:=	aTotProv[nTipo][12]+ (nSigno *nRetSUS)
				aTotProv[nTipo][13]:=	aTotProv[nTipo][13]+ (nSigno *nRetSLI)
				aTotProv[nTipo][14]:=	aTotProv[nTipo][14]+(nSigno *(cAliasSF3)->F3_EXENTAS)
				aTotProv[nTipo][15]:=	aTotProv[nTipo][15]+ (nSigno *nValBrut)
			Endif
		Endif
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		//ณBusca y discrimina por Tipo de Produto (Si esta cargada la tabla de Tipo Materiales en el SX5).  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤp
		If Alltrim((cAliasSF3)->F3_ESPECIE) !="NCC"
			cChave := xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA
		Else
			cChave := xFilial("SD1")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA
		EndIf
		
		If (cAliasSF3)->F3_TIPO+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA # cNotaAnt
			If lProduto
				If Alltrim((cAliasSF3)->F3_ESPECIE) !="NCC"
					SD2->( dbSetOrder(3) )
					SD2->( dbSeek( xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA) )
					While !Eof() .And. SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA ==;
						xFilial("SD2")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA
						
						nTipo := AScan( aProduto,{|X| alltrim(x[1])==Alltrim(SD2->D2_TP) })
						nValImp := SD2->D2_VALIMP1+SD2->D2_VALIMP2+SD2->D2_VALIMP3+;
						SD2->D2_VALIMP4+SD2->D2_VALIMP5+SD2->D2_VALIMP6
						nValBrut:= SD2->D2_TOTAL+SD2->D2_VALFRE+SD2->D2_SEGURO+SD2->D2_DESPESA
						nValBrut := nSigno * (nValBrut + nValImp)
						If nTipo == 0
							aTotTPProd[Len(aTotTPProd)][1]:=	aTotTPProd[Len(aTotTPProd)][1] + (nSigno *xMoeda(SD2->D2_TOTAL,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][2]:=	aTotTPProd[Len(aTotTPProd)][2] + (nSigno *xMoeda(SD2->D2_VALIMP1,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][3]:=	aTotTPProd[Len(aTotTPProd)][3] + (nSigno *xMoeda(SD2->D2_VALIMP2,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][4]:=	aTotTPProd[Len(aTotTPProd)][4] + (nSigno *xMoeda(SD2->D2_VALIMP3,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][7]:=	aTotTPProd[Len(aTotTPProd)][7] + (nSigno *xMoeda(SD2->D2_VALIMP4,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][8]:=	aTotTPProd[Len(aTotTPProd)][8] + (nSigno *xMoeda((SD2->D2_VALIMP5+SD2->D2_VALIMP6),nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPPROD[Len(aTotTPPROD)][10]:=	aTotTPProd[Len(aTotTPProd)][10]+ (nSigno *nRetIVA)
							aTotTPProd[Len(aTotTPProd)][11]:=	aTotTPProd[Len(aTotTPProd)][11]+ (nSigno *nRetIBB)
							aTotTPPROD[Len(aTotTPPROD)][12]:=	aTotTPProd[Len(aTotTPProd)][12]+ (nSigno *nRetSUS)
							aTotTPProd[Len(aTotTPProd)][13]:=	aTotTPProd[Len(aTotTPProd)][13]+ (nSigno *nRetSLI)
							aTotTPProd[Len(aTotTPProd)][14]:=	aTotTPProd[Len(aTotTPProd)][14]+ (nSigno*(cAliasSF3)->F3_EXENTAS)
							aTotTPProd[Len(aTotTPProd)][15]:=	aTotTPProd[Len(aTotTPProd)][15]+ xMoeda(nValBrut,nMoeda,1,dDigita,nDecs,nTaxa)
						Else
							aTotTPProd[nTipo][1]:=	aTotTPProd[nTipo][1] + (nSigno *xMoeda(SD2->D2_TOTAL,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][2]:=	aTotTPProd[nTipo][2] + (nSigno *xMoeda(SD2->D2_VALIMP1,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][3]:=	aTotTPProd[nTipo][3] + (nSigno *xMoeda(SD2->D2_VALIMP2,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][4]:=	aTotTPProd[nTipo][4] + (nSigno *xMoeda(SD2->D2_VALIMP3,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][7]:=	aTotTPProd[nTipo][7] + (nSigno *xMoeda(SD2->D2_VALIMP4,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][8]:=	aTotTPProd[nTipo][8] + (nSigno *xMoeda((SD2->D2_VALIMP5+SD2->D2_VALIMP6),nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][10]:=	aTotTPProd[nTipo][10]+ (nSigno *nRetIVA)
							aTotTPProd[nTipo][11]:=	aTotTPProd[nTipo][11]+ (nSigno *nRetIBB)
							aTotTPProd[nTipo][12]:=	aTotTPProd[nTipo][12]+ (nSigno *nRetSUS)
							aTotTPProd[nTipo][13]:=	aTotTPProd[nTipo][13]+ (nSigno *nRetSLI)
	 						aTotTPProd[nTipo][14]:=	aTotTPProd[nTipo][14]+ (nSigno*(cAliasSF3)->F3_EXENTAS)
							aTotTPProd[nTipo][15]:=	aTotTPProd[nTipo][15]+ xMoeda(nValBrut,nMoeda,1,dDigita,nDecs,nTaxa)
						Endif
						SD2->(DbSkip())
					End
				Else
					SD1->( dbSetOrder(1) )
					SD1->( dbSeek( xFilial("SD1")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA) )
					While !Eof() .And. SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA ==;
						xFilial("SD1")+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA
						
						nTipo := AScan( aProduto,{|X| alltrim(x[1])==Alltrim(SD1->D1_TP) })
						nValImp := SD1->D1_VALIMP1+SD1->D1_VALIMP2+SD1->D1_VALIMP3+;
						SD1->D1_VALIMP4+SD1->D1_VALIMP5+SD1->D1_VALIMP6
						nValBrut:= SD1->D1_TOTAL+SD1->D1_VALFRE+SD1->D1_SEGURO+SD1->D1_DESPESA
						nValBrut := nSigno * (nValBrut + nValImp)
						If nTipo == 0
							aTotTPProd[Len(aTotTPProd)][1]:=	aTotTPProd[Len(aTotTPProd)][1] + (nSigno *xMoeda(SD1->D1_TOTAL,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][2]:=	aTotTPProd[Len(aTotTPProd)][2] + (nSigno *xMoeda(SD1->D1_VALIMP1,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][3]:=	aTotTPProd[Len(aTotTPProd)][3] + (nSigno *xMoeda(SD1->D1_VALIMP2,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][4]:=	aTotTPProd[Len(aTotTPProd)][4] + (nSigno *xMoeda(SD1->D1_VALIMP3,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][7]:=	aTotTPProd[Len(aTotTPProd)][7] + (nSigno *xMoeda(SD1->D1_VALIMP4,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[Len(aTotTPProd)][8]:=	aTotTPProd[Len(aTotTPProd)][8] + (nSigno *xMoeda((SD1->D1_VALIMP5+SD1->D1_VALIMP6),nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPPROD[Len(aTotTPPROD)][10]:=	aTotTPProd[Len(aTotTPProd)][10]+ (nSigno *nRetIVA)
							aTotTPProd[Len(aTotTPProd)][11]:=	aTotTPProd[Len(aTotTPProd)][11]+ (nSigno *nRetIBB)
							aTotTPPROD[Len(aTotTPPROD)][12]:=	aTotTPProd[Len(aTotTPProd)][12]+ (nSigno *nRetSUS)
							aTotTPProd[Len(aTotTPProd)][13]:=	aTotTPProd[Len(aTotTPProd)][13]+ (nSigno *nRetSLI)
							aTotTPProd[Len(aTotTPProd)][14]:=	aTotTPProd[Len(aTotTPProd)][14]+ (nSigno*(cAliasSF3)->F3_EXENTAS)
							aTotTPProd[Len(aTotTPProd)][15]:=	aTotTPProd[Len(aTotTPProd)][15]+ xMoeda(nValBrut,nMoeda,1,dDigita,nDecs,nTaxa)
						Else
							aTotTPProd[nTipo][1]:=	aTotTPProd[nTipo][1] + (nSigno *xMoeda(SD1->D1_TOTAL,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][2]:=	aTotTPProd[nTipo][2] + (nSigno *xMoeda(SD1->D1_VALIMP1,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][3]:=	aTotTPProd[nTipo][3] + (nSigno *xMoeda(SD1->D1_VALIMP2,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][4]:=	aTotTPProd[nTipo][4] + (nSigno *xMoeda(SD1->D1_VALIMP3,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][7]:=	aTotTPProd[nTipo][7] + (nSigno *xMoeda(SD1->D1_VALIMP4,nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][8]:=	aTotTPProd[nTipo][8] + (nSigno *xMoeda((SD1->D1_VALIMP5+SD1->D1_VALIMP6),nMoeda,1,dDigita,nDecs,nTaxa))
							aTotTPProd[nTipo][10]:=	aTotTPProd[nTipo][10]+ (nSigno *nRetIVA)
							aTotTPProd[nTipo][11]:=	aTotTPProd[nTipo][11]+ (nSigno *nRetIBB)
							aTotTPProd[nTipo][12]:=	aTotTPProd[nTipo][12]+ (nSigno *nRetSUS)
							aTotTPProd[nTipo][13]:=	aTotTPProd[nTipo][13]+ (nSigno *nRetSLI)
							aTotTPProd[nTipo][14]:=	aTotTPProd[nTipo][14]+ (nSigno*(cAliasSF3)->F3_EXENTAS)
							aTotTPProd[nTipo][15]:=	aTotTPProd[nTipo][15]+ xMoeda(nValBrut,nMoeda,1,dDigita,nDecs,nTaxa)
						Endif
						SD1->(DbSkip())
					End
				EndIf
			EndIf
		Endif
		cNotaAnt	:= (cAliasSF3)->F3_TIPO+(cAliasSF3)->F3_NFISCAL+(cAliasSF3)->F3_SERIE+(cAliasSF3)->F3_CLIEFOR+(cAliasSF3)->F3_LOJA
	EndIf
	(cAliasSF3)->(dbSkip())
	lImpTDia := .F.  //Flag de controle do quebra por dia
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDispara a funcao para impressao dos Totalizadores.   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู    
If lImpB
	Rar2ImpB()       // Imprime os valores dos documentos serie B(Consumidores finais)
EndIf	

If ( mv_par04 == 1 .And. !lImpTDia )
	RaR2TotDia()   // Imprime o sub total do dia
EndIf

RaR2TotPg()   // Imprime o Sub Total Impresso

If mv_par06 == 1
	RaR2Resumo()  // Imprime o resumo do relatorio
EndIf

Set Device To Screen
If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif
MS_FLUSH()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRAR2Cab   บAutor  ณGilson da Silva     บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cabecalho do Libro de IVA ( Vendas ).			          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RAR2Cab()

Local aDriver	:=	ReadDriver()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVariaveis utilizadas no cabecalhoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cTitulo    := OemToAnsi(STR0009) //"LIBRO DE  I.V.A. "
cTitulo    := cTitulo + OemToAnsi(STR0010) //"V E N T  A S"
cTitulo    := cTitulo + OemToAnsi(STR0026) //" - Desde : "
cTitulo    := cTitulo + DTOC(mv_par01)
cTitulo    := cTitulo + OemToAnsi(STR0027) //"   Hasta : "
cTitulo    := cTitulo + DTOC(mv_par02)
cEmpresa   := SM0->M0_NOMECOM
cInscr     := InscrEst()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCabecalho para o Relatorio.  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
nPagina := nPagina + 1
@ 00,000 PSAY &(aDriver[5])
@ 02,000 PSAY OemToAnsi(STR0011) //"Empresa: "
@ 02,020 PSAY cEmpresa
@ 03,000 PSAY OemToAnsi(STR0012) //"Pagina Nro.: "
@ 03,014 PSAY StrZero(nPagina,6)
@ 05,000 PSAY cTitulo
@ 07,000 PSAY OemToAnsi(STR0013)  //"Tipo Serie Comprobante   Razon Social        C.U.I.T.       Neto Gravado IVA   R.G IVA. R.N.I  IVA SERV  IVA BS.CAP  IVA  R.E  PERCEP.IVA  PERC.IIBB  PERC. GAN RET. IVA. RET. IIBB RET. SUS. RET. SLI    EXENTO    TOTAL"
//                               xx   x     xxxxxxxxxxxxx xxxxxxxxxxxxxxxxxx 12345678901234 999999999.99  999999.99  999999.99 999999.99  999999.99  999999.99   999999.99  999999.99 999999.99 999999.99 999999.99 999999.99 999999.99 999999.99 999999999.99
//                        0         1         2         3         4         5         6         7         8         9        10        11       12        13        14        15         16        17        18        19       20        21         22        23
//                        01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345679012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
nLin := 08
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRAR2TotDia  บAutor  ณGilson da Silva   บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rodape do Libro de IVA Vendas . 			              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RaR2TotDia()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDispara a funcao para impressao do Total do dia.   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
lImpTDia	:= .T.  //Flag para controlar se imprimiu a quebra por dia
nLin := nLin + 1
@ nLin,001 PSAY OemToAnsi(STR0028)+OemToAnsi(STR0016) //"Sub Total Facturas           : "
@ nLin,062 PSAY nFValMerc	     	Picture cPictVals
@ nLin,086 PSAY nFValImp1			Picture cPictImp
@ nLin,110 PSAY nFValImp2			Picture cPictImp
@ nLin,134 PSAY nFValImp3			Picture cPictImp
@ nLin,158 PSAY nFExento			Picture cPictImp
@ nLin,182 PSAY nFImpTotal			Picture cPictVals
nLin := nLin +1

@ nLin,001 PSAY OemToAnsi(STR0028)+OemToAnsi(STR0018) //"Sub Total Notas de Debito    : "
@ nLin,062 PSAY nDValMerc	      	Picture cPictVals
@ nLin,086 PSAY nDValImp1			Picture cPictImp
@ nLin,110 PSAY nDValImp2			Picture cPictImp
@ nLin,134 PSAY nDValImp3			Picture cPictImp
@ nLin,158 PSAY nDExento			Picture cPictImp
@ nLin,182 PSAY nDImpTotal			Picture cPictVals

nLin := nLin +1
@ nLin,001 PSAY OemToAnsi(STR0028)+OemToAnsi(STR0017) //"Sub Total Notas de Credito   : "
@ nLin,062 PSAY nCValMerc	      	Picture cPictVals
@ nLin,086 PSAY nCValImp1			Picture cPictImp
@ nLin,110 PSAY nCValImp2			Picture cPictImp
@ nLin,134 PSAY nCValImp3			Picture cPictImp
@ nLin,158 PSAY nCExento			Picture cPictImp
@ nLin,182 PSAY nCImpTotal			Picture cPictVals

nLin := nLin +2

dEntAnt := (cAliasSF3)->F3_ENTRADA

// zera as variaveis de sub totais
nFVALMERC :=0
nDVALMERC :=0
nCVALMERC :=0

nFValImp1 :=0
nDValImp1 :=0
nCValImp1 :=0

nFValImp2 :=0
nDValImp2 :=0
nCValImp2 :=0

nFValImp3 :=0
nDValImp3 :=0
nCValImp3 :=0

nFValImp4 :=0
nDValImp4 :=0
nCValImp4 :=0

nFValImp5 :=0
nDValImp5 :=0
nCValImp5 :=0

nFRetIVA  :=0
nDRetIVA  :=0
nCRetIVA  :=0

nFRetIBB  :=0
nDRetIBB  :=0
nCRetIBB  :=0

nFRetSUS  :=0
nDRetSUS  :=0
nCRetSUS  :=0

nFRetSLI  :=0
nDRetSLI  :=0
nCRetSLI  :=0
nFExento  :=0
nDExento  :=0
nCExento  :=0

nFImpTotal:=0
nDImpTotal:=0
nCImpTotal:=0
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRaR2TotPg   บAutor  ณGilson da Silva   บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Totaliza pagina do Libro de IVA ( Vendas  ).              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RaR2TotPg()

nLin := nLin + 1
@ nLin,015 PSAY OemToAnsi(STR0019) // "Totales por Tipo Tipo de Documento :"

nLin := nLin + 1
@ nLin,020 PSAY OemToAnsi(STR0016) //"Total Facturas           : "
@ nLin,062 PSAY nTFValMerc	      	Picture cPictVals
@ nLin,086 PSAY nTFValImp1			Picture cPictImp
@ nLin,110 PSAY nTFValImp2			Picture cPictImp
@ nLin,134 PSAY nTFValImp3			Picture cPictImp
@ nLin,158 PSAY ntFExento			Picture cPictImp
@ nLin,182 PSAY nTFImpTotal			Picture cPictVals

nLin := nLin +1
@ nLin,020 PSAY OemToAnsi(STR0018) //"Total Notas de Debito    : "
@ nLin,062 PSAY nTDValMerc	      	Picture cPictVals
@ nLin,086 PSAY nTDValImp1			Picture cPictImp
@ nLin,110 PSAY nTDValImp2			Picture cPictImp
@ nLin,134 PSAY nTDValImp3			Picture cPictImp
@ nLin,158 PSAY nTDExento			Picture cPictImp
@ nLin,182 PSAY nTDImpTotal			Picture cPictVals

nLin := nLin +1
@ nLin,020 PSAY OemToAnsi(STR0017) //"Total Notas de Credito   : "
@ nLin,062 PSAY nTCValMerc	      	Picture cPictVals
@ nLin,086 PSAY nTCValImp1			Picture cPictImp
@ nLin,110 PSAY nTCValImp2			Picture cPictImp
@ nLin,134 PSAY nTCValImp3			Picture cPictImp
@ nLin,158 PSAY nTCExento			Picture cPictImp
@ nLin,182 PSAY nTCImpTotal			Picture cPictVals

nLin := nLin + 2
@ nLin,015 PSAY OemToAnsi(STR0014) //"Totales Generales :"
nLin := nLin +1
@ nLin,020 PSAY OemToAnsi(STR0029) //"Total General :"
@ nLin,062 PSAY (nTFValMerc+nTDValMerc+nTCValMerc)	      	Picture cPictVals
@ nLin,086 PSAY (nTFValImp1+nTDValImp1+nTCValImp1)			Picture cPictImp
@ nLin,110 PSAY (nTFValImp2+nTDValImp2+nTCValImp2)			Picture cPictImp
@ nLin,134 PSAY (nTFValImp3+nTDValImp3+nTCValImp3)			Picture cPictImp
@ nLin,158 PSAY (nTFExento+nTDExento+nTCExento)	   			Picture cPictImp
@ nLin,182 PSAY (nTFImpTotal+nTDImpTotal+nTCImpTotal)		Picture cPictVals
nLin := nLin +1
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณRaR2Resumo  บAutor  ณGilson da Silva   บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rodape do Libro de IVA ( Vendas  ). 		              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RaR2Resumo()

Local nQtLinRes  	:= 0
Local nX       		:= 0
Local nD            := 0

nCnt1 :=	1
For nX:=1 To Len(aTotCFis)
	If aTotCFis[nx,1] <> 0
		nQtLinRes ++
	EndIf
Next nX
nQtLinRes := nQtLinRes+nLin
If nQtLinRes > 55
	RAR2Cab()  //Imprime o Cabecalho do relatorio
	nQtLinRes := 0
EndIf
If lTipos
	For nD:=	1 to len(aTotCFis)
		If aTotCFis[nD][1]<>0.00 .Or. aTotCFis[nD][2]<>0.00 .Or. aTotCFis[nD][3] <> 0.00 .Or.;
			aTotCFis[nD][4] <> 0.00 .Or. aTotCFis[nD][5]<>0.00 .Or. aTotCFis[nD][6] <> 0.00 .Or.;
			aTotCFis[nD][7] <> 0.00 .Or. aTotCFis[nD][8]<>0.00 .Or. aTotCFis[nD][9] <> 0.00 .Or.;
			aTotCFis[nD][10] <> 0.00 .Or. aTotCFis[nD][11]<>0.00 .Or. aTotCFis[nD][12] <> 0.00 .Or.;
			aTotCFis[nD][13] <> 0.00
			If nCnt1==1
				nLin := nLin +1
				@nLin , 015 PSAY OemToAnsi(STR0015)  //"Totales por Condicion Fiscal "
				nLin := nLin +1
			Endif
			nCnt1 ++
			@nLin   , 028 PSAY aTipos[nD][2]
			@nLin	, 062 PSAY  aTotCFis[nD][1]		Picture cPictVals
			@nLin	, 086 PSAY  aTotCFis[nD][2] 	Picture cPictImp
			@nLin	, 110 PSAY  aTotCFis[nD][3]  	Picture cPictImp
			@nLin	, 134 PSAY  aTotCFis[nD][4]  	Picture cPictImp
			@nLin   , 158 PSAY  aTotCFis[nD][14] 	Picture cPictImp
			@nLin	, 182 PSAY  aTotCFis[nD][15] 	Picture cPictVals
			nLin := nLin +1
		Endif
	Next
Endif

// TOTALES POR ZONA FISCAL
nQtLinRes := 2
For nX:=1 To Len(aTotProv)
	If aTotProv[nx,1] <> 0
		nQtLinRes ++
	EndIf
Next nX
nQtLinRes := nQtLinRes+nLin
If nQtLinRes > 55
	RAR2Cab()  //Imprime o Cabecalho do relatorio
	nQtLinRes := 0
EndIf
nCnt1 :=	1
If lProvincia
	For nD:=	1 to len(aTotProv)
		If aTotProv[nD][1]<>0.00 .Or. aTotProv[nD][2]<>0.00 .Or. aTotProv[nD][3] <> 0.00 .Or.;
			aTotProv[nD][4] <> 0.00 .Or. aTotProv[nD][5]<>0.00 .Or. aTotProv[nD][6] <> 0.00 .Or.;
			aTotProv[nD][7] <> 0.00 .Or. aTotProv[nD][8]<>0.00 .Or. aTotProv[nD][9] <> 0.00 .Or.;
			aTotProv[nD][10] <> 0.00 .Or. aTotProv[nD][11]<>0.00 .Or. aTotProv[nD][12] <> 0.00 .Or.;
			aTotProv[nD][13] <> 0.00
			If nCnt1==1
				nLin := nLin +1
				@nLin , 015 PSAY OemToAnsi(STR0030)  //"Totales por Zona Fiscal "
				nLin := nLin +1
			Endif
			nCnt1 ++
			@nLin   , 028 PSAY aProvincia [nD][2]
			@nLin	, 062 PSAY  aTotProv[nD][1] 	Picture cPictVals
			@nLin	, 086 PSAY  aTotProv[nD][2] 	Picture cPictImp
			@nLin	, 110 PSAY  aTotProv[nD][3] 	Picture cPictImp
			@nLin	, 134 PSAY  aTotProv[nD][4] 	Picture cPictImp
			@nLin   , 158 PSAY  aTotProv[nD][14] 	Picture cPictImp
			@nLin	, 182 PSAY  aTotProv[nD][15]	Picture cPictVals
			nLin := nLin +1
		Endif
	Next
Endif

// TOTALES POR TIPO DE PRODUTO
nQtLinRes := 2
For nX:=1 To Len(aTotTpProd)
	If aTotTpProd[nx,1] <> 0
		nQtLinRes ++
	EndIf
Next nX
nQtLinRes := nQtLinRes+nLin
If nQtLinRes > 55
	RAR2Cab()  //Imprime o Cabecalho do relatorio
EndIf
nCnt1 :=	1
If lProduto
	For nD:=	1 to len(aTotTpProd)
		If aTotTpProd[nD][1]<>0.00 .Or. aTotTpProd[nD][2]<>0.00 .Or. aTotTpProd[nD][3] <> 0.00 .Or.;
			aTotTpProd[nD][4] <> 0.00 .Or. aTotTpProd[nD][5]<>0.00 .Or. aTotTpProd[nD][6] <> 0.00 .Or.;
			aTotTpProd[nD][7] <> 0.00 .Or. aTotTpProd[nD][8]<>0.00 .Or. aTotTpProd[nD][9] <> 0.00 .Or.;
			aTotTpProd[nD][10] <> 0.00 .Or. aTotTpProd[nD][11]<>0.00 .Or. aTotTpProd[nD][12] <> 0.00 .Or.;
			aTotTpProd[nD][13] <> 0.00
			If nCnt1==1
				nLin := nLin +1
				@nLin , 015 PSAY OemToAnsi(STR0031)  //"Totales por Tipo de Producto "
				nLin := nLin +1
			Endif
			nCnt1 ++
			@nLin   , 028 PSAY aProduto[nD][2]
			@nLin	, 062 PSAY  aTotTpProd[nD][1] 	Picture cPictVals
			@nLin	, 086 PSAY  aTotTpProd[nD][2]	Picture cPictImp
			@nLin	, 110 PSAY  aTotTpProd[nD][3] 	Picture cPictImp
			@nLin	, 134 PSAY  aTotTpProd[nD][4]  	Picture cPictImp
			@nLin   , 158 PSAY  aTotTpProd[nD][14] 	Picture cPictImp
			@nLin	, 182 PSAY  aTotTpProd[nD][15] 	Picture cPictVals
			nLin := nLin +1
		Endif
	Next
Endif      

nLin := nLin +1

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณ Rar2ImpB บAutor  ณGilson da Silva    บ Data ณ  22/01/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime os valores acumulados dos documentos Serie B (Con- บฑฑ
ฑฑบ          ณ (sumidores finais)com valor de mercadoria menor que        บฑฑ                                                         
ฑฑบ          ณ MV_LIMCFIS                                                 บฑฑ                                                         
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Livros Fiscais                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Rar2ImpB()

@ nLin,001 PSAY cEspAnt				Picture "@!"
@ nLin,007 PSAY cSerAnt				Picture "@!"
@ nLin,013 PSAY OemToAnsi(STR0026)  //" - Desde : "
@ nLin,024 PSAY cDocIni         	Picture PesqPict("SF3","F3_NFISCAL")
@ nLin,039 PSAY OemToAnsi(STR0027)  //"   Hasta : "
@ nLin,050 PSAY cDocFim  			Picture PesqPict("SF3","F3_NFISCAL")
@ nLin,062 PSAY nVlMercB			Picture cPictVals
@ nLin,086 PSAY nVlImp1B			Picture cPictImp
@ nLin,110 PSAY nVlImp2B			Picture cPictImp
@ nLin,134 PSAY nVlImp3B			Picture cPictImp
@ nLin,158 PSAY nExentoB      		Picture cPictImp
@ nLin,182 PSAY nImpTotB			Picture cPictVals

nLin := nLin + 1

cSerAnt := " "     
cEspAnt := " "  
cDocIni := " "
cDocFim := " "
lImpB   := .F.

nFValMerc    	+= nVlMercB
nTFVALMERC 		+= nVlMercB
nFValImp1       += nVlImp1B
nTFValImp1      += nVlImp1B
nFValImp2       += nVlImp2B
nTFValImp2      += nVlImp2B
nFValImp3       += nVlImp3B
nTFValImp3      += nVlImp3B
nFValImp4       += nVlImp4B
nTFValImp4    	+= nVlImp4B
nFValImp5       += nVlImp5B
nTFValImp5      += nVlImp5B
nFRetIVA        += nRetIVAB	
nTFRetIVA	    += nRetIVAB
nFRetIBB        += nRetIBBB
nTFRetIBB       += nRetIBBB
nFRetSUS        += nRetSUSB
nTFRetSUS	    += nRetSUSB
nFRetSLI        += nRetSLIB
nTFRetSLI       += nRetSLIB
nFExento  		+= nExentoB
nTFExento  		+= nExentoB
nFImpTotal      += nImpTotB
nTFImpTotal     += nImpTotB 

nVlMercB := 0
nVlImp1B := 0
nVlImp2B := 0
nVlImp3B := 0
nVlImp4B := 0
nVlImp5B := 0
nExentoB := 0
nImpTotB := 0

Return