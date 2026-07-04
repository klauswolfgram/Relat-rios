/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "Protheus.ch"
#include "pmsr120.ch"
#include "pmsicons.ch"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)

//---------------------------RELEASE 4-------------------------------------------//
User Function PMSR120()
	Local oReport

	If PMSBLKINT()
		Return Nil
	EndIf
		
	oReport := ReportDef()

	If !Empty(oReport:uParam)
		Pergunte(oReport:uParam,.F.)
	EndIf	

	oReport:PrintDialog()

Return

Static Function ReportDef()
Local cPerg		:= "PMR120"
Local cDesc1   := STR0012 //"Este relatorio ira imprimir uma relacao dos projetos, sua estrutura e o cronograma financeiro realizado para execucao do projeto."
Local cDesc2   := ""
Local cDesc3   := ""

Local oReport
Local oProjeto
Local oTarefa
Local nX

Local aOrdem  := {}

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

oReport := TReport():New("PMSR120",STR0013, cPerg, ;
			{|oReport| ReportPrint(oReport)},;
			cDesc1 )
//STR0013 "Cronograma Financeiro Realizado"
oReport:SetLandScape()

oProjeto := TRSection():New(oReport, STR0016, { "AF8", "AFE", "SA1" }, aOrdem /*{}*/, .F., .F.) //"Projeto"
oProjeto:SetLeftMargin(10)
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
TRCell():New(oProjeto,	"AF8_PROJET"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_DESCRI"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_CLIENT"	,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AF8_LOJA"		,"AF8",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"A1_NOME"		,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_REVISA"	,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_DATAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oProjeto,	"AFE_HORAF"		,"AFE",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)

TRPosition():New(oProjeto, "AFE", 1, {|| xFilial("AFE") + AF8->AF8_PROJET + AF8->AF8_REVISA})
TRPosition():New(oProjeto, "SA1", 1, {|| xFilial("SA1") + AF8->AF8_CLIENT})

//-------------------------------------------------------------
oTarefa := TRSection():New(oReport, STR0017, , /*{aOrdem}*/, .F., .F.) //"Tarefa"
oTarefa:SetHeaderPage()
oTarefa:SetColSpace(2) 
TRCell():New(oTarefa, "AF9_TAREFA","AF9",ALLTRIM(LEFT(STR0005,30))/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
TRCell():New(oTarefa, "AF9_DESCRI","AF9",/*Titulo*/,/*Picture*/,40/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/)
oTarefa:Cell("AF9_TAREFA"):SetLineBreak()
oTarefa:Cell("AF9_DESCRI"):SetLineBreak()

For nX := 1 TO 6   // no relatório deve ter sempre 6 periodos
	TRCell():New(oTarefa, "PERIODO-"+Str(nX,1)+"_V","",STR0021+"-"+Str(nX,1)+CRLF+" " + STR0018 /*Titulo*/,"@E 999,999,999,999.99"/*Picture*/,15/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")
	TRCell():New(oTarefa, "PERIODO-"+Str(nX,1)+"_P","",STR0021+"-"+Str(nX,1)+CRLF+" " + STR0019 /*Titulo*/,"@E 999"/*Picture*/,4/*Tamanho*/,/*lPixel*/,/*{|| bloco-de-impressao }*/,,,"RIGHT")
Next

Return(oReport)

Static Function ReportPrint(oReport)
Local dAuxFim
Local dAuxIni
Local aAuxImp  := {}
Local cFilterUsr  := ""
Local oProjeto := oReport:Section(1)

PRIVATE nValPrj	:= 0
Private lIniData	:= Empty(mv_par06).Or.empty(mv_par07)

If Empty(oProjeto:GetAdvplExp())
	cFilterUsr  := ".T."
Else
	cFilterUsr  := oProjeto:GetAdvplExp()
EndIf

CrteFilIni()

oReport:SetMeter(AF8->(LastRec()))

dbSelectArea("AF8")
dbSeek(xFilial()+mv_par01,.T.)
While !Eof() .And. AF8->AF8_PROJET <= mv_par02 .AND. !oReport:Cancel()

	oReport:IncMeter()

	If  AF8->AF8_DATA > mv_par04 .Or. AF8->AF8_DATA < mv_par03 .Or. !&( cFilterUsr )
		dbSkip()
		Loop
	EndIf

	SA1->(dbSetOrder(1))
	SA1->(dbSeek(xFilial()+AF8->AF8_CLIENT+AF8->AF8_LOJA))

	dbSelectArea("AFE")
	dbSetOrder(1)
	dbSeek(xFilial()+AF8->AF8_PROJET)

	While !Eof() .And. AFE->AFE_FILIAL+AFE->AFE_PROJET==xFilial()+AF8->AF8_PROJET .AND. !oReport:Cancel()
	
		// verifica as versoes a serem impressas
		// se estiver em branco so imprime a ultima versao (AF8_REVISA)
		If AFE->AFE_REVISA!=AF8->AF8_REVISA
			dbSkip()
			Loop
		EndIf
	
		If lIniData
			mv_par06 := AF8->AF8_START
			mv_par07 := AF8->AF8_FINISH
		EndIf

		aAuxImp  := {}
		dAuxFim	 := Nil
		Do Case
			Case mv_par08==1
				dAuxIni := mv_par06
			Case mv_par08==2
				dAuxIni := mv_par06
				If DOW(dAuxIni)<>1
					dAuxIni -= DOW(dAuxIni)-1
				EndIf
			Case mv_par08==3
				dAuxIni := CTOD("01/"+StrZero(MONTH(mv_par06),2,0)+"/"+StrZero(YEAR(mv_par06),4,0))-1
		EndCase

		aHandle	:= PmsIniCRTE(AF8->AF8_PROJET,AFE->AFE_REVISA,PMS_MAX_DATE)
		nValPrj	:= PmsRetCRTE(aHandle,2,Padr(AF8->AF8_PROJET,Len(AFC->AFC_EDT)))[1]
		PmR120_AFC(AF8->AF8_PROJET, AFE->AFE_REVISA, AF8->AF8_PROJET, aAuxImp, 4)

		While dAuxFim==Nil .Or. dAuxFim < mv_par07

			Do Case
				Case mv_par08 == 1
					dAuxFim := dAuxIni+5
				Case mv_par08==2
					dAuxFim := dAuxIni+(5*7)
				Case mv_par08==3
					dAuxFim := dAuxIni+(5*31)
					dAuxFim := CTOD("01/"+StrZero(MONTH(dAuxFim),2,0)+"/"+StrZero(YEAR(dAuxFim),4,0))-1
			EndCase
			dx := dAuxIni

			While dx <= dAuxFim
				aHandle	:= PmsIniCRTE(AF8->AF8_PROJET,AFE->AFE_REVISA,dx)
				PmR120_AFC(AF8->AF8_PROJET,AFE->AFE_REVISA,AF8->AF8_PROJET,aAuxImp,2)
				Do Case
					Case mv_par08 == 1
						dx++
					Case mv_par08==2
						dx+= 7
					Case mv_par08==3
						dx+= 35
						dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
				EndCase
			End

			dAuxIni := dx

		EndDo

		U_PmR120_Imp(oReport, aAuxImp)
		oReport:EndPage()

		dbSelectArea("AFE")
		dbSkip()

	EndDo

	dbSelectArea("AF8")
	dbSkip()

EndDo

// verifica o cancelamento pelo usuario..
If oReport:Cancel()
	oReport:SkipLine()
	oReport:PrintText(STR0022) //"*** CANCELADO PELO OPERADOR ***"
EndIf

dbSelectArea("AF8")
dbSetOrder(1)
dbClearFilter() //Set Filter to
CrteFilEnd()	

Return                  



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR120_AFC  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AFC.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR120_AFC()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PmR120_AFC(cProjeto, cRevisa, cEDT, aAuxImp, nPosArray)
Local aArea    := {}
Local x        := 0

Local aNodes   := {}
Local nNode    := 0

Aadd( aArea, AFC->( GetArea() ) )
Aadd( aArea, AF9->( GetArea() ) )
Aadd( aArea, GetArea() )

dbSelectArea("AFC")
dbSetOrder(1)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)
cProjeto	:= AFC->AFC_PROJET
cRevisa		:= AFC->AFC_REVISA
cEDT		:= AFC->AFC_EDT

If PmrPertence(AFC->AFC_NIVEL,mv_par05).And. PmsChkUser(AFC->AFC_PROJET,,AFC->AFC_EDT,AFC->AFC_EDTPAI,1,"ESTRUT",cRevisa)

	nPosAux := aScan(aAuxImp,{|x|x[1]=="AFC" .And. x[2]==AFC->(REcNo()) })
	If nPosAux <= 0
		aAdd(aAuxImp,{"AFC",AFC->(RecNo()),{},Nil,.T.,0})
		nPosAux := Len(aAuxImp)
	EndIf

	nVal	:= PmsRetCRTE(aHandle,2,AFC->AFC_EDT)[1]
	If nPosArray==4
		aAuxImp[nPosAux][4] := nVal
	Else
		aAdd(aAuxImp[nPosAux][3],{dx,nVal})
	EndIf
	
EndIf

dbSelectArea("AF9")
dbSetOrder(2)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)

While !Eof() .And. xFilial()+cProjeto+cRevisa+cEDT==;
	AF9->AF9_FILIAL+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_EDTPAI
	
	aAdd(aNodes, {PMS_TASK,;
	              AF9->(Recno()),;
	              If(Empty(AF9->AF9_ORDEM), "000", AF9->AF9_ORDEM),;
	              AF9->AF9_TAREFA})
	dbSkip()

EndDo

dbSelectArea("AFC")
dbSetOrder(2)
dbSeek(xFilial()+cProjeto+cRevisa+cEDT)

While !Eof() .And. xFilial()+cProjeto+cRevisa+cEDT==;
	AFC->AFC_FILIAL+AFC->AFC_PROJET+AFC->AFC_REVISA+AFC->AFC_EDTPAI

	aAdd(aNodes, {PMS_WBS,;
	              AFC->(Recno()),;
	              If(Empty(AFC->AFC_ORDEM), "000", AFC->AFC_ORDEM),;
	              AFC->AFC_EDT})	
	dbSelectArea("AFC")
	dbSkip()

EndDo

aSort(aNodes, , , {|x, y| x[3]+x[4] < y[3]+y[4]})

For nNode := 1 To Len(aNodes)

	If aNodes[nNode][1] == PMS_TASK
		AF9->(dbGoto(aNodes[nNode][2]))
		PmR120_AF9(AF9->AF9_PROJET, AF9->AF9_REVISA, AF9->AF9_TAREFA, aAuxImp, nPosArray)
	Else
		AFC->(dbGoto(aNodes[nNode][2]))
		PmR120_AFC(AFC->AFC_PROJET, AFC->AFC_REVISA, AFC->AFC_EDT, aAuxImp, nPosArray)
	EndIf

Next nNode

For x := 1 to Len(aArea)
	RestArea(aArea[x])
Next x

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ PMR120_AF9  ³ Autor ³ Edson Maricate      ³ Data ³21.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faz a impressao do detalhe AF9.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PMR120_AF9()                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function PmR120_AF9(cProjeto, cRevisa, cTarefa, aAuxImp, nPosArray)
Local aArea    := {}
Local x        := 0

Aadd( aArea, AF9->( GetArea() ) )
Aadd( aArea, GetArea() )

If PmrPertence(AF9->AF9_NIVEL,mv_par05).And.PmsChkUser(AF9->AF9_PROJET,AF9->AF9_TAREFA,,AF9->AF9_EDTPAI,1,"ESTRUT",cRevisa)

	If Pmr120Rec()
		
		nPosAux := aScan(aAuxImp,{|x|x[1]=="AF9" .And. x[2]==AF9->(REcNo()) })
		
		If nPosAux <= 0
			aAdd(aAuxImp,{"AF9",AF9->(RecNo()),{},Nil,.T.,0})
			nPosAux := Len(aAuxImp)
		EndIf
		
		nVal := PmsRetCRTE(aHandle,1,AF9->AF9_TAREFA)[1]
		
		If nPosArray==4
			aAuxImp[nPosAux][4] := nVal
		Else
			aAdd(aAuxImp[nPosAux][3],{dx,nVal})
		EndIf
		
	Endif
	
EndIf

For x := 1 to Len(aArea)
	RestArea(aArea[x])
Next //x

Return

User Function Pmr120_Imp(oReport, aAuxImp)
Local oProjeto 		:= oReport:Section(1)
Local oTarefa	 	:= oReport:Section(2)

Local dAuxFim
Local dAuxIni
Local dCabFim
Local nX
Local nPeriodo
Local lLoop := .T.

oTarefa:Cell("AF9_TAREFA"):SetBlock({|| If(aAuxImp[nx][1]=="AFC", AFC->AFC_EDT, AF9->AF9_TAREFA) })
oTarefa:Cell("AF9_DESCRI"):SetBlock({|| If(aAuxImp[nx][1]=="AFC", ;
											 Repli(".",Val(AFC->AFC_NIVEL)-1)+Substr(AFC->AFC_DESCRI,1,36-Val(AFC->AFC_NIVEL)-1),;
											 Repli(".",Val(AF9->AF9_NIVEL)-1)+Substr(AF9->AF9_DESCRI,1,36-Val(AFC->AFC_NIVEL)-1)) ;
									 })

Do Case
	Case mv_par08==1
		dAuxIni := mv_par06
	Case mv_par08==2
		dAuxIni := mv_par06
		If DOW(dAuxIni)<>1
			dAuxIni -= DOW(dAuxIni)-1
		EndIf
	Case mv_par08==3
		dAuxIni := CTOD("01/"+StrZero(MONTH(mv_par06),2,0)+"/"+StrZero(YEAR(mv_par06),4,0))-1
EndCase
dCabIni := dAuxIni

Do Case
	Case mv_par08 == 1
		dCabFim := dCabIni+5
	Case mv_par08==2
		dCabFim := dCabIni+(5*7)
	Case mv_par08==3
		dCabFim := dCabIni+(5*31)
		dCabFim := CTOD("01/"+StrZero(MONTH(dCabFim),2,0)+"/"+StrZero(YEAR(dCabFim),4,0))-1
EndCase

dx := dCabIni
nPeriodo := 1

While dx <= dCabFim
	oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_V"):SetTitle(DTOC(dx) + CRLF + STR0018) //"Valor"
	oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_P"):SetTitle(DTOC(dx) + CRLF+ STR0020) //"%Perc."
	nPeriodo++
	Do Case
		Case mv_par08 == 1
			dx++
		Case mv_par08==2
			dx+= 7
		Case mv_par08==3
			dx+= 35
			dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
	EndCase
EndDo

oProjeto:Init()
oProjeto:PrintLine()
oProjeto:Finish()

oReport:FatLine()

oTarefa:Init()

While (dAuxFim==Nil .Or. dAuxFim < mv_par07) .AND. lLoop

	If oReport:Cancel()
		lLoop := .F.
		Exit
	Endif

	Do Case
		Case mv_par08 == 1
			dAuxFim := dAuxIni+5
		Case mv_par08==2
			dAuxFim := dAuxIni+(5*7)
		Case mv_par08==3
			dAuxFim := dAuxIni+(5*31)
			dAuxFim := CTOD("01/"+StrZero(MONTH(dAuxFim),2,0)+"/"+StrZero(YEAR(dAuxFim),4,0))-1
	EndCase
	
	For nx := 1 to Len(aAuxImp)
	
		If mv_par10 ==1 // .Or. aAuxImp[nx,4] > 0

			If aAuxImp[nx][1]=="AFC"
				AFC->(dbGoto(aAuxImp[nx,2]))
			Else
				AF9->(dbGoto(aAuxImp[nx,2]))
			EndIf
			
			nColuna := 0
			dx := dAuxIni
			nPeriodo := 1

			While dx <= dAuxFim
			
				If !Empty(aAuxImp[nx,3])
				
					nPos := aScan(aAuxImp[nx][3],{|x|x[1]==dx})
					
					If nPos > 0 .And. aAuxImp[nx,5]
					
						If (aAuxImp[nx,3,npos,2]/aAuxImp[nx,4]*100) > 100
							aAuxImp[nx,5] := .F.
						EndIf
					
						oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_V"):SetValue(If(mv_par09==1,aAuxImp[nx,3,npos,2],aAuxImp[nx,3,npos,2]-aAuxImp[nx,6]))
						oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_P"):SetValue(If(mv_par09==1,aAuxImp[nx,3,npos,2],aAuxImp[nx,3,npos,2]-aAuxImp[nx,6])/aAuxImp[nx,4]*100)
						
						aAuxImp[nx][6] := aAuxImp[nx,3,npos,2]
					Else
					
						oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_V"):SetValue(0)
						oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_P"):SetValue(0)
					EndIf
					
				EndIf
				
				Do Case
					Case mv_par08 == 1
						dx++
					Case mv_par08==2
						dx+= 7
					Case mv_par08==3
						dx+= 35
						dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
				EndCase
				
				nColuna++
				nPeriodo++
				
			EndDo
			
			oTarefa:PrintLine()
			oReport:SkipLine()

		EndIf

		If oReport:Cancel()
			lLoop := .F.
			Exit
		Endif

	Next nX

	dAuxIni := dx
	dCabIni := dx
	
	Do Case
		Case mv_par08 == 1
			dCabFim := dCabIni+5
		Case mv_par08==2
			dCabFim := dCabIni+(5*7)
		Case mv_par08==3
			dCabFim := dCabIni+(5*31)
			dCabFim := CTOD("01/"+StrZero(MONTH(dCabFim),2,0)+"/"+StrZero(YEAR(dCabFim),4,0))-1
	EndCase

	dx := dCabIni
	nPeriodo := 1

	While dx <= dCabFim
		oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_V"):SetTitle(DTOC(dx)+CRLF+STR0018)
		oTarefa:Cell("PERIODO-"+Str(nPeriodo,1)+"_P"):SetTitle(DTOC(dx)+CRLF+STR0020)
		nPeriodo++

		Do Case
			Case mv_par08 == 1
				dx++
			Case mv_par08==2
				dx+= 7
			Case mv_par08==3
				dx+= 35
				dx := CTOD("01/"+StrZero(MONTH(dx),2,0)+"/"+StrZero(YEAR(dx),4,0))-1
		EndCase
		
	EndDo
	
	If dAuxFim < mv_par07
		oReport:EndPage()
	EndIf
	
EndDo

oTarefa:Finish()

Return

Static Function PMR120Rec()
Local lRet		:=	.F. 
If !Empty(mv_par11) .Or. mv_par12 <> Replicate('z',TamSx3('AFA_RECURS')[1])
	DbSelectArea('AFA')
  	DbSetOrder(5)
  	DbSeek(xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA+MV_PAR11,.T.)
  	If AFA_FILIAL+AFA_PROJET+AFA_REVISA+AFA_TAREFA == xFilial()+AF9->AF9_PROJET+AF9->AF9_REVISA+AF9->AF9_TAREFA .And.;
  		AFA_RECURS <= MV_PAR12
  		lRet	:=	.T.
	Endif
Else
	lRet	:=	.T.   	
Endif
Return lRet

