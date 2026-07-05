/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR130.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR130"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR130   ³ Autor ³ Rodrigo Toledo        ³ Data ³ 27.04.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Orcado x Realizado                      		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR130()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Proposta Inicial 	?                                      ³
//³ MV_PAR02 : Proposta Final 		?                                      ³
//³ MV_PAR03 : Cliente Inicial ?                                      	   ³
//³ MV_PAR04 : Cliente Final   ?                                      	   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("ATR130",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr130RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr130RptDef ºAutor  ³Rodrigo Toledo      º Data ³  27/04/2011 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR130                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr130RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local aOrdem	:= {}  
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE 
	cAlias1	:= "ADY"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR130" TITLE STR0003 PARAMETER "ATR130" ACTION {|oReport| Tcr130PrtRpt(oReport, aOrdem, cAlias1)} DESCRIPTION STR0004 + STR0005 + STR0006
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0007 TABLES "ADY" ORDERS aOrdem // "Cabecalho da Proposta"
		oSection1:SetLineBreak()  	                        
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "ADY_PROPOS" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_PREVIS" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_OPORTU" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_REVISA" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_CLIENT" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_LOJENT" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_DSCENT" 	OF oSection1 ALIAS "ADY" BLOCK {||IIF((cAlias1)->ADY_ENTIDA == "1",Posicione("SA1",1,xFilial("SA1")+(cAlias1)->ADY_CODIGO+(cAlias1)->ADY_LOJA,"A1_NOME"),Posicione("SUS",1,xFilial("SUS")+(cAlias1)->ADY_CODIGO+(cAlias1)->ADY_LOJA,"US_NOME"))}
		DEFINE CELL NAME "ADY_TABELA" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_DATA" 	OF oSection1 ALIAS "ADY"
		DEFINE CELL NAME "ADY_CODIGO" 	OF oSection1 ALIAS "ADY"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0008 TABLE "ADZ" // "Itens da Proposta"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao2  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
		DEFINE CELL NAME "ADZ_ITEM" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_ITEM",2)
		DEFINE CELL NAME "ADZ_PRODUT" 	OF oSection2 ALIAS "ADZ"
		DEFINE CELL NAME "ADZ_DESCRI" 	OF oSection2 ALIAS "ADZ"
		DEFINE CELL NAME "ADZ_UM" 		OF oSection2 ALIAS "ADZ"
		DEFINE CELL NAME "ADZ_MOEDA"	OF oSection2 ALIAS "ADZ"
		DEFINE CELL NAME "ADZ_CONDPG"	OF oSection2 ALIAS "ADZ"
		DEFINE CELL NAME "ADZ_TES"		OF oSection2 ALIAS "ADZ"			
		DEFINE CELL NAME "ADZ_QTDVEN" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_QTDVEN") HEADER ALIGN RIGHT
		DEFINE CELL NAME "ADZ_PRCVEN" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_PRCVEN",14) HEADER ALIGN RIGHT
		DEFINE CELL NAME "ADZ_PRCTAB" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_PRCTAB",14) HEADER ALIGN RIGHT
		DEFINE CELL NAME "ADZ_TOTAL" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_TOTAL",14) HEADER ALIGN RIGHT 
		DEFINE CELL NAME "ADZ_DESCON" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_DESCON",14) HEADER ALIGN RIGHT
		DEFINE CELL NAME "ADZ_VALDES" 	OF oSection2 ALIAS "ADZ" PICTURE PesqPict("ADZ","ADZ_VALDES",14) HEADER ALIGN RIGHT
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao3 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection3 OF oSection2 TITLE STR0009 TABLE "SC6" // "Itens do Pedido de Venda"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao3  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
		DEFINE CELL NAME "C6_PRODUTO" 	OF oSection3 ALIAS "SC6"
		DEFINE CELL NAME "C6_DESCRI" 	OF oSection3 ALIAS "SC6"
		DEFINE CELL NAME "C6_UM" 		OF oSection3 ALIAS "SC6"
		DEFINE CELL NAME "C6_QTDVEN"	OF oSection3 ALIAS "SC6"
		DEFINE CELL NAME "C6_TES"		OF oSection3 ALIAS "SC6"
		DEFINE CELL NAME "C6_PRCVEN" 	OF oSection3 ALIAS "SC6" PICTURE PesqPict("SC6","C6_PRCVEN",14) HEADER ALIGN RIGHT
		DEFINE CELL NAME "C6_PRUNIT" 	OF oSection3 ALIAS "SC6" PICTURE PesqPict("SC6","C6_PRUNIT",14) HEADER ALIGN RIGHT
		DEFINE CELL NAME "C6_VALOR" 	OF oSection3 ALIAS "SC6" PICTURE PesqPict("SC6","C6_VALOR",14) HEADER ALIGN RIGHT			
Return oReport
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr130PrtRptºAutor  ³Rodrigo Toledo      º Data ³  27/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem:  Array com as ordens de impressao disponiveis      	º±±
±±º          ³cAlias1: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR130                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr130PrtRpt( oReport, aOrdem, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local oSection3 := oSection2:Section(1)				// Define a secao 3 do relatorio
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local cDbMs		:= ""								// Nome do BD              
Local aTotal	:= {0}								// Monta array para totalizar o valor total da prosposta/contr. manut./ordem servico
Local aCServ	:= {}								// Monta array para gravar as inf. do contrato de servico
Local aOServ	:= {}								// Monta array para gravar as inf. da ordem de servico
Local nLoop		:= 0								// Contador
Local nPos		:= 0                                // Localiza a posicao do codigo do produto
Local nVlrPrUn	:= 0								// Armazena o valor unitario do calculo de preco medio
Local nVlrPrLi	:= 0								// Armazena o valor prc lista do calculo de preco medio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

#IFDEF TOP
	cDbMs	:= UPPER(TcGetDb())  //define o tipo de banco para diferenciar o operador de soma
	cOrderBy := "% ADY_FILIAL,ADY_PROPOS %"
	cIndexKey:= "ADY_FILIAL+ADY_PROPOS"
#ENDIF

#IFDEF TOP
	DbSelectArea("ADY") 
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR130")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	ADY_PROPOS,	ADY_PREVIS,	ADY_OPORTU, ADY_REVISA, ADY_ENTIDA,ADY_CLIENT,
				ADY_LOJA,ADY_LOJENT, ADY_TABELA, ADY_DATA, ADY_CODIGO 
								
		FROM %table:ADY% ADY
		WHERE	ADY_FILIAL = %xfilial:ADY%		AND
				ADY_PROPOS >= %exp:mv_par01%   AND  
				ADY_PROPOS <= %exp:mv_par02%   AND
				ADY_CLIENT >= %exp:mv_par03%	AND				
				ADY_CLIENT <= %exp:mv_par04%	AND
				ADY.%notDel%

		ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1 

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR130")

	DbSelectArea(cAlias1) 
	DbSetOrder(1)

	cFiltro := "ADY_FILIAL=='"+xFilial("ADY")+"'.AND."
	cFiltro += "ADY_PROPOS>='"+MV_PAR01+"'.AND."
	cFiltro += "ADY_PROPOS<='"+MV_PAR02+"'.AND."
	cFiltro += "ADY_CLIENT>='"+MV_PAR03+"'.AND."
	cFiltro += "ADY_CLIENT<='"+MV_PAR04+"'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AB7 (Itens da OS) 								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cIndexKey )

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(05))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)

While !oReport:Cancel() .AND. !(cAlias1)->(Eof())
	
	If nLin > 0
		oReport:Section(1):SetPageBreak(.T.)
	EndIf
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf	
	cQuebra := (cAlias1)->ADY_PROPOS
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !isBlind()		
		oSection1:Init()
		oSection1:PrintLine()
	EndIf
	
	ADZ->(DbSetOrder(3))
	ADZ->(MsSeek(xFilial("ADZ")+(cAlias1)->ADY_PROPOS+(cAlias1)->ADY_PREVIS))	
	While (ADZ->(!Eof()) .AND. xFilial("ADZ") == ADZ->ADZ_FILIAL .AND.;
						 (cAlias1)->ADY_PROPOS == ADZ->ADZ_PROPOS .AND.;
						 (cAlias1)->ADY_PREVIS == ADZ->ADZ_REVISA)							        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 2 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTotal[1] += ADZ->ADZ_TOTAL 
		If !isBlind()
			oSection2:Init()
			oSection2:PrintLine()
		EndIf
		ADZ->(DbSkip())
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o total da proposta |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nLin := oReport:Row()
	oReport:ThinLine()
	oReport:SkipLine(1)  	
	oReport:PrintText(STR0010, oReport:Row()) //"   Total Geral"
	oReport:SkipLine()
	oReport:ThinLine()	
	oReport:PrintText(Transform(aTotal[1], PesqPict("ADZ","ADZ_TOTAL",14)))
 	oReport:SkipLine()
 	aTotal[1] := 0
 		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza os registros do contrato de servico ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
	AAM->(DbSetOrder(3))
	If AAM->(DbSeek(xFilial("AAM")+(cAlias1)->ADY_PROPOS+(cAlias1)->ADY_PREVIS))
		SC6->(DbSetOrder(6))
		If SC6->(DbSeek(xFilial("SC6")+AAM->AAM_CONTRT+"1"))		
			While (SC6->(!Eof()) .AND. SC6->C6_FILIAL == xFilial("SC6") .AND.;
										SC6->C6_CONTRT == AAM->AAM_CONTRT .AND.;
										SC6->C6_TPCONTRT == "1")
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta array para o contrato de servico ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
				If (nPos := aScan(aCServ,{|x| x[1] == SC6->C6_PRODUTO})) == 0
					aAdd(aCServ,{SC6->C6_PRODUTO,;	// 1- Codigo do Produto
						SC6->C6_DESCRI,;			// 2- Descricao do Produto
						SC6->C6_UM,;				// 3- Unidade de Medida
						SC6->C6_QTDVEN,;			// 4- Quantidade Vendida
						SC6->C6_TES,;				// 5- Tipo Saida
						SC6->C6_PRCVEN,;			// 6- Prc Unitario
						SC6->C6_PRUNIT,;			// 7- Prc Lista
						SC6->C6_VALOR})				// 8- Vlr. Total
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Atualiza valores do produto ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
					nVlrPrUn := 0
					nVlrPrLi := 0
					nVlrPrUn := (((aCServ[nPos,4] * aCServ[nPos,6]) + (SC6->C6_QTDVEN * SC6->C6_PRCVEN))/(aCServ[nPos,4]+SC6->C6_QTDVEN))
					nVlrPrLi := (((aCServ[nPos,4] * aCServ[nPos,7]) + (SC6->C6_QTDVEN * SC6->C6_PRUNIT))/(aCServ[nPos,4]+SC6->C6_QTDVEN))
					aCServ[nPos,4] += SC6->C6_QTDVEN
					aCServ[nPos,6] := Round(nVlrPrUn,2)
					aCServ[nPos,7] := Round(nVlrPrLi,2)
					aCServ[nPos,8] := Round((aCServ[nPos,4] * nVlrPrUn),2)
				EndIf
				SC6->(DbSkip())
			End			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atribui os valores p/ as celulas da secao 3 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
			If Len(aCServ) > 0
				oReport:PrintText(STR0011, oReport:Row()) //Contrato de Serviço
				oReport:SkipLine() 
				oReport:ThinLine()				
				For nLoop := 1 To Len(aCServ)				               
					oSection3:Cell("C6_PRODUTO"):SetValue(aCServ[nLoop,1])
				    oSection3:Cell("C6_DESCRI"):SetValue(aCServ[nLoop,2])
				    oSection3:Cell("C6_UM"):SetValue(aCServ[nLoop,3])
				    oSection3:Cell("C6_QTDVEN"):SetValue(aCServ[nLoop,4])
				    oSection3:Cell("C6_TES"):SetValue(aCServ[nLoop,5])
				    oSection3:Cell("C6_PRCVEN"):SetValue(aCServ[nLoop,6])
				    oSection3:Cell("C6_PRUNIT"):SetValue(aCServ[nLoop,7])
				    oSection3:Cell("C6_VALOR"):SetValue(aCServ[nLoop,8])
					
					aTotal[1] += aCServ[nLoop,8]
					If !isBlind()
						oSection3:Init()
						oSection3:PrintLine()
					EndIf
				Next nLoop  				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime a secao 3 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oReport:SkipLine()
				oReport:ThinLine()
				oReport:PrintText(STR0010, oReport:Row()) //"   Total Geral"
				oReport:SkipLine()   
				oReport:ThinLine()				
				oReport:PrintText(Transform(aTotal[1], PesqPict("SC6","C6_VALOR",14)),oReport:Row())				
				oReport:SkipLine(2)
				oSection3:Finish() 
				aCServ := {}
				aTotal[1] := 0
			EndIf
		EndIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Localiza os registros da ordem de servico ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	AAH->(DbSetOrder(6))
	AA3->(DbSetOrder(2))
	AB7->(DbSetOrder(5))
	AB8->(DbSetOrder(1))
	SC6->(DbSetOrder(1))

	If	AAH->(DbSeek(xFilial("AAH")+(cAlias1)->ADY_PROPOS+(cAlias1)->ADY_PREVIS)) 	.AND.;
		AA3->(DbSeek(xFilial("AA3")+AAH->AAH_CONTRT+AAH->AAH_CODCLI+AAH->AAH_LOJA)) 	.AND.;
		AB7->(DbSeek(xFilial("AB7")+AA3->AA3_CODFAB+AA3->AA3_LOJAFA+AA3->AA3_CODPRO+AA3->AA3_NUMSER))
		
		While (AB7->(!Eof()) .AND. AB7->AB7_FILIAL == xFilial("AB7") .AND.;
		 							AB7->AB7_CODFAB == AA3->AA3_CODFAB .AND.;				
		 							AB7->AB7_LOJAFA == AA3->AA3_LOJAFA .AND.;
		 							AB7->AB7_CODPRO == AA3->AA3_CODPRO .AND.;
		 							AB7->AB7_NUMSER == AA3->AA3_NUMSER)	 
		 								
			AB8->(DbSeek(xFilial("AB8")+AB7->AB7_NUMOS+AB7->AB7_ITEM))
			
			While !AB8->(Eof()) .AND.	AB8->AB8_FILIAL	== xFilial("AB8")	.AND.;
										AB8->AB8_NUMOS 	== AB7->AB7_NUMOS	.AND.;
										AB8->AB8_ITEM 	== AB7->AB7_ITEM    
							
				SC6->(DbSeek(xFilial("SC6")+LEFT(AB8->AB8_NUMPV,6))) 
				
				While (SC6->(!Eof()) .AND.	SC6->C6_FILIAL == xFilial("SC6") .AND.;
											SC6->C6_NUM == LEFT(AB8->AB8_NUMPV,6))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Monta array para ordem de servico ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
					If (nPos := aScan(aOServ,{|x| x[1] == SC6->C6_PRODUTO})) == 0
						aAdd(aOServ,{SC6->C6_PRODUTO,;	// 1- Codigo do Produto
							SC6->C6_DESCRI,;			// 2- Descricao do Produto
							SC6->C6_UM,;				// 3- Unidade de Medida
							SC6->C6_QTDVEN,;			// 4- Quantidade Vendida
							SC6->C6_TES,;				// 5- Tipo Saida
							SC6->C6_PRCVEN,;			// 6- Prc Unitario
							SC6->C6_PRUNIT,;			// 7- Prc Lista
							SC6->C6_VALOR})				// 8- Vlr. Total
					Else 				
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Atualiza valores do produto ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
						nVlrPrUn := 0
						nVlrPrLi := 0
						nVlrPrUn := (((aOServ[nPos,4] * aOServ[nPos,6]) + (SC6->C6_QTDVEN * SC6->C6_PRCVEN))/(aOServ[nPos,4]+SC6->C6_QTDVEN))
						nVlrPrLi := (((aOServ[nPos,4] * aOServ[nPos,7]) + (SC6->C6_QTDVEN * SC6->C6_PRUNIT))/(aOServ[nPos,4]+SC6->C6_QTDVEN))
						aOServ[nPos,4] += SC6->C6_QTDVEN
						aOServ[nPos,6] := Round(nVlrPrUn,2)
						aOServ[nPos,7] := Round(nVlrPrLi,2)
						aOServ[nPos,8] := Round((aOServ[nPos,4] * nVlrPrUn),2)
					EndIf
					SC6->(DbSkip())
				End						
				AB8->(DbSkip())
			End
			AB7->(DbSkip())
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atribui os valores p/ as celulas da secao 3 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		If Len(aOServ) > 0					
			oReport:PrintText(STR0012, oReport:Row())   //Ordem de Servico
			oReport:SkipLine() 
			oReport:ThinLine()				
			For nLoop := 1 To Len(aOServ)
				oSection3:Cell("C6_PRODUTO"):SetValue(aOServ[nLoop,1])
			    oSection3:Cell("C6_DESCRI"):SetValue(aOServ[nLoop,2])
			    oSection3:Cell("C6_UM"):SetValue(aOServ[nLoop,3])
			    oSection3:Cell("C6_QTDVEN"):SetValue(aOServ[nLoop,4])
			    oSection3:Cell("C6_TES"):SetValue(aOServ[nLoop,5])
			    oSection3:Cell("C6_PRCVEN"):SetValue(aOServ[nLoop,6])
			    oSection3:Cell("C6_PRUNIT"):SetValue(aOServ[nLoop,7])
			    oSection3:Cell("C6_VALOR"):SetValue(aOServ[nLoop,8])
			    
			    aTotal[1] += aOServ[nLoop,8]
				If !isBlind()
					oSection3:Init()
					oSection3:PrintLine()
				EndIf
			Next nLoop					
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a secao 3 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oReport:SkipLine()
			oReport:ThinLine()
			oReport:PrintText(STR0010, oReport:Row()) //"   Total Geral"
			oReport:SkipLine()
			oReport:ThinLine()
			oReport:PrintText(Transform(aTotal[1], PesqPict("SC6","C6_VALOR",14)),oReport:Row())
			oReport:SkipLine(2)
			oSection3:Finish()
			aOServ := {}
			aTotal[1] := 0
		EndIf


	EndIf	
	            
	oSection1:Finish()
	oSection2:Finish()	
	
	dbSelectArea(cAlias1)
	dbSkip()		
End 

Return

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definiçoes do relatorio.
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Tcr130RptDef()

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr130PrtRpt( oReport , {} , GetNextAlias() )

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg