/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr745.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR745  ³ Autor ³ Rafael Diogo Richter  ³ Data ³ 14/07/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de analise do resultado de audiometria			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR745()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR745"
LOCAL limite  := 132
LOCAL cDesc1  := STR0021 //"Relatorio de analise do resultado de audiometria"
LOCAL cDesc2  := " "
LOCAL cDesc3  := " "
LOCAL cString := "TM9"
Local nTamGrupExa := 0

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
cCliMdtps:= If(!lSigaMdtPS,"","Z")

PRIVATE nomeprog := "MDTR745"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0002, 1,STR0003, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0022 //"Relatório de Analise do Resultado de Audiometria"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg := If(!lSigaMdtPS,"MDT745    ","MDT745PS  ")
PRIVATE cabec1, cabec2

cAliasCC := "SI3"   
cCodCC2  := "I3_CUSTO"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
cF3CC    := "SI3"  //SI3 apenas do cliente
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC2  := "CTT_CUSTO"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cF3CC := "CTT"  	
	cDescCC2 := "CTT->CTT_DESC01"
Endif   	

/*---------------------------------|
//PERGUNTAS PADRÃO					|
| 01  Exame ?          				|
| 02  De Matricula ?   				|
| 03  Ate Matricula ?  				|
| 04  De C. Custo ?    				|
| 05  Ate C. Custo ?   				|
| 06  De Funcao ?      				|
| 07  Ate Funcao ?     				|
| 08  De Data ?        				|
| 09  Ate Data ?       				|
|										|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01  De Cliente ?    				|
| 02  Loja             				|
| 03  Até Cliente ?    				|
| 04  Loja             				|
| 05  Exame ?          				|
| 06  De Matricula ?   				|
| 07  Ate Matricula ?  				|
| 08  De C. Custo ?    				|
| 09  Ate C. Custo ?   				|
| 10  De Funcao ?      				|
| 11  Ate Funcao ?     				|
| 12  De Data ?        				|	
| 13  Ate Data ?       				|
|----------------------------------|*/

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//----------------------------------------------------------------
//| Verifica as perguntas selecionadas                           |
//----------------------------------------------------------------
pergunte(cPerg,.F.)

//----------------------------------------------------------------
//| Envia controle para a funcao SETPRINT                        |
//----------------------------------------------------------------
wnrel:="MDTR745"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//----------------------------------------------------------------
	//| Devolve variaveis armazenadas (NGRIGHTCLICK)                 |
	//----------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//----------------------------------------------------------------
	//| Devolve variaveis armazenadas (NGRIGHTCLICK)                 |
	//----------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

RptStatus({|lEnd| R745Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//----------------------------------------------------------------
//| Devolve variaveis armazenadas (NGRIGHTCLICK)                 |
//----------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R745Imp  ³ Autor ³ Rafael Diogo Richter  ³ Data ³12/08/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR745                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R745Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL cChave    := SPACE(16)
LOCAL lContinua := .T.
LOCAL lExist    := .f.   

LOCAL lPrint := .f.

LOCAL t_OD05KH 
LOCAL t_OD1KHZ 
LOCAL t_OD2KHZ 
LOCAL t_OD3KHZ 

LOCAL t_OE05KH 
LOCAL t_OE1KHZ 
LOCAL t_OE2KHZ 
LOCAL t_OE3KHZ 
LOCAL aResult:= {"Requer Interpretação", "Normal", "Redução em Grau Mínimo", "Redução em Grau Médio", "Redução em Grau Máximo", "Perda de Audição"}
Local nRes1, nRes2, cResult1, cResult2, lres := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1
PRIVATE lImpmat := .t.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// PRIVATE

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cabec1 := STR0014 //"Mat.     Nome Funcionario              Funcao                Data Exame  Resultado Or.Esquerda          Resultado Or.Direita"
cabec2 := ""

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                                   Funcionarios por Centro de Custo e Funcao                                         (Padrao)
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Mat.     Nome Funcionario              Funcao                Data Exame  Resultado Or.Esquerda          Resultado Or.Direita
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Centro de Custo: 999999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

XXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXX  99/99/9999  Reducao em grau maximo..:999   Reducao em grau maximo..:999


Total de exames no setor.........:999     								 Audicao normal..........:999   Reducao em grau medio;;;:999
*/                         

nTSetor  :=0 //Total de exames do setor
nTDLiAc  :=0 //Total de exames do setor audicao normal direita
nTDSuPa  :=0 //Total de exames do setor reducao minima direita
nTDNSuPa :=0 //Total de exames do setor reducao media direita
nTDSuDes :=0 //Total de exames do setor reducao maxima direita
nTDSuAg  :=0 //Total de exames do setor perda de audicao direita 
nTELiAc  :=0 //Total de exames do setor audicao normal esquerda
nTESuPa  :=0 //Total de exames do setor reducao minima esquerda
nTENSuPa :=0 //Total de exames do setor reducao media esquerda                         
nTESuDes :=0 //Total de exames do setor reducao maxima esquerda
nTESuAg  :=0 //Total de exames do setor perda de audicao esquerda

nTFilial  :=0 //Total de exames da filial
nTFDLiAc  :=0 //Total de exames da filial audicao normal direita
nTFDSuPa  :=0 //Total de exames da filial reducao minima direita
nTFDNSuPa :=0 //Total de exames da filial reducao media direita
nTFDSuDes :=0 //Total de exames da filial reducao maxima direita
nTFDSuAg  :=0 //Total de exames da filial perda de audicao direita 
nTFELiAc  :=0 //Total de exames da filial audicao normal esquerda
nTFESuPa  :=0 //Total de exames da filial reducao minima esquerda
nTFENSuPa :=0 //Total de exames da filial reducao media esquerda                         
nTFESuDes :=0 //Total de exames da filial reducao maxima esquerda
nTFESuAg  :=0 //Total de exames da filial perda de audicao esquerda
ccSalvo   := " "
lPricc    := .f.

If lSigaMdtps

	cCliente := ""

	dbSelectArea("SRA")
	dbSetOrder(02)   //RA_FILIAL+RA_CC+RA_MAT
	dbSeek(xFilial("SRA")+mv_par08,.t.)
	
	SetRegua(LastRec())
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA') .and. SRA->RA_CC <= MV_PAR09
	
		cCliMdtps := SubStr(SRA->RA_CC,1,nSizeTD)
		
		If cCliMdtps < mv_par01+mv_par02 .or. cCliMdtps > mv_par03+mv_par04
			DBSkip()
			Loop			
		Endif
		
		IF SRA->RA_MAT < MV_PAR06 .or. SRA->RA_MAT > MV_PAR07
			DBSkip()
			Loop
		ENDIF
		IF SRA->RA_CODFUNC < MV_PAR10 .or. SRA->RA_CODFUNC > MV_PAR11
			DBSkip()
			Loop
		ENDIF
	         
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC)+SRA->RA_CC)
	
		dbSelectArea("SRJ")
		dbSetOrder(01)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
	         
		dbSelectArea("TM0")
		dbSetOrder(03) 
		IF dbSeek(xFilial("SRA")+SRA->RA_MAT)
			lfirst := .t.
			dbSelectArea("TM5")
			dbSetOrder(06)
			DbSeek(xFilial("TM5")+TM0->TM0_NUMFIC+mv_par05)
			While !Eof() .and. TM5->TM5_FILIAL = xFilial("TM5") .and. TM0->TM0_NUMFIC = TM5->TM5_NUMFIC .and. TM5->TM5_EXAME = mv_par05
						  
				dbSelectArea("TM9")
				dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA    	     	
				IF DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par05)
					
					If TM5->TM5_DTRESU < mv_par12 .or. TM5->TM5_DTRESU > mv_par13
						dbSelectArea("TM5")
						dbSkip()
						Loop
					Endif				
					
					lExist := .t.			
					
					If cCliente != cCliMdtps
						cCliente := cCliMdtps
						cA1_COD := SubStr(SRA->RA_CC,1,nTa1)
						cA1_LOJA := SubStr(SRA->RA_CC,nTa1+1,nTa1L)
						Somalinha()
						@Li,000 PSay STR0034 + AllTrim(cA1_COD) + "-" + AllTrim(cA1_LOJA) + " - " +  NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")   //"Cliente/Loja: "
						SomaLinha()	
					Endif
					
					If ccSalvo != SRA->RA_CC
		
						If lPricc .and. lexist	
							Somalinha()
							@Li,000 PSay STR0031 + Alltrim(str(nTSetor,6)) //"Total de Exames no Setor..........:"
							@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTDLiAc,6))
							@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTELiAc,6))//"Audicao Normal"
							Somalinha()
							@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTDSuPa,6))
							@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTESuPa,6))//"Reducao em Grau Minimo" 
							Somalinha()
							@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTDNSuPa,6))
							@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTENSuPa,6))//"Reducao em Grau Medio"
							Somalinha()                    
							@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTDSuDes,6))
							@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTESuDes,6))//"Reducao em Grau Maximo"
							Somalinha()                    
							@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTDSuAg,6))
							@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTESuAg,6))//"Perda de Audicao"
							somalinha()
						EndIf	
						nTSetor  :=0 //Total de exames do setor
						nTDLiAc  :=0 //Total de exames do setor audicao normal direita
						nTDSuPa  :=0 //Total de exames do setor reducao minima direita
						nTDNSuPa :=0 //Total de exames do setor reducao media direita
						nTDSuDes :=0 //Total de exames do setor reducao maxima direita
						nTDSuAg  :=0 //Total de exames do setor perda de audicao direita 
						nTELiAc  :=0 //Total de exames do setor audicao normal esquerda
						nTESuPa  :=0 //Total de exames do setor reducao minima esquerda
						nTENSuPa :=0 //Total de exames do setor reducao media esquerda                         
						nTESuDes :=0 //Total de exames do setor reducao maxima esquerda
						nTESuAg  :=0 //Total de exames do setor perda de audicao esquerda
						lPricc   :=.t.				
						Somalinha()
						@ Li,000 PSay STR0030 + Alltrim(SRA->RA_CC) + " - " + &cDescCC2  //"Centro de Custo: "
						ccSalvo  := SRA->RA_CC
						Somalinha()
						Somalinha()
		
					EndIf
					IF lfirst .or. lImpmat
						@ Li,000 PSay SRA->RA_MAT
						@ Li,010 PSay SubStr(SRA->RA_NOME,1,27)
						@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,17)
						lfirst := .f.
					ENDIF
					@ Li,061 PSay TM5->TM5_DTRESU
					lImpmat := .f.
			
					//Caso o limiar seja Ausente, ajusta o valor para calcular corretamente
					t_OD05KH := If(TM9->TM9_OD05KH=-2, 115, TM9->TM9_OD05KH)
					t_OD1KHZ := If(TM9->TM9_OD1KHZ=-2, 115, TM9->TM9_OD1KHZ)
					t_OD2KHZ := If(TM9->TM9_OD2KHZ=-2, 115, TM9->TM9_OD2KHZ)
					t_OD3KHZ := If(TM9->TM9_OD3KHZ=-2, 115, TM9->TM9_OD3KHZ)
		
					t_OE05KH := If(TM9->TM9_OE05KH=-2, 115, TM9->TM9_OE05KH)
					t_OE1KHZ := If(TM9->TM9_OE1KHZ=-2, 115, TM9->TM9_OE1KHZ)
					t_OE2KHZ := If(TM9->TM9_OE2KHZ=-2, 115, TM9->TM9_OE2KHZ)
					t_OE3KHZ := If(TM9->TM9_OE3KHZ=-2, 115, TM9->TM9_OE3KHZ)
					
					nRes1 := val(TM9->TM9_OEINSS)
					nRes2 := val(TM9->TM9_ODINSS) 
					
					If !Empty(nRes1) .And. !Empty(nRes2) 
						cResult1 := aResult[nRes1]            
						cResult2 := aResult[nRes2]
						@ Li,73 PSay cResult2 
						@ Li,104 PSay cResult1 
					  /*
						1 - "Requer Interpretação"
						2 - "Normal"
						3 - "Redução em Grau Mínimo"
						4 - "Redução em Grau Médio" 
						5 - "Redução em Grau Máximo"
						6 - "Perda de Audição"
					  */
				  		//ORELHA ESQUERDA	
						If nRes1 == 2 //"Audição Normal"  
							nTELiAc++
							nTFELiAc++
						EndIf	
						If nRes1 == 3 //"Redução em Grau Mínimo"	
							nTESuPa++
							nTFESuPa++
						ENDIF         
						If nRes1 == 4 //"Redução em Grau Médio"
							nTENSuPa++
							nTFENSuPa++
						ENDIF 
						If nRes1 == 5 //"Redução em Grau Máximo"
							nTESuDes++
							nTFESuDes++
						ENDIF
						If nRes1 == 6 //"Perda de Audição"			
							nTESuAg++
							nTFESuAg++
						ENDIF
					   
						//ORELHA DIREITA
						If nRes2 == 2 //"Audição Normal"
							nTDLiAc++
							nTFDLiAc++
						ENDIF
						If nRes2 == 3 //"Redução em Grau Mínimo"
							nTDSuPa++
							nTFDSuPa++
						ENDIF
						If nRes2 == 4 //"Redução em Grau Médio"
							nTDNSuPa++
							nTFDNSuPa++
						ENDIF
						If nRes2 == 5 //"Redução em Grau Máximo"
							nTDSuDes++
							nTFDSuDes++
						ENDIF
						If nRes2 == 6 //"Perda de Audição"
							nTDSuAg++
							nTFDSuAg++
						ENDIF 											 

					Else	
						lres := .T.						
					EndIf
					If lres	
						res_oe := (t_OE05KH+t_OE1KHZ+t_OE2KHZ+t_OE3KHZ)/4
						res_od := (t_OD05KH+t_OD1KHZ+t_OD2KHZ+t_OD3KHZ)/4 
						IF res_od < 26
							@ Li,73 PSay STR0015 //"Audição Normal"
							nTDLiAc++
							nTFDLiAc++
						ENDIF
						IF res_od >= 26 .and. res_od < 41
							@ Li,73 PSay STR0016 //"Redução em Grau Mínimo"
							nTDSuPa++
							nTFDSuPa++
						ENDIF
						IF res_od >= 41 .and. res_od < 71
							@ Li,73 PSay STR0017 //"Redução em Grau Médio"
							nTDNSuPa++
							nTFDNSuPa++
						ENDIF
						IF res_od >= 71 .and. res_od <= 91
							@ Li,73 PSay STR0018 //"Redução em Grau Máximo"
							nTDSuDes++
							nTFDSuDes++
						ENDIF
						IF res_od > 91
							@ Li,73 PSay STR0019 //"Perda de Audição"
							nTDSuAg++
							nTFDSuAg++
						ENDIF
						IF res_oe < 26
							@ Li,104 PSay STR0015 //"Audição Normal"  
							nTELiAc++
							nTFELiAc++									
						ENDIF
						IF res_oe >= 26 .and. res_oe < 41
							@ Li,104 PSay STR0016 //"Redução em Grau Mínimo"
							nTESuPa++
							nTFESuPa++
						ENDIF
						IF res_oe >= 41 .and. res_oe < 71
							@ Li,104 PSay STR0017 //"Redução em Grau Médio"
							nTENSuPa++
							nTFENSuPa++
						ENDIF
						IF res_oe >= 71 .and. res_oe <= 91
							@ Li,104 PSay STR0018 //"Redução em Grau Máximo"
							nTESuDes++
							nTFESuDes++
						ENDIF
						IF res_oe > 91
							@ Li,104 PSay STR0019 //"Perda de Audição"
							nTESuAg++
							nTFESuAg++
						ENDIF
						 
					ENDIF 
					Somalinha()
					nTSetor++
					nTFilial++  
				ENDIF
				dbSelectArea("TM5")
				DBSkip()
			END
		ENDIF   
	
		dbSelectArea("SRA")
		DBSkip()   			
		
		If cCliente != SubStr(SRA->RA_CC,1,nSizeTD)
			If lexist
				Somalinha()
				@Li,000 PSay STR0031 + Alltrim(str(nTSetor,6))  //"Total de Exames no Setor..........:"
				@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTDLiAc,6))
				@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTELiAc,6))			
				Somalinha()
				@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTDSuPa,6))
				@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTESuPa,6)) 
				Somalinha()
				@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTDNSuPa,6))
				@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTENSuPa,6))
				Somalinha()                    
				@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTDSuDes,6))
				@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTESuDes,6))
				Somalinha()                    
				@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTDSuAg,6))
				@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTESuAg,6))
				somalinha()
				somalinha()
			
				Somalinha()
				@Li,000 Psay STR0032 + Alltrim(str(nTFilial,6))  //"Total de Exames no Cliente........:"
				@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTFDLiAc,6))
				@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTFELiAc,6))
				Somalinha()
				@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTFDSuPa,6))
				@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTFESuPa,6)) 
				Somalinha()
				@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTFDNSuPa,6))
				@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTFENSuPa,6))
				Somalinha()                    
				@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTFDSuDes,6))
				@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTFESuDes,6))
				Somalinha()                    
				@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTFDSuAg,6))
				@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTFESuAg,6))
				lExist := .f.
				SomaLinha()
				@Li,000 PSay Replicate("-",132)	
				
				nTFilial  :=0 //Total de exames da filial
				nTFDLiAc  :=0 //Total de exames da filial audicao normal direita
				nTFDSuPa  :=0 //Total de exames da filial reducao minima direita
				nTFDNSuPa :=0 //Total de exames da filial reducao media direita
				nTFDSuDes :=0 //Total de exames da filial reducao maxima direita
				nTFDSuAg  :=0 //Total de exames da filial perda de audicao direita 
				nTFELiAc  :=0 //Total de exames da filial audicao normal esquerda
				nTFESuPa  :=0 //Total de exames da filial reducao minima esquerda
				nTFENSuPa :=0 //Total de exames da filial reducao media esquerda                         
				nTFESuDes :=0 //Total de exames da filial reducao maxima esquerda
				nTFESuAg  :=0 //Total de exames da filial perda de audicao esquerda
				ccSalvo   := " "
				lPricc    := .f.							
				lPrint := .t.
			EndIf
		Endif
	
	END	

Else

	dbSelectArea("SRA")
	dbSetOrder(02)
	dbSeek(xFilial("SRA")+mv_par04,.t.)
	
	SetRegua(LastRec())
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA') .and. SRA->RA_CC <= MV_PAR05
	
		IF SRA->RA_MAT < MV_PAR02 .or. SRA->RA_MAT > MV_PAR03
			DBSkip()
			Loop
		ENDIF
		IF SRA->RA_CODFUNC < MV_PAR06 .or. SRA->RA_CODFUNC > MV_PAR07
			DBSkip()
			Loop
		ENDIF  		
	         
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC)+SRA->RA_CC)
	
		dbSelectArea("SRJ")
		dbSetOrder(01)
		dbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
	         
		dbSelectArea("TM0")
		dbSetOrder(03) 
		IF dbSeek(xFilial("SRA")+SRA->RA_MAT)
			lfirst := .t.
			dbSelectArea("TM5")
			dbSetOrder(06)
			DbSeek(xFilial("TM5")+TM0->TM0_NUMFIC+mv_par01)
			While !Eof() .and. TM5->TM5_FILIAL = xFilial("TM5") .and. TM0->TM0_NUMFIC = TM5->TM5_NUMFIC .and. TM5->TM5_EXAME = mv_par01
				lres := .F.		  
				dbSelectArea("TM9")
				dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA    	     	
				IF DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par01)
					
					If TM5->TM5_DTRESU < mv_par08 .or. TM5->TM5_DTRESU > mv_par09
						dbSelectArea("TM5")
						dbSkip()
						Loop
					Endif
					
					lExist := .t.
					If ccSalvo != SRA->RA_CC
		
						If lPricc .and. lexist	
							Somalinha()
							@Li,000 PSay STR0031 + Alltrim(str(nTSetor,6))  //"Total de Exames no Setor..........:"
							@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTDLiAc,6))
							@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTELiAc,6))
							Somalinha()
							@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTDSuPa,6))
							@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTESuPa,6)) 
							Somalinha()
							@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTDNSuPa,6))
							@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTENSuPa,6))
							Somalinha()                    
							@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTDSuDes,6))
							@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTESuDes,6))
							Somalinha()                    
							@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTDSuAg,6))
							@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTESuAg,6))					
							somalinha()
						EndIf	
						nTSetor  :=0 //Total de exames do setor
						nTDLiAc  :=0 //Total de exames do setor audicao normal direita
						nTDSuPa  :=0 //Total de exames do setor reducao minima direita
						nTDNSuPa :=0 //Total de exames do setor reducao media direita
						nTDSuDes :=0 //Total de exames do setor reducao maxima direita
						nTDSuAg  :=0 //Total de exames do setor perda de audicao direita 
						nTELiAc  :=0 //Total de exames do setor audicao normal esquerda
						nTESuPa  :=0 //Total de exames do setor reducao minima esquerda
						nTENSuPa :=0 //Total de exames do setor reducao media esquerda                         
						nTESuDes :=0 //Total de exames do setor reducao maxima esquerda
						nTESuAg  :=0 //Total de exames do setor perda de audicao esquerda
						lPricc   :=.t.				
						Somalinha()
						@ Li,000 PSay STR0030 + Alltrim(SRA->RA_CC) + " - " + &cDescCC2  //"Centro de Custo: "
						ccSalvo  := SRA->RA_CC
						Somalinha()
						Somalinha()
		
					EndIf
					IF lfirst .or. lImpmat
						@ Li,000 PSay SRA->RA_MAT
						@ Li,010 PSay SubStr(SRA->RA_NOME,1,27)
						@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,17)
						lfirst := .f.
					ENDIF
					@ Li,061 PSay TM5->TM5_DTRESU
					lImpmat := .f.
			
					//Caso o limiar seja Ausente, ajusta o valor para calcular corretamente
					t_OD05KH := If(TM9->TM9_OD05KH=-2, 115, TM9->TM9_OD05KH)
					t_OD1KHZ := If(TM9->TM9_OD1KHZ=-2, 115, TM9->TM9_OD1KHZ)
					t_OD2KHZ := If(TM9->TM9_OD2KHZ=-2, 115, TM9->TM9_OD2KHZ)
					t_OD3KHZ := If(TM9->TM9_OD3KHZ=-2, 115, TM9->TM9_OD3KHZ)
		
					t_OE05KH := If(TM9->TM9_OE05KH=-2, 115, TM9->TM9_OE05KH)
					t_OE1KHZ := If(TM9->TM9_OE1KHZ=-2, 115, TM9->TM9_OE1KHZ)
					t_OE2KHZ := If(TM9->TM9_OE2KHZ=-2, 115, TM9->TM9_OE2KHZ)
					t_OE3KHZ := If(TM9->TM9_OE3KHZ=-2, 115, TM9->TM9_OE3KHZ)
						
					nRes1 := val(TM9->TM9_OEINSS)
					nRes2 := val(TM9->TM9_ODINSS) 

					If !Empty(nRes1) .And. !Empty(nRes2) 
						cResult1 := aResult[nRes1]            
						cResult2 := aResult[nRes2]
						@ Li,73 PSay cResult2 
						@ Li,104 PSay cResult1  
						
						/*
						1 - "Requer Interpretação"
						2 - "Normal"
						3 - "Redução em Grau Mínimo"
						4 - "Redução em Grau Médio" 
						5 - "Redução em Grau Máximo"
						6 - "Perda de Audição"
					  */
				  		//ORELHA ESQUERDA	
						If nRes1 == 2 //"Audição Normal"  
							nTELiAc++
							nTFELiAc++
						EndIf	
						If nRes1 == 3 //"Redução em Grau Mínimo"	
							nTESuPa++
							nTFESuPa++
						ENDIF
						If nRes1 == 4 //"Redução em Grau Médio"
							nTENSuPa++
							nTFENSuPa++
						ENDIF 
						If nRes1 == 5 //"Redução em Grau Máximo"
							nTESuDes++
							nTFESuDes++
						ENDIF
						If nRes1 == 6 //"Perda de Audição"			
							nTESuAg++
							nTFESuAg++
						ENDIF
					   
						//ORELHA DIREITA
						If nRes2 == 2 //"Audição Normal"
							nTDLiAc++
							nTFDLiAc++
						ENDIF
						If nRes2 == 3 //"Redução em Grau Mínimo"
							nTDSuPa++
							nTFDSuPa++
						ENDIF
						If nRes2 == 4 //"Redução em Grau Médio"
							nTDNSuPa++
							nTFDNSuPa++
						ENDIF
						If nRes2 == 5 //"Redução em Grau Máximo"
							nTDSuDes++
							nTFDSuDes++
						ENDIF
						If nRes2 == 6 //"Perda de Audição"
							nTDSuAg++
							nTFDSuAg++
						ENDIF 	
					Else	
						lres := .T.						
					EndIf	
			      
				  If lres
					  	res_oe := (t_OE05KH+t_OE1KHZ+t_OE2KHZ+t_OE3KHZ)/4
						res_od := (t_OD05KH+t_OD1KHZ+t_OD2KHZ+t_OD3KHZ)/4    
						IF res_od < 26
							@ Li,73 PSay STR0015 //"Audição Normal"
							nTDLiAc++
							nTFDLiAc++
						ENDIF
						IF res_od >= 26 .and. res_od < 41
							@ Li,73 PSay STR0016 //"Redução em Grau Mínimo"
							nTDSuPa++
							nTFDSuPa++
						ENDIF
						IF res_od >= 41 .and. res_od < 71
							@ Li,73 PSay STR0017 //"Redução em Grau Médio"
							nTDNSuPa++
							nTFDNSuPa++
						ENDIF
						IF res_od >= 71 .and. res_od <= 91
							@ Li,73 PSay STR0018 //"Redução em Grau Máximo"
							nTDSuDes++
							nTFDSuDes++
						ENDIF
						IF res_od > 91
							@ Li,73 PSay STR0019 //"Perda de Audição"
							nTDSuAg++
							nTFDSuAg++
						ENDIF
						IF res_oe < 26
						 	@ Li,104 PSay STR0015 //"Audição Normal"
							nTELiAc++
							nTFELiAc++
						ENDIF
						IF res_oe >= 26 .and. res_oe < 41
							@ Li,104 PSay STR0016 //"Redução em Grau Mínimo"
							nTESuPa++
							nTFESuPa++
						ENDIF
						IF res_oe >= 41 .and. res_oe < 71
							@ Li,104 PSay STR0017 //"Redução em Grau Médio"
							nTENSuPa++
							nTFENSuPa++
						ENDIF
						IF res_oe >= 71 .and. res_oe <= 91
							@ Li,104 PSay STR0018 //"Redução em Grau Máximo"
							nTESuDes++
							nTFESuDes++
						ENDIF
						IF res_oe > 91
							@ Li,104 PSay STR0019 //"Perda de Audição"
							nTESuAg++
							nTFESuAg++
						ENDIF
					ENDIF
					Somalinha()
					nTSetor++
			 		nTFilial++  
				ENDIF
				dbSelectArea("TM5")
				DBSkip()
	
			END
		ENDIF   
	
		dbSelectArea("SRA")
		DBSkip()   
	
	END
	
	If lexist
		Somalinha()
		@Li,000 PSay STR0031 + Alltrim(str(nTSetor,6))  //"Total de Exames no Setor..........:"
		@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTDLiAc,6))
		@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTELiAc,6))
		Somalinha()
		@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTDSuPa,6))
		@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTESuPa,6)) 
		Somalinha()
		@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTDNSuPa,6))
		@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTENSuPa,6))
		Somalinha()                    
		@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTDSuDes,6))
		@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTESuDes,6))
		Somalinha()                    
		@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTDSuAg,6))
		@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTESuAg,6))
		somalinha()
		somalinha()
	
		Somalinha()
		@Li,000 Psay STR0033 + Alltrim(str(nTFilial,6))  //"Total de Exames na Filial.........:"
		@Li,074 PSay STR0015 + "...........:" + Alltrim(str(nTFDLiAc,6))
		@Li,104 PSay STR0015 + "...........:" + Alltrim(str(nTFELiAc,6))
		Somalinha()
		@Li,074 PSay STR0016 + "...:" + Alltrim(str(nTFDSuPa,6))
		@Li,104 PSay STR0016 + "...:" + Alltrim(str(nTFESuPa,6)) 
		Somalinha()
		@Li,074 PSay STR0017 + "....:" + Alltrim(str(nTFDNSuPa,6))
		@Li,104 PSay STR0017 + "....:" + Alltrim(str(nTFENSuPa,6))
		Somalinha()                    
		@Li,074 PSay STR0018 + "...:" + Alltrim(str(nTFDSuDes,6))
		@Li,104 PSay STR0018 + "...:" + Alltrim(str(nTFESuDes,6))
		Somalinha()                    
		@Li,074 PSay STR0019 + ".........:" + Alltrim(str(nTFDSuAg,6))
		@Li,104 PSay STR0019 + ".........:" + Alltrim(str(nTFESuAg,6))
		lPrint := .t.
	EndIf	

Endif

RetIndex("SRA")

Set Filter To  

If !lPrint
	MsgInfo(STR0035)  //"Não há nada para imprimir no relatório."
	Return .F.
Endif

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

dbSelectArea("SRA")
dbSetOrder(01)

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()

Li++

If Li > 58
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	lImpmat := .t.
EndIf

Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³r745chkexa³ Autor ³Denis Hyroshi de Souza ³ Data ³ 15/01/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR745                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function r745chkexa()

If lSigaMdtps

	dbSelectArea("TM4")
	dbSetOrder(1)
	dbSeek(xFilial("TM4")+mv_par05)
	
	IF TM4->TM4_INDRES != "4"
		MSGSTOP(STR0020) //"O Exame selecionado não é de AudioMetria"
		Return .f.
	ENDIF

Else

	dbSelectArea("TM4")
	dbSetOrder(1)
	dbSeek(xFilial("TM4")+mv_par01)
	
	IF TM4->TM4_INDRES != "4"
		MSGSTOP(STR0020) //"O Exame selecionado não é de AudioMetria"
		Return .f.
	ENDIF

Endif

Return .t.