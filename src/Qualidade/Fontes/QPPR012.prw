/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QPPR012.CH"
#INCLUDE "PROTHEUS.CH"
#include "AP5MAIL.CH"

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR012	  ³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Impressao Total do PPAP              	  				    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR012()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Void                                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAPPAP				                 					    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS  ³ MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR012

Local cPecaRev	:= ""
Local lPergunte	:= .F.
Local lEquipe	:= .F.   
Local lJPEG     := .F.

Private aAttach    := {} 
Private cStartPath := GetSrvProfString("Startpath","")
Private cAttach    := ""
Private lFMEA4A := GetMV("MV_QVEFMEA",.T.,"3") == "4" //FMEA 4a. EDICAO...

DbSelectArea("QKM")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros							³
//³ mv_par01				// Peca        	   						³
//³ mv_par02				// Revisao         						³
//³ mv_par03  				// Todo PPAP Sim/Nao   					³
//³ mv_par04  				// Cronograma Sim/Nao 					³
//³ mv_par05  				// Viabilidade Sim/Nao 					³
//³ mv_par06  				// Estudo de RR Sim/Nao     			³
//³ mv_par07  				// Capabilidade Sim/Nao					³
//³ mv_par08  				// Ensaio Dimensional Sim/Nao   		³
//³ mv_par09  				// Ensaio Material Sim/Nao              ³
//³ mv_par10  				// Ensaio Desempenho Sim/Nao            ³
//³ mv_par11  				// Aprovac. Aparencia                 	³
//³ mv_par12  				// Certif. Submissao                 	³
//³ mv_par13  				// Plano de Controle                 	³
//³ mv_par14  				// FMEA Projeto                 		³
//³ mv_par15  				// FMEA Processo                 		³
//³ mv_par16  				// Sumario e APQP                 		³
//³ mv_par17  				// Diagrama de Fluxo                 	³
//³ mv_par18  				// Aprovacao Interina-GM                ³
//³ mv_par19  				// Checklist APQP A1 A8                 ³
//³ mv_par20  				// Checklist Granel                     ³
//³ mv_par21  				// PSA                                  ³
//³ mv_par22  				// VDA                                  ³
//³ mv_par23  				// Envia por email ? (S=Sim, N=Nao)     ³
//³ mv_par24  				// Fase de Produção?  Prototipo         |
//|							    				  Pre-Lancamento    |
//|												  Produção          |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

lPergunte := Pergunte("PPR012",.T.)

If lPergunte
	cPecaRev := mv_par01 + mv_par02	
Else
	Return Nil
Endif

lJPEG := IIF(mv_par23 == 1,.T.,.F.)

DbSelectArea("QK1")
DbSetOrder(1)

If DbSeek(xFilial()+cPecaRev)
	lEquipe := !Empty(QK1->QK1_CODEQU)
	Processa({|| U_QPPR012PROC(cPecaRev,lEquipe,lJPEG)})
Endif

Return Nil

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR012PROC³ Autor ³ Robson Ramiro A. Olive³ Data ³ 26/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a impressao Total                       			    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR012PROC()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 : Peca e Revisao                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAPPAP				                 					    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function QPPR012PROC(cPecaRev,lEquipe,lJPEG)

Local nQtde		:= 0
Local aCarac 	:= {}
Local nCont		:= 0
Local x			:= 0
Local nPos		:= 0
Local nSeq		:= 0
Local cFiltro	:= ""
Local cSeqQKB 	:= "000"
Local cSeqQKC 	:= "000"
Local cSeqQKD 	:= "000"
Local cArqTmp   := ""

For nCont := 4 To 22
	x := StrZero(nCont,2)
	If mv_par&(x) == 1
		nQtde++
	Endif
Next nCont

If mv_par03 == 1
	nQtde := 19
Endif

If nQtde == 0
	Return Nil
Endif

QK2->(DbSetOrder(1))
QK2->(DbSeek(xFilial("QK2")+cPecaRev))

Do While QK2->(!Eof()) .and. cPecaRev == QK2->QK2_PECA + QK2->QK2_REV;
						.and. xFilial("QK2") == QK2->QK2_FILIAL
	aAdd(aCarac, {QK2->QK2_CODCAR,"  "})
	QK2->(DbSkip())
Enddo

QK9->(DbSetOrder(1))
QK9->(DbSeek(xFilial("QK9")+cPecaRev))

Do While QK9->(!Eof()) .and. cPecaRev == QK9->QK9_PECA + QK9->QK9_REV; 
						.and. xFilial("QK9") == QK9->QK9_FILIAL
						
	nPos := aScan(aCarac, {|x| x[1] == QK9->QK9_CARAC})

	If nPos <> 0
		aCarac[nPos,2] := QK9->QK9_SEQ  //Guarda apenas a Maior Sequencia
	Endif

	QK9->(DbSkip())
Enddo

cFiltro := "QKB->QKB_ITEM == '"+StrZero(1,Len(QKB->QKB_ITEM))+"'"

QKB->(DbSetFilter({|| &cFiltro }, cFiltro))
QKB->(DbSetOrder(1))
QKB->(DbSeek(xFilial("QKB")+cPecaRev))

Do While QKB->(!Eof()) .and. cPecaRev == QKB->QKB_PECA + QKB->QKB_REV; 
						.and. xFilial("QKB") == QKB->QKB_FILIAL
						
	cSeqQKB := QKB->QKB_SEQ  //Guarda apenas a Maior Sequencia
	QKB->(DbSkip())

Enddo

QKB->(DbClearFilter())

cFiltro := "QKC->QKC_ITEM == '"+StrZero(1,Len(QKC->QKC_ITEM))+"'"

QKC->(DbSetFilter({|| &cFiltro }, cFiltro))
QKC->(DbSetOrder(1))
QKC->(DbSeek(xFilial("QKC")+cPecaRev))

Do While QKC->(!Eof()) .and. cPecaRev == QKC->QKC_PECA + QKC->QKC_REV; 
						.and. xFilial("QKC") == QKC->QKC_FILIAL
						
	cSeqQKC := QKC->QKC_SEQ  //Guarda apenas a Maior Sequencia
	QKC->(DbSkip())

Enddo

QKC->(DbClearFilter())

cFiltro := "QKD->QKD_ITEM == '"+StrZero(1,Len(QKD->QKD_ITEM))+"'"

QKD->(DbSetFilter({|| &cFiltro }, cFiltro))
QKD->(DbSetOrder(1))
QKD->(DbSeek(xFilial("QKD")+cPecaRev))

Do While QKD->(!Eof()) .and. cPecaRev == QKD->QKD_PECA + QKD->QKD_REV; 
						.and. xFilial("QKC") == QKD->QKD_FILIAL
						
	cSeqQKD := QKD->QKD_SEQ  //Guarda apenas a Maior Sequencia
	QKD->(DbSkip())

Enddo

QKD->(DbClearFilter())

If lEquipe
	nQtde++
Endif

ProcRegua(nQtde)

If mv_par04 == 1 .or. mv_par03 == 1		// Cronograma
	IncProc(STR0001+STR0002) //"Imprimindo "###"Cronograma"
	cArqTmp := CriaTrab(,.F.)
	QPPR110(Nil,cPecaRev,IIF(lJPEG,cArqTmp,"")) 
	U_QPPR012ATT(cArqTmp," - QPPR110 - "+STR0002)
Endif

If mv_par05 == 1 .or. mv_par03 == 1		// Viabilidade
	IncProc(STR0001+STR0003) //"Imprimindo "###"Viabilidade"
	cArqTmp := CriaTrab(,.F.)
	QPPR140(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR140 - "+STR0003)
Endif

If mv_par06 == 1 .or. mv_par03 == 1		// Estudo de RR
	IncProc(STR0001+STR0004) //"Imprimindo "###"RR"
	For nCont := 1 To Len(aCarac)
		cArqTmp := CriaTrab(,.F.)
		QMTR150(Nil,cPecaRev+aCarac[nCont,1],IIF(lJPEG,cArqTmp+Alltrim(Str(nCont)),""))
		U_QPPR012ATT(cArqTmp+Alltrim(Str(nCont))," - QMTR150 - "+STR0004)
	Next nCont
Endif

If mv_par07 == 1 .or. mv_par03 == 1		// Capabilidade
	IncProc(STR0001+STR0005) //"Imprimindo "###"Capabilidade"
	For nCont := 1 To Len(aCarac)
		For nSeq := 0 To Val(aCarac[nCont,2])
			cArqTmp := CriaTrab(,.F.)
			QPPR170(Nil,Nil,cPecaRev+aCarac[nCont,1]+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nCont))+Alltrim(Str(nSeq)),""))
			U_QPPR012ATT(cArqTmp+Alltrim(Str(nCont))+Alltrim(Str(nSeq))," - QPPR170 - "+STR0005)
		Next nSeq
	Next nCont
Endif



If mv_par08 == 1 .or. mv_par03 == 1		// Ensaio Dimensional
	IncProc(STR0001+STR0006) //"Imprimindo "###"Ensaio Dimensional"	
	For nSeq := 0 To Val(cSeqQKB)
		cArqTmp := CriaTrab(,.F.)
		QPPR180(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nSeq)),""))
		U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR180 - "+STR0006)
	Next nSeq
	Pergunte("PPR012",.F.)
Endif

If mv_par09 == 1 .or. mv_par03 == 1		// Ensaio Material
	IncProc(STR0001+STR0007) //"Imprimindo "###"Ensaio Material"
	For nSeq := 0 To Val(cSeqQKD)
		cArqTmp := CriaTrab(,.F.)
		QPPR190(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nSeq)),""))
		U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR190 - "+STR0007)
	Next nSeq
Endif

If mv_par10 == 1 .or. mv_par03 == 1		// Ensaio Desempenho
	IncProc(STR0001+STR0008) //"Imprimindo "###"Ensaio Desempenho"
	For nSeq := 0 To Val(cSeqQKC)
		cArqTmp := CriaTrab(,.F.)
		QPPR200(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nSeq)),""))
		U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR200 - "+STR0008)
	Next nSeq
Endif

If mv_par11 == 1 .or. mv_par03 == 1		// Aprovac. Aparencia
	IncProc(STR0001+STR0009) //"Imprimindo "###"Aprovacao de Aparencia"
	cArqTmp := CriaTrab(,.F.)
	QPPR210(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR210 - "+STR0009)
Endif

If mv_par12 == 1 .or. mv_par03 == 1 	// Certif. Submissao
	IncProc(STR0001+STR0010) //"Imprimindo "###"Certificado de Submissao"
	cArqTmp := CriaTrab(,.F.)
	QPPR220(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR220 - "+STR0010)
Endif

If mv_par13 == 1 .or. mv_par03 == 1		// Plano de Controle
	IncProc(STR0001+STR0011) //"Imprimindo "###"Plano de Controle"
	cArqTmp := CriaTrab(,.F.)
	QPPR160(Nil,cPecaRev+AllTrim(STR(mv_par24-1)),IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR160 - "+STR0011)
Endif

If mv_par14 == 1 .or. mv_par03 == 1 	// FMEA Projeto
	IncProc(STR0001+STR0012) //"Imprimindo "###"FMEA de Projeto"
	cArqTmp := CriaTrab(,.F.)
	If lFMEA4a
		QPPR370(Nil,IIf(mv_par25 == 2,.T.,.F.),cPecaRev,IIF(lJPEG,cArqTmp,.F.),IIf(mv_par25 == 2,.T.,.F.))
		U_QPPR012ATT(cArqTmp," - QPPR370 - "+STR0012)
	Else
		QPPR120(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
		U_QPPR012ATT(cArqTmp," - QPPR120 - "+STR0012)
	Endif
Endif

If mv_par15 == 1 .or. mv_par03 == 1 	// FMEA Processo
	IncProc(STR0001+STR0013) //"Imprimindo "###"FMEA de Processo"
	cArqTmp := CriaTrab(,.F.)        
	If lFMEA4a
		QPPR380(Nil,IIf(mv_par25 == 2,.T.,.F.),cPecaRev,IIF(lJPEG,cArqTmp,.F.),IIf(mv_par25 == 2,.T.,.F.))
		U_QPPR012ATT(cArqTmp," - QPPR380 - "+STR0013)
	Else
		QPPR130(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
		U_QPPR012ATT(cArqTmp," - QPPR130 - "+STR0013)
	Endif
Endif

If mv_par16 == 1 .or. mv_par03 == 1		// Sumario e APQP
	IncProc(STR0001+STR0014) //"Imprimindo "###"Sumario e APQP"
	cArqTmp := CriaTrab(,.F.)
	QPPR230(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR230 - "+STR0014)
Endif

If mv_par17 == 1 .or. mv_par03 == 1		// Diagrama de Fluxo
	IncProc(STR0001+STR0015) //"Imprimindo "###"Diagrama de Fluxo"
	cArqTmp := CriaTrab(,.F.)
	QPPR150(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR150 - "+STR0015)
Endif

If mv_par18 == 1 .or. mv_par03 == 1 	// Aprovacao Interina-GM
	IncProc(STR0001+STR0016) //"Imprimindo "###"Aprovacao Interina-GM"
	cArqTmp := CriaTrab(,.F.)
	QPPR240(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR240 - "+STR0016)
Endif

If mv_par19 == 1 .or. mv_par03 == 1		// Checklist APQP A1 A8
	IncProc(STR0001+STR0017) //"Imprimindo "###"Checklist APQP A1 A8"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR250(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR250 - "+STR0022) //"Checklist APQP A1"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR260(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR260 - "+STR0023) //"Checklist APQP A2"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR270(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR270 - "+STR0024) //"Checklist APQP A3"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR280(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR280 - "+STR0025) //"Checklist APQP A4"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR290(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR290 - "+STR0026) //"Checklist APQP A5"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR300(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR300 - "+STR0027) //"Checklist APQP A6"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR310(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR310 - "+STR0028) //"Checklist APQP A7"
	
	cArqTmp := CriaTrab(,.F.)
	QPPR320(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR320 - "+STR0029) //"Checklist APQP A8"
Endif

If mv_par20 == 1 .or. mv_par03 == 1		// Checklist Granel
	IncProc(STR0001+STR0018) //"Imprimindo "###"Checklist Granel"
	cArqTmp := CriaTrab(,.F.)
	QPPR330(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR330 - "+STR0018)
Endif

If mv_par21 == 1 .or. mv_par03 == 1		// PSA
	IncProc(STR0001+STR0019) //"Imprimindo "###"PSA"
	cArqTmp := CriaTrab(,.F.)
	QPPR340(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR340 - "+STR0019)
Endif

If mv_par22 == 1 .or. mv_par03 == 1  	// VDA
	IncProc(STR0001+STR0020) //"Imprimindo "###"VDA"
	cArqTmp := CriaTrab(,.F.)
	QPPR350(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR350 - "+STR0020)
	cArqTmp := CriaTrab(,.F.)
	QPPR360(Nil,cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR360 - "+STR0020)
	
	For nSeq := 0 To Val(cSeqQKB)
			cArqTmp := CriaTrab(,.F.)
			QPPR180V(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nSeq)),""))
			U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR180V - "+STR0020)
	Next nSeq

	For nSeq := 0 To Val(cSeqQKD)
			cArqTmp := CriaTrab(,.F.)
			QPPR190V(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,"QPPR190V"+Alltrim(Str(nSeq)),""))
			U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR190V - "+STR0020)
	Next nSeq
	
	For nSeq := 0 To Val(cSeqQKC)
			cArqTmp := CriaTrab(,.F.)
			QPPR200V(Nil,cPecaRev+StrZero(nSeq,3),IIF(lJPEG,cArqTmp+Alltrim(Str(nSeq)),""))
			U_QPPR012ATT(cArqTmp+Alltrim(Str(nSeq))," - QPPR200V - "+STR0020)
	Next nSeq
Endif

If lEquipe
	IncProc(STR0001+STR0021)	//"Imprimindo "###"Equipe Multifuncional" 
	cArqTmp := CriaTrab(,.F.)
	QPPR040(.F., cPecaRev,IIF(lJPEG,cArqTmp,""))
	U_QPPR012ATT(cArqTmp," - QPPR040 - "+STR0021)
Endif

If lJPEG 
	U_QPPR012MAIL()      
Endif

Return Nil

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR012ATT ³ Autor ³ Cleber Souza          ³ Data ³ 26/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Pesquisa todos os arquivos gerados para esse relatorio.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR012ATT(cNome,cTexto)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAPPAP				                 					    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QPPR012ATT(cNome,cTexto)

Local aArqAux  := {}
Local nY       := 0

aArqAux := Directory(cStartPath+cNome+"*.jpg") 

For nY:=1 to Len(aArqAux)      
	AADD(aAttach,{aArqAux[nY,1],cTexto}) 
	If !Empty(cAttach)	
		cAttach +=";"
	EndIf
	cAttach +=cStartPath+aArqAux[nY,1]
Next nY

Return 

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR012MAIL³ Autor ³ Cleber Souza          ³ Data ³ 26/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Rotina de envio do email com os JPEGs.          			    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR012MAIL()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAPPAP				                 					    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QPPR012MAIL() 

Local aArq    := {}  
Local aDados  := U_QPPR012TO() 
Local cBody   := "" 
Local aUsrMat := QA_USUARIO() 
Local nY      := 0 

//Valida digitação dos destinatarios.
If Empty(aDados[1])
	Return
EndIF	

//Gerando Corpo do Email com os Relatorios gerados.
If !Empty(aDados[2])
	cBody := Alltrim(aDados[2])
	cBody += CHR(13)+CHR(10)+CHR(13)+CHR(10)
EndIF
 
//Verifica se envia lista dos arquivos gerados.
If aDados[3]
	cBody += STR0030+CHR(13)+CHR(10)+CHR(13)+CHR(10) //"Foram gerados os seguintes relatorios : "
	For nY:=1 to Len(aAttach)
		cBody += aAttach[nY,1]+aAttach[nY,2]+CHR(13)+CHR(10)
	Next nY
EndIF

//Monta dados para envio do email.
AADD(aArq,{" - Peca : "+Alltrim(MV_PAR01)+"\"+MV_PAR02+Space(2)+Alltrim(QK1->QK1_DESC),cBody,cAttach}) 
aUsuarios := {{"",aDados[1],aArq} }

QaEnvMail(aUsuarios,,,,aUsrMat[5])    


//Deleta arquivos JPEG gerados pelos relatorios.                          
For nY:=1 to Len(aAttach)
	FErase( cStartPath+aAttach[nY,1] )
Next nY 	

Return               

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ QPPR012TO³ Autor ³ Cleber Souza            ³ Data ³ 26/01/04 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Tela de digitação do email e corpo do email.    			    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QPPR012TO()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ SIGAPPAP				                 					    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QPPR012TO()
            
Local cEmail := ""    
Local cCorpo := ""  
Local lLista := .T.  
Local oEmail
Local oCorpo
Local oDlg

DEFINE MSDIALOG oDlg FROM 12,35 TO 32, 90 TITLE OemToAnsi(STR0031) //"Informe os Emails para envio."
@ 03,03	  TO 32,215 LABEL STR0032 OF oDlg PIXEL  //"Para :"
@ 34,03	  TO 136,215 LABEL STR0033 OF oDlg PIXEL  //"Mensagem :"
@ 11,06   GET oEmail VAR cEmail MEMO SIZE 205,18 OF oDlg PIXEL 
@ 42,06   GET oCorpo VAR cCorpo MEMO SIZE 205,91 OF oDlg PIXEL
@ 138,10  CHECKBOX oLista Var lLista Prompt OemtoAnsi( STR0034 )	SIZE 100,10 OF oDlg PIXEL  //"Envia lista dos relatorios gerados."
@ 138,179 BUTTON STR0035 OF oDlg SIZE 35, 12 ACTION IIF(!Empty(cEmail),oDlg:End(),.t.) PIXEL //"&Enviar"
ACTIVATE DIALOG oDlg CENTERED

Return({cEmail,cCorpo,lLista})