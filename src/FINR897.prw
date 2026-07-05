/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR897.CH"
#INCLUDE "FIVEWIN.CH"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR897  ³ Autor ³ PAULO AUGUSTO         ³ Data ³ 15.08.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Comissoes.                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FINR897(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR897()

	Local oReport	:= Nil
	
	Private nDecs	:= 2
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³18/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport	:= Nil	
Local oSection1	:= Nil
Local oSection2	:= Nil
Local cReport	:= "FINR897"
Local cDescri	:= OemToAnsi(STR0002) //"Emision del informe de comisiones."

Pergunte( "FIR897" , .F. )

oReport  := TReport():New( cReport, OemToAnsi( STR0018), "FIR897" , { |oReport| ReportPrint( oReport, "SEX" ) }, cDescri )  //"Comision de Cobradores"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,OemToAnsi( STR0019) , {"SAQ"},,/*Campos do SX3*/,/*Campos do SIX*/) //"Cobradores"
TRCell():New( oSection1, "AQ_COD","SAQ" ,/*X3Titulo*/  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,)
TRCell():New( oSection1, "AQ_NOME","SAQ" ,/*X3Titulo*/ ,/*Picture*/,,/*lPixel*/,)	
oSection1:SetNofilter({"SAQ"})

oSection2 := TRSection():New( oSection1,OemToAnsi( STR0020) , {"SEX","SA1"} ) //"Comis."

TRCell():New( oSection2, "COD"			,"" 	,"Codigo Cobrador"/*X3Titulo*/  ,/*Picture*/,TamSX3("AQ_COD")[1]/*Tamanho*/,/*lPixel*/,{||SAQ->AQ_COD})
TRCell():New( oSection2, "NOME"			,"" 	,"Nome" /*X3Titulo*/ ,/*Picture*/,TamSX3("AQ_NOME")[1],/*lPixel*/,{||SAQ->AQ_NOME})	 
TRCell():New( oSection2, "EX_SERREC" 	,"SEX" 	,/*"Recibo"*/  ,/*Picture*/,TamSX3("EX_SERREC")[1],/*lPixel*/,)
TRCell():New( oSection2, "EX_NUM" 		,"SEX"	,"" /*X3Titulo*/  ,/*Picture*/,TamSX3("EX_NUM")[1]+2/*Tamanho*/,/*lPixel*/,)	
TRCell():New( oSection2, "EX_TIPODOC" 	,"SEX"	,/*"Tipo Doc"*/ /*X3Titulo*/  ,/*Picture*/,TamSX3("EX_TIPODOC")[1]/*Tamanho*/,/*lPixel*/,)	
TRCell():New( oSection2, "EX_TITULO"  	,"SEX"	, /*"Numero Doc"X3Titulo()*/,/*Picture*/,TamSX3("EX_TITULO")[1]+3/*Tamanho*/,/*lPixel*/,)	
TRCell():New( oSection2, "EX_CODCLI"  	,"SEX"	,/*"Cod. Cliente" X3Titulo()*/,/*Picture*/,TamSX3("EX_CODCLI")[1],/*lPixel*/,)	  
TRCell():New( oSection2, "EX_LOJA" 		,"SEX"	, /*X3Titulo*/  ,/*Picture*/,TamSX3("EX_LOJA")[1]/*Tamanho*/,/*lPixel*/,)	
TRCell():New( oSection2, "A1_NOME" 		,"SA1"	,/* "Nome Cli"X3Titulo*/  ,/*Picture*/,20/*Tamanho*/,/*lPixel*/,{||SA1->A1_NOME})	
TRCell():New( oSection2, "EX_EMISSAO"  	,"SEX"	, /*X3Titulo()*/,/*Picture*/,TamSX3("EX_EMISSAO")[1]+3,/*lPixel*/,)	  
TRCell():New( oSection2, "EX_DATA"  	,"SEX"	, /*X3Titulo()*/,/*Picture*/,TamSX3("EX_EMISSAO")[1],/*lPixel*/,)	  
TRCell():New( oSection2, "EX_BASE" 		,"SEX"	, /*X3Titulo*/  ,/*Picture*/,16/*Tamanho*/,/*lPixel*/,{|| xmoeda(SEX->EX_BASE,SEX->EX_MOEDA,mv_par06,ddatabase,nDecs)})	
TRCell():New( oSection2, "EX_PORC"  	,"SEX"	, /*X3Titulo()*/,/*Picture*/,TamSX3("EX_PORC")[1]+2/*Tamanho*/,/*lPixel*/,)	
TRCell():New( oSection2, "EX_COMIS"  	,"SEX"	, /*X3Titulo()*/,/*Picture*/,16,/*lPixel*/,{||xMoeda(SEX->EX_COMIS,SEX->EX_MOEDA,mv_par06,ddatabase,nDecs) })	  

Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Paulo Augusto          ³ Data ³18/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao a ReportPrint devera ser criada para todos os        ³±±
±±³          ³relatorios urilizam relatorios configuraveis                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint( oReport )

Local oSection1		:= oReport:Section(1)
Local oSection2		:= oSection1:Section(1)
Local oBreak1		:= Nil
Local cCondicao		:= ""
Local cChave		:= ""
Local cFilterUser	:= ""

nDecs  := GetMv("MV_CENT"+(IIF(mv_par06 > 1 , STR(mv_par06,1),"")))

cCondicao := "SEX->EX_FILIAL=='" +  xFilial("SEX") + "'"
cCondicao += ".And.SEX->EX_COBRAD>='" + mv_par03 + "'"
cCondicao += ".And.SEX->EX_COBRAD<='" + mv_par04 + "'"
cCondicao += ".And.DtoS(SEX->EX_EMISSAO)>='" + DtoS(mv_par01) + "'"
cCondicao += ".And.DtoS(SEX->EX_EMISSAO)<='" + DtoS(mv_par02) + "'"
If mv_par05 == 1 		// Comissoes a pagar
	cCondicao += ".And.Dtos(SEX->EX_DATA)=='"+Dtos(Ctod(""))+"'"
ElseIf mv_par05 == 2 // Comissoes pagas
	cCondicao += ".And.Dtos(SEX->EX_DATA)!='"+Dtos(Ctod(""))+"'"
Endif
If mv_par07 == 2 		// Nao Inclui Comissoes Zeradas
   cCondicao += ".And.SEX->EX_COMIS<>0"
EndIf

If MV_PAR08 == 1 
	cChave := "SEX->(EX_FILIAL+EX_COBRAD+ DTOS(EX_EMISSAO)+EX_SERREC+EX_NUM)"
Else
	cChave := "SEX->(EX_FILIAL+EX_SERREC+EX_NUM+DTOS(EX_EMISSAO))"
EndIf
DbselectArea("SEX")

cFilterUser:= oSection1:GetAdvPlExp("SEX" )
If !Empty(cFilterUser)
	cCondicao +=".And. SEX->(" + cFilterUser +")"
EndIf

oSection2:SetFilter(cCondicao,cChave)
Trposition():New(oReport:Section(1),"SAQ",1,"xfilial()+ SEX->EX_COBRAD")  

Dbgotop()
If MV_PAR08 == 1
	oSection2:Cell("COD"):disable()
	oSection2:Cell("NOME"):disable()
	oBreak1 := TRBreak():New( oSection1,oSection1:Cell("AQ_COD") ,"Total : ") 
	TRFunction():New(oSection2:Cell("EX_BASE")	, , "SUM"  	, oBreak1, , , , .F. ,  )
	TRFunction():New(oSection2:Cell("EX_COMIS")	, , "SUM"  	, oBreak1, , , , .F. ,  )
ELse
	oSection1:Hide()
	TRFunction():New(oSection2:Cell("EX_BASE")	, , "SUM"  	, , , , , .F. ,  )
	TRFunction():New(oSection2:Cell("EX_COMIS")	, , "SUM"  	, , , , , .F. ,  )
EndIf
oSection2:SetParentFilter({|cParam|SEX->EX_COBRAD == cParam },{||SAQ->AQ_COD}) 
oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

oSection1:Print()

DbSelectArea("SEX")
RetIndex("SEX")
DbSetOrder(1) //EX_FILIAL+EX_NUM+DTOS(EX_EMISSAO)+EX_SERREC
DbClearFilter()

Return .T.
