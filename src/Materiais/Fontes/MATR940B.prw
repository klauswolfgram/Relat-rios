/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "protheus.ch" 
#include "Rwmake.ch" 
#include "matr940b.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MATR940B 	º Autor ³ Luana Ferrari      º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio demonstrativo de estoque para empresas sujeitas  º±±
±±º          ³ ao regime de substituicao tributaria.					  º±±
±±º          ³ Baseado no mata940 - Sintegra 							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß                          
/*/
User Function MATR940B()
Local cDesc1        := STR0001
Local cDesc2        := STR0002
Local cDesc3        := STR0003
Local titulo        := STR0004
Local nLin          := 80
Local Cabec1		:= STR0007
Local Cabec2       	:= ""
Local imprime      	:= .T.
Local aOrd        	:= {}
Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt      	:= ""
Private limite     	:= 80
Private tamanho    	:= "G"
Private nomeprog   	:= "MATR940B" 
Private nTipo      	:= 18
Private aReturn   	:= { STR0005, 1, STR0006, 2, 2, 1, "", 1}
Private nLastKey   	:= 0
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= nomeprog 
Private cPerg      	:= "MTR94B"
Private cString    	:= "SFT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ajusta perguntas do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Set Device To Screen
If aReturn[5]==1
   dbCommitAll()
   Set Printer To
   OurSpool(wnrel)
Endif
MS_FLUSH()

Return()

                                                                                                                                                                                            /*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ Luana Ferrari      º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local cAliasSB1		:= ""

Local aSld			:=	{}       
Local aPrec			:=	{}
Local aUltVend      :=  {}
Local aFilsCalc     := {}

Local dDtcorte		:= ctod("//")                   
Local dDtcorte1		:= ctod("//")

Local nForFilial    := 0                                                               

aFilsCalc := MatFilCalc(mv_par07 == 1,,,mv_par08 == 1,,Iif(mv_par08 == 1,2,0))
If Empty( aFilsCalc )
	Return
Endif

For nForFilial := 1 to Len( aFilsCalc )
	If aFilsCalc[nForFilial,1]
	
		cFilAnt   := aFilsCalc[nForFilial][2]
		nLin      := 80  // faz a quebra de pagina por filial 
		SM0->(DbSeek(cEmpAnt+cFilAnt))
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Monta arquivo temporario³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MontTrab()    
	
	 	DbSelectArea("SB1")
		SB1->(DbSetOrder (1)) 
		
		#IFDEF TOP
		If (TcSrvType ()<>"AS/400")
			cAliasSB1	:=	GetNextAlias()   		   	
			BeginSql Alias cAliasSB1    	
					SELECT SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_LOCPAD, SB1.B1_TIPO, SB1.B1_DESC, SB1.B1_DTCORTE, SB1.B1_POSIPI, SB1.B1_CODBAR, SB1.B1_PICMENT, SB1.B1_UM
					FROM 
						%Table:SB1% SB1 
					WHERE 
						SB1.B1_FILIAL=%xFilial:SB1% AND 
						SB1.B1_DTCORTE >= %Exp:DToS (MV_PAR01)% AND
						SB1.B1_DTCORTE <= %Exp:DToS (MV_PAR02)% AND   
						SB1.B1_COD     >= %Exp:mv_par05% 	AND
						SB1.B1_COD     <= %Exp:mv_par06% 	AND						
						SB1.%NotDel%					               
					ORDER BY B1_DESC		
				EndSql
		Else
		#ENDIF
			cIndex	:= CriaTrab(NIL,.F.)
			cFiltro	:= 'B1_FILIAL == "'+xFilial ("SB1")+" .AND. ' 
			cFiltro	:= 'B1_DTCORTE>="'+DTOS (MV_PAR01)+'" AND SF3.F3_EMISSAO<="'+DTOS (MV_PAR02)+'" AND "
			cFitro	:= 'B1_COD >= "'+mv_par05+'".And.B1_COD <="'+mv_par06+'"'  

			IndRegua (cAliasSB1, cIndex, SB1->(IndexKey ()),, cFiltro)
			nIndex := RetIndex(cAliasSB1)
			#IFNDEF TOP
				DbSetIndex (cIndex+OrdBagExt ())
			#ENDIF			
			DbSelectArea (cAliasSB1)
			DbSetOrder (nIndex)
		#IFDEF TOP
		Endif
		#ENDIF		

		DbSelectArea (cAliasSB1)
		(cAliasSB1)->(DbGoTop ())
		ProcRegua ((cAliasSB1)->(RecCount ()))

		While !(cAliasSB1)->(Eof())     
			dDtcorte  := ctod(substr((cAliasSB1)->B1_DTCORTE,7,2)+"/"+substr((cAliasSB1)->B1_DTCORTE,5,2)+"/"+substr((cAliasSB1)->B1_DTCORTE,1,4))   
			dDtcorte1 := dDtcorte -1
			cCodpro	  := (cAliasSB1)->B1_COD
			aUltVend  := UltVend(dDtcorte1,cCodPro)  	 			
			aPrec     := UltComp(dDtcorte1,cCodPro)
			aSld      := CalcEst(cCodpro,(cAliasSB1)->B1_LOCPAD, dDtcorte)   
			DbSelectArea("TRB2")
			Reclock("TRB2",.T.)
			TRB2->NBM 		:=	(cAliasSB1)->B1_POSIPI
			TRB2->EAN		:=	(cAliasSB1)->B1_CODBAR       
			TRB2->CODPRO	:=	(cAliasSB1)->B1_COD
			TRB2->UM		:=	(cAliasSB1)->B1_UM
			TRB2->DESC 		:=	(cAliasSB1)->B1_DESC
			TRB2->QTD      	:= 	aSld[1] //Saldo em estoque um dia antes da alteracao regime tributacao
			TRB2->VLRUNIT  	:= 	aPrec[1,1] // Valor unitario ultima nota de entrada antes da alteração regime tributação
			TRB2->VLRTOT    :=	TRB2->VLRUNIT*TRB2->QTD
			TRB2->MVA 		:=	(cAliasSB1)->B1_PICMENT
			TRB2->BSICMST  	:= 	aPrec[1,4]
			TRB2->ALIQ		:= 	aUltVend[1,6]
			TRB2->ICMSTTO  	:= 	aPrec[1,4] * aUltVend[1,6] / 100  // Valor base ICMS * Aliquota
			TRB2->DTCORTE  	:= 	dtoc(dDtcorte)
			TRB2->CNPJFIL  	:= 	SM0->M0_CGC
			TRB2->(MsUnLock())
			(cAliasSB1)->(DbSkip())
		EndDo
                                         
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciona tabela temporaria³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		TRB2->(DbSelectArea("TRB2"))
		TRB2->(dbGoTop())
		ProcRegua(TRB2->(RecCount()))
		TRB2->(DbGotop())
		If TRB2->(EOF())
			MsgBox(STR0010) 
			TRB2->(DbCloseArea())
			Return()
		EndIf
	
		TRB2->(DbGotop())
		While !TRB2->(Eof())
			IncProc()
			If lAbortPrint
				@nLin,00 PSAY STR0011
				Exit
			Endif
			
			If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
				Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin := 8
			Endif
	
		   	//Cod. NCM    Cod.EAN13        Cod.Próprio                     Un. Descrição                        Quantidade      VLUnitário       Vl. Total    MVA  Base de Cálculo  Alíquota       Vl.ICMS  Dt.Corte    CNPJ Filial
		   	//xxxxxxxxxx  xxxxxxxxxxxxxxx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xx  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  xxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxxxxxxxxxxx  xxxxx   xxxxxxxxxxxxxx     xxxxx  xxxxxxxxxxxx  xx/xx/xxxx  NN.NNN.NNN/NNNN-99
	
			@ nLin, 000			Psay TRB2->NBM
			@ nLin, PCOL() + 2	PSay TRB2->EAN
			@ nLin, PCOL() + 2	PSay substr(TRB2->CODPRO,1,30)
			@ nLin, PCOL() + 2	PSay TRB2->UM
			@ nLin, PCOL() + 2	PSay TRB2->DESC
			@ nLin, PCOL() + 2	PSay Transform(TRB2->QTD				,"@E 99999999.99")
			@ nLin, PCOL() + 2	PSay Transform(TRB2->VLRUNIT			,"@E 999,999,999.99") 
		  	@ nLin, PCOL() + 2	PSay Transform(TRB2->VLRTOT				,"@E 999,999,999.99") 
			@ nLin, PCOL() + 2	PSay Transform(TRB2->MVA				,"@E 99.99")	
			@ nLin, PCOL() + 3	PSay Transform(TRB2->BSICMST			,"@E 999,999,999.99")
			@ nLin, PCOL() + 5	PSay Transform(TRB2->ALIQ	   			,"@E 99.99")	
			@ nLin, PCOL() + 2	PSay Transform(TRB2->ICMSTTO   			,"@E 9,999,999.99")
			@ nLin, PCOL() + 2	PSay TRB2->DTCORTE
			@ nLin, PCOL() + 2	PSay TransForm(TRB2->CNPJFIL   			,"@R! NN.NNN.NNN/NNNN-99")			
			nLin ++
		
			TRB2->(DbSkip())
		EndDo

		TRB2->(DbSelectArea("TRB2"))
		TRB2->(DbCloseArea())
	
	EndIf
Next nForFilial

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MontTrab  ºAutor  ³Luana Ferrari       º Data ³  05/10/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta tabela temporaria 							          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MontTrab()
Local aDbf := {}
Local nTamPrd := TamSx3("B1_COD")[1]                                              

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta tabela temporaria³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd( aDbf, { "NBM"    	,"C"  	,10     ,0 } )
aAdd( aDbf, { "EAN"  	,"C"  	,15		,0 } )
aAdd( aDbf, { "CODPRO"	,"C"  	,nTamPrd,0 } )
aAdd( aDbf, { "UM"     	,"C"  	,02     ,0 } )
aAdd( aDbf, { "DESC"  	,"C"  	,30		,0 } )
aAdd( aDbf, { "QTD" 	,"N"  	,11		,2 } )
aAdd( aDbf, { "VLRUNIT"	,"N"  	,14		,2 } )
aAdd( aDbf, { "VLRTOT" 	,"N"  	,14		,2 } )
aAdd( aDbf, { "MVA"    	,"N"  	,05		,2 } )
aAdd( aDbf, { "BSICMST"	,"N"  	,14		,2 } )  
aAdd( aDbf, { "ALIQ"  	,"N"	,05		,2 } )
aAdd( aDbf, { "ICMSTTO"	,"N"  	,14		,2 } )     
aAdd( aDbf, { "DTCORTE"	,"C"  	,10		,0 } )     
aAdd( aDbf, { "CNPJFIL"	,"C"  	,14		,0 } )     
TRB2 := CriaTrab( aDbf, .t. )
dbUseArea(.T.,,TRB2,"TRB2",.F.,.F.)
dbSelectArea('TRB2')
cKey   := "CODPRO"
cCond  := ""
cIndex := CriaTrab(NIL,.F.)
IndRegua( "TRB2" ,cIndex ,cKey ,,cCond ,"Indexando Arq.Temporario")
Return()                                                       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UltComp   ºAutor  ³Luana Ferrari       º Data ³  30/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a ultima compra de um produto a partir de uma data  º±±
±±º          ³de fechamento de estoque.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MATR940B                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function UltComp(dDtcorte,cCodpro)
Local nPreco		:= 0
Local cAliasSD1		:= "SD1"   
Local aUltNF		:= {}
Local aArea			:= GetArea()
Local nVlICMS		:= 0
Local nCoeRed		:= 0
Local nBasICMS		:= 0

#IFDEF TOP
	Local cQuery   		:= "" 
	Local aStruSD1 		:= {}
	Local nX	   		:= 0
#ELSE
	Local cIndex		:= ""
	Local cCondicao		:= ""  
	Local cKey			:= "" 
	Local nIndex		:= 0              
#ENDIF

SD2->(dbSetOrder(1))

#IFDEF TOP
   If TcSrvType()<>"AS/400"
		cAliasSD1 := GetNextAlias()
		aStruSD1  := SD1->(dbStruct())
		cQuery := "SELECT D1_VUNIT, D1_VALIPI, D1_VALFRE, D1_SEGURO, D1_DESPESA, D1_QUANT, D1_DOC, D1_DTDIGIT, D1_PICM, D1_VALICM, D1_BRICMS"
		cQuery += "FROM " + RetSqlName("SD1") + " "
		cQuery += "WHERE D1_FILIAL='" + xFilial("SD1") + "' AND "
		cQuery += "D1_COD = '" + cCodpro + "' AND "
		cQuery += "D1_DTDIGIT <= '" + Dtos(dDtcorte) + "' AND "
		cQuery += "D_E_L_E_T_ = ' ' "
		cQuery += "ORDER BY D1_DTDIGIT DESC "
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSD1)
		For nX := 1 To len(aStruSD1)
			If aStruSD1[nX][2] <> "C" .And. FieldPos(aStruSD1[nX][1])<>0
				TcSetField(cAliasSD1,aStruSD1[nX][1],aStruSD1[nX][2],aStruSD1[nX][3],aStruSD1[nX][4])
			EndIf
		Next nX
		dbSelectArea(cAliasSD1)	
	Else
#ENDIF
		cIndex    	:= CriaTrab(NIL,.F.)
		cKey		:= 'dtos(D1_DTDIGIT)'
		cCondicao 	:= 'D1_FILIAL=="'+xFilial("SD1")+'".And.'
		cCondicao 	+= 'D1_COD == "' + cCodProd+'".And.'
		cCondicao 	+= 'DTOS(D1_DTDIGIT)<="'+DTOS(dDtcorte)+'"'
		IndRegua(cAliasSD1,cIndex,SD1->(IndexKey()),,cCondicao)
		nIndex := RetIndex("SD1")
		#IFNDEF TOP
			dbSetIndex(cIndex+OrdBagExt())
		#ENDIF
		dbSelectArea("SD1")
		dbSetOrder(nIndex+1)
		dbSelectArea(cAliasSD1)
		dbGoBottom()
#IFDEF TOP
	Endif    
#ENDIF

nPreco   := Round((cAliasSD1)->(D1_VUNIT + (((cAliasSD1)->(D1_VALIPI + D1_VALFRE + D1_SEGURO + D1_DESPESA)) / (cAliasSD1)->D1_QUANT)) ,2)
nVlICMS  := Round((cAliasSD1)->(D1_QUANT * D1_VUNIT * D1_PICM / 100),2) //Valor do ICMS sem redução
nCoeRed  := Round((cAliasSD1)->D1_VALICM / nVlICMS,2) //Coeficiente de redução da base
nBasICMS := (cAliasSD1)->D1_BRICMS * nCoeRed //Base do icms st

aadd(aUltNF,{nPreco,;
	(cAliasSD1)->D1_DOC,;
	(cAliasSD1)->D1_PICM,;
	nBasICMS,;
	0})

#IFDEF TOP
	dbSelectArea(cAliasSD1)
	dbCloseArea()
#ELSE
	dbSelectArea(cAliasSD1)
	RetIndex(cAliasSD1)
	Ferase(cIndex+OrdBagExt())
#ENDIF
RestArea(aArea)
Return aUltNF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UltVend   ºAutor  ³Luccas Curcio       º Data ³  17/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a ultima venda de um produto a partir de uma data   º±±
±±º          ³de fechamento de estoque.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MATR940B                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function UltVend(dDtCorte,cCodPro)

Local cAlias		:= "SD2" 

Local nPreco		:= 0
Local nVlICMS		:= 0
Local nCoeRed		:= 0
Local nBasICMS		:= 0
Local nAliqICMS     := 0

Local aUltNF		:= {}
Local aArea			:= GetArea()


DbSelectArea(cAlias)
(cAlias)->(DbSetOrder(1))
#IFDEF TOP
	If TcSrvType()<>"AS/400"
		cAlias := GetNextAlias()
		
		BeginSql alias cAlias
			SELECT 	D2_TOTAL, D2_VALICM, D2_PICM, D2_DOC, D2_SERIE, D2_EMISSAO, D2_PRUNIT, D2_BASEICM, D2_VALIPI, D2_DESPESA, D2_VALFRE, D2_QUANT, D2_SEGURO
			FROM %table:SD2% SD2 
			WHERE   SD2.D2_FILIAL   = %xfilial:SD2%  			AND
					SD2.D2_COD 		= %exp:cCodPro%  			AND
	                SD2.D2_EMISSAO  <= %exp:DToS (dDtCorte)%  	AND
					SD2.%notDel%
			ORDER BY D2_EMISSAO DESC     
		EndSql
	Else
#ENDIF
    
    cIndex   	:= CriaTrab(NIL,.F.)
	cKey		:= 'dtos(D2_EMISSAO)'
	cCondicao 	:= 'D2_FILIAL=="'+xFilial("SD2")+'".And.'
	cCondicao 	+= 'D2_COD == "' + cCodPro+'".And.'
	cCondicao 	+= 'DTOS(D2_EMISSAO)<="'+DTOS(dDtcorte)+'"'
    IndRegua(cAliasSD1,cIndex,SD1->(IndexKey()),,cCondicao)
	nIndex := RetIndex("SD2")
    
    #IFNDEF TOP
		DbSetIndex (cIndex+OrdBagExt ())
	#ENDIF
	
	DbSelectArea (cAlias)
	DbSetOrder (nIndex+1)
#IFDEF TOP
	Endif
#ENDIF

While !(cAlias)->(Eof ()) .And. (cAlias)->D2_PICM == 0
	(cAlias)->(DbSkip())
	Loop
End 

If (cAlias)->(Eof()) .And. (cAlias)->D2_PICM == 0
	nPreco   := 0//valor unitário
	nCoeRed  := 0 //Coeficiente de redução da base
	nVlICMS  := 0 //Valor do ICMS com redução
	nBasICMS := 0 //Base do icms st
	nAliqICMS:= 0 //Aliquota com redução
Else
	nPreco   := (cAlias)->(D2_PRUNIT + (((cAlias)->(D2_VALIPI + D2_VALFRE + D2_SEGURO + D2_DESPESA)) / (cAlias)->D2_QUANT))//valor unitário
	nCoeRed  := (cAlias)->D2_BASEICM / (cAlias)->D2_TOTAL * 100 //Coeficiente de redução da base
	nBasICMS := (cAlias)->D2_TOTAL * nCoeRed / 100 //Base do icms st
	nVlICMS  := (nBasICMS * (cAlias)->D2_PICM / 100) //Valor do ICMS com redução
	nAliqICMS:= (cAlias)->D2_PICM * nCoeRed / 100// Aliquota com redução
Endif

aadd(aUltNF,{nPreco,; //Valor unitário
			(cAlias)->D2_DOC,; //Documento
			(cAlias)->D2_PICM,; //Aliquota ICMS
			nBasICMS,; //Base do ICMS com redução
			nVlICMS,;//Valor do ICMS com redução
			nAliqICMS})//Aliquota com redução 

#IFDEF TOP
	dbSelectArea(cAlias)
	dbCloseArea()
#ELSE
	dbSelectArea(cAlias)
	RetIndex(cAlias)
	Ferase(cIndex+OrdBagExt())
#ENDIF
RestArea(aArea)
Return aUltNF

