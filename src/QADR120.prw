/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "QADR120.CH"
#include "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QADR015   ºAutor  ³Telso Carneiro      º Data ³  26/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Plano de Auditoria                               º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QADR120()
Local oReport	

If TRepInUse()
	Pergunte("QAR120",.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
Else	
	U_QADR120R3()	// Executa versão anterior do fonte
Endif                

Return


Static Function ReportDef()
Local cDesc1     := OemToAnsi(STR0001) //"Este relatorio tem o objetivo de imprimir a lista de Plano de Audioria"
Local cDesc2     := OemToAnsi(STR0002) //"separadas por areas/departamentos"
Local cString    := "QUM"
Local wnRel      := "QADR120"
Local cPerg    	 := "QAR120"
Local oReport
Local oSection1
Local nLargAp	 := TAMSX3("QAD_DESC")[1]

Private cTitulo := STR0003 //"Plano de Auditoria"  


oReport	:= TReport():New(wnrel,cTitulo,cPerg,{|oReport| PrintReport(oReport) },cDesc1+cDesc2)

oSection1:= TRSection():New(oReport,STR0010,{"QUA","QUM"})  // "Auditorias"            
TRCell():New(oSection1,"CCUSTO",'','AREAS/DEPARTAMENTOS' ,"@!"    ,nLargAp,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES01' ,'','JAN'			     ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES02' ,'','FEV'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES03' ,'','MAR'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES04' ,'','ABR'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES05' ,'','MAI'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES06' ,'','JUN'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES07' ,'','JUL'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES08' ,'','AGO'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES09' ,'','SET'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES10' ,'','OUT'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES11' ,'','NOV'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'MES12' ,'','DEZ'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,'TOTAL' ,'','TOTAL'				 ,"@E 999",3 	  ,/*lPixel*/,/*{|| code-block de impressao }*/)
                                                                       
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrinºAutor  ³Telso Carneiro      º Data ³  16/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio Personalizavel                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³U_QADR120()                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PrintReport(oReport) 
Local cFiltro   := "" 
Local cAliasQUA		:= "QUA"
Local nMes			:= 0 
Local nPosA			:= 0
Local aImprime		:= {} 
Local nA			:= 0

cTitulo  := OemToAnsi(STR0003) //"Plano de Auditoria"

If mv_par01 == mv_par02
	cTitulo := Rtrim(cTitulo) +" "+ OemToAnsi(STR0008)+StrZero(mv_par01,4)	// "Ano: "
Else
	cTitulo := Rtrim(cTitulo) +" "+ OemToAnsi(STR0008)+StrZero(mv_par01,4)+OemToAnsi(STR0009)+StrZero(mv_par02,4)	//"Ano: "### " ate "	
Endif                                                                                                                                   

oReport:SetTitle(cTitulo) 

DbSelectArea("QAD")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao Advpl                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeAdvplExpr(oReport:uParam)

dbSelectArea("QUA")
dbSetOrder(1)

cFiltro:= 'QUA_FILIAL == "'+xFilial("QUA")+'"'
If mv_par05 == 2	// Agendadas
	cFiltro+= ' .AND. QUA_STATUS == "1"'
ElseIf mv_par05 == 3 // Encerradas
	cFiltro+= ' .AND. QUA_STATUS == "2"'
Endif

cFiltro+= ' .AND. YEAR(QUA_ALOC) >= '+StrZero(mv_par01,4)+' .AND. YEAR(QUA_ALOC) <= '+StrZero(mv_par02,4)

oReport:Section(1):SetFilter(cFiltro,'QUA->QUA_FILIAL+QUA->QUA_NUMAUD')

dbSelectArea("QUA")
dbGoTop()

While QUA->(!Eof())

	QUM->(dbSeek(xFilial("QUM")+QUA->QUA_NUMAUD))
	While QUM->(!Eof()) .And. QUA->QUA_FILIAL+QUA->QUA_NUMAUD == xFilial("QUM")+QUM->QUM_NUMAUD
			
		If !Empty(AllTrim(oReport:Section(1):GetAdvplExp("QUM")))
			If !QUM->(&(oReport:Section(1):GetAdvplExp("QUM")))
				QUM->(dbSkip())
				Loop
			Endif
		EndIf

		If mv_par03 > QUM->QUM_CCUSTO .Or. QUM->QUM_CCUSTO > mv_par04
			QUM->(dbSkip())
			Loop
		Endif	

		If (nPosA := Ascan(aImprime,{|x| x[1] == QUM->QUM_CCUSTO })) == 0
			aAdd(aImprime,{QUM->QUM_CCUSTO,0,0,0,0,0,0,0,0,0,0,0,0})
			aImprime[Len(aImprime),Month(QUA->QUA_ALOC)+1] += 1
		Else
			aImprime[nPosA,Month(QUA->QUA_ALOC)+1] += 1		
		Endif
		QUM->(dbSkip())
		
	Enddo
	QUA->(dbSkip())
	
Enddo
	  	

If Len(aImprime) > 0

	aImprime := aSort( aImprime,, , { |x,y| x[1] < y[1] } )

	oReport:SetMeter((cAliasQUA)->(LastRec()))
	
	oReport:Section(1):Init()
	
	For nA:=1 To Len(aImprime)
	
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
		
		oReport:Section(1):Cell("CCUSTO"):SetValue(QA_NDEPT(aImprime[nA,1],.F.,xFilial("QAD")))
		
		nTotMes:=0
		For nMes:=1 to 12
			oReport:Section(1):Cell("MES"+StrZero(nMes,2)):SetValue(aImprime[nA,nMes+1])
			nTotMes+=aImprime[nA,nMes+1]
		Next	
		oReport:Section(1):Cell("TOTAL"):SetValue(nTotMes)	
	
		oReport:Section(1):PrintLine()
			
	Next

	oReport:Section(1):Finish()

	IF 	(cAliasQUA)!='QUA'
		(cAliasQUA)->(DbCloseArea())
	Endif	
Endif

Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QADR120  ³ Autor ³ Aldo Marini Junior    ³ Data ³ 07/09/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Plano de Auditoria                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAQAD                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function QADR120R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1     := STR0001 //"Este relatorio tem o objetivo de imprimir a lista de Plano de Audioria"
Local cDesc2     := STR0002 //"separadas por areas/departamentos"
Local cDesc3     := ''
Local cString    := 'QUM'
Local lEnd       := .F.
Local Titulo     := STR0003 //"Plano de Auditoria"
Local wnRel      := 'QADR120'

Private cTamanho := 'M'
Private aReturn  := {STR0004, 1, STR0005, 1, 2, 1, '', 1}  //"Zebrado"#"Administracao"
Private cPerg    := 'QAR120' 
                             
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg, .F.)

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,cTamanho,"",.F.)

If mv_par01 == mv_par02
	Titulo := Rtrim(Titulo) +" "+ OemToAnsi(STR0008)+StrZero(mv_par01,4)	// "Ano: "
Else
	Titulo := Rtrim(Titulo) +" "+ OemToAnsi(STR0008)+StrZero(mv_par01,4)+OemToAnsi(STR0009)+StrZero(mv_par02,4)	//"Ano: "### " ate "
Endif

If nLastKey == 27
	Set Filter To
	Return Nil
Endif

SetDefault(aReturn, cString)

If nLastKey == 27
	Set Filter To
	Return Nil
Endif

RptStatus({|lEnd| Qad120Imp(@lEnd,wnRel,cString,Titulo)},Titulo)

Set Filter To

Return(NIL)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Qad120Imp ³ Autor ³ Aldo Marini Junior    ³ Data ³07/09/03  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do relato de Plano de Auditoria                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Qad120Imp(lEnd, wnRel, cTamanho, Titulo)					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR120                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Qad120Imp(lEnd,wnRel,cString,Titulo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nTotMes := 0
Local nMes    := 0
Local cFiltro := ""
Local nPosA   := 0
Local nA      := 0
Local nCol    := 36
Local aImprime := {}
	
Private Li      := 80
Private m_pag   := 1
Private cCabec1 := STR0006 //"AREAS/DEPARTAMENTOS                JAN   FEV   MAR   ABR   MAI   JUN   JUL   AGO   SET   OUT   NOV   DEZ   TOTAL "
Private cCabec2 := ""      //           1         2         3         4         5         6         7         8         9         0         1         2
//                            01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   99    99    99    99    99    99    99    99    99    99    99    99    9999
//                                                                36    42    48
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros utilizados                                                        ³
//³ mv_par01 - Ano de                                                            ³
//³ mv_par02 - Ano Ate                                                           ³
//³ mv_par03 - Area de                                                           ³
//³ mv_par04 - Area ate                                                          ³
//³ mv_par05 - Status Agenda 1-Ambas/2-Agendada/3-Encerrada                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Filtro do Ano De/Ate                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QAD->(dbSetorder(1))
QUM->(dbSetOrder(1))
QUA->(DbSetOrder(1))

cFiltro:= 'QUA_FILIAL == "'+xFilial("QUA")+'"'
If mv_par05 == 2	// Agendadas
	cFiltro+= ' .AND. QUA_STATUS == "1"'
ElseIf mv_par05 == 3 // Encerradas
	cFiltro+= ' .AND. QUA_STATUS == "2"'
Endif

cFiltro+= ' .AND. YEAR(QUA_ALOC) >= '+StrZero(mv_par01,4)+' .AND. YEAR(QUA_ALOC) <= '+StrZero(mv_par02,4)
  
If ! Empty(aReturn[7])	// Filtro de Usuario
	cFiltro += " .And. (" + aReturn[7] + ")"
Endif

dbSelectArea("QUA")
Set Filter to &cFiltro
dbGoTop()
SetRegua(LastRec()) // Total de Elementos da Regua

While QUA->(!Eof())

	QUM->(dbSeek(xFilial("QUM")+QUA->QUA_NUMAUD))
	While QUM->(!Eof()) .And. QUA->QUA_FILIAL+QUA->QUA_NUMAUD == xFilial("QUM")+QUM->QUM_NUMAUD
			
		If mv_par03 > QUM->QUM_CCUSTO .Or. QUM->QUM_CCUSTO > mv_par04
			QUM->(dbSkip())
			Loop
		Endif	

		If (nPosA := Ascan(aImprime,{|x| x[1] == QUM->QUM_CCUSTO })) == 0
			aAdd(aImprime,{QUM->QUM_CCUSTO,0,0,0,0,0,0,0,0,0,0,0,0})
			aImprime[Len(aImprime),Month(QUA->QUA_ALOC)+1] += 1
		Else
			aImprime[nPosA,Month(QUA->QUA_ALOC)+1] += 1		
		Endif
		QUM->(dbSkip())
		
	Enddo
	QUA->(dbSkip())
	
Enddo

If Len(aImprime) > 0

	aImprime := aSort( aImprime,, , { |x,y| x[1] < y[1] } )
	
	For nA:=1 to Len(aImprime)
	
		IncRegua()

		If lEnd
			Li++
			@ PROW()+1,001 PSAY OemToAnsi(STR0007) // "CANCELADO PELO OPERADOR"
			Exit
		EndIf

		If Li > 55                    
			Cabec(titulo,cCabec1,cCabec2,wnRel,ctamanho)
		Endif
	                                                       
		QAD->(dbSeek(xFilial("QAD")+aImprime[nA,1]))

		@ Li, 00 pSay PADR(QAD->QAD_DESC,30)
		nTotMes := 0
		nCol := 36
		For nMes:=2 to 13
			@ Li, nCol pSay TransForm(aImprime[nA,nMes],"@E 99")
			nTotMes += aImprime[nA,nMes]
			nCol += 6
		Next
		@ Li, nCol pSay TransForm(nTotMes,"@E 9999")
		Li++
		@ Li, 00 pSay Repl("-",132)
		Li++    
	Next

Endif

If Li # 80
    Roda(0,,cTamanho)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve a condicao original do arquivo principal                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QUA")
Set Filter to &cFiltro

If aReturn[5] == 1
	Set Printer To 
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return(NIL)