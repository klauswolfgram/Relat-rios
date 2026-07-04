/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR044C.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR044C  ºAutor  ³Armando M. Tessaroliº Data ³  18/12/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao ira pesquisar os dados do marketing realizado c/º±±
±±º          ³a entidade e o contato selecionados para consulta.          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TMKR044C(lEnd,wnrel,cString,nomeprog,Titulo,oExplorer,aEmpCont)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLi		:= 0			// Linha a ser impressa
Local nMax		:= 58			// Maximo de linhas suportada pelo relatorio
Local cCabec1	:= "" 			// Label dos itens
Local cCabec2	:= "" 			// Label dos itens    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis especificas para este relatorio      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nJ		:= 0		// Controle de loop
Local nCampanha		:= 0	// Controle interno para impressao das campanhas
Local aUO_Atendim	:= TkSx3Box("UO_ATENDIM")	// Busca as opcoes do campo no dicionario
Local aACD_Estac	:= TkSx3Box("ACD_ESTAC")	// Busca as opcoes do campo no dicionario
Local aUZ_Tipo		:= TkSx3Box("UZ_TIPO")		// Busca as opcoes do campo no dicionario
Local aUH_Bound		:= TkSx3Box("UH_BOUND")		// Busca as opcoes do campo no dicionario
Local aUZ_Formato	:= TkSx3Box("UZ_FORMATO")	// Busca as opcoes do campo no dicionario
Local aUZ_ArmResp	:= TkSx3Box("UZ_ARMRESP")	// Busca as opcoes do campo no dicionario
Local aACD_TipExp	:= TkSx3Box("ACD_TIPEXP")	// Busca as opcoes do campo no dicionario
Local aU4_Tele		:= TkSx3Box("U4_TELE")		// Busca no DD SX3 as opcoes para o campo
Local aU4_TipoTel	:= TkSx3Box("U4_TIPOTEL")	// Busca no DD SX3 as opcoes para o campo
Local aU4_TipoEnd	:= TkSx3Box("U4_TIPOEND")	// Busca no DD SX3 as opcoes para o campo
Local aU4_Label		:= TkSx3Box("U4_LABEL")		// Busca no DD SX3 as opcoes para o campo
Local aU4_Forma		:= TkSx3Box("U4_FORMA")		// Busca no DD SX3 as opcoes para o campo
Local aU4_Tipo		:= TkSx3Box("U4_TIPO")		// Busca no DD SX3 as opcoes para o campo
Local aArray		:= {}						// Dados específicos
Local aPDFields		:= {"U7_NOME","UO_RESP","UO_COORDEN","ACE_PALEST"}

FATPDLoad(Nil,Nil,aPDFields)      

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados das campanhas que foram apresentadas.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[6]  
Endif

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Campanha do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0001 //"L I S T A S   C O M   P A R T I C I P A Ç Ã O   D O   C O N T A T O"
	
	DbSelectArea("SU4")
	DbSetOrder(1)		// UO_FILIAL+UO_CODCAMP
	For nJ := 1 to Len(aArray)
		If !MsSeek(xFilial("SU4") + aArray[nJ][1])
			Loop
		Endif
		
		If !Empty(aArray[nJ][14])
			nCampanha++
		Endif
		
		DbSelectArea("SU7")
		DbSetOrder(1)
		MsSeek(xFilial("SU7")+SU4->U4_OPERAD)
		
		DbSelectArea("SUO")
		DbSetOrder(1)
		MsSeek(xFilial("SUO")+SU4->U4_CODCAMP)
		
		DbSelectArea("SUZ")
		DbSetOrder(1)
		MsSeek(xFilial("SUZ")+SU4->U4_SCRIPT)
		
		DbSelectArea("ACD")
		DbSetOrder(1)
		MsSeek(xFilial("ACD")+SU4->U4_EVENTO)
		
		DbSelectArea("SU4")
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0002,20) //"Data da Lista"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_DATA, PesqPict("SU4","U4_LISTA")),10)
		@ nLi,Limite/2	PSay PadR(STR0003,20) //"Operador"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_OPERAD, PesqPict("SU4","U4_OPERAD")),6)
		@ nLi,PCol()+2	PSay PadR(FATPDObfuscate(SU7->U7_NOME,"U7_NOME"),38)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0004,20) //"Lista"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_LISTA, PesqPict("SU4","U4_LISTA")),6)
		@ nLi,Limite/2	PSay PadR(STR0005,20) //"Descrição"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_DESC, PesqPict("SU4","U4_DESC")),45)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 		PSay PadR(STR0006,20) //"Tipo de Lista"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_TIPO),aU4_Tipo[Val(SU4->U4_TIPO)],""),45)
		@ nLi,Limite/2	PSay PadR(STR0007,20) //"Tipo de Contato"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_FORMA),aU4_Forma[Val(SU4->U4_FORMA)],""),45)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0008,20) //"Atendimento"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_TELE),aU4_Tele[Val(SU4->U4_TELE)],""),45)
		@ nLi,Limite/2	PSay PadR(STR0009,20) //"Configuração TMK"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_CONFIG, PesqPict("SU4","U4_CONFIG")),45)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0010,20) //"Tipo do Telefone"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_TIPOTEL),aU4_TipoTel[Val(SU4->U4_TIPOTEL)],""),45)
		@ nLi,Limite/2	PSay PadR(STR0011,20) //"Arquivo"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_MALADIR, PesqPict("SU4","U4_MALADIR")),45)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0012,20) //"Endereço"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_TIPOEND),aU4_TipoEnd[Val(SU4->U4_TIPOEND)],""),45)
		@ nLi,Limite/2	PSay PadR(STR0013,20) //"Etiqueta"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SU4->U4_LABEL),aU4_Label[Val(SU4->U4_LABEL)],""),45)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0011,20) //"Arquivo"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_ETIQUET, PesqPict("SU4","U4_ETIQUET")),45)
		@ nLi,Limite/2	PSay PadR(STR0014,20) //"Campanha"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_CODCAMP, PesqPict("SU4","U4_CODCAMP")),6)
		@ nLi,PCol()+2	PSay PadR(SUO->UO_DESC,38)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0015,20) //"Script"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_SCRIPT, PesqPict("SU4","U4_SCRIPT")),6)
		@ nLi,PCol()+2	PSay PadR(SUZ->UZ_DESC,38)
		@ nLi,Limite/2	PSay PadR(STR0016,20) //"Evento"
		@ nLi,PCol()+1	PSay PadR(Transform(SU4->U4_EVENTO, PesqPict("SU4","U4_EVENTO")),6)
		@ nLi,PCol()+2	PSay PadR(ACD->ACD_DESC,38)
		
		TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		
	Next nJ
	
	If nCampanha == 0
		Return(.T.)
	Endif
	
	// Campanha do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0017 //"C A M P A N H A S   D O   C O N T A T O"
	
	DbSelectArea("SUO")
	DbSetOrder(1)		// UO_FILIAL+UO_CODCAMP
	For nJ := 1 to Len(aArray)
		If !MsSeek(xFilial("SUO") + aArray[nJ][14])
			Loop
		Endif
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
	
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0018 + Alltrim(SUO->UO_CODCAMP) //"Campanha               : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0019 + SUO->UO_DESC //"Título                 : "
		@ nLi,110	PSAY STR0020 + SUO->UO_OBJETIV //"Objetivo               : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0021 + DTOC(SUO->UO_DTINI ) //"Data Inicial           : "
		@ nLi,110	PSAY STR0022 + DTOC(SUO->UO_DTFIM ) //"Data Final             : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0023 + SUO->UO_TIPO + " - " + Iif(SUO->UO_TIPO == "2",STR0024,STR0025) //"Tipo                   : "###"Ativo"###"Receptivo"
		@ nLi,110	PSay STR0026 + IIF(!Empty(SUO->UO_ATENDIM),aUO_Atendim[Val(SUO->UO_ATENDIM)],"") //"Atendimento            : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0027 + SUO->UO_PUBALVO //"Publico Alvo           : "
		@ nLi,110	PSAY STR0028 + Alltrim(Posicione("SX5",1,xFilial("SX5") + "T6" + SUO->UO_PUBALVO,"X5DESCRI()")) //"Descrição              : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0029 + FATPDObfuscate(SUO->UO_RESP	,"UO_RESP") //"Responsável            : "
		@ nLi,110	PSAY STR0030 + FATPDObfuscate(SUO->UO_COORDEN,"UO_COORDEN") //"Coordenador            : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0031 + SUO->UO_DEPTO //"Departamento           : "
		@ nLi,110	PSAY STR0032 + AllTrim(Transform(SUO->UO_META     ,PesqPict("SUO","UO_META"))) //"Meta de Contato        : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0033 + AllTrim(Transform(SUO->UO_METAOP   ,PesqPict("SUO","UO_METAOP"))) //"Meta por Operador      : "
		@ nLi,110	PSAY STR0034 + AllTrim(Transform(SUO->UO_CUSTO    ,PesqPict("SUO","UO_CUSTO"))) //"Custo                  : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0035 + AllTrim(Transform(SUO->UO_PREVEND   ,PesqPict("SUO","UO_PREVEND"))) //"ROI                    : "
		@ nLi,110	PSAY STR0036 + AllTrim(Transform(SUO->UO_RETORNO   ,PesqPict("SUO","UO_RETORNO"))) //"%ROI                   : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0037 + AllTrim(Transform(SUO->UO_PRELEAD   ,PesqPict("SUO","UO_PRELEAD"))) //"Novos Leads Previstos  : "
		@ nLi,110	PSAY STR0038 + AllTrim(Transform(SUO->UO_TOTSUC    ,PesqPict("SUO","UO_TOTSUC"))) //"% Sucesso              : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0039 + AllTrim(Transform(SUO->UO_TOTFRA    ,PesqPict("SUO","UO_TOTFRA"))) //"% Fracasso             : "
		
		TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nli,000 PSAY  __PrtFATLine()
		
		DbSelectArea("SUW")
		DbSetOrder(1)
		MsSeek(xFilial("SUW") + SUO->UO_CODCAMP)
		While 	!EOF()								.AND.;
				xFilial("SUW")== SUW->UW_FILIAL		.AND.;
				SUW->UW_CODCAMP == SUO->UO_CODCAMP
				
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se existir Script³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(SUW->UW_CODSCRI)
				
				DbSelectArea("SUZ")
				DbSetOrder(1)
				If DbSeek(xFilial("SUZ") + SUW->UW_CODSCRI)
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0040 + SUZ->UZ_CODSCRI //"Script                 : "
					@ nLi,110	PSAY STR0019 + SUZ->UZ_DESC //"Título                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0041 + SUZ->UZ_TEMPO //"Tempo Médio Atendimento: "
					@ nLi,110	PSay STR0042 + IIF(!Empty(SUZ->UZ_TIPO),aUZ_Tipo[Val(SUZ->UZ_TIPO)],"") //"Tipo de Atendimento    : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSay STR0043 + IIF(!Empty(SUZ->UZ_FORMATO),aUZ_Formato[Val(SUZ->UZ_FORMATO)],"") //"Formato                : "
					@ nLi,110	PSay STR0044 + IIF(!Empty(SUZ->UZ_ARMRESP),aUZ_ArmResp[Val(SUZ->UZ_ARMRESP)],"") //"Armazena Resposta      : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0045 + AllTrim(Transform( SUZ->UZ_SCORMIN  ,PesqPict("SUZ","UZ_SCORMIN"))) //"Score Minimo           : "
					@ nLi,110	PSAY STR0046 + SUZ->UZ_PROCMIN + " - " + SubStr(Posicione("SX5",1,xFilial("SX5") + "E3" + SUZ->UZ_PROCMIN,"X5DESCRI()"),1,40) //"Ação para score Minimo : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0047 + AllTrim(Transform( SUZ->UZ_SCORMAX  ,PesqPict("SUZ","UZ_SCORMAX"))) //"Score Maximo           : "
					@ nLi,110	PSAY STR0048 + SUZ->UZ_PROCMAX + " - " + SubStr(Posicione("SX5",1,xFilial("SX5") + "E3" + SUZ->UZ_PROCMAX,"X5DESCRI()"),1,40) //"Ação para score Maximo : "
					
					TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,000 PSAY  __PrtFATLine()
					
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao da Midia relacionada aos itens da campanha.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(SUW->UW_MIDIA)
	
				DbSelectArea("SUH")
				DbSetOrder(1)
				If DbSeek(xFilial("SUH") + SUW->UW_MIDIA)
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0049 + SUH->UH_MIDIA //"Mídia                  : "
					@ nli,110 	PSAY STR0028 + SUH->UH_DESC //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0023 + Posicione("SX5",1,xFilial("SX5")+"T4"+SUH->UH_TIPO ,"X5_DESCRI") //"Tipo                   : "
					@ nLi,110	PSay STR0050 + IIF(!Empty(SUH->UH_BOUND),aUH_Bound[Val(SUH->UH_BOUND)],"") //"Tipo de Ligação        : "
					
					TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,000 PSAY  __PrtFATLine()
	
				EndIf
			EndIf
	
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao do Produto relacionada aos itens da campanha.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(SUW->UW_PRODUTO)
			
				DbSelectArea("SB1")
				DbSetOrder(1)
				If DbSeek(xFilial("SB1") + SUW->UW_PRODUTO)
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0051 + SB1->B1_COD //"Produto                : "
					@ nli,110 	PSAY STR0028 + SB1->B1_DESC //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0023 + Posicione("SX5",1,xFilial("SX5")+"02"+SB1->B1_TIPO ,"X5_DESCRI") //"Tipo                   : "
					@ nli,110 	PSAY STR0052 + SB1->B1_UM //"Unidade                : "
				EndIf
				
				TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
				@ nli,000 PSAY  __PrtFATLine()
			Endif
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Impressao dos Eventos.          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(SUW->UW_CODEVE)
		
				DbSelectArea("ACD")
				DbSetOrder(1)
				If DbSeek(xFilial("ACD") + SUW->UW_CODEVE)
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0053 + AllTrim(ACD->ACD_CODIGO) //"Evento                 : "
					@ nLi,110	PSAY STR0028 + AllTrim(ACD->ACD_DESC) PICTURE PesqPict("ACD","ACD_DESC") //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0054 + AllTrim(ACD->ACD_TEMA) PICTURE PesqPict("ACD","ACD_TEMA") //"Tema                   : "
					@ nLi,110	PSay STR0055 + IIF(!Empty(ACD->ACD_TIPEXP),aACD_TipExp[Val(ACD->ACD_TIPEXP)],"") //"Exposição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0056 + Alltrim(If(ACD->ACD_GRATUI = "1",STR0057,STR0058)) //"Gratuito               : "###"Sim"###"Não"
					@ nLi,110	PSAY STR0059 + TRANSFORM(ACD->ACD_PRECO, PesqPict("ACD","ACD_PRECO")) //"Preço                  : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0060 + Alltrim(ACD->ACD_LOCAL)  PICTURE PesqPict("ACD","ACD_LOCAL") //"Local                  : "
					@ nLi,110	PSAY STR0061 + AllTrim(ACD->ACD_END) PICTURE PesqPict("ACD","ACD_END") //"Endereço               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0062 + Alltrim(ACD->ACD_MUN) PICTURE PesqPict("ACD","ACD_MUN") //"Município              : "
					@ nli,110	PSAY STR0063 + AllTrim(ACD->ACD_EST) PICTURE PesqPict("ACD","ACD_EST") //"Estado                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0064 + AllTrim(ACD->ACD_PAIS) PICTURE PesqPict("ACD","ACD_PAIS") //"País                   : "
					@ nli,110	PSAY STR0065 + AllTrim(ACD->ACD_TEL) PICTURE PesqPict("ACD","ACD_TEL") //"Telefone               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0066 + AllTrim(ACD->ACD_HPAGE) PICTURE PesqPict("ACD","ACD_HPAGE") //"Home Page              : "
					@ nli,110	PSAY STR0067 + AllTrim(ACD->ACD_EMAIL) PICTURE PesqPict("ACD","ACD_EMAIL") //"E-mail                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0068 + TRANSFORM(ACD->ACD_DTINI,PesqPict("ACD","ACD_DTINI")) //"Data Inicio            : "
					@ nli,110	PSAY STR0069 + TRANSFORM(ACD->ACD_DTFIM,PesqPict("ACD","ACD_DTFIM")) //"Data Termino           : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0070 + TRANSFORM(ACD->ACD_HRINI,PesqPict("ACD","ACD_HRINI")) //"Hora Inicio            : "
					@ nli,110	PSAY STR0071 + TRANSFORM(ACD->ACD_HRFIM,PesqPict("ACD","ACD_HRFIM")) //"Hora Termino           : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSay STR0072 + IIF(!Empty(ACD->ACD_ESTAC),aACD_Estac[Val(ACD->ACD_ESTAC)],"") //"Estacionamento         : "
					@ nli,110	PSAY STR0061 + AllTrim(ACD->ACD_ENDEST)PICTURE PesqPict("ACD","ACD_ENDEST") //"Endereço               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 PSAY  __PrtThinLine()
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0073 //"Grade                Tema                                       Hr.Ini Hr.Fim Data      Sala         Palestrante                     Empresa"
					
					DbSelectArea("ACE")
					DbSetOrder(1)
					DbSeek(xFilial("ACE") + ACD->ACD_CODIGO)
					While 	!Eof()								.AND.;
							ACE->ACE_FILIAL == xFilial("ACE") 	.AND.;
							ACE->ACE_CODIGO == ACD->ACD_CODIGO
						
						TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
						@ nli,005 PSAY AllTrim(ACE->ACE_GRADE )PICTURE PesqPict("ACE","ACE_GRADE" )	//GRADE
						@ nli,032 PSAY AllTrim(ACE->ACE_TEMA  )PICTURE PesqPict("ACE","ACE_TEMA"  )	//TEMA
						@ nli,074 PSAY AllTrim(ACE->ACE_HRINI )PICTURE PesqPict("ACE","ACE_HRINI" )	//HORA INICIAL
						@ nli,081 PSAY AllTrim(ACE->ACE_HRFIM )PICTURE PesqPict("ACE","ACE_HRFIM" )	//HORA FINAL
						@ nli,089 PSAY TRANSFORM(ACE->ACE_DATA , PesqPict("ACE","ACE_DATA"  )) 	   	//DATA
						@ nli,100 PSAY AllTrim(ACE->ACE_SALA  )PICTURE PesqPict("ACE","ACE_SALA"  )	//SALA
						@ nli,111 PSAY FATPDObfuscate(AllTrim(ACE->ACE_PALEST),"ACE_PALEST") PICTURE PesqPict("ACE","ACE_PALEST")	//PALESTRANTE
						@ nli,144 PSAY AllTrim(ACE->ACE_EMP   )PICTURE PesqPict("ACE","ACE_EMP"   )	//EMPRESA
						
						DbSelectArea("ACE")
						DbSkip()
					End  
					
					TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,010 PSAY  __PrtThinLine()
				Endif
			Endif
			
			DbSelectarea("SUW")
			DbSkip()
		End
	Next nJ
Endif

FATPDUnload()
FATPDLogUser("TMKR044C")

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
/*/{Protheus.doc} FATPDLogUser
    @description
    Realiza o log dos dados acessados, de acordo com as informações enviadas, 
    quando a regra de auditoria de rotinas com campos sensíveis ou pessoais estiver habilitada
	Remover essa função quando não houver releases menor que 12.1.27

   @type  Function
    @sample FATPDLogUser(cFunction, nOpc)
    @author Squad CRM & Faturamento
    @since 06/01/2020
    @version P12
    @param cFunction, Caracter, Rotina que será utilizada no log das tabelas
    @param nOpc, Numerico, Opção atribuída a função em execução - Default=0

    @return lRet, Logico, Retorna se o log dos dados foi executado. 
    Caso o log esteja desligado ou a melhoria não esteja aplicada, também retorna falso.

/*/
//-----------------------------------------------------------------------------
Static Function FATPDLogUser(cFunction, nOpc)

	Local lRet := .F.

	If FATPDActive()
		lRet := FTPDLogUser(cFunction, nOpc)
	EndIf 

Return lRet  

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