/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr489.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 2 //Versao do fonte
/*/  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR489  ³ Autor ³ Roger Rodrigues       ³ Data ³ 21/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de evolução audimetria              			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR489( cProgCham , cFichaCham , cExameCham )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR489"
LOCAL limite  := 220
LOCAL cDesc1  := STR0022 //"Relatório da evolução audiométrica."
LOCAL cDesc2  := " "
LOCAL cDesc3  := " "
LOCAL cString := "SRA"
Local nTamGrupExa := 0

Private lxMdt120 := .F.
Private cCliMdtps := " "

If Valtype(cProgCham) == "C" .and. Valtype(cFichaCham) == "C" .and. Valtype(cExameCham) == "C"
	If cProgCham == "MDTA120"
		lxMdt120 := .T.
	Endif
Endif

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Private lSigaMdtRl11 := If( NGCADICBASE("TQW_FILIAL","A","TQW",.F.), .f., .t.)

nTamExa := If((TAMSX3("TM4_EXAME")[1]) < 1,6,(TAMSX3("TM4_EXAME")[1]))
nTamMat := If((TAMSX3("RA_MAT")[1]) < 1,6,(TAMSX3("RA_MAT")[1]))
nTamCtt := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
nTamFun := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))

PRIVATE nomeprog := "MDTR489"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0038, 1,STR0039, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0022 //"Relatório da evolução audiométrica."
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg := If(!lSigaMdtPS,"MDT489    ","MDT489PS  ")
PRIVATE cabec1, cabec2

cCliMdtps := If(lSigaMdtps,"Z","")

cAliasCC := "SI3"   
cCodCC2  := "I3_CUSTO"
cF3CC    := "SI3001"  //SI3 apenas do cliente
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC2  := "CTT_CUSTO"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cF3CC := "CTT001"  //CTT apenas do cliente	
	cDescCC2 := "CTT->CTT_DESC01"
	cF3CC := "CTT001"  //CTT apenas do cliente	
Endif   	

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------
//PERGUNTAS PADRÃO	  |
| 01  De Cliente ?     |
| 02  Loja             |
| 03  Até Cliente ?    |
| 04  Loja             |
| 05  Exame ?          |
| 06  De Matricula ?   |
| 07  Ate Matricula ?  |
| 08  De C. Custo ?    |
| 09  Ate C. Custo ?   |
| 10  De Funcao ?      |
| 11  Ate Funcao ?     |
| 12  De Data ?        |
| 13  Ate Data ?       |
------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR489"

wnrel:=SetPrint(cString,wnrel,If(lxMdt120,nil,cPerg),titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return
Endif

If lxMdt120
	dbSelectArea("TM0")
	dbSetOrder(1)
	dbSeek(xFilial("TM0")+cFichaCham)
	dbSelectArea("SRA")
	dbSetOrder(1)
	dbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT)
	
	If lSigaMdtps
		Mv_par01 := Space( Len(Mv_par01) )
		Mv_par02 := Space( Len(Mv_par02) )
		Mv_par03 := Replicate("Z",nTa1)
		Mv_par04 := Replicate("Z",nTa1L)
		Mv_par05 := cExameCham
		Mv_par06 := SRA->RA_MAT
		Mv_par07 := SRA->RA_MAT
		Mv_par08 := SRA->RA_CC
		Mv_par09 := SRA->RA_CC
		Mv_par10 := SRA->RA_CODFUNC
		Mv_par11 := SRA->RA_CODFUNC
		Mv_par12 := SRA->RA_ADMISSA-30
		Mv_par13 := dDataBase
	Else
		Mv_par01 := cExameCham
		Mv_par02 := SRA->RA_MAT
		Mv_par03 := SRA->RA_MAT
		Mv_par04 := SRA->RA_CC
		Mv_par05 := SRA->RA_CC
		Mv_par06 := SRA->RA_CODFUNC
		Mv_par07 := SRA->RA_CODFUNC
		Mv_par08 := SRA->RA_ADMISSA-30
		Mv_par09 := dDataBase
	Endif
Endif

RptStatus({|lEnd| R489Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R489Imp  ³ Autor ³ Roger Rodrigues       ³ Data ³22/01/2009³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR489                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R489Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL lPrint := .f.
LOCAL lFirst := .t.
LOCAL lAerea := .F.

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

cabec1 := STR0001 //"Mat.     Nome Funcionario              Funcao                              Centro de Custo"
cabec2 := STR0002 //"Data Exame  Via   Resultado Port. 19 - OD                                                                Referencial?  Resultado Port. 19 - OE                                                                Referencial?"
/*
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Mat.     Nome Funcionario              Funcao                              Centro de Custo
Data Exame  Via   Resultado Port. 19 - OD                                                                Referencial?  Resultado Port. 19 - OE                                                                Referencial?
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
000035   DANILO FRANCISCO SILVA        ANALISTA PLENO                      ADMINISTRACAO E FINANCAS      
                                                Frequências - Orelha Direita (KHz)          Médias                                                   Frequências - Orelha Esquerda (KHz)         Médias
                                            |0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)                                          |0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)
14/09/09   Aerea  Limiares Aceitaveis       |  10|  10|  10|  10|  10|  10|  10|  10|   999,99  999,99   Não           Limiares Aceitaveis       |  10|  10|  10|  10|  10|  10|  10|  10|   999,99  999,99   Não
           Ossea  Limiares Aceitaveis            |  10|  10|  10|  10|  10|             999,99  999,99   Não           Limiares Aceitaveis            |  10|  10|  10|  10|  10|             999,99  999,99   Não
*/

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
		    IF !lfirst
				Somalinha()
				@ Li,000 PSAY __PrtThinLine()
				Somalinha()
				lfirst := .T.
			ENDIF

			dbSelectArea("TM5")
			dbSetOrder(06)
			DbSeek(xFilial("TM5")+TM0->TM0_NUMFIC+mv_par05)
			While !Eof() .and. TM5->TM5_FILIAL = xFilial("TM5") .and. TM0->TM0_NUMFIC = TM5->TM5_NUMFIC .and. TM5->TM5_EXAME = mv_par05
				  
				dbSelectArea("TM9")
				dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA    	     	
				IF DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par05+"1")
				    
					If TM5->TM5_DTRESU < mv_par12 .or. TM5->TM5_DTRESU > mv_par13
						dbSelectArea("TM5")
						dbSkip()
						Loop
					Endif				
					
					If cCliente != cCliMdtps
						cCliente := cCliMdtps
						cA1_COD := SubStr(SRA->RA_CC,1,nTa1)
						cA1_LOJA := SubStr(SRA->RA_CC,nTa1+1,nTa1L)
						Somalinha()
						@Li,000 PSay STR0037 + cA1_COD + "-" + cA1_LOJA + " - " +  NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")   //"Cliente/Loja: "
						SomaLinha()
						SomaLinha()	
					Endif
					IF lfirst .or. lImpmat
				   		lPrint = .T.
						@ Li,000 PSay SRA->RA_MAT
						@ Li,009 PSay SubStr(SRA->RA_NOME,1,28)
						@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,30)
						@ Li,075 PSay SubStr(CTT->CTT_DESC01,1,30)
						Somalinha()
						Somalinha()
						@ Li,048 Psay STR0023 //"Frequências - Orelha Direita (KHz)"
						@ Li,092 PSay STR0040 //"Médias"
						@ Li,149 PSay STR0024 //"Frequências - Orelha Esquerda (KHz)"
						@ Li,193 PSay STR0040 //"Médias"
						Somalinha()
					    @ Li,044 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    @ Li,145 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    Somalinha()
						lfirst = .F.
						lImpmat = .F.
 					Endif
 					@ Li,000 PSay TM5->TM5_DTRESU
					
					@ Li,011 Psay STR0025//"Aerea"
					lAerea := .T.
					IF TM9->TM9_ODRESU = "1"
						@ Li,018 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_ODRESU = "2"
						@ Li,018 Psay STR0028//"Limiares Aceitaveis"
					ENDIF
					IF TM9->TM9_ODRESU = "3"
						@ Li,018 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "4"
						@ Li,018 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "5"
						@ Li,018 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_ODRESU = "6"
						@ Li,018 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_ODRESU = "7"
						@ Li,018 Psay STR0033//"Perda de Audição"
					ENDIF

 					@ Li,044 Psay "|"
 					IF TM9->TM9_OD025K = -1
 						@ Li,048 Psay " "
 					ElseIF  TM9->TM9_OD025K = -2
 						@ Li,048 Psay "A"
 					Else 
 						@ Li,046 Psay TM9->TM9_OD025K Picture "999" 
					Endif
					@ Li,049 Psay "|"
 				    IF TM9->TM9_OD05KH = -1 
 						@ Li,053 Psay " "
 					ElseIf TM9->TM9_OD05KH = -2
 						@ Li,053 Psay "A"
 					Else
 						@ Li,051 Psay TM9->TM9_OD05KH Picture "999"
 					Endif
 					@ Li,054 Psay "|"
 					IF TM9->TM9_OD1KHZ = -1 
 						@ Li,058 Psay " "
 					ElseIf TM9->TM9_OD1KHZ = -2
 						@ Li,058 Psay "A"
 					Else
 						@ Li,056 Psay TM9->TM9_OD1KHZ Picture "999"
 					Endif
 					@ Li,059 Psay "|"
 					IF TM9->TM9_OD2KHZ = -1 
 						@ Li,063 Psay " "
 					ElseIf TM9->TM9_OD2KHZ = -2
 						@ Li,063 Psay "A"	
 					Else
 						@ Li,061 Psay TM9->TM9_OD2KHZ Picture "999"
 					Endif
 					@ Li,064 Psay "|"
 					IF TM9->TM9_OD3KHZ = -1
 						@ Li,068 Psay " "
 					ElseIf TM9->TM9_OD3KHZ = -2
 						@ Li,068 Psay "A"
 					Else
 						@ Li,066 Psay TM9->TM9_OD3KHZ Picture "999"
 					Endif
 					@ Li,069 Psay "|"
 				    IF TM9->TM9_OD4KHZ = -1 
 						@ Li,073 Psay " "
 					ElseIf TM9->TM9_OD4KHZ = -2
 						@ Li,073 Psay "A"
 					Else	
 						@ Li,071 Psay TM9->TM9_OD4KHZ Picture "999"
 					Endif
 					@ Li,074 Psay "|"
 					IF TM9->TM9_OD6KHZ = -1 
 						@ Li,078 Psay " "
 					ElseIF TM9->TM9_OD6KHZ = -2
 						@ Li,078 Psay "A"
 					Else
 						@ Li,076 Psay TM9->TM9_OD6KHZ Picture "999"
 					Endif
 					@ Li,079 Psay "|"
 					IF TM9->TM9_OD8KHZ = -1 
 						@ Li,083 Psay " "
 					ElseIf TM9->TM9_OD8KHZ = -2
 						@ Li,083 Psay "A"
 					Else
 						@ Li,081 Psay TM9->TM9_OD8KHZ Picture "999"
 					Endif
 					@ Li,084 Psay "|"

 					@ Li,088 Psay fMedia1(1)
 					@ Li,096 Psay fMedia2(1)

 					IF TM9->TM9_ODREFE = "1"
 						@ Li,105 PSay STR0035//"Sim"
 					ELSE
 						@ Li,105 PSay STR0036//"Não"
 					ENDIF
 					
 					IF TM9->TM9_OERESU = "1"
						@ Li,119 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_OERESU = "2"
						@ Li,119 Psay STR0028//"Limiares Aceitaveis"
					ENDIF  
					IF TM9->TM9_OERESU = "3"
						@ Li,119 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "4"
						@ Li,119 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "5"
						@ Li,119 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_OERESU = "6"
						@ Li,119 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_OERESU = "7"
						@ Li,119 Psay STR0033//"Perda de Audição"
					ENDIF

					@ Li,145 Psay "|"
					If TM9->TM9_OE025K = -1 
						@ Li,149 Psay " "
					ElseIF TM9->TM9_OE025K = -2
						@ Li,149 Psay "A"
					Else
 						@ Li,147 Psay TM9->TM9_OE025K Picture "999" 
					Endif
					@ Li,150 Psay "|"
 				    If TM9->TM9_OE05KH = -1
						@ Li,154 Psay " "
					ElseIF TM9->TM9_OE05KH = -2
						@ Li,154 Psay "A"
					Else
 						@ Li,152 Psay TM9->TM9_OE05KH Picture "999"
 					Endif
 					@ Li,155 Psay "|"
 					If TM9->TM9_OE1KHZ = -1
						@ Li,159 Psay " "
					ElseIf  TM9->TM9_OE1KHZ = -2
						@ Li,159 Psay "A"
					Else
 						@ Li,157 Psay TM9->TM9_OE1KHZ Picture "999"
 					Endif
 					@ Li,160 Psay "|"
 					If TM9->TM9_OE2KHZ = -1 
						@ Li,164 Psay " "
					ElseIf TM9->TM9_OE2KHZ = -2
						@ Li,164 Psay "A"
					Else
 						@ Li,162 Psay TM9->TM9_OE2KHZ Picture "999"
 					Endif
 					@ Li,165 Psay "|"
 					If TM9->TM9_OE3KHZ = -1 
						@ Li,169 Psay " "
					ElseIf TM9->TM9_OE3KHZ = -2
				   		@ Li,169 Psay "A"
					Else
 						@ Li,167 Psay TM9->TM9_OE3KHZ Picture "999"
 					Endif
 					@ Li,170 Psay "|"
 					If TM9->TM9_OE4KHZ = -1
						@ Li,174 Psay " "
					ElseIf  TM9->TM9_OE4KHZ = -2
						@ Li,174 Psay "A"
					Else
 						@ Li,172 Psay TM9->TM9_OE4KHZ Picture "999"
 					Endif
 					@ Li,175 Psay "|"
 					If TM9->TM9_OE6KHZ = -1 
						@ Li,179 Psay " "
					ElseIf TM9->TM9_OE6KHZ = -2
						@ Li,179 Psay "A"
					Else
 						@ Li,177 Psay TM9->TM9_OE6KHZ Picture "999"
 					Endif
 					@ Li,180 Psay "|"
 					If TM9->TM9_OE8KHZ = -1 
						@ Li,184 Psay " "
					ElseIf TM9->TM9_OE8KHZ = -2
						@ Li,184 Psay "A"
					Else
 						@ Li,182 Psay TM9->TM9_OE8KHZ Picture "999"
 					Endif
 					@ Li,185 Psay "|"

 					@ Li,189 Psay fMedia1(2)
 					@ Li,197 Psay fMedia2(2)
 					
 					IF TM9->TM9_OEREFE = "1"
 						@ Li,206 PSay STR0035//"Sim"
 					ELSE
 						@ Li,206 PSay STR0036//"Não"
 					ENDIF
 					Somalinha()
				ENDIF
				IF DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par05+"2")
						If TM5->TM5_DTRESU < mv_par12 .or. TM5->TM5_DTRESU > mv_par13
							dbSelectArea("TM5")
							dbSkip()
							Loop
						Endif
						If !lAerea
						  Somalinha()
						Endif
						IF lfirst .or. lImpmat
					   		lPrint = .T.
							@ Li,000 PSay SRA->RA_MAT
							@ Li,009 PSay SubStr(SRA->RA_NOME,1,28)
							@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,30)
							@ Li,075 PSay SubStr(CTT->CTT_DESC01,1,30)
							Somalinha()
							Somalinha()
							@ Li,048 Psay STR0023 //"Frequências - Orelha Direita (KHz)"
							@ Li,092 PSay STR0040 //"Médias"
							@ Li,149 PSay STR0024 //"Frequências - Orelha Esquerda (KHz)"
							@ Li,193 PSay STR0040 //"Médias"
							Somalinha()
						    @ Li,044 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
						    @ Li,145 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
						    Somalinha()
							lfirst = .F.
							lImpmat = .F.
	 					Endif
	 					If !lAerea
		 					If cCliente != cCliMdtps
								cCliente := cCliMdtps
								cA1_COD := SubStr(SRA->RA_CC,1,nTa1)
								cA1_LOJA := SubStr(SRA->RA_CC,nTa1+1,nTa1L)
								Somalinha()
								@Li,000 PSay STR0037 + cA1_COD + "-" + cA1_LOJA + " - " +  NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")   //"Cliente/Loja: "
								SomaLinha()
								SomaLinha()	
					   		Endif
		 					@ Li,000 PSay TM5->TM5_DTRESU
 						EndIf
 						@ Li,011 Psay STR0026//"Ossea"
						IF TM9->TM9_ODRESU = "1"
							@ Li,018 Psay STR0027//"Requer Interpretação"
						ENDIF
						IF TM9->TM9_ODRESU = "2"
							@ Li,018 Psay STR0028//"Limiares Aceitaveis"
						ENDIF
						IF TM9->TM9_ODRESU = "3"
							@ Li,018 Psay STR0029//"Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_ODRESU = "4"
							@ Li,018 Psay STR0030//"Não Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_ODRESU = "5"
							@ Li,018 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
						ENDIF
						IF TM9->TM9_ODRESU = "6"
							@ Li,018 Psay STR0032//"Sugestivo de Agravamento"
						ENDIF
						IF TM9->TM9_ODRESU = "7"
							@ Li,018 Psay STR0033//"Perda de Audição"
						ENDIF

						@ Li,049 Psay "|"
	 				    IF TM9->TM9_OD05KH = -1 
	 						@ Li,053 Psay " "
	 					ElseIf TM9->TM9_OD05KH = -2
	 						@ Li,053 Psay "A"
	 					Else
	 						@ Li,051 Psay TM9->TM9_OD05KH Picture "999"
	 					Endif
	 					@ Li,054 Psay "|"
	 					IF TM9->TM9_OD1KHZ = -1 
	 						@ Li,058 Psay " "
	 					ElseIf TM9->TM9_OD1KHZ = -2
	 						@ Li,058 Psay "A"
	 					Else
	 						@ Li,056 Psay TM9->TM9_OD1KHZ Picture "999"
	 					Endif
	 					@ Li,059 Psay "|"
	 					IF TM9->TM9_OD2KHZ = -1 
	 						@ Li,063 Psay " "
	 					ElseIf TM9->TM9_OD2KHZ = -2
	 						@ Li,063 Psay "A"	
	 					Else
	 						@ Li,061 Psay TM9->TM9_OD2KHZ Picture "999"
	 					Endif
	 					@ Li,064 Psay "|"
	 					IF TM9->TM9_OD3KHZ = -1
	 						@ Li,068 Psay " "
	 					ElseIf TM9->TM9_OD3KHZ = -2
	 						@ Li,068 Psay "A"
	 					Else
	 						@ Li,066 Psay TM9->TM9_OD3KHZ Picture "999"
	 					Endif
	 					@ Li,069 Psay "|"
	 				    IF TM9->TM9_OD4KHZ = -1 
	 						@ Li,073 Psay " "
	 					ElseIf TM9->TM9_OD4KHZ = -2
	 						@ Li,073 Psay "A"
	 					Else	
	 						@ Li,071 Psay TM9->TM9_OD4KHZ Picture "999"
	 					Endif
	 					@ Li,074 Psay "|"

	 					@ Li,088 Psay fMedia1(1)
	 					@ Li,096 Psay fMedia2(1)

	 					IF TM9->TM9_ODREFE = "1"
	 						@ Li,105 PSay STR0035//"Sim"
	 					ELSE
	 						@ Li,105 PSay STR0036//"Não"
	 					ENDIF
	                        
	 					IF TM9->TM9_OERESU = "1"
							@ Li,119 Psay STR0027//"Requer Interpretação"
						ENDIF
						IF TM9->TM9_OERESU = "2"
							@ Li,119 Psay STR0028//"Limiares Aceitaveis"
						ENDIF  
						IF TM9->TM9_OERESU = "3"
							@ Li,119 Psay STR0029//"Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_OERESU = "4"
							@ Li,119 Psay STR0030//"Não Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_OERESU = "5"
							@ Li,119 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
						ENDIF
						IF TM9->TM9_OERESU = "6"
							@ Li,119 Psay STR0032//"Sugestivo de Agravamento"
						ENDIF
						IF TM9->TM9_OERESU = "7"
							@ Li,119 Psay STR0033//"Perda de Audição"
						ENDIF

						@ Li,150 Psay "|"
	 				    If TM9->TM9_OE05KH = -1
							@ Li,154 Psay " "
						ElseIF TM9->TM9_OE05KH = -2
							@ Li,154 Psay "A"
						Else
	 						@ Li,152 Psay TM9->TM9_OE05KH Picture "999"
	 					Endif
	 					@ Li,155 Psay "|"
	 					If TM9->TM9_OE1KHZ = -1
							@ Li,159 Psay " "
						ElseIf  TM9->TM9_OE1KHZ = -2
							@ Li,159 Psay "A"
						Else
	 						@ Li,157 Psay TM9->TM9_OE1KHZ Picture "999"
	 					Endif
	 					@ Li,160 Psay "|"
	 					If TM9->TM9_OE2KHZ = -1 
							@ Li,164 Psay " "
						ElseIf TM9->TM9_OE2KHZ = -2
							@ Li,164 Psay "A"
						Else
	 						@ Li,162 Psay TM9->TM9_OE2KHZ Picture "999"
	 					Endif
	 					@ Li,165 Psay "|"
	 					If TM9->TM9_OE3KHZ = -1 
							@ Li,169 Psay " "
						ElseIf TM9->TM9_OE3KHZ = -2
					   		@ Li,169 Psay "A"
						Else
	 						@ Li,167 Psay TM9->TM9_OE3KHZ Picture "999"
	 					Endif
	 					@ Li,170 Psay "|"
	 					If TM9->TM9_OE4KHZ = -1
							@ Li,174 Psay " "
						ElseIf  TM9->TM9_OE4KHZ = -2
							@ Li,174 Psay "A"
						Else
	 						@ Li,172 Psay TM9->TM9_OE4KHZ Picture "999"
	 					Endif
	 					@ Li,175 Psay "|"

	 					@ Li,189 Psay fMedia1(2)
	 					@ Li,197 Psay fMedia2(2)

	 					IF TM9->TM9_OEREFE = "1"
	 						@ Li,206 PSay STR0035//"Sim"
	 					ELSE
	 						@ Li,206 PSay STR0036//"Não"
	 					ENDIF
	 					Somalinha()
	 					lAerea := .F.
 					
				ENDIF
				dbSelectArea("TM5")
				DBSkip()
	            
			END
		ENDIF   
	
		dbSelectArea("SRA")
		DBSkip()   			
		
		If cCliente != SubStr(SRA->RA_CC,1,nSizeTD)
	
				ccSalvo   := " "
				lPricc    := .f.							
				lPrint := .t.
	    EndIf
		
	
	END	
ElseIf lSigaMdtRl11
	dbSelectArea("SRA")
	dbSetOrder(02)
	dbSeek(xFilial("SRA")+mv_par04,.t.)
	
	SetRegua(LastRec())
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA') .and. SRA->RA_CC <= MV_PAR05
	
		IF SRA->RA_MAT < MV_PAR02 .or. SRA->RA_MAT > MV_PAR03
			dbSelectArea("SRA")
			DBSkip()
			Loop
		ENDIF
		IF SRA->RA_CODFUNC < MV_PAR06 .or. SRA->RA_CODFUNC > MV_PAR07
			dbSelectArea("SRA")
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
			IF !lfirst
				Somalinha()
				@ Li,000 PSAY __PrtThinLine()
				Somalinha()
				lfirst := .T.
			ENDIF
			
			dbSelectArea("TM5")
			dbSetOrder(06)
			DbSeek(xFilial("TM5")+TM0->TM0_NUMFIC+mv_par01)
			While !Eof() .and. TM5->TM5_FILIAL = xFilial("TM5") .and. TM0->TM0_NUMFIC = TM5->TM5_NUMFIC .and. TM5->TM5_EXAME = mv_par01
				
								  
				dbSelectArea("TM9")
				dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA    	     	
		     	If DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par01)
			  	
							If TM5->TM5_DTRESU < mv_par08 .or. TM5->TM5_DTRESU > mv_par09
							dbSelectArea("TM5")
							dbSkip()
							Loop
					Endif
					Somalinha()
					IF lfirst .or. lImpmat
				   		lPrint = .T.
						@ Li,000 PSay SRA->RA_MAT
						@ Li,009 PSay SubStr(SRA->RA_NOME,1,28)
						@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,30)
						@ Li,075 PSay SubStr(CTT->CTT_DESC01,1,30)
						Somalinha()
						Somalinha()
						@ Li,048 Psay STR0023 //"Frequências - Orelha Direita (KHz)"
						@ Li,092 PSay STR0040 //"Médias"
						@ Li,149 PSay STR0024 //"Frequências - Orelha Esquerda (KHz)"
						@ Li,193 PSay STR0040 //"Médias"
						Somalinha()
					    @ Li,044 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    @ Li,145 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    Somalinha()
						lfirst = .F.
						lImpmat = .F.
 					Endif
 					@ Li,000 PSay TM5->TM5_DTRESU
					IF TM9->TM9_INDVIA = "1"
						@ Li,011 Psay STR0025//"Aerea"
					Else
						@ Li,011 Psay STR0026//"Ossea"
					Endif
					IF TM9->TM9_ODRESU = "1"
						@ Li,018 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_ODRESU = "2"
						@ Li,018 Psay STR0028//"Limiares Aceitaveis"
					ENDIF
					IF TM9->TM9_ODRESU = "3"
						@ Li,018 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "4"
						@ Li,018 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "5"
						@ Li,018 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_ODRESU = "6"
						@ Li,018 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_ODRESU = "7"
						@ Li,018 Psay STR0033//"Perda de Audição"
					ENDIF

 					@ Li,044 Psay "|"
 					IF TM9->TM9_OD025K = -1
 						@ Li,048 Psay " "
 					ElseIF  TM9->TM9_OD025K = -2
 						@ Li,048 Psay "A"
 					Else 
 						@ Li,046 Psay TM9->TM9_OD025K Picture "999" 
					Endif
					@ Li,049 Psay "|"
 				    IF TM9->TM9_OD05KH = -1 
 						@ Li,053 Psay " "
 					ElseIf TM9->TM9_OD05KH = -2
 						@ Li,053 Psay "A"
 					Else
 						@ Li,051 Psay TM9->TM9_OD05KH Picture "999"
 					Endif
 					@ Li,054 Psay "|"
 					IF TM9->TM9_OD1KHZ = -1 
 						@ Li,058 Psay " "
 					ElseIf TM9->TM9_OD1KHZ = -2
 						@ Li,058 Psay "A"
 					Else
 						@ Li,056 Psay TM9->TM9_OD1KHZ Picture "999"
 					Endif
 					@ Li,059 Psay "|"
 					IF TM9->TM9_OD2KHZ = -1 
 						@ Li,063 Psay " "
 					ElseIf TM9->TM9_OD2KHZ = -2
 						@ Li,063 Psay "A"	
 					Else
 						@ Li,061 Psay TM9->TM9_OD2KHZ Picture "999"
 					Endif
 					@ Li,064 Psay "|"
 					IF TM9->TM9_OD3KHZ = -1
 						@ Li,068 Psay " "
 					ElseIf TM9->TM9_OD3KHZ = -2
 						@ Li,068 Psay "A"
 					Else
 						@ Li,066 Psay TM9->TM9_OD3KHZ Picture "999"
 					Endif
 					@ Li,069 Psay "|"
 				    IF TM9->TM9_OD4KHZ = -1 
 						@ Li,073 Psay " "
 					ElseIf TM9->TM9_OD4KHZ = -2
 						@ Li,073 Psay "A"
 					Else	
 						@ Li,071 Psay TM9->TM9_OD4KHZ Picture "999"
 					Endif
 					@ Li,074 Psay "|"
 					IF TM9->TM9_OD6KHZ = -1 
 						@ Li,078 Psay " "
 					ElseIF TM9->TM9_OD6KHZ = -2
 						@ Li,078 Psay "A"
 					Else
 						@ Li,076 Psay TM9->TM9_OD6KHZ Picture "999"
 					Endif
 					@ Li,079 Psay "|"
 					IF TM9->TM9_OD8KHZ = -1 
 						@ Li,083 Psay " "
 					ElseIf TM9->TM9_OD8KHZ = -2
 						@ Li,083 Psay "A"
 					Else
 						@ Li,081 Psay TM9->TM9_OD8KHZ Picture "999"
 					Endif
 					@ Li,084 Psay "|"

 					@ Li,088 Psay fMedia1(1)
 					@ Li,096 Psay fMedia2(1)
 					
 					IF TM9->TM9_ODREFE = "1"
 						@ Li,105 PSay STR0035//"Sim"
 					ELSE
 						@ Li,105 PSay STR0036//"Não"
 					ENDIF
 					
 					IF TM9->TM9_OERESU = "1"
						@ Li,119 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_OERESU = "2"
						@ Li,119 Psay STR0028//"Limiares Aceitaveis"
					ENDIF  
					IF TM9->TM9_OERESU = "3"
						@ Li,119 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "4"
						@ Li,119 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "5"
						@ Li,119 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_OERESU = "6"
						@ Li,119 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_OERESU = "7"
						@ Li,119 Psay STR0033//"Perda de Audição"
					ENDIF

					@ Li,145 Psay "|"
					If TM9->TM9_OE025K = -1 
						@ Li,149 Psay " "
					ElseIF TM9->TM9_OE025K = -2
						@ Li,149 Psay "A"
					Else
 						@ Li,147 Psay TM9->TM9_OE025K Picture "999" 
					Endif
					@ Li,150 Psay "|"
 				    If TM9->TM9_OE05KH = -1
						@ Li,154 Psay " "
					ElseIF TM9->TM9_OE05KH = -2
						@ Li,154 Psay "A"
					Else
 						@ Li,152 Psay TM9->TM9_OE05KH Picture "999"
 					Endif
 					@ Li,155 Psay "|"
 					If TM9->TM9_OE1KHZ = -1
						@ Li,159 Psay " "
					ElseIf  TM9->TM9_OE1KHZ = -2
						@ Li,159 Psay "A"
					Else
 						@ Li,157 Psay TM9->TM9_OE1KHZ Picture "999"
 					Endif
 					@ Li,160 Psay "|"
 					If TM9->TM9_OE2KHZ = -1 
						@ Li,164 Psay " "
					ElseIf TM9->TM9_OE2KHZ = -2
						@ Li,164 Psay "A"
					Else
 						@ Li,162 Psay TM9->TM9_OE2KHZ Picture "999"
 					Endif
 					@ Li,165 Psay "|"
 					If TM9->TM9_OE3KHZ = -1 
						@ Li,169 Psay " "
					ElseIf TM9->TM9_OE3KHZ = -2
				   		@ Li,169 Psay "A"
					Else
 						@ Li,167 Psay TM9->TM9_OE3KHZ Picture "999"
 					Endif
 					@ Li,170 Psay "|"
 					If TM9->TM9_OE4KHZ = -1
						@ Li,174 Psay " "
					ElseIf  TM9->TM9_OE4KHZ = -2
						@ Li,174 Psay "A"
					Else
 						@ Li,172 Psay TM9->TM9_OE4KHZ Picture "999"
 					Endif
 					@ Li,175 Psay "|"
 					If TM9->TM9_OE6KHZ = -1 
						@ Li,179 Psay " "
					ElseIf TM9->TM9_OE6KHZ = -2
						@ Li,179 Psay "A"
					Else
 						@ Li,177 Psay TM9->TM9_OE6KHZ Picture "999"
 					Endif
 					@ Li,180 Psay "|"
 					If TM9->TM9_OE8KHZ = -1 
						@ Li,184 Psay " "
					ElseIf TM9->TM9_OE8KHZ = -2
						@ Li,184 Psay "A"
					Else
 						@ Li,182 Psay TM9->TM9_OE8KHZ Picture "999"
 					Endif
 					@ Li,185 Psay "|"

 					@ Li,189 Psay fMedia1(2)
 					@ Li,197 Psay fMedia2(2)

 					IF TM9->TM9_OEREFE = "1"
 						@ Li,206 PSay STR0035//"Sim"
 					ELSE
 						@ Li,206 PSay STR0036//"Não"
 					ENDIF
 					Somalinha()
 				ENDIF
 							 
				dbSelectArea("TM5")
				DBSkip()	
	   		END
	   		
		ENDIF   
	    
		dbSelectArea("SRA")
		DBSkip()   	
	END
	
Else

 	dbSelectArea("SRA")
	dbSetOrder(02)
	dbSeek(xFilial("SRA")+mv_par04,.t.)
	
	SetRegua(LastRec())
	
	While !Eof() .AND. SRA->RA_FILIAL = xFilial('SRA') .and. SRA->RA_CC <= MV_PAR05
	
		IF SRA->RA_MAT < MV_PAR02 .or. SRA->RA_MAT > MV_PAR03
			dbSelectArea("SRA")
			DBSkip()
			Loop
		ENDIF
		IF SRA->RA_CODFUNC < MV_PAR06 .or. SRA->RA_CODFUNC > MV_PAR07
			dbSelectArea("SRA")
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
			IF !lfirst
				Somalinha()
				@ Li,000 PSAY __PrtThinLine()
				Somalinha()
				lfirst := .T.
			ENDIF
			
			dbSelectArea("TM5")
			dbSetOrder(06)
			DbSeek(xFilial("TM5")+TM0->TM0_NUMFIC+mv_par01)
			While !Eof() .and. TM5->TM5_FILIAL = xFilial("TM5") .and. TM0->TM0_NUMFIC = TM5->TM5_NUMFIC .and. TM5->TM5_EXAME = mv_par01
		
								  
				dbSelectArea("TM9")
				dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA    	     	
		     	If DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par01+"1")
									
					If TM5->TM5_DTRESU < mv_par08 .or. TM5->TM5_DTRESU > mv_par09
							dbSelectArea("TM5")
							dbSkip()
							Loop
					Endif
					Somalinha()	
					IF lfirst .or. lImpmat
				   		lPrint = .T.
						@ Li,000 PSay SRA->RA_MAT
						@ Li,009 PSay SubStr(SRA->RA_NOME,1,28)
						@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,30)
						@ Li,075 PSay SubStr(CTT->CTT_DESC01,1,30)
						Somalinha()
						Somalinha()
						@ Li,048 Psay STR0023 //"Frequências - Orelha Direita (KHz)"
						@ Li,092 PSay STR0040 //"Médias"
						@ Li,149 PSay STR0024 //"Frequências - Orelha Esquerda (KHz)"
						@ Li,193 PSay STR0040 //"Médias"
						Somalinha()
					    @ Li,044 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    @ Li,145 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
					    Somalinha()
						lfirst = .F.
						lImpmat = .F.
 					Endif
 					@ Li,000 PSay TM5->TM5_DTRESU
					@ Li,011 Psay STR0025//"Aerea"
					lAerea := .T.
					IF TM9->TM9_ODRESU = "1"
						@ Li,018 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_ODRESU = "2"
						@ Li,018 Psay STR0028//"Limiares Aceitaveis"
					ENDIF
					IF TM9->TM9_ODRESU = "3"
						@ Li,018 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "4"
						@ Li,018 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_ODRESU = "5"
						@ Li,018 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_ODRESU = "6"
						@ Li,018 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_ODRESU = "7"
						@ Li,018 Psay STR0033//"Perda de Audição"
					ENDIF

 					@ Li,044 Psay "|"
 					IF TM9->TM9_OD025K = -1
 						@ Li,048 Psay " "
 					ElseIF  TM9->TM9_OD025K = -2
 						@ Li,048 Psay "A"
 					Else 
 						@ Li,046 Psay TM9->TM9_OD025K Picture "999" 
					Endif
					@ Li,049 Psay "|"
 				    IF TM9->TM9_OD05KH = -1 
 						@ Li,053 Psay " "
 					ElseIf TM9->TM9_OD05KH = -2
 						@ Li,053 Psay "A"
 					Else
 						@ Li,051 Psay TM9->TM9_OD05KH Picture "999"
 					Endif
 					@ Li,054 Psay "|"
 					IF TM9->TM9_OD1KHZ = -1 
 						@ Li,058 Psay " "
 					ElseIf TM9->TM9_OD1KHZ = -2
 						@ Li,058 Psay "A"
 					Else
 						@ Li,056 Psay TM9->TM9_OD1KHZ Picture "999"
 					Endif
 					@ Li,059 Psay "|"
 					IF TM9->TM9_OD2KHZ = -1 
 						@ Li,063 Psay " "
 					ElseIf TM9->TM9_OD2KHZ = -2
 						@ Li,063 Psay "A"	
 					Else
 						@ Li,061 Psay TM9->TM9_OD2KHZ Picture "999"
 					Endif
 					@ Li,064 Psay "|"
 					IF TM9->TM9_OD3KHZ = -1
 						@ Li,068 Psay " "
 					ElseIf TM9->TM9_OD3KHZ = -2
 						@ Li,068 Psay "A"
 					Else
 						@ Li,066 Psay TM9->TM9_OD3KHZ Picture "999"
 					Endif
 					@ Li,069 Psay "|"
 				    IF TM9->TM9_OD4KHZ = -1 
 						@ Li,073 Psay " "
 					ElseIf TM9->TM9_OD4KHZ = -2
 						@ Li,073 Psay "A"
 					Else	
 						@ Li,071 Psay TM9->TM9_OD4KHZ Picture "999"
 					Endif
 					@ Li,074 Psay "|"
 					IF TM9->TM9_OD6KHZ = -1 
 						@ Li,078 Psay " "
 					ElseIF TM9->TM9_OD6KHZ = -2
 						@ Li,078 Psay "A"
 					Else
 						@ Li,076 Psay TM9->TM9_OD6KHZ Picture "999"
 					Endif
 					@ Li,079 Psay "|"
 					IF TM9->TM9_OD8KHZ = -1 
 						@ Li,083 Psay " "
 					ElseIf TM9->TM9_OD8KHZ = -2
 						@ Li,083 Psay "A"
 					Else
 						@ Li,081 Psay TM9->TM9_OD8KHZ Picture "999"
 					Endif
 					@ Li,084 Psay "|"

 					@ Li,088 Psay fMedia1(1)
 					@ Li,096 Psay fMedia2(1)
 					
 					IF TM9->TM9_ODREFE = "1"
 						@ Li,105 PSay STR0035//"Sim"
 					ELSE
 						@ Li,105 PSay STR0036//"Não"
 					ENDIF
 					
 					IF TM9->TM9_OERESU = "1"
						@ Li,119 Psay STR0027//"Requer Interpretação"
					ENDIF
					IF TM9->TM9_OERESU = "2"
						@ Li,119 Psay STR0028//"Limiares Aceitaveis"
					ENDIF  
					IF TM9->TM9_OERESU = "3"
						@ Li,119 Psay STR0029//"Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "4"
						@ Li,119 Psay STR0030//"Não Sugestivo de PAIR"
					ENDIF
					IF TM9->TM9_OERESU = "5"
						@ Li,119 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
					ENDIF
					IF TM9->TM9_OERESU = "6"
						@ Li,119 Psay STR0032//"Sugestivo de Agravamento"
					ENDIF
					IF TM9->TM9_OERESU = "7"
						@ Li,119 Psay STR0033//"Perda de Audição"
					ENDIF
					
					@ Li,145 Psay "|"
					If TM9->TM9_OE025K = -1 
						@ Li,149 Psay " "
					ElseIF TM9->TM9_OE025K = -2
						@ Li,149 Psay "A"
					Else
 						@ Li,147 Psay TM9->TM9_OE025K Picture "999" 
					Endif
					@ Li,150 Psay "|"
 				    If TM9->TM9_OE05KH = -1
						@ Li,154 Psay " "
					ElseIF TM9->TM9_OE05KH = -2
						@ Li,154 Psay "A"
					Else
 						@ Li,152 Psay TM9->TM9_OE05KH Picture "999"
 					Endif
 					@ Li,155 Psay "|"
 					If TM9->TM9_OE1KHZ = -1
						@ Li,159 Psay " "
					ElseIf  TM9->TM9_OE1KHZ = -2
						@ Li,159 Psay "A"
					Else
 						@ Li,157 Psay TM9->TM9_OE1KHZ Picture "999"
 					Endif
 					@ Li,160 Psay "|"
 					If TM9->TM9_OE2KHZ = -1 
						@ Li,164 Psay " "
					ElseIf TM9->TM9_OE2KHZ = -2
						@ Li,164 Psay "A"
					Else
 						@ Li,162 Psay TM9->TM9_OE2KHZ Picture "999"
 					Endif
 					@ Li,165 Psay "|"
 					If TM9->TM9_OE3KHZ = -1 
						@ Li,169 Psay " "
					ElseIf TM9->TM9_OE3KHZ = -2
				   		@ Li,169 Psay "A"
					Else
 						@ Li,167 Psay TM9->TM9_OE3KHZ Picture "999"
 					Endif
 					@ Li,170 Psay "|"
 					If TM9->TM9_OE4KHZ = -1
						@ Li,174 Psay " "
					ElseIf  TM9->TM9_OE4KHZ = -2
						@ Li,174 Psay "A"
					Else
 						@ Li,172 Psay TM9->TM9_OE4KHZ Picture "999"
 					Endif
 					@ Li,175 Psay "|"
 					If TM9->TM9_OE6KHZ = -1 
						@ Li,179 Psay " "
					ElseIf TM9->TM9_OE6KHZ = -2
						@ Li,179 Psay "A"
					Else
 						@ Li,177 Psay TM9->TM9_OE6KHZ Picture "999"
 					Endif
 					@ Li,180 Psay "|"
 					If TM9->TM9_OE8KHZ = -1 
						@ Li,184 Psay " "
					ElseIf TM9->TM9_OE8KHZ = -2
						@ Li,184 Psay "A"
					Else
 						@ Li,182 Psay TM9->TM9_OE8KHZ Picture "999"
 					Endif
 					@ Li,185 Psay "|"

 					@ Li,189 Psay fMedia1(2)
 					@ Li,197 Psay fMedia2(2)

 					IF TM9->TM9_OEREFE = "1"
 						@ Li,206 PSay STR0035//"Sim"
 					ELSE
 						@ Li,206 PSay STR0036//"Não"
 					ENDIF
 					Somalinha()
 				ENDIF
 				If DbSeek(xFilial("TM9")+TM0->TM0_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_HRPROG+mv_par01+"2")
						If TM5->TM5_DTRESU < mv_par08 .or. TM5->TM5_DTRESU > mv_par09
								dbSelectArea("TM5")
								dbSkip()
								Loop
						Endif
						If !lAerea
						  Somalinha()
						Endif
						IF lfirst .or. lImpmat
					   		lPrint = .T.
							@ Li,000 PSay SRA->RA_MAT
							@ Li,009 PSay SubStr(SRA->RA_NOME,1,28)
							@ Li,039 PSay SubStr(SRJ->RJ_DESC,1,30)
							@ Li,075 PSay SubStr(CTT->CTT_DESC01,1,30)
							Somalinha()
							Somalinha()
							@ Li,048 Psay STR0023 //"Frequências - Orelha Direita (KHz)"
							@ Li,092 PSay STR0040 //"Médias"
							@ Li,149 PSay STR0024 //"Frequências - Orelha Esquerda (KHz)"
							@ Li,193 PSay STR0040 //"Médias"
							Somalinha()
						    @ Li,044 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
						    @ Li,145 Psay "|0,25| 0,5|  1 |  2 |  3 |  4 |  6 |  8 |  (.5,1,2) (3,4,6)"
						    Somalinha()
							lfirst = .F.
							lImpmat = .F.
	 					Endif
	 					If !lAerea
		 					@ Li,000 PSay TM5->TM5_DTRESU
 						EndIf
 						@ Li,011 Psay STR0026//"Ossea"
						IF TM9->TM9_ODRESU = "1"
							@ Li,018 Psay STR0027//"Requer Interpretação"
						ENDIF
						IF TM9->TM9_ODRESU = "2"
							@ Li,018 Psay STR0028//"Limiares Aceitaveis"
						ENDIF
						IF TM9->TM9_ODRESU = "3"
							@ Li,018 Psay STR0029//"Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_ODRESU = "4"
							@ Li,018 Psay STR0030//"Não Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_ODRESU = "5"
							@ Li,018 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
						ENDIF
						IF TM9->TM9_ODRESU = "6"
							@ Li,018 Psay STR0032//"Sugestivo de Agravamento"
						ENDIF
						IF TM9->TM9_ODRESU = "7"
							@ Li,018 Psay STR0033//"Perda de Audição"
						ENDIF

						@ Li,049 Psay "|"
	 				    IF TM9->TM9_OD05KH = -1 
	 						@ Li,053 Psay " "
	 					ElseIf TM9->TM9_OD05KH = -2
	 						@ Li,053 Psay "A"
	 					Else
	 						@ Li,051 Psay TM9->TM9_OD05KH Picture "999"
	 					Endif
	 					@ Li,054 Psay "|"
	 					IF TM9->TM9_OD1KHZ = -1 
	 						@ Li,058 Psay " "
	 					ElseIf TM9->TM9_OD1KHZ = -2
	 						@ Li,058 Psay "A"
	 					Else
	 						@ Li,056 Psay TM9->TM9_OD1KHZ Picture "999"
	 					Endif
	 					@ Li,059 Psay "|"
	 					IF TM9->TM9_OD2KHZ = -1 
	 						@ Li,063 Psay " "
	 					ElseIf TM9->TM9_OD2KHZ = -2
	 						@ Li,063 Psay "A"	
	 					Else
	 						@ Li,061 Psay TM9->TM9_OD2KHZ Picture "999"
	 					Endif
	 					@ Li,064 Psay "|"
	 					IF TM9->TM9_OD3KHZ = -1
	 						@ Li,068 Psay " "
	 					ElseIf TM9->TM9_OD3KHZ = -2
	 						@ Li,068 Psay "A"
	 					Else
	 						@ Li,066 Psay TM9->TM9_OD3KHZ Picture "999"
	 					Endif
	 					@ Li,069 Psay "|"
	 				    IF TM9->TM9_OD4KHZ = -1 
	 						@ Li,073 Psay " "
	 					ElseIf TM9->TM9_OD4KHZ = -2
	 						@ Li,073 Psay "A"
	 					Else	
	 						@ Li,071 Psay TM9->TM9_OD4KHZ Picture "999"
	 					Endif
	 					@ Li,074 Psay "|"

	 					@ Li,088 Psay fMedia1(1)
	 					@ Li,096 Psay fMedia2(1)

	 					IF TM9->TM9_ODREFE = "1"
	 						@ Li,105 PSay STR0035//"Sim"
	 					ELSE
	 						@ Li,105 PSay STR0036//"Não"
	 					ENDIF

	 					IF TM9->TM9_OERESU = "1"
							@ Li,119 Psay STR0027//"Requer Interpretação"
						ENDIF
						IF TM9->TM9_OERESU = "2"
							@ Li,119 Psay STR0028//"Limiares Aceitaveis"
						ENDIF  
						IF TM9->TM9_OERESU = "3"
							@ Li,119 Psay STR0029//"Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_OERESU = "4"
							@ Li,119 Psay STR0030//"Não Sugestivo de PAIR"
						ENDIF
						IF TM9->TM9_OERESU = "5"
							@ Li,119 Psay Substr(STR0031,1,24)//"Sugestivo de Desencadeamento"
						ENDIF
						IF TM9->TM9_OERESU = "6"
							@ Li,119 Psay STR0032//"Sugestivo de Agravamento"
						ENDIF
						IF TM9->TM9_OERESU = "7"
							@ Li,119 Psay STR0033//"Perda de Audição"
						ENDIF

						@ Li,150 Psay "|"
	 				    If TM9->TM9_OE05KH = -1
							@ Li,154 Psay " "
						ElseIF TM9->TM9_OE05KH = -2
							@ Li,154 Psay "A"
						Else
	 						@ Li,152 Psay TM9->TM9_OE05KH Picture "999"
	 					Endif
	 					@ Li,155 Psay "|"
	 					If TM9->TM9_OE1KHZ = -1
							@ Li,159 Psay " "
						ElseIf  TM9->TM9_OE1KHZ = -2
							@ Li,159 Psay "A"
						Else
	 						@ Li,157 Psay TM9->TM9_OE1KHZ Picture "999"
	 					Endif
	 					@ Li,160 Psay "|"
	 					If TM9->TM9_OE2KHZ = -1 
							@ Li,164 Psay " "
						ElseIf TM9->TM9_OE2KHZ = -2
							@ Li,164 Psay "A"
						Else
	 						@ Li,162 Psay TM9->TM9_OE2KHZ Picture "999"
	 					Endif
	 					@ Li,165 Psay "|"
	 					If TM9->TM9_OE3KHZ = -1 
							@ Li,169 Psay " "
						ElseIf TM9->TM9_OE3KHZ = -2
					   		@ Li,169 Psay "A"
						Else
	 						@ Li,167 Psay TM9->TM9_OE3KHZ Picture "999"
	 					Endif
	 					@ Li,170 Psay "|"
	 					If TM9->TM9_OE4KHZ = -1
							@ Li,174 Psay " "
						ElseIf  TM9->TM9_OE4KHZ = -2
							@ Li,174 Psay "A"
						Else
	 						@ Li,172 Psay TM9->TM9_OE4KHZ Picture "999"
	 					Endif
	 					@ Li,175 Psay "|"

	 					@ Li,189 Psay fMedia1(2)
	 					@ Li,197 Psay fMedia2(2)

	 					IF TM9->TM9_OEREFE = "1"
	 						@ Li,206 PSay STR0035//"Sim"
	 					ELSE
	 						@ Li,206 PSay STR0036//"Não"
	 					ENDIF
	 					Somalinha()
	 					lAerea := .F.
 					
				ENDIF
			 
				dbSelectArea("TM5")
				DBSkip()	
	   		END
	   		
		ENDIF   
	    
		dbSelectArea("SRA")
		DBSkip()   	
	END

RetIndex("SRA")

ENDIF

Set Filter To  

If !lPrint
	MsgInfo(STR0017)  //"Não há nada para imprimir no relatório."
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
±±³ Uso      ³ MDTR489                                                    ³±±
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
±±³ Fun‡…o   ³r489chkexa³ Autor ³Roger Rodrigues        ³ Data ³ 22/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR489                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function r489chkexa()

If lSigaMdtps

	dbSelectArea("TM4")
	dbSetOrder(1)
	dbSeek(xFilial("TM4")+mv_par05)
	
	IF TM4->TM4_INDRES != "4"
		MSGSTOP(STR0003) //"O Exame selecionado não é de AudioMetria"
		Return .f.
	ENDIF

Else

	dbSelectArea("TM4")
	dbSetOrder(1)
	dbSeek(xFilial("TM4")+mv_par01)
	
	IF TM4->TM4_INDRES != "4"
		MSGSTOP(STR0003) //"O Exame selecionado não é de AudioMetria"
		Return .f.
	ENDIF

Endif

Return .t.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ fMedia1  ³ Autor ³ Denis                 ³ Data ³ 22/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Calcula Media 0,5 - 1 - 2                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR489                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function fMedia1(nTipo)
Local nRet := " "
Local lAusente5 := .F.
Local t_OD05KH,t_OD1KHZ,t_OD2KHZ,lFalso

If nTipo == 1
	lFalso := .f.
	x_OD05KH := NG120DtoC(TM9->TM9_OD05KH, @lFalso , TM9->TM9_ODAS50)
	x_OD1KHZ := NG120DtoC(TM9->TM9_OD1KHZ, @lFalso , TM9->TM9_ODAS10)
	x_OD2KHZ := NG120DtoC(TM9->TM9_OD2KHZ, @lFalso , TM9->TM9_ODAS20)
	t_OD05KH  := IF(Empty(x_OD05KH), lAusente5 := .T., Val(x_OD05KH))
	t_OD1KHZ  := IF(Empty(x_OD1KHZ), lAusente5 := .T., Val(x_OD1KHZ))
	t_OD2KHZ  := IF(Empty(x_OD2KHZ), lAusente5 := .T., Val(x_OD2KHZ))
	If !lAusente5
		nRet := (t_OD05KH+t_OD1KHZ+t_OD2KHZ)/3
	Endif
Else
	lFalso := .f.
	x_OE05KH := NG120DtoC(TM9->TM9_OE05KH, @lFalso , TM9->TM9_OEAS50)
	x_OE1KHZ := NG120DtoC(TM9->TM9_OE1KHZ, @lFalso , TM9->TM9_OEAS10)
	x_OE2KHZ := NG120DtoC(TM9->TM9_OE2KHZ, @lFalso , TM9->TM9_OEAS20)
	t_OD05KH  := IF(Empty(x_OE05KH), lAusente5 := .T., Val(x_OE05KH))
	t_OD1KHZ  := IF(Empty(x_OE1KHZ), lAusente5 := .T., Val(x_OE1KHZ))
	t_OD2KHZ  := IF(Empty(x_OE2KHZ), lAusente5 := .T., Val(x_OE2KHZ))
	If !lAusente5
		nRet := (t_OD05KH+t_OD1KHZ+t_OD2KHZ)/3
	Endif
Endif

Return If( Valtype(nRet) == "N" , TransForm(nRet,"@E 999.99") , " " )

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ fMedia2  ³ Autor ³ Denis                 ³ Data ³ 22/01/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Calcula Media 3 - 4 - 6                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR489                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function fMedia2(nTipo)
Local nRet := " "
Local lAusente3 := .F.
Local t_OD3KHZ,t_OD4KHZ,t_OD6KHZ

If nTipo == 1
	lFalso := .f.
	x_OD3KHZ := NG120DtoC(TM9->TM9_OD3KHZ, @lFalso , TM9->TM9_ODAS30)
	x_OD4KHZ := NG120DtoC(TM9->TM9_OD4KHZ, @lFalso , TM9->TM9_ODAS40)
	x_OD6KHZ := NG120DtoC(TM9->TM9_OD6KHZ, @lFalso , TM9->TM9_ODAS60)
	t_OD3KHZ  := IF(Empty(x_OD3KHZ), lAusente3 := .T., Val(x_OD3KHZ))
	t_OD4KHZ  := IF(Empty(x_OD4KHZ), lAusente3 := .T., Val(x_OD4KHZ))
	If TM9->TM9_INDVIA == "1"
		t_OD6KHZ  := IF(Empty(x_OD6KHZ), lAusente3 := .T., Val(x_OD6KHZ))
	Endif
	If TM9->TM9_INDVIA == "1"
		If !lAusente3
			nRet := (t_OD3KHZ+t_OD4KHZ+t_OD6KHZ)/3
		Endif
	Else
		If !lAusente3
			nRet := (t_OD3KHZ+t_OD4KHZ)/2
		Endif
	Endif
Else
	lFalso := .f.
	x_OE3KHZ := NG120DtoC(TM9->TM9_OE3KHZ, @lFalso , TM9->TM9_OEAS30)
	x_OE4KHZ := NG120DtoC(TM9->TM9_OE4KHZ, @lFalso , TM9->TM9_OEAS40)
	x_OE6KHZ := NG120DtoC(TM9->TM9_OE6KHZ, @lFalso , TM9->TM9_OEAS60)
	t_OD3KHZ  := IF(Empty(x_OE3KHZ), lAusente3 := .T., Val(x_OE3KHZ))
	t_OD4KHZ  := IF(Empty(x_OE4KHZ), lAusente3 := .T., Val(x_OE4KHZ))
	If TM9->TM9_INDVIA == "1"
		t_OD6KHZ  := IF(Empty(x_OE6KHZ), lAusente3 := .T., Val(x_OE6KHZ))
	Endif
	If TM9->TM9_INDVIA == "1"
		If !lAusente3
			nRet := (t_OD3KHZ+t_OD4KHZ+t_OD6KHZ)/3
		Endif
	Else
		If !lAusente3
			nRet := (t_OD3KHZ+t_OD4KHZ)/2
		Endif
	Endif
Endif
	
Return If( Valtype(nRet) == "N" , TransForm(nRet,"@E 999.99") , " " )