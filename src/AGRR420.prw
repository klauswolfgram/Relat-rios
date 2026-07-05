/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR420  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao de Abastecimentos por Transportadora               ³±±
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

User Function AGRR420()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Acerto de Frete."
Local titulo         := "Media Consumo/Transportador"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {"Transportador + Equipamento"}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := 'AGRR420'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR420"
Private wnrel       := "AGRR420"
Private cString 	:= "SA4"

Private aEquips     := Array(0,0)
Private nQtdUm      := 0
Private nQtdDois    := 0
Private nQtdDias    := 0
Private nQtdComb    := 0
Private nQtdCont    := 0
Private nMedCons    := 0
Private nVlCusto    := 0
Private dDataINI    := CToD('  /  /  ')
Private dDataFIM    := CToD('  /  /  ')

DbSelectArea("SA4")
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
Local cFilSA4   := ''
Local cFilNNB   := ''
Local lListaTRA := .f.
Local cFiltUser := aReturn[7]

Local nQt1TRA := 0
Local nQt2TRA := 0
Local nDiaTRA := 0
Local nLtsTRA := 0
Local nKmsTRA := 0
Local nMedTRA := 0
Local nCusTRA := 0

Local nQt1TOT := 0
Local nQt2TOT := 0
Local nDiaTOT := 0
Local nLtsTOT := 0
Local nKmsTOT := 0
Local nMedTOT := 0
Local nCusTOT := 0

If mv_par08 <> 1
	mv_par09 := cFilial
	mv_par10 := cFilial
EndIf

cFilSA4 := "A4_COD >= '"+mv_par02+"' .And. A4_COD <= '"+mv_par03+"' .And. "
//Considera Filias
If mv_par08==1
	cFilSA4 += "A4_FILIAL >= '"+mv_par09+"' .And. A4_FILIAL <= '"+mv_par10+"'"
Else
	cFilSA4 += "A4_FILIAL == '"+xFilial('SA4')+"'"
EndIf
dbSelectArea('SA4')
dbSetOrder(1)
dbSetFilter( {|| &cFilSA4 }, cFilSA4 )
dbGotop()
While .Not. Eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltUser).And.!(&cFiltUser)
		SA4->(dbSkip())
		Loop
	EndIf

//	If AllTrim(xFilial('SA4')) <> ''
//		If SA4->A4_FILIAL < mv_par09 .Or. SA4->A4_FILIAL > mv_par10
//			dbSkip()
//			Loop
//		EndIf
//	EndIf
//	If SA4->A4_COD < mv_par02 .Or. SA4->A4_COD > mv_par03
//		dbSkip()
//		Loop
//	EndIf

	dbSelectArea('NNB')
	dbSetOrder(1)
	cFilNNB := "NNB_CODTRA == '"+SA4->A4_COD+"' .And. "
	cFilNNB += "NNB_CODIGO >= '"+mv_par04+"' .And. NNB_CODIGO <= '"+mv_par05+"' .And. "
	//Considera Filias
	If mv_par08==1
		cFilNNB += "NNB_FILIAL >= '"+mv_par09+"' .And. NNB_FILIAL <= '"+mv_par10+"'"
	Else
		cFilNNB += "NNB_FILIAL == '"+xFilial('NNB')+"'"
	EndIf
	dbSetFilter( {|| &cFilNNB }, cFilNNB )
	dbGotop()
	While .Not. Eof()

		lProducao := fBusProd(SA4->A4_COD, NNB_CODIGO) //Busca produção por equipamento nos romaneios de entrada...
		
		lAbastece := fBusAbas(NNB_CODIGO, mv_par01) //Busca abastecimento / manutencoes...
		
		If nQtdComb > 0 .And. nQtdCont > 0
			nMedCons := nQtdCont / nQtdComb
		Else
			nMedCons := 0
		EndIf

		If lProducao .Or. lAbastece
			lProducao := .f.
			lAbastece := .f.
			lListaTRA := .t.

			nQt1TRA += nQtdUm
			nQt2TRA += nQtdDois
			nDiaTRA := IIf(nQtdDias > nDiaTRA, nQtdDias, nDiaTRA)
			nLtsTRA += nQtdComb
			nKmsTRA += nQtdCont
			nMedTRA := IIf(nLtsTRA > 0 .And. nKmsTRA > 0, nKmsTRA / nLtsTRA, 0)
			nCusTRA += nVlCusto

			aAdd(aEquips, {'R', AllTrim(SA4->A4_COD), AllTrim(SA4->A4_NOME), NNB->NNB_CODIGO, NNB->NNB_PLACA, nQtdUm, nQtdDois, dDataINI, dDataFIM, nQtdDias, nQtdComb, nQtdCont, nMedCons, nVlCusto } )
		EndIf

		dbSelectArea('NNB')
		dbSkip()
	EndDo

	If lListaTRA
		lListaTRA := .f.
		aAdd(aEquips, {'T', '', '', '', '', nQt1TRA, nQt2TRA, '', '', nDiaTRA, nLtsTRA, nKmsTRA, nMedTRA, nCusTRA } )
	EndIf

	nQt1TOT += nQt1TRA
	nQt2TOT += nQt2TRA
	nDiaTOT := IIf(nDiaTRA > nDiaTOT, nDiaTRA, nDiaTOT)
	nLtsTOT += nLtsTRA
	nKmsTOT += nKmsTRA
	nMedTOT := IIf(nLtsTOT > 0 .And. nKmsTOT > 0, nKmsTOT / nLtsTOT, 0)
	nCusTOT += nCusTRA

	nQt1TRA := 0
	nQt2TRA := 0
	nDiaTRA := 0
	nLtsTRA := 0
	nKmsTRA := 0
	nMedTRA := 0
	nCusTRA := 0

	dbSelectArea('SA4')
	dbSkip()
EndDo

If Len(aEquips) > 0
	aAdd(aEquips, {'G', '', '', '', '', nQt1TOT, nQt2TOT, '', '', nDiaTOT, nLtsTOT, nKmsTOT, nMedTOT, nCusTOT } )
EndIf

//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//|Transportadora                        | Equipamento      |              Quantidades Transportadas | Data     | Data     |     Dias    |     Consumo |         KMs |      Media |          Custo(R$)|
//|Codigo Nome                           | Codigo  Placa    |                UM1                 UM2 | Inicial  | Final    | Trabalhados |      Litros |             |            |                   |
//|###### ############################## | ######  ###-#### | ###,###,###,###.##  ###,###,###,###.## | ##/##/## | ##/##/## |    ##,###   | ###,###,### | ###,###,### | ###,###.## | ###,###,###,###.##|

Cabec1 := "|Transportadora                        | Equipamento      |              Quantidades Transportadas | Data     | Data     |     Dias    |     Consumo |         KMs |      Media |          Custo(R$)|"
Cabec2 := "|Codigo Nome                           | Codigo  Placa    |                "+PadR(mv_par06,3)+"                 "+PadR(mv_par07,3)+" | Inicial  | Final    | Trabalhados |      Litros |             |            |                   |"

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

	@nLin, 001 PSay Substr(aEquips[nX,02],01,06) //Cod. Transportadora
	@nLin, 008 PSay Substr(aEquips[nX,03],01,28) //Nome Transportadora
	@nLin, 041 PSay Substr(aEquips[nX,04],01,06) //Cod.  Equipamento
	@nLin, 049 PSay Substr(aEquips[nX,05],01,08) //Placa Equipamento
	@nLin, 060 PSay Transform(aEquips[nX,06],"@E 999,999,999,999.99") //Qtd. Transportada Um
	@nLin, 080 PSay Transform(aEquips[nX,07],"@E 999,999,999,999.99") //Qtd. Transportada Dois
	@nLin, 101 PSay DToC(aEquips[nX,08]) //Data Inicial
	@nLin, 112 PSay DToC(aEquips[nX,09]) //Data Final
	@nLin, 126 PSay Transform(aEquips[nX,10],"@E 99,999") //Dias Trabalhados
	@nLin, 137 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Litros de Combustivel
	@nLin, 151 PSay Transform(aEquips[nX,12],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 165 PSay Transform(aEquips[nX,13],"@E 999,999.99") //Media de Consumo
	@nLin, 178 PSay Transform(aEquips[nX,14],"@E 999,999,999,999.99") //Custo do Combustivel
	nLin++

ElseIf aEquips[nX,01] == 'T'

	nLin++
	@nLin, 000 PSay PadL('Total da Transportadora -->',58)
	@nLin, 060 PSay Transform(aEquips[nX,06],"@E 999,999,999,999.99") //Qtd. Transportada Um
	@nLin, 080 PSay Transform(aEquips[nX,07],"@E 999,999,999,999.99") //Qtd. Transportada Dois
	@nLin, 126 PSay Transform(aEquips[nX,10],"@E 99,999") //Dias Trabalhados
	@nLin, 137 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Litros de Combustivel
	@nLin, 151 PSay Transform(aEquips[nX,12],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 165 PSay Transform(aEquips[nX,13],"@E 999,999.99") //Media de Consumo
	@nLin, 178 PSay Transform(aEquips[nX,14],"@E 999,999,999,999.99") //Custo do Combustivel
	nLin++;	nLin++

Else

	nLin++;	nLin++
	@nLin, 000 PSay PadL('Total da Geral ---->',58)
	@nLin, 060 PSay Transform(aEquips[nX,06],"@E 999,999,999,999.99") //Qtd. Transportada Um
	@nLin, 080 PSay Transform(aEquips[nX,07],"@E 999,999,999,999.99") //Qtd. Transportada Dois
	@nLin, 126 PSay Transform(aEquips[nX,10],"@E 99,999") //Dias Trabalhados
	@nLin, 137 PSay Transform(aEquips[nX,11],"@E 999,999,999") //Litros de Combustivel
	@nLin, 151 PSay Transform(aEquips[nX,12],"@E 999,999,999") //Contador (Hodometro ou Horimetro)
	@nLin, 165 PSay Transform(aEquips[nX,13],"@E 999,999.99") //Media de Consumo
	@nLin, 178 PSay Transform(aEquips[nX,14],"@E 999,999,999,999.99") //Custo do Combustivel

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


Static Function fBusProd(cCodTra, cCodEqu)
Local aArea    := GetArea()
Local lRetorno := .f.
Local cFilNPO  := ''

nQtdUm   := 0
nQtdDois := 0

//cFilNPO := "NPO_CODTRA == '"+cCodTra+"' .And. "
cFilNPO := "NPO_CODEQU == '"+cCodEqu+"' .And. "
cFilNPO += "NPO_SAFRA == '"+mv_par01+"' .And. "
//Considera Filias
If mv_par08==1
	cFilNPO += "NPO_FILIAL >= '"+MV_PAR09+"' .And. NPO_FILIAL <= '"+MV_PAR10+"'"
Else
	cFilNPO += "NPO_FILIAL == '"+xFilial('NPO')+"'"
EndIf
dbSelectArea('NPO')
dbSetOrder(1)
dbSetFilter( {|| &cFilNPO }, cFilNPO )
dbGotop()
While .Not. eof()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Converte a Primeira Unidade de Medida se Necessario ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
	If Len(AllTrim(mv_par06)) > 0 .And. AllTrim(mv_par06) <> AllTrim(NPO->NPO_UM)
		nQtdUm += AgrX001(AllTrim(NPO->NPO_UM),AllTrim(mv_par06),NPO->NPO_PSSUBT)
	Else
		nQtdUm += NPO->NPO_PSSUBT
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Converte a Segunda Unidade de Medida se Necessario  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ						
	If Len(AllTrim(mv_par07)) > 0 .And. AllTrim(mv_par07) <> AllTrim(NPO->NPO_UM)
		nQtdDois += AgrX001(AllTrim(NPO->NPO_UM),AllTrim(mv_par07),NPO->NPO_PSSUBT)
	Else
		nQtdDois += NPO->NPO_PSSUBT
	Endif

	dbSelectArea('NPO')
	dbSkip()
EndDo

If nQtdUm > 0; lRetorno := .t.; EndIf

RestArea(aArea)
Return(lRetorno)


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

cFilNQD := "NQD_FILIAL >= '"+mv_par09+"' .And. NQD_FILIAL <= '"+mv_par10+"' .And. "
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

