/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/


#Include "CDAR011.CH"
#Include "FIVEWIN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³  CDAR011 ³ Autor ³ Sueli C. Santos       ³ Data ³ 14/06/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Relacao de Contratos de Direitos Autorais                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CDAR011()

Local oReport

If FindFunction("TRepInUse") .And. TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := ReportDef()
	oReport:PrintDialog()
Else       
	Help("  ",1,"CDAR011TR4",,OEMTOANSI(STR0020),1,0) //"Função disponível apenas em TReport"
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ReportDef ³ Autor ³ Sueli C. Santos       ³ Data ³ 14/06/2007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Definicao do componente                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport 
Local oFornecedor
Local oContrato

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

oReport := TReport():New("CDAR011",OemToAnsi(STR0001),"CDR011",{|oReport| ReportPrint(oReport)},STR0002) //"Imprimirá os dados dos Contratos de Direitos Autorais de acordo com a configuração do usuário."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

Pergunte("CDR011",.F.)

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


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos Fornecedores                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFornecedor := TRSection():New(oReport,STR0001,{"AH1","SA2"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Produtos"
oFornecedor:SetTotalInLine(.F.)

	oFornecedor:SetHeaderSection(.T.)
	TRCell():New(oFornecedor,"FORNECEDOR"      ,     ,/*Titulo*/,/*Picture*/,35,/*lPixel*/,{|| Substr(SA2->A2_NOME,1,35) }) //"Desc Prod" 
	TRCell():New(oFornecedor,"AH1_FORNEC","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_FORNEC})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Sessao dos Contrato                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oContrato := TRSection():New(oFornecedor,STR0001,{"AH1","SB1","SA2","SX5"},/*aOrdem*/,/*Campos do SX3*/,/*Campos do SIX*/) //"Produtos"
oContrato:SetTotalInLine(.F.)   

	oContrato:SetHeaderBreak(.T.)
   	TRCell():New(oContrato,"AH1_FORNEC",,,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_FORNEC})
   	TRCell():New(oContrato,"FORNECEDOR",,,/*Picture*/,35,/*lPixel*/,{|| Substr(SA2->A2_NOME,1,35) }) //"Desc Prod" 
  	TRCell():New(oContrato,"AH1_CONTRA", ,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_CONTRA})
	TRCell():New(oContrato,"AH1_SEQCON","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_SEQCON})
	TRCell():New(oContrato,"AH1_PRODUT","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_PRODUT})
   	TRCell():New(oContrato,"PRODUTO"      ,     ,/*Titulo*/,/*Picture*/,25,/*lPixel*/,{|| Substr(SB1->B1_DESC,1,25) }) //"Desc Prod" 
	TRCell():New(oContrato,"AH1_INICVI","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_INICVI})
	TRCell():New(oContrato,"AH1_DATAFI","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_DATAFI})
	TRCell():New(oContrato,"PERIODO",   ,/*Titulo*/,/*Picture*/,15,/*lPixel*/,{|| Substr(SX5->X5_DESCRI,1,15)})
	TRCell():New(oContrato,"AH1_DIAST","AH1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (cAliasAH1)->AH1_DIAST})
	
 	oBreak := TRBreak():New(oContrato,oContrato:Cell("FORNECEDOR"),"",.T.)
	TRFunction():New(oContrato:Cell("AH1_FORNEC"),NIL,"COUNT",oBreak,STR0018,,/*uFormula*/,.F.,.T.,.F.) 

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Sueli C. Santos        ³ Data ³14/06/2007³±±
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
/*/
Static Function ReportPrint(oReport)
Local oFornecedor := oReport:Section(1)
Local oContrato   := oReport:Section(1):Section(1)

Private cAliasAH1 := "AH1"  
Private cForneced 

cOrder := "%AH1_FILIAL , AH1_FORNEC , AH1_LOJAFO , AH1_PRODUT%"
oReport:SetTitle(STR0001) //"Contrato de Direitos Autorais"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alterando titulo das celulas para impressao     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	 
oFornecedor:SetHeaderSection(.T.)
oFornecedor:Cell("AH1_FORNEC"):SetTitle(STR0011) //"Cod. Fornecedor"
oFornecedor:Cell("FORNECEDOR"):SetTitle(STR0009) //"Cod. Fornecedor"

                       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Alterando titulo das celulas para impressao     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oContrato:Cell("AH1_CONTRA"):SetTitle(STR0010) //"Contrato"
oContrato:Cell("AH1_SEQCON"):SetTitle(STR0019) //"Contrato"
oContrato:Cell("AH1_FORNEC"):SetTitle(STR0009) //"Cod. Fornecedor"
oContrato:Cell("FORNECEDOR"):SetTitle("") //"Fornecedor"
oContrato:Cell("AH1_INICVI"):SetTitle(STR0012) //"Dt Vigencia"
oContrato:Cell("AH1_DATAFI"):SetTitle(STR0013) //"Dt Vencimento"
oContrato:Cell("AH1_PRODUT"):SetTitle(STR0014) //"Cod. Produto"
oContrato:Cell("PRODUTO"):SetTitle("") //"Desc. Produto"
oContrato:Cell("PERIODO"):SetTitle(STR0016) //"Periodo"
oContrato:Cell("AH1_DIAST"):SetTitle(STR0017) //"Dias de Antecedencia de Aviso"


#IFDEF TOP
	
	lQuery    := .T.
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query do relatorio                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):BeginQuery()	

	cAliasAH1 := GetNextAlias()

	BeginSql alias cAliasAH1
		SELECT AH1_CONTRA, AH1_FORNEC, AH1_INICVI, AH1_DATAFI, AH1_PRODUT, AH1_PERIOD,AH1_DIAST, AH1_SEQCON, AH1_LOJAFO
		FROM %table:AH1% AH1 
		WHERE AH1_FILIAL = %xFilial:AH1% 	AND
			  AH1_INICVI >= %Exp:Dtos(mv_par01)%	AND			  
			  AH1_INICVI <= %Exp:Dtos(mv_par02)%	AND		 
			  AH1_DATAFI >= %Exp:Dtos(mv_par03)%	AND
			  AH1_DATAFI <= %Exp:Dtos(mv_par04)%	AND  
			  AH1.%notDel%
	ORDER BY %Exp:cOrder%
	EndSql
	sDebug:= GetLastQuery()[2]
    oReport:Section(1):EndQuery()

#ELSE
	lQuery    := .F.
	dbSelectArea(cAliasAH1)
	dbSetOrder(2)
	
	cCondicao := 'AH1_FILIAL =='+"'"+xFilial()+"'"+' .And. ' 
	cCondicao += 'Dtos(AH1_INICVI) >='+"'"+Dtos(mv_par01)+"'"+' .And. Dtos(AH1_INICVI) <='+"'"+Dtos(mv_par02)+"'"+' .And. '
	cCondicao += 'Dtos(AH1_DATAFI) >='+"'"+Dtos(mv_par03)+"'"+' .And. Dtos(AH1_DATAFI) <='+"'"+Dtos(mv_par04)+"'" 

	oReport:Section(1):SetFilter(cCondicao,IndexKey())
	
#ENDIF

TRPosition():New(oContrato,"SA2",1,{|| xFilial("SA2")+cForneced })

RepPrintCon(oReport)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RepPrintCon³ Autor ³Sueli C. Santos        ³ Data ³14/06/2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do relatorio por ordem de produto                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function RepPrintCon(oReport)
Local oContrato := oReport:Section(1):Section(1)
Local cFornec   := ""   
                                     
oReport:SetMeter(AH1->(LastRec()))

dbSelectArea(cAliasAH1)
dbGotop()


While !oReport:Cancel() .And. !(cAliasAH1)->(Eof())
		
	IF (cAliasAH1)->AH1_CONTRA + (cAliasAH1)->AH1_SEQCON >= mv_par05 + mv_par06 .And.;
			(cAliasAH1)->AH1_CONTRA + (cAliasAH1)->AH1_SEQCON <= mv_par07 + mv_par08

		cForneced := (cAliasAH1)->AH1_FORNEC + (cAliasAH1)->AH1_LOJAFO
		cData   := (cAliasAH1)->AH1_INICVI

		dbSelectArea("SA2")
		dbSeek( xFilial("SA2") + cForneced )
		
		dbSelectArea("SB1")
		dbSeek( xFilial("SB1") + (cAliasAH1)->AH1_PRODUT )
		
		dbSelectArea("SX5")
	    dbSeek( xFilial()+"H3"+(cAliasAH1)->AH1_PERIOD )		

		oContrato:Init()
		
		If cFornec == (cAliasAH1)->AH1_FORNEC
			oContrato:Cell("AH1_FORNEC"):Hide()
			oContrato:Cell("FORNECEDOR"):Hide()
		Else		                           
			oContrato:Cell("AH1_FORNEC"):Show()
			oContrato:Cell("FORNECEDOR"):Show() 
			cFornec := (cAliasAH1)->AH1_FORNEC
		EndIf                                
		
		oContrato:PrintLine()     
	EndIf                  
	       
	dbSelectArea(cAliasAH1)
	dbSkip()
End

oContrato:Finish()
Return
