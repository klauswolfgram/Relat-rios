/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr443.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR443  ³ Autor ³ Liber de Esteban O.P. ³ Data ³ 20/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de resultados dos exames de Audiometria.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAMDT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR443()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR443"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio para impressao dos resultados de exame de audiometria."
LOCAL cDesc2  := STR0002 //"Atraves dos parametros o usuario podera selecionar: Periodo Desejado"
LOCAL cDesc3  := STR0003 //"e os centros de custo que serao impressos"
LOCAL cString := "TM0"
Private oTempTRB

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

nomeprog := "MDTR443"
tamanho  := "M"
aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
titulo   := STR0006 //"Resultados dos Exames de Audiometria"
ntipo    := 0
nLastKey := 0
cPerg    := If(!lSigaMdtPS,"MDT443    ","MDT443PS  ")
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))

cabec1 := STR0007  //"Mat.    Nome                            Dt.Nasc.  Admissao  Dt.Exame  Orelha Direita                   Orelha Esquerda"
cabec2 := " "

cAlias := "SI3"
cDescr := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
Endif

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------------------
//PERGUNTAS PADRÃO					|
|  01  De Centro de Custo ?    		|
|  02  Ate Centro de Custo ?   		|
|  03  De Data ?               		|
|  04  Ate Data ?              		|
| 										|
//PERGUNTA PRESTADOR DE SERVIÇO		|
|  01  De Cliente ?             	|
|  02  Loja                     	|
|  03  Até Cliente ?            	|
|  04  Loja	                 		|
|  05  De Centro de Custo ?    		|
|  06  Ate Centro de Custo ?   		|
|  07  De Data ?               		|
|  08  Ate Data ?              		|
------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "MDTR443"

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
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

RptStatus({|lEnd| R443Rel(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R443Rel  ³ Autor ³ Liber de Esteban O.P. ³ Data ³ 21/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR443                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R443Rel(lEnd,wnRel,titulo,tamanho)

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
LOCAL lContinua        := .T.

Local nTamMat   := TAMSX3("RA_MAT")[1]
Local nIndTM5   := NGRETORDEM("TM5","TM5_FILIAL+TM5_NUMFIC+DTOS(TM5_DTPROG)+TM5_HRPROG+TM5_EXAME",.T.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,flag := .f. ,m_pag := 1

Set Century Off

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                                        Resultado dos Exames de Audiometria                                           (Padrao)
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Mat.    Nome                            Dt.Nasc.  Admissao  Dt.Exame  Orelha Direita                   Orelha Esquerda
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Centro de Custo: 99999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Total de Exames no Setor.........: 999                                Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999


Total de Exames na Filial.........: 999                               Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
*/

// Prestador de serviço
/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                                                                                  DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************

          1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
(Padrao)                                        Resultado dos Exames de Audiometria                                           (Padrao)
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Mat.    Nome                            Dt.Nasc.  Admissao  Dt.Exame  Orelha Direita                   Orelha Esquerda
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Cliente/Loja: 000001-0000 - Bar do JEC

---------------------------------
Centro de Custo: 99999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Total de Exames no Setor.........: 999                                Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
---------------------------------
Centro de Custo: 99999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Total de Exames no Setor.........: 999                                Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
---------------------------------

Total de Exames do cliente.........: 999                              Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
																	  Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
______________________________________________________________________________________________________________________________________

Cliente/Loja: 000002-0000 - Bar Tigre

---------------------------------
Centro de Custo: 99999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Total de Exames no Setor.........: 999                                Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
---------------------------------
Centro de Custo: 99999999 - XXXXXXXXXXXXXXXXXXXXXXXXX

999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  Sugestivo Desencadeamento        Sugestivo Desencadeamento
999999  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/99  99/99/99  99/99/99  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Total de Exames no Setor.........: 999                                Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
                                                                      Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
---------------------------------

Total de Exames do cliente.........: 999                              Limites Aceitaveis........: 999  Nao Sugestivo PAIR........: 999
																	  Sugestivo Desencadeamento.: 999  Sugestivo Desencadeamento.: 999
*/

If nIndTM5 <= 0
	nIndTM5 := 8
Endif
If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{ "CLIENT"     , "C" ,nTa1, 0 })
	AADD(aDBF,{ "LOJA"       , "C" ,nTa1L, 0 })
	AADD(aDBF,{ "NOMECLI"    , "C" ,40, 0 })
	AADD(aDBF,{ "CC"         , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "DESCCC"     , "C" ,35, 0 })
	AADD(aDBF,{ "MAT"        , "C" ,nTamMat, 0 })
	AADD(aDBF,{ "NOME"       , "C" ,35, 0 })
	AADD(aDBF,{ "DTREF"      , "D" ,08, 0 })
	AADD(aDBF,{ "DTADMISSA"  , "D" ,08, 0 })
	AADD(aDBF,{ "DTNASC"     , "D" ,08, 0 })
	AADD(aDBF,{ "RESDIR"     , "C" ,01, 0 })
	AADD(aDBF,{ "RESESQ"     , "C" ,01, 0 })

	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CC","MAT","DTREF"} )
	oTempTRB:Create()

	dbSelectArea("TM9")
	dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA
	dbSeek(xFilial("TM9"))

	While !Eof() .AND. TM9->TM9_FILIAL = xFilial('TM9')

		dbSelectArea("TM5")
		dbSetOrder(nIndTM5)  //TM5_FILIAL+TM5_NUMFIC+DTOS(TM5_DTPROG)+TM5_HRPROG+TM5_EXAME
		If !dbSeek(xFilial("TM5")+TM9->TM9_NUMFIC+DTOS(TM9->TM9_DTPROG)+TM9->TM9_HRPROG+TM9->TM9_EXAME)
			dbSelectArea("TM9")
			dbSkip()
			Loop
		Else
			IF TM5->TM5_DTPROG < MV_PAR07 .or. TM5->TM5_DTPROG > MV_PAR08
				dbSelectArea("TM9")
				dbSkip()
				Loop
			EndIf
		ENDIF

		dbSelectArea("TM0")
		dbSetOrder(01)
		If !dbSeek(xFilial("TM0")+TM9->TM9_NUMFIC)
			dbSelectArea("TM9")
			dbSkip()
			Loop
		EndIf

		If TM0->(TM0_CLIENT+TM0_LOJA) < mv_par01+mv_par02 .or. TM0->(TM0_CLIENT+TM0_LOJA) > mv_par03+mv_par04
			dbSelectArea("TM9")
			dbSkip()
			Loop
		Endif

		dbSelectArea("SRA")
		dbSetOrder(01)
		if !dbSeek(xFilial("SRA")+TM0->TM0_MAT)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		EndIf
		IF SRA->RA_CC < MV_PAR05 .or. SRA->RA_CC > MV_PAR06 .or. Empty(SRA->RA_CC)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		ENDIF
		dbSelectArea(cAlias)
		dbSetOrder(01)
		If !dbSeek(xFilial(cAlias)+SRA->RA_CC)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		EndIf

		RecLock("TRB",.t.)
		TRB->CLIENT    := SubStr(SRA->RA_CC,1,nTa1)
		TRB->LOJA      := SubStr(SRA->RA_CC,nTa1+1,nTa1L)
		TRB->NOMECLI   := NGSEEK("SA1",TRB->CLIENT+TRB->LOJA,1,"SA1->A1_NOME")
		TRB->CC        := SRA->RA_CC
		TRB->DESCCC    := &(cDescr)
		TRB->MAT       := SRA->RA_MAT
		TRB->NOME      := SRA->RA_NOME
		TRB->DTREF     := TM5->TM5_DTPROG
		TRB->DTADMISSA := SRA->RA_ADMISSA
		TRB->DTNASC    := SRA->RA_NASC
		TRB->RESDIR    := TM9->TM9_ODRESU
		TRB->RESESQ    := TM9->TM9_OERESU
		MsUnlock("TRB")
		dbSelectArea("TM9")
		dbSkip()

	END

Else

	aDBF := {}
	AADD(aDBF,{ "CC"         , "C" ,nSizeSI3, 0 })
	AADD(aDBF,{ "DESCCC"     , "C" ,35, 0 })
	AADD(aDBF,{ "MAT"        , "C" ,nTamMat, 0 })
	AADD(aDBF,{ "NOME"       , "C" ,35, 0 })
	AADD(aDBF,{ "DTREF"      , "D" ,08, 0 })
	AADD(aDBF,{ "DTADMISSA"  , "D" ,08, 0 })
	AADD(aDBF,{ "DTNASC"     , "D" ,08, 0 })
	AADD(aDBF,{ "RESDIR"     , "C" ,01, 0 })
	AADD(aDBF,{ "RESESQ"     , "C" ,01, 0 })
	//Cria TRB
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CC","MAT","DTREF"} )
	oTempTRB:Create()

	dbSelectArea("TM9")
	dbSetOrder(03)  //TM9_FILIAL+TM9_NUMFIC+DTOS(TM9_DTPROG)+TM9_HRPROG+TM9_EXAME+TM9_INDVIA
	dbSeek(xFilial("TM9"))

	While !Eof() .AND. TM9->TM9_FILIAL = xFilial('TM9')

		dbSelectArea("TM5")
		dbSetOrder(nIndTM5)  //TM5_FILIAL+TM5_NUMFIC+DTOS(TM5_DTPROG)+TM5_HRPROG+TM5_EXAME
		If !dbSeek(xFilial("TM5")+TM9->TM9_NUMFIC+DTOS(TM9->TM9_DTPROG)+TM9->TM9_HRPROG+TM9->TM9_EXAME)
			dbSelectArea("TM9")
			dbSkip()
			Loop
		Else
			IF TM5->TM5_DTPROG < MV_PAR03 .or. TM5->TM5_DTPROG > MV_PAR04
				dbSelectArea("TM9")
				dbSkip()
				Loop
			EndIf
		ENDIF

		dbSelectArea("TM0")
		dbSetOrder(01)
		If !dbSeek(xFilial("TM0")+TM9->TM9_NUMFIC)
			dbSelectArea("TM9")
			dbSkip()
			Loop
		EndIf
		dbSelectArea("SRA")
		dbSetOrder(01)
		if !dbSeek(xFilial("SRA")+TM0->TM0_MAT)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		EndIf
		IF SRA->RA_CC < MV_PAR01 .or. SRA->RA_CC > MV_PAR02 .or. Empty(SRA->RA_CC)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		ENDIF
		dbSelectArea(cAlias)
		dbSetOrder(01)
		If !dbSeek(xFilial(cAlias)+SRA->RA_CC)
			dbSelectArea("TM9")
			DBSkip()
			Loop
		EndIf

		RecLock("TRB",.t.)
		TRB->CC        := SRA->RA_CC
		TRB->DESCCC    := &(cDescr)
		TRB->MAT       := SRA->RA_MAT
		TRB->NOME      := SRA->RA_NOME
		TRB->DTREF     := TM5->TM5_DTPROG
		TRB->DTADMISSA := SRA->RA_ADMISSA
		TRB->DTNASC    := SRA->RA_NASC
		TRB->RESDIR    := TM9->TM9_ODRESU
		TRB->RESESQ    := TM9->TM9_OERESU
		MsUnlock("TRB")
		dbSelectArea("TM9")
		dbSkip()

	END

Endif

_R443Imp()

dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0022)  //"Não há nada para imprimir no relatório."
	//Use
	oTempTRB:Delete()
	RetIndex("TM0")
	Set Filter To
	Return .F.
Endif

dbSelectArea("TRB")
//Use
oTempTRB:Delete()

RetIndex("TM0")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

RETURN NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³SomaLinha ³ Autor ³ Liber De Esteban O.P. ³ Data ³ 20/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR443                                                    ³±±
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³_R443Imp  ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 10/03/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressao do Relat¢rio                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR443                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function _R443Imp(lEnd,wnRel,titulo,tamanho)

Local ccSalvo := ""
Local cCliente := ""

//Totais a nivel de Filial/Cliente
Local nTFilial  := 0
Local nTFD1 := 0
Local nTFD2 := 0
Local nTFD3 := 0
Local nTFD4 := 0
Local nTFD5 := 0
Local nTFD6 := 0
Local nTFD7 := 0

Local nTFE1 := 0
Local nTFE2 := 0
Local nTFE3 := 0
Local nTFE4 := 0
Local nTFE5 := 0
Local nTFE6 := 0
Local nTFE7 := 0

//Totais a nivel de Setor
Local nTSetor  := 0
Local nTD1 := 0
Local nTD2 := 0
Local nTD3 := 0
Local nTD4 := 0
Local nTD5 := 0
Local nTD6 := 0
Local nTD7 := 0

Local nTE1 := 0
Local nTE2 := 0
Local nTE3 := 0
Local nTE4 := 0
Local nTE5 := 0
Local nTE6 := 0
Local nTE7 := 0

Local lImpmat := .t.  //Serve p/ nao imprimir 2 vezes a mesma matricula

//Descricao do resultado
Local cERDESC := ""
Local cDRDESC := ""

If lSigaMdtps

	dbSelectArea("TRB")
	dbSetOrder(01)
	dbGoTop()
	While !EOF()

		nTFilial := 0
		nTFD1 := 0
		nTFD2 := 0
		nTFD3 := 0
		nTFD4 := 0
		nTFD5 := 0
		nTFD6 := 0
		nTFD7 := 0

		nTFE1 := 0
		nTFE2 := 0
		nTFE3 := 0
		nTFE4 := 0
		nTFE5 := 0
		nTFE6 := 0
		nTFE7 := 0

	    cCliente := TRB->CLIENT+TRB->LOJA
	    SomaLinha()
	    @ Li,000 PSay STR0023 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOMECLI  //"Cliente/Loja: "
	    SomaLinha()
	    @ Li,000 PSay Replicate("_",32)
	    somalinha()

	    While !Eof() .and. cCliente == TRB->CLIENT+TRB->LOJA
		    ccSalvo  := TRB->CC
		    cMat   	 := " "
			nTSetor  := 0
			nTD1 := 0
			nTD2 := 0
			nTD3 := 0
			nTD4 := 0
			nTD5 := 0
			nTD6 := 0
			nTD7 := 0

			nTE1 := 0
			nTE2 := 0
			nTE3 := 0
			nTE4 := 0
			nTE5 := 0
			nTE6 := 0
			nTE7 := 0
		    somalinha()

		    @ Li,000 PSay STR0008 + Alltrim(TRB->CC) + " - " + TRB->DESCCC //"Centro de Custo: "
		    somalinha()

			While !Eof() .and. TRB->CC == ccSalvo .AND. cCliente == TRB->CLIENT+TRB->LOJA

		    	somalinha()
		    	If cMat != TRB->MAT .or. lImpmat
			    	@ Li,000 PSay TRB->MAT
					@ Li,010 PSay Substr(TRB->NOME,1,28)
					@ Li,040 PSay TRB->DTNASC
					@ Li,050 PSay TRB->DTADMISSA
				EndIf
				@ Li,060 Psay TRB->DTREF
				cMat := TRB->MAT
				lImpmat := .f.

				If TRB->RESDIR = "1"
					cDRDESC := STR0024  //"Requer Interpretação"
					nTD1++
					nTFD1++
				ElseIf TRB->RESDIR = "2"
					cDRDESC := STR0025  //"Limiares Aceitáveis"
					nTD2++
					nTFD2++
				ElseIf TRB->RESDIR = "3"
					cDRDESC := STR0026  //"Sugestivo do PAIR"
					nTD3++
					nTFD3++
				ElseIf TRB->RESDIR = "4"
			       	cDRDESC := STR0027  //"Não Sugestivo do PAIR"
				   	nTD4++
				   	nTFD4++
				ElseIf TRB->RESDIR = "5"
					cDRDESC := STR0028  //"Sugestivo de Desencadeamento"
					nTD5++
					nTFD5++
				ElseIf TRB->RESDIR = "6"
					cDRDESC := STR0013 //"Sugestivo Agravamento"
					nTD6++
					nTFD6++
				Else
					cDRDESC := STR0029  //"Perda de Audição"
					nTD7++
					nTFD7++
				EndIF

				If TRB->RESESQ = "1"
					cERDESC := STR0024  //"Requer Interpretação"
					nTE1++
					nTFE1++
				ElseIf TRB->RESESQ = "2"
					cERDESC := STR0025  //"Limiares Aceitáveis"
					nTE2++
					nTFE2++
				ElseIf TRB->RESESQ = "3"
					cERDESC := STR0026  //"Sugestivo do PAIR"
					nTE3++
					nTFE3++
				ElseIf TRB->RESESQ = "4"
				   	cERDESC := STR0027  //"Não Sugestivo do PAIR"
				   	nTE4++
				   	nTFE4++
				ElseIf TRB->RESESQ = "5"
					cERDESC := STR0028  //"5ugestivo de Desencadeamento"
					nTE5++
					nTFE5++
				ElseIf TRB->RESESQ = "6"
					cERDESC := STR0013 //"Sugestivo Agravamento"
					nTE6++
					nTFE6++
				Else
					cERDESC := STR0029  //"Perda de Audição"
					nTE7++
					nTFE7++
				EndIF

				@ Li,070 PSay cDRDESC
				@ Li,103 PSay cERDESC
				nTSetor++
				nTFilial++
				dbSelectArea("TRB")
				dbSkip()
			END

			Somalinha()
			Somalinha()
			@Li,000 PSay STR0014 + Alltrim(str(nTSetor,6)) //"Total de Exames no Setor.........: "
			@Li,070 PSay STR0030 + Alltrim(str(nTD1,6)) //"Requer Interpretação......: "
			@Li,103 PSay STR0030 + Alltrim(str(nTE1,6)) //"Requer Interpretação......: "
			Somalinha()
			@Li,070 PSay STR0031 + Alltrim(str(nTD2,6))  //"Limiares Aceitáveis.......: "
			@Li,103 PSay STR0031 + Alltrim(str(nTE2,6))  //"Limiares Aceitáveis.......: "
			Somalinha()
			@Li,070 PSay STR0032 + Alltrim(str(nTD3,6)) //"Sugestivo de PAIR.........: "
			@Li,103 PSay STR0032 + Alltrim(str(nTE3,6)) //"Sugestivo de PAIR.........: "
			Somalinha()
			@Li,070 PSay STR0033 + Alltrim(str(nTD4,6)) //"Nao Sugestivo de PAIR.....: "
			@Li,103 PSay STR0033 + Alltrim(str(nTE4,6)) //"Nao Sugestivo de PAIR.....: "
			Somalinha()
			@Li,070 PSay STR0034 + Alltrim(str(nTD5,6)) //"Sugestivo Desencadeamento.: "
			@Li,103 PSay STR0034 + Alltrim(str(nTE5,6)) //"Sugestivo Desencadeamento.: "
			somalinha()
			@Li,070 PSay STR0035 + Alltrim(str(nTD6,6)) //"Sugestivo de Agravamento..: "
			@Li,103 PSay STR0035 + Alltrim(str(nTE6,6)) //"Sugestivo de Agravamento..: "
			somalinha()
			@Li,070 PSay STR0036 + Alltrim(str(nTD7,6)) //"Perda de Audição..........: "
			@Li,103 PSay STR0036 + Alltrim(str(nTE7,6)) //"Perda de Audição..........: "
			somalinha()
			@ Li,000 PSay Replicate("_",32)
			somalinha()
	    End

		somalinha()
		@Li,000 Psay STR0021 + Alltrim(str(nTFilial,6)) //"Total de Exames no Cliente........: "
		@Li,070 PSay STR0030 + Alltrim(str(nTFD1,6)) //"Requer Interpretação......: "
		@Li,103 PSay STR0030 + Alltrim(str(nTFE1,6)) //"Requer Interpretação......: "
		Somalinha()
		@Li,070 PSay STR0031 + Alltrim(str(nTFD2,6))  //"Limiares Aceitáveis.......: "
		@Li,103 PSay STR0031 + Alltrim(str(nTFE2,6))  //"Limiares Aceitáveis.......: "
		Somalinha()
		@Li,070 PSay STR0032 + Alltrim(str(nTFD3,6)) //"Sugestivo de PAIR.....: "
		@Li,103 PSay STR0032 + Alltrim(str(nTFE3,6)) //"Sugestivo de PAIR.....: "
		Somalinha()
		@Li,070 PSay STR0033 + Alltrim(str(nTFD4,6)) //"Nao Sugestivo de PAIR.....: "
		@Li,103 PSay STR0033 + Alltrim(str(nTFE4,6)) //"Nao Sugestivo de PAIR.....: "
		Somalinha()
		@Li,070 PSay STR0034 + Alltrim(str(nTFD5,6)) //"Sugestivo Desencadeamento.: "
		@Li,103 PSay STR0034 + Alltrim(str(nTFE5,6)) //"Sugestivo Desencadeamento.: "
		Somalinha()
		@Li,070 PSay STR0035 + Alltrim(str(nTFD6,6)) //"Sugestivo Agravamento.....: "
		@Li,103 PSay STR0035 + Alltrim(str(nTFE6,6)) //"Sugestivo Agravamento.....: "
		Somalinha()
		@Li,070 PSay STR0036 + Alltrim(str(nTFD7,6)) //"Perda de Audição..........: "
		@Li,103 PSay STR0036 + Alltrim(str(nTFE7,6)) //"Perda de Audição..........: "

		SomaLinha()
		@Li,000 PSay Replicate("_",132)
		SomaLinha()

	END

Else

	dbSelectArea("TRB")
	dbSetOrder(01)
	dbGoTop()
	While !EOF()
	    ccSalvo  := TRB->CC
	    cMat   	 := " "
		nTSetor  := 0
		nTD1 := 0
		nTD2 := 0
		nTD3 := 0
		nTD4 := 0
		nTD5 := 0
		nTD6 := 0
		nTD7 := 0

		nTE1 := 0
		nTE2 := 0
		nTE3 := 0
		nTE4 := 0
		nTE5 := 0
		nTE6 := 0
		nTE7 := 0
	    somalinha()
	    @ Li,000 PSay STR0008 + Alltrim(TRB->CC) + " - " + TRB->DESCCC //"Centro de Custo: "
	    somalinha()
		While !Eof().and.TRB->CC == ccSalvo

	    	somalinha()
	    	If cMat != TRB->MAT .or. lImpmat
		    	@ Li,000 PSay TRB->MAT
				@ Li,010 PSay Substr(TRB->NOME,1,28)
				@ Li,040 PSay TRB->DTNASC
				@ Li,050 PSay TRB->DTADMISSA
			EndIf
			@ Li,060 Psay TRB->DTREF
			cMat := TRB->MAT
			lImpmat := .f.

			If TRB->RESDIR = "1"
				cDRDESC := STR0024  //"Requer Interpretação"
				nTD1++
				nTFD1++
			ElseIf TRB->RESDIR = "2"
				cDRDESC := STR0025  //"Limiares Aceitáveis"
				nTD2++
				nTFD2++
			ElseIf TRB->RESDIR = "3"
				cDRDESC := STR0026  //"Sugestivo do PAIR"
				nTD3++
				nTFD3++
			ElseIf TRB->RESDIR = "4"
		       	cDRDESC := STR0027  //"Não Sugestivo do PAIR"
			   	nTD4++
			   	nTFD4++
			ElseIf TRB->RESDIR = "5"
				cDRDESC := STR0028  //"Sugestivo de Desencadeamento"
				nTD5++
				nTFD5++
			ElseIf TRB->RESDIR = "6"
				cDRDESC := STR0013 //"Sugestivo Agravamento"
				nTD6++
				nTFD6++
			Else
				cDRDESC := STR0029  //"Perda de Audição"
				nTD7++
				nTFD7++
			EndIF

			If TRB->RESESQ = "1"
				cERDESC := STR0024  //"Requer Interpretação"
				nTE1++
				nTFE1++
			ElseIf TRB->RESESQ = "2"
				cERDESC := STR0025  //"Limiares Aceitáveis"
				nTE2++
				nTFE2++
			ElseIf TRB->RESESQ = "3"
				cERDESC := STR0026  //"Sugestivo do PAIR"
				nTE3++
				nTFE3++
			ElseIf TRB->RESESQ = "4"
			   	cERDESC := STR0027  //"Não Sugestivo do PAIR"
			   	nTE4++
			   	nTFE4++
			ElseIf TRB->RESESQ = "5"
				cERDESC := STR0028  //"5ugestivo de Desencadeamento"
				nTE5++
				nTFE5++
			ElseIf TRB->RESESQ = "6"
				cERDESC := STR0013 //"Sugestivo Agravamento"
				nTE6++
				nTFE6++
			Else
				cERDESC := STR0029  //"Perda de Audição"
				nTE7++
				nTFE7++
			EndIF

			@ Li,070 PSay cDRDESC
			@ Li,103 PSay cERDESC
			nTSetor++
			nTFilial++
			dbSelectArea("TRB")
			dbSkip()
		END

		Somalinha()
		Somalinha()
		@Li,000 PSay STR0014 + Alltrim(str(nTSetor,6)) //"Total de Exames no Setor.........: "
		@Li,070 PSay STR0030 + Alltrim(str(nTD1,6)) //"Requer Interpretação......: "
		@Li,103 PSay STR0030 + Alltrim(str(nTE1,6)) //"Requer Interpretação......: "
		Somalinha()
		@Li,070 PSay STR0031 + Alltrim(str(nTD2,6))  //"Limiares Aceitáveis.......: "
		@Li,103 PSay STR0031 + Alltrim(str(nTE2,6))  //"Limiares Aceitáveis.......: "
		Somalinha()
		@Li,070 PSay STR0032 + Alltrim(str(nTD3,6)) //"Sugestivo de PAIR.........: "
		@Li,103 PSay STR0032 + Alltrim(str(nTE3,6)) //"Sugestivo de PAIR.........: "
		Somalinha()
		@Li,070 PSay STR0033 + Alltrim(str(nTD4,6)) //"Nao Sugestivo de PAIR.....: "
		@Li,103 PSay STR0033 + Alltrim(str(nTE4,6)) //"Nao Sugestivo de PAIR.....: "
		Somalinha()
		@Li,070 PSay STR0034 + Alltrim(str(nTD5,6)) //"Sugestivo Desencadeamento.: "
		@Li,103 PSay STR0034 + Alltrim(str(nTE5,6)) //"Sugestivo Desencadeamento.: "
		somalinha()
		@Li,070 PSay STR0035 + Alltrim(str(nTD6,6)) //"Sugestivo de Agravamento..: "
		@Li,103 PSay STR0035 + Alltrim(str(nTE6,6)) //"Sugestivo de Agravamento..: "
		somalinha()
		@Li,070 PSay STR0036 + Alltrim(str(nTD7,6)) //"Perda de Audição..........: "
		@Li,103 PSay STR0036 + Alltrim(str(nTE7,6)) //"Perda de Audição..........: "
		somalinha()
		somalinha()
	END
	somalinha()
	@Li,000 Psay STR0020 + Alltrim(str(nTFilial,6)) //"Total de Exames da Filial........: "
	@Li,070 PSay STR0030 + Alltrim(str(nTFD1,6)) //"Requer Interpretação......: "
	@Li,103 PSay STR0030 + Alltrim(str(nTFE1,6)) //"Requer Interpretação......: "
	Somalinha()
	@Li,070 PSay STR0031 + Alltrim(str(nTFD2,6))  //"Limiares Aceitáveis.......: "
	@Li,103 PSay STR0031 + Alltrim(str(nTFE2,6))  //"Limiares Aceitáveis.......: "
	Somalinha()
	@Li,070 PSay STR0032 + Alltrim(str(nTFD3,6)) //"Sugestivo de PAIR.....: "
	@Li,103 PSay STR0032 + Alltrim(str(nTFE3,6)) //"Sugestivo de PAIR.....: "
	Somalinha()
	@Li,070 PSay STR0033 + Alltrim(str(nTFD4,6)) //"Nao Sugestivo de PAIR.....: "
	@Li,103 PSay STR0033 + Alltrim(str(nTFE4,6)) //"Nao Sugestivo de PAIR.....: "
	Somalinha()
	@Li,070 PSay STR0034 + Alltrim(str(nTFD5,6)) //"Sugestivo Desencadeamento.: "
	@Li,103 PSay STR0034 + Alltrim(str(nTFE5,6)) //"Sugestivo Desencadeamento.: "
	Somalinha()
	@Li,070 PSay STR0035 + Alltrim(str(nTFD6,6)) //"Sugestivo Agravamento.....: "
	@Li,103 PSay STR0035 + Alltrim(str(nTFE6,6)) //"Sugestivo Agravamento.....: "
	Somalinha()
	@Li,070 PSay STR0036 + Alltrim(str(nTFD7,6)) //"Perda de Audição..........: "
	@Li,103 PSay STR0036 + Alltrim(str(nTFE7,6)) //"Perda de Audição..........: "

Endif

Return NIL