/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "LOJR780.CH"
#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºPrograma  ³LOJR780   ºAutor  ³Hanna Caroline      º Data ³  25/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ranking de Produtos por Preco ou por Quantidade			  º±±
±±º          ³ Personalizavel                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus - Relatorio                                       º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Lojr780()
Local oReport
Local aArea := GetArea()      

If !TRepInUse()
	MsgAlert("Atenção, esse relatório somente será exibido no Modo de Relatório Personalizado." +CHR(10)+CHR(13)+;
			"Altere o parâmetro MV_TREPORT para 2 e o relatório poderá ser emitido normalmente")
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros						 ³
	//³ mv_par01				 // De Grupo						 ³
	//³ mv_par02				 // Ate o Grupo						 ³
	//³ mv_par03				 // De Data 						 ³
	//³ mv_par04				 // Ate a Data 						 ³
	//³ mv_par05				 // De Produto 						 ³
	//³ mv_par06				 // Ate o Produto 					 ³
	//³ mv_par07				 // Ranking p/ Preco ou Quant.		 ³
	//³ mv_par08				 // Classificacao s 10 Mais,...      ³
	//³         				 // ...os 20 mais,.                  ³
	//³ mv_par09				 // Considera as devolucoes para a   ³
	//³         				 // geracao do ranking               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("LJR780",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Ljr780RptDef()
	oReport:PrintDialog()
EndIf

RestArea( aArea )
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºPrograma  ³Ljr780RptDefºAutor  ³Vendas e CRM      º Data ³  25/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no re- º±±
±±º          ³latorio                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJA780                                                    º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Ljr780RptDef()
Local oReport										// Objeto do relatorio
Local oSection1										// Objeto da secao 1
Local cAlias1	:= GetNextAlias()					// Pega o proximo Alias Disponivel
Local aTamCod	:= TamSX3("B1_COD")
Local lTop      := .F.                        		// Verifica se esta usando o Top

#IFDEF TOP
	lTop 	:= .T.
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gera a tela com os dados para a confirmação da geracao do relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                                        
// Ranking de Produtos
//"Este programa irá emitir um Ranking de Produtos por" "Preço ou Quantidade em Moeda Corrente."
oReport := TReport():New("LOJR780",STR0005,"LJR780",{|oReport| Ljr780PrtRpt(oReport,cAlias1)}, STR0001 + STR0002 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define a secao1 do relatorio, informando que o arquivo principal utlizado eh o SL2 e o complementar o SB1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New(oReport,STR0013,{"SB1"} )		// Detalhes dos Produtos
oSection1:SetTotalText("")									// Inibe o texto da secao
oSection1:SetTotalInLine(.F.)								// Imprime total em linha ou coluna (default .T. - linha )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define as celulas que irao aparecer na secao1³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oSection1,"COD"		,cAlias1,STR0012,"@!",If(aTamCod[1]>13, aTamCod[1], 13))					// "Código "
TRCell():New(oSection1,"B1_DESC"	,"SB1")
TRCell():New(oSection1,"QUANT"		,cAlias1,STR0008,"@E 999,999.99"		,9	,NIL, If(cPaisLoc == "BRA" .And. lTop, Nil, {|| Lj780QtdCalc(1) }) ) // "Quantidade")
TRCell():New(oSection1,"B1_UM"		,"SB1")
TRCell():New(oSection1,"VALOR"		,cAlias1,STR0007,"@E 999,999,999.9999"	,15 ,NIL, If(cPaisLoc == "BRA" .And. lTop, Nil, {|| Lj780QtdCalc(2) }) ) // "Valor"

TRFunction():New(oSection1:Cell("QUANT"),,"SUM",,,,,,.F.)		// Ultimo parametro informa que nao deve imprimir o total no final da secao, somente no final do relatorio
TRFunction():New(oSection1:Cell("VALOR"),,"SUM",,,,,,.F.)

Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ºPrograma  ³Ljr780PrtRptºAutor  ³Vendas e CRM        º Data ³  25/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LOJR780                                                      º±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Ljr780PrtRpt( oReport, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local cProduto	:= ""								// Codigo do produto
Local cPart		:= ""								// Condicoes do IF, para ser incluido na query
Local cArqTrb	:= ""								// Arquivo de trabalho
Local cOrderBy	:= ""								// Indice que sera usado no order by
Local cTop		:= ""								// Expressao com os registros que serao apresentados
Local nQuant	:= 0								// Quantidade
Local nValor	:= 0								// Valor
Local nMoeda	:= 1								// Moeda utilizada na venda
Local nDecs		:= 0								// Casas decimais
Local nCont		:= 0								// Contador de acordo com o parametro mv_par08
Local aTam		:= {}								// Tamanho dos campos
Local aProd		:= {}								// Produtos
Local aCampos	:= {}								// Campos
Local aIndexKey := {}                        // Indice do arquivo temporário
Local nQtdeRegs := 0								// Contador para delimitar o tamanho da regua de progressao
Local oTempTable:= Nil								//Objeto tabela temporaria
            
#IFDEF TOP

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//³Exemplo Word, nao intervalos pre definidos (mais utilizado pelo RH - Ferias)     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("LJR190")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Valida se considera devolucao ou nao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR09 == 2
		cPart := "%L2_STATUS  <> 'D' AND %"
	Else
		cPart := "%%"
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³De acordo com o parametro, monta a ordem do relatorio³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR07 == 1
		cOrderBy := "%VALOR DESC, COD%"
	Else
		cOrderBy := "%QUANT DESC, COD%"
	EndIf	


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	If MV_PAR09 == 2				// Parametro que define se considera devolucao
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query utilizada para filtrar todos os dados necessarios ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 

		BeginSql alias cAlias1
			SELECT	B1_COD COD,		B1_DESC,	B1_UM,	SUM(L2_QUANT) QUANT,	SUM(L2_VLRITEM+L2_VALIPI) VALOR 
		
			FROM %table:SB1% SB1,%table:SF4% SF4,%table:SL1% SL1,%table:SL2% SL2 

			LEFT JOIN %table:SC6% SC6 ON (C6_FILIAL=L2_FILIAL AND C6_NUM=L2_PEDRES AND SC6.%notDel%)							 
			WHERE	B1_FILIAL	=	%xfilial:SB1%			AND	
					L2_FILIAL	=	%xfilial:SL2%			AND
					F4_FILIAL	=	%xfilial:SF4%			AND
					L1_FILIAL	= 	%xfilial:SL1%			AND
					SL1.%notDel%							AND
					L2_NUM = L1_NUM                         AND					
					L1_STORC <> 'C'							AND
					B1_GRUPO	>=	%exp:mv_par01%			AND                                               
					B1_GRUPO	<=	%exp:mv_par02%			AND
					L2_EMISSAO	>=	%exp:DTOS(mv_par03)%	AND
					L2_EMISSAO	<=	%exp:DTOS(mv_par04)%	AND
					L2_PRODUTO	>=	%exp:mv_par05%			AND
					L2_PRODUTO	<=	%exp:mv_par06%			AND                                   
					L2_TES		=	F4_CODIGO				AND
					L2_PRODUTO	=	B1_COD					AND
				  ((L2_VENDIDO 	= 	'S' AND L1_DOC != ' ')  OR (L2_ENTREGA IN ('1','3','4','5') AND L2_PEDRES <> ' ' AND C6_QTDVEN = C6_QTDENT)) AND
					F4_DUPLIC	=	'S'						AND
					SL2.%notDel%							AND
					%exp:cPart%
					SF4.%notDel%							AND
					SB1.%notDel%							
	
			GROUP BY B1_COD, B1_DESC, B1_UM, L2_PRODUTO
			ORDER BY %exp:cOrderBy%	

		EndSql
	Else
			
		If cPaisLoc == "BRA"
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Query utilizada para filtrar todos os dados necessarios ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BeginSql alias cAlias1
			
				SELECT COD,		B1_DESC,	B1_UM,	SUM(QUANT) QUANT,	SUM(VALOR) VALOR 
				FROM (
				
					SELECT	B1_COD COD,		B1_DESC,	B1_UM,	SUM(L2_QUANT) QUANT,	SUM(L2_VLRITEM+L2_VALIPI) VALOR
					FROM %table:SB1% SB1, %table:SF4% SF4, %table:SL1% SL1, %table:SL2% SL2
					LEFT JOIN %table:SC6% SC6 ON (C6_FILIAL=L2_FILIAL AND C6_NUM=L2_PEDRES AND SC6.%notDel%) 	
					WHERE	B1_FILIAL		=	%xfilial:SB1%			AND
							L2_FILIAL		=	%xfilial:SL2%			AND
							F4_FILIAL		=	%xfilial:SF4%			AND
							L1_FILIAL		= 	%xfilial:SL1%			AND
							L2_NUM 			= 	L1_NUM              	AND
							L1_STORC 		<> 	'C'						AND
							B1_GRUPO		>=	%exp:mv_par01%			AND
							B1_GRUPO		<=	%exp:mv_par02%			AND
							L2_EMISSAO		>=	%exp:DTOS(mv_par03)%	AND
							L2_EMISSAO		<=	%exp:DTOS(mv_par04)%	AND
							L2_PRODUTO		>=	%exp:mv_par05%			AND
							L2_PRODUTO		<=	%exp:mv_par06%			AND
							L2_TES			=	F4_CODIGO				AND
							L2_PRODUTO		=	B1_COD					AND
						  ((L2_VENDIDO 	= 	'S' AND L1_DOC != ' ')  OR (L2_ENTREGA IN ('1','3','4','5') AND L2_PEDRES <> ' ' AND C6_QTDVEN = C6_QTDENT)) AND
							F4_DUPLIC		=	'S'						AND
							%exp:cPart%
							SL1.%notDel%								AND
							SL2.%notDel%								AND
							SF4.%notDel%								AND
							SB1.%notDel%
							
							
					GROUP BY B1_COD, B1_DESC, B1_UM
					
					UNION
					
					SELECT	D1_COD COD, 	B1_DESC,	B1_UM,	(-SUM(D1_QUANT)) QUANT, (-SUM(D1_TOTAL+D1_VALIPI)) VALOR
					FROM %table:SD1% SD1, %table:SB1% SB1
					WHERE 	D1_FILIAL		=  %xfilial:SD1% 			AND
					  	 	B1_FILIAL		=  %xfilial:SB1% 			AND
					  		D1_COD			=  B1_COD 					AND
					  		B1_GRUPO		>= %exp:mv_par01% 			AND
					  		B1_GRUPO		<= %exp:mv_par02% 			AND
					  		D1_EMISSAO  	>= %exp:DTOS(mv_par03)% 	AND
					  		D1_EMISSAO  	<= %exp:DTOS(mv_par04)% 	AND
					  		D1_COD      	>= %exp:mv_par05% 			AND
					  		D1_COD      	<= %exp:mv_par06% 			AND
					  		D1_TIPO			=  'D' 						AND
					  		D1_ORIGLAN 		=  'LO' 					AND
					  		SD1.%notDel% 								AND
					  		SB1.%notDel%
					GROUP BY D1_COD, B1_DESC, B1_UM
				
				) TABTMP
				
				GROUP BY  COD,	B1_DESC,B1_UM
				
				ORDER BY %exp:cOrderBy%
				
			EndSql
		
		Else
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Query utilizada para filtrar todos os dados necessarios ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			BeginSql alias cAlias1
			
				SELECT	B1_COD COD,		B1_DESC,	B1_UM,	SUM(L2_QUANT) QUANT,	SUM(L2_VLRITEM+L2_VALIPI) VALOR 
			
				FROM %table:SB1% SB1,%table:SL2% SL2,%table:SF4% SF4, %table:SL1% SL1
				WHERE	B1_FILIAL	=	%xfilial:SB1%			AND	
						L2_FILIAL	=	%xfilial:SL2%			AND
						F4_FILIAL	=	%xfilial:SF4%			AND
						L1_FILIAL	= 	%xfilial:SL1%			AND
						SL1.%notDel%							AND          
						L2_NUM = L1_NUM                         AND
						L1_STORC <> 'C'							AND
						B1_GRUPO	>=	%exp:mv_par01%			AND
						B1_GRUPO	<=	%exp:mv_par02%			AND
						L2_EMISSAO	>=	%exp:DTOS(mv_par03)%	AND
						L2_EMISSAO	<=	%exp:DTOS(mv_par04)%	AND
						L2_PRODUTO	>=	%exp:mv_par05%			AND
						L2_PRODUTO	<=	%exp:mv_par06%			AND
						L2_TES		=	F4_CODIGO				AND
						L2_PRODUTO	=	B1_COD					AND
						L2_VENDIDO	=	'S'						AND
						F4_DUPLIC	=	'S'						AND
						SL2.%notDel%							AND
						%exp:cPart%
						SF4.%notDel%							AND
						SB1.%notDel%							
		
				GROUP BY B1_COD, B1_DESC, B1_UM
		
				UNION
		
				SELECT	D1_COD COD, 	B1_DESC,	B1_UM,	0 QUANT,	0 VALOR
				
				FROM %table:SD1% SD1,%table:SB1% SB1,%table:SL2% SL2,%table:SF4% SF4
				WHERE	D1_FILIAL	=	%xfilial:SD1%			AND
						B1_FILIAL	=	%xfilial:SB1%			AND
						F4_FILIAL	=	%xfilial:SF4%			AND
						D1_COD		=	B1_COD 		 			AND
						B1_GRUPO	>=	%exp:mv_par01%			AND
						B1_GRUPO	<=	%exp:mv_par02%			AND
						D1_TIPO		=	'D'						AND
						D1_ORIGLAN  =	'LO'					AND
						D1_COD      >=	%exp:mv_par05%			AND
						D1_COD      <=	%exp:mv_par06%			AND
						D1_EMISSAO  >=	%exp:DTOS(MV_PAR03)%	AND
						D1_EMISSAO  <=	%exp:DTOS(MV_PAR04)%	AND
						F4_DUPLIC	=	'S'						AND
						SD1.%notDel%							AND
						SB1.%notDel%							AND
						D1_COD		NOT IN (SELECT L2_PRODUTO FROM %table:SL2% SL2, %table:SD1% SD1, %table:SF4% SF4
									WHERE	L2_PRODUTO	=	D1_COD					AND
											L2_EMISSAO	>=	%exp:DTOS(MV_PAR03)%	AND
											L2_EMISSAO	<=	%exp:DTOS(MV_PAR04)%	AND
											L2_FILIAL	=	%xfilial:SB1%			AND
											L2_TES		=	F4_CODIGO				AND
											SL2.%notDel%
											GROUP BY L2_PRODUTO	)
				
				GROUP BY D1_COD, B1_DESC, B1_UM
				ORDER BY %exp:cOrderBy%
		         
			EndSql
		
		EndIf
		
	EndIf

	END REPORT QUERY oSection1

	
	//Conta aproximadamente a quantidade de registros para definir o tamanho da regua de processamento.
	//Foi feito desta forma para melhorar o desempenho do processamento, fazendo a contagem dos registros de forma mais rapida.
	While (cAlias1)->( !EoF() )
		nQtdeRegs++
		(cAlias1)->(DbSkip(100))
	End
	nQtdeRegs := nQtdeRegs * 100
	(cAlias1)->(DbGoTop())
	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se o parametro estiver 0, imprime todo o ranking.         ³
	//³Se estiver com uma quantidade limitada deve ser controlado³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cAlias1)
	oReport:SetMeter(nQtdeRegs)
	oSection1:Init()
	While (cAlias1)->( !EOF() )
		
		oReport:IncMeter() 

		If oReport:Cancel()
			Exit
		EndIf
		
		oSection1:PrintLine()
		(cAlias1)->( DbSkip() )
		If MV_PAR08 > 0
			nCont	:= nCont + 1
			If nCont >= MV_PAR08
				Exit
			Endif
		Endif
	End

	oSection1:Finish()

#ELSE

   If MV_PAR07 == 2
		aIndexKey := "QUANT"
	Else
		aIndexKey := "VALOR"
	Endif
   
	aTam	:= TamSX3( "B1_COD" )
	AADD(aCampos,{"COD" ,"C",aTam[1],aTam[2]})
	aTam	:= TamSX3( "L2_QUANT" )
	AADD(aCampos,{"QUANT" ,"N",aTam[1] + 4,aTam[2]})
	aTam	:= TamSX3( "L2_VLRITEM" )
	AADD(aCampos,{"VALOR" ,"N",aTam[1] + 4,aTam[2]})
	cArqTrb := CriaTrab( Nil,.F. )
	//Cria tabela temporaria
	oTempTable := LjCrTmpTbl(cAlias1, aCampos, aIndexKey)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza registro inicial 									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SL2")
	DbSetOrder(2)
	MsSeek( xFilial( "SL2" ) + MV_PAR05, .T. )
	
	oReport:SetMeter( RecCount() )

	While	SL2->( !Eof() ) .AND. xFilial("SL2") == SL2->L2_FILIAL .AND. ;
			SL2->L2_PRODUTO >= MV_PAR05 .AND. SL2->L2_PRODUTO <= MV_PAR06

		If oReport:Cancel()
			Exit
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Valida o grupo do produto³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->( DbSetOrder( 1 ) )
		If SB1->( MsSeek( xFilial( "SB1" ) + SL2->L2_PRODUTO ) )
			If SB1->B1_GRUPO < MV_PAR01 .OR. SB1->B1_GRUPO > MV_PAR02
				SL2->( DbSkip() )
				Loop
			EndIf
		Endif

		cProduto := SL2->L2_PRODUTO
		nQuant   := 0
		nValor   := 0

		While !SL2->( EOF() ) .AND. cProduto == SL2->L2_PRODUTO .AND. SL2->L2_FILIAL == xFilial("SL2")
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Considera nao considera devolucoes e o registro for devolucao, nao entra ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( MV_PAR09 == 2 .AND. SL2->L2_STATUS == "D" ) .OR. SL2->L2_VENDIDO <> "S"
				SL2->( DbSkip() )
				Loop
			Endif
	
			If	!( DTOS( SL2->L2_EMISSAO ) >=	DTOS( MV_PAR03 ) .AND. 	DTOS( SL2->L2_EMISSAO ) <=	DTOS( MV_PAR04 ) )
				SL2->( DbSkip() )
				Loop
			Endif
	
			SF4->( DbSetOrder( 1 ) )
			If SF4->( MsSeek( xFilial( "SF4" ) + SL2->L2_TES ) ) .AND. SF4->F4_DUPLIC <> "S"
				SL2->( DbSkip() )
				Loop
			Endif

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Soma os valores, caso esteja dentro das condicoes³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nQuant += SL2->L2_QUANT		
		
			If cPaisLoc == "BRA"
				nValor	+=SL2->L2_VLRITEM + SL2->L2_VALIPI
			Else
				DbSelectArea("SL1")
				DbSetOrder(1)

				If MsSeek( xFilial( "SL1" ) + SL2->L2_NUM )
					nMoeda	:= Max(SL1->L1_MOEDA,1)
					nDecs	:= MsDecimais(1)
					nValor	+= Round(	xMoeda( SL2->L2_VLRITEM,nMoeda,1,SL1->L1_EMISSAO,nDecs + 1), nDecs ) + ;
										RetImposto( SL2->L2_TES )[1] // Imposto Discriminado
				Endif
			EndIf
				
			SL2->( DbSkip() )
		End 

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se houver valor ou quantidade, grava no arquivo de trabalho³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nQuant > 0 .OR. nValor > 0
			DbSelectArea( cAlias1 )
			Reclock( cAlias1, .T. )
				(cAlias1)->COD 		:= SB1->B1_COD
				(cAlias1)->QUANT   	:= nQuant
				(cAlias1)->VALOR   	:= nValor
			(cAlias1)->( MsUnLock() )

			Aadd(aProd,SB1->B1_COD)
		EndIf
	End
	DbSelectArea( cAlias1 )
	cArqTrb2 := Substr( cArqTrb,1,7 ) + "2"

	If MV_PAR09 == 1    		// Parametro que define se considera devolucao
		DbSelectArea("SD1")
		DbSetOrder(3)
		DbSeek( xFilial("SD1") + DTOS(MV_PAR03), .T. )
		While !Eof() .AND. SD1->D1_EMISSAO  >= MV_PAR03 .AND. SD1->D1_EMISSAO <= MV_PAR04
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica se o e' devolucao, e se esta dentro do periodo. ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
     		If 	SD1->D1_TIPO <> "D" .OR. SD1->D1_ORIGLAN <> "LO"
				SD1->(dbSkip())
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Valida o produto³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If SD1->D1_COD < MV_PAR05 .OR. SD1->D1_COD > MV_PAR06
				SD1->(dbSkip())
				Loop
			EndIf

			If Ascan(aProd, SD1->D1_COD) <> 0
				SD1->(dbSkip())
				Loop
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Valida o grupo do produto³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SB1->( DbSetOrder( 1 ) )
			If SB1->( MsSeek( xFilial( "SB1" ) + SD1->D1_COD ) )
				If SB1->B1_GRUPO < MV_PAR01 .OR. SB1->B1_GRUPO > MV_PAR02
					SD1->( DbSkip() )
					Loop
				EndIf
			Endif

			DbSelectArea( cAlias1 )
			Reclock( cAlias1, .T. )
				(cAlias1)->COD 		:= SD1->D1_COD
				(cAlias1)->QUANT   	:= 0
				(cAlias1)->VALOR   	:= 0
			(cAlias1)->( MsUnLock() )

			DbSelectArea("SD1")

			SD1->(dbSkip())
		End 
	EndIf
	
	TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + (cAlias1)->COD })

	(cAlias1)->( DbGoBottom() )
	oSection1:Init()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Se o parametro estiver 0, imprime todo o ranking.         ³
	//³Se estiver com uma quantidade limitada deve ser controlado³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	While (cAlias1)->( !BOF() )
		oSection1:PrintLine()
		oReport:IncMeter()
		(cAlias1)->( DbSkip(-1) )
		If MV_PAR08 > 0
			nCont	:= nCont + 1
			If nCont >= MV_PAR08
				Exit
			Endif
		Endif
	End
	oSection1:Finish()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Fecha o arquivo de trabalho e o índice³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea(cAlias1)
	DbCloseArea()

	If( ValType(oTempTable) == "O")
	  oTempTable:Delete()
	  FreeObj(oTempTable)
	  oTempTable := Nil
	EndIf
#ENDIF	

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Funcao    ³Lj780QtdCalc³ Autor ³ Vendas e CRM		³ Data ³ 04.07.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Calcula a quantidade e  o valor do produto que esta   	  ³±±
±±³			 ³ posicionado na linha de impressao do relatorio			  ³±±	
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ LOJR780                                                    ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Lj780QtdCalc( nTipo )
Local nQuant	:= QUANT		// Recebe a quantidade do produto que esta sendo impresso 
Local cCodPro	:= COD			// Recebe o Codigo do produto
Local nQtdDev	:= 0			// Quantidade do produto que foi devolvida
Local nValDev   := 0			// Valor que foi devolvido
Local aArea 	:= GetArea()
Local nMoeda  	:= 1			// Moeda
Local nDecs 	:= 2			// Decimais
Local nResult	:= 0

Static nVlrAtu	                // Recebe o valor do produto que esta sendo impresso

If nTipo == 1
	nVlrAtu    := VALOR
	If (MV_PAR09 == 1)    		// Parametro que define se considera devolucao
		DbSelectArea("SD1")
		DbSetOrder(2)
		If DbSeek( xFilial("SD1") + cCodPro )
			While !Eof() .AND. ( SD1->D1_FILIAL + SD1->D1_COD == xFilial("SD1") + cCodPro )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica se o e' devolucao, e se esta dentro do periodo. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	     		If 	SD1->D1_TIPO <> "D" .OR. SD1->D1_ORIGLAN <> "LO".OR. ;
	     		(SD1->D1_EMISSAO < MV_PAR03 .OR. SD1->D1_EMISSAO > MV_PAR04)
					SD1->(dbSkip())
					Loop
				EndIf
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Atualiza a quantidade do produto que foi devolvido ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				nQtdDev += SD1->D1_QUANT
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Atualiza o Valor do produto que foi devolvido ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If cPaisLoc == "BRA"
					nValDev += SD1->D1_TOTAL + SD1->D1_VALIPI
				Else
					dbSelectArea("SF1")
					dbSetOrder(1)
					If dbSeek(xFilial("SF1") + SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA + SD1->D1_TIPO)
						nMoeda := 	Max(SF1->F1_MOEDA,1)
						nDecs  := 	MsDecimais(1)
						nVlrAtu += 	Round(xMoeda(SD1->D1_TOTAL,nMoeda,1,SD1->D1_EMISSAO,nDecs+1),nDecs) + ;
									RetImposto( SD1->D1_TES )[1] // Imposto Discriminado
					EndIf
				EndIf
			
				SD1->(dbSkip())
			End 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Caso tenha algum produto devolvido atualiza a quantidade³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( nQtdDev > 0 .OR. nValDev > 0 ) 
		  		nQuant 	-= nQtdDev
		  		nVlrAtu	-= nValDev
			EndIf          		
		EndIf
	EndIf
EndIf
		
RestArea( aArea )

If nTipo == 1
	nResult := nQuant
Else
	nResult := Abs(nVlrAtu)
EndIf

Return nResult  
