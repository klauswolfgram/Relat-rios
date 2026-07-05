/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TMKR046.CH"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ TMKR046  ³ Autor ³ Cleber Martinez       ³ Data ³ 24/07/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de Posicao Geral da Fila de Telecobranca         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_TMKR046(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGATMK                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ANALISTA     ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TMKR046()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   	:= "TMKR046"  	 	// Nome do Arquivo utilizado no Spool
Local Titulo 	:= STR0001 			//"Posicao Geral da Fila de TeleCobranca"
Local cDesc1 	:= STR0002 			//"Este relatório ira exibir de forma sintetica os números atualizados dos títulos que estão em cobranca"
Local cDesc2 	:= ""
Local cDesc3 	:= STR0003 			//"Não haverá opção de extrair o relatório ref. a datas retroativas"
Local nomeprog	:= "TMKR046.PRW"	 // nome do programa
Local cAlias 	:= "SK1"			 // Alias utilizado na Filtragem
Local lDic    	:= .F. 				 // Habilita/Desabilita Dicionario
Local lComp   	:= .F. 				 // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro 	:= .F. 				 // Habilita/Desabilita o Filtro
Local dMaiorAtraso 					 // Armazena a data do titulo com maior atraso fora da fila de cobrança

Private Tamanho := "M" 				 // P/M/G
Private Limite  := 132 				 // 80/132/220
Private aReturn := { STR0004,;		 							//[1] Reservado para Formulario	//"Zebrado"
					 1,;										//[2] Reservado para N§ de Vias
					 STR0005,;		 							//[3] Destinatario //"Administração"
					 2,;										//[4] Formato => 1-Comprimido 2-Normal	
					 2,;	    								//[5] Midia   => 1-Disco 2-Impressora
					 1,;										//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
					 "",;										//[7] Expressao do Filtro
					 1 } 										//[8] Ordem a ser selecionada
					 											//[9]..[10]..[n] Campos a Processar (se houver)

Private m_pag   := 1  				 // Contador de Paginas
Private nLastKey:= 0  				 // Controla o cancelamento da SetPrint e SetDefault
Private aOrdem  := {}  				 // Ordem do Relatorio

wnrel:=SetPrint(cAlias,wnrel,,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)

If (nLastKey == 27)
	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

SetDefault(aReturn,cAlias)

If (nLastKey == 27)
	DbSelectArea(cAlias)
	DbSetOrder(1)
	DbClearFilter()
	Return
Endif

RptStatus({|lEnd| TKR046Imp(@lEnd,wnRel,cAlias,nomeprog,Titulo)},Titulo)

Return(.T.)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TKR045Imp ³ Autor ³ Cleber Martinez       ³ Data ³ 24/07/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ TKR045Imp		                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ANALISTA     ³ DATA   ³ BOPS ³MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function TKR046Imp(	lEnd,	wnrel,	cAlias,		nomeprog,;
							Titulo	)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao Do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nLi		:= 0			// Linha a ser impressa
Local nMax		:= 58			// Maximo de linhas suportada pelo relatorio
Local cbCont	:= 0			// Numero de Registros Processados
Local cbText	:= SPACE(10)	// Mensagem do Rodape
Local cCabec1	:= "" 			// Label dos itens
Local cCabec2	:= "" 			// Label dos itens
Local nIni		:= 0			// Inicio do periodo de cobranca
Local nFim		:= 0			// Final do periodo de cobranca
Local nX		:= 0			// Usada em lacos For...Next
Local dIni		:= MsDate()		// Data Inicial da Regra de Selecao
Local dFim		:= MsDate()		// Data Final da Regra de Selecao
Local cSK1		:= ""			// Alias da tabela SK1
Local aRegras	:= {}			// Array com as regras de selecao
Local aResult	:= {}			// Array com os resultados obtidos na consulta
Local nTitulos	:= 0			// Total de titulos encontrados
Local nTotCli	:= 0			// Total de clientes a cobrar
Local nTotValor	:= 0			// Valor total dos titulos
Local cTipo		:= UPPER(GetNewPar("MV_TMKCOBR","")) 	// Contem os tipos de titulos que devem ser utilizados para cobranca
Local cSep		:= ""     		// Separador dos tipos de titulo utilizado na select 
Local aTotais	:= {}			// Array com os dados totalizados a partir das queries					
Local aNaoAcionados	:= {}		// Array com os titulos nao acionados por Regra de Selecao
Local cOperadores := ""			// Armazena os operadores que nao devem ser considerados por estarem na mesma faixa de selecao e nao sao receptivo

#IFDEF TOP
	Local cQuery	:= ""		// Query a executar
#ENDIF

DbSelectArea("SK0")
DbSetOrder(2)
DbSeek(xFilial("SK0"))
While !Eof() .AND. xFilial("SK0") == SK0->K0_FILIAL
	nIni := nFim + 1
	If SK0->K0_PRAZO == "999999"		// Trabalha com lista de contato
    	nFim := nFim + 100000
    Else
    	nFim := nFim + Val(SK0->K0_PRAZO)
	EndIf
    
    aAdd(aRegras,{	SK0->K0_DESC,;
    				nIni,;
    				nFim,;
    				SK0->K0_ORDEM})
    
    DbSelectArea("SK0")
    DbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atribui os separadores dos tipos de titulos a serem utilizados e os tipos de  titulos de abatimento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(cTipo)
	cSep:=	If("/" $ cTipo,"/",",") 
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posicao atual por regra de selecao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aRegras)

	nTitulos	:= 0
	nTotValor	:= 0
	nTotCli		:= 0

	DbSelectArea(cAlias)
	DbSetOrder(2)	//K1_FILIAL+DTOS(K1_VENCREA)+K1_CLIENTE+K1_LOJA
	#IFDEF TOP
		cSK1 := GetNextAlias()		// Alias temporario do SK1
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  -----60---------30--------Hoje----		³
		//³	     dIni       dFim      dDataBase		³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dIni	:= dDataBase - aRegras[nX][3]		
		dFim	:= dDataBase - aRegras[nX][2]		
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Query de totalizacao de clientes ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cQuery	:=	" SELECT COUNT(*) AS CLIENTES, SUM(TIT) AS TITULOS, SUM(SALDO) AS SALDO FROM (" 
		cQuery	+=  " SELECT SK1.K1_CLIENTE, COUNT(SK1.K1_CLIENTE) AS TIT "
		cQuery	+=  " , SUM(SK1.K1_SALDO) AS SALDO "
		cQuery  +=	" FROM " + RetSqlName("SK1") + " SK1"
		cQuery  +=	" WHERE SK1.K1_FILIAL = '" + xFilial("SK1") + "' AND "
		cQuery	+=  " SK1.K1_OPERAD <> 'XXXXXX' AND"
		cQuery  +=	" SK1.D_E_L_E_T_ = '' "
		cQuery  +=	" GROUP BY SK1.K1_CLIENTE "		
		cQuery  +=	" HAVING MIN(SK1.K1_VENCREA) BETWEEN '" + DtoS(dIni) + "' AND '" + DtoS(dFim) + "' "				
		cQuery  +=	" ) CONTADOR"
		
		cQuery	:= ChangeQuery( cQuery )
		DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cSK1, .F., .T.)
		nTitulos 	:= (cSK1)->TITULOS
     	nTotCli		:= (cSK1)->CLIENTES
     	nTotValor	:= (cSK1)->SALDO
        (cSK1)->(DbCloseArea())
      
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Adiciona os resultados no array para depois usar na impressao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     	aAdd(aResult, { aRegras[nX][1]	,;		//Nome da Regra
     					nTitulos		,;		//Total de Titulos
     					nTotCli			,;		//Total de Clientes
				     	nTotValor		} )		//Valor Total
		
		nTitulos	:= 0
		nTotValor	:= 0
		nTotCli		:= 0

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Seleciona os operadores que trabalham na mesma faixa de selecao |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ        
		cOperadores := ""
		DbSelectArea("SU7")
		DbSetOrder(1)
		If DbSeek(xFilial("SU7"))
	
			While !Eof() .AND. SU7->U7_FILIAL == xFilial("SU7")
	
				DbSelectArea("SU0")
				DbSetOrder(1)
	
				If DbSeek(xFilial("SU0") + SU7->U7_POSTO)
					DbSelectArea("SK0")
					DbSetOrder(1)
	
					If DbSeek(xFilial("SK0") + SU0->U0_REGSEL) .AND. SU0->U0_BOUND <> '1'
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Esses operadores estao no grupo do operador atual ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If SK0->K0_ORDEM == aRegras[nX][4]
							cOperadores+= SU7->U7_COD + ","
						Endif	
					Endif	
	
				Endif
	
				DbSelectArea("SU7")
				DbSkip()
			End	
		Endif
		
		If !Empty(cOperadores)
			cOperadores := Left(cOperadores,Len(cOperadores)-1) //Tira a ultima virgula da string
	    Endif
	
	

		cQuery	:=	" SELECT COUNT(*) AS CLIENTES, SUM(TIT) AS TITULOS, SUM(SALDO) AS SALDO FROM (" 
		cQuery	+=  " SELECT SK1.K1_CLIENTE, COUNT(SK1.K1_CLIENTE) AS TIT "
		cQuery	+=  " , SUM(SK1.K1_SALDO) AS SALDO "	
		cQuery  +=	" FROM " + RetSqlName("SK1") + " SK1"
		cQuery  +=	" WHERE SK1.K1_FILIAL = '" + xFilial("SK1") + "' AND "
		cQuery	+=  " SK1.K1_OPERAD <> 'XXXXXX' AND"
		cQuery  +=	" SK1.D_E_L_E_T_ = '' "
		cQuery  +=	" GROUP BY SK1.K1_CLIENTE "		
		cQuery  +=	" HAVING MIN(SK1.K1_VENCREA) BETWEEN '" + DtoS(dIni) + "' AND '" + DtoS(dFim) + "' AND"				
		cQuery  +=	" MAX(SK1.K1_OPERAD) NOT IN" + FormatIn(cOperadores,",") + ""				
		cQuery  +=	" ) CONTADOR"		
		cQuery	:= ChangeQuery( cQuery )
		DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cSK1, .F., .T.)

		nTitulos 	:= (cSK1)->TITULOS
     	nTotCli		:= (cSK1)->CLIENTES
     	nTotValor	:= (cSK1)->SALDO
        (cSK1)->(DbCloseArea())		
    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Adiciona os resultados no array para depois usar na impressao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     	aAdd(aNaoAcionados, {	aRegras[nX][1]	,;		//Nome da Regra
     							nTitulos		,;		//Total de Titulos
     							nTotCli			,;		//Total de Clientes
				     			nTotValor		} )		//Valor Total
				     	        	
	#ENDIF 
Next nX


#IFDEF TOP

	

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulos a receber no TeleCobranca       ³
	//³ Totaliza os resultados ja obtidos antes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTitulos := 0
    nTotCli	 := 0
	nTotValor:= 0 
    For nX := 1 To Len(aResult)
		nTitulos 	+= aResult[nX][2]		//Total de Titulos
     	nTotCli		+= aResult[nX][3]		//Total de Clientes
	    nTotValor 	+= aResult[nX][4]		//Valor Total
	Next nX
	
	//aTotais[2]
	aAdd(aTotais, {	STR0007,;	//"Títulos a receber no Telecobrança"
					nTitulos,;
					nTotCli,;
					nTotValor	} )
    
	nTitulos := 0
    nTotCli	 := 0
	nTotValor:= 0 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Titulos nao acionados                   ³
	//³ Totaliza os resultados ja obtidos 		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    For nX := 1 To Len(aNaoAcionados)
		nTitulos 	+= aNaoAcionados[nX][2]		//Total de Titulos
     	nTotCli		+= aNaoAcionados[nX][3]		//Total de Clientes
	    nTotValor 	+= aNaoAcionados[nX][4]		//Valor Total
	Next nX
	//aTotais[3]
	aAdd(aTotais, {	STR0008,; 	//"Títulos não acionados"
					nTitulos,;
					nTotCli,;
					nTotValor	} )		
	    

#ENDIF	
		
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos resultados obtidos	  ³
//³ Posicao atual por Regra Selecao 	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aResult)

	If lEnd
		@Prow()+1,000 PSay STR0010 //"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o cabecalho da secao (somente no primeiro item) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nX == 1
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,050 PSay STR0011 //"Posição atual por Regra de Seleção"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,040 PSay STR0012 //"(Informa títulos da Telecobrança não pagos, que não foram alocados p/ nenhum operador e agrupados por Regra de Seleção)"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,000 PSay __PrtFatLine()
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,002 PSay STR0013 //"Nome da Regra"
		@ nLi,060 PSay STR0014 //"Total de Títulos"
		@ nLi,090 PSay STR0015 //"Total de Clientes"
		@ nLi,120 PSay STR0016 //"Valor (R$)"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)		
		@ nLi,000 PSay __PrtThinLine()
	EndIf
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)		
	@ nLi,002 PSay aResult[nX][1] 
	@ nLi,060 PSay PadL(TransForm(aResult[nX][2], '@E 999999999'),16)		// Total de Titulos
	@ nLi,090 PSay PadL(TransForm(aResult[nX][3], '@E 999999999'),17)		// Total de Clientes
	@ nLi,116 PSay PadL(TransForm(aResult[nX][4], '@E 999,999,999.99'),14)	// Valor 
	
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos resultados obtidos	  ³
//³ Qtde. de titulos nao acionados  	  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aNaoAcionados)

	If lEnd
		@Prow()+1,000 PSay STR0010	//"CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o cabecalho da secao (somente no primeiro item) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nX == 1
		TkIncLine(@nLi,3,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,040 PSay STR0017 //"Quantidade de títulos não acionados por Regra de Seleção"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)			
		@ nLi,020 PSay STR0018 //"(Títulos da Telecobr. não pagos, não alocados p/ nenhum operador, mas que o cliente possua títulos na pendência de um operador)"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,000 PSay __PrtFatLine()
		
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,002 PSay STR0013	//"Nome da Regra"
		@ nLi,060 PSay STR0014	//"Total de Títulos"
		@ nLi,090 PSay STR0015	//"Total de Clientes"
		@ nLi,120 PSay STR0016	//"Valor (R$)"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)		
		@ nLi,000 PSay __PrtThinLine()
	EndIf
	
	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)		
	@ nLi,002 PSay aNaoAcionados[nX][1] 
	@ nLi,060 PSay PadL(TransForm(aNaoAcionados[nX][2], '@E 999999999'),16)		// Total de Titulos
	@ nLi,090 PSay PadL(TransForm(aNaoAcionados[nX][3], '@E 999999999'),17)		// Total de Clientes
	@ nLi,116 PSay PadL(TransForm(aNaoAcionados[nX][4], '@E 999,999,999.99'),14)	// Valor 
	
Next nX

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao dos totalizadores de:                          ³
//³ - Titulos a receber no Protheus (validos p/ Telecobranca)³
//³ - Titulos a receber no Telecobranca                      ³
//³ - Titulos nao acionados                                  ³
//³ - Qtde. titulos que nao estao na fila de cobranca        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nX := 1 To Len(aTotais)

	If lEnd
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@nLi,000 PSay STR0010	//"CANCELADO PELO OPERADOR"
		Exit
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o cabecalho da secao (somente no primeiro item) ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nX == 1
		TkIncLine(@nLi,4,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,002 PSay STR0019	//"Indicadores"
		@ nLi,060 PSay STR0014	//"Total de Títulos"
		@ nLi,090 PSay STR0015	//"Total de Clientes"
		@ nLi,120 PSay STR0016	//"Valor (R$)"
		TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
		@ nLi,000 PSay __PrtThinLine()
	EndIf

	TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)	
	@ nLi,002 PSay aTotais[nX][1] 
	@ nLi,060 PSay PadL(TransForm(aTotais[nX][2], '@E 999999999'),16)		// Total de Titulos
	@ nLi,090 PSay PadL(TransForm(aTotais[nX][3], '@E 999999999'),17)		// Total de Clientes
	@ nLi,116 PSay PadL(TransForm(aTotais[nX][4], '@E 999,999,999.99'),14)	// Valor 
	
Next nX
	                                                   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime o rodape do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Roda(cbCont,cbText,Tamanho)

Set Device To Screen
If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()
	    	
Return .T.
