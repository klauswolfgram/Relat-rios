/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR185.ch"   
#INCLUDE "MSOLE.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR185   ³ Autor ³ William P. Alves      ³ Data ³ 05.07.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao Carta de Correcao                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function MATR185()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo      := OemToAnsi(STR0001)  
Local cDesc1      := OemToAnsi(STR0002 ) 
Local cDesc2      := OemToAnsi(STR0003) 
Local cDesc3      := OemToAnsi("")
Local cString     := "SF2"
Local lDic        := .F. 	// Habilita/Desabilita Dicionario
Local lComp       := .T. 	// Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro     := .F. 	// Habilita/Desabilita o Filtro
Local wnrel       := "MATR185"  	// Nome do Arquivo utilizado no Spool
Local nomeprog    := "MATR185"  	// nome do programa
Local aPDFields   := {"A1_NOME","A1_END","A1_CEP","A1_MUN","A1_BAIRRO"}

Private Tamanho := "M" // P/M/G
Private Limite  := 132 // 80/132/220
Private aOrdem  := {}  // Ordem do Relatorio
Private cPerg   := "MTR185"  // Pergunta do Relatorio
Private aReturn := { STR0004, 1,STR0005, 1, 2, 1, "",1 }  //"Zebrado"###"Administracao"

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault


Pergunte(cPerg,.F.)

FATPDLoad(Nil,Nil,aPDFields)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif
 
RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)

dbSelectArea(cString)
dbClearFilter()
Set Device To Screen
Set Printer To

If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
FATPDUnload()

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³IMPDET    ³ Autor ³ William P. Alves      ³ Data ³ 05.07.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpDet()

Local aLayEnt	:= LayOutEnt()
Local aLaySai	:= LayOutSai()

Local cAliasSF2 := "SF2"
Local cAliasSF1 := "SF1"
Local cArqInd   := ""

Local lQuery    := .F.
Local li        := 0
Local aIrrCC	:= {}
Local nRet		:= 0
Local nOpcRet	:= 0
Local nDia     := Day(dDataBase)
Local cMes     := MesExtenso(Month(dDataBase))
Local nAno     := Year(dDataBase)
Local cNome		:= ""	
Local cEndereco	:= ""
Local cBairro	:= ""
Local cCep		:= ""
Local cMunic	:= ""
Local cEst		:= ""
Local lA1A2		:= .F.

Local aStruSF2  := {}
Local aCamposSF2:= {}

Local aStruSF1  := {}
Local aCamposSF1:= {}

Local cQuery    := ""   
Local cCmpQry	:= ""

Local nX        := 0

If !IsBlind() //Tratativa para execução de testes automatizados
	nOpcRet := A185TabIrr(@aIrrCC)
Else
	nOpcRet := 1 
EndIf

If nOpcRet <> 0
	If mv_par03 == 2
	
		dbSelectArea("SF2")
		dbSetOrder(1)
    
	    aAdd(aCamposSF2,"F2_DOC")
   	    aAdd(aCamposSF2,"F2_SERIE")
   	    aAdd(aCamposSF2,"F2_CLIENTE")
   	    aAdd(aCamposSF2,"F2_LOJA")
   	    aAdd(aCamposSF2,"F2_EMISSAO")
   	    aAdd(aCamposSF2,"F2_TIPO")
   	    If SerieNfId("SF2",3,"F2_SERIE")<>"F2_SERIE"
   	    	aAdd(aCamposSF2,"F2_SDOC")	
   	    Endif
   	    
    	//
    	aStruSF2  := SF2->(Mtr185Str(aCamposSF2,@cCmpQry))

		lQuery    := .T.
		cAliasSF2 := "F2_MATR185"
		
		cQuery    := "SELECT "
		cQuery    += cCmpQry
		cQuery    += "FROM " + RetSqlName("SF2") + " SF2 "
		cQuery    += "WHERE "
		cQuery    += "F2_FILIAL = '" + xFilial("SF2") + "' AND "
		cQuery    += "F2_DOC = '"+mv_par01+"' AND "
		cQuery    += SerieNfId("SF2",3,"F2_SERIE") + " = '"+mv_par02+"' AND "	
		cQuery    += "SF2.D_E_L_E_T_ = ' ' "               
		cQuery    += "ORDER BY " + SqlOrder(SF2->(IndexKey()))
	
	    cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2,.T.,.T.)
	
		For nX := 1 To len(aStruSF2)
			If aStruSF2[nX][2] <> "C" 
				TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
			EndIf
		Next nX
	
		dbSelectArea(cAliasSF2)	
	
	Else
	
		dbSelectArea("SF1")
		dbSetOrder(1)
	
	    aAdd(aCamposSF1,"F1_DOC")
   	    aAdd(aCamposSF1,"F1_SERIE")
   	    aAdd(aCamposSF1,"F1_FORNECE")
   	    aAdd(aCamposSF1,"F1_LOJA")
   	    aAdd(aCamposSF1,"F1_EMISSAO")
   	    aAdd(aCamposSF1,"F1_TIPO")
   	    If SerieNfId("SF1",3,"F1_SERIE")<>"F1_SERIE"
   	    	aAdd(aCamposSF2,"F1_SDOC")	
   	    Endif
    	//
    	aStruSF1  := SF1->(Mtr185Str(aCamposSF1,@cCmpQry))

		lQuery    := .T.
		cAliasSF1 := "F1_MATR185"
		
		cQuery    := "SELECT "
		cQuery    += cCmpQry
		cQuery    += "FROM " + RetSqlName("SF1") + " SF1 "
		cQuery    += "WHERE "
		cQuery    += "F1_FILIAL = '" + xFilial("SF1") + "' AND "
		cQuery    += "F1_DOC = '"+mv_par01+"' AND "
		cQuery    += SerieNfId("SF1",3,"F1_SERIE") + " = '"+mv_par02+"' AND "	
		cQuery    += "SF1.D_E_L_E_T_ = ' ' "               
		cQuery    += "ORDER BY " + SqlOrder(SF1->(IndexKey()))
	
	    cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF1,.T.,.T.)
	
		For nX := 1 To len(aStruSF1)
			If aStruSF1[nX][2] <> "C" 
				TcSetField(cAliasSF1,aStruSF1[nX][1],aStruSF1[nX][2],aStruSF1[nX][3],aStruSF1[nX][4])
			EndIf
		Next nX
	
		dbSelectArea(cAliasSF1)	
		
	EndIf
	
	
	If mv_par03 == 2
		dbSelectArea("SA1")
		dbSetOrder(1)
		While (cAliasSF2)->(!Eof())
		    cNome		:= ""
			cEndereco	:= ""
			cBairro		:= ""
			cCep		:= ""
			cMunic		:= ""
			cEst		:= ""
			lA1A2		:= .F.
		
		    IF (cAliasSF2)->F2_TIPO $ "BD" 
				//Se for Nota de beneficiamento ou devolução irá buscar pelo fornecedor
				IF SA2->(dbSeek(xFilial("SA2")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))		    		    
					cNome		:= SA2->A2_NOME
					cEndereco	:= SA2->A2_END
					cBairro		:= SA2->A2_BAIRRO
					cCep		:= SA2->A2_CEP
					cMunic		:= SA2->A2_MUN
					cEst		:= SA2->A2_EST
					lA1A2		:= .T.
				EndIF
		    Else
				IF SA1->(dbSeek(xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))		    
					cNome		:= SA1->A1_NOME
					cEndereco	:= SA1->A1_END
					cBairro		:= SA1->A1_BAIRRO
					cCep		:= SA1->A1_CEP
					cMunic		:= SA1->A1_MUN
					cEst		:= SA1->A1_EST
					lA1A2		:= .T.
				EndIF				
		    EndIF

		    If lA1A2
		    	nLin := 0
    			@nLin,000 Psay aValImp(Limite)
    			nLin++
				FmtLin({AllTrim(SM0->M0_CIDENT) + ", ",StrZero(ndia,2), " de " + AllTrim(cMes) + " de ", StrZero(nAno,4), TransForm(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99") },aLaySai[1],,,@Li)
				FmtLin({AllTrim(SM0->M0_NOMECOM)},aLaySai[75],,,@Li)	
				FmtLin({AllTrim(SM0->M0_ENDENT)},aLaySai[2],,,@Li)		
				FmtLin({AllTrim(SM0->M0_BAIRENT)},aLaySai[3],,,@Li)
				FmtLin({AllTrim(SM0->M0_CEPENT), AllTrim(SM0->M0_CIDENT), AllTrim(SM0->M0_ESTENT)},aLaySai[4],,,@Li)	
				FmtLin({},aLaySai[5],,,@Li)
				FmtLin({FATPDObfuscate(AllTrim(cNome)		, "A1_NOME")},aLaySai[6],,,@Li)
				FmtLin({FATPDObfuscate(AllTrim(cEndereco)	, "A1_END") , FATPDObfuscate(AllTrim(cBairro), "A1_BAIRRO") , FATPDObfuscate(AllTrim(cCep), "A1_CEP") },aLaySai[7],,,@Li)
				FmtLin({FATPDObfuscate(AllTrim(cMunic)		, "A1_MUN"), AllTrim(cEst)},aLaySai[8],,,@Li)
				FmtLin({},aLaySai[9],,,@Li)
				FmtLin({},aLaySai[10],,,@Li)
				FmtLin({},aLaySai[11],,,@Li)
				FmtLin({},aLaySai[12],,,@Li)
				FmtLin({(cAliasSF2)->F2_DOC, (cAliasSF2)->&(SerieNfId("SF2",3,"F2_SERIE")), (cAliasSF2)->F2_EMISSAO },aLaySai[13],,,@Li)
				FmtLin({},aLaySai[14],,,@Li)
				FmtLin({},aLaySai[15],,,@Li)
				FmtLin({},aLaySai[16],,,@Li)
				FmtLin({},aLaySai[17],,,@Li)
				FmtLin({},aLaySai[18],,,@Li)
				FmtLin({},aLaySai[19],,,@Li)
				FmtLin({},aLaySai[20],,,@Li)
				FmtLin({},aLaySai[21],,,@Li)
				FmtLin({},aLaySai[22],,,@Li)
				FmtLin({},aLaySai[23],,,@Li)
				FmtLin({},aLaySai[24],,,@Li)
				FmtLin({},aLaySai[25],,,@Li)                             
				FmtLin({},aLaySai[26],,,@Li)
				FmtLin({},aLaySai[27],,,@Li)
				FmtLin({},aLaySai[28],,,@Li)
				FmtLin({},aLaySai[29],,,@Li)
				FmtLin({},aLaySai[30],,,@Li)
				FmtLin({},aLaySai[31],,,@Li)
				FmtLin({},aLaySai[32],,,@Li)
				FmtLin({},aLaySai[33],,,@Li)
				FmtLin({},aLaySai[34],,,@Li)
				FmtLin({},aLaySai[35],,,@Li)
				FmtLin({},aLaySai[36],,,@Li)
				FmtLin({},aLaySai[37],,,@Li)
				FmtLin({},aLaySai[38],,,@Li)
				FmtLin({},aLaySai[39],,,@Li)
				FmtLin({},aLaySai[40],,,@Li)
				FmtLin({},aLaySai[41],,,@Li)
				FmtLin({},aLaySai[42],,,@Li)
				FmtLin({},aLaySai[43],,,@Li)
				FmtLin({},aLaySai[44],,,@Li)
				FmtLin({},aLaySai[45],,,@Li)
				FmtLin({},aLaySai[46],,,@Li)
				FmtLin({},aLaySai[47],,,@Li)
				FmtLin({},aLaySai[48],,,@Li)
				FmtLin({},aLaySai[49],,,@Li)
				FmtLin({},aLaySai[50],,,@Li)
				FmtLin({},aLaySai[51],,,@Li)
				FmtLin({},aLaySai[52],,,@Li)
				FmtLin({},aLaySai[53],,,@Li)
				FmtLin({},aLaySai[54],,,@Li)
				FmtLin({},aLaySai[55],,,@Li)
				FmtLin({},aLaySai[56],,,@Li)
				FmtLin({},aLaySai[57],,,@Li)
				FmtLin({},aLaySai[58],,,@Li)
				FmtLin({},aLaySai[59],,,@Li)
				FmtLin({},aLaySai[60],,,@Li)
				
				For nRet := 1 to Len(aIrrCC)
					If Alltrim(aIrrCC[nRet][3]) <> ""
						FmtLin({aIrrCC[nRet][1], aIrrCC[nRet][3]},aLaySai[61],,,@Li)
					EndIf
				Next nRet
				FmtLin({},aLaySai[62],,,@Li) 
				FmtLin({},aLaySai[63],,,@Li)
				FmtLin({},aLaySai[64],,,@Li)
				FmtLin({},aLaySai[65],,,@Li)
				FmtLin({},aLaySai[66],,,@Li)
				FmtLin({},aLaySai[67],,,@Li)
				FmtLin({},aLaySai[68],,,@Li)
				FmtLin({},aLaySai[69],,,@Li) 
				FmtLin({},aLaySai[70],,,@Li)
				FmtLin({},aLaySai[71],,,@Li)
				FmtLin({},aLaySai[72],,,@Li)
				FmtLin({},aLaySai[73],,,@Li)
				FmtLin({},aLaySai[74],,,@Li)
			EndIf
		(cAliasSF2)->(DbSkip ())	
		EndDo
	Else                  		
		dbSelectArea("SA2")
		dbSetOrder(1)
		While (cAliasSF1)->(!Eof())                  
		
		    cNome		:= ""
			cEndereco	:= ""
			cBairro		:= ""
			cCep		:= ""
			cMunic		:= ""
			cEst		:= ""
			lA1A2		:= .F.
		
		    IF (cAliasSF1)->F1_TIPO $ "BD" 
				//Se for Nota de beneficiamento ou devolução irá buscar pelo cliente
				IF SA1->(dbSeek(xFilial("SA1")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA))		    
					cNome		:= SA1->A1_NOME
					cEndereco	:= SA1->A1_END
					cBairro		:= SA1->A1_BAIRRO
					cCep		:= SA1->A1_CEP
					cMunic		:= SA1->A1_MUN
					cEst		:= SA1->A1_EST
					lA1A2		:= .T.
				EndIF				
		    Else
				IF SA2->(dbSeek(xFilial("SA2")+(cAliasSF1)->F1_FORNECE+(cAliasSF1)->F1_LOJA))		    		    
					cNome		:= SA2->A2_NOME
					cEndereco	:= SA2->A2_END
					cBairro		:= SA2->A2_BAIRRO
					cCep		:= SA2->A2_CEP
					cMunic		:= SA2->A2_MUN
					cEst		:= SA2->A2_EST
					lA1A2		:= .T.
				EndIF
		    EndIF  
		    		    
		    If lA1A2
		    	nLin := 0
    			@nLin,000 Psay aValImp(Limite)
    			nLin++
				FmtLin({AllTrim(SM0->M0_CIDENT) + ", ",StrZero(ndia,2), " de " + AllTrim(cMes) + " de ", StrZero(nAno,4), TransForm(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99") },aLayEnt[1],,,@Li)
				FmtLin({AllTrim(SM0->M0_NOMECOM)},aLayEnt[75],,,@Li)
				FmtLin({AllTrim(SM0->M0_ENDENT)},aLayEnt[2],,,@Li)		
				FmtLin({AllTrim(SM0->M0_BAIRENT)},aLayEnt[3],,,@Li)
				FmtLin({AllTrim(SM0->M0_CEPENT), AllTrim(SM0->M0_CIDENT), AllTrim(SM0->M0_ESTENT)},aLayEnt[4],,,@Li)	
				FmtLin({},aLayEnt[5],,,@Li)
				FmtLin({ FATPDObfuscate(AllTrim(cNome)		, "A1_NOME") },aLayEnt[6],,,@Li)
				FmtLin({ FATPDObfuscate(AllTrim(cEndereco)	, "A1_END") , FATPDObfuscate(AllTrim(cBairro), "A1_BAIRRO") , FATPDObfuscate(AllTrim(cCep), "A1_CEP") },aLayEnt[7],,,@Li)
				FmtLin({ FATPDObfuscate(AllTrim(cMunic)		, "A1_MUN") , AllTrim(cEst)},aLayEnt[8],,,@Li)
				FmtLin({},aLayEnt[9],,,@Li)
				FmtLin({},aLayEnt[10],,,@Li)
				FmtLin({},aLayEnt[11],,,@Li)
				FmtLin({},aLayEnt[12],,,@Li)
				FmtLin({(cAliasSF1)->F1_DOC, (cAliasSF1)->&(SerieNfId("SF1",3,"F1_SERIE")), (cAliasSF1)->F1_EMISSAO },aLayEnt[13],,,@Li)
				FmtLin({},aLayEnt[14],,,@Li)
				FmtLin({},aLayEnt[15],,,@Li)
				FmtLin({},aLayEnt[16],,,@Li)
				FmtLin({},aLayEnt[17],,,@Li)
				FmtLin({},aLayEnt[18],,,@Li)
				FmtLin({},aLayEnt[19],,,@Li)
				FmtLin({},aLayEnt[20],,,@Li)
				FmtLin({},aLayEnt[21],,,@Li)
				FmtLin({},aLayEnt[22],,,@Li)
				FmtLin({},aLayEnt[23],,,@Li)
				FmtLin({},aLayEnt[24],,,@Li)
				FmtLin({},aLayEnt[25],,,@Li)                             
				FmtLin({},aLayEnt[26],,,@Li)
				FmtLin({},aLayEnt[27],,,@Li)
				FmtLin({},aLayEnt[28],,,@Li)
				FmtLin({},aLayEnt[29],,,@Li)
				FmtLin({},aLayEnt[30],,,@Li)
				FmtLin({},aLayEnt[31],,,@Li)
				FmtLin({},aLayEnt[32],,,@Li)
				FmtLin({},aLayEnt[33],,,@Li)
				FmtLin({},aLayEnt[34],,,@Li)
				FmtLin({},aLayEnt[35],,,@Li)
				FmtLin({},aLayEnt[36],,,@Li)
				FmtLin({},aLayEnt[37],,,@Li)
				FmtLin({},aLayEnt[38],,,@Li)
				FmtLin({},aLayEnt[39],,,@Li)
				FmtLin({},aLayEnt[40],,,@Li)
				FmtLin({},aLayEnt[41],,,@Li)
				FmtLin({},aLayEnt[42],,,@Li)
				FmtLin({},aLayEnt[43],,,@Li)
				FmtLin({},aLayEnt[44],,,@Li)
				FmtLin({},aLayEnt[45],,,@Li)
				FmtLin({},aLayEnt[46],,,@Li)
				FmtLin({},aLayEnt[47],,,@Li)
				FmtLin({},aLayEnt[48],,,@Li)
				FmtLin({},aLayEnt[49],,,@Li)
				FmtLin({},aLayEnt[50],,,@Li)
				FmtLin({},aLayEnt[51],,,@Li)
				FmtLin({},aLayEnt[52],,,@Li)
				FmtLin({},aLayEnt[53],,,@Li)
				FmtLin({},aLayEnt[54],,,@Li)
				FmtLin({},aLayEnt[55],,,@Li)
				FmtLin({},aLayEnt[56],,,@Li)
				FmtLin({},aLayEnt[57],,,@Li)
				FmtLin({},aLayEnt[58],,,@Li)
				FmtLin({},aLayEnt[59],,,@Li)
				FmtLin({},aLayEnt[60],,,@Li)
				
				For nRet := 1 to Len(aIrrCC)
					If Alltrim(aIrrCC[nRet][3]) <> ""
						FmtLin({aIrrCC[nRet][1], aIrrCC[nRet][3]},aLayEnt[61],,,@Li)
					EndIf
				Next nRet
				FmtLin({},aLayEnt[62],,,@Li) 
				FmtLin({},aLayEnt[63],,,@Li)
				FmtLin({},aLayEnt[64],,,@Li)
				FmtLin({},aLayEnt[65],,,@Li)
				FmtLin({},aLayEnt[66],,,@Li)
				FmtLin({},aLayEnt[67],,,@Li)
				FmtLin({},aLayEnt[68],,,@Li)
				FmtLin({},aLayEnt[69],,,@Li) 
				FmtLin({},aLayEnt[70],,,@Li)
				FmtLin({},aLayEnt[71],,,@Li)
				FmtLin({},aLayEnt[72],,,@Li)
				FmtLin({},aLayEnt[73],,,@Li)
				FmtLin({},aLayEnt[74],,,@Li)
			EndIf
		(cAliasSF1)->(DbSkip ())	
		EndDo
	EndIf
	
	If mv_par03 == 2
		If !lQuery
			RetIndex("SF2")	
			dbClearFilter()	
			Ferase(cArqInd+OrdBagExt())
		Else
			dbSelectArea(cAliasSF2)
			dbCloseArea()
		Endif
	Else
		If !lQuery
			RetIndex("SF1")	
			dbClearFilter()	
			Ferase(cArqInd+OrdBagExt())
		Else
			dbSelectArea(cAliasSF1)
			dbCloseArea()
		Endif
	EndIf
EndIf

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Mtr185Str ºAutor  ³William P. Alves    º Data ³  05/05/2010 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Montar um array apenas com os campos utilizados na query    º±±
±±º          ³para passagem na funcao TCSETFIELD                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³aCampos: campos a serem tratados na query                   º±±
±±º          ³cCmpQry: string contendo os campos para select na query     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Matr185                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

Static Function Mtr185Str(aCampos,cCmpQry)
	Local	aRet	:=	{}
	Local	nX		:=	0
	Local	aTamSx3	:=	{}
	//
	For nX := 1 To Len(aCampos)
		If(FieldPos(aCampos[nX])>0)
			aTamSx3 := TamSX3(aCampos[nX])
			aAdd (aRet,{aCampos[nX],aTamSx3[3],aTamSx3[1],aTamSx3[2]})
			//
			cCmpQry	+=	aCampos[nX]+", "
		EndIf
	Next(nX)
	//
	If(Len(cCmpQry)>0)
		cCmpQry	:=	" " + SubStr(cCmpQry,1,Len(cCmpQry)-2) + " "
	EndIf
Return(aRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetLayOut | Autor ³ William P. Alves      ³ Data ³ 05.07.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o LayOut a ser impresso                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com o LayOut                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function LayOutSai()

Local aLaySai := Array(75)

//
//                        1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aLaySai[01] := "            #################### #### ############# ######                   CNPJ:   ######################################        "
aLaySai[75] := "                                                                             ##############################################        "
aLaySai[02] := "                                                                             ##############################################        "
aLaySai[03] := "                                                                             Bairro: ######################################        "
aLaySai[04] := "                                                                             Cep:    ######### ######################### ##        "           
aLaySai[05] := "     À                                                                                                                             "
aLaySai[06] := "     ###########################################################################                                                   "
aLaySai[07] := "     ################################### ##################### Cep: ############                                                   "
aLaySai[08] := "     ##################### ##                                                                                                      "
aLaySai[09] := "                                                                                                                                   "
aLaySai[10] := "     Prezado(s) Senhor(es): Ref.: Conferência de Documento Fiscal e Comunicação de Incorreções                                     "
aLaySai[11] := "                                                                                                                                   "
aLaySai[12] := "     |-----------------------------------------------------------------------------------------------------------------------|     "
aLaySai[13] := "     |Nossa(X) Sua()        Nota Fiscal nº: ############ Série: ######                               Data: #############     |     "
aLaySai[14] := "     |-----------------------------------------------------------------------------------------------------------------------|     "
aLaySai[15] := "                                                                                                                                   "
aLaySai[16] := "            Em face do que determina a legislação fiscal vigente, vimos pela presente comunicar-lhe(s) que a nota fiscal           "
aLaySai[17] := "     em referência contém a(s) irregularidade(s) que abaixo apontamos, cuja correção solicitamos seja providenciada                "
aLaySai[18] := "     imediatamente.                                                                                                                "
aLaySai[19] := "                                                                                                                                   "
aLaySai[20] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[21] := "     |Cód. | Especificação                   |Cód. | Especificação                   |Cód. | Especificação                   |     "
aLaySai[22] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[23] := "     | 01  | Razao Social                    | 18  | Classificacao Fiscal            | 35  | Despesas Frete                  |     "
aLaySai[24] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[25] := "     | 02  | Endereco                        | 19  | Aliquota do IPI                 | 36  | Despesas Seguro                 |     "
aLaySai[26] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[27] := "     | 03  | Municipio                       | 20  | Valor do IPI                    | 37  | Total de Despesas Acessorias    |     "
aLaySai[28] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[29] := "     | 04  | Estado                          | 21  | Base de Calculo do IPI          | 38  | Rasuras                         |     "
aLaySai[30] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[31] := "     | 05  | No. de Inscr. no CNPJ/CPF       | 22  | Valor Total da Nota             | 39  | No. Nota Fiscal                 |     "
aLaySai[32] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[33] := "     | 06  | No. de Inscr. Estadual          | 23  | Aliquota do ICMS                | 40  | Serie Errada                    |     "
aLaySai[34] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[35] := "     | 07  | Natureza da Operacao            | 24  | Valor do ICMS                   | 41  | Local de Saida das Mercadorias  |     "
aLaySai[36] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[37] := "     | 08  | Cod. Fiscal da Operacao         | 25  | Base de Calculo do ICMS         | 42  | Local de Entrega das Mercadorias|     "
aLaySai[38] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[39] := "     | 09  | Via de Transporte               | 26  | Nome do Transportador           | 43  | Motivo da Devolucao             |     "
aLaySai[40] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[41] := "     | 10  | Data da Emissao                 | 27  | End. do Transportador           | 44  | Disc. Mao de Obra Aplicada      |     "
aLaySai[42] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[43] := "     | 11  | Data da Saida                   | 28  | Termo de Isencao do IPI         | 45  | Valor de Mao de Obra Aplicada   |     "
aLaySai[44] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[45] := "     | 12  | Data da Entrada                 | 29  | Termo de Isencao ICMS           | 46  | Condicoes de Pagamento          |     "
aLaySai[46] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[47] := "     | 13  | Unidade (Produto)               | 30  | Peso Bruto                      | 47  | Data de Entrega                 |     "
aLaySai[48] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[49] := "     | 14  | Quantidade (Produto)            | 31  | Peso Liquido                    | 48  | Dec.Exig. Pelo Art207 e &&  RIPI|     "
aLaySai[50] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[51] := "     | 15  | Descricao dos Produtos          | 23  | Marca dos Volumes               | 49  | Fatura                          |     "
aLaySai[52] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[53] := "     | 16  | Preco Unitario                  | 33  | Numeros dos Volumes             | 50  | Outros                          |     "
aLaySai[54] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[55] := "     | 17  | Valor Total dos Produtos        | 34  | Especies dos Volumes            |     |                                 |     "
aLaySai[56] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLaySai[57] := "                                                                                                                                   "
aLaySai[58] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLaySai[59] := "     |Cód. |                                    Retificações a serem consideradas                                            |     "
aLaySai[60] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLaySai[61] := "     | ##  | #################################################################                                               |     "
aLaySai[62] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLaySai[63] := "                                                                                                                                   "
aLaySai[64] := "            Para evitar-se qualquer sanção fiscal, solicitamos acusarem o recebimento desta, na cópia que a acompanha,             "
aLaySai[65] := "     devendo a via de V. S (as) ficar arquivada juntamente com a Nota Fiscal em questão.                                           "
aLaySai[66] := "                                                                                                                                   "
aLaySai[67] := "             Acusamos o recebimento da 1ª via                            Sem outro motivo para o momento, subscrevemo-nos          "
aLaySai[68] := "     |------------------------------------------------------|                               Atenciosamente,                        "
aLaySai[69] := "     |    ____________________________________________      |                                                                      "
aLaySai[70] := "     |                    (Local e data)                    |                                                                      "
aLaySai[71] := "     |                                                      |                                                                      "
aLaySai[72] := "     |    ____________________________________________      |                __________________________________________            "
aLaySai[73] := "     |               (carimbo e assinatura)                 |                         (carimbo e assinatura)                       "
aLaySai[74] := "     |------------------------------------------------------|                                                                      "

Return(aLaySai)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³RetLayOut | Autor ³ William P. Alves      ³ Data ³ 05.07.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o LayOut a ser impresso                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Array com o LayOut                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum                                                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function LayOutEnt()

Local aLayEnt := Array(75)

//
//                        1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
aLayEnt[01] := "            #################### #### ############# ######                   CNPJ:   ######################################        "
aLayEnt[75] := "                                                                             ##############################################        "
aLayEnt[02] := "                                                                             ##############################################        "
aLayEnt[03] := "                                                                             Bairro: ######################################        "
aLayEnt[04] := "                                                                             Cep:    ######### ######################### ##        "           
aLayEnt[05] := "     À                                                                                                                             "
aLayEnt[06] := "     ###########################################################################                                                   "
aLayEnt[07] := "     ################################### ##################### Cep: ############                                                   "
aLayEnt[08] := "     ##################### ##                                                                                                      "
aLayEnt[09] := "                                                                                                                                   "
aLayEnt[10] := "     Prezado(s) Senhor(es): Ref.: Conferência de Documento Fiscal e Comunicação de Incorreções                                     "
aLayEnt[11] := "                                                                                                                                   "
aLayEnt[12] := "     |-----------------------------------------------------------------------------------------------------------------------|     "
aLayEnt[13] := "     |Nossa() Sua(X)        Nota Fiscal nº: ############ Série: ######                               Data: #############     |     "
aLayEnt[14] := "     |-----------------------------------------------------------------------------------------------------------------------|     "
aLayEnt[15] := "                                                                                                                                   "
aLayEnt[16] := "            Em face do que determina a legislação fiscal vigente, vimos pela presente comunicar-lhe(s) que a nota fiscal           "
aLayEnt[17] := "     em referência contém a(s) irregularidade(s) que abaixo apontamos, cuja correção solicitamos seja providenciada                "
aLayEnt[18] := "     imediatamente.                                                                                                                "
aLayEnt[19] := "                                                                                                                                   "
aLayEnt[20] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[21] := "     |Cód. | Especificação                   |Cód. | Especificação                   |Cód. | Especificação                   |     "
aLayEnt[22] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[23] := "     | 01  | Razao Social                    | 18  | Classificacao Fiscal            | 35  | Despesas Frete                  |     "
aLayEnt[24] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[25] := "     | 02  | Endereco                        | 19  | Aliquota do IPI                 | 36  | Despesas Seguro                 |     "
aLayEnt[26] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[27] := "     | 03  | Municipio                       | 20  | Valor do IPI                    | 37  | Total de Despesas Acessorias    |     "
aLayEnt[28] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[29] := "     | 04  | Estado                          | 21  | Base de Calculo do IPI          | 38  | Rasuras                         |     "
aLayEnt[30] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[31] := "     | 05  | No. de Inscr. no CNPJ/CPF       | 22  | Valor Total da Nota             | 39  | No. Nota Fiscal                 |     "
aLayEnt[32] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[33] := "     | 06  | No. de Inscr. Estadual          | 23  | Aliquota do ICMS                | 40  | Serie Errada                    |     "
aLayEnt[34] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[35] := "     | 07  | Natureza da Operacao            | 24  | Valor do ICMS                   | 41  | Local de Saida das Mercadorias  |     "
aLayEnt[36] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[37] := "     | 08  | Cod. Fiscal da Operacao         | 25  | Base de Calculo do ICMS         | 42  | Local de Entrega das Mercadorias|     "
aLayEnt[38] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[39] := "     | 09  | Via de Transporte               | 26  | Nome do Transportador           | 43  | Motivo da Devolucao             |     "
aLayEnt[40] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[41] := "     | 10  | Data da Emissao                 | 27  | End. do Transportador           | 44  | Disc. Mao de Obra Aplicada      |     "
aLayEnt[42] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[43] := "     | 11  | Data da Saida                   | 28  | Termo de Isencao do IPI         | 45  | Valor de Mao de Obra Aplicada   |     "
aLayEnt[44] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[45] := "     | 12  | Data da Entrada                 | 29  | Termo de Isencao ICMS           | 46  | Condicoes de Pagamento          |     "
aLayEnt[46] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[47] := "     | 13  | Unidade (Produto)               | 30  | Peso Bruto                      | 47  | Data de Entrega                 |     "
aLayEnt[48] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[49] := "     | 14  | Quantidade (Produto)            | 31  | Peso Liquido                    | 48  | Dec.Exig. Pelo Art207 e &&  RIPI|     "
aLayEnt[50] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[51] := "     | 15  | Descricao dos Produtos          | 23  | Marca dos Volumes               | 49  | Fatura                          |     "
aLayEnt[52] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[53] := "     | 16  | Preco Unitario                  | 33  | Numeros dos Volumes             | 50  | Outros                          |     "
aLayEnt[54] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[55] := "     | 17  | Valor Total dos Produtos        | 34  | Especies dos Volumes            |     |                                 |     "
aLayEnt[56] := "     |-----+---------------------------------+-----+---------------------------------+-----+---------------------------------|     "
aLayEnt[57] := "                                                                                                                                   "
aLayEnt[58] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLayEnt[59] := "     |Cód. |                                    Retificações a serem consideradas                                            |     "
aLayEnt[60] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLayEnt[61] := "     | ##  | #################################################################                                               |     "
aLayEnt[62] := "     |-----+-----------------------------------------------------------------------------------------------------------------|     "
aLayEnt[63] := "                                                                                                                                   "
aLayEnt[64] := "            Para evitar-se qualquer sanção fiscal, solicitamos acusarem o recebimento desta, na cópia que a acompanha,             "
aLayEnt[65] := "     devendo a via de V. S (as) ficar arquivada juntamente com a Nota Fiscal em questão.                                           "
aLayEnt[66] := "                                                                                                                                   "
aLayEnt[67] := "             Acusamos o recebimento da 1ª via                            Sem outro motivo para o momento, subscrevemo-nos          "
aLayEnt[68] := "     |------------------------------------------------------|                               Atenciosamente,                        "
aLayEnt[69] := "     |    ____________________________________________      |                                                                      "
aLayEnt[70] := "     |                    (Local e data)                    |                                                                      "
aLayEnt[71] := "     |                                                      |                                                                      "
aLayEnt[72] := "     |    ____________________________________________      |                __________________________________________            "
aLayEnt[73] := "     |               (carimbo e assinatura)                 |                         (carimbo e assinatura)                       "
aLayEnt[74] := "     |------------------------------------------------------|                                                                      "

Return(aLayEnt) 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ A185Ret  ³ Autor ³William P. Alves       ³ Data ³05.07.2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Permite a digitacao das retificacoes das irregularidades    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1: Array com as irregularidades                         ³±±
±±³          ³ExpN2: Item do Array                                        ³±±
±±³          ³ExpO3: Objeto                                               ³±±
±±³          ³ExpN4: Numero de Retificacoes Digitadas                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A185Ret(aIrrCC,nItem,oQual,nMaxRet)
                
Local aDim      := {} 
Local bValidRet := { || .T. } 
Local cRetifica := aIrrCC[nItem][3]
Local lValid    := .F. 
Local nCol      := 3 
Local nRow      := oQual:nAt
Local oOwner    := oQual:oWnd 
Local oDlg      
Local oGet1                      
Local oRect           
Local oBtn 

oRect := tRect():New(0,0,0,0)    // obtem as coordenadas da celula (lugar onde
oQual:GetCellRect(nCol,,oRect)    // a janela de edicao deve ficar)
aDim  := {oRect:nTop,oRect:nLeft,oRect:nBottom,oRect:nRight}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria uma janela invisivel para permitir a edicao do campo sobre o browse ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlg OF oOwner  FROM 0, 0 TO 0, 0 STYLE nOR( WS_VISIBLE, WS_POPUP ) PIXEL

@ 0,0 MSGET oGet1 VAR cRetifica SIZE 0,0 OF oDlg FONT oOwner:oFont PIXEL HASBUTTON 
			
oGet1:Move(-2,-2, (aDim[ 4 ] - aDim[ 2 ]) + 4, aDim[ 3 ] - aDim[ 1 ] + 4 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Botao criado para receber o foco - nao retirar                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 0,0 BUTTON oBtn PROMPT "X" SIZE 0,0 OF oDlg
oBtn:bGotFocus := {|| oDlg:nLastKey := VK_RETURN, If( lValid := ( Eval( bValidRet, cRetifica ) ), oDlg:End(0), oGet1:SetFocus() ) }

ACTIVATE MSDIALOG oDlg ON INIT oDlg:Move(aDim[1],aDim[2],aDim[4]-aDim[2], aDim[3]-aDim[1])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a listbox                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oQual:nAt := nRow
SetFocus(oQual:hWnd)
oQual:Refresh()
   
If !Empty(cRetifica) .And. Empty(aIrrCC[nItem][3])
	nMaxRet ++
	If nMaxRet > 5
		cRetifica := Space(80)
		nMaxRet --
        Help(" ",1,"A9810002") //"Permitido apenas 5 irregularidades !!!"
	Endif
ElseIf nMaxRet > 0 .And. Empty(cRetifica) .And. !Empty(aIrrCC[nItem][3])
	nMaxRet --
Endif

If lValid 
	aIrrCC[nItem][3] := cRetifica
EndIf 	

Return(.T.)         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³A185TabIrr³ Autor ³William P. Alves       ³ Data ³05/07/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Monta a tabela com as irregularidades a serem consideradas  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1: Array com as irregularidades                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A185TabIrr(aIrrCC)
         
Local nOpcA  := 0
Local nMaxRet:= 0
Local oDlg
Local oQual
Local oBold 
Local cCadastro := STR0007 //"Tabela de Irregularidades"

dbSelectArea("SX5")
dbSetOrder(1)
MsSeek(xFilial("SX5")+"CC")

While !Eof() .And. SX5->X5_FILIAL == xFilial("SX5") .And. SX5->X5_TABELA == "CC" 
	AADD( aIrrCC,{AllTrim(SX5->X5_CHAVE),SX5->X5_DESCRI,Space(80)})
	dbSkip()
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Montagem da janela de exibicao                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aIrrCC) > 0 
	
	DEFINE MSDIALOG oDlg TITLE CCADASTRO FROM 0,0 TO 290,550 OF oMainWnd	PIXEL 

	DEFINE FONT oBold NAME "Arial" SIZE 0, -13 BOLD
	
	@ 14, 10 TO 16 ,272 LABEL '' OF oDlg PIXEL
	@ 03, 10 SAY "Digite as Retificações a serem consideradas : " FONT oBold PIXEL //"Digite as Retificações a serem consideradas : "
	
	@ 020,010 LISTBOX oQual VAR cVarQ ;
	FIELDS HEADER OemToAnsi("Código"),OemToAnsi("Especificação"), OemToAnsi("Retificação") ; //"Código"  "Especificação"   "Retificação"
	SIZE 260,100 ; 
	ON DBLCLICK (If(A185Ret(@aIrrCC,oQual:nAt,oQual,@nMaxRet),oQual:Refresh(),oDlg:End())) NOSCROLL PIXEL
		
	oQual:SetArray(aIrrCC)
	oQual:bLine := { || {aIrrCC[oQual:nAT,1],aIrrCC[oQual:nAT,2],aIrrCC[oQual:nAT,3]}}

	DEFINE SBUTTON FROM 127,210 TYPE 1 ACTION (nOpcA := oQual:nAt,oDlg:End()) ENABLE OF oDlg PIXEL

	DEFINE SBUTTON FROM 127,243 TYPE 2 ACTION (oDlg:End()) ENABLE OF oDlg		
	
	ACTIVATE MSDIALOG oDlg CENTERED
Else
	Help(" ",1,"A9810003") //Tabela de Irregularidas nao encontrada
Endif

Return(nOpcA)




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   



//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  

