/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr482.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR482  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Resultado dos Exames por Centro de Custo.      ³±±
±±³          ³Demonstra por C.Custo o resultado dos  exames ocupacionais  ³±±
±±³          ³realizados na empresa.                                      ³±±
±±³          ³Atraves dos parametros o usuario podera selecionar um exame ³±±
±±³          ³especifico o todos, um C.Custo ou todos e ainda um periodo  ³±±
±±³          ³determinado. Com base nos parametro o programa ira obter    ³±±
±±³          ³as informacoes da tabela de exames do funcionario - TM5.    ³±±
±±³          ³O Relatorio saira classificado por c.custo e por codigo do  ³±±
±±³          ³resultado do exame.                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR482(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR482()

Local nTamGrupExa := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

Local oReport
Local aArea := GetArea()
LOCAL cF3CC := "CTT001"  //SI3 apenas do cliente

Private aTrb := {}
Private nPos482
lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private lPRI1 := .T., lPRI2 := .T.
Private nCONTACUM := 0, nCONTAD := 0
Private cPerg := If(!lSigaMdtPS,"MDT482    ","MDT482PS  ")

Private cAliasCC := "CTT"
Private cDescCC  := "CTT->CTT_DESC01"
Private cCodCC   := "CTT->CTT_CUSTO"
Private cCodCC2  := "CTT_CUSTO"
Private nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))


If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*----------------------------------
//PERGUNTA PADRÃO						|
| 01  De  Exame ?           		|
| 02  Ate Exame ?           		|
| 03  De  Resultado Exame ? 		|
| 04  Ate Resultado Exame ? 		|
| 05  De  Centro de Custo ? 		|
| 06  Ate Centro de Custo ? 		|
| 07  De  Data Resultado ?  		|
| 08  Ate Data Resultado ?  		|
| 09  Medicina ?            		|
| 10  Listar Obs. Exames ?  		|
										|
//PERGUNTAS PRESTADOR DE SERVIÇO	|
| 01  De Cliente ?          		|
| 02  Loja                  		|
| 03  Até Cliente ?         		|
| 04  Loja	                			|
| 05  De  Centro de Custo ? 		|
| 06  Ate Centro de Custo ? 		|
| 07  De  Exame ?           		|
| 08  Ate Exame ?           		|
| 09  De  Resultado Exame ? 		|
| 10  Ate Resultado Exame ? 		|
| 11  De  Data Resultado ?  		|
| 12  Ate Data Resultado ?  		|
| 13  Medicina ?            		|
| 14  Listar Obs. Exames ?  		|
------------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If TRepInUse()
   //-- Interface de impressao
   oReport := ReportDef()
   oReport:SetLandscape()
   oReport:PrintDialog()
Else
   U_MDTR482R3()
EndIf
RestArea(aArea)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve variaveis armazenadas (NGRIGHTCLICK)                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NGRETURNPRM(aNGBEGINPRM)

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³Andre E. Perez Alvarez ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define as secoes impressas no relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR482                                                    ³±±
±±|__________|____________________________________________________________|±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function ReportDef()

Local nX
Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
Static oReport
Static oSection1
Static oSection2
Static oSection3
Local lMV_NGMDTPS := .F.

If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lMV_NGMDTPS := .T.
Endif

Private aCampos := {}
AADD (aCampos, {"A1_COD"} )
If lSigaMdtps
	AADD (aCampos, {"A1_LOJA"} )
Endif
AADD (aCampos, {"A1_NOME"} )
AADD (aCampos, {"TM5_CC"} )
AADD (aCampos, {"CTT_DESC01"} )
AADD (aCampos, {"TM5_EXAME"} )
AADD (aCampos, {"TM4_NOMEXA"} )
AADD (aCampos, {"TM5_CODRES"} )
AADD (aCampos, {"TMU_RESULT"} )
AADD (aCampos, {"TM5_MAT"} )
AADD (aCampos, {"TM0_NOMFIC"} )
AADD (aCampos, {"TM5_DTPROG"} )

For nX := 1 To len(aCampos)    //Adiona a Picture para cada campo de acordo com o SX3
	AADD( aCampos[nX], X3Picture(aCampos[nX][1]) )
Next nX

//LAYOUT -- Nao - Prestador de Servico
/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

                                                       Resultado dos Exames Ocupacionais
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

Código    Centro de Custo
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
Observacao: 12345678901234567890123456789012345678901234567890123456789012345678901234567890
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456

Código    Centro de Custo
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
*/

//LAYOUT -- Prestador de Servico
/*        1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

                                                       Resultado dos Exames Ocupacionais
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

Cliente   Nome
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
123456    124567890124567890124567890124567890

Código    Centro de Custo
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________

123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
Observacao: 12345678901234567890123456789012345678901234567890123456789012345678901234567890
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456

Código    Centro de Custo
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MDTR482",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;
           STR0001+" "+STR0002+" "+STR0003)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Exame                             ³
//³ mv_par02             // Ate Exame                            ³
//³ mv_par03             // De Resultado                         ³
//³ mv_par04             // Ate Resultado                        ³
//³ mv_par05             // De Centro de Custo                   ³
//³ mv_par06             // Ate Centro de Custo                  ³
//³ mv_par07             // De Dt.Realizacao                     ³
//³ mv_par08             // Ate Dt.Realizacao                    ³
//³ mv_par09             // Medicina                             ³
//³                            1 - Ocupacional                   ³
//³                            2 - Assistencial                  ³
//³                            3 - Ambas                         ³
//³ mv_par10             // Listar Observação                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

If lSigaMdtps

	oSection1 := TRSection():New (oReport,STR0026, {"TM5", "SA1"} )  //"Cliente"
	TRCell():New (oSection1, "A1_COD" , "SA1", STR0026, "@!", nTa1 )  //"Cliente"
	TRCell():New (oSection1, "A1_LOJA", "SA1", STR0030, "@!", nTa1L ) //"Loja"
	TRCell():New (oSection1, "A1_NOME", "SA1", STR0027, "@!", 40 )    //"Nome"
	TRPosition():New (oSection1, "SA1", 1, {|| xFilial("SA1") + Substr( aTrb[nPos482][1], 1,nSizeTD ) } )

	oSection2 := TRSection():New(oReport, STR0019,{"TM5","CTT"})  //"Centro de Custo"
	TRCell():New (oSection2, "TM5_CC" , "TM5", STR0017, "@!", nSizeSI3 )  ////"Descrição"
	TRCell():New (oSection2, "CTT_DESC01", "CTT", STR0019, "@!", 40       )  //"Centro de Custo"
    TRPosition():New (oSection2, "CTT", 1, {|| xFilial("CTT") + aTrb[nPos482][1] } )
    TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + aTrb[nPos482][3] } )
    TRPosition():New (oSection2, "TMU", 1, {|| xFilial("TMU") + aTrb[nPos482][6] } )
    TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + aTrb[nPos482][12] } )
	TRPosition():New (oSection2, "TM5", 1, {|| xFilial("TM5") + aTrb[nPos482][12] + DTOS(aTrb[nPos482][9]) + aTrb[nPos482][3] } )

	oSection3 := TRSection():New (oReport,STR0036, {"TM5","TM4","TMU","TM0"})  //"Exames"
	oCell := TRCell():New (oSection3, "TM5_EXAME" , "TM5", STR0018, "@!", nTamExa, /*lPixel*/, {|| aTrb[nPos482][3]})  //"Exame"
	oCell := TRCell():New (oSection3, "TM4_NOMEXA", "TM4", STR0019, "@!", 30, /*lPixel*/, {|| aTrb[nPos482][4]}) //"Descrição"
	oCell := TRCell():New (oSection3, "TM5_CODRES", "TM5", STR0021, "@!", 04, /*lPixel*/, {|| aTrb[nPos482][5]}) //"Resultado"
	oCell := TRCell():New (oSection3, "TMU_RESULT", "TMU", STR0019, "@!", 20, /*lPixel*/, {|| aTrb[nPos482][6]}) //"Descrição"
	oCell := TRCell():New (oSection3, "TM5_MAT"   , "TM5", STR0022, "@!", 06, /*lPixel*/, {|| aTrb[nPos482][7]}) //"Matrícula"
	oCell := TRCell():New (oSection3, "TM0_NOMFIC", "TM0", STR0023, "@!", 30, /*lPixel*/, {|| aTrb[nPos482][8]}) //"Funcionário"
	oCell := TRCell():New (oSection3, "TM5_DTPROG", "TM5", STR0024, "99/99/9999", 08, /*lPixel*/, {|| aTrb[nPos482][9]}) //"Realização"
	oCell := TRCell():New (oSection3, "cNatExa_"  , "TM5", STR0025, "@!"        , 14, /*lPixel*/, {|| aTrb[nPos482][10]}) //"Natureza"
	TRPosition():New (oSection3, "TM4", 1, {|| xFilial("TM4") + aTrb[nPos482][3] } )
    TRPosition():New (oSection3, "TMU", 1, {|| xFilial("TMU") + aTrb[nPos482][6] } )
    TRPosition():New (oSection3, "TM0", 1, {|| xFilial("TM0") + aTrb[nPos482][12] } )
	TRPosition():New (oSection3, "TM5", 1, {|| xFilial("TM5") + aTrb[nPos482][12] + DTOS(aTrb[nPos482][9]) + aTrb[nPos482][3] } )
ElseIf lMV_NGMDTPS

	oSection1 := TRSection():New (oReport,STR0026, {"TM5", "SA1"} )  //"Cliente"
	TRCell():New (oSection1, "A1_COD" , "SA1", STR0026, Pict482MDT("A1_COD") , TAMSX3_("A1_COD", 6) )  //"Cliente"
	TRCell():New (oSection1, "A1_NOME", "SA1", STR0027, Pict482MDT("A1_NOME"), 40                    ) //"Nome"
	TRPosition():New (oSection1, "SA1", 1, {|| xFilial("SA1") + Substr( TM5->TM5_CC, 1, TAMSX3_("A1_COD", 6) ) } )

	oSection2 := TRSection():New(oReport,STR0019,{"TM5","SI3"})  //"Centro de Custo"
	TRCell():New (oSection2, "TM5_CC" , "TM5", STR0017, Pict482MDT("TM5_CC") , TAMSX3_("TM5_CC",20),{|| aTrb[nPos482][1]} ) //"Descrição"
	TRCell():New (oSection2, "I3_DESC", "SI3", STR0019, Pict482MDT("I3_DESC"), 40                   )  //"Centro de Custo"
    TRPosition():New (oSection2, "SI3", 1, {|| xFilial("SI3") + TM5->TM5_CC} )
    TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + TM5->TM5_EXAME} )
    TRPosition():New (oSection2, "TMU", 1, {|| xFilial("TMU") + TM5->TM5_CODRES} )
    TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + TM5->TM5_NUMFIC} )

	oSection3 := TRSection():New (oReport,STR0036, {"TM5","TM4","TMU","TM0"}) //"Exames"
	oCell := TRCell():New (oSection3, "TM5_EXAME" , "TM5", STR0018, Pict482MDT("TM5_EXAME") , nTamExa, /*lPixel*/, /*{|| code-block de impressao }*/ ) //"Exame"
	oCell := TRCell():New (oSection3, "TM4_NOMEXA", "TM4", STR0019, Pict482MDT("TM4_NOMEXA"), 30, /*lPixel*/, {|| aTrb[nPos482][4]}) //"Descrição"
	oCell := TRCell():New (oSection3, "TM5_CODRES", "TM5", STR0021, Pict482MDT("TM5_CODRES"), 04, /*lPixel*/, {|| aTrb[nPos482][5]}) //"Resultado"
	oCell := TRCell():New (oSection3, "TMU_RESULT", "TMU", STR0019, Pict482MDT("TMU_RESULT"), 20, /*lPixel*/, {|| aTrb[nPos482][6]}) //"Descrição"
	oCell := TRCell():New (oSection3, "TM5_MAT"   , "TM5", STR0022, Pict482MDT("TM5_MAT")   , 06, /*lPixel*/, {|| aTrb[nPos482][7]}) //"Matrícula"
	oCell := TRCell():New (oSection3, "TM0_NOMFIC", "TM0", STR0023, Pict482MDT("TM0_NOMFIC"), 30, /*lPixel*/, {|| aTrb[nPos482][8]}) //"Funcionário"
	oCell := TRCell():New (oSection3, "TM5_DTPROG", "TM5", STR0024, Pict482MDT("TM5_DTPROG"), 08, /*lPixel*/, {|| aTrb[nPos482][9]}) //"Realização"
	oCell := TRCell():New (oSection3, "cNatExa_"  , "TM5", STR0025, "@!"                    , 14, /*lPixel*/, {|| aTrb[nPos482][10]}) //"Natureza"
	TRPosition():New (oSection3, "TM4", 1, {|| xFilial("TM4") + TM5->TM5_EXAME} )
    TRPosition():New (oSection3, "TMU", 1, {|| xFilial("TMU") + TM5->TM5_CODRES} )
    TRPosition():New (oSection3, "TM0", 1, {|| xFilial("TM0") + TM5->TM5_NUMFIC} )

Else

	oSection1 := TRSection():New (oReport, STR0019, {"TM5","CTT"} )   //"Centro de Custo"
	TRCell():New(oSection1, "TM5_CC" , "TM5", STR0017, Pict482MDT("TM5_CC") , 09 ,/*lPixel*/,{|| aTrb[nPos482][1]}) //"Descrição"
	TRCell():New(oSection1, "CTT_DESC01", "CTT", STR0019, Pict482MDT("CTT_DESC01"), 40 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Exame" //"Centro de Custo"
    TRPosition():New (oSection1, "CTT", 1, {|| xFilial("CTT") + aTrb[nPos482][1] } )
    TRPosition():New (oSection1, "TM5", 1, {|| xFilial("TM5") + aTrb[nPos482][12] + DTOS(aTrb[nPos482][9]) + aTrb[nPos482][3] } )

	oSection2 := TRSection():New (oReport,STR0036, {"TM5","TM4","TMU","TM0"} )  //"Exames"
	oCell := TRCell():New (oSection2, "TM5_EXAME" , "TM5", STR0018, Pict482MDT("TM5_EXAME") , nTamExa, /*lPixel*/,{||  aTrb[nPos482][3]}) //"Exame"
	oCell := TRCell():New (oSection2, "TM4_NOMEXA", "TM4", STR0019, Pict482MDT("TM4_NOMEXA"), 30, /*lPixel*/,{|| aTrb[nPos482][4]}) //"Descrição"
	oCell := TRCell():New (oSection2, "TM5_CODRES", "TM5", STR0021, Pict482MDT("TM5_CODRES"), 04, /*lPixel*/,{|| aTrb[nPos482][5]}) //"Resultado"
	oCell := TRCell():New (oSection2, "TMU_RESULT", "TMU", STR0019, Pict482MDT("TMU_RESULT"), 20, /*lPixel*/,{|| aTrb[nPos482][6]}) //"Descrição"
	oCell := TRCell():New (oSection2, "TM5_MAT"   , "TM5", STR0022, Pict482MDT("TM5_MAT")   , 06, /*lPixel*/,{|| aTrb[nPos482][7]}) //"Matrícula"
	oCell := TRCell():New (oSection2, "TM0_NOMFIC", "TM0", STR0023, Pict482MDT("TM0_NOMFIC"), 30, /*lPixel*/,{|| aTrb[nPos482][8]}) //"Funcionário"
	oCell := TRCell():New (oSection2, "TM5_DTPROG", "TM5", STR0024, Pict482MDT("TM5_DTPROG"), 08, /*lPixel*/,{|| aTrb[nPos482][9]}) //"Realização"
	oCell := TRCell():New (oSection2, "cNatExa_"  , "TM5", STR0025, "@!"                    , 20, /*lPixel*/, {|| aTrb[nPos482][10]}) //"Natureza"
	TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + aTrb[nPos482][3] } )
    TRPosition():New (oSection2, "TMU", 1, {|| xFilial("TMU") + aTrb[nPos482][6] } )
    TRPosition():New (oSection2, "TM0", 1, {|| xFilial("TM0") + aTrb[nPos482][12] } )
    TRPosition():New (oSection2, "TM5", 1, {|| xFilial("TM5") + aTrb[nPos482][12] + DTOS(aTrb[nPos482][9]) + aTrb[nPos482][3] } )

Endif

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportPrint()

Local lMV_NGMDTPS := .F.
Local bWHILE := {|| ( !Eof() .AND. !oReport:Cancel()      .AND.;
					   TM5->TM5_FILIAL == xFilial('TM5')   .AND.;
					   TM5->TM5_CC <= MV_PAR06					   ) }
Local lImprimiu := .F.
Local i
Local xm_par10 := If(lSigaMdtPs,mv_par14,mv_par10)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCC := space(9)
cCliente := ""
lPrint := .t.

	If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
		lMV_NGMDTPS := .T.
		bWHILE := {|| ( !Eof() .AND. !oReport:Cancel()      .AND.;
	     					 TM5->TM5_FILIAL == xFilial('TM5')   .AND.;
							 TM5->TM5_CC <= MV_PAR06			  .AND.;
						  	 cCliente == Substr(TM5->TM5_CC,1,6)  ) 	}

	Endif
	//Carrega o Array
	CargPadrao(.T.)

lPrint_cabec := .F.
cCC := space(9)
cEXA := space(If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1]))
lMV_NGMDTPS := .f.
cCliente    := ""
aTMYCombo := MDTCbox("TM5_NATEXA"," ",1)
lPrint := .t.
If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
	lMV_NGMDTPS := .t.
Endif

oReport:SetMeter(Len(aTrb))
aSort (aTrb ,,, {|x,y| x[1] < y[1] })
For i := 1 to len(aTrb)
	nPos482 := i
	If lMV_NGMDTPS .or. lSigaMdtps
		If i == 1
			cCliente := SubStr(aTrb[i][1],1,6)
			lPrint_cabec := .T.
		ElseIf cCliente <> SubStr(aTrb[i][1],1,6)
			cCliente := SubStr(aTrb[i][1],1,6)
			oReport:EndPage()
			oReport:StartPage()
			lPrint_cabec := .T.
		EndIf
	EndIf

	If lPrint_cabec .and. (lMV_NGMDTPS .or. lSigaMdtps)
		lPrint_cabec := .f.
		oSection1:Finish()
		oSection1:Init()
		oSection1:PrintLine()
	Else
		lPrint := .f.
	Endif
    If cCC <> aTrb[i][1]
        cCC  := aTrb[i][1]
        cEXA := ""
		If lMV_NGMDTPS .or. lSigaMdtps
			oSection3:Finish()
			oSection2:Finish()

			oSection2:Init()
		   	oSection2:PrintLine()
		   	oSection3:Init()
		Else
			oSection2:Finish()
			oSection1:Finish()

			oSection1:Init()
		   	oSection1:PrintLine()
		   	oSection2:Init()
		Endif
	Endif
    lPrimeiro := .f.
    lImprimiu := .T.
    If cEXA <> aTrb[i][3]
         cEXA:= aTrb[i][3]
    EndIf
      If lMV_NGMDTPS .or. lSigaMdtps
      	oSection3:PrintLine()
    Else
     	oSection2:PrintLine()
    Endif
      IF xm_par10 == 2 .AND. !EMPTY(aTrb[i][11])
      	oReport:PrintText(STR0037 + AllTrim(aTrb[i][11]), , 70 )  //"Observação: "
    ENDIF
	oReport:IncMeter()
Next i
If lMV_NGMDTPS .or. lSigaMdtps
   		oSection3:Finish()
EndIf
oSection2:Finish()
oSection1:Finish()

If lMV_NGMDTPS .or. lSigaMdtps
	oReport:EndPage()
EndIf

If !lImprimiu
	MsgInfo(STR0038)  //"Não há nada para imprimir no relatório."
	Return .F.
Endif

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TAMSX3_    ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna tamanho do campo no SX3.                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR482                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function TAMSX3_(cCampo, nDefault)

nTamanho := If( (TAMSX3(cCampo)[1]) < 1, nDefault, (TAMSX3(cCampo)[1]) )

Return nTamanho

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Pict482MDT ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Retorna a Picuture do campo informado.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR482                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function Pict482MDT(cCampo)

Local cPicture
Local nIND

nIND := aScan ( aCampos, {|x| x[1] == cCampo } )
cPicture := AllTrim ( aCampos[nIND][2] )

Return cPicture

/****************************************************************************
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR482R3 ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Resultado dos Exames por Centro de Custo (R3)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR482                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR482R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR482"
LOCAL cDesc1  := STR0001 //"Relatorio do Resultado dos exames por Centro de Custo                "
LOCAL cDesc2  := STR0002 //"Demonstrativo dos resultados dos exames realizados dentro de um      "
LOCAL cDesc3  := STR0003 //"periodo classificados por Centro de Custo e resultado do exame.      "
LOCAL cString := "TM5"

PRIVATE nomeprog := "MDTR482"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Resultado dos Exames Ocupacionais"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Exame                             ³
//³ mv_par02             // Ate Exame                            ³
//³ mv_par03             // De Resultado                         ³
//³ mv_par04             // Ate Resultado                        ³
//³ mv_par05             // De Centro de Custo                   ³
//³ mv_par06             // Ate Centro de Custo                  ³
//³ mv_par07             // De Dt.Realizacao                     ³
//³ mv_par08             // Ate Dt.Realizacao                    ³
//³ mv_par09             // Medicina                             ³
//³                            1 - Ocupacional                   ³
//³                            2 - Assistencial                  ³
//³                            3 - Ambas                         ³
//³ mv_par10             // Listar Observação                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR482"

WnRel:=SetPrint(cString,WnRel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.,"G")

If nLastKey == 27
	Set Filter to
 	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

RptStatus({|lEnd| R482Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R482Imp  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio (R3)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR482                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function R482Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local i
Local xm_par10 := If(lSigaMdtPs,mv_par14,mv_par10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lPrimeiro := .t.
cabec1 := STR0007 //"Centro de Custo    Descrição"
cabec2 := STR0013 //"       Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza"

/*
*****************************************************************************************************************************************************************************************************************************
*<empresa>                                                                                                                                                                                                 Folha..: xxxxx   *
*SIGA /<nome .04                                                                          Resultado dos Exames Ocupacionais                                                                                DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                                                                                                         Emissao: dd/mm/aa*
*****************************************************************************************************************************************************************************************************************************
          1         2         3         4         5         6         7         8         9       100       110       120       130       140       150       160       170       180       190       200       210       220
01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
Código                   Centro de Custo
       Exame   Nome do Exame                             Cód.Desc.  Resultado Exame                           Matrícula  Funcionário                               Realização  Natureza
_____________________________________________________________________________________________________________________________________________________________________________________________________________________________
xxxxxxxxx                xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
       123456  1234567890123456789012345678901234567890  1234       1234567890123456789012345678901234567890  123456     1234567890123456789012345678901234567890  xx/xx/xx    1234567890123456
*/
aTrb := {}

	CargPadrao(.F.)

	lPrint_cabec := .F.
	cCC := space(9)
	cEXA := space(If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1]))
	lMV_NGMDTPS := .f.
	cCliente    := ""
	aTMYCombo := MDTCbox("TM5_NATEXA"," ",1)
	lPrint := .t.
	If SuperGetMv("MV_NGMDTPS",.F.,"N") == "S"
		lMV_NGMDTPS := .t.
	Endif

	aSort (aTrb ,,, {|x,y| x[1] < y[1] })
	For i := 1 to len(aTrb)
		nPos482 := i
		If lMV_NGMDTPS
			If i == 1
				cCliente := SubStr(aTrb[i][1],1,6)
				lPrint_cabec := .T.
			ElseIf cCliente <> SubStr(aTrb[i][1],1,6)
				cCliente := SubStr(aTrb[i][1],1,6)
				lPrint_cabec := .F.
			EndIf
		EndIf

		If lPrint_cabec .and. lMV_NGMDTPS
			Printcabec()
			lPrint_cabec := .f.
		Else
			lPrint := .f.
		Endif
      If cCC <> aTrb[i][1]
         cCC  := aTrb[i][1]
         cEXA := ""
			Somalinha()
			If !lPrimeiro
				Somalinha()
			Endif
			@ Li,000 PSay aTrb[i][1]
	      @ Li,025 PSay aTrb[i][2]
		Endif
      somalinha()
      lPrimeiro := .f.
      If cEXA <> aTrb[i][3]
      	@ Li,007 PSay aTrb[i][3]  Picture "@!"
         @ Li,019 PSay aTrb[i][4]
         cEXA:= aTrb[i][3]
      EndIf
      @ Li,061 PSay aTrb[i][5] Picture "@!"
      @ Li,072 PSay aTrb[i][6]
      @ Li,114 PSay aTrb[i][7] Picture "999999"
      @ Li,125 PSay aTrb[i][8]
      @ Li,167 PSay aTrb[i][9]
      @ Li,179 PSAY aTrb[i][10]     PICTURE "@!"

      IF xm_par10 == 2 .AND. !EMPTY(aTrb[i][11])
      	somalinha()
         @LI,007 Psay STR0020 //"Obs.:"
         @LI,014 Psay aTrb[i][11]
      ENDIF
	Next i

//EJECT

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lPrint   //Se nao imprimiu
	MsgInfo(STR0038)  //"Não há nada para imprimir no relatório."
	RetIndex("TM5")
	Set Filter To
	Return .F.
Endif

RetIndex("TM5")

Set Filter To

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()

Return NIL
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina (R3)           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function Somalinha()
    Li++
    If Li > 58
        Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
    EndIf
Return
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³Denis Hyroshi de Souza ³ Data ³ 15/01/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina  (R3)          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR405                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function Printcabec()

If lSigaMdtps

	Dbselectarea("SA1")
	Dbsetorder(1)
	Dbseek(xFilial("SA1")+cCliente)
	If lPrint
       	Somalinha()
       	lPrint := .f.
	Else
       	Li := 80
       	Somalinha()
	Endif
	@Li,000 Psay STR0039 + AllTrim(SA1->A1_COD) +"-"+ AllTrim(SA1->A1_LOJA) +" - "+ AllTrim(SA1->A1_NOME)  //"Cliente/Loja: "
	Dbselectarea("TM5")

Else

	If lMV_NGMDTPS
		Dbselectarea("SA1")
		Dbsetorder(1)
		Dbseek(xFilial("SA1")+cCliente)
		If lPrint
	       	Somalinha()
	       	lPrint := .f.
		Else
	       	Li := 80
	       	Somalinha()
		Endif
		@Li,000 Psay STR0015+cCliente+If(Empty(SA1->A1_NOME),""," - "+SA1->A1_NOME) //"Cliente..: "
		Somalinha()
		Dbselectarea("TM5")
	Endif

Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MDTR482   ºAutor  ³Microsiga           º Data ³  04/18/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CargPadrao(lPerson)

Local aTMYCombo := MDTCbox( "TM5_NATEXA", " ", 1 )

Default cCC     := space( 9 )
Default cEXA    := ""

dbSelectArea("TM5")
dbSetOrder(07)  //TM5_FILIAL + TM5_CC + TM5_EXAME
dbSeek(xFilial("TM5")+MV_PAR05,.T.)

If !lPerson
	SetRegua(LastRec())
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Correr TM5 para ler os  Exames realizados                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
While !Eof()                                     .AND.;
      TM5->TM5_FILIAL == FwxFilial('TM5')        .AND.;
      TM5->TM5_CC <= MV_PAR06

	If !lPerson
		IncRegua()
	EndIf

    If Empty(TM5->TM5_CC)
	    dbSelectArea("TM5")
		dbSkip()
		Loop
    Endif

    If !Empty(TM5->TM5_DTRESU)
		If mv_par09 == 1   //Ocupacional
			If TM5->TM5_ORIGEX == "1"   //Assitencial
				DbSkip()
				Loop
			EndIf
		ElseIf mv_par09 == 2  //Assistencial
   			If TM5->TM5_ORIGEX == "2"   //Ocupacional
				DbSkip()
				Loop
			EndIf
        EndIf

		If TM5->TM5_EXAME   >= MV_PAR01               .AND.;
			TM5->TM5_EXAME   <= MV_PAR02               .AND.;
			TM5->TM5_CODRES  >= MV_PAR03               .AND.;
			TM5->TM5_CODRES  <= MV_PAR04               .AND.;
			TM5->TM5_CC      >= MV_PAR05               .AND.;
			TM5->TM5_CC      <= MV_PAR06               .AND.;
			TM5->TM5_DTPROG  >= MV_PAR07               .AND.;
			TM5->TM5_DTPROG  <= MV_PAR08

			If cCC <> TM5->TM5_CC
				cCC  := TM5->TM5_CC
				cEXA := ""
				dbSelectArea("CTT")
				dbSetOrder(01)
				dbSeek(xFilial("CTT")+TM5->TM5_CC)
			EndIf

			lPrimeiro := .f.
			
			If cEXA <> TM5->TM5_EXAME
				dbSelectArea("TM4")
				dbSetOrder(01)
				dbSeek(xFilial("TM4")+TM5->TM5_EXAME)
				cEXA:= TM5->TM5_EXAME
           	EndIf

			dbSelectArea("TMU")
			dbSetOrder(01)
			dbSeek(xFilial("TMU")+TM5->TM5_CODRES)
			dbSelectArea("TM0")
			dbSetOrder(01)
			dbSeek(xFilial("TM0")+TM5->TM5_NUMFIC)
			cBoxTMY := " "
			If (nIND := aScan(aTMYcombo,{|x| Upper(Substr(x,1,1)) == Substr(TM5->TM5_NATEXA,1,1)})) > 0
				cBoxTMY := Substr(aTMYcombo[nIND],3,20)
			Endif

			aadd( aTrb , { TM5->TM5_CC , CTT->CTT_DESC01 , TM5->TM5_EXAME , SUBSTR(TM4->TM4_NOMEXA,1,40) , TM5->TM5_CODRES ,;
							SUBSTR(TMU->TMU_RESULT,1,40) , TM5->TM5_MAT , SUBSTR(TM0->TM0_NOMFIC,1,40) , TM5->TM5_DTPROG ,;
							cBoxTMY , TM5->TM5_OBSERV , TM5->TM5_NUMFIC	} )

    	EndIf
    EndIf
	
	dbSelectArea("TM5")
	dbskip()

Enddo

Return
