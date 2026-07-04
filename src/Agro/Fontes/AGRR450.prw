/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR450  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao para Transferencia de Produtos                     ³±±
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

User Function AGRR450()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Transferencia de Produtos."
Local titulo         := "Relacao para Transferencia de Produtos"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {""}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := 'AGRR450'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR450"
Private wnrel       := "AGRR450"
Private cString 	:= "NQT"

DbSelectArea("NQT")
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
Local cFilNQT   := ''
Local cFiltUser := aReturn[7]

//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//|Docum. | Seq | Origem                                                     | Destino                                                    | Produto                                                                      |
//|       |     | Fl | Armazem            |   Data   | TM  | Usuario         | Fl | Armazem            |   Data   | TM  | Usuario         | Descrição                              | UM |     Quantidade |          Valor|
// ######   ###   ##   ##-###############   ##/##/##   ###   ###############   ##   ##-###############   ##/##/##   ###   ###############   ######-##############################    ##   ###.###.###,##   ###.###.###,##

Cabec1 := "|Docum. | Seq | Origem                                                     | Destino                                                    | Produto                                                                      |"
Cabec2 := "|       |     | Fl | Armazem            |   Data   | TM  | Usuario         | Fl | Armazem            |   Data   | TM  | Usuario         | Descrição                              | UM |     Quantidade |          Valor|"

cFilNQT += "NQT_DOC >= '"+mv_par02+"' .And. NQT_DOC <= '"+mv_par03+"' .And. "
cFilNQT += "DTOS(NQT_DATA) >= '"+DTOS(mv_par04)+"' .And. DTOS(NQT_DATA) <= '"+DTOS(mv_par05)+"' .And. "
cFilNQT += "NQT_ARMORI >= '"+mv_par06+"' .And. NQT_ARMORI <= '"+mv_par07+"' .And. "
cFilNQT += "NQT_ARMDES >= '"+mv_par06+"' .And. NQT_ARMDES <= '"+mv_par07+"' .And. "
cFilNQT += "NQT_CODPRO >= '"+mv_par08+"' .And. NQT_CODPRO <= '"+mv_par09+"' .And. "
If mv_par01 == 1
	cFilNQT += "!Empty(NQT_DTORIG) .And. !Empty(NQT_DTDEST) .And. "
ElseIf mv_par01 == 2
	cFilNQT += "Empty(NQT_DTORIG) .And. Empty(NQT_DTDEST) .And. "
EndIf
If mv_par12 == 1
	cFilNQT += "NQT_FILIAL >= '"+mv_par13+"' .And. NQT_FILIAL <= '"+mv_par14+"'"
Else
	cFilNQT += "NQT_FILIAL = '"+xFilial('NQT')+"'"
EndIf

dbSelectArea('NQT')
dbSetOrder(1)
dbSetFilter( {|| &cFilNQT }, cFilNQT )
dbGotop()
While .Not. Eof()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltUser).And.!(&cFiltUser)
		NQT->(dbSkip())
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

	nLin++
	@nLin, 001 PSay PadR(NQT->NQT_DOC,06) //Documento
	@nLin, 010 PSay PadR(NQT->NQT_SEQ,02) //Sequencia
	@nLin, 016 PSay PadR(NQT->NQT_FILORI,02) //Filial Origem
	NNR->(dbSeek(xFilial('NNR')+NQT->NQT_ARMORI))
	@nLin, 021 PSay PadR(NQT->NQT_ARMORI+'-'+NNR->NNR_DESCRI,18) //Armazem de Origem
	@nLin, 042 PSay DToC(NQT->NQT_DTORIG) //Data de Origem
	@nLin, 053 PSay PadR(NQT->NQT_TMSAI,03) //TM de Origem
	@nLin, 059 PSay PadR(NQT->NQT_USUORI,15) //Usuario de Origem
	@nLin, 077 PSay PadR(NQT->NQT_FILDES,02) //Filial de Destino
	NNR->(dbSeek(xFilial('NNR')+NQT->NQT_ARMDES))
	@nLin, 082 PSay PadR(NQT->NQT_ARMDES+'-'+NNR->NNR_DESCRI,18) //Armazem de Destino
	@nLin, 103 PSay DToC(NQT->NQT_DTDEST) //Data de Destino
	@nLin, 114 PSay PadR(NQT->NQT_TMENT,03) //TM de Destino
	@nLin, 120 PSay PadR(NQT->NQT_USUDES,15) //Usuario de Destino
	SB1->(dbSeek(xFilial('SB1')+NQT->NQT_CODPRO))
	@nLin, 138 PSay PadR(AllTrim(NQT->NQT_CODPRO)+'-'+AllTrim(SB1->B1_DESC),38) //Produto
	@nLin, 179 PSay PadR(SB1->B1_UM,02) //Unidade de Medida
	@nLin, 184 PSay Transform(NQT->NQT_QUANT,'@E 999,999,999.99') //Quantidade
	@nLin, 201 PSay Transform(NQT->NQT_CUSTO,'@E 999,999,999.99') //Valor

	dbSelectArea('NQT')
	dbSkip()

EndDo

RestArea(aArea)

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()

