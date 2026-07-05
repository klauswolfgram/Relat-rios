/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "mdtr490.ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR490  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos com o PCMSO.             ³±±
±±³          ³Sera considerado para o relatorio todos os exames, ou       ³±±
±±³          ³somente os que foram atendidos, ou somente os que nao foram ³±±
±±³          ³atendidos, de acordo com a preferencia do usuario.          ³±±
±±³          ³O programa le a tabela de Exames do Funcionario (TM5), e    ³±±
±±³          ³para cada exame realizado, o programa busca o valor na      ³±±
±±³          ³tabela precos (TMD), com base no fornecedor e na data de    ³±±
±±³          ³realizacao do exame (isto se o exame tiver sido realizado.  ³±±
±±³          ³Se a data do resultado estiver vazia, e o usuario escolher  ³±±
±±³          ³na pergunta "Considerar"  a opcao todos os exames ou so' nao³±±
±±³          ³atendidos, o custo do exame sera zero, pois nao ha como saber±±
±±³          ³o seu preco, pois a chave unica de um preco de exame e' com-³±±
±±³          ³posta pelo fornecedor, loja, exame e Dt. In. Valid. Prec.). ³±±
±±³          ³O relatorio saira classificado por centro de custo e por    ³±±
±±³          ³exame, acumulando os valores por exame. No final emite um   ³±±
±±³          ³resumo com os valores dos exames acumulados por filial.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MDTR490(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR490()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM( )

Local oReport
Local aArea := GetArea()
Local cF3
Local nTamGrupExa := 0
Private nSizeSI3
Private lMcontab := .T.
Private nSizeSA1  := If((TAMSX3("A1_COD")[1]) < 1,6,(TAMSX3("A1_COD")[1]))
Private nSizeLo1  := If((TAMSX3("A1_LOJA")[1]) < 1,6,(TAMSX3("A1_LOJA")[1]))
Private cAliasCC := "CTT"
Private cDescCC  := "CTT_DESC01"
Private lTMW_Filial := If( Empty(xFilial("TMW")) .and. !Empty(xFilial("SRA")) , .t. , .f. ) //Indica se o PCMSO é para varias filiais
Private aFilRelat := {}
Private nSizeFil  := Len(TMW->TMW_FILIAL)
Private aVetinr := {}
Private oTempTable

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )
lNGMDTPS := If( SuperGetMv("MV_NGMDTPS",.F.,"N") == "S", .t. , .f. )

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	If lSigaMdtps
		cF3 := "MDTPS9"
	Else
		cF3 := "CTT"
	Endif
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cDescCC2 := "CTT->CTT_DESC01"
Else
	If lSigaMdtps
		cF3 := "MDTPS8"
	Else
		cF3 := "SI3"
	Endif
	nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
	lMcontab := .F.
	cAliasCC := "SI3"
	cDescCC  := "I3_DESC"
	cDescCC2 := "SI3->I3_DESC"
Endif

PRIVATE cPerg := If(!lSigaMdtps,PADR( "MDT490" , 10 ),PADR( "MDT490PS" , 10 ))

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

/*------------------------------
//PERGUNTAS PADRÃO				|
| 01 PCMSO ?						|
| 02 De Data Progr. ?			|
| 03 Até Data Progr. ?			|
| 04 De  Centro de Custo ?		|
| 05 Ate Centro de Custo ?		|
| 06 De  Exame ?					|
| 07 Ate Exame ?					|
| 08 Considerar ?					|
| 09 De Filial ?					|
| 10 Ate Filial ?					|
---------------------------------*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adicionando as perguntas relacionadas a Exames ao grupo de   ³
//³ campos 048 - "Exame".                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//----------------- Impressão do Relatório -----------------
If TRepInUse()
   	//-- Interface de impressao
  	oReport := ReportDef()
	oReport:SetPortrait()
	oReport:PrintDialog()
Else
   U_MDTR490R3()
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
±±³Fun‡…o    ³ MDT490FLVL³ Autor ³ Denis Hyroshi        ³ Data ³ 04/08/08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Valida os campos De/Ate Filial                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT490FLVL(nTipo)
Local lRet := .T.
Local cArea := Alias()
Local aArea := SM0->(GetArea())

If nTipo == 1
	If !Empty(Mv_par09)
		dbSelectArea("SM0")
		If !dbSeek(cEmpAnt+Mv_par09)
			Help(" ",1,"REGNOIS")
			lRet := .F.
		Endif
		If Mv_par09 > Mv_par10
			Mv_par10 := Mv_par09
		Endif
	Endif
Else
	If Mv_par10 <> Replicate("Z",Len(Mv_par10)) .and. Mv_par10 <> Replicate("9",Len(Mv_par10))
		If Mv_par09 > Mv_par10
			Help(" ",1,"DEATEINVAL")
			lRet := .F.
		Else
			dbSelectArea("SM0")
			If !dbSeek(cEmpAnt+Mv_par10)
				Help(" ",1,"REGNOIS")
				lRet := .F.
			Endif
		Endif
	Endif
Endif

RestArea(aArea)
dbSelectArea(cArea)

Return lRet

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³Andre E. Perez Alvarez ³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define as secoes impressas no relatorio                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±|__________|____________________________________________________________|±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportDef()

Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
Local nTamCus := If(TAMSX3("TMD_VALEXA")[1] < 1, 12, TAMSX3("TMD_VALEXA")[1])
Local cPictCus:= X3Picture("TMD_VALEXA")

Static oReport

Static oSection0
Static oSection1
Static oSection2

Static oBreak1
Static oBreak2

Static oCell

//LAYOUT ------------- Nao Prestador de servico
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

                                                       Resultado dos Exames Ocupacionais
____________________________________________________________________________________________________________________________________

Código    Centro de Custo
__________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Quantidade   Custo
______________________________________________________________________

123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx

Total do Centro de Custo
______________________________________________________________________

												  123456789    xxxx,xx


Código    Centro de Custo
__________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Quantidade   Custo
______________________________________________________________________

123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx

Total do Centro de Custo
______________________________________________________________________

												  123456789    xxxx,xx


Total da Filial
______________________________________________________________________

												  123456789    xxxx,xx
*/


//LAYOUT ------------------ Prestador de servico
/*        1         2         3         4         5         6         7         8         9       100       110       120       130
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
____________________________________________________________________________________________________________________________________

                                                       Resultado dos Exames Ocupacionais
____________________________________________________________________________________________________________________________________

Cliente/Unidade: 000001 - 1047 - SMP & B Lavagem de Dinheiro

Código    Centro de Custo
__________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Quantidade   Custo
______________________________________________________________________

123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx

Total do Centro de Custo
______________________________________________________________________

												  123456789    xxxx,xx


Código    Centro de Custo
__________________________________________
xxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Exame   Nome do Exame                             Quantidade   Custo
______________________________________________________________________

123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx
123456  1234567890123456789012345678901234567890  123456789    xxxx,xx

Total do Centro de Custo
______________________________________________________________________

												  123456789    xxxx,xx


Total do Cliente
______________________________________________________________________

												  123456789    xxxx,xx
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
oReport := TReport():New("MDTR490",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint()},;  //"Custos do PCMSO"
           STR0001+STR0002+STR0003)  //"Relatório de Custos do PCMSO. "//"O programa demonstra o custo dos exames gerados pelo PCMSO "//"escolhido."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // PCMSO                                ³
//³ mv_par02             // De Dt. Progamacao                    ³
//³ mv_par03             // Ate Dt. Programacao                  ³
//³ mv_par04             // De Centro de Custo                   ³
//³ mv_par05             // Ate Centro de Custo                  ³
//³ mv_par06             // De Exame                             ³
//³ mv_par07             // Ate Exame                            ³
//| mv_par08             //Considerar (Todos,So Atendidos,       |
//|                                    So nao atendidos          |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)

If lNGMDTPS .OR. lSigaMdtps
	//Carrega informacoes do CC
	U_MDTA490CLI(2)
Endif

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
oReport:SetTotalInLine(.F.)

If !( lNGMDTPS .OR. lSigaMdtps )

	//********************* Secao 0 - Filial
	oSection0 := TRSection():New (oReport,Alltrim(NGRETTITULO("TMW_FILIAL")), {"TRBEX","SM0"} )
	oSection0:SetPageBreak() // sempre que houver quebra salta de pagina
	oCell := TRCell():New(oSection0, "TRBEX->FILIAL" , "TRBEX", Alltrim(NGRETTITULO("TMW_FILIAL")), "@!", nSizeFil )
	oCell := TRCell():New(oSection0, "SM0->M0_NOME"  , "SM0"  , STR0029, "@!", 40 ) //"Nome da Filial"
	TRPosition():New(oSection0, "SM0", 1, {|| cEmpAnt + TRBEX->FILIAL })

	//********************* Secao 1 - CC
	oSection1 := TRSection():New (oReport,STR0014, {"TRBEX",cAliasCC} ) //"Centro de Custo"
	oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção
 	oCell := TRCell():New(oSection1, "TRBEX->CCUSTO" , "TRBEX", STR0014, "@!", nSizeSI3 )  //"Centro de Custo"
 	oCell := TRCell():New(oSection1, cDescCC         , cAliasCC , STR0015, "@!", 25 ) //"Descrição"
	TRPosition():New(oSection1, cAliasCC, 1, {|| xFilial(cAliasCC,TRBEX->FILIAL) + TRBEX->CCUSTO})

	//********************* Secao 2 - Exames
	oSection2 := TRSection():New (oReport,STR0024, {"TRBEX","TM4","TM5"} )  //"Exames"
	oCell := TRCell():New (oSection2, "TRBEX->EXAME" , "TRBEX", STR0016, "@!"          , nTamExa , /*lPixel*/,/*{|| code-block de impressao }*/) //"Exame"
	oCell := TRCell():New (oSection2, "TM4_NOMEXA"   , "TM4"  , STR0017, "@!"          , 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Exame"
	oCell := TRCell():New (oSection2, "TRBEX->QUANTI", "TRBEX", STR0018, "999999"      , 6                		  , /*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
	oCell := TRCell():New (oSection2, "TRBEX->CUSTO" , "TRBEX", STR0019, cPictCus, nTamCus              	  , /*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo"
	TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4",TRBEX->FILIAL) + TRBEX->EXAME} )

	//-- Totaliza por Centro de Custo
	oBreak1 := TRBreak():New(oSection1,oSection1:Cell("TRBEX->CCUSTO"),STR0011,.F.)  //"Total do Centro de Custo:"
	TRFunction():New(oSection2:Cell("TRBEX->QUANTI"),/*cId*/,"SUM",oBreak1,/*cTitle*/,"999999",/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
	TRFunction():New(oSection2:Cell("TRBEX->CUSTO") ,/*cId*/,"SUM",oBreak1,/*cTitle*/,cPictCus,/*uFormula*/,.F./*lEndSection*/,.T./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)

	//-- Totaliza por Filial
	oBreak2 := TRBreak():New(oSection0,".T.",STR0010,.F.) //"Total da Filial"
	TRFunction():New(oSection2:Cell("TRBEX->QUANTI"),/*cId*/,"SUM",oBreak2,/*cTitle*/,"999999",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
	TRFunction():New(oSection2:Cell("TRBEX->CUSTO") ,/*cId*/,"SUM",oBreak2,/*cTitle*/,cPictCus,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)

Else  //-- Prestador de servico

	//********************* Secao 0 - Cliente
	oSection0 := TRSection():New (oReport,STR0023, {"TRBEX","SA1"} )  //"Cliente"
	oSection0:SetPageBreak() // sempre que houver quebra salta de pagina
	oCell := TRCell():New(oSection0, "TRBEX->CLIENT" , "TRBEX", STR0023, "@!", nSizeSA1 )  //"Cliente"
	oCell := TRCell():New(oSection0, "A1_NOME"       , "SA1"  , STR0022, "@!", 40 ) //"Nome do Cliente"
	TRPosition():New(oSection0, "SA1", 1, {|| xFilial("SA1") + TRBEX->CLIENT})

	//********************* Secao 1 - CC
	oSection1 := TRSection():New (oReport,STR0014, {"TRBEX",cAliasCC} )  //"Centro de Custo"
	oSection1:SetHeaderBreak() // sempre que houver quebra imprime o cabeçalho da seção
	oCell := TRCell():New(oSection1, "TRBEX->CCUSTO" , "TRBEX" , STR0014    , "@!", nSizeSI3 )  //"Centro de Custo"
	oCell := TRCell():New(oSection1, cDescCC         , cAliasCC, STR0015    , "@!", 25 ) //"Descrição"
	TRPosition():New(oSection1, cAliasCC, 1, {|| xFilial(cAliasCC) + TRBEX->CCUSTO})

	//********************* Secao 2 - Exames
	oSection2 := TRSection():New (oReport,STR0024, {"TRBEX","TM4","TM5"} )  //"Exames"
	oCell := TRCell():New (oSection2, "TRBEX->EXAME" , "TRBEX", STR0016, "@!"          , nTamExa , /*lPixel*/,/*{|| code-block de impressao }*/) //"Exame"
	oCell := TRCell():New (oSection2, "TM4_NOMEXA"   , "TM4"  , STR0017, "@!"          , 40, /*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Exame"
	oCell := TRCell():New (oSection2, "TRBEX->QUANTI", "TRBEX", STR0018, "999999"      , 6                		  , /*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
	oCell := TRCell():New (oSection2, "TRBEX->CUSTO" , "TRBEX", STR0019, "@E 99,999.99", nTamCus              	  , /*lPixel*/,/*{|| code-block de impressao }*/)  //"Custo"
	TRPosition():New (oSection2, "TM4", 1, {|| xFilial("TM4") + TRBEX->EXAME} )

	//-- Totaliza por Centro de Custo
	oBreak1 := TRBreak():New(oSection2,".T.",STR0011,.F.)  //"Total do Centro de Custo"
	TRFunction():New(oSection2:Cell("TRBEX->QUANTI"),/*cId*/,"SUM",oBreak1,/*cTitle*/,"999999",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
	TRFunction():New(oSection2:Cell("TRBEX->CUSTO") ,/*cId*/,"SUM",oBreak1,/*cTitle*/,cPictCus,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)

	//-- Totaliza por Cliente
	oBreak2 := TRBreak():New(oSection0,".T.",STR0013,.F.)  //"Total do Cliente"
	TRFunction():New(oSection2:Cell("TRBEX->QUANTI"),/*cId*/,"SUM",oBreak2,/*cTitle*/,"999999",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
	TRFunction():New(oSection2:Cell("TRBEX->CUSTO") ,/*cId*/,"SUM",oBreak2,/*cTitle*/,cPictCus,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/,/*oSection1*/)
Endif

oSection2:Cell("TRBEX->QUANTI"):SetHeaderAlign("RIGHT")
oSection2:Cell("TRBEX->CUSTO"):SetHeaderAlign("RIGHT")

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ReportPrint³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Imprime o relatorio.                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportDef                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function ReportPrint()
Private cArqTrab

If lTMW_Filial .and. !Empty(xFilial("TM5"))
	aAreaSM0 := SM0->(GetArea())
	dbSelectArea("SM0")
	dbGoTop()
	If Empty(Mv_par09)
		dbSeek(cEmpAnt)
	Else
		dbSeek(cEmpAnt+Mv_par09)
	Endif
	While !Eof() .and. SM0->M0_CODIGO == cEmpAnt .and. SM0->M0_CODFIL <= Mv_par10
		aAdd( aFilRelat , { SM0->M0_CODFIL , SM0->M0_NOME } )
		dbSkip()
	End
	RestArea(aAreaSM0)
Else
	aAdd( aFilRelat , { cFilAnt , SM0->M0_NOME } )
Endif

If !( lNGMDTPS .OR. lSigaMdtps )

	Processa( {|lEND| TRBgrava()}, STR0021 ,STR0020 ) //"Aguarde" ## "Processando os Exames..."

	DbSelectArea("TRBEX")
	DbGoTop()
	oReport:SetMeter(LastRec())
	While !oReport:Cancel() .AND. !Eof()
		oSection0:Init()
		If lTMW_Filial
			oSection0:PrintLine()
		Endif
		cFilOld := TRBEX->FILIAL
		While !oReport:Cancel() .AND. !Eof() .AND. cFilOld == TRBEX->FILIAL
			cCC := TRBEX->CCUSTO
			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()
			While !oReport:Cancel() .AND. !Eof() .AND. cFilOld == TRBEX->FILIAL .AND. cCC == TRBEX->CCUSTO
				oReport:IncMeter()
				oSection2:PrintLine()
				DbSkip()
			End
			oSection2:Finish()
			oSection1:Finish()
		End
		oSection0:Finish()
	End

Else //-- Prestador de servico

	Processa( {|lEND| TRBgrava()}, STR0021 ,STR0020 ) //"Aguarde" ## "Processando os Exames..."

	DbSelectArea("TRBEX")
	DbGoTop()
	oReport:SetMeter(LastRec())
	While !oReport:Cancel()	  		.AND.;
	      !Eof()

		oSection0:Init()
		oSection0:PrintLine()
		cClient := TRBEX->CLIENT

		While !oReport:Cancel()	  		.AND.;
	      	  !Eof()                  	.AND.;
	      	  cClient == TRBEX->CLIENT

			cCC := TRBEX->CCUSTO
			oSection1:Init()
			oSection1:PrintLine()
			oSection2:Init()

			While !oReport:Cancel()	  		.AND.;
			      !Eof()              		.AND.;
			      cClient == TRBEX->CLIENT	.AND.;
			      cCC == TRBEX->CCUSTO

				oReport:IncMeter()
				oSection2:PrintLine()
				DbSkip()
			End
	  		oSection2:Finish()
	  		oSection1:Finish()
	  	End
	  	oSection0:Finish()

	End

Endif

dbSelectArea("TRBEX")
If TRBEX->(RecCount()) == 0
	MsgInfo(STR0030) //"Não há nada para imprimir no relatório."
	oTempTable:Delete()
	Return .F.
Endif

oTempTable:Delete()
Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TRBgrava   ³ Autor ³ Andre E. Perez Alvarez³ Data ³ 31/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Processa os exames de acordo com os parametros e grava      ³±±
±±³          ³ no arquivo temporario.                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportPrint                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function TRBgrava()
Local nXYZ
Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])
Local nTamCus := If(TAMSX3("TMD_VALEXA")[1] < 1, 12, TAMSX3("TMD_VALEXA")[1])

Private nVALOR
Private aDBF := {}

If lNGMDTPS .OR. lSigaMdtps
	AADD(aDBF,{"CLIENT","C",nSizeSA1,0})
Endif
AADD(aDBF,{"FILIAL","C",nSizeFil ,0})
AADD(aDBF,{"CCUSTO","C",nSizeSI3 ,0})
AADD(aDBF,{"EXAME" ,"C",nTamExa  ,0})
AADD(aDBF,{"QUANTI","N",06,0})
AADD(aDBF,{"CUSTO" ,"N",nTamCus,2})

oTempTable := FWTemporaryTable():New( "TRBEX", aDBF )
If lNGMDTPS .OR. lSigaMdtps
	oTempTable:AddIndex( "1", {"CLIENT","CCUSTO","EXAME"} )
Else
	oTempTable:AddIndex( "1", {"FILIAL","CCUSTO","EXAME"} )
EndIf
oTempTable:Create()

dbSelectArea("TM5")
ProcRegua(LastRec())

aDados := {}
For nXYZ := 1 To Len(aFilRelat)

	dbSelectArea("TM5")
	dbSetOrder(03)
	dbSeek(xFilial("TM5",aFilRelat[nXYZ,1]) + MV_PAR01,.T.)
	While !Eof() .AND. !oReport:Cancel() .AND. TM5->TM5_FILIAL  == xFilial('TM5',aFilRelat[nXYZ,1]) .and. TM5->TM5_PCMSO == MV_PAR01

		IncProc()

		If !Empty(TM5->TM5_FILFUN)
			If lTMW_Filial
				If TM5->TM5_FILFUN < Mv_par09 .or. TM5->TM5_FILFUN > Mv_par10
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Else
				If TM5->TM5_FILFUN <> aFilRelat[nXYZ,1]
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif
		Endif

		If MV_PAR08 == 2  //So atendidos
			If Empty(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSKIP()
				loop
			EndIf
		ElseIf MV_PAR08 == 3   //So nao atendidos
			If !Empty(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSKIP()
				loop
			EndIf
		EndIf

		If !(   ( TM5->TM5_DTPROG  >= MV_PAR02 )  .AND.;
		        ( TM5->TM5_DTPROG  <= MV_PAR03 )  .AND.;
		        ( TM5->TM5_CC      >= MV_PAR04 )  .AND.;
		        ( TM5->TM5_CC      <= MV_PAR05 )  .AND.;
		        ( TM5->TM5_EXAME   >= MV_PAR06 )  .AND.;
		        ( TM5->TM5_EXAME   <= MV_PAR07 )           )
			DbSelectArea("TM5")
			DbSkip()
			Loop
		Endif

		U_AcValor( TM5->TM5_FILFUN ) //busca preco do exame do fornecedor (nVALOR)

		If !( lNGMDTPS .OR. lSigaMdtps )

			DbSelectArea("TRBEX")
			If !DbSeek(TM5->TM5_FILFUN + TM5->TM5_CC + TM5->TM5_EXAME)
				TRBEX->(DbAppend())
				TRBEX->FILIAL := TM5->TM5_FILFUN
				TRBEX->CCUSTO := TM5->TM5_CC
				TRBEX->EXAME  := TM5->TM5_EXAME
				TRBEX->QUANTI := 1
				TRBEX->CUSTO  := nVALOR
			Else
				RecLock("TRBEX",.F.)
				TRBEX->QUANTI ++
				TRBEX->CUSTO += nVALOR
			Endif

		Else	//Prestador de servico

			cCliente := SubStr(TM5->TM5_CC,1,nSizeSA1)
			DbSelectArea("TRBEX")
			If !DbSeek(cCliente + TM5->TM5_CC + TM5->TM5_EXAME)
				TRBEX->(DbAppend())
				TRBEX->CLIENT := cCliente
				TRBEX->CCUSTO := TM5->TM5_CC
				TRBEX->EXAME  := TM5->TM5_EXAME
				TRBEX->QUANTI := 1
				TRBEX->CUSTO  := nVALOR
			Else
				RecLock("TRBEX",.F.)
				TRBEX->QUANTI ++
				TRBEX->CUSTO += nVALOR
			Endif

		Endif

		dbSelectArea("TM5")
		dbskip()
	End
Next nXYZ

Return .T.

/***************************************************************************/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR490R3 ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio demonstrativo dos custos com o PCMSO (Realese 3)  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function MDTR490R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR490"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatório de Custos do PCMSO. "
LOCAL cDesc2  := STR0002 + STR0003 //"O programa demonstra o custo dos exames gerados pelo PCMSO "//"escolhido."
LOCAL cDesc3  := ""
LOCAL cString := "TM5"

PRIVATE nomeprog := "MDTR490"
PRIVATE tamanho  := "M"
PRIVATE aReturn  := { STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Custos do PCMSO"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

If lNGMDTPS .OR. lSigaMdtps
	//Carrega informacoes do CC
	U_MDTA490CLI(2)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // PCMSO                                ³
//³ mv_par02             // De Dt. Progamacao                    ³
//³ mv_par03             // Ate Dt. Programacao                  ³
//³ mv_par04             // De Centro de Custo                   ³
//³ mv_par05             // Ate Centro de Custo                  ³
//³ mv_par06             // De Exame                             ³
//³ mv_par07             // Ate Exame                            ³
//| mv_par08             //Considerar (Todos,So Atendidos,       |
//|                                    So nao atendidos          |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="MDTR490"
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

If lNGMDTPS .OR. lSigaMdtps
	//Carrega informacoes do CC
	U_MDTA490CLI(3)
Endif

If lTMW_Filial .and. !Empty(xFilial("TM5"))
	aAreaSM0 := SM0->(GetArea())
	dbSelectArea("SM0")
	dbGoTop()
	If Empty(Mv_par09)
		dbSeek(cEmpAnt)
	Else
		dbSeek(cEmpAnt+Mv_par09)
	Endif
	While !Eof() .and. SM0->M0_CODIGO == cEmpAnt .and. SM0->M0_CODFIL <= Mv_par10
		aAdd( aFilRelat , { SM0->M0_CODFIL , SM0->M0_NOME } )
		dbSkip()
	End
	RestArea(aAreaSM0)
Else
	aAdd( aFilRelat , { cFilAnt , SM0->M0_NOME } )
Endif

RptStatus({|lEnd| U_R490Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R490Imp  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
User Function R490Imp(lEnd,wnRel,titulo,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cRodaTxt := ""
Local cPictCus := X3Picture("TMD_VALEXA")
LOCAL nCntImpr := 0
LOCAL lPrint := .F.
Local nXYZ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis para controle do cursor de progressao do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL lContinua        := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis tipo Private padrao de todos os relatorios         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contadores de linha e pagina                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE li := 80 ,m_pag := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis locais exclusivas deste programa                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCC     //variavel Centro de Custo
PRIVATE cEXA    //variavel Exame
PRIVATE nQTDEXA := 0   //quantidade A NIVEL DE EXAMES
PRIVATE nQTDCC  := 0   //quantidade a nivel de C.C.
PRIVATE nQTDFIL := 0   //quantidade a nivel de Filial
PRIVATE nVALOR  := 0   //Valor do exame
PRIVATE nVALEXA := 0   //valor a nivel de exame
PRIVATE nVALCC  := 0   //valor a nivel de CC
PRIVATE nVALFIL := 0   //valor a nivel de FILIAL
PRIVATE nTotCC  := 0   //valor a nivel de CC
PRIVATE nTotFil := 0   //valor a nivel de FILIAL
PRIVATE cCliente:= ""
PRIVATE cNome   := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se deve comprimir ou nao                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTipo  := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cabec1 := STR0007 //"Codigo         Centro de Custo "
cabec2 := STR0008 //"Exame       Nome do Exame                      Quantidade                 Custo"

//********************* NÃO-PRESTADOR DE SERVIÇO

/*        1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
______________________________________________________________________________________________________________________________________
Codigo         Centro de Custo
Exame     Nome do Exame                      Quantidade                 Custo
______________________________________________________________________________________________________________________________________
xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx

total da Filial
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
                                                xxx.xxx          xx.xxx.xxx,xx
*/

//********************* PRESTADOR DE SERVIÇO

/*           1         2         3         4         5         6         7         8         9         0         1         2         3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
______________________________________________________________________________________________________________________________________
Codigo         Centro de Custo
Exame     Nome do Exame                      Quantidade                 Custo
______________________________________________________________________________________________________________________________________
Cliente/Unidade:  0000001 - 1047 - SMP & B Empresa de Laranjas

xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
Total do Centro de Custo:

xxxxxxxxx - xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
xxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx       xxx.xxx          xx.xxx.xxx,xx
Total do Centro de Custo:

Total do Cliente:
*/

dbSelectArea("TM5")
SetRegua(LastRec())

aDados := {}
For nXYZ := 1 To Len(aFilRelat)

	dbSelectArea("TM5")
	dbSetOrder(03)
	dbSeek(xFilial("TM5",aFilRelat[nXYZ,1]) + MV_PAR01,.T.)
	While !Eof() .AND. lContinua .And. TM5->TM5_FILIAL  == xFilial('TM5',aFilRelat[nXYZ,1]) .and. TM5->TM5_PCMSO  == MV_PAR01

		If lEnd
			@ PROW()+1,001 PSay STR0009 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf

		IncRegua()

		If !Empty(TM5->TM5_FILFUN)
			If lTMW_Filial
				If TM5->TM5_FILFUN < Mv_par09 .or. TM5->TM5_FILFUN > Mv_par10
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Else
				If TM5->TM5_FILFUN <> aFilRelat[nXYZ,1]
					dbSelectArea("TM5")
					dbskip()
					Loop
				Endif
			Endif
		Endif

		If MV_PAR08 = 2
			If Empty(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSKIP()
				loop
			EndIf
		ElseIf MV_PAR08 = 3
			If !Empty(TM5->TM5_DTRESU)
				dbSelectArea("TM5")
				dbSKIP()
				loop
			EndIf
		EndIf

		IF	TM5->TM5_DTPROG  >= MV_PAR02	  .AND.;
			TM5->TM5_DTPROG  <= MV_PAR03	  .AND.;
			TM5->TM5_CC      >= MV_PAR04	  .AND.;
			TM5->TM5_CC      <= MV_PAR05	  .AND.;
			TM5->TM5_EXAME   >= MV_PAR06	  .AND.;
			TM5->TM5_EXAME   <= MV_PAR07

			U_AcValor( TM5->TM5_FILFUN )   //funcao para buscar valor do exame

			nPosCC := aScan( aDados ,{|x| x[1]+x[2]+x[3] == TM5->TM5_FILFUN + TM5->TM5_CC + TM5->TM5_EXAME })
			If nPosCC == 0
				aAdd( aDados , { TM5->TM5_FILFUN , TM5->TM5_CC , TM5->TM5_EXAME , 1 , nVALOR , aFilRelat[nXYZ,2] } )
			Else
				aDados[nPosCC,4] ++
				aDados[nPosCC,5] += nVALOR
			Endif

		EndIf

		dbSelectArea("TM5")
		dbskip()
	Enddo
Next nXYZ

If lTMW_Filial
	aSort(aDados,,,{|x,y| x[1]+x[2]+x[3] < y[1]+y[2]+y[3] })
Else
	aSort(aDados,,,{|x,y| x[2]+x[3] < y[2]+y[3] })
Endif

aTotCC  := {0,0}
aTotFil := {0,0}
aTotRel := {0,0}
cOldCC  := "-"
cOldFil := "-"
nQtdFil := 0

For nXYZ := 1 To Len(aDados)

	lImpCabCC := .f.
	//Imprime cabeçalho FILIAL (PRESTADOR SERVICO)
	If lNGMDTPS .OR. lSigaMdtps
		If cOldFil <> SubStr(aDados[nXYZ,2],1,nSizeSA1)
			cOldFil := SubStr(aDados[nXYZ,2],1,nSizeSA1)
			Li := 80
			SomaLinha()
			dbSelectArea("SA1")
			dbSetOrder(01)
			dbSeek(xFilial("SA1")+cOldFil)
			@ Li,000 Psay STR0012+cOldFil   //"Cliente :"
			@ Li,12 + ( nSizeSA1 ) Psay SA1->A1_NOME Picture "@!"
			SomaLinha()
			lImpCabCC := .t.
		EndIf

	//Imprime cabeçalho FILIAL
	Else
		If cOldFil <> aDados[nXYZ,1]
			cOldFil := aDados[nXYZ,1]
			If lTMW_Filial
				Li := 80
				SomaLinha()
				aAreaSM0 := SM0->(GetArea())
				dbSelectArea("SM0")
				dbGoTop()
				dbSeek(cEmpAnt+cOldFil)
				aDados[nXYZ,6] := SM0->M0_NOME
				RestArea(aAreaSM0)
				@ Li,000 PSay Alltrim(NGRETTITULO("TMW_FILIAL")) + ": " + cOldFil + " - " + Alltrim(aDados[nXYZ,6])
				SomaLinha()
				lImpCabCC := .t.
				nQtdFil++
			Endif
		Endif
	Endif

	//Imprime cabeçalho C.CUSTO
	If cOldCC <> aDados[nXYZ,2] .or. lImpCabCC
		cOldCC := aDados[nXYZ,2]
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC, If(lTMW_Filial,cOldFil,cFilAnt) )+cOldCC)
		SomaLinha()
		@ Li,000 PSay cOldCC
		@ Li,023 PSay &(cDescCC2)
		SomaLinha()
	Endif

	dbSelectArea("TM4")
	dbSetOrder(01)
	dbSeek( xFilial("TM4", If(lTMW_Filial,cOldFil,cFilAnt) ) + aDados[nXYZ,3] )
	@ Li,000 PSay aDados[nXYZ,3]
	@ Li,012 PSay SUBSTR(TM4->TM4_NOMEXA,1,30)
	@ Li,052 Psay aDados[nXYZ,4] picture "99999"
	@ Li,065 Psay aDados[nXYZ,5] picture cPictCus
	aTotCC[1] += aDados[nXYZ,4]
	aTotCC[2] += aDados[nXYZ,5]
	Somalinha()

	lTotCC  := If( nXYZ == Len(aDados) , .T. , .F. )
	lTotFil := If( nXYZ == Len(aDados) , .T. , .F. )
	If !lTotCC
		If lNGMDTPS .OR. lSigaMdtps
			If SubStr(aDados[nXYZ,2],1,nSizeSA1) <> SubStr(aDados[nXYZ+1,2],1,nSizeSA1)
				lTotCC  := .T.
				lTotFil := .T.
			ElseIf aDados[nXYZ,2] <> aDados[nXYZ+1,2]
				lTotCC := .T.
			Endif
		Else
			If lTMW_Filial
				If aDados[nXYZ,1] <> aDados[nXYZ+1,1]
					lTotCC  := .T.
					lTotFil := .T.
				Endif
			Endif
			If aDados[nXYZ,2] <> aDados[nXYZ+1,2]
				lTotCC := .T.
			Endif
		Endif
	Endif

	If lTotCC //Imprime total do C.CUSTO
		Somalinha()
		@ Li,000 PSay STR0011 //"Total da Centro de Custo"
		@ Li,052 Psay aTotCC[1] picture "99999"
		@ Li,065 Psay aTotCC[2] picture cPictCus
		aTotFil[1] += aTotCC[1]
		aTotFil[2] += aTotCC[2]
		Somalinha()
		aTotCC := {0,0}
	Endif

	If lTotFil //Imprime total da FILIAL ou CLIENTE
		Somalinha()
		If lNGMDTPS .OR. lSigaMdtps
			@ Li,000 PSay STR0013 //"Total do Cliente"
		Else
			@ Li,000 PSay STR0010 //"Total da Filial"
			@ Li,018 PSay cOldFil
		EndIf
		@ Li,052 PSay aTotFil[1] picture "99999"
		@ Li,065 PSay aTotFil[2] picture cPictCus
		aTotRel[1] += aTotFil[1]
		aTotRel[2] += aTotFil[2]
		aTotFil := {0,0}
	Endif

Next nXYZ

If Len(aDados) > 0 .and. nQtdFil > 1
	Somalinha()
	Somalinha()
	@ Li,000 PSay STR0031 //"Total Geral"
	@ Li,052 PSay aTotRel[1] picture "99999"
	@ Li,065 PSay aTotRel[2] picture cPictCus
Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TM5")

Set Filter To

Set device to Screen

If Len(aDados) == 0
	MsgInfo(STR0030) //"Não há nada para imprimir no relatório."
	Return .F.
Endif

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
±±³ Fun‡…o   ³ AcValor  ³ Autor ³                       ³ Data ³   /03/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Acumula Valores                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ AcValor                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Busca valor da tabela de fornecedores de exame.            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
User Function AcValor(_FilTmp)
LOCAL nAC := 0   //salva ultimo valor da tabela de precos
LOCAL dDtTmp := If( Empty(TM5->TM5_DTRESU) , TM5->TM5_DTPROG , TM5->TM5_DTRESU )
Local cFilTemp := If( ValType(_FilTmp) == "C" .and. !Empty(_FilTmp) , _FilTmp , cFilAnt )

dbSelectArea("TMD")
dbSetOrder(01)
dbSeek(xFilial("TMD",cFilTemp)+TM5->TM5_FORNEC+TM5->TM5_LOJA+TM5->TM5_EXAME)
while !EOF()                                  .AND.;
      TMD->TMD_FILIAL == XFILIAL("TMD",cFilTemp) .AND.;
      TMD->TMD_FORNEC == TM5->TM5_FORNEC     .AND.;
      TMD->TMD_LOJA   == TM5->TM5_LOJA       .AND.;
      TMD->TMD_EXAME  == TM5->TM5_EXAME

      If dDtTmp >= TMD->TMD_DTINIC
          nAC := TMD->TMD_VALEXA
      Endif

      DbSelectArea("TMD")
      dbskip()
enddo

nVALOR := nAC

Return .T.
/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ SomaLinha³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Incrementa Linha e Controla Salto de Pagina                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ SomaLinha()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±/*/
Static Function Somalinha()

Li++
If Li > 58
   Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDTA475CLI³ Autor ³Denis Hyroshi de Souza ³ Data ³24/05/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Valida cliente nos parametros                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR475                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTA490CLI(nTipo)

Local aArea := GetArea()

//Valida tela parametros
If nTipo == 1 .or. nTipo == 2
	dbSelectArea("TMW")
	dbSetOrder(1)
	If !dbSeek( xFilial("TMW") + Mv_par01 )
		If nTipo == 1
			Help(" ",1,"REGNOIS")
		Endif
		Return .f.
	Endif
	Mv_par02 := TMW->TMW_DTINIC
	Mv_par03 := TMW->TMW_DTFIM
	Mv_par04 := TMW->TMW_CCDE
	Mv_par05 := TMW->TMW_CCATE
Else
	dbSelectArea("TMW")
	dbSetOrder(1)
	If !dbSeek( xFilial("TMW") + Mv_par01 )
		MsgStop(STR0025,STR0026)  //"O PCMSO informado não está cadastrado." //"Atenção"
		Return .f.
	Endif

	If !lSigaMdtps
		If  SubStr(Mv_par04,1,nSizeSa1) <> SubStr(TMW->TMW_CCDE,1,nSizeSa1) .or. ;
			SubStr(Mv_par05,1,nSizeSa1) <> SubStr(TMW->TMW_CCATE,1,nSizeSa1)

			Mv_par04 := TMW->TMW_CCDE
			Mv_par05 := TMW->TMW_CCATE
		Endif
	Else
		If  SubStr(Mv_par04,1,nSizeSa1+nSizeLo1) <> SubStr(TMW->TMW_CCDE,1,nSizeSa1+nSizeLo1) .or. ;
			SubStr(Mv_par05,1,nSizeSa1+nSizeLo1) <> SubStr(TMW->TMW_CCATE,1,nSizeSa1+nSizeLo1)

			Mv_par04 := TMW->TMW_CCDE
			Mv_par05 := TMW->TMW_CCATE
		Endif
	Endif
Endif

RestArea(aArea)

Return .t.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MDT490CC³   Autor ³Andre E. Perez Alvarez ³ Data ³07/11/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Valida centro de custo de acordo com o PCMSO escolhido.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR490                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDT490CC(nOpc)

If nOpc == 1  //Valida "De CC"
	If empty(mv_par04)
		Return .t.
	Else
		If ExistCpo(cAliasCC,mv_par04)
			If mv_par04 >= TMW->TMW_CCDE .AND. mv_par04 <= TMW->TMW_CCATE
				Return .T.
			Else
				MsgStop(;
					STR0027 + CHR(13)+CHR(10) +; //"Esse centro de custo não pertence ao intervalo"
				   	STR0028 + CHR(13)+CHR(10) ;  //"de centros de custo do PCMSO selecionado."
				)
				Return .F.
			Endif
		Else
			Return .F.
		Endif
	Endif
Else  //Valida "Até CC"
	If NaoVazio(mv_par05)
		If mv_par05 == Replicate("Z",nSizeSI3)
			Return .T.
		Else
			If ExistCpo(cAliasCC,mv_par05)
				If mv_par05 >= TMW->TMW_CCDE .AND. mv_par05 <= TMW->TMW_CCATE
					Return If(atecodigo(cAliasCC,mv_par04,mv_par05,nSizeSI3),.t.,.f.)
				Else
					MsgStop(;
						STR0027 + CHR(13)+CHR(10) +; //"Esse centro de custo não pertence ao intervalo"
					   	STR0028 + CHR(13)+CHR(10) ;  //"de centros de custo do PCMSO selecionado."
					)
					Return .F.
				Endif
			Else
				Return .F.
			Endif
		Endif
	Else
		Return .F.
	Endif
Endif