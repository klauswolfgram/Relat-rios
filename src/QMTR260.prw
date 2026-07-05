/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QMTR260.CH"
#INCLUDE "Protheus.CH"
#INCLUDE "Report.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QMTR260   ºAutor  ³Leandro Sabino      º Data ³  18/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relacao de Ordens de Servicos                              º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                            
User Function QMTR260()
Local oReport

If TRepInUse()
	Pergunte("QMR260",.F.) 
    oReport := ReportDef()
    oReport:PrintDialog()
Else
	U_QMTR260R3()	// Executa versão anterior do fonte
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ ReportDef()   ³ Autor ³ Leandro Sabino   ³ Data ³ 18/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Montar a secao				                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()				                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local ctitulo := STR0002//"Planilha de Entrada" 
Local cDesc1  := STR0001//"Este programa ir  emitir a planilha de entrada"
Local oSection1 
Local aOrdem  := {}

//Definicao de Indices
Aadd( aOrdem, OemToAnsi(STR0005) ) // Por Nota
Aadd( aOrdem, OemToAnsi(STR0006) ) // Por Produto 

DEFINE REPORT oReport NAME "QMTR260" TITLE cTitulo PARAMETER "QMR260" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION (cDesc1)
oReport:SetLandscape(.T.)

oSection1 := TRSection():New(oReport,OemToAnsi(STR0005),{"QMZ","QMB"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/) //Ordem de Servicos

DEFINE CELL NAME "QMZ_COD"      OF oSection1 ALIAS "QMZ" TITLE STR0005  SIZE (TamSx3("QMZ_NTFISC")[1])
DEFINE CELL NAME "QMZ_DTPREV"   OF oSection1 ALIAS "QMZ" TITLE TitSx3("QMZ_DTPREV")[1]  SIZE (TamSx3("QMZ_DTPREV")[1])
DEFINE CELL NAME "QMZ_DTSAID"   OF oSection1 ALIAS "QMZ" TITLE TitSx3("QMZ_DTSAID")[1]  SIZE (TamSx3("QMZ_DTSAID")[1])
DEFINE CELL NAME "QMZ_CLIENT"   OF oSection1 ALIAS "QMZ" TITLE TitSx3("QMZ_CLIENT")[1]  SIZE 50
DEFINE CELL NAME "QMB_MATERI"   OF oSection1 ALIAS "QMZ" TITLE STR0010 SIZE (TamSx3("QMB_MATERI")[1] + TamSx3("QM2_DESCR")[1]+5) //("Instrumento/Material")
DEFINE CELL NAME "QMB_TEXTO"  	OF oSection1 ALIAS "QMB" TITLE TitSx3("QMB_TEXTO")[1]   SIZE 28 LINE BREAK  BLOCK {||MSMM(QMB->QMB_CHAVE,35)}
DEFINE CELL NAME "QMB_ITEM"     OF oSection1 ALIAS "QMZ" TITLE TitSx3("QMB_ITEM")[1]    SIZE (TamSx3("QMB_ITEM")[1])+4
DEFINE CELL NAME "cInspe"       OF oSection1 ALIAS TITLE STR0012

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PrintReport   ³ Autor ³ Leandro Sabino   ³ Data ³ 13/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relacao de Ordens de Servicos							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PrintReport(ExpO1)  	     	                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = Objeto oPrint                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QMTR260                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  
Static Function PrintReport(oReport) 
Local oSection1 	:= oReport:Section(1)
Local TRB_ZCOD	 	:= ""
Local TRB_ZCLIENT	:= ""
Local TRB_ZLOJA		:= ""
Local TRB_ZDTPREV	:= ""
Local TRB_ZDTSAID	:= ""
Local cNomeCli		:= ""
Local cKey		:= ""
Local oQMZ 	    := oReport:Section(1)
Local aInstru       := {}
Local nTm			:= 1
Local lPrint        := .T.  
Local aArea			:= GetArea()
Local nOrdem    	:= oReport:Section(1):GetOrder() 

dbSelectArea("QMZ")
dbSetOrder(1)            

    MakeSqlExpr(oReport:uParam)
   
If	Upper(TcGetDb()) $ 'INFORMIX'     
  	cKey += "%1,2%"
Else		
  	cKey += "%QMZ_FILIAL,QMZ_COD%"     	 
Endif	

    BEGIN REPORT QUERY oQMZ
    
    BeginSql Alias "TRB"
 				                       	
SELECT QMZ.QMZ_FILIAL,QMZ.QMZ_COD,QMZ.QMZ_CLIENT,QMZ.QMZ_LOJA,QMZ.QMZ_DTPREV,QMZ.QMZ_DTSAID,QMZ.QMZ_TPSERV,
	QMZ.QMZ_TPSERV,QMZ.QMZ_VENDED,QMZ.QMZ_FREQUE,QMZ.QMZ_TIPO  

FROM %table:QMZ% QMZ ,%table:SA1% SA1

WHERE 
QMZ.QMZ_FILIAL = %xFilial:QMZ%  AND 
QMZ.QMZ_COD    BetWeen %Exp:mv_par01% AND %Exp:mv_par02% AND 
QMZ.QMZ_CLIENT BetWeen %Exp:mv_par03% AND %Exp:mv_par04% AND  
QMZ.QMZ_DTPREV BetWeen %Exp:DTOS(mv_par05)% AND %Exp:DTOS(mv_par06)% AND 
QMZ.QMZ_CLIENT = SA1.A1_COD AND  
QMZ.QMZ_LOJA = SA1.A1_LOJA AND  
QMZ.%notDel% AND QMZ.%notDel% 		

ORDER BY %Exp:cKey%	        

EndSql          

END REPORT QUERY oQMZ

dbSelectArea("TRB")
dbGoTop()	

While !Eof()
	Aadd(aInstru,{TRB->QMZ_FILIAL,TRB->QMZ_COD,TRB->QMZ_CLIENT,TRB->QMZ_LOJA,TRB->QMZ_DTPREV,TRB->QMZ_DTSAID})
	dbSkip()
Enddo    
	
If nOrdem == 2	// Indice por Cliente
	aSort(aInstru,,,{|x,y| x[3] < y[3]}) 
Else 			// Indice por Ordem de Servico
	aSort(aInstru,,,{|x,y| x[2] < y[2]}) 
Endif	      

TRB->(dbCloseArea())	

While nTm <= Len(aInstru) 
	TRB_ZCOD	:= aInstru[nTm][2]
	TRB_ZCLIENT	:= aInstru[nTm][3]
	TRB_ZLOJA	:= aInstru[nTm][4]
	TRB_ZDTPREV	:= aInstru[nTm][5]
	TRB_ZDTSAID	:= aInstru[nTm][6]

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura a descricao da familia no QM1                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA1")
	dbSetOrder(1)
	If dbSeek(xFilial("SA1")+TRB_ZCLIENT+TRB_ZLOJA)
		cNomeCli := Alltrim(SA1->A1_COD+" - "+SubStr(SA1->A1_NOME,1,31))
	Endif
		
	dbSelectArea( "QMB" )
	dbSetOrder( 1 )
	If dbSeek( xFilial("QMB") + TRB_ZCOD )

	    oSection1:Init()
		oSection1:CELL("QMZ_COD"):SetValue(TRB_ZCOD) 
		oSection1:CELL("QMZ_DTPREV"):SetValue(TRB_ZDTPREV)
		oSection1:CELL("QMZ_DTSAID"):SetValue(TRB_ZDTSAID)
		oSection1:CELL("QMZ_CLIENT"):SetValue(cNomeCli)
		oSection1:CELL("QMB_MATERI"):SetValue(QMB->QMB_MATERI)		
		
		While !QMB->(Eof()) .and. QMB->QMB_FILIAL+QMB->QMB_COD == xFilial("QMB")+TRB_ZCOD
			dbSelectArea("QM2")
			dbSetOrder(1)
			If dbSeek(xFilial("QM2")+SubStr(QMB->QMB_MATERI,1,16))
			    If (lPrint)
					oSection1:CELL("QMZ_COD"):Show()
					oSection1:CELL("QMZ_DTPREV"):Show()
					oSection1:CELL("QMZ_DTSAID"):Show()
					oSection1:CELL("QMZ_CLIENT"):Show()
			    Else
					oSection1:CELL("QMZ_COD"):Hide()
					oSection1:CELL("QMZ_DTPREV"):Hide()
					oSection1:CELL("QMZ_DTSAID"):Hide()
					oSection1:CELL("QMZ_CLIENT"):Hide()
			    Endif
			    
				oSection1:CELL("QMB_MATERI"):SetValue(Alltrim(QMB->QMB_MATERI)+" - "+Alltrim(QM2->QM2_DESCR))
				oSection1:CELL("QMB_TEXTO"):SetValue(MSMM(QMB->QMB_CHAVE))				
				oSection1:CELL("QMB_ITEM"):SetAlign(2) 
				oSection1:CELL("QMB_ITEM"):SetValue(Space(2)+QMB->QMB_ITEM) 				
				oSection1:CELL("cInspe"):SetValue(Space(10))
				oSection1:PrintLine() 
				oReport:SkipLine(1)	
				lPrint:= .F.
			Endif	
			dbSelectArea("QMB")
			dbSkip()
		Enddo 
		If lPrint
			oSection1:PrintLine()
		Endif	
	Endif
	nTm++
	oReport:ThinLine()
	oReport:SkipLine(1)	
	lPrint := .T.
EndDo

oSection1:Finish()

RestArea(aArea)

Return NIL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QMTR260R3³ Autor ³ Denis Martins         ³ Data ³ 26.02.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Ordens de Servicos                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QMTR260                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Denis     ³Melhor³ Criacao do relatorio                                ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function QMTR260R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cDesc1	:= STR0001//"Este programa ir  emitir a planilha de entrada"
Local cDesc2	:= ""
Local cDesc3	:= ""
Local wnrel		:= ""
Local lImpLin2	:= .T.
Local cString	:="QMZ"

Private titulo	 := STR0002//"Planilha de Entrada" 
Private cabec1	 := ""
Private cabec2	 := ""
Private aReturn	 := { STR0003, 1,STR0004, 1, 2, 1, "",1 } //"Zebrado"###"Administra‡„o"
Private nomeprog :="QMTR260"
Private cPerg	 :="QMR260"
Private cTamanho := "G"

aOrd := {STR0005,STR0006} //"Ordem de Servico" , "Cliente"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("QMR260",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                  ³
//³ mv_par01   : Ordem de Servico Inicial                 ³
//³ mv_par02   : Ordem de Servico Final                   ³
//³ mv_par03   : Cliente Inicial                          ³
//³ mv_par04   : Cliente Final                            ³
//³ mv_par05   : Data de Entrada de                       ³
//³ mv_par06   : Data de Entrada ate                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="QMTR260"   //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,cTamanho,{},.F.)

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| MTR260Imp(@lEnd,wnRel,cString,lImpLin2)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MTR260Imp³ Autor ³ Denis Martins         ³ Data ³ 26.02.03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ MTR260Imp(lEnd,wnRel,cString)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - Acao do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MTR260Imp(lEnd,wnRel,cString,lImpLin2)

Local CbCont
Local CbTxt
Local nOrdem		:= IndexOrd()
Local cAlias		:= Alias()
Local nIndex		:= 0
Local cKey			:= ""
Local nTm			:= 1
Local cNome
Local aObs          := {}
Local nI            := 1
			
Private cIndex      := ""
Private lAbortPrint := .F.
Private aInstru := {}
Private	TRB_ZFILIAL	 
Private	TRB_ZCOD	
Private	TRB_ZCLIENT	
Private	TRB_ZLOJA	
Private	TRB_ZINSTR	
Private	TRB_ZDTPREV	
Private	TRB_ZDTSAID	
Private	TRB_ZTPSERV	
Private	TRB_ZVENDED	
Private	TRB_ZFREQUE 
Private	TRB_ZTIPO	
Private	TRB_BCOD	
Private	TRB_BITEM	
Private	TRB_BMATERI	
Private	TRB_BCONTRA	
Private	TRB_BFAIXA	
Private	TRB_BPRECO	
Private	TRB_BAPROVS	
Private	TRB_BTEXTO	
Private	TRB_BCHAVE	
Private cNomeCli	:= ""
Private cCods		:= ""
Private lFirst
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := STR0007//"Planilha de Entrada"
/*
          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6          7         8         9         20        1         2
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678900123456789012345678901234567890123456789012345678901234567890
Ordem de Servico  Data de Entrada  Data de Saida   C O D I G O / N O M E  D O  C L I E N T E   I N S T R U M E N T O ( S ) / M A T E R I A L ( I S ) / O B S .   Item  Inspecao
XXXXXXXXXXXX      	XX/XX/XXXX      XX/XX/XXXX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
*/
Cabec1:= STR0008 //"|        O.Servico | Data de Entrada | Data de Saida | C O D I G O / N O M E  D O  C L I E N T E | I N S T R U M E N T O ( S ) / M A T E R I A L ( I S ) / O B S E R V A C O E S	| Item | Inspecao "

cabec2 :=""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := Space(10)
cbcont   := 0
li       := 80
m_pag    := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a Ordem (informada na SetPrint)  ser utilizada      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("QMZ")
dbSetOrder(1)            

cQuery := "SELECT QMZ_FILIAL,QMZ_COD,QMZ_CLIENT,QMZ_LOJA,QMZ_DTPREV,QMZ_DTSAID,"
cQuery += "QMZ_TPSERV,QMZ_VENDED,QMZ_FREQUE,QMZ_TIPO " 
cQuery += "FROM "+RetSqlName("QMZ")+" QMZ, "					
cQuery += RetSqlName("SA1")+" SA1 "
cQuery += "WHERE "
cQuery += "QMZ.QMZ_FILIAL = '"				+xFilial("QMZ")+	"' AND "
cQuery += "QMZ.QMZ_COD    BetWeen '"		+ mv_par01 +		"' AND '" + mv_par02 +			"' AND " 
cQuery += "QMZ.QMZ_CLIENT BetWeen '"		+ mv_par03 +		"' AND '" + mv_par04 + 			"' AND " 
cQuery += "QMZ.QMZ_DTPREV BetWeen '"		+ DTOS(mv_par05) +		"' AND '" + DTOS(mv_par06) + 			"' AND " 
cQuery += "QMZ.QMZ_CLIENT = SA1.A1_COD AND " 
cQuery += "QMZ.QMZ_LOJA = SA1.A1_LOJA AND " 
cQuery += "QMZ.D_E_L_E_T_= ' ' " + " AND " + "SA1.D_E_L_E_T_= ' ' "

If UPPER(TcGetDB()) == "INFORMIX"
		cKey := "1,2"
Else		
		cKey := "QMZ_FILIAL,QMZ_COD"
Endif	

cQuery += "ORDER BY " + cKey
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)
TcSetField("TRB","QMZ_DTPREV","D",8,0)
TcSetField("TRB","QMZ_DTSAID","D",8,0)

dbSelectArea( "TRB" )                 
While !Eof()
	Aadd(aInstru,{TRB->QMZ_FILIAL,TRB->QMZ_COD,TRB->QMZ_CLIENT,TRB->QMZ_LOJA,TRB->QMZ_DTPREV,TRB->QMZ_DTSAID,;
				TRB->QMZ_TPSERV,TRB->QMZ_VENDED,TRB->QMZ_FREQUE,TRB->QMZ_TIPO})
	dbSkip()
Enddo

If aReturn[8] == 2 // Indice por Cliente
	aSort(aInstru,,,{|x,y| x[3] < y[3]}) 
Else // Indice por Ordem de Servico
	aSort(aInstru,,,{|x,y| x[2] < y[2]}) 
Endif	      

SetRegua(RecCount())                  

While nTm <= Len(aInstru) 
	TRB_ZFILIAL	:= aInstru[nTm][1]
	TRB_ZCOD	:= aInstru[nTm][2]
	TRB_ZCLIENT	:= aInstru[nTm][3]
	TRB_ZLOJA	:= aInstru[nTm][4]
	TRB_ZDTPREV	:= aInstru[nTm][5]
	TRB_ZDTSAID	:= aInstru[nTm][6]
	TRB_ZTPSERV	:= aInstru[nTm][7]
	TRB_ZVENDED	:= aInstru[nTm][8]
	TRB_ZFREQUE := aInstru[nTm][9]
	TRB_ZTIPO	:= aInstru[nTm][10]
		
	IncRegua()
	
	If lAbortPrint
		li := li + 1
		@li,001 PSAY STR0009//"CANCELADO PELO OPERADOR"
		Exit
	EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Procura a descricao da familia no QM1                        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			dbSelectArea("SA1")
			dbSetOrder(1)
			If dbSeek(xFilial("SA1")+TRB_ZCLIENT+TRB_ZLOJA)
				cNome    := SubStr(SA1->A1_NOME,1,31)
				cNomeCli := Alltrim(SA1->A1_COD+" - "+cNome)
			Endif
				
			dbSelectArea( "QMB" )
			dbSetOrder( 1 )
			If dbSeek( xFilial("QMB") + TRB_ZCOD )
				cCods := TRB_ZCOD
				If li > 50
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
				Endif	
	/*
   	          1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6          7         8         9         20        1         2
	01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	| Ordem de Servico | Data de Entrada | Data de Saida | C O D I G O / N O M E  D O  C L I E N T E | I N S T R U M E N T O ( S ) / M A T E R I A L ( I S ) / O B S E R V A C O E S	| Item | Inspecao 
	   XXXXXXXXXXXX        XX/XX/XXXX       XX/XX/XXXX     XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX |  XX  | XXXXXXXX 
	*/
				If li > 50
					cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
				Endif	
				@ li,000 PSAY "|"
				@ li,015 PSAY TRB_ZCOD	 			
				@ li,030 PSAY "|"
				@ li,035 PSAY TRB_ZDTPREV
				@ li,048 PSAY "|"
				@ li,052 PSAY TRB_ZDTSAID
				@ li,064 PSAY "|"
				@ li,066 PSAY cNomeCli
				
				lFirst := .t.
				While !QMB->(Eof()) .and. QMB->QMB_FILIAL+QMB->QMB_COD == xFilial("QMB")+cCods
					dbSelectArea("QM2")
					dbSetOrder(1)
					If dbSeek(xFilial("QM2")+SubStr(QMB->QMB_MATERI,1,16))
						If !lFirst
							li++
							If li > 50
								cabec(titulo,cabec1,cabec2,nomeprog,ctamanho,IIF(aReturn[4]==1,15,18))
							Endif	
							@ li,000 PSAY "|"
							@ li,030 PSAY "|"
							@ li,048 PSAY "|"         
							@ li,064 PSAY "|"
						Endif
                        lFirst := .f.
						@li,108 PSAY "|"						
						@li,110 PSAY Alltrim(QMB->QMB_MATERI)+" - "+Alltrim(QM2->QM2_DESCR)
						@li,156 PSAY "|"
						aObs:=JustificaTXT(MSMM(QMB->QMB_CHAVE,TamSX3('QMB_TEXTO')[1]),40,.T.)	
				        For nI:=1 to Len(aObs)
					      	@ Li,158 PSay aObs[nI]
					      	Li++
					    Next  		  	
						@li,192 PSAY "|"
						@li,195 PSAY QMB->QMB_ITEM
						@li,198 PSAY "|"
					Endif	
					dbSelectArea("QMB")
					dbSkip()
				Enddo 
			Endif

	li++
    @li,000 Psay __PrtThinLine()
    li++
	nTm++
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se a linha for 80, ‚ porque nao foi impresso nem a 1§ pag    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If li != 80
	 Roda( cbCont, cbTxt, cTamanho )
EndIf

Set Device To Screen

If File(cIndex+OrdBagExt())
	Set Filter To
	RetIndex("QMZ")
	dbClearInd()
	FErase(cIndex+OrdBagExt())
	dbCloseArea()
Else	
	dbSelectArea("TRB")
	dbCloseArea()
	dbSelectArea("QMZ")
	dbSetOrder(1)
EndIf
dbSelectArea(cAlias)
dbSetOrder(nOrdem)

If aReturn[5] = 1
	Set Printer TO
	dbCommitall()
	ourspool(wnrel)
EndIf
MS_FLUSH()

Return(Nil)
