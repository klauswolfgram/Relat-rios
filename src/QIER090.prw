/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "QIER090.Ch"
#Include "PROTHEUS.CH"
#Include "REPORT.CH"
#define Confirma 1
#define Redigita 2
#define Abandona 3

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QIER090  ³ Autor ³     Marcelo Pimentel  ³ Data ³ 19.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Avalia‡Æo Ultimos Lotes Recebidos.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SigaQie                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³			ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data	³ BOPS ³  Motivo da Alteracao 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Vera        ³19/04/99³------³ Inclusao da Loja do Fornecedor           ³±±
±±³CesarValadao³01/09/99³PROTHE³Retirada funcao FClose() apos MemoWrite() ³±±
±±³Vera        ³17/11/99³------³ Acerto picture para versao TOP           ³±±
±±³Paulo Emidio³29/09/00³------³Alteracao na exibiciao de caracteres inva-³±±
±±³            ³        ³      ³lidos.                                    ³±±
±±³Robson Ramir³25/04/01³FNC   ³Alteracao para cabecalho grafico          ³±±
±±³Paulo Emidio³28/05/01³META  ³ Alterado programa para que possa ser sele³±±
±±³       	   ³		³	   ³ cionado o Tipo da Nota Fiscal de Entrada ³±±
±±³       	   ³		³	   ³ sendo a mesma 1)Normal 2)Beneficiamento  ³±±
±±³       	   ³		³	   ³ 3)Devolucao.							  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qier090()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva a Integridade dos dados de Entrada                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea := GetArea()
Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nOpc    :=0 
Local oDlg
Local cTitulo :=""
Local cText1  :=""

Private lEnd  :=.F.
Private lEdit := .t.	// Para editar os textos

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para montar Get.                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aListBox  := {}
Private aMsg      := {}
Private aSel      := {}
Private aValid    := {}
Private aConteudo := {}
Private cPerg1    := "QER031"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Janela Principal                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo := OemToAnsi(STR0001)	//"Avaliacao dos Ultimos Lotes Recebidos"
cText1	:= OemToAnsi(STR0002)	//"Sera impressa a Avaliacao dos Ultimos Lotes Recebidos"

DEFINE MSDIALOG oDlg TITLE cTitulo FROM  165,115 TO 315,525 PIXEL OF oMainWnd
@ 03, 10 TO 43, 195 LABEL "" OF oDlg  PIXEL
@ 10, 15 SAY cText1 SIZE 180, 8 OF oDlg PIXEL
DEFINE SBUTTON FROM 50, 112 TYPE 5 ACTION (nOpc:=2,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 50, 141 TYPE 1 ACTION (nOpc:=1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 50, 170 TYPE 2 ACTION (nOpc:=3,oDlg:End()) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg

Do Case
	Case nOpc==1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Relat¢rio de Avaliacao dos Ultimos Lotes                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Pergunte("QER090",.F.)	
		oReport := ReportDef()
		oReport:PrintDialog()	
	Case nOpc==2
		R090Processa()
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aArea)
Return
   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef ³ Autor ³ Cleber Souza         ³ Data ³ 14/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definição dos Sections                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local cPrograma   := "QIER090"
Local cString     := "QEK"
Local cDesc1      := STR0007 //"Neste relatorio sera impresso a Avaliacao dos Ultimos Lotes Recebidos"

Private cPerg     := "QER090"
Private cTitulo   := STR0008 //"AVALIACAO ULTIMOS LOTES RECEBIDOS"

DEFINE REPORT oReport NAME cPrograma TITLE cTitulo PARAMETER cPerg ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)
                     
DEFINE SECTION oSection OF oReport TITLE STR0043 TABLES "QEK","QEU"//Data
DEFINE CELL NAME "cData"     OF oSection  ALIAS NIL TITLE ""  SIZE 400

DEFINE SECTION oSection1 OF oSection TITLE STR0025 
DEFINE CELL NAME "cEnsaio"   OF oSection1 ALIAS NIL TITLE TitSX3("QE7_ENSAIO")[1] SIZE TamSx3("QE7_DESENS")[1] +1  
DEFINE CELL NAME "cNumEns"   OF oSection1 ALIAS NIL TITLE ""					   SIZE 4  // para corrigir erro q estava aparecendo
DEFINE CELL NAME "cEspec"    OF oSection1 ALIAS NIL TITLE STR0025  		 		   SIZE 40  //"Especificado" 
DEFINE CELL NAME "cResult"   OF oSection1 ALIAS NIL TITLE STR0026 			       SIZE 40  //"Resultados"

DEFINE SECTION oSection2 OF oSection1 TITLE STR0029
DEFINE CELL NAME "cNumEns"   OF oSection2 ALIAS NIL TITLE ""					   SIZE 4  
DEFINE CELL NAME "cNaoConf"  OF oSection2 ALIAS NIL TITLE STR0027    			   SIZE TamSx3("QEU_DESNCO")[1] +1  //"Nao Conformidade(s) encontrada(s)"
DEFINE CELL NAME "cNumNConf" OF oSection2 ALIAS NIL TITLE STR0028    			   SIZE TamSx3("QEU_NUMNC")[1] +1  //"No."   
DEFINE CELL NAME "cClasse"   OF oSection2 ALIAS NIL TITLE STR0029    			   SIZE TamSx3("QEU_CLASSE")[1] +1  //"Classe"
DEFINE CELL NAME "cFatorC"   OF oSection2 ALIAS NIL TITLE STR0030    			   SIZE TamSx3("QEL_HRDILA")[1] +1  //"Fator Criticidade"
DEFINE CELL NAME "cReinc"    OF oSection2 ALIAS NIL TITLE STR0031    			   SIZE TamSx3("QEL_HRDILA")[1] +1  //"Reincidencia"

DEFINE SECTION oSection3 OF oSection2 TITLE TitSX3("QEK_DTENTR")[1]
DEFINE CELL NAME "cDtEntr"    OF oSection3 ALIAS NIL TITLE Subs(TitSX3("QEK_DTENTR")[1],1,10)    SIZE TamSx3("QEK_DTENTR")[1] +1  
DEFINE CELL NAME "cLote"      OF oSection3 ALIAS NIL TITLE TitSX3("QEK_LOTE")[1]  			      SIZE TamSx3("QEK_LOTE")[1] +1  
DEFINE CELL NAME "cTamLote"   OF oSection3 ALIAS NIL TITLE TitSX3("QEK_TAMLOT")[1]  			  SIZE TamSx3("QEK_TAMLOT")[1] +1  
DEFINE CELL NAME "cNtFisc"    OF oSection3 ALIAS NIL TITLE TitSX3("QEK_NTFISC")[1]  			  SIZE TamSx3("QEK_NTFISC")[1] +1  
DEFINE CELL NAME "cDiasat"    OF oSection3 ALIAS NIL TITLE Subs(TitSX3("QEK_DIASAT")[1],1,10)    SIZE TamSx3("QEK_DIASAT")[1] +1  
DEFINE CELL NAME "cVerifica"  OF oSection3 ALIAS NIL TITLE STR0040  							  SIZE 10  //"Verifica"
DEFINE CELL NAME "cLaudo"     OF oSection3 ALIAS NIL TITLE STR0041 							      SIZE 10  //Laudo 
DEFINE CELL NAME "cDtLaudo"   OF oSection3 ALIAS NIL TITLE TitSX3("QEL_DTLAUD")[1] 			  	  SIZE TamSx3("QEL_DTLAUD")[1] +1
DEFINE CELL NAME "cSHLF"      OF oSection3 ALIAS NIL TITLE TitSX3("QE6_SHLF")[1] 			      SIZE TamSx3("QE6_SHLF")[1] +1
DEFINE CELL NAME "cNNC"       OF oSection3 ALIAS NIL TITLE TitSX3("QEK_NNC")[1] 			      SIZE TamSx3("QEK_NNC")[1] +1
DEFINE CELL NAME "cQtRej"     OF oSection3 ALIAS NIL TITLE TitSX3("QEL_QTREJ")[1] 			      SIZE TamSx3("QEL_QTREJ")[1] +1
DEFINE CELL NAME "cJUSTLA"    OF oSection3 ALIAS NIL TITLE TitSX3("QEL_JUSTLA")[1] 			      SIZE 20
oSection3:Cell("cJUSTLA"):SeTLineBREAK(.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Cleber Souza       º Data ³  07/15/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de immpressao do relatorio R4.			          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QIER090                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local aLinha    := {}
Local cImpTxt   := ""
Local cImpLinha := ""
Local cTexto    := ""
Local cArqTxt   := ""
Local cData     := ""
Local cAcentos  := "€ú‡úŽú?ú…ú†úƒú ú?úˆú‚ú¡ú“ú”ú¢ú™ú£ú"
Local cAcSubst  := "C,c,A~A'a`a~a^a'E'e^e'i'o^o~o'O~U'"
Local aMeses    := {	STR0011,STR0012,STR0013,STR0014,STR0015,STR0016,STR0017,STR0018,STR0019,STR0020,STR0021,STR0022}		//"Janeiro"###"Fevereiro"###"Marco"###"Abril"###"Maio"###"Junho"###"Julho"###"Agosto"###"Setembro"###"Outubro"###"Novembro"###"Dezembro"
Local aTxt      := {}
Local nCont     := 0
Local cTxt      := ""
Local cVerif
Local cProduto
Local cFor
Local cLojFor
Local cChaveQEL
Local nRecQEK
Local cFatRep    := " "
Local cChaveQa2	 := ""
Local nCount     := 0
Local nC         := 0
Local nP         := 0
Local oSection   :=oReport:Section(1)
Local oSection1  :=oReport:Section(1):Section(1)
Local oSection2  :=oReport:Section(1):Section(1):Section(1)
Local oSection3  :=oReport:Section(1):Section(1):Section(1):Section(1) 
Local cSeek      := ""
Local nPos       := 1
Local nCol       := 0
Local cNiseri    := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da funcao onde armazenar  array's com NConformidades.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aEnsaio := {}
Private nEns	:= 1
Private aNConf	:= {}
Private aResTXT := {}
Private aResult := {}
Private cChave	:= ""  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam) 

dbSelectArea("QEK")
dbSetOrder(1)
If !dbSeek(xFilial("QEK")+mv_par01+mv_par02+mv_par03+Inverte(mv_par04)+Inverte(mv_par05))
	Set Device to Screen
	Help(" ",1,"QE_NAOENTR")	// "Entrada nao cadastrada."
	dbSelectArea("QEK")
	dbSetOrder(1)
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define o Fator Reprovado                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QED->(dbSetOrder(1))
QED->(dbSeek(xFilial("QED")))
While !QED->(Eof())
	If QED->QED_CATEG == "3"
		cFatRep := QED->QED_CODFAT
		Exit
	EndIf
	QED->(dbSkip())
EndDo

dbSelectArea("SA5")
dbSetOrder(2)
dbSeek(xFilial("SA5")+QEK->QEK_PRODUT+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

dbSelectArea("QE6")
dbSetOrder(1)
dbSeek(xFilial("QE6")+QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI))

cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
QEL->(dbSetOrder(3))
cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE

If QEL->(dbSeek(xFilial("QEL")+cSeek+Space(TamSX3("QEL_LAUDO")[1])))
	If QEL->QEL_LAUDO != cFatRep
		Set Device to Screen
		Help(" ",1,"QE_ENTNREP")	//	"Entrada nao tem Laudo Reprovado."
		dbSelectArea("QEK")
		dbSetOrder(1)
		Return
	EndIf	
Endif

R090NNC(.T.,oReport)

oSection:Init()  
cData := AllTrim(SM0->M0_CIDENT)+","+ Alltrim(Str(day(dDataBase))) + STR0023 + aMeses[month(dDataBase)] + STR0023 + Alltrim(Str(year(dDataBase)))		//" de "###" de "
oSection:Cell("cData"):SetValue(cData)
oSection:PrintLine()
oSection:Finish()  

oReport:SkipLine ( )
oReport:SkipLine ( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto superior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTxt := "QER0902"+".TXT"
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		oReport:PrintText (cImpLinha, oReport:ROW(),010)
		oReport:SkipLine ( )
	Next nC
EndIf

oReport:SkipLine ( )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Faz a Impressao dos dados da Entrada             	 		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³	Seleciona os dados referentes a Fornecedores/Cliente		 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !(QEK->QEK_TIPONF $"DB")
	dbSelectArea("SA2")
	dbSetOrder(1)
	dbSeek(xFilial("SA2")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

	oReport:PrintText (AllTrim(TitSX3("QEK_FORNEC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_FORNEC")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (AllTrim(QEK->QEK_FORNEC)+"/"+QEK->QEK_LOJFOR+" - "+SA2->A2_NOME, oReport:ROW(),370)

	oReport:SkipLine ( )

	oReport:PrintText (AllTrim(TitSX3("A2_END")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A2_END")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (SA2->A2_END, oReport:ROW(),370)
	oReport:SkipLine ( )

	oReport:PrintText (AllTrim(TitSX3("A2_MUN")[1]) + "/" + AllTrim(TitSX3("A2_EST")[1])+Replicate(".",23-(Len(AllTrim(TitSX3("A2_MUN")[1]))+Len(AllTrim(TitSX3("A2_EST")[1])))-1)+":", oReport:ROW(),010)
	oReport:PrintText (SA2->A2_MUN + " - " + SA2->A2_EST, oReport:ROW(),370)
	oReport:SkipLine ( )

	oReport:PrintText (AllTrim(TitSX3("A2_CEP")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A2_CEP")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (Subs(SA2->A2_CEP,1,5)+"-"+Subs(SA2->A2_CEP,6,8), oReport:ROW(),370)
	oReport:SkipLine ( )

Else
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+QEK->QEK_FORNEC+QEK->QEK_LOJFOR)

	oReport:PrintText (AllTrim(TitSX3("A7_CLIENTE")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A7_CLIENTE")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (AllTrim(QEK->QEK_FORNEC)+"/"+QEK->QEK_LOJFOR+" - "+SA1->A1_NOME, oReport:ROW(),370)
	oReport:SkipLine ( )

	oReport:PrintText (AllTrim(TitSX3("A1_END")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A1_END")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (SA1->A1_END, oReport:ROW(),370)
	oReport:SkipLine ( )
	
	oReport:PrintText (AllTrim(TitSX3("A1_MUN")[1]) + "/" + AllTrim(TitSX3("A1_EST")[1])+Replicate(".",23-(Len(AllTrim(TitSX3("A1_MUN")[1]))+Len(AllTrim(TitSX3("A1_EST")[1])))-1)+":", oReport:ROW(),010)
	oReport:PrintText (SA1->A1_MUN + " - " + SA1->A1_EST, oReport:ROW(),370)
	oReport:SkipLine ( )
	
	oReport:PrintText (AllTrim(TitSX3("A1_CEP")[1])+Replicate(".",23-Len(AllTrim(TitSX3("A1_CEP")[1])))+":", oReport:ROW(),010)
	oReport:PrintText (Subs(SA1->A1_CEP,1,5)+"-"+Subs(SA1->A1_CEP,6,8), oReport:ROW(),370)
	oReport:SkipLine ( )
	
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo dos dados da Entrada             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:PrintText (AllTrim(TitSX3("QEK_PRODUT")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PRODUT")[1])))+":", oReport:ROW(),010)
oReport:PrintText (AllTrim(QEK->QEK_PRODUT) + " - " + Alltrim(QE6->QE6_DESCPO) + " - " + QEK->QEK_REVI, oReport:ROW(),370)
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3("QEK_DTENTR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_DTENTR")[1])))+":", oReport:ROW(),010)
oReport:PrintText (DTOC(QEK->QEK_DTENTR), oReport:ROW(),370)
oReport:PrintText (AllTrim(TitSX3("QEK_LOTE")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_LOTE")[1])))+":" ,oReport:ROW(),1220)
oReport:PrintText (QEK->QEK_LOTE, oReport:ROW(),1520)
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3("QEK_NTFISC")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_NTFISC")[1])))+":", oReport:ROW(),010)
oReport:PrintText (QEK->QEK_NTFISC, oReport:ROW(),370)
oReport:PrintText (AllTrim(TitSX3("QEK_DTNFIS")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_DTNFISC")[1])))+":", oReport:ROW(),1220)
oReport:PrintText (DTOC(QEK->QEK_DTNFIS), oReport:ROW(),1520)
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3("QEK_PEDIDO")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_PEDIDO")[1])))+":", oReport:ROW(),010)
oReport:PrintText (QEK->QEK_PEDIDO, oReport:ROW(),370)
oReport:PrintText (AllTrim(FwX3Titulo("QEK_DOCENT"))+Replicate(".",19-Len(AllTrim(FwX3Titulo("QEK_DOCENT"))))+":", oReport:ROW(),1220)
oReport:PrintText (QEK->QEK_DOCENT, oReport:ROW(),1520)
oReport:SkipLine ( )

oReport:PrintText (AllTrim(TitSX3("QEK_CERFOR")[1])+Replicate(".",23-Len(AllTrim(TitSX3("QEK_CERFOR")[1])))+":", oReport:ROW(),010)
oReport:PrintText (QEK->QEK_CERFOR, oReport:ROW(),370)
oReport:PrintText (AllTrim(TitSX3("QEK_TAMLOT")[1])+Replicate(".",19-Len(AllTrim(TitSX3("QEK_TAMLOT")[1])))+":", oReport:ROW(),1220)
SAH->(dbSetOrder(1))
SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
oReport:PrintText (QEK->QEK_TAMLOT + "  " + SAH->AH_UMRES, oReport:ROW(),1520)
oReport:SkipLine ( )
oReport:SkipLine ( )
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe medi‡äes <> TXT               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aEnsaio) > 0 .And. Len(aEnsaio) <> Len(aResTxt)  
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se existe medi‡äes <> TXT               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aEnsaio) > 0 .And. Len(aEnsaio) <> Len(aResTxt)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a impressao do cabe‡alho                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	oReport:SkipLine(1) 
	oReport:ThinLine()
	oReport:SkipLine(1)	
	oReport:PrintText(TitSX3("QE7_ENSAIO")[1],oReport:Row(),005)
 	oReport:PrintText(AllTrim(TitSX3("QE7_LIE")[1]),oReport:Row(),750)
	oReport:PrintText(AllTrim(TitSX3("QE7_LSE")[1]),oReport:Row(),950)
	oReport:PrintText(Subs(TitSX3("QE7_UNIMED")[1],1,10),oReport:Row(),1100)
	oReport:PrintText(STR0024,oReport:Row(),1500)		//"Resultados"
	oReport:SkipLine(1)
	oReport:ThinLine()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Faz a impressao dos resultados                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nC := 1 to Len(aEnsaio)
		oReport:SkipLine(1)
		If aEnsaio[nC,6] != "TXT"
			dbSelectArea("QE1")
			QE1->(dbSetOrder(1))
			dbSeek(xFilial("QE1")+aEnsaio[nC,2])
			oReport:PrintText(QE1_DESCPO,oReport:Row(),005)
			oReport:PrintText("(" + StrZero(aEnsaio[nC,1],2) + ")",oReport:Row(),600)
			
			If QE7->QE7_MINMAX == "1"
				oReport:PrintText(aEnsaio[nC,3],oReport:Row(),700)
				oReport:PrintText(aEnsaio[nC,4],oReport:Row(),900)
			ElseIf QE7->QE7_MINMAX == "2"	
				oReport:PrintText(aEnsaio[nC,3],oReport:Row(),700)
				oReport:PrintText(">>>",oReport:Row(),900)
			ElseIf QE7->QE7_MINMAX == "3"
				oReport:PrintText("<<<",oReport:Row(),700)
				oReport:PrintText(aEnsaio[nC,4],oReport:Row(),900)
			EndIf
			
			// Identifica a Descricao resumida da Unidade Medida
			SAH->(dbSetOrder(1))
			SAH->(dbSeek(xFilial("SAH")+aEnsaio[nC,5]))
			oReport:PrintText(SAH->AH_UMRES,oReport:Row(),1100)
		
			nCol:= 1500
			
			For nCont := 1 to Len(aResult)
				If nC == aResult[nCont,1]
					If nPos == 6
						oReport:SkipLine(1)
						nCol := 1500
						nPos:= 1
					EndIf
					oReport:PrintText(aResult[nCont,2],oReport:Row(),nCol)
					nCol+=170
					nPos++
				EndIf
			Next nCont
			nPos:= 1			
		EndIf	
	Next nC
EndIf

EndIf
oReport:SkipLine(1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CABECALHO DOS RESULTADOS NAO ENCONTRADOS  - TXT  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aResTxt) > 0
	x:= 1
	cTxt := ""
	For nP:= 1 to Len(aResTxt)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta array de acordo com o tamanho do texto.    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		                         
		oReport:SetMeter(Len(aTxt))
		oSection1:Init()  
		dbSelectArea("QE1")
		QE1->(dbSetOrder(1))
		dbSeek(xFilial("QE1")+aResTxt[nP,3])
		oSection1:Cell("cEnsaio"):SetValue(Alltrim(QE1_DESCPO))
		oSection1:Cell("cNumEns"):SetValue("(" + StrZero(aResTxt[nP,4],2) + ")")
		oSection1:Cell("cEspec"):SetValue(aResTxt[nP,1])
		oSection1:Cell("cResult"):SetValue(aResTxt[nP,2])
		oSection1:PrintLine()
		oReport:IncMeter()
	Next nP
EndIf	
oSection1:Finish()


If Len(aNConf) > 0
	oReport:SetMeter(Len(aNConf))
	oSection2:Init()  
	For nC := 1 to Len(aNConf)
		If AllTrim(aNConf[nC,6]) == "0"
			Loop
		EndIf
		oSection2:Cell("cNumEns"):SetValue( "("+StrZero(aNConf[nC,1],2)+")")
		oSection2:Cell("cNaoConf"):SetValue(aNConf[nC,2])
		oSection2:Cell("cNumNConf"):SetValue(Str( aNConf[nC,3],5 ))
		oSection2:Cell("cClasse"):SetValue(AllTrim(aNConf[nC,4]))
		If aNConf[nC,8] == "S"
			oSection2:Cell("cFatorC"):SetValue(STR0033 + AllTrim(aNConf[nC,6]) +STR0034)
		Else
			oSection2:Cell("cFatorC"):SetValue(STR0035)
		EndIf
		If aNConf[nC,7] > 1
			oSection2:Cell("cReinc"):SetValue(AllTrim(Str(aNConf[nC,7] - 1)) + " a.")
		Else
			oSection2:Cell("cReinc"):SetValue("")
		EndIf
		oSection2:PrintLine()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  CRONICA                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("QA2")
		dbSetOrder(1)
		cChaveQa2 := aNConf[nC,Len(aNConf[nC])]
		If	dbSeek(xFilial("QA2")+"QIEA210C"+cChaveQa2)
			While !Eof() .and.	xFilial("QA2") == QA2->QA2_FILIAL .And. ;
			QA2->QA2_ESPEC = "QIEA210C" .And. QA2->QA2_CHAVE == cChaveQa2
				oReport:PrintText (StrTran(QA2_TEXTO, "\13\10", ""), oReport:ROW(),100)
				oReport:SkipLine ( )
				dbSkip()
			EndDo
		EndIf
	Next nC
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  LAUDO                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine ( )
dbSelectArea("QEL")

cNiseri := 	QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
QEL->(dbSetOrder(3))
cSeek := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE

If dbSeek(xFilial("QEL")+cSeek+Space(TamSX3("QEL_LAUDO")[1]))
	oReport:PrintText (AllTrim(TitSX3("QEL_LAUDO")[1])+Replicate(".",30-Len(AllTrim(TitSX3("QEL_LAUDO")[1])))+":", oReport:ROW(),70)
	dbSelectArea("QED")
	dbSetOrder(1)
	If dbSeek(xFilial("QED")+QEL->QEL_LAUDO)
		oReport:PrintText (QEL->QEL_LAUDO +" - "+QED_DESCPO, oReport:ROW(),520)
		oReport:SkipLine ( )
	EndIf
	oReport:PrintText (AllTrim(TitSX3("QEL_JUSTLA")[1])+Replicate(".",30-Len(AllTrim(TitSX3("QEL_JUSTLA")[1])))+":", oReport:ROW(),70)
	oReport:PrintText (QEL->QEL_JUSTLA, oReport:ROW(),520)
	oReport:SkipLine ( )
	If !Empty(QEL->QEL_QTREJ)
		SAH->(dbSetOrder(1))
		SAH->(dbSeek(xFilial("SAH")+QEK->QEK_UNIMED))
		oReport:PrintText (AllTrim(TitSX3("QEL_QTREJ")[1])+Replicate(".",30-Len(AllTrim(TitSX3("QEL_QTREJ")[1])))+":", oReport:ROW(),70)
		oReport:PrintText (AllTrim(QEL->QEL_QTREJ) +" "+ SAH->AH_UMRES, oReport:ROW(),520)
		oReport:SkipLine ( )
	EndIf	
	oReport:SkipLine ( )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ARMAZENA NO ARRAY AS ULTIMAS ENTRADAS      			 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cProduto := QEK->QEK_PRODUT
cFor	 := QEK->QEK_FORNEC
cLojFor	 := QEK->QEK_LOJFOR
nCont 	 := 0

dbSelectArea("QEK")

nRecQEK:=Recno()
dbSetOrder(2)
oReport:SetMeter(RecCount())
oSection3:Init()  

While	!QEK->(Eof()) .And. QEK->QEK_FILIAL+QEK->QEK_FORNEC+QEK->QEK_LOJFOR+;
	QEK->QEK_PRODUT == xFilial("QEK")+cFor+cLojFor+cProduto .and. nCont < 5
	cNiseri := QEK->QEK_NTFISC+QEK->QEK_SERINF+QEK->QEK_ITEMNF
	cChaveQEL := QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT+cNiseri+QEK->QEK_TIPONF+DTOS(QEK->QEK_DTENTR)+QEK->QEK_LOTE+Space(TamSX3("QEL_LABOR")[1])
	cVerif :=IIF(QEK->QEK_VERIFI == 1,STR0037,IIF(QEK->QEK_VERIFI == 2,STR0038,STR0039))	//"Inspec."###"Certifi."###"Lib.Urg."

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra o Tipo de Nota Fiscal de Entrada				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 1    
		If !(QEK->QEK_TIPONF == "N" .Or. QEK_TIPONF == " ")
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	ElseIf mv_par06 == 2
 		If !(QEK->QEK_TIPONF == "B") 
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	ElseIf mv_par06 == 3
 		If !(QEK->QEK_TIPONF == "D") 
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	EndIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Posiciona em registros de outros Arquivos                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("QEL")
	QEL->(dbSetOrder(3))
	dbSeek(xFilial("QEL")+cChaveQEL)
	dbSelectArea("QE6")
	QE6->(dbSetOrder(1))
	dbSeek(xFilial("QE6")+QEK->QEK_PRODUT+Inverte(QEK->QEK_REVI))

	oSection3:Cell("cDtEntr"):SetValue(DTOC(QEK->QEK_DTENTR))
	oSection3:Cell("cLote"):SetValue(QEK->QEK_LOTE)
	oSection3:Cell("cTamLote"):SetValue(QEK->QEK_TAMLOT)
	oSection3:Cell("cNtFisc"):SetValue(QEK->QEK_NTFISC)
	oSection3:Cell("cDiasat"):SetValue(QEK->QEK_DIASAT)
	oSection3:Cell("cVerifica"):SetValue(cVerif)
	oSection3:Cell("cLaudo"):SetValue(QEL->QEL_LAUDO)
	oSection3:Cell("cDtLaudo"):SetValue(DTOC(QEL->QEL_DTLAUD))
	oSection3:Cell("cSHLF"):SetValue(QE6->QE6_SHLF)
	oSection3:Cell("cNNC"):SetValue(QEK->QEK_NNC)
	oSection3:Cell("cQtRej"):SetValue(QEL->QEL_QTREJ)
	oSection3:Cell("cJUSTLA"):SetValue(QEL->QEL_JUSTLA)
	oSection3:PrintLine()
	
	nCont++  
	oReport:IncMeter()
	dbSelectArea("QEK")
	QEk->(dbSkip())
Enddo
oSection3:Finish()                         

dbSelectArea("QEK")
dbGoTo(nRecQEK)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz a ImpressÆo do Texto inferior da Capa        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SkipLine ( )
oReport:SkipLine ( )
cArqTxt := "QER0903"+".TXT"
If File(cArqTxt)
	cTexto:=MemoRead(cArqTxt)
	For nC := 1 To MLCOUNT(cTexto,130)
		aLinha := MEMOLINE(cTexto,130,nC)
		cImpTxt   := ""
		cImpLinha := ""
		For nCount := 1 To Len(aLinha)
			cImpTxt := Substr(aLinha,nCount,1)
			If AT(cImpTxt,cAcentos)>0
				cImpTxt:=Substr(cAcSubst,AT(cImpTxt,cAcentos),1)
			EndIf
			cImpLinha := cImpLinha+cImpTxt
		Next nCount
		oReport:PrintText (cImpLinha, oReport:ROW(),010)
		oReport:SkipLine ( )
	Next nC
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a Integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEK")
Set Filter To
dbSetOrder(1)
dbSelectArea("SA2")
dbSetOrder(1)
dbSelectArea("SA5")
dbSetOrder(1)
dbSelectArea("QE6")
dbSetOrder(1)
dbSelectArea("QEL")
dbSetOrder(1)
dbSelectArea("QE1")
dbSetOrder(1)
dbSelectArea("QED")
dbSetOrder(1)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R090Processa ³ Autor ³  Marcelo Pimentel ³ Data ³ 19/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Processamento do QIER090                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R090Processa()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta tela para digitacao de itens.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lEnd:=A090Mont()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³   A090Mont   ³ Autor ³   Marcelo Pimentel³ Data ³ 19/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Monta Tela para digitacao dos textos.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A090Mont()

Local i        :=1
Local oListBox
Local nOpcA    :=2
Local oDlgGet

AADD(aListBox," ")
AADD(aListBox,STR0003)		//" Texto Superior Capa "
AADD(aListBox,STR0004)		//" Texto Inferior Capa "
AADD(aListBox," ")

For i:= 1 To Len(aListBox)
	aListBox[i] := aListBox[i]
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa ListBox com opcoes para o array da configuracao          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE MSDIALOG oDlgGet TITLE OemToAnsi(STR0001) FROM  63,1	TO 275,399 PIXEL OF oMainWnd		//"Avaliacao dos Ultimos Lotes Recebidos"

@ 12, 21 SAY OemToAnsi(STR0042)	SIZE 67, 7 OF oDlgGet PIXEL		//"Itens de Configuracao"
@ 20, 21 TO 72, 181 OF oDlgGet PIXEL
@ 31, 28 LISTBOX oListBox VAR cVar FIELDS HEADER "" ON DBLCLICK (R090GetList(oListBox)) SIZE 147,36 PIXEL

oListBox:SetArray(aListBox)
oListBox:bLine := { ||{aListBox[oListBox:nAt]}}

DEFINE SBUTTON FROM 85, 101 TYPE 1 ACTION (nOpca:=1,oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 85, 145 TYPE 2 ACTION (nOpca:=2,oDlgGet:End()) ENABLE OF oDlgGet

ACTIVATE MSDIALOG oDlgGet CENTERED

If nOpca == 1
	U_QIER090() 		//Janela Principal
EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R090GetList ³Autor³ Marcelo Pimentel      ³ Data ³ 19.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Get para edicao de Elemento relacionado ao ListBox    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER090                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R090GetList(oListBox)
Local nAt := oListBox:nAt

If nAt == 2 .Or. nAt == 3
	R090TEXT(oListBox)
Endif	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R090Text    ³Autor³ Marcelo Pimentel      ³ Data ³ 19.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ativa Tela para preenchimento do conteudo relacionado com o ³±±
±±³          ³ListBox.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER090                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R090Text(oListBox)

Local cTexto   := ""
Local nOpca    :=2
Local oFontMet := TFont():New("Courier New",6,0)
Local oDlgGet2 
Local oTexto
Local oFontDialog := TFont():New("Arial",6,15,,.T.)
Local oBox

nAt      := oListBox:nAt
cNomeArq := CriaTrab(NIL,.F.)

nHdl:=MSFCREATE(cNomeArq,0)
If nHdl <= -1
	HELP(" ",1,"NODIRCQ")
	Return .T.
Else
	If File(cNomeArq)
		FCLOSE(nHdl)
		FERASE(cNomeArq)
	Endif
Endif

cNomeArq := "QER090"+Str(nAt,1)+".TXT"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Le arquivo                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTexto:=MemoRead(cNomeArq)
	
DEFINE MSDIALOG oDlgGet2 FROM	62,100 TO 345,610 TITLE  OemToAnsi(STR0042) PIXEL FONT oFontDialog		//"Itens de Configuracao"
@ 003, 004 TO 027, 250 LABEL "" 	OF oDlgGet2 PIXEL
@ 040, 004 TO 110, 250				OF oDlgGet2 PIXEL
	
@ 013, 010 MSGET oBox VAR aListBox[nAt]	 SIZE 235, 010 OF oDlgGet2 PIXEL
oBox:lReadOnly := .t.
@ 050, 010 GET oTexto VAR cTexto MEMO NO VSCROLL WHEN lEdit SIZE 235, 051 OF oDlgGet2 PIXEL
	
oTexto:oFont := oFontMet
	
DEFINE SBUTTON FROM 120,190 TYPE 1 ACTION (nOpca := 1,oDlgGet2:End()) ENABLE OF oDlgGet2
DEFINE SBUTTON FROM 120,220 TYPE 2 ACTION (nOpca := 2,oDlgGet2:End()) ENABLE OF oDlgGet2
	
ACTIVATE MSDIALOG oDlgGet2 CENTERED

If nOpca == Confirma
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua gravacao do arquivo                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MemoWrit( cNomeArq,cTexto )

EndIf
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R090NNC     ³Autor³ Marcelo Pimentel      ³ Data ³ 19.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Verifica se existe Nao Conformidade.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³QIER090                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R090NNC(lR4,oReport)
Local nOcor:= 0
Local aAreaQEU := NIL
Local aAreaQEK := NIL
Local aAreaQER := NIL
Default lR4  			:= .F.
Default oReport			:= Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fun‡Æo que verificar h  ligacao com Nao Conformidades        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QEK")
aAreaQEK := { Alias(),IndexOrd(),Recno()}	

dbSelectArea("QER")
dbSetOrder(1)
dbSeek(xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+QEK->QEK_FORNEC+;
		QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE)

While !QER->(Eof()) .And. QER->QER_FILIAL == xFilial("QER") .And.;
	QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+;
	Dtos(QER->QER_DTENTR)+QER->QER_LOTE == QEK->QEK_PRODUT+QEK->QEK_REVI+;
	QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE
	
	aAreaQER := { Alias(),IndexOrd(),Recno()}


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Chave de ligacao com o QEU - Nao Conformidade das Entradas   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cChave := QER->QER_CHAVE
	
	QE1->(dbSetOrder(1))
	If QE1->(dbSeek(xFilial("QE1")+QER->QER_ENSAIO))
		
		dbSelectArea("QEU")
		dbSetOrder(1)
		If dbSeek(xFilial("QEU")+cChave)
			aAreaQEU1 := { Alias(),IndexOrd(),Recno() }
			While !Eof() .And. xFilial("QEU") == 	QEU_FILIAL .And. ;
				cChave == QEU_CODMED

			    If lR4 
					If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QEU")))
						If !QEU->(&(oReport:Section(1):GetAdvplExp("QEU")))
							QEU->(DbSkip())
							loop
						Endif
					Endif				
				Endif
		
				aAreaQEU := { Alias(),IndexOrd(),Recno() }
				cNConf:= QEU_NAOCON
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta array com nao conformidades encontradas                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				SAG->(dbSetOrder(1))
				If SAG->(dbSeek(xFilial("SAG")+cNConf))
					QEE->(dbSetOrder(1))
					If QEE->(dbSeek(xFilial("QEE")+QEU->QEU_CLASSE))
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Ser  Calculado o nr. de ocorrencias encontradas              ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						nOcor := R090OCOR(QEU->QEU_NAOCON)
						DbSelectArea(aAreaQEU[1]);DbSetOrder(aAreaQEU[2]);DbGoto(aAreaQEU[3])
						AADD(aNConf,{nENS,SAG->AG_DESCPO,QEU->QEU_NUMNC,QEE->QEE_DESCPO,CCHAVE,Str(QEE->QEE_PONTOS,2),nOcor,QEU->QEU_DEMIQI,QEU->QEU_CHAVE})
					EndIf
				Endif
				QEU->(DbSkip())
			EndDo
			nOcor := 0
		
			dbSelectArea(aAreaQEK[1]);dbSetOrder(aAreaQEK[2]);dbGoTo(aAreaQEK[3])
			dbSelectArea(aAreaQER[1]);dbSetOrder(aAreaQER[2]);dbGoTo(aAreaQER[3])
		
			If QE1->QE1_CARTA <> "TXT"
				QES->(dbSetOrder(1))
				If QES->(dbSeek(xFilial("QES")+cChave))
					While !QES->(EOF()) .And. QES->QES_FILIAL == xFilial("QES") .and.;
						QES->QES_CODMED == cChave
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Monta array c/ os valores de medicoes mensur veis(QES)    ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						AADD(aResult,{nEns,QES->QES_MEDICA})
						QES->(dbSkip())
					EndDo
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta array c/ os ensaios mensur veis dos produtos(QE7)      ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					QE7->(dbSetOrder(1))
					QE7->(dbSeek(xFilial("QE7")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
					AADD(aEnsaio,{nEns,QER->QER_ENSAIO,QE7->QE7_LIE,QE7->QE7_LSE,QE7->QE7_UNIMED,"NTXT"})
				EndIf
				nEns++
			Else
				QE8->(dbSetOrder(1))
				QE8->(dbSeek(xFilial("QE8")+QER->QER_PRODUT+QER->QER_REVI+QER->QER_ENSAIO))
				cTxt := QE8->QE8_TEXTO
				QEQ->(dbSetOrder(1))
				QEQ->(dbSeek(xFilial("QEQ")+cChave))
				cTxtRes := QEQ->QEQ_MEDICA
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta £nico array com Ensaios textos e valores de medic.(QEQ)³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				AADD(aResTXT,{QE8->QE8_TEXTO,QEQ->QEQ_MEDICA,QER->QER_ENSAIO,nEns})
				AADD(aEnsaio,{nEns,,,,,"TXT" })
				nEns++
			Endif
		EndIf
	EndIf
	dbSelectArea(aAreaQER[1]);dbSetOrder(aAreaQER[2]);dbGoTo(aAreaQER[3])
	QER->(dbSkip())
EndDo

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R090OCOR ³ Autor ³ Marcelo Pimentel      ³ Data ³ 26/03/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula a reicidencia da NC para o Produto e Fornecedor    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ R090OCOR()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QIER090                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function R090OCOR(cNConf)
Local nOcor     := 0
Local dDtLimite
Local cFornec   := QEK->QEK_FORNEC
Local cLojFor   := QEK->QEK_LOJFOR
Local cProdut   := QEK->QEK_PRODUT
Local cCh       :=""

nDias	  := GetMv("MV_QDIREIN")
dDtLimite := QEK->QEK_DTENTR - nDias

While !QEK->(Eof()) .And. QEK->QEK_FILIAL == xFilial("QEK") .And. ;
	QEK->QEK_FORNEC+QEK->QEK_LOJFOR+QEK->QEK_PRODUT == cFornec+cLojFor+cProdut

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra o Tipo de Nota Fiscal de Entrada				 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If mv_par06 == 1    
		If !(QEK->QEK_TIPONF == "N" .Or. QEK->QEK_TIPONF == " ")
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	ElseIf mv_par06 == 2
 		If !(QEK->QEK_TIPONF == "B") 
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	ElseIf mv_par06 == 3
 		If !(QEK->QEK_TIPONF == "D") 
			dbSelectArea("QEK")
			dbSkip()
		EndIf
	EndIF

	If QEK->QEK_DTENTR < dDtLimite
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona os resultados da Entrada                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	QER->(dbSetOrder(1))
	If QER->(dbSeek(xFilial("QER")+QEK->QEK_PRODUT+QEK->QEK_REVI+;
		QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE))
		While !QER->(Eof()) .And. QER->QER_FILIAL == xFilial("QER") .And.;
			QER->QER_PRODUT+QER->QER_REVI+QER->QER_FORNEC+QER->QER_LOJFOR+;
			Dtos(QER->QER_DTENTR)+QER->QER_LOTE == QEK->QEK_PRODUT+QEK->QEK_REVI+;
			QEK->QEK_FORNEC+QEK->QEK_LOJFOR+Dtos(QEK->QEK_DTENTR)+QEK->QEK_LOTE

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Obtem chave de ligacao da medicao com os outros arquivos     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cCh := QER->QER_CHAVE

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se a medicao tem NC                                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			QEU->(dbSetOrder(1))
			QEU->(dbSeek(xFilial("QEU")+cCh))
			While !QEU->(eof()) .And. QEU->QEU_FILIAL == xFilial("QEU") .And.;
				QEU->QEU_CODMED == cCh
				If QEU->QEU_NAOCON == cNConf
					nOcor++
				EndIf	
				QEU->(dbSkip())
			EndDo
			QER->(dbSkip())
		EndDo
	EndIf
	QEK->(dbSkip())
EndDo

Return(nOcor)
