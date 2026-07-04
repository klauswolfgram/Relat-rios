/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "matr462.ch"
#INCLUDE "Protheus.Ch"
#define TT	Chr(254)+Chr(254)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ MATR462  ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 02.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorios Produtos Controlados DECRETO 3665               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR462()
Local wnrel
Local titulo	:=STR0001 //"Mapas de Produtos Controlados"
Local cDesc1	:=STR0002 //"Emiss„o dos mapas civil de compra, venda e mapa do Exercito"
Local cDesc2	:=STR0003 //"de produtos controlados"
Local cDesc3	:=""
Local cString	:="SB1"
Local cNomeProg	:="MATR462"
Local Tamanho	:="G"
Local cPerg		:="MTR462"
Private aReturn	:={STR0004,1,STR0005,2,2,1,"",1} //"Zebrado"###"Administracao"
Private nLastKey:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,cNomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey==27
	Return .T.
Endif
SetDefault(aReturn,cString)
If nLastKey==27
	Return .T.
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // De  Produto                                  ³
//³ mv_par02     // Ate Produto                                  ³
//³ mv_par03     // De  Armazem                                  ³
//³ mv_par04     // Ate Armazem                                  ³
//³ mv_par05     // De  Grupo                                    ³
//³ mv_par06     // Ate Grupo                                    ³
//³ mv_par07     // De  Tipo                                     ³
//³ mv_par08     // Ate Tipo                                     ³
//³ mv_par09     // Trimestre                                    ³
//³ mv_par10     // Imprime Mapa Civil Compra  1 - Sim 2 - Nao   ³
//³ mv_par11     // Imprime Mapa Civil Venda   1 - Sim 2 - Nao   ³
//³ mv_par12     // Imprime Mapa Exercito      1 - Sim 2 - Nao   ³
//³ mv_par13     // Informe a RM		       (Regiao Militar)  ³
//³ mv_par14     // Informe o CR		       (Certif.Registro) ³
//³ mv_par15     // CR Valido ate'                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

If mv_par10 == 1 .Or. mv_par11 == 1 .Or. mv_par12 == 1
	RptStatus({|lEnd| R462Imp(@lEnd,wnRel,cString,Tamanho)},titulo)
Endif

If aReturn[5]==1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return (NIL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R462Imp  ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 02.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Variavel p/ controle de interrupcao pelo usuario   ³±±
±±³          ³ ExpC1 = Codigo do relatorio                                ³±±
±±³          ³ ExpC2 = Alias do arquivo                                   ³±±
±±³          ³ ExpC3 = Tamanho do relatorio			                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R462Imp(lEnd,wnRel,cString,Tamanho)
Local aArqTemp	:={}
Local aTam    	:={}
Local dDataIni	:=dDataBase
Local dDataFim	:=dDataBase
Local aMes		:={1,4,7,10} // Meses que iniciam trimestre
Local aMesOrd	:={STR0006,STR0007,STR0008,STR0009} // Ordinal dos trimestres //"PRIMEIRO"###"SEGUNDO"###"TERCEIRO"###"QUARTO"
Local lFirst 	:= .T.
Local nLinMax	:=0
Local aSaldo	:={}
Local nSaldoIni	:=0
Local nTamCPro	:=TamSX3("B1_COD")[1]
Local nTamForn	:=TamSX3("D1_FORNECE")[1]
Local oTmpTable	:= NIL
Local oTmpTable1	:= NIL
Local oTmpTable2	:= NIL

Local cCpoB5	:= GetNewPar("MV_MTR949A","")	//Produto Controlado 
Local cCpo2B5	:= GetNewPar("MV_MTR949D","")	//Descricao do Produto da tabela SB5

Local lBuscaSB5 := .F.
Local nChkSB5   := Nil
Local nDescSB5  := Nil
Local cDescrPro := Nil

Local nTamChavF1 := TamSX3("F1_FILIAL")[1]+TamSX3("F1_SERIE")[1]

If (! Empty(cCpoB5)) .And. (! Empty(cCpo2B5))
	nChkSB5  := SB5->(FieldPos(cCpoB5))
	nDescSB5 := SB5->(FieldPos(cCpo2B5))
	If nChkSB5 > 0 .And. nDescSB5 > 0
		lBuscaSB5 := .T.
	Endif
Endif	

// Calculo da data inicial e final
dDataIni := CTOD("01/"+Str(aMes[mv_par09],2,0)+"/"+Str(Year(dDataBase),4,0),"ddmmyyyy")
dDataFim := LastDay(CTOD("01/"+Str(aMes[mv_par09]+2,2,0)+"/"+Str(Year(dDataBase),4,0),"ddmmyyyy"))

// Montagem dos arquivos de trabalhos
// TOTCOM - Totalizador do mapa de compras
AADD(aArqTemp,{"PRODUTO"	,"C",nTamCPro,0})
aTam:=TamSX3("B1_DESC")
AADD(aArqTemp,{"DESCRIPRO"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("B2_QFIM")
AADD(aArqTemp,{"SALDOANT"	,"N",16,aTam[2]})
AADD(aArqTemp,{"COMPRAS"	,"N",16,aTam[2]})
AADD(aArqTemp,{"VENDAS"  	,"N",16,aTam[2]})
AADD(aArqTemp,{"CONSUMO" 	,"N",16,aTam[2]})
AADD(aArqTemp,{"ESTOQFIM"	,"N",16,aTam[2]})
aTam:=TamSX3("B1_UM")
AADD(aArqTemp,{"UM"			,"C",aTam[1],aTam[2]})
aTam:=TamSX3("B1_SEGUM")
AADD(aArqTemp,{"SEGUM" 		,"C",aTam[1],aTam[2]})

oTmpTable := FWTemporaryTable():New( "TOTCOM" )
oTmpTable:SetFields( aArqTemp )
oTmpTable:AddIndex("indice1", {"PRODUTO"} )
oTmpTable:Create()

// ITECOM - Item do mapa de compras
aArqTemp :={}
aTam:=TamSX3("B1_DESC")
AADD(aArqTemp,{"DESCRIPRO"	,"C",aTam[1],aTam[2]})
AADD(aArqTemp,{"DTDIGIT"	,"D",8,0})
aTam:=TamSX3("D1_FORNECE")
nTamChavF1 += aTam[1]
AADD(aArqTemp,{"FORNECEDOR"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D1_LOJA")
nTamChavF1+= aTam[1]
AADD(aArqTemp,{"LOJA"		,"C"  ,aTam[1],aTam[2]})
aTam:=TamSX3("A2_NOME")
AADD(aArqTemp,{"DESCRIFOR"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A2_END")
AADD(aArqTemp,{"ADRESS"  	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A2_CEP")
AADD(aArqTemp,{"CEP"       	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A2_MUN")
AADD(aArqTemp,{"MUNICIPIO" 	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A2_EST")
AADD(aArqTemp,{"UF"			,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D1_DOC")
nTamChavF1+=aTam[1]
AADD(aArqTemp,{"DOCUMENTO" ,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D1_QUANT")
AADD(aArqTemp,{"QUANTIDADE","N",16,aTam[2]})
aTam:=TamSX3("D1_COD")
AADD(aArqTemp,{"PRODUTO"   ,"C",aTam[1],aTam[2]})
AADD(aArqTemp,{"IDENTUF"   ,"C",1,0})

oTmpTable1 := FWTemporaryTable():New( "ITECOM" )
oTmpTable1:SetFields( aArqTemp )
oTmpTable1:AddIndex("indice1", {"PRODUTO","DTDIGIT","FORNECEDOR"} )
oTmpTable1:AddIndex("indice2", {"IDENTUF","PRODUTO","DTDIGIT","FORNECEDOR"} )
oTmpTable1:Create()

// ITEVEN - Item do mapa de vendas
aArqTemp :={}
aTam:=TamSX3("B1_DESC")
AADD(aArqTemp,{"DESCRIPRO"	,"C",aTam[1],aTam[2]})
AADD(aArqTemp,{"EMISSAO"	,"D",8,0})
aTam:=TamSX3("D2_CLIENTE")
AADD(aArqTemp,{"CLIENTE"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D2_LOJA")
AADD(aArqTemp,{"LOJA"		,"C"  ,aTam[1],aTam[2]})
aTam:=TamSX3("A1_NOME")
AADD(aArqTemp,{"DESCRICLI"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A1_END")
AADD(aArqTemp,{"ADRESS"  	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A1_CEP")
AADD(aArqTemp,{"CEP"		,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A1_MUN")
AADD(aArqTemp,{"MUNICIPIO"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("A1_EST")
AADD(aArqTemp,{"UF"			,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D2_DOC")
AADD(aArqTemp,{"DOCUMENTO"	,"C",aTam[1],aTam[2]})
aTam:=TamSX3("D2_QUANT")
AADD(aArqTemp,{"QUANTIDADE"	,"N",16,aTam[2]})
aTam:=TamSX3("D2_COD")
AADD(aArqTemp,{"PRODUTO"	,"C",aTam[1],aTam[2]})

oTmpTable2 := FWTemporaryTable():New( "ITEVEN" )
oTmpTable2:SetFields( aArqTemp )
oTmpTable2:AddIndex("indice1", {"PRODUTO","EMISSAO","CLIENTE"}  )
oTmpTable2:Create()

// Alimenta arquivos de trabalho com dados
dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial("SB1")+mv_par01,.T.)
SetRegua(LastRec())
While !lEnd .and. !eof() .And. xFilial("SB1") == B1_FILIAL .And. B1_COD <= mv_par02
	IncRegua()
	// Filtra Grupo	
	If B1_GRUPO < mv_par05 .Or. B1_GRUPO > mv_par06
		dbSkip()
		Loop	
	EndIf
	// Filtra Tipo
	If B1_TIPO < mv_par07 .Or. B1_TIPO > mv_par08
		dbSkip()
		Loop	
	EndIf                                                    	

	cDescrPro := SB1->B1_DESC

	If lBuscaSB5
		SB5->(dbSeek(xFilial("SB5") + SB1->B1_COD))
		If mv_par16 == 2 .And. (SB5->(Eof()) .Or. (! SB5->(FieldGet(nChkSB5)) == "S"))
			dbSkip()
			Loop
		Endif	

		If Empty(cDescrPro := SB5->(FieldGet(nDescSB5)))
			cDescrPro := SB1->B1_DESC				
		Endif
	Endif		
	
	If Interrupcao(@lEnd)
		Exit
	Endif
	// TOTCOM - Totalizador do mapa de compras - 
	// INDICE -> PRODUTO
	// "PRODUTO" 
	// "SALDOANT" 
	// "COMPRAS"  
	// "VENDAS"   
	// "CONSUMO"  
	// "ESTOQFIM"
	If mv_par10 == 1 .Or. mv_par12 == 1
		dbSelectArea("TOTCOM")
		If !dbSeek(SB1->B1_COD)
	    	dbSelectArea("SB2")
    		dbSetOrder(1)
    		MsSeek(xFilial("SB2")+SB1->B1_COD+mv_par03,.T.)
			nSaldoIni:=0
	    	While !EOF() .And. B2_FILIAL+B2_COD == xFilial("SB2")+SB1->B1_COD .And. B2_LOCAL <= mv_par04
				aSaldo:=CalcEst(SB2->B2_COD,SB2->B2_LOCAL,dDataIni)
    			nSaldoIni+=	aSaldo[1]
				dbSkip()
	    	End
			Reclock("TOTCOM",.T.)
			Replace PRODUTO   With SB1->B1_COD
			Replace DESCRIPRO With cDescrPro
			Replace UM        With SB1->B1_UM
			Replace SEGUM     With SB1->B1_SEGUM
			Replace SALDOANT  With nSaldoIni
			Replace ESTOQFIM  With nSaldoIni
			MsUnlock()
		EndIf	
	EndIf	
	// Carrega informacoes para o Mapa de Compras
	If mv_par10 == 1 .Or. mv_par12 == 1
		dbSelectArea("SD1")
		dbSetOrder(7)
		dbSeek(xFilial("SD1")+SB1->B1_COD+mv_par03+DTOS(dDataIni),.T.)
		While !Eof() .And. D1_FILIAL+D1_COD == xFilial("SD1")+SB1->B1_COD .And. D1_LOCAL <= mv_par04 .And. DTOS(D1_DTDIGIT) <= DTOS(dDataFim)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data e valida         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If DTOS(D1_DTDIGIT) < DTOS(dDataIni)
				dbSkip()
				Loop			
			EndIf
			If !Empty(D1_OP)
				SC2->(dbSetOrder(1))
				SC2->(MsSeek(xFilial("SC2")+SD1->D1_OP))
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o TES atualiza estoque  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SF4")
			dbSeek(xFilial("SF4")+SD1->D1_TES)
			dbSelectArea("SD1")
			//-- 							Filtro para não listar os retornos simbólicos de remessa para industrialização
			If SF4->F4_ESTOQUE != "S" .Or. (!Empty(D1_OP) .And. SF4->F4_PODER3 == "D" .And. SC2->C2_TPPR == "E")
				dbSkip()
				Loop
			EndIf
			A462GrTrb("SD1",D1_COD,D1_QUANT,D1_DTDIGIT,D1_FORNECE,D1_LOJA,D1_TIPO,D1_DOC,dDataIni,cDescrPro)
			dbSelectArea("SD1")
			dbSkip()
		End
		dbSelectArea("SD3")
		dbSetOrder(7)
		dbSeek(xFilial("SD3")+SB1->B1_COD+mv_par03+DTOS(dDataIni),.T.)
		While !Eof() .And. D3_FILIAL+D3_COD == xFilial("SD3")+SB1->B1_COD .And. D3_LOCAL <= mv_par04 .And. DTOS(D3_EMISSAO) <= DTOS(dDataFim)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data e valida         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If DTOS(D3_EMISSAO) < DTOS(dDataIni)
				dbSkip()
				Loop
			EndIf
			If !Empty(D3_OP)
				SC2->(dbSetOrder(1))
				SC2->(MsSeek(xFilial("SC2")+SD3->D3_OP))
				//-- Não lista movimentos de produção externa
				If SC2->C2_TPPR == 'E' .And. Empty(D3_CHAVEF1) .And. !("SV" $ D3_TIPO)
					dbSkip()
					Loop
				EndIf
			EndIf

			If !Empty(D3_CHAVEF1)
				SF1->(dbSetOrder(1))
				SF1->(MsSeek(PadR(SD3->D3_CHAVEF1,nTamChavF1)))
				//-- Lista produção externa (beneficiamento) como entrada por nota (aquisição do serviço de beneficiamento)
				A462GrTrb("SD1",D3_COD,D3_QUANT,D3_EMISSAO,SF1->F1_FORNECE,SF1->F1_LOJA,SF1->F1_TIPO,SF1->F1_DOC,dDataIni,cDescrPro)
			Else
				A462GrTrb("SD3",D3_COD,D3_QUANT*If(D3_TM <= "500",-1,1),D3_EMISSAO,NIL,NIL,NIL,D3_DOC,dDataIni,cDescrPro)
			EndIf
			dbSelectArea("SD3")
			dbSkip()
		End
	EndIf	
	// Carrega informacoes para o Mapa de Compras e/ou Mapa de Vendas e/ou Mapa do Exercito
	If mv_par10 == 1 .Or. mv_par11 == 1 .Or. mv_par12 == 1
		dbSelectArea("SD2")
		dbSetOrder(6)
		dbSeek(xFilial("SD2")+SB1->B1_COD+mv_par03+DTOS(dDataIni),.T.)
		While !Eof() .And. D2_FILIAL+D2_COD == xFilial("SD2")+SB1->B1_COD .And. D2_LOCAL <= mv_par04 .And. DTOS(D2_EMISSAO) <= DTOS(dDataFim)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a data e valida         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If DTOS(D2_EMISSAO) < DTOS(dDataIni)
				dbSkip()
				Loop			
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se o TES atualiza estoque  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SF4")
			dbSeek(xFilial("SF4")+SD2->D2_TES)
			dbSelectArea("SD2")
			If SF4->F4_ESTOQUE != "S"
				dbSkip()
				Loop
			EndIf
			A462GrTrb("SD2",D2_COD,D2_QUANT,D2_EMISSAO,D2_CLIENTE,D2_LOJA,D2_TIPO,D2_DOC,dDataIni,cDescrPro)
			dbSelectArea("SD2")
			dbSkip()
		End
	EndIf
	dbSelectArea("SB1")
	dbSkip()
End

// Imprime relatorios
nLin   :=80
nLinMax:=45
If mv_par10 == 1
	// Carrega Layout	
	aL:=R462LCom()
	// Imprime Capa
    dbSelectArea("TOTCOM")
    dbGotop()
    While !Eof()
		If nLin > 60
			R462Cabec(@nLin,1,aMesOrd,aL)		
		EndIf
		FmtLin({PRODUTO,Substr(DESCRIPRO,1,29),SALDOANT,COMPRAS,VENDAS,CONSUMO,ESTOQFIM},aL[17],,,@nLin)
		dbSkip()
		If (Eof() .And. nLin <= nLinMax) .Or. nLin > nLinMax
			While nLin <= nLinMax
				FmtLin(,aL[18],,,@nLin)			   
			End		
			R462Cabec(@nLin,2,aMesOrd,aL)		
		EndIf
    End
    // Imprime interior
	nLinMax:=50
    dbSelectArea("ITECOM")
    dbSetOrder(1)
    dbGotop()
    While !Eof()
		If nLin > 60
			R462Cabec(@nLin,3,aMesOrd,aL)		
		EndIf
		FmtLin({DTDIGIT,FORNECEDOR,LOJA,Substr(DESCRIFOR,1,If(nTamForn>8 .And. nTamCPro >15, 17,28)),Substr(ADRESS,1,41),CEP,Substr(MUNICIPIO,1,15),UF,DOCUMENTO,QUANTIDADE,PRODUTO,Substr(DESCRIPRO,1,27)},aL[37],,,@nLin)
		dbSkip()
		If (Eof() .And. nLin <= nLinMax) .Or. nLin > nLinMax
			While nLin <= nLinMax
				FmtLin(,aL[39],,,@nLin)			   
			End		
			R462Cabec(@nLin,4,aMesOrd,aL)		
		EndIf
    End
EndIf

If mv_par11 == 1
	nlinMax:=45
	// Carrega Layout	
	aL:=R462LVen()
	// Imprime interior
    dbSelectArea("ITEVEN")
    dbGotop()
    While !Eof()
		If nLin > 60
			R462Cabec(@nLin,If(lFirst,5,6),aMesOrd,aL)		
		EndIf
		FmtLin({EMISSAO,CLIENTE,LOJA,Substr(DESCRICLI,1,If(nTamForn>8 .And. nTamCPro >15, 17,28)),Substr(ADRESS,1,41),CEP,Substr(MUNICIPIO,1,15),UF,DOCUMENTO,QUANTIDADE,PRODUTO,Substr(DESCRIPRO,1,27)},aL[17],,,@nLin)
		dbSkip()
		If (Eof() .And. nLin <= nLinMax) .Or. nLin > nLinMax
			While nLin <= 50
				FmtLin(,aL[18],,,@nLin)			   
			End		
			R462Cabec(@nLin,If(lFirst,7,8),aMesOrd,aL)		
			If lFirst
				lFirst:=.F.			
				nLinMax:=50
			EndIf
		EndIf
    End
EndIf

If mv_par12 == 1
	lFirst:=.T.
	nlinMax:=45
	// Carrega Layout	
	aL:=R462LExe()
	// Imprime Capa
    dbSelectArea("TOTCOM")
    dbGotop()
    While !Eof()
		If nLin > 60
			R462Cabec(@nLin,If(lFirst,9,11),aMesOrd,aL)		
		EndIf
		FmtLin({PRODUTO,Substr(DESCRIPRO,1,29),SALDOANT,COMPRAS,SALDOANT+COMPRAS,CONSUMO,VENDAS,ESTOQFIM,If(UM=="KG",ESTOQFIM,If(SEGUM=="KG",ConvUm(PRODUTO,ESTOQFIM,0,2),0))},aL[16],,,@nLin)
		dbSkip()
		If (Eof() .And. nLin <= nLinMax) .Or. nLin > nLinMax
			While nLin <= nLinMax
				FmtLin(,aL[17],,,@nLin)			   
			End		
			//linha para fechar
			FmtLin(,aL[18],,,@nLin)
			If !Eof()
				R462Cabec(@nLin,If(lFirst,10,11),aMesOrd,aL)		
			EndIf
			If lFirst
				lFirst:=.F.			
				nLinMax:=55
			EndIf
		EndIf
    End
	nLinMax:=60
    // Imprime DETALHE SP
	R462Cabec(@nLin,12,aMesOrd,aL)		
    dbSelectArea("ITECOM")
    dbSetOrder(2)
    dbSeek("1")
    While !Eof() .And. IDENTUF == "1"
		If nLin > nLinMax
			R462Cabec(@nLin,12,aMesOrd,aL)		
		EndIf
		FmtLin({DTDIGIT,FORNECEDOR,LOJA,Substr(DESCRIFOR,1,If(nTamForn>8 .And. nTamCPro >15, 17,28)),Substr(ADRESS,1,41),Substr(MUNICIPIO,1,15),UF,"",DOCUMENTO,QUANTIDADE,PRODUTO,Substr(DESCRIPRO,1,27)},aL[25],,,@nLin)
		dbSkip()
    End                                     
    // Imprime DETALHE OUTROS ESTADOS
	R462Cabec(@nLin,13,aMesOrd,aL)		
    dbSelectArea("ITECOM")
    dbSetOrder(2)
    dbSeek("2")
    While !Eof() .And. IDENTUF == "2"
		If nLin > nLinMax
			R462Cabec(@nLin,14,aMesOrd,aL)		
		EndIf
		FmtLin({DTDIGIT,FORNECEDOR,LOJA,Substr(DESCRIFOR,1,If(nTamForn>8 .And. nTamCPro >15, 17,28)),Substr(ADRESS,1,41),Substr(MUNICIPIO,1,15),UF,"",DOCUMENTO,QUANTIDADE,PRODUTO,Substr(DESCRIPRO,1,27)},aL[25],,,@nLin)
		dbSkip()
    End
	While nLin < nLinMax
		FmtLin(,aL[39],,,@nLin)			   
	End		
	FmtLin(,aL[20],,,@nLin)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga Arquivos Temporarios                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTmpTable:Delete()
oTmpTable1:Delete()
oTmpTable2:Delete()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³A462GrTrb ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 04/08/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao que grava os arquivos de trabalho utilizados na     ³±±
±±³          ³ impressao do relatorio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³A462GrTrb(ExpC1,ExpC2,ExpN1,ExpD1,ExpC3,ExpC4,ExpC5,ExpC6,  ³±±
±±³			 ³		    ExpD2,ExpC7)									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Arquivo origem das informacoes                     ³±±
±±³          ³ ExpC2 = Codigo do produto do movimento               	  ³±±
±±³          ³ ExpN1 = Quantidade do movimento                            ³±±
±±³          ³ ExpD1 = Data do movimento                                  ³±±
±±³          ³ ExpC3 = Codigo do cliente / fornecedor do movimento    	  ³±±
±±³          ³ ExpC4 = Loja  do cliente / fornecedor do movimento  		  ³±±
±±³          ³ ExpC5 = Tipo do documento do movimento               	  ³±±
±±³          ³ ExpC6 = Documento do movimento                   	      ³±±
±±³          ³ ExpD2 = Data inicio do processamento         	          ³±±
±±³          ³ ExpC7 = Descricao do produto do movimento 	              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A462GrTrb(cAlias,cProduto,nQuant,dData,cCliFor,cLoja,cTipoDoc,cDoc,dDataIni,cDescri)
LOCAL cEnder:=""
LOCAL cCep:=""
LOCAL cMun:=""
LOCAL cUF:=""
LOCAL cDescriCli:=""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona registros                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Valtype(cCliFor) == "C" .And. !Empty(cCliFor)
	If (cTipoDoc$"DB" .And. cAlias == "SD1") .Or. (!(cTipoDoc$"DB") .And. cAlias == "SD2")
		dbSelectArea("SA1")
		dbSetOrder(1)
		If MsSeek(xFilial("SA1")+cCliFor+cLoja)
			cEnder    :=SA1->A1_END
			cCep      :=SA1->A1_CEP
			cMun      :=SA1->A1_MUN
			cUF       :=SA1->A1_EST
			cDescriCli:=SA1->A1_NOME
		EndIf	
	Else
		dbSelectArea("SA2")
		dbSetOrder(1)
		If MsSeek(xFilial("SA2")+cCliFor+cLoja)
			cEnder    :=SA2->A2_END
			cCep      :=SA2->A2_CEP
			cMun      :=SA2->A2_MUN
			cUF       :=SA2->A2_EST
			cDescriCli:=SA2->A2_NOME
		EndIf	
	EndIf
EndIf	

// ITECOM - Item do mapa de compras
// INDICE -> DTOS(DTDIGIT)+FORNECEDOR+PRODUTO
// "DTDIGIT"
// "FORNECEDOR"
// "LOJA"
// "ADRESS"
// "CEP"      
// "MUNICIPIO" 
// "UF" 
// "DOCUMENTO" 
// "QUANTIDADE"
// "PRODUTO"   
If (mv_par10 == 1 .Or. mv_par12 == 1) .And. cAlias $ "SD1/SD3"
	If cAlias == "SD1"
		// Grava item
		Reclock("ITECOM",.T.)
		Replace DTDIGIT    With dData
		Replace FORNECEDOR With cCliFor
		Replace LOJA       With cLoja
		Replace DESCRIFOR  With cDescriCli
		Replace ADRESS     With Substr(cEnder,1,Len(ITECOM->ADRESS))
		Replace CEP        With cCep
		Replace MUNICIPIO  With Substr(cMun,1,Len(ITECOM->MUNICIPIO))
		Replace UF         With cUF
		Replace DOCUMENTO  With cDoc
		Replace QUANTIDADE With nQuant
		Replace PRODUTO    With cProduto
		Replace DESCRIPRO  With cDescri
		Replace IDENTUF    With If(cUF=="SP","1","2")
		MsUnlock()
		// Grava totalizador
		Reclock("TOTCOM",.F.)
		Replace COMPRAS   With COMPRAS+nQuant
		Replace ESTOQFIM  With ESTOQFIM+nQuant
		MsUnlock()
	Else
		// Grava totalizador
		Reclock("TOTCOM",.F.)
		Replace CONSUMO   With CONSUMO+nQuant
		Replace ESTOQFIM  With ESTOQFIM+(nQuant*-1)
		MsUnlock()
	EndIf
EndIf

// ITEVEN - Item do mapa de vendas
// INDICE -> DTOS(EMISSAO)+CLIENTE+PRODUTO
// "EMISSAO"
// "CLIENTE"
// "LOJA"
// "ADRESS"
// "CEP"      
// "MUNICIPIO" 
// "UF"
// "DOCUMENTO" 
// "QUANTIDADE"
// "PRODUTO"   
If (mv_par10 ==1 .Or. mv_par11 == 1 .Or. mv_par12 == 1) .And. cAlias == "SD2"
	// Grava item
	Reclock("ITEVEN",.T.)
	Replace EMISSAO    With dData
	Replace CLIENTE    With cCliFor
	Replace LOJA       With cLoja
	Replace DESCRICLI  With cDescriCli
	Replace ADRESS     With Substr(cEnder,1,Len(ITEVEN->ADRESS))
	Replace CEP        With cCep
	Replace MUNICIPIO  With Substr(cMun,1,Len(ITEVEN->MUNICIPIO))
	Replace UF         With cUF
	Replace DOCUMENTO  With cDoc
	Replace QUANTIDADE With nQuant
	Replace PRODUTO    With cProduto
	Replace DESCRIPRO  With cDescri	
	MsUnlock()
	If mv_par10 == 1 .Or. mv_par12 == 1
		// Grava totalizador
		Reclock("TOTCOM",.F.)
		Replace VENDAS    With VENDAS+nQuant
		Replace ESTOQFIM  With ESTOQFIM-nQuant
		MsUnlock()
	EndIf	
EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R462LCom  ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 02.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Lay-Out do Mapa de Compra                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ ExpA1 = Array com as strings para a impressao              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R462LCom()
Local aL		:= Array(44)
Local nTamCPro	:= TamSX3("B1_COD")[1]
Local nTamForn  := TamSX3("D1_FORNECE")[1]

aL[01]:=STR0010 //"|-----------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------|"
aL[02]:=STR0011 //"| MAPA TRIMESTRAL                                                                                           |                                       MAPA TRIMESTRAL DE ENTRADA, DE ESTOQUE E                              |"
aL[03]:=STR0012 //"|                                                                                                           |                                           COMPRAS DE PRODUTOS CONTROLADOS                                   |"
aL[04]:=STR0013 //"|                                                                                                           |                                                                                                             |"
aL[05]:=STR0014 //"|                                                                                                           |                                                                 REFERENTE AO ############ TRIMESTRE DE #### |"
aL[06]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[07]:=STR0016 //"| FIRMA:    ##########################################################################                                                                                        INSC.EST.: ################                 |"
aL[08]:=STR0017 //"| ENDERECO: ##########################################################################                                                                                        CNPJ (MF): ################################ |"
aL[09]:=STR0018 //"| CIDADE:   ###########################################################  CEP #########                                                                                                                                    |"
aL[10]:=STR0019 //"| TELEFONES:##########################################################################                                                                                                                                    |"
aL[11]:=STR0020 //"| MAPA TRIMESTRAL DEMONSTRATIVO DO ESTOQUE, DE COMPRAS VENDA E CONSUMO                                                                                                                                                    |"
aL[12]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
If nTamCPro > 15
	aL[13]:=STR0077 //"|                                                               |     SALDO DO     |                  |                  |                  |                                                                             |"
	aL[14]:=STR0078 //"|                         PRODUTOS                              |     TRIMESTRE    |      COMPRAS     |      VENDAS      |     CONSUMO      |            ESTOQUE   QUE   PASSA   PARA   O   TRIMESTRE   SEGUINTE          |"
	aL[15]:=STR0079 //"|                                                               |     ANTERIOR     |                  |                  |                  |                                                                             |"
	aL[16]:=STR0080 //"|---------------------------------------------------------------+------------------+------------------+------------------+------------------+-----------------------------------------------------------------------------|"
	aL[17]:=STR0081 //"| ############################## ############################## | ################ | ################ | ################ | ################ | ################                                                            |"
	aL[18]:=STR0082 //"|                                                               |                  |                  |                  |                  |                                                                             |"
	aL[19]:=STR0080 //"|---------------------------------------------------------------+------------------+------------------+------------------+------------------+-----------------------------------------------------------------------------|"
Else
	aL[13]:=STR0021 //"|                                               |     SALDO DO     |                  |                  |                  |                                                                                             |"
	aL[14]:=STR0022 //"|                  PRODUTOS                     |     TRIMESTRE    |      COMPRAS     |      VENDAS      |     CONSUMO      |    E S T O Q U E   Q U E   P A S S A   P A R A   O   T R I M E S T R E   S E G U I N T E    |"
	aL[15]:=STR0023 //"|                                               |     ANTERIOR     |                  |                  |                  |                                                                                             |"
	aL[16]:=STR0024 //"|-----------------------------------------------+------------------+------------------+------------------+------------------+---------------------------------------------------------------------------------------------|"
	aL[17]:=STR0025 //"| ############### ##############################| ################ | ################ | ################ | ################ | ################                                                                            |"
	aL[18]:=STR0026 //"|                                               |                  |                  |                  |                  |                                                                                             |"
	aL[19]:=STR0024 //"|-----------------------------------------------+------------------+------------------+------------------+------------------+---------------------------------------------------------------------------------------------|"
EndIf
aL[20]:=STR0027 //"|  OBSERVACOES : FAZER EM (3) TRES VIAS.                                                                                                                                                                                  |"
aL[21]:=STR0028 //"|                ESTE MAPA E APRESENTADO TRIMESTRALMENTE (ATE O DIA 5),                                                                                                                                                   |"
aL[22]:=STR0029 //"|                COM O SALDO DO TRIMESTRE ANTERIOR.                                                                                               ######################### ## DE ############# DE ####                   |"
aL[23]:=STR0030 //"|                RELACAO DE COMPRAS NO VERSO.                                                                                                                                                                             |"
aL[24]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[25]:=STR0032 //"|                                                                                                                                                  ________________________________________________________               |"
aL[26]:=STR0033 //"|                                                                                                                                                     A S S I N A T U R A   D O   R E S P O N S A V E L                   |"
aL[27]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[28]:=STR0034 //"|                                                                                                                                                 N O M E ________________________________________________                |"
aL[29]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[30]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[31]:=STR0035 //"| RELACAO DAS COMPRAS DURANTE O TRIMESTRE                                                                                                                                                                                 |"
aL[32]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
If nTamCPro > 15
	aL[33]:=STR0084 //"|          |                  FIRMA                    |                            E N D E R E C O                           |    NOTA     |                 |                                                           |"
	aL[34]:=STR0085 //"|  DATA    |                VENDEDORA                  |----------------------------------------------------------------------|             |    QUANTIDADE   |           P R O D U T O S     C O M P R A D O S           |"
	aL[35]:=STR0087 //"|          |                                           |             RUA E NUMERO                |   CEP   |    CIDADE     |UF|   FISCAL    |                 |                                                           |"
	aL[36]:=STR0088 //"|----------+-------------------------------------------+-----------------------------------------+---------+---------------+--+-------------+-----------------+-----------------------------------------------------------|"
	aL[37]:=STR0089 //"|##########|#################### #### #################|#########################################|#########|###############|##|############ |################ | ############################## ###########################|"
	aL[38]:=STR0088 //"|----------+-------------------------------------------+-----------------------------------------+---------+---------------+--+-------------+-----------------+-----------------------------------------------------------|"
	aL[39]:=STR0090 //"|          |                                           |                                         |         |               |  |             |                 |                                                           |"
Else
	aL[33]:=STR0036 //"|            |                    FIRMA                    |                                    E N D E R E C O                           |     NOTA     |                  |                                             |"
	aL[34]:=STR0037 //"|    DATA    |                  VENDEDORA                  |------------------------------------------------------------------------------|              |    QUANTIDADE    |       P R O D U T O S    C O M P R A D O S  |"
	aL[35]:=STR0038 //"|            |                                             |               RUA E NUMERO                |    CEP    |     CIDADE      | UF |    FISCAL    |                  |                                             |"
	aL[36]:=STR0039 //"|------------+---------------------------------------------+-------------------------------------------+-----------+-----------------+----+--------------+------------------+---------------------------------------------|"
	aL[37]:=STR0040 //"| ########## | ########## #### ########################### | ######################################### | ######### | ############### | ## | ############ | ################ | ############### ########################### |"
	aL[38]:=STR0039 //"|------------+---------------------------------------------+-------------------------------------------+-----------+-----------------+----+--------------+------------------+---------------------------------------------|"
	aL[39]:=STR0041 //"|            |                                             |                                           |           |                 |    |              |                  |                                             |"
EndIf
If nTamForn <= 8 .And. nTamCPro <= 15
	aL[37]:=STR0102 //"|##########|#################### #### #################|#########################################|#########|###############|##|############ |################ | ############################## ###########################|"
EndIf
aL[40]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[41]:=STR0042 //"|                                          LICENCAS DE ACIDOS , TRANSPORTE , EXPLOSIVOS , CORROSIVOS                                                                                                                      |"
aL[42]:=STR0043 //"|                                          SFPC/2 - EXERCITO BRASILEIRO                                                                                                                                                   |"
aL[43]:=STR0044 //"|                                          DIRD     - DIVISAO DE PRODUTOS CONTROLADOS                                                                                                                                     |"
aL[44]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
//        1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                 1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22        
Return (aL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R462LVen  ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 02.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Lay-Out do Mapa de Venda                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ ExpA1 = Array com as strings para a impressao              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R462LVen()
Local aL		:= Array(34)
Local nTamCPro	:= TamSX3("B1_COD")[1]
Local nTamCli	:= TamSX3("D2_CLIENTE")[1]

aL[01]:=STR0045 //"|----------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------------------|"
aL[02]:=STR0046 //"| MAPA TRIMESTRAL                                                                                          |                                        MAPA TRIMESTRAL DE VENDAS DE                                          |"
aL[03]:=STR0047 //"|                                                                                                          |                                            PRODUTOS CONTROLADOS                                              |"
aL[04]:=STR0048 //"|                                                                                                          |                                                                                                              |"
aL[05]:=STR0049 //"|                                                                                                          |                                                                  REFERENTE AO ############ TRIMESTRE DE #### |"
aL[06]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[07]:=STR0016 //"| FIRMA:    ##########################################################################                                                                                        INSC.EST.: ################                 |"
aL[08]:=STR0017 //"| ENDERECO: ##########################################################################                                                                                        CNPJ (MF): ################################ |"
aL[09]:=STR0018 //"| CIDADE:   ###########################################################  CEP #########                                                                                                                                    |"
aL[10]:=STR0019 //"| TELEFONES:##########################################################################                                                                                                                                    |"
aL[11]:=STR0050 //"| RELACAO DAS VENDAS DURANTE O TRIMESTRE                                                                                                                                                                                  |"
aL[12]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
If nTamCPro > 15
	aL[13]:=STR0084 //"|          |                  FIRMA                    |                            E N D E R E C O                           |    NOTA     |                 |                                                           |"
	aL[14]:=STR0086 //"|  DATA    |                COMPRADORA                 |----------------------------------------------------------------------|             |    QUANTIDADE   |           P R O D U T O S      V E N D I D O S            |"
	aL[15]:=STR0087 //"|          |                                           |             RUA E NUMERO                |   CEP   |    CIDADE     |UF|   FISCAL    |                 |                                                           |"
	aL[16]:=STR0088 //"|----------+-------------------------------------------+-----------------------------------------+---------+---------------+--+-------------+-----------------+-----------------------------------------------------------|"
	aL[17]:=STR0089 //"|##########|#################### #### #################|#########################################|#########|###############|##|############ |################ | ############################## ###########################|"
	aL[18]:=STR0090 //"|          |                                           |                                         |         |               |  |             |                 |                                                           |"
	aL[19]:=STR0088 //"|----------+-------------------------------------------+-----------------------------------------+---------+---------------+--+-------------+-----------------+-----------------------------------------------------------|"
Else
	aL[13]:=STR0036 //"|            |                    FIRMA                    |                                    E N D E R E C O                           |     NOTA     |                  |                                             |"
	aL[14]:=STR0051 //"|    DATA    |                  COMPRADORA                 |------------------------------------------------------------------------------|              |    QUANTIDADE    |      P R O D U T O S    V E N D I D O S     |"
	aL[15]:=STR0038 //"|            |                                             |               RUA E NUMERO                |    CEP    |     CIDADE      | UF |    FISCAL    |                  |                                             |"
	aL[16]:=STR0039 //"|------------+---------------------------------------------+-------------------------------------------+-----------+-----------------+----+--------------+------------------+---------------------------------------------|"
	aL[17]:=STR0040 //"| ########## | #################### #### ################# | ######################################### | ######### | ############### | ## | ############ | ################ | ############### ########################### |"
	aL[18]:=STR0041 //"|            |                                             |                                           |           |                 |    |              |                  |                                             |"
	aL[19]:=STR0039 //"|------------+---------------------------------------------+-------------------------------------------+-----------+-----------------+----+--------------+------------------+---------------------------------------------|"
EndIf
If nTamCli <= 8 .And. nTamcPro <= 15
	aL[17]:=STR0103 //"|##########|######## #### #############################|#########################################|#########|###############|##|############ |################ | ############################## ###########################|"                                                                                                                                                                                                                                                                                       
EndIf
aL[20]:=STR0027 //"|  OBSERVACOES : FAZER EM (3) TRES VIAS.                                                                                                                                                                                  |"
aL[21]:=STR0028 //"|                ESTE MAPA E APRESENTADO TRIMESTRALMENTE (ATE O DIA 5),                                                                                                                                                   |"
aL[22]:=STR0029 //"|                COM O SALDO DO TRIMESTRE ANTERIOR.                                                                                               ######################### ## DE ############# DE ####                   |"
aL[23]:=STR0030 //"|                RELACAO DE COMPRAS NO VERSO.                                                                                                                                                                             |"
aL[24]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[25]:=STR0032 //"|                                                                                                                                                  ________________________________________________________               |"
aL[26]:=STR0033 //"|                                                                                                                                                     A S S I N A T U R A   D O   R E S P O N S A V E L                   |"
aL[27]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[28]:=STR0034 //"|                                                                                                                                                 N O M E ________________________________________________                |"
aL[29]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[30]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[31]:=STR0042 //"|                                          LICENCAS DE ACIDOS , TRANSPORTE , EXPLOSIVOS , CORROSIVOS                                                                                                                      |"
aL[32]:=STR0043 //"|                                          SFPC/2 - EXERCITO BRASILEIRO                                                                                                                                                   |"
aL[33]:=STR0044 //"|                                          DIRD     - DIVISAO DE PRODUTOS CONTROLADOS                                                                                                                                     |"
aL[34]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
//        1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                 1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22        
Return (aL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R462LExe  ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 03.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Lay-Out do Mapa do Exercito                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ ExpA1 = Array com as strings para a impressao              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R462LExe()
Local aL		:= Array(39)
Local nTamCPro	:= TamSX3("B1_COD")[1]
Local nTamForn	:= TamSX3("D1_FORNECE")[1]

aL[01]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[02]:=STR0052 //"| EXMO. SR.                                                                                                                                                                                                               |"
aL[03]:=STR0053 //"| GENERAL COMANDANTE DA ##a. REGIAO MILITAR - SFPC/2 - SAO PAULO                                                                                                                                                          |"
aL[04]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[05]:=STR0054 //"| A firma  ################################################################# estabelecida a ############################################################### CEP  ########                                                 |"
aL[06]:=STR0055 //"| Fone #################### Fax ################### Bairro ############################# Cidade ############################ portadora do Certificado de Registro No. #################### , valido ate ##########     ,  |"
aL[07]:=STR0056 //"| por seu responsavel que abaixo assina, apresenta a V. Exa., os Mapas do Movimento de produtos controlados referente ao ############ trimestre de #### , de acordo com o regulamento aprovado pelo Decreto No. 3665, de  |"
aL[08]:=STR0057 //"| 20 de novembro de 2000.                                                                                                                                                                                                 |"
aL[09]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[10]:=STR0058 //"| a) Movimento Geral                                                                                                                                                                                                      |"
aL[11]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
If nTamCPro > 15
	aL[12]:=STR0091 //"|                                                              |     SALDO DO     |                  |                  |                  |  VENDAS , PERDAS   |  SALDO QUE PASSA PARA O |  UNIDADES DE                  |"
	aL[13]:=STR0092 //"|                         PRODUTOS                             |     TRIMESTRE    |      COMPRAS     |      SOMA        |     CONSUMO      |  OU TRANSFERENCIAS |    TRIMESTRE SEGUINTE   |  MEDIDAS EM KGS               |"
	aL[14]:=STR0093 //"|                                                              |     ANTERIOR     |                  |                  |                  |                    |                         |                               |"
	aL[15]:=STR0094 //"|--------------------------------------------------------------+------------------+------------------+------------------+------------------+--------------------+-------------------------+-------------------------------|"
	aL[16]:=STR0095 //"| ############################## ##############################| ################ | ################ | ################ | ################ | ################   |    ################     |  ################             |"
	aL[17]:=STR0096 //"|                                                              |                  |                  |                  |                  |                    |                         |                               |"
	aL[18]:=STR0094 //"|--------------------------------------------------------------+------------------+------------------+------------------+------------------+--------------------+-------------------------+-------------------------------|"
Else
	aL[12]:=STR0059 //"|                                               |     SALDO DO     |                  |                  |                  |  VENDAS , PERDAS   |  SALDO QUE PASSA PARA O | UNIDADES DE                                  |"
	aL[13]:=STR0060 //"|                  PRODUTOS                     |     TRIMESTRE    |      COMPRAS     |      SOMA        |     CONSUMO      |  OU TRANSFERENCIAS |    TRIMESTRE SEGUINTE   | MEDIDAS EM KGS                               |"
	aL[14]:=STR0061 //"|                                               |     ANTERIOR     |                  |                  |                  |                    |                         |                                              |"
	aL[15]:=STR0062 //"|-----------------------------------------------+------------------+------------------+------------------+------------------+--------------------+-------------------------+----------------------------------------------|"
	aL[16]:=STR0063 //"| ############### ##############################| ################ | ################ | ################ | ################ | ################   |    ################     |  ################                            |"
	aL[17]:=STR0064 //"|                                               |                  |                  |                  |                  |                    |                         |                                              |"
	aL[18]:=STR0062 //"|-----------------------------------------------+------------------+------------------+------------------+------------------+--------------------+-------------------------+----------------------------------------------|"
EndIf	
aL[19] :=	STR0065 //"| b) Relacao das compras efetuadas no estado de Sao Paulo                                                                                                                                                                 |"
aL[20] :=	STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
If nTamCPro > 15
	aL[21]:=STR0097 //"|          |                   FIRMA                   |    E N D E R E C O   D A   F I R M A   V E N D E D O R A   | GUIA DE  |    NOTA    |                 |                                                           |"
	aL[22]:=STR0098 //"|   DATA   |                 VENDEDORA                 |------------------------------------------------------------| TRAFEGO  |            |   QUANTIDADE    |          P R O D U T O S     C O M P R A D O S            |"
	aL[23]:=STR0099 //"|          |                                           |        RUA , NUMERO E BAIRRO            |    CIDADE     |UF| NUMERO   |   FISCAL   |                 |                                                           |"
	aL[24]:=STR0100 //"|----------+-------------------------------------------+-----------------------------------------+---------------+--+----------+------------+-----------------+-----------------------------------------------------------|"
	aL[25]:=STR0101 //"|##########|#################### #### #################|#########################################|###############|##|##########|############|################ | ############################## ###########################|"
	aL[39]:=STR0083 //"|          |                                           |                                         |               |  |          |            |                 |                                                           |"
Else
	aL[21]:=STR0066 //"|            |                    FIRMA                    |      E N D E R E C O   D A   F I R M A   V E N D E D O R A       |   GUIA DE  |     NOTA     |                  |                                            |"
	aL[22]:=STR0067 //"|    DATA    |                  VENDEDORA                  |------------------------------------------------------------------|   TRAFEGO  |              |    QUANTIDADE    |    P R O D U T O S    C O M P R A D O S    |"
	aL[23]:=STR0068 //"|            |                                             |          RUA , NUMERO E BAIRRO            |     CIDADE      | UF |   NUMERO   |    FISCAL    |                  |                                            |"
	aL[24]:=STR0069 //"|------------+---------------------------------------------+-------------------------------------------+-----------------+----+------------+--------------+------------------+--------------------------------------------|"
	aL[25]:=STR0070 //"| ########## | #################### #### ################# | ######################################### | ############### | ## | ########## | ############ | ################ | ############### ###########################|"
	aL[39]:=STR0076 //"|            |                                             |                                           |                 |    |            |              |                  |                                            |"
EndIf	   
If nTamForn <= 8 .And. nTamCPro <= 15
	aL[25]:=STR0104 //"| ########## | ######## #### ############################# | ######################################### | ############### | ## | ########## | ############ | ################ | ############### ###########################|"                                                                                                                                                                                                                                                                                       
EndIf
aL[26]:=STR0071 //"| c) Relacao das compras efetuadas em outros estados                                                                                                                                                                      |"
aL[27]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
aL[28]:=STR0072 //"| ATENCAO: Prazo improrrogavel para entrega ate o                                                                                                                                                                         |"
aL[29]:=STR0073 //"|          dia 5 apos o vencimento do trimestre.                                                                                                                                                                          |"
aL[30]:=STR0074 //"|                                                                                                                                                 ######################### ## DE ############# DE ####                   |"
aL[31]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[32]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[33]:=STR0032 //"|                                                                                                                                                  ________________________________________________________               |"
aL[34]:=STR0033 //"|                                                                                                                                                     A S S I N A T U R A   D O   R E S P O N S A V E L                   |"
aL[35]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[36]:=STR0075 //"| Obs: Fazer em 4 vias                                                                                                                            N O M E ________________________________________________                |"
aL[37]:=STR0031 //"|                                                                                                                                                                                                                         |"
aL[38]:=STR0015 //"|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
Return (aL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³R462Cabec()    ³Autor³Rodrigo A Sartorio  ³ Data ³ 04.08.04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cabecalho do Relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 = No.da linha                                        ³±±
±±³          ³ ExpC1 = Tipo do relatorio                                  ³±±
±±³          ³ ExpA1 = Array com descricao ordinal dos Trimestres	      ³±±
±±³          ³ ExpA2 = Array com strings para impressao	                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR462                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R462Cabec(nLin,nTipo,aMesOrd,aL)
Local cPicCgc
If  cPaisLoc=="ARG"
	cPicCgc	:="@R 99-99.999.999-9"
ElseIf cPaisLoc == "CHI"
	cPicCgc	:="@R XX.999.999-X"
ElseIf cPaisLoc $ "POR|EUA"
	cPicCgc	:=PesqPict("SA2","A2_CGC")
Else
	cPicCgc	:="@!R NN.NNN.NNN/NNNN-99"
EndIf

// Inicio da Capa do Mapa de Compras e Capa e Interior do Mapa de Vendas
If nTipo == 1 .Or. nTipo == 5 .Or. nTipo == 6
	nLin:=1
	@ 00,00 PSAY AvalImp(220)
	If nTipo == 1 .Or. nTipo == 5
		FmtLin(,aL[01],,,@nLin)
		FmtLin(,aL[02],,,@nLin)
		FmtLin(,aL[03],,,@nLin)
		FmtLin(,aL[04],,,@nLin)
		FmtLin({aMesOrd[mv_par09],Str(Year(dDataBase),4,0)},aL[05],,,@nLin)
		FmtLin(,aL[06],,,@nLin)
		FmtLin({SM0->M0_NOMECOM,InscrEst()},aL[07],,,@nLin)
		FmtLin({SM0->M0_ENDCOB,Transform(SM0->M0_CGC,cPicCgc)},aL[08],,,@nLin)
		FmtLin({Alltrim(SM0->M0_CIDCOB),SM0->M0_CEPCOB},aL[09],,,@nLin)
		FmtLin({SM0->M0_TEL},aL[10],,,@nLin)
		FmtLin(,aL[11],,,@nLin)
	EndIf
	FmtLin(,aL[12],,,@nLin)
	FmtLin(,aL[13],,,@nLin)
	FmtLin(,aL[14],,,@nLin)
	FmtLin(,aL[15],,,@nLin)
	FmtLin(,aL[16],,,@nLin)
// Fim da Capa do Mapa de Compras / Fim da capa do Mapa de Vendas
ElseIf nTipo == 2 .Or. nTipo == 7
	FmtLin(,aL[19],,,@nLin)
	FmtLin(,aL[20],,,@nLin)
	FmtLin(,aL[21],,,@nLin)
	FmtLin({SM0->M0_CIDCOB,StrZero(Day(dDataBase),2,0),MesExtenso(Month(dDataBase)),Str(Year(dDataBase),4,0)},aL[22],,,@nLin)
	FmtLin(,aL[23],,,@nLin)
	FmtLin(,aL[24],,,@nLin)
	FmtLin(,aL[25],,,@nLin)
	FmtLin(,aL[26],,,@nLin)
	FmtLin(,aL[27],,,@nLin)
	FmtLin(,aL[28],,,@nLin)	
	FmtLin(,aL[29],,,@nLin)
	FmtLin(,aL[30],,,@nLin)	
	nLin:=80
// Inicio do interior do Mapa de Compras
ElseIf nTipo == 3
	nLin:=1
	@ 00,00 PSAY AvalImp(220)
	FmtLin(,aL[30],,,@nLin)
	FmtLin(,aL[31],,,@nLin)
	FmtLin(,aL[32],,,@nLin)
	FmtLin(,aL[33],,,@nLin)
	FmtLin(,aL[34],,,@nLin)
	FmtLin(,aL[35],,,@nLin)
	FmtLin(,aL[36],,,@nLin)
// Fim do interior do Mapa de Compras
ElseIf nTipo == 4
	FmtLin(,aL[40],,,@nLin)
	FmtLin(,aL[41],,,@nLin)
	FmtLin(,aL[42],,,@nLin)
	FmtLin(,aL[43],,,@nLin)
	FmtLin(,aL[44],,,@nLin)
	nLin:=80
// Fim do interior do Mapa de Vendas
ElseIf nTipo == 8
	FmtLin(,aL[30],,,@nLin)
	FmtLin(,aL[31],,,@nLin)
	FmtLin(,aL[32],,,@nLin)
	FmtLin(,aL[33],,,@nLin)
	FmtLin(,aL[34],,,@nLin)
	nLin:=80
// Inicio do mapa do exercito
ElseIf nTipo == 9 .Or. nTipo == 11
	nLin:=1
	@ 00,00 PSAY AvalImp(220)
	If nTipo == 9
		FmtLin(,aL[01],,,@nLin)
		FmtLin(,aL[02],,,@nLin)
		FmtLin({Str(mv_par13,2)},aL[03],,,@nLin)	
		FmtLin(,aL[04],,,@nLin)
		FmtLin({SM0->M0_NOMECOM,Alltrim(SM0->M0_ENDCOB),SM0->M0_CEPCOB},aL[05],,,@nLin)	
		FmtLin({SM0->M0_TEL,SM0->M0_FAX,AllTrim(SM0->M0_BAIRCOB),AllTrim(SM0->M0_CIDCOB),mv_par14},aL[06],,,@nLin)
		FmtLin({DTOC(mv_par15),aMesOrd[mv_par09],Str(Year(dDataBase),4,0)},aL[07],,,@nLin)
		FmtLin(,aL[08],,,@nLin)	
	EndIf	
	FmtLin(,aL[09],,,@nLin)	
	FmtLin(,aL[10],,,@nLin)	
	FmtLin(,aL[11],,,@nLin)	
	FmtLin(,aL[12],,,@nLin)	
	FmtLin(,aL[13],,,@nLin)	
	FmtLin(,aL[14],,,@nLin)	
	FmtLin(,aL[15],,,@nLin)	
// Fim da capa do mapa do exercito
ElseIf	nTipo == 10
	FmtLin(,aL[27],,,@nLin)
	FmtLin(,aL[28],,,@nLin)
	FmtLin(,aL[29],,,@nLin)
	FmtLin({SM0->M0_CIDCOB,StrZero(Day(dDataBase),2,0),MesExtenso(Month(dDataBase)),Str(Year(dDataBase),4,0)},aL[30],,,@nLin)
	FmtLin(,aL[31],,,@nLin)
	FmtLin(,aL[32],,,@nLin)
	FmtLin(,aL[33],,,@nLin)
	FmtLin(,aL[34],,,@nLin)
	FmtLin(,aL[35],,,@nLin)
	FmtLin(,aL[36],,,@nLin)	
	FmtLin(,aL[37],,,@nLin)
	FmtLin(,aL[38],,,@nLin)	
	nLin:=80
ElseIf nTipo == 12
	nLin:=1
	@ 00,00 PSAY AvalImp(220)
	FmtLin(,aL[20],,,@nLin)
	FmtLin(,aL[19],,,@nLin)	
	FmtLin(,aL[20],,,@nLin)	
	FmtLin(,aL[21],,,@nLin)	
	FmtLin(,aL[22],,,@nLin)	
	FmtLin(,aL[23],,,@nLin)	
	FmtLin(,aL[24],,,@nLin)	
ElseIf nTipo == 13 .Or. nTipo == 14
	If nTipo == 14
		nLin:=1
		@ 00,00 PSAY AvalImp(220)
	EndIf
	FmtLin(,aL[20],,,@nLin)
	FmtLin(,aL[26],,,@nLin)	
	FmtLin(,aL[27],,,@nLin)	
	FmtLin(,aL[21],,,@nLin)	
	FmtLin(,aL[22],,,@nLin)	
	FmtLin(,aL[23],,,@nLin)	
	FmtLin(,aL[24],,,@nLin)	
EndIf
Return (NIL)
