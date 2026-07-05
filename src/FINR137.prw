/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR137.ch"
#INCLUDE "PROTHEUS.CH"
//#INCLUDE "FWLIBVERSION.CH"

Static lFWCodFil := FindFunction("FWCodFil")
Static nVends 
Static _oFinr1371 
Static __oF137Lq 
Static _oTmpLiq 
Static __aCposCos
Static __cBDName := AllTrim(tcGetdb())
Static __oTitPr As Object
Static __lCachedQry As Logical
Static __nTpLiq As Numeric
Static __cSGBD As Character

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR137  ³ Autor ³Marcel Borges Ferreira ³ Data ³ 22/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Posicao de Titulos a Receber por Vendedor                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FINR137                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Finr137()

	Local oReport

	oReport:=ReportDef()
	oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Marcel Borges Ferreira ³ Data ³ 22/06/06 ³±±
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

Local oReport
Local dOldDtBase := dDataBase
Local cMascara := Getmv("MV_MASCNAT")
Local nTamNat  := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Variaveis utilizadas para parametros								   ³
//³  mv_par01		 // Do Cliente										   ³
//³  mv_par02		 // Da Loja											   ³
//³  mv_par03		 // Ate o Cliente									   ³
//³  mv_par04		 // Ate a Loja  									   ³
//³  mv_par05		 // Da Emissao 										   ³
//³  mv-par06      // Ate Emissao	   			 						   ³
//³  mv_par07		 // Do vencimento									   |
//³  mv_par08		 // Ate o vencimento								   |
//³  mv_par09		 // Do vendedor    				 					   |
//³  mv_par10		 // Ate o vendedor   								   |
//³  mv_par11		 // Considera Tipos    								   |
//³  mv_par12		 // Nao considera tipos								   |
//³  mv_par13		 // Qual moeda										   |
//³  mv_par14		 // Outras Moedas : 1-converte 2=nao imprime		   |
//³  mv_par15		 // Considera data base : 1-Sim, 2=Nao				   |
//³  mv_par16		 // Database										   |
//³  mv_par17		 // Considera Filiais abaixo (1=Sim/2=Nao)			   |
//³  mv_par18		 // Filial De  										   |
//³  mv_par19		 // Filial Ate										   |
//³  mv_par20		 // Salta Pag. Vendedor								   |
//³  mv_par21		 // Converte valores pela (Taxa do dia/Taxa do mov.)   |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Pergunte("FIN137",.F.)

oReport := TReport():New("FINR137",STR0001+" "+STR0005+GetMv("MV_MOEDA" + Str(mv_par13,1,0) ),"FIN137",{|oReport| ReportPrint(oReport)},STR0001) // Este relatorio ira imprimir os Titulos a Receber, não baixados, por Vendedor.

//Acerta a database de acordo com a database real do sistema
If mv_par15 == 1    // Considera Data Base
	dDataBase := dOldDtBase
Endif	

oReport:SetTotalText(STR0008)
oReport:SetTotalinLine(.F.)
oReport:SetLandscape()

/*/
ÚÄÄÄÄÄÄÄÄÄÄÄ¿
³  Secao 1  ³
ÀÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

oSection1 := TRSection():New(oReport,STR0025, ("TRB","SA3") )

TRCell():New( oSection1, "A3_COD"	,"SA3",,/*Picture*/,10,/*lPixel*/,/*{|| code-block de impressao }*/)	// PRF
TRCell():New( oSection1, "A3_NOME"	,"SA3",,/*Picture*/,40 ,/*lPixel*/,/*{|| code-block de impressao }*/)	// PRF

oSection1:SetNoFilter("SA3")

/*/
ÚÄÄÄÄÄÄÄÄÄÄÄ¿
³  Secao 2  ³
ÀÄÄÄÄÄÄÄÄÄÄÄÙ
/*/

nTamNat:= If(!empty(cMascara),len(cMascara)-1, 0)

oSection2 := TRSection():New(oSection1,STR0026, {"TRB","SE1","SED"} )

TRCell():New( oSection2, "E1_PREFIXO"	,"SE1",STR0009,/*Picture*/,3 ,/*lPixel*/,/*{|| code-block de impressao }*/)	// PRF
TRCell():New( oSection2, "E1_NUM"		,"SE1",STR0010,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)	// NUMERO
TRCell():New( oSection2, "E1_PARCELA"	,"SE1",STR0011,/*Picture*/,3,/*lPixel*/,/*{|| code-block de impressao }*/)	// PARC
TRCell():New( oSection2, "E1_TIPO"		,"SE1",STR0012,/*Picture*/,3 ,/*lPixel*/,/*{|| }*/)	// TIPO
TRCell():New( oSection2, "E1_CLIENTE"	,"SE1",STR0013,/*Picture*/,6,/*lPixel*/,/*{|| code-block de impressao }*/)	// CLIENTE
TRCell():New( oSection2, "E1_LOJA"		,"SE1",STR0014,/*Picture*/,2,/*lPixel*/,/*{|| code-block de impressao }*/)	// LOJA
TRCell():New( oSection2, "E1_NOMCLI"	,"SE1",STR0015,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)	// NOME DO CLIENTE
TRCell():New( oSection2, "E1_EMISSAO"	,"SE1",STR0016,/*Picture*/,9,/*lPixel*/,/*{|| code-block de impressao }*/)	// EMISSAO
TRCell():New( oSection2, "E1_VENCTO"	,"SE1",STR0017,/*Picture*/,9,/*lPixel*/,/*{|| code-block de impressao }*/)	// VENCIMENTO
TRCell():New( oSection2, "E1_VALOR"		,"SE1",STR0018,PesqPict("SE1","E1_VALOR"),,/*lPixel*/,)	// VALOR
TRCell():New( oSection2, "E1_SALDO"		,"SE1",STR0019,PesqPict("SE1","E1_SALDO"),,/*lPixel*/,)// SALDO
TRCell():New( oSection2, "E1_JUROS"		,"SE1",STR0020,PesqPict("SE1","E1_JUROS"),,/*lPixel*/,/*{|| nJuros := fa070juros(mv_par13,(cAliasSec1)->E1_SALDO,(cAliasSec1))}*/)// JUROS
TRCell():New( oSection2, "VLACESS"		,"SE1",STR0027,PesqPict("SE1","E1_VALOR"),,/*lPixel*/,)// "Vlr Acessorio"
TRCell():New( oSection2, "CEL_SLDCOR"	,     ,STR0021,PesqPict("SE1","E1_VALOR"),17,/*lPixel*/,)// SALDO CORRENTE
TRCell():New( oSection2, "E1_NATUREZ"   ,"SE1",STR0022,/*Picture*/,TamSX3("E1_NATUREZ")[1] + nTamNat,/*lPixel*/,/*{|| code-block de impressao }*/,,,,,,.F.)// NATUREZA
TRCell():New( oSection2, "ED_DESCRIC"	,"SED",STR0023,/*Picture*/,15,/*lPixel*/,/*{|| code-block de impressao }*/)// DESCRICAO
TRCell():New( oSection2, "TITLIQ"	    ,     ,STR0028,/*Picture*/,6,/*lPixel*/,)// "TIT. LIQUIDADO"
TRCell():New( oSection2, "CEL_ATRASO"	,     ,STR0024,/*Picture*/,3,/*lPixel*/,)// ATRASO

oSection2:SetNoFilter("SED")

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Marcel Borges Ferreira ³ Data ³ 23/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos os³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.           ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³05/10/2007³ Pedro P Lima  ³Foi corrigido a geracao de relatorio de      ³±±
±±³          ³    TI6434     ³de titulos liquidados, pois quando a rotina  ³±±
±±³          ³               ³rodava, eram geradas linhas duplicadas desses³±±
±±³          ³               ³mesmos titulos, causando inconsistencia no   ³±±
±±³          ³               ³nos dados, inclusive no valor total por      ³±±
±±³          ³               ³vendedor                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)
Local oSection1		:= oReport:Section(1) 
Local oSection2		:= oReport:Section(1):Section(1)
Local cFilterUser	:= oReport:Section(1):Section(1):GetAdvplExp("SE1")
Local aTam			:= {}
Local aCampos		:= {}    
Local cVend			:= ""
Local aVend			:= {}
Local nPosVend		:= 0
Local nAbatim		:= 0
Local nVend			:= fa440CntVen()
Local cVendedor		:= ""
Local nY			:= 0
Local nZ			:= 0
Local nVendTit		:= 0
Local lLiq			:= .F.
Local lFirst		:= .T.
Local nSaldo		:= 0
Local nCont			:= 0
Local cLiqProc		:= ""
Local aVendedor		:= {}
Local cDataFim		:= ''
Local cAliasQry		:= "SE1"
Local cQuery		:= ""
Local nI 			:= 0
Local aStru 		:= SE1->(dbStruct())
Local nVlAcess		:= 0
Local aTitPaiLiq	:= {}
Local aTitFilLiq	:= {}
Local nSaldoLiq	    := 0
Local aTitPai		:= {}
Local aTitFil		:= {}
Local aDtParam		:= {}
Local nX			:= 0
Local cFilSe1		:= ""
Local cFilSa3		:= ""
Local cFilSed		:= ""
Local aStruLiq		:= {}

Private nJuros		:= 0
Private nIndexSE5	:= 0
Private cControl    := "00000000"

dbSelectArea("SE1")
dbSetOrder(1)

dbSelectArea("SA3")
dbSetOrder(1)

If __lCachedQry == Nil
	__lCachedQry := .T. //FwLibVersion() >= "20211116"
EndIf

If __nTpLiq == Nil
	__nTpLiq := TamSx3('E1_TIPOLIQ')[1]
EndIf

If __cSGBD == Nil
	__cSGBD := AllTrim(Upper(TcGetDb()))
EndIf

If mv_par20 == 1
	oSection1:SetPageBreak()
endif	

oSection1:Cell("A3_COD" 	 ):SetBlock({|| cVend })
oSection1:Cell("A3_NOME" 	 ):SetBlock({|| SA3->A3_NOME })			  		

oSection1:SetTotalInLine(.F.)
oSection1:SetTotalText(STR0007) //Total do vendedor
oSection1:SetHeaderSection(.F.)

oSection2:Cell("E1_PREFIXO" ):SetBlock({|| TRB->PREFIXO })		
oSection2:Cell("E1_NUM"     ):SetBlock({|| TRB->NUM })		
oSection2:Cell("E1_PARCELA" ):SetBlock({|| TRB->PARCELA })		
oSection2:Cell("E1_TIPO"    ):SetBlock({|| TRB->TIPO })		
oSection2:Cell("E1_CLIENTE" ):SetBlock({|| SE1->E1_CLIENTE })		
oSection2:Cell("E1_LOJA"    ):SetBlock({|| SE1->E1_LOJA })
oSection2:Cell("E1_NOMCLI"  ):SetBlock({|| SE1->E1_NOMCLI })
oSection2:Cell("E1_EMISSAO" ):SetBlock({|| SE1->E1_EMISSAO })
oSection2:Cell("E1_VENCTO"  ):SetBlock({|| SE1->E1_VENCTO })
oSection2:Cell("E1_VALOR"   ):SetBlock({|| nValor })
oSection2:Cell("E1_SALDO" 	):SetBlock({|| TRB->SALDO }) 
oSection2:Cell("E1_JUROS" 	):SetBlock({|| nJuros })	
nVlAcess := IIf(ExistFunc('FValAcess') ,FValAcess(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_TIPO,SE1->E1_CLIENTE,SE1->E1_LOJA, SE1->E1_NATUREZ,!Empty(SE1->E1_BAIXA),,"R",SE1->E1_BAIXA,,SE1->E1_MOEDA), 0)
oSection2:Cell("VLACESS"	):SetBlock({|| nVlAcess })
oSection2:Cell("CEL_SLDCOR" ):SetBlock({|| TRB->SALDO + nJuros + nVlAcess })
oSection2:Cell("E1_NATUREZ" ):SetBlock({|| MascNat(SE1->E1_NATUREZ) })
oSection2:Cell("ED_DESCRIC" ):SetBlock({|| SED->ED_DESCRIC })
oSection2:Cell("TITLIQ"     ):SetBlock({|| TRB->NUMLIQ }) // "LIQUIDADO"
oSection2:Cell("CEL_ATRASO" ):SetBlock({|| Padl(nAtraso,3) })

oSection2:SetTotalinLine(.F.)
oSection2:SetHeaderPage()	//Define o cabecalho da secao como padrao

TRFunction():New(oSection2:Cell("E1_JUROS")  ,/*"oTotal"*/,"SUM", /*oBreak */,STR0007,/*[ cPicture ]*/,/*[ uFormula ]*/,   ,.F.,,/*oSection1*/)
TRFunction():New(oSection2:Cell("E1_VALOR")  ,/*[ cID ]*/ ,"SUM", /*oBreak*/ ,STR0007,/*[ cPicture ]*/,/*[ uFormula ]*/,   ,.F.,,/*oSection1*/)
TRFunction():New(oSection2:Cell("E1_SALDO")  ,/*[ cID ]*/ ,"SUM", /*oBreak*/ ,STR0007,/*[ cPicture ]*/,/*[ uFormula ]*/,   ,.F.,,/*oSection1*/)
TRFunction():New(oSection2:Cell("CEL_SLDCOR"),/*[ cID ]*/ ,"SUM", /*oBreak*/ ,STR0007,/*[ cPicture ]*/,/*[ uFormula ]*/,.T.,.T.,,/*oSection1*/)
TRFunction():New(oSection2:Cell("VLACESS")   ,/*"oTotal"*/,"SUM", /*oBreak */,STR0007,/*[ cPicture ]*/,/*[ uFormula ]*/,   ,.F.,,/*oSection1*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Geracao do arquivo de Trabalho	        			              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("E1_VEND1")
AADD(aCampos,{"CODVEND"  ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_FILIAL")
AADD(aCampos,{"FILIAL"    ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_PREFIXO")
AADD(aCampos,{"PREFIXO"    ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_NUM")
AADD(aCampos,{"NUM"    ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_PARCELA")
AADD(aCampos,{"PARCELA"    ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_TIPO")
AADD(aCampos,{"TIPO"    ,"C",aTam[1],aTam[2]})

aTam:=TamSX3("E1_SALDO")
AADD(aCampos,{"SALDO"    ,"N",aTam[1],aTam[2]})

aTam:=TamSX3("E1_VALOR")
AADD(aCampos,{"VALOR"    ,"N",aTam[1],aTam[2]})

aTam:=TamSX3("E1_NUMLIQ")
AADD(aCampos,{"NUMLIQ"    ,"C",aTam[1],aTam[2]})

AADD(aCampos,{"CONTROL", "C", 8, 2})

If _oFinr1371 <> Nil
	_oFinr1371:Delete()
	_oFinr1371 := Nil
Endif

_oFinr1371 := FWTemporaryTable():New( "TRB" )  
_oFinr1371:SetFields(aCampos) 	
_oFinr1371:AddIndex("1", {"CODVEND","FILIAL","PREFIXO","NUM","PARCELA","TIPO"}) 
_oFinr1371:AddIndex("2", {"CODVEND","CONTROL"})

//------------------
//Criação da tabela temporaria
//------------------
_oFinr1371:Create()		

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atribui valores as variaveis ref a filiais                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par17 == 2
	cFilDe  := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	cFilAte := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
ELSE
	cFilDe := mv_par18	// Todas as filiais
	cFilAte:= mv_par19
Endif

dbSelectArea("SM0")
SM0->(MsSeek(cEmpAnt+cFilDe,.T.))

nRegSM0 := SM0->(Recno())
nAtuSM0 := SM0->(Recno())

//Acerta a database de acordo com o parametro
If mv_par15 == 1    // Considera Data Base
	dDataBase := mv_par16
Endif	

If Empty(mv_par09)
	mv_par09 := Replicate( "0", TAMSX3("A3_COD")[1] ) 
Endif

If MV_PAR06 > mv_par16
	cDataFim := DTOS(mv_par16)
Else
	cDataFim := DTOS(mv_par06)
EndIf

aAdd( aStruLiq, {'FI7_FILDES'   ,'C',TamSx3("FI7_FILDES")[1],0} )    
aAdd( aStruLiq, {'FI7_PRFDES'   ,'C',TamSx3("FI7_PRFDES")[1],0} )    
aAdd( aStruLiq, {'FI7_NUMDES'   ,'C',TamSx3("FI7_NUMDES")[1],0} )    
aAdd( aStruLiq, {'FI7_PARDES'   ,'C',TamSx3("FI7_PARDES")[1],0} )    
aAdd( aStruLiq, {'FI7_TIPDES'   ,'C',TamSx3("FI7_TIPDES")[1],0} )    
aAdd( aStruLiq, {'FI7_CLIDES'   ,'C',TamSx3("FI7_CLIDES")[1],0} )    
aAdd( aStruLiq, {'FI7_LOJDES'   ,'C',TamSx3("FI7_LOJDES")[1],0} )  

cAliasQry	:= GetNextAlias()

While !Eof() .and. M0_CODIGO == cEmpAnt .and. IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL ) <= cFilAte
     
	dbSelectArea("SE1")
	cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
	cFilSe1 := xFilial("SE1")

	TabLiqTemp( aStruLiq , cFilSe1 , cDataFim )

	cQuery := "SELECT * FROM " + RetSqlName("SE1") + " SE1 
	cQuery += " LEFT JOIN " + _oTmpLiq:GetRealName()
	cQuery += " 	ON E1_FILIAL = FI7_FILDES "
	cQuery += " 	AND E1_PREFIXO = FI7_PRFDES  "
	cQuery += " 	AND E1_NUM = FI7_NUMDES "
	cQuery += " 	AND E1_PARCELA = FI7_PARDES "
	cQuery += " 	AND E1_TIPO = FI7_TIPDES "
	cQuery += " 	AND E1_CLIENTE = FI7_CLIDES "
	cQuery += " 	AND E1_LOJA = FI7_LOJDES	 "
	cQuery += " WHERE E1_FILIAL = '" + cFilSe1 + "' AND "
	cQuery += "E1_CLIENTE >= '" + MV_PAR01 + "' AND E1_CLIENTE <= '" + MV_PAR03 + "' AND "
	cQuery += "E1_LOJA >= '" + MV_PAR02 + "' AND E1_LOJA <= '" + MV_PAR04 + "' AND " 		
	cQuery += "E1_EMISSAO >= '" + DTOS(MV_PAR05) + "' AND E1_EMISSAO <= '" + cDataFim + "' AND "
	cQuery += "E1_VENCTO >= '" + DTOS(MV_PAR07) + "' AND E1_VENCTO <= '" + DTOS(MV_PAR08) + "'AND "
	If mv_par15 == 2
		cQuery += " E1_SALDO > 0 AND "
	EndIf
	/* Se estiver preenchido e tiver mais de um tipo, separador DEVE ser ';' segundo help da pergunta*/
	If !Empty(mv_par11)
		If At(";",mv_par11)>0
			cIn := FormatIn(mv_par11,";") 
			cQuery += "E1_TIPO IN " + cIn + " AND "
		Else
			cQuery += "E1_TIPO = '"+Alltrim(mv_par11) +"' AND "
		Endif
	EndIf
	/* Se estiver preenchido e tiver mais de um tipo, separador DEVE ser ';' segundo help da pergunta*/
	If !Empty(mv_par12)
		If At(";",mv_par12) > 0
			cIn := FormatIn(mv_par12,";")
			cQuery += "E1_TIPO NOT IN " + cIn + " AND "
		Else
			cQuery += "E1_TIPO <> '"+Alltrim(mv_par12) +"' AND "
		Endif 
	Endif

	/* Vendedor de mv_par09 ate mv_par10  preenchidos*/
	If nVend <= 5
		/* Vendedor de mv_par09 E mv_par10 são iguais */
		If Alltrim(mv_par09) == Alltrim(mv_par10)
			cQuery += "((E1_NUMLIQ <> ' ') OR "	
			cQuery += " ( E1_VEND1 = '"+ Alltrim(mv_par09)+"' AND E1_NUMLIQ = ' ') OR "
			cQuery += " ( E1_VEND2 = '"+ Alltrim(mv_par09)+"' AND E1_NUMLIQ = ' ') OR "
			cQuery += " ( E1_VEND3 = '"+ Alltrim(mv_par09)+"' AND E1_NUMLIQ = ' ') OR "
			cQuery += " ( E1_VEND4 = '"+ Alltrim(mv_par09)+"' AND E1_NUMLIQ = ' ') OR "
			cQuery += " ( E1_VEND5 = '"+ Alltrim(mv_par09)+"' AND E1_NUMLIQ = ' ') ) AND "
		Else
			If Alltrim(mv_par09) < Alltrim(mv_par10)
				/* Range de Vendedores de mv_par09 E mv_par10 são iguais */
				cQuery += "((E1_NUMLIQ <> ' ') OR "
				cQuery += " ( E1_VEND1 between '"+ Alltrim(mv_par09)+"' AND '"+ Alltrim(mv_par10)+"'  AND E1_NUMLIQ = ' ') OR "
				cQuery += " ( E1_VEND2 between '"+ Alltrim(mv_par09)+"' AND '"+ Alltrim(mv_par10)+"'  AND E1_NUMLIQ = ' ') OR "
				cQuery += " ( E1_VEND3 between '"+ Alltrim(mv_par09)+"' AND '"+ Alltrim(mv_par10)+"'  AND E1_NUMLIQ = ' ') OR "
				cQuery += " ( E1_VEND4 between '"+ Alltrim(mv_par09)+"' AND '"+ Alltrim(mv_par10)+"'  AND E1_NUMLIQ = ' ') OR "
				cQuery += " ( E1_VEND5 between '"+ Alltrim(mv_par09)+"' AND '"+ Alltrim(mv_par10)+"'  AND E1_NUMLIQ = ' ') ) AND "
			EndIf
		EndIf
	Endif
	If mv_par14 == 2
		cQuery += "E1_MOEDA = " + STR(mv_par13) + " AND "
	EndIf
	cQuery += "	FI7_NUMDES IS NULL AND "
	cQuery += " SE1.D_E_L_E_T_ = ' ' "
	cQuery += " ORDER BY E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "
	cQuery := ChangeQuery(cQuery)

	If Select(cAliasQry) > 0
		(cAliasQry)->(dbCloseArea())
	EndIf

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),cAliasQry,.F., .T.)
	If (cAliasQry)->(!Eof())
		For nI := 1 TO LEN(aStru)
			If aStru[nI][2] != "C"
				TCSetField(cAliasQry, aStru[nI][1], aStru[nI][2], aStru[nI][3], aStru[nI][4])
			EndIf
		Next
	EndIf
	dbSelectArea(cAliasQry)
	dbGoTop()
	
	If Select("__SE1") == 0
		ChkFile("SE1",.F.,"__SE1")
	Endif
	
	dbSelectArea(cAliasQry)
	
	While (cAliasQry)->(!Eof()) .and. (cAliasQry)->E1_FILIAL == cFilSe1

		lLiq 		:= .F.
		aLiquid 	:= {}
		aVendedor	:= {{},{},{},{}}

		nCont := nCont + 1
		If nCont >= 100000
			oReport:IncMeter()
			nCont:= 0
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			(cAliasQry)->(dbSkip())
			Loop
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se é título Liquidado.                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cAliasQry)->E1_NUMLIQ) .And. (cAliasQry)->E1_SALDO <> 0 .And. !(cAliasQry)->E1_TIPO $ MV_CRNEG 
			aVendedor := Vendedor137(cAliasQry,nIndexSE5,cFilSe1)						
			nSaldo:= VlTitDtBas(cAliasQry)

			If ! (cAliasQry)->E1_TIPO $ MVABATIM
				If ! ((cAliasQry)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. ;
						!( MV_PAR15 == 2 .And. nSaldo == 0 )  	// deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
					nAbatim := SomaAbat((cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,"R",mv_par15,,(cAliasQry)->E1_CLIENTE,(cAliasQry)->E1_LOJA)
					If STR(nSaldo,17,2) == STR(nAbatim,17,2)
						nSaldo := 0
					Else
						nSaldo-= nAbatim
					Endif
				Endif	
			Else
				(cAliasQry)->(dbSkip())                          
				Loop
			Endif

			nSaldo:=Round(NoRound(nSaldo,3),2)
	
			If nSaldo <= 0
				(cAliasQry)->(dbSkip())                          
				Loop
			Endif
	
			Fa440LiqSe1((cAliasQry)->E1_NUMLIQ,@aLiquid)		    

			If !((cAliasQry)->E1_NUMLIQ $ cLiqProc)
				aVend := {}
				For nZ := 1 To Len(aLiquid)
					__SE1->(dbgoto(aLiquid[nZ]))
					
					For nVendTit := 1 to len(aVendedor[1])										
						For nY := 1 To nVend
							cVendedor := aVendedor[1][nVendTit][nY]					                         							
							If cVendedor >= mv_par09 .AND. cVendedor <= mv_par10 .AND. !Empty(cVendedor)
								nPosVend := aScan(aVend,{|x| x[1] == cVendedor})
								If nPosVend = 0
									aAdd(aVend, {cVendedor,__SE1->E1_VALOR})
								Else
									aVend[nPosVend][2] += __SE1->E1_VALOR
								EndIf
							EndIf
						Next
						cLiqProc := (cAliasQry)->E1_NUMLIQ
					Next	
				Next
			EndIf

			For nZ := 1 to Len(aVend)
				R137TR4(aVend[nZ][1], nSaldo, cAliasQry, cLiqProc)
			Next
			
			lLiq := .T.
			(cAliasQry)->(dbSkip())                          
			Loop
      	EndIf
				
		If Len(aVendedor[1]) <= 0
			aVendedor := Vendedor137(cAliasQry,nIndexSE5,cFilSe1)
		Endif			
		
		If Len(aVendedor[1]) <= 0
			(cAliasQry)->(dbSkip())
			Loop
		EndIf

		 // Tratamento da correcao monetaria para a Argentina
		If  cPaisLoc=="ARG" .And. mv_par13 <> 1  .And.  (cAliasQry)->E1_CONVERT=='N'
			(cAliasQry)->(dbSkip())
			Loop
		Endif

		// Verifica se virou um título liquidado
		If (cAliasQry)->E1_TIPOLIQ == 'LIQ'
			dbSelectArea("FI7")
			dbSetOrder(1)
			aTitFilLiq := {}
			aTitPaiLiq := {}

			aTitPai := {(cAliasQry)->E1_FILIAL,(cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,(cAliasQry)->E1_TIPO,(cAliasQry)->E1_CLIENTE,(cAliasQry)->E1_LOJA}
			aDtParam := {DTOS(MV_PAR05),cDataFim,DTOS(MV_PAR07),DTOS(MV_PAR08)}

			aTitFil := FR137Liq(aTitPai,aDtParam)

			For nX := 1 To Len(aTitFil)
				aAdd(aTitFilLiq, aTitFil[nX])
				SE1->(DbGoto(aTitFil[nX]))
                
				nSaldo := Round(NoRound(VlTitDtBas("SE1"), 3), 2)
				nSaldoLiq := Round(NoRound(VlTitDtBas(cAliasQry), 3), 2)

				For nVendTit := 1 to len(aVendedor[1])
					For nY := 1 To nVend
						cVendedor := aVendedor[1][nVendTit][nY]					
						If cVendedor >= mv_par09 .And. cVendedor <= mv_par10 .AND. !Empty(cVendedor)
							If !aScan(aTitPaiLiq, {|x| x[2] == (cAliasQry)->(RECNO()) .And. x[1] == cVendedor}) .And. (cAliasQry)->E1_SALDO <> 0
								R137TR4(cVendedor, nSaldoLiq, cAliasQry, SE1->E1_NUMLIQ)
								aAdd(aTitPaiLiq, {cVendedor, (cAliasQry)->(RECNO())})
							EndIf
							R137TR4(cVendedor, nSaldo, "SE1", SE1->E1_NUMLIQ)
						EndIf
					Next
				Next
			Next nX
			If Len(aTitFil) > 0 
				(cAliasQry)->(dbSkip())
				Loop
			EndIf
		EndIf

		//Se não for titulo liquidado
		If !lLiq
			nSaldo := VlTitDtBas(cAliasQry)
	
			If ! (cAliasQry)->E1_TIPO $ MVABATIM
				If ! ((cAliasQry)->E1_TIPO $ MVRECANT+"/"+MV_CRNEG) .And. ;
						!( MV_PAR15 == 2 .And. nSaldo == 0 )  	// deve olhar abatimento pois e zerado o saldo na liquidacao final do titulo
					nAbatim := SomaAbat((cAliasQry)->E1_PREFIXO,(cAliasQry)->E1_NUM,(cAliasQry)->E1_PARCELA,"R",mv_par15,,(cAliasQry)->E1_CLIENTE,(cAliasQry)->E1_LOJA)
					If STR(nSaldo,17,2) == STR(nAbatim,17,2)
						nSaldo := 0
					Else
						nSaldo-= nAbatim
					Endif
				Endif	
			Else
				(cAliasQry)->(dbSkip())
				Loop
			Endif
			
			nSaldo:=Round(NoRound(nSaldo,3),2)
			
			If nSaldo <= 0
				(cAliasQry)->(dbSkip())
				Loop
			Endif    

			For nVendTit := 1 to len(aVendedor[1])
				For nY := 1 To nVend								
					cVendedor := aVendedor[1][nVendTit][nY]					
					If cVendedor >= mv_par09 .And. cVendedor <= mv_par10 .AND. !Empty(cVendedor)
						R137TR4(cVendedor, nSaldo, cAliasQry,(cAliasQry)->E1_NUMLIQ) 
					EndIf
				Next
			Next  

			(cAliasQry)->(dbSkip())
			Loop
		EndIf
	Enddo

	If Empty(FwFilial("SE1"))
		Exit
	Endif

	_oTmpLiq:Delete()
	_oTmpLiq := Nil

	dbSelectArea("SM0")
	dbSkip()
	Loop
Enddo	

SM0->(dbGoTo(nRegSM0))
cFilAnt := IIf( lFWCodFil, FWGETCODFILIAL, SM0->M0_CODFIL )
cFilSa3 := xFilial("SA3")
cFilSed := xFilial("SED")

dbSelectArea(cAliasQry)
dbCloseArea()
ChKFile("SE1")
dbSelectArea("SE1")
dbSetOrder(1)

TRB->(DBSetOrder(2))
TRB->(dbgotop())

oReport:SetMeter(TRB->(RecCount()))		

While !TRB->(EOF())

	cVar		:= TRB->CODVEND
	nTotal 		:= 0
	nTotJur 	:= 0 
	cVend		:= Space(06)
	
	While !TRB->(EOF()) .AND. cVar==TRB->CODVEND
		
		cVend:=TRB->CODVEND
				
		If lFirst
			dbSelectArea("SA3")
			dbSetOrder(1)
			SA3->(MsSeek(cFilSa3 + cVend))

			oSection1:Init()
			oSection1:PrintLine()
            oSection1:Finish()

			lFirst := .F.
		Endif		

		oSection2:Init()	
		oSection2:SetTotalText(STR0007 + cVar + " " + SA3->A3_NOME)	//"TOTAL DO VENDEDOR : "

		SE1->(MsSeek(TRB->(FILIAL+PREFIXO+NUM+PARCELA+TIPO)))
		nValor  := xMoeda(SE1->E1_VALOR,SE1->E1_MOEDA,MV_PAR13,,,Iif(MV_PAR21==2,Iif(!Empty(SE1->E1_TXMOEDA),SE1->E1_TXMOEDA,RecMoeda(SE1->E1_EMISSAO,SE1->E1_MOEDA)),0))
		nAtraso := (mv_par16-SE1->E1_VENCTO)
		nAtraso := If(nAtraso < 0, 0, nAtraso)

		dbSelectArea("SE1")
		nJuros := fa070juros(mv_par13)

		dbSelectArea("SED")
		dbSetOrder(1)
		SED->(MsSeek(cFilSed + SE1->E1_NATUREZ))
	
		nTotJur += nJuros

		If SE1->E1_TIPO $ MV_CRNEG+"/"+MVRECANT
			nTotal -=  TRB->SALDO
		Else
			nTotal +=  TRB->SALDO
		Endif	
		
		oSection2:PrintLine()	
		
		TRB->(dbSkip()) 
	EndDo
	oSection2:Finish()
   lFirst := .T.
Enddo
TRPosition():New (oSection1,"SA3",1,{||cFilSa3+TRB->CODVEND})
TRPosition():New (oSection2,"SE1",1,{||SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO})

If Select("TRB") > 0
	TRB->(dbCloseArea())		  // Elimina arquivos de Trabalho
Endif

//Deleta tabela temporária do banco de dados
If _oFinr1371 <> Nil
	_oFinr1371:Delete()
	_oFinr1371 := Nil
Endif

If _oTmpLiq <> Nil
	_oTmpLiq:Delete()
	_oTmpLiq := Nil
Endif

If __oF137Lq <> NIL
	__oF137Lq:Destroy()
	__oF137Lq := NIL
Endif	

FwFreeArray(__aCposCos)

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³R137TR4   ºAutor  ³Marcel Borges Ferreira º Data ³  05/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gravacao do arquivo de trabalho                                º±±
±±º          ³                                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R137TR4(cVend As Character, nSaldo As Numeric, cAlias As Character, cNumLiq As Character)
	Local aArea As Array
	Local cInsert As Character
	Local nExecQry As Numeric

	Default cVend := ''
	Default nSaldo := 0
	Default cAlias := ''	
	Default cNumLiq := ''	

	aArea := GetArea()
	cControl := Soma1(cControl)

	dbSelectArea("TRB")
	dbSetOrder(1)
	
	If !(TRB->(MsSeek(cVend + (cAlias)->E1_FILIAL + (cAlias)->E1_PREFIXO + (cAlias)->E1_NUM + (cAlias)->E1_PARCELA + (cAlias)->E1_TIPO)))
		
		cInsert := "INSERT"
		
		If __cSGBD == "ORACLE"
			cInsert += " /*+ APPEND */"
		EndIf		

		cInsert += " INTO "+_oFinr1371:GetRealName()
		cInsert += " (CODVEND,FILIAL,PREFIXO,NUM,PARCELA,TIPO,SALDO,NUMLIQ,CONTROL)"
		cInsert += " VALUES ('"+cVend+"','"+(cAlias)->E1_FILIAL+"','"+(cAlias)->E1_PREFIXO+"',"
		cInsert += " '"+(cAlias)->E1_NUM+"','"+(cAlias)->E1_PARCELA+"','"+(cAlias)->E1_TIPO+"',"
		cInsert += Alltrim(Str(nSaldo))+",'"+cNumLiq+"','"+cControl+"')"
		
		nExecQry := TcSqlExec(cInsert)
		
		If nExecQry < 0
			UserException(TCSQLError())
		EndIf	

	EndIf

	RestArea( aArea )
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ TitPrinc ³ Autor ³ Marcelo Celi Marques  ³ Data ³ 18/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna um array com as comissões, vendedores e tit princ  ³±±
±±³          ³ dos títulos que foram liquidados/faturados                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr137.prx, Finr610.prx                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TitPrinc(FILIAL,PREFIXO,NUMERO,PARCELA,TIPO,AliasSE1,aVendedor,nIndexSE5,cAliasQry)	
	Local aVends As Array
	Local aComis As Array
	Local aBase As Array
	Local nX As Numeric
	Local nIndex As Numeric
	Local lContinua As Logical
	Local cAliasBkp	As Character
	Local cQuery As Character
	Local cCampoE1 As Character
	Local cVends As Character
	Local cAliasLiq As Character

	Default FILIAL	:= ""
	Default PREFIXO	:= ""
	Default NUMERO	:= ""
	Default PARCELA	:= ""
	Default AliasSE1 := ""
	Default aVendedor := {}
	Default nIndexSE5:= 0
	Default cAliasQry := ""

	aVends := {}
	aComis := {}
	aBase := {}
	nX := 0
	lContinua := .T.
	cAliasBkp := AliasSE1
	cQuery := ""
	cCampoE1 := ""
	cVends := ""

	If nVends == nil
		nVends := fa440CntVen()
	Endif

	If __aCposCos == Nil
		__aCposCos := fa440Cpos()
	EndIf

	If __nTpLiq == Nil
		__nTpLiq := TamSx3('E1_TIPOLIQ')[1]
	EndIf

	//	Não realizar seek na SE1 se o alias for da query (já tem os dados na query)
	If Empty(cAliasQry)	// Caso não venha de query, posicionar na tabela
		(AliasSE1)->(dbSetOrder(1))	
		If !(AliasSE1)->(dbSeek(FILIAL+PREFIXO+NUMERO+PARCELA+TIPO))	
			lContinua := .F.
		EndIf
	Else // Caso venha de query, chamada pelo Vendedor137, assumir a AliasSE1 como a tabela temporária da query que já está posicionada para não precisar dar seek na SE1 ou __SE1
		AliasSE1 := cAliasQry
	EndIf

	If lContinua
		cVends := ""
		for nX := 1 to len(__aCposCos)
			cVends += (AliasSE1)->&(__aCposCos[nX][1])
		next nX
		If !Empty(cVends)
			If (AliasSE1)->E1_SALDO >= 0 
				aVends := {}
				aComis := {}
				aBase  := {}								
				For nX := 1 to nVends					
					aAdd(aVends,(AliasSE1)->&(__aCposCos[nX][1]))					
					aAdd(aComis,(AliasSE1)->&(__aCposCos[nX][2]))				     					
					aAdd(aBase,(AliasSE1)->&(__aCposCos[nX][3]))				    
				Next				
				aAdd(aVendedor[1],aVends) 
				aAdd(aVendedor[2],aComis) 
				aAdd(aVendedor[3],aBase) 
				aAdd(aVendedor[4],(AliasSE1)->E1_FILIAL+(AliasSE1)->E1_PREFIXO+(AliasSE1)->E1_NUM+(AliasSE1)->E1_PARCELA+(AliasSE1)->E1_TIPO)
			Endif
			Return 
		Endif

		If "NOTFAT" $ (AliasSE1)->E1_FATURA .or. !Empty((AliasSE1)->E1_NUMLIQ)	 				
			lContinua := .T.				
		Else			    
			Return 			
		Endif      

		// Volta o AliasSE1 para __SE1 caso chamado pelo Vendedor127 e passada query, para seguir com a busca recursiva posicionado na __SE1
		If !Empty(cAliasQry)
			AliasSE1 := cAliasBkp
			(AliasSE1)->(dbSetOrder(1))	
			If !(AliasSE1)->(MsSeek(FILIAL+PREFIXO+NUMERO+PARCELA+TIPO))	
				lContinua := .F.
			EndIf
		EndIf

		If lContinua

			If "NOTFAT" $ (AliasSE1)->E1_FATURA	
				cCampoE1 := "E1_FATURA"
			ElseIf !Empty((AliasSE1)->E1_NUMLIQ)
				cCampoE1 := "E1_NUMLIQ"
			Endif

    		If __oTitPr == Nil
				cQuery := "SELECT E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, ? " //##1
				cQuery += "FROM   " + RetSqlName("FK1") + " FK1 "
				cQuery += 	"INNER JOIN " + RetSqlName("FK7") + " FK7 "
				cQuery += 			"ON FK7.FK7_FILIAL = FK1.FK1_FILIAL "
				cQuery += 				"AND FK7.FK7_IDDOC = FK1.FK1_IDDOC "
				cQuery += 				"AND FK7.FK7_ALIAS = 'SE1' "
				cQuery += 				"AND FK7.D_E_L_E_T_ = ? " //##2
				cQuery += 	"INNER JOIN " + RetSqlName("SE1") + " SE1 "
				cQuery +=				" ON FK7.FK7_FILTIT = SE1.E1_FILIAL " 
				cQuery += 					" AND FK7.FK7_PREFIX = SE1.E1_PREFIXO "
				cQuery += 					" AND FK7.FK7_NUM = SE1.E1_NUM 
				cQuery += 					" AND FK7.FK7_PARCEL = SE1.E1_PARCELA "
				cQuery += 					" AND FK7.FK7_TIPO = SE1.E1_TIPO "
				cQuery += 					" AND ( ? ) " //##3
				cQuery += 					" AND SE1.D_E_L_E_T_ = ? " //##4
				cQuery += "WHERE  FK1.FK1_FILIAL = ? " //##5
				cQuery += 	"AND FK1.FK1_DOC = ? " //##6
				cQuery += 	"AND FK1.D_E_L_E_T_ = ? " //##7

				cQuery += "UNION "
				
				cQuery += "SELECT E1ORI.E1_FILIAL, E1ORI.E1_PREFIXO, E1ORI.E1_NUM, "
				cQuery += " E1ORI.E1_PARCELA, E1ORI.E1_TIPO, ? " //##8
				cQuery += " FROM   " + RetSqlName("FK1") + " FK1 "
				cQuery += 	"INNER JOIN " + RetSqlName("FK7") + " FK7 "
				cQuery += 			"ON FK7.FK7_FILIAL = FK1.FK1_FILIAL "
				cQuery += 				"AND FK7.FK7_IDDOC = FK1.FK1_IDDOC "
				cQuery += 				"AND FK7.FK7_ALIAS = 'SE1' "
				cQuery += 				"AND FK7.D_E_L_E_T_ = ? " //##9
				cQuery += 	"INNER JOIN " + RetSqlName("SE1") + " SE1 "
				cQuery +=			" ON FK7.FK7_FILTIT = SE1.E1_FILIAL " 
				cQuery += 				" AND FK7.FK7_PREFIX = SE1.E1_PREFIXO "
				cQuery += 				" AND FK7.FK7_NUM = SE1.E1_NUM 
				cQuery += 				" AND FK7.FK7_PARCEL = SE1.E1_PARCELA "
				cQuery += 				" AND FK7.FK7_TIPO = SE1.E1_TIPO "
				cQuery += 				" AND SE1.E1_NUMLIQ <> ? "  //Titulo reliquidado //##10
				cQuery += 				" AND SE1.E1_TIPOLIQ <> ? " //Titulo reliquidado //##11
				cQuery += 				" AND SE1.D_E_L_E_T_ = ? " //##12
				cQuery += 	"INNER JOIN " + RetSqlName("FK1") + " FK1LIQ "
				cQuery += 			"ON FK1LIQ.FK1_FILIAL = SE1.E1_FILIAL "
				cQuery += 				"AND FK1LIQ.FK1_DOC = SE1.E1_NUMLIQ "
				cQuery += 				"AND FK1LIQ.D_E_L_E_T_ = ? " //##13
				cQuery += 	"INNER JOIN " + RetSqlName("FK7") + " FK7LIQ "
				cQuery += 			"ON FK7LIQ.FK7_FILIAL = FK1LIQ.FK1_FILIAL "
				cQuery += 				"AND FK7LIQ.FK7_IDDOC = FK1LIQ.FK1_IDDOC "
				cQuery += 				"AND FK7LIQ.D_E_L_E_T_ = ? " //##14
				cQuery += 	"INNER JOIN " + RetSqlName("SE1") + " E1ORI "
				cQuery +=			" ON FK7LIQ.FK7_FILTIT = E1ORI.E1_FILIAL " 
				cQuery += 				" AND FK7LIQ.FK7_PREFIX = E1ORI.E1_PREFIXO "
				cQuery += 				" AND FK7LIQ.FK7_NUM = E1ORI.E1_NUM 
				cQuery += 				" AND FK7LIQ.FK7_PARCEL = E1ORI.E1_PARCELA "
				cQuery += 				" AND FK7LIQ.FK7_TIPO = E1ORI.E1_TIPO "
				cQuery += 				"AND ( ? ) " //##15
				cQuery += 				"AND E1ORI.D_E_L_E_T_ = ? " //##16
				cQuery += "WHERE  FK1.FK1_FILIAL = ? " //##17
				cQuery += 	"AND FK1.FK1_DOC = ? " //##18
				cQuery += 	"AND FK1.D_E_L_E_T_ = ? " //##19
			
				cQuery := ChangeQuery(cQuery)

				__oTitPr := IIf(__lCachedQry, FwExecStatement():New(cQuery), FWPreparedStatement():New(cQuery))
			EndIf

			nIndex := 0

			__oTitPr:setUnsafe(++nIndex,fa440CpoCh(,1))			 	//##01
			__oTitPr:SetString(++nIndex,Space(1))				  	//##02
			__oTitPr:setUnsafe(++nIndex,fa440CpoCh("SE1", 2))	  	//##03
			__oTitPr:SetString(++nIndex,Space(1))				  	//##04
			__oTitPr:SetString(++nIndex,xFilial("FK1"))				//##05
			__oTitPr:SetString(++nIndex,(AliasSE1)->&(cCampoE1))	//##06
			__oTitPr:SetString(++nIndex,Space(1))					//##07
			__oTitPr:setUnsafe(++nIndex,fa440CpoCh("E1ORI",1))		//##08
			__oTitPr:SetString(++nIndex,Space(1))					//##09
			__oTitPr:SetString(++nIndex,Space(F460TamLiq()))		//##10
			__oTitPr:SetString(++nIndex,Space(__nTpLiq))			//##11
			__oTitPr:SetString(++nIndex,Space(1))					//##12
			__oTitPr:SetString(++nIndex,Space(1))					//##13
			__oTitPr:SetString(++nIndex,Space(1))					//##14
			__oTitPr:setUnsafe(++nIndex,fa440CpoCh("E1ORI",2))		//##15
			__oTitPr:SetString(++nIndex,Space(1))					//##16
			__oTitPr:SetString(++nIndex,xFilial("FK1"))				//##17
			__oTitPr:SetString(++nIndex,(AliasSE1)->&(cCampoE1))	//##18
			__oTitPr:SetString(++nIndex,Space(1))					//##19

			cQuery := __oTitPr:GetFixQuery()
			cAliasLiq := MpSysOpenQuery(cQuery)

			Do While (cAliasLiq)->(!Eof())			
				aVends := {}
				aComis := {}
				aBase  := {}
				For nX := 1 to nVends					
					aAdd(aVends,(cAliasLiq)->&(__aCposCos[nX][1]))					
					aAdd(aComis,(cAliasLiq)->&(__aCposCos[nX][2]))				     					
					aAdd(aBase,(cAliasLiq)->&(__aCposCos[nX][3]))				    
				Next						
				aAdd(aVendedor[1],aVends) 
				aAdd(aVendedor[2],aComis) 
				aAdd(aVendedor[3],aBase) 
				aAdd(aVendedor[4],(cAliasLiq)->E1_FILIAL+(cAliasLiq)->E1_PREFIXO+(cAliasLiq)->E1_NUM+(cAliasLiq)->E1_PARCELA+(cAliasLiq)->E1_TIPO)
				(cAliasLiq)->(dbSkip())
			Enddo

			(cAliasLiq)->(dbCloseArea())	

		EndIf		
	Endif	 

Return 
   

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ Vendedor137 ³ Autor ³ Marcelo Celi Marques³Data ³ 18/03/09 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Complemento a função TitPrinc para retorno da array de     ³±±
±±³          ³ vendedores com dados de comissão de titulos principais     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Finr137.prx                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Vendedor137(cAliasSe1,nIndexSE5,cFilSe1)
	Local aAreaSe1 := GetArea()
	Local aVendedor	:= {{},{},{},{}}
	U_TitPrinc(cFilSe1,(cAliasSe1)->E1_PREFIXO,(cAliasSe1)->E1_NUM,(cAliasSe1)->E1_PARCELA,(cAliasSe1)->E1_TIPO,"__SE1",@aVendedor,nIndexSE5,cAliasSe1)
	RestArea(aAreaSe1)
Return aVendedor


//-------------------------------------------------------------------------------------------
/*/{Protheus.doc} VlTitDtBas

Funções para calcular o saldo de acordo com o MV_PAR15

@author richard.lopes
@version 12
@since   15/04/2020

/*/
//-------------------------------------------------------------------------------------------
Static Function VlTitDtBas(cAlias)
	Local nSaldo := 0
    LOCAL aAreaSE1 := {}

	If mv_par15 == 2
		nSaldo := xMoeda(((cAlias)->E1_SALDO+(cAlias)->E1_SDACRES-(cAlias)->E1_SDDECRE),(cAlias)->E1_MOEDA,MV_PAR13,,,Iif(MV_PAR21==2,Iif(!Empty((cAlias)->E1_TXMOEDA),(cAlias)->E1_TXMOEDA,RecMoeda((cAlias)->E1_EMISSAO,(cAlias)->E1_MOEDA)),0))
	ELSE
        aAreaSE1 := SE1->(GetArea())
		SE1->(MsSeek( (cAlias)->E1_FILIAL + (cAlias)->E1_PREFIXO + (cAlias)->E1_NUM + (cAlias)->E1_PARCELA + (cAlias)->E1_TIPO ))
		nSaldo := SaldoTit((cAlias)->E1_PREFIXO,(cAlias)->E1_NUM,(cAlias)->E1_PARCELA,(cAlias)->E1_TIPO,(cAlias)->E1_NATUREZ,"R",(cAlias)->E1_CLIENTE,mv_par13,mv_par16,,(cAlias)->E1_LOJA,,Iif(MV_PAR21==2,Iif(!Empty((cAlias)->E1_TXMOEDA),(cAlias)->E1_TXMOEDA,RecMoeda((cAlias)->E1_EMISSAO,(cAlias)->E1_MOEDA)),0))
        RestArea(aAreaSE1)
	Endif
Return nSaldo

/*/{Protheus.doc} FR137Liq
    Retorna um Array contendo o Recno da SE1.

    @author Alberto Teixeira
    @since 14/08/2020
    @param aTitPai, Array (Chave do título pai envolvido na liquidação)
    @return aRecSE1 = Retorna o RECNO DA se1
    @type static function
/*/
Static Function FR137Liq(aTitPai As Array, aDtParam As Array ) As Array

    Local aArea As Array
    Local aAreaSE1 As Array
    Local aRecSE1 As Array
	Local cAliasQry As Character
	Local cQuery As Character

    Default aTitPai := {}
	Default aDtParam := {}

    aArea := GetArea()
    aAreaSE1 := SE1->(GetArea())
    aRecSE1 := {}
	cAliasQry := ""
	cQuery := ""

	If __oF137Lq == NIL
		cQuery := " SELECT SE1.R_E_C_N_O_ RECNOSE1 FROM "
		cQuery += RetSqlName("FI7") + " FI7," + RetSqlName("SE1") + " SE1 "
		cQuery += " WHERE "
		cQuery += " FI7.FI7_FILIAL = ? AND "
		cQuery += " FI7.FI7_PRFORI = ? AND "
		cQuery += " FI7.FI7_NUMORI = ? AND "
		cQuery += " FI7.FI7_PARORI = ? AND "
		cQuery += " FI7.FI7_TIPORI = ? AND "
		cQuery += " FI7.FI7_CLIORI = ? AND "
		cQuery += " FI7.FI7_LOJORI = ? AND "
		cQuery += " SE1.E1_FILIAL = FI7.FI7_FILDES AND "
		cQuery += " SE1.E1_PREFIXO = FI7.FI7_PRFDES AND "
		cQuery += " SE1.E1_NUM = FI7.FI7_NUMDES AND "
		cQuery += " SE1.E1_PARCELA = FI7.FI7_PARDES AND "
		cQuery += " SE1.E1_CLIENTE = FI7.FI7_CLIDES AND "
		cQuery += " SE1.E1_LOJA = FI7.FI7_LOJDES AND "
		cQuery += " SE1.E1_EMISSAO >= ? AND SE1.E1_EMISSAO <= ? AND "
		cQuery += " SE1.E1_VENCTO >= ? AND SE1.E1_VENCTO <= ? AND "
		cQuery += " SE1.E1_STATUS = ? AND "
		cQuery += " SE1.E1_SALDO > ? AND " 
		cQuery += " FI7.D_E_L_E_T_ = ? AND "
		cQuery += " SE1.D_E_L_E_T_ = ? "
		cQuery := ChangeQuery(cQuery)
		__oF137Lq := IIf(__lCachedQry, FwExecStatement():New(cQuery), FWPreparedStatement():New(cQuery))
	Endif

	__oF137Lq:SetString(1,aTitPai[1] )
	__oF137Lq:SetString(2,aTitPai[2] )
	__oF137Lq:SetString(3,aTitPai[3] )
	__oF137Lq:SetString(4,aTitPai[4] )
	__oF137Lq:SetString(5,aTitPai[5] )
	__oF137Lq:SetString(6,aTitPai[6] )
	__oF137Lq:SetString(7,aTitPai[7] )
	__oF137Lq:SetString(8, aDtParam[1])
	__oF137Lq:SetString(9, aDtParam[2])
	__oF137Lq:SetString(10, aDtParam[3])
	__oF137Lq:SetString(11, aDtParam[4])
	__oF137Lq:SetString(12, "A" )
	__oF137Lq:SetNumeric(13, "0" )
	__oF137Lq:SetString(14, Space(1))
	__oF137Lq:SetString(15, Space(1))

	cQuery := __oF137Lq:GetFixQuery()

	cAliasQry := MpSysOpenQuery( cQuery )

    While !( cAliasQRY )->( Eof())
        Aadd(aRecSE1, ( cAliasQRY )->(RECNOSE1))
        ( cAliasQRY )->(Dbskip())
    EndDo
    
    (cAliasQRY)->(dbCloseArea())

    RestArea(aAreaSE1)
    RestArea(aArea)

Return aRecSE1

/*/{Protheus.doc} TabLiqTemp
    Popula tabela temporaria com titulos gerados por liquidação sem vendedores, cujo pai em primeiro nivel seja original sem liquidação anterior 
	e que também não possui vendedores. 
	Para melhorar a performance, não avaliar esses títulos no laço

    @author rafael.rondon
    @since 25/02/2021
    @param aStruLiq	, Array com a estrutura dos campos da temporaria
	@param cFilSe1	, Caractere Filial corrente
    @return 
    @type static function
/*/
Static Function TabLiqTemp( aStruLiq As Character, cFilSe1 As Character , cDataFim As Character)

Local cInsert As Character
Local cTempLiq As Character

If _oTmpLiq <> Nil	
	_oTmpLiq:Delete()
	_oTmpLiq := Nil	
EndIf

cTempLiq := GetNextAlias()
_oTmpLiq := FwTemporaryTable():New( cTempLiq ) 

_oTmpLiq:SetFields( aStruLiq )

_oTmpLiq:AddIndex("1", {"FI7_FILDES","FI7_PRFDES","FI7_NUMDES","FI7_PARDES","FI7_TIPDES","FI7_CLIDES","FI7_LOJDES"})

_oTmpLiq:Create()

cInsert := " INSERT INTO " + _oTmpLiq:GetRealName()  + "  (FI7_FILDES , FI7_PRFDES , FI7_NUMDES , FI7_PARDES , FI7_TIPDES , FI7_CLIDES , FI7_LOJDES)  "
cInsert += " SELECT FI7_FILDES , FI7_PRFDES , FI7_NUMDES , FI7_PARDES , FI7_TIPDES , FI7_CLIDES , FI7_LOJDES
cInsert += " FROM " + RetSqlName("SE1") + " SE1DES "
cInsert += " INNER JOIN " + RetSqlName("FI7") + " FI7 "
cInsert += " 	ON SE1DES.E1_FILIAL = FI7_FILDES "
cInsert += " 	AND SE1DES.E1_PREFIXO = FI7_PRFDES "
cInsert += " 	AND SE1DES.E1_NUM = FI7_NUMDES "
cInsert += " 	AND SE1DES.E1_PARCELA = FI7_PARDES "
cInsert += " 	AND SE1DES.E1_TIPO = FI7_TIPDES "
cInsert += " 	AND SE1DES.E1_CLIENTE = FI7_CLIDES "
cInsert += " 	AND SE1DES.E1_LOJA = FI7_LOJDES "
cInsert += " 	AND FI7.D_E_L_E_T_ = ' ' "
cInsert += " INNER JOIN " + RetSqlName("SE1") + " SE1ORI "
cInsert += " 	ON SE1ORI.E1_FILIAL = FI7_FILIAL "
cInsert += " 	AND SE1ORI.E1_PREFIXO = FI7_PRFORI "
cInsert += " 	AND SE1ORI.E1_NUM = FI7_NUMORI "
cInsert += " 	AND SE1ORI.E1_PARCELA = FI7_PARORI "
cInsert += " 	AND SE1ORI.E1_TIPO = FI7_TIPORI "
cInsert += " 	AND SE1ORI.E1_CLIENTE = FI7_CLIORI "
cInsert += " 	AND SE1ORI.E1_LOJA = FI7_LOJORI "
cInsert += " 	AND SE1ORI.E1_NUMLIQ = ' ' " // Pai sem liquidação anterior
cInsert += " 	AND SE1ORI.E1_VEND1 = ' ' " // Pai sem vendedores
cInsert += " 	AND SE1ORI.E1_VEND2 = ' ' "
cInsert += " 	AND SE1ORI.E1_VEND3 = ' ' "
cInsert += " 	AND SE1ORI.E1_VEND4 = ' ' "
cInsert += " 	AND SE1ORI.E1_VEND5 = ' ' "
cInsert += " 	AND SE1ORI.D_E_L_E_T_ = ' ' "
cInsert += " WHERE SE1DES.E1_FILIAL = '" + cFilSe1 + "' "
cInsert += "	AND SE1DES.E1_CLIENTE >= '" + MV_PAR01 + "' "
cInsert += "	AND SE1DES.E1_CLIENTE <= '" + MV_PAR03 + "' "
cInsert += "	AND SE1DES.E1_LOJA >= '" + MV_PAR02 + "' "
cInsert += "	AND SE1DES.E1_LOJA <= '" + MV_PAR04 + "' "
cInsert += "	AND SE1DES.E1_EMISSAO >= '" + DTOS(MV_PAR05) + "' "
cInsert += "	AND SE1DES.E1_EMISSAO <= '" + cDataFim + "' "
cInsert += "	AND SE1DES.E1_VENCTO >= '" + DTOS(MV_PAR07) + "' "
cInsert += "	AND SE1DES.E1_VENCTO <= '" + DTOS(MV_PAR08) + "' "
If mv_par15 == 2
	cInsert += " AND SE1DES.E1_SALDO > 0 "
EndIf
cInsert += "	AND SE1DES.E1_NUMLIQ <> ' ' " // Filho Vindo de Liquidação
cInsert += " 	AND SE1DES.E1_VEND1 = ' ' "  // Filho sem vendedor
cInsert += " 	AND SE1DES.E1_VEND2 = ' ' "
cInsert += " 	AND SE1DES.E1_VEND3 = ' ' "
cInsert += " 	AND SE1DES.E1_VEND4 = ' ' "
cInsert += " 	AND SE1DES.E1_VEND5 = ' ' "
cInsert += " 	AND SE1DES.D_E_L_E_T_ = ' ' "

If TcSqlExec( cInsert ) < 0
	If ExistFunc("FinxMsgE")
		FinxMsgE(TCSQLError())            
	Else
		Help( " ", 1, "F137TMP", , STR0030 + CRLF +  CRLF + TCSQLError() , 1, 0 ) //"Não foi possivel montar a tabela temporaria, favor verificar o seu ambiente Protheus."        
	EndIf       		
Endif

Return
