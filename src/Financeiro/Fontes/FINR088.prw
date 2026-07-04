/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "SIGAWIN.CH"
#include "FINR088.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡…o    ³FINR088   ºAutor  ³ IvanPC             º Data ³  02/15/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impresion de los cheques recibidos aun no ingresados en la º±±
±±º          ³ Movimentacion bancaria de siga (no depositados).           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ FINR088                                                    º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³21/06/06  ³Paulo          ³ Transf. para o release 4                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR088()

	Local oReport

	oReport	:= ReportDef()
	oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Andressa Fagundes      ³ Data ³17/05/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport	:= Nil
Local oCabec	:= Nil
Local aOrd		:= {OemToAnsi(STR0006),OemToAnsi(STR0007),OemToAnsi(STR0008),OemToAnsi(STR0009),OemToAnsi(STR0010)} //"Vencimien." - "Cliente" - "Recibo" - "Numero de Cheque" - "Emision"
Local aMes		:= {OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),OemToAnsi(STR0016),; //"ENERO" - "FEBRERO" - "MARZO" - "ABRIL" - "MAYO" - "JUNIO"
					OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),OemToAnsi(STR0020),OemToAnsi(STR0021),OemToAnsi(STR0022)} //"JULIO" - "AGOSTO" - "SEPT." - "OCTUBRE" - "NOVIEM." - "DICIEM."

Local cTitulo	:= ""
Local cPerg		:= ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Requisitos Entidades Bancarias - Julho de 2012 ³
//³ O Pergunte eh alterado para FIN850B            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  If cPaisLoc == "ARG"
     cPerg := "FIR088A"
  Else
     cPerg := "FIR088"
  EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Componente de impressao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte( cPerg , .T. )

oReport := TReport():New("FINR088", STR0073, cPerg, {|oReport| ReportPrint(oReport)}, STR0002+" "+STR0003) // Este relatorio ira imprimir os movimentos de entrada e saida de produtos incentivados ou nao pelo PRODEPE.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1 - Cabecalho Padrao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabec	:= TRSection():New(oReport,STR0074,{"SE1","SA1"},aOrd,/*Campos do SX3*/,/*Campos do SIX*/) //"Ctas por Cobrar"

TRCell():New(oCabec,"E1_CLIENTE"	,"SE1",	,/*Picture*/,12,/*lPixel*/,)
TRCell():New(oCabec,"E1_LOJA"		,"SE1",	,/*Picture*/,12,/*lPixel*/,)
TRCell():New(oCabec,"E1_NOMCLI"	,"SE1",	,/*Picture*/,TamSX3("E1_NOMCLI")[1],/*lPixel*/,)
If cPaisLoc == "PAR" .And. AllTrim(SE1->E1_ORIGEM) == "LOJA010"
	TRCell():New(oCabec,"E1_NUMCHQ"		,"SE1"	,STR0062 + CHR(13)+ CHR(10)+  STR0063,,,/*lPixel*/,) //"Numero" - "RCBO/CHQ"
Else
	TRCell():New(oCabec,"E1_PREFIXO"		,"SE1"	,,,13,/*lPixel*/,)
	TRCell():New(oCabec,"E1_NUM"			,"SE1"	,,,20,/*lPixel*/,)
	TRCell():New(oCabec,"E1_PARCELA"		,"SE1"	,,,9,/*lPixel*/,)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Requisitos Entidades Bancarias - Julho de 2012 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc == "ARG"
   //--- Verifica se deve levar em conta os Parametros de Entidades Bancarias
   If MV_PAR11 == 1
      If MV_PAR16 == 1        // Por Codigo
         cTitulo := STR0075   // "Bco. Cheque (Bco/Age/Cod. Postal)"
      ElseIf MV_PAR16 == 2    // Por Nome
         cTitulo := STR0076   // "Bco. Cheque (Nome)"
      EndIf
   Else
      cTitulo := Iif(Mv_PAR08==1,STR0069,Iif(Mv_PAR08==2,STR0070,STR0071)) //"Banco Dep.(Nom.) " - "Bco Dep (Bco/ Age/ Cta)" - "Bco Ori.(Bco/ Age/ Cta"
   EndIf
Else
   cTitulo := Iif(Mv_PAR08==1,STR0069,Iif(Mv_PAR08==2,STR0070,STR0071)) //"Banco Dep.(Nom.) " - "Bco Dep (Bco/ Age/ Cta)" - "Bco Ori.(Bco/ Age/ Cta"
EndIf

TRCell():New(oCabec,"E1_EMISSAO"	,"SE1",,/*Picture*/,18,/*lPixel*/,)
TRCell():New(oCabec,"ESTADO"		,     ,STR0064,/*Picture*/,15,/*lPixel*/,{|| Iif (SE1->E1_STATUS = "R",STR0033,Iif(SE1->E1_DTACRED >= dDataBase,STR0034,Iif(SE1->E1_VENCTO < dDataBase,STR0035,STR0036))) }) //"ESTADO" - "Rechazado" - "Clearing" - "Vencido" - "En Fch"
TRCell():New(oCabec,"E1_VENCTO"  ,"SE1",STR0065 + CHR(13)+ CHR(10)+ STR0066 ,/*Picture*/,22,/*lPixel*/,{|| Iif (SE1->E1_STATUS = "R",SE1->E1_VENCTO,Iif(SE1->E1_DTACRED >= dDataBase,SE1->E1_DTACRED,SE1->E1_VENCTO)) }) //"Fch Vto." - "Clearing"
TRCell():New(oCabec,"E1_VALOR"	,"SE1",,TM(SE1->E1_VALOR,13,MsDecimais(MV_PAR10)),20,/*lPixel*/,{|| Iif (MV_PAR09 == 2,xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR10, dDataBase) ,SE1->E1_VALOR) })
TRCell():New(oCabec,"DUMMY",,"",/*Picture*/,6,/*lPixel*/,)
TRCell():New(oCabec,"E1_NUMBCO"	,"SE1",cTitulo,/*Picture*/,60,/*lPixel*/,{|| FIR88BCO()})
TRCell():New(oCabec,"MOEDA" 		,     ,STR0067 + CHR(13)+ CHR(10)+ STR0068	,/*Picture*/,10,/*lPixel*/,{||GetMV("MV_MOEDAP"+STR(SE1->E1_MOEDA,1))}) //"Moned" - "Original "
TRCell():New(oCabec,"MES","","Mes",/*Picture*/,2,/*lPixel*/,{|| aMes[Month(SE1->E1_VENCTO)] })

TrPosition():New(oCabec,'SA1',1,{|| xFilial('SA1')+SE1->(E1_CLIENTE+E1_LOJA)})

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Paulo Augusto          ³ Data ³21.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local cFilterUser	:= ""
Local oCabec		:= oReport:Section(1)
Local cFiltro		:= ""
Local nOrder		:= oReport:Section(1):GetOrder()
Local oBreak		:= Nil
Local oBreak2		:= Nil
Local xAnt			:= Nil
Local aMes			:= {OemToAnsi(STR0011),OemToAnsi(STR0012),OemToAnsi(STR0013),OemToAnsi(STR0014),OemToAnsi(STR0015),OemToAnsi(STR0016),; //"ENERO" - "FEBRERO" - "MARZO" - "ABRIL" - "MAYO" - "JUNIO"
						OemToAnsi(STR0017),OemToAnsi(STR0018),OemToAnsi(STR0019),OemToAnsi(STR0020),OemToAnsi(STR0021),OemToAnsi(STR0022)} //"JULIO" - "AGOSTO" - "SEPT." - "OCTUBRE" - "NOVIEM." - "DICIEM."
Local cPerg			:= ""

Private cInd	:= CriaTrab(Nil ,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Requisitos Entidades Bancarias - Julho de 2012 ³
//³ O Pergunte eh alterado para FIN850B            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  If cPaisLoc == "ARG"
     cPerg := "FIR088A"
  Else
     cPerg := "FIR088"
  EndIf

If nOrder == 1 // Ordenado por vencto
	oBreak := TRBreak():New(oCabec,oCabec:Cell("MES"),,.F.) //"Total por Mes"
	oBreak:SetTitle({|| STR0030 + aMes[xAnt] }) //"Total"
ElseIf nOrder  == 2 // Ordenado por CLIENTE
	oBreak := TRBreak():New(oCabec,oCabec:Cell("E1_CLIENTE"),,.F.) //"Total por cliente"
	oBreak:SetTitle({|| STR0032 +" "+xAnt }) //"Total"
EndIf

oBreak2 := TRBreak():New(oCabec,oCabec:Cell("DUMMY"),,.F.)
oBreak2:SetTitle({|| STR0072 + AllTrim(GetMV("MV_MOEDAP"+STR(MV_PAR10,1)))}) //"Total gral en "

TRFunction():New(oCabec:Cell("E1_VALOR"),"","SUM",oBreak,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)

TRFunction():New(oCabec:Cell("E1_VALOR"),"","SUM",oBreak2,/*cTitulo*/,/*cPicture*/,/*uFormula*/,.F.,.F.)

MakeAdvplExpr( cPerg )

/*
+-Preguntas---------------------------------+
¦  Mv_par01    ¿Del Cliente       ?         ¦
¦  Mv_par02    ¿Hasta Cliente     ?         ¦
¦  Mv_par03    ¿Del Emissao       ?         ¦
¦  Mv_par04    ¿Hasta Emissao     ?         ¦
¦  Mv_par05    ¿Del Vencimiento   ?         ¦
¦  Mv_par06    ¿Hasta Vencimiento ?         ¦
¦  Mv_par07    ¿Situacao          ?         ¦
¦  Mv_par08    ¿Imprime Banco     ?         ¦
¦  Mv_par09    ¿Quanto a Moeda    ?         ¦
¦  Mv_par10    ¿Que Moeda         ?         ¦
+-------------------------------------------+
*/

cFiltro := 'E1_FILIAL=="' + xFilial("SE1") + '".And.E1_CLIENTE >= "' + MV_PAR01 + '".AND.E1_CLIENTE <= "' + MV_PAR02 + '"'
cFiltro += '.AND. IIF(Type("MVCHEQUES")=="C",E1_TIPO $ MVCHEQUES, Subs(E1_TIPO,1,2) $ MVCHEQUE) .AND. E1_SALDO>0'
cFiltro += '.And. DTOS(E1_VENCTO)  >= "' + DTOS(MV_PAR05) + '".AND.DTOS(E1_VENCTO)  <= "' + DTOS(MV_PAR06) + '"'
cFiltro += '.AND. DTOS(E1_EMISSAO) >= "' + DTOS(MV_PAR03) + '".AND.DTOS(E1_EMISSAO) <= "' + DTOS(MV_PAR04) + '"'

//--- Moeda
If mv_par09 == 1  // Filtra
   cFiltro += '.And.E1_MOEDA== ' + Str(MV_PAR10)
EndIf

//--- Situacao
If mv_par07 == 1     // Carteira
   cFiltro += '.And.E1_SITUACA=="0"'
ElseIf mv_par07 == 2 // Banco
   cFiltro += '.And.E1_SITUACA=="1"'
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Requisitos Entidades Bancarias - Julho de 2012 ³
//³ O Pergunte eh alterado para FIN850B            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  If cPaisLoc == "ARG"
     /*
     +-Preguntas---------------------------------+
     ¦  Mv_par11    ¿Considera Abaixo ?          ¦
     ¦  Mv_par12    ¿Banco Cheque ?              ¦
     ¦  Mv_par13    ¿Agencia Cheque ?            ¦
     ¦  Mv_par14    ¿Conta Cheque ?              ¦
     ¦  Mv_par15    ¿Codigo Postal ?             ¦
     ¦  Mv_par16    ¿Imprime Banco ?             ¦
     +-------------------------------------------+
     */
       //--- Verifica se deve levar em conta os Parametros de Entidades Bancarias
	   If MV_PAR11 == 1
          If Empty( MV_PAR12 )  // Empty( cBcoChq )
             If !Empty( MV_PAR15 )   // !Empty( cPostal )
                 cFiltro += " .And. E1_POSTAL=='" + MV_PAR15 + "'"
             EndIf
          Else
             cFiltro += " .And. E1_BCOCHQ=='" + MV_PAR12 + "'"
             cFiltro += " .And. E1_AGECHQ=='" + MV_PAR13 + "'"
          EndIf
       EndIf
  EndIf
//ÚÄÄÄÄÄÄÄ¿
//³ F I M ³
//ÀÄÄÄÄÄÄÄÙ

Do Case
	Case nOrder==1
		cCHAVE := "E1_VENCTO+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA"
	Case nOrder==2
		cCHAVE := "E1_CLIENTE+E1_LOJA+E1_VENCTO+E1_PREFIXO+E1_NUM+E1_PARCELA"
	Case nOrder==3
		cCHAVE := "E1_SERREC+E1_RECIBO+E1_VENCTO+E1_NUM+E1_PARCELA"
	Case nOrder==4
	   If cPaisLoc == "PAR" .And. (nModulo == 12 .OR. nModulo == 72 )// SIGALOJA //SIGAPHOTO
		  cCHAVE := "E1_NUMCHQ+E1_CLIENTE+E1_LOJA"
	   Else
		  cCHAVE := "E1_PREFIXO+E1_NUM+E1_PARCELA+E1_CLIENTE+E1_LOJA"
	   EndIf
	Case nOrder==5
		cCHAVE := "E1_EMISSAO+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA"
EndCase

cFilterUser := oCabec:GetAdvplExp("SE1")

If !Empty(cFilterUser)
	cFiltro := cFiltro + " .And. " + cFilterUser
Endif

IndRegua("SE1",cInd,cChave,,cFiltro,OemToAnsi(STR0023)) //"Selecc. Cheques..."

nIndex	:=	Retindex("SE1")

DbSelectArea("SE1")
DbSetOrder(nIndex+1)
DbGoTop()

If nOrder == 1
	oBreak:SetBreak(oCabec:Cell("MES"))
ElseIf nOrder ==2
	oBreak:SetBreak(oCabec:Cell("E1_CLIENTE"))
EndIf

oReport:SetTitle(OemToAnsi(STR0028)+DTOC(MV_PAR05)+OemToAnsi(STR0029)+DTOC(MV_PAR06)+ OemToAnsi(STR0061) + GetMV("MV_MOEDAP"+STR(MV_PAR10,1) ) ) // "*** Listado de cheques a acreditar entre el " - " a " - " en "

oReport:Section(1):Cell("MES"):Hide()
oReport:Section(1):Cell("MES"):HideHeader()
oReport:Section(1):Cell("DUMMY"):Hide()
oReport:Section(1):Cell("DUMMY"):HideHeader()
oReport:Section(1):Init()
oReport:Section(1):SetFilter(cFiltro,cChave,,"SE1")
If nOrder == 1 // Ordenado por vencto
	xAnt	:=	Month(SE1->E1_VENCTO)
ElseIf nOrder == 2 // Ordenado por cliente
	xAnt	:=	SE1->E1_CLIENTE
Endif
While !SE1->(Eof())
	oReport:Section(1):PrintLine()
	If nOrder == 1 // Ordenado por vencto
		xAnt	:=	Month(SE1->E1_VENCTO)
	ElseIf nOrder == 2 // Ordenado por cliente
		xAnt	:=	SE1->E1_CLIENTE
	Endif
	SE1->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura Indice de SE1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SE1" )
RetIndex( "SE1" )
Set Filter To

dbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga o arquivo temporario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cInd += OrdBagExt()

If File( cInd )
   FErase( cInd )
EndIf

oReport:Section(1):Finish()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³FIR88BCO  ³ Autor ³Paulo Augusto          ³ Data ³21.06.2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Trazer o banco na impressao conforme a parametrizacao       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FIR88BCO()

//--- Retorno
Local cBANCO := ""

//--- Ambiente
Local aOrigin := GetArea()

/*
Possiveis conteudos do combo de MV_PAR16
Bco Dep(Cod)
Banco Dep(Nome)
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Requisitos Entidades Bancarias - Julho de 2012 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cPaisLoc == "ARG"
   //--- Verifica se deve levar em conta os Parametros de Entidades Bancarias
   If MV_PAR11 == 1

      If MV_PAR16 == 1 // Por Codigo
         cBanco := SE1->E1_BCOCHQ + "/" + SE1->E1_AGECHQ + "/" + SE1->E1_POSTAL
      ElseIf MV_PAR16 == 2   // Por Nome

         //--- Tabela Entidades Bancarias
         dbSelectArea( "FJN" )
         //--- Filia + Banco + Agencia
         dbSetOrder(1) //FJN_FILIAL+FJN_COD+FJN_AGENCI  
         dbSeek( xFilial( "FJN" ) + SE1->E1_BCOCHQ + SE1->E1_AGECHQ )
         cBanco := SubStr( Posicione( "FJO", 1, xFilial("FJO") + FJN->FJN_COD, "FJO_NOME"), 1, 25 )
      EndIf
   Else
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Tratamento Default ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      cBanco := FIR88DFT()
   EndIf
Else
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Tratamento Default ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   cBanco := FIR88DFT()
EndIf

RestArea( aOrigin )

Return( cBanco )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ FIR88DFT ³ Autor ³ Carlos E. Chigres     ³ Data ³ 06/07/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Tratamento Default, antes de Entidades Bancarias           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ String com a Descricao                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function FIR88DFT()

//--- Retorno
Local cBANCO := ""

//--- Ambiente
Local aOrigin := GetArea()

/*
Possiveis conteudos do combo de MV_PAR08
Banco Dep(Nome)
Bco Dep(Cod)
Bco. Orig.
*/
If MV_PAR08 == 3
   //--- Recibos de Cobranca
   dbSelectArea("SEL")
   dbSetOrder( 8 ) //EL_FILIAL+EL_SERIE+EL_RECIBO+EL_TIPODOC+EL_PREFIXO+EL_NUMERO+EL_PARCELA+EL_TIPO
   dbSeek( xFILIAL("SEL") + SE1->E1_SERREC + SE1->E1_RECIBO + "CH" + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA )
	If Found() .And. !Empty( EL_BCOCHQ )
		cBANCO := SUBS(TABELA("95",SEL->EL_BCOCHQ,.F.),1,20)
		cBanco := If(Empty(cBanco),If(Empty(SEL->EL_OBSBCO),SEL->EL_BCOCHQ+"/" +SEL->EL_AGECHQ+"/"+Right(Alltrim(SEL->EL_CTACHQ),8),SEL->EL_OBSBCO),cBanco)
	ElseIf !Empty( SE1->E1_BCOCHQ )
		cBANCO := SUBS(TABELA("95",SE1->E1_BCOCHQ,.F.),1,20)
		cBanco := If(Empty(cBanco),SE1->E1_BCOCHQ+"/" +SE1->E1_AGECHQ+"/"+Right(Alltrim(SE1->E1_AGECHQ),8),cBanco)
	Else
		cBanco	:=	 OemToAnsi(STR0037) //"No registrado"
	Endif
Else
	If Empty( SE1->E1_PORTADO )
		cBanco := OemToAnsi(STR0038)   // "Em Carteira"
	Else
		If SE1->E1_PORTADO $ GetMV("MV_CARTEIR")
			cBanco := OemToAnsi(STR0039) + SE1->E1_PORTADO    // "Caixa "
		Else
			If MV_PAR08 == 1
               dbSelectArea( "SA6" )
               dbSetOrder(1) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
			   If dbSeek( xFilial( "SA6" ) + SE1->E1_PORTADO + SE1->E1_AGEDEP + SE1->E1_CONTA )
				  cBanco := SUBSTR( SA6->A6_NREDUZ,1,27 )
			   EndIf
			Else
				cBanco := SE1->E1_PORTADO + "/" + SE1->E1_AGEDEP + "/" + Right(Alltrim(SE1->E1_CONTA),8)
			EndIf
		EndIf
	EndIf
EndIf

RestArea( aOrigin )

Return( cBanco )
