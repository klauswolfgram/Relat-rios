/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "rwmake.ch"        // incluido por el asistente de conversión del AP5 IDE en 01/06/00
#include "finr13a.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR13A ³ Autor ³ Lucas                       ³ Data ³ 15.03.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Titulos a Recibir	                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR13A(void)                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Argentina                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador  ³ Data   ³ BOPS     ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Jonathan Glez³06/12/16³SERINN001-³Se modifica uso de tablas temporales      ³±±
±±³             ³        ³      129 ³por motivo de limpieza de CTREE.          ³±±
±±³   Marco A.  ³16/04/18³DMINA-2310³Se remueven sentencias CriaTrab y se apli-³±±
±±³             ³        ³          ³ca FWTemporaryTable(), para el manejo de  ³±±
±±³             ³        ³          ³las tablas temporales.                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr13a()

Local oReport	:= Nil

Private oTmpTRB	:= Nil
Private aOrder := {}

SetPrvt("CDESC1,CDESC2,CDESC3,LIMITE,CSTRING,TAMANHO")
SetPrvt("TITULO,CABEC1,CABEC2,ARETURN,NOMEPROG,ALINHA")
SetPrvt("NLASTKEY,CPERG,WNREL,AORD,NSALDOATU")
SetPrvt("NSALATUG,NSALANTG,ASALDOS,DEMISSAO,DVENCTO,CCLIEINI")
SetPrvt("CCLIEFIM,CLOJAINI,CLOJAFIM,DFECHAINI,DFECHAFIM,NINFORME")
SetPrvt("NSITUACAO,NIMPSALDO,DFECHABASE,DBAIXA,NORDEM,CBTXT")
SetPrvt("CBCONT,LI,M_PAG,ACAMPOS,CNOMEARQ,CINDEXKEY")
SetPrvt("NTGTITULOS,NTGNORMAL,NTGATRASO,NTGCORRIG,NTGVENCER,NTGJUROS")
SetPrvt("NTITULOS,NVLRNORMAL,NVLRATRASO,NVLRCORRIG,NVLRVENCER,NVLRJUROS")
SetPrvt("CCODCLIE,CLOJACLI,CRAZSOCIAL,CTELEFONE,CMODALIDAD,LIMPCLIE")
SetPrvt("CCONDWCLIE,LEND,NJUROS,NATRASO,CTOTAL,_SALIAS")
SetPrvt("I,J,EXPC1,EXPC2,EXPN1,EXPL1")
SetPrvt("EXPL2,EXPC3,NDEBITO,NCREDITO,CHISTOR,")
Private lReltGraf :=.F.

If TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lReltGraf :=.T.
	oReport	:= ReportDef()
	oReport:PrintDialog()
Else
	U_Finr13aR3()
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³28/06/2006³±±
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
Local oReport,oSection1,oSection2
Local cReport := "FINR13A"
Local cTitulo := OemToAnsi(STR0004) 
Local cDescri := OemToAnsi(STR0001)+" "+OemToAnsi(STR0002)+OemToAnsi(STR0003)             
Local nTamTitVenc := 12

Pergunte( "FIN13A" , .F. )
                   
oReport  := TReport():New( cReport, cTitulo,"FIN13A", { |oReport| ReportPrint( oReport, "TRB" ) }, cDescri )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,STR0072 , {"TRB","SA1"},{OemToAnsi(STR0027 ),OemToAnsi(STR0028),OemToAnsi(STR0029 )},/*Campos do SX3*/,/*Campos do SIX*/)//"Clientes"
oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)
oReport:SetLandScape()

TRCell():New( oSection1, "CLIENTE" 	,"SE1"  ,/*X3Titulo()*/,/*Picture*/,TamSx3("E1_CLIENTE")[1]+TamSx3("E1_LOJA")[1]+1,/*lPixel*/,{||TRB->CODIGO +" "+TRB->LOJA})
TRCell():New( oSection1, "A1_NOME"	,"SA2"	,/*X3Titulo()*/,/*Picture*/,15,/*lPixel*/,{||TRB->CLIENTE})	
TRCell():New( oSection1, "NATUREZ"	    ,"" 	,/*X3Titulo()*/,/*Picture*/,20,/*lPixel*/,{||MascNat(SED->ED_CODIGO)})
TRCell():New( oSection1, "ED_DESCRIC"	    ,"SED" 	,/*X3Titulo()*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,)

oSection2 := TRSection():New( oSection1,STR0073, {"TRB"} )//"Movimentos"
TRCell():New( oSection2, "E1_CLIENTE" ,""    ,	/*X3Titulo()*/                                              ,/*Picture*/                ,TamSx3("E1_CLIENTE")[1]+TamSx3("E1_LOJA")[1]+1                        ,/*lPixel*/, {|| TRB->CODIGO+" "+TRB->LOJA})
TRCell():New( oSection2, "E1_PREFIXO" ,"SE1" ,	OemToAnsi(STR0050) + CHR(13)+CHR(10) + OemToAnsi(STR0051)	,/*Picture*/                ,TamSx3("E1_PREFIXO")[1]+TamSx3("E1_NUM")[1]+TamSx3("E1_PARCELA")[1]+5 ,/*lPixel*/,	{|| TRB->PREFIXO+Trans(TRB->NUMERO,"@R /99999999999999")+" "+TRB->PARCELA})
TRCell():New( oSection2, "E1_TIPO"    ,"SE1" ,	/*X3Titulo()*/                                              ,/*Picture*/                ,/*Tamanho*/                                                           ,/*lPixel*/, {|| If(Alltrim(TRB->TIPO)$"NF","FT ",TRB->TIPO) })
TRCell():New( oSection2, "E1_NATUREZ" ,"SE1" ,	/*X3Titulo()*/                                              ,/*Picture*/                ,/*Tamanho*/                                                           ,/*lPixel*/, {|| AllTrim(MascNat(TRB->NATUREZA))})
TRCell():New( oSection2, "QTDTIT"     ,"   " ,	OemToAnsi(STR0052) + CHR(13)+CHR(10) + OemToAnsi(STR0053)	,"@E 999"                   ,3                                                                     ,/*lPixel*/,	{|| 1})
TRCell():New( oSection2, "E1_EMIS"    ,"SE1" ,	OemToAnsi(STR0054) + CHR(13)+CHR(10) + OemToAnsi(STR0055)	,/*Picture*/                ,nTamTitVenc                                                           ,/*lPixel*/,	{|| TRB->EMISSAO })
TRCell():New( oSection2, "E1_VENCTO"  ,"SE1" ,	/*X3Titulo()*/                                              ,/*Picture*/                ,nTamTitVenc                                                        ,/*lPixel*/, {|| Iif(TRB->VENCTO == dDataBase,OemToAnsi(STR0034),TRB->VENCTO)})
TRCell():New( oSection2, "E1_VENCREA" ,"SE1" ,	OemToAnsi(STR0056) + CHR(13)+CHR(10) + OemToAnsi(STR0057)	,/*Picture*/                ,nTamTitVenc                                                          ,/*lPixel*/,	{|| TRB->VENCREA })
TRCell():New( oSection2, "E1_SALDO"   ,"SE1" ,	OemToAnsi(STR0058) + CHR(13)+CHR(10) + OemToAnsi(STR0059)	,/*Picture*/                ,TamSx3("E1_VALOR")[1]                                                 ,/*lPixel*/,	{||Iif(TRB->TIPO $ "RA "+MV_CRNEG, TRB->VALOR *-1,TRB->VALOR )})
TRCell():New( oSection2, "SALDOATU"   ,""    ,	OemToAnsi(STR0060) + CHR(13)+CHR(10) + OemToAnsi(STR0061)	,PesqPict("SE1","E1_VALOR") ,TamSx3("E1_VALOR")[1]                                                 ,/*lPixel*/,	{|| Iif(dDataBase >= TRB->VENCREA,Iif(TIPO $ "RA "+MV_CRNEG,(TRB->SALTIT)*-1,TRB->SALTIT),0)})
TRCell():New( oSection2, "E1_VALOR"   ,"SE1" ,	OemToAnsi(STR0060) + CHR(13)+CHR(10) + OemToAnsi(STR0063)	,                           ,TamSx3("E1_VALOR")[1]                                                 ,/*lPixel*/,	{||Iif(dDataBase >= TRB->VENCREA,Iif(TRB->TIPO $ "RA "+MV_CRNEG,(TRB->SALTIT+TRB->JUROS)*-1,TRB->SALTIT+TRB->JUROS),0) })
TRCell():New( oSection2, "TITVENC"    ,""    ,	OemToAnsi(STR0064) + CHR(13)+CHR(10) + OemToAnsi(STR0065)	,PesqPict("SE1","E1_VALOR") ,TamSx3("E1_VALOR")[1]                                                 ,/*lPixel*/,	{||Iif(dDataBase < TRB->VENCREA,Iif(TRB->TIPO $ "RA "+MV_CRNEG,(TRB->SALTIT+TRB->JUROS)*-1,TRB->SALTIT+TRB->JUROS),0) })
TRCell():New( oSection2, "NUMBCO"     ,""    ,	OemToAnsi(STR0062)                                          ,/*Picture*/                ,10                                                                    ,/*lPixel*/,	{|| TRB->NUMBCO})
TRCell():New( oSection2, "E1_ACRESC"  ,"SE1" ,	OemToAnsi(STR0066) + CHR(13)+CHR(10) + OemToAnsi(STR0067)	,/*Picture*/                ,10                                                                    ,/*lPixel*/,	{|| TRB->JUROS})
TRCell():New( oSection2, "ATRASO"     ,""    ,	OemToAnsi(STR0068) + CHR(13)+CHR(10) + OemToAnsi(STR0069)	,"@E 99999"                 ,5                                                                     ,/*lPixel*/,	{|| TRB->ATRASO })
TRCell():New( oSection2, "SALDOFIN"   ,""    ,	OemToAnsi(STR0070) + CHR(13)+CHR(10) + OemToAnsi(STR0071)	,PesqPict("SE1","E1_VALOR") ,TamSx3("E1_VALOR")[1]                                                 ,/*lPixel*/,	{||Iif(TRB->TIPO $ "RA "+MV_CRNEG,(TRB->SALTIT+TRB->JUROS)*-1,TRB->SALTIT+TRB->JUROS)})

oSection2:Cell("E1_SALDO" ):SetHeaderAlign("RIGHT")  
oSection2:Cell("SALDOATU" ):SetHeaderAlign("RIGHT")
oSection2:Cell("E1_VALOR" ):SetHeaderAlign("RIGHT")
oSection2:Cell("TITVENC"  ):SetHeaderAlign("RIGHT")
oSection2:Cell("SALDOFIN" ):SetHeaderAlign("RIGHT")
  
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1	:= oReport:Section(1)   
Local oSection2	:= oSection1:Section(1)
Local oBreak1	:= Nil
Local nOrder	:= oReport:Section(1):GetOrder()

nSaldoAtu:= 0.00
nSalAtuG := 0.00
nSalAntG := 0.00
aSaldos  := {}
dEmissao := CTOD("")
dVencto  := CTOD("")

cClieIni  := mv_par01
cClieFim  := mv_par02
cLojaIni  := mv_par03
cLojaFim  := mv_par04
dFechaIni := mv_par05
dFechaFim := Min(dDataBase,mv_par06)
nInforme  := mv_par07
nSituacao := 1
nImpSaldo := mv_par09
dFechaBase := dDataBase

dBaixa := dDataBase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt  := SPACE(10)
cbcont := 0
aCampos := {}
AADD(aCampos,{"CODIGO"  ,"C",TamSX3('A1_COD')[1],0})
AADD(aCampos,{"LOJA"    ,"C",TamSX3('A1_LOJA')[1],0})
AADD(aCampos,{"CLIENTE" ,"C",25,0})
AADD(aCampos,{"TELEFONE","C",15,0})
AADD(aCampos,{"VENDEDOR","C",03,0})
AADD(aCampos,{"NOMEVEND","C",25,0})
AADD(aCampos,{"TELEVEND","C",15,0})
AADD(aCampos,{"NATUREZA","C",10,0})
AADD(aCampos,{"PREFIXO" ,"C",TamSX3('E1_PREFIXO')[1],0})
AADD(aCampos,{"NUMERO"  ,"C",TamSX3('E1_NUM')[1],0})
AADD(aCampos,{"TIPO"    ,"C",03,0})
AADD(aCampos,{"SIGLA"   ,"C",03,0})
AADD(aCampos,{"PARCELA" ,"C",TamSX3('E1_PARCELA')[1],0})
AADD(aCampos,{"BANCO"   ,"C",03,0})
AADD(aCampos,{"NUMBCO"  ,"C",10,0})
AADD(aCampos,{"PORTADOR","C",03,0})
AADD(aCampos,{"SITUACAO","C",01,0})
AADD(aCampos,{"MOEDA"   ,"N",02,0})
AADD(aCampos,{"EMISSAO" ,"D",08,0})
AADD(aCampos,{"VENCTO"  ,"D",08,0})
AADD(aCampos,{"VENCREA" ,"D",08,0})
AADD(aCampos,{"BAIXA"   ,"D",08,0})
AADD(aCampos,{"HISTOR"  ,"C",20,0})
AADD(aCampos,{"VALOR"   ,"N",18,2})
AADD(aCampos,{"DEBITO"  ,"N",18,2})
AADD(aCampos,{"CREDITO" ,"N",18,2})
AADD(aCampos,{"SALDO"   ,"N",18,2})
AADD(aCampos,{"SALTIT"  ,"N",18,2})
AADD(aCampos,{"DC"      ,"C", 1,0})
AADD(aCampos,{"JUROS"   ,"N",18,2})
AADD(aCampos,{"ATRASO"  ,"N", 5,0})

aOrder := {"CODIGO","LOJA","EMISSAO"}//JGR
If nOrder == 1
	aOrder := {"CODIGO","LOJA","EMISSAO"}
ElseIf nOrder == 2
	aOrder := {"CLIENTE","EMISSAO"}
ElseIf nOrder == 3
	aOrder := {"NATUREZA","CODIGO","LOJA","EMISSAO"}
EndIf

oTmpTRB := FWTemporaryTable():New("TRB") //JGR
oTmpTRB:SetFields( aCampos )
oTmpTRB:AddIndex("I1", aOrder)
oTmpTRB:Create()

Processa({|lEnd| GrvSldXXX(oSection1:GetAdvPlExp('SA1')) },,OemToAnsi(STR0033))// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Processa({|lEnd| Execute(GrvSldXXX) },,OemToAnsi("Preparando Transit¢rio...")) //"Preparando Transit¢rio..."

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")
dbGoTop()
 
If nInforme <> 1 //Detallado
	oSection2:SetHeaderSection(.T.)
	oSection2:Hide()
EndIf
oSection2:Cell("SALDOFIN"):Hide()
oSection2:Cell("QTDTIT"):Hide()

oSection1:SetOrder(1)
oSection1:SetHeaderPage()

oSection1:SetLineCondition({|| !Alltrim(TRB->TIPO)$"RC" .And. Empty(TRB->BAIXA) .And. TRB->SALDO > 0})   
oSection2:SetOrder(1)
oSection2:SetLineCondition({|| !Alltrim(TRB->TIPO)$"RC" .And. Empty(TRB->BAIXA) .And. TRB->SALDO > 0})     

If nOrder == 3 
	oSection1:Cell("CLIENTE"):Hide()	
	oSection1:Cell("A1_NOME"):disable()
	oSection2:Cell("E1_NATUREZ"):disable()  
	oSection2:SetParentFilter({|cParam|TRB->NATUREZA == cParam},{||SED->ED_CODIGO})
	oBreak1 := TRBreak():New( oSection1,oSection1:Cell("NATUREZ") ,OemToAnsi(STR0035))  
Else
	oSection1:Cell("NATUREZ"):Hide()
	oSection2:Cell("E1_CLIENTE"):disable()
	oBreak1 := TRBreak():New( oSection1,oSection1:Cell("CLIENTE") , OemToAnsi(STR0036) )  
	oSection2:SetParentFilter({|cParam|TRB->CODIGO+TRB->LOJA == cParam},{||SA1->A1_COD+SA1->A1_LOJA})
EndIf
Trposition():New(oReport:Section(1),"SED",1,{|| xFilial()+TRB->NATUREZA})  
Trposition():New(oReport:Section(1),"SA1",1,{|| xFilial()+TRB->CODIGO+TRB->LOJA})
Trposition():New(oReport:Section(1),"SA1",1,{|| xFilial()+TRB->CODIGO+TRB->LOJA})

TRFunction():New(oSection2:Cell("E1_SALDO")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("SALDOATU")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("E1_VALOR")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("TITVENC")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("E1_ACRESC")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("SALDOFIN")	, , "SUM"  	, oBreak1, , , , .F. ,  )
TRFunction():New(oSection2:Cell("QTDTIT"  )	, , "COUNT" , oBreak1, , , , .F. ,  )

oSection1:Print()

If oTmpTRB <> Nil   //JGR
	dbSelectArea("TRB")
	TRB->(dbCloseArea())
	oTmpTRB:Delete()
	oTmpTRB := Nil
Endif

dbSelectArea("SA1")
RetIndex("SA1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SA2")
RetIndex("SA2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE1")
RetIndex("SE1")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE2")
RetIndex("SE2")
dbSetOrder(1)
DbClearFilter()

dbSelectArea("SE5")
RetIndex("SE5")
dbSetOrder(1)
DbClearFilter()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funci¢n   ³Finr13aR3 ³ Autor ³ Paulo Augusto         ³ Data ³ 11/01/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip.  ³ Creacion de Tabla Temporal para Informe.                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ FINR13A                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr13aR3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaración de variables utilizadas en el programa a través de la función    ³
//³ SetPrvt, va a crear sólo las variables definidas por el usuario,             ³
//³ identificando las variables públicas del sistema utilizadas en el código     ³
//³ Incluido por el asistente de conversión del AP5 IDE                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDesc1 := OemToAnsi(STR0001)  //"Este programa imprimir  la demostraci¢n contable de Clientes "
cDesc2 := OemToAnsi(STR0002)  //"Se puede  emitir  todo  el movimiento de los mismos, o apenas"
cDesc3 := OemToAnsi(STR0003)  //"los valores originales.                                      "

limite  := 220
cString := "SE1"
Tamanho := "G"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Defini‡„o dos cabe‡alhos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0004)  // "Posici¢n de los T¡tulos a Cobrar"
cabec1 := OemToAnsi(STR0005)  // "C¢digo    Nombre Cliente       Prf-N£mero          TP  Modalidad  Fecha de   Vencto     Vencto     Banco Valor Original|       T¡tulos  Vencidos       |T¡tulos a Vencer| Num        Vlr.Inter‚s   D¡as              Saldo"
cabec2 := OemToAnsi(STR0006)  // "                               Cuota                              Emisi¢n    T¡tulo     Real                           | Valor Nominal  Valor Corregido|  Valor Nominal | Banco     o Permanencia  Atraso            Final"

aReturn  := { OemToAnsi(STR0007), 1,OemToAnsi(STR0008), 2, 2, 2,"",1 }  //"Especial", 1,"Administracao"

nomeprog := "FINR13A"

aLinha   := {}
nLastKey := 0
cPerg    := "FIN13A"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

pergunte("FIN13A",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := "FINR13A"            //Nome Default do relatorio em Disco

aOrd := { OemToAnsi(STR0027),;  //"Por C¢digo"
   	       OemToAnsi(STR0028),;  //"Por Nombre"
 		   OemToAnsi(STR0029) }  //"Por Modalidad"

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,"",.F.)

If nLastKey == 27
   Return
EndIf

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
EndIf

RptStatus({|| FA13AImp()},OemToAnsi(STR0030),OemToAnsi(STR0031))// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> RptStatus({|| Execute(FA13AImp)},"Posici¢n de Clientes","Imprimiendo...") //"Posicion de Clientes","Imprimiendo..."

Set Device To Screen
If aReturn[5] == 1
   Set Printer To
   Commit
   Ourspool(wnrel)
Endif
MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA13AImp ³ Autor ³Jose Lucas/Diego Rivero³ Data ³ 09.09.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Razonete de Cliente/Fornecedores                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA13AImp(lEnd,wnRel,cString)                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd    - A‡Æo do Codeblock                                ³±±
±±³          ³ wnRel   - T¡tulo do relat¢rio                              ³±±
±±³          ³ cString - Mensagem                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FA13AImp()

	nSaldoAtu:= 0.00
	nSalAtuG := 0.00
	nSalAntG := 0.00
	aSaldos  := {}
	dEmissao := CTOD("")
	dVencto  := CTOD("")
	
	cClieIni  := mv_par01
	cClieFim  := mv_par02
	cLojaIni  := mv_par03
	cLojaFim  := mv_par04
	dFechaIni := mv_par05
	dFechaFim := Min(dDataBase,mv_par06)
	nInforme  := mv_par07
	nSituacao := 1
	nImpSaldo := mv_par09
	dFechaBase := dDataBase
	
	dBaixa := dDataBase
	
	nOrdem := aReturn[8]
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cbtxt  := SPACE(10)
	cbcont := 0
	li := 80
	m_pag := 1
	
	aCampos := {}
	AADD(aCampos,{"CODIGO"  ,"C",TamSX3('A1_COD')[1],0})
	AADD(aCampos,{"LOJA"    ,"C",TamSX3('A1_LOJA')[1],0})
	AADD(aCampos,{"CLIENTE" ,"C",25,0})
	AADD(aCampos,{"TELEFONE","C",15,0})
	AADD(aCampos,{"VENDEDOR","C",03,0})
	AADD(aCampos,{"NOMEVEND","C",25,0})
	AADD(aCampos,{"TELEVEND","C",15,0})
	AADD(aCampos,{"NATUREZA","C",10,0})
	AADD(aCampos,{"PREFIXO" ,"C",03,0})
	AADD(aCampos,{"NUMERO"  ,"C",15,0})
	AADD(aCampos,{"TIPO"    ,"C",03,0})
	AADD(aCampos,{"SIGLA"   ,"C",03,0})
	AADD(aCampos,{"PARCELA" ,"C",01,0})
	AADD(aCampos,{"BANCO"   ,"C",03,0})
	AADD(aCampos,{"NUMBCO"  ,"C",10,0})
	AADD(aCampos,{"PORTADOR","C",03,0})
	AADD(aCampos,{"SITUACAO","C",01,0})
	AADD(aCampos,{"MOEDA"   ,"N",02,0})
	AADD(aCampos,{"EMISSAO" ,"D",08,0})
	AADD(aCampos,{"VENCTO"  ,"D",08,0})
	AADD(aCampos,{"VENCREA" ,"D",08,0})
	AADD(aCampos,{"BAIXA"   ,"D",08,0})
	AADD(aCampos,{"HISTOR"  ,"C",20,0})
	AADD(aCampos,{"VALOR"   ,"N",18,2})
	AADD(aCampos,{"DEBITO"  ,"N",18,2})
	AADD(aCampos,{"CREDITO" ,"N",18,2})
	AADD(aCampos,{"SALDO"   ,"N",18,2})
	AADD(aCampos,{"SALTIT"  ,"N",18,2})
	AADD(aCampos,{"DC"      ,"C", 1,0})
	
	aOrder := {"CODIGO","LOJA","EMISSAO"}
	If nOrdem == 1
		aOrder := {"CODIGO","LOJA","EMISSAO"}
	ElseIf nOrdem == 2
		aOrder := {"CLIENTE","EMISSAO"}
	ElseIf nOrdem == 3
		aOrder := {"CODIGO","LOJA","NATUREZA","EMISSAO"}
	EndIf
	
	oTmpTRB := FWTemporaryTable():New("TRB")
	oTmpTRB:SetFields( aCampos )
	oTmpTRB:AddIndex("I1", aOrder)
	oTmpTRB:Create()
	
	Processa({|lEnd| GrvSldXXX() },,OemToAnsi(STR0033))// Substituido por el asistente de conversión del AP5 IDE en 01/06/00 ==> Processa({|lEnd| Execute(GrvSldXXX) },,OemToAnsi("Preparando Transit¢rio...")) //"Preparando Transit¢rio..."
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inicia rotina de impressao                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("TRB")
	dbGoTop()
	
	nTGTitulos := 0.00
	nTGNormal  := 0.00
	nTGAtraso  := 0.00
	nTGCorrig  := 0.00
	nTGVencer  := 0.00
	nTGJuros   := 0.00
	
	SetRegua(RecCount())
	
	While ! Eof()
		If li > 50
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
			li := 09
      	EndIf

		nTitulos := 0.00

		nVlrNormal := 0.00
		nVlrAtraso := 0.00
		nVlrCorrig := 0.00
		nVlrVencer := 0.00
		nVlrJuros  := 0.00

		cCodClie := TRB->CODIGO
		cLojaCli := TRB->LOJA
		cRazSocial := TRB->CLIENTE
		cTelefone := TRB->TELEFONE
		cModalidad := TRB->NATUREZA

		lImpClie := .T.

		If nOrdem == 3
	      cCondWClie := "!Eof().and.TRB->NATUREZA==cModalidad"
		Else
	      cCondWClie := "!Eof().and.TRB->CODIGO==cCodClie.and.TRB->LOJA==cLojaCli"
		EndIf

		While If(nOrdem==3,!Eof().and.TRB->NATUREZA==cModalidad,!Eof().and.TRB->CODIGO==cCodClie.and.TRB->LOJA==cLojaCli)
			IncRegua()
			
			If lEnd
				Exit
			EndIf
			
			If li>50
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
				li:=9
			End

			If Alltrim(TIPO) $ "RC"
				dbSkip()
				Loop
			EndIf

			If mv_par08 == 2
				If ! AllTrim(TIPO) $ "FT.NF"
					dbSkip()
					Loop
				EndIf
			EndIf

			If ! Empty(BAIXA)
				dbSkip()
				Loop
			EndIf

			nJuros := 0
			dbSelectArea("SE1")
			dbSeek(xFilial("SE1")+TRB->PREFIXO+TRB->NUMERO+TRB->PARCELA)
			If Found()
				FA070Juros( mv_par09 )
			EndIf
			dbSelectArea("TRB")

			nAtraso := 0
			If !Empty(VENCREA) .and. dDataBase > VENCREA
				nAtraso:=dDataBase-VENCTO
				If Dow(VENCTO) == 1 .Or. Dow(VENCTO) == 7
					If Dow(dBaixa) == 2 .and. nAtraso <= 2
						nAtraso := 0
					EndIf
				EndIF
				nAtraso:=IIF(nAtraso<0,0,nAtraso)
			EndIf

			If nInforme == 1 //Detallado
				@li,	0 PSAY CODIGO+" "+LOJA
				If Len(CODIGO)>6
					@li := li + 1					
				Endif	
				@li, 10 PSAY SubStr( CLIENTE, 1, 20 )
				@li, 31 PSAY PREFIXO+Trans(NUMERO,"@R /99999999999999")+" "+PARCELA
				@li, 51 PSAY If(Alltrim(TIPO)$"NF","FT ",TIPO)
				@li, 55 PSAY AllTrim(NATUREZA)
				@li, 66 PSAY EMISSAO
				If VENCTO == dDataBase
					@li, 77 PSAY OemToAnsi(STR0034) // "Vence Hoy"
				Else
					@li, 77 PSAY VENCTO
				EndIf
				@li, 88 PSAY VENCREA
				@li, 99 PSAY PORTADOR+" "+SITUACAO

            If TIPO $ "RA "+MV_CRNEG
               @li,104 PSAY VALOR *-1  Picture tm (TRB->VALOR,14)
            Else
               @li,104 PSAY VALOR     Picture tm (TRB->VALOR,14)
				EndIf

				If dDataBase > VENCREA
					@li,119 PSAY SALTIT			Picture tm ( SALTIT, 14 )
					@li,137 PSAY SALTIT+nJuros  Picture tm(SALTIT+nJuros,14)
				Else
					@li,154 PSAY SALTIT			Picture tm ( SALTIT, 14 )
				EndIf
				@ li, 170 PSAY NUMBCO
				If nJuros > 0
					@ Li,181 PSAY nJuros Picture Tm(nJuros,12)
				EndIf
				If nAtraso > 0
					@ Li,197 PSAY nAtraso Picture '9999'
				EndIf
				li := li + 1
			EndIf

			If TIPO $ "RA /"+MV_CRNEG
				nVlrNormal := nVlrNormal - SALTIT
				nTGNormal := nTGNormal - SALTIT
				If dDataBase > VENCREA
					nVlrAtraso := nVlrATraso - SALTIT
					nVlrCorrig := nVlrCorrig - (SALTIT + nJuros)
					nTGAtraso := nTGATraso - SALTIT
					nTGCorrig := nTGCorrig - (SALTIT + nJuros)
				Else
					nVlrVencer := nVlrVencer - SALTIT
					nTGVencer := nTGVencer - SALTIT
				EndIf
     		Else
				nVlrNormal := nVlrNormal + SALTIT
				nTGNormal := nTGNormal + SALTIT
				If dDataBase > VENCREA
					nVlrAtraso := nVlrATraso + SALTIT
					nVlrCorrig := nVlrCorrig + (SALTIT + nJuros)
					nTGAtraso := nTGATraso + SALTIT
					nTGCorrig := nTGCorrig + (SALTIT + nJuros)
				Else
					nVlrVencer := nVlrVencer + SALTIT
					nTGVencer := nTGVencer + SALTIT
				EndIf
			EndIf
			nTitulos := nTitulos + 1
			nTGTitulos := nTGTitulos + 1
			nVlrJuros := nVlrJuros + nJuros
			nTGJuros := nTGJuros + nJuros
			dbSelectArea("TRB")
			dbSkip()
		EndDo

		If nInforme == 1 //Detallado
			If nTitulos > 0
				If li>50
   				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
    				li:=9
				EndIf
				li := li + 1
				If nOrdem==3
					cTotal := OemToAnsi(STR0035) // "T O T A L  P O R  M O D A L I D A D ----> "
				Else
					cTotal := OemToAnsi(STR0036) // "T O T A L  P O R  C L I E N T E     ----> "
				EndIf
				@li,000 PSAY cTotal
				@li,043 PSAY "( "+OemToAnsi(STR0037)+" "+Str(nTitulos,4)+" )"  //"Titulos"
				@li,106 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,121 PSAY nVlrAtraso		Picture TM(nVlrAtraso,14)
				@li,139 PSAY nVlrCorrig		Picture TM(nVlrCorrig,14)
				@li,156 PSAY nVlrVencer 	Picture TM(nVlrVencer,14)
				If nVlrJuros > 0
					@li,182 PSAY nVlrJuros	Picture TM(nTotJur,12)
				Endif
				@li,204 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,219 PSAY If(nVlrNormal>0,"D","C")
				li := li + 2
			Endif
		Else
			If nTitulos > 0
				If nOrdem == 3
					SED->(dbSetOrder(1))
					SED->(dbSeek(xFilial("SED")+cModalidad))
					If SED->(Found())
	         		@li,  0 PSAY cModalidad
		      		@li, 15 PSAY SED->ED_DESCRIC
					Endif
				Else
         		@li,  0 PSAY cCodClie+"-"+cLojaCli
	      		@li, 11 PSAY cRazSocial
				EndIf
				@li,043 PSAY "( "+OemToAnsi(STR0037)+" "+Str(nTitulos,4)+" )"  //"Titulos"
				@li,107 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,122 PSAY nVlrAtraso		Picture TM(nVlrAtraso,14)
				@li,140 PSAY nVlrCorrig		Picture TM(nVlrCorrig,14)
				@li,157 PSAY nVlrVencer 	Picture TM(nVlrVencer,14)
				If nVlrJuros > 0
					@li,183 PSAY nVlrJuros	Picture TM(nTotJur,12)
				Endif
				@li,205 PSAY nVlrNormal		Picture TM(nVlrNormal,14)
				@li,220 PSAY If(nVlrNormal>0,"D","C")
				li := li + 2
			Endif
		Endif
	EndDo

	If nTGTitulos > 0
		If li>50
	   	cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	    	li:=9
		EndIf
		li := li + 1
		@li,000 PSAY Replicate("-",220)
		li := li + 1
		@li,000 PSAY OemToAnsi(STR0038) //"T O T A L     G E N E R A L         ----> "
		@li,043 PSAY "( "+OemToAnsi(STR0037)+" "+Str(nTGTitulos,4)+" )"  //"Titulos"
		@li,106 PSAY nTGNormal		Picture TM(nVlrNormal,14)
		@li,121 PSAY nTGAtraso		Picture TM(nVlrAtraso,14)
		@li,139 PSAY nTGCorrig		Picture TM(nVlrCorrig,14)
		@li,156 PSAY nTGVencer	 	Picture TM(nVlrVencer,14)
		If nVlrJuros > 0
			@li,182 PSAY nTGJuros	Picture TM(nTotJur,12)
		Endif
		@li,204 PSAY nTGNormal		Picture TM(nVlrNormal,14)
		@li,219 PSAY If(nTGNormal>0,"D","C")
		li := li + 1
		@li,000 PSAY Replicate("-",220)
		li := li + 1
	EndIf

	Roda( cbCont, cbTxt, Tamanho )

	dbSelectArea("TRB")
	dbCloseArea()
	If oTmpTRB <> Nil
		oTmpTRB:Delete()
		oTmpTRB := Nil
	EndIf
	
	dbSelectArea("SA1")
	RetIndex("SA1")
	dbSetOrder(1)
	DbClearFilter()
	
	dbSelectArea("SA2")
	RetIndex("SA2")
	dbSetOrder(1)
	DbClearFilter()
	
	dbSelectArea("SE1")
	RetIndex("SE1")
	dbSetOrder(1)
	DbClearFilter()
	
	dbSelectArea("SE2")
	RetIndex("SE2")
	dbSetOrder(1)
	DbClearFilter()
	
	dbSelectArea("SE5")
	RetIndex("SE5")
	dbSetOrder(1)
	DbClearFilter()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ GrvSldClie³ Autor ³ Lucas                ³ Data ³ 05/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grabar uno archivo transit¢rio (TRB) con los salods de los ³±±
±±³          ³ Clientes. Baseado en las leyes y denificiones de Localiza- ³±±
±±³          ³ ciones de los paises del ConeSul y Andinos.                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GrvSldClie(ExpC1,ExpC2,ExpN1,ExpL1,ExpC3)                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 := C¢digo Inicial del Cliente                        ³±±
±±³          ³ ExpC2 := C¢digo Final del Cliente                          ³±±
±±³          ³ ExpN1 := Selecci¢n del Tipo de T¡tulos                     ³±±
±±³          ³ ExpL1 := Identifica lo Cierre por Vendedor o Cliente		  ³±±
±±³          ³ ExpL2 := Imprimir con Historico o No (Saldo > 0)    		  ³±±
±±³          ³ ExpC3 := Nombre do Relat¢rio. Ejemplo: "FINR132"			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Localizacoes ConeSul y Andinos                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GrvSldXXX(cFiltSA1)
	Local lGerou	:=	.F.
	Local lVersao	:=	.F.
	If cPaisLoc $ "ARG"
		DbSelectArea("SEL")
		If cPaisLoc $ "ANG|ARG|AUS|BOL|BRA|CHI|COL|COS|DOM|EQU|EUA|HAI|MEX|PAD|PAN|PAR|PER|POR|PTG|SAL|TRI|URU|VEN" 
			lVersao := .T.
		EndIf
	EndIf
	
	nDebito := 0.00
	nCredito := 0.00
	
	ProcRegua(SE1->(RecCount()))
	
	dbSelectArea("SE1")
	dbSetOrder(2)
	dbSeek(xFilial("SE1")+cClieIni+cLojaIni,.T. )

	While !Eof() .and. SE1->E1_CLIENTE <= cClieFim .and. SE1->E1_LOJA <= cLojaFim .and. xFilial("SE1") == SE1->E1_FILIAL

		lGerou	:=	.F.
		SA1->(dbSetOrder(1))
		SA1->(dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA) )
		If !Empty(cFiltSA1) .And. !SA1->(&(cFiltSA1))
			dbSelectArea("SE1")
			dbSkip()
			Loop
		Endif
		If  cPaisLoc <> "BRA" .And. SE1->E1_CONVERT=='N'
			dbSelectArea("SE1")
			dbSkip()
			Loop
		EndIf
                
		If Alltrim(SE1->E1_TIPO) $ "RC"
			dbSkip()
			Loop
		EndIf
		If mv_par08 == 2
			If !AllTrim(SE1->E1_TIPO) $ "FT|NF"
				dbSkip()
				Loop
			EndIf
		EndIf  

		If ! SubStr( SE1->E1_TIPO, 1, 2 ) $ "TF~CH"
			If nSituacao == 1 //Historico
				If SE1->E1_EMISSAO <= dFechaFim
					If DToS( SE1->E1_EMISSAO ) < DToS( dFechaIni )
						If ALLTRIM(SE1->E1_TIPO)$MV_CRNEG.OR.SUBSTR(SE1->E1_TIPO,3,1)=="-"
							nCredito := SE1->E1_VLCRUZ
						Else
							nDebito := SE1->E1_VLCRUZ
            			EndIf
            		ElseIf DToS( SE1->E1_EMISSAO ) >= DToS( dFechaIni ) .and. DToS( SE1->E1_EMISSAO ) <= DToS( dFechaFim )
						lGerou	:=	.T.
            	  		RecLock( "TRB", .T. )
            			TRB->CODIGO  :=  SE1->E1_CLIENTE
            			TRB->LOJA    :=  SE1->E1_LOJA
 	         			TRB->CLIENTE :=  SA1->A1_NOME
  	      	 			TRB->TELEFONE :=  SA1->A1_TEL
            			TRB->NUMERO  :=  SE1->E1_NUM
                 		If ALLTRIM(SE1->E1_TIPO)$ MV_CRNEG .OR. SUBSTR(SE1->E1_TIPO,3,1)=="-"
              				TRB->CREDITO:= SE1->E1_VLCRUZ
            			Else
              				TRB->DEBITO := SE1->E1_VLCRUZ
            			EndIf
            			TRB->NUMERO  :=  SE1->E1_NUM
            			TRB->TIPO    :=  SE1->E1_TIPO
            			TRB->SIGLA   :=  SE1->E1_TIPO
            			TRB->PARCELA :=  SE1->E1_PARCELA
            			TRB->PREFIXO :=  SE1->E1_PREFIXO
                  		TRB->VALOR   :=  xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par09,DDATABASE,,Iif(MV_PAR10==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))
                  		TRB->SALTIT  :=  SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R",SE1->E1_CLIENTE,mv_par09 ,,dFechaBase,SE1->E1_LOJA,,Iif(MV_PAR10==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))
                   		If TRB->SALTIT > 0.00
               				If SE1->E1_VENCTO == dDataBase
                  				TRB->VENCTO := dDataBase
               				ElseIf SE1->E1_VENCTO < dDataBase.And.!Empty(SE1->E1_VENCTO )
                				TRB->VENCTO := SE1->E1_VENCTO
                  				TRB->VENCREA := SE1->E1_VENCREA
               				Else
                  				TRB->VENCTO := SE1->E1_VENCTO
                  				TRB->VENCREA := SE1->E1_VENCREA
               				EndIf
            			Else
               				TRB->VENCTO := SE1->E1_BAIXA
							TRB->VENCREA := SE1->E1_BAIXA
               				TRB->BAIXA := SE1->E1_BAIXA
            			EndIf
            			TRB->EMISSAO  :=  SE1->E1_EMISSAO
            			TRB->SALDO    := TRB->DEBITO - TRB->CREDITO
						If SubStr( SE1->E1_TIPO, 1, 2 ) $ MVRECANT+"|"+MV_CRNEG .AND. TRB->SALDO < 0
							TRB->SALDO    := TRB->SALDO * -1
						EndIF
            			MsUnLock()
         			EndIf
	      		EndIf
			Else
	         	If DToS( SE1->E1_EMISSAO ) < DToS( dFechaIni )
               		If ALLTRIM(SE1->E1_TIPO)$MV_CRNEG.OR.SUBSTR(SE1->E1_TIPO,3,1)=="-"
     		       	  	nCredito := SE1->E1_VLCRUZ
        		   Else
              			nDebito := SE1->E1_VLCRUZ
           			EndIf
        		ElseIf DToS( SE1->E1_EMISSAO ) >= DToS( dFechaIni ) .and. DToS( SE1->E1_EMISSAO ) <= DToS( dFechaFim )
					lGerou	:=	.T.
           			RecLock( "TRB", .T. )
           			TRB->CODIGO  :=  SE1->E1_CLIENTE
           			TRB->LOJA    :=  SE1->E1_LOJA
         			TRB->CLIENTE :=  SA1->A1_NOME
  	      			TRB->TELEFONE :=  SA1->A1_TEL
           			TRB->NUMERO  :=  SE1->E1_NUM
               		If ALLTRIM(SE1->E1_TIPO)$MV_CRNEG .OR. SUBSTR(SE1->E1_TIPO,3,1)=="-"
              			TRB->CREDITO:= SE1->E1_VLCRUZ
           			Else
              			TRB->DEBITO := SE1->E1_VLCRUZ
           			EndIf
           			TRB->NUMERO  :=  SE1->E1_NUM
           			TRB->TIPO    :=  SE1->E1_TIPO
           			TRB->SIGLA   :=  SE1->E1_TIPO
           			TRB->PARCELA :=  SE1->E1_PARCELA
           			TRB->PREFIXO :=  SE1->E1_PREFIXO
               		TRB->VALOR   :=  xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,mv_par09,DDATABASE,,Iif(MV_PAR10==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))
               		TRB->SALTIT  :=  SaldoTit(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_NATUREZ,"R" ,SE1->E1_CLIENTE,mv_par09 , ,dFechaBase,SE1->E1_LOJA,,Iif(MV_PAR10==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))

               		If TRB->SALTIT > 0.00
                  		If SE1->E1_VENCTO == dDataBase
                 			TRB->VENCTO  := dDataBase
                 			TRB->VENCREA := dDataBase
              			ElseIf SE1->E1_VENCTO < dDataBase.And.!Empty(SE1->E1_VENCTO )
                 	   		TRB->VENCTO  := SE1->E1_VENCTO
                 			TRB->VENCREA := SE1->E1_VENCTO
              			Else
                 			TRB->VENCTO  := SE1->E1_VENCTO
                 	   		TRB->VENCREA := SE1->E1_VENCTO
              			EndIf
           	   		Else
              			TRB->VENCTO  := SE1->E1_BAIXA
                	 	 TRB->VENCREA := SE1->E1_VENCTO
            	      	TRB->BAIXA   := SE1->E1_BAIXA
           			EndIf
           			TRB->EMISSAO  :=  SE1->E1_EMISSAO
           			TRB->SALDO    := TRB->DEBITO - TRB->CREDITO
           			MsUnLock()
        		EndIf
			EndIf
			If lGerou
		      	cHistor := ""
		      	If SE1->E1_TIPO == "NCC"
	   	      		cHistor := OemToAnsi(STR0039) //"NOTA DE CREDITO No. "
	     		ElseIf SE1->E1_TIPO == "NDC"
	        	 	cHistor := OemToAnsi(STR0040) //"NOTA DE DEBITO No. "
	      		ElseIf SE1->E1_TIPO == "NF "
	         		cHistor := OemToAnsi(STR0041) //"FACTURA No. "
	      		ElseIf SE1->E1_TIPO == "FT "
	        	 	cHistor := OemToAnsi(STR0041) //"FACTURA No. "
	 	     	ElseIf SE1->E1_TIPO == "RA "
	    	     	cHistor := OemToAnsi(STR0042) //"ANTICIPO"
	    	  	ElseIf SE1->E1_TIPO == "NCI"
	       	  		cHistor := OemToAnsi(STR0043) //"NOTA DE CRED. INTERNA"
	      		ElseIf SE1->E1_TIPO == "NDI"
	         		cHistor := OemToAnsi(STR0044) //"NOTA DE DEB. INTERNA"
				Else
	         		cHistor := OemToAnsi(STR0045) //"NO CLASIFICADO..."
	      		EndIf
	      		RecLock("TRB",.F.)
	        	TRB->HISTOR := cHistor
				MsUnLock()
			Endif
			If lGerou .And.	 lReltGraf
		    	nJuros:=0
	   	    	nAtraso := 0
				dbSelectArea("TRB")
			
				RecLock("TRB",.F.)
				TRB-> NATUREZA:= SE1->E1_NATUREZ
			
	        	If !Empty(VENCREA) .and. dDataBase >= VENCREA
		   	   		FA070Juros( mv_par09 )
					nAtraso:=dDataBase-VENCTO
					If Dow(VENCTO) == 1 .Or. Dow(VENCTO) == 7
						If Dow(dBaixa) == 2 .and. nAtraso <= 2
							nAtraso := 0
						EndIf
					EndIF
					nAtraso:=IIF(nAtraso<0,0,nAtraso)
				EndIf  
		      	If 	nJuros > 0 .Or. nAtraso>0
						TRB->JUROS	:= nJuros
						TRB->ATRASO	:=	nAtraso
	         	EndIf
         		MsUnLock() 
	        EndIF
		EndIf
		// Calcula Juros Release 4
		dbSelectArea("SE1")
		dbSkip()
   EndDo

	dbSelectArea("SEL")
	dbSetOrder(3)
	dbSeek( xFilial( "SEL" ) + cClieIni+cLojaIni,.T. )

	While !Eof() .and. EL_CLIENTE <= cClieFim ;
					 .and. EL_LOJA <= cLojaFim ;
					 .AND. Iif(lVersao,(SEL->EL_VERSAO == F841VERSA(SEL->EL_RECIBO,SEL->EL_SERIE)),.T.);
					 .AND. xFilial( "SEL" ) == EL_FILIAL

		cHistor := ""
	    If SEL->EL_TIPODOC $ "TB.EF.CH"
  	      cHistor := OemToAnsi(STR0046)  //"RECIBO No. "
  		ElseIf SEL->EL_TIPODOC == "RI"
        	cHistor := OemToAnsi(STR0047)  //"RETENCION IVA"
     	ElseIf SEL->EL_TIPODOC == "RG"
        	cHistor := OemToAnsi(STR0048)  //"RET. GANANCIAS"
     	ElseIf SEL->EL_TIPODOC == "RA"
        	cHistor := OemToAnsi(STR0042)  //"ANTICIPO"
     	ElseIf SEL->EL_TIPODOC == "RB"
        	cHistor := OemToAnsi(STR0049)  //"RET. ING. BRUTOS"
     	EndIf
		
		SA1->(dbSetOrder(1))
		SA1->(dbSeek(xFilial("SA1")+SEL->EL_CLIENTE+SEL->EL_LOJA) )
		If !Empty(cFiltSA1) .And. !SA1->(&(cFiltSA1))
			dbSelectArea("SEL")
			dbSkip()
			Loop
		Endif

		If nSituacao == 1 //Historico
			If SEL->EL_TIPODOC $ "TB.RA"
				If SEL->EL_DTDIGIT <= dFechaFim .and.  ! SEL->EL_CANCEL
					If DToS( SEL->EL_DTDIGIT ) < DToS( dFechaIni )
		         		nCredito := SEL->EL_VLMOED1
	   	        		dbSkip()
	      	      		Loop
		        	ElseIf DToS( SEL->EL_DTDIGIT ) >= DToS( dFechaInI ) .and. DToS( SEL->EL_DTDIGIT ) <= DToS( dFechaFim ) // entra aqui 
				      	RecLock("TRB",.T.)
			         	TRB->CODIGO  :=  SEL->EL_CLIENTE
			  	        TRB->LOJA    :=  SEL->EL_LOJA
		   	       		TRB->CLIENTE :=  SA1->A1_NOME
		   	        	TRB->TELEFONE:=  SA1->A1_TEL
		               	TRB->NUMERO  :=  AllTrim( SEL->EL_RECIBO )
		                TRB->PARCELA :=  SEL->EL_PARCELA
		                TRB->TIPO    :=  "RC"
		                TRB->SIGLA   :=  "RC"
		                TRB->EMISSAO :=  SEL->EL_DTDIGIT
		                TRB->VENCTO  :=  SEL->EL_DTDIGIT
		                TRB->CREDITO := TRB->CREDITO + SEL->EL_VLMOED1
		                TRB->SALDO   := TRB->CREDITO*-1
		                TRB->HISTOR := cHistor
		                MsUnLock()
	        		EndIf
	        	EndIf
	        EndIf
		Else	//Piendente
			If SEL->EL_TIPODOC $ "TB.RA"
				If ! SEL->EL_CANCEL
					If DToS( SEL->EL_DTDIGIT ) < DToS( dFechaIni )
		         		nCredito := SEL->EL_VLMOED1
		  	        	dbSkip()
	      	      		Loop
		        	ElseIf DToS( SEL->EL_DTDIGIT ) >= DToS( dFechaIni ) .and. DToS( SEL->EL_DTDIGIT ) <= DToS( dFechaFim )
				      	RecLock("TRB",.T.)
			         	TRB->CODIGO  :=  SEL->EL_CLIENTE
		   	     	    TRB->LOJA    :=  SEL->EL_LOJA
		   	       		TRB->CLIENTE :=  SA1->A1_NOME
		   	       	 	TRB->TELEFONE:=  SA1->A1_TEL
		                TRB->NUMERO  :=  AllTrim( SEL->EL_RECIBO )
		                TRB->PARCELA :=  SEL->EL_PARCELA
		                TRB->TIPO    :=  "RC"
		                TRB->SIGLA   :=  "RC"
		                TRB->EMISSAO :=  SEL->EL_DTDIGIT
		                TRB->VENCTO  :=  SEL->EL_DTDIGIT
		                TRB->CREDITO := TRB->CREDITO + SEL->EL_VLMOED1
		                TRB->SALDO   := TRB->CREDITO*-1
		                TRB->HISTOR := cHistor
		                MsUnLock()
	        		EndIf
				EndIf
			EndIf
		EndIf
	   dbSelectArea("SEL")
	   dbSkip()
	EndDo
Return