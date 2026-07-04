/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MDTR486.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MDTR486  ³ Autor ³ Marcio Costa          ³ Data ³ 12.01.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do Resultado dos Exames realizados por motivo de  ³±±
±±³          ³exposicao ao Agentes Quimicos.                              ³±±
±±³          ³Atraves dos parametros o usuario podera selecionar um exame ³±±
±±³          ³especifico o todos, um C.Custo ou todos e ainda um periodo  ³±±
±±³          ³determinado. Com base nos parametro o programa ira ler a    ³±±
±±³          ³tabela de Exames do Funcionario (TM5) e para cada exame que ³±±
±±³          ³atender as condicoes definidas nos parametros deve obter    ³±±
±±³          ³as informacoes da tabela de resultado dos exames por agentes³±±
±±³          ³TN4, e o Indice Biologico Maximo Permetido na Tabela  Exames³±±
±±³          ³por Agente TMB.  Permitira o usuario selecionar exames      ³±±
±±³          ³cujo o resultado esteja acima do IBMP ou todos os exames.   ³±±
±±³          ³                                                            ³±±
±±³          ³O Relatorio saira classificado por c.custo e por matricula, ³±±
±±³          ³para cada exame acima do IBMP aparecera uma mensagem indi-  ³±±
±±³          ³cando que a quantidade encontrada esta acima do IBMP.       ³±±
±±³          ³O programa so lista exames cujo tipo de resultado seja igual³±±
±±³          ³a Exames por Agente Quimico, este indicador o programa obtem³±±
±±³          ³na tabela de Exames (TM4).                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MDTR486void)                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR486()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

Local oReport
Local aArea := GetArea()
LOCAL cF3CC := "SI3001"  //SI3 apenas do cliente
Local nTamGrupExa := 0

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

Private cPerg := If(!lSigaMdtPS,"MDT486    ","MDT486PS  ")
Private aVetinr := {}, cArqTrab
Private oTempTable

cAliasCC := "SI3"
cCodCC   := "SI3->I3_CUSTO"
cCodCC2  := "I3_CUSTO"
nSizeSI3 := If((TAMSX3("I3_CUSTO")[1]) < 1,9,(TAMSX3("I3_CUSTO")[1]))
cF3CC    := "SI3001"  //SI3 apenas do cliente
cDescCC  := "I3_DESC"
cDescCC2 := "SI3->I3_DESC"

If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
	cAliasCC := "CTT"
	cCodCC   := "CTT->CTT_CUSTO"
	cCodCC2  := "CTT_CUSTO"
	nSizeSI3 := If((TAMSX3("CTT_CUSTO")[1]) < 1,9,(TAMSX3("CTT_CUSTO")[1]))
	cF3CC := "CTT001"  //CTT apenas do cliente
	cDescCC := "CTT_DESC01"
	cDescCC2 := "CTT->CTT_DESC01"
	cF3CC := "CTT001"  //CTT apenas do cliente
Endif

/*-----------------------------
//PERGUNTAS PADRÃO			  |
| 01  De  Centro de Custo ?   |
| 02  Ate Centro de Custo ?   |
| 03  De  Agente ?            |
| 04  Ate Agente ?            |
| 05  De  Exame ?             |
| 06  Ate Exame ?             |
| 07  De  Data Resultado ?    |
| 08  Ate Data Resultado ?    |
|								  |
//PERGUNTAS PRESTADOR		  |
| 01 De Cliente ?             |
| 02 Loja                     |
| 03 Até Clietne ?            |
| 04 Loja                     |
| 05  De  Centro de Custo ?   |
| 06  Ate Centro de Custo ?   |
| 07  De  Agente ?            |
| 08  Ate Agente ?            |
| 09  De  Exame ?             |
| 10  Ate Exame ?             |
| 11  De  Data Resultado ?    |
| 12  Ate Data Resultado ?    |
-------------------------------*/

If !MDTRESTRI(cPrograma)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Devolve variaveis armazenadas (NGRIGHTCLICK) 			 			  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	NGRETURNPRM(aNGBEGINPRM)
	Return .F.
Endif

If TRepInUse()
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:lDisableOrientation := .T.//trava o modo de impressão como paisagem
	oReport:SetLandscape()
	oReport:PrintDialog()
Else
	U_MDTR486R3()
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
±±³Fun‡„o    ³ MDTR486R3  ³ Autor ³                     ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio nao-personalizavel                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR486R3                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR486R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL wnrel   := "MDTR486"
LOCAL limite  := 132
LOCAL cDesc1  := STR0001 //"Relatorio de Resultado dos exames por Exposicao a Agentes Quimicos"
LOCAL cDesc2  := STR0002 //"Demonstra exames realizados em um determinado periodo, permitindo "
LOCAL cDesc3  := STR0003 //"selecionar Agentes, Exames e Centro de Custo.                     "
LOCAL cString := "TN4"


PRIVATE nomeprog := "MDTR486"
PRIVATE tamanho  := "G"
PRIVATE aReturn  := {STR0004, 1,STR0005, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Resultado dos Exames por Exposicao a Agentes Quimicos"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De Centro de Custo                   ³
//³ mv_par02             // Ate Centro de Custo                  ³
//³ mv_par03             // De Agente                            ³
//³ mv_par04             // Ate Agente                           ³
//³ mv_par05             // De Exame                             ³
//³ mv_par06             // Ate Exame                            ³
//³ mv_par07             // De Dt.Realizacao                     ³
//³ mv_par08             // Ate Dt.Realizacao                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

RptStatus({|lEnd| R486Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R486Imp  ³ Autor ³ Inacio Luiz Kolling   ³ Data ³   /06/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MDTR486                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R486Imp(lEnd,wnRel,titulo,tamanho)

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

cabec1 := STR0007 //"Codigo        Nome do Centro de Custo"
cabec2 := STR0008 //"Matric  Funcionario                 Realizado  Agente  Nome do Agente        Exame       Nome do Exame        Quantidade       IBMP  U.M.     Res."

/*
************************************************************************************************************************************
*<empresa>                                                                                                        Folha..: xxxxx   *
*SIGA /<nome .04                                 <Resultado dos Exames por Exposicao a Agentes Quimicos>          DT.Ref.: dd/mm/aa*
*Hora...: xx:xx:xx                                                                                                Emissao: dd/mm/aa*
************************************************************************************************************************************
               1         2         3         4         5         6         7         8         9         0         1         2     3
0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Codigo        Nome do Centro de Custo
Matric Funcionario                Realizado  Agente Nome do Agente       Exame  Nome do Exame        Quantidade     IBMP U.M. Res.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxx xx/xx/xx  xxxxxx xxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxx xx.xxx,xx xx.xxx,xx xxxx xxxxx
                                                                         xxxxxx xxxxxxxxxxxxxxxxxxxx xx.xxx,xx xx.xxx,xx xxxx xxxxx
                                                                         xxxxxx xxxxxxxxxxxxxxxxxxxx xx.xxx,xx xx.xxx,xx xxxx xxxxx
                                   xx/xx/xx  xxxxxx xxxxxxxxxxxxxxxxxxxx xxxxxx xxxxxxxxxxxxxxxxxxxx xx.xxx,xx xx.xxx,xx xxxx xxxxx
                                                                         xxxxxx xxxxxxxxxxxxxxxxxxxx xx.xxx,xx xx.xxx,xx xxxx xxxxx
*/

Processa({|lEND| U_MDTR486TM5()},STR0010) //"Processando Arquivo..."

If lSigaMdtps

	dbSelectArea("TRB")
	dbGOTOP()

	ProcRegua(RecCount())

	While !Eof()

		cCliente := TRB->CLIENT+TRB->LOJA
		SomaLinha()
		@Li,000 PSay STR0036 + TRB->CLIENT + "-" + TRB->LOJA + " - " +  TRB->NOMECLI   //"Cliente/Loja: "
		SomaLinha()

		While !Eof() .and. cCliente == TRB->CLIENT+TRB->LOJA

			ccCUSTO := TRB->CCUSTO

			SomaLinha()

			@Li,000 PSay ccCUSTO
			dbSelectArea(cAliasCC)
			dbSetOrder(01)
			dbSeek(xFilial(cAliasCC)+ccCUSTO)
			@Li,022 PSay &(cDescCC)
			Somalinha()
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO

				IncProc()

				cMAT := TRB->MATRIC

				Somalinha()
				@Li,000 PSay cMAT PICTURE "@!"
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+cMAT)
				@Li,010 PSay Substr(SRA->RA_NOME,1,27)

				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC

					dDATAREAL := TRB->DTREAL

					@Li,038 PSay dDATAREAL PICTURE '99/99/99'

					dbSelectArea("TRB")
					While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
						  .AND. dDATAREAL == TRB->DTREAL

						cAGENTE := TRB->AGENTE

						@Li,049 PSay cAGENTE PICTURE '@!'

						dbSelectArea("TMA")
						dbSetOrder(01)
						dbSeek(xFilial("TMA")+TRB->AGENTE)
						@Li,057 PSay Substr(TMA->TMA_NOMAGE,1,20)

						lPRIN := .t.
						dbSelectArea("TRB")
						While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
							  .AND. dDATAREAL == TRB->DTREAL .AND. cAGENTE == TRB->AGENTE

							If !lPRIN
								Somalinha()
							Endif

							@Li,079 PSay TRB->EXAME PICTURE '@!'

							dbSelectArea("TM4")
							dbSetOrder(01)
							dbSeek(xFilial("TM4")+TRB->EXAME)
							@Li,091 PSay Substr(TM4->TM4_NOMEXA,1,20)

							@Li,113 PSay TRB->QUANTID PICTURE '@E 99,999.99'

							dbSelectArea("TMB")
							dbSetOrder(01)
							dbSeek(xFilial("TMB")+cAGENTE+TRB->EXAME)

							@Li,124 PSay TMB->TMB_QTIBMP PICTURE '@E 99,999.99'

							@Li,135 PSay substr(TMB->TMB_UNIDAD,1,5)

							If TRB->QUANTID > TMB->TMB_QTIBMP
								@Li,142 PSay "> "+STR0050 //"IBMP"
							Endif

							lPRIN := .f.

							dbSelectArea("TRB")
							dbSKIP()

						Enddo

						Somalinha()
					Enddo

				Enddo  //fim MAT

			End  //fim CC

		End  //fim cliente

		@Li,000 PSay Replicate("-",132)

	End

Else

	dbSelectArea("TRB")
	dbGOTOP()

	ProcRegua(RecCount())
	dbSelectArea("TM5")
	dbGOTOP()

	While !Eof()

		IncProc()

		ccCUSTO := TRB->CCUSTO

		SomaLinha()

		@Li,000 PSay ccCUSTO
		dbSelectArea(cAliasCC)
		dbSetOrder(01)
		dbSeek(xFilial(cAliasCC)+ccCUSTO)
		@Li,022 PSay &(cDescCC2)
		Somalinha()
		dbSelectArea("TRB")
		While !Eof() .AND. ccCUSTO == TRB->CCUSTO

			cMAT := TRB->MATRIC

			Somalinha()
			@Li,000 PSay cMAT PICTURE "@!"
			If !Empty(cMAT)
				dbSelectArea("SRA")
				dbSetOrder(01)
				dbSeek(xFilial("SRA")+cMAT)
				@Li,010 PSay Substr(SRA->RA_NOME,1,27)
			Else
				@Li,010 PSay Substr(TRB->NOMEFIC,1,27)
			EndIf
			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC

				dDATAREAL := TRB->DTREAL

				@Li,038 PSay dDATAREAL PICTURE '99/99/99'

				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
					  .AND. dDATAREAL == TRB->DTREAL

					cAGENTE := TRB->AGENTE

					@Li,049 PSay cAGENTE PICTURE '@!'

					dbSelectArea("TMA")
					dbSetOrder(01)
					dbSeek(xFilial("TMA")+TRB->AGENTE)
					@Li,057 PSay Substr(TMA->TMA_NOMAGE,1,20)

					lPRIN := .t.
					dbSelectArea("TRB")
					While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
						  .AND. dDATAREAL == TRB->DTREAL .AND. cAGENTE == TRB->AGENTE

						If !lPRIN
							Somalinha()
						Endif

						@Li,079 PSay TRB->EXAME PICTURE '@!'

						dbSelectArea("TM4")
						dbSetOrder(01)
						dbSeek(xFilial("TM4")+TRB->EXAME)
						@Li,091 PSay Substr(TM4->TM4_NOMEXA,1,20)

						@Li,113 PSay TRB->QUANTID PICTURE '@E 99,999.99'

						dbSelectArea("TMB")
						dbSetOrder(01)
						dbSeek(xFilial("TMB")+cAGENTE+TRB->EXAME)

						@Li,124 PSay TMB->TMB_QTIBMP PICTURE '@E 99,999.99'

						@Li,135 PSay substr(TMB->TMB_UNIDAD,1,5)

						If TRB->QUANTID > TMB->TMB_QTIBMP
							@Li,145 PSay "> "+STR0050 //"IBMP"
						Endif

						lPRIN := .f.

						dbSelectArea("TRB")
						dbSKIP()

					Enddo

					Somalinha()
				Enddo

			Enddo

			If ccCUSTO == TRB->CCUSTO
				Somalinha()
			Endif

		Enddo

		Somalinha()
	Enddo

Endif

Roda(nCntImpr,cRodaTxt,Tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RetIndex("TM5")

Set Filter To

If TRB->(RecCount()) = 0
	MsgInfo(STR0039)  //"Não há nada para imprimir no relatório."
	oTempTable:Delete()
	Return .f.
Endif

Set device to Screen

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif
//SET CENTURY ON
MS_FLUSH()
oTempTable:Delete()

dbSelectArea("TM5")

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
EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³ Ricardo Dal Ponte     ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Define as secoes impressas no relatorio                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2
Local oCell
Local nTamExa := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

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
oReport := TReport():New("MDTR486",OemToAnsi(STR0006),cPerg,{|oReport| ReportPrint(oReport)},STR0001+" "+STR0002+" "+STR0003)

Pergunte(oReport:uParam,.F.)

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

If lSigaMdtps
	oSection0 := TRSection():New (oReport,STR0037, {"TRB", "SA1"} )   //"Cliente"
	TRCell():New (oSection0, "A1_COD" , "SA1", STR0037, "@!", nTa1 )  //"Cliente"
	TRCell():New (oSection0, "A1_LOJA", "SA1", STR0030, "@!", nTa1L ) //"Loja"
	TRCell():New (oSection0, "A1_NOME", "SA1", STR0038, "@!", 40 )    //"Nome"
	TRPosition():New (oSection0, "SA1", 1, {|| xFilial("SA1") + TRB->CLIENT+TRB->LOJA } )
Endif

oSection1 := TRSection():New(oReport,STR0040,{"TRB",cAliasCC})  //"Centro de Custo"
TRCell():New(oSection1,"TRB->CCUSTO" ,"TRB",STR0040	,"@!" ,nSizeSI3+10  ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Centro de Custo"
TRCell():New(oSection1,cDescCC,cAliasCC,STR0041	,"@!" ,40,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Centro de Custo"
TRPosition():New(oSection1,cAliasCC,1,{|| xFilial(cAliasCC) + TRB->CCUSTO })

oSection2 := TRSection():New(oReport,STR0025,{"TRB","SRA","TM4","TMB","TMA"})  //"Exames"
oCell := TRCell():New(oSection2,"TRB->MATRIC"	,"TRB" ,STR0013	,"@!" 		  ,14  ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Matricula"
oCell := TRCell():New(oSection2,"TRB->NOMEFIC","TRB" ,STR0014	,"@!" 		  ,38 ,/*lPixel*/,/*{|| code-block de impressao }*/)  //"Funcionário"
oCell := TRCell():New(oSection2,"TRB->DTREAL"	,"TRB" ,STR0015	,"99/99/9999" ,14 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Realizado"
TRCell():New(         oSection2,"TRB->AGENTE"   ,"TRB" ,STR0016	,"@!"         ,10 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Agente"
TRCell():New(         oSection2,"TMA_NOMAGE"    ,"TMA" ,STR0017	,"@!"         ,40 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Agente"
oCell := TRCell():New(oSection2,"TRB->EXAME" 	,"TRB" ,STR0018 ,"@!"         ,nTamExa+2 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Exame"
oCell := TRCell():New(oSection2,"TM4_NOMEXA"	,"TM4" ,STR0019	,"@!"          ,24  ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Nome do Exame"
oCell := TRCell():New(oSection2,"TRB->QUANTID" 	,"TRB" ,STR0020	,"@E 999,999,999.99" ,15  ,/*lPixel*/,/*{|| code-block de impressao }*/) //"Quantidade"
oCell := TRCell():New(oSection2,"TMB_QTIBMP"	,"TMB" ,STR0021	,"@E 999.99"         ,8  ,/*lPixel*/,/*{|| code-block de impressao }*/) //"IBMP"
oCell := TRCell():New(oSection2,"  "			,"   " ,	,"@!"          ,2  ,/*lPixel*//*,{|| cRES}*/) //"Espaço em Branco"
oCell := TRCell():New(oSection2,"TMB_UNIDAD"	,"TMB" ,STR0022	,"@!"          ,8 ,/*lPixel*/,/*{|| code-block de impressao }*/) //"U.M."
oCell := TRCell():New(oSection2,"  "			,"   " ,STR0023	,"@!"          ,8  ,/*lPixel*/,{|| cRES}) //"Res."

TRPosition():New(oSection2,"SRA",1,{|| xFilial("SRA") + TRB->MATRIC})
TRPosition():New(oSection2,"TM4",1,{|| xFilial("TM4") + TRB->EXAME})
TRPosition():New(oSection2,"TMB",1,{|| xFilial("TMB") + cAGENTE+TRB->EXAME})
TRPosition():New(oSection2,"TMA",1,{|| xFilial("TMA") + TRB->AGENTE })

oSection2:Cell("TRB->QUANTID"):SetHeaderAlign("RIGHT")
oSection2:Cell("TMB_QTIBMP"):SetHeaderAlign("RIGHT")
Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportPrint³ Autor ³ Ricardo Dal Ponte     ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamada do Relat¢rio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMNT                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oSection1
Local oSection2

Private ccCUSTO
Private cMAT
Private dDATAREAL
Private cAGENTE
Private cRES

Processa({|lEND| U_MDTR486TM5()},STR0010) //"Processando Arquivo..."

If lSigaMdtps

	oSection0 := oReport:Section(1)
	oSection1 := oReport:Section(2)
	oSection2 := oReport:Section(3)

	dbSelectArea("TRB")
	dbGOTOP()
	oReport:SetMeter(RecCount())
	While !Eof() .And. !oReport:Cancel()

		oReport:IncMeter()

		cCliente := TRB->CLIENT+TRB->LOJA
		oSection0:Init()
		oSection0:PrintLine()

		dbSelectArea("TRB")

		While !Eof() .AND. cCliente == TRB->CLIENT+TRB->LOJA .And. !oReport:Cancel()

			ccCUSTO := TRB->CCUSTO
			oSection1:Init()
			oSection1:PrintLine()

			dbSelectArea("TRB")

			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .And. !oReport:Cancel()

				oSection2:Init()

				cMAT := TRB->MATRIC

				lPRIN := .t.

				oSection2:Cell("TRB->MATRIC"):Show()
				oSection2:Cell("RA_NOME"):Show()

				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
							 .And. !oReport:Cancel()

					dDATAREAL := TRB->DTREAL

					dbSelectArea("TRB")
					While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
								 .AND. dDATAREAL == TRB->DTREAL;
								 .And. !oReport:Cancel()

						cAGENTE := TRB->AGENTE

						dbSelectArea("TRB")
						While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
									 .AND. dDATAREAL == TRB->DTREAL .AND. cAGENTE == TRB->AGENTE;
									 .And. !oReport:Cancel()


							dbSelectArea("TMB")
							dbSetOrder(01)
							dbSeek(xFilial("TMB")+cAGENTE+TRB->EXAME)

							cRES := ""

							If TRB->QUANTID > TMB->TMB_QTIBMP
								cRES := "> "+STR0050 //"IBMP"
							Endif

							oSection2:PrintLine()

							oSection2:Cell("TRB->MATRIC"):Hide()
							oSection2:Cell("RA_NOME"):Hide()

							dbSelectArea("TRB")
							dbSKIP()
						End
					End
				End
				oSection2:Finish()
			End
			oSection1:Finish()
		End
		oSection0:Finish()

	End

Else

	oSection1 := oReport:Section(1)
	oSection2 := oReport:Section(2)

	dbSelectArea("TRB")
	dbGOTOP()
	oReport:SetMeter(RecCount())
	While !Eof() .And. !oReport:Cancel()

		oReport:IncMeter()

		ccCUSTO := TRB->CCUSTO

		oSection1:Init()
		oSection1:PrintLine()

		dbSelectArea("TRB")

		While !Eof() .AND. ccCUSTO == TRB->CCUSTO .And. !oReport:Cancel()

			oSection2:Init()

			cMAT := TRB->MATRIC

			lPRIN := .t.

			oSection2:Cell("TRB->MATRIC"):Show()
			oSection2:Cell("TRB->NOMEFIC"):Show()

			dbSelectArea("TRB")
			While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
						 .And. !oReport:Cancel()

				dDATAREAL := TRB->DTREAL

				dbSelectArea("TRB")
				While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
							 .AND. dDATAREAL == TRB->DTREAL;
							 .And. !oReport:Cancel()

					cAGENTE := TRB->AGENTE

					dbSelectArea("TRB")
					While !Eof() .AND. ccCUSTO == TRB->CCUSTO .AND. cMAT == TRB->MATRIC;
								 .AND. dDATAREAL == TRB->DTREAL .AND. cAGENTE == TRB->AGENTE;
								 .And. !oReport:Cancel()


						dbSelectArea("TMB")
						dbSetOrder(01)
						dbSeek(xFilial("TMB")+cAGENTE+TRB->EXAME)

						cRES := ""

						If TRB->QUANTID > TMB->TMB_QTIBMP
							cRES := "> "+STR0050 //"IBMP"
						Endif

						oSection2:PrintLine()

						oSection2:Cell("TRB->MATRIC"):Hide()
						oSection2:Cell("TRB->NOMEFIC"):Hide()

						dbSelectArea("TRB")
						dbSKIP()
					EndDo
				EndDo
			EndDo

			oSection2:Finish()
		EndDo

		oSection1:Finish()
	EndDo

Endif

If TRB->(RecCount()) = 0
	MsgInfo(STR0039)  //"Não há nada para imprimir no relatório."
	oTempTable:Delete()
	Return .f.
Endif

oTempTable:Delete()

Return .T.
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MDTR486TM5 ³ Autor ³ Ricardo Dalponte      ³ Data ³09/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Processa o arquivo de roteio..                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaMDT                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ F.O  ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³            ³        ³      ³                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MDTR486TM5()
Local nTamMat   := TAMSX3("RA_MAT")[1]
LOCAL lContinua := .T.
Local nTamExa   := If(TAMSX3("TM4_EXAME")[1] < 1, 6, TAMSX3("TM4_EXAME")[1])

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{"CLIENT" ,"C",nTa1,0})
	AADD(aDBF,{"LOJA"   ,"C",nTa1l,0})
	AADD(aDBF,{"NOMECLI","C",40,0})
	AADD(aDBF,{"CCUSTO" ,"C",nSizeSI3,0})
	AADD(aDBF,{"MATRIC" ,"C",nTamMat,0})
	AADD(aDBF,{"DTREAL" ,"D",08,0})
	AADD(aDBF,{"AGENTE" ,"C",06,0})
	AADD(aDBF,{"EXAME"  ,"C",nTamExa,0})
	AADD(aDBF,{"QUANTID","N",08,2})
	AADD(aDBF,{"NOMEFIC","C",20,0})

	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"CLIENT","LOJA","CCUSTO","MATRIC","DTREAL","AGENTE"} )
	oTempTable:Create()

	dbSelectArea("TM5")
	dbSetOrder(07)  //TM5_FILIAL+TM5_CC+TM5_EXAME
	dbSeek(xFilial("TM5")+MV_PAR05,.T.)

	dbSelectArea("TM0")
	dbSetOrder(1)
	dbSeek(xFilial("TM0")+TM5->TM5_NUMFIC)

	ProcRegua(RecCount())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  Exames realizados                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While lContinua                           .AND.;
	      !Eof()                              .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5')   .AND.;
	      TM5->TM5_CC <= MV_PAR06

		IncProc()

		cCliente := SubStr(TM5->TM5_CC,1,nSizeTD)

		If cCliente < mv_par01+mv_par02 .or. cCliente > mv_par03+mv_par04
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		If Empty(TM5->TM5_DTRESU)
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		If TM5->TM5_EXAME < MV_PAR09 .or. TM5->TM5_EXAME > MV_PAR10
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		If TM5->TM5_DTRESU < MV_PAR11 .or. TM5->TM5_DTRESU > MV_PAR12
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TN4")
		dbSetOrder(01)
		dbSeek(xFilial("TN4")+TM5->TM5_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_EXAME)
		While !Eof()                              .AND.;
	   		  TN4->TN4_FILIAL == xFIlial('TN4')   .AND.;
			  TN4->TN4_NUMFIC == TM5->TM5_NUMFIC  .AND.;
			  TN4->TN4_DTPROG == TM5->TM5_DTPROG  .AND.;
			  TN4->TN4_EXAME == TM5->TM5_EXAME

			If TN4->TN4_AGENTE < MV_PAR07 .or. TN4->TN4_AGENTE > MV_PAR08
				dbSelectArea("TN4")
				dbSKIP()
				loop
			Endif

			dbSelectArea("TRB")
			TRB->(DbAppend())
			TRB->CLIENT  := SubStr(cCliente,1,nTa1)
			TRB->LOJA    := SubStr(cCliente,nTa1+1,nSizeTD)
			TRB->NOMECLI := NGSEEK("SA1",cCliente,1,"SA1->A1_NOME")
			TRB->CCUSTO  := TM5->TM5_CC
			TRB->MATRIC  := TM5->TM5_MAT
			TRB->DTREAL  := TM5->TM5_DTRESU
			TRB->EXAME   := TM5->TM5_EXAME
			TRB->AGENTE  := TN4->TN4_AGENTE
			TRB->QUANTID := TN4->TN4_QTDENC
			TRB->NOMEFIC  := TM0->TM0_NOMFIC


			dbSelectArea("TN4")
			dbSkip()

		End
		dbSelectArea("TM5")
		dbSkip()
	End

Else

	aDBF := {}
	AADD(aDBF,{"CCUSTO" ,"C",nSizeSI3,0})
	AADD(aDBF,{"MATRIC" ,"C",nTamMat,0})
	AADD(aDBF,{"DTREAL" ,"D",08,0})
	AADD(aDBF,{"AGENTE" ,"C",06,0})
	AADD(aDBF,{"EXAME"  ,"C",nTamExa,0})
	AADD(aDBF,{"QUANTID","N",08,2})
	AADD(aDBF,{"NOMEFIC","C",20,0})

	oTempTable := FWTemporaryTable():New( "TRB", aDBF )
	oTempTable:AddIndex( "1", {"CCUSTO","MATRIC","DTREAL","AGENTE"} )
	oTempTable:Create()

	dbSelectArea("TM5")
	dbSetOrder(07)
	dbSeek(xFilial("TM5")+MV_PAR01,.T.)

	dbSelectArea("TM0")
	dbSetOrder(1)
	dbSeek(xFilial("TM0")+TM5->TM5_NUMFIC)

	ProcRegua(RecCount())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Correr TM5 para ler os  Exames realizados                ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	While lContinua                           .AND.;
	      !Eof()                              .AND.;
	      TM5->TM5_FILIAL == xFIlial('TM5')   .AND.;
	      TM5->TM5_CC <= MV_PAR02

		IncProc()

		If Empty(TM5->TM5_DTRESU)
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		If TM5->TM5_EXAME < MV_PAR05 .or. TM5->TM5_EXAME > MV_PAR06
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		If TM5->TM5_DTRESU < MV_PAR07 .or. TM5->TM5_DTRESU > MV_PAR08
			dbSelectArea("TM5")
			dbSKIP()
			loop
		Endif

		dbSelectArea("TN4")
		dbSetOrder(01)
		dbSeek(xFilial("TN4")+TM5->TM5_NUMFIC+DTOS(TM5->TM5_DTPROG)+TM5->TM5_EXAME)
		While !Eof()                              .AND.;
	   		  TN4->TN4_FILIAL == xFIlial('TN4')   .AND.;
			  TN4->TN4_NUMFIC == TM5->TM5_NUMFIC  .AND.;
			  TN4->TN4_DTPROG == TM5->TM5_DTPROG  .AND.;
			  TN4->TN4_EXAME == TM5->TM5_EXAME

			If TN4->TN4_AGENTE < MV_PAR03 .or. TN4->TN4_AGENTE > MV_PAR04
				dbSelectArea("TN4")
				dbSKIP()
				loop
			Endif

			dbSelectArea("TRB")
			TRB->(DbAppend())
			TRB->CCUSTO	:= TM5->TM5_CC
			TRB->MATRIC	:= TM5->TM5_MAT
			TRB->DTREAL	:= TM5->TM5_DTRESU
			TRB->EXAME		:= TM5->TM5_EXAME
			TRB->AGENTE	:= TN4->TN4_AGENTE
			TRB->QUANTID	:= TN4->TN4_QTDENC
			TRB->NOMEFIC	:= NgSeek( "TM0", TM5->TM5_NUMFIC, 1, "TM0_NOMFIC" )

			dbSelectArea("TN4")
			dbSkip()

		End
		dbSelectArea("TM5")
		dbSkip()
	End

Endif

Return .T.