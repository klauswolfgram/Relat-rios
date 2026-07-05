/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR014.CH"  
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR014  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 01/04/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Cancelamentos da Rotina de Televendas                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Televendas (SUA)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Relatorio Personalizavel									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ANALISTA  ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Danilo Ca.³30/06/06³99186 ³Desenvolvimento relatorio personalizavel R4.³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TMKR014()
Local oReport	:= Nil			// Objeto para geracao do relatorio
Local aArea		:= GetArea()	// Salva a area

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                          ³
//³ Mv_Par01           // Do Atendimento                          ³
//³ Mv_Par02           // Ate o Atendimento                       ³
//³ Mv_Par03           // A Partir de                             ³
//³ Mv_Par04           // Ate o Data                              ³
//³ Mv_Par05           // Do Vendedor                             ³
//³ Mv_Par06           // Ate o Vendedor                          ³
//³ Mv_Par07           // Do Cliente                              ³
//³ Mv_Par08           // Ate o Cliente                           ³
//³ Mv_Par09           // Tipo do Relatorio                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK014",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a area³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea( aArea )

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKR014RptDºAutor  ³Danilo Calil        º Data ³  30/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no relaº±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±³ Fernando ³811   |11/10/06|Foi modificada a funcao ReportDef para   ³±±
±±³			 |		|		 |criacao de string a ser visualizada na opcao³±±
±±³			 |		|		 |Personalizar do relatorio TMKR014           ³±±                               
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport											// Objeto do relatorio
Local oSection1											// Objeto da secao 1	
Local oSection2											// Objeto da secao 2
Local oSection3											// Objeto da secao 3
Local cAlias1		:= "SUA"							// Pega o proximo Alias Disponivel
Local aUA_Oper		:= TkSx3Box("UA_OPER")				// Busca no DD SX3 as opcoes para o campo
Local aUA_TMK		:= TkSx3Box("UA_TMK")				// Busca no DD SX3 as opcoes para o campo
Local aUA_TpFrete	:= TkSx3Box("UA_TPFRETE")			// Busca no DD SX3 as opcoes para o campo
Local oBreak

#IFDEF TOP
	cAlias1		:= GetNextAlias()						// Pega o proximo Alias Disponivel
#ENDIF	

DEFINE REPORT oReport NAME "TMKR014" TITLE STR0001 PARAMETER "TMK014" ACTION {|oReport| TKR014PrtRpt(oReport, cAlias1)} DESCRIPTION STR0001 + STR0002 + STR0003 + STR0004
//ÚÄÄÄÄÄÄÄ¿
//³Secao 1³
//ÀÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0050 TABLES "SUA" //orcamentos

DEFINE CELL NAME "UA_EMISSAO"	OF oSection1 ALIAS "SUA" 

//ÚÄÄÄÄÄÄÄ¿
//³Secao 2³
//ÀÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection2 OF oSection1 TITLE STR0051 TABLES "SUA","SU5","SU7","SA3","SUH","SUO","SU9","SA1","SUS"   //cadastro de orcamento
oSection2:SetLineBreak()

DEFINE CELL NAME "UA_NUM"		OF oSection2 ALIAS "SUA" 
DEFINE CELL NAME "COD_CLI"	 	OF oSection2 TITLE STR0010	SIZE 11 BLOCK {|| PadR((cAlias1)->UA_CLIENTE + " / " + (cAlias1)->UA_LOJA,80)}
DEFINE CELL NAME "RAZAO_CLI"	OF oSection2 TITLE STR0011 	SIZE 22 BLOCK {|| FATPDObfuscate( ;
IIF(!(cAlias1)->UA_PROSPEC,IIF(!Empty((cAlias1)->UA_CLIENTE),SA1->A1_NOME,STR0042),IIF(!Empty((cAlias1)->UA_CLIENTE),SUS->US_NOME,STR0042)),;
IIF(!(cAlias1)->UA_PROSPEC,"A1_NOME","US_NOME"),,.T.) }
DEFINE CELL NAME "UA_CODCONT"	OF oSection2 ALIAS "SUA" 
DEFINE CELL NAME "U5_CONTAT"	OF oSection2 ALIAS "SU5" BLOCK {|| IIF(!Empty((cAlias1)->UA_CODCONT),SU5->U5_CONTAT,STR0043)} //Contato nao localizado
DEFINE CELL NAME "UA_TMK" 		OF oSection2 ALIAS "SUA" BLOCK {|| PadR(IIF(Val((cAlias1)->UA_TMK)>0,aUA_TMK[Val((cAlias1)->UA_TMK)],""),80)} 
DEFINE CELL NAME "UA_OPER" 		OF oSection2 ALIAS "SUA" BLOCK {|| PadR(IIF(Val((cAlias1)->UA_OPER)>0,aUA_Oper[Val((cAlias1)->UA_OPER)],""),80)} 
DEFINE CELL NAME "UA_TPFRETE"	OF oSection2 ALIAS "SUA" BLOCK {|| PadR(IIF(Val((cAlias1)->UA_TPFRETE)>0,aUA_TpFrete[Val((cAlias1)->UA_TPFRETE)],""),80)} 
DEFINE CELL NAME "UA_TABELA"	OF oSection2 ALIAS "SUA" 		
DEFINE CELL NAME "UA_OPERADO"	OF oSection2 ALIAS "SUA" 		
DEFINE CELL NAME "U7_NOME"		OF oSection2 ALIAS "SU7" BLOCK {|| IIF(!Empty((cAlias1)->UA_OPERADO),SU7->U7_NOME,STR0044)} 	//Operador nao localizado		
DEFINE CELL NAME "UA_VEND"		OF oSection2 ALIAS "SUA" 		
DEFINE CELL NAME "A3_NOME"		OF oSection2 ALIAS "SA3" BLOCK {|| IIF(!Empty((cAlias1)->UA_VEND),SA3->A3_NOME,STR0045)}  		//Vendedor nao localizado		
DEFINE CELL NAME "UA_MIDIA"		OF oSection2 ALIAS "SUA" 		
DEFINE CELL NAME "UH_DESC"		OF oSection2 ALIAS "SUH" BLOCK {|| IIF(!Empty((cAlias1)->UA_MIDIA),SUH->UH_DESC,STR0046)} 		//Midia nao localizada  		
DEFINE CELL NAME "UA_CODCAMP"	OF oSection2 ALIAS "SUA" 					
DEFINE CELL NAME "UO_DESC"		OF oSection2 ALIAS "SUO" BLOCK {|| IIF(!Empty((cAlias1)->UA_CODCAMP),SUO->UO_DESC,STR0047)}	//Campanha nao localizada				
DEFINE CELL NAME "UA_CODLIG"	OF oSection2 ALIAS "SUA" 					
DEFINE CELL NAME "U9_DESC"		OF oSection2 ALIAS "SU9" BLOCK {|| IIF(!Empty((cAlias1)->UA_CODLIG),SU9->U9_DESC,STR0048)}		//Ocorrencia nao localizada			
DEFINE CELL NAME "UA_PROXLIG"	OF oSection2 ALIAS "SUA" 					
DEFINE CELL NAME "UA_HRPEND"	OF oSection2 ALIAS "SUA" 					
DEFINE CELL NAME "UA_CODOBS"	OF oSection2 ALIAS "SUA" SIZE 180 BLOCK {|| MSMM(UA_CODOBS)} 					

//ÚÄÄÄÄÄÄÄ¿
//³Secao 3³
//ÀÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection3 OF oSection2 TITLE STR0052 TABLES "SUB","SB1"    //total de itens
oSection3:SetLineBreak()

DEFINE CELL NAME "UB_ITEM" 		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_PRODUTO"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "B1_DESC"		OF oSection3 ALIAS "SB1" 
DEFINE CELL NAME "UB_SITPROD"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_QUANT"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_VRUNIT"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_VLRITEM"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_DESC"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_VALDESC"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_ACRE"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_VALACRE"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_TES"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_CF"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_PRCTAB"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_BASEICM"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_LOCAL"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_UM"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_DTENTRE"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_LOTE"		OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_SUBLOTE"	OF oSection3 ALIAS "SUB" 
DEFINE CELL NAME "UB_DTVALID"	OF oSection3 ALIAS "SUB" 
                            
DEFINE BREAK oBreak OF oSection1 WHEN oSection2:Cell("UA_NUM")
oBreak:SetTotalInLine(.T.)		// Imprime total em linha ou coluna (default .T. - linha )
                                
//"Total de atendimentos cancelados no dia "
DEFINE FUNCTION FROM oSection2:Cell("UA_NUM") FUNCTION COUNT BREAK oBreak NO END SECTION NO END REPORT TITLE STR0033
//"Total de atendimentos cancelados no periodo"
DEFINE FUNCTION FROM oSection2:Cell("UA_NUM") FUNCTION COUNT  NO END SECTION TITLE PadR(STR0036 + DtoC(Mv_Par03) + " a " + DtoC(Mv_Par04),70)

Return oReport                                 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR014PrtºAutor  ³Danilo Calil        º Data ³  10/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TKR014PrtRpt(oReport, cAlias1)
Local cQuery		:= "%%"								// Primeira Query
Local oSection1		:= oReport:Section(1)		   		// Define a secao 1 do relatorio
Local oSection2		:= oSection1:Section(1)				// Define que a secao 2 serah filha da secao 1
Local oSection3     := oSection2:Section(1)				// Define que a secao 3 serah filha da secao 1

DbSelectArea("SUA")
DbSetOrder(4)		

If Mv_Par09 <> 4
	cQuery:= "%SUA.UA_OPER = '" + Str(Mv_Par09,1) + "' AND%"	
EndIf    

MakeSqlExpr("TMKR014")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BEGIN REPORT QUERY oSection1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query da secao 1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BeginSql alias cAlias1
	SELECT	UA_EMISSAO,  UA_NUM,    UA_CLIENTE,  UA_LOJA,  
			UA_PROSPEC,  UA_CODCONT,UA_TMK,      UA_OPER,
			UA_TPFRETE,  UA_TABELA, UA_OPERADO,  UA_VEND,
			UA_MIDIA,    UA_CODCAMP,UA_CODLIG,   UA_PROXLIG,
			UA_HRPEND,   UA_CODOBS, UB_ACRE,     UB_BASEICM,
			UB_CF,       UB_DESC,   UB_DTENTRE,  UB_DTVALID,				
			UB_FILIAL,   UB_ITEM,   UB_LOCAL,    B1_DESC,				
			UB_LOTE,     UB_NUM,    UB_PRCTAB,   UB_PRODUTO,
			UB_QUANT,    UB_SITPROD,UB_SUBLOTE,  UB_TES, 
			UB_UM,       UB_VALACRE,UB_VALDESC,  UB_VLRITEM, 
			UB_VRUNIT
	FROM %table:SUA% SUA,%table:SUB% SUB,%table:SB1% SB1
	WHERE	SUA.UA_FILIAL	= %xfilial:SUA%                                    	  	AND 
			SUA.UA_NUM BETWEEN %exp:mv_par01% AND %exp:mv_par02% 				  	AND
			SUA.UA_EMISSAO BETWEEN %exp:DtoS(mv_par03)% AND %exp:DtoS(mv_par04)% 	AND
			SUA.UA_VEND	   BETWEEN %exp:mv_par05% AND %exp:mv_par06%    			AND				
			SUA.UA_CLIENTE BETWEEN %exp:mv_par07% AND %exp:mv_par08%				AND				
			SUA.UA_CANC     = %exp:'S'%												AND
			SUB.UB_FILIAL	= %xfilial:SUB% 									  	AND
			SUB.UB_NUM      = SUA.UA_NUM		 									AND
			SB1.B1_FILIAL	= %xfilial:SB1%											AND
			SB1.B1_COD      = SUB.UB_PRODUTO										AND
			%exp:cQuery%     
			SUA.%notDel%														  	AND
			SUB.%notDel%				     										AND
			SB1.%notDel%				     

	ORDER BY %Order:SUA%
EndSql

END REPORT QUERY oSection1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Baseada na query da secao1, utiliza filtro para saber quando deve sair do laco de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2:SetParentQuery()
oSection2:SetParentFilter( { | cParam | (cAlias1)->UA_EMISSAO == cParam},{|| (cAlias1)->UA_EMISSAO } )

oSection3:SetParentQuery()
oSection3:SetParentFilter( { | cParam | (cAlias1)->UB_NUM == cParam},{|| (cAlias1)->UA_NUM } )

oSection1:SetHeaderSection(.T.)		//Define que o header vai ser apresentado

TRPosition():New(oSection2,"SA1",1,{|| xFilial("SA1") + (cAlias1)->UA_CLIENTE + (cAlias1)->UA_LOJA })  
TRPosition():New(oSection2,"SUS",1,{|| xFilial("SUS") + (cAlias1)->UA_CLIENTE + (cAlias1)->UA_LOJA })  
TRPosition():New(oSection2,"SU5",1,{|| xFilial("SU5") + (cAlias1)->UA_CODCONT })  
TRPosition():New(oSection2,"SU7",1,{|| xFilial("SU7") + (cAlias1)->UA_OPERADO })  
TRPosition():New(oSection2,"SA3",1,{|| xFilial("SA3") + (cAlias1)->UA_VEND })  
TRPosition():New(oSection2,"SUH",1,{|| xFilial("SUH") + (cAlias1)->UA_MIDIA })  
TRPosition():New(oSection2,"SUO",1,{|| xFilial("SUO") + (cAlias1)->UA_CODCAMP })  
TRPosition():New(oSection2,"SU9",1,{|| xFilial("SU9") + (cAlias1)->UA_CODLIG })  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:Print()

Return Nil


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 22/01/2020
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 22/01/2020
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive