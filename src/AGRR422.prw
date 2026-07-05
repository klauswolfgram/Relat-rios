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

User Function AGRR422()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relacao para Acerto de Frete."
Local titulo         := "Media Consumo/Equipamento"
Local nLin           := 80
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {"Equipamento+Data+Hora"}
Private lEnd        := .f.
Private lAbortPrint := .f.
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := 'AGRR422'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR422"
Private wnrel       := "AGRR422"
Private cString 	:= "NQD"

DbSelectArea("NQD")
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
Local cFilNQD   := ''
Local cFiltUser := aReturn[7]
Local nAndam    := 0
Local nMedia    := 0
Local dDataINI  := CToD('  /  /  ')
Local nQtdPro   := 0
Local nQtdTot   := 0
Local nCntTot   := 0

If mv_par07 <> 1
	mv_par08 := cFilial
	mv_par09 := cFilial
EndIf

//          0         0         0         0         0         0         0         0         0         1         1         1         1         1         1         1         1         1         1         2         2         2
//          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//|Codigo  Placa    | Data  e  Hora  | Safra  | Faz | Arm | Produto | Quantidade |   Contador |  Andamento |      Media | Tipo|
//|######  ###-#### | ##/##/## ##:## | ###### |  ## |  ## |  ###### | ###.###,## | ###.###,## | ###.###,## | ###.###,## |    #|

Cabec1 := "|Codigo  Placa    | Data  e  Hora  | Safra  | Faz | Arm | Produto | Quantidade |   Contador |  Andamento |      Media | Tipo|"
Cabec2 := ""

cFilNQD += "NQD_CODEQU >= '"+mv_par03+"' .And. NQD_CODEQU <= '"+mv_par04+"' .And. "
//cFilNQD += "DToS(NQD_DATA)>= '"+DToS(mv_par03)+"' .And. DToS(NQD_DATA)<= '"+DToS(mv_par04)+"' .And. "
cFilNQD += "NQD_TIPO $ 'I#A#F' .And. "
//Considera Filias
If mv_par07==1
	cFilNQD += "NQD_FILIAL >= '"+mv_par08+"' .And. NQD_FILIAL <= '"+mv_par09+"'"
Else
	cFilNQD += "NQD_FILIAL == '"+xFilial('NQD')+"'"
EndIf
dbSelectArea('NQD')
dbSetOrder(1)
dbSetFilter( {|| &cFilNQD }, cFilNQD )
dbGotop()
While .Not. Eof()

	dbSelectArea('NNB')
	dbSetOrder(1)
	dbSeek(xFilial('NNB')+NQD->NQD_CODEQU)
	If NNB->NNB_CODFAM < mv_par01 .Or. NNB->NNB_CODFAM > mv_par02
		NQD->(dbSkip())
		Loop
	EndIf

	dbSelectArea('NQD')
	While NQD->NQD_CODEQU == NNB->NNB_CODIGO

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Avalia filtro do usuario                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFiltUser).And.!(&cFiltUser)
			NQD->(dbSkip())
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
	   	Endif

		//Define a primeira data e contador encontrado como inicial
		// caso o registro tipo I nao exista.
		If Empty(dDataINI)
			dDataINI := NQD->NQD_DATA
			nContAnt := NQD->NQD_CONT
			nQtdPro  := 0
			nAndam   := 0
			nMedia   := 0
			lPrimo   := .f.
		Else
			nQtdPro  := NQD->NQD_QTDPRO
			nAndam   := NQD->NQD_CONT - nContAnt
			nMedia   := IIf(mv_par10==1,nAndam/nQtdPro,nQtdPro/nAndam)
			nContAnt := NQD->NQD_CONT
		EndIf

		If NQD->NQD_DATA >= mv_par05 .And. NQD->NQD_DATA <= mv_par06
			@nLin, 001 PSay PadL(NQD->NQD_CODEQU,06) //Codigo
			@nLin, 009 PSay PadL(NNB->NNB_PLACA ,08) //Placa
			@nLin, 020 PSay PadL(DToC(NQD->NQD_DATA),08) //Data
			@nLin, 029 PSay PadL(NQD->NQD_HORA  ,05) //Hora
			@nLin, 037 PSay PadL(NQD->NQD_SAFRA ,06) //Safra
			@nLin, 047 PSay PadL(NQD->NQD_FAZ   ,02) //Fazenda
			@nLin, 053 PSay PadL(NQD->NQD_LOCAL ,02) //Armazem
			@nLin, 059 PSay PadL(NQD->NQD_CODPRO,06) //Produto
			@nLin, 068 PSay Transform(nQtdPro        ,'@E 999,999.99') //Quantidade Produto
			@nLin, 081 PSay Transform(NQD->NQD_CONT  ,'@E 999,999.99') //Contador
			@nLin, 094 PSay Transform(nAndam         ,'@E 999,999.99') //Andamento
			@nLin, 107 PSay Transform(nMedia         ,'@E 999,999.99') //Media
			@nLin, 123 PSay PadR(NQD->NQD_TIPO,01) //Media
			nLin++

			nQtdTot += nQtdPro
			nCntTot += nAndam
		EndIf

		dbSelectArea('NQD')
		dbSkip()
	EndDo

	nMedia := IIf(mv_par10==1,nCntTot/nQtdTot,nQtdTot/nCntTot)
	nLin++
	@nLin, 001 PSay PadL('Total do Equipamento: '+PadR(NNB->NNB_DESCRI,30)+' --->',64)
	@nLin, 068 PSay Transform(nQtdTot,'@E 999,999.99') //Quantidade Produto
	@nLin, 094 PSay Transform(nCntTot,'@E 999,999.99') //Andamento
	@nLin, 107 PSay Transform(nMedia ,'@E 999,999.99') //Media
	nLin += 3

	dDataINI := CToD('  /  /  ')
	nQtdTot  := 0
	nCntTot  := 0
	nMedia   := 0

EndDo

RestArea(aArea)

Roda()

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()

