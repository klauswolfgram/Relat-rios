/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "PONR100.CH"   
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PONR100    ³ Autor ³ Eduardo Ju                 ³ Data ³ 29/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Banco de Horas                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_PONR100(void)                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data     ³ FNC/CH   ³  Motivo da Alteracao                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Leandro Dr. ³14/04/2014³          ³Retirada de ajustes, database e FieldPos   ³±±
±±³            ³          ³          ³que nao serao utilizados na P12.		     ³±±
±±³Luis Artuso ³15/07/2014³	   TPWXRB³Ajuste para correta impressao dos saldos   ³±±
±±³            ³          ³          ³no relatorio personalizavel,atraves da fun-³±±
±±³            ³          ³          ³cao: fTotR100.							 ³±±
±±³Luis Artuso ³16/06/2015³	   TSAHN0³Ajuste em fTotR100 para 'zerar' as celulas ³±±
±±³            ³          ³          ³FUNCDEB e FUNCCRED para calcular a totaliza³±±
±±³            ³          ³          ³cao de debito/credito entre funcionarios.	 ³±±
±±³Leandro Dr. ³05/01/2016³	   TTZWSP³Ajuste para exibir corretamente o saldo de ³±±
±±³            ³          ³          ³horas do mes anterior quando for centezimal.±±
±±³Raquel Hager³08/06/2016³	   TUWNO3³Ajuste para verificação do tipo de relatóri³±±
±±³            ³          ³          ³na geração dos dados em planilha, o tipo ana±±
±±³            ³          ³          ³lítico no formato tabela e para o sintético³±±
±±³            ³          ³          ³formato normal.                            ³±±
±±³Matheus M.  ³09/06/2016³	   TVGWHP³Ajuste para exibir corretamente o saldo do ³±±
±±³            ³          ³          ³banco de horas mês anterior quando este    ³±±
±±³            ³          ³          ³for negativo.							     ³±±
±±³Matheus M.  ³23/06/2016³	   TUXAKJ³Realizado ajuste na totalização por centro ³±±
±±³            ³          ³          ³de custo e não identificando o funcionário.³±±
±±³Matheus M.  ³19/07/2016³	   TVKCSE³Realizado ajuste para exibir valores nega- ³±±
±±³            ³          ³          ³tivos de bc para mês atual.				 ³±±
±±³Oswaldo L.  ³18/05/2017³DRHPONTP-577³Ajuste inicializacao variavel, ocorria   ³±±
±±³            ³          ³            ³problema somente ao ordenar por c.custo  ³±±
±±³Wesley Alves³07/03/2019³DRHGCH-9154³Ajuste para corrigir totalizadores quando ³±±
±±Pereira      ³          ³           ³o rel for ordenado pro C.C. sintetico     ³±±

±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function PONR100()

Local oReport
Local aArea 		:= GetArea()

Private cAliasQry 	:= GetNextAlias()
Private nSaldo	  	:= 0
Private nSaldoAnt 	:= 0
Private nSaldoEmp   := 0
Private dDataAux  	:= Ctod('') 	//-- Variavel auxiliar para armazenar a ultima data						
Private nResult		:= 0
Private lTotaliza	:= .F.
Private nAcuAnt		:= 0
Private nTotal		:= 0

Static nSdFilAnt	:= 0
Static nSdCCAnt		:= 0
Static nSaldComp 	:= 0 //-- Variavel auxiliar para comparacao de saldo
Static lIdentFu  	:= .T.
Static lSinCCSF     := .F. //Sintetico por Centro de Custo sem Funcionarios considerada no calculo do Saldo Anterior	

lSinCCSF    := .F. 
nSdFilAnt	:= 0
nSdCCAnt	:= 0
nSaldComp 	:= 0
lIdentFu  	:= .T.								
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("PN100R",.F.)

oReport := ReportDef()
oReport:PrintDialog()	

RestArea( aArea )

Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 29.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Definicao do Componente de Impressao do Relatorio           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2 
Local aOrdem    := {} 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:=TReport():New("PONR100",OemToAnsi(STR0001),"PN100R",{|oReport| PrintReport(oReport)},OemToAnsi(STR0033)+" - "+OemToAnsi(STR0002))	
	//"Relatorio de Banco de Horas"###"Emite relatorio de Banco de Horas."###"Será impresso de acordo com os parametros solicitados pelo usuario"
oReport:SetTotalInLine(.F.) 
Pergunte("PN100R",.F.)  

Aadd( aOrdem, STR0003)	// "Matricula"
Aadd( aOrdem, STR0004)	// "Centro de Custo"
Aadd( aOrdem, STR0005)	// "Nome" 
Aadd( aOrdem, STR0016)	// "C.Custo+Nome"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Primeira Secao: Funcionarios ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
oSection1 := TRSection():New(oReport,STR0019,{"SRA"},aOrdem,/*Campos do SX3*/,/*Campos do SIX*/)
oSection1:SetTotalInLine(.F.) 
oSection1:SetHeaderBreak(.T.)  

TRCell():New(oSection1,"RA_FILIAL","SRA")	//Filial
TRCell():New(oSection1,"RA_MAT","SRA")		//Matricula do Funcionario
TRCell():New(oSection1,"RA_NOME","SRA")	   	//Nome do Funcionario  
TRCell():New(oSection1,"SALDOANT","   ",STR0020,"@E 99999999.99",12)	//Saldo Anterior

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Segunda Secao: Banco de Horas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New(oSection1,STR0021,{"SRA","SPI","SP9"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/)	//Avaliados	
oSection2:SetTotalInLine(.F.) 
oSection2:SetHeaderBreak(.T.)  
oSection2:SetHeaderSection(.T.)	//Exibe Cabecalho da Secao
oSection2:SetHeaderPage(.T.)	//Exibe Cabecalho da Secao
oSection2:SetLeftMargin(2)	//Identacao da Secao
//oSection2:SetAutoSize()

TRCell():New(oSection2,"PI_DATA",	"SPI"									)	//Data da Marcacao do Evento
TRCell():New(oSection2,"PI_PD",		"SPI",	STR0022							)	//Codigo do Evento
TRCell():New(oSection2,"P9_DESC",	"SP9",	""								)	//Descricao do Evento
TRCell():New(oSection2,"DEBITO"	,	"   ",	FwNoAccent(STR0023),	"@E 99999999.99",12	)	//Debito
TRCell():New(oSection2,"CREDITO",	"   ",	FwNoAccent(STR0024),	"@E 99999999.99",12	)	//Credito
TRCell():New(oSection2,"SALDO",		"   ",	STR0025,	"@E 99999999.99",12	)	//Saldo
TRCell():New(oSection2,"STATUS"	,	"   ",	STR0026,					,15	)	//Status
TRCell():New(oSection2,"SALDO2",	"   ",	'',			"@E 99999999.99",12	)	//Saldo Anterior (Nao sera visualizado no relatorio)
TRCell():New(oSection2,"SALDO3",	"   ",	'',			"@E 99999999.99",12	)	//Saldo Anterior (Nao sera visualizado no relatorio)   
       
Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef() ³ Autor ³ Eduardo Ju          ³ Data ³ 29.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Impressao do Relatorio                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)

	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(1):Section(1)  
	Local nOrdem  	:= osection1:GetOrder()
	Local cCatQuery	:= ""
	Local cOrdem	:= ""
	Local cSitQuery	:= ""
	Local cTit
	Local cTitCC	:= ""
	Local cTitle	:= "" 
	Local cTitFil	:= ""
	Local nBcFlCrTt	:= 0
	Local nBcFlDbTt	:= 0  
	Local nSdFilAux	:= 0
	Local aLanca    := {}
	Local nValor	:= 0 //-- Variavel auxiliar para calculo do Saldo Anterior
	Local lSchedule	:= IsBlind()
	Local nTamSitFol:= TamSX1("PN100R","07")[1]
	Local cAcessaSRA:= ChkRH("PONR100", "SRA", "2")
	Local cSFiltrSQL:= fSFiltrSQL(cAcessaSRA)
	
	Private lPrimeiro := .T.
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Centralizacao das Celulas do Relatorio ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	oSection2:Cell("DEBITO"):SetHeaderAlign("RIGHT")
	oSection2:Cell("CREDITO"):SetHeaderAlign("RIGHT")
	oSection2:Cell("SALDO"):SetHeaderAlign("RIGHT")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                                          ³
	//³ MV_PAR01        //  Filial?                                                   ³
	//³ MV_PAR02        //  Centro de Custo?                                          ³
	//³ MV_PAR03        //  Matricula?                                                ³
	//³ MV_PAR04        //  Nome?                                                     ³
	//³ MV_PAR05        //  Turno?                                                    ³
	//³ MV_PAR06        //  Regra Apontamento?                                        ³
	//³ MV_PAR07        //  Situacao do Funcionario?                                  ³
	//³ MV_PAR08        //  Categoria do Funcionario?                                 ³
	//³ MV_PAR09        //  CC em outra Pagina? 1-Sim 2-Nao                           ³
	//³ MV_PAR10        //  Funcionario em outra Pagina? 1-Sim 2-Nao                  ³
	//³ MV_PAR11        //  Impressao? 1-Analitico 2-Sintetico                        ³
	//³ MV_PAR12        //  Imprime Total por Filial? 1-Sim 2-Nao                     ³
	//³ MV_PAR13        //  Imprime Total por Empresa? 1-Sim 2-Nao                    ³
	//³ MV_PAR14        //  Imprime Eventos? 1-Proventos 2-Descontos 3-Ambos          ³
	//³ MV_PAR15        //  Periodo De?                                               ³
	//³ MV_PAR16        //  Periodo Ate?                                              ³
	//³ MV_PAR17        //  Horas? 1-Normais 2-Valorizadas                            ³
	//³ MV_PAR18        //  Imprimir com Saldo? 1-Resultado 2-Credor 3-Devedor        ³
	//³ MV_PAR19        //  Eventos? 1-Autorizados 2-Nao Autorizados 3-Ambos          ³
	//³ MV_PAR20        //  Identifica Funcionario? 1-Sim 2-Nao                       ³
	//³ MV_PAR21        //  Identifica tipo de horas? 1-Sexagesimal 2-Centesimal      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	lSalta   := ( MV_PAR09 == 1 )	//Imprime C.C em outra Pagina
	lFuncS   := ( MV_PAR10 == 1 )	//Func. Outra Pagina
	lSint    := ( MV_PAR11 == 1 )	//Sintetico ou Analitico
	lImpFil  := ( MV_PAR12 == 1 )	//Imprime Total Filial
	lImpEmp  := ( MV_PAR13 == 1 )	//Imprime Total Empresa
	nImpRel	 := MV_PAR14			//Impr. Eventos (Proventos/Descontos/Ambos) 1-Proventos	2-Descontos	3-Ambos
	dPerIni	 := MV_PAR15			//Periodo De
	dPerFim	 := MV_PAR16			//Periodo Ate
	nHoras	 := MV_PAR17			// Horas Normais/Valorizadas 1-Normais 	2-Valorizadas
	nSalBH	 := MV_PAR18			// Imprimir com Saldo (Resultado/Credor/Devedor) 1-Resultado	2-Credor 3-Devedor
	nTpEvento:= MV_PAR19			// Imprimir Eventos (Autorizados/N.Autorizados/Ambos) 1-Autorizado	2-N.Autorizado 3-Ambos
	lIdentFu := Iif(MV_PAR20==1,.T.,.F.)	// Imprime somente os totais, ou também as linhas detalhe
	lSexaCent:= Iif(MV_PAR21==1,.T.,.F.)		//Horas em  (Sexagesimal/Centesimal)
	cFunction:= If(lSexaCent,"TIMESUM","SUM")
	lTotaliza	:= .F.
	nTotal		:= 0
	nAcuAnt		:= 0
	
	If !lIdentFu .AND. (nOrdem == 2 .OR.  nOrdem == 4) 
		lSinCCSF := .T.
	Endif

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Altera o Titulo do Relatorio conforme o parametro selecionado   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTit 	:= OemToansi(STR0008) + " - " + " ( "+DTOC(MV_PAR15)+" a "+DTOC(MV_PAR16)+" )"
	cTitle 	:= If(AllTrim(oReport:Title())==AllTrim(cTitle),cTit,oReport:Title())
	oReport:SetTitle(cTitle) 
	
	// - Se o relatório for sintético e a impressão for em Planilha
	// - O tipo não poderá ser formato tabela, pois o mesmo exibe apenas totalizadores.
	// - O tipo deverá ser 'Normal'.
	If lSint .And. (oReport:nDevice == 4 .And. (oReport:nExcelPrintType == 3 .Or. oReport:nExcelPrintType == 2) )
	    MsgInfo(STR0041)
	    oReport:CancelPrint()
	    Return( Nil )
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Relatorio Sintetico: Totalizacao por Funcionario   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lIdentFu     
	    If lSexaCent
			DEFINE FUNCTION oFuncDeb   NAME "FUNCDEB"   FROM oSection2:Cell("DEBITO")  	FUNCTION TIMESUM TITLE OemToAnsi(STR0023) 	OF oSection2 PICTURE "@E 99999999.99"; 	//"Debito 
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
			DEFINE FUNCTION oFuncCred  NAME "FUNCCRED"  FROM oSection2:Cell("CREDITO") 	FUNCTION TIMESUM TITLE OemToAnsi(STR0024)	OF oSection2 PICTURE "@E 99999999.99"; 	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
			DEFINE FUNCTION oFuncSal2  NAME "FUNCSAL2"  FROM oSection2:Cell("SALDO2") 	FUNCTION TIMESUM TITLE "" 					OF oSection2 PICTURE "@E 99999999.99"	//"Saldo Anterior - NAO SERA IMPRESSO
		
			DEFINE FUNCTION oFuncSal   NAME "FUNCSAL"   FROM oSection2:Cell("SALDO")   FUNCTION ONPRINT TITLE OemToAnsi(STR0036) OF oSection2;								//"Saldo Funcionario
				FORMULA {|| nResult := fTotR100(oSection1,oSection2,lTotaliza,.T.)	}
	
			oSection2:SetTotalText(OemToAnsi(STR0032))	//"Total por Funcionário"
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³O saldo anterior foi adicionado a uma celula da Section2 no ultimo lancamento do³
			³do funcionario. No entanto, esta celula nao sera impressa.                      ³
			³Isso foi necessario devido a impressao do Total Geral que nao estava saindo     ³
			³correto porque o saldo de cada funcionario esta sendo calculado por funcao.     ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			oSection2:Cell("SALDO2"):Hide(.T.)
			oSection2:Cell("SALDO3"):Hide(.T.)
			oSection2:GetFunction("FUNCSAL2"):Hide(.T.)
	
			If lSint                                                                             
				//Imprime Somente Totais  
		   		oSection2:Cell("PI_DATA"):SetTitle("")
				oSection2:Cell("PI_PD"):SetTitle("")
				oSection2:Cell("STATUS"):SetTitle("")     
	 		EndIf  
		Else
			DEFINE FUNCTION oFuncDeb   NAME "FUNCDEB"   FROM oSection2:Cell("DEBITO")  	FUNCTION SUM TITLE OemToAnsi(STR0023) 	OF oSection2 PICTURE "@E 99999999.99"; 	//"Debito 
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
			DEFINE FUNCTION oFuncCred  NAME "FUNCCRED"  FROM oSection2:Cell("CREDITO") 	FUNCTION SUM TITLE OemToAnsi(STR0024)	OF oSection2 PICTURE "@E 99999999.99"; 	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
			DEFINE FUNCTION oFuncSal2  NAME "FUNCSAL2"  FROM oSection2:Cell("SALDO2") 	FUNCTION SUM TITLE "" 					OF oSection2 PICTURE "@E 99999999.99"	//"Saldo Anterior - NAO SERA IMPRESSO
		
			DEFINE FUNCTION oFuncSal   NAME "FUNCSAL"   FROM oSection2:Cell("SALDO")   FUNCTION ONPRINT TITLE OemToAnsi(STR0036) OF oSection2;								//"Saldo Funcionario
				FORMULA {|| nResult := fTotR100(oSection1,oSection2,lTotaliza,.F.)	}
	
			oSection2:SetTotalText(OemToAnsi(STR0032))	//"Total por Funcionário"
			/*
			ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			³O saldo anterior foi adicionado a uma celula da Section2 no ultimo lancamento do³
			³do funcionario. No entanto, esta celula nao sera impressa.                      ³
			³Isso foi necessario devido a impressao do Total Geral que nao estava saindo     ³
			³correto porque o saldo de cada funcionario esta sendo calculado por funcao.     ³
			ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
			oSection2:Cell("SALDO2"):Hide(.T.)
			oSection2:Cell("SALDO3"):Hide(.T.)
			oSection2:GetFunction("FUNCSAL2"):Hide(.T.)
	
			If lSint                                                                             
				//Imprime Somente Totais  
		   		oSection2:Cell("PI_DATA"):SetTitle("")
				oSection2:Cell("PI_PD"):SetTitle("")
				oSection2:Cell("STATUS"):SetTitle("")     
	 		EndIf  
	 	EndIf	
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ordem do Relatorio   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nOrdem == 2 .or.  nOrdem == 4
		If  nOrdem == 2
	 		oSection1:SetIdxOrder(2)	//Centro de Custo
	 	Else
	 		oSection1:SetIdxOrder(8)	//Centro de Custo + Nome
	 	EndIf
	 	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacao por Centro de Custo ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oBreakCC := TRBreak():New(oReport,{|| (cAliasQry)->RA_CC },,.f.,,.f.)	//"Total por Centro de Custo"
		oBreakCC:OnBreak({|x,y|cTitCC:=OemToAnsi(STR0029)+" - "+U_fCarrCentro(x) })	//"Total por Centro de Custo - CC" 
	    oBreakCC:SetTotalText({||cTitCC})
	    
	    If lSexaCent
	
			DEFINE FUNCTION oCCDeb   NAME "CCDEB"   FROM oSection2:Cell("DEBITO")	FUNCTION TIMESUM	BREAK oBreakCC TITLE ""	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Debito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oCCCred  NAME "CCCRED"  FROM oSection2:Cell("CREDITO")	FUNCTION TIMESUM	BREAK oBreakCC	TITLE ""	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oCCSal   NAME "CCSALDO"   FROM oSection2:Cell("SALDO")   	FUNCTION ONPRINT	BREAK oBreakCC	TITLE ""	OF oSection2							NO END SECTION NO END REPORT  ;	//"Saldo Filial
	  			FORMULA {|lSection,lReport,lPage| 	nBcFlCrTt := Iif(!Empty(oSection2:GetFunction("CCCRED"):GetLastValue()),oSection2:GetFunction("CCCRED"):GetLastValue(),0), ;
	   												nBcFlDbTt := Iif(!Empty(oSection2:GetFunction("CCDEB" ):GetLastValue()),oSection2:GetFunction("CCDEB" ):GetLastValue(),0), ;
													nSdFilAux := nSdFilAux := Iif(!lIdentFu .AND. !lSinCCSF,nSaldComp,nSdCCAnt), ;
													nSdCCAnt := 0, ;
													If( !Empty(nSdFilAux), Iif(!lIdentFu,nSdFilAux,__TimeSum(nSdFilAux,__TimeSub(nBcFlCrTt,nBcFlDbTt))),__TimeSub(nBcFlCrTt,nBcFlDbTt)) }
													
		Else
			DEFINE FUNCTION oCCDeb   NAME "CCDEB"   FROM oSection2:Cell("DEBITO")	FUNCTION SUM	BREAK oBreakCC TITLE ""	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Debito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oCCCred  NAME "CCCRED"  FROM oSection2:Cell("CREDITO")	FUNCTION SUM	BREAK oBreakCC	TITLE ""	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oCCSal   NAME "CCSALDO"   FROM oSection2:Cell("SALDO")   	FUNCTION ONPRINT	BREAK oBreakCC	TITLE ""	OF oSection2							NO END SECTION NO END REPORT  ;	//"Saldo Filial
	  			FORMULA {|lSection,lReport,lPage| 	nBcFlCrTt := Iif(!Empty(oSection2:GetFunction("CCCRED"):GetLastValue()),oSection2:GetFunction("CCCRED"):GetLastValue(),0), ;
	   												nBcFlDbTt := Iif(!Empty(oSection2:GetFunction("CCDEB" ):GetLastValue()),oSection2:GetFunction("CCDEB" ):GetLastValue(),0), ;
													nSdFilAux := nSdCCAnt, ;
													nSdCCAnt := 0, ;
													If( !Empty(nSdFilAux), (nSdFilAux + (nBcFlCrTt - nBcFlDbTt)),nBcFlCrTt-nBcFlDbTt) }
		EndIf
	
		If lSalta
			oBreakCC:SetPageBreak(.T.) //Salta Pagina		
		EndIf
	EndIf
	
	If lImpFil
		If lSexaCent
	  		oBreakFil := TRBreak():New(oReport,{|| (cAliasQry)->RA_FILIAL },{|| STR0027 + " : " +(cAliasQry)->RA_FILIAL } )	//"Total por Filial"
	 
			DEFINE FUNCTION oBcFilDeb   NAME "BCFILDEB"   FROM oSection2:Cell("DEBITO")		FUNCTION TIMESUM	BREAK oBreakFil TITLE OemToAnsi(STR0023)	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Debito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oBcFilCred  NAME "BCFILCRED"  FROM oSection2:Cell("CREDITO")	FUNCTION TIMESUM	BREAK oBreakFil	TITLE OemToAnsi(STR0024)	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oBcFilSal   NAME "BCFILSAL"   FROM oSection2:Cell("SALDO")   	FUNCTION ONPRINT	BREAK oBreakFil	TITLE OemToAnsi(STR0034)	OF oSection2							NO END SECTION NO END REPORT  ;	//"Saldo Filial
	  			FORMULA {|lSection,lReport,lPage| 	nBcFlCrTt := Iif(!Empty(oSection2:GetFunction("BCFILCRED"):GetLastValue()),oSection2:GetFunction("BCFILCRED"):GetLastValue(),0), ;
	   											nBcFlDbTt := Iif(!Empty(oSection2:GetFunction("BCFILDEB" ):GetLastValue()),oSection2:GetFunction("BCFILDEB" ):GetLastValue(),0), ;
												nSdFilAux := nSdFilAnt, ;
												nSdFilAnt := 0, ;
												If( !Empty(nSdFilAux), __TimeSum(nSdFilAux,__TimeSub(nBcFlCrTt,nBcFlDbTt)),__TimeSub(nBcFlCrTt,nBcFlDbTt)) }
	
			oSection2:Cell("SALDO2"):Hide(.T.)
			oSection2:Cell("SALDO3"):Hide(.T.)
	
	 		oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0011)+x,oReport:ThinLine()})	//"TOTAL FILIAL  "
	    	oBreakFil:SetTotalText({||cTitFil})
	    Else
	    	 oBreakFil := TRBreak():New(oReport,{|| (cAliasQry)->RA_FILIAL },{|| STR0027 + " : " +(cAliasQry)->RA_FILIAL } )	//"Total por Filial"
	 
			DEFINE FUNCTION oBcFilDeb   NAME "BCFILDEB"   FROM oSection2:Cell("DEBITO")		FUNCTION SUM	BREAK oBreakFil TITLE OemToAnsi(STR0023)	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Debito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oBcFilCred  NAME "BCFILCRED"  FROM oSection2:Cell("CREDITO")	FUNCTION SUM	BREAK oBreakFil	TITLE OemToAnsi(STR0024)	OF oSection2 PICTURE "@E 99999999.99"	NO END SECTION NO END REPORT ;	//"Credito
					WHEN {||(oSection2:Cell("STATUS"):GetValue()<>"B")}
	
			DEFINE FUNCTION oBcFilSal   NAME "BCFILSAL"   FROM oSection2:Cell("SALDO")   	FUNCTION ONPRINT	BREAK oBreakFil	TITLE OemToAnsi(STR0034)	OF oSection2							NO END SECTION NO END REPORT  ;	//"Saldo Filial
	  			FORMULA {|lSection,lReport,lPage| 	nBcFlCrTt := Iif(!Empty(oSection2:GetFunction("BCFILCRED"):GetLastValue()),oSection2:GetFunction("BCFILCRED"):GetLastValue(),0), ;
	   											nBcFlDbTt := Iif(!Empty(oSection2:GetFunction("BCFILDEB" ):GetLastValue()),oSection2:GetFunction("BCFILDEB" ):GetLastValue(),0), ;
												nSdFilAux := nSdFilAnt, ;
												nSdFilAnt := 0, ;
												If( !Empty(nSdFilAux),((nSdFilAux)+(nBcFlCrTt-nBcFlDbTt)),(nBcFlCrTt-nBcFlDbTt)) }											
	
			oSection2:Cell("SALDO2"):Hide(.T.)
			oSection2:Cell("SALDO3"):Hide(.T.)
	
	 		oBreakFil:OnBreak({|x,y|cTitFil:=OemToAnsi(STR0011)+x,oReport:ThinLine()})	//"TOTAL FILIAL  "
	    	oBreakFil:SetTotalText({||cTitFil})
	    EndIf
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Transforma parametros Range em expressao (intervalo) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("PN100R")
	
	If lSchedule
		MV_PAR07 := AllTrim(MV_PAR07)
		If Len(MV_PAR07) < nTamSitFol
			MV_PAR07 := PadL(MV_PAR07,nTamSitFol)
		EndIf
	EndIf
	
	cSitQuery := "%"+fSqlIn(MV_PAR07, 1)+"%"
	cCatQuery := "%"+fSqlIn(MV_PAR08, 1)+"%"
	cSFiltrSQL := If(!Empty(cSFiltrSQL) .And.  cSFiltrSQL != ".T.", "%AND " + cSFiltrSQL + "%", "%%")
	
	BEGIN REPORT QUERY oSection1

	If nOrdem == 1	
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT,SRA.RA_NOME%"
	ElseIf  nOrdem == 2
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
	ElseIf nOrdem == 3
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME,SRA.RA_MAT%"
	ElseIf nOrdem == 4
	 	cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_NOME%"
	EndIf	  

	BeginSql alias cAliasQry
		SELECT RA_FILIAL, RA_MAT, RA_NOME, RA_CC
		FROM %table:SRA% SRA
		WHERE SRA.RA_SITFOLH IN	(%exp:Upper(cSitQuery)%) AND
		 		SRA.RA_CATFUNC IN (%exp:Upper(cCatQuery)%) AND
				SRA.%notDel% %Exp:cSFiltrSQL%
		ORDER BY %exp:cOrdem%
	EndSql

	END REPORT QUERY oSection1 PARAM mv_par01, mv_par02, mv_par03, mv_par04, mv_par05, mv_par06
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Funcionario em Outra Pagina ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lFuncS .And. lIdentFu
		oBreakFunc := TRBreak():New(oReport,{|| (cAliasQry)->RA_MAT },{|| STR0019 + " "+ (cAliasQry)->RA_MAT } )
		oBreakFunc:SetPageBreak(.T.) //Salta Pagina
	EndIf
	
	dbSelectArea( cAliasQry )
	
	While !EOF() 
			
		oReport:IncMeter()
		
		If oReport:Cancel()
			Exit
		EndIf
	
		// Totalizador do Saldo
		nSaldo    := 0
		nSaldoAnt := 0
		lPrimeira := .T.
		aLanca    := {}
		nValor	  := 0
	    dDataAux  := CTOD(SPACE(8))		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica lancamentos no Banco de Horas                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea( "SPI" )
		dbSetOrder(2)
		dbSeek( (cAliasQry)->RA_FILIAL + (cAliasQry)->RA_MAT )
		While SPI->( !Eof() .and. PI_FILIAL+PI_MAT == (cAliasQry)->( RA_FILIAL+RA_MAT ) )
	
			//-- Verifica tipo de Evento quando for diferente de Ambos
			If nTpEvento <> 3
				If !fBscEven(SPI->PI_PD,2,nTpEvento)
					SPI->(dbSkip())
					Loop
				EndIf
			Else
				PosSP9(SPI->PI_PD,(cAliasQry)->RA_FILIAL,"P9_TIPOCOD")
			Endif
	
			// Totaliza Saldo Anterior
			If SPI->PI_DATA < dPerIni
				If SP9->P9_TIPOCOD $  "1*3"
					If nImpRel == 1 .Or. nImpRel == 3
						nValor:=If(SPI->PI_STATUS=="B",0,If(nHoras=1,SPI->PI_QUANT,SPI->PI_QUANTV))
						//-- Para valor nao nulo considera a Data para Referencia do Saldo
					    dDataAux:=If(Empty(nValor),dDataAux,SPI->PI_DATA)
						nSaldoAnt:=__TimeSum(nSaldoAnt,nValor)  
					Endif
				Else
					If nImpRel == 2 .Or. nImpRel == 3
						nValor:=If(SPI->PI_STATUS=="B",0,If(nHoras=1,SPI->PI_QUANT,SPI->PI_QUANTV))
						//-- Para valor nao nulo considera a Data para Referencia do Saldo
						dDataAux:=If(Empty(nValor),dDataAux,SPI->PI_DATA)
						nSaldoAnt:=__TimeSub(nSaldoAnt,nValor)  
					Endif
				Endif
				nSaldo   := If(!lSexaCent, fConvHr(nSaldoAnt,'D',,2,.T.),nSaldoAnt)
			Endif
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica os Lancamentos a imprimir                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If	SPI->PI_DATA < dPerIni .Or. SPI->PI_DATA > dPerFim
				nAcuAnt	+=	nSaldo
				dbSkip()
				Loop
			Endif
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Acumula os lancamentos de Proventos/Desconto em Array        ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			FSomaR4(@aLanca,1)	// Funcionario
	
			dbSelectArea( "SPI" )
			dbSkip()
	
		Enddo
		
		If !lSexaCent
		 	nSaldoAnt := fConvHr(nSaldoAnt,'D',,2,.T.)
		EndIf	
	
		dbSelectArea( cAliasQry )
		
		//-- Se nao houve movimento no periodo sera comparado o tipo de saldo (credito ou debito
		//-- com o saldo anterior
		//-- Senao sera comparado o resultado do mes
		If	Len(aLanca) == 0 
		    nSaldComp+= nSaldoAnt
		Else
		    nSaldComp+= aLanca[Len(aLanca),5]
		Endif    
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Funcionarios                                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( nSalBH == 1  .Or. (nSalBH == 2 .And. nSaldComp >= 0) .Or. (nSalBH == 3 .And. nSaldComp < 0)) 
			
			fImpFunR4(@aLanca,oReport)
			
		Endif
	
		dbSelectArea( cAliasQry )
		dbSkip()
	
		// ZERA O VALOR PARA GARANTIR QUE O SALDO DO PROXIMO REGISTRO, NÃO TENHA O VALOR INCORRETO. 
		nSaldComp := 0
	
	Enddo

	lTotaliza	:= .T.
	
Return Nil

*---------------------------------*
Static Function FSomaR4(aLanca,nTipo)      		// Acumula Lancamentos
*---------------------------------*
Private nPos:=0
DEFAULT lSexaCent := .T.

IF SP9->( P9_TIPOCOD $ "1*3" .and. nImpRel == 2 .or. P9_TIPOCOD == "2" .and. nImpRel == 1  )
	Return( NIL )
EndIF

If nTipo > 1 .And. (nPos:=aScan(aLanca,{ |x| x[2] == SPI->PI_PD })) > 0
	If SPI->PI_STATUS <> "B"
		If SP9->P9_TIPOCOD $ "1*3"
			If lSexaCent
				aLanca[nPos,4] := __TimeSum(aLanca[nPos,4],If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV))
			Else
				aLanca[nPos,4] := (aLanca[nPos,4]) + (If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV)) 
			EndIf
		Else
			If lSexaCent
				aLanca[nPos,3] := __TimeSum(aLanca[nPos,3],If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV))
			Else
				aLanca[nPos,3] := fConvHr((aLanca[nPos,3]) + (If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV)),'D',,5)
			EndIf
		Endif
	Endif
Else
	aAdd(aLanca ,{})
	aAdd(aLanca[Len(aLanca)],SPI->PI_DATA)
	aAdd(aLanca[Len(aLanca)],SPI->PI_PD)
	If SP9->P9_TIPOCOD $ "1*3"
		If nTipo == 1
			If lSexaCent
				nSaldo:= __TimeSum(nSaldo,If(SPI->PI_STATUS=="B",0,If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV)))
			Else
				nSaldo:= (nSaldo) + (If(SPI->PI_STATUS=="B",0,fConvHr(If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV),'D',,5,.T.)))
			EndIf
		Endif
		aAdd(aLanca[Len(aLanca)],0.00)

		If nTipo > 1 .And. SPI->PI_STATUS == "B"
			aAdd(aLanca[Len(aLanca)],0.00)
		Else
			If (lSexaCent != .T.) 
				aAdd(aLanca[Len(aLanca)],fConvHr(If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV),'D',,5,.T.))
			Else
				aAdd(aLanca[Len(aLanca)],If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV))
			EndIf
		Endif

		aAdd(aLanca[Len(aLanca)],nSaldo)
	Else
		If nTipo == 1
		If lSexaCent
				nSaldo:=__TimeSub(nSaldo,If(SPI->PI_STATUS=="B",0,If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV)))
			Else
				nSaldo:=(nSaldo) - (If(SPI->PI_STATUS=="B",0,fConvHr(If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV),'D',,5,.T.)))
			EndIf
		Endif

		If nTipo > 1 .And. SPI->PI_STATUS == "B"
			aAdd(aLanca[Len(aLanca)],0.00)
		Else
			If lSexaCent
				aAdd(aLanca[Len(aLanca)],If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV))
			Else
				aAdd(aLanca[Len(aLanca)],fConvHr(If(nHoras==1,SPI->PI_QUANT,SPI->PI_QUANTV),'D',,5,.T.))
			EndIf
		Endif

		aAdd(aLanca[Len(aLanca)],0.00)
		aAdd(aLanca[Len(aLanca)],nSaldo)
	Endif
	aAdd(aLanca[Len(aLanca)],If(nTipo==1,SPI->PI_STATUS," "))	//
Endif

Return Nil

*-----------------------------*
Static Function fImpFunR4(aLanca,oReport)            // Imprime um Funcionario
*-----------------------------*
If	Len(aLanca) == 0 .AND. EMPTY(nSaldoAnt)
	Return Nil
Endif

fImprimeR4(aLanca,oReport)

aLanca := {}

Return Nil

*-----------------------------------------------*
Static Function fImprimeR4(aLanca,oReport)
*-----------------------------------------------*
// nTipo: 1- Funcionario
//        2- Centro de Custo
//        3- Filial
//        4- Empresa

Local nConta := 0        
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local nQtdLanc  := 0
Local cSeek		:= ""

If lIdentFu
	oSection1:Init() 
	oSection1:Cell("SALDOANT"):SetValue(nSaldoAnt)
	oSection1:PrintLine()
	oSection1:Finish()
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime identificacao do Funcionario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lIdentFu //Nao imprime detalhe do Funcionario ou Sintetico
	if lPrimeiro 
		oReport:PrintText(" ")
		lPrimeiro := .F.
	endIf 
	oSection2:Hide()      
   	oSection2:Cell("PI_DATA"):SetTitle("")
	oSection2:Cell("PI_PD"):SetTitle("")
	oSection2:Cell("STATUS"):SetTitle("")
	
	oSection2:SetHeaderBreak(.T.)  
EndIf


oSection2:Init()

nQtdLanc := Len(aLanca) 

DbSelectArea("SPI")
DbSetOrder(1)

For nConta :=1 TO nQtdLanc
	oSection2:Cell("PI_DATA"	):SetValue(aLanca[nConta,1])
	oSection2:Cell("PI_DATA"	):SetTitle("") 
	oSection2:Cell("PI_PD"		):SetValue(aLanca[nConta,2]) 
	oSection2:Cell("PI_PD"		):SetTitle("")
	oSection2:Cell("P9_DESC"	):SetValue(Left(DescPdPon(aLanca[nConta,2],(cAliasQry)->RA_FILIAL),20))   
	oSection2:Cell("P9_DESC"	):SetTitle("")
	oSection2:Cell("DEBITO"		):SetValue(aLanca[nConta,3])
	oSection2:Cell("CREDITO"	):SetValue(aLanca[nConta,4])
	oSection2:Cell("SALDO"		):SetValue(aLanca[nConta,5])
	oSection2:Cell("STATUS"		):SetValue(If(aLanca[nConta,6]=="B",STR0030,STR0031)) //"Baixado"#"Pendente" 
	oSection2:Cell("STATUS"		):SetTitle("")


	cSeek := xFilial("SPI",(cAliasQry)->RA_FILIAL)+(cAliasQry)->RA_MAT +aLanca[nConta,2]+dToS(aLanca[nConta,1])
	
	dbSeek(cSeek)

	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³O saldo anterior foi adicionado ao ultimo lancamento do funcionario.            ³
	³Isso foi necessario devido para que a impressao do Total Geral saia correta     ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
  	
	If nQtdLanc == nConta
		oSection2:Cell("SALDO2"	):SetValue(nSaldoAnt)
		
		If !lIdentFu
			If lSexaCent
				oSection2:Cell("CREDITO"):SetValue(__TimeSum(oSection2:Cell("CREDITO"):GetValue(),nSaldoAnt))
			Else
				oSection2:Cell("CREDITO"):SetValue(oSection2:Cell("CREDITO"):GetValue() + nSaldoAnt)
			EndIf
		EndIf
	Else
		oSection2:Cell("SALDO2"	):SetValue(0)	
	EndIf 
	
	If lSexaCent
		oSection2:Cell("SALDO3"	):SetValue( IF(!Empty(oSection2:Cell("SALDO3"	):GetValue()),__TimeSum(oSection2:Cell("SALDO3"	):GetValue(),oSection2:Cell("SALDO2"	):GetValue()),oSection2:Cell("SALDO2"	):GetValue()))
	Else
		oSection2:Cell("SALDO3"	):SetValue( IF(!Empty(oSection2:Cell("SALDO3"	):GetValue()),oSection2:Cell("SALDO3"	):GetValue() + oSection2:Cell("SALDO2"	):GetValue(),oSection2:Cell("SALDO2"	):GetValue()))
	EndIf
		
   	IF lSint
   		oSection2:Hide()    
   	Endif	
 	oSection2:PrintLine()     
Next nConta 

oSection2:Finish()

Return Nil

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄT¿
//³Funcao para retornar a descricao do centro de custo na quebra da pagina.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTÙ
User Function fCarrCentro(cCodCCusto)
                                       
Return( cCodCCusto + " "+Left(DescCC(cCodCCusto),20) )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DescCC    ºAutor  ³Ricardo Berti       º Data ³  16/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna a Descricao do Centro de Custo                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PONR100                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function DescCC(cCC, nMoeda)

Local aAreaAnt   := GetArea()
Local aAreaCC    := {}
Local cRet       := Replicate('*', Len(CTT->CTT_DESC01))
Local cSeekCC    := ''
Local cAliasCC   := 'CTT'

Default cCC        := ''
Default nMoeda     := 1

dbSelectArea(cAliasCC)
aAreaCC := GetArea()
dbSetOrder(1)
If MsSeek(cSeekCC:=xFilial(cAliasCC)+cCC, .F.)
	If cAliasCC == 'CTT'
		cRet := Left(&('CTT_DESC'+StrZero(nMoeda, 2)), Len(CTT->CTT_DESC01)) //-- Do mesmo tamanho do I3_DESC, para manter a compatibilidade
	EndIf
EndIf
RestArea(aAreaCC)
RestArea(aAreaAnt)

Return cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fTotR100  ºAutor  ³Luis Artuso         º Data ³  06/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Totaliza o saldo de horas.                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fTotR100(oSection1,oSection2,lTotaliza,lSexaCent)

Local nFuncCrTt	:= 0
Local nFuncDbTt	:= 0
Local nSdFunAnt	:= 0
Local nRet		:= 0

If ( lTotaliza )
	nSdFunAnt := nAcuAnt
Else
	nSdFunAnt := oSection1:Cell("SALDOANT"):GetValue()
	If lSexaCent
		nSdFilAnt := __TimeSum(oSection1:Cell("SALDOANT"):GetValue(),nSdFilAnt)
		nSdCCAnt  := __TimeSum(oSection1:Cell("SALDOANT"):GetValue(),nSdCCAnt)
	Else
		nSdFilAnt += oSection1:Cell("SALDOANT"):GetValue()
		nSdCCAnt += oSection1:Cell("SALDOANT"):GetValue()
	EndIf
EndIf

if !(Empty(oSection2:GetFunction("FUNCCRED"):GetLastValue()))
	nFuncCrTt	:= oSection2:GetFunction("FUNCCRED"):GetLastValue()
EndIF

if !(Empty(oSection2:GetFunction("FUNCDEB" ):GetLastValue()))
	nFuncDbTt	:= oSection2:GetFunction("FUNCDEB" ):GetLastValue()
EndIf	

If lSexaCent
	If !( Empty(nSdFunAnt) )
		nRet	:= __TimeSum(nSdFunAnt,__TimeSub(nFuncCrTt,nFuncDbTt))
	Else	
		nRet	:= __TimeSub(nFuncCrTt,nFuncDbTt) 
	EndIf
Else
	nRet := (nFuncCrTt - nFuncDbTt) + nSdFunAnt
EndIf

oSection2:GetFunction("FUNCDEB" ):SetValue(0)
oSection2:GetFunction("FUNCCRED" ):SetValue(0)

If ( lTotaliza )
	Return	nTotal
Else
	If lSexaCent	
		nTotal	:= __TimeSum(nTotal,nRet)
	Else
		nTotal	+= nRet
	EndIf
	Return nRet			
EndIf

Static Function SchedDef()
	
	Local aParam
	Local aOrd := {}
	
	Aadd( aOrd, STR0003)	// "Matricula"
	Aadd( aOrd, STR0004)	// "Centro de Custo"
	Aadd( aOrd, STR0005)	// "Nome" 
	Aadd( aOrd, STR0016)	// "C.Custo+Nome"
	
	aParam := { "R",;      	// Tipo R para relatorio P para processo
				"PN100R",;	// Pergunte do relatorio, caso nao use passar ParamDef
				"",;  		// Alias
   				aOrd,;   	// Array de ordens
				}
	
Return aParam
