/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "DLGR290.CH"
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³DLGR290   ³ Autor ³Felipe Nunes Toledo    ³ Data ³ 12/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao Servico X Tarefa X Atividade pendentes/executados.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           
*/
User Function DLGR290()
Local oReport

If SuperGetMv("MV_WMSNEW",.F.,.F.)
	Return WMSR290()
EndIf

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:= ReportDef()
	oReport:PrintDialog()
Else
	U_DLGR290R3()
EndIf

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Felipe Nunes Toledo    ³ Data ³12/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ DLGR290                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport
Local oSection
Private cAliasSDB

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
oReport:= TReport():New("DLGR290",OemToAnsi(STR0001),"DLR290", {|oReport| ReportPrint(oReport)},OemToAnsi(STR0002)+" "+OemToAnsi(STR0003)+" "+(STR0004)) //##"Servicos Pendentes / Executados - Relacao com Servicos X Tarefas X Atividades pendentes e /ou executados. Os itens serao filtrados de acordo com os parametros utilizados pelo usuario."
oReport:SetLandscape() //Define a orientacao de pagina do relatorio como paisagem.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas - DLR290                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01     // De Servico                                   ³
//³ mv_par02     // Ate Servico				                     ³
//³ mv_par03     // De Tarefa									 ³
//³ mv_par04     // Ate Tarefa                                   ³
//³ mv_par05     // Ate Recurso                                  ³
//³ mv_par06     // De Atividade                                 ³
//³ mv_par07     // Ate Atividade                                ³
//³ mv_par08     // De Documento                                 ³
//³ mv_par09     // Ate Documento                                ³
//³ mv_par10     // De Serie                                     ³
//³ mv_par11     // Imprime Itens                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(oReport:uParam,.F.)
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
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sessao 1 (oSection)                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection := TRSection():New(oReport,STR0011,{"SDB"}) //"Movimentos por endereco"
oSection:SetHeaderPage()

TRCell():New(oSection,'DB_DOC'	 	,'SDB',STR0012,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Docto"
TRCell():New(oSection,'DB_SERIE'   ,'SDB',/*Titulo*/,'!!!',/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DB_PRODUTO' ,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DB_LOCAL'  	,'SDB',STR0013,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Arm"
TRCell():New(oSection,'DB_QUANT'  	,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'cUM'   		,'SB1',STR0014,PesqPict("SB1","B1_UM"),/*Tamanho*/,/*lPixel*/,{|| If(SB5->B5_UMIND=='2',SB1->B1_SEGUM,SB1->B1_UM)}) //"UM"
TRCell():New(oSection,'DB_LOTECTL'	,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DB_NUMLOTE'	,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DB_SERVIC'	,'SDB',STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Serv"
TRCell():New(oSection,'X5_DESCRI' 	,'SX5',/*Titulo*/,PesqPict("SDB","DB_DESSER",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L4"+(cAliasSDB)->DB_SERVIC,"X5_DESCRI") })// Descricao do Servico
TRCell():New(oSection,'DB_TAREFA' 	,'SDB',STR0016,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tarefa"
TRCell():New(oSection,'X5_DESCRI' 	,'SDB',/*Titulo*/,PesqPict("SDB","DB_DESTAR",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L2"+(cAliasSDB)->DB_TAREFA,"X5_DESCRI") }) // Descricao da Tarefa
TRCell():New(oSection,'DB_ATIVID' 	,'SDB',STR0017,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Ativ"
TRCell():New(oSection,'X5_DESCRI' 	,'SDB',/*Titulo*/,PesqPict("SDB","DB_DESATI",23),15,/*lPixel*/,{|| Posicione("SX5",1,xFilial("SX5")+"L3"+(cAliasSDB)->DB_ATIVID,"X5_DESCRI") }) // Descricao da Atividade
TRCell():New(oSection,'DB_RECHUM' 	,'SDB',STR0018,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rec.Hum"
TRCell():New(oSection,'DB_RECFIS' 	,'SDB',STR0019,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Rec.Fis"
TRCell():New(oSection,'DB_ESTFIS' 	,'SDB',STR0020,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Est.Fis"
TRCell():New(oSection,'DB_LOCALIZ' 	,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection,'DB_ESTDES' 	,'SDB',STR0021,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/) //"Est.Des"
TRCell():New(oSection,'DB_ENDDES' 	,'SDB',/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint ³ Autor ³Felipe Nunes Toledo  ³ Data ³12/06/06  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatorio                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ DLGR290			                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)
Local oSection  := oReport:Section(1)
Local cWhere
Local cIdWhere
Local cOrderBy
Local cCondicao:="",cChave :="" // Utilizados na filtragem do arquivo 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatorio                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(oReport:uParam)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio da secao 1                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	oSection:BeginQuery()	
	
	cAliasSDB := GetNextAlias()
	

	cWhere := "%"
	IF mv_par11 == 1 
		cWhere += " DB_HRFIM = '"+Criavar("DB_HRFIM",.F.)+"' AND "
	ElseIF mv_par11 == 2
		cWhere += " DB_HRFIM <> '"+Criavar("DB_HRFIM",.F.)+"' AND "
	Else
		cWhere += ""	
	EndIF
	//cWhere += "%"
		
	cOrderBy := "%"
	cOrderBy += " DB_DOC,DB_SERIE,DB_PRODUTO,DB_LOCAL,DB_LOTECTL,DB_NUMLOTE,DB_SERVIC,DB_ORDTARE,DB_ORDATIV "
	cOrderBy += "%"
    
	//cWhere := "%"
	cWhere += " SDB."+SerieNfId("SDB",3,"DB_SERIE")+" >='" + mv_par09 + "' AND "
	cWhere += " SDB."+SerieNfId("SDB",3,"DB_SERIE")+" <='" + mv_par10 + "' AND "
	cWhere += "%"
	
	BeginSql Alias cAliasSDB

	SELECT  SDB.DB_DOC, 
			SDB.DB_SERIE, 
			SDB.DB_PRODUTO, 
			SDB.DB_LOCAL, 
			SDB.DB_LOTECTL, 
			SDB.DB_NUMLOTE, 
			SDB.DB_SERVIC, 
			SDB.DB_ORDTARE, 
			SDB.DB_ORDATIV,
			SDB.DB_TAREFA,
			SDB.DB_ATIVID
	
	FROM %table:SDB% SDB

	WHERE DB_FILIAL   = %xFilial:SDB%	AND 
	      DB_ATUEST   = 'N'   			AND
	      DB_ESTORNO  = ' '   			AND
  		  DB_SERVIC   >= %Exp:mv_par01%	AND 
	 	  DB_SERVIC   <= %Exp:mv_par02%	AND 
	 	  DB_TAREFA   >= %Exp:mv_par03%	AND 
	 	  DB_TAREFA   <= %Exp:mv_par04%	AND 
	 	  DB_ATIVID   >= %Exp:mv_par05%	AND 
	 	  DB_ATIVID   <= %Exp:mv_par06%	AND 
		  DB_DOC      >= %Exp:mv_par07%	AND 	
		  DB_DOC      <= %Exp:mv_par08%	AND 	
// 		  DB_SERIE    >= %Exp:mv_par09%	AND 	
// 		  DB_SERIE    <= %Exp:mv_par10%	AND
		 // %Exp:cIdWhere%
 		  %Exp:cWhere%
 		  SDB.%NotDel%

	ORDER BY %Exp:cOrderBy%
			
	EndSql

	oSection:EndQuery()
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao ADVPL                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr(oReport:uParam)

	cAliasSDB := "SDB"
	dbSelectArea(cAliasSDB)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Indice Condicional de acordo com a ordem selecionada.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cCondicao:= 'DB_FILIAL=="'+xFilial("SDB")+'".And.DB_ATUEST=="N".And.DB_ESTORNO==" ".And.DB_SERVIC>="'+mv_par01+'".And.DB_SERVIC<="'+mv_par02+'"'
	cCondicao+= '.And.DB_TAREFA>="'+mv_par03+'".And.DB_TAREFA<="'+mv_par04+'"'
	cCondicao+= '.And.DB_ATIVID>="'+mv_par05+'".And.DB_ATIVID<="'+mv_par06+'"'
	cCondicao+= '.And.DB_DOC>="'+mv_par07+'".And.DB_DOC<="'+mv_par08+'"'
	cCondicao+= '.And."'+SerieNfId("SDB",3,"DB_SERIE")+'">="'+mv_par09+'".And."'+SerieNfId("SDB",3,"DB_SERIE")+'"<="'+mv_par10+'"'
	// Nao apontados
	If mv_par11 == 1
		cCondicao+= '.And. DB_HRFIM == "'+Criavar("DB_HRFIM",.F.)+'"'
	// Apontados
	ElseIf mv_par11 == 2
		cCondicao+= '.And. DB_HRFIM <> "'+Criavar("DB_HRFIM",.F.)+'"'
	EndIf

	cChave	:= 'DB_DOC+DB_SERIE+DB_PRODUTO+DB_LOCAL+DB_LOTECTL+DB_NUMLOTE+DB_SERVIC+DB_ORDTARE+DB_ORDATIV'

	oReport:Section(1):SetFilter(cCondicao,cChave)

#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posicionamento das tabelas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection,"SB1",1,{|| xFilial("SB1")+(cAliasSDB)->DB_PRODUTO })
TRPosition():New(oSection,"SB5",1,{|| xFilial("SB5")+(cAliasSDB)->DB_PRODUTO })


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:Section(1):Print()
Return NIL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³DLGR290   ³ Autor ³Rodrigo de A Sartorio  ³ Data ³ 05.11.02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao Servico X Tarefa X Atividade pendentes/executados.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß           
*/
User Function DLGR290R3()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := OemToAnsi(STR0001) //"Servicos Pendentes / Executados" 
Local cDesc1  := OemToAnsi(STR0002) //"Relacao com Servicos X Tarefas X Atividades pendentes"
Local cDesc2  := OemToAnsi(STR0003) //"e /ou executados. Os itens serao filtrados de acordo"
Local cDesc3  := OemToAnsi(STR0004) //"com os parametros utilizados pelo usuario."
Local cArqPri := "SDB"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "DLGR290"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "DLGR290"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {}  // Ordem do Relatorio
Private cPerg   := "DLR290"  // Pergunta do Relatorio
Private aReturn := { STR0005, 1,STR0006, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)

Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cArqPri,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cArqPri)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cArqPri)
If ( nLastKey==27 )
	dbSelectArea(cArqPri)
	dbSetOrder(1)
	Set Filter to
	Return
Endif
RptStatus({|lEnd| ImpDet(@lEnd,wnRel,nomeprog,Titulo)},Titulo)
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³Rodrigo de A Sartorio  ³ Data ³05.11.2002³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpDet(lEnd,wnrel,nomeprog,Titulo)
Local li        := 100 // Contador de Linhas
Local lImp      := .F. // Indica se algo foi impresso
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local cArq      := "",cCondicao:="",cChave :="" // Utilizados na filtragem do arquivo 
Local cCabec1   := STR0007 //"DOCUMENTO    SER PRODUTO         AR QUANTIDADE    UM LOTE       SUB    SERVICO                     TAREFA                      ATIVIDADE                   REC    REC    ESTRUT END             ESTRUT  END           "
Local cCabec2   := STR0008 //"                                                                LOTE                                                                                       HUMANO FISICO ORIGEM ORIGEM          DESTINO DESTINO       "
Local cServico  := ""
Local cTarefa   := ""
Local cAtividade:= ""
Local lQuery    := .F.
Local aStruSDB  := {}
Local cAliasSDB := "SDB"
Local cUM       := ""
Local aUM       := {}
Local nPosUM    := 0
Local nTam      := TamSx3("DB_DOC")[1]
Local nIncCol   := If(nTam>=10,nTam-10,0) //Tamanho do campo - tamanho minimo

#IFDEF TOP
	Local nX
#ENDIF

//"DOCUMENTO    SER PRODUTO         AR QUANTIDADE    UM LOTE       SUB    SERVICO                     TAREFA                      ATIVIDADE                   REC    REC    ESTRUT END             ESTRUT  END           "
//"                                                                LOTE                                                                                       HUMANO FISICO ORIGEM ORIGEM          DESTINO DESTINO       "
//           1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
// 123456789012 123 123456789012345 12 1234567890123 1234567890 123456 123 12345678901234567890123 123 12345678901234567890123 123 12345678901234567890123 123456 123456 123456 123456789012345 123456  123456789012345 
If nIncCol > 0
	cCabec1 := Stuff(cCabec1,At(" ",cCabec1),0,Space(nIncCol))
	cCabec2 := Space(nIncCol)+cCabec2
EndIf

dbSelectArea(cAliasSDB)
#IFDEF TOP
	If ( TcSrvType()<>"AS/400" )
		lQuery 	  := .T.
		aStruSDB  := (cAliasSDB)->(dbStruct())
		cAliasSDB := "DLGR290"
		cCondicao := "SELECT * FROM "
		cCondicao += RetSqlName("SDB")+" SDB "
		cCondicao += "WHERE SDB.DB_FILIAL = '"+xFilial("SDB")+"' AND "
		cCondicao += "SDB.DB_ATUEST = 'N' AND SDB.DB_ESTORNO=' ' AND SDB.DB_SERVIC >= '"+mv_par01+"' AND SDB.DB_SERVIC <= '"+mv_par02+"' AND "
		cCondicao += "SDB.DB_TAREFA >='"+mv_par03+"' AND DB_TAREFA<='"+mv_par04+"' AND "
		cCondicao += "SDB.DB_ATIVID >='"+mv_par05+"' AND DB_ATIVID<='"+mv_par06+"' AND "
		cCondicao += "SDB.DB_DOC >='"+mv_par07+"' AND DB_DOC<='"+mv_par08+"' AND "
		cCondicao += "SDB."+SerieNfId("SDB",3,"DB_SERIE")+" >='"+mv_par09+"' AND '"+SerieNfId("SDB",3,"DB_SERIE")+" <='"+mv_par10+"' AND "
		// Nao apontados
		If mv_par11 == 1
			cCondicao+= "SDB.DB_HRFIM = '"+Criavar("DB_HRFIM",.F.)+"' AND "
		// Apontados
		ElseIf mv_par11 == 2
			cCondicao+= "SDB.DB_HRFIM <> '"+Criavar("DB_HRFIM",.F.)+"' AND "
		EndIf
		cCondicao += "SDB.D_E_L_E_T_ = ' ' "
		cCondicao += "ORDER BY DB_DOC,DB_SERIE,DB_PRODUTO,DB_LOCAL,DB_LOTECTL,DB_NUMLOTE,DB_SERVIC,DB_ORDTARE,DB_ORDATIV"
		cCondicao := ChangeQuery(cCondicao)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cCondicao),cAliasSDB,.T.,.T.)
		For nX := 1 To Len(aStruSDB)
			If ( aStruSDB[nX][2] <> "C" )
				TcSetField(cAliasSDB,aStruSDB[nX][1],aStruSDB[nX][2],aStruSDB[nX][3],aStruSDB[nX][4])
			EndIf
		Next nX
	EndIf	
#ENDIF

// Monta Indregua em AS400 ou BANCO NAO SQL
If !lQuery
	cArq 		:= CriaTrab("",.F.)
	cCondicao:= 'DB_FILIAL=="'+xFilial("SDB")+'".And.DB_ATUEST=="N".And.DB_ESTORNO=" ".And.DB_SERVIC>="'+mv_par01+'".And.DB_SERVIC<="'+mv_par02+'"'
	cCondicao+= '.And.DB_TAREFA>="'+mv_par03+'".And.DB_TAREFA<="'+mv_par04+'"'
	cCondicao+= '.And.DB_ATIVID>="'+mv_par05+'".And.DB_ATIVID<="'+mv_par06+'"'
	cCondicao+= '.And.DB_DOC>="'+mv_par07+'".And.DB_DOC<="'+mv_par08+'"'
	cCondicao+= '.And."'+SerieNfId("SDB",3,"DB_SERIE")+'">="'+mv_par09+'".And."'+SerieNfId("SDB",3,"DB_SERIE")+'" <="'+mv_par10+'"'
	// Nao apontados
	If mv_par11 == 1
		cCondicao+= '.And. DB_HRFIM == "'+Criavar("DB_HRFIM",.F.)+'"'
	// Apontados
	ElseIf mv_par11 == 2
		cCondicao+= '.And. DB_HRFIM <> "'+Criavar("DB_HRFIM",.F.)+'"'
	EndIf
	cChave	:= 'DB_DOC+DB_SERIE+DB_PRODUTO+DB_LOCAL+DB_LOTECTL+DB_NUMLOTE+DB_SERVIC+DB_ORDTARE+DB_ORDATIV'
	IndRegua(cAliasSDB,cArq,cChave,,cCondicao,STR0009)	 //"Selecionando Registros..."
EndIf

SB5->(dbSetOrder(1))
SB1->(dbSetOrder(1))
SetRegua( LastRec() )
dbGotop()
While !Eof()
	IncRegua()
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY STR0010 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( li > 58 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	Endif
	// Pesquisa no SX5 descricao do SERVICO, TAREFA e ATIVIDADE
	cServico:=""
	SX5->(dbSetOrder(1))
	If SX5->(dbSeek(xFilial()+"L4"+(cAliasSDB)->DB_SERVIC))
		cServico:=Trim(SX5->(X5Descri()))
	EndIf
	cTarefa:=""
	If SX5->(dbSeek(xFilial()+"L2"+(cAliasSDB)->DB_TAREFA))
		cTarefa:=Trim(SX5->(X5Descri()))
	EndIf
	cAtividade:=""
	If SX5->(dbSeek(xFilial()+"L3"+(cAliasSDB)->DB_ATIVID))
		cAtividade:=Trim(SX5->(X5Descri()))					    
	EndIf
	cUM := ''
	If Len(aUM)>0 .And. (nPosUM:=aScan(aUM, {|x| x[1]==(cAliasSDB)->DB_PRODUTO}))>0
		cUM := aUM[nPosUM, 2]
	Else
		If SB5->(dbSeek(xFilial('SB5')+(cAliasSDB)->DB_PRODUTO, .F.))
			If SB1->(dbSeek(xFilial('SB1')+(cAliasSDB)->DB_PRODUTO, .F.))
				cUm := If(SB5->B5_UMIND=='2',SB1->B1_SEGUM,SB1->B1_UM)
				aAdd(aUM, {(cAliasSDB)->DB_PRODUTO, cUM})
			EndIf		
		EndIf
	EndIf	
	@ li,000 PSay DB_DOC Picture PesqPict("SDB","DB_DOC",Min(Len(DB_DOC),12))
	@ li,013+nIncCol PSay DB_SERIE Picture PesqPict("SDB","DB_SERIE",3)
	@ li,017+nIncCol PSay DB_PRODUTO Picture PesqPict("SDB","DB_PRODUTO",15)
	@ li,033+nIncCol PSay DB_LOCAL Picture PesqPict("SDB","DB_LOCAL",2)                                             
	@ li,036+nIncCol PSay DB_QUANT Picture PesqPict("SDB","DB_QUANT",13)
	@ li,050+nIncCol PSay cUM
	@ li,053+nIncCol PSay DB_LOTECTL Picture PesqPict("SDB","DB_LOTECTL",10)
	@ li,064+nIncCol PSay DB_NUMLOTE Picture PesqPict("SDB","DB_NUMLOTE",6)
	@ li,071+nIncCol PSay DB_SERVIC Picture PesqPict("SDB","DB_SERVIC",3)
	@ li,075+nIncCol PSay Substr(cServico,1,23) Picture PesqPict("SDB","DB_DESSER",23)
	@ li,099+nIncCol PSay DB_TAREFA Picture PesqPict("SDB","DB_TAREFA",3)
	@ li,103+nIncCol PSay Substr(cTarefa,1,23)	Picture PesqPict("SDB","DB_DESTAR",23)
	@ li,127+nIncCol PSay DB_ATIVID Picture PesqPict("SDB","DB_ATIVID",3)
	@ li,131+nIncCol PSay Substr(cAtividade,1,23) Picture PesqPict("SDB","DB_DESATI",23)
	@ li,155+nIncCol PSay DB_RECHUM Picture PesqPict("SDB","DB_RECHUM",6)
	@ li,162+nIncCol PSay DB_RECFIS Picture PesqPict("SDB","DB_RECFIS",6)
	@ li,169+nIncCol PSay DB_ESTFIS Picture PesqPict("SDB","DB_ESTFIS",6)
	@ li,176+nIncCol PSay DB_LOCALIZ Picture PesqPict("SDB","DB_LOCALIZ",15)
	@ li,192+nIncCol PSay DB_ESTDES Picture PesqPict("SDB","DB_ESTDES",6)
	@ li,200+nIncCol PSay DB_ENDDES Picture PesqPict("SDB","DB_ENDDES",15)
	dbSelectArea(cAliasSDB)
	dbSkip()
	li++
	cbCont++
EndDo

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf
                          
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga Arquivos Temporarios                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	(cAliasSDB)->(dbCloseArea())//(cAliasSDB)
#ELSE
	dbSelectArea(cAliasSDB)
	Set Filter To
	dbSetOrder(1)
	RetIndex("SDB")
	If File(cArq+OrdBagExt())
		Ferase(cArq+OrdBagExt())
	Endif
#ENDIF

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return(.T.)
