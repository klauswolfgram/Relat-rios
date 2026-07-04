/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR320.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR320"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR320   ³ Autor ³ Cleber Martinez       ³ Data ³ 25.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Chamados Tecnicos por Produto                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR320()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Nr.Chamado de  ?                                            ³
//³ MV_PAR02 : Nr.Chamado ate ?                                            ³
//³ MV_PAR03 : Emissao de     ?                                            ³
//³ MV_PAR04 : Emissao ate    ?                                            ³
//³ MV_PAR05 : Cliente de     ?                                            ³
//³ MV_PAR06 : Cliente ate    ?                                            ³
//³ MV_PAR07 : Produto de     ?                                            ³
//³ MV_PAR08 : Produto ate    ?                                            ³
//³ MV_PAR09 : Lista Quais    ? Aberto / Orcamento / OS / Todos / Outros   ³
//³ MV_PAR10 : Classificacao de ?                                          ³
//³ MV_PAR11 : Classificacao ate?                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("ATR320",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr320RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr320RptDef ºAutor  ³Cleber Martinez     º Data ³  25/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR320 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr320RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local nMinutos:= 0		// Variav. da celula Minutos
Local aOrdem  := {STR0005,STR0006,STR0007} //"Produto"###"Ocorrencia/Problema"###"Classificacao"
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
#ELSE 
	cAlias1	:= "AB2"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//"Chamados por Produto"  
//"   Este programa ira imprimir a Relacao de Chamados Tecnicos por Produto "
//"conforme os parametros solicitados." 
DEFINE REPORT oReport NAME "TECR320" TITLE STR0001 PARAMETER "ATR320" ACTION {|oReport| Tcr320PrtRpt(oReport, aOrdem, cAlias1)} DESCRIPTION STR0002 + STR0003 + STR0004
    oReport:SetDynamic()   
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0030 TABLES cAlias1,"SB1","AAG" ORDERS aOrdem	//"Produto"
		oSection1:SetLineBreak()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB2_CODPRO" 	OF oSection1 ALIAS cAlias1
		DEFINE CELL NAME "B1_DESC"		OF oSection1 ALIAS "SB1"
		DEFINE CELL NAME "AB2_CODPRB" 	OF oSection1 ALIAS cAlias1
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG"
		DEFINE CELL NAME "cClassific"	OF oSection1 ALIAS " "  SIZE 60 TITLE RetTitle("AB2_CLASSI") BLOCK {|| AB2_CLASSI + " - " + Tabela("A3",AB2_CLASSI) }
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0031 TABLES cAlias1,"AB1","AAG"	//"Chamados"
			oSection2:SetLineBreak()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
			DEFINE CELL NAME "AB2_NRCHAM" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_ITEM" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB1_EMISSA" 	OF oSection2 ALIAS "AB1"
			DEFINE CELL NAME "AB2_TIPO" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_CLASSI" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB1_CODCLI" 	OF oSection2 ALIAS "AB1"
			DEFINE CELL NAME "AB1_LOJA" 	OF oSection2 ALIAS "AB1"
			DEFINE CELL NAME "AB1_CONTAT" 	OF oSection2 ALIAS "AB1"
			DEFINE CELL NAME "nMinutos"		OF oSection2 ALIAS " " TITLE STR0028 PICTURE TM(nMinutos,5,0) //"Tempo(Min)"
			DEFINE CELL NAME "AB2_CODPRO" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_NUMSER" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_CODPRB" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AAG_DESCRI" 	OF oSection2 ALIAS "AAG" 
			DEFINE CELL NAME "AB2_NUMOS" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_NUMORC" 	OF oSection2 ALIAS cAlias1
			DEFINE CELL NAME "AB2_MEMO" 	OF oSection2 ALIAS cAlias1 SIZE 140 TITLE STR0029 BLOCK {|| MSMM((cAlias1)->AB2_MEMO) } //"Comentário da Ocorr/Problema"
			
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr320PrtRptºAutor  ³Cleber Martinez     º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem : Array com as ordens de impressao do relatorio     	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR320 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr320PrtRpt( oReport, aOrdem, cAlias1 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local lImp 		:= .F.								// Indica se imprimiu algum registro
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local aTotal    := { 0 , 0 , 0 , 0}  				// Array dos totalizadores
Local nMinutos  := 0                				// Variav. com o resultado dos minutos do atendimento
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio (cliente ou emissao)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local lQuebra	:= .F.								// Indica se ocorreu quebra 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura as secoes a imprimir e os indices conforme a Ordem selecionada  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case                 

	Case ( nOrdem == 1 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ PRODUTO     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB2_FILIAL,AB2_CODPRO,AB2_EMISSA %"
		cIndexKey:= "AB2_FILIAL+AB2_CODPRO+DTOS(AB2_EMISSA)"
	Case ( nOrdem == 2 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ OCORR/PROBLEMA ³	
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB2_FILIAL,AB2_CODPRB,AB2_EMISSA %"
		cIndexKey:= "AB2_FILIAL+AB2_CODPRB+DTOS(AB2_EMISSA)"
	Case ( nOrdem == 3 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ CLASSIFICACAO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB2_FILIAL,AB2_CLASSI,AB2_EMISSA %"
		cIndexKey:= "AB2_FILIAL+AB2_CLASSI+DTOS(AB2_EMISSA)"

EndCase
   
#IFDEF TOP
	DbSelectArea("AB2")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR320")
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB2_FILIAL,	AB2_NRCHAM,	AB2_ITEM,	AB2_TIPO,
				AB2_CLASSI,	AB2_CODPRO,	AB2_NUMSER,	AB2_CODPRB,
				AB2_NUMOS,	AB2_NUMORC, AB2_MEMO
		
		FROM %table:AB2% AB2
		WHERE	AB2_FILIAL = %xfilial:AB2%		AND
				AB2_NRCHAM >= %exp:mv_par01%	AND  
				AB2_NRCHAM <= %exp:mv_par02%	AND
				AB2_EMISSA >= %exp:DtoS(mv_par03)%	AND
				AB2_EMISSA <= %exp:DtoS(mv_par04)%	AND
				AB2_CODCLI >= %exp:mv_par05%	AND
				AB2_CODCLI <= %exp:mv_par06%	AND
				AB2_CODPRO >= %exp:mv_par07%	AND
				AB2_CODPRO <= %exp:mv_par08%	AND
				AB2_CLASSI >= %exp:mv_par10%	AND
				AB2_CLASSI <= %exp:mv_par11%	AND
				AB2.%notDel%

		ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1 
      
#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR320")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)
    
	cFiltro := "AB2_FILIAL=='"+xFilial("AB2")+"'.And."
	cFiltro += "AB2_NRCHAM>='"+MV_PAR01+"'.And."
	cFiltro += "AB2_NRCHAM<='"+MV_PAR02+"'.And."
	cFiltro += "DTOS(AB2_EMISSA)>='"+DTOS(MV_PAR03)+"'.And."
	cFiltro += "DTOS(AB2_EMISSA)<='"+DTOS(MV_PAR04)+"'.And."
	cFiltro += "AB2_CODCLI>='"+MV_PAR05+"'.And."
	cFiltro += "AB2_CODCLI<='"+MV_PAR06+"'.And."
	cFiltro += "AB2_CODPRO>='"+MV_PAR07+"'.And."
	cFiltro += "AB2_CODPRO<='"+MV_PAR08+"'.And."
	cFiltro += "AB2_CLASSI>='"+MV_PAR10+"'.And."
	cFiltro += "AB2_CLASSI<='"+MV_PAR11+"'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Efetua o filtro de acordo com a expressao do arquivo AB1 (Chamado Tecnico)	 						 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oSection1:SetFilter( cFiltro, cIndexKey )

#ENDIF	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(10) + "[ " + AllTrim(Upper(aOrdem[nOrdem])) + " ]" )

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
	
	If (	((cAlias1)->AB2_TIPO=="2" .AND. MV_PAR09 == 2) .OR.;
			((cAlias1)->AB2_TIPO=="3" .AND. MV_PAR09 == 3) .OR.;
			((cAlias1)->AB2_TIPO=="1" .AND. MV_PAR09 == 1) .OR.;
			(!(cAlias1)->AB2_TIPO$"123" .AND. MV_PAR09==5) .OR.;
			( MV_PAR09 == 4 ) )

	 	lImp := .T.

		Do Case
			Case ( nOrdem == 1 )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Quebra por Produto ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ( cQuebra != (cAlias1)->AB2_CODPRO)
					cQuebra := (cAlias1)->AB2_CODPRO
					lQuebra	:= .T.
					
					oSection1:Cell("AB2_CODPRB"):Disable()
					oSection1:Cell("AAG_DESCRI"):Disable()
					oSection1:Cell("cClassific"):Disable()
					
					TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + (cAlias1)->AB2_CODPRO })  
				EndIf
			Case ( nOrdem == 2 )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Quebra por Ocorrencia ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If ( cQuebra != (cAlias1)->AB2_CODPRB)
					cQuebra := (cAlias1)->AB2_CODPRB   
					lQuebra	:= .T.
					
					oSection1:Cell("AB2_CODPRO"):Disable()
					oSection1:Cell("B1_DESC"):Disable()
					oSection1:Cell("cClassific"):Disable()
					
					TRPosition():New(oSection1,"AAG",1,{|| xFilial("AAG") + (cAlias1)->AB2_CODPRB })  
				EndIf
			Case ( nOrdem == 3 )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Quebra por Classific. ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
				If ( cQuebra != (cAlias1)->AB2_CLASSI)
					cQuebra := (cAlias1)->AB2_CLASSI   
					lQuebra	:= .T.
					
					oSection1:Cell("AB2_CODPRO"):Disable()
					oSection1:Cell("B1_DESC"):Disable()
					oSection1:Cell("AB2_CODPRB"):Disable()
					oSection1:Cell("AAG_DESCRI"):Disable()
															
				EndIf
		EndCase

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao1 quando ocorrer a quebra  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lQuebra
			If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
				oSection1:Init()
			 	oSection1:PrintLine()
			 	oSection1:Finish()
			 	oSection2:Init()
		 	EndIf
		 	lQuebra	:= .F.
		EndIf
 			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona nas tabelas auxiliares ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		AB1->( dbSetOrder(1) )
		AB1->( MsSeek( xFilial("AB1") + (cAlias1)->AB2_NRCHAM ) )
		
		TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG") + (cAlias1)->AB2_CODPRB })  
		
		nMinutos := SubtHoras(AB1->AB1_EMISSA,AB1->AB1_HORA,AB1->AB1_EMISSA,AB1->AB1_HORAF)*60
	    
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza valor da celula Minutos ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    oSection2:Cell("nMinutos"):SetValue(nMinutos)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 2 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
			oSection2:PrintLine()
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Sub-Totais do Relatorio ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aTotal[1] ++
		aTotal[2] ++
		aTotal[3] += nMinutos
		aTotal[4] += nMinutos

	EndIf		
	DbSelectArea(cAlias1)
	(cAlias1)->(DbSkip())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a quebra e a impressao dos Subtotais ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	Do Case
		Case ( nOrdem == 1 )
			If ( cQuebra != (cAlias1)->AB2_CODPRO)

				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0016 + cQuebra, nLin  ) //"TOTAL DO PRODUTO: "
				If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
					oReport:PrintText( STR0017 + Str(aTotal[1],6,0), nLin, oSection2:Cell("AB2_CLASSI"):ColPos() ) //"NR.CHAMADOS:"
					oReport:PrintText( Str(aTotal[3],6,0), nLin, oSection2:Cell("nMinutos"):ColPos() ) 
					oReport:PrintText( STR0018 + Str(aTotal[3]/aTotal[1],8,2), nLin, oSection2:Cell("AB2_CODPRB"):ColPos() )	//"MEDIA:"
				EndIf
              oReport:SkipLine()

				aTotal[1] := aTotal[3] := 0			
				lQuebra := .T.
			EndIf			
		Case ( nOrdem == 2 )
			If ( cQuebra != (cAlias1)->AB2_CODPRB )
			                      
				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0019 + cQuebra, nLin  ) //"TOTAL DA OCORRENCIA/PROBLEMA: "
				oReport:PrintText( STR0020 + Str(aTotal[1],6,0), nLin, oSection2:Cell("AB2_CLASSI"):ColPos() ) //"NR.CHAMADOS:"
				oReport:PrintText( Str(aTotal[3],6,0), nLin, oSection2:Cell("nMinutos"):ColPos() ) 
				oReport:PrintText( STR0021 + Str(aTotal[3]/aTotal[1],8,2), nLin, oSection2:Cell("AB2_CODPRB"):ColPos() )	//"MEDIA:"
                oReport:SkipLine()

				aTotal[1] := aTotal[3] := 0
				lQuebra := .T.
			EndIf
		Case ( nOrdem == 3 )
			If ( cQuebra != (cAlias1)->AB2_CLASSI )
				
				oReport:SkipLine()   
				nLin := oReport:Row()
				oReport:PrintText( STR0022 + cQuebra, nLin ) //"TOTAL DA CLASSIFICACAO: "
				oReport:PrintText( STR0023 + Str(aTotal[1],6,0),nLin, oSection2:Cell("AB2_CLASSI"):ColPos() ) //"NR.CHAMADOS:"
				oReport:PrintText( Str(aTotal[3],6,0), nLin, oSection2:Cell("nMinutos"):ColPos() ) 
				oReport:PrintText( STR0024 + Str(aTotal[3]/aTotal[1],8,2), nLin, oSection2:Cell("AB2_CODPRB"):ColPos() ) //"MEDIA:"
                oReport:SkipLine()

				aTotal[1] := aTotal[3] := 0
				lQuebra := .T.
			EndIf
	EndCase
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Finaliza a impressao da secao2 quando ocorrer quebra ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lQuebra 
		oSection2:Finish()	
		lQuebra := .F.
	EndIf
	
End 	    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o totalizador final do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lImp )                                                              
	oReport:PrintText( STR0025,,oSection2:Cell("AB2_NRCHAM"):ColPos() ) //"TOTAL GERAL:"
	oReport:FatLine()
	//Guarda a linha atual
	nLin := oReport:Row()
	oReport:PrintText( STR0026, nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() )			//"NR.CHAMADOS:"
	If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
		oReport:PrintText( Str(aTotal[2],6,0), nLin, oSection2:Cell("AB2_TIPO"):ColPos() )
	EndIf	
	oReport:SkipLine()
	nLin := oReport:Row()
	If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
		oReport:PrintText( Upper(STR0028), nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() ) 	//"Tempo(Min)"
		oReport:PrintText( Str(aTotal[4],6,0), nLin, oSection2:Cell("AB2_TIPO"):ColPos() ) 	
	EndIf
	oReport:SkipLine()
	nLin := oReport:Row()	
	If !isBlind() .Or. IsInCallStack("FwBoschdexecute")
		oReport:PrintText( STR0027, nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() )			//"MEDIA:"
		oReport:PrintText( Str(aTotal[4]/aTotal[2],8,2), nLin, oSection2:Cell("AB2_TIPO"):ColPos() )
	EndIf
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

Return Tcr320RptDef()

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

Return Tcr320PrtRpt( oReport , {STR0005,STR0006,STR0007} , GetNextAlias() )

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
