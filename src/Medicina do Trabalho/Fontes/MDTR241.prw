/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"
#Include "MDTR241.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR241  ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 29.03.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio das Ocorrencias por Funcionario                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR241(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR241()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR241"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatório das ocorrências por funcionário. Através dos parâmetros "
LOCAL cDesc2  := STR0002 //"o usuário poderá filtrar quais ocorrências deseja imprimir."
LOCAL cDesc3  := " "
LOCAL cString := "SRA"
Local cF3CC  := "SI3001"

lSigaMdtPS    := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE tamanho	:= "M"
PRIVATE aReturn	:= { STR0003, 1, STR0004, 2, 2, 1, "", 1 } //"Zebrado"  //"Administracao"
PRIVATE titulo		:= STR0005	 //"Ocorrências por Funcionário"
PRIVATE ntipo		:= 0
PRIVATE nLastKey	:= 0
PRIVATE nomeprog	:= "MDTR241"
PRIVATE cPerg		:= If(!lSigaMDTPS,"MDT241    ","MDT241PS  ")
PRIVATE cabec1, cabec2
PRIVATE nSizeSI3	:= If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
PRIVATE cTableCC	:= "SI3"
PRIVATE cCodCC		:= "I3_CUSTO"
PRIVATE cDesCC		:= "I3_DESC"
PRIVATE nSizeFil	:= FwSizeFilial()
PRIVATE oTempTRB

dbSelectArea("SX2")

//Verifica se existe integracao com o modulo contabil
If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cTableCC := "CTT"
	cCodCC := "CTT_CUSTO"
	cDesCC := "CTT_DESC01"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cF3CC  := "CTT001"
Endif

/*
//---------------------------------------------------
//PERGUNTAS PADRÕES.										|
|  MDT241    ¦1       ¦De Filial ?						|
|  MDT241    ¦2       ¦AtÚ Filial ?					|
|  MDT241    ¦3       ¦De Centro de Custo ?			|
|  MDT241    ¦4       ¦AtÚ Centro de Custo ?			|
|  MDT241    ¦5       ¦De Funcionário ?				|
|  MDT241    ¦6       ¦AtÚ Funcionário ?				|
|  MDT241    ¦7       ¦De Data ?						|
|  MDT241    ¦8       ¦Ate Data ?						|
|  MDT241    ¦9       ¦Ordenar Ocorrências por ?		|
|  															|
//PERGUNTAS DE PRESTADOR.								|
|  	          	1        De Cliente ?					|
|  	          	2        Loja								|
|            	3        Até Cliente?					|
|             4        Loja								|
|  	MDT241    ¦5       ¦De Centro de Custo ?			|
|  	MDT241    ¦6       ¦Até Centro de Custo ?			|
|  	MDT241    ¦7       ¦De Funcionário ?				|
|  	MDT241    ¦8       ¦Até Funcionário ?				|
|  	MDT241    ¦9       ¦De Data ?						|
|  	MDT241    ¦10      ¦Ate Data ?						|
|  	MDT241    ¦11      ¦Ordenar Ocorrências por ?		|
//---------------------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR241"

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

If lSigaMdtps
	RptStatus({|lEnd| _R241Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Else
	RptStatus({|lEnd| R241Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R241Imp  ³ Autor ³ Andre E.Perez Alvarez ³ Data ³ 29/03/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function R241Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local lContinua := .T.
Local lExcluTO8 := .F.
Local aAreaSM0 := SM0->(GetArea())
Local nTamSX3 := TAMSX3("RA_MAT")[1]
Local oTempTRB
Local aDBF := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private li := 80 ,m_pag := 1
Private lNewPage := .T.

Private oTempTRB1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case

	Case mv_par09 == 1 .OR. mv_par09 == 2
		cabec1 := STR0017  //"Filial        Nome                             Matrícula   Funcionário                      C. Custo             Descrição C. Custo"
		cabec2 := STR0018  //"       Ocorrência  Data       Gravidade             Descrição Ocorrência"

	Case mv_par09 == 3 .OR. mv_par09 == 4
		cabec1 := STR0019  //"Filial        Nome                             C. Custo             Descrição C. Custo"
		cabec2 := STR0021  //"      Ocorrência  Data       Gravidade            Descrição Ocorrência"

	Case mv_par09 == 5
		cabec1 := STR0022  //"Ocorrência   Descrição Ocorrência"
		cabec2 := STR0023  //"         Matrícula   Nome Funcionário                 C. Custo    Descrição C. Custo         Data       Gravidade"

EndCase

// Ordenacao por matricula (1) ou nome (2)
/*
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
Filial        Nome Filial                      Matrícula   Nome Funcionário                 C. Custo    Descrição C. Custo
       Ocorrência  Data       Gravidade             Descrição Ocorrência
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
12            123456789012345678901234567890   123456      123456789012345678901234567890   123456789   1234567890123456789012345

       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
*/

// Ordenacao por Centro de Custo e Matricula (3) ou Centro de Custo e Nome funcionario (4)
/*
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
Filial        Nome Filial                      C. Custo    Descrição C. Custo
      Ocorrência  Data       Gravidade            Descrição Ocorrência
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
12            123456789012345678901234567890   123456789   1234567890123456789012345

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
*/

// Ordenacao por No. Ocorrencia (5)
/*
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
Ocorrência   Descrição Ocorrência
         Matrícula   Nome Funcionário                 C. Custo    Descrição C. Custo         Data       Gravidade
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
123456       12345678901234567890123456789012345678901234567890123456789012345678901234567890

   Filial: 12            Nome Filial: 123456789012345678901234567890
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678

   Filial: 12            Nome Filial: 123456789012345678901234567890
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   123456789   1234567890123456789012345  12345678   0123456789012345678
-------------------------------------------------------------------------------------------------------------------------------------
*/

AADD( aDBF, {"OCOR"    , "C", 6       , 0} )  //Ocorrencia
AADD( aDBF, {"OCORDESC", "C", 80      , 0} )  //Descricao Ocorrencia
AADD( aDBF, {"DATAOC"  , "D", 8       , 0} )  //Data Ocorrencia
AADD( aDBF, {"GRAVID"  , "C", 19      , 0} )  //Gravidade Ocorrencia

AADD( aDBF, {"FIL"     , "C", nSizeFil, 0} )  //Filial
AADD( aDBF, {"NOMEFIL" , "C", 30      , 0} )  //Nome Filial
AADD( aDBF, {"MAT"     , "C", nTamSX3 , 0} )  //Matricula Funcionario
AADD( aDBF, {"NOMEFU"  , "C", 30      , 0} )  //Nome Funcionario

AADD( aDBF, {"CC"      , "C", nSizeSI3, 0} )  //Cod Centro de Custo
AADD( aDBF, {"DESCCC"  , "C", 25      , 0} )	//Descricao Centro de Custo

//Cria TRB
oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
Do Case
	Case mv_par09 == 1		//Filial + Matricula + Ocorrencia + Data
		oTempTRB:AddIndex( "1", { "FIL","MAT","OCOR","DATAOC" } )
	Case mv_par09 == 2		//Filial + Nome Funcionario + Ocorrencia + Data
		oTempTRB:AddIndex( "1", { "FIL","NOMEFU","OCOR","DATAOC" } )
	Case mv_par09 == 3 		//Filial + C.C. + Matricula + Ocorrencia + Data
		oTempTRB:AddIndex( "1", { "FIL","CC","MAT","OCOR","DATAOC" } )
	Case mv_par09 == 4		//Filial + C.C. + Nome Funcionario + Ocorrencia + Data
		oTempTRB:AddIndex( "1", { "FIL","CC","NOMEFU","OCOR","DATAOC" } )
	Case mv_par09 == 5 		//Ocorrencia + Filial + Matricula + Data
		oTempTRB:AddIndex( "1", { "OCOR","FIL","MAT","DATAOC" } )
EndCase
oTempTRB:Create()

/* Verifica o modo de acesso da tabela TO8.  													 */
/* Se o modo de acesso for exclusivo, o programa buscara' registros na tabela TO8 utilizando
os campos Filial e Matricula dos funcionarios selecionados na tabela SRA.                        */
/* Senao, ele buscara' registros utilizando apenas a Matricula, uma vez que todas as filiais
tem acesso a eles.																				 */
/* Essa diferenciacao e' necessaria, pois o que define a filial do funcionario e' o campo FILIAL
da tabela SRA, e nao o campo FILIAL da tabela TO8. O ultimo apenas serve para separar as
ocorrencias por Filial. O fato da tabela TO8 estar em modo de acesso compartilhado ou exclusivo
pouco importa no que se refere 'a definicao da filial do funcionario -- isso apenas define se
os registros que estao na TO8 devem ser acessados apenas pela filial que os criou ou nao.		 */
If FWModeAccess("TO8",3)+FWModeAccess("TO8",2)+FWModeAccess("TO8",1) == "EEE"
	lExcluTO8 := .T.
EndIf

DbSelectArea ("SRA")
DbSetOrder (02)    //Filial + C.C. + Matricula
dbSeek (mv_par01, .T.)
SetRegua(LastRec())

While SRA->RA_FILIAL >= mv_par01	.AND.;
	  SRA->RA_FILIAL <= mv_par02	.AND.;
	  lContinua	 .AND. !Eof()

	IncRegua()

    If SRA->RA_CC < mv_par03	.OR. 	SRA->RA_CC  > mv_par04
    	DbSkip();	Loop
    EndIf

    If SRA->RA_MAT < mv_par05	.OR.	SRA->RA_MAT > mv_par06
    	DbSkip();	Loop
    EndIf

   	DbSelectArea ("TO8")
	DbSetOrder (02)		//Filial + Matricula
   	DbSeek ( If(lExcluTO8,SRA->RA_FILIAL,xFilial("TO8")) + SRA->RA_MAT )
   	While TO8->TO8_FILIAL == If(lExcluTO8,SRA->RA_FILIAL,xFilial("TO8"))	  .AND.;
		  TO8->TO8_MAT    == SRA->RA_MAT	  								  .AND.;
		  !EOF()

		If TO8->TO8_DTOCOR < mv_par07  .OR.  TO8->TO8_DTOCOR > mv_par08
			DbSkip();	Loop
	    EndIf

		dbSelectArea("TRB")
		Reclock("TRB",.T.)
		TRB->OCOR      := TO8->TO8_CODOCO
		TRB->OCORDESC  := NgSeek("TO7",TO8->TO8_CODOCO,1,"TO7->TO7_DESOCO")
		TRB->DATAOC    := TO8->TO8_DTOCOR
		Do Case
			Case TO8->TO8_GRAVID == '1';	 TRB->GRAVID := STR0025		//"Advertência Verbal"
			Case TO8->TO8_GRAVID == '2';	 TRB->GRAVID := STR0026		//"Advertência Escrita"
			Case TO8->TO8_GRAVID == '3';	 TRB->GRAVID := STR0027		//"Suspensão"
			Case TO8->TO8_GRAVID == '4';	 TRB->GRAVID := STR0028		//"Demissão"
		EndCase
		TRB->FIL       := SRA->RA_FILIAL

		dbSelectArea("SM0")
		DbSeek(SM0->M0_CODIGO+SRA->RA_FILIAL)
		TRB->NOMEFIL   := SubSTR(SM0->M0_NOMECOM,1,30)
		RestArea(aAreaSM0)

		TRB->MAT       := SRA->RA_MAT
		TRB->NOMEFU    := SRA->RA_NOME
		TRB->CC        := SRA->RA_CC
		TRB->DESCCC    := NgSeek(cTableCC,SRA->RA_CC,1,cDesCC)
		MsUnlock("TRB")

   		DbSelectArea("TO8") ; DbSkip()
   	EndDo

	DbSelectArea("SRA") ; DbSkip()
EndDo

DbSelectArea("TRB")
DbGoTop()
If RecCount()==0
	MsgInfo(STR0024)	//"Não há nada para imprimir no relatório."
	oTempTRB:Delete()
	Return .F.
EndIf

//Imprime o relatorio de acordo com a ordenacao escolhida
Do Case
	Case mv_par09 == 1 .OR. mv_par09 == 2
		U_RImp241_(1)
	Case mv_par09 == 3 .OR. mv_par09 == 4
		U_RImp241_(2)
	OtherWise
		U_RImp241_(3)
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SRA")
RetIndex("TO8")

oTempTRB:Delete()

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R241Imp  ³ Autor ³ Andre E.Perez Alvarez ³ Data ³ 13/02/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio (para prestador de serv.)             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function _R241Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//LOCAL lContinua := .T.
Local lExcluTO8 := .F.
//LOCAL aAreaSM0 := SM0->(GetArea())
Local nTamSX3 := TAMSX3("RA_MAT")[1]
Local aDBF := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private li := 80 ,m_pag := 1
Private lNewPage := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case

Case mv_par11 == 1 .OR. mv_par11 == 2
	cabec1 := STR0035  //"Matrícula   Funcionário                      C. Custo              Descrição C. Custo"
	cabec2 := STR0036  //"       Ocorrência  Data       Gravidade             Descrição Ocorrência"
Case mv_par11 == 3 .OR. mv_par11 == 4
	cabec1 := STR0037  //"C. Custo              Descrição C. Custo"
	cabec2 := STR0038  //"      Ocorrência  Data       Gravidade            Descrição Ocorrência"
Case mv_par11 == 5
	cabec1 := STR0039  //"Ocorrência   Descrição Ocorrência"
	cabec2 := STR0040  //"         Matrícula   Funcionário                      C. Custo              Descrição C. Custo         Data       Gravidade"
EndCase

// Ordenacao por matricula (1) ou nome (2)
/*
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
Matrícula   Nome Funcionário                 C. Custo              Descrição C. Custo
       Ocorrência  Data       Gravidade             Descrição Ocorrência
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 000001-0001 - Cliente Teste

123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890

123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 000002-0001 - Tabajara Futebol Clube LDTA.

123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
       123456      12345678   0123456789012345678   12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
*/

// Ordenacao por Centro de Custo e Matricula (3) ou Centro de Custo e Nome funcionario (4)
/*
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
C. Custo              Descrição C. Custo
      Ocorrência  Data       Gravidade            Descrição Ocorrência
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 000003-0001 - IBM Borracharia

12345678901234567890  1234567890123456789012345

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890

12345678901234567890  1234567890123456789012345

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 000004-0001 - Bar do JEC

12345678901234567890  1234567890123456789012345

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890

   Matrícula: 123456    Nome Funcionário: 123456789012345678901234567890
      123456      12345678   0123456789012345678  12345678901234567890123456789012345678901234567890123456789012345678901234567890
-------------------------------------------------------------------------------------------------------------------------------------
*/

// Ordenacao por No. Ocorrencia (5)
/*
          1         2         3         4         5         6         7         8         9       100       110       120       130
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
*************************************************************************************************************************************
*<empresa>                                                                                                    	   Folha..: xxxxx   *
*SIGA /<nome .04                                  Ocorrencias por Funcionario                               	   DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                 Emissao: dd/mm/aa*
*************************************************************************************************************************************
Ocorrência   Descrição Ocorrência
         Matrícula   Nome Funcionário                 C. Custo              Descrição C. Custo         Data       Gravidade
*************************************************************************************************************************************
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 00006-0000 - Cliente Teste

123456       12345678901234567890123456789012345678901234567890123456789012345678901234567890

         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
-------------------------------------------------------------------------------------------------------------------------------------
Cliente/Loja: 00006-0000 - Cliente Teste

123456       12345678901234567890123456789012345678901234567890123456789012345678901234567890

         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
         123456      123456789012345678901234567890   12345678901234567890  1234567890123456789012345  12345678   0123456789012345678
-------------------------------------------------------------------------------------------------------------------------------------
*/

AADD( aDBF, {"CLIENT"  , "C", nTa1    , 0} )
AADD( aDBF, {"LOJA"    , "C", nTa1L   , 0} )
AADD( aDBF, {"NOME"    , "C", 40      , 0} )

AADD( aDBF, {"OCOR"    , "C", 6       , 0} )  //Ocorrencia
AADD( aDBF, {"OCORDESC", "C", 80      , 0} )  //Descricao Ocorrencia
AADD( aDBF, {"DATAOC"  , "D", 8       , 0} )  //Data Ocorrencia
AADD( aDBF, {"GRAVID"  , "C", 19      , 0} )  //Gravidade Ocorrencia

AADD( aDBF, {"MAT"     , "C", nTamSX3 , 0} )  //Matricula Funcionario
AADD( aDBF, {"NOMEFU"  , "C", 30      , 0} )  //Nome Funcionario

AADD( aDBF, {"CC"      , "C", nSizeSI3, 0} )  //Cod Centro de Custo
AADD( aDBF, {"DESCCC"  , "C", 25      , 0} )	//Descricao Centro de Custo

oTempTRB1 := FWTemporaryTable():New( "TRB", aDBF )
Do Case
	Case mv_par11 == 1		//Matricula + Ocorrencia + Data
		oTempTRB1:AddIndex( "1", { "CLIENT","LOJA","MAT","OCOR","DATAOC" } )
	Case mv_par11 == 2		//Nome Funcionario + Ocorrencia + Data
		oTempTRB1:AddIndex( "1", { "CLIENT","LOJA","NOMEFU","OCOR","DATAOC" } )
	Case mv_par11 == 3 		//C.C. + Matricula + Ocorrencia + Data
	    oTempTRB1:AddIndex( "1", { "CLIENT","LOJA","CC","MAT","OCOR","DATAOC" } )
	Case mv_par11 == 4		//C.C. + Nome Funcionario + Ocorrencia + Data
	    oTempTRB1:AddIndex( "1", { "CLIENT","LOJA","CC","NOMEFU","OCOR","DATAOC" } )
	Case mv_par11 == 5 		//Ocorrencia + Filial + Matricula + Data
	    oTempTRB1:AddIndex( "1", { "CLIENT","LOJA","OCOR","MAT","DATAOC" } )
EndCase
oTempTRB1:Create()

/* Verifica o modo de acesso da tabela TO8.  													 */
/* Se o modo de acesso for exclusivo, o programa buscara' registros na tabela TO8 utilizando
os campos Filial e Matricula dos funcionarios selecionados na tabela SRA.                        */
/* Senao, ele buscara' registros utilizando apenas a Matricula, uma vez que todas as filiais
tem acesso a eles.																				 */
/* Essa diferenciacao e' necessaria, pois o que define a filial do funcionario e' o campo FILIAL
da tabela SRA, e nao o campo FILIAL da tabela TO8. O ultimo apenas serve para separar as
ocorrencias por Filial. O fato da tabela TO8 estar em modo de acesso compartilhado ou exclusivo
pouco importa no que se refere 'a definicao da filial do funcionario -- isso apenas define se
os registros que estao na TO8 devem ser acessados apenas pela filial que os criou ou nao.		 */

If FWModeAccess("TO8",3)+FWModeAccess("TO8",2)+FWModeAccess("TO8",1) == "EEE"
	lExcluTO8 := .T.
EndIf

DbSelectArea ("SRA")
DbSetOrder (02)  //RA_FILIAL+RA_CC+RA_MAT
dbSeek( xFilial("SRA") + MV_PAR05, .T.)
SetRegua(LastRec())

While !Eof() .AND. SRA->RA_FILIAL = xFilial("SRA") .AND. SRA->RA_CC >= MV_PAR05 .AND. SRA->RA_CC <= MV_PAR06

	IncRegua()

    If SRA->RA_MAT < mv_par07 .OR. SRA->RA_MAT > mv_par08
    	DbSkip()
    	Loop
    EndIf

   	DbSelectArea ("TO8")
	DbSetOrder (02)		//Filial + Matricula
   	DbSeek ( If(lExcluTO8,SRA->RA_FILIAL,xFilial("TO8")) + SRA->RA_MAT )
   	While TO8->TO8_FILIAL == If(lExcluTO8,SRA->RA_FILIAL,xFilial("TO8"))	  .AND.;
		  TO8->TO8_MAT    == SRA->RA_MAT	  								  .AND.;
		  !EOF()

	    If TO8->(TO8_CLIENT+TO8_LOJA) < mv_par01+mv_par02 .OR. TO8->(TO8_CLIENT+TO8_LOJA) > mv_par03+mv_par04
	    	DbSkip()
	    	Loop
	    EndIf

		If TO8->TO8_DTOCOR < mv_par09  .OR.  TO8->TO8_DTOCOR > mv_par10
			DbSkip()
			Loop
	    EndIf

		dbSelectArea("TRB")
		Reclock("TRB",.T.)
		TRB->CLIENT    := TO8->TO8_CLIENT
		TRB->LOJA      := TO8->TO8_LOJA
		TRB->NOME      := NGSEEK("SA1",TO8->TO8_CLIENT+TO8->TO8_LOJA,1,"SA1->A1_NOME")
		TRB->OCOR      := TO8->TO8_CODOCO
		TRB->OCORDESC  := NgSeek("TO7",TO8->TO8_CLIENT+TO8->TO8_LOJA+TO8->TO8_CODOCO,2,"TO7->TO7_DESOCO")
		TRB->DATAOC    := TO8->TO8_DTOCOR
		Do Case
			Case TO8->TO8_GRAVID == '1';	 TRB->GRAVID := STR0025		//"Advertência Verbal"
			Case TO8->TO8_GRAVID == '2';	 TRB->GRAVID := STR0026		//"Advertência Escrita"
			Case TO8->TO8_GRAVID == '3';	 TRB->GRAVID := STR0027		//"Suspensão"
			Case TO8->TO8_GRAVID == '4';	 TRB->GRAVID := STR0028		//"Demissão"
		EndCase

		TRB->MAT       := SRA->RA_MAT
		TRB->NOMEFU    := SRA->RA_NOME
		TRB->CC        := U_fCUSTOTO8(SRA->RA_MAT,TO8->TO8_DTOCOR,TO8->TO8_CLIENT+TO8->TO8_LOJA)
		TRB->DESCCC    := NgSeek(cTableCC,TRB->CC,1,cDesCC)
		MsUnlock("TRB")

   		DbSelectArea("TO8")
   		DbSkip()
   	EndDo

	DbSelectArea("SRA")
	DbSkip()
EndDo

DbSelectArea("TRB")
DbGoTop()
If RecCount()==0
	MsgInfo(STR0024)	//"Não há nada para imprimir no relatório."
	oTempTRB1:Delete()
	Return .F.
EndIf

//Imprime o relatorio de acordo com a ordenacao escolhida
Do Case
	Case mv_par11 == 1 .OR. mv_par11 == 2
		U__RImp241_(1)
	Case mv_par11 == 3 .OR. mv_par11 == 4
		U__RImp241_(2)
	OtherWise
		U__RImp241_(3)
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("SRA")
RetIndex("TO8")

oTempTRB1:Delete()

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³SomaLinha ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 13/02/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function SomaLinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
        lNewPage := .T.
    Else
    	lNewPage := .F.
    EndIf
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³RImp241_ ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 12/04/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o relatorio de acordo com o agrupamento escolhido. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ U_RImp241_(nOrdem)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nOrdem - Indica qual e' o agrupamento escolhido.           ³±±
±±³          ³          1 - Matricula                                     ³±±
±±³          ³          2 - Centro de Custo                               ³±±
±±³          ³          3 - No. da Ocorrencia                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
User Function RImp241_(nOrdem)
LOCAL cMat  := ""
LOCAL cCC   := ""
LOCAL cOcor := ""
LOCAL cFil  := ""

SomaLinha()

Do Case

Case nOrdem == 1

	While !EOF()

		If cMat != TRB->MAT
			cMat := TRB->MAT
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 Psay TRB->FIL
			@ Li,014 Psay TRB->NOMEFIL
			@ Li,047 PSay TRB->MAT
			@ Li,059 PSay TRB->NOMEFU
			@ Li,092 PSay TRB->CC
			@ Li,113 PSay SubSTR(TRB->DESCCC, 1, 19)
			SomaLinha(); If ( !lNewPage, SomaLinha(), Nil )
		Endif

		@ Li,007 PSay TRB->OCOR
		@ Li,019 PSay TRB->DATAOC
		@ Li,030 PSay TRB->GRAVID
		@ Li,052 PSay TRB->OCORDESC
		SomaLinha()

		DbSkip()
	EndDo

Case nOrdem == 2

	While !EOF()

		If cCC != TRB->CC
			cCC  := TRB->CC
			cMat := TRB->MAT
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 Psay TRB->FIL
			@ Li,014 Psay TRB->NOMEFIL
			@ Li,047 PSay TRB->CC
			@ Li,068 PSay TRB->DESCCC
			SomaLinha(); 	If ( !lNewPage, SomaLinha(), Nil )
			@ Li,003 PSay STR0020	//"Matrícula:"
			@ Li,014 PSay TRB->MAT
			@ Li,024 PSay STR0029	//"Nome Funcionário:"
			@ Li,042 PSay TRB->NOMEFU
			SomaLinha()
		Else
			If cMat != TRB->MAT
				cMat := TRB->MAT
				SomaLinha()
				@ Li,003 PSay STR0020	//"Matrícula:"
				@ Li,014 PSay TRB->MAT
				@ Li,024 PSay STR0029	//"Nome Funcionário:"
				@ Li,042 PSay TRB->NOMEFU
				SomaLinha()
			EndIf
		Endif

		@ Li,006 PSay TRB->OCOR
		@ Li,018 PSay TRB->DATAOC
		@ Li,029 PSay TRB->GRAVID
		@ Li,050 PSay TRB->OCORDESC
		SomaLinha()

		DbSkip()
	EndDo

Case nOrdem == 3

	While !EOF()

		If cOcor != TRB->OCOR
			cFil := ""
			cOcor := TRB->OCOR
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay TRB->OCOR
			@ Li,013 PSay TRB->OCORDESC
			SomaLinha()
		Endif

		If cFil != TRB->FIL
			cFil := TRB->FIL
			SomaLinha()
			@ Li,003 PSay STR0031	//"Filial:"
			@ Li,011 PSay TRB->FIL
			@ Li,024 PSay STR0032	//"Nome Filial:"
			@ Li,038 PSay TRB->NOMEFIL
			SomaLinha()
		EndIf

		@ Li,009 PSay TRB->MAT
		@ Li,021 PSay TRB->NOMEFU
		@ Li,054 PSay TRB->CC
		@ Li,075 PSay TRB->DESCCC
		@ Li,102 PSay TRB->DATAOC
		@ Li,113 PSay TRB->GRAVID
		SomaLinha()

		DbSkip()
	EndDo

EndCase

@ Li,000 PSAY Replicate("-",132)

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³_RImp241_ ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 14/02/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Imprime o relatorio de acordo com o agrupamento escolhido. ³±±
±±³          ³ (para prestador de serv.)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ U__RImp241_(nOrdem)                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nOrdem - Indica qual e' o agrupamento escolhido.           ³±±
±±³          ³          1 - Matricula                                     ³±±
±±³          ³          2 - Centro de Custo                               ³±±
±±³          ³          3 - No. da Ocorrencia                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
User Function _RImp241_(nOrdem)
LOCAL cMat  := ""
LOCAL cCC   := ""
LOCAL cOcor := ""
LOCAL cCliente := ""

SomaLinha()

Do Case

Case nOrdem == 1

	While !EOF()

		If cCliente <> TRB->CLIENT + TRB->LOJA
			cCliente := TRB->CLIENT + TRB->LOJA
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay STR0041 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOME  //"Cliente/Loja: "
			SomaLinha()
		Endif

		If cMat != TRB->MAT
			SomaLinha()
			cMat := TRB->MAT
			@ Li,000 PSay TRB->MAT
			@ Li,012 PSay TRB->NOMEFU
			@ Li,045 PSay TRB->CC
			@ Li,067 PSay TRB->DESCCC
			SomaLinha()
		Endif

		@ Li,007 PSay TRB->OCOR
		@ Li,019 PSay TRB->DATAOC
		@ Li,030 PSay TRB->GRAVID
		@ Li,052 PSay TRB->OCORDESC
		SomaLinha()

		DbSkip()
	EndDo

Case nOrdem == 2

	While !EOF()

		If cCliente <> TRB->CLIENT + TRB->LOJA
			cCliente := TRB->CLIENT + TRB->LOJA
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay STR0041 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOME  //"Cliente/Loja: "
			SomaLinha()
		Endif

		If cCC != TRB->CC
			SomaLinha()
			cCC  := TRB->CC
			cMat := TRB->MAT
			@ Li,000 PSay TRB->CC
			@ Li,022 PSay TRB->DESCCC
			SomaLinha(); 	If ( !lNewPage, SomaLinha(), Nil )
			@ Li,003 PSay STR0020	//"Matrícula:"
			@ Li,014 PSay TRB->MAT
			@ Li,024 PSay STR0029	//"Nome Funcionário:"
			@ Li,042 PSay TRB->NOMEFU
			SomaLinha()
		Else
			If cMat != TRB->MAT
				cMat := TRB->MAT
				SomaLinha()
				@ Li,003 PSay STR0020	//"Matrícula:"
				@ Li,014 PSay TRB->MAT
				@ Li,024 PSay STR0029	//"Nome Funcionário:"
				@ Li,042 PSay TRB->NOMEFU
				SomaLinha()
			EndIf
		Endif

		@ Li,006 PSay TRB->OCOR
		@ Li,018 PSay TRB->DATAOC
		@ Li,029 PSay TRB->GRAVID
		@ Li,050 PSay TRB->OCORDESC
		SomaLinha()

		DbSkip()
	EndDo

Case nOrdem == 3

	While !EOF()

		If cCliente <> TRB->CLIENT + TRB->LOJA
			cCliente := TRB->CLIENT + TRB->LOJA
			@ Li,000 PSay Replicate("-",132)
			SomaLinha()
			@ Li,000 PSay STR0041 + TRB->CLIENT + "-" + TRB->LOJA + " - " + TRB->NOME  //"Cliente/Loja: "
			SomaLinha()
			SomaLinha()
		Endif

		If cOcor != TRB->OCOR
			cFil := ""
			cOcor := TRB->OCOR
			@ Li,000 PSay TRB->OCOR
			@ Li,013 PSay TRB->OCORDESC
			SomaLinha()
		Endif

		@ Li,009 PSay TRB->MAT
		@ Li,021 PSay TRB->NOMEFU
		@ Li,054 PSay TRB->CC
		@ Li,076 PSay TRB->DESCCC
		@ Li,093 PSay TRB->DATAOC
		@ Li,104 PSay TRB->GRAVID
		SomaLinha()

		DbSkip()
	EndDo

EndCase

@ Li,000 PSAY Replicate("-",132)

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ValFil   ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 17.04.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Valida a pergunta "Ate filial? "                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³nCampo  - Campo a validar. 1="De Filial"; 2="Ate Filial"    ³±±
±±³          ³cEmp    - Codigo da empresa                                 ³±±
±±³          ³cFilDe  - Valor da pergunta "De filial ?"                   ³±±
±±³          ³cFilAte - Valor da pergunta "Ate Filal ?"                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function ValFil(nCampo,cEmp,cFilDe,cFilAte)
LOCAL lRet := .F.
LOCAL aAreaSM0 := SM0->(GetArea())

If nCampo == 1

	Do Case
		Case Empty(cFilDe)
			lRet := .T.
	    OtherWise
		    Dbselectarea("SM0")
			IF Dbseek(cEmp+cFilDe)
				lRet := .T.
			Else
				Help(" ",1,"REGNOIS")
			EndIF
	EndCase

Else

	Do Case
		Case cFilAte == Replicate('Z',nSizeFil)
			lRet := .T.
		Case Empty(cFilAte)
			Help(" ",1,"REGNOIS")
		OtherWise
			Dbselectarea("SM0")
			IF Dbseek(cEmp+cFilDe)
   				If atecodigo('SM0',cEmp+cFilDe,cEmp+cFilAte)
					lRet := .T.
				EndIf
			Else
				Help(" ",1,"REGNOIS")
			EndIF
	EndCase

EndIf

RestArea(aAreaSM0)

Return lRet
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³fCUSTOTO8 ³ Autor ³Andre E. Perez Álvarez ³ Data ³14/02/2008³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Busca o centro de custo do funcionario na epoca da Ocorrencia±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR241                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function fCUSTOTO8(cMAT,__dDTOCOR,cCliente)

Local cCentroC  := SRA->RA_CC
Local cCentroC2 := Space(nSizeSI3)
Local dDTOCOR   := stod(Space(8))
Local dDTINIC   := stod(Space(8))
Local lFirst    := .t.
Local cCentroR  := SRA->RA_CC  //Centro de Custo retornado

Dbselectarea("SRE")
Dbsetorder(2)
Dbseek(SM0->M0_CODIGO+SM0->M0_CODFIL+SRA->RA_MAT)

While !eof() .and. SM0->M0_CODIGO+SM0->M0_CODFIL+SRA->RA_MAT == SRE->RE_EMPP+SRE->RE_FILIALP+SRE->RE_MATP

	If SRE->RE_DATA < dDTINIC .or. Empty(dDTINIC)
		cCentroC2 := SRE->RE_CCD
		dDTINIC   := SRE->RE_DATA
	Endif
	If SRE->RE_DATA <= __dDTOCOR .and. (SRE->RE_DATA > dDTOCOR .or. Empty(dDTOCOR))
		lFirst   := .f.
		dDTOCOR  := SRE->RE_DATA
		cCentroC := SRE->RE_CCP
	Endif

	Dbselectarea("SRE")
	Dbskip()
End

If lFirst .and. !Empty(cCentroC2)
	cCentroC := cCentroC2
Endif

If SubSTR(cCentroC,1,nSizeTD) = cCliente
	cCentroR := cCentroC
Endif

Return cCentroR