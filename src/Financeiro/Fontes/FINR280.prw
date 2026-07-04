/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "FINR280.CH"
#INCLUDE "PROTHEUS.CH"

// 17/08/2009 - Compilacao para o campo filial de 4 posicoes
// 18/08/2009 - Compilacao para o campo filial de 4 posicoes

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ DATA   ³ BOPS ³Prograd.³ALTERACAO                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³27.06.98³xxxxxx³Mauricio³Numero de titulos com 12 posicoes              ³±±
±±³02.10.98³xxxxxx³Andreia ³ Acerto no lay-out p/ ativar set century  		³±±
±±³30.03.99³META  ³Julio   ³ Verificacao nos Parametros de Tamanho  do Rel.³±±
±±³30.11.99³META  ³Julio   ³ Melhoria de Performance - Implementar TcQuery ³±±
±±³30.11.99³META  ³Julio   ³ Considerar Filtro de Usuario                  ³±±
±±ÃÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³30.11.99³META  ³Julio   ³ Revis„o dos Fontes / Remover c¢digo DOS       ³±±
±±³21.08.00³oooooo³Rubens P³Implementacao multimoeda                       ³±±
±±³29.06.06³R4		³Daniel  ³ Construcao do Release 4		                  ³±±
±±ÀÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR280  ³ Autor ³ Daniel Tadashi Batori ³ Data ³ 29.06.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Juros Recebidos                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR280(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR280()

Local oReport

If TRepInUse()
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	Return U_FINR280R3() // Executa versão anterior do fonte
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportDef³ Autor ³ Daniel Batori         ³ Data ³ 29/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do layout do Relatorio									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local cPerg      := "FIN280"  // Nome do grupo de perguntas
Local oReport
Local oSection1
Local cAliasQry1 := "SE5" //GetNextAlias()
Local aTam1, aTam2, aTam3
Local nMoedaBco := 1

Pergunte(cPerg, .F.)

oReport := TReport():New("FINR280",STR0005,cPerg,;
{|oReport| ReportPrint(oReport,@cAliasQry1)},STR0001+' '+STR0002)


aTam1 := TamSX3("E1_CLIENTE")
aTam2 := TamSX3("E1_LOJA")
nTamCli :=	aTam1[1] + aTam2[1] + 1
aTam1 := TamSX3("E5_PREFIXO")
aTam2 := TamSX3("E5_NUMERO")
aTam3 := TamSX3("E5_PARCELA")
nTamTit :=	aTam1[1] + aTam2[1] + aTam3[1] + 2

oSection1 := TRSection():New(oReport,STR0010,{"SE5","SE1","SA1","SED","SA6"},)
TRCell():New(oSection1,"E5_BANCO" 	,"SE5",STR0011,,,.F.,{|| (cAliasQry1)->E5_BANCO})		//"BANCO"
TRCell():New(oSection1,"CLIENLOJA" 	,     ,STR0012,,nTamCli,.F.,/*{|| 	SE1->E1_CLIENTE+' '+SE1->E1_LOJA }*/)	//"CODIGO"
TRCell():New(oSection1,"A1_NREDUZ" 	,"SA1",STR0013,,,.F.,{|| SA1->A1_NREDUZ})	//"CLIENTE"
TRCell():New(oSection1,"E1_NUM"   	,"SE5",STR0014,,nTamTit,.F.,{|| (cAliasQry1)->E5_PREFIXO+"-"+(cAliasQry1)->E5_NUMERO+"-"+(cAliasQry1)->E5_PARCELA})		//"No.TITULO"
TRCell():New(oSection1,"E1_VENCTO"	,"SE1",STR0015,,,.F.,{|| SE1->E1_VENCTO })		//"VENCTO"
TRCell():New(oSection1,"ATRASO"   	,		,STR0016,,5,.F.,{||})	//"ATRASO"
TRCell():New(oSection1,"E5_DATA"  	,"SE5",STR0017,,,.F.,{|| (cAliasQry1)->E5_DATA })		//"PAGTO"
TRCell():New(oSection1,"E1_VLCRUZ"	, "SE1",STR0018,TM(SE1->E1_VLCRUZ,14,MsDecimais(1)),,.F.,/*{||}*/)
TRCell():New(oSection1,"E1_VALJUR"	,"SE1",STR0019,TM(SE1->E1_VLCRUZ,14,MsDecimais(1)),,.F.,{|| nMoedaBco := If(cPaisLoc#"BRA",Max(SA6->A6_MOEDA,1),1),;		//"VALOR JUROS"
																											 xMoeda((cAliasQry1)->E5_VALOR, nMoedaBco, mv_par05, (cAliasQry1)->E5_DATA, MsDecimais(mv_par05)+1) })

#IFNDEF TOP
	TRPosition():New ( oSection1, "SE1" , 1 ,{|| xfilial("SE1")+SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO) } , .T. )
	TRPosition():New ( oSection1, "SA1" , 1 ,{|| xfilial("SA1")+SE1->(E1_CLIENTE+E1_LOJA) } , .T. )
	TRPosition():New ( oSection1, "SA6" , 1 ,{|| xfilial("SA6")+SA6->(E5_BANCO+E5_AGENCIA+E5_CONTA) } , .T. )
#ELSE
	oSection1:SetLineCondition({|| mv_par06 == 1 .OR. mv_par05==Max(SA6->A6_MOEDA,1) })
#ENDIF


oReport:SetTotalText(STR0008)
TRFunction():New(oSection1:Cell("E1_VALJUR"),"TOTAL","SUM",,,,,.F.,.T.)
oReport:SetTotalInLine(.F.)
oSection1:SetTotalInLine(.F.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Daniel Batori          ³ Data ³26/06/2006³±±
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
*/
Static Function ReportPrint(oReport,cAliasQry1)
Local oSection1  := oReport:Section(1)
Local cCond1	:=	""
Local cCond2	:=	""
Local nMoedaBCO:= 1
Local aAreaAtu := {}
Local aAreaSE1 := {}
Local lOk := .F.
Local cFilterUser := ""
Local cFilSE1 := xfilial("SE1")
Local ni		:= 0
Local aStru := SE5->(DbStruct())
Local cOrder := ""
Local cQuery := ""

dbSelectArea("SE5")
dbSetOrder(1)

cOrder := SqlOrder(IndexKey())

If TcSrvType() !="AS/400"
	cQuery := "SELECT * "
	cQuery += " FROM " + RetSqlName("SE5")
	cQuery += " WHERE E5_FILIAL = '" + xFilial("SE5") + "'"
	cQuery += " AND D_E_L_E_T_ =  ' ' "
	cQuery += " AND E5_DATA between '" + DTOS(mv_par01)  + "' AND '" + DTOS(mv_par02) + "'"
	cQuery += " AND E5_RECPAG <> 'P' AND E5_SITUACA <> 'C'"
	cQuery += " AND ( E5_TIPODOC = 'JR' OR E5_TIPODOC = 'J2' ) "
	cQuery += " AND E5_DTDIGIT between '" + DTOS(mv_par03)  + "' AND '" + DTOS(mv_par04) + "'"
	cQuery += " ORDER BY " + cOrder
	cQuery := ChangeQuery(cQuery)

	dbSelectArea("SE5")
	dbCloseArea()
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .T., .T.)
	For ni := 1 to Len(aStru)
		If aStru[ni,2] != 'C'
			TCSetField('SE5', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
		Endif
	Next
	cCond1:='!Eof()'
	cCond2:='!Eof()'
Else
	oReport:SetMeter(RecCount())
	dbSeek(cFilial+DtoS(mv_par01),.T.)
	cCond1:= '!Eof() .And. E5_FILIAL == "'+cFilial+'" .And. '+;
		'Dtos(E5_DATA) <= "'+Dtos(mv_par02)+'"'

	cCond2:= 'E5_RECPAG != "P" .and. E5_SITUACA != "C" .And. '+;
			'(E5_TIPODOC == "JR" .or. E5_TIPODOC == "J2") .And. '+;
			'Dtos(E5_DTDIGIT) >= "'+dtos(mv_par03)+'" .and. '+;
			'Dtos(E5_DTDIGIT) <= "'+dtos(mv_par04)+'"'
			
	If !Empty(oSection1:GetADVPLExp("SE5"))
		cCond2 += " .And. " + oSection1:GetADVPLExp("SE5") + " .And. Dtos(E5_DATA) >= " + '"' + Dtos(mv_par01) + '" .And. Dtos(E5_DATA) <= "' + Dtos(mv_par02) + '"' 
	Else
		cFilterUser := oSection1:GetADVPLExp("SE1")	
	EndIf
Endif 
			
oSection1:Init()
While &cCond1
        // Pega moeda do banco e calcula o valor na moeda
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	nMoedaBCO	:=	1
	If cPaisLoc	# "BRA"
		SA6->(DbSetOrder(1))
		SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
		nMoedaBco := Max(SA6->A6_MOEDA,1)
	Endif

        // Desconsidera movimentos de outras moedas
	If mv_par06 == 2 .And. nMoedaBco != mv_par05
	   SE5->(dbSkip())
	   Loop
	EndIf
	
	IF &cCond2		
		aAreaAtu := GetArea()			
		dbSelectArea("SE1")
		SE1->(dbgotop())
		If !Empty(cFilterUser)
			SE1->( dbSeek(cFilSE1+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO) )
			If (&(cFilterUser)) .And. (SE1->E1_NUM == SE5->E5_NUMERO .And. SE1->E1_PREFIXO == SE5->E5_PREFIXO .And. SE1->E1_LOJA == SE5->E5_LOJA) 						
				Fr280Vlr(oSection1,(cAliasQry1)->E5_CLIFOR,(cAliasQry1)->E5_LOJA,(cAliasQry1)->E5_PREFIXO,(cAliasQry1)->E5_NUMERO,(cAliasQry1)->E5_PARCELA,(cAliasQry1)->E5_TIPO,(cAliasQry1)->E5_DATA)
				oSection1:PrintLine()
			EndIf
		Else
			SE1->( dbSeek(cFilSE1+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO) )
			If SE1->E1_NUM == SE5->E5_NUMERO .And. SE1->E1_PREFIXO == SE5->E5_PREFIXO .And. SE1->E1_LOJA == SE5->E5_LOJA						
				Fr280Vlr(oSection1,(cAliasQry1)->E5_CLIFOR,(cAliasQry1)->E5_LOJA,(cAliasQry1)->E5_PREFIXO,(cAliasQry1)->E5_NUMERO,(cAliasQry1)->E5_PARCELA,(cAliasQry1)->E5_TIPO,(cAliasQry1)->E5_DATA)
				oSection1:PrintLine()
			EndIf
		EndIf
			
		RestArea(aAreaAtu)
		aAreaAtu := {}				
	Endif		
	
	SE5->(DbSkip())
Enddo
	
oSection1:Finish()
If TcSrvType() != "AS/400"
	dbSelectArea("SE5")
	dbCloseArea()
	ChKFile("SE5")
	dbSelectArea("SE5")
	dbSetOrder(1)
Else
	dbSelectArea("SE5")
	dbClearFil()
	dbSetOrder(1)
endif
MS_FLUSH()
Return



/*
---------------------------------------------------------- RELEASE 3 ---------------------------------------------
*/




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR280R3³ Autor ³ Paulo Boschetti       ³ Data ³ 18.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Juros Recebidos                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_FINR280R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function FINR280R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL cDesc1 := OemToAnsi(STR0001)  //"Este programa ir  emitir a rela‡„o dos juros recebidos a partir"
LOCAL cDesc2 := OemToAnsi(STR0002)  //"da data da baixa."
LOCAL cDesc3 :=""
LOCAL cString:= "SE5"
LOCAL wnrel
LOCAL Tamanho:="G"

PRIVATE aReturn := { OemToAnsi(STR0003), 1,OemToAnsi(STR0004), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
PRIVATE nomeprog:="FINR280"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="FIN280"
PRIVATE titulo
PRIVATE cabec1
PRIVATE cabec2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo := OemToAnsi(STR0005)  //"Relacao dos Juros Recebidos"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("FIN280",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // Da Data De Baixa                      ³
//³ mv_par02            // Ate a Data de Baixa                   ³
//³ mv_par03            // Da data de digitacao de               ³
//³ mv_par04            // Ate a Data de digitacao               ³
//³ mv_par05            // Qual moeda                            ³
//³ mv_par06            // Outras moedas                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="FINR280"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)
If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| Fa280Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FA280Imp ³ Autor ³ Paulo Boschetti       ³ Data ³ 18.06.92 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao dos Juros Recebidos                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FA280Imp(lEnd,wnRel,cString)                               ³±±
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
Static Function FA280Imp(lEnd,wnRel,cString)
LOCAL CbCont,CbTxt
LOCAL tamanho:= "G"
LOCAL nTotJuros :=0
Local cCond1,cCond2
#IFDEF TOP
	Local aStru := SE5->(DbStruct())
	Local ni
	Local cOrder,cQuery
#ENDIF
Local cFilterUser := aReturn[7]
Local aColu	:= {}
Local aTam  := TamSX3("E1_CLIENTE")
Local nDecs := MsDecimais(mv_par05)
Local nValor, nMoedaBco := 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := IIF(aTam[1] > 6,OemToAnsi(STR0009),OemToAnsi(STR0006))  //"BANCO  CODIGO                     CLIENTE                      No.TITULO           VENCTO      ATRASO  PAGTO                VALOR     VALOR JUROS"###"BANCO  CODIGO    CLIENTE                       No.TITULO          VENCTO    ATRASO PAGTO                VALOR      VALOR JUROS"
cabec2 := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1

dbSelectArea("SE5")
dbSetOrder(1)
SetRegua(RecCount())

#IFDEF TOP

	cOrder := SqlOrder(IndexKey())

	If TcSrvType() !="AS/400"
		cQuery := "SELECT * "
		cQuery += " FROM " + RetSqlName("SE5")
		cQuery += " WHERE E5_FILIAL = '" + xFilial("SE5") + "'"
		cQuery += " AND D_E_L_E_T_ <> '*' "
		cQuery += " AND E5_DATA between '" + DTOS(mv_par01)  + "' AND '" + DTOS(mv_par02) + "'"
		cQuery += " AND E5_RECPAG <> 'P' AND E5_SITUACA <> 'C'"
		cQuery += " AND ( E5_TIPODOC = 'JR' OR E5_TIPODOC = 'J2' ) "
		cQuery += " AND E5_DTDIGIT between '" + DTOS(mv_par03)  + "' AND '" + DTOS(mv_par04) + "'"
		cQuery += " ORDER BY " + cOrder
		cQuery := ChangeQuery(cQuery)

		dbSelectArea("SE5")
		dbCloseArea()
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'SE5', .T., .T.)
		For ni := 1 to Len(aStru)
			If aStru[ni,2] != 'C'
				TCSetField('SE5', aStru[ni,1], aStru[ni,2],aStru[ni,3],aStru[ni,4])
			Endif
		Next
		cCond1:='!Eof()'
		cCond2:='!Eof()'
	Else
#ENDIF
	dbSeek(cFilial+DtoS(mv_par01),.T.)
	cCond1:= '!Eof() .And. E5_FILIAL == "'+cFilial+'" .And. '+;
		'Dtos(E5_DATA) <= "'+Dtos(mv_par02)+'"'

	cCond2:= 'E5_RECPAG != "P" .and. E5_SITUACA != "C" .And. '+;
			'(E5_TIPODOC == "JR" .or. E5_TIPODOC == "J2") .And. '+;
			'Dtos(E5_DTDIGIT) >= "'+dtos(mv_par03)+'" .and. '+;
			'Dtos(E5_DTDIGIT) <= "'+dtos(mv_par04)+'"'
#IFDEF TOP
	Endif
#ENDIF

aColu := IIF (aTam[1] > 6,;
					{000,007,034,063,083,098,103,115,131},;
					{000,007,018,047,067,082,087,099,115})

While &cCond1

	IF lEnd
		@Prow()+1,001 PSAY OemToAnsi(STR0007)  //"CANCELADO PELO OPERADOR"
		Exit
	End

	IncRegua()

	IF &cCond2

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			SE5->(dbSkip())
			Loop
		Endif

        // Pega moeda do banco e calcula o valor na moeda
		If cPaisLoc	# "BRA"
			SA6->(DbSetOrder(1))
			SA6->(DbSeek(xFilial()+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA))
			nMoedaBco := Max(SA6->A6_MOEDA,1)
		Endif

        // Desconsidera movimentos de outras moedas
		If mv_par06 = 2 .And. nMoedaBco != mv_par05
		   SE5->(dbSkip())
		   Loop
		EndIf

		nValor := xMoeda(SE5->E5_VALOR, nMoedaBco, mv_par05, SE5->E5_DATA, nDecs+1)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza o titulo                                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SE1->(dbSeek(xfilial("SE1")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Localiza o cliente                                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SA1")
		DbSetOrder(1)
		SA1->(dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA))

		dbSelectArea("SE5")

		IF li > 58
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
		End

		@li , aColu[1] PSAY E5_BANCO
		@li , aColu[2] PSAY SE1->E1_CLIENTE+" "+SE1->E1_LOJA
		@li , aColu[3] PSAY Substr(SA1->A1_NOME,1,20)
		@li , aColu[4] PSAY E5_PREFIXO+"-"+E5_NUMERO+"-"+E5_PARCELA
		@li , aColu[5] PSAY SE1->E1_VENCTO

		@li , aColu[6] PSAY (E5_DATA-SE1->E1_VENCTO) Picture "999"

		@li , aColu[7] PSAY E5_DATA
		@li , aColu[8] PSAY xMoeda(SE1->E1_VLCRUZ , SE1->E1_MOEDA, mv_par05, SE5->E5_DATA, nDecs+1)	Picture TM(SE1->E1_VLCRUZ,14,MsDecimais(1))
		@li , aColu[9] PSAY nValor	            Picture PesqPict("SE5","E5_VALOR",14,mv_par05)
		nTotJuros += nValor
		li++
	Endif

	SE5->(dbSkip())
Enddo

IF nTotJuros != 0
	li+=2
	IF li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,IIF(aReturn[4]==1,15,18))
	Endif
	@li,001 PSAY OemToAnsi(STR0008)  //"Total de Juros Recebidos no Periodo : "
	@li,aColu[9] PSAY nTotJuros Picture PesqPict("SE5","E5_VALOR",14,mv_par05)
EndIF

IF li != 80
	roda(cbcont,cbtxt,"M")
EndIF

Set Device To Screen

#IFNDEF TOP
	dbSelectArea("SE5")
	dbClearFil()
	dbSetOrder(1)
#ELSE
	if TcSrvType() != "AS/400"
		dbSelectArea("SE5")
		dbCloseArea()
		ChKFile("SE5")
		dbSelectArea("SE5")
		dbSetOrder(1)
	else
		dbSelectArea("SE5")
		dbClearFil()
		dbSetOrder(1)
	endif
#ENDIF

If aReturn[5] = 1
	Set Printer To
	dbCommitall()
	ourspool(wnrel)
End

MS_FLUSH()

Return

Static Function Fr280Vlr(oSection1,cCli,cLoja,cPref,cNum,cParc,cTipo,dDataBx)
Local aAreaSA1 := SA1->(getArea())
Local oSection := oSection1

	oSection:Cell("E1_VLCRUZ"):SetValue(xMoeda(SE1->E1_VLCRUZ, SE1->E1_MOEDA, mv_par05, dDataBx, MsDecimais(mv_par05)+1))
	oSection:Cell("CLIENLOJA"):SetValue(SE1->E1_CLIENTE+' '+SE1->E1_LOJA)
	oSection:Cell("E1_VENCTO"):SetValue(SE1->E1_VENCTO)
	oSection:Cell("ATRASO"):SetValue(dDataBx - SE1->E1_VENCTO)	//"ATRASO"

	DbSelectArea("SA1")
	DbSetOrder(1)
	If Dbseek(xFilial("SA1") + cCli+cLoja)
		oSection:Cell("A1_NREDUZ"):SetValue(SA1->A1_NREDUZ)
	EndIf

SA1->(RestArea(aAreaSA1))

Return
