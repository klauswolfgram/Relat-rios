/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "MATR815.CH"
#Include "Protheus.CH"
#Define OP       1
#Define RECURSO  2
#Define DATA     3                
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MATR815   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 14/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao da Carga Maquina                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           
*/
User Function MATR815()
Local   oReport
Local   cDirPcp             
Local	cNameCarga	:= ""        
Local	cEmp690 	:= Alltrim(STR(a690FilNum(FwCodFil())))
Local   lApsInUse   := SuperGetMV("MV_APS",.F.,"") == "TOTVS"
Private cArqTrab  
Private cQryCarga
Private cAliasC2
Private cTipoTemp :=GetMV("MV_TPHR")

/*If !lApsInUse
	cNameCarga := "CARGA"+cEmp690
	
	If GetMV("MV_PROCPCP",.T.)
		cDirPcp := Alltrim(GetMV("MV_PROCPCP"))
	Else
		cDirPcp := Alltrim(GetMV("MV_DIRPCP"))
	EndIf
	
	If !Empty(cDirPcp)
		cDirPcp += IIf( Right(cDirPcp,1) # "\" , "\" , "" )
	EndIf	
	cArqTrab := cDirPCP + cNameCarga + "TRB"
	
	If ! File(cArqTrab + GetDBExtension()) // Preciso abrir este arquivo para uso do setup com formula
		Help(" ",1, "A690NAOCA2")
		Return
	Endif
EndIf*/

//-- Verifica se o SH8 esta locado para atualizacao por outro processo                
If !IsLockSH8()

	If SH8->(LastRec()) = 0
		Help(" ",1, "A690NAOCA1")
		dbSelectArea("SH8")
		dbCloseArea()
		Return
	Endif
	
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:= ReportDef()
		If !oReport:PrintDialog()
	   		dbSelectArea("SH8")
			Set Filter to
			dbCloseArea()
			Return Nil
		EndIf
	Else
		U_MATR815R3()
	EndIf
     
EndIf	
Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³14/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR815                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection
Local aOrdem     := {STR0005,STR0006,STR0007}	//"Por OP"###"Por Recurso"###"Por Data Inicio"
Local aDiaSemana := {STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016}	//"DOMINGO"###"SEGUNDA"###"TERCA"###"QUARTA"###"QUINTA"###"SEXTA"###"SABADO"

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
oReport:= TReport():New("MATR815",OemToAnsi(STR0001),"MTR815", {|oReport| ReportPrint(oReport)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+OemToAnsi(STR0004)) //"Este programa ira imprimir a Rela‡„o da Carga M quina. O valor referente ao tempo de duracao est  convertido conforme o parametro MV_TPHR, (C)entesimal ou (N)ormal."
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas - MTR815                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // De                                    ³
//³ mv_par02            // Ate                                   ³
//³ mv_par03            // Da data                               ³
//³ mv_par04            // Ate a data                            ³
//³ mv_par05            // Impr. OP's Firmes, Previstas ou Ambas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(oReport:uParam,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da secao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a secao.                   ³
//³ExpA4 : Array com as Ordens do relatorio                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1 (oSection)                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection := TRSection():New(oReport,STR0025,{"SH8","SC2","SB1","SH1","SH4","SG2"},aOrdem) //"Relacao da Carga Maquina"
oSection:SetHeaderPage()

TRCell():New(oSection,'H8_OP'	   	,'SH8','O.P.'/*Titulo*/,/*Picture*/,TamSx3("H8_OP")[1]/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'C2_PRODUTO' 	,'SC2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'B1_DESC'   	,'SB1',/*Titulo*/,/*Picture*/, 15        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_QUANT'  	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H1_CODIGO'  	,'SH1',''/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H1_DESCRI'	,'SH1','Recurso'/*Titulo*/,/*Picture*/, 15        ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H4_CODIGO'	,'SH4',''/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H4_DESCRI'	,'SH4', Substr(STR0021,6) ,/*Picture*/,9,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'G2_OPERAC'	,'SG2',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'G2_DESCRI'	,'SG2',''/*Titulo*/,/*Picture*/,9,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'G2_TPOPER'	,'SG2', STR0022 ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_DTINI'	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DiaSemaINI'	,'SH8',''/*Titulo*/,/*Picture*/, 7         ,/*lPixel*/, {|| aDiaSemana[Dow((cQryCarga)->H8_DTINI)] })
TRCell():New(oSection,'H8_HRINI'	,'SH8','Hr Inicial'/*Titulo*/,/*Picture*/, 9/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_DTFIM'	,'SH8',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DiaSemaFIM' 	,'SH8',''/*Titulo*/,/*Picture*/, 7         ,/*lPixel*/, {|| aDiaSemana[Dow((cQryCarga)->H8_DTFIM)] })
TRCell():New(oSection,'H8_HRFIM'	,'SH8','Hr Final'/*Titulo*/,/*Picture*/, 9/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'H8_BITUSO'	,'SH8', STR0023  ,If(cTipoTemp=='C','@E 99999.99',''), 9/*Tamanho*/,/*lPixel*/, {|| ConvTime((cQryCarga)->H8_BITUSO) })
TRCell():New(oSection,'SETUP' 		,'SG2', STR0024  ,If(cTipoTemp=='C',PesqPictQt('G2_TEMPAD',7),''), If(cTipoTemp=='C',7,9) ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'C2_TPOP'		,'SC2','Tp OP'/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasC2)->C2_TPOP })

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³14/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³MATR815                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local  oSection  := oReport:Section(1)
Local  nOrdem    := oSection:GetOrder()
Local  cOrderBy
Local  cWhere01
Local lApsInUse  := SuperGetMV("MV_APS",.F.,"") == "TOTVS"
local aTRB := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definindo o titulo do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF nOrdem == 1		
	oReport:SetTitle(STR0001+"    "+"("+STR0005+")") //"Relacao da Carga Maquina "####"Por OP"
ElseIF nOrdem == 2
	oReport:SetTitle(STR0001+"    "+"("+STR0006+")") //"Relacao da Carga Maquina "####"Por Recurso"
ElseIF nOrdem == 3
	oReport:SetTitle(STR0001+"    "+"("+STR0007+")") //"Relacao da Carga Maquina "####"Por Data Inicio"
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Condicao Where para filtrar OP's                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cWhere01 := "%"
If	Upper(TcGetDb()) $ 'ORACLE,DB2,POSTGRES,INFORMIX'
	cWhere01  += "SC2.C2_ITEM = SUBSTR(SH8.H8_OP,7,2) AND "
	cWhere01  += "SC2.C2_SEQUEN = SUBSTR(SH8.H8_OP,9,3) AND "
	cWhere01  += "SC2.C2_ITEMGRD = SUBSTR(SH8.H8_OP,12,2)"
Else
	cWhere01  += "SC2.C2_ITEM = SUBSTRING(SH8.H8_OP,7,2) AND "
	cWhere01  += "SC2.C2_SEQUEN = SUBSTRING(SH8.H8_OP,9,3) AND "
	cWhere01  += "SC2.C2_ITEMGRD = SUBSTRING(SH8.H8_OP,12,2)"
EndIf
cWhere01 += "%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatorio da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oSection:BeginQuery()	

cQryCarga := GetNextAlias()
cAliasC2  := cQryCarga	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Order by de acordo com a ordem selecionada.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cOrderBy := "%"
If nOrdem == 1
	cOrderBy += " SH8.H8_FILIAL, SH8.H8_OP, SH8.H8_OPER, SH8.H8_DESDOBR " // Por OP
ElseIf nOrdem == 2
	cOrderBy += " SH8.H8_FILIAL, SH8.H8_RECURSO, SH8.H8_BITINI " // Por Recurso
ElseIf nOrdem == 3
	//cOrderBy += " SH8.H8_FILIAL, SH8.H8_DTINI, SH8.H8_OPER, SH8.H8_HRINI, SH8.H8_DTFIM, SH8.H8_HRFIM, SH8.H8_RECURSO, SH8.H8_OP " // Por Data Inicio
	cOrderBy += " SH8.H8_FILIAL, SH8.H8_DTINI, SH8.H8_HRINI, SH8.H8_OP, SH8.H8_OPER, SH8.H8_RECURSO" // Por Data Inicio
EndIf
cOrderBy += "%"

BeginSql Alias cQryCarga

SELECT SH8.H8_FILIAL, SH8.H8_OP, SH8.H8_OPER, SH8.H8_DESDOBR, SH8.H8_QUANT, SH8.H8_DTINI, SH8.H8_HRINI, SH8.H8_SETUP,
	SH8.H8_DTFIM,SH8.H8_HRFIM, SH8.H8_BITUSO, SH8.H8_RECURSO, SH8.H8_BITINI, SH8.H8_ROTEIRO, SH8.H8_FERRAM,
	SC2.C2_FILIAL, SC2.C2_NUM, SC2.C2_ITEM, SC2.C2_SEQUEN, SC2.C2_ITEMGRD, SC2.C2_PRODUTO, SC2.C2_TPOP, SC2.C2_ROTEIRO,
	SB1.B1_FILIAL, SB1.B1_COD, SB1.B1_DESC, SB1.B1_OPERPAD,
	SH1.H1_FILIAL, SH1.H1_CODIGO, SH1.H1_DESCRI,
	SH4.H4_FILIAL, SH4.H4_CODIGO, SH4.H4_DESCRI,
	SG2.G2_FILIAL, SG2.G2_PRODUTO, SG2.G2_CODIGO, SG2.G2_OPERAC, SG2.G2_DESCRI, SG2.G2_TPOPER, SG2.G2_TEMPAD,
	SG2.G2_FORMSTP, SG2.G2_SETUP

FROM %table:SH8% SH8

LEFT JOIN %table:SC2% SC2 ON
	SC2.C2_FILIAL = %xFilial:SC2% AND SC2.C2_NUM = SUBSTRING(SH8.H8_OP,1,6) AND %Exp:cWhere01% AND SC2.%NotDel%

LEFT JOIN %table:SB1% SB1 ON
	SB1.B1_FILIAL = %xFilial:SB1% AND SB1.B1_COD = SC2.C2_PRODUTO AND SB1.%NotDel%
	
LEFT JOIN %table:SH1% SH1 ON
	SH1.H1_FILIAL = %xFilial:SH1% AND SH1.H1_CODIGO = SH8.H8_RECURSO AND SH1.%NotDel%

LEFT JOIN %table:SH4% SH4 ON
	SH4.H4_FILIAL = %xFilial:SH4% AND SH4.H4_CODIGO = SH8.H8_FERRAM AND SH4.%NotDel%
	
LEFT JOIN %table:SG2% SG2 ON
	SG2.G2_FILIAL = %xFilial:SG2% AND SG2.G2_PRODUTO = SC2.C2_PRODUTO AND 
	SG2.G2_CODIGO = SH8.H8_ROTEIRO AND SG2.G2_OPERAC = SH8.H8_OPER AND SG2.%NotDel%

WHERE SH8.H8_FILIAL = %xFilial:SH8% AND
	SH8.H8_OP >= %Exp:mv_par01% AND
	SH8.H8_OP <= %Exp:mv_par02% AND
	SH8.H8_DTINI >= %Exp:mv_par03% AND
	SH8.H8_DTINI <= %Exp:mv_par04% AND
	SH8.%NotDel%
	
ORDER BY %Exp:cOrderBy%

EndSql

oSection:EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³O arquivo aberto abaixo, nao tem uso direto no relatorio.          ³
//³Mas, podera ser usado por alguma customizacao no SETUP por Formula.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lApsInUse
       aAdd(aTRB,{"OPNUM" ,"C", TamSX3("C2_NUM")[1], TamSX3("C2_NUM")[2]})
		aAdd(aTRB,{"ITEM" ,"C", TamSX3("C2_ITEM")[1], TamSX3("C2_ITEM")[2]})
		aAdd(aTRB,{"SEQUEN" ,"C", TamSX3("C2_SEQUEN")[1], TamSX3("C2_SEQUEN")[2]})
		aAdd(aTRB,{"ITEMGRD" ,"C", TamSX3("C2_ITEMGRD")[1]   , TamSX3("C2_ITEMGRD")[2]})
		aAdd(aTRB,{"RECURSO"   ,"N", TamSX3("G2_RECURSO")[1] , TamSX3("G2_RECURSO")[2]})
		aAdd(aTRB,{"OPERAC" ,"N", TamSX3("G2_OPERAC")[1]  , TamSX3("G2_OPERAC")[2]})

	 oTempTable := FWTemporaryTable():New("TRB")
	 oTempTable:SetFields( aTRB )
	 oTempTable:AddIndex("TRB", {"OPNUM","ITEM","SEQUEN","ITEMGRD","RECURSO","OPERAC"} )
	 oTempTable:Create()

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatorio                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter(SH8->(LastRec()))
oSection:Init()

dbSelectArea(cQryCarga)
While !oReport:Cancel() .And. !(cQryCarga)->(Eof())
	//-- Valida se a OP deve ser Impressa ou nao
	If !MtrAValOP(mv_par05, 'SC2', If(cQryCarga<>'SH8',cQryCarga,NIL))
		dbSelectArea(cQryCarga)
		dbSkip()
		Loop
	EndIf

	If !lApsInUse
		TRB->( dbSeek((cQryCarga)->H8_OP+(cQryCarga)->H8_RECURSO+(cQryCarga)->H8_OPER) )
	EndIf

	oSection:Cell('SETUP'):SetValue( ConvTime((cQryCarga)->H8_SETUP) )
	oSection:PrintLine()
	oReport:IncMeter()
	dbSelectArea(cQryCarga)
	dbSkip()
EndDo

oSection:Finish()
(cQryCarga)->(DbCloseArea())
dbSelectArea("SH8")
Set Filter to
dbCloseArea()
If !lApsInUse
	TRB->(DbCloseArea())
EndIf

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Descri‡…o ³ PLANO DE MELHORIA CONTINUA                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ITEM PMC  ³ Responsavel              ³ Data                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³      01  ³ Flavio Luiz Vicco        ³21/02/2006 - BOPS 00000093732    ³±±
±±³      02  ³ Flavio Luiz Vicco        ³28/12/2005                       ³±±
±±³      03  ³                          ³                                 ³±±
±±³      04  ³                          ³                                 ³±±
±±³      05  ³                          ³                                 ³±±
±±³      06  ³                          ³                                 ³±±
±±³      07  ³                          ³                                 ³±±
±±³      08  ³ Flavio Luiz Vicco        ³21/02/2006 - BOPS 00000093732    ³±±
±±³      09  ³                          ³                                 ³±±
±±³      10  ³ Flavio Luiz Vicco        ³28/12/2005                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ MATR815  ³ Autor ³ Ary Medeiros          ³ Data ³ 21.05.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao da Carga de Maquina                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_MATR815(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Rodrigo Sart.³02/06/98³XXXXXX³Acerto nas impressoes qdo lista por ordem³±±
±±³             ³        ³      ³de recurso ou ordem de data de inicio.   ³±±
±±³Rodrigo Sart.³10/08/98³15952A³Imprimir a quantidade e o setup da opera.³±±
±±³Rodrigo Sart.³03/11/98³XXXXXX³Acerto p/ Bug Ano 2000                   ³±±
±±³Fernando Joly³07/02/99³META  ³Imprimir OP's Firmes, Previstas ou Ambas.³±±
±±³Rodrigo Sart.³05/05/99³XXXXXX³Melhorar indice qto lista por data inicio³±±
±±³Patricia Sal.³18/04/00³003265³Imprimir Cod/Descr. da Ferramenta.       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MATR815R3()
Local titulo 	 := STR0001	//"Relacao da Carga Maquina "
Local cString	 :="SH8"
Local wnrel		 :="MATR815"
Local cDesc1	 :=STR0002	//" Este programa ira imprimir a Rela‡„o da Carga M quina."
Local cDesc2	 :=STR0003	//" O valor referente ao tempo de duracao est  convertido conforme"
Local cDesc3	 :=STR0004	//" o parametro MV_TPHR, (C)entesimal ou (N)ormal."
Local aOrd 		 := {STR0005,STR0006,STR0007}	//"Por OP"###"Por Recurso"###"Por Data Inicio"
Local tamanho	 :="G"
Local lApsInUse  := SuperGetMV("MV_APS",.F.,"") == "TOTVS"
local aTRB := {}

Private aReturn  := {STR0008,1,STR0009, 1, 2, 1, "",1 }	//"Zebrado"###"Administracao"
Private cPerg    :="MTR815"
Private nLastKey := 0     
                                  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR815",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01            // De                                    ³
//³ mv_par02            // Ate                                   ³
//³ mv_par03            // Da data                               ³
//³ mv_par04            // Ate a data                            ³
//³ mv_par05            // Impr. OP's Firmes, Previstas ou Ambas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If !IsLockSH8()
	
	If SH8->(LastRec()) = 0
		Help(" ",1, "A690NAOCA1")
		dbSelectArea("SH8")
		dbCloseArea()
		Return
	Endif
	
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho)
	
	If nLastKey = 27
		dbSelectArea("SH8")
		dbClearFilter()
		dbCloseArea()
		
		dbSelectArea("SG2")
		Return
	Endif
	
	titulo += "("+AllTRim(aOrd[aReturn[8]])+")"
	
	SetDefault(aReturn,cString)
	
	If nLastKey = 27
		dbSelectArea("SH8")
		dbClearFilter()
		dbCloseArea()
		dbSelectArea("SG2")
		Return
	Endif
	
	/*
	O arquivo aberto abaixo, não tem uso direto no relatório.
	Mas, poderá ser usado por alguma customização no SETUP por Formula.
	*/	
	If !lApsInUse

       aAdd(aTRB,{"OPNUM" ,"C", TamSX3("C2_NUM")[1], TamSX3("C2_NUM")[2]})
		aAdd(aTRB,{"ITEM" ,"C", TamSX3("C2_ITEM")[1], TamSX3("C2_ITEM")[2]})
		aAdd(aTRB,{"SEQUEN" ,"C", TamSX3("C2_SEQUEN")[1], TamSX3("C2_SEQUEN")[2]})
		aAdd(aTRB,{"ITEMGRD" ,"C", TamSX3("C2_ITEMGRD")[1]   , TamSX3("C2_ITEMGRD")[2]})
		aAdd(aTRB,{"RECURSO"   ,"N", TamSX3("G2_RECURSO")[1] , TamSX3("G2_RECURSO")[2]})
		aAdd(aTRB,{"OPERAC" ,"N", TamSX3("G2_OPERAC")[1]  , TamSX3("G2_OPERAC")[2]})

		oTempTable := FWTemporaryTable():New("TRB")
	    oTempTable:SetFields( aTRB )
	    oTempTable:AddIndex("TRB", {"OPNUM","ITEM","SEQUEN","ITEMGRD","RECURSO","OPERAC"} )
	    oTempTable:Create()

	EndIf

	
	
	RptStatus({|lEnd| R815Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	
	If !lApsInUse
		dbSelectArea("TRB")
		dbCloseArea()
	EndIf

EndIf
	
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ R815Imp  ³ Autor ³ Waldemiro L. Lustosa  ³ Data ³ 13.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relat¢rio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR815                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R815Imp(lEnd,wnRel,titulo,tamanho)
Local cCond,cNomArq,cIndex
Local CbCont,cabec1,cabec2,cbtxt
Local aDiaSemana := {STR0010,STR0011,STR0012,STR0013,STR0014,STR0015,STR0016}	//"DOMINGO"###"SEGUNDA"###"TERCA"###"QUARTA"###"QUINTA"###"SEXTA"###"SABADO"
Local nomeprog:="MATR815"
Local cRoteiro:=""
Local lApsInUse  := SuperGetMV("MV_APS",.F.,"") == "TOTVS"

PRIVATE cTipoTemp:=GetMV("MV_TPHR")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta os Cabecalhos                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cabec1 := STR0017	//"O.P.          PRODUTO         DESCRICAO                    QUANTIDADE  RECURSO                     FERRAMENTA            OPERACAO                TIPO INICIO           ALOCADO TERMINO          ALOCADO DURACAO   TEMPO TP"
cabec2 := STR0018	//"                                                                                                                                                 OPER DATA                HORA DATA                HORA           SETUP OP"
//                     1234567890123 123456789012345 1234567890123456789012345 12345678901234 000001 12345678901234567890 123456 12345678901234 XX 12345678901234567890 XX   02/05/1994 DOMINGO 06:00 08/05/1994 DOMINGO 10:00 0100:00 ##10:00  1
//                               1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt    := SPACE(10)
cbcont   := 0
li       := 80
m_pag    := 1


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega o nome do arquivo de indice de trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq := CriaTrab("",.F.)

dbSelectarea("SH8")
If aReturn[8] == OP .Or. aReturn[8] == RECURSO
	dbSetOrder(aReturn[8])
	cIndex:=IndexKey()
Else
	//cIndex:="H8_FILIAL+H8_DTINI+H8_OPER+H8_HRINI+H8_DTFIM+H8_HRFIM+H8_RECURSO+H8_OP"
   cIndex:="H8_FILIAL+H8_DTINI+H8_HRINI+H8_OP+H8_OPER+H8_RECURSO" // Por Data Inicio
EndIf

cCond := "H8_OP>='"+mv_par01+"'.And.H8_OP<='"+mv_par02+"'.And.H8_FILIAL=='"+xFilial("SH8")+"'"
cCond += ".And.DTOS(H8_DTINI)>='"+DTOS(mv_par03)+"'"
cCond += ".And.DTOS(H8_DTINI)<='"+DTOS(mv_par04)+"'"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria o indice de trabalho                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IndRegua("SH8",cNomArq,cIndex,,cCond,STR0019)	//"Selecionando Registros..."
dbGoTop()

SetRegua(LastRec())
While !Eof() .And. H8_FILIAL == xFilial("SH8")

	If lEnd
		@Prow()+1,001 PSay STR0020	//"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	If !lApsInUse
		dbSelectArea("TRB")
		dbSeek(SH8->H8_OP+SH8->H8_RECURSO+SH8->H8_OPER)
	EndIf

	dbSelectarea("SC2")
	dbSetOrder(1)
	dbSeek(xFilial("SC2")+SH8->H8_OP)

	//-- Valida se a OP deve ser Impressa ou n„o
	If !MtrAValOP(mv_par05, 'SC2')
		dbSelectArea('SH8')
		dbSkip()
		Loop
	EndIf

	dbSelectarea("SB1")
	dbSeek(xFilial("SB1")+SC2->C2_PRODUTO)

	If Empty(SC2->C2_ROTEIRO)
		If !Empty(SB1->B1_OPERPAD)
			cRoteiro:=SB1->B1_OPERPAD
		Else
			cRoteiro:="01"
		EndIf
	Else
		cRoteiro:=SC2->C2_ROTEIRO
	EndIf

	dbSelectArea("SH1")
	dbSeek(xFilial("SH1")+SH8->H8_RECURSO)

	dbSelectArea("SH4")
	dbSeek(xFilial("SH4")+SH8->H8_FERRAM)

	dbSelectArea("SG2")
	dbSeek(xFilial("SG2")+SC2->C2_PRODUTO+cRoteiro+SH8->H8_OPER)

	IncRegua()

	If li > 58
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
	EndIf

	@ li,000 PSay SH8->H8_OP
	@ li,014 PSay SC2->C2_PRODUTO
	@ li,030 PSay SubStr(SB1->B1_DESC,1,25)
	@ li,056 PSay SH8->H8_QUANT Picture PesqPictQt("H8_QUANT",14)

	@ li,071 PSay SH1->H1_CODIGO
	@ li,078 PSay SubStr(SH1->H1_DESCRI,1,20)

	@ LI,099 PSAY SH4->H4_CODIGO
	@ LI,106 PSAY Substr(SH4->H4_DESCRI,1,14)

	@ li,121 PSay SG2->G2_OPERAC
	@ li,124 PSay SubStr(SG2->G2_DESCRI,1,20)
	@ li,145 PSay SG2->G2_TPOPER

	@ li,150 PSay SH8->H8_DTINI
	@ li,161 PSay aDiaSemana[Dow(SH8->H8_DTINI)]
	@ li,169 PSay SH8->H8_HRINI

	@ li,175 PSay SH8->H8_DTFIM
	@ li,186 PSay aDiaSemana[Dow(SH8->H8_DTFIM)]
	@ li,194 PSay SH8->H8_HRFIM

	@ li,200 PSay ConvTime(SH8->H8_BITUSO) Picture If(cTipoTemp=='C','@E 9999.99','')
	@ li,208 PSay ConvTime(SH8->H8_SETUP) Picture If(cTipoTemp=='C','@E 9999.99','')

	@ li,216 PSay SC2->C2_TPOP
	Li++
	dbSelectArea("SH8")
	dbSkip()
EndDo

IF Li != 80
	roda(cbcont,cbtxt,"G")
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Devolve as ordens originais do arquivo                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SH8")
RetIndex("SH8")
dbClearFilter()
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq += OrdBagExt()
FErase( cNomArq )

dbSelectArea("SH8")
dbCloseArea()

dbSelectArea("SG2")

If aReturn[5] = 1
	Set Printer To
	dbCommitall()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return NIL
