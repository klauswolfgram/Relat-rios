/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "OMSR070.CH"
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ OMSR070  ³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Roteirizacao (Janela Prev. x Real). Release 4.³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAOMS                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function OMSR070()
Local oReport := Nil

	If FindFunction("OMSMsgRelD")
		OMSMsgRelD()
	EndIf

	If FindFunction("TRepInUse") .And. TRepInUse()
		//-- Interface de impressao
		oReport := ReportDef()
		oReport:PrintDialog()
	Else
		U_OMSR070R3()
	EndIf

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
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
#IFDEF TOP
	Local cAliasDAK := GetNextAlias()
	Local cAliasDAH := cAliasDAK
	Local cAliasDA3 := cAliasDAK
	Local cAliasDA4 := cAliasDAK
	Local cAliasSA1 := cAliasDAK
#ELSE 
	Local cAliasDAK := "DAK"
	Local cAliasDAH := "DAH"
	Local cAliasDA3 := "DA3"
	Local cAliasDA4 := "DA4"
	Local cAliasSA1 := "SA1"
#ENDIF	


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
oReport := TReport():New("OMSR070",STR0018,"OMR070", {|oReport| ReportPrint(oReport,cAliasDAK,cAliasDAH,cAliasSA1)},STR0019 + " " + STR0020 + " " + STR0021)	// "Janela de Entregas Previsto x Realizado"###"Este programa ira emitir a relacao Previsto x Realizado da"###"Janela de Entregas de acordo com os parametros escolhidos "###"pelo usuario"
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
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
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Section(1)                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCarga := TRSection():New(oReport,"Carga",{"DAK","DA3","DA4"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCarga:SetTotalInLine(.F.)
oCarga:SetLineStyle(.T.)
oCarga:SetPageBreak(.T.)
TRCell():New(oCarga,"DAK_COD"   ,"DAK","Carga"   ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_SEQCAR","DAK","Seq." 	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAMINH","DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA3_DESC"  ,"DA3",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_MOTORI","DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DA4_NOME"  ,"DA4",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PESO"  ,"DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_CAPVOL","DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_PTOENT","DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_VALOR" ,"DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_DATA"  ,"DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCarga,"DAK_HORA"  ,"DAK",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Section(1):Section(1)                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oEntrega := TRSection():New(oCarga,"Entregas",{"DAH","SA1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oEntrega:SetTotalInLine(.F.)

TRCell():New(oEntrega,"DAH_SEQUEN","DAH",RetTitle("DAH_SEQUEN"),PesqPict("DAH","DAH_SEQUEN")	,TamSx3("DAH_SEQUEN"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEntrega,"DAH_CODCLI","DAH",RetTitle("DAH_CODCLI"),PesqPict("DAH","DAH_CODCLI")	,TamSx3("DAH_CODCLI"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEntrega,"DAH_LOJA"  ,"DAH",RetTitle("DAH_LOJA")	,PesqPict("DAH","DAH_LOJA")		,TamSx3("DAH_LOJA"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEntrega,"A1_NOME"   ,"SA1",RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME"		)[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oEntrega,"DAH_HRCHEG","DAH",STR0022				,PesqPict("DAH","DAH_HRCHEG")	,TamSx3("DAH_HRCHEG"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)																	// "Chegada Prevista"
TRCell():New(oEntrega,"DAH_TMSERV","DAH",STR0023				,PesqPict("DAH","DAH_TMSERV")	,TamSx3("DAH_TMSERV"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)																	// "Time Service Previsto"
TRCell():New(oEntrega,"SPREVC"    ,"   ",STR0024				,/*Picture*/					,/*Tamanho*/				,/*lPixel*/,{||  IntToHora(HoraToint((cAliasDAH)->DAH_HRCHEG,2)+HoraToInt((cAliasDAH)->DAH_TMSERV,4),2) })	// "Saida Prevista"
TRCell():New(oEntrega,"DAH_CHGREA","DAH",STR0025				,PesqPict("DAH","DAH_CHGREA")	,TamSx3("DAH_CHGREA"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)																	// "Chegada Real"
TRCell():New(oEntrega,"DAH_TMREAL","DAH",STR0026				,PesqPict("DAH","DAH_TMREAL")	,TamSx3("DAH_TMREAL"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)																	// "Time Service Real"
TRCell():New(oEntrega,"DAH_SDREAL","DAH",STR0027				,PesqPict("DAH","DAH_SDREAL")	,TamSx3("DAH_SDREAL"	)[1],/*lPixel*/,/*{|| code-block de impressao }*/)																	// "Saida Real"

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 08/08/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasDAK,cAliasDAH,cAliasSA1)


Local lQuery    := .F.
#IFNDEF TOP
	Local cCondicao := ""
#ELSE
	Local cOrder := ""	
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP

	DAH->(dbSetOrder(1))
	If TcSrvType() <> "AS/400"
	
		lQuery := .T.
		cOrder := "%" + SqlOrder(DAH->(IndexKey(1))) + "%"
				
		oReport:Section(1):BeginQuery()
		BeginSql Alias cAliasDAK
		SELECT DAK.*,A1_COD,A1_LOJA,A1_NOME,DAH.*
		FROM %Table:DAK% DAK, %Table:DAH% DAH, %Table:SA1% SA1
		WHERE
		DAK_FILIAL = %xFilial:DAK%
		AND DAK_COD >= %Exp:mv_par01% AND DAK_COD <= %Exp:mv_par02%
		AND DAK_SEQCAR >= %Exp:mv_par03% AND DAK_SEQCAR <= %Exp:mv_par04%
		AND DAK_DATA >= %Exp:Dtos(mv_par05)% AND DAK_DATA <= %Exp:Dtos(mv_par06)%
		AND DAK_CAMINH >= %Exp:mv_par07% AND DAK_CAMINH <= %Exp:mv_par08%
		AND DAK_MOTORI >= %Exp:mv_par09% AND DAK_MOTORI <= %Exp:mv_par10%
		AND DAK.%Notdel%
			
		AND DAH_FILIAL = %xFilial:DAH%
		AND DAH_CODCAR = DAK_COD
		AND DAH_SEQCAR = DAK_SEQCAR
		AND DAH.%Notdel%
		
		AND A1_FILIAL = %xFilial:SA1%
		AND A1_COD  = DAH_CODCLI
		AND A1_LOJA = DAH_LOJA
		AND SA1.%Notdel%

		ORDER BY %Exp:cOrder%
		EndSql
		oReport:Section(1):EndQuery()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Usa Query da Secao Principal nas Secoes Filhas                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):Section(1):SetParentQuery()		
	
    Else  	 		
#ENDIF	 		

		dbSelectarea(cAliasDAK)
		cCondicao := 'DAK_FILIAL == "'+xFilial("DAK")+'".And.' 
		cCondicao += 'DAK_COD >= "'+mv_par01+'".And.DAK_COD <="'+mv_par02+'".And.'
		cCondicao += 'DAK_SEQCAR >= "'+mv_par03+'".And.DAK_SEQCAR <="'+mv_par04+'".And.'               
		cCondicao += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par05)+'".And.Dtos(DAK_DATA) <="'+Dtos(mv_par06)+'".And.'
		cCondicao += 'DAK_CAMINH >= "'+mv_par07+'".And.DAK_CAMINH <="'+mv_par08+'".And.'    
		cCondicao += 'DAK_MOTORI >= "'+mv_par09+'".And.DAK_MOTORI <="'+mv_par10+'"'		

		oReport:Section(1):SetFilter(cCondicao,(cAliasDAK)->(IndexKey()))

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Relaciona tabela principal com tabelas filhas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport:Section(1):Section(1):SetRelation({|| xFilial("DAH")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR}, cAliasDAH , 1 , .T. )
		    
#IFDEF TOP
	Endif
#ENDIF	    	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define regra de saida do loop quando mutilizado metodo Print            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Section(1):SetParentFilter({|x| (cAliasDAH)->DAH_FILIAL+(cAliasDAH)->DAH_CODCAR+(cAliasDAH)->DAH_SEQCAR == x}, {||xFilial("DAH")+(cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR} )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lQuery
	TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasDAH)->DAH_CODCLI+(cAliasDAH)->DAH_LOJA})
EndIf	
TRPosition():New(oReport:Section(1),"DA3",1,{|| xFilial("DA3")+(cAliasDAK)->DAK_CAMINH })
TRPosition():New(oReport:Section(1),"DA4",1,{|| xFilial("DA4")+(cAliasDAK)->DAK_MOTORI })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicio da impressao do fluxo do relatório                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Print()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³OMSR070   ³ Autor ³ Henry Fila            ³ Data ³ 20.06.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relatorio de Roteirizacao                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function OMSR070R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	Local Titulo  := OemToAnsi(STR0001) //"Roteirizacao"
	Local cDesc1  := OemToAnsi(STR0002) //""  // Descricao 1
	Local cDesc2  := OemToAnsi(STR0003) //""  // Descricao 2
	Local cDesc3  := OemToAnsi(STR0004) //""  // Descricao 3
#ELSE
	Local Titulo  := ""
	Local cDesc1  := ""
	Local cDesc2  := ""
	Local cDesc3  := ""
#ENDIF
Local cString := "DAH"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .T. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "OMSR070"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "OMSR070"  // nome do programa

Private Tamanho := "M" // P/M/G
Private Limite  := 132 // 80/132/220
Private cPerg   := "OMR070"  // Pergunta do Relatorio
Private aReturn := { OemtoAnsi(STR0005), 1,OemtoAnsi(STR0006), 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
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
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
		dbClearFilter()
	Return
Endif
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
#ELSE
	ImpDet(.F.,wnrel,cString,nomeprog,Titulo)
#ENDIF

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

#IFDEF TOP
	Local cQuery    := ""
	Local aStruDAK  := DAK->(dbStruct()) 
	Local cAliasDA3 := "DA3"
	Local cAliasDA4 := "DA4"
	Local nX        := 0
#ENDIF

Local li        := 100 // Contador de Linhas
Local lImp      := .F. // Indica se algo foi impresso
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local cAliasDAH := "DAH"
Local cAliasSA1 := "SA1"
Local cAliasDAK := "DAK"
Local cCarga    := ""
Local cKey      := ""
Local cCondicao := ""
Local cIndDAK   := ""

Local lQuery  := .F.                     

Local nIndDAK := 0

//
//                         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//              "SEQUENCIA   CLIENTE LOJA  NOME                           CHEGADA    TIME SERVICE   SAIDA      CHEGADA  TIME SERVICE   SAIDA"     
//              "ENTREGA                                                  PREVISTA   PREVISTO       PREVISTA   REAL     REAL           REAL"
//               XXXXXX      XXXXXX  XX    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX:XX      XX:XX          XX:XX      XX:XX    XX:XX          XX:XX

cCabec1 :=  OemtoAnsi(STR0016) //"SEQUENCIA   CLIENTE LOJA  NOME                           CHEGADA    TIME SERVICE   SAIDA      CHEGADA  TIME SERVICE   SAIDA" 
cCabec2 :=  OemtoAnsi(STR0017)//"ENTREGA                                                  PREVISTA   PREVISTO       PREVISTA   REAL     REAL           REAL"
#IFDEF TOP

	DAH->(dbSetOrder(1))

	If TcSrvType() <> "AS/400"                    		
	
		lQuery := .T.
		cAliasDAH := "QRYDAH"
		cAliasSA1 := "QRYDAH"
		cAliasDAK := "QRYDAH"
		cAliasDA3 := "QRYDAH"
		cAliasDA4 := "QRYDAH"
				
		cQuery := "SELECT DAK.*,A1_COD,A1_LOJA,A1_NOME,DAH.*"
		cQuery += " FROM "
		cQuery += RetSqlName("DAK") + " DAK, "
		cQuery += RetSqlName("DAH") + " DAH, "
		cQuery += RetSqlName("SA1") + " SA1 "
		cQuery += " WHERE "
		cQuery += " DAK_FILIAL = '"+xFilial("DAK")+"' "                    
		cQuery += " AND DAK_COD >= '"+mv_par01+"' AND DAK_COD <='"+mv_par02+"' "
		cQuery += " AND DAK_SEQCAR >= '"+mv_par03+"' AND DAK_SEQCAR <='"+mv_par04+"' "        
		cQuery += " AND DAK_DATA >= '"+Dtos(mv_par05)+"' AND DAK_DATA <='"+Dtos(mv_par06)+"' "
		cQuery += " AND DAK_CAMINH >= '"+mv_par07+"' AND DAK_CAMINH <='"+mv_par08+"' "
		cQuery += " AND DAK_MOTORI >= '"+mv_par09+"' AND DAK_MOTORI <='"+mv_par10+"' "                 
		cQuery += " AND DAK.D_E_L_E_T_ = ' ' "
			
		cQuery += " AND DAH_FILIAL ='"+xFilial("DAH")+"' "
		cQuery += " AND DAH_CODCAR = DAK_COD "
		cQuery += " AND DAH_SEQCAR = DAK_SEQCAR "			
		cQuery += " AND DAH.D_E_L_E_T_ = ' ' " 
		
		cQuery += " AND A1_FILIAL ='"+xFilial("SA1")+"' "
		cQuery += " AND A1_COD  = DAH_CODCLI "
		cQuery += " AND A1_LOJA = DAH_LOJA "			
		cQuery += " AND SA1.D_E_L_E_T_ = ' ' " 

		cQuery += "ORDER BY "+SqlOrder(DAH->(IndexKey()))
		
		cQuery := ChangeQuery(cQuery)
 		dBUseArea(.t.,"TOPCONN",TCGENQRY(,,cQuery),cAliasDAH,.f.,.t.)

		For nX := 1 To Len(aStruDAK)
			If aStruDAK[nX][2]!="C"
				TcSetField(cAliasDAK,aStruDAK[nX][1],aStruDAK[nX][2],aStruDAK[nX][3],aStruDAK[nX][4])
			EndIf
		Next nX

    Else  	 		
#ENDIF	 		

		dbSelectarea(cAliasDAK)
		cIndDAK := CriaTrab(NIL,.F.)
		cKey := IndexKey()

		cCondicao := 'DAK_FILIAL == "'+xFilial("DAK")+'".And.' 
		cCondicao += 'DAK_COD >= "'+mv_par01+'".And.DAK_COD <="'+mv_par02+'".And.'
		cCondicao += 'DAK_SEQCAR >= "'+mv_par03+'".And.DAK_SEQCAR <="'+mv_par04+'".And.'               
		cCondicao += 'Dtos(DAK_DATA) >= "'+Dtos(mv_par05)+'".And.Dtos(DAK_DATA) <="'+Dtos(mv_par06)+'".And.'
		cCondicao += 'DAK_CAMINH >= "'+mv_par07+'".And.DAK_CAMINH <="'+mv_par08+'".And.'    
		cCondicao += 'DAK_MOTORI >= "'+mv_par09+'".And.DAK_MOTORI <="'+mv_par10+'"'		

		IndRegua("DAK",cIndDAK,cKey,,cCondicao,"Selecionando Registros ...") //"Selecionando Registros ..."
		nIndDAK := RetIndex("DAK")
		#IFNDEF TOP
		dbSetIndex(cIndDAK+OrdBagExT())
		#ENDIF
		dbSetOrder(nIndDAK+1)
    
#IFDEF TOP
	Endif
#ENDIF	    	
	   
		
While (cAliasDAK)->(!Eof())

	lSkip := .F.			

	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF
	If lEnd
		@ Prow()+1,001 PSAY STR0006 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	
	If ( li > 60 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Busca cliente e motoristas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DA3->(dbSetOrder(1))
	DA3->(MsSeek(xFilial("DA3")+(cAliasDAK)->DAK_CAMINH))

	DA4->(dbSetOrder(1))
	DA4->(MsSeek(xFilial("DA4")+(cAliasDAK)->DAK_MOTORI))

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o cabecalho da carga                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ li,000 PSAY OemtoAnsi(STR0007)+(cAliasDAK)->DAK_COD+"-"+(cAliasDAK)->DAK_SEQCAR //"CARGA   : "
	li++
	@ li,000 PSAY OemtoAnsi(STR0008)+ (cAliasDAK)->DAK_CAMINH + " - " + DA3->DA3_DESC //"VEICULO : "
	@ li,055 PSAY OemtoAnsi(STR0009)+(cAliasDAK)->DAK_MOTORI + " - " + DA4->DA4_NOME //"MOTORISTA : "	
	li++
	@ li,000 PSAY OemtoAnsi(STR0010) //"PESO    :" 
	@ li,010 PSAY (cAliasDAK)->DAK_PESO Picture PesqPict("DAK","DAK_PESO")  
	@ li,025 PSAY OemtoAnsi(STR0011) //"VOLUME M3 : "
	@ li,037 PSAY (cAliasDAK)->DAK_CAPVOL Picture PesqPict("DAK","DAK_CAPVOL")  	
	@ li,052 PSAY OemtoAnsi(STR0012) //"PTOS ENTREGA : "
	@ li,067 PSAY (cAliasDAK)->DAK_PTOENT Picture PesqPict("DAK","DAK_PTOENT")  	
	@ li,076 PSAY OemtoAnsi(STR0013) //"VALOR : "                                        
	@ li,084 PSAY (cAliasDAK)->DAK_VALOR Picture PesqPict("DAK","DAK_VALOR")  		
	li++ 
	@ li,000 PSAY OemtoAnsi(STR0014) +DtoC((cAliasDAK)->DAK_DATA) + OemtoAnsi(STR0015) + (cAliasDAK)->DAK_HORA
	li++
	@ li,000 PSAY Replicate('-',limite)        
	li++
		
	cCarga := (cAliasDAK)->DAK_COD+(cAliasDAK)->DAK_SEQCAR

    If !lQuery
	   	(cAliasDAH)->(dbSetOrder(1))
       	(cAliasDAH)->(MsSeek(xFilial("DAH")+cCarga))
    Endif

	While (cAliasDAH)->(!Eof()) .And. (cAliasDAH)->DAH_FILIAL == xFilial("DAH") .And.;
									(cAliasDAH)->DAH_CODCAR+(cAliasDAH)->DAH_SEQCAR == cCarga

		If ( li > 60 )
			li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
			li++
		Endif
	
		If !lQuery
			SA1->(dbSetOrder(1))
			SA1->(MsSeek(xFilial("SA1")+(cAliasDAH)->DAH_CODCLI+(cAliasDAH)->DAH_LOJA))
		Endif

		@ li,000 PSAY (cAliasDAH)->DAH_SEQUEN
		@ li,012 PSAY (cAliasDAH)->DAH_CODCLI
		@ li,020 PSAY (cAliasDAH)->DAH_LOJA
		@ li,026 PSAY SubStr((cAliasSA1)->A1_NOME,1,30)
		@ li,057 PSAY (cAliasDAH)->DAH_HRCHEG                                     		
		@ li,068 PSAY (cAliasDAH)->DAH_TMSERV
		@ li,083 PSAY IntToHora(HoraToint((cAliasDAH)->DAH_HRCHEG,2)+HoraToInt((cAliasDAH)->DAH_TMSERV,4),2)				
		@ li,094 PSAY (cAliasDAH)->DAH_CHGREA
		@ li,103 PSAY (cAliasDAH)->DAH_TMREAL
		@ li,118 PSAY (cAliasDAH)->DAH_SDREAL
		li++
							
		(cAliasDAH)->(dbSkip())
		If lQuery 
			lSkip := .T.
		Endif	

	Enddo
	li:=61
	If !lQuery .Or. !lSkip
		(cAliasDAK)->(dbSkip())	
	Endif	

Enddo

If lQuery
	dbSelectArea(cAliasDAK)
	dbCloseArea()
	dbSelectArea("DAK")
Endif		

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

Set Device To Screen
Set Printer To
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
Endif
MS_FLUSH()
Return(.T.)    
