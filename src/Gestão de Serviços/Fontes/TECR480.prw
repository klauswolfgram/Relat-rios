/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR480.CH"
#INCLUDE "REPORT.CH"

#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR480"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR480   ³ Autor ³ Eduardo Riera         ³ Data ³ 07.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Relacao de Servicos 						                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³17/08/2006³Cleber M.      ³Bops 99267: Conversao para relatorio perso- ³±±
±±³          ³               ³nalizavel (Release 4).                      ³±±
±±³16/02/2007³Conrado Quilles³Bops 119542: Retirado ajuste no SX1.        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TECR480()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Nr.OS de       ?                                            ³
//³ MV_PAR02 : Nr.OS Ate      ?                                            ³
//³ MV_PAR03 : Data Inicio de ?                                            ³
//³ MV_PAR04 : Data Inicio Ate?                                            ³
//³ MV_PAR05 : Cliente de     ?                                            ³
//³ MV_PAR06 : Cliente ate    ?                                            ³
//³ MV_PAR07 : Tecnico de     ?                                            ³
//³ MV_PAR08 : Tecnico Ate    ?                                            ³
//³ MV_PAR09 : Produto de     ?                                            ³
//³ MV_PAR10 : Produto ate    ?                                            ³
//³ MV_PAR11 : Lista Quais    ? Atendido / Em Atendimento / Ambos          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("ATR480",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := Tcr480RptDef()
oReport:PrintDialog()

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr480RptDef ºAutor  ³Cleber Martinez     º Data ³  17/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR480 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr480RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local aOrdem	:=	{STR0005,STR0006,STR0007,STR0008}  //"OS"###"Tecnico"###"Cliente"###"Problema"
Local aOrdem2	:=	{STR0033,STR0034} //Material ## Descrição
Local cAlias1	:= ""	// Pega o proximo Alias Disponivel
Local cAlias2	:= ""	// Pega o proximo Alias Disponivel

#IFDEF TOP
	cAlias1	:= GetNextAlias()
	cAlias2	:= GetNextAlias()
#ELSE 
	cAlias1	:= "AB9"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DEFINE REPORT oReport NAME "TECR480" TITLE STR0001 PARAMETER "ATR480" ACTION {|oReport| Tcr480PrtRpt(oReport, aOrdem, cAlias1, cAlias2)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0032 TABLES "AB9","AB6","AB7","AAG" ORDERS aOrdem // "Serviços técnicos"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB7_NUMOS" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB7_ITEM" 	OF oSection1 ALIAS "AB7"
		DEFINE CELL NAME "AB9_SEQ" 		OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_CODTEC" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_CODCLI" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_CODPRO" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_DTCHEG" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_HRCHEG" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_DTINI" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_HRINI" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_DTFIM" 	OF oSection1 ALIAS "AB9"
		DEFINE CELL NAME "AB9_HRFIM" 	OF oSection1 ALIAS "AB9" 
		DEFINE CELL NAME "AB9_DTSAID" 	OF oSection1 ALIAS "AB9" 
		DEFINE CELL NAME "AB9_HRSAID" 	OF oSection1 ALIAS "AB9" 
		DEFINE CELL NAME "AB9_TRASLA" 	OF oSection1 ALIAS "AB9" ALIGN RIGHT
		DEFINE CELL NAME "nHrTotal2" 	OF oSection1 ALIAS " "  TITLE STR0030 ALIGN RIGHT //"Total Horas"
		DEFINE CELL NAME "AB9_CODPRB" 	OF oSection1 ALIAS "AB9" 
		DEFINE CELL NAME "AAG_DESCRI" 	OF oSection1 ALIAS "AAG" 
		DEFINE CELL NAME "AB9_TIPO" 	OF oSection1 ALIAS "AB9" 
		DEFINE CELL NAME "AB9_MEMO1" 	OF oSection1 ALIAS "AB9" LINE BREAK SIZE 170 TITLE STR0031 BLOCK {|| AllTrim(MSMM((cAlias1)->AB9_MEMO1)) }	//"Laudo"

		oSection1:SetLineBreak()	                    
		oSection1:SetHeaderPage(.T.)

		DEFINE SECTION oSection2 OF oSection1 TITLE STR0035 TABLES "ABA","SB1" ORDERS aOrdem2 //'Itens de Apontamento'
		DEFINE CELL NAME "ABA_CODPRO" 	OF oSection2 ALIAS "ABA"
		DEFINE CELL NAME "B1_DESC" 	OF oSection2 BLOCK {|| Posicione("SB1", 1, xFilial("SB1")+oSection2:Cell("ABA_CODPRO"):GetValue(.T.), "B1_DESC")}
		oSection2:SetLineBreak()	                    
		oSection2:SetHeaderPage(.T.)
				
Return oReport
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr480PrtRptºAutor  ³Cleber Martinez     º Data ³  15/08/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±º          ³aOrdem:  Array com as ordens de impressao disponiveis      	º±±
±±º          ³cAlias1: Alias principal do relatorio                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR480 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr480PrtRpt( oReport, aOrdem, cAlias1, cAlias2)
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)	
Local lImp    	:= .F. 								// Indica se algo foi impresso
Local lImpAb9   := .F. 								// Indica se algo foi impresso
Local nHrTotal1 := 0								// Total de horas de traslado
Local nHrTotal2 := 0								// Total de horas da chegada ate a saida
Local nHrTotal3 := 0								// Total de horas do inicio ate o termino do servico
Local aTotal    := { 0 , 0 , 0 , 0 , 0 , 0}			// Array com os totalizadores
Local nLoop     := 0 								// Usada em For...Next
Local aTotOcor  := {}								// Array com totalizador por Ocorrencia
Local nPosOcor  := 0 								// Posicao da Ocorrencia no array
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio
Local cFiltro	:= ""								// Filtro da tabela (CodeBase)
Local nLin 		:= 0								// Guarda a linha atual impressa
Local cHoraForm := ""                               // Guarda a hora formatada

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

Do Case
	Case ( nOrdem == 1 ) 
		// [ ORDEM DE SERVICO ] 
		cOrderBy := "% AB9_FILIAL,AB9_NUMOS,AB9_SEQ,AB9_DTINI %"
		cIndexKey := "AB9_FILIAL+AB9_NUMOS+AB9_SEQ+DTOS(AB9_DTINI)"
	Case ( nOrdem == 2 )
		// [ TECNICO ] 
		cOrderBy := "% AB9_FILIAL,AB9_CODTEC,AB9_DTINI %"
		cIndexKey := "AB9_FILIAL+AB9_CODTEC+DTOS(AB9_DTINI)"
	Case ( nOrdem == 3 ) 
		// [ CLIENTE ]   
		cOrderBy := "% AB9_FILIAL,AB9_CODCLI,AB9_DTINI %"
		cIndexKey := "AB9_FILIAL+AB9_CODCLI+DTOS(AB9_DTINI)"
	Case ( nOrdem == 4 ) 
		// [ OCORRENCIA ] 
		cOrderBy := "% AB9_FILIAL,AB9_CODPRB,AB9_DTINI %"
		cIndexKey := "AB9_FILIAL+AB9_CODPRB+DTOS(AB9_DTINI)"
EndCase

#IFDEF TOP
	DbSelectArea("AB9") 
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR480")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB9_FILIAL,	AB9_SEQ,	AB9_CODTEC, AB9_CODCLI,
				AB9_CODPRO,	AB9_DTCHEG,	AB9_HRCHEG, AB9_DTINI,
				AB9_HRINI,	AB9_DTFIM,	AB9_HRFIM,	AB9_DTSAID,
				AB9_HRSAID,	AB9_TRASLA,	AB9_CODPRB,	AB9_MEMO1,
				AB9_NUMOS,	AB9_TIPO
		
		FROM %table:AB9% AB9
		WHERE	AB9_FILIAL = %xfilial:AB9%		AND
				AB9_NUMOS >= %exp:mv_par01%		AND  
				AB9_NUMOS <= %exp:mv_par02+"zz"%		AND
				AB9_DTINI >= %exp:DtoS(mv_par03)%		AND
				AB9_DTINI <= %exp:DtoS(mv_par04)%		AND
				AB9_CODCLI >= %exp:mv_par05%	AND
				AB9_CODCLI <= %exp:mv_par06%	AND
				AB9_CODTEC >= %exp:mv_par07%	AND
				AB9_CODTEC <= %exp:mv_par08%	AND
				AB9_CODPRO >= %exp:mv_par09%	AND
				AB9_CODPRO <= %exp:mv_par10%	AND	
				AB9.%notDel%

		ORDER BY %exp:cOrderBy%
	EndSql
	
	END REPORT QUERY oSection1

#ELSE

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Utilizar a funcao MakeAdvlExpr, somente quando for utilizar o range de parametros³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeAdvplExpr("ATR480")

	DbSelectArea( cAlias1 ) 
	DbSetOrder(1)
    
	cFiltro := "AB9_FILIAL=='"+xFilial("AB9")+"'.AND."
	cFiltro += "AB9_NUMOS>='"+MV_PAR01+"'.AND."
	cFiltro += "AB9_NUMOS<='"+MV_PAR02+"zz'.AND."
	cFiltro += "DTOS(AB9_DTINI)>='"+DTOS(MV_PAR03)+"'.AND."
	cFiltro += "DTOS(AB9_DTINI)<='"+DTOS(MV_PAR04)+"'.AND."
	cFiltro += "AB9_CODCLI>='"+MV_PAR05+"'.AND."
	cFiltro += "AB9_CODCLI<='"+MV_PAR06+"'.AND."
	cFiltro += "AB9_CODTEC>='"+MV_PAR07+"'.AND."
	cFiltro += "AB9_CODTEC<='"+MV_PAR08+"'"
	cFiltro += ".AND. AB9_CODPRO>='"+MV_PAR09+"'.AND. "
	cFiltro += "AB9_CODPRO<='"+MV_PAR10+"'"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Efetua o filtro de acordo com a expressao do arquivo AB9 (Atendimento da OS)						 ³
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

If !isBlind()
	oSection1:Init()
	oSection2:Init()
EndIf

If MV_PAR12 == 2
	oSection2:lHeaderPage:= .F.
EndIf

While !oReport:Cancel() .AND. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf

	If ( 	(cAlias1)->AB9_CODPRO >= MV_PAR09 .AND.;
			(cAlias1)->AB9_CODPRO <= MV_PAR10 .AND.;
			If(MV_PAR11==1, (cAlias1)->AB9_TIPO=="1", .T.) .AND.;
			If(MV_PAR11==2, (cAlias1)->AB9_TIPO!="1", .T.) )
	
		Do Case
			Case ( nOrdem == 2 )
				cQuebra := (cAlias1)->AB9_CODTEC
			Case ( nOrdem == 3 )
				cQuebra := (cAlias1)->AB9_CODCLI
			Case ( nOrdem == 4 )
				cQuebra := (cAlias1)->AB9_CODPRB
		EndCase
		
		dbSelectArea("AB7")
		dbSetOrder(1)
		MsSeek(xFilial("AB7")+(cAlias1)->AB9_NUMOS)
		
		dbSelectArea("AB6")
		dbSetOrder(1)
		MsSeek(xFilial("AB6")+AB7->AB7_NUMOS)
		
		dbSelectArea("AAG")
		dbSetOrder(1)
		MsSeek(xFilial("AAG")+(cAlias1)->AB9_CODPRB)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula as horas e atualiza o valor das celulas ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nHrTotal1 := SubtHoras(dDataBase,"00:00",dDataBase,(cAlias1)->AB9_TRASLA)
		nHrTotal2 := SubtHoras((cAlias1)->AB9_DTCHEG,(cAlias1)->AB9_HRCHEG,(cAlias1)->AB9_DTSAID,(cAlias1)->AB9_HRSAID)
		nHrTotal3 := SubtHoras((cAlias1)->AB9_DTINI,(cAlias1)->AB9_HRINI,(cAlias1)->AB9_DTFIM,(cAlias1)->AB9_HRFIM)
		
		If mv_par13 == 1
			oSection1:Cell("nHrTotal2"):SetValue(Transform(nHrTotal2,TM(nHrTotal2,8)))
		Else                                   
			cHoraForm := LimpaZeros(IntToHora(nHrTotal2,6))
			oSection1:Cell("nHrTotal2"):SetValue(cHoraForm)	
		EndIf

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime a secao 1 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !isBlind()
       		oSection1:PrintLine()
		EndIf

		If MV_PAR12 == 1
			dbSelectArea("ABA")
			ABA->(dbSetOrder(1))
			ABA->(MsSeek(xFilial("ABA")+(cAlias1)->AB9_NUMOS+(cAlias1)->AB9_CODTEC+(cAlias1)->AB9_SEQ))
			While (ABA->(!Eof()) .AND.;
							(cAlias1)->AB9_NUMOS == ABA->ABA_NUMOS .AND.;
							(cAlias1)->AB9_CODTEC == ABA->ABA_CODTEC .AND.;
							(cAlias1)->AB9_SEQ == ABA->ABA_SEQ)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Imprime a secao 2 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !isBlind()
					oSection2:PrintLine()
				EndIf
				ABA->(DbSkip())
			EndDo
		EndIf
		
		lImp 	:= .T.
		lImpAb9 := .T.
		           
		aTotal[1] += nHrTotal1
		aTotal[2] += nHrTotal1
		aTotal[3] += nHrTotal2
		aTotal[4] += nHrTotal2
		aTotal[5] += nHrTotal3
		aTotal[6] += nHrTotal3
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Incrementa o total por ocorrencia ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Empty( nPosOcor := AScan( aTotOcor, { |x| x[1] == AAG->AAG_CODPRB } ) ) 
			AAdd( aTotOcor, { AAG->AAG_CODPRB, AAG->AAG_DESCRI, nHrTotal1, nHrTotal2, nHrTotal3 } )
		Else
			aTotOcor[ nPosOcor, 3 ] += nHrTotal1
			aTotOcor[ nPosOcor, 4 ] += nHrTotal2
			aTotOcor[ nPosOcor, 5 ] += nHrTotal3		
		EndIf 		
		
	EndIf	
	dbSelectArea(cAlias1)
	dbSkip()
	    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime os Totais por Quebra ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case ( nOrdem == 2 )
			If ( cQuebra != (cAlias1)->AB9_CODTEC .AND. lImpAb9 )

				dbSelectArea("AA1")
				dbSetOrder(1)
				MsSeek(xFilial("AA1")+cQuebra)
				
				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0018+cQuebra+" "+AA1->AA1_NOMTEC, nLin  ) //"TOTAL DO TECNICO: "
				
				If mv_par13 == 1
					oReport:PrintText( Transform(aTotal[1], TM(aTotal[1],5)), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					oReport:PrintText( Transform(aTotal[3], TM(aTotal[3],8)), nLin, oSection1:Cell("nHrTotal2"):ColPos() )				
				Else  
					oReport:PrintText( InttoHora(aTotal[1],2), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					cHoraForm := LimpaZeros(IntToHora(aTotal[3],6))
					oReport:PrintText(cHoraForm, nLin, oSection1:Cell("nHrTotal2"):ColPos() )				
				EndIf	
					
				If mv_par13 == 1
					oReport:PrintText( STR0019 + " " + Transform(aTotal[5], TM(aTotal[5],8)), nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
				Else
				   cHoraForm := LimpaZeros(IntToHora(aTotal[5],6))
				   oReport:PrintText( STR0019 + " " + cHoraForm, nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"	
				EndIf
				oReport:SkipLine()
				oReport:SkipLine()
				
				aTotal[1] := 0
				aTotal[3] := 0
				aTotal[5] := 0
				lImpAb9 	:= .F.
			EndIf
		Case ( nOrdem == 3 )
			If ( cQuebra != (cAlias1)->AB9_CODCLI .AND. lImpAb9)

				dbSelectArea("SA1")
				dbSetOrder(1)
				MsSeek(xFilial("SA1")+cQuebra)
				
				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0020+cQuebra+" "+SA1->A1_NOME, nLin  ) //"TOTAL DO CLIENTE: "
								
				If mv_par13 == 1
					oReport:PrintText( Transform(aTotal[1], TM(aTotal[1],5)), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					oReport:PrintText( Transform(aTotal[3], TM(aTotal[3],8)), nLin, oSection1:Cell("nHrTotal2"):ColPos() )				
				Else
					oReport:PrintText( InttoHora(aTotal[1],2), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					cHoraForm := LimpaZeros(IntToHora(aTotal[3],6))
					oReport:PrintText(cHoraForm, nLin, oSection1:Cell("nHrTotal2"):ColPos() )
				EndIf	                                  
                
				If mv_par13 == 1				
					oReport:PrintText( STR0021 + " " + Transform(aTotal[5], TM(aTotal[5],8)), nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
				Else  
				   cHoraForm := LimpaZeros(IntToHora(aTotal[5],6))
				   oReport:PrintText( STR0021 + " " + cHoraForm, nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"	
				EndIf
				oReport:SkipLine()
				oReport:SkipLine()
				
				aTotal[1] := 0
				aTotal[3] := 0
				aTotal[5] := 0
				lImpAb9 	:= .F.
			EndIf
		Case ( nOrdem == 4 )
			If ( cQuebra != (cAlias1)->AB9_CODPRB .AND. lImpAb9)
				dbSelectArea("AAG")
				dbSetOrder(1)
				MsSeek(xFilial("AAG")+cQuebra)

				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0022+cQuebra+" "+AAG->AAG_DESCRI, nLin  ) //"TOTAL DA OCORRENCIA/PROBLEMA: "
				
				If mv_par13 == 1
					oReport:PrintText( Transform(aTotal[1], TM(aTotal[1],5)), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					oReport:PrintText( Transform(aTotal[3], TM(aTotal[3],8)), nLin, oSection1:Cell("nHrTotal2"):ColPos() )				
				Else
					oReport:PrintText( InttoHora(aTotal[1],2), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
					cHoraForm := LimpaZeros(IntToHora(aTotal[3],6))
					oReport:PrintText(cHoraForm, nLin, oSection1:Cell("nHrTotal2"):ColPos() )
				EndIf	        

				If mv_par13 == 1
					oReport:PrintText( STR0023 + " " + Transform(aTotal[5], TM(aTotal[5],8)), nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
				Else
					cHoraForm := LimpaZeros(IntToHora(aTotal[5],6))
					oReport:PrintText( STR0023 + " " + cHoraForm, nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
				EndIf										
				oReport:SkipLine()
				oReport:SkipLine()
				
				aTotal[1] := 0
				aTotal[3] := 0
				aTotal[5] := 0
				lImpAb9 	:= .F.
			EndIf
	EndCase
	dbSelectArea(cAlias1)
End
oSection2:Finish()
oSection1:Finish()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o Total Geral e Total por Ocorrencia ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lImp )
	oReport:SkipLine()
	oReport:ThinLine()
	nLin := oReport:Row()
	oReport:PrintText( STR0024, nLin  ) //"TOTAL GERAL"

	If mv_par13 == 1
		If !isBlind()
			oReport:PrintText( Transform(aTotal[2], TM(aTotal[2],5)), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
			oReport:PrintText( Transform(aTotal[4], TM(aTotal[4],8)), nLin, oSection1:Cell("nHrTotal2"):ColPos() )
		EndIf			
	Else
		oReport:PrintText( InttoHora(aTotal[2],2), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )   
        cHoraForm := LimpaZeros(IntToHora(aTotal[4],6))
		oReport:PrintText( cHoraForm, nLin, oSection1:Cell("nHrTotal2"):ColPos() )  	
	EndIf	        

	If mv_par13 == 1
		If !isBlind()
			oReport:PrintText( STR0025+" "+Transform(aTotal[6], TM(aTotal[6],8)), nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
		EndIf	
	Else
		cHoraForm := LimpaZeros(IntToHora(aTotal[6],6))
		oReport:PrintText( STR0025+" "+ cHoraForm, nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
	EndIf							
				
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lista os totais por ocorrencia ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText( STR0028 ) //"TOTAL POR OCORRENCIA"
	oReport:SkipLine()
		
	ASort( aTotOcor, , , { |x,y| y[1] > x[1] } ) 
	
	For nLoop := 1 to Len( aTotOcor ) 	
		                   
		nLin := oReport:Row()
		If !isBlind()        
			oReport:PrintText( aTotOcor[nLoop,1] + "-" + Left(aTotOcor[nLoop,2], 30), nLin, oSection1:Cell("AB9_DTFIM"):ColPos() )
       EndIf
		If mv_par13 == 1
			If !isBlind()
				oReport:PrintText( Transform(aTotOcor[nLoop,3], TM(aTotOcor[nLoop,3], 5)), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )	
				oReport:PrintText( Transform(aTotOcor[nLoop,4], TM(aTotOcor[nLoop,4], 8)), nLin, oSection1:Cell("nHrTotal2"):ColPos() )
			EndIf	
		Else
			oReport:PrintText( IntToHora(aTotOcor[nLoop,3],2), nLin, oSection1:Cell("AB9_TRASLA"):ColPos() )
			cHoraForm := LimpaZeros(IntToHora(aTotOcor[nLoop,4],6))
			oReport:PrintText( cHoraForm, nLin, oSection1:Cell("nHrTotal2"):ColPos() )
		EndIf	        
	
		If mv_par13 == 1
			If !isBlind()			
				oReport:PrintText( STR0025 + " " + Transform(aTotOcor[nLoop,5], TM(aTotOcor[nLoop,5],8)), nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"
			EndIf
		Else  
			cHoraForm := (LimpaZeros(IntToHora(aTotOcor[nLoop,5],6)))
			oReport:PrintText( STR0025 + " " + cHoraForm, nLin, oSection1:Cell("AB9_CODPRB"):ColPos() )	//"HORAS UTEIS"	
		EndIf
	
        oReport:SkipLine()
	
	Next nLoop
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LimpaZerosºAutor  ³Vendas/CRM          º Data ³  07/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Formata a hora retirando zeros a esquerda                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function LimpaZeros(cValor)
Local aVetor := {}
Local cHoraFormatada := ''
aVetor:= strtokarr(cValor,':')
cHoraFormatada := cValToChar(val(aVetor[1]))+ ":" + cValToChar(aVetor[2])
Return (cHoraFormatada)   

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

Return Tcr480RptDef()

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

Return Tcr480PrtRpt( oReport , {STR0005,STR0006,STR0007,STR0008} , GetNextAlias())

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
