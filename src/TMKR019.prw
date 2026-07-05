/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR019.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR019  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 09/03/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analise do Telemarketing pelo Tipo de Comunicacao          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ TeleMarketing (SUC)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 indice 1     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Thiago G  ³14/07/04³811   ³Inclusao do cabecalho padrao e alteracao das³±±
±±³          ³        ³      ³totalizacoes.                               ³±±
±±³Michel W. ³15/08/06³99190 ³Atualizacao para relatorio release 4.       ³±±
±±³Michel W. ³21/08/06³99190 ³Revisao do fonte.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/               
User Function TMKR019()
Local oReport	//Objeto relatorio TReport (Release 4)
Local aPDFields := {"U7_NOME","U5_CONTAT","U5_FONE","U5_EMAIL","A1_NOME","A1_END","A1_BAIRRO","A1_MUN","A1_EST"}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK019",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Da Data                                ³
//³ Mv_Par02           // Ate a Data                             ³
//³ Mv_Par03           // Tipo de Comunicacao                    ³
//³ Mv_Par04           // Operador                               ³
//³ Mv_Par05           // Produto                                ³
//³ Mv_Par06           // Tipo de Produto                        ³
//³ Mv_Par07           // Status da Ligacao                      ³
//³ Mv_Par08           // Do CEP                                 ³
//³ Mv_Par09           // Ate o CEP                              ³
//³ Mv_Par10           // Rotina  Ativo/Receptivo/Ambas          ³
//³ Mv_Par11 	       // Segmento 1             ?               ³
//³ Mv_Par12 	       // Segmento 2             ?               ³
//³ Mv_Par13 		   // Segmento 3             ?               ³
//³ Mv_Par14		   // Segmento 4             ?               ³
//³ Mv_Par15	       // Segmento 5             ?               ³
//³ Mv_Par16           // Segmento 6             ?               ³
//³ Mv_Par17           // Segmento 7             ?               ³
//³ Mv_Par18           // Segmento 8             ?               ³
//³ Mv_Par19           // Entidade               ?               ³
//³ Mv_Par20           // Contato                ?               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FATPDLoad(Nil,Nil,aPDFields)
oReport := ReportDef()
oReport:PrintDialog() 
FATPDUnload()  

Return(.T.)
	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Tk019ValidºAutor  ³Armando M. Tessaroliº Data ³  25/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida os itens do atendimento de acordo com os parametro   º±±
±±º          ³informado para validar se o atendimento sera impresso ou naoº±±
±±º          ³Valida tambem os itens que serao impressos para o           º±±
±±º          ³atendimento selecionado.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR019                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Tk019Valid(cSUC, cSUD)

Local aArea	:= GetArea()		// Salva a area atual
Local lRet	:= .F.				// Retorno da funcao

DbSelectArea(cSUD)
DbSetOrder(1)
If DbSeek(xFilial(cSUD)+(cSUC)->UC_CODIGO)
	While	(!Eof())									.AND.;
			(cSUD)->UD_FILIAL == xFilial(cSUC)			.AND.;
			(cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o produto informado                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par05) .AND. (cSUD)->UD_PRODUTO <> Mv_Par05
			(cSUD)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o tipo de produto informado                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par06)
			DbSelectArea("SB1")
			DbSetOrder(1)
			If DbSeek(xFilial("SB1")+(cSUD)->UD_PRODUTO)
				If Trim(SB1->B1_TIPO) <> Trim(Mv_Par06)
					DbSelectArea(cSUD)
					(cSUD)->(DbSkip())
					Loop
				Endif
			Endif
		Endif
	
		lRet := .T.
		Exit
	End
Endif

RestArea(aArea)

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³Michel W. Mosca     ³ Data ³15/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Tipo de comunicacao   no release 4.                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±³ Fernando ³811   |11/10/06|Foi modificada a funcao ReportDef para   ³±±
±±³			 |		|		 |criacao de string a ser visualizada na opcao³±±
±±³			 |		|		 |Personalizar do relatorio TMKR019           ³±±                               
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()
Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2             //Secao com itens relacionados ao atendimento
Local oSection3             //Secao com totalizadores do relatorio
Local oSection4             //Secao com totalizadores do relatorio
Local oSection5             //Secao com totalizadores do relatorio
Local oSection6             //Secao com totalizadores do relatorio
Local cSUC := "SUC"     	//Alias da consulta Embedded SQL
Local cSUD := "SUD"
Local aCampos		:= {}						// Campos do alias principal para select
Local aDescCab      :={}
Local aDesc      :={}
Local aUC_Status	:= TkSx3Box("UC_STATUS")		// Busca no dd SX3 as opcoes para o campo
Local aUD_Status	:= TkSx3Box("UD_STATUS")		// Busca no dd SX3 as opcoes para o campo


#IFDEF TOP
	cSUC	:= GetNextAlias()						// Pega o proximo Alias Disponivel	
	cSUD	:= cSUC	
#ENDIF                   

aCampos		:= {"UC_DATA"		,"UC_CODCONT"	,"UC_CODIGO"	,;
   				"U5_FCOM1"		,"UC_OPERADO"	,"U5_EMAIL"		,;
   				"UC_OPERACA"	,"UC_ENTIDAD"	,"UC_TIPO"		,;
   				"UC_DESCCHA"	,"UC_MIDIA"		,"A1_TEL"		,;
   				"UC_CODCAMP"	,"A1_END"		,"UC_STATUS"	,;
   				"A1_BAIRRO"		,"UC_PENDENT"	,"A1_MUN"		,;
   				"UC_HRPEND"		,"A1_EST"		,"UC_OBS"		,;
   				"UC_DTENCER"	,"UC_DIASDAT"	,"UC_OBSMOT"	,;	
   				"UC_DESCCAM"}
aDescCab	:= TkTitX3(aCampos)	 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Comeca a imprimir os items do atendimento            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCampos		:= {"UD_ITEM"		,"UD_ASSUNTO"	,"UD_PRODUTO"	,;
				"UD_OCORRENCIA"	,"UD_SOLUCAO"	,"UD_OPERADO"	,;
				"UD_DATA"		,"UD_STATUS"	,"UD_DTEXEC"	,;
				"UD_OBS"		,"UD_OBSEXEC"}
aDesc		:= TkTitX3(aCampos)        
        

// "Telemarketing - Tipo de Comunicacao" # // "Este programa ira emitir uma relacao dos tipos de comunicacoes utilizadas pelo operador"
// "As totalizacoes serao apresentadas por dia e um total geral na ultima pagina do relatorio"
DEFINE REPORT oReport NAME "TMKR019" TITLE STR0004 PARAMETER "TMK019" ACTION {|oReport| Tkr019PrtRpt( oReport, cSUC, cSUD )} DESCRIPTION STR0005 + 	STR0006

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport TITLE STR0028 TABLES "SUC"         //Telemarketing
DEFINE SECTION oSection2 OF oSection1 TITLE STR0029 TABLES "SUD"       //Itens do Telemarketing
DEFINE SECTION oSection3 OF oReport TITLE STR0023                      // Tipo de comunicacao
DEFINE SECTION oSection4 OF oReport TITLE STR0027                      // Periodo
DEFINE SECTION oSection6 OF oReport TITLE STR0030                      //Operadores Ativo/Passivo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ            
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime os dados do cabecalho do script dinamico.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DEFINE CELL NAME "UC_DATA" OF oSection1 Alias "SUC"
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCONT + " - " + FATPDObfuscate(TkDadosContato((cSUC)->UC_CODCONT,0),"U5_CONTAT")} TITLE aDescCab[2][1] SIZE 50
DEFINE CELL NAME "UC_CODIGO" OF oSection1 Alias "SUC"		
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(Transform( TkDadosContato((cSUC)->UC_CODCONT,8) + TkDadosContato((cSUC)->UC_CODCONT,4) , "@R (99)9999-9999"),"U5_FONE")} TITLE aDescCab[4][1] SIZE 15	
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME")} TITLE aDescCab[5][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkDadosContato((cSUC)->UC_CODCONT,10),"U5_EMAIL")} TITLE aDescCab[6][1] SIZE 50	
DEFINE CELL NAME "UC_OPERACA" OF oSection1 Alias "SUC"
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Posicione("SX5",1,xFilial("SX5")+"T5"+(cSUC)->UC_ENTIDAD,"X5DESCRI()")} TITLE aDescCab[8][1] SIZE 50			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_TIPO  + " - " + Posicione("SUL",1,xFilial("SUL")+(cSUC)->UC_TIPO,"UL_DESC")} TITLE aDescCab[9][1] SIZE 50 
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,1),"A1_NOME")} TITLE aDescCab[10][1]	SIZE 120
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH")+(cSUC)->UC_MIDIA,"UH_DESC")} TITLE aDescCab[11][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(Transform(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,9)+TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,6) , "@R (99)9999-9999"),"A1_NOME")} TITLE aDescCab[12][1] SIZE 15
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCAMP + " - " + Posicione("SUO",1,xFilial("SUO")+(cSUC)->UC_MIDIA,"UO_DESC")} TITLE aDescCab[13][1] SIZE 50
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,2),"A1_END")} TITLE aDescCab[14][1] SIZE 40 	
DEFINE CELL NAME "UC_STATUS" OF oSection1 Alias "SUC" BLOCK{||IIF(!Empty((cSUC)->UC_STATUS),aUC_Status[Val((cSUC)->UC_STATUS)],"")} TITLE aDescCab[15][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,10),"A1_BAIRRO")} TITLE aDescCab[16][1] SIZE 40			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||DTOC((cSUC)->UC_PENDENT) + " - " + (cDia:= Tk_DiaSemana((cSUC)->UC_PENDENT,Nil,Nil))} TITLE aDescCab[17][1] SIZE 30
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,3),"A1_MUN")} TITLE aDescCab[18][1] SIZE 120			
DEFINE CELL NAME "UC_HRPEND" OF oSection1 Alias "SUC"  
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,4),"A1_EST")} TITLE aDescCab[20][1] SIZE 10						
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||MSMM((cSUC)->UC_CODOBS, 200)} TITLE aDescCab[21][1] SIZE 200	

	    
DEFINE CELL NAME "UD_ITEM" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_ASSUNTO),Posicione("SX5",1,xFilial("SX5")+"T1"+(cSUD)->UD_ASSUNTO,"X5DESCRI()"),STR0012)} TITLE aDesc[2][1] SIZE 30						
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_PRODUTO),	Posicione("SB1",1,xFilial("SB1")+(cSUD)->UD_PRODUTO,"B1_DESC"),STR0012)} TITLE aDesc[3][1] SIZE 30			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_OCORREN),Posicione("SU9",1,xFilial("SU9")+(cSUD)->UD_ASSUNTO+(cSUD)->UD_OCORREN,"U9_DESC"),STR0012)} TITLE aDesc[4][1] SIZE 50			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_SOLUCAO),Posicione("SUQ", 1, xFilial("SUQ")+(cSUD)->UD_SOLUCAO, "UQ_DESC"),STR0012)} TITLE aDesc[5][1] SIZE 30 			
DEFINE CELL NAME "S2_USR" OF oSection2 ALIAS "SUD" TITLE aDesc[6][1] SIZE 40			
DEFINE CELL NAME "UD_DATA" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_STATUS),aUD_Status[Val((cSUD)->UD_STATUS)],"")} TITLE aDesc[8][1] SIZE 20			
DEFINE CELL NAME "UD_DTEXEC" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "UD_OBS" OF oSection2 ALIAS "SUD" 			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||MSMM((cSUD)->UD_CODEXEC,200)} TITLE aDesc[11][1] SIZE 200			
	

DEFINE CELL NAME "S3_TPCOMUN" OF oSection3 TITLE STR0023 SIZE 50   
DEFINE CELL NAME "S3_ATIVO" OF oSection3 TITLE STR0024 SIZE 10
DEFINE CELL NAME "S3_PERC_AT" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_RECEP" OF oSection3 TITLE STR0025 SIZE 10
DEFINE CELL NAME "S3_PERC_RP" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_TOT" OF oSection3 TITLE STR0016 SIZE 10
DEFINE CELL NAME "S3_PERC_TOT" OF oSection3 TITLE "%" SIZE 10			

DEFINE CELL NAME "S4_DATA"  OF oSection4 TITLE STR0027 SIZE 9
DEFINE CELL NAME "S4_OPER" OF oSection4 TITLE STR0026 SIZE 50			
DEFINE CELL NAME "S4_ATIVO" OF oSection4 TITLE STR0024 SIZE 10
DEFINE CELL NAME "S4_RECEP" OF oSection4 TITLE STR0025 SIZE 10
DEFINE CELL NAME "S4_TOT" 	OF oSection4 TITLE STR0016 SIZE 10


DEFINE CELL NAME "S6_OPER" OF oSection6 TITLE STR0026 SIZE 40
DEFINE CELL NAME "S6_ATIVO" OF oSection6 TITLE STR0024 SIZE 10
DEFINE CELL NAME "S6_RECEP" OF oSection6 TITLE STR0025 SIZE 10
DEFINE CELL NAME "S6_TOT" OF oSection6 TITLE STR0016 SIZE 10



Return(oReport)                    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr019PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³15/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Tipo de comunicacao    release 4.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr019PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query atual                               ³±±
±±³          ³ ExpC3 = alias da query atual                               ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr019PrtRpt(oReport, cSUC, cSUD)
Local oSection1 := oReport:Section(1)             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2 := oSection1:Section(1)             //Secao com itens relacionados ao atendimento
Local oSection3 := oReport:Section(2)             //Secao com totalizadores do relatorio    
Local oSection4 := oReport:Section(3)             //Secao com totalizadores do relatorio    
Local oSection6 := oReport:Section(4)             //Secao com totalizadores do relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cCep     		:= ""							// Apoio
Local cData			:= ""							// Apoio
Local cCodSUC		:= ""							// Gerencia o alias para tratamento do top e dbf
Local cCodSUD		:= ""							// Gerencia o alias para tratamento do top e dbf
Local aTotData		:= {}							// Guarda as totalizacoes
Local aTotGer		:= {}							// Guarda as totalizacoes
Local aTotOper		:= {}							// Guarda as totalizacoes
Local dData			:= CtoD("  /  /  ")				// Trata a quebra por data
Local nI			:= 0							// Controle
Local nPos			:= 0							// Ponteiro da pesquisa no array
Local nPosTot		:= 0							// Ponteiro da pesquisa no array de totais.
Local cDesc			:= ""							// Variavel de auxilio 
Local cDescPro		:= ""							// Variavel de auxilio 
Local cDescOco		:= ""							// Variavel de auxilio 
Local cDescAss		:= "" 							// Variavel de auxilio 
Local cDescSol		:= ""							// Variavel de auxilio 
Local aCampos		:= {}							// Array com os Campos utilizados como descricao
Local aDescCab		:= {}               			// Descricao dos campos do cabecalho
Local aDesc			:= {}               			// Descricao dos campos dos items

#IFDEF TOP
	Local aSetField		:= {}						// Parametros para SetField do alias principal
	Local cCampos		:= ""						// Campos do alias principal para select
	Local cQuery		:= ""						// Armazena a expressao da query para top
	Local cWhere		:= ""						// Validacao do segmento de negocio para top
	Local cTable	 	:= ""
#ENDIF

TRFunction():New(oSection1:Cell("UC_CODIGO"),/* cID */,"COUNT",/*oBreak*/,;
				STR0008 + DtoC(Mv_Par01) + STR0009 + DtoC(Mv_Par02),;		//"Total de atendimentos computados para o periodo de ",  " a "
				/*cPicture*/,/*uFormula*/,.F./*lEndSection*/,/*lEndReport*/,/*lEndPage */)
				
//Ajusta os campos a serem visualizados dos totalizadores conforme os parametros informados
If Mv_Par10 <> 3 // Ambos
	oSection3:Cell("S3_TOT"):Disable()
	oSection3:Cell("S3_PERC_TOT"):Disable()
	If Mv_Par10 == 1 // Ativo
		oSection3:Cell("S3_RECEP"):Disable()
		oSection3:Cell("S3_PERC_RP"):Disable()
	Else
		oSection3:Cell("S3_ATIVO"):Disable() 
		oSection3:Cell("S3_PERC_AT"):Disable()
	EndIf
Endif

//Ajusta os campos a serem visualizados dos totalizadores conforme os parametros informados
If Mv_Par10 <> 3 // Ambos
	oSection4:Cell("S4_TOT"):Disable()
	If Mv_Par10 == 1 // Ativo
		oSection4:Cell("S4_RECEP"):Disable()
	Else
		oSection4:Cell("S4_ATIVO"):Disable()
	EndIf
Endif                                                                                      

//Ajusta os campos a serem visualizados dos totalizadores conforme os parametros informados
If Mv_Par10 <> 3
	oSection6:Cell("S6_TOT"):Disable()                
	If Mv_Par10 == 1 // Ativo
		oSection6:Cell("S6_RECEP"):Disable()
	Else                                
		oSection6:Cell("S6_ATIVO"):Disable()
	EndIf
Endif	


#IFDEF TOP 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("TMKR019")      
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Chamo a funcao que monta a parte da query para validar os segmentos de negocios³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (Mv_Par19 == "SA1") .OR. (Mv_Par19 == "SUS")
		TKSegmento(	Mv_Par11,	Mv_Par12,	Mv_Par13,	Mv_Par14,;
					Mv_Par15,	Mv_Par16,	Mv_Par17,	Mv_Par18,;
					Mv_Par19,	NIL		,	@cWhere)
	Endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Implementa na query a validacao dos segmentos de negocios³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cTable = "%"	
	If !Empty(cWhere)
		cTable += ", " + RetSqlName(Mv_Par19) + " " + Mv_Par19
	Endif
	
	If !Empty(Mv_Par06)
		cTable += ", " + RetSqlName("SB1") + " SB1"
	Endif       
	cTable += "%"
	
	cQuery +=	"% 		SUC.UC_FILIAL = '" + xFilial("SUC") + "' AND" +;
				"		SUC.UC_CODCANC = '' AND"
	
	If Mv_Par10 <> 3	// Ambos
		cQuery += "		(SUC.UC_OPERACA = '" + IIF(Mv_Par10==1,"2","1") + "' OR"	// ATIVO, RECEPTIVO
		cQuery += "		SUC.UC_OPERACA = '') AND"
	Endif
	
	cQuery += "		SUC.UC_DATA BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND"

	If ! Empty(Mv_Par03)	// Tipo de comunicacao
		cQuery += "		SUC.UC_TIPO = '" + Trim(Mv_Par03) + "' AND"
	Endif
	
	If !Empty(Mv_Par04)
		cQuery += "		SUC.UC_OPERADO = '" + Mv_Par04 + "' AND"
	Endif
	
	If (Mv_Par07 <> 1)  // Todas as licacoes
		cQuery += "		SUC.UC_STATUS = '" + Str(Mv_Par07-1,1) + "' AND"
	Endif
	
	If !Empty(Mv_Par20)
		cQuery += "		SUC.UC_CODCONT = '" + Mv_Par20 + "' AND"
	Endif
	
	If !Empty(Mv_Par19)
		cQuery += "		SUC.UC_ENTIDAD = '" + Mv_Par19 + "' AND"
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Seleciono somente chamados que nao sao compartilhamento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cQuery += " 	SUC.UC_CHAORIG = '' AND"
	
	cQuery +=	"		SUD.UD_FILIAL = '" + xFilial("SUD") + "' AND" +;
				"		SUD.UD_CODIGO = SUC.UC_CODIGO AND"
	
	If !Empty(Mv_Par05)
		cQuery += "		SUD.UD_PRODUTO = '" + Mv_Par05 + "' AND"
	Endif
	
	If !Empty(Mv_Par06)
		cQuery +=	"	SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND" +;
					"	SB1.B1_COD = SUD.UD_PRODUTO AND" +;
					"	SB1.B1_TIPO = '" + Trim(Mv_Par06) + "' AND" +;
					"	SB1.D_E_L_E_T_ = ' ' AND"
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Implementa na query a validacao dos segmentos de negocios³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cWhere)
		cQuery += " " + cWhere + " AND "
	Endif
	
	cQuery +=	"		SUD.D_E_L_E_T_ = ' ' AND"
	cQuery +=	"		SUC.D_E_L_E_T_ = ' ' %"
	

	BEGIN REPORT QUERY oSection1
 	BeginSQL alias cSUC
		SELECT	UC_DATA, 		UC_CODCONT, 		UC_CODIGO, 		UC_OPERADO, 
				UC_OPERACA, 	UC_ENTIDAD, 		UC_TIPO, 		UC_CHAVE, 
				UC_MIDIA, 		UC_CODCAMP, 		UC_PENDENT, 	UC_HRPEND, 
				UC_CODOBS, 		UC_DTENCER, 		UC_CODENCE, 	UC_CODMOT,
				UC_FILIAL, 		UC_CODCANC, 		UC_STATUS, 
				UD_ASSUNTO, 	UD_PRODUTO, 		UD_OCORREN, 	UD_SOLUCAO, 
				UD_OPERADO, 	UD_DATA, 			UD_STATUS,		UD_DTEXEC, 
				UD_OBS, 		UD_CODEXEC, 		UD_CODIGO, 		UD_ITEM 
		FROM 	%table:SUC% SUC, %table:SUD% SUD %exp:cTable%
		WHERE	%exp:cQuery%
		ORDER BY %order:SUC%    
    EndSql    
	END REPORT QUERY oSection1 
	
	oSection2:SetParentQuery()
	
#ELSE 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("TMK019")       		
	DbSelectArea(cSUC)
	DbSetOrder(3)
	oReport:SetMeter(RecCount())
	DbSeek(xFilial("SUC")+DtoS(Mv_Par01),.T.)		//Operador
		
	
#ENDIF 

oSection1:Init()     
oSection1:SetLineStyle()
	
While	(!Eof())							.AND.;
		(cSUC)->UC_FILIAL == xFilial("SUC")	.AND.;
		(cSUC)->UC_DATA >=	Mv_Par01		.AND.;
		(cSUC)->UC_DATA <=	Mv_Par02
	
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Carrega o CEP da entidade gravada no atendimento     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCep := TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,5)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona o intervalo do CEP Exceto Concorrente que nao tem CEP  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( TRIM(cCep) < TRIM(Mv_Par08) ) .OR. ( TRIM(cCep) > TRIM(Mv_Par09) )
		(cSUC)->(DbSkip())
		Loop
	Endif
	
	#IFNDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao seleciono as ligacoes canceladas                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CODCANC)
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona as ligacoes de acordo com o parametro RECEPTIVO/ATIVO/AMBOS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par10 <> 3 //Ambos  (Nao sera validado o Tipo de Ligacao para a impressao)
			If Mv_Par10 == 1  //Ativo    
			
				If ( Val((cSUC)->UC_OPERACA) <> ATIVO )  .OR. ( Empty((cSUC)->UC_OPERACA) ) //"2"
					(cSUC)->(DbSkip())
					Loop
				Endif
				
			Else           	  //Receptivo

				If ( Val((cSUC)->UC_OPERACA) <> RECEPTIVO ) .OR. ( Empty((cSUC)->UC_OPERACA) ) //"1"
					(cSUC)->(DbSkip())
					Loop
				Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o tipo de comunicacao informado                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !Empty(Mv_Par03) ) .AND. ( TRIM((cSUC)->UC_TIPO) <> TRIM(Mv_Par03) )
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o operador informado                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !Empty(Mv_Par04) ) .AND. ( (cSUC)->UC_OPERADO <> Mv_Par04 )
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o status da ligacao informado                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (Mv_Par07 <> 1)  // Todas
			Do Case
				Case Mv_Par07 == 2 // Planejada
					If Val((cSUC)->UC_STATUS) <> PLANEJADA //"1"
						(cSUC)->(DbSkip())
						Loop
					Endif
					
				Case Mv_Par07 == 3 // Pendente
					If Val((cSUC)->UC_STATUS) <> PENDENTE //"2"
						(cSUC)->(DbSkip())
						Loop
					Endif
					
				Case Mv_Par07 == 4 // Encerrada
					If Val((cSUC)->UC_STATUS) <> ENCERRADA //"3"
						(cSUC)->(DbSkip())
						Loop
					Endif
			EndCase
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Permite a impressao somente do contato informado         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !Empty(Mv_Par20) ) .AND. ( (cSUC)->UC_CODCONT <> Mv_Par20 )
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Permite a impressao somente da entidade informada        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !Empty(Mv_Par19) ) .AND. ( (cSUC)->UC_ENTIDAD  <> Mv_Par19 )
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifico os parametros referentes aos itens do atendimento ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !U_Tk019Valid(cSUC, cSUD)
			(cSUC)->(DbSkip())  
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Chamo a funcao que valida os segmentos de negocios³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (Mv_Par19 == "SA1") .OR. (Mv_Par19 == "SUS")
			If !TKSegmento(	Mv_Par11,	Mv_Par12,	Mv_Par13,	Mv_Par14,;
							Mv_Par15,	Mv_Par16,	Mv_Par17,	Mv_Par18,;
							Mv_Par19,	(cSUC)->UC_CHAVE)
				(cSUC)->(DbSkip())
				Loop
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao seleciono chamados que sao compartilhamentos         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CHAORIG)
			(cSUC)->(DbSkip())
			Loop
		EndIf
		
	#ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Comeca a imprimir o relatorio neste ponto³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cCodSUC <> (cSUC)->UC_CODIGO
		If cCodSUC <> "" 
			oSection2:Finish()	
			oReport:EndPage()			
		EndIf 
		cCodSUC := (cSUC)->UC_CODIGO
		oSection1:PrintLine()		
		oReport:ThinLine()
		oReport:SkipLine()
		oSection2:Init()  
		oSection2:SetLineStyle()
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento por Tipo de Comunicacao.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotGer, {|x| x[1]=="TIPO"} )
		If nPosTot == 0
		    If VAL((cSUC)->UC_OPERACA) == RECEPTIVO		// Acumula os totais de atendimentos repcetivos
				AAdd(aTotGer, { "TIPO" 	,; 				// Auxilio
								1 		,; 				// Total das Ligacoes
								1 		,; 				// Total Receptivo
								0 }) 					// Total Ativo    
			ElseIf VAL((cSUC)->UC_OPERACA) == ATIVO		// Acumula os totais de atendimentos ativos
				AAdd(aTotGer, { "TIPO" 	,; 				// Auxilio
								 1 		,; 				// Total das Ligacoes
								 0 		,; 				// Total Receptivo
								 1 }) 					// Total Ativo
			Endif
		Else
			aTotGer[nPosTot][2]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 
				aTotGer[nPosTot][3]++
			ElseIf VAL ( (cSUC)->UC_OPERACA ) == ATIVO
				aTotGer[nPostot][4]++
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento por Tipo de Comunicacao.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotGer, {|x| x[1]==(cSUC)->UC_TIPO} )

		If nPos == 0
		
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 	// Ligacao Receptiva 
				AAdd(aTotGer, { (cSUC)->UC_TIPO	,;		// Tipo da Ligacao   
								 1 				,;		// Total das Ligacoes
								 1 				,;		// Total Receptivo
								 0 } ) 					// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa                     
				AAdd(aTotGer, { (cSUC)->UC_TIPO,;		// Tipo da Ligacao   
								 1 				,;		// Total das Ligacoes
								 0 				,;		// Total Receptivo
								 1 } ) 					// Total Ativo
			Endif
		Else     
			aTotGer[nPos][2]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotGer[nPos][3]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotGer[nPos][4]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes gerais do atendimento por Data e por Operador.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotData, {|x| x[1]=="DATA"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO	// Ligacao Receptiva 
				AAdd(aTotData,{	"DATA" 		,;			// Auxilio
				 				"CODOPER" 	,;   		// Auxilio
								"OPERADOR" 	,;   		// Auxilio
								1 			,;   		// Total das Ligacoes
								1 			,;   		// Total Receptivo
								0 }	)		 			// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa                     
				AAdd(aTotData, { "DATA" 	,;			// Auxilio
								 "CODOPER" 	,;   		// Auxilio
								 "OPERADOR" ,;   		// Auxilio
								  1 		,;   		// Total das Ligacoes
								  0 		,;   		// Total Receptivo
								  1 } )			 		// Total Ativo         
			Endif
		Else
			aTotData[nPosTot][4]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotData[nPosTot][5]++                                     
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotData[nPosTot][6]++
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento por Data e por Operador.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos := Ascan(aTotData, {|x| x[1]==DtoS((cSUC)->UC_DATA)} )
		If nPos == 0
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotData, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
								 (cSUC)->UC_OPERADO 											,;	// Codigo do Operador
								 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME")	,;	// Nome do Operador
								 1 																,;	// Total das Ligacoes
								 1 																,;  // Total Receptivo
								 0 })  																// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotData, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
								 (cSUC)->UC_OPERADO 											,;	// Codigo do Operador
								 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME")	,;	// Nome do Operador
								 1 																,;	// Total das Ligacoes
								 0 																,;  // Total Receptivo
								 1 })  																// Total Ativo
			Endif
		Else
			nPos := Ascan(aTotData, {|x| x[1]== DtoS((cSUC)->UC_DATA) .AND. x[2]==(cSUC)->UC_OPERADO })
			If nPos = 0
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					AAdd(aTotData, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME") , 1 , 1 , 0 } )
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					AAdd(aTotData, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME") , 1 , 0 , 1 } )
				Endif
			Else    
				aTotData[nPos][4]++
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					aTotData[nPos][5]++
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					aTotData[nPos][6]++
				Endif
			Endif
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Totalizacoes especificas do atendimento por Operador.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPosTot := Ascan(aTotOper, {|x| x[1]==(cSUC)->UC_OPERADO})
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotOper, { (cSUC)->UC_OPERADO 											,; // Codigo do Operador
				 				 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME")	,; // Nome do Operador
				  				 1 																,; // Total das Ligacoes
							  	 1 																,; // Total Receptivo
								 0 	} ) 														   // Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa			
				AAdd(aTotOper, { (cSUC)->UC_OPERADO 											 ,; // Codigo do Operador
				 				 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME") ,; // Nome do Operador
				  				 1 																 ,; // Total das Ligacoes
								 0 																 ,; // Total Receptivo 
								 1 } ) 														   		// Total Ativo
			Endif
		Else
			aTotOper[nPosTot][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotOper[nPosTot][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotOper[nPosTot][5]++
			Endif
		Endif
		
	Endif
	
	#IFNDEF TOP
		DbSelectArea(cSUD)
		DbSetOrder(1)
		DbSeek(xFilial(cSUD) + (cSUC)->UC_CODIGO)
		While	(!Eof()) .AND. (cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
	#ENDIF                                                           
			PswOrder(1)
			aUser := IIF(PswSeek((cSUD)->UD_OPERADO),PswRet(1),{})
			oSection2:Cell("S2_USR"):SetValue(IIF(Len(aUser)>0,FATPDObfuscate(aUser[1][2],"U7_NOME"),""))
			oSection2:PrintLine() 
			oReport:SkipLine()
	#IFNDEF TOP
			DbSelectArea(cSUD)
			DbSkip()
		End
	#ENDIF
	
	DbSelectArea(cSUC)
	DbSkip()
End        
If cCodSUC <> "" 
	oSection2:Finish()	
	oReport:EndPage()			
EndIf 
oSection1:Finish()  


If Len(aTotGer) > 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Tipo na ultima pagina³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ASort(aTotGer,2,,{|x,y| x[2] > y[2]})
	oSection3:Init()
	For nI := 2 To Len(aTotGer)
		DbSelectArea("SUL")
		DbSetOrder(1)
		
		If !Empty(aTotGer[nI][1])
			DbSeek(xFilial("SUL")+aTotGer[nI][1])
			oSection3:Cell("S3_TPCOMUN"):SetValue(SUL->UL_DESC)
		Else
			oSection3:Cell("S3_TPCOMUN"):SetValue(STR0010 + Space((TAMSX3("UL_DESC")[1])-Len(STR0010))) //"**Não Informado.**"
		Endif 
			
		If Mv_Par10 == 3 // Ambos
			oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[nI][4],'@E 999,999'))
			oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[nI][4]/aTotGer[1][2]*100, '@E 999.99'))
			oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[nI][3]/aTotGer[1][2]*100, '@E 999.99'))
			oSection3:Cell("S3_TOT"):SetValue(Transform(aTotGer[nI][4]+aTotGer[nI][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotGer[nI][4]/aTotGer[1][2]*100)+(aTotGer[nI][3]/aTotGer[1][2]*100), '@E 999.99'))
		Else // Ativo ou Receptivo 
			If Mv_Par10 == 1 // Ativo
				oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[nI][2],'@E 999,999'))
				oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[nI][2]/aTotGer[1][2]*100, '@E 999.99'))
			Else
				oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[nI][2],'@E 999,999'))
				oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[nI][2]/aTotGer[1][2]*100, '@E 999.99'))
			EndIf
		Endif	
		oSection3:PrintLine()			
	Next nI

	oSection3:Cell("S3_TPCOMUN"):SetValue(STR0016) // TOTAL
	If Mv_Par10 == 3 // Ambos
		oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[1][4],'@E 999,999'))
		oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[1][4]/aTotGer[1][2]*100, '@E 999.99'))
		oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[1][3],'@E 999,999'))
		oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[1][3]/aTotGer[1][2]*100, '@E 999.99'))
		oSection3:Cell("S3_TOT"):SetValue(Transform(aTotGer[1][4]+aTotGer[1][3],'@E 999,999'))
		oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotGer[1][4]/aTotGer[1][2]*100)+(aTotGer[1][3]/aTotGer[1][2]*100), '@E 999.99'))
	Else // Ativo ou Receptivo
		If Mv_Par10 == 1 // Ativo
			oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[1][2],'@E 999,999'))
			oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[1][2]/aTotGer[1][2]*100, '@E 999.99'))
		Else
			oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[1][2],'@E 999,999'))
			oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[1][2]/aTotGer[1][2]*100, '@E 999.99'))
		EndIf
	Endif	
	oSection3:PrintLine()				
	oSection3:Finish()		
	aTotGer := {}
	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Data e Operador.     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection4:Init()
	For nI := 2 To Len(aTotData)
		oSection4:Cell("S4_DATA"):SetValue(StoD(aTotData[nI][1]))		
		If Mv_Par10 == 3 // Ambos
			oSection4:Cell("S4_OPER"):SetValue(aTotData[nI][2] + " - " + aTotData[nI][3])			
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotData[nI][6], '@E 999,999'))			
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotData[nI][5], '@E 999,999'))			
			oSection4:Cell("S4_TOT"):SetValue(Transform(aTotData[nI][6]+aTotData[nI][5], '@E 999,999'))			
		Else // Ativo ou Receptivo
			oSection4:Cell("S4_OPER"):SetValue(aTotData[nI][2] + " - " + aTotData[nI][3])			
			If Mv_Par10 == 1 // Ativo
				oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotData[nI][4], '@E 999,999'))			                                        				
			Else
				oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotData[nI][4], '@E 999,999'))			                                        
			EndIf
		Endif
		oSection4:PrintLine()			
	Next nI

	oSection4:Cell("S4_DATA"):SetValue(STR0016)// "TOTAL"
	oSection4:Cell("S4_OPER"):SetValue("")
	If Mv_Par10 == 3 // Ambos
		oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotData[1][6], '@E 999,999'))			
		oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotData[1][5], '@E 999,999'))			
		oSection4:Cell("S4_TOT"):SetValue(Transform(aTotData[1][6]+aTotData[1][5], '@E 999,999'))			
	Else // Ativo ou Receptivo
		If Mv_Par10 == 1 // Ativo
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotData[1][4], '@E 999,999'))			                                        				
		Else
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotData[1][4], '@E 999,999'))			                                        
		EndIf
	Endif
	oSection4:PrintLine()			
	oSection4:Finish()	
	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Imprime o total dos atendimentos por Operador.		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ASort(aTotOper,,,{|x,y| x[3] > y[3]})
    oSection6:Init()
	For nI := 1 To Len(aTotOper)
		oSection6:Cell("S6_OPER"):SetValue(aTotOper[nI][1] + " - " + aTotOper[nI][2])
		If Mv_Par10 == 3
			oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOper[nI][5], '@E 999,999'))				
			oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOper[nI][4], '@E 999,999'))								
			oSection6:Cell("S6_TOT"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))								
		Else                 
			If Mv_Par10 == 1 // Ativo
				oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))					
			Else                                
				oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))
			EndIf
		Endif				
		oSection6:PrintLine()
	Next nI

	aTotData := {}
    
    oSection6:Finish()  
		

EndIf
Return(.T.)
//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource

//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
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
    @since 17/12/2019
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