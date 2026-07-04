/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "pcor015.ch"
#INCLUDE "PROTHEUS.CH"

#DEFINE CELLTAMDATA 420
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ PCOR015  ³ AUTOR ³ Reynaldo Tetsu Miyashita ³ DATA ³ 20-01-2004 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Programa de impressao da planilha orcamentaria.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ USO      ³ SIGAPCO                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³_DOCUMEN_ ³ PCOR015                                                         ³±±
±±³_DESCRI_  ³ Programa de impressao da planilha orcamentaria.                 ³±±
±±³_FUNC_    ³ Esta funcao devera ser utilizada com a sua chamada normal a     ³±±
±±³          ³ partir do Menu do sistema.                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PCOR015(aPerg)
Local aArea	:= GetArea()
Local lOk	:= .F.
Local oPrint
Local nRecAK1

Private nLin	:= 200
Private cRevisa

//OBSERVACAO NAO TIRAR A LINHA ABAIXO POIS SERA UTILIZADA NA CONSULTA PADRAO AKE1
Private M->AKR_ORCAME := Replicate("Z", Len(AKR->AKR_ORCAME))     
Private _aEntids := {}


Default aPerg := {}  

CN15PrepList()

// inicializa o oPrint
If Len(aPerg) == 0 
	oPrint := PcoPrtIni(STR0001+STR0017,.T.,2,,@lOk,"PCR015",STR0015) //"Planilha Orcamentaria (Mod.2)"###" - Novas Entidades"###"Este relatorio apresentara todos os itens orcamentarios referente as contas da planilha solicitada."
Else
	aEval(aPerg, {|x, y| &("MV_PAR"+StrZero(y,2)) := x})  
	oPrint := PcoPrtIni(STR0001+STR0017,.T.,2,,@lOk,"",STR0015) //"Planilha Orcamentaria (Mod.2)"###"Este relatorio apresentara todos os itens orcamentarios referente as contas da planilha solicitada."
EndIf

If lOk
	dbSelectArea("AK1")
	dbSetOrder(1)
	If MSSeek(xFilial()+MV_PAR01)
	   	If !Empty(MV_PAR02)
	   		dbSelectArea("AKE")
	   		dbSetOrder(1)
	   		If ! MSSeek(xFilial()+MV_PAR01+MV_PAR02)
	   			MsgStop(STR0016)  // Revisao nao encontrada. Verifique!
	   			lOk := .F.
	   		Else
	   			cRevisa := MV_PAR02
	   		EndIf
	   		dbSelectArea("AKE")
	   	Else			
	      While AK1->(! Eof() .And. AK1_FILIAL+AK1_CODIGO == xFilial("AK1")+MV_PAR01)
			cRevisa	:= AK1->AK1_VERSAO
			nRecAK1 := AK1->(Recno())
	        AK1->(dbSkip())
	      End
	      AK1->(dbGoto(nRecAK1))
	   	EndIf      
		
		If lOk	   
			RptStatus( {|lEnd| PCOR015Imp(@lEnd,oPrint)})
		EndIf		   
	EndIf                                                          
		
    PcoPrtEnd(oPrint)
    	
EndIf

Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR015Imp³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³20-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR015Imp(lEnd)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd - Variavel para cancelamento da impressao pelo usuario   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PCOR015Imp(lEnd ,oPrint)
Local aPeriodo 		:= {}
Local lDescricao	:= .T.
Local nTam			:= 0
Local nX
    
// obtem os periodos
aPeriodo := PCO015CalcPer( AK1->AK1_TPPERI ,AK1->AK1_INIPER ,AK1->AK1_FIMPER )	

aNovPer := {}   
For nX := 1 TO Len(aPeriodo)
	If aPeriodo[nX] >= mv_par03 .And. aPeriodo[nX] <= mv_par04
		aAdd(aNovPer, aPeriodo[nX])
	EndIf
Next

aPeriodo := AClone(aNovPer)

If Empty(aNovPer)
    HELP("  ",1,"PCOR0151")
EndIf

While ! Empty(aPeriodo)
	
	aNovPer := {}   
	aColDescr := {}
	nLin := 200
	If lDescricao
		nTam := 2150
	Else
		nTam := 20
	Endif
	
	While ((nTam+CELLTAMDATA)<=3100)
		If empty(aPeriodo)
			Exit
		Endif			
		aAdd( aNovPer ,aPeriodo[1])
		aDel( aPeriodo ,1)
		aSize( aPeriodo ,len(aPeriodo)-1)
		nTam += CELLTAMDATA
	End 
	
	// monta cabecalho principal
	PcoPrtCab(oPrint)
	PcoPrtCol({20,370,470,2075,2250})	
	PcoPrtCell(PcoPrtPos(1),nLin,PcoPrtTam(1),60,AK1->AK1_CODIGO,oPrint,4,2,/*RgbColor*/,STR0002) //"Codigo"
	PcoPrtCell(PcoPrtPos(2),nLin,PcoPrtTam(2),60,cRevisa,oPrint,4,2,/*RgbColor*/,STR0003) //"Versao"
	PcoPrtCell(PcoPrtPos(3),nLin,PcoPrtTam(3),60,AK1->AK1_DESCRI,oPrint,4,2,/*RgbColor*/,STR0004) //"Descricao"
	PcoPrtCell(PcoPrtPos(4),nLin,PcoPrtTam(4),60,DTOC(AK1->AK1_INIPER),oPrint,4,2,/*RgbColor*/,STR0005) //"Dt.Inicio"
	PcoPrtCell(PcoPrtPos(5),nLin,PcoPrtTam(5),60,DTOC(AK1->AK1_FIMPER),oPrint,4,2,/*RgbColor*/,STR0006) //"Dt.Fim"
	nLin+=70
	
	aTamCols := {}
	If lDescricao
		aColDescr := {STR0007 ,STR0008 ,STR0004 ,STR0009 ,"" } //"C.O."###"Nivel"###"Descricao"###"Tipo"
		aTamCols := {20,370,470,2050,2200}
	Else
		aColDescr := {"" }
		aTamCols := {20}
	Endif	
	PcoPrtCol(aTamCols)
	PCOR015TitCol( @oPrint ,aColDescr )
	
	dbSelectArea("AK3")
	dbSetOrder(3)
	MsSeek(xFilial()+AK1->AK1_CODIGO+cRevisa+"001")
	While !Eof() .And. 	AK3_FILIAL+AK3_ORCAME+AK3_VERSAO+AK3_NIVEL==;
						xFilial("AK3")+AK1->AK1_CODIGO+cRevisa+"001"
		// Dados da classe orcamentaria
		PCOR015CO( AK3_ORCAME ,AK3_VERSAO ,AK3_CO ,	aNovPer ,aTamCols ,@oPrint ,lDescricao ,aColDescr ,aTamCols )
		dbSelectArea("AK3")
		dbSkip()
	End 
	lDescricao := .F.
End
	
Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR015CO ³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³20-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria do Centro         ³±±
±±³          ³orcamentario.                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR015CO( cOrcame,cVersao,cCO,aPeriodo,aTamanho,oPrint        ³±±
±±³          ³          ,lDescricao,aColDescr )                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cOrcame    - Orcamento                                        ³±±
±±³          ³ cVersao    - Versao do Orcamento                              ³±±
±±³          ³ cCO        - Conta Orcamentaria                               ³±±
±±³          ³ aPeriodo   - Datas do periodo                                 ³±±
±±³          ³ aTamanho   - Tamanho das colunas                              ³±±
±±³          ³ oPrint     - objeto TMSPrinter                                ³±±
±±³          ³ lDescricao - Se existe coluna de descricao na pagina atual    ³±±
±±³          ³ aColDescr  - Cabecalho das colunas                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PCOR015CO( cOrcame ,cVersao ,cCO ,aPeriodo ,aTamanho ,oPrint ,lDescricao ,aColDescr )

Local aArea		:= GetArea()
Local aAreaAK2	:= AK2->(GetArea())
Local aAreaAK3	:= AK3->(GetArea())
    
	If AK3_NIVEL =="001" .OR. ;
		(AK3->AK3_CO >= mv_par05 .And. AK3->AK3_CO <= mv_par06 .And. ;
		PcoChkUser(cOrcame, cCO, AK3->AK3_PAI, 1, "ESTRUT", cVersao))

		PcoPrtCol(aTamanho)
		If PcoPrtLim(nLin)
			nLin := 200
			PcoPrtCab(oPrint)
			PcoPrtCol(aTamanho)
			PCOR015TitCol( @oPrint ,aColDescr )
		EndIf
		
		If lDescricao
			PcoPrtCell(PcoPrtPos(1),nLin,,60,PcoRetCo(AK3->AK3_CO),oPrint,1,3)
			PcoPrtCell(PcoPrtPos(2),nLin,,60,AK3->AK3_NIVEL,oPrint,1,3)
			PcoPrtCell(PcoPrtPos(3),nLin,,60,SPACE((VAL(AK3->AK3_NIVEL)-1)*3)+AK3->AK3_DESCRI,oPrint,1,3)
			If AK3->AK3_TIPO $ " ;1"
				PcoPrtCell(PcoPrtPos(4),nLin,,60,STR0010,oPrint,1,3) //"Sintetica"
			Else
				PcoPrtCell(PcoPrtPos(4),nLin,,60,STR0011,oPrint,1,3) //"Analitica"
			EndIf
		Else
			PcoPrtCell(PcoPrtPos(1),nLin,,60,"",oPrint,1,3)
		EndIf
		nLin+= 70
		
		// itens da conta orcamentaria
		PCOR015COIt( cOrcame ,cVersao ,cCO ,aPeriodo ,aTamanho ,@oPrint ,lDescricao ,aColDescr )
	EndIf
	
	dbSelectArea("AK3")
	dbSetOrder(2)
	MsSeek(xFilial()+cOrcame+cVersao+cCO)
	While !Eof() .And. AK3->AK3_FILIAL+AK3->AK3_ORCAME+AK3->AK3_VERSAO+AK3->AK3_PAI==xFilial("AK3")+cOrcame+cVersao+cCO
		// Conta orcamentaria
		PCOR015CO( AK3_ORCAME ,AK3_VERSAO ,AK3_CO ,	aPeriodo ,aTamanho ,@oPrint ,lDescricao ,aColDescr )
		dbSelectArea("AK3")
		dbSkip()
	End
	
	RestArea(aAreaAK2)
	RestArea(aAreaAK3)
	RestArea(aArea)
	
Return( NIL )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR015COIt ³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³20-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao de impressao da planilha orcamentaria da classe           ³±±
±±³          ³orcamentaria.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR015COIt( cOrcame,cVersao,cCO,aPeriodo,aTamanho,oPrint        ³±±
±±³          ³            ,lDescricao ,aColDescr )                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cOrcame    - Orcamento                                          ³±±
±±³          ³ cVersao    - Versao do Orcamento                                ³±±
±±³          ³ cCO        - Conta Orcamentaria                                 ³±±
±±³          ³ aPeriodo   - Datas do periodo                                   ³±±
±±³          ³ aTamanho   - Tamanho das colunas                                ³±±
±±³          ³ oPrint     - objeto TMSPrinter                                  ³±±
±±³          ³ lDescricao - Se existe coluna de descricao na pagina atual      ³±±
±±³          ³ aColDescr  - Cabecalho das colunas                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PCOR015COIt( cOrcame ,cVersao ,cCO ,aPeriodo ,aTamanho ,oPrint ,lDescricao ,aColDescr )

Local aArea			:= GetArea()
Local aAreaAK2		:= AK2->(GetArea())    
Local aAuxArea 		:= {}
Local cDescricao	:= ""
Local cUM 			:= ""  
Local aClassDescr	:= {}
Local aClassTam		:= {}
Local nX 			:= 0
Local nCol 			:= 150 //200
Local lTitle
Local cDesCla       := Space(Len(AK6->AK6_DESCRI)) 

	If lDescricao		
		aClassDescr := {STR0012 ,STR0004 ,STR0013,"UM",STR0014 } //"Classe Orc."###"Descricao"###"Identificador"###"Operacao"
		//aClassTam	:= {200 ,370 ,1160 ,1950 ,2050 }
		aClassTam	:= {150 ,320 ,1110 ,1900 ,2000 }
		nCol := 2250
	Endif
	
	For nX := 1 To len(aPeriodo)
		aadd( aClassDescr ,DTOC(aPeriodo[nX]) )
		aAdd( aClassTam	,nCol )
		nCol+=CELLTAMDATA
	Next nX
	
	dbSelectArea("AK2")
	dbSetOrder(1)
	
	If MsSeek(xFilial()+cOrcame+cVersao+cCO+DTOS(aPeriodo[1]))
        lTitle := .T.
        
       	While AK2->AK2_FILIAL+AK2->AK2_ORCAME+AK2->AK2_VERSAO+AK2->AK2_CO+DTOS(AK2->AK2_PERIOD)== xFilial()+cOrcame+cVersao+cCO+DTOS(aPeriodo[1])
	    
		    If ( AK2->AK2_CLASSE >= mv_par07 .And. AK2->AK2_CLASSE <= mv_par08) .And. ;
				(AK2->AK2_OPER >= mv_par09 .And. AK2->AK2_OPER <= mv_par10 .And. AK2->AK2_VALOR != 0 .And. ; 
				PcoCC_User(cOrcame, cCO, AK3->AK3_PAI, 2, "CCUSTO", cVersao, AK2->AK2_CC) .And. ;
				PcoIC_User(cOrcame, cCO, AK3->AK3_PAI, 2, "ITMCTB", cVersao, AK2->AK2_ITCTB) .And. ;
		  		PcoCV_User(cOrcame, cCO, AK3->AK3_PAI, 2, "CLAVLR", cVersao, AK2->AK2_CLVLR) .And. ;	
		  		CN15VrfUniorc() .And. ;
		  		CN15VerEntidade() )	    
  		        
			    If lTitle
			    	PcoPrtCol( aClassTam )
					PCOR015TitCol( @oPrint ,aClassDescr )
					lTitle := .F.
	            EndIf
	            
				PcoPrtCol( aClassTam )
				If PcoPrtLim(nLin)
					nLin := 200
					PcoPrtCab(oPrint) 
					PcoPrtCol( aTamanho )			
					PCOR015TitCol( @oPrint ,aColDescr )
					PcoPrtCol( aClassTam )
					PCOR015TitCol( @oPrint ,aClassDescr )
				
				EndIf
				
				If lDescricao
					
					If !Empty(AK2->AK2_CHAVE)
						aAuxArea := GetArea()
						AK6->(dbSetOrder(1))
						AK6->(dbSeek(xFilial()+AK2->AK2_CLASSE))
						If !Empty(AK6->AK6_VISUAL)
							dbSelectArea(Substr(AK2->AK2_CHAVE,1,3))
							dbSetOrder(Val(Substr(AK2->AK2_CHAVE,4,2)))
							dbSeek(Substr(AK2->AK2_CHAVE,6,Len(AK2->AK2_CHAVE)))
							cDescricao := alltrim(&(AK6->AK6_VISUAL))						
							cUM := allTrim(&(AK6->AK6_UM))
						Else
							cDescricao:= ""
							cUM := ""    
						EndIf
						RestArea(aAuxArea)
						
					EndIf                 
					
					cDescCla := Posicione("AK6", 1, xFilial("AK6")+AK2->AK2_CLASSE, "AK6_DESCRI")

					PcoPrtCell(PcoPrtPos(1),nLin,,60,AK2->AK2_CLASSE ,oPrint,1,3)			
					PcoPrtCell(PcoPrtPos(2),nLin,,60,cDescCla,oPrint,1,3)			
					PcoPrtCell(PcoPrtPos(3),nLin,,60,cDescricao ,oPrint,1,3)			
					PcoPrtCell(PcoPrtPos(4),nLin,,60,cUM ,oPrint,1,3)
					PcoPrtCell(PcoPrtPos(5),nLin,,60,AK2->AK2_OPER ,oPrint,1,3)
					PCO015ValPer( cOrcame ,cVersao ,cCO ,aPeriodo ,AK2->AK2_ID ,@oPrint ,5 )
				Else
					PCO015ValPer( cOrcame ,cVersao ,cCO ,aPeriodo ,AK2->AK2_ID ,@oPrint )
				Endif
				// avanco de linha
				nLin+=30
			EndIf
		AK2->(dbSkip())
		End

		// avanco de linha
		nLin+=60
	EndIf
	RestArea(aAreaAK2)
	RestArea(aArea)
	
Return( NIL ) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCOR015TitCol ³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³2!-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Titulo das colunas do relatorio                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCOR015TitCol( oPrint ,aColDescr )                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oPrint  - objeto TMSPrinter                                       ³±±
±±³          ³ aColDescr  - Cabecalho das colunas                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PCOR015TitCol( oPrint ,aColDescr )
Local nX := 0

	For nX := 1 To len(aColDescr)
		PcoPrtCell(PcoPrtPos(nX),nLin,PcoPrtTam(nX),30,aColDescr[nX],oPrint,2,1,RGB(230,230,230))
	Next nX                       
	
	//PcoPrtCell(PcoPrtPos(2),nLin,PcoPrtTam(2),30,"Nivel",oPrint,2,1,RGB(230,230,230))
	//PcoPrtCell(PcoPrtPos(3),nLin,PcoPrtTam(3),30,"Descricao",oPrint,2,1,RGB(230,230,230))
	//PcoPrtCell(PcoPrtPos(4),nLin,PcoPrtTam(4),30,"Tipo",oPrint,2,1,RGB(230,230,230))
	nLin+=75
	
Return( NIL )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCO015CalcPer ³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³21-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Calcula as datas do periodo de acordo com o tipo de periodo        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCO015CalcPer( nTipo ,dIniPer ,dFimPer )                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nTipo - Tipo do periodo a ser calculado                           ³±±
±±³          ³ dIniPer - Data de inicio do periodo                               ³±±
±±³          ³ dFimPer - Data do fim do periodo                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
STATIC FUNCTION PCO015CalcPer( nTipo ,dIniPer ,dFimPer )
Local dX 		:= ctod("  / /  ")
Local dINI 		:= ctod("  / /  ")
Local aPeriodo 	:= {}

Do Case 
	// Semanal
	Case nTipo == "1"
		dIni := dIniPer
		If DOW(dIniPer)<>1
			dIni -= DOW(dIniPer)-1
		EndIf
	OtherWise
		dIni := CTOD("01/"+StrZero(MONTH(dIniPer),2,0)+"/"+StrZero(YEAR(dIniPer),4,0))
EndCase
dx := dIni
While dx < dFimPer
	aAdd( aPeriodo ,dX )
	Do Case  		
		// Semanal
		Case nTipo == "1"
			dx += 7
		// Quinzenal
		Case nTipo == "2"
			If DAY(dx) == 01
				dx	:= CTOD("15/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
			Else
				dx += 35
				dx	:= CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
			EndIf
		// Mensal
		Case nTipo == "3"
			dx += 35
			dx	:= CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		// Bimestral
		Case nTipo == "4"
			dx += 62
			dx	:= CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		// Semestral
		Case nTipo == "5"
			dx += 185
			dx	:= CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
		// Anual
		Case nTipo == "6"
			dx += 370
			dx	:= CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))
	EndCase
End

Return( aPeriodo )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PCO015ValPer  ³ Autor ³ Reynaldo Tetsu Miyashita ³ Data ³21-01-2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valor da coluna data(periodo) da classe orcamentaria atual        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³PCO015ValPer( cOrcame ,cVersao ,cCO ,aPeriodo ,cID ,oPrint ,nCol ) ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ cOrcame - Orcamento                                               ³±±
±±³          ³ cVersao - Versao do Orcamento                                     ³±±
±±³          ³ cCO     - Conta Orcamentaria                                      ³±±
±±³          ³ aPeriodo- array com as datas do periodo                           ³±±
±±³          ³ cID     - ID da atual classe Orcamentaria                         ³±±
±±³          ³ oPrint  - objeto TMSPrinter                                       ³±±
±±³          ³ nCol    - Posicao inicial da coluna                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
STATIC FUNCTION PCO015ValPer( cOrcame ,cVersao ,cCO ,aPeriodo ,cID ,oPrint ,nCol )
Local nX 		:= 0
Local aAreaAK2 	:= AK2->(GetArea())
Local cPicture	:= ""

DEFAULT nCol 	:= 0

	dbSelectArea("AK2")
		
	// varre o periodo
	For nX := 1 to len(aPeriodo)
		// busca pela tabela AK2
		IF MsSeek(xFilial()+cOrcame+cVersao+cCO+DTOS(aPeriodo[nX])+cID )
			
			PcoPrtCell(PcoPrtPos(nCol+nX),nLin,,60,PcoPlanCel(AK2->AK2_VALOR,AK2->AK2_CLASSE,,@cPicture),oPrint,1,3,,,.T.)
			dbSelectArea("AK2")
			dbSkip()
		EndIf
	Next nX
	
	RestArea( aAreaAK2 )
	
Return( NIL )         

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CN15PrepList   ºAutor  ³Microsiga           º Data ³  11/17/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula a quantidade de entidades novas, e inclui as       º±±
±±º          ³ entidades em array                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static function CN15PrepList()
Local nCont
Local cCampo
Static nQtdEntid := Nil
_aEntids := {}

If nQtdEntid == Nil
	If cPaisLoc == "RUS"
		nQtdEntid := PCOQtdEntd() //sao 4 entidades padroes -> conta /centro custo /item contabil/ classe de valor.
	Else
		nQtdEntid := CtbQtdEntd() //sao 4 entidades padroes -> conta /centro custo /item contabil/ classe de valor
	EndIf
EndIf           

For nCont := 5 to  nQtdEntid
    
	If nCont < 10
 		cCampo := "AK2_ENT0" + AllTrim(STR(nCont))
 	Else
  		cCampo := "AK2_ENT"  + AllTrim(STR(nCont))
    EndIf
        
    aadd (_aEntids, cCampo)
Next

//no final teremos isto: _aEntids := {"AK2_ENT05","AK2_ENT06","AK2_ENT07" ... }            

Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PCOR015   ºAutor  ³Microsiga           º Data ³  11/17/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se o usuário tem direito de acesso as entidades   º±±
±±º          ³ cadastradas                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CN15VerEntidade()
Local lRet := .T.  
Local nCont := 0
Local nCont2 := 5
Local aAreaAK2                                := GetArea()                                                                       
Local cEntInformada := ''

/*
Na janela PCOa210 cadastramos as restrições de acesso a uma EMTIDADE

Caso haja uma restrição cadastrada, vc identifica isto na tabela AL6 aonde o campo AL6_ENTIDADE deve conter o código existente no campo AK2_UNIORC

PcoDirEnt_User retorna
0        - sem direito de acesso
1,2 ou 3 - com direito de acesso
*/

//  nCont :            1            2            3
//_aEntis : { "AK2_ENT05",  "AK2_ENT06", "AK2_ENT07"}
For nCont := 1 to  len(_aEntids)
	
	cEntInformada := AK2->(FieldGet (   AK2->(FieldPos(_aEntids[nCont])) ) )
	cEntInformada := AllTrim(cEntInformada)
	
	If cEntInformada != ''
		lRet := .F.
		
		dbSelectArea("CT0")
		dbSetOrder(1)
		CT0->( dbSeek(xFilial("CT0")+strZero(nCont2,2)) )
		
		If CT0->(!Eof())
			if  PcoDirEnt_User ( CT0->(CT0_ALIAS), AK2->(FieldGet (   AK2->(FieldPos(_aEntids[nCont])) ) ), __cUserID, .F., CT0->CT0_ENTIDA) > 0
				lRet := .T.
			EndIf
		EndIf
		
		nCont2++
		If !lRet    //Se alguma das entidades verificadas está bloqueada para o usuário , já retornamos FALSE e bloqueamos tudo
			RestArea(aAreaAK2)
			return lRet
		EndIf
		
	EndIf
Next


RestArea(aAreaAK2)
Return lRet//se não houver nenhuma nova entidade cadastrada retorna FALSE também





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PCOR015  ºAutor  ³Microsiga           º Data ³  11/17/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica direito de acesso a tabela AK2_UNIORC              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CN15VrfUniorc()
Local lRet := .F.
Local aAreaAK2                                := GetArea()
Local cUnidOrc
Local lTemUniOrc	:= IIF( AK2->(FieldPos('AK2_UNIORC')) > 0 , .T. , .F. )
cUnidOrc := AK2->AK2_UNIORC
cUnidOrc := AllTrim(cUnidOrc)
/*
Na janela PCOa210 cadastramos as restrições de acesso a uma EMTIDADE

Caso haja uma restrição cadastrada, vc identifica isto na tabela AL6 aonde o campo AL6_ENTIDADE deve conter o código existente no campo AK2_UNIORC

PcoDirEnt_User retorna
0        - sem direito de acesso
1,2 ou 3 - com direito de acesso
*/

If lTemUniOrc == .T. .and. cUnidOrc != ''
	If  PcoDirEnt_User("AMF", AK2->AK2_UNIORC, __cUserID, .F.) > 0
		lRet := .T.
	EndIf
Else
	lRet := .T.
EndIf

RestArea(aAreaAK2)
Return lRet

