/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR410.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR410"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR410   ³ Autor ³ Cleber Martinez       ³ Data ³ 04.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Orcamentos.                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³16/02/2007³Conrado Quilles³Bops 119542: Retirado função de ajuste.     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR410()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Nr.Orcamento de?                                            ³
//³ MV_PAR02 : Nr.Orcamento ate?                                           ³
//³ MV_PAR03 : Emissao de     ?                                            ³
//³ MV_PAR04 : Emissao ate    ?                                            ³
//³ MV_PAR05 : Cliente de     ?                                            ³
//³ MV_PAR06 : Cliente ate    ?                                            ³
//³ MV_PAR07 : Produto de     ?                                            ³
//³ MV_PAR08 : Produto ate    ?                                            ³
//³ MV_PAR09 : Lista Quais    ? Aberto / OS / Todos                        ³
//³ MV_PAR10 : Lista Apontamento(s)? Sim/Nao                               ³
//³ MV_PAR11 : Qual Moeda ?                      						   ³
//³ MV_PAR12 : Outras Moedas ? (Converter/Nao imprimir) 				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("ATR410",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr410RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr410RptDef ºAutor  ³Cleber Martinez     º Data ³  04/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR410 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr410RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local aOrdem  := {STR0005,STR0006,STR0007}  //"Numero"###"Cliente"###"Emissao"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR410" TITLE STR0001 PARAMETER "ATR410" ACTION {|oReport| Tcr410PrtRpt(oReport,aOrdem)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0024 TABLES "AB3","AB4","AAG" ORDERS aOrdem 	//Orcamento Tecnico
		oSection1:SetLineBreak()	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB4_NUMORC" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_ITEM" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_TIPO" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB3_CODCLI" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_LOJA" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_EMISSA" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB3_MOEDA" 	OF oSection1 ALIAS "AB3" BLOCK {|| Str(MV_PAR11,1) }
		DEFINE CELL NAME "AB3_CONPAG" 	OF oSection1 ALIAS "AB3"
		DEFINE CELL NAME "AB4_CODPRO" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_NUMSER" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_CODPRB" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "AB4_NUMOS" 	OF oSection1 ALIAS "AB4"
		DEFINE CELL NAME "AB4_MEMO" 	OF oSection1 ALIAS "AB4" SIZE 140 TITLE STR0020 BLOCK {|| AllTrim(MSMM(AB4->AB4_MEMO)) }	//"Ocorrencia"
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0025 TABLE "AB5","AB3"				//Itens Orçamento Tecnico
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
			DEFINE CELL NAME "AB5_ITEM" 	OF oSection2 ALIAS "AB5" PICTURE PesqPict("AB5","AB5_ITEM",2)
			DEFINE CELL NAME "AB5_CODPRO" 	OF oSection2 ALIAS "AB5"
			DEFINE CELL NAME "AB5_DESPRO" 	OF oSection2 ALIAS "AB5"
			DEFINE CELL NAME "AB5_CODSER" 	OF oSection2 ALIAS "AB5"
			DEFINE CELL NAME "AB5_QUANT" 	OF oSection2 ALIAS "AB5" PICTURE PesqPict("AB5","AB5_QUANT",14) HEADER ALIGN RIGHT
			DEFINE CELL NAME "AB5_VUNIT" 	OF oSection2 ALIAS "AB5" PICTURE PesqPict("AB5","AB5_VUNIT",14,MV_PAR11) HEADER ALIGN RIGHT
			DEFINE CELL NAME "nValCliente" 	OF oSection2 ALIAS " " TITLE STR0021 PICTURE PesqPict("AB5","AB5_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Cliente"
			DEFINE CELL NAME "nValFabric" 	OF oSection2 ALIAS " " TITLE STR0022 PICTURE PesqPict("AB5","AB5_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Fabricante"
			DEFINE CELL NAME "nValTotal"	OF oSection2 ALIAS " " TITLE STR0023 PICTURE PesqPict("AB5","AB5_TOTAL",14,MV_PAR11) HEADER ALIGN RIGHT //"Valor Total"
  			                                                      
	        oSection2:Cell("nValCliente"):GetFieldInfo("AB5_TOTAL")
	        oSection2:Cell("nValCliente"):SetTitle(STR0021)
	        oSection2:Cell("nValFabric"):GetFieldInfo("AB5_TOTAL")
	        oSection2:Cell("nValFabric"):SetTitle(STR0022)
	        oSection2:Cell("nValTotal"):GetFieldInfo("AB5_TOTAL")
	        oSection2:Cell("nValTotal"):SetTitle(STR0023)
	        
Return oReport
              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr410PrtRptºAutor  ³Cleber Martinez     º Data ³  07/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem: Array com as ordens de impressao disponiveis      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR410 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr410PrtRpt( oReport, aOrdem )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local lImp 		:= .F.								// Indica se imprimiu algum registro
Local cAlias1	:= ""								// Pega o proximo Alias Disponivel
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cWhere	:= ""								// expressao a adicionar no WHERE 
Local cSelect	:= ""								// Campos adicionais do Select
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local aValor    := { 0 ,0 ,0}						//Array dos valores a serem impressos
Local lImpAB4   := .F.								//Indica se imprime o item do AB4
Local aTotal    := {}								//Array com os totalizadores do Orcamento por Moeda
Local nLoop     := 0 								//Variav. usada em lacos For...Next
Local nPMoeda   := 0								//Posicao da moeda encontrada no array
Local nTMoeda   := 0								//Total de moedas
Local nAB5_TOTAL:= 0								//Conteudo do campo AB5_TOTAL
Local nDecs		:= Msdecimais(MV_PAR11)				//Nr. de casas decimais da moeda usada no relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE 
	cAlias1	:= "AB3"
#ENDIF

Do Case
	Case ( nOrdem == 1 )
		 // [ NR.ORCAMENTO ] 
		cOrderBy := "% AB3_FILIAL,AB3_NUMORC %"
		cIndexKey:= "AB3_FILIAL+AB3_NUMORC"
	Case ( nOrdem == 2 )
		// [ CLIENTE ] 
		cOrderBy := "% AB3_FILIAL,AB3_CODCLI,AB3_LOJA,AB3_NUMORC %"
		cIndexKey:= "AB3_FILIAL+AB3_CODCLI+AB3_LOJA+AB3_NUMORC"
	Case ( nOrdem == 3 )
		// [ EMISSAO ] 
		cOrderBy := "% AB3_FILIAL,AB3_EMISSA,AB3_CODCLI,AB3_LOJA,AB3_NUMORC %"
		cIndexKey:= "AB3_FILIAL+DTOS(AB3_EMISSA)+AB3_CODCLI+AB3_LOJA+AB3_NUMORC"
EndCase


#IFDEF TOP
	DbSelectArea("AB3")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR410")

	If MV_PAR12 == 2
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Nao imprimir orcamentos com moeda diferente da escolhida ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cWhere := "% AND AB3_MOEDA = '" + Str(mv_par11) + "' %"
	Else
		cWhere := "% %"
	EndIf
              
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Adiciona campos no SELECT ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	cSelect := "%, AB3_TXMOED %"

	    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB3_NUMORC,	AB3_EMISSA,	AB3_CODCLI,	
				AB3_LOJA,	AB3_MOEDA,	AB3_CONPAG	
				%exp:cSelect%
		
		FROM %table:AB3% AB3
		WHERE	AB3_FILIAL = %xfilial:AB3%		AND
				AB3_NUMORC >= %exp:mv_par01%	AND  
				AB3_NUMORC <= %exp:mv_par02%	AND
				AB3_EMISSA >= %exp:DtoS(mv_par03)%		AND
				AB3_EMISSA <= %exp:DtoS(mv_par04)%		AND
				AB3_CODCLI >= %exp:mv_par05%	AND
				AB3_CODCLI <= %exp:mv_par06%	AND
				AB3.%notDel%
				%exp:cWhere%

		ORDER BY %exp:cOrderBy%
				
	EndSql
	
	END REPORT QUERY oSection1 
      

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR410")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)
	
	cFiltro := "AB3_FILIAL=='"+xFilial("AB3")+"'.And."
	cFiltro += "AB3_NUMORC>='"+MV_PAR01+"'.And."
	cFiltro += "AB3_NUMORC<='"+MV_PAR02+"'.And."
	cFiltro += "DTOS(AB3_EMISSA)>='"+DTOS(MV_PAR03)+"'.And."
	cFiltro += "DTOS(AB3_EMISSA)<='"+DTOS(MV_PAR04)+"'.And."
	cFiltro += "AB3_CODCLI>='"+MV_PAR05+"'.And."
	cFiltro += "AB3_CODCLI<='"+MV_PAR06+"'"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Nao imprimir orcamentos com moeda diferente da escolhida ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR12 == 2
		cFiltro += " .And. AB3_MOEDA==" + Alltrim(Str(MV_PAR11))
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao do arquivo AB3 (Orcamentos Tecnicos) 						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cIndexKey )

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(05) + "[ " + AllTrim(Upper(aOrdem[nOrdem])) + " ]" + " - " + SuperGetMv("MV_MOEDA" + Str(MV_PAR11,1)))

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
    
 	lImp	:= .T.
  	lImpAb4 := .F.

	Do Case
		Case ( nOrdem == 2 )
			If ( cQuebra <> (cAlias1)->AB3_CODCLI)
				cQuebra := (cAlias1)->AB3_CODCLI
				SA1->(dbSetOrder(1))
				SA1->(MsSeek(xFilial("SA1")+(cAlias1)->AB3_CODCLI+(cAlias1)->AB3_LOJA))
				oReport:SkipLine()
				oReport:PrintText( RetTitle("AB3_CODCLI")+": "+SA1->A1_NOME )
				oReport:SkipLine()
			EndIf
		Case ( nOrdem == 3 )
			cQuebra := (cAlias1)->AB3_EMISSA
	EndCase
	
	dbSelectArea("AB4")
	dbSetOrder(1)
	MsSeek(xFilial("AB4")+ (cAlias1)->AB3_NUMORC)
	While ( !Eof() .AND. xFilial("AB4") == AB4->AB4_FILIAL .AND.;
			(cAlias1)->AB3_NUMORC== AB4->AB4_NUMORC )
		
		If (  AB4->AB4_CODPRO >= MV_PAR07 .AND.;
				AB4->AB4_CODPRO <= MV_PAR08 .AND.;
				( (!Empty(AB4->AB4_NUMOS ) .AND. MV_PAR09 == 2) .OR.;
				( Empty(AB4->AB4_NUMOS ) .AND. MV_PAR09 == 1 .AND. AB4->AB4_TIPO == "1" ) .OR.;
				( MV_PAR09 == 3 )) )
			
			TRPosition():New(oSection1,"AAG",1,{|| xFilial("AAG") + AB4->AB4_CODPRB })

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Imprime a secao 1 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			
			If !isBlind()
				oSection1:Init()
				oSection1:PrintLine()
			EndIf
			If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?
				oSection2:Init()
			EndIf
			
			dbSelectArea("AB5")
			dbSetOrder(1)
			MsSeek(xFilial("AB5")+AB4->AB4_NUMORC+AB4->AB4_ITEM)
			While ( !Eof() .AND. xFilial("AB5")  == AB5->AB5_FILIAL .AND.;
									AB4->AB4_NUMORC == AB5->AB5_NUMORC .AND.;
									AB4->AB4_ITEM   == AB5->AB5_ITEM )
				If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?
					lImpAb4 := .T.
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Converte os valores para a moeda selecionada ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ					
					nAB5_VUNIT:= Round(xMoeda(AB5->AB5_VUNIT, (cAlias1)->AB3_MOEDA, MV_PAR11, (cAlias1)->AB3_EMISSA, nDecs+1, (cAlias1)->AB3_TXMOED), nDecs)
					nAB5_TOTAL:= Round(xMoeda(AB5->AB5_TOTAL, (cAlias1)->AB3_MOEDA, MV_PAR11, (cAlias1)->AB3_EMISSA, nDecs+1, (cAlias1)->AB3_TXMOED), nDecs)
					
					aValor[1] := AtVlrPagto(AB5->AB5_CODSER, nAB5_TOTAL, "C")
					aValor[2] := AtVlrPagto(AB5->AB5_CODSER, nAB5_TOTAL, "F")
					aValor[3] := nAB5_TOTAL
                    
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Atribui os valores p/ as celulas da secao 2 ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			        oSection2:Cell("AB5_VUNIT"):SetValue(nAB5_VUNIT)
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
				dbSelectArea("AB5")
				dbSkip()
			End
			If ( MV_PAR10 == 1 ) //Imprime Apontamento(s)?
				oSection2:Finish()
			EndIf
			oSection1:Finish()
		EndIf
		dbSelectArea("AB4")
		dbSkip()
	End
	dbSelectArea(cAlias1)
	(cAlias1)->(dbSkip())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os Subtotais ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case ( nOrdem == 1 .AND. MV_PAR10 == 1 )
			For nTMoeda := 1 To Len(aTotal)
				If ( lImpAb4 .AND. aTotal[nTMoeda,2,3]>0 )

					oReport:SkipLine()
					nLin := oReport:Row()
					oReport:PrintText( STR0016, nLin  ) //"TOTAL ORCAMENTO"
					If !isBlind()
						oReport:PrintText( aTotal[nTMoeda,1], nLin, oSection1:Cell("AB3_MOEDA"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,1], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,2], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,3], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
					EndIf
	                oReport:SkipLine()

					aTotal[nTMoeda,2,1] := 0
					aTotal[nTMoeda,2,2] := 0
					aTotal[nTMoeda,2,3] := 0
				EndIf
			Next nTMoeda
		Case ( nOrdem == 2 )
			If ( cQuebra <> (cAlias1)->AB3_CODCLI )
				For nTMoeda := 1 To Len(aTotal)
					If ( lImpAb4 .AND. aTotal[nTMoeda,2,3]>0 )
					
						oReport:SkipLine()
						nLin := oReport:Row()					
						oReport:PrintText( STR0017, nLin  ) //"TOTAL CLIENTE "
						oReport:PrintText( aTotal[nTMoeda,1], nLin, oSection1:Cell("AB3_MOEDA"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,1], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,2], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,3], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
		                oReport:SkipLine()															
					
						aTotal[nTMoeda,2,1] := 0
						aTotal[nTMoeda,2,2] := 0
						aTotal[nTMoeda,2,3] := 0
					EndIf
				Next nTMoeda
			EndIf
		Case ( nOrdem == 3 )
			If ( cQuebra <> (cAlias1)->AB3_EMISSA )
				For nTMoeda := 1 To Len(aTotal)
					If ( lImpAb4 .AND. aTotal[nTMoeda,2,3]>0 )

						oReport:SkipLine()
						nLin := oReport:Row()					
						oReport:PrintText( STR0018 + DTOC(cQuebra), nLin  ) // "TOTAL DE "
						oReport:PrintText( aTotal[nTMoeda,1], nLin, oSection1:Cell("AB3_MOEDA"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,1], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,2], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
						oReport:PrintText( Transform(aTotal[nTMoeda,2,3], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
		                oReport:SkipLine()
		                
						aTotal[nTMoeda,2,1] := 0
						aTotal[nTMoeda,2,2] := 0
						aTotal[nTMoeda,2,3] := 0
					EndIf
				Next nTMoeda
			EndIf
	EndCase
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o totalizador do final do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lImp )
	For nTMoeda := 1 To Len(aTotal)
		
		oReport:SkipLine()
		nLin := oReport:Row()
		oReport:PrintText(STR0019, nLin)	//"TOTAL GERAL"
		If !isBlind()
			oReport:PrintText( aTotal[nTMoeda,1], nLin, oSection1:Cell("AB3_MOEDA"):ColPos() )
			oReport:PrintText( Transform(aTotal[nTMoeda,2,4], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValCliente"):ColPos() )
			oReport:PrintText( Transform(aTotal[nTMoeda,2,5], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValFabric"):ColPos() )
			oReport:PrintText( Transform(aTotal[nTMoeda,2,6], PesqPict("AB5","AB5_TOTAL",14,MV_PAR11)), nLin, oSection2:Cell("nValTotal"):ColPos() )
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

Return Tcr410RptDef()

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

Return Tcr410PrtRpt( oReport , {STR0005,STR0006,STR0007} )

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