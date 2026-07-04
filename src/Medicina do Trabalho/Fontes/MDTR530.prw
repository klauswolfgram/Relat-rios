/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr530.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 3 //Versao do fonte

Static __cArqTab
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR530  ³ Autor ³Denis Hyroshi de Souza ³ Data ³ 04/12/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o | Evolucao funcional dos funcionarios.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MDTR530()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR530()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR530"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Este relatorio apresentara um historico de todas as funcoes ja desenvolvidas"
LOCAL cDesc2  := STR0002 //"pelo funcionario desde sua admissao ate a data corrente, considerando tambem"
LOCAL cDesc3  := STR0003 //"a mudanca de centro de custo ocorrida neste periodo."
LOCAL cString := "SRA"

__cArqTab := cArqTab
Private nTamTable := Len(cArqTab)
PRIVATE cEmpPPP   := SM0->M0_CODIGO
PRIVATE lNGMDTPS  := .F.
PRIVATE lMudEmpr := .f.

PRIVATE nomeprog := "MDTR530"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 }    //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Evolucao Funcional dos Funcionarios."
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cPerg    := ""
PRIVATE cabec1 := "" //Space(5)+STR0009 //"Periodo              C.Custo    Nome Centro de Custo             Funcao  Nome Funcao"
PRIVATE cabec2 := ""
Private cAlias := "SI3"
Private cDescr := "SI3->I3_DESC"
PRIVATE nSizeSI3,nSizeSRJ
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
nSizeSRJ := If((TAMSX3("RJ_FUNCAO")[1]) < 1,5,(TAMSX3("RJ_FUNCAO")[1]))
Private nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))
Private nSizeTD := nTa1+nTa1L
Private cCliMdtPs := ""
Private cF3CC  := "SI3001"
Private cSvFilAnt  := cFilAnt	//Salva a Filial Corrente

Private lSigaMdtPS :=  If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAlias := "CTT"
	cDescr := "CTT->CTT_DESC01"
	cF3CC  := "CTT001"
Endif
If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lNGMDTPS := .T.
Endif
If Alltrim(GETMV("MV_NG2MEMP")) == "S"
	lMudEmpr := .t.
Endif

cCliMdtPs := If(lSigaMdtps,"Z",Space(nSizeTD))

cPerg    := If(lSigaMdtPs,"MDT530PS  ","MDT530    ")

/*--------------------------------------------
//PERGUNTAS PADRÃO								|
| MDT530    ¦01      ¦De  Funcionario ?		|
| MDT530    ¦02      ¦Ate Funcionario ?		|
| MDT530    ¦03      ¦De Centro de Custo ?	|
| MDT530    ¦04      ¦Ate Centro de Custo ?	|
| MDT530    ¦05      ¦De  Funcao ?				|
| MDT530    ¦06      ¦Ate Funcao ?				|
| MDT530    ¦07      ¦Modelo de Impressõo ?	|
|													|
//PERGUNTAS PRESTADOR DE SERVIÇO				|
| MDT530    ¦01      ¦De  Funcionario ?		|
| MDT530    ¦02      ¦Ate Funcionario ?		|
| MDT530    ¦03      ¦De Centro de Custo ?	|
| MDT530    ¦04      ¦Ate Centro de Custo ?	|
| MDT530    ¦05      ¦De  Funcao ?				|
| MDT530    ¦06      ¦Ate Funcao ?				|
| MDT530    ¦07      ¦Modelo de Impressõo ?	|
----------------------------------------------*/

pergunte(cPerg,.F.)

wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

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

RptStatus({|lEnd| R530Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

cArqTab := __cArqTab    //Devolve o valor original por Variavel Estatica

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R530Imp  ³ Autor ³Denis Hyroshi de Souza ³ Data ³04/12/2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR530                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R530Imp(lEnd,wnRel,titulo,tamanho)

LOCAL cCliente := ""
Local nTamMat  := TAMSX3("RA_MAT")[1]
Local oTempTRB
Private nSizeFil := If(lMudEmpr, NGMTAMFIL(),FwSizeFilial())
PRIVATE li := 80 ,m_pag := 1
PRIVATE nAddLi   := 0

nTipo  := IIF(aReturn[4]==1,15,18)

aDBF := {}
AADD(aDBF,{"MATRIC","C",nTamMat,0})
AADD(aDBF,{"NOME"  ,"C",30,0})
AADD(aDBF,{"DTDE"  ,"D",8,0})
AADD(aDBF,{"DTATE" ,"D",8,0})
AADD(aDBF,{"CNPJ"  ,"C",20,0})
AADD(aDBF,{"CBO"   ,"C",06,0})
AADD(aDBF,{"TIPINS","N",01,0})
AADD(aDBF,{"CUSTO" ,"C",nSizeSI3,0})
AADD(aDBF,{"DESCUS","C",25,0})
AADD(aDBF,{"FILIAL","C",nSizeFil,0})
AADD(aDBF,{"MAT"   ,"C",nTamMat,0})
AADD(aDBF,{"CARGO" ,"C",5,0})
AADD(aDBF,{"DESCAR","C",25,0})
AADD(aDBF,{"CODFUN","C",nSizeSRJ,0})
AADD(aDBF,{"DESFUN","C",25,0})
AADD(aDBF,{"GFIP"  ,"C",2,0})
AADD(aDBF,{"EMP"   ,"C",2,0})
AADD(aDBF,{"CODCLI" ,"C",nTa1 ,0})
AADD(aDBF,{"LOJCLI" ,"C",nTa1L,0})
AADD(aDBF,{"SEQ"   ,"C",01,0})

oTempTRB := FWTemporaryTable():New( "TRBPPP", aDBF )
oTempTRB:AddIndex( "1", {"MATRIC","DTDE"} )
oTempTRB:AddIndex( "2", {"CODCLI","LOJCLI","MATRIC","DTDE"} )
oTempTRB:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do Relatorio                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lSigaMdtps

	DbSelectArea("SRA")
	DbSetOrder(1)
	DbSeek(xFilial("SRA")+MV_PAR05,.t.)
	SetRegua(LastRec())
	While !eof() .and. xFilial("SRA") == SRA->RA_FILIAL .and. SRA->RA_MAT <= Mv_par06
		IncRegua()

		cCliente := SubSTR(SRA->RA_CC,1,nSizeTD)

		If cCliente < mv_par01+mv_par02 .OR. cCliente > mv_par03+mv_par04
			DbSelectArea("SRA")
			Dbskip()
			Loop
		Endif

		If lEnd
			@ PROW()+1,001 PSay STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		If SRA->RA_CC < Mv_par07 .or. SRA->RA_CC > Mv_par08
			DbSkip()
			Loop
		Endif
		If SRA->RA_CODFUNC < Mv_par09 .or. SRA->RA_CODFUNC > Mv_par10
			DbSkip()
			Loop
		Endif

		Matricula := SRA->RA_MAT
		U_NG530HISTO(Matricula)
		DbSelectArea("SRA")
		Dbskip()

	End

Else

	DbSelectArea("SRA")
	DbSetOrder(1)
	DbSeek(xFilial("SRA")+MV_PAR01,.t.)
	SetRegua(LastRec())
	While !eof() .and. xFilial("SRA") == SRA->RA_FILIAL .and. SRA->RA_MAT <= Mv_par02
		IncRegua()
		If lEnd
			@ PROW()+1,001 PSay STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		If SRA->RA_CC < Mv_par03 .or. SRA->RA_CC > Mv_par04
			DbSkip()
			Loop
		Endif
		If SRA->RA_CODFUNC < Mv_par05 .or. SRA->RA_CODFUNC > Mv_par06
			DbSkip()
			Loop
		Endif

		Matricula := SRA->RA_MAT
		U_NG530HISTO(Matricula)
		DbSelectArea("SRA")
		Dbskip()

	End

Endif


/*
          1         2         3         4         5         6         7         8         9         0         1        12        13
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
 Matricula.: XXXXXX - XXXXXXXXXXXXXXXXXXXX
  __________________________________________________________________________________________________________________________________
 |Periodo                |CNPJ/CEI        |Setor                    |Cargo                    |Funcao                   |CBO   |GFIP|
 |_______________________|________________|_________________________|_________________________|_________________________|______|____|
 |########## a ##########|################|#########################|#########################|#########################|######|##  |
 |_______________________|________________|_________________________|_________________________|_________________________|______|____|
 |########## a ##########|################|#########################|#########################|#########################|######|##  |
 |_______________________|________________|_________________________|_________________________|_________________________|______|____|
 |########## a ##########|################|#########################|#########################|#########################|######|##  |
 |_______________________|________________|_________________________|_________________________|_________________________|______|____|
*/
l1st := .t.

If lSigaMdtps

	cCliSA1 := "X"
	Dbselectarea("TRBPPP")
	dbSetOrder(2)
	Dbgotop()
	While !eof()
		If !l1st
			Somalinha()
		Endif

		l1st := .f.
		cMat := TRBPPP->MATRIC
		If cCliSA1 <> TRBPPP->CODCLI+TRBPPP->LOJCLI
			cCliSA1 := TRBPPP->CODCLI+TRBPPP->LOJCLI
			Dbselectarea("SA1")
			Dbsetorder(1)
			Dbseek(xFilial("SA1")+TRBPPP->CODCLI+TRBPPP->LOJCLI)
			li := 80
			Somalinha()
			@li,000 Psay "Cliente: "+Alltrim(TRBPPP->CODCLI)+' - '+;
									 Alltrim(TRBPPP->LOJCLI)+' - '+;
									 Alltrim(SA1->A1_NOME)
			Somalinha()
		Endif

		Dbselectarea("SRA")
		Dbsetorder(1)
		Dbseek(xFilial("SRA")+TRBPPP->MATRIC)

		Somalinha()
		@li,000 Psay STR0008+Alltrim(TRBPPP->MATRIC)+' - '+Alltrim(SRA->RA_NOME) //"Matricula..: "
		Somalinha()
		@li,000 Psay " __________________________________________________________________________________________________________________________________ "
		Somalinha()
		If mv_par11 == 1
			@li,000 Psay STR0013 //"|Periodo               |CNPJ/CEI        |Setor                    |Cargo                     |Função                   |CBO   |GFIP|"
			Somalinha()
			@li,000 Psay "|______________________|________________|_________________________|__________________________|_________________________|______|____|"
		Else
			If nSizeSi3 == 9
				@li,000 Psay STR0014 //"|Periodo               |Setor      |Descrição Setor          |Cargo                     |Função |Descrição Função      |CBO   |GFIP|"
				Somalinha()
				@li,000 Psay "|______________________|___________|_________________________|__________________________|_______|______________________|______|____|"
			Else
				@li,000 Psay STR0015 //"|Periodo               |Setor                                |Cargo                     |Função                        |CBO   |GFIP|"
				Somalinha()
				@li,000 Psay "|______________________|_____________________________________|__________________________|______________________________|______|____|"
			Endif

		EndIf
		lContrInd := .f.

		Dbselectarea("TRBPPP")
		While !eof() .and. cMat = TRBPPP->MATRIC
			If lContrInd .and. li == 8
				@li,000 Psay " __________________________________________________________________________________________________________________________________ "
			Endif
			Somalinha()
			If lContrInd .and. li == 8
				@li,000 Psay " __________________________________________________________________________________________________________________________________ "
				Somalinha()
			Endif
			@li,000 Psay "|"
			@li,001 Psay TRBPPP->DTDE
			@li,011 Psay "-"
			@li,013 Psay TRBPPP->DTATE
			@li,023 Psay "|"
			If mv_par11 == 1
				@li,024 Psay TRBPPP->CNPJ PICTURE IF(TRBPPP->TIPINS==2,"@R 99999999/9999-99","@R 99.999.99999/99")
				@li,040 Psay "|"
				@li,041 Psay SUBSTR(TRBPPP->DESCUS,1,25)
				@li,066 Psay "|"
				@li,067 Psay SUBSTR(TRBPPP->DESCAR,1,25)
				@li,093 Psay "|"
				@li,094 Psay SUBSTR(TRBPPP->DESFUN,1,25)
			Else
				If nSizeSi3 == 9
					@li,024 Psay TRBPPP->CUSTO
					@li,035 Psay "|"
					@li,036 Psay SUBSTR(TRBPPP->DESCUS,1,24)
					@li,061 Psay "|"
					@li,062 Psay SUBSTR(TRBPPP->DESCAR,1,25)
					@li,088 Psay "|"
					@li,089 Psay TRBPPP->CODFUN
					@li,096 Psay "|"
					@li,097 Psay SUBSTR(TRBPPP->DESFUN,1,21)
				Else
					@li,024 Psay SUBSTR(Alltrim(TRBPPP->CUSTO)+" -"+TRBPPP->DESCUS,1,37)
					@li,061 Psay "|"
					@li,062 Psay SUBSTR(TRBPPP->DESCAR,1,25)
					@li,088 Psay "|"
					@li,089 Psay SUBSTR(TRBPPP->CODFUN+" -"+TRBPPP->DESFUN,1,30)
				Endif
			EndIf
			@li,119 Psay "|"
			@li,120 Psay TRBPPP->CBO
			@li,126 Psay "|"
			@li,127 Psay TRBPPP->GFIP
			@li,131 Psay "|"
			If mv_par11 == 1
				@li+1,000 Psay "|______________________|________________|_________________________|__________________________|_________________________|______|____|"
			ElseIf nSizeSi3 == 9
				@li+1,000 Psay "|______________________|___________|_________________________|__________________________|_______|______________________|______|____|"
			Else
				@li+1,000 Psay "|______________________|_____________________________________|__________________________|______________________________|______|____|"
			EndIf
			Somalinha()
			lContrInd := .t.

			Dbskip()
		End
	End

Else

	Dbselectarea("TRBPPP")
	dbSetOrder(1)
	Dbgotop()
	While !eof()
		If !l1st
			Somalinha()
		Endif

		l1st := .f.
		cMat := TRBPPP->MATRIC

		Dbselectarea("SRA")
		Dbsetorder(1)
		Dbseek(xFilial("SRA")+TRBPPP->MATRIC)

		Somalinha()
		@li,000 Psay STR0008+Alltrim(TRBPPP->MATRIC)+' - '+Alltrim(SRA->RA_NOME) //"Matricula..: "
		Somalinha()
		@li,000 Psay " __________________________________________________________________________________________________________________________________ "
		Somalinha()
		If mv_par07 == 1
			@li,000 Psay STR0013 //"|Periodo               |CNPJ/CEI        |Setor                    |Cargo                     |Função                   |CBO   |GFIP|"
			Somalinha()
			@li,000 Psay "|______________________|________________|_________________________|__________________________|_________________________|______|____|"
		Else
			If nSizeSi3 == 9
				@li,000 Psay STR0014 //"|Periodo               |Setor      |Descrição Setor          |Cargo                     |Função |Descrição Função      |CBO   |GFIP|"
				Somalinha()
				@li,000 Psay "|______________________|___________|_________________________|__________________________|_______|______________________|______|____|"
			Else
				@li,000 Psay STR0015 //"|Periodo               |Setor                                |Cargo                     |Função                        |CBO   |GFIP|"
				Somalinha()
				@li,000 Psay "|______________________|_____________________________________|__________________________|______________________________|______|____|"
			Endif

		EndIf
		lContrInd := .f.

		Dbselectarea("TRBPPP")
		While !eof() .and. cMat = TRBPPP->MATRIC
			If lContrInd .and. li == 8
				@li,000 Psay " __________________________________________________________________________________________________________________________________ "
			Endif
			Somalinha()
			If lContrInd .and. li == 8
				@li,000 Psay " __________________________________________________________________________________________________________________________________ "
				Somalinha()
			Endif
			@li,000 Psay "|"
			@li,001 Psay TRBPPP->DTDE
			@li,011 Psay "-"
			@li,013 Psay TRBPPP->DTATE
			@li,023 Psay "|"
			If mv_par07 == 1
				@li,024 Psay TRBPPP->CNPJ PICTURE IF(TRBPPP->TIPINS==2,"@R 99999999/9999-99","@R 99.999.99999/99")
				@li,040 Psay "|"
				@li,041 Psay SUBSTR(TRBPPP->DESCUS,1,25)
				@li,066 Psay "|"
				@li,067 Psay SUBSTR(TRBPPP->DESCAR,1,25)
				@li,093 Psay "|"
				@li,094 Psay SUBSTR(TRBPPP->DESFUN,1,25)
			Else
				If nSizeSi3 == 9
					@li,024 Psay TRBPPP->CUSTO
					@li,035 Psay "|"
					@li,036 Psay SUBSTR(TRBPPP->DESCUS,1,24)
					@li,061 Psay "|"
					@li,062 Psay SUBSTR(TRBPPP->DESCAR,1,25)
					@li,088 Psay "|"
					@li,089 Psay TRBPPP->CODFUN
					@li,096 Psay "|"
					@li,097 Psay SUBSTR(TRBPPP->DESFUN,1,21)
				Else
					@li,024 Psay SUBSTR(Alltrim(TRBPPP->CUSTO)+" -"+TRBPPP->DESCUS,1,37)
					@li,061 Psay "|"
					@li,062 Psay SUBSTR(TRBPPP->DESCAR,1,25)
					@li,088 Psay "|"
					@li,089 Psay SUBSTR(TRBPPP->CODFUN+" -"+TRBPPP->DESFUN,1,30)
				Endif
			EndIf
			@li,119 Psay "|"
			@li,120 Psay TRBPPP->CBO
			@li,126 Psay "|"
			@li,127 Psay TRBPPP->GFIP
			@li,131 Psay "|"
			If mv_par07 == 1
				@li+1,000 Psay "|______________________|________________|_________________________|__________________________|_________________________|______|____|"
			ElseIf nSizeSi3 == 9
				@li+1,000 Psay "|______________________|___________|_________________________|__________________________|_______|______________________|______|____|"
			Else
				@li+1,000 Psay "|______________________|_____________________________________|__________________________|______________________________|______|____|"
			EndIf
			Somalinha()
			lContrInd := .t.

			Dbskip()
		End
	End

Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SRA")

oTempTRB:Delete()

Set Filter To

Set device to Screen

If aReturn[5] = 1
        Set Printer To
        dbCommitAll()
        OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()
DbSelectArea("SRA")
dbSetOrder(01)

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³Denis Hyroshi de Souza ³ Data ³ 05/12/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha inicial                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha()
    Li ++
    If Li > 58
       Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    Endif
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³NG530HISTO³ Autor ³Denis Hyroshi de Souza ³ Data ³ 05/12/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Carrega os dados do historico do funcionario               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function NG530HISTO(cMatr)
Local aHistory := {},nWWW,nXYZ,nBeg
Local nSizeSRE    := If(TAMSX3("RE_FILIALD")[1] > 0, TAMSX3("RE_FILIALD")[1], Len(SRE->RE_FILIALD))
Local cCBO        := " " // Guarda o CBO da Funcao
Local lFimPPP     := .f. // Verifica se acabou o historico de setores
Local dINIPPP     := SRA->RA_ADMISSA //Data Inicio do PPP
Local dFIMPPP     := If(empty(SRA->RA_DEMISSA),dDataBase,SRA->RA_DEMISSA) // Data limite p/ uma transferencia
Local dFINALPPP   := dFIMPPP //Data final do PPP
Local aDadosPPP   := {} //Grava dados do historico de setores
Local cDesFunPPP  := Space(25) //Descricao da Funcao do periodo anterior
Local cDesFunFOR  := Space(25) //Descricao da Funcao do periodo anterior
Local cFuncaoPPP  := Space(Len(SRA->RA_CODFUNC)) // Funcao do periodo anterior
Local cFuncaoFOR  := Space(Len(SRA->RA_CODFUNC)) // Funcao do periodo anterior
Local cCargoPPP   := Space(5)
Local cCargoFOR   := Space(5)
Local lAchou      := .t. //Variavel de Controle
Local lInicio     := .t. //Variavel de Controle
Local dDataFOR    := ctod("  /  /  ")
Local cKeyEmp     := SM0->M0_CODIGO // Empresa origem
Local cKeyFil     := Padr(SRA->RA_FILIAL,nSizeSRE)// Filial origem
Local cKeyMat     := SRA->RA_MAT // Matricula origem
Local cKeyCus     := SRA->RA_CC // Centro Custo origem
Local cCondCus    := Space(Len(SRA->RA_CC))
Local cCondALL    := Space(10)
Local lFirstSRE   := .t. //Indica se eh o primeiro SRE
Local lFirst      := .t.
Local lAchouSRE   := .f.
Local nTotRegPPP  := 0,nRegPPP := 0
Local lPrimeiro   := .t.,_dFimPPP  := ctod("  /  /  ")
Local cFunAnter   := Space(5) //Funcao Anterior, para verificar se nao esta gravando funcao igual
Local cCarAnter   := Space(5)
Local cRA_CODFUNC := SRA->RA_CODFUNC //Se nao achar transf. de funcao o programa adota a funcao atual
Local lCposSR7    := If(Empty(SRA->RA_CARGO),.f.,.t.)
Local cRA_CARGO   := If(lCposSR7,SRA->RA_CARGO,Space(5)) //Se nao achar transf. de funcao o programa adota a funcao atual
Local aMatriculas := {}
Local cModoSRA,cXFilSRA,cModoCTT,cXFilCTT,cModoSRJ,cXFilSRJ,cModoSQ3,cXFilSQ3,cModoSR9,cXFilSR9

lFirstSRE := .t.
lFimPPP   := .f.
While !lFimPPP
	lPrimeiro := .t.
	_dFimPPP  := ctod("  /  /  ")
	cCondCus  := cKeyCus
	cCondALL  := cKeyEmp+cKeyFil+cKeyMat
	Dbselectarea("SRE")
	Dbsetorder(2)
	Dbseek(cCondALL)
	While !eof() .and. cCondALL == SRE->RE_EMPP+SRE->RE_FILIALP+SRE->RE_MATP

			If SRE->RE_EMPP == SRE->RE_EMPD .and. SRE->RE_FILIALP == SRE->RE_FILIALD .and. ;
				SRE->RE_MATP == SRE->RE_MATD .and. SRE->RE_CCP == SRE->RE_CCD
				Dbselectarea("SRE")
				Dbskip()
				Loop
			Endif

			If (If(lFirstSRE,SRE->RE_DATA > dFIMPPP,SRE->RE_DATA >= dFIMPPP)) .or. ;
				SRE->RE_DATA < dINIPPP
				Dbselectarea("SRE")
				Dbskip()
				Loop
			Endif
			If SRE->RE_CCP != cCondCus
				Dbselectarea("SRE")
				Dbskip()
				Loop
			Endif

			lFirstSRE := .f.
			If lPrimeiro
				If lMudEmpr
					cKeyEmp := SRE->RE_EMPD
				Endif
				cKeyFil := SRE->RE_FILIALD
				cKeyMat := SRE->RE_MATD
				cKeyCus := SRE->RE_CCD
				aADD(aDadosPPP,{SRE->RE_DATA,dFimPPP,SRE->RE_FILIALP,SRE->RE_MATP,SRE->RE_CCP,SRE->RE_EMPP})
				_dFimPPP := SRE->RE_DATA
			Else
				If SRE->RE_DATA > aDadosPPP[Len(aDadosPPP)][1]
					If lMudEmpr
						cKeyEmp := SRE->RE_EMPD
					Endif
					cKeyFil := SRE->RE_FILIALD
					cKeyMat := SRE->RE_MATD
					cKeyCus := SRE->RE_CCD
					aDadosPPP[Len(aDadosPPP)][1] := SRE->RE_DATA
					_dFimPPP := SRE->RE_DATA
				Endif
			Endif
			lPrimeiro := .f.

			If SRE->RE_EMPD != cEmpPPP 	.and. !lMudEmpr// O funcionario esta mudando de empresa, portanto, o processo para aqui
				lFimPPP := .t.
			Else
				lFimPPP := .f.
			Endif

			Dbselectarea("SRE")
			Dbskip()
	End
	If lPrimeiro
		lFimPPP := .t.
		If SRA->RA_ADMISSA < dFimPPP
			aADD(aDadosPPP,{SRA->RA_ADMISSA,dFimPPP,cKeyFil,cKeyMat,cKeyCus,cKeyEmp})
		Endif
	Else
		dFimPPP := _dFimPPP
    Endif
End

If Len(aDadosPPP) == 0
	aADD(aDadosPPP,{SRA->RA_ADMISSA,dFINALPPP,SRA->RA_FILIAL,SRA->RA_MAT,SRA->RA_CC,SM0->M0_CODIGO})
Endif

If Len(aDadosPPP) > 1
	For nWWW := Len(aDadosPPP) to 1 Step -1
		cFilSR7 := Substr(aDadosPPP[nWWW][3],1,FwSizeFilial(aDadosPPP[nWWW][6]))
		If lMudEmpr .and. aDadosPPP[nWWW][6] != cEmpPPP
			cModo := FWModeAccess("SR7")
			U_EMP530OPEN("SR7","SR7",1,aDadosPPP[nWWW][6],@cModo,cFilSR7)
		Endif
		cModoSR7 := f700RetCom("SR7")
		cXFilSR7 := FwxFilial("SR7",cFilSR7,Substr(cModoSR7,1,1),Substr(cModoSR7,2,1),Substr(cModoSR7,3,1))

		cSeqSR7 := "Z"
		Dbselectarea("SR7")
		Dbsetorder(1)
		Dbseek(cXFilSR7+aDadosPPP[nWWW][4]+DTOS(dINIPPP))
		While !Eof() .and. SR7->(R7_FILIAL+R7_MAT+DTOS(R7_DATA)) == cXFilSR7+aDadosPPP[nWWW][4]+DTOS(dINIPPP)
			If SR7->R7_SEQ <= cSeqSR7
				cFuncaoPPP := SR7->R7_FUNCAO
				cDesFunPPP := SR7->R7_DESCFUN
				cSeqSR7    := SR7->R7_SEQ
				If lCposSR7
					cCargoPPP  := SR7->R7_CARGO
				Endif
			Endif
			Dbselectarea("SR7")
			dbSkip()
		End

		If lMudEmpr .and. aDadosPPP[nWWW][6] != cEmpPPP
			U_EMP530OPEN("SR7","SR7",1,cEmpPPP,@cModo)
		Endif
		If cSeqSR7 <> "Z"
			Exit
		Endif
	Next nWWW
Else
	cFuncaoPPP := SRA->RA_CODFUNC
Endif

lAchouSRE := .f.

aSRArea := SRA->(GetArea())
For nXYZ := Len(aDadosPPP) to 1 Step -1
	If nXYZ != Len(aDadosPPP)
		cFunAnter := cFuncaoPPP
		If lCposSR7
			cCarAnter := cCargoPPP
		Endif
	Else
		cFunAnter := Space(5)
		If lCposSR7
			cCarAnter := Space(5)
		Endif
	Endif
	cFilMat := Substr(aDadosPPP[nXYZ][3],1,FwSizeFilial(aDadosPPP[nXYZ][6]))
	If (aScan(aMatriculas,{|x| x[1]+x[2]+x[3] == cFilMat+aDadosPPP[nXYZ][4]+;
																				aDadosPPP[nXYZ][6]})) <= 0
		aADD(aMatriculas,{cFilMat,aDadosPPP[nXYZ][4],aDadosPPP[nXYZ][6]})//MAtriculas Utilizadas pelo funcionario na empresa
	Endif

	aAreaAtual := {}
	aAreaVelha := {}
	dDtTermino := CtoD("  /  /    ")
	lAchou     := .t.
	lInicio    := .t.
	lFirst     := .t.

	If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
		cModo := FWModeAccess("SR7")
		U_EMP530OPEN("SR7","SR7",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
		cModo := FWModeAccess("SRJ")
		U_EMP530OPEN("SRJ","SRJ",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
		cModo := FWModeAccess("SQ3")
		EMP700OPEN("SQ3","SQ3",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
	Endif

	cModoSR7 := f700RetCom("SR7")
	cXFilSR7 := FwxFilial("SR7",cFilMat,Substr(cModoSR7,1,1),Substr(cModoSR7,2,1),Substr(cModoSR7,3,1))

	cModoSRJ := f700RetCom("SRJ")
	cXFilSRJ := FwxFilial("SRJ",cFilMat,Substr(cModoSRJ,1,1),Substr(cModoSRJ,2,1),Substr(cModoSRJ,3,1))

	cModoSQ3 := f700RetCom("SQ3")
	cXFilSQ3 := FwxFilial("SQ3",cFilMat,Substr(cModoSQ3,1,1),Substr(cModoSQ3,2,1),Substr(cModoSQ3,3,1))

	Dbselectarea("SR7")
	Dbsetorder(1)
	Dbseek(cFilMat+aDadosPPP[nXYZ][4]+Dtos(aDadosPPP[nXYZ][1]),.t.)
	While !eof() .and. cFilMat+aDadosPPP[nXYZ][4] == SR7->R7_FILIAL+SR7->R7_MAT .and.;
		(If(nXYZ != 1,SR7->R7_DATA < aDadosPPP[nXYZ][2],SR7->R7_DATA <= aDadosPPP[nXYZ][2]))

		cCNPJ := Space(10)
		nTIPINS := 2
		aAreaEMP := SM0->(GetArea())

		If lNGMDTPS .OR. lSigaMdtPS
			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				cModo := FWModeAccess("SA1")
				U_EMP530OPEN("SA1","SA1",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
			Endif

			cModoSA1 := f700RetCom("SA1")
			cXFilSA1 := FwxFilial("SA1",cFilMat,Substr(cModoSA1,1,1),Substr(cModoSA1,2,1),Substr(cModoSA1,3,1))

			nTamSub := nTa1+nTa1L
			If !lSigaMdtPS
				nTamSub := nTa1
			Endif
			Dbselectarea("SA1")
			Dbsetorder(1)
			Dbseek(cXFilSA1+Substr(aDadosPPP[nXYZ][5],1,nTamSub))
			cCNPJ := SA1->A1_CGC

			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				U_EMP530OPEN("SA1","SA1",1,cEmpPPP,@cModo)
			Endif
		Else
			Dbselectarea("SM0")
			Dbseek(aDadosPPP[nXYZ][6]+cFilMat)
			cCNPJ := SM0->M0_CGC
			nTIPINS := SM0->M0_TPINSC
		Endif
		RestArea(aAreaEMP)

		Dbselectarea("SRJ")
		Dbsetorder(1)
		Dbseek(cXFilSRJ+SR7->R7_FUNCAO)

		Dbselectarea("SQ3")
		Dbsetorder(1)
		Dbseek(cXFilSQ3+If(lCposSR7,SR7->R7_CARGO,SRJ->RJ_CARGO))

		Dbselectarea("TRBPPP")
		Dbsetorder(1)
		If !Dbseek(cMatr+DTOS(SR7->R7_DATA)) .and. (SR7->R7_FUNCAO != cFunAnter .or. If(lCposSR7,SR7->R7_CARGO != cCarAnter,.f.))
			lAchouSRE := .t.
			Reclock("TRBPPP",.t.)
			TRBPPP->MATRIC := cMatr
			TRBPPP->DTDE   := SR7->R7_DATA
			TRBPPP->DTATE  := aDadosPPP[nXYZ][2]
			TRBPPP->CNPJ   := cCNPJ
			TRBPPP->TIPINS := nTIPINS
			TRBPPP->SEQ    := SR7->R7_SEQ
			TRBPPP->FILIAL := cFilMat
			TRBPPP->MAT    := aDadosPPP[nXYZ][4]
			TRBPPP->CUSTO  := aDadosPPP[nXYZ][5]
			TRBPPP->EMP    := aDadosPPP[nXYZ][6]
			TRBPPP->CARGO  := If(lCposSR7,SR7->R7_CARGO,SRJ->RJ_CARGO)
			TRBPPP->CODFUN := SR7->R7_FUNCAO
			TRBPPP->DESFUN := If(!Empty(SR7->R7_DESCFUN),SR7->R7_DESCFUN,SRJ->RJ_DESC)
			Msunlock("TRBPPP")
			cFunAnter := SR7->R7_FUNCAO
			If lCposSR7
				cCarAnter := SR7->R7_CARGO
			Endif
		Else
			Dbselectarea("SR7")
			Dbskip()
			Loop
		Endif

		//Guarda ultimo registro do arquivo de trabalho TRBPPP. Para alterar a data fim no proximo laco.
		aAreaAtual := TRBPPP->(GetArea())

		cFuncaoFOR := SR7->R7_FUNCAO
		cDesFunFOR := SR7->R7_DESCFUN
		If lCposSR7
			cCargoFOR  := SR7->R7_CARGO
		Endif

		dDtTermino := SR7->R7_DATA //Variavel para alterar a data fim do registro anterior
		cSeqTabR7  := TRBPPP->SEQ

		lVelha := .t.
		If lFirst //Se for a primeira vez que entrou no laco
			dDataFOR := SR7->R7_DATA
			lFirst := .f.
		Else
			RestArea(aAreaVelha)
			If !eof() .and. !bof()
				If dDtTermino == TRBPPP->DTDE .and. TRBPPP->SEQ > cSeqTabR7
					cFunAnter := TRBPPP->CODFUN
					If lCposSR7
						cCarAnter := TRBPPP->CARGO
					Endif
					RestArea(aAreaAtual)
					lVelha := .f.
				Endif
				Reclock("TRBPPP",.f.)
				TRBPPP->DTATE  := dDtTermino //Altera a data fim do registro anterior
				Msunlock("TRBPPP")
			Endif
			RestArea(aAreaAtual)
		Endif
		If lVelha
			aAreaVelha := TRBPPP->(GetArea())
		Else

		Endif

		If aDadosPPP[nXYZ][1] == SR7->R7_DATA
			//Variavel de controle. Para saber se existe mudanca de funcao no comeco da transferencia
			lInicio := .f.
		Endif

		//Variavel de controle. Para saber se houve mudanca de funcao
		lAchou := .f.

		Dbselectarea("SR7")
		Dbskip()
	End

	If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
		U_EMP530OPEN("SR7","SR7",1,cEmpPPP,@cModo)
		EMP700OPEN("SQ3","SQ3",1,cEmpPPP,@cModo)
	Endif

	If lAchou // se nao achou nenhuma mudanca de funcao
		cCNPJ := Space(10)
		nTIPINS := 2
		aAreaEMP := SM0->(GetArea())

		If lNGMDTPS .or. lSigaMdtPS
			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				cModo := FWModeAccess("SA1")
				U_EMP530OPEN("SA1","SA1",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
			Endif
			cModoSA1 := f700RetCom("SA1")
			cXFilSA1 := FwxFilial("SA1",cFilMat,Substr(cModoSA1,1,1),Substr(cModoSA1,2,1),Substr(cModoSA1,3,1))

			nTamSub := nTa1+nTa1L
			If !lSigaMdtPS
				nTamSub := nTa1
			Endif
			Dbselectarea("SA1")
			Dbsetorder(1)
			Dbseek(cXFilSA1+Substr(aDadosPPP[nXYZ][5],1,nTamSub))
			cCNPJ := SA1->A1_CGC

			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				U_EMP530OPEN("SA1","SA1",1,cEmpPPP,@cModo)
			Endif
		Else
			Dbselectarea("SM0")
			Dbseek(aDadosPPP[nXYZ][6]+cFilMat)
			cCNPJ := SM0->M0_CGC
			nTIPINS := SM0->M0_TPINSC
		Endif
		RestArea(aAreaEMP)

		Dbselectarea("SRJ")
		Dbsetorder(1)
		Dbseek(cXFilSRJ+cFuncaoPPP)

		Dbselectarea("SQ3")
		Dbsetorder(1)
		Dbseek(cXFilSQ3+If(lCposSR7,cCargoPPP,SRJ->RJ_CARGO))

		Dbselectarea("TRBPPP")
		Dbsetorder(1)
		If !Dbseek(cMatr+DTOS(aDadosPPP[nXYZ][1]))
			Reclock("TRBPPP",.t.)
			TRBPPP->MATRIC := cMatr
			TRBPPP->DTDE   := aDadosPPP[nXYZ][1]
			TRBPPP->DTATE  := aDadosPPP[nXYZ][2]
			TRBPPP->CNPJ   := cCNPJ
			TRBPPP->TIPINS := nTIPINS
			TRBPPP->CUSTO  := aDadosPPP[nXYZ][5]
			TRBPPP->FILIAL := cFilMat
			TRBPPP->EMP    := aDadosPPP[nXYZ][6]
			TRBPPP->MAT    := aDadosPPP[nXYZ][4]
			TRBPPP->CARGO  := If(lCposSR7,cCargoPPP,SRJ->RJ_CARGO)
			TRBPPP->CODFUN := cFuncaoPPP
			TRBPPP->DESFUN := If(Empty(cDesFunPPP),SRJ->RJ_DESC,cDesFunPPP)
			cFuncaoFOR   := cFuncaoPPP
			cDesFunFOR   := cDesFunPPP
			If lCposSR7
				cCargoFOR    := If(lCposSR7,cCargoPPP,SRJ->RJ_CARGO)
			Endif
			Msunlock("TRBPPP")
		Endif
	Elseif lInicio // se nao achou nenhuma mudanca de funcao no inicio da mudanca de setor
		cCNPJ := Space(10)
		nTIPINS := 2
		aAreaEMP := SM0->(GetArea())

		If lNGMDTPS .or. lSigaMdtPS
			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				cModo := FWModeAccess("SA1")
				U_EMP530OPEN("SA1","SA1",1,aDadosPPP[nXYZ][6],@cModo,cFilMat)
			Endif

			cModoSA1 := f700RetCom("SA1")
			cXFilSA1 := FwxFilial("SA1",cFilMat,Substr(cModoSA1,1,1),Substr(cModoSA1,2,1),Substr(cModoSA1,3,1))

			nTamSub := nTa1+nTa1L
			If !lSigaMdtPS
				nTamSub := nTa1
			Endif
			Dbselectarea("SA1")
			Dbsetorder(1)
			Dbseek(cXFilSA1+Substr(aDadosPPP[nXYZ][5],1,nTamSub))
			cCNPJ := SA1->A1_CGC

			If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
				U_EMP530OPEN("SA1","SA1",1,cEmpPPP,@cModo)
			Endif
		Else
			Dbselectarea("SM0")
			Dbseek(aDadosPPP[nXYZ][6]+cFilMat)
			cCNPJ := SM0->M0_CGC
			nTIPINS := SM0->M0_TPINSC
		Endif
		RestArea(aAreaEMP)

		Dbselectarea("SRJ")
		Dbsetorder(1)
		Dbseek(cXFilSRJ+cFuncaoPPP)

		Dbselectarea("SQ3")
		Dbsetorder(1)
		Dbseek(cXFilSQ3+If(lCposSR7,cCargoPPP,SRJ->RJ_CARGO))

		Dbselectarea("TRBPPP")
		Dbsetorder(1)
		If !Dbseek(cMatr+DTOS(aDadosPPP[nXYZ][1]))
			Reclock("TRBPPP",.t.)
			TRBPPP->MATRIC := cMatr
			TRBPPP->DTDE   := aDadosPPP[nXYZ][1]
			TRBPPP->DTATE  := dDataFOR
			TRBPPP->CNPJ   := cCNPJ
			TRBPPP->TIPINS := nTIPINS
			TRBPPP->CUSTO  := aDadosPPP[nXYZ][5]
			TRBPPP->FILIAL := cFilMat
			TRBPPP->EMP    := aDadosPPP[nXYZ][6]
			TRBPPP->MAT    := aDadosPPP[nXYZ][4]
			TRBPPP->CARGO  := If(lCposSR7,cCargoPPP,SRJ->RJ_CARGO)
			TRBPPP->CODFUN := cFuncaoPPP
			If !Empty(SRJ->RJ_DESC)
				TRBPPP->DESFUN := SRJ->RJ_DESC
			Else
				TRBPPP->DESFUN := cDesFunPPP
			Endif
			Msunlock("TRBPPP")
		Endif
	Endif
	cFuncaoPPP := cFuncaoFOR
	cDesFunPPP := cDesFunFOR
	If lCposSR7
		cCargoPPP  := cCargoFOR
	Endif
	If lMudEmpr .and. aDadosPPP[nXYZ][6] != cEmpPPP
		U_EMP530OPEN("SRJ","SRJ",1,cEmpPPP,@cModo)
	Endif
Next
RestArea(aSRArea)

If !lAchouSRE
	Begin Sequence
		Dbselectarea("SRJ")
		Dbsetorder(1)
		If Dbseek(xFilial("SRJ")+cRA_CODFUNC)
			If lCposSR7
				Dbselectarea("SQ3")
				Dbsetorder(1)
				Dbseek(xFilial("SQ3")+cRA_CARGO)
			Endif

			Dbselectarea("TRBPPP")
			Dbsetorder(1)
			Dbseek(cMatr)
			While !eof() .and. TRBPPP->MATRIC == cMatr
				RecLock("TRBPPP",.f.)
				TRBPPP->CODFUN := cRA_CODFUNC
				TRBPPP->DESFUN := SRJ->RJ_DESC
				TRBPPP->CARGO  := SRJ->RJ_CARGO
				If lCposSR7
					TRBPPP->CARGO  := cRA_CARGO
				Endif
				MsUnLock("TRBPPP")
				Dbskip()
			End
			Break
		Endif
		For nBeg := Len(aMatriculas) to 1 step -1
			If lMudEmpr .and. aMatriculas[nBeg][3] != cEmpPPP
				cModo := FWModeAccess("SRJ")
				U_EMP530OPEN("SRJ","SRJ",1,aMatriculas[nBeg][3],@cModo,aMatriculas[nBeg][1])
			Endif
			Dbselectarea("SRJ")
			Dbsetorder(1)
			If Dbseek(xFilial("SRJ",aMatriculas[nBeg,1])+cRA_CODFUNC)
				Dbselectarea("TRBPPP")
				Dbsetorder(1)
				Dbseek(cMatr)
				While !eof() .and. TRBPPP->MATRIC == cMatr
					RecLock("TRBPPP",.f.)
					TRBPPP->CODFUN := cRA_CODFUNC
					TRBPPP->DESFUN := SRJ->RJ_DESC
					TRBPPP->CARGO  := SRJ->RJ_CARGO
					MsUnLock("TRBPPP")
					Dbskip()
				End
				Break
			Endif
			If lMudEmpr .and. aMatriculas[nBeg][3] != cEmpPPP
				U_EMP530OPEN("SRJ","SRJ",1,cEmpPPP,@cModo)
			Endif
		Next nBeg
	End Sequence
Endif

nRegPPP  := 0
cGFIPant := "  "
lGfipAll := .f. //Se achou alguma alteracao de GFIP

Dbselectarea("TRBPPP")
nTotRegPPP := TRBPPP->(Reccount())
Dbsetorder(1)
Dbseek(cMatr)
While !eof() .and. TRBPPP->MATRIC == cMatr
	If !empty(TRBPPP->GFIP)
    	Dbselectarea("TRBPPP")
    	Dbskip()
    	Loop
    Endif
    aAreaSv := TRBPPP->(GetArea())
    aAreaAnt := {}
	lAchou := .f.
	nRegPPP++
	cFilSR9 := Substr(TRBPPP->FILIAL,1,FwSizeFilial(TRBPPP->EMP))

	If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
		cModo := FWModeAccess("SR9")
		U_EMP530OPEN("SR9","SR9",1,TRBPPP->EMP,@cModo,cFilSR9)
	Endif
	cModoSR9 := f700RetCom("SR9")
	cXFilSR9 := FwxFilial("SR9",cFilSR9,Substr(cModoSR9,1,1),Substr(cModoSR9,2,1),Substr(cModoSR9,3,1))

	cChavePPP := cXFilSR9+TRBPPP->MAT
	svDTDE    := TRBPPP->DTDE
	svDTATE   := TRBPPP->DTATE

	Dbselectarea("SR9")
	Dbsetorder(1)
	Dbseek(cXFilSR9+TRBPPP->MAT+"RA_OCORREN")
	While !eof() .and. cChavePPP == SR9->R9_FILIAL+SR9->R9_MAT .and.;
		"RA_OCORREN" == SR9->R9_CAMPO

	    If svDTDE > SR9->R9_DATA .or. svDTATE <= SR9->R9_DATA
	    	Dbselectarea("SR9")
	    	Dbskip()
	    	Loop
	    Endif

		tmpDTDE   := TRBPPP->DTDE
		tmpDTATE  := TRBPPP->DTATE
		tmpCNPJ   := TRBPPP->CNPJ
		tmpTIPINS := TRBPPP->TIPINS
		tmpCUSTO  := TRBPPP->CUSTO
		tmpFILIAL := TRBPPP->FILIAL
		tmpMAT    := TRBPPP->MAT
		tmpCARGO  := TRBPPP->CARGO
		tmpCODFUN := TRBPPP->CODFUN
		tmpDESFUN := TRBPPP->DESFUN
		tmpEMP    := TRBPPP->EMP

		lInsertTRB := .f.

		Dbselectarea("TRBPPP")
		If !lAchou
			If TRBPPP->DTDE >= SR9->R9_DATA-5
				RecLock("TRBPPP",.f.)
				TRBPPP->GFIP  := Alltrim(SR9->R9_DESC)
				Msunlock("TRBPPP")
			Else
				RecLock("TRBPPP",.f.)
				TRBPPP->DTATE := SR9->R9_DATA
				TRBPPP->GFIP  := cGFIPant
				Msunlock("TRBPPP")
				lInsertTRB := .t.
			Endif
		Else
			lInsertTRB := .t.
			RestArea(aAreaAnt)
			RecLock("TRBPPP",.f.)
			TRBPPP->DTATE := SR9->R9_DATA
			Msunlock("TRBPPP")
		Endif

		If lInsertTRB
			RecLock("TRBPPP",.t.)
			TRBPPP->MATRIC := cMatr
			TRBPPP->DTDE   := SR9->R9_DATA
			TRBPPP->DTATE  := tmpDTATE
			TRBPPP->CNPJ   := tmpCNPJ
			TRBPPP->TIPINS := tmpTIPINS
			TRBPPP->CUSTO  := tmpCUSTO
			TRBPPP->FILIAL := tmpFILIAL
			TRBPPP->MAT    := tmpMAT
			TRBPPP->CARGO  := tmpCARGO
			TRBPPP->CODFUN := tmpCODFUN
			TRBPPP->DESFUN := tmpDESFUN
			TRBPPP->EMP    := tmpEMP
			TRBPPP->GFIP   := Alltrim(SR9->R9_DESC)
			Msunlock("TRBPPP")
		Endif
		aAreaAnt := TRBPPP->(GetArea())

		lAchou     := .t. //Controle p/ ver se houve alguma alteracao de GFIP em cada periodo de trabalho
		lGfipAll   := .t.
		cGFIPant   := Alltrim(SR9->R9_DESC)

	   	Dbselectarea("SR9")
	   	Dbskip()
	End
	RestArea(aAreaSv)

	If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
		U_EMP530OPEN("SR9","SR9",1,cEmpPPP,@cModo)
	Endif

	Dbselectarea("TRBPPP")
	If !lAchou
		RecLock("TRBPPP",.f.)
		TRBPPP->GFIP := cGFIPant
		Msunlock("TRBPPP")
	Endif

	RestArea(aAreaSv)

   	Dbselectarea("TRBPPP")
   	Dbskip()
End

Dbselectarea("TRBPPP")
Dbsetorder(1)
Dbseek(cMatr)
While !eof() .and. TRBPPP->MATRIC == cMatr
	if Empty(TRBPPP->GFIP) .or. TRBPPP->GFIP == "00"

		If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
			cModo := FWModeAccess(cAlias)
			U_EMP530OPEN(cAlias,cAlias,1,TRBPPP->EMP,@cModo,Substr(TRBPPP->FILIAL,1,FwSizeFilial(TRBPPP->EMP)))
		Endif
		cModoCTT := f700RetCom(cAlias)
		cXFilCTT := FwxFilial(cAlias,Substr(TRBPPP->FILIAL,1,FwSizeFilial(TRBPPP->EMP)),Substr(cModoCTT,1,1),Substr(cModoCTT,2,1),Substr(cModoCTT,3,1))

		Dbselectarea(cAlias)
		Dbsetorder(1)
		If Dbseek(cXFilCTT+TRBPPP->CUSTO)
			If cAlias == "SI3"
				If !Empty(SI3->I3_OCORREN)
					Dbselectarea("TRBPPP")
					RecLock("TRBPPP",.f.)
					TRBPPP->GFIP := SI3->I3_OCORREN
					MsUnLock("TRBPPP")
				Endif
			Else
				If !Empty(CTT->CTT_OCORRE)
					Dbselectarea("TRBPPP")
					RecLock("TRBPPP",.f.)
					TRBPPP->GFIP := CTT->CTT_OCORRE
					MsUnLock("TRBPPP")
				Endif
			Endif
		Endif

		If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
			U_EMP530OPEN(cAlias,cAlias,1,cEmpPPP,@cModo)
		Endif

		If !Empty(SRA->RA_OCORREN) .and. (Empty(TRBPPP->GFIP) .or. TRBPPP->GFIP == "00") .and. !lGfipAll
			RecLock("TRBPPP",.f.)
			TRBPPP->GFIP := SRA->RA_OCORREN
			MsUnLock("TRBPPP")
		Endif
	Endif
   	Dbselectarea("TRBPPP")
   	Dbskip()
End

Dbselectarea("TRBPPP")
Dbsetorder(1)
Dbseek(cMatr)
While !eof() .and. TRBPPP->MATRIC == cMatr
	aAreaTmp := TRBPPP->(GetArea())
	dDtFimsv := CTOD("  /  /  ")
	svPPPchv := TRBPPP->CNPJ+Str(TRBPPP->TIPINS,1)+TRBPPP->CUSTO+TRBPPP->FILIAL+TRBPPP->MAT+TRBPPP->CARGO+;
				TRBPPP->CODFUN+TRBPPP->DESFUN+TRBPPP->EMP+TRBPPP->GFIP+TRBPPP->MATRIC
	Dbskip()
	If !eof() .and. TRBPPP->MATRIC == cMatr
		Dbselectarea("TRBPPP")
		While !eof() .and. svPPPchv == TRBPPP->CNPJ+Str(TRBPPP->TIPINS,1)+TRBPPP->CUSTO+TRBPPP->FILIAL+;
			TRBPPP->MAT+TRBPPP->CARGO+TRBPPP->CODFUN+TRBPPP->DESFUN+TRBPPP->EMP+TRBPPP->GFIP+TRBPPP->MATRIC

			If dDtFimsv < TRBPPP->DTATE
				dDtFimsv := TRBPPP->DTATE
			Endif
			RecLock("TRBPPP",.f.)
			DbDelete()
			MsUnLock("TRBPP")
		   	Dbselectarea("TRBPPP")
		   	Dbskip()
		End
		If !Empty(dDtFimsv)
			RestArea(aAreaTmp)
			RecLock("TRBPPP",.f.)
			TRBPPP->DTATE := dDtFimsv
			MsUnLock("TRBPP")
		Endif
	Endif

	RestArea(aAreaTmp)
   	Dbselectarea("TRBPPP")
   	Dbskip()
End


lTroca    := .t.
cTrocaFun := " "
//Executa os historicos
Dbselectarea("TRBPPP")
Dbsetorder(1)
Dbseek(cMatr)
While !eof() .and. TRBPPP->MATRIC == cMatr

	cFilFichas := Substr(TRBPPP->FILIAL,1,FwSizeFilial(TRBPPP->EMP))

	If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
		cModo := FWModeAccess("SRJ")
		U_EMP530OPEN("SRJ","SRJ",1,TRBPPP->EMP,@cModo,cFilFichas)
		cModo := FWModeAccess("SQ3")
		U_EMP530OPEN("SQ3","SQ3",1,TRBPPP->EMP,@cModo,cFilFichas)
		cModo := FWModeAccess(cAlias)
		U_EMP530OPEN(cAlias,cAlias,1,TRBPPP->EMP,@cModo,cFilFichas)
	Endif

	cModoSRA := f700RetCom("SRA")
	cXFilSRA := FwxFilial("SRA",cFilFichas,Substr(cModoSRA,1,1),Substr(cModoSRA,2,1),Substr(cModoSRA,3,1))

	cModoSRJ := f700RetCom("SRJ")
	cXFilSRJ := FwxFilial("SRJ",cFilFichas,Substr(cModoSRJ,1,1),Substr(cModoSRJ,2,1),Substr(cModoSRJ,3,1))

	cModoSQ3 := f700RetCom("SQ3")
	cXFilSQ3 := FwxFilial("SQ3",cFilFichas,Substr(cModoSQ3,1,1),Substr(cModoSQ3,2,1),Substr(cModoSQ3,3,1))

	cModoCTT := f700RetCom(cAlias)
	cXFilCTT := FwxFilial(cAlias,cFilFichas,Substr(cModoCTT,1,1),Substr(cModoCTT,2,1),Substr(cModoCTT,3,1))

	strFuncao := Space(25)
	Dbselectarea("SRJ")
	Dbsetorder(1)
	If Dbseek(cXFilSRJ+TRBPPP->CODFUN)
		strFuncao := SRJ->RJ_DESC
	Endif
	cCBO  := SRJ->RJ_CBO
	If Year(TRBPPP->DTATE) >= 2003
		If !Empty(SRJ->RJ_CODCBO)
			cCBO := SRJ->RJ_CODCBO
		Endif
	Endif
	cCBO := Strzero(Val(cCBO),6)
	cTrocaFun := TRBPPP->CODFUN

	Dbselectarea("SQ3")
	Dbsetorder(1)
	If !Dbseek(cXFilSQ3+TRBPPP->CARGO+TRBPPP->CUSTO)
		Dbselectarea("SQ3")
		Dbsetorder(1)
		Dbseek(cXFilSQ3+TRBPPP->CARGO)
	Endif
	strCargo := SQ3->Q3_DESCSUM

	cCNPJtrb := TRBPPP->CNPJ
	cTIPOtrb := TRBPPP->TIPINS
	Dbselectarea(cAlias)
	Dbsetorder(1)
	If Dbseek(cXFilCTT+TRBPPP->CUSTO)
		If cAlias == "SI3"
			If !Empty(SI3->I3_CEI)
				cTIPOtrb := If(SI3->I3_TIPO=="1",2,1)
				cCNPJtrb := SI3->I3_CEI
			Endif
		Else
			If !Empty(CTT->CTT_CEI)
				cTIPOtrb := If(CTT->CTT_TIPO=="1",2,1)
				cCNPJtrb := CTT->CTT_CEI
			Endif
		Endif
	Endif
	strCCusto := &cDescr

	Dbselectarea("TRBPPP")
	RecLock("TRBPPP",.f.)
	TRBPPP->DTATE  := TRBPPP->DTATE - 1
	TRBPPP->DESCUS := Alltrim(strCCusto)
	TRBPPP->DESCAR := Alltrim(strCargo)
	TRBPPP->DESFUN := Alltrim(strFuncao)
	TRBPPP->CBO    := cCBO
	TRBPPP->CNPJ   := cCNPJtrb
	TRBPPP->TIPINS := cTIPOtrb
	TRBPPP->CODCLI := SubSTR(TRBPPP->CUSTO,1,nTa1)
	TRBPPP->LOJCLI := SubSTR(TRBPPP->CUSTO,nTa1+1,nTa1L)
	MsUnLock("TRBPPP")

	If lMudEmpr .and. TRBPPP->EMP != cEmpPPP
		U_EMP530OPEN("SRJ","SRJ",1,cEmpPPP,@cModo)
		U_EMP530OPEN("SQ3","SQ3",1,cEmpPPP,@cModo)
		U_EMP530OPEN(cAlias,cAlias,1,cEmpPPP,@cModo)
	Endif

	Dbselectarea("TRBPPP")
	Dbskip()
	If eof() .or. TRBPPP->MATRIC != cMatr
		Dbskip(-1)
		If !eof() .and. !bof()
			RecLock("TRBPPP",.f.)
			TRBPPP->DTATE  := SRA->RA_DEMISSA
			MsUnLock("TRBPPP")
		Endif
		Dbskip()
	Endif
End

Return aHistory
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³NG530GRAVA³ Autor ³Denis Hyroshi de Souza ³ Data ³ 21/10/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Carrega os dados do historico do funcionario               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function NG530GRAVA(dIni,dFim,cCus,strCus,cFun,strFun)

Dbselectarea("TRB")
TRB->(DbAppend())
TRB->MAT     := SRA->RA_MAT
TRB->NOME    := SRA->RA_NOME
TRB->DTINI   := dIni
TRB->DTFIM   := dFim
TRB->CCUSTO  := cCus
TRB->STRCC   := strCus
TRB->FUNCAO  := cFun
TRB->STRFUN  := strFun

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³EMP530OPEN³ Autor ³Denis Hyroshi de Souza ³ Data ³ 07/05/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Abre arquivo de outra empresa                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function EMP530OPEN(cAlias1,cAlias2,nIndice,MvEmpresa,cMd)
Local nAT := 0
default nIndice := 1
default cAlias1 := Alias()
default cAlias2 := Alias()
default MvEmpresa := cEmpAnt
default cMd := FWModeAccess(Alias())

UniqueKey( NIL , cAlias1 , .T. )
EmpOpenFile(cAlias2,cAlias1,nIndice,.t.,MvEmpresa,@cMd)   // Abre arquivo da empresa selecionada
nAT := AT(cAlias1,cArqTab)
IF nAT > 0
	cArqTab := Subs(cArqTab,1,nAT+2)+cMd+Subs(cArqTab,nAT+4)
EndIF

cArqTab := Subs(cArqTab,1,nTamTable)
Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³f700RetComºAutor  ³Roger Rodrigues     º Data ³  12/11/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna compartilhamento da tabela                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³MDTR700                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function f700RetCom(cAlias)
dbSelectArea("SX2")
dbSetOrder(1)
dbSeek(cAlias)

Return FWModeAccess(cAlias,1) + FWModeAccess(cAlias,2) + FWModeAccess(cAlias,3)