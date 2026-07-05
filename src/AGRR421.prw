/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR421  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao de Abastecimentos por Equipamento                  ³±±
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

User Function AGRR421()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Acerto de Frete."
Local titulo         := "Media Consumo/Equipamento"
Local nLin           := 80
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {"Familia + Equipamento"}
Private lEnd        := .f.
Private lAbortPrint := .f.
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := 'AGRR421'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR421"
Private wnrel       := "AGRR421"
Private cString 	:= "NND"

DbSelectArea("NND")
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
Local nX        := 0
Local cFilNND   := ''
Local cFilNNB   := ''
Local lListaFAM := .f.
Local cFiltUser := aReturn[7]

Local nQtdFAM := 0
Local nDiaFAM := 0
Local nLtsFAM := 0
Local nKmsFAM := 0
Local nMedFAM := 0
Local nCusFAM := 0

Local nQtdTOT := 0
Local nDiaTOT := 0
Local nLtsTOT := 0
Local nKmsTOT := 0
Local nMedTOT := 0
Local nCusTOT := 0

Private aEquips     := Array(0,0)
Private aAbast      := Array(0,0)
Private nQtd        := 0
Private nQtdDias    := 0
Private nQtdComb    := 0
Private nQtdCont    := 0
Private nMedCons    := 0
Private nVlCusto    := 0
Private dDataINI    := CToD('  /  /  ')
Private dDataFIM    := CToD('  /  /  ')

If mv_par06 <> 1
	mv_par07 := cFilial
	mv_par08 := cFilial
EndIf

cFilNND := "NND_CODIGO >= '"+mv_par02+"' .And. NND_CODIGO <= '"+mv_par03+"' .And. "
//Considera Filias
If mv_par06==1
	cFilNND += "NND_FILIAL >= '"+mv_par07+"' .And. NND_FILIAL <= '"+mv_par08+"'"
Else
	cFilNND += "NND_FILIAL == '"+xFilial('NND')+"'"
EndIf
dbSelectArea('NND')
dbSetOrder(1)
dbSetFilter( {|| &cFilNND }, cFilNND )
dbGotop()
While .Not. Eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltUser).And.!(&cFiltUser)
		NND->(dbSkip())
		Loop
	EndIf

	dbSelectArea('NNB')
	dbSetOrder(1)
	cFilNNB := "NNB_CODFAM == '"+NND->NND_CODIGO+"' .And. "
	cFilNNB += "NNB_CODIGO >= '"+mv_par04+"' .And. NNB_CODIGO <= '"+mv_par05+"' .And. "
	//Considera Filias
	If mv_par06==1
		cFilNNB += "NNB_FILIAL >= '"+mv_par07+"' .And. NNB_FILIAL <= '"+mv_par08+"'"
	Else
		cFilNNB += "NNB_FILIAL == '"+xFilial('NNB')+"'"
	EndIf
	dbSetFilter( {|| &cFilNNB }, cFilNNB )
	dbGotop()
	While .Not. Eof()

		lAbastece := fBusAbas(NNB_CODIGO, mv_par01) //Busca abastecimento / manutenções...

		If nQtdComb > 0 .And. nQtdCont > 0
			If mv_par09 == 1
				nMedCons := nQtdCont / nQtdComb
			Else
				nMedCons := nQtdComb / nQtdCont
			EndIf
		Else
			nMedCons := 0
		EndIf

		If  lAbastece
			lAbastece := .f.
			lListaFAM := .t.

			nQtdFAM += nQtd
			nDiaFAM := IIf(nQtdDias > nDiaFAM, nQtdDias, nDiaFAM)
			nLtsFAM += nQtdComb
			nKmsFAM += nQtdCont
			nMedFAM := IIf(nLtsFAM > 0 .And. nKmsFAM > 0, IIf(mv_par09==1, nKmsFAM / nLtsFAM, nLtsFAM / nKmsFAM) , 0)
			nCusFAM += nVlCusto

			aAdd(aEquips, {'R', AllTrim(NND->NND_CODIGO), AllTrim(NND->NND_NOME), NNB->NNB_CODIGO, NNB->NNB_PLACA, nQtd, dDataINI, dDataFIM, nQtdDias, nQtdComb, nQtdCont, nMedCons, nVlCusto } )
		EndIf

		dbSelectArea('NNB')
		dbSkip()
	EndDo

	If lListaFAM
		lListaFAM := .f.
		aAdd(aEquips, {'T', '', '', '', '', nQtdFAM, '', '', nDiaFAM, nLtsFAM, nKmsFAM, nMedFAM, nCusFAM } )
	EndIf

	nQtdTOT += nQtdFAM
	nDiaTOT := IIf(nDiaFAM > nDiaTOT, nDiaFAM, nDiaTOT)
	nLtsTOT += nLtsFAM
	nKmsTOT += nKmsFAM
	nMedTOT := IIf(nLtsTOT > 0 .And. nKmsTOT > 0, IIf(mv_par09==1, nKmsTOT / nLtsTOT, nLtsTOT / nKmsTOT), 0)
	nCusTOT += nCusFAM

	nQtdFAM := 0
	nDiaFAM := 0
	nLtsFAM := 0
	nKmsFAM := 0
	nMedFAM := 0
	nCusFAM := 0

	dbSelectArea('NND')
	dbSkip()
EndDo

If Len(aEquips) > 0
	aAdd(aEquips, {'G', '', '', '', '', nQtdTOT, '', '', nDiaTOT, nLtsTOT, nKmsTOT, nMedTOT, nCusTOT } )
EndIf

//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//|Familia                     | Equipamento      | Data     | Data     | Dias | Consumo |    Contador |  Media |      Custo(R$)|
//|Codigo Nome                 | Codigo  Placa    | Inicial  | Final    | Trab |  Litros |             |        |               |
//|###### #################### | ######  ###-#### | ##/##/## | ##/##/## | #### | ###,### | ###,###,### | ###.## | ###,###,###.##|

Cabec1 := "|Familia                     | Equipamento      | Data     | Data     | Dias | Consumo |    Contador |  Media |      Custo(R$)|"
Cabec2 := "|Codigo Nome                 | Codigo  Placa    | Inicial  | Final    | Trab |  Litros |             |        |               |"

For nX := 1 to Len(aEquips)

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
   	Endif

If aEquips[nX,01] == 'R'

	@nLin, 001 PSay Substr(aEquips[nX,02],01,06) //Cod. Familia
	@nLin, 008 PSay Substr(aEquips[nX,03],01,20) //Nome Familia
	@nLin, 031 PSay Substr(aEquips[nX,04],01,06) //Cod.  Equipamento
	@nLin, 039 PSay Substr(aEquips[nX,05],01,08) //Placa Equipamento
	@nLin, 050 PSay DToC(aEquips[nX,07]) //Data Inicial
	@nLin, 061 PSay DToC(aEquips[nX,08]) //Data Final
	@nLin, 072 PSay Transform(aEquips[nX,09],"@E 9999") //Dias Trabalhados
	@nLin, 079 PSay Transform(aEquips[nX,10],"@E 999,999") //Litros de Combustivel
	@nLin, 089 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 103 PSay Transform(aEquips[nX,12],"@E 999.99") //Media de Consumo
	@nLin, 112 PSay Transform(aEquips[nX,13],"@E 999,999,999.99") //Custo
	nLin++

ElseIf aEquips[nX,01] == 'T'

	nLin++
	@nLin, 000 PSay PadL('Total da Familia -->',58)
	@nLin, 072 PSay Transform(aEquips[nX,09],"@E 9999") //Dias Trabalhados
	@nLin, 079 PSay Transform(aEquips[nX,10],"@E 999,999") //Litros de Combustivel
	@nLin, 089 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 103 PSay Transform(aEquips[nX,12],"@E 999.99") //Media de Consumo
	@nLin, 112 PSay Transform(aEquips[nX,13],"@E 999,999,999.99") //Custo

	nLin++;	nLin++

Else

	nLin++;	nLin++
	@nLin, 000 PSay PadL('Total da Geral ---->',58)
	@nLin, 072 PSay Transform(aEquips[nX,09],"@E 9999") //Dias Trabalhados
	@nLin, 079 PSay Transform(aEquips[nX,10],"@E 999,999") //Litros de Combustivel
	@nLin, 089 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 103 PSay Transform(aEquips[nX,12],"@E 999.99") //Media de Consumo
	@nLin, 112 PSay Transform(aEquips[nX,13],"@E 999,999,999.99") //Custo

EndIf

Next nX

RestArea(aArea)

Roda()

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return


Static Function fBusAbas(cCodEqu, cSafra)
Local aArea := GetArea()
Local lRetorno := .f.
Local nContINI := 0
Local nContFIM := 0
Local cFilNQD  := ''

dDataINI := CToD('  /  /  ')
dDataFIM := CToD('  /  /  ')
nQtdDias := 0
nQtdComb := 0
nQtdCont := 0
nVlCusto := 0

cFilNQD := "NQD_FILIAL >= '"+mv_par07+"' .And. NQD_FILIAL <= '"+mv_par08+"' .And. "
cFilNQD += "NQD_CODEQU == '"+cCodEqu +"' .And. NQD_SAFRA == '" +cSafra  +"'"
dbSelectArea('NQD')
dbSetOrder(1)
dbSetFilter( {|| &cFilNQD }, cFilNQD )
dbGotop()
While .Not. Eof()

	If NQD->NQD_TIPO == 'I'
		nContINI := NQD->NQD_CONT
		dDataINI := NQD->NQD_DATA
	ElseIf NQD->NQD_TIPO = 'F'
		nContFIM := NQD->NQD_CONT
		dDataFIM := NQD->NQD_DATA
	ElseIf NQD->NQD_TIPO = 'A'
		nQtdComb += NQD->NQD_QTDPRO
		nVlCusto += NQD->NQD_CUSTO
		nContFIM := NQD->NQD_CONT
		dDataFIM := NQD->NQD_DATA
		If Empty(dDataINI)
			nContINI := NQD->NQD_CONT
			dDataINI := NQD->NQD_DATA
		EndIf
	Else
		nVlCusto += NQD->NQD_CUSTO
	EndIf

	dbSelectArea('NQD')
	dbSkip()
EndDo

nQtdDias := dDataFIM - dDataINI
nQtdCont := nContFIM - nContINI

If nQtdComb > 0; lRetorno := .t.; EndIf

dbClearFilter()
RestArea(aArea)
Return(lRetorno)

