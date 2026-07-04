/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TMKR039.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKSegmentoºAutor  ³ Vendas e CRM       º Data ³  03/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Valida se as çopcoes de segmento de negocios colocados nos   º±±
±±º          ³parametros para selecao sao compativeis com o cliente.      º±±
±±º          ³DBF-> Neste caso a validacao eh feita para cada registro,   º±±
±±º          ³entao a chamada desta funcao devera estar dentro do loop.   º±±
±±º          ³TOP-> Nesta regra a funcao montara uma string que devera    º±±
±±º          ³ser concatenada na query dentro da clausula WHERE e a tabelaº±±
±±º          ³adicionada manualmente na clausula FROM, com a indicacao do º±±
±±º          ³alias, pois o mesmo estara sendo utilizado na clausula WHEREº±±
±±º          ³portanto a funcao devera ser chamada apenas uma vez.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ cExp1  - Codigo do primeiro segmento de negocio            º±±
±±º          ³ cExp2  - Codigo do segundo segmento de negocio             º±±
±±º          ³ cExp3  - Codigo do terceiro segmento de negocio            º±±
±±º          ³ cExp4  - Codigo do quarto segmento de negocio              º±±
±±º          ³ cExp5  - Codigo do quinto de negocio                       º±±
±±º          ³ cExp6  - Codigo do sexto de negocio                        º±±
±±º          ³ cExp7  - Codigo do setimo de negocio                       º±±
±±º          ³ cExp8  - Codigo do oitavo de negocio                       º±±
±±º          ³ cExp9  - Alias em que sera validado o segmento SA1 ou SUS  º±±
±±º          ³ cExp10 - Chave de pesquisa da entidade                     º±±
±±º          ³ cExp11 - Referencia, retorna a expressao que sera          º±±
±±º          ³          implementada na query para validar o segmento     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TKSegmento(	cSeg1,	cSeg2,	cSeg3,	cSeg4,;
						cSeg5,	cSeg6,	cSeg7,	cSeg8,;
						cAlias,	cChave,	cWhere)

Local aArea		:= GetArea()				// Salva a area antes da pesquisa
Local nTMKCTSG	:= SuperGetMV("MV_TMKCTSG")		// (N = .OR.) (S = .AND.) (C = Contido)
Local nTMKSEGN	:= SuperGetMV("MV_TMKSEGN")		// Varia de 1 a 8
Local lRet		:= .F.						// Guarda a validacao para retornar
Local cVar		:= ""						// Nome da variavel da base da dados
Local cSegMV	:= ""						// Conteudo dos parametros
Local cSegDB	:= ""						// Conteudo da base de dados
Local aSegMV	:= {}						// Array com os segmentos dos parametros
Local nI		:= 0 						// Contador
Local nSegMv	:= 0 						// Contador auxiliar para o Len

Default cSeg1	:= ""						// Guarda o codigo do segmento de negocio 1	
Default cSeg2	:= ""						// Guarda o codigo do segmento de negocio 2
Default cSeg3	:= ""						// Guarda o codigo do segmento de negocio 3
Default cSeg4	:= ""						// Guarda o codigo do segmento de negocio 4
Default cSeg5	:= ""						// Guarda o codigo do segmento de negocio 5
Default cSeg6	:= ""						// Guarda o codigo do segmento de negocio 6
Default cSeg7	:= ""						// Guarda o codigo do segmento de negocio 7
Default cSeg8	:= ""						// Guarda o codigo do segmento de negocio 8
Default cAlias	:= ""						// Alias que valida o segmento
Default cChave	:= ""                       // Chave da entidade
Default cWhere	:= ""						// Expressao que valida o segmento

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se o parametro da variavel cWhere foi passado, entao eu retorno a expressao da query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ValType(cWhere) == "C"
	// O parametro 11 devera ser passado com referencia para retornar a clausula WHERE
	If !Empty(cSeg1+cSeg2+cSeg3+cSeg4+cSeg5+cSeg6+cSeg7+cSeg8)
		AADD(aSegMV, cSeg1)
		AADD(aSegMV, cSeg2)
		AADD(aSegMV, cSeg3)
		AADD(aSegMV, cSeg4)
		AADD(aSegMV, cSeg5)
		AADD(aSegMV, cSeg6)
		AADD(aSegMV, cSeg7)
		AADD(aSegMV, cSeg8)
		
		// Cria neste ponto a amarracao com a tabela da entidade pela chave primaria
		cWhere :=	cAlias + "." + IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_FILIAL = '" + xFilial(cAlias) + "' AND " +;
					cAlias + "." + IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_COD = SubString(SUC.UC_CHAVE,1,6) AND " +;
					cAlias + "." + IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_LOJA = SubString(SUC.UC_CHAVE,7,2) AND "
		
		Do Case
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³MV_TMKCTSG == "N"                                                                         ³
			//³                                                                                          ³
			//³Neste caso a regra sera igual ao caso anterior, onde sera considerado apenas os parametros³
			//³informados e valida caso um dos parametros seja igual ao conteudo da base da dados.       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case nTMKCTSG == "N"		// Atende a regra com operador .OR.
				cWhere += " ( "
				For nI := 1 TO 8
					cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
					cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
					If !Empty(aSegMV[nI])
						cWhere += cAlias + "." + cVar + " = '" + aSegMV[nI] + "' OR "
					Endif
				Next nI
				cWhere := SubStr(cWhere,1,Len(cWhere)-4) + ") AND "
				cWhere += " " + cAlias + ".D_E_L_E_T_ <> '*'"
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³MV_TMKCTSG == "S"                                                                                  ³
			//³                                                                                                   ³
			//³Para esta regra tambem serao ignorados os parametros em branco e para validar o segmento de negocio³
			//³todos os parametros informados deverao ser iguais aos valores da base de dados.                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case nTMKCTSG == "S"		// Atende a regra com operador .AND.
				For nI := 1 TO 8
					cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
					cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
					If !Empty(aSegMV[nI])
						cWhere += cAlias + "." + cVar + " = '" + aSegMV[nI] + "' AND "
					Endif
				Next nI
				cWhere += " " + cAlias + ".D_E_L_E_T_ <> '*'"
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄA¿
			//³MV_TMKCTSG == "C" e MV_TMKSEGN == N [1-8]                                                                                         ³
			//³                                                                                                                                  ³
			//³Para esta regra serao considerados os parametros informados e desconsiderados os parametros em branco, onde caso alguma ocorrencia³
			//³dos parametros seja encontrada na base de dados considerando o nivel dos segmentos, o retorno sera verdadeiro.                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAÙ
			Case nTMKCTSG == "C"		// Atende a regra com operador $ CONTIDO
				nSegMv := Len(aSegMV)
				For nI := 1 TO nSegMv
					If !Empty(aSegMV[nI])
						cSegMV += "'" + aSegMV[nI] + "',"
					Endif
				Next nI
				cSegMV := "(" + SubStr(cSegMV,1,Len(cSegMV)-1) + ")"
				cWhere += " ( "
				For nI := 1 TO nTMKSEGN
					cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
					cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
					cWhere += cAlias + "." + cVar + " IN " + cSegMV + " OR "
				Next nI
				cWhere := SubStr(cWhere,1,Len(cWhere)-3) + ") AND "
				cWhere += " " + cAlias + ".D_E_L_E_T_ <> '*'"
		EndCase
	Endif
	lRet := .T.
Else
	If !Empty(cSeg1+cSeg2+cSeg3+cSeg4+cSeg5+cSeg6+cSeg7+cSeg8)
		AADD(aSegMV, cSeg1)
		AADD(aSegMV, cSeg2)
		AADD(aSegMV, cSeg3)
		AADD(aSegMV, cSeg4)
		AADD(aSegMV, cSeg5)
		AADD(aSegMV, cSeg6)
		AADD(aSegMV, cSeg7)
		AADD(aSegMV, cSeg8)
		DbSelectArea(cAlias)
		DbSetOrder(1)
		If DbSeek(xFilial(cAlias) + AllTrim(cChave))
			
			Do Case
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³MV_TMKCTSG == "N"                                                                         ³
				//³                                                                                          ³
				//³Neste caso a regra sera igual ao caso anterior, onde sera considerado apenas os parametros³
				//³informados e valida caso um dos parametros seja igual ao conteudo da base da dados.       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Case nTMKCTSG == "N"		// Atende a regra com operador .OR.
					For nI := 1 TO 8
						cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
						cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
						If !Empty(aSegMV[nI]) .AND. aSegMV[nI] == FieldGet(FieldPos(cVar))
							lRet := .T.
							Exit
						Endif
					Next nI
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³MV_TMKCTSG == "S"                                                                                  ³
				//³                                                                                                   ³
				//³Para esta regra tambem serao ignorados os parametros em branco e para validar o segmento de negocio³
				//³todos os parametros informados deverao ser iguais aos valores da base de dados.                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				Case nTMKCTSG == "S"		// Atende a regra com operador .AND.
					For nI := 1 TO 8
						If !Empty(aSegMV[nI])
							cSegMV+=aSegMV[nI]
							cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
							cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
							cSegDB += FieldGet(FieldPos(cVar))
						Endif
					Next nI
					lRet := IIF(cSegDB==cSegMV,.T.,.F.)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄA¿
				//³MV_TMKCTSG == "C" e MV_TMKSEGN == N [1-8]                                                                                         ³
				//³                                                                                                                                  ³
				//³Para esta regra serao considerados os parametros informados e desconsiderados os parametros em branco, onde caso alguma ocorrencia³
				//³dos parametros seja encontrada na base de dados considerando o nivel dos segmentos, o retorno sera verdadeiro.                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄAÙ
				Case nTMKCTSG == "C"		// Atende a regra com operador $ contido
					For nI := 1 TO nTMKSEGN
						cVar := IIF(SubStr(cAlias,1,1)=="S",SubStr(cAlias,2,3),cAlias) + "_SATIV" + Str(nI,1)
						cVar := IIF(cVar=="US_SATIV1","US_SATIV",cVar)
						If !Empty(FieldGet(FieldPos(cVar))) .AND. aScan(aSegMV, {|x| x == FieldGet(FieldPos(cVar)) } ) > 0
							lRet := .T.
							Exit
						Endif
					Next nI
			EndCase
		Endif
	Else
		lRet := .T.
	Endif
Endif

RestArea(aArea)

Return(lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TkImpMemo ºAutor  ³ Vendas e CRM       º Data ³  05/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monta o texto conforme foi digitado pelo operador e quebra  º±±
±±º          ³as linhas no tamanho especificado sem cortar palavras e     º±±
±±º          ³devolve um array com os textos a serem impressos.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ cExp1 - Codigo de referencia da gravacao do memo           º±±
±±º          ³ nExp2 - Tamanho maximo de colunas do texto                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkMemo(cCodigo,nTam)

Local cString	:= MSMM(cCodigo,nTam)		// Carrega o memo da base de dados
Local nI		:= 0    					// Contador dos caracteres	
Local nL		:= 0						// Contador das linhas 
Local cLinha	:= ""						// Guarda a linha editada no campo memo
Local aLinhas	:= {}						// Array com o memo dividido em linhas
Local nJ		:= 0						// Contador das linhas 
Local nString 	:= Len(cString)	            // Contador auxiliar para o Len

For nI := 1 TO nString
	If (MsAscII(SubStr(cString,nI,1)) <> 13) .And. (nL < nTam)
		// Enquanto não houve enter na digitacao e a linha nao atingiu o tamanho maximo
		cLinha+=SubStr(cString,nI,1)
		nL++
	Else    
		// Se a linha atingiu o tamanho maximo ela vai entrar no array
		If MsAscII(SubStr(cString,nI,1)) <> 13
			nI--
			For nJ := Len(cLinha) TO 1 Step -1
				// Verifica se a ultima palavra da linha foi quebrada, entao retira e passa pra frente
				If SubStr(cLinha,nJ,1) <> " "
					nI--
					nL--
				Else
					Exit
				Endif
			Next nJ
			// Se a palavra for maior que o tamanho maximo entao ela vai ser quebrada
			If nL <=0
				nL := Len(cLinha)
			Endif
		Endif
		
		// Testa o valor de nL para proteger o fonte e insere a linha no array
		If nL >= 0
			cLinha := SubStr(cLinha,1,nL)
			cLinha := StrTran(cLinha, Chr(10), "")
			AADD(aLinhas, cLinha)
			cLinha := ""
			nL := 0
		Endif	
	Endif
Next nI

// Se o nL > 0, eh porque o usuario nao deu enter no fim do memo e eu adiciono a linha no array.
If nL >= 0
	cLinha := SubStr(cLinha,1,nL)
	cLinha := StrTran(cLinha, Chr(10), "")	
	AADD(aLinhas, cLinha)
	cLinha := ""
	nL := 0
Endif	

Return(aLinhas)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TkIncLine ºAutor  ³ Vendas e CRM       º Data ³  06/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Incrementa o contador de linhas para impressao nos          º±±
±±º          ³relatorios e verifica se uma nova pagina sera iniciada.     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ nExp1    - Numero da linha em que sera impresso            º±±
±±º          ³ nExp2    - Quantidade de linhas a serem incrementadas      º±±
±±º          ³ nExp3    - Numero maximo de linhas por pagina              º±±
±±º          ³ cExp4    - Titulo do cabecalho do relatorio                º±±
±±º          ³ cExp5    - Primeira linha do lalbel do relatorio           º±±
±±º          ³ cExp6    - Segunda linha do label do relatorio             º±±
±±º          ³ cExp7    - Nome do programa que sera impresso no cabecalho º±±
±±º          ³ nExp8    - Tamanho de colunas do relatorio                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkIncLine(	nLi,		nInc,		nMax,		Titulo,;
					cCabec1,	cCabec2,	NomeProg,	Tamanho)

Local nChrComp	:= IIF(aReturn[4]==1,15,18)		// Define se o caracter sera comprimido ou normal

nLi+=nInc
If nLi > nMax .OR. nLi < 5
	nLi := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,nChrComp)
	nLi++
Endif

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TkSX3Box  ºAutor  ³ Vendas e CRM       º Data ³  19/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que monta um array com todas as opcoes do combobox   º±±
±±º          ³a partir da leitura do dicionario de dados SX3.        	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ cExp1  - Nome do campo que sera pesquisado no SX3.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkSX3Box(cCampo)

Local aBox		:= {}			// Array com o conteudo de cada COMBOBOX de acordo com o idioma usado
Local aItens	:= {}			// Array contendo somente as opcoes do campo (Descricao de cada opcao)
Local nI		:= 0			// Contador
Local nLenAux 	:= 0			// Contador auxiliar para o Len
Local cComboBox	:= ""

cComboBox := Posicione("SX3", 2, AllTrim(cCampo), "AllTrim(X3CBox())")

If !Empty( cComboBox )
	If At("=",cComboBox) == 0
		cComboBox := &( cComboBox )
	EndIf
	If !Empty( cComboBox )
		aAdd(aBox, &('{"' + StrTran(AllTrim(cComboBox),';','","') + '"}') )
		If Len(aBox) > 0
			nLenAux := Len(aBox[1])
			For nI := 1 TO nLenAux
				AADD(aItens, aBox[1][nI])
			Next nI
		EndIf
	EndIf
EndIf
aBox	:= {}
Return(aItens)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TMKRFUN   ºAutor  ³ Vendas e CRM       º Data ³  07/04/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao monta uma string com os todos os campos do  	  º±±
±±º          ³alias principal da QUERY e do relatorio, onde sera tratado aº±±
±±º          ³expressao de filtro do usuario que podera conter um campo   º±±
±±º          ³nao contemplado no relatorio.                               º±±
±±º          ³Aproveitando a leitura do SX3 esta funcao retorna um        º±±
±±º          ³array contendo os parametros que deverao ser passados na 	  º±±
±±º          ³funcao SETFIELD que devera obrigatoriamente ser rodado para º±±
±±º          ³correcao dos campos da tabela temporaria gerada pela query. º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ cExp1     - Nome do alias que sera carregado os campos     º±±
±±º          ³ cExp2     - Referencia, Retornara os campos que a query    º±±
±±º          ³             devera contemplar, Exemplo:                    º±±
±±º          ³             U_TkSelect("SA1", @cCampos, @aSetField)          º±±
±±º          ³             "SELECT " + cCampos + " FROM " + RetSqlName(...º±±
±±º          ³ aExp3     - Referencia, Retorna os parametros que deverao  º±±
±±º          ³             ser enviados na funcao SETFIELD como exemplo:  º±±
±±º          ³             aSetField[n][1] = "SA1"       - Alias          º±±
±±º          ³             aSetField[n][2] = "A1_LCFIN"  - Campo          º±±
±±º          ³             aSetField[n][1] = "N"         - Tipo           º±±
±±º          ³             aSetField[n][1] = 14          - Tamanho        º±±
±±º          ³             aSetField[n][1] = 2           - Decimal        º±±
±±º          ³             Exemplo de Execussao                           º±±
±±º          ³             SetField(aSetField[n][1], aSetField[n][1],...) º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Call Center                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkSelect(cAlias, cCampos, aSetFileld)

Local aStruct	:= DbStruct()		// Nome, Tipo, Tamanho, Decimal
Local nI		:= 0 				// Contador
Local nLenAux 	:= Len(aStruct)		// Contador auxiliar para o Len

If !Empty(cAlias)
	DbSelectarea(cAlias)
Endif
aStruct := DbStruct()		

nLenAux := Len(aStruct)
For nI := 1 TO nLenAux
	cCampos += (aStruct[nI][1] + ", ")

	If aStruct[nI][2] $ ("N,D,L")					// Numerico, Data ou Logico
		AAdd(aSetFileld, {	aStruct[nI][1],;		// 01 - Nome
							aStruct[nI][2],;		// 02 - Tipo
							aStruct[nI][3],;		// 03 - Tamanho
							aStruct[nI][4]} )		// 04 - Decimal
	Endif
End
cCampos := SubStr(cCampos, 1, Len(cCampos)-2)

Return(.T.)
/*                          
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³TkSecsToHMS³ Autor ³ Vendas e CRM         ³ Data ³22/04/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Converte Segundos para Horas, Minutos e Segundos			  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³U_TkSecsToHMS( nSecsToHMS , @nHours , @nMinuts , @nSeconds )] ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³nExp1     -> Numero de Segundos que sera convertidos    	  ³±±
±±³   		 ³nExp2  	-> Valor das Horas			   	                  ³±±
±±³   		 ³nExp3  	-> Valor dos Minutos			   	              ³±±
±±³   		 ³nExp4    	-> Valor dos Segundos		   	                  ³±±
±±³   		 ³cExp5    	-> Tipo do Retorno Desejado: "H" ou "h" -> nHours ³±±
±±³   		 ³            							 "M" ou "m" -> nMinuts³±±
±±³   		 ³             							"S" ou "s" -> nSeconds³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function TkSecsToHMS(	nSecsToHMS , nHours , nMinuts , nSeconds ,;
						cRet	)
        
Local nRet	:= 0.00		// Retorno da funcao

Default nSecsToHMS	:= 0.00
Default cRet		:= "H"

nHours	:= SecsToHrs( nSecsToHMS ) // Transforma Segundos em Horas
nMinuts	:= SecsToMin( nSecsToHMS ) // Transforma Segundos em Minutos
nSeconds:= ( HrsToSecs( nHours ) + MinToSecs( nMinuts ) )
nSeconds:= ( nSecsToHMS - nSeconds )
nSeconds:= Int( nSeconds )
nSeconds:= Mod( nSeconds , 60 )

If ( cRet $ "Hh" )
	nRet := nHours
ElseIf ( cRet $ "Mm" )
	nRet := nMinuts
ElseIf ( cRet $ "Ss" )
	nRet := nSeconds
Endif

Return( nRet )

/*                          
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao	 ³TkHMSToTime³ Autor ³ Vendas e CRM         ³ Data ³22/04/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Transformar Valores de Horas, Minutos e Segundos em String  ³±±
±±³          ³Padrao "HH:MM:SS"                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³( [ < nHours > ] , [ < nMinuts > ] , [ < nSeconds > ]       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³nHours 		-> Valor das Horas				   	          ³±±
±±³   		 ³nMinuts		-> Valor dos Minutos			   	          ³±±
±±³   		 ³nSeconds		-> Valor dos Segundos			   	          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkHMSToTime( nHours , nMinuts , nSeconds )

Local cTime

Default nHours		:= 0.00
Default nMinuts		:= 0.00
Default nSeconds	:= 0.00

cTime := AllTrim( Str( nHours ) )
cTime := StrZero( Val( cTime ) , Max( Len( cTime ) , 2 ) )
cTime += ":"
cTime += StrZero( Val( AllTrim( Str( nMinuts  ) ) ) , 2 )
cTime += ":"
cTime += StrZero( Val( AllTrim( Str( nSeconds ) ) ) , 2 )

Return( cTime )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TKCABECPADºAutor  ³ Vendas e CRM       º Data ³  12/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Esta funcao monta uma estrutura padrao com os campos        º±±
±±º          ³necessarios para a impressao do cabecalho em relatorios de  º±±
±±º          ³Telemarketing, Televendas e Telecobranca. O retorno e a     º±±
±±º          ³posicao da linha no relatorio.							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³cExp1      -Rotina de Telemarkenting/Televendas/Telecobrancaº±±
±±º          ³aExp2      -Array com a descricao dos campos                º±±
±±º          ³nExp3      -Numero da linha em que sera impresso            º±±
±±º          ³nExp4      -Numero maximo de linhas por pagina              º±±
±±º          ³cExp5      -Titulo do cabecalho do relatorio                º±±
±±º          ³cExp6      -Primeira linha do lalbel do relatorio           º±±
±±º          ³cExp7      -Segunda linha do label do relatorio             º±±
±±º          ³cExp8      -Nome do programa que sera impresso no cabecalho º±±
±±º          ³nExp9      -Tamanho de colunas do relatorio                 º±±
±±º          ³aExp10     -Status do Atendimento  (Opcoes do campo no SX3) º±±
±±º          ³aExp11     -Tipo de Ligacao (Opcoes do campo no SX3)        º±±
±±º          ³lExp12     -Habilita informacoes de encerramento			  º±±
±±º          ³aExp13     -Tipo de Operacao (Opcoes do campo no SX3)       º±±
±±º          ³aExp14     -Tipo de Marketing(Opcoes do campo no SX3)       º±±
±±º          ³aExp15     -Tipo de Frete (Opcoes do campo no SX3)       	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CALL CENTER / RELATORIOS                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkCabecPad(cRotina		,aCampos	,nLi			,nMax		,;
					titulo		,cCabec1	,cCabec2		,nomeprog	,;
					tamanho		,aUC_Status	,aUC_Operaca	,lEncer		,;
					aUA_Oper	,aUA_TMK	,aUA_TpFrete	)

Local cDesc		:= ""		// Variavel de Auxilio 			
Local aLinOb	:= {}		// Array com o memo dividido em linhas
Local nLinOb	:= 0 		// Contador auxiliar para o Len
Local aLinEnc	:= {}		// Array com o memo dividido em linhas
Local nLinEnc	:= 0		// Contador auxiliar para o Len
Local nX		:= 0		// Controle
Local cSUC		:= "SUC"	// Gerencia o alias para tratamento em top e dbf
Local cSUA		:= "SUA"	// Gerencia o alias para tratamento em top e dbf
Local lProspect	:= .F.		// Variavel que indica se o atendimento foi p/ Prospect
Local aPDFields := {"U7_NOME","A3_NOME","A1_NOME","US_NOME","A1_TEL","A1_END","US_END"}

FATPDLoad(/*cUserPDA*/, /*aAlias*/, aPDFields)

Default lEncer  := .F.		// Flag para nao imprimir as informacoes do encerramento

Do Case

	// Cabecalho para o Telemarketing
	Case cRotina == "SUC"

		U_TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[1][1],12) + ":" //"Data do atendimento"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_DATA,10)
		@ nLi,Limite/2	PSay PadR(aCampos[2][1],12) + ":" //"Contato"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_CODCONT,6) + " - " + PadR(TkDadosContato((cSUC)->UC_CODCONT,0),30)   
			
		DbSelectArea("SX5")
		DbSetOrder(1)
		If MsSeek(xFilial("SX5")+"T5"+(cSUC)->UC_ENTIDAD)
			cDesc := X5DESCRI()
		Else
			cDesc := ""
		Endif
		
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[3][1],12) + ":" //"Codigo do atendimento"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_CODIGO,6)
		@ nLi,Limite/2	PSay PadR(aCampos[4][1],12) + ":" //"Fone Com.1"
		@ nLi,PCol()+1	PSay PadR(Transform( TkDadosContato((cSUC)->UC_CODCONT,8) + TkDadosContato((cSUC)->UC_CODCONT,4) , "@R (99)9999-9999"),13)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[5][1],12) + ":" //"Operador"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_OPERADO,6)+ " - " + PadR(FATPDObfuscate(Posicione("SU7",1,xFilial("SU7")+(cSUC)->UC_OPERADO,"U7_NOME"),"U7_NOME"),40)
		@ nLi,Limite/2	PSay PadR(aCampos[6][1],12) + ":"	// "E-Mail"
		@ nLi,PCol()+1	PSay PadR(TkDadosContato((cSUC)->UC_CODCONT,10),40)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[7][1],12) + ":" //"Tipo do atendimento"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty((cSUC)->UC_OPERACA),aUC_Operaca[Val((cSUC)->UC_OPERACA)],""),47)
		@ nLi,Limite/2	PSay PadR(aCampos[8][1],12) + ":" //"Descricao da Entidade"
		@ nLi,PCol()+1	PSay PadR(cDesc,120)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[9][1],12) + ":" //"Tipo de Comunicacao"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_TIPO,6)  + " - " + PadR(Posicione("SUL",1,xFilial("SUL")+(cSUC)->UC_TIPO,"UL_DESC"),55)
		@ nLi,Limite/2	PSay PadR(aCampos[10][1],12) + ":" //"Nome da Empresa"
		@ nLi,PCol()+1	PSay PadR(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,1),120)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[11][1],12) + ":"	// "Midia"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_MIDIA,6) + " - " +PadR(Posicione("SUH",1,xFilial("SUH")+(cSUC)->UC_MIDIA,"UH_DESC"),40)
		@ nLi,Limite/2	PSay PadR(aCampos[12][1],12) + ":"	// "Telefone"
		@ nLi,PCol()+1	PSay PadR(Transform(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,9)+TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,6) , "@R (99)9999-9999"),13)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[13][1],12) + ":"	// "Campanha"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_CODCAMP,6)+ " - " + PadR(Posicione("SUO",1,xFilial("SUO")+(cSUC)->UC_MIDIA,"UO_DESC"),40) 
		@ nLi,Limite/2	PSay PadR(aCampos[14][1],12) + ":"	// "Endereco"
		@ nLi,PCol()+1	PSay PadR(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,2),40)
	
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[15][1],12) + ":" //"Status do atendimento"
		@ nLi,PCol()+1	PSay PadR(IIF(!Empty((cSUC)->UC_STATUS),aUC_Status[Val((cSUC)->UC_STATUS)],""),47)
		@ nLi,Limite/2	PSay PadR(aCampos[16][1],12) + ":"	// "Bairro"
		@ nLi,PCol()+1	PSay PadR(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,10),40)
			
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[17][1],12) + ":"	// "Data do Retorno"
		@ nLi,PCol()+1	PSay PadR(DTOC((cSUC)->UC_PENDENT),8) + " - " + (cDia:= Tk_DiaSemana((cSUC)->UC_PENDENT,Nil,Nil))
		@ nLi,Limite/2	PSay PadR(aCampos[18][1],12) + ":" // "Cidade"
		@ nLi,PCol()+1	PSay PadR(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,3),120)
			
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[19][1],12) + ":"	// "Hora do Retorno"
		@ nLi,PCol()+1	PSay PadR((cSUC)->UC_HRPEND,6)
		@ nLi,Limite/2	PSay PadR(aCampos[20][1],12) + ":" //"Estado"
		@ nLi,PCol()+1	PSay PadR(TkEntidade((cSUC)->UC_ENTIDAD,(cSUC)->UC_CHAVE,4),120)
						
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a observacao da liga‡ao                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aLinOb := U_TkMemo((cSUC)->UC_CODOBS, 200)
		nLinOb := Len(aLinOb)
		For nX := 1 TO nLinOb
			U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			If nX == 1
				@ nLi,000 PSay PadR(aCampos[21][1],12) + ":" //"Observacao do Atendimento"
			Endif
			@ nLi,14 PSay aLinOb[nX]
		Next nX
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime campos do encerramento.  				         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lEncer
		
			U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay PadR(aCampos[22][1],12)  + ":" //"Data do encerramento"
			@ nLi,PCol()+1	PSay PadR((cSUC)->UC_DTENCER,10)              
		   
			U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)		
			@ nLi,000		PSay PadR(aCampos[23][1],12)  + ":" //"Num. Dias Para Encerrar"
			@ nLi,PCol()+1	PSay IIF(!Empty((cSUC)->UC_DTENCER), STRZERO(((cSUC)->UC_DTENCER-(cSUC)->UC_DATA),4) ,0) Picture '@E 9999'
		
			U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			@ nLi,000		PSay PadR(aCampos[24][1],12)  + ":" // "Motivo do Encerramento"
			@ nLi,PCol()+1	PSay PadR(Posicione("SUN",1,xFilial("SUN")+(cSUC)->UC_CODENCE,"UN_DESC"),47)
			
			If !Empty((cSUC)->UC_CODMOT)
				aLinEnc := U_TkMemo((cSUC)->UC_CODMOT, 200)
				nLinEnc := Len(aLinEnc)
				For nX := 1 TO nLinEnc
					U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
					If nX == 1
						@ nLi,000 	PSay PadR(aCampos[25][1],12)  + ":" // "Descricao do Encerramento"
					Endif
					@ nLi, 14 PSay aLinEnc[nX]
				Next nX
			Endif
		Endif
		
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()

	// Cabecalho para o Televendas
	Case cRotina == "SUA"

        lProspect := (cSUA)->UA_PROSPEC
		
		U_TkIncLine(@nLi,nMax+1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[1][1],12) + ":" // "Data"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_EMISSAO,10)
		@ nLi,Limite/2	PSay PadR(aCampos[2][1],12) + ":" // "Contato"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_CODCONT,6) + " - " + PadR(TkDadosContato((cSUA)->UA_CODCONT,0),30)   

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[3][1],12) + ":" // "Atendimento"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_NUM,6)
		@ nLi,Limite/2	PSay PadR(aCampos[4][1],12) + ":" // "Fone Com.1"
		@ nLi,PCol()+1	PSay PadR(Transform( TkDadosContato((cSUA)->UA_CODCONT,8) + TkDadosContato((cSUA)->UA_CODCONT,4) , "@R (99)9999-9999"),13)

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[5][1],12) + ":"  // "Operador"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_OPERADO,6) + " - " + PadR(FATPDObfuscate(Posicione("SU7",1,xFilial("SU7") + SUA->UA_OPERADO,"U7_NOME"),"U7_NOME"),40)   
		@ nLi,Limite/2	PSay PadR(aCampos[6][1],12) + ":"	// "E-Mail"
		@ nLi,PCol()+1	PSay PadR(TkDadosContato((cSUA)->UA_CODCONT,10),40)

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[7][1],12) + ":"	// Vendedor"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_VEND,6) + " - " + PadR(FATPDObfuscate(Posicione("SA3",1,xFilial("SA3")+(cSUA)->UA_VEND,"A3_NOME"),"A3_NOME"),40)   		
		@ nLi,Limite/2	PSay PadR(aCampos[8][1],12) + ":"	// "Empresa"

		If Upper(FunName()) == "TMKR039"
			If !lProspect
				@ nLi,PCol()+1	PSay STR0051 + " - " + PadR((cSUA)->UA_CLIENTE,6) + " - " + PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_NOME"),"A1_NOME"),40)		//"PROSPECT"
			Else
				@ nLi,PCol()+1	PSay STR0050 + " - " + PadR((cSUA)->UA_CLIENTE,6) + " - " + PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_NOME"),"US_NOME"),40)		//"CLIENTE"
			EndIf
		Else
			If !lProspect
				@ nLi,PCol()+1	PSay PadR((cSUA)->UA_CLIENTE,6) + " - " + PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_NOME"),"A1_NOME"),40)
			Else
				@ nLi,PCol()+1	PSay PadR((cSUA)->UA_CLIENTE,6) + " - " + PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_NOME"),"US_NOME"),40)
			EndIf
		EndIf
		
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[9][1],12) + ":"	// "Midia"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_MIDIA,6) + " - " + PadR(Posicione("SUH",1,xFilial("SUH")+(cSUA)->UA_MIDIA,"UH_DESC"),55)   
		@ nLi,Limite/2	PSay PadR(aCampos[10][1],12) + ":"	// "Telefone"
		If !lProspect
			@ nLi,PCol()+1	PSay PadR(Transform(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_TEL"),"A1_TEL"),"@R 9999-9999"),15)
		Else
			@ nLi,PCol()+1	PSay PadR(Transform(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_TEL"),"US_TEL"),"@R 9999-9999"),15)
		EndIf

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[11][1],12) + ":"  // "Campanha"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_CODCAMP,6) + " - " + PadR(Posicione("SUO",1,xFilial("SUO")+(cSUA)->UA_CODCAMP,"UO_DESC"),40)   
		@ nLi,Limite/2	PSay PadR(aCampos[12][1],12) + ":"	// "Endereco"
		If !lProspect
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_END"),"A1_END"),40)		
		Else
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_END"),"US_END"),40)				
		EndIf

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[13][1],12) + ":"  //"Codigo da Ocorrencia"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_CODLIG,6) + " - " + PadR(Posicione("SU9",2,xFilial("SU9")+(cSUA)->UA_CODLIG,"U9_DESC"),30)   
		@ nLi,Limite/2	PSay PadR(aCampos[14][1],12) + ":"	// "Bairro"
		If !lProspect
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_BAIRRO"),"A1_BAIRRO"),30)
		Else
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_BAIRRO"),"US_BAIRRO"),30)		
		EndIf

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000	PSay PadR(aCampos[15][1],12) + ":"  // "Tabela"
		@ nLi,PCol()+1	PSay PadR((cSUA)->UA_TABELA,6)+ " - " + PadR(Posicione("DA0",1,xFilial("DA0") + (cSUA)->UA_TABELA,"DA0_DESCRI"),30)   
		@ nLi,Limite/2	PSay PadR(aCampos[16][1],12) + ":"	// "Municipio"
		If !lProspect
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_MUN"),"A1_MUN"),15)
		Else
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_MUN"),"US_MUN"),15)
		EndIf

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[17][1],12) + ":"  // "Operacao"
		@ nLi,PCol()+1	PSay PadR(IIF(Val((cSUA)->UA_OPER)>0,aUA_Oper[Val((cSUA)->UA_OPER)],""),80)
		@ nLi,Limite/2	PSay PadR(aCampos[18][1],12) + ":"	// "Estado"
		If !lProspect
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SA1",1,xFilial("SA1") + SUA->UA_CLIENTE + SUA->UA_LOJA,"A1_EST"),"A1_EST"),15)
		Else
			@ nLi,PCol()+1	PSay PadR(FATPDObfuscate(Posicione("SUS",1,xFilial("SUS") + SUA->UA_CLIENTE + SUA->UA_LOJA,"US_EST"),"US_EST"),15)
		EndIf

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[19][1],12) + ":"  // "Marketing"
		@ nLi,PCol()+1	PSay PadR(IIF(Val((cSUA)->UA_TMK)>0,aUA_TMK[Val((cSUA)->UA_TMK)],""),80)

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[20][1],12) + ":"  // "Tipo de Frete"
		@ nLi,PCol()+1	PSay PadR(IIF(!EMPTY((cSUA)->UA_TPFRETE),aUA_TpFrete[ IIF((cSUA)->UA_TPFRETE=="C",1,2) ],""),80)		

		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000		PSay PadR(aCampos[21][1],12) + ":"  //"Retorno"
		@ nLi,PCol()+1	PSay PadR(DtoC((cSUA)->UA_PROXLIG) + " - " +(cSUA)->UA_HRPEND,18)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a observacao da liga‡ao                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aLinOb := U_TkMemo((cSUA)->UA_CODOBS, 200)
		nLinOb := Len(aLinOb)
		For nX := 1 TO nLinOb
			U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
			If nX == 1
				@ nLi,000 PSay PadR(aCampos[15][1],12) + ":" //"Observacao do Atendimento"
			Endif
			@ nLi,14 PSay aLinOb[nX]
		Next nX
		
		U_TkIncLine(@nLi,1,nMax,titulo,cCabec1,cCabec2,nomeprog,tamanho)
		@ nLi,000 PSay __PrtThinLine()

	// Cabecalho para o Telecobranca	
	Case cRotina == ""
	
EndCase

FATPDUnload()
// Retorna a posicao da ultima linha impressa
Return(nLi)  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TkTitX3	ºAutor  ³ Vendas e CRM         º Data ³ 25/02/03  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna um array com a descricao de todos os campos de uma º±±
±±º			 ³ tabela especifica do X3.									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³aExp1      -Array com a descricao dos campos                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CALL CENTER / RELATORIOS                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function TkTitX3(aTitCampos)

Local aArea		:= GetArea()									// Salva a area atual
Local aDesc 	:= {}											// Array com a descricao dos campos
Local nCont		:= 0 											// Variavel de Controle
Local nTotal	:= IIF(aTitCampos <> NIL,Len(aTitCampos),0)		// Conta o numero de posicoes do Array 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Descricao do array aTitCampos³
//³                             ³
//³[Posicao] "Nome do Campo"    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If Len(aTitCampos) > 0
	DbSelectArea("SX3")
	DbSetOrder(2)			// Ordem de Campo
	
	For nCont:=1 TO nTotal
		If DbSeek(aTitCampos[nCont])
			AAdd(aDesc, { X3TITULO()})
		Endif
	Next nCont
Endif

RestArea(aArea)

Return (aDesc)

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