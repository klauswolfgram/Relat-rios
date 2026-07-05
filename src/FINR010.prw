/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR010.CH"
#include "PROTHEUS.CH"
#INCLUDE "fwcommand.ch"

Static _oFINR010

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR010  ³ Autor ³ Daniel Batori         ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio do cadastro do plano de classses orcamentarios    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR010()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR010()
Local oReport

Private nTamCod

oReport := ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 31/05/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Rela‡„o das naturezas                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR010R4(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oSection

//Gestao
PRIVATE cNomFil := ""



oReport := TReport():New("FINR010",STR0014,,{|oReport| U_ReportPrint(oReport)},STR0001+STR0002) //"RELACAO DAS NATUREZAS"

nTamCod := 0

//Gestao
oReport:SetUseGC(.F.)

SED->(dbSetOrder(1))
SED->(dbGoTop())

While SED->(!Eof())
	If( Len(MascNat(SED->ED_CODIGO)) > nTamCod )
		nTamCod := Len(MascNat(SED->ED_CODIGO))
	EndIf
	SED->(dbSkip())
EndDo

nTamDesc:= TamSX3("ED_DESCRIC")[1]

oSection := TRSection():New(oReport,STR0014,{"TRB","SED"})
TRCell():New(oSection,"ED_CODIGO" ,"SED",                               ,,nTamCod  ,.F.,{||TRB->CODIGO})
TRCell():New(oSection,"ED_DESCRIC","SED",                               ,,         ,.F.,{||TRB->DESCRICAO})
TRCell():New(oSection,"CODIGO1"   ,     ,AllTrim(RetTitle("ED_CODIGO")) ,,nTamCod  ,.F.,{||TRB->CODIGO1})
TRCell():New(oSection,"DESCRI1"   ,     ,AllTrim(RetTitle("ED_DESCRIC")),,nTamDesc ,.F.,{||TRB->DESCRI1})

oReport:SetPortrait()

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³02/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os  ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ReportPrint(oReport)
Local oSection := oReport:Section(1)
Local aCampos := {}
Local aTam1
Local aTam2
Local nRow, nPos
Local cFilterUser := oSection:GetAdvplExp("SED")

//Gestao
Local cFilTAB 	:= cFilAnt
Local cFilSM0 	:= cFilAnt
Local nRecSM0Atu	:= SM0->(Recno())
Local nRegSM0 	:= SM0->(Recno())
Local nLenSm0 	:= 0
Local lGestao   := ( FWSizeFilial() > 2 ) 	// Indica se usa Gestao Corporativa
Local lSEDAccess:= Iif( lGestao, FWModeAccess("SED",1) == "E", FWModeAccess("SED",3) == "E")
Local aSelFil 	:= {}
Local aSm0		:= {}
Local nX		:= 0
Local nLenFil	:= 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam1:= TamSX3("ED_CODIGO")
aTam2:= TamSX3("ED_DESCRIC")

AADD(aCampos,{ "CODIGO"		,"C",IIF(aTam1[1] > nTamCod,aTam1[1],nTamCod),aTam1[2] } )
AADD(aCampos,{ "DESCRICAO"	,"C",aTam2[1],aTam2[2] } )
AADD(aCampos,{ "CODNAT"		,"C",IIF(aTam1[1] > nTamCod,aTam1[1],nTamCod),aTam1[2] } )
AADD(aCampos,{ "CODIGO1"	,"C",IIF(aTam1[1] > nTamCod,aTam1[1],nTamCod),aTam1[2] } )
AADD(aCampos,{ "DESCRI1"	,"C",aTam2[1],aTam2[2] } )
AADD(aCampos,{ "CODNAT1"	,"C",IIF(aTam1[1] > nTamCod,aTam1[1],nTamCod),aTam1[2] } )
AADD(aCampos,{ "RECFIL"		,"N",10,0 } )

//Gestao
nRegSM0 := SM0->(Recno())
If lSEDAccess	//filial nao totalmente compartilhada
	If !IsBlind()	//controle via job
		If FindFunction("FwSelectGC") .AND. lGestao
			aSelFil := FwSelectGC()
		Else
			aSelFil := AdmGetFil(.F.,.F.,"SED")
		Endif
	EndIf
Endif
If Empty(aSelFil)
	aSelFil := {cFilAnt}
Endif
SM0->(DbGoTo(nRegSM0))

//Gestao
aSM0 := F010AbreSM0(aSelFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ChkFile("SED",.F.,"SED1")

//cria um indice temporario
dbSelectarea("SED1")

_oFINR010 := FwTemporaryTable():New("TRB")
_oFINR010:SetFields(aCampos)
_oFINR010:AddIndex("1",{"RECFIL","CODIGO","DESCRICAO"})
_oFINR010:Create()

DbSelectArea('SED')
If !Empty(cFilterUser)
	DbSetFilter({||&(cFilterUser)},cFilterUser)
Endif
SED->(dbSetOrder(1))
SED->(dbGoTop())
SED1->(dbSetOrder(3))
SED1->(dbGoTop())


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ inclui na TRB os registros ordenados por ED_CODIGO e por ED_DESCRIC³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//Gestao
nLenSm0 := Len(aSm0)
nX := 1
While nX <= nLenSM0

	cFilSM0 := aSm0[nX,2]
	cFilTAB := FWxFilial("SED", cFilSM0)

	SED1->(dbSeek(cFilTAB))
	SED->(dbSeek(cFilTAB))

	While SED1->(!Eof())
		If SED1->ED_FILIAL == cFilTAB
			Reclock("TRB",.T.)
			TRB->CODIGO		:= MascNat(SED->ED_CODIGO)
			TRB->DESCRICAO	:= SED->ED_DESCRIC
			TRB->CODNAT		:= SED->ED_CODIGO
			Trb->CODIGO1	:= MascNat(SED1->ED_CODIGO)
			Trb->DESCRI1	:= SED1->ED_DESCRIC
			Trb->CODNAT1	:= SED1->ED_CODIGO
			TRB->RECFIL		:= aSm0[nX,SM0_RECNO]
			MsUnlock( )
		EndIf
		SED1->(dbSkip())
		SED->(dbSkip())
	EndDo

	cFilSM0 := Alltrim(cFilSM0)
	nLenFil := Len(cFilSM0)
	While .T.
		If nX <= nLenSm0 .and. Substr(aSm0[nX,2],1,nLenFil) == cFilSM0
			nX++
		Else
			Exit
		Endif
	Enddo
Enddo

oReport:NoUserFilter()
oReport:SetMeter(TRB->(Reccount()))


dbSelectArea("TRB")
Trb->(dbGoTop())

While !Eof()
	oSection:Init()
	nRegSM0 := TRB->RECFIL
	SM0->(DbGoto(nRegSM0))
	cFilSM0 := SM0->M0_CODFIL

	oReport:PrintText(" ")

	nRow := oReport:Row()
	nPos := oSection:Cell("CODIGO1"):ColPos()

	oReport:PrintText(STR0012,nRow)
	oReport:PrintText(STR0013,nRow,nPos)
	oReport:SkipLine()
	oReport:FatLine()

	While Trb->(!eof()) .and. TRB->RECFIL == nRegSM0
		SED->(DBSetOrder(1))
		SED->(MsSeek(xFilial("SED")+TRB->CODNAT))
		SED1->(DBSetOrder(1))
		SED1->(MsSeek(xFilial("SED")+TRB->CODNAT1))
		oSection:PrintLine()
		oReport:IncMeter()
		Trb->(dbSkip())
	Enddo

	oReport:EndPage()
	oSection:Finish()

EndDo

DbSelectArea('SED')
If Empty(cFilterUser)
	SET filter to
Endif

Trb->(dbCloseArea())
SED1->(dbCloseArea())
If _oFINR010 <> Nil

	_oFINR010:Delete()
	_oFINR010 := Nil

EndIf		

//Gestao
SM0->(DbGoTo(nRecSM0Atu))

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³F010AbreSM0³ Autor ³ Mauricio Pequim Jr   ³ Data ³ 02/10/13 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Retorna um array com as informacoes das filias das empresas ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F010AbreSM0(aSelFil)

Local aArea			:= SM0->( GetArea() )
Local aRetSM0		:= {}
Local nLaco			:= 0

aRetSM0	:= FWLoadSM0()

If Len(aRetSM0) != Len(aSelFil)
	For nLaco := Len(aRetSM0) To 1 Step -1
		cFilx := aRetSm0[nLaco,SM0_CODFIL]
		nPosFil := Ascan(aSelFil,aRetSm0[nLaco,SM0_CODFIL])
		If aRetSm0[nLaco,1] != cEmpAnt
			nPosFil := 0
		EndIf
		If nPosFil == 0
			ADel(aRetSM0,nLaco)
			aSize(aRetSM0, Len(aRetSM0)-1)
		Endif
	Next
Endif

aSort(aRetSm0,,,{ |x,y| x[SM0_CODFIL] < y[SM0_CODFIL] } )
RestArea( aArea )

Return aClone(aRetSM0)