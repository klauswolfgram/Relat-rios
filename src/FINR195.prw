/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr195.ch"
#Include "PROTHEUS.CH"

#DEFINE COL_PREFIXO		000        
#DEFINE COL_TITULO		004
#DEFINE COL_PARCELA		035
#DEFINE COL_TIPO       	020
#DEFINE COL_FORNECEDOR	027
#DEFINE COL_EMISSAO		058
#DEFINE COL_VENCIMENTO	072
#DEFINE COL_RATEADO		087

Static lFWCodFil := .T.
Static lIsIssBx := FindFunction("IsIssBx")
Static _oFINR195
Static aMasksCTB := {}
Static aDscEntCTB := {}

/*                                                                                    
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FINR195    ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 05.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Contas a Pagar Realizadas por Centro de Custo                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±                  
±±³ Uso      ³ SIGAATF                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR195()
                                                               
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cString 	:= "SE2"
LOCAL cDesc1    := STR0001 //"Este programa ira demonstrar os rateio gerenciais"
LOCAL cDesc2    := STR0002 //"dentro do periodo informado nos parametros."
LOCAL cDesc3    := ""
LOCAL wnrel

PRIVATE aReturn  := { STR0003, 1,STR0004, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE cPerg    := "FIN195"
PRIVATE nomeprog := "FINR195"
PRIVATE nLastKey := 0
PRIVATE tamanho  := "M"

PRIVATE cabec0	:= ""
PRIVATE cabec1	:= ""
PRIVATE cabec2	:= ""
PRIVATE nTamanho    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros       					³
//³ mv_par01            Fornecedor De          					³
//³ mv_par02            Fornecedor Ate         					³
//³ mv_par03            Titulo De              					³
//³ mv_par04            Titulo Ate             					³
//³ mv_par05            Prefixo    De          					³
//³ mv_par06            Prefixo    Ate         					³
//³ mv_par07            Emissao Ate            					³
//³ mv_par08            Emissao De             					³
//³ mv_par09            Vencimento De          					³
//³ mv_par10            Vencimento Ate         					³
//³ mv_par11            Natureza De            					³
//³ mv_par12            Natureza Ate         					³
//³ mv_par13            Nivel Gerencial        					³
//³ mv_par14            Quebra - Somente o Nivel/Ate o Nivel	³
//³ mv_par15            Salta pagina por Nivel 					³
//³ mv_par16            Centro de Custo De     					³
//³ mv_par17            Centro de Custo Ate  					³
//³ mv_par18            Item Contabil   De     					³
//³ mv_par19            Item Contabil   Ate  					³
//³ mv_par20            Classe de Valor De     					³
//³ mv_par21            Classe de Valor Ate  					³
//³ mv_par22            Considera ? Previsto/Realizado			³
//³ mv_par23            Qual Moeda           					³
//³ mv_par24            Imprime - Analitico/Sintetico			³
//³ mv_par25            Considera Rateio ? Financeiro/Compras/Ambos	³
//³ mv_par26            Cons.Filiais Abaixo?                       	³
//³ mv_par27            Da Filial    ?                            	³
//³ mv_par28            Ate a Filial ?                            	³
//³ mv_par29            Quebra por Filial?                         	³
//³ mv_par30		 	Outras Moedas   ?  							³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

If mv_par13 = 1
	Titulo := STR0005 + CTBSayDsc("CTT") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTT") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 2
	Titulo := STR0005 + CTBSayDsc("CTD") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTD") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 3
	Titulo := STR0005 + CTBSayDsc("CTH") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTH") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 4
	Titulo := STR0005 + STR0015 //"Mapa Rateio - "	
	Titulo0 := STR0005 + STR0015 + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
Endif

wnrel := NomeProg
wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If mv_par13 = 1
	Titulo := STR0005 + CTBSayDsc("CTT") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTT") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 2
	Titulo := STR0005 + CTBSayDsc("CTD") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTD") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 3
	Titulo := STR0005 + CTBSayDsc("CTH") //"Mapa Rateio - "
	Titulo0 := STR0005 + CTBSayDsc("CTH") + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
ElseIf mv_par13 = 4
	Titulo := STR0005 + STR0015 //"Mapa Rateio - "	
	Titulo0 := STR0005 + STR0017 //"Mapa Rateio - (Filiais selecionadas para o relatorio)"
Endif

If nLastKey == 27
	Return
End
                                   
SetDefault( aReturn,cString )

nTamanho:=IIf(aReturn[4]==1,15,18)

/*

Prf Numero     Prc TP  Fornecedor           Emissao    Vencimento Realizado 1234
123 1234567890 001 12  12345678901234567890 99/99/9999 99/99/9999 999.999.999,99

*/

cabec0 := STR0016 // "Código         Empresa                                           Unidade de Negócio                                Filial"

If mv_par24 = 1
	cabec1  := STR0006 //"Prf Numero     Prc TP  Fornecedor           Emissao    Vencimento "
	cabec1  += Space(10) + If(mv_par22 = 1, STR0013, STR0014) + SuperGetMv("MV_SIMB" + Str(mv_par23,1),.T.,"  ")
Endif
cabec2  := ""
	

If nLastKey == 27
   Return
Endif

RptStatus({|lEnd| Fir195Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o     ³Fir195Imp ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 05/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o  ³ Imprime o relatorio de Contas a Pagar realizada por CC     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e  ³Fir195Imp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ FINR195                                                    ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º   Data    ³    Autor   ³ BOPS ³        Manutencao Efetuada             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º14/11/2007 ³Pedro P Lima³135367³O relatorio apresentava valores errados º±±
±±º           ³   TI6434   ³ P-10 ³quando os centros de custo selecionados º±±
±±º           ³            ³      ³continham porcentagem de rateio         º±±
±±º           ³            ³      ³diferente dos outros centros de custo,  º±±
±±º           ³            ³      ³imprimindo os valores incorretos, em    º±±
±±º           ³            ³      ³todas as linhas.                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Fir195Imp(lEnd,wnRel,cString)

LOCAL CbTxt
LOCAL CbCont
LOCAL aCampos, cArqTmp
Local lGestao   := ( FWSizeFilial() > 2 )
Local lSE2Excl  := Iif( lGestao, FWModeAccess("SE2",1) == "E", FWModeAccess("SE2",3) == "E")
Local lSE1Excl  := Iif( lGestao, FWModeAccess("SE1",1) == "E", FWModeAccess("SE1",3) == "E")
Local cRngFilSE2 := ""
Local cTmpSE2Fil := ""
Local aSelFil := {}
Local cFilialAnt := cFilAnt
Local lPrtFil := .T.
Local aTmpFil := {}
Local aRateios	:= {}
Local nDecs		:= MsDecimais(mv_par23), cCC, cItem, cClVl, cNatur, nLin, cCta 
Local nTotNat	:= nTotCC := nTotIt := nTotCl := nTotGeral := nTotGeralF := 0.00
Local cDescNat, cDescCC, cDescIt, cDescCl
Local nTamanho		:= 100, nPerc, nSomado, nRateio, nTotal, cFiltro, cFil195
Local nRateios 		:= 0 
Local nRegAtu  		:= 0 
Local nRegEmp		:= SM0->(Recno())
Local lD1FilOrig	:= .T.
Local bWhile
Local bFor
Local cAlias
Local cChaveCV4       
Local cFilAtu  		:= "" 
Local lArqRat
Local lIrfMp232		:= .F.
Local lCalcIssBx 	:= .F.
Local lPCCBaixa		:= .F.
Local lSest			:= .F.
Local nValSE2 		:= 0
Local nValSE5 		:= 0      
Local nI	 		:= 0
Local aAreaSE2 
Local aAreaSE5 
Local aFiliais		:= {}
Local aTps 
Local aParc 
Local nX
Local lCb10925 		:= GetNewPar("MV_CB10925","2") == "1"
Local lNovoRat		:= .F.
Local lExcSE2		:= !Empty(xFilial("SE2"))
Local lExcSD1		:= !Empty(xFilial("SD1"))
Local lProcFil		:= .T.
Local lTemDupl		:= .T.
Local lTemSDE		:= .T. // Para verificar se tem rateio do produto.
Local nARatear		:= 0
Local cItemNF	    := ''   
Local lRatBaixa		:= .F.
Local nRegSE5 
Local lSeq			:= .F.
Local nSaldo		:= 0
Local nInc			:= 0
Local aSM0			:= AdmAbreSM0()
Local aFil			:= {}
Local cFilterUser := Iif(Type("aReturn[7]") == "U"," ",aReturn[7]) //Filtro do Usuario
                          
aCampos:={	{"FILIAL" 		, "C" , IIf( lFWCodFil, FWGETTAMFILIAL, 2 ), 0 },;		// Codigo da Filial
			{"NATUR"  		, "C" , Len(SED->ED_CODIGO),0},;	// Cod. da Natureza
			{"DESCNAT"		, "C" , 25,0},;						// Descricao
			{"CC"     		, "C" , Len(CTK->CTK_CCD),0},;		// Centro de Custo
			{"DESCCC" 		, "C" , 35, 0},;						// Descricao
			{"ITEM"   		, "C" , Len(CTK->CTK_ITEMD),0},;	// Item Contabil
			{"DESCIT" 		, "C" , 35, 0},;						// Descricao
			{"CLVL"   		, "C" , Len(CTK->CTK_CLVLDB),0},;	// Classe de Valor
			{"DESCCL" 		, "C" , 35, 0},;						// Descricao
			{"PREFIXO"		, "C" , Len(SE2->E2_PREFIXO),0},;	// Prefixo do Titulo
			{"NUMERO" 		, "C" , Len(SE2->E2_NUM),0},;		// Numero do Titulo
			{"PARCELA"		, "C" , Len(SE2->E2_PARCELA),0},;	// Parcela
			{"TIPO"   		, "C" , Len(SE2->E2_TIPO),0},;		// Tipo do Titulo
			{"FORNECE"		, "C" , Len(SE2->E2_FORNECE),0},;	// Codigo do Fornecedor
			{"LOJA"   		, "C" , Len(SE2->E2_LOJA),0},;		// Loja do Fornecedor
			{"NOMFOR"		, "C" , Len(SE2->E2_NOMFOR),0},;	// Nome do Fornecedor
			{"EMISSAO"   	, "D" ,  8, 0},;                 	// Emissao
			{"VENCIMENTO"	, "D" ,  8, 0},;                 	// Vencimento
			{"RATEADO"		, "N" , 17, 4},;                 	// Valor Realizado/Previsto
			{"ITEMNF" 		, "C" ,  4, 0},;                 	// Item da NF
			{"CTACONTB" 	, "C" , 20, 0}} 						// Conta Contabil

If(_oFINR195 <> NIL)

	_oFINR195:Delete()
	_oFINR195 := NIL

EndIf

_oFINR195 := FwTemporaryTable():New("cArqTmp")
_oFINR195:SetFields(aCampos)

If mv_par13 = 1
	_oFINR195:AddIndex("1",{"FILIAL","CC","NATUR"}) //"Selecionando Registros..."
ElseIf mv_par13 = 2 .And. mv_par14 = 2
	_oFINR195:AddIndex("2",{"FILIAL","ITEM","CC","NATUR"}) //"Selecionando Registros..."
ElseIf mv_par13 = 2
	_oFINR195:AddIndex( "3",{"FILIAL","ITEM","NATUR"}) //"Selecionando Registros..."
ElseIf mv_par13 = 3 .And. mv_par14 = 2
	_oFINR195:AddIndex( "4",{"FILIAL","CLVL","ITEM","CC","NATUR"}) //"Selecionando Registros..."
ElseIf mv_par13 = 3
	_oFINR195:AddIndex( "5",{"FILIAL","CLVL","NATUR"}) //"Selecionando Registros..."
ElseIf mv_par13 = 4
	_oFINR195:AddIndex( "6",{"FILIAL", "NATUR"}) //"Selecionando Registros..."
Endif

_oFINR195:Create()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbTxt   := SPACE(10)
cbCont  := 0
nLin    := 80
m_pag   := 1

CTK->(DbSetOrder(1))
CV4->(DbSetOrder(1))
CTT->(DbSetOrder(1))
SEV->(DbSetOrder(1))
SEZ->(DbSetOrder(1))
If MV_MULNATP 
	SEZ->(Dbgotop())
Endif

dbSelectArea("SE5")
SE5->(dbSetOrder(7))

dbSelectArea("SE2")
SE2->(dbSetOrder(3))


If (lSE2Excl .and. mv_par32 == 1)
	aAreaSM0 := SM0->(GetArea())
	If lGestao
		aSelFil := FwSelectGC()
	Else
		aSelFil := AdmGetFil(.F.,.F.,"SE2")
	Endif
	RestArea(aAreaSM0)
Endif

If Len(aSelFil) > 1
	aSort(aSelFil)
	nTamEmp := Len(FWSM0LayOut(,1))
	nTamUnNeg := Len(FWSM0LayOut(,2))
	For nX := 1 To Len(aSelFil)
		If nLin > 58
			nLin := cabec(titulo0,cabec0,"",nomeprog,tamanho,GetMv("MV_COMP"))
			nLin++
		EndIf
		nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[nX]})
		If nLinha > 0
			cFilSel := Substr(aSM0[nLinha,SM0_CODFIL],1,nTamEmp)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + 1,nTamUnNeg)
			cFilSel += " "
			cFilSel += Substr(aSM0[nLinha,SM0_CODFIL],nTamEmp + nTamUnNeg + 1)
			Aadd(aFiliais,{aSM0[nLinha][2],aSM0[nLinha][1],nLinha})
			@ nLin,0 PSAY cFilSel
			@ nLin,15 PSAY aSM0[nLinha,SM0_DESCEMP]
			@ nLin,60 PSAY aSM0[nLinha,SM0_DESCUN]
			@ nLin++,90 PSAY aSM0[nLinha,SM0_NOMRED]
		Endif
	Next
	cRngFilSE2 := GetRngFil( aSelFil, "SE2", .T., @cTmpSE2Fil )
	aAdd(aTmpFil, cTmpSE2Fil)
	cFilSE2 := "E2_FILIAL "+ cRngFilSE2
	nLin := 80
Else
	aSelFil := {cFilAnt}
	nLinha := Ascan(aSM0,{|sm0|,sm0[SM0_CODFIL] == aSelFil[1]})
	Aadd(aFiliais,{aSM0[nLinha][2],aSM0[nLinha][1],nLinha})
	cFilSE2 := "E2_FILIAL = '"+ xFilial("SE2",aSelFil[1])
EndIf

If mv_par25 == 1 .Or. mv_par25 == 3		// Financeiro ou Ambos
	
	For nI := 1 to Len(aFiliais)
		cFilAtu := aFiliais[nI,1]
		nRegAtu := aFiliais[nI,3]
		
		cAliasQry := SelDados(	"SE2" /*cAlias*/, "E2_FILIAL = '"+ xFilial("SE2",cFilAtu) +"' .And. " +;
						 		"DTOS(E2_VENCREA) >= '" + Dtos(mv_par09) + "' .And. " +;
								"DTOS(E2_VENCREA) <= '" + Dtos(mv_par10) + "' .And. " +;
								"E2_FORNECE >= '" + mv_par01 + "' .And. " +;
								"E2_FORNECE <= '" + mv_par02 + "' .And. " +;
								"E2_NUM >= '" + mv_par03 + "' .And. " +;
								"E2_NUM <= '" + mv_par04 + "' .And. " +;
								"E2_PREFIXO >= '" + mv_par05 + "' .And. " +;
								"E2_PREFIXO <= '" + mv_par06 + "' .And. " +;
								"DTOS(E2_EMISSAO) >= '" + Dtos(mv_par07) + "' .And. " +;
								"DTOS(E2_EMISSAO) <= '" + Dtos(mv_par08) + "' .And. " +;
								"E2_NATUREZ >= '" + mv_par11 + "' .And. " +;
								"E2_NATUREZ <= '" + mv_par12 + "'" +;
								If(mv_par22 == 1, " .And. E2_SALDO <> E2_VALOR", "") +;
								If(mv_par22 == 2, " .And. E2_SALDO = E2_VALOR", "") +;
								If(mv_par30 == 2, " .And. E2_MOEDA = " + Str(mv_par23, 1), ""))

		If (cAliasQry)->(!EoF())
			
			Do While (mv_par25 = 1 .Or. mv_par25 = 3) .And. (cAliasQry)->(!EoF()) //Financeiro ou Ambos
				
				CarregaSel("SE2")
				
				//Permite que o filtro de usuario seja utilizado.
				If !Empty(cFilterUser).and.!(&cFilterUser)
					(cAliasQry)->(DbSkip())
					Loop
				Endif
				
				If mv_par22 = 2 //Considera ? Previsto
					If ((SE2->E2_RATEIO = 'S' .And. SE2->E2_ARQRAT <> ' ') .Or.;
						(SE2->E2_MULTNAT = "1"))
						
						If SE2->E2_SALDO > 0 .And. SE2->E2_MULTNAT = "1" .And. Select("SEZ") > 0      //multiplas naturezas
							SEV->(DbSeek(xFilial("SEV",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
							SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA))
							
							While 	SEV->(	EV_FILIAL + EV_PREFIXO + EV_NUM +;
								EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) ==;
								xFilial("SEV",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
								SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA .And.;
								! SEV->(Eof())
								
								If SEV->EV_IDENT == "1" //INCLUSAO
									nSaldo := SEV->EV_VALOR
									
									SEZ->(DbSeek(	xFilial("SEZ",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
									SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE +;
									SE2->E2_LOJA + SEV->EV_NATUREZ))
									SED->(DbSeek(xFilial("SED",cFilAtu) + SEV->EV_NATUREZ))
									
									
									While 	SEZ->(	EZ_FILIAL + EZ_PREFIXO + EZ_NUM +;
										EZ_PARCELA + EZ_TIPO + EZ_CLIFOR + EZ_LOJA + EZ_NATUREZ ) ==;
										xFilial("SEZ",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
										SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE +;
										SE2->E2_LOJA + SEV->EV_NATUREZ .And. ! SEZ->(Eof())
										
										If SEZ->EZ_IDENT == "1"	//INCLUSAO
											cCc 	:= 	SEZ->EZ_CCUSTO
											cItem 	:= 	SEZ->EZ_ITEMCTA
											cClVl 	:= 	SEZ->EZ_CLVL
											If 	(cCC >= mv_par16 .And. cCc <= mv_par17) 		.And.;
												(cItem >= mv_par18 .And. cItem <= mv_par19) 	.And.;
												(cClVl >= mv_par20 .And. cClVl <= mv_par21)
												If 	(mv_par13 = 1 .And. ! Empty(cCc)) .Or.;
													(mv_par13 = 2 .And. ! Empty(cItem)) .Or.;
													(mv_par13 = 3 .And. ! Empty(cClVl))  .Or.;
													(mv_par13 = 4)
													
													CTT->(DbSeek(xFilial("CTT",cFilAtu) + cCC))
													CTD->(DbSeek(xFilial("CTD",cFilAtu) + cItem))
													CTH->(DbSeek(xFilial("CTH",cFilAtu) + cClVl))
													
													//DbSelectArea("cArqTmp")
													RecLock("cArqTmp", .T.)
													cArqTmp->NATUR 		:= SEV->EV_NATUREZ
													cArqTmp->DESCNAT	:= SED->ED_DESCRIC
													
													// Centro de Custo
													
													cArqTmp->CC    		:= cCC
													cArqTmp->DESCCC  	:= If(mv_par23 == 1, CTT->CTT_DESC01,&("CTT->CTT_DESC" + StrZero(mv_par23,2)))
													If Empty(cArqTmp->DESCCC)
														cArqTmp->DESCCC := CTT->CTT_DESC01
													Endif
													
													// Item Contabil
													
													cArqTmp->ITEM  		:= cItem
													cArqTmp->DESCIT  	:= If(mv_par23 == 1, CTD->CTD_DESC01,&("CTD->CTD_DESC" + StrZero(mv_par23,2)))
													If Empty(cArqTmp->DESCIT)
														cArqTmp->DESCIT := CTD->CTD_DESC01
													Endif
													
													// Classe de Valor
													
													cArqTmp->CLVL  		:= cClVl
													cArqTmp->DESCCL  	:= If(mv_par23 == 1, CTH->CTH_DESC01,&("CTH->CTH_DESC" + StrZero(mv_par23,2)))
													If Empty(cArqTmp->DESCCL)
														cArqTmp->DESCCL := CTH->CTH_DESC01
													Endif
													
													If mv_par29 = 1
														cArqTmp->FILIAL	:= SE2->E2_FILIAL
													Endif
													cArqTmp->PREFIXO	:= SE2->E2_PREFIXO
													cArqTmp->NUMERO 	:= SE2->E2_NUM
													cArqTmp->PARCELA	:= SE2->E2_PARCELA
													cArqTmp->TIPO   	:= SE2->E2_TIPO
													cArqTmp->NOMFOR		:= GetLGPDValue('SE2','E2_NOMFOR')
													cArqTmp->EMISSAO    := SE2->E2_EMISSAO
													cArqTmp->VENCIMENTO := SE2->E2_VENCREA
													cArqTmp->RATEADO  	:= xMoeda(nSaldo * SEZ->EZ_PERC, SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
													MsUnLock()
												Endif
											Endif
										Endif
										SEZ->(DbSkip())
									EndDo
								Endif
								SEV->(DbSkip())
							EndDo
						Else
							SED->(DbSeek(xFilial("SED",cFilAtu) + SE2->E2_NATUREZ))
							CTK->(DbSeek(xFilial("CTK",cFilAtu) + SE2->E2_ARQRAT + "511"))
							
							bWhile := { || CTK->CTK_SEQUEN = SE2->E2_ARQRAT .And. ! CTK->(Eof()) }
							bFor	 := { || CTK->CTK_CONTAB = "4" }
							cAlias := "CTK"
							// Se nao encontrou no CTK, pesquisa no CV4
							If CTK->(!Found())
								cChaveCV4 := RTrim(SE2->E2_ARQRAT)
								CV4->(MsSeek(cChaveCV4)) // Chave jah contem filial
								bWhile := { || CV4->(!Eof()) .And. CV4->CV4_FILIAL+DTOS(CV4->CV4_DTSEQ)+CV4->CV4_SEQUEN == cChaveCV4 }
								bFor	 := { || .T. }
								cAlias := "CV4"
							Endif
							While Eval(bWhile)
								If Eval(bFor)
									If cAlias == 'CTK'
										cCta	:= (cAlias)->(If(Empty(CTK_DEBITO), CTK_CREDITO, CTK_DEBITO))
										cCc		:= (cAlias)->(If(Empty(CTK_CCD), CTK_CCC, CTK_CCD))
										cItem	:= (cAlias)->(If(Empty(CTK_ITEMD), CTK_ITEMC, CTK_ITEMD))
										cClVl	:= (cAlias)->(If(Empty(CTK_CLVLDB), CTK_CLVLCR, CTK_CLVLDB))
									Else
										cCta	:= (cAlias)->(If(Empty(CV4_DEBITO), CV4_CREDITO, CV4_DEBITO))
										cCc		:= (cAlias)->(If(Empty(CV4_CCD), CV4_CCC, CV4_CCD))
										cItem	:= (cAlias)->(If(Empty(CV4_ITEMD), CV4_ITEMC, CV4_ITEMD))
										cClVl	:= (cAlias)->(If(Empty(CV4_CLVLDB), CV4_CLVLCR, CV4_CLVLDB))
									EndIf
									If (cCC >= mv_par16 .And. cCc <= mv_par17) 		.And.;
										(cItem >= mv_par18 .And. cItem <= mv_par19) 	.And.;
										(cClVl >= mv_par20 .And. cClVl <= mv_par21)
										If (mv_par13 = 1 .And. ! Empty(cCc)) .Or.;
											(mv_par13 = 2 .And. ! Empty(cItem)) .Or.;
											(mv_par13 = 3 .And. ! Empty(cClVl)) .Or.;
											(mv_par13 = 4)
											
											//DbSelectArea("cArqTmp")
											RecLock("cArqTmp", .T.)
											cArqTmp->NATUR 	:= SE2->E2_NATUREZ
											cArqTmp->DESCNAT	:= SED->ED_DESCRIC
											
											// Conta Cont bil
											cArqTmp->CTACONTB    := cCta
											
											// Centro de Custo
											If !Empty(cCC) .and. CTT->(DbSeek(xFilial("CTT",cFilAtu) + cCC))
												cArqTmp->CC    		:= cCC
												cArqTmp->DESCCC  	:= &("CTT->CTT_DESC" + StrZero(mv_par23,2))
												If Empty(cArqTmp->DESCCC)
													cArqTmp->DESCCC := CTT->CTT_DESC01
												Endif
											EndIf
											
											// Item Contabil
											If !Empty(cItem) .and. CTD->(DbSeek(xFilial("CTD",cFilAtu) + cItem))
												cArqTmp->ITEM  		:= cItem
												cArqTmp->DESCIT  	:= &("CTD->CTD_DESC" + StrZero(mv_par23,2))
												If Empty(cArqTmp->DESCIT)
													cArqTmp->DESCIT := CTD->CTD_DESC01
												Endif
											EndIf
											
											// Classe de Valor
											If !Empty(cClVl) .and. CTH->(DbSeek(xFilial("CTH",cFilAtu) + cClVl))
												cArqTmp->CLVL  		:= cClVl
												cArqTmp->DESCCL  	:= &("CTH->CTH_DESC" + StrZero(mv_par23,2))
												If Empty(cArqTmp->DESCCL)
													cArqTmp->DESCCL := CTH->CTH_DESC01
												Endif
											EndIf
											
											If mv_par29 = 1
												cArqTmp->FILIAL	:= SE2->E2_FILIAL
											Endif
											cArqTmp->PREFIXO	:= SE2->E2_PREFIXO
											cArqTmp->NUMERO 	:= SE2->E2_NUM
											cArqTmp->PARCELA	:= SE2->E2_PARCELA
											cArqTmp->TIPO   	:= SE2->E2_TIPO
											cArqTmp->NOMFOR		:= GetLGPDValue('SE2','E2_NOMFOR')
											cArqTmp->EMISSAO    := SE2->E2_EMISSAO
											cArqTmp->VENCIMENTO := SE2->E2_VENCREA
											If cAlias == "CTK"
												cArqTmp->RATEADO := xMoeda(SE2->E2_VALOR * (CTK->CTK_VLR01 / SE2->E2_VALOR), SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
											Else
												cArqTmp->RATEADO := xMoeda(CV4->CV4_VALOR, SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
											EndIf
											MsUnLock()
										Endif
									Endif
								Endif
								(cAlias)->(DbSkip())
							EndDo
						Endif
					EndIf
				ElseIf SE5->(DbSeek(xFilial("SE5",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA +; //mv_par22 <> 2 -> Considera ? Realizado
					SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA))
					//No caso do SE5 ser compartilhado devo verificar o campo E5_FILORIG.
					If Empty(xFilial("SE5",cFilAtu)) .and. Alltrim(SE5->E5_FILORIG) <> Alltrim(cFilAtu)
						(cAliasQry)->(dbSkip())
						Loop
					Endif
					
					aRateios := {}
					
					If ((SE5->E5_MULTNAT = "1") .Or. ;
						(SE2->E2_RATEIO = 'S' .And. SE2->E2_ARQRAT <> ' ') .Or.;
						(SE2->E2_MULTNAT = "1"))
						
						If  SE2->E2_MULTNAT = "1" .And. Select("SEZ") > 0
							SEV->(DbSetOrder(2))
							
							// verifica se teve rateio de multiplas naturezas na baixa (EV_IDENT == 2), caso nao tenha,
							// considera o rateio informado na emissao do titulo (EV_IDENT == 1)
							If SEV->(DbSeek(	xFilial("SEV",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
								SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA + '2'))
								If SEV->EV_SITUACA == " "
									lRatBaixa := .T.
								Else
									While SEV->(EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) ==;
										xFilial("SEV",cFilAtu)+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA .and.;
										!SEV->(Eof()) .and. SEV->EV_IDENT == '2' .and. lRatBaixa == .F.
										SEV->(DbSkip())
										If 	SEV->(EV_FILIAL + EV_PREFIXO + EV_NUM + EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) == xFilial("SEV",cFilAtu) +;
											SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA .and.;
											SEV->EV_SITUACA == " "
											lRatBaixa := .T.
										EndIf
									EndDo
								EndIf
							EndIf
							If !lRatBaixa
								SEV->(DbSeek(	xFilial("SEV",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
								SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA + '1'))
							EndIf
							
							While 	SEV->(	EV_FILIAL + EV_PREFIXO + EV_NUM +;
								EV_PARCELA + EV_TIPO + EV_CLIFOR + EV_LOJA) ==;
								xFilial("SEV",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
								SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA .And.;
								! SEV->(Eof())
								//Validação para considerar os registros ativos.
								If SEV->EV_SITUACA <> " "
									SEV->(DbSkip())
									Loop
								EndIf
								
								SEZ->(DbSeek(	xFilial("SEZ",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
								SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE +;
								SE2->E2_LOJA + SEV->EV_NATUREZ))
								
								While 	SEZ->(	EZ_FILIAL + EZ_PREFIXO + EZ_NUM +;
									EZ_PARCELA + EZ_TIPO + EZ_CLIFOR + EZ_LOJA + EZ_NATUREZ) ==;
									xFilial("SEZ",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +;
									SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE +;
									SE2->E2_LOJA + SEV->EV_NATUREZ .And. ! SEZ->(Eof())
									
									//Validação para considerar os registros ativos.
									If SEZ->EZ_SITUACA <> " "  .or. SEZ->EZ_IDENT<>SEV->EV_IDENT
										SEZ->(DbSkip())
										Loop
									EndIf
									
									If SEZ->EZ_SEQ == SEV->EV_SEQ //Mesma sequencia de baixa.
										
										cCc 	:= 	SEZ->EZ_CCUSTO
										cItem 	:= 	SEZ->EZ_ITEMCTA
										cClVl 	:= 	SEZ->EZ_CLVL
										
										If 	(cCC >= mv_par16 .And. cCc <= mv_par17) 		.And.;
											(cItem >= mv_par18 .And. cItem <= mv_par19) 	.And.;
											(cClVl >= mv_par20 .And. cClVl <= mv_par21)
											If 	(mv_par13 = 1 .And. ! Empty(cCc)) .Or.;
												(mv_par13 = 2 .And. ! Empty(cItem)) .Or.;
												(mv_par13 = 3 .And. ! Empty(cClVl)) .Or.;
												(mv_par13 = 4)
												Aadd(aRateios, { SEZ->EZ_VALOR, cCC, cItem, cClVl,;
												SEV->EV_NATUREZ, SEZ->EZ_PERC, SEV->EV_PERC, SEV->EV_SEQ })
											Endif
										Endif
									Endif
									SEZ->(DbSkip())
								EndDo
								SEV->(DbSkip())
							EndDo
						Else
							CTK->(DbSeek(xFilial("CTK",cFilAtu) + SE2->E2_ARQRAT + "511"))
							SED->(DbSeek(xFilial("SED",cFilAtu) + SE2->E2_NATUREZ))
							bWhile := { || CTK->CTK_SEQUEN = SE2->E2_ARQRAT .And. ! CTK->(Eof()) }
							bFor	 := { || CTK->CTK_CONTAB = "4" }
							cAlias := "CTK"
							// Se nao encontrou no CTK, pesquisa no CV4
							If CTK->(!Found())
								cChaveCV4 := RTrim(SE2->E2_ARQRAT)
								CV4->(MsSeek(cChaveCV4)) // Chave jah contem filial
								bWhile := { || CV4->(!Eof()) .And. CV4->CV4_FILIAL+DTOS(CV4->CV4_DTSEQ)+CV4->CV4_SEQUEN == cChaveCV4 }
								bFor	 := { || .T. }
								cAlias := "CV4"
							Endif
							
							While Eval(bWhile)
								If Eval(bFor)
									cCta:= If(Empty((cAlias)->&(cAlias+"_DEBITO")), (cAlias)->&(cAlias+"_CREDIT"), (cAlias)->&(cAlias+"_DEBITO"))
									cCc	:= If(Empty((cAlias)->&(cAlias+"_CCD")), (cAlias)->&(cAlias+"_CCC"), (cAlias)->&(cAlias+"_CCD"))
									cItem	:= If(Empty((cAlias)->&(cAlias+"_ITEMD")), (cAlias)->&(cAlias+"_ITEMC"), (cAlias)->&(cAlias+"_ITEMD"))
									cClVl := If(Empty((cAlias)->&(cAlias+"_CLVLDB")), (cAlias)->&(cAlias+"_CLVLCR"), (cAlias)->&(cAlias+"_CLVLDB"))
									
									If (cCC >= mv_par16 .And. cCc <= mv_par17) 		.And.;
										(cItem >= mv_par18 .And. cItem <= mv_par19) 	.And.;
										(cClVl >= mv_par20 .And. cClVl <= mv_par21)
										If (mv_par13 = 1 .And. ! Empty(cCc)) .Or.;
											(mv_par13 = 2 .And. ! Empty(cItem)) .Or.;
											(mv_par13 = 3 .And. ! Empty(cClVl)) .Or.;
											(mv_par13 = 4)
											Aadd(aRateios, { If(cAlias == "CTK",CTK->CTK_VLR01,CV4->CV4_VALOR), cCC, cItem, cClVl, cCta })
										Endif
									Endif
								Endif
								(cAlias)->(DbSkip())
							EndDo
						Endif
					EndIf
					
					If Len(aRateios) = 0
						DbSelectArea(cAliasQry)
						DbSkip()
						Loop
					Endif
					
					While 	SE5->E5_FILIAL + SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA +;
						SE5->E5_TIPO + SE5->E5_CLIFOR + SE5->E5_LOJA ==;
						xFilial("SE5",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA +;
						SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA .And. ! SE5->(Eof())
						
						//No caso do SE5 ser compartilhado devo verificar o campo E5_FILORIG.
						If Empty(xFilial("SE5")) .and. Alltrim(cFilAtu) <> Alltrim(SE5->E5_FILORIG)
							SE5->(dbSkip())
							Loop
						Endif
						
						IF 	SE5->E5_SITUACA == "C" .Or.;
							SE5->E5_TIPODOC $ "CH/DC/D2/JR/J2/TL/MT/M2/CM/C2"
							SE5->(dbSkip())
							Loop
						Endif
						
						If 	! (SE5->E5_DATA >= mv_par09 .And. SE5->E5_DATA <= mv_par10)
							SE5->(dbSkip())
							Loop
						Endif
						
						If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
							SE5->(DbSkip())
							Loop
						EndIf
						
						For nRateios := 1 To Len(aRateios)
							
							If Len(aRateios[nRateios]) <= 5							
								lSeq := .T.
							ElseIf aRateios[nRateios, 8] == SE5->E5_SEQ	// Verifica se possui a mesma sequencia de baixa
								lSeq := .T.
							Endif
							
							If lSeq
								nValSE2 := 0
								nValSE5 := 0
								
								CTT->(DbSeek(xFilial("CTT",cFilAtu) + aRateios[nRateios, 2]))
								CTD->(DbSeek(xFilial("CTD",cFilAtu) + aRateios[nRateios, 3]))
								CTH->(DbSeek(xFilial("CTH",cFilAtu) + aRateios[nRateios, 4]))
								
								DbSelectArea("cArqTmp")
								RecLock("cArqTmp", .T.)
								If Len(aRateios[nRateios]) > 5
									cArqTmp->NATUR 	:= aRateios[nRateios][5]
								Else
									cArqTmp->NATUR 	:= SE2->E2_NATUREZ
								Endif
								SED->(DbSeek(xFilial("SED",cFilAtu) + cArqTmp->NATUR))
								cArqTmp->DESCNAT	:= SED->ED_DESCRIC
								
								// Centro de Custo
								cArqTmp->CTACONTB:= aRateios[nRateios, 5]
								cArqTmp->CC    	:= aRateios[nRateios, 2]
								cArqTmp->DESCCC  	:= &("CTT->CTT_DESC" + StrZero(mv_par23,2))
								If Empty(cArqTmp->DESCCC)
									cArqTmp->DESCCC := CTT->CTT_DESC01
								Endif
								
								// Item Contabil
								cArqTmp->ITEM  		:= aRateios[nRateios, 3]
								cArqTmp->DESCIT  	:= &("CTD->CTD_DESC" + StrZero(mv_par23,2))
								If Empty(cArqTmp->DESCIT)
									cArqTmp->DESCIT := CTD->CTD_DESC01
								Endif
								
								// Classe de Valor
								cArqTmp->CLVL  		:= aRateios[nRateios, 4]
								cArqTmp->DESCCL  	:= &("CTH->CTH_DESC" + StrZero(mv_par23,2))
								If Empty(cArqTmp->DESCCL)
									cArqTmp->DESCCL := CTH->CTH_DESC01
								Endif
								
								lIrfMp232	:= cPaisLoc == "BRA" .and. SA2->A2_CALCIRF == "2"
								
								lCalcIssBx	:= IIF(lIsIssBx, IsIssBx("P"), SuperGetMv("MV_MRETISS",.F.,"1") == "2" )
								
								lPCCBaixa	:= 	SuperGetMv("MV_BX10925",.T.,"2") == "1"
								
								lSest		:= .T.  //Verifica campo de SEST
								nValSE2 += SE2->E2_VALOR + SE2->(If(!lIrfMP232,E2_IRRF,0)+E2_INSS+If(!lCalcIssBx,E2_ISS,0)+If(lSest,E2_SEST,0))
								nValSE5 += SE5->E5_VALOR + SE5->E5_VLDESCO + SE5->E5_VLACRES + SE5->E5_VLDECRE
								
								aAreaSE5 := SE5->(GetArea())
								If !Fa050Filho(.T.)
									aAreaSe2 := SE2->(GetArea())
									aTps := {"TX ","INS","ISS","SES"}
									aParc := {SE2->E2_PARCIR,SE2->E2_PARCINS,SE2->E2_PARCISS,SE2->E2_PARCSES}
									Aadd(aParc, SE2->E2_PARCPIS)
									Aadd(aParc, SE2->E2_PARCCOF)
									Aadd(aParc, SE2->E2_PARCSLL)
									Aadd(aTps , "TX ")
									Aadd(aTps , "TX ")
									Aadd(aTps , "TX ") // aTps deve ter o mesmo tamanho de aParc
									
									SE2->(DbSetOrder(1))
									
									For nX := 1 to Len(aTps)
										// Se encontrou o titulo filho (titulo de tributo) e este sofreu baixa
										// Não permite a exclusao do titulo pai (titulo principal).
										If !Empty(aParc[nx]) .And. SE2->(Msseek(xFilial("SE2",cFilAtu)+SE5->(E5_PREFIXO+E5_NUMERO)+aParc[nX]+aTps[nX])) .And.;
											(SE2->E2_SALDO != SE2->E2_VALOR) .And. !lCb10925
											nValSE5 += SE2->E2_VALOR - SE2->E2_SALDO
										Endif
									Next
									RestArea(aAreaSE2)
								EndIf
								RestArea(aAreaSE5)
								
								If !lPccBaixa
									nValSE2 += SE2->(E2_PIS+E2_COFINS+E2_CSLL)
								EndIf
								
								If mv_par29 = 1
									cArqTmp->FILIAL	:= SE2->E2_FILIAL
								Endif
								cArqTmp->PREFIXO	:= SE2->E2_PREFIXO
								cArqTmp->NUMERO 	:= SE2->E2_NUM
								cArqTmp->PARCELA	:= SE2->E2_PARCELA
								cArqTmp->TIPO   	:= SE2->E2_TIPO
								cArqTmp->NOMFOR		:= GetLGPDValue('SE2','E2_NOMFOR')
								cArqTmp->EMISSAO    := SE2->E2_EMISSAO
								cArqTmp->VENCIMENTO := SE5->E5_DATA
								If Len(aRateios[nRateios]) > 5
									cArqTmp->RATEADO := xMoeda(aRateios[nRateios][6] *;
									aRateios[nRateios][7] * SE5->E5_VALOR, SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
								Else
									cArqTmp->RATEADO := xMoeda(Round(NoRound(nValSE5 * (aRateios[nRateios, 1] / nValSE2 ), 3), 2), SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
								Endif
								MsUnLock()
								lSeq := .F.
							Endif
						Next
						SE5->(DbSkip())
					EndDo
				Endif
				
				DbSelectArea(cAliasQry)
				DbSkip()
			EndDo
			
		EndIf
		
		dbSelectArea("SE2")
		
		// O alias alternativo para o SE2 sera aberto apenas quando solicitada a opcao
		// Considera Rateio for igual a Financeiro ou ambos
		RemoveSel("SE2")
		//Se o SE2 for compartilhado, deve percorrer apenas uma vez.
		If !lExcSE2
			Exit
		Endif
	Next nI
	
EndIf

If mv_par25 = 2 .Or. mv_par25 = 3			// Compras ou Ambos
	
	For nI := 1 to Len(aFiliais)
		
		cFilAtu := aFiliais[nI,1]
		nRegAtu := aFiliais[nI,3]
		
		cFilAnt := cFilAtu
		
		cQuery := "select SD1.R_E_C_N_O_ from " + RetSqlName("SD1") + " SD1, " + RetSqlName("SF1") + " SF1"
		cQuery += " where F1_FILIAL = '" + xFilial("SF1") + "'"
		cQuery += " and F1_FORNECE >= '" + MV_PAR01 + "'"
		cQuery += " and F1_FORNECE <= '" + MV_PAR02 + "'"
		cQuery += " and F1_DOC >= '" + MV_PAR03 + "'"
		cQuery += " and F1_DOC <= '" + MV_PAR04 + "'"
		cQuery += " and F1_PREFIXO >= '" + MV_PAR05 + "'"
		cQuery += " and F1_PREFIXO <= '" + MV_PAR06 + "'"
		cQuery += " and F1_EMISSAO >= '" + Dtos(MV_PAR07) + "'"
		cQuery += " and F1_EMISSAO <= '" + Dtos(MV_PAR08) + "'"
		cQuery += " and SF1.D_E_L_E_T_ = ' '"
		cQuery += " and D1_FILIAL = '" + xFilial("SD1") + "'"
		cQuery += " and D1_FORNECE = F1_FORNECE"
		cQuery += " and D1_LOJA = F1_LOJA"
		cQuery += " and D1_DOC = F1_DOC"
		cQuery += " and D1_SERIE = F1_SERIE"
		if MV_PAR31 <> 1
			cQuery += " and D1_RATEIO = '1'"
		Endif
		cQuery += " and SD1.D_E_L_E_T_ = ' '"
		
		cQuery := ChangeQuery(cQuery)
		cAliasQry := GetNextAlias()
		DbUseArea( .T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry,.T.,.F.)
		
		If (cAliasQry)->(!EoF())
			
			SF4->( dbSetOrder(1) )
			
			Do While (mv_par25 = 2 .Or. mv_par25 = 3) .And. (cAliasQry)->(!Eof())  	// Compras ou Ambos
				SD1->(DbGoTo((cAliasQry)->R_E_C_N_O_))
				
				// Verifica se a TES gera duplicata
				SF4->( MsSeek( xFilial("SF4") + SD1->D1_TES ) )
				
				SF1->(DbSeek( xFilial("SF1") + SD1->D1_DOC + SD1->D1_SERIE +	SD1->D1_FORNECE + SD1->D1_LOJA))
				
				nSomado  := nTotal := nPerc := nRateio := 0.00
				aRateios := {}
				lTemSDE	:= .F. // Se nao tiver rateio do produto, o total rateado sera 100% para o centro de custo
				// por item da NF
				
				// Posiciona rateio item no documento de entrada
				If SDE->( MsSeek( xFilial("SDE") + SD1->D1_DOC + SD1->D1_SERIE +	SD1->D1_FORNECE + SD1->D1_LOJA + SD1->D1_ITEM))
					If (mv_par25 = 3) .AND. SEZ->(DbSeek(xFilial("SDE",cFilAtu) + SE2->E2_PREFIXO + SE2->E2_NUM +SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE +SE2->E2_LOJA ))
						DbSkip()
					Endif
					lTemSDE := .T.
					While SDE->DE_FILIAL = xFilial("SDE")		.And.;
						SDE->DE_DOC = SD1->D1_DOC				.And.;
						SDE->DE_SERIE = SD1->D1_SERIE   		.And.;
						SDE->DE_FORNECE = SD1->D1_FORNECE 	.And.;
						SDE->DE_LOJA = SD1->D1_LOJA      	.And.;
						SDE->DE_ITEMNF = SD1->D1_ITEM    	.And.;
						! SDE->(Eof())
						
						cCc 	:= 	SDE->DE_CC
						cItem 	:= 	SDE->DE_ITEMCTA
						cClVl 	:= 	SDE->DE_CLVL
						If (cCC >= mv_par16 .And. cCc <= mv_par17) 		.And.;
							(cItem >= mv_par18 .And. cItem <= mv_par19) 	.And.;
							(cClVl >= mv_par20 .And. cClVl <= mv_par21)
							
							If (mv_par13 = 1 .And. ! Empty(cCc)) .Or.;
								(mv_par13 = 2 .And. ! Empty(cItem)) .Or.;
								(mv_par13 = 3 .And. ! Empty(cClVl)) .Or.;
								(mv_par13 = 4)
								
								nPerc 	+= SDE->DE_PERC
								nRateio	:= SDE->DE_CUSTO1
								nTotal	+= nRateio
								nSomado  += SDE->DE_CUSTO1
								
								If nPerc = 100 .And. nSomado <> nTotal
									nRateio += nTotal - nSomado
								Endif
								
								Aadd(aRateios, { cCc, cItem, cClVl, nRateio, (SF4->F4_DUPLIC == "S"),"" })
								cItemNF := SDE->DE_ITEMNF
								MsUnLock()
							Endif
							
						Endif
						
						SDE->(DbSkip())
						
					EndDo
				Else
					nTotal := SF1->F1_VALBRUT
					lTemSDE := .F.
					// Considera Rateio no Produto somente se deve considerar rateio previsto
					If mv_par31 == 1
						
						cCc   := SD1->D1_CC
						cItem := SD1->D1_ITEMCTA
						cClVl := SD1->D1_CLVL
						
						If (cCC >= mv_par16 .And. cCc <= mv_par17)	.And.;
							(cItem >= mv_par18 .And. cItem <= mv_par19) .And.;
							(cClVl >= mv_par20 .And. cClVl <= mv_par21)
							
							If	(mv_par13 == 1 .And. ! Empty(cCc)) .Or.;
								(mv_par13 == 2 .And. ! Empty(cItem)) .Or.;
								(mv_par13 == 3 .And. ! Empty(cClVl)) .Or.;
								(mv_par13 == 4)
								Aadd(aRateios, { cCc, cItem, cClVl, SD1->D1_TOTAL, (SF4->F4_DUPLIC == "S"),"" })
							EndIf
							
						EndIf
					EndIf
				Endif
				
				If Len(aRateios) = 0
					DbSelectArea(cAliasQry)
					DbSkip()
					Loop
				Endif
				
				// Ajusta valor total para fazer a proporcao do rateio corretamento quando existe filtro por cc/item/clvl.
				If lTemSDE .And. nTotal != SF1->F1_VALBRUT
					nTotal := SF1->F1_VALBRUT
				EndIf
				
				If mv_par26 = 1
					cFiltro := "E2_FILIAL >= '" + mv_par27 + "' .And. E2_FILIAL <= '" + mv_par28 + "'"
				Else
					cFiltro := "E2_FILIAL = '" + xFilial("SE2") + "'"
				Endif
				
				SE2->(DbSetOrder(6))
				SA2->(DbSetOrder(1))
				
				SE2->(DbSeek( xFilial("SE2") + SF1->F1_FORNECE + SF1->F1_LOJA + SF1->F1_PREFIXO + SF1->F1_DUPL))
				SED->(DbSeek( xFilial("SED") + SE2->E2_NATUREZ))
				SEV->(DbSeek( xFilial("SEV") + SF1->F1_PREFIXO + SF1->F1_DUPL + SE2->E2_NATUREZ))
				SA2->(DbSeek( xFilial("SA2") + SD1->D1_FORNECE + SD1->D1_LOJA ) )

				If SE2->E2_TIPO == MVNOTAFIS .And. 	SE2->E2_FORNECE + SE2->E2_LOJA = SF1->F1_FORNECE + SF1->F1_LOJA .And.;
					SE2->E2_EMISSAO >= mv_par07 .And. SE2->E2_EMISSAO <= mv_par08 .And.;
					SE2->E2_NATUREZ >= mv_par11 .And. SE2->E2_NATUREZ <= mv_par12
		
					Do While (SE2->( !EoF() .And. E2_FILIAL + E2_FORNECE + E2_LOJA + E2_PREFIXO + E2_NUM == xFilial("SE2") + SF1->( F1_FORNECE + F1_LOJA + F1_PREFIXO + F1_DUPL )))

						If SE2->E2_VENCREA >= mv_par09 .And. SE2->E2_VENCREA <= mv_par10
							//Verifica se tem registro de baixa no SE5
							SE5->(DbSeek(	xFilial("SE5") + SE2->E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA + SE2->E2_TIPO + SE2->E2_FORNECE + SE2->E2_LOJA))
							
							Do While mv_par22 = 2 .Or.;
								(SE5->(!EoF()) .And. SE5->(E5_FILIAL + E5_PREFIXO + E5_NUMERO + E5_PARCELA + E5_TIPO + E5_FORNECE + E5_LOJA) = xFilial("SE5") + SE2->(E2_PREFIXO + SE2->E2_NUM + SE2->E2_PARCELA + SE2->E2_TIPO + E2_FORNECE + E2_LOJA))
								
								If mv_par22 = 1
									
									If	! (SE5->E5_DATA >= mv_par09 .And. SE5->E5_DATA <= mv_par10) .Or.;
										! (SE5->E5_CLIFOR >= mv_par01 .And. SE5->E5_CLIFOR <= mv_par02)
										SE5->(dbSkip())
										Loop
									Endif
									
									IF SE5->E5_SITUACA == "C" .Or.;
										SE5->E5_TIPODOC $ "CH/DC/D2/JR/J2/TL/MT/M2/CM/C2"
										SE5->(dbSkip())
										Loop
									Endif
									
									If TemBxCanc(SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA+E5_SEQ))
										SE5->(DbSkip())
										Loop
									EndIf
									
								Endif
								nSomado := 0.00
								nARatear := 0

								For nRateios := 1 To Len(aRateios)
									
									CTT->(DbSeek(xFilial("CTT") + aRateios[nRateios][1]))
									CTD->(DbSeek(xFilial("CTD") + aRateios[nRateios][2]))
									CTH->(DbSeek(xFilial("CTH") + aRateios[nRateios][3]))
									
									// Se verdadeiro, deve checar a duplicada gerada para o rateio, caso contratio, nao faz a verificacao mas grava
									// os dados do rateio a partir do documento de entrada
									lTemDupl := aRateios[nRateios][5]
									
									If lTemDupl
										
										If mv_par29 == 1 //Quebra por Filial?
											lArqRat := cArqTmp->(DbSeek(SE2->E2_FILIAL+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+aRateios[nRateios][1]+ cItemNF))
										Else
											lArqRat := cArqTmp->(DbSeek(xFilial(cArqTmp)+SE2->E2_FORNECE+SE2->E2_LOJA+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+aRateios[nRateios][1]+ cItemNF))
										EndIf
									EndIf
									
									DbSelectArea("cArqTmp")
									RecLock("cArqTmp", !lArqRat)
									cArqTmp->NATUR		:= Iif( lTemDupl, SE2->E2_NATUREZ, "" )
									cArqTmp->DESCNAT	:= Iif( lTemDupl, SED->ED_DESCRIC, "" )
									
									// Centro de Custo
									cArqTmp->CC    		:= aRateios[nRateios][1]
									cArqTmp->DESCCC  	:= &("CTT->CTT_DESC" + StrZero(mv_par23,2))
									If Empty(cArqTmp->DESCCC)
										cArqTmp->DESCCC := CTT->CTT_DESC01
									Endif
									
									// Item Contabil
									cArqTmp->ITEM  		:= aRateios[nRateios][2]
									cArqTmp->DESCIT  	:= &("CTD->CTD_DESC" + StrZero(mv_par23,2))
									If Empty(cArqTmp->DESCIT)
										cArqTmp->DESCIT := CTD->CTD_DESC01
									Endif
									
									// Classe de Valor
									cArqTmp->CLVL  		:= aRateios[nRateios][3]
									cArqTmp->DESCCL  	:= &("CTH->CTH_DESC" + StrZero(mv_par23,2))
									If Empty(cArqTmp->DESCCL)
										cArqTmp->DESCCL := CTH->CTH_DESC01
									Endif
									
									If mv_par29 = 1
										cArqTmp->FILIAL	:= Iif( lTemDupl, SE2->E2_FILIAL, SD1->D1_FILIAL )
									Endif
									
									cArqTmp->PREFIXO	:= Iif( lTemDupl, SE2->E2_PREFIXO,SF1->F1_PREFIXO )
									cArqTmp->NUMERO		:= Iif( lTemDupl, SE2->E2_NUM,SD1->D1_DOC )
									cArqTmp->PARCELA	:= Iif( lTemDupl, SE2->E2_PARCELA, "" )
									cArqTmp->TIPO		:= Iif( lTemDupl, SE2->E2_TIPO, MVNOTAFIS )
									cArqTmp->FORNECE	:= Iif( lTemDupl, SE2->E2_FORNECE, SD1->D1_FORNECE )
									cArqTmp->LOJA		:= Iif( lTemDupl, SE2->E2_LOJA, SD1->D1_LOJA )
									cArqTmp->NOMFOR		:= Iif( lTemDupl, GetLGPDValue('SE2','E2_NOMFOR'), GetLGPDValue('SA2','A2_NREDUZ') )
									cArqTmp->EMISSAO	:= Iif( lTemDupl, SE2->E2_EMISSAO, SD1->D1_EMISSAO )
									cArqTmp->VENCIMENTO	:= Iif( lTemDupl, SE2->E2_VENCREA, CtoD("  /  /  ") )
									cArqTmp->ITEMNF 	:= cItemNF
									If mv_par22 = 1
										cArqTmp->RATEADO += xMoeda(Round(NoRound(SE5->E5_VALOR * (aRateios[nRateios, 4] / nTotal), 3), 2), SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
									Else
										cArqTmp->RATEADO += xMoeda(Round(NoRound(SE2->E2_SALDO * (aRateios[nRateios, 4] / nTotal), 3), 2), SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
									Endif
									// Verifica o total a ratear conforme o rateio efetuado, para efetuar o ajuste do rateio
									// e nao ocorrer diferencao de centavos.
									If lTemSDE
										nARatear := xMoeda(SE5->E5_VALOR, SE2->E2_MOEDA, mv_par23, SE2->E2_EMISSAO, nDecs + 1)
									Else
										nARatear	+= aRateios[nRateios, 4]
									Endif
									nSomado 	+= cArqTmp->RATEADO
									lNovoRat := .T.
								Next

								If mv_par22 = 2
									Exit
								Else
									lNovoRat		:= .F.
									SE5->(DbSkip())
								Endif
							EndDo
						EndIf
						SE2->(dbSkip())
					EndDo
				Endif
				DbSelectArea(cAliasQry)
				DbSkip()
			EndDo
			
		EndIf
		DbSelectArea(cAliasQry)
		DbCloseArea()
		dbSelectArea("SD1")
		//Se o SD1 for compartilhado, deve percorrer apenas uma vez.
		If !lExcSD1
			Exit
		Endif
	Next nI
Endif

For nX := 1 TO Len(aTmpFil)
	CtbTmpErase(aTmpFil[nX])   
Next

DbSelectArea("cArqTmp")
DbGoTop()
cCta   := ""
cCC		:= ""
cItem	:= ""
cClVl	:= ""
cNatur	:= ""
cFil195 := ""

While cArqTmp->(!Eof())
	
	If lEnd
		@PROW()+1,001 PSAY STR0008 //"CANCELADO PELO OPERADOR"
		Exit
	End
	
	If nLin > 58
		nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
		nLin ++
	End	

	If ! Empty(FILIAL) .And. cFil195 <> FILIAL
		SM0->(DbSeek(cArqTmp->FILIAL))
		FWArrFilAtu( cEmpAnt, cArqTmp->FILIAL )
		
		If nTotGeralF <> 0 .And. cFil195 <> "" .And. mv_par32 == 1
			If nLin > 58
				nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
			End
			nLin ++
			@ nLin,COL_PREFIXO 	PSAY STR0018 //"Total Filial"
			@ nLin ++,COL_RATEADO PSAY Trans(nTotGeralF, Tm(0, 14, 2))
			@ nLin ++,00 PSAY __PrtfatLine()
			nTotGeralF := 0
			nLin ++
		Endif
		
		If Len( aFil ) > 0
			@ nLin ++,00 PSay Padc(	AllTrim(RetTitle("E2_FILIAL")) + " - " + FILIAL +;
			" - " + AllTrim(aFil[6]), 80)
			@ nLin ++,00 PSAY __PrtfatLine()
		EndIf
	Endif
	If 	(mv_par13 = 1 .And. ! Empty(cCC) .And. CC <> cCC) .Or.;
		(mv_par13 = 2 .And. ! Empty(cItem) .And. ITEM <> cItem) .Or.;
		(mv_par13 = 3 .And. ! Empty(cClVl) .And. CLVL <> cClVl)
		nLin ++
	Endif
	
	If mv_par13 = 2 .And. mv_par24 = 1 .And. ITEM <> cItem
		@ nLin ++,00 PSay CTBSayDsc("CTD") + " - " + ITEM + " - " +;
		DESCIT
		@ nLin ++,00 PSAY __PrtfatLine()
	Endif
	
	If mv_par13 = 3 .And. mv_par24 = 1 .And. CLVL <> cClVl
		@ nLin ++,00 PSay CTBSayDsc("CTH") + " - " + CLVL + " - " +;
		DESCCL
		@ nLin ++,00 PSAY __PrtfatLine()
	Endif
	
	If mv_par24 = 1 .And. CC <> cCC .And. (mv_par13 = 1 .Or. mv_par14 = 2)
		@ nLin ++,00 PSay Alltrim(CTBSayDsc("CTT")) + " - " + Alltrim(MaskaraCtb(CC,,, "","CTT")) + " - " +;
		ALLTRIM(DESCCC)+IIF(!Empty(ALLTRIM(CTACONTB))," - "+Alltrim(GetSx3Cache("CT1_CONTA","X3_TITULO")) +" - " +Alltrim(CTACONTB),"")
		
		If mv_par13 = 1
			@ nLin ++,00 PSAY __PrtfatLine()
		Else
			@ nLin ++,00 PSAY Repl("-", nTamanho)
		Endif
	Endif
	
	If 	(mv_par24 = 1 .And. NATUR <> cNatur) .Or.;
		(mv_par24 = 1 .And. CC <> cCC .And. (mv_par13 = 1 .Or. mv_par14 = 2))
		@ nLin ++,COL_TITULO PSay STR0009 + MascNat(NATUR,,, "") + " - " +; //"Natureza - "
		DESCNAT
		@ nLin ++,00 PSAY Repl("-", nTamanho)
	Endif
	
	If mv_par24 = 1
		@ nLin,COL_PREFIXO 		PSAY PREFIXO
		@ nLin,COL_TITULO  		PSAY NUMERO
		@ nLin,COL_PARCELA 		PSAY PARCELA
		@ nLin,COL_TIPO    		PSAY TIPO
		@ nLin,COL_FORNECEDOR 	PSAY NOMFOR
		@ nLin,COL_EMISSAO    	PSAY EMISSAO
		@ nLin,COL_VENCIMENTO 	PSAY VENCIMENTO
		@ nLin ++,COL_RATEADO PSAY Trans(RATEADO, Tm(0, 14, 2))
	Endif
	
	cNatur	 	:= NATUR
	cCC       	:= CC
	cItem     	:= ITEM
	cClVl     	:= ITEM
	nTotNat	+= RATEADO
	nTotCC 	+= RATEADO
	nTotIT 	+= RATEADO
	nTotCL 	+= RATEADO
	nTotGeral	+= RATEADO
	nTotGeralF	+= RATEADO
	cDescNat	:= 	STR0009 + MascNat(NATUR,,, "") + " - " +; //"Natureza - "
	DESCNAT
	cDescCC		:= 	"Tot " + CTBSayDsc("CTT") + " - " +;
	MaskaraCtb(CC,,, "","CTT") + " - " + DESCCC
	cDescIt		:= 	"Tot " + CTBSayDsc("CTD") + " - " +;
	ITEM + " - " + DESCIT
	cDescCl		:= 	"Tot " + CTBSayDsc("CTH") + " - " +;
	CLVL + " - " + DESCCL
	
	DbSelectArea("cArqTmp")
	cFil195 := FILIAL
	DbSkip()
	
	lTraco := mv_par24 = 1

	If NATUR <> cNatur .Or. If(mv_par13 = 1, CC <> cCC,If(mv_par13 = 2, ITEM <> cItem .Or. CC <> cCC,CLVL <> cClVl .Or. ITEM <> cItem .Or. CC <> cCC))
		If lTraco
			@ nLin ++,00 PSAY Repl("-", nTamanho)
			lTraco := .F.
		Endif
		If mv_par24 = 1
			@ nLin,COL_TITULO 	PSAY STR0010 + MascNat(cNatur,,, "") //"Total da Natureza - "
		Else
			@ nLin,COL_TITULO PSay cDescNat
		Endif
		@ nLin ++,COL_RATEADO PSAY Trans(nTotNat, Tm(0, 14, 2))
		@ nLin ++,00 PSAY Repl("-", nTamanho)
		nTotNat := 0.00
	Endif

	If CC <> cCC .And. (mv_par13 = 1 .Or. mv_par14 = 2)
		If lTraco
			If mv_par13 = 1
				@ nLin ++,00 PSAY __PrtfatLine()
			Else
				@ nLin ++,00 PSAY Repl("-", nTamanho)
			Endif
		Endif
		If nLin > 58
			nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
			nLin ++
		End
		
		If mv_par24 = 1
			@ nLin,COL_PREFIXO 	PSAY STR0011 + CTBSayDsc("CTT") + " - " +; //"Total "
			MaskaraCtb(cCC,,, "","CTT")
		Else
			@ nLin,00 PSay cDescCC
		Endif
		@ nLin ++,COL_RATEADO PSAY Trans(nTotCc, Tm(0, 14, 2))
		If mv_par13 = 1
			@ nLin ++,00 PSAY __PrtfatLine()
		Else
			@ nLin ++,00 PSAY Repl("-", nTamanho)
		Endif
		nTotCC := 0.00
		If mv_par15 = 1 .And. mv_par13 = 1
			nLin := 60
		Endif
	Endif
	
	If ITEM <> cItem .And. (mv_par13 = 2 .Or. (mv_par14 = 2 .And. mv_par13 = 3))
		If lTraco
			If mv_par13 = 1
				@ nLin ++,00 PSAY __PrtfatLine()
			Else
				@ nLin ++,00 PSAY Repl("-", nTamanho)
			Endif
		Endif
		If nLin > 58
			nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
			nLin ++
		End
		
		If mv_par24 = 1
			@ nLin,COL_PREFIXO 	PSAY STR0011 + CTBSayDsc("CTD") + " - " + cItem //"Total "
		Else
			@ nLin,00 PSay cDescIt
		Endif
		@ nLin ++,COL_RATEADO PSAY Trans(nTotIt, Tm(0, 14, 2))
		If mv_par13 = 2
			@ nLin ++,00 PSAY __PrtfatLine()
		Else
			@ nLin ++,00 PSAY Repl("-", nTamanho)
		Endif
		nTotIt := 0.00
		If mv_par15 = 1 .And. mv_par13 = 2
			nLin := 60
		Endif
	Endif
	
	If CLVL <> cClVl .And. mv_par13 = 3
		If lTraco
			@ nLin ++,00 PSAY __PrtfatLine()
		Endif
		If nLin > 58
			nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
			nLin ++
		End
		
		If mv_par24 = 1
			@ nLin,COL_PREFIXO 	PSAY STR0011 + CTBSayDsc("CTH") + " - " + cClVl //"Total "
		Else
			@ nLin,00 PSay cDescCl
		Endif
		@ nLin ++,COL_RATEADO PSAY Trans(nTotCl, Tm(0, 14, 2))
		@ nLin ++,00 PSAY __PrtfatLine()
		nTotCl := 0.00
		If mv_par15 = 1 .And. mv_par13 = 3
			nLin := 60
		Endif
	Endif
EndDo


If nTotGeral <> 0
	If nTotGeralF <> 0 .And. mv_par32 == 1
		If nLin > 58
			nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
		End
		nLin ++
		@ nLin,COL_PREFIXO 	PSAY STR0018 //"Total Filial"
		@ nLin ++,COL_RATEADO PSAY Trans(nTotGeralF, Tm(0, 14, 2))
		@ nLin ++,00 PSAY __PrtfatLine()
		nTotGeralF := 0
		nLin ++
	Endif
	If nLin > 58
		nLin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTamanho)
	End
	nLin ++
	@ nLin,COL_PREFIXO 	PSAY STR0012 //"Total Geral"
	@ nLin ++,COL_RATEADO PSAY Trans(nTotGeral, Tm(0, 14, 2))
	@ nLin ++,00 PSAY __PrtfatLine()
	nLin ++
Endif
       
If nLin != 80 .And. nLin < 59
	Roda(cbcont,cbtxt,Tamanho)
End

If(_oFINR195 <> NIL)

	_oFINR195:Delete()
	_oFINR195 := NIL

EndIf

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	Ourspool(wnrel)
End

MS_FLUSH()

Return .T.


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
	Local aArea			:= SM0->( GetArea() )
	Local aAux			:= {}
	Local aRetSM0		:= {}
	Local lFWLoadSM0	:= .T.
	Local lFWCodFilSM0 	:= .T.

	If lFWLoadSM0
		aRetSM0	:= FWLoadSM0()
	Else
		DbSelectArea( "SM0" )
		SM0->( DbGoTop() )
		While SM0->( !Eof() )
			aAux := { 	SM0->M0_CODIGO,;
						IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
						"",;
						"",;
						"",;
						SM0->M0_NOME,;
						SM0->M0_FILIAL }

			aAdd( aRetSM0, aClone( aAux ) )
			SM0->( DbSkip() )
		End
	EndIf

	RestArea( aArea )
Return aRetSM0

//-------------------------------------------------------------------
/*/{Protheus.doc} function MaskaraCtb
Criar um cache em mem¢ria est tica para evitar acesso constante a um mesmo registro.
@author  norbertom
@since   05/12/2017
@version P12
/*/
//-------------------------------------------------------------------
Static Function MaskaraCtb(cCodigo as char,cMascara as char,nTamanho as numeric,cSeparador as char,cAlias as char) as char
Local nPos as Numeric
Local cRet as Char

DEFAULT cCodigo		:= ''
DEFAULT cAlias		:= ''

nPos := ASCAN(aMasksCTB,{|e| e[1]==cCodigo .and. e[2] == cMascara .and. e[3] == STR(nTamanho) .and. e[4] == cSeparador .and. e[5] == cAlias})

If EMPTY(nPos)
	cRet := MascaraCtb(cCodigo,@cMascara,@nTamanho,@cSeparador,cAlias)
	AADD(aMasksCTB,{cCodigo,cMascara,STR(nTamanho),cSeparador,cAlias,cRet})
Else
	cRet := aMasksCTB[nPos,6]
EndIf

RETURN cRet

//-------------------------------------------------------------------
/*/{Protheus.doc} function CTBSayDsc
Criar um cache em mem¢ria est tica para evitar acesso constante a um mesmo registro.
@author  norbertom
@since   05/12/2017
@version P12
/*/
//-------------------------------------------------------------------
Static Function CTBSayDsc(cAliasTab as Char) as Char
Local nPos as Numeric
Local cRet as Char

DEFAULT cAliasTab	:= ''

nPos := ASCAN(aDscEntCTB,{|e| e[1]==cAliasTab})

If EMPTY(nPos)
	cRet := CTBSayApro(cAliasTab)
	AADD(aDscEntCTB,{cAliasTab,cRet})
Else
	cRet := aDscEntCTB[nPos,2]
EndIf

RETURN cRet


