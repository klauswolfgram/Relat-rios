/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR018.CH"
#INCLUDE "TMKDEF.CH"
#INCLUDE "REPORT.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR018  ³ Autor ³ Armando M. Tessaroli  ³ Data ³ 28/02/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Analise do Telemarketing Ativo pelo Tipo de Reclamacao     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR018(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TeleMarketing (SUC)                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista  ³ Data/Bops/Ver ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Marcelo K ³10/07/03³710   ³Correcao do seek na Tabela SU9 indice 1     ³±±
±±³Andrea F. ³11/05/04³811   ³Revisao do Fonte e inclusao de totalizadores³±±
±±³Michel W. ³07/08/06³99189 ³Atualizacao de relatorio para release 4.    ³±±
±±³Michel W. ³05/10/06³105074³Inserido SetLineBreak para secao 2.         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function TMKR018()

Local oReport //Objeto relatorio TReport (Release 4)
Local aPDFields := {"U5_FCOM1","U5_CONTAT","U7_NREDUZ"}

FATPDLoad(/*cUserPDA*/, /*aAlias*/, aPDFields, "TMKR018")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("TMK018",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ Mv_Par01           // Da Data                                ³
//³ Mv_Par02           // Ate a Data                             ³
//³ Mv_Par03           // Tipo de Reclamacao - Ocorrencia        ³
//³ Mv_Par04           // Operador                               ³
//³ Mv_Par05           // Produto                                ³
//³ Mv_Par06           // Tipo de Produto                        ³
//³ Mv_Par07           // Status da Ligacao - Plan. Pend. Encerr.³
//³ Mv_Par08           // Do CEP                                 ³
//³ Mv_Par09           // Ate o CEP                              ³
//³ Mv_Par10	       // Contato                ?               ³
//³ Mv_Par11 	       // Entidade               ?               ³
//³ Mv_Par12	       // Segmento 1             ?               ³
//³ Mv_Par13 	       // Segmento 2             ?               ³
//³ Mv_Par14 		   // Segmento 3             ?               ³
//³ Mv_Par15		   // Segmento 4             ?               ³
//³ Mv_Par16	       // Segmento 5             ?               ³
//³ Mv_Par17           // Segmento 6             ?               ³
//³ Mv_Par18           // Segmento 7             ?               ³
//³ Mv_Par19           // Segmento 8             ?               ³
//³ Mv_Par20           // Tipo de atendimento    ?               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := ReportDef()
oReport:PrintDialog() 

FATPDUnload("TMKR018")

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Tk018ValidºAutor  ³Armando M. Tessaroliº Data ³  25/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³   Valida os itens do atendimento de acordo com os parametroº±±
±±º          ³informado para validar se o atendimento sera impresso ou naoº±±
±±º          ³   Valida tambem os itens que serao impressos para o atendi-º±±
±±º          ³mento selecionado.                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TMKR018                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tk018Valid(cSUC, cSUD)

Local aArea	:= GetArea()
Local lRet	:= .F.

DbSelectArea(cSUD)
DbSetOrder(1)
If DbSeek(xFilial(cSUD)+(cSUC)->UC_CODIGO)
	While	(!Eof())									.AND.;
			(cSUD)->UD_FILIAL == xFilial(cSUC)			.AND.;
			(cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o tipo de reclamacao informado                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par03) .AND. (cSUD)->UD_OCORREN <> Mv_Par03
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o produto  informado                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par05) .AND. (cSUD)->UD_PRODUTO <> Mv_Par05
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o tipo de produto informado                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par06)
			DbSelectArea("SB1")
			DbSetOrder(1)
			If DbSeek(xFilial("SB1")+(cSUD)->UD_PRODUTO)
				If AllTrim(SB1->B1_TIPO) <> AllTrim(Mv_Par06)
					DbSelectArea(cSUD)
					DbSkip()
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
±±³Fun‡…o    ³ReportDef    ³ Autor ³Michel W. Mosca     ³ Data ³07/08/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina que define os itens que serao apresentados no relato-³±±
±±³          ³rio de Atendimento receptivo - Ocorrencias.                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ReportDef()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ CALL CENTER                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Fernando ³811   |11/10/06|Foi modificada a funcao ReportDef para      ³±±
±±³			 |		|		 |criacao de string a ser visualizada na opcao³±±
±±³			 |		|		 |Personalizar do relatorio TMKR018           ³±±                               
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄ|ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/              
Static Function ReportDef()

Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Dados do atendimentos)
Local oSection2             //Objeto secao 2 do relatorio (Itens vendidos)
Local oSection3				//Totalizador por atendimentos
Local oSection4				//Totalizador por ocorrencias
Local oSection5				//Totalizador de ocorrencias executadas por produto
Local oSection6				//Totalizador de ocorrencias executadas por assunto
Local cSUC := "SUC"     	//Alias da consulta Embedded SQL     
Local cSUD := "SUD"     	//Alias da consulta Embedded SQL     
Local aUC_Status	:= TkSx3Box("UC_STATUS")	// Le as opcoes do campo no dd SX3 
Local aUD_Status	:= TkSx3Box("UD_STATUS")	// Le as opcoes do campo no dd SX3

cSUC	:= GetNextAlias()						// Pega o proximo Alias Disponivel
cSUD	:= cSUC

//"Ligacoes Recebidas - Tipo de Reclamacao " # //"Este programa ira emitir a relacao dos tipos" #
//"de reclamacoes recebidas pelo operador"
DEFINE REPORT oReport NAME "TMKR018" TITLE STR0001 PARAMETER "TMK018" ACTION {|oReport| Tkr018PrtRpt( oReport, cSUC, cSUD)} DESCRIPTION STR0002 + STR0003

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE SECTION oSection1 OF oReport		TITLE STR0058 TABLES "SUC"    // telemarketing                      
DEFINE SECTION oSection2 OF oSection1	TITLE STR0059 TABLES "SUD"  // itens do telemarketing
DEFINE SECTION oSection3 OF oReport		TITLE STR0027                 // periodo
DEFINE SECTION oSection4 OF oReport 	TITLE STR0046                 // ocorrencia por atendimento
DEFINE SECTION oSection5 OF oReport 	TITLE STR0048                 // ocorrencia por produto
DEFINE SECTION oSection6 OF oReport 	TITLE STR0049                 // ocorrencia por assunto

DEFINE CELL NAME "" 			OF oSection1 ALIAS "" 		BLOCK {||DToC((cSUC)->UC_DATA) + "  " + (cSUC)->UC_INICIO + " - " + (cSUC)->UC_FIM} TITLE STR0008 SIZE 30 //"Data do Atendimento"
DEFINE CELL NAME "" 			OF oSection1 ALIAS "" 		BLOCK {||FATPDObfuscate(Posicione("SU5",1,xFilial("SU5")+(cSUC)->UC_CODCONT,"U5_CONTAT"),"U5_CONTAT","TMKR018")} TITLE STR0009 SIZE 40  //"Nome do Contato"
DEFINE CELL NAME "UC_CODIGO" 	OF oSection1 ALIAS cSUC
DEFINE CELL NAME "" 			OF oSection1 ALIAS "" 		BLOCK{||FATPDObfuscate(Transform(TkDadosContato((cSUC)->UC_CODCONT,4),'@R 9999-9999'),"U5_FCOM1","TMKR018")} TITLE STR0035 SIZE 9
DEFINE CELL NAME "" 			OF oSection1 ALIAS "" 		BLOCK{||FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NREDUZ"),"U7_NREDUZ","TMKR018")} TITLE STR0012 SIZE 40 
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||TkDadosContato((cSUC)->UC_CODCONT,10,.T.)} TITLE STR0037 SIZE 30 //"Descricao do Email"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||IIF(!Empty((cSUC)->UC_STATUS),aUC_Status[Val((cSUC)->UC_STATUS)],"")} TITLE STR0014 SIZE 25  //"Status do Atendimento"
DEFINE CELL NAME "S1_ENTDESC"	OF oSection1 ALIAS cSUC 	TITLE STR0011 SIZE 40 //"Descricao da Entidade"
DEFINE CELL NAME "UC_OPERACA"	OF oSection1 ALIAS cSUC
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,1,,.T.)} TITLE STR0013 SIZE 40 //"Razao Social da Entidade"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||(cSUC)->UC_MIDIA + " - " +	Posicione("SUH",1,xFilial("SUH")+(cSUC)->UC_MIDIA,"UH_DESC")} TITLE STR0040 SIZE 20 // "Descricao da Midia"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||FATPDObfuscate(Transform(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,6),'@R 9999-9999'),"U5_FCOM1","TMKR018")} TITLE STR0015 SIZE 10 //"Telefone da Entidade"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||(cSUC)->UC_TIPO  + " - " + Posicione("SUL",1,xFilial("SUL")+(cSUC)->UC_TIPO,"UL_DESC")} TITLE STR0041 SIZE 20 // "Descricao da Comunicacao"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,3,,.T.)} TITLE STR0017 SIZE 25 //"Cidade da Entidade"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC")} TITLE STR0018 SIZE 25 //"Motivo do Encerramento"
DEFINE CELL NAME "" 			OF oSection1 ALIAS cSUC 	BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,4,,.T.)} TITLE STR0019 SIZE 25 //"Estado da Entidade"
DEFINE CELL NAME "UC_OBS"		OF oSection1 ALIAS cSUC 	BLOCK{||MSMM((cSUC)->UC_CODOBS)} TITLE STR0020

DEFINE CELL NAME "UD_ITEM" 		OF oSection2 ALIAS cSUD
DEFINE CELL NAME "S2_PRODDESC"	OF oSection2 ALIAS "" 		TITLE STR0051
DEFINE CELL NAME "" 			OF oSection2 ALIAS cSUD 	BLOCK{||Posicione("SB1",1,xFilial("SB1")+(cSUD)->UD_PRODUTO,"B1_DESC")} TITLE STR0052 SIZE 30
DEFINE CELL NAME "" 			OF oSection2 ALIAS cSUD 	BLOCK{||Posicione("SU9",1,xFilial("SU9")+(cSUD)->UD_ASSUNTO+(cSUD)->UD_OCORREN,"U9_DESC")} TITLE STR0026 SIZE 30
DEFINE CELL NAME "" 			OF oSection2 ALIAS cSUD 	BLOCK{||Posicione("SUQ",1,xFilial("SUQ")+(cSUD)->UD_SOLUCAO,"UQ_DESC")} TITLE STR0053 SIZE 50
DEFINE CELL NAME "S2_AUSER" 	OF oSection2 ALIAS "" 		TITLE STR0060 SIZE 15 // "Responsável"
DEFINE CELL NAME "UD_DATA" 		OF oSection2 ALIAS cSUD 	
DEFINE CELL NAME "" 			OF oSection2 ALIAS cSUD 	BLOCK{||IIF(!Empty((cSUD)->UD_STATUS),aUD_Status[Val((cSUD)->UD_STATUS)],"")} TITLE STR0054 SIZE 12
DEFINE CELL NAME "UD_DTEXEC" 	OF oSection2 ALIAS cSUD
DEFINE CELL NAME "" 			OF oSection2 ALIAS cSUD
DEFINE CELL NAME "S2_OBS"		OF oSection2 ALIAS "" 		BLOCK{||MSMM((cSUD)->UD_OBS)} TITLE STR0020 
DEFINE CELL NAME "UD_OBSEXEC"	OF oSection2 ALIAS "" 		BLOCK{||MSMM((cSUD)->UD_CODEXEC)} TITLE STR0031 


DEFINE CELL NAME "S3_DATA" 		OF oSection3 TITLE STR0055 	SIZE 10
DEFINE CELL NAME "S3_ATIV" 		OF oSection3 TITLE STR0056	SIZE 10
DEFINE CELL NAME "S3_RECP" 		OF oSection3 TITLE STR0057	SIZE 10

DEFINE CELL NAME "S4_OCORR" 	OF oSection4 TITLE STR0026	SIZE 30
DEFINE CELL NAME "S4_TOTAL" 	OF oSection4 TITLE STR0045	SIZE 10
DEFINE CELL NAME "S4_PERC" 		OF oSection4 TITLE "%" 		SIZE 5

DEFINE CELL NAME "S5_OCORR" 	OF oSection5 TITLE STR0026 	SIZE 30
DEFINE CELL NAME "S5_PROD"  	OF oSection5 TITLE STR0052	SIZE 30
DEFINE CELL NAME "S5_TOT" 		OF oSection5 TITLE STR0045	SIZE 10
DEFINE CELL NAME "S5_PERC"		OF oSection5 TITLE "%" 		SIZE 5

DEFINE CELL NAME "S6_ASS" 		OF oSection6 TITLE STR0051	SIZE 30
DEFINE CELL NAME "S6_OCORR" 	OF oSection6 TITLE STR0026	SIZE 30
DEFINE CELL NAME "S6_TOT" 		OF oSection6 TITLE STR0045	SIZE 10
DEFINE CELL NAME "S6_PERC" 		OF oSection6 TITLE "%"		SIZE 5

Return(oReport) 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Tkr018PrtRpt ³ Autor ³Michel W. Mosca     ³ Data ³07/08/2006³±±
±±³          ³             ³       ³                    ³      ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina responsavel pela impressao do relatorio de           ³±±
±±³          ³Atendimento Receptivo - Ocorrencias                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Tkr018PrtRept(ExpO1,ExpC2,ExpC3)                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpO1 = objeto relatorio                                   ³±±
±±³          ³ ExpC2 = alias da query atual                               ³±±
±±³          ³ ExpC3 = alias da query atual                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tkr018PrtRpt(oReport, cSUC, cSUD)     
Local oSection1 := oReport:Section(1)		//Objeto secao 1 do relatorio (Cabecalho, campos das tabelas SU2 e SB1)
Local oSection2 := oSection1:Section(1) 	//Objeto secao 2 do relatorio (Itens vendidos)
Local oSection3 := oReport:Section(2)		//Totalizador por atendimentos
Local oSection4 := oReport:Section(3)		//Totalizador por ocorrencias
Local oSection5 := oReport:Section(4)     	//Totalizador de ocorrencias executadas por produto
Local oSection6 := oReport:Section(5)		//Totalizador de ocorrencias executadas por assunto
Local cFiltro	:= ""                      	//String contendo o filtro de busca a ser utilizado com DBF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Declaracao de variaveis especificas para este relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nI			:= 0						// Controle
Local cCodSUC		:= ""						// Manipula a quebra do cabecalho
Local cCodSUD		:= ""						// Manipula a quebra dos itens
Local aTotGerAtend	:= {}						// Totalizacao dos atendimentos ativos e receptivos por data
Local nPosDtAtend
Local aUser		:= {}     
Local aTotGerOcorr	:= {}						// Totalizacao das ocorrencias
Local aTotGerProd	:= {}						// Totalizacao das ocorrencias X produtos
Local aTotGerAss 	:= {}						// Totalizacao das ocorrencias X assunto
Local nTotOcorr		:= 0                        // Total de Ocorrencias
Local nTotProd 		:= 0                        // Total de Produtos
Local nTotAss       := 0                        // Total de Assunto                     
Local nAtivos		:= 0                        // Total de ligacoes ativas
Local nReceptivos	:= 0                        // Total de ligacoes receptivas
Local cCodOcorr     := ""					    // Contem o codigo da Ocorrencia anterior
Local cCodAss       := ""						// Contem o codigo do Assunto anterior

Local cTables								//Armazena as tabelas adicionais a serem consultadas
Local cQuery		:= ""					// Armazena a expressao da query para top
Local cWhere		:= ""					// Validacao do segmento de negocio para top

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr("TMK018")      
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamo a funcao que monta a parte da query para validar os segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Mv_Par11 == "SA1" .OR. Mv_Par11 == "SUS"
	TKSegmento(	Mv_Par12,	Mv_Par13,	Mv_Par14,	Mv_Par15,;
				Mv_Par16,	Mv_Par17,	Mv_Par18,	Mv_Par19,;
				Mv_Par11,	"",			@cWhere)
Endif
        
cTables = "%"
If !Empty(Mv_Par06)
	cTables += " , " + RetSqlName("SB1") + " SB1"
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cTables += ", " + RetSqlName(Mv_Par11) + " " + Mv_Par11 
Endif    
cTables +="%"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query as condicoes de busca dos dados do relatório³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
cQuery +=	"% SUC.UC_FILIAL = '" + xFilial("SUC") + "' AND" +;
			"		SUC.UC_CODCANC = '" + Space(TamSX3("UC_CODCANC")[01]) + "' AND" +;
			"		SUC.UC_DATA BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND"

If Mv_Par20 <> 3 //Ambos
	cQuery += "		(SUC.UC_OPERACA = '" + IIF(Mv_Par20==1,"2","1") + "' OR"
	cQuery += "		SUC.UC_OPERACA = '" + Space(TamSX3("UC_OPERACA")[01]) + "') AND"
Endif

If !Empty(Mv_Par04)
	cQuery += "		SUC.UC_OPERADO = '" + Mv_Par04 + "' AND"
Endif
	
If !Empty(Mv_Par10)
	cQuery += "		SUC.UC_CODCONT = '" + Mv_Par10 + "' AND"
Endif
	
If !Empty(Mv_Par11)
	cQuery += "		SUC.UC_ENTIDAD = '" + Mv_Par11 + "' AND"
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciono somente chamados que nao sao compartilhamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cQuery += "		SUC.UC_CHAORIG = '" + Space(TamSX3("UC_CHAORIG")[01]) + "' AND"


If (Mv_Par07 <> 1)  // Todas as licacoes
	cQuery += "		(SUC.UC_STATUS = '" + Str(Mv_Par07-1,1) + "' OR"
	cQuery += "		SUC.UC_STATUS = ' ') AND"
Endif
                
cQuery +=	"		SUD.UD_FILIAL = '" + xFilial("SUD") + "' AND" +;
   				"		SUD.UD_CODIGO = SUC.UC_CODIGO AND"
    			
If !Empty(Mv_Par03)
	cQuery += "		SUD.UD_OCORREN = '" + Mv_Par03 + "' AND"
Endif
	
If !Empty(Mv_Par05)
	cQuery += "		SUD.UD_PRODUTO = '" + Mv_Par05 + "' AND"
Endif
	
If !Empty(Mv_Par06)
	cQuery +=	"	SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND" +;
				"	SB1.B1_COD = SUD.UD_PRODUTO AND" +;
				"	SB1.B1_TIPO = '" + AllTrim(Mv_Par06) + "' AND" +;
				"	SB1.D_E_L_E_T_ = ' ' AND"
Endif
     			
cQuery +=	"		SUD.D_E_L_E_T_ = ' ' AND" +;
			"		SUC.D_E_L_E_T_ = ' ' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Implementa na query a validacao dos segmentos de negocios³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cWhere)
	cQuery += " AND " + cWhere
Endif
cQuery += "%"

BEGIN REPORT QUERY oSection1
BeginSQL alias cSUC       
	SELECT 	UC_DATA,		UC_INICIO,		UC_FIM,			UC_CODCONT,		UC_FILIAL,
			UC_CODCONT,		UC_OPERADO,		UC_CODCONT,		UC_STATUS,
			UC_ENTIDAD,		UC_CHAVE,		UC_MIDIA, 		UC_TIPO,
			UC_CODENCE,		UC_CODOBS,		UC_OPERACA,		UC_CODIGO, 		
			UD_ASSUNTO, 	UD_PRODUTO, 	UD_OCORREN, 	UD_SOLUCAO, 
			UD_OPERADO, 	UD_DATA, 		UD_STATUS,		UD_DTEXEC, 
			UD_OBS, 		UD_CODEXEC, 	UD_CODIGO, 		UD_ITEM  
	FROM %table:SUC% SUC, %table:SUD% SUD%exp:cTables%
	WHERE %exp:cQuery%	
    ORDER BY %order:SUC%
EndSql    
END REPORT QUERY oSection1
                                  
TRPosition():New(oSection2,"SUD",1,{|| xFilial("SUD") + (cSUC)->UC_CODIGO } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Quebra a linha, caso existam muitas colunas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:SetLineBreak()
oSection2:SetLineBreak()

While	(!Eof())							.AND.;
		(cSUC)->UC_FILIAL == xFilial("SUC")	.AND.;
		(cSUC)->UC_DATA >= Mv_Par01			.AND.;
		(cSUC)->UC_DATA <= Mv_Par02
	
	oReport:IncMeter()
	
	If oReport:Cancel()
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Seleciona o intervalo do CEP Exeto Concorrente que nao tem CEP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Mv_Par11 <> "AC3"
		cCep := TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,5)
		If Alltrim(cCep) < Alltrim(Mv_Par08) .OR. Alltrim(cCep) > Alltrim(Mv_Par09)
			DbSkip()
			Loop
		Endif
	Endif
	
	#IFNDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Elimino as ligacoes canceladas                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CODCANC)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona as ligacoes de acordo com o parametro RECEPTIVO/ATIVO/AMBOS³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par20 <> 3 //Ambos  (Nao sera validado o Tipo de Ligacao para a impressao)
			If Mv_Par20 == 1  //Ativo
				If Val((cSUC)->UC_OPERACA) <> ATIVO .OR. Empty((cSUC)->UC_OPERACA) //"2"
					DbSkip()
					Loop
				Endif
			Else           //Receptivo
				If Val((cSUC)->UC_OPERACA) <> RECEPTIVO .OR. Empty((cSUC)->UC_OPERACA) //"1"
					DbSkip()
					Loop
				Endif
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Seleciono apenas os operadores validos³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par04) .AND. (cSUC)->UC_OPERADO <> Mv_Par04
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifico o contato                                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par10) .AND. (cSUC)->UC_CODCONT <> AllTrim(Mv_Par10)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Permite a impressao somente da entidade informada        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(Mv_Par11) .AND. (cSUC)->UC_ENTIDAD <> Mv_Par11
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona o status da ligacao informado                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par07 <> 1  // Todas
			Do Case
				Case Mv_Par07 == 2 // Planejada
					If Val((cSUC)->UC_STATUS) <> PLANEJADA		// 1
						DbSelectarea(cSUC)
						DbSkip()
						Loop
					Endif
					
				Case Mv_Par07 == 3 // Pendente
					If Val((cSUC)->UC_STATUS) <> PENDENTE		// 2
						DbSelectarea(cSUC)
						DbSkip()
						Loop
					Endif
					
				Case Mv_Par07 == 4 // Encerrada
					If VAL((cSUC)->UC_STATUS) <> ENCERRADA		// 3
						DbSelectarea(cSUC)
						DbSkip()
						Loop
					Endif
			EndCase
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ VerIfico os parametros referentes aos itens do atendimento ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Tk018Valid(cSUC, cSUD)
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao seleciono chamados que sao compartilhamentos         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty((cSUC)->UC_CHAORIG)
			DbSkip()
			Loop
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Chamo a funcao que valida os segmentos de negocios³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Mv_Par11 == "SA1" .OR. Mv_Par11 == "SUS"
			If !TKSegmento(	Mv_Par12,	Mv_Par13,	Mv_Par14,	Mv_Par15,;
							Mv_Par16,	Mv_Par17,	Mv_Par18,	Mv_Par19,;
							Mv_Par11,	(cSUC)->UC_CHAVE)
				DbSkip()
				Loop
			Endif
		Endif
	#ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Comeca a imprimir o relatorio neste ponto³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cCodSUC <> (cSUC)->UC_CODIGO
	         
		If cCodSUC <> ""
			oSection2:Finish()
			oSection1:Finish()
		EndIf		                   
		cCodSUC := (cSUC)->UC_CODIGO				
		oSection1:Init()
		oSection1:SetLineStyle()
		DbSelectArea("SX5")
		DbSetOrder(1)
		oSection1:Cell("S1_ENTDESC"):SetValue("")
		If DbSeek(xFilial("SX5")+"T5"+(cSUC)->UC_ENTIDAD)
			oSection1:Cell("S1_ENTDESC"):SetValue(X5DESCRI())
		EndIf		
		oSection1:PrintLine() 
		oSection2:Init()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Acumula os atendimentos Ativos e Receptivos por Data³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aTotGerAtend) == 0
			aAdd(aTotGerAtend, {,,1})
		Else
			aTotGerAtend[1][3]++	
        Endif                 
        
		nPosDtAtend:= aScan(aTotGerAtend, {|x| x[1]==(cSUC)->UC_DATA}) 
		If nPosDtAtend > 0
			If Val((cSUC)->UC_OPERACA) == ATIVO
				aTotGerAtend[nPosDtAtend][2]++	//ATIVO
			Else
				aTotGerAtend[nPosDtAtend][3]++ 	//RECEPTIVO
		    Endif
		Else
			If Val((cSUC)->UC_OPERACA) == ATIVO
			 	Aadd(aTotGerAtend,{(cSUC)->UC_DATA,1,0 })
			Else
			 	Aadd(aTotGerAtend,{(cSUC)->UC_DATA,0,1 })
		    Endif
		Endif
		
	EndIf 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Comeca a imprimir os itens do atendimento            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	#IFNDEF TOP
		DbSelectArea(cSUD)
		DbSetOrder(1)
		DbSeek(xFilial(cSUD) + (cSUC)->UC_CODIGO)
		While	(!Eof())								.AND.;
				(cSUD)->UD_FILIAL == xFilial(cSUC)		.AND.;
				(cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
	#ENDIF
			
                                  
				If !Empty((cSUD)->UD_ASSUNTO)
					DbSelectArea("SX5")
					DbSetORder(1)		// Codigo do Assunto
					If DbSeek(xFilial("SX5")+"T1"+(cSUD)->UD_ASSUNTO)
						oSection2:Cell("S2_PRODDESC"):SetValue(X5DESCRI())
					EndIf
				EndIf     
				
				PswOrder(1)
				aUser := IIF(PswSeek((cSUD)->UD_OPERADO),PswRet(1),{})
				oSection2:Cell("S2_AUSER"):SetValue(IIF(Len(aUser)>0,FATPDObfuscate(aUser[1][2],"U7_NREDUZ","TMKR018"),""))
				oSection2:PrintLine()
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Acumula os totalizadores gerais³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty((cSUD)->UD_OCORREN)
					nTotOcorr+=1
					nPos := aScan(aTotGerOcorr, {|x| x[1]==(cSUD)->UD_OCORREN} )
					If nPos == 0
						aAdd(aTotGerOcorr, {(cSUD)->UD_OCORREN, 1} )
					Else
						aTotGerOcorr[nPos][2]++
					Endif
				Endif
				
				If !Empty((cSUD)->UD_PRODUTO) .AND. !Empty((cSUD)->UD_OCORREN)
					nTotProd+=1
					nPos := aScan(aTotGerProd, {|x| ALLTRIM(x[1]+x[2])==ALLTRIM((cSUD)->UD_OCORREN+(cSUD)->UD_PRODUTO)} )
					If nPos == 0
						aAdd(aTotGerProd, {(cSUD)->UD_OCORREN,(cSUD)->UD_PRODUTO,1} )
					Else
						aTotGerProd[nPos][3]++
					Endif
				Endif
				
				If !Empty((cSUD)->UD_ASSUNTO) .AND. !Empty((cSUD)->UD_OCORREN)
					nTotAss+=1
					nPos := aScan(aTotGerAss, {|x| ALLTRIM(x[1]+x[2])==ALLTRIM((cSUD)->UD_ASSUNTO+(cSUD)->UD_OCORREN)} )
					If nPos == 0
						aAdd(aTotGerAss, {(cSUD)->UD_ASSUNTO,(cSUD)->UD_OCORREN,1} )
					Else
						aTotGerAss[nPos][3]++
					Endif
				Endif
	#IFNDEF TOP
			DbSelectArea(cSUD)
			DbSkip()
		End
	#ENDIF
	
	
	DbSelectArea(cSUC)
	DbSkip()
End 	//Fim-Loop de impressao

If cCodSUC <> ""
	oSection2:Finish()
	oSection1:Finish()
EndIf	   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprimi os totais dos atendimentos ao sair do while³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aTotGerAtend) > 0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Salta a Pagina para imprimir os totalizadores³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
	oReport:EndPage()
	oReport:SkipLine()
	oReport:PrintText(STR0042 +; //"TOTAL DE ATENDIMENTOS ATIVOS E RECEPTIVOS NO PERÍODO DE  "  
	 					DTOC(MV_PAR01)+ " - " + (cDia:= Tk_DiaSemana(MV_PAR01,Nil,Nil))+ STR0043 + " " +;  //" ATE "
	 					DTOC(MV_PAR02)+ " - " + (cDia:= Tk_DiaSemana(MV_PAR02,Nil,Nil)) + " -> " +;
	 					Transform(aTotGerAtend[1][3],'@E 999,999'))
	

	oSection3:Init()
	For nI:= 2 To Len(aTotGerAtend)
		oSection3:Cell("S3_DATA"):SetValue(Transform(aTotGerAtend[nI][1],'@ 999,999'))
		oSection3:Cell("S3_ATIV"):SetValue(Transform(aTotGerAtend[nI][2],'@ 999,999'))
		oSection3:Cell("S3_RECP"):SetValue(Transform(aTotGerAtend[nI][3],'@ 999,999'))
		oSection3:PrintLine()
	    nAtivos		+=aTotGerAtend[nI][2]
	    nReceptivos	+=aTotGerAtend[nI][3]
	Next nI	
	oSection3:Cell("S3_DATA"):SetValue(STR0045) //"TOTAL" 
	oSection3:Cell("S3_ATIV"):SetValue(Transform(nAtivos,'@ 999,999'))
	oSection3:Cell("S3_RECP"):SetValue(Transform(nReceptivos,'@ 999,999'))	      
	oSection3:PrintLine()
	oSection3:Finish()
	
	If Len(aTotGerOcorr) > 0
		oSection4:Init()  
		oReport:SkipLine()
		aSort(aTotGerOcorr,,, {|x,y| x[2] > y[2]} )		// Decrescente
        oReport:ThinLine()
        oReport:PrintText(STR0046) //"OCORRÊNCIAS COM MAIOR NÚMERO DE ATENDIMENTOS"
        oReport:SkipLine()
		For nI := 1 To Len(aTotGerOcorr)
			oSection4:Cell("S4_OCORR"):SetValue(aTotGerOcorr[nI][1] + " - " + Posicione("SU9",2,xFilial("SU9")+aTotGerOcorr[nI][1],"U9_DESC"))
			oSection4:Cell("S4_TOTAL"):SetValue(Transform(aTotGerOcorr[nI][2],'@ 999,999'))
			oSection4:Cell("S4_PERC"):SetValue(Transform(aTotGerOcorr[nI][2]/nTotOcorr*100, '@ 999.99') + ' %')
			oSection4:PrintLine()
		Next nI         
		oSection4:Finish()
	Endif	
	
	If Len(aTotGerProd) > 0
		aSort(aTotGerProd,,, {|x,y| x[1]+x[2] < y[1]+y[2]} )		 
		oSection5:Init()
		oReport:SkipLine()
		oReport:ThinLine()
		oReport:PrintText(STR0048)  //"OCORRÊNCIAS EXECUTADAS POR PRODUTO "		
		oReport:SkipLine()		
		For nI := 1 To Len(aTotGerProd)
            If cCodOcorr <> aTotGerProd[nI][1]
				oSection5:Cell("S5_OCORR"):SetValue(aTotGerProd[nI][1] + " - " +  Posicione("SU9",2,xFilial("SU9")+aTotGerProd[nI][1],"U9_DESC"))
                oSection5:PrintLine()
				cCodOcorr:= aTotGerProd[nI][1]
				oSection5:Cell("S5_OCORR"):SetValue("")
            Endif
			oSection5:Cell("S5_PROD"):SetValue(aTotGerProd[nI][1] + " - " + Posicione("SB1",1,xFilial("SB1")+aTotGerProd[nI][2],"B1_DESC"))
			oSection5:Cell("S5_TOT"):SetValue(Transform(aTotGerProd[nI][3],'@ 999,999'))
			oSection5:Cell("S5_PERC"):SetValue(Transform(aTotGerProd[nI][3]/nTotProd*100, '@ 999.99') + ' %')
			oSection5:PrintLine()                                                                              
			oSection5:Cell("S5_OCORR"):SetValue("")
			oSection5:Cell("S5_PROD"):SetValue("")
			oSection5:Cell("S5_TOT"):SetValue("") 
			oSection5:Cell("S5_PERC"):SetValue("")			
		Next nI
		oSection5:Finish()
	Endif  

    If Len(aTotGerAss) > 0
    	oSection6:Init()
    	oReport:SkipLine()
    	oReport:ThinLine()
    	oReport:PrintText(STR0049) 	//"OCORRÊNCIAS EXECUTADAS POR ASSUNTO "
		oReport:SkipLine()
		For nI := 1 To Len(aTotGerAss)
            If cCodAss <> aTotGerAss[nI][1]
				oSection6:Cell("S6_ASS"):SetValue(aTotGerAss[nI][1] + " - " +  Posicione("SX5",1,xFilial("SX5")+"T1"+aTotGerAss[nI][1],"X5_DESCRI"))
				oSection6:PrintLine()
				cCodAss:= aTotGerAss[nI][1]
				oSection6:Cell("S6_ASS"):SetValue("")
            Endif
			oSection6:Cell("S6_OCORR"):SetValue(aTotGerAss[nI][2] + " - " + Posicione("SU9",2,xFilial("SU9")+aTotGerAss[nI][2],"U9_DESC"))
			oSection6:Cell("S6_TOT"):SetValue(Transform(aTotGerAss[nI][3],'@ 999,999'))
			oSection6:Cell("S6_PERC"):SetValue(Transform(aTotGerAss[nI][3]/nTotAss*100, '@ 999.99') + ' %')			
			oSection6:PrintLine()			                                                                  
			oSection6:Cell("S6_ASS"):SetValue("")
			oSection6:Cell("S6_OCORR"):SetValue("")
			oSection6:Cell("S6_TOT"):SetValue("")
			oSection6:Cell("S6_PERC"):SetValue("")			
		Next nI 
		oSection6:Finish()
    Endif	
	
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