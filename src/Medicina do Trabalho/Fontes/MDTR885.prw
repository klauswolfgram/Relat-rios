/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr885.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte   
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³MDTR885   ³ Autor ³   Liber De Esteban    ³ Data ³26/08/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³Impressao do cronograma do plano de acao.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR885()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿   
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR885"
LOCAL cDesc1  := STR0001 //"Relatório do cronograma do Plano de Ação. Atraves dos parâmetros o usuário poderá"
LOCAL cDesc2  := STR0002 //"filtrar os responsáveis dos planos(funcionário ou integrante da SESMT), e poderá"
LOCAL cDesc3  := STR0003 //"selecionar um intervalo de anos para visualizar o período em que cada plano ira atuar"
LOCAL cString := "TMI" 

nTa1 := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
nTa1L := If((TAMSX3("A1_LOJA")[1]) < 1,2,(TAMSX3("A1_LOJA")[1]))

PRIVATE nomeprog := "MDTR885"
PRIVATE tamanho  := "G"
PRIVATE nLimite  := 132
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Cronograma do Plano de Ação"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2
PRIVATE cPerg    :="MDT885    "
Private lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
Private nSizeFil := FwSizeFilial()
Private lFilPA
PRIVATE cCliMdtPs := Space(nTa1+nTa1L)

SG90PLACAO()//Adequação do Plano de Ação.

lFilPA := NGCADICBASE(aFieldPA[26],"A",cAliasPA,.F.)

/*----------------------------------
//PADRÃO								|
|  De Responsavel Sesmt ?			|
|  Ate Responsavel Sesmt ?			|
|  De Func. Responsavel ?			|
|  Ate Func. Responsavel ?			|
|  De Dt. Inicio Prevista ?			|
|  Ate Dt. Inicio Prevista ?		|
|  Considerar ?						|
|  Classificar Por ?					|
|  										|
//PRESTADOR							|
|  De Cliente ?						|
|  Loja								|
|  Até Cliente ?						|
|  Loja								|
|  De Responsavel Sesmt ?			|
|  Ate Responsavel Sesmt ?			|
|  De Func. Responsavel ?			|
|  Ate Func. Responsavel ?			|
|  De Dt. Inicio Prevista ?			|
|  Ate Dt. Inicio Prevista ?		|
|  Considerar ?						|
|  Classificar Por ?					|
------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

wnrel:="MDTR885"
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| U_R885Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R885Imp  ³ Autor ³   Liber De Esteban    ³ Data ³26/08/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR885                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function R885Imp(lEnd,wnRel,titulo,tamanho)
//----Variaveis locais----
Local cPlano     := ""
Local cResponsa  := ""   , cResponaux := ""

//Variaveis de Contador
Local nPos, nAdd, nLim, nDias, nDay
Local nCont, nX

//Variaveis de condicoes
Local cCond	:= ""

//Variaveis de salto de pagina
Local cCliente   := ""
Local cAlias	:= "SRA", cDesc := "SRA->RA_NOME", cField := aFieldPA[11]
//----Fim variaveis locais----

//Variaveis de TRB
Local aTRB, nInd := 1
Local oTempTRB
Private cAliTRB  := GetNextAlias()
Private cCli01   := "", cCli02 := ""
Private cWhile   := ".T."  

//Parametros
Private xm_par01 := mv_par01 //De Usuario
Private xm_par02 := mv_par02 //Até Usuario
Private xm_par03 := mv_par03 //De Funcionario
Private xm_par04 := mv_par04 //Ate Funcionario
Private xm_par05 := mv_par05 //Data Inicio Prevista
Private xm_par06 := mv_par06 //Data Fim Prevista
Private xm_par07 := mv_par07 //Considera?

//Controle de titulos
Private cTitulo   
Private nPrim

// Contadores de linha e pagina
Private li := 80 ,m_pag := 1

//--------------------------------------
// Verifica se deve comprimir ou nao 
//--------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//------------------------
// Monta os Cabecalhos
//------------------------
cabec1 := ""
cabec2 := ""

/*        1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
-------------------------------------------------------------------------------------------------------------------------------------
|    Logo    |																										   	    Pag: 999
SIGA       										Cronograma de Atividades	                                       Dt. Ref: 99/99/99
Hora.:																											   Emissão: 99/99/99
-------------------------------------------------------------------------------------------------------------------------------------
Responsavel.: XXXXXXXXXXXX XXXX XXXXXXXXXXX XXXXXX
-------------------------------------------------------------------------------------------------------------------------------------
Plano     Nome do Plano                 Ini.Prev   Fim Prev   Ago - Set - Out - Nov - Dez - Jan - Fev - Mar - Abr - Mai - Jun - Jul
-------------------------------------------------------------------------------------------------------------------------------------
XXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999 ****  ****  **
XXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999               **  ****  ***
XXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXX  99/99/9999 99/99/9999                            *  ****  ****  ****
*/
If lSigaMdtPs //Caso prestador altera os parametros
	cCli01   := mv_par01+mv_par02
	cCli02   := mv_par03+mv_par04
	xm_par01 := mv_par05
	xm_par02 := mv_par06
	xm_par03 := mv_par07
	xm_par04 := mv_par08
	xm_par05 := mv_par09
	xm_par06 := mv_par10
	xm_par07 := mv_par11
	cCond    := MV_PAR01+MV_PAR02
	nInd     := 5
	cWhile   := cAliasPA+"->("+cClientePA+"+"+cLojaPA+") >= cCli01 .AND. "+cAliasPA+"->("+cClientePA+"+"+cLojaPA+") <= cCli02"
	
Endif   

cAlias   := "TMK"
cDesc    := If(TC9->TC9_TIPRES == "2",'NGSEEK("SRA",(cAliTRB)->RESPON,1,"SRA->RA_NOME")','NGSEEK("QAA",(cAliTRB)->RESPON,1,"QAA->QAA_NOME")')

//--------- INICIO DA MONTAGEM DO TRB ---------   
aTRB := {	{ "RESPON" , "C" , 30		 , 0 } ,;  
			{ "PLANO"  , "C" , 06      , 0 } ,;     
			{ "NOMPLA" , "C" , 40       , 0 },;
			{ "DTIPRE" , "D" , 08       , 0 },;
			{ "DTFPRE" , "D" , 08       , 0 },;     
			{ "ANOATU" , "C" , 04       , 0 }}

If lSigaMdtPs 
	aAdd(aTRB, {"CLIENT" , "C", nTa1 ,0})
	aAdd(aTRB, {"LOJA"   , "C", nTa1L,0})
Endif

If lFilPA
	aAdd(aTRB, {"FILFUN", "C", nSizeFil, 0})
Endif

oTempTRB := FWTemporaryTable():New( cAliTRB, aTRB )
If lSigaMdtPs
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","RESPON","PLANO","DTIPRE"} )
Else
	oTempTRB:AddIndex( "1", {"RESPON","PLANO","DTIPRE"} )
EndIf
oTempTRB:Create()

//--------- FIM DA MONTAGEM DO TRB ---------

//--------- INICIO DA POPULACAO DO TRB ---------
dbSelectArea("TC9")
dbgotop()
While !Eof() 
	If TC9->TC9_TIPRES == "2" .And. (TC9->TC9_CODRES < xm_par03 .Or. TC9->TC9_CODRES > xm_par04)//Se for Funcionário.
		dbSelectArea("TC9")
		dbSkip()             
		Loop   
	ElseIf TC9->TC9_TIPRES == "1" .And. (TC9->TC9_CODRES < xm_par01 .Or. TC9->TC9_CODRES > xm_par02)//Se for Usuário.
		dbSelectArea("TC9")
		dbSkip()             
		Loop      
	Endif      
	aAreaTC9 := GetArea()
	dbSelectArea("TAA")
	dbSetOrder(1)
	dbSeek(xFilial("TAA")+TC9->TC9_CODPLA)
	If (cAliasPA)->&(aFieldPA[6]) < xm_par05 .OR. (cAliasPA)->&(aFieldPA[7]) > xm_par06
		dbSelectArea("TC9")
		dbSkip()                
		Loop           
	EndIf
	RestArea(aAreaTC9)
	
	If xm_par07 == 2 .and. Empty((cAliasPA)->&(aFieldPA[9]))
		dbSelectArea( "TC9" )
		dbSkip()
		Loop
	ElseIf xm_par07 == 3 .and. !Empty((cAliasPA)->&(aFieldPA[9]))
		dbSelectArea( "TC9" )
		dbSkip()
		Loop   
	EndIf
	
	aYears := fRetYears((cAliasPA)->&(aFieldPA[6]),(cAliasPA)->&(aFieldPA[7]))
	
	For nX := 1 To Len(aYears)
		dbSelectArea(cAliTRB)
		RecLock(cAliTRB,.t.)
		(cAliTRB)->PLANO  := (cAliasPA)->&(aFieldPA[2])
		(cAliTRB)->NOMPLA := (cAliasPA)->&(aFieldPA[3])
		(cAliTRB)->DTIPRE := (cAliasPA)->&(aFieldPA[6])
		(cAliTRB)->DTFPRE := (cAliasPA)->&(aFieldPA[7])
		(cAliTRB)->ANOATU := cValToChar(aYears[nX])
		(cAliTRB)->RESPON := TC9->TC9_CODRES
		If lSigaMdtPs
			(cAliTRB)->CLIENT := (cAliasPA)->(cClientePA)
			(cAliTRB)->LOJA   := (cAliasPA)->(cLojaPA)
		Endif
		If lFilPA
			(cAliTRB)->FILFUN := (cAliasPA)->&(aFieldPA[26])
		Endif
		
		MsUnLock(cAliTRB)
	Next nX
	dbSelectArea("TC9")
	TC9->(dbSkip())     
End
//--------- FIM DA POPULACAO DO TRB ---------

//--------- INICIO DA IMPRESSAO DO RELATORIO ---------
cResponaux := ""
dbSelectArea(cAliTRB)
DbGoTop()

While !EOF()
	//Caso altere o reponsavel, salta a pagina, se for prestador, caso troque o cliente tambem
	If cResponaux != (cAliTRB)->RESPON .OR. If(lSigaMdtPs,cCliente <> (cAliTRB)->(CLIENT+LOJA),.F.)
		cResponaux := (cAliTRB)->RESPON
		cCliente   := If(lSigaMdtPs,(cAliTRB)->(CLIENT+LOJA),cCliente)
		Li := 80
		U_NGORMES()
		Somalinha(cAlias,cDesc,cField,@cResponsa)
	EndIf
	
	nMes := Month((cAliTRB)->DTIPRE)//Define mes de inicio
	nLim := 0//Inicializa variavies de limite
	If cPlano <> (cAliTRB)->PLANO //Troca do plano, imprime informacoes principais
		Somalinha(cAlias,cDesc,cField,@cResponsa)
		cPlano := (cAliTRB)->PLANO
		@Li,000 PSAY (cAliTRB)->PLANO
		@Li,010 PSAY Substr((cAliTRB)->NOMPLA,1,28)
		@Li,040 PSAY (cAliTRB)->DTIPRE Picture "99/99/9999"
		@Li,051 PSAY (cAliTRB)->DTFPRE Picture "99/99/9999"
		//Verifica em qual mes e semana comeca a impressao
		nAtu := nMes - nPrim
		If nAtu < 0
			nAtu := (12 - nPrim) + nMes
		EndIf
		nPos  := 67 + (6*nAtu)
		nDay  := Int(DAY((cAliTRB)->DTIPRE)/7.5)
		nAdd  := nDay
	Else
		//Caso haja mais de um ano, define o termine do ano
		nPos  := 67
		nAdd  := 0
		If Year((cAliTRB)->DTFPRE) <> Val((cAliTRB)->ANOATU)
			nLim := 0
		Else
			nLim  := nPos+((Month((cAliTRB)->DTFPRE)-1)*6)+ROUND(DAY((cAliTRB)->DTFPRE)/7.5,0)
		Endif
	Endif
	@Li,062 PSAY (cAliTRB)->ANOATU Picture "9999"
	
	//Verifica quantas semanasiram imprimir
	nDias := ((cAliTRB)->DTFPRE - (cAliTRB)->DTIPRE)
	nDias := nDias/7.5
	nDias := ROUND(nDias,0)
	
	//Imprime '*' para as semanas
	For nCont := 1 to nDias
		If nLim > 0
			If nPos+nAdd >= nLim
				Exit
			Endif
		Endif
		@Li,nPos+nAdd PSAY "*"
		nAdd++
		If nAdd >= 4
			If nPos >= 128
				Exit
			EndIf
			nAdd := 0
			nPos += 6
		EndIf
	Next nCont
	
	Somalinha(cAlias,cDesc,cField,@cResponsa)
	
	dbSelectArea(cAliTRB) 
	dbSkip()
End

//Fecha TRB
oTempTRB:Delete()

//--------- FIM DA IMPRESSAO DO RELATORIO ---------
//EJECT

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex( cAliasPA )
Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()

dbSelectArea( cAliasPA )
dbSetOrder(nIndexPA)
Return NIL

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³26/04/2000³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR407                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Somalinha(cAlias,cDesc,cField,cResponsa)
Li++
If Li > 58
	dbSelectArea(cAlias)
	dbSetOrder(01)
	If cAlias == "SRA"
		If lFilPA
			dbSeek(xFilial(cAlias,(cAliTRB)->FILFUN) + (cAliTRB)->RESPON)
		Else
			dbSeek(xFilial(cAlias) + (cAliTRB)->RESPON)
		Endif
	Else
		dbSeek(xFilial(cAlias) + (cAliTRB)->RESPON)
	Endif
	cResponsa := &cDesc
	
	If lSigaMdtps
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial("SA1")+(cAliTRB)->CLIENT+(cAliTRB)->LOJA)
		cabec1 := STR0024 + (cAliTRB)->CLIENT+"-"+(cAliTRB)->LOJA + STR0025+ AllTrim(SA1->A1_NOME) + STR0023 + AllTrim(cResponsa) // "Cliente/Loja: "###"      Nome Cliente: "###"       Responsável: "
	Else
		cabec1 := STR0007 + cResponsa //"Responsavel.: "
	Endif
	cabec2 := STR0008 + cTitulo //"Plano     Nome do Plano                   Ini.Prev  Fim Prev  Ano  "
	Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
EndIf
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ VALDTINI  ³ Autor ³ Anônimo              ³ Data ³ ???????  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Valida a data.                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ U_VALDTINI()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR885                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function VALDTINI()

If lSigaMdtps
	If mv_par09 > mv_par10
		msgStop(STR0009,STR0010) //"A data 'ate' deve ser maior que a 'de'"###"ATENCAO"
		Return .f.
	EndIf
	If mv_par10 - mv_par09 > 365
		msgStop(STR0011,STR0010) //"Selecione um intervalo de no maximo uma ano"###"ATENCAO"
		Return .f.
	EndIf
Else
	If xm_par05 > xv_par06
		msgStop(STR0009,STR0010) //"A data 'ate' deve ser maior que a 'de'"###"ATENCAO"
		Return .f.
	EndIf
	If xv_par06 - xv_par05 > 365
		msgStop(STR0011,STR0010) //"Selecione um intervalo de no maximo uma ano"###"ATENCAO"
		Return .f.
	EndIf
Endif

Return .t.


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ NGORMES  ³ Autor ³ Anônimo               ³ Data ³ ???????  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Acumula mês                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ U_NGORMES()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR885                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function NGORMES()
Local nCont, lContinua := .t.
nPrim := 1
nCont := nPrim + 1//9
cTitulo := U_NOMEMES(nPrim)

While lContinua
	If nCont > 12
		nCont := 1
	EndIf
	If nCont == nPrim
		Exit
	EndIf
	cTitulo += " - " + U_NOMEMES(nCont)
	nCont ++
End

Return .t.


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ NOMEMES³ Autor ³ Anônimo                 ³ Data ³ ???????  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Nome do mês                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ U_NOMEMES()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR885                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function NOMEMES(nMes)
Local cNomMes

If nMes == 1
	cNomMes := STR0026 //"Jan"
ElseIf nMes == 2
	cNomMes := STR0027 //"Fev"
ElseIf nMes == 3
	cNomMes := STR0028 //"Mar"
ElseIf nMes == 4
	cNomMes := STR0029 //"Abr"
ElseIf nMes == 5
	cNomMes := STR0030 //"Mai"
ElseIf nMes == 6
	cNomMes := STR0031 //"Jun"
ElseIf nMes == 7
	cNomMes := STR0032 //"Jul"
ElseIf nMes == 8
	cNomMes := STR0033 //"Ago"
ElseIf nMes == 9
	cNomMes := STR0034 //"Set"
ElseIf nMes == 10
	cNomMes := STR0035 //"Out"
ElseIf nMes == 11
	cNomMes := STR0036 //"Nov"
ElseIf nMes == 12
	cNomMes := STR0037 //"Dez"
EndIf

Return cNomMes
//---------------------------------------------------------------------
/*/{Protheus.doc} fRetYears
Retorna os anos

@return Nil

@sample
fRetYears('01/01/2012','31/12/2012')

@author Jackson Machado
@since 28/05/2012
@version 1.0
/*/
//---------------------------------------------------------------------
Static Function fRetYears(dDtIni,dDtFim)
Local nAnoIni, nAnoFim
Local aAnos := {}

nAnoIni := Year(dDtIni)
nAnoFim := Year(dDtFim)
While nAnoIni <= nAnoFim
	aAdd(aAnos,nAnoIni)
	nAnoIni++
End

Return aAnos