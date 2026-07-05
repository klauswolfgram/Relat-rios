/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR044A.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR044A  ºAutor  ³ Vendas Clientes    º Data ³  18/12/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao ira pesquisar os dados do contato que foi seleciº±±
±±º          ³onado para a pesquisa da consulta do perfil.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TMKR044A(lEnd,wnrel,cString,nomeprog,Titulo,oExplorer,aEmpCont)

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
Local nI		:= 0		// Controle de loop
Local nJ		:= 0		// Controle de loop
Local cDesc		:= ""		// Guarda o resultado da pesquisa na base de dados
Local cDescAss	:= ""		// Guarda o resultado da pesquisa na base de dados
Local cDescPro	:= ""		// Guarda o resultado da pesquisa na base de dados
Local cDescOco	:= ""		// Guarda o resultado da pesquisa na base de dados
Local cDescSol	:= ""		// Guarda o resultado da pesquisa na base de dados
Local aLinhas	:= {}		// Guarda as linhas do campo memo que deverão ser impressas
Local aUC_Operaca	:= TkSx3Box("UC_OPERACA")	// Busca as opcoes do campo no dicionario
Local aUC_Status	:= TkSx3Box("UC_STATUS")	// Busca as opcoes do campo no dicionario
Local aUD_Status	:= TkSx3Box("UD_STATUS")	// Busca as opcoes do campo no dicionario
Local aUO_Atendim	:= TkSx3Box("UO_ATENDIM")	// Busca as opcoes do campo no dicionario
Local aACD_Estac	:= TkSx3Box("ACD_ESTAC")	// Busca as opcoes do campo no dicionario
Local aUZ_Tipo		:= TkSx3Box("UZ_TIPO")		// Busca as opcoes do campo no dicionario
Local aUH_Bound		:= TkSx3Box("UH_BOUND")		// Busca as opcoes do campo no dicionario
Local aUZ_Formato	:= TkSx3Box("UZ_FORMATO")	// Busca as opcoes do campo no dicionario
Local aUZ_ArmResp	:= TkSx3Box("UZ_ARMRESP")	// Busca as opcoes do campo no dicionario
Local aACD_TipExp	:= TkSx3Box("ACD_TIPEXP")	// Busca as opcoes do campo no dicionario
Local aArray		:= {}						// Array com os dados específicos
Local aPDFields		:= {}

aPDFields := {"U5_CONTAT","U5_END","U5_BAIRRO","U5_MUN","U5_EST","U5_CEP","U5_DDD",;
	"U5_FONE","U5_CELULAR","U5_FAX","U5_FCOM1","U5_EMAIL","U7_NOME","UO_RESP","UO_COORDEN","ACE_PALEST"}

FATPDLoad(/*cUserPDA*/, /*aAlias*/, aPDFields)

DbSelectarea("SU5")
DbSetOrder(1)
MsSeek(xFilial("SU5") + aEmpCont[1][3])

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que incrementa a linha e verifica a quebra de pagina³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TkIncLine(@nLi,3,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtFatLine()

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay STR0001 //"D A D O S   D O   C O N T A T O"

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtFatLine()

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0002,25) //"Código do contato"
@ nLi,PCol()+1	PSay PadR(SU5->U5_CODCONT,80)
@ nLi,Limite/2	PSay PadR(STR0003,25) //"Nome do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_CONTAT,"U5_CONTAT"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0004,25) //"Endereço do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_END,"U5_END"),80)
@ nLi,Limite/2	PSay PadR(STR0005,25) //"Bairro do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_BAIRRO,"U5_BAIRRO"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0006,25) //"Município do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_MUN,"U5_MUN"),80)
@ nLi,Limite/2	PSay PadR(STR0007,25) //"CEP do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_CEP,"U5_CEP"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0008,25) //"UF do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_EST,"U5_EST"),80)
@ nLi,Limite/2	PSay PadR(STR0009,25) //"DDD do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_DDD,"U5_DDD"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0010,25) //"Telefone Residencial"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_FONE,"U5_FONE"),80)
@ nLi,Limite/2	PSay PadR(STR0011,25) //"Telefone Celular"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_CELULAR,"U5_CELULAR"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0012,25) //"Fax do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_FAX,"U5_FAX"),80)
@ nLi,Limite/2	PSay PadR(STR0013,25) //"Telefone Comercial"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_FCOM1,"U5_FCOM1"),80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0014,25) //"e-mail do contato"
@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(SU5->U5_EMAIL,"U5_EMAIL"),80)
@ nLi,Limite/2	PSay PadR(STR0015,25) //"Home Page do contato"
@ nLi,PCol()+1	PSay PadR(SU5->U5_URL,80)

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtThinLine()

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay STR0016 //"Entidade  Código  Nome                            Endereço                        Município             UF  CEP         Fone Cial        e-mail                          Home Page                       DDD"

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtThinLine()

DbSelectArea("AC8")
DbSetOrder(1)		// AC8_FILIAL+AC8_CODCON+AC8_ENTIDA+AC8_FILENT+AC8_CODENT
MsSeek(xFilial("AC8") + SU5->U5_CODCONT)
While	!Eof()								.AND.;
		AC8->AC8_FILIAL == xFilial("AC8")	.AND.;
		AC8->AC8_CODCON == SU5->U5_CODCONT
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay PadR(AC8->AC8_ENTIDA,8)
	@ nLi,PCol()+2	PSay PadR(AC8->AC8_CODENT,TkEntTam(AC8->AC8_ENTIDA)[1])
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 1,,.T.),30)		// Nome
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 2,,.T.),30)		// Endereco
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 3,,.T.),20)		// Municipio
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 4,,.T.),02)		// Estado
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 5,,.T.),10)		// CEP
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 6,,.T.),15)		// Telefone comercial 1
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 7,,.T.),30)		// e-mail
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 8,,.T.),30)		// Home page
	@ nLi,PCol()+2	PSay PadR(TkEntidade(AC8->AC8_ENTIDA, AC8->AC8_CODENT, 9,,.T.),05)		// DDD
	
	DbSelectArea("AC8")
	DbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados do item de telemarketing.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[1]
EndIf

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Atendimentos do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0017 //"A T E N D I M E N T O S   D O   C O N T A T O"
	
	DbSelectArea("SUC")
	DbSetOrder(1)
	For nJ := 1 to Len(aArray)
		MsSeek(xFilial("SUC") + aArray[nJ][1])
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0018,25) //"Código do Atendimento"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_CODIGO,6)
		@ nLi,Limite/3	PSay PadR(STR0019,25) //"Data do Atendimento"
		@ nLi,PCol()+1	PSay PadR(DtoC(SUC->UC_DATA),10)
		
		If !Empty(SUC->UC_CODCONT)
			DbSelectArea("SU5")
			DbSetOrder(1)
			If MsSeek(xFilial("SU5")+SUC->UC_CODCONT)
				cDesc := SU5->U5_CONTAT
			Else 
				cDesc := STR0020 //"Não localizado no cadastro..."
			EndIf
		Else
			cDesc := STR0021 //"Não informado no atendimento..."
		EndIf
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0002,25) //"Código do Contato"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_CODCONT,6)
		@ nLi,Limite/3	PSay PadR(STR0003,25) //"Nome do Contato"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U5_CONTAT"),118)
	
		DbSelectArea("SX2")
		DbSetOrder(1)
		If MsSeek(SUC->UC_ENTIDAD)
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay PadR(STR0022,25) //"Descrição da Entidade"
			@ nLi,PCol()+1	PSay PadR(X2NOME(),46)
			@ nLi,Limite/3	PSay PadR(STR0023,25) //"Nome da Empresa"
			@ nLi,PCol()+1	PSay PadR(TkEntidade(SUC->UC_ENTIDAD,SUC->UC_CHAVE,1,,.T.),118)
			DbSelectArea("SUC")
		Else
			@ nLi,PCol()+1	PSay PadR(STR0020,46) //"Não localizado no cadastro..."
		EndIf	
		
		If !Empty(SUC->UC_OPERADO) 
			DbSelectArea("SU7")
			DbSetOrder(1)
			If MsSeek(xFilial("SU7")+SUC->UC_OPERADO)
				cDesc := SU7->U7_NOME
			Else 
				cDesc := STR0020 //"Não localizado no cadastro..."
			EndIf
		Else
			cDesc := STR0021 //"Não informado no atendimento..."
		EndIf
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0024,25) //"Código do Operador"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_OPERADO,6)
		@ nLi,Limite/3	PSay PadR(STR0025,25) //"Nome do Operador"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U7_NOME"),118)
		DbSelectArea("SUC")
	
		If !Empty(SUC->UC_MIDIA) 
			DbSelectArea("SUH")
			DbSetOrder(1)
			If MsSeek(xFilial("SUH")+SUC->UC_MIDIA)
				cDesc := SUH->UH_DESC
			Else 
				cDesc := STR0020 //"Não localizado no cadastro..."
			EndIf
		Else
			cDesc := STR0021 //"Não informado no atendimento..."
		EndIf	
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0026,25) //"Código da Mídia"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_MIDIA,6)
		@ nLi,Limite/3	PSay PadR(STR0027,25) //"Descrição da Mídia"
		@ nLi,PCol()+1	PSay PadR(cDesc,118)
		DbSelectArea("SUC")
	
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0028,25) //"Tipo da Ligação"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SUC->UC_OPERACA),aUC_Operaca[Val(SUC->UC_OPERACA)],""),43)
		@ nLi,Limite/3	PSay PadR(STR0029,25) //"Status do Atendimento"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty(SUC->UC_STATUS),aUC_Status[Val(SUC->UC_STATUS)],""),118)
	
		If !Empty(SUC->UC_TIPO) 
			DbSelectArea("SUL")
			DbSetOrder(1)
			If MsSeek(xFilial("SUL")+SUC->UC_TIPO)
				cDesc := SUL->UL_DESC
			Else 
				cDesc := STR0020 //"Não localizado no cadastro..."
			EndIf
		Else
			cDesc := STR0021 //"Não informado no atendimento..."
		EndIf	                    
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0030,25) //"Código da Comunicação"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_TIPO,6)
		@ nLi,Limite/3	PSay PadR(STR0031,25) //"Descrição da Comunicação"
		@ nLi,PCol()+1	PSay PadR(cDesc,118)
		DbSelectArea("SUC")
	
		If !Empty(SUC->UC_CODCAMP) 
			DbSelectArea("SUO")
			DbSetOrder(1)
			If MsSeek(xFilial("SUO")+SUC->UC_CODCAMP)
				cDesc := SUO->UO_DESC
			Else 
				cDesc := STR0020 //"Não localizado no cadastro..."
			EndIf
		Else
			cDesc := STR0021 //"Não informado no atendimento..."
		EndIf	                    
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0032,25) //"Código da Campanha"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_CODCAMP,6)
		@ nLi,Limite/3	PSay PadR(STR0033,25) //"Descrição da Campanha"
		@ nLi,PCol()+1	PSay PadR(cDesc,118)
		DbSelectArea("SUC")
	
					
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0034,25) //"Data do Retorno"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_PENDENT,10)
		@ nLi,Limite/3	PSay PadR(STR0035,25) //"Hora do Retorno"
		@ nLi,PCol()+1	PSay PadR(SUC->UC_HRPEND,8)
	
		aLinhas := TkMemo(SUC->UC_CODOBS, 195)
		For nI := 1 to Len(aLinhas)
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			If nI == 1
				@ nLi,000		PSay PadR(STR0036,25) //"Observação"
			Endif
			@ nLi,26 PSay aLinhas[nI]
		Next nI
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0037, Limite) //"Item  Assunto                              Produto                         Ocorrência                      Ação                                                Responsável      Dt Ação     Status        Execução"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()
		
		DbSelectArea("SUD")
		DbSetOrder(1)
		MsSeek(xFilial("SUD") + SUC->UC_CODIGO)
		While	!Eof()								.AND.;
				SUD->UD_FILIAL == xFilial("SUD")	.AND.;
				SUD->UD_CODIGO == SUC->UC_CODIGO
			
			DbSelectArea("SX5")
			DbSetOrder(1)      		// Codigo do Assunto 
			If !Empty(SUD->UD_ASSUNTO)
				If MsSeek(xFilial("SX5")+"T1"+SUD->UD_ASSUNTO)
					cDescAss := X5DESCRI()		
				Else
					cDescAss := STR0020 //"Não localizado no cadastro..."
				EndIf
			Else
				cDescAss := STR0021 //"Não informado no atendimento..."
			EndIf
			
			DbSelectArea("SB1")
			DbSetOrder(1)
			If !Empty(SUD->UD_PRODUTO)
				If 	MsSeek(xFilial("SB1")+SUD->UD_PRODUTO)
					cDescPro := SB1->B1_DESC
				Else
					cDescPro := STR0020 //"Não localizado no cadastro..."
				EndIf
			Else
				cDescPro := STR0021 //"Não informado no atendimento..."
			EndIf
			
			DbSelectArea("SU9")
			DbSetOrder(1)          
			If !Empty(SUD->UD_OCORREN)
				If 	MsSeek(xFilial("SU9")+ SUD->UD_ASSUNTO + SUD->UD_OCORREN)// Codigo do Assunto + Codigo da Ocorrencia
					cDescOco := SU9->U9_DESC
				Else
					cDescOco := STR0020 //"Não localizado no cadastro..."
				EndIf
			Else
				cDescOco := STR0021 //"Não informado no atendimento..."
			EndIf
			
			DbSelectArea("SUQ")
			DbSetOrder(1)
			If !Empty(SUD->UD_SOLUCAO)
				If 	MsSeek(xFilial("SUQ")+SUD->UD_SOLUCAO)
					cDescSol := SUQ->UQ_DESC
				Else
					cDescSol := STR0020 //"Não localizado no cadastro..."
				EndIf
			Else
				cDescSol := STR0021 //"Não informado no atendimento..."
			EndIf
			
			PswOrder(1)
			aUser := IIF(PswSeek(SUD->UD_OPERADO),PswRet(1),{})
			
			DbSelectArea("SUC")
			
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay PadR(SUD->UD_ITEM,4)
			@ nLi,PCol()+2	PSay PadR(cDescAss,35)
			@ nLi,PCol()+2	PSay PadR(cDescPro,30)
			@ nLi,PCol()+2	PSay PadR(cDescOco,30)
			@ nLi,PCol()+2	PSay PadR(cDescSol,50)
			@ nLi,PCol()+2	PSay PadR(IIF(Len(aUser)>0,aUser[1][2],""),15)
			@ nLi,PCol()+2	PSay PadR(SUD->UD_DATA,10)
			@ nLi,PCol()+2	PSay PadR(IIF(!Empty(SUD->UD_STATUS),aUD_Status[Val(SUD->UD_STATUS)],""),12)
			@ nLi,PCol()+2	PSay PadR(SUD->UD_DTEXEC,10)
			If !Empty(SUD->UD_OBS)
				TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
				@ nLi,000		PSay PadR(STR0038,30) //"Observação do atendimento"
				@ nLi,PCol()+1	PSay PadR(SUD->UD_OBS,190)
			Endif
			If !Empty(SUD->UD_CODEXEC)
				aLinhas := TkMemo(SUD->UD_CODEXEC, 190)
				For nI := 1 to Len(aLinhas)
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					If nI == 1
						@ nLi,000 PSay PadR(STR0039,30) //"Complemento da execução"
					Endif
					@ nLi,031 PSay aLinhas[nI]
				Next nI
			Endif
			
			DbSelectArea("SUD")
			DbSkip()
		End
		TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		
	Next nJ
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados das campanhas que foram apresentadas.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[2]
EndIf

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Campanha do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0040 //"C A M P A N H A S   D O   C O N T A T O"
	
	DbSelectArea("SUO")
	DbSetOrder(1)		// UO_FILIAL+UO_CODCAMP
	For nJ := 1 to Len(aArray)
		MsSeek(xFilial("SUO") + aArray[nJ][1])
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
	
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0041 + Alltrim(SUO->UO_CODCAMP) //"Campanha               : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0042 + SUO->UO_DESC //"Título                 : "
		@ nLi,110	PSAY STR0043 + SUO->UO_OBJETIV //"Objetivo               : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0044 + DTOC(SUO->UO_DTINI ) //"Data Inicial           : "
		@ nLi,110	PSAY STR0045 + DTOC(SUO->UO_DTFIM ) //"Data Final             : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0046 + SUO->UO_TIPO + " - " + Iif(SUO->UO_TIPO == "2",STR0047,STR0048) //"Tipo                   : "###"Ativo"###"Receptivo"
		@ nLi,110	PSay STR0049 + IIF(!Empty(SUO->UO_ATENDIM),aUO_Atendim[Val(SUO->UO_ATENDIM)],"") //"Atendimento            : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0050 + SUO->UO_PUBALVO //"Publico Alvo           : "
		@ nLi,110	PSAY STR0051 + Alltrim(Posicione("SX5",1,xFilial("SX5") + "T6" + SUO->UO_PUBALVO,"X5DESCRI()")) //"Descrição              : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0052 + FATPDObfuscate(SUO->UO_RESP,"UO_RESP") //"Responsável            : "
		@ nLi,110	PSAY STR0053 + FATPDObfuscate(SUO->UO_COORDEN,"UO_COORDEN") //"Coordenador            : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0054 + SUO->UO_DEPTO //"Departamento           : "
		@ nLi,110	PSAY STR0055 + AllTrim(Transform(SUO->UO_META     ,PesqPict("SUO","UO_META"))) //"Meta de Contato        : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0056 + AllTrim(Transform(SUO->UO_METAOP   ,PesqPict("SUO","UO_METAOP"))) //"Meta por Operador      : "
		@ nLi,110	PSAY STR0057 + AllTrim(Transform(SUO->UO_CUSTO    ,PesqPict("SUO","UO_CUSTO"))) //"Custo                  : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0058 + AllTrim(Transform(SUO->UO_PREVEND   ,PesqPict("SUO","UO_PREVEND"))) //"ROI                    : "
		@ nLi,110	PSAY STR0059 + AllTrim(Transform(SUO->UO_RETORNO   ,PesqPict("SUO","UO_RETORNO"))) //"%ROI                   : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0060 + AllTrim(Transform(SUO->UO_PRELEAD   ,PesqPict("SUO","UO_PRELEAD"))) //"Novos Leads Previstos  : "
		@ nLi,110	PSAY STR0061 + AllTrim(Transform(SUO->UO_TOTSUC    ,PesqPict("SUO","UO_TOTSUC"))) //"% Sucesso              : "
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSAY STR0062 + AllTrim(Transform(SUO->UO_TOTFRA    ,PesqPict("SUO","UO_TOTFRA"))) //"% Fracasso             : "
		
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
					@ nli,005 	PSAY STR0063 + SUZ->UZ_CODSCRI //"Script                 : "
					@ nLi,110	PSAY STR0042 + SUZ->UZ_DESC //"Título                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0064 + SUZ->UZ_TEMPO //"Tempo Médio Atendimento: "
					@ nLi,110	PSay STR0065 + IIF(!Empty(SUZ->UZ_TIPO),aUZ_Tipo[Val(SUZ->UZ_TIPO)],"") //"Tipo de Atendimento    : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSay STR0066 + IIF(!Empty(SUZ->UZ_FORMATO),aUZ_Formato[Val(SUZ->UZ_FORMATO)],"") //"Formato                : "
					@ nLi,110	PSay STR0067 + IIF(!Empty(SUZ->UZ_ARMRESP),aUZ_ArmResp[Val(SUZ->UZ_ARMRESP)],"") //"Armazena Resposta      : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0068 + AllTrim(Transform( SUZ->UZ_SCORMIN  ,PesqPict("SUZ","UZ_SCORMIN"))) //"Score Minimo           : "
					@ nLi,110	PSAY STR0069 + SUZ->UZ_PROCMIN + " - " + SubStr(Posicione("SX5",1,xFilial("SX5") + "E3" + SUZ->UZ_PROCMIN,"X5DESCRI()"),1,40) //"Ação para score Minimo : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0070 + AllTrim(Transform( SUZ->UZ_SCORMAX  ,PesqPict("SUZ","UZ_SCORMAX"))) //"Score Maximo           : "
					@ nLi,110	PSAY STR0071 + SUZ->UZ_PROCMAX + " - " + SubStr(Posicione("SX5",1,xFilial("SX5") + "E3" + SUZ->UZ_PROCMAX,"X5DESCRI()"),1,40) //"Ação para score Maximo : "
					
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
					@ nli,005 	PSAY STR0072 + SUH->UH_MIDIA //"Mídia                  : "
					@ nli,110 	PSAY STR0051 + SUH->UH_DESC //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0046 + Posicione("SX5",1,xFilial("SX5")+"T4"+SUH->UH_TIPO ,"X5_DESCRI") //"Tipo                   : "
					@ nLi,110	PSay STR0073 + IIF(!Empty(SUH->UH_BOUND),aUH_Bound[Val(SUH->UH_BOUND)],"") //"Tipo de Ligação        : "
					
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
					@ nli,005 	PSAY STR0074 + SB1->B1_COD //"Produto                : "
					@ nli,110 	PSAY STR0051 + SB1->B1_DESC //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 	PSAY STR0046 + Posicione("SX5",1,xFilial("SX5")+"02"+SB1->B1_TIPO ,"X5_DESCRI") //"Tipo                   : "
					@ nli,110 	PSAY STR0075 + SB1->B1_UM //"Unidade                : "
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
					@ nLi,005	PSAY STR0076 + AllTrim(ACD->ACD_CODIGO) //"Evento                 : "
					@ nLi,110	PSAY STR0051 + AllTrim(ACD->ACD_DESC) PICTURE PesqPict("ACD","ACD_DESC") //"Descrição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0077 + AllTrim(ACD->ACD_TEMA) PICTURE PesqPict("ACD","ACD_TEMA") //"Tema                   : "
					@ nLi,110	PSay STR0078 + IIF(!Empty(ACD->ACD_TIPEXP),aACD_TipExp[Val(ACD->ACD_TIPEXP)],"") //"Exposição              : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0079 + Alltrim(If(ACD->ACD_GRATUI = "1",STR0080,STR0081)) //"Gratuito               : "###"Sim"###"Não"
					@ nLi,110	PSAY STR0082 + TRANSFORM(ACD->ACD_PRECO, PesqPict("ACD","ACD_PRECO")) //"Preço                  : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSAY STR0083 + Alltrim(ACD->ACD_LOCAL)  PICTURE PesqPict("ACD","ACD_LOCAL") //"Local                  : "
					@ nLi,110	PSAY STR0084 + AllTrim(ACD->ACD_END) PICTURE PesqPict("ACD","ACD_END") //"Endereço               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0085 + Alltrim(ACD->ACD_MUN) PICTURE PesqPict("ACD","ACD_MUN") //"Município              : "
					@ nli,110	PSAY STR0086 + AllTrim(ACD->ACD_EST) PICTURE PesqPict("ACD","ACD_EST") //"Estado                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0087 + AllTrim(ACD->ACD_PAIS) PICTURE PesqPict("ACD","ACD_PAIS") //"País                   : "
					@ nli,110	PSAY STR0088 + AllTrim(ACD->ACD_TEL) PICTURE PesqPict("ACD","ACD_TEL") //"Telefone               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0089 + AllTrim(ACD->ACD_HPAGE) PICTURE PesqPict("ACD","ACD_HPAGE") //"Home Page              : "
					@ nli,110	PSAY STR0090 + AllTrim(ACD->ACD_EMAIL) PICTURE PesqPict("ACD","ACD_EMAIL") //"E-mail                 : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0091 + TRANSFORM(ACD->ACD_DTINI,PesqPict("ACD","ACD_DTINI")) //"Data Inicio            : "
					@ nli,110	PSAY STR0092 + TRANSFORM(ACD->ACD_DTFIM,PesqPict("ACD","ACD_DTFIM")) //"Data Termino           : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0093 + TRANSFORM(ACD->ACD_HRINI,PesqPict("ACD","ACD_HRINI")) //"Hora Inicio            : "
					@ nli,110	PSAY STR0094 + TRANSFORM(ACD->ACD_HRFIM,PesqPict("ACD","ACD_HRFIM")) //"Hora Termino           : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nLi,005	PSay STR0095 + IIF(!Empty(ACD->ACD_ESTAC),aACD_Estac[Val(ACD->ACD_ESTAC)],"") //"Estacionamento         : "
					@ nli,110	PSAY STR0084 + AllTrim(ACD->ACD_ENDEST)PICTURE PesqPict("ACD","ACD_ENDEST") //"Endereço               : "
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005 PSAY  __PrtThinLine()
					
					TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					@ nli,005	PSAY STR0096 //"Grade                Tema                                       Hr.Ini Hr.Fim Data      Sala         Palestrante                     Empresa"
					
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
						@ nli,111 PSAY AllTrim(FATPDObfuscate(ACE->ACE_PALEST,"ACE_PALEST"))PICTURE PesqPict("ACE","ACE_PALEST")	//PALESTRANTE
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
aSize(aPDFields, 0)
FATPDLogUser("TMKR044A")
	
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