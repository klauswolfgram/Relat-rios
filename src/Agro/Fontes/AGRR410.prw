/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR410  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao para Acertos de Diaristas.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAAGR                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR410()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Acerto de Diaristas."
Local titulo         := "Relacao para Acerto de Diaristas"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {"Diarista+Data"}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := 'AGRR410'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR410"
Private wnrel       := "AGRR410"
Private cString 	:= "NQF"

DbSelectArea("NQF")
DbSetOrder(1)

Pergunte(cPerg,.f.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³RunReport ³ Autor ³ Danyel Bernuci        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ³±±
±±³			 ³ monta a janela com a regua de processamento.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local aArea     := GetArea()
Local cFilNQF   := ''
Local cFiltUser := aReturn[7]
Local lImpMDO   := .t.
Local nCntDia   := 0
Local nCntTot   := 0
Local nVlrPar   := 0
Local nVlrTot   := 0

//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//|Diarista                                 |   Data   | Safra                | Fazenda              | Servico                                  |   Valor Diaria |   Data   |         Usuario |         Usuario |
//|                                         |          |                      |                      |                                          |                |  Acerto  |     de Inclusao |  de Confirmacao |
//|######################################## | ##/##/## | #################### | #################### | ######################################## | ###.###.###,## | ##/##/## | ############### | ############### |

Cabec1 := "|Diarista                                 |   Data   | Safra                | Fazenda              | Servico                                  |   Valor Diaria |   Data   |         Usuario |         Usuario |"
Cabec2 := "|                                         |          |                      |                      |                                          |                |  Acerto  |     de Inclusao |  de Confirmacao |"

If mv_par08 <> 1
	mv_par09 := cFilial
	mv_par10 := cFilial
EndIf

cFilNQF += "NQF_CODMDO >= '"+mv_par02+"' .And. NQF_CODMDO <= '"+mv_par03+"' .And. "
cFilNQF += "NQF_FAZ >= '"+mv_par04+"' .And. NQF_FAZ <= '"+mv_par05+"' .And. "
cFilNQF += "DTOS(NQF_DATA) >= '"+DTOS(mv_par06)+"' .And. DTOS(NQF_DATA) <= '"+DTOS(mv_par07)+"' .And. "
If mv_par01==1
	cFilNQF += "AllTrim(DTOS(NQF_DATACR)) <> '' .And. "
ElseIf mv_par01==2
	cFilNQF += "AllTrim(DTOS(NQF_DATACR)) == '' .And. "
EndIf
If mv_par08==1
	cFilNQF += "NQF_FILIAL >= '"+mv_par09+"' .And. NQF_FILIAL <= '"+mv_par10+"'"
Else
	cFilNQF += "NQF_FILIAL == '"+xFilial('NQF')+"'"
EndIf
dbSelectArea('NQF')
dbSetOrder(1)
dbSetFilter( {|| &cFilNQF }, cFilNQF )
dbGotop()
While .Not. Eof()

	lImpMDO := .t.
	nCntDia := 0
	nVlrPar := 0
	NNA->(dbSeek(xFilial('NNA')+NQF->NQF_CODMDO))

	Do While .Not. Eof() .And. NQF->NQF_CODMDO == NNA->NNA_CODIGO

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			NQF->(dbSkip())
			Loop
		EndIf
	
	   	If lAbortPrint
	      	@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
	      	Exit
	   	Endif
	                                                                                                              
	   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	      	If nLin < 80
		  		Roda()
		  	EndIf
	      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	      	nLin := 9
	   	EndIf

		NN1->(dbSeek(xFilial('NN1')+NQF->NQF_SAFRA))
		dbSelectArea('NN2')
		dbSetOrder(2)
		dbSeek(xFilial('NN2')+NQF->NQF_FAZ)
		dbSelectArea('NQF')
		NN9->(dbSeek(xFilial('NN9')+NQF->NQF_CODSRV))

		If lImpMDO
			@nLin, 001 PSay PadR(AllTrim(NNA->NNA_CODIGO)+'-'+AllTrim(NNA->NNA_NOME),40)
			lImpMDO := .f.
		EndIf
		@nLin, 044 PSay DTOC(NQF->NQF_DATA)
		@nLin, 055 PSay PadR(AllTrim(NN1->NN1_ANO+NN1->NN1_SEQ)+'-'+AllTrim(NN1->NN1_DESCRI),20)
		@nLin, 078 PSay PadR(AllTrim(NN2->NN2_CODIGO)+'-'+AllTrim(NN2->NN2_NOME),20)
		@nLin, 101 PSay PadR(AllTrim(NN9->NN9_CODIGO)+'-'+AllTrim(NN9->NN9_DESCRI),40)
		@nLin, 144 PSay Transform(NQF->NQF_VALOR, '@E 999,999,999.99')
		@nLin, 161 PSay DTOC(NQF->NQF_DATACR)
		@nLin, 172 PSay PadR(AllTrim(NQF->NQF_USER),15)
		@nLin, 190 PSay PadR(AllTrim(NQF->NQF_APROVA),15)
		nLin++

		nCntDia += 1
		nCntTot += 1
		nVlrPar += NQF->NQF_VALOR
		nVlrTot += NQF->NQF_VALOR

		dbSelectArea('NQF')
		dbSkip()
	EndDo

	If nCntDia > 0
		nLin++
		@nLin, 001 PSay PadL('Total de diarias: ('+Transform(nCntDia, '@E 999')+') ---> ',140)
		@nLin, 144 PSay Transform(nVlrPar, '@E 999,999,999.99')
		nLin += 2
	EndIf

EndDo

If nCntTot > 0
	nLin++
	@nLin, 001 PSay PadL('Total geral de diarias: ('+Transform(nCntTot, '@E 999')+') --------> ',140)
	@nLin, 144 PSay Transform(nVlrTot, '@E 999,999,999.99')
	nLin += 2
	Roda()
EndIf

RestArea(aArea)

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()
