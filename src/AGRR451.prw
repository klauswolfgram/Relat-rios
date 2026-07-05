/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR451  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
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

User Function AGRR451(cDocum)

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Transferencia de Produtos."
Local titulo         := "Transferencia de Produtos"
Local nLin           := 80
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := 'AGRR451'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR451"
Private wnrel       := "AGRR451"
Private cString 	:= "NQT"
Private cDoc        := cDocum

DbSelectArea("NQT")
DbSetOrder(1)

Pergunte(cPerg,.f.)

If cDoc <> nil
	cPerg := ''
EndIf

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
±±³ Uso      ³ AGRR451                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local aArea     := GetArea()
Local cFilNQT   := ''
Local cFiltUser := aReturn[7]

//          0         0         0         0         0         0         0         0         0         1         1         1         1
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
//|Numero    |  Data  |Orig.|Dest.|Produto                                                                           |Nome           |
//|Documento |Inclusao|Fl/Ar|Fl/Ar|Descrição                            |UM|Modelo|Fabricante|Quantidade|       Valor|Transportador  |
//|######-###|##/##/##|##/##|##/##|######-##############################|##|######|##########|###.###,##|#.###.###,##|###############|

Cabec1 := "|Numero    |  Data  |Orig.|Dest.|Produto                                                                           |Nome           |"
Cabec2 := "|Documento |Inclusao|Fl/Ar|Fl/Ar|Descrição                            |UM|Modelo|Fabricante|Quantidade|       Valor|Transportador  |"

If cDoc <> Nil
	mv_par01 := cDoc
	mv_par02 := cDoc
	mv_par03 := '   '
	mv_par04 := 'ZZZ'
EndIf

cFilNQT += "NQT_DOC >= '"+mv_par01+"' .And. NQT_DOC <= '"+mv_par02+"' .And. "
cFilNQT += "NQT_SEQ >= '"+mv_par03+"' .And. NQT_SEQ <= '"+mv_par04+"' .And. "
cFilNQT += "NQT_FILIAL = '"+xFilial('NQT')+"'"

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

//          0         0         0         0         0         0         0         0         0         1         1         1         1
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
//|Numero    |  Data  |Orig.|Dest.|Produto                                                                           |Nome           |
//|Documento |Inclusao|Fl/Ar|Fl/Ar|Descrição                            |UM|Modelo|Fabricante|Quantidade|       Valor|Transportador  |
//|######-###|##/##/##|##/##|##/##|######-##############################|##|######|##########|###.###,##|#.###.###,##|###############|

	nLin++
	@nLin, 001 PSay PadR(NQT->NQT_DOC,06)+'-'+PadR(NQT->NQT_SEQ,03) //Documento+Sequencia
	@nLin, 012 PSay DToC(NQT->NQT_DATA) //Data da Inclusao
	NNR->(dbSeek(xFilial('NNR')+NQT->NQT_ARMORI))
	@nLin, 021 PSay PadR(NQT->NQT_FILORI,02)+'/'+PadR(NQT->NQT_ARMORI,02) //Filial+Armazem de Origem
	NNR->(dbSeek(xFilial('NNR')+NQT->NQT_ARMDES))
	@nLin, 027 PSay PadR(NQT->NQT_FILDES,02)+'/'+PadR(NQT->NQT_ARMDES,02) //Filial+Armazem de Destino
	SB1->(dbSeek(xFilial('SB1')+NQT->NQT_CODPRO))
	@nLin, 033 PSay PadR(AllTrim(NQT->NQT_CODPRO)+'-'+AllTrim(SB1->B1_DESC),37) //Produto
	@nLin, 071 PSay PadR(SB1->B1_UM,02) //Unidade de Medida
	@nLin, 074 PSay PadR(SB1->B1_MODELO,06) //Modelo do Produto
	@nLin, 081 PSay PadR(SB1->B1_FABRIC,10) //Cod. do Fabricante
	@nLin, 092 PSay Transform(NQT->NQT_QUANT,'@E 999,999.99') //Quantidade
	@nLin, 103 PSay Transform(NQT->NQT_CUSTO,'@E 9,999,999.99') //Valor
	@nLin, 116 PSay PadR(NQT->NQT_NOMTRA,15) //Nome do Transportador

	dbSelectArea('NQT')
	dbSkip()

EndDo

Roda()
NQT->(dbClearFilter())
RestArea(aArea)

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()

