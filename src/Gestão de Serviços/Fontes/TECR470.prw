/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR470.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR470"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR470   ³ Autor ³ Eduardo Riera         ³ Data ³ 07.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Ordem de Servico por Produto                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³29/05/2006³Cleber Martinez³Bops 98346: Localizacao do modulo SIGATEC.  ³±±
±±³15/08/2006³Cleber Martinez³Bops 99266: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±³22/09/2006³Tatiana        ³Bops 107209:Inserido tratamento de para DB2 ³±±
±±³          ³               ³na concatenacao de campos para R4           ³±±
±±³16/02/2007³Conrado Quilles³Bops 119542: Retirado ajuste no SX1.        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR470()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Nr.OS de       ?                                            ³
//³ MV_PAR02 : Nr.OS Ate      ?                                            ³
//³ MV_PAR03 : Emissao de     ?                                            ³
//³ MV_PAR04 : Emissao ate    ?                                            ³
//³ MV_PAR05 : Cliente de     ?                                            ³
//³ MV_PAR06 : Cliente ate    ?                                            ³
//³ MV_PAR07 : Produto de     ?                                            ³
//³ MV_PAR08 : Produto ate    ?                                            ³
//³ MV_PAR09 : Lista Quais    ? Aberto / Pedido / Todas                    ³
//³ MV_PAR10 : Lista Apontamento(s)? Sim/Nao                               ³
//³ MV_PAR11 : Qual Moeda ?                      						   ³
//³ MV_PAR12 : Outras Moedas ? (Converter/Nao imprimir) 				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("ATR470",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr470RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr470RptDef ºAutor  ³Cleber Martinez     º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR470 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr470RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local aOrdem	:=	{STR0005,STR0006}  //"Produto"###"Ocorrencia/Problema"
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE 
	cAlias1	:= "AB7"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR470" TITLE STR0001 PARAMETER "ATR470" ACTION {|oReport| Tcr470PrtRpt(oReport, aOrdem, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0021 TABLES "AB7","AB6","AAG" ORDERS aOrdem // "Itens da ordem de serviço"
		oSection1:SetLineBreak()	                        
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB7_NUMOS" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_ITEM" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_TIPO" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB6_CODCLI" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_LOJA" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_EMISSA" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB6_CONPAG" 	OF oSection1 ALIAS "AB6"
		DEFINE CELL NAME "AB7_CODPRO" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_NUMSER" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_CODPRB" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "AB6_MOEDA" 	OF oSection1 ALIAS "AB6" BLOCK {|| Str(MV_PAR11,1) }		
		DEFINE CELL NAME "AB7_MEMO1" 	OF oSection1 ALIAS "AB7" LINE BREAK SIZE 140 TITLE STR0017 BLOCK {||MSMM((cAlias1)->AB7_MEMO1)}//"Ocorrencia"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0022 TABLE "AB8","AB6" // "Sub-itens da ordem de servico"
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
			DEFINE CELL NAME "AB8_ITEM" 	OF oSection2 ALIAS "AB8" PICTURE PesqPict("AB8","AB8_ITEM",2)
			DEFINE CELL NAME "AB8_CODPRO" 	OF oSection2 ALIAS "AB8"
			DEFINE CELL NAME "AB8_DESPRO" 	OF oSection2 ALIAS "AB8"
			DEFINE CELL NAME "AB8_CODSER" 	OF oSection2 ALIAS "AB8"
			DEFINE CELL NAME "AB8_QUANT" 	OF oSection2 ALIAS "AB8" PICTURE PesqPict("AB8","AB8_QUANT",14) HEADER ALIGN RIGHT
			DEFINE CELL NAME "AB8_VUNIT" 	OF oSection2 ALIAS "AB8" PICTURE PesqPict("AB8","AB8_VUNIT",14,MV_PAR11) HEADER ALIGN RIGHT
			DEFINE CELL NAME "nValCliente" 	OF oSection2 ALIAS " " TITLE STR0018 PICTURE PesqPict("AB8","AB8_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Cliente"
			DEFINE CELL NAME "nValFabric" 	OF oSection2 ALIAS " " TITLE STR0019 PICTURE PesqPict("AB8","AB8_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Fabricante"
			DEFINE CELL NAME "nValTotal"	OF oSection2 ALIAS " " TITLE STR0020 PICTURE PesqPict("AB8","AB8_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Total"
			DEFINE CELL NAME "AB8_DTGAR" 	OF oSection2 ALIAS "AB8"

			oSection2:Cell("nValCliente"):GetFieldInfo("AB8_TOTAL")
			oSection2:Cell("nValCliente"):SetTitle(STR0018)
			oSection2:Cell("nValFabric"):GetFieldInfo("AB8_TOTAL")
			oSection2:Cell("nValFabric"):SetTitle(STR0019)
			oSection2:Cell("nValTotal"):GetFieldInfo("AB8_TOTAL")
			oSection2:Cell("nValTotal"):SetTitle(STR0020)
			
Return oReport
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr470PrtRptºAutor  ³Cleber Martinez     º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem:  Array com as ordens de impressao disponiveis      	º±±
±±º          ³cAlias1: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR470 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr470PrtRpt( oReport, aOrdem, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local lImp 		:= .F.								// Indica se imprimiu algum registro
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cWhere	:= ""								// expressao a adicionar no WHERE 
Local cSelect	:= ""								// Campos adicionais do Select
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local lImpAb7   := .F.								// Indica se imprime o item do AB7
Local aValor    := { 0 ,0 ,0}						// Array dos valores a serem impressos
Local aTotal    := {}								// Array com os totalizadores do Orcamento por Moeda
Local nLoop     := 0 								// Variavel usada em lacos For...Next
Local nPMoeda   := 0								// Posicao da moeda encontrada no array
Local nTMoeda   := 0								// Total de moedas
Local nAB8_TOTAL:= 0								// Conteudo do campo AB8_TOTAL
Local nDecs		:= Msdecimais(MV_PAR11)				// Nr. de casas decimais da moeda usada no relatorio
Local cDbMs		:= ""								//Nome do BD              
       
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

#IFDEF TOP
	cDbMs	:= UPPER(TcGetDb())  //define o tipo de banco para diferenciar o operador de soma


Do Case
	Case ( nOrdem == 1 )
		// [ PRODUTO ]
		If cDbMs $ "MSSQL"
		cOrderBy := "% AB7_FILIAL,AB7_CODPRO+AB7_EMISSA %"
	Else
		cOrderBy := "% AB7_FILIAL,AB7_CODPRO||AB7_EMISSA %"
	EndIf		

		cIndexKey:= "AB7_FILIAL+AB7_CODPRO+DTOS(AB7_EMISSA)"
	
	Case ( nOrdem == 2 )
		// [ OCORRENCIA/PROBLEMA ]
		cOrderBy := "% AB7_FILIAL,AB7_CODPRB,AB7_EMISSA %"
		cIndexKey:= "AB7_FILIAL+AB7_CODPRB+DTOS(AB7_EMISSA)"
EndCase

#ENDIF
#IFDEF TOP
	DbSelectArea("AB7") 
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR470")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB7_NUMOS,	AB7_ITEM,	AB7_TIPO,
				AB7_CODPRO,	AB7_NUMSER,	AB7_CODPRB,
				AB7_MEMO1,	AB7_FILIAL
		
		FROM %table:AB7% AB7
		WHERE	AB7_FILIAL = %xfilial:AB7%		AND
				AB7_NUMOS >= %exp:mv_par01%		AND  
				AB7_NUMOS <= %exp:mv_par02%		AND
				AB7_EMISSA >= %exp:DtoS(mv_par03)%		AND
				AB7_EMISSA <= %exp:DtoS(mv_par04)%		AND
				AB7_CODCLI >= %exp:mv_par05%	AND
				AB7_CODCLI <= %exp:mv_par06%	AND
				AB7_CODPRO >= %exp:mv_par07%	AND
				AB7_CODPRO <= %exp:mv_par08%	AND
				AB7.%notDel%

		ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1 

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR470")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)

	cFiltro := "AB7_FILIAL=='"+xFilial("AB7")+"'.AND."
	cFiltro += "AB7_NUMOS>='"+MV_PAR01+"'.AND."
	cFiltro += "AB7_NUMOS<='"+MV_PAR02+"'.AND."
	cFiltro += "DTOS(AB7_EMISSA)>='"+DTOS(MV_PAR03)+"'.AND."
	cFiltro += "DTOS(AB7_EMISSA)<='"+DTOS(MV_PAR04)+"'.AND."
	cFiltro += "AB7_CODPRO>='"+MV_PAR07+"'.AND."
	cFiltro += "AB7_CODPRO<='"+MV_PAR08+"'.AND."
	cFiltro += "AB7_CODCLI>='"+MV_PAR05+"'.AND."
	cFiltro += "AB7_CODCLI<='"+MV_PAR06+"'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AB7 (Itens da OS) 								 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cIndexKey )

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(05) + "[ " + AllTrim(Upper(aOrdem[nOrdem])) + " ]" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)

While !oReport:Cancel() .AND. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	lImpAb7 := .F.

	Do Case
		Case ( nOrdem == 1 )
  			cQuebra := (cAlias1)->AB7_CODPRO
		Case ( nOrdem == 2 )
			cQuebra := (cAlias1)->AB7_CODPRB
	EndCase

	dbSelectArea("AB6")
	dbSetOrder(1)
	MsSeek(xFilial("AB6")+(cAlias1)->AB7_NUMOS)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se imprime outras moedas ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR12 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao imprimir Ord. Serv. com moeda diferente da escolhida ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (AB6->AB6_MOEDA <> 0) .AND. (AB6->AB6_MOEDA <> MV_PAR11)
			(cAlias1)->( dbSkip() )
			Loop
		EndIf
	EndIf
		
	dbSelectArea("AAG")
	dbSetOrder(1)
	MsSeek(xFilial("AAG")+(cAlias1)->AB7_CODPRB)
	
	If (  ((cAlias1)->AB7_TIPO=="2" .AND. MV_PAR09 == 2) .OR.;
			((cAlias1)->AB7_TIPO=="1" .AND. MV_PAR09 == 1) .OR.;
			(!(cAlias1)->AB7_TIPO$"12" .AND. MV_PAR09 == 4) .OR.;
			( MV_PAR09 == 3 ) )

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 1 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !isBlind()		
			oSection1:Init()
			oSection1:PrintLine()
		EndIf
		lImpAb7 := .T.
		lImp := .T.
		  
		If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?
			oSection2:Init()
		EndIf			
					  
		dbSelectArea("AB8")
		dbSetOrder(1)
		MsSeek(xFilial("AB8")+(cAlias1)->AB7_NUMOS+(cAlias1)->AB7_ITEM)
		While ( !Eof() .AND. xFilial("AB7")  == (cAlias1)->AB7_FILIAL .AND.;
								(cAlias1)->AB7_NUMOS == AB8->AB8_NUMOS .AND.;
								(cAlias1)->AB7_ITEM   == AB8->AB8_ITEM )
			
			If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?

				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Converte os valores para a moeda selecionada ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
				nAB8_TOTAL:= Round(xMoeda(AB8->AB8_TOTAL, AB6->AB6_MOEDA, MV_PAR11, AB6->AB6_EMISSA, nDecs+1, AB6->AB6_TXMOED), nDecs)
				nAB8_VUNIT:= Round(xMoeda(AB8->AB8_VUNIT, AB6->AB6_MOEDA, MV_PAR11, AB6->AB6_EMISSA, nDecs+1, AB6->AB6_TXMOED), nDecs)

				aValor[1] := AtVlrPagto(AB8->AB8_CODSER, nAB8_TOTAL, "C")
				aValor[2] := AtVlrPagto(AB8->AB8_CODSER, nAB8_TOTAL, "F")
				aValor[3] := nAB8_TOTAL
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Atribui os valores p/ as celulas da secao 2 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		        oSection2:Cell("AB8_VUNIT"):SetValue(nAB8_VUNIT)
		        oSection2:Cell("nValCliente"):SetValue(aValor[1])
		        oSection2:Cell("nValFabric"):SetValue(aValor[2])
		        oSection2:Cell("nValTotal"):SetValue(aValor[3])
		        
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime a secao 2 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !isBlind()
					oSection2:PrintLine()
				EndIf
			EndIf 
            
			If Empty(nPMoeda:=aScan(aTotal,{|x|x[1]==Str(MV_PAR11,1)}))
				aAdd(aTotal,{Str(MV_PAR11,1),{aValor[1],aValor[2],aValor[3],aValor[1],aValor[2],aValor[3]}})
			Else
				aTotal[nPMoeda,2,1] += aValor[1]
				aTotal[nPMoeda,2,2] += aValor[2]
				aTotal[nPMoeda,2,3] += aValor[3]
				aTotal[nPMoeda,2,4] += aValor[1]
				aTotal[nPMoeda,2,5] += aValor[2]
				aTotal[nPMoeda,2,6] += aValor[3]
			EndIf
			aSort(aTotal,,,{|x,y|y[1]>x[1]})
			dbSelectArea("AB8")
			dbSkip()
		End
		If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?
			oSection2:Finish()
		EndIf
		oSection1:Finish()			
	EndIf
	dbSelectArea(cAlias1)
	dbSkip()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os Subtotais ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	Do Case
		Case ( nOrdem == 1 )
			If ( cQuebra != (cAlias1)->AB7_CODPRO )
				For nTMoeda := 1 To Len(aTotal)
					If ( lImpAB7 .AND. aTotal[nTMoeda,2,3]>0 )			
						dbSelectArea("SB1")
						dbSetOrder(1)
						MsSeek(xFilial("SB1")+cQuebra)
						
						oReport:SkipLine()
						nLin := oReport:Row()
						oReport:PrintText( STR0014+cQuebra+" "+Alltrim(SB1->B1_DESC), nLin  ) //"TOTAL DO PRODUTO: "
						If !isBlind()
							oReport:PrintText( Transform(aTotal[nTMoeda,2,1], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
							oReport:PrintText( Transform(aTotal[nTMoeda,2,2], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
							oReport:PrintText( Transform(aTotal[nTMoeda,2,3], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
						EndIf
		                oReport:SkipLine()					
						
						aTotal[nTMoeda,2,1] := 0
						aTotal[nTMoeda,2,2] := 0
						aTotal[nTMoeda,2,3] := 0
					EndIf
				Next nTMoeda
			EndIf
		Case ( nOrdem == 2 )
			If ( cQuebra != (cAlias1)->AB7_CODPRB )
				For nTMoeda := 1 To Len(aTotal)
					If ( lImpAB7 .AND. aTotal[nTMoeda,2,3]>0 )			
						dbSelectArea("AAG")
						dbSetOrder(1)
						MsSeek(xFilial("AAG")+cQuebra)

						oReport:SkipLine()
						nLin := oReport:Row()
						oReport:PrintText( STR0015+" "+cQuebra+" "+AAG->AAG_DESCRI, nLin  ) //"TOTAL DA OCORRENCIA/PROBLEMA: "
						oReport:PrintText( Transform(aTotal[nTMoeda,2,1], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,2], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,3], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
		                oReport:SkipLine()					
						
						aTotal[nTMoeda,2,1] := 0
						aTotal[nTMoeda,2,2] := 0
						aTotal[nTMoeda,2,3] := 0
					EndIf
				Next nTMoeda
			EndIf
	EndCase
	dbSelectArea(cAlias1)
End 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o totalizador do final do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lImp )
	For nTMoeda := 1 To Len(aTotal)

		oReport:SkipLine()
		nLin := oReport:Row()
		oReport:PrintText( STR0016, nLin )	//"TOTAL GERAL"
		If !isBlind()
			oReport:PrintText( Transform(aTotal[nTMoeda,2,4], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
			oReport:PrintText( Transform(aTotal[nTMoeda,2,5], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
			oReport:PrintText( Transform(aTotal[nTMoeda,2,6], PesqPict("AB8","AB8_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
		EndIf
		oReport:SkipLine()
	
	Next nTMoeda
EndIf

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

Return Tcr470RptDef()

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

Return Tcr470PrtRpt( oReport , {STR0005,STR0006} , GetNextAlias())

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