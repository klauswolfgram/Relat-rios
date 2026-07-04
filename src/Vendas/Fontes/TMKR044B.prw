/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR044B.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR044B  ºAutor  ³Armando M. Tessaroliº Data ³  18/12/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao ira pesquisar os dados da entidade que foi sele-º±±
±±º          ³cionado para a pesquisa da consulta do perfil.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TMKR044B(lEnd,wnrel,cString,nomeprog,Titulo,oExplorer,aEmpCont)

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
Local aUA_Oper		:= TkSx3Box("UA_OPER")		// Pesquisa as opcoes do campo no DD SX3
Local aUA_TMK		:= TkSx3Box("UA_TMK")		// Pesquisa as opcoes do campo no DD SX3
Local aUA_TpFrete	:= TkSx3Box("UA_TPFRETE")	// Pesquisa as opcoes do campo no DD SX3
Local aACG_Status	:= TkSx3Box("ACG_STATUS")	// Pesquisa as opcoes do campo no DD SX3
Local aACF_Opera	:= TkSx3Box("ACF_OPERA")	// Pesquisa as opcoes do campo no DD SX3
Local aArray		:= {}						// Array com os dados específicos
Local aPDFields		:= {"A1_NOME","U5_CONTAT","U7_NOME","A3_NOME"}

FATPDLoad(Nil,Nil,aPDFields)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que incrementa a linha e verifica a quebra de pagina³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TkIncLine(@nLi,3,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtFatLine()

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay STR0001 //"D A D O S   D A   E N T I D A D E"

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtFatLine()

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0002,25) //"Entidade / Código"
@ nLi,PCol()+1	PSay PadR(aEmpCont[9][3] + " / " + aEmpCont[10][3],80)
@ nLi,Limite/2	PSay PadR(STR0003,25) //"Nome da Entidade"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 1,,.T.),80)		// Nome

TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0004,25) //"Endereço"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 2,,.T.),80)		// Endereco
@ nLi,Limite/2	PSay PadR(STR0005,25) //"Município"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 3,,.T.),80)		// Municipio
	
TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0006,25) //"Estado"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 4,,.T.),80)		// Etado
@ nLi,Limite/2	PSay PadR(STR0007,25) //"CEP"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 5,,.T.),80)		// CEP
	
TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0008,25) //"Telefone Comercial"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 6,,.T.),80)		// Telefone comercial 1
@ nLi,Limite/2	PSay PadR("DDD",25)
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 9,,.T.),80)		// DDD
	
TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay PadR(STR0009,25) //"Home Page"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 8,,.T.),80)		// Home page
@ nLi,Limite/2	PSay PadR(STR0010,25) //"E-mail"
@ nLi,PCol()+1	PSay PadR(TkEntidade(aEmpCont[9][3], aEmpCont[10][3], 7,,.T.),80)		// e-mail


TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
@ nLi,000		PSay __PrtFatLine()
	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados do item de Televendas    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[3]	
EndIf

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Atendimentos do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0047		//"A T E N D I M E N T O S   D E   T E L E V E N D A S   D A   E N T I D A D E"
	
	DbSelectArea("SUA")
	DbSetOrder(1)
	For nJ := 1 to Len(aArray)
		MsSeek(xFilial("SUA") + aArray[nJ][1])
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)  
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0011,25) //"Código do Atendimento"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_NUM,6)
		@ nLi,Limite/2	PSay PadR(STR0012,25) //"Data do Atendimento"
		@ nLi,PCol()+1	PSay PadR(DtoC(SUA->UA_EMISSAO),10)
	
		If !Empty(SUA->UA_CLIENTE) .AND. !Empty(SUA->UA_LOJA)
			DbSelectArea("SA1")
			DbSetOrder(1)
			If MsSeek(xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA)
				cDesc := SA1->A1_NOME
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0015,25) //"Código Cliente/Loja"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_CLIENTE + " / " + SUA->UA_LOJA,80)
		@ nLi,Limite/2	PSay PadR(STR0016,25) //"Razão Social"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"A1_NOME"),80)
		
		If !Empty(SUA->UA_CODCONT)
			DbSelectArea("SU5")
			DbSetOrder(1)
			If MsSeek(xFilial("SU5") + SUA->UA_CODCONT)
				cDesc := SU5->U5_CONTAT
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0017,25) //"Código do Contato"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_CODCONT,80)
		@ nLi,Limite/2	PSay PadR(STR0018,25) //"Nome do Contato"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U5_CONTAT"),80)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0019,25) //"Tipo de Marketing"
		@ nLi,PCol()+1	PSay PadR(IIF(Val(SUA->UA_TMK)>0,aUA_TMK[Val(SUA->UA_TMK)],""),80)
		@ nLi,Limite/2	PSay PadR(STR0020,25) //"Operação"
		@ nLi,PCol()+1	PSay PadR(IIF(Val(SUA->UA_OPER)>0,aUA_Oper[Val(SUA->UA_OPER)],""),80)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0021,25) //"Tipo de Frete"
		@ nLi,PCol()+1	PSay PadR(IIF(Val(SUA->UA_TPFRETE)>0,aUA_TpFrete[Val(SUA->UA_TPFRETE)],""),80)
		@ nLi,Limite/2	PSay PadR(STR0022,25) //"Tabela de Preço"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_TABELA,80)
		
		If !Empty(SUA->UA_OPERADO)
			DbSelectArea("SU7")
			DbSetOrder(1)
			If MsSeek(xFilial("SU7") + SUA->UA_OPERADO)
				cDesc := SU7->U7_NOME
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0023,25) //"Código do Operador"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_OPERADO,80)
		@ nLi,Limite/2	PSay PadR(STR0024,25) //"Nome do Operador"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U7_NOME"),80)
		
		If !Empty(SUA->UA_VEND)
			DbSelectArea("SA3")
			DbSetOrder(1)
			If MsSeek(xFilial("SA3") + SUA->UA_VEND)
				cDesc := SA3->A3_NOME
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0025,25) //"Código do Vendedor"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_VEND,80)
		@ nLi,Limite/2	PSay PadR(STR0026,25) //"Nome do Vendedor"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"A3_NOME"),80)
		
		If !Empty(SUA->UA_MIDIA)
			DbSelectArea("SUH")
			DbSetOrder(1)
			If MsSeek(xFilial("SUH") + SUA->UA_MIDIA)
				cDesc := SUH->UH_DESC
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0027,25) //"Código da Mídia"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_MIDIA,80)
		@ nLi,Limite/2	PSay PadR(STR0028,25) //"Descrição da Mídia"
		@ nLi,PCol()+1	PSay PadR(cDesc,80)
		
		If !Empty(SUA->UA_CODCAMP)
			DbSelectArea("SUO")
			DbSetOrder(1)
			If MsSeek(xFilial("SUO") + SUA->UA_CODCAMP)
				cDesc := SUO->UO_DESC
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0029,25) //"Código da Campanha"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_CODCAMP,80)
		@ nLi,Limite/2	PSay PadR(STR0030,25) //"Descrição da Campanha"
		@ nLi,PCol()+1	PSay PadR(cDesc,80)
		
		If !Empty(SUA->UA_CODLIG)
			DbSelectArea("SU9")
			DbSetOrder(2)    	// Codigo da Ocorrencia
			If MsSeek(xFilial("SU9") + SUA->UA_CODLIG)
				cDesc := SU9->U9_DESC
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0031,25) //"Código da Ocorrência"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_CODLIG,80)
		@ nLi,Limite/2	PSay PadR(STR0032,25) //"Descrição da Ocorrência"
		@ nLi,PCol()+1	PSay PadR(cDesc,80)
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0033,25) //"Data de Retorno"
		@ nLi,PCol()+1	PSay PadR(DtoC(SUA->UA_PROXLIG),80)
		@ nLi,Limite/2	PSay PadR(STR0034,25) //"Hora de Retorno"
		@ nLi,PCol()+1	PSay PadR(SUA->UA_HRPEND,80)
		
		aLinhas := TkMemo(SUA->UA_CODOBS, 195)
		For nI := 1 to Len(aLinhas)
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			If nI == 1
				@ nLi,000 PSay PadR(STR0035,25) //"Observação"
			Endif
			@ nLi,26 PSay aLinhas[nI]
		Next nI
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay PadR(STR0048, 4) //"Item"
		@ nLi,PCol()+1	PSay PadR(STR0049,TamSX3("UB_PRODUTO")[1]) //"Produto"
		@ nLi,PCol()+1	PSay PadR(STR0050,TamSX3("B1_DESC")[1])//"Descricao"
		@ nLi,PCol()+1	PSay PadR(STR0051,TamSX3("UB_SITPROD")[1])//"St"
		@ nLi,PCol()+1	PSay PadR(STR0052,8)//"Qtdade"
		@ nLi,PCol()+1	PSay PadR(STR0053,14)//"Vl.Unitario"
		@ nLi,PCol()+1	PSay PadR(STR0054,14)//"Vl.Item"
		@ nLi,PCol()+1	PSay PadR(STR0055,6)//"%Desc"
		@ nLi,PCol()+1	PSay PadR(STR0056,14)//"Vl.Desconto"
		@ nLi,PCol()+1	PSay PadR(STR0057,6)//"%Acres"
		@ nLi,PCol()+1	PSay PadR(STR0058,14)//"Vl.Acrescimo"
		@ nLi,PCol()+1	PSay PadR(STR0059,TamSX3("UB_TES")[1])//"TES"
		@ nLi,PCol()+1	PSay PadR(STR0060,TamSX3("UB_CF")[1])//"CFOP"
		@ nLi,PCol()+1	PSay PadR(STR0061,10)//"Tabela"
		@ nLi,PCol()+1	PSay PadR(STR0062,14)//"Base ICMS"
		@ nLi,PCol()+1	PSay PadR(STR0063,TamSX3("UB_LOCAL")[1])//"LP"
		@ nLi,PCol()+1	PSay PadR(STR0064,TamSX3("UB_UM")[1])//"UM"
		@ nLi,PCol()+1	PSay PadR(STR0065,TamSX3("UB_DTENTRE")[1])//"Entrega"
		@ nLi,U_TKR044BVerifPos(@nLi, "UB_LOTE")	PSay PadR(STR0066,TamSX3("UB_LOTE")[1])//"Lote"
		@ nLi,U_TKR044BVerifPos(@nLi, "UB_SUBLOTE")	PSay PadR(STR0067,TamSX3("UB_SUBLOTE")[1])//"Sub-Lt"
		@ nLi,U_TKR044BVerifPos(@nLi, "UB_DTVALID")	PSay PadR(STR0068,TamSX3("UB_DTVALID")[1])//"Validade"
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()
		
		DbSelectArea("SUB")
		DbSetOrder(1)
		MsSeek(xFilial("SUB") + SUA->UA_NUM)
		While	(!Eof())							.AND.;
				SUB->UB_FILIAL	==	xFilial("SUB")	.AND.;
				SUB->UB_NUM		==	SUA->UA_NUM
			
			If !Empty(SUB->UB_PRODUTO)
				DbSelectArea("SB1")
				DbSetOrder(1)
				If MsSeek(xFilial("SB1") + SUB->UB_PRODUTO)
					cDesc := SB1->B1_DESC
				Else
					cDesc := STR0013 //"Não Localizado no cadastro..."
				Endif
		        Else
				cDesc := STR0014 //"Não Informado no atendimento..."
			Endif
			
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay PadR(SUB->UB_ITEM,4)
			@ nLi,PCol()+1	PSay PadR(SUB->UB_PRODUTO,TamSX3("UB_PRODUTO")[1])
			@ nLi,PCol()+1	PSay PadR(cDesc,30)
			@ nLi,PCol()+1	PSay PadR(SUB->UB_SITPROD,TamSX3("UB_SITPROD")[1])
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_QUANT, '@E 99999.99')),8)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_VRUNIT, '@E 999,999,999.99')),14)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_VLRITEM, '@E 999,999,999.99')),14)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_DESC, '@E 999.99')),6)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_VALDESC, '@E 999,999,999.99')),14)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_ACRE, '@E 999.99')),6)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_VALACRE, '@E 999,999,999.99')),14)
			@ nLi,PCol()+1	PSay PadR(SUB->UB_TES,TamSX3("UB_TES")[1])
			@ nLi,PCol()+1	PSay PadR(SUB->UB_CF,TamSX3("UB_CF")[1])
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_PRCTAB, '@E 999,999.99')),10)
			@ nLi,PCol()+1	PSay PadR(AllTrim(Transform(SUB->UB_BASEICM, '@E 999,999,999.99')),14)
			@ nLi,PCol()+1	PSay PadR(SUB->UB_LOCAL,TamSX3("UB_LOCAL")[1])
			@ nLi,PCol()+1	PSay PadR(SUB->UB_UM,TamSX3("UB_UM")[1])
			@ nLi,PCol()+1	PSay PadR(SUB->UB_DTENTRE,TamSX3("UB_DTENTRE")[1])
			@ nLi,U_TKR044BVerifPos(@nLi, "UB_LOTE")	PSay PadR(SUB->UB_LOTE,TamSX3("UB_LOTE")[1])
			@ nLi,U_TKR044BVerifPos(@nLi, "UB_SUBLOTE")	PSay PadR(SUB->UB_SUBLOTE,TamSX3("UB_SUBLOTE")[1])
			@ nLi,U_TKR044BVerifPos(@nLi, "UB_DTVALID")	PSay PadR(SUB->UB_DTVALID,TamSX3("UB_DTVALID")[1])
			
			DbSelectArea("SUB")
			DbSkip()
		End
		TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		
	Next nJ
Endif
	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados do banco de conhecimento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[4]
EndIf

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Atendimentos do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0038 //"O B J E T O S   V I N C U L A D O S   A O   B A N C O   D E   C O N H E C I M E N T O"
	
	DbSelectArea("ACB")
	DbSetOrder(1)
	For nJ := 1 to Len(aArray)
		MsSeek(xFilial("ACB") + aArray[nJ][1])
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay STR0039 //"Código Obj     Tamanho     Descrição                                                        Objeto"
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay ACB->ACB_CODOBJ
		@ nLi,PCol()+5	PSay Ft340Taman()
		@ nLi,PCol()+5	PSay ACB->ACB_DESCRI
		@ nLi,PCol()+5	PSay PadR(ACB->ACB_OBJETO,130)
		
	Next nJ
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pega os dados do item de Telecobranca  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Type("aDados") == "A"
	aArray := aDados[5]
EndIf

If ValType(aArray) == "A" .And. Len(aArray) > 0
	
	// Atendimentos do contato
	TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay __PrtFatLine()
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
	@ nLi,000		PSay STR0040 //"A T E N D I M E N T O S   D E   T E L E C O B R A N C A S   D A   E N T I D A D E"
	
	DbSelectArea("ACF")
	DbSetOrder(1)
	For nJ := 1 to Len(aArray)
		MsSeek(xFilial("ACF") + aArray[nJ][1])
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0012,25) //"Data do Atendimento"
		@ nLi,PCol()+1	PSay PadR(DtoC(ACF->ACF_DATA),80)
		@ nLi,Limite/2	PSay PadR(STR0011,25) //"Código do Atendimento"
		@ nLi,PCol()+1	PSay PadR(ACF->ACF_CODIGO,80)

		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0041,25) //"Tipo de Ligação"
		@ nLi,PCol()+1	PSay PadR(IIF(Val(ACF->ACF_OPERA)>0,aACF_Opera[Val(ACF->ACF_OPERA)],STR0042),80) //"Não Informado"
		@ nLi,Limite/2	PSay PadR(STR0043,25) //"Retornar em"
		@ nLi,PCol()+1	PSay ACF->ACF_PENDEN
		@ nLi,PCol()+1	PSay STR0044 //"às"
		@ nLi,PCol()+1	PSay ACF->ACF_HRPEND
		
		If !Empty(ACF->ACF_CLIENT) .AND. !Empty(ACF->ACF_LOJA)
			DbSelectArea("SA1")
			DbSetOrder(1)
			If MsSeek(xFilial("SA1") + ACF->ACF_CLIENT + ACF->ACF_LOJA)
				cDesc := SA1->A1_NOME
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0015,25) //"Código Cliente/Loja"
		@ nLi,PCol()+1	PSay PadR(ACF->ACF_CLIENT + " / " + ACF->ACF_LOJA,80)
		@ nLi,Limite/2	PSay PadR(STR0016,25) //"Razão Social"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"A1_NOME"),80)
		
		If !Empty(ACF->ACF_CODCON)
			DbSelectArea("SU5")
			DbSetOrder(1)
			If MsSeek(xFilial("SU5") + ACF->ACF_CODCON)
				cDesc := SU5->U5_CONTAT
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0017,25) //"Código do Contato"
		@ nLi,PCol()+1	PSay PadR(ACF->ACF_CODCON,80)
		@ nLi,Limite/2	PSay PadR(STR0018,25) //"Nome do Contato"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U5_CONTAT"),80)
		
		If !Empty(ACF->ACF_OPERAD)
			DbSelectArea("SU7")
			DbSetOrder(1)
			If MsSeek(xFilial("SU7") + ACF->ACF_OPERAD)
				cDesc := SU7->U7_NOME
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0023,25) //"Código do Operador"
		@ nLi,PCol()+1	PSay PadR(ACF->ACF_OPERAD,80)
		@ nLi,Limite/2	PSay PadR(STR0024,25) //"Nome do Operador"
		@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(cDesc,"U7_NOME"),80)
		
		If !Empty(ACF->ACF_MOTIVO)
			DbSelectArea("SU9")
			DbSetOrder(2)    	// Codigo da Ocorrencia
			If MsSeek(xFilial("SU9") + ACF->ACF_MOTIVO)
				cDesc := SU9->U9_DESC
			Else
				cDesc := STR0013 //"Não Localizado no cadastro..."
			Endif
        Else
			cDesc := STR0014 //"Não Informado no atendimento..."
		Endif
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0031,25) //"Código da Ocorrência"
		@ nLi,PCol()+1	PSay PadR(ACF->ACF_MOTIVO,80)
		@ nLi,Limite/2	PSay PadR(STR0032,25) //"Descrição da Ocorrência"
		@ nLi,PCol()+1	PSay PadR(cDesc,80)
		
		aLinhas := TkMemo(ACF->ACF_CODOBS, 195)
		For nI := 1 to Len(aLinhas)
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			If nI == 1
				@ nLi,000 PSay PadR(STR0035,25) //"Observação"
			Endif
			@ nLi,26 PSay aLinhas[nI]
		Next nI
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(STR0045,Limite) //"Prf Título-P Tip Natureza   Vencto   V. Real         Valor   Acrésc  Decrésc Núm Banco       Histórico                  %Per  Val Jur     IRRF      ISS     CSLL   COFINS      PIS Status          Resp.  Nome do Responsável"
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay __PrtThinLine()
		
		DbSelectArea("ACG")
		DbSetOrder(1)
		MsSeek(xFilial("ACG") + ACF->ACF_Codigo)
		While	!Eof() 								.AND.;
				ACG->ACG_FILIAL == xFilial("ACG") 	.AND.;
				ACG->ACG_CODIGO == ACF->ACF_CODIGO
			
			// Agora vamos imprimir todos os titulos
			TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay ACG->ACG_PREFIX
			@ nLi,PCol()+1	PSay ACG->ACG_TITULO + "-" + ACG->ACG_PARCEL
			@ nLi,PCol()+1	PSay ACG->ACG_TIPO
			@ nLi,PCol()+1	PSay ACG->ACG_NATURE
			@ nLi,PCol()+1	PSay ACG->ACG_DTVENC
			@ nLi,PCol()+1	PSay ACG->ACG_DTREAL
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_VALOR, '@E 9,999,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_ACRESC, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_DECRES, '@E 9,999.99')
			@ nLi,PCol()+1	PSay ACG->ACG_NUMBCO
			@ nLi,PCol()+1	PSay ACG->ACG_HIST
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_PORJUR, '@E 99.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_VALJUR, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_IRRF, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_ISS, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_CSLL, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_COFINS, '@E 9,999.99')
			@ nLi,PCol()+1	PSay Transform(ACG->ACG_PIS, '@E 9,999.99')
			@ nLi,PCol()+1	PSay PadR(IIF(Val(ACG->ACG_STATUS)>0,aACG_Status[Val(ACG->ACG_STATUS)],STR0042),15) //"Não Informado"
			@ nLi,PCol()+1	PSay ACG->ACG_OPERAD
			@ nLi,PCol()+1	PSay Substr(UsrRetName(ACG->ACG_OPERAD)+Space(24),1,20)
			
			DbSelectArea("ACG")
			DbSkip()
		End
		TkIncLine(@nLi,2,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		
	Next nJ
	
Endif

FATPDUnload()
FATPDLogUser("TMKR044B")

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKR044BVerifPosºAutor  ³CRM - VENDAS        º Data ³  08/03/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para controlar a coluna do campo para ver se pula linha.   º±±
±±º          |OBS: Passar o parâmetro 1 (nLi) como referência.				    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TKR044BVerifPos(nLi, cCampo)
	Local nLocalPCol	:= 000							// Controla a coluna da impressão do relatório para saber se precisa pular linha
	nLocalPCol := PCol()+1
	If(nLocalPCol+(TamSX3(cCampo)[1]) > Limite)
		nLi += 1
		nLocalPCol := 000
	End IF
return nLocalPCol

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