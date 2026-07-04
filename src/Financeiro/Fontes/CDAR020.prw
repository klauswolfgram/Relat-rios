/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CDAR020.ch"
#INCLUDE "PROTHEUS.ch"

Static lFWCodFil := FindFunction("FWCodFil")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CDAR020  ³ Autor ³ Cristiano G. Cunha    ³ Data ³ 10/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Gerencial de Direitos Autorais                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_CDAR020()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACDA - Controle de Direitos Autorais                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CDAR020()


Local nLin       := 80
Local cDesc1     := STR0001 //"Emissao da Prestacao de Contas de Direitos Autorais"
Local cDesc2     := STR0002 //"Serao solicitados os parametros necessarios para a emissao"
Local cDesc3     := STR0003 //"do relatorio."

PRIVATE nLastKey   := 0
PRIVATE Tamanho    := "P"
PRIVATE Titulo     := STR0004 //"Prest. de Contas / Royalties Statement"
PRIVATE cString    := "AH4"
PRIVATE aOrd       := {}
PRIVATE aReturn    := {STR0005,1,STR0006,2,2,1,"",1} //"Zebrado"###"Administracao"
PRIVATE cPerg      := "CDR020"
PRIVATE wnrel      := "CDAR020"
PRIVATE NomeProg   := "CDAR020"
PRIVATE m_pag      := 1
PRIVATE lEnd       := .F.


/*/
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis utilizadas para parametros                         ³
³ mv_par01    // Periodo da Prestacao de Contas MM/AA          ³
³ mv_par02    // Fornecedor Inicial                            ³
³ mv_par03    // Fornecedor Final                              ³
³ mv_par04    // Produto Inicial                               ³
³ mv_par05    // Produto Final                                 ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*/


cLocalProd := Alltrim(SuperGetMv("MV_CDALOC"))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("CDR020",.F.)

dbSelectArea("AH4")
dbSetOrder(4)

dbSelectArea("AH5")
dbSetOrder(1)

dbSelectArea("AH6")
dbSetOrder(1)

dbSelectArea("AH7")
dbSetOrder(1)

dbSelectArea("AH1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

If nLastKey == 27
	Return (.T.)
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
	Return (.T.)
EndIf

RptStatus({|| CD020Imp(@lEnd,wnrel,cString,NomeProg,Titulo)},Titulo)

Return (.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CD020Imp ³ Autor ³ Cristiano G. Cunha    ³ Data ³ 10/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR020                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CD020Imp(lEnd,wnrel,cString,NomeProg,Titulo)

Local cFilIni 		:= Iif(Empty(MV_PAR06),cFilAnt,MV_PAR06)
Local cFilFin 		:= Iif(Empty(MV_PAR07),cFilAnt,MV_PAR07) 
Local cFilOri		:= IIf( lFWCodFil , FWGETCODFILIAL, SM0->M0_CODFIL )
Local aSM0			:= AdmAbreSM0()
Local nContFil		:= 0  

cbTxt       := SPACE(10)
Limite      := 80
cbCont      := 0
cCondFiltr  := aReturn[7]
nLin        := 80

SetRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Controle por filial.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nContFil := 1 to Len(aSM0)
	If aSM0[nContFil][SM0_CODFIL] < cFilIni .Or. aSM0[nContFil][SM0_CODFIL] > cFilFin .Or. aSM0[nContFil][SM0_GRPEMP] != cEmpAnt  
		Loop
	EndIf
	 
	cFilAnt := aSM0[nContFil][SM0_CODFIL]				

	dbSelectArea("AH4")
	DbClearFilter()
	
	CD020Prest()
Next nContFil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna a situacao original.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device to Screen

If aReturn[5] == 1
	Set Printer TO
	dbCommitall()
	OurSpool(wnrel)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Volta a empresa anteriormente selecionada.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cFilAnt := cFilOri

dbSelectArea("AH4")
DbClearFilter()
dbSetOrder(1)

dbSelectArea("AH7")
dbSetOrder(1)

MS_FLUSH()

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³CD020Prest³ Autor ³ Cristiano G. Cunha    ³ Data ³ 10/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao da Prestacao de Contas de Direito Autoral        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CDAR020                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function CD020Prest()
Local i := 0
Local cPictqtd := PesqPict("AH5","AH5_QTDACU")
Local aAreaSM0 := SM0->(GetArea())
Cabec1 := ""
Cabec2 := ""

nTipo  := IIf(aReturn[4] == 1,15,18)
dbSelectArea("AH4")

// Posiciona na tabela para o nome da compania
SM0->(dbSeek(cEmpAnt + cFilAnt))

dPeriodo := LastDay(CTOD("01/" + StrZero(Month(Mv_Par01),2) + "/" + Str(Year(Mv_Par01))))
aTabela := CD040AbrIR()

SetRegua(RecCount())

dbSelectArea("AH5")
dbSetOrder(3)

cChave := " "
dbSelectArea("AH4")
dbSetOrder(4)
dbSeek(xFilial("AH4")+mv_par02,.T.)
While !AH4->(Eof()) .And. AH4->AH4_FORNEC <= mv_par03

	cForneced := AH4->AH4_FORNEC + AH4->AH4_LOJAFO
	nTotGer   := 0
	lImpForne := .F.
	m_pag     := 1
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Emite a Prestacao de Contas Aglutinada por Autor.            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While !AH4->(Eof()) .And. cForneced == AH4->AH4_FORNEC + AH4->AH4_LOJAFO
		
		IncRegua()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIfica se o produto est  dentro do intervalo.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If AH4->AH4_PRODUT < mv_par04 .Or. AH4->AH4_PRODUT > mv_par05 .Or. ;
			AH4->AH4_DTPRES != dPeriodo .Or. AH4->AH4_DATCAL > dPeriodo
			dbSelectArea("AH4")
			dbSkip()
			Loop
		EndIf
		
		If AH4->AH4_FORNEC+AH4->AH4_LOJAFO+AH4->AH4_PRODUT+DTOS(AH4->AH4_DTPRES) == cChave
			dbSelectArea("AH4")
			dbSkip()
			Loop
		Else
			cChave := AH4->AH4_FORNEC+AH4->AH4_LOJAFO+AH4->AH4_PRODUT+DTOS(AH4->AH4_DTPRES)
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIfica se o usuario cancelou o relatorio.                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAbortPrint
			@Prow()+1,001 PSAY STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
		
		dbSelectArea("SA2")
		dbSeek(xFilial("SA2")+cForneced)
		dbSelectArea("SB1")
		dbSeek(xFilial("SB1")+AH4->AH4_PRODUT)
		dbSelectArea("AH6")
		dbSeek(xFilial("AH6")+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO)
		dbSelectArea("AH1")
		dbSeek(xFilial()+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO)
		cMdaRoy := IIF(AH1->AH1_MOEDRO >0 ,AllTrim(Str(AH1->AH1_MOEDRO,2)),"1")
		cMdaOri := IIf(AH1->AH1_MOEDA == "1","1",SuperGetMv("MV_MCUSTO"))
		
		dInicPres := CdDtInPres(AH4->AH4_PRODUT,AH4->AH4_FORNEC,AH4->AH4_LOJAFO,AH4->AH4_DTPRES)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o saldo inicial do produto.                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SB2")
		dbSeek(xFilial("SB2")+AH4->AH4_PRODUT)
		nSaldoIni := 0
		While !SB2->(Eof()) .And. xFilial("SB2")+AH4->AH4_PRODUT == SB2->B2_FILIAL+SB2->B2_COD
			aSaldo := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,dInicPres)
			nSaldoIni += aSaldo[1]
			dbSkip()
		End

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula Saldo Inicial e Final para o Produto + Local                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSaldo    := CalcEst(AH4->AH4_PRODUT,cLocalProd,dInicPres)
		nSaldoIni := aSaldo[1]

		dbSelectArea("AH7")
		dbSeek(xFilial()+AH4->AH4_PRODUT+DTOS(dInicPres),.T.)
		nQtdVenda := 0
		nQtdDevol := 0
		nQtdTrans := 0
		nQtdPromo := 0
		nQtdConsi := 0
		nQtdPerda := 0
		nQtdProdu := 0
		nQtdAcert := 0
		nQtdVdCon := 0
		nQtdDvCon := 0
		nQtdDvVdC := 0
		nSaldoFim := 0
		nQtdOutros:= 0     
		nVendaAut := 0
		nQtdBoni  := 0
		nQtdDoa   := 0

		While !AH7->(Eof()) .And. AH7->AH7_PRODUT == AH4->AH4_PRODUT .And.;
			AH7->AH7_DATCAL <= dPeriodo
			nQtdVenda += AH7->AH7_VENDAS
			nQtdDevol += AH7->AH7_DEVOLU
			nQtdTrans += AH7->AH7_TRANSF
			nQtdPromo += AH7->AH7_PROMOC
			nQtdConsi += AH7->AH7_CONSIG
			nQtdPerda += AH7->AH7_PERDAS
			nQtdProdu += AH7->AH7_PRODUC
			nQtdAcert += (AH7->AH7_ACERTO * -1)
			nQtdVdCon += AH7->AH7_VDACON
			nQtdDvCon += AH7->AH7_DEVCON
			nQtdDvVdC += AH7->AH7_DVVDCO
			nSaldoFim := AH7->AH7_SALDFI
			nQtdBoni  += Iif(AH7->(FieldPos("AH7_BONIFI")) > 0,AH7->AH7_BONIFI,0)
			nVendaAut += Iif(AH7->(FieldPos("AH7_VENDAU")) > 0,AH7->AH7_VENDAU,0)
			nQtdDoa   += Iif(AH7->(FieldPos("AH7_DOACAO")) > 0,AH7->AH7_DOACAO,0)
			dbSkip()
		End

		If GETMV("MV_CDACEST",,"AH7") == "EST"
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula o saldo final do produto.                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SB2")
			dbSeek(xFilial("SB2")+AH4->AH4_PRODUT)
			nSaldoFim := 0
			While !SB2->(Eof()) .And. xFilial("SB2")+AH4->AH4_PRODUT == SB2->B2_FILIAL+SB2->B2_COD
				aSaldo := CalcEst(SB2->B2_COD,SB2->B2_LOCAL,dPeriodo)
				nSaldoFim += aSaldo[1]
				dbSkip()
			End
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula Saldo Inicial e Final para o Produto + Local                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aSaldo    := CalcEst(AH4->AH4_PRODUT,cLocalProd,dPeriodo)
			nSaldoFim := aSaldo[1]
			
		EndIf
                     
		nQtdDvCon  := Abs(nQtdDvCon)
		
		nQtdOutros := nSaldoIni-nQtdVenda+nQtdDevol+nQtdTrans-nQtdPromo-nQtdConsi-nQtdPerda+nQtdProdu+nQtdAcert+nQtdDvCon-nQtdDvVdC-nQtdBoni-nVendaAut-nQtdDoa
		nQtdOutros := nSaldoFim-nQtdOutros
		dbSelectArea("AH4")
		Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
		nLin := 10
		@ nLin,00 PSAY STR0009 //"Autor/Editora"
		nLin := nLin + 1
		@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0010 //"Titulo"
		@ nLin,49 PSAY STR0011 //"| Cod. Produto"
		nLin := nLin + 1
		@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY AH4->AH4_PRODUT
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0012 //"Periodo"
		@ nLin,22 PSAY CdDtInPres(AH4->AH4_PRODUT,AH4->AH4_FORNEC,AH4->AH4_LOJAFO,AH4->AH4_DTPRES)
		@ nLin,34 PSAY STR0013 //"Ate"
		@ nLin,38 PSAY dPeriodo
		@ nLin,49 PSAY STR0014 //"| Observacao"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY Substr(AH1->AH1_OBSERV,1,25)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0015 //"Estoque Anterior"
		@ nLin,35 PSAY nSaldoIni  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY Substr(AH1->AH1_OBSERV,26,25)
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0016 //"(-) Vendas"
		@ nLin,35 PSAY nQtdVenda  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY STR0017 //"Total:Vendas"
		@ nLin,69 PSAY nQtdVenda + nQtdVdCon Picture cPictqtd
		nLin := nLin + 1
		@ nLin,00 PSAY STR0018 //"(+) Devolucoes"
		@ nLin,35 PSAY nQtdDevol  Picture cPictqtd
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0019 //"(-) Livros Defeituosos"
		@ nLin,35 PSAY nQtdTrans  Picture cPictqtd
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0020 //"(-) Cota Autor"
		@ nLin,35 PSAY nQtdPromo  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,50 PSAY Replicate("-",29)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0021 //"(-) Divulgacao"
		@ nLin,35 PSAY nQtdPerda  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY STR0022 //"Agente Literario"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0023 //"(+) Producao"
		@ nLin,35 PSAY nQtdProdu  Picture cPictqtd
		@ nLin,49 PSAY "|"
		dbSelectArea("SA2")
		dbSeek(xFilial("SA2")+AH1->AH1_AGENLI+AH1->AH1_LOJAGE)
		@ nLin,51 PSAY SA2->A2_NOME
		nLin := nLin + 1
		@ nLin,00 PSAY STR0024 //"(+/-) Ajuste de Estoque"
		@ nLin,35 PSAY nQtdAcert  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,50 PSAY Replicate("-",29)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0025 //"(-) Consignacao"
		@ nLin,35 PSAY nQtdConsi  Picture cPictqtd
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0026 //"(+) Devolucao de Consignacao"
		@ nLin,35 PSAY nQtdDvCon  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY STR0027 //"Titulo Original"
		nLin := nLin + 1  

		@ nLin,00 PSAY "(-) Bonificacao"
		@ nLin,35 PSAY nQtdBoni  Picture "@E 999,999,999"
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		
		@ nLin,00 PSAY "(-) Doacao"
		@ nLin,35 PSAY nQtdDoa  Picture "@E 999,999,999"
		@ nLin,49 PSAY "|"
		nLin := nLin + 1

		@ nLin,00 PSAY "(-) Venda p/ Autor"
		@ nLin,35 PSAY nVendaAut  Picture "@E 999,999,999"
		@ nLin,49 PSAY "|"
		nLin := nLin + 1

		@ nLin,00 PSAY STR0028 //"(+/-) Outras Movimentacoes"
		@ nLin,35 PSAY nQtdOutros Picture cPictqtd
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		cTitOrig := IIf(Empty(AH1->AH1_TITORI),SB1->B1_TITORIG,AH1->AH1_TITORI)
		@ nLin,51 PSAY Substr(cTitOrig,1,28)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0029 //"Estoque Atual"
		@ nLin,35 PSAY nSaldoFim  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,51 PSAY Substr(cTitOrig,29,28)
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0030 //"Venda de Consignacao"
		@ nLin,35 PSAY nQtdVdCon  Picture cPictqtd
		@ nLin,49 PSAY "|"
		@ nLin,50 PSAY Replicate("-",29)
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0031 //"Devolucao de Venda de Consignacao"
		@ nLin,35 PSAY nQtdDvVdC  Picture cPictqtd
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("_",Limite)
		nLin := nLin + 1
   //	@ nLin,03 PSAY "|"
   //	@ nLin,49 PSAY "|"
   //	nLin := nLin + 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Demonstracao da venda bruta, junto com o direito autoral.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cSimbMda := Substr(SuperGetMv("MV_SIMB" + cMdaRoy),1,3)
		@ nLin,00 PSAY STR0032 //"(A)| Venda : "
		@ nLin,49 PSAY STR0033 //"| Direito Autoral :"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0034 //"   | Exemplares | Pr.Unit.- "
		@ nLin,28 PSAY cSimbMda
		@ nLin,32 PSAY STR0035 //"|        Total "
		@ nLin,49 PSAY "|    %   |              " + cSimbMda
		nLin := nLin + 1
		@ nLin,03 PSAY "|------------|---------------|----------------|--------|--------------------"
		nLin := nLin + 1
		nTotLiq  := 0
		nTotRoy  := 0
		aDevolu1 := {}
		aDevolu  := {}
		aDireitos:= {}
		nQtdDev  := 0
		nVlDev   := 0
		nValorT  := 0
		
		dbSelectArea("AH5")
		dbSeek(xFilial("AH5")+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+DTOS(dPeriodo))
		While !AH5->(Eof()) .And. xFilial("AH5")+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+DTOS(dPeriodo) ==;
			AH5->AH5_FILIAL+AH5->AH5_PRODUT+AH5->AH5_FORNEC+AH5->AH5_LOJAFO+DTOS(AH5->AH5_DTPRES)
			nFaixaFim := AH5->AH5_FXFINA
			nPrecPesq := AH5->AH5_PRECOU     // Preco Unitario para Pesquisa
			nPerceDA  := AH5->AH5_PERCDA
			nPrecoUn  := xMoeda(AH5->AH5_PRECOU,Val(cMdaOri),Val(cMdaRoy),AH4->AH4_DTPRES)
			nAcQtdes  := 0
			nAcValDA  := 0
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula valores enquanto for mesmo preco e % de D.A.         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			While !AH5->(Eof()) .And. xFilial("AH5")+AH4->AH4_PRODUT+AH4->AH4_FORNEC+AH4->AH4_LOJAFO+DTOS(dPeriodo) ==; 
					AH5->AH5_FILIAL+AH5->AH5_PRODUT+AH5->AH5_FORNEC+AH5->AH5_LOJAFO+DTOS(AH5->AH5_DTPRES) .And.;
					NoRound(nFaixaFim) == NoRound(AH5->AH5_FXFINA) .And. nPrecPesq == AH5->AH5_PRECOU
				If AH5->AH5_PERCDA != 0
					nValDAIt := xMoeda(AH5->AH5_VALORD,Val(cMdaOri),Val(cMdaRoy),AH4->AH4_DTPRES)
				Else
					nValDAIt := AH5->AH5_VALORD
				EndIf
				
				If AH5->AH5_QTDACU > 0
					nAcQtdes := nAcQtdes + AH5->AH5_QTDACU
					nAcValDA := nAcValDA + nValDAIt
				
					nElement := aScan(aDireitos,{|x| x[4]==AH5->AH5_PERCDA .And. x[2] == nPrecoUn})
					If nElement == 0
						aAdd(aDireitos,{AH5->AH5_QTDACU,nPrecoUn,nValDAIt,AH5->AH5_PERCDA})
					Else
						aDireitos[nElement][1] += AH5->AH5_QTDACU
						aDireitos[nElement][3] += nValDAIt
					Endif
				ElseIf AH5->AH5_QTDACU < 0
					nElement := aScan(aDevolu, {|x| x[2] == nPrecoUn .And. x[3] == AH5->AH5_PERCDA})
					If nElement == 0
						aAdd(aDevolu,{AH5->AH5_QTDACU,nPrecoUn,AH5->AH5_PERCDA,nValDAIt})
					Else
						aDevolu[nElement][1] += AH5->AH5_QTDACU
						aDevolu[nElement][4] += nValDAIt
					EndIf
				EndIf
				
				dbSelectArea("AH5")
				dbSkip()
			End
		End
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Demonstracao dos direitos autorais                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For i := 1 to Len(aDireitos)
			nValor := AH5->AH5_QTDACU * nPrecoUn
			If nLin > 60
				Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
				nLin := 10
				@ nLin,00 PSAY STR0009 //"Autor/Editora"
				nLin := nLin + 1
				@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
				@ nLin,00 PSAY STR0010 //"Titulo"
				@ nLin,49 PSAY STR0011 //"| Cod. Produto"
				nLin := nLin + 1
				@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
				@ nLin,49 PSAY "|"
				@ nLin,51 PSAY AH4->AH4_PRODUT
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ nValDAIt -> Valor do direito autoral por item.               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nValor := aDireitos[i][1] * aDireitos[i][2]
			
			If aDireitos[i][1] > 0
				@ nLin,03 PSAY "|"
				@ nLin,04 PSAY aDireitos[i][1]	Picture cPictqtd
				@ nLin,16 PSAY "|"
				@ nLin,17 PSAY aDireitos[i][2]	Picture "@E 999,999,999.99"
				@ nLin,32 PSAY "|"
				@ nLin,33 PSAY nValor			Picture "@E 9,999,999,999.99"
				@ nLin,49 PSAY "|"
				If aDireitos[i][4]<>0
					@ nLin,51 PSAY aDireitos[i][4]	Picture "@E 999.99"
				Endif
				@ nLin,58 PSAY "|"
				@ nLin,62 PSAY aDireitos[i][3]	Picture "@E 9999,999,999.99"
				nLin := nLin + 1
				nTotLiq += nValor
				nTotRoy += aDireitos[i][3]
			EndIf
		Next
		
		@ nLin,03 PSAY "|            |               |                |        |"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0036 //"(B)| Devolucao :"
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
//		@ nLin,03 PSAY "|            |               |                |        |"
//		nLin := nLin + 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Demonstracao das devolucoes, junto com o direito autoral.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		For i := 1 To Len(aDevolu)
			If nLin > 60
				Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
				nLin := 10
				@ nLin,00 PSAY STR0009 //"Autor/Editora"
				nLin := nLin + 1
				@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
				@ nLin,00 PSAY STR0010 //"Titulo"
				@ nLin,49 PSAY STR0011 //"| Cod. Produto"
				nLin := nLin + 1
				@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
				@ nLin,49 PSAY "|"
				@ nLin,51 PSAY AH4->AH4_PRODUT
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
			EndIf
			nValor := aDevolu[i][1] * aDevolu[i][2]
			
			If aDevolu[i][1] != 0
				@ nLin,03 PSAY "|"
				@ nLin,04 PSAY aDevolu[i][1]*-1 Picture cPictqtd
				@ nLin,16 PSAY "|"
				@ nLin,17 PSAY aDevolu[i][2]    Picture "@E 999,999,999.99"
				@ nLin,32 PSAY "|"
				@ nLin,33 PSAY nValor*-1        Picture "@E 9,999,999,999.99"
				@ nLin,49 PSAY "|"
				@ nLin,51 PSAY aDevolu[i][3]    Picture "@E 999.99"
				@ nLin,58 PSAY "|"
				@ nLin,62 PSAY aDevolu[i][4]    Picture "@E 9999,999,999.99"
				nLin := nLin + 1
				nTotLiq += nValor
				nTotRoy += aDevolu[i][4]
			EndIf
		Next
		@ nLin,03 PSAY "|            |               |                |        |"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		
		If nLin > 55
			Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
			nLin := 10
			@ nLin,00 PSAY STR0009 //"Autor/Editora"
			nLin := nLin + 1
			@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
			@ nLin,00 PSAY STR0010 //"Titulo"
			@ nLin,49 PSAY STR0011 //"| Cod. Produto"
			nLin := nLin + 1
			@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
			@ nLin,49 PSAY "|"
			@ nLin,51 PSAY AH4->AH4_PRODUT
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
		EndIf
		nTotAux := nTotRoy
		If AH4->AH4_QTDADI == 0 .And. AH4->AH4_VALADI > 0
			nTotAux -= AH4->AH4_VALADI
		EndIf
		nTotRoy := Round(nTotRoy,2)
		
		@ nLin,00 PSAY STR0037 //"(C)| Valor de Direitos Autorais (A-B)"
		@ nLin,58 PSAY "|"
		@ nLin,59 PSAY cSimbMda
		@ nLin,62 PSAY nTotRoy Picture "@E 9999,999,999.99"
		nLin := nLin + 1
		
		nValor := nTotRoy / IIf(nTotLiq == 0,1,nTotLiq) * 100
		
		@ nLin,00 PSAY Replicate("_",Limite)
		nLin := nLin + 1
		If nLin > 55
			Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
			nLin := 10
			@ nLin,00 PSAY STR0009 //"Autor/Editora"
			nLin := nLin + 1
			@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
			@ nLin,00 PSAY STR0010 //"Titulo"
			@ nLin,49 PSAY STR0011 //"| Cod. Produto"
			nLin := nLin + 1
			@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
			@ nLin,49 PSAY "|"
			@ nLin,51 PSAY AH4->AH4_PRODUT
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
		EndIf
		
		If AH4->AH4_VALADI > 0 .Or. AH4->AH4_QTDADI > 0
			@ nLin,03 PSAY "|            |                                         |"
			nLin := nLin + 1
			@ nLin,00 PSAY STR0038 //"(D)|Exemplares  | Saldo de Adiantamento                   |   Valor         "
			nLin := nLin + 1
			@ nLin,03 PSAY "|"
			If AH4->AH4_QTDADI > 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Demonstracao do adiantamento em quantidade.                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				@ nLin,04 PSAY AH4->AH4_QTDADI Picture PesqPict("AH4","AH4_QTDADI")
				@ nLin,16 PSAY "|"
				@ nLin,58 PSAY "|"
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
				@ nLin,03 PSAY STR0039 //"|            | Saldo Atual de Adiantamento (D - C)   |"
				nLin := nLin + 1
				If ((nQtdVenda + nQtdVdCon) - nQtdDevol) > 0
					nSaldAdto := AH4->AH4_QTDADI - (nQtdVenda + nQtdVdCon) + nQtdDevol
				Else
					nSaldAdto := AH4->AH4_QTDADI
				EndIf
				If nSaldAdto < 0
					nSaldAdto := 0
				EndIf
				@ nLin,03 PSAY "|"
				@ nLin,04 PSAY nSaldAdto Picture PesqPict("AH4","AH4_QTDADI")
			ElseIf AH4->AH4_VALADI > 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Demonstracao do adiantamento em valor.                       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectArea("AH3")
				dbSeek(xFilial("AH3")+AH4->AH4_PRODUT+cForneced)
				@ nLin,16 PSAY "|"
				@ nLin,58 PSAY "|"
				@ nLin,59 PSAY cSimbMda
				@ nLin,62 PSAY AH4->AH4_VALADI Picture "@E 9999,999,999.99"
				nLin := nLin + 1
				@ nLin,00 PSAY Replicate("-",Limite)
				nLin := nLin + 1
				@ nLin,03 PSAY STR0040 //"|            | Saldo Atual de Adiantamento (D - C)     |"
				nLin := nLin + 1
				nSaldAdto := AH4->AH4_VALADI - nTotRoy
				If nSaldAdto < 0
					nSaldAdto := 0
				ElseIf nTotRoy < 0
					nSaldAdto := AH4->AH4_VALADI
				EndIf
				@ nLin,03 PSAY "|"
//				@ nLin,16 PSAY "| Current Balance Advance (D - C)         |"
				@ nLin,59 PSAY cSimbMda
				@ nLin,62 PSAY nSaldAdto Picture "@E 9999,999,999.99"
				If nTotAux <= 0 .And. nTotRoy >= 0
					nTotRoy := 0
				ElseIf nTotAux > 0
					nTotRoy := nTotAux
				EndIf
			EndIf
			
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("_",Limite)
			nLin := nLin + 1
		EndIf
		nTotGer += nTotRoy
		If nLin > 55
			Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
			nLin := 10
			@ nLin,00 PSAY STR0009 //"Autor/Editora"
			nLin := nLin + 1
			@ nLin,00 PSAY SA2->A2_COD + " - " + SA2->A2_NOME
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
			@ nLin,00 PSAY STR0010 //"Titulo"
			@ nLin,49 PSAY STR0011 //"| Cod. Produto"
			nLin := nLin + 1
			@ nLin,00 PSAY Substr(SB1->B1_DESC,1,48)
			@ nLin,49 PSAY "|"
			@ nLin,52 PSAY AH4->AH4_PRODUT
			nLin := nLin + 1
			@ nLin,00 PSAY Replicate("-",Limite)
			nLin := nLin + 1
		EndIf
		@ nLin,58 PSAY "|"
		nLin := nLin + 1
		@ nLin,05 PSAY STR0041 //"Valor Dir. Autorais a Pagar"
		@ nLin,58 PSAY "|"
		@ nLin,59 PSAY cSimbMda
		@ nLin,62 PSAY nTotRoy Picture "@E 9999,999,999.99"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("_",Limite)
		
		lImpForne := .T.
		
		dbSelectArea("AH4")
		dbSkip()
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do total a ser pago ao autor de todas as prestacoes   ³
	//³ do periodo solicitado.                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lImpForne
		Cabec(SM0->M0_NOMECOM,PADC(STR0008,Limite),"",NomeProg,Tamanho,nTipo) //"Prestacao de Contas"
		nLin := 10
		@ nLin,00 PSAY STR0042 //"Autor"
		@ nLin,49 PSAY STR0043 //"| Editora"
		nLin := nLin + 1
		dbSelectArea("SA2")
		dbSeek(xFilial("SA2")+cForneced)
		@ nLin,00 PSAY SA2->A2_NOME
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0044 //"(Resumo)"
		@ nLin,49 PSAY STR0045 //"| Credito/Debito"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,31 PSAY STR0046 //"Total Geral ..... |"
		@ nLin,52 PSAY SuperGetMv("MV_SIMB" + cMdaRoy)
		@ nLin,56 PSAY nTotGer Picture "@E 999,999,999.99"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
		@ nLin,00 PSAY STR0047 //"(Deducoes/Deductions)"
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0048 //"Imposto de Renda"
		@ nLin,49 PSAY "|"
		If SA2->A2_TIPO == "F" .And. nTotGer > 0    // Pessoa Fisica
			nTotGerIR  := xMoeda(nTotGer,Val(cMdaRoy),1,AH4->AH4_DTPRES)
			nValIRRF   := CD040CalIR(nTotGerIR, dPeriodo, .F.)
			nValIRRF := xMoeda(nValIRRF,Val(cMdaOri),Val(cMdaRoy),AH4->AH4_DTPRES)
		Else
			nValIRRF := 0
		EndIf
		If SA2->A2_TXTRIBU > 0 .And. nTotGer > 0
			nValIRRF := nValIRRF + Round(nTotGer * SA2->A2_TXTRIBU / 100,2)
		EndIf
		nTotGer -= nValIRRF
		@ nLin,52 PSAY SuperGetMv("MV_SIMB" + cMdaRoy)
		@ nLin,56 PSAY nValIRRF Picture "@E 999,999,999.99"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0049 //"Total a Pagar"
		@ nLin,49 PSAY "|"
		@ nLin,52 PSAY SuperGetMv("MV_SIMB" + cMdaRoy)
		If nTotGer >= 0
			@ nLin,56 PSAY nTotGer Picture "@E 999,999,999.99"
		EndIf
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,49 PSAY "|"
		nLin := nLin + 1
		@ nLin,00 PSAY STR0050 //"(Saldo Devedor)"
		@ nLin,49 PSAY "|"
		@ nLin,52 PSAY SuperGetMv("MV_SIMB" + cMdaRoy)
		If nTotGer < 0
			@ nLin,56 PSAY nTotGer Picture "@E 999,999,999.99"
		EndIf
		nLin := nLin + 2
		@ nLin,00 PSAY Replicate("-",Limite)
		nLin := nLin + 1
	EndIf
End
RestArea(aAreaSM0)
Return (.T.)     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³AdmAbreSM0³ Autor ³ Orizio                ³ Data ³ 22/01/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AdmAbreSM0()
Local aArea			:= SM0->( GetArea() )
Local aAux			:= {}
Local aRetSM0		:= {}
Local lFWLoadSM0	:= FindFunction( "FWLoadSM0" )
Local lFWCodFilSM0 	:= FindFunction( "FWCodFil" )

If lFWLoadSM0
	aRetSM0	:= FWLoadSM0()
Else
	DbSelectArea( "SM0" )
	SM0->( DbGoTop() )
	While SM0->( !Eof() )
		aAux := { 	SM0->M0_CODIGO,;
					IIf( lFWCodFilSM0, FWGETCODFILIAL, SM0->M0_CODFIL ),;
					"",;
					"",;
					"",;
					SM0->M0_NOME,;
					SM0->M0_FILIAL }

		aAdd( aRetSM0, aClone( aAux ) )
		SM0->( DbSkip() )
	End
EndIf

RestArea( aArea )
Return aRetSM0         

