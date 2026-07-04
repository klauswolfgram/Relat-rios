/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR022.ch"
#INCLUDE "TMKDEF.CH"   
#INCLUDE "REPORT.CH"

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё TMKR022  Ё Autor Ё Armando M. Tessaroli  Ё Data Ё 10/03/03 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Relacao de Ligacoes encerradas pelo tipo de comunicacao    Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_TMKR022(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico TeleMarketing (SUC)                               Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     Ё╠╠
╠╠цддддддддддбддддддддбддддддбдддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁANALISTA  Ё DATA   Ё BOPS ЁMOTIVO DA ALTERACAO                         Ё╠╠
╠╠цддддддддддеддддддддеддддддедддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁMarcelo K Ё10/07/03Ё710   ЁCorrecao do seek na Tabela SU9 indice 1     Ё╠╠
╠╠ЁThiago G  Ё14/07/04Ё811   ЁInclusao do cabecalho padrao e alteracao dasЁ╠╠
╠╠Ё          Ё        Ё      Ёtotalizacoes.                               Ё╠╠
╠╠ЁMichel W. Ё16/08/06Ё99192 ЁAtualizacao para relatorio release 4.       Ё╠╠
╠╠ЁMichel W. Ё21/08/06Ё99192 ЁRevisao de fonte.                           Ё╠╠
╠╠юддддддддддаддддддддаддддддадддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function TMKR022()

Local oReport	//Objeto relatorio TReport (Release 4)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁInsere a opcao AMBOS na pergunta "Tipo de Ligacao" (Mv_Par05) Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё VerIfica as perguntas selecionadas                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte("TMK022",.F.)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё Mv_Par01           // A partir de                            Ё
//Ё Mv_Par02           // Ate a Data                             Ё
//Ё Mv_Par03           // Tipo de Comunicacao                    Ё
//Ё Mv_Par04           // Operador                               Ё
//Ё Mv_Par05           // Tipo de Ligacao /ATIVO/RECEPTIVO       Ё
//Ё Mv_Par06 	       // Segmento 1             ?               Ё
//Ё Mv_Par07 	       // Segmento 2             ?               Ё
//Ё Mv_Par08 		   // Segmento 3             ?               Ё
//Ё Mv_Par09		   // Segmento 4             ?               Ё
//Ё Mv_Par10	       // Segmento 5             ?               Ё
//Ё Mv_Par11           // Segmento 6             ?               Ё
//Ё Mv_Par12           // Segmento 7             ?               Ё
//Ё Mv_Par13           // Segmento 8             ?               Ё
//Ё Mv_Par14           // Midia                  ?               Ё
//Ё Mv_Par15           // Campanha               ?               Ё
//Ё Mv_Par16           // Ocorrencia             ?               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			
//здддддддддддддддддддддд©
//ЁInterface de impressaoЁ
//юдддддддддддддддддддддды
oReport := ReportDef()
oReport:PrintDialog() 

Return(.T.)

/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁTk018Valid╨Autor  ЁArmando M. Tessaroli╨ Data Ё  25/02/03   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁValida os itens do atendimento de acordo com os parametro   ╨╠╠
╠╠╨          Ёinformado para validar se o atendimento sera impresso ou nao╨╠╠
╠╠╨          ЁValida tambem os itens que serao impressos para o           ╨╠╠
╠╠╨          Ёatendimento selecionado.                                    ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё TMKR018                                                    ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
User Function Tk022Valid(cSUC, cSUD)  

Local aArea	:= GetArea()
Local lRet	:= .F.

DbSelectArea(cSUD)
DbSetOrder(1)
If MsSeek(xFilial(cSUD)+(cSUC)->UC_CODIGO)
	While	(!Eof())									.AND.;
			(cSUD)->UD_FILIAL == xFilial(cSUC)			.AND.;
			(cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Seleciona o tipo de reclamacao informado                 Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty(Mv_Par16) .AND. (cSUD)->UD_OCORREN <> Mv_Par16
			(cSUD)->(DbSkip())
			Loop
		Endif
		
		lRet := .T.
		Exit
	End
Endif

RestArea(aArea)

Return(lRet)

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддддддбдддддддбддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁReportDef    Ё Autor ЁMichel W. Mosca     Ё Data Ё16/08/2006Ё╠╠
╠╠цддддддддддедддддддддддддадддддддаддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁRotina que define os itens que serao apresentados no relato-Ё╠╠
╠╠Ё          Ёrio de Ligacoes encerradas X Tipo de Comunicacao            Ё╠╠
╠╠Ё          Ёno release 4.                                               Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё ReportDef()                                                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ                                                            Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё CALL CENTER                                                Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/              
Static Function ReportDef()

Local oReport 				//Objeto relatorio TReport (Release 4)
Local oSection1             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2             //Secao com itens relacionados ao atendimento
Local oSection3             //Secao com totalizadores do relatorio
Local oSection4             //Secao com totalizadores do relatorio
Local oSection5             //Secao com totalizadores do relatorio
Local oSection6             //Secao com totalizadores do relatorio
Local oSection7             //Secao com totalizadores do relatorio
Local cSUC := "SUC"     //Alias da consulta Embedded SQL
Local cSUD := "SUD"
Local aCampos		:= {}						// Campos do alias principal para select
Local aDescCab      :={}
Local aDesc      :={}
Local aUC_Status	:= TkSx3Box("UC_STATUS")		// Busca no dd SX3 as opcoes para o campo
Local aUD_Status	:= TkSx3Box("UD_STATUS")		// Busca no dd SX3 as opcoes para o campo

cSUC	:= GetNextAlias()						// Pega o proximo Alias Disponivel	
cSUD	:= cSUC	                  

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

//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁComeca a imprimir os items do atendimento            Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
aCampos		:= {"UD_ITEM"		,"UD_ASSUNTO"	,"UD_PRODUTO"	,;
				"UD_OCORRENCIA"	,"UD_SOLUCAO"	,"UD_OPERADO"	,;
				"UD_DATA"		,"UD_STATUS"	,"UD_DTEXEC"	,;
				"UD_OBS"		,"UD_OBSEXEC"}
aDesc		:= TkTitX3(aCampos)        
        
// "Ligacoes Encerradas x Tipo de Comunicacao" # // "Este programa emitira uma relacao das Ligacoes"
// "encerradas ordenado por data." # // "Conforme os parametros previamente definidos"
DEFINE REPORT oReport NAME "TMKR022" TITLE STR0001 PARAMETER "TMK022" ACTION {|oReport| Tkr022PrtRpt( oReport, cSUC, cSUD )} DESCRIPTION STR0002 + 	STR0003 + STR0004

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDefine a secao1 do relatorio, informando que o arquivo principal Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DEFINE SECTION oSection1 OF oReport 	TITLE STR0035 TABLES "SUC"   	// "CabeГalho do telemarketing"
DEFINE SECTION oSection2 OF oSection1 	TITLE STR0036 TABLES "SUD" 		// "Itens do telemarketing"
DEFINE SECTION oSection3 OF oReport 	TITLE STR0037 					// "Total dos atendimentos por tipo"
DEFINE SECTION oSection4 OF oReport 	TITLE STR0038 					// "Total dos atendimentos por motivo"
DEFINE SECTION oSection5 OF oReport 	TITLE STR0039 					// "Total dos atendimentos por data e operador"
DEFINE SECTION oSection6 OF oReport 	TITLE STR0040 					// "Total dos atendimentos por operador"
DEFINE SECTION oSection7 OF oReport 	TITLE STR0041 					// "Total dos atendimentos por motivo e por tipo"
                                                    	
//зддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDefine as celulas que irao aparecer na secao1Ё
//юддддддддддддддддддддддддддддддддддддддддддддды            
//зддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁImprime os dados do cabecalho do script dinamico.Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддды

DEFINE CELL NAME "UC_DATA" OF oSection1 Alias "SUC"
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCONT + " - " + TkDadosContato((cSUC)->UC_CODCONT,0,.T.)} TITLE aDescCab[2][1] SIZE 50
DEFINE CELL NAME "UC_CODIGO" OF oSection1 Alias "SUC"		
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{|| FATPDObfuscate(Transform(TkDadosContato((cSUC)->UC_CODCONT,8) + TkDadosContato((cSUC)->UC_CODCONT,4) , "@R (99)9999-9999"),"U5_FCOM1","",.T.)} TITLE aDescCab[4][1] SIZE 15	
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_OPERADO + " - " + FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.)} TITLE aDescCab[5][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkDadosContato((cSUC)->UC_CODCONT,10,.T.)} TITLE aDescCab[6][1] SIZE 50	
DEFINE CELL NAME "UC_OPERACA" OF oSection1 Alias "SUC"
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Posicione("SX5",1,xFilial("SX5")+"T5"+(cSUC)->UC_ENTIDAD,"X5DESCRI()")} TITLE aDescCab[8][1] SIZE 50			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_TIPO  + " - " + Posicione("SUL",1,xFilial("SUL")+(cSUC)->UC_TIPO,"UL_DESC")} TITLE aDescCab[9][1] SIZE 50 
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,1,,.T.)} TITLE aDescCab[10][1]	SIZE 120
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_MIDIA + " - " + Posicione("SUH",1,xFilial("SUH")+(cSUC)->UC_MIDIA,"UH_DESC")} TITLE aDescCab[11][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||FATPDObfuscate(Transform(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,9)+TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,6) , "@R (99)9999-9999"),"A1_NOME",,.T.)} TITLE aDescCab[12][1] SIZE 15
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||(cSUC)->UC_CODCAMP + " - " + Posicione("SUO",1,xFilial("SUO")+(cSUC)->UC_MIDIA,"UO_DESC")} TITLE aDescCab[13][1] SIZE 50
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,2,,.T.)} TITLE aDescCab[14][1] SIZE 40 	
DEFINE CELL NAME "UC_STATUS" OF oSection1 Alias "SUC" BLOCK{||IIF(!Empty((cSUC)->UC_STATUS),aUC_Status[Val((cSUC)->UC_STATUS)],"")} TITLE aDescCab[15][1] SIZE 40
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,10,,.T.)} TITLE aDescCab[16][1] SIZE 40			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||DTOC((cSUC)->UC_PENDENT) + " - " + (cDia:= Tk_DiaSemana((cSUC)->UC_PENDENT,Nil,Nil))} TITLE aDescCab[17][1] SIZE 30
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,3,,.T.)} TITLE aDescCab[18][1] SIZE 120			
DEFINE CELL NAME "UC_HRPEND" OF oSection1 Alias "SUC"  
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,4,,.T.)} TITLE aDescCab[20][1] SIZE 10  						
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||MSMM((cSUC)->UC_CODOBS, 200)} TITLE aDescCab[21][1] SIZE 200	
DEFINE CELL NAME "UC_DTENCER" OF oSection1 Alias "SUC"		   
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Transform(IIF(!Empty((cSUC)->UC_DTENCER), STRZERO(((cSUC)->UC_DTENCER-(cSUC)->UC_DATA),4) ,0),'@E 9999')} TITLE aDescCab[23][1] SIZE 5		
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC")} TITLE aDescCab[24][1] SIZE 50			
DEFINE CELL NAME "" OF oSection1 Alias "SUC" BLOCK{||MSMM((cSUC)->UC_CODMOT, 200)} TITLE aDescCab[25][1] SIZE 200				

DEFINE FUNCTION FROM oSection1:Cell("UC_CODIGO") OF oSection1 FUNCTION COUNT TITLE STR0010 + DtoC(Mv_Par01) + STR0028 + DtoC(Mv_Par02) NO END SECTION 
	    
DEFINE CELL NAME "UD_ITEM" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_ASSUNTO),Posicione("SX5",1,xFilial("SX5")+"T1"+(cSUD)->UD_ASSUNTO,"X5DESCRI()"),STR0009)} TITLE aDesc[2][1] SIZE 30						
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_PRODUTO),	Posicione("SB1",1,xFilial("SB1")+(cSUD)->UD_PRODUTO,"B1_DESC"),STR0009)} TITLE aDesc[3][1] SIZE 30			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_OCORREN),Posicione("SU9",1,xFilial("SU9")+(cSUD)->UD_ASSUNTO+(cSUD)->UD_OCORREN,"U9_DESC"),STR0009)} TITLE aDesc[4][1] SIZE 50			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_SOLUCAO),Posicione("SUQ", 1, xFilial("SUQ")+(cSUD)->UD_SOLUCAO, "UQ_DESC"),STR0009)} TITLE aDesc[5][1] SIZE 30 			
DEFINE CELL NAME "S2_USR" OF oSection2 ALIAS "SUD" TITLE aDesc[6][1] SIZE 40			
DEFINE CELL NAME "UD_DATA" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||IIF(!Empty((cSUD)->UD_STATUS),aUD_Status[Val((cSUD)->UD_STATUS)],"")} TITLE aDesc[8][1] SIZE 20			
DEFINE CELL NAME "UD_DTEXEC" OF oSection2 ALIAS "SUD"			
DEFINE CELL NAME "UD_OBS" OF oSection2 ALIAS "SUD" 			
DEFINE CELL NAME "" OF oSection2 ALIAS "SUD" BLOCK{||MSMM((cSUD)->UD_CODEXEC,200)} TITLE aDesc[11][1] SIZE 200			
	

DEFINE CELL NAME "S3_TPCOM" OF oSection3 TITLE STR0029 SIZE 50		   	
DEFINE CELL NAME "S3_ATIVO" OF oSection3 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S3_PERC_AT" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_RECEP" OF oSection3 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S3_PERC_RP" OF oSection3 TITLE "%" SIZE 10
DEFINE CELL NAME "S3_TOT" OF oSection3 TITLE STR0027 SIZE 10
DEFINE CELL NAME "S3_PERC_TOT" OF oSection3 TITLE "%" SIZE 10		

DEFINE CELL NAME "S4_MOTIV" OF oSection4 TITLE STR0033 SIZE 50			
DEFINE CELL NAME "S4_ATIVO" OF oSection4 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S4_PERC_AT" OF oSection4 TITLE "%" SIZE 10
DEFINE CELL NAME "S4_RECEP" OF oSection4 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S4_PERC_RP" OF oSection4 TITLE "%" SIZE 10
DEFINE CELL NAME "S4_TOT" 	OF oSection4 TITLE STR0027 SIZE 10
DEFINE CELL NAME "S4_PERC_TOT" OF oSection4 TITLE "%" SIZE 10

DEFINE CELL NAME "S5_DATA" OF oSection5 TITLE STR0032 SIZE 10			
DEFINE CELL NAME "S5_OPER" OF oSection5 TITLE STR0034 SIZE 50			
DEFINE CELL NAME "S5_ATIVO" OF oSection5 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S5_RECEP" OF oSection5 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S5_TOT" 	OF oSection5 TITLE STR0027 SIZE 10

DEFINE CELL NAME "S6_OPER" OF oSection6 TITLE STR0034 SIZE 50			
DEFINE CELL NAME "S6_ATIVO" OF oSection6 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S6_RECEP" OF oSection6 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S6_TOT" 	OF oSection6 TITLE STR0027 SIZE 10

DEFINE CELL NAME "S7_MOTIV" OF oSection7 TITLE STR0033 SIZE 50			
DEFINE CELL NAME "S7_TPCOM" OF oSection7 TITLE STR0029 SIZE 10
DEFINE CELL NAME "S7_ATIVO" OF oSection7 TITLE STR0030 SIZE 10
DEFINE CELL NAME "S7_PERC_AT" OF oSection7 TITLE "%" SIZE 10
DEFINE CELL NAME "S7_RECEP" OF oSection7 TITLE STR0031 SIZE 10
DEFINE CELL NAME "S7_PERC_RP" OF oSection7 TITLE "%" SIZE 10 
DEFINE CELL NAME "S7_TOT" 	OF oSection7 TITLE STR0027 SIZE 10
DEFINE CELL NAME "S7_PERC_TOT" OF oSection7 TITLE "%" SIZE 10


Return(oReport)                    

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбдддддддддддддбдддддддбддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁTkr022PrtRpt Ё Autor ЁMichel W. Mosca     Ё Data Ё16/08/2006Ё╠╠
╠╠Ё          Ё             Ё       Ё                    Ё      Ё          Ё╠╠
╠╠цддддддддддедддддддддддддадддддддаддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o ЁRotina responsavel pela impressao do relatorio de           Ё╠╠
╠╠Ё          ЁLigacoes encerradas X Tipo de Comunicacao            		  Ё╠╠
╠╠Ё          Ёno release 4.                                               Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё Tkr022PrtRept(ExpO1,ExpC2,ExpC3)                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁParametrosЁ ExpO1 = objeto relatorio                                   Ё╠╠
╠╠Ё          Ё ExpC2 = alias da query atual                               Ё╠╠
╠╠Ё          Ё ExpC3 = alias da query atual                               Ё╠╠
╠╠Ё          Ё                                                            Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function Tkr022PrtRpt(oReport, cSUC, cSUD)
Local oSection1 := oReport:Section(1)             //Objeto secao 1 do relatorio (Cabecalho, dados do atendimento)
Local oSection2 := oSection1:Section(1)             //Secao com itens relacionados ao atendimento
Local oSection3 := oReport:Section(2)             //Secao com totalizadores do relatorio    
Local oSection4 := oReport:Section(3)             //Secao com totalizadores do relatorio    
Local oSection5 := oReport:Section(4)             //Secao com totalizadores do relatorio
Local oSection6 := oReport:Section(5)             //Secao com totalizadores do relatorio
Local oSection7 := oReport:Section(6)             //Secao com totalizadores do relatorio

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁDeclaracao de variaveis especificas para este relatorioЁ
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Local cData			:= ""							// Apoio
Local cMtEnc		:= ""							// Apoio
Local cCodSUD		:= ""							// Gerencia a quebra do cabecalho do atendimento
Local cCodSUC		:= ""							// Gerencia a quebra dos itens do atendimento
Local nI			:= 0							// Controle
Local aLinhas		:= {}							// Guarda as linhas do memo
Local nTotData		:= 0							// Total de atendimento por dia
Local nTotGer		:= 0							// Total de atendimento geral
Local aTotData		:= {}							// Guarda as totalizacoes
Local aTotGer		:= {}							// Guarda as totalizacoes
Local aTotOper		:= {}							// Guarda as totalizacoes
Local aTotMot		:= {}							// Guarda as totalizacoes
Local aTotMtEnc		:= {}							// Guarda as totalizacoes
Local nPos			:= 0							// Auxiliar do contador
Local dData			:= CtoD("  /  /  ")				// Quebra por data
Local cDesc			:= ""							// VariАvel de auxilio para descricoes.
Local cDescPro		:= ""							// Variavel de auxilio 
Local cDescOco		:= ""					   		// Variavel de auxilio 
Local cDescAss		:= "" 							// Variavel de auxilio 
Local cDescSol		:= ""							// Variavel de auxilio 
Local lPula			:= .F.							// Variavel de auxilio	
Local aCampos		:= {}							// Array com os Campos utilizados como descricao
Local aDescCab		:= {}               			// Descricao dos campos do cabecalho
Local aDesc			:= {}               			// Descricao dos campos dos items

Local aSetField		:= {}						// Parametros para SetField do alias principal
Local cCampos		:= ""						// Campos do alias principal para select
Local cQuery		:= ""						// Armazena a expressao da query para top
Local cWhere		:= ""						// Validacao do segmento de negocio para top
Local cTable	 	:= ""

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁTransforma parametros do tipo Range em expressao SQL para ser utilizada na query Ё
//ЁExemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MakeSqlExpr("TMKR022")      
	
cQuery +=	"% 		SUC.UC_FILIAL = '" + xFilial("SUC") + "' AND " +;
				" 		SUC.UC_CODCANC = '' AND" +;
				" 		SUC.UC_DATA BETWEEN '" + DtoS(Mv_Par01) + "' AND '" + DtoS(Mv_Par02) + "' AND" +;
				" 		SUC.UC_STATUS = '3' AND" 
	If Mv_Par05 == 3
		cQuery += "		(SUC.UC_OPERACA IN ('1','2') OR"
	Else
		cQuery += "		(SUC.UC_OPERACA = '" + IIF(Mv_Par05==1,"2","1") + "' OR"
	EndIf			 
	cQuery += "		SUC.UC_OPERACA = '') AND"
				                             

	//здддддддддддддддддддддддддддд©
	//ЁValida o tipo de comunicacaoЁ
	//юдддддддддддддддддддддддддддды
	If !Empty(Mv_Par03)
		cQuery +=	" 		SUC.UC_TIPO = '" + Mv_Par03 + "' AND"
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁValida o operador do parametro caso informadoЁ
	//юддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(Mv_Par04)
		cQuery +=	" 		SUC.UC_OPERADO = '" + Mv_Par04 + "' AND"
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Imprime somente se a midia estiver no escopo da pergunte Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(Mv_Par14)
		cQuery += " 		SUC.UC_MIDIA = '" + Mv_Par14 + "' AND"
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁSeleciono somente as liga┤■es da campanha inFormada  Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If !Empty(Mv_Par15)
		cQuery += " 		SUC.UC_CODCAMP = '" + Mv_Par15 + "' AND"
	Endif

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁSeleciono somente chamados que nao sao compartilhamentoЁ
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cQuery += " 		SUC.UC_CHAORIG = '' AND"
	
	cQuery +=	"		SUC.D_E_L_E_T_ = ' ' AND"
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁComeca a fazer a amarracao com a tabela SUD dos itens do atendimentoЁ
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cQuery +=	"		SUD.UD_FILIAL = '" + xFilial("SUD") + "' AND" +;
				"		SUD.UD_CODIGO = SUC.UC_CODIGO AND"
    
	If !Empty(Mv_Par16)
		cQuery += "		SUD.UD_OCORREN = '" + Mv_Par16 + "' AND"
	Endif
	
	cQuery +=	"		SUD.D_E_L_E_T_ = ' '"
	
	cQuery +=	" %"
	
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
		FROM 	%table:SUC% SUC, %table:SUD% SUD 
		WHERE	%exp:cQuery%
		ORDER BY %order:SUC%    
    EndSql    
	END REPORT QUERY oSection1 
	oSection2:SetParentQuery()	

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

	//здддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁChamo a funcao que valida os segmentos de negociosЁ
	//юдддддддддддддддддддддддддддддддддддддддддддддддддды
	If (cSUC)->UC_ENTIDAD == "SA1" .or. (cSUC)->UC_ENTIDAD == "SUS"
		If !TKSegmento(	Mv_Par06,			Mv_Par07,		Mv_Par08,	Mv_Par09,;
						Mv_Par10,			Mv_Par11,		Mv_Par12,	Mv_Par13,;
						(cSUC)->UC_ENTIDAD,	(cSUC)->UC_CHAVE)
			(cSUC)->(DbSkip())
			Loop
		Endif
	Endif
	
	#IFNDEF TOP
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Nao seleciono as ligacoes canceladas                     Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty((cSUC)->UC_CODCANC)
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSeleciono somente os atendimentos encerradosЁ
		//юдддддддддддддддддддддддддддддддддддддддддддды
		If Val((cSUC)->UC_STATUS) <> 3
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//здддддддддддддддддддддддддддддддддд©
		//ЁSeleciono os tipos de comunicacoesЁ
		//юдддддддддддддддддддддддддддддддддды
		If !Empty(Mv_Par03) .AND. (cSUC)->UC_TIPO <> Mv_Par03
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//здддддддддддддддддддд©
		//ЁSeleciono o operadorЁ
		//юдддддддддддддддддддды
		If !Empty(Mv_Par04) .AND. (cSUC)->UC_OPERADO <> Mv_Par04
			(cSUC)->(DbSkip())
			Loop
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Seleciona as ligacoes de acordo com o parametro RECEPTIVO/ATIVO/AMBOSЁ
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If Mv_Par05 <> 3
			If Mv_Par05 == 1  //Ativo
				If Val((cSUC)->UC_OPERACA) <> 2 .or. Empty((cSUC)->UC_OPERACA) // ATIVO
					(cSUC)->(DbSkip())
					Loop
				Endif
			Else
				If Val((cSUC)->UC_OPERACA) <> 1 .or. Empty((cSUC)->UC_OPERACA) // RECEPTIVO
					(cSUC)->(DbSkip())
					Loop
				Endif
			Endif
		Endif			

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Imprime somente se a midia estiver no escopo da pergunte Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty(Mv_Par14) .AND. (cSUC)->UC_MIDIA <> Mv_Par14
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//ЁSeleciono somente as ligacoes da campanha informada  Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty(Mv_Par15) .AND. (cSUC)->UC_CODCAMP <> Mv_Par15
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifico os parametros referentes aos itens do atendimento Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !U_Tk022Valid(cSUC, cSUD)
			(cSUC)->(DbSkip())
			Loop
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Nao seleciono chamados que sao compartilhamentos         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If !Empty((cSUC)->UC_CHAORIG)
			(cSUC)->(DbSkip())
			Loop
		EndIf
		
	#ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддд©
	//ЁComeca a imprimir o relatorio neste pontoЁ
	//юддддддддддддддддддддддддддддддддддддддддды
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
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes gerais do atendimento por Tipo de Comunicacao.Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPosTot := Ascan(aTotGer, {|x| x[1]=="TIPO"} )
		If nPosTot == 0
		    If VAL((cSUC)->UC_OPERACA) == RECEPTIVO	// Acumula os totais de atendimentos repcetivos
				AAdd(aTotGer, { "TIPO" 	,; 			// Auxilio
								1 		,; 			// Total das Ligacoes
								1 		,; 			// Total Receptivo
								0 		}) 			// Total Ativo    
			ElseIf VAL((cSUC)->UC_OPERACA) == ATIVO	// Acumula os totais de atendimentos ativos
				AAdd(aTotGer, { "TIPO" 	,; 			// Auxilio
								 1 		,; 			// Total das Ligacoes
								 0 		,; 			// Total Receptivo
								 1 		}) 			// Total Ativo
			Endif
		Else
			aTotGer[nPosTot][2]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 
				aTotGer[nPosTot][3]++
			ElseIf VAL ( (cSUC)->UC_OPERACA ) == ATIVO
				aTotGer[nPostot][4]++
			Endif
		Endif
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes especificas do atendimento por Tipo de Comunicacao.Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := Ascan(aTotGer, {|x| x[1]==(cSUC)->UC_TIPO} )
		If nPos == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 	// Ligacao Receptiva 
				AAdd(aTotGer, { (cSUC)->UC_TIPO	,;		// Tipo da Ligacao   
								 1 				,;		// Total das Ligacoes
								 1 				,;		// Total Receptivo
								 0 } ) 					// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO  	// Ligacao Ativa                     
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

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes gerais do atendimento pelo Motivo do Encerramento.Ё 
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPosTot := Ascan(aTotMot, {|x| x[2]=="MOTIVO"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 		// Ligacao Receptiva 
				AAdd(aTotMot, { "CODIGO"	,;  // Auxilio
				 				"MOTIVO" 	,; 	// Auxilio
				 				1 		 	,;	// Total das Ligacoes
				 				1 			,; 	// Total Receptivo
				 				0})				// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa                     
				AAdd(aTotMot, { "CODIGO" 	,; 	// Auxilio
								 "MOTIVO" 	,; 	// Auxilio
								 1 			,;	// Total das Ligacoes
								 0 			,; 	// Total Receptivo
								 1 } )			// Total Ativo
			Endif
		Else
			aTotMot[nPosTot][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO 		// Ligacao Receptiva 
				aTotMot[nPosTot][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa
				aTotMot[nPosTot][5]++
			Endif
		Endif

		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes especificas do atendimento pelo Motivo do Encerramento.Ё 
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := Ascan(aTotMot , {|x| x[1]==(cSUC)->UC_CODENCE})
		If nPos == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotMot , { (cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
								 1 																,; 	// Total das Ligacoes
								 1 																,; 	// Total Receptivo
								 0 } )																// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotMot , { (cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),; 	// Descricao do Encerramento
								 1 																,; 	// Total das Ligacoes
								 0  														   	,; 	// Total Receptivo
								 1 } )																// Total Ativo
			Endif
		Else
			aTotMot[nPos][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotMot[nPos][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotMot[nPos][5]++
			Endif
		Endif

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes gerais do atendimento por Data e por Operador.Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPosTot := Ascan(aTotData, {|x| x[1]=="DATA"} )
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO	// Ligacao Receptiva 
				AAdd(aTotData,{	"DATA" 		,;			// Auxilio
				 				"CODOPER" 	,;   		// Auxilio
								"OPERADOR" 	,;   		// Auxilio
								1 			,;   		// Total das Ligacoes
								1 			,;   		// Total Receptivo
								0 } ) 					// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa                     
				AAdd(aTotData, { "DATA" 	,;			// Auxilio
								 "CODOPER" 	,;			// Auxilio
								 "OPERADOR" ,;			// Auxilio
								 1 			,;   		// Total das Ligacoes
								 0 			,;   		// Total Receptivo
								 1 } ) 					// Total Ativo
			Endif
		Else
			aTotData[nPosTot][4]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotData[nPosTot][5]++                                     
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotData[nPosTot][6]++
			Endif
		Endif

		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes especificas do atendimento por Data e por Operador.Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := Ascan(aTotData, {|x| x[1]==DtoS((cSUC)->UC_DATA)} )
		If nPos == 0
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotData, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
								 (cSUC)->UC_OPERADO 											,;	// Codigo do Operador
								 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) ,;  // Nome do Operador
								 1 																,;	// Total das Ligacoes
								 1 																,;  // Total Receptivo
								 0 } )														  		// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotData, { DtoS((cSUC)->UC_DATA) 											,; 	// Data do Atendimento
				 				 (cSUC)->UC_OPERADO 											,;	// Codigo do Operador
				 				 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) ,;  // Nome do Operador
				 				 1 																,;	// Total das Ligacoes
				 				 0 																,;  // Total Receptivo
				 				 1 } )														  		// Total Ativo
			Endif
		Else
			nPos := Ascan(aTotData, {|x| x[1]== DtoS((cSUC)->UC_DATA) .AND. x[2]==(cSUC)->UC_OPERADO })
			If nPos = 0
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					AAdd(aTotData, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) , 1 , 1 , 0 } )
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					AAdd(aTotData, { DtoS((cSUC)->UC_DATA) , (cSUC)->UC_OPERADO , FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) , 1 , 0 , 1 } )
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

		//здддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes especificas do atendimento por Operador.Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPosTot := Ascan(aTotOper, {|x| x[1]==(cSUC)->UC_OPERADO})
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotOper, { (cSUC)->UC_OPERADO 											,; // Codigo do Operador
				 				 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) ,; // Nome do Operador
				  				 1 																,; // Total das Ligacoes
							  	 1 																,; // Total Receptivo
								 0 } ) 															   // Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa			
				AAdd(aTotOper, { (cSUC)->UC_OPERADO 											,; // Codigo do Operador
								 FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME",,.T.) ,; // Nome do Operador
								 1 																,; // Total das Ligacoes
								 0																,; // Total Receptivo
								 1 } )															   // Total Ativo
			Endif
		Else
			aTotOper[nPosTot][3]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotOper[nPosTot][4]++
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotOper[nPosTot][5]++
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes gerais do atendimento por Tipo e por Motivo.  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPosTot := Ascan(aTotMtEnc, {|x| x[1]=="CODMOT"})
		If nPosTot == 0
		    If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO	// Ligacao Receptiva 
				AAdd(aTotMtEnc,{ "CODMOT" 	,;			// Auxilio
				 				 "MOTIVO" 	,;   		// Auxilio
								 "TIPO" 	,;   		// Auxilio
								 1 			,;   		// Total das Ligacoes
								 1 			,;   		// Total Receptivo
								 0 	} ) 				// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO 	// Ligacao Ativa                     
				AAdd(aTotMtEnc, { "CODMOT" 	,;			// Auxilio
								  "MOTIVO" 	,;			// Auxilio
								  "TIPO"	,;			// Auxilio
								  1 		,;   		// Total das Ligacoes
								  0 		,;   		// Total Receptivo
								  1 } ) 				// Total Ativo         
			Endif
		Else
			aTotMtEnc[nPosTot][4]++
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva 
				aTotMtEnc[nPosTot][5]++                                     
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				aTotMtEnc[nPosTot][6]++
			Endif
		Endif

		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Totalizacoes especificas do atendimento por Tipo e por Motivo.  Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		nPos := Ascan(aTotMtEnc, {|x| x[3]==(cSUC)->UC_TIPO} ) 
		If nPos == 0
			If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
				AAdd(aTotMtEnc, {(cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),;  // Descricao do Encerramento
								 (cSUC)->UC_TIPO												,;	// Tipo de Comunicacao
								 1 																,;	// Total das Ligacoes
								 1 																,;  // Total Receptivo
								 0 } )																// Total Ativo
			ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
				AAdd(aTotMtEnc, {(cSUC)->UC_CODENCE 											,; 	// Codigo do Encerramento
								 Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),;  // Descricao do Encerramento
								 (cSUC)->UC_TIPO												,;	// Tipo de Comunicacao
								 1 																,;	// Total das Ligacoes
								 0 																,;  // Total Receptivo
								 1 } )																// Total Ativo
			Endif
		Else
			nPos := Ascan(aTotMtEnc, {|x| x[1]==(cSUC)->UC_CODENCE .AND. x[3]==(cSUC)->UC_TIPO })
			If nPos = 0
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					AAdd(aTotMtEnc, { (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , (cSUC)->UC_TIPO , 1 , 1 , 0 } )
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					AAdd(aTotMtEnc, { (cSUC)->UC_CODENCE , Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC") , (cSUC)->UC_TIPO , 1 , 0 , 1 } )
				Endif
			Else
				aTotMtEnc[nPos][4]++
				If VAL( (cSUC)->UC_OPERACA ) == RECEPTIVO // Ligacao Receptiva
					aTotMtEnc[nPos][5]++
				ElseIf VAL( (cSUC)->UC_OPERACA ) == ATIVO // Ligacao Ativa
					aTotMtEnc[nPos][6]++
				Endif
			Endif
		Endif			
	Endif
	
	#IFNDEF TOP
		DbSelectArea(cSUD)
		DbSetOrder(1)
		MsSeek(xFilial(cSUD) + (cSUC)->UC_CODIGO)
		While	(!Eof()) .AND. (cSUD)->UD_CODIGO == (cSUC)->UC_CODIGO
	#ENDIF                                                           
			PswOrder(1)
			aUser := IIF(PswSeek((cSUD)->UD_OPERADO),PswRet(1),{})
			oSection2:Cell("S2_USR"):SetValue(IIF(Len(aUser)>0,aUser[1][2],""))
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

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Tipo na ultima paginaЁ
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды	
	oSection3:Init()
	ASort(aTotGer,2,,{|x,y| x[2] > y[2]})
	For nI := 2 To Len(aTotGer)
		DbSelectArea("SUL")
		DbSetOrder(1)
		If !Empty(aTotGer[nI][1])
			MsSeek(xFilial("SUL")+aTotGer[nI][1])
			oSection3:Cell("S3_TPCOM"):SetValue(SUL->UL_DESC)
		Else	
			oSection3:Cell("S3_TPCOM"):SetValue(STR0008 + Space((TAMSX3("UL_DESC")[1])-Len(STR0008)))//"**NЦo Informado.**"
		Endif 
		If Mv_Par05 == 3 // Ambos
			oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[nI][4],'@E 999,999'))
			oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[nI][4]/aTotGer[1][2]*100, '@E 999.99'))
			oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[nI][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[nI][3]/aTotGer[1][2]*100, '@E 999.99'))
			oSection3:Cell("S3_TOT"):SetValue(Transform(aTotGer[nI][4]+aTotGer[nI][3],'@E 999,999'))
			oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotGer[nI][4]/aTotGer[1][2]*100)+(aTotGer[nI][3]/aTotGer[1][2]*100), '@E 999.99'))
		Else 
			If Mv_Par05 == 1 // Ativo 
				oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[nI][2],'@E 999,999'))
				oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[nI][2]/aTotGer[1][2]*100, '@E 999.99'))
			Else
				oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[nI][2],'@E 999,999'))
				oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[nI][2]/aTotGer[1][2]*100, '@E 999.99'))
			EndIf
		Endif
		oSection3:PrintLine()	
	Next nI

	oSection3:Cell("S3_TPCOM"):SetValue(STR0027) //"TOTAL"
	If Mv_Par05 == 3 // Ambos
		oSection3:Cell("S3_ATIVO"):SetValue(Transform(aTotGer[1][4],'@E 999,999'))
		oSection3:Cell("S3_PERC_AT"):SetValue(Transform(aTotGer[1][4]/aTotGer[1][2]*100, '@E 999.99'))
		oSection3:Cell("S3_RECEP"):SetValue(Transform(aTotGer[1][3],'@E 999,999'))
		oSection3:Cell("S3_PERC_RP"):SetValue(Transform(aTotGer[1][3]/aTotGer[1][2]*100, '@E 999.99'))
		oSection3:Cell("S3_TOT"):SetValue(Transform(aTotGer[1][4]+aTotGer[1][3],'@E 999,999'))
		oSection3:Cell("S3_PERC_TOT"):SetValue(Transform((aTotGer[1][4]/aTotGer[1][2]*100)+(aTotGer[1][3]/aTotGer[1][2]*100), '@E 999.99'))
	Else 
		If Mv_Par05 == 1 // Ativo 
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
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Motivo.				 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	ASort(aTotMot,2,,{|x,y| x[2] > y[2]})
	oSection4:Init()
	For nI := 2 To Len(aTotMot)
		oSection4:Cell("S4_MOTIV"):SetValue(aTotMot[nI][2])		
		If Mv_Par05 == 3 
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotMot[nI][5],'@E 999,999'))				
			oSection4:Cell("S4_PERC_AT"):SetValue(Transform(aTotMot[nI][5]/aTotMot[1][3]*100, '@E 999.99'))				
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotMot[nI][4],'@E 999,999'))				
			oSection4:Cell("S4_PERC_RP"):SetValue(Transform(aTotMot[nI][4]/aTotMot[1][3]*100, '@E 999.99'))				
			oSection4:Cell("S4_TOT"):SetValue(Transform(aTotMot[nI][5]+aTotMot[nI][4],'@E 999,999'))				
			oSection4:Cell("S4_PERC_TOT"):SetValue(Transform((aTotMot[nI][5]/aTotMot[1][3]*100)+(aTotMot[nI][4]/aTotMot[1][3]*100), '@E 999.99'))				
		Else
			If Mv_Par05 == 1 // Ativo
				oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotMot[nI][3],'@E 999,999'))					
				oSection4:Cell("S4_PERC_AT"):SetValue(Transform(aTotMot[nI][3]/aTotMot[1][3]*100, '@E 999.99'))									
			Else
				oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotMot[nI][3],'@E 999,999'))									
				oSection4:Cell("S4_PERC_RP"):SetValue(Transform(aTotMot[nI][3]/aTotMot[1][3]*100, '@E 999.99'))									
			EndIf
		Endif
		oSection4:PrintLine()			
	Next nI

	oSection4:Cell("S4_MOTIV"):SetValue(STR0027) // "TOTAL"		
	If Mv_Par05 == 3 
		oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotMot[1][5],'@E 999,999'))				
		oSection4:Cell("S4_PERC_AT"):SetValue(Transform(aTotMot[1][5]/aTotMot[1][3]*100, '@E 999.99'))				
		oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotMot[1][4],'@E 999,999'))				
		oSection4:Cell("S4_PERC_RP"):SetValue(Transform(aTotMot[1][4]/aTotMot[1][3]*100, '@E 999.99'))				
		oSection4:Cell("S4_TOT"):SetValue(Transform(aTotMot[1][5]+aTotMot[1][4],'@E 999,999'))				
		oSection4:Cell("S4_PERC_TOT"):SetValue(Transform((aTotMot[1][5]/aTotMot[1][3]*100)+(aTotMot[1][4]/aTotMot[1][3]*100), '@E 999.99'))				
	Else
		If Mv_Par05 == 1 // Ativo
			oSection4:Cell("S4_ATIVO"):SetValue(Transform(aTotMot[1][3],'@E 999,999'))					
			oSection4:Cell("S4_PERC_AT"):SetValue(Transform(aTotMot[1][3]/aTotMot[1][3]*100, '@E 999.99'))									
		Else
			oSection4:Cell("S4_RECEP"):SetValue(Transform(aTotMot[1][3],'@E 999,999'))									
			oSection4:Cell("S4_PERC_RP"):SetValue(Transform(aTotMot[1][3]/aTotMot[1][3]*100, '@E 999.99'))									
		EndIf
	Endif
	oSection4:PrintLine()
	oSection4:Finish()	
	aTotMot := {}    
	

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Data e Operador.     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oSection5:Init()
	For nI := 2 To Len(aTotData)
		oSection5:Cell("S5_DATA"):SetValue(StoD(aTotData[nI][1]))
		oSection5:Cell("S5_OPER"):SetValue(aTotData[nI][2]+ " - " + aTotData[nI][3])			
		If Mv_Par05 == 3
			oSection5:Cell("S5_ATIVO"):SetValue(Transform(aTotData[nI][6], '@E 999,999'))				
			oSection5:Cell("S5_RECEP"):SetValue(Transform(aTotData[nI][5], '@E 999,999'))				
			oSection5:Cell("S5_TOT"):SetValue(Transform(aTotData[nI][6]+aTotData[nI][5], '@E 999,999'))				
		Else             
			If Mv_Par05 == 1 // Ativo
				oSection5:Cell("S5_ATIVO"):SetValue(Transform(aTotData[nI][4], '@E 999,999'))				
			Else
				oSection5:Cell("S5_RECEP"):SetValue(Transform(aTotData[nI][4], '@E 999,999'))									
			EndIf
		Endif
		oSection5:PrintLine()
	Next nI
		           
	oSection5:Cell("S5_DATA"):SetValue(STR0027) // "TOTAL"
	oSection5:Cell("S5_OPER"):SetValue("")			
	If Mv_Par05 == 3
		oSection5:Cell("S5_ATIVO"):SetValue(Transform(aTotData[1][6], '@E 999,999'))				
		oSection5:Cell("S5_RECEP"):SetValue(Transform(aTotData[1][5], '@E 999,999'))				
		oSection5:Cell("S5_TOT"):SetValue(Transform(aTotData[1][6]+aTotData[1][5], '@E 999,999'))				
	Else             
		If Mv_Par05 == 1 // Ativo
			oSection5:Cell("S5_ATIVO"):SetValue(Transform(aTotData[1][4], '@E 999,999'))				
		Else
			oSection5:Cell("S5_RECEP"):SetValue(Transform(aTotData[1][4], '@E 999,999'))									
		EndIf
	Endif
	oSection5:PrintLine()
	aTotData := {}	
	oSection5:Finish()

	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Operador.		     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oSection6:Init()
	ASort(aTotOper,,,{|x,y| x[3] > y[3]})
	
	For nI := 1 To Len(aTotOper)
		oSection6:Cell("S6_OPER"):SetValue(aTotOper[nI][1]+ " - " + aTotOper[nI][2])
		If Mv_Par05 == 3
			oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOper[nI][5], '@E 999,999'))			
			oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOper[nI][4], '@E 999,999'))						
			oSection6:Cell("S6_TOT"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))						
		Else                     
			If Mv_Par05 == 1 // Ativo		
				oSection6:Cell("S6_ATIVO"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))						
			Else
				oSection6:Cell("S6_RECEP"):SetValue(Transform(aTotOper[nI][3], '@E 999,999'))							
			EndIf
		Endif				
		oSection6:PrintLine()
	Next nI
	aTotOper := {}		
	oSection6:Finish()	


	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//ЁImprime o total dos atendimentos por Motivo e por Tipo.	 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	oSection7:Init()
	ASort(aTotMtEnc,,,{|x,y| x[1] > y[1]})

	For nI := 2 To Len(aTotMtEnc)
		oSection7:Cell("S7_MOTIV"):SetValue(aTotMtEnc[nI][2])		
		oSection7:Cell("S7_TPCOM"):SetValue(Posicione("SUL",1,xFilial("SUL")+aTotMtEnc[nI][3],"UL_DESC"))							
		If Mv_Par05 == 3 // Ambos
			oSection7:Cell("S7_ATIVO"):SetValue(Transform(aTotMtEnc[nI][6], '@E 999,999'))								
			oSection7:Cell("S7_PERC_AT"):SetValue(Transform(aTotMtEnc[nI][6]/aTotMtEnc[1][4]*100, '@E 999.99'))								
			oSection7:Cell("S7_RECEP"):SetValue(Transform(aTotMtEnc[nI][5], '@E 999,999'))								
			oSection7:Cell("S7_PERC_RP"):SetValue(Transform(aTotMtEnc[nI][5]/aTotMtEnc[1][4]*100, '@E 999.99'))								
			oSection7:Cell("S7_TOT"):SetValue(Transform(aTotMtEnc[nI][6]+aTotMtEnc[nI][5], '@E 999,999'))								
			oSection7:Cell("S7_PERC_TOT"):SetValue(Transform((aTotMtEnc[nI][5]/aTotMtEnc[1][4]*100)+(aTotMtEnc[nI][6]/aTotMtEnc[1][4]*100), '@E 999.99'))								
		Else                         							
		    If Mv_Par05 == 1 // Ativo
				oSection7:Cell("S7_ATIVO"):SetValue(Transform(aTotMtEnc[nI][4], '@E 999,999'))								
				oSection7:Cell("S7_PERC_AT"):SetValue(Transform(aTotMtEnc[nI][4]/aTotMtEnc[1][4]*100, '@E 999.99'))								
			Else // Receptivo
				oSection7:Cell("S7_RECEP"):SetValue(Transform(aTotMtEnc[nI][4], '@E 999,999'))								
				oSection7:Cell("S7_PERC_RP"):SetValue(Transform(aTotMtEnc[nI][4]/aTotMtEnc[1][4]*100, '@E 999.99'))								
			Endif					
		Endif
		oSection7:PrintLine()
		cMtEnc := aTotMtEnc[nI][1]
	Next nI	


	oSection7:Cell("S7_MOTIV"):SetValue(STR0027) // "TOTAL"		
	oSection7:Cell("S7_TPCOM"):SetValue("")							
	If Mv_Par05 == 3 // Ambos
		oSection7:Cell("S7_ATIVO"):SetValue(Transform(aTotMtEnc[1][6], '@E 999,999'))								
		oSection7:Cell("S7_PERC_AT"):SetValue(Transform(aTotMtEnc[1][6]/aTotMtEnc[1][4]*100, '@E 999.99'))								
		oSection7:Cell("S7_RECEP"):SetValue(Transform(aTotMtEnc[1][5], '@E 999,999'))								
		oSection7:Cell("S7_PERC_RP"):SetValue(Transform(aTotMtEnc[1][5]/aTotMtEnc[1][4]*100, '@E 999.99'))								
		oSection7:Cell("S7_TOT"):SetValue(Transform(aTotMtEnc[1][6]+aTotMtEnc[1][5], '@E 999,999'))								
		oSection7:Cell("S7_PERC_TOT"):SetValue(Transform((aTotMtEnc[1][5]/aTotMtEnc[1][4]*100)+(aTotMtEnc[1][6]/aTotMtEnc[1][4]*100), '@E 999.99'))								
	Else                         							
	    If Mv_Par05 == 1 // Ativo
			oSection7:Cell("S7_ATIVO"):SetValue(Transform(aTotMtEnc[1][4], '@E 999,999'))								
			oSection7:Cell("S7_PERC_AT"):SetValue(Transform(aTotMtEnc[1][4]/aTotMtEnc[1][4]*100, '@E 999.99'))								
		Else // Receptivo
			oSection7:Cell("S7_RECEP"):SetValue(Transform(aTotMtEnc[1][4], '@E 999,999'))								
			oSection7:Cell("S7_PERC_RP"):SetValue(Transform(aTotMtEnc[1][4]/aTotMtEnc[1][4]*100, '@E 999.99'))								
		Endif					
	Endif 
	oSection7:PrintLine()
	oSection7:Finish()

	aTotMtEnc := {}

EndIf

Return(.T.)

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

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
    FunГЦo que verifica se a melhoria de Dados Protegidos existe.

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